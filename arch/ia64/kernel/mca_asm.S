/*
 * File:	mca_asm.S
 * Purpose:	assembly portion of the IA64 MCA handling
 *
 * Mods by cfleck to integrate into kernel build
 *
 * 2000-03-15 David Mosberger-Tang <davidm@hpl.hp.com>
 *		Added various stop bits to get a clean compile
 *
 * 2000-03-29 Chuck Fleckenstein <cfleck@co.intel.com>
 *		Added code to save INIT handoff state in pt_regs format,
 *		switch to temp kstack, switch modes, jump to C INIT handler
 *
 * 2002-01-04 J.Hall <jenna.s.hall@intel.com>
 *		Before entering virtual mode code:
 *		 1. Check for TLB CPU error
 *		 2. Restore current thread pointer to kr6
 *		 3. Move stack ptr 16 bytes to conform to C calling convention
 *
 * 2004-11-12 Russ Anderson <rja@sgi.com>
 *		Added per cpu MCA/INIT stack save areas.
 *
 * 2005-12-08 Keith Owens <kaos@sgi.com>
 *		Use per cpu MCA/INIT stacks for all data.
 */
#include <linux/threads.h>

#include <asm/asmmacro.h>
#include <asm/pgtable.h>
#include <asm/processor.h>
#include <asm/mca_asm.h>
#include <asm/mca.h>

#include "entry.h"

#define GET_IA64_MCA_DATA(reg)						\
	GET_THIS_PADDR(reg, ia64_mca_data)				\
	;;								\
	ld8 reg=[reg]

	.global ia64_do_tlb_purge
	.global ia64_os_mca_dispatch
	.global ia64_os_init_on_kdump
	.global ia64_os_init_dispatch_monarch
	.global ia64_os_init_dispatch_slave

	.text
	.align 16


/*
 * Just the TLB purge part is moved to a separate function
 * so we can re-use the code for cpu hotplug code as well
 * Caller should now setup b1, so we can branch once the
 * tlb flush is complete.
 */

ia64_do_tlb_purge:
#define O(member)	IA64_CPUINFO_##member##_OFFSET

	GET_THIS_PADDR(r2, ia64_cpu_info) // load phys addr of cpu_info into r2
	;;
	addl r17=O(PTCE_STRIDE),r2
	addl r2=O(PTCE_BASE),r2
	;;
	ld8 r18=[r2],(O(PTCE_COUNT)-O(PTCE_BASE));;
	ld4 r19=[r2],4				
	ld4 r21=[r17],4				
	;;
	ld4 r20=[r2]				
	ld4 r22=[r17]				
	mov r24=0
	;;
	adds r20=-1,r20
	;;
#undef O

2:
	cmp.ltu p6,p7=r24,r19
(p7)	br.cond.dpnt.few 4f
	mov ar.lc=r20
3:
	ptc.e r18
	;;
	add r18=r22,r18
	br.cloop.sptk.few 3b
	;;
	add r18=r21,r18
	add r24=1,r24
	;;
	br.sptk.few 2b
4:
	srlz.i 		
	;;

        // Now purge addresses formerly mapped by TR registers

	movl r16=KERNEL_START
	mov r18=KERNEL_TR_PAGE_SHIFT<<2
	;;
	ptr.i r16, r18
	ptr.d r16, r18
	;;
	srlz.i
	;;
	srlz.d
	;;

	GET_THIS_PADDR(r2, ia64_mca_pal_base)
	;;
	ld8 r16=[r2]
	mov r18=IA64_GRANULE_SHIFT<<2
	;;
	ptr.i r16,r18
	;;
	srlz.i
	;;

	mov r16=IA64_KR(CURRENT_STACK)
	;;
	shl r16=r16,IA64_GRANULE_SHIFT
	movl r19=PAGE_OFFSET
	;;
	add r16=r19,r16
	mov r18=IA64_GRANULE_SHIFT<<2
	;;
	ptr.d r16,r18
	;;
	srlz.i
	;;

	br.sptk.many b1
	;;



ia64_os_mca_dispatch:
	mov r3=IA64_MCA_CPU_MCA_STACK_OFFSET
	LOAD_PHYSICAL(p0,r2,1f)		
	mov r19=1			
	br.sptk ia64_state_save		
