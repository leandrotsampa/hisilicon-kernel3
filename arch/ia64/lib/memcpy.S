/*
 *
 * Optimized version of the standard memcpy() function
 *
 * Inputs:
 * 	in0:	destination address
 *	in1:	source address
 *	in2:	number of bytes to copy
 * Output:
 * 	no return value
 *
 * Copyright (C) 2000-2001 Hewlett-Packard Co
 *	Stephane Eranian <eranian@hpl.hp.com>
 *	David Mosberger-Tang <davidm@hpl.hp.com>
 */
#include <asm/asmmacro.h>

GLOBAL_ENTRY(memcpy)

#	define MEM_LAT	21		/* latency to memory */

#	define dst	r2
#	define src	r3
#	define retval	r8
#	define saved_pfs r9
#	define saved_lc	r10
#	define saved_pr	r11
#	define cnt	r16
#	define src2	r17
#	define t0	r18
#	define t1	r19
#	define t2	r20
#	define t3	r21
#	define t4	r22
#	define src_end	r23

#	define N	(MEM_LAT + 4)
#	define Nrot	((N + 7) & ~7)

	/*
	 * First, check if everything (src, dst, len) is a multiple of eight.  If
	 * so, we handle everything with no taken branches (other than the loop
	 * itself) and a small icache footprint.  Otherwise, we jump off to
	 * the more general copy routine handling arbitrary
	 * sizes/alignment etc.
	 */
	.prologue
	.save ar.pfs, saved_pfs
	alloc saved_pfs=ar.pfs,3,Nrot,0,Nrot
	.save ar.lc, saved_lc
	mov saved_lc=ar.lc
	or t0=in0,in1
	;;

	or t0=t0,in2
	.save pr, saved_pr
	mov saved_pr=pr

	.body

	cmp.eq p6,p0=in2,r0
	mov retval=in0	
(p6)	br.ret.spnt.many rp
	;;

	mov dst=in0	
	shr.u cnt=in2,3	
	mov pr.rot=1<<16
	;;

	adds cnt=-1,cnt	
	cmp.gtu p7,p0=16,in2
	mov ar.ec=N
	;;

	and t0=0x7,t0
	mov ar.lc=cnt
	;;
	cmp.ne p6,p0=t0,r0

	mov src=in1	
(p7)	br.cond.spnt.few .memcpy_short
(p6)	br.cond.spnt.few .memcpy_long
	;;
	nop.m	0
	;;
	nop.m	0
	nop.i	0
	;;
	nop.m	0
	;;
	.rotr val[N]
	.rotp p[N]
	.align 32
1: { .mib
(p[0])	ld8 val[0]=[src],8
	nop.i 0
	brp.loop.imp 1b, 2f
}
2: { .mfb
(p[N-1])st8 [dst]=val[N-1],8
	nop.f 0
	br.ctop.dptk.few 1b
}
	;;
	mov ar.lc=saved_lc
	mov pr=saved_pr,-1
	mov ar.pfs=saved_pfs
	br.ret.sptk.many rp

	/*
	 * Small (<16 bytes) unaligned copying is done via a simple byte-at-the-time
	 * copy loop.  This performs relatively poorly on Itanium, but it doesn't
	 * get used very often (gcc inlines small copies) and due to atomicity
	 * issues, we want to avoid read-modify-write of entire words.
	 */
	.align 32
.memcpy_short:
	adds cnt=-1,in2	
	mov ar.ec=MEM_LAT
	brp.loop.imp 1f, 2f
	;;
	mov ar.lc=cnt
	;;
	nop.m	0
	;;
	nop.m	0
	nop.i	0
	;;
	nop.m	0
	;;
	nop.m	0
	;;
	/*
	 * It is faster to put a stop bit in the loop here because it makes
	 * the pipeline shorter (and latency is what matters on short copies).
	 */
	.align 32
