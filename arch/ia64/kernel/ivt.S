/*
 * arch/ia64/kernel/ivt.S
 *
 * Copyright (C) 1998-2001, 2003, 2005 Hewlett-Packard Co
 *	Stephane Eranian <eranian@hpl.hp.com>
 *	David Mosberger <davidm@hpl.hp.com>
 * Copyright (C) 2000, 2002-2003 Intel Co
 *	Asit Mallick <asit.k.mallick@intel.com>
 *      Suresh Siddha <suresh.b.siddha@intel.com>
 *      Kenneth Chen <kenneth.w.chen@intel.com>
 *      Fenghua Yu <fenghua.yu@intel.com>
 *
 * 00/08/23 Asit Mallick <asit.k.mallick@intel.com> TLB handling for SMP
 * 00/12/20 David Mosberger-Tang <davidm@hpl.hp.com> DTLB/ITLB handler now uses virtual PT.
 *
 * Copyright (C) 2005 Hewlett-Packard Co
 *	Dan Magenheimer <dan.magenheimer@hp.com>
 *      Xen paravirtualization
 * Copyright (c) 2008 Isaku Yamahata <yamahata at valinux co jp>
 *                    VA Linux Systems Japan K.K.
 *                    pv_ops.
 *      Yaozu (Eddie) Dong <eddie.dong@intel.com>
 */
/*
 * This file defines the interruption vector table used by the CPU.
 * It does not include one entry per possible cause of interruption.
 *
 * The first 20 entries of the table contain 64 bundles each while the
 * remaining 48 entries contain only 16 bundles each.
 *
 * The 64 bundles are used to allow inlining the whole handler for critical
 * interruptions like TLB misses.
 *
 *  For each entry, the comment is as follows:
 *
 *	
 *  entry offset ----/     /         /                  /          /
 *  entry number ---------/         /                  /          /
 *  size of the entry -------------/                  /          /
 *  vector name -------------------------------------/          /
 *  interruptions triggering this vector ----------------------/
 *
 * The table is 32KB in size and must be aligned on 32KB boundary.
 * (The CPU ignores the 15 lower bits of the address)
 *
 * Table is based upon EAS2.6 (Oct 1999)
 */


#include <asm/asmmacro.h>
#include <asm/break.h>
#include <asm/kregs.h>
#include <asm/asm-offsets.h>
#include <asm/pgtable.h>
#include <asm/processor.h>
#include <asm/ptrace.h>
#include <asm/thread_info.h>
#include <asm/unistd.h>
#include <asm/errno.h>

#if 0
# define PSR_DEFAULT_BITS	psr.ac
#else
# define PSR_DEFAULT_BITS	0
#endif

#if 0
  /*
   * This lets you track the last eight faults that occurred on the CPU.  Make sure ar.k2 isn't
   * needed for something else before enabling this...
   */
# define DBG_FAULT(i)	mov r16=ar.k2;;	shl r16=r16,8;;	add r16=(i),r16;;mov ar.k2=r16
#else
# define DBG_FAULT(i)
#endif

#include "minstate.h"

#define FAULT(n)									\
	mov r31=pr;									\
	mov r19=n;;			/* prepare to save predicates */		\
	br.sptk.many dispatch_to_fault_handler

	.section .text..ivt,"ax"

	.align 32768
	.global ia64_ivt
ia64_ivt:
ENTRY(vhpt_miss)
	DBG_FAULT(0)
	/*
	 * The VHPT vector is invoked when the TLB entry for the virtual page table
	 * is missing.  This happens only as a result of a previous
	 * (the "original") TLB miss, which may either be caused by an instruction
	 * fetch or a data access (or non-access).
	 *
	 * What we do here is normal TLB miss handing for the _original_ miss,
	 * followed by inserting the TLB entry for the virtual page table page
	 * that the VHPT walker was attempting to access.  The latter gets
	 * inserted as long as page table entry above pte level have valid
	 * mappings for the faulting address.  The TLB entry for the original
	 * miss gets inserted only if the pte entry indicates that the page is
	 * present.
	 *
	 * do_page_fault gets invoked in the following cases:
	 *	- the faulting virtual address uses unimplemented address bits
	 *	- the faulting virtual address has no valid page table mapping
	 */
	MOV_FROM_IFA(r16)		
#ifdef CONFIG_HUGETLB_PAGE
	movl r18=PAGE_SHIFT
	MOV_FROM_ITIR(r25)
#endif
	;;
	RSM_PSR_DT			
	mov r31=pr			
	mov r19=IA64_KR(PT_BASE)	
	shl r21=r16,3			
	shr.u r17=r16,61		
	;;
	shr.u r22=r21,3
#ifdef CONFIG_HUGETLB_PAGE
	extr.u r26=r25,2,6
	;;
	cmp.ne p8,p0=r18,r26
	sub r27=r26,r18
	;;
(p8)	dep r25=r18,r25,2,6
(p8)	shr r22=r22,r27
#endif
	;;
	cmp.eq p6,p7=5,r17		
	shr.u r18=r22,PGDIR_SHIFT	
	;;
(p7)	dep r17=r17,r19,(PAGE_SHIFT-3),3

	srlz.d
	LOAD_PHYSICAL(p6, r19, swapper_pg_dir)

	.pred.rel "mutex", p6, p7
(p6)	shr.u r21=r21,PGDIR_SHIFT+PAGE_SHIFT
(p7)	shr.u r21=r21,PGDIR_SHIFT+PAGE_SHIFT-3
	;;
(p6)	dep r17=r18,r19,3,(PAGE_SHIFT-3)
(p7)	dep r17=r18,r17,3,(PAGE_SHIFT-6)
	cmp.eq p7,p6=0,r21		
#ifdef CONFIG_PGTABLE_4
	shr.u r28=r22,PUD_SHIFT		
#else
	shr.u r18=r22,PMD_SHIFT		
#endif
	;;
	ld8 r17=[r17]			
	;;
(p7)	cmp.eq p6,p7=r17,r0		
#ifdef CONFIG_PGTABLE_4
	dep r28=r28,r17,3,(PAGE_SHIFT-3)
	;;
	shr.u r18=r22,PMD_SHIFT		
(p7)	ld8 r29=[r28]			
	;;
(p7)	cmp.eq.or.andcm p6,p7=r29,r0	
	dep r17=r18,r29,3,(PAGE_SHIFT-3)
#else
	dep r17=r18,r17,3,(PAGE_SHIFT-3)