1:

	GET_IA64_MCA_DATA(r2)

	;;
	add r3=IA64_MCA_CPU_MCA_STACK_OFFSET+MCA_SOS_OFFSET+SOS(PROC_STATE_PARAM), r2
	;;
	ld8 r18=[r3]			
	;;
	tbit.nz p6,p7=r18,60
(p7)	br.spnt done_tlb_purge_and_reload



begin_tlb_purge_and_reload:
	movl r18=ia64_reload_tr;;
	LOAD_PHYSICAL(p0,r18,ia64_reload_tr);;
	mov b1=r18;;
	br.sptk.many ia64_do_tlb_purge;;

ia64_reload_tr:


	mov r18=KERNEL_TR_PAGE_SHIFT<<2
	movl r17=KERNEL_START
	;;
	mov cr.itir=r18
	mov cr.ifa=r17
        mov r16=IA64_TR_KERNEL
	mov r19=ip
	movl r18=PAGE_KERNEL
	;;
        dep r17=0,r19,0, KERNEL_TR_PAGE_SHIFT
	;;
	or r18=r17,r18
	;;
        itr.i itr[r16]=r18
	;;
        itr.d dtr[r16]=r18
        ;;
	srlz.i
	srlz.d
	;;

	GET_THIS_PADDR(r2, ia64_mca_pal_pte)
	;;
	ld8 r18=[r2]		
	;;
	GET_THIS_PADDR(r2, ia64_mca_pal_base)
	;;
	ld8 r16=[r2]		
	mov r19=IA64_GRANULE_SHIFT<<2
	;;
	mov cr.itir=r19
	mov cr.ifa=r16
	mov r20=IA64_TR_PALCODE
	;;
	itr.i itr[r20]=r18
	;;
	srlz.i
	;;

	mov r16=IA64_KR(CURRENT_STACK)
	;;
	shl r16=r16,IA64_GRANULE_SHIFT
	movl r19=PAGE_OFFSET
	;;
	add r18=r19,r16
	movl r20=PAGE_KERNEL
	;;
	add r16=r20,r16
	mov r19=IA64_GRANULE_SHIFT<<2
	;;
	mov cr.itir=r19
	mov cr.ifa=r18
	mov r20=IA64_TR_CURRENT_STACK
	;;
	itr.d dtr[r20]=r16
	GET_THIS_PADDR(r2, ia64_mca_tr_reload)
	mov r18 = 1
	;;
	srlz.d
	;;
	st8 [r2] =r18
	;;

done_tlb_purge_and_reload:


	mov r3=IA64_MCA_CPU_MCA_STACK_OFFSET
	LOAD_PHYSICAL(p0,r2,1f)		
	br.sptk ia64_new_stack
1:


	mov r3=IA64_MCA_CPU_MCA_STACK_OFFSET
	LOAD_PHYSICAL(p0,r2,1f)		
	br.sptk ia64_set_kernel_registers
1:


	GET_IA64_MCA_DATA(r2)
	;;
	mov r7=r2

        // Enter virtual mode from physical mode
	VIRTUAL_MODE_ENTER(r2, r3, ia64_os_mca_virtual_begin, r4)





ENTRY(ia64_os_mca_virtual_begin)
	.prologue
	.save rp,r0
	.body

	mov ar.rsc=3			
	mov r2=r7			
	;;


	alloc r14=ar.pfs,0,0,3,0
	;;
	DATA_PA_TO_VA(r2,r7)
	;;
	add out0=IA64_MCA_CPU_MCA_STACK_OFFSET+MCA_PT_REGS_OFFSET, r2
	add out1=IA64_MCA_CPU_MCA_STACK_OFFSET+MCA_SWITCH_STACK_OFFSET, r2
	add out2=IA64_MCA_CPU_MCA_STACK_OFFSET+MCA_SOS_OFFSET, r2
	br.call.sptk.many    b0=ia64_mca_handler


	PHYSICAL_MODE_ENTER(r2, r3, ia64_os_mca_virtual_end, r4)
ia64_os_mca_virtual_end:

END(ia64_os_mca_virtual_begin)


	alloc r14=ar.pfs,0,0,0,0	
	mov r3=IA64_MCA_CPU_MCA_STACK_OFFSET
	LOAD_PHYSICAL(p0,r2,1f)		
	br.sptk ia64_old_stack
