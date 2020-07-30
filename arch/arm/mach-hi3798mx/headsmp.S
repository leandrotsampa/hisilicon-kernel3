/*
 *
 * clone from linux/arch/arm/mach-realview/headsmp.S
 *
 *  Copyright (c) 2003 ARM Limited
 *  All Rights Reserved
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */
#include <linux/linkage.h>
#include <linux/init.h>

	__CPUINIT

/*
 * Realview specific entry point for secondary CPUs.  This provides
 * a "holding pen" into which all secondary cores are held until we're
 * ready for them to initialise.
 */
ENTRY(hi3798mx_secondary_startup)

	/* set the cpu to SVC32 mode */
	mrs	r0, cpsr
	bic	r0, r0, #0x1f  /* r0 = ((~0x1F) & r0) */
	orr	r0, r0, #0xd3  /* r0 = (0xd3 | r0)    */
	msr	cpsr, r0

	bl flash_cache_all
#ifdef CONFIG_SECURE_EXTENSION
	/* add for set NSACR*/
	ldr	r0,=0x00060c00           @Bit 10:unsecure access cp10       Bit 11:unsecure access cp11
	mcr	p15, 0, r0, c1, c1, 2    @Bit 17:non_secure can access L2ECTLR   Bit 18:non_secure can access actlr smp bit
	/* end */

	/* Set GIC */
	/* Get the address of the GIC */
	ldr	r0, =0xF8A01000         @ GICD_BASE

	/*enable the gic*/
	ldr	r1,[r0]
	orr	r1,r1,#0x03
	str	r1,[r0]

	/*Enable interrupt source 0->15 */
	ldr	r1,=0x0000FFFF
	str	r1,[r0,#0x100]

	/*set all SGI PPI unsecure*/
	ldr	r1,=0xfffff7ff
	str	r1,[r0,#0x80]

	/* Set priority of interrupt source 0->16 to 0x0 (highest priority) */
	mov	r1, #0xa0
	str	r1, [r0, #0x400]        @ Sources 00-03
	str	r1, [r0, #0x404]        @ Sources 04-07
	str	r1, [r0, #0x408]        @ Sources 08-11
	str	r1, [r0, #0x40C]        @ Sources 12-15

	ldr	r0, =0xF8A02000         @ GICC_BASE
	ldr	r1,[r0]
	orr	r1,r1,#0xB              @ Bit4:SBPR 0 bit3:FIQEn 1 bit2:AckCtl 0  bit1:EnableNS 1 bit0:EnableS 1
	str	r1,[r0]

	/* Set the Processor's Priority	Mask */
	mov	r1, #0xFF
	str	r1, [r0, #0x4]	        @ Write	the Priority Mask register

	ldr	r1, =0x3E701000         @ SEC_MONITOR_ADDR
	mcr	p15, 0, r1, c12, c0, 1

	cps	#0x16
	mov	r1, #0x31
	mcr	p15, 0, r1, c1, c1, 0                   @ Write Secure Configuration Register
	cps	#0x13
#endif
	mrc	p15, 0, r0, c0, c0, 5
	and	r0, r0, #15
	adr	r4, 1f
	ldmia	r4, {r5, r6}
	sub	r4, r4, r5
	add	r6, r6, r4
pen:	ldr	r7, [r6]
	cmp	r7, r0
	bne	pen

	/*
	 * we've been released from the holding pen: secondary_stack
	 * should now contain the SVC stack for this core
	 */
	b	secondary_startup

1:	.long	.
	.long	pen_release

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@
@  corrupt: r0, r1, r2, r3
@
.align	2
flash_cache_all:

	/* disable MMU stuff and caches */
	mrc	p15, 0, r0, c1, c0, 0
	orr	r0, r0, #0x00002000      /* clear bits 13 (--V-)   */
	bic	r0, r0, #0x00000007      /* clear bits 2:0 (-CAM)  */
	orr	r0, r0, #0x00000002      /* set bit 1 (--A-) Align */
	orr	r0, r0, #0x00000800      /* set bit 12 (Z---) BTB  */
	mcr	p15, 0, r0, c1, c0, 0

	/*
	 * Invalidate L1 I/D
	 */
	mov	r0, #0                   /* set up for MCR */
	mcr	p15, 0, r0, c8, c7, 0    /* invalidate TLBs */
	mcr	p15, 0, r0, c7, c5, 0    /* invalidate icache */

	/* Invalidate L1 D-cache */
	mcr	p15, 2, r0, c0, c0, 0    /* select L1 data cache */
	mrc	p15, 1, r3, c0, c0, 0    /* Read Current Cache Size Identification Register */
	ldr	r1, =0x1ff
	and	r3, r1, r3, LSR #13      /* r3 = (number of sets -1) */
	mov	r0, #0
way_loop:
	mov	r1, #0                  /* r1->set counter */
line_loop:
	mov	r2, r0, LSL #30
	orr	r2, r1, LSL #5           /* r2->set/way cache-op format */
	mcr     p15, 0, r2, c7, c6, 2    /* Invalidate line described by r2 */
	add	r1, r1, #1               /* Increment set counter */
	cmp	r1, r3                   /* Check if the last set is reached... */
	ble	line_loop                /* if not, continue the set_loop */
	add	r0, r0, #1               /* else, Increment way counter */
	cmp	r0, #4                   /* Check if the last way is reached... */
	blt	way_loop                 /* if not, continue the way_loop */

	mov	pc, lr