#endif
	;;
(p7)	ld8 r20=[r17]			
	shr.u r19=r22,PAGE_SHIFT	
	;;
(p7)	cmp.eq.or.andcm p6,p7=r20,r0	
	dep r21=r19,r20,3,(PAGE_SHIFT-3)
	;;
(p7)	ld8 r18=[r21]			
	MOV_FROM_ISR(r19)		
	;;
(p7)	tbit.z p6,p7=r18,_PAGE_P_BIT	
	MOV_FROM_IHA(r22)		
	;;				
(p7)	tbit.nz.unc p10,p11=r19,32	
	dep r23=0,r20,0,PAGE_SHIFT	
	;;
	ITC_I_AND_D(p10, p11, r18, r24)	
					
(p6)	br.cond.spnt.many page_fault	
	MOV_TO_IFA(r22, r24)

#ifdef CONFIG_HUGETLB_PAGE
	MOV_TO_ITIR(p8, r25, r24)	
#endif

	/*
	 * Now compute and insert the TLB entry for the virtual page table.  We never
	 * execute in a page table page so there is no need to set the exception deferral
	 * bit.
	 */
	adds r24=__DIRTY_BITS_NO_ED|_PAGE_PL_0|_PAGE_AR_RW,r23
	;;
	ITC_D(p7, r24, r25)
	;;
#ifdef CONFIG_SMP
	/*
	 * Tell the assemblers dependency-violation checker that the above "itc" instructions
	 * cannot possibly affect the following loads:
	 */
	dv_serialize_data

	/*
	 * Re-check pagetable entry.  If they changed, we may have received a ptc.g
	 * between reading the pagetable and the "itc".  If so, flush the entry we
	 * inserted and retry.  At this point, we have:
	 *
	 * r28 = equivalent of pud_offset(pgd, ifa)
	 * r17 = equivalent of pmd_offset(pud, ifa)
	 * r21 = equivalent of pte_offset(pmd, ifa)
	 *
	 * r29 = *pud
	 * r20 = *pmd
	 * r18 = *pte
	 */
	ld8 r25=[r21]			
	ld8 r26=[r17]			
#ifdef CONFIG_PGTABLE_4
	ld8 r19=[r28]			
#endif
	cmp.ne p6,p7=r0,r0
	;;
	cmp.ne.or.andcm p6,p7=r26,r20	
#ifdef CONFIG_PGTABLE_4
	cmp.ne.or.andcm p6,p7=r19,r29	
#endif
	mov r27=PAGE_SHIFT<<2
	;;
(p6)	ptc.l r22,r27			
(p7)	cmp.ne.or.andcm p6,p7=r25,r18	
	;;
(p6)	ptc.l r16,r27			
#endif

	mov pr=r31,-1			
	RFI
END(vhpt_miss)

	.org ia64_ivt+0x400
ENTRY(itlb_miss)
	DBG_FAULT(1)
	/*
	 * The ITLB handler accesses the PTE via the virtually mapped linear
	 * page table.  If a nested TLB miss occurs, we switch into physical
	 * mode, walk the page table, and then re-execute the PTE read and
	 * go on normally after that.
	 */
	MOV_FROM_IFA(r16)		
	mov r29=b0			
	mov r31=pr			
.itlb_fault:
	MOV_FROM_IHA(r17)		
	movl r30=1f			
	;;
1:	ld8 r18=[r17]			
	;;
	mov b0=r29
	tbit.z p6,p0=r18,_PAGE_P_BIT	
(p6)	br.cond.spnt page_fault
	;;
	ITC_I(p0, r18, r19)
	;;
#ifdef CONFIG_SMP
	/*
	 * Tell the assemblers dependency-violation checker that the above "itc" instructions
	 * cannot possibly affect the following loads:
	 */
	dv_serialize_data

	ld8 r19=[r17]			
	mov r20=PAGE_SHIFT<<2		
	;;
	cmp.ne p7,p0=r18,r19
	;;
(p7)	ptc.l r16,r20
#endif
	mov pr=r31,-1
	RFI
END(itlb_miss)

	.org ia64_ivt+0x0800
ENTRY(dtlb_miss)
	DBG_FAULT(2)
	/*
	 * The DTLB handler accesses the PTE via the virtually mapped linear
	 * page table.  If a nested TLB miss occurs, we switch into physical
	 * mode, walk the page table, and then re-execute the PTE read and
	 * go on normally after that.
	 */
	MOV_FROM_IFA(r16)		
	mov r29=b0			
	mov r31=pr			
dtlb_fault:
	MOV_FROM_IHA(r17)		
	movl r30=1f			
	;;
1:	ld8 r18=[r17]			
	;;
	mov b0=r29
	tbit.z p6,p0=r18,_PAGE_P_BIT	
(p6)	br.cond.spnt page_fault
	;;
	ITC_D(p0, r18, r19)
	;;
#ifdef CONFIG_SMP
	/*
	 * Tell the assemblers dependency-violation checker that the above "itc" instructions
	 * cannot possibly affect the following loads:
	 */
	dv_serialize_data

	ld8 r19=[r17]			
	mov r20=PAGE_SHIFT<<2		
	;;
	cmp.ne p7,p0=r18,r19
	;;
(p7)	ptc.l r16,r20
#endif
	mov pr=r31,-1
	RFI
END(dtlb_miss)

	.org ia64_ivt+0x0c00
ENTRY(alt_itlb_miss)
	DBG_FAULT(3)
	MOV_FROM_IFA(r16)
	movl r17=PAGE_KERNEL
	MOV_FROM_IPSR(p0, r21)
	movl r19=(((1 << IA64_MAX_PHYS_BITS) - 1) & ~0xfff)
	mov r31=pr
	;;
#ifdef CONFIG_DISABLE_VHPT
	shr.u r22=r16,61		
	;;
	cmp.gt p8,p0=6,r22		
	;;
	THASH(p8, r17, r16, r23)
	;;
	MOV_TO_IHA(p8, r17, r23)
(p8)	mov r29=b0			
(p8)	br.cond.dptk .itlb_fault
#endif
	extr.u r23=r21,IA64_PSR_CPL0_BIT,2
	and r19=r19,r16	
	shr.u r18=r16,57
	;;
	andcm r18=0x10,r18
	cmp.ne p8,p0=r0,r23
	or r19=r17,r19	
	;;
	or r19=r19,r18	
(p8)	br.cond.spnt page_fault
	;;
	ITC_I(p0, r19, r18)
	mov pr=r31,-1
	RFI
