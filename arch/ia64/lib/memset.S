/* Optimized version of the standard memset() function.

   Copyright (c) 2002 Hewlett-Packard Co/CERN
	Sverre Jarp <Sverre.Jarp@cern.ch>

   Return: dest

   Inputs:
        in0:    dest
        in1:    value
        in2:    count

   The algorithm is fairly straightforward: set byte by byte until we
   we get to a 16B-aligned address, then loop on 128 B chunks using an
   early store as prefetching, then loop on 32B chucks, then clear remaining
   words, finally clear remaining bytes.
   Since a stf.spill f0 can store 16B in one go, we use this instruction
   to get peak speed when value = 0.  */

#include <asm/asmmacro.h>
#undef ret

#define dest		in0
#define value		in1
#define	cnt		in2

#define tmp		r31
#define save_lc		r30
#define ptr0		r29
#define ptr1		r28
#define ptr2		r27
#define ptr3		r26
#define ptr9 		r24
#define	loopcnt		r23
#define linecnt		r22
#define bytecnt		r21

#define fvalue		f6

#define p_scr		p6		
#define p_nz		p7
#define p_zr		p8
#define p_unalgn	p9
#define p_y		p11
#define p_n		p12
#define p_yy		p13
#define p_nn		p14

#define MIN1		15
#define MIN1P1HALF	8
#define LINE_SIZE	128
#define LSIZE_SH        7		
#define PREF_AHEAD	8

GLOBAL_ENTRY(memset)
{ .mmi
	.prologue
	alloc	tmp = ar.pfs, 3, 0, 0, 0
	lfetch.nt1 [dest]		
	.save   ar.lc, save_lc
	mov.i	save_lc = ar.lc
	.body
} { .mmi
	mov	ret0 = dest		
	cmp.ne	p_nz, p_zr = value, r0	
	cmp.eq	p_scr, p0 = cnt, r0
;; }
{ .mmi
	and	ptr2 = -(MIN1+1), dest	
	and	tmp = MIN1, dest	
	tbit.nz p_y, p_n = dest, 0	
} { .mib
	mov	ptr1 = dest
	mux1	value = value, @brcst	
(p_scr)	br.ret.dpnt.many rp		
;; }
{ .mib
	cmp.ne	p_unalgn, p0 = tmp, r0	
} { .mib
	sub	bytecnt = (MIN1+1), tmp	
	cmp.gt	p_scr, p0 = 16, cnt	
(p_scr)	br.cond.dptk.many .move_bytes_unaligned
;; }
{ .mmi
(p_unalgn) add	ptr1 = (MIN1+1), ptr2	
(p_unalgn) add	ptr2 = MIN1P1HALF, ptr2	
(p_unalgn) tbit.nz.unc p_y, p_n = bytecnt, 3
;; }
{ .mib
(p_y)	add	cnt = -8, cnt		
(p_unalgn) tbit.nz.unc p_yy, p_nn = bytecnt, 2
} { .mib
(p_y)	st8	[ptr2] = value,-4	
(p_n)	add	ptr2 = 4, ptr2		
;; }
{ .mib
(p_yy)	add	cnt = -4, cnt		
(p_unalgn) tbit.nz.unc p_y, p_n = bytecnt, 1
} { .mib
(p_yy)	st4	[ptr2] = value,-2	
(p_nn)	add	ptr2 = 2, ptr2		
;; }
{ .mmi
	mov	tmp = LINE_SIZE+1	
(p_y)	add	cnt = -2, cnt		
(p_unalgn) tbit.nz.unc p_yy, p_nn = bytecnt, 0
} { .mmi
	setf.sig fvalue=value		
(p_y)	st2	[ptr2] = value,-1	
(p_n)	add	ptr2 = 1, ptr2		
;; }

{ .mmi
(p_yy)	st1	[ptr2] = value 		
  	cmp.gt	p_scr, p0 = tmp, cnt	
} { .mbb
(p_yy)	add	cnt = -1, cnt		
(p_scr)	br.cond.dpnt.many .fraction_of_line
;; }

