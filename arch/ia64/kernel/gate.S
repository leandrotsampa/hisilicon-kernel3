/*
 * This file contains the code that gets mapped at the upper end of each task's text
 * region.  For now, it contains the signal trampoline code only.
 *
 * Copyright (C) 1999-2003 Hewlett-Packard Co
 * 	David Mosberger-Tang <davidm@hpl.hp.com>
 */


#include <asm/asmmacro.h>
#include <asm/errno.h>
#include <asm/asm-offsets.h>
#include <asm/sigcontext.h>
#include <asm/unistd.h>
#include <asm/kregs.h>
#include <asm/page.h>
#include "paravirt_inst.h"

/*
 * We can't easily refer to symbols inside the kernel.  To avoid full runtime relocation,
 * complications with the linker (which likes to create PLT stubs for branches
 * to targets outside the shared object) and to avoid multi-phase kernel builds, we
 * simply create minimalistic "patch lists" in special ELF sections.
 */
	.section ".data..patch.fsyscall_table", "a"
	.previous
#define LOAD_FSYSCALL_TABLE(reg)			\
[1:]	movl reg=0;					\
	.xdata4 ".data..patch.fsyscall_table", 1b-.

	.section ".data..patch.brl_fsys_bubble_down", "a"
	.previous
#define BRL_COND_FSYS_BUBBLE_DOWN(pr)			\
[1:](pr)brl.cond.sptk 0;				\
	;;						\
	.xdata4 ".data..patch.brl_fsys_bubble_down", 1b-.

GLOBAL_ENTRY(__kernel_syscall_via_break)
	.prologue
	.altrp b6
	.body
	/*
	 * Note: for (fast) syscall restart to work, the break instruction must be
	 *	 the first one in the bundle addressed by syscall_via_break.
	 */
{ .mib
	break 0x100000
	nop.i 0
	br.ret.sptk.many b6
}
END(__kernel_syscall_via_break)

#	define ARG0_OFF		(16 + IA64_SIGFRAME_ARG0_OFFSET)
#	define ARG1_OFF		(16 + IA64_SIGFRAME_ARG1_OFFSET)
#	define ARG2_OFF		(16 + IA64_SIGFRAME_ARG2_OFFSET)
#	define SIGHANDLER_OFF	(16 + IA64_SIGFRAME_HANDLER_OFFSET)
#	define SIGCONTEXT_OFF	(16 + IA64_SIGFRAME_SIGCONTEXT_OFFSET)

#	define FLAGS_OFF	IA64_SIGCONTEXT_FLAGS_OFFSET
#	define CFM_OFF		IA64_SIGCONTEXT_CFM_OFFSET
#	define FR6_OFF		IA64_SIGCONTEXT_FR6_OFFSET
#	define BSP_OFF		IA64_SIGCONTEXT_AR_BSP_OFFSET
#	define RNAT_OFF		IA64_SIGCONTEXT_AR_RNAT_OFFSET
#	define UNAT_OFF		IA64_SIGCONTEXT_AR_UNAT_OFFSET
#	define FPSR_OFF		IA64_SIGCONTEXT_AR_FPSR_OFFSET
#	define PR_OFF		IA64_SIGCONTEXT_PR_OFFSET
#	define RP_OFF		IA64_SIGCONTEXT_IP_OFFSET
#	define SP_OFF		IA64_SIGCONTEXT_R12_OFFSET
#	define RBS_BASE_OFF	IA64_SIGCONTEXT_RBS_BASE_OFFSET
#	define LOADRS_OFF	IA64_SIGCONTEXT_LOADRS_OFFSET
#	define base0		r2
#	define base1		r3
	/*
	 * When we get here, the memory stack looks like this:
	 *
	 *   +===============================+
       	 *   |				     |
       	 *   //	    struct sigframe          //
       	 *   |				     |
	 *   +-------------------------------+ <-- sp+16
	 *   |      16 byte of scratch       |
	 *   |            space              |
	 *   +-------------------------------+ <-- sp
	 *
	 * The register stack looks _exactly_ the way it looked at the time the signal
	 * occurred.  In other words, we're treading on a potential mine-field: each
	 * incoming general register may be a NaT value (including sp, in which case the
	 * process ends up dying with a SIGSEGV).
	 *
	 * The first thing need to do is a cover to get the registers onto the backing
	 * store.  Once that is done, we invoke the signal handler which may modify some
	 * of the machine state.  After returning from the signal handler, we return
	 * control to the previous context by executing a sigreturn system call.  A signal
	 * handler may call the rt_sigreturn() function to directly return to a given
	 * sigcontext.  However, the user-level sigreturn() needs to do much more than
	 * calling the rt_sigreturn() system call as it needs to unwind the stack to
	 * restore preserved registers that may have been saved on the signal handler's
	 * call stack.
	 */

