/*
 * This file contains the light-weight system call handlers (fsyscall-handlers).
 *
 * Copyright (C) 2003 Hewlett-Packard Co
 * 	David Mosberger-Tang <davidm@hpl.hp.com>
 *
 * 25-Sep-03 davidm	Implement fsys_rt_sigprocmask().
 * 18-Feb-03 louisk	Implement fsys_gettimeofday().
 * 28-Feb-03 davidm	Fixed several bugs in fsys_gettimeofday().  Tuned it some more,
 *			probably broke it along the way... ;-)
 * 13-Jul-04 clameter   Implement fsys_clock_gettime and revise fsys_gettimeofday to make
 *                      it capable of using memory based clocks without falling back to C code.
 * 08-Feb-07 Fenghua Yu Implement fsys_getcpu.
 *
 */

#include <asm/asmmacro.h>
#include <asm/errno.h>
#include <asm/asm-offsets.h>
#include <asm/percpu.h>
#include <asm/thread_info.h>
#include <asm/sal.h>
#include <asm/signal.h>
#include <asm/unistd.h>

#include "entry.h"
#include "paravirt_inst.h"

/*
 * See Documentation/ia64/fsys.txt for details on fsyscalls.
 *
 * On entry to an fsyscall handler:
 *   r10	= 0 (i.e., defaults to "successful syscall return")
 *   r11	= saved ar.pfs (a user-level value)
 *   r15	= system call number
 *   r16	= "current" task pointer (in normal kernel-mode, this is in r13)
 *   r32-r39	= system call arguments
 *   b6		= return address (a user-level value)
 *   ar.pfs	= previous frame-state (a user-level value)
 *   PSR.be	= cleared to zero (i.e., little-endian byte order is in effect)
 *   all other registers may contain values passed in from user-mode
 *
 * On return from an fsyscall handler:
 *   r11	= saved ar.pfs (as passed into the fsyscall handler)
 *   r15	= system call number (as passed into the fsyscall handler)
 *   r32-r39	= system call arguments (as passed into the fsyscall handler)
 *   b6		= return address (as passed into the fsyscall handler)
 *   ar.pfs	= previous frame-state (as passed into the fsyscall handler)
 */

ENTRY(fsys_ni_syscall)
	.prologue
	.altrp b6
	.body
	mov r8=ENOSYS
	mov r10=-1
	FSYS_RETURN
END(fsys_ni_syscall)

ENTRY(fsys_getpid)
	.prologue
	.altrp b6
	.body
	add r17=IA64_TASK_GROUP_LEADER_OFFSET,r16
	;;
	ld8 r17=[r17]			
	add r9=TI_FLAGS+IA64_TASK_SIZE,r16
	;;
	ld4 r9=[r9]
	add r17=IA64_TASK_TGIDLINK_OFFSET,r17
	;;
	and r9=TIF_ALLWORK_MASK,r9
	ld8 r17=[r17]			
	;;
	add r8=IA64_PID_LEVEL_OFFSET,r17
	;;
	ld4 r8=[r8]			
	add r17=IA64_PID_UPID_OFFSET,r17
	;;
	shl r8=r8,IA64_UPID_SHIFT
	;;
	add r17=r17,r8			
	;;
	ld4 r8=[r17]			
	;;
	mov r17=0
	;;
	cmp.ne p8,p0=0,r9
(p8)	br.spnt.many fsys_fallback_syscall
	FSYS_RETURN
END(fsys_getpid)

ENTRY(fsys_set_tid_address)
	.prologue
	.altrp b6
	.body
	add r9=TI_FLAGS+IA64_TASK_SIZE,r16
	add r17=IA64_TASK_TGIDLINK_OFFSET,r16
	;;
	ld4 r9=[r9]
	tnat.z p6,p7=r32	
	ld8 r17=[r17]			
	;;
	and r9=TIF_ALLWORK_MASK,r9
	add r8=IA64_PID_LEVEL_OFFSET,r17
	add r18=IA64_TASK_CLEAR_CHILD_TID_OFFSET,r16
	;;
	ld4 r8=[r8]			
	add r17=IA64_PID_UPID_OFFSET,r17
	;;
	shl r8=r8,IA64_UPID_SHIFT
	;;
	add r17=r17,r8			
	;;
	ld4 r8=[r17]			
	;;
	cmp.ne p8,p0=0,r9
	mov r17=-1
	;;
(p6)	st8 [r18]=r32
(p7)	st8 [r18]=r17
(p8)	br.spnt.many fsys_fallback_syscall
	;;
	mov r17=0		
	mov r18=0		
	FSYS_RETURN
END(fsys_set_tid_address)

