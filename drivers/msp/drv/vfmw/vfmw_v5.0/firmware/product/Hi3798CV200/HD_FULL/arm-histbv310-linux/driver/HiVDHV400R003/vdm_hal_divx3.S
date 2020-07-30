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
	.file	"vdm_hal_divx3.c"

	.text
	.align	2
	.global	DIVX3HAL_V400R003_InitHal
	.type	DIVX3HAL_V400R003_InitHal, %function
DIVX3HAL_V400R003_InitHal:
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
	.size	DIVX3HAL_V400R003_InitHal, .-DIVX3HAL_V400R003_InitHal
	.align	2
	.global	DIVX3HAL_V400R003_WriteReg
	.type	DIVX3HAL_V400R003_WriteReg, %function
DIVX3HAL_V400R003_WriteReg:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #16
	sub	sp, sp, #16
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r8, r0
	mov	r6, r1
	mov	r0, #2
	ldr	r1, .L8
	mov	r4, r2
	mov	r5, r3
	bl	dprint_vfmw
	cmp	r4, #0
	ble	.L3
	mov	r0, #0
	mov	r3, r4
	str	r0, [sp]
	ldr	r2, .L8+4
	ldr	r1, .L8+8
	bl	dprint_vfmw
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L3:
	ldr	r0, [r6, #8]
	mov	r7, #0
	ldr	ip, [r6, #12]
	mov	r1, r7
	mov	lr, #0
	bfi	lr, r7, #1, #1
	mov	r3, r5
	mov	r2, r4
	mul	ip, r0, ip
	mov	r0, #8
	sub	ip, ip, #1
	bfi	r1, ip, #0, #20
	str	r1, [fp, #-40]
	strb	lr, [fp, #-37]
	mov	r1, r1, lsr #16
	bfi	r1, r7, #7, #1
	strb	r1, [fp, #-38]
	ldr	r9, [fp, #-40]
	mov	r1, r9
	bl	MFDE_ConfigReg
	mov	r2, r9
	ldr	r1, .L8+12
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r1, [r6, #168]
	mov	r3, #0
	mov	r2, #0
	bfi	r3, r7, #0, #12
	bfi	r2, r7, #5, #1
	strh	r3, [fp, #-38]
	mov	r3, #0
	bfi	r3, r1, #4, #1
	strb	r2, [fp, #-37]
	and	r3, r3, #16
	ldr	r1, [r6, #164]
	uxtb	r2, r2
	orr	r3, r3, #64
	bfi	r2, r1, #6, #1
	mov	r0, #5
	mvn	r3, r3, asl #25
	strb	r0, [fp, #-40]
	mvn	r3, r3, lsr #25
	strb	r3, [fp, #-39]
	mov	r3, r2
	bfi	r3, r7, #7, #1
	strb	r3, [fp, #-37]
	mov	r2, r4
	ldr	r9, [fp, #-40]
	mov	r3, r5
	mov	r0, #12
	mov	r1, r9
	bl	MFDE_ConfigReg
	mov	r2, r9
	ldr	r1, .L8+16
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r9, [r8, #56]
	mov	r3, r5
	mov	r2, r4
	bic	r9, r9, #15
	mov	r0, #16
	mov	r1, r9
	bl	MFDE_ConfigReg
	mov	r2, r9
	ldr	r1, .L8+20
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r9, [r8, #40]
	mov	r3, r5
	mov	r2, r4
	bic	r9, r9, #15
	mov	r0, #20
	mov	r1, r9
	bl	MFDE_ConfigReg
	mov	r2, r9
	ldr	r1, .L8+24
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r9, [r6, #96]
	mov	r3, r5
	mov	r2, r4
	mov	r0, #24
	mov	r1, r9
	str	r9, [fp, #-40]
	bl	MFDE_ConfigReg
	mov	r2, r9
	ldr	r1, .L8+28
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r1, [r6, #8]
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
	movw	r2, #3075
	movt	r2, 48
	ldr	r1, .L8+32
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r9, [r6, #128]
	mov	r3, r5
	mov	r2, r4
	bic	r9, r9, #15
	mov	r0, #96
	mov	r1, r9
	bl	MFDE_ConfigReg
	mov	r2, r9
	ldr	r1, .L8+36
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r9, [r6, #136]
	mov	r3, r5
	mov	r2, r4
	mov	r0, #100
	mov	r1, r9
	bl	MFDE_ConfigReg
	mov	r2, r9
	ldr	r1, .L8+40
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r9, [r6, #140]
	mov	r3, r5
	mov	r2, r4
	mov	r0, #104
	mov	r1, r9
	bl	MFDE_ConfigReg
	mov	r2, r9
	ldr	r1, .L8+44
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r6, [r6, #148]
	mov	r3, r5
	mov	r2, r4
	mov	r0, #108
	mov	r1, r6
	bl	MFDE_ConfigReg
	mov	r2, r6
	ldr	r1, .L8+48
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r6, [r8, #1204]
	mov	r3, r5
	mov	r2, r4
	mov	r0, #144
	mov	r1, r6
	bl	MFDE_ConfigReg
	mov	r2, r6
	ldr	r1, .L8+52
	mov	r0, #3
	bl	dprint_vfmw
	mov	r3, r5
	mov	r1, r7
	mov	r2, r4
	mov	r0, #148
	str	r7, [fp, #-40]
	bl	MFDE_ConfigReg
	mov	r2, r7
	ldr	r1, .L8+56
	mov	r0, #3
	bl	dprint_vfmw
	ldrb	r1, [fp, #-40]
	mov	r3, r5
	mov	r2, r4
	bfi	r1, r7, #0, #1
	strb	r1, [fp, #-40]
	ldr	r6, [fp, #-40]
	mov	r0, #152
	mov	r1, r6
	bl	MFDE_ConfigReg
	mov	r2, r6
	ldr	r1, .L8+60
	mov	r0, #3
	bl	dprint_vfmw
	mov	r3, r5
	mov	r2, r4
	mvn	r1, #0
	mov	r0, #32
	bl	MFDE_ConfigReg
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L9:
	.align	2
.L8:
	.word	.LC0
	.word	.LANCHOR0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	.LC11
	.word	.LC12
	.word	.LC13
	.word	.LC14
	.fnend
	.size	DIVX3HAL_V400R003_WriteReg, .-DIVX3HAL_V400R003_WriteReg
	.align	2
	.global	DIVX3HAL_V400R003_WritePicMsg
	.type	DIVX3HAL_V400R003_WritePicMsg, %function
DIVX3HAL_V400R003_WritePicMsg:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #8
	sub	sp, sp, #8
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r6, r0
	mov	r4, r1
	mov	r0, #2
	ldr	r1, .L14
	bl	dprint_vfmw
	ldr	r0, [r6, #56]
	bic	r0, r0, #15
	bl	MEM_Phy2Vir
	subs	r5, r0, #0
	beq	.L13
	ldr	r2, [r4, #4]
	mov	r7, #0
	mov	r3, #0
	str	r7, [fp, #-32]
	bfi	r3, r2, #0, #1
	strb	r3, [fp, #-32]
	ldr	r2, [fp, #-32]
	mov	r0, #4
	ldr	r1, .L14+4
	str	r2, [r5]
	bl	dprint_vfmw
	ldr	r2, [r4, #8]
	ldr	r3, [r4, #12]
	mov	r0, #0
	sub	r2, r2, #1
	mov	r1, r0
	sub	r3, r3, #1
	bfi	r0, r2, #0, #9
	bfi	r1, r3, #0, #9
	strh	r0, [fp, #-32]
	strh	r1, [fp, #-30]
	mov	r0, #4
	ldr	r2, [fp, #-32]
	ldr	r1, .L14+8
	str	r2, [r5, #4]
	bl	dprint_vfmw
	ldr	r3, [r4, #16]
	ldr	r1, [r4, #20]
	mov	r0, #4
	ldr	r2, [r4, #24]
	and	r3, r3, #31
	bfi	r3, r1, #5, #1
	str	r7, [fp, #-32]
	bfi	r3, r2, #6, #1
	strb	r3, [fp, #-32]
	ldr	r2, [fp, #-32]
	ldr	r1, .L14+12
	str	r2, [r5, #8]
	bl	dprint_vfmw
	ldr	r3, [r4, #28]
	ldr	r1, [r4, #32]
	mov	r2, #0
	ldr	ip, [r4, #36]
	and	r3, r3, #3
	ldr	lr, [r4, #40]
	bfi	r3, r1, #2, #2
	bfi	r3, ip, #4, #1
	ldr	r1, [r4, #44]
	ldr	ip, [r4, #48]
	bfi	r3, lr, #5, #2
	str	r7, [fp, #-32]
	bfi	r3, r1, #7, #1
	bfi	r2, ip, #0, #1
	strb	r3, [fp, #-32]
	strb	r2, [fp, #-31]
	mov	r0, #4
	ldr	r2, [fp, #-32]
	ldr	r1, .L14+16
	str	r2, [r5, #12]
	bl	dprint_vfmw
	ldr	r2, [r4, #100]
	ldr	r1, .L14+20
	mov	r0, #4
	str	r2, [r5, #64]
	bl	dprint_vfmw
	ldr	r2, [r4, #108]
	str	r7, [fp, #-32]
	mov	r3, #0
	bfi	r3, r2, #0, #7
	strb	r3, [fp, #-32]
	ldr	r2, [fp, #-32]
	mov	r0, #4
	ldr	r1, .L14+24
	str	r2, [r5, #68]
	bl	dprint_vfmw
	ldr	r2, [r4, #116]
	ldr	r1, .L14+28
	mov	r0, #4
	str	r2, [r5, #72]
	bl	dprint_vfmw
	ldr	r2, [r4, #104]
	ldr	r1, .L14+32
	mov	r0, #4
	str	r2, [r5, #76]
	bl	dprint_vfmw
	ldr	r2, [r4, #112]
	str	r7, [fp, #-32]
	mov	r3, #0
	bfi	r3, r2, #0, #7
	strb	r3, [fp, #-32]
	ldr	r2, [fp, #-32]
	mov	r0, #4
	ldr	r1, .L14+36
	str	r2, [r5, #80]
	bl	dprint_vfmw
	ldr	r2, [r4, #120]
	ldr	r1, .L14+40
	mov	r0, #4
	str	r2, [r5, #84]
	bl	dprint_vfmw
	ldr	r2, [r4, #132]
	ldr	r1, .L14+44
	mov	r0, #4
	bic	r2, r2, #15
	str	r2, [r5, #128]
	bl	dprint_vfmw
	ldr	r2, [r4, #124]
	ldr	r1, .L14+48
	mov	r0, #4
	bic	r2, r2, #15
	str	r2, [r5, #132]
	bl	dprint_vfmw
	ldr	r2, [r6, #1144]
	ldr	r1, .L14+52
	mov	r0, #4
	bic	r2, r2, #15
	str	r2, [r5, #136]
	bl	dprint_vfmw
	ldr	r2, [r6, #1148]
	ldr	r1, .L14+56
	mov	r0, #4
	bic	r2, r2, #15
	str	r2, [r5, #140]
	bl	dprint_vfmw
	ldr	r2, [r6, #1156]
	ldr	r1, .L14+60
	mov	r0, #4
	bic	r2, r2, #15
	str	r2, [r5, #144]
	bl	dprint_vfmw
	ldr	r2, [r4, #156]
	ldr	r1, .L14+64
	mov	r0, #4
	bic	r2, r2, #15
	str	r2, [r5, #148]
	bl	dprint_vfmw
	ldr	r2, [r6, #60]
	ldr	r1, .L14+68
	mov	r0, #4
	bic	r2, r2, #15
	str	r2, [r5, #252]
	bl	dprint_vfmw
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L13:
	ldr	r3, .L14+72
	ldr	r2, .L14+76
	ldr	r1, .L14+80
	bl	dprint_vfmw
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L15:
	.align	2
.L14:
	.word	.LC15
	.word	.LC18
	.word	.LC19
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
	.word	.LC16
	.word	.LANCHOR0+28
	.word	.LC17
	.fnend
	.size	DIVX3HAL_V400R003_WritePicMsg, .-DIVX3HAL_V400R003_WritePicMsg
	.align	2
	.global	DIVX3HAL_V400R003_WriteSliceMsg
	.type	DIVX3HAL_V400R003_WriteSliceMsg, %function
DIVX3HAL_V400R003_WriteSliceMsg:
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
	ldr	r8, [r0, #60]
	mov	r9, r1
	bic	r8, r8, #15
	mov	r0, r8
	bl	MEM_Phy2Vir
	subs	r6, r0, #0
	beq	.L33
	ldr	r7, [r9, #56]
	cmp	r7, #0
	bne	.L34
.L19:
	ldr	r3, [r9, #52]
	cmp	r3, #0
	beq	.L16
	add	r3, r8, r7, lsl #6
	mov	r7, r7, asl #8
	mov	r5, #0
	str	r3, [fp, #-56]
.L29:
	cmp	r5, #0
	ldreq	r3, [r9, #56]
	beq	.L22
	add	r2, r9, r5, lsl #2
	ldr	r3, [r2, #56]
	ldr	r2, [r2, #52]
	cmp	r3, r2
	bls	.L23
.L22:
	add	r10, r7, r5, lsl #8
	ldr	r1, .L35
	mov	r2, #0
	mov	r0, #4
	bfi	r2, r3, #0, #20
	str	r2, [fp, #-48]
	str	r2, [r6, r10]
	add	r4, r5, #1
	bl	dprint_vfmw
	ldr	r1, [r9, #52]
	cmp	r4, r1
	bcs	.L24
	add	r3, r9, r5, lsl #2
	ldr	r0, [r3, #56]
	ldr	r3, [r3, #60]
	cmp	r0, r3
	bcc	.L24
	add	r3, r5, #15
	add	r3, r9, r3, lsl #2
	b	.L25
.L26:
	ldr	r2, [r3, #4]!
	cmp	r2, r0
	bhi	.L24
.L25:
	add	r4, r4, #1
	cmp	r4, r1
	bcc	.L26
.L24:
	cmp	r1, r4
	add	ip, r10, #4
	addne	r3, r4, #14
	add	r10, r10, #252
	ldreq	r1, [r9, #12]
	moveq	r8, #0
	ldreq	r2, [r9, #8]
	moveq	r5, r8
	ldrne	r1, [r9, r3, asl #2]
	mov	r0, #4
	ldrne	r2, [fp, #-56]
	muleq	r1, r2, r1
	addne	r5, r2, r4, lsl #8
	mov	r2, #0
	movne	r8, r5
	sub	r1, r1, #1
	bfi	r2, r1, #0, #20
	ldr	r1, .L35+4
	str	r2, [fp, #-48]
	str	r2, [r6, ip]
	bl	dprint_vfmw
	mov	r2, r5
	ldr	r1, .L35+8
	mov	r0, #4
	str	r8, [r6, r10]
	str	r5, [fp, #-48]
	bl	dprint_vfmw
	sub	r5, r4, #1
.L23:
	ldr	r3, [r9, #52]
	add	r5, r5, #1
	cmp	r3, r5
	bhi	.L29
.L16:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L34:
	mov	r4, #0
	ldr	r1, .L35
	mov	r3, r4
	bfi	r3, r4, #0, #20
	mov	r0, #4
	str	r3, [fp, #-48]
	mov	r2, r3
	str	r3, [r6]
	bl	dprint_vfmw
	ldr	r3, [r9, #56]
	ldr	r1, .L35+4
	mov	r2, r4
	sub	r3, r3, #1
	mov	r0, #4
	bfi	r2, r3, #0, #20
	str	r2, [fp, #-48]
	str	r2, [r6, #4]
	mov	r7, #1
	bl	dprint_vfmw
	add	r3, r8, #256
	ldr	r1, .L35+8
	mov	r0, #4
	str	r3, [r6, #252]
	mov	r2, r3
	str	r3, [fp, #-48]
	bl	dprint_vfmw
	b	.L19
.L33:
	ldr	r3, .L35+12
	ldr	r2, .L35+16
	ldr	r1, .L35+20
	bl	dprint_vfmw
	b	.L16
.L36:
	.align	2
.L35:
	.word	.LC18
	.word	.LC19
	.word	.LC34
	.word	.LC16
	.word	.LANCHOR0+60
	.word	.LC17
	.fnend
	.size	DIVX3HAL_V400R003_WriteSliceMsg, .-DIVX3HAL_V400R003_WriteSliceMsg
	.align	2
	.global	DIVX3HAL_V400R003_StartDec
	.type	DIVX3HAL_V400R003_StartDec, %function
DIVX3HAL_V400R003_StartDec:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #16
	sub	sp, sp, #16
	push	{lr}
	bl	__gnu_mcount_nc
	cmp	r1, #0
	mov	r4, r0
	beq	.L39
	cmp	r1, #1
	bne	.L44
	mov	r0, #0
	mov	r3, r1
	str	r0, [sp]
	ldr	r2, .L46
	ldr	r1, .L46+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L41
.L39:
	ldr	r5, .L46+8
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L45
.L42:
	ldr	lr, .L46+12
	mov	r3, r2
	mov	r1, r4
	mov	r2, #0
	ldr	r0, .L46+8
	ldr	ip, [lr]
	add	ip, ip, #1
	str	ip, [lr]
	bl	DIVX3HAL_V400R003_WriteReg
	mov	r1, r4
	ldr	r0, .L46+8
	bl	DIVX3HAL_V400R003_WritePicMsg
	ldr	r0, .L46+8
	mov	r1, r4
	bl	DIVX3HAL_V400R003_WriteSliceMsg
	mov	r0, #0
.L41:
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L44:
	ldr	r1, .L46+16
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L45:
	mov	r0, #0
	str	r2, [fp, #-24]
	movt	r0, 63683
	bl	MEM_Phy2Vir
	subs	r3, r0, #0
	strne	r3, [r5]
	ldrne	r2, [fp, #-24]
	bne	.L42
.L43:
	ldr	r1, .L46+20
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L41
.L47:
	.align	2
.L46:
	.word	.LANCHOR0+92
	.word	.LC1
	.word	g_HwMem
	.word	.LANCHOR1
	.word	.LC35
	.word	.LC36
	.fnend
	.size	DIVX3HAL_V400R003_StartDec, .-DIVX3HAL_V400R003_StartDec
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	__func__.15317, %object
	.size	__func__.15317, 27
__func__.15317:
	.ascii	"DIVX3HAL_V400R003_WriteReg\000"
	.space	1
	.type	__func__.15325, %object
	.size	__func__.15325, 30
__func__.15325:
	.ascii	"DIVX3HAL_V400R003_WritePicMsg\000"
	.space	2
	.type	__func__.15339, %object
	.size	__func__.15339, 32
__func__.15339:
	.ascii	"DIVX3HAL_V400R003_WriteSliceMsg\000"
	.type	__func__.15309, %object
	.size	__func__.15309, 27
__func__.15309:
	.ascii	"DIVX3HAL_V400R003_StartDec\000"
	.data
	.align	2
.LANCHOR1 = . + 0
	.type	FrameNum, %object
	.size	FrameNum, 4
FrameNum:
	.word	-1
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"configuring VDM registers...\012\000"
	.space	2
.LC1:
	.ascii	"%s: VdhId(%d) > %d\012\000"
.LC2:
	.ascii	"BASIC_V200R003_CFG0 = 0x%x\012\000"
.LC3:
	.ascii	"BASIC_V400R003_CFG1=0x%x\012\000"
	.space	2
.LC4:
	.ascii	"AVM_V400R003_ADDR=0x%x\012\000"
.LC5:
	.ascii	"VAM_V400R003_ADDR=0x%x\012\000"
.LC6:
	.ascii	"STREAM_V200R003_BASE_ADDR=0x%x\012\000"
.LC7:
	.ascii	"TIME_OUT = 0x%x\012\000"
	.space	3
.LC8:
	.ascii	"YSTADDR_V400R003_1D = 0x%x\012\000"
.LC9:
	.ascii	"YSTRIDE_V400R003_1D = 0x%x\012\000"
.LC10:
	.ascii	"UVOFFSET_V400R003_1D = 0x%x\012\000"
	.space	3
.LC11:
	.ascii	"HEAD_INF_OFFSET = 0x%x\012\000"
.LC12:
	.ascii	"DNR_MBINFO_STADDR=0x%x\012\000"
.LC13:
	.ascii	"REF_V400R003_PIC_TYPE=0x%x\012\000"
.LC14:
	.ascii	"FF_V400R003_APT_EN=0x%x\012\000"
	.space	3
.LC15:
	.ascii	"configuring Pic Msg...\012\000"
.LC16:
	.ascii	"can not map dn msg virtual address!\012\000"
	.space	3
.LC17:
	.ascii	"%s: %s\012\000"
.LC18:
	.ascii	"D0 = 0x%x\012\000"
	.space	1
.LC19:
	.ascii	"D1 = 0x%x\012\000"
	.space	1
.LC20:
	.ascii	"D2 = 0x%x\012\000"
	.space	1
.LC21:
	.ascii	"D3 = 0x%x\012\000"
	.space	1
.LC22:
	.ascii	"D16 = 0x%x\012\000"
.LC23:
	.ascii	"D17 = 0x%x\012\000"
.LC24:
	.ascii	"D18 = 0x%x\012\000"
.LC25:
	.ascii	"D19 = 0x%x\012\000"
.LC26:
	.ascii	"D20 = 0x%x\012\000"
.LC27:
	.ascii	"D21 = 0x%x\012\000"
.LC28:
	.ascii	"D32 = 0x%x\012\000"
.LC29:
	.ascii	"D33 = 0x%x\012\000"
.LC30:
	.ascii	"D34 = 0x%x\012\000"
.LC31:
	.ascii	"D35 = 0x%x\012\000"
.LC32:
	.ascii	"D36 = 0x%x\012\000"
.LC33:
	.ascii	"D37 = 0x%x\012\000"
.LC34:
	.ascii	"D63 = 0x%x\012\000"
.LC35:
	.ascii	"VdhId is wrong! DIVX3HAL_V400R003_StartDec\012\000"
.LC36:
	.ascii	"vdm register virtual address not mapped, reset fail"
	.ascii	"ed!\012\000"
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
