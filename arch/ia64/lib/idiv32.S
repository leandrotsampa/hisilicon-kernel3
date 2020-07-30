/*
 * Copyright (C) 2000 Hewlett-Packard Co
 * Copyright (C) 2000 David Mosberger-Tang <davidm@hpl.hp.com>
 *
 * 32-bit integer division.
 *
 * This code is based on the application note entitled "Divide, Square Root
 * and Remainder Algorithms for the IA-64 Architecture".  This document
 * is available as Intel document number 248725-002 or via the web at
 * http://developer.intel.com/software/opensource/numerics/
 *
 * For more details on the theory behind these algorithms, see "IA-64
 * and Elementary Functions" by Peter Markstein; HP Professional Books
 * (http://www.hp.com/go/retailbooks/)
 */

#include <asm/asmmacro.h>

#ifdef MODULO
# define OP	mod
#else
# define OP	div
#endif

#ifdef UNSIGNED
# define SGN	u
# define EXTEND	zxt4
# define INT_TO_FP(a,b)	fcvt.xuf.s1 a=b
# define FP_TO_INT(a,b)	fcvt.fxu.trunc.s1 a=b
#else
# define SGN
# define EXTEND	sxt4
# define INT_TO_FP(a,b)	fcvt.xf a=b
# define FP_TO_INT(a,b)	fcvt.fx.trunc.s1 a=b
#endif

#define PASTE1(a,b)	a##b
#define PASTE(a,b)	PASTE1(a,b)
#define NAME		PASTE(PASTE(__,SGN),PASTE(OP,si3))

GLOBAL_ENTRY(NAME)
	.regstk 2,0,0,0

	mov r2 = 0xffdd		
	EXTEND in0 = in0	
	EXTEND in1 = in1	
	;;
	setf.sig f8 = in0
	setf.sig f9 = in1
#ifdef MODULO
	sub in1 = r0, in1	
#endif
	;;

	INT_TO_FP(f8, f8)
	INT_TO_FP(f9, f9)
	;;
	setf.exp f7 = r2	
	frcpa.s1 f6, p6 = f8, f9
	;;
(p6)	fmpy.s1 f8 = f8, f6	
(p6)	fnma.s1 f6 = f9, f6, f1	
	;;
#ifdef MODULO
	setf.sig f9 = in1	
#endif
(p6)	fma.s1 f8 = f6, f8, f8	
(p6)	fma.s1 f6 = f6, f6, f7	
	;;
#ifdef MODULO
	setf.sig f7 = in0
#endif
(p6)	fma.s1 f6 = f6, f8, f8	
	;;
	FP_TO_INT(f6, f6)	
	;;
#ifdef MODULO
	xma.l f6 = f6, f9, f7	
	;;
#endif
	getf.sig r8 = f6	
	br.ret.sptk.many rp
END(NAME)