1:

	mov r3=IA64_MCA_CPU_MCA_STACK_OFFSET
	LOAD_PHYSICAL(p0,r2,1f)		
	br.sptk ia64_state_restore	
1:

	mov		b0=r12		

	br		b0



ia64_os_init_on_kdump:
	mov		r8=r0	
	mov             r9=r10	
	mov		r22=r17	
	;;
	mov		r10=r0	
	mov		b0=r12	
	br		b0


ia64_os_init_dispatch_monarch:
	mov r19=1			
	br.sptk ia64_os_init_dispatch

ia64_os_init_dispatch_slave:
	mov r19=0			

ia64_os_init_dispatch:

	mov r3=IA64_MCA_CPU_INIT_STACK_OFFSET
	LOAD_PHYSICAL(p0,r2,1f)		
	br.sptk ia64_state_save		
1:


	mov r3=IA64_MCA_CPU_INIT_STACK_OFFSET
	LOAD_PHYSICAL(p0,r2,1f)		
	br.sptk ia64_new_stack
1:


	mov r3=IA64_MCA_CPU_INIT_STACK_OFFSET
	LOAD_PHYSICAL(p0,r2,1f)		
	br.sptk ia64_set_kernel_registers
1:


	GET_IA64_MCA_DATA(r2)
	;;
	mov r7=r2

        // Enter virtual mode from physical mode
	VIRTUAL_MODE_ENTER(r2, r3, ia64_os_init_virtual_begin, r4)





ENTRY(ia64_os_init_virtual_begin)
	.prologue
	.save rp,r0
	.body

	mov ar.rsc=3			
	mov r2=r7			
	;;


	alloc r14=ar.pfs,0,0,3,0
	;;
	DATA_PA_TO_VA(r2,r7)
	;;
	add out0=IA64_MCA_CPU_INIT_STACK_OFFSET+MCA_PT_REGS_OFFSET, r2
	add out1=IA64_MCA_CPU_INIT_STACK_OFFSET+MCA_SWITCH_STACK_OFFSET, r2
	add out2=IA64_MCA_CPU_INIT_STACK_OFFSET+MCA_SOS_OFFSET, r2
	br.call.sptk.many    b0=ia64_init_handler


	PHYSICAL_MODE_ENTER(r2, r3, ia64_os_init_virtual_end, r4)
ia64_os_init_virtual_end:

END(ia64_os_init_virtual_begin)

	mov r3=IA64_MCA_CPU_INIT_STACK_OFFSET
	LOAD_PHYSICAL(p0,r2,1f)		
	br.sptk ia64_state_restore	
1:


	alloc r14=ar.pfs,0,0,0,0	
	mov r3=IA64_MCA_CPU_INIT_STACK_OFFSET
	LOAD_PHYSICAL(p0,r2,1f)		
	br.sptk ia64_old_stack
1:

	mov		b0=r12		
	br		b0


#define	ms		r4
#define	regs		r5
#define	temp1		r2	/* careful, it overlaps with input registers */
#define	temp2		r3	/* careful, it overlaps with input registers */
#define	temp3		r7
#define	temp4		r14



ia64_state_save:
	add regs=MCA_SOS_OFFSET, r3
	add ms=MCA_SOS_OFFSET+8, r3
	mov b0=r2	
	cmp.eq p1,p2=IA64_MCA_CPU_MCA_STACK_OFFSET, r3
	;;
	GET_IA64_MCA_DATA(temp2)
	;;
	add temp1=temp2, regs
	add temp2=temp2, ms
	;;
	mov regs=temp1	
	st8 [temp1]=r1,16
	st8 [temp2]=r8,16
	;;
	st8 [temp1]=r9,16
	st8 [temp2]=r11,16
	mov r11=cr.iipa
	;;
	st8 [temp1]=r18	
	st8 [temp2]=r19	
	mov r6=IA64_KR(CURRENT)
	add temp1=SOS(SAL_RA), regs
	add temp2=SOS(SAL_GP), regs
	;;
	st8 [temp1]=r12,16
	st8 [temp2]=r10,16
	mov r12=cr.isr
	;;
	st8 [temp1]=r17,16
	st8 [temp2]=r6,16
	mov r6=IA64_KR(CURRENT_STACK)
	;;
	st8 [temp1]=r6,16
	st8 [temp2]=r0,16
	mov r6=cr.ifa
	;;
	st8 [temp1]=r12,16
	st8 [temp2]=r6,16
	mov r12=cr.itir
	;;
	st8 [temp1]=r12,16
	st8 [temp2]=r11,16
	mov r12=cr.iim
	;;
	st8 [temp1]=r12	