END(alt_itlb_miss)

	.org ia64_ivt+0x1000
ENTRY(alt_dtlb_miss)
	DBG_FAULT(4)
	MOV_FROM_IFA(r16)
	movl r17=PAGE_KERNEL
	MOV_FROM_ISR(r20)
	movl r19=(((1 << IA64_MAX_PHYS_BITS) - 1) & ~0xfff)
	MOV_FROM_IPSR(p0, r21)
	mov r31=pr
	mov r24=PERCPU_ADDR
	;;
#ifdef CONFIG_DISABLE_VHPT
	shr.u r22=r16,61		
	;;
	cmp.gt p8,p0=6,r22		
	;;
	THASH(p8, r17, r16, r25)
	;;
	MOV_TO_IHA(p8, r17, r25)
(p8)	mov r29=b0			
(p8)	br.cond.dptk dtlb_fault
#endif
	cmp.ge p10,p11=r16,r24		
	tbit.z p12,p0=r16,61		
	mov r25=PERCPU_PAGE_SHIFT << 2
	mov r26=PERCPU_PAGE_SIZE
	nop.m 0
	nop.b 0
	;;
(p10)	mov r19=IA64_KR(PER_CPU_DATA)
(p11)	and r19=r19,r16			
	extr.u r23=r21,IA64_PSR_CPL0_BIT,2
	and r22=IA64_ISR_CODE_MASK,r20	
	tbit.nz p6,p7=r20,IA64_ISR_SP_BIT
	tbit.nz p9,p0=r20,IA64_ISR_NA_BIT
	;;
(p10)	sub r19=r19,r26
	MOV_TO_ITIR(p10, r25, r24)
	cmp.ne p8,p0=r0,r23
(p9)	cmp.eq.or.andcm p6,p7=IA64_ISR_CODE_LFETCH,r22
(p12)	dep r17=-1,r17,4,1		
(p8)	br.cond.spnt page_fault

	dep r21=-1,r21,IA64_PSR_ED_BIT,1
	;;
	or r19=r19,r17	
	MOV_TO_IPSR(p6, r21, r24)
	;;
	ITC_D(p7, r19, r18)
	mov pr=r31,-1
	RFI
END(alt_dtlb_miss)

	.org ia64_ivt+0x1400
ENTRY(nested_dtlb_miss)
	/*
	 * In the absence of kernel bugs, we get here when the virtually mapped linear
	 * page table is accessed non-speculatively (e.g., in the Dirty-bit, Instruction
	 * Access-bit, or Data Access-bit faults).  If the DTLB entry for the virtual page
	 * table is missing, a nested TLB miss fault is triggered and control is
	 * transferred to this point.  When this happens, we lookup the pte for the
	 * faulting address by walking the page table in physical mode and return to the
	 * continuation point passed in register r30 (or call page_fault if the address is
	 * not mapped).
	 *
	 * Input:	r16:	faulting address
	 *		r29:	saved b0
	 *		r30:	continuation address
	 *		r31:	saved pr
	 *
	 * Output:	r17:	physical address of PTE of faulting address
	 *		r29:	saved b0
	 *		r30:	continuation address
	 *		r31:	saved pr
	 *
	 * Clobbered:	b0, r18, r19, r21, r22, psr.dt (cleared)
	 */
	RSM_PSR_DT			
	mov r19=IA64_KR(PT_BASE)	
	shl r21=r16,3			
	MOV_FROM_ITIR(r18)
	;;
	shr.u r17=r16,61		
	extr.u r18=r18,2,6		
	;;
	cmp.eq p6,p7=5,r17		
	add r22=-PAGE_SHIFT,r18		
	add r18=PGDIR_SHIFT-PAGE_SHIFT,r18
	;;
	shr.u r22=r16,r22
	shr.u r18=r16,r18
(p7)	dep r17=r17,r19,(PAGE_SHIFT-3),3

	srlz.d
	LOAD_PHYSICAL(p6, r19, swapper_pg_dir)

	.pred.rel "mutex", p6, p7
(p6)	shr.u r21=r21,PGDIR_SHIFT+PAGE_SHIFT
(p7)	shr.u r21=r21,PGDIR_SHIFT+PAGE_SHIFT-3
	;;
(p6)	dep r17=r18,r19,3,(PAGE_SHIFT-3)
(p7)	dep r17=r18,r17,3,(PAGE_SHIFT-6)
	cmp.eq p7,p6=0,r21		
#ifdef CONFIG_PGTABLE_4
	shr.u r18=r22,PUD_SHIFT		
#else
	shr.u r18=r22,PMD_SHIFT		
#endif
	;;
	ld8 r17=[r17]			
	;;
(p7)	cmp.eq p6,p7=r17,r0		
	dep r17=r18,r17,3,(PAGE_SHIFT-3)
	;;
#ifdef CONFIG_PGTABLE_4
(p7)	ld8 r17=[r17]			
	shr.u r18=r22,PMD_SHIFT		
	;;
(p7)	cmp.eq.or.andcm p6,p7=r17,r0	
	dep r17=r18,r17,3,(PAGE_SHIFT-3)
	;;
#endif
(p7)	ld8 r17=[r17]			
	shr.u r19=r22,PAGE_SHIFT	
	;;
(p7)	cmp.eq.or.andcm p6,p7=r17,r0	
	dep r17=r19,r17,3,(PAGE_SHIFT-3)
(p6)	br.cond.spnt page_fault
	mov b0=r30
	br.sptk.many b0			
END(nested_dtlb_miss)

	.org ia64_ivt+0x1800
ENTRY(ikey_miss)
	DBG_FAULT(6)
	FAULT(6)
END(ikey_miss)

	.org ia64_ivt+0x1c00
ENTRY(dkey_miss)
	DBG_FAULT(7)
	FAULT(7)
END(dkey_miss)

	.org ia64_ivt+0x2000
ENTRY(dirty_bit)
	DBG_FAULT(8)
	/*
	 * What we do here is to simply turn on the dirty bit in the PTE.  We need to
	 * update both the page-table and the TLB entry.  To efficiently access the PTE,
	 * we address it through the virtual page table.  Most likely, the TLB entry for
	 * the relevant virtual page table page is still present in the TLB so we can
	 * normally do this without additional TLB misses.  In case the necessary virtual
	 * page table TLB entry isn't present, we take a nested TLB miss hit where we look
	 * up the physical address of the L3 PTE and then continue at label 1 below.
	 */
	MOV_FROM_IFA(r16)		
	movl r30=1f			
	;;
	THASH(p0, r17, r16, r18)	
	mov r29=b0			
	mov r31=pr			
