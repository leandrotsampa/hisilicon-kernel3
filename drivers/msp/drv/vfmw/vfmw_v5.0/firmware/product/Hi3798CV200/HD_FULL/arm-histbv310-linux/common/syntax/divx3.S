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
	.file	"divx3.c"

	.text
	.align	2
	.global	Divx3_GetImageBuffer
	.type	Divx3_GetImageBuffer, %function
Divx3_GetImageBuffer:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #8
	sub	sp, sp, #8
	push	{lr}
	bl	__gnu_mcount_nc
	add	r4, r0, #36864
	mov	r5, r0
	mov	r1, #1
	ldr	r0, [r4, #2944]
	bl	FSP_NewLogicFs
	cmp	r0, #0
	str	r0, [r4, #2548]
	blt	.L9
	mov	r1, r0
	ldr	r0, [r4, #2944]
	bl	FSP_GetLogicFs
	subs	r5, r0, #0
	beq	.L10
	ldr	r2, [r4, #2548]
	mov	r0, #18
	ldr	r1, .L11
	bl	dprint_vfmw
	ldr	r2, [r5, #608]
	cmp	r2, #0
	beq	.L7
	ldr	r3, [r5, #612]
	cmp	r3, #0
	beq	.L7
	ldr	r1, [r5, #616]
	cmp	r1, #0
	beq	.L7
	ldr	ip, [r1, #16]
	mov	r0, #18
	ldr	r3, [r3, #16]
	mov	r5, #1
	ldr	r2, [r2, #16]
	ldr	r1, .L11+4
	str	ip, [sp]
	bl	dprint_vfmw
.L3:
	mov	r0, r5
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L7:
	mov	r5, #1
	mov	r0, r5
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L9:
	ldr	r1, .L11+8
	mov	r0, #0
	bl	dprint_vfmw
	add	r1, r5, #39424
	add	r1, r1, #32
	ldr	r0, [r4, #2944]
	bl	FSP_ClearNotInVoQueue
	mov	r2, #1
	ldr	r1, [r4, #2544]
	mov	r5, #0
	ldr	r0, [r4, #2944]
	bl	FSP_ClearLogicFs
	str	r5, [r4, #2544]
	ldr	r0, [r4, #2944]
	bl	FSP_GetNullLogicFs
	str	r5, [r4, #2460]
	str	r0, [r4, #2544]
	mov	r0, r5
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L10:
	mov	r2, #100
	ldr	r1, .L11+12
	bl	dprint_vfmw
	b	.L3
.L12:
	.align	2
.L11:
	.word	.LC2
	.word	.LC3
	.word	.LC0
	.word	.LC1
	.fnend
	.size	Divx3_GetImageBuffer, .-Divx3_GetImageBuffer
	.align	2
	.global	Divx3_ArrangeVHBMem
	.type	Divx3_ArrangeVHBMem, %function
Divx3_ArrangeVHBMem:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #48
	sub	sp, sp, #48
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r5, r1
	ldr	r1, [r2, #48]
	ldr	r3, [r2, #52]
	cmp	r1, #1
	bls	.L15
	cmp	r3, #1
	bls	.L15
	ldr	r1, [r5]
	ldr	r3, [r1, #700]
	cmp	r3, #0
	ldr	r3, [r1, #28]
	bne	.L18
	cmp	r3, #25
	beq	.L39
.L19:
	ldr	r6, [r2, #56]
	mov	r7, #5
	ldr	r9, [r2, #60]
	mov	r4, #2
	mov	r8, #4
.L24:
	ldr	r3, .L44
	mov	r2, #32
	mov	r1, #0
	sub	r0, fp, #68
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r3, [r5]
	mov	r2, #0
	str	r6, [fp, #-60]
	str	r9, [fp, #-56]
	ldr	r3, [r3, #28]
	strb	r2, [fp, #-67]
	cmp	r3, #24
	beq	.L30
	uxtb	r3, r4
	strb	r8, [fp, #-65]
	strb	r7, [fp, #-63]
.L32:
	add	r6, r5, #36864
	sub	r1, fp, #68
	strb	r3, [fp, #-62]
	mov	r4, #0
	ldr	r0, [r6, #2944]
	strb	r4, [fp, #-66]
	bl	FSP_ConfigInstance
	subs	r7, r0, #0
	beq	.L40
.L38:
	mov	r0, #0
.L37:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L18:
	cmp	r3, #25
	bne	.L19
	ldr	r6, [r2, #56]
	ldr	r0, [r1, #660]
	cmp	r6, r0
	bhi	.L41
	ldr	r3, [r2, #60]
	ldr	ip, [r1, #664]
	cmp	r3, ip
	bhi	.L27
	ldr	r2, [r1, #688]
	mov	r9, r3
	ldr	r4, [r1, #684]
	cmp	r2, #0
	add	r8, r4, #2
	bne	.L42
.L35:
	mov	r4, #1
.L29:
	ldrb	r7, [r1, #708]
	b	.L24
.L15:
	mov	r2, r1
	mov	r0, #0
	ldr	r1, .L44+4
	bl	dprint_vfmw
	b	.L38
.L40:
	ldr	r1, [r5]
	sub	r3, fp, #72
	ldr	r0, [r6, #2944]
	ldr	r2, [r1, #24]
	ldr	r1, [r1, #20]
	bl	FSP_ConfigFrameBuf
	cmp	r0, r4
	moveq	r0, #1
	streqb	r0, [r5, #186]
	beq	.L37
	ldr	r1, .L44+8
	mov	r0, r7
	bl	dprint_vfmw
	mov	r0, r7
	b	.L37
.L30:
	mov	r3, #1
	strb	r7, [fp, #-63]
	strb	r3, [fp, #-65]
	b	.L32
.L39:
	ldr	r0, [r2, #56]
	ldr	r6, [r1, #660]
	cmp	r0, r6
	bhi	.L43
	ldr	r3, [r2, #60]
	ldr	r9, [r1, #664]
	cmp	r3, r9
	bhi	.L21
	ldrb	r0, [r5, #186]
	cmp	r0, #1
	beq	.L37
	ldr	r2, [r1, #688]
	ldr	r3, [r1, #684]
	cmp	r2, #0
	add	r8, r3, #2
	beq	.L35
	add	r3, r3, #1
	cmp	r3, #17
	movlt	r4, r3
	movge	r4, #17
	b	.L29
.L41:
	ldr	ip, [r1, #664]
	ldr	r3, [r2, #60]
.L27:
	stmia	sp, {r0, ip}
	mov	r2, r6
	ldr	r1, .L44+12
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #0
	b	.L37
.L43:
	ldr	r9, [r1, #664]
	ldr	r3, [r2, #60]
.L21:
	mov	r2, r0
	stmia	sp, {r6, r9}
	ldr	r1, .L44+12
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #0
	b	.L37
.L42:
	add	r3, r4, #1
	cmp	r3, #17
	movlt	r4, r3
	movge	r4, #17
	b	.L29
.L45:
	.align	2
.L44:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC4
	.word	.LC6
	.word	.LC5
	.fnend
	.size	Divx3_ArrangeVHBMem, .-Divx3_ArrangeVHBMem
	.align	2
	.global	Divx3_SetImgFormat
	.type	Divx3_SetImgFormat, %function
Divx3_SetImgFormat:
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
	add	r6, r0, #36864
	mov	r7, r0
	ldr	r1, [r6, #2548]
	ldr	r0, [r6, #2944]
	bl	FSP_GetFsImagePtr
	subs	r4, r0, #0
	beq	.L46
	ldr	r3, [r6, #2336]
	mov	r5, #0
	str	r5, [r4, #96]
	mov	r1, r5
	and	r3, r3, #3
	str	r3, [r4, #100]
	orr	r2, r3, #7168
	str	r3, [r4, #104]
	orr	r2, r2, #32
	str	r2, [r4, #108]
	ldr	r3, [r6, #2384]
	mov	r3, r3, asl #4
	str	r3, [r4, #112]
	ldr	r3, [r6, #2388]
	mov	r3, r3, asl #4
	str	r3, [r4, #116]
	bl	SetAspectRatio
	ldr	r3, [r7]
	ldr	r3, [r3, #28]
	cmp	r3, #25
	beq	.L52
.L48:
	mov	r2, #5
	mov	r3, #0
	str	r2, [r4, #340]
	mov	r2, #1
	strb	r3, [r4, #328]
	mov	r3, #8
	strb	r2, [r4, #335]
	strb	r2, [r4, #333]
	str	r3, [r4, #344]
	str	r3, [r4, #352]
	str	r3, [r4, #348]
.L46:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L52:
	ldr	r3, [r4, #116]
	add	r8, r4, #480
	ldr	r2, [r4, #140]
	add	r1, r4, #496
	add	r3, r3, #15
	ldr	ip, [r4, #44]
	mov	r0, r2, asl #4
	mov	r3, r3, lsr #4
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
	ldr	r3, [r4, #32]
	str	r3, [r4, #64]
	b	.L48
	.fnend
	.size	Divx3_SetImgFormat, .-Divx3_SetImgFormat
	.align	2
	.global	Divx3_RecordVFMWState
	.type	Divx3_RecordVFMWState, %function
Divx3_RecordVFMWState:
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
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Divx3_RecordVFMWState, .-Divx3_RecordVFMWState
	.align	2
	.global	Divx3_WritePicMsg
	.type	Divx3_WritePicMsg, %function
Divx3_WritePicMsg:
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
	add	r3, r0, #36864
	ldr	r2, [r3, #2336]
	str	r2, [r0, #12]
	ldr	r2, [r3, #2384]
	str	r2, [r0, #16]
	ldr	r2, [r3, #2388]
	str	r2, [r0, #20]
	ldr	r2, [r3, #2340]
	str	r2, [r0, #24]
	ldr	r2, [r3, #2344]
	str	r2, [r0, #28]
	ldr	r2, [r3, #2352]
	str	r2, [r0, #32]
	ldr	r2, [r3, #2360]
	str	r2, [r0, #36]
	ldr	r2, [r3, #2364]
	str	r2, [r0, #40]
	ldr	r2, [r3, #2368]
	str	r2, [r0, #44]
	ldr	r2, [r3, #2372]
	str	r2, [r0, #48]
	ldr	r2, [r3, #2376]
	str	r2, [r0, #52]
	ldr	r3, [r3, #2380]
	str	r3, [r0, #56]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Divx3_WritePicMsg, .-Divx3_WritePicMsg
	.align	2
	.global	Divx3_WriteReg
	.type	Divx3_WriteReg, %function
Divx3_WriteReg:
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
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Divx3_WriteReg, .-Divx3_WriteReg
	.align	2
	.global	Divx3_DecodeDecide
	.type	Divx3_DecodeDecide, %function
Divx3_DecodeDecide:
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
	ldrb	r5, [r0, #186]
	add	r6, r0, #36864
	mov	r4, r0
	cmp	r5, #0
	ldr	r7, [r6, #2336]
	beq	.L85
	ldrb	r3, [r0, #187]
	sub	r3, r3, #2
	cmp	r3, #1
	ldr	r3, [r0]
	ldr	r2, [r3, #8]
	bls	.L86
.L60:
	uxtb	r3, r2
	strb	r3, [r4, #187]
	cmp	r3, #4
	ldrls	pc, [pc, r3, asl #2]
	b	.L66
.L68:
	.word	.L64
	.word	.L64
	.word	.L61
	.word	.L63
	.word	.L64
.L87:
	mov	r2, r7
	ldr	r1, .L90
	mov	r0, #18
	bl	dprint_vfmw
.L63:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L86:
	cmp	r2, #4
	cmpne	r2, #1
	bhi	.L60
	ldr	r1, .L90+4
	mov	r0, #2
	bl	dprint_vfmw
	mov	r2, #1
	ldr	r1, [r6, #2544]
	mov	r5, #0
	ldr	r0, [r6, #2944]
	bl	FSP_ClearLogicFs
	str	r5, [r6, #2544]
	ldr	r0, [r6, #2944]
	bl	FSP_GetNullLogicFs
	str	r5, [r6, #2460]
	str	r0, [r6, #2544]
	ldr	r3, [r4]
	ldr	r2, [r3, #8]
	b	.L60
.L85:
	ldr	r1, .L90+8
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L61:
	cmp	r7, #0
	bne	.L87
.L62:
	ldr	r1, [r6, #2544]
	ldr	r0, [r6, #2944]
	bl	FSP_GetFsImagePtr
.L83:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L64:
	cmp	r7, #0
	beq	.L62
	ldr	r3, [r6, #2460]
	cmp	r3, #0
	beq	.L88
	ldr	r1, [r6, #2544]
	ldr	r0, [r6, #2944]
	bl	FSP_GetFsImagePtr
	subs	r5, r0, #0
	beq	.L89
	ldr	r3, [r4]
	ldr	r2, [r5, #160]
	ldr	r3, [r3]
	cmp	r2, r3
	bls	.L83
	ldr	r1, .L90+12
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L66:
	ldr	r1, .L90+16
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L88:
	ldr	r2, .L90+20
	mov	r0, #18
	ldr	r1, .L90+24
	bl	dprint_vfmw
	b	.L63
.L89:
	movw	r3, #453
	ldr	r2, .L90+28
	ldr	r1, .L90+32
	bl	dprint_vfmw
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L91:
	.align	2
.L90:
	.word	.LC9
	.word	.LC8
	.word	.LC7
	.word	.LC14
	.word	.LC12
	.word	.LC10
	.word	.LC11
	.word	.LANCHOR0
	.word	.LC13
	.fnend
	.size	Divx3_DecodeDecide, .-Divx3_DecodeDecide
	.align	2
	.global	Divx3_GetPictureHeader
	.type	Divx3_GetPictureHeader, %function
Divx3_GetPictureHeader:
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
	mov	r4, r1
	mov	r1, #2
	mov	r6, r2
	mov	r5, r0
	bl	BsGet
	cmp	r0, #1
	str	r0, [r4]
	bls	.L93
.L96:
	mov	r3, #0
.L94:
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L93:
	mov	r1, #5
	mov	r0, r5
	bl	BsGet
	ldr	r3, [r4]
	cmp	r3, #0
	str	r0, [r4, #4]
	beq	.L114
	cmp	r6, #0
	mov	r1, #1
	streq	r6, [r4, #8]
	mov	r0, r5
	ldrne	r3, [r4, #8]
	str	r6, [r4, #20]
	rsbne	r3, r3, #1
	strne	r3, [r4, #8]
	bl	BsGet
	mov	r1, #2
	str	r0, [r4, #16]
	mov	r0, r5
	bl	BsShow
	str	r0, [r4, #36]
	cmp	r0, #3
	ldrls	pc, [pc, r0, asl #2]
	b	.L109
.L111:
	.word	.L110
	.word	.L110
	.word	.L113
	.word	.L113
.L113:
	mov	r1, #2
	mov	r0, r5
	bl	BsSkip
.L109:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	str	r0, [r4, #40]
	mov	r0, r5
	bl	BsGet
	mov	r3, #1
	str	r0, [r4, #44]
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L114:
	mov	r3, #1
	mov	r1, #5
	str	r3, [r4, #8]
	mov	r0, r5
	bl	BsGet
	sub	r3, r0, #23
	str	r0, [r4, #12]
	cmp	r0, #26
	cmpne	r3, #1
	bhi	.L96
	mov	r1, #2
	mov	r0, r5
	bl	BsShow
	str	r0, [r4, #24]
	cmp	r0, #3
	ldrls	pc, [pc, r0, asl #2]
	b	.L97
.L99:
	.word	.L98
	.word	.L98
	.word	.L101
	.word	.L101
.L110:
	mov	r1, #1
	mov	r0, r5
	bl	BsSkip
	b	.L109
.L101:
	mov	r1, #2
	mov	r0, r5
	bl	BsSkip
.L97:
	mov	r1, #2
	mov	r0, r5
	bl	BsShow
	str	r0, [r4, #28]
	cmp	r0, #3
	ldrls	pc, [pc, r0, asl #2]
	b	.L102
.L104:
	.word	.L103
	.word	.L103
	.word	.L106
	.word	.L106
.L106:
	mov	r1, #2
	mov	r0, r5
	bl	BsSkip
.L102:
	mov	r0, r5
	mov	r1, #1
	bl	BsGet
	mov	r3, #1
	str	r0, [r4, #32]
	b	.L94
.L98:
	mov	r1, #1
	mov	r0, r5
	bl	BsSkip
	b	.L97
.L103:
	mov	r1, #1
	mov	r0, r5
	bl	BsSkip
	b	.L102
	.fnend
	.size	Divx3_GetPictureHeader, .-Divx3_GetPictureHeader
	.align	2
	.global	DIVX3DEC_Init
	.type	DIVX3DEC_Init, %function
DIVX3DEC_Init:
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
	ldr	r3, .L119
	add	r5, r0, #36864
	mov	r7, r1
	movw	r2, #39816
	mov	r1, #0
	ldr	r8, [r5, #2936]
	mov	r4, r0
	ldr	r3, [r3, #48]
	mov	r6, r1
	blx	r3
	add	r0, r4, #39424
	add	r0, r0, #32
	str	r8, [r5, #2936]
	bl	ResetVoQueue
	str	r7, [r4]
	mov	r3, #1
	str	r3, [r5, #2432]
	ldr	r3, [r7, #8]
	mov	r0, r4
	strb	r6, [r4, #186]
	strb	r3, [r4, #187]
	bl	VCTRL_GetChanIDByCtx
	cmn	r0, #1
	str	r0, [r5, #2944]
	mov	r0, r6
	beq	.L118
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L118:
	ldr	r1, .L119+4
	bl	dprint_vfmw
	mvn	r0, #19
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L120:
	.align	2
.L119:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC15
	.fnend
	.size	DIVX3DEC_Init, .-DIVX3DEC_Init
	.align	2
	.global	DIVX3DEC_Destroy
	.type	DIVX3DEC_Destroy, %function
DIVX3DEC_Destroy:
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
	add	r3, r0, #36864
	ldr	r1, .L122
	mov	r0, #2
	ldr	r2, [r3, #2456]
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L123:
	.align	2
.L122:
	.word	.LC16
	.fnend
	.size	DIVX3DEC_Destroy, .-DIVX3DEC_Destroy
	.align	2
	.global	DIVX3DEC_Decode
	.type	DIVX3DEC_Decode, %function
DIVX3DEC_Decode:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #180
	sub	sp, sp, #180
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r2, #96
	mov	r5, r1
	mov	r9, r0
	mov	r1, #0
	sub	r0, fp, #140
	mov	r4, #0
	bl	memset
	cmp	r5, #0
	str	r4, [fp, #-180]
	str	r4, [fp, #-176]
	str	r4, [fp, #-172]
	str	r4, [fp, #-168]
	str	r4, [fp, #-164]
	str	r4, [fp, #-160]
	str	r4, [fp, #-156]
	str	r4, [fp, #-152]
	str	r4, [fp, #-148]
	str	r4, [fp, #-144]
	beq	.L195
	ldr	r3, [r5, #8]
	cmp	r3, #0
	beq	.L196
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L197
	ldr	r3, [r5, #12]
	cmp	r3, #9
	ble	.L198
	ldr	r7, .L208
	add	r3, r9, #36864
	add	r10, r9, #8
	mov	r2, #172
	mov	r6, r3
	str	r3, [fp, #-192]
	mov	r1, r4
	ldr	r3, [r7, #48]
	mov	r0, r10
	blx	r3
	str	r4, [r9, #260]
	ldr	r3, [r5, #12]
	str	r3, [r6, #2440]
	ldr	r3, [r5, #8]
	str	r3, [r9, #264]
	ldr	r3, [r5]
	str	r3, [r9, #212]
	ldr	r2, [r5, #12]
	str	r2, [r9, #268]
	ldrb	r3, [r5, #5]
	str	r3, [r9, #272]
	ldrb	r3, [r5, #5]
	cmp	r3, #1
	beq	.L130
	ldr	r3, [r5, #88]
	str	r3, [r9, #276]
	ldr	r3, [r5, #80]
	str	r3, [r9, #216]
	ldr	r3, [r5, #92]
	str	r3, [r9, #280]
	ldrb	r3, [r5, #85]
	str	r3, [r9, #284]
	ldrb	r3, [r5, #85]
	cmp	r3, #1
	bne	.L199
.L131:
	movw	r3, #65525
	sub	r1, r2, #10
	movt	r3, 47
	cmp	r1, r3
	movhi	r4, #0
	bhi	.L126
	ldr	r1, [r9, #212]
	cmp	r1, #0
	moveq	r4, r1
	beq	.L126
	add	r8, r9, #39424
	mov	r0, r8
	bl	BsInit
	mov	r0, r8
	bl	BsResidBits
	mov	r1, #32
	str	r0, [fp, #-196]
	mov	r0, r8
	bl	BsGet
	mov	r1, #32
	rev	r4, r0
	mov	r0, r8
	add	r3, r4, #15
	str	r4, [fp, #-84]
	mov	r3, r3, lsr #4
	str	r3, [fp, #-92]
	bl	BsGet
	sub	r1, r4, #32
	rev	r3, r0
	str	r3, [fp, #-80]
	sub	r0, r3, #32
	add	r2, r3, #15
	cmp	r1, #1888
	cmpls	r0, #1056
	mov	r2, r2, lsr #4
	str	r2, [fp, #-88]
	movhi	ip, #1
	movls	ip, #0
	bhi	.L200
	ldr	r2, [fp, #-192]
	sub	r1, fp, #140
	mov	r0, r8
	str	ip, [fp, #-200]
	ldr	r3, [r2, #2344]
	ldr	r2, [r2, #2432]
	str	r3, [fp, #-132]
	bl	Divx3_GetPictureHeader
	ldr	ip, [fp, #-200]
	cmp	r0, #1
	mov	r4, r0
	bne	.L201
	ldr	r3, [fp, #-192]
	ldr	r3, [r3, #2460]
	cmp	r3, #0
	bne	.L134
	ldr	r2, [fp, #-140]
	cmp	r2, #0
	bne	.L202
.L134:
	ldr	r2, [fp, #-92]
	ldr	r1, [fp, #-88]
	ldrb	r0, [r9, #186]
	mul	r3, r2, r1
	cmp	r0, #0
	str	r3, [fp, #-76]
	beq	.L135
	ldr	r3, [fp, #-192]
	ldr	r3, [r3, #2384]
	cmp	r2, r3
	beq	.L203
.L135:
	ldr	r3, .L208+4
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L137
	ldr	r6, [fp, #-192]
	mov	r3, #8
	strh	r2, [fp, #-184]
	sub	r2, fp, #188
	strh	r1, [fp, #-182]
	mov	r1, #2
	ldr	r0, [r6, #2388]
	ldr	lr, [r6, #2384]
	strh	r0, [fp, #-186]
	strh	lr, [fp, #-188]
	ldr	r0, [r6, #2944]
	blx	ip
.L137:
	ldr	r6, [fp, #-192]
	mov	r2, #1
	ldr	r1, [r6, #2544]
	ldr	r0, [r6, #2944]
	bl	FSP_ClearLogicFs
	mov	r3, #0
	str	r3, [r6, #2544]
	add	r3, r9, #39424
	ldr	r0, [r6, #2944]
	str	r6, [fp, #-192]
	mov	r6, r3
	bl	FSP_GetNullLogicFs
	ldr	ip, [fp, #-192]
	add	r3, r6, #32
	mov	r2, #0
	mov	r1, r3
	str	r2, [ip, #2460]
	mov	r6, r3
	str	r0, [ip, #2544]
	ldr	r0, [ip, #2944]
	bl	FSP_ClearNotInVoQueue
	ldr	r2, [fp, #-92]
	ldr	r3, [fp, #-88]
	cmp	r2, #512
	bhi	.L139
	cmp	r3, #512
	bhi	.L139
	ldr	r1, [r9]
	ldr	r0, [r1, #700]
	cmp	r0, #0
	bne	.L141
	ldr	r1, [r1, #28]
	cmp	r1, #25
	beq	.L204
.L141:
	ldr	r3, [fp, #-192]
	ldr	r0, [r3, #2944]
	bl	FSP_GetFspType
	cmp	r0, #0
	beq	.L143
.L194:
	ldr	r2, [fp, #-92]
	ldr	r3, [fp, #-88]
.L142:
	ldr	r1, .L208+8
	mov	r0, #1
	bl	dprint_vfmw
	sub	r2, fp, #140
	mov	r1, r9
	mov	r0, #6
	bl	Divx3_ArrangeVHBMem
	cmp	r0, #1
	bne	.L205
.L136:
	ldr	r3, [fp, #-140]
	add	r0, r9, #39168
	mov	r2, #96
	sub	r1, fp, #140
	cmp	r3, #0
	add	r0, r0, #32
	ldrne	r3, [fp, #-192]
	moveq	r3, #23
	ldrne	r3, [r3, #2348]
	mov	r6, r3
	ldr	r3, [r7, #52]
	blx	r3
	ldr	r3, [fp, #-140]
	mov	r0, r9
	cmp	r3, #0
	ldrne	r2, [fp, #-192]
	movne	r3, r6
	strne	r3, [r2, #2348]
	bl	Divx3_DecodeDecide
	cmp	r0, #1
	mov	r7, r0
	beq	.L146
	ldr	r1, .L208+12
	mov	r0, #1
	bl	dprint_vfmw
	mov	r4, #0
	b	.L126
.L198:
	ldr	r1, .L208+16
	mov	r0, #1
	bl	dprint_vfmw
.L126:
	mov	r0, r4
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L199:
	ldr	r6, [fp, #-192]
	ldr	r1, [r5, #16]
	ldr	r0, [r6, #2944]
	bl	SM_ReleaseStreamSeg
	ldr	r1, [r5, #96]
	ldr	r0, [r6, #2944]
	bl	SM_ReleaseStreamSeg
	mov	r0, r4
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L196:
	ldr	r1, .L208+20
	mov	r0, #1
	mov	r4, r3
	bl	dprint_vfmw
	mov	r0, r4
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L130:
	str	r4, [r9, #276]
	str	r4, [r9, #216]
	str	r4, [r9, #280]
	str	r4, [r9, #284]
	b	.L131
.L200:
	mov	r2, r4
	ldr	r1, .L208+24
	mov	r0, #1
	mov	r4, #0
	bl	dprint_vfmw
	b	.L126
.L201:
	ldr	r1, .L208+28
	mov	r0, #1
	mov	r4, ip
	bl	dprint_vfmw
	b	.L126
.L195:
	add	ip, r9, #36864
	ldr	r1, .L208+32
	mov	r0, #1
	mov	r4, r5
	ldr	r2, [ip, #2456]
	bl	dprint_vfmw
	b	.L126
.L197:
	ldr	r1, .L208+36
	mov	r0, #1
	mov	r4, r3
	bl	dprint_vfmw
	b	.L126
.L139:
	ldr	r1, .L208+40
	mov	r0, #18
	bl	dprint_vfmw
	mov	r4, #0
	b	.L126
.L205:
	ldr	r1, .L208+44
	mov	r0, #1
	bl	dprint_vfmw
	mov	r4, #0
	b	.L126
.L203:
	ldr	r3, [fp, #-192]
	ldr	r3, [r3, #2388]
	cmp	r1, r3
	bne	.L135
	b	.L136
.L204:
	ldrb	r1, [r9, #186]
	cmp	r1, #0
	bne	.L142
.L143:
	mov	r0, r6
	bl	ResetVoQueue
	b	.L194
.L146:
	mov	r0, r9
	bl	Divx3_GetImageBuffer
	subs	r3, r0, #0
	beq	.L206
	ldr	r3, [fp, #-192]
	ldr	r1, [r3, #2548]
	ldr	r0, [r3, #2944]
	bl	FSP_GetFsImagePtr
	subs	r3, r0, #0
	beq	.L148
	ldr	r7, [r9]
	add	r2, r3, #576
	add	lr, r3, #592
	ldr	r1, .L208+48
	mov	r0, #29
	ldrd	r6, [r7, #56]
	strd	r6, [r2, #-8]
	ldr	r7, [r9]
	ldrd	r6, [r7, #72]
	strd	r6, [r2]
	ldr	r7, [r9]
	ldrd	r6, [r7, #88]
	strd	r6, [lr, #-8]
	mvn	r6, #0
	ldr	lr, [r9]
	mvn	r7, #0
	ldr	lr, [lr, #104]
	str	lr, [r3, #8]
	ldr	lr, [r9]
	ldr	lr, [lr, #108]
	str	lr, [r3, #12]
	ldr	lr, [r9]
	ldr	lr, [lr, #112]
	str	lr, [r3, #16]
	ldr	lr, [r9]
	ldr	lr, [lr, #128]
	str	lr, [r3, #20]
	ldr	r3, [r9]
	strd	r6, [r3, #56]
	ldrd	r6, [r2]
	ldrd	r2, [r2, #-8]
	strd	r6, [sp]
	bl	dprint_vfmw
	ldr	r6, [fp, #-192]
	ldr	r1, [r6, #2548]
	ldr	r0, [r6, #2944]
	bl	FSP_GetLogicFs
	ldr	r1, [r6, #2544]
	mov	r7, r0
	ldr	r0, [r6, #2944]
	bl	FSP_GetLogicFs
	cmp	r7, #0
	cmpne	r0, #0
	beq	.L149
	ldr	r3, [r7, #608]
	cmp	r3, #0
	beq	.L149
	ldr	r2, [r7, #616]
	cmp	r2, #0
	beq	.L149
	ldr	r2, [r7, #612]
	cmp	r2, #0
	beq	.L149
	ldr	r2, [r0, #608]
	mov	ip, #0
	str	ip, [fp, #-200]
	mov	r0, #13
	cmp	r2, #0
	ldrne	r1, [r2, #16]
	ldreq	r1, [r3, #16]
	ldr	r2, [r9, #168]
	str	r1, [r9, #132]
	ldr	r3, [r7, #608]
	mov	ip, r2
	ldr	r2, [r3, #16]
	str	r2, [r9, #136]
	ldr	lr, [r7, #620]
	str	lr, [r9, #164]
	ldr	r3, [r7, #612]
	ldr	r3, [r3, #16]
	stmia	sp, {r1, lr}
	ldr	r1, .L208+52
	str	r3, [r9, #140]
	str	ip, [sp, #8]
	bl	dprint_vfmw
	ldr	r3, [r7, #612]
	mov	r0, r8
	ldr	r3, [r3, #32]
	str	r3, [r9, #144]
	ldr	r3, [r7, #612]
	ldr	r3, [r3, #76]
	str	r3, [r9, #148]
	ldr	r3, [r7, #612]
	ldr	r3, [r3, #60]
	str	r3, [r9, #152]
	ldr	r3, [r7, #612]
	ldr	r3, [r3, #64]
	str	r3, [r9, #156]
	bl	BsResidBits
	ldr	r3, [r5, #8]
	ldr	r2, [fp, #-196]
	bic	r3, r3, #15
	str	r3, [r9, #104]
	ldr	r3, [r5, #8]
	and	r3, r3, #15
	add	r3, r2, r3, lsl #3
	rsb	r3, r0, r3
	mov	r0, r8
	and	r2, r3, #127
	str	r2, [r9, #116]
	mov	r3, r3, lsr #7
	mov	r3, r3, asl #4
	str	r3, [r9, #108]
	bl	BsResidBits
	ldr	ip, [fp, #-200]
	ldr	r3, [fp, #-192]
	str	ip, [r9, #112]
	str	ip, [r9, #120]
	str	ip, [r9, #128]
	str	r0, [r9, #124]
	ldr	r3, [r3, #2348]
	cmp	r3, #24
	beq	.L155
	cmp	r3, #26
	beq	.L156
	cmp	r3, #23
	beq	.L207
	ldr	r1, .L208+56
	mov	r0, #1
	mov	r4, ip
	bl	dprint_vfmw
	b	.L126
.L202:
	ldr	r1, .L208+60
	mov	r4, r3
	bl	dprint_vfmw
	b	.L126
.L206:
	ldr	r2, [fp, #-192]
	mov	r4, r3
	ldr	r1, .L208+64
	ldr	r2, [r2, #2456]
	bl	dprint_vfmw
	b	.L126
.L149:
	ldr	r3, [fp, #-192]
	mov	r2, #1
	mov	r4, #0
	ldr	r1, [r3, #2548]
	ldr	r0, [r3, #2944]
	bl	FSP_ClearLogicFs
	ldr	r1, .L208+68
	mov	r0, r4
	bl	dprint_vfmw
	b	.L126
.L148:
	mov	r0, r7
	ldr	r1, .L208+72
	mov	r4, r3
	bl	dprint_vfmw
	b	.L126
.L155:
	ldr	r3, [fp, #-192]
	str	ip, [fp, #-180]
	ldr	r2, [r3, #2388]
	ldr	r3, [r3, #2384]
	tst	r2, #1
	mov	r2, r2, lsr #1
	moveq	r5, #2
	mul	r3, r3, r2
	sub	r2, r3, #1
	str	r2, [fp, #-160]
	mov	r2, r3, asl #1
	str	r3, [fp, #-176]
	sub	r3, r2, #1
	str	r3, [fp, #-156]
	beq	.L158
	ldr	r3, [fp, #-192]
	mov	r5, #3
	str	r2, [fp, #-172]
	ldr	r3, [r3, #2400]
	sub	r3, r3, #1
	str	r3, [fp, #-152]
.L158:
	ldr	r2, [fp, #-192]
	cmp	r5, #0
	ldr	r3, [r2, #2336]
	str	r3, [r9, #12]
	ldr	r3, [r2, #2384]
	str	r3, [r9, #16]
	ldr	r3, [r2, #2388]
	str	r3, [r9, #20]
	ldr	r3, [r2, #2340]
	str	r3, [r9, #24]
	ldr	r3, [r2, #2344]
	str	r3, [r9, #28]
	ldr	r3, [r2, #2352]
	str	r3, [r9, #32]
	ldr	r3, [r2, #2360]
	str	r3, [r9, #36]
	ldr	r3, [r2, #2364]
	str	r3, [r9, #40]
	ldr	r3, [r2, #2368]
	str	r3, [r9, #44]
	ldr	r3, [r2, #2372]
	str	r3, [r9, #48]
	ldr	r3, [r2, #2376]
	str	r3, [r9, #52]
	ldr	r3, [r2, #2380]
	str	r5, [r9, #60]
	str	r3, [r9, #56]
	beq	.L161
	sub	lr, fp, #180
	add	r0, r9, #60
	sub	r1, fp, #160
	add	r2, r9, #80
	mov	r3, #0
.L160:
	add	r3, r3, #1
	ldr	r6, [lr], #4
	ldr	ip, [r1], #4
	cmp	r3, r5
	str	r6, [r0, #4]!
	str	ip, [r2, #4]!
	bne	.L160
.L161:
	ldr	r3, [r9]
	str	r10, [r9, #4]
	ldr	r2, [r3, #588]
	str	r2, [r9, #172]
	ldr	r3, [r3, #624]
	str	r3, [r9, #176]
	b	.L126
.L207:
	ldr	r3, [fp, #-192]
	mov	r5, #1
	str	ip, [fp, #-180]
	ldr	r3, [r3, #2400]
	sub	r3, r3, #1
	str	r3, [fp, #-160]
	b	.L158
.L156:
	ldr	r3, [fp, #-192]
	str	ip, [fp, #-180]
	ldr	r2, [r3, #2388]
	ldr	r3, [r3, #2384]
	tst	r2, #3
	mov	r2, r2, lsr #2
	moveq	r5, #4
	mul	r3, r3, r2
	sub	r2, r3, #1
	str	r2, [fp, #-160]
	mov	r2, r3, asl #1
	mov	r1, r3, asl #2
	add	r0, r2, r3
	str	r3, [fp, #-176]
	str	r2, [fp, #-172]
	sub	r3, r0, #1
	sub	r2, r2, #1
	str	r3, [fp, #-152]
	str	r0, [fp, #-168]
	sub	r3, r1, #1
	str	r2, [fp, #-156]
	str	r3, [fp, #-148]
	beq	.L158
	ldr	r3, [fp, #-192]
	mov	r5, #5
	str	r1, [fp, #-164]
	ldr	r3, [r3, #2400]
	sub	r3, r3, #1
	str	r3, [fp, #-144]
	b	.L158
.L209:
	.align	2
.L208:
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_event_report
	.word	.LC25
	.word	.LC27
	.word	.LC20
	.word	.LC18
	.word	.LC21
	.word	.LC22
	.word	.LC17
	.word	.LC19
	.word	.LC24
	.word	.LC26
	.word	.LC29
	.word	.LC32
	.word	.LC33
	.word	.LC23
	.word	.LC28
	.word	.LC31
	.word	.LC30
	.fnend
	.size	DIVX3DEC_Decode, .-DIVX3DEC_Decode
	.align	2
	.global	DIVX3DEC_RecycleImage
	.type	DIVX3DEC_RecycleImage, %function
DIVX3DEC_RecycleImage:
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
	cmp	r0, #0
	mov	r5, r1
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	add	r4, r0, #36864
	mov	r2, #0
	ldr	r0, [r4, #2944]
	bl	FSP_SetDisplay
	mov	r1, r5
	ldr	r0, [r4, #2944]
	bl	FSP_GetFsImagePtr
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	DIVX3DEC_RecycleImage, .-DIVX3DEC_RecycleImage
	.align	2
	.global	DIVX3DEC_GetRemainImg
	.type	DIVX3DEC_GetRemainImg, %function
DIVX3DEC_GetRemainImg:
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
	ldr	r3, [r0]
	mov	r4, r0
	ldr	r3, [r3, #12]
	cmp	r3, #1
	beq	.L229
	add	r6, r0, #36864
	ldr	r1, [r6, #2548]
	ldr	r0, [r6, #2944]
	bl	FSP_GetFsImagePtr
	subs	r7, r0, #0
	beq	.L229
	ldr	r1, [r6, #2548]
	ldr	r0, [r6, #2944]
	bl	FSP_GetDisplay
	cmp	r0, #2
	beq	.L227
.L229:
	add	r5, r4, #39424
	add	r5, r5, #32
.L218:
	mov	r0, r5
	bl	GetVoLastImageID
.L228:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L227:
	mov	r0, r4
	add	r5, r4, #39424
	bl	Divx3_SetImgFormat
	add	r5, r5, #32
	mov	r3, #1
	str	r3, [r7, #188]
	mov	r2, r3
	ldr	r1, [r6, #2548]
	ldr	r0, [r6, #2944]
	bl	FSP_SetDisplay
	ldr	r0, [r6, #2944]
	mov	r2, r4
	str	r7, [sp]
	mov	r3, r5
	mov	r1, #5
	bl	InsertImgToVoQueue
	cmp	r0, #1
	beq	.L215
	mov	r2, #0
	ldr	r1, [r6, #2548]
	ldr	r0, [r6, #2944]
	add	r10, r7, #528
	bl	FSP_SetDisplay
	add	r4, r7, #544
	ldr	r1, [r7, #528]
	mov	r8, #0
	ldr	r0, [r6, #2944]
	mov	r9, #0
	bl	FreeUsdByDec
	strd	r8, [r10]
	ldr	r0, [r6, #2944]
	ldr	r1, [r7, #536]
	bl	FreeUsdByDec
	strd	r8, [r4, #-8]
	b	.L218
.L215:
	ldr	r3, [r7, #160]
	cmp	r3, #100
	bhi	.L218
	ldr	r3, [r7, #112]
	cmp	r3, #31
	bls	.L218
	ldr	r3, [r7, #116]
	cmp	r3, #31
	movhi	r0, #0
	bhi	.L228
	b	.L218
	.fnend
	.size	DIVX3DEC_GetRemainImg, .-DIVX3DEC_GetRemainImg
	.align	2
	.global	DIVX3DEC_VDMPostProc
	.type	DIVX3DEC_VDMPostProc, %function
DIVX3DEC_VDMPostProc:
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
	mov	r6, r1
	mov	r5, r0
	ldr	r1, .L260
	add	r4, r5, #36864
	mov	r7, r2
	mov	r0, #22
	mov	r2, r6
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, #5
	bl	ReleasePacket
	ldr	r1, [r4, #2548]
	ldr	r0, [r4, #2944]
	bl	FSP_GetFsImagePtr
	cmp	r0, #0
	beq	.L257
	ldr	r3, [r4, #2336]
	cmp	r3, #0
	andeq	r7, r7, #1
	streq	r7, [r4, #2432]
	cmp	r6, #0
	movlt	r6, #0
	blt	.L234
	cmp	r6, #100
	movge	r6, #100
.L234:
	str	r6, [r0, #160]
	mov	r0, #22
	ldr	r1, .L260+4
	bl	dprint_vfmw
	mov	r0, r5
	bl	Divx3_SetImgFormat
	ldrb	r3, [r5, #187]
	cmp	r3, #2
	beq	.L237
	ldr	r3, [r5]
	ldr	r3, [r3, #12]
	cmp	r3, #1
	beq	.L237
	ldr	r3, [r4, #2460]
	cmp	r3, #0
	ldrne	r1, [r4, #2544]
	mvneq	r1, #0
	str	r1, [r4, #2552]
.L236:
	cmn	r1, #1
	beq	.L239
	ldr	r0, [r4, #2944]
	bl	FSP_GetFsImagePtr
	ldr	r6, [r4, #2552]
	mov	r1, r6
	mov	r7, r0
	ldr	r0, [r4, #2944]
	bl	FSP_GetRef
	mov	r2, r6
	ldr	r1, .L260+8
	mov	r3, r0
	mov	r0, #12
	bl	dprint_vfmw
	mov	r2, #1
	ldr	r1, [r4, #2552]
	ldr	r0, [r4, #2944]
	bl	FSP_SetDisplay
	add	r3, r5, #39424
	ldr	r0, [r4, #2944]
	add	r3, r3, #32
	str	r7, [sp]
	mov	r2, r5
	mov	r1, #5
	bl	InsertImgToVoQueue
	cmp	r0, #1
	bne	.L258
.L239:
	ldr	r2, [r4, #2336]
	ldr	r3, [r4, #2456]
	cmp	r2, #1
	add	r3, r3, #1
	str	r3, [r4, #2456]
	beq	.L259
.L240:
	ldr	r2, [r4, #2544]
	mov	r3, #1
	ldr	r1, [r4, #2548]
	str	r3, [r4, #2460]
	cmp	r2, r1
	beq	.L242
	ldr	r1, .L260+12
	mov	r0, #13
	bl	dprint_vfmw
	mov	r2, #0
	ldr	r1, [r4, #2544]
	ldr	r0, [r4, #2944]
	bl	FSP_SetRef
	ldr	r1, [r4, #2544]
	ldr	r0, [r4, #2944]
	bl	FSP_RemovePmv
	ldr	r1, [r4, #2548]
.L242:
	str	r1, [r4, #2544]
	mov	r2, #1
	ldr	r0, [r4, #2944]
	bl	FSP_SetRef
	ldr	r2, [r4, #2548]
	ldr	r1, .L260+16
	mov	r0, #13
	bl	dprint_vfmw
	mov	r0, #1
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L237:
	ldr	r1, [r4, #2548]
	str	r1, [r4, #2552]
	b	.L236
.L258:
	mov	r2, #0
	ldr	r1, [r4, #2552]
	ldr	r0, [r4, #2944]
	bl	FSP_SetDisplay
.L257:
	mov	r0, #0
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L259:
	ldr	r3, [r4, #2460]
	cmp	r3, #0
	bne	.L240
	b	.L257
.L261:
	.align	2
.L260:
	.word	.LC34
	.word	.LC35
	.word	.LC36
	.word	.LC37
	.word	.LC38
	.fnend
	.size	DIVX3DEC_VDMPostProc, .-DIVX3DEC_VDMPostProc
	.align	2
	.global	DIVX3DEC_GetImageBuffer
	.type	DIVX3DEC_GetImageBuffer, %function
DIVX3DEC_GetImageBuffer:
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
	add	r4, r0, #36864
	mov	r5, r0
	ldr	r0, [r4, #2944]
	bl	FSP_IsNewFsAvalible
	cmp	r0, #1
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r0, [r4, #2944]
	bl	FSP_IsNewFsAvalible
	cmn	r0, #1
	beq	.L268
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L268:
	add	r1, r5, #39424
	ldr	r0, [r4, #2944]
	add	r1, r1, #32
	bl	FSP_ClearNotInVoQueue
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	DIVX3DEC_GetImageBuffer, .-DIVX3DEC_GetImageBuffer
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	__FUNCTION__.14730, %object
	.size	__FUNCTION__.14730, 19
__FUNCTION__.14730:
	.ascii	"Divx3_DecodeDecide\000"
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"get frame store fail!\012\000"
	.space	1
.LC1:
	.ascii	"line: %d, pImage is NULL!\012\000"
	.space	1
.LC2:
	.ascii	"get image buffer ok: LogicFsID = %d\012\000"
	.space	3
.LC3:
	.ascii	"decode %p, disp %p, tf %p\012\000"
	.space	1
.LC4:
	.ascii	"image size abnormal (%dx%d) in MB\012\000"
	.space	1
.LC5:
	.ascii	"divx3 actual frame size(%dx%d) exeed max config(%dx"
	.ascii	"%d)\012\000"
.LC6:
	.ascii	"partition fs memory fail!\012\000"
	.space	1
.LC7:
	.ascii	"ERROR: No Img buffer is allocated\012\000"
	.space	1
.LC8:
	.ascii	"----------------- divx3 Imode -> %d ---------------"
	.ascii	"---\012\000"
.LC9:
	.ascii	"-----I_MODE, but FrameType is %d-----\012\000"
	.space	1
.LC10:
	.ascii	"P-frm\000"
	.space	2
.LC11:
	.ascii	"-----cur framtype is %s, but refnum=%d-----\012\000"
	.space	3
.LC12:
	.ascii	"error: DecMode illegal\012\000"
.LC13:
	.ascii	"fuction return value is null,%s %d unknow error!!\012"
	.ascii	"\000"
	.space	1
.LC14:
	.ascii	"dec P frame, fwd ref err(%d) > ref_thr(%d)\012\000"
.LC15:
	.ascii	"-1 == VCTRL_GetChanIDByCtx() Err! \012\000"
.LC16:
	.ascii	"Decoding quits at frm %d\012\000"
	.space	2
.LC17:
	.ascii	"ERROR: frm %d, Invalid packet pointer!\012\000"
.LC18:
	.ascii	"ERROR: frm %d, Invalid packet PhyAddr!\012\000"
.LC19:
	.ascii	"ERROR: frm %d, Invalid packet VirAddr!\012\000"
.LC20:
	.ascii	"ERROR: frm %d, Invalid packet len!\012\000"
.LC21:
	.ascii	"ERROR: frm %d, Invalid WxH: %dx%d!\012\000"
.LC22:
	.ascii	"Divx3_GetPictureHeader Error!\012\000"
	.space	1
.LC23:
	.ascii	"Can't decode from P frame!\012\000"
.LC24:
	.ascii	"pic width/height to large,MbWidth = %d, MbHeight = "
	.ascii	"%d\000"
	.space	2
.LC25:
	.ascii	"new seq size %d * %d\012\000"
	.space	2
.LC26:
	.ascii	"Divx3_ArrangeVHBMem err\012\000"
	.space	3
.LC27:
	.ascii	"Divx3_DecodeDecide err\012\000"
.LC28:
	.ascii	"Fatal Error: frm%d, get image buffer failed\012\000"
	.space	3
.LC29:
	.ascii	"dec_pts: %lld Usertag = %lld\012\000"
	.space	2
.LC30:
	.ascii	"FSP_GetFsImagePtr Error!\012\000"
	.space	2
.LC31:
	.ascii	"CurFsID abnormal!\012\000"
	.space	1
.LC32:
	.ascii	"dec addr: cur,cur2d,fwd,currpmv,colpmv = %p,%p,%p,%"
	.ascii	"p,%p,%p\012\000"
.LC33:
	.ascii	"vol_mode Error!\012\000"
	.space	3
.LC34:
	.ascii	"ErrRatio = %d\012\000"
	.space	1
.LC35:
	.ascii	"DEBUG: DEC over\012\000"
	.space	3
.LC36:
	.ascii	"insert buf %d ref %d\012\000"
	.space	2
.LC37:
	.ascii	"---------- unref %d\012\000"
	.space	3
.LC38:
	.ascii	"++++++++++ ref %d\012\000"
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
