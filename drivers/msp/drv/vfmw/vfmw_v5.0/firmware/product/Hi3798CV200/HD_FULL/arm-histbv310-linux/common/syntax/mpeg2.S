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
	.file	"mpeg2.c"

	.text
	.align	2
	.type	MP2_SearchStartCode.part.1, %function
MP2_SearchStartCode.part.1:
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
	add	r3, r0, #2
	add	ip, r0, r1
.L12:
	cmp	ip, r3
	bls	.L2
.L15:
	ldrb	r2, [r3]
	cmp	r2, #1
	bls	.L14
.L8:
	add	r3, r3, #3
	cmp	ip, r3
	bhi	.L15
.L2:
	sub	r0, r1, #3
	ldmfd	sp, {fp, sp, pc}
.L14:
	cmp	r2, #0
	bne	.L5
	ldrb	r2, [r3, #-1]
	cmp	r2, #0
	addeq	r3, r3, #1
	beq	.L12
	ldrb	r2, [r3, #1]
	cmp	r2, #0
	addeq	r3, r3, #2
	addne	r3, r3, #4
	b	.L12
.L5:
	cmp	r2, #1
	bne	.L12
	ldrb	r2, [r3, #-2]
	cmp	r2, #0
	bne	.L8
	ldrb	r2, [r3, #-1]
	cmp	r2, #0
	bne	.L8
	rsb	r3, r0, r3
	sub	r0, r3, #2
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MP2_SearchStartCode.part.1, .-MP2_SearchStartCode.part.1
	.align	2
	.global	MP2_VerifyMemPara
	.type	MP2_VerifyMemPara, %function
MP2_VerifyMemPara:
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
	.size	MP2_VerifyMemPara, .-MP2_VerifyMemPara
	.align	2
	.global	MP2_ArrangeVHBMem
	.type	MP2_ArrangeVHBMem, %function
MP2_ArrangeVHBMem:
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
	add	r6, r0, #81920
	mov	r5, r0
	ldr	r3, [r6, #3728]
	ldr	r2, [r3, #48]
	ldr	r3, [r3, #52]
	cmp	r2, #31
	bls	.L19
	cmp	r3, #31
	bls	.L19
	ldr	r1, [r0]
	ldr	r0, [r1, #28]
	cmp	r0, #25
	beq	.L40
	mov	r7, r2
	mov	r10, r3
	mov	r8, #5
	mov	r4, #2
	mov	r9, #3
.L28:
	ldr	r3, .L42
	mov	r2, #32
	mov	r1, #0
	sub	r0, fp, #76
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r2, [r5]
	str	r10, [fp, #-48]
	mov	r3, #0
	str	r7, [fp, #-68]
	ldr	r2, [r2, #28]
	str	r10, [fp, #-64]
	cmp	r2, #24
	str	r7, [fp, #-52]
	strb	r3, [fp, #-75]
	beq	.L33
	uxtb	r3, r4
	strb	r9, [fp, #-73]
	strb	r8, [fp, #-71]
.L36:
	sub	r1, fp, #76
	ldr	r0, [r6, #4088]
	strb	r3, [fp, #-70]
	mov	r4, #0
	strb	r4, [fp, #-74]
	bl	FSP_ConfigInstance
	subs	r7, r0, #0
	bne	.L34
	ldr	r1, [r5]
	sub	r3, fp, #80
	ldr	r0, [r6, #4088]
	ldr	r2, [r1, #24]
	ldr	r1, [r1, #20]
	bl	FSP_ConfigFrameBuf
	cmp	r0, r4
	moveq	r0, #1
	beq	.L39
	ldr	r1, .L42+4
	mov	r0, r7
	bl	dprint_vfmw
	mov	r0, r7
	b	.L39
.L19:
	ldr	r1, .L42+8
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #0
.L39:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L34:
	ldr	r1, .L42+12
	mov	r0, r4
	bl	dprint_vfmw
	mov	r0, r4
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L40:
	ldr	r0, [r1, #700]
	cmp	r0, #0
	bne	.L23
	ldr	r7, [r1, #660]
	ldr	r10, [r1, #664]
	cmp	r2, r7
	bhi	.L25
	cmp	r3, r10
	bhi	.L25
	ldr	r2, [r1, #688]
	ldr	r3, [r1, #684]
	cmp	r2, #0
	add	r9, r3, #2
	beq	.L38
	add	r3, r3, #1
	cmp	r3, #17
	movlt	r4, r3
	movge	r4, #17
.L32:
	ldrb	r8, [r1, #708]
	b	.L28
.L23:
	ldr	r0, [r1, #660]
	ldr	ip, [r1, #664]
	cmp	r2, r0
	bhi	.L30
	cmp	r3, ip
	bhi	.L30
	ldr	r0, [r1, #688]
	mov	r7, r2
	ldr	r4, [r1, #684]
	mov	r10, r3
	cmp	r0, #0
	add	r9, r4, #2
	bne	.L41
.L38:
	mov	r4, #1
	b	.L32
.L33:
	mov	r3, #1
	strb	r8, [fp, #-71]
	strb	r3, [fp, #-73]
	b	.L36
.L30:
	stmia	sp, {r0, ip}
	mov	r0, #0
	ldr	r1, .L42+16
	bl	dprint_vfmw
	mov	r0, #0
	b	.L39
.L41:
	add	r3, r4, #1
	cmp	r3, #17
	movlt	r4, r3
	movge	r4, #17
	b	.L32
.L25:
	stmia	sp, {r7, r10}
	mov	r0, #0
	ldr	r1, .L42+16
	bl	dprint_vfmw
	mov	r0, #0
	b	.L39
.L43:
	.align	2
.L42:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC3
	.word	.LC1
	.word	.LC4
	.word	.LC2
	.fnend
	.size	MP2_ArrangeVHBMem, .-MP2_ArrangeVHBMem
	.align	2
	.global	MP2_DecodingDecide
	.type	MP2_DecodingDecide, %function
MP2_DecodingDecide:
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
	add	r4, r0, #81920
	mov	r5, r0
	ldr	r3, [r4, #2404]
	ldr	r7, [r4, #3728]
	tst	r3, #8388608
	mvneq	r6, #0
	bne	.L119
.L45:
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L119:
	ldrb	r2, [r7, #9]
	cmp	r2, #3
	beq	.L46
	ldr	r2, [r4, #2416]
	cmp	r2, #1
	beq	.L46
	ands	r6, r3, #255
	beq	.L48
.L122:
	ldr	r2, .L138
	ldr	ip, [r2]
	cmp	ip, #0
	beq	.L49
	mov	r3, #0
	mov	r1, #103
	mov	r2, r3
	ldr	r0, [r4, #4088]
	blx	ip
	ldr	r3, [r4, #2404]
.L49:
	ldr	r2, [r4, #2412]
	mov	r0, #22
	ldr	r1, .L138+4
	mov	r6, #0
	bl	dprint_vfmw
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L48:
	ldr	r3, [r4, #2452]
	cmp	r3, #0
	beq	.L120
	ldr	r3, [r4, #2392]
	sub	r3, r3, #2
	cmp	r3, #1
	ldr	r3, [r5]
	ldr	r2, [r3, #8]
	bls	.L121
.L52:
	sub	r3, r2, #1
	str	r2, [r4, #2392]
	cmp	r3, #3
	ldrls	pc, [pc, r3, asl #2]
	b	.L115
.L58:
	.word	.L57
	.word	.L59
	.word	.L60
	.word	.L61
.L46:
	ldr	r2, [r4, #4092]
	ands	r6, r3, #255
	add	r2, r2, #1
	str	r2, [r4, #4092]
	beq	.L48
	b	.L122
.L61:
	ldrb	r10, [r7, #22]
	cmp	r10, #1
	beq	.L123
	cmp	r10, #3
	beq	.L124
.L67:
	cmp	r10, #2
	beq	.L71
.L115:
	ldrb	r10, [r7, #22]
	mov	r3, #1
	ldrb	r9, [r7, #9]
	str	r3, [fp, #-52]
.L62:
	ldr	r2, [r4, #2412]
	add	r0, r5, #83968
	ldr	r1, [r4, #2352]
	add	r0, r0, #600
	ldr	r8, [r4, #2456]
	str	r2, [fp, #-48]
	add	r8, r8, r1
	bl	BsPos
	mov	r3, r10
	str	r9, [sp]
	ldr	r2, [fp, #-48]
	ldr	r1, .L138+8
	add	r8, r8, r0, lsr #3
	mov	r0, #18
	str	r8, [sp, #4]
	bl	dprint_vfmw
	ldr	r3, [r4, #2404]
	bic	r3, r3, #14155776
	str	r3, [r4, #2404]
	ldr	r3, [r5]
	ldr	r0, [r3, #608]
	ldr	r3, [r4, #2444]
	cmp	r0, #1
	beq	.L125
	cmp	r3, #0
	bne	.L75
	ldrb	r2, [r7, #22]
	sub	r1, r2, #2
	cmp	r1, #1
	bls	.L126
.L76:
	cmp	r2, #3
	beq	.L127
.L73:
	ldr	r1, [r4, #2480]
	ldr	r0, [r4, #4088]
	bl	FSP_GetFsImagePtr
	ldr	r1, [r4, #2484]
	mov	r8, r0
	ldr	r0, [r4, #4088]
	bl	FSP_GetFsImagePtr
	clz	r3, r8
	mov	r3, r3, lsr #5
	clz	r1, r0
	mov	r1, r1, lsr #5
	orrs	r2, r1, r3
	bne	.L128
	ldrb	r2, [r7, #22]
	cmp	r2, #2
	beq	.L129
	cmp	r2, #3
	beq	.L130
.L81:
	ldr	r3, [fp, #-52]
	cmp	r3, #0
	movne	r6, #1
	bne	.L45
	ldrb	r3, [r7, #9]
	cmp	r3, #3
	beq	.L87
	ldr	r3, [r4, #2416]
	cmp	r3, #0
	bne	.L45
.L87:
	ldrb	r3, [r7, #27]
	cmp	r3, #1
	beq	.L131
	ldrb	r3, [r7, #18]
	cmp	r3, #1
	beq	.L132
	ldr	r3, [r4, #2568]
	add	r3, r3, #1
	str	r3, [r4, #2568]
	mov	r3, r3, asl #1
	str	r3, [r4, #2564]
.L89:
	ldr	r2, [r4, #2560]
	ldr	r3, [r4, #2412]
	add	r2, r2, #1
	str	r2, [r4, #2560]
	add	r3, r3, #1
	str	r3, [r4, #2412]
	b	.L45
.L57:
	ldrb	r10, [r7, #22]
	cmp	r10, #3
	beq	.L133
.L117:
	mov	r3, #1
	ldrb	r9, [r7, #9]
	str	r3, [fp, #-52]
	b	.L62
.L60:
	mov	r3, #0
	ldrb	r10, [r7, #22]
	str	r3, [fp, #-52]
	ldrb	r9, [r7, #9]
	b	.L62
.L59:
	ldrb	r10, [r7, #22]
	sub	r3, r10, #2
	cmp	r3, #1
	bhi	.L117
	cmp	r10, #2
	beq	.L134
.L65:
	ldrb	r9, [r7, #9]
	cmp	r9, #3
	beq	.L135
.L68:
	ldr	r3, [r4, #2416]
	mov	r2, #0
	str	r2, [fp, #-52]
	clz	r3, r3
	mov	r3, r3, lsr #5
	str	r3, [r4, #2416]
	ldrb	r10, [r7, #22]
	ldrb	r9, [r7, #9]
	b	.L62
.L75:
	cmp	r3, #1
	bhi	.L73
	ldrb	r2, [r7, #22]
	b	.L76
.L125:
	cmp	r3, #0
	bne	.L73
	ldrb	r2, [r7, #22]
	cmp	r2, #3
	beq	.L136
	cmp	r2, #2
	bne	.L73
	ldr	r1, .L138+12
	bl	dprint_vfmw
	b	.L73
.L121:
	cmp	r2, #4
	cmpne	r2, #1
	bhi	.L52
	ldr	r1, .L138+16
	mov	r0, #2
	bl	dprint_vfmw
	ldr	r3, [r4, #2404]
	ldr	r1, [r4, #2484]
	orr	r3, r3, #128
	ldr	r0, [r4, #4088]
	str	r3, [r4, #2404]
	bl	FSP_GetFsImagePtr
	subs	r8, r0, #0
	beq	.L54
	add	r9, r8, #544
	ldr	r1, [r8, #528]
	ldr	r0, [r4, #4088]
	add	r10, r8, #560
	bl	FreeUsdByDec
	ldr	r1, [r9, #-8]
	ldr	r0, [r4, #4088]
	add	r3, r8, #528
	str	r3, [fp, #-48]
	bl	FreeUsdByDec
	ldr	r1, [r8, #544]
	ldr	r0, [r4, #4088]
	bl	FreeUsdByDec
	ldr	r1, [r10, #-8]
	ldr	r0, [r4, #4088]
	bl	FreeUsdByDec
	ldr	r3, [fp, #-48]
	mov	r0, #0
	mov	r1, #0
	mov	r2, #1
	strd	r0, [r3]
	strd	r0, [r9, #-8]
	strd	r0, [r9]
	strd	r0, [r10, #-8]
	ldr	r1, [r4, #2484]
	ldr	r0, [r4, #4088]
	bl	FSP_ClearLogicFs
	mov	r2, #1
	ldr	r1, [r4, #2480]
	ldr	r0, [r4, #4088]
	bl	FSP_ClearLogicFs
	str	r6, [r4, #2480]
	str	r6, [r4, #2484]
	ldr	r0, [r4, #4088]
	bl	FSP_GetFspType
	cmp	r0, #0
	bne	.L137
.L54:
	mov	r3, #0
	str	r3, [r4, #2444]
	ldr	r3, [r5]
	ldr	r2, [r3, #8]
	b	.L52
.L120:
	ldr	r2, [r4, #2412]
	mov	r0, #1
	ldr	r1, .L138+20
	bl	dprint_vfmw
	b	.L45
.L129:
	cmp	r3, #0
	bne	.L79
	ldr	r3, [r5]
	ldr	r2, [r8, #160]
	ldr	r3, [r3]
	cmp	r2, r3
	bls	.L81
	ldr	r1, .L138+24
	mov	r0, #1
	bl	dprint_vfmw
	b	.L45
.L128:
	mov	r3, #924
	ldr	r2, .L138+28
	ldr	r1, .L138+32
	mov	r0, #1
	bl	dprint_vfmw
	b	.L45
.L130:
	cmp	r3, #0
	ldr	r3, [r5]
	ldr	r2, [r8, #160]
	ldr	r3, [r3]
	bne	.L83
	cmp	r2, r3
	bhi	.L83
	cmp	r1, #0
	ldr	r2, [r0, #160]
	bne	.L86
	cmp	r3, r2
	bcs	.L81
.L86:
	ldr	r1, .L138+36
	mov	r0, #1
	bl	dprint_vfmw
	b	.L45
.L131:
	ldrb	r2, [r7, #16]
	ldrb	r3, [r7, #10]
	ldr	r1, [r4, #2568]
	add	r3, r2, r3
	add	r3, r3, #1
	add	r3, r3, r1
	str	r3, [r4, #2568]
	mov	r3, r3, asl #1
	str	r3, [r4, #2564]
	b	.L89
.L83:
	ldr	r1, .L138+40
	mov	r0, #1
	bl	dprint_vfmw
	b	.L45
.L124:
	add	r3, r5, #86016
	ldr	r3, [r3, #4]
	cmp	r3, #0
	bne	.L117
.L70:
	ldrb	r9, [r7, #9]
	cmp	r9, #3
	bne	.L68
	mov	r3, #0
	ldrb	r10, [r7, #22]
	str	r3, [fp, #-52]
	b	.L62
.L123:
	add	r3, r5, #86016
	mov	r2, #0
	str	r2, [r3, #4]
	ldrb	r10, [r7, #22]
	cmp	r10, #3
	bne	.L67
	b	.L70
.L133:
	ldrb	r10, [r7, #9]
	cmp	r10, #3
	bne	.L68
	mov	r3, #0
	mov	r9, r10
	str	r3, [fp, #-52]
	b	.L62
.L132:
	ldr	r2, [r4, #2568]
	ldr	r3, [r4, #2564]
	add	r2, r2, #1
	str	r2, [r4, #2568]
	ldrb	r2, [r7, #16]
	add	r2, r2, #2
	add	r3, r3, r2
	str	r3, [r4, #2564]
	b	.L89
.L71:
	add	r3, r5, #86016
	mov	r2, #1
	str	r2, [fp, #-52]
	str	r2, [r3, #4]
	ldrb	r10, [r7, #22]
	ldrb	r9, [r7, #9]
	b	.L62
.L126:
	ldr	r1, .L138+44
	mov	r0, #1
	str	r3, [fp, #-52]
	bl	dprint_vfmw
	b	.L73
.L127:
	ldr	r1, .L138+48
	mov	r0, #1
	bl	dprint_vfmw
	mov	r3, #0
	str	r3, [fp, #-52]
	b	.L73
.L79:
	movw	r3, #934
	ldr	r2, .L138+28
	ldr	r1, .L138+52
	mov	r0, #1
	bl	dprint_vfmw
	b	.L45
.L136:
	ldr	r1, .L138+56
	str	r3, [fp, #-52]
	bl	dprint_vfmw
	b	.L73
.L137:
	ldr	r0, [r4, #4088]
	bl	FSP_GetNullLogicFs
	str	r0, [r4, #2480]
	str	r0, [r4, #2484]
	b	.L54
.L134:
	add	r3, r5, #45056
	ldrb	r2, [r3, #297]
	cmp	r2, #3
	beq	.L65
	ldrb	r9, [r3, #296]
	cmp	r9, #1
	streq	r9, [fp, #-52]
	ldreqb	r9, [r7, #9]
	bne	.L65
	b	.L62
.L135:
	mov	r3, #0
	str	r3, [fp, #-52]
	b	.L62
.L139:
	.align	2
.L138:
	.word	g_event_report
	.word	.LC5
	.word	.LC8
	.word	.LC10
	.word	.LC7
	.word	.LC6
	.word	.LC15
	.word	.LANCHOR0
	.word	.LC13
	.word	.LC17
	.word	.LC16
	.word	.LC11
	.word	.LC12
	.word	.LC14
	.word	.LC9
	.fnend
	.size	MP2_DecodingDecide, .-MP2_DecodingDecide
	.align	2
	.global	MP2_EstimatePicQp
	.type	MP2_EstimatePicQp, %function
MP2_EstimatePicQp:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, fp, ip, lr, pc}
	.pad #4
	.save {r4, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #132
	sub	sp, sp, #132
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r2, #128
	mov	r4, r0
	ldr	r1, .L146
	sub	r0, fp, #148
	bl	memcpy
	add	r3, r4, #81920
	ldr	r0, [r4, #316]
	ldr	r2, [r3, #2440]
	cmp	r2, #1
	beq	.L141
	ldr	r3, [r3, #3728]
	ldrb	r3, [r3, #13]
	cmp	r3, #0
	subne	r3, fp, #20
	moveq	r0, r0, asl #1
	addne	r0, r3, r0, lsl #2
	ldrne	r0, [r0, #-128]
.L141:
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L147:
	.align	2
.L146:
	.word	.LANCHOR0+20
	.fnend
	.size	MP2_EstimatePicQp, .-MP2_EstimatePicQp
	.align	2
	.global	MP2_GetSequenceInfo
	.type	MP2_GetSequenceInfo, %function
MP2_GetSequenceInfo:
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
	add	r4, r0, #81920
	mov	r3, #0
	mov	r6, r0
	str	r3, [fp, #-64]
	ldr	r2, [r4, #2440]
	ldr	r5, [r4, #3728]
	cmp	r2, #1
	ldr	r7, [r4, #3732]
	str	r3, [fp, #-60]
	str	r3, [fp, #-56]
	beq	.L150
	cmp	r2, #2
	bne	.L195
	ldr	r3, [r4, #2404]
	and	r3, r3, #1769472
	cmp	r3, #589824
	beq	.L153
.L152:
	ldr	r1, .L204
	mov	r0, #17
	bl	dprint_vfmw
	ldr	r3, [r4, #2440]
	cmp	r3, #1
	beq	.L196
.L155:
	ldr	r3, [r5, #48]
	add	r3, r3, #15
	mov	r3, r3, lsr #4
	str	r3, [r5, #56]
	ldr	r2, [r4, #2440]
	cmp	r2, #2
	beq	.L197
.L156:
	ldr	r2, [r5, #52]
	add	r2, r2, #15
	mov	r2, r2, lsr #4
.L157:
	mov	r1, #0
	str	r2, [r5, #60]
	str	r1, [r5, #64]
	ldr	r1, [r4, #2440]
	cmp	r1, #2
	beq	.L198
.L158:
	ldr	r1, [r4, #2452]
	cmp	r1, #0
	beq	.L159
	ldr	r0, [r7, #56]
	cmp	r3, r0
	beq	.L199
.L159:
	ldr	r1, [r4, #2484]
	ldr	r0, [r4, #4088]
	bl	FSP_GetFsImagePtr
	subs	r8, r0, #0
	beq	.L162
	ldr	r1, [r8, #528]
	add	r9, r8, #544
	ldr	r0, [r4, #4088]
	add	r10, r8, #560
	bl	FreeUsdByDec
	ldr	r1, [r8, #536]
	ldr	r0, [r4, #4088]
	add	r3, r8, #528
	str	r3, [fp, #-72]
	bl	FreeUsdByDec
	ldr	r1, [r8, #544]
	ldr	r0, [r4, #4088]
	bl	FreeUsdByDec
	ldr	r1, [r8, #552]
	ldr	r0, [r4, #4088]
	bl	FreeUsdByDec
	ldr	r3, [fp, #-72]
	mov	r0, #0
	mov	r1, #0
	mov	r2, #1
	strd	r0, [r3]
	strd	r0, [r9, #-8]
	strd	r0, [r9]
	strd	r0, [r10, #-8]
	ldr	r1, [r4, #2484]
	ldr	r0, [r4, #4088]
	bl	FSP_ClearLogicFs
	mov	r2, #1
	ldr	r1, [r4, #2480]
	ldr	r0, [r4, #4088]
	bl	FSP_ClearLogicFs
	mov	r3, #0
	ldr	r0, [r4, #4088]
	str	r3, [r4, #2480]
	str	r3, [r4, #2484]
	bl	FSP_GetFspType
	cmp	r0, #0
	bne	.L200
.L162:
	add	r8, r6, #84992
	mov	r3, #0
	add	r8, r8, #664
	str	r3, [r4, #2444]
	ldr	r0, [r4, #4088]
	mov	r1, r8
	bl	FSP_ClearNotInVoQueue
	ldr	r3, [r6]
	ldr	r2, [r3, #700]
	cmp	r2, #0
	bne	.L164
	ldr	r3, [r3, #28]
	cmp	r3, #25
	beq	.L201
.L164:
	ldr	r3, [r4, #2452]
	cmp	r3, #0
	beq	.L167
	ldr	r3, [r7, #56]
	cmp	r3, #0
	beq	.L167
	ldr	r3, [r7, #60]
	cmp	r3, #0
	bne	.L202
.L167:
	ldr	r0, [r4, #4088]
	bl	FSP_GetFspType
	cmp	r0, #0
	bne	.L169
	sub	r3, fp, #56
	sub	r2, fp, #60
	sub	r1, fp, #64
	ldr	r0, [r4, #4088]
	bl	VCTRL_GetChanImgNum
	ldr	r3, [r6]
	ldr	r3, [r3, #700]
	cmp	r3, #1
	beq	.L203
.L170:
	mov	r0, r8
	bl	ResetVoQueue
	add	r3, r6, #86016
	mov	r2, #0
	strb	r2, [r3, #9]
.L169:
	mov	r3, #0
	mov	r0, r6
	mov	r1, r3
	str	r3, [r4, #2452]
	str	r3, [r4, #2468]
	bl	MP2_ArrangeVHBMem
	ldr	r1, .L204+4
	str	r0, [r4, #2452]
	mov	r0, #1
	ldr	r3, [r5, #60]
	ldr	r2, [r5, #56]
	mov	r3, r3, asl #4
	mov	r2, r2, asl #4
	bl	dprint_vfmw
.L165:
	ldr	r3, .L204+8
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L193
	ldr	r0, [r5, #60]
	mov	r3, #8
	ldr	r8, [r7, #56]
	sub	r2, fp, #52
	ldr	r6, [r7, #60]
	mov	r1, #2
	ldr	lr, [r5, #56]
	strh	r0, [fp, #-46]
	strh	r8, [fp, #-52]
	strh	r6, [fp, #-50]
	strh	lr, [fp, #-48]
	ldr	r0, [r4, #4088]
	blx	ip
.L193:
	ldr	r1, [r4, #2452]
.L160:
	str	r1, [r4, #2400]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L195:
	ldr	r3, [r4, #2404]
	tst	r3, #3538944
	beq	.L153
	tst	r3, #131072
	mov	r2, #2
	orreq	r3, r3, r2
	streq	r3, [r4, #2404]
	tst	r3, #1048576
	str	r2, [r4, #2440]
	orreq	r3, r3, #16
	streq	r3, [r4, #2404]
	moveq	r2, #2
	movne	r2, #2
	b	.L152
.L153:
	mov	r2, #1
	str	r2, [r4, #2440]
	b	.L152
.L150:
	ldr	r3, [r4, #2404]
	mov	r1, #18
	bfi	r1, r1, #16, #16
	and	r3, r3, r1
	cmp	r3, #1179648
	moveq	r2, #2
	streq	r2, [r4, #2440]
	b	.L152
.L198:
	ldrb	r1, [r5, #27]
	cmp	r1, #0
	bne	.L158
	ldr	r1, [r5, #52]
	add	r0, r1, #31
	add	r1, r1, #15
	mov	r0, r0, lsr #5
	mov	r1, r1, lsr #4
	rsb	r1, r1, r0, lsl #1
	str	r1, [r5, #64]
	b	.L158
.L197:
	ldrb	r2, [r5, #27]
	cmp	r2, #0
	bne	.L156
	ldr	r2, [r5, #52]
	add	r2, r2, #31
	mov	r2, r2, lsr #5
	mov	r2, r2, asl #1
	b	.L157
.L196:
	mov	r2, #0
	mov	r0, #3
	mov	r1, #5
	strb	r3, [r5, #27]
	strb	r3, [r5, #18]
	strb	r3, [r5, #11]
	strb	r3, [r5, #28]
	strb	r0, [r5, #9]
	str	r1, [r5, #144]
	strb	r2, [r5, #12]
	strb	r2, [r5, #13]
	strb	r2, [r5, #14]
	strb	r2, [r5, #15]
	strb	r2, [r5, #8]
	b	.L155
.L202:
	mov	r9, #0
	ldr	r1, .L204+12
	str	r9, [r4, #2452]
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L204+8
	ldr	ip, [r3]
	cmp	ip, r9
	beq	.L167
	mov	r3, r9
	mov	r2, r9
	mov	r1, #120
	ldr	r0, [r4, #4088]
	blx	ip
	b	.L167
.L199:
	ldr	r3, [r7, #60]
	cmp	r2, r3
	bne	.L159
	b	.L160
.L203:
	ldr	r2, [fp, #-60]
	ldr	r1, [fp, #-56]
	add	r2, r2, r1
	cmp	r2, #0
	ble	.L170
	add	r6, r6, #86016
	strb	r3, [r6, #9]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L200:
	ldr	r0, [r4, #4088]
	bl	FSP_GetNullLogicFs
	str	r0, [r4, #2480]
	str	r0, [r4, #2484]
	b	.L162
.L201:
	ldr	r9, [r4, #2452]
	cmp	r9, #0
	bne	.L165
	mov	r0, r8
	bl	ResetVoQueue
	mov	r1, r9
	mov	r0, r6
	bl	MP2_ArrangeVHBMem
	str	r9, [r4, #2468]
	str	r0, [r4, #2452]
	b	.L165
.L205:
	.align	2
.L204:
	.word	.LC18
	.word	.LC20
	.word	g_event_report
	.word	.LC19
	.fnend
	.size	MP2_GetSequenceInfo, .-MP2_GetSequenceInfo
	.global	__aeabi_idiv
	.align	2
	.global	MP2_CalcRealEncFrameRate
	.type	MP2_CalcRealEncFrameRate, %function
MP2_CalcRealEncFrameRate:
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
	add	r4, r0, #81920
	ldr	r3, [r4, #3728]
	ldr	r5, [r4, #2544]
	ldr	lr, [r4, #2556]
	ldrb	r2, [r3, #22]
	ldr	ip, [r3, #72]
	cmp	r2, #1
	ldr	r1, [r4, #2552]
	ldr	r2, [r4, #2540]
	ldr	r6, [r4, #2536]
	ldr	r0, [r4, #2548]
	ldmnefd	sp, {r4, r5, r6, r7, fp, sp, pc}
	cmp	ip, #0
	add	r0, r6, r0
	add	r1, r2, r1
	movgt	r2, #1
	movle	r2, #0
	cmp	r0, #0
	andgt	r2, r2, #1
	movle	r2, #0
	cmp	r1, #0
	andgt	r2, r2, #1
	movle	r2, #0
	cmp	r2, #0
	streq	r2, [r4, #2572]
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldrb	r3, [r3, #27]
	cmp	r3, #1
	movne	r0, r0, asl #1
	addeq	r1, r5, lr
	mul	r0, ip, r0
	bl	__aeabi_idiv
	mov	r3, #100
	mul	r0, r3, r0
	add	r3, r0, #1020
	cmp	r0, #0
	add	r3, r3, #3
	movlt	r0, r3
	mov	r0, r0, asr #10
	str	r0, [r4, #2572]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	MP2_CalcRealEncFrameRate, .-MP2_CalcRealEncFrameRate
	.align	2
	.global	MP2_CalcDar
	.type	MP2_CalcDar, %function
MP2_CalcDar:
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
	add	r0, r0, #81920
	ldr	r3, [r0, #3728]
	ldr	r3, [r3, #84]
	sub	r3, r3, #1
	cmp	r3, #2
	ldrls	r2, .L214
	addls	r3, r2, r3, lsl #2
	ldrls	r0, [r3, #148]
	movhi	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L215:
	.align	2
.L214:
	.word	.LANCHOR0
	.fnend
	.size	MP2_CalcDar, .-MP2_CalcDar
	.align	2
	.global	MP2_SetImgFormat
	.type	MP2_SetImgFormat, %function
MP2_SetImgFormat:
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
	add	r6, r0, #81920
	mov	r7, r0
	ldr	r1, [r6, #2488]
	ldr	r0, [r6, #4088]
	ldr	r5, [r6, #3728]
	bl	FSP_GetFsImagePtr
	subs	r4, r0, #0
	beq	.L216
	ldrb	r3, [r5, #22]
	ldrb	r1, [r5, #27]
	cmp	r3, #4
	ldr	r2, [r4, #108]
	subne	r3, r3, #1
	ldrb	lr, [r5, #9]
	andne	r3, r3, #3
	moveq	r3, #0
	cmp	r1, #0
	ubfx	r2, r2, #10, #2
	orr	r2, r2, lr
	ldr	r0, [r5, #128]
	moveq	ip, #1
	movne	ip, #0
	movne	lr, #4096
	beq	.L242
.L219:
	ldr	r1, [r6, #3728]
	and	r0, r0, #3
	and	r9, r2, #3
	mov	r0, r0, asl #5
	ldr	r1, [r1, #84]
	orr	ip, r0, ip, asl #8
	orr	r2, ip, r9, asl #10
	str	r3, [r4, #100]
	sub	r1, r1, #1
	str	r3, [r4, #104]
	cmp	r1, #2
	orr	r3, r2, r3
	orr	r3, r3, lr
	mov	r0, r4
	ldrls	r8, .L246
	movhi	r1, #0
	movhi	r8, r1
	addls	r1, r8, r1, lsl #2
	ldrls	r1, [r1, #148]
	andls	r8, r1, #7
	movls	r8, r8, asl #14
	orr	r8, r3, r8
	str	r8, [r4, #108]
	bl	SetAspectRatio
	mov	r3, #3
	str	r3, [r4, #340]
	mov	r2, #1
	ldrb	r3, [r5, #9]
	strb	r2, [r4, #335]
	cmp	r3, #3
	moveq	r3, #0
	movne	r3, #4
	strb	r3, [r4, #328]
	ldr	r3, [r7, #4]
	cmp	r3, #0
	streqb	r3, [r4, #335]
	ldrneb	r3, [r3, #144]
	moveq	r2, #32
	moveq	r3, r2
	streq	r2, [r4, #344]
	mov	r2, #1
	strb	r2, [r4, #333]
	strne	r3, [r4, #344]
	str	r3, [r4, #352]
	str	r3, [r4, #348]
	ldr	r3, [r5, #72]
	str	r3, [r4, #136]
	ldr	r2, [r5, #48]
	str	r2, [r4, #112]
	ldr	r3, [r5, #52]
	str	r3, [r4, #116]
	ldr	r1, [r7]
	ldr	r1, [r1, #28]
	cmp	r1, #25
	beq	.L243
.L226:
	mov	r1, r3, lsr #1
	mov	r0, r2, lsr #1
	str	r1, [r4, #132]
	str	r0, [r4, #128]
	ldr	r1, [r5, #148]
	cmp	r1, #0
	bne	.L244
.L227:
	str	r2, [r4, #120]
	str	r3, [r4, #124]
.L228:
	ldrb	r3, [r5, #27]
	mov	r0, r7
	str	r3, [r4, #440]
	ldrb	r3, [r5, #18]
	str	r3, [r4, #444]
	ldr	r3, [r5, #144]
	str	r3, [r4, #452]
	bl	MP2_CalcRealEncFrameRate
	ldr	r3, [r6, #2572]
	str	r3, [r4, #448]
.L216:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L244:
	ldr	r0, [r5, #152]
	cmp	r0, #0
	beq	.L227
	cmp	r2, r1
	movcs	r2, r1
	str	r2, [r4, #120]
	ldr	r2, [r5, #152]
	cmp	r3, r2
	movcs	r3, r2
	str	r3, [r4, #124]
	b	.L228
.L242:
	cmp	lr, #3
	beq	.L245
	ldr	r1, [r6, #2416]
	cmp	r1, #0
	bne	.L221
	sub	lr, lr, #1
	clz	lr, lr
	mov	lr, lr, lsr #5
	mov	lr, lr, asl #12
	b	.L219
.L221:
	subs	lr, lr, #1
	movne	lr, #1
	mov	lr, lr, asl #12
	b	.L219
.L245:
	ldrb	lr, [r5, #10]
	and	lr, lr, #1
	mov	lr, lr, asl #12
	b	.L219
.L243:
	ldr	r2, [r4, #140]
	add	r3, r3, #15
	ldr	r1, [r4, #44]
	add	lr, r4, #480
	mov	r3, r3, lsr #4
	mov	r0, r2, asl #4
	add	r10, r1, r2
	mul	r3, r3, r0
	add	ip, r3, r1
	str	ip, [r4, #48]
	ldrd	r8, [lr, #-8]
	add	r2, ip, r2
	mov	r0, ip
	strd	r8, [fp, #-52]
	adds	r8, r8, r3
	adc	r9, r9, r3, asr #31
	strd	r8, [lr]
	str	r2, [r4, #40]
	add	r8, r4, #496
	ldrd	r2, [fp, #-52]
	str	r1, [r4, #28]
	str	ip, [r4, #32]
	str	r10, [r4, #36]
	strd	r2, [r8, #-8]
	str	r1, [r4, #60]
	bl	MEM_Phy2Vir
	ldr	r1, [r4, #32]
	mov	r3, #0
	ldr	r2, [r4, #112]
	str	r3, [r4, #500]
	str	r1, [r4, #64]
	ldr	r3, [r4, #116]
	str	r0, [r4, #496]
	b	.L226
.L247:
	.align	2
.L246:
	.word	.LANCHOR0
	.fnend
	.size	MP2_SetImgFormat, .-MP2_SetImgFormat
	.align	2
	.global	MP2_SearchStartCode
	.type	MP2_SearchStartCode, %function
MP2_SearchStartCode:
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
	cmp	r1, #4
	ble	.L250
	bl	MP2_SearchStartCode.part.1
	ldmfd	sp, {fp, sp, pc}
.L250:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MP2_SearchStartCode, .-MP2_SearchStartCode
	.align	2
	.global	MP2_ProtocolPPSCheck
	.type	MP2_ProtocolPPSCheck, %function
MP2_ProtocolPPSCheck:
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
	add	r4, r0, #81920
	ldr	r3, [r4, #2440]
	ldr	r1, [r4, #3728]
	cmp	r3, #1
	beq	.L253
	cmp	r3, #2
	beq	.L254
	ldr	r3, [r4, #2404]
	orr	r3, r3, #63
	str	r3, [r4, #2404]
	ldrb	r2, [r1, #22]
.L260:
	tst	r3, #24
	beq	.L262
.L278:
	cmp	r2, #3
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L263:
	orr	r3, r3, #64
	ldr	r1, [r4, #2484]
	str	r3, [r4, #2404]
	ldr	r0, [r4, #4088]
	bl	FSP_GetFsImagePtr
	subs	r5, r0, #0
	beq	.L266
	ldr	r1, [r5, #528]
	add	r6, r5, #544
	ldr	r0, [r4, #4088]
	add	r7, r5, #560
	bl	FreeUsdByDec
	ldr	r1, [r5, #536]
	ldr	r0, [r4, #4088]
	add	r8, r5, #528
	bl	FreeUsdByDec
	ldr	r1, [r5, #544]
	ldr	r0, [r4, #4088]
	bl	FreeUsdByDec
	ldr	r1, [r5, #552]
	ldr	r0, [r4, #4088]
	bl	FreeUsdByDec
	mov	r0, #0
	mov	r1, #0
	mov	r2, #1
	strd	r0, [r8]
	strd	r0, [r6, #-8]
	strd	r0, [r6]
	strd	r0, [r7, #-8]
	ldr	r1, [r4, #2484]
	ldr	r0, [r4, #4088]
	bl	FSP_ClearLogicFs
	mov	r2, #1
	ldr	r1, [r4, #2480]
	ldr	r0, [r4, #4088]
	bl	FSP_ClearLogicFs
	mov	r3, #0
	ldr	r0, [r4, #4088]
	str	r3, [r4, #2480]
	str	r3, [r4, #2484]
	bl	FSP_GetFspType
	cmp	r0, #0
	bne	.L277
.L266:
	mov	r3, #0
	str	r3, [r4, #2444]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L254:
	ldr	r3, [r4, #2404]
	tst	r3, #1048576
	orreq	r3, r3, #16
	streq	r3, [r4, #2404]
	ldrb	r2, [r1, #22]
	sub	r0, r2, #1
	cmp	r0, #2
	bls	.L260
.L275:
	orr	r3, r3, #8
	str	r3, [r4, #2404]
	tst	r3, #24
	ldrb	r2, [r1, #22]
	bne	.L278
.L262:
	cmp	r2, #1
	biceq	r3, r3, #192
	streq	r3, [r4, #2404]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L253:
	ldrb	r2, [r1, #22]
	sub	r3, r2, #1
	cmp	r3, #3
	ldr	r3, [r4, #2404]
	orrhi	r3, r3, #8
	strhi	r3, [r4, #2404]
	ldrhib	r2, [r1, #22]
	sub	r0, r2, #2
	cmp	r0, #1
	bls	.L279
.L257:
	cmp	r2, #3
	beq	.L280
	tst	r3, #24
	bne	.L263
	b	.L262
.L277:
	ldr	r0, [r4, #4088]
	bl	FSP_GetNullLogicFs
	str	r0, [r4, #2480]
	str	r0, [r4, #2484]
	b	.L266
.L280:
	ldrb	r2, [r1, #26]
	cmp	r2, #0
	ldmnefd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	b	.L275
.L279:
	ldrb	r0, [r1, #24]
	cmp	r0, #0
	orreq	r3, r3, #8
	streq	r3, [r4, #2404]
	ldreqb	r2, [r1, #22]
	b	.L257
	.fnend
	.size	MP2_ProtocolPPSCheck, .-MP2_ProtocolPPSCheck
	.align	2
	.global	MP2_GetImageBuffer
	.type	MP2_GetImageBuffer, %function
MP2_GetImageBuffer:
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
	add	r4, r0, #81920
	mov	r5, r0
	mov	r1, #1
	ldr	r0, [r4, #4088]
	bl	FSP_NewLogicFs
	cmp	r0, #0
	str	r0, [r4, #2488]
	blt	.L294
	mov	r1, r0
	ldr	r0, [r4, #4088]
	bl	FSP_GetLogicFs
	subs	r5, r0, #0
	beq	.L295
	ldr	r2, [r4, #2488]
	mov	r0, #18
	ldr	r1, .L297
	bl	dprint_vfmw
	ldr	r2, [r5, #608]
	cmp	r2, #0
	beq	.L290
	ldr	r3, [r5, #612]
	cmp	r3, #0
	beq	.L290
	ldr	r1, [r5, #616]
	cmp	r1, #0
	beq	.L290
	ldr	ip, [r1, #16]
	mov	r0, #18
	ldr	r3, [r3, #16]
	ldr	r2, [r2, #16]
	ldr	r1, .L297+4
	str	ip, [sp]
	bl	dprint_vfmw
	mov	r0, #1
.L286:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L290:
	mov	r0, #1
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L294:
	ldr	r1, .L297+8
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r1, [r4, #2484]
	ldr	r0, [r4, #4088]
	bl	FSP_GetFsImagePtr
	subs	r6, r0, #0
	beq	.L284
	ldr	r1, [r6, #528]
	add	r7, r6, #544
	ldr	r0, [r4, #4088]
	add	r8, r6, #560
	bl	FreeUsdByDec
	ldr	r1, [r6, #536]
	ldr	r0, [r4, #4088]
	add	r9, r6, #528
	bl	FreeUsdByDec
	ldr	r1, [r6, #544]
	ldr	r0, [r4, #4088]
	bl	FreeUsdByDec
	ldr	r1, [r6, #552]
	ldr	r0, [r4, #4088]
	bl	FreeUsdByDec
	mov	r0, #0
	mov	r1, #0
	mov	r2, #1
	strd	r0, [r9]
	strd	r0, [r7, #-8]
	strd	r0, [r7]
	strd	r0, [r8, #-8]
	ldr	r1, [r4, #2484]
	ldr	r0, [r4, #4088]
	bl	FSP_ClearLogicFs
	mov	r2, #1
	ldr	r1, [r4, #2480]
	ldr	r0, [r4, #4088]
	bl	FSP_ClearLogicFs
	mov	r3, #0
	ldr	r0, [r4, #4088]
	str	r3, [r4, #2480]
	str	r3, [r4, #2484]
	bl	FSP_GetFspType
	cmp	r0, #0
	bne	.L296
.L284:
	add	r1, r5, #84992
	ldr	r0, [r4, #4088]
	mov	r5, #0
	add	r1, r1, #664
	str	r5, [r4, #2444]
	bl	FSP_ClearNotInVoQueue
	mov	r0, r5
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L296:
	ldr	r0, [r4, #4088]
	bl	FSP_GetNullLogicFs
	str	r0, [r4, #2480]
	str	r0, [r4, #2484]
	b	.L284
.L295:
	movw	r2, #1909
	ldr	r1, .L297+12
	bl	dprint_vfmw
	mov	r0, r5
	b	.L286
.L298:
	.align	2
.L297:
	.word	.LC23
	.word	.LC24
	.word	.LC21
	.word	.LC22
	.fnend
	.size	MP2_GetImageBuffer, .-MP2_GetImageBuffer
	.align	2
	.global	MP2_GetPictureInfo
	.type	MP2_GetPictureInfo, %function
MP2_GetPictureInfo:
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
	add	r6, r0, #81920
	mov	r4, r0
	ldr	r3, [r6, #2440]
	ldr	r5, [r6, #3728]
	cmp	r3, #1
	ldr	r8, [r6, #3732]
	beq	.L358
.L300:
	ldrb	r3, [r5, #9]
	cmp	r3, #3
	beq	.L301
	ldr	r2, [r6, #2416]
	ldr	r1, [r6, #2448]
	clz	r3, r2
	mov	r3, r3, lsr #5
	str	r3, [r6, #2416]
	ldr	r2, [r5, #156]
	cmp	r2, r1
	moveq	r3, #0
	andne	r3, r3, #1
	cmp	r3, #0
	bne	.L359
.L354:
	add	r7, r4, #45056
.L303:
	ldrb	r3, [r5, #9]
	strb	r3, [r7, #297]
	ldr	r3, [r5, #156]
	str	r3, [r6, #2448]
	ldr	r3, [r5, #56]
	strh	r3, [r4, #160]
	ldrb	r3, [r5, #9]
	cmp	r3, #3
	ldr	r3, [r5, #60]
	ldreq	r2, [r5, #64]
	movne	r3, r3, lsr #1
	rsbeq	r3, r2, r3
	strh	r3, [r4, #156]
	ldr	r3, [r5, #60]
	strh	r3, [r4, #158]
	ldrb	r3, [r5, #11]
	strb	r3, [r4, #13]
	ldrb	r3, [r5, #9]
	strb	r3, [r4, #11]
	ldr	r2, [r6, #2416]
	strb	r2, [r4, #12]
	ldrb	r3, [r5, #12]
	strb	r3, [r4, #15]
	ldrb	r3, [r5, #22]
	strb	r3, [r4, #8]
	ldr	r3, [r6, #2440]
	sub	r3, r3, #1
	clz	r3, r3
	mov	r3, r3, lsr #5
	str	r3, [r4, #188]
	cmp	r3, #0
	ldrneb	r3, [r5, #25]
	strneb	r3, [r4, #9]
	ldrneb	r3, [r5, #23]
	strneb	r3, [r4, #10]
	ldrb	r3, [r5, #4]
	strb	r3, [r4, #20]
	ldrb	r3, [r5, #5]
	strb	r3, [r4, #21]
	ldrb	r3, [r5, #6]
	strb	r3, [r4, #22]
	ldrb	r3, [r5, #7]
	strb	r3, [r4, #23]
	ldrb	r3, [r5, #10]
	strb	r3, [r4, #14]
	ldrb	r3, [r5, #8]
	strb	r3, [r4, #19]
	ldrb	r3, [r5, #13]
	strb	r3, [r4, #18]
	ldrb	r3, [r5, #14]
	strb	r3, [r4, #17]
	ldrb	r3, [r5, #15]
	strb	r3, [r4, #16]
	ldrb	r3, [r5, #9]
	cmp	r2, #0
	cmpne	r3, #3
	bne	.L312
	mov	r1, #0
	mov	r0, r4
	bl	MP2_GetImageBuffer
	subs	r8, r0, #0
	beq	.L360
	ldr	r1, [r6, #2488]
	ldr	r0, [r6, #4088]
	bl	FSP_GetFsImagePtr
	subs	r8, r0, #0
	beq	.L315
	ldr	r9, [r4]
	add	ip, r8, #576
	add	lr, r8, #592
	ldr	r1, .L363
	mov	r0, #29
	ldrd	r2, [r9, #56]
	strd	r2, [ip, #-8]
	ldr	r9, [r4]
	ldrd	r2, [r9, #72]
	strd	r2, [ip]
	ldr	r9, [r4]
	ldrd	r2, [r9, #88]
	strd	r2, [lr, #-8]
	mvn	r2, #0
	ldr	lr, [r4]
	mvn	r3, #0
	ldr	lr, [lr, #104]
	str	lr, [r8, #8]
	ldr	lr, [r4]
	ldr	lr, [lr, #108]
	str	lr, [r8, #12]
	ldr	lr, [r4]
	ldr	lr, [lr, #112]
	str	lr, [r8, #16]
	ldr	lr, [r4]
	ldr	lr, [lr, #128]
	str	lr, [r8, #20]
	ldr	lr, [r4]
	strd	r2, [lr, #56]
	ldrd	r2, [ip]
	strd	r2, [fp, #-60]
	ldrd	r2, [ip, #-8]
	strd	r2, [fp, #-52]
	ldrd	r2, [fp, #-60]
	strd	r2, [sp]
	ldrd	r2, [fp, #-52]
	bl	dprint_vfmw
	ldrb	r3, [r5, #9]
	subs	r3, r3, #3
	movne	r3, #1
	str	r3, [r8, #96]
.L315:
	ldrb	r3, [r5, #22]
	cmp	r3, #3
	beq	.L312
	ldr	r3, [r6, #2444]
	ldr	r2, [r6, #2480]
	cmp	r3, #0
	ldr	r3, [r6, #2484]
	movne	r1, #2
	moveq	r1, #1
	cmp	r2, r3
	str	r1, [r6, #2444]
	beq	.L318
	ldr	r1, .L363+4
	mov	r0, #13
	bl	dprint_vfmw
	mov	r2, #0
	ldr	r1, [r6, #2480]
	ldr	r0, [r6, #4088]
	bl	FSP_SetRef
	ldr	r3, [r6, #2484]
.L318:
	ldr	r1, [r6, #2488]
	mov	r2, #1
	str	r3, [r6, #2480]
	ldr	r0, [r6, #4088]
	str	r1, [r6, #2484]
	bl	FSP_SetRef
	ldr	r1, [r6, #2480]
	ldr	r0, [r6, #4088]
	bl	FSP_RemovePmv
	ldr	r2, [r6, #2488]
	ldr	r1, .L363+8
	mov	r0, #13
	bl	dprint_vfmw
.L312:
	ldr	r1, [r6, #2488]
	ldr	r0, [r6, #4088]
	bl	FSP_GetLogicFs
	ldr	r1, [r6, #2480]
	mov	r5, r0
	ldr	r0, [r6, #4088]
	bl	FSP_GetLogicFs
	ldr	r1, [r6, #2484]
	mov	r9, r0
	ldr	r0, [r6, #4088]
	bl	FSP_GetLogicFs
	cmp	r5, #0
	cmpne	r9, #0
	moveq	r3, #1
	movne	r3, #0
	cmp	r0, #0
	orreq	r3, r3, #1
	mov	r10, r0
	cmp	r3, #0
	bne	.L361
	ldr	r2, [r5, #608]
	cmp	r2, #0
	beq	.L320
	ldr	r3, [r5, #616]
	cmp	r3, #0
	beq	.L320
	ldr	r3, [r5, #612]
	cmp	r3, #0
	beq	.L320
	ldr	r3, [r0, #608]
	ldr	r1, .L363+12
	cmp	r3, #0
	ldrne	lr, [r3, #16]
	ldreq	lr, [r2, #16]
	str	lr, [r4, #200]
	ldr	r3, [r9, #608]
	cmp	r3, #0
	ldreq	r3, [r5, #608]
	ldr	ip, [r3, #16]
	str	ip, [r4, #204]
	ldr	r3, [r5, #608]
	ldr	r2, [r3, #16]
	str	r2, [r4, #208]
	ldr	r6, [r5, #620]
	str	r6, [r4, #264]
	ldr	r3, [r5, #608]
	ldr	r3, [r3, #36]
	str	r3, [r4, #236]
	ldr	r3, [r5, #608]
	ldr	r3, [r3, #40]
	str	r3, [r4, #240]
	ldr	r3, [r0, #616]
	mov	r0, #13
	cmp	r3, #0
	ldreq	r3, [r5, #616]
	ldr	r3, [r3, #16]
	str	r3, [r4, #220]
	ldr	r3, [r9, #616]
	cmp	r3, #0
	ldreq	r3, [r5, #616]
	ldr	r3, [r3, #16]
	str	r3, [r4, #224]
	ldr	r3, [r5, #616]
	ldr	r3, [r3, #16]
	str	r3, [r4, #228]
	ldr	r3, [r5, #612]
	ldr	r3, [r3, #16]
	str	r3, [r4, #232]
	ldr	r8, [r10, #104]
	str	r8, [r4, #212]
	ldr	r8, [r9, #104]
	str	r8, [r4, #216]
	ldr	r8, [r5, #616]
	ldr	r8, [r8, #16]
	str	lr, [sp, #4]
	str	r6, [sp, #8]
	str	r8, [r7, #280]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [r5, #612]
	add	r1, r4, #83968
	add	lr, r4, #87
	add	r0, r1, #628
	add	ip, r4, #23
	ldr	r3, [r3, #32]
	add	r1, r1, #884
	mov	r2, #0
	str	r3, [r4, #244]
	ldr	r3, [r5, #612]
	ldr	r3, [r3, #76]
	str	r3, [r4, #248]
	ldr	r3, [r5, #612]
	ldr	r3, [r3, #60]
	str	r3, [r4, #252]
	ldr	r3, [r5, #612]
	ldr	r3, [r3, #64]
	str	r3, [r4, #256]
.L330:
	ldr	r3, [r0, #4]!
	add	r2, r2, #1
	cmp	r2, #64
	strb	r3, [lr, #1]!
	ldr	r3, [r1, #4]!
	strb	r3, [ip, #1]!
	bne	.L330
	mov	r0, r4
	mov	r8, #1
	bl	MP2_EstimatePicQp
	strb	r0, [r4, #152]
	mov	r0, r8
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L360:
	ldr	r2, [r6, #2412]
	ldr	r1, .L363+16
	bl	dprint_vfmw
	mov	r0, r8
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L301:
	add	r7, r4, #45056
	ldrb	r1, [r7, #297]
	cmp	r1, #3
	beq	.L306
	ldr	r3, [r6, #2416]
	cmp	r3, #0
	beq	.L362
.L306:
	mov	r3, #1
	str	r3, [r6, #2416]
	b	.L303
.L358:
	ldrb	r2, [r5, #26]
	ldrb	r3, [r5, #24]
	strb	r2, [r5, #7]
	strb	r2, [r5, #6]
	strb	r3, [r5, #5]
	strb	r3, [r5, #4]
	b	.L300
.L361:
	ldr	r1, [r6, #2488]
	mov	r8, #0
	ldr	r0, [r6, #4088]
	mov	r2, #1
	bl	FSP_ClearLogicFs
	stmia	sp, {r9, r10}
	mov	r3, r5
	movw	r2, #1225
	ldr	r1, .L363+20
	mov	r0, r8
	bl	dprint_vfmw
	mov	r0, r8
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L362:
	ldr	r2, [r6, #2412]
	mov	r0, #1
	str	r1, [sp]
	ldr	r1, .L363+24
	bl	dprint_vfmw
	mov	r2, #1
	ldr	r1, [r6, #2488]
	ldr	r0, [r6, #4088]
	bl	FSP_ClearLogicFs
	ldrb	r3, [r8, #22]
	cmp	r3, #3
	ldrne	r3, [r6, #2404]
	orrne	r3, r3, #192
	strne	r3, [r6, #2404]
	b	.L306
.L320:
	ldr	r1, [r6, #2488]
	mov	r2, #1
	ldr	r0, [r6, #4088]
	mov	r8, #0
	bl	FSP_ClearLogicFs
	ldr	r1, [r5, #612]
	ldr	r3, [r6, #2488]
	mov	r0, r8
	ldr	r2, [r6, #2480]
	str	r1, [sp, #12]
	ldr	ip, [r5, #616]
	ldr	lr, [r6, #2484]
	ldr	r1, .L363+28
	str	ip, [sp, #8]
	ldr	ip, [r5, #608]
	str	lr, [sp]
	str	ip, [sp, #4]
	bl	dprint_vfmw
	mov	r0, r8
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L359:
	ldr	r2, [r6, #2412]
	mov	r0, #1
	ldr	r1, .L363+32
	bl	dprint_vfmw
	mov	r3, #0
	mov	r2, #1
	str	r3, [r6, #2416]
	ldr	r1, [r6, #2488]
	ldr	r0, [r6, #4088]
	bl	FSP_ClearLogicFs
	ldrb	r3, [r8, #22]
	cmp	r3, #3
	beq	.L354
	ldr	r3, [r6, #2404]
	add	r7, r4, #45056
	orr	r3, r3, #192
	str	r3, [r6, #2404]
	b	.L303
.L364:
	.align	2
.L363:
	.word	.LC28
	.word	.LC29
	.word	.LC30
	.word	.LC33
	.word	.LC27
	.word	.LC31
	.word	.LC26
	.word	.LC32
	.word	.LC25
	.fnend
	.size	MP2_GetPictureInfo, .-MP2_GetPictureInfo
	.align	2
	.global	MP2_SetVDMInf
	.type	MP2_SetVDMInf, %function
MP2_SetVDMInf:
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
	add	r5, r0, #81920
	mov	r4, r0
	add	r0, r0, #83968
	ldrb	r3, [r5, #2356]
	add	r0, r0, #600
	ldr	lr, [r5, #2360]
	cmp	r3, #1
	ldr	r3, [r5, #2672]
	ldr	ip, [r5, #2352]
	add	r1, r3, #7
	beq	.L368
	cmp	r3, #0
	add	r2, lr, r3, lsr #3
	ldr	r6, [r5, #2364]
	bic	r2, r2, #3
	movge	r1, r3
	add	r3, r3, lr, lsl #3
	and	r3, r3, #31
	add	r1, ip, r1, asr #3
	str	r1, [r5, #2352]
	bic	r6, r6, #3
	str	r3, [r4, #172]
	str	r2, [r4, #164]
	bl	BsResidBits
	str	r6, [r4, #168]
	str	r0, [r4, #180]
	ldr	r3, [r5, #2364]
	and	r3, r3, #3
	mov	r3, r3, asl #3
	str	r3, [r4, #176]
	ldr	r3, [r5, #2372]
	mov	r3, r3, asl #3
	str	r3, [r4, #184]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L368:
	cmp	r3, #0
	add	r2, lr, r3, lsr #3
	bic	r2, r2, #3
	movge	r1, r3
	add	r3, r3, lr, lsl #3
	and	r3, r3, #31
	add	r1, ip, r1, asr #3
	str	r1, [r5, #2352]
	str	r3, [r4, #172]
	str	r2, [r4, #164]
	bl	BsResidBits
	mov	r3, #0
	str	r3, [r4, #168]
	str	r3, [r4, #176]
	str	r3, [r4, #184]
	str	r0, [r4, #180]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	MP2_SetVDMInf, .-MP2_SetVDMInf
	.align	2
	.global	MP2_DecNewPic
	.type	MP2_DecNewPic, %function
MP2_DecNewPic:
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
	mov	r4, r0
	bl	MP2_SetVDMInf
	ldr	r3, [r4]
	add	r2, r4, #45056
	add	r1, r4, #81920
	ldr	r0, [r3, #588]
	str	r0, [r2, #284]
	ldr	r0, [r3, #624]
	str	r0, [r2, #288]
	ldr	r0, [r3, #592]
	str	r0, [r2, #292]
	ldr	r2, [r1, #3728]
	ldrb	r0, [r2, #22]
	cmp	r0, #3
	beq	.L387
	cmp	r0, #2
	addeq	r0, r4, #86016
	moveq	ip, #1
	streq	ip, [r0, #4]
.L371:
	add	ip, r4, #8
	str	ip, [r4, #4]
	ldr	r0, [r3, #856]
	cmp	r0, #1
	beq	.L388
	cmp	r0, #2
	beq	.L389
.L374:
	ldr	r3, [r1, #2404]
	bic	r3, r3, #16252928
	str	r3, [r1, #2404]
	ldrb	r5, [r2, #22]
	cmp	r5, #1
	movne	r0, #1
	beq	.L390
.L372:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L390:
	ldr	r3, .L391
	ldr	r6, [r3]
	cmp	r6, #0
	moveq	r0, r5
	beq	.L372
	ldr	lr, [r4, #184]
	sub	r2, fp, #28
	ldr	ip, [r4, #180]
	mov	r3, #4
	ldr	r0, [r1, #4088]
	mov	r1, #20
	add	ip, ip, lr
	add	lr, ip, #7
	cmp	ip, #0
	movlt	ip, lr
	mov	ip, ip, asr #3
	str	ip, [r2, #-4]!
	blx	r6
	mov	r0, r5
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L387:
	add	r0, r4, #86016
	ldr	r0, [r0, #4]
	cmp	r0, #0
	bne	.L371
	ldr	ip, [r1, #2444]
	cmp	ip, #2
	beq	.L371
	ldrb	r3, [r2, #9]
	cmp	r3, #3
	ldrne	r3, [r1, #2416]
	clzne	r3, r3
	movne	r3, r3, lsr #5
	strne	r3, [r1, #2416]
	b	.L372
.L388:
	cmp	ip, #0
	beq	.L374
	ldrb	r3, [r2, #22]
	cmp	r3, #3
	moveq	r0, #0
	streq	r0, [r4, #4]
	bne	.L374
	b	.L372
.L389:
	ldr	r0, [r3, #860]
	cmp	ip, #0
	cmpne	r0, #0
	ble	.L374
	ldrb	r0, [r2, #22]
	cmp	r0, #3
	bne	.L374
	mov	r0, #0
	str	r0, [r4, #4]
	ldr	r2, [r3, #860]
	sub	r2, r2, #1
	str	r2, [r3, #860]
	b	.L372
.L392:
	.align	2
.L391:
	.word	g_event_report
	.fnend
	.size	MP2_DecNewPic, .-MP2_DecNewPic
	.align	2
	.global	MP2_RecordVFMWState
	.type	MP2_RecordVFMWState, %function
MP2_RecordVFMWState:
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
	add	r3, r0, #81920
	ldr	ip, [r0]
	add	r1, r0, #86016
	ldr	r2, [r3, #3728]
	ldr	lr, [r2, #40]
	str	lr, [ip, #564]
	ldr	ip, [r2, #44]
	ldr	r2, [r0]
	str	ip, [r2, #568]
	ldr	r3, [r3, #4092]
	ldr	r2, [r1]
	ldr	r1, [r0]
	cmp	r3, r2
	rsbge	r3, r2, r3
	movlt	r3, #0
	str	r3, [r1, #572]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MP2_RecordVFMWState, .-MP2_RecordVFMWState
	.align	2
	.global	MP2_GetUsrData
	.type	MP2_GetUsrData, %function
MP2_GetUsrData:
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
	add	r9, r0, #83968
	add	r5, r9, #600
	mov	r8, r0
	mov	r0, r5
	bl	BsToNextByte
	mov	r0, r5
	bl	BsResidBits
	add	r7, r0, #7
	cmp	r0, #0
	movlt	r0, r7
	mov	r7, r0, asr #3
	cmp	r7, #0
	ble	.L416
	mov	r6, #0
	ldr	r10, .L434
	mov	r4, r6
	b	.L401
.L432:
	bl	BsGet
	add	r4, r4, #1
	cmp	r4, r7
	strb	r0, [r10, r6]
	add	r6, r6, #1
	beq	.L397
.L401:
	mov	r1, #24
	mov	r0, r5
	bl	BsShow
	mov	r1, #8
	bic	r3, r0, #-16777216
	mov	r0, r5
	cmp	r3, #1
	beq	.L398
	cmp	r6, #1024
	blt	.L432
	mov	r1, #8
	mov	r0, r5
	add	r4, r4, #1
	bl	BsGet
	cmp	r4, r7
	bne	.L401
.L397:
	add	r10, r8, #81920
	movw	r3, #2356
	ldrsb	r4, [r10, r3]
	cmp	r4, #0
	beq	.L413
.L431:
	mov	r7, #0
.L402:
	ldr	r4, [r10, #2436]
	cmp	r4, #3
	ble	.L415
.L414:
	add	r4, r9, #368
	add	r9, r9, #384
	mov	r5, #0
.L406:
	ldr	r1, [r4, #4]!
	ldr	r0, [r10, #4088]
	bl	FreeUsdByDec
	cmp	r4, r9
	str	r5, [r4]
	mov	r3, #0
	bne	.L406
	mov	r4, r3
	str	r3, [r10, #2436]
.L415:
	ldr	r0, [r10, #4088]
	add	r4, r8, r4, lsl #2
	bl	GetUsd
	add	r4, r4, #81920
	str	r0, [r4, #2420]
	ldr	r2, [r10, #2436]
	add	r3, r8, r2, lsl #2
	add	r3, r3, #83968
	add	r3, r3, #72
	ldr	r3, [r3, #300]
	cmp	r3, #0
	beq	.L407
	ldr	r3, [r8]
	add	r0, r0, #1056
	ldr	r1, .L434
	ldrd	r2, [r3, #56]
	strd	r2, [r0]
	ldr	r3, [r4, #2420]
	ldr	r2, [r10, #2408]
	str	r2, [r3, #1044]
	ldr	r3, [r4, #2420]
	str	r6, [r3, #1052]
	ldr	r2, [r10, #3728]
	ldr	r3, [r4, #2420]
	ldrb	r2, [r2, #22]
	strb	r2, [r3, #1024]
	ldr	r3, [r4, #2420]
	ldr	r2, [r10, #4092]
	str	r2, [r3, #1032]
	ldr	r2, [r10, #3728]
	ldr	r3, [r4, #2420]
	ldrb	r2, [r2, #10]
	strb	r2, [r3, #1025]
	ldr	r3, [r10, #2404]
	tst	r3, #524288
	ldr	r3, [r4, #2420]
	movne	r2, #3
	moveq	r2, #1
	str	r2, [r3, #1040]
	ldr	r0, [r4, #2420]
	ldr	r2, [r0, #1052]
	cmp	r2, #1024
	movgt	r3, #1024
	strgt	r3, [r0, #1052]
	ldr	r3, .L434+4
	ldrgt	r0, [r4, #2420]
	ldr	r3, [r3, #52]
	ldrgt	r2, [r0, #1052]
	blx	r3
	ldr	r3, .L434+8
	ldr	r5, [r3]
	cmp	r5, #0
	beq	.L411
	ldr	r2, [r4, #2420]
	movw	r3, #1064
	mov	r1, #6
	ldr	r0, [r10, #4088]
	blx	r5
.L411:
	ldr	r3, [r10, #2436]
	add	r3, r3, #1
	str	r3, [r10, #2436]
.L430:
	mov	r0, r7
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L413:
	movw	r3, #2357
	ldrsb	r3, [r10, r3]
	cmp	r3, #0
	beq	.L419
	ldr	r7, [r10, #2372]
	cmp	r7, #0
	beq	.L402
	ldr	r1, .L434+12
	mov	r0, r4
	bl	dprint_vfmw
	ldr	lr, .L434+4
	ldr	r3, [r10, #2368]
	mov	r2, #3
	ldr	r1, [r10, #2384]
	mov	r7, #1
	ldr	r0, [r10, #2388]
	sub	r3, r3, #3
	add	r1, r1, r3
	ldr	r3, [lr, #52]
	sub	r0, r0, #3
	blx	r3
	ldr	r3, [r10, #2388]
	ldr	r2, [r10, #2372]
	mov	r0, r5
	sub	r3, r3, #3
	ldr	lr, [r10, #2364]
	add	r2, r2, #3
	str	r3, [r10, #2384]
	sub	lr, lr, #3
	str	r2, [r10, #2368]
	mov	r1, r3
	str	lr, [r10, #2360]
	strb	r7, [r10, #2356]
	strb	r4, [r10, #2357]
	str	r4, [r10, #2372]
	str	r4, [r10, #2388]
	str	r4, [r10, #2364]
	bl	BsInit
	strb	r7, [r10, #2357]
	strb	r4, [r10, #2356]
	mov	r0, r5
	bl	BsToNextByte
	mov	r0, r5
	bl	BsResidBits
	add	r7, r0, #7
	cmp	r0, #0
	movlt	r0, r7
	mov	r7, r0, asr #3
	sub	r7, r7, #3
	cmp	r7, #0
	bgt	.L405
	b	.L418
.L433:
	bl	BsGet
	ldr	r3, .L434
	strb	r0, [r3, r6]
	add	r6, r6, #1
.L404:
	add	r4, r4, #1
	cmp	r4, r7
	beq	.L431
.L405:
	mov	r1, #24
	mov	r0, r5
	bl	BsShow
	mov	r1, #8
	bic	r3, r0, #-16777216
	mov	r0, r5
	cmp	r3, #1
	beq	.L419
	cmp	r6, #1024
	blt	.L433
	mov	r1, #8
	mov	r0, r5
	bl	BsGet
	b	.L404
.L398:
	add	r10, r8, #81920
	mov	r7, r3
	ldr	r4, [r10, #2436]
	cmp	r4, #3
	bgt	.L414
	b	.L415
.L419:
	mov	r7, r3
	b	.L402
.L407:
	mov	r0, r3
	ldr	r1, .L434+16
	bl	dprint_vfmw
	b	.L430
.L416:
	mov	r6, #0
	b	.L397
.L418:
	mov	r7, r4
	b	.L402
.L435:
	.align	2
.L434:
	.word	.LANCHOR1
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_event_report
	.word	.LC34
	.word	.LC35
	.fnend
	.size	MP2_GetUsrData, .-MP2_GetUsrData
	.align	2
	.global	next_start_code
	.type	next_start_code, %function
next_start_code:
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
	add	r5, r0, #83968
	add	r5, r5, #600
	mov	r7, r0
	mov	r0, r5
	bl	BsToNextByte
	mov	r0, r5
	bl	BsGetNextBytePtr
	mov	r4, r0
	mov	r0, r5
	bl	BsResidBits
	cmp	r0, #0
	add	r3, r0, #7
	movge	r1, r0
	movlt	r1, r3
	mov	r1, r1, asr #3
	cmp	r1, #4
	movle	r1, #0
	bgt	.L461
.L437:
	mov	r0, r5
	bl	BsLongSkip
	mov	r0, r5
	bl	BsResidBits
	mov	r6, r0
	add	r0, r0, #7
	cmp	r6, #0
	movlt	r6, r0
	mov	r6, r6, asr #3
	sub	r6, r6, #3
	cmp	r6, #0
	movgt	r4, #0
	bgt	.L443
	b	.L444
.L441:
	bl	BsSkip
	cmp	r4, r6
	beq	.L444
.L443:
	mov	r1, #24
	mov	r0, r5
	bl	BsShow
	add	r4, r4, #1
	mov	r1, #8
	cmp	r0, #1
	mov	r0, r5
	bne	.L441
.L446:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L444:
	add	r7, r7, #81920
	movw	r3, #2356
	ldrsb	r4, [r7, r3]
	cmp	r4, #0
	bne	.L440
	ldrb	r3, [r7, #2357]
	cmp	r3, #0
	beq	.L440
	ldr	r3, [r7, #2372]
	cmp	r3, #0
	beq	.L440
	ldr	r1, .L464
	mov	r0, #7
	bl	dprint_vfmw
	ldr	ip, .L464+4
	ldr	r3, [r7, #2368]
	mov	r2, #3
	ldr	r1, [r7, #2384]
	mov	r6, #1
	ldr	r0, [r7, #2388]
	sub	r3, r3, #3
	add	r1, r1, r3
	ldr	r3, [ip, #52]
	sub	r0, r0, #3
	blx	r3
	ldr	r3, [r7, #2388]
	ldr	ip, [r7, #2364]
	mov	r0, r5
	ldr	r2, [r7, #2372]
	sub	r3, r3, #3
	strb	r6, [r7, #2356]
	mov	r1, r3
	add	r2, r2, #3
	str	r3, [r7, #2384]
	sub	r3, ip, #3
	str	r2, [r7, #2368]
	str	r3, [r7, #2360]
	strb	r4, [r7, #2357]
	str	r4, [r7, #2372]
	str	r4, [r7, #2388]
	str	r4, [r7, #2364]
	bl	BsInit
	strb	r6, [r7, #2357]
	strb	r4, [r7, #2356]
	mov	r0, r5
	bl	BsToNextByte
	mov	r0, r5
	bl	BsGetNextBytePtr
	mov	r6, r0
	mov	r0, r5
	bl	BsResidBits
	cmp	r0, #0
	add	r1, r0, #7
	movge	r3, r0
	movlt	r3, r1
	mov	r1, r3, asr #3
	cmp	r1, #4
	movle	r1, r4
	bgt	.L462
.L445:
	mov	r0, r5
	bl	BsLongSkip
	mov	r0, r5
	bl	BsResidBits
	add	r6, r0, #7
	cmp	r0, #0
	movlt	r0, r6
	mov	r6, r0, asr #3
	sub	r6, r6, #3
	cmp	r6, #0
	ble	.L440
	mov	r4, #0
	b	.L447
.L463:
	bl	BsSkip
	cmp	r4, r6
	beq	.L440
.L447:
	mov	r1, #24
	mov	r0, r5
	bl	BsShow
	add	r4, r4, #1
	mov	r1, #8
	cmp	r0, #1
	mov	r0, r5
	bne	.L463
	b	.L446
.L440:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L461:
	mov	r0, r4
	bl	MP2_SearchStartCode.part.1
	mov	r1, r0, asl #3
	b	.L437
.L462:
	mov	r0, r6
	bl	MP2_SearchStartCode.part.1
	mov	r1, r0, asl #3
	b	.L445
.L465:
	.align	2
.L464:
	.word	.LC34
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	next_start_code, .-next_start_code
	.align	2
	.global	GetSliceHdr
	.type	GetSliceHdr, %function
GetSliceHdr:
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
	add	r5, r0, #83968
	mov	r6, r0
	add	r5, r5, #600
	add	r7, r0, #81920
	b	.L467
.L474:
	bl	BsShow
	mov	r4, r0
	mov	r0, r5
	bl	BsPos
	sub	r3, r4, #256
	sub	r3, r3, #1
	mov	r1, #32
	cmp	r3, #174
	str	r0, [r7, #2464]
	mov	r0, r5
	bls	.L480
	bl	BsSkip
.L467:
	mov	r0, r6
	bl	next_start_code
	mov	r1, #32
	mov	r3, r0
	cmp	r3, #1
	mov	r0, r5
	beq	.L474
	cmn	r3, #1
	beq	.L469
.L475:
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L469:
	ldr	r3, .L481
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L476
	add	r6, r6, #81920
	mov	r3, #0
	mov	r2, r3
	mov	r1, #113
	ldr	r0, [r6, #4088]
	blx	ip
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L480:
	bl	BsResidBits
	cmp	r0, #40
	ble	.L469
	ldr	r3, [r7, #2400]
	mov	r2, #0
	str	r2, [r7, #2460]
	cmp	r3, r2
	bne	.L473
	mov	r0, r6
	bl	MP2_GetSequenceInfo
	ldr	r3, [r7, #2452]
	cmp	r3, #0
	beq	.L475
.L473:
	mov	r0, r6
	bl	MP2_ProtocolPPSCheck
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L476:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L482:
	.align	2
.L481:
	.word	g_event_report
	.fnend
	.size	GetSliceHdr, .-GetSliceHdr
	.align	2
	.global	sequence_header
	.type	sequence_header, %function
sequence_header:
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
	add	r4, r0, #83968
	add	r6, r4, #600
	add	r7, r0, #81920
	mov	r2, #65536
	mov	r3, #0
	str	r2, [r7, #2404]
	mov	r1, #12
	str	r3, [r7, #2400]
	mov	r5, r0
	mov	r0, r6
	ldr	r8, [r7, #3728]
	bl	BsGet
	mov	r1, #12
	str	r0, [r8, #48]
	mov	r0, r6
	bl	BsGet
	mov	r1, #4
	str	r0, [r8, #52]
	mov	r0, r6
	bl	BsGet
	mov	r1, #4
	str	r0, [r8, #84]
	mov	r0, r6
	bl	BsGet
	mov	r1, #18
	str	r0, [r8, #88]
	mov	r0, r6
	bl	BsGet
	mov	r1, #1
	str	r0, [r8, #92]
	mov	r0, r6
	bl	BsGet
	cmp	r0, #0
	ldreq	r3, [r7, #2404]
	orreq	r3, r3, #1
	streq	r3, [r7, #2404]
.L484:
	mov	r1, #10
	mov	r0, r6
	bl	BsGet
	mov	r1, #1
	str	r0, [r8, #96]
	mov	r0, r6
	bl	BsGet
	mov	r1, #1
	strb	r0, [r8, #1]
	mov	r0, r6
	bl	BsGet
	cmp	r0, #1
	str	r0, [r8, #76]
	beq	.L491
	ldr	r2, .L498
	add	r3, r4, #628
	add	r0, r4, #884
.L487:
	ldrb	r1, [r2, #1]!
	str	r1, [r3, #4]!
	cmp	r3, r0
	bne	.L487
.L486:
	mov	r1, #1
	mov	r0, r6
	bl	BsGet
	cmp	r0, #1
	str	r0, [r8, #80]
	beq	.L492
	add	r5, r5, #84992
	add	r3, r4, #884
	add	r5, r5, #116
	mov	r2, #16
.L489:
	str	r2, [r3, #4]!
	cmp	r3, r5
	bne	.L489
	mov	r0, #1
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L491:
	ldr	r10, .L498+4
	add	r9, r10, #64
.L485:
	mov	r1, #8
	mov	r0, r6
	ldrb	r7, [r10, #1]!
	bl	BsGet
	add	r3, r7, #20992
	cmp	r10, r9
	add	r3, r3, #158
	str	r0, [r5, r3, asl #2]
	bne	.L485
	b	.L486
.L492:
	ldr	r7, .L498+4
	add	r8, r7, #64
.L488:
	mov	r1, #8
	mov	r0, r6
	ldrb	r4, [r7, #1]!
	bl	BsGet
	add	r3, r4, #20992
	cmp	r7, r8
	add	r3, r3, #222
	str	r0, [r5, r3, asl #2]
	bne	.L488
	mov	r0, #1
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L499:
	.align	2
.L498:
	.word	.LANCHOR2-1
	.word	.LANCHOR2+63
	.fnend
	.size	sequence_header, .-sequence_header
	.align	2
	.global	group_of_pictures_header
	.type	group_of_pictures_header, %function
group_of_pictures_header:
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
	add	r5, r0, #83968
	add	r5, r5, #600
	add	r4, r0, #81920
	mov	r1, #1
	add	r7, r4, #2560
	mov	r0, r5
	ldr	r6, [r4, #3728]
	bl	BsGet
	mov	r1, #5
	strb	r0, [r6, #2]
	mov	r0, r5
	bl	BsGet
	mov	r1, #6
	str	r0, [r6, #100]
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	str	r0, [r6, #104]
	mov	r0, r5
	bl	BsSkip
	mov	r0, r5
	mov	r1, #6
	bl	BsGet
	mov	r1, #6
	str	r0, [r6, #108]
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	str	r0, [r6, #112]
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	str	r0, [r6, #116]
	mov	r0, r5
	bl	BsGet
	add	ip, r4, #2528
	add	ip, ip, #8
	add	lr, r4, #2512
	add	r3, r4, #2544
	add	lr, lr, #12
	add	r3, r3, #4
	mov	r5, #0
	str	r0, [r6, #120]
	ldmia	ip, {r0, r1, r2}
	stmia	lr, {r0, r1, r2}
	ldmia	r3, {r0, r1, r2}
	stmia	ip, {r0, r1, r2}
	ldmia	r7, {r0, r1, r2}
	stmia	r3, {r0, r1, r2}
	str	r5, [r4, #2560]
	str	r5, [r4, #2568]
	str	r5, [r4, #2564]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	group_of_pictures_header, .-group_of_pictures_header
	.align	2
	.global	sequence_extension
	.type	sequence_extension, %function
sequence_extension:
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
	add	r6, r0, #81920
	add	r4, r0, #83968
	mov	r2, #0
	add	r4, r4, #600
	ldr	r3, [r6, #2404]
	str	r2, [r6, #2400]
	mov	r1, #8
	orr	r3, r3, #131072
	mov	r0, r4
	str	r3, [r6, #2404]
	ldr	r5, [r6, #3728]
	bl	BsGet
	mov	r1, #1
	str	r0, [r5, #124]
	mov	r0, r4
	bl	BsGet
	mov	r1, #2
	strb	r0, [r5, #27]
	mov	r0, r4
	bl	BsGet
	mov	r1, #2
	strb	r0, [r5, #28]
	mov	r0, r4
	bl	BsGet
	mov	r1, #2
	mov	r10, r0
	mov	r0, r4
	bl	BsGet
	mov	r1, #12
	mov	r8, r0
	mov	r0, r4
	bl	BsGet
	mov	r1, #1
	mov	r7, r0
	mov	r0, r4
	bl	BsGet
	cmp	r0, #0
	bne	.L502
	ldr	r3, [r6, #2404]
	orr	r3, r3, #2
	str	r3, [r6, #2404]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L502:
	mov	r1, #8
	mov	r0, r4
	bl	BsGet
	mov	r1, #1
	mov	r9, r0
	mov	r0, r4
	bl	BsGet
	mov	r1, #2
	strb	r0, [r5, #29]
	mov	r0, r4
	bl	BsGet
	mov	r1, #5
	strb	r0, [r5, #30]
	mov	r0, r4
	bl	BsGet
	ldrb	r3, [r5, #30]
	uxtb	r1, r0
	strb	r0, [r5, #31]
	add	r1, r1, #1
	add	r0, r3, #1
	bl	__aeabi_idiv
	ldr	r1, [r5, #88]
	ldr	r2, .L526
	ldr	r3, [r5, #124]
	add	r2, r2, r1, lsl #2
	tst	r3, #128
	ldr	r2, [r2, #160]
	mul	r0, r2, r0
	str	r0, [r5, #72]
	bne	.L525
	ubfx	r2, r3, #4, #3
	and	r3, r3, #15
	str	r2, [r5, #40]
	str	r3, [r5, #44]
.L505:
	ldr	r3, [r5, #48]
	ldr	r2, [r5, #52]
	ubfx	r3, r3, #0, #12
	ubfx	r2, r2, #0, #12
	orr	r3, r3, r10, asl #12
	orr	r8, r2, r8, asl #12
	str	r3, [r5, #48]
	cmp	r8, #0
	cmpne	r3, #0
	str	r8, [r5, #52]
	ldreq	r3, [r6, #2404]
	orreq	r3, r3, #1
	streq	r3, [r6, #2404]
	ldreq	r3, [r5, #48]
	cmp	r3, #8192
	bhi	.L507
	ldr	r3, [r5, #52]
	cmp	r3, #8192
	bls	.L508
.L507:
	ldr	r2, .L526+4
	ldr	r3, [r6, #2404]
	ldr	ip, [r2]
	orr	r3, r3, #1
	str	r3, [r6, #2404]
	cmp	ip, #0
	beq	.L508
	mov	r3, #0
	mov	r1, #102
	mov	r2, r3
	ldr	r0, [r6, #4088]
	blx	ip
.L508:
	ldr	r3, [r5, #92]
	mov	r1, #400
	ldr	r2, [r5, #40]
	add	r7, r3, r7, lsl #18
	str	r7, [r5, #92]
	sub	r0, r2, #4
	ldr	r3, [r5, #96]
	mul	r7, r1, r7
	cmp	r0, #1
	add	r9, r3, r9, lsl #10
	str	r9, [r5, #96]
	str	r7, [r5, #68]
	bls	.L510
	ldr	r3, .L526+4
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L511
	mov	r3, #0
	mov	r1, #102
	mov	r2, r3
	ldr	r0, [r6, #4088]
	blx	ip
	ldr	r2, [r5, #40]
.L511:
	ldr	r1, .L526+8
	mov	r0, #1
	bl	dprint_vfmw
.L510:
	ldr	r2, [r5, #44]
	sub	r3, r2, #4
	cmp	r3, #6
	ldmlsfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	ldr	r3, .L526+4
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L512
	mov	r3, #0
	ldr	r0, [r6, #4088]
	mov	r2, r3
	mov	r1, #102
	blx	ip
	ldr	r2, [r5, #44]
.L512:
	ldr	r1, .L526+12
	mov	r0, #1
	bl	dprint_vfmw
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L525:
	and	r3, r3, #15
	cmp	r3, #5
	moveq	r2, #133
	moveq	r3, #8
	streq	r2, [r5, #40]
	streq	r3, [r5, #44]
	b	.L505
.L527:
	.align	2
.L526:
	.word	.LANCHOR0
	.word	g_event_report
	.word	.LC36
	.word	.LC37
	.fnend
	.size	sequence_extension, .-sequence_extension
	.align	2
	.global	sequence_display_extension
	.type	sequence_display_extension, %function
sequence_display_extension:
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
	add	r6, r0, #81920
	add	r4, r0, #83968
	mov	r1, #3
	ldr	r3, [r6, #2404]
	add	r4, r4, #600
	ldr	r5, [r6, #3728]
	orr	r3, r3, #262144
	mov	r0, r4
	str	r3, [r6, #2404]
	bl	BsGet
	mov	r1, #1
	str	r0, [r5, #128]
	mov	r0, r4
	bl	BsGet
	cmp	r0, #0
	str	r0, [r5, #132]
	bne	.L535
.L529:
	mov	r1, #14
	mov	r0, r4
	bl	BsGet
	mov	r1, #1
	str	r0, [r5, #148]
	mov	r0, r4
	bl	BsGet
	cmp	r0, #0
	bne	.L530
	ldr	r3, [r6, #2404]
	orr	r3, r3, #4
	str	r3, [r6, #2404]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L530:
	mov	r0, r4
	mov	r1, #14
	bl	BsGet
	str	r0, [r5, #152]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L535:
	mov	r1, #8
	mov	r0, r4
	bl	BsGet
	mov	r1, #8
	str	r0, [r5, #136]
	mov	r0, r4
	bl	BsGet
	mov	r1, #8
	str	r0, [r5, #140]
	mov	r0, r4
	bl	BsGet
	str	r0, [r5, #144]
	b	.L529
	.fnend
	.size	sequence_display_extension, .-sequence_display_extension
	.align	2
	.global	quant_matrix_extension
	.type	quant_matrix_extension, %function
quant_matrix_extension:
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
	add	r5, r0, #83968
	add	r5, r5, #600
	add	r3, r0, #81920
	mov	r7, r0
	mov	r1, #1
	mov	r0, r5
	ldr	r9, [r3, #3728]
	bl	BsGet
	cmp	r0, #1
	str	r0, [r9, #76]
	beq	.L561
.L537:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	cmp	r0, #1
	str	r0, [r9, #80]
	ldreq	r6, .L563
	addeq	r8, r6, #64
	beq	.L539
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	cmp	r0, #0
	beq	.L541
.L547:
	mov	r4, #64
.L542:
	mov	r1, #8
	mov	r0, r5
	bl	BsGet
	subs	r4, r4, #1
	bne	.L542
.L541:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	cmp	r0, #0
	beq	.L562
.L543:
	mov	r4, #64
.L544:
	mov	r1, #8
	mov	r0, r5
	bl	BsGet
	subs	r4, r4, #1
	bne	.L544
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L539:
	mov	r1, #8
	mov	r0, r5
	ldrb	r4, [r6, #1]!
	bl	BsGet
	add	r3, r4, #20992
	cmp	r6, r8
	add	r3, r3, #222
	str	r0, [r7, r3, asl #2]
	bne	.L539
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	cmp	r0, #0
	bne	.L547
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	cmp	r0, #0
	bne	.L543
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L562:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L561:
	ldr	r6, .L563
	add	r8, r6, #64
.L538:
	mov	r1, #8
	mov	r0, r5
	ldrb	r4, [r6, #1]!
	bl	BsGet
	add	r3, r4, #20992
	cmp	r6, r8
	add	r3, r3, #158
	str	r0, [r7, r3, asl #2]
	bne	.L538
	b	.L537
.L564:
	.align	2
.L563:
	.word	.LANCHOR2+63
	.fnend
	.size	quant_matrix_extension, .-quant_matrix_extension
	.align	2
	.global	sequence_scalable_extension
	.type	sequence_scalable_extension, %function
sequence_scalable_extension:
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
	add	r0, r0, #83968
	mov	r1, #32
	add	r0, r0, #600
	bl	BsSkip
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	sequence_scalable_extension, .-sequence_scalable_extension
	.align	2
	.global	picture_display_extension
	.type	picture_display_extension, %function
picture_display_extension:
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
	add	r8, r0, #81920
	add	r4, r0, #83968
	ldr	r5, [r8, #3728]
	add	r4, r4, #600
	ldr	r3, [r8, #2404]
	orr	r3, r3, #2097152
	str	r3, [r8, #2404]
	ldrb	r3, [r5, #27]
	cmp	r3, #0
	beq	.L567
	ldrb	r3, [r5, #16]
	cmp	r3, #0
	bne	.L579
.L575:
	mov	r7, #1
.L568:
	add	r5, r5, #160
	mov	r6, #0
	b	.L572
.L581:
	bl	BsGet
	mov	r1, #1
	str	r0, [r5, #12]
	mov	r0, r4
	bl	BsGet
	cmp	r0, #0
	beq	.L578
	cmp	r6, r7
	bge	.L580
.L572:
	mov	r1, #16
	mov	r0, r4
	bl	BsGet
	mov	r1, #1
	add	r6, r6, r1
	str	r0, [r5, #4]!
	mov	r0, r4
	bl	BsGet
	mov	r1, #16
	cmp	r0, #0
	mov	r0, r4
	bne	.L581
.L578:
	ldr	r3, [r8, #2404]
	orr	r3, r3, #32
	str	r3, [r8, #2404]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L567:
	ldrb	r3, [r5, #9]
	cmp	r3, #3
	bne	.L575
	ldrb	r3, [r5, #16]
	cmp	r3, #0
	moveq	r7, #2
	movne	r7, #3
	b	.L568
.L579:
	ldrb	r3, [r5, #10]
	cmp	r3, #0
	moveq	r7, #2
	movne	r7, #3
	b	.L568
.L580:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	picture_display_extension, .-picture_display_extension
	.align	2
	.global	picture_coding_extension
	.type	picture_coding_extension, %function
picture_coding_extension:
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
	add	r8, r0, #81920
	add	r4, r0, #83968
	ldr	r7, [r8, #3728]
	add	r4, r4, #600
	ldr	r3, [r8, #2404]
	add	r10, r7, #4
	add	r9, r7, #8
	orr	r3, r3, #1048576
	str	r3, [r8, #2404]
.L583:
	mov	r6, r10
	mov	r5, #0
.L585:
	mov	r1, #4
	mov	r0, r4
	bl	BsGet
	add	r5, r5, #1
	uxtb	r0, r0
	strb	r0, [r6], #1
	sub	r3, r0, #10
	cmp	r0, #0
	cmpne	r3, #4
	ldrls	r3, [r8, #2404]
	orrls	r3, r3, #16
	strls	r3, [r8, #2404]
	cmp	r5, #2
	bne	.L585
	add	r10, r10, #2
	cmp	r10, r9
	bne	.L583
	mov	r1, r5
	mov	r0, r4
	bl	BsGet
	mov	r1, r5
	strb	r0, [r7, #8]
	mov	r0, r4
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r7, #9]
	cmp	r0, #0
	bne	.L587
	ldr	r3, [r8, #2404]
	orr	r3, r3, #16
	str	r3, [r8, #2404]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L587:
	mov	r1, #1
	mov	r0, r4
	bl	BsGet
	mov	r1, #1
	strb	r0, [r7, #10]
	mov	r0, r4
	bl	BsGet
	mov	r1, #1
	strb	r0, [r7, #11]
	mov	r0, r4
	bl	BsGet
	mov	r1, #1
	strb	r0, [r7, #12]
	mov	r0, r4
	bl	BsGet
	mov	r1, #1
	strb	r0, [r7, #13]
	mov	r0, r4
	bl	BsGet
	mov	r1, #1
	strb	r0, [r7, #14]
	mov	r0, r4
	bl	BsGet
	mov	r1, #1
	strb	r0, [r7, #15]
	mov	r0, r4
	bl	BsGet
	mov	r1, #1
	strb	r0, [r7, #16]
	mov	r0, r4
	bl	BsGet
	mov	r1, #1
	strb	r0, [r7, #17]
	mov	r0, r4
	bl	BsGet
	mov	r1, #1
	strb	r0, [r7, #18]
	mov	r0, r4
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r7, #3]
	cmp	r0, #0
	ldmeqfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	mov	r1, #1
	mov	r0, r4
	bl	BsGet
	mov	r1, #3
	strb	r0, [r7, #19]
	mov	r0, r4
	bl	BsGet
	mov	r1, #1
	strb	r0, [r7, #20]
	mov	r0, r4
	bl	BsGet
	mov	r1, #7
	strb	r0, [r7, #21]
	mov	r0, r4
	bl	BsGet
	mov	r1, #8
	str	r0, [r7, #32]
	mov	r0, r4
	bl	BsGet
	str	r0, [r7, #36]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	.fnend
	.size	picture_coding_extension, .-picture_coding_extension
	.align	2
	.global	picture_spatial_scalable_extension
	.type	picture_spatial_scalable_extension, %function
picture_spatial_scalable_extension:
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
	add	r0, r0, #83968
	mov	r1, #32
	add	r0, r0, #600
	bl	BsSkip
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	picture_spatial_scalable_extension, .-picture_spatial_scalable_extension
	.align	2
	.global	picture_temporal_scalable_extension
	.type	picture_temporal_scalable_extension, %function
picture_temporal_scalable_extension:
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
	add	r0, r0, #83968
	mov	r1, #32
	add	r0, r0, #600
	bl	BsSkip
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	picture_temporal_scalable_extension, .-picture_temporal_scalable_extension
	.align	2
	.global	extra_bit_information
	.type	extra_bit_information, %function
extra_bit_information:
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
	add	r4, r0, #83968
	mov	r5, #0
	add	r4, r4, #600
	b	.L599
.L601:
	bl	BsSkip
	mov	r0, r4
	bl	BsResidBits
	add	r5, r5, #1
	cmp	r0, #8
	ble	.L600
.L599:
	mov	r1, #1
	mov	r0, r4
	bl	BsGet
	mov	r1, #8
	cmp	r0, #0
	mov	r0, r4
	bne	.L601
.L600:
	mov	r0, r5
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	extra_bit_information, .-extra_bit_information
	.align	2
	.global	picture_header
	.type	picture_header, %function
picture_header:
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
	add	r2, r0, #81920
	add	r4, r0, #83968
	mov	r1, #10
	ldr	r3, [r2, #2404]
	add	r4, r4, #600
	mov	r6, r0
	ldr	r5, [r2, #3728]
	bic	r3, r3, #3145728
	mov	r0, r4
	bic	r3, r3, #56
	orr	r3, r3, #524288
	str	r3, [r2, #2404]
	bl	BsGet
	mov	r1, #3
	str	r0, [r5, #156]
	mov	r0, r4
	bl	BsGet
	mov	r1, #16
	strb	r0, [r5, #22]
	mov	r0, r4
	bl	BsGet
	ldrb	r7, [r5, #22]
	sub	r3, r7, #2
	cmp	r3, #1
	str	r0, [r5, #160]
	bls	.L605
.L603:
	cmp	r7, #3
	beq	.L606
.L604:
	mov	r0, r6
	bl	extra_bit_information
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L606:
	mov	r1, #1
	mov	r0, r4
	bl	BsGet
	mov	r1, r7
	strb	r0, [r5, #25]
	mov	r0, r4
	bl	BsGet
	strb	r0, [r5, #26]
	b	.L604
.L605:
	mov	r1, #1
	mov	r0, r4
	bl	BsGet
	mov	r1, #3
	strb	r0, [r5, #23]
	mov	r0, r4
	bl	BsGet
	ldrb	r7, [r5, #22]
	strb	r0, [r5, #24]
	b	.L603
	.fnend
	.size	picture_header, .-picture_header
	.align	2
	.global	copyright_extension
	.type	copyright_extension, %function
copyright_extension:
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
	add	r0, r0, #83968
	mov	r1, #32
	add	r0, r0, #600
	bl	BsSkip
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	copyright_extension, .-copyright_extension
	.align	2
	.global	extension
	.type	extension, %function
extension:
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
	add	r3, r0, #81920
	add	r4, r0, #83968
	mov	r2, #0
	ldr	r3, [r3, #3728]
	add	r4, r4, #600
	mov	r5, r0
	mov	r1, #4
	mov	r0, r4
	str	r2, [r3, #148]
	str	r2, [r3, #152]
	str	r2, [r3, #128]
	str	r2, [r3, #132]
	str	r2, [r3, #136]
	str	r2, [r3, #140]
	str	r2, [r3, #144]
	bl	BsGet
	sub	r0, r0, #1
	cmp	r0, #9
	ldrls	pc, [pc, r0, asl #2]
	b	.L609
.L611:
	.word	.L610
	.word	.L612
	.word	.L613
	.word	.L614
	.word	.L614
	.word	.L609
	.word	.L616
	.word	.L617
	.word	.L614
	.word	.L614
.L616:
	mov	r0, r5
	bl	picture_display_extension
.L609:
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L614:
	mov	r0, r4
	mov	r1, #32
	bl	BsSkip
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L613:
	mov	r0, r5
	bl	quant_matrix_extension
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L617:
	mov	r0, r5
	bl	picture_coding_extension
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L610:
	mov	r0, r5
	bl	sequence_extension
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L612:
	mov	r0, r5
	bl	sequence_display_extension
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	extension, .-extension
	.align	2
	.global	MPEG2DEC_Init
	.type	MPEG2DEC_Init, %function
MPEG2DEC_Init:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #892
	sub	sp, sp, #892
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r3, [r1, #604]
	mov	r7, r1
	mov	r5, r0
	ldr	r6, .L630
	cmp	r3, #1
	addne	r4, r0, #81920
	beq	.L627
.L621:
	ldr	r8, [r4, #4080]
	movw	r2, #20496
	ldr	r3, [r6, #48]
	movt	r2, 1
	mov	r1, #0
	add	r6, r5, #84992
	mov	r0, r5
	mov	r10, #1
	blx	r3
	add	r0, r6, #664
	str	r8, [r4, #4080]
	mov	r8, #0
	bl	ResetVoQueue
	add	r2, r5, #86016
	add	r3, r5, #45056
	str	r7, [r5]
	add	r1, r6, #280
	add	r6, r6, #468
	str	r1, [r4, #3732]
	mov	r0, r5
	str	r6, [r4, #3728]
	str	r8, [r2, #4]
	mov	r2, #3
	str	r10, [r4, #2416]
	strb	r2, [r3, #297]
	str	r8, [r4, #2460]
	ldr	r3, [r7, #8]
	str	r8, [r4, #2452]
	ldr	r9, .L630
	str	r3, [r4, #2392]
	bl	VCTRL_GetChanIDByCtx
	cmn	r0, #1
	str	r0, [r4, #4088]
	beq	.L628
	ldr	r6, [r7, #604]
	cmp	r6, #1
	movne	r6, r10
	beq	.L629
.L623:
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L629:
	add	r5, r5, #83968
	ldr	r3, [r9, #52]
	sub	r1, fp, #556
	add	r0, r5, #632
	mov	r2, #256
	blx	r3
	ldr	r3, [r9, #52]
	sub	r1, fp, #300
	add	r0, r5, #888
	mov	r2, #256
	blx	r3
	ldr	r3, [r9, #52]
	sub	r1, fp, #932
	mov	r2, #188
	ldr	r0, [r4, #3728]
	blx	r3
	ldr	r3, [r9, #52]
	ldr	r0, [r4, #3732]
	mov	r2, #188
	sub	r1, fp, #744
	blx	r3
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L627:
	add	r8, r0, #83968
	add	r4, r5, #81920
	add	r1, r8, #632
	ldr	r3, [r6, #52]
	mov	r2, #256
	sub	r0, fp, #556
	blx	r3
	add	r1, r8, #888
	ldr	r3, [r6, #52]
	mov	r2, #256
	sub	r0, fp, #300
	blx	r3
	ldr	r3, [r6, #52]
	ldr	r1, [r4, #3728]
	mov	r2, #188
	sub	r0, fp, #932
	blx	r3
	ldr	r3, [r6, #52]
	ldr	r1, [r4, #3732]
	mov	r2, #188
	sub	r0, fp, #744
	blx	r3
	b	.L621
.L628:
	mov	r0, r8
	ldr	r1, .L630+4
	bl	dprint_vfmw
	mvn	r6, #19
	b	.L623
.L631:
	.align	2
.L630:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC38
	.fnend
	.size	MPEG2DEC_Init, .-MPEG2DEC_Init
	.align	2
	.global	MPEG2DEC_Destroy
	.type	MPEG2DEC_Destroy, %function
MPEG2DEC_Destroy:
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
	add	r3, r0, #81920
	ldr	r1, .L633
	mov	r0, #2
	ldr	r2, [r3, #2412]
	bl	dprint_vfmw
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L634:
	.align	2
.L633:
	.word	.LC39
	.fnend
	.size	MPEG2DEC_Destroy, .-MPEG2DEC_Destroy
	.align	2
	.global	MPEG2DEC_RecycleImage
	.type	MPEG2DEC_RecycleImage, %function
MPEG2DEC_RecycleImage:
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
	mov	r4, r1
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	add	r5, r0, #81920
	mov	r2, #0
	ldr	r0, [r5, #4088]
	bl	FSP_SetDisplay
	mov	r1, r4
	ldr	r0, [r5, #4088]
	bl	FSP_GetFsImagePtr
	cmp	r0, #0
	addne	r4, r0, #520
	addne	r6, r0, #552
	movne	r8, #0
	movne	r9, #0
	beq	.L639
.L638:
	ldr	r1, [r4, #8]!
	ldr	r0, [r5, #4088]
	bl	FreeUsdByDec
	cmp	r4, r6
	strd	r8, [r4]
	bne	.L638
.L639:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	MPEG2DEC_RecycleImage, .-MPEG2DEC_RecycleImage
	.align	2
	.global	MPEG2DEC_GetRemainImg
	.type	MPEG2DEC_GetRemainImg, %function
MPEG2DEC_GetRemainImg:
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
	ldr	r3, [r0]
	mov	r4, r0
	ldr	r3, [r3, #12]
	cmp	r3, #1
	beq	.L665
	add	r5, r0, #81920
	ldr	r1, [r5, #2484]
	ldr	r0, [r5, #4088]
	bl	FSP_GetFsImagePtr
	subs	r9, r0, #0
	beq	.L665
	ldr	r1, [r5, #2484]
	ldr	r0, [r5, #4088]
	bl	FSP_GetDisplay
	cmp	r0, #2
	beq	.L662
.L665:
	add	r6, r4, #84992
.L643:
	add	r8, r6, #664
.L649:
	mov	r0, r8
	bl	GetVoLastImageID
.L663:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L662:
	mov	r0, r4
	bl	MP2_SetImgFormat
	add	ip, r4, #83968
	add	r3, ip, #368
	add	r2, r9, #528
	add	ip, ip, #384
	mov	r0, #0
.L645:
	ldr	r1, [r3, #4]!
	mov	r7, #0
	add	r2, r2, #8
	cmp	r1, r7
	strne	r0, [r2, #-4]
	strne	r1, [r2, #-8]
	cmp	r3, ip
	str	r0, [r3]
	bne	.L645
	add	r6, r4, #84992
	mov	r3, #1
	add	r8, r6, #664
	str	r7, [r5, #2436]
	mov	r2, r3
	str	r3, [r9, #188]
	ldr	r1, [r9, #156]
	ldr	r0, [r5, #4088]
	bl	FSP_SetDisplay
	ldr	r0, [r5, #4088]
	mov	r3, r8
	str	r9, [sp]
	mov	r2, r4
	mov	r1, #3
	bl	InsertImgToVoQueue
	cmp	r0, #1
	beq	.L646
	ldr	r1, [r9, #156]
	mov	r0, r4
	bl	MPEG2DEC_RecycleImage
	b	.L649
.L646:
	ldr	r3, [r9, #160]
	cmp	r3, #100
	bhi	.L643
	ldr	r3, [r9, #112]
	cmp	r3, #31
	bls	.L643
	ldr	r3, [r9, #116]
	cmp	r3, #31
	movhi	r0, r7
	bhi	.L663
	b	.L649
	.fnend
	.size	MPEG2DEC_GetRemainImg, .-MPEG2DEC_GetRemainImg
	.align	2
	.global	MPEG2DEC_GetImageBuffer
	.type	MPEG2DEC_GetImageBuffer, %function
MPEG2DEC_GetImageBuffer:
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
	add	r3, r0, #45056
	mov	r4, r0
	add	r5, r0, #81920
	ldrb	r3, [r3, #297]
	cmp	r3, #3
	beq	.L667
	ldr	r3, [r5, #2416]
	cmp	r3, #0
	beq	.L669
.L667:
	ldr	r0, [r5, #4088]
	bl	FSP_IsNewFsAvalible
	cmp	r0, #1
	beq	.L669
	ldr	r0, [r5, #4088]
	bl	FSP_IsNewFsAvalible
	cmn	r0, #1
	beq	.L677
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L669:
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L677:
	add	r1, r4, #84992
	ldr	r0, [r5, #4088]
	add	r1, r1, #664
	bl	FSP_ClearNotInVoQueue
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	MPEG2DEC_GetImageBuffer, .-MPEG2DEC_GetImageBuffer
	.align	2
	.global	MP2_ClearCurPacket
	.type	MP2_ClearCurPacket, %function
MP2_ClearCurPacket:
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
	ldr	r1, [r1, #20]
	mov	r5, r0
	bl	SM_ReleaseStreamSeg
	ldrsb	r3, [r4]
	cmp	r3, #1
	beq	.L679
	mov	r0, r5
	ldr	r1, [r4, #24]
	bl	SM_ReleaseStreamSeg
.L679:
	ldr	r3, .L683
	mov	r0, r4
	mov	r2, #36
	mov	r1, #0
	ldr	r3, [r3, #48]
	blx	r3
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L684:
	.align	2
.L683:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	MP2_ClearCurPacket, .-MP2_ClearCurPacket
	.align	2
	.global	MP2_ReceivePacket
	.type	MP2_ReceivePacket, %function
MP2_ReceivePacket:
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
	subs	r4, r1, #0
	add	r3, r0, #36864
	beq	.L690
	mov	r5, #0
	str	r5, [r3, #2056]
	ldr	r1, [r4, #12]
	str	r1, [r3, #2100]
	ldr	r1, [r4, #8]
	str	r1, [r3, #2064]
	ldr	r1, [r4]
	str	r1, [r3, #2088]
	ldr	r1, [r4, #12]
	str	r1, [r3, #2072]
	ldrb	r1, [r4, #5]
	strb	r1, [r3, #2060]
	ldr	r1, [r4, #16]
	str	r1, [r3, #2080]
	ldrb	ip, [r4, #5]
	cmp	ip, #1
	beq	.L688
	ldr	r1, [r4, #88]
	str	r1, [r3, #2068]
	ldr	r1, [r4, #80]
	str	r1, [r3, #2092]
	ldr	r1, [r4, #92]
	str	r1, [r3, #2076]
	ldrb	r1, [r4, #85]
	strb	r1, [r3, #2061]
	ldr	r1, [r4, #96]
	str	r1, [r3, #2084]
	ldrb	ip, [r4, #85]
	cmp	ip, #1
	beq	.L689
	add	r1, r0, #38912
	mov	r0, r2
	add	r1, r1, #12
	bl	MP2_ClearCurPacket
	ldrb	r2, [r4, #85]
	ldr	r1, .L691
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r5
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L689:
	mov	r0, ip
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L688:
	str	r5, [r3, #2068]
	mov	r0, ip
	str	r5, [r3, #2092]
	str	r5, [r3, #2076]
	strb	r5, [r3, #2061]
	str	r5, [r3, #2084]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L690:
	ldr	r1, .L691+4
	mov	r0, #1
	ldr	r2, [r3, #2116]
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L692:
	.align	2
.L691:
	.word	.LC41
	.word	.LC40
	.fnend
	.size	MP2_ReceivePacket, .-MP2_ReceivePacket
	.align	2
	.global	MP2_ClearCurPic
	.type	MP2_ClearCurPic, %function
MP2_ClearCurPic:
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
	add	r6, r0, #45056
	ldr	r3, [r6, #276]
	cmp	r3, #0
	movne	r4, r0
	movne	r5, #0
	addne	r7, r4, #81920
	bne	.L696
	b	.L697
.L695:
	ldr	r3, [r6, #276]
	add	r4, r4, #44
	cmp	r5, r3
	bcs	.L697
.L696:
	ldr	r1, [r4, #300]
	add	r5, r5, #1
	ldr	r0, [r7, #4088]
	bl	SM_ReleaseStreamSeg
	ldr	r3, [r4, #280]
	cmp	r3, #0
	beq	.L695
	ldr	r3, [r4, #288]
	cmp	r3, #0
	beq	.L695
	ldr	r1, [r4, #304]
	add	r4, r4, #44
	ldr	r0, [r7, #4088]
	bl	SM_ReleaseStreamSeg
	ldr	r3, [r6, #276]
	cmp	r5, r3
	bcc	.L696
.L697:
	mov	r3, #0
	str	r3, [r6, #276]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	MP2_ClearCurPic, .-MP2_ClearCurPic
	.global	__aeabi_uidiv
	.align	2
	.global	MPEG2DEC_VDMPostProc
	.type	MPEG2DEC_VDMPostProc, %function
MPEG2DEC_VDMPostProc:
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
	ldrb	ip, [r0, #152]
	add	r4, r0, #81920
	mov	r6, r0
	mov	r2, r1
	mov	r10, r1
	mov	r0, #22
	strb	ip, [r4, #2584]
	add	r8, r6, #86016
	ldr	r1, .L778
	add	r5, r6, #8
	ldr	r7, [r4, #3728]
	bl	dprint_vfmw
	ldr	r2, [r4, #3728]
	add	r9, r6, #45056
	ldr	r1, [r6]
	ldr	r0, [r2, #40]
	str	r0, [r1, #564]
	ldr	r1, [r2, #44]
	ldr	r2, [r6]
	str	r1, [r2, #568]
	ldr	r2, [r4, #4092]
	ldr	r1, [r8]
	ldr	r0, [r6]
	cmp	r2, r1
	rsbge	r2, r1, r2
	movlt	r2, #0
	str	r2, [r0, #572]
	mov	r0, r6
	bl	MP2_ClearCurPic
	ldr	ip, .L778+4
	movw	r2, #45344
	mov	r0, r5
	mov	r1, #0
	ldr	ip, [ip, #48]
	blx	ip
	ldr	r1, [r4, #2488]
	ldr	r0, [r4, #4088]
	bl	FSP_GetFsImagePtr
	ldr	r1, [r4, #2484]
	mov	r5, r0
	ldr	r0, [r4, #4088]
	bl	FSP_GetFsImagePtr
	ldr	r1, [r4, #2480]
	str	r0, [fp, #-48]
	ldr	r0, [r4, #4088]
	bl	FSP_GetFsImagePtr
	cmp	r5, #0
	beq	.L772
	ldrb	r2, [r7, #22]
	cmp	r10, #0
	strb	r2, [r9, #296]
	str	r10, [r5, #160]
	blt	.L710
	cmp	r10, #100
	movlt	r3, r10
	movge	r3, #100
	str	r3, [r5, #160]
	ldrb	r2, [r7, #22]
	cmp	r2, #3
	beq	.L711
	ldr	r2, [r6]
	ldr	r2, [r2]
	cmp	r3, r2
	bhi	.L773
.L711:
	ldr	r1, .L778+8
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r6
	bl	MP2_SetImgFormat
	ldr	r3, [r6]
	ldr	r3, [r3, #592]
	cmp	r3, #1
	movne	r3, #0
	strne	r3, [r5, #80]
	strne	r3, [r5, #84]
	beq	.L774
.L717:
	ldrb	r3, [r7, #9]
	cmp	r3, #3
	beq	.L720
	ldr	r3, [r4, #2416]
	cmp	r3, #1
	movne	r0, #1
	beq	.L720
.L767:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L720:
	add	r1, r6, #83968
	add	r5, r5, #528
	add	r3, r1, #368
	add	r1, r1, #384
	mov	r0, #0
.L719:
	ldr	r2, [r3, #4]!
	mov	ip, #0
	add	r5, r5, #8
	cmp	r2, ip
	strne	r0, [r5, #-4]
	strne	r2, [r5, #-8]
	cmp	r3, r1
	str	r0, [r3]
	bne	.L719
	str	ip, [r4, #2436]
	ldr	r3, [r6]
	ldr	r3, [r3, #12]
	cmp	r3, #1
	beq	.L722
	ldrb	r3, [r7, #22]
	cmp	r3, #3
	beq	.L722
	ldr	r1, [r4, #2480]
	str	r1, [r4, #2492]
.L723:
	cmn	r1, #1
	beq	.L725
	ldr	r0, [r4, #4088]
	bl	FSP_GetDisplay
	cmp	r0, #1
	beq	.L729
	ldr	r1, [r4, #2492]
	ldr	r0, [r4, #4088]
	bl	FSP_GetDisplay
	cmp	r0, #2
	beq	.L729
.L725:
	ldrb	r3, [r7, #27]
	cmp	r3, #1
	beq	.L775
	ldrb	r3, [r7, #18]
	cmp	r3, #1
	ldr	r3, [r4, #2568]
	addeq	r3, r3, #1
	addne	r3, r3, #1
	streq	r3, [r4, #2568]
	ldreqb	r3, [r7, #16]
	ldreq	r2, [r4, #2564]
	addeq	r3, r3, #2
	strne	r3, [r4, #2568]
	addeq	r3, r2, r3
	movne	r3, r3, asl #1
	str	r3, [r4, #2564]
.L736:
	ldr	r2, [r4, #2560]
	mov	r0, #1
	ldr	r3, [r4, #2412]
	add	r2, r2, r0
	str	r2, [r4, #2560]
	add	r3, r3, r0
	str	r3, [r4, #2412]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L710:
	mov	r3, #0
	str	r3, [r5, #160]
	b	.L711
.L773:
	ldr	r1, [r4, #2484]
	ldr	r0, [r4, #4088]
	bl	FSP_GetFsImagePtr
	subs	r5, r0, #0
	beq	.L713
	ldr	r1, [r5, #528]
	add	r6, r5, #544
	ldr	r0, [r4, #4088]
	add	r7, r5, #560
	bl	FreeUsdByDec
	ldr	r1, [r5, #536]
	ldr	r0, [r4, #4088]
	add	r8, r5, #528
	bl	FreeUsdByDec
	ldr	r1, [r5, #544]
	ldr	r0, [r4, #4088]
	bl	FreeUsdByDec
	ldr	r1, [r5, #552]
	ldr	r0, [r4, #4088]
	bl	FreeUsdByDec
	mov	r0, #0
	mov	r1, #0
	mov	r2, #1
	strd	r0, [r8]
	strd	r0, [r6, #-8]
	strd	r0, [r6]
	strd	r0, [r7, #-8]
	ldr	r1, [r4, #2484]
	ldr	r0, [r4, #4088]
	bl	FSP_ClearLogicFs
	mov	r2, #1
	ldr	r1, [r4, #2480]
	ldr	r0, [r4, #4088]
	bl	FSP_ClearLogicFs
	mov	r3, #0
	ldr	r0, [r4, #4088]
	str	r3, [r4, #2480]
	str	r3, [r4, #2484]
	bl	FSP_GetFspType
	cmp	r0, #0
	beq	.L713
	ldr	r0, [r4, #4088]
	bl	FSP_GetNullLogicFs
	str	r0, [r4, #2480]
	str	r0, [r4, #2484]
.L713:
	mov	r3, #0
	mov	r0, #1
	str	r3, [r4, #2444]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L774:
	ldr	r2, .L778+12
	ldr	r2, [r2]
	add	r2, r2, #4096
	ldr	r0, [r2, #84]
	ldr	r1, [r2, #88]
	str	r3, [r5, #80]
	cmp	r1, #0
	moveq	r1, #1
	bl	__aeabi_uidiv
	str	r0, [r5, #84]
	b	.L717
.L729:
	ldr	r1, [r4, #2492]
	ldr	r0, [r4, #4088]
	bl	FSP_GetFsImagePtr
	subs	r5, r0, #0
	beq	.L776
	ldr	r2, [r5, #160]
	cmp	r2, #0
	beq	.L731
	ldr	r3, [r6]
	ldr	r3, [r3, #4]
	cmp	r2, r3
	bhi	.L777
.L731:
	ldr	r9, [r4, #2492]
	ldr	r0, [r4, #4088]
	mov	r1, r9
	bl	FSP_GetRef
	mov	r2, r9
	ldr	r1, .L778+16
	mov	r3, r0
	mov	r0, #12
	bl	dprint_vfmw
	mov	r2, #1
	ldr	r1, [r4, #2492]
	ldr	r0, [r4, #4088]
	bl	FSP_SetDisplay
	add	r3, r6, #84992
	ldr	r0, [r4, #4088]
	add	r3, r3, #664
	str	r5, [sp]
	mov	r2, r6
	mov	r1, #3
	bl	InsertImgToVoQueue
	cmp	r0, #1
	beq	.L738
	add	r6, r5, #520
	add	r5, r5, #552
	mov	r8, #0
	mov	r9, #0
.L733:
	ldr	r1, [r6, #8]!
	ldr	r0, [r4, #4088]
	bl	FreeUsdByDec
	cmp	r6, r5
	strd	r8, [r6]
	bne	.L733
	ldr	r0, [r4, #4088]
	mov	r2, #0
	ldr	r1, [r4, #2492]
	bl	FSP_SetDisplay
	mov	r0, #0
	b	.L767
.L722:
	ldr	r1, [r4, #2488]
	str	r1, [r4, #2492]
	b	.L723
.L775:
	ldrb	r2, [r7, #16]
	ldrb	r3, [r7, #10]
	ldr	r1, [r4, #2568]
	add	r3, r2, r3
	add	r3, r3, #1
	add	r3, r3, r1
	str	r3, [r4, #2568]
	mov	r3, r3, asl #1
	str	r3, [r4, #2564]
	b	.L736
.L777:
	ldr	r1, .L778+20
	mov	r0, #1
	bl	dprint_vfmw
	add	r6, r5, #520
	add	r5, r5, #552
	mov	r8, #0
	mov	r9, #0
.L734:
	ldr	r1, [r6, #8]!
	ldr	r0, [r4, #4088]
	bl	FreeUsdByDec
	cmp	r6, r5
	strd	r8, [r6]
	bne	.L734
	mov	r2, #0
	ldr	r1, [r4, #2492]
	ldr	r0, [r4, #4088]
	bl	FSP_SetDisplay
	b	.L725
.L772:
	str	r0, [sp]
	mov	r2, r5
	ldr	r3, [fp, #-48]
	mov	r0, r5
	ldr	r1, .L778+24
	bl	dprint_vfmw
	mov	r0, r5
	b	.L767
.L738:
	ldr	r3, [r8]
	add	r3, r3, #1
	str	r3, [r8]
	b	.L725
.L776:
	movw	r2, #3560
	ldr	r1, .L778+28
	bl	dprint_vfmw
	mov	r0, r5
	b	.L767
.L779:
	.align	2
.L778:
	.word	.LC42
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC44
	.word	g_HwMem
	.word	.LC46
	.word	.LC45
	.word	.LC43
	.word	.LC22
	.fnend
	.size	MPEG2DEC_VDMPostProc, .-MPEG2DEC_VDMPostProc
	.align	2
	.global	MP2_u_v
	.type	MP2_u_v, %function
MP2_u_v:
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
	mov	r5, r2
	mov	r6, r0
	mov	r7, r1
	bl	BsShow
	mov	r1, r7
	mov	r4, r0
	mov	r0, r6
	bl	BsSkip
	mov	r3, r4
	mov	r2, r5
	ldr	r1, .L781
	mov	r0, #2
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L782:
	.align	2
.L781:
	.word	.LC47
	.fnend
	.size	MP2_u_v, .-MP2_u_v
	.align	2
	.global	MP2_DecSliceHeader
	.type	MP2_DecSliceHeader, %function
MP2_DecSliceHeader:
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
	ldr	r2, [r0, #4]
	mov	r1, #1
	mov	r3, #0
	cmp	r2, #175
	mov	r5, r0
	str	r1, [r0, #16]
	ldr	r4, [r0, #52]
	str	r3, [r0, #24]
	bls	.L784
	ldr	r2, [r0]
	cmp	r2, r3
	beq	.L796
.L784:
	ldr	r1, [r5, #20]
	mov	r0, r4
	ldr	r2, [r5, #8]
	sub	r1, r1, #1
	add	r3, r1, r3
	mov	r1, #5
	mul	r3, r2, r3
	ldr	r2, .L798
	cmp	r3, #0
	subne	r3, r3, #1
	str	r3, [r5, #28]
	bl	MP2_u_v
	mov	r3, #0
	mov	r1, #1
	str	r3, [r5, #32]
	str	r0, [r5, #44]
	mov	r0, r4
	bl	BsShow
	cmp	r0, #0
	bne	.L797
.L789:
	mov	r0, r4
	ldr	r2, .L798+4
	mov	r1, #1
	bl	MP2_u_v
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L797:
	ldr	r2, .L798+8
	mov	r1, #1
	mov	r0, r4
	bl	MP2_u_v
	ldr	r2, .L798+12
	mov	r1, #1
	mov	r0, r4
	bl	MP2_u_v
	ldr	r2, .L798+16
	mov	r1, #7
	str	r0, [r5, #32]
	mov	r0, r4
	bl	MP2_u_v
	b	.L787
.L788:
	bl	MP2_u_v
	ldr	r2, .L798+20
	mov	r1, #8
	mov	r0, r4
	bl	MP2_u_v
.L787:
	mov	r1, #1
	mov	r0, r4
	bl	BsShow
	ldr	r2, .L798+4
	mov	r1, #1
	cmp	r0, #0
	mov	r0, r4
	bne	.L788
	b	.L789
.L796:
	ldr	r2, .L798+24
	mov	r1, #3
	mov	r0, r4
	bl	MP2_u_v
	mov	r3, r0, asl #7
	str	r0, [r5, #24]
	b	.L784
.L799:
	.align	2
.L798:
	.word	.LC49
	.word	.LC50
	.word	.LC51
	.word	.LC52
	.word	.LC53
	.word	.LC54
	.word	.LC48
	.fnend
	.size	MP2_DecSliceHeader, .-MP2_DecSliceHeader
	.align	2
	.global	MP2_ExitMb
	.type	MP2_ExitMb, %function
MP2_ExitMb:
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
	mov	r3, #0
	str	r3, [r0, #16]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MP2_ExitMb, .-MP2_ExitMb
	.align	2
	.global	MP2_WriteSliceInfo
	.type	MP2_WriteSliceInfo, %function
MP2_WriteSliceInfo:
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
	add	r7, r0, #45056
	mov	r4, #44
	add	r5, r0, #81920
	ldr	r2, [r7, #276]
	mov	r6, r0
	ldr	r1, [r5, #2624]
	cmp	r2, #1024
	mla	r4, r4, r2, r0
	str	r1, [r4, #312]
	ldr	r1, [r5, #2636]
	str	r1, [r4, #316]
	ldr	r1, [r5, #2632]
	str	r1, [r4, #308]
	bcs	.L807
	ldr	r2, [r5, #2672]
	add	r0, r0, #83968
	ldr	r3, [r5, #2360]
	add	r0, r0, #600
	and	r1, r2, #7
	str	r1, [r4, #292]
	add	r3, r3, r2, lsr #3
	str	r3, [r4, #276]
	ldr	r3, [r5, #2376]
	str	r3, [r4, #300]
	bl	BsResidBits
	movw	r2, #2356
	str	r0, [r4, #284]
	ldrsh	r3, [r5, r2]
	cmp	r3, #1
	beq	.L808
	cmp	r3, #256
	bne	.L806
	ldr	r1, [r5, #2364]
	mov	r2, #0
	str	r2, [r4, #296]
	str	r1, [r4, #280]
	ldr	r3, [r5, #2380]
	str	r3, [r4, #304]
	ldr	r3, [r5, #2372]
	mov	r3, r3, asl #3
	str	r3, [r4, #288]
.L805:
	ldr	r3, [r7, #276]
	mov	r0, #1
	add	r3, r3, r0
	str	r3, [r7, #276]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L807:
	mov	r3, #1024
	ldr	r1, .L809
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r6
	bl	MP2_ClearCurPic
	ldr	r3, [r5, #2404]
	mov	r0, #0
	str	r0, [r5, #2460]
	bic	r3, r3, #5767168
	str	r3, [r5, #2404]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L808:
	mov	r3, #0
	add	r4, r4, #284
	str	r3, [r4, #-4]
	str	r3, [r4, #12]
	str	r3, [r4, #20]
	str	r3, [r4, #4]
	b	.L805
.L806:
	movw	r3, #2357
	ldrsb	r2, [r5, r2]
	ldrsb	r3, [r5, r3]
	mov	r0, #1
	ldr	r1, .L809+4
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L810:
	.align	2
.L809:
	.word	.LC55
	.word	.LC56
	.fnend
	.size	MP2_WriteSliceInfo, .-MP2_WriteSliceInfo
	.align	2
	.global	MP2_MbAddrInc
	.type	MP2_MbAddrInc, %function
MP2_MbAddrInc:
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
	mov	r1, #4
	mov	r6, r0
	bl	BsShow
	ldr	r5, .L817
	add	r0, r5, r0, lsl #3
	ldr	r4, [r0, #224]
	ldr	r1, [r0, #228]
	cmp	r4, #6
	bls	.L815
	cmp	r4, #9
	beq	.L816
	mov	r1, #11
	mov	r0, r6
	bl	BsShow
	ldr	r2, .L817+4
	and	r3, r0, #127
	mov	r0, r6
	sub	r3, r3, #24
	add	r5, r5, r3, lsl #3
	ldr	r4, [r5, #352]
	ldr	r1, [r5, #356]
	bl	MP2_u_v
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L815:
	mov	r0, r6
	ldr	r2, .L817+4
	bl	MP2_u_v
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L816:
	mov	r0, r6
	ldr	r2, .L817+4
	bl	MP2_u_v
	rsb	r0, r0, #9
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L818:
	.align	2
.L817:
	.word	.LANCHOR0
	.word	.LC57
	.fnend
	.size	MP2_MbAddrInc, .-MP2_MbAddrInc
	.align	2
	.global	MP2_InitMb
	.type	MP2_InitMb, %function
MP2_InitMb:
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
	mov	r5, #0
	mov	r6, r0
	ldr	r4, [r0, #52]
	b	.L820
.L824:
	cmp	r0, #15
	beq	.L821
	cmp	r0, #8
	add	r5, r5, #33
	bne	.L832
.L821:
	ldr	r2, .L834
	mov	r1, #11
	mov	r0, r4
	bl	MP2_u_v
.L820:
	mov	r1, #11
	mov	r0, r4
	bl	BsShow
	cmp	r0, #23
	bls	.L824
	mov	r0, r4
	bl	MP2_MbAddrInc
	ldr	r4, [r6, #16]
	cmp	r4, #0
	beq	.L825
	ldr	r3, [r6, #28]
	add	r5, r5, r0
	cmp	r3, #0
	addne	r2, r5, r3
	ldr	r3, [r6, #12]
	subeq	r2, r5, #1
	str	r2, [r6, #40]
	sub	r3, r3, #1
	cmp	r2, r3
	bhi	.L833
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L832:
	ldr	r1, .L834+4
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L825:
	mov	r2, r4
	ldr	r1, .L834+8
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L833:
	ldr	r1, .L834+12
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L835:
	.align	2
.L834:
	.word	.LC59
	.word	.LC58
	.word	.LC61
	.word	.LC60
	.fnend
	.size	MP2_InitMb, .-MP2_InitMb
	.align	2
	.global	MP2_GetFirstMbInSlice
	.type	MP2_GetFirstMbInSlice, %function
MP2_GetFirstMbInSlice:
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
	mov	r4, r0
	bl	MP2_DecSliceHeader
	mov	r0, r4
	bl	MP2_InitMb
	mov	r3, #0
	str	r3, [r4, #16]
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	MP2_GetFirstMbInSlice, .-MP2_GetFirstMbInSlice
	.align	2
	.global	MP2_DecSlice
	.type	MP2_DecSlice, %function
MP2_DecSlice:
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
	add	r4, r0, #81920
	add	ip, r0, #83968
	uxtb	r1, r1
	ldr	r2, [r4, #2440]
	add	r7, ip, #544
	ldr	r3, [r4, #3728]
	add	ip, ip, #600
	ldr	lr, [r4, #2368]
	sub	r2, r2, #1
	ldr	r8, [r4, #2384]
	clz	r2, r2
	mov	r6, r0
	mov	r0, r7
	str	lr, [r4, #2628]
	mov	r2, r2, lsr #5
	str	r8, [r4, #2640]
	mov	r5, #0
	str	r2, [r4, #2592]
	ldr	r2, [r3, #60]
	str	r2, [r4, #2596]
	ldr	r2, [r3, #56]
	str	r2, [r4, #2600]
	ldr	r2, [r3, #52]
	ldr	r3, [r3, #48]
	add	r2, r2, #15
	str	r1, [r4, #2612]
	add	r3, r3, #15
	str	ip, [r4, #2644]
	mov	r2, r2, lsr #4
	mov	r3, r3, lsr #4
	mul	r3, r3, r2
	str	r3, [r4, #2604]
	bl	MP2_DecSliceHeader
	mov	r0, r7
	bl	MP2_InitMb
	str	r5, [r4, #2608]
	cmp	r0, #1
	mov	r7, r0
	beq	.L838
	ldr	r1, .L843
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L838:
	mov	r0, r6
	bl	MP2_WriteSliceInfo
	cmp	r0, #1
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	mov	r0, r7
	ldr	r1, .L843+4
	bl	dprint_vfmw
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L844:
	.align	2
.L843:
	.word	.LC62
	.word	.LC63
	.fnend
	.size	MP2_DecSlice, .-MP2_DecSlice
	.align	2
	.global	MP2_GetHDR
	.type	MP2_GetHDR, %function
MP2_GetHDR:
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
	add	r4, r0, #81920
	add	r5, r0, #83968
	add	r5, r5, #600
	add	r7, r0, #86016
	ldr	r3, [r4, #3728]
	mov	r1, #32
	ldr	r10, [r4, #3732]
	mov	r6, r0
	mov	r8, #0
	mov	r0, r5
	strb	r8, [r7, #8]
	str	r3, [fp, #-80]
	bl	BsShow
	ldr	r3, [r4, #2404]
	str	r3, [fp, #-84]
	mov	r9, r0
	mov	r0, r5
	bl	BsPos
	mov	r1, #32
	str	r0, [r4, #2464]
	mov	r0, r5
	bl	BsSkip
	movw	r3, #439
	cmp	r9, r3
	beq	.L913
	movw	r3, #435
	cmp	r9, r3
	cmpne	r9, #440
	bne	.L852
.L848:
	ldr	r3, [r4, #2460]
	cmp	r3, #1
	beq	.L914
.L849:
	movw	r3, #435
	cmp	r9, r3
	beq	.L854
.L917:
	cmp	r9, #436
	bcc	.L915
	movw	r3, #437
	cmp	r9, r3
	beq	.L858
	cmp	r9, #436
	bls	.L908
	movw	r3, #439
	cmp	r9, r3
	beq	.L908
	cmp	r9, #440
	bne	.L853
	ldr	r3, [r4, #2456]
	mov	r0, r5
	ldr	r7, [r4, #2352]
	add	r7, r3, r7
	bl	BsPos
	ldr	r1, .L921
	add	r2, r7, r0, lsr #3
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r6
	bl	group_of_pictures_header
	mov	r0, r5
	bl	BsResidBits
	cmp	r0, #0
	blt	.L916
.L908:
	mov	r5, #0
.L851:
	mov	r0, r5
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L852:
	cmp	r9, #256
	beq	.L848
	movw	r3, #435
	cmp	r9, r3
	bne	.L917
.L854:
	ldr	r3, [r4, #2456]
	mov	r0, r5
	ldr	r7, [r4, #2352]
	add	r7, r3, r7
	bl	BsPos
	ldr	r1, .L921+4
	add	r2, r7, r0, lsr #3
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r6
	bl	sequence_header
	mov	r0, r5
	bl	BsResidBits
	cmp	r0, #0
	blt	.L918
	ldr	r5, [r4, #2404]
	ands	r5, r5, #7
	bne	.L863
	ldr	r2, [fp, #-80]
	mov	r3, #1
	mov	r0, r10
	strb	r3, [r2]
	mov	r1, r2
	mov	r2, #188
	bl	memcpy
	ldr	r3, [r4, #2408]
	add	r3, r3, #1
	str	r3, [r4, #2408]
	b	.L851
.L915:
	cmp	r9, #256
	beq	.L856
	bcc	.L853
	cmp	r9, #432
	bls	.L853
	ldr	r3, [r4, #2456]
	mov	r0, r5
	ldr	r5, [r4, #2352]
	add	r5, r3, r5
	bl	BsPos
	ldr	r1, .L921+8
	add	r2, r5, r0, lsr #3
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r6
	bl	MP2_GetUsrData
	subs	r5, r0, #0
	bne	.L869
	add	r1, r6, #83968
	ldr	r0, [r4, #4088]
	add	r1, r1, #308
	bl	MP2_ClearCurPacket
	ldr	r3, .L921+12
	ldr	ip, [r3]
	cmp	ip, #0
	mvneq	r5, #0
	beq	.L851
	mov	r3, r5
	mov	r2, r5
	ldr	r0, [r4, #4088]
	mov	r1, #113
	blx	ip
	mvn	r5, #0
	b	.L851
.L856:
	ldr	r3, [r4, #2456]
	mov	r0, r5
	ldr	r7, [r4, #2352]
	add	r7, r3, r7
	bl	BsPos
	ldr	r1, .L921+16
	add	r2, r7, r0, lsr #3
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r6
	bl	picture_header
	mov	r0, r5
	bl	BsResidBits
	cmp	r0, #0
	bge	.L908
	ldr	r3, .L921+12
	ldr	r2, [fp, #-84]
	ldr	ip, [r3]
	str	r2, [r4, #2404]
	cmp	ip, #0
	beq	.L868
	mov	r3, #0
	mov	r1, #113
	mov	r2, r3
	ldr	r0, [r4, #4088]
	blx	ip
.L868:
	add	r1, r6, #83968
	ldr	r0, [r4, #4088]
	add	r1, r1, #308
	mvn	r5, #0
	bl	MP2_ClearCurPacket
	mov	r2, #256
	ldr	r1, .L921+20
	mov	r0, #1
	bl	dprint_vfmw
	b	.L851
.L914:
	ldr	r2, [r4, #2404]
	tst	r2, #4194304
	beq	.L849
	strb	r3, [r7, #8]
	orr	r2, r2, #8388608
	mov	r0, r6
	str	r2, [r4, #2404]
	mov	r2, #0
	str	r2, [r4, #2460]
	mov	r5, r3
	bl	MP2_ProtocolPPSCheck
	b	.L851
.L913:
	ldr	r3, .L921+24
	mov	r2, #32
	mov	r1, r5
	sub	r0, fp, #76
	ldr	r3, [r3, #52]
	blx	r3
	mov	r1, #32
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, #32
	str	r0, [fp, #-88]
	sub	r0, fp, #76
	bl	BsGet
	ldr	r3, [fp, #-88]
	movw	r1, #20036
	movw	r2, #20553
	movt	r1, 17221
	movt	r2, 18515
	cmp	r0, r1
	cmpeq	r3, r2
	bne	.L848
	ldr	r5, [r4, #2460]
	cmp	r5, #1
	beq	.L919
.L850:
	mov	r3, #1
	mov	r5, #0
	strb	r3, [r7, #10]
	b	.L851
.L853:
	sub	r3, r9, #256
	sub	r3, r3, #1
	cmp	r3, #174
	bhi	.L871
	ldr	r8, [r4, #2400]
	cmp	r8, #0
	beq	.L872
.L874:
	ldr	r3, [r4, #2404]
	tst	r3, #589824
	beq	.L908
	orr	r3, r3, #4194304
	mov	r0, r6
	str	r3, [r4, #2404]
	mov	r6, #1
	mov	r1, r9
	str	r6, [r4, #2460]
	bl	MP2_DecSlice
	cmp	r0, r6
	mov	r5, r0
	beq	.L851
	mov	r2, r9
	mov	r0, r6
	ldr	r1, .L921+28
	mov	r5, #0
	bl	dprint_vfmw
	b	.L851
.L858:
	ldr	r3, [r4, #2456]
	mov	r0, r5
	ldr	r7, [r4, #2352]
	add	r7, r3, r7
	bl	BsPos
	ldr	r1, .L921+32
	add	r2, r7, r0, lsr #3
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r6
	bl	extension
	mov	r0, r5
	bl	BsResidBits
	cmp	r0, #0
	bge	.L908
	ldr	r3, .L921+12
	ldr	r2, [fp, #-84]
	ldr	ip, [r3]
	str	r2, [r4, #2404]
	cmp	ip, #0
	beq	.L870
	mov	r3, #0
	mov	r1, #113
	mov	r2, r3
	ldr	r0, [r4, #4088]
	blx	ip
.L870:
	add	r1, r6, #83968
	ldr	r0, [r4, #4088]
	add	r1, r1, #308
	mvn	r5, #0
	bl	MP2_ClearCurPacket
	b	.L851
.L863:
	ldrb	r3, [r10]
	cmp	r3, #1
	beq	.L920
.L871:
	ldr	r3, .L921+12
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L908
.L907:
	mov	r3, #0
	ldr	r0, [r4, #4088]
	mov	r2, r3
	mov	r1, #113
	blx	ip
	b	.L908
.L869:
	ldr	r1, .L921+36
	mov	r0, #1
	bl	dprint_vfmw
	b	.L851
.L919:
	ldr	r3, [r4, #2404]
	tst	r3, #4194304
	beq	.L850
	strb	r5, [r7, #10]
	orr	r3, r3, #8388608
	strb	r5, [r7, #8]
	mov	r0, r6
	str	r3, [r4, #2404]
	str	r8, [r4, #2460]
	bl	MP2_ProtocolPPSCheck
	b	.L851
.L872:
	mov	r0, r6
	bl	MP2_GetSequenceInfo
	ldr	r5, [r4, #2452]
	cmp	r5, #0
	beq	.L851
	ldrb	r3, [r7, #9]
	cmp	r3, #1
	bne	.L874
	mov	r5, r8
	b	.L851
.L920:
	mov	r2, #188
	mov	r1, r10
	ldr	r0, [fp, #-80]
	bl	memcpy
	ldr	r2, .L921+12
	ldr	r3, [r4, #2404]
	ldr	ip, [r2]
	bic	r3, r3, #7
	str	r3, [r4, #2404]
	cmp	ip, #0
	bne	.L907
	b	.L908
.L916:
	ldr	r3, .L921+12
	ldr	r2, [fp, #-84]
	ldr	ip, [r3]
	str	r2, [r4, #2404]
	cmp	ip, #0
	beq	.L867
	mov	r3, #0
	mov	r1, #113
	mov	r2, r3
	ldr	r0, [r4, #4088]
	blx	ip
.L867:
	add	r1, r6, #83968
	ldr	r0, [r4, #4088]
	add	r1, r1, #308
	mvn	r5, #0
	bl	MP2_ClearCurPacket
	mov	r2, #440
	ldr	r1, .L921+40
	mov	r0, #1
	bl	dprint_vfmw
	b	.L851
.L918:
	ldr	r3, .L921+12
	ldr	r2, [fp, #-84]
	ldr	ip, [r3]
	str	r2, [r4, #2404]
	cmp	ip, #0
	beq	.L862
	mov	r3, #0
	mov	r1, #113
	mov	r2, r3
	ldr	r0, [r4, #4088]
	blx	ip
.L862:
	add	r1, r6, #83968
	ldr	r0, [r4, #4088]
	add	r1, r1, #308
	mvn	r5, #0
	bl	MP2_ClearCurPacket
	movw	r2, #435
	ldr	r1, .L921+44
	mov	r0, #1
	bl	dprint_vfmw
	b	.L851
.L922:
	.align	2
.L921:
	.word	.LC66
	.word	.LC64
	.word	.LC70
	.word	g_event_report
	.word	.LC68
	.word	.LC69
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC73
	.word	.LC72
	.word	.LC71
	.word	.LC67
	.word	.LC65
	.fnend
	.size	MP2_GetHDR, .-MP2_GetHDR
	.align	2
	.global	MPEG2DEC_Decode
	.type	MPEG2DEC_Decode, %function
MPEG2DEC_Decode:
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
	ldr	r3, .L961
	add	r5, r0, #84992
	add	r6, r0, #45312
	add	r5, r5, #120
	add	r7, r0, #81920
	add	r6, r6, #40
	ldr	r3, [r3, #52]
	mov	r2, #160
	mov	r4, r0
	mov	r0, r5
	blx	r3
	mov	r1, r5
	mov	r0, r6
	ldr	r2, [r7, #4088]
	bl	MP2_ReceivePacket
	cmp	r0, #1
	beq	.L924
	ldr	r1, .L961+4
	mov	r0, #1
	bl	dprint_vfmw
	mov	r5, #0
.L925:
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L924:
	add	r0, r4, #83968
	ldr	r2, [r7, #2368]
	add	r0, r0, #600
	ldr	r1, [r7, #2384]
	bl	BsInit
	ldr	r3, [r4]
	ldr	r2, [r3, #824]
	cmp	r2, #1
	beq	.L956
.L926:
	ldr	r3, [r7, #2404]
	str	r3, [r7, #2588]
.L927:
	mov	r0, r4
	bl	MP2_GetHDR
	add	r0, r0, #1
	cmp	r0, #1
	bls	.L957
	mov	r0, r4
	bl	MP2_DecodingDecide
	subs	r5, r0, #0
	beq	.L958
	cmn	r5, #1
	beq	.L955
	mov	r0, r4
	bl	MP2_GetPictureInfo
	subs	r5, r0, #0
	bne	.L933
	add	r1, r6, #38912
	ldr	r0, [r7, #4088]
	add	r1, r1, #12
	bl	MP2_ClearCurPacket
	mov	r0, r4
	bl	MP2_ClearCurPic
	ldr	r3, .L961+8
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L934
	ldr	r0, [r7, #4088]
	mov	r3, r5
	mov	r2, r5
	mov	r1, #113
	blx	ip
.L934:
	ldr	r1, .L961+12
	mov	r0, #1
	bl	dprint_vfmw
	mov	r5, #0
	b	.L925
.L957:
	ldr	r3, [r4]
	ldr	r2, [r3, #824]
	cmp	r2, #1
	beq	.L959
.L929:
	add	r4, r4, #86016
	ldrb	r3, [r4, #9]
	cmp	r3, #1
	beq	.L955
	add	r1, r6, #38912
	ldr	r0, [r7, #4088]
	add	r1, r1, #12
	mov	r5, #0
	bl	MP2_ClearCurPacket
	b	.L925
.L958:
	add	r1, r6, #38912
	ldr	r0, [r7, #4088]
	add	r1, r1, #12
	bl	MP2_ClearCurPacket
	mov	r0, r4
	bl	MP2_ClearCurPic
	ldr	r3, .L961+8
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L932
	ldr	r0, [r7, #4088]
	mov	r3, r5
	mov	r2, r5
	mov	r1, #113
	blx	ip
.L932:
	ldr	r1, .L961+16
	mov	r0, #22
	bl	dprint_vfmw
.L955:
	mov	r5, #0
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L956:
	ldr	r3, [r3, #864]
	cmp	r3, #1
	ldreq	r3, [r7, #2588]
	streq	r3, [r7, #2404]
	bne	.L926
	b	.L927
.L959:
	ldr	r3, [r3, #864]
	cmp	r3, #0
	beq	.L929
	b	.L955
.L933:
	mov	r0, r4
	bl	MP2_DecNewPic
	subs	r5, r0, #0
	beq	.L960
	ldr	r5, [r7, #2352]
	ldr	r3, [r7, #2456]
	ldr	r2, [r7, #2368]
	mov	r5, r5, asl #3
	add	r3, r3, r2
	str	r3, [r7, #2456]
	b	.L925
.L960:
	mov	r2, #1
	ldr	r1, [r7, #2488]
	ldr	r0, [r7, #4088]
	bl	FSP_ClearLogicFs
	add	r1, r6, #38912
	add	r1, r1, #12
	ldr	r0, [r7, #4088]
	bl	MP2_ClearCurPacket
	mov	r0, r4
	bl	MP2_ClearCurPic
	ldr	r3, .L961+8
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L936
	ldr	r0, [r7, #4088]
	mov	r3, r5
	mov	r2, r5
	mov	r1, #113
	blx	ip
.L936:
	ldr	r1, .L961+20
	mov	r0, #1
	bl	dprint_vfmw
	b	.L925
.L962:
	.align	2
.L961:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC74
	.word	g_event_report
	.word	.LC76
	.word	.LC75
	.word	.LC77
	.fnend
	.size	MPEG2DEC_Decode, .-MPEG2DEC_Decode
	.align	2
	.global	MP2_GetPacketState
	.type	MP2_GetPacketState, %function
MP2_GetPacketState:
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
	add	r0, r0, #86016
	ldrb	r3, [r0, #8]
	cmp	r3, #1
	moveq	r0, #2
	movne	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MP2_GetPacketState, .-MP2_GetPacketState
	.global	g_tmpusd
	.global	zigzag
	.global	default_intra_quantizer_matrix
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	__FUNCTION__.14833, %object
	.size	__FUNCTION__.14833, 19
__FUNCTION__.14833:
	.ascii	"MP2_DecodingDecide\000"
	.space	1
.LC0:
	.word	0
	.word	1
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	7
	.word	8
	.word	10
	.word	12
	.word	14
	.word	16
	.word	18
	.word	20
	.word	22
	.word	24
	.word	28
	.word	32
	.word	36
	.word	40
	.word	44
	.word	48
	.word	52
	.word	56
	.word	64
	.word	72
	.word	80
	.word	88
	.word	96
	.word	104
	.word	112
	.type	CSWTCH.45, %object
	.size	CSWTCH.45, 12
CSWTCH.45:
	.word	5
	.word	1
	.word	2
	.type	frame_rate_Table, %object
	.size	frame_rate_Table, 64
frame_rate_Table:
	.word	0
	.word	24551
	.word	24576
	.word	25600
	.word	30689
	.word	30720
	.word	51200
	.word	61378
	.word	61440
	.word	-1
	.word	-1
	.word	-1
	.word	-1
	.word	-1
	.word	-1
	.word	-1
	.type	tab_for_first_4bit, %object
	.size	tab_for_first_4bit, 128
tab_for_first_4bit:
	.word	8
	.word	4
	.word	9
	.word	5
	.word	5
	.word	4
	.word	4
	.word	4
	.word	3
	.word	3
	.word	3
	.word	3
	.word	2
	.word	3
	.word	2
	.word	3
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.type	tab_for_last_7bit, %object
	.size	tab_for_last_7bit, 832
tab_for_last_7bit:
	.word	33
	.word	11
	.word	32
	.word	11
	.word	31
	.word	11
	.word	30
	.word	11
	.word	29
	.word	11
	.word	28
	.word	11
	.word	27
	.word	11
	.word	26
	.word	11
	.word	25
	.word	11
	.word	24
	.word	11
	.word	23
	.word	11
	.word	22
	.word	11
	.word	21
	.word	10
	.word	21
	.word	10
	.word	20
	.word	10
	.word	20
	.word	10
	.word	19
	.word	10
	.word	19
	.word	10
	.word	18
	.word	10
	.word	18
	.word	10
	.word	17
	.word	10
	.word	17
	.word	10
	.word	16
	.word	10
	.word	16
	.word	10
	.word	15
	.word	8
	.word	15
	.word	8
	.word	15
	.word	8
	.word	15
	.word	8
	.word	15
	.word	8
	.word	15
	.word	8
	.word	15
	.word	8
	.word	15
	.word	8
	.word	14
	.word	8
	.word	14
	.word	8
	.word	14
	.word	8
	.word	14
	.word	8
	.word	14
	.word	8
	.word	14
	.word	8
	.word	14
	.word	8
	.word	14
	.word	8
	.word	13
	.word	8
	.word	13
	.word	8
	.word	13
	.word	8
	.word	13
	.word	8
	.word	13
	.word	8
	.word	13
	.word	8
	.word	13
	.word	8
	.word	13
	.word	8
	.word	12
	.word	8
	.word	12
	.word	8
	.word	12
	.word	8
	.word	12
	.word	8
	.word	12
	.word	8
	.word	12
	.word	8
	.word	12
	.word	8
	.word	12
	.word	8
	.word	11
	.word	8
	.word	11
	.word	8
	.word	11
	.word	8
	.word	11
	.word	8
	.word	11
	.word	8
	.word	11
	.word	8
	.word	11
	.word	8
	.word	11
	.word	8
	.word	10
	.word	8
	.word	10
	.word	8
	.word	10
	.word	8
	.word	10
	.word	8
	.word	10
	.word	8
	.word	10
	.word	8
	.word	10
	.word	8
	.word	10
	.word	8
	.word	9
	.word	7
	.word	9
	.word	7
	.word	9
	.word	7
	.word	9
	.word	7
	.word	9
	.word	7
	.word	9
	.word	7
	.word	9
	.word	7
	.word	9
	.word	7
	.word	9
	.word	7
	.word	9
	.word	7
	.word	9
	.word	7
	.word	9
	.word	7
	.word	9
	.word	7
	.word	9
	.word	7
	.word	9
	.word	7
	.word	9
	.word	7
	.word	8
	.word	7
	.word	8
	.word	7
	.word	8
	.word	7
	.word	8
	.word	7
	.word	8
	.word	7
	.word	8
	.word	7
	.word	8
	.word	7
	.word	8
	.word	7
	.word	8
	.word	7
	.word	8
	.word	7
	.word	8
	.word	7
	.word	8
	.word	7
	.word	8
	.word	7
	.word	8
	.word	7
	.word	8
	.word	7
	.word	8
	.word	7
	.data
	.align	2
.LANCHOR2 = . + 0
	.type	default_intra_quantizer_matrix, %object
	.size	default_intra_quantizer_matrix, 64
default_intra_quantizer_matrix:
	.byte	8
	.byte	16
	.byte	19
	.byte	22
	.byte	26
	.byte	27
	.byte	29
	.byte	34
	.byte	16
	.byte	16
	.byte	22
	.byte	24
	.byte	27
	.byte	29
	.byte	34
	.byte	37
	.byte	19
	.byte	22
	.byte	26
	.byte	27
	.byte	29
	.byte	34
	.byte	34
	.byte	38
	.byte	22
	.byte	22
	.byte	26
	.byte	27
	.byte	29
	.byte	34
	.byte	37
	.byte	40
	.byte	22
	.byte	26
	.byte	27
	.byte	29
	.byte	32
	.byte	35
	.byte	40
	.byte	48
	.byte	26
	.byte	27
	.byte	29
	.byte	32
	.byte	35
	.byte	40
	.byte	48
	.byte	58
	.byte	26
	.byte	27
	.byte	29
	.byte	34
	.byte	38
	.byte	46
	.byte	56
	.byte	69
	.byte	27
	.byte	29
	.byte	35
	.byte	38
	.byte	46
	.byte	56
	.byte	69
	.byte	83
	.type	zigzag, %object
	.size	zigzag, 64
zigzag:
	.byte	0
	.byte	1
	.byte	8
	.byte	16
	.byte	9
	.byte	2
	.byte	3
	.byte	10
	.byte	17
	.byte	24
	.byte	32
	.byte	25
	.byte	18
	.byte	11
	.byte	4
	.byte	5
	.byte	12
	.byte	19
	.byte	26
	.byte	33
	.byte	40
	.byte	48
	.byte	41
	.byte	34
	.byte	27
	.byte	20
	.byte	13
	.byte	6
	.byte	7
	.byte	14
	.byte	21
	.byte	28
	.byte	35
	.byte	42
	.byte	49
	.byte	56
	.byte	57
	.byte	50
	.byte	43
	.byte	36
	.byte	29
	.byte	22
	.byte	15
	.byte	23
	.byte	30
	.byte	37
	.byte	44
	.byte	51
	.byte	58
	.byte	59
	.byte	52
	.byte	45
	.byte	38
	.byte	31
	.byte	39
	.byte	46
	.byte	53
	.byte	60
	.byte	61
	.byte	54
	.byte	47
	.byte	55
	.byte	62
	.byte	63
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC1:
	.ascii	"image size abnormal(%dx%d)\012\000"
.LC2:
	.ascii	"mp2 actual frame size(%dx%d) exeed max config(%dx%d"
	.ascii	")\012\000"
	.space	2
.LC3:
	.ascii	"partition fs memory fail!\012\000"
	.space	1
.LC4:
	.ascii	"FSP_ConfigInstance fail!\012\000"
	.space	2
.LC5:
	.ascii	"ERROR: frm %d, integrality: %#x\012\000"
	.space	3
.LC6:
	.ascii	"ERROR: frm %d, No Img buffer is allocated\012\000"
	.space	1
.LC7:
	.ascii	"----------------- mp2 Imode -> %d -----------------"
	.ascii	"-\012\000"
	.space	2
.LC8:
	.ascii	"frm %d pic type %d struct is %d total pos %#x\012\000"
	.space	1
.LC9:
	.ascii	"NOTE: Drop non-I, cur is B\012\000"
.LC10:
	.ascii	"NOTE: Drop non-I, cur is P\012\000"
.LC11:
	.ascii	"NOTE: Drop non-I\012\000"
	.space	2
.LC12:
	.ascii	"NOTE: Drop B\012\000"
	.space	2
.LC13:
	.ascii	"%s %d pFwdImg = NULL,  pBwdImg = NULL!!\012\000"
	.space	3
.LC14:
	.ascii	"fuction return value is null,%s %d !!\012\000"
	.space	1
.LC15:
	.ascii	"dec P frame, fwd ref err(%d) > ref_thr(%d)\012\000"
.LC16:
	.ascii	"dec B frame, bwd ref err(%d) > ref_thr(%d)\012\000"
.LC17:
	.ascii	"dec B frame, fwd ref err(%d) > ref_thr(%d)\012\000"
.LC18:
	.ascii	"Protocol %d\012\000"
	.space	3
.LC19:
	.ascii	"seq size change, call vpss to release all frames.\012"
	.ascii	"\000"
	.space	1
.LC20:
	.ascii	"new seq size %dx%d\012\000"
.LC21:
	.ascii	"get frame store fail!\012\000"
	.space	1
.LC22:
	.ascii	"line: %d, pImage is NULL!\012\000"
	.space	1
.LC23:
	.ascii	"get image buffer ok: LogicFsID = %d\012\000"
	.space	3
.LC24:
	.ascii	"decode %p, disp %p, tf %p\012\000"
	.space	1
.LC25:
	.ascii	"ERROR: frm %d, lost one field\012\000"
	.space	1
.LC26:
	.ascii	"ERROR: frm %d, lost one field flg = %d, last_struct"
	.ascii	" = %d\012\000"
	.space	2
.LC27:
	.ascii	"Fatal Error: frm%d, get image buffer failed\012\000"
	.space	3
.LC28:
	.ascii	"dec_pts: %lld Usertag: %lld\012\000"
	.space	3
.LC29:
	.ascii	"---------- unref %d\012\000"
	.space	3
.LC30:
	.ascii	"++++++++++ ref %d\012\000"
	.space	1
.LC31:
	.ascii	"line: %d(pCur, pFwd, pBwd)(%p, %p, %p)\012\000"
.LC32:
	.ascii	"CurFsID(fwd%d,%d,bwd%d) abnormal!(%p,%p,%p)\012\000"
	.space	3
.LC33:
	.ascii	"dec addr: cur,cur2d,fwd,bwd,pmv = %p,%p,%p,%p,%p\012"
	.ascii	"\000"
	.space	2
.LC34:
	.ascii	"\012mpeg2 copy last 3 bytes of the first packet!\012"
	.ascii	"\012\000"
.LC35:
	.ascii	"pMp2CodecInfo->pUsrDatArray[%d] is null\012\000"
	.space	3
.LC36:
	.ascii	"ERROR: unsupported profile %d\012\000"
	.space	1
.LC37:
	.ascii	"ERROR: unsupported level %d\012\000"
	.space	3
.LC38:
	.ascii	"-1 == VCTRL_GetChanIDByCtx() Err! \012\000"
.LC39:
	.ascii	"Decoding quits at frm %d\012\000"
	.space	2
.LC40:
	.ascii	"ERROR: frm %d, Invalid packet pointer!\012\000"
.LC41:
	.ascii	"line %d, pPacket->StreamPack[1].IsLastSeg = %d\012\000"
.LC42:
	.ascii	"ErrRatio = %d\012\000"
	.space	1
.LC43:
	.ascii	"pImg is null, pCurImg %#x pBwdImg %#x pFwdImg %#x\012"
	.ascii	"\000"
	.space	1
.LC44:
	.ascii	"DEBUG: DEC over\012\000"
	.space	3
.LC45:
	.ascii	"err(%d) > out_thr(%d)\012\000"
	.space	1
.LC46:
	.ascii	"insert buf %d ref %d\012\000"
	.space	2
.LC47:
	.ascii	"%-40s%20d\012\000"
	.space	1
.LC48:
	.ascii	"slice_vertical_position\000"
.LC49:
	.ascii	"quantiser_scale_code\000"
	.space	3
.LC50:
	.ascii	"extra_bit_slice\000"
.LC51:
	.ascii	"intra_slice_flag\000"
	.space	3
.LC52:
	.ascii	"intra_slice\000"
.LC53:
	.ascii	"reserved_bits\000"
	.space	2
.LC54:
	.ascii	"extra_infrmation_slice\000"
	.space	1
.LC55:
	.ascii	"Slice num = %d >= %d\012\000"
	.space	2
.LC56:
	.ascii	"seg info is wrong! IsLastSeg[0] = %d, IsLastSeg[1] "
	.ascii	"= %d\012\000"
	.space	3
.LC57:
	.ascii	"macroblock_address_increment\000"
	.space	3
.LC58:
	.ascii	"macroblock_escape ERROR\012\000"
	.space	3
.LC59:
	.ascii	"macroblock_escape\000"
	.space	2
.LC60:
	.ascii	"SlcStartMbNum = %d > PicEndMum = %d\012\000"
	.space	3
.LC61:
	.ascii	"FirstMbInSliceFlag = %d\012\000"
	.space	3
.LC62:
	.ascii	"MP2_GetFirstMbInSlice Failed!\012\000"
	.space	1
.LC63:
	.ascii	"MP2_WriteSliceInfo Failed!\012\000"
.LC64:
	.ascii	"found sh %#x\012\000"
	.space	2
.LC65:
	.ascii	"SEQUENCE_HEADER_CODE Bitstream is not enough!\012\000"
	.space	1
.LC66:
	.ascii	"found gh %#x\012\000"
	.space	2
.LC67:
	.ascii	"GROUP_START_CODE Bitstream is not enough!\012\000"
	.space	1
.LC68:
	.ascii	"found ph %#x\012\000"
	.space	2
.LC69:
	.ascii	"PICTURE_START_CODE Bitstream is not enough!\012\000"
	.space	3
.LC70:
	.ascii	"found ud %#x\012\000"
	.space	2
.LC71:
	.ascii	"cann't get ud pointer\012\000"
	.space	1
.LC72:
	.ascii	"found ext %#x\012\000"
	.space	1
.LC73:
	.ascii	"MP2_DecSlice is wrong!\012\000"
.LC74:
	.ascii	"line %d, MP2_ReceivePacket receive packet failed!\012"
	.ascii	"\000"
	.space	1
.LC75:
	.ascii	"MP2 Decode Decide is wrong!\012\000"
	.space	3
.LC76:
	.ascii	"MP2 get picture info is wrong!\012\000"
.LC77:
	.ascii	"MP2 dec new pic failed!\012\000"
	.bss
	.align	2
.LANCHOR1 = . + 0
	.type	g_tmpusd, %object
	.size	g_tmpusd, 1024
g_tmpusd:
	.space	1024
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