(p1)	mov r12=IA64_MCA_COLD_BOOT
(p2)	mov r12=IA64_INIT_WARM_BOOT
	mov r6=cr.iha
	add temp1=SOS(OS_STATUS), regs
	;;
	st8 [temp2]=r6	
	add temp2=SOS(CONTEXT), regs
	st8 [temp1]=r12	
	mov r6=IA64_MCA_SAME_CONTEXT
	;;
	st8 [temp2]=r6	



	add regs=MCA_PT_REGS_OFFSET-MCA_SOS_OFFSET, regs
	;;
	add temp1=PT(B6), regs
	mov temp3=b6
	mov temp4=b7
	add temp2=PT(B7), regs
	;;
	st8 [temp1]=temp3,PT(AR_CSD)-PT(B6)	
	st8 [temp2]=temp4,PT(AR_SSD)-PT(B7)	
	mov temp3=ar.csd
	mov temp4=ar.ssd
	cover					
	;;
	st8 [temp1]=temp3,PT(AR_UNAT)-PT(AR_CSD)
	st8 [temp2]=temp4,PT(AR_PFS)-PT(AR_SSD)	
	mov temp3=ar.unat
	mov temp4=ar.pfs
	;;
	st8 [temp1]=temp3,PT(AR_RNAT)-PT(AR_UNAT)
	st8 [temp2]=temp4,PT(AR_BSPSTORE)-PT(AR_PFS)
	mov temp3=ar.rnat
	mov temp4=ar.bspstore
	;;
	st8 [temp1]=temp3,PT(LOADRS)-PT(AR_RNAT)
	st8 [temp2]=temp4,PT(AR_FPSR)-PT(AR_BSPSTORE)
	mov temp3=ar.bsp
	;;
	sub temp3=temp3, temp4
	mov temp4=ar.fpsr
	;;
	shl temp3=temp3,16
	;;
	st8 [temp1]=temp3,PT(AR_CCV)-PT(LOADRS)	
	st8 [temp2]=temp4,PT(F6)-PT(AR_FPSR)	
	mov temp3=ar.ccv
	;;
	st8 [temp1]=temp3,PT(F7)-PT(AR_CCV)	
	stf.spill [temp2]=f6,PT(F8)-PT(F6)
	;;
	stf.spill [temp1]=f7,PT(F9)-PT(F7)
	stf.spill [temp2]=f8,PT(F10)-PT(F8)
	;;
	stf.spill [temp1]=f9,PT(F11)-PT(F9)
	stf.spill [temp2]=f10
	;;
	stf.spill [temp1]=f11



	add regs=MCA_SWITCH_STACK_OFFSET-MCA_PT_REGS_OFFSET, regs
	;;
	add temp1=SW(F2), regs
	add temp2=SW(F3), regs
	;;
	stf.spill [temp1]=f2,32
	stf.spill [temp2]=f3,32
	;;
	stf.spill [temp1]=f4,32
	stf.spill [temp2]=f5,32
	;;
	stf.spill [temp1]=f12,32
	stf.spill [temp2]=f13,32
	;;
	stf.spill [temp1]=f14,32
	stf.spill [temp2]=f15,32
	;;
	stf.spill [temp1]=f16,32
	stf.spill [temp2]=f17,32
	;;
	stf.spill [temp1]=f18,32
	stf.spill [temp2]=f19,32
	;;
	stf.spill [temp1]=f20,32
	stf.spill [temp2]=f21,32
	;;
	stf.spill [temp1]=f22,32
	stf.spill [temp2]=f23,32
	;;
	stf.spill [temp1]=f24,32
	stf.spill [temp2]=f25,32
	;;
	stf.spill [temp1]=f26,32
	stf.spill [temp2]=f27,32
	;;
	stf.spill [temp1]=f28,32
	stf.spill [temp2]=f29,32
	;;
	stf.spill [temp1]=f30,SW(B2)-SW(F30)
	stf.spill [temp2]=f31,SW(B3)-SW(F31)
	mov temp3=b2
	mov temp4=b3
	;;
	st8 [temp1]=temp3,16
	st8 [temp2]=temp4,16
	mov temp3=b4
	mov temp4=b5
	;;
	st8 [temp1]=temp3,SW(AR_LC)-SW(B4)
	st8 [temp2]=temp4
	mov temp3=ar.lc
	;;
	st8 [temp1]=temp3








	add r1=32*1,r17
	add r2=32*2,r17
	add r3=32*3,r17
	add r4=32*4,r17
	add r5=32*5,r17
	add r6=32*6,r17
	add r7=32*7,r17
	;;
	fc r17
	fc r1
	fc r2
	fc r3
	fc r4
	fc r5
	fc r6
	fc r7
	add r17=32*8,r17
	add r1=32*8,r1
	add r2=32*8,r2
	add r3=32*8,r3
	add r4=32*8,r4
	add r5=32*8,r5
	add r6=32*8,r6
	add r7=32*8,r7
	;;
	fc r17
	fc r1
	fc r2
	fc r3
	fc r4
	fc r5
	fc r6
	fc r7
	add r17=32*8,r17
	add r1=32*8,r1
	add r2=32*8,r2
	add r3=32*8,r3
	add r4=32*8,r4
	add r5=32*8,r5
	add r6=32*8,r6
	add r7=32*8,r7
	;;
	fc r17
	fc r1
	fc r2
	fc r3
	fc r4
	fc r5
	fc r6
	fc r7
	add r17=32*8,r17
	add r1=32*8,r1
	add r2=32*8,r2
	add r3=32*8,r3
	add r4=32*8,r4
	add r5=32*8,r5
	add r6=32*8,r6
	add r7=32*8,r7
	;;
	fc r17
	fc r1
	fc r2
	fc r3
	fc r4
	fc r5
	fc r6
	fc r7

	br.sptk b0




