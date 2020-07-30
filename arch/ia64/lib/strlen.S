/*
 *
 * Optimized version of the standard strlen() function
 *
 *
 * Inputs:
 *	in0	address of string
 *
 * Outputs:
 *	ret0	the number of characters in the string (0 if empty string)
 *	does not count the \0
 *
 * Copyright (C) 1999, 2001 Hewlett-Packard Co
 *	Stephane Eranian <eranian@hpl.hp.com>
 *
 * 09/24/99 S.Eranian add speculation recovery code
 */

#include <asm/asmmacro.h>

#define saved_pfs	r11
#define	tmp		r10
#define base		r16
#define orig		r17
#define saved_pr	r18
#define src		r19
#define mask		r20
#define val		r21
#define val1		r22
#define val2		r23

GLOBAL_ENTRY(strlen)
	.prologue
	.save ar.pfs, saved_pfs
	alloc saved_pfs=ar.pfs,11,0,0,8 // rotating must be multiple of 8

	.rotr v[2], w[2]

	extr.u tmp=in0,0,3
	mov orig=in0	
	dep src=0,in0,0,3
	.save pr, saved_pr
	mov saved_pr=pr	
	;;

	.body

	ld8 v[1]=[src],8
	shl tmp=tmp,3	
	mov mask=-1	
	;;
	ld8.s w[1]=[src],8
	cmp.eq p6,p0=r0,r0
	sub tmp=64,tmp	
	;;
	shr.u	mask=mask,tmp
	mov ar.ec=r0	
	;;
	add base=-16,src
	or v[1]=v[1],mask
	;;
1:
	ld8.s v[0]=[src],8
	czx1.r val1=v[1]
	czx1.r val2=w[1]
	;;
	ld8.s w[0]=[src],8
	cmp.eq.and p6,p0=8,val1
	cmp.eq.and p6,p0=8,val2
(p6)	br.wtop.dptk 1b	
	;;







	cmp.eq  p8,p9=8,val1
	tnat.nz p6,p7=val1
(p6)	br.cond.spnt .recover
	;;



	cmp.eq.and  p7,p0=8,val1// val1==8?
	tnat.nz.and p7,p0=val2
(p7)	br.cond.spnt .recover
	;;
(p8)	mov val1=val2	
(p8)	adds src=-16,src
(p9)	adds src=-24,src
	;;
	sub ret0=src,orig
	sub tmp=8,val1	
	mov pr=saved_pr,0xffffffffffff0000
	;;
	sub ret0=ret0,tmp
	mov ar.pfs=saved_pfs
	br.ret.sptk.many rp


















.recover:
	ld8 val=[base],8
	;;
	or val=val,mask	
	cmp.eq p0,p6=r0,r0
	;;



2:
(p6)	ld8 val=[base],8
	;;
	czx1.r val1=val	
	;;
	cmp.eq p6,p0=8,val1
(p6)	br.wtop.dptk 2b	
	;;		
	sub ret0=base,orig
	sub tmp=8,val1
	mov pr=saved_pr,0xffffffffffff0000
	;;
	sub ret0=ret0,tmp
	mov ar.pfs=saved_pfs
	br.ret.sptk.many rp
END(strlen)