#ifdef CONFIG_SMP
	mov r28=ar.ccv			
	;;
1:	ld8 r18=[r17]
	;;				
	mov ar.ccv=r18			
	or r25=_PAGE_D|_PAGE_A,r18	
	tbit.z p7,p6 = r18,_PAGE_P_BIT	
	;;
(p6)	cmpxchg8.acq r26=[r17],r25,ar.ccv
	mov r24=PAGE_SHIFT<<2
	;;
(p6)	cmp.eq p6,p7=r26,r18		
	;;
	ITC_D(p6, r25, r18)		
	;;
	/*
	 * Tell the assemblers dependency-violation checker that the above "itc" instructions
	 * cannot possibly affect the following loads:
	 */
	dv_serialize_data

	ld8 r18=[r17]			
	;;
	cmp.eq p6,p7=r18,r25		
	;;
(p7)	ptc.l r16,r24
	mov b0=r29			
	mov ar.ccv=r28
#else
	;;
1:	ld8 r18=[r17]
	;;				
	or r18=_PAGE_D|_PAGE_A,r18	
	mov b0=r29			
	;;
	st8 [r17]=r18			
	ITC_D(p0, r18, r16)		
#endif
	mov pr=r31,-1			
	RFI
END(dirty_bit)

	.org ia64_ivt+0x2400
ENTRY(iaccess_bit)
	DBG_FAULT(9)

	MOV_FROM_IFA(r16)		
	movl r30=1f			
	mov r31=pr			
#ifdef CONFIG_ITANIUM
	/*
	 * Erratum 10 (IFA may contain incorrect address) has "NoFix" status.
	 */
	MOV_FROM_IPSR(p0, r17)
	;;
	MOV_FROM_IIP(r18)
	tbit.z p6,p0=r17,IA64_PSR_IS_BIT
	;;
(p6)	mov r16=r18			
#endif /* CONFIG_ITANIUM */
	;;
	THASH(p0, r17, r16, r18)	
	mov r29=b0			
#ifdef CONFIG_SMP
	mov r28=ar.ccv			
	;;
1:	ld8 r18=[r17]
	;;
	mov ar.ccv=r18			
	or r25=_PAGE_A,r18		
	tbit.z p7,p6 = r18,_PAGE_P_BIT	 
	;;
(p6)	cmpxchg8.acq r26=[r17],r25,ar.ccv
	mov r24=PAGE_SHIFT<<2
	;;
(p6)	cmp.eq p6,p7=r26,r18		
	;;
	ITC_I(p6, r25, r26)		
	;;
	/*
	 * Tell the assemblers dependency-violation checker that the above "itc" instructions
	 * cannot possibly affect the following loads:
	 */
	dv_serialize_data

	ld8 r18=[r17]			
	;;
	cmp.eq p6,p7=r18,r25		
	;;
(p7)	ptc.l r16,r24
	mov b0=r29			
	mov ar.ccv=r28
#else /* !CONFIG_SMP */
	;;
1:	ld8 r18=[r17]
	;;
	or r18=_PAGE_A,r18		
	mov b0=r29			
	;;
	st8 [r17]=r18			
	ITC_I(p0, r18, r16)		
#endif /* !CONFIG_SMP */
	mov pr=r31,-1
	RFI
END(iaccess_bit)

	.org ia64_ivt+0x2800
ENTRY(daccess_bit)
	DBG_FAULT(10)

	MOV_FROM_IFA(r16)		
	movl r30=1f			
	;;
	THASH(p0, r17, r16, r18)	
	mov r31=pr
	mov r29=b0			
#ifdef CONFIG_SMP
	mov r28=ar.ccv			
	;;
1:	ld8 r18=[r17]
	;;				
	mov ar.ccv=r18			
	or r25=_PAGE_A,r18		
	tbit.z p7,p6 = r18,_PAGE_P_BIT	
	;;
(p6)	cmpxchg8.acq r26=[r17],r25,ar.ccv
	mov r24=PAGE_SHIFT<<2
	;;
(p6)	cmp.eq p6,p7=r26,r18		
	;;
	ITC_D(p6, r25, r26)		
	/*
	 * Tell the assemblers dependency-violation checker that the above "itc" instructions
	 * cannot possibly affect the following loads:
	 */
	dv_serialize_data
	;;
	ld8 r18=[r17]			
	;;
	cmp.eq p6,p7=r18,r25		
	;;
(p7)	ptc.l r16,r24
	mov ar.ccv=r28
#else
	;;
1:	ld8 r18=[r17]
	;;				
	or r18=_PAGE_A,r18		
	;;
	st8 [r17]=r18			
	ITC_D(p0, r18, r16)		
#endif
	mov b0=r29			
	mov pr=r31,-1
	RFI
END(daccess_bit)

	.org ia64_ivt+0x2c00
ENTRY(break_fault)
	/*
	 * The streamlined system call entry/exit paths only save/restore the initial part
	 * of pt_regs.  This implies that the callers of system-calls must adhere to the
	 * normal procedure calling conventions.
	 *
	 *   Registers to be saved & restored:
	 *	CR registers: cr.ipsr, cr.iip, cr.ifs
	 *	AR registers: ar.unat, ar.pfs, ar.rsc, ar.rnat, ar.bspstore, ar.fpsr
	 * 	others: pr, b0, b6, loadrs, r1, r11, r12, r13, r15
	 *   Registers to be restored only:
	 * 	r8-r11: output value from the system call.
	 *
	 * During system call exit, scratch registers (including r15) are modified/cleared
	 * to prevent leaking bits from kernel to user level.
	 */
	DBG_FAULT(11)
	mov.m r16=IA64_KR(CURRENT)	
	MOV_FROM_IPSR(p0, r29)		
	mov r31=pr			

	MOV_FROM_IIM(r17)		
	mov.m r27=ar.rsc		
	mov r18=__IA64_BREAK_SYSCALL	

	mov.m ar.rsc=0			
	mov.m r21=ar.fpsr		
	mov r19=b6			
	;;
	mov.m r23=ar.bspstore		
	mov.m r24=ar.rnat		
	mov.i r26=ar.pfs		

	invala				
	nop.m 0				
	mov r20=r1			

	nop.m 0
	movl r30=sys_call_table		

	MOV_FROM_IIP(r28)		
	cmp.eq p0,p7=r18,r17		
