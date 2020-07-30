/*P:900
 * This is the Switcher: code which sits at 0xFFC00000 (or 0xFFE00000) astride
 * both the Host and Guest to do the low-level Guest<->Host switch.  It is as
 * simple as it can be made, but it's naturally very specific to x86.
 *
 * You have now completed Preparation.  If this has whet your appetite; if you
 * are feeling invigorated and refreshed then the next, more challenging stage
 * can be found in "make Guest".
 :*/

/*M:012
 * Lguest is meant to be simple: my rule of thumb is that 1% more LOC must
 * gain at least 1% more performance.  Since neither LOC nor performance can be
 * measured beforehand, it generally means implementing a feature then deciding
 * if it's worth it.  And once it's implemented, who can say no?
 *
 * This is why I haven't implemented this idea myself.  I want to, but I
 * haven't.  You could, though.
 *
 * The main place where lguest performance sucks is Guest page faulting.  When
 * a Guest userspace process hits an unmapped page we switch back to the Host,
 * walk the page tables, find it's not mapped, switch back to the Guest page
 * fault handler, which calls a hypercall to set the page table entry, then
 * finally returns to userspace.  That's two round-trips.
 *
 * If we had a small walker in the Switcher, we could quickly check the Guest
 * page table and if the page isn't mapped, immediately reflect the fault back
 * into the Guest.  This means the Switcher would have to know the top of the
 * Guest page table and the page fault handler address.
 *
 * For simplicity, the Guest should only handle the case where the privilege
 * level of the fault is 3 and probably only not present or write faults.  It
 * should also detect recursive faults, and hand the original fault to the
 * Host (which is actually really easy).
 *
 * Two questions remain.  Would the performance gain outweigh the complexity?
 * And who would write the verse documenting it?
:*/

/*M:011
 * Lguest64 handles NMI.  This gave me NMI envy (until I looked at their
 * code).  It's worth doing though, since it would let us use oprofile in the
 * Host when a Guest is running.
:*/

/*S:100
 * Welcome to the Switcher itself!
 *
 * This file contains the low-level code which changes the CPU to run the Guest
 * code, and returns to the Host when something happens.  Understand this, and
 * you understand the heart of our journey.
 *
 * Because this is in assembler rather than C, our tale switches from prose to
 * verse.  First I tried limericks:
 *
 *	There once was an eax reg,
 *	To which our pointer was fed,
 *	It needed an add,
 *	Which asm-offsets.h had
 *	But this limerick is hurting my head.
 *
 * Next I tried haikus, but fitting the required reference to the seasons in
 * every stanza was quickly becoming tiresome:
 *
 *	The %eax reg
 *	Holds "struct lguest_pages" now:
 *	Cherry blossoms fall.
 *
 * Then I started with Heroic Verse, but the rhyming requirement leeched away
 * the content density and led to some uniquely awful oblique rhymes:
 *
 *	These constants are coming from struct offsets
 *	For use within the asm switcher text.
 *
 * Finally, I settled for something between heroic hexameter, and normal prose
 * with inappropriate linebreaks.  Anyway, it aint no Shakespeare.
 */

#include <linux/linkage.h>
#include <asm/asm-offsets.h>
#include <asm/page.h>
#include <asm/segment.h>
#include <asm/lguest.h>

.text
ENTRY(start_switcher_text)

ENTRY(switch_to_guest)







	pushl	%es
	pushl	%ds
	pushl	%gs
	pushl	%fs




	pushl	%ebp



	movl	%esp, LGUEST_PAGES_host_sp(%eax)









	movl	%eax, %edx
	addl	$LGUEST_PAGES_regs, %edx
	movl	%edx, %esp



	lgdt	LGUEST_PAGES_guest_gdt_desc(%eax)



	lidt	LGUEST_PAGES_guest_idt_desc(%eax)







	movl	$(GDT_ENTRY_TSS*8), %edx
	ltr	%dx






	movl	(LGUEST_PAGES_host_gdt_desc+2)(%eax), %edx

	andb	$0xFD, (GDT_ENTRY_TSS*8 + 5)(%edx)




	movl	%ebx, %cr3





	popl	%eax
	popl	%ebx
	popl	%ecx
	popl	%edx
	popl	%esi
	popl	%edi
	popl	%ebp
	popl	%gs
	popl	%fs
	popl	%ds
	popl	%es





	addl	$8, %esp






	iret

