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
	.file	"vp6.c"

	.text
	.align	2
	.global	Vp6_Vfmw_DecodeBool
	.type	Vp6_Vfmw_DecodeBool, %function
Vp6_Vfmw_DecodeBool:
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
	mov	r7, r1
	ldmib	r1, {r1, r5}
	mov	r6, r0
	ldr	r3, [r7, #12]
	sub	r4, r1, #1
	mul	r2, r4, r2
	mov	r4, r2, lsr #8
	add	r4, r4, #1
	mov	r2, r4, asl #16
	cmp	r5, r2
	rsbcs	r4, r4, r1
	rsbcs	r5, r2, r5
	movcs	r8, #1
	movcc	r8, #0
	cmp	r4, #127
	bls	.L6
	b	.L9
.L5:
	cmp	r4, #127
	bhi	.L11
.L6:
	subs	r3, r3, #1
	mov	r4, r4, asl #1
	mov	r5, r5, asl #1
	bne	.L5
	mov	r1, #8
	mov	r0, r6
	bl	BsGet
	cmp	r4, #127
	mov	r3, #8
	orr	r5, r5, r0
	bls	.L6
.L11:
	str	r3, [r7, #12]
.L9:
	stmib	r7, {r4, r5}
	mov	r0, r8
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	Vp6_Vfmw_DecodeBool, .-Vp6_Vfmw_DecodeBool
	.align	2
	.global	Vp6_Vfmw_DecodeBool128
	.type	Vp6_Vfmw_DecodeBool128, %function
Vp6_Vfmw_DecodeBool128:
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
	ldr	r5, [r1, #4]
	ldr	r2, [r1, #8]
	mov	r4, r1
	add	r3, r5, #1
	ldr	r1, [r1, #12]
	mov	r3, r3, lsr #1
	mov	r6, r3, asl #16
	cmp	r2, r6
	rsbcs	r3, r3, r5
	rsbcs	r2, r6, r2
	movcs	r7, #1
	movcc	r5, r3, asl #1
	movcs	r5, r3, asl r7
	movcs	r6, r2, asl r7
	movcc	r6, r2, asl #1
	movcc	r7, #0
	subs	r1, r1, #1
	bne	.L15
	mov	r1, #8
	bl	BsGet
	mov	r1, #8
	orr	r6, r6, r0
.L15:
	str	r1, [r4, #12]
	mov	r0, r7
	stmib	r4, {r5, r6}
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	Vp6_Vfmw_DecodeBool128, .-Vp6_Vfmw_DecodeBool128
	.align	2
	.global	Vp6_Vfmw_BoolRead
	.type	Vp6_Vfmw_BoolRead, %function
Vp6_Vfmw_BoolRead:
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
	subs	r4, r2, #1
	mov	r5, #0
	mov	r6, r0
	mov	r7, r1
	bmi	.L17
.L18:
	mov	r1, r7
	mov	r0, r6
	bl	Vp6_Vfmw_DecodeBool128
	orr	r5, r5, r0, asl r4
	subs	r4, r4, #1
	bcs	.L18
.L17:
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	Vp6_Vfmw_BoolRead, .-Vp6_Vfmw_BoolRead
	.align	2
	.global	Vp6_Vfmw_StartDecode
	.type	Vp6_Vfmw_StartDecode, %function
Vp6_Vfmw_StartDecode:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r4, r1
	mov	r2, #0
	mov	r3, #255
	stmia	r1, {r2, r3}
	mov	r3, #8
	mov	r1, #24
	str	r3, [r4, #12]
	bl	BsGet
	str	r0, [r4, #8]
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	Vp6_Vfmw_StartDecode, .-Vp6_Vfmw_StartDecode
	.align	2
	.global	VP6_ArrangeVHBMem
	.type	VP6_ArrangeVHBMem, %function
VP6_ArrangeVHBMem:
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
	add	r4, r0, #12288
	mov	r6, r0
	ldr	r3, [r4, #224]
	ldr	r2, [r4, #228]
	cmp	r3, #2
	bls	.L24
	sub	r0, r2, #3
	movw	r1, #509
	cmp	r3, #512
	cmpls	r0, r1
	bhi	.L24
	ldr	r1, [r6]
	ldr	r0, [r1, #700]
	cmp	r0, #0
	ldr	r0, [r1, #28]
	bne	.L27
	cmp	r0, #25
	beq	.L49
.L28:
	mov	r5, #3
	mov	r7, r2, asl #4
	mov	r8, r3, asl #4
	mov	r9, r5
	mov	r10, #5
.L33:
	ldr	r3, .L50
	mov	r2, #32
	mov	r1, #0
	sub	r0, fp, #76
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r2, [r6]
	str	r8, [fp, #-48]
	mov	r3, #0
	str	r7, [fp, #-68]
	ldr	r2, [r2, #28]
	str	r8, [fp, #-64]
	cmp	r2, #24
	str	r7, [fp, #-52]
	strb	r3, [fp, #-75]
	beq	.L39
	uxtb	r5, r5
	strb	r9, [fp, #-73]
	strb	r10, [fp, #-71]
.L42:
	sub	r1, fp, #76
	ldr	r0, [r4, #728]
	strb	r5, [fp, #-70]
	mov	r5, #0
	strb	r5, [fp, #-74]
	bl	FSP_ConfigInstance
	subs	r7, r0, #0
	bne	.L40
	ldr	r1, [r6]
	sub	r3, fp, #80
	ldr	r0, [r4, #728]
	ldr	r2, [r1, #24]
	ldr	r1, [r1, #20]
	bl	FSP_ConfigFrameBuf
	cmp	r0, r5
	moveq	r0, #1
	streq	r0, [r4, #24]
	beq	.L46
	ldr	r1, .L50+4
	mov	r0, r7
	bl	dprint_vfmw
	mov	r0, r7
	b	.L46
.L24:
	ldr	r1, .L50+8
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #0
.L46:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L27:
	cmp	r0, #25
	bne	.L28
	ldr	r0, [r1, #660]
	mov	r2, r2, asl #4
	ldr	ip, [r1, #664]
	mov	r3, r3, asl #4
	cmp	r2, r0
	bhi	.L36
	cmp	r3, ip
	bhi	.L36
	ldr	r0, [r1, #688]
	mov	r7, r2
	ldr	r2, [r1, #684]
	mov	r8, r3
	cmp	r0, #0
	add	r9, r2, #2
	beq	.L44
	add	r5, r2, #1
	cmp	r5, #17
	movge	r5, #17
.L38:
	ldrb	r10, [r1, #708]
	b	.L33
.L40:
	ldr	r1, .L50+12
	mov	r0, r5
	bl	dprint_vfmw
	mov	r0, r5
	b	.L46
.L39:
	mov	r5, #1
	strb	r10, [fp, #-71]
	strb	r5, [fp, #-73]
	b	.L42
.L49:
	ldr	r7, [r1, #660]
	mov	r2, r2, asl #4
	ldr	r8, [r1, #664]
	mov	r3, r3, asl #4
	cmp	r2, r7
	bhi	.L30
	cmp	r3, r8
	bhi	.L30
	ldr	r0, [r4, #24]
	cmp	r0, #1
	beq	.L46
	ldr	r2, [r1, #688]
	ldr	r3, [r1, #684]
	cmp	r2, #0
	add	r9, r3, #2
	beq	.L44
	add	r5, r3, #1
	cmp	r5, #17
	movge	r5, #17
	b	.L38
.L36:
	stmia	sp, {r0, ip}
	mov	r0, #0
	ldr	r1, .L50+16
	bl	dprint_vfmw
	mov	r0, #0
	b	.L46
.L44:
	mov	r5, #1
	b	.L38
.L30:
	stmia	sp, {r7, r8}
	mov	r0, #0
	ldr	r1, .L50+16
	bl	dprint_vfmw
	mov	r0, #0
	b	.L46
.L51:
	.align	2
.L50:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC2
	.word	.LC0
	.word	.LC3
	.word	.LC1
	.fnend
	.size	VP6_ArrangeVHBMem, .-VP6_ArrangeVHBMem
	.align	2
	.global	VP6_GetImageBuffer
	.type	VP6_GetImageBuffer, %function
VP6_GetImageBuffer:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #12
	sub	sp, sp, #12
	push	{lr}
	bl	__gnu_mcount_nc
	add	r4, r0, #12288
	mov	r6, r0
	mov	r1, #1
	ldr	r0, [r4, #728]
	bl	FSP_NewLogicFs
	cmp	r0, #0
	str	r0, [r4, #36]
	blt	.L59
	mov	r1, r0
	ldr	r0, [r4, #728]
	bl	FSP_GetLogicFs
	subs	r5, r0, #0
	beq	.L60
	ldr	r2, [r4, #36]
	mov	r0, #18
	ldr	r1, .L61
	bl	dprint_vfmw
	ldr	r3, [r5, #608]
	cmp	r3, #0
	beq	.L58
	ldr	r0, [r5, #612]
	cmp	r0, #0
	beq	.L54
	ldr	r3, [r5, #616]
	cmp	r3, #0
	beq	.L58
	ldr	r3, [r0, #32]
	add	r2, r5, #608
	mov	r0, #18
	ldr	r1, .L61+4
	str	r3, [r4, #52]
	ldmia	r2, {r2, r3, ip}
	ldr	ip, [ip, #16]
	ldr	r3, [r3, #16]
	ldr	r2, [r2, #16]
	str	ip, [sp]
	bl	dprint_vfmw
	mov	r0, #1
.L54:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L58:
	mov	r0, r3
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L59:
	ldr	r1, .L61+8
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r1, [r4, #40]
	ldr	r0, [r4, #728]
	mov	r2, #1
	bl	FSP_ClearLogicFs
	mov	r2, #1
	ldr	r1, [r4, #44]
	mov	r5, #0
	ldr	r0, [r4, #728]
	bl	FSP_ClearLogicFs
	str	r5, [r4, #40]
	str	r5, [r4, #44]
	ldr	r0, [r4, #728]
	bl	FSP_GetNullLogicFs
	add	r1, r6, #12608
	str	r5, [r4, #20]
	add	r1, r1, #56
	str	r0, [r4, #44]
	str	r0, [r4, #40]
	ldr	r0, [r4, #728]
	bl	FSP_ClearNotInVoQueue
	mov	r0, r5
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L60:
	movw	r2, #682
	ldr	r1, .L61+12
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r5
	b	.L54
.L62:
	.align	2
.L61:
	.word	.LC6
	.word	.LC7
	.word	.LC4
	.word	.LC5
	.fnend
	.size	VP6_GetImageBuffer, .-VP6_GetImageBuffer
	.align	2
	.global	VP6DEC_GetImageBuffer
	.type	VP6DEC_GetImageBuffer, %function
VP6DEC_GetImageBuffer:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	push	{lr}
	bl	__gnu_mcount_nc
	add	r4, r0, #12288
	mov	r5, r0
	ldr	r0, [r4, #728]
	bl	FSP_IsNewFsAvalible
	cmp	r0, #1
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r0, [r4, #728]
	bl	FSP_IsNewFsAvalible
	cmn	r0, #1
	beq	.L69
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L69:
	add	r1, r5, #12608
	ldr	r0, [r4, #728]
	add	r1, r1, #56
	bl	FSP_ClearNotInVoQueue
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	VP6DEC_GetImageBuffer, .-VP6DEC_GetImageBuffer
	.align	2
	.global	VP6_BuildScanOrder
	.type	VP6_BuildScanOrder, %function
VP6_BuildScanOrder:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	push	{lr}
	bl	__gnu_mcount_nc
	add	r5, r0, #1088
	mov	r4, #1
	mov	lr, #0
	strb	lr, [r0, #960]
.L71:
	mov	r2, r5
	mov	r3, #1
.L73:
	ldrb	ip, [r2, #1]!
	cmp	ip, lr
	addeq	ip, r0, r4
	addeq	r4, r4, #1
	streqb	r3, [ip, #960]
	add	r3, r3, #1
	cmp	r3, #64
	bne	.L73
	add	lr, lr, #1
	cmp	lr, #16
	bne	.L71
	add	r5, r0, #1020
	add	r4, r0, #956
	add	r5, r5, #3
	add	r4, r4, #3
	mov	lr, #0
.L74:
	mov	r3, #0
	mov	ip, r4
	mov	r2, r3
.L75:
	ldrb	r0, [ip, #1]!
	add	r2, r2, #1
	cmp	r3, r0
	movcc	r3, r0
	cmp	r2, lr
	bls	.L75
	uxtb	r3, r3
	strb	r3, [r5, #1]!
	ldr	r2, [r1, #12]
	add	lr, lr, #1
	cmp	r2, #6
	addhi	r3, r3, #1
	strhib	r3, [r5]
	cmp	lr, #64
	bne	.L74
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	VP6_BuildScanOrder, .-VP6_BuildScanOrder
	.global	__aeabi_idiv
	.global	__aeabi_uidiv
	.align	2
	.global	VP6_BuildModeTree
	.type	VP6_BuildModeTree, %function
VP6_BuildModeTree:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #100
	sub	sp, sp, #100
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r9, #0
	mov	r10, #100
	mov	r7, r9
	add	r2, r0, #404
	add	r3, r0, #464
	str	r0, [fp, #-128]
	str	r0, [fp, #-132]
	str	r2, [fp, #-140]
	str	r3, [fp, #-136]
.L82:
	ldr	r3, [fp, #-128]
	ldr	r8, [fp, #-140]
	ldr	r9, [fp, #-132]
	str	r3, [fp, #-92]
	str	r3, [fp, #-88]
.L88:
	mov	r4, #0
	sub	r1, fp, #84
	mov	r2, r4
	mov	r0, r8
.L85:
	cmp	r7, r2
	add	r2, r2, #1
	subeq	r3, fp, #84
	add	r1, r1, #4
	ldrneb	r3, [r0]
	moveq	ip, #0
	streq	ip, [r3, r7, asl #2]
	add	r0, r0, #1
	ldreq	r3, [r1, #-4]
	smulbbne	r3, r3, r10
	add	r4, r4, r3
	strne	r3, [r1, #-4]
	cmp	r2, #10
	bne	.L85
	ldr	r2, [fp, #-88]
	add	r8, r8, #20
	add	r9, r9, #90
	add	r2, r2, #20
	ldrb	r0, [r2, #394]
	ldrb	r3, [r2, #384]
	add	r1, r0, #1
	str	r2, [fp, #-88]
	add	r1, r1, r3
	rsb	r0, r0, r0, lsl #8
	bl	__aeabi_idiv
	ldr	r3, [fp, #-72]
	ldr	r2, [fp, #-84]
	add	r1, r4, #1
	ldr	r6, [fp, #-76]
	mov	ip, r3
	ldr	r3, [fp, #-68]
	add	r6, r2, r6
	ldr	lr, [fp, #-92]
	str	ip, [fp, #-96]
	add	ip, ip, r3
	add	r4, ip, r6
	str	r2, [fp, #-124]
	add	lr, lr, #10
	str	ip, [fp, #-104]
	mvn	r3, r0
	rsb	r0, r4, r4, lsl #8
	strb	r3, [lr, #-6]
	str	lr, [fp, #-92]
	bl	__aeabi_uidiv
	add	r1, r4, #1
	add	r3, r0, #1
	rsb	r0, r6, r6, lsl #8
	strb	r3, [r9, #-46]
	bl	__aeabi_uidiv
	ldr	lr, [fp, #-64]
	ldr	r3, [fp, #-80]
	ldr	r1, [fp, #-52]
	ldr	r5, [fp, #-56]
	ldr	ip, [fp, #-48]
	ldr	r4, [fp, #-60]
	add	r5, r3, r5
	add	ip, r1, ip
	str	r3, [fp, #-120]
	add	r4, lr, r4
	add	r3, ip, #1
	str	r1, [fp, #-108]
	add	r1, ip, r5
	add	ip, r4, #1
	str	r3, [fp, #-112]
	add	r1, r1, ip
	str	ip, [fp, #-116]
	str	lr, [fp, #-100]
	add	r0, r0, #1
	strb	r0, [r9, #-45]
	rsb	r0, r5, r5, lsl #8
	bl	__aeabi_uidiv
	ldr	r2, [fp, #-124]
	add	r1, r6, #1
	add	lr, r0, #1
	rsb	r0, r2, r2, lsl #8
	strb	lr, [r9, #-44]
	bl	__aeabi_uidiv
	ldr	r3, [fp, #-96]
	ldr	ip, [fp, #-104]
	add	r1, ip, #1
	add	r2, r0, #1
	rsb	r0, r3, r3, lsl #8
	strb	r2, [r9, #-43]
	bl	__aeabi_uidiv
	ldr	r3, [fp, #-120]
	add	r1, r5, #1
	add	r2, r0, #1
	rsb	r0, r3, r3, lsl #8
	strb	r2, [r9, #-42]
	bl	__aeabi_uidiv
	ldr	r5, [fp, #-112]
	add	r1, r5, r4
	add	r3, r0, #1
	rsb	r0, r4, r4, lsl #8
	strb	r3, [r9, #-41]
	bl	__aeabi_uidiv
	ldr	ip, [fp, #-116]
	ldr	lr, [fp, #-100]
	mov	r1, ip
	add	r3, r0, #1
	rsb	r0, lr, lr, lsl #8
	strb	r3, [r9, #-40]
	bl	__aeabi_uidiv
	ldr	r2, [fp, #-108]
	mov	r1, r5
	add	r3, r0, #1
	rsb	r0, r2, r2, lsl #8
	strb	r3, [r9, #-39]
	bl	__aeabi_uidiv
	ldr	r3, [fp, #-136]
	cmp	r8, r3
	add	r0, r0, #1
	strb	r0, [r9, #-38]
	bne	.L88
	ldr	r3, [fp, #-128]
	add	r7, r7, #1
	cmp	r7, #10
	add	r3, r3, #1
	str	r3, [fp, #-128]
	ldr	r3, [fp, #-132]
	add	r3, r3, #9
	str	r3, [fp, #-132]
	bne	.L82
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	.fnend
	.size	VP6_BuildModeTree, .-VP6_BuildModeTree
	.align	2
	.global	VP6_ConfigureContexts
	.type	VP6_ConfigureContexts, %function
VP6_ConfigureContexts:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r3, r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	push	{lr}
	bl	__gnu_mcount_nc
	add	r7, r0, #1184
	add	lr, r0, #516
	add	r7, r7, #5
	add	lr, lr, #2
	add	r0, r0, #540
.L91:
	ldr	r6, .L99
	sub	r5, r7, #33
	add	r4, lr, #6
	sub	r8, lr, #5
.L96:
	sub	ip, r5, #5
	mov	r1, r8
	mov	r2, r6
.L92:
	ldmia	r2, {r3, r9}
	add	r2, r2, #24
	ldrb	r10, [r1, #1]!
	mul	r3, r3, r10
	add	r3, r3, #128
	add	r3, r9, r3, asr #8
	cmp	r3, #255
	movge	r3, #255
	cmp	r3, #1
	movlt	r3, #1
	cmp	r1, lr
	strb	r3, [ip, #1]!
	bne	.L92
	mov	r2, r5
	mov	r3, lr
.L93:
	ldrb	r1, [r3, #1]!
	cmp	r4, r3
	strb	r1, [r2, #1]!
	bne	.L93
	add	r5, r5, #11
	add	r6, r6, #8
	cmp	r7, r5
	bne	.L96
	add	lr, lr, #11
	add	r7, r7, #33
	cmp	lr, r0
	bne	.L91
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L100:
	.align	2
.L99:
	.word	.LANCHOR0
	.fnend
	.size	VP6_ConfigureContexts, .-VP6_ConfigureContexts
	.align	2
	.global	VP6_ConfigureEntropyDecoder
	.type	VP6_ConfigureEntropyDecoder, %function
VP6_ConfigureEntropyDecoder:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #60
	sub	sp, sp, #60
	push	{lr}
	bl	__gnu_mcount_nc
	mov	lr, r2
	str	r2, [fp, #-100]
	ldr	r2, .L149
	mov	r9, r1
	str	r0, [fp, #-72]
	mov	r1, #128
	sub	r0, fp, #55
	str	r3, [fp, #-64]
	ldr	ip, [r2, #48]
	mov	r2, #11
	add	r8, lr, #72
	blx	ip
	mov	r3, #0
	str	r3, [fp, #-68]
.L102:
	ldr	r3, [fp, #-68]
	mov	r4, #0
	add	r5, r3, #512
	sub	r6, r3, #1
	ldr	r3, .L149+4
	add	r5, r5, #2
	add	r6, r3, r6
	ldr	r3, [fp, #-72]
	add	r5, r3, r5
.L106:
	ldrb	r2, [r6, #1]!
	mov	r1, r8
	mov	r0, r9
	bl	Vp6_Vfmw_DecodeBool
	cmp	r0, #0
	beq	.L103
	mov	r10, #0
	mov	r7, #6
.L104:
	mov	r1, r8
	mov	r0, r9
	bl	Vp6_Vfmw_DecodeBool128
	orr	r10, r10, r0, asl r7
	subs	r7, r7, #1
	bcs	.L104
	mov	r3, r10, asl #1
	ands	r3, r3, #255
	moveq	r2, #1
	movne	r2, #0
	add	r3, r3, r2
	sub	r2, fp, #55
	uxtb	r3, r3
	strb	r3, [r2, r4]
	strb	r3, [r5]
.L105:
	add	r4, r4, #1
	add	r5, r5, #1
	cmp	r4, #11
	bne	.L106
	ldr	r3, [fp, #-68]
	add	r3, r3, #11
	str	r3, [fp, #-68]
	cmp	r3, #22
	bne	.L102
	ldr	r3, [fp, #-64]
	cmp	r3, #0
	bne	.L108
	ldr	r3, .L149
	mov	r2, #28
	ldr	r0, [fp, #-72]
	ldr	r1, .L149+8
	ldr	r3, [r3, #52]
	add	r0, r0, #536
	blx	r3
.L108:
	mov	r1, r8
	mov	r0, r9
	bl	Vp6_Vfmw_DecodeBool128
	cmp	r0, #0
	beq	.L112
	ldr	r3, [fp, #-72]
	ldr	r4, .L149+12
	add	r5, r3, #1088
	add	r5, r5, #1
	add	r6, r4, #63
.L111:
	ldrb	r2, [r4, #1]!
	mov	r1, r8
	mov	r0, r9
	bl	Vp6_Vfmw_DecodeBool
	cmp	r0, #0
	beq	.L109
	mov	r10, #0
	mov	r7, #3
.L110:
	mov	r1, r8
	mov	r0, r9
	bl	Vp6_Vfmw_DecodeBool128
	orr	r10, r10, r0, asl r7
	subs	r7, r7, #1
	bcs	.L110
	strb	r10, [r5]
.L109:
	cmp	r4, r6
	add	r5, r5, #1
	bne	.L111
	ldr	r1, [fp, #-100]
	ldr	r0, [fp, #-72]
	bl	VP6_BuildScanOrder
.L112:
	mov	r3, #0
	str	r3, [fp, #-68]
.L116:
	ldr	r3, [fp, #-68]
	sub	r5, r3, #1
	add	r6, r3, #536
	add	r7, r3, #13
	ldr	r3, .L149+16
	add	r5, r3, r5
	ldr	r3, [fp, #-72]
	add	r6, r3, r6
	ldr	r3, .L149+16
	add	r7, r3, r7
.L115:
	ldrb	r2, [r5, #1]!
	mov	r1, r8
	mov	r0, r9
	bl	Vp6_Vfmw_DecodeBool
	cmp	r0, #0
	beq	.L113
	mov	r10, #0
	mov	r4, #6
.L114:
	mov	r1, r8
	mov	r0, r9
	bl	Vp6_Vfmw_DecodeBool128
	orr	r10, r10, r0, asl r4
	subs	r4, r4, #1
	bcs	.L114
	mov	r10, r10, asl #1
	ands	r10, r10, #255
	moveq	r3, #1
	movne	r3, #0
	add	r3, r10, r3
	strb	r3, [r6]
.L113:
	cmp	r5, r7
	add	r6, r6, #1
	bne	.L115
	ldr	r3, [fp, #-68]
	add	r3, r3, #14
	str	r3, [fp, #-68]
	cmp	r3, #28
	bne	.L116
	mov	r3, #0
	str	r3, [fp, #-96]
.L125:
	ldr	r3, [fp, #-96]
	add	r2, r3, #396
	str	r2, [fp, #-92]
	str	r3, [fp, #-88]
	str	r3, [fp, #-84]
.L127:
	ldr	r3, [fp, #-84]
	add	r2, r3, #66
	str	r2, [fp, #-76]
	str	r3, [fp, #-68]
	ldr	r3, [fp, #-88]
	sub	r3, r3, #1
	str	r3, [fp, #-80]
.L124:
	ldr	r3, [fp, #-68]
	mov	r4, #0
	ldr	r2, [fp, #-80]
	add	r5, r3, #564
	add	r6, r2, r3
	ldr	r3, .L149+20
	add	r6, r3, r6
	ldr	r3, [fp, #-72]
	add	r5, r3, r5
.L121:
	ldrb	r2, [r6, #1]!
	mov	r1, r8
	mov	r0, r9
	bl	Vp6_Vfmw_DecodeBool
	cmp	r0, #0
	beq	.L118
	mov	r10, #0
	mov	r7, #6
.L119:
	mov	r1, r8
	mov	r0, r9
	bl	Vp6_Vfmw_DecodeBool128
	orr	r10, r10, r0, asl r7
	subs	r7, r7, #1
	bcs	.L119
	mov	r3, r10, asl #1
	ands	r3, r3, #255
	moveq	r2, #1
	movne	r2, #0
	add	r3, r3, r2
	sub	r2, fp, #55
	uxtb	r3, r3
	strb	r3, [r2, r4]
	strb	r3, [r5]
.L120:
	add	r4, r4, #1
	add	r5, r5, #1
	cmp	r4, #11
	bne	.L121
	ldr	r3, [fp, #-68]
	ldr	r2, [fp, #-76]
	add	r3, r3, #11
	str	r3, [fp, #-68]
	cmp	r3, r2
	bne	.L124
	ldr	r2, [fp, #-88]
	ldr	r3, [fp, #-84]
	sub	r2, r2, #132
	str	r2, [fp, #-88]
	ldr	r2, [fp, #-92]
	add	r3, r3, #198
	str	r3, [fp, #-84]
	cmp	r3, r2
	bne	.L127
	ldr	r3, [fp, #-96]
	add	r3, r3, #66
	str	r3, [fp, #-96]
	cmp	r3, #198
	bne	.L125
	ldr	r1, [fp, #-100]
	ldr	r0, [fp, #-72]
	bl	VP6_ConfigureContexts
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L118:
	ldr	r3, [fp, #-64]
	cmp	r3, #0
	subeq	r3, fp, #55
	ldreqb	r3, [r3, r4]
	streqb	r3, [r5]
	b	.L120
.L103:
	ldr	r3, [fp, #-64]
	cmp	r3, #0
	subeq	r3, fp, #55
	ldreqb	r3, [r3, r4]
	streqb	r3, [r5]
	b	.L105
.L150:
	.align	2
.L149:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0+120
	.word	.LANCHOR0+144
	.word	.LANCHOR0+596
	.word	.LANCHOR0+172
	.word	.LANCHOR0+200
	.fnend
	.size	VP6_ConfigureEntropyDecoder, .-VP6_ConfigureEntropyDecoder
	.align	2
	.global	VP6_decodeModeDiff
	.type	VP6_decodeModeDiff, %function
VP6_decodeModeDiff:
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
	add	r5, r1, #72
	mov	r2, #205
	mov	r7, r0
	mov	r1, r5
	bl	Vp6_Vfmw_DecodeBool
	cmp	r0, #0
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	mov	r1, r5
	mov	r0, r7
	bl	Vp6_Vfmw_DecodeBool128
	mov	r2, #171
	mov	r1, r5
	mov	r6, r0, asl #1
	mov	r0, r7
	bl	Vp6_Vfmw_DecodeBool
	rsb	r6, r6, #1
	cmp	r0, #0
	beq	.L161
	mov	r2, #199
	mov	r1, r5
	mov	r0, r7
	bl	Vp6_Vfmw_DecodeBool
	cmp	r0, #0
	movne	r8, #0
	movne	r4, #6
	beq	.L162
.L158:
	mov	r1, r5
	mov	r0, r7
	bl	Vp6_Vfmw_DecodeBool128
	orr	r8, r8, r0, asl r4
	subs	r4, r4, #1
	bcs	.L158
	mul	r0, r8, r6
	mov	r0, r0, asl #2
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L162:
	mov	r2, #140
	mov	r1, r5
	mov	r0, r7
	bl	Vp6_Vfmw_DecodeBool
	cmp	r0, #0
	beq	.L155
	mov	r0, r6, asl #4
	sub	r0, r0, r6, asl #2
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L161:
	mov	r1, r5
	mov	r0, r7
	mov	r2, #83
	bl	Vp6_Vfmw_DecodeBool
	rsb	r0, r0, #3
	mov	r0, r6, asl r0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L155:
	mov	r2, #125
	mov	r1, r5
	mov	r0, r7
	bl	Vp6_Vfmw_DecodeBool
	cmp	r0, #0
	beq	.L156
	mov	r0, r6, asl #4
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L156:
	mov	r1, r5
	mov	r0, r7
	mov	r2, #104
	bl	Vp6_Vfmw_DecodeBool
	cmp	r0, #0
	movne	r0, r6, asl #4
	addne	r0, r0, r6, lsl #2
	moveq	r0, r6, asl #5
	subeq	r0, r0, r6, asl #3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	VP6_decodeModeDiff, .-VP6_decodeModeDiff
	.align	2
	.global	VP6_DecodeModeProbs
	.type	VP6_DecodeModeProbs, %function
VP6_DecodeModeProbs:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #12
	sub	sp, sp, #12
	push	{lr}
	bl	__gnu_mcount_nc
	add	r9, r0, #412
	add	r7, r2, #72
	add	r9, r9, #1
	mov	r6, r2
	mov	r5, r1
	mov	r8, #0
	str	r0, [fp, #-48]
.L170:
	mov	r2, #174
	mov	r1, r7
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool
	cmp	r0, #0
	beq	.L164
	mov	r10, #0
	mov	r4, #3
.L165:
	mov	r1, r7
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool128
	orr	r10, r10, r0, asl r4
	subs	r4, r4, #1
	bcs	.L165
	mov	r3, r10, asl #4
	add	r0, r8, #20
	add	r1, r3, r10, lsl #2
	mov	r2, r9
	add	r3, r8, r1
	add	r0, r1, r0
	ldr	r1, .L185
	add	r3, r1, r3
	add	r0, r1, r0
.L166:
	ldrb	r1, [r3]
	add	r3, r3, #2
	strb	r1, [r2, #1]!
	ldrb	r1, [r3, #-1]
	cmp	r3, r0
	strb	r1, [r2, #-10]
	bne	.L166
.L164:
	mov	r2, #254
	mov	r1, r7
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool
	cmp	r0, #0
	beq	.L171
	sub	r10, r9, #412
	mov	r4, #0
	sub	r10, r10, #1
.L169:
	mov	r1, r6
	mov	r0, r5
	bl	VP6_decodeModeDiff
	ldrb	r3, [r10, #414]
	adds	r0, r3, r0
	movmi	r0, #0
	bmi	.L167
	cmp	r0, #255
	movge	r0, #255
	uxtb	r0, r0
.L167:
	strb	r0, [r10, #414]
	mov	r1, r6
	mov	r0, r5
	bl	VP6_decodeModeDiff
	ldrb	r3, [r10, #404]
	adds	r0, r3, r0
	movmi	r0, #0
	bmi	.L168
	cmp	r0, #255
	movge	r0, #255
	uxtb	r0, r0
.L168:
	add	r4, r4, #1
	strb	r0, [r10, #404]
	cmp	r4, #10
	add	r10, r10, #1
	bne	.L169
.L171:
	add	r8, r8, #320
	add	r9, r9, #20
	cmp	r8, #960
	bne	.L170
	mov	r1, r6
	ldr	r0, [fp, #-48]
	bl	VP6_BuildModeTree
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L186:
	.align	2
.L185:
	.word	.LANCHOR0+660
	.fnend
	.size	VP6_DecodeModeProbs, .-VP6_DecodeModeProbs
	.align	2
	.global	VP6_ConfigureMvEntropyDecoder
	.type	VP6_ConfigureMvEntropyDecoder, %function
VP6_ConfigureMvEntropyDecoder:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #12
	sub	sp, sp, #12
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r3, .L226
	add	r4, r2, #72
	mov	r5, r1
	mov	r7, r0
	add	r8, r3, #34
	str	r0, [fp, #-52]
	mov	r6, r3
.L195:
	ldrb	r2, [r6]
	mov	r1, r4
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool
	cmp	r0, #0
	beq	.L191
	mov	r10, #0
	mov	r9, #6
.L189:
	mov	r1, r4
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool128
	orr	r10, r10, r0, asl r9
	subs	r9, r9, #1
	bcs	.L189
	mov	r3, r10, asl #1
	ands	r3, r3, #255
	moveq	r3, #1
	strb	r3, [r7, #2]
.L191:
	ldrb	r2, [r6, #1]
	mov	r1, r4
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool
	cmp	r0, #0
	beq	.L194
	mov	r10, #0
	mov	r9, #6
.L192:
	mov	r1, r4
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool128
	orr	r10, r10, r0, asl r9
	subs	r9, r9, #1
	bcs	.L192
	mov	r3, r10, asl #1
	ands	r3, r3, #255
	moveq	r3, #1
	strb	r3, [r7]
.L194:
	add	r6, r6, #17
	add	r7, r7, #1
	cmp	r6, r8
	bne	.L195
	ldr	r3, [fp, #-52]
	add	r8, r3, #488
	mov	r3, #0
	add	r8, r8, #3
	str	r3, [fp, #-48]
.L196:
	ldr	r3, [fp, #-48]
	sub	r6, r8, #7
	add	r7, r3, #1
	ldr	r3, .L226
	add	r7, r3, r7
.L202:
	ldrb	r2, [r7, #1]!
	mov	r1, r4
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool
	cmp	r0, #0
	beq	.L198
	mov	r10, #0
	mov	r9, #6
.L199:
	mov	r1, r4
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool128
	orr	r10, r10, r0, asl r9
	subs	r9, r9, #1
	bcs	.L199
	mov	r2, r10, asl #1
	ands	r2, r2, #255
	strneb	r2, [r6]
	moveq	r3, #1
	streqb	r3, [r6]
.L198:
	add	r6, r6, #1
	cmp	r8, r6
	bne	.L202
	ldr	r3, [fp, #-48]
	add	r8, r8, #7
	add	r3, r3, #17
	str	r3, [fp, #-48]
	cmp	r3, #34
	bne	.L196
	ldr	r3, [fp, #-52]
	add	r8, r3, #504
	mov	r3, #0
	add	r8, r8, #2
	str	r3, [fp, #-48]
.L203:
	ldr	r3, [fp, #-48]
	sub	r6, r8, #8
	add	r7, r3, #8
	ldr	r3, .L226
	add	r7, r3, r7
.L209:
	ldrb	r2, [r7, #1]!
	mov	r1, r4
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool
	cmp	r0, #0
	beq	.L205
	mov	r10, #0
	mov	r9, #6
.L206:
	mov	r1, r4
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool128
	orr	r10, r10, r0, asl r9
	subs	r9, r9, #1
	bcs	.L206
	mov	r2, r10, asl #1
	ands	r2, r2, #255
	strneb	r2, [r6]
	moveq	r3, #1
	streqb	r3, [r6]
.L205:
	add	r6, r6, #1
	cmp	r8, r6
	bne	.L209
	ldr	r3, [fp, #-48]
	add	r8, r8, #8
	add	r3, r3, #17
	str	r3, [fp, #-48]
	cmp	r3, #34
	bne	.L203
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L227:
	.align	2
.L226:
	.word	.LANCHOR0+1620
	.fnend
	.size	VP6_ConfigureMvEntropyDecoder, .-VP6_ConfigureMvEntropyDecoder
	.align	2
	.global	VP6_BoolTreeToHuffCodes
	.type	VP6_BoolTreeToHuffCodes, %function
VP6_BoolTreeToHuffCodes:
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
	ldrb	r2, [r0, #1]
	ldrb	r3, [r0]
	smulbb	r3, r2, r3
	mov	r3, r3, lsr #8
	str	r3, [r1, #44]
	ldrb	r3, [r0, #1]
	ldrb	r2, [r0]
	rsb	r3, r3, #255
	mul	r3, r2, r3
	mov	r3, r3, lsr #8
	str	r3, [r1]
	ldrb	ip, [r0]
	ldrb	r3, [r0, #2]
	rsb	ip, ip, #255
	mul	r3, r3, ip
	mov	r3, r3, lsr #8
	str	r3, [r1, #4]
	ldrb	r3, [r0, #2]
	ldrb	r2, [r0, #3]
	rsb	r3, r3, #255
	ldrb	lr, [r0, #4]
	mul	r3, ip, r3
	mov	r3, r3, lsr #8
	mul	r2, r2, r3
	mov	ip, r2, lsr #8
	mul	r2, lr, ip
	mov	r2, r2, lsr #8
	str	r2, [r1, #8]
	ldrb	r2, [r0, #4]
	ldrb	lr, [r0, #5]
	rsb	r2, r2, #255
	mul	r2, r2, ip
	mov	r2, r2, lsr #8
	mul	ip, lr, r2
	mov	ip, ip, lsr #8
	str	ip, [r1, #12]
	ldrb	ip, [r0, #5]
	rsb	ip, ip, #255
	mul	r2, ip, r2
	mov	r2, r2, lsr #8
	str	r2, [r1, #16]
	ldrb	ip, [r0, #3]
	ldrb	r2, [r0, #6]
	rsb	ip, ip, #255
	ldrb	lr, [r0, #7]
	mul	r3, ip, r3
	mov	r3, r3, lsr #8
	mul	r2, r2, r3
	mov	ip, r2, lsr #8
	mul	r2, lr, ip
	mov	r2, r2, lsr #8
	str	r2, [r1, #20]
	ldrb	r2, [r0, #7]
	rsb	r2, r2, #255
	mul	r2, r2, ip
	mov	r2, r2, lsr #8
	str	r2, [r1, #24]
	ldrb	ip, [r0, #6]
	ldrb	r2, [r0, #8]
	rsb	ip, ip, #255
	ldrb	lr, [r0, #9]
	mul	r3, ip, r3
	mov	r3, r3, lsr #8
	mul	r2, r2, r3
	mov	ip, r2, lsr #8
	mul	r2, lr, ip
	mov	r2, r2, lsr #8
	str	r2, [r1, #28]
	ldrb	r2, [r0, #9]
	rsb	r2, r2, #255
	mul	r2, r2, ip
	mov	r2, r2, lsr #8
	str	r2, [r1, #32]
	ldrb	r2, [r0, #8]
	ldrb	ip, [r0, #10]
	rsb	r2, r2, #255
	mul	r3, r2, r3
	mov	r3, r3, lsr #8
	mul	r2, ip, r3
	mov	r2, r2, lsr #8
	str	r2, [r1, #36]
	ldrb	r2, [r0, #10]
	rsb	r2, r2, #255
	mul	r3, r2, r3
	mov	r3, r3, lsr #8
	str	r3, [r1, #40]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VP6_BoolTreeToHuffCodes, .-VP6_BoolTreeToHuffCodes
	.align	2
	.global	VP6_ZerosBoolTreeToHuffCodes
	.type	VP6_ZerosBoolTreeToHuffCodes, %function
VP6_ZerosBoolTreeToHuffCodes:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	push	{lr}
	bl	__gnu_mcount_nc
	ldrb	ip, [r0, #1]
	ldrb	r3, [r0]
	ldrb	r2, [r0, #2]
	smulbb	r3, ip, r3
	mov	r3, r3, lsr #8
	mul	r2, r2, r3
	mov	r2, r2, lsr #8
	str	r2, [r1]
	ldrb	r2, [r0, #2]
	rsb	r2, r2, #255
	mul	r3, r3, r2
	mov	r3, r3, lsr #8
	str	r3, [r1, #4]
	ldrb	r3, [r0, #1]
	ldrb	ip, [r0]
	rsb	r3, r3, #255
	ldrb	lr, [r0, #3]
	mul	r3, ip, r3
	mov	r2, r3, lsr #8
	mul	r3, lr, r2
	mov	r3, r3, lsr #8
	str	r3, [r1, #8]
	ldrb	r3, [r0, #3]
	rsb	r3, r3, #255
	mul	r3, r3, r2
	mov	r3, r3, lsr #8
	str	r3, [r1, #12]
	ldrb	r3, [r0]
	ldrb	r4, [r0, #4]
	rsb	r3, r3, #255
	ldrb	ip, [r0, #5]
	ldrb	lr, [r0, #6]
	mul	r3, r4, r3
	mov	r3, r3, lsr #8
	mul	r3, ip, r3
	mov	r2, r3, lsr #8
	mul	r3, lr, r2
	mov	r3, r3, lsr #8
	str	r3, [r1, #16]
	ldrb	r3, [r0, #6]
	rsb	r3, r3, #255
	mul	r3, r3, r2
	mov	r3, r3, lsr #8
	str	r3, [r1, #20]
	ldrb	r3, [r0]
	ldrb	lr, [r0, #4]
	rsb	r3, r3, #255
	ldrb	r2, [r0, #5]
	ldrb	ip, [r0, #7]
	mul	r3, lr, r3
	rsb	r2, r2, #255
	mov	r3, r3, lsr #8
	mul	r3, r2, r3
	mov	r3, r3, lsr #8
	mul	r2, ip, r3
	mov	r2, r2, lsr #8
	str	r2, [r1, #24]
	ldrb	r2, [r0, #7]
	rsb	r2, r2, #255
	mul	r3, r2, r3
	mov	r3, r3, lsr #8
	str	r3, [r1, #28]
	ldrb	r3, [r0, #4]
	ldrb	r2, [r0]
	rsb	r0, r3, #255
	rsb	r3, r2, #255
	mul	r3, r3, r0
	mov	r3, r3, lsr #8
	str	r3, [r1, #32]
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	VP6_ZerosBoolTreeToHuffCodes, .-VP6_ZerosBoolTreeToHuffCodes
	.align	2
	.global	VP6_InsertSorted
	.type	VP6_InsertSorted, %function
VP6_InsertSorted:
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
	ldr	r5, [r2]
	mov	r7, r1, asl #4
	cmn	r5, #1
	beq	.L231
	mov	r3, r5, asl #4
	sub	r7, r7, r1, asl #2
	sub	r3, r3, r5, asl #2
	add	r7, r0, r7
	add	r3, r0, r3
	ldr	r6, [r7, #8]
	ldr	ip, [r3, #8]
	cmp	r6, ip
	bls	.L232
	mov	r4, r5
	b	.L234
.L242:
	add	r3, r0, r3
	ldr	lr, [r3, #8]
	cmp	lr, r6
	bcs	.L241
	mov	r4, ip
.L234:
	ldr	ip, [r3, #4]
	cmn	ip, #1
	mov	r3, ip, asl #4
	sub	r3, r3, ip, asl #2
	bne	.L242
.L233:
	mov	r3, r4, asl #4
	sub	r4, r3, r4, asl #2
	add	r0, r0, r4
	str	r1, [r0, #4]
	str	ip, [r7, #4]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L241:
	cmp	r5, ip
	bne	.L233
.L236:
	str	r1, [r2]
	str	ip, [r7, #4]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L231:
	sub	r7, r7, r1, asl #2
	add	r7, r0, r7
.L232:
	mov	ip, r5
	b	.L236
	.fnend
	.size	VP6_InsertSorted, .-VP6_InsertSorted
	.align	2
	.global	VP6_BuildHuffTree
	.type	VP6_BuildHuffTree, %function
VP6_BuildHuffTree:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #380
	sub	sp, sp, #380
	push	{lr}
	bl	__gnu_mcount_nc
	subs	r10, r2, #0
	mov	r9, r0
	mov	r0, #0
	str	r0, [fp, #-408]
	beq	.L248
	sub	r6, fp, #404
	sub	r1, r1, #4
	mov	r5, #1
	mvn	r4, #0
	mov	ip, r6
.L247:
	mov	r2, r0, asl #4
	sub	r3, fp, #44
	sub	r2, r2, r0, asl #2
	ldr	lr, [r1, #4]!
	add	r2, r3, r2
	cmp	lr, #0
	ldrb	r3, [r2, #-360]
	moveq	lr, #1
	streq	r5, [r1]
	orr	r3, r3, #1
	bfi	r3, r0, #1, #4
	add	r0, r0, #1
	cmp	r0, r10
	bfc	r3, #5, #3
	strb	r3, [r2, #-360]
	stmib	ip, {r4, lr}
	add	ip, ip, #12
	bne	.L247
	cmp	r10, #1
	bls	.L248
	sub	r7, fp, #408
	mov	r4, #1
.L249:
	mov	r1, r4
	mov	r2, r7
	mov	r0, r6
	add	r4, r4, #1
	bl	VP6_InsertSorted
	cmp	r4, r10
	bne	.L249
	ldr	r1, [fp, #-408]
.L245:
	mov	r2, r1, asl #2
	mov	r1, r1, asl #4
	rsb	r3, r2, r1
	sub	r0, fp, #44
	add	r3, r0, r3
	ldr	r3, [r3, #-356]
	cmn	r3, #1
	beq	.L243
	mov	r5, r10, asl #4
	sub	r8, r10, #2
	sub	r6, fp, #404
	sub	r5, r5, r10, asl #2
	add	r8, r8, r10
	add	r9, r9, r10, lsl #1
	and	r8, r8, #15
	add	r5, r6, r5
	sub	r7, fp, #408
	mov	r4, r10
	str	r6, [fp, #-416]
.L251:
	mov	ip, r4, asl #4
	rsb	lr, r2, r1
	sub	ip, ip, r4, asl #2
	sub	r2, fp, #44
	add	ip, r2, ip
	mov	r0, r3, asl #4
	sub	r3, r0, r3, asl #2
	add	lr, r2, lr
	ldrb	r1, [ip, #-360]
	add	r3, r2, r3
	rsb	r10, r4, r8
	ldr	r0, [lr, #-352]
	and	r1, r1, #254
	ldrb	lr, [lr, #-360]
	bfi	r1, r10, #1, #4
	ldrb	r10, [r3, #-360]
	strb	r1, [ip, #-360]
	mvn	r6, #0
	ldr	ip, [r3, #-352]
	mov	r1, r4
	str	r6, [r5, #4]
	mov	r2, r7
	add	r0, ip, r0
	str	r0, [r5, #8]
	ldr	r3, [r3, #-356]
	add	r4, r4, #1
	ldr	r0, [fp, #-416]
	add	r5, r5, #12
	strb	r10, [r9, #-3]
	sub	r9, r9, #2
	strb	lr, [r9, #-2]
	str	r3, [fp, #-408]
	bl	VP6_InsertSorted
	ldr	r1, [fp, #-408]
	sub	r0, fp, #44
	mov	r2, r1, asl #2
	mov	r1, r1, asl #4
	rsb	r3, r2, r1
	add	r3, r0, r3
	ldr	r3, [r3, #-356]
	cmp	r3, r6
	bne	.L251
.L243:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L248:
	mov	r1, #0
	b	.L245
	.fnend
	.size	VP6_BuildHuffTree, .-VP6_BuildHuffTree
	.align	2
	.global	VP6_BuildHuffLookupTable
	.type	VP6_BuildHuffLookupTable, %function
VP6_BuildHuffLookupTable:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r4, #0
.L260:
	mov	r2, #0
	mov	lr, r2
.L259:
	rsb	r3, lr, #5
	add	r5, r0, r2, lsl #1
	mov	r3, r4, asr r3
	add	ip, lr, #1
	tst	r3, #1
	mov	lr, ip
	ldrneb	r3, [r5, #1]
	ldreqb	r3, [r0, r2, asl #1]
	and	r5, r3, #1
	ubfx	r2, r3, #1, #4
	bfi	r3, r5, #0, #1
	bfi	r3, r2, #1, #4
	eor	r3, r3, #1
	cmp	ip, #5
	movhi	r3, #0
	andls	r3, r3, #1
	cmp	r3, #0
	bne	.L259
	ldrb	r3, [r1, r4]
	bfi	r3, r2, #4, #4
	bfi	r3, ip, #1, #3
	bfi	r3, r5, #0, #1
	strb	r3, [r1, r4]
	add	r4, r4, #1
	cmp	r4, #64
	bne	.L260
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	VP6_BuildHuffLookupTable, .-VP6_BuildHuffLookupTable
	.align	2
	.global	VP6_BuildTreeTab
	.type	VP6_BuildTreeTab, %function
VP6_BuildTreeTab:
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
	add	r6, r0, #9088
	add	r7, r0, #9920
	add	r6, r6, #30
	add	r7, r7, #62
	mov	r1, #0
.L264:
	sub	r5, r6, #432
.L273:
	sub	r4, r5, #96
.L271:
	ldrb	lr, [r4, #-2]
	add	r3, r0, r1
	add	ip, r1, #1
	mov	r2, r4
	add	ip, r0, ip
	add	r1, r1, #2
	strb	lr, [r3, #1218]
	mov	r3, #0
	ldrb	lr, [r4, #-1]
	strb	lr, [ip, #1218]
	b	.L269
.L267:
	ldrb	lr, [r2]
	cmp	r3, #5
	cmpne	r3, #11
	addne	r1, r1, #2
	addeq	r1, r1, #6
	add	r2, r2, #2
	strb	lr, [ip, #1218]
	ldrb	lr, [r2, #-1]
	strb	lr, [ip, #1219]
.L269:
	add	r3, r3, #1
	add	ip, r0, r1
	cmp	r3, #12
	bne	.L267
	add	r4, r4, #24
	cmp	r4, r5
	bne	.L271
	add	r5, r4, #144
	cmp	r6, r5
	bne	.L273
	add	r6, r4, #576
	cmp	r6, r7
	bne	.L264
	add	r4, r0, #9408
	add	r5, r0, #9472
	add	r4, r4, #46
	add	r5, r5, #30
	mov	r1, #768
.L272:
	ldrb	lr, [r4, #-2]
	add	r3, r0, r1
	add	ip, r1, #1
	mov	r2, r4
	add	ip, r0, ip
	add	r1, r1, #2
	strb	lr, [r3, #1218]
	mov	r3, #0
	ldrb	lr, [r4, #-1]
	strb	lr, [ip, #1218]
	b	.L278
.L276:
	ldrb	lr, [r2]
	cmp	r3, #5
	cmpne	r3, #11
	addne	r1, r1, #2
	addeq	r1, r1, #6
	add	r2, r2, #2
	strb	lr, [ip, #1218]
	ldrb	lr, [r2, #-1]
	strb	lr, [ip, #1219]
.L278:
	add	r3, r3, #1
	add	ip, r0, r1
	cmp	r3, #12
	bne	.L276
	add	r4, r4, #24
	cmp	r4, r5
	bne	.L272
	add	r4, r0, #8512
	add	r5, r0, #8576
	add	r4, r4, #20
	add	r5, r5, #12
	mov	ip, #832
.L277:
	mov	r1, r4
	mov	r3, #0
.L283:
	ldrb	lr, [r1]
	add	r2, r0, ip
	cmp	r3, #5
	cmpne	r3, #11
	addeq	ip, ip, #6
	strb	lr, [r2, #1218]
	ldrb	lr, [r1, #1]
	strb	lr, [r2, #1219]
	beq	.L280
	cmp	r3, #13
	beq	.L288
	add	ip, ip, #2
.L280:
	add	r3, r3, #1
	add	r1, r1, #2
	cmp	r3, #14
	bne	.L283
.L282:
	add	r4, r4, #28
	cmp	r4, r5
	bne	.L277
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L288:
	add	ip, ip, #30
	b	.L282
	.fnend
	.size	VP6_BuildTreeTab, .-VP6_BuildTreeTab
	.align	2
	.global	VP6_ConvertBoolToHuff
	.type	VP6_ConvertBoolToHuff, %function
VP6_ConvertBoolToHuff:
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
	add	r6, r0, #6592
	mov	r7, r0
	add	r6, r6, #4
	ldr	r1, .L296
	mov	r0, #22
	add	r5, r7, #9408
	bl	dprint_vfmw
	add	r5, r5, #44
	add	r0, r7, #512
	mov	r1, r6
	add	r0, r0, #2
	add	r4, r7, #6592
	bl	VP6_BoolTreeToHuffCodes
	mov	r2, #12
	mov	r1, r6
	mov	r0, r5
	bl	VP6_BuildHuffTree
	add	r1, r7, #9472
	mov	r0, r5
	add	r4, r4, #52
	add	r1, r1, #28
	add	r6, r7, #9472
	bl	VP6_BuildHuffLookupTable
	add	r6, r6, #4
	add	r0, r7, #524
	mov	r1, r4
	add	r0, r0, #1
	add	r5, r7, #6656
	bl	VP6_BoolTreeToHuffCodes
	mov	r2, #12
	mov	r1, r4
	mov	r0, r6
	bl	VP6_BuildHuffTree
	add	r5, r5, #36
	add	r1, r7, #9536
	add	r4, r7, #8512
	mov	r0, r6
	add	r4, r4, #20
	add	r1, r1, #28
	bl	VP6_BuildHuffLookupTable
	mov	r1, r5
	add	r0, r7, #536
	bl	VP6_ZerosBoolTreeToHuffCodes
	mov	r2, #9
	mov	r1, r5
	mov	r0, r4
	bl	VP6_BuildHuffTree
	add	r5, r7, #6720
	add	r1, r7, #11904
	mov	r0, r4
	add	r5, r5, #28
	add	r1, r1, #28
	add	r4, r7, #8512
	bl	VP6_BuildHuffLookupTable
	add	r4, r4, #48
	add	r0, r7, #548
	mov	r1, r5
	add	r0, r0, #2
	bl	VP6_ZerosBoolTreeToHuffCodes
	mov	r1, r5
	mov	r0, r4
	mov	r2, #9
	bl	VP6_BuildHuffTree
	add	r3, r7, #760
	mov	r0, r4
	add	r1, r7, #11968
	mov	r4, r3
	add	r3, r7, #6784
	add	r1, r1, #28
	mov	r5, r3
	add	r3, r7, #8576
	mov	r6, r3
	add	r3, r7, #9600
	mov	r8, r3
	add	r3, r7, #1152
	mov	r9, r3
	bl	VP6_BuildHuffLookupTable
	add	r3, r4, #2
	str	r7, [fp, #-72]
	str	r3, [fp, #-52]
	add	r3, r5, #20
	str	r3, [fp, #-60]
	add	r3, r6, #12
	str	r3, [fp, #-64]
	add	r3, r8, #28
	str	r3, [fp, #-56]
	add	r3, r9, #6
	str	r3, [fp, #-68]
.L290:
	ldr	r3, [fp, #-52]
	ldr	r9, [fp, #-56]
	sub	r10, r3, #198
	ldr	r8, [fp, #-64]
	ldr	r3, [fp, #-60]
	str	r3, [fp, #-48]
.L294:
	ldr	r7, [fp, #-48]
	add	r6, r10, #66
	mov	r5, r9
	mov	r4, r8
.L291:
	mov	r1, r7
	mov	r0, r10
	bl	VP6_BoolTreeToHuffCodes
	mov	r1, r7
	mov	r0, r4
	mov	r2, #12
	bl	VP6_BuildHuffTree
	add	r10, r10, #11
	mov	r1, r5
	mov	r0, r4
	bl	VP6_BuildHuffLookupTable
	cmp	r10, r6
	add	r7, r7, #48
	add	r5, r5, #64
	add	r4, r4, #24
	bne	.L291
	ldr	r3, [fp, #-52]
	add	r8, r8, #144
	add	r9, r9, #384
	cmp	r3, r10
	ldr	r3, [fp, #-48]
	add	r3, r3, #288
	str	r3, [fp, #-48]
	bne	.L294
	ldr	r2, [fp, #-60]
	ldr	r3, [fp, #-52]
	add	r2, r2, #864
	str	r2, [fp, #-60]
	ldr	r2, [fp, #-68]
	add	r3, r3, #198
	str	r3, [fp, #-52]
	cmp	r3, r2
	ldr	r3, [fp, #-64]
	add	r3, r3, #432
	str	r3, [fp, #-64]
	ldr	r3, [fp, #-56]
	add	r3, r3, #1152
	str	r3, [fp, #-56]
	bne	.L290
	ldr	r7, [fp, #-72]
	mov	r0, r7
	bl	VP6_BuildTreeTab
	ldr	r1, .L296+4
	mov	r0, #22
	bl	dprint_vfmw
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L297:
	.align	2
.L296:
	.word	.LC8
	.word	.LC9
	.fnend
	.size	VP6_ConvertBoolToHuff, .-VP6_ConvertBoolToHuff
	.align	2
	.global	VP6_IntraFrmHeader
	.type	VP6_IntraFrmHeader, %function
VP6_IntraFrmHeader:
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
	mov	r5, r1
	mov	r4, r0
	ldr	r1, .L337
	mov	r0, #22
	bl	dprint_vfmw
	mov	r1, #5
	mov	r0, r5
	add	r8, r4, #8192
	bl	BsGet
	mov	r1, #2
	uxtb	r3, r0
	mov	r0, r5
	str	r3, [r8, #4072]
	bl	BsGet
	ldr	r2, [r8, #4072]
	cmp	r2, #8
	uxtb	r0, r0
	str	r0, [r8, #4076]
	bhi	.L333
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	uxtb	r6, r0
	cmp	r6, #0
	bne	.L334
	ldrb	r3, [r8, #4062]
	cmp	r3, #0
	beq	.L302
	mov	r1, #16
	mov	r0, r5
	bl	BsGet
	add	r9, r4, #12288
	mov	r2, #255
	mov	r3, #8
	str	r6, [r9, #36]
	mov	r1, #24
	str	r2, [r9, #40]
	str	r3, [r9, #48]
	str	r0, [r9, #16]
	mov	r0, r5
	bl	BsGet
	str	r0, [r9, #44]
.L303:
	add	r4, r4, #12288
	mov	r10, #0
	add	r4, r4, #36
	mov	r6, #7
.L304:
	mov	r1, r4
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool128
	orr	r10, r10, r0, asl r6
	subs	r6, r6, #1
	bcs	.L304
	mov	r7, #0
	mov	r6, #7
	uxtb	r10, r10
	str	r10, [r8, #4084]
.L305:
	mov	r1, r4
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool128
	orr	r7, r7, r0, asl r6
	subs	r6, r6, #1
	bcs	.L305
	ldr	r10, [r8, #4084]
	uxtb	r3, r7
	mov	r6, #7
	mov	r7, #0
	str	r3, [r8, #4088]
	mov	r3, r3, asl #1
	mov	r10, r10, asl #1
	str	r3, [fp, #-48]
	str	r10, [r8, #4092]
	str	r3, [r9]
.L306:
	mov	r1, r4
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool128
	orr	r7, r7, r0, asl r6
	subs	r6, r6, #1
	bcs	.L306
	uxtb	r2, r7
	mov	r6, #7
	mov	r7, #0
	mov	r2, r2, asl #1
	str	r2, [r9, #4]
.L307:
	mov	r1, r4
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool128
	orr	r7, r7, r0, asl r6
	subs	r6, r6, #1
	bcs	.L307
	uxtb	r3, r7
	mov	r1, r4
	mov	r0, r5
	mov	r3, r3, asl #1
	str	r3, [r9, #8]
	bl	Vp6_Vfmw_DecodeBool128
	mov	r1, r4
	mov	r6, r0
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool128
	ldr	r3, [r8, #3872]
	ldr	r2, [r8, #3868]
	cmp	r10, r3
	orr	r0, r0, r6, asl #1
	strb	r0, [r8, #4063]
	bne	.L309
	ldr	r1, [fp, #-48]
	cmp	r1, r2
	beq	.L310
.L309:
	ldr	r1, [fp, #-48]
	mov	r0, #22
	str	r10, [sp, #4]
	str	r1, [sp]
	ldr	r1, .L337+4
	bl	dprint_vfmw
.L310:
	ldr	r3, [r8, #4076]
	ldr	r2, [fp, #-48]
	cmp	r3, #0
	str	r10, [r8, #3872]
	str	r2, [r8, #3868]
	moveq	r2, #14
	streqb	r2, [r8, #4066]
	streq	r3, [r9, #20]
	bne	.L335
.L319:
	ldr	r1, .L337+8
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, #1
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L333:
	ldr	r1, .L337+12
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L302:
	add	r9, r4, #12288
	mov	ip, #255
	mov	r2, #8
	mov	r1, #24
	str	r3, [r9, #36]
	mov	r0, r5
	str	ip, [r9, #40]
	str	r2, [r9, #48]
	bl	BsGet
	str	r0, [r9, #44]
	b	.L303
.L334:
	ldr	r1, .L337+16
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L335:
	mov	r1, r4
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool128
	cmp	r0, #0
	beq	.L312
	mov	r7, #0
	mov	r6, #4
	mov	r3, #2
	str	r3, [r9, #20]
.L313:
	mov	r1, r4
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool128
	orr	r7, r7, r0, asl r6
	subs	r6, r6, #1
	bcs	.L313
	ldr	r3, [r8, #4072]
	mov	r9, #0
	mov	r6, #2
	cmp	r3, #7
	movhi	r3, r9
	movls	r3, #5
	mov	r7, r7, asl r3
	strb	r7, [r8, #4064]
.L315:
	mov	r1, r4
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool128
	orr	r9, r9, r0, asl r6
	subs	r6, r6, #1
	bcs	.L315
	strb	r9, [r8, #4065]
.L316:
	ldr	r3, [r8, #4072]
	cmp	r3, #7
	bls	.L336
	mov	r7, #0
	mov	r6, #3
.L318:
	mov	r1, r4
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool128
	orr	r7, r7, r0, asl r6
	subs	r6, r6, #1
	bcs	.L318
	strb	r7, [r8, #4066]
	b	.L319
.L336:
	mov	r3, #16
	strb	r3, [r8, #4066]
	b	.L319
.L312:
	mov	r1, r4
	mov	r0, r5
	bl	Vp6_Vfmw_DecodeBool128
	cmp	r0, #0
	streq	r0, [r9, #20]
	movne	r3, #1
	strne	r3, [r9, #20]
	b	.L316
.L338:
	.align	2
.L337:
	.word	.LC10
	.word	.LC13
	.word	.LC14
	.word	.LC11
	.word	.LC12
	.fnend
	.size	VP6_IntraFrmHeader, .-VP6_IntraFrmHeader
	.align	2
	.global	VP6_InterFrmHeader
	.type	VP6_InterFrmHeader, %function
VP6_InterFrmHeader:
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
	add	r4, r0, #8192
	mov	r5, r0
	mov	r7, r1
	ldr	r2, [r4, #3928]
	cmp	r2, #0
	beq	.L361
	ldrb	r3, [r4, #4062]
	ldr	r1, [r4, #3932]
	cmp	r3, #0
	str	r2, [r4, #4072]
	str	r1, [r4, #4076]
	bne	.L362
	add	r6, r0, #12288
	mov	ip, #255
	mov	r2, #8
	mov	r1, #24
	str	r3, [r6, #36]
	mov	r0, r7
	str	ip, [r6, #40]
	str	r2, [r6, #48]
	bl	BsGet
	str	r0, [r6, #44]
.L343:
	add	r5, r5, #12288
	mov	r0, r7
	add	r5, r5, #36
	mov	r1, r5
	bl	Vp6_Vfmw_DecodeBool128
	str	r0, [r6, #24]
	ldr	r3, [r4, #3932]
	str	r0, [r4, #3892]
	cmp	r3, #0
	bne	.L363
	mov	r2, #14
	mov	r0, #1
	strb	r2, [r4, #4066]
	str	r3, [r6, #20]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L362:
	mov	r1, #16
	mov	r0, r7
	bl	BsGet
	add	r6, r5, #12288
	mov	r3, #0
	mov	r2, #255
	str	r3, [r6, #36]
	mov	r1, #24
	mov	r3, #8
	str	r2, [r6, #40]
	str	r3, [r6, #48]
	str	r0, [r6, #16]
	mov	r0, r7
	bl	BsGet
	str	r0, [r6, #44]
	b	.L343
.L363:
	mov	r1, r5
	mov	r0, r7
	bl	Vp6_Vfmw_DecodeBool128
	cmp	r0, #0
	mov	r8, r0
	str	r0, [r6, #28]
	bne	.L364
.L345:
	ldr	r3, [r4, #3928]
	cmp	r3, #7
	bhi	.L365
	mov	r3, #16
	mov	r0, #1
	strb	r3, [r4, #4066]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L365:
	mov	r1, r5
	mov	r0, r7
	bl	Vp6_Vfmw_DecodeBool128
	cmp	r0, #0
	bne	.L366
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L364:
	mov	r1, r5
	mov	r0, r7
	bl	Vp6_Vfmw_DecodeBool128
	orr	r0, r0, r8, asl #1
	str	r0, [r6, #28]
	b	.L345
.L366:
	mov	r1, r5
	mov	r0, r7
	bl	Vp6_Vfmw_DecodeBool128
	cmp	r0, #0
	beq	.L347
	mov	r9, #0
	mov	r8, #4
	mov	r3, #2
	str	r3, [r6, #20]
.L348:
	mov	r1, r5
	mov	r0, r7
	bl	Vp6_Vfmw_DecodeBool128
	orr	r9, r9, r0, asl r8
	subs	r8, r8, #1
	bcs	.L348
	mov	r8, #0
	mov	r6, #2
	strb	r9, [r4, #4064]
.L349:
	mov	r1, r5
	mov	r0, r7
	bl	Vp6_Vfmw_DecodeBool128
	orr	r8, r8, r0, asl r6
	subs	r6, r6, #1
	bcs	.L349
	strb	r8, [r4, #4065]
.L350:
	mov	r8, #0
	mov	r6, #3
.L352:
	mov	r1, r5
	mov	r0, r7
	bl	Vp6_Vfmw_DecodeBool128
	orr	r8, r8, r0, asl r6
	subs	r6, r6, #1
	bcs	.L352
	strb	r8, [r4, #4066]
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L361:
	ldr	r3, [r4, #4072]
	mov	r0, #1
	ldr	r1, .L367
	bl	dprint_vfmw
	mvn	r0, #87
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L347:
	mov	r1, r5
	mov	r0, r7
	bl	Vp6_Vfmw_DecodeBool128
	cmp	r0, #0
	streq	r0, [r6, #20]
	movne	r3, #1
	strne	r3, [r6, #20]
	b	.L350
.L368:
	.align	2
.L367:
	.word	.LC15
	.fnend
	.size	VP6_InterFrmHeader, .-VP6_InterFrmHeader
	.align	2
	.global	VP6_GetPictureHeader
	.type	VP6_GetPictureHeader, %function
VP6_GetPictureHeader:
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
	cmp	r1, #0
	cmpne	r0, #0
	mov	r7, r0
	mov	r6, r1
	beq	.L375
	ldr	r1, .L378
	mov	r0, #22
	bl	dprint_vfmw
	mov	r1, #1
	mov	r0, r6
	add	r4, r7, #8192
	bl	BsGet
	mov	r1, #6
	uxtb	r3, r0
	mov	r0, r6
	str	r3, [r4, #4080]
	strb	r3, [r4, #3888]
	bl	BsGet
	ldr	r1, .L378+4
	add	r2, r7, #12224
	mov	ip, r0
	uxtb	r3, r0
	ldr	r0, .L378+8
	add	r1, r1, r3
	mov	r3, r3, asl #1
	strb	ip, [r4, #4060]
	add	r5, r0, #128
	ldrb	r8, [r1, #1656]
	ldrh	lr, [r0, r3]
	mov	r1, #1
	ldrh	r3, [r5, r3]
	mov	r0, r6
	strb	r8, [r4, #4061]
	strh	lr, [r2, #36]
	strh	r3, [r2, #38]
	bl	BsGet
	ldr	r3, [r4, #4080]
	mov	r1, r6
	cmp	r3, #0
	strb	r0, [r4, #4062]
	mov	r0, r7
	beq	.L376
	bl	VP6_InterFrmHeader
	mov	r5, r0
	cmp	r5, #1
	beq	.L377
.L374:
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L376:
	bl	VP6_IntraFrmHeader
	mov	r5, r0
	cmp	r5, #1
	bne	.L374
.L377:
	add	r1, r7, #12288
	mov	r0, r6
	add	r1, r1, #36
	add	r7, r7, #12288
	bl	Vp6_Vfmw_DecodeBool128
	ldr	r1, .L378+12
	str	r0, [r7, #32]
	mov	r0, #22
	ldrb	r3, [r4, #4060]
	str	r3, [r7, #12]
	bl	dprint_vfmw
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L375:
	ldr	r1, .L378+16
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L379:
	.align	2
.L378:
	.word	.LC17
	.word	.LANCHOR0
	.word	.LANCHOR0+1720
	.word	.LC18
	.word	.LC16
	.fnend
	.size	VP6_GetPictureHeader, .-VP6_GetPictureHeader
	.align	2
	.global	VP6DEC_Init
	.type	VP6DEC_Init, %function
VP6DEC_Init:
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
	ldr	r6, .L384
	add	r5, r0, #12288
	movw	r2, #13024
	mov	r7, r1
	mov	r1, #0
	ldr	r8, [r5, #720]
	mov	r4, r0
	ldr	r3, [r6, #48]
	blx	r3
	add	r0, r4, #12608
	add	r0, r0, #56
	str	r8, [r5, #720]
	bl	ResetVoQueue
	str	r7, [r4]
	mov	r0, r4
	bl	VCTRL_GetChanIDByCtx
	cmn	r0, #1
	str	r0, [r5, #728]
	beq	.L383
	ldr	r3, [r6, #48]
	movw	r2, #12396
	mov	r1, #0
	add	r0, r4, #236
	blx	r3
	mov	r2, #1024
	mov	r3, #0
	str	r2, [r5, #52]
	str	r3, [r5, #24]
	mov	r0, #22
	ldr	r3, [r4]
	ldr	r1, .L384+4
	ldr	r3, [r3, #8]
	str	r3, [r5, #16]
	bl	dprint_vfmw
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L383:
	ldr	r1, .L384+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #19
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L385:
	.align	2
.L384:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC20
	.word	.LC19
	.fnend
	.size	VP6DEC_Init, .-VP6DEC_Init
	.align	2
	.global	VP6DEC_Destroy
	.type	VP6DEC_Destroy, %function
VP6DEC_Destroy:
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
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VP6DEC_Destroy, .-VP6DEC_Destroy
	.align	2
	.global	VP6_DecodeDecide
	.type	VP6_DecodeDecide, %function
VP6_DecodeDecide:
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
	add	r4, r0, #12288
	mov	r6, r0
	ldr	r5, [r4, #24]
	cmp	r5, #0
	beq	.L413
	ldr	r3, [r4, #16]
	sub	r3, r3, #2
	cmp	r3, #1
	ldr	r3, [r0]
	ldr	r2, [r3, #8]
	bls	.L414
.L391:
	str	r2, [r4, #16]
	cmp	r2, #4
	ldrls	pc, [pc, r2, asl #2]
	b	.L396
.L397:
	.word	.L395
	.word	.L395
	.word	.L392
	.word	.L394
	.word	.L395
.L415:
	ldr	r1, .L417
	mov	r0, #18
	bl	dprint_vfmw
.L394:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L414:
	cmp	r2, #4
	cmpne	r2, #1
	bhi	.L391
	ldr	r1, .L417+4
	mov	r0, #2
	bl	dprint_vfmw
	mov	r2, #1
	ldr	r1, [r4, #40]
	mov	r5, #0
	ldr	r0, [r4, #728]
	bl	FSP_ClearLogicFs
	mov	r2, #1
	ldr	r1, [r4, #44]
	ldr	r0, [r4, #728]
	bl	FSP_ClearLogicFs
	str	r5, [r4, #40]
	str	r5, [r4, #44]
	ldr	r0, [r4, #728]
	bl	FSP_GetNullLogicFs
	str	r5, [r4, #20]
	str	r0, [r4, #44]
	str	r0, [r4, #40]
	ldr	r3, [r6]
	ldr	r2, [r3, #8]
	b	.L391
.L413:
	ldr	r1, .L417+8
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L392:
	ldrb	r2, [r4, #28]
	cmp	r2, #0
	bne	.L415
.L393:
	ldr	r1, [r4, #44]
	ldr	r0, [r4, #728]
	bl	FSP_GetFsImagePtr
	subs	r5, r0, #0
	beq	.L416
	ldrb	r3, [r4, #28]
	cmp	r3, #0
	beq	.L402
	ldr	r3, [r6]
	ldr	r2, [r5, #160]
	ldr	r3, [r3]
	cmp	r2, r3
	bls	.L402
	ldr	r1, .L417+12
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L395:
	ldrb	r3, [r4, #28]
	cmp	r3, #0
	beq	.L393
	ldr	r3, [r4, #20]
	cmp	r3, #0
	bne	.L393
	ldr	r2, .L417+16
	mov	r0, #18
	ldr	r1, .L417+20
	bl	dprint_vfmw
	b	.L394
.L396:
	ldr	r1, .L417+24
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L402:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L416:
	movw	r3, #2187
	ldr	r2, .L417+28
	ldr	r1, .L417+32
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L418:
	.align	2
.L417:
	.word	.LC23
	.word	.LC22
	.word	.LC21
	.word	.LC28
	.word	.LC24
	.word	.LC25
	.word	.LC26
	.word	.LANCHOR0+1976
	.word	.LC27
	.fnend
	.size	VP6_DecodeDecide, .-VP6_DecodeDecide
	.align	2
	.global	VP6_Set_DecParam
	.type	VP6_Set_DecParam, %function
VP6_Set_DecParam:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r3, r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	push	{lr}
	bl	__gnu_mcount_nc
	add	r6, r0, #12288
	mov	r4, r0
	add	r5, r0, #8
	ldrb	r3, [r6, #28]
	ldr	r8, [r0, #220]
	cmp	r3, #3
	beq	.L444
	ldr	r3, .L445
	mov	r2, #212
	mov	r1, #0
	mov	r0, r5
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r3, [r6, #220]
	mov	r2, #0
	strb	r2, [r4, #9]
	str	r3, [r4, #68]
	ldrb	r3, [r6, #200]
	str	r3, [r4, #72]
	ldrb	r3, [r6, #202]
	str	r3, [r4, #76]
	ldr	r3, [r6, #268]
	str	r3, [r4, #80]
	ldr	r3, [r6, #256]
	str	r3, [r4, #92]
	ldrb	r3, [r6, #204]
	str	r3, [r4, #96]
	ldrb	r3, [r6, #205]
	str	r3, [r4, #100]
	ldrb	r3, [r6, #206]
	str	r3, [r4, #104]
	ldr	r3, [r6, #264]
	str	r3, [r4, #116]
	ldrb	r3, [r6, #201]
	strb	r3, [r4, #8]
	ldrh	r3, [r6, #208]
	str	r3, [r4, #84]
	ldrh	r3, [r6, #210]
	str	r3, [r4, #88]
	ldr	r3, [r6, #216]
	str	r3, [r4, #112]
	ldr	r3, [r6, #212]
	str	r3, [r4, #108]
	ldr	r3, [r6, #228]
	strh	r3, [r4, #60]
	ldr	r3, [r6, #224]
	strh	r3, [r4, #62]
	ldr	r1, [r6, #36]
	ldr	r0, [r6, #728]
	bl	FSP_GetLogicFs
	ldr	r1, [r6, #44]
	mov	r7, r0
	ldr	r0, [r6, #728]
	bl	FSP_GetLogicFs
	ldr	r1, [r6, #40]
	mov	r9, r0
	ldr	r0, [r6, #728]
	bl	FSP_GetLogicFs
	cmp	r7, #0
	cmpne	r9, #0
	moveq	r3, #1
	movne	r3, #0
	cmp	r0, #0
	orreq	r3, r3, #1
	cmp	r3, #0
	bne	.L428
	ldr	r3, [r7, #608]
	cmp	r3, #0
	beq	.L429
	ldr	r3, [r3, #16]
	str	r3, [r4, #180]
	ldr	r3, [r7, #620]
	str	r3, [r4, #192]
	ldr	r3, [r0, #608]
	cmp	r3, #0
	ldreq	r3, [r7, #608]
	ldr	r3, [r3, #16]
	str	r3, [r4, #184]
	ldr	r3, [r9, #608]
	add	r9, r4, #12608
	add	r9, r9, #24
	cmp	r3, #0
	mov	r0, r9
	ldreq	r3, [r7, #608]
	ldr	r3, [r3, #16]
	str	r3, [r4, #188]
	ldr	r3, [r6, #52]
	str	r3, [r4, #196]
	ldr	r3, [r7, #608]
	ldr	r3, [r3, #76]
	str	r3, [r4, #200]
	ldr	r3, [r7, #608]
	ldr	r3, [r3, #60]
	str	r3, [r4, #204]
	ldr	r3, [r7, #608]
	ldr	r3, [r3, #64]
	str	r3, [r4, #208]
	ldr	r3, [r6, #280]
	str	r3, [r4, #168]
	ldr	r3, [r6, #276]
	str	r3, [r4, #172]
	ldr	r3, [r6, #284]
	str	r3, [r4, #176]
	ldr	r7, [r8]
	bl	BsPos
	mov	r3, r0
	add	r0, r0, #7
	cmp	r3, #0
	movlt	r3, r0
	add	r7, r7, r3, asr #3
	mov	r0, r7
	bl	MEM_Vir2Phy
	bic	r3, r0, #15
	mov	r0, r7
	sub	r3, r3, #16
	str	r3, [r4, #64]
	bl	MEM_Vir2Phy
	ldrb	r7, [r6, #202]
	cmp	r7, #0
	and	r0, r0, #15
	mov	r0, r0, asl #3
	bne	.L434
	ldr	r3, [r6, #216]
	cmp	r3, #0
	bne	.L435
.L434:
	mov	r3, #16
	str	r0, [r4, #124]
	str	r3, [r4, #128]
	mov	r0, r9
	ldr	r9, [r6, #252]
	bl	BsPos
	mov	r7, #0
	str	r7, [r4, #140]
	str	r7, [r4, #136]
	mov	r9, r9, asl #3
	str	r7, [r4, #132]
	rsb	r0, r0, r9
	str	r0, [r4, #120]
	ldr	r3, [r8]
	ldr	r10, [r6, #252]
	add	r10, r3, r10
	mov	r0, r10
	bl	MEM_Vir2Phy
	mov	r9, r0
	mov	r0, r10
	bl	MEM_Vir2Phy
	and	r9, r9, #15
	ldr	r3, [r4, #64]
	mov	r9, r9, asl #3
	str	r9, [r4, #148]
	bic	r0, r0, #15
	rsb	r0, r3, r0
	str	r0, [r4, #152]
	ldr	r3, [r6, #252]
	ldr	r2, [r8, #8]
	str	r7, [r4, #164]
	mov	r3, r3, asl #3
	str	r7, [r4, #160]
	rsb	r3, r3, r2, lsl #3
	str	r7, [r4, #156]
	str	r3, [r4, #144]
.L436:
	add	r9, r4, #4992
	add	r3, r4, #5120
	add	r3, r3, #46
	str	r3, [r4, #52]
	mov	r3, r9
	add	r3, r3, #14
	str	r3, [r4, #44]
	add	r10, r4, #4416
	ldr	r3, [r4]
	add	r8, r4, #4288
	add	r7, r4, #3296
	add	r6, r4, #3360
	add	lr, r4, #3232
	add	ip, r4, #2528
	add	r0, r4, #2464
	add	r1, r4, #3168
	add	r2, r4, #6656
	add	r10, r10, #14
	add	r9, r9, #46
	str	r10, [r4, #40]
	str	r9, [r4, #48]
	add	r8, r8, #46
	add	r7, r7, #14
	str	r8, [r4, #36]
	str	r7, [r4, #28]
	add	r6, r6, #14
	add	lr, lr, #14
	str	r6, [r4, #32]
	str	lr, [r4, #24]
	add	ip, ip, #14
	add	r0, r0, #14
	str	ip, [r4, #16]
	str	r0, [r4, #12]
	add	r1, r1, #14
	add	r2, r2, #46
	str	r1, [r4, #20]
	str	r2, [r4, #56]
	mov	r0, #1
	ldr	r3, [r3, #588]
	str	r3, [r4, #212]
	ldr	r3, [r4]
	ldr	r3, [r3, #624]
	str	r5, [r4, #4]
	str	r3, [r4, #216]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L428:
	ldr	r1, .L445+4
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L444:
	str	r3, [r0, #68]
	mov	r3, #1
	strb	r3, [r0, #9]
	ldr	r1, [r6, #36]
	ldr	r0, [r6, #728]
	bl	FSP_GetLogicFs
	ldr	r1, [r6, #44]
	mov	r7, r0
	ldr	r0, [r6, #728]
	bl	FSP_GetLogicFs
	ldr	r1, [r6, #40]
	mov	r8, r0
	ldr	r0, [r6, #728]
	bl	FSP_GetLogicFs
	cmp	r7, #0
	cmpne	r8, #0
	moveq	r3, #1
	movne	r3, #0
	cmp	r0, #0
	orreq	r3, r3, #1
	cmp	r3, #0
	bne	.L428
	ldr	r3, [r7, #608]
	cmp	r3, #0
	beq	.L429
	ldr	r3, [r3, #16]
	str	r3, [r4, #180]
	ldr	r3, [r7, #620]
	str	r3, [r4, #192]
	ldr	r3, [r0, #608]
	mov	r0, #1
	cmp	r3, #0
	ldreq	r3, [r7, #608]
	ldr	r3, [r3, #16]
	str	r3, [r4, #184]
	ldr	r3, [r8, #608]
	cmp	r3, #0
	ldreq	r3, [r7, #608]
	ldr	r3, [r3, #16]
	str	r5, [r4, #4]
	str	r3, [r4, #188]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L435:
	str	r0, [r4, #124]
	mov	r3, #16
	mov	r0, r9
	str	r3, [r4, #128]
	ldr	r6, [r8, #8]
	bl	BsPos
	str	r7, [r4, #140]
	str	r7, [r4, #136]
	mov	r6, r6, asl #3
	str	r7, [r4, #132]
	str	r7, [r4, #152]
	str	r7, [r4, #148]
	str	r7, [r4, #144]
	str	r7, [r4, #164]
	str	r7, [r4, #160]
	str	r7, [r4, #156]
	rsb	r0, r0, r6
	str	r0, [r4, #120]
	b	.L436
.L429:
	ldr	r1, .L445+8
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L446:
	.align	2
.L445:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC29
	.word	.LC30
	.fnend
	.size	VP6_Set_DecParam, .-VP6_Set_DecParam
	.align	2
	.global	VP6_CfgTable
	.type	VP6_CfgTable, %function
VP6_CfgTable:
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
	ldr	r5, .L472
	add	r4, r0, #2240
	add	r7, r0, #2288
	add	r4, r4, #2
	add	r7, r7, #2
	add	r6, r0, #4
	mov	r9, r0
	mov	r3, #0
	str	r1, [fp, #-64]
	str	r3, [fp, #-60]
	str	r3, [fp, #-56]
	str	r3, [fp, #-52]
	str	r3, [fp, #-48]
.L448:
	mov	r1, r6
	mov	r0, r4
	ldr	r3, [r5, #52]
	mov	r2, #10
	add	r4, r4, #16
	blx	r3
	cmp	r4, r7
	add	r6, r6, #10
	bne	.L448
	add	r3, r9, #2944
	add	r7, r9, #2304
	add	r3, r3, #2
	add	r7, r7, #2
	add	r8, r9, #44
	str	r9, [fp, #-68]
	mov	r10, r3
.L449:
	add	r6, r7, #160
	mov	r9, r8
.L450:
	mov	r1, r9
	mov	r0, r7
	ldr	ip, [r5, #52]
	mov	r2, #9
	add	r7, r7, #16
	blx	ip
	cmp	r7, r6
	add	r9, r9, #9
	ldr	r4, .L472
	bne	.L450
	cmp	r7, r10
	add	r8, r8, #90
	bne	.L449
	ldr	r9, [fp, #-68]
	mov	r1, #0
	ldr	r3, [r4, #48]
	mov	r2, #16
	sub	r0, fp, #60
	mov	r6, r1
	blx	r3
	ldrb	r10, [r9]
	ldrb	r8, [r9, #2]
	mov	r0, r7
	ldrb	r7, [r9, #484]
	sub	r1, fp, #60
	ldrb	lr, [r9, #485]
	mov	r2, #16
	ldrb	ip, [r9, #486]
	ldrb	r3, [r9, #487]
	strb	r10, [fp, #-60]
	strb	r8, [fp, #-59]
	ldrb	r10, [r9, #488]
	ldrb	r8, [r9, #489]
	strb	r7, [fp, #-58]
	ldrb	r7, [r9, #490]
	strb	lr, [fp, #-57]
	strb	ip, [fp, #-56]
	strb	r3, [fp, #-55]
	strb	r10, [fp, #-54]
	strb	r8, [fp, #-53]
	strb	r7, [fp, #-52]
	ldr	r3, [r4, #52]
	blx	r3
	mov	r1, r6
	ldr	r3, [r4, #48]
	mov	r2, #16
	sub	r0, fp, #60
	blx	r3
	ldrb	lr, [r9]
	ldrb	ip, [r9, #498]
	add	r0, r9, #2960
	ldrb	r3, [r9, #499]
	sub	r1, fp, #60
	ldrb	r10, [r9, #500]
	mov	r2, #16
	ldrb	r8, [r9, #501]
	add	r0, r0, #2
	ldrb	r7, [r9, #502]
	strb	lr, [fp, #-60]
	strb	ip, [fp, #-59]
	ldrb	lr, [r9, #503]
	ldrb	ip, [r9, #504]
	strb	r3, [fp, #-58]
	ldrb	r3, [r9, #505]
	strb	lr, [fp, #-54]
	strb	ip, [fp, #-53]
	strb	r10, [fp, #-57]
	strb	r8, [fp, #-56]
	strb	r7, [fp, #-55]
	strb	r3, [fp, #-52]
	strb	r6, [fp, #-51]
	strb	r6, [fp, #-50]
	ldr	r3, [r4, #52]
	blx	r3
	mov	r1, r6
	ldr	r3, [r4, #48]
	mov	r2, #16
	sub	r0, fp, #60
	blx	r3
	ldrb	lr, [r9, #1]
	ldrb	ip, [r9, #3]
	add	r0, r9, #2976
	ldrb	r3, [r9, #491]
	sub	r1, fp, #60
	ldrb	r10, [r9, #492]
	mov	r2, #16
	ldrb	r8, [r9, #493]
	add	r0, r0, #2
	ldrb	r7, [r9, #494]
	strb	lr, [fp, #-60]
	strb	ip, [fp, #-59]
	ldrb	lr, [r9, #495]
	ldrb	ip, [r9, #496]
	strb	r3, [fp, #-58]
	ldrb	r3, [r9, #497]
	strb	lr, [fp, #-54]
	strb	ip, [fp, #-53]
	strb	r10, [fp, #-57]
	strb	r8, [fp, #-56]
	strb	r7, [fp, #-55]
	strb	r3, [fp, #-52]
	ldr	r3, [r4, #52]
	blx	r3
	mov	r1, r6
	ldr	r3, [r4, #48]
	mov	r2, #16
	sub	r0, fp, #60
	blx	r3
	ldrb	r3, [r9, #1]
	ldrb	lr, [r9, #508]
	add	r0, r9, #2992
	ldrb	r2, [r9, #509]
	sub	r1, fp, #60
	ldrb	r8, [r9, #506]
	add	r0, r0, #2
	ldrb	r7, [r9, #507]
	str	r2, [fp, #-68]
	mov	r2, #16
	ldrb	r10, [r9, #510]
	ldrb	ip, [r9, #511]
	strb	r6, [fp, #-51]
	strb	r6, [fp, #-50]
	strb	r3, [fp, #-60]
	ldrb	r6, [r9, #512]
	ldrb	r3, [r9, #513]
	strb	lr, [fp, #-57]
	ldrb	lr, [fp, #-68]
	strb	r3, [fp, #-52]
	strb	r8, [fp, #-59]
	ldr	r3, [r4, #52]
	strb	r7, [fp, #-58]
	strb	lr, [fp, #-56]
	strb	r10, [fp, #-55]
	strb	ip, [fp, #-54]
	strb	r6, [fp, #-53]
	blx	r3
	ldr	r3, [fp, #-64]
	ldr	r3, [r3, #68]
	cmp	r3, #0
	bne	.L452
	add	r6, r9, #4096
	add	r7, r9, #1152
	mov	r4, r6
	add	r6, r6, #2
	add	r4, r4, #50
.L453:
	mov	r1, r7
	mov	r0, r6
	ldr	r3, [r5, #52]
	mov	r2, #11
	add	r6, r6, #16
	blx	r3
	cmp	r6, r4
	add	r7, r7, #11
	bne	.L453
	add	r6, r9, #1184
	add	r7, r9, #4160
	add	r6, r6, #1
	add	r7, r7, #34
.L454:
	mov	r1, r6
	mov	r0, r4
	ldr	r3, [r5, #52]
	mov	r2, #11
	add	r4, r4, #16
	blx	r3
	cmp	r4, r7
	add	r6, r6, #11
	ldr	r10, .L472
	bne	.L454
	add	r0, r9, #4736
	ldr	r3, [r10, #52]
	mov	r2, #14
	add	r1, r9, #536
	add	r0, r0, #34
	add	r8, r9, #4480
	blx	r3
	add	ip, r9, #5056
	add	r1, r9, #548
	add	r0, r9, #4736
	ldr	r3, [r10, #52]
	add	r1, r1, #2
	add	r0, r0, #50
	mov	r2, #14
	mov	r4, ip
	blx	r3
	add	r3, r4, #2
	str	r3, [fp, #-64]
	add	r3, r9, #564
	add	r8, r8, #2
	str	r9, [fp, #-68]
	mov	r10, r3
.L461:
	sub	r4, r8, #288
	mov	r7, r10
.L464:
	add	r9, r4, #48
	mov	r6, r7
.L462:
	mov	r1, r6
	mov	r0, r4
	ldr	r3, [r5, #52]
	mov	r2, #11
	add	r4, r4, #16
	blx	r3
	cmp	r9, r4
	add	r6, r6, #66
	bne	.L462
	cmp	r9, r8
	add	r7, r7, #11
	mov	r4, r9
	bne	.L464
	ldr	r3, [fp, #-64]
	add	r8, r8, #288
	add	r10, r10, #198
	cmp	r8, r3
	bne	.L461
	ldr	r9, [fp, #-68]
.L460:
	add	r0, r9, #3008
	ldr	r3, [r5, #52]
	add	r1, r9, #960
	mov	r2, #64
	add	r0, r0, #2
	blx	r3
	add	r0, r9, #3072
	ldr	r3, [r5, #52]
	add	r1, r9, #1024
	mov	r2, #64
	add	r0, r0, #2
	blx	r3
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L452:
	add	r1, r9, #9472
	add	r0, r9, #4800
	ldr	r3, [r4, #52]
	add	r1, r1, #28
	mov	r2, #128
	add	r0, r0, #2
	blx	r3
	add	ip, r9, #9600
	ldr	r3, [r4, #52]
	add	r1, r9, #11904
	mov	r4, ip
	add	r0, r9, #6464
	add	ip, r9, #7232
	mov	r2, #128
	add	r1, r1, #28
	add	r0, r0, #2
	mov	r6, ip
	add	r8, r9, #5696
	blx	r3
	add	r3, r4, #28
	add	r8, r8, #2
	add	r2, r6, #2
	mov	r10, r3
	str	r2, [fp, #-64]
	str	r9, [fp, #-68]
.L455:
	sub	r4, r8, #768
	mov	r7, r10
.L459:
	add	r6, r4, #256
	mov	r9, r7
.L456:
	ldr	r3, [r5, #52]
	mov	r2, #64
	mov	r1, r9
	mov	r0, r4
	add	r4, r4, r2
	blx	r3
	cmp	r6, r4
	add	r9, r9, #64
	ldr	r3, .L472
	bne	.L456
	cmp	r6, r8
	add	r7, r7, #384
	mov	r4, r6
	bne	.L459
	ldr	r2, [fp, #-64]
	add	r8, r6, #768
	add	r10, r10, #1152
	cmp	r8, r2
	bne	.L455
	ldr	r9, [fp, #-68]
	mov	r2, #960
	ldr	r3, [r3, #52]
	add	r1, r9, #1216
	add	r0, r9, #3136
	add	r1, r1, #2
	add	r0, r0, #2
	blx	r3
	b	.L460
.L473:
	.align	2
.L472:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VP6_CfgTable, .-VP6_CfgTable
	.align	2
	.global	VP6_BuildTables
	.type	VP6_BuildTables, %function
VP6_BuildTables:
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
	cmp	r2, #0
	cmpne	r1, #0
	mov	r4, r1
	mov	r6, r2
	moveq	r3, #1
	movne	r3, #0
	cmp	r0, #0
	orreq	r3, r3, #1
	mov	r5, r0
	cmp	r3, #0
	bne	.L479
	ldr	r3, [r1, #20]
	cmp	r3, #0
	bne	.L483
	ldr	r7, .L485
	mov	r2, #80
	ldr	r1, .L485+4
	add	r0, r0, #404
	ldr	r3, [r7, #52]
	blx	r3
	mov	r2, #2
	ldr	r3, [r7, #52]
	add	r0, r5, r2
	ldr	r1, .L485+8
	blx	r3
	ldr	r3, [r7, #52]
	mov	r2, #14
	ldr	r1, .L485+12
	add	r0, r5, #484
	blx	r3
	ldr	r3, [r7, #52]
	mov	r2, #2
	ldr	r1, .L485+16
	mov	r0, r5
	blx	r3
	add	r0, r5, #496
	ldr	r3, [r7, #52]
	mov	r2, #16
	ldr	r1, .L485+20
	add	r0, r0, #2
	blx	r3
	ldr	r1, .L485+24
	ldr	r3, [r7, #52]
	mov	r2, #64
	add	r0, r5, #1088
	blx	r3
	mov	r1, r4
	mov	r0, r5
	bl	VP6_BuildScanOrder
.L477:
	ldr	r3, [r4, #20]
	mov	r1, r6
	mov	r2, r4
	mov	r0, r5
	bl	VP6_ConfigureEntropyDecoder
	ldr	r3, [r4, #68]
	cmp	r3, #0
	bne	.L484
.L478:
	mov	r1, r4
	mov	r0, r5
	bl	VP6_CfgTable
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L483:
	mov	r2, r1
	mov	r1, r6
	bl	VP6_DecodeModeProbs
	mov	r2, r4
	mov	r1, r6
	mov	r0, r5
	bl	VP6_ConfigureMvEntropyDecoder
	b	.L477
.L484:
	mov	r0, r5
	bl	VP6_ConvertBoolToHuff
	b	.L478
.L479:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L486:
	.align	2
.L485:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0+1996
	.word	.LANCHOR0+2076
	.word	.LANCHOR0+2080
	.word	.LANCHOR0+2096
	.word	.LANCHOR0+2100
	.word	.LANCHOR0+2116
	.fnend
	.size	VP6_BuildTables, .-VP6_BuildTables
	.align	2
	.global	IsFrameSizeChanged
	.type	IsFrameSizeChanged, %function
IsFrameSizeChanged:
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
	add	r0, r0, #8192
	ldr	r2, [r0, #3940]
	ldr	r3, [r0, #4084]
	cmp	r2, r3
	beq	.L490
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L490:
	ldr	r3, [r0, #3944]
	ldr	r0, [r0, #4088]
	subs	r0, r3, r0
	movne	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	IsFrameSizeChanged, .-IsFrameSizeChanged
	.align	2
	.global	VP6DEC_Decode
	.type	VP6DEC_Decode, %function
VP6DEC_Decode:
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
	ldr	r3, [r1]
	mov	r4, r0
	str	r3, [r0, #224]
	ldr	r2, [r1, #8]
	str	r2, [r0, #228]
	ldr	r2, [r1, #12]
	cmp	r2, #0
	str	r2, [r0, #232]
	bne	.L492
	add	r5, r0, #12288
	mov	r3, #3
	strb	r3, [r5, #28]
.L493:
	mov	r0, r4
	bl	VP6_DecodeDecide
	cmp	r0, #1
	mov	r6, r0
	beq	.L508
	ldr	r1, .L529
	mov	r0, #1
	bl	dprint_vfmw
	mov	r6, #0
.L495:
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L492:
	cmp	r2, #2
	ble	.L524
	add	r5, r0, #12608
	add	r6, r0, #236
	add	r5, r5, #24
	mov	r1, r3
	mov	r0, r5
	bl	BsInit
	add	r3, r4, #224
	mov	r1, r5
	mov	r0, r6
	str	r3, [r4, #220]
	bl	VP6_GetPictureHeader
	cmp	r0, #1
	mov	r7, r0
	beq	.L496
	ldr	r1, .L529+4
	mov	r0, #1
	bl	dprint_vfmw
	mov	r6, #0
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L508:
	mov	r0, r4
	bl	VP6_GetImageBuffer
	cmp	r0, #1
	mov	r8, r0
	beq	.L509
	mov	r0, r6
	ldr	r1, .L529+8
	bl	dprint_vfmw
	mov	r6, #0
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L524:
	ldr	r1, .L529+12
	mov	r0, #1
	bl	dprint_vfmw
	mov	r6, #0
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L496:
	add	r1, r4, #12480
	mov	r2, r5
	mov	r0, r6
	add	r1, r1, #8
	bl	VP6_BuildTables
	cmp	r0, #1
	bne	.L525
	add	r5, r4, #12288
	ldr	r3, [r5, #24]
	cmp	r3, #0
	beq	.L498
	ldr	r2, [r5, #80]
	ldr	r3, [r5, #224]
	cmp	r2, r3
	bne	.L498
	ldr	r2, [r5, #84]
	ldr	r3, [r5, #228]
	cmp	r2, r3
	beq	.L493
.L498:
	ldr	r3, .L529+16
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L500
	ldr	r0, [r5, #224]
	mov	r3, #8
	ldr	r7, [r5, #84]
	sub	r2, fp, #52
	ldr	r6, [r5, #80]
	mov	r1, #2
	ldr	lr, [r5, #228]
	strh	r0, [fp, #-46]
	strh	r7, [fp, #-52]
	strh	r6, [fp, #-50]
	strh	lr, [fp, #-48]
	ldr	r0, [r5, #728]
	blx	ip
.L500:
	mov	r2, #1
	ldr	r1, [r5, #40]
	ldr	r0, [r5, #728]
	mov	r7, #0
	bl	FSP_ClearLogicFs
	mov	r2, #1
	ldr	r1, [r5, #44]
	add	r6, r4, #12608
	ldr	r0, [r5, #728]
	add	r6, r6, #56
	bl	FSP_ClearLogicFs
	str	r7, [r5, #40]
	str	r7, [r5, #44]
	ldr	r0, [r5, #728]
	bl	FSP_GetNullLogicFs
	str	r7, [r5, #20]
	mov	r1, r6
	str	r0, [r5, #44]
	str	r0, [r5, #40]
	ldr	r0, [r5, #728]
	bl	FSP_ClearNotInVoQueue
	ldr	r2, [r5, #228]
	ldr	r3, [r5, #224]
	cmp	r2, #512
	bhi	.L502
	cmp	r3, #512
	bhi	.L502
	ldr	r3, [r4]
	ldr	r2, [r3, #700]
	cmp	r2, #0
	bne	.L504
	ldr	r3, [r3, #28]
	cmp	r3, #25
	beq	.L526
.L504:
	ldr	r0, [r5, #728]
	bl	FSP_GetFspType
	cmp	r0, #0
	beq	.L523
.L506:
	mov	r0, r4
	bl	VP6_ArrangeVHBMem
	cmp	r0, #1
	beq	.L493
	ldr	r1, .L529+20
	mov	r0, #1
	bl	dprint_vfmw
	mov	r6, #0
	b	.L495
.L509:
	mov	r2, r0
	ldr	r1, [r5, #36]
	ldr	r0, [r5, #728]
	bl	FSP_SetRef
	ldr	r1, [r5, #36]
	ldr	r0, [r5, #728]
	bl	FSP_GetFsImagePtr
	subs	lr, r0, #0
	beq	.L527
	ldr	r0, [r4]
	add	ip, lr, #576
	add	r10, lr, #592
	mov	r9, #0
	mvn	r2, #0
	mvn	r3, #0
	ldrd	r6, [r0, #56]
	mov	r0, #29
	ldr	r1, .L529+24
	strd	r6, [ip, #-8]
	ldr	r6, [r4]
	ldrd	r6, [r6, #72]
	strd	r6, [ip]
	ldr	r6, [r4]
	ldrd	r6, [r6, #88]
	strd	r6, [r10, #-8]
	ldr	r6, [r4]
	ldr	r6, [r6, #104]
	str	r6, [lr, #8]
	ldr	r6, [r4]
	ldr	r6, [r6, #108]
	str	r6, [lr, #12]
	ldr	r6, [r4]
	ldr	r6, [r6, #112]
	str	r6, [lr, #16]
	ldr	r6, [r4]
	ldr	r6, [r6, #128]
	str	r9, [lr, #96]
	str	r6, [lr, #20]
	ldr	lr, [r4]
	strd	r2, [lr, #56]
	ldrd	r6, [ip]
	ldrd	r2, [ip, #-8]
	strd	r6, [sp]
	bl	dprint_vfmw
	mov	r0, r4
	bl	VP6_Set_DecParam
	cmp	r0, #1
	mov	r6, r0
	beq	.L511
	mov	r0, r8
	ldr	r1, .L529+28
	mov	r6, r9
	bl	dprint_vfmw
	b	.L495
.L511:
	ldrb	r3, [r5, #28]
	add	r1, r4, #12480
	cmp	r3, #0
	ldr	r3, .L529+32
	beq	.L528
	ldr	r7, [r5, #68]
	add	r0, r4, #12288
	ldr	r4, [r5, #72]
	add	r1, r1, #8
	ldr	r3, [r3, #52]
	add	r0, r0, #56
	mov	r2, #144
	blx	r3
	str	r7, [r5, #68]
	str	r4, [r5, #72]
.L513:
	ldr	r1, .L529+36
	mov	r0, #22
	bl	dprint_vfmw
	b	.L495
.L502:
	ldr	r1, .L529+40
	mov	r0, #18
	bl	dprint_vfmw
	mov	r6, #0
	b	.L495
.L525:
	mov	r0, r7
	ldr	r1, .L529+44
	bl	dprint_vfmw
	mov	r6, #0
	b	.L495
.L528:
	add	r0, r4, #12288
	add	r1, r1, #8
	mov	r2, #144
	ldr	r3, [r3, #52]
	add	r0, r0, #56
	blx	r3
	b	.L513
.L527:
	movw	r2, #2769
	ldr	r1, .L529+48
	mov	r0, #22
	mov	r6, lr
	bl	dprint_vfmw
	b	.L495
.L526:
	ldr	r3, [r5, #24]
	cmp	r3, #0
	bne	.L506
.L523:
	mov	r0, r6
	bl	ResetVoQueue
	b	.L506
.L530:
	.align	2
.L529:
	.word	.LC36
	.word	.LC32
	.word	.LC37
	.word	.LC31
	.word	g_event_report
	.word	.LC35
	.word	.LC38
	.word	.LC39
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC40
	.word	.LC34
	.word	.LC33
	.word	.LC5
	.fnend
	.size	VP6DEC_Decode, .-VP6DEC_Decode
	.align	2
	.global	VP6_SetImgFormat
	.type	VP6_SetImgFormat, %function
VP6_SetImgFormat:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #8
	sub	sp, sp, #8
	push	{lr}
	bl	__gnu_mcount_nc
	add	r7, r0, #12288
	mov	r6, r0
	ldr	r1, [r7, #36]
	ldr	r0, [r7, #728]
	bl	FSP_GetFsImagePtr
	subs	r4, r0, #0
	beq	.L531
	ldrb	r3, [r7, #28]
	mov	r5, #0
	mov	r1, r5
	mov	ip, #10
	and	r3, r3, #3
	str	ip, [r4, #340]
	orr	r2, r3, #7168
	mov	ip, #1
	orr	r2, r2, #32
	str	r3, [r4, #100]
	str	r3, [r4, #104]
	mov	r3, #8
	str	r2, [r4, #108]
	str	r3, [r4, #344]
	str	r3, [r4, #352]
	str	r3, [r4, #348]
	strb	r5, [r4, #328]
	strb	ip, [r4, #335]
	strb	ip, [r4, #333]
	bl	SetAspectRatio
	ldr	r2, [r7, #228]
	mov	r2, r2, asl #4
	str	r2, [r4, #112]
	ldr	r3, [r7, #224]
	mov	r3, r3, asl #4
	str	r3, [r4, #116]
	ldr	r1, [r6]
	ldr	r1, [r1, #28]
	cmp	r1, #25
	beq	.L537
.L533:
	str	r2, [r4, #120]
	mov	r2, r2, lsr #1
	str	r3, [r4, #124]
	mov	r3, r3, lsr #1
	str	r2, [r4, #128]
	str	r3, [r4, #132]
.L531:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L537:
	ldr	r2, [r4, #140]
	mov	r3, r3, lsr #4
	ldr	ip, [r4, #44]
	add	r8, r4, #480
	add	r1, r4, #496
	mov	r0, r2, asl #4
	add	r9, ip, r2
	mul	r3, r3, r0
	add	lr, r3, ip
	str	lr, [r4, #48]
	ldrd	r6, [r8, #-8]
	add	r2, lr, r2
	mov	r0, lr
	strd	r6, [fp, #-44]
	adds	r6, r6, r3
	adc	r7, r7, r3, asr #31
	strd	r6, [r8]
	str	r2, [r4, #40]
	mov	r6, r1
	ldrd	r2, [fp, #-44]
	str	lr, [r4, #32]
	str	ip, [r4, #28]
	str	r9, [r4, #36]
	strd	r2, [r1, #-8]
	str	ip, [r4, #60]
	bl	MEM_Phy2Vir
	str	r0, [r4, #496]
	str	r5, [r6, #4]
	ldr	r1, [r4, #32]
	ldr	r2, [r4, #112]
	ldr	r3, [r4, #116]
	str	r1, [r4, #64]
	b	.L533
	.fnend
	.size	VP6_SetImgFormat, .-VP6_SetImgFormat
	.align	2
	.global	VP6DEC_VDMPostProc
	.type	VP6DEC_VDMPostProc, %function
VP6DEC_VDMPostProc:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #12
	sub	sp, sp, #12
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r2, r1
	mov	r6, r0
	mov	r5, r1
	add	r4, r6, #12288
	ldr	r1, .L574
	mov	r0, #22
	bl	dprint_vfmw
	mov	r1, r6
	mov	r0, #10
	bl	ReleasePacket
	ldr	r1, [r4, #36]
	ldr	r0, [r4, #728]
	bl	FSP_GetFsImagePtr
	subs	r3, r0, #0
	beq	.L567
	cmp	r5, #0
	blt	.L541
	cmp	r5, #100
	movlt	r2, r5
	movge	r2, #100
	str	r2, [r3, #160]
	ldr	r3, [r6]
	ldr	r3, [r3]
	cmp	r2, r3
	bhi	.L568
.L542:
	mov	r0, r6
	bl	VP6_SetImgFormat
	ldr	r3, [r4, #16]
	mov	r2, #1
	str	r2, [r4, #20]
	cmp	r3, #2
	beq	.L569
.L543:
	ldr	r1, [r4, #36]
	str	r1, [r4, #48]
.L544:
	cmn	r1, #1
	beq	.L545
	mov	r2, #1
	ldr	r0, [r4, #728]
	bl	FSP_SetDisplay
	ldr	r1, [r4, #48]
	ldr	r0, [r4, #728]
	bl	FSP_GetFsImagePtr
	subs	r7, r0, #0
	beq	.L570
	add	r3, r6, #12608
	ldr	r0, [r4, #728]
	add	r3, r3, #56
	str	r7, [sp]
	mov	r2, r6
	mov	r1, #10
	bl	InsertImgToVoQueue
	cmp	r0, #1
	mov	r5, r0
	bne	.L571
.L545:
	ldr	r3, [r4, #44]
	ldr	r2, [r4, #40]
	cmp	r3, r2
	beq	.L547
	ldr	r1, [r4, #36]
	cmp	r3, r1
	beq	.L548
	mov	r1, r3
	mov	r2, #0
	ldr	r0, [r4, #728]
	bl	FSP_SetRef
	ldr	r1, [r4, #36]
.L548:
	str	r1, [r4, #44]
	mov	r2, #1
	ldr	r0, [r4, #728]
	bl	FSP_SetRef
	ldrb	r3, [r4, #28]
	cmp	r3, #0
	bne	.L572
	ldr	r3, [r4, #40]
	ldr	r1, [r4, #36]
	cmp	r3, r1
	beq	.L551
.L573:
	mov	r1, r3
	mov	r2, #0
	ldr	r0, [r4, #728]
	bl	FSP_SetRef
	ldr	r1, [r4, #36]
.L551:
	ldr	r0, [r4, #728]
	mov	r2, #1
	str	r1, [r4, #40]
	bl	FSP_SetRef
	mov	r0, #1
.L565:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L572:
	ldr	r3, [r4, #32]
	cmp	r3, #0
	moveq	r0, #1
	beq	.L565
	ldr	r3, [r4, #40]
	ldr	r1, [r4, #36]
	cmp	r3, r1
	bne	.L573
	b	.L551
.L541:
	mov	r2, #0
	str	r2, [r3, #160]
	b	.L542
.L569:
	ldrb	r3, [r4, #28]
	cmp	r3, #0
	beq	.L543
	mvn	r3, #0
	ldr	r1, [r4, #36]
	mov	r2, #0
	str	r3, [r4, #48]
	ldr	r0, [r4, #728]
	bl	FSP_SetDisplay
	ldr	r1, [r4, #48]
	b	.L544
.L571:
	add	r10, r7, #528
	ldr	r1, [r7, #528]
	ldr	r0, [r4, #728]
	add	r6, r7, #544
	bl	FreeUsdByDec
	mov	r8, #0
	mov	r9, #0
	strd	r8, [r10]
	ldr	r1, [r7, #536]
	ldr	r0, [r4, #728]
	bl	FreeUsdByDec
	strd	r8, [r6, #-8]
	mov	r2, #0
	ldr	r1, [r4, #48]
	ldr	r0, [r4, #728]
	bl	FSP_SetDisplay
	ldr	r1, .L574+4
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, r5
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L547:
	mov	r1, r3
	ldr	r0, [r4, #728]
	bl	FSP_GetRef
	subs	r2, r0, #0
	bne	.L566
	ldr	r3, [r4, #44]
	ldr	r1, [r4, #36]
	cmp	r3, r1
	beq	.L548
	mov	r1, r3
	ldr	r0, [r4, #728]
	bl	FSP_SetRef
.L566:
	ldr	r1, [r4, #36]
	b	.L548
.L568:
	ldr	r1, .L574+8
	mov	r0, #1
	bl	dprint_vfmw
	mov	r2, #1
	ldr	r1, [r4, #40]
	mov	r5, #0
	ldr	r0, [r4, #728]
	bl	FSP_ClearLogicFs
	mov	r2, #1
	ldr	r1, [r4, #44]
	ldr	r0, [r4, #728]
	bl	FSP_ClearLogicFs
	str	r5, [r4, #40]
	str	r5, [r4, #44]
	ldr	r0, [r4, #728]
	bl	FSP_GetNullLogicFs
	str	r5, [r4, #20]
	mov	r3, r0
	mvn	r0, #0
	str	r3, [r4, #44]
	str	r3, [r4, #40]
	b	.L565
.L570:
	mov	r2, r7
	ldr	r1, .L574+12
	mov	r0, #22
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L565
.L567:
	ldr	r1, .L574+16
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L565
.L575:
	.align	2
.L574:
	.word	.LC41
	.word	.LC45
	.word	.LC43
	.word	.LC44
	.word	.LC42
	.fnend
	.size	VP6DEC_VDMPostProc, .-VP6DEC_VDMPostProc
	.align	2
	.global	VP6DEC_RecycleImage
	.type	VP6DEC_RecycleImage, %function
VP6DEC_RecycleImage:
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
	cmp	r0, #0
	mov	r5, r1
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	add	r4, r0, #12288
	mov	r2, #0
	ldr	r0, [r4, #728]
	bl	FSP_SetDisplay
	mov	r1, r5
	ldr	r0, [r4, #728]
	bl	FSP_GetFsImagePtr
	cmp	r0, #0
	beq	.L579
	add	r5, r0, #544
	add	r8, r0, #528
	ldr	r1, [r0, #528]
	mov	r6, #0
	ldr	r0, [r4, #728]
	mov	r7, #0
	bl	FreeUsdByDec
	strd	r6, [r8]
	ldr	r0, [r4, #728]
	ldr	r1, [r5, #-8]
	bl	FreeUsdByDec
	strd	r6, [r5, #-8]
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L579:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	VP6DEC_RecycleImage, .-VP6DEC_RecycleImage
	.align	2
	.global	VP6DEC_GetRemainImg
	.type	VP6DEC_GetRemainImg, %function
VP6DEC_GetRemainImg:
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
	add	r0, r0, #12608
	add	r0, r0, #56
	bl	GetVoLastImageID
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VP6DEC_GetRemainImg, .-VP6DEC_GetRemainImg
	.global	DefaultScanBands
	.global	ZrlUpdateProbs
	.global	ScanBandUpdateProbs
	.global	ZeroRunProbDefaults
	.global	VP6_AcUpdateProbs
	.global	VP6_DcUpdateProbs
	.global	DefaultSignProbs
	.global	DefaultIsShortProbs
	.global	DefaultMvLongProbs
	.global	DefaultMvShortProbs
	.global	VP6_MvUpdateProbs
	.global	VP6_BaselineXmittedProbs
	.global	VP6_ModeVq
	.global	VP6_DcNodeEqs
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	VP6_DcNodeEqs, %object
	.size	VP6_DcNodeEqs, 120
VP6_DcNodeEqs:
	.word	122
	.word	133
	.word	133
	.word	51
	.word	142
	.word	-16
	.word	0
	.word	1
	.word	0
	.word	1
	.word	0
	.word	1
	.word	78
	.word	171
	.word	169
	.word	71
	.word	221
	.word	-30
	.word	139
	.word	117
	.word	214
	.word	44
	.word	246
	.word	-3
	.word	168
	.word	79
	.word	210
	.word	38
	.word	203
	.word	17
	.type	VP6_DcUpdateProbs, %object
	.size	VP6_DcUpdateProbs, 22
VP6_DcUpdateProbs:
	.byte	-110
	.byte	-1
	.byte	-75
	.byte	-49
	.byte	-24
	.byte	-13
	.byte	-18
	.byte	-5
	.byte	-12
	.byte	-6
	.byte	-7
	.byte	-77
	.byte	-1
	.byte	-42
	.byte	-16
	.byte	-6
	.byte	-1
	.byte	-12
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.space	2
	.type	ZeroRunProbDefaults, %object
	.size	ZeroRunProbDefaults, 28
ZeroRunProbDefaults:
	.byte	-58
	.byte	-59
	.byte	-60
	.byte	-110
	.byte	-58
	.byte	-52
	.byte	-87
	.byte	-114
	.byte	-126
	.byte	-120
	.byte	-107
	.byte	-107
	.byte	-65
	.byte	-7
	.byte	-121
	.byte	-55
	.byte	-75
	.byte	-102
	.byte	98
	.byte	117
	.byte	-124
	.byte	126
	.byte	-110
	.byte	-87
	.byte	-72
	.byte	-16
	.byte	-10
	.byte	-2
	.type	ZrlUpdateProbs, %object
	.size	ZrlUpdateProbs, 28
ZrlUpdateProbs:
	.byte	-37
	.byte	-10
	.byte	-18
	.byte	-7
	.byte	-24
	.byte	-17
	.byte	-7
	.byte	-1
	.byte	-8
	.byte	-3
	.byte	-17
	.byte	-12
	.byte	-15
	.byte	-8
	.byte	-58
	.byte	-24
	.byte	-5
	.byte	-3
	.byte	-37
	.byte	-15
	.byte	-3
	.byte	-1
	.byte	-8
	.byte	-7
	.byte	-12
	.byte	-18
	.byte	-5
	.byte	-1
	.type	VP6_AcUpdateProbs, %object
	.size	VP6_AcUpdateProbs, 396
VP6_AcUpdateProbs:
	.byte	-29
	.byte	-10
	.byte	-26
	.byte	-9
	.byte	-12
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-47
	.byte	-25
	.byte	-25
	.byte	-7
	.byte	-7
	.byte	-3
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-31
	.byte	-14
	.byte	-15
	.byte	-5
	.byte	-3
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-15
	.byte	-3
	.byte	-4
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-8
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-16
	.byte	-1
	.byte	-8
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-16
	.byte	-3
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-50
	.byte	-53
	.byte	-29
	.byte	-17
	.byte	-9
	.byte	-1
	.byte	-3
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-49
	.byte	-57
	.byte	-36
	.byte	-20
	.byte	-13
	.byte	-4
	.byte	-4
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-44
	.byte	-37
	.byte	-26
	.byte	-13
	.byte	-12
	.byte	-3
	.byte	-4
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-20
	.byte	-19
	.byte	-9
	.byte	-4
	.byte	-3
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-16
	.byte	-16
	.byte	-8
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-26
	.byte	-23
	.byte	-7
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-18
	.byte	-18
	.byte	-6
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-8
	.byte	-5
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-31
	.byte	-17
	.byte	-29
	.byte	-25
	.byte	-12
	.byte	-3
	.byte	-13
	.byte	-1
	.byte	-1
	.byte	-3
	.byte	-1
	.byte	-24
	.byte	-22
	.byte	-32
	.byte	-28
	.byte	-14
	.byte	-7
	.byte	-14
	.byte	-4
	.byte	-5
	.byte	-5
	.byte	-1
	.byte	-21
	.byte	-7
	.byte	-18
	.byte	-16
	.byte	-5
	.byte	-1
	.byte	-7
	.byte	-1
	.byte	-3
	.byte	-3
	.byte	-1
	.byte	-7
	.byte	-3
	.byte	-5
	.byte	-6
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-5
	.byte	-6
	.byte	-7
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-13
	.byte	-12
	.byte	-6
	.byte	-6
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-7
	.byte	-8
	.byte	-6
	.byte	-3
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-3
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.type	ScanBandUpdateProbs, %object
	.size	ScanBandUpdateProbs, 64
ScanBandUpdateProbs:
	.byte	-1
	.byte	-124
	.byte	-124
	.byte	-97
	.byte	-103
	.byte	-105
	.byte	-95
	.byte	-86
	.byte	-92
	.byte	-94
	.byte	-120
	.byte	110
	.byte	103
	.byte	114
	.byte	-127
	.byte	118
	.byte	124
	.byte	125
	.byte	-124
	.byte	-120
	.byte	114
	.byte	110
	.byte	-114
	.byte	-121
	.byte	-122
	.byte	123
	.byte	-113
	.byte	126
	.byte	-103
	.byte	-73
	.byte	-90
	.byte	-95
	.byte	-85
	.byte	-76
	.byte	-77
	.byte	-92
	.byte	-53
	.byte	-38
	.byte	-31
	.byte	-39
	.byte	-41
	.byte	-50
	.byte	-53
	.byte	-39
	.byte	-27
	.byte	-15
	.byte	-8
	.byte	-13
	.byte	-3
	.byte	-1
	.byte	-3
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.type	VP6_ModeVq, %object
	.size	VP6_ModeVq, 960
VP6_ModeVq:
	.byte	9
	.byte	15
	.byte	32
	.byte	25
	.byte	7
	.byte	19
	.byte	9
	.byte	21
	.byte	1
	.byte	12
	.byte	14
	.byte	12
	.byte	3
	.byte	18
	.byte	14
	.byte	23
	.byte	3
	.byte	10
	.byte	0
	.byte	4
	.byte	48
	.byte	39
	.byte	1
	.byte	2
	.byte	11
	.byte	27
	.byte	29
	.byte	44
	.byte	7
	.byte	27
	.byte	1
	.byte	4
	.byte	0
	.byte	3
	.byte	1
	.byte	6
	.byte	1
	.byte	2
	.byte	0
	.byte	0
	.byte	21
	.byte	32
	.byte	1
	.byte	2
	.byte	4
	.byte	10
	.byte	32
	.byte	43
	.byte	6
	.byte	23
	.byte	2
	.byte	3
	.byte	1
	.byte	19
	.byte	1
	.byte	6
	.byte	12
	.byte	21
	.byte	0
	.byte	7
	.byte	69
	.byte	83
	.byte	0
	.byte	0
	.byte	0
	.byte	2
	.byte	10
	.byte	29
	.byte	3
	.byte	12
	.byte	0
	.byte	1
	.byte	0
	.byte	3
	.byte	0
	.byte	3
	.byte	2
	.byte	2
	.byte	0
	.byte	0
	.byte	11
	.byte	20
	.byte	1
	.byte	4
	.byte	18
	.byte	36
	.byte	43
	.byte	48
	.byte	13
	.byte	35
	.byte	0
	.byte	2
	.byte	0
	.byte	5
	.byte	3
	.byte	12
	.byte	1
	.byte	2
	.byte	0
	.byte	0
	.byte	70
	.byte	44
	.byte	0
	.byte	1
	.byte	2
	.byte	10
	.byte	37
	.byte	46
	.byte	8
	.byte	26
	.byte	0
	.byte	2
	.byte	0
	.byte	2
	.byte	0
	.byte	2
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	8
	.byte	15
	.byte	0
	.byte	1
	.byte	8
	.byte	21
	.byte	74
	.byte	53
	.byte	22
	.byte	42
	.byte	0
	.byte	1
	.byte	0
	.byte	2
	.byte	0
	.byte	3
	.byte	1
	.byte	2
	.byte	0
	.byte	0
	.byte	-115
	.byte	42
	.byte	0
	.byte	0
	.byte	1
	.byte	4
	.byte	11
	.byte	24
	.byte	1
	.byte	11
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	2
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	19
	.byte	4
	.byte	10
	.byte	24
	.byte	45
	.byte	21
	.byte	37
	.byte	9
	.byte	29
	.byte	0
	.byte	3
	.byte	1
	.byte	7
	.byte	11
	.byte	25
	.byte	0
	.byte	2
	.byte	0
	.byte	1
	.byte	46
	.byte	42
	.byte	0
	.byte	1
	.byte	2
	.byte	10
	.byte	54
	.byte	51
	.byte	10
	.byte	30
	.byte	0
	.byte	2
	.byte	0
	.byte	2
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	28
	.byte	32
	.byte	0
	.byte	0
	.byte	3
	.byte	10
	.byte	75
	.byte	51
	.byte	14
	.byte	33
	.byte	0
	.byte	1
	.byte	0
	.byte	2
	.byte	0
	.byte	1
	.byte	1
	.byte	2
	.byte	0
	.byte	0
	.byte	100
	.byte	46
	.byte	0
	.byte	1
	.byte	3
	.byte	9
	.byte	21
	.byte	37
	.byte	5
	.byte	20
	.byte	0
	.byte	1
	.byte	0
	.byte	2
	.byte	1
	.byte	2
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	27
	.byte	29
	.byte	0
	.byte	1
	.byte	9
	.byte	25
	.byte	53
	.byte	51
	.byte	12
	.byte	34
	.byte	0
	.byte	1
	.byte	0
	.byte	3
	.byte	1
	.byte	5
	.byte	0
	.byte	2
	.byte	0
	.byte	0
	.byte	80
	.byte	38
	.byte	0
	.byte	0
	.byte	1
	.byte	4
	.byte	69
	.byte	33
	.byte	5
	.byte	16
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	16
	.byte	20
	.byte	0
	.byte	0
	.byte	2
	.byte	8
	.byte	104
	.byte	49
	.byte	15
	.byte	33
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	1
	.byte	0
	.byte	0
	.byte	-62
	.byte	16
	.byte	0
	.byte	0
	.byte	1
	.byte	1
	.byte	1
	.byte	9
	.byte	1
	.byte	3
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	41
	.byte	22
	.byte	1
	.byte	0
	.byte	1
	.byte	31
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	1
	.byte	7
	.byte	0
	.byte	1
	.byte	98
	.byte	25
	.byte	4
	.byte	10
	.byte	123
	.byte	37
	.byte	6
	.byte	4
	.byte	1
	.byte	27
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	5
	.byte	8
	.byte	1
	.byte	7
	.byte	0
	.byte	1
	.byte	12
	.byte	10
	.byte	0
	.byte	2
	.byte	26
	.byte	14
	.byte	14
	.byte	12
	.byte	0
	.byte	24
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	55
	.byte	17
	.byte	1
	.byte	9
	.byte	0
	.byte	36
	.byte	5
	.byte	7
	.byte	1
	.byte	3
	.byte	-47
	.byte	5
	.byte	0
	.byte	0
	.byte	0
	.byte	27
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	2
	.byte	5
	.byte	4
	.byte	5
	.byte	0
	.byte	121
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	3
	.byte	2
	.byte	4
	.byte	1
	.byte	4
	.byte	2
	.byte	2
	.byte	0
	.byte	1
	.byte	-81
	.byte	5
	.byte	0
	.byte	1
	.byte	0
	.byte	48
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	2
	.byte	0
	.byte	1
	.byte	0
	.byte	2
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	83
	.byte	5
	.byte	2
	.byte	3
	.byte	0
	.byte	102
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	3
	.byte	0
	.byte	2
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-23
	.byte	6
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	34
	.byte	16
	.byte	112
	.byte	21
	.byte	1
	.byte	28
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	6
	.byte	8
	.byte	1
	.byte	7
	.byte	0
	.byte	3
	.byte	2
	.byte	5
	.byte	0
	.byte	2
	.byte	-97
	.byte	35
	.byte	2
	.byte	2
	.byte	0
	.byte	25
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	3
	.byte	6
	.byte	0
	.byte	5
	.byte	0
	.byte	1
	.byte	4
	.byte	4
	.byte	0
	.byte	1
	.byte	75
	.byte	39
	.byte	5
	.byte	7
	.byte	2
	.byte	48
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	3
	.byte	11
	.byte	2
	.byte	16
	.byte	1
	.byte	4
	.byte	7
	.byte	10
	.byte	0
	.byte	2
	.byte	-44
	.byte	21
	.byte	0
	.byte	1
	.byte	0
	.byte	9
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	2
	.byte	0
	.byte	2
	.byte	0
	.byte	0
	.byte	2
	.byte	2
	.byte	0
	.byte	0
	.byte	4
	.byte	2
	.byte	0
	.byte	0
	.byte	0
	.byte	-84
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	2
	.byte	0
	.byte	0
	.byte	2
	.byte	0
	.byte	0
	.byte	0
	.byte	-69
	.byte	22
	.byte	1
	.byte	1
	.byte	0
	.byte	17
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	3
	.byte	6
	.byte	0
	.byte	4
	.byte	0
	.byte	1
	.byte	4
	.byte	4
	.byte	0
	.byte	1
	.byte	-123
	.byte	6
	.byte	1
	.byte	2
	.byte	1
	.byte	70
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	2
	.byte	0
	.byte	4
	.byte	0
	.byte	3
	.byte	1
	.byte	1
	.byte	0
	.byte	0
	.byte	-5
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	2
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.byte	0
	.byte	2
	.byte	0
	.byte	2
	.byte	0
	.byte	0
	.byte	11
	.byte	4
	.byte	1
	.byte	4
	.byte	0
	.byte	2
	.byte	3
	.byte	2
	.byte	0
	.byte	4
	.byte	49
	.byte	46
	.byte	3
	.byte	4
	.byte	7
	.byte	31
	.byte	42
	.byte	41
	.byte	0
	.byte	0
	.byte	2
	.byte	6
	.byte	1
	.byte	7
	.byte	1
	.byte	4
	.byte	2
	.byte	4
	.byte	0
	.byte	1
	.byte	26
	.byte	25
	.byte	1
	.byte	1
	.byte	2
	.byte	10
	.byte	67
	.byte	39
	.byte	0
	.byte	0
	.byte	1
	.byte	1
	.byte	0
	.byte	14
	.byte	0
	.byte	2
	.byte	31
	.byte	26
	.byte	1
	.byte	6
	.byte	103
	.byte	46
	.byte	1
	.byte	2
	.byte	2
	.byte	10
	.byte	33
	.byte	42
	.byte	0
	.byte	0
	.byte	1
	.byte	4
	.byte	0
	.byte	3
	.byte	0
	.byte	1
	.byte	1
	.byte	3
	.byte	0
	.byte	0
	.byte	14
	.byte	31
	.byte	9
	.byte	13
	.byte	14
	.byte	54
	.byte	22
	.byte	29
	.byte	0
	.byte	0
	.byte	2
	.byte	6
	.byte	4
	.byte	18
	.byte	6
	.byte	13
	.byte	1
	.byte	5
	.byte	0
	.byte	1
	.byte	85
	.byte	39
	.byte	0
	.byte	0
	.byte	1
	.byte	9
	.byte	69
	.byte	40
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	3
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	0
	.byte	0
	.byte	31
	.byte	28
	.byte	0
	.byte	0
	.byte	3
	.byte	14
	.byte	-126
	.byte	34
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	3
	.byte	0
	.byte	1
	.byte	3
	.byte	3
	.byte	0
	.byte	1
	.byte	-85
	.byte	25
	.byte	0
	.byte	0
	.byte	1
	.byte	5
	.byte	25
	.byte	21
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	17
	.byte	21
	.byte	68
	.byte	29
	.byte	6
	.byte	15
	.byte	13
	.byte	22
	.byte	0
	.byte	0
	.byte	6
	.byte	12
	.byte	3
	.byte	14
	.byte	4
	.byte	10
	.byte	1
	.byte	7
	.byte	0
	.byte	3
	.byte	51
	.byte	39
	.byte	0
	.byte	1
	.byte	2
	.byte	12
	.byte	91
	.byte	44
	.byte	0
	.byte	0
	.byte	0
	.byte	2
	.byte	0
	.byte	3
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	0
	.byte	1
	.byte	81
	.byte	25
	.byte	0
	.byte	0
	.byte	2
	.byte	9
	.byte	106
	.byte	26
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	1
	.byte	0
	.byte	0
	.byte	-116
	.byte	37
	.byte	0
	.byte	1
	.byte	1
	.byte	8
	.byte	24
	.byte	33
	.byte	0
	.byte	0
	.byte	1
	.byte	2
	.byte	0
	.byte	2
	.byte	0
	.byte	1
	.byte	1
	.byte	2
	.byte	0
	.byte	0
	.byte	14
	.byte	23
	.byte	1
	.byte	3
	.byte	11
	.byte	53
	.byte	90
	.byte	31
	.byte	0
	.byte	0
	.byte	0
	.byte	3
	.byte	1
	.byte	5
	.byte	2
	.byte	6
	.byte	1
	.byte	2
	.byte	0
	.byte	0
	.byte	123
	.byte	29
	.byte	0
	.byte	0
	.byte	1
	.byte	7
	.byte	57
	.byte	30
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	13
	.byte	14
	.byte	0
	.byte	0
	.byte	4
	.byte	20
	.byte	-81
	.byte	20
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	1
	.byte	0
	.byte	0
	.byte	-54
	.byte	23
	.byte	0
	.byte	0
	.byte	1
	.byte	3
	.byte	2
	.byte	9
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.type	VP6_MvUpdateProbs, %object
	.size	VP6_MvUpdateProbs, 34
VP6_MvUpdateProbs:
	.byte	-19
	.byte	-10
	.byte	-3
	.byte	-3
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-6
	.byte	-6
	.byte	-4
	.byte	-25
	.byte	-13
	.byte	-11
	.byte	-3
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-5
	.byte	-5
	.byte	-2
	.space	2
	.type	VP6_LoopFilterLimitValues, %object
	.size	VP6_LoopFilterLimitValues, 64
VP6_LoopFilterLimitValues:
	.byte	14
	.byte	14
	.byte	13
	.byte	13
	.byte	12
	.byte	12
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	2
	.type	DcQuantTab, %object
	.size	DcQuantTab, 128
DcQuantTab:
	.short	188
	.short	188
	.short	188
	.short	188
	.short	180
	.short	172
	.short	172
	.short	172
	.short	172
	.short	172
	.short	168
	.short	164
	.short	164
	.short	160
	.short	160
	.short	160
	.short	160
	.short	140
	.short	140
	.short	140
	.short	140
	.short	132
	.short	132
	.short	132
	.short	132
	.short	128
	.short	128
	.short	128
	.short	108
	.short	108
	.short	104
	.short	104
	.short	100
	.short	100
	.short	96
	.short	96
	.short	92
	.short	92
	.short	76
	.short	76
	.short	76
	.short	76
	.short	72
	.short	72
	.short	68
	.short	64
	.short	64
	.short	64
	.short	64
	.short	64
	.short	60
	.short	44
	.short	44
	.short	44
	.short	40
	.short	40
	.short	36
	.short	32
	.short	28
	.short	20
	.short	12
	.short	12
	.short	8
	.short	8
	.type	AcQuantTab, %object
	.size	AcQuantTab, 128
AcQuantTab:
	.short	376
	.short	368
	.short	360
	.short	352
	.short	344
	.short	328
	.short	312
	.short	296
	.short	280
	.short	264
	.short	248
	.short	232
	.short	216
	.short	212
	.short	208
	.short	204
	.short	200
	.short	196
	.short	192
	.short	188
	.short	184
	.short	180
	.short	176
	.short	172
	.short	168
	.short	160
	.short	156
	.short	148
	.short	144
	.short	140
	.short	136
	.short	132
	.short	128
	.short	124
	.short	120
	.short	116
	.short	112
	.short	108
	.short	104
	.short	100
	.short	96
	.short	92
	.short	88
	.short	84
	.short	80
	.short	76
	.short	72
	.short	68
	.short	64
	.short	60
	.short	56
	.short	52
	.short	48
	.short	44
	.short	40
	.short	36
	.short	32
	.short	28
	.short	24
	.short	20
	.short	16
	.short	12
	.short	8
	.short	4
	.type	__FUNCTION__.15038, %object
	.size	__FUNCTION__.15038, 17
__FUNCTION__.15038:
	.ascii	"VP6_DecodeDecide\000"
	.space	3
	.type	VP6_BaselineXmittedProbs, %object
	.size	VP6_BaselineXmittedProbs, 80
VP6_BaselineXmittedProbs:
	.byte	42
	.byte	2
	.byte	7
	.byte	42
	.byte	22
	.byte	3
	.byte	2
	.byte	5
	.byte	1
	.byte	0
	.byte	69
	.byte	1
	.byte	1
	.byte	44
	.byte	6
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	8
	.byte	1
	.byte	8
	.byte	0
	.byte	0
	.byte	2
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	-27
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	35
	.byte	1
	.byte	6
	.byte	34
	.byte	0
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.byte	0
	.byte	122
	.byte	1
	.byte	1
	.byte	46
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	64
	.byte	0
	.byte	64
	.byte	64
	.byte	64
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	64
	.byte	0
	.byte	64
	.byte	64
	.byte	64
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.type	DefaultIsShortProbs, %object
	.size	DefaultIsShortProbs, 2
DefaultIsShortProbs:
	.byte	-94
	.byte	-92
	.space	2
	.type	DefaultMvShortProbs, %object
	.size	DefaultMvShortProbs, 14
DefaultMvShortProbs:
	.byte	-31
	.byte	-110
	.byte	-84
	.byte	-109
	.byte	-42
	.byte	39
	.byte	-100
	.byte	-52
	.byte	-86
	.byte	119
	.byte	-21
	.byte	-116
	.byte	-26
	.byte	-28
	.space	2
	.type	DefaultSignProbs, %object
	.size	DefaultSignProbs, 2
DefaultSignProbs:
	.byte	-128
	.byte	-128
	.space	2
	.type	DefaultMvLongProbs, %object
	.size	DefaultMvLongProbs, 16
DefaultMvLongProbs:
	.byte	-9
	.byte	-46
	.byte	-121
	.byte	68
	.byte	-118
	.byte	-36
	.byte	-17
	.byte	-10
	.byte	-12
	.byte	-72
	.byte	-55
	.byte	44
	.byte	-83
	.byte	-35
	.byte	-17
	.byte	-3
	.type	DefaultScanBands, %object
	.size	DefaultScanBands, 64
DefaultScanBands:
	.byte	0
	.byte	0
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	3
	.byte	3
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	6
	.byte	6
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	8
	.byte	8
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	10
	.byte	10
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	13
	.byte	13
	.byte	13
	.byte	13
	.byte	13
	.byte	14
	.byte	14
	.byte	14
	.byte	14
	.byte	15
	.byte	15
	.byte	15
	.byte	15
	.byte	15
	.byte	15
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"image_size_in_mb abnormal(%d x %d)\012\000"
.LC1:
	.ascii	"vp6 actual frame size(%dx%d) exeed max config(%dx%d"
	.ascii	")\012\000"
	.space	2
.LC2:
	.ascii	"partition fs memory fail!\012\000"
	.space	1
.LC3:
	.ascii	"FSP_ConfigInstance fail!\012\000"
	.space	2
.LC4:
	.ascii	"get frame store fail!\012\000"
	.space	1
.LC5:
	.ascii	"line: %d, pImage is NULL!\012\000"
	.space	1
.LC6:
	.ascii	"get image buffer ok: LogicFsID = %d\012\000"
	.space	3
.LC7:
	.ascii	"decode %p, disp %p, tf %p\012\000"
	.space	1
.LC8:
	.ascii	"enter VP6_ConvertBoolToHuff\012\000"
	.space	3
.LC9:
	.ascii	"leave VP6_ConvertBoolToHuff\012\000"
	.space	3
.LC10:
	.ascii	"enter VP6_IntraFrmHeader\012\000"
	.space	2
.LC11:
	.ascii	"error: Vp3VersionNo %d > CURRENT_DECODE_VERSION(8)\012"
	.ascii	"\000"
.LC12:
	.ascii	"error: bitstream error!\012\000"
	.space	3
.LC13:
	.ascii	"We have a new size image!\012 The old size is %d x "
	.ascii	"%d, and the new is %d x %d\012\000"
.LC14:
	.ascii	"leave VP6_IntraFrmHeader\012\000"
	.space	2
.LC15:
	.ascii	"VP6_InterFrmHeader VersionNo fault,old:%d,new:%d\012"
	.ascii	"\000"
	.space	2
.LC16:
	.ascii	"[ERR]VP6_GetPictureHeader invalid param!\012\000"
	.space	2
.LC17:
	.ascii	"VP6_GetPictureHeader enter!\012\000"
	.space	3
.LC18:
	.ascii	"VP6_GetPictureHeader leave!\012\000"
	.space	3
.LC19:
	.ascii	"-1 == VCTRL_GetChanIDByCtx() Err! \012\000"
.LC20:
	.ascii	"VP6DEC_Init leave\012\000"
	.space	1
.LC21:
	.ascii	"ERROR: No Img buffer is allocated\012\000"
	.space	1
.LC22:
	.ascii	"----------------- vp6 Imode -> %d -----------------"
	.ascii	"-\012\000"
	.space	2
.LC23:
	.ascii	"-----I_MODE, but FrameType is %d-----\012\000"
	.space	1
.LC24:
	.ascii	"P-frm\000"
	.space	2
.LC25:
	.ascii	"-----cur framtype is %s, but refnum=%d-----\012\000"
	.space	3
.LC26:
	.ascii	"error: DecMode illegal\012\000"
.LC27:
	.ascii	"%s %d NULL == pFwdImg!!\012\000"
	.space	3
.LC28:
	.ascii	"dec P frame, fwd ref err(%d) > ref_thr(%d)\012\000"
.LC29:
	.ascii	"VP6_Set_DecParam but logic fs is null!\012\000"
.LC30:
	.ascii	"Decord FS is NULL!\012\000"
.LC31:
	.ascii	"Error! Truncated packet\012\000"
	.space	3
.LC32:
	.ascii	"[ERR]VP6_GetPictureHeader Error!\012\000"
	.space	2
.LC33:
	.ascii	"[ERR] VP6_DecodeDecide Error!\012\000"
	.space	1
.LC34:
	.ascii	"pic width/height to large,MbWidth = %d, MbHeight = "
	.ascii	"%d\000"
	.space	2
.LC35:
	.ascii	"VP6_ArrangeVHBMem err\012\000"
	.space	1
.LC36:
	.ascii	"VP6_DecodeDecide err\012\000"
	.space	2
.LC37:
	.ascii	"VP6DEC_GetImageBuffer err\012\000"
	.space	1
.LC38:
	.ascii	"dec_pts: %lld Usertag = %lld\012\000"
	.space	2
.LC39:
	.ascii	"VP6_PrePare_decode Error!\012\000"
	.space	1
.LC40:
	.ascii	"leave VP6DEC_Decode\012\000"
	.space	3
.LC41:
	.ascii	"ErrRatio = %d\012\000"
	.space	1
.LC42:
	.ascii	"pCurImg is null\012\000"
	.space	3
.LC43:
	.ascii	"err_level(%d) over ref_thr(%d)\012\000"
.LC44:
	.ascii	"line: %d pToQueImg is null!\012\000"
	.space	3
.LC45:
	.ascii	"insert img to Voqueue failed!\012\000"
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