#if IA64_GTOD_SEQ_OFFSET !=0
#error fsys_gettimeofday incompatible with changes to struct fsyscall_gtod_data_t
#endif
#if IA64_ITC_JITTER_OFFSET !=0
#error fsys_gettimeofday incompatible with changes to struct itc_jitter_data_t
#endif
#define CLOCK_REALTIME 0
#define CLOCK_MONOTONIC 1
#define CLOCK_DIVIDE_BY_1000 0x4000
#define CLOCK_ADD_MONOTONIC 0x8000

ENTRY(fsys_gettimeofday)
	.prologue
	.altrp b6
	.body
	mov r31 = r32
	tnat.nz p6,p0 = r33	
(p6)    br.cond.spnt.few .fail_einval
	mov r30 = CLOCK_DIVIDE_BY_1000
	;;
.gettime:











































	add r2 = TI_FLAGS+IA64_TASK_SIZE,r16
	tnat.nz p6,p0 = r31	
(p6)	br.cond.spnt.few .fail_einval
	movl r20 = fsyscall_gtod_data // load fsyscall gettimeofday data address
	;;
	ld4 r2 = [r2]		
	movl r29 = itc_jitter_data
	add r22 = IA64_GTOD_WALL_TIME_OFFSET,r20
	add r21 = IA64_CLKSRC_MMIO_OFFSET,r20
	mov pr = r30,0xc000
	;;
	and r2 = TIF_ALLWORK_MASK,r2
	add r19 = IA64_ITC_LASTCYCLE_OFFSET,r29
(p15)	add r22 = IA64_GTOD_MONO_TIME_OFFSET,r20
	;;
	add r26 = IA64_CLKSRC_CYCLE_LAST_OFFSET,r20
	cmp.ne p6, p0 = 0, r2
(p6)	br.cond.spnt.many fsys_fallback_syscall
	;;

.time_redo:
	ld4.acq r28 = [r20]
	;;
	and r28 = ~1,r28
	;;
	ld8 r30 = [r21]	
	add r24 = IA64_CLKSRC_MULT_OFFSET,r20
	ld4 r2 = [r29]	
	add r23 = IA64_CLKSRC_SHIFT_OFFSET,r20
	add r14 = IA64_CLKSRC_MASK_OFFSET,r20
	;;
	ld4 r3 = [r24]	
	ld8 r14 = [r14]         // clocksource mask value
	cmp.eq p8,p9 = 0,r30
	;;
	setf.sig f7 = r3
(p8)	cmp.ne p13,p0 = r2,r0
	ld4 r23 = [r23]	
	ld8 r24 = [r26]	
(p9)	cmp.eq p13,p0 = 0,r30
	;;
	.pred.rel.mutex p8,p9
	MOV_FROM_ITC(p8, p6, r2, r10)
(p9)	ld8 r2 = [r30]	
(p13)	ld8 r25 = [r19]	
	ld8 r9 = [r22],IA64_TIMESPEC_TV_NSEC_OFFSET
	;;
	ld8 r8 = [r22],-IA64_TIMESPEC_TV_NSEC_OFFSET
(p13)	sub r3 = r25,r2	
	;;
(p13)	cmp.gt.unc p6,p7 = r3,r0 // check if it is less than last. p6,p7 cleared
	sub r10 = r2,r24
	;;
(p6)	sub r10 = r25,r24
(p7)	mov ar.ccv = r25
	;;
(p7)	cmpxchg8.rel r3 = [r19],r2,ar.ccv
	;;
(p7)	cmp.ne p7,p0 = r25,r3
	;;
(p7)	sub r10 = r3,r24
	;;
	and r10 = r10,r14
	;;
	setf.sig f8 = r10
	nop.i 123
	;;

EX(.fail_efault, probe.w.fault r31, 3)
	xmpy.l f8 = f8,f7
	;;
	getf.sig r2 = f8
	mf
	;;
	ld4 r10 = [r20]	
	shr.u r2 = r2,r23
	;;
	add r8 = r8,r2	
	cmp4.ne p7,p0 = r28,r10
(p7)	br.cond.dpnt.few .time_redo


	mov r10 = r0
	movl r2 = 1000000000
	add r23 = IA64_TIMESPEC_TV_NSEC_OFFSET, r31
(p14)	movl r3 = 2361183241434822607
	;;
.time_normalize:
	mov r21 = r8
	cmp.ge p6,p0 = r8,r2
(p14)	shr.u r20 = r8, 3 // We can repeat this if necessary just wasting time
	;;
(p14)	setf.sig f8 = r20
(p6)	sub r8 = r8,r2
(p6)	add r9 = 1,r9	
(p14)	setf.sig f7 = r3
(p6)	br.cond.dpnt.few .time_normalize
	;;