{ .mib
	nop.m 0
	shr.u	linecnt = cnt, LSIZE_SH
(p_zr)	br.cond.dptk.many .l1b		
;; }

	TEXT_ALIGN(32) // --------------------- //  L1A: store ahead into cache lines; fill later
{ .mmi
	and	tmp = -(LINE_SIZE), cnt	
	mov	ptr9 = ptr1		
	and	cnt = (LINE_SIZE-1), cnt
} { .mmi
	mov	loopcnt = PREF_AHEAD-1	
	cmp.gt	p_scr, p0 = PREF_AHEAD, linecnt
;; }
{ .mmi
(p_scr)	add	loopcnt = -1, linecnt	
	add	ptr2 = 8, ptr1		
	add	ptr1 = tmp, ptr1	
;; }
{ .mmi
	add	tmp = -1, linecnt	
	mov.i	ar.lc = loopcnt		
;; }
.pref_l1a:
{ .mib
	stf8 [ptr9] = fvalue, 128	
	nop.i	0
	br.cloop.dptk.few .pref_l1a
;; }
{ .mmi
	add	ptr0 = 16, ptr2		
	mov.i	ar.lc = tmp		
;; }
.l1ax:
 { .mmi
	stf8 [ptr2] = fvalue, 8
	stf8 [ptr0] = fvalue, 8
 ;; }
 { .mmi
	stf8 [ptr2] = fvalue, 24
	stf8 [ptr0] = fvalue, 24
 ;; }
 { .mmi
	stf8 [ptr2] = fvalue, 8
	stf8 [ptr0] = fvalue, 8
 ;; }
 { .mmi
	stf8 [ptr2] = fvalue, 24
	stf8 [ptr0] = fvalue, 24
 ;; }
 { .mmi
	stf8 [ptr2] = fvalue, 8
	stf8 [ptr0] = fvalue, 8
 ;; }
 { .mmi
	stf8 [ptr2] = fvalue, 24
	stf8 [ptr0] = fvalue, 24
 ;; }
 { .mmi
	stf8 [ptr2] = fvalue, 8
	stf8 [ptr0] = fvalue, 32
 	cmp.lt	p_scr, p0 = ptr9, ptr1	
 ;; }
{ .mmb
	stf8 [ptr2] = fvalue, 24
(p_scr)	stf8 [ptr9] = fvalue, 128
	br.cloop.dptk.few .l1ax
;; }
{ .mbb
	cmp.le  p_scr, p0 = 8, cnt	
(p_scr) br.cond.dpnt.many  .fraction_of_line
	br.cond.dpnt.many  .move_bytes_from_alignment
;; }

	TEXT_ALIGN(32)
.l1b:
{ .mmi
	and	tmp = -(LINE_SIZE), cnt	
	mov	ptr9 = ptr1		
	and	cnt = (LINE_SIZE-1), cnt
} { .mmi
	mov	loopcnt = PREF_AHEAD-1	
	cmp.gt	p_scr, p0 = PREF_AHEAD, linecnt
;; }
{ .mmi
(p_scr)	add	loopcnt = -1, linecnt
	add	ptr2 = 16, ptr1		
	add	ptr1 = tmp, ptr1	
;; }
{ .mmi
	add	tmp = -1, linecnt	
	mov.i	ar.lc = loopcnt
;; }
.pref_l1b:
{ .mib
	stf.spill [ptr9] = f0, 128	
	nop.i   0
	br.cloop.dptk.few .pref_l1b
;; }
{ .mmi
	add	ptr0 = 16, ptr2		
	mov.i	ar.lc = tmp
;; }
.l1bx:
 { .mmi
	stf.spill [ptr2] = f0, 32
	stf.spill [ptr0] = f0, 32
 ;; }
 { .mmi
	stf.spill [ptr2] = f0, 32
	stf.spill [ptr0] = f0, 32
 ;; }
 { .mmi
	stf.spill [ptr2] = f0, 32
	stf.spill [ptr0] = f0, 64
 	cmp.lt	p_scr, p0 = ptr9, ptr1	
 ;; }
{ .mmb
	stf.spill [ptr2] = f0, 32
(p_scr)	stf.spill [ptr9] = f0, 128
	br.cloop.dptk.few .l1bx
;; }
{ .mib
	cmp.gt  p_scr, p0 = 8, cnt	
(p_scr)	br.cond.dpnt.many  .move_bytes_from_alignment
;; }

