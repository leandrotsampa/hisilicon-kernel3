/*
 *
 * Optimized version of the copy_user() routine.
 * It is used to copy date across the kernel/user boundary.
 *
 * The source and destination are always on opposite side of
 * the boundary. When reading from user space we must catch
 * faults on loads. When writing to user space we must catch
 * errors on stores. Note that because of the nature of the copy
 * we don't need to worry about overlapping regions.
 *
 *
 * Inputs:
 *	in0	address of source buffer
 *	in1	address of destination buffer
 *	in2	number of bytes to copy
 *
 * Outputs:
 *	ret0	0 in case of success. The number of bytes NOT copied in
 *		case of error.
 *
 * Copyright (C) 2000-2001 Hewlett-Packard Co
 *	Stephane Eranian <eranian@hpl.hp.com>
 *
 * Fixme:
 *	- handle the case where we have more than 16 bytes and the alignment
 *	  are different.
 *	- more benchmarking
 *	- fix extraneous stop bit introduced by the EX() macro.
 */

#include <asm/asmmacro.h>

#define COPY_BREAK	16
#define PIPE_DEPTH	21

#define EPI		p[PIPE_DEPTH-1]

#define dst		in0
#define src		in1
#define len		in2

#define t1		r2
#define t2		r3
#define rshift		r14
#define lshift		r15
#define word1		r16
#define word2		r17
#define cnt		r18
#define len2		r19
#define saved_lc	r20
#define saved_pr	r21
#define tmp		r22
#define val		r23
#define src1		r24
#define dst1		r25
#define src2		r26
#define dst2		r27
#define len1		r28
#define enddst		r29
#define endsrc		r30
#define saved_pfs	r31

GLOBAL_ENTRY(__copy_user)
	.prologue
	.save ar.pfs, saved_pfs
	alloc saved_pfs=ar.pfs,3,((2*PIPE_DEPTH+7)&~7),0,((2*PIPE_DEPTH+7)&~7)

	.rotr val1[PIPE_DEPTH],val2[PIPE_DEPTH]
	.rotp p[PIPE_DEPTH]

	adds len2=-1,len
	mov ret0=r0

	;;		
	cmp.eq p8,p0=r0,len
	.save ar.lc, saved_lc
	mov saved_lc=ar.lc
(p8)	br.ret.spnt.many rp
	;;
	add enddst=dst,len
	add endsrc=src,len
	.save pr, saved_pr
	mov saved_pr=pr	

	.body

	mov dst1=dst	
	mov ar.ec=PIPE_DEPTH
	mov pr.rot=1<<16

	mov src1=src	
	mov ar.lc=len2	
	cmp.lt p10,p7=COPY_BREAK,len

	xor tmp=src,dst	
(p10)	br.cond.dptk .long_copy_user
	;;		




1:
	EX(.failure_in_pipe1,(p16) ld1 val1[0]=[src1],1)
	EX(.failure_out,(EPI) st1 [dst1]=val1[PIPE_DEPTH-1],1)
	br.ctop.dptk.few 1b
	;;
	mov ar.lc=saved_lc
	mov pr=saved_pr,0xffffffffffff0000
	mov ar.pfs=saved_pfs	
	br.ret.sptk.many rp	




.diff_align_copy_user:


	and src2=0x7,src1			
	and dst2=0x7,dst1			
	;;
























	cmp.eq p14,p15=r0,dst2
(p15)	br.cond.spnt 1f
	;;
	sub t1=8,src2
	mov t2=src2
	;;
	shl rshift=t2,3
	sub len1=len,t1				
	;;
	sub lshift=64,rshift
	;;
	br.cond.spnt .word_copy_user
	;;
1:
	cmp.leu	p14,p15=src2,dst2
	sub t1=dst2,src2
	;;
	.pred.rel "mutex", p14, p15
(p14)	sub word1=8,src2			
(p15)	sub t1=r0,t1				
(p15)	sub word1=8,dst2			
	;;


	sub t2=8,t1
(p14)	sub word1=word1,t1
	;;
	sub len1=len,word1			
(p15)	shl rshift=t1,3				
(p14)	shl rshift=t2,3
	;;
(p14)	sub len1=len1,t1
	adds cnt=-1,word1
	;;
	sub lshift=64,rshift
	mov ar.ec=PIPE_DEPTH
	mov pr.rot=1<<16
	mov ar.lc=cnt
	;;
