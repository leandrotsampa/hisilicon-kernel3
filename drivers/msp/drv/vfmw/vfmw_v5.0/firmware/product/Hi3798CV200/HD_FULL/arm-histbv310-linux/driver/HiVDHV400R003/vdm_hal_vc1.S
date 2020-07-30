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
	.file	"vdm_hal_vc1.c"

	.text
	.align	2
	.global	VC1HAL_V400R003_InitHal
	.type	VC1HAL_V400R003_InitHal, %function
VC1HAL_V400R003_InitHal:
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
	.size	VC1HAL_V400R003_InitHal, .-VC1HAL_V400R003_InitHal
	.align	2
	.global	VC1HAL_V400R003_CfgSliceMsg
	.type	VC1HAL_V400R003_CfgSliceMsg, %function
VC1HAL_V400R003_CfgSliceMsg:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #52
	sub	sp, sp, #52
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r3, [r1, #60]
	add	r2, r0, #84
	mov	r10, r0
	str	r2, [fp, #-52]
	mov	r0, r3
	str	r3, [fp, #-56]
	bl	MEM_Phy2Vir
	subs	r5, r0, #0
	beq	.L57
	ldrb	r3, [r10, #4]
	cmp	r3, #2
	beq	.L58
	ldr	lr, [r10, #96]
	add	r3, r10, #12288
	str	r3, [fp, #-48]
	bic	r8, lr, #15
	str	r8, [r3, #172]
	ldrb	r0, [r10, #70]
	cmp	r0, #0
	ble	.L2
	mov	r1, #0
	add	r6, r10, #144
	mov	r7, r1
	cmp	r7, #0
	mov	ip, r5
	mov	r4, r1
	bne	.L25
.L59:
	cmp	r0, #1
	ldr	r4, [r10, #108]
	beq	.L43
	ble	.L27
	ldr	r3, [r10, #156]
	cmp	r4, r3
	blt	.L27
	ldr	r3, [fp, #-52]
	mov	r1, #1
	b	.L28
.L30:
	ldr	r2, [r3, #72]
	cmp	r4, r2
	blt	.L38
.L28:
	add	r1, r1, #1
	add	r3, r3, #48
	cmp	r1, r0
	bne	.L30
.L55:
	mov	r3, #0
.L31:
	mov	r2, #0
.L26:
	ldr	r5, [r6, #-44]
	rsb	lr, r8, lr
	ldr	r0, [r6, #-40]
	add	r2, r2, r4, lsl #16
	add	r5, r5, lr, lsl #3
	bic	lr, lr, #15
	add	r7, r7, #1
	add	r6, r6, #48
	add	r0, r0, r5, lsl #25
	str	r0, [ip]
	str	lr, [ip, #4]
	mov	r0, #0
	str	r0, [ip, #8]
	add	ip, ip, #256
	str	r0, [ip, #-244]
	str	r2, [ip, #-240]
	str	r3, [ip, #-4]
	ldrb	r0, [r10, #70]
	cmp	r0, r7
	ble	.L2
	ldr	r3, [fp, #-48]
	cmp	r7, #0
	ldr	lr, [r6, #-48]
	ldr	r8, [r3, #172]
	beq	.L59
.L25:
	ldr	r5, [fp, #-52]
	mov	r3, r1, asl #6
	add	r2, r1, #1
	sub	r3, r3, r1, asl #4
	add	r3, r5, r3
	cmp	r2, r0
	ldr	r5, [r3, #24]
	bge	.L32
	ldr	r9, [r3, #72]
	cmp	r5, r9
	blt	.L32
	mov	r9, r1
	b	.L33
.L34:
	ldr	r1, [r3, #72]
	cmp	r5, r1
	blt	.L54
.L33:
	add	r2, r2, #1
	add	r3, r3, #48
	cmp	r2, r0
	blt	.L34
.L54:
	mov	r1, r9
.L32:
	cmp	r2, r0
	ldrne	r3, [fp, #-56]
	movne	r1, r2
	moveq	r3, #0
	addne	r3, r3, r2, lsl #8
	add	r2, r4, #1
	mov	r4, r5
	b	.L26
.L27:
	cmp	r0, #1
	beq	.L44
	mov	r1, #1
.L38:
	ldr	r3, [fp, #-56]
	add	r3, r3, r1, lsl #8
	b	.L31
.L57:
	ldr	r2, .L60
	ldr	r1, .L60+4
	bl	dprint_vfmw
.L2:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L43:
	mov	r3, r7
	mov	r2, r7
	b	.L26
.L58:
	ldr	r0, [r10, #96]
	add	r3, r10, #12288
	str	r3, [fp, #-48]
	mov	lr, r3
	str	r0, [r3, #172]
	ldrb	r2, [r10, #70]
	cmp	r2, #0
	ble	.L6
	mov	r3, r10
	mov	r1, #0
.L9:
	ldr	ip, [r3, #88]
	cmp	ip, #0
	beq	.L7
	ldr	ip, [r3, #112]
	cmp	ip, r0
	strcc	ip, [lr, #172]
	movcc	r0, ip
	bcc	.L8
.L7:
	ldr	ip, [r3, #96]
	cmp	ip, r0
	strcc	ip, [lr, #172]
	movcc	r0, ip
.L8:
	add	r1, r1, #1
	add	r3, r3, #48
	cmp	r1, r2
	bne	.L9
.L6:
	ldr	r3, [fp, #-48]
	bic	r0, r0, #15
	ldr	r1, .L60+8
	str	r0, [r3, #172]
	mov	r0, #4
	bl	dprint_vfmw
	ldrb	r8, [r10, #70]
	cmp	r8, #0
	ble	.L2
	mov	r4, #0
	mov	r7, r5
	mov	ip, r4
	mov	r5, r10
	mov	r6, r4
	str	r10, [fp, #-84]
.L23:
	ldr	r3, [fp, #-48]
	ldr	r2, [r5, #96]
	ldr	r1, [r5, #88]
	ldr	r3, [r3, #172]
	ldr	r9, [r5, #100]
	cmp	r1, #0
	rsb	r2, r3, r2
	ldr	r0, [r5, #104]
	and	lr, r2, #15
	bic	r2, r2, #15
	str	r2, [fp, #-64]
	add	lr, r9, lr, lsl #3
	beq	.L39
	ldr	r10, [r5, #112]
	ldr	r9, [r5, #116]
	rsb	r10, r3, r10
	ldr	r3, [r5, #120]
	str	r10, [fp, #-72]
	add	r9, r9, r10, lsl #3
	add	r9, r3, r9, lsl #25
	str	r9, [fp, #-68]
.L11:
	cmp	ip, #0
	bne	.L12
	ldr	r3, [fp, #-84]
	cmp	r8, #1
	ldr	r6, [r3, #108]
	beq	.L40
	ble	.L14
	ldr	r3, [r3, #156]
	cmp	r6, r3
	blt	.L14
	ldr	r3, [fp, #-52]
	mov	r4, #1
	b	.L15
.L17:
	ldr	r2, [r3, #72]
	cmp	r6, r2
	blt	.L37
.L15:
	add	r4, r4, #1
	add	r3, r3, #48
	cmp	r4, r8
	bne	.L17
	mov	r3, #0
	mov	r8, r3
.L18:
	mov	r2, #0
	str	r2, [fp, #-80]
.L13:
	add	r2, r0, lr, lsl #25
	ldr	r1, .L60+12
	str	r2, [r7]
	mov	r0, #4
	add	ip, ip, #1
	str	r3, [fp, #-76]
	str	ip, [fp, #-60]
	add	r5, r5, #48
	str	ip, [fp, #-88]
	bl	dprint_vfmw
	ldr	r3, [fp, #-64]
	mov	r0, #4
	ldr	r1, .L60+16
	add	r7, r7, #256
	str	r3, [r7, #-252]
	mov	r2, r3
	bl	dprint_vfmw
	ldr	r3, [fp, #-68]
	mov	r2, r9
	ldr	r1, .L60+20
	mov	r0, #4
	str	r3, [r7, #-248]
	bl	dprint_vfmw
	ldr	r3, [fp, #-72]
	mov	r2, r10
	ldr	r1, .L60+24
	mov	r0, #4
	str	r3, [r7, #-244]
	bl	dprint_vfmw
	ldr	r3, [fp, #-80]
	ldr	r1, .L60+28
	mov	r0, #4
	add	r2, r3, r6, lsl #16
	str	r2, [r7, #-240]
	bl	dprint_vfmw
	ldr	r3, [fp, #-76]
	mov	r2, r8
	ldr	r1, .L60+32
	mov	r0, #4
	str	r3, [r7, #-4]
	bl	dprint_vfmw
	ldr	r3, [fp, #-84]
	ldr	ip, [fp, #-60]
	ldrb	r8, [r3, #70]
	cmp	r8, ip
	bgt	.L23
	b	.L2
.L12:
	ldr	r1, [fp, #-52]
	mov	r3, r4, asl #6
	add	r2, r4, #1
	sub	r3, r3, r4, asl #4
	add	r3, r1, r3
	cmp	r2, r8
	str	r2, [fp, #-60]
	ldr	r1, [r3, #24]
	bge	.L19
	ldr	r2, [r3, #72]
	cmp	r1, r2
	blt	.L19
	str	r0, [fp, #-76]
	ldr	r2, [fp, #-60]
	b	.L20
.L21:
	ldr	r0, [r3, #72]
	cmp	r1, r0
	blt	.L52
.L20:
	add	r2, r2, #1
	add	r3, r3, #48
	cmp	r2, r8
	blt	.L21
.L52:
	ldr	r0, [fp, #-76]
	str	r2, [fp, #-60]
.L19:
	ldr	r2, [fp, #-60]
	cmp	r2, r8
	ldrne	r3, [fp, #-56]
	moveq	r3, #0
	movne	r4, r2
	moveq	r8, r3
	addne	r8, r3, r2, lsl #8
	add	r2, r6, #1
	mov	r6, r1
	str	r2, [fp, #-80]
	movne	r3, r8
	b	.L13
.L14:
	cmp	r8, #1
	beq	.L41
	mov	r4, #1
.L37:
	ldr	r3, [fp, #-56]
	add	r8, r3, r4, lsl #8
	mov	r3, r8
	b	.L18
.L39:
	mov	r10, r1
	str	r1, [fp, #-72]
	str	r1, [fp, #-68]
	mov	r9, r1
	b	.L11
.L40:
	mov	r3, ip
	str	ip, [fp, #-80]
	mov	r8, ip
	b	.L13
.L41:
	mov	r3, #0
	mov	r4, r8
	mov	r8, r3
	b	.L18
.L44:
	mov	r1, r0
	b	.L55
.L61:
	.align	2
.L60:
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.fnend
	.size	VC1HAL_V400R003_CfgSliceMsg, .-VC1HAL_V400R003_CfgSliceMsg
	.align	2
	.global	VC1HAL_V400R003_CfgReg
	.type	VC1HAL_V400R003_CfgReg, %function
VC1HAL_V400R003_CfgReg:
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
	subs	r4, r2, #0
	mov	r9, #0
	mov	r7, r0
	mov	r8, r1
	mov	r5, r3
	str	r9, [fp, #-48]
	bgt	.L67
	add	r6, r0, #12288
	mov	r0, #8
	ldr	r1, [r6, #164]
	ubfx	r1, r1, #0, #20
	orr	r1, r1, #1090519040
	bl	MFDE_ConfigReg
	ldrh	r2, [fp, #-46]
	mov	r1, #1
	ldr	ip, [r6, #260]
	bfi	r2, r1, #0, #12
	strh	r2, [fp, #-46]
	ldrb	lr, [fp, #-47]
	mov	r3, r5
	mov	r2, r2, lsr #8
	ldr	r0, [r6, #256]
	and	r2, r2, #239
	bfi	lr, ip, #4, #1
	bfi	r2, r9, #5, #1
	ldrb	r10, [fp, #-48]
	and	lr, lr, #223
	uxtb	r2, r2
	orr	lr, lr, #192
	bfi	r2, r0, #6, #1
	strb	lr, [fp, #-47]
	bfi	r10, r1, #0, #4
	bfi	r2, r9, #7, #1
	strb	r10, [fp, #-48]
	mov	r0, #12
	strb	r2, [fp, #-45]
	mov	r2, r4
	ldr	r1, [fp, #-48]
	str	r1, [r6, #168]
	bl	MFDE_ConfigReg
	mov	r3, r5
	mov	r2, r4
	ldr	r1, [r8, #56]
	mov	r0, #16
	bl	MFDE_ConfigReg
	mov	r3, r5
	mov	r2, r4
	ldr	r1, [r8, #40]
	mov	r0, #20
	bl	MFDE_ConfigReg
	ldr	ip, [r6, #172]
	mov	r3, r5
	mov	r2, r4
	mov	r0, #24
	mov	r1, ip
	str	ip, [fp, #-48]
	bl	MFDE_ConfigReg
	ldrh	r1, [r7, #78]
	mov	r3, r5
	mov	r2, r4
	cmp	r1, #256
	mov	r0, #4
	movhi	r1, #0
	movls	r1, #1
	bl	SCD_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, r4
	mov	r0, #60
	movt	r1, 48
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, r4
	mov	r0, #64
	movt	r1, 48
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, r4
	mov	r0, #68
	movt	r1, 48
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, r4
	mov	r0, #72
	movt	r1, 48
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, r4
	mov	r0, #76
	movt	r1, 48
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, r4
	mov	r0, #80
	movt	r1, 48
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, r4
	mov	r0, #84
	movt	r1, 48
	bl	MFDE_ConfigReg
	mov	r3, r5
	mov	r2, r4
	ldr	r1, [r6, #224]
	mov	r0, #96
	bl	MFDE_ConfigReg
	ldr	r1, [r6, #176]
	mov	r3, r5
	mov	r2, r4
	mov	r0, #100
	str	r1, [r6, #228]
	bl	MFDE_ConfigReg
	ldr	r1, [r6, #180]
	mov	r3, r5
	mov	r2, r4
	mov	r0, #104
	str	r1, [r6, #232]
	bl	MFDE_ConfigReg
	mov	r3, r5
	mov	r2, r4
	ldrb	r1, [r7, #69]
	mov	r0, #152
	bl	MFDE_ConfigReg
	mov	r3, r5
	mov	r2, r4
	ldrb	r1, [r7, #68]
	mov	r0, #148
	bl	MFDE_ConfigReg
	mov	r3, r5
	mov	r2, r4
	ldr	r1, [r6, #188]
	mov	r0, #108
	bl	MFDE_ConfigReg
	mov	r3, r5
	mov	r2, r4
	mvn	r1, #0
	mov	r0, #32
	bl	MFDE_ConfigReg
	mov	r0, r9
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L67:
	str	r9, [sp]
	mov	r3, r4
	mov	r0, r9
	ldr	r2, .L68
	ldr	r1, .L68+4
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L69:
	.align	2
.L68:
	.word	.LANCHOR0+28
	.word	.LC8
	.fnend
	.size	VC1HAL_V400R003_CfgReg, .-VC1HAL_V400R003_CfgReg
	.align	2
	.global	VC1HAL_V400R003_CfgDnMsg
	.type	VC1HAL_V400R003_CfgDnMsg, %function
VC1HAL_V400R003_CfgDnMsg:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #52
	sub	sp, sp, #52
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r4, r0
	ldr	r0, [r1, #56]
	mov	r6, r1
	bl	MEM_Phy2Vir
	subs	r3, r0, #0
	beq	.L74
	ldrb	r1, [r4, #4]
	mov	r2, #0
	ldrb	r0, [r4, #3]
	mov	r5, #0
	ldrb	ip, [r4, #5]
	bfi	r2, r1, #4, #2
	str	r5, [fp, #-48]
	bfi	r2, r0, #0, #2
	mov	r1, #0
	strb	r2, [fp, #-48]
	bfi	r1, ip, #6, #2
	strb	r1, [fp, #-47]
	ldr	r1, [fp, #-48]
	mov	r2, #0
	str	r5, [fp, #-48]
	mov	r8, r2
	strb	r2, [fp, #-60]
	mov	lr, r2
	str	r1, [r3]
	mov	ip, r2
	ldrh	r10, [r4, #80]
	mov	r1, r2
	ldrh	r9, [r4, #78]
	mov	r0, r2
	mov	r7, r2
	strb	r2, [fp, #-68]
	strb	r10, [fp, #-46]
	mov	r10, r2
	strb	r9, [fp, #-48]
	ldr	r9, [fp, #-48]
	strb	r2, [fp, #-76]
	ldr	r2, [fp, #-60]
	str	r9, [r3, #4]
	ldrb	r9, [r4, #8]
	str	r5, [fp, #-48]
	bfi	r2, r9, #2, #1
	ldrb	r9, [r4, #6]
	bfi	r2, r9, #0, #1
	ldrb	r9, [r4, #9]
	bfi	r2, r9, #3, #1
	ldrb	r9, [r4, #7]
	bfi	r2, r9, #1, #1
	ldrb	r9, [r4, #10]
	bfi	r2, r9, #4, #2
	ldrb	r9, [r4, #11]
	bfi	r2, r9, #6, #2
	strb	r2, [fp, #-48]
	ldr	r2, [fp, #-48]
	str	r5, [fp, #-48]
	str	r2, [r3, #8]
	ldrb	r2, [r4, #15]
	bfi	r0, r2, #4, #2
	ldrb	r2, [r4, #13]
	bfi	r0, r2, #1, #1
	ldrb	r2, [r4, #14]
	bfi	r0, r2, #2, #1
	ldrb	r2, [r4, #12]
	strb	lr, [fp, #-84]
	bfi	r0, r2, #0, #1
	strb	r0, [fp, #-48]
	ldr	r0, [fp, #-48]
	mov	r2, r8
	strb	ip, [fp, #-92]
	str	r0, [r3, #12]
	ldrb	r0, [r4, #19]
	ldrb	r9, [r4, #18]
	bfi	r7, r0, #0, #1
	ldrb	r0, [r4, #17]
	strb	r7, [fp, #-45]
	bfi	r8, r9, #0, #5
	bfi	lr, r0, #0, #5
	ldrb	r0, [r4, #16]
	strb	r8, [fp, #-46]
	mov	r8, r1
	strb	lr, [fp, #-47]
	bfi	ip, r0, #0, #5
	strb	ip, [fp, #-48]
	add	r0, r4, #12288
	ldr	ip, [fp, #-48]
	str	r5, [fp, #-48]
	str	ip, [r3, #16]
	ldrb	ip, [r4, #24]
	ldrb	lr, [r4, #23]
	bfi	r1, ip, #4, #1
	ldrb	ip, [r4, #20]
	bfi	r1, lr, #0, #2
	ldrb	lr, [r4, #22]
	and	ip, ip, #1
	ldrb	r7, [r4, #25]
	bfi	ip, lr, #2, #2
	ldrb	lr, [r4, #21]
	bfi	r1, r7, #6, #1
	strb	r1, [fp, #-47]
	bfi	ip, lr, #1, #1
	ldrb	r1, [r4, #26]
	ldr	lr, [fp, #-68]
	mov	r7, r2
	strb	ip, [fp, #-48]
	bfi	lr, r1, #0, #4
	strb	lr, [fp, #-46]
	ldr	r1, [fp, #-48]
	mov	lr, r10
	str	r5, [fp, #-48]
	str	r1, [r3, #20]
	ldrb	r1, [r4, #27]
	ldrb	ip, [r4, #28]
	and	r1, r1, #7
	bfi	r1, ip, #4, #2
	strb	r1, [fp, #-48]
	ldr	r1, [fp, #-48]
	mov	ip, r10
	ldr	r9, [fp, #-76]
	str	r5, [fp, #-48]
	str	r1, [r3, #24]
	ldrb	r1, [r4, #34]
	bfi	r10, r1, #6, #1
	ldrb	r1, [r4, #33]
	bfi	r10, r1, #4, #2
	ldrb	r1, [r4, #30]
	strb	r10, [fp, #-47]
	bfi	r9, r1, #1, #1
	mov	r1, r9
	ldrb	r9, [r4, #29]
	bfi	r1, r9, #0, #1
	ldrb	r9, [r4, #31]
	bfi	r1, r9, #2, #2
	ldrb	r9, [r4, #32]
	strb	r1, [fp, #-48]
	ldrh	r1, [fp, #-48]
	bfi	r1, r9, #4, #5
	strh	r1, [fp, #-48]
	ldr	r1, [fp, #-48]
	str	r5, [fp, #-48]
	str	r1, [r3, #28]
	ldrb	r1, [r4, #35]
	ldrb	r9, [r4, #36]
	and	r1, r1, #1
	ldrb	r10, [r4, #39]
	bfi	r1, r9, #1, #1
	ldrb	r9, [r4, #37]
	bfi	r1, r9, #2, #1
	ldrb	r9, [r4, #38]
	bfi	r1, r9, #4, #2
	ldrb	r9, [r4, #40]
	bfi	r1, r10, #6, #2
	ldr	r10, [fp, #-60]
	strb	r1, [fp, #-48]
	bfi	r10, r9, #0, #2
	strb	r10, [fp, #-47]
	ldr	r1, [fp, #-48]
	str	r5, [fp, #-48]
	str	r1, [r3, #32]
	ldrb	r1, [r4, #46]
	ldrb	r9, [r4, #42]
	bfi	r2, r1, #5, #1
	ldrb	r1, [r4, #44]
	bfi	r2, r9, #1, #1
	ldrb	r9, [r4, #41]
	bfi	r2, r1, #3, #1
	ldrb	r1, [r4, #43]
	bfi	r2, r9, #0, #1
	ldrb	r9, [r4, #47]
	bfi	r2, r1, #2, #1
	ldrb	r1, [r4, #45]
	bfi	r2, r9, #6, #1
	ldr	r9, [fp, #-92]
	bfi	r2, r1, #4, #1
	strb	r2, [fp, #-48]
	ldr	r2, [fp, #-48]
	ldr	r1, [fp, #-84]
	str	r5, [fp, #-48]
	str	r2, [r3, #36]
	ldrb	r2, [r4, #50]
	bfi	r1, r2, #0, #7
	ldrb	r2, [r4, #48]
	strb	r1, [fp, #-46]
	ldrb	r1, [r4, #49]
	bfi	r8, r2, #0, #3
	strb	r8, [fp, #-48]
	bfi	r9, r1, #0, #3
	strb	r9, [fp, #-47]
	ldr	r2, [fp, #-48]
	str	r5, [fp, #-48]
	str	r2, [r3, #40]
	ldrb	r1, [r4, #53]
	ldrb	r2, [r4, #51]
	ldrb	r8, [r4, #54]
	and	r1, r1, #3
	ldrb	r9, [r4, #52]
	and	r2, r2, #7
	bfi	r1, r8, #4, #1
	strb	r1, [fp, #-47]
	bfi	r2, r9, #4, #2
	strb	r2, [fp, #-48]
	ldr	r2, [fp, #-48]
	str	r2, [r3, #44]
	ldr	r2, [r0, #84]
	str	r2, [r3, #48]
	ldr	r2, [r0, #88]
	str	r2, [r3, #52]
	ldr	r2, [r0, #92]
	str	r2, [r3, #56]
	ldrb	r1, [r4, #55]
	ldrb	r2, [r4, #57]
	ldrh	r8, [r4, #72]
	bfi	lr, r1, #4, #1
	ldrb	r9, [r4, #58]
	and	r2, r2, #1
	ldrb	r1, [r4, #56]
	strh	r8, [fp, #-48]
	bfi	r2, r9, #1, #3
	bfi	lr, r1, #5, #3
	strb	r2, [fp, #-45]
	strb	lr, [fp, #-46]
	ldr	r2, [fp, #-48]
	str	r2, [r3, #60]
	ldr	r2, [r0, #96]
	str	r2, [r3, #64]
	ldr	r2, [r0, #100]
	str	r2, [r3, #68]
	ldr	r2, [r0, #104]
	str	r2, [r3, #72]
	ldr	r2, [r0, #108]
	str	r2, [r3, #76]
	ldr	r2, [r0, #112]
	str	r2, [r3, #80]
	ldr	r2, [r6, #1144]
	str	r2, [r3, #84]
	ldr	r2, [r6, #1148]
	str	r2, [r3, #88]
	ldr	r2, [r6, #1156]
	str	r2, [r3, #92]
	ldr	r2, [r6, #1160]
	str	r2, [r3, #96]
	ldr	r2, [r6, #1176]
	str	r2, [r3, #104]
	ldrh	r1, [r4, #74]
	ldrh	r2, [r4, #76]
	strh	r1, [fp, #-48]
	strh	r2, [fp, #-46]
	ldr	r2, [fp, #-48]
	str	r5, [fp, #-48]
	str	r2, [r3, #108]
	ldrb	r2, [r4, #59]
	ldrb	r1, [r4, #63]
	bfi	ip, r2, #4, #1
	ldrb	r2, [r4, #60]
	bfi	r7, r1, #1, #3
	strb	r7, [fp, #-45]
	ldrb	lr, [r4, #61]
	bfi	ip, r2, #5, #1
	ldrb	r1, [r4, #62]
	uxtb	r2, r7
	bfi	ip, lr, #6, #1
	strb	ip, [fp, #-46]
	bfi	r2, r1, #0, #1
	strb	r2, [fp, #-45]
	ldr	r2, [fp, #-48]
	str	r2, [r3, #112]
	ldr	r2, [r0, #116]
	str	r2, [r3, #116]
	ldr	r2, [r0, #120]
	str	r2, [r3, #120]
	ldr	r2, [r0, #124]
	str	r2, [r3, #124]
	ldr	r2, [r0, #128]
	str	r2, [r3, #128]
	ldr	r2, [r0, #132]
	str	r2, [r3, #132]
	ldr	r2, [r0, #136]
	str	r2, [r3, #136]
	ldr	r2, [r0, #140]
	str	r2, [r3, #140]
	ldr	r2, [r0, #144]
	str	r2, [r3, #144]
	ldr	r2, [r6, #60]
	str	r2, [r3, #252]
	ldr	r0, [r6, #1176]
	str	r2, [fp, #-48]
	bl	MEM_Phy2Vir
	cmp	r0, r5
	beq	.L75
	ldr	r3, .L76
	mov	r2, #3072
	ldr	r1, [r4, #64]
	ldr	r3, [r3, #52]
	blx	r3
	mov	r0, r5
.L72:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L74:
	ldr	r2, .L76+4
	ldr	r1, .L76+8
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L72
.L75:
	ldr	r2, .L76+4
	ldr	r1, .L76+12
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L72
.L77:
	.align	2
.L76:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0+52
	.word	.LC0
	.word	.LC9
	.fnend
	.size	VC1HAL_V400R003_CfgDnMsg, .-VC1HAL_V400R003_CfgDnMsg
	.align	2
	.global	VC1HAL_V400R003_StartDec
	.type	VC1HAL_V400R003_StartDec, %function
VC1HAL_V400R003_StartDec:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	push	{lr}
	bl	__gnu_mcount_nc
	subs	r6, r1, #0
	mov	r4, r0
	mov	r8, r2
	beq	.L89
	cmp	r6, #1
	moveq	r9, #0
	movteq	r9, 63941
	bne	.L92
.L80:
	cmp	r4, #0
	beq	.L93
	ldrh	r3, [r4, #78]
	cmp	r3, #512
	ldrhi	r3, .L97
	bhi	.L91
	ldrh	r3, [r4, #80]
	cmp	r3, #512
	bhi	.L94
	movw	r7, #1224
	ldr	r5, .L97+4
	mul	r7, r7, r6
	add	r3, r5, r7
	ldr	r0, [r3, #56]
	bl	MEM_Phy2Vir
	cmp	r0, #0
	beq	.L95
	ldr	r3, [r5, r7]
	cmp	r3, #0
	beq	.L96
.L87:
	movw	ip, #1224
	mov	r0, r4
	mla	r5, ip, r6, r5
	mov	r1, r5
	bl	VC1HAL_V400R003_CfgSliceMsg
	mov	r3, r8
	mov	r2, r6
	mov	r1, r5
	mov	r0, r4
	bl	VC1HAL_V400R003_CfgReg
	mov	r1, r5
	mov	r0, r4
	bl	VC1HAL_V400R003_CfgDnMsg
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L92:
	ldr	r1, .L97+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L89:
	mov	r9, #0
	movt	r9, 63683
	b	.L80
.L96:
	mov	r0, r9
	bl	MEM_Phy2Vir
	subs	r3, r0, #0
	beq	.L88
	str	r3, [r5, r7]
	b	.L87
.L94:
	ldr	r3, .L97+12
.L91:
	ldr	r2, .L97+16
	mov	r0, #0
	ldr	r1, .L97+20
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L93:
	mov	r0, r4
	ldr	r3, .L97+24
	ldr	r2, .L97+16
	ldr	r1, .L97+20
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L95:
	ldr	r3, .L97+28
	ldr	r2, .L97+16
	ldr	r1, .L97+20
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L88:
	ldr	r1, .L97+32
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L98:
	.align	2
.L97:
	.word	.LC13
	.word	g_HwMem
	.word	.LC10
	.word	.LC14
	.word	.LANCHOR0+80
	.word	.LC12
	.word	.LC11
	.word	.LC15
	.word	.LC16
	.fnend
	.size	VC1HAL_V400R003_StartDec, .-VC1HAL_V400R003_StartDec
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	__func__.15476, %object
	.size	__func__.15476, 28
__func__.15476:
	.ascii	"VC1HAL_V400R003_CfgSliceMsg\000"
	.type	__func__.15505, %object
	.size	__func__.15505, 23
__func__.15505:
	.ascii	"VC1HAL_V400R003_CfgReg\000"
	.space	1
	.type	__func__.15513, %object
	.size	__func__.15513, 25
__func__.15513:
	.ascii	"VC1HAL_V400R003_CfgDnMsg\000"
	.space	3
	.type	__func__.15452, %object
	.size	__func__.15452, 25
__func__.15452:
	.ascii	"VC1HAL_V400R003_StartDec\000"
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"%s: pMsgBase = NULL\012\000"
	.space	3
.LC1:
	.ascii	"pVc1DecParam->SlcNum = %d\012\000"
	.space	1
.LC2:
	.ascii	"D0 = 0x%08x\012\000"
	.space	3
.LC3:
	.ascii	"D1 = 0x%08x\012\000"
	.space	3
.LC4:
	.ascii	"D2 = 0x%08x\012\000"
	.space	3
.LC5:
	.ascii	"D3 = 0x%08x\012\000"
	.space	3
.LC6:
	.ascii	"D4 = 0x%08x\012\000"
	.space	3
.LC7:
	.ascii	"D63 = 0x%08x\012\000"
	.space	2
.LC8:
	.ascii	"%s: VdhId(%d) > %d\012\000"
.LC9:
	.ascii	"%s: u8Tmp = NULL\012\000"
	.space	2
.LC10:
	.ascii	"VdhId is wrong! VC1HAL_V200R003_StartDec\012\000"
	.space	2
.LC11:
	.ascii	"point of picture para null\012\000"
.LC12:
	.ascii	"%s: %s\012\000"
.LC13:
	.ascii	"picture width out of range\000"
	.space	1
.LC14:
	.ascii	"picture height out of range\000"
.LC15:
	.ascii	"can not map down msg virtual address!\000"
	.space	2
.LC16:
	.ascii	"vdm register virtual address not mapped, reset fail"
	.ascii	"ed!\012\000"
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