#define SWITCH_TO_HOST							\
	/* We save the Guest state: all registers first			\
	 * Laid out just as "struct lguest_regs" defines */		\
	pushl	%es;							\
	pushl	%ds;							\
	pushl	%fs;							\
	pushl	%gs;							\
	pushl	%ebp;							\
	pushl	%edi;							\
	pushl	%esi;							\
	pushl	%edx;							\
	pushl	%ecx;							\
	pushl	%ebx;							\
	pushl	%eax;							\
	/* Our stack and our code are using segments			\
	 * Set in the TSS and IDT					\
	 * Yet if we were to touch data we'd use			\
	 * Whatever data segment the Guest had.				\
	 * Load the lguest ds segment for now. */			\
	movl	$(LGUEST_DS), %eax;					\
	movl	%eax, %ds;						\
	/* So where are we?  Which CPU, which struct?			\
	 * The stack is our clue: our TSS starts			\
	 * It at the end of "struct lguest_pages".			\
	 * Or we may have stumbled while restoring			\
	 * Our Guest segment regs while in switch_to_guest,		\
	 * The fault pushed atop that part-unwound stack.		\
	 * If we round the stack down to the page start			\
	 * We're at the start of "struct lguest_pages". */		\
	movl	%esp, %eax;						\
	andl	$(~(1 << PAGE_SHIFT - 1)), %eax;			\
	/* Save our trap number: the switch will obscure it		\
	 * (In the Host the Guest regs are not mapped here)		\
	 * %ebx holds it safe for deliver_to_host */			\
	movl	LGUEST_PAGES_regs_trapnum(%eax), %ebx;			\
	/* The Host GDT, IDT and stack!					\
	 * All these lie safely hidden from the Guest:			\
	 * We must return to the Host page tables			\
	 * (Hence that was saved in struct lguest_pages) */		\
	movl	LGUEST_PAGES_host_cr3(%eax), %edx;			\
	movl	%edx, %cr3;						\
	/* As before, when we looked back at the Host			\
	 * As we left and marked TSS unused				\
	 * So must we now for the Guest left behind. */			\
	andb	$0xFD, (LGUEST_PAGES_guest_gdt+GDT_ENTRY_TSS*8+5)(%eax); \
	/* Switch to Host's GDT, IDT. */				\
	lgdt	LGUEST_PAGES_host_gdt_desc(%eax);			\
	lidt	LGUEST_PAGES_host_idt_desc(%eax);			\
	/* Restore the Host's stack where its saved regs lie */		\
	movl	LGUEST_PAGES_host_sp(%eax), %esp;			\
	/* Last the TSS: our Host is returned */			\
	movl	$(GDT_ENTRY_TSS*8), %edx;				\
	ltr	%dx;							\
	/* Restore now the regs saved right at the first. */		\
	popl	%ebp;							\
	popl	%fs;							\
	popl	%gs;							\
	popl	%ds;							\
	popl	%es

return_to_host:
	SWITCH_TO_HOST
	iret

deliver_to_host:
	SWITCH_TO_HOST













	movl	(LGUEST_PAGES_host_idt_desc+2)(%eax), %edx








	leal	(%edx,%ebx,8), %eax
	movzwl	(%eax),%edx
	movl	4(%eax), %eax
	xorw	%ax, %ax
	orl	%eax, %edx


	jmp	*%edx




.macro IRQ_STUB N TARGET
	.data; .long 1f; .text; 1:
 // Trap eight, ten through fourteen and seventeen
 // Supply an error number.  Else zero.
 .if (\N <> 8) && (\N < 10 || \N > 14) && (\N <> 17)
	pushl	$0
 .endif
	pushl	$\N
	jmp	\TARGET
	ALIGN
.endm

.macro IRQ_STUBS FIRST LAST TARGET
 irq=\FIRST
 .rept \LAST-\FIRST+1
	IRQ_STUB irq \TARGET
  irq=irq+1
 .endr
.endm

.data
.global default_idt_entries
default_idt_entries:
.text

	IRQ_STUBS 0 1 return_to_host

	IRQ_STUB 2 handle_nmi

	IRQ_STUBS 3 31 return_to_host

	IRQ_STUBS 32 127 deliver_to_host


	IRQ_STUB 128 return_to_host
	IRQ_STUBS 129 255 deliver_to_host

handle_nmi:
	addl	$8, %esp
	iret


ENTRY(end_switcher_text)