(p7)	br.cond.spnt non_syscall	




	mov r1=r16			
	mov r2=r16			
	add r9=TI_FLAGS+IA64_TASK_SIZE,r16

	adds r16=IA64_TASK_THREAD_ON_USTACK_OFFSET,r16
	adds r15=-1024,r15		
	mov r3=NR_syscalls - 1
	;;
	ld1.bias r17=[r16]		
	ld4 r9=[r9]			
	extr.u r8=r29,41,2		

	shladd r30=r15,3,r30		
	addl r22=IA64_RBS_OFFSET,r1	
	cmp.leu p6,p7=r15,r3		
	;;

	lfetch.fault.excl.nt1 [r22]	
(p6)	ld8 r30=[r30]			
	tnat.nz.or p7,p0=r15		

	mov.m ar.bspstore=r22		
	cmp.eq p8,p9=2,r8		
	;;

(p8)	mov r8=0			
(p7)	movl r30=sys_ni_syscall		

(p8)	adds r28=16,r28			
(p9)	adds r8=1,r8			
#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
	;;
	mov b6=r30			
#else
	nop.i 0
	;;
#endif

	mov.m r25=ar.unat		
	dep r29=r8,r29,41,2		
	adds r15=1024,r15		




	st1 [r16]=r0			
#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
	MOV_FROM_ITC(p0, p14, r30, r18)	
#else
	mov b6=r30			
#endif
	cmp.eq pKStk,pUStk=r0,r17	

	and r9=_TIF_SYSCALL_TRACEAUDIT,r9
	mov r18=ar.bsp			
(pKStk)	br.cond.spnt .break_fixup	
	;;
.back_from_break_fixup:
(pUStk)	addl r1=IA64_STK_OFFSET-IA64_PT_REGS_SIZE,r1 // A    compute base of memory stack
	cmp.eq p14,p0=r9,r0		
	br.call.sptk.many b7=ia64_syscall_setup
1:
#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE

	add r16=TI_AC_STAMP+IA64_TASK_SIZE,r13
	add r17=TI_AC_LEAVE+IA64_TASK_SIZE,r13
(pKStk)	br.cond.spnt .skip_accounting	
	;;
	ld8 r18=[r16],TI_AC_STIME-TI_AC_STAMP
	ld8 r19=[r17],TI_AC_UTIME-TI_AC_LEAVE
	;;
	ld8 r20=[r16],TI_AC_STAMP-TI_AC_STIME
	ld8 r21=[r17]			
	sub r22=r19,r18			
	;;
	st8 [r16]=r30,TI_AC_STIME-TI_AC_STAMP
	sub r18=r30,r19			
	;;
	add r20=r20,r22			
	add r21=r21,r18			
	;;
	st8 [r16]=r20			
	st8 [r17]=r21			
	;;
.skip_accounting:
#endif
	mov ar.rsc=0x3			
	nop 0
	BSW_1(r2, r14)			
	;;

	SSM_PSR_IC_AND_DEFAULT_BITS_AND_SRLZ_I(r3, r16)
					
	movl r3=ia64_ret_from_syscall	
	;;
	mov rp=r3			
(p10)	br.cond.spnt.many ia64_ret_from_syscall

	SSM_PSR_I(p15, p15, r16)	
(p14)	br.call.sptk.many b6=b6		
	br.cond.spnt.many ia64_trace_syscall




.break_fixup:
	add r1=-IA64_PT_REGS_SIZE,sp	
	mov ar.rnat=r24			
	;;
	mov ar.bspstore=r23		
	br.cond.sptk .back_from_break_fixup
END(break_fault)

	.org ia64_ivt+0x3000
ENTRY(interrupt)
	/* interrupt handler has become too big to fit this area. */
	br.sptk.many __interrupt
END(interrupt)

	.org ia64_ivt+0x3400
	DBG_FAULT(13)
	FAULT(13)

	.org ia64_ivt+0x3800
	DBG_FAULT(14)
	FAULT(14)

	/*
	 * There is no particular reason for this code to be here, other than that
	 * there happens to be space here that would go unused otherwise.  If this
	 * fault ever gets "unreserved", simply moved the following code to a more
	 * suitable spot...
	 *
	 * ia64_syscall_setup() is a separate subroutine so that it can
	 *	allocate stacked registers so it can safely demine any
	 *	potential NaT values from the input registers.
	 *
	 * On entry:
	 *	- executing on bank 0 or bank 1 register set (doesn't matter)
	 *	-  r1: stack pointer
	 *	-  r2: current task pointer
	 *	-  r3: preserved
	 *	- r11: original contents (saved ar.pfs to be saved)
	 *	- r12: original contents (sp to be saved)
	 *	- r13: original contents (tp to be saved)
	 *	- r15: original contents (syscall # to be saved)
	 *	- r18: saved bsp (after switching to kernel stack)
	 *	- r19: saved b6
	 *	- r20: saved r1 (gp)
	 *	- r21: saved ar.fpsr
	 *	- r22: kernel's register backing store base (krbs_base)
	 *	- r23: saved ar.bspstore
	 *	- r24: saved ar.rnat
	 *	- r25: saved ar.unat
	 *	- r26: saved ar.pfs
	 *	- r27: saved ar.rsc
	 *	- r28: saved cr.iip
	 *	- r29: saved cr.ipsr
	 *	- r30: ar.itc for accounting (don't touch)
	 *	- r31: saved pr
	 *	-  b0: original contents (to be saved)
	 * On exit:
	 *	-  p10: TRUE if syscall is invoked with more than 8 out
	 *		registers or r15's Nat is true
	 *	-  r1: kernel's gp
	 *	-  r3: preserved (same as on entry)
	 *	-  r8: -EINVAL if p10 is true
	 *	- r12: points to kernel stack
	 *	- r13: points to current task
	 *	- r14: preserved (same as on entry)
	 *	- p13: preserved
	 *	- p15: TRUE if interrupts need to be re-enabled
	 *	- ar.fpsr: set to kernel settings
	 *	-  b6: preserved (same as on entry)
	 */
