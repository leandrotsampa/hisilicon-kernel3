/*
 *
 * Optmized version of the standard do_csum() function
 *
 * Return: a 64bit quantity containing the 16bit Internet checksum
 *
 * Inputs:
 *	in0: address of buffer to checksum (char *)
 *	in1: length of the buffer (int)
 *
 * Copyright (C) 1999, 2001-2002 Hewlett-Packard Co
 *	Stephane Eranian <eranian@hpl.hp.com>
 *
 * 02/04/22	Ken Chen <kenneth.w.chen@intel.com>
 *		Data locality study on the checksum buffer.
 *		More optimization cleanup - remove excessive stop bits.
 * 02/04/08	David Mosberger <davidm@hpl.hp.com>
 *		More cleanup and tuning.
 * 01/04/18	Jun Nakajima <jun.nakajima@intel.com>
 *		Clean up and optimize and the software pipeline, loading two
 *		back-to-back 8-byte words per loop. Clean up the initialization
 *		for the loop. Support the cases where load latency = 1 or 2.
 *		Set CONFIG_IA64_LOAD_LATENCY to 1 or 2 (default).
 */

#include <asm/asmmacro.h>


#define saved_pfs	r11
#define hmask		r16
#define tmask		r17
#define first1		r18
#define firstval	r19
#define firstoff	r20
#define last		r21
#define lastval		r22
#define lastoff		r23
#define saved_lc	r24
#define saved_pr	r25
#define tmp1		r26
#define tmp2		r27
#define tmp3		r28
#define carry1		r29
#define carry2		r30
#define first2		r31

#define buf		in0
#define len		in1

#define LOAD_LATENCY	2

#if (LOAD_LATENCY != 1) && (LOAD_LATENCY != 2)
# error "Only 1 or 2 is supported/tested for LOAD_LATENCY."
#endif

#define PIPE_DEPTH			(LOAD_LATENCY+2)
#define ELD	p[LOAD_LATENCY]	
#define ELD_1	p[LOAD_LATENCY+1]


GLOBAL_ENTRY(do_csum)
	.prologue
	.save ar.pfs, saved_pfs
	alloc saved_pfs=ar.pfs,2,16,0,16
	.rotr word1[4], word2[4],result1[LOAD_LATENCY+2],result2[LOAD_LATENCY+2]
	.rotp p[PIPE_DEPTH], pC1[2], pC2[2]
	mov ret0=r0	
	cmp.lt p0,p6=r0,len
	;;
	add tmp1=buf,len
	.save pr, saved_pr
	mov saved_pr=pr	
(p6)	br.ret.spnt.many rp

	mov hmask=-1	
	tbit.nz p15,p0=buf,0
	and first1=-8,buf

	and firstoff=7,buf
	mov tmask=-1	

	;;
	adds tmp2=-1,tmp1
	and lastoff=7,tmp1
	;;
	sub tmp1=8,lastoff
	and last=-8,tmp2
	;;
	sub tmp3=last,first1
	.save ar.lc, saved_lc
	mov saved_lc=ar.lc
	cmp.eq p8,p9=last,first1

	ld8 firstval=[first1],8
	and tmp1=7, tmp1
	shl tmp2=firstoff,3
	;;
(p9)	ld8 lastval=[last]
	shl tmp1=tmp1,3	
(p9)	adds tmp3=-8,tmp3
	;;
(p8)	mov lastval=r0	
	shl hmask=hmask,tmp2
	shr.u tmask=tmask,tmp1
	;;
	.body
#define count tmp3

(p8)	and hmask=hmask,tmask
(p9)	and word2[0]=lastval,tmask
	shr.u count=count,3
	;;


	and word1[0]=firstval,hmask
	tbit.nz p10,p11=count,0	
	;;
(p8)	mov result1[0]=word1[0]
(p9)	add result1[0]=word1[0],word2[0]
	;;
	cmp.ltu p6,p0=result1[0],word1[0]
	cmp.eq.or.andcm p8,p0=0,count	
	;;
(p6)	adds result1[0]=1,result1[0]
(p8)	br.cond.dptk .do_csum_exit
(p11)	br.cond.dptk .do_csum16	


	ld8 word1[1]=[first1],8	
	cmp.eq p9,p10=1,count	
	adds count=-1,count	
	;;
	add result1[0]=result1[0],word1[1]
	;;
	cmp.ltu p6,p0=result1[0],word1[1]
	;;
(p6)	adds result1[0]=1,result1[0]
(p9)	br.cond.sptk .do_csum_exit





.do_csum16:
	add first2=8,first1
	shr.u count=count,1
	;;
	adds count=-1,count
	mov carry1=r0
	mov carry2=r0
	brp.loop.imp 1f,2f
	;;
	mov ar.ec=PIPE_DEPTH
	mov ar.lc=count
	mov pr.rot=1<<16

	mov result2[0]=r0
	;;
	.align 32
1:
(ELD_1)	cmp.ltu pC1[0],p0=result1[LOAD_LATENCY],word1[LOAD_LATENCY+1]
(pC1[1])adds carry1=1,carry1
(ELD_1)	cmp.ltu pC2[0],p0=result2[LOAD_LATENCY],word2[LOAD_LATENCY+1]
(pC2[1])adds carry2=1,carry2
(ELD)	add result1[LOAD_LATENCY-1]=result1[LOAD_LATENCY],word1[LOAD_LATENCY]
(ELD)	add result2[LOAD_LATENCY-1]=result2[LOAD_LATENCY],word2[LOAD_LATENCY]
2:
(p[0])	ld8 word1[0]=[first1],16
(p[0])	ld8 word2[0]=[first2],16
	br.ctop.sptk 1b
	;;

(pC1[1])adds carry1=1,carry1
(pC2[1])adds carry2=1,carry2
	;;
	add result1[LOAD_LATENCY+1]=result1[LOAD_LATENCY+1],carry1
	add result2[LOAD_LATENCY+1]=result2[LOAD_LATENCY+1],carry2
	;;
	cmp.ltu p6,p0=result1[LOAD_LATENCY+1],carry1
	cmp.ltu p7,p0=result2[LOAD_LATENCY+1],carry2
	;;
(p6)	adds result1[LOAD_LATENCY+1]=1,result1[LOAD_LATENCY+1]
(p7)	adds result2[LOAD_LATENCY+1]=1,result2[LOAD_LATENCY+1]
	;;
	add result1[0]=result1[LOAD_LATENCY+1],result2[LOAD_LATENCY+1]
	;;
	cmp.ltu p6,p0=result1[0],result2[LOAD_LATENCY+1]
	;;
(p6)	adds result1[0]=1,result1[0]
	;;
.do_csum_exit:




	mov tmp3=0xffff
	zxt4 tmp1=result1[0]
	shr.u tmp2=result1[0],32
	;;
	add result1[0]=tmp1,tmp2
	;;
	and tmp1=result1[0],tmp3
	shr.u tmp2=result1[0],16
	;;
	add result1[0]=tmp1,tmp2
	;;
	and tmp1=result1[0],tmp3
	shr.u tmp2=result1[0],16
	;;
	add result1[0]=tmp1,tmp2
	;;
	and tmp1=result1[0],tmp3
	shr.u tmp2=result1[0],16
	;;
	add ret0=tmp1,tmp2
	mov pr=saved_pr,0xffffffffffff0000
	;;

	mov ar.pfs=saved_pfs	
(p15)	mux1 ret0=ret0,@rev	
	;;
	mov ar.lc=saved_lc
(p15)	shr.u ret0=ret0,64-16
	br.ret.sptk.many rp


END(do_csum)