2:
	EX(.failure_in_pipe2,(p16) ld1 val1[0]=[src1],1)
	EX(.failure_out,(EPI) st1 [dst1]=val1[PIPE_DEPTH-1],1)
	br.ctop.dptk.few 2b
	;;
	clrrrb
	;;
.word_copy_user:
	cmp.gtu p9,p0=16,len1
(p9)	br.cond.spnt 4f		
	;;
	shr.u cnt=len1,3	
	;;
	adds cnt=-1,cnt
	;;
	.pred.rel "mutex", p14, p15
(p14)	sub src1=src1,t2
(p15)	sub src1=src1,t1




	mov ar.lc=cnt
	mov ar.ec=PIPE_DEPTH
	mov pr.rot=1<<16
	;;
3:











#define EPI_1		p[PIPE_DEPTH-2]
#define SWITCH(pred, shift)	cmp.eq pred,p0=shift,rshift
#define CASE(pred, shift)	\
	(pred)	br.cond.spnt .copy_user_bit##shift
#define BODY(rshift)						\
.copy_user_bit##rshift:						\
1:								\
	EX(.failure_out,(EPI) st8 [dst1]=tmp,8);		\
(EPI_1) shrp tmp=val1[PIPE_DEPTH-2],val1[PIPE_DEPTH-1],rshift;	\
	EX(3f,(p16) ld8 val1[1]=[src1],8);			\
(p16)	mov val1[0]=r0;						\
	br.ctop.dptk 1b;					\
	;;							\
	br.cond.sptk.many .diff_align_do_tail;			\
2:								\
(EPI)	st8 [dst1]=tmp,8;					\
(EPI_1)	shrp tmp=val1[PIPE_DEPTH-2],val1[PIPE_DEPTH-1],rshift;	\
3:								\
(p16)	mov val1[1]=r0;						\
(p16)	mov val1[0]=r0;						\
	br.ctop.dptk 2b;					\
	;;							\
	br.cond.sptk.many .failure_in2






	SWITCH(p6, 8)
	SWITCH(p7, 16)
	SWITCH(p8, 24)
	SWITCH(p9, 32)
	SWITCH(p10, 40)
	SWITCH(p11, 48)
	SWITCH(p12, 56)
	;;
	CASE(p6, 8)
	CASE(p7, 16)
	CASE(p8, 24)
	CASE(p9, 32)
	CASE(p10, 40)
	CASE(p11, 48)
	CASE(p12, 56)
	;;
	BODY(8)
	BODY(16)
	BODY(24)
	BODY(32)
	BODY(40)
	BODY(48)
	BODY(56)
	;;
.diff_align_do_tail:
	.pred.rel "mutex", p14, p15
(p14)	sub src1=src1,t1
(p14)	adds dst1=-8,dst1
(p15)	sub dst1=dst1,t1
	;;
4:






	sub len1=endsrc,src1,1
	clrrrb
	;;
	mov ar.ec=PIPE_DEPTH
	mov pr.rot=1<<16
	mov ar.lc=len1
	;;
5:
	EX(.failure_in_pipe1,(p16) ld1 val1[0]=[src1],1)
	EX(.failure_out,(EPI) st1 [dst1]=val1[PIPE_DEPTH-1],1)
	br.ctop.dptk.few 5b
	;;
	mov ar.lc=saved_lc
	mov pr=saved_pr,0xffffffffffff0000
	mov ar.pfs=saved_pfs
	br.ret.sptk.many rp




.long_copy_user:
	tbit.nz p6,p7=src1,0
	and tmp=7,tmp
	;;
	cmp.eq p10,p8=r0,tmp
	mov len1=len	
(p8)	br.cond.dpnt .diff_align_copy_user
	;;






	EX(.failure_in1,(p6) ld1 val1[0]=[src1],1)
(p6)	adds len1=-1,len1;;
	tbit.nz p7,p0=src1,1
	;;
	EX(.failure_in1,(p7) ld2 val1[1]=[src1],2)
(p7)	adds len1=-2,len1;;
	tbit.nz p8,p0=src1,2
	;;




	EX(.failure_in1,(p8) ld4 val2[0]=[src1],4)
	;;
	EX(.failure_out,(p6) st1 [dst1]=val1[0],1)
	tbit.nz p9,p0=src1,3
	;;




	EX(.failure_in1,(p9) ld8 val2[1]=[src1],8)
	EX(.failure_out,(p7) st2 [dst1]=val1[1],2)
(p8)	adds len1=-4,len1
	;;
	EX(.failure_out, (p8) st4 [dst1]=val2[0],4)