ia64_state_restore:

	add regs=MCA_SWITCH_STACK_OFFSET, r3
	mov b0=r2	
	;;
	GET_IA64_MCA_DATA(temp2)
	;;
	add regs=temp2, regs
	;;
	add temp1=SW(F2), regs
	add temp2=SW(F3), regs
	;;
	ldf.fill f2=[temp1],32
	ldf.fill f3=[temp2],32
	;;
	ldf.fill f4=[temp1],32
	ldf.fill f5=[temp2],32
	;;
	ldf.fill f12=[temp1],32
	ldf.fill f13=[temp2],32
	;;
	ldf.fill f14=[temp1],32
	ldf.fill f15=[temp2],32
	;;
	ldf.fill f16=[temp1],32
	ldf.fill f17=[temp2],32
	;;
	ldf.fill f18=[temp1],32
	ldf.fill f19=[temp2],32
	;;
	ldf.fill f20=[temp1],32
	ldf.fill f21=[temp2],32
	;;
	ldf.fill f22=[temp1],32
	ldf.fill f23=[temp2],32
	;;
	ldf.fill f24=[temp1],32
	ldf.fill f25=[temp2],32
	;;
	ldf.fill f26=[temp1],32
	ldf.fill f27=[temp2],32
	;;
	ldf.fill f28=[temp1],32
	ldf.fill f29=[temp2],32
	;;
	ldf.fill f30=[temp1],SW(B2)-SW(F30)
	ldf.fill f31=[temp2],SW(B3)-SW(F31)
	;;
	ld8 temp3=[temp1],16
	ld8 temp4=[temp2],16
	;;
	mov b2=temp3
	mov b3=temp4
	ld8 temp3=[temp1],SW(AR_LC)-SW(B4)
	ld8 temp4=[temp2]
	;;
	mov b4=temp3
	mov b5=temp4
	ld8 temp3=[temp1]
	;;
	mov ar.lc=temp3



	add regs=MCA_PT_REGS_OFFSET-MCA_SWITCH_STACK_OFFSET, regs
	;;
	add temp1=PT(B6), regs
	add temp2=PT(B7), regs
	;;
	ld8 temp3=[temp1],PT(AR_CSD)-PT(B6)	
	ld8 temp4=[temp2],PT(AR_SSD)-PT(B7)	
	;;
	mov b6=temp3
	mov b7=temp4
	ld8 temp3=[temp1],PT(AR_UNAT)-PT(AR_CSD)
	ld8 temp4=[temp2],PT(AR_PFS)-PT(AR_SSD)	
	;;
	mov ar.csd=temp3
	mov ar.ssd=temp4
	ld8 temp3=[temp1]			
	add temp1=PT(AR_CCV)-PT(AR_UNAT), temp1
	ld8 temp4=[temp2],PT(AR_FPSR)-PT(AR_PFS)
	;;
	mov ar.unat=temp3
	mov ar.pfs=temp4

	ld8 temp3=[temp1],PT(F6)-PT(AR_CCV)	
	ld8 temp4=[temp2],PT(F7)-PT(AR_FPSR)	
	;;
	mov ar.ccv=temp3
	mov ar.fpsr=temp4
	ldf.fill f6=[temp1],PT(F8)-PT(F6)
	ldf.fill f7=[temp2],PT(F9)-PT(F7)
	;;
	ldf.fill f8=[temp1],PT(F10)-PT(F8)
	ldf.fill f9=[temp2],PT(F11)-PT(F9)
	;;
	ldf.fill f10=[temp1]
	ldf.fill f11=[temp2]


	add regs=MCA_SOS_OFFSET-MCA_PT_REGS_OFFSET, regs
	;;
	add temp1=SOS(SAL_RA), regs
	add temp2=SOS(SAL_GP), regs
	;;
	ld8 r12=[temp1],16
	ld8 r9=[temp2],16
	;;
	ld8 r22=[temp1],16
	ld8 r13=[temp2],16
	;;
	ld8 r16=[temp1],16
	ld8 r20=[temp2],16
	;;
	ld8 temp3=[temp1],16
	ld8 temp4=[temp2],16
	;;
	mov cr.isr=temp3
	mov cr.ifa=temp4
	ld8 temp3=[temp1],16
	ld8 temp4=[temp2],16
	;;
	mov cr.itir=temp3
	mov cr.iipa=temp4
	ld8 temp3=[temp1]
	ld8 temp4=[temp2]	
	add temp1=SOS(OS_STATUS), regs
	add temp2=SOS(CONTEXT), regs
	;;
	mov cr.iim=temp3
	mov cr.iha=temp4
	dep r22=0,r22,62,1
	mov IA64_KR(CURRENT)=r13
	ld8 r8=[temp1]	
	ld8 r10=[temp2]	

	/* Wire IA64_TR_CURRENT_STACK to the stack that we are resuming to.  To
	 * avoid any dependencies on the algorithm in ia64_switch_to(), just
	 * purge any existing CURRENT_STACK mapping and insert the new one.
	 *
	 * r16 contains prev_IA64_KR_CURRENT_STACK, r13 contains
	 * prev_IA64_KR_CURRENT, these values may have been changed by the C
	 * code.  Do not use r8, r9, r10, r22, they contain values ready for
	 * the return to SAL.
	 */

	mov r15=IA64_KR(CURRENT_STACK)	
	;;
	shl r15=r15,IA64_GRANULE_SHIFT
	;;
	dep r15=-1,r15,61,3		
	mov r18=IA64_GRANULE_SHIFT<<2	
	;;
	ptr.d r15,r18
	;;
	srlz.d

	extr.u r19=r13,61,3		
	shl r20=r16,IA64_GRANULE_SHIFT	
	movl r21=PAGE_KERNEL		
	;;
	mov IA64_KR(CURRENT_STACK)=r16
	cmp.ne p6,p0=RGN_KERNEL,r19	
	or r21=r20,r21			