#ifdef __IA64_ASM_PARAVIRTUALIZED_NATIVE
GLOBAL_ENTRY(ia64_syscall_setup)
#if PT(B6) != 0
# error This code assumes that b6 is the first field in pt_regs.
#endif
	st8 [r1]=r19			
	add r16=PT(CR_IPSR),r1		
	add r17=PT(R11),r1		
	;;
	alloc r19=ar.pfs,8,0,0,0	
	st8 [r16]=r29,PT(AR_PFS)-PT(CR_IPSR)
	tnat.nz p8,p0=in0

	st8.spill [r17]=r11,PT(CR_IIP)-PT(R11)
	tnat.nz p9,p0=in1
(pKStk)	mov r18=r0			
	;;

	st8 [r16]=r26,PT(CR_IFS)-PT(AR_PFS)
	st8 [r17]=r28,PT(AR_UNAT)-PT(CR_IIP)
	mov r28=b0			
	;;

	st8 [r17]=r25,PT(AR_RSC)-PT(AR_UNAT)
	dep r19=0,r19,38,26		
(p8)	mov in0=-1
	;;

	st8 [r16]=r19,PT(AR_RNAT)-PT(CR_IFS)
	extr.u r11=r19,7,7
	and r8=0x7f,r19	

	st8 [r17]=r27,PT(AR_BSPSTORE)-PT(AR_RSC)// save ar.rsc
	tbit.nz p15,p0=r29,IA64_PSR_I_BIT // I0
(p9)	mov in1=-1
	;;

(pUStk) sub r18=r18,r22			
	tnat.nz p10,p0=in2
	add r11=8,r11
	;;
(pKStk) adds r16=PT(PR)-PT(AR_RNAT),r16	
(pKStk) adds r17=PT(B0)-PT(AR_BSPSTORE),r17
	tnat.nz p11,p0=in3
	;;
(p10)	mov in2=-1
	tnat.nz p12,p0=in4			
(p11)	mov in3=-1
	;;
(pUStk) st8 [r16]=r24,PT(PR)-PT(AR_RNAT)
(pUStk) st8 [r17]=r23,PT(B0)-PT(AR_BSPSTORE)
	shl r18=r18,16			
	;;
	st8 [r16]=r31,PT(LOADRS)-PT(PR)	
	st8 [r17]=r28,PT(R1)-PT(B0)	
	tnat.nz p13,p0=in5			
	;;
	st8 [r16]=r18,PT(R12)-PT(LOADRS)
	st8.spill [r17]=r20,PT(R13)-PT(R1)
(p12)	mov in4=-1
	;;

.mem.offset 0,0; st8.spill [r16]=r12,PT(AR_FPSR)-PT(R12)
.mem.offset 8,0; st8.spill [r17]=r13,PT(R15)-PT(R13)	
(p13)	mov in5=-1
	;;
	st8 [r16]=r21,PT(R8)-PT(AR_FPSR)
	tnat.nz p13,p0=in6
	cmp.lt p10,p9=r11,r8
	;;
	mov r8=1
(p9)	tnat.nz p10,p0=r15
	adds r12=-16,r1	

	st8.spill [r17]=r15		
	tnat.nz p8,p0=in7
	nop.i 0

	mov r13=r2			
	movl r1=__gp			
	;;
	st8 [r16]=r8	
(p13)	mov in6=-1
(p8)	mov in7=-1

	cmp.eq pSys,pNonSys=r0,r0	
	movl r17=FPSR_DEFAULT
	;;
	mov.m ar.fpsr=r17		
(p10)	mov r8=-EINVAL
	br.ret.sptk.many b7
END(ia64_syscall_setup)
#endif /* __IA64_ASM_PARAVIRTUALIZED_NATIVE */

	.org ia64_ivt+0x3c00
	DBG_FAULT(15)
	FAULT(15)

	.org ia64_ivt+0x4000
	DBG_FAULT(16)
	FAULT(16)

#if defined(CONFIG_VIRT_CPU_ACCOUNTING_NATIVE) && defined(__IA64_ASM_PARAVIRTUALIZED_NATIVE)
	/*
	 * There is no particular reason for this code to be here, other than
	 * that there happens to be space here that would go unused otherwise.
	 * If this fault ever gets "unreserved", simply moved the following
	 * code to a more suitable spot...
	 *
	 * account_sys_enter is called from SAVE_MIN* macros if accounting is
	 * enabled and if the macro is entered from user mode.
	 */
GLOBAL_ENTRY(account_sys_enter)

	add r16=TI_AC_STAMP+IA64_TASK_SIZE,r13
	add r17=TI_AC_LEAVE+IA64_TASK_SIZE,r13
	;;
	ld8 r18=[r16],TI_AC_STIME-TI_AC_STAMP
	ld8 r19=[r17],TI_AC_UTIME-TI_AC_LEAVE
        ;;
	ld8 r23=[r16],TI_AC_STAMP-TI_AC_STIME
	ld8 r21=[r17]			
	sub r22=r19,r18			
	;;
	st8 [r16]=r20,TI_AC_STIME-TI_AC_STAMP
	sub r18=r20,r19			
	;;
	add r23=r23,r22			
	add r21=r21,r18			
	;;
	st8 [r16]=r23			
	st8 [r17]=r21			
	;;
	br.ret.sptk.many rp
END(account_sys_enter)
#endif

	.org ia64_ivt+0x4400
	DBG_FAULT(17)
	FAULT(17)

	.org ia64_ivt+0x4800
	DBG_FAULT(18)
	FAULT(18)

	.org ia64_ivt+0x4c00
	DBG_FAULT(19)
	FAULT(19)


	.org ia64_ivt+0x5000
ENTRY(page_not_present)
	DBG_FAULT(20)
	MOV_FROM_IFA(r16)
	RSM_PSR_DT
	/*
	 * The Linux page fault handler doesn't expect non-present pages to be in
	 * the TLB.  Flush the existing entry now, so we meet that expectation.
	 */
	mov r17=PAGE_SHIFT<<2
	;;
	ptc.l r16,r17
	;;
	mov r31=pr
	srlz.d
	br.sptk.many page_fault
END(page_not_present)

	.org ia64_ivt+0x5100
ENTRY(key_permission)
	DBG_FAULT(21)
	MOV_FROM_IFA(r16)
	RSM_PSR_DT
	mov r31=pr
	;;
	srlz.d
	br.sptk.many page_fault
END(key_permission)

	.org ia64_ivt+0x5200
ENTRY(iaccess_rights)
	DBG_FAULT(22)
	MOV_FROM_IFA(r16)
	RSM_PSR_DT
	mov r31=pr
	;;
	srlz.d
	br.sptk.many page_fault
END(iaccess_rights)

	.org ia64_ivt+0x5300