(p9)	adds len1=-8,len1;;
	shr.u cnt=len1,4	
	;;
	EX(.failure_out, (p9) st8 [dst1]=val2[1],8)
	tbit.nz p6,p0=len1,3
	cmp.eq p7,p0=r0,cnt
	adds tmp=-1,cnt		
(p7)	br.cond.dpnt .dotail	
	;;
	adds src2=8,src1
	adds dst2=8,dst1
	mov ar.lc=tmp
	;;



2:
	EX(.failure_in3,(p16) ld8 val1[0]=[src1],16)
(p16)	ld8 val2[0]=[src2],16

	EX(.failure_out, (EPI)	st8 [dst1]=val1[PIPE_DEPTH-1],16)
(EPI)	st8 [dst2]=val2[PIPE_DEPTH-1],16
	br.ctop.dptk 2b
	;;		






.dotail:
	EX(.failure_in1,(p6) ld8 val1[0]=[src1],8)
	tbit.nz p7,p0=len1,2
	;;
	EX(.failure_in1,(p7) ld4 val1[1]=[src1],4)
	tbit.nz p8,p0=len1,1
	;;
	EX(.failure_in1,(p8) ld2 val2[0]=[src1],2)
	tbit.nz p9,p0=len1,0
	;;
	EX(.failure_out, (p6) st8 [dst1]=val1[0],8)
	;;
	EX(.failure_in1,(p9) ld1 val2[1]=[src1])
	mov ar.lc=saved_lc
	;;
	EX(.failure_out,(p7) st4 [dst1]=val1[1],4)
	mov pr=saved_pr,0xffffffffffff0000
	;;
	EX(.failure_out, (p8)	st2 [dst1]=val2[0],2)
	mov ar.pfs=saved_pfs
	;;
	EX(.failure_out, (p9)	st1 [dst1]=val2[1])
	br.ret.sptk.many rp


























.failure_in_pipe1:
	sub ret0=endsrc,src1
1:
(p16)	mov val1[0]=r0
(EPI)	st1 [dst1]=val1[PIPE_DEPTH-1],1
	br.ctop.dptk 1b
	;;
	mov pr=saved_pr,0xffffffffffff0000
	mov ar.lc=saved_lc
	mov ar.pfs=saved_pfs
	br.ret.sptk.many rp






.failure_in_pipe2:
	sub ret0=endsrc,src1
2:
(p16)	mov val1[0]=r0
(EPI)	st1 [dst1]=val1[PIPE_DEPTH-1],1
	br.ctop.dptk 2b
	;;
	sub len=enddst,dst1,1	
	br.cond.dptk.many .failure_in1bis
	;;









































































.failure_in1:
	sub ret0=endsrc,src1
	sub len=endsrc,src1,1







	;;
.failure_in1bis:	
	mov ar.lc=len	
	;;
5:
	st1 [dst1]=r0,1
	br.cloop.dptk 5b
	;;
	mov pr=saved_pr,0xffffffffffff0000
	mov ar.lc=saved_lc
	mov ar.pfs=saved_pfs
	br.ret.sptk.many rp











.failure_in3:
	sub ret0=endsrc,src1
	;;
2:
(p16)	mov val1[0]=r0
(p16)	mov val2[0]=r0
(EPI)	st8 [dst1]=val1[PIPE_DEPTH-1],16
(EPI)	st8 [dst2]=val2[PIPE_DEPTH-1],16
	br.ctop.dptk 2b
	;;
	cmp.ne p6,p0=dst1,enddst
	sub len=enddst,dst1,1	
(p6)	br.cond.dptk .failure_in1bis
	;;
	mov pr=saved_pr,0xffffffffffff0000
	mov ar.lc=saved_lc
	mov ar.pfs=saved_pfs
	br.ret.sptk.many rp

.failure_in2:
	sub ret0=endsrc,src1
	cmp.ne p6,p0=dst1,enddst
	sub len=enddst,dst1,1	
(p6)	br.cond.dptk .failure_in1bis
	;;
	mov pr=saved_pr,0xffffffffffff0000
	mov ar.lc=saved_lc
	mov ar.pfs=saved_pfs
	br.ret.sptk.many rp




.failure_out:
	sub ret0=enddst,dst1
	mov pr=saved_pr,0xffffffffffff0000
	mov ar.lc=saved_lc

	mov ar.pfs=saved_pfs
	br.ret.sptk.many rp
END(__copy_user)