#define SIGTRAMP_SAVES										\
	.unwabi 3, 's';		/* mark this as a sigtramp handler (saves scratch regs) */	\
	.unwabi @svr4, 's'; /* backwards compatibility with old unwinders (remove in v2.7) */	\
	.savesp ar.unat, UNAT_OFF+SIGCONTEXT_OFF;						\
	.savesp ar.fpsr, FPSR_OFF+SIGCONTEXT_OFF;						\
	.savesp pr, PR_OFF+SIGCONTEXT_OFF;     							\
	.savesp rp, RP_OFF+SIGCONTEXT_OFF;							\
	.savesp ar.pfs, CFM_OFF+SIGCONTEXT_OFF;							\
	.vframesp SP_OFF+SIGCONTEXT_OFF

GLOBAL_ENTRY(__kernel_sigtramp)

	.prologue
	SIGTRAMP_SAVES
	.body

	.label_state 1

	adds base0=SIGHANDLER_OFF,sp
	adds base1=RBS_BASE_OFF+SIGCONTEXT_OFF,sp
	br.call.sptk.many rp=1f
1:
	ld8 r17=[base0],(ARG0_OFF-SIGHANDLER_OFF)
	ld8 r15=[base1]				
	cover			
	;;
	cmp.ne p1,p0=r15,r0	
	mov.m r9=ar.bsp		
	.spillsp.p p1, ar.rnat, RNAT_OFF+SIGCONTEXT_OFF
(p1)	br.cond.spnt setup_rbs	
back_from_setup_rbs:
	alloc r8=ar.pfs,0,0,3,0
	ld8 out0=[base0],16	
	adds base1=(ARG1_OFF-(RBS_BASE_OFF+SIGCONTEXT_OFF)),base1
	;;
	ld8 out1=[base1]	
	ld8 r10=[r17],8		
	;;
	ld8 out2=[base0]	
	ld8 gp=[r17]		
	adds base0=(BSP_OFF+SIGCONTEXT_OFF),sp
	;;
	.spillsp ar.bsp, BSP_OFF+SIGCONTEXT_OFF
	st8 [base0]=r9		
	adds base0=(FR6_OFF+SIGCONTEXT_OFF),sp
	adds base1=(FR6_OFF+16+SIGCONTEXT_OFF),sp
	;;
	stf.spill [base0]=f6,32
	stf.spill [base1]=f7,32
	;;
	stf.spill [base0]=f8,32
	stf.spill [base1]=f9,32
	mov b6=r10
	;;
	stf.spill [base0]=f10,32
	stf.spill [base1]=f11,32
	;;
	stf.spill [base0]=f12,32
	stf.spill [base1]=f13,32
	;;
	stf.spill [base0]=f14,32
	stf.spill [base1]=f15,32
	br.call.sptk.many rp=b6		
.ret0:	adds base0=(BSP_OFF+SIGCONTEXT_OFF),sp
	;;
	ld8 r15=[base0]			
	mov r14=ar.bsp
	;;
	cmp.ne p1,p0=r14,r15		
(p1)	br.cond.spnt restore_rbs	
	;;
back_from_restore_rbs:
	adds base0=(FR6_OFF+SIGCONTEXT_OFF),sp
	adds base1=(FR6_OFF+16+SIGCONTEXT_OFF),sp
	;;
	ldf.fill f6=[base0],32
	ldf.fill f7=[base1],32
	;;
	ldf.fill f8=[base0],32
	ldf.fill f9=[base1],32
	;;
	ldf.fill f10=[base0],32
	ldf.fill f11=[base1],32
	;;
	ldf.fill f12=[base0],32
	ldf.fill f13=[base1],32
	;;
	ldf.fill f14=[base0],32
	ldf.fill f15=[base1],32
	mov r15=__NR_rt_sigreturn
	.restore sp			
	break __BREAK_SYSCALL

	.prologue
	SIGTRAMP_SAVES
setup_rbs:
	mov ar.rsc=0			
	;;
	.save ar.rnat, r19
	mov r19=ar.rnat			
	adds r14=(RNAT_OFF+SIGCONTEXT_OFF),sp

	mov r18=ar.bspstore
	mov ar.bspstore=r15		
	;;

	.spillsp ar.rnat, RNAT_OFF+SIGCONTEXT_OFF
	st8 [r14]=r19			
	.body
	mov.m r16=ar.bsp		
	adds r14=(LOADRS_OFF+SIGCONTEXT_OFF),sp
	;;
	invala
	sub r15=r16,r15
	extr.u r20=r18,3,6
	;;
	mov ar.rsc=0xf			
	cmp.eq p8,p0=63,r20
	shl r15=r15,16
	;;
	st8 [r14]=r15			