ENTRY(daccess_rights)
	DBG_FAULT(23)
	MOV_FROM_IFA(r16)
	RSM_PSR_DT
	mov r31=pr
	;;
	srlz.d
	br.sptk.many page_fault
END(daccess_rights)

	.org ia64_ivt+0x5400
ENTRY(general_exception)
	DBG_FAULT(24)
	MOV_FROM_ISR(r16)
	mov r31=pr
	;;
	cmp4.eq p6,p0=0,r16
(p6)	br.sptk.many dispatch_illegal_op_fault
	;;
	mov r19=24	
	br.sptk.many dispatch_to_fault_handler
END(general_exception)

	.org ia64_ivt+0x5500
ENTRY(disabled_fp_reg)
	DBG_FAULT(25)
	rsm psr.dfh	
	;;
	srlz.d
	mov r31=pr
	mov r19=25
	br.sptk.many dispatch_to_fault_handler
END(disabled_fp_reg)

	.org ia64_ivt+0x5600
ENTRY(nat_consumption)
	DBG_FAULT(26)

	MOV_FROM_IPSR(p0, r16)
	MOV_FROM_ISR(r17)
	mov r31=pr			
	;;
	and r18=0xf,r17			
	tbit.z p6,p0=r17,IA64_ISR_NA_BIT
	;;
	cmp.ne.or p6,p0=IA64_ISR_CODE_LFETCH,r18
	dep r16=-1,r16,IA64_PSR_ED_BIT,1
(p6)	br.cond.spnt 1f	
	;;
	MOV_TO_IPSR(p0, r16, r18)
	mov pr=r31,-1
	;;
	RFI

1:	mov pr=r31,-1
	;;
	FAULT(26)
END(nat_consumption)

	.org ia64_ivt+0x5700
ENTRY(speculation_vector)
	DBG_FAULT(27)
	/*
	 * A [f]chk.[as] instruction needs to take the branch to the recovery code but
	 * this part of the architecture is not implemented in hardware on some CPUs, such
	 * as Itanium.  Thus, in general we need to emulate the behavior.  IIM contains
	 * the relative target (not yet sign extended).  So after sign extending it we
	 * simply add it to IIP.  We also need to reset the EI field of the IPSR to zero,
	 * i.e., the slot to restart into.
	 *
	 * cr.imm contains zero_ext(imm21)
	 */
	MOV_FROM_IIM(r18)
	;;
	MOV_FROM_IIP(r17)
	shl r18=r18,43		
	;;

	MOV_FROM_IPSR(p0, r16)
	shr r18=r18,39		
	;;

	add r17=r17,r18		
	;;
	MOV_TO_IIP(r17, r19)
	dep r16=0,r16,41,2	
	;;

	MOV_TO_IPSR(p0, r16, r19)
	;;

	RFI
END(speculation_vector)

	.org ia64_ivt+0x5800
	DBG_FAULT(28)
	FAULT(28)

	.org ia64_ivt+0x5900
ENTRY(debug_vector)
	DBG_FAULT(29)
	FAULT(29)
END(debug_vector)

	.org ia64_ivt+0x5a00
ENTRY(unaligned_access)
	DBG_FAULT(30)
	mov r31=pr	
	;;
	br.sptk.many dispatch_unaligned_handler
END(unaligned_access)

	.org ia64_ivt+0x5b00
ENTRY(unsupported_data_reference)
	DBG_FAULT(31)
	FAULT(31)
END(unsupported_data_reference)

	.org ia64_ivt+0x5c00
ENTRY(floating_point_fault)
	DBG_FAULT(32)
	FAULT(32)
END(floating_point_fault)

	.org ia64_ivt+0x5d00
ENTRY(floating_point_trap)
	DBG_FAULT(33)
	FAULT(33)
END(floating_point_trap)

	.org ia64_ivt+0x5e00
ENTRY(lower_privilege_trap)
	DBG_FAULT(34)
	FAULT(34)
END(lower_privilege_trap)

	.org ia64_ivt+0x5f00
ENTRY(taken_branch_trap)
	DBG_FAULT(35)
	FAULT(35)
END(taken_branch_trap)

	.org ia64_ivt+0x6000
ENTRY(single_step_trap)
	DBG_FAULT(36)
	FAULT(36)
END(single_step_trap)

	.org ia64_ivt+0x6100
	DBG_FAULT(37)
	FAULT(37)

	.org ia64_ivt+0x6200
	DBG_FAULT(38)
	FAULT(38)

	.org ia64_ivt+0x6300
	DBG_FAULT(39)
	FAULT(39)

	.org ia64_ivt+0x6400
	DBG_FAULT(40)
	FAULT(40)

	.org ia64_ivt+0x6500
	DBG_FAULT(41)
	FAULT(41)

	.org ia64_ivt+0x6600
	DBG_FAULT(42)
	FAULT(42)

	.org ia64_ivt+0x6700
	DBG_FAULT(43)
	FAULT(43)

	.org ia64_ivt+0x6800
	DBG_FAULT(44)
	FAULT(44)

	.org ia64_ivt+0x6900
ENTRY(ia32_exception)
	DBG_FAULT(45)
	FAULT(45)
END(ia32_exception)

	.org ia64_ivt+0x6a00
ENTRY(ia32_intercept)
	DBG_FAULT(46)
	FAULT(46)
END(ia32_intercept)

	.org ia64_ivt+0x6b00
ENTRY(ia32_interrupt)
	DBG_FAULT(47)
	FAULT(47)