(p6)	br.spnt 1f			
	;;
	mov cr.itir=r18
	mov cr.ifa=r13
	mov r20=IA64_TR_CURRENT_STACK
	;;
	itr.d dtr[r20]=r21
	;;
	srlz.d
1:

	br.sptk b0




ia64_new_stack:
	add regs=MCA_PT_REGS_OFFSET, r3
	add temp2=MCA_SOS_OFFSET+SOS(PAL_MIN_STATE), r3
	mov b0=r2		
	GET_IA64_MCA_DATA(temp1)
	invala
	;;
	add temp2=temp2, temp1	
	add regs=regs, temp1	
	;;


	ld8 ms=[temp2]		
	;;
	dep temp1=-1,ms,62,2	
	mov temp3=IA64_RBS_OFFSET-MCA_PT_REGS_OFFSET
	;;
	st8 [temp2]=temp1	

	add temp4=temp3, regs	
	;;
	mov ar.bspstore=temp4	
	;;
	flushrs			
	br.sptk b0




ia64_old_stack:
	add regs=MCA_PT_REGS_OFFSET, r3
	mov b0=r2		
	GET_IA64_MCA_DATA(temp2)
	LOAD_PHYSICAL(p0,temp1,1f)
	;;
	mov cr.ipsr=r0
	mov cr.ifs=r0
	mov cr.iip=temp1
	;;
	invala
	rfi