EX(.fail_efault, probe.w.fault r23, 3)
(p14)	xmpy.hu f8 = f8, f7	
	;;
(p14)	getf.sig r2 = f8
	;;
	mov r8 = r0
(p14)	shr.u r21 = r2, 4
	;;
EX(.fail_efault, st8 [r31] = r9)
EX(.fail_efault, st8 [r23] = r21)
	FSYS_RETURN
.fail_einval:
	mov r8 = EINVAL
	mov r10 = -1
	FSYS_RETURN
.fail_efault:
	mov r8 = EFAULT
	mov r10 = -1
	FSYS_RETURN
END(fsys_gettimeofday)

ENTRY(fsys_clock_gettime)
	.prologue
	.altrp b6
	.body
	cmp4.ltu p6, p0 = CLOCK_MONOTONIC, r32

(p6)	br.spnt.few fsys_fallback_syscall
	mov r31 = r33
	shl r30 = r32,15
	br.many .gettime
END(fsys_clock_gettime)

/*
 * fsys_getcpu doesn't use the third parameter in this implementation. It reads
 * current_thread_info()->cpu and corresponding node in cpu_to_node_map.
 */
ENTRY(fsys_getcpu)
	.prologue
	.altrp b6
	.body
	;;
	add r2=TI_FLAGS+IA64_TASK_SIZE,r16
	tnat.nz p6,p0 = r32		
	add r3=TI_CPU+IA64_TASK_SIZE,r16
	;;
	ld4 r3=[r3]			
	ld4 r2=[r2]			
(p6)    br.cond.spnt.few .fail_einval	
	;;
	tnat.nz p7,p0 = r33		
(p7)    br.cond.spnt.few .fail_einval	
	;;
	cmp.ne p6,p0=r32,r0
	cmp.ne p7,p0=r33,r0
	;;
#ifdef CONFIG_NUMA
	movl r17=cpu_to_node_map
	;;
EX(.fail_efault, (p6) probe.w.fault r32, 3)	
EX(.fail_efault, (p7) probe.w.fault r33, 3)	
	shladd r18=r3,1,r17
	;;
	ld2 r20=[r18]			
	and r2 = TIF_ALLWORK_MASK,r2
	;;
	cmp.ne p8,p0=0,r2
(p8)	br.spnt.many fsys_fallback_syscall
	;;
	;;
EX(.fail_efault, (p6) st4 [r32] = r3)
EX(.fail_efault, (p7) st2 [r33] = r20)
	mov r8=0
	;;
#else
EX(.fail_efault, (p6) probe.w.fault r32, 3)	
EX(.fail_efault, (p7) probe.w.fault r33, 3)	
	and r2 = TIF_ALLWORK_MASK,r2
	;;
	cmp.ne p8,p0=0,r2
(p8)	br.spnt.many fsys_fallback_syscall
	;;
EX(.fail_efault, (p6) st4 [r32] = r3)
EX(.fail_efault, (p7) st2 [r33] = r0)
	mov r8=0
	;;
#endif
	FSYS_RETURN
END(fsys_getcpu)

ENTRY(fsys_fallback_syscall)
	.prologue
	.altrp b6
	.body
	/*
	 * We only get here from light-weight syscall handlers.  Thus, we already
	 * know that r15 contains a valid syscall number.  No need to re-check.
	 */
	adds r17=-1024,r15
	movl r14=sys_call_table
	;;
	RSM_PSR_I(p0, r26, r27)
	shladd r18=r17,3,r14
	;;
	ld8 r18=[r18]			
	MOV_FROM_PSR(p0, r29, r26)	
	mov r27=ar.rsc
	mov r21=ar.fpsr
	mov r26=ar.pfs
END(fsys_fallback_syscall)
	/* FALL THROUGH */
