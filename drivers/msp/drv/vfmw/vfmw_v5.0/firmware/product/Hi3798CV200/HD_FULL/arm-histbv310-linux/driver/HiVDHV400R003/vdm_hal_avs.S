	.arch armv7-a
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"vdm_hal_avs.c"

	.text
	.align	2
	.global	AVSHAL_V400R003_InitHal
	.type	AVSHAL_V400R003_InitHal, %function
AVSHAL_V400R003_InitHal:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	.pad #4
	.save {fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	AVSHAL_V400R003_InitHal, .-AVSHAL_V400R003_InitHal
	.align	2
	.global	AVSHAL_V400R003_WirteSlicMsg
	.type	AVSHAL_V400R003_WirteSlicMsg, %function
AVSHAL_V400R003_WirteSlicMsg:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #28
	sub	sp, sp, #28
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	ip, .L32
	movw	r3, #1224
	mov	r5, r0
	str	r0, [fp, #-56]
	add	r8, r0, #96
	str	r1, [fp, #-52]
	mla	r2, r3, r2, ip
	ldr	r6, [r2, #56]
	add	r4, r6, #320
	mov	r0, r6
	bl	MEM_Phy2Vir
	ldr	r3, [r5, #112]
	cmp	r3, #0
	moveq	r2, r3
	add	r5, r0, #320
	beq	.L3
	ldr	r3, [fp, #-56]
	mov	r1, #0
	ldr	r2, [fp, #-52]
	add	r6, r6, #576
	ldr	r3, [r3, #96]
	add	r3, r3, #4
	rsb	r3, r2, r3
	and	r2, r3, #15
	bic	r3, r3, #15
	mov	r2, r2, asl #3
	cmp	r2, #7
	addls	r2, r2, #120
	subhi	r2, r2, #8
	subls	r3, r3, #4
	mov	r2, r2, asl #25
	bic	r3, r3, #-16777216
	orr	r2, r2, #8
	str	r2, [r0, #320]
	str	r3, [r0, #324]
	mov	r2, #1
	ldr	r3, [fp, #-56]
	str	r1, [r0, #328]
	str	r1, [r0, #332]
	ldr	r3, [r3, #112]
	sub	r3, r3, #1
	mov	r3, r3, asl #16
	str	r3, [r0, #336]
	str	r6, [r0, #572]
.L3:
	ldr	r3, [fp, #-56]
	add	r9, r3, #12288
	ldr	r3, [r9, #2144]
	cmp	r3, #0
	ble	.L2
	mov	r1, #0
	add	r3, r4, r2, lsl #8
	mov	r6, r1
	str	r3, [fp, #-60]
	mov	r0, r1
	mov	r2, r1
	b	.L18
.L29:
	mov	r4, r0, asl #5
	cmp	r0, #0
	sub	r4, r4, r0, asl #2
	add	r3, r8, r4
	movgt	ip, #1
	movle	ip, #0
	ldr	lr, [r3, #16]
	ldr	r1, [r3, #-12]
	cmp	lr, r1
	movhi	lr, #0
	andls	lr, ip, #1
	cmp	lr, #0
	beq	.L28
	ldr	r3, [r9, #2144]
	add	r0, r0, #1
	cmp	r3, r0
	ble	.L2
.L18:
	cmp	r6, #512
	blt	.L29
	sub	r0, r2, #1
.L31:
	ldr	r3, [r9, #2144]
	add	r0, r0, #1
	cmp	r3, r0
	bgt	.L18
.L2:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L28:
	ldr	r7, [r8, r4]
	ldr	r1, [r3, #4]
	ldr	ip, [fp, #-52]
	add	r7, r7, #4
	ldr	r2, [r3, #8]
	cmp	r1, #0
	rsb	r7, ip, r7
	and	ip, r7, #15
	sub	r2, r2, #4
	moveq	lr, r1
	bic	r10, r7, #15
	mov	r2, r2, asl #3
	mov	ip, ip, asl #3
	moveq	r7, lr
	beq	.L9
	ldr	r7, [fp, #-56]
	add	r4, r7, r4
	ldr	r4, [r4, #108]
	cmp	r4, #0
	ble	.L26
	ldr	r4, [fp, #-52]
	cmp	r2, #0
	rsb	r1, r4, r1
	ldr	r4, [r3, #12]
	and	r7, r1, #15
	str	r4, [fp, #-48]
	bic	r4, r1, #15
	str	r4, [fp, #-64]
	mov	r7, r7, asl #3
	ldr	r4, [fp, #-48]
	mov	r4, r4, asl #3
	beq	.L23
	bic	r4, r4, #-33554432
	bic	lr, r1, #-16777216
	orr	r7, r4, r7, asl #25
	bic	lr, lr, #15
.L9:
	cmp	ip, #7
	add	r2, r2, #8
	addls	ip, ip, #120
	subhi	ip, ip, #8
	mov	r1, r0, asl #8
	bic	r2, r2, #-33554432
	subls	r10, r10, #4
	orr	ip, r2, ip, asl #25
	add	r2, r1, #4
	str	r2, [fp, #-48]
	bic	r2, r10, #-16777216
	ldr	r10, [fp, #-48]
	str	ip, [r5, r0, asl #8]
	add	r4, r1, #8
	add	ip, r1, #12
	str	r2, [r5, r10]
	add	r2, r0, #1
	str	r7, [r5, r4]
	str	lr, [r5, ip]
	ldr	ip, [r9, #2144]
	ldr	r0, [r3, #16]
	cmp	r2, ip
	bge	.L13
	ldr	lr, [r3, #44]
	cmp	r0, lr
	bcs	.L14
	b	.L13
.L15:
	ldr	lr, [r3, #44]
	cmp	lr, r0
	bhi	.L13
.L14:
	add	r2, r2, #1
	add	r3, r3, #28
	cmp	r2, ip
	blt	.L15
.L13:
	cmp	ip, r2
	beq	.L30
	mov	r3, r2, asl #5
	ldr	ip, [fp, #-60]
	sub	r3, r3, r2, asl #2
	add	r3, r8, r3
	add	lr, ip, r2, lsl #8
	ldr	r3, [r3, #16]
	sub	r3, r3, #1
.L17:
	add	ip, r1, #16
	add	r1, r1, #252
	uxth	r0, r0
	add	r6, r6, #1
	orr	r3, r0, r3, asl #16
	sub	r0, r2, #1
	str	r3, [r5, ip]
	str	lr, [r5, r1]
	b	.L31
.L23:
	ldr	r10, [fp, #-64]
	mov	r2, r4
	mov	ip, r7
.L26:
	mov	r7, lr
	b	.L9
.L30:
	ldr	r3, [fp, #-56]
	mov	lr, #0
	ldrh	ip, [r3, #56]
	ldrh	r3, [r3, #58]
	mul	r3, r3, ip
	sub	r3, r3, #1
	b	.L17
.L33:
	.align	2
.L32:
	.word	g_HwMem
	.fnend
	.size	AVSHAL_V400R003_WirteSlicMsg, .-AVSHAL_V400R003_WirteSlicMsg
	.align	2
	.global	AVSHAL_V400R003_StartDec
	.type	AVSHAL_V400R003_StartDec, %function
AVSHAL_V400R003_StartDec:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #20
	sub	sp, sp, #20
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r3, .L73
	mov	r4, r0
	clz	r0, r2
	mov	r7, r2
	ldrb	r3, [r3]
	mov	r0, r0, lsr #5
	cmp	r3, #1
	moveq	r0, #0
	cmp	r0, #0
	bne	.L69
	cmp	r1, #0
	bgt	.L70
	ldrh	r3, [r4, #56]
	cmp	r3, #512
	bhi	.L39
	ldrh	r3, [r4, #58]
	cmp	r3, #512
	bhi	.L39
	cmp	r1, #0
	bne	.L67
	ldr	r9, .L73+4
	ldr	r3, [r9]
	cmp	r3, #0
	beq	.L71
.L43:
	add	r8, r4, #12288
	ldr	r0, [r8, #2144]
	cmp	r0, #0
	ble	.L45
	mov	r3, r4
	mov	r1, #0
	mvn	r6, #0
.L46:
	ldr	r2, [r3, #96]
	cmp	r2, #0
	beq	.L49
	ldr	ip, [r3, #104]
	bic	r2, r2, #15
	cmp	ip, #0
	ble	.L49
	cmp	r6, r2
	movcs	r6, r2
.L49:
	ldr	r2, [r3, #100]
	cmp	r2, #0
	beq	.L47
	ldr	ip, [r3, #108]
	bic	r2, r2, #15
	cmp	ip, #0
	ble	.L47
	cmp	r6, r2
	movcs	r6, r2
.L47:
	add	r1, r1, #1
	add	r3, r3, #28
	cmp	r1, r0
	bne	.L46
	cmn	r6, #1
	beq	.L45
	ldrh	r0, [r4, #56]
	mov	r5, #0
	ldrh	ip, [r4, #58]
	mov	r1, r5
	mov	lr, #65
	bfi	lr, r5, #1, #1
	mov	r3, r7
	mov	r2, r5
	mul	ip, ip, r0
	mov	r0, #8
	sub	ip, ip, #1
	bfi	r1, ip, #0, #20
	str	r1, [fp, #-48]
	strb	lr, [fp, #-45]
	mov	r1, r1, lsr #16
	orr	r1, r1, #64
	bfi	r1, r5, #7, #1
	strb	r1, [fp, #-46]
	ldr	r10, [fp, #-48]
	mov	r1, r10
	bl	MFDE_ConfigReg
	mov	r2, r10
	ldr	r1, .L73+8
	mov	r0, #3
	bl	dprint_vfmw
	mov	r3, #1
	mov	r1, #12288
	bfi	r1, r3, #0, #12
	ldr	r0, [r8, #2604]
	mov	r2, #0
	uxth	r3, r1
	strh	r1, [fp, #-46]
	bfi	r2, r0, #4, #1
	ldrb	r0, [r4, #16]
	mov	r3, r3, lsr #8
	ldr	r1, [r8, #2600]
	and	r3, r3, #239
	cmp	r0, #3
	cmpne	r0, #1
	bfi	r3, r5, #5, #1
	and	r2, r2, #16
	orr	ip, r2, #64
	movls	r0, #1
	uxtb	r3, r3
	movhi	r0, #0
	bfi	r3, r1, #6, #1
	bfi	ip, r0, #7, #1
	mov	r2, #6
	strb	ip, [fp, #-47]
	strb	r2, [fp, #-48]
	bfi	r3, r5, #7, #1
	strb	r3, [fp, #-45]
	mov	r2, r5
	ldr	r10, [fp, #-48]
	mov	r3, r7
	mov	r0, #12
	mov	r1, r10
	bl	MFDE_ConfigReg
	mov	r2, r10
	ldr	r1, .L73+12
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r10, [r9, #56]
	mov	r3, r7
	mov	r2, r5
	bic	r10, r10, #15
	mov	r0, #16
	mov	r1, r10
	bl	MFDE_ConfigReg
	mov	r2, r10
	ldr	r1, .L73+16
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r10, [r9, #40]
	mov	r3, r7
	mov	r2, r5
	bic	r10, r10, #15
	mov	r0, #20
	mov	r1, r10
	bl	MFDE_ConfigReg
	mov	r2, r10
	ldr	r1, .L73+20
	mov	r0, #3
	bl	dprint_vfmw
	mov	r3, r7
	mov	r2, r5
	mov	r1, r6
	mov	r0, #24
	str	r6, [fp, #-48]
	bl	MFDE_ConfigReg
	mov	r2, r6
	ldr	r1, .L73+24
	mov	r0, #3
	bl	dprint_vfmw
	ldrh	r1, [r4, #56]
	mov	r3, r7
	mov	r2, r5
	cmp	r1, #120
	mov	r0, #4
	movhi	r1, #0
	movls	r1, #1
	bl	SCD_ConfigReg
	movw	r1, #3075
	mov	r3, r7
	mov	r2, r5
	mov	r0, #60
	movt	r1, 48
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r7
	mov	r2, r5
	mov	r0, #64
	movt	r1, 48
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r7
	mov	r2, r5
	mov	r0, #68
	movt	r1, 48
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r7
	mov	r2, r5
	mov	r0, #72
	movt	r1, 48
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r7
	mov	r2, r5
	mov	r0, #76
	movt	r1, 48
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r7
	mov	r2, r5
	mov	r0, #80
	movt	r1, 48
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r7
	mov	r2, r5
	mov	r0, #84
	movt	r1, 48
	bl	MFDE_ConfigReg
	ldr	r10, [r8, #2160]
	mov	r3, r7
	mov	r2, r5
	bic	r10, r10, #15
	mov	r0, #96
	mov	r1, r10
	bl	MFDE_ConfigReg
	mov	r2, r10
	ldr	r1, .L73+28
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r10, [r8, #2564]
	mov	r3, r7
	mov	r2, r5
	mov	r0, #100
	mov	r1, r10
	bl	MFDE_ConfigReg
	mov	r2, r10
	ldr	r1, .L73+32
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r10, [r8, #2572]
	mov	r3, r7
	mov	r2, r5
	mov	r0, #104
	mov	r1, r10
	bl	MFDE_ConfigReg
	mov	r2, r10
	ldr	r1, .L73+36
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r10, [r8, #2580]
	mov	r3, r7
	mov	r2, r5
	mov	r0, #108
	mov	r1, r10
	bl	MFDE_ConfigReg
	mov	r2, r10
	ldr	r1, .L73+40
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r10, [r9, #1204]
	mov	r3, r7
	mov	r2, r5
	mov	r0, #144
	mov	r1, r10
	bl	MFDE_ConfigReg
	mov	r2, r10
	ldr	r1, .L73+44
	mov	r0, #3
	bl	dprint_vfmw
	mov	r3, r7
	mov	r2, r5
	mov	r1, r5
	mov	r0, #148
	bl	MFDE_ConfigReg
	mov	r2, r5
	ldr	r1, .L73+48
	mov	r0, #3
	bl	dprint_vfmw
	mov	r3, r7
	mov	r2, r5
	mov	r1, r5
	mov	r0, #152
	bl	MFDE_ConfigReg
	mov	r2, r5
	ldr	r1, .L73+52
	mov	r0, #3
	bl	dprint_vfmw
	mov	r3, r7
	mvn	r1, #0
	mov	r2, r5
	mov	r0, #32
	str	r1, [fp, #-48]
	bl	MFDE_ConfigReg
	ldr	r0, [r9, #56]
	bl	MEM_Phy2Vir
	subs	r7, r0, #0
	beq	.L72
	ldrh	r3, [r4, #58]
	mov	r0, #4
	ldrh	r1, [fp, #-46]
	sub	r3, r3, #1
	ldrh	lr, [r4, #56]
	bfi	r1, r3, #0, #9
	ldrb	ip, [r4, #40]
	ldrh	r2, [fp, #-48]
	sub	lr, lr, #1
	mov	r3, r1, lsr #8
	strh	r1, [fp, #-46]
	bfi	r2, lr, #0, #9
	bfi	r3, ip, #1, #2
	ldrb	ip, [r4, #39]
	mov	r1, r2, lsr #8
	strh	r2, [fp, #-48]
	bfi	r3, ip, #3, #2
	bfi	r1, r5, #1, #7
	bfi	r3, r5, #5, #3
	strb	r1, [fp, #-47]
	strb	r3, [fp, #-45]
	ldr	r2, [fp, #-48]
	ldr	r1, .L73+56
	str	r2, [r7]
	bl	dprint_vfmw
	ldrb	r3, [r4, #25]
	ldrb	r1, [r4, #17]
	mov	r0, #4
	ldrb	r2, [r4, #16]
	and	r3, r3, #1
	ldrb	ip, [r4, #24]
	bfi	r3, r1, #1, #2
	bfi	r3, r2, #3, #2
	ldrb	r1, [r4, #19]
	ldrb	r2, [r4, #21]
	bfi	r3, ip, #5, #1
	ldrb	lr, [r4, #23]
	and	r1, r1, #1
	ldrb	ip, [r4, #20]
	and	r2, r2, #63
	ldrb	r10, [r4, #18]
	bfi	r3, lr, #6, #1
	str	r5, [fp, #-48]
	bfi	r2, ip, #6, #1
	bfi	r1, r10, #1, #1
	ldrb	ip, [r4, #31]
	strb	r1, [fp, #-46]
	ldrb	r1, [r4, #22]
	bfi	r2, ip, #7, #1
	ldrh	lr, [fp, #-46]
	bfi	r3, r1, #7, #1
	strb	r2, [fp, #-47]
	bfi	lr, r5, #2, #14
	strb	r3, [fp, #-48]
	strh	lr, [fp, #-46]
	ldr	r2, [fp, #-48]
	ldr	r1, .L73+60
	str	r2, [r7, #4]
	bl	dprint_vfmw
	ldrb	r3, [r4, #29]
	ldrb	r2, [r4, #28]
	mov	r0, #4
	ldrb	r1, [r4, #27]
	and	r3, r3, #1
	bfi	r3, r2, #1, #1
	str	r5, [fp, #-48]
	ldrb	r2, [r4, #26]
	bfi	r3, r1, #2, #5
	strb	r3, [fp, #-48]
	ldrh	r3, [fp, #-48]
	ldr	r1, .L73+64
	bfi	r3, r2, #7, #5
	strh	r3, [fp, #-48]
	ldr	r2, [fp, #-48]
	str	r2, [r7, #8]
	bl	dprint_vfmw
	ldrb	r3, [r4, #34]
	ldrb	r2, [r4, #35]
	mov	r0, #4
	ldrb	ip, [r4, #36]
	and	r3, r3, #1
	ldrb	r1, [r4, #37]
	bfi	r3, r2, #1, #2
	bfi	r3, ip, #3, #1
	ldrb	r2, [r4, #32]
	bfi	r3, r1, #4, #2
	ldrb	ip, [r4, #33]
	str	r5, [fp, #-48]
	bfi	r3, r2, #6, #1
	strb	r3, [fp, #-48]
	ldrh	r3, [fp, #-48]
	ldr	r1, .L73+68
	bfi	r3, ip, #7, #2
	strh	r3, [fp, #-48]
	ldr	r2, [fp, #-48]
	bfi	r2, r5, #9, #23
	str	r2, [fp, #-48]
	str	r2, [r7, #12]
	bl	dprint_vfmw
	ldr	r2, [r8, #2148]
	ldr	r1, .L73+72
	mov	r0, #4
	bic	r2, r2, #15
	str	r2, [r7, #16]
	bl	dprint_vfmw
	ldr	r2, [r8, #2152]
	ldr	r1, .L73+76
	mov	r0, #4
	bic	r2, r2, #15
	str	r2, [r7, #20]
	bl	dprint_vfmw
	ldr	r2, [r8, #2156]
	ldr	r1, .L73+80
	mov	r0, #4
	bic	r2, r2, #15
	str	r2, [r7, #24]
	bl	dprint_vfmw
	ldr	r2, [r8, #2172]
	ldr	r1, .L73+84
	mov	r0, #4
	bic	r2, r2, #15
	str	r2, [r7, #28]
	bl	dprint_vfmw
	ldrb	r3, [r4, #38]
	ldrb	r1, [r4, #30]
	mov	r2, #0
	str	r5, [fp, #-48]
	bfi	r2, r3, #0, #1
	mov	r3, #0
	strb	r2, [fp, #-48]
	bfi	r3, r1, #0, #2
	strb	r3, [fp, #-45]
	ldr	r2, [fp, #-48]
	mov	r0, #4
	ldr	r1, .L73+88
	str	r2, [r7, #32]
	bl	dprint_vfmw
	ldr	r2, [r4, #72]
	mov	r3, r5
	ldr	r1, .L73+92
	bfi	r3, r2, #0, #24
	mov	r0, #4
	str	r3, [fp, #-48]
	mov	r2, r3
	str	r3, [r7, #36]
	bl	dprint_vfmw
	ldr	r1, [r4, #88]
	ldr	r2, [r4, #80]
	mov	r3, r5
	bfi	r3, r1, #0, #24
	str	r3, [fp, #-48]
	ldrb	r3, [fp, #-45]
	mov	r0, #4
	ldr	r1, .L73+96
	bfi	r3, r2, #0, #7
	strb	r3, [fp, #-45]
	ldr	r2, [fp, #-48]
	str	r2, [r7, #40]
	bl	dprint_vfmw
	ldr	r2, [r4, #76]
	mov	r3, r5
	ldr	r1, .L73+100
	bfi	r3, r2, #0, #24
	mov	r0, #4
	str	r3, [fp, #-48]
	mov	r2, r3
	str	r3, [r7, #44]
	bl	dprint_vfmw
	ldrb	r2, [r4, #41]
	ldrb	r3, [r4, #43]
	mov	r1, #0
	ldrb	ip, [r4, #42]
	and	r2, r2, #1
	ldrb	r0, [r4, #45]
	and	r3, r3, #63
	ldrb	lr, [r4, #44]
	bfi	r2, ip, #1, #1
	bfi	r3, r0, #6, #1
	ldrb	ip, [r4, #46]
	ldrb	r0, [r4, #47]
	bfi	r2, lr, #2, #6
	bfi	r3, ip, #7, #1
	str	r5, [fp, #-48]
	bfi	r1, r0, #0, #1
	strb	r3, [fp, #-47]
	strb	r1, [fp, #-46]
	mov	r0, #4
	strb	r2, [fp, #-48]
	ldr	r2, [fp, #-48]
	ldr	r1, .L73+104
	str	r2, [r7, #48]
	bl	dprint_vfmw
	ldr	r3, .L73+4
	ldr	r1, .L73+108
	mov	r0, #4
	ldr	r2, [r3, #1148]
	bic	r2, r2, #15
	str	r2, [r7, #52]
	bl	dprint_vfmw
	ldr	r3, .L73+4
	ldr	r1, .L73+112
	mov	r0, #4
	ldr	r2, [r3, #1152]
	bic	r2, r2, #15
	str	r2, [r7, #56]
	bl	dprint_vfmw
	ldr	r2, [r8, #2168]
	ldr	r1, .L73+116
	mov	r0, #4
	bic	r2, r2, #15
	str	r2, [r7, #64]
	bl	dprint_vfmw
	add	r3, r4, #14464
	add	r2, r7, #68
	add	r0, r4, #14592
.L54:
	ldr	r1, [r3, #4]!
	cmp	r3, r0
	str	r1, [r2], #4
	bne	.L54
	ldr	r2, [r8, #2164]
	mov	r0, #4
	ldr	r1, .L73+120
	bic	r2, r2, #15
	str	r2, [r7, #196]
	bl	dprint_vfmw
	ldr	r2, [r9, #1160]
	ldr	r1, .L73+124
	mov	r0, #4
	bic	r2, r2, #15
	str	r2, [r7, #200]
	bl	dprint_vfmw
	ldr	r2, [r9, #1144]
	ldr	r1, .L73+128
	mov	r0, #4
	bic	r2, r2, #15
	str	r2, [r7, #204]
	bl	dprint_vfmw
	ldr	r2, [r9, #56]
	ldr	r1, .L73+132
	mov	r0, #4
	add	r2, r2, #320
	str	r2, [r7, #252]
	str	r2, [fp, #-48]
	bl	dprint_vfmw
	ldrb	lr, [r4, #41]
	cmp	lr, #1
	beq	.L55
.L59:
	mov	r0, r4
	mov	r1, r6
	mov	r2, #0
	bl	AVSHAL_V400R003_WirteSlicMsg
	mov	r0, #0
.L36:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L55:
	add	ip, r4, #14592
	add	r5, r7, #256
	add	ip, ip, #28
	add	r7, r7, #320
.L58:
	tst	lr, #1
	add	ip, ip, #16
	add	lr, lr, #1
	ldrneb	r1, [ip, #-24]
	ldreqb	r1, [ip, #-36]
	ldrneb	r3, [ip, #-16]
	ldreqb	r3, [ip, #-28]
	movne	r1, r1, asl #16
	ldrneb	r2, [ip, #-40]
	moveq	r1, r1, asl #16
	ldrneb	r0, [ip, #-32]
	ldreqb	r2, [ip, #-52]
	orr	r3, r1, r3, asl #24
	ldreqb	r0, [ip, #-44]
	orr	r3, r3, r2
	orr	r3, r3, r0, asl #8
	str	r3, [r5], #4
	cmp	r5, r7
	bne	.L58
	b	.L59
.L71:
	mov	r0, #0
	movt	r0, 63683
	bl	MEM_Phy2Vir
	subs	r3, r0, #0
	beq	.L44
	str	r3, [r9]
	b	.L43
.L70:
	mov	r3, r1
	str	r0, [sp]
	ldr	r2, .L73+136
	ldr	r1, .L73+140
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L36
.L39:
	ldr	r3, .L73+144
	mov	r0, #0
	ldr	r2, .L73+136
	ldr	r1, .L73+148
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L36
.L45:
	mvn	r2, #0
	ldr	r1, .L73+152
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L36
.L67:
	ldr	r1, .L73+156
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L36
.L72:
	ldr	r3, .L73+160
	ldr	r2, .L73+136
	ldr	r1, .L73+148
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L36
.L69:
	mov	r3, r2
	ldr	r1, .L73+164
	ldr	r2, .L73+136
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L36
.L44:
	ldr	r1, .L73+168
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L36
.L74:
	.align	2
.L73:
	.word	g_HalDisable
	.word	g_HwMem
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	.LC11
	.word	.LC12
	.word	.LC13
	.word	.LC14
	.word	.LC15
	.word	.LC16
	.word	.LC17
	.word	.LC18
	.word	.LC20
	.word	.LC21
	.word	.LC22
	.word	.LC23
	.word	.LC24
	.word	.LC25
	.word	.LC26
	.word	.LC27
	.word	.LC28
	.word	.LC29
	.word	.LC30
	.word	.LC31
	.word	.LC32
	.word	.LC33
	.word	.LC34
	.word	.LC35
	.word	.LC36
	.word	.LC37
	.word	.LC38
	.word	.LC39
	.word	.LANCHOR0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC6
	.word	.LC4
	.word	.LC19
	.word	.LC0
	.word	.LC5
	.fnend
	.size	AVSHAL_V400R003_StartDec, .-AVSHAL_V400R003_StartDec
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	__func__.15187, %object
	.size	__func__.15187, 25
__func__.15187:
	.ascii	"AVSHAL_V400R003_StartDec\000"
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"%s: pMfdeTask(%p) = NULL\012\000"
	.space	2
.LC1:
	.ascii	"%s: VdhId(%d) > %d\012\000"
.LC2:
	.ascii	"picture width out of range\000"
	.space	1
.LC3:
	.ascii	"%s: %s\012\000"
.LC4:
	.ascii	"VdhId is wrong! AVSHAL_V200R003_StartDec\012\000"
	.space	2
.LC5:
	.ascii	"vdm register virtual address not mapped, reset fail"
	.ascii	"ed!\012\000"
.LC6:
	.ascii	"stream_base_addr = %#x\012\000"
.LC7:
	.ascii	"BASIC_V400R003_CFG0 = 0x%x\012\000"
.LC8:
	.ascii	"BASIC_V400R003_CFG1 = 0x%x\012\000"
.LC9:
	.ascii	"AVM_V400R003_ADDR = 0x%x\012\000"
	.space	2
.LC10:
	.ascii	"VAM_V400R003_ADDR = 0x%x\012\000"
	.space	2
.LC11:
	.ascii	"STREAM_V400R003_BASE_ADDR = 0x%x\012\000"
	.space	2
.LC12:
	.ascii	"YSTADDR_V400R003_1D = 0x%x\012\000"
.LC13:
	.ascii	"YSTRIDE_V400R003_1D = 0x%x\012\000"
.LC14:
	.ascii	"UVOFFSET_V400R003_1D = 0x%x\012\000"
	.space	3
.LC15:
	.ascii	"HEAD_INF_OFFSET = 0x%x\012\000"
.LC16:
	.ascii	"VREG_V400R003_DNR_MBINFO_STADDR = 0x%x\012\000"
.LC17:
	.ascii	"VREG_V200R003_REF_PIC_TYPE = 0x%x\012\000"
	.space	1
.LC18:
	.ascii	"VREG_V400R003_FF_APT_EN = 0x%x\012\000"
.LC19:
	.ascii	"can not map down msg virtual address!\000"
	.space	2
.LC20:
	.ascii	"D0 = 0x%x\012\000"
	.space	1
.LC21:
	.ascii	"D1 = 0x%x\012\000"
	.space	1
.LC22:
	.ascii	"D2 = 0x%x\012\000"
	.space	1
.LC23:
	.ascii	"D3 = 0x%x\012\000"
	.space	1
.LC24:
	.ascii	"D4 = 0x%x\012\000"
	.space	1
.LC25:
	.ascii	"D5 = 0x%x\012\000"
	.space	1
.LC26:
	.ascii	"D6 = 0x%x\012\000"
	.space	1
.LC27:
	.ascii	"D7 = 0x%x\012\000"
	.space	1
.LC28:
	.ascii	"D8 = 0x%x\012\000"
	.space	1
.LC29:
	.ascii	"D9 = 0x%x\012\000"
	.space	1
.LC30:
	.ascii	"D10 = 0x%x\012\000"
.LC31:
	.ascii	"D11 = 0x%x\012\000"
.LC32:
	.ascii	"D12 = 0x%x\012\000"
.LC33:
	.ascii	"D13 = 0x%x\012\000"
.LC34:
	.ascii	"D14 = 0x%x\012\000"
.LC35:
	.ascii	"D16 = 0x%x\012\000"
.LC36:
	.ascii	"D49 = 0x%x\012\000"
.LC37:
	.ascii	"D50 = 0x%x\012\000"
.LC38:
	.ascii	"D51 = 0x%x\012\000"
.LC39:
	.ascii	"D63 = 0x%x\012\000"
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