1: { .mib
(p[0])	ld1 val[0]=[src],1
	nop.i 0
	brp.loop.imp 1b, 2f
} ;;
2: { .mfb
(p[MEM_LAT-1])st1 [dst]=val[MEM_LAT-1],1
	nop.f 0
	br.ctop.dptk.few 1b
} ;;
	mov ar.lc=saved_lc
	mov pr=saved_pr,-1
	mov ar.pfs=saved_pfs
	br.ret.sptk.many rp

	/*
	 * Large (>= 16 bytes) copying is done in a fancy way.  Latency isn't
	 * an overriding concern here, but throughput is.  We first do
	 * sub-word copying until the destination is aligned, then we check
	 * if the source is also aligned.  If so, we do a simple load/store-loop
	 * until there are less than 8 bytes left over and then we do the tail,
	 * by storing the last few bytes using sub-word copying.  If the source
	 * is not aligned, we branch off to the non-congruent loop.
	 *
	 *   stage:   op:
	 *         0  ld
	 *	   :
	 * MEM_LAT+3  shrp
	 * MEM_LAT+4  st
	 *
	 * On Itanium, the pipeline itself runs without stalls.  However,  br.ctop
	 * seems to introduce an unavoidable bubble in the pipeline so the overall
	 * latency is 2 cycles/iteration.  This gives us a _copy_ throughput
	 * of 4 byte/cycle.  Still not bad.
	 */
#	undef N
#	undef Nrot
#	define N	(MEM_LAT + 5)		/* number of stages */
#	define Nrot	((N+1 + 2 + 7) & ~7)	/* number of rotating regs */

#define LOG_LOOP_SIZE	6

.memcpy_long:
	alloc t3=ar.pfs,3,Nrot,0,Nrot
	and t0=-8,src	
	and t2=7,src	
	;;
	ld8 t0=[t0]	
	adds src2=7,src	
	sub t4=r0,dst	
	;;
	and src2=-8,src2
	shl t2=t2,3	
	shl t4=t4,3	
	;;
	ld8 t1=[src2]	
	sub t3=64,t2	
	shr.u t0=t0,t2
	;;
	add src_end=src,in2
	shl t1=t1,t3
	mov pr=t4,0x38	
	;;
	or t0=t0,t1
	mov cnt=r0
	adds src_end=-1,src_end
	;;
(p3)	st1 [dst]=t0,1
(p3)	shr.u t0=t0,8
(p3)	adds cnt=1,cnt
	;;
(p4)	st2 [dst]=t0,2
(p4)	shr.u t0=t0,16
(p4)	adds cnt=2,cnt
	;;
(p5)	st4 [dst]=t0,4
(p5)	adds cnt=4,cnt
	and src_end=-8,src_end
	;;



1:{	add src=cnt,src		
	sub cnt=in2,cnt		
	mov t4=ip
  }	;;
	and src2=-8,src		
	adds t4=.memcpy_loops-1b,t4
	mov ar.ec=N

	and t0=7,src		
	shr.u t2=cnt,3		
	shl cnt=cnt,3		
	;;

	.rotr val[N+1], w[2]
	.rotp p[N]

	cmp.ne p6,p0=t0,r0	
	shl t0=t0,LOG_LOOP_SIZE	
	adds t2=-1,t2		
	;;
	add t4=t0,t4
	mov pr=cnt,0x38		
	mov ar.lc=t2
	;;
	nop.m	0
	;;
	nop.m	0
	nop.i	0
	;;
	nop.m	0
	;;
(p6)	ld8 val[1]=[src2],8	
	mov b6=t4
	br.sptk.few b6
	;;

.memcpy_tail:


(p5)	st4 [dst]=t0,4
(p5)	shr.u t0=t0,32
	mov ar.lc=saved_lc
	;;
(p4)	st2 [dst]=t0,2
(p4)	shr.u t0=t0,16
	mov ar.pfs=saved_pfs
	;;
(p3)	st1 [dst]=t0
	mov pr=saved_pr,-1
	br.ret.sptk.many rp

	.align 64

#define COPY(shift,index)									\
 1: { .mib											\
	(p[0])		ld8 val[0]=[src2],8;							\
	(p[MEM_LAT+3])	shrp w[0]=val[MEM_LAT+3],val[MEM_LAT+4-index],shift;			\
			brp.loop.imp 1b, 2f							\
    };												\
 2: { .mfb											\
	(p[MEM_LAT+4])	st8 [dst]=w[1],8;							\
			nop.f 0;								\
			br.ctop.dptk.few 1b;							\
    };												\
			;;									\
			ld8 val[N-1]=[src_end];	/* load last word (may be same as val[N]) */	\
			;;									\
			shrp t0=val[N-1],val[N-index],shift;					\
			br .memcpy_tail
.memcpy_loops:
	COPY(0, 1) /* no point special casing this---it doesn't go any faster without shrp */
	COPY(8, 0)
	COPY(16, 0)
	COPY(24, 0)
	COPY(32, 0)
	COPY(40, 0)
	COPY(48, 0)
	COPY(56, 0)

END(memcpy)