(p8)	st8 [r18]=r19	
	.restore sp			
	br.cond.sptk back_from_setup_rbs

	.prologue
	SIGTRAMP_SAVES
	.spillsp ar.rnat, RNAT_OFF+SIGCONTEXT_OFF
	.body
restore_rbs:













	alloc r2=ar.pfs,0,0,0,0		
	adds r16=(LOADRS_OFF+SIGCONTEXT_OFF),sp
	adds r18=(RNAT_OFF+SIGCONTEXT_OFF),sp
	;;
	ld8 r17=[r16]
	ld8 r16=[r18]		
	extr.u r18=r15,3,6
	;;
	mov ar.rsc=r17		
	shr.u r17=r17,16
	;;
	sub r14=r14,r17	
	shr.u r17=r17,3	
	;;
	loadrs		
	extr.u r14=r14,3,6
	;;
	add r14=r14,r17	
	;;
	shr.u r14=r14,6	
	;;
	sub r14=r14,r17	
	movl r17=0x8208208208208209
	;;
	add r18=r18,r14	
	setf.sig f7=r17
	cmp.lt p7,p0=r14,r0
	;;
(p7)	adds r18=-62,r18
	;;
	setf.sig f6=r18
	;;
	xmpy.h f6=f6,f7
	;;
	getf.sig r17=f6
	;;
	add r17=r17,r18
	shr r18=r18,63
	;;
	shr r17=r17,5
	;;
	sub r17=r17,r18	
	;;
	add r17=r14,r17	
	;;
	shladd r15=r17,3,r15
	;;
	mov ar.bspstore=r15		
	;;
	mov ar.rnat=r16			
	mov ar.rsc=0xf			

	br.cond.sptk back_from_restore_rbs
END(__kernel_sigtramp)

/*
 * On entry:
 *	r11 = saved ar.pfs
 *	r15 = system call #
 *	b0  = saved return address
 *	b6  = return address
 * On exit:
 *	r11 = saved ar.pfs
 *	r15 = system call #
 *	b0  = saved return address
 *	all other "scratch" registers:	undefined
 *	all "preserved" registers:	same as on entry
 */

GLOBAL_ENTRY(__kernel_syscall_via_epc)
	.prologue
	.altrp b6
	.body
{
	/*
	 * Note: the kernel cannot assume that the first two instructions in this
	 * bundle get executed.  The remaining code must be safe even if
	 * they do not get executed.
	 */
	adds r17=-1024,r15		
	mov r10=0			
	epc				
}
	;;
	RSM_PSR_BE_I(r20, r22)		
	LOAD_FSYSCALL_TABLE(r14)	
	;;
	mov r16=IA64_KR(CURRENT)	
	shladd r18=r17,3,r14		
	mov r19=NR_syscalls-1		
	;;
	lfetch [r18]			
	MOV_FROM_PSR(p0, r29, r8)	

	cmp.geu p6,p7=r19,r17		
	;;
	mov r21=ar.fpsr			
	tnat.nz p10,p9=r15		
	mov.i r26=ar.pfs		
	;;
	srlz.d				
(p6)	ld8 r18=[r18]			
	nop.i 0
	;;
	nop.m 0
(p6)	tbit.z.unc p8,p0=r18,0		
	nop.i 0
	;;
	SSM_PSR_I(p8, p14, r25)
(p6)	mov b7=r18			
(p8)	br.dptk.many b7			

	mov r27=ar.rsc			
/*
 * brl.cond doesn't work as intended because the linker would convert this branch
 * into a branch to a PLT.  Perhaps there will be a way to avoid this with some
 * future version of the linker.  In the meantime, we just use an indirect branch
 * instead.
 */
#ifdef CONFIG_ITANIUM
(p6)	add r14=-8,r14			
	;;
(p6)	ld8 r14=[r14]			
	;;
(p6)	mov b7=r14
(p6)	br.sptk.many b7
#else
	BRL_COND_FSYS_BUBBLE_DOWN(p6)
#endif
	SSM_PSR_I(p0, p14, r10)
	mov r10=-1
(p10)	mov r8=EINVAL
(p9)	mov r8=ENOSYS
	FSYS_RETURN

#ifdef CONFIG_PARAVIRT
	/*
	 * padd to make the size of this symbol constant
	 * independent of paravirtualization.
	 */
	.align PAGE_SIZE / 8
#endif
END(__kernel_syscall_via_epc)