1:

	add regs=regs, temp2	
	;;
	add temp1=PT(LOADRS), regs
	;;
	ld8 temp2=[temp1],PT(AR_BSPSTORE)-PT(LOADRS)
	;;
	ld8 temp3=[temp1],PT(AR_RNAT)-PT(AR_BSPSTORE)
	mov ar.rsc=temp2
	;;
	loadrs
	ld8 temp4=[temp1]	
	;;
	mov ar.bspstore=temp3	
	;;
	mov ar.rnat=temp4
	;;

	br.sptk b0




ia64_set_kernel_registers:
	add temp3=MCA_SP_OFFSET, r3
	mov b0=r2	
	GET_IA64_MCA_DATA(temp1)
	;;
	add r12=temp1, temp3
	add r13=temp1, r3
	add r20=temp1, r3
	;;
	DATA_PA_TO_VA(r12,temp2)
	DATA_PA_TO_VA(r13,temp3)
	;;
	mov IA64_KR(CURRENT)=r13

	/* Wire IA64_TR_CURRENT_STACK to the MCA/INIT handler stack.  To avoid
	 * any dependencies on the algorithm in ia64_switch_to(), just purge
	 * any existing CURRENT_STACK mapping and insert the new one.
	 */

	mov r16=IA64_KR(CURRENT_STACK)	
	;;
	shl r16=r16,IA64_GRANULE_SHIFT
	;;
	dep r16=-1,r16,61,3		
	mov r18=IA64_GRANULE_SHIFT<<2	
	;;
	ptr.d r16,r18
	;;
	srlz.d

	shr.u r16=r20,IA64_GRANULE_SHIFT
	movl r21=PAGE_KERNEL		
	;;
	mov IA64_KR(CURRENT_STACK)=r16
	or r21=r20,r21			
	;;
	mov cr.itir=r18
	mov cr.ifa=r13
	mov r20=IA64_TR_CURRENT_STACK

	movl r17=FPSR_DEFAULT
	;;
	mov.m ar.fpsr=r17		
	;;
	itr.d dtr[r20]=r21
	;;
	srlz.d

	br.sptk b0


#undef	ms
#undef	regs
#undef	temp1
#undef	temp2
#undef	temp3
#undef	temp4


GLOBAL_ENTRY(ia64_get_rnat)
	alloc r14=ar.pfs,1,0,0,0
	mov ar.rsc=0
	;;
	mov r14=ar.bspstore
	;;
	cmp.lt p6,p7=in0,r14
	;;
(p6)	ld8 r8=[in0]
(p7)	mov r8=ar.rnat
	mov ar.rsc=3
	br.ret.sptk.many rp
END(ia64_get_rnat)


GLOBAL_ENTRY(ia64_set_psr_mc)
	rsm psr.i | psr.ic	
	;;
	srlz.d
	;;
	mov r14 = psr		
	movl r15 = 1f
	;;
	dep r14 = -1, r14, PSR_MC, 1
	;;
	dep r14 = -1, r14, PSR_IC, 1
	;;
	dep r14 = -1, r14, PSR_BN, 1
	;;
	mov cr.ipsr = r14
	mov cr.ifs = r0
	mov cr.iip = r15
	;;
	rfi
1:
	br.ret.sptk.many rp
END(ia64_set_psr_mc)
