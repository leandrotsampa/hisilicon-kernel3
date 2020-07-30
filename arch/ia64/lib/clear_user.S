/*
 * This routine clears to zero a linear memory buffer in user space.
 *
 * Inputs:
 *	in0:	address of buffer
 *	in1:	length of buffer in bytes
 * Outputs:
 *	r8:	number of bytes that didn't get cleared due to a fault
 *
 * Copyright (C) 1998, 1999, 2001 Hewlett-Packard Co
 *	Stephane Eranian <eranian@hpl.hp.com>
 */

#include <asm/asmmacro.h>

#define buf		r32
#define len		r33

#define cnt		r16
#define buf2		r17
#define saved_lc	r18
#define saved_pfs	r19
#define tmp		r20
#define len2		r21
#define len3		r22


GLOBAL_ENTRY(__do_clear_user)
	.prologue
	.save ar.pfs, saved_pfs
	alloc	saved_pfs=ar.pfs,2,0,0,0
	cmp.eq p6,p0=r0,len	
	.save ar.lc, saved_lc
	mov saved_lc=ar.lc	
	.body
	;;			
	adds tmp=-1,len		
	mov ret0=len		
(p6)	br.ret.spnt.many rp
	;;
	cmp.lt p6,p0=16,len	
	mov ar.lc=tmp		
(p6)	br.cond.dptk .long_do_clear
	;;			








1:
	EX( .Lexit1, st1 [buf]=r0,1 )
	adds len=-1,len		
	br.cloop.dptk 1b
	;;			



.Lexit1:
	mov ret0=len		
	mov ar.lc=saved_lc
	br.ret.sptk.many rp	










.long_do_clear:
	tbit.nz p6,p0=buf,0	
	;;
	EX( .Lexit3, (p6) st1 [buf]=r0,1 )
(p6)	adds len=-1,len;;	
	tbit.nz p6,p0=buf,1
	;;
	EX( .Lexit3, (p6) st2 [buf]=r0,2 )
(p6)	adds len=-2,len;;
	tbit.nz p6,p0=buf,2
	;;
	EX( .Lexit3, (p6) st4 [buf]=r0,4 )
(p6)	adds len=-4,len;;
	tbit.nz p6,p0=buf,3
	;;
	EX( .Lexit3, (p6) st8 [buf]=r0,8 )
(p6)	adds len=-8,len;;
	shr.u cnt=len,4	
	;;
	cmp.eq p6,p0=r0,cnt
	adds tmp=-1,cnt
(p6)	br.cond.dpnt .dotail	
	;;
	adds buf2=8,buf		
	mov ar.lc=tmp
	;;




















2:	EX(.Lexit3, st8 [buf]=r0,16 )
	;;			
	st8 [buf2]=r0,16
	adds len=-16,len
	br.cloop.dptk 2b
	;;
	mov ar.lc=saved_lc








.dotail:
	mov len2=len		
	mov len3=len
	tbit.nz p6,p0=len,3
	;;
	EX( .Lexit2, (p6) st8 [buf]=r0,8 )
(p6)	adds len3=-8,len2
	tbit.nz p7,p6=len,2
	;;
	EX( .Lexit2, (p7) st4 [buf]=r0,4 )
(p7)	adds len2=-4,len3
	tbit.nz p6,p7=len,1
	;;
	EX( .Lexit2, (p6) st2 [buf]=r0,2 )
(p6)	adds len3=-2,len2
	tbit.nz p7,p6=len,0
	;;
	EX( .Lexit2, (p7) st1 [buf]=r0 )
	mov ret0=r0			
	br.ret.sptk.many rp		














.Lexit2:
	.pred.rel "mutex", p6, p7
(p6)	mov len=len2
(p7)	mov len=len3
	;;




.Lexit3:
	mov ret0=len
	mov ar.lc=saved_lc
	br.ret.sptk.many rp
END(__do_clear_user)