.fraction_of_line:
{ .mib
	add	ptr2 = 16, ptr1
	shr.u	loopcnt = cnt, 5   	
;; }
{ .mib
	cmp.eq	p_scr, p0 = loopcnt, r0
	add	loopcnt = -1, loopcnt
(p_scr)	br.cond.dpnt.many .store_words
;; }
{ .mib
	and	cnt = 0x1f, cnt		
	mov.i   ar.lc = loopcnt
;; }
	TEXT_ALIGN(32)
.l2:
{ .mmb
	stf8	[ptr1] = fvalue, 8
	stf8	[ptr2] = fvalue, 8
;; } { .mmb
	stf8	[ptr1] = fvalue, 24
	stf8	[ptr2] = fvalue, 24
	br.cloop.dptk.many .l2
;; }
.store_words:
{ .mib
	cmp.gt	p_scr, p0 = 8, cnt	
(p_scr)	br.cond.dpnt.many .move_bytes_from_alignment
;; }

{ .mmi
	stf8	[ptr1] = fvalue, 8	
	cmp.le	p_y, p_n = 16, cnt
	add	cnt = -8, cnt		
;; }
{ .mmi
(p_y)	stf8	[ptr1] = fvalue, 8	
(p_y)	cmp.le.unc p_yy, p_nn = 16, cnt
(p_y)	add	cnt = -8, cnt		
;; }
{ .mmi					
(p_yy)	stf8	[ptr1] = fvalue, 8
(p_yy)	add	cnt = -8, cnt		
;; }

.move_bytes_from_alignment:
{ .mib
	cmp.eq	p_scr, p0 = cnt, r0
	tbit.nz.unc p_y, p0 = cnt, 2	
(p_scr)	br.cond.dpnt.few .restore_and_exit
;; }
{ .mib
(p_y)	st4	[ptr1] = value,4
	tbit.nz.unc p_yy, p0 = cnt, 1	
;; }
{ .mib
(p_yy)	st2	[ptr1] = value,2
	tbit.nz.unc p_y, p0 = cnt, 0	
;; }

{ .mib
(p_y)	st1	[ptr1] = value
;; }
.restore_and_exit:
{ .mib
	nop.m	0
	mov.i	ar.lc = save_lc
	br.ret.sptk.many rp
;; }

.move_bytes_unaligned:
{ .mmi
       .pred.rel "mutex",p_y, p_n
       .pred.rel "mutex",p_yy, p_nn
(p_n)	cmp.le  p_yy, p_nn = 4, cnt
(p_y)	cmp.le  p_yy, p_nn = 5, cnt
(p_n)	add	ptr2 = 2, ptr1
} { .mmi
(p_y)	add	ptr2 = 3, ptr1
(p_y)	st1	[ptr1] = value, 1	
(p_y)	add	cnt = -1, cnt
;; }
{ .mmi
(p_yy)	cmp.le.unc p_y, p0 = 8, cnt
	add	ptr3 = ptr1, cnt	
	mov.i	ar.lc = save_lc
} { .mmi
(p_yy)	st2	[ptr1] = value, 4	
(p_yy)	st2	[ptr2] = value, 4	
(p_yy)	add	cnt = -4, cnt
;; }
{ .mmi
(p_y)	cmp.le.unc p_yy, p0 = 8, cnt
	add	ptr3 = -1, ptr3		
	tbit.nz p_scr, p0 = cnt, 1	
} { .mmi
(p_y)	st2	[ptr1] = value, 4	
(p_y)	st2	[ptr2] = value, 4	
(p_y)	add	cnt = -4, cnt
;; }
{ .mmi
(p_yy)	st2	[ptr1] = value, 4	
(p_yy)	st2	[ptr2] = value, 4	
	tbit.nz p_y, p0 = cnt, 0	
} { .mmi
(p_yy)	add	cnt = -4, cnt
;; }
{ .mmb
(p_scr)	st2	[ptr1] = value		
(p_y)	st1	[ptr3] = value		
	br.ret.sptk.many rp
}
END(memset)