GLOBAL_ENTRY(paravirt_fsys_bubble_down)
	.prologue
	.altrp b6
	.body
	/*
	 * We get here for syscalls that don't have a lightweight
	 * handler.  For those, we need to bubble down into the kernel
	 * and that requires setting up a minimal pt_regs structure,
	 * and initializing the CPU state more or less as if an
	 * interruption had occurred.  To make syscall-restarts work,
	 * we setup pt_regs such that cr_iip points to the second
	 * instruction in syscall_via_break.  Decrementing the IP
	 * hence will restart the syscall via break and not
	 * decrementing IP will return us to the caller, as usual.
	 * Note that we preserve the value of psr.pp rather than
	 * initializing it from dcr.pp.  This makes it possible to
	 * distinguish fsyscall execution from other privileged
	 * execution.
	 *
	 * On entry:
	 *	- normal fsyscall handler register usage, except
	 *	  that we also have:
	 *	- r18: address of syscall entry point
	 *	- r21: ar.fpsr
	 *	- r26: ar.pfs
	 *	- r27: ar.rsc
	 *	- r29: psr
	 *
	 * We used to clear some PSR bits here but that requires slow
	 * serialization.  Fortuntely, that isn't really necessary.
	 * The rationale is as follows: we used to clear bits
	 * ~PSR_PRESERVED_BITS in PSR.L.  Since
	 * PSR_PRESERVED_BITS==PSR.{UP,MFL,MFH,PK,DT,PP,SP,RT,IC}, we
	 * ended up clearing PSR.{BE,AC,I,DFL,DFH,DI,DB,SI,TB}.
	 * However,
	 *
	 * PSR.BE : already is turned off in __kernel_syscall_via_epc()
	 * PSR.AC : don't care (kernel normally turns PSR.AC on)
	 * PSR.I  : already turned off by the time paravirt_fsys_bubble_down gets
	 *	    invoked
	 * PSR.DFL: always 0 (kernel never turns it on)
	 * PSR.DFH: don't care --- kernel never touches f32-f127 on its own
	 *	    initiative
	 * PSR.DI : always 0 (kernel never turns it on)
	 * PSR.SI : always 0 (kernel never turns it on)
	 * PSR.DB : don't care --- kernel never enables kernel-level
	 *	    breakpoints
	 * PSR.TB : must be 0 already; if it wasn't zero on entry to
	 *          __kernel_syscall_via_epc, the branch to paravirt_fsys_bubble_down
	 *          will trigger a taken branch; the taken-trap-handler then
	 *          converts the syscall into a break-based system-call.
	 */
	/*
	 * Reading psr.l gives us only bits 0-31, psr.it, and psr.mc.
	 * The rest we have to synthesize.
	 */
#	define PSR_ONE_BITS		((3 << IA64_PSR_CPL0_BIT)	\
					 | (0x1 << IA64_PSR_RI_BIT)	\
					 | IA64_PSR_BN | IA64_PSR_I)

	invala				
	movl r14=ia64_ret_from_syscall	

	nop.m 0
	movl r28=__kernel_syscall_via_break
	;;

	mov r2=r16			
	adds r16=IA64_TASK_THREAD_ON_USTACK_OFFSET,r16 // A
	mov r31=pr			
	;;
	st1 [r16]=r0			
	addl r22=IA64_RBS_OFFSET,r2	
	add r3=TI_FLAGS+IA64_TASK_SIZE,r2
	;;
	ld4 r3=[r3]			
	lfetch.fault.excl.nt1 [r22]	
	nop.i 0
	;;
	mov ar.rsc=0			
#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
	MOV_FROM_ITC(p0, p6, r30, r23)	
#else
	nop.m 0
#endif
	nop.i 0
	;;
	mov r23=ar.bspstore		
	mov.m r24=ar.rnat		
	nop.i 0
	;;
	mov ar.bspstore=r22		
	movl r8=PSR_ONE_BITS		
	;;
	mov r25=ar.unat			
	mov r19=b6			
	mov r20=r1			
	;;
	or r29=r8,r29			
	mov b6=r18			
	addl r1=IA64_STK_OFFSET-IA64_PT_REGS_SIZE,r2 // A compute base of memory stack

	mov r18=ar.bsp			
	cmp.ne pKStk,pUStk=r0,r0	
	br.call.sptk.many b7=ia64_syscall_setup
	;;
#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE

	add r16=TI_AC_STAMP+IA64_TASK_SIZE,r2
	add r17=TI_AC_LEAVE+IA64_TASK_SIZE,r2
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
#endif
	mov ar.rsc=0x3			
	mov rp=r14			
	and r3=_TIF_SYSCALL_TRACEAUDIT,r3
	;;
	SSM_PSR_I(p0, p6, r22)		
	cmp.eq p8,p0=r3,r0		
(p10)	br.cond.spnt.many ia64_ret_from_syscall

	nop.m 0
(p8)	br.call.sptk.many b6=b6		
	br.cond.spnt ia64_trace_syscall	
END(paravirt_fsys_bubble_down)

	.rodata
	.align 8
	.globl paravirt_fsyscall_table

	data8 paravirt_fsys_bubble_down
paravirt_fsyscall_table:
	data8 fsys_ni_syscall
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 fsys_getpid	
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 fsys_gettimeofday	
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0					 	
	data8 0
	data8 0
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0
	data8 0			
	data8 0			
	data8 0						
	data8 0
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0
	data8 0
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 fsys_set_tid_address
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 fsys_clock_gettime
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0
	data8 0						
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0			
	data8 0
	data8 fsys_getcpu	


	.zero:
	.space paravirt_fsyscall_table + 8*NR_syscalls - .zero, 0