END(ia32_interrupt)

	.org ia64_ivt+0x6c00
	DBG_FAULT(48)
	FAULT(48)

	.org ia64_ivt+0x6d00
	DBG_FAULT(49)
	FAULT(49)

	.org ia64_ivt+0x6e00
	DBG_FAULT(50)
	FAULT(50)

	.org ia64_ivt+0x6f00
	DBG_FAULT(51)
	FAULT(51)

	.org ia64_ivt+0x7000
	DBG_FAULT(52)
	FAULT(52)

	.org ia64_ivt+0x7100
	DBG_FAULT(53)
	FAULT(53)

	.org ia64_ivt+0x7200
	DBG_FAULT(54)
	FAULT(54)

	.org ia64_ivt+0x7300
	DBG_FAULT(55)
	FAULT(55)

	.org ia64_ivt+0x7400
	DBG_FAULT(56)
	FAULT(56)

	.org ia64_ivt+0x7500
	DBG_FAULT(57)
	FAULT(57)

	.org ia64_ivt+0x7600
	DBG_FAULT(58)
	FAULT(58)

	.org ia64_ivt+0x7700
	DBG_FAULT(59)
	FAULT(59)

	.org ia64_ivt+0x7800
	DBG_FAULT(60)
	FAULT(60)

	.org ia64_ivt+0x7900
	DBG_FAULT(61)
	FAULT(61)

	.org ia64_ivt+0x7a00
	DBG_FAULT(62)
	FAULT(62)

	.org ia64_ivt+0x7b00
	DBG_FAULT(63)
	FAULT(63)

	.org ia64_ivt+0x7c00
	DBG_FAULT(64)
	FAULT(64)

	.org ia64_ivt+0x7d00
	DBG_FAULT(65)
	FAULT(65)

	.org ia64_ivt+0x7e00
	DBG_FAULT(66)
	FAULT(66)

	.org ia64_ivt+0x7f00
	DBG_FAULT(67)
	FAULT(67)



ENTRY(page_fault)
	SSM_PSR_DT_AND_SRLZ_I
	;;
	SAVE_MIN_WITH_COVER
	alloc r15=ar.pfs,0,0,3,0
	MOV_FROM_IFA(out0)
	MOV_FROM_ISR(out1)
	SSM_PSR_IC_AND_DEFAULT_BITS_AND_SRLZ_I(r14, r3)
	adds r3=8,r2			
	SSM_PSR_I(p15, p15, r14)	
	movl r14=ia64_leave_kernel
	;;
	SAVE_REST
	mov rp=r14
	;;
	adds out2=16,r12		
	br.call.sptk.many b6=ia64_do_page_fault
END(page_fault)

ENTRY(non_syscall)
	mov ar.rsc=r27		
	;;
	SAVE_MIN_WITH_COVER






	alloc r14=ar.pfs,0,0,2,0
	MOV_FROM_IIM(out0)
	add out1=16,sp
	adds r3=8,r2		

	SSM_PSR_IC_AND_DEFAULT_BITS_AND_SRLZ_I(r15, r24)
				
	SSM_PSR_I(p15, p15, r15)
	movl r15=ia64_leave_kernel
	;;
	SAVE_REST
	mov rp=r15
	;;
	br.call.sptk.many b6=ia64_bad_break
END(non_syscall)

ENTRY(__interrupt)
	DBG_FAULT(12)
	mov r31=pr	
	;;
	SAVE_MIN_WITH_COVER
	SSM_PSR_IC_AND_DEFAULT_BITS_AND_SRLZ_I(r3, r14)
			
	adds r3=8,r2	
	;;
	SAVE_REST
	;;
	MCA_RECOVER_RANGE(interrupt)
	alloc r14=ar.pfs,0,0,2,0 // must be first in an insn group
	MOV_FROM_IVR(out0, r8)
	add out1=16,sp	
	;;
	srlz.d		
	movl r14=ia64_leave_kernel
	;;
	mov rp=r14
	br.call.sptk.many b6=ia64_handle_irq
END(__interrupt)

	/*
	 * There is no particular reason for this code to be here, other than that
	 * there happens to be space here that would go unused otherwise.  If this
	 * fault ever gets "unreserved", simply moved the following code to a more
	 * suitable spot...
	 */

ENTRY(dispatch_unaligned_handler)
	SAVE_MIN_WITH_COVER
	;;
	alloc r14=ar.pfs,0,0,2,0	
	MOV_FROM_IFA(out0)
	adds out1=16,sp

	SSM_PSR_IC_AND_DEFAULT_BITS_AND_SRLZ_I(r3, r24)
					
	SSM_PSR_I(p15, p15, r3)		
	adds r3=8,r2			
	;;
	SAVE_REST
	movl r14=ia64_leave_kernel
	;;
	mov rp=r14
	br.sptk.many ia64_prepare_handle_unaligned
END(dispatch_unaligned_handler)

	/*
	 * There is no particular reason for this code to be here, other than that
	 * there happens to be space here that would go unused otherwise.  If this
	 * fault ever gets "unreserved", simply moved the following code to a more
	 * suitable spot...
	 */

ENTRY(dispatch_to_fault_handler)
	/*
	 * Input:
	 *	psr.ic:	off
	 *	r19:	fault vector number (e.g., 24 for General Exception)
	 *	r31:	contains saved predicates (pr)
	 */
	SAVE_MIN_WITH_COVER_R19
	alloc r14=ar.pfs,0,0,5,0
	MOV_FROM_ISR(out1)
	MOV_FROM_IFA(out2)
	MOV_FROM_IIM(out3)
	MOV_FROM_ITIR(out4)
	;;
	SSM_PSR_IC_AND_DEFAULT_BITS_AND_SRLZ_I(r3, out0)
					
	mov out0=r15
	;;
	SSM_PSR_I(p15, p15, r3)		
	adds r3=8,r2			
	;;
	SAVE_REST
	movl r14=ia64_leave_kernel
	;;
	mov rp=r14
	br.call.sptk.many b6=ia64_fault
END(dispatch_to_fault_handler)

	/*
	 * Squatting in this space ...
	 *
	 * This special case dispatcher for illegal operation faults allows preserved
	 * registers to be modified through a callback function (asm only) that is handed
	 * back from the fault handler in r8. Up to three arguments can be passed to the
	 * callback function by returning an aggregate with the callback as its first
	 * element, followed by the arguments.
	 */
ENTRY(dispatch_illegal_op_fault)
	.prologue
	.body
	SAVE_MIN_WITH_COVER
	SSM_PSR_IC_AND_DEFAULT_BITS_AND_SRLZ_I(r3, r24)
			
	;;
	SSM_PSR_I(p15, p15, r3)
	adds r3=8,r2
	;;
	alloc r14=ar.pfs,0,0,1,0
	mov out0=ar.ec
	;;
	SAVE_REST
	PT_REGS_UNWIND_INFO(0)
	;;
	br.call.sptk.many rp=ia64_illegal_op_fault
.ret0:	;;
	alloc r14=ar.pfs,0,0,3,0
	mov out0=r9
	mov out1=r10
	mov out2=r11
	movl r15=ia64_leave_kernel
	;;
	mov rp=r15
	mov b6=r8
	;;
	cmp.ne p6,p0=0,r8
(p6)	br.call.dpnt.many b6=b6	
	br.sptk.many ia64_leave_kernel
END(dispatch_illegal_op_fault)
