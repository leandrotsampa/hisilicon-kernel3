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
	.file	"vdm_hal_mpeg2.c"

	.text
	.align	2
	.global	MP2HAL_V400R003_InitHal
	.type	MP2HAL_V400R003_InitHal, %function
MP2HAL_V400R003_InitHal:
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
	.size	MP2HAL_V400R003_InitHal, .-MP2HAL_V400R003_InitHal
	.align	2
	.global	MP2HAL_V400R003_WriteSliceMsg
	.type	MP2HAL_V400R003_WriteSliceMsg, %function
MP2HAL_V400R003_WriteSliceMsg:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #36
	sub	sp, sp, #36
	push	{lr}
	bl	__gnu_mcount_nc
	mov	lr, r0
	add	ip, r0, #45056
	str	r0, [fp, #-72]
	mov	r8, r1
	ldr	r0, [r0, #300]
	mov	r4, r2
	str	r3, [fp, #-60]
	add	r9, lr, #268
	cmp	r0, #0
	ldr	r10, [ip, #268]
	mov	r5, #0
	moveq	r1, r0
	bne	.L22
.L3:
	cmp	r10, #0
	ble	.L19
	add	r3, r4, r1, lsl #5
	mov	r4, #0
	str	r3, [fp, #-68]
	mov	r3, r1, asl #7
	str	r3, [fp, #-64]
	b	.L15
.L7:
	add	r4, r4, #1
	cmp	r10, r4
	ble	.L19
.L15:
	mov	r2, #44
	cmp	r4, #0
	mul	r2, r2, r4
	movgt	r1, #1
	movle	r1, #0
	add	r5, r9, r2
	ldr	r0, [r5, #32]
	ldr	r3, [r5, #-12]
	cmp	r0, r3
	movhi	r7, #0
	andls	r7, r1, #1
	cmp	r7, #0
	bne	.L7
	ldr	ip, [r9, r2]
	mov	r0, r7
	ldr	r2, [r5, #16]
	mov	r1, #0
	and	lr, ip, #15
	ldr	r6, [r5, #8]
	ldr	r3, [fp, #-64]
	add	r2, r2, lr, lsl #3
	bfi	r0, r6, #0, #24
	bfi	r1, r2, #0, #7
	str	r0, [fp, #-48]
	strb	r1, [fp, #-45]
	add	r6, r3, r4, lsl #5
	ldr	r2, [fp, #-48]
	mov	r0, #4
	ldr	r1, .L24
	str	ip, [fp, #-56]
	str	r2, [r8, r6]
	bl	dprint_vfmw
	ldr	ip, [fp, #-56]
	ldr	r3, [fp, #-60]
	mov	lr, r7
	bic	ip, ip, #15
	add	r2, r6, #4
	rsb	ip, r3, ip
	ldr	r1, .L24+4
	bfi	lr, ip, #0, #24
	mov	r0, #4
	str	lr, [r8, r2]
	mov	r2, lr
	str	lr, [fp, #-48]
	bl	dprint_vfmw
	ldr	ip, [r5, #4]
	ldr	r2, [r5, #20]
	mov	r0, r7
	and	lr, ip, #15
	ldr	r3, [r5, #12]
	mov	r1, #0
	str	ip, [fp, #-56]
	add	r2, r2, lr, lsl #3
	bfi	r0, r3, #0, #24
	bfi	r1, r2, #0, #7
	str	r0, [fp, #-48]
	strb	r1, [fp, #-45]
	add	lr, r6, #8
	ldr	r2, [fp, #-48]
	mov	r0, #4
	ldr	r1, .L24+8
	str	r2, [r8, lr]
	bl	dprint_vfmw
	ldr	r2, [r5, #4]
	ldr	ip, [fp, #-56]
	mov	r0, #4
	cmp	r2, #0
	ldr	r1, .L24+12
	bicne	ip, ip, #15
	streq	r2, [fp, #-48]
	ldrne	r2, [fp, #-60]
	movne	r3, r7
	add	r7, r4, #1
	mov	r4, #0
	rsbne	ip, r2, ip
	bfine	r3, ip, #0, #24
	strne	r3, [fp, #-48]
	ldr	r2, [fp, #-48]
	add	ip, r6, #12
	str	r2, [r8, ip]
	bl	dprint_vfmw
	ldr	r2, [r5, #40]
	ldr	r1, [r5, #36]
	add	ip, r6, #16
	and	r2, r2, #63
	str	r4, [fp, #-48]
	bfi	r2, r1, #6, #1
	strb	r2, [fp, #-48]
	ldr	r2, [fp, #-48]
	mov	r0, #4
	ldr	r1, .L24+16
	str	r2, [r8, ip]
	bl	dprint_vfmw
	ldr	r1, [r5, #32]
	add	r2, r6, #20
	mov	r0, #4
	bfi	r4, r1, #0, #20
	ldr	r1, .L24+20
	str	r4, [r8, r2]
	mov	r2, r4
	str	r4, [fp, #-48]
	bl	dprint_vfmw
	cmp	r10, r7
	ble	.L10
	ldr	r1, [r5, #32]
	ldr	r2, [r5, #76]
	cmp	r1, r2
	bcs	.L11
	b	.L10
.L12:
	ldr	r3, [r5, #76]
	cmp	r3, r1
	bhi	.L10
.L11:
	add	r7, r7, #1
	add	r5, r5, #44
	cmp	r10, r7
	bgt	.L12
.L10:
	cmp	r7, r10
	beq	.L23
	mov	r2, #44
	ldr	r3, [fp, #-68]
	mla	r2, r2, r7, r9
	add	r4, r3, r7, lsl #5
	mov	r5, r4
	ldr	r2, [r2, #32]
	sub	r2, r2, #1
.L14:
	add	r0, r6, #24
	mov	ip, #0
	bfi	ip, r2, #0, #20
	ldr	r1, .L24+24
	str	ip, [r8, r0]
	add	r6, r6, #28
	mov	r2, ip
	mov	r0, #4
	str	ip, [fp, #-48]
	bl	dprint_vfmw
	mov	r2, r4
	str	r4, [fp, #-48]
	sub	r4, r7, #1
	ldr	r1, .L24+28
	str	r5, [r8, r6]
	mov	r0, #4
	add	r4, r4, #1
	bl	dprint_vfmw
	cmp	r10, r4
	bgt	.L15
.L19:
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L23:
	ldr	r3, [fp, #-72]
	mov	r5, #0
	mov	r4, r5
	ldrh	r1, [r3, #152]
	ldrh	r2, [r3, #148]
	mul	r2, r2, r1
	sub	r2, r2, #1
	b	.L14
.L22:
	ldr	r6, [lr, #268]
	mov	r7, lr
	ldr	r2, [lr, #284]
	mov	r1, #1
	and	lr, r6, #15
	str	r1, [fp, #-48]
	mov	ip, #0
	ldr	r1, .L24
	add	r2, r2, lr, lsl #3
	mov	r0, #4
	bfi	ip, r2, #0, #7
	strb	ip, [fp, #-45]
	ldr	r2, [fp, #-48]
	str	r2, [r8]
	bl	dprint_vfmw
	ldr	r3, [fp, #-60]
	bic	r1, r6, #15
	mov	ip, r5
	rsb	r1, r3, r1
	mov	r0, #4
	bfi	ip, r1, #0, #24
	ldr	r1, .L24+4
	str	ip, [r8, #4]
	mov	r2, ip
	str	ip, [fp, #-48]
	bl	dprint_vfmw
	ldr	r6, [r7, #272]
	ldr	r2, [r7, #288]
	mov	ip, #0
	and	lr, r6, #15
	str	r5, [fp, #-48]
	ldr	r1, .L24+8
	mov	r0, #4
	add	r2, r2, lr, lsl #3
	bfi	ip, r2, #0, #7
	strb	ip, [fp, #-45]
	ldr	r2, [fp, #-48]
	str	r2, [r8, #8]
	bl	dprint_vfmw
	ldr	r2, [r7, #272]
	mov	r3, r7
	ldr	r1, .L24+12
	cmp	r2, r5
	mov	r0, #4
	bicne	r2, r6, #15
	streq	r2, [fp, #-48]
	ldrne	r3, [fp, #-60]
	rsbne	r2, r3, r2
	bfine	r5, r2, #0, #24
	strne	r5, [fp, #-48]
	ldr	r2, [fp, #-48]
	mov	r5, #0
	str	r2, [r8, #12]
	bl	dprint_vfmw
	ldr	r6, [fp, #-72]
	str	r5, [fp, #-48]
	mov	r0, #4
	ldr	r2, [r6, #308]
	ldr	r1, [r6, #304]
	and	r2, r2, #63
	bfi	r2, r1, #6, #1
	strb	r2, [fp, #-48]
	ldr	r2, [fp, #-48]
	ldr	r1, .L24+16
	str	r2, [r8, #16]
	bl	dprint_vfmw
	mov	ip, r5
	bfi	ip, r5, #0, #20
	ldr	r1, .L24+20
	str	ip, [r8, #20]
	mov	r0, #4
	mov	r2, ip
	str	ip, [fp, #-48]
	bl	dprint_vfmw
	ldr	ip, [r6, #300]
	ldr	r1, .L24+24
	mov	r2, r5
	sub	ip, ip, #1
	mov	r0, #4
	bfi	r2, ip, #0, #20
	str	r2, [r8, #24]
	str	r2, [fp, #-48]
	bl	dprint_vfmw
	add	r2, r4, #32
	mov	r1, #1
	str	r2, [r8, #28]
	b	.L3
.L25:
	.align	2
.L24:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.fnend
	.size	MP2HAL_V400R003_WriteSliceMsg, .-MP2HAL_V400R003_WriteSliceMsg
	.align	2
	.global	MP2HAL_V400R003_MakeReg
	.type	MP2HAL_V400R003_MakeReg, %function
MP2HAL_V400R003_MakeReg:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	push	{lr}
	bl	__gnu_mcount_nc
	ldrh	r6, [r2, #152]
	ldrh	r3, [r2, #148]
	mov	r4, #3
	ldr	r5, [r0, #8]
	mov	lr, #1
	mov	ip, #0
	mul	r3, r3, r6
	ldr	r6, [r5]
	sub	r3, r3, #1
	bfi	r6, r3, #0, #20
	str	r6, [r5]
	ldr	r5, [r0, #8]
	ldrb	r3, [r5, #3]
	orr	r3, r3, #64
	strb	r3, [r5, #3]
	ldr	r3, [r0, #8]
	ldrb	r5, [r3, #3]
	bfc	r5, #7, #1
	strb	r5, [r3, #3]
	ldr	r3, [r0, #12]
	ldrb	r5, [r3]
	bfi	r5, r4, #0, #4
	strb	r5, [r3]
	ldr	r4, [r0, #12]
	ldrb	r3, [r4, #1]
	orr	r3, r3, #64
	strb	r3, [r4, #1]
	ldr	r3, [r0, #12]
	ldrb	r4, [r3, #1]
	bfc	r4, #7, #1
	strb	r4, [r3, #1]
	ldr	r3, [r0, #12]
	ldrh	r4, [r3, #2]
	bfi	r4, lr, #0, #12
	strh	r4, [r3, #2]
	ldr	lr, [r0, #12]
	ldrb	r3, [lr, #3]
	orr	r3, r3, #32
	strb	r3, [lr, #3]
	ldr	r3, [r0, #12]
	ldrb	lr, [r3, #3]
	bfc	lr, #7, #1
	strb	lr, [r3, #3]
	ldr	r3, [r0, #12]
	ldrb	lr, [r3, #3]
	bfc	lr, #4, #1
	strb	lr, [r3, #3]
	ldr	r3, [r0, #12]
	ldrb	lr, [r3, #3]
	bfc	lr, #6, #1
	strb	lr, [r3, #3]
	ldr	r3, [r0, #60]
	ldrb	lr, [r3]
	bfc	lr, #0, #1
	strb	lr, [r3]
	ldr	r3, [r0, #56]
	str	ip, [r3]
	ldr	r3, [r0, #56]
	ldr	lr, [r2, #208]
	ldrb	ip, [r3]
	bfi	ip, lr, #0, #2
	strb	ip, [r3]
	ldr	r3, [r0, #56]
	ldr	lr, [r2, #204]
	ldrb	ip, [r3]
	bfi	ip, lr, #2, #2
	strb	ip, [r3]
	ldr	ip, [r0, #16]
	ldr	r3, [r1, #56]
	bic	r3, r3, #15
	str	r3, [ip]
	ldr	ip, [r0, #20]
	ldr	r3, [r1, #40]
	bic	r3, r3, #15
	str	r3, [ip]
	ldr	r1, [r0, #28]
	ldr	r3, [r2, #200]
	bic	r3, r3, #255
	str	r3, [r1]
	ldrb	r1, [r2, #3]
	ldrh	lr, [r2, #148]
	sub	r1, r1, #1
	ldr	ip, [r0, #32]
	cmp	r1, #1
	ldrh	r1, [r2, #152]
	movls	r3, #2
	movhi	r3, #1
	mul	r3, r3, lr
	str	r1, [ip]
	ldrh	r1, [r2, #152]
	ldr	ip, [r0, #36]
	mul	r3, r1, r3
	mov	r3, r3, asl #8
	str	r3, [ip]
	ldr	r3, [r2, #176]
	cmp	r3, #0
	ldreq	ip, [r2, #164]
	ldrne	ip, [r2, #168]
	ldreq	r1, [r0, #24]
	ldreq	r3, [r2, #156]
	ldrne	r1, [r0, #24]
	mov	r0, #0
	ldrne	r3, [r2, #160]
	add	r3, r3, ip, lsr #3
	bic	r3, r3, #15
	str	r3, [r1]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	MP2HAL_V400R003_MakeReg, .-MP2HAL_V400R003_MakeReg
	.align	2
	.global	MP2HAL_V400R003_MakeDnMsg
	.type	MP2HAL_V400R003_MakeDnMsg, %function
MP2HAL_V400R003_MakeDnMsg:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #24
	sub	sp, sp, #24
	push	{lr}
	bl	__gnu_mcount_nc
	ldrh	r3, [r2, #152]
	mov	r4, r2
	mov	r6, r0
	mov	r5, r1
	cmp	r3, #512
	ldrhi	r3, .L56
	bhi	.L53
	ldrh	r2, [r2, #148]
	cmp	r2, #512
	bhi	.L54
	ldr	r2, [r0]
	sub	r3, r3, #1
	ldrh	r1, [r2]
	bfi	r1, r3, #0, #9
	strh	r1, [r2]
	ldr	r2, [r0]
	ldrh	r3, [r4, #148]
	ldrh	r1, [r2, #2]
	sub	r3, r3, #1
	bfi	r1, r3, #0, #9
	strh	r1, [r2, #2]
	ldr	r3, [r0]
	ldr	r1, [r4, #180]
	ldrb	r2, [r3, #3]
	bfi	r2, r1, #1, #1
	strb	r2, [r3, #3]
	ldr	r3, [r0, #4]
	ldrb	r1, [r4, #5]
	ldrb	r2, [r3]
	bfi	r2, r1, #0, #1
	strb	r2, [r3]
	ldr	r3, [r0, #4]
	ldrb	r1, [r4, #3]
	ldrb	r2, [r3, #1]
	bfi	r2, r1, #0, #2
	strb	r2, [r3, #1]
	ldr	r3, [r0, #4]
	ldrb	r1, [r4, #4]
	ldrb	r2, [r3, #1]
	bfi	r2, r1, #2, #1
	strb	r2, [r3, #1]
	ldr	r3, [r0, #4]
	ldrb	r1, [r4, #7]
	ldrb	r2, [r3, #2]
	bfi	r2, r1, #0, #1
	strb	r2, [r3, #2]
	ldr	r3, [r0, #4]
	ldrb	r1, [r4]
	ldrb	r2, [r3, #3]
	bfi	r2, r1, #0, #3
	strb	r2, [r3, #3]
	ldr	r3, [r0, #4]
	ldrb	r2, [r3, #3]
	ldrb	r1, [r4, #2]
	bfi	r2, r1, #3, #1
	strb	r2, [r3, #3]
	ldr	r3, [r0, #4]
	ldrb	r1, [r4, #1]
	ldrb	r2, [r3, #3]
	bfi	r2, r1, #4, #1
	strb	r2, [r3, #3]
	ldr	r3, [r0, #8]
	ldrb	r1, [r4, #15]
	ldrb	r2, [r3]
	bfi	r2, r1, #0, #4
	strb	r2, [r3]
	ldr	r3, [r0, #8]
	ldrb	r1, [r4, #14]
	ldrb	r2, [r3, #1]
	bfi	r2, r1, #0, #4
	strb	r2, [r3, #1]
	ldr	r3, [r0, #8]
	ldrb	r1, [r4, #13]
	ldrb	r2, [r3, #2]
	bfi	r2, r1, #0, #4
	strb	r2, [r3, #2]
	ldr	r3, [r0, #8]
	ldrb	r1, [r4, #12]
	ldrb	r2, [r3, #3]
	bfi	r2, r1, #0, #4
	strb	r2, [r3, #3]
	ldr	r3, [r0, #8]
	ldrb	r1, [r4, #6]
	ldrb	r2, [r3, #3]
	bfi	r2, r1, #7, #1
	strb	r2, [r3, #3]
	ldr	r3, [r0, #12]
	ldrb	r1, [r4, #11]
	ldrb	r2, [r3]
	bfi	r2, r1, #0, #2
	strb	r2, [r3]
	ldr	r3, [r0, #12]
	ldrb	r1, [r4, #10]
	ldrb	r2, [r3, #1]
	bfi	r2, r1, #0, #1
	strb	r2, [r3, #1]
	ldr	r3, [r0, #12]
	ldrb	r1, [r4, #9]
	ldrb	r2, [r3, #2]
	bfi	r2, r1, #0, #1
	strb	r2, [r3, #2]
	ldr	r3, [r0, #12]
	ldrb	r1, [r4, #8]
	ldrb	r2, [r3, #3]
	bfi	r2, r1, #0, #1
	strb	r2, [r3, #3]
	ldr	r2, [r0, #16]
	ldr	r3, [r4, #192]
	bic	r3, r3, #15
	str	r3, [r2]
	ldr	r2, [r0, #20]
	ldr	r3, [r4, #196]
	bic	r3, r3, #15
	str	r3, [r2]
	ldr	r2, [r0, #24]
	ldr	r3, [r4, #224]
	bic	r3, r3, #15
	str	r3, [r2]
	ldr	r2, [r0, #28]
	ldr	r3, [r4, #256]
	bic	r3, r3, #15
	str	r3, [r2]
	ldr	r0, [r4, #156]
	bl	MEM_Phy2Vir
	mov	r7, r0
	ldr	r0, [r4, #160]
	bl	MEM_Phy2Vir
	ldr	r1, [r4, #176]
	cmp	r1, #0
	mov	r9, r0
	beq	.L55
	ldr	r2, [r4, #164]
	cmp	r7, #0
	ldr	r8, [r4, #168]
	ldr	r1, [r4, #160]
	ldr	r0, [r6, #32]
	ldr	r3, [r4, #156]
	add	r8, r1, r8, lsr #3
	bic	lr, r8, #15
	add	r3, r3, r2, lsr #3
	ldr	ip, [r0]
	bic	r1, r3, #15
	and	r2, r3, #15
	rsb	r3, lr, r1
	bfi	ip, r3, #0, #24
	str	ip, [r0]
	ldr	r3, [r6, #36]
	ldr	r0, [r4, #172]
	ldr	r1, [r3]
	bfi	r1, r0, #0, #24
	str	r1, [r3]
	ldr	r1, [r6, #36]
	ldr	r3, [r4, #164]
	ldrb	r0, [r1, #3]
	and	r3, r3, #7
	add	r3, r3, r2, lsl #3
	bfi	r0, r3, #0, #7
	strb	r0, [r1, #3]
	beq	.L38
	ldr	r3, [r4, #164]
	mov	r0, #8
	ldr	r1, .L56+4
	add	ip, r7, r3, lsr #3
	ldrb	r2, [r7, r3, lsr #3]
	ldrb	lr, [ip, #7]
	ldrb	r3, [ip, #1]
	str	lr, [sp, #20]
	ldrb	lr, [ip, #6]
	str	lr, [sp, #16]
	ldrb	lr, [ip, #5]
	str	lr, [sp, #12]
	ldrb	lr, [ip, #4]
	str	lr, [sp, #8]
	ldrb	lr, [ip, #3]
	str	lr, [sp, #4]
	ldrb	ip, [ip, #2]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r2, [r4, #172]
	ldr	r3, [r4, #164]
	mov	r0, #9
	add	ip, r2, #7
	cmp	r2, #0
	ldr	r1, .L56+8
	mov	r3, r3, lsr #3
	movlt	r2, ip
	sub	r3, r3, #8
	add	r3, r3, r2, asr #3
	add	ip, r7, r3
	ldrb	r2, [r7, r3]
	ldrb	lr, [ip, #7]
	ldrb	r3, [ip, #1]
	str	lr, [sp, #20]
	ldrb	lr, [ip, #6]
	str	lr, [sp, #16]
	ldrb	lr, [ip, #5]
	str	lr, [sp, #12]
	ldrb	lr, [ip, #4]
	str	lr, [sp, #8]
	ldrb	lr, [ip, #3]
	str	lr, [sp, #4]
	ldrb	ip, [ip, #2]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r2, [r4, #172]
	ldr	r3, [r4, #156]
	mov	r0, #22
	ldr	r1, .L56+12
	add	r2, r2, r3
	bl	dprint_vfmw
.L38:
	ldr	r3, [r6, #40]
	and	r8, r8, #15
	cmp	r9, #0
	ldr	r2, [r3]
	bfc	r2, #0, #24
	str	r2, [r3]
	ldr	r2, [r6, #44]
	ldr	r3, [r4, #176]
	ldr	r1, [r2]
	add	r3, r3, #24
	bfi	r1, r3, #0, #24
	str	r1, [r2]
	ldr	r2, [r6, #44]
	ldr	r3, [r4, #168]
	ldrb	r1, [r2, #3]
	and	r3, r3, #7
	add	r8, r3, r8, lsl #3
	bfi	r1, r8, #0, #7
	strb	r1, [r2, #3]
	beq	.L37
	ldr	r3, [r4, #168]
	mov	r0, #8
	ldr	r1, .L56+16
	add	ip, r9, r3, lsr #3
	ldrb	r2, [r9, r3, lsr #3]
	ldrb	lr, [ip, #7]
	ldrb	r3, [ip, #1]
	str	lr, [sp, #20]
	ldrb	lr, [ip, #6]
	str	lr, [sp, #16]
	ldrb	lr, [ip, #5]
	str	lr, [sp, #12]
	ldrb	lr, [ip, #4]
	str	lr, [sp, #8]
	ldrb	lr, [ip, #3]
	str	lr, [sp, #4]
	ldrb	ip, [ip, #2]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r2, [r4, #176]
	ldr	r3, [r4, #168]
	mov	r0, #9
	add	ip, r2, #7
	cmp	r2, #0
	ldr	r1, .L56+20
	mov	r3, r3, lsr #3
	movlt	r2, ip
	sub	r3, r3, #8
	add	r3, r3, r2, asr #3
	add	ip, r9, r3
	ldrb	r2, [r9, r3]
	ldrb	lr, [ip, #7]
	ldrb	r3, [ip, #1]
	str	lr, [sp, #20]
	ldrb	lr, [ip, #6]
	str	lr, [sp, #16]
	ldrb	lr, [ip, #5]
	str	lr, [sp, #12]
	ldrb	lr, [ip, #4]
	str	lr, [sp, #8]
	ldrb	lr, [ip, #3]
	str	lr, [sp, #4]
	ldrb	ip, [ip, #2]
	str	ip, [sp]
	bl	dprint_vfmw
.L37:
	add	r7, r6, #64
	mov	r1, r6
.L41:
	mov	ip, r4
	mov	r3, r1
	mov	r2, #2
.L39:
	ldr	r0, [r3, #48]
	subs	r2, r2, #1
	ldrb	lr, [ip, #80]
	add	r3, r3, #4
	add	ip, ip, #8
	strb	lr, [r0]
	ldr	r0, [r3, #44]
	ldrb	lr, [ip, #88]
	strb	lr, [r0, #1]
	ldr	r0, [r3, #44]
	ldrb	lr, [ip, #104]
	strb	lr, [r0, #2]
	ldr	r0, [r3, #44]
	ldrb	lr, [ip, #120]
	strb	lr, [r0, #3]
	ldr	r0, [r3, #172]
	ldrb	lr, [ip, #8]
	strb	lr, [r0]
	ldr	r0, [r3, #172]
	ldrb	lr, [ip, #24]
	strb	lr, [r0, #1]
	ldr	r0, [r3, #172]
	ldrb	lr, [ip, #40]
	strb	lr, [r0, #2]
	ldr	r0, [r3, #172]
	ldrb	lr, [ip, #56]
	strb	lr, [r0, #3]
	bne	.L39
	add	r1, r1, #8
	add	r4, r4, #1
	cmp	r1, r7
	bne	.L41
	ldr	r1, [r6, #304]
	mov	r0, r2
	ldr	r3, [r5, #1148]
	bic	r3, r3, #15
	str	r3, [r1]
.L52:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L55:
	ldr	r0, [r6, #32]
	cmp	r7, #0
	ldr	r2, [r4, #164]
	ldr	r3, [r4, #156]
	ldr	ip, [r0]
	add	r3, r3, r2, lsr #3
	bfi	ip, r1, #0, #24
	str	ip, [r0]
	ldr	r1, [r6, #36]
	and	r2, r3, #15
	ldr	r3, [r4, #172]
	ldr	r0, [r1]
	add	r3, r3, #24
	bfi	r0, r3, #0, #24
	str	r0, [r1]
	ldr	r1, [r6, #36]
	ldr	r3, [r4, #164]
	ldrb	r0, [r1, #3]
	and	r3, r3, #7
	add	r3, r3, r2, lsl #3
	bfi	r0, r3, #0, #7
	strb	r0, [r1, #3]
	beq	.L36
	ldr	r3, [r4, #164]
	mov	r0, #8
	ldr	r1, .L56+24
	add	ip, r7, r3, lsr #3
	ldrb	r2, [r7, r3, lsr #3]
	ldrb	lr, [ip, #7]
	ldrb	r3, [ip, #1]
	str	lr, [sp, #20]
	ldrb	lr, [ip, #6]
	str	lr, [sp, #16]
	ldrb	lr, [ip, #5]
	str	lr, [sp, #12]
	ldrb	lr, [ip, #4]
	str	lr, [sp, #8]
	ldrb	lr, [ip, #3]
	str	lr, [sp, #4]
	ldrb	ip, [ip, #2]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r2, [r4, #172]
	ldr	r3, [r4, #164]
	mov	r0, #9
	add	ip, r2, #7
	cmp	r2, #0
	ldr	r1, .L56+28
	mov	r3, r3, lsr #3
	movlt	r2, ip
	sub	r3, r3, #8
	add	r3, r3, r2, asr #3
	add	ip, r7, r3
	ldrb	r2, [r7, r3]
	ldrb	lr, [ip, #7]
	ldrb	r3, [ip, #1]
	str	lr, [sp, #20]
	ldrb	lr, [ip, #6]
	str	lr, [sp, #16]
	ldrb	lr, [ip, #5]
	str	lr, [sp, #12]
	ldrb	lr, [ip, #4]
	str	lr, [sp, #8]
	ldrb	lr, [ip, #3]
	str	lr, [sp, #4]
	ldrb	ip, [ip, #2]
	str	ip, [sp]
	bl	dprint_vfmw
.L36:
	ldr	r3, [r6, #40]
	ldr	r2, [r3]
	bfc	r2, #0, #24
	str	r2, [r3]
	ldr	r3, [r6, #44]
	ldr	r2, [r3]
	bfc	r2, #0, #24
	str	r2, [r3]
	ldr	r3, [r6, #44]
	ldrb	r2, [r3, #3]
	bfc	r2, #0, #7
	strb	r2, [r3, #3]
	b	.L37
.L54:
	ldr	r3, .L56+32
.L53:
	mov	r0, #0
	ldr	r2, .L56+36
	ldr	r1, .L56+40
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L52
.L57:
	.align	2
.L56:
	.word	.LC8
	.word	.LC13
	.word	.LC14
	.word	.LC15
	.word	.LC16
	.word	.LC17
	.word	.LC11
	.word	.LC12
	.word	.LC10
	.word	.LANCHOR0
	.word	.LC9
	.fnend
	.size	MP2HAL_V400R003_MakeDnMsg, .-MP2HAL_V400R003_MakeDnMsg
	.align	2
	.global	MP2HAL_V400R003_CfgReg
	.type	MP2HAL_V400R003_CfgReg, %function
MP2HAL_V400R003_CfgReg:
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
	add	r7, r0, #45056
	mov	r10, r3
	cmp	r2, #0
	mov	r6, r0
	ldr	r3, [r7, #284]
	mov	r0, #0
	mov	r8, r1
	str	r0, [fp, #-48]
	ldr	r5, [fp, #4]
	str	r3, [fp, #-56]
	beq	.L60
	cmp	r2, #1
	bne	.L81
	mov	r3, r2
	str	r0, [sp]
	ldr	r2, .L83
	ldr	r1, .L83+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L62
.L60:
	ldr	r3, [r1]
	cmp	r3, #0
	beq	.L82
.L63:
	ldrh	lr, [r6, #152]
	mov	r3, r5
	ldrh	r1, [r6, #148]
	mov	r2, #0
	ldr	ip, [fp, #-48]
	mov	r0, #8
	mov	r4, r2
	mov	r9, #3
	mul	r1, r1, lr
	sub	r1, r1, #1
	bfi	ip, r1, #0, #20
	str	ip, [fp, #-48]
	ubfx	r1, ip, #16, #8
	mov	ip, ip, lsr #24
	orr	r1, r1, #64
	and	ip, ip, #62
	bfc	r1, #7, #1
	orr	ip, ip, #65
	strb	r1, [fp, #-46]
	bfc	ip, #1, #1
	strb	ip, [fp, #-45]
	ldr	ip, [fp, #-48]
	mov	r1, ip
	str	ip, [fp, #-60]
	bl	MFDE_ConfigReg
	ldr	ip, [fp, #-60]
	ldr	r1, .L83+8
	mov	r0, r9
	mov	r2, ip
	bl	dprint_vfmw
	ldr	r2, [fp, #-56]
	ldr	r1, [r7, #280]
	mov	r3, #0
	bfi	r3, r2, #3, #1
	mov	r2, #0
	bfi	r3, r1, #4, #1
	bfi	r2, r4, #4, #1
	strh	r9, [fp, #-46]
	and	r3, r3, #223
	strb	r2, [fp, #-45]
	orr	r3, r3, #64
	ldr	r1, [r7, #276]
	uxtb	r2, r2
	bfi	r3, r4, #7, #1
	strb	r9, [fp, #-48]
	strb	r3, [fp, #-47]
	bfi	r2, r1, #6, #1
	strb	r2, [fp, #-45]
	mov	r3, r5
	ldr	ip, [fp, #-48]
	mov	r2, r4
	mov	r0, #12
	mov	r1, ip
	str	ip, [fp, #-56]
	bl	MFDE_ConfigReg
	ldr	ip, [fp, #-56]
	ldr	r1, .L83+12
	mov	r0, r9
	mov	r2, ip
	bl	dprint_vfmw
	ldr	r1, [r8, #56]
	mov	r2, r4
	mov	r3, r5
	bic	r1, r1, #15
	mov	r0, #16
	bl	MFDE_ConfigReg
	ldr	r1, [r8, #40]
	mov	r2, r4
	mov	r3, r5
	bic	r1, r1, #15
	mov	r0, #20
	bl	MFDE_ConfigReg
	ldr	r1, [r7, #268]
	str	r4, [fp, #-48]
	cmp	r1, r4
	beq	.L65
	mov	r3, r6
	mvn	ip, #0
.L66:
	ldr	r2, [r3, #268]
	cmp	r2, #0
	beq	.L69
	ldr	r0, [r3, #276]
	bic	r2, r2, #15
	cmp	r0, #0
	ble	.L69
	cmp	ip, r2
	movcs	ip, r2
.L69:
	ldr	r2, [r3, #272]
	cmp	r2, #0
	beq	.L67
	ldr	r0, [r3, #280]
	bic	r2, r2, #15
	cmp	r0, #0
	ble	.L67
	cmp	ip, r2
	movcs	ip, r2
.L67:
	add	r4, r4, #1
	add	r3, r3, #44
	cmp	r4, r1
	bne	.L66
	cmn	ip, #1
	beq	.L65
	mov	r1, ip
	str	ip, [r10]
	mov	r3, r5
	mov	r2, #0
	mov	r0, #24
	str	ip, [fp, #-48]
	bl	MFDE_ConfigReg
	ldrh	r1, [r6, #152]
	mov	r3, r5
	mov	r2, #0
	cmp	r1, #120
	mov	r0, #4
	movhi	r1, #0
	movls	r1, #1
	bl	SCD_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, #0
	movt	r1, 48
	mov	r0, #60
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, #0
	movt	r1, 48
	mov	r0, #64
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, #0
	movt	r1, 48
	mov	r0, #68
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, #0
	movt	r1, 48
	mov	r0, #72
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, #0
	movt	r1, 48
	mov	r0, #76
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, #0
	movt	r1, 48
	mov	r0, #80
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, #0
	movt	r1, 48
	mov	r0, #84
	bl	MFDE_ConfigReg
	ldr	r1, [r6, #200]
	mov	r3, r5
	mov	r2, #0
	bic	r1, r1, #15
	mov	r0, #96
	bl	MFDE_ConfigReg
	mov	r2, #0
	mov	r4, r2
	ldr	r1, [r6, #236]
	mov	r3, r5
	mov	r0, #100
	bl	MFDE_ConfigReg
	mov	r3, r5
	ldr	r1, [r6, #240]
	mov	r2, r4
	mov	r0, #104
	bl	MFDE_ConfigReg
	ldr	r2, [r6, #240]
	ldr	r1, .L83+16
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r3, [r6, #208]
	ldr	r1, [r6, #204]
	mov	r2, r4
	and	r3, r3, #3
	str	r4, [fp, #-48]
	bfi	r3, r1, #2, #2
	strb	r3, [fp, #-48]
	ldr	r7, [fp, #-48]
	mov	r3, r5
	mov	r0, #148
	mov	r1, r7
	bl	MFDE_ConfigReg
	mov	r2, r7
	ldr	r1, .L83+20
	mov	r0, #3
	bl	dprint_vfmw
	str	r4, [fp, #-48]
	mov	r3, #0
	bfi	r3, r4, #0, #1
	strb	r3, [fp, #-48]
	mov	r2, r4
	ldr	r1, [fp, #-48]
	mov	r3, r5
	mov	r0, #152
	bl	MFDE_ConfigReg
	ldr	r6, [r6, #248]
	mov	r3, r5
	mov	r2, r4
	mov	r0, #108
	mov	r1, r6
	bl	MFDE_ConfigReg
	mov	r2, r6
	ldr	r1, .L83+24
	mov	r0, #3
	bl	dprint_vfmw
	mov	r0, #32
	mov	r3, r5
	mov	r2, r4
	mvn	r1, #0
	bl	MFDE_ConfigReg
	mov	r0, r4
.L62:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L81:
	ldr	r1, .L83+28
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L82:
	mov	r0, #0
	movt	r0, 63683
	bl	MEM_Phy2Vir
	subs	r3, r0, #0
	beq	.L64
	str	r3, [r8]
	b	.L63
.L65:
	mvn	r2, #0
	ldr	r1, .L83+32
	mov	r0, #0
	bl	dprint_vfmw
	mov	r3, #0
	mvn	r0, #0
	str	r3, [r10]
	b	.L62
.L64:
	ldr	r1, .L83+36
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L62
.L84:
	.align	2
.L83:
	.word	.LANCHOR0+28
	.word	.LC19
	.word	.LC21
	.word	.LC22
	.word	.LC24
	.word	.LC25
	.word	.LC26
	.word	.LC18
	.word	.LC23
	.word	.LC20
	.fnend
	.size	MP2HAL_V400R003_CfgReg, .-MP2HAL_V400R003_CfgReg
	.align	2
	.global	MP2HAL_V400R003_CfgDnMsg
	.type	MP2HAL_V400R003_CfgDnMsg, %function
MP2HAL_V400R003_CfgDnMsg:
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
	str	r3, [fp, #-64]
	mov	r6, r1
	mov	r3, #0
	str	r3, [fp, #-48]
	bl	MEM_Phy2Vir
	subs	r5, r0, #0
	beq	.L112
	ldrh	r2, [r4, #152]
	cmp	r2, #512
	bhi	.L113
	ldrh	r1, [r4, #148]
	cmp	r1, #512
	bhi	.L114
	ldrh	r3, [fp, #-46]
	sub	r1, r1, #1
	ldr	r0, [r4, #180]
	sub	r2, r2, #1
	bfi	r3, r1, #0, #9
	ldrh	r1, [fp, #-48]
	strh	r3, [fp, #-46]
	mov	r8, #0
	mov	r3, r3, lsr #8
	bfi	r1, r2, #0, #9
	bfi	r3, r0, #1, #1
	strh	r1, [fp, #-48]
	strb	r3, [fp, #-45]
	mov	r7, r8
	ldr	r3, [fp, #-48]
	mov	lr, r8
	mov	ip, r8
	mov	r0, r8
	mov	r1, r8
	mov	r10, r8
	str	r3, [r5]
	ldrb	r3, [r4]
	ldrb	r2, [r4, #3]
	ldrb	r9, [r4, #2]
	and	r3, r3, #7
	and	r2, r2, #3
	str	r2, [fp, #-60]
	ldrb	r2, [r4, #4]
	bfi	r3, r9, #3, #1
	ldrb	r9, [r4, #1]
	bfi	r3, r9, #4, #1
	mov	r9, r2
	ldr	r2, [fp, #-60]
	strb	r3, [fp, #-45]
	ldrb	r3, [r4, #5]
	bfi	r2, r9, #2, #1
	str	r2, [fp, #-60]
	mov	r9, r8
	ldrb	r2, [fp, #-60]
	bfi	r8, r3, #0, #1
	ldrb	r3, [r4, #7]
	strb	r8, [fp, #-48]
	strb	r2, [fp, #-47]
	mov	r2, r7
	bfi	r7, r3, #0, #1
	strb	r7, [fp, #-46]
	ldr	r3, [fp, #-48]
	str	r3, [r5, #4]
	ldrb	r3, [r4, #12]
	ldrb	r7, [r4, #15]
	ldrb	r8, [r4, #6]
	and	r3, r3, #15
	bfi	lr, r7, #0, #4
	strb	lr, [fp, #-48]
	bfi	r3, r8, #7, #1
	strb	r3, [fp, #-45]
	ldrb	r3, [r4, #14]
	ldrb	r7, [r4, #13]
	bfi	ip, r3, #0, #4
	strb	ip, [fp, #-47]
	bfi	r0, r7, #0, #4
	strb	r0, [fp, #-46]
	ldr	r3, [fp, #-48]
	str	r3, [r5, #8]
	ldrb	r3, [r4, #11]
	ldrb	r0, [r4, #10]
	bfi	r1, r3, #0, #2
	ldrb	r3, [r4, #8]
	strb	r1, [fp, #-48]
	bfi	r10, r0, #0, #1
	ldrb	r1, [r4, #9]
	bfi	r2, r3, #0, #1
	strb	r10, [fp, #-47]
	bfi	r9, r1, #0, #1
	strb	r2, [fp, #-45]
	strb	r9, [fp, #-46]
	ldr	r3, [fp, #-48]
	str	r3, [r5, #12]
	ldr	r3, [r4, #192]
	bic	r3, r3, #15
	str	r3, [r5, #16]
	ldr	r3, [r4, #196]
	bic	r3, r3, #15
	str	r3, [r5, #20]
	ldr	r3, [r4, #224]
	bic	r3, r3, #15
	str	r3, [r5, #24]
	ldr	r3, [r4, #256]
	bic	r3, r3, #15
	str	r3, [r5, #28]
	ldr	r0, [r4, #156]
	str	r3, [fp, #-48]
	bl	MEM_Phy2Vir
	mov	r7, r0
	ldr	r0, [r4, #160]
	bl	MEM_Phy2Vir
	ldr	r3, [r4, #176]
	cmp	r3, #0
	mov	r9, r0
	beq	.L115
	ldr	r2, [r4, #164]
	mov	r1, #0
	ldr	r8, [r4, #168]
	mov	r0, r1
	ldr	ip, [r4, #160]
	cmp	r7, r1
	ldr	r3, [r4, #156]
	add	r8, ip, r8, lsr #3
	add	r3, r3, r2, lsr #3
	bic	lr, r8, #15
	bic	ip, r3, #15
	and	r2, r3, #15
	rsb	r3, lr, ip
	bfi	r1, r3, #0, #24
	str	r1, [r5, #32]
	ldr	r1, [r4, #172]
	ldr	r3, [r4, #164]
	bfi	r0, r1, #0, #24
	str	r0, [fp, #-48]
	and	r3, r3, #7
	ldrb	r1, [fp, #-45]
	add	r3, r3, r2, lsl #3
	bfi	r1, r3, #0, #7
	strb	r1, [fp, #-45]
	ldr	r3, [fp, #-48]
	str	r3, [r5, #36]
	beq	.L93
	ldr	r3, [r4, #164]
	mov	r0, #8
	ldr	r1, .L118
	add	ip, r7, r3, lsr #3
	ldrb	r2, [r7, r3, lsr #3]
	ldrb	lr, [ip, #7]
	ldrb	r3, [ip, #1]
	str	lr, [sp, #20]
	ldrb	lr, [ip, #6]
	str	lr, [sp, #16]
	ldrb	lr, [ip, #5]
	str	lr, [sp, #12]
	ldrb	lr, [ip, #4]
	str	lr, [sp, #8]
	ldrb	lr, [ip, #3]
	str	lr, [sp, #4]
	ldrb	ip, [ip, #2]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r2, [r4, #172]
	ldr	r3, [r4, #164]
	mov	r0, #9
	add	ip, r2, #7
	cmp	r2, #0
	ldr	r1, .L118+4
	mov	r3, r3, lsr #3
	movlt	r2, ip
	sub	r3, r3, #8
	add	r3, r3, r2, asr #3
	add	ip, r7, r3
	ldrb	r2, [r7, r3]
	ldrb	lr, [ip, #7]
	ldrb	r3, [ip, #1]
	str	lr, [sp, #20]
	ldrb	lr, [ip, #6]
	str	lr, [sp, #16]
	ldrb	lr, [ip, #5]
	str	lr, [sp, #12]
	ldrb	lr, [ip, #4]
	str	lr, [sp, #8]
	ldrb	lr, [ip, #3]
	str	lr, [sp, #4]
	ldrb	ip, [ip, #2]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r2, [r4, #172]
	ldr	r3, [r4, #156]
	mov	r0, #22
	ldr	r1, .L118+8
	add	r2, r2, r3
	bl	dprint_vfmw
.L93:
	mov	r3, #0
	and	r8, r8, #15
	mov	r2, r3
	bfi	r2, r3, #0, #24
	str	r2, [r5, #40]
	cmp	r9, r3
	ldr	r1, [r4, #176]
	ldr	r2, [r4, #168]
	add	r1, r1, #24
	bfi	r3, r1, #0, #24
	str	r3, [fp, #-48]
	and	r3, r2, #7
	ldrb	r2, [fp, #-45]
	add	r8, r3, r8, lsl #3
	bfi	r2, r8, #0, #7
	strb	r2, [fp, #-45]
	ldr	r3, [fp, #-48]
	str	r3, [r5, #44]
	beq	.L92
	ldr	r3, [r4, #168]
	mov	r0, #8
	ldr	r1, .L118+12
	add	ip, r9, r3, lsr #3
	ldrb	r2, [r9, r3, lsr #3]
	ldrb	lr, [ip, #7]
	ldrb	r3, [ip, #1]
	str	lr, [sp, #20]
	ldrb	lr, [ip, #6]
	str	lr, [sp, #16]
	ldrb	lr, [ip, #5]
	str	lr, [sp, #12]
	ldrb	lr, [ip, #4]
	str	lr, [sp, #8]
	ldrb	lr, [ip, #3]
	str	lr, [sp, #4]
	ldrb	ip, [ip, #2]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r2, [r4, #176]
	ldr	r3, [r4, #168]
	mov	r0, #9
	add	ip, r2, #7
	cmp	r2, #0
	ldr	r1, .L118+16
	mov	r3, r3, lsr #3
	movlt	r2, ip
	sub	r3, r3, #8
	add	r3, r3, r2, asr #3
	add	ip, r9, r3
	ldrb	r2, [r9, r3]
	ldrb	lr, [ip, #7]
	ldrb	r3, [ip, #1]
	str	lr, [sp, #20]
	ldrb	lr, [ip, #6]
	str	lr, [sp, #16]
	ldrb	lr, [ip, #5]
	str	lr, [sp, #12]
	ldrb	lr, [ip, #4]
	str	lr, [sp, #8]
	ldrb	lr, [ip, #3]
	str	lr, [sp, #4]
	ldrb	ip, [ip, #2]
	str	ip, [sp]
	bl	dprint_vfmw
.L92:
	add	r8, r5, #64
	add	r10, r4, #8
	mov	r1, r4
.L98:
	add	r7, r1, #16
	mov	r2, r8
	mov	r3, r1
.L94:
	ldrb	r9, [r3, #80]
	add	r3, r3, #8
	ldrb	lr, [r3, #88]
	add	r2, r2, #4
	ldrb	ip, [r3, #104]
	ldrb	r0, [r3, #120]
	strb	r9, [fp, #-48]
	strb	lr, [fp, #-47]
	strb	ip, [fp, #-46]
	strb	r0, [fp, #-45]
	ldr	r0, [fp, #-48]
	str	r0, [r2, #-4]
	ldrb	r0, [r3, #56]
	ldrb	r9, [r3, #8]
	ldrb	lr, [r3, #24]
	ldrb	ip, [r3, #40]
	cmp	r7, r3
	strb	r9, [fp, #-48]
	strb	lr, [fp, #-47]
	strb	ip, [fp, #-46]
	strb	r0, [fp, #-45]
	ldr	r0, [fp, #-48]
	str	r0, [r2, #60]
	bne	.L94
	add	r1, r1, #1
	add	r8, r8, #8
	cmp	r1, r10
	bne	.L98
	ldr	r3, [r6, #1148]
	bic	r3, r3, #15
	str	r3, [r5, #192]
	ldr	r3, [r4, #228]
	bic	r3, r3, #15
	str	r3, [r5, #196]
	ldr	r3, [r4, #232]
	str	r3, [r5, #200]
	ldr	r7, [r6, #56]
	str	r3, [fp, #-48]
	bic	r7, r7, #15
	add	r7, r7, #256
	mov	r0, r7
	bl	MEM_Phy2Vir
	subs	r1, r0, #0
	beq	.L116
	ldr	r3, [fp, #-64]
	mov	r0, r4
	str	r7, [r5, #252]
	mov	r2, r7
	str	r7, [fp, #-48]
	bl	MP2HAL_V400R003_WriteSliceMsg
	ldr	r3, .L118+20
	ldr	r3, [r3]
	ands	r0, r3, #16
	bne	.L117
.L111:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L115:
	ldr	ip, [r4, #164]
	mov	r0, r3
	ldr	r2, [r4, #156]
	cmp	r7, #0
	str	r3, [r5, #32]
	ldr	r1, [r4, #172]
	add	r2, r2, ip, lsr #3
	ldr	r3, [r4, #164]
	and	r2, r2, #15
	add	r1, r1, #24
	bfi	r0, r1, #0, #24
	and	r3, r3, #7
	str	r0, [fp, #-48]
	add	r3, r3, r2, lsl #3
	ldrb	r1, [fp, #-45]
	bfi	r1, r3, #0, #7
	strb	r1, [fp, #-45]
	ldr	r3, [fp, #-48]
	str	r3, [r5, #36]
	beq	.L91
	ldr	r3, [r4, #164]
	mov	r0, #8
	ldr	r1, .L118+24
	add	ip, r7, r3, lsr #3
	ldrb	r2, [r7, r3, lsr #3]
	ldrb	lr, [ip, #7]
	ldrb	r3, [ip, #1]
	str	lr, [sp, #20]
	ldrb	lr, [ip, #6]
	str	lr, [sp, #16]
	ldrb	lr, [ip, #5]
	str	lr, [sp, #12]
	ldrb	lr, [ip, #4]
	str	lr, [sp, #8]
	ldrb	lr, [ip, #3]
	str	lr, [sp, #4]
	ldrb	ip, [ip, #2]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r2, [r4, #172]
	ldr	r3, [r4, #164]
	mov	r0, #9
	add	ip, r2, #7
	cmp	r2, #0
	ldr	r1, .L118+28
	mov	r3, r3, lsr #3
	movlt	r2, ip
	sub	r3, r3, #8
	add	r3, r3, r2, asr #3
	add	ip, r7, r3
	ldrb	r2, [r7, r3]
	ldrb	lr, [ip, #7]
	ldrb	r3, [ip, #1]
	str	lr, [sp, #20]
	ldrb	lr, [ip, #6]
	str	lr, [sp, #16]
	ldrb	lr, [ip, #5]
	str	lr, [sp, #12]
	ldrb	lr, [ip, #4]
	str	lr, [sp, #8]
	ldrb	lr, [ip, #3]
	str	lr, [sp, #4]
	ldrb	ip, [ip, #2]
	str	ip, [sp]
	bl	dprint_vfmw
.L91:
	mov	r3, #0
	mov	r2, #0
	mov	r0, r3
	mov	r1, r3
	bfi	r0, r3, #0, #24
	bfi	r1, r3, #0, #24
	str	r0, [r5, #40]
	bfi	r2, r3, #0, #7
	str	r1, [fp, #-48]
	strb	r2, [fp, #-45]
	ldr	r3, [fp, #-48]
	str	r3, [r5, #44]
	b	.L92
.L117:
	ldr	ip, .L118+32
	mov	r0, #4
	ldr	r3, [r6, #56]
	mov	r4, #0
	ldr	r1, .L118+36
	mov	r6, r5
	ldr	r2, [ip]
	add	r2, r2, #1
	str	r2, [ip]
	bl	dprint_vfmw
.L97:
	ldr	ip, [r6, #12]
	mov	r2, r4
	ldr	r3, [r5, r4, asl #2]
	mov	r0, #4
	ldr	r1, .L118+40
	add	r4, r4, r0
	str	ip, [sp, #8]
	add	r6, r6, #16
	ldr	ip, [r6, #-8]
	str	ip, [sp, #4]
	ldr	ip, [r6, #-12]
	str	ip, [sp]
	bl	dprint_vfmw
	cmp	r4, #64
	bne	.L97
	ldr	r1, .L118+44
	mov	r0, #4
	bl	dprint_vfmw
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L114:
	mov	r0, #0
	ldr	r3, .L118+48
	ldr	r2, .L118+52
	ldr	r1, .L118+56
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L111
.L113:
	mov	r0, #0
	ldr	r3, .L118+60
	ldr	r2, .L118+52
	ldr	r1, .L118+56
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L111
.L116:
	ldr	r1, .L118+64
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L111
.L112:
	ldr	r3, .L118+68
	ldr	r2, .L118+52
	ldr	r1, .L118+56
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L111
.L119:
	.align	2
.L118:
	.word	.LC13
	.word	.LC14
	.word	.LC15
	.word	.LC16
	.word	.LC17
	.word	g_PrintEnable
	.word	.LC11
	.word	.LC12
	.word	.LANCHOR1
	.word	.LC29
	.word	.LC30
	.word	.LC31
	.word	.LC10
	.word	.LANCHOR0+52
	.word	.LC9
	.word	.LC8
	.word	.LC28
	.word	.LC27
	.fnend
	.size	MP2HAL_V400R003_CfgDnMsg, .-MP2HAL_V400R003_CfgDnMsg
	.align	2
	.global	MP2HAL_V400R003_StartDec
	.type	MP2HAL_V400R003_StartDec, %function
MP2HAL_V400R003_StartDec:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #28
	sub	sp, sp, #28
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r5, .L134
	cmp	r1, #0
	movw	r4, #1224
	mov	r6, r0
	mla	r4, r4, r1, r5
	bgt	.L131
	bne	.L129
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L132
.L126:
	ldr	lr, .L134+4
	sub	r3, fp, #32
	str	r2, [sp]
	mov	r1, r4
	mov	r2, #0
	mov	r0, r6
	ldr	ip, [lr]
	add	ip, ip, #1
	str	ip, [lr]
	bl	MP2HAL_V400R003_CfgReg
	subs	r5, r0, #0
	bne	.L133
	mov	r1, r4
	mov	r0, r6
	ldr	r3, [fp, #-32]
	mov	r2, r5
	bl	MP2HAL_V400R003_CfgDnMsg
.L122:
	mov	r0, r5
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L132:
	mov	r0, #0
	str	r2, [fp, #-40]
	movt	r0, 63683
	bl	MEM_Phy2Vir
	subs	r3, r0, #0
	beq	.L127
	str	r3, [r5]
	ldr	r2, [fp, #-40]
	b	.L126
.L131:
	mov	r3, r1
	mov	r0, #0
	ldr	r2, .L134+8
	mvn	r5, #0
	str	r0, [sp]
	ldr	r1, .L134+12
	bl	dprint_vfmw
	b	.L122
.L133:
	ldr	r1, .L134+16
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r5, #0
	b	.L122
.L129:
	ldr	r1, .L134+20
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r5, #0
	b	.L122
.L127:
	ldr	r1, .L134+24
	mvn	r5, #0
	bl	dprint_vfmw
	b	.L122
.L135:
	.align	2
.L134:
	.word	g_HwMem
	.word	.LANCHOR2
	.word	.LANCHOR0+80
	.word	.LC19
	.word	.LC33
	.word	.LC32
	.word	.LC20
	.fnend
	.size	MP2HAL_V400R003_StartDec, .-MP2HAL_V400R003_StartDec
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	__func__.15286, %object
	.size	__func__.15286, 26
__func__.15286:
	.ascii	"MP2HAL_V400R003_MakeDnMsg\000"
	.space	2
	.type	__func__.15315, %object
	.size	__func__.15315, 23
__func__.15315:
	.ascii	"MP2HAL_V400R003_CfgReg\000"
	.space	1
	.type	__func__.15338, %object
	.size	__func__.15338, 25
__func__.15338:
	.ascii	"MP2HAL_V400R003_CfgDnMsg\000"
	.space	3
	.type	__func__.15239, %object
	.size	__func__.15239, 25
__func__.15239:
	.ascii	"MP2HAL_V400R003_StartDec\000"
	.data
	.align	2
.LANCHOR2 = . + 0
	.type	FrameNum, %object
	.size	FrameNum, 4
FrameNum:
	.word	-1
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"D0 = %#x \012\000"
	.space	1
.LC1:
	.ascii	"D1 = %#x \012\000"
	.space	1
.LC2:
	.ascii	"D2 = %#x \012\000"
	.space	1
.LC3:
	.ascii	"D3 = %#x \012\000"
	.space	1
.LC4:
	.ascii	"D4 = %#x \012\000"
	.space	1
.LC5:
	.ascii	"D5 = %#x \012\000"
	.space	1
.LC6:
	.ascii	"D6 = %#x \012\000"
	.space	1
.LC7:
	.ascii	"D7 = %#x \012\000"
	.space	1
.LC8:
	.ascii	"picture width out of range\000"
	.space	1
.LC9:
	.ascii	"%s: %s\012\000"
.LC10:
	.ascii	"picture height out of range\000"
.LC11:
	.ascii	"Stream Head (8bytes): 0x%02x 0x%02x 0x%02x 0x%02x 0"
	.ascii	"x%02x 0x%02x 0x%02x 0x%02x\012\000"
	.space	1
.LC12:
	.ascii	"Stream Tail (8bytes): 0x%02x 0x%02x 0x%02x 0x%02x 0"
	.ascii	"x%02x 0x%02x 0x%02x 0x%02x\012\000"
	.space	1
.LC13:
	.ascii	"1p Stream Head (8bytes): 0x%02x 0x%02x 0x%02x 0x%02"
	.ascii	"x 0x%02x 0x%02x 0x%02x 0x%02x\012\000"
	.space	2
.LC14:
	.ascii	"1p Stream Tail (8bytes): 0x%02x 0x%02x 0x%02x 0x%02"
	.ascii	"x 0x%02x 0x%02x 0x%02x 0x%02x\012\000"
	.space	2
.LC15:
	.ascii	"1p last phy addr = 0x%x\012\000"
	.space	3
.LC16:
	.ascii	"2p Stream Head (8bytes): 0x%02x 0x%02x 0x%02x 0x%02"
	.ascii	"x 0x%02x 0x%02x 0x%02x 0x%02x\012\000"
	.space	2
.LC17:
	.ascii	"2p Stream Tail (8bytes): 0x%02x 0x%02x 0x%02x 0x%02"
	.ascii	"x 0x%02x 0x%02x 0x%02x 0x%02x\012\000"
	.space	2
.LC18:
	.ascii	"VdhId is wrong! MP2HAL_V200R003_CfgReg\012\000"
.LC19:
	.ascii	"%s: VdhId(%d) > %d\012\000"
.LC20:
	.ascii	"vdm register virtual address not mapped, reset fail"
	.ascii	"ed!\012\000"
.LC21:
	.ascii	"MPEG2  VREG_V400R003_BASIC_CFG0= 0x%x\012\000"
	.space	1
.LC22:
	.ascii	"MPEG2  VREG_V400R003_BASIC_CFG1= 0x%x\012\000"
	.space	1
.LC23:
	.ascii	"stream_base_addr = %#x\012\000"
.LC24:
	.ascii	"MPEG2  VREG_V400R003_UVOFFSET_1D= 0x%x\012\000"
.LC25:
	.ascii	"MPEG2  VREG_V400R003_REF_PIC_TYPE= 0x%x\012\000"
	.space	3
.LC26:
	.ascii	"HEAD_INF_OFFSET = 0x%x\012\000"
.LC27:
	.ascii	"can not map down msg virtual address!\000"
	.space	2
.LC28:
	.ascii	"Map SlcDnMsgPhyAddr to SlcDnMsgVirAddr is NULL \012"
	.ascii	"\000"
	.space	3
.LC29:
	.ascii	"\012*****No.%2d Down Msg (phy addr: %#8x) *****\012"
	.ascii	"\000"
	.space	2
.LC30:
	.ascii	"\0120x%02x 0x%08x 0x%08x 0x%08x 0x%08x\012\000"
	.space	3
.LC31:
	.ascii	"\012***** Down Msg print finished *****\012\000"
	.space	2
.LC32:
	.ascii	"VdhId is wrong! MP2HAL_V200R003_StartDec\012\000"
	.space	2
.LC33:
	.ascii	"MP2HAL_V200R003_CfgReg ERROR!\012\000"
	.bss
	.align	2
.LANCHOR1 = . + 0
	.type	num.15349, %object
	.size	num.15349, 4
num.15349:
	.space	4
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
