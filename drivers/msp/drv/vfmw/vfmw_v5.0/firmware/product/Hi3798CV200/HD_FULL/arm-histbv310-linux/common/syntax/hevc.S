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
	.file	"hevc.c"

	.text
	.align	2
	.type	compare_pic_by_poc_asc, %function
compare_pic_by_poc_asc:
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
	ldr	r2, [r0]
	ldr	r3, [r1]
	ldr	r2, [r2, #12]
	ldr	r3, [r3, #12]
	cmp	r2, r3
	blt	.L3
	movgt	r0, #1
	movle	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L3:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	compare_pic_by_poc_asc, .-compare_pic_by_poc_asc
	.align	2
	.type	HEVC_SetFrmRepeatCount.part.4, %function
HEVC_SetFrmRepeatCount.part.4:
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
	ldr	ip, [r0, #276]
	ldr	r2, [r0, #2504]
	ldr	r3, [r0, #272]
	add	r2, r2, ip
	add	ip, r2, #1
	cmp	r3, ip
	movcc	r3, #0
	strcc	r3, [r1, #24]
	ldmccfd	sp, {fp, sp, pc}
	sub	r3, r3, #1
	rsb	r3, r2, r3
	cmp	r3, #1
	movhi	r3, #2
	movls	r3, #1
	strhi	r3, [r1, #24]
	strls	r3, [r1, #24]
	ldrhi	r3, [r0, #276]
	ldrls	r3, [r0, #276]
	addhi	r3, r3, #2
	addls	r3, r3, #1
	str	r3, [r0, #276]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_SetFrmRepeatCount.part.4, .-HEVC_SetFrmRepeatCount.part.4
	.global	__aeabi_uidiv
	.align	2
	.global	HEVC_InitSigLastScan
	.type	HEVC_InitSigLastScan, %function
HEVC_InitSigLastScan:
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
	ldr	r4, [fp, #8]
	str	r0, [fp, #-48]
	cmp	r4, #15
	ldr	r6, [fp, #4]
	bgt	.L10
	cmp	r4, #8
	mul	r9, r4, r4
	beq	.L45
	cmp	r9, #0
	movne	r10, r6
	beq	.L10
.L12:
	mov	r5, #0
	rsb	r7, r4, #1
	mov	r8, r5
.L19:
	cmp	r4, r8
	mov	r3, r8
	mov	r1, #0
	bgt	.L21
.L16:
	sub	r3, r3, #1
	add	r1, r1, #1
	cmp	r4, r3
	ble	.L16
.L21:
	cmp	r3, #0
	cmpge	r4, r1
	ble	.L17
	mla	ip, r3, r4, r1
	add	lr, r10, r5, lsl #2
	mov	r0, r5
.L18:
	add	r0, r0, #1
	sub	r3, r3, #1
	rsb	r2, r5, r0
	str	ip, [lr], #4
	add	r2, r2, r1
	add	ip, ip, r7
	cmp	r3, #0
	cmpge	r4, r2
	bgt	.L18
	mov	r5, r0
.L17:
	cmp	r9, r5
	add	r8, r8, #1
	bhi	.L19
.L10:
	cmp	r4, #4
	ble	.L9
	mov	r3, r4, asr #2
	ldr	r1, [fp, #-48]
	str	r3, [fp, #-64]
	mov	r2, r3
	add	r3, r1, r3
	mul	r2, r2, r2
	mov	r0, r2
	str	r2, [fp, #-60]
	cmp	r0, #0
	ldrsb	r2, [r3, #10]
	add	r2, r2, #1
	beq	.L9
	add	r3, r1, #324
.L14:
	ldr	r1, .L46
	rsb	r7, r4, #1
	str	r3, [fp, #-52]
	mov	r3, #0
	add	r2, r1, r2, lsl #16
	str	r3, [fp, #-48]
	sub	r3, r2, #4
	str	r3, [fp, #-56]
.L30:
	ldr	r3, [fp, #-56]
	cmp	r4, #32
	ldr	r9, [fp, #-64]
	mov	r8, #0
	ldr	r5, [r3, #4]!
	mov	r1, r9
	str	r3, [fp, #-56]
	ldreq	r3, [fp, #-52]
	ldreq	r5, [r3]
	mov	r0, r5
	bl	__aeabi_uidiv
	ldr	ip, [fp, #-48]
	mov	r3, r8
	mov	r2, r8
	mov	lr, r8
	mov	r10, ip, asl #4
	mla	r1, r4, r0, r5
	mls	r1, r9, r0, r1
	mov	r9, r1, asl #2
.L24:
	cmp	lr, #3
	mvn	r1, r2
	mov	r1, r1, lsr #31
	movgt	r1, #0
	cmp	r1, #0
	beq	.L25
	mla	r1, r2, r4, lr
	add	r0, r3, r10
	rsb	lr, r3, lr
	add	r0, r6, r0, lsl #2
	add	r1, r1, r9
.L26:
	add	r3, r3, #1
	sub	r2, r2, #1
	add	r5, lr, r3
	str	r1, [r0], #4
	cmp	r5, #3
	mvn	ip, r2
	mov	ip, ip, lsr #31
	add	r1, r1, r7
	movgt	ip, #0
	cmp	ip, #0
	bne	.L26
.L25:
	cmp	r3, #15
	add	r8, r8, #1
	bhi	.L27
	cmp	r8, #3
	movle	r2, r8
	movle	lr, #0
	subgt	lr, r8, #3
	movgt	r2, #3
	b	.L24
.L27:
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-48]
	add	r2, r2, #4
	str	r2, [fp, #-52]
	ldr	r2, [fp, #-60]
	add	r3, r3, #1
	str	r3, [fp, #-48]
	cmp	r3, r2
	bne	.L30
.L9:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L45:
	add	r3, r0, #324
	cmp	r9, #0
	mov	r10, r3
	bne	.L12
	ldr	r2, [fp, #-48]
	mov	r1, #2
	str	r1, [fp, #-64]
	mov	r1, #4
	str	r1, [fp, #-60]
	ldrsb	r2, [r2, #12]
	add	r2, r2, #1
	b	.L14
.L47:
	.align	2
.L46:
	.word	.LANCHOR0
	.fnend
	.size	HEVC_InitSigLastScan, .-HEVC_InitSigLastScan
	.align	2
	.global	HEVC_InitScalingOrderTable
	.type	HEVC_InitScalingOrderTable, %function
HEVC_InitScalingOrderTable:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #16
	sub	sp, sp, #16
	push	{lr}
	bl	__gnu_mcount_nc
	add	r3, r0, #9
	add	r1, r0, #138
	mov	r7, r0
	mvn	r2, #0
.L49:
	strb	r2, [r3, #1]!
	cmp	r3, r1
	bne	.L49
	ldr	r6, .L53
	mov	r2, #0
	mov	r3, #2
	mov	r5, r2
	mov	r4, r3
	strb	r2, [r7, #14]
	strb	r3, [r7, #26]
	mov	r2, #1
	mov	r3, #3
	strb	r2, [r7, #18]
	strb	r3, [r7, #42]
	mov	r3, #4
	strb	r3, [r7, #74]
.L50:
	mov	r3, #0
	str	r5, [sp, #12]
	str	r4, [sp, #8]
	add	r5, r5, #1
	str	r4, [sp, #4]
	mov	r2, r3
	str	r6, [sp]
	mov	r1, r3
	mov	r0, r7
	mov	r4, r4, asl #1
	bl	HEVC_InitSigLastScan
	cmp	r5, #7
	add	r6, r6, #65536
	bne	.L50
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L54:
	.align	2
.L53:
	.word	.LANCHOR0
	.fnend
	.size	HEVC_InitScalingOrderTable, .-HEVC_InitScalingOrderTable
	.global	__aeabi_idiv
	.align	2
	.global	HEVCGetDar
	.type	HEVCGetDar, %function
HEVCGetDar:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, fp, ip, lr, pc}
	.pad #4
	.save {r4, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #12
	sub	sp, sp, #12
	push	{lr}
	bl	__gnu_mcount_nc
	cmp	r0, #0
	mov	ip, r1
	moveq	r4, r0
	beq	.L56
	subs	lr, r0, #255
	movne	lr, #1
	cmp	r0, #16
	movle	r4, #0
	andgt	r4, lr, #1
	cmp	r4, #0
	movne	r4, #0
	bne	.L56
	cmp	r2, #0
	cmpne	r1, #0
	moveq	r1, #1
	movne	r1, #0
	cmp	r0, #255
	movne	r1, #0
	andeq	r1, r1, #1
	cmp	r1, #0
	bne	.L56
	cmp	r0, #1
	moveq	r4, #5
	beq	.L56
	cmp	lr, #0
	str	r3, [fp, #-24]
	ldrne	r2, .L82
	addne	r1, r2, r0, lsl #3
	ldrne	ip, [r2, r0, asl #3]
	ldrne	r2, [r1, #4]
	mov	r0, ip, asl #10
	mov	r1, r2
	bl	__aeabi_idiv
	ldr	r3, [fp, #-24]
	ldr	r1, [fp, #4]
	mov	r4, r0
	mov	r0, r3, asl #10
	bl	__aeabi_idiv
	mul	r0, r0, r4
	add	r2, r0, #1020
	cmp	r0, #0
	add	r2, r2, #3
	movlt	r0, r2
	mov	r2, r0, asr #10
	sub	r3, r2, #2400
	sub	r1, r2, #2256
	sub	r3, r3, #6
	sub	r1, r1, #7
	cmp	r3, #0
	rsblt	r3, r2, #2400
	addlt	r3, r3, #6
	cmp	r1, #0
	rsblt	r1, r2, #2256
	addlt	r1, r1, #7
	cmp	r3, r1
	movlt	r4, #4
	blt	.L56
	sub	r3, r2, #1808
	sub	r3, r3, #12
	cmp	r3, #0
	rsblt	r3, r2, #1808
	addlt	r3, r3, #12
	cmp	r1, r3
	movlt	r4, #3
	bge	.L81
.L56:
	mov	r2, r4
	ldr	r1, .L82+4
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r4
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L81:
	sub	r0, r2, #1360
	sub	r0, r0, #5
	cmp	r0, #0
	rsblt	r0, r2, #1360
	addlt	r0, r0, #5
	cmp	r3, r0
	movlt	r4, #2
	movge	r4, #1
	b	.L56
.L83:
	.align	2
.L82:
	.word	.LANCHOR1
	.word	.LC2
	.fnend
	.size	HEVCGetDar, .-HEVCGetDar
	.align	2
	.global	HEVC_PrintNaluArraySlot
	.type	HEVC_PrintNaluArraySlot, %function
HEVC_PrintNaluArraySlot:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #12
	sub	sp, sp, #12
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r1, .L91
	mov	r5, r0
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r5, #160]
	cmn	r3, #1
	beq	.L88
	mov	r8, #0
	movw	r6, #52429
	add	r7, r5, #65536
	mov	r4, r8
	movt	r6, 52428
	b	.L87
.L86:
	ldr	r3, [r5, #160]
	add	r3, r3, #1
	cmp	r3, r4
	bls	.L88
.L87:
	ldr	r3, [r7, #1736]
	mov	r2, r4
	ldr	r1, .L91+4
	mov	r0, #1
	add	r3, r3, r8
	add	r8, r8, #100
	ldr	ip, [r3, #36]
	str	ip, [sp]
	bl	dprint_vfmw
	umull	r2, r3, r4, r6
	mov	r2, r3, lsr #3
	mov	r3, r2, asl #3
	add	r3, r3, r2, lsl #1
	cmp	r4, r3
	add	r4, r4, #1
	bne	.L86
	ldr	r1, .L91+8
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r5, #160]
	add	r3, r3, #1
	cmp	r3, r4
	bhi	.L87
.L88:
	ldr	r1, .L91+8
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r1, .L91+12
	mov	r0, #1
	bl	dprint_vfmw
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L92:
	.align	2
.L91:
	.word	.LC3
	.word	.LC6
	.word	.LC4
	.word	.LC5
	.fnend
	.size	HEVC_PrintNaluArraySlot, .-HEVC_PrintNaluArraySlot
	.align	2
	.global	HEVC_PrintCurrSlicelistX
	.type	HEVC_PrintCurrSlicelistX, %function
HEVC_PrintCurrSlicelistX:
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
	add	r6, r0, #53248
	mov	r7, r0
	ldr	r1, .L115
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r2, [r6, #1080]
	ldr	r1, .L115+4
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r6, #1080]
	cmp	r3, #0
	addne	r5, r7, #2320
	movne	r4, #0
	addne	r5, r5, #12
	beq	.L101
.L100:
	ldr	r3, [r5, #4]!
	mov	r2, r4
	ldr	r1, .L115+8
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #1
	ldr	r3, [r5]
	add	r4, r4, r0
	ldr	r1, .L115+12
	cmp	r3, #0
	beq	.L98
	ldr	r2, [r3, #32]
	bl	dprint_vfmw
	ldr	r3, [r5]
	ldr	r3, [r3, #32]
	cmp	r3, #0
	beq	.L98
	ldr	r1, [r3, #32]
	ldr	r0, [r7, #244]
	bl	FSP_GetLogicFs
	ldr	r1, .L115+16
	mov	r2, r0
	mov	r0, #1
	bl	dprint_vfmw
.L98:
	ldr	r1, .L115+20
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r6, #1080]
	cmp	r3, r4
	bhi	.L100
.L101:
	ldr	r2, [r6, #1084]
	mov	r0, #1
	ldr	r1, .L115+24
	bl	dprint_vfmw
	ldr	r3, [r6, #1084]
	cmp	r3, #0
	addne	r5, r7, #2400
	movne	r4, #0
	beq	.L96
.L105:
	ldr	r3, [r5, #4]!
	mov	r2, r4
	ldr	r1, .L115+28
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #1
	ldr	r3, [r5]
	add	r4, r4, r0
	ldr	r1, .L115+12
	cmp	r3, #0
	beq	.L103
	ldr	r2, [r3, #32]
	bl	dprint_vfmw
	ldr	r3, [r5]
	ldr	r3, [r3, #32]
	cmp	r3, #0
	beq	.L103
	ldr	r1, [r3, #32]
	ldr	r0, [r7, #244]
	bl	FSP_GetLogicFs
	ldr	r1, .L115+16
	mov	r2, r0
	mov	r0, #1
	bl	dprint_vfmw
.L103:
	ldr	r1, .L115+20
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r6, #1084]
	cmp	r3, r4
	bhi	.L105
.L96:
	ldr	r1, .L115+32
	mov	r0, #1
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L116:
	.align	2
.L115:
	.word	.LC7
	.word	.LC8
	.word	.LC10
	.word	.LC11
	.word	.LC12
	.word	.LC4
	.word	.LC9
	.word	.LC14
	.word	.LC13
	.fnend
	.size	HEVC_PrintCurrSlicelistX, .-HEVC_PrintCurrSlicelistX
	.align	2
	.global	HEVC_PrintFrameStoreState
	.type	HEVC_PrintFrameStoreState, %function
HEVC_PrintFrameStoreState:
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
	ldr	r1, .L125
	mov	r10, r0
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r10, #176]
	cmp	r3, #0
	addne	r8, r10, #67584
	movne	r9, #0
	addne	r8, r8, #496
	beq	.L121
.L120:
	ldrb	ip, [r8, #2]
	mov	r3, r8
	mov	r2, r9
	ldr	r1, .L125+4
	mov	r0, #1
	add	r5, r8, #592
	str	ip, [sp, #8]
	mov	r4, #0
	ldrb	ip, [r8, #1]
	str	ip, [sp, #4]
	ldr	ip, [r8, #4]
	str	ip, [sp]
	bl	dprint_vfmw
.L119:
	ldrd	r6, [r5, #8]!
	mov	r2, r4
	ldr	r1, .L125+8
	add	r4, r4, #1
	mov	r0, #1
	strd	r6, [sp]
	bl	dprint_vfmw
	cmp	r4, #4
	bne	.L119
	ldr	r1, .L125+12
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r10, #176]
	add	r9, r9, #1
	add	r8, r8, #664
	cmp	r3, r9
	bhi	.L120
.L121:
	ldr	r1, .L125+16
	mov	r0, #1
	bl	dprint_vfmw
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L126:
	.align	2
.L125:
	.word	.LC15
	.word	.LC17
	.word	.LC18
	.word	.LC4
	.word	.LC16
	.fnend
	.size	HEVC_PrintFrameStoreState, .-HEVC_PrintFrameStoreState
	.align	2
	.global	HEVC_PrintAPCState
	.type	HEVC_PrintAPCState, %function
HEVC_PrintAPCState:
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
	ldr	r1, .L130
	mov	r5, r0
	mov	r7, r0
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r5, #2800]
	ldr	r2, [r7, #2804]!
	mov	r0, #1
	ldr	r1, .L130+4
	add	r6, r5, #2864
	bl	dprint_vfmw
	add	r5, r5, #2928
	add	r6, r6, #4
	add	r5, r5, #4
	mov	r4, #0
.L128:
	ldr	lr, [r5, #4]!
	mov	r2, r4
	ldr	ip, [r6, #4]!
	add	r4, r4, #1
	ldr	r3, [r7, #4]!
	mov	r0, #1
	ldr	r1, .L130+8
	stmia	sp, {ip, lr}
	bl	dprint_vfmw
	cmp	r4, #16
	bne	.L128
	ldr	r1, .L130+12
	mov	r0, #1
	bl	dprint_vfmw
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L131:
	.align	2
.L130:
	.word	.LC19
	.word	.LC20
	.word	.LC21
	.word	.LC22
	.fnend
	.size	HEVC_PrintAPCState, .-HEVC_PrintAPCState
	.align	2
	.global	HEVC_PrintDPBState
	.type	HEVC_PrintDPBState, %function
HEVC_PrintDPBState:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #68
	sub	sp, sp, #68
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r1, .L149
	mov	r9, r0
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r1, [r9, #2520]
	ldr	lr, [r9, #2516]
	mov	r0, #1
	ldr	ip, [r9, #2524]
	ldr	r3, [r9, #2508]
	ldr	r2, [r9, #2504]
	stmia	sp, {r1, ip, lr}
	ldr	r1, .L149+4
	bl	dprint_vfmw
	ldr	r3, [r9, #2508]
	cmp	r3, #0
	addne	r4, r9, #2512
	movne	r5, #0
	addne	r4, r4, #12
	beq	.L137
.L136:
	ldr	r3, [r4, #4]!
	ldr	r0, [r9, #244]
	ldr	ip, [r3, #4]
	ldrb	r2, [r3]
	ldrb	lr, [r3, #1]
	str	ip, [fp, #-52]
	ldr	ip, [r3, #52]
	ldr	r1, [r3, #32]
	str	r2, [fp, #-48]
	str	lr, [fp, #-56]
	str	ip, [fp, #-60]
	ldrb	r8, [r3, #2]
	ldr	r10, [r3, #12]
	bl	FSP_GetLogicFs
	ldr	r3, [r4]
	ldr	r1, [r3, #32]
	mov	r6, r0
	ldr	r0, [r9, #244]
	bl	FSP_GetRef
	ldr	r3, [r4]
	ldr	r1, [r3, #32]
	mov	r7, r0
	ldr	r0, [r9, #244]
	bl	FSP_GetDisplay
	ldr	r1, [r4]
	ldr	ip, [fp, #-60]
	mov	r2, r5
	add	r5, r5, #1
	ldr	lr, [r1, #228]
	mov	r3, r1
	str	lr, [sp, #40]
	ldr	r1, [r1, #32]
	ldr	lr, [fp, #-56]
	str	ip, [sp, #20]
	str	r1, [sp, #36]
	ldr	ip, [fp, #-52]
	ldr	r1, [fp, #-48]
	str	r10, [sp, #16]
	str	r8, [sp, #12]
	str	r1, [sp]
	str	lr, [sp, #8]
	str	ip, [sp, #4]
	str	r7, [sp, #28]
	str	r6, [sp, #24]
	ldr	r1, .L149+8
	str	r0, [sp, #32]
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r9, #2508]
	cmp	r3, r5
	bhi	.L136
.L137:
	ldr	r1, .L149+12
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r9, #2508]
	cmp	r3, #0
	addne	r5, r9, #2512
	movne	r6, #0
	addne	r5, r5, #12
	bne	.L144
	b	.L135
.L148:
	bl	dprint_vfmw
	ldr	r2, [r4, #600]
	ldr	r1, .L149+16
	mov	r0, #1
	bl	dprint_vfmw
	ldrsb	r2, [r4]
	ldr	r1, .L149+20
	mov	r0, #1
	bl	dprint_vfmw
	ldrsb	r2, [r4, #1]
	ldr	r1, .L149+24
	mov	r0, #1
	bl	dprint_vfmw
.L139:
	cmp	r8, #0
	mov	r2, r8
	ldr	r1, .L149+28
	mov	r0, #1
	beq	.L140
	bl	dprint_vfmw
	ldr	r2, [r8, #88]
	ldr	r1, .L149+32
	mov	r0, #1
	bl	dprint_vfmw
.L141:
	cmp	r7, #0
	mov	r2, r7
	ldr	r1, .L149+36
	mov	r0, #1
	beq	.L142
	bl	dprint_vfmw
	ldr	r2, [r7, #88]
	ldr	r1, .L149+40
	mov	r0, #1
	bl	dprint_vfmw
.L143:
	ldr	r1, .L149+12
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r9, #2508]
	add	r6, r6, #1
	cmp	r3, r6
	bls	.L135
.L144:
	ldr	r3, [r5, #4]!
	ldr	r0, [r9, #244]
	ldr	r1, [r3, #32]
	bl	FSP_GetLogicFs
	ldr	r3, [r5]
	ldr	r1, [r3, #32]
	mov	r4, r0
	ldr	r0, [r9, #244]
	bl	FSP_GetDecPhyFs
	ldr	r3, [r5]
	ldr	r1, [r3, #32]
	mov	r8, r0
	ldr	r0, [r9, #244]
	bl	FSP_GetDispPhyFs
	mov	r2, r6
	ldr	r1, .L149+44
	mov	r7, r0
	mov	r0, #1
	bl	dprint_vfmw
	cmp	r4, #0
	mov	r2, r4
	ldr	r1, .L149+48
	mov	r0, #1
	bne	.L148
	ldr	r1, .L149+52
	mov	r0, #1
	bl	dprint_vfmw
	b	.L139
.L142:
	ldr	r1, .L149+56
	mov	r0, #1
	bl	dprint_vfmw
	b	.L143
.L140:
	ldr	r1, .L149+60
	mov	r0, #1
	bl	dprint_vfmw
	b	.L141
.L135:
	ldr	r1, .L149+64
	mov	r0, #1
	bl	dprint_vfmw
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L150:
	.align	2
.L149:
	.word	.LC23
	.word	.LC24
	.word	.LC25
	.word	.LC4
	.word	.LC29
	.word	.LC30
	.word	.LC31
	.word	.LC33
	.word	.LC34
	.word	.LC36
	.word	.LC37
	.word	.LC27
	.word	.LC28
	.word	.LC32
	.word	.LC38
	.word	.LC35
	.word	.LC26
	.fnend
	.size	HEVC_PrintDPBState, .-HEVC_PrintDPBState
	.align	2
	.global	HEVC_IsSliceUnit
	.type	HEVC_IsSliceUnit, %function
HEVC_IsSliceUnit:
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
	cmp	r0, #9
	bls	.L153
	sub	r0, r0, #16
	cmp	r0, #5
	movhi	r0, #0
	movls	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L153:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_IsSliceUnit, .-HEVC_IsSliceUnit
	.align	2
	.global	HEVC_IsIUnit
	.type	HEVC_IsIUnit, %function
HEVC_IsIUnit:
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
	sub	r0, r0, #16
	cmp	r0, #5
	movhi	r0, #0
	movls	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_IsIUnit, .-HEVC_IsIUnit
	.align	2
	.global	HEVC_IsNonRefPic
	.type	HEVC_IsNonRefPic, %function
HEVC_IsNonRefPic:
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
	bics	r0, r0, #6
	subne	r0, r0, #8
	clzne	r0, r0
	movne	r0, r0, lsr #5
	moveq	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_IsNonRefPic, .-HEVC_IsNonRefPic
	.align	2
	.global	HEVC_IsFlushUnit
	.type	HEVC_IsFlushUnit, %function
HEVC_IsFlushUnit:
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
	sub	r0, r0, #16
	cmp	r0, #4
	movhi	r0, #0
	movls	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_IsFlushUnit, .-HEVC_IsFlushUnit
	.align	2
	.global	HEVC_IsPVRFlushPic
	.type	HEVC_IsPVRFlushPic, %function
HEVC_IsPVRFlushPic:
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
	add	r3, r0, #53248
	ldr	r3, [r3, #292]
	cmp	r3, #0
	bne	.L161
	ldr	r2, [r0, #2324]
	ldr	r1, [r2, #632]
	cmp	r1, #1
	beq	.L165
.L163:
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L161:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L165:
	ldr	r0, [r2, #628]
	cmp	r0, #0
	bne	.L163
	ldr	r3, [r2, #636]
	cmp	r3, #0
	ldmnefd	sp, {fp, sp, pc}
	ldr	r3, [r2, #600]
	add	r3, r3, #1024
	cmp	r3, #2048
	movls	r0, #0
	movhi	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_IsPVRFlushPic, .-HEVC_IsPVRFlushPic
	.align	2
	.global	HEVC_IsEosNal
	.type	HEVC_IsEosNal, %function
HEVC_IsEosNal:
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
	mov	r1, #32
	mov	r4, r0
	ldr	r0, [r0, #2308]
	bl	BsGet
	mov	r1, #32
	mov	r5, r0
	ldr	r0, [r4, #2308]
	bl	BsGet
	movw	r2, #20036
	movw	r3, #20553
	movt	r2, 17221
	movt	r3, 18515
	cmp	r0, r2
	cmpeq	r5, r3
	moveq	r0, #1
	movne	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	HEVC_IsEosNal, .-HEVC_IsEosNal
	.align	2
	.global	HEVC_CalcTileInfo
	.type	HEVC_CalcTileInfo, %function
HEVC_CalcTileInfo:
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
	add	r5, r0, #24576
	str	r3, [fp, #-48]
	mov	r6, r2
	mov	r8, r1
	ldr	r3, [r5, #2784]
	ldr	r2, [r5, #2780]
	ldr	r7, [r3, #68]
	ldr	r9, [r3, #72]
	ldr	r2, [r2, #148]
	sub	r3, r7, #1
	cmp	r3, #9
	str	r2, [fp, #-52]
	bhi	.L195
	sub	r3, r9, #1
	cmp	r3, #10
	bhi	.L196
	ldr	r4, .L197
	mov	r2, #512
	mov	r1, #0
	mov	r0, r8
	ldr	r3, [r4, #48]
	blx	r3
	ldr	r3, [r4, #48]
	mov	r2, #80
	mov	r1, #0
	mov	r0, r6
	blx	r3
	ldr	r3, [r4, #48]
	mov	r2, #88
	mov	r1, #0
	ldr	r0, [fp, #-48]
	blx	r3
	cmp	r7, #0
	ble	.L176
	ldr	r3, [fp, #-52]
	mov	r2, #0
	mov	r1, r2
	mov	r0, r6
	sub	r10, r3, #4
.L175:
	str	r2, [r6, r1, asl #3]
	mov	r3, r2, asl r10
	ldr	ip, [r5, #2784]
	add	ip, ip, r1, lsl #1
	ldrsh	ip, [ip, #176]
	add	r2, ip, r2
	sub	ip, r2, #1
	str	ip, [r0, #4]
	mov	lr, r2, asl r10
	cmp	r3, lr
	bge	.L181
	cmp	r3, #255
	bhi	.L177
	uxtb	r4, r1
	add	ip, r8, r3
	b	.L179
.L180:
	cmp	r3, #255
	bhi	.L177
.L179:
	add	r3, r3, #1
	strb	r4, [ip], #1
	cmp	r3, lr
	blt	.L180
.L181:
	add	r1, r1, #1
	add	r0, r0, #8
	cmp	r1, r7
	bne	.L175
.L176:
	cmp	r9, #0
	ble	.L173
	ldr	r3, [fp, #-52]
	mov	ip, #0
	ldr	r7, [fp, #-48]
	mov	lr, ip
	sub	r4, r3, #4
	mov	r6, r7
.L183:
	str	ip, [r7, lr, asl #3]
	mov	r3, ip, asl r4
	ldr	r2, [r5, #2784]
	add	r2, r2, lr, lsl #1
	ldrsh	r2, [r2, #216]
	add	ip, r2, ip
	sub	r2, ip, #1
	str	r2, [r6, #4]
	mov	r1, ip, asl r4
	cmp	r3, r1
	bge	.L188
	cmp	r3, #255
	bhi	.L184
	add	r2, r3, #255
	uxtb	r0, lr
	add	r2, r8, r2
	b	.L186
.L187:
	cmp	r3, #255
	bhi	.L184
.L186:
	add	r3, r3, #1
	strb	r0, [r2, #1]!
	cmp	r3, r1
	blt	.L187
.L188:
	add	lr, lr, #1
	add	r6, r6, #8
	cmp	lr, r9
	bne	.L183
.L173:
	mov	r0, #0
	b	.L169
.L177:
	ldr	r2, .L197+4
	mov	r0, #1
	ldr	r1, .L197+8
	bl	dprint_vfmw
	mvn	r0, #0
.L169:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L184:
	ldr	r2, .L197+4
	mov	r0, #1
	ldr	r1, .L197+12
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L169
.L196:
	mov	r1, #11
	mov	r3, r9
	str	r1, [sp]
	mov	r0, #1
	ldr	r2, .L197+4
	ldr	r1, .L197+16
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L169
.L195:
	mov	r1, #10
	mov	r3, r7
	str	r1, [sp]
	mov	r0, #1
	ldr	r2, .L197+4
	ldr	r1, .L197+20
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L169
.L198:
	.align	2
.L197:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR1+136
	.word	.LC41
	.word	.LC42
	.word	.LC40
	.word	.LC39
	.fnend
	.size	HEVC_CalcTileInfo, .-HEVC_CalcTileInfo
	.align	2
	.global	HEVC_VPSEqual
	.type	HEVC_VPSEqual, %function
HEVC_VPSEqual:
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
	subs	r10, r0, #0
	beq	.L223
	cmp	r1, #0
	beq	.L224
	ldr	r4, [r10, #12]
	add	lr, r10, #12288
	ldr	r3, [r10, #16]
	add	ip, r1, #12288
	ldr	r6, [r1, #16]
	add	r2, r10, #12416
	ldr	r5, [r1, #12]
	add	r0, r1, #12416
	ldr	r9, [r1, #20]
	mov	r7, r2
	cmp	r3, r6
	cmpeq	r4, r5
	ldr	r8, [r10, #20]
	ldrb	r5, [r10, #1]
	add	r2, r2, #20
	ldrb	r3, [r1, #1]
	moveq	r4, #1
	movne	r4, #0
	cmp	r8, r9
	movne	r4, #0
	andeq	r4, r4, #1
	cmp	r5, r3
	movne	r9, #0
	andeq	r9, r4, #1
	ldr	r6, [r1, #24]
	ldr	r3, [r10, #24]
	add	r0, r0, #20
	ldr	r5, [r10, #8]
	add	r7, r7, #52
	ldr	r4, [r1, #8]
	cmp	r3, r6
	movne	r3, #0
	andeq	r3, r9, #1
	ldr	r9, [ip, #424]
	cmp	r5, r4
	movne	r6, #0
	andeq	r6, r3, #1
	ldr	r5, [lr, #424]
	ldrb	r3, [ip, #148]
	ldrb	r4, [lr, #148]
	cmp	r5, r9
	movne	r5, #0
	andeq	r5, r6, #1
	ldr	r9, [lr, #420]
	ldr	r6, [ip, #420]
	cmp	r4, r3
	movne	r4, #0
	andeq	r4, r5, #1
	cmp	r9, r6
	movne	r3, #0
	andeq	r3, r4, #1
.L203:
	ldrb	r5, [r2, #1]!
	ldrb	r4, [r0, #1]!
	cmp	r5, r4
	movne	r3, #0
	andeq	r3, r3, #1
	cmp	r2, r7
	bne	.L203
	ldrb	r2, [lr, #182]
	add	r7, r10, #80
	ldrb	r6, [ip, #182]
	sub	r0, r8, #1
	ldrb	r5, [lr, #181]
	add	r9, r1, #48
	ldrb	r4, [ip, #181]
	add	r8, r1, #80
	str	r7, [fp, #-56]
	cmp	r2, r6
	cmpeq	r5, r4
	ldrb	r7, [lr, #183]
	ldrb	r4, [ip, #183]
	mov	r5, #0
	ldrb	lr, [lr, #184]
	moveq	r2, #1
	ldrb	ip, [ip, #184]
	movne	r2, #0
	ldrb	r6, [r10, #7]
	cmp	r7, r4
	movne	r2, #0
	andeq	r2, r2, #1
	add	r4, r10, #112
	str	r4, [fp, #-52]
	ldrb	r4, [r1, #7]
	cmp	lr, ip
	movne	ip, #0
	andeq	ip, r2, #1
	add	r7, r1, #112
	str	r1, [fp, #-60]
	cmp	r6, r4
	movne	ip, #0
	andeq	ip, ip, #1
	ldr	r1, [fp, #-56]
	str	r0, [fp, #-48]
	and	r6, r3, ip
	add	r0, r10, #48
	ldr	r2, [fp, #-52]
	str	r10, [fp, #-52]
.L204:
	ldr	r3, [r1, #4]!
	add	r5, r5, #1
	ldr	r10, [r8, #4]!
	ldr	r4, [r0, #4]!
	ldr	lr, [r9, #4]!
	ldr	ip, [r2, #4]!
	cmp	r3, r10
	cmpeq	r4, lr
	ldr	r10, [r7, #4]!
	moveq	r3, #1
	movne	r3, #0
	cmp	ip, r10
	movne	r3, #0
	andeq	r3, r3, #1
	ldr	ip, [fp, #-48]
	and	r6, r6, r3
	cmp	r5, ip
	bls	.L204
	ldr	r10, [fp, #-52]
	ldr	r1, [fp, #-60]
	ldr	r8, [r10, #32]
	ldr	r3, [r1, #32]
	ldr	r4, [r10, #28]
	ldr	r2, [r1, #28]
	cmp	r8, r3
	cmpeq	r4, r2
	moveq	r3, #1
	movne	r3, #0
	cmp	r8, #0
	and	r6, r6, r3
	beq	.L205
	add	r7, r10, #148
	add	r5, r1, #148
	mov	r9, #1
.L206:
	mov	r0, r5
	mov	r2, r7
	mov	r3, #0
.L207:
	ldr	lr, [r2, #4]!
	add	r3, r3, #1
	ldr	ip, [r0, #4]!
	cmp	lr, ip
	movne	r6, #0
	andeq	r6, r6, #1
	cmp	r3, r4
	bls	.L207
	add	r9, r9, #1
	add	r7, r7, #4
	cmp	r9, r8
	add	r5, r5, #4
	bls	.L206
.L205:
	ldrb	r3, [r10, #6]
	ldrb	r2, [r1, #6]
	cmp	r2, r3
	movne	r6, #0
	andeq	r6, r6, #1
	cmp	r3, #0
	beq	.L208
	ldr	r3, [r10, #36]
	ldr	r2, [r10, #40]
	ldr	r4, [r1, #40]
	ldr	lr, [r1, #36]
	ldrb	r0, [r10, #5]
	cmp	r2, r4
	cmpeq	r3, lr
	ldrb	ip, [r1, #5]
	moveq	r3, #1
	movne	r3, #0
	cmp	ip, r0
	movne	r3, #0
	andeq	r3, r3, #1
	cmp	r0, #0
	and	r6, r6, r3
	bne	.L225
.L209:
	ldr	r2, [r10, #48]
	ldr	r3, [r1, #48]
	cmp	r2, r3
	movne	r6, #0
	andeq	r6, r6, #1
.L208:
	eor	r6, r6, #1
	rsb	r0, r6, #0
.L201:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L225:
	ldr	r2, [r10, #44]
	ldr	r3, [r1, #44]
	cmp	r2, r3
	movne	r6, #0
	andeq	r6, r6, #1
	b	.L209
.L224:
	mov	r0, r1
	mov	r3, #1696
	ldr	r2, .L226
	ldr	r1, .L226+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L201
.L223:
	movw	r3, #1695
	ldr	r2, .L226
	ldr	r1, .L226+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L201
.L227:
	.align	2
.L226:
	.word	.LC43
	.word	.LC44
	.fnend
	.size	HEVC_VPSEqual, .-HEVC_VPSEqual
	.align	2
	.global	HEVC_Sei_More_Data_In_Payload
	.type	HEVC_Sei_More_Data_In_Payload, %function
HEVC_Sei_More_Data_In_Payload:
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
	ldr	r2, [r0, #2308]
	mov	r5, r1
	ldr	r3, [r2, #24]
	mov	r0, r2
	ldr	r4, [r2, #28]
	rsb	r4, r4, r3
	bl	BsIsByteAligned
	cmp	r4, r5, asl #3
	movne	r3, #1
	moveq	r3, #0
	cmp	r0, #0
	moveq	r0, #0
	andne	r0, r3, #1
	eor	r0, r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	HEVC_Sei_More_Data_In_Payload, .-HEVC_Sei_More_Data_In_Payload
	.align	2
	.global	HEVC_Sei_Payload_Extension_Present
	.type	HEVC_Sei_Payload_Extension_Present, %function
HEVC_Sei_Payload_Extension_Present:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #32
	sub	sp, sp, #32
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r3, .L236
	mov	r5, r1
	mov	r2, #32
	ldr	r1, [r0, #2308]
	sub	r0, fp, #52
	mov	r5, r5, asl #3
	ldr	r3, [r3, #52]
	blx	r3
	ldr	r3, [fp, #-28]
	ldr	r2, [fp, #-24]
	rsb	r3, r2, r3
	cmp	r3, r5
	movcs	r0, #0
	bcc	.L235
.L230:
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L235:
	mov	r1, #1
	sub	r0, fp, #52
	bl	BsShow
	cmp	r0, #0
	moveq	r0, #1
	beq	.L230
	mov	r1, #1
	sub	r0, fp, #52
	bl	BsSkip
	ldr	r3, [fp, #-28]
	ldr	r4, [fp, #-24]
	rsb	r4, r4, r3
	b	.L231
.L232:
	bl	BsSkip
	ldr	r3, [fp, #-28]
	ldr	r4, [fp, #-24]
	rsb	r4, r4, r3
.L231:
	mov	r1, #1
	sub	r0, fp, #52
	bl	BsShow
	cmp	r4, r5
	mov	r1, #1
	movcs	r3, #0
	movcc	r3, #1
	cmp	r0, #0
	movne	r2, #0
	andeq	r2, r3, #1
	sub	r0, fp, #52
	cmp	r2, #0
	bne	.L232
	mov	r0, r3
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L237:
	.align	2
.L236:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	HEVC_Sei_Payload_Extension_Present, .-HEVC_Sei_Payload_Extension_Present
	.align	2
	.global	HEVC_Sei_Decoded_Picture_Hash
	.type	HEVC_Sei_Decoded_Picture_Hash, %function
HEVC_Sei_Decoded_Picture_Hash:
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
	mov	r6, r0
	mov	r7, r1
	beq	.L246
	mov	r1, #8
	ldr	r0, [r0, #2308]
	bl	BsGet
	sub	r4, r7, #1
	add	r8, r7, #47
	mov	r3, r0
	cmp	r3, #0
	str	r0, [r7, #48]
	str	r0, [r7, #52]
	bne	.L240
.L251:
	add	r5, r4, #16
.L241:
	mov	r1, #8
	ldr	r0, [r6, #2308]
	bl	BsGet
	strb	r0, [r4, #1]!
	cmp	r4, r5
	bne	.L241
.L242:
	cmp	r5, r8
	mov	r4, r5
	beq	.L247
.L253:
	ldr	r3, [r7, #52]
	cmp	r3, #0
	beq	.L251
.L240:
	cmp	r3, #1
	beq	.L252
	cmp	r3, #2
	addne	r5, r4, #16
	bne	.L242
	mov	r1, #32
	ldr	r0, [r6, #2308]
	bl	BsGet
	add	r5, r4, #16
	cmp	r5, r8
	strb	r0, [r4, #4]
	mov	r2, r0, lsr #24
	mov	r3, r0, lsr #16
	strb	r2, [r4, #1]
	mov	r0, r0, lsr #8
	strb	r3, [r4, #2]
	strb	r0, [r4, #3]
	mov	r4, r5
	bne	.L253
.L247:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L252:
	mov	r1, #16
	ldr	r0, [r6, #2308]
	bl	BsGet
	add	r5, r4, #16
	mov	r3, r0, lsr #8
	strb	r0, [r4, #2]
	strb	r3, [r4, #1]
	b	.L242
.L246:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	HEVC_Sei_Decoded_Picture_Hash, .-HEVC_Sei_Decoded_Picture_Hash
	.align	2
	.global	HEVC_Sei_Region_Refresh_Info
	.type	HEVC_Sei_Region_Refresh_Info, %function
HEVC_Sei_Region_Refresh_Info:
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
	cmp	r1, #0
	cmpne	r0, #0
	mov	r5, r1
	moveq	r4, #1
	movne	r4, #0
	beq	.L256
	ldr	r0, [r0, #2308]
	mov	r1, #1
	bl	BsGet
	mov	r3, r4
	strb	r0, [r5]
.L255:
	mov	r0, r3
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L256:
	mvn	r3, #0
	b	.L255
	.fnend
	.size	HEVC_Sei_Region_Refresh_Info, .-HEVC_Sei_Region_Refresh_Info
	.align	2
	.global	HEVC_Sei_Mastering_Display_Colour_Volume
	.type	HEVC_Sei_Mastering_Display_Colour_Volume, %function
HEVC_Sei_Mastering_Display_Colour_Volume:
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
	cmp	r1, #0
	cmpne	r0, #0
	mov	r5, r0
	mov	r6, r1
	beq	.L260
	sub	r4, r1, #4
	add	r7, r1, #8
.L259:
	mov	r1, #16
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #16
	str	r0, [r4, #4]!
	ldr	r0, [r5, #2308]
	bl	BsGet
	cmp	r4, r7
	str	r0, [r4, #12]
	bne	.L259
	mov	r1, #16
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #16
	str	r0, [r6, #24]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #32
	str	r0, [r6, #28]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #32
	str	r0, [r6, #32]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r3, #0
	str	r0, [r6, #36]
.L258:
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L260:
	mvn	r3, #0
	b	.L258
	.fnend
	.size	HEVC_Sei_Mastering_Display_Colour_Volume, .-HEVC_Sei_Mastering_Display_Colour_Volume
	.align	2
	.global	HEVC_Sei_Temporal_Sub_Layer_Zero_Index
	.type	HEVC_Sei_Temporal_Sub_Layer_Zero_Index, %function
HEVC_Sei_Temporal_Sub_Layer_Zero_Index:
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
	cmp	r1, #0
	cmpne	r0, #0
	mov	r5, r0
	mov	r6, r1
	moveq	r4, #1
	movne	r4, #0
	beq	.L264
	mov	r1, #1
	ldr	r0, [r0, #2308]
	bl	BsGet
	mov	r1, #1
	str	r0, [r6]
	ldr	r0, [r5, #2308]
	bl	BsGet
	str	r0, [r6, #4]
	ldr	r0, [r5, #2308]
	bl	BsToNextByte
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L264:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	HEVC_Sei_Temporal_Sub_Layer_Zero_Index, .-HEVC_Sei_Temporal_Sub_Layer_Zero_Index
	.align	2
	.global	HEVC_Sei_Display_Orientation
	.type	HEVC_Sei_Display_Orientation, %function
HEVC_Sei_Display_Orientation:
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
	cmp	r1, #0
	cmpne	r0, #0
	mov	r4, r0
	mov	r5, r1
	beq	.L268
	mov	r1, #1
	ldr	r0, [r0, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r5, #2]
	cmp	r0, #0
	beq	.L269
.L267:
	ldr	r0, [r4, #2308]
	bl	BsToNextByte
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L269:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r5]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #16
	strb	r0, [r5, #1]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	str	r0, [r5, #4]
	ldr	r0, [r4, #2308]
	bl	BsGet
	strb	r0, [r5, #3]
	b	.L267
.L268:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	HEVC_Sei_Display_Orientation, .-HEVC_Sei_Display_Orientation
	.align	2
	.global	HEVC_Sei_ParsePts_Init
	.type	HEVC_Sei_ParsePts_Init, %function
HEVC_Sei_ParsePts_Init:
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
	ldr	r3, .L271
	mov	r4, r0
	add	r0, r0, #27136
	mov	r2, #80
	mov	r1, #0
	ldr	r3, [r3, #48]
	add	r0, r0, #136
	blx	r3
	add	r3, r4, #4544
	add	r0, r4, #4096
	add	r1, r3, #2096
	add	r3, r3, #2080
	mov	r4, #0
	mov	r5, #0
	mov	r2, #0
	strd	r4, [r1]
	strd	r4, [r3, #-8]
	strd	r4, [r3]
	strd	r4, [r1, #-8]
	str	r2, [r0, #428]
	str	r2, [r0, #432]
	str	r2, [r0, #420]
	str	r2, [r0, #424]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L272:
	.align	2
.L271:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	HEVC_Sei_ParsePts_Init, .-HEVC_Sei_ParsePts_Init
	.align	2
	.global	HEVC_Sei_Get_Dpb_Output_Time
	.type	HEVC_Sei_Get_Dpb_Output_Time, %function
HEVC_Sei_Get_Dpb_Output_Time:
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
	add	r3, r0, #53248
	ldr	r5, [r0, #2320]
	movw	r6, #2024
	ldr	lr, [r1, #12]
	ldr	ip, [r3, #996]
	add	r3, r0, #24576
	ldr	r4, [r0, #2316]
	mla	ip, r6, ip, r5
	movw	r5, #26164
	ldr	r6, [r3, #2700]
	cmp	r6, #1
	ldr	ip, [ip, #32]
	str	lr, [r3, #2720]
	ldr	lr, [r1, #16]
	mla	r1, r5, ip, r4
	str	lr, [r3, #2724]
	ldr	lr, [r2, #76]
	str	lr, [r3, #2744]
	ldr	ip, [r2, #80]
	str	ip, [r3, #2748]
	ldr	ip, [r1, #56]
	add	r1, r1, ip, lsl #2
	ldrb	r7, [r1, #412]
	beq	.L281
	ldrb	r1, [r3, #2769]
	cmp	r1, #0
	bne	.L282
	add	ip, r0, #4544
	add	r6, r0, #4096
	add	r1, ip, #2080
	add	r4, ip, #2096
	ldr	r5, [r6, #452]
	ldrd	r0, [r1, #-8]
	adds	r0, r0, r5
	adc	r1, r1, #0
	strd	r0, [r4]
.L275:
	add	ip, ip, #2096
	mov	r4, #0
	strd	r0, [ip, #-8]
	strb	r4, [r3, #2769]
	ldrb	r2, [r2, #9]
	cmp	r2, r4
	ldr	r2, [r6, #456]
	bne	.L283
	adds	r0, r0, r2
	add	r3, r3, #2704
	adc	r1, r1, #0
	subs	r0, r0, r7
	sbc	r1, r1, #0
	strd	r0, [r3, #32]
	umull	r4, r5, r0, lr
	mla	r5, lr, r1, r5
	strd	r4, [r3, #24]
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L282:
	ldrb	r1, [r0, #3473]
	add	ip, r0, #4544
	cmp	r1, #0
	add	r1, ip, #2080
	bne	.L284
	ldrd	r4, [r1, #-8]
	strd	r4, [fp, #-52]
	ldrd	r4, [r1]
	strd	r4, [fp, #-44]
.L278:
	add	r6, r0, #4096
	mov	r5, #0
	add	r9, ip, #2096
	add	r8, ip, #2080
	ldr	r1, [r6, #452]
	mov	r0, r1
	mov	r1, r5
	ldrd	r4, [fp, #-52]
	strd	r0, [fp, #-60]
	adds	r4, r4, r0
	adc	r5, r5, r1
	mov	r0, r4
	mov	r1, r5
	ldrd	r4, [fp, #-44]
	strd	r0, [r9]
	cmp	r0, r4
	strd	r0, [r8, #-8]
	sbcs	r4, r1, r5
	bge	.L275
	ldrd	r0, [fp, #-60]
	ldrd	r4, [fp, #-44]
	adds	r0, r0, r4
	adc	r1, r1, r5
	strd	r0, [r9]
	strd	r0, [r8, #-8]
	b	.L275
.L283:
	adds	r0, r0, r2
	add	ip, r3, #2704
	adc	r1, r1, #0
	movs	r1, r1, asr #1
	mov	r0, r0, rrx
	subs	r0, r0, r7
	sbc	r1, r1, #0
	strd	r0, [ip, #32]
	umull	r2, r3, r0, lr
	mla	r3, lr, r1, r3
	strd	r2, [ip, #24]
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L281:
	add	r6, r0, #4096
	add	ip, r0, #4544
	add	r5, ip, #2096
	add	r4, ip, #2080
	ldr	r0, [r6, #420]
	mov	r1, r0, asr #31
	strd	r0, [r5]
	strd	r0, [r4, #-8]
	b	.L275
.L284:
	ldrd	r4, [r1]
	strd	r4, [fp, #-52]
	strd	r4, [fp, #-44]
	b	.L278
	.fnend
	.size	HEVC_Sei_Get_Dpb_Output_Time, .-HEVC_Sei_Get_Dpb_Output_Time
	.align	2
	.global	HEVC_Get_Last_IDR_Frame_Info
	.type	HEVC_Get_Last_IDR_Frame_Info, %function
HEVC_Get_Last_IDR_Frame_Info:
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
	sub	r3, r1, #19
	cmp	r3, #1
	bls	.L289
.L286:
	sub	r1, r1, #6
	cmp	r1, #3
	ldmlsfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	add	r0, r0, #4544
	add	r3, r0, #2096
	add	r0, r0, #2080
	ldrd	r2, [r3]
	strd	r2, [r0]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L289:
	ldr	ip, [r0, #2324]
	mvn	r3, #0
	mvn	r2, #0
	ldrd	r4, [ip, #56]
	cmp	r5, r3
	cmpeq	r4, r2
	beq	.L287
	movw	r2, #27312
	add	r3, r0, #27136
	ldrd	r6, [r0, r2]
	movw	r2, #27328
	strd	r4, [r0, r2]
	strd	r6, [r3, #200]
.L287:
	add	r3, r0, #24576
	mov	r2, #1
	strb	r2, [r3, #2768]
	b	.L286
	.fnend
	.size	HEVC_Get_Last_IDR_Frame_Info, .-HEVC_Get_Last_IDR_Frame_Info
	.global	__aeabi_uidivmod
	.align	2
	.global	HEVC_Sei_Get_Frame_Pts
	.type	HEVC_Sei_Get_Frame_Pts, %function
HEVC_Sei_Get_Frame_Pts:
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
	add	r3, r0, #27136
	add	r2, r0, #24576
	add	r3, r3, #208
	mov	r4, r0
	ldr	r5, [r2, #2744]
	movw	r0, #27328
	ldr	r10, [r2, #2748]
	movw	r1, #27312
	ldrd	r2, [r3, #-8]
	cmp	r5, #0
	ldrd	r6, [r4, r1]
	strd	r2, [fp, #-60]
	ldrd	r2, [r4, r0]
	strd	r2, [fp, #-52]
	beq	.L293
	mov	r9, r5
	mov	r0, r10
	b	.L292
.L294:
	mov	r9, r1
.L292:
	mov	r1, r9
	bl	__aeabi_uidivmod
	mov	r0, r9
	cmp	r1, #0
	bne	.L294
.L291:
	ldrd	r2, [fp, #-60]
	mov	r1, r9
	mov	r0, r5
	mov	r8, #1000
	subs	r2, r6, r2
	movw	r5, #54144
	mul	r6, r8, r2
	bl	__aeabi_uidiv
	mov	r1, r9
	mul	r6, r0, r6
	mov	r0, r10
	bl	__aeabi_uidiv
	mov	r1, r0
	mov	r0, r6
	bl	__aeabi_uidiv
	ldrd	r2, [fp, #-52]
	adds	r2, r2, r0
	adc	r3, r3, #0
	mov	r0, r2
	mov	r1, r3
	strd	r0, [r4, r5]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L293:
	mov	r9, r10
	b	.L291
	.fnend
	.size	HEVC_Sei_Get_Frame_Pts, .-HEVC_Sei_Get_Frame_Pts
	.align	2
	.global	HEVC_Sei_User_Data_Unregistered
	.type	HEVC_Sei_User_Data_Unregistered, %function
HEVC_Sei_User_Data_Unregistered:
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
	cmp	r2, #15
	mov	r8, r2
	mov	r5, r0
	mov	r7, r1
	addhi	r4, r1, #3
	addhi	r6, r1, #19
	bls	.L303
.L298:
	mov	r1, #8
	ldr	r0, [r5, #2308]
	bl	BsGet
	strb	r0, [r4, #1]!
	cmp	r4, r6
	bne	.L298
	sub	r0, r8, #16
	str	r0, [r7, #20]
	cmp	r0, #0
	movne	r4, #0
	beq	.L304
.L300:
	mov	r1, #8
	ldr	r0, [r5, #2308]
	bl	BsGet
	ldr	r3, [r7, #20]
	add	r4, r4, #1
	cmp	r3, r4
	bhi	.L300
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L304:
	str	r0, [r7]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L303:
	ldr	r1, .L305
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L306:
	.align	2
.L305:
	.word	.LC45
	.fnend
	.size	HEVC_Sei_User_Data_Unregistered, .-HEVC_Sei_User_Data_Unregistered
	.align	2
	.global	HEVC_IsRefListWrong
	.type	HEVC_IsRefListWrong, %function
HEVC_IsRefListWrong:
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
	add	r7, r0, #53248
	mov	r5, r0
	ldr	r3, [r7, #1080]
	cmp	r3, #0
	beq	.L308
	ldr	r4, [r0, #2336]
	cmp	r4, #0
	beq	.L309
	ldr	r2, [r4, #32]
	cmp	r2, #0
	addne	r6, r0, #2336
	movne	r4, #0
	bne	.L314
	b	.L352
.L315:
	ldr	r3, [ip, #608]
	cmp	r3, #0
	beq	.L316
	ldr	r3, [r7, #1080]
	add	r4, r4, #1
	cmp	r4, r3
	bcs	.L353
	ldr	r2, [r6, #4]!
	cmp	r2, #0
	beq	.L309
	ldr	r2, [r2, #32]
	cmp	r2, #0
	beq	.L310
.L314:
	ldr	r1, [r2, #32]
	ldr	r0, [r5, #244]
	bl	FSP_GetLogicFs
	subs	ip, r0, #0
	bne	.L315
.L316:
	add	r3, r4, #584
	mov	r2, r4
	ldr	r1, .L357
	mov	r0, #1
	ldr	r3, [r5, r3, asl #2]
	ldr	r3, [r3, #32]
	str	ip, [sp]
	bl	dprint_vfmw
.L313:
	mvn	r0, #0
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L353:
	cmp	r3, #0
	beq	.L308
	ldr	r2, [r7, #1084]
	cmp	r2, #0
	beq	.L308
	ldr	r4, [r5, #2404]
	cmp	r4, #0
	beq	.L321
	ldr	r2, [r4, #32]
	cmp	r2, #0
	addne	r6, r5, #2400
	movne	r4, #0
	addne	r6, r6, #4
	bne	.L325
	b	.L354
.L326:
	ldr	r3, [r0, #608]
	cmp	r3, #0
	beq	.L327
	ldr	r3, [r7, #1084]
	add	r4, r4, #1
	cmp	r4, r3
	bcs	.L308
	ldr	r3, [r6, #4]!
	cmp	r3, #0
	beq	.L355
	ldr	r2, [r3, #32]
	cmp	r2, #0
	beq	.L356
.L325:
	ldr	r1, [r2, #32]
	ldr	r0, [r5, #244]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	bne	.L326
.L327:
	mov	r3, r0
	mov	r2, r4
	ldr	r1, .L357+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L347
.L308:
	mov	r0, #0
.L347:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L309:
	mov	r2, r4
	ldr	r1, .L357+8
	mov	r0, #1
	bl	dprint_vfmw
	b	.L313
.L352:
	mov	r4, r2
.L310:
	mov	r2, r4
	ldr	r1, .L357+12
	mov	r0, #1
	bl	dprint_vfmw
	b	.L313
.L355:
	ldr	r3, [r7, #1080]
.L321:
	mov	r2, r4
	ldr	r1, .L357+16
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L347
.L356:
	ldr	r3, [r7, #1080]
.L322:
	mov	r2, r4
	ldr	r1, .L357+20
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L347
.L354:
	mov	r4, r2
	b	.L322
.L358:
	.align	2
.L357:
	.word	.LC48
	.word	.LC51
	.word	.LC46
	.word	.LC47
	.word	.LC49
	.word	.LC50
	.fnend
	.size	HEVC_IsRefListWrong, .-HEVC_IsRefListWrong
	.align	2
	.global	HEVC_GetUnRefPicWithMinPoc
	.type	HEVC_GetUnRefPicWithMinPoc, %function
HEVC_GetUnRefPicWithMinPoc:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, fp, ip, lr, pc}
	.pad #4
	.save {r4, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #12
	sub	sp, sp, #12
	push	{lr}
	bl	__gnu_mcount_nc
	mvn	r4, #0
	str	r4, [r1]
	ldr	r3, [r0, #2508]
	cmp	r3, #16
	bhi	.L360
	cmp	r3, #0
	addne	ip, r0, #2512
	mvnne	r4, #-2147483648
	addne	ip, ip, #12
	movne	r3, #0
	beq	.L362
.L365:
	ldr	r2, [ip, #4]!
	ldr	lr, [r2, #12]
	cmp	lr, r4
	bge	.L364
	ldr	r2, [r2]
	bic	r2, r2, #-16777216
	bic	r2, r2, #255
	cmp	r2, #0
	streq	r3, [r1]
	moveq	r4, lr
.L364:
	ldr	r2, [r0, #2508]
	add	r3, r3, #1
	cmp	r2, r3
	bhi	.L365
	ldr	r3, [r1]
	cmn	r3, #1
	beq	.L362
	str	r4, [sp]
	mov	r0, #1
	ldr	r2, .L368
	ldr	r1, .L368+4
	bl	dprint_vfmw
	mov	r0, #0
.L363:
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L360:
	ldr	r2, .L368
	mov	r0, #1
	ldr	r1, .L368+8
	bl	dprint_vfmw
	mov	r0, r4
	b	.L363
.L362:
	ldr	r2, .L368
	mov	r0, #1
	ldr	r1, .L368+12
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L363
.L369:
	.align	2
.L368:
	.word	.LANCHOR1+156
	.word	.LC54
	.word	.LC52
	.word	.LC53
	.fnend
	.size	HEVC_GetUnRefPicWithMinPoc, .-HEVC_GetUnRefPicWithMinPoc
	.align	2
	.global	HEVC_IncreaseDPBSize
	.type	HEVC_IncreaseDPBSize, %function
HEVC_IncreaseDPBSize:
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
	ldr	r3, [r0, #2504]
	mov	r4, r0
	cmp	r3, #16
	bhi	.L374
	ldr	r0, [r0, #244]
	bl	FSP_GetTotalValidFsNum
	cmp	r0, #0
	ble	.L373
	ldr	r2, [r4, #2504]
	add	r3, r2, #1
	cmp	r0, r3
	bcc	.L373
	str	r3, [r4, #2504]
	mov	r0, #13
	ldr	r2, .L375
	ldr	r1, .L375+4
	bl	dprint_vfmw
	mov	r0, #0
.L372:
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L373:
	mov	r3, r0
	ldr	r2, .L375
	ldr	r1, .L375+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L372
.L374:
	mov	r5, #17
	ldr	r2, .L375
	mov	r0, #1
	str	r5, [sp]
	ldr	r1, .L375+12
	bl	dprint_vfmw
	str	r5, [r4, #2504]
	mvn	r0, #0
	b	.L372
.L376:
	.align	2
.L375:
	.word	.LANCHOR1+184
	.word	.LC56
	.word	.LC57
	.word	.LC55
	.fnend
	.size	HEVC_IncreaseDPBSize, .-HEVC_IncreaseDPBSize
	.align	2
	.global	HEVC_PicTypeStatistic
	.type	HEVC_PicTypeStatistic, %function
HEVC_PicTypeStatistic:
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
	add	r0, r0, #53248
	ldr	r3, [r0, #992]
	sub	r2, r3, #16
	cmp	r2, #5
	bls	.L378
	ldr	r3, [r0, #284]
	sub	r3, r3, #16
	cmp	r3, #5
	bls	.L389
	ldr	r3, [r0, #980]
	cmp	r3, #1
	beq	.L381
	cmp	r3, #2
	beq	.L382
	cmp	r3, #0
	moveq	r3, #2
	streq	r3, [r0, #292]
	ldmfd	sp, {fp, sp, pc}
.L378:
	str	r3, [r0, #284]
	mov	r3, #0
	str	r3, [r0, #292]
	ldmfd	sp, {fp, sp, pc}
.L381:
	ldr	r2, [r0, #292]
	cmp	r2, #2
	beq	.L390
	str	r3, [r0, #292]
	ldmfd	sp, {fp, sp, pc}
.L382:
	ldr	r3, [r0, #292]
	sub	r3, r3, #1
	cmp	r3, #1
	movhi	r3, #0
	strhi	r3, [r0, #292]
	ldmfd	sp, {fp, sp, pc}
.L390:
	ldmfd	sp, {fp, sp, pc}
.L389:
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_PicTypeStatistic, .-HEVC_PicTypeStatistic
	.align	2
	.global	HEVC_IsReferenceNalu
	.type	HEVC_IsReferenceNalu, %function
HEVC_IsReferenceNalu:
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
	add	r0, r0, #53248
	ldr	r0, [r0, #992]
	cmp	r0, #15
	bhi	.L392
	tst	r0, #1
	bne	.L394
.L392:
	sub	r0, r0, #16
	cmp	r0, #7
	movhi	r0, #0
	movls	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L394:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_IsReferenceNalu, .-HEVC_IsReferenceNalu
	.align	2
	.global	HEVC_WriteQmatrix_4x4
	.type	HEVC_WriteQmatrix_4x4, %function
HEVC_WriteQmatrix_4x4:
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
	add	r1, r1, r0, lsl #6
	ldr	r0, [r1, #588]
	ldr	r3, [r1, #592]
	ldrb	ip, [r1, #580]
	ldrb	lr, [r1, #584]
	mov	r0, r0, asl #8
	orr	r3, ip, r3, asl #24
	uxth	r0, r0
	orr	r3, r3, lr, asl #16
	orr	r3, r3, r0
	str	r3, [r2]
	ldr	r0, [r1, #588]
	ldrb	lr, [r1, #581]
	ldrb	r3, [r1, #593]
	and	r0, r0, #65280
	ldrb	ip, [r1, #585]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #16
	str	r3, [r2, #4]
	ldr	r0, [r1, #584]
	ldrb	lr, [r1, #582]
	ldrb	r3, [r1, #594]
	and	r0, r0, #16711680
	ldrb	ip, [r1, #590]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #8]
	ldr	r0, [r1, #592]
	ldrb	r3, [r1, #587]
	ldrb	lr, [r1, #583]
	and	r0, r0, #-16777216
	ldrb	ip, [r1, #591]
	orr	r1, lr, r0
	orr	r3, r1, r3, asl #16
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #12]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_WriteQmatrix_4x4, .-HEVC_WriteQmatrix_4x4
	.align	2
	.global	HEVC_WriteQmatrix_32x32
	.type	HEVC_WriteQmatrix_32x32, %function
HEVC_WriteQmatrix_32x32:
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
	add	r1, r1, r0, lsl #6
	ldr	r0, [r1, #1740]
	ldr	r3, [r1, #1756]
	ldrb	ip, [r1, #1732]
	ldrb	lr, [r1, #1748]
	mov	r0, r0, asl #8
	orr	r3, ip, r3, asl #24
	uxth	r0, r0
	orr	r3, r3, lr, asl #16
	orr	r3, r3, r0
	str	r3, [r2]
	ldr	r0, [r1, #1772]
	ldr	r3, [r1, #1788]
	ldrb	ip, [r1, #1764]
	ldrb	lr, [r1, #1780]
	mov	r0, r0, asl #8
	orr	r3, ip, r3, asl #24
	uxth	r0, r0
	orr	r3, r3, lr, asl #16
	orr	r3, r3, r0
	str	r3, [r2, #4]
	ldr	r0, [r1, #1740]
	ldrb	lr, [r1, #1733]
	ldrb	r3, [r1, #1757]
	and	r0, r0, #65280
	ldrb	ip, [r1, #1749]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #16
	str	r3, [r2, #8]
	ldr	r0, [r1, #1772]
	ldrb	lr, [r1, #1765]
	ldrb	r3, [r1, #1789]
	and	r0, r0, #65280
	ldrb	ip, [r1, #1781]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #16
	str	r3, [r2, #12]
	ldr	r0, [r1, #1748]
	ldrb	lr, [r1, #1734]
	ldrb	r3, [r1, #1758]
	and	r0, r0, #16711680
	ldrb	ip, [r1, #1742]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #16]
	ldr	r0, [r1, #1780]
	ldrb	lr, [r1, #1766]
	ldrb	r3, [r1, #1790]
	and	r0, r0, #16711680
	ldrb	ip, [r1, #1774]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #20]
	ldr	r0, [r1, #1756]
	ldrb	lr, [r1, #1735]
	ldrb	r3, [r1, #1751]
	and	r0, r0, #-16777216
	ldrb	ip, [r1, #1743]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #16
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #24]
	ldr	r0, [r1, #1788]
	ldrb	lr, [r1, #1767]
	ldrb	r3, [r1, #1783]
	and	r0, r0, #-16777216
	ldrb	ip, [r1, #1775]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #16
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #28]
	ldr	r0, [r1, #1744]
	ldr	r3, [r1, #1760]
	ldrb	ip, [r1, #1736]
	ldrb	lr, [r1, #1752]
	mov	r0, r0, asl #8
	orr	r3, ip, r3, asl #24
	uxth	r0, r0
	orr	r3, r3, lr, asl #16
	orr	r3, r3, r0
	str	r3, [r2, #32]
	ldr	r0, [r1, #1776]
	ldr	r3, [r1, #1792]
	ldrb	ip, [r1, #1768]
	ldrb	lr, [r1, #1784]
	mov	r0, r0, asl #8
	orr	r3, ip, r3, asl #24
	uxth	r0, r0
	orr	r3, r3, lr, asl #16
	orr	r3, r3, r0
	str	r3, [r2, #36]
	ldr	r0, [r1, #1744]
	ldrb	lr, [r1, #1737]
	ldrb	r3, [r1, #1761]
	and	r0, r0, #65280
	ldrb	ip, [r1, #1753]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #16
	str	r3, [r2, #40]
	ldr	r0, [r1, #1776]
	ldrb	lr, [r1, #1769]
	ldrb	r3, [r1, #1793]
	and	r0, r0, #65280
	ldrb	ip, [r1, #1785]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #16
	str	r3, [r2, #44]
	ldr	r0, [r1, #1752]
	ldrb	lr, [r1, #1738]
	ldrb	r3, [r1, #1762]
	and	r0, r0, #16711680
	ldrb	ip, [r1, #1746]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #48]
	ldrb	lr, [r1, #1770]
	ldr	r0, [r1, #1784]
	ldrb	r3, [r1, #1794]
	ldrb	ip, [r1, #1778]
	and	r0, r0, #16711680
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #52]
	ldr	r0, [r1, #1760]
	ldrb	lr, [r1, #1739]
	ldrb	r3, [r1, #1755]
	and	r0, r0, #-16777216
	ldrb	ip, [r1, #1747]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #16
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #56]
	ldr	r0, [r1, #1792]
	ldrb	r3, [r1, #1787]
	ldrb	lr, [r1, #1771]
	and	r0, r0, #-16777216
	ldrb	ip, [r1, #1779]
	orr	r1, lr, r0
	orr	r3, r1, r3, asl #16
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #60]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_WriteQmatrix_32x32, .-HEVC_WriteQmatrix_32x32
	.align	2
	.global	HEVC_WriteQmatrix_8x8
	.type	HEVC_WriteQmatrix_8x8, %function
HEVC_WriteQmatrix_8x8:
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
	add	r1, r1, r0, lsl #6
	ldr	r0, [r1, #980]
	ldr	r3, [r1, #1012]
	ldrb	ip, [r1, #964]
	ldrb	lr, [r1, #996]
	mov	r0, r0, asl #8
	orr	r3, ip, r3, asl #24
	uxth	r0, r0
	orr	r3, r3, lr, asl #16
	orr	r3, r3, r0
	str	r3, [r2]
	ldr	r0, [r1, #988]
	ldr	r3, [r1, #1020]
	ldrb	ip, [r1, #972]
	ldrb	lr, [r1, #1004]
	mov	r0, r0, asl #8
	orr	r3, ip, r3, asl #24
	uxth	r0, r0
	orr	r3, r3, lr, asl #16
	orr	r3, r3, r0
	str	r3, [r2, #4]
	ldr	r0, [r1, #980]
	ldrb	lr, [r1, #965]
	ldrb	r3, [r1, #1013]
	and	r0, r0, #65280
	ldrb	ip, [r1, #997]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #16
	str	r3, [r2, #8]
	ldr	r0, [r1, #988]
	ldrb	lr, [r1, #973]
	ldrb	r3, [r1, #1021]
	and	r0, r0, #65280
	ldrb	ip, [r1, #1005]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #16
	str	r3, [r2, #12]
	ldr	r0, [r1, #996]
	ldrb	lr, [r1, #966]
	ldrb	r3, [r1, #1014]
	and	r0, r0, #16711680
	ldrb	ip, [r1, #982]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #16]
	ldr	r0, [r1, #1004]
	ldrb	lr, [r1, #974]
	ldrb	r3, [r1, #1022]
	and	r0, r0, #16711680
	ldrb	ip, [r1, #990]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #20]
	ldr	r0, [r1, #1012]
	ldrb	lr, [r1, #967]
	ldrb	r3, [r1, #999]
	and	r0, r0, #-16777216
	ldrb	ip, [r1, #983]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #16
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #24]
	ldr	r0, [r1, #1020]
	ldrb	lr, [r1, #975]
	ldrb	r3, [r1, #1007]
	and	r0, r0, #-16777216
	ldrb	ip, [r1, #991]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #16
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #28]
	ldr	r0, [r1, #984]
	ldr	r3, [r1, #1016]
	ldrb	ip, [r1, #968]
	ldrb	lr, [r1, #1000]
	mov	r0, r0, asl #8
	orr	r3, ip, r3, asl #24
	uxth	r0, r0
	orr	r3, r3, lr, asl #16
	orr	r3, r3, r0
	str	r3, [r2, #32]
	ldr	r0, [r1, #992]
	ldr	r3, [r1, #1024]
	ldrb	ip, [r1, #976]
	ldrb	lr, [r1, #1008]
	mov	r0, r0, asl #8
	orr	r3, ip, r3, asl #24
	uxth	r0, r0
	orr	r3, r3, lr, asl #16
	orr	r3, r3, r0
	str	r3, [r2, #36]
	ldr	r0, [r1, #984]
	ldrb	lr, [r1, #969]
	ldrb	r3, [r1, #1017]
	and	r0, r0, #65280
	ldrb	ip, [r1, #1001]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #16
	str	r3, [r2, #40]
	ldr	r0, [r1, #992]
	ldrb	lr, [r1, #977]
	ldrb	r3, [r1, #1025]
	and	r0, r0, #65280
	ldrb	ip, [r1, #1009]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #16
	str	r3, [r2, #44]
	ldr	r0, [r1, #1000]
	ldrb	lr, [r1, #970]
	ldrb	r3, [r1, #1018]
	and	r0, r0, #16711680
	ldrb	ip, [r1, #986]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #48]
	ldrb	lr, [r1, #978]
	ldr	r0, [r1, #1008]
	ldrb	r3, [r1, #1026]
	ldrb	ip, [r1, #994]
	and	r0, r0, #16711680
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #52]
	ldr	r0, [r1, #1016]
	ldrb	lr, [r1, #971]
	ldrb	r3, [r1, #1003]
	and	r0, r0, #-16777216
	ldrb	ip, [r1, #987]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #16
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #56]
	ldr	r0, [r1, #1024]
	ldrb	r3, [r1, #1011]
	ldrb	lr, [r1, #979]
	and	r0, r0, #-16777216
	ldrb	ip, [r1, #995]
	orr	r1, lr, r0
	orr	r3, r1, r3, asl #16
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #60]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_WriteQmatrix_8x8, .-HEVC_WriteQmatrix_8x8
	.align	2
	.global	HEVC_WriteQmatrix_16x16
	.type	HEVC_WriteQmatrix_16x16, %function
HEVC_WriteQmatrix_16x16:
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
	add	r1, r1, r0, lsl #6
	ldr	r0, [r1, #1356]
	ldr	r3, [r1, #1372]
	ldrb	ip, [r1, #1348]
	ldrb	lr, [r1, #1364]
	mov	r0, r0, asl #8
	orr	r3, ip, r3, asl #24
	uxth	r0, r0
	orr	r3, r3, lr, asl #16
	orr	r3, r3, r0
	str	r3, [r2]
	ldr	r0, [r1, #1388]
	ldr	r3, [r1, #1404]
	ldrb	ip, [r1, #1380]
	ldrb	lr, [r1, #1396]
	mov	r0, r0, asl #8
	orr	r3, ip, r3, asl #24
	uxth	r0, r0
	orr	r3, r3, lr, asl #16
	orr	r3, r3, r0
	str	r3, [r2, #4]
	ldr	r0, [r1, #1356]
	ldrb	lr, [r1, #1349]
	ldrb	r3, [r1, #1373]
	and	r0, r0, #65280
	ldrb	ip, [r1, #1365]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #16
	str	r3, [r2, #8]
	ldr	r0, [r1, #1388]
	ldrb	lr, [r1, #1381]
	ldrb	r3, [r1, #1405]
	and	r0, r0, #65280
	ldrb	ip, [r1, #1397]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #16
	str	r3, [r2, #12]
	ldr	r0, [r1, #1364]
	ldrb	lr, [r1, #1350]
	ldrb	r3, [r1, #1374]
	and	r0, r0, #16711680
	ldrb	ip, [r1, #1358]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #16]
	ldr	r0, [r1, #1396]
	ldrb	lr, [r1, #1382]
	ldrb	r3, [r1, #1406]
	and	r0, r0, #16711680
	ldrb	ip, [r1, #1390]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #20]
	ldr	r0, [r1, #1372]
	ldrb	lr, [r1, #1351]
	ldrb	r3, [r1, #1367]
	and	r0, r0, #-16777216
	ldrb	ip, [r1, #1359]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #16
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #24]
	ldr	r0, [r1, #1404]
	ldrb	lr, [r1, #1383]
	ldrb	r3, [r1, #1399]
	and	r0, r0, #-16777216
	ldrb	ip, [r1, #1391]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #16
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #28]
	ldr	r0, [r1, #1360]
	ldr	r3, [r1, #1376]
	ldrb	ip, [r1, #1352]
	ldrb	lr, [r1, #1368]
	mov	r0, r0, asl #8
	orr	r3, ip, r3, asl #24
	uxth	r0, r0
	orr	r3, r3, lr, asl #16
	orr	r3, r3, r0
	str	r3, [r2, #32]
	ldr	r0, [r1, #1392]
	ldr	r3, [r1, #1408]
	ldrb	ip, [r1, #1384]
	ldrb	lr, [r1, #1400]
	mov	r0, r0, asl #8
	orr	r3, ip, r3, asl #24
	uxth	r0, r0
	orr	r3, r3, lr, asl #16
	orr	r3, r3, r0
	str	r3, [r2, #36]
	ldr	r0, [r1, #1360]
	ldrb	lr, [r1, #1353]
	ldrb	r3, [r1, #1377]
	and	r0, r0, #65280
	ldrb	ip, [r1, #1369]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #16
	str	r3, [r2, #40]
	ldr	r0, [r1, #1392]
	ldrb	lr, [r1, #1385]
	ldrb	r3, [r1, #1409]
	and	r0, r0, #65280
	ldrb	ip, [r1, #1401]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #16
	str	r3, [r2, #44]
	ldr	r0, [r1, #1368]
	ldrb	lr, [r1, #1354]
	ldrb	r3, [r1, #1378]
	and	r0, r0, #16711680
	ldrb	ip, [r1, #1362]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #48]
	ldrb	lr, [r1, #1386]
	ldr	r0, [r1, #1400]
	ldrb	r3, [r1, #1410]
	ldrb	ip, [r1, #1394]
	and	r0, r0, #16711680
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #24
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #52]
	ldr	r0, [r1, #1376]
	ldrb	lr, [r1, #1355]
	ldrb	r3, [r1, #1371]
	and	r0, r0, #-16777216
	ldrb	ip, [r1, #1363]
	orr	r0, lr, r0
	orr	r3, r0, r3, asl #16
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #56]
	ldr	r0, [r1, #1408]
	ldrb	r3, [r1, #1403]
	ldrb	lr, [r1, #1387]
	and	r0, r0, #-16777216
	ldrb	ip, [r1, #1395]
	orr	r1, lr, r0
	orr	r3, r1, r3, asl #16
	orr	r3, r3, ip, asl #8
	str	r3, [r2, #60]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_WriteQmatrix_16x16, .-HEVC_WriteQmatrix_16x16
	.global	__aeabi_idivmod
	.align	2
	.global	HEVC_CtbRsAddrToTsAddr
	.type	HEVC_CtbRsAddrToTsAddr, %function
HEVC_CtbRsAddrToTsAddr:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #204
	sub	sp, sp, #204
	push	{lr}
	bl	__gnu_mcount_nc
	add	r3, r0, #24576
	mov	r7, r1
	ldr	r0, [r3, #2784]
	ldrb	r2, [r0, #13]
	cmp	r2, #0
	beq	.L434
	ldr	r2, [r0, #72]
	ldr	r3, [r3, #2780]
	subs	r2, r2, #1
	ldr	r5, [r0, #68]
	str	r2, [fp, #-236]
	ldrb	r4, [r0, #15]
	sub	r5, r5, #1
	ldr	r6, [r3, #72]
	ldr	r1, [r3, #148]
	bmi	.L405
	ldr	r8, [fp, #-236]
	add	lr, r0, #214
	sub	ip, fp, #216
	mov	r2, #0
.L404:
	add	r2, r2, #1
	ldrsh	r3, [lr, #2]!
	cmp	r8, r2
	sub	r3, r3, #1
	str	r3, [ip, #4]!
	bge	.L404
.L405:
	cmp	r5, #0
	addge	r0, r0, #174
	subge	ip, fp, #128
	movge	r2, #0
	blt	.L403
.L408:
	add	r2, r2, #1
	ldrsh	r3, [r0, #2]!
	cmp	r5, r2
	sub	r3, r3, #1
	str	r3, [ip, #4]!
	bge	.L408
.L403:
	mov	r9, #1
	mov	r0, r6
	mov	r9, r9, asl r1
	mov	r1, r9
	bl	__aeabi_idiv
	mov	r1, r9
	mov	r8, r0
	mov	r0, r6
	bl	__aeabi_idivmod
	mov	r0, r7
	cmp	r1, #0
	addne	r8, r8, #1
	mov	r1, r8
	bl	__aeabi_idivmod
	mov	r0, r7
	mov	r6, r1
	mov	r1, r8
	bl	__aeabi_idiv
	cmp	r4, #0
	beq	.L446
	ldr	r3, [fp, #-236]
	cmp	r3, #0
	mov	r3, #0
	blt	.L425
	sub	r10, fp, #212
	mov	r4, r3
	mov	r7, r3
	mov	r8, r3
	str	r3, [fp, #-232]
	str	r3, [fp, #-240]
.L411:
	cmp	r5, #0
	blt	.L428
	ldr	r8, [r10]
	mov	r2, #0
	ldr	r3, [fp, #-232]
	mov	r1, r2
	add	r8, r8, #1
	sub	lr, fp, #128
	mov	r7, r4
	add	r9, r3, r8
	b	.L414
.L426:
	mov	r7, r4
.L414:
	ldr	r3, [lr, #4]!
	add	r1, r1, #1
	add	r3, r3, #1
	add	ip, r2, r3
	cmp	r6, ip
	mla	r4, r8, r3, r4
	bge	.L412
	cmp	r0, r9
	blt	.L444
.L412:
	cmp	r5, r1
	mov	r2, ip
	bge	.L426
.L417:
	add	r2, ip, r3
	cmp	r6, r2
	bge	.L427
	cmp	r0, r9
	blt	.L447
.L427:
	ldr	r2, [fp, #-240]
	add	r10, r10, #4
	ldr	r1, [fp, #-236]
	add	r2, r2, #1
	str	r9, [fp, #-232]
	cmp	r1, r2
	str	r2, [fp, #-240]
	bge	.L411
	rsb	r0, r9, r0
	mov	r2, ip
	rsb	r2, r2, r6
	mul	r3, r0, r3
	add	r3, r2, r3
	add	r7, r3, r7
.L434:
	mov	r0, r7
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L446:
	ldr	r3, [fp, #-236]
	cmp	r3, #0
	mov	r3, r4
	blt	.L425
	sub	r10, fp, #212
	mov	lr, r4
	mov	r7, r4
	mov	r8, r4
	str	r4, [fp, #-232]
	str	r4, [fp, #-240]
.L410:
	cmp	r5, #0
	blt	.L431
	ldr	r8, [r10]
	mov	r2, #0
	ldr	r3, [fp, #-232]
	mov	ip, r2
	add	r8, r8, #1
	sub	r4, fp, #128
	mov	r7, lr
	add	r9, r3, r8
	b	.L420
.L429:
	mov	r7, lr
.L420:
	ldr	r3, [r4, #4]!
	add	ip, ip, #1
	add	r3, r3, #1
	add	r1, r2, r3
	cmp	r6, r1
	mla	lr, r8, r3, lr
	bge	.L418
	cmp	r0, r9
	blt	.L419
.L418:
	cmp	r5, ip
	mov	r2, r1
	bge	.L429
.L423:
	add	r2, r1, r3
	cmp	r6, r2
	bge	.L443
	cmp	r0, r9
	blt	.L448
.L443:
	ldr	r2, [fp, #-240]
	add	r10, r10, #4
	ldr	ip, [fp, #-236]
	add	r2, r2, #1
	str	r9, [fp, #-232]
	cmp	ip, r2
	str	r2, [fp, #-240]
	bge	.L410
	rsb	r0, r9, r0
	mov	r2, r1
	mul	r3, r0, r3
	b	.L409
.L444:
	ldr	r1, [fp, #-232]
	rsb	r0, r1, r0
	mul	r3, r0, r3
.L409:
	rsb	r2, r2, r6
	add	r3, r2, r3
	add	r7, r3, r7
	mov	r0, r7
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L419:
	cmp	r1, r6
	bgt	.L444
	mov	r1, r2
	b	.L443
.L428:
	ldr	r2, [fp, #-232]
	mov	ip, #0
	add	r9, r2, r8
	b	.L417
.L431:
	ldr	r2, [fp, #-232]
	mov	r1, #0
	add	r9, r2, r8
	b	.L423
.L447:
	ldr	r2, [fp, #-232]
	rsb	r0, r2, r0
	mov	r2, ip
	mul	r3, r0, r3
	b	.L409
.L448:
	ldr	r2, [fp, #-232]
	rsb	r0, r2, r0
	mov	r2, r1
	mul	r3, r0, r3
	b	.L409
.L425:
	mov	r2, r3
	mov	r7, r3
	b	.L409
	.fnend
	.size	HEVC_CtbRsAddrToTsAddr, .-HEVC_CtbRsAddrToTsAddr
	.align	2
	.global	HEVC_CtbTsAddrToRsAddr
	.type	HEVC_CtbTsAddrToRsAddr, %function
HEVC_CtbTsAddrToRsAddr:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #204
	sub	sp, sp, #204
	push	{lr}
	bl	__gnu_mcount_nc
	add	r0, r0, #24576
	mov	r8, r1
	ldr	r1, [r0, #2784]
	ldrb	r3, [r1, #13]
	cmp	r3, #0
	moveq	r0, r8
	beq	.L478
	ldr	r2, [r1, #72]
	ldr	r3, [r0, #2780]
	subs	r2, r2, #1
	ldr	r7, [r1, #68]
	str	r2, [fp, #-232]
	mov	r5, r2
	ldr	r4, [r3, #72]
	sub	r7, r7, #1
	ldr	ip, [r3, #148]
	bmi	.L451
	add	lr, r1, #214
	sub	r0, fp, #216
	mov	r2, #0
.L452:
	add	r2, r2, #1
	ldrsh	r3, [lr, #2]!
	cmp	r5, r2
	sub	r3, r3, #1
	str	r3, [r0, #4]!
	bge	.L452
	cmp	r7, #0
	blt	.L484
.L454:
	add	r0, r1, #174
	sub	r1, fp, #128
	mov	r2, #0
.L457:
	add	r2, r2, #1
	ldrsh	r3, [r0, #2]!
	cmp	r7, r2
	sub	r3, r3, #1
	str	r3, [r1, #4]!
	bge	.L457
	mov	r5, #1
	mov	r0, r4
	mov	r5, r5, asl ip
	mov	r1, r5
	bl	__aeabi_idiv
	mov	r1, r5
	mov	r6, r0
	mov	r0, r4
	bl	__aeabi_idivmod
	ldr	r3, [fp, #-232]
	cmp	r1, #0
	addne	r6, r6, #1
	cmp	r3, #0
	str	r6, [fp, #-240]
	blt	.L455
.L456:
	ldr	r3, [fp, #-124]
	mov	r9, #0
	sub	r10, fp, #212
	mov	r0, r9
	add	r3, r3, #1
	mov	r1, r9
	str	r3, [fp, #-236]
	mov	r6, r9
	mov	r3, r9
	mov	r4, r9
.L462:
	cmp	r7, #0
	blt	.L468
	ldr	r6, [r10]
	ldr	r4, [fp, #-236]
	add	r6, r6, #1
	mla	ip, r6, r4, r3
	cmp	r8, ip
	blt	.L469
	mov	r5, #0
	mov	r1, r3
	mov	r2, r5
	mov	r3, ip
	sub	lr, fp, #124
	b	.L464
.L460:
	ldr	r4, [lr, #4]!
	mov	r1, r3
	add	r4, r4, #1
	mla	ip, r6, r4, r3
	cmp	ip, r8
	bgt	.L461
	mov	r3, ip
.L464:
	add	r2, r2, #1
	add	r5, r5, r4
	cmp	r7, r2
	bge	.L460
.L463:
	cmp	r3, r8
	bgt	.L467
	ldr	r2, [fp, #-232]
	add	r0, r0, #1
	add	r9, r9, r6
	add	r10, r10, #4
	cmp	r2, r0
	bge	.L462
.L467:
	mov	r3, r1
.L461:
	cmp	r4, #0
	beq	.L455
	rsb	r8, r3, r8
	mov	r1, r4
	mov	r0, r8
	bl	__aeabi_idiv
	ldr	r3, [fp, #-240]
	mov	r1, r4
	add	r4, r0, r9
	mov	r0, r8
	mul	r4, r4, r3
	bl	__aeabi_idivmod
	add	r1, r1, r5
	add	r0, r4, r1
.L478:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L451:
	cmp	r7, #0
	bge	.L454
.L455:
	ldr	r1, .L485
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L478
.L468:
	mov	r5, #0
	b	.L463
.L469:
	ldr	r4, [fp, #-236]
	mov	r5, #0
	b	.L461
.L484:
	mov	r5, #1
	mov	r0, r4
	mov	r5, r5, asl ip
	mov	r1, r5
	bl	__aeabi_idiv
	mov	r1, r5
	mov	r6, r0
	mov	r0, r4
	bl	__aeabi_idivmod
	cmp	r1, #0
	addne	r6, r6, #1
	str	r6, [fp, #-240]
	b	.L456
.L486:
	.align	2
.L485:
	.word	.LC58
	.fnend
	.size	HEVC_CtbTsAddrToRsAddr, .-HEVC_CtbTsAddrToRsAddr
	.align	2
	.global	HEVC_CalcTileMap
	.type	HEVC_CalcTileMap, %function
HEVC_CalcTileMap:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #44
	sub	sp, sp, #44
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r4, .L510
	mov	r5, r0
	str	r0, [fp, #-60]
	mov	r2, #147456
	mov	r1, #0
	ldr	r0, .L510+4
	ldr	r3, [r4, #48]
	add	r10, r5, #24576
	blx	r3
	ldr	r3, [r4, #48]
	mov	r2, #36864
	mov	r1, #0
	ldr	r0, .L510+8
	blx	r3
	add	r0, r5, #64768
	ldr	r3, [r4, #48]
	mov	r2, #880
	mov	r1, #0
	add	r0, r0, #20
	blx	r3
	add	r2, r5, #61440
	mov	r3, #0
	str	r2, [fp, #-56]
	str	r3, [r2, #3344]
	ldr	r9, [r10, #2784]
	ldr	r1, [r10, #2780]
	ldr	r2, [r9, #72]
	ldr	r8, [r1, #240]
	cmp	r2, r3
	strne	r3, [fp, #-72]
	strne	r3, [fp, #-76]
	beq	.L487
.L495:
	ldr	r2, [r9, #68]
	cmp	r2, #0
	ldr	r2, [fp, #-72]
	add	r2, r2, #108
	streq	r2, [fp, #-80]
	beq	.L496
	mov	r1, r2
	str	r2, [fp, #-80]
	mov	r7, r1, asl #1
	ldr	r1, [fp, #-76]
	mov	r2, #0
	str	r2, [fp, #-48]
	str	r2, [fp, #-52]
	mul	r1, r8, r1
	ldr	r2, [fp, #-56]
	ldr	r2, [r2, #3344]
	str	r1, [fp, #-68]
.L494:
	add	r1, r2, #8064
	ldr	r0, [fp, #-60]
	add	r1, r1, #34
	add	r1, r0, r1, lsl #3
	str	r3, [r1, #4]
	ldrsh	r1, [r9, r7]
	cmp	r1, #0
	ldreq	r1, [fp, #-48]
	addeq	r1, r1, #88
	streq	r1, [fp, #-64]
	beq	.L490
	ldr	r2, [fp, #-48]
	mov	r5, #0
	ldr	r1, [fp, #-52]
	add	r2, r2, #88
	ldr	r0, [fp, #-68]
	str	r2, [fp, #-64]
	add	r6, r1, r0
	mov	ip, r2, asl #1
.L491:
	ldrsh	r2, [r9, ip]
	cmp	r2, #0
	beq	.L493
	ldr	r2, .L510+4
	rsb	lr, r3, r6
	mov	r4, r3
	add	r2, r2, r3, lsl #2
.L492:
	add	r1, lr, r3
	str	r1, [r2], #4
	ldr	r9, [r10, #2784]
	add	r3, r3, #1
	rsb	r1, r4, r3
	ldrsh	r0, [r9, ip]
	cmp	r0, r1
	bhi	.L492
.L493:
	ldrsh	r2, [r9, r7]
	add	r5, r5, #1
	add	r6, r6, r8
	cmp	r2, r5
	bhi	.L491
	ldr	r2, [fp, #-56]
	ldr	r2, [r2, #3344]
.L490:
	ldr	r1, [fp, #-60]
	sub	ip, r3, #1
	ldr	r0, [fp, #-64]
	add	r1, r1, r2, lsl #3
	ldr	lr, [fp, #-48]
	add	r1, r1, #64768
	add	r2, r2, #1
	mov	r0, r0, asl #1
	add	lr, lr, #1
	str	ip, [r1, #24]
	ldr	r1, [fp, #-56]
	str	lr, [fp, #-48]
	str	r2, [r1, #3344]
	ldr	r1, [r9, #68]
	ldrsh	r0, [r9, r0]
	cmp	r1, lr
	ldr	r1, [fp, #-52]
	add	r1, r1, r0
	str	r1, [fp, #-52]
	bhi	.L494
.L496:
	ldr	r2, [fp, #-80]
	ldr	r0, [fp, #-72]
	ldr	r1, [r9, #72]
	mov	r2, r2, asl #1
	add	r0, r0, #1
	cmp	r1, r0
	ldr	r1, [fp, #-76]
	ldrsh	r2, [r9, r2]
	str	r0, [fp, #-72]
	add	r2, r1, r2
	str	r2, [fp, #-76]
	bhi	.L495
.L487:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L511:
	.align	2
.L510:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR2+448
	.word	.LANCHOR3+592
	.fnend
	.size	HEVC_CalcTileMap, .-HEVC_CalcTileMap
	.align	2
	.global	HEVC_WritePicMsg
	.type	HEVC_WritePicMsg, %function
HEVC_WritePicMsg:
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
	add	r7, r0, #53248
	mov	r5, r0
	ldr	r1, .L534
	ldr	r3, [r7, #316]
	mov	r0, #2
	ldr	r2, [r7, #484]
	add	r4, r5, #61440
	bl	dprint_vfmw
	ldr	r1, .L534+4
	mov	r0, #4
	add	r8, r5, #24576
	bl	dprint_vfmw
	ldr	r3, [r7, #468]
	add	ip, r5, #65536
	mov	lr, #0
	ldr	r6, .L534+8
	add	r1, r5, #2928
	str	r3, [r4, #1836]
	add	r0, r5, #61952
	ldr	r3, [r7, #372]
	add	r1, r1, #8
	ldr	r9, [r7, #376]
	mov	r2, #64
	add	r0, r0, #156
	rsb	r9, r3, r9
	str	r9, [r4, #1840]
	ldr	r9, [r7, #484]
	str	r9, [r4, #1828]
	ldr	r9, [r7, #316]
	str	r9, [r4, #1832]
	ldr	r9, [r7, #472]
	str	r9, [r4, #1844]
	ldr	r9, [r7, #476]
	str	r9, [r4, #1848]
	ldr	r9, [r7, #480]
	str	r9, [r4, #1852]
	ldr	r9, [r7, #396]
	rsb	r3, r3, r9
	str	r3, [r4, #1856]
	ldr	r3, [r7, #400]
	rsb	r3, r9, r3
	str	r3, [r4, #1860]
	str	lr, [r5, #208]
	ldr	r3, [ip, #1732]
	str	r3, [r4, #3116]
	ldr	r3, [r8, #2780]
	ldrb	ip, [r3, #13]
	strb	ip, [r4, #548]
	ldrb	ip, [r3, #6]
	strb	ip, [r4, #549]
	ldrb	ip, [r3, #10]
	strb	ip, [r4, #550]
	ldrb	ip, [r3, #9]
	strb	ip, [r4, #551]
	ldrb	ip, [r3, #8]
	strb	ip, [r4, #552]
	ldr	ip, [r3, #64]
	str	ip, [r4, #556]
	ldr	ip, [r3, #116]
	strb	ip, [r4, #560]
	ldr	ip, [r3, #244]
	sub	ip, ip, #1
	str	ip, [r4, #564]
	ldr	ip, [r3, #240]
	sub	ip, ip, #1
	str	ip, [r4, #568]
	ldr	ip, [r7, #288]
	str	ip, [r4, #572]
	ldr	ip, [r8, #2784]
	ldr	lr, [ip, #84]
	sub	lr, lr, #2
	str	lr, [r4, #576]
	ldrb	lr, [ip, #11]
	strb	lr, [r4, #580]
	ldrb	ip, [ip, #10]
	strb	ip, [r4, #581]
	ldr	ip, [r3, #200]
	str	ip, [r4, #584]
	ldr	ip, [r3, #208]
	str	ip, [r4, #588]
	ldr	ip, [r3, #188]
	str	ip, [r4, #592]
	ldr	ip, [r3, #196]
	str	ip, [r4, #596]
	ldr	ip, [r3, #172]
	str	ip, [r4, #600]
	ldr	ip, [r3, #180]
	str	ip, [r4, #604]
	ldr	ip, [r3, #216]
	str	ip, [r4, #608]
	ldr	ip, [r3, #140]
	str	ip, [r4, #612]
	ldr	lr, [r3, #148]
	ldr	ip, [r6, #52]
	str	lr, [r4, #616]
	ldr	lr, [r3, #112]
	str	lr, [r4, #620]
	ldr	lr, [r3, #104]
	str	lr, [r4, #624]
	ldr	lr, [r3, #124]
	str	lr, [r4, #628]
	ldr	lr, [r3, #120]
	str	lr, [r4, #632]
	ldr	lr, [r3, #108]
	str	lr, [r4, #636]
	ldr	r3, [r3, #100]
	str	r3, [r4, #640]
	blx	ip
	ldr	ip, [r8, #2780]
	add	r3, r5, #64256
	add	r1, r5, #63744
	add	r1, r1, #60
	mov	r0, r5
	ldr	lr, [ip, #76]
	mov	r2, r3
	add	r3, r3, #140
	add	r2, r2, #60
	str	lr, [r4, #732]
	ldr	ip, [ip, #72]
	str	ip, [r4, #736]
	bl	HEVC_CalcTileInfo
	subs	r6, r0, #0
	bne	.L532
	ldr	r3, [r8, #2784]
	ldrb	r2, [r3, #16]
	strb	r2, [r4, #760]
	ldrb	r2, [r3, #7]
	strb	r2, [r4, #761]
	ldrb	r2, [r3, #3]
	strb	r2, [r4, #762]
	ldrb	r2, [r3, #14]
	strb	r2, [r4, #763]
	ldrb	r2, [r3, #15]
	strb	r2, [r4, #764]
	ldrb	r2, [r3, #13]
	strb	r2, [r4, #765]
	ldr	r2, [r8, #2780]
	ldr	r1, [r3, #56]
	ldr	r2, [r2, #148]
	rsb	r2, r1, r2
	str	r2, [r3, #88]
	ldr	r3, [r8, #2784]
	ldr	r2, [r3, #88]
	str	r2, [r4, #768]
	ldr	r2, [r3, #52]
	str	r2, [r4, #772]
	ldrb	r2, [r3, #8]
	strb	r2, [r4, #776]
	ldrb	r2, [r3, #12]
	strb	r2, [r4, #777]
	ldrb	r2, [r3, #6]
	strb	r2, [r4, #778]
	ldr	r2, [r3, #60]
	str	r2, [r4, #780]
	ldr	r2, [r3, #64]
	str	r2, [r4, #784]
	ldr	r2, [r3, #72]
	sub	r2, r2, #1
	str	r2, [r4, #788]
	ldr	r2, [r3, #68]
	sub	r2, r2, #1
	str	r2, [r4, #792]
	ldrb	r2, [r3, #10]
	strb	r2, [r4, #581]
	ldrb	r3, [r3, #11]
	strb	r3, [r4, #580]
	ldr	r3, [r7, #324]
	ldr	r0, [r5, #244]
	ldr	r1, [r3, #32]
	bl	FSP_GetLogicFs
	subs	r8, r0, #0
	beq	.L533
	ldr	r2, [r8, #608]
	ldr	r3, [r8, #612]
	cmp	r2, #0
	beq	.L517
	cmp	r3, #0
	beq	.L517
	add	r2, r5, #63232
	add	r3, r5, #63488
	add	r3, r3, #56
	ldr	r0, [r5, #244]
	mov	r1, r2
	add	r2, r2, #92
	add	r1, r1, #220
	bl	FSP_GetDecFsAddrTab
	ldr	r3, [r8, #608]
	add	r2, r5, #63232
	add	r1, r5, #63488
	add	r2, r2, #224
	add	r1, r1, #48
	ldr	r3, [r3, #8]
	str	r3, [r4, #1828]
	ldr	r0, [r5, #244]
	bl	FSP_GetPmvAddrTab
	ldr	r3, [r7, #316]
	str	r3, [r4, #1832]
	ldr	r3, [r8, #624]
	str	r3, [r4, #2100]
	ldr	r3, [r8, #612]
	ldr	r3, [r3, #16]
	str	r3, [r4, #3336]
	ldr	r3, [r8, #612]
	ldr	r3, [r3, #76]
	str	r3, [r4, #3340]
	ldr	ip, [r5, #2800]
	cmp	ip, #0
	str	ip, [r4, #3108]
	beq	.L519
	add	r2, r5, #2864
	add	r3, r5, #64256
	add	r2, r2, #4
	add	r3, r3, #224
	mov	r0, r6
.L520:
	add	r0, r0, #1
	ldr	r1, [r2, #4]!
	cmp	r0, ip
	str	r1, [r3, #4]!
	bne	.L520
.L519:
	add	r8, r5, #62208
	mov	r6, #0
	add	r8, r8, #32
.L521:
	mov	r2, r8
	mov	r0, r6
	mov	r1, r5
	add	r6, r6, #1
	bl	HEVC_WriteQmatrix_8x8
	cmp	r6, #4
	add	r8, r8, #64
	bne	.L521
	add	r2, r5, #62464
	mov	r0, r6
	add	r2, r2, #32
	mov	r1, r5
	bl	HEVC_WriteQmatrix_8x8
	add	r2, r5, #62464
	add	r2, r2, #96
	mov	r1, r5
	mov	r0, #5
	add	r8, r5, #62720
	bl	HEVC_WriteQmatrix_8x8
	add	r2, r5, #62464
	add	r2, r2, #160
	mov	r1, r5
	mov	r0, #0
	add	r8, r8, #32
	bl	HEVC_WriteQmatrix_16x16
	add	r2, r5, #62464
	add	r2, r2, #224
	mov	r1, r5
	mov	r0, #1
	mov	r6, #2
	bl	HEVC_WriteQmatrix_16x16
.L522:
	mov	r2, r8
	mov	r0, r6
	mov	r1, r5
	add	r6, r6, #1
	bl	HEVC_WriteQmatrix_16x16
	cmp	r6, #6
	add	r8, r8, #64
	bne	.L522
	add	r2, r5, #62976
	mov	r1, r5
	add	r2, r2, #32
	mov	r0, #0
	bl	HEVC_WriteQmatrix_32x32
	add	r2, r5, #62976
	add	r2, r2, #96
	mov	r1, r5
	mov	r0, #1
	add	r8, r5, #62976
	bl	HEVC_WriteQmatrix_32x32
	add	r8, r8, #160
	mov	r6, #0
.L523:
	mov	r2, r8
	mov	r0, r6
	mov	r1, r5
	add	r6, r6, #1
	bl	HEVC_WriteQmatrix_4x4
	cmp	r6, #6
	add	r8, r8, #16
	bne	.L523
	ldr	r1, [r5, #2268]
	mov	r0, #0
	ldr	r3, [r5, #2272]
	ldr	r2, [r5, #2260]
	ldr	ip, [r5, #2264]
	mov	r1, r1, asl #16
	orr	r3, r1, r3, asl #24
	orr	r3, r3, r2
	orr	r3, r3, ip, asl #8
	str	r3, [r4, #1792]
	ldr	r1, [r5, #2284]
	ldr	r3, [r5, #2288]
	ldr	r2, [r5, #2276]
	ldr	ip, [r5, #2280]
	mov	r1, r1, asl #16
	orr	r3, r1, r3, asl #24
	orr	r3, r3, r2
	orr	r3, r3, ip, asl #8
	str	r3, [r4, #1796]
	ldr	r3, [r7, #316]
	str	r3, [r4, #1824]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L532:
	ldr	r2, .L534+12
	mov	r0, #1
	ldr	r1, .L534+16
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L517:
	ldr	r1, .L534+20
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L533:
	ldr	r3, [r7, #324]
	mov	r0, #1
	ldr	r1, .L534+24
	ldr	r2, [r3, #32]
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L535:
	.align	2
.L534:
	.word	.LC59
	.word	.LC60
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR1+208
	.word	.LC61
	.word	.LC63
	.word	.LC62
	.fnend
	.size	HEVC_WritePicMsg, .-HEVC_WritePicMsg
	.align	2
	.global	HEVC_CheckListX
	.type	HEVC_CheckListX, %function
HEVC_CheckListX:
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
	add	r3, r0, #53248
	ldrb	r3, [r3, #923]
	cmp	r3, #0
	addeq	r3, r0, #54016
	addeq	r3, r3, #152
	beq	.L538
	ldrsb	r3, [r0, #9]
	cmp	r3, #0
	addne	r3, r0, #57856
	addne	r3, r3, #44
	beq	.L571
.L538:
	ldr	ip, [r3, #160]
	ldr	lr, [r3, #164]
	cmp	ip, #16
	bhi	.L572
	cmp	lr, #16
	bhi	.L542
	cmp	ip, #0
	beq	.L543
	ldr	r3, [r0, #2336]
	cmp	r3, #0
	beq	.L556
	ldr	r3, [r3, #32]
	cmp	r3, #0
	addne	r1, r0, #2336
	movne	r2, #0
	bne	.L548
	b	.L573
.L549:
	ldr	r3, [r1, #4]!
	cmp	r3, #0
	beq	.L544
	ldr	r3, [r3, #32]
	cmp	r3, #0
	beq	.L545
.L548:
	add	r2, r2, #1
	cmp	r2, ip
	bne	.L549
.L543:
	cmp	lr, #0
	beq	.L568
	ldr	r3, [r0, #2404]
	cmp	r3, #0
	beq	.L559
	ldr	r3, [r3, #32]
	cmp	r3, #0
	addne	r0, r0, #2400
	movne	r2, #0
	addne	r0, r0, #4
	bne	.L554
	b	.L574
.L555:
	ldr	r3, [r0, #4]!
	cmp	r3, #0
	beq	.L550
	ldr	r3, [r3, #32]
	cmp	r3, #0
	beq	.L551
.L554:
	add	r2, r2, #1
	cmp	r2, lr
	bne	.L555
.L568:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L556:
	mov	r2, r3
.L544:
	ldr	r1, .L575
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L573:
	mov	r2, r3
.L545:
	ldr	r1, .L575+4
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L559:
	mov	r2, r3
.L550:
	ldr	r1, .L575+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L574:
	mov	r2, r3
.L551:
	ldr	r1, .L575+12
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L571:
	mov	r0, r3
	ldr	r2, .L575+16
	ldr	r1, .L575+20
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L542:
	mov	r2, lr
	mov	r3, #17
	ldr	r1, .L575+24
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L572:
	mov	r2, ip
	mov	r3, #17
	ldr	r1, .L575+28
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L576:
	.align	2
.L575:
	.word	.LC67
	.word	.LC68
	.word	.LC69
	.word	.LC70
	.word	.LANCHOR1+228
	.word	.LC64
	.word	.LC66
	.word	.LC65
	.fnend
	.size	HEVC_CheckListX, .-HEVC_CheckListX
	.align	2
	.global	HEVC_WriteSliceMsg
	.type	HEVC_WriteSliceMsg, %function
HEVC_WriteSliceMsg:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #76
	sub	sp, sp, #76
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r4, r0
	bl	HEVC_CheckListX
	subs	r3, r0, #0
	str	r3, [fp, #-112]
	bne	.L615
	ldr	r0, [r4, #208]
	ldr	r3, [r4, #144]
	cmp	r0, r3
	bcs	.L651
	add	r9, r4, #65536
	mov	r5, #1360
	ldr	r7, [fp, #-112]
	mov	r2, r5
	ldr	r6, [r9, #1732]
	add	r8, r4, #53248
	ldr	r3, .L654
	mov	r1, r7
	mla	r6, r5, r0, r6
	ldr	r3, [r3, #48]
	mov	r0, r6
	blx	r3
	ldr	r3, .L654
	mov	r2, #64
	mov	r1, r7
	sub	r0, fp, #108
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r3, [r4, #208]
	ldr	r2, [r4, #144]
	add	r3, r3, #1
	str	r3, [r4, #208]
	cmp	r3, r2
	ldrcc	r2, [r9, #1732]
	ldrcs	r3, [fp, #-112]
	mlacc	r3, r5, r3, r2
	str	r3, [r6, #1356]
	ldr	r2, [r4, #216]
	ldr	r1, [r8, #996]
	add	r3, r2, #16640
	add	r2, r2, #1
	add	r3, r3, #178
	add	r3, r4, r3, lsl #2
	str	r1, [r3, #4]
	ldr	r3, [r4, #172]
	str	r2, [r4, #216]
	add	r3, r3, #1
	str	r3, [r4, #172]
	ldr	r2, [r9, #2540]
	mov	r0, r3, asl #5
	ldr	r1, [r8, #980]
	sub	r3, r0, r3, asl #2
	str	r3, [fp, #-116]
	add	r3, r2, r3
	str	r1, [r3, #8]
	ldr	r2, [r4, #2332]
	ldrb	r1, [r2, #1]
	ldr	r3, [r2, #8]
	cmp	r1, #1
	cmpls	r1, r3
	bcs	.L582
	add	r0, r6, r1, lsl #2
.L583:
	mov	r3, r1, asl #5
	sub	r3, r3, r1, asl #2
	add	r1, r1, #1
	add	r2, r2, r3
	ldr	r2, [r2, #60]
	str	r2, [r0, #8]
	ldr	r2, [r4, #2332]
	add	r2, r2, r3
	ldr	r2, [r2, #56]
	str	r2, [r0], #4
	ldr	r2, [r4, #2332]
	add	r3, r2, r3
	ldr	r3, [r3, #64]
	str	r3, [r0, #12]
	ldr	r2, [r4, #2332]
	ldr	r3, [r2, #8]
	cmp	r3, r1
	movhi	ip, #1
	movls	ip, #0
	cmp	r1, #1
	movhi	ip, #0
	cmp	ip, #0
	bne	.L583
.L582:
	cmp	r3, #1
	addls	r3, r6, r3, lsl #2
	addls	r1, r6, #8
	movls	r2, #0
	bhi	.L588
.L587:
	str	r2, [r3, #8]
	str	r2, [r3], #4
	cmp	r3, r1
	str	r2, [r3, #12]
	bne	.L587
.L588:
	ldrb	r3, [r8, #923]
	cmp	r3, #0
	beq	.L652
.L586:
	add	r5, r4, #57344
	ldr	r3, [r5, #716]
	cmp	r3, #0
	beq	.L589
	add	r0, r4, #2336
	add	r10, r6, #112
	add	lr, r6, #368
	mov	r1, #0
.L590:
	ldr	ip, [r0]
	sub	r7, fp, #44
	add	r1, r1, #1
	ldr	r2, [ip, #32]
	ldr	r3, [r2, #24]
	ldr	r2, [r2, #28]
	add	r3, r3, #15808
	add	r3, r3, #54
	add	r2, r7, r2, lsl #2
	add	r3, r4, r3, lsl #2
	ldr	r3, [r3, #8]
	str	r3, [r2, #-64]
	ldr	r3, [ip, #16]
	str	r3, [r10, #4]!
	ldr	r3, [r0], #4
	ldr	r3, [r3, #32]
	ldr	r3, [r3, #28]
	str	r3, [lr, #4]!
	ldr	r3, [r5, #716]
	cmp	r3, r1
	bhi	.L590
	ldr	r2, [r5, #720]
	cmp	r2, #0
	beq	.L591
.L614:
	add	r1, r4, #2400
	add	r10, r6, #176
	add	r1, r1, #4
	add	lr, r6, #432
	mov	r0, #0
.L592:
	ldr	ip, [r1]
	sub	r7, fp, #44
	add	r0, r0, #1
	ldr	r2, [ip, #32]
	ldr	r3, [r2, #24]
	ldr	r2, [r2, #28]
	add	r3, r3, #15808
	add	r3, r3, #54
	add	r2, r7, r2, lsl #2
	add	r3, r4, r3, lsl #2
	ldr	r3, [r3, #8]
	str	r3, [r2, #-64]
	ldr	r3, [ip, #16]
	str	r3, [r10, #4]!
	ldr	r3, [r1], #4
	ldr	r3, [r3, #32]
	ldr	r3, [r3, #28]
	str	r3, [lr, #4]!
	ldr	r2, [r5, #720]
	cmp	r2, r0
	bhi	.L592
	ldr	r3, [r5, #716]
.L591:
	cmp	r3, #0
	beq	.L593
	ldr	r1, [r6, #372]
	ldr	lr, [r8, #288]
	add	r1, r1, #732
	add	r1, r1, #2
	ldr	r1, [r4, r1, asl #2]
	cmp	lr, r1
	blt	.L621
	add	ip, r6, #372
	mov	r0, #0
	b	.L595
.L596:
	ldr	r1, [ip, #4]!
	add	r1, r1, #732
	add	r1, r1, #2
	ldr	r1, [r4, r1, asl #2]
	cmp	r1, lr
	bgt	.L621
.L595:
	add	r0, r0, #1
	cmp	r0, r3
	bne	.L596
.L593:
	ldr	r1, [r5, #616]
	cmp	r1, #0
	bne	.L649
	cmp	r2, #0
	beq	.L649
	ldr	r3, [r6, #436]
	ldr	ip, [r8, #288]
	add	r3, r3, #732
	add	r3, r3, #2
	ldr	r3, [r4, r3, asl #2]
	cmp	ip, r3
	blt	.L594
	add	r0, r6, #436
	b	.L597
.L598:
	ldr	r3, [r0, #4]!
	add	r3, r3, #732
	add	r3, r3, #2
	ldr	r3, [r4, r3, asl #2]
	cmp	r3, ip
	bgt	.L621
.L597:
	add	r1, r1, #1
	cmp	r1, r2
	bne	.L598
.L649:
	mov	r1, #1
.L594:
	strb	r1, [r6, #24]
	ldrb	r3, [r8, #923]
	strb	r3, [r6, #25]
	ldr	r3, [r5, #612]
	str	r3, [r6, #28]
	ldrb	r3, [r5, #566]
	strb	r3, [r6, #32]
	ldr	r3, [r5, #636]
	str	r3, [r6, #36]
	ldr	r3, [r5, #616]
	cmp	r3, #0
	bne	.L599
	ldrb	r3, [r5, #567]
	cmp	r3, #0
	bne	.L600
	ldr	r3, [r5, #668]
	add	r3, r6, r3, lsl #2
	ldr	r3, [r3, #436]
	mov	r7, r3
.L601:
	str	r7, [r6, #40]
	add	r10, r4, #24576
	ldr	r3, [r5, #668]
	str	r3, [r6, #48]
	ldrb	r3, [r5, #567]
	strb	r3, [r6, #52]
	ldr	r3, [r5, #672]
	str	r3, [r6, #44]
	ldr	r3, [r5, #724]
	cmp	r3, #0
	subne	r3, r3, #1
	str	r3, [r6, #60]
	ldr	r3, [r5, #728]
	cmp	r3, #0
	subne	r3, r3, #1
	str	r3, [r6, #56]
	ldrb	r2, [r5, #563]
	strb	r2, [r6, #64]
	ldrb	r2, [r5, #565]
	strb	r2, [r6, #65]
	ldr	r2, [r5, #716]
	str	r2, [r6, #68]
	ldr	r2, [r5, #720]
	str	r2, [r6, #72]
	ldr	r2, [r5, #616]
	str	r2, [r6, #76]
	ldr	r2, [r8, #1000]
	str	r2, [r6, #80]
	ldr	r2, [r10, #2780]
	ldr	r0, [r8, #1000]
	ldr	r1, [r2, #240]
	bl	__aeabi_uidivmod
	str	r1, [r6, #84]
	ldr	r2, [r10, #2780]
	ldr	r0, [r8, #1000]
	ldr	r1, [r2, #240]
	bl	__aeabi_uidiv
	str	r0, [r6, #88]
	mov	r0, r4
	ldr	r1, [r8, #1000]
	bl	HEVC_CtbRsAddrToTsAddr
	str	r0, [r6, #92]
	ldr	r2, [r5, #680]
	str	r2, [r6, #96]
	ldr	r2, [r5, #684]
	str	r2, [r6, #100]
	ldr	r2, [r5, #692]
	str	r2, [r6, #104]
	ldr	r2, [r5, #688]
	str	r2, [r6, #108]
	ldrb	r2, [r5, #562]
	strb	r2, [r6, #112]
	ldrb	r2, [r5, #561]
	strb	r2, [r6, #113]
	ldrb	r2, [r5, #569]
	strb	r2, [r6, #114]
	ldrb	r2, [r5, #570]
	strb	r2, [r6, #115]
	ldr	r3, [r10, #2784]
	ldrb	r2, [r3, #10]
	cmp	r2, #0
	beq	.L606
	ldr	r2, [r5, #616]
	cmp	r2, #1
	beq	.L607
.L606:
	ldrb	r3, [r3, #11]
	cmp	r3, #1
	beq	.L653
.L609:
	ldrb	r3, [r5, #563]
	add	r1, r4, #61440
	ldr	ip, [fp, #-116]
	cmp	r3, #0
	subne	r3, fp, #44
	movne	r2, r7
	addne	r10, r3, r2, lsl #2
	ldrne	r3, [r10, #-64]
	strne	r3, [r6, #564]
	mov	r3, #0
	ldr	r2, [r9, #2540]
	ldr	r0, [r4, #2332]
	add	r2, r2, ip
	str	r0, [r2, #24]
	str	r3, [r4, #2332]
	ldrb	r2, [r1, #765]
	cmp	r2, r3
	beq	.L630
	ldr	ip, [r4, #216]
	cmp	ip, #1
	ldreq	r2, [r6, #92]
	streq	r2, [r9, #132]
	beq	.L613
	add	r0, r4, ip, lsl #3
	ldr	lr, [r6, #92]
	add	r0, r0, #65536
	add	r2, ip, #8192
	add	r2, r2, #15
	sub	lr, lr, #1
	str	lr, [r0, #120]
	sub	r3, ip, #1
	ldr	r0, [r6, #92]
	add	r2, r4, r2, lsl #3
	str	r0, [r2, #4]
.L613:
	ldr	r2, [r1, #564]
	add	r3, r4, r3, lsl #3
	ldr	r1, [r1, #568]
	add	r3, r3, #65536
	mla	r2, r1, r2, r2
	add	r2, r2, r1
	str	r2, [r3, #136]
	ldr	r1, [r6, #92]
	sub	r1, r1, #1
	cmp	r1, #36864
	bcs	.L630
	mov	r0, r4
	bl	HEVC_CtbTsAddrToRsAddr
	str	r0, [r6, #568]
.L630:
	ldr	r0, [fp, #-112]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L621:
	mov	r1, #0
	b	.L594
.L599:
	cmp	r3, #1
	movne	r3, #0
	movne	r7, r3
	bne	.L601
.L600:
	ldr	r3, [r5, #668]
	add	r3, r6, r3, lsl #2
	ldr	r3, [r3, #372]
	mov	r7, r3
	b	.L601
.L652:
	ldr	r3, .L654
	add	r1, r4, #54016
	add	r0, r4, #57856
	add	r1, r1, #152
	add	r0, r0, #44
	movw	r2, #3732
	ldr	r3, [r3, #52]
	blx	r3
	mov	r3, #1
	strb	r3, [r4, #9]
	b	.L586
.L653:
	ldr	r3, [r5, #616]
	cmp	r3, #0
	bne	.L609
.L607:
	ldr	ip, [r5, #2148]
	add	r1, r4, #60416
	ldr	r3, .L654
	add	r1, r1, #112
	ldr	r8, .L654
	mov	r2, #64
	str	ip, [r6, #580]
	add	r0, r6, #588
	ldr	ip, [r5, #3180]
	ldr	r3, [r3, #52]
	str	ip, [r6, #584]
	blx	r3
	add	r1, r4, #59648
	add	r1, r1, #44
	ldr	r3, [r8, #52]
	mov	r2, #64
	add	r0, r6, #716
	blx	r3
	add	r1, r4, #60416
	add	r1, r1, #176
	ldr	r3, [r8, #52]
	mov	r2, #128
	add	r0, r6, #844
	blx	r3
	add	r1, r4, #60672
	add	r0, r6, #1088
	ldr	r3, [r8, #52]
	add	r1, r1, #48
	add	r0, r0, #12
	mov	r2, #128
	blx	r3
	ldr	r3, [r5, #616]
	cmp	r3, #0
	bne	.L609
	add	r1, r4, #60672
	ldr	r3, [r8, #52]
	add	r1, r1, #176
	mov	r2, #64
	add	r0, r6, #652
	blx	r3
	add	r1, r4, #60160
	ldr	r3, [r8, #52]
	add	r1, r1, #44
	mov	r2, #64
	add	r0, r6, #780
	blx	r3
	add	r1, r4, #60672
	ldr	r3, [r8, #52]
	add	r1, r1, #240
	mov	r2, #128
	add	r0, r6, #972
	blx	r3
	add	r1, r4, #60928
	add	r0, r6, #1216
	ldr	r3, [r8, #52]
	add	r1, r1, #112
	mov	r2, #128
	add	r0, r0, #12
	blx	r3
	b	.L609
.L589:
	ldr	r3, [r5, #720]
	cmp	r3, #0
	bne	.L614
	b	.L649
.L615:
	mvn	r3, #0
	str	r3, [fp, #-112]
	b	.L630
.L651:
	mov	r2, r0
	ldr	r1, .L654+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r3, #0
	str	r3, [fp, #-112]
	b	.L630
.L655:
	.align	2
.L654:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC71
	.fnend
	.size	HEVC_WriteSliceMsg, .-HEVC_WriteSliceMsg
	.align	2
	.global	HEVC_GetVirAddr
	.type	HEVC_GetVirAddr, %function
HEVC_GetVirAddr:
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
	add	r0, r1, r0, lsl #2
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_GetVirAddr, .-HEVC_GetVirAddr
	.align	2
	.global	HEVC_GetPhyAddr
	.type	HEVC_GetPhyAddr, %function
HEVC_GetPhyAddr:
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
	add	r0, r1, r0, lsl #2
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_GetPhyAddr, .-HEVC_GetPhyAddr
	.align	2
	.global	HEVC_CfgVDMReg
	.type	HEVC_CfgVDMReg, %function
HEVC_CfgVDMReg:
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
	add	ip, r0, #53248
	add	r2, r0, #61440
	mov	r1, r0
	ldr	r3, [ip, #308]
	mov	r0, #0
	clz	r3, r3
	mov	r3, r3, lsr #5
	str	r3, [r2, #1880]
	ldr	r3, [ip, #312]
	str	r3, [r2, #1872]
	ldr	r3, [r1, #208]
	str	r3, [r2, #3112]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_CfgVDMReg, .-HEVC_CfgVDMReg
	.align	2
	.global	HEVC_IsRefForCurrPic
	.type	HEVC_IsRefForCurrPic, %function
HEVC_IsRefForCurrPic:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #44
	sub	sp, sp, #44
	push	{lr}
	bl	__gnu_mcount_nc
	add	r3, r0, #53248
	str	r3, [fp, #-48]
	mov	r6, r0
	ldr	r2, [r0, #156]
	ldr	r3, [r3, #996]
	cmp	r3, #0
	blt	.L661
	cmp	r3, r2
	bge	.L661
	ldr	r2, [r0, #2320]
	movw	r1, #2024
	mla	r3, r1, r3, r2
	ldr	r2, [r0, #152]
	ldr	r3, [r3, #32]
	cmp	r3, #0
	blt	.L665
	cmp	r3, r2
	bge	.L665
	ldr	r2, [r0, #2316]
	movw	r1, #26164
	add	r0, r0, #57344
	mov	r9, #1
	str	r0, [fp, #-52]
	mla	r3, r1, r3, r2
	ldr	r2, [r0, #108]
	ldr	r1, [r0, #112]
	ldr	ip, [r0, #116]
	add	r10, r1, r2
	str	r2, [fp, #-60]
	cmp	r10, ip
	str	r1, [fp, #-64]
	ldr	r3, [r3, #128]
	mov	r4, r10
	mov	r9, r9, asl r3
	bcs	.L676
	cmp	r10, #15
	bgt	.L668
	ldr	r3, [fp, #-48]
	add	r5, r10, #14336
	add	r5, r5, #57
	str	r10, [fp, #-68]
	str	r6, [fp, #-56]
	ldr	r3, [r3, #288]
	add	r5, r6, r5, lsl #2
	mov	r6, ip
	mov	r10, r3
	b	.L670
.L688:
	cmp	r6, r4
	bls	.L686
	cmp	r4, #16
	beq	.L687
.L670:
	ldr	r7, [r5, #4]!
	mov	r1, r9
	mov	r0, r10
	mov	r8, r10
	ldr	r2, [r5, #-1884]
	cmp	r2, #0
	bne	.L671
	bl	__aeabi_idivmod
	mov	r0, r7
	mov	r8, r1
	mov	r1, r9
	bl	__aeabi_idivmod
	mov	r7, r1
.L671:
	cmp	r8, r7
	add	r4, r4, #1
	bne	.L688
	ldr	r10, [fp, #-68]
	mov	r4, #1
	ldr	r6, [fp, #-56]
.L667:
	cmp	r10, #0
	beq	.L663
	ldr	r2, [fp, #-48]
	ldr	r3, [fp, #-52]
	ldr	ip, [r2, #968]
	ldr	r3, [r3, #164]
	ldr	r0, [r2, #288]
	add	r3, ip, r3
	cmp	r0, r3
	beq	.L680
	add	r6, r6, #57344
	mov	r1, #0
	add	r6, r6, #164
	b	.L673
.L674:
	ldr	r3, [r6, #4]!
	add	r3, ip, r3
	cmp	r3, r0
	beq	.L680
.L673:
	add	r1, r1, #1
	cmp	r1, r10
	beq	.L663
	cmp	r1, #17
	bne	.L674
	ldr	r3, [fp, #-64]
	mov	r0, #0
	ldr	r2, [fp, #-60]
	str	r1, [sp]
	str	r3, [sp, #8]
	mov	r3, r1
	str	r2, [sp, #4]
	movw	r2, #6633
	ldr	r1, .L689
	bl	dprint_vfmw
	mov	r0, r4
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L665:
	str	r2, [sp]
	mov	r0, #0
	movw	r2, #6584
	ldr	r1, .L689+4
	mov	r4, r0
	bl	dprint_vfmw
.L663:
	mov	r0, r4
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L661:
	str	r2, [sp]
	mov	r0, #0
	movw	r2, #6572
	ldr	r1, .L689+8
	mov	r4, r0
	bl	dprint_vfmw
	mov	r0, r4
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L687:
	mov	ip, r6
	ldr	r6, [fp, #-56]
.L668:
	mov	r3, r4
	mov	r1, #16
	movw	r2, #6604
	str	r1, [sp]
	mov	r0, #0
	str	ip, [sp, #4]
	ldr	r1, .L689+12
	mov	r4, r0
	bl	dprint_vfmw
	ldr	r3, [fp, #-52]
	ldr	r2, [r3, #108]
	ldr	r3, [r3, #112]
	str	r2, [fp, #-60]
	add	r10, r3, r2
	str	r3, [fp, #-64]
	b	.L667
.L686:
	ldr	r10, [fp, #-68]
	mov	r4, #0
	ldr	r6, [fp, #-56]
	b	.L667
.L680:
	mov	r4, #1
	b	.L663
.L676:
	mov	r4, #0
	b	.L667
.L690:
	.align	2
.L689:
	.word	.LC75
	.word	.LC73
	.word	.LC72
	.word	.LC74
	.fnend
	.size	HEVC_IsRefForCurrPic, .-HEVC_IsRefForCurrPic
	.align	2
	.global	HEVC_RepairList
	.type	HEVC_RepairList, %function
HEVC_RepairList:
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
	add	r3, r0, #53248
	str	r3, [fp, #-56]
	mov	ip, r0
	ldr	r3, [r3, #980]
	cmp	r3, #1
	beq	.L708
	cmp	r3, #2
	beq	.L709
	cmp	r3, #0
	moveq	r3, #2
	streq	r3, [fp, #-48]
	beq	.L693
	ldr	r2, .L718
	mov	r0, #1
	ldr	r1, .L718+4
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L708:
	str	r3, [fp, #-48]
.L693:
	add	r8, ip, #54272
	add	r9, ip, #2336
	add	r8, r8, #52
	mov	r10, #0
.L706:
	ldr	r1, [r8, #4]!
	cmp	r1, #0
	beq	.L696
	ldr	r3, [r9]
	cmp	r3, #0
	bne	.L710
	mov	r2, r9
	mov	r4, r3
	b	.L698
.L700:
	ldr	r6, [r2, #4]!
	cmp	r6, #0
	bne	.L716
.L698:
	add	r4, r4, #1
	cmp	r4, r1
	bne	.L700
	mov	r4, #255
.L699:
	ldr	r2, [ip, #2324]
	ldr	r2, [r2, #12]
	cmp	r2, #2
	bne	.L701
	ldr	r2, [fp, #-56]
	ldr	r6, [r2, #324]
	add	r6, r6, #36
.L697:
	mov	r7, r9
	mov	r5, #0
	b	.L707
.L703:
	ldr	r3, [r7, #4]!
.L707:
	cmp	r3, #0
	beq	.L717
.L702:
	ldr	r3, [r8]
	add	r5, r5, #1
	cmp	r3, r5
	bhi	.L703
.L704:
	ldr	r3, [fp, #-48]
	add	r10, r10, #1
	add	r9, r9, #68
	cmp	r10, r3
	bcc	.L706
.L709:
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L696:
	ldr	r3, [ip, #2324]
	ldr	r3, [r3, #12]
	cmp	r3, #2
	bne	.L704
	mov	r3, #1
	str	r3, [r8]
	ldr	r3, [fp, #-56]
	ldr	r3, [r3, #324]
	add	r3, r3, #36
	str	r3, [r9]
	b	.L704
.L717:
	sxtb	r2, r4
	str	r5, [sp]
	str	r2, [sp, #4]
	mov	r3, r10
	ldr	r2, .L718
	mov	r0, #1
	ldr	r1, .L718+8
	str	ip, [fp, #-52]
	bl	dprint_vfmw
	str	r6, [r7]
	ldr	ip, [fp, #-52]
	b	.L702
.L716:
	uxtb	r4, r4
	cmp	r4, #255
	bne	.L697
	b	.L699
.L710:
	mov	r6, r3
	mov	r4, #0
	b	.L697
.L701:
	mov	r3, r10
	ldr	r2, .L718
	ldr	r1, .L718+12
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L719:
	.align	2
.L718:
	.word	.LANCHOR1+244
	.word	.LC76
	.word	.LC78
	.word	.LC77
	.fnend
	.size	HEVC_RepairList, .-HEVC_RepairList
	.align	2
	.global	HEVC_InitListX
	.type	HEVC_InitListX, %function
HEVC_InitListX:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #156
	sub	sp, sp, #156
	push	{lr}
	bl	__gnu_mcount_nc
	subs	r7, r0, #0
	beq	.L756
	ldr	r3, .L788
	mov	r2, #136
	mov	r1, #0
	sub	r0, fp, #180
	ldr	r3, [r3, #48]
	blx	r3
	ldr	lr, [r7, #2520]
	cmp	lr, #0
	beq	.L757
	mov	r0, #0
	add	r1, r7, #2592
	mov	r3, r0
	b	.L724
.L723:
	cmp	r3, lr
	beq	.L722
.L724:
	ldr	r2, [r1, #4]!
	add	r3, r3, #1
	ldrb	ip, [r2, #1]
	cmp	ip, #1
	bne	.L723
	ldr	ip, [r2, #52]
	cmp	ip, #0
	bne	.L723
	ldr	ip, [r2, #56]
	cmp	ip, #1
	subeq	ip, fp, #44
	addeq	r2, r2, #36
	addeq	ip, ip, r0, lsl #2
	addeq	r0, r0, #1
	streq	r2, [ip, #-136]
	cmp	r3, lr
	bne	.L724
.L722:
	ldr	r4, [r7, #2524]
	cmp	r4, #0
	beq	.L758
	add	r1, r7, #2656
	mov	ip, r0
	add	r1, r1, #4
	mov	r3, #0
	b	.L727
.L726:
	cmp	r3, r4
	beq	.L784
.L727:
	ldr	r2, [r1, #4]!
	add	r3, r3, #1
	ldrb	lr, [r2, #1]
	cmp	lr, #1
	bne	.L726
	ldr	lr, [r2, #52]
	cmp	lr, #0
	bne	.L726
	ldr	lr, [r2, #56]
	cmp	lr, #1
	subeq	lr, fp, #44
	addeq	r2, r2, #36
	addeq	lr, lr, ip, lsl #2
	addeq	ip, ip, #1
	streq	r2, [lr, #-136]
	cmp	r3, r4
	bne	.L727
.L784:
	rsb	r4, r0, ip
.L725:
	ldr	r5, [r7, #2516]
	cmp	r5, #0
	beq	.L759
	add	lr, r7, #2720
	mov	r9, ip
	add	lr, lr, #8
	mov	r2, #0
	b	.L730
.L729:
	cmp	r2, r5
	beq	.L785
.L730:
	ldr	r3, [lr, #4]!
	add	r2, r2, #1
	ldrb	r1, [r3, #1]
	cmp	r1, #1
	bne	.L729
	ldr	r1, [r3, #52]
	cmp	r1, #1
	bne	.L729
	ldr	r1, [r3, #56]
	sub	r6, fp, #44
	add	r6, r6, r9, lsl #2
	add	r3, r3, #36
	cmp	r1, #0
	addeq	r9, r9, #1
	streq	r3, [r6, #-136]
	cmp	r2, r5
	bne	.L730
.L785:
	rsb	r5, r0, r9
	rsb	r5, r4, r5
.L728:
	cmp	r9, #0
	beq	.L786
	add	r3, r7, #53248
	str	r3, [fp, #-184]
	ldr	r3, [r3, #980]
	cmp	r3, #0
	str	r3, [fp, #-188]
	beq	.L787
	ldr	r3, [fp, #-184]
	ldr	r4, [r3, #1088]
	ldr	r5, [r3, #1092]
	cmp	r4, #0
	str	r4, [r3, #1080]
	str	r5, [r3, #1084]
	beq	.L749
.L755:
	add	r1, r7, #57344
	add	r2, r7, #2320
	add	r8, r7, #57600
	add	r2, r2, #12
	ldrb	r10, [r1, #296]
	add	r8, r8, #44
	str	r5, [fp, #-192]
	mov	r6, #0
	mov	r5, r10
	mov	r10, r4
	mov	r4, r2
.L742:
	cmp	r5, #0
	mov	r1, r9
	mov	r0, r6
	ldrne	r1, [r8]
	bne	.L741
	bl	__aeabi_uidivmod
.L741:
	sub	r3, fp, #44
	add	r6, r6, #1
	add	r3, r3, r1, lsl #2
	cmp	r10, r6
	add	r8, r8, #4
	ldr	r3, [r3, #-136]
	str	r3, [r4, #4]!
	bhi	.L742
	ldr	r3, [fp, #-188]
	ldr	r5, [fp, #-192]
	cmp	r3, #0
	bne	.L783
.L743:
	cmp	r5, #0
	beq	.L745
	add	r2, r7, #57344
	add	r6, r7, #57600
	add	r6, r6, #172
	add	r8, r7, #2400
	ldrb	r10, [r2, #297]
	mov	r4, #0
.L748:
	cmp	r10, #0
	mov	r1, r9
	mov	r0, r4
	ldrne	r1, [r6]
	bne	.L747
	bl	__aeabi_uidivmod
.L747:
	sub	r3, fp, #44
	add	r4, r4, #1
	add	r3, r3, r1, lsl #2
	cmp	r4, r5
	add	r6, r6, #4
	ldr	r3, [r3, #-68]
	str	r3, [r8, #4]!
	bne	.L748
.L783:
	ldr	r3, [fp, #-184]
	ldr	r4, [r3, #1080]
	ldr	r5, [r3, #1084]
.L744:
	cmp	r4, #16
	bhi	.L753
.L749:
	add	r4, r4, #580
	add	r2, r7, #2400
	add	r4, r4, #3
	add	r4, r7, r4, lsl #2
.L752:
	ldr	r3, [r7, #2336]
	str	r3, [r4, #4]!
	cmp	r4, r2
	bne	.L752
.L753:
	cmp	r5, #16
	bhi	.L751
	add	r5, r5, #600
	add	r2, r7, #2464
	add	r2, r2, #4
	add	r5, r7, r5, lsl #2
.L754:
	ldr	r3, [r7, #2404]
	str	r3, [r5, #4]!
	cmp	r5, r2
	bne	.L754
.L751:
	mov	r0, #0
.L782:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L787:
	cmp	r4, #0
	beq	.L734
	sub	r3, fp, #180
	ldr	r2, [fp, #-188]
	add	lr, r3, r0, lsl #2
	sub	r1, fp, #116
.L735:
	add	r2, r2, #1
	ldr	r3, [lr], #4
	cmp	r2, r4
	str	r3, [r1, #4]!
	bne	.L735
.L734:
	cmp	r0, #0
	beq	.L736
	add	r1, r4, #16
	sub	lr, fp, #180
	mov	r2, #0
	add	r1, lr, r1, lsl #2
.L737:
	add	r2, r2, #1
	ldr	r3, [lr], #4
	cmp	r2, r0
	str	r3, [r1, #4]!
	bne	.L737
	add	r4, r4, r2
.L736:
	cmp	r5, #0
	beq	.L738
	add	r4, r4, #16
	sub	r3, fp, #180
	add	ip, r3, ip, lsl #2
	mov	r2, #0
	add	r4, r3, r4, lsl #2
.L739:
	add	r2, r2, #1
	ldr	r3, [ip], #4
	cmp	r2, r5
	str	r3, [r4, #4]!
	bne	.L739
.L738:
	ldr	r3, [fp, #-184]
	ldr	r4, [r3, #1088]
	ldr	r5, [r3, #1092]
	cmp	r4, #0
	str	r4, [r3, #1080]
	str	r5, [r3, #1084]
	bne	.L755
	b	.L743
.L786:
	ldr	r3, .L788
	add	r4, r7, #53248
	mov	r2, #136
	mov	r1, r9
	str	r9, [r4, #1080]
	add	r0, r7, #2336
	ldr	ip, [r3, #48]
	str	r9, [r4, #1084]
	blx	ip
	ldr	r2, [r7, #2324]
	ldr	r2, [r2, #12]
	cmp	r2, #2
	bne	.L751
	ldr	r2, [r4, #324]
	mov	r3, #1
	mov	r0, r9
	str	r3, [r4, #1080]
	add	r3, r2, #36
	str	r3, [r7, #2336]
	b	.L782
.L757:
	mov	r0, lr
	b	.L722
.L758:
	mov	ip, r0
	b	.L725
.L759:
	mov	r9, ip
	b	.L728
.L745:
	ldr	r3, .L788
	add	r0, r7, #2400
	add	r0, r0, #4
	mov	r2, #68
	add	r1, r7, #2336
	ldr	r3, [r3, #52]
	blx	r3
	ldr	r3, [fp, #-184]
	ldr	r4, [r3, #1080]
	str	r4, [r3, #1084]
	mov	r5, r4
	b	.L744
.L756:
	mvn	r0, #0
	b	.L782
.L789:
	.align	2
.L788:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	HEVC_InitListX, .-HEVC_InitListX
	.align	2
	.global	HEVC_DecList
	.type	HEVC_DecList, %function
HEVC_DecList:
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
	add	r3, r0, #53248
	mov	r4, r0
	ldr	r2, [r3, #980]
	cmp	r2, #2
	beq	.L795
	bl	HEVC_InitListX
	cmp	r0, #0
	bne	.L796
	mov	r0, r4
	bl	HEVC_RepairList
	cmp	r0, #0
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r1, .L797
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L795:
	mov	r0, #0
	str	r0, [r3, #1080]
	str	r0, [r3, #1084]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L796:
	ldr	r1, .L797+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L798:
	.align	2
.L797:
	.word	.LC80
	.word	.LC79
	.fnend
	.size	HEVC_DecList, .-HEVC_DecList
	.align	2
	.global	HEVC_RemoveApcStore
	.type	HEVC_RemoveApcStore, %function
HEVC_RemoveApcStore:
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
	add	r5, r0, r1, lsl #2
	mov	r4, r0
	ldr	r2, [r5, #2528]
	ldr	r3, [r2, #28]
	cmp	r3, #16
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	add	r3, r3, #700
	mov	ip, #0
	add	r3, r3, #2
	ldr	r1, .L804
	mov	r0, #13
	str	ip, [r4, r3, asl #2]
	ldr	r3, [r2, #28]
	add	r3, r3, #716
	add	r3, r3, #2
	str	ip, [r4, r3, asl #2]
	ldr	r3, [r2, #28]
	add	r3, r3, #732
	add	r3, r3, #2
	str	ip, [r4, r3, asl #2]
	ldr	r3, [r2, #24]
	add	r3, r3, #528
	add	r3, r4, r3, lsl #2
	str	ip, [r3, #4]
	ldr	r3, [r2, #24]
	ldr	r2, [r2, #28]
	bl	dprint_vfmw
	ldr	r3, [r5, #2528]
	mov	r2, #16
	str	r2, [r3, #28]
	ldr	r3, [r4, #2804]
	sub	r3, r3, #1
	str	r3, [r4, #2804]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L805:
	.align	2
.L804:
	.word	.LC81
	.fnend
	.size	HEVC_RemoveApcStore, .-HEVC_RemoveApcStore
	.align	2
	.global	HEVC_RemoveUnusedApcStore
	.type	HEVC_RemoveUnusedApcStore, %function
HEVC_RemoveUnusedApcStore:
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
	ldr	r3, [r0, #2508]
	mov	r6, r0
	cmp	r3, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	add	r5, r0, #2512
	mov	r4, #0
	add	r5, r5, #12
	b	.L809
.L808:
	ldr	r3, [r6, #2508]
	add	r4, r4, #1
	cmp	r4, r3
	bcs	.L812
.L809:
	ldr	r3, [r5, #4]!
	ldrb	r3, [r3, #1]
	cmp	r3, #0
	bne	.L808
	mov	r1, r4
	mov	r0, r6
	bl	HEVC_RemoveApcStore
	ldr	r3, [r6, #2508]
	add	r4, r4, #1
	cmp	r4, r3
	bcc	.L809
.L812:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	HEVC_RemoveUnusedApcStore, .-HEVC_RemoveUnusedApcStore
	.align	2
	.global	HEVC_ApplyReferencePictureSet
	.type	HEVC_ApplyReferencePictureSet, %function
HEVC_ApplyReferencePictureSet:
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
	add	r3, r0, #53248
	ldr	r2, [r0, #2320]
	movw	r4, #2024
	str	r3, [fp, #-68]
	ldr	r1, [r3, #996]
	movw	ip, #26164
	ldr	r3, [r0, #2316]
	mov	r9, r0
	ldr	lr, [r9, #2508]
	mov	r0, #1
	mla	r2, r4, r1, r2
	cmp	lr, #0
	ldr	r2, [r2, #32]
	mla	r3, ip, r2, r3
	ldr	r8, [r3, #128]
	mov	r3, r0, asl r8
	str	r3, [fp, #-48]
	beq	.L813
	add	r8, r9, #2528
	add	r3, r9, #57344
	add	r7, r9, #57344
	str	r9, [fp, #-56]
	mov	r9, r8
	mov	r2, #0
	add	r3, r3, #164
	str	r2, [fp, #-60]
	str	r3, [fp, #-72]
	str	r0, [fp, #-64]
.L830:
	ldr	r0, [r7, #108]
	ldr	r2, [r7, #112]
	ldr	r1, [r7, #116]
	add	r2, r2, r0
	ldr	r5, [r9]
	cmp	r2, r1
	mov	r8, r2
	movcs	r4, #0
	ldrcs	r0, [r5, #12]
	bcs	.L816
	add	r6, r2, #14336
	ldr	r3, [fp, #-56]
	add	r6, r6, #58
	ldr	r10, [r5, #12]
	mov	r4, #0
	add	r6, r3, r6, lsl #2
.L822:
	ldr	r3, [r6, #-1884]
	cmp	r3, #0
	ldr	r3, [r5, #52]
	beq	.L817
	cmp	r3, #0
	beq	.L818
	ldr	r3, [r6]
	cmp	r3, r10
	beq	.L848
.L818:
	cmp	r4, #0
	bne	.L835
	ldr	r1, [r6]
	mov	r4, r10
	b	.L832
.L817:
	cmp	r3, #0
	beq	.L820
	ldr	r1, [fp, #-48]
	mov	r0, r10
	bl	__aeabi_idivmod
	ldr	r0, [r6]
	str	r1, [fp, #-52]
	ldr	r1, [fp, #-48]
	bl	__aeabi_idivmod
	ldr	r3, [fp, #-52]
	cmp	r3, r1
	beq	.L848
.L820:
	cmp	r4, #0
	bne	.L835
	ldr	r3, [r6]
	mov	r0, r10
	ldr	r1, [fp, #-48]
	str	r3, [fp, #-52]
	bl	__aeabi_idivmod
	ldr	r3, [fp, #-52]
	mov	r0, r3
	mov	r4, r1
	ldr	r1, [fp, #-48]
	bl	__aeabi_idivmod
.L832:
	ldrb	r0, [r5, #1]
	rsb	r4, r1, r4
	clz	r4, r4
	cmp	r0, #0
	mov	r4, r4, lsr #5
	moveq	r4, #0
	cmp	r4, #0
	bne	.L849
.L835:
	mov	r0, r10
.L821:
	ldr	r3, [r7, #116]
	add	r8, r8, #1
	add	r6, r6, #4
	mov	r10, r0
	cmp	r8, r3
	bcc	.L822
	ldr	r2, [r7, #112]
	ldr	r1, [r7, #108]
	add	r2, r2, r1
.L816:
	ldr	r3, [fp, #-68]
	cmp	r2, #0
	ldrne	r8, [fp, #-72]
	movne	r6, #0
	ldr	ip, [r3, #968]
	beq	.L824
.L826:
	ldr	r3, [r5, #52]
	add	r6, r6, #1
	cmp	r3, #0
	bne	.L825
	ldr	r3, [r8]
	add	r3, ip, r3
	cmp	r3, r0
	beq	.L850
.L825:
	ldr	r3, [r7, #112]
	add	r8, r8, #4
	ldr	r2, [r7, #108]
	add	r3, r3, r2
	cmp	r6, r3
	bcc	.L826
.L824:
	eor	r4, r4, #1
	cmp	r0, ip
	moveq	r0, #0
	andne	r0, r4, #1
	cmp	r0, #0
	beq	.L828
	mov	r3, #0
	strb	r3, [r5, #1]
	ldr	r2, [r9]
	str	r3, [r2, #52]
	ldr	r2, [r9]
	ldr	r1, [r2, #8]
	cmp	r1, #1
	beq	.L828
	ldr	r1, [r2, #32]
	mov	r2, r3
	ldr	r3, [fp, #-56]
	ldr	r0, [r3, #244]
	bl	FSP_SetRef
.L828:
	ldr	r3, [fp, #-56]
	add	r9, r9, #4
	ldr	r2, [r3, #2508]
	ldr	r3, [fp, #-60]
	add	r3, r3, #1
	str	r3, [fp, #-60]
	cmp	r3, r2
	bcc	.L830
.L813:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L849:
	ldr	r1, [fp, #-64]
	mov	r2, #1
	mov	r4, r2
	strb	r1, [r5, #1]
	ldr	r3, [r9]
	str	r1, [r3, #52]
	ldr	r3, [r9]
	str	r1, [r3, #4]
	ldr	r1, [fp, #-56]
	ldr	r3, [r9]
	ldr	r0, [r1, #244]
	ldr	r1, [r3, #32]
	bl	FSP_SetRef
	ldr	r5, [r9]
	ldr	r0, [r5, #12]
	b	.L821
.L848:
	ldr	r1, [fp, #-64]
	mov	r2, #1
	mov	r4, #1
	strb	r1, [r5, #1]
	ldr	r3, [r9]
	str	r1, [r3, #4]
	ldr	r1, [fp, #-56]
	ldr	r3, [r9]
	ldr	r0, [r1, #244]
	ldr	r1, [r3, #32]
	bl	FSP_SetRef
	ldr	r5, [r9]
	ldr	r0, [r5, #12]
	b	.L821
.L850:
	ldr	r1, [fp, #-64]
	mov	r2, #1
	mov	r4, r2
	strb	r1, [r5, #1]
	ldr	r3, [r9]
	str	r1, [r3, #4]
	ldr	r1, [fp, #-56]
	ldr	r3, [r9]
	ldr	r0, [r1, #244]
	ldr	r1, [r3, #32]
	bl	FSP_SetRef
	ldr	r5, [r9]
	ldr	r3, [fp, #-68]
	ldr	r0, [r5, #12]
	ldr	ip, [r3, #968]
	b	.L825
	.fnend
	.size	HEVC_ApplyReferencePictureSet, .-HEVC_ApplyReferencePictureSet
	.align	2
	.global	HEVC_CheckThatAllRefPicsAreAvailable
	.type	HEVC_CheckThatAllRefPicsAreAvailable, %function
HEVC_CheckThatAllRefPicsAreAvailable:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #44
	sub	sp, sp, #44
	push	{lr}
	bl	__gnu_mcount_nc
	add	r3, r0, #53248
	ldr	ip, [r0, #2320]
	movw	r6, #2024
	add	lr, r0, #57344
	ldr	r2, [r3, #996]
	movw	r5, #26164
	str	r1, [fp, #-84]
	mov	r7, r0
	ldr	r1, [lr, #108]
	mla	ip, r6, r2, ip
	ldr	r6, [lr, #112]
	ldr	r4, [r0, #2316]
	add	r1, r6, r1
	ldr	r2, [lr, #116]
	str	r1, [fp, #-80]
	mov	lr, r1
	cmp	r1, r2
	ldr	ip, [ip, #32]
	str	r0, [fp, #-60]
	mov	r0, #1
	mla	r1, r5, ip, r4
	ldr	r10, [r1, #128]
	mov	r10, r0, asl r10
	bcs	.L852
	add	r9, lr, #14336
	ldr	r6, [r7, #2508]
	add	r9, r9, #58
	mov	r0, #0
	add	r2, r2, #57344
	add	r1, lr, #57344
	add	r9, r7, r9, lsl #2
	mov	ip, r0
	add	r2, r2, #145
	add	r1, r1, #145
	str	r0, [fp, #-64]
	mov	r0, r7
	add	r2, r7, r2
	str	ip, [fp, #-72]
	str	r2, [fp, #-68]
	add	r2, r7, r1
	str	r3, [fp, #-76]
	str	r2, [fp, #-56]
.L853:
	cmp	r6, #0
	beq	.L859
	ldr	r3, [fp, #-60]
	mov	r2, #0
	ldr	r8, [r9, #-1884]
	mov	r5, r2
	add	r4, r3, #2528
	str	r2, [fp, #-52]
	b	.L856
.L896:
	ldr	r3, [r4]
	ldr	r1, [r3, #52]
	cmp	r1, #0
	beq	.L855
	ldr	r0, [r3, #12]
	ldr	r1, [r9]
	cmp	r0, r1
	ldreqb	r3, [r3, #1]
	beq	.L894
.L855:
	add	r5, r5, #1
	add	r4, r4, #4
	cmp	r5, r6
	beq	.L895
.L856:
	cmp	r8, #0
	bne	.L896
	ldr	r7, [r4]
	mov	r1, r10
	ldr	r3, [r7, #52]
	cmp	r3, #0
	beq	.L855
	ldr	r0, [r7, #12]
	bl	__aeabi_idivmod
	ldr	r0, [r9]
	str	r1, [fp, #-48]
	mov	r1, r10
	bl	__aeabi_idivmod
	ldr	r3, [fp, #-48]
	cmp	r3, r1
	bne	.L855
	ldrb	r3, [r7, #1]
.L894:
	cmp	r3, #0
	add	r5, r5, #1
	ldr	r3, [fp, #-52]
	add	r4, r4, #4
	movne	r3, #1
	cmp	r5, r6
	str	r3, [fp, #-52]
	bne	.L856
.L895:
	ldr	r2, [fp, #-52]
	cmp	r2, #0
	beq	.L859
.L857:
	ldr	r3, [fp, #-56]
	add	r9, r9, #4
	ldr	r2, [fp, #-68]
	add	r3, r3, #1
	str	r3, [fp, #-56]
	cmp	r3, r2
	bne	.L853
	ldr	r2, [fp, #-80]
	ldr	r3, [fp, #-76]
	cmp	r2, #0
	beq	.L861
.L860:
	ldr	r2, [fp, #-60]
	mov	r7, #0
	ldr	r0, [fp, #-72]
	add	r4, r2, #57344
	ldr	r10, [fp, #-80]
	mov	r9, r2
	mov	r8, r4
	add	r4, r4, #164
	add	r8, r8, #145
.L865:
	cmp	r6, #0
	beq	.L866
	add	lr, r9, #2512
	mov	r5, #0
	add	lr, lr, #12
	mov	r2, r5
	str	r0, [fp, #-48]
	b	.L863
.L862:
	cmp	r2, r6
	beq	.L897
.L863:
	ldr	r1, [lr, #4]!
	add	r2, r2, #1
	ldr	r0, [r1, #52]
	cmp	r0, #0
	bne	.L862
	ldr	ip, [r4]
	ldr	r0, [r3, #968]
	add	r0, r0, ip
	ldr	ip, [r1, #12]
	cmp	ip, r0
	bne	.L862
	ldrb	r1, [r1, #1]
	cmp	r1, #0
	movne	r5, #1
	cmp	r2, r6
	bne	.L863
.L897:
	cmp	r5, #0
	ldr	r0, [fp, #-48]
	beq	.L866
.L864:
	add	r7, r7, #1
	add	r4, r4, #4
	cmp	r7, r10
	add	r8, r8, #1
	bcc	.L865
	str	r0, [fp, #-72]
.L861:
	ldr	r3, [fp, #-72]
	cmp	r3, #0
	ldrne	r3, [fp, #-84]
	movne	r0, #0
	ldrne	r2, [fp, #-64]
	moveq	r0, #1
	strne	r2, [r3]
.L893:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L866:
	ldr	r2, [r3, #968]
	ldr	ip, [r4]
	ldr	r1, [r9, #200]
	add	r2, r2, ip
	cmp	r2, r1
	blt	.L864
	ldrb	r1, [r8]
	cmp	r1, #0
	ldr	r1, [fp, #-64]
	movne	r0, #1
	movne	r1, r2
	str	r1, [fp, #-64]
	b	.L864
.L859:
	ldr	r3, [fp, #-76]
	ldr	r0, [r9, #-68]
	ldr	r2, [r3, #968]
	ldr	r3, [fp, #-60]
	add	r2, r2, r0
	ldr	r1, [r3, #200]
	cmp	r2, r1
	blt	.L857
	ldr	r3, [fp, #-56]
	ldrb	r1, [r3]
	ldr	r3, [fp, #-64]
	cmp	r1, #0
	movne	r3, r2
	str	r3, [fp, #-64]
	ldr	r3, [fp, #-72]
	movne	r3, #1
	str	r3, [fp, #-72]
	b	.L857
.L852:
	ldr	r2, [fp, #-80]
	cmp	r2, #0
	beq	.L893
	ldr	r1, [fp, #-60]
	mov	r2, #0
	str	r2, [fp, #-64]
	str	r2, [fp, #-72]
	ldr	r6, [r1, #2508]
	b	.L860
	.fnend
	.size	HEVC_CheckThatAllRefPicsAreAvailable, .-HEVC_CheckThatAllRefPicsAreAvailable
	.align	2
	.global	HEVC_SetFrmRepeatCount
	.type	HEVC_SetFrmRepeatCount, %function
HEVC_SetFrmRepeatCount:
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
	ldr	r3, [r0, #2324]
	ldr	r3, [r3, #600]
	add	r3, r3, #2032
	add	r3, r3, #15
	cmp	r3, #4096
	movcc	r3, #0
	strcc	r3, [r1, #24]
	ldmccfd	sp, {fp, sp, pc}
	bl	HEVC_SetFrmRepeatCount.part.4
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_SetFrmRepeatCount, .-HEVC_SetFrmRepeatCount
	.align	2
	.global	HEVC_GetFreeFrameStoreNum
	.type	HEVC_GetFreeFrameStoreNum, %function
HEVC_GetFreeFrameStoreNum:
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
	add	r2, r0, #67584
	add	r4, r0, #80896
	add	r2, r2, #496
	add	r4, r4, #464
	mov	r5, #0
.L906:
	ldr	r3, [r2, #4]
	cmp	r3, #0
	bne	.L902
	cmp	r2, #0
	beq	.L903
	ldr	lr, [r0, #2508]
	cmp	lr, #0
	beq	.L903
	ldr	r1, [r0, #2528]
	cmp	r1, r2
	beq	.L902
	add	r1, r0, #2528
	b	.L904
.L905:
	ldr	ip, [r1, #4]!
	cmp	ip, r2
	beq	.L902
.L904:
	add	r3, r3, #1
	cmp	r3, lr
	bne	.L905
.L903:
	add	r5, r5, #1
.L902:
	add	r2, r2, #664
	cmp	r2, r4
	bne	.L906
	mov	r0, r5
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	HEVC_GetFreeFrameStoreNum, .-HEVC_GetFreeFrameStoreNum
	.align	2
	.global	HEVC_UpdateReflist
	.type	HEVC_UpdateReflist, %function
HEVC_UpdateReflist:
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
	add	r10, r0, #57344
	mov	r5, r0
	ldr	r1, [r10, #108]
	cmp	r1, #0
	beq	.L940
	mov	r7, #0
	add	r9, r10, #144
	add	r8, r10, #164
	add	ip, r0, #53248
	mov	r6, r7
.L924:
	ldrb	r3, [r9, #1]!
	cmp	r3, #0
	beq	.L918
	ldr	r4, [r5, #2508]
	ldr	lr, [ip, #968]
	ldr	r3, [r8]
	cmp	r4, #0
	add	lr, lr, r3
	beq	.L918
	ldr	r1, [r5, #2528]
	ldr	r3, [r1, #12]
	cmp	r3, lr
	addne	r2, r5, #2528
	movne	r3, #0
	bne	.L921
	b	.L972
.L923:
	ldr	r1, [r2, #4]!
	ldr	r0, [r1, #12]
	cmp	r0, lr
	beq	.L919
.L921:
	add	r3, r3, #1
	cmp	r3, r4
	bne	.L923
.L918:
	ldr	r1, [r10, #108]
	add	r6, r6, #1
	add	r8, r8, #4
	cmp	r1, r6
	bhi	.L924
.L917:
	ldr	r2, [r5, #2504]
	str	r7, [r5, #2520]
	cmp	r2, r7
	addhi	r3, r7, #648
	movhi	r0, #0
	addhi	r3, r5, r3, lsl #2
	bls	.L929
.L928:
	add	r7, r7, #1
	str	r0, [r3, #4]!
	cmp	r7, r2
	bne	.L928
.L929:
	ldr	r8, [r10, #112]
	add	r8, r1, r8
	cmp	r8, r6
	movls	r7, #0
	bls	.L927
	add	r9, r6, #14336
	add	r10, r6, #57344
	add	r9, r9, #41
	add	r10, r10, #144
	add	r10, r5, r10
	add	ip, r5, #53248
	add	r9, r5, r9, lsl #2
	mov	r7, #0
.L936:
	ldrb	r3, [r10, #1]!
	cmp	r3, #0
	beq	.L930
	ldr	r4, [r5, #2508]
	ldr	lr, [ip, #968]
	ldr	r3, [r9]
	cmp	r4, #0
	add	lr, lr, r3
	beq	.L930
	ldr	r1, [r5, #2528]
	ldr	r3, [r1, #12]
	cmp	r3, lr
	addne	r2, r5, #2528
	movne	r3, #0
	bne	.L933
	b	.L973
.L935:
	ldr	r1, [r2, #4]!
	ldr	r0, [r1, #12]
	cmp	r0, lr
	beq	.L931
.L933:
	add	r3, r3, #1
	cmp	r3, r4
	bne	.L935
.L930:
	add	r6, r6, #1
	add	r9, r9, #4
	cmp	r8, r6
	bhi	.L936
.L976:
	ldr	r2, [r5, #2504]
.L927:
	cmp	r2, r7
	str	r7, [r5, #2524]
	bls	.L916
	add	r1, r7, #664
	mov	r3, #0
	add	r1, r1, #1
	add	r5, r5, r1, lsl #2
.L938:
	add	r7, r7, #1
	str	r3, [r5, #4]!
	cmp	r7, r2
	bne	.L938
.L916:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L972:
	mov	r3, #0
.L919:
	add	r4, r5, r3, lsl #2
	mov	r2, #1
	strb	r2, [r1, #1]
	ldr	r3, [r4, #2528]
	ldrb	r1, [r3, #1]
	cmp	r1, #0
	bne	.L974
.L922:
	mov	r2, #1
	str	r2, [r3, #56]
	ldr	r2, [r4, #2528]
	mov	r1, #0
	add	r3, r5, r7, lsl #2
	add	r7, r7, #1
	str	r1, [r2, #52]
	ldr	r2, [r4, #2528]
	str	r2, [r3, #2596]
	b	.L918
.L973:
	mov	r3, #0
.L931:
	add	r4, r5, r3, lsl #2
	mov	r2, #1
	strb	r2, [r1, #1]
	ldr	r3, [r4, #2528]
	ldrb	r1, [r3, #1]
	cmp	r1, #0
	bne	.L975
.L934:
	mov	r2, #1
	str	r2, [r3, #56]
	ldr	r2, [r4, #2528]
	add	r3, r7, #664
	mov	r1, #0
	add	r6, r6, #1
	add	r3, r3, #2
	cmp	r8, r6
	str	r1, [r2, #52]
	add	r7, r7, #1
	ldr	r2, [r4, #2528]
	add	r9, r9, #4
	str	r2, [r5, r3, asl #2]
	bhi	.L936
	b	.L976
.L974:
	ldr	r1, [r3, #32]
	ldr	r0, [r5, #244]
	str	ip, [fp, #-48]
	bl	FSP_SetRef
	ldr	r3, [r4, #2528]
	ldr	ip, [fp, #-48]
	b	.L922
.L975:
	ldr	r1, [r3, #32]
	ldr	r0, [r5, #244]
	str	ip, [fp, #-48]
	bl	FSP_SetRef
	ldr	r3, [r4, #2528]
	ldr	ip, [fp, #-48]
	b	.L934
.L940:
	mov	r7, r1
	mov	r6, r1
	b	.L917
	.fnend
	.size	HEVC_UpdateReflist, .-HEVC_UpdateReflist
	.align	2
	.global	HEVC_UpdateLTReflist
	.type	HEVC_UpdateLTReflist, %function
HEVC_UpdateLTReflist:
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
	add	r3, r0, #53248
	ldr	r2, [r0, #2320]
	movw	ip, #2024
	add	r10, r0, #57344
	ldr	r3, [r3, #996]
	movw	r4, #26164
	ldr	r5, [r10, #112]
	mov	r1, #1
	ldr	lr, [r0, #2316]
	mla	ip, ip, r3, r2
	ldr	r2, [r10, #108]
	ldr	r3, [r10, #116]
	add	r2, r2, r5
	sub	r2, r2, #1
	sub	r9, r3, #1
	cmp	r9, r2
	ldr	ip, [ip, #32]
	mla	r2, r4, ip, lr
	ldr	r8, [r2, #128]
	mov	r8, r1, asl r8
	ble	.L988
	add	r7, r3, #14336
	add	r3, r3, #57344
	add	r7, r7, #57
	add	r3, r3, #145
	add	r3, r0, r3
	sub	r8, r8, #1
	add	r7, r0, r7, lsl #2
	mov	r6, #0
	str	r6, [fp, #-48]
	mov	r6, r3
	str	r1, [fp, #-52]
.L984:
	ldrb	r3, [r6, #-1]!
	cmp	r3, #0
	beq	.L979
	ldrb	r4, [r7, #-1884]
	ldr	lr, [r7]
	ldr	r5, [r0, #2508]
	cmp	r4, #0
	andeq	lr, lr, r8
	cmp	r5, #0
	ble	.L979
	add	r1, r0, #2512
	mov	r3, #0
	add	r1, r1, #12
	b	.L983
.L982:
	add	r3, r3, #1
	cmp	r3, r5
	beq	.L979
.L983:
	ldr	ip, [r1, #4]!
	cmp	r4, #0
	ldr	r2, [ip, #12]
	andeq	r2, r2, r8
	cmp	lr, r2
	bne	.L982
	ldr	r1, [fp, #-48]
	add	r3, r0, r3, lsl #2
	ldr	lr, [fp, #-52]
	add	r2, r0, r1, lsl #2
	add	r1, r1, #1
	strb	lr, [ip, #1]
	mov	ip, #0
	str	r1, [fp, #-48]
	ldr	r1, [r3, #2528]
	str	ip, [r1, #56]
	ldr	r1, [r3, #2528]
	str	lr, [r1, #52]
	ldr	r3, [r3, #2528]
	str	r3, [r2, #2732]
.L979:
	ldr	r3, [r10, #108]
	sub	r9, r9, #1
	ldr	r2, [r10, #112]
	sub	r7, r7, #4
	add	r3, r3, r2
	sub	r3, r3, #1
	cmp	r3, r9
	blt	.L984
	ldr	r6, [fp, #-48]
	mov	r2, r6
.L978:
	ldr	r3, [r0, #2504]
	str	r2, [r0, #2516]
	cmp	r3, r6
	ble	.L977
	add	r1, r6, #680
	mov	r2, #0
	add	r1, r1, #2
	add	r0, r0, r1, lsl #2
.L986:
	add	r6, r6, #1
	str	r2, [r0, #4]!
	cmp	r6, r3
	bne	.L986
.L977:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L988:
	mov	r2, #0
	mov	r6, r2
	b	.L978
	.fnend
	.size	HEVC_UpdateLTReflist, .-HEVC_UpdateLTReflist
	.align	2
	.global	HEVC_GetAPC
	.type	HEVC_GetAPC, %function
HEVC_GetAPC:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #20
	sub	sp, sp, #20
	push	{lr}
	bl	__gnu_mcount_nc
	subs	r6, r1, #0
	mov	r5, r0
	beq	.L996
	ldr	ip, [r0, #2800]
	cmp	ip, #0
	beq	.L1005
	ldr	r4, [r0, #2808]
	cmp	r4, #0
	addne	r3, r0, #2800
	movne	r4, #0
	addne	r3, r3, #8
	bne	.L1000
	b	.L998
.L1003:
	ldr	r2, [r3, #4]!
	cmp	r2, #0
	beq	.L998
.L1000:
	add	r4, r4, #1
	cmp	r4, ip
	bne	.L1003
.L1005:
	mvn	r0, #6
.L1009:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L998:
	ldr	r1, [r6, #32]
	ldr	r0, [r5, #244]
	bl	FSP_GetLogicFs
	subs	ip, r0, #0
	beq	.L1001
	ldr	r3, [ip, #608]
	cmp	r3, #0
	beq	.L1001
	add	r2, r5, r4, lsl #2
	mov	r0, #1
	mov	r3, r4
	ldr	r1, .L1010
	str	r0, [r2, #2808]
	mov	r0, #13
	ldr	ip, [ip, #608]
	ldr	ip, [ip, #8]
	str	ip, [r2, #2872]
	ldr	ip, [r6, #12]
	str	ip, [r2, #2936]
	ldr	r2, [r5, #2804]
	add	r2, r2, #1
	str	r2, [r5, #2804]
	ldr	r2, [r6, #228]
	bl	dprint_vfmw
	mov	r0, #0
	str	r4, [r6, #28]
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L1001:
	ldrb	r1, [r6, #1]
	mov	r0, #0
	ldr	r2, [r6, #32]
	ldr	r3, [r6, #12]
	stmia	sp, {r1, ip}
	str	r0, [sp, #8]
	ldr	r1, .L1010+4
	bl	dprint_vfmw
	mvn	r0, #6
	b	.L1009
.L996:
	mov	r0, r6
	movw	r3, #8907
	ldr	r2, .L1010+8
	ldr	r1, .L1010+12
	bl	dprint_vfmw
	mvn	r0, #6
	b	.L1009
.L1011:
	.align	2
.L1010:
	.word	.LC82
	.word	.LC83
	.word	.LC43
	.word	.LC44
	.fnend
	.size	HEVC_GetAPC, .-HEVC_GetAPC
	.align	2
	.global	HEVC_CheckFrameStore
	.type	HEVC_CheckFrameStore, %function
HEVC_CheckFrameStore:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, fp, ip, lr, pc}
	.pad #4
	.save {r4, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #12
	sub	sp, sp, #12
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r4, r1
	ldr	r0, [r0, #244]
	ldr	r1, [r1, #32]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	beq	.L1013
	ldrsb	r2, [r0, #1]
	cmp	r2, #3
	cmpne	r2, #0
	moveq	r0, #1
	movne	r0, #0
	beq	.L1032
	ldr	r3, [r4, #8]
	cmp	r3, #1
	beq	.L1019
	ldr	r2, [r4, #4]
	ldrb	r3, [r4]
	cmp	r2, #0
	beq	.L1018
	cmp	r3, #1
	beq	.L1018
.L1029:
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L1032:
	ldr	r3, [r4, #32]
	mov	r0, #13
	str	r2, [sp]
	ldr	r1, .L1033
	ldr	r2, .L1033+4
	bl	dprint_vfmw
.L1015:
	ldr	r3, [r4, #8]
	cmp	r3, #1
	beq	.L1019
	ldr	r3, [r4, #12]
	mov	r0, #1
	ldr	r2, .L1033+4
	ldr	r1, .L1033+8
	bl	dprint_vfmw
	mvn	r0, #2
	b	.L1029
.L1013:
	ldr	lr, [r4, #32]
	mov	r2, r4
	ldr	ip, [r4, #8]
	mov	r0, #1
	ldr	r3, [r4, #12]
	ldr	r1, .L1033+12
	stmia	sp, {ip, lr}
	bl	dprint_vfmw
	b	.L1015
.L1018:
	str	r3, [sp, #4]
	mov	r0, #1
	str	r2, [sp]
	mov	r3, r4
	ldr	r2, .L1033+4
	ldr	r1, .L1033+16
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1029
.L1019:
	mov	r2, #1
	mov	r3, #2
	strb	r2, [r4, #2]
	mvn	r0, #2
	str	r3, [r4, #8]
	b	.L1029
.L1034:
	.align	2
.L1033:
	.word	.LC84
	.word	.LANCHOR1+260
	.word	.LC86
	.word	.LC85
	.word	.LC87
	.fnend
	.size	HEVC_CheckFrameStore, .-HEVC_CheckFrameStore
	.align	2
	.global	HEVC_GetImagePara
	.type	HEVC_GetImagePara, %function
HEVC_GetImagePara:
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
	ldr	r3, [r1, #180]
	mov	r4, r1
	add	r1, r0, #24576
	bic	r3, r3, #16128
	mov	r2, #25600
	bic	r3, r3, #3
	str	r2, [r4, #208]
	str	r3, [r4, #180]
	ldr	r1, [r1, #2776]
	ldr	r2, [r4, #16]
	add	r1, r1, #12288
	ldr	r1, [r1, #180]
	bic	r1, r1, #-16777216
	bic	r1, r1, #255
	cmp	r1, #256
	beq	.L1042
	cmp	r1, #65536
	moveq	r1, #256
	beq	.L1036
	mov	ip, #256
	movt	ip, 1
	cmp	r1, ip
	beq	.L1051
.L1042:
	mov	r1, #0
.L1036:
	ldr	ip, [r4, #4]
	and	r2, r2, #3
	orr	r3, r3, r2
	cmp	ip, #0
	orr	r3, r3, #11264
	orr	r3, r3, r1
	str	r3, [r4, #180]
	ldrne	r3, [r4, #20]
	ldr	r1, [r4, #32]
	strne	r3, [r4, #232]
	ldr	r0, [r0, #244]
	bl	FSP_GetFsImagePtr
	subs	r5, r0, #0
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r3, .L1052
	mov	r2, #592
	add	r1, r4, #72
	ldr	r3, [r3, #52]
	blx	r3
	mov	r3, #16
	str	r3, [r5, #340]
	mov	r3, #1
	ldr	r2, [r4, #48]
	strb	r3, [r5, #335]
	cmp	r2, #0
	strb	r3, [r5, #333]
	moveq	r3, #0
	movne	r3, #4
	strb	r3, [r5, #328]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1051:
	add	r1, r0, #4096
	ldr	r1, [r1, #448]
	cmp	r1, #0
	movne	r1, #0
	moveq	r1, #256
	b	.L1036
.L1053:
	.align	2
.L1052:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	HEVC_GetImagePara, .-HEVC_GetImagePara
	.align	2
	.global	HEVC_OutputCurrPic
	.type	HEVC_OutputCurrPic, %function
HEVC_OutputCurrPic:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #12
	sub	sp, sp, #12
	push	{lr}
	bl	__gnu_mcount_nc
	add	r6, r0, #53248
	mov	r4, r0
	mov	r2, #592
	add	r1, r6, #328
	ldr	r5, [r6, #324]
	ldr	r3, [r6, #320]
	add	r0, r5, #72
	str	r3, [r5, #20]
	bl	memcpy
	mov	r1, r5
	mov	r0, r4
	bl	HEVC_GetImagePara
	ldr	r1, [r5, #32]
	ldr	r0, [r4, #244]
	bl	FSP_GetFsImagePtr
	subs	r7, r0, #0
	beq	.L1076
	ldr	r2, [r5, #20]
	cmp	r2, #0
	str	r2, [r7, #160]
	bne	.L1057
.L1062:
	ldrb	r3, [r6, #280]
	cmp	r3, #0
	bne	.L1077
.L1059:
	mov	r2, #1
	ldr	r1, [r5, #32]
	ldr	r0, [r4, #244]
	bl	FSP_SetDisplay
	add	r3, r4, #61440
	ldr	r0, [r4, #244]
	add	r3, r3, #192
	str	r7, [sp]
	mov	r2, r4
	mov	r1, #16
	bl	InsertImgToVoQueue
	cmp	r0, #1
	bne	.L1078
	ldr	r3, [r4, #2324]
	ldr	r3, [r3, #600]
	add	r3, r3, #2032
	add	r3, r3, #15
	cmp	r3, #4096
	movcc	r3, #0
	strcc	r3, [r7, #24]
	bcs	.L1079
.L1066:
	ldr	r2, [r4, #284]
	mov	r0, #0
	ldr	r3, [r4, #276]
	add	r2, r2, #1
	str	r2, [r4, #284]
	add	r3, r3, #1
	str	r3, [r4, #276]
.L1056:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L1057:
	ldr	r8, [r6, #292]
	cmp	r8, #0
	beq	.L1080
.L1060:
	ldr	r3, [r4, #2324]
	ldr	r3, [r3, #4]
	cmp	r3, r2
	bcs	.L1062
	ldr	r1, [r5, #32]
	mov	r2, #0
	ldr	r0, [r4, #244]
	bl	FSP_SetDisplay
	ldr	r1, [r4, #2324]
	ldr	r3, [r7, #160]
	mov	r0, #1
	ldr	r2, .L1081
	ldr	ip, [r1, #4]
	ldr	r1, .L1081+4
	str	ip, [sp]
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1056
.L1077:
	mov	r2, #1
	ldr	r1, [r5, #32]
	ldr	r0, [r4, #244]
	bl	FSP_SetRef
	b	.L1059
.L1079:
	mov	r1, r7
	mov	r0, r4
	bl	HEVC_SetFrmRepeatCount.part.4
	b	.L1066
.L1080:
	ldr	r2, .L1081
	mov	r0, #1
	ldr	r1, .L1081+8
	bl	dprint_vfmw
	ldr	r3, .L1081+12
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L1061
	mov	r3, r8
	mov	r2, r8
	mov	r1, #111
	ldr	r0, [r4, #244]
	blx	ip
.L1061:
	ldr	r2, [r7, #160]
	cmp	r2, #0
	bne	.L1060
	b	.L1062
.L1078:
	ldr	r2, .L1081
	mov	r0, #1
	ldr	r1, .L1081+16
	bl	dprint_vfmw
	ldr	r0, [r4, #244]
	ldr	r1, [r5, #32]
	mov	r2, #0
	bl	FSP_SetDisplay
	mvn	r0, #0
	b	.L1056
.L1076:
	ldr	r2, .L1081
	ldr	r1, .L1081+20
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1056
.L1082:
	.align	2
.L1081:
	.word	.LANCHOR1+284
	.word	.LC91
	.word	.LC89
	.word	g_event_report
	.word	.LC90
	.word	.LC88
	.fnend
	.size	HEVC_OutputCurrPic, .-HEVC_OutputCurrPic
	.align	2
	.global	HEVC_FirstFrameFastOut
	.type	HEVC_FirstFrameFastOut, %function
HEVC_FirstFrameFastOut:
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
	bl	HEVC_OutputCurrPic
	subs	r5, r0, #0
	bne	.L1086
	add	r3, r4, #53248
	add	r1, r4, #61440
	mov	r2, #1
	mov	ip, #2
	ldr	r0, [r3, #324]
	str	ip, [r0, #8]
	mov	r0, r5
	str	r2, [r1, #544]
	ldr	r1, [r3, #288]
	str	r1, [r4, #212]
	ldr	r3, [r3, #324]
	strb	r2, [r3, #2]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1086:
	ldr	r2, .L1087
	mov	r0, #1
	ldr	r1, .L1087+4
	bl	dprint_vfmw
	mov	r0, r5
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1088:
	.align	2
.L1087:
	.word	.LANCHOR1+304
	.word	.LC92
	.fnend
	.size	HEVC_FirstFrameFastOut, .-HEVC_FirstFrameFastOut
	.align	2
	.global	HEVC_CheckOutputImage
	.type	HEVC_CheckOutputImage, %function
HEVC_CheckOutputImage:
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
	cmp	r1, #19
	bhi	.L1091
	mov	r3, #664
	mla	r1, r3, r1, r0
	add	r1, r1, #67584
	ldrb	r0, [r1, #497]
	adds	r0, r0, #0
	movne	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L1091:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_CheckOutputImage, .-HEVC_CheckOutputImage
	.align	2
	.global	HEVC_DECRecycleImage
	.type	HEVC_DECRecycleImage, %function
HEVC_DECRecycleImage:
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
	mov	r5, r0
	ldr	r0, [r0, #244]
	mov	r8, r1
	bl	FSP_GetLogicFs
	cmp	r0, #0
	beq	.L1097
	ldrsb	r3, [r0, #1]
	cmp	r3, #0
	addne	r4, r0, #528
	addne	r9, r0, #560
	movne	r6, #0
	movne	r7, #0
	beq	.L1102
.L1096:
	ldrd	r2, [r4, #8]!
	orrs	r1, r2, r3
	bne	.L1103
.L1095:
	cmp	r4, r9
	bne	.L1096
	ldr	r0, [r5, #244]
	mov	r1, r8
	mov	r2, #0
	bl	FSP_SetDisplay
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1103:
	mov	r1, r2
	ldr	r0, [r5, #244]
	bl	FreeUsdByDec
	strd	r6, [r4]
	b	.L1095
.L1102:
	ldr	r1, .L1104
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1097:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1105:
	.align	2
.L1104:
	.word	.LC93
	.fnend
	.size	HEVC_DECRecycleImage, .-HEVC_DECRecycleImage
	.align	2
	.global	HEVC_ArrangeVahbMem
	.type	HEVC_ArrangeVahbMem, %function
HEVC_ArrangeVahbMem:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #44
	sub	sp, sp, #44
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r3, .L1114
	mov	r5, r1
	mov	r6, r2
	mov	r4, r0
	mov	r2, #32
	sub	r0, fp, #60
	ldr	r3, [r3, #48]
	mov	r1, #0
	blx	r3
	ldr	r3, [r4, #2324]
	str	r6, [fp, #-32]
	mov	r0, #0
	str	r5, [fp, #-52]
	ldr	r3, [r3, #28]
	str	r6, [fp, #-48]
	cmp	r3, #24
	str	r5, [fp, #-44]
	str	r6, [fp, #-40]
	str	r5, [fp, #-36]
	strb	r0, [fp, #-60]
	strb	r0, [fp, #-59]
	beq	.L1107
	ldr	r2, [r4, #2504]
	mov	r1, #5
	ldrb	r3, [fp, #12]
	strb	r0, [fp, #-56]
	strb	r1, [fp, #-55]
	strb	r2, [fp, #-57]
.L1110:
	sub	r1, fp, #60
	ldr	r0, [r4, #244]
	strb	r3, [fp, #-54]
	mov	r3, #0
	strb	r3, [fp, #-58]
	bl	FSP_ConfigInstance
	cmp	r0, #0
	bne	.L1108
	ldr	r1, [r4, #2324]
	sub	r3, fp, #64
	ldr	r0, [r4, #244]
	ldr	r2, [r1, #24]
	ldr	r1, [r1, #20]
	bl	FSP_ConfigFrameBuf
	cmp	r0, #0
	moveq	r0, #1
	bne	.L1113
.L1112:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L1107:
	mov	r3, #1
	mov	r2, #5
	strb	r0, [fp, #-56]
	strb	r3, [fp, #-57]
	strb	r2, [fp, #-55]
	b	.L1110
.L1108:
	ldr	r1, .L1114+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #19
	b	.L1112
.L1113:
	ldr	r1, .L1114+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #19
	b	.L1112
.L1115:
	.align	2
.L1114:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC95
	.word	.LC94
	.fnend
	.size	HEVC_ArrangeVahbMem, .-HEVC_ArrangeVahbMem
	.align	2
	.global	HEVC_AllocFrameStore
	.type	HEVC_AllocFrameStore, %function
HEVC_AllocFrameStore:
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
	add	r6, r0, #53248
	ldr	r3, [r0, #2320]
	movw	lr, #2024
	ldr	r2, [r6, #996]
	mov	r7, r0
	ldr	r0, [r0, #2316]
	movw	r5, #26164
	add	ip, r7, #67584
	mov	r1, #0
	mla	r3, lr, r2, r3
	add	ip, ip, #496
	mov	lr, r1
	ldr	r3, [r3, #32]
	strb	r1, [r6, #281]
	mla	r5, r5, r3, r0
.L1121:
	ldr	r3, [ip, #4]
	cmp	r3, #0
	bne	.L1117
	cmp	ip, #0
	beq	.L1129
	ldr	r0, [r7, #2508]
	cmp	r0, #0
	beq	.L1129
	ldr	r2, [r7, #2528]
	cmp	r2, ip
	beq	.L1117
	add	r2, r7, #2528
	b	.L1119
.L1120:
	ldr	r1, [r2, #4]!
	cmp	r1, ip
	beq	.L1117
.L1119:
	add	r3, r3, #1
	cmp	r3, r0
	bne	.L1120
.L1129:
	mov	r8, #664
	mov	r4, ip
	mla	lr, r8, lr, r7
	mov	r3, #101
	mov	r2, #592
	str	r3, [r6, #320]
	add	r0, r6, #328
	mov	r3, #1
	add	r8, lr, #67584
	strb	r3, [r6, #281]
	add	r1, r8, #568
	bl	memcpy
	str	r4, [r6, #324]
	mov	r3, #0
	str	r3, [r6, #488]
	str	r3, [r8, #516]
	strb	r3, [r8, #498]
	strb	r3, [r4]
	ldr	r2, [r6, #324]
	str	r3, [r2, #52]
	ldr	r2, [r6, #324]
	str	r3, [r2, #56]
	ldr	r2, [r6, #324]
	str	r3, [r2, #8]
	ldrb	r1, [r6, #281]
	cmp	r1, #1
	bne	.L1126
	ldr	r0, [r7, #244]
	bl	FSP_NewLogicFs
	mov	r9, r0
	mov	r1, r0
	ldr	r0, [r7, #244]
	bl	FSP_GetLogicFs
	mov	r4, r0
	mvn	r0, r9
	cmp	r4, #0
	mov	r0, r0, lsr #31
	moveq	r0, #0
	cmp	r0, #0
	beq	.L1123
	ldrb	r3, [r5, #2629]
	add	r1, r7, #6784
	add	r0, r4, #272
	mov	r8, #3
	mov	r2, r1
	add	r1, r1, #48
	strb	r3, [r4, #248]
	add	r2, r2, #60
	ldr	ip, [r5, #2664]
	mov	r3, r4
	str	ip, [r4, #252]
	ldr	ip, [r5, #2668]
	str	ip, [r4, #256]
	ldr	ip, [r5, #2672]
	str	ip, [r3, #260]!
.L1124:
	ldr	ip, [r1, #4]!
	subs	r8, r8, #1
	str	ip, [r3, #4]!
	ldr	ip, [r2, #4]!
	str	ip, [r0, #4]!
	bne	.L1124
	add	r3, r7, #4096
	ldr	r2, [r3, #2764]
	str	r2, [r4, #288]
	ldr	r2, [r3, #2768]
	str	r2, [r4, #292]
	ldr	r2, [r3, #2772]
	str	r2, [r4, #296]
	ldr	r3, [r3, #2776]
	str	r3, [r4, #300]
	ldr	r3, [r7, #2324]
	ldr	r3, [r3, #28]
	cmp	r3, #25
	beq	.L1134
.L1125:
	ldr	r5, .L1135
	add	r1, r4, #8
	ldr	r0, [r6, #324]
	mov	r2, #592
	ldr	r3, [r5, #52]
	add	r0, r0, #72
	blx	r3
	ldr	r1, [r6, #324]
	add	r0, r7, #53504
	ldr	r3, [r5, #52]
	add	r1, r1, #72
	mov	r2, #592
	add	r0, r0, #72
	blx	r3
	ldr	r3, [r6, #324]
	mov	r0, #0
	str	r9, [r3, #32]
	ldrsb	r3, [r4, #4]
	str	r3, [r6, #316]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1117:
	add	lr, lr, #1
	add	ip, ip, #664
	cmp	lr, #20
	bne	.L1121
.L1126:
	ldr	r1, .L1135+4
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1134:
	add	r3, r7, #24576
	ldr	r5, [r4, #148]
	ldr	r0, [r4, #52]
	ldr	r2, [r3, #2780]
	ldr	r3, [r2, #76]
	ldr	r2, [r2, #72]
	mul	r5, r5, r3
	str	r2, [r4, #120]
	str	r3, [r4, #124]
	add	r0, r5, r0
	str	r0, [r4, #56]
	bl	MEM_Phy2Vir
	ldr	r2, [r4, #36]
	ldr	r3, [r4, #148]
	str	r8, [r4, #492]
	str	r0, [r4, #488]
	ldr	r0, [r4, #68]
	add	r0, r5, r0
	add	r5, r5, r2
	str	r0, [r4, #72]
	str	r5, [r4, #40]
	add	r5, r5, r3
	str	r5, [r4, #48]
	bl	MEM_Phy2Vir
	str	r8, [r4, #508]
	str	r0, [r4, #504]
	b	.L1125
.L1123:
	strb	r0, [r6, #281]
	ldr	r1, .L1135+8
	bl	dprint_vfmw
	mvn	r0, #3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1136:
	.align	2
.L1135:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC96
	.word	.LC97
	.fnend
	.size	HEVC_AllocFrameStore, .-HEVC_AllocFrameStore
	.align	2
	.global	HEVC_IsVoFinish
	.type	HEVC_IsVoFinish, %function
HEVC_IsVoFinish:
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
	mov	r5, r0
	ldr	r0, [r0, #244]
	bl	FSP_GetFspType
	cmn	r0, #1
	mov	r4, r0
	movne	r4, #0
	bne	.L1141
	b	.L1144
.L1140:
	ldrsb	r3, [r0, #1]
	cmp	r3, #3
	beq	.L1142
	cmp	r4, #32
	beq	.L1145
.L1141:
	mov	r1, r4
	ldr	r0, [r5, #244]
	bl	FSP_GetLogicFs
	add	r4, r4, #1
	cmp	r0, #0
	bne	.L1140
	ldr	r1, .L1146
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1144:
	ldr	r1, .L1146+4
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1142:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1145:
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1147:
	.align	2
.L1146:
	.word	.LC99
	.word	.LC98
	.fnend
	.size	HEVC_IsVoFinish, .-HEVC_IsVoFinish
	.align	2
	.global	HEVC_GetBackPicFromVOQueue
	.type	HEVC_GetBackPicFromVOQueue, %function
HEVC_GetBackPicFromVOQueue:
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
	mov	r5, r0
	ldr	r0, [r0, #244]
	bl	FSP_GetFspType
	cmp	r0, #0
	beq	.L1162
.L1149:
	add	r9, r5, #68608
	add	r8, r5, #81920
	add	r9, r9, #96
	add	r8, r8, #64
	mov	r6, #0
	mov	r7, #0
.L1152:
	sub	r4, r9, #32
	mov	r3, #0
	strb	r3, [r9, #-623]
	str	r3, [r9, #-620]
.L1151:
	ldrd	r2, [r4, #8]!
	orrs	r1, r2, r3
	bne	.L1163
.L1150:
	cmp	r4, r9
	bne	.L1151
	add	r9, r4, #664
	cmp	r9, r8
	bne	.L1152
	ldr	r2, [r5, #180]
	cmp	r2, #0
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	mov	r3, #0
	add	r5, r5, #2112
	mov	r1, r3
.L1154:
	add	r3, r3, #1
	str	r1, [r5, #4]!
	cmp	r3, r2
	bne	.L1154
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1163:
	mov	r1, r2
	ldr	r0, [r5, #244]
	bl	FreeUsdByDec
	strd	r6, [r4]
	b	.L1150
.L1162:
	add	r0, r5, #61440
	add	r0, r0, #192
	bl	ResetVoQueue
	b	.L1149
	.fnend
	.size	HEVC_GetBackPicFromVOQueue, .-HEVC_GetBackPicFromVOQueue
	.align	2
	.global	HEVC_RemoveFrameStoreOutDPB
	.type	HEVC_RemoveFrameStoreOutDPB, %function
HEVC_RemoveFrameStoreOutDPB:
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
	add	r6, r0, r1, lsl #2
	mov	r7, #0
	mov	r4, r1
	ldr	r3, [r6, #2528]
	mov	r5, r0
	str	r7, [r3, #4]
	ldr	r3, [r6, #2528]
	ldr	r0, [r0, #244]
	ldr	r1, [r3, #32]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	beq	.L1165
	ldrsb	r3, [r0, #1]
	cmp	r3, #3
	beq	.L1166
	ldr	r3, [r6, #2528]
	mov	r2, r7
	ldr	r0, [r5, #244]
	ldr	r1, [r3, #32]
	bl	FSP_SetDisplay
.L1166:
	ldr	r3, [r6, #2528]
	mov	r2, #0
	ldr	r0, [r5, #244]
	ldr	r1, [r3, #32]
	bl	FSP_SetRef
.L1165:
	ldr	r1, [r5, #2508]
	sub	r1, r1, #1
	cmp	r4, r1
	addls	r3, r4, #632
	addls	r3, r5, r3, lsl #2
	bhi	.L1169
.L1168:
	add	r4, r4, #1
	ldr	r2, [r3, #4]!
	cmp	r4, r1
	str	r2, [r3, #-4]
	bls	.L1168
.L1169:
	add	r3, r1, #632
	mov	r2, #0
	str	r2, [r5, r3, asl #2]
	str	r1, [r5, #2508]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	HEVC_RemoveFrameStoreOutDPB, .-HEVC_RemoveFrameStoreOutDPB
	.align	2
	.global	HEVC_RemoveDummyFrame
	.type	HEVC_RemoveDummyFrame, %function
HEVC_RemoveDummyFrame:
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
	ldr	r3, [r0, #2508]
	mov	r5, r0
	cmp	r3, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	mov	r7, #0
	mov	r4, r7
	mov	r6, r7
	b	.L1181
.L1180:
	ldr	r3, [r5, #2508]
	add	r4, r4, #1
	cmp	r4, r3
	mov	r7, r4
	bcs	.L1187
.L1181:
	add	r3, r4, #632
	ldr	r3, [r5, r3, asl #2]
	ldrb	r2, [r3]
	cmp	r2, #0
	beq	.L1180
	mov	r1, r7
	mov	r0, r5
	strb	r6, [r3]
	sub	r4, r4, #1
	bl	HEVC_RemoveApcStore
	mov	r1, r7
	mov	r0, r5
	bl	HEVC_RemoveFrameStoreOutDPB
	b	.L1180
.L1187:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	HEVC_RemoveDummyFrame, .-HEVC_RemoveDummyFrame
	.align	2
	.global	HEVC_RemoveUnUsedFrameStore
	.type	HEVC_RemoveUnUsedFrameStore, %function
HEVC_RemoveUnUsedFrameStore:
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
	ldr	r5, [r0, #2508]
	mov	r7, r0
	cmp	r5, #0
	beq	.L1197
	mov	r6, #0
	mvn	r8, #0
	mov	r10, r6
	mov	r9, r6
	b	.L1196
.L1207:
	ldrsb	r3, [r0, #1]
	cmp	r3, #0
	cmpne	r3, #3
	ldr	r3, [r4, #2528]
	bne	.L1192
	ldr	r0, [r3, #8]
	cmp	r0, #1
	beq	.L1192
	str	r8, [r3, #32]
	mov	r2, #1
	ldr	r3, [r4, #2528]
	strb	r1, [r3, #1]
	ldr	r3, [r4, #2528]
	strb	r2, [r3, #2]
	ldr	r3, [r4, #2528]
.L1192:
	ldr	r3, [r3]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #65536
	addne	r10, r10, #1
	beq	.L1206
	add	r9, r9, #1
	cmp	r9, r5
	beq	.L1189
.L1196:
	add	r4, r7, r10, lsl #2
	ldr	r0, [r7, #244]
	ldr	r3, [r4, #2528]
	ldr	r1, [r3, #32]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	beq	.L1190
	ldrsb	r1, [r0]
	cmp	r1, #0
	beq	.L1207
	ldr	r3, [r4, #2528]
	b	.L1192
.L1190:
	ldr	r3, [r4, #2528]
	ldr	r1, [r3, #8]
	cmp	r1, #1
	beq	.L1192
	str	r8, [r3, #32]
	mov	r2, #1
	ldr	r3, [r4, #2528]
	strb	r0, [r3, #1]
	ldr	r3, [r4, #2528]
	strb	r2, [r3, #2]
	ldr	r3, [r4, #2528]
	b	.L1192
.L1206:
	mov	r1, r10
	mov	r0, r7
	add	r9, r9, #1
	bl	HEVC_RemoveFrameStoreOutDPB
	cmp	r9, r5
	mov	r6, #1
	bne	.L1196
.L1189:
	mov	r0, r6
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1197:
	mov	r6, r5
	b	.L1189
	.fnend
	.size	HEVC_RemoveUnUsedFrameStore, .-HEVC_RemoveUnUsedFrameStore
	.align	2
	.global	HEVC_SimpleSlideDPB
	.type	HEVC_SimpleSlideDPB, %function
HEVC_SimpleSlideDPB:
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
	ldr	r3, [r0, #2504]
	ldr	r2, [r0, #2508]
	mov	r4, r0
	cmp	r2, r3
	ldmccfd	sp, {r4, r5, fp, sp, pc}
	cmp	r3, #15
	bls	.L1211
.L1212:
	ldr	r3, [r4, #2528]
	mov	r5, #0
	mov	r2, r5
	strb	r5, [r3, #1]
	ldr	r1, [r3, #32]
	ldr	r0, [r4, #244]
	bl	FSP_SetRef
	mov	r1, r5
	mov	r0, r4
	bl	HEVC_RemoveApcStore
	mov	r1, r5
	mov	r0, r4
	bl	HEVC_RemoveFrameStoreOutDPB
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1211:
	bl	HEVC_IncreaseDPBSize
	cmp	r0, #0
	bne	.L1212
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	HEVC_SimpleSlideDPB, .-HEVC_SimpleSlideDPB
	.align	2
	.global	HEVC_GetMinPOC
	.type	HEVC_GetMinPOC, %function
HEVC_GetMinPOC:
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
	mov	r7, r2
	mvn	r3, #-2147483648
	mov	r2, #0
	str	r2, [r7]
	mov	r5, r1
	str	r3, [r1]
	mov	r6, r0
	ldr	r2, [r0, #2508]
	ldr	r3, [r0, #2504]
	cmp	r2, r3
	bhi	.L1221
	cmp	r2, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1222:
	add	lr, r6, #2512
	mov	r3, #0
	add	lr, lr, #12
.L1218:
	ldr	r2, [lr, #4]!
	ldr	r4, [r5]
	ldr	ip, [r2, #12]
	cmp	r4, ip
	strgt	ip, [r5]
	strgt	r3, [r7]
	add	r3, r3, #1
	ldr	ip, [r6, #2508]
	cmp	ip, r3
	bhi	.L1218
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1221:
	ldr	r1, .L1223
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r2, [r6, #2504]
	cmp	r2, #0
	str	r2, [r6, #2508]
	bne	.L1222
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1224:
	.align	2
.L1223:
	.word	.LC100
	.fnend
	.size	HEVC_GetMinPOC, .-HEVC_GetMinPOC
	.align	2
	.global	HEVC_GetReRangeFlag
	.type	HEVC_GetReRangeFlag, %function
HEVC_GetReRangeFlag:
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
	add	r3, r0, #53248
	ldr	r4, [r0, #2320]
	movw	r5, #2024
	ldr	ip, [r3, #996]
	movw	lr, #26164
	ldr	r3, [r0, #2316]
	mla	ip, r5, ip, r4
	ldr	ip, [ip, #32]
	mla	r3, lr, ip, r3
	ldrb	ip, [r3, #2]
	ldr	lr, [r3, #72]
	cmp	ip, #0
	ldr	r3, [r3, #76]
	bne	.L1229
	cmp	r2, r3
	cmpeq	r1, lr
	beq	.L1230
.L1229:
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1230:
	ldr	r3, [r0, #168]
	cmp	r3, #0
	beq	.L1229
	ldr	r3, [r0, #2324]
	ldr	r0, [r3, #880]
	adds	r0, r0, #0
	movne	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	HEVC_GetReRangeFlag, .-HEVC_GetReRangeFlag
	.align	2
	.global	HEVC_CalcStreamBits
	.type	HEVC_CalcStreamBits, %function
HEVC_CalcStreamBits:
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
	ldr	r4, [r0, #2332]
	ldrb	lr, [r4, #1]
	cmp	lr, #0
	beq	.L1242
	mov	r3, #0
	mov	r2, r4
	mov	r1, r3
.L1233:
	add	r3, r3, #1
	ldr	ip, [r2, #48]
	cmp	r3, lr
	add	r2, r2, #28
	add	r1, r1, ip
	bne	.L1233
.L1232:
	ldr	r2, [r0, #2308]
	mov	r3, lr, asl #5
	sub	lr, r3, lr, asl #2
	add	r4, r4, lr
	ldr	r3, [r2, #24]
	and	r3, r3, #7
	str	r3, [r4, #60]
	ldr	r2, [r0, #2332]
	ldr	r3, [r0, #2308]
	ldrb	lr, [r2, #1]
	ldr	ip, [r3, #24]
	mov	r3, lr, asl #5
	cmp	ip, #0
	sub	r3, r3, lr, asl #2
	add	r4, ip, #7
	add	r3, r2, r3
	movlt	ip, r4
	ldr	r2, [r3, #52]
	add	r2, r2, ip, asr #3
	rsb	r2, r1, r2
	str	r2, [r3, #64]
	ldr	ip, [r0, #2332]
	ldr	r3, [r0, #2308]
	ldrb	r2, [ip, #1]
	ldr	lr, [r3, #24]
	mov	r3, r2, asl #5
	sub	r2, r3, r2, asl #2
	add	r2, ip, r2
	ldr	r3, [r2, #48]
	add	r3, r1, r3
	rsb	r3, lr, r3, lsl #3
	str	r3, [r2, #56]
	ldr	r2, [r0, #2332]
	ldrb	r1, [r2, #1]
	mov	r3, r1, asl #5
	sub	r3, r3, r1, asl #2
	add	r3, r2, r3
	ldr	r2, [r3, #64]
	ldr	r1, [r3, #60]
	and	r2, r2, #3
	add	r2, r1, r2, lsl #3
	str	r2, [r3, #60]
	ldr	r2, [r0, #2332]
	ldrb	r1, [r2, #1]
	mov	r3, r1, asl #5
	sub	r3, r3, r1, asl #2
	add	r3, r2, r3
	ldr	r2, [r3, #64]
	bic	r2, r2, #3
	str	r2, [r3, #64]
	ldr	r3, [r0, #2332]
	ldr	r2, [r3, #8]
	sub	ip, r2, #1
	cmp	ip, #1
	bhi	.L1249
	ldrb	r1, [r3, #1]
	add	lr, r1, #1
	cmp	r2, lr
	movhi	r2, #1
	movls	r2, #0
	cmp	lr, #1
	movhi	r2, #0
	cmp	r2, #0
	beq	.L1236
	add	r1, r1, #2
	mov	ip, #0
.L1237:
	sub	r2, r1, #1
	mov	lr, r2, asl #5
	sub	lr, lr, r2, asl #2
	add	r3, r3, lr
	str	ip, [r3, #60]
	ldr	r2, [r0, #2332]
	add	r2, r2, lr
	ldr	r3, [r2, #52]
	str	r3, [r2, #64]
	ldr	r2, [r0, #2332]
	add	r2, r2, lr
	ldr	r3, [r2, #48]
	mov	r3, r3, asl #3
	str	r3, [r2, #56]
	ldr	r3, [r0, #2332]
	add	r3, r3, lr
	ldr	r2, [r3, #64]
	ldr	r4, [r3, #60]
	and	r2, r2, #15
	add	r2, r4, r2, lsl #3
	str	r2, [r3, #60]
	ldr	r2, [r0, #2332]
	add	r3, r2, lr
	ldr	r2, [r3, #64]
	bic	r2, r2, #15
	str	r2, [r3, #64]
	ldr	r3, [r0, #2332]
	ldr	r2, [r3, #8]
	cmp	r1, #1
	cmpls	r1, r2
	add	r1, r1, #1
	movcc	lr, #1
	movcs	lr, #0
	cmp	lr, #0
	bne	.L1237
	sub	ip, r2, #1
.L1236:
	mov	r1, ip, asl #5
	ldr	lr, [r3, #12]
	sub	ip, r1, ip, asl #2
	add	r3, r3, ip
	ldr	r2, [r3, #56]
	rsb	r2, lr, r2
	str	r2, [r3, #56]
	ldr	lr, [r0, #2332]
	ldrb	r1, [lr, #1]
	ldr	r3, [lr, #8]
	cmp	r1, r3
	ldmcsfd	sp, {r4, r5, fp, sp, pc}
	sxth	r3, r1
	add	r0, r0, #53248
	mov	r2, r3, asl #5
	sub	r3, r2, r3, asl #2
	add	r3, lr, r3
.L1240:
	ldr	r2, [r3, #64]
	add	r1, r1, #1
	ldr	ip, [r0, #312]
	add	r3, r3, #28
	cmp	r2, ip
	strcc	r2, [r0, #312]
	ldr	r2, [lr, #8]
	cmp	r2, r1
	bhi	.L1240
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1249:
	ldr	r1, .L1250
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1242:
	mov	r1, lr
	b	.L1232
.L1251:
	.align	2
.L1250:
	.word	.LC101
	.fnend
	.size	HEVC_CalcStreamBits, .-HEVC_CalcStreamBits
	.align	2
	.global	HEVC_VpsSpsPpsCheck
	.type	HEVC_VpsSpsPpsCheck, %function
HEVC_VpsSpsPpsCheck:
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
	add	r2, r0, #53248
	ldr	r3, [r0, #156]
	ldr	r2, [r2, #996]
	cmp	r2, r3
	bge	.L1260
	movw	r3, #2024
	ldr	r1, [r0, #2320]
	mul	r3, r3, r2
	add	ip, r1, r3
	ldrb	r3, [r1, r3]
	cmp	r3, #0
	beq	.L1261
	ldr	r2, [ip, #32]
	ldr	r3, [r0, #152]
	cmp	r2, r3
	bge	.L1262
	ldr	r1, [r0, #2316]
	movw	r3, #26164
	mla	r3, r3, r2, r1
	ldrb	r1, [r3, #1]
	cmp	r1, #0
	beq	.L1263
	ldr	r2, [r3, #52]
	ldr	r3, [r0, #148]
	cmp	r2, r3
	bcs	.L1264
	movw	r3, #23196
	ldr	r1, [r0, #2312]
	mul	r3, r3, r2
	ldrb	r3, [r1, r3]
	cmp	r3, #0
	beq	.L1265
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1260:
	ldr	r1, .L1266
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1261:
	ldr	r1, .L1266+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1262:
	ldr	r1, .L1266+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1263:
	ldr	r1, .L1266+12
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1264:
	ldr	r1, .L1266+16
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1265:
	ldr	r1, .L1266+20
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1267:
	.align	2
.L1266:
	.word	.LC102
	.word	.LC103
	.word	.LC104
	.word	.LC105
	.word	.LC106
	.word	.LC107
	.fnend
	.size	HEVC_VpsSpsPpsCheck, .-HEVC_VpsSpsPpsCheck
	.align	2
	.global	HEVC_IsNewPic
	.type	HEVC_IsNewPic, %function
HEVC_IsNewPic:
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
	ldr	r2, [r0, #2332]
	ldr	r1, [r0, #200]
	ldr	r3, [r2, #16]
	cmn	r1, #-2147483647
	sub	ip, r3, #16
	beq	.L1300
	cmp	r3, #21
	cmpne	ip, #2
	addls	ip, r0, #53248
	ldrls	lr, [ip, #968]
	bls	.L1274
.L1282:
	sub	r3, r3, #19
	add	ip, r0, #53248
	cmp	r3, #1
	movls	r1, #-2147483647
	strls	r1, [r0, #200]
	ldr	lr, [ip, #968]
.L1274:
	cmp	lr, r1
	bge	.L1272
	ldr	r3, [r2, #16]
	sub	r4, r3, #8
	cmp	r4, #1
	bls	.L1301
.L1275:
	ldrb	r1, [r0, #8]
	cmp	r1, #0
	beq	.L1276
	ldr	r4, [r0, #204]
	cmp	lr, r4
	bge	.L1276
	ldr	r3, [r2, #16]
	sub	r5, r3, #8
	cmp	r5, #1
	bls	.L1302
.L1276:
	ldrb	r3, [ip, #923]
	cmp	r3, #0
	bne	.L1277
	ldr	r2, [r2, #16]
	sub	r1, r2, #19
	cmp	r1, #1
	bls	.L1297
	cmp	r2, #21
	beq	.L1297
	sub	r2, r2, #16
	cmp	r2, #2
	strls	lr, [r0, #204]
	movls	r3, #1
	strlsb	r3, [r0, #8]
.L1277:
	ldr	r2, [r0, #216]
	ldrb	r3, [ip, #921]
	cmp	r2, #0
	ldreq	r1, [ip, #996]
	bne	.L1303
	ldr	r2, [r0, #288]
	cmp	r2, r1
	movne	r0, #1
	beq	.L1304
.L1295:
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1300:
	cmp	ip, #5
	bhi	.L1298
	cmp	r3, #21
	cmpne	ip, #2
	bhi	.L1282
	add	ip, r0, #53248
	ldr	lr, [ip, #968]
	str	lr, [r0, #200]
.L1272:
	ldrb	r1, [r0, #3]
	cmp	r1, #0
	beq	.L1275
	ldr	r3, [r2, #16]
	sub	r4, r3, #8
	cmp	r4, #1
	bhi	.L1275
	str	r3, [sp, #8]
	mov	r0, #1
	str	r1, [sp, #4]
	movw	r3, #9989
	str	lr, [sp]
	ldr	r2, .L1305
	ldr	r1, .L1305+4
	bl	dprint_vfmw
	mov	r0, #2
	b	.L1295
.L1303:
	add	r2, r2, #16640
	ldr	r1, [ip, #996]
	add	r2, r2, #177
	add	r2, r0, r2, lsl #2
	ldr	r2, [r2, #4]
	cmp	r1, r2
	ldr	r2, [r0, #288]
	movne	r3, #1
	cmp	r2, r1
	movne	r0, #1
	bne	.L1295
	b	.L1304
.L1302:
	str	r3, [sp, #12]
	mov	r0, #1
	stmia	sp, {r1, lr}
	movw	r3, #9999
	str	r4, [sp, #8]
	ldr	r2, .L1305
	ldr	r1, .L1305+8
	bl	dprint_vfmw
.L1298:
	mov	r0, #2
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1304:
	ldr	r0, [r0, #252]
	cmp	r0, lr
	moveq	r0, r3
	movne	r0, #1
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1301:
	str	r3, [sp, #8]
	mov	r0, #1
	str	r1, [sp, #4]
	movw	r3, #9981
	str	lr, [sp]
	ldr	r2, .L1305
	ldr	r1, .L1305+12
	bl	dprint_vfmw
	mov	r0, #2
	b	.L1295
.L1297:
	str	lr, [r0, #204]
	strb	r3, [r0, #8]
	b	.L1277
.L1306:
	.align	2
.L1305:
	.word	.LANCHOR1+328
	.word	.LC109
	.word	.LC110
	.word	.LC108
	.fnend
	.size	HEVC_IsNewPic, .-HEVC_IsNewPic
	.align	2
	.global	HEVC_ReadByteAlignment
	.type	HEVC_ReadByteAlignment, %function
HEVC_ReadByteAlignment:
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
	mov	r1, #1
	mov	r4, r0
	ldr	r0, [r0, #2308]
	bl	BsGet
	cmp	r0, #0
	beq	.L1312
	ldr	r0, [r4, #2308]
	bl	BsBitsToNextByte
	subs	r1, r0, #0
	beq	.L1311
	ldr	r0, [r4, #2308]
	bl	BsGet
	ldr	r1, .L1313
	mov	r2, r0
	mov	r0, #19
	bl	dprint_vfmw
.L1311:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1312:
	ldr	r1, .L1313+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1314:
	.align	2
.L1313:
	.word	.LC112
	.word	.LC111
	.fnend
	.size	HEVC_ReadByteAlignment, .-HEVC_ReadByteAlignment
	.align	2
	.global	HEVC_GetRapPicFlag
	.type	HEVC_GetRapPicFlag, %function
HEVC_GetRapPicFlag:
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
	add	r0, r0, #53248
	ldr	r0, [r0, #992]
	sub	r0, r0, #16
	cmp	r0, #5
	movhi	r0, #0
	movls	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_GetRapPicFlag, .-HEVC_GetRapPicFlag
	.align	2
	.global	HEVC_GetIdrPicFlag
	.type	HEVC_GetIdrPicFlag, %function
HEVC_GetIdrPicFlag:
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
	add	r0, r0, #53248
	ldr	r0, [r0, #992]
	sub	r0, r0, #19
	cmp	r0, #1
	movhi	r0, #0
	movls	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_GetIdrPicFlag, .-HEVC_GetIdrPicFlag
	.align	2
	.global	HEVC_DecPTL
	.type	HEVC_DecPTL, %function
HEVC_DecPTL:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #116
	sub	sp, sp, #116
	push	{lr}
	bl	__gnu_mcount_nc
	subs	r8, r2, #0
	mov	r5, r1
	mov	r4, r0
	str	r3, [fp, #-152]
	moveq	r1, #8
	bne	.L1356
.L1353:
	ldr	r0, [r4, #2308]
	bl	BsGet
	ldr	r3, [fp, #-152]
	cmp	r3, #0
	str	r0, [r5, #284]
	ble	.L1320
	ldr	r3, [fp, #-152]
	add	r6, r5, #42
	add	r9, r3, #42
	mov	r7, r6
	add	r9, r5, r9
	b	.L1322
.L1321:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	strb	r0, [r7, #1]!
	cmp	r7, r9
	beq	.L1357
.L1322:
	cmp	r8, #0
	beq	.L1321
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	strb	r0, [r7, #-5]
	b	.L1321
.L1357:
	ldr	r3, [fp, #-152]
	cmp	r3, #7
	ldrle	r7, [fp, #-152]
	ble	.L1326
	b	.L1332
.L1325:
	cmp	r7, #8
	beq	.L1332
.L1326:
	mov	r1, #2
	ldr	r0, [r4, #2308]
	bl	BsGet
	add	r7, r7, #1
	cmp	r0, #0
	beq	.L1325
	ldr	r1, .L1358
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1320:
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1332:
	add	r9, r5, #360
	add	r3, r5, #48
	mov	r7, #0
	b	.L1330
.L1329:
	ldr	r3, [fp, #-152]
	add	r7, r7, #1
	add	r9, r9, #4
	cmp	r3, r7
	mov	r3, r5
	ble	.L1320
.L1330:
	cmp	r8, #0
	beq	.L1354
	ldrb	r2, [r6, #-5]
	cmp	r2, #0
	bne	.L1352
.L1354:
	add	r5, r3, #32
.L1327:
	ldrb	r3, [r6, #1]!
	cmp	r3, #0
	beq	.L1329
	mov	r1, #8
	ldr	r0, [r4, #2308]
	bl	BsGet
	str	r0, [r9]
	b	.L1329
.L1352:
	mov	r1, #2
	ldr	r0, [r4, #2308]
	str	r3, [fp, #-156]
	bl	BsGet
	ldr	r3, [fp, #-156]
	mov	r1, #1
	add	r5, r3, #32
	mov	r10, r3
	str	r0, [r9, #-72]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #5
	strb	r0, [r6, #199]
	ldr	r0, [r4, #2308]
	bl	BsGet
	str	r0, [r9, #-48]
.L1328:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	strb	r0, [r10, #1]!
	cmp	r10, r5
	bne	.L1328
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r6, #205]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r6, #211]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r6, #217]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #16
	strb	r0, [r6, #223]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #16
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #12
	ldr	r0, [r4, #2308]
	bl	BsGet
	b	.L1327
.L1356:
	mov	r1, #2
	ldr	r0, [r0, #2308]
	bl	BsGet
	mov	r1, #1
	ldr	r9, .L1358+4
	mov	r7, r5
	mov	r6, #0
	str	r0, [r5, #276]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #5
	strb	r0, [r5]
	ldr	r0, [r4, #2308]
	bl	BsGet
	str	r0, [r5, #272]
.L1319:
	mov	r3, r6
	ldr	ip, [r9, #68]
	ldr	r2, .L1358+8
	mov	r1, #100
	sub	r0, fp, #144
	add	r6, r6, #1
	blx	ip
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	cmp	r6, #32
	strb	r0, [r7, #1]!
	bne	.L1319
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r5, #33]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r5, #34]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r5, #35]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #16
	strb	r0, [r5, #36]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #16
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #12
	ldr	r0, [r4, #2308]
	bl	BsGet
	ldr	r2, [r5, #272]
	add	r3, r4, #81920
	mov	r1, #8
	str	r2, [r3, #2904]
	ldrb	r2, [r5, #2]
	str	r2, [r3, #2908]
	ldrb	r2, [r5, #3]
	str	r2, [r3, #2912]
	b	.L1353
.L1359:
	.align	2
.L1358:
	.word	.LC114
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC113
	.fnend
	.size	HEVC_DecPTL, .-HEVC_DecPTL
	.align	2
	.global	HEVC_SetDefaultScalingList
	.type	HEVC_SetDefaultScalingList, %function
HEVC_SetDefaultScalingList:
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
	ldr	r9, .L1378
	add	r10, r0, #2192
	mov	r6, #0
	add	r3, r0, #2208
	str	r0, [fp, #-52]
	str	r3, [fp, #-48]
.L1361:
	ldr	r3, [r10, #4]!
	cmp	r3, #0
	beq	.L1369
	ldr	r3, [fp, #-52]
	mov	r8, r6, asl #9
	ldr	r7, [fp, #-48]
	sub	r8, r8, r6, asl #7
	add	r5, r3, #580
	mov	r4, #0
.L1367:
	cmp	r6, #0
	add	r0, r5, r8
	mov	r2, #64
	ldr	r3, [r9, #52]
	beq	.L1376
	cmp	r6, #3
	beq	.L1377
	ldr	ip, .L1378+4
	cmp	r4, #2
	ldr	r1, .L1378+8
	movhi	r1, ip
	blx	r3
.L1363:
	mov	r3, #16
	str	r3, [r7, #4]!
	ldr	r3, [r10]
	add	r4, r4, #1
	add	r5, r5, #64
	cmp	r3, r4
	bhi	.L1367
.L1369:
	add	r6, r6, #1
	ldr	r3, [fp, #-48]
	cmp	r6, #4
	add	r3, r3, #24
	str	r3, [fp, #-48]
	bne	.L1361
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1376:
	mov	r2, #16
	ldr	r1, .L1378+12
	mov	r0, r5
	blx	r3
	b	.L1363
.L1377:
	ldr	r0, .L1378+4
	cmp	r4, #0
	ldr	r1, .L1378+8
	mov	r2, #64
	movne	r1, r0
	add	r0, r5, #1152
	blx	r3
	b	.L1363
.L1379:
	.align	2
.L1378:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR1+344
	.word	.LANCHOR4
	.word	.LANCHOR1+408
	.fnend
	.size	HEVC_SetDefaultScalingList, .-HEVC_SetDefaultScalingList
	.align	2
	.global	HEVC_CalScalingList
	.type	HEVC_CalScalingList, %function
HEVC_CalScalingList:
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
	add	lr, r0, r2, lsl #2
	mov	ip, r2, asl #3
	mov	r5, #0
	ldr	r7, [lr, #292]
	sub	r2, ip, r2, asl #1
	add	r3, r3, r2
	cmp	r7, #64
	mov	r6, r3, asl #4
	movcs	r7, #64
	mov	r8, r7, lsr #2
.L1381:
	cmp	r5, r8
	ldmcsfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	cmp	r7, #0
	beq	.L1381
	add	r3, r5, r6
	ldrb	ip, [r1]
	mov	r4, r1
	mov	r2, #0
	add	r3, r0, r3, lsl #2
	ldr	lr, [r3, #580]
	orr	ip, lr, ip
	str	ip, [r3, #580]
.L1387:
	add	r2, r2, #1
	add	r3, r5, r6
	and	lr, r2, #3
	cmp	r2, r7
	add	r3, r0, r3, lsl #2
	mov	ip, lr, asl #3
	beq	.L1381
	ldrb	r9, [r4, #1]!
	cmp	lr, #3
	ldr	lr, [r3, #580]
	addeq	r5, r5, #1
	orr	ip, lr, r9, asl ip
	str	ip, [r3, #580]
	b	.L1387
	.fnend
	.size	HEVC_CalScalingList, .-HEVC_CalScalingList
	.align	2
	.global	HEVC_SetScalingList
	.type	HEVC_SetScalingList, %function
HEVC_SetScalingList:
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
	add	r6, r0, #24576
	mov	r5, r0
	ldr	r3, [r6, #2780]
	ldrb	r2, [r3, #6]
	cmp	r2, #0
	beq	.L1389
	ldrb	r3, [r3, #7]
	cmp	r3, #0
	ldr	r3, [r6, #2784]
	bne	.L1390
	ldrb	r3, [r3, #21]
	cmp	r3, #0
	beq	.L1408
.L1391:
	ldr	r8, .L1409
	mov	r1, #0
	mov	r2, #1536
	add	r0, r5, #580
	add	r10, r5, #2192
	mov	r7, r1
	ldr	r3, [r8, #48]
	blx	r3
.L1393:
	ldr	r3, [r10, #4]!
	cmp	r3, #0
	movne	r9, r7, asl #3
	movne	r4, #0
	subne	r9, r9, r7, asl #1
	beq	.L1397
.L1394:
	add	r0, r9, r4
	ldr	r1, [r6, #2784]
	mov	r3, r4
	mov	r2, r7
	add	r1, r1, r0, lsl #6
	mov	r0, r5
	add	r1, r1, #308
	add	r4, r4, #1
	add	r1, r1, #1
	bl	HEVC_CalScalingList
	ldr	r3, [r10]
	cmp	r4, r3
	bcc	.L1394
.L1397:
	add	r7, r7, #1
	cmp	r7, #4
	bne	.L1393
	ldr	r1, [r6, #2784]
	add	r0, r5, #2208
	add	r0, r0, #4
	ldr	r3, [r8, #52]
	add	r1, r1, #1920
	mov	r2, #96
	add	r1, r1, #8
	blx	r3
.L1389:
	mov	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1390:
	ldrb	r1, [r3, #21]
	cmp	r1, #0
	bne	.L1391
	ldr	r8, .L1409
	mov	r2, #1536
	add	r0, r0, #580
	mov	r7, r1
	add	r10, r5, #2192
	ldr	r3, [r8, #48]
	blx	r3
.L1398:
	ldr	r3, [r10, #4]!
	cmp	r3, #0
	movne	r9, r7, asl #3
	movne	r4, #0
	subne	r9, r9, r7, asl #1
	beq	.L1402
.L1399:
	add	r0, r9, r4
	ldr	r1, [r6, #2780]
	mov	r3, r4
	mov	r2, r7
	add	r1, r1, r0, lsl #6
	mov	r0, r5
	add	r1, r1, #908
	add	r4, r4, #1
	add	r1, r1, #1
	bl	HEVC_CalScalingList
	ldr	r3, [r10]
	cmp	r4, r3
	bcc	.L1399
.L1402:
	add	r7, r7, #1
	cmp	r7, #4
	bne	.L1398
	ldr	r1, [r6, #2780]
	add	r0, r5, #2208
	ldr	r3, [r8, #52]
	mov	r2, #96
	add	r1, r1, #2528
	add	r0, r0, #4
	blx	r3
	mov	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1408:
	bl	HEVC_SetDefaultScalingList
	b	.L1389
.L1410:
	.align	2
.L1409:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	HEVC_SetScalingList, .-HEVC_SetScalingList
	.align	2
	.global	HEVC_GetScalingListDefaultAddress
	.type	HEVC_GetScalingListDefaultAddress, %function
HEVC_GetScalingListDefaultAddress:
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
	cmp	r0, #3
	ldrls	pc, [pc, r0, asl #2]
	b	.L1412
.L1414:
	.word	.L1418
	.word	.L1416
	.word	.L1416
	.word	.L1417
.L1416:
	ldr	r3, .L1422
	cmp	r1, #2
	add	r0, r3, #64
	movhi	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L1418:
	ldr	r0, .L1422+4
	ldmfd	sp, {fp, sp, pc}
.L1417:
	ldr	r3, .L1422
	cmp	r1, #0
	add	r0, r3, #64
	movne	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L1412:
	ldr	r1, .L1422+8
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1423:
	.align	2
.L1422:
	.word	.LANCHOR4+80
	.word	.LANCHOR4+64
	.word	.LC115
	.fnend
	.size	HEVC_GetScalingListDefaultAddress, .-HEVC_GetScalingListDefaultAddress
	.align	2
	.global	HEVC_DecRefPicListsModification
	.type	HEVC_DecRefPicListsModification, %function
HEVC_DecRefPicListsModification:
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
	cmp	r2, #0
	cmpne	r1, #0
	mov	r5, r3
	mov	r7, r1
	moveq	ip, #1
	movne	ip, #0
	cmp	r0, #0
	orreq	ip, ip, #1
	mov	r8, r2
	cmp	ip, #0
	mov	r6, r0
	bne	.L1434
	sub	ip, r3, #1
	mov	r4, #1
	movs	ip, ip, asr #1
	beq	.L1426
.L1427:
	movs	ip, ip, asr #1
	add	r4, r4, #1
	bne	.L1427
.L1426:
	mov	r1, #1
	ldr	r0, [r6, #2308]
	bl	BsGet
	cmp	r5, #1
	movls	r10, #0
	movhi	r10, #1
	uxtb	r0, r0
	strb	r0, [r8]
	cmp	r0, #0
	cmpne	r5, #1
	bls	.L1431
	ldr	r3, [r7, #168]
	cmp	r3, #0
	beq	.L1431
	mov	r9, r8
	mov	r5, #0
.L1432:
	mov	r1, r4
	ldr	r0, [r6, #2308]
	bl	BsGet
	add	r5, r5, #1
	str	r0, [r9, #4]!
	ldr	r3, [r7, #168]
	cmp	r3, r5
	bhi	.L1432
.L1431:
	ldr	r5, [r7, #60]
	cmp	r5, #0
	beq	.L1449
.L1430:
	mov	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1449:
	mov	r1, #1
	ldr	r0, [r6, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r8, #1]
	cmp	r0, #0
	moveq	r10, #0
	andne	r10, r10, #1
	cmp	r10, #0
	beq	.L1430
	ldr	r3, [r7, #172]
	cmp	r3, #0
	beq	.L1430
	add	r8, r8, #128
.L1433:
	mov	r1, r4
	ldr	r0, [r6, #2308]
	bl	BsGet
	add	r5, r5, #1
	str	r0, [r8, #4]!
	ldr	r3, [r7, #172]
	cmp	r3, r5
	bhi	.L1433
	mov	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1434:
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	.fnend
	.size	HEVC_DecRefPicListsModification, .-HEVC_DecRefPicListsModification
	.align	2
	.global	HEVC_MoreRbspData
	.type	HEVC_MoreRbspData, %function
HEVC_MoreRbspData:
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
	ldr	r0, [r0, #2308]
	bl	BsResidBits
	subs	r3, r0, #0
	ble	.L1452
	ldr	r2, [r4, #2332]
	ldr	r0, [r2, #12]
	add	r0, r0, #3
	cmp	r3, r0
	movls	r0, #0
	movhi	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1452:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	HEVC_MoreRbspData, .-HEVC_MoreRbspData
	.align	2
	.global	HEVC_More_Rbsp_Data
	.type	HEVC_More_Rbsp_Data, %function
HEVC_More_Rbsp_Data:
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
	ldr	r0, [r0, #2308]
	ldr	r2, [r0, #16]
	ldr	r3, [r0, #24]
	mov	r2, r2, asl #3
	cmp	r2, r3
	ble	.L1456
	mov	r1, #8
	bl	BsShow
	subs	r0, r0, #128
	movne	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L1456:
	ldr	r1, .L1457
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1458:
	.align	2
.L1457:
	.word	.LC116
	.fnend
	.size	HEVC_More_Rbsp_Data, .-HEVC_More_Rbsp_Data
	.align	2
	.global	HEVC_FindTrailZeros
	.type	HEVC_FindTrailZeros, %function
HEVC_FindTrailZeros:
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
	mov	r1, #0
	mov	r6, r0
.L1471:
	ldr	r3, [r6, #2332]
	ldr	ip, [r3, #8]
	sub	ip, ip, #1
	mov	r0, ip, asl #2
	mov	ip, ip, asl #5
	rsb	r2, r0, ip
	add	r2, r3, r2
	add	r2, r2, #40
	ldr	r3, [r2, #8]
	ldr	r2, [r2, #4]
	sub	r3, r3, #1
	add	r3, r2, r3
.L1460:
	ldrb	r4, [r3]
	rsb	r5, r0, ip
	cmp	r4, #0
	bne	.L1472
	ldr	r2, [r6, #2332]
	add	r1, r1, #1
	add	lr, r2, r5
	ldr	r2, [r2, #44]
	cmp	r2, r3
	beq	.L1473
	ldr	r2, [lr, #44]
	cmp	r2, r3
	sub	r3, r3, #1
	bne	.L1460
	ldr	r1, [lr, #68]
	ldr	r0, [r6, #244]
	bl	SM_ReleaseStreamSeg
	ldr	r3, [r6, #2332]
	mov	r1, r4
	add	r5, r3, r5
	str	r4, [r5, #44]
	ldr	r2, [r6, #2332]
	ldr	r3, [r2, #8]
	sub	r3, r3, #1
	str	r3, [r2, #8]
	b	.L1471
.L1472:
	tst	r4, #1
	mov	r3, #1
	moveq	r2, r3
	bne	.L1467
.L1468:
	ands	r0, r4, r2, asl r3
	add	r3, r3, #1
	bne	.L1467
	cmp	r3, #8
	bne	.L1468
	ldr	r1, .L1474
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1473:
	ldr	r1, .L1474+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1467:
	ldr	ip, [r6, #2332]
	mov	r2, #0
	add	r1, r3, r1, lsl #3
	mov	r0, r2
	str	r2, [ip, #4]
	ldr	r3, [r6, #2332]
	str	r1, [r3, #12]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1475:
	.align	2
.L1474:
	.word	.LC118
	.word	.LC117
	.fnend
	.size	HEVC_FindTrailZeros, .-HEVC_FindTrailZeros
	.align	2
	.global	HEVC_FindNaluArraySlot
	.type	HEVC_FindNaluArraySlot, %function
HEVC_FindNaluArraySlot:
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
	ldr	r5, [r0, #160]
	mov	r8, r0
	ldr	r3, [r0, #140]
	add	r5, r5, #1
	cmp	r5, #0
	ble	.L1477
	mov	r0, r3
	mov	r1, r5
	bl	__aeabi_uidivmod
	add	r2, r8, #65536
	mov	r6, #100
	ldr	r7, [r2, #1736]
	mla	r2, r6, r1, r7
	mov	r3, r1
	ldr	r2, [r2, #36]
	cmp	r2, #0
	beq	.L1478
	mov	r4, #0
	b	.L1479
.L1480:
	bl	__aeabi_uidivmod
	mla	r2, r6, r1, r7
	mov	r3, r1
	ldr	r2, [r2, #36]
	cmp	r2, #0
	beq	.L1478
.L1479:
	add	r4, r4, #1
	mov	r1, r5
	cmp	r4, r5
	add	r0, r3, r4
	bne	.L1480
.L1477:
	mvn	r0, #0
	str	r3, [r8, #140]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1478:
	cmp	r3, r5
	mov	r0, r3
	str	r3, [r8, #140]
	bcs	.L1490
	mov	r3, #100
	mov	r2, #1
	mla	r7, r3, r0, r7
	str	r2, [r7, #36]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1490:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	HEVC_FindNaluArraySlot, .-HEVC_FindNaluArraySlot
	.align	2
	.global	HEVC_ReleaseNAL
	.type	HEVC_ReleaseNAL, %function
HEVC_ReleaseNAL:
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
	subs	r5, r1, #0
	mov	r6, r0
	beq	.L1500
	add	r7, r5, #56
	mov	r4, r5
	mov	r3, #0
	str	r3, [r5, #36]
	str	r3, [r5, #40]
.L1495:
	ldr	r3, [r4, #44]
	mov	r0, r6
	cmp	r3, #0
	beq	.L1494
	ldr	r1, [r4, #68]
	bl	SM_ReleaseStreamSeg
	ldr	ip, [r4, #48]
	ldr	r3, [r4, #44]
	mov	r0, #7
	ldr	r2, .L1501
	ldr	r1, .L1501+4
	str	ip, [sp]
	bl	dprint_vfmw
	mov	r3, #0
	str	r3, [r4, #44]
	str	r3, [r4, #60]
	str	r3, [r4, #48]
.L1494:
	add	r4, r4, #28
	cmp	r4, r7
	bne	.L1495
	ldr	r3, .L1501+8
	mov	r0, r5
	mov	r2, #100
	mov	r1, #0
	ldr	r3, [r3, #48]
	blx	r3
.L1491:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1500:
	mov	r0, r5
	movw	r3, #11281
	ldr	r2, .L1501+12
	ldr	r1, .L1501+16
	bl	dprint_vfmw
	b	.L1491
.L1502:
	.align	2
.L1501:
	.word	.LANCHOR1+424
	.word	.LC119
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC43
	.word	.LC44
	.fnend
	.size	HEVC_ReleaseNAL, .-HEVC_ReleaseNAL
	.align	2
	.global	Hevc_InitDecBuffers
	.type	Hevc_InitDecBuffers, %function
Hevc_InitDecBuffers:
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
	add	r3, r0, #24576
	mov	r7, r0
	add	r0, r0, #2720
	ldr	r3, [r3, #2780]
	add	r1, r7, #2656
	add	r2, r7, #2512
	mov	lr, #0
	add	r1, r1, #4
	add	r2, r2, #12
	ldr	r3, [r3, #236]
	add	ip, r7, #2592
	mov	r6, #17
	add	r3, r3, #1
	cmp	r3, #17
	movhi	r3, #17
	str	r3, [r0, #-216]
	add	r0, r0, #8
	mov	r3, lr
	str	lr, [r7, #2508]
	str	lr, [r7, #2520]
	str	lr, [r7, #2524]
	str	lr, [r7, #2516]
	str	lr, [r7, #2512]
.L1506:
	subs	r6, r6, #1
	str	r3, [r0, #4]!
	str	r3, [ip, #4]!
	str	r3, [r1, #4]!
	str	r3, [r2, #4]!
	bne	.L1506
	add	r4, r7, #67584
	ldr	r10, .L1539
	add	r4, r4, #568
	mov	r8, r6
.L1507:
	ldr	r3, [r10, #48]
	mov	r2, #592
	mov	r0, r4
	mov	r1, #0
	blx	r3
	str	r8, [r4, #156]
	add	r8, r8, #1
	mov	r5, #0
	cmp	r8, #20
	sub	r3, r4, #72
	strb	r5, [r4, #-72]
	mov	r2, #20
	str	r3, [r4, #-4]
	mov	r9, #16
	str	r5, [r4, #-68]
	add	r4, r4, #664
	strb	r5, [r4, #-735]
	str	r5, [r4, #-724]
	strb	r5, [r4, #-734]
	str	r5, [r4, #-688]
	str	r2, [r4, #-712]
	str	r9, [r4, #-708]
	ldr	r3, .L1539
	bne	.L1507
	ldr	r3, [r3, #48]
	mov	r2, #200
	mov	r1, r5
	add	r0, r7, #2800
	blx	r3
	add	r2, r7, #2320
	add	r2, r2, #12
	add	r3, r7, #2400
	mov	r1, r5
	str	r9, [r7, #2800]
	str	r5, [r7, #2804]
.L1508:
	str	r1, [r2, #4]!
	cmp	r2, r3
	mov	r0, #0
	bne	.L1508
	add	r1, r7, #2464
	add	lr, r7, #53248
	add	r1, r1, #4
	mov	ip, r0
	str	r0, [lr, #1080]
.L1509:
	str	ip, [r3, #4]!
	cmp	r3, r1
	mov	r2, #0
	bne	.L1509
	str	r2, [lr, #1084]
	ldr	r1, [r7, #180]
	cmp	r1, r2
	movne	r3, r2
	addne	r2, r7, #2112
	movne	r0, r3
	beq	.L1514
.L1513:
	add	r3, r3, #1
	str	r0, [r2, #4]!
	cmp	r3, r1
	bne	.L1513
.L1514:
	ldr	r3, [r7, #160]
	cmp	r3, #0
	beq	.L1538
	mov	r4, #0
	add	r8, r7, #65536
	mov	r5, r4
.L1519:
	ldr	r3, [r8, #2540]
	add	r3, r3, r6
	ldr	r1, [r3, #24]
	cmp	r1, #0
	beq	.L1515
	ldr	r3, [r7, #2332]
	cmp	r1, r3
	beq	.L1515
	ldr	r0, [r7, #244]
	bl	HEVC_ReleaseNAL
	ldr	r3, [r8, #2540]
	add	r3, r3, r6
	str	r5, [r3, #24]
	ldr	r3, [r7, #208]
	ldr	r2, [r7, #216]
	cmp	r3, #0
	subne	r3, r3, #1
	str	r3, [r7, #208]
	ldr	r3, [r7, #172]
	cmp	r2, #0
	subne	r2, r2, #1
	str	r2, [r7, #216]
	cmp	r3, #2
	subhi	r3, r3, #1
	movls	r3, #2
	str	r3, [r7, #172]
.L1515:
	ldr	r3, [r7, #160]
	add	r4, r4, #1
	add	r6, r6, #28
	cmp	r3, r4
	bhi	.L1519
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1538:
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1540:
	.align	2
.L1539:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	Hevc_InitDecBuffers, .-Hevc_InitDecBuffers
	.align	2
	.global	HEVC_EmptyFrmFromDPB
	.type	HEVC_EmptyFrmFromDPB, %function
HEVC_EmptyFrmFromDPB:
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
	subs	r6, r0, #0
	beq	.L1552
	ldr	r3, [r6, #2508]
	add	r8, r6, #2512
	cmp	r3, #0
	addne	r8, r8, #12
	movne	r3, #0
	movne	ip, #1
	movne	r1, r8
	beq	.L1567
.L1546:
	ldr	r2, [r1, #4]!
	add	r3, r3, #1
	ldrb	r0, [r2, #2]
	cmp	r0, #0
	streqb	ip, [r2, #2]
	ldr	r2, [r6, #2508]
	cmp	r2, r3
	bhi	.L1546
.L1547:
	mov	r4, r6
	mov	r7, #17
	mov	r5, #0
	mov	r3, #-2147483647
	str	r3, [r6, #212]
.L1544:
	ldr	r3, [r8, #4]!
	mov	r2, #1
	cmp	r3, #0
	beq	.L1548
	ldr	r1, [r3, #32]
	ldr	r0, [r6, #244]
	bl	FSP_ClearLogicFs
.L1548:
	ldr	r3, [r4, #2596]
	mov	r2, #1
	cmp	r3, #0
	beq	.L1549
	ldr	r1, [r3, #32]
	ldr	r0, [r6, #244]
	bl	FSP_ClearLogicFs
.L1549:
	ldr	r3, [r4, #2664]
	mov	r2, #1
	cmp	r3, #0
	beq	.L1550
	ldr	r1, [r3, #32]
	ldr	r0, [r6, #244]
	bl	FSP_ClearLogicFs
.L1550:
	ldr	r3, [r4, #2732]
	mov	r2, #1
	cmp	r3, #0
	beq	.L1551
	ldr	r1, [r3, #32]
	ldr	r0, [r6, #244]
	bl	FSP_ClearLogicFs
.L1551:
	subs	r7, r7, #1
	str	r5, [r4, #2732]
	str	r5, [r4, #2664]
	add	r4, r4, #4
	str	r5, [r4, #2592]
	str	r5, [r4, #2524]
	bne	.L1544
	mov	r0, r6
	bl	Hevc_InitDecBuffers
	mov	r0, r7
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1567:
	add	r8, r8, #12
	b	.L1547
.L1552:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	HEVC_EmptyFrmFromDPB, .-HEVC_EmptyFrmFromDPB
	.align	2
	.global	HEVC_CombinePacket
	.type	HEVC_CombinePacket, %function
HEVC_CombinePacket:
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
	ldr	r0, [r0, #2332]
	cmp	r0, #0
	beq	.L1571
	ldr	r3, [r0, #48]
	cmp	r3, #4096
	ldmcsfd	sp, {r4, r5, fp, sp, pc}
	ldr	r1, .L1572
	mov	r0, #7
	bl	dprint_vfmw
	ldr	r3, [r4, #2332]
	ldr	ip, .L1572+4
	mov	r5, #0
	ldr	r2, [r3, #48]
	ldr	r0, [r3, #72]
	ldr	r1, [r3, #44]
	rsb	r0, r2, r0
	ldr	r3, [ip, #52]
	blx	r3
	ldr	r3, [r4, #2332]
	mov	r0, #1
	ldr	r2, [r3, #96]
	ldr	r1, [r3, #68]
	str	r2, [r3, #68]
	ldr	r3, [r4, #2332]
	str	r5, [r3, #60]
	ldr	r3, [r4, #2332]
	ldr	ip, [r3, #48]
	ldr	r2, [r3, #72]
	rsb	r2, ip, r2
	str	r2, [r3, #44]
	ldr	r3, [r4, #2332]
	ldr	ip, [r3, #48]
	ldr	r2, [r3, #80]
	rsb	r2, ip, r2
	str	r2, [r3, #52]
	ldr	r3, [r4, #2332]
	ldr	r2, [r3, #48]
	ldr	ip, [r3, #76]
	add	r2, r2, ip
	str	r2, [r3, #48]
	ldr	r3, [r4, #2332]
	str	r0, [r3, #8]
	ldr	r0, [r4, #244]
	bl	SM_ReleaseStreamSeg
	ldr	r3, [r4, #2332]
	str	r5, [r3, #72]
	ldr	r3, [r4, #2332]
	str	r5, [r3, #88]
	ldr	r3, [r4, #2332]
	str	r5, [r3, #76]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1571:
	ldr	r1, .L1572+8
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1573:
	.align	2
.L1572:
	.word	.LC121
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC120
	.fnend
	.size	HEVC_CombinePacket, .-HEVC_CombinePacket
	.align	2
	.global	HEVC_IsOutDPB
	.type	HEVC_IsOutDPB, %function
HEVC_IsOutDPB:
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
	cmp	r1, #0
	beq	.L1579
	ldr	ip, [r0, #2508]
	cmp	ip, #0
	beq	.L1579
	ldr	r3, [r0, #2528]
	cmp	r3, r1
	beq	.L1581
	add	r0, r0, #2528
	mov	r3, #0
	b	.L1576
.L1577:
	ldr	r2, [r0, #4]!
	cmp	r2, r1
	beq	.L1581
.L1576:
	add	r3, r3, #1
	cmp	r3, ip
	bne	.L1577
.L1579:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L1581:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_IsOutDPB, .-HEVC_IsOutDPB
	.align	2
	.global	HEVC_IsNewPicNal
	.type	HEVC_IsNewPicNal, %function
HEVC_IsNewPicNal:
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
	.size	HEVC_IsNewPicNal, .-HEVC_IsNewPicNal
	.align	2
	.global	HEVC_u_v
	.type	HEVC_u_v, %function
HEVC_u_v:
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
	bl	BsGet
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_u_v, .-HEVC_u_v
	.align	2
	.global	HEVC_f_v
	.type	HEVC_f_v, %function
HEVC_f_v:
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
	bl	BsGet
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_f_v, .-HEVC_f_v
	.align	2
	.global	HEVC_ue_v
	.type	HEVC_ue_v, %function
HEVC_ue_v:
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
	mov	r1, #32
	mov	r5, r0
	bl	BsShow
	bl	ZerosMS_32
	cmp	r0, #31
	bls	.L1588
	movw	r3, #61166
	mov	r2, r0
	movt	r3, 65535
	ldr	r1, .L1589
	mov	r0, #1
	bl	dprint_vfmw
	movw	r0, #61166
	movt	r0, 65535
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1588:
	add	r4, r0, #1
	mov	r1, r0
	mov	r0, r5
	bl	BsSkip
	mov	r1, r4
	mov	r0, r5
	bl	BsShow
	mov	r1, r4
	sub	r4, r0, #1
	mov	r0, r5
	bl	BsSkip
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1590:
	.align	2
.L1589:
	.word	.LC122
	.fnend
	.size	HEVC_ue_v, .-HEVC_ue_v
	.align	2
	.global	HEVC_Sei_Tone_Mapping_Info
	.type	HEVC_Sei_Tone_Mapping_Info, %function
HEVC_Sei_Tone_Mapping_Info:
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
	mov	r4, r1
	mov	r5, r0
	ldr	r1, .L1615
	ldr	r0, [r0, #2308]
	bl	HEVC_ue_v
	mov	r1, #1
	str	r0, [r4, #4]
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4]
	cmp	r0, #0
	beq	.L1592
	ldr	r3, [r4, #16]
.L1593:
	cmp	r3, #4
	ldrls	pc, [pc, r3, asl #2]
	b	.L1610
.L1597:
	.word	.L1596
	.word	.L1598
	.word	.L1599
	.word	.L1600
	.word	.L1601
.L1592:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #8
	strb	r0, [r4, #1]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #8
	str	r0, [r4, #8]
	ldr	r0, [r5, #2308]
	bl	BsGet
	cmp	r0, #8
	str	r0, [r4, #12]
	bhi	.L1613
	mov	r1, #8
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r3, r0
	str	r0, [r4, #16]
	b	.L1593
.L1601:
	mov	r1, #8
	ldr	r0, [r5, #2308]
	bl	BsGet
	cmp	r0, #255
	str	r0, [r4, #36]
	beq	.L1614
.L1609:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #16
	strb	r0, [r4, #2]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #16
	str	r0, [r4, #52]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #32
	str	r0, [r4, #56]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #32
	str	r0, [r4, #60]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #16
	str	r0, [r4, #64]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #16
	str	r0, [r4, #68]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #16
	str	r0, [r4, #72]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #16
	str	r0, [r4, #52]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r3, #0
	str	r0, [r4, #76]
.L1595:
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1596:
	mov	r1, #32
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #32
	str	r0, [r4, #20]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r3, #0
	str	r0, [r4, #24]
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1598:
	mov	r1, #32
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #32
	str	r0, [r4, #28]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r3, #0
	str	r0, [r4, #32]
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1599:
	ldr	r8, [r4, #12]
	mov	r3, #1
	movs	r8, r3, asl r8
	addne	r7, r4, #2128
	movne	r6, #0
	beq	.L1604
.L1603:
	ldr	r1, [r4, #8]
	add	r6, r6, #1
	ldr	r0, [r5, #2308]
	add	r1, r1, #7
	bic	r1, r1, #7
	bl	BsGet
	cmp	r8, r6
	str	r0, [r7, #4]!
	bne	.L1603
.L1604:
	ldr	r1, [r4, #8]
	add	r8, r4, r8, lsl #2
	mov	r3, #0
	mov	r2, #1
	mov	r2, r2, asl r1
	mov	r0, r3
	str	r2, [r8, #2132]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1600:
	mov	r1, #16
	ldr	r0, [r5, #2308]
	bl	BsGet
	cmp	r0, #256
	str	r0, [r4, #80]
	bhi	.L1605
	cmp	r0, #0
	addne	r6, r4, #80
	movne	r7, #0
	beq	.L1610
.L1607:
	ldr	r1, [r4, #8]
	add	r7, r7, #1
	ldr	r0, [r5, #2308]
	add	r1, r1, #7
	bic	r1, r1, #7
	bl	BsGet
	str	r0, [r6, #4]!
	ldr	r1, [r4, #12]
	ldr	r0, [r5, #2308]
	add	r1, r1, #7
	bic	r1, r1, #7
	bl	BsGet
	str	r0, [r6, #1024]
	ldr	r3, [r4, #80]
	cmp	r3, r7
	bhi	.L1607
.L1610:
	mov	r3, #0
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1614:
	mov	r1, #32
	ldr	r0, [r5, #2308]
	bl	BsGet
	str	r0, [r4, #40]
	b	.L1609
.L1613:
	mov	r2, r0
	ldr	r1, .L1615+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r3, #0
	b	.L1595
.L1605:
	ldr	r1, .L1615+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r3, #0
	b	.L1595
.L1616:
	.align	2
.L1615:
	.word	.LC123
	.word	.LC124
	.word	.LC125
	.fnend
	.size	HEVC_Sei_Tone_Mapping_Info, .-HEVC_Sei_Tone_Mapping_Info
	.align	2
	.global	HEVC_Sei_Frame_Packing_Arrangement
	.type	HEVC_Sei_Frame_Packing_Arrangement, %function
HEVC_Sei_Frame_Packing_Arrangement:
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
	mov	r5, r1
	mov	r4, r0
	ldr	r1, .L1626
	ldr	r0, [r0, #2308]
	bl	HEVC_ue_v
	mov	r1, #1
	str	r0, [r5, #12]
	ldr	r0, [r4, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r5]
	cmp	r0, #0
	bne	.L1618
	mov	r1, #7
	ldr	r0, [r4, #2308]
	bl	BsGet
	sub	r3, r0, #3
	str	r0, [r5, #16]
	cmp	r3, #2
	bhi	.L1625
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #6
	strb	r0, [r5, #1]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	str	r0, [r5, #20]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r5, #2]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r5, #3]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r5, #4]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r5, #5]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r5, #6]
	ldr	r0, [r4, #2308]
	bl	BsGet
	ldrb	r3, [r5, #1]
	cmp	r3, #0
	strb	r0, [r5, #7]
	bne	.L1621
	ldr	r3, [r5, #16]
	cmp	r3, #5
	beq	.L1621
	mov	r1, #4
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #4
	str	r0, [r5, #24]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #4
	str	r0, [r5, #28]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #4
	str	r0, [r5, #32]
	ldr	r0, [r4, #2308]
	bl	BsGet
	str	r0, [r5, #36]
.L1621:
	mov	r1, #8
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	str	r0, [r5, #40]
	ldr	r0, [r4, #2308]
	bl	BsGet
	strb	r0, [r5, #8]
.L1618:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	strb	r0, [r5, #9]
	ldr	r0, [r4, #2308]
	bl	BsToNextByte
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1625:
	mov	r2, r0
	ldr	r1, .L1626+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1627:
	.align	2
.L1626:
	.word	.LC126
	.word	.LC127
	.fnend
	.size	HEVC_Sei_Frame_Packing_Arrangement, .-HEVC_Sei_Frame_Packing_Arrangement
	.align	2
	.global	HEVC_Sei_Dec_Unit_Info
	.type	HEVC_Sei_Dec_Unit_Info, %function
HEVC_Sei_Dec_Unit_Info:
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
	mov	r5, r1
	mov	r6, r2
	moveq	r3, #1
	movne	r3, #0
	cmp	r0, #0
	orreq	r3, r3, #1
	mov	r4, r0
	cmp	r3, #0
	bne	.L1633
	ldr	r1, .L1639
	ldr	r0, [r0, #2308]
	bl	HEVC_ue_v
	str	r0, [r5, #4]
	ldrb	r3, [r6, #3]
	cmp	r3, #0
	streq	r3, [r5, #8]
	bne	.L1637
.L1631:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r5]
	cmp	r0, #0
	bne	.L1638
.L1632:
	ldr	r0, [r4, #2308]
	bl	BsToNextByte
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1637:
	ldr	r1, [r6, #8]
	ldr	r0, [r4, #2308]
	add	r1, r1, #1
	bl	BsGet
	str	r0, [r5, #8]
	b	.L1631
.L1638:
	ldr	r1, [r6, #12]
	ldr	r0, [r4, #2308]
	add	r1, r1, #1
	bl	BsGet
	str	r0, [r5, #12]
	b	.L1632
.L1633:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1640:
	.align	2
.L1639:
	.word	.LC128
	.fnend
	.size	HEVC_Sei_Dec_Unit_Info, .-HEVC_Sei_Dec_Unit_Info
	.align	2
	.global	HEVC_Sei_Active_Param_sets
	.type	HEVC_Sei_Active_Param_sets, %function
HEVC_Sei_Active_Param_sets:
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
	mov	r7, r1
	mov	r6, r0
	mov	r1, #4
	ldr	r0, [r0, #2308]
	bl	BsGet
	mov	r1, #1
	str	r0, [r7, #4]
	ldr	r0, [r6, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r7]
	ldr	r0, [r6, #2308]
	bl	BsGet
	ldr	r1, .L1648
	strb	r0, [r7, #1]
	ldr	r0, [r6, #2308]
	bl	HEVC_ue_v
	cmp	r0, #15
	str	r0, [r7, #8]
	bgt	.L1642
	cmp	r0, #0
	addge	r5, r7, #8
	movge	r4, #0
	blt	.L1646
.L1645:
	ldr	r1, .L1648+4
	add	r4, r4, #1
	ldr	r0, [r6, #2308]
	bl	HEVC_ue_v
	str	r0, [r5, #4]!
	ldr	r3, [r7, #8]
	cmp	r3, r4
	bge	.L1645
.L1646:
	ldr	r0, [r6, #2308]
	bl	BsToNextByte
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1642:
	ldr	r1, .L1648+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1649:
	.align	2
.L1648:
	.word	.LC129
	.word	.LC131
	.word	.LC130
	.fnend
	.size	HEVC_Sei_Active_Param_sets, .-HEVC_Sei_Active_Param_sets
	.align	2
	.global	HEVC_Sei_Buf_Period
	.type	HEVC_Sei_Buf_Period, %function
HEVC_Sei_Buf_Period:
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
	add	r4, r0, #24576
	mov	r5, r1
	mov	r6, r0
	mov	r0, #0
	ldr	r1, [r4, #2704]
	mov	r8, r2
	ldr	r3, [r4, #2696]
	str	r0, [r4, #2704]
	str	r1, [r4, #2716]
	add	r3, r3, #1
	ldr	r1, .L1683
	str	r3, [r4, #2696]
	ldr	r0, [r6, #2308]
	bl	HEVC_ue_v
	cmp	r0, #15
	str	r0, [r5, #4]
	bhi	.L1678
	mov	r1, #1
	strb	r1, [r4, #2769]
	ldrb	r3, [r8, #2]
	cmp	r3, #0
	beq	.L1653
	ldrb	r0, [r5]
.L1654:
	cmp	r0, #0
	bne	.L1679
.L1655:
	mov	r1, #1
	ldr	r0, [r6, #2308]
	bl	BsGet
	strb	r0, [r5, #1]
	ldr	r1, [r8, #32]
	ldr	r0, [r6, #2308]
	add	r1, r1, #1
	bl	BsGet
	add	r0, r0, #1
	str	r0, [r5, #16]
	ldr	r2, [r8, #48]
	cmp	r2, #31
	bhi	.L1680
.L1656:
	mov	r4, #0
	cmp	r4, #0
	mov	r9, r5
	mov	r7, #1
	beq	.L1681
.L1657:
	cmp	r4, #1
	beq	.L1682
.L1661:
	cmp	r7, #1
	bhi	.L1660
.L1659:
	add	r4, r4, #1
	add	r7, r7, #1
	cmp	r4, #0
	add	r9, r9, #16
	bne	.L1657
.L1681:
	ldrb	r3, [r8]
	cmp	r3, #0
	beq	.L1661
	ldr	r3, [r8, #48]
	cmn	r3, #1
	movne	r10, r9
	movne	r3, r4
	beq	.L1659
.L1673:
	ldr	r1, [r8, #28]
	add	r3, r3, #1
	ldr	r0, [r6, #2308]
	add	r1, r1, #1
	str	r3, [fp, #-48]
	str	r3, [fp, #-52]
	bl	BsGet
	str	r0, [r10, #20]
	ldr	r1, [r8, #28]
	ldr	r0, [r6, #2308]
	add	r1, r1, #1
	bl	BsGet
	ldr	r3, [fp, #-48]
	str	r0, [r10, #24]
	ldrb	r2, [r8, #2]
	cmp	r2, #0
	bne	.L1663
	ldrb	r2, [r5]
	cmp	r2, #0
	beq	.L1664
.L1663:
	ldr	r1, [r8, #28]
	ldr	r0, [r6, #2308]
	add	r1, r1, #1
	str	r3, [fp, #-48]
	bl	BsGet
	str	r0, [r10, #28]
	ldr	r1, [r8, #28]
	ldr	r0, [r6, #2308]
	add	r1, r1, #1
	bl	BsGet
	ldr	r3, [fp, #-48]
	str	r0, [r10, #32]
.L1664:
	ldr	r2, [r8, #48]
	add	r10, r10, #32
	add	r2, r2, #1
	cmp	r2, r3
	bhi	.L1673
	b	.L1661
.L1660:
	ldr	r0, [r6, #2308]
	bl	BsToNextByte
	mov	r0, #0
.L1677:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1680:
	ldr	r1, .L1683+4
	mov	r0, #1
	bl	dprint_vfmw
	mov	r3, #0
	str	r3, [r8, #48]
	b	.L1656
.L1679:
	ldr	r1, [r8, #32]
	ldr	r0, [r6, #2308]
	add	r1, r1, #1
	bl	BsGet
	str	r0, [r5, #8]
	ldr	r1, [r8, #36]
	ldr	r0, [r6, #2308]
	add	r1, r1, #1
	bl	BsGet
	str	r0, [r5, #12]
	b	.L1655
.L1653:
	ldr	r0, [r6, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r5]
	b	.L1654
.L1678:
	mov	r2, r0
	ldr	r1, .L1683+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1677
.L1682:
	ldrb	r3, [r8, #1]
	cmp	r3, #0
	beq	.L1660
	ldr	r3, [r8, #48]
	cmn	r3, #1
	beq	.L1660
	mov	r10, r9
	mov	r3, #0
	b	.L1673
.L1684:
	.align	2
.L1683:
	.word	.LC132
	.word	.LC134
	.word	.LC133
	.fnend
	.size	HEVC_Sei_Buf_Period, .-HEVC_Sei_Buf_Period
	.align	2
	.global	HEVC_Sei_Pic_Timming
	.type	HEVC_Sei_Pic_Timming, %function
HEVC_Sei_Pic_Timming:
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
	add	r3, r0, #24576
	mov	r5, r2
	mov	r6, r1
	ldr	r2, [r3, #2704]
	mov	r4, r0
	ldr	r1, [r3, #2700]
	add	r2, r2, #1
	str	r2, [r3, #2704]
	add	r1, r1, #1
	str	r1, [r3, #2700]
	ldrb	r3, [r5, #9]
	cmp	r3, #0
	bne	.L1713
.L1686:
	ldrh	r3, [r5, #108]
	cmp	r3, #0
	beq	.L1688
	ldr	r1, [r5, #140]
	ldr	r0, [r4, #2308]
	add	r1, r1, #1
	bl	BsGet
	add	r0, r0, #1
	str	r0, [r6, #12]
	ldr	r1, [r5, #144]
	ldr	r0, [r4, #2308]
	add	r1, r1, #1
	bl	BsGet
	str	r0, [r6, #16]
	ldrb	r3, [r5, #110]
	cmp	r3, #0
	bne	.L1689
.L1692:
	ldr	r2, [r4, #244]
	ldr	r3, .L1716
	ldr	r3, [r3, r2, asl #2]
	ldrsb	r2, [r3, #160]
	cmp	r2, #1
	beq	.L1714
.L1688:
	ldr	r0, [r4, #2308]
	bl	BsToNextByte
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1713:
	mov	r1, #4
	ldr	r0, [r0, #2308]
	bl	BsGet
	mov	r1, #2
	str	r0, [r6, #4]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	str	r0, [r6, #8]
	ldr	r0, [r4, #2308]
	bl	BsGet
	strb	r0, [r6]
	b	.L1686
.L1714:
	ldr	r2, [r3, #168]
	cmp	r2, #0
	bne	.L1688
	ldr	r3, [r3, #172]
	cmp	r3, #1
	bne	.L1688
	mov	r2, r5
	mov	r1, r6
	mov	r0, r4
	bl	HEVC_Sei_Get_Dpb_Output_Time
	b	.L1688
.L1689:
	ldr	r1, [r5, #120]
	ldr	r0, [r4, #2308]
	add	r1, r1, #1
	bl	BsGet
	str	r0, [r6, #20]
	ldrb	r3, [r5, #110]
	cmp	r3, #0
	beq	.L1692
	ldrb	r3, [r5, #111]
	cmp	r3, #0
	beq	.L1692
	ldr	r1, .L1716+4
	ldr	r0, [r4, #2308]
	bl	HEVC_ue_v
	mov	r1, #1
	str	r0, [r6, #24]
	ldr	r0, [r4, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r6, #1]
	cmp	r0, #0
	bne	.L1715
.L1693:
	ldr	r3, [r6, #24]
	cmp	r3, #255
	bhi	.L1697
	add	r8, r6, #28
	mov	r7, #0
	b	.L1696
.L1695:
	ldr	r3, [r6, #24]
	cmp	r3, r7
	bcc	.L1692
.L1696:
	ldr	r1, .L1716+8
	add	r7, r7, #1
	ldr	r0, [r4, #2308]
	bl	HEVC_ue_v
	str	r0, [r8, #4]!
	ldrb	r3, [r6, #1]
	cmp	r3, #0
	bne	.L1695
	ldr	r1, [r5, #116]
	ldr	r0, [r4, #2308]
	add	r1, r1, #1
	bl	BsGet
	str	r0, [r8, #1024]
	b	.L1695
.L1715:
	ldr	r1, [r5, #116]
	ldr	r0, [r4, #2308]
	add	r1, r1, #1
	bl	BsGet
	str	r0, [r6, #28]
	b	.L1693
.L1697:
	ldr	r1, .L1716+12
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1717:
	.align	2
.L1716:
	.word	s_pstVfmwChan
	.word	.LC135
	.word	.LC137
	.word	.LC136
	.fnend
	.size	HEVC_Sei_Pic_Timming, .-HEVC_Sei_Pic_Timming
	.align	2
	.global	HEVC_DecShortTermRefPicSet
	.type	HEVC_DecShortTermRefPicSet, %function
HEVC_DecShortTermRefPicSet:
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
	subs	r7, r3, #0
	mov	r5, r0
	mov	r6, r1
	mov	r4, r2
	streq	r7, [r2]
	bne	.L1760
.L1721:
	ldr	r1, .L1769
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #16
	str	r0, [r4, #16]
	bhi	.L1761
	ldr	r1, .L1769+4
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #16
	str	r0, [r4, #20]
	bhi	.L1762
	ldr	r6, [r4, #16]
	add	r2, r0, r6
	str	r2, [r4, #24]
	cmp	r2, #16
	bhi	.L1746
	cmp	r6, #0
	addne	r10, r4, #68
	addne	r9, r4, #52
	movne	r7, #0
	movne	r8, r7
	bne	.L1750
	b	.L1748
.L1749:
	str	r8, [r10, #4]!
	ldr	r0, [r5, #2308]
	bl	BsGet
	strb	r0, [r9, #1]!
	ldr	r6, [r4, #16]
	cmp	r6, r7
	bls	.L1763
.L1750:
	ldr	r1, .L1769+8
	add	r7, r7, #1
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	mov	r1, #1
	cmp	r0, #32768
	mvn	r3, r0
	add	r8, r8, r3
	bcc	.L1749
	mov	r2, r0
	ldr	r1, .L1769+12
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1760:
	mov	r1, #1
	ldr	r0, [r0, #2308]
	bl	BsGet
	cmp	r0, #0
	str	r0, [r4]
	beq	.L1721
	ldr	r8, [r6, #228]
	cmp	r8, r7
	movne	r0, #0
	strne	r0, [r4, #4]
	beq	.L1764
.L1724:
	sub	r3, r7, #1
	rsb	r7, r0, r3
	cmp	r7, r3
	bhi	.L1765
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	ldr	r1, .L1769+16
	str	r0, [r4, #8]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	mov	r3, #204
	mul	r3, r3, r7
	ldr	r1, [r4, #8]
	mov	r1, r1, asl #1
	add	r9, r6, r3
	rsb	r1, r1, #1
	add	r9, r9, #13120
	add	r9, r9, #8
	add	r0, r0, #1
	str	r0, [r4, #12]
	ldr	r2, [r9, #4]
	mul	r1, r1, r0
	cmp	r2, #16
	str	r1, [fp, #-56]
	bhi	.L1766
	add	r2, r3, #13120
	mov	r10, #0
	add	r2, r2, #60
	add	r8, r4, #35
	add	r6, r6, r2
	str	r10, [fp, #-48]
	str	r10, [fp, #-52]
	mov	r7, r10
	b	.L1733
.L1728:
	sub	r2, r0, #1
	cmp	r2, #1
	bls	.L1767
.L1729:
	strb	r0, [r8, #1]!
	add	r10, r10, #1
	ldr	r2, [r9, #4]
	add	r6, r6, #4
	cmp	r2, r10
	bcc	.L1768
.L1733:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	cmp	r0, #0
	bne	.L1728
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r0, r0, asl #1
	sub	r2, r0, #1
	cmp	r2, #1
	bhi	.L1729
.L1767:
	ldr	r2, [r9, #4]
	add	r1, r7, #18
	ldr	r3, [fp, #-56]
	sub	ip, r0, #1
	cmp	r2, r10
	clz	ip, ip
	ldrhi	r2, [r6]
	movls	r2, #0
	mov	ip, ip, lsr #5
	add	r2, r2, r3
	str	r2, [r4, r1, asl #2]
	cmp	r2, #0
	add	r2, r4, r7
	add	r7, r7, #1
	ldrlt	r3, [fp, #-52]
	ldrge	r3, [fp, #-48]
	addlt	r3, r3, #1
	strb	ip, [r2, #53]
	addge	r3, r3, #1
	strlt	r3, [fp, #-52]
	strge	r3, [fp, #-48]
	b	.L1729
.L1768:
	add	r2, r2, #1
	ldr	r3, [fp, #-52]
	str	r2, [r4, #28]
	cmp	r7, #16
	ldr	r2, [fp, #-48]
	str	r7, [r4, #24]
	str	r3, [r4, #16]
	str	r2, [r4, #20]
	bhi	.L1734
	cmp	r3, #16
	bhi	.L1734
	cmp	r2, #16
	bhi	.L1734
	cmp	r7, #1
	subhi	r7, r7, #1
	addhi	r8, r4, #72
	addhi	r6, r4, #53
	movhi	r5, #0
	bls	.L1740
.L1739:
	ldr	ip, [r8, #4]!
	cmp	r5, #0
	ldrb	lr, [r6, #1]!
	mov	r2, r5
	movge	r1, r8
	movge	r3, r6
	blt	.L1742
.L1738:
	ldr	r0, [r1, #-4]!
	sub	r3, r3, #1
	cmp	ip, r0
	strlt	r0, [r1, #4]
	ldrltb	r0, [r3]
	strltb	r0, [r3, #1]
	strlt	ip, [r1]
	strltb	lr, [r3]
	subs	r2, r2, #1
	bpl	.L1738
.L1742:
	add	r5, r5, #1
	cmp	r5, r7
	bne	.L1739
.L1740:
	ldr	r3, [fp, #-52]
	movs	r6, r3, lsr #1
	beq	.L1737
	ldr	r3, [fp, #-52]
	add	r0, r4, #72
	mov	r1, #0
	add	r2, r3, #17
	add	r3, r3, #52
	add	r3, r4, r3
	add	r2, r4, r2, lsl #2
	add	r4, r4, #53
.L1743:
	ldr	r5, [r2]
	add	r1, r1, #1
	ldr	lr, [r0]
	cmp	r1, r6
	ldrb	ip, [r4]
	str	r5, [r0], #4
	ldrb	r5, [r3]
	strb	r5, [r4], #1
	str	lr, [r2], #-4
	strb	ip, [r3], #-1
	bne	.L1743
.L1737:
	mov	r0, #0
.L1725:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1763:
	ldr	r2, [r4, #24]
.L1748:
	cmp	r2, r6
	bls	.L1737
	add	r8, r6, #17
	add	r9, r6, #52
	add	r9, r4, r9
	mov	r7, #0
	add	r8, r4, r8, lsl #2
.L1751:
	ldr	r1, .L1769+20
	add	r6, r6, #1
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	mov	r1, #1
	add	r0, r0, r1
	add	r7, r7, r0
	str	r7, [r8, #4]!
	ldr	r0, [r5, #2308]
	bl	BsGet
	strb	r0, [r9, #1]!
	ldr	r3, [r4, #24]
	cmp	r3, r6
	bhi	.L1751
	b	.L1737
.L1764:
	ldr	r1, .L1769+24
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	add	r2, r0, #1
	str	r2, [r4, #4]
	cmp	r8, r2
	bcs	.L1724
	mov	r3, r8
	ldr	r1, .L1769+28
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1725
.L1734:
	ldr	r1, .L1769+32
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1725
.L1761:
	mov	r2, r0
	ldr	r1, .L1769+36
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1725
.L1765:
	mov	r2, r7
	ldr	r1, .L1769+40
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1725
.L1766:
	ldr	r1, .L1769+44
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1725
.L1762:
	ldr	r2, [r4, #16]
	mov	r0, #1
	ldr	r1, .L1769+48
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1725
.L1746:
	mov	r3, #16
	ldr	r1, .L1769+52
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1725
.L1770:
	.align	2
.L1769:
	.word	.LC144
	.word	.LC146
	.word	.LC149
	.word	.LC150
	.word	.LC141
	.word	.LC151
	.word	.LC138
	.word	.LC139
	.word	.LC143
	.word	.LC145
	.word	.LC140
	.word	.LC142
	.word	.LC147
	.word	.LC148
	.fnend
	.size	HEVC_DecShortTermRefPicSet, .-HEVC_DecShortTermRefPicSet
	.align	2
	.global	HEVC_DecHrdParam
	.type	HEVC_DecHrdParam, %function
HEVC_DecHrdParam:
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
	cmp	r1, #0
	cmpne	r0, #0
	mov	r7, r3
	mov	r5, r0
	mov	r8, r1
	beq	.L1793
	cmp	r2, #0
	bne	.L1818
.L1776:
	mov	r4, r8
	mov	r6, #0
.L1790:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #40]
	cmp	r0, #0
	movne	r3, #1
	strneb	r3, [r4, #41]
	beq	.L1819
.L1778:
	ldrb	r2, [r4, #41]
	mov	r3, #0
	strb	r3, [r4, #42]
	cmp	r2, r3
	str	r3, [r4, #48]
	beq	.L1779
	ldr	r1, .L1826
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	ldrb	r3, [r4, #42]
	cmp	r3, #0
	str	r0, [r4, #44]
	beq	.L1781
.L1822:
	ldr	r2, [r4, #48]
	cmp	r2, #31
	bhi	.L1820
.L1783:
	mov	r2, r4
	mov	r10, #0
.L1792:
	cmp	r10, #0
	beq	.L1821
	cmp	r10, #1
	beq	.L1816
.L1789:
	add	r10, r10, #1
	add	r2, r2, #4
	cmp	r10, #2
	bne	.L1792
.L1788:
	add	r6, r6, #1
	add	r4, r4, #1280
	cmp	r7, r6
	add	r4, r4, #12
	bcs	.L1790
	mov	r0, #0
.L1815:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1779:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r3, r0
	strb	r3, [r4, #42]
	cmp	r3, #0
	bne	.L1822
.L1781:
	ldr	r1, .L1826+4
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	mov	r2, r0
	cmp	r2, #31
	str	r0, [r4, #48]
	bls	.L1783
.L1820:
	ldr	r1, .L1826+8
	mov	r0, #1
	bl	dprint_vfmw
	mov	r3, #0
	str	r3, [r4, #48]
	b	.L1783
.L1819:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	strb	r0, [r4, #41]
	b	.L1778
.L1818:
	mov	r1, #1
	ldr	r0, [r0, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r8]
	ldr	r0, [r5, #2308]
	bl	BsGet
	strb	r0, [r8, #1]
	ldrh	r3, [r8]
	cmp	r3, #0
	beq	.L1776
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r8, #2]
	cmp	r0, #0
	bne	.L1823
.L1774:
	mov	r1, #4
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #4
	str	r0, [r8, #16]
	ldr	r0, [r5, #2308]
	bl	BsGet
	ldrb	r3, [r8, #2]
	cmp	r3, #0
	str	r0, [r8, #20]
	bne	.L1824
.L1775:
	mov	r1, #5
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #5
	str	r0, [r8, #28]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #5
	str	r0, [r8, #32]
	ldr	r0, [r5, #2308]
	bl	BsGet
	str	r0, [r8, #36]
	b	.L1776
.L1793:
	mvn	r0, #0
	b	.L1815
.L1824:
	mov	r1, #4
	ldr	r0, [r5, #2308]
	bl	BsGet
	str	r0, [r8, #24]
	b	.L1775
.L1823:
	mov	r1, #8
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #5
	str	r0, [r8, #4]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	str	r0, [r8, #8]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #5
	strb	r0, [r8, #3]
	ldr	r0, [r5, #2308]
	bl	BsGet
	str	r0, [r8, #36]
	b	.L1774
.L1821:
	ldrb	r1, [r8]
	cmp	r1, #0
	beq	.L1825
	mov	r9, r2
	str	r10, [fp, #-48]
	b	.L1806
.L1791:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	str	r2, [fp, #-52]
	bl	BsGet
	ldr	r3, [fp, #-48]
	add	r9, r9, #8
	ldr	r2, [fp, #-52]
	str	r0, [r9, #1068]
	ldr	r1, [r4, #48]
	cmp	r1, r3
	bcc	.L1789
.L1806:
	ldr	r3, [fp, #-48]
	ldr	r1, .L1826+12
	ldr	r0, [r5, #2308]
	add	r3, r3, #1
	str	r2, [fp, #-52]
	str	r3, [fp, #-48]
	bl	HEVC_ue_v
	ldr	r1, .L1826+16
	str	r0, [r9, #52]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	ldr	r2, [fp, #-52]
	str	r0, [r9, #308]
	ldrb	r1, [r8, #2]
	cmp	r1, #0
	beq	.L1791
	ldr	r1, .L1826+20
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	ldr	r1, .L1826+24
	str	r0, [r9, #564]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	ldr	r2, [fp, #-52]
	str	r0, [r9, #820]
	b	.L1791
.L1825:
	add	r2, r2, #4
	mov	r10, #1
.L1816:
	ldrb	r1, [r8, #1]
	cmp	r1, #0
	beq	.L1788
	mov	r3, #0
	mov	r9, r2
	str	r3, [fp, #-48]
	b	.L1806
.L1827:
	.align	2
.L1826:
	.word	.LC152
	.word	.LC153
	.word	.LC154
	.word	.LC155
	.word	.LC156
	.word	.LC157
	.word	.LC158
	.fnend
	.size	HEVC_DecHrdParam, .-HEVC_DecHrdParam
	.align	2
	.global	HEVC_ProcessVPS
	.type	HEVC_ProcessVPS, %function
HEVC_ProcessVPS:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #124
	sub	sp, sp, #124
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r6, r1
	mov	r7, r0
	mov	r1, #2
	ldr	r0, [r0, #2308]
	bl	BsGet
	cmp	r0, #3
	str	r0, [r6, #12]
	beq	.L1829
	mov	r2, r0
	ldr	r1, .L1881
	mov	r0, #1
	bl	dprint_vfmw
.L1829:
	mov	r1, #6
	ldr	r0, [r7, #2308]
	bl	BsGet
	cmp	r0, #63
	str	r0, [r6, #16]
	bhi	.L1873
	mov	r1, #3
	ldr	r0, [r7, #2308]
	bl	BsGet
	cmp	r0, #7
	str	r0, [fp, #-152]
	bhi	.L1874
	ldr	r3, [fp, #-152]
	mov	r1, #1
	add	r5, r3, #1
	str	r5, [r6, #20]
	ldr	r0, [r7, #2308]
	bl	BsGet
	mov	r1, #16
	strb	r0, [r6, #1]
	ldr	r0, [r7, #2308]
	bl	BsGet
	movw	r3, #65535
	cmp	r0, r3
	str	r0, [r6, #24]
	bne	.L1875
	add	r1, r6, #12416
	ldr	r3, [fp, #-152]
	add	r1, r1, #20
	mov	r2, #1
	mov	r0, r7
	bl	HEVC_DecPTL
	subs	r4, r0, #0
	bne	.L1876
	mov	r1, #1
	ldr	r0, [r7, #2308]
	bl	BsGet
	ldr	r3, [fp, #-152]
	cmp	r3, #0
	addge	r8, r6, #48
	strb	r0, [r6, #7]
	bge	.L1841
	b	.L1839
.L1838:
	add	r4, r4, #1
	cmp	r4, r5
	beq	.L1839
.L1841:
	ldr	r1, .L1881+4
	ldr	r0, [r7, #2308]
	bl	HEVC_ue_v
	ldr	r1, .L1881+8
	add	r0, r0, #1
	str	r0, [r8, #4]!
	ldr	r0, [r7, #2308]
	bl	HEVC_ue_v
	ldr	r1, .L1881+12
	str	r0, [r8, #32]
	ldr	r0, [r7, #2308]
	bl	HEVC_ue_v
	str	r0, [r8, #64]
	ldrb	r3, [r6, #7]
	cmp	r3, #0
	bne	.L1838
	ldr	r3, [fp, #-152]
	add	r2, r4, #1
	cmp	r3, r2
	blt	.L1839
	add	r3, r4, #13
	add	r3, r6, r3, lsl #2
.L1840:
	ldr	r1, [r6, #52]
	add	r2, r2, #1
	cmp	r2, r5
	str	r1, [r3, #4]!
	ldr	r1, [r6, #84]
	str	r1, [r3, #32]
	ldr	r1, [r6, #116]
	str	r1, [r3, #64]
	bne	.L1840
.L1839:
	mov	r1, #6
	ldr	r0, [r7, #2308]
	bl	BsGet
	ldr	r1, .L1881+16
	str	r0, [r6, #28]
	ldr	r0, [r7, #2308]
	bl	HEVC_ue_v
	cmp	r0, #1024
	str	r0, [r6, #32]
	bhi	.L1877
	cmp	r0, #1
	ble	.L1842
	ldr	r10, .L1881+20
	add	r9, r6, #148
	mov	r8, #1
.L1843:
	ldr	r3, [r6, #28]
	cmp	r3, #0
	movgt	r5, r9
	movgt	r4, #0
	ble	.L1845
.L1844:
	ldr	r2, .L1881+24
	mov	r3, r8
	str	r4, [sp]
	mov	r1, #100
	ldr	ip, [r10, #68]
	sub	r0, fp, #144
	blx	ip
	mov	r1, #1
	ldr	r0, [r7, #2308]
	add	r4, r4, r1
	bl	BsGet
	str	r0, [r5, #4]!
	ldr	r2, [r6, #28]
	cmp	r2, r4
	bgt	.L1844
.L1845:
	ldr	r3, [r6, #32]
	add	r8, r8, #1
	add	r9, r9, #4
	cmp	r3, r8
	bgt	.L1843
.L1842:
	mov	r1, #1
	ldr	r0, [r7, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r6, #6]
	cmp	r0, #0
	beq	.L1851
	mov	r1, #32
	ldr	r0, [r7, #2308]
	bl	BsGet
	mov	r1, #32
	str	r0, [r6, #36]
	ldr	r0, [r7, #2308]
	bl	BsGet
	mov	r1, #1
	str	r0, [r6, #40]
	ldr	r0, [r7, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r6, #5]
	cmp	r0, #0
	bne	.L1878
.L1849:
	ldr	r1, .L1881+28
	ldr	r0, [r7, #2308]
	bl	HEVC_ue_v
	cmp	r0, #1024
	str	r0, [r6, #48]
	bcs	.L1879
	cmp	r0, #0
	ble	.L1851
	add	r9, r6, #8192
	mov	r3, #1
	ldr	r1, .L1881+32
	add	r8, r6, #12800
	str	r3, [r9, #148]
	add	r5, r6, #4224
	ldr	r0, [r7, #2308]
	add	r8, r8, #20
	bl	HEVC_ue_v
	add	r3, r6, #4096
	add	r5, r5, #24
	mov	r4, #0
	str	r0, [r3, #148]
	ldr	r0, [r9, #148]
	ldr	r9, [fp, #-152]
.L1852:
	uxtb	r2, r0
	mov	r1, r8
	mov	r3, r9
	mov	r0, r7
	bl	HEVC_DecHrdParam
	add	r4, r4, #1
	ldr	r1, .L1881+32
	cmp	r0, #0
	bne	.L1880
	ldr	r3, [r6, #48]
	cmp	r3, r4
	ble	.L1851
	ldr	r0, [r7, #2308]
	bl	HEVC_ue_v
	cmp	r4, #0
	mov	r1, #1
	str	r0, [r5], #4
	ldrle	r0, [r5, #4092]
	ble	.L1852
	ldr	r0, [r7, #2308]
	bl	BsGet
	str	r0, [r5, #4092]
	b	.L1852
.L1851:
	mov	r1, #1
	ldr	r0, [r7, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r6, #3]
	cmp	r0, #0
	bne	.L1868
.L1848:
	mov	r0, #0
.L1831:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1857:
	ldr	r0, [r7, #2308]
	bl	BsGet
	strb	r0, [r6, #4]
.L1868:
	mov	r0, r7
	bl	HEVC_MoreRbspData
	mov	r1, #1
	cmp	r0, #0
	bne	.L1857
	b	.L1848
.L1880:
	ldr	r1, .L1881+36
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1878:
	ldr	r1, .L1881+40
	ldr	r0, [r7, #2308]
	bl	HEVC_ue_v
	str	r0, [r6, #44]
	b	.L1849
.L1875:
	ldr	r1, .L1881+44
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1831
.L1873:
	ldr	r1, .L1881+48
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1831
.L1876:
	ldr	r1, .L1881+52
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1831
.L1874:
	mov	r2, r0
	ldr	r1, .L1881+56
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1831
.L1877:
	mov	r2, r0
	mov	r3, #1024
	ldr	r1, .L1881+60
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1831
.L1879:
	mov	r2, r0
	mov	r3, #1024
	ldr	r1, .L1881+64
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1831
.L1882:
	.align	2
.L1881:
	.word	.LC159
	.word	.LC165
	.word	.LC166
	.word	.LC167
	.word	.LC164
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC169
	.word	.LC171
	.word	.LC173
	.word	.LC174
	.word	.LC170
	.word	.LC162
	.word	.LC160
	.word	.LC163
	.word	.LC161
	.word	.LC168
	.word	.LC172
	.fnend
	.size	HEVC_ProcessVPS, .-HEVC_ProcessVPS
	.align	2
	.global	HEVC_DecVPS
	.type	HEVC_DecVPS, %function
HEVC_DecVPS:
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
	mov	r1, #4
	mov	r4, r0
	ldr	r0, [r0, #2308]
	bl	BsGet
	cmp	r0, #15
	mov	r6, r0
	bhi	.L1889
	movw	r7, #23196
	ldr	r3, [r4, #2312]
	mul	r5, r7, r0
	add	r2, r3, r5
	ldrb	r9, [r3, r5]
	cmp	r9, #0
	bne	.L1890
	str	r0, [r2, #8]
	mov	r0, r4
	ldr	r1, [r4, #2312]
	add	r1, r1, r5
	bl	HEVC_ProcessVPS
	subs	r8, r0, #0
	bne	.L1891
	ldr	r3, [r4, #2312]
	mov	r2, #1
	add	r3, r3, r5
	strb	r2, [r3, #2]
	ldr	r3, [r4, #2312]
	strb	r2, [r3, r5]
.L1885:
	mov	r0, r8
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1890:
	ldr	r9, .L1893
	mov	r0, r4
	ldr	r1, .L1893+4
	str	r6, [r9, #-3456]
	bl	HEVC_ProcessVPS
	subs	r8, r0, #0
	bne	.L1892
	ldr	ip, .L1893+8
	mov	r3, #1
	ldr	r0, [r4, #2312]
	mov	r2, r7
	ldr	r1, .L1893+4
	add	r0, r0, r5
	ldr	ip, [ip, #56]
	strb	r3, [r9, #-3462]
	strb	r3, [r9, #-3464]
	blx	ip
	mov	r0, r8
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1892:
	mov	r2, r6
	ldr	r1, .L1893+12
	mov	r0, #1
	mvn	r8, #0
	bl	dprint_vfmw
	b	.L1885
.L1889:
	ldr	r1, .L1893+16
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1885
.L1891:
	mov	r2, r6
	ldr	r1, .L1893+20
	mov	r0, #1
	mvn	r8, #0
	bl	dprint_vfmw
	ldr	r3, [r4, #2312]
	mov	r2, #1
	add	r3, r3, r5
	strb	r2, [r3, #2]
	ldr	r3, [r4, #2312]
	strb	r9, [r3, r5]
	b	.L1885
.L1894:
	.align	2
.L1893:
	.word	.LANCHOR5
	.word	.LANCHOR5-3464
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC176
	.word	.LC175
	.word	.LC177
	.fnend
	.size	HEVC_DecVPS, .-HEVC_DecVPS
	.align	2
	.global	HEVC_DecVuiParam
	.type	HEVC_DecVuiParam, %function
HEVC_DecVuiParam:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #36
	sub	sp, sp, #36
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r3, .L1944
	mov	r5, r0
	mov	r4, r1
	mov	r6, r2
	add	ip, r3, #16
	sub	lr, fp, #60
	ldmia	r3, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	sub	ip, fp, #28
	stmdb	ip, {r0, r1, r2, r3}
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4]
	cmp	r0, #0
	bne	.L1935
.L1897:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #1]
	cmp	r0, #0
	bne	.L1936
.L1899:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #3]
	cmp	r0, #0
	bne	.L1937
.L1901:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #6]
	cmp	r0, #0
	bne	.L1938
.L1903:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #7]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #8]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #9]
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #10]
	cmp	r0, #0
	beq	.L1904
	ldr	r1, .L1944+4
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	str	r0, [r4, #60]
	ldr	r3, [r6, #64]
	cmp	r3, #3
	bhi	.L1939
	sub	r2, fp, #28
	ldr	r1, .L1944+8
	add	r3, r2, r3, lsl #2
	ldr	r3, [r3, #-32]
	mul	r0, r3, r0
	str	r0, [r4, #60]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	sub	r2, fp, #28
	ldr	r1, .L1944+12
	str	r0, [r4, #64]
	ldr	r3, [r6, #64]
	add	r3, r2, r3, lsl #2
	ldr	r3, [r3, #-32]
	mul	r0, r3, r0
	str	r0, [r4, #64]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	sub	r2, fp, #28
	ldr	r1, .L1944+16
	str	r0, [r4, #68]
	ldr	r3, [r6, #64]
	add	r3, r2, r3, lsl #2
	ldr	r3, [r3, #-16]
	mul	r0, r3, r0
	str	r0, [r4, #68]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	sub	r2, fp, #28
	str	r0, [r4, #72]
	ldr	r3, [r6, #64]
	add	r3, r2, r3, lsl #2
	ldr	r3, [r3, #-16]
	mul	r0, r3, r0
	str	r0, [r4, #72]
.L1904:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #11]
	cmp	r0, #0
	beq	.L1907
	mov	r1, #32
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #32
	str	r0, [r4, #76]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	str	r0, [r4, #80]
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #12]
	cmp	r0, #0
	bne	.L1940
.L1908:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #13]
	cmp	r0, #0
	bne	.L1941
.L1907:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #14]
	cmp	r0, #0
	moveq	r3, r0
	bne	.L1942
.L1906:
	mov	r0, r3
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L1942:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #15]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #16]
	ldr	r0, [r5, #2308]
	bl	BsGet
	ldr	r1, .L1944+20
	strb	r0, [r4, #17]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #4096
	str	r0, [r4, #88]
	bcs	.L1943
.L1909:
	ldr	r1, .L1944+24
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	ldr	r1, .L1944+28
	str	r0, [r4, #92]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	ldr	r1, .L1944+32
	str	r0, [r4, #96]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	ldr	r1, .L1944+36
	str	r0, [r4, #100]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	mov	r3, #0
	str	r0, [r4, #104]
	mov	r0, r3
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L1938:
	ldr	r1, .L1944+40
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	ldr	r1, .L1944+44
	str	r0, [r4, #52]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	str	r0, [r4, #56]
	b	.L1903
.L1935:
	mov	r1, #8
	ldr	r0, [r5, #2308]
	bl	BsGet
	cmp	r0, #255
	str	r0, [r4, #24]
	bne	.L1897
	mov	r1, #16
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #16
	str	r0, [r4, #28]
	ldr	r0, [r5, #2308]
	bl	BsGet
	str	r0, [r4, #32]
	b	.L1897
.L1937:
	mov	r1, #3
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	str	r0, [r4, #36]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #4]
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #5]
	cmp	r0, #0
	beq	.L1901
	mov	r1, #8
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #8
	str	r0, [r4, #40]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #8
	str	r0, [r4, #44]
	ldr	r0, [r5, #2308]
	bl	BsGet
	str	r0, [r4, #48]
	b	.L1901
.L1936:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	strb	r0, [r4, #2]
	b	.L1899
.L1941:
	ldr	r3, [r6, #56]
	mov	r2, #1
	add	r1, r4, #108
	mov	r0, r5
	bl	HEVC_DecHrdParam
	cmp	r0, #0
	beq	.L1907
	ldr	r1, .L1944+48
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r3, #0
	b	.L1906
.L1940:
	ldr	r1, .L1944+52
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	str	r0, [r4, #84]
	b	.L1908
.L1943:
	ldr	r1, .L1944+56
	mov	r0, #1
	bl	dprint_vfmw
	b	.L1909
.L1939:
	ldr	r1, .L1944+60
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r3, #0
	b	.L1906
.L1945:
	.align	2
.L1944:
	.word	.LANCHOR1+440
	.word	.LC180
	.word	.LC182
	.word	.LC183
	.word	.LC184
	.word	.LC187
	.word	.LC189
	.word	.LC190
	.word	.LC191
	.word	.LC192
	.word	.LC178
	.word	.LC179
	.word	.LC186
	.word	.LC185
	.word	.LC188
	.word	.LC181
	.fnend
	.size	HEVC_DecVuiParam, .-HEVC_DecVuiParam
	.align	2
	.global	HEVC_se_v
	.type	HEVC_se_v, %function
HEVC_se_v:
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
	mov	r1, #32
	mov	r5, r0
	bl	BsShow
	bl	ZerosMS_32
	cmp	r0, #31
	bls	.L1951
	mvn	r0, #-2147483648
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1951:
	add	r6, r0, #1
	mov	r1, r0
	mov	r0, r5
	bl	BsSkip
	mov	r1, r6
	mov	r0, r5
	bl	BsShow
	mov	r1, r6
	sub	r0, r0, #1
	tst	r0, #1
	mov	r3, r0, asr #1
	mov	r0, r5
	addne	r4, r3, #1
	rsbeq	r4, r3, #0
	bl	BsSkip
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	HEVC_se_v, .-HEVC_se_v
	.align	2
	.global	HEVC_Sei_Structure_Of_Pictures_Info
	.type	HEVC_Sei_Structure_Of_Pictures_Info, %function
HEVC_Sei_Structure_Of_Pictures_Info:
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
	mov	r9, r1
	mov	r5, r0
	ldr	r1, .L1964
	ldr	r0, [r0, #2308]
	bl	HEVC_ue_v
	ldr	r1, .L1964+4
	str	r0, [r9]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #1024
	str	r0, [r9, #4]
	bhi	.L1953
	cmp	r0, #0
	beq	.L1959
	add	r7, r9, #4096
	add	r8, r9, #12288
	add	r7, r7, #8
	add	r8, r8, #8
	add	r6, r9, #4
	mov	r4, #0
	b	.L1958
.L1957:
	ldr	r3, [r9, #4]
	add	r8, r8, #4
	cmp	r3, r4
	bls	.L1959
.L1958:
	mov	r1, #6
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #3
	str	r0, [r6, #4]!
	ldr	r0, [r5, #2308]
	bl	BsGet
	ldr	r1, .L1964+8
	str	r0, [r7], #4
	ldr	r3, [r6]
	sub	r3, r3, #19
	cmp	r3, #1
	bls	.L1956
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	str	r0, [r7, #4092]
.L1956:
	cmp	r4, #0
	add	r4, r4, #1
	beq	.L1957
	ldr	r1, .L1964+12
	add	r8, r8, #4
	ldr	r0, [r5, #2308]
	bl	HEVC_se_v
	str	r0, [r8, #-4]
	ldr	r3, [r9, #4]
	cmp	r3, r4
	bhi	.L1958
.L1959:
	ldr	r0, [r5, #2308]
	bl	BsToNextByte
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1953:
	ldr	r1, .L1964+16
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1965:
	.align	2
.L1964:
	.word	.LC193
	.word	.LC194
	.word	.LC196
	.word	.LC197
	.word	.LC195
	.fnend
	.size	HEVC_Sei_Structure_Of_Pictures_Info, .-HEVC_Sei_Structure_Of_Pictures_Info
	.align	2
	.global	HEVC_Sei_Recovery_Point
	.type	HEVC_Sei_Recovery_Point, %function
HEVC_Sei_Recovery_Point:
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
	cmp	r1, #0
	cmpne	r0, #0
	mov	r4, r0
	mov	r6, r1
	moveq	r5, #1
	movne	r5, #0
	beq	.L1968
	ldr	r1, .L1969
	ldr	r0, [r0, #2308]
	bl	HEVC_se_v
	mov	r1, #1
	str	r0, [r6, #4]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r6]
	ldr	r0, [r4, #2308]
	bl	BsGet
	strb	r0, [r6, #1]
	ldr	r0, [r4, #2308]
	bl	BsToNextByte
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1968:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1970:
	.align	2
.L1969:
	.word	.LC198
	.fnend
	.size	HEVC_Sei_Recovery_Point, .-HEVC_Sei_Recovery_Point
	.align	2
	.global	HEVC_Sei_Payload
	.type	HEVC_Sei_Payload, %function
HEVC_Sei_Payload:
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
	mov	r6, r1
	ldr	r1, [r0, #2332]
	mov	r4, r0
	ldr	r7, [fp, #4]
	ldr	r1, [r1, #16]
	cmp	r1, #39
	beq	.L2013
	cmp	r3, #5
	beq	.L1997
	cmp	r3, #132
	beq	.L1998
	cmp	r7, #0
	movne	r5, #0
	beq	.L1992
.L2000:
	add	r5, r5, #1
	mov	r1, #8
	ldr	r0, [r4, #2308]
	bl	BsGet
	cmp	r5, r7
	bne	.L2000
	b	.L1992
.L1997:
	mov	r2, r7
	add	r1, r6, #3200
	bl	HEVC_Sei_User_Data_Unregistered
	cmp	r0, #0
	bne	.L1994
.L1992:
	mov	r1, r7
	mov	r0, r4
	bl	HEVC_Sei_More_Data_In_Payload
	cmp	r0, #0
	bne	.L2014
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2014:
	mov	r1, r7
	mov	r0, r4
	bl	HEVC_Sei_Payload_Extension_Present
	cmp	r0, #0
	bne	.L2015
.L2001:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	str	r0, [r6, #12]
	b	.L2002
.L2003:
	ldr	r0, [r4, #2308]
	bl	BsGet
	str	r0, [r6, #16]
.L2002:
	ldr	r0, [r4, #2308]
	bl	BsIsByteAligned
	mov	r1, #1
	cmp	r0, #0
	beq	.L2003
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2013:
	cmp	r3, #137
	ldrls	pc, [pc, r3, asl #2]
	b	.L1973
.L1975:
	.word	.L1974
	.word	.L1976
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1977
	.word	.L1978
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1979
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1980
	.word	.L1973
	.word	.L1981
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1973
	.word	.L1982
	.word	.L1983
	.word	.L1984
	.word	.L1985
	.word	.L1973
	.word	.L1986
	.word	.L1987
	.word	.L1973
	.word	.L1973
	.word	.L1988
.L1998:
	add	r1, r6, #23552
	add	r1, r1, #216
	bl	HEVC_Sei_Decoded_Picture_Hash
	cmp	r0, #0
	beq	.L1992
	b	.L1994
.L2015:
	ldr	r1, .L2016
	ldr	r0, [r4, #2308]
	bl	HEVC_ue_v
	str	r0, [r6, #8]
	b	.L2001
.L1988:
	add	r1, r6, #3376
	add	r1, r1, #12
	bl	HEVC_Sei_Mastering_Display_Colour_Volume
	cmp	r0, #0
	beq	.L1992
.L1994:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1974:
	add	r2, r2, #2720
	add	r1, r6, #24
	add	r2, r2, #12
	bl	HEVC_Sei_Buf_Period
	cmp	r0, #0
	beq	.L1992
	b	.L1994
.L1976:
	add	r2, r2, #2624
	add	r1, r6, #1088
	bl	HEVC_Sei_Pic_Timming
	cmp	r0, #0
	beq	.L1992
	b	.L1994
.L1977:
	mov	r2, r7
	add	r1, r6, #3200
	bl	HEVC_Sei_User_Data_Unregistered
	cmp	r0, #0
	beq	.L1992
	b	.L1994
.L1978:
	add	r1, r6, #3312
	add	r1, r1, #4
	bl	HEVC_Sei_Recovery_Point
	cmp	r0, #0
	beq	.L1992
	b	.L1994
.L1979:
	add	r1, r6, #3424
	add	r1, r1, #4
	bl	HEVC_Sei_Tone_Mapping_Info
	cmp	r0, #0
	beq	.L1992
	b	.L1994
.L1980:
	add	r1, r6, #3312
	add	r1, r1, #12
	bl	HEVC_Sei_Frame_Packing_Arrangement
	cmp	r0, #0
	beq	.L1992
	b	.L1994
.L1981:
	add	r1, r6, #3360
	add	r1, r1, #8
	bl	HEVC_Sei_Display_Orientation
	cmp	r0, #0
	beq	.L1992
	b	.L1994
.L1982:
	add	r1, r6, #6528
	mov	r2, r7
	add	r1, r1, #60
	bl	HEVC_Sei_Structure_Of_Pictures_Info
	cmp	r0, #0
	beq	.L1992
	b	.L1994
.L1983:
	add	r1, r6, #3216
	add	r1, r1, #8
	bl	HEVC_Sei_Active_Param_sets
	cmp	r0, #0
	beq	.L1992
	b	.L1994
.L1984:
	add	r2, r2, #2720
	add	r1, r6, #3296
	add	r2, r2, #12
	add	r1, r1, #4
	bl	HEVC_Sei_Dec_Unit_Info
	cmp	r0, #0
	beq	.L1992
	b	.L1994
.L1985:
	add	r1, r6, #3376
	bl	HEVC_Sei_Temporal_Sub_Layer_Zero_Index
	cmp	r0, #0
	beq	.L1992
	b	.L1994
.L1986:
	mov	r3, r7
	mov	r1, r6
	bl	HEVC_Sei_Scalable_Nesting
	cmp	r0, #0
	beq	.L1992
	b	.L1994
.L1987:
	add	r1, r6, #3376
	add	r1, r1, #8
	bl	HEVC_Sei_Region_Refresh_Info
	cmp	r0, #0
	beq	.L1992
	b	.L1994
.L1973:
	cmp	r7, #0
	movne	r5, #0
	beq	.L1992
.L1995:
	add	r5, r5, #1
	mov	r1, #8
	ldr	r0, [r4, #2308]
	bl	BsGet
	cmp	r5, r7
	bne	.L1995
	b	.L1992
.L2017:
	.align	2
.L2016:
	.word	.LC199
	.fnend
	.size	HEVC_Sei_Payload, .-HEVC_Sei_Payload
	.align	2
	.global	HEVC_SeiMessage
	.type	HEVC_SeiMessage, %function
HEVC_SeiMessage:
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
	mov	r5, #0
	mov	r4, r0
	mov	r6, r1
	mov	r7, r2
	ldr	r0, [r0, #2308]
	b	.L2019
.L2021:
	bl	BsSkip
	ldr	r0, [r4, #2308]
	add	r5, r5, #255
	ldr	r3, [r0, #24]
	ldr	r2, [r0, #16]
	add	r1, r3, #8
	cmp	r1, r2
	bgt	.L2027
.L2019:
	mov	r1, #8
	bl	BsShow
	mov	r1, #8
	cmp	r0, #255
	ldr	r0, [r4, #2308]
	beq	.L2021
	bl	BsGet
	mov	r8, #0
	mov	r9, r0
	str	r0, [r6]
	ldr	r0, [r4, #2308]
	b	.L2022
.L2023:
	bl	BsSkip
	ldr	r0, [r4, #2308]
	add	r8, r8, #255
	ldr	r3, [r0, #24]
	ldr	r2, [r0, #16]
	add	r1, r3, #8
	cmp	r1, r2
	bgt	.L2028
.L2022:
	mov	r1, #8
	bl	BsShow
	mov	r1, #8
	cmp	r0, #255
	ldr	r0, [r4, #2308]
	beq	.L2023
	bl	BsGet
	add	r3, r9, r5
	mov	r2, r7
	mov	r1, r6
	str	r0, [r6, #4]
	add	r8, r0, r8
	mov	r0, r4
	str	r8, [sp]
	bl	HEVC_Sei_Payload
	cmp	r0, #0
	bne	.L2029
.L2020:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2027:
	str	r2, [sp]
	mov	r0, #1
	movw	r2, #2868
	ldr	r1, .L2030
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2028:
	str	r2, [sp]
	mov	r0, #1
	movw	r2, #2890
	ldr	r1, .L2030
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2029:
	ldr	r1, .L2030+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2020
.L2031:
	.align	2
.L2030:
	.word	.LC200
	.word	.LC201
	.fnend
	.size	HEVC_SeiMessage, .-HEVC_SeiMessage
	.align	2
	.global	HEVC_DecSEI
	.type	HEVC_DecSEI, %function
HEVC_DecSEI:
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
	add	r6, r0, #3440
	add	r5, r0, #27136
	mov	r4, r0
	add	r6, r6, #8
	add	r5, r5, #228
	b	.L2036
.L2033:
	ldr	r0, [r4, #2308]
	bl	BsIsByteAligned
	cmp	r0, #0
	mov	r0, r4
	beq	.L2041
	bl	HEVC_More_Rbsp_Data
	subs	r7, r0, #0
	beq	.L2042
.L2036:
	mov	r2, r5
	mov	r1, r6
	mov	r0, r4
	bl	HEVC_SeiMessage
	cmp	r0, #0
	beq	.L2033
	ldr	r1, .L2043
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r7, #0
.L2034:
	mov	r0, r7
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2041:
	ldr	r1, .L2043+4
	mvn	r7, #0
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r7
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2042:
	ldr	r0, [r4, #2308]
	mov	r1, #8
	bl	BsGet
	cmp	r0, #128
	beq	.L2034
	mov	r2, r0
	ldr	r1, .L2043+8
	mov	r0, #1
	mvn	r7, #0
	bl	dprint_vfmw
	b	.L2034
.L2044:
	.align	2
.L2043:
	.word	.LC202
	.word	.LC203
	.word	.LC204
	.fnend
	.size	HEVC_DecSEI, .-HEVC_DecSEI
	.align	2
	.global	HEVC_Sei_Scalable_Nesting
	.type	HEVC_Sei_Scalable_Nesting, %function
HEVC_Sei_Scalable_Nesting:
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
	mov	r4, r0
	mov	r7, r1
	ldr	r0, [r0, #2308]
	mov	r1, #1
	mov	r9, r2
	bl	BsGet
	add	r8, r7, #20480
	mov	r1, #1
	strb	r0, [r8, #2500]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	uxtb	r0, r0
	strb	r0, [r8, #2501]
	cmp	r0, #0
	ldr	r0, [r4, #2308]
	beq	.L2046
	bl	BsGet
	ldr	r1, .L2062
	strb	r0, [r8, #2502]
	ldr	r0, [r4, #2308]
	bl	HEVC_ue_v
	cmp	r0, #63
	str	r0, [r8, #2508]
	bhi	.L2059
	ldrb	r6, [r8, #2502]
	cmp	r0, r6
	addcs	r5, r6, #5696
	addcs	r5, r5, #51
	addcs	r5, r7, r5, lsl #2
	bcc	.L2052
.L2051:
	mov	r1, #3
	ldr	r0, [r4, #2308]
	bl	BsGet
	ldr	r1, .L2062+4
	add	r6, r6, #1
	str	r0, [r5, #4]!
	ldr	r0, [r4, #2308]
	bl	HEVC_ue_v
	str	r0, [r5, #256]
	ldr	r3, [r8, #2508]
	cmp	r3, r6
	bcs	.L2051
.L2052:
	ldr	r0, [r4, #2308]
	bl	BsToNextByte
	mov	r3, #0
	strb	r3, [r8, #2504]
	b	.L2050
.L2055:
	bl	HEVC_MoreRbspData
	cmp	r0, #0
	beq	.L2060
.L2050:
	mov	r2, r9
	mov	r1, r7
	mov	r0, r4
	bl	HEVC_SeiMessage
	cmp	r0, #0
	mov	r0, r4
	beq	.L2055
	ldr	r1, .L2062+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2046:
	bl	BsGet
	uxtb	r5, r0
	strb	r5, [r8, #2503]
	cmp	r5, #0
	bne	.L2052
	mov	r1, #3
	ldr	r0, [r4, #2308]
	bl	BsGet
	ldr	r1, .L2062+12
	str	r0, [r8, #3024]
	ldr	r0, [r4, #2308]
	bl	HEVC_ue_v
	cmp	r0, #63
	str	r0, [r8, #3028]
	addls	r6, r7, #23296
	addls	r6, r6, #212
	bhi	.L2061
.L2054:
	mov	r1, #6
	ldr	r0, [r4, #2308]
	bl	BsGet
	add	r5, r5, #1
	str	r0, [r6, #4]!
	ldr	r3, [r8, #3028]
	cmp	r3, r5
	bcs	.L2054
	b	.L2052
.L2060:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2059:
	mov	r2, #64
	ldr	r1, .L2062+16
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2061:
	ldr	r1, .L2062+20
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2063:
	.align	2
.L2062:
	.word	.LC205
	.word	.LC207
	.word	.LC202
	.word	.LC208
	.word	.LC206
	.word	.LC209
	.fnend
	.size	HEVC_Sei_Scalable_Nesting, .-HEVC_Sei_Scalable_Nesting
	.align	2
	.global	HEVC_DecScalingListData
	.type	HEVC_DecScalingListData, %function
HEVC_DecScalingListData:
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
	ldr	r3, .L2101
	mov	r9, r1
	mov	r6, r0
	add	ip, r9, #1664
	add	r1, r1, #1264
	add	r0, r9, #1392
	ldr	r3, [r3, #52]
	add	r1, r1, #1
	add	r0, r0, #1
	mov	r2, #64
	mov	r4, ip
	blx	r3
	add	r3, r4, #4
	str	r3, [fp, #-76]
	add	r3, r6, #2192
	str	r3, [fp, #-48]
	add	r3, r9, #24
	str	r3, [fp, #-68]
	add	r3, r9, #49
	str	r3, [fp, #-72]
	mov	r3, #0
	str	r3, [fp, #-52]
.L2065:
	ldr	r2, [fp, #-48]
	ldr	r3, [r2, #4]!
	cmp	r3, #0
	str	r2, [fp, #-48]
	beq	.L2084
	ldr	r3, [fp, #-76]
	ldr	r7, [fp, #-72]
	str	r3, [fp, #-64]
	ldr	r3, [fp, #-68]
	str	r3, [fp, #-56]
	mov	r3, #0
	str	r3, [fp, #-60]
.L2083:
	mov	r1, #1
	ldr	r0, [r6, #2308]
	bl	BsGet
	ldr	r3, [fp, #-56]
	uxtb	r0, r0
	strb	r0, [r3, #1]!
	str	r3, [fp, #-56]
	ldr	r3, [fp, #-48]
	ldr	r5, [r3, #-1904]
	ldr	r3, [fp, #-52]
	cmp	r5, #64
	movge	r5, #64
	cmp	r3, #0
	beq	.L2066
	cmp	r0, #0
	add	r4, r6, #324
	beq	.L2097
	ldr	r3, [fp, #-52]
	cmp	r3, #1
	bls	.L2090
	ldr	r1, .L2101+4
	ldr	r0, [r6, #2308]
	bl	HEVC_se_v
	add	r3, r0, #7
	str	r0, [r9, #1660]
	cmp	r3, #254
	bhi	.L2098
	ldr	r3, [fp, #-64]
	add	r8, r0, #8
	str	r8, [r3]
.L2077:
	cmp	r5, #0
	ble	.L2076
	sub	r4, r4, #4
	mov	r10, #0
	b	.L2081
.L2080:
	mov	r8, r8, lsr #24
	ldr	r2, [r4, #4]!
	add	r3, r3, r8
	cmp	r10, r5
	uxtb	r3, r3
	rsb	r8, r8, r3
	strb	r8, [r7, r2]
	beq	.L2076
.L2081:
	ldr	r1, .L2101+8
	add	r10, r10, #1
	ldr	r0, [r6, #2308]
	bl	HEVC_se_v
	add	r3, r8, r0
	add	r2, r0, #128
	add	r3, r3, #256
	cmp	r2, #255
	str	r0, [r9, #1664]
	mov	r8, r3, asr #31
	bls	.L2080
	ldr	r1, .L2101+12
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
.L2095:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2085:
	ldr	r1, .L2101+16
	ldr	r0, [r6, #2308]
	bl	HEVC_ue_v
	ldr	r3, [fp, #-60]
	cmp	r0, r3
	bhi	.L2087
	ldr	r2, [fp, #-60]
	uxtb	r0, r0
	ldr	r3, [fp, #-56]
	rsb	r1, r0, r2
	strb	r0, [r3, #1560]
	uxtb	r1, r1
	strb	r1, [r3, #1584]
.L2071:
	ldr	r3, [fp, #-60]
	cmp	r1, r3
	beq	.L2099
	ldr	r2, [fp, #-52]
	mov	r3, r2, asl #3
	sub	r3, r3, r2, asl #1
	add	r1, r3, r1
	add	r1, r9, r1, lsl #6
	add	r1, r1, #49
.L2074:
	cmp	r1, #0
	beq	.L2100
	ldr	r3, .L2101
	mov	r2, r5
	mov	r0, r7
	ldr	r3, [r3, #52]
	blx	r3
.L2076:
	ldr	r3, [fp, #-48]
	add	r7, r7, #64
	ldr	r2, [fp, #-60]
	ldr	r1, [fp, #-64]
	ldr	r3, [r3]
	add	r2, r2, #1
	add	r1, r1, #4
	str	r2, [fp, #-60]
	cmp	r3, r2
	str	r1, [fp, #-64]
	bhi	.L2083
.L2084:
	ldr	r3, [fp, #-52]
	ldr	r2, [fp, #-68]
	add	r3, r3, #1
	str	r3, [fp, #-52]
	cmp	r3, #4
	ldr	r3, [fp, #-72]
	add	r2, r2, #6
	str	r2, [fp, #-68]
	add	r3, r3, #384
	str	r3, [fp, #-72]
	ldr	r3, [fp, #-76]
	add	r3, r3, #24
	str	r3, [fp, #-76]
	bne	.L2065
	mov	r0, #0
	b	.L2095
.L2090:
	mov	r8, #8
	b	.L2077
.L2097:
	ldr	r1, .L2101+16
	ldr	r0, [r6, #2308]
	bl	HEVC_ue_v
	ldr	r3, [fp, #-60]
	cmp	r0, r3
	bhi	.L2087
	ldr	r3, [fp, #-52]
	uxtb	r0, r0
	ldr	ip, [fp, #-60]
	ldr	r2, [fp, #-56]
	cmp	r3, #1
	rsb	r1, r0, ip
	strb	r0, [r2, #1560]
	uxtb	r1, r1
	strb	r1, [r2, #1584]
	bls	.L2071
	cmp	ip, r1
	mov	r2, ip
	movne	r2, r3
	movne	r3, r3, asl #3
	subne	r3, r3, r2, asl #1
	ldr	r2, [fp, #-64]
	addne	r3, r3, r1
	moveq	r3, #16
	addne	r3, r9, r3, lsl #2
	ldrne	r3, [r3, #1668]
	str	r3, [r2]
	b	.L2071
.L2099:
	mov	r1, r3
	ldr	r0, [fp, #-52]
	bl	HEVC_GetScalingListDefaultAddress
	mov	r1, r0
	b	.L2074
.L2098:
	ldr	r1, .L2101+20
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2095
.L2100:
	ldr	r1, .L2101+24
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2095
.L2087:
	ldr	r1, .L2101+28
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2095
.L2066:
	cmp	r0, #0
	beq	.L2085
	ldr	r4, .L2101+32
	mov	r8, #8
	b	.L2077
.L2102:
	.align	2
.L2101:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC213
	.word	.LC215
	.word	.LC216
	.word	.LC210
	.word	.LC214
	.word	.LC212
	.word	.LC211
	.word	.LANCHOR0+65536
	.fnend
	.size	HEVC_DecScalingListData, .-HEVC_DecScalingListData
	.align	2
	.global	HEVC_ProcessSPS
	.type	HEVC_ProcessSPS, %function
HEVC_ProcessSPS:
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
	mov	r4, r1
	mov	r5, r0
	ldr	r1, .L2261
	ldr	r0, [r0, #2308]
	bl	HEVC_ue_v
	cmp	r0, #1
	mov	r8, r0
	str	r0, [r4, #64]
	beq	.L2104
	cmp	r0, #3
	bhi	.L2238
	mov	r2, r0
	ldr	r1, .L2261+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
.L2106:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2238:
	ldr	r1, .L2261+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2104:
	ldr	r1, .L2261+12
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #8192
	str	r0, [r4, #72]
	bhi	.L2239
	ldr	r1, .L2261+16
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #4096
	str	r0, [r4, #76]
	bhi	.L2240
	ldr	r2, [r4, #760]
	ldr	r3, [r4, #72]
	cmp	r2, #120
	mul	r0, r3, r0
	beq	.L2110
	bgt	.L2111
	cmp	r2, #60
	beq	.L2112
	ble	.L2241
	cmp	r2, #90
	beq	.L2115
	cmp	r2, #93
	beq	.L2116
	cmp	r2, #63
	bne	.L2109
	mov	r2, #61440
	mov	r3, #245760
	b	.L2117
.L2111:
	cmp	r2, #156
	beq	.L2118
	bgt	.L2119
	cmp	r2, #150
	beq	.L2118
	cmp	r2, #153
	beq	.L2118
	cmp	r2, #123
	beq	.L2110
.L2109:
	ldr	r1, .L2261+20
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2119:
	cmp	r2, #183
	beq	.L2120
	cmp	r2, #186
	beq	.L2120
	cmp	r2, #180
	bne	.L2109
.L2120:
	mov	r2, #8912896
	mov	r3, #35651584
.L2117:
	cmp	r0, r2
	movls	r3, #16
	strls	r3, [r4, #236]
	bls	.L2122
	cmp	r0, r3, lsr #1
	movls	r3, #12
	strls	r3, [r4, #236]
	bls	.L2122
	add	r3, r3, r3, lsl #1
	cmp	r0, r3, lsr #2
	movls	r3, #8
	movhi	r3, #6
	str	r3, [r4, #236]
.L2122:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	cmp	r0, #0
	str	r0, [r4, #80]
	beq	.L2125
	ldr	r1, .L2261+24
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	ldr	r3, [r4, #64]
	ldr	r6, .L2261+28
	ldr	r1, .L2261+32
	add	r3, r6, r3, lsl #2
	ldr	r3, [r3, #472]
	mul	r0, r3, r0
	str	r0, [r4, #84]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	ldr	r2, [r4, #64]
	ldr	r3, [r4, #72]
	ldr	r1, [r4, #84]
	add	r2, r6, r2, lsl #2
	rsb	r3, r1, r3
	ldr	r2, [r2, #472]
	mul	r0, r2, r0
	rsb	r3, r0, r3
	cmp	r3, #0
	str	r0, [r4, #88]
	blt	.L2242
	ldr	r1, .L2261+36
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	ldr	r3, [r4, #64]
	ldr	r1, .L2261+40
	add	r3, r6, r3, lsl #2
	ldr	r3, [r3, #488]
	mul	r0, r3, r0
	str	r0, [r4, #92]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	ldr	r1, [r4, #64]
	ldr	r2, [r4, #92]
	ldr	r3, [r4, #76]
	add	r6, r6, r1, lsl #2
	rsb	r3, r2, r3
	ldr	r2, [r6, #488]
	mul	r0, r2, r0
	rsb	r3, r0, r3
	cmp	r3, #0
	str	r0, [r4, #96]
	blt	.L2243
.L2125:
	ldr	r1, .L2261+44
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #6
	add	r2, r0, #8
	str	r2, [r4, #100]
	bhi	.L2244
	ldr	r1, .L2261+48
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #6
	add	r2, r0, #8
	str	r2, [r4, #108]
	bhi	.L2245
	ldr	r3, [r4, #100]
	ldr	r1, .L2261+52
	str	r3, [r5, #192]
	ldr	r3, [r4, #108]
	str	r3, [r5, #196]
	ldr	r0, [r4, #108]
	ldr	ip, [r4, #100]
	mov	r3, r0, asl #3
	mov	r2, ip, asl #3
	sub	r3, r3, r0, asl #1
	sub	r2, r2, ip, asl #1
	sub	r3, r3, #48
	sub	r2, r2, #48
	str	r3, [r4, #112]
	str	r2, [r4, #104]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #12
	bhi	.L2246
	add	r0, r0, #4
	mov	r1, #1
	str	r0, [r4, #128]
	mov	r6, r4
	str	r0, [r4, #132]
	mov	r7, #0
	ldr	r0, [r5, #2308]
	bl	BsGet
	strb	r0, [r4, #4]
	b	.L2136
.L2130:
	ldr	r3, [r4, #56]
	add	r7, r7, #1
	cmp	r7, r3
	bhi	.L2135
.L2136:
	ldr	r1, .L2261+56
	add	r6, r6, #4
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	ldr	r1, .L2261+60
	add	r0, r0, #1
	str	r0, [r6, #376]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	ldr	r1, .L2261+64
	ldr	r9, [r6, #376]
	str	r0, [r6, #408]
	ldr	r0, [r5, #2308]
	ldr	r10, [r4, #380]
	bl	HEVC_ue_v
	str	r0, [r6, #440]
	ldrb	r3, [r4, #4]
	cmp	r3, #0
	bne	.L2130
	ldr	r1, [r4, #56]
	add	r3, r7, #1
	cmp	r3, r1
	addls	r7, r7, #95
	addls	r7, r4, r7, lsl #2
	bhi	.L2135
.L2134:
	ldr	r2, [r4, #380]
	add	r3, r3, #1
	cmp	r3, r1
	str	r2, [r7, #4]!
	ldr	r2, [r4, #412]
	str	r2, [r7, #32]
	ldr	r2, [r4, #444]
	str	r2, [r7, #64]
	bls	.L2134
.L2135:
	ldr	r3, [r4, #236]
	cmp	r9, r10
	ldr	r1, .L2261+68
	movcc	r9, r10
	cmp	r3, r9
	movcs	r3, r9
	str	r3, [r4, #236]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #3
	str	r0, [r4, #136]
	bhi	.L2247
	ldr	r1, .L2261+72
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #3
	str	r0, [r4, #144]
	bhi	.L2248
	ldr	r3, [r4, #136]
	add	r3, r3, #3
	str	r3, [r4, #140]
	add	r6, r0, r3
	str	r6, [r4, #148]
	sub	r2, r6, #4
	cmp	r2, #2
	bhi	.L2249
	mov	r2, #1
	ldr	r7, [r4, #72]
	mov	r6, r2, asl r6
	mov	r3, r2, asl r3
	str	r6, [r4, #156]
	str	r6, [r4, #160]
	mov	r1, r6
	str	r6, [r4, #164]
	mov	r0, r7
	str	r3, [r4, #152]
	bl	__aeabi_uidivmod
	mov	r0, r7
	cmp	r1, #0
	mov	r1, r6
	beq	.L2139
	bl	__aeabi_uidiv
	add	r0, r0, #1
.L2140:
	ldr	r7, [r4, #76]
	mov	r1, r6
	str	r0, [r4, #240]
	mov	r0, r7
	bl	__aeabi_uidivmod
	mov	r0, r7
	cmp	r1, #0
	mov	r1, r6
	beq	.L2141
	bl	__aeabi_uidiv
	add	r0, r0, #1
.L2142:
	str	r0, [r4, #244]
	ldr	r1, .L2261+76
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #3
	str	r0, [r4, #168]
	bhi	.L2250
	ldr	r1, .L2261+80
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #3
	str	r0, [r4, #176]
	bhi	.L2251
	ldr	r3, [r4, #168]
	ldr	r2, [r4, #140]
	add	r3, r3, #2
	str	r3, [r4, #172]
	cmp	r3, r2
	bcs	.L2252
	add	r0, r0, r3
	str	r0, [r4, #180]
	cmp	r0, #5
	bhi	.L2146
	ldr	r3, [r4, #148]
	cmp	r0, r3
	bhi	.L2146
	ldr	r1, .L2261+84
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	ldr	r3, [r4, #148]
	ldr	r2, [r4, #172]
	rsb	r3, r2, r3
	cmp	r0, r3
	str	r0, [r4, #200]
	bhi	.L2253
	ldr	r1, .L2261+88
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	ldr	r3, [r4, #148]
	ldr	r2, [r4, #172]
	rsb	r3, r2, r3
	cmp	r0, r3
	str	r0, [r4, #208]
	bhi	.L2254
	ldr	r3, [r4, #200]
	add	r0, r0, #1
	mov	r1, #0
	str	r0, [r4, #212]
	add	r3, r3, #1
	str	r3, [r4, #204]
	str	r1, [r5, #228]
	mov	ip, #1
	ldr	r3, [r4, #172]
	ldr	r0, [r4, #160]
	ldr	r2, [r4, #144]
	mov	r3, ip, asl r3
	cmp	r3, r0, lsr r2
	bcc	.L2151
	b	.L2255
.L2178:
	mov	r8, r0
.L2151:
	str	r8, [r5, #228]
	add	r0, r8, #1
	ldr	r3, [r4, #172]
	ldr	r1, [r4, #160]
	add	r3, r8, r3
	ldr	r2, [r4, #144]
	mov	r3, ip, asl r3
	cmp	r3, r1, lsr r2
	bcc	.L2178
.L2150:
	mov	r6, #1
	add	r8, r2, r8
	str	r6, [r4, #224]
	mov	r3, #0
	str	r8, [r4, #216]
	mov	r1, r6
	str	r3, [r4, #220]
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #6]
	cmp	r0, #0
	beq	.L2152
	mov	r1, r6
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #7]
	cmp	r0, #0
	bne	.L2256
.L2152:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #8]
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r6, r0
	strb	r6, [r4, #9]
	cmp	r6, #0
	bne	.L2153
	ldr	r2, [r4, #76]
	cmp	r2, #64
	bls	.L2257
.L2153:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	cmp	r0, #0
	str	r0, [r4, #116]
	beq	.L2154
	mov	r1, #4
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #4
	add	r0, r0, #1
	str	r0, [r4, #120]
	ldr	r0, [r5, #2308]
	bl	BsGet
	ldr	r1, .L2261+92
	add	r0, r0, #1
	str	r0, [r4, #124]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #2
	str	r0, [r4, #184]
	bhi	.L2258
.L2155:
	ldr	r1, .L2261+96
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #2
	str	r0, [r4, #192]
	bhi	.L2259
.L2156:
	ldr	r2, [r4, #184]
	add	r2, r2, #3
	str	r2, [r4, #188]
	add	r0, r0, r2
	str	r0, [r4, #196]
	cmp	r0, #5
	bhi	.L2157
	ldr	r3, [r4, #148]
	cmp	r0, r3
	bhi	.L2157
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	strb	r0, [r4, #10]
.L2154:
	ldr	r1, .L2261+100
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #64
	str	r0, [r4, #228]
	bhi	.L2159
	cmp	r0, #0
	addne	r7, r4, #13056
	movne	r6, #0
	addne	r7, r7, #52
	bne	.L2164
	b	.L2165
.L2163:
	ldr	r3, [r4, #228]
	cmp	r6, r3
	bcs	.L2165
.L2164:
	mov	r3, r6
	mov	r2, r7
	mov	r1, r4
	mov	r0, r5
	bl	HEVC_DecShortTermRefPicSet
	add	r6, r6, #1
	add	r7, r7, #204
	cmp	r0, #0
	beq	.L2163
	ldr	r1, .L2261+104
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2116:
	mov	r2, #245760
	mov	r3, #983040
	b	.L2117
.L2141:
	bl	__aeabi_uidiv
	b	.L2142
.L2139:
	bl	__aeabi_uidiv
	b	.L2140
.L2165:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #11]
	cmp	r0, #0
	beq	.L2162
	ldr	r1, .L2261+108
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #32
	str	r0, [r4, #232]
	bhi	.L2168
	cmp	r0, #0
	addne	r8, r4, #244
	addne	r7, r4, #16
	movne	r6, #0
	beq	.L2162
.L2170:
	ldr	r1, [r4, #128]
	add	r6, r6, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	str	r0, [r8, #4]!
	ldr	r0, [r5, #2308]
	bl	BsGet
	strb	r0, [r7, #1]!
	ldr	r3, [r4, #232]
	cmp	r6, r3
	bcc	.L2170
.L2162:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #12]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #13]
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #14]
	cmp	r0, #0
	beq	.L2167
	mov	r2, r4
	add	r1, r4, #2624
	mov	r0, r5
	bl	HEVC_DecVuiParam
	cmp	r0, #0
	bne	.L2260
.L2167:
	ldr	ip, [r4, #76]
	ldr	r3, [r4, #72]
	ldr	r2, [r4, #2656]
	ldr	r1, [r4, #2652]
	ldr	r0, [r4, #2648]
	str	ip, [sp]
	bl	HEVCGetDar
	mov	r1, #1
	str	r0, [r4, #2644]
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #15]
	cmp	r0, #0
	bne	.L2232
.L2175:
	mov	r1, #1
	strb	r1, [r4]
	ldr	r2, [r5, #256]
	movw	ip, #26164
	ldr	r3, [r5, #2316]
	ldr	r0, [r4, #236]
	mla	r3, ip, r2, r3
	ldr	r3, [r3, #236]
	cmp	r0, r3
	strneb	r1, [r4, #2]
	movne	r0, #0
	moveq	r0, #0
	streqb	r0, [r4, #2]
	b	.L2106
.L2174:
	ldr	r0, [r5, #2308]
	bl	BsGet
	strb	r0, [r4, #16]
.L2232:
	mov	r0, r5
	bl	HEVC_MoreRbspData
	mov	r1, #1
	cmp	r0, #0
	bne	.L2174
	b	.L2175
.L2241:
	cmp	r2, #0
	beq	.L2114
	cmp	r2, #30
	bne	.L2109
.L2114:
	mov	r2, #9216
	mov	r3, #36864
	b	.L2117
.L2257:
	ldr	r1, .L2261+112
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L2261+116
	ldr	ip, [r3]
	cmp	ip, #0
	mvneq	r0, #0
	beq	.L2106
	ldr	r0, [r5, #244]
	mov	r3, r6
	mov	r2, r6
	mov	r1, #102
	blx	ip
	mvn	r0, #0
	b	.L2106
.L2112:
	mov	r2, #30720
	mov	r3, #122880
	b	.L2117
.L2110:
	mov	r2, #557056
	mov	r3, #2228224
	b	.L2117
.L2118:
	mov	r2, #2228224
	mov	r3, #8912896
	b	.L2117
.L2115:
	mov	r2, #138240
	mov	r3, #552960
	b	.L2117
.L2256:
	add	r1, r4, #860
	mov	r0, r5
	bl	HEVC_DecScalingListData
	cmp	r0, #0
	beq	.L2152
	mov	r0, r6
	ldr	r1, .L2261+120
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2146:
	ldr	r1, .L2261+124
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2259:
	mov	r2, r0
	ldr	r1, .L2261+128
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r0, [r4, #192]
	b	.L2156
.L2258:
	mov	r2, r0
	ldr	r1, .L2261+132
	mov	r0, #1
	bl	dprint_vfmw
	b	.L2155
.L2255:
	mov	r8, r1
	b	.L2150
.L2239:
	mov	r0, r8
	ldr	r1, .L2261+136
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2246:
	ldr	r1, .L2261+140
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2247:
	ldr	r1, .L2261+144
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2250:
	ldr	r1, .L2261+148
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2157:
	ldr	r1, .L2261+152
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2253:
	ldr	r1, .L2261+156
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2240:
	mov	r0, r8
	ldr	r1, .L2261+160
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2249:
	ldr	r1, .L2261+164
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2248:
	ldr	r1, .L2261+168
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2244:
	ldr	r1, .L2261+172
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2245:
	ldr	r1, .L2261+176
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2252:
	ldr	r1, .L2261+180
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2251:
	ldr	r1, .L2261+184
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2254:
	ldr	r1, .L2261+188
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2159:
	mov	r2, #64
	ldr	r1, .L2261+192
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2242:
	ldr	r1, .L2261+196
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2243:
	ldr	r1, .L2261+200
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2168:
	ldr	r1, .L2261+204
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2260:
	ldr	r1, .L2261+208
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2106
.L2262:
	.align	2
.L2261:
	.word	.LC217
	.word	.LC219
	.word	.LC218
	.word	.LC220
	.word	.LC222
	.word	.LC224
	.word	.LC225
	.word	.LANCHOR1
	.word	.LC226
	.word	.LC228
	.word	.LC229
	.word	.LC231
	.word	.LC233
	.word	.LC235
	.word	.LC237
	.word	.LC238
	.word	.LC239
	.word	.LC240
	.word	.LC242
	.word	.LC245
	.word	.LC247
	.word	.LC251
	.word	.LC253
	.word	.LC257
	.word	.LC259
	.word	.LC262
	.word	.LC264
	.word	.LC265
	.word	.LC256
	.word	g_event_report
	.word	.LC255
	.word	.LC250
	.word	.LC260
	.word	.LC258
	.word	.LC221
	.word	.LC236
	.word	.LC241
	.word	.LC246
	.word	.LC261
	.word	.LC252
	.word	.LC223
	.word	.LC244
	.word	.LC243
	.word	.LC232
	.word	.LC234
	.word	.LC249
	.word	.LC248
	.word	.LC254
	.word	.LC263
	.word	.LC227
	.word	.LC230
	.word	.LC266
	.word	.LC267
	.fnend
	.size	HEVC_ProcessSPS, .-HEVC_ProcessSPS
	.align	2
	.global	HEVC_DecSPS
	.type	HEVC_DecSPS, %function
HEVC_DecSPS:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #404
	sub	sp, sp, #404
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r5, .L2281
	mov	r4, r0
	movw	r2, #26164
	mov	r1, #0
	ldr	r0, .L2281+4
	ldr	r3, [r5, #48]
	blx	r3
	mov	r2, #384
	ldr	r3, [r5, #48]
	mov	r1, #0
	sub	r0, fp, #428
	ldr	r8, .L2281+8
	blx	r3
	ldr	r0, [r4, #2308]
	mov	r1, #4
	bl	BsGet
	ldr	r2, [r4, #148]
	cmp	r2, r0
	str	r0, [fp, #-440]
	bls	.L2274
	mov	r1, #3
	ldr	r0, [r4, #2308]
	bl	BsGet
	cmp	r0, #8
	mov	r7, r0
	bhi	.L2275
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r3, r7
	mov	r2, #1
	sub	r1, fp, #428
	mov	r9, r0
	mov	r0, r4
	bl	HEVC_DecPTL
	cmp	r0, #0
	bne	.L2276
	ldr	r1, .L2281+12
	ldr	r0, [r4, #2308]
	bl	HEVC_ue_v
	ldr	r2, [r4, #152]
	cmp	r0, r2
	mov	r10, r0
	bcs	.L2277
	movw	ip, #26164
	ldr	r2, [r4, #2316]
	mul	r6, ip, r0
	uxtb	r0, r9
	str	ip, [fp, #-444]
	ldr	r3, [fp, #-440]
	add	r2, r2, r6
	ldrb	r9, [r2, #1]
	cmp	r9, #0
	bne	.L2278
	str	r3, [r2, #52]
	sub	r1, fp, #428
	ldr	lr, [r4, #2316]
	mov	r2, #384
	add	lr, lr, r6
	str	r7, [lr, #56]
	ldr	lr, [r4, #2316]
	add	lr, lr, r6
	strb	r0, [lr, #3]
	ldr	r0, [r4, #2316]
	ldr	r7, [r5, #52]
	add	r0, r0, r6
	add	r0, r0, #476
	blx	r7
	ldr	r2, [r4, #2316]
	mov	r0, r4
	add	r2, r2, r6
	str	r10, [r2, #60]
	ldr	r1, [r4, #2316]
	add	r1, r1, r6
	bl	HEVC_ProcessSPS
	ldr	ip, [fp, #-444]
	subs	r7, r0, #0
	bne	.L2279
	ldr	r3, [r4, #2316]
	mov	r1, #1
	add	r0, r4, #27136
	mov	r2, ip
	add	r0, r0, #228
	strb	r1, [r3, r6]
	ldr	r3, [r4, #2316]
	add	r3, r3, r6
	strb	r1, [r3, #1]
	ldr	r1, [r4, #2316]
	ldr	r3, [r5, #52]
	add	r1, r1, r6
	blx	r3
.L2265:
	mov	r0, r7
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2278:
	str	r3, [r8, #-3412]
	sub	r1, fp, #428
	str	r7, [r8, #-3408]
	mov	r2, #384
	strb	r0, [r8, #-3461]
	ldr	r7, [r5, #52]
	ldr	r0, .L2281+16
	blx	r7
	ldr	r1, .L2281+4
	mov	r0, r4
	str	r10, [r8, #-3404]
	bl	HEVC_ProcessSPS
	ldr	ip, [fp, #-444]
	subs	r7, r0, #0
	bne	.L2280
	ldr	r0, [r4, #2316]
	mov	r3, #1
	mov	r2, ip
	strb	r3, [r8, #-3464]
	strb	r3, [r8, #-3463]
	add	r0, r0, r6
	ldr	r9, [r5, #56]
	ldr	r1, .L2281+4
	str	ip, [fp, #-440]
	blx	r9
	ldr	ip, [fp, #-440]
	add	r0, r4, #27136
	ldr	r1, [r4, #2316]
	add	r0, r0, #228
	ldr	r3, [r5, #52]
	mov	r2, ip
	add	r1, r1, r6
	blx	r3
	mov	r0, r7
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2277:
	ldr	r1, .L2281+20
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r2, [r4, #152]
	cmp	r10, r2
	bcc	.L2273
	ldr	r1, .L2281+24
	ldr	ip, [r1]
	cmp	ip, #0
	beq	.L2273
	str	r2, [fp, #-432]
	mov	r3, #8
	str	r10, [fp, #-436]
	sub	r2, fp, #436
	ldr	r0, [r4, #244]
	mov	r1, #109
	blx	ip
	mvn	r7, #0
	mov	r0, r7
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2273:
	mvn	r7, #0
	b	.L2265
.L2274:
	ldr	r1, .L2281+28
	mov	r0, #1
	mvn	r7, #0
	bl	dprint_vfmw
	b	.L2265
.L2275:
	mov	r2, #8
	ldr	r1, .L2281+32
	mov	r0, #1
	mvn	r7, #0
	bl	dprint_vfmw
	b	.L2265
.L2276:
	ldr	r1, .L2281+36
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r7, #0
	b	.L2265
.L2279:
	mov	r2, r10
	ldr	r1, .L2281+40
	mov	r0, #1
	mvn	r7, #0
	bl	dprint_vfmw
	ldr	r3, [r4, #2316]
	mov	r2, #1
	strb	r2, [r3, r6]
	ldr	r3, [r4, #2316]
	add	r6, r3, r6
	strb	r9, [r6, #1]
	b	.L2265
.L2280:
	ldr	r1, [r4, #2316]
	add	r0, r4, #27136
	mov	r2, ip
	ldr	r4, [r5, #52]
	add	r1, r1, r6
	add	r0, r0, #228
	blx	r4
	mov	r2, r10
	ldr	r1, .L2281+44
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r7, #0
	b	.L2265
.L2282:
	.align	2
.L2281:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR5-3464
	.word	.LANCHOR5
	.word	.LC271
	.word	.LANCHOR5-2988
	.word	.LC272
	.word	g_event_report
	.word	.LC268
	.word	.LC269
	.word	.LC270
	.word	.LC274
	.word	.LC273
	.fnend
	.size	HEVC_DecSPS, .-HEVC_DecSPS
	.align	2
	.global	HEVC_ProcessPPS
	.type	HEVC_ProcessPPS, %function
HEVC_ProcessPPS:
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
	mov	r4, r1
	mov	r7, #1
	mov	r5, r0
	strb	r7, [r4, #16]
	str	r7, [r4, #68]
	str	r7, [r4, #72]
	ldr	r1, .L2411
	ldr	r0, [r0, #2308]
	bl	HEVC_ue_v
	cmp	r0, #0
	str	r0, [r4, #32]
	blt	.L2284
	ldr	r3, [r5, #152]
	cmp	r0, r3
	bge	.L2284
	ldr	r3, [r5, #2316]
	movw	r6, #26164
	mla	r6, r6, r0, r3
	ldrb	r3, [r6, #1]
	cmp	r3, #0
	beq	.L2391
	mov	r1, r7
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, r7
	strb	r0, [r4, #2]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #3
	strb	r0, [r4, #4]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, r7
	str	r0, [r4, #36]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, r7
	strb	r0, [r4, #3]
	ldr	r0, [r5, #2308]
	bl	BsGet
	ldr	r1, .L2411+4
	strb	r0, [r4, #5]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	add	r0, r0, #1
	str	r0, [r4, #40]
	cmp	r0, #15
	bhi	.L2392
	ldr	r1, .L2411+8
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	add	r0, r0, #1
	str	r0, [r4, #44]
	cmp	r0, #15
	bhi	.L2393
	ldr	r1, .L2411+12
	ldr	r0, [r5, #2308]
	bl	HEVC_se_v
	add	r2, r0, #26
	str	r2, [r4, #48]
	ldr	r3, [r6, #104]
	cmp	r2, #51
	rsb	r0, r3, #0
	movle	r1, #0
	movgt	r1, #1
	cmp	r2, r0
	orrlt	r1, r1, #1
	cmp	r1, #0
	bne	.L2394
	mov	r1, r7
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, r7
	strb	r0, [r4, #6]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, r7
	strb	r0, [r4, #7]
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #8]
	cmp	r0, #0
	streq	r0, [r4, #52]
	bne	.L2395
.L2293:
	str	r0, [r4, #56]
	ldr	r1, .L2411+16
	ldr	r0, [r5, #2308]
	bl	HEVC_se_v
	add	r3, r0, #12
	str	r0, [r4, #60]
	cmp	r3, #24
	bhi	.L2396
	ldr	r1, .L2411+20
	ldr	r0, [r5, #2308]
	bl	HEVC_se_v
	add	r3, r0, #12
	str	r0, [r4, #64]
	cmp	r3, #24
	bhi	.L2397
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #9]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #10]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #11]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #12]
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #13]
	ldr	r0, [r5, #2308]
	bl	BsGet
	ldrb	r3, [r4, #13]
	cmp	r3, #0
	strb	r0, [r4, #14]
	bne	.L2398
	ldr	r3, [r6, #240]
	strh	r3, [r4, #176]
	ldr	r3, [r6, #244]
	strh	r3, [r4, #216]
.L2332:
	ldr	r0, [r4, #68]
	cmp	r0, #0
	ble	.L2337
.L2331:
	ldr	ip, [r6, #160]
	add	r1, r4, #174
	mov	r3, #0
.L2336:
	ldrsh	r2, [r1, #2]!
	add	r3, r3, #1
	mul	r2, ip, r2
	cmp	r2, #64
	bhi	.L2335
	ldr	lr, [r6, #72]
	cmp	lr, #64
	bhi	.L2399
.L2335:
	cmp	r3, r0
	blt	.L2336
.L2337:
	ldr	r1, [r4, #72]
	cmp	r1, #0
	ble	.L2334
	ldr	r0, [r6, #160]
	ldrsh	r2, [r4, #216]
	mul	r2, r0, r2
	cmp	r2, #63
	addhi	r1, r1, #107
	addhi	r3, r4, #216
	addhi	r1, r4, r1, lsl #1
	bhi	.L2340
	b	.L2338
.L2341:
	ldrsh	r2, [r3, #2]!
	mul	r2, r0, r2
	cmp	r2, #63
	bls	.L2338
.L2340:
	cmp	r3, r1
	bne	.L2341
.L2334:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #17]
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #18]
	cmp	r0, #0
	bne	.L2400
.L2343:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #21]
	cmp	r0, #0
	beq	.L2346
	add	r1, r4, #260
	mov	r0, r5
	bl	HEVC_DecScalingListData
	cmp	r0, #0
	bne	.L2401
.L2346:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	ldr	r1, .L2411+24
	strb	r0, [r4, #22]
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	add	r2, r0, #2
	str	r2, [r4, #84]
	cmp	r2, #1
	ble	.L2347
	ldr	r3, [r6, #148]
	cmp	r2, r3
	bhi	.L2347
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #23]
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #24]
	cmp	r0, #0
	bne	.L2378
	b	.L2351
.L2350:
	ldr	r0, [r5, #2308]
	bl	BsGet
	strb	r0, [r4, #25]
.L2378:
	mov	r0, r5
	bl	HEVC_MoreRbspData
	mov	r1, #1
	cmp	r0, #0
	bne	.L2350
.L2351:
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2395:
	ldr	r1, .L2411+28
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #3
	str	r0, [r4, #52]
	bls	.L2293
	mov	r0, r7
	ldr	r1, .L2411+32
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2379
.L2398:
	ldr	r1, .L2411+36
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #19
	add	r2, r0, #1
	str	r2, [r4, #68]
	bhi	.L2402
	ldr	r1, .L2411+40
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #21
	add	r3, r0, #1
	str	r3, [r4, #72]
	bhi	.L2403
	ldr	r2, [r4, #68]
	cmp	r2, #10
	bgt	.L2404
	cmp	r3, #11
	ble	.L2301
	ldr	r1, .L2411+44
	mov	r2, #11
.L2388:
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L2411+48
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L2383
.L2385:
	mov	r3, #0
	ldr	r0, [r5, #244]
	mov	r2, r3
	mov	r1, #102
	blx	ip
	mvn	r0, #0
.L2379:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2338:
	ldr	r1, .L2411+52
.L2387:
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L2411+48
	ldr	ip, [r3]
	cmp	ip, #0
	bne	.L2385
.L2383:
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2399:
	ldr	r1, .L2411+56
	b	.L2387
.L2394:
	mov	r0, r7
	ldr	r1, .L2411+60
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2379
.L2301:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #15]
	cmp	r0, #0
	bne	.L2315
	ldr	r3, [r4, #68]
	sub	r3, r3, #1
	cmp	r3, #0
	addgt	r8, r4, #90
	movgt	r7, r0
	bgt	.L2313
	b	.L2405
.L2407:
	cmp	r3, r2
	bhi	.L2311
	ldr	r3, [r4, #68]
	add	r7, r7, #1
	sub	r3, r3, #1
	cmp	r3, r7
	ble	.L2406
.L2313:
	ldr	r1, .L2411+64
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	add	r0, r0, #1
	uxth	r3, r0
	strh	r3, [r8, #2]!
	ldr	r2, [r6, #240]
	sxth	r3, r3
	cmp	r3, #0
	bge	.L2407
.L2311:
	str	r2, [sp]
	mov	r0, #1
	mov	r2, r7
	ldr	r1, .L2411+68
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2379
.L2404:
	mov	r3, r2
	ldr	r1, .L2411+72
	mov	r2, #10
	b	.L2388
.L2400:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #19]
	ldr	r0, [r5, #2308]
	bl	BsGet
	uxtb	r7, r0
	strb	r7, [r4, #20]
	cmp	r7, #0
	bne	.L2343
	ldr	r1, .L2411+76
	ldr	r0, [r5, #2308]
	bl	HEVC_se_v
	add	r3, r0, #6
	mov	r2, r0
	cmp	r3, #12
	str	r0, [r4, #76]
	bhi	.L2408
.L2345:
	ldr	r1, .L2411+80
	ldr	r0, [r5, #2308]
	bl	HEVC_se_v
	add	r3, r0, #6
	mov	r2, r0
	cmp	r3, #12
	str	r0, [r4, #80]
	bls	.L2343
	ldr	r1, .L2411+84
	mov	r0, #1
	bl	dprint_vfmw
	mov	r3, #0
	str	r3, [r4, #80]
	b	.L2343
.L2315:
	ldr	r7, [r4, #68]
	cmp	r7, #0
	addgt	r3, r4, #174
	movgt	r8, #0
	ble	.L2305
.L2323:
	ldr	r10, [r6, #240]
	add	r8, r8, #1
	mov	r1, r7
	str	r3, [fp, #-48]
	mul	r0, r10, r8
	bl	__aeabi_uidiv
	mov	r1, r7
	mov	r9, r0
	sub	r0, r8, #1
	mul	r0, r0, r10
	bl	__aeabi_uidiv
	ldr	r3, [fp, #-48]
	cmp	r8, r7
	rsb	r0, r0, r9
	strh	r0, [r3, #2]!
	bne	.L2323
.L2305:
	ldr	r10, [r4, #72]
	cmp	r10, #0
	addgt	r2, r4, #214
	movgt	r8, #0
	ble	.L2322
.L2324:
	ldr	r3, [r6, #244]
	add	r8, r8, #1
	mov	r1, r10
	str	r2, [fp, #-52]
	mul	r0, r3, r8
	str	r3, [fp, #-48]
	bl	__aeabi_uidiv
	ldr	r3, [fp, #-48]
	mov	r1, r10
	mov	r9, r0
	sub	r0, r8, #1
	mul	r0, r0, r3
	bl	__aeabi_uidiv
	ldr	r2, [fp, #-52]
	cmp	r8, r10
	rsb	r0, r0, r9
	strh	r0, [r2, #2]!
	bne	.L2324
.L2322:
	cmp	r7, #1
	bne	.L2330
	ldr	r0, [r4, #72]
	cmp	r0, #1
	beq	.L2331
.L2330:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	strb	r0, [r4, #16]
	b	.L2332
.L2284:
	mov	r2, r0
	ldr	r1, .L2411+88
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2379
.L2391:
	mov	r2, r0
	ldr	r1, .L2411+92
	mov	r0, r7
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2379
.L2392:
	mov	r0, r7
	ldr	r1, .L2411+96
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2379
.L2393:
	mov	r0, r7
	ldr	r1, .L2411+100
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2379
.L2396:
	ldr	r1, .L2411+104
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2379
.L2397:
	ldr	r1, .L2411+108
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2379
.L2347:
	ldr	r1, .L2411+112
	mov	r0, #1
	bl	dprint_vfmw
	b	.L2383
.L2406:
	ldr	r3, [r4, #72]
	sub	r3, r3, #1
	cmp	r3, #0
	ble	.L2309
.L2308:
	add	r8, r4, #130
	mov	r7, #0
	b	.L2320
.L2409:
	cmp	r3, r2
	bhi	.L2318
	ldr	r3, [r4, #72]
	add	r7, r7, #1
	sub	r3, r3, #1
	cmp	r3, r7
	ble	.L2309
.L2320:
	ldr	r1, .L2411+116
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	add	r0, r0, #1
	uxth	r3, r0
	strh	r3, [r8, #2]!
	ldr	r2, [r6, #244]
	sxth	r3, r3
	cmp	r3, #0
	bge	.L2409
.L2318:
	str	r2, [sp]
	mov	r0, #1
	mov	r2, r7
	ldr	r1, .L2411+120
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2379
.L2402:
	mov	r3, #20
	ldr	r1, .L2411+124
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2379
.L2408:
	ldr	r1, .L2411+128
	mov	r0, #1
	bl	dprint_vfmw
	str	r7, [r4, #76]
	b	.L2345
.L2309:
	ldrb	r3, [r4, #15]
	cmp	r3, #0
	bne	.L2315
.L2316:
	ldr	r7, [r4, #68]
	ldrh	r3, [r6, #240]
	sub	r2, r7, #1
	add	ip, r4, r7, lsl #1
	cmp	r2, #0
	strh	r3, [ip, #174]
	ble	.L2325
	add	r8, r7, #44
	add	r1, r4, #90
	add	lr, r4, #174
	add	r8, r4, r8, lsl #1
.L2326:
	ldrh	r0, [r1, #2]!
	cmp	r1, r8
	strh	r0, [lr, #2]!
	ldrh	r3, [ip, #174]
	rsb	r3, r0, r3
	uxth	r3, r3
	strh	r3, [ip, #174]
	bne	.L2326
.L2325:
	sxth	r3, r3
	cmp	r3, #0
	ble	.L2410
	ldr	r1, [r4, #72]
	ldrh	r3, [r6, #244]
	sub	r2, r1, #1
	add	ip, r4, r1, lsl #1
	cmp	r2, #0
	strh	r3, [ip, #214]
	ble	.L2328
	add	r8, r1, #64
	add	lr, r4, #214
	add	r1, r4, #130
	add	r8, r4, r8, lsl #1
.L2329:
	ldrh	r0, [r1, #2]!
	cmp	r1, r8
	strh	r0, [lr, #2]!
	ldrh	r3, [ip, #214]
	rsb	r3, r0, r3
	uxth	r3, r3
	strh	r3, [ip, #214]
	bne	.L2329
.L2328:
	sxth	r3, r3
	cmp	r3, #0
	bgt	.L2322
	ldr	r1, .L2411+132
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2379
.L2403:
	mov	r2, r3
	ldr	r1, .L2411+136
	mov	r3, #22
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2379
.L2401:
	ldr	r1, .L2411+140
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2379
.L2405:
	ldr	r3, [r4, #72]
	sub	r3, r3, #1
	cmp	r3, #0
	bgt	.L2308
	b	.L2316
.L2410:
	ldr	r1, .L2411+144
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2379
.L2412:
	.align	2
.L2411:
	.word	.LC275
	.word	.LC278
	.word	.LC280
	.word	.LC282
	.word	.LC286
	.word	.LC288
	.word	.LC309
	.word	.LC284
	.word	.LC285
	.word	.LC290
	.word	.LC292
	.word	.LC295
	.word	g_event_report
	.word	.LC303
	.word	.LC302
	.word	.LC283
	.word	.LC296
	.word	.LC297
	.word	.LC294
	.word	.LC304
	.word	.LC306
	.word	.LC307
	.word	.LC276
	.word	.LC277
	.word	.LC279
	.word	.LC281
	.word	.LC287
	.word	.LC289
	.word	.LC310
	.word	.LC298
	.word	.LC299
	.word	.LC291
	.word	.LC305
	.word	.LC301
	.word	.LC293
	.word	.LC308
	.word	.LC300
	.fnend
	.size	HEVC_ProcessPPS, .-HEVC_ProcessPPS
	.align	2
	.global	HEVC_DecPPS
	.type	HEVC_DecPPS, %function
HEVC_DecPPS:
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
	ldr	r1, .L2423
	mov	r4, r0
	ldr	r0, [r0, #2308]
	bl	HEVC_ue_v
	ldr	r3, [r4, #156]
	cmp	r0, r3
	mov	r6, r0
	bcs	.L2419
	movw	r7, #2024
	ldr	r3, [r4, #2320]
	mul	r5, r7, r0
	add	r2, r3, r5
	ldrb	r9, [r3, r5]
	cmp	r9, #0
	bne	.L2420
	str	r0, [r2, #28]
	mov	r0, r4
	ldr	r1, [r4, #2320]
	add	r1, r1, r5
	bl	HEVC_ProcessPPS
	subs	r8, r0, #0
	bne	.L2421
	ldr	r3, [r4, #2320]
	mov	r2, #1
	add	r3, r3, r5
	strb	r2, [r3, #1]
	ldr	r3, [r4, #2320]
	strb	r2, [r3, r5]
.L2415:
	mov	r0, r8
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2420:
	ldr	r9, .L2423+4
	mov	r0, r4
	ldr	r1, .L2423+8
	str	r6, [r9, #-3436]
	bl	HEVC_ProcessPPS
	subs	r8, r0, #0
	bne	.L2422
	ldr	ip, .L2423+12
	mov	r3, #1
	ldr	r0, [r4, #2320]
	mov	r2, r7
	ldr	r1, .L2423+8
	add	r0, r0, r5
	ldr	ip, [ip, #56]
	strb	r3, [r9, #-3463]
	strb	r3, [r9, #-3464]
	blx	ip
	mov	r0, r8
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2422:
	mov	r2, r6
	ldr	r1, .L2423+16
	mov	r0, #1
	mvn	r8, #0
	bl	dprint_vfmw
	b	.L2415
.L2419:
	mov	r2, r0
	ldr	r1, .L2423+20
	mov	r0, #1
	mvn	r8, #0
	bl	dprint_vfmw
	b	.L2415
.L2421:
	mov	r2, r6
	ldr	r1, .L2423+16
	mov	r0, #1
	mvn	r8, #0
	bl	dprint_vfmw
	ldr	r3, [r4, #2320]
	mov	r2, #1
	add	r3, r3, r5
	strb	r2, [r3, #1]
	ldr	r3, [r4, #2320]
	strb	r9, [r3, r5]
	b	.L2415
.L2424:
	.align	2
.L2423:
	.word	.LC311
	.word	.LANCHOR5
	.word	.LANCHOR5-3464
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC313
	.word	.LC312
	.fnend
	.size	HEVC_DecPPS, .-HEVC_DecPPS
	.align	2
	.global	HEVC_DecPredWeightTable
	.type	HEVC_DecPredWeightTable, %function
HEVC_DecPredWeightTable:
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
	add	r9, r0, #53248
	ldr	r2, [r0, #2320]
	movw	ip, #2024
	mov	r5, r0
	ldr	r1, [r9, #996]
	ldr	r0, [r9, #980]
	ldr	r4, [r5, #2316]
	mla	r2, ip, r1, r2
	cmp	r0, #1
	ldr	r6, [r2, #32]
	beq	.L2491
	cmp	r0, #0
	bne	.L2429
	ldrb	r2, [r2, #11]
	cmp	r2, #0
	beq	.L2429
.L2427:
	ldr	r1, .L2502
	ldr	r0, [r5, #2308]
	bl	HEVC_ue_v
	cmp	r0, #7
	str	r0, [r9, #2512]
	bhi	.L2492
	movw	r2, #26164
	mla	r8, r2, r6, r4
	ldr	r2, [r8, #64]
	cmp	r2, #0
	ldreq	r2, [r9, #2516]
	bne	.L2493
.L2433:
	ldr	r1, [r9, #1088]
	add	r2, r2, r0
	str	r2, [r9, #3544]
	cmp	r1, #0
	beq	.L2434
	add	r4, r5, #55552
	mov	r6, #0
	add	r4, r4, #212
	mov	r7, r4
.L2435:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	add	r6, r6, #1
	str	r0, [r7, #4]!
	ldr	r2, [r9, #1088]
	cmp	r2, r6
	bhi	.L2435
	ldr	r1, [r8, #64]
	cmp	r1, #0
	beq	.L2436
	cmp	r2, #0
	addne	r7, r5, #55808
	movne	r6, #0
	addne	r7, r7, #20
	beq	.L2434
.L2440:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	add	r6, r6, #1
	str	r0, [r7, #4]!
	ldr	r2, [r9, #1088]
	cmp	r2, r6
	bhi	.L2440
.L2436:
	cmp	r2, #0
	beq	.L2434
	add	r6, r5, #55808
	mov	r7, #0
	add	r6, r6, #216
	mov	r3, r9
	str	r5, [fp, #-48]
	mov	r9, r8
	mov	r10, #1
	mov	r8, r7
	mov	r5, r6
	mov	r7, r3
	b	.L2451
.L2441:
	ldr	r1, [r7, #2512]
	str	r0, [r4, #192]
	mov	r1, r10, asl r1
	str	r1, [r4, #1028]
.L2443:
	ldr	r1, [r9, #64]
	cmp	r1, #0
	beq	.L2445
	ldr	r1, [r4, #64]
	cmp	r1, #0
	bne	.L2446
	ldr	r0, [r7, #3544]
	str	r1, [r5, #964]
	mov	r0, r10, asl r0
	str	r1, [r5, #968]
	str	r0, [r5, #836]
	str	r0, [r5, #840]
.L2445:
	ldr	r1, [r7, #1088]
	add	r8, r8, #1
	add	r5, r5, #8
	cmp	r1, r8
	bls	.L2494
.L2451:
	ldr	r0, [r4, #4]!
	cmp	r0, #0
	beq	.L2441
	ldr	r3, [fp, #-48]
	ldr	r1, .L2502+4
	ldr	r0, [r3, #2308]
	bl	HEVC_se_v
	add	r1, r0, #128
	str	r0, [r4, #128]
	cmp	r1, #255
	bhi	.L2495
	ldr	r3, [fp, #-48]
	ldr	lr, [r7, #2512]
	ldr	r1, .L2502+8
	add	r0, r0, r10, asl lr
	str	r0, [r4, #1028]
	ldr	r0, [r3, #2308]
	bl	HEVC_se_v
	add	r1, r0, #128
	str	r0, [r4, #192]
	cmp	r1, #255
	bls	.L2443
	mov	r2, r0
	ldr	r1, .L2502+12
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2428
.L2491:
	ldrb	r2, [r2, #10]
	cmp	r2, #0
	bne	.L2427
.L2429:
	mov	r0, #0
.L2428:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2446:
	add	r3, r5, #832
	add	r1, r5, #128
	add	r2, r5, #960
	str	r8, [fp, #-52]
	str	r9, [fp, #-56]
	mov	r8, r5
	str	r4, [fp, #-60]
	mov	r6, #0
	str	r5, [fp, #-64]
	mov	r4, r3
	mov	r9, r1
	mov	r5, r2
.L2449:
	ldr	r3, [fp, #-48]
	add	r6, r6, #1
	ldr	r1, .L2502+16
	ldr	r0, [r3, #2308]
	bl	HEVC_se_v
	ldr	r1, .L2502+20
	add	r3, r0, #128
	str	r0, [r8]
	cmp	r3, #255
	bhi	.L2496
	ldr	r3, [fp, #-48]
	ldr	r0, [r3, #2308]
	bl	HEVC_se_v
	add	r3, r0, #512
	str	r0, [r9], #4
	cmp	r3, #1024
	bcs	.L2497
	ldr	r1, [r7, #3544]
	cmp	r6, #2
	ldr	r2, [r8], #4
	add	r3, r2, r10, asl r1
	str	r3, [r4, #4]!
	mov	r3, r3, asl #7
	mov	r3, r3, asr r1
	rsb	r3, r3, #128
	add	r3, r0, r3
	ssat	r3, #8, r3
	str	r3, [r5, #4]!
	bne	.L2449
	ldr	r8, [fp, #-52]
	ldr	r9, [fp, #-56]
	ldr	r4, [fp, #-60]
	ldr	r5, [fp, #-64]
	b	.L2445
.L2494:
	ldr	r5, [fp, #-48]
	mov	r8, r9
	mov	r9, r7
.L2434:
	ldr	r4, [r9, #980]
	cmp	r4, #0
	bne	.L2429
	ldr	r2, [r9, #1092]
	cmp	r2, #0
	beq	.L2429
	add	r10, r5, #56064
	add	r10, r10, #212
	mov	r6, r10
.L2452:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	add	r4, r4, #1
	str	r0, [r6, #4]!
	ldr	r2, [r9, #1092]
	cmp	r2, r4
	bhi	.L2452
	ldr	r1, [r8, #64]
	cmp	r1, #0
	bne	.L2498
.L2453:
	cmp	r2, #0
	beq	.L2429
	add	r7, r5, #56320
	mov	r3, #0
	add	r7, r7, #216
	str	r5, [fp, #-48]
	mov	r5, r9
	mov	r9, r8
	mov	r8, r7
	mov	r7, r3
	b	.L2467
.L2457:
	ldr	r1, [r5, #2512]
	mov	r3, #1
	str	r0, [r10, #192]
	mov	r1, r3, asl r1
	str	r1, [r10, #836]
.L2459:
	ldr	r1, [r9, #64]
	cmp	r1, #0
	beq	.L2461
	ldr	r1, [r10, #64]
	cmp	r1, #0
	bne	.L2462
	ldr	r0, [r5, #3544]
	mov	r3, #1
	str	r1, [r8, #772]
	mov	r0, r3, asl r0
	str	r1, [r8, #776]
	str	r0, [r8, #644]
	str	r0, [r8, #648]
.L2461:
	ldr	r1, [r5, #1092]
	add	r7, r7, #1
	add	r8, r8, #8
	cmp	r1, r7
	bls	.L2429
.L2467:
	ldr	r0, [r10, #4]!
	cmp	r0, #0
	beq	.L2457
	ldr	r3, [fp, #-48]
	ldr	r1, .L2502+24
	ldr	r0, [r3, #2308]
	bl	HEVC_se_v
	add	r1, r0, #128
	str	r0, [r10, #128]
	cmp	r1, #255
	bhi	.L2499
	ldr	lr, [r5, #2512]
	mov	r3, #1
	ldr	r1, .L2502+28
	add	r0, r0, r3, asl lr
	ldr	r3, [fp, #-48]
	str	r0, [r10, #836]
	ldr	r0, [r3, #2308]
	bl	HEVC_se_v
	add	r1, r0, #128
	str	r0, [r10, #192]
	cmp	r1, #255
	bls	.L2459
	ldr	r1, .L2502+32
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2428
.L2462:
	add	r3, r8, #640
	add	r1, r8, #128
	add	r2, r8, #768
	str	r10, [fp, #-60]
	ldr	r10, [fp, #-48]
	mov	r6, r8
	str	r8, [fp, #-52]
	mov	r4, #0
	str	r9, [fp, #-56]
	mov	r8, r2
	str	r7, [fp, #-64]
	mov	r9, r1
	mov	r7, r3
.L2465:
	ldr	r1, .L2502+36
	add	r4, r4, #1
	ldr	r0, [r10, #2308]
	bl	HEVC_se_v
	ldr	r1, .L2502+40
	add	r3, r0, #128
	str	r0, [r6]
	cmp	r3, #255
	bhi	.L2500
	ldr	r0, [r10, #2308]
	bl	HEVC_se_v
	add	r3, r0, #512
	str	r0, [r9], #4
	cmp	r3, #1024
	bcs	.L2501
	ldr	r1, [r5, #3544]
	mov	r3, #1
	ldr	r2, [r6], #4
	cmp	r4, #2
	add	r3, r2, r3, asl r1
	str	r3, [r7, #4]!
	mov	r3, r3, asl #7
	mov	r3, r3, asr r1
	rsb	r3, r3, #128
	add	r3, r0, r3
	ssat	r3, #8, r3
	str	r3, [r8, #4]!
	bne	.L2465
	ldr	r8, [fp, #-52]
	ldr	r9, [fp, #-56]
	ldr	r10, [fp, #-60]
	ldr	r7, [fp, #-64]
	b	.L2461
.L2493:
	ldr	r1, .L2502+44
	ldr	r0, [r5, #2308]
	bl	HEVC_se_v
	add	r1, r0, #7
	mov	r2, r0
	cmp	r1, #14
	str	r0, [r9, #2516]
	bhi	.L2432
	ldr	r0, [r9, #2512]
	b	.L2433
.L2496:
	ldr	r1, .L2502+48
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2497:
	ldr	r1, .L2502+52
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2498:
	cmp	r2, #0
	addne	r6, r5, #56320
	movne	r4, #0
	addne	r6, r6, #20
	beq	.L2429
.L2456:
	mov	r1, #1
	ldr	r0, [r5, #2308]
	bl	BsGet
	add	r4, r4, #1
	str	r0, [r6, #4]!
	ldr	r2, [r9, #1092]
	cmp	r2, r4
	bhi	.L2456
	b	.L2453
.L2495:
	mov	r2, r0
	ldr	r1, .L2502+56
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2428
.L2500:
	ldr	r1, .L2502+60
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2428
.L2501:
	ldr	r1, .L2502+64
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2428
.L2499:
	ldr	r1, .L2502+68
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2428
.L2492:
	ldr	r1, .L2502+72
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2428
.L2432:
	ldr	r1, .L2502+76
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2428
.L2503:
	.align	2
.L2502:
	.word	.LC314
	.word	.LC318
	.word	.LC320
	.word	.LC321
	.word	.LC322
	.word	.LC324
	.word	.LC326
	.word	.LC328
	.word	.LC329
	.word	.LC330
	.word	.LC332
	.word	.LC316
	.word	.LC323
	.word	.LC325
	.word	.LC319
	.word	.LC331
	.word	.LC333
	.word	.LC327
	.word	.LC315
	.word	.LC317
	.fnend
	.size	HEVC_DecPredWeightTable, .-HEVC_DecPredWeightTable
	.align	2
	.global	HEVC_ClearCurrNal
	.type	HEVC_ClearCurrNal, %function
HEVC_ClearCurrNal:
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
	ldr	r1, [r0, #2332]
	mov	r4, r0
	cmp	r1, #0
	beq	.L2505
	ldr	r0, [r0, #244]
	bl	HEVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #2332]
.L2505:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	HEVC_ClearCurrNal, .-HEVC_ClearCurrNal
	.align	2
	.global	HEVC_FrameStoreRefFlg
	.type	HEVC_FrameStoreRefFlg, %function
HEVC_FrameStoreRefFlg:
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
	ldrb	r0, [r0, #1]
	adds	r0, r0, #0
	movne	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_FrameStoreRefFlg, .-HEVC_FrameStoreRefFlg
	.align	2
	.global	HEVC_ClearCurrSlice
	.type	HEVC_ClearCurrSlice, %function
HEVC_ClearCurrSlice:
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
	ldr	r1, [r0, #2332]
	mov	r4, r0
	cmp	r1, #0
	beq	.L2511
	ldr	r0, [r0, #244]
	bl	HEVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #2332]
.L2511:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	HEVC_ClearCurrSlice, .-HEVC_ClearCurrSlice
	.align	2
	.global	HEVC_ClearAllSlice
	.type	HEVC_ClearAllSlice, %function
HEVC_ClearAllSlice:
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
	ldr	r3, [r0, #160]
	mov	r7, r0
	cmp	r3, #0
	beq	.L2519
	mov	r4, #0
	add	r8, r0, #65536
	mov	r5, r4
	mov	r6, r4
.L2518:
	ldr	r3, [r8, #2540]
	add	r5, r5, #1
	add	r3, r3, r4
	ldr	r1, [r3, #24]
	cmp	r1, #0
	beq	.L2517
	ldr	r0, [r7, #244]
	bl	HEVC_ReleaseNAL
	ldr	r3, [r8, #2540]
	add	r3, r3, r4
	str	r6, [r3, #24]
.L2517:
	ldr	r3, [r7, #160]
	add	r4, r4, #28
	cmp	r3, r5
	bhi	.L2518
.L2519:
	mov	r0, #0
	mov	r3, #2
	str	r0, [r7, #208]
	str	r0, [r7, #224]
	str	r0, [r7, #216]
	strb	r0, [r7, #9]
	str	r3, [r7, #172]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	HEVC_ClearAllSlice, .-HEVC_ClearAllSlice
	.align	2
	.global	HEVC_InitDPB
	.type	HEVC_InitDPB, %function
HEVC_InitDPB:
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
	mov	r5, r0
	mov	r8, r1
	bl	HEVC_ClearAllSlice
	add	r9, r5, #2512
	add	r9, r9, #12
	mov	r4, r5
	mov	r6, #17
	mov	r7, #0
.L2530:
	ldr	r3, [r9, #4]!
	mov	r2, #1
	cmp	r3, #0
	beq	.L2526
	ldr	r1, [r3, #32]
	ldr	r0, [r5, #244]
	bl	FSP_ClearLogicFs
.L2526:
	ldr	r3, [r4, #2596]
	mov	r2, #1
	cmp	r3, #0
	beq	.L2527
	ldr	r1, [r3, #32]
	ldr	r0, [r5, #244]
	bl	FSP_ClearLogicFs
.L2527:
	ldr	r3, [r4, #2664]
	mov	r2, #1
	cmp	r3, #0
	beq	.L2528
	ldr	r1, [r3, #32]
	ldr	r0, [r5, #244]
	bl	FSP_ClearLogicFs
.L2528:
	ldr	r3, [r4, #2732]
	mov	r2, #1
	cmp	r3, #0
	beq	.L2529
	ldr	r1, [r3, #32]
	ldr	r0, [r5, #244]
	bl	FSP_ClearLogicFs
.L2529:
	subs	r6, r6, #1
	str	r7, [r4, #2732]
	str	r7, [r4, #2664]
	add	r4, r4, #4
	str	r7, [r4, #2592]
	str	r7, [r4, #2524]
	bne	.L2530
	add	r4, r5, #24576
	mov	r7, #0
	mov	r1, r7
	mov	r2, #200
	ldr	r3, [r4, #2780]
	add	r0, r5, #2800
	ldr	r3, [r3, #236]
	str	r7, [r5, #2508]
	add	r3, r3, #1
	str	r7, [r5, #2520]
	cmp	r3, #17
	str	r7, [r5, #2524]
	str	r7, [r5, #2516]
	movhi	r3, #17
	str	r3, [r5, #2504]
	ldr	r3, .L2572
	str	r7, [r5, #2512]
	ldr	r3, [r3, #48]
	blx	r3
	add	r2, r5, #2320
	add	r2, r2, #12
	add	r3, r5, #2400
	mov	r0, r7
	mov	r1, #16
	str	r7, [r5, #2804]
	str	r1, [r5, #2800]
.L2533:
	str	r0, [r2, #4]!
	cmp	r2, r3
	mov	r1, #0
	bne	.L2533
	add	r2, r5, #2464
	add	ip, r5, #53248
	add	r2, r2, #4
	mov	r0, r1
	str	r1, [ip, #1080]
.L2534:
	str	r0, [r3, #4]!
	cmp	r3, r2
	mov	r1, #0
	bne	.L2534
	cmp	r8, r1
	str	r1, [ip, #1084]
	bne	.L2535
	ldr	r3, [r5, #2324]
	ldr	r3, [r3, #864]
	cmp	r3, #1
	beq	.L2535
.L2536:
	ldr	r1, [r5, #180]
	cmp	r1, #0
	addne	r2, r5, #2112
	movne	r3, #0
	movne	r0, r3
	beq	.L2544
.L2543:
	add	r3, r3, #1
	str	r0, [r2, #4]!
	cmp	r3, r1
	bne	.L2543
.L2544:
	ldr	r3, [r5, #160]
	cmp	r3, #0
	addne	r8, r5, #65536
	movne	r4, #0
	movne	r7, r4
	beq	.L2542
.L2546:
	ldr	r3, [r8, #2540]
	add	r4, r4, #1
	add	r3, r3, r6
	ldr	r3, [r3, #24]
	cmp	r3, #0
	mov	r1, r3
	beq	.L2545
	ldr	r2, [r5, #2332]
	cmp	r3, r2
	beq	.L2545
	ldr	r0, [r5, #244]
	bl	HEVC_ReleaseNAL
	ldr	r3, [r8, #2540]
	add	r3, r3, r6
	str	r7, [r3, #24]
.L2545:
	ldr	r3, [r5, #160]
	add	r6, r6, #28
	cmp	r3, r4
	bhi	.L2546
.L2542:
	mov	r0, #0
.L2537:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2535:
	mov	r7, #20
	str	r7, [r5, #176]
	str	r7, [r5, #180]
	mov	r0, r5
	ldr	r1, [r4, #2780]
	ldr	r3, [r1, #240]
	ldr	ip, [r1, #244]
	ldr	r2, [r1, #148]
	str	r7, [sp, #8]
	mov	r1, r3, asl r2
	str	ip, [sp]
	mov	r2, ip, asl r2
	str	r7, [sp, #4]
	bl	HEVC_ArrangeVahbMem
	ldr	r3, [r5, #2324]
	ldr	r3, [r3, #864]
	cmp	r3, #1
	beq	.L2547
	cmp	r0, #1
	bne	.L2570
	ldr	r0, [r5, #244]
	bl	FSP_GetTotalValidFsNum
	cmp	r0, #20
	movgt	r0, r7
	ble	.L2571
.L2539:
	str	r0, [r5, #176]
	b	.L2536
.L2571:
	ldr	r0, [r5, #244]
	bl	FSP_GetTotalValidFsNum
	b	.L2539
.L2570:
	ldr	r2, .L2572+4
	mov	r0, #0
	ldr	r1, .L2572+8
	bl	dprint_vfmw
	mvn	r0, #4
	b	.L2537
.L2547:
	mvn	r0, #1
	b	.L2537
.L2573:
	.align	2
.L2572:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR1+504
	.word	.LC334
	.fnend
	.size	HEVC_InitDPB, .-HEVC_InitDPB
	.align	2
	.global	HEVC_ClearAllNal
	.type	HEVC_ClearAllNal, %function
HEVC_ClearAllNal:
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
	ldr	r3, [r0, #160]
	mov	r6, r0
	cmn	r3, #1
	beq	.L2578
	mov	r4, #0
	add	r7, r0, #65536
	mov	r5, r4
	b	.L2577
.L2576:
	ldr	r3, [r6, #160]
	add	r3, r3, #1
	cmp	r3, r5
	bls	.L2578
.L2577:
	ldr	r1, [r7, #1736]
	add	r5, r5, #1
	add	r1, r1, r4
	add	r4, r4, #100
	ldr	r3, [r1, #36]
	cmp	r3, #1
	bne	.L2576
	ldr	r0, [r6, #244]
	bl	HEVC_ReleaseNAL
	ldr	r3, [r6, #160]
	add	r3, r3, #1
	cmp	r3, r5
	bhi	.L2577
.L2578:
	mov	r0, #0
	strb	r0, [r6, #5]
	str	r0, [r6, #140]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	HEVC_ClearAllNal, .-HEVC_ClearAllNal
	.align	2
	.global	HEVC_InitDecPara
	.type	HEVC_InitDecPara, %function
HEVC_InitDecPara:
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
	ldr	r1, .L2594
	mov	r4, r0
	mov	r0, #22
	bl	dprint_vfmw
	mov	r3, #-2147483647
	mov	r0, r4
	str	r3, [r4, #212]
	bl	HEVC_ClearAllNal
	add	r0, r4, #61440
	add	r0, r0, #192
	add	r5, r4, #67584
	bl	ResetVoQueue
	ldr	r6, .L2594+4
	mov	r8, #0
	add	r5, r5, #568
	mov	r9, #20
	mov	r7, r8
.L2582:
	strb	r7, [r5, #-72]
	mov	r3, #16
	str	r7, [r5, #-68]
	mov	r0, r5
	strb	r7, [r5, #-71]
	mov	r2, #592
	str	r7, [r5, #-60]
	mov	r1, #0
	strb	r7, [r5, #-70]
	str	r9, [r5, #-48]
	str	r3, [r5, #-44]
	ldr	r3, [r6, #48]
	blx	r3
	str	r8, [r5, #156]
	add	r8, r8, #1
	sub	r3, r5, #72
	cmp	r8, #20
	str	r7, [r5, #-24]
	str	r3, [r5, #-4]
	add	r5, r5, #664
	bne	.L2582
	add	r3, r4, #2112
	add	r1, r4, #2192
	mov	r2, #0
.L2583:
	str	r2, [r3, #4]!
	cmp	r3, r1
	bne	.L2583
	ldr	r3, [r4, #160]
	cmp	r3, #0
	addne	ip, r4, #65536
	movne	r3, #0
	movne	r0, r3
	movne	r1, r3
	beq	.L2587
.L2586:
	ldr	r2, [ip, #2540]
	add	r0, r0, #1
	str	r1, [r2, r3]
	ldr	r2, [ip, #2540]
	add	r2, r2, r3
	str	r1, [r2, #20]
	ldr	r2, [ip, #2540]
	add	r2, r2, r3
	add	r3, r3, #28
	str	r1, [r2, #24]
	ldr	r2, [r4, #160]
	cmp	r2, r0
	bhi	.L2586
.L2587:
	ldr	r3, [r6, #48]
	mov	r2, #200
	mov	r1, #0
	add	r0, r4, #2800
	blx	r3
	add	ip, r4, #2720
	add	r0, r4, #2656
	add	r1, r4, #2512
	add	ip, ip, #8
	add	r0, r0, #4
	add	r1, r1, #12
	add	lr, r4, #2592
	mov	r3, #16
	mov	r2, #17
	str	r3, [r4, #2800]
	mov	r3, #0
.L2585:
	subs	r2, r2, #1
	str	r3, [ip, #4]!
	str	r3, [r0, #4]!
	str	r3, [lr, #4]!
	str	r3, [r1, #4]!
	bne	.L2585
	add	r1, r4, #2320
	add	ip, r4, #2464
	add	r1, r1, #12
	add	ip, ip, #4
	add	r3, r4, #2400
	mov	r0, r2
	mov	lr, #17
	str	r2, [r4, #2508]
	str	r2, [r4, #2512]
	str	r2, [r4, #2516]
	str	r2, [r4, #2520]
	str	r2, [r4, #2524]
	str	lr, [r4, #2504]
.L2588:
	str	r0, [r3, #4]!
	cmp	r3, ip
	str	r0, [r1, #4]!
	mov	r5, #0
	bne	.L2588
	add	r0, r4, #54016
	mov	r9, #2
	mov	r1, r5
	ldr	r3, [r6, #48]
	str	r5, [r4, #2332]
	movw	r2, #3732
	str	r5, [r4, #208]
	add	r0, r0, #152
	str	r5, [r4, #224]
	add	r7, r4, #2464
	str	r5, [r4, #216]
	add	r7, r7, #8
	str	r9, [r4, #172]
	mov	r8, #32
	blx	r3
	add	r2, r4, #53248
	mov	r3, #1
	mov	lr, #20
	str	r9, [r2, #980]
	mov	ip, #16
	str	r3, [r2, #2508]
	mov	r1, r5
	strb	r3, [r4, #1]
	mov	r2, r8
	strb	r3, [r4, #3]
	mov	r0, r7
	mov	r3, #8
	strb	r5, [r4, #4]
	strb	r5, [r4, #2]
	mov	r10, #64
	strb	r5, [r4, #8]
	str	r9, [r4, #2208]
	mvn	r9, #-2147483648
	str	r5, [r4, #168]
	movw	r5, #1025
	str	r8, [r4, #320]
	mov	r8, #4
	str	lr, [r4, #176]
	str	lr, [r4, #180]
	mov	lr, #6
	str	r3, [r4, #192]
	str	r3, [r4, #196]
	str	r3, [r4, #312]
	mov	r3, #256
	ldr	r6, [r6, #48]
	str	r9, [r4, #200]
	str	ip, [r4, #292]
	str	ip, [r4, #316]
	str	r10, [r4, #296]
	str	r3, [r4, #300]
	str	r5, [r4, #304]
	str	r8, [r4, #308]
	str	lr, [r4, #2196]
	str	lr, [r4, #2200]
	str	lr, [r4, #2204]
	blx	r6
	str	r7, [r4, #2308]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2595:
	.align	2
.L2594:
	.word	.LC335
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	HEVC_InitDecPara, .-HEVC_InitDecPara
	.align	2
	.global	HEVCDEC_Init
	.type	HEVCDEC_Init, %function
HEVCDEC_Init:
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
	add	r8, r0, #61440
	ldr	r7, .L2609
	movw	r2, #19304
	mov	r4, r0
	ldr	r5, [r8, #536]
	mov	r9, r1
	ldr	r3, [r7, #48]
	movt	r2, 1
	mov	r1, #0
	blx	r3
	str	r5, [r8, #536]
	mov	r3, #0
	str	r9, [r4, #2324]
	str	r3, [r4, #2328]
	ldr	r3, [r9, #28]
	cmp	r3, #25
	beq	.L2604
	mov	r3, #17
	mov	r1, #65
	str	r3, [r4, #148]
	mov	r2, #200
	str	r3, [r4, #152]
	mov	r3, #210
	str	r1, [r4, #156]
	str	r2, [r4, #144]
	str	r3, [r4, #160]
.L2598:
	ldr	r0, [r9, #580]
	bl	MEM_Phy2Vir
	subs	r5, r0, #0
	beq	.L2605
	ldr	r3, [r4, #148]
	movw	r2, #23196
	ldr	r10, [r4, #2324]
	add	r6, r4, #65536
	ldr	r0, [r4, #152]
	mov	lr, #100
	mul	r3, r2, r3
	ldr	ip, [r10, #576]
	ldr	r2, [r4, #156]
	add	r1, r5, ip
	str	r1, [r4, #2312]
	add	ip, r3, ip
	str	r3, [fp, #-52]
	add	r3, r5, ip
	str	r3, [r4, #2316]
	movw	r3, #26164
	mla	ip, r3, r0, ip
	add	r3, r5, ip
	str	r3, [r4, #2320]
	movw	r3, #2024
	mla	ip, r3, r2, ip
	mov	r3, #1360
	add	r0, r5, ip
	str	r0, [r6, #1732]
	ldr	r2, [r4, #144]
	mul	r2, r3, r2
	add	ip, ip, r2
	add	r3, r5, ip
	str	r3, [r6, #1736]
	ldr	r3, [r4, #160]
	mla	lr, r3, lr, lr
	mov	r3, r3, asl #5
	str	lr, [fp, #-48]
	ldr	lr, [r4, #160]
	sub	r3, r3, lr, asl #2
	ldr	lr, [fp, #-48]
	add	ip, ip, lr
	add	r5, r5, ip
	str	r5, [r6, #2540]
	ldr	r5, [r10, #584]
	add	r3, ip, r3
	cmp	r3, r5
	bhi	.L2606
	ldr	r5, [r9, #604]
	cmp	r5, #0
	beq	.L2607
.L2602:
	ldr	r3, [r7, #48]
	mov	r1, #0
	blx	r3
	ldr	ip, [r4, #160]
	mov	r2, #100
	ldr	r3, [r7, #48]
	mov	r1, #0
	ldr	r0, [r6, #1736]
	mla	r2, ip, r2, r2
	blx	r3
	ldr	r3, [r4, #160]
	ldr	ip, [r7, #48]
	mov	r1, #0
	ldr	r0, [r6, #2540]
	mov	r5, #1
	mov	r2, r3, asl #5
	sub	r2, r2, r3, asl #2
	blx	ip
	ldr	lr, [r4, #148]
	movw	r3, #23196
	ldr	r6, [r4, #2312]
	add	ip, r4, #24576
	movw	r1, #2024
	mul	r3, r3, lr
	movw	r2, #26164
	mov	r0, r4
	sub	r3, r3, #23040
	sub	r3, r3, #156
	add	r6, r6, r3
	str	r6, [ip, #2776]
	ldr	r3, [r4, #156]
	ldr	r7, [r4, #2320]
	mul	r3, r1, r3
	sub	r3, r3, #2016
	sub	r3, r3, #8
	add	r3, r7, r3
	str	r3, [ip, #2784]
	ldr	r3, [r4, #152]
	ldr	r1, [r4, #2316]
	mul	r3, r2, r3
	sub	r3, r3, #26112
	sub	r3, r3, #52
	add	r3, r1, r3
	str	r3, [ip, #2780]
	str	lr, [r6, #8]
	ldr	r3, [ip, #2784]
	ldr	r2, [r4, #152]
	str	r2, [r3, #28]
	ldr	r3, [ip, #2780]
	ldr	r2, [r4, #156]
	str	r2, [r3, #60]
	bl	HEVC_InitScalingOrderTable
	add	r3, r4, #81920
	mov	r0, r4
	str	r5, [r3, #2916]
	bl	VCTRL_GetChanIDByCtx
	cmn	r0, #1
	str	r0, [r4, #244]
	beq	.L2608
	mov	r3, #-2147483647
	mov	r0, r4
	str	r3, [r4, #212]
	bl	HEVC_InitDecPara
	mov	r0, #0
	str	r0, [r8, #544]
	movw	r2, #9999
	ldr	r3, [r4, #156]
	strb	r5, [r4]
	str	r2, [r4, #252]
	str	r3, [r4, #288]
.L2600:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2607:
	ldr	r2, [fp, #-52]
	mov	r0, r1
	ldr	r3, [r7, #48]
	mov	r1, r5
	blx	r3
	ldr	r2, [r4, #152]
	movw	ip, #26164
	ldr	r3, [r7, #48]
	mov	r1, r5
	ldr	r0, [r4, #2316]
	mul	r2, ip, r2
	blx	r3
	ldr	r2, [r4, #156]
	movw	ip, #2024
	ldr	r3, [r7, #48]
	mov	r1, r5
	ldr	r0, [r4, #2320]
	mul	r2, ip, r2
	blx	r3
	ldr	r2, [r4, #144]
	mov	r3, #1360
	ldr	r0, [r6, #1732]
	mul	r2, r3, r2
	b	.L2602
.L2604:
	ldr	r3, [r9, #672]
	str	r3, [r4, #148]
	ldr	r3, [r9, #676]
	str	r3, [r4, #152]
	ldr	r3, [r9, #680]
	str	r3, [r4, #156]
	ldr	r3, [r9, #668]
	add	r2, r3, #5
	str	r2, [r4, #160]
	str	r3, [r4, #144]
	b	.L2598
.L2606:
	str	r5, [sp]
	mov	r0, #0
	ldr	r2, .L2609+4
	ldr	r1, .L2609+8
	bl	dprint_vfmw
	mvn	r0, #19
	b	.L2600
.L2608:
	ldr	r2, .L2609+4
	mov	r0, #0
	ldr	r1, .L2609+12
	bl	dprint_vfmw
	mvn	r0, #19
	b	.L2600
.L2605:
	ldr	r2, .L2609+4
	ldr	r1, .L2609+16
	bl	dprint_vfmw
	mvn	r0, #19
	b	.L2600
.L2610:
	.align	2
.L2609:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR1+520
	.word	.LC337
	.word	.LC338
	.word	.LC336
	.fnend
	.size	HEVCDEC_Init, .-HEVCDEC_Init
	.align	2
	.global	HEVC_ClearCurrPic
	.type	HEVC_ClearCurrPic, %function
HEVC_ClearCurrPic:
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
	add	r4, r0, #53248
	mov	r5, r0
	bl	HEVC_ClearAllSlice
	ldr	r3, [r4, #324]
	cmp	r3, #0
	beq	.L2612
	ldr	r1, [r3, #32]
	mov	r2, #1
	ldr	r0, [r5, #244]
	bl	FSP_ClearLogicFs
	ldr	r2, [r4, #324]
	mov	r3, #0
	str	r3, [r2, #4]
	str	r3, [r4, #324]
.L2612:
	mov	r0, #0
	strb	r0, [r4, #281]
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	HEVC_ClearCurrPic, .-HEVC_ClearCurrPic
	.align	2
	.global	HEVC_ClearAll
	.type	HEVC_ClearAll, %function
HEVC_ClearAll:
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
	mov	r5, r1
	bl	HEVC_ClearCurrPic
	mov	r0, r4
	mov	r1, #0
	bl	HEVC_InitDPB
	cmp	r5, #0
	bne	.L2619
	add	r0, r4, #61440
	add	r0, r0, #192
	bl	ResetVoQueue
	ldr	r0, [r4, #244]
	bl	FSP_EmptyInstance
.L2618:
	mov	r0, r4
	bl	HEVC_InitDecPara
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L2619:
	add	r1, r4, #61440
	ldr	r0, [r4, #244]
	add	r1, r1, #192
	bl	FSP_ClearNotInVoQueue
	b	.L2618
	.fnend
	.size	HEVC_ClearAll, .-HEVC_ClearAll
	.align	2
	.global	HEVC_InitPic
	.type	HEVC_InitPic, %function
HEVC_InitPic:
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
	ldr	r3, [r0, #256]
	mov	r4, r0
	add	r9, r0, #24576
	add	r5, r0, #53248
	str	r3, [fp, #-60]
	ldr	r3, [r4, #260]
	ldr	r2, [r9, #2780]
	ldr	r0, [r5, #996]
	str	r3, [fp, #-48]
	ldr	r3, [r4, #264]
	cmp	r0, #0
	str	r3, [fp, #-52]
	ldr	r3, [r2, #100]
	str	r3, [fp, #-64]
	ldr	r3, [r2, #108]
	str	r3, [fp, #-68]
	ldr	r3, [r4, #268]
	str	r3, [fp, #-56]
	blt	.L2652
	ldr	r3, [r4, #156]
	cmp	r0, r3
	bge	.L2652
	ldr	lr, [r4, #2320]
	movw	r6, #2024
	movw	ip, #26164
	ldr	r3, [r4, #2316]
	ldr	r7, [r4, #2312]
	movw	r1, #23196
	mla	r6, r6, r0, lr
	ldr	r0, [r9, #2776]
	ldr	r0, [r0, #8]
	ldr	r10, [r6, #32]
	mul	r10, ip, r10
	add	r8, r3, r10
	ldr	ip, [r8, #52]
	mla	r1, r1, ip, r7
	ldr	ip, [r1, #8]
	cmp	r0, ip
	bne	.L2622
	ldrb	r0, [r1, #2]
	cmp	r0, #0
	beq	.L2676
.L2622:
	mov	r2, #0
	strb	r2, [r1, #2]
	ldr	r0, [r4, #148]
	movw	r7, #23196
	ldr	ip, .L2683
	mov	r2, r7
	ldr	lr, [r4, #2312]
	mul	r0, r7, r0
	ldr	ip, [ip, #52]
	str	r3, [fp, #-72]
	sub	r0, r0, #23040
	sub	r0, r0, #156
	add	r0, lr, r0
	blx	ip
	ldr	r0, [r4, #148]
	ldr	r2, [r9, #2780]
	ldr	r3, [fp, #-72]
	mul	r7, r7, r0
	ldr	r1, [r4, #2312]
	sub	r7, r7, #23040
	sub	r7, r7, #156
	add	r7, r1, r7
	str	r7, [r9, #2776]
.L2623:
	ldr	r0, [r2, #60]
	ldr	r1, [r8, #60]
	cmp	r0, r1
	bne	.L2624
	ldrb	r1, [r3, r10]
	cmp	r1, #0
	beq	.L2677
.L2624:
	mov	r2, #0
	strb	r2, [r3, r10]
	ldr	r0, [r4, #152]
	movw	r7, #26164
	ldr	r3, .L2683
	mov	r2, r7
	ldr	ip, [r4, #2316]
	mov	r1, r8
	mul	r0, r7, r0
	ldr	r3, [r3, #52]
	sub	r0, r0, #26112
	sub	r0, r0, #52
	add	r0, ip, r0
	blx	r3
	ldr	r3, [r4, #152]
	ldr	r2, [r4, #2316]
	mul	r7, r7, r3
	sub	r7, r7, #26112
	sub	r7, r7, #52
	add	r2, r2, r7
	str	r2, [r9, #2780]
	ldr	r3, [r2, #60]
	str	r3, [r4, #256]
	ldr	r3, [r2, #72]
	str	r3, [r4, #260]
	ldr	r3, [r2, #76]
	str	r3, [r4, #264]
	ldr	r3, [r2, #148]
	str	r3, [r4, #268]
.L2625:
	ldr	r3, [r2, #108]
	ldr	r2, [r2, #100]
	ldr	r1, [r4, #2324]
	cmp	r3, r2
	movcc	r3, r2
	str	r3, [r1, #876]
	ldr	r2, [r9, #2784]
	ldr	r3, [r6, #28]
	ldr	r2, [r2, #28]
	cmp	r2, r3
	beq	.L2678
.L2626:
	ldrb	r3, [r6, #13]
	mov	r7, #0
	strb	r7, [r6, #1]
	cmp	r3, r7
	beq	.L2628
	ldrb	r3, [r6, #15]
	cmp	r3, r7
	beq	.L2629
	ldr	r10, [r6, #68]
	cmp	r10, r7
	ble	.L2634
	add	ip, r6, #174
	str	r4, [fp, #-76]
	str	r6, [fp, #-72]
	mov	r4, ip
	str	r5, [fp, #-80]
.L2633:
	ldr	r6, [r8, #240]
	add	r7, r7, #1
	mov	r1, r10
	mul	r0, r6, r7
	bl	__aeabi_uidiv
	mov	r1, r10
	mov	r5, r0
	sub	r0, r7, #1
	mul	r0, r0, r6
	bl	__aeabi_uidiv
	cmp	r7, r10
	rsb	r0, r0, r5
	strh	r0, [r4, #2]!
	bne	.L2633
	ldr	r6, [fp, #-72]
	ldr	r4, [fp, #-76]
	ldr	r5, [fp, #-80]
.L2634:
	ldr	r10, [r6, #72]
	cmp	r10, #0
	ble	.L2635
	add	ip, r6, #214
	str	r4, [fp, #-76]
	mov	r7, #0
	str	r6, [fp, #-72]
	mov	r4, ip
	str	r5, [fp, #-80]
.L2636:
	ldr	r6, [r8, #244]
	add	r7, r7, #1
	mov	r1, r10
	mul	r0, r6, r7
	bl	__aeabi_uidiv
	mov	r1, r10
	mov	r5, r0
	sub	r0, r7, #1
	mul	r0, r0, r6
	bl	__aeabi_uidiv
	cmp	r7, r10
	rsb	r0, r0, r5
	strh	r0, [r4, #2]!
	bne	.L2636
	ldr	r6, [fp, #-72]
	ldr	r4, [fp, #-76]
	ldr	r5, [fp, #-80]
	b	.L2635
.L2652:
	mov	r0, #0
.L2621:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2628:
	ldr	r3, [r8, #240]
	strh	r3, [r6, #176]
	ldr	r3, [r8, #244]
	strh	r3, [r6, #216]
.L2635:
	ldr	r0, [r4, #156]
	movw	r7, #2024
	ldr	r3, .L2683
	mov	r2, r7
	ldr	ip, [r4, #2320]
	mov	r1, r6
	mul	r0, r7, r0
	ldr	r3, [r3, #52]
	sub	r0, r0, #2016
	sub	r0, r0, #8
	add	r0, ip, r0
	blx	r3
	ldr	r2, [r4, #156]
	ldr	r3, [r4, #2320]
	mul	r7, r7, r2
	sub	r7, r7, #2016
	sub	r7, r7, #8
	add	r7, r3, r7
	str	r7, [r9, #2784]
.L2627:
	ldr	r3, [r8, #60]
	ldr	r2, [fp, #-60]
	cmp	r2, r3
	beq	.L2679
.L2642:
	ldr	r3, [fp, #-56]
	mov	r0, r4
	ldr	r2, [fp, #-52]
	ldr	r1, [fp, #-48]
	bl	HEVC_GetReRangeFlag
	ldr	r3, [r4, #2324]
	cmp	r0, #0
	bne	.L2643
	ldr	r2, [r3, #864]
	cmp	r2, #1
	beq	.L2643
.L2646:
	mov	r3, #0
	strb	r3, [r8, #2]
	ldr	r2, [r4, #2324]
	str	r3, [r2, #880]
.L2644:
	mov	r0, r4
	bl	HEVC_AllocFrameStore
	subs	r6, r0, #0
	bne	.L2680
	ldr	ip, [r5, #992]
	mov	r0, #1
	ldr	r3, [r5, #968]
	mvn	r1, #0
	ldr	r2, [r5, #324]
	movw	r7, #54144
	str	ip, [r5, #284]
	add	ip, r4, #54016
	strb	r0, [r5, #281]
	movw	lr, #54160
	str	r3, [r5, #288]
	add	r0, r4, #53504
	str	r3, [r2, #12]
	add	r0, r0, #72
	str	r1, [r5, #312]
	ldr	r1, [r9, #2780]
	ldr	r8, [r1, #72]
	str	r8, [r5, #296]
	ldr	r8, [r1, #76]
	str	r8, [r5, #300]
	ldr	r8, [r1, #240]
	ldr	r1, [r1, #244]
	str	r6, [r5, #308]
	mul	r1, r1, r8
	str	r1, [r5, #304]
	ldr	r1, [r4, #2324]
	ldrd	r2, [r1, #56]
	strd	r2, [r4, r7]
	ldrd	r2, [r1, #72]
	strd	r2, [ip, #136]
	ldrd	r2, [r1, #88]
	strd	r2, [r4, lr]
	mvn	r2, #0
	ldr	ip, [r1, #104]
	mvn	r3, #0
	str	ip, [r5, #336]
	ldr	ip, [r1, #108]
	str	ip, [r5, #340]
	ldr	ip, [r1, #112]
	str	ip, [r5, #344]
	ldr	ip, [r1, #128]
	str	ip, [r5, #348]
	strd	r2, [r1, #56]
	ldr	r2, [r9, #2780]
	ldr	r3, [r2, #72]
	str	r3, [r5, #440]
	ldr	r3, [r2, #76]
	str	r3, [r5, #444]
	ldr	r3, [r2, #2660]
	ldr	r1, [r2, #64]
	mov	r3, r3, asl #5
	subs	r1, r1, #1
	uxtb	r3, r3
	movne	r1, #1
	orr	r3, r3, r1, asl #2
	str	r3, [r5, #436]
	ldr	r1, [r2, #2644]
	and	r1, r1, #7
	bl	SetAspectRatio
	ldr	r3, [r5, #324]
	ldr	r2, [r5, #436]
	str	r6, [r5, #424]
	str	r2, [r3, #180]
	ldr	r3, [r5, #324]
	ldr	r2, [r5, #424]
	str	r2, [r3, #168]
	ldr	r3, [r5, #324]
	ldr	r2, [r5, #332]
	str	r2, [r3, #76]
	ldr	r3, [r5, #324]
	ldr	r2, [r5, #328]
	str	r2, [r3, #72]
	ldr	r3, [r5, #324]
	ldr	r2, [r5, #440]
	str	r2, [r3, #184]
	ldr	r3, [r5, #324]
	ldr	r2, [r5, #444]
	str	r2, [r3, #188]
	ldr	r3, [r5, #324]
	ldr	r0, [r4, #244]
	ldr	r1, [r3, #32]
	bl	FSP_GetDispPhyFs
	cmp	r0, #0
	beq	.L2650
	ldr	r3, [r5, #424]
	mov	r1, r6
	ldr	r2, [r0, #8]
	adds	r3, r3, #0
	ldr	r0, [r4, #244]
	movne	r3, #1
	bl	FSP_SetStoreType
.L2650:
	ldr	r3, [r9, #2780]
	mov	r4, #0
	ldr	lr, [r5, #324]
	mov	r0, r4
	ldr	r2, [r3, #84]
	str	r2, [r5, #624]
	ldr	r7, [r3, #88]
	str	r7, [r5, #628]
	ldr	r1, [r3, #92]
	str	r1, [r5, #632]
	ldr	r6, [r3, #96]
	str	r6, [r5, #636]
	ldr	ip, [r3, #72]
	rsb	r2, r2, ip
	rsb	r2, r7, r2
	str	r2, [r5, #448]
	ldr	ip, [r3, #76]
	rsb	r1, r1, ip
	rsb	r1, r6, r1
	str	r1, [r5, #452]
	ldr	r1, [r3, #64]
	str	r1, [r5, #500]
	ldr	r1, [r3, #100]
	str	r1, [r5, #504]
	ldr	r3, [r3, #108]
	str	r3, [r5, #508]
	ldr	r3, [lr, #200]
	str	r3, [r5, #456]
	ldr	r3, [lr, #204]
	str	r3, [r5, #460]
	str	r2, [lr, #192]
	ldr	r2, [r5, #452]
	ldr	r3, [r5, #324]
	str	r2, [r3, #196]
	ldr	r2, [r5, #456]
	ldr	r3, [r5, #324]
	str	r2, [r3, #200]
	ldr	r2, [r5, #460]
	ldr	r3, [r5, #324]
	str	r2, [r3, #204]
	ldr	r3, [r5, #324]
	ldr	r2, [r5, #504]
	str	r2, [r3, #248]
	ldr	r3, [r5, #324]
	ldr	r2, [r5, #508]
	str	r2, [r3, #252]
	str	r4, [r5, #292]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2679:
	ldrb	r3, [r8, #2]
	cmp	r3, #0
	bne	.L2642
	ldr	r3, [r4, #168]
	cmp	r3, #0
	beq	.L2642
	ldr	r3, [r8, #72]
	ldr	r2, [fp, #-48]
	cmp	r2, r3
	bne	.L2642
	ldr	r3, [r8, #76]
	ldr	r2, [fp, #-52]
	cmp	r2, r3
	bne	.L2642
	ldr	r3, [r4, #2324]
	ldr	r2, [r3, #864]
	cmp	r2, #1
	bne	.L2644
.L2643:
	ldr	r3, [r3, #880]
	cmp	r3, #1
	beq	.L2681
.L2647:
	add	r3, r4, #81920
	ldr	r3, [r3, #2916]
	cmp	r3, #1
	beq	.L2682
.L2648:
	mov	r1, #1
	mov	r0, r4
	bl	HEVC_InitDPB
	cmn	r0, #2
	beq	.L2621
	cmp	r0, #0
	beq	.L2646
	mov	r2, r0
	ldr	r1, .L2683+4
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	mov	r1, #0
	bl	HEVC_ClearAll
	mvn	r0, #0
	b	.L2621
.L2629:
	ldr	lr, [r6, #68]
	ldr	r3, [r8, #240]
	sub	r2, lr, #1
	add	r0, r6, lr, lsl #1
	cmp	r2, #0
	strh	r3, [r0, #174]
	ble	.L2640
	add	lr, lr, #44
	add	r1, r6, #90
	add	ip, r6, #174
	add	lr, r6, lr, lsl #1
.L2639:
	ldrh	r2, [r1, #2]!
	cmp	r1, lr
	strh	r2, [ip, #2]!
	ldrh	r3, [r0, #174]
	rsb	r3, r2, r3
	strh	r3, [r0, #174]
	bne	.L2639
.L2640:
	ldr	lr, [r6, #72]
	ldr	r3, [r8, #244]
	sub	r2, lr, #1
	add	r0, r6, lr, lsl #1
	cmp	r2, #0
	strh	r3, [r0, #214]
	ble	.L2635
	add	lr, lr, #64
	add	r1, r6, #130
	add	ip, r6, #214
	add	lr, r6, lr, lsl #1
.L2641:
	ldrh	r2, [r1, #2]!
	cmp	r1, lr
	strh	r2, [ip, #2]!
	ldrh	r3, [r0, #214]
	rsb	r3, r2, r3
	strh	r3, [r0, #214]
	bne	.L2641
	b	.L2635
.L2677:
	ldr	r1, [r4, #168]
	cmp	r1, #0
	beq	.L2624
	ldr	r1, [r8, #72]
	ldr	r0, [fp, #-48]
	cmp	r0, r1
	bne	.L2624
	ldr	r1, [r8, #76]
	ldr	r0, [fp, #-52]
	cmp	r0, r1
	bne	.L2624
	ldr	r1, [r8, #148]
	ldr	r0, [fp, #-56]
	cmp	r0, r1
	bne	.L2624
	b	.L2625
.L2676:
	ldr	r0, [r4, #168]
	cmp	r0, #0
	bne	.L2623
	b	.L2622
.L2680:
	ldr	r1, .L2683+8
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2678:
	ldrb	r3, [r6, #1]
	cmp	r3, #0
	bne	.L2626
	ldr	r3, [r4, #168]
	cmp	r3, #0
	beq	.L2626
	ldr	r3, [r8, #72]
	ldr	r2, [fp, #-48]
	cmp	r2, r3
	bne	.L2626
	ldr	r3, [r8, #76]
	ldr	r2, [fp, #-52]
	cmp	r2, r3
	bne	.L2626
	ldr	r3, [r8, #148]
	ldr	r2, [fp, #-56]
	cmp	r2, r3
	bne	.L2626
	b	.L2627
.L2681:
	ldr	ip, [r8, #108]
	mov	r0, #31
	ldr	r1, [fp, #-68]
	ldr	r3, [r8, #100]
	ldr	r2, [fp, #-64]
	str	r1, [sp]
	str	ip, [sp, #4]
	ldr	r1, .L2683+12
	bl	dprint_vfmw
	b	.L2647
.L2682:
	mov	r0, r4
	bl	HEVC_GetBackPicFromVOQueue
	b	.L2648
.L2684:
	.align	2
.L2683:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC340
	.word	.LC341
	.word	.LC339
	.fnend
	.size	HEVC_InitPic, .-HEVC_InitPic
	.align	2
	.global	HEVC_OutputFrmToVO
	.type	HEVC_OutputFrmToVO, %function
HEVC_OutputFrmToVO:
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
	mov	r4, r0
	mov	r5, r1
	bl	HEVC_GetImagePara
	mov	r1, r5
	mov	r0, r4
	bl	HEVC_CheckFrameStore
	subs	r6, r0, #0
	beq	.L2693
	cmn	r6, #3
	moveq	r0, #0
	bne	.L2694
.L2688:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2693:
	mov	r2, #1
	ldr	r1, [r5, #32]
	ldr	r0, [r4, #244]
	bl	FSP_SetDisplay
	ldr	r1, [r5, #32]
	ldr	r0, [r4, #244]
	bl	FSP_GetFsImagePtr
	subs	r7, r0, #0
	beq	.L2695
	add	r3, r4, #61440
	ldr	r0, [r4, #244]
	add	r3, r3, #192
	str	r7, [sp]
	mov	r2, r4
	mov	r1, #16
	bl	InsertImgToVoQueue
	cmp	r0, #1
	bne	.L2696
	ldr	r3, [r4, #2324]
	ldr	r3, [r3, #600]
	add	r3, r3, #2032
	add	r3, r3, #15
	cmp	r3, #4096
	strcc	r6, [r7, #24]
	bcs	.L2697
.L2691:
	ldr	r2, [r4, #284]
	mov	r0, #0
	ldr	r3, [r4, #276]
	add	r2, r2, #1
	str	r2, [r4, #284]
	add	r3, r3, #1
	str	r3, [r4, #276]
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2697:
	mov	r1, r7
	mov	r0, r4
	bl	HEVC_SetFrmRepeatCount.part.4
	b	.L2691
.L2694:
	mov	r3, r6
	movw	r2, #9169
	ldr	r1, .L2698
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r1, [r5, #228]
	mov	r0, r4
	bl	HEVC_DECRecycleImage
	mvn	r0, #0
	b	.L2688
.L2696:
	mov	r2, r0
	ldr	r1, .L2698+4
	mov	r0, r6
	bl	dprint_vfmw
	mov	r2, r6
	ldr	r1, [r5, #32]
	ldr	r0, [r4, #244]
	bl	FSP_SetDisplay
	mov	r0, r4
	mov	r1, #1
	bl	HEVC_ClearAll
	mvn	r0, #0
	b	.L2688
.L2695:
	ldr	r2, .L2698+8
	ldr	r1, .L2698+12
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2688
.L2699:
	.align	2
.L2698:
	.word	.LC344
	.word	.LC343
	.word	.LANCHOR1+536
	.word	.LC342
	.fnend
	.size	HEVC_OutputFrmToVO, .-HEVC_OutputFrmToVO
	.align	2
	.global	HEVC_DirectOutput
	.type	HEVC_DirectOutput, %function
HEVC_DirectOutput:
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
	add	r6, r0, #53248
	mov	ip, #2
	mov	r5, #0
	ldr	r4, [r6, #324]
	mov	r3, #1
	mov	r7, r0
	add	r1, r6, #328
	mov	r2, #592
	add	r0, r4, #72
	str	ip, [r4, #4]
	strb	r3, [r4, #2]
	strb	r5, [r4, #1]
	ldr	r3, [r6, #292]
	str	r3, [r4, #16]
	ldr	r3, [r6, #320]
	str	r3, [r4, #20]
	bl	memcpy
	str	r5, [r4, #48]
	ldr	r3, [r6, #320]
	mov	r2, r5
	ldr	r1, [r4, #32]
	str	r3, [r4, #40]
	ldr	r0, [r7, #244]
	bl	FSP_SetRef
	mov	r1, r4
	mov	r0, r7
	bl	HEVC_OutputFrmToVO
	ldr	r3, .L2701
	str	r5, [r4, #4]
	mov	r1, r5
	mov	r2, #640
	ldr	r3, [r3, #48]
	mov	r6, r0
	add	r0, r7, #53504
	add	r0, r0, #24
	blx	r3
	mov	r0, r6
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2702:
	.align	2
.L2701:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	HEVC_DirectOutput, .-HEVC_DirectOutput
	.align	2
	.global	HEVC_IModeProcess
	.type	HEVC_IModeProcess, %function
HEVC_IModeProcess:
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
	bl	HEVC_DirectOutput
	add	r2, r4, #53248
	ldr	r1, [r4, #180]
	ldr	r3, [r2, #316]
	cmp	r3, r1
	addne	r3, r3, #528
	movne	ip, #0
	addne	r4, r4, r3, lsl #2
	strne	ip, [r4, #4]
	strne	r1, [r2, #316]
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	HEVC_IModeProcess, .-HEVC_IModeProcess
	.align	2
	.global	HEVC_OutputFrmFromDPB
	.type	HEVC_OutputFrmFromDPB, %function
HEVC_OutputFrmFromDPB:
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
	ldr	r8, [r0, #2508]
	mov	r4, r0
	cmp	r8, #0
	beq	.L2706
	add	r6, r0, #2512
	mov	r7, #0
	add	r6, r6, #12
	mov	r3, r7
	mov	r1, r6
.L2708:
	ldr	r2, [r1, #4]!
	add	r3, r3, #1
	ldrb	r0, [r2, #2]
	cmp	r0, #0
	bne	.L2707
	ldr	r0, [r2, #12]
	ldr	r2, [r4, #212]
	cmp	r0, r2
	addgt	r7, r7, #1
.L2707:
	cmp	r3, r8
	bne	.L2708
	mov	r5, #0
	mov	r8, r5
.L2714:
	ldr	r1, [r6, #4]!
	ldrb	r2, [r1, #2]
	cmp	r2, #0
	bne	.L2709
	ldr	r0, [r1, #12]
	ldr	r3, [r4, #212]
	cmp	r0, r3
	ble	.L2710
	add	r9, r4, #53248
	add	lr, r4, #24576
	ldr	r10, [r9, #988]
	ldr	ip, [lr, #2780]
	add	ip, ip, r10, lsl #2
	ldr	ip, [ip, #412]
	cmp	ip, r7
	bcs	.L2710
	ldr	ip, [r9, #968]
	cmp	r0, ip
	blt	.L2711
	ldrb	r0, [r4, #2]
	cmp	r0, #0
	bne	.L2711
.L2710:
	cmp	r3, #0
	bne	.L2712
	ldr	r0, [r1, #12]
	cmp	r0, #0
	bge	.L2712
	cmp	r2, #0
	beq	.L2721
.L2713:
	str	r0, [sp]
	mov	r0, #31
	ldr	r2, .L2722
	ldr	r1, .L2722+4
	bl	dprint_vfmw
.L2712:
	ldr	r3, [r4, #2508]
	add	r5, r5, #1
	cmp	r3, r5
	bhi	.L2714
.L2706:
	mov	r0, r8
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2711:
	mov	r3, #1
	mov	r0, r4
	strb	r3, [r1, #2]
	sub	r7, r7, #1
	ldr	r1, [r6]
	bl	HEVC_OutputFrmToVO
	ldr	r3, [r6]
	ldr	r3, [r3, #12]
	str	r3, [r4, #212]
	mov	r8, r0
	b	.L2712
.L2709:
	ldr	r3, [r4, #212]
	b	.L2710
.L2721:
	mov	r2, r3
	ldr	r0, [r4, #244]
	ldr	r1, [r1, #32]
	bl	FSP_SetDisplay
	ldr	r2, [r6]
	ldr	r3, [r4, #212]
	ldr	r0, [r2, #12]
	b	.L2713
.L2723:
	.align	2
.L2722:
	.word	.LANCHOR1+556
	.word	.LC345
	.fnend
	.size	HEVC_OutputFrmFromDPB, .-HEVC_OutputFrmFromDPB
	.align	2
	.global	HEVC_OutputOneFrmFromDPB
	.type	HEVC_OutputOneFrmFromDPB, %function
HEVC_OutputOneFrmFromDPB:
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
	add	r4, r0, r1, lsl #2
	mov	r2, #1
	mov	r6, r1
	ldr	r3, [r4, #2528]
	mov	r5, r0
	strb	r2, [r3, #2]
	ldr	r1, [r4, #2528]
	bl	HEVC_OutputFrmToVO
	ldr	r3, [r4, #2528]
	ldr	r2, [r3, #12]
	str	r2, [r5, #212]
	ldrb	r3, [r3, #1]
	cmp	r3, #0
	mov	r7, r0
	bne	.L2725
	mov	r1, r6
	mov	r0, r5
	bl	HEVC_RemoveApcStore
	mov	r1, r6
	mov	r0, r5
	bl	HEVC_RemoveFrameStoreOutDPB
.L2725:
	mov	r0, r7
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	HEVC_OutputOneFrmFromDPB, .-HEVC_OutputOneFrmFromDPB
	.align	2
	.global	HEVC_OutputUnRefPicWithMinPoc
	.type	HEVC_OutputUnRefPicWithMinPoc, %function
HEVC_OutputUnRefPicWithMinPoc:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, fp, ip, lr, pc}
	.pad #4
	.save {r4, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #12
	sub	sp, sp, #12
	push	{lr}
	bl	__gnu_mcount_nc
	sub	r1, fp, #24
	mov	r4, r0
	bl	HEVC_GetUnRefPicWithMinPoc
	cmp	r0, #0
	bne	.L2730
	mov	r0, r4
	ldr	r1, [fp, #-24]
	bl	HEVC_OutputOneFrmFromDPB
	cmp	r0, #0
	bne	.L2731
.L2728:
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L2730:
	ldr	r2, .L2732
	mov	r0, #1
	ldr	r1, .L2732+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2728
.L2731:
	ldr	r2, .L2732
	mov	r0, #1
	ldr	r1, .L2732+8
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2728
.L2733:
	.align	2
.L2732:
	.word	.LANCHOR1+580
	.word	.LC346
	.word	.LC347
	.fnend
	.size	HEVC_OutputUnRefPicWithMinPoc, .-HEVC_OutputUnRefPicWithMinPoc
	.align	2
	.global	HEVC_FlushOutputFrmFromDPB
	.type	HEVC_FlushOutputFrmFromDPB, %function
HEVC_FlushOutputFrmFromDPB:
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
	subs	r4, r0, #0
	beq	.L2743
	ldr	r3, [r4, #2508]
	cmp	r3, #0
	addne	r5, r4, #2512
	movne	r6, #0
	addne	r5, r5, #12
	movne	r8, #1
	bne	.L2741
	b	.L2742
.L2749:
	strb	r8, [r3, #2]
	ldr	r1, [r5]
	bl	HEVC_OutputFrmToVO
	cmn	r0, #1
	mov	r9, r0
	beq	.L2748
.L2739:
	ldr	r3, [r4, #2508]
	cmp	r3, r6
	bls	.L2742
.L2741:
	ldr	r3, [r5, #4]!
	mov	r2, #0
	ldr	r0, [r4, #244]
	add	r6, r6, #1
	ldr	r1, [r3, #32]
	bl	FSP_SetRef
	ldr	r3, [r5]
	mov	r0, r4
	ldrb	r7, [r3, #2]
	cmp	r7, #0
	beq	.L2749
	ldr	r1, [r3, #32]
	ldr	r0, [r4, #244]
	bl	FSP_GetDisplay
	mov	r2, #0
	cmp	r0, #3
	beq	.L2739
	ldr	r3, [r5]
	ldr	r0, [r4, #244]
	ldr	r1, [r3, #32]
	bl	FSP_SetDisplay
	ldr	r3, [r4, #2508]
	cmp	r3, r6
	bhi	.L2741
.L2742:
	mov	r3, #-2147483647
	mov	r0, r4
	str	r3, [r4, #212]
	mov	r9, #0
	bl	Hevc_InitDecBuffers
.L2735:
	mov	r0, r9
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2748:
	mov	r0, r7
	ldr	r2, .L2750
	ldr	r1, .L2750+4
	bl	dprint_vfmw
	mov	r0, r9
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2743:
	mvn	r9, #0
	b	.L2735
.L2751:
	.align	2
.L2750:
	.word	.LANCHOR1+612
	.word	.LC348
	.fnend
	.size	HEVC_FlushOutputFrmFromDPB, .-HEVC_FlushOutputFrmFromDPB
	.align	2
	.global	HEVC_ReceivePacket
	.type	HEVC_ReceivePacket, %function
HEVC_ReceivePacket:
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
	add	r4, r0, #81920
	mov	r3, #0
	mov	r5, r0
	str	r3, [r4, #2896]
	ldr	r6, [r0, #2332]
	cmp	r6, r3
	beq	.L2774
	ldrb	r3, [r1]
	str	r3, [r6, #40]
	ldr	r3, [r0, #2324]
	ldr	r2, [r3, #824]
	cmp	r2, #1
	beq	.L2775
.L2758:
	ldrb	r3, [r1]
	cmp	r3, #1
	bne	.L2759
	ldr	r3, [r5, #2332]
	ldr	r2, [r3, #8]
	cmp	r2, #1
	bls	.L2760
	ldr	r0, [r3, #40]
	cmp	r0, #1
	beq	.L2759
.L2760:
	ldr	r0, [r1, #12]
	cmp	r0, #0
	ble	.L2761
	ldr	ip, [r1, #4]
	cmp	ip, #0
	beq	.L2761
	ldr	r0, [r1, #8]
	cmp	r0, #0
	bne	.L2776
.L2761:
	mov	r2, #1
	str	r2, [r3, #40]
	ldr	r1, [r1, #16]
	ldr	r0, [r5, #244]
	bl	SM_ReleaseStreamSeg
.L2757:
	ldr	r3, [r5, #2332]
	ldr	r0, [r3, #40]
	clz	r0, r0
	mov	r0, r0, lsr #5
	rsb	r0, r0, #0
.L2756:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L2775:
	ldr	r3, [r3, #864]
	cmp	r3, #0
	bne	.L2757
	b	.L2758
.L2776:
	mov	r0, r2, asl #5
	mov	lr, #0
	sub	r2, r0, r2, asl #2
	mov	r0, r5
	add	r3, r3, r2
	str	ip, [r3, #44]
	ldr	r3, [r5, #2332]
	ldr	r6, [r1, #12]
	ldr	ip, [r3, #8]
	mov	r2, ip, asl #5
	sub	r2, r2, ip, asl #2
	add	r3, r3, r2
	str	r6, [r3, #48]
	ldr	r3, [r5, #2332]
	ldr	r6, [r1, #8]
	ldr	ip, [r3, #8]
	mov	r2, ip, asl #5
	sub	r2, r2, ip, asl #2
	add	r3, r3, r2
	str	r6, [r3, #52]
	ldr	r3, [r5, #2332]
	ldr	ip, [r1, #16]
	ldr	r1, [r3, #8]
	mov	r2, r1, asl #5
	sub	r2, r2, r1, asl #2
	add	r3, r3, r2
	str	ip, [r3, #68]
	ldr	r3, [r5, #2332]
	ldr	r1, [r3, #8]
	mov	r2, r1, asl #5
	sub	r2, r2, r1, asl #2
	add	r3, r3, r2
	str	lr, [r3, #60]
	ldr	r2, [r5, #2332]
	ldr	r3, [r2, #8]
	add	r3, r3, #1
	str	r3, [r2, #8]
	bl	HEVC_CombinePacket
	mov	r3, #1
	str	r3, [r4, #2896]
	b	.L2757
.L2774:
	ldr	r3, [r1, #12]
	cmp	r3, #0
	ble	.L2754
	ldr	r3, [r1, #4]
	cmp	r3, #0
	beq	.L2754
	ldr	r3, [r1, #8]
	str	r1, [fp, #-32]
	cmp	r3, #0
	beq	.L2754
	bl	HEVC_FindNaluArraySlot
	ldr	r1, [fp, #-32]
	cmn	r0, #1
	mov	r4, r0
	beq	.L2777
	add	r3, r5, #65536
	mov	r0, #100
	mov	r2, #1
	ldr	r3, [r3, #1736]
	mla	r4, r0, r4, r3
	str	r4, [r5, #2332]
	ldr	r3, [r1, #4]
	str	r3, [r4, #44]
	ldr	r3, [r5, #2332]
	ldr	r0, [r1, #12]
	str	r0, [r3, #48]
	ldr	r3, [r5, #2332]
	ldr	r0, [r1, #16]
	str	r0, [r3, #68]
	ldr	r3, [r5, #2332]
	ldr	r0, [r1, #8]
	str	r0, [r3, #52]
	ldr	r3, [r5, #2332]
	str	r6, [r3, #60]
	ldr	r3, [r5, #2332]
	str	r2, [r3, #8]
	ldr	r3, [r5, #2332]
	strb	r6, [r3, #1]
	ldrb	r2, [r1]
	ldr	r3, [r5, #2332]
	str	r2, [r3, #40]
	b	.L2757
.L2759:
	ldr	r1, .L2778
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2756
.L2754:
	ldr	r1, .L2778+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2756
.L2777:
	ldr	r1, .L2778+8
	mov	r0, r6
	bl	dprint_vfmw
	mov	r1, r6
	mov	r0, r5
	bl	HEVC_ClearAll
	mov	r0, r4
	b	.L2756
.L2779:
	.align	2
.L2778:
	.word	.LC351
	.word	.LC350
	.word	.LC349
	.fnend
	.size	HEVC_ReceivePacket, .-HEVC_ReceivePacket
	.align	2
	.global	HEVCDEC_GetImageBuffer
	.type	HEVCDEC_GetImageBuffer, %function
HEVCDEC_GetImageBuffer:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, fp, ip, lr, pc}
	.pad #4
	.save {r4, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #20
	sub	sp, sp, #20
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r3, [r0, #176]
	mov	r4, r0
	cmp	r3, #0
	beq	.L2783
	add	r3, r0, #53248
	ldrb	r3, [r3, #281]
	cmp	r3, #1
	beq	.L2783
	add	r2, r0, #67584
	add	r0, r0, #80896
	add	r2, r2, #496
	add	r0, r0, #464
.L2789:
	ldr	r3, [r2, #4]
	cmp	r3, #0
	bne	.L2784
	cmp	r2, #0
	beq	.L2785
	ldr	lr, [r4, #2508]
	cmp	lr, #0
	beq	.L2785
	ldr	r1, [r4, #2528]
	cmp	r1, r2
	beq	.L2784
	add	r1, r4, #2528
	b	.L2786
.L2787:
	ldr	ip, [r1, #4]!
	cmp	ip, r2
	beq	.L2784
.L2786:
	add	r3, r3, #1
	cmp	r3, lr
	bne	.L2787
.L2785:
	ldr	r0, [r4, #244]
	bl	FSP_IsNewFsAvalible
	cmp	r0, #1
	beq	.L2783
	cmn	r0, #1
	beq	.L2808
.L2807:
	mov	r0, #0
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L2783:
	mov	r0, #1
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L2784:
	add	r2, r2, #664
	cmp	r2, r0
	bne	.L2789
	add	r0, r4, #61440
	sub	r2, fp, #24
	sub	r1, fp, #28
	add	r0, r0, #192
	bl	GetQueueImgNum
	mov	r0, r4
	bl	HEVC_PrintFrameStoreState
	ldr	r1, .L2809
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, r4
	bl	HEVC_PrintDPBState
	ldr	r2, [r4, #176]
	ldr	r0, [r4, #2508]
	ldr	r3, [fp, #-28]
	sub	r2, r2, #2
	ldr	r1, [fp, #-24]
	rsb	r2, r0, r2
	add	r0, r3, r1
	cmp	r0, r2
	bge	.L2807
	str	r1, [sp]
	mov	r0, #0
	ldr	r2, .L2809+4
	ldr	r1, .L2809+8
	bl	dprint_vfmw
	mov	r0, r4
	mov	r1, #1
	bl	HEVC_ClearAll
	mov	r0, #0
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L2808:
	add	r1, r4, #61440
	ldr	r0, [r4, #244]
	add	r1, r1, #192
	bl	FSP_ClearNotInVoQueue
	b	.L2807
.L2810:
	.align	2
.L2809:
	.word	.LC352
	.word	.LANCHOR1+640
	.word	.LC353
	.fnend
	.size	HEVCDEC_GetImageBuffer, .-HEVCDEC_GetImageBuffer
	.align	2
	.global	HEVC_FlushDPB
	.type	HEVC_FlushDPB, %function
HEVC_FlushDPB:
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
	ldr	r3, [r0, #2508]
	mov	r4, r0
	cmp	r3, #0
	beq	.L2813
	add	r6, r0, #2512
	mov	r5, #0
	add	r6, r6, #12
	mov	r7, r5
	b	.L2815
.L2814:
	ldr	r3, [r4, #2508]
	cmp	r3, r5
	bls	.L2813
.L2815:
	ldr	r3, [r6, #4]!
	add	r5, r5, #1
	ldrb	r2, [r3, #1]
	cmp	r2, #0
	beq	.L2814
	strb	r7, [r3, #1]
	mov	r2, #0
	ldr	r1, [r3, #32]
	ldr	r0, [r4, #244]
	bl	FSP_SetRef
	ldr	r3, [r4, #2508]
	cmp	r3, r5
	bhi	.L2815
.L2813:
	mov	r0, r4
	bl	HEVC_RemoveUnUsedFrameStore
	cmp	r0, #0
	beq	.L2817
	mov	r0, r4
	bl	HEVC_RemoveUnUsedFrameStore
	cmp	r0, #0
	bne	.L2813
	b	.L2817
.L2819:
	bl	HEVC_GetMinPOC
	ldr	r1, [fp, #-36]
	mov	r0, r4
	bl	HEVC_OutputOneFrmFromDPB
	cmn	r0, #1
	beq	.L2818
.L2817:
	ldr	r3, [r4, #2508]
	sub	r2, fp, #36
	sub	r1, fp, #32
	mov	r0, r4
	cmp	r3, #0
	bne	.L2819
	mov	r0, r3
.L2818:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	HEVC_FlushDPB, .-HEVC_FlushDPB
	.align	2
	.global	HEVC_ClearDPB
	.type	HEVC_ClearDPB, %function
HEVC_ClearDPB:
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
	bl	HEVC_FlushDPB
	subs	r3, r0, #0
	beq	.L2828
	ldr	r2, .L2832
	mov	r0, #0
	ldr	r1, .L2832+4
	bl	dprint_vfmw
.L2828:
	mov	r0, r4
	mov	r1, #0
	bl	HEVC_InitDPB
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L2833:
	.align	2
.L2832:
	.word	.LANCHOR1+664
	.word	.LC354
	.fnend
	.size	HEVC_ClearDPB, .-HEVC_ClearDPB
	.align	2
	.global	HEVC_RecoverDPBProcess
	.type	HEVC_RecoverDPBProcess, %function
HEVC_RecoverDPBProcess:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, fp, ip, lr, pc}
	.pad #4
	.save {r4, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #12
	sub	sp, sp, #12
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r4, r0
	b	.L2835
.L2837:
	str	lr, [sp]
	bl	dprint_vfmw
	mov	r0, r4
	bl	HEVC_IncreaseDPBSize
	cmp	r0, #0
	bne	.L2844
.L2835:
	ldr	ip, [r4, #2508]
	mov	r0, #13
	ldr	lr, [r4, #2504]
	ldr	r2, .L2845
	cmp	ip, lr
	ldr	r1, .L2845+4
	mov	r3, ip
	bcs	.L2837
	b	.L2839
.L2841:
	str	lr, [sp]
	bl	dprint_vfmw
	mov	r0, r4
	bl	HEVC_OutputUnRefPicWithMinPoc
	cmp	r0, #0
	bne	.L2838
	ldr	ip, [r4, #2508]
	ldr	lr, [r4, #2504]
.L2839:
	cmp	ip, lr
	mov	r3, ip
	ldr	r2, .L2845
	mov	r0, #1
	ldr	r1, .L2845+8
	bcs	.L2841
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L2844:
	ldr	r2, .L2845
	mov	r0, #1
	ldr	r1, .L2845+12
	bl	dprint_vfmw
	ldr	ip, [r4, #2508]
	ldr	lr, [r4, #2504]
	b	.L2839
.L2838:
	ldr	r2, .L2845
	mov	r0, #1
	ldr	r1, .L2845+16
	bl	dprint_vfmw
	mov	r0, r4
	bl	HEVC_PrintDPBState
	mov	r0, r4
	bl	HEVC_ClearDPB
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L2846:
	.align	2
.L2845:
	.word	.LANCHOR1+680
	.word	.LC355
	.word	.LC357
	.word	.LC356
	.word	.LC347
	.fnend
	.size	HEVC_RecoverDPBProcess, .-HEVC_RecoverDPBProcess
	.align	2
	.global	HEVC_DecSliceSegmentHeader
	.type	HEVC_DecSliceSegmentHeader, %function
HEVC_DecSliceSegmentHeader:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #84
	sub	sp, sp, #84
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r1, #1
	mov	r4, r0
	ldr	r0, [r0, #2308]
	add	r10, r4, #53248
	bl	BsGet
	ldr	r7, [r10, #992]
	sub	r3, r7, #16
	cmp	r3, #5
	movhi	r3, #0
	movls	r3, #1
	cmp	r3, #0
	str	r3, [fp, #-72]
	strb	r0, [r10, #921]
	bne	.L3112
.L2848:
	ldr	r1, .L3155
	ldr	r0, [r4, #2308]
	bl	HEVC_ue_v
	cmp	r0, #0
	str	r0, [r10, #996]
	ldr	r3, [r4, #156]
	blt	.L2850
	cmp	r0, r3
	bge	.L2850
	mov	r0, r4
	bl	HEVC_VpsSpsPpsCheck
	subs	r3, r0, #0
	str	r3, [fp, #-88]
	bne	.L3113
	ldr	r1, [r10, #996]
	movw	r5, #2024
	ldr	r2, [r4, #2320]
	movw	r6, #26164
	ldr	r3, [r4, #2316]
	mla	r5, r5, r1, r2
	ldrb	r1, [r5, #2]
	ldr	r2, [r5, #32]
	cmp	r1, #0
	mla	r6, r6, r2, r3
	bne	.L3114
.L2856:
	mov	r3, #0
	strb	r3, [r10, #923]
.L2857:
	ldr	r9, [r6, #160]
	ldr	r3, [r6, #164]
	cmp	r9, #0
	beq	.L2859
	cmp	r3, #0
	beq	.L2859
	ldr	r0, [r6, #76]
	mov	r1, r3
	add	r0, r3, r0
	sub	r0, r0, #1
	bl	__aeabi_uidiv
	mov	r1, r9
	mov	r8, r0
	ldr	r0, [r6, #72]
	add	r0, r9, r0
	sub	r0, r0, #1
	bl	__aeabi_uidiv
	ldr	r9, [r6, #216]
	mov	r3, #1
	mov	r1, #0
	mov	r9, r9, asl r3
	mov	r9, r3, asl r9
	mul	r8, r0, r8
	cmp	r8, r3
	ble	.L2861
.L2862:
	add	r1, r1, #1
	cmp	r8, r3, asl r1
	bgt	.L2862
.L2861:
	ldrb	r3, [r10, #921]
	cmp	r3, #0
	movne	r2, #0
	beq	.L3115
.L2863:
	mul	r9, r9, r8
	ldrb	r8, [r10, #923]
	str	r2, [r10, #1072]
	cmp	r8, #0
	str	r9, [r10, #1076]
	ldr	r3, [r4, #188]
	str	r3, [r10, #968]
	beq	.L3116
.L2866:
	ldr	r3, [r5, #12]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #0
	streq	r3, [r10, #1060]
	bne	.L3117
.L2973:
	ldrb	r3, [r5, #23]
	cmp	r3, #0
	bne	.L2978
.L2984:
	ldr	r3, [r10, #1072]
	cmp	r3, #0
	bne	.L3118
	ldrb	r3, [r4, #1]
	cmp	r3, #0
	beq	.L2986
	ldr	r3, [fp, #-72]
	cmp	r3, #0
	movne	r3, #1
	strneb	r3, [r4, #3]
	bne	.L2988
.L2989:
	mov	r3, #0
	strb	r3, [r4, #2]
.L2990:
	mov	r0, r4
	bl	HEVC_IsNewPic
	str	r0, [r10, #2508]
	mov	r0, r4
	bl	HEVC_ReadByteAlignment
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r0, r0, #0
.L3092:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3118:
	ldrb	r3, [r4, #3]
	cmp	r3, #0
	beq	.L2989
.L2988:
	ldr	r3, [r10, #968]
	ldr	r2, [fp, #-72]
	cmp	r3, #0
	moveq	r2, #0
	andne	r2, r2, #1
	cmp	r2, #0
	beq	.L2989
	ldr	r3, [r10, #992]
	cmp	r3, #21
	moveq	r3, #1
	streqb	r3, [r4, #2]
	bne	.L2989
	b	.L2990
.L3114:
	ldrb	r3, [r10, #921]
	cmp	r3, #0
	bne	.L2856
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	strb	r0, [r10, #923]
	b	.L2857
.L3116:
	ldr	r3, [r5, #36]
	cmp	r3, #0
	beq	.L2871
.L2870:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	ldr	r1, .L3155+4
	add	r8, r8, #1
	mov	r2, r0
	mov	r0, #19
	bl	dprint_vfmw
	ldr	r3, [r5, #36]
	cmp	r3, r8
	bhi	.L2870
.L2871:
	ldr	r1, .L3155+8
	ldr	r0, [r4, #2308]
	bl	HEVC_ue_v
	cmp	r0, #2
	str	r0, [r10, #980]
	bhi	.L3119
	ldrb	r3, [r5, #4]
	cmp	r3, #0
	moveq	r3, #1
	streqb	r3, [r10, #920]
	bne	.L3120
.L2873:
	sub	r7, r7, #19
	cmp	r7, #1
	bhi	.L3121
	mov	r3, #0
	str	r3, [r10, #968]
	str	r3, [r4, #188]
	ldr	r3, [r10, #988]
	cmp	r3, #0
	streq	r3, [r10, #972]
	streq	r3, [r4, #184]
	ldrb	r3, [r6, #9]
	cmp	r3, #0
	bne	.L3103
.L2992:
	mov	r3, #0
	strb	r3, [r10, #927]
	str	r3, [fp, #-92]
.L2994:
	ldr	r3, [r10, #980]
	cmp	r3, #2
	beq	.L2917
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r10, #928]
	cmp	r0, #0
	bne	.L3122
	ldr	r3, [r10, #980]
	ldr	r2, [r5, #40]
	cmp	r3, #0
	str	r2, [r10, #1088]
	bne	.L2923
	ldr	r3, [r5, #44]
	str	r3, [r10, #1092]
.L2924:
	ldr	r3, [fp, #-92]
	cmp	r3, #0
	beq	.L3123
	ldr	r3, [fp, #-92]
	ldr	r2, [r3, #24]
	cmp	r2, #16
	bhi	.L2927
	cmp	r2, #0
	moveq	r3, r2
	beq	.L2929
	ldr	r3, [fp, #-92]
	add	r2, r2, #52
	add	r1, r3, #52
	add	r2, r3, r2
	mov	r3, #0
.L2931:
	ldrb	r0, [r1, #1]!
	cmp	r0, #0
	addne	r3, r3, #1
	cmp	r1, r2
	bne	.L2931
	cmp	r3, #1
	movle	r2, #0
	movgt	r2, #1
.L2929:
	ldrb	r1, [r5, #22]
	cmp	r1, #0
	moveq	r2, #0
	andne	r2, r2, #1
	cmp	r2, #0
	beq	.L3124
	add	r2, r4, #57600
	add	r1, r4, #54016
	add	r2, r2, #40
	add	r1, r1, #152
	mov	r0, r4
	bl	HEVC_DecRefPicListsModification
	cmp	r0, #0
	bne	.L3125
.L2925:
	ldr	r3, [r10, #980]
	cmp	r3, #0
	beq	.L2996
.L2932:
	cmp	r3, #2
	beq	.L2917
.L2997:
	ldrb	r3, [r5, #5]
	cmp	r3, #0
	bne	.L3126
.L2933:
	ldrb	r3, [r10, #927]
	cmp	r3, #0
	ldr	r3, [r10, #980]
	beq	.L2943
	cmp	r3, #0
	beq	.L3127
	cmp	r3, #2
	mov	r3, #1
	strb	r3, [r10, #931]
	beq	.L2938
.L2941:
	ldr	r3, [r10, #1088]
	cmp	r3, #1
	bls	.L3100
.L2939:
	ldr	r1, .L3155+12
	ldr	r0, [r4, #2308]
	bl	HEVC_ue_v
	ldrb	r2, [r10, #931]
	cmp	r2, #0
	str	r0, [r10, #1032]
	bne	.L2944
	ldr	r3, [r10, #1028]
	sub	r3, r3, #1
.L2946:
	cmp	r3, r0
	movcs	r1, #0
	movcc	r1, #1
	orrs	r1, r1, r0, lsr #31
	beq	.L3100
	str	r3, [sp]
	mov	r3, r0
	ldr	r1, .L3155+16
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3112:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	strb	r0, [r10, #922]
	b	.L2848
.L3115:
	ldr	r0, [r4, #2308]
	bl	BsGet
	str	r0, [r10, #1000]
	cmp	r0, #0
	ldr	r2, [r6, #244]
	ldr	r3, [r6, #240]
	mul	r3, r3, r2
	blt	.L2865
	cmp	r3, r0
	bls	.L2865
	mul	r2, r9, r0
	b	.L2863
.L3117:
	ldr	r1, .L3155+20
	ldr	r0, [r4, #2308]
	bl	HEVC_ue_v
	str	r0, [r10, #1060]
	ldr	r3, [r5, #12]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #65536
	ldreq	r3, [r6, #244]
	subeq	r3, r3, #1
	beq	.L2969
	cmp	r3, #256
	ldreq	r2, [r5, #68]
	ldreq	r3, [r5, #72]
	ldrne	r3, [r6, #244]
	ldrne	r2, [r5, #68]
	mul	r3, r3, r2
	sub	r3, r3, #1
.L2969:
	cmp	r3, #255
	movcs	r3, #255
	cmp	r0, r3
	bhi	.L3128
	cmp	r0, #0
	beq	.L2973
	ldr	r1, .L3155+24
	ldr	r0, [r4, #2308]
	bl	HEVC_ue_v
	cmp	r0, #31
	add	r1, r0, #1
	str	r1, [r10, #984]
	bhi	.L3129
	ldr	r3, [r10, #1060]
	cmp	r3, #0
	addne	r7, r4, #54272
	movne	r6, #0
	addne	r7, r7, #72
	bne	.L2977
	b	.L2973
.L3130:
	ldr	r1, [r10, #984]
.L2977:
	ldr	r0, [r4, #2308]
	add	r6, r6, #1
	bl	BsGet
	str	r0, [r7, #4]!
	ldr	r3, [r10, #1060]
	cmp	r3, r6
	bhi	.L3130
	ldrb	r3, [r5, #23]
	cmp	r3, #0
	beq	.L2984
.L2978:
	ldr	r1, .L3155+28
	ldr	r0, [r4, #2308]
	bl	HEVC_ue_v
	cmp	r0, #256
	str	r0, [r10, #1064]
	bhi	.L3131
	ldr	r0, [r4, #2308]
	bl	BsResidBits
	ldr	r3, [r10, #1064]
	cmp	r0, r3
	bcc	.L2982
	cmp	r3, #0
	movne	r5, #0
	beq	.L2984
.L2985:
	mov	r1, #8
	ldr	r0, [r4, #2308]
	bl	BsGet
	ldr	r3, [r10, #1064]
	add	r5, r5, #1
	cmp	r3, r5
	str	r0, [r10, #1068]
	bhi	.L2985
	b	.L2984
.L2917:
	ldrb	r3, [r10, #927]
	cmp	r3, #0
	beq	.L2938
	mov	r3, #2
	mov	r2, #1
	strb	r2, [r10, #931]
.L2943:
	ldrb	r2, [r5, #10]
	cmp	r2, #0
	beq	.L2948
	cmp	r3, #1
	beq	.L2951
.L2948:
	ldrb	r2, [r5, #11]
	cmp	r2, #0
	beq	.L2937
	cmp	r3, #0
	bne	.L2937
.L2951:
	mov	r0, r4
	bl	HEVC_DecPredWeightTable
	cmp	r0, #0
	ldreq	r3, [r10, #980]
	bne	.L3132
.L2937:
	cmp	r3, #2
	beq	.L2952
	ldr	r1, .L3155+32
	ldr	r0, [r4, #2308]
	bl	HEVC_ue_v
	rsb	r3, r0, #4
	rsb	r2, r0, #5
	cmp	r3, #4
	str	r2, [r10, #1036]
	bhi	.L3133
.L2952:
	ldr	r1, .L3155+36
	ldr	r0, [r4, #2308]
	bl	HEVC_se_v
	str	r0, [r10, #1040]
	ldr	r2, [r5, #48]
	add	r2, r0, r2
	str	r2, [r10, #976]
	ldr	r3, [r6, #104]
	cmp	r2, #51
	rsb	r0, r3, #0
	movle	r1, #0
	movgt	r1, #1
	cmp	r2, r0
	orrlt	r1, r1, #1
	cmp	r1, #0
	bne	.L3134
	ldrb	r3, [r5, #9]
	cmp	r3, #0
	bne	.L3135
.L2954:
	ldrb	r3, [r5, #18]
	cmp	r3, #0
	beq	.L3101
	ldrb	r3, [r5, #19]
	cmp	r3, #0
	streqb	r3, [r10, #932]
	bne	.L3136
.L2962:
	ldrb	r0, [r5, #20]
	strb	r0, [r10, #933]
	ldr	r3, [r5, #76]
	str	r3, [r10, #1052]
	ldr	r3, [r5, #80]
	str	r3, [r10, #1056]
.L2959:
	ldrb	r3, [r6, #9]
	cmp	r3, #0
	beq	.L2965
	ldr	r2, [r10, #924]
	bic	r3, r2, #-16777216
	bic	r3, r3, #255
	adds	r3, r3, #0
	movne	r3, #1
.L2965:
	ldrb	r2, [r5, #17]
	cmp	r2, #0
	beq	.L2966
	cmp	r0, #0
	orreq	r3, r3, #1
	cmp	r3, #0
	bne	.L3137
.L2966:
	strb	r2, [r10, #934]
	b	.L2866
.L2986:
	ldr	r2, [fp, #-72]
	cmp	r2, #0
	strneb	r3, [r4, #3]
	b	.L2989
.L3124:
	ldr	r3, [r10, #980]
	cmp	r3, #0
	bne	.L2997
.L2996:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	ldr	r3, [r10, #980]
	strb	r0, [r10, #929]
	b	.L2932
.L3101:
	ldrb	r0, [r10, #933]
	b	.L2959
.L3121:
	ldr	r1, [r6, #132]
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r2, #1
	str	r0, [r10, #1008]
	mov	r8, r0
	ldr	r3, [r6, #128]
	ldr	r7, [r4, #184]
	mov	r3, r2, asl r3
	str	r0, [fp, #-100]
	str	r3, [fp, #-104]
	mov	r1, r3
	mov	r0, r7
	bl	__aeabi_uidivmod
	cmp	r1, r8
	rsb	r3, r1, r7
	bls	.L2875
	ldr	r0, [fp, #-104]
	ldr	r2, [fp, #-100]
	rsb	r2, r2, r1
	cmp	r2, r0, lsr #1
	movcs	r2, r0
	addcs	r3, r3, r2
	bcc	.L2875
.L2876:
	ldr	r2, [r10, #992]
	sub	r2, r2, #16
	cmp	r2, #2
	ldr	r2, [fp, #-100]
	movls	r3, #0
	add	r3, r3, r2
	str	r3, [r10, #968]
	ldr	r2, [r4, #212]
	cmp	r3, r2
	bge	.L2878
	ldrb	r0, [r10, #921]
	cmp	r0, #1
	beq	.L3138
.L2878:
	str	r3, [r4, #188]
	ldr	r2, [r10, #988]
	cmp	r2, #0
	bne	.L2879
	ldr	r2, [r10, #992]
	cmp	r2, #15
	bls	.L3139
.L2880:
	sub	r1, r2, #16
	cmp	r1, #7
	movhi	r1, #0
	movls	r1, #1
.L2881:
	sub	r2, r2, #7
	bics	r2, r2, #2
	andne	r2, r1, #1
	moveq	r2, #0
	cmp	r2, #0
	strne	r3, [r10, #972]
	strne	r3, [r4, #184]
.L2879:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r10, #924]
	cmp	r0, #0
	beq	.L2882
	ldr	r3, [r6, #228]
	cmp	r3, #1
	movhi	r1, #0
	movhi	r2, #1
	bls	.L2884
.L2886:
	add	r1, r1, #1
	cmp	r3, r2, asl r1
	bhi	.L2886
	cmp	r1, #0
	bne	.L3140
.L2884:
	mov	r1, #0
	str	r1, [r10, #1012]
.L2889:
	mov	r2, #204
	add	r0, r4, #57344
	mla	r1, r2, r1, r6
	add	r0, r0, #92
	str	r0, [fp, #-92]
	add	r1, r1, #13056
	add	r1, r1, #52
	bl	memcpy
.L2885:
	ldrb	r3, [r6, #11]
	cmp	r3, #0
	beq	.L2890
	add	r3, r4, #57344
	str	r3, [fp, #-84]
	mov	r1, r3
	ldr	r3, [r6, #232]
	ldr	r2, [r1, #112]
	cmp	r3, #0
	ldr	r3, [r1, #108]
	add	r3, r2, r3
	str	r3, [fp, #-108]
	bne	.L2891
.L2894:
	mov	r9, #0
.L2892:
	ldr	r1, .L3155+40
	ldr	r0, [r4, #2308]
	bl	HEVC_ue_v
	ldr	ip, [fp, #-84]
	ldr	r1, [r10, #1016]
	str	r0, [r10, #1020]
	add	r0, r0, r1
	ldr	r2, [ip, #108]
	ldr	r3, [ip, #112]
	str	r0, [ip, #124]
	add	lr, r3, r2
	add	lr, lr, r0
	cmp	lr, #16
	bhi	.L3141
	ldr	r3, [fp, #-108]
	cmp	r0, #0
	sub	r7, r3, #1
	add	r7, r0, r7
	beq	.L2910
	add	r3, r7, #13888
	add	r7, r7, #57344
	add	r3, r3, #19
	add	r7, r7, #145
	add	r7, r4, r7
	str	r7, [fp, #-64]
	mov	r3, r3, asl #2
	add	lr, r4, #54016
	add	ip, r3, #64
	str	ip, [fp, #-56]
	ldr	r7, [fp, #-56]
	add	ip, r4, #55296
	str	ip, [fp, #-48]
	add	r0, r4, #55552
	add	r8, r4, r7
	add	r7, r4, r3
	ldr	r3, [fp, #-48]
	add	r0, r0, #8
	str	r0, [fp, #-60]
	add	r0, ip, #140
	add	ip, lr, #167
	add	lr, r3, #76
	add	r3, r3, #204
	add	r2, r4, #54016
	str	r7, [fp, #-96]
	add	r2, r2, #182
	str	lr, [fp, #-48]
	mov	lr, r3
	mov	r3, #0
	str	r5, [fp, #-112]
	str	r6, [fp, #-76]
	mov	r7, lr
	str	r9, [fp, #-80]
	mov	r9, r0
	ldr	r5, [fp, #-64]
	str	r4, [fp, #-52]
	mov	r4, r3
	str	r10, [fp, #-64]
	mov	r10, ip
	str	r2, [fp, #-116]
	str	r3, [fp, #-68]
	str	r2, [fp, #-56]
	ldr	r6, [fp, #-96]
	b	.L2909
.L3144:
	ldr	r3, [fp, #-80]
	cmp	r3, #0
	ldreq	r0, [fp, #-80]
	bne	.L3142
.L2900:
	ldr	r2, [fp, #-76]
	add	r3, r2, r0
	add	r0, r0, #62
	ldrb	r1, [r3, #17]
	ldr	r3, [r2, r0, asl #2]
	strb	r1, [r5]
.L2903:
	ldr	r2, [fp, #-60]
	mov	r1, #1
	str	r3, [r2, #4]!
	ldr	r3, [fp, #-52]
	str	r2, [fp, #-60]
	ldr	r0, [r3, #2308]
	bl	BsGet
	ldr	r3, [fp, #-56]
	uxtb	r0, r0
	strb	r0, [r3, #1]!
	cmp	r0, #0
	str	r3, [fp, #-56]
	bne	.L3143
	cmp	r4, #0
	streq	r4, [fp, #-68]
	beq	.L2907
	ldr	r3, [fp, #-64]
	ldr	r2, [fp, #-68]
	ldr	r3, [r3, #1016]
	cmp	r3, r4
	moveq	r2, #0
	str	r2, [fp, #-68]
.L2907:
	mov	r3, #0
	str	r3, [r8]
.L2906:
	ldr	r3, [fp, #-84]
	add	r4, r4, #1
	ldr	r2, [fp, #-48]
	sub	r6, r6, #4
	sub	r8, r8, #4
	sub	r5, r5, #1
	ldr	r3, [r3, #124]
	add	r2, r2, #4
	add	r9, r9, #4
	add	r10, r10, #1
	cmp	r3, r4
	str	r2, [fp, #-48]
	add	r7, r7, #4
	bls	.L2908
	ldr	r3, [fp, #-64]
	ldr	r1, [r3, #1016]
.L2909:
	cmp	r1, r4
	bhi	.L3144
	ldr	r3, [fp, #-76]
	ldr	r1, [r3, #132]
	ldr	r3, [fp, #-52]
	ldr	r0, [r3, #2308]
	bl	BsGet
	ldr	r3, [fp, #-52]
	mov	r1, #1
	str	r0, [r9]
	str	r0, [fp, #-96]
	ldr	r0, [r3, #2308]
	bl	BsGet
	ldr	r3, [fp, #-96]
	uxtb	r0, r0
	strb	r0, [r10]
	strb	r0, [r5]
	b	.L2903
.L2875:
	ldr	r2, [fp, #-100]
	cmp	r1, r2
	bcs	.L2876
	rsb	r1, r1, r2
	ldr	r2, [fp, #-104]
	cmp	r1, r2, lsr #1
	rsbhi	r3, r2, r3
	b	.L2876
.L3120:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	strb	r0, [r10, #920]
	b	.L2873
.L3135:
	ldr	r1, .L3155+44
	ldr	r0, [r4, #2308]
	bl	HEVC_se_v
	add	r3, r0, #12
	str	r0, [r10, #1044]
	cmp	r3, #24
	bhi	.L3145
	ldr	r3, [r5, #60]
	add	r2, r0, r3
	add	r2, r2, #12
	cmp	r2, #24
	bhi	.L3146
	ldr	r1, .L3155+48
	ldr	r0, [r4, #2308]
	bl	HEVC_se_v
	add	r3, r0, #12
	str	r0, [r10, #1048]
	cmp	r3, #24
	bhi	.L3147
	ldr	r2, [r5, #64]
	add	r2, r0, r2
	add	r3, r2, #12
	cmp	r3, #24
	bls	.L2954
	ldr	r1, .L3155+52
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L2850:
	str	r3, [sp]
	mov	r3, r0
	ldr	r2, .L3155+56
	mov	r0, #1
	ldr	r1, .L3155+60
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3100:
	ldr	r3, [r10, #980]
	b	.L2943
.L2890:
	ldrb	r3, [r6, #12]
	cmp	r3, #0
	streqb	r3, [r10, #927]
	bne	.L3148
.L2915:
	ldrb	r3, [r6, #9]
	cmp	r3, #0
	beq	.L2994
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r10, #925]
	ldr	r0, [r4, #2308]
	bl	BsGet
	strb	r0, [r10, #926]
	b	.L2994
.L3103:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r10, #925]
	ldr	r0, [r4, #2308]
	bl	BsGet
	strb	r0, [r10, #926]
	b	.L2992
.L3126:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	strb	r0, [r10, #930]
	b	.L2933
.L2923:
	str	r0, [r10, #1092]
.L2922:
	cmp	r3, #2
	bne	.L2924
	b	.L2925
.L3122:
	ldr	r1, .L3155+64
	ldr	r0, [r4, #2308]
	bl	HEVC_ue_v
	add	r2, r0, #1
	str	r2, [r10, #1024]
	cmp	r2, #16
	bhi	.L3149
	ldr	r3, [r10, #980]
	str	r2, [r10, #1088]
	cmp	r3, #0
	movne	r2, #0
	strne	r2, [r10, #1028]
	strne	r2, [r10, #1092]
	bne	.L2922
	ldr	r1, .L3155+68
	ldr	r0, [r4, #2308]
	bl	HEVC_ue_v
	add	r2, r0, #1
	str	r2, [r10, #1028]
	cmp	r2, #16
	strls	r2, [r10, #1092]
	ldrls	r3, [r10, #980]
	bls	.L2922
	mov	r3, #16
	ldr	r1, .L3155+72
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3127:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	ldr	r3, [r10, #980]
	cmp	r3, #2
	uxtb	r0, r0
	strb	r0, [r10, #931]
	beq	.L2952
	cmp	r0, #0
	bne	.L2941
	ldr	r2, [r10, #1092]
	cmp	r2, #1
	bhi	.L2939
	b	.L2943
.L2938:
	mov	r3, #2
	b	.L2948
.L2944:
	ldr	r3, [r10, #1024]
	sub	r3, r3, #1
	b	.L2946
.L3139:
	tst	r2, #1
	movne	r1, #1
	bne	.L2881
	b	.L2880
.L2891:
	ldr	r1, .L3155+76
	ldr	r0, [r4, #2308]
	bl	HEVC_ue_v
	str	r0, [r10, #1016]
	mov	r2, r0
	ldr	r3, [r6, #232]
	cmp	r0, r3
	bhi	.L3150
	cmp	r3, #1
	bls	.L2894
	mov	r9, #0
	mov	r2, #1
.L2895:
	add	r9, r9, #1
	cmp	r3, r2, asl r9
	bhi	.L2895
	str	r9, [fp, #-88]
	b	.L2892
.L3138:
	ldr	r1, .L3155+80
	bl	dprint_vfmw
	mov	r0, r4
	bl	HEVC_ClearDPB
	mov	r3, #-2147483647
	str	r3, [r4, #212]
	ldr	r3, [r10, #968]
	b	.L2878
.L2982:
	mov	r2, r0
	ldr	r1, .L3155+84
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3143:
	ldr	r3, [fp, #-52]
	ldr	r1, .L3155+88
	ldr	r0, [r3, #2308]
	bl	HEVC_ue_v
	cmp	r4, #0
	str	r0, [r7]
	beq	.L2905
	ldr	r3, [fp, #-64]
	ldr	r3, [r3, #1016]
	cmp	r3, r4
	ldrne	r3, [fp, #-68]
	addne	r0, r0, r3
.L2905:
	str	r0, [r6]
	mov	r3, #1
	str	r0, [fp, #-68]
	str	r3, [r8]
	b	.L2906
.L3142:
	ldr	r3, [fp, #-52]
	ldr	r1, [fp, #-88]
	ldr	r0, [r3, #2308]
	bl	BsGet
	ldr	r3, [fp, #-48]
	cmp	r0, #0
	str	r0, [r3]
	blt	.L3151
	ldr	r3, [fp, #-76]
	ldr	r3, [r3, #232]
	sub	r3, r3, #1
	cmp	r3, r0
	bcs	.L2900
	mov	r7, r4
.L2902:
	str	r3, [sp]
	mov	r2, r7
	mov	r3, r0
	ldr	r1, .L3155+92
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L2859:
	mov	r2, r9
	ldr	r1, .L3155+96
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3137:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	strb	r0, [r10, #934]
	b	.L2866
.L3136:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r10, #932]
	cmp	r0, #0
	beq	.L2962
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r10, #933]
	cmp	r0, #0
	bne	.L2959
	ldr	r1, .L3155+100
	ldr	r0, [r4, #2308]
	bl	HEVC_se_v
	add	r3, r0, #6
	mov	r2, r0
	cmp	r3, #12
	str	r0, [r10, #1052]
	bhi	.L3152
.L2963:
	ldr	r1, .L3155+104
	ldr	r0, [r4, #2308]
	bl	HEVC_se_v
	add	r3, r0, #6
	mov	r2, r0
	cmp	r3, #12
	str	r0, [r10, #1056]
	bls	.L3101
	ldr	r1, .L3155+108
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r5, #80]
	ldrb	r0, [r10, #933]
	str	r3, [r10, #1056]
	b	.L2959
.L2908:
	ldr	r2, [fp, #-108]
	cmp	r3, #0
	ldr	r5, [fp, #-112]
	add	r2, r2, #14336
	ldr	r6, [fp, #-76]
	ldr	r4, [fp, #-52]
	add	r2, r2, #57
	ldr	r10, [fp, #-64]
	beq	.L2910
	add	r2, r2, r3
	add	lr, r4, #55552
	add	lr, lr, #12
	mov	r7, #0
	add	r2, r4, r2, lsl #2
	ldr	r8, [fp, #-104]
	ldr	ip, [fp, #-116]
	ldr	r9, [fp, #-100]
	str	r4, [fp, #-48]
	b	.L2913
.L3154:
	ldr	r0, [r10, #968]
	ldr	r4, [lr]
	rsb	r1, r9, r0
	add	r1, r1, r4
	ldr	r4, [r2, #-1948]
	mls	r1, r4, r8, r1
	rsb	r0, r0, r1
	str	r0, [r2, #-68]
	str	r1, [r2]
.L2912:
	add	r7, r7, #1
	add	lr, lr, #4
	cmp	r3, r7
	sub	r2, r2, #4
	bls	.L3153
.L2913:
	ldrb	r1, [ip, #1]!
	cmp	r1, #0
	bne	.L3154
	ldr	r1, [lr]
	str	r1, [r2]
	ldr	r0, [r10, #968]
	rsb	r1, r0, r1
	str	r1, [r2, #-68]
	b	.L2912
.L3113:
	ldr	r3, [r4, #216]
	mov	r0, r4
	cmp	r3, #0
	ldrne	r3, [r4, #188]
	str	r3, [r10, #968]
	bl	HEVC_IsNewPic
	ldr	r1, .L3155+112
	str	r0, [r10, #2508]
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3153:
	ldr	r4, [fp, #-48]
.L2898:
	ldr	r2, [fp, #-108]
	add	r2, r3, r2
	ldr	r3, [fp, #-84]
	cmp	r2, #16
	str	r2, [r3, #116]
	bls	.L2890
	mov	r3, #16
	ldr	r1, .L3155+116
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L2882:
	add	r7, r4, #57344
	ldr	r3, [r6, #228]
	add	r7, r7, #92
	mov	r1, r6
	mov	r0, r4
	mov	r2, r7
	bl	HEVC_DecShortTermRefPicSet
	cmp	r0, #0
	streq	r7, [fp, #-92]
	beq	.L2885
	ldr	r1, .L3155+120
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3148:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	bl	BsGet
	strb	r0, [r10, #927]
	b	.L2915
.L3156:
	.align	2
.L3155:
	.word	.LC358
	.word	.LC364
	.word	.LC363
	.word	.LC383
	.word	.LC384
	.word	.LC400
	.word	.LC402
	.word	.LC404
	.word	.LC386
	.word	.LC388
	.word	.LC371
	.word	.LC390
	.word	.LC393
	.word	.LC395
	.word	.LANCHOR1+704
	.word	.LC359
	.word	.LC376
	.word	.LC378
	.word	.LC379
	.word	.LC369
	.word	.LC366
	.word	.LC406
	.word	.LC374
	.word	.LC373
	.word	.LC361
	.word	.LC396
	.word	.LC398
	.word	.LC399
	.word	.LC360
	.word	.LC375
	.word	.LC367
	.word	.LC368
	.word	.LC389
	.word	.LC362
	.word	.LC405
	.word	.LC365
	.word	.LC381
	.word	.LC387
	.word	.LC401
	.word	.LC397
	.word	.LC392
	.word	.LC385
	.word	.LC394
	.word	.LC391
	.word	.LC372
	.word	.LC382
	.word	.LC377
	.word	.LC380
	.word	.LC403
	.word	.LC370
.L3140:
	ldr	r0, [r4, #2308]
	bl	BsGet
	str	r0, [r10, #1012]
	cmp	r0, #0
	ldr	r3, [r6, #228]
	mov	r1, r0
	sub	r3, r3, #1
	blt	.L2888
	cmp	r3, r0
	bcs	.L2889
.L2888:
	mov	r2, r1
	mov	r0, #1
	ldr	r1, .L3155+124
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3134:
	ldr	r1, .L3155+128
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L2865:
	mov	r2, r0
	ldr	r1, .L3155+132
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3131:
	mov	r2, r0
	ldr	r1, .L3155+136
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3151:
	ldr	r6, [fp, #-76]
	mov	r7, r4
	ldr	r3, [r6, #232]
	sub	r3, r3, #1
	b	.L2902
.L3119:
	mov	r2, r0
	ldr	r1, .L3155+140
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L2927:
	mov	r3, #16
	ldr	r1, .L3155+144
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3133:
	ldr	r1, .L3155+148
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3128:
	mov	r2, r0
	ldr	r1, .L3155+152
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3152:
	ldr	r1, .L3155+156
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r5, #76]
	str	r3, [r10, #1052]
	b	.L2963
.L3146:
	mov	r2, r0
	ldr	r1, .L3155+160
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L2910:
	mov	r3, #0
	b	.L2898
.L3132:
	ldr	r1, .L3155+164
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3147:
	mov	r2, r0
	ldr	r1, .L3155+168
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3145:
	mov	r2, r0
	ldr	r1, .L3155+172
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3141:
	str	r0, [sp]
	mov	ip, #16
	ldr	r1, .L3155+176
	mov	r0, #1
	str	ip, [sp, #4]
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3125:
	ldr	r1, .L3155+180
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3149:
	mov	r3, #16
	ldr	r1, .L3155+184
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3123:
	ldr	r1, .L3155+188
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3129:
	mov	r2, r1
	mov	r0, #1
	ldr	r1, .L3155+192
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
.L3150:
	ldr	r1, .L3155+196
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3092
	.fnend
	.size	HEVC_DecSliceSegmentHeader, .-HEVC_DecSliceSegmentHeader
	.align	2
	.global	HEVC_InsertFrmInDPB
	.type	HEVC_InsertFrmInDPB, %function
HEVC_InsertFrmInDPB:
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
	cmp	r1, #16
	mov	r7, r1
	mov	r6, r0
	mov	r4, r2
	bhi	.L3161
	ldr	r3, [r2, #44]
	add	r5, r0, r1, lsl #2
	mov	r1, #1
	mov	r2, r1
	str	r3, [r5, #2528]
	str	r1, [r3, #4]
	ldr	r3, [r5, #2528]
	ldr	r0, [r0, #244]
	ldr	r1, [r3, #32]
	bl	FSP_SetRef
	ldrb	r3, [r4]
	ldr	r0, [r5, #2528]
	mov	r2, #592
	adds	r3, r3, #0
	add	r1, r4, #48
	movne	r3, #1
	strb	r3, [r0, #1]
	ldr	r3, [r5, #2528]
	ldr	r0, [r4, #36]
	str	r0, [r3, #24]
	ldr	r0, [r5, #2528]
	add	r0, r0, #72
	bl	memcpy
	ldr	ip, [r5, #2528]
	ldr	lr, [r4, #40]
	add	r1, r7, #1
	ldr	r3, .L3163
	mov	r2, #4
	add	r0, r6, #2528
	str	lr, [ip, #40]
	str	lr, [ip, #20]
	ldr	ip, [r5, #2528]
	ldr	lr, [r4, #44]
	str	lr, [ip, #68]
	ldr	ip, [r5, #2528]
	ldr	lr, [r4, #12]
	str	lr, [ip, #44]
	str	lr, [ip, #16]
	ldr	ip, [r5, #2528]
	ldr	lr, [r4, #8]
	str	lr, [ip, #12]
	ldr	ip, [r5, #2528]
	ldr	lr, [r4, #8]
	str	lr, [ip, #36]
	bl	qsort
	ldr	r3, [r6, #2508]
	mov	r0, r6
	add	r3, r3, #1
	str	r3, [r6, #2508]
	ldr	r1, [r4, #44]
	bl	HEVC_GetAPC
	subs	r3, r0, #0
	bne	.L3162
	mov	r0, r3
	strb	r3, [r4, #1]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3161:
	mov	r3, r1
	ldr	r2, .L3163+4
	ldr	r1, .L3163+8
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, r6
	bl	HEVC_ClearDPB
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3162:
	ldr	r2, .L3163+4
	mov	r0, #0
	ldr	r1, .L3163+12
	bl	dprint_vfmw
	mov	r0, r6
	bl	HEVC_PrintDPBState
	mov	r0, r6
	bl	HEVC_ClearDPB
	mvn	r0, #6
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3164:
	.align	2
.L3163:
	.word	compare_pic_by_poc_asc
	.word	.LANCHOR1+732
	.word	.LC407
	.word	.LC408
	.fnend
	.size	HEVC_InsertFrmInDPB, .-HEVC_InsertFrmInDPB
	.align	2
	.global	HEVC_SimpleDPBProcess
	.type	HEVC_SimpleDPBProcess, %function
HEVC_SimpleDPBProcess:
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
	add	r4, r0, #53248
	mov	r5, r0
	ldrb	r3, [r4, #280]
	cmp	r3, #0
	bne	.L3178
	ldr	r3, [r4, #324]
	mov	r2, #2
	str	r2, [r3, #4]
.L3167:
	ldr	r3, [r4, #324]
	mov	r2, #1
	mov	r0, r5
	strb	r2, [r3, #2]
	ldr	r1, [r4, #324]
	bl	HEVC_CheckFrameStore
	cmn	r0, #1
	mov	r4, r0
	beq	.L3179
	cmn	r0, #3
	beq	.L3171
	mov	r0, r5
	bl	HEVC_OutputCurrPic
	cmp	r0, #0
	bne	.L3180
.L3171:
	mov	r0, #0
.L3168:
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L3178:
	bl	HEVC_SimpleSlideDPB
	add	r2, r5, #53504
	add	r2, r2, #24
	ldr	r1, [r5, #2508]
	mov	r0, r5
	bl	HEVC_InsertFrmInDPB
	cmp	r0, #0
	beq	.L3167
	str	r0, [sp]
	movw	r3, #8306
	ldr	r2, .L3181
	mov	r0, #0
	ldr	r1, .L3181+4
	bl	dprint_vfmw
	mvn	r0, #6
	b	.L3168
.L3180:
	ldr	r2, .L3181
	mov	r0, #0
	ldr	r1, .L3181+8
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3168
.L3179:
	ldr	r2, .L3181
	mov	r0, #0
	ldr	r1, .L3181+12
	bl	dprint_vfmw
	mov	r0, r4
	b	.L3168
.L3182:
	.align	2
.L3181:
	.word	.LANCHOR1+752
	.word	.LC409
	.word	.LC92
	.word	.LC410
	.fnend
	.size	HEVC_SimpleDPBProcess, .-HEVC_SimpleDPBProcess
	.align	2
	.global	HEVC_DecOrderProcess
	.type	HEVC_DecOrderProcess, %function
HEVC_DecOrderProcess:
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
	ldr	r1, [r0, #2508]
	ldr	r3, [r0, #2504]
	mov	r4, r0
	cmp	r1, r3
	bcs	.L3195
.L3184:
	add	r2, r4, #53504
	mov	r0, r4
	add	r2, r2, #24
	bl	HEVC_InsertFrmInDPB
	subs	r6, r0, #0
	bne	.L3196
	add	r3, r4, #53248
	mov	r0, r4
	ldr	r1, [r3, #324]
	bl	HEVC_CheckFrameStore
	cmn	r0, #1
	mov	r5, r0
	beq	.L3197
	cmn	r0, #3
	beq	.L3190
	mov	r0, r4
	bl	HEVC_OutputCurrPic
	cmp	r0, #0
	bne	.L3198
.L3190:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3195:
	bl	HEVC_RemoveUnusedApcStore
	mov	r0, r4
	bl	HEVC_RemoveUnUsedFrameStore
	cmp	r0, #1
	beq	.L3194
	ldr	r2, .L3199
	mov	r0, #0
	ldr	r1, .L3199+4
	bl	dprint_vfmw
.L3194:
	ldr	r1, [r4, #2508]
	b	.L3184
.L3196:
	ldr	r2, .L3199
	mov	r0, #0
	ldr	r1, .L3199+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3198:
	mov	r0, r6
	ldr	r2, .L3199
	ldr	r1, .L3199+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3197:
	mov	r0, r6
	ldr	r2, .L3199
	ldr	r1, .L3199+16
	bl	dprint_vfmw
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3200:
	.align	2
.L3199:
	.word	.LANCHOR1+776
	.word	.LC411
	.word	.LC412
	.word	.LC92
	.word	.LC410
	.fnend
	.size	HEVC_DecOrderProcess, .-HEVC_DecOrderProcess
	.align	2
	.global	HEVC_DispOrderProcess
	.type	HEVC_DispOrderProcess, %function
HEVC_DispOrderProcess:
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
	add	r3, r0, #61440
	mov	r4, r0
	ldr	r3, [r3, #544]
	cmp	r3, #1
	beq	.L3202
	bl	HEVC_FirstFrameFastOut
	cmp	r0, #0
	bne	.L3219
.L3202:
	ldr	r1, [r4, #2508]
	ldr	r3, [r4, #2504]
	cmp	r1, r3
	bcs	.L3220
.L3204:
	add	r2, r4, #53504
	mov	r0, r4
	add	r2, r2, #24
	bl	HEVC_InsertFrmInDPB
	cmp	r0, #0
	bne	.L3221
	ldr	r3, [r4, #2508]
	cmp	r3, #0
	bne	.L3207
.L3208:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L3207:
	mov	r0, r4
	bl	HEVC_OutputFrmFromDPB
	cmp	r0, #0
	beq	.L3208
	ldr	r2, .L3222
	mov	r0, #1
	ldr	r1, .L3222+4
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L3220:
	mov	r0, r4
	bl	HEVC_RemoveUnusedApcStore
	mov	r0, r4
	bl	HEVC_RemoveUnUsedFrameStore
	cmp	r0, #1
	beq	.L3218
	ldr	r1, .L3222+8
	mov	r0, #0
	bl	dprint_vfmw
.L3218:
	ldr	r1, [r4, #2508]
	b	.L3204
.L3221:
	mov	r2, r0
	ldr	r1, .L3222+12
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L3219:
	ldr	r2, .L3222
	mov	r0, #0
	ldr	r1, .L3222+16
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L3223:
	.align	2
.L3222:
	.word	.LANCHOR1+800
	.word	.LC416
	.word	.LC414
	.word	.LC415
	.word	.LC413
	.fnend
	.size	HEVC_DispOrderProcess, .-HEVC_DispOrderProcess
	.align	2
	.global	HEVC_StorePicInDPB
	.type	HEVC_StorePicInDPB, %function
HEVC_StorePicInDPB:
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
	ldr	r3, .L3267
	ldr	r2, [r0, #244]
	mov	r4, r0
	ldr	r3, [r3, r2, asl #2]
	ldrsb	r2, [r3, #160]
	cmp	r2, #1
	beq	.L3258
.L3225:
	ldr	r3, [r4, #2324]
	ldr	r3, [r3, #592]
	cmp	r3, #1
	beq	.L3259
	add	r6, r4, #53248
	mov	r3, #0
	str	r3, [r6, #408]
	str	r3, [r6, #412]
.L3228:
	mov	r0, r4
	bl	HEVC_RemoveDummyFrame
	ldrb	r5, [r6, #281]
	cmp	r5, #0
	beq	.L3260
	ldr	r3, [r4, #2324]
	ldr	r1, [r6, #320]
	ldr	r2, [r3, #4]
	cmp	r1, r2
	bhi	.L3261
	ldr	r2, [r4, #248]
	cmp	r2, #2
	beq	.L3262
	ldr	r3, [r3, #12]
	cmp	r3, #2
	beq	.L3263
	cmp	r3, #1
	beq	.L3264
	cmp	r3, #0
	beq	.L3242
.L3243:
	mov	r0, r4
	mvn	r5, #0
	bl	HEVC_ClearCurrPic
	ldr	r2, .L3267+4
	ldr	r1, .L3267+8
	mov	r0, #1
	bl	dprint_vfmw
.L3241:
	mov	r3, #0
	mov	r0, r5
	strb	r3, [r6, #281]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3259:
	ldr	r2, .L3267+12
	add	r6, r4, #53248
	ldr	r2, [r2]
	add	r2, r2, #4096
	ldr	r0, [r2, #84]
	ldr	r1, [r2, #88]
	str	r3, [r6, #408]
	cmp	r1, #0
	moveq	r1, #1
	bl	__aeabi_uidiv
	str	r0, [r6, #412]
	b	.L3228
.L3258:
	ldr	r2, [r3, #168]
	cmp	r2, #0
	bne	.L3225
	ldr	r3, [r3, #172]
	cmp	r3, #1
	bne	.L3225
	add	r3, r0, #24576
	ldrb	r3, [r3, #2768]
	cmp	r3, #1
	bne	.L3225
	bl	HEVC_Sei_Get_Frame_Pts
	b	.L3225
.L3260:
	ldr	r2, .L3267+4
	mov	r0, #1
	ldr	r1, .L3267+16
	bl	dprint_vfmw
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3263:
	mov	r0, r4
	bl	HEVC_SimpleDPBProcess
	subs	r5, r0, #0
	bne	.L3265
.L3237:
	movw	r3, #8634
	mov	r2, r5
	ldr	r1, .L3267+20
	mov	r0, #14
	bl	dprint_vfmw
.L3235:
	cmn	r5, #1
	bne	.L3241
	b	.L3243
.L3261:
	mov	r0, r4
	bl	HEVC_ClearCurrPic
	ldr	r3, [r4, #2324]
	ldr	r2, [r6, #320]
	mov	r0, #1
	ldr	r1, .L3267+24
	ldr	r3, [r3, #4]
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3264:
	mov	r0, r4
	bl	HEVC_DecOrderProcess
	subs	r5, r0, #0
	beq	.L3239
	ldr	r2, .L3267+4
	mov	r0, #0
	ldr	r1, .L3267+28
	bl	dprint_vfmw
	ldr	r3, [r4, #2324]
	ldr	r3, [r3, #12]
	cmp	r3, #0
	bne	.L3235
.L3242:
	mov	r0, r4
	bl	HEVC_DispOrderProcess
	subs	r5, r0, #0
	bne	.L3240
.L3244:
	mov	r5, #0
	b	.L3241
.L3262:
	mov	r0, r4
	bl	HEVC_DirectOutput
	ldr	r3, [r6, #316]
	ldr	r2, [r4, #180]
	cmp	r3, r2
	addne	r3, r3, #528
	movne	r1, #0
	addne	r3, r4, r3, lsl #2
	strne	r1, [r3, #4]
	mov	r5, r0
	strne	r2, [r6, #316]
	cmp	r0, #0
	bne	.L3266
.L3234:
	movw	r3, #8619
	mov	r2, r5
	ldr	r1, .L3267+20
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3235
.L3239:
	ldr	r3, [r4, #2324]
	ldr	r3, [r3, #12]
	cmp	r3, #0
	bne	.L3244
	b	.L3242
.L3240:
	ldr	r2, .L3267+4
	mov	r0, #0
	ldr	r1, .L3267+32
	bl	dprint_vfmw
	b	.L3235
.L3266:
	ldr	r2, .L3267+4
	mov	r0, #0
	ldr	r1, .L3267+36
	bl	dprint_vfmw
	b	.L3234
.L3265:
	ldr	r2, .L3267+4
	mov	r0, #0
	ldr	r1, .L3267+40
	bl	dprint_vfmw
	b	.L3237
.L3268:
	.align	2
.L3267:
	.word	s_pstVfmwChan
	.word	.LANCHOR1+824
	.word	.LC424
	.word	g_HwMem
	.word	.LC417
	.word	.LC420
	.word	.LC418
	.word	.LC422
	.word	.LC423
	.word	.LC419
	.word	.LC421
	.fnend
	.size	HEVC_StorePicInDPB, .-HEVC_StorePicInDPB
	.align	2
	.global	HEVC_CreateLostPicture
	.type	HEVC_CreateLostPicture, %function
HEVC_CreateLostPicture:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #640
	sub	sp, sp, #640
	push	{lr}
	bl	__gnu_mcount_nc
	add	r4, r0, #67584
	mov	r5, r0
	add	r4, r4, #496
	mov	r6, r1
	mov	r7, #0
.L3274:
	ldr	r2, [r4, #4]
	cmp	r2, #0
	bne	.L3270
	cmp	r4, #0
	beq	.L3271
	ldr	r3, [r5, #2508]
	cmp	r3, #0
	beq	.L3271
	ldr	r1, [r5, #2528]
	cmp	r4, r1
	beq	.L3270
	add	ip, r5, #2528
	b	.L3272
.L3273:
	ldr	lr, [ip, #4]!
	cmp	lr, r4
	beq	.L3270
.L3272:
	add	r2, r2, #1
	cmp	r2, r3
	bne	.L3273
.L3271:
	mov	r8, #664
	mov	r2, #592
	mla	r8, r8, r7, r5
	sub	r0, fp, #628
	mov	r9, #1
	mov	r3, #101
	str	r6, [fp, #-668]
	add	r8, r8, #67584
	str	r3, [fp, #-636]
	add	r1, r8, #568
	strb	r9, [fp, #-675]
	strb	r9, [fp, #-676]
	bl	memcpy
	cmp	r7, #19
	strb	r9, [r8, #498]
	mov	r7, #0
	strb	r9, [r8, #496]
	str	r4, [fp, #-632]
	str	r7, [r8, #504]
	str	r7, [fp, #-468]
	bgt	.L3275
	ldr	r0, [r5, #2508]
	cmp	r0, #0
	beq	.L3277
	add	r1, r5, #2512
	mov	ip, r7
	add	r1, r1, #12
	mvn	r2, #-2147483648
	mov	r8, r1
.L3280:
	ldr	lr, [r8, #4]!
	add	ip, ip, #1
	ldr	r3, [lr, #12]
	rsb	r3, r6, r3
	cmp	r3, #0
	rsblt	r3, r3, #0
	cmp	r3, r2
	bge	.L3279
	ldrb	lr, [lr, #1]
	cmp	lr, #0
	movne	r2, r3
	movne	r7, #1
.L3279:
	cmp	ip, r0
	bne	.L3280
	cmp	r7, #0
	beq	.L3277
	mov	r4, #0
	b	.L3281
.L3282:
	add	r4, r4, #1
	cmp	r4, r0
	beq	.L3283
.L3281:
	ldr	ip, [r1, #4]!
	ldr	r3, [ip, #12]
	rsb	r3, r6, r3
	cmp	r3, #0
	rsblt	r3, r3, #0
	cmp	r3, r2
	bne	.L3282
	ldrb	r3, [ip, #1]
	cmp	r3, #0
	beq	.L3282
	ldr	r1, [ip, #32]
	add	r4, r4, #632
	ldr	r0, [r5, #244]
	bl	FSP_GetLogicFs
	ldr	r2, [r5, r4, asl #2]
	mov	r3, r6
	ldr	r1, .L3314
	ldr	r2, [r2, #12]
	mov	r7, r0
	mov	r0, #1
	bl	dprint_vfmw
	cmp	r7, #0
	beq	.L3283
	ldr	r0, [r7, #608]
	cmp	r0, #0
	beq	.L3312
	mov	r1, #0
	ldr	r0, [r5, #244]
	bl	FSP_NewLogicFs
	mov	r8, r0
	mov	r1, r0
	ldr	r0, [r5, #244]
	bl	FSP_GetLogicFs
	mvn	r2, r8
	mov	r2, r2, lsr #31
	cmp	r0, #0
	mov	r3, r0
	moveq	r2, #0
	cmp	r2, #0
	beq	.L3286
	ldr	r1, [fp, #-632]
	sub	r2, fp, #676
	mov	r0, r5
	str	r8, [r1, #32]
	ldr	r1, [r7, #608]
	str	r1, [r3, #608]
	ldr	r1, [r7, #612]
	str	r1, [r3, #612]
	ldr	r1, [r7, #616]
	str	r1, [r3, #616]
	ldrsb	r3, [r7, #4]
	ldr	r1, [r5, #2508]
	str	r3, [fp, #-640]
	bl	HEVC_InsertFrmInDPB
	subs	r4, r0, #0
	bne	.L3313
	ldr	r0, [r5, #244]
	mov	r1, r8
	mov	r2, r4
	bl	FSP_SetDisplay
	ldr	r3, [r5, #200]
	mov	r0, r4
	cmn	r3, #-2147483647
	streq	r6, [r5, #200]
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L3270:
	add	r7, r7, #1
	add	r4, r4, #664
	cmp	r7, #20
	bne	.L3274
.L3275:
	ldr	r1, .L3314+4
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
.L3307:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L3283:
	ldr	r1, .L3314+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #3
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L3286:
	ldr	r3, [fp, #-632]
	mov	r0, r2
	ldr	r1, .L3314+12
	strb	r2, [r3]
	bl	dprint_vfmw
	mvn	r0, #3
	b	.L3307
.L3313:
	ldr	r3, [fp, #-632]
	mov	r1, r8
	mov	r4, #0
	mov	r2, #1
	strb	r4, [r3]
	ldr	r0, [r5, #244]
	bl	FSP_ClearLogicFs
	mov	r0, r4
	ldr	r1, .L3314+16
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3307
.L3277:
	mov	r0, #0
	ldr	r1, .L3314+20
	strb	r0, [r4]
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3307
.L3312:
	ldr	r1, .L3314+24
	bl	dprint_vfmw
	mov	r0, r5
	bl	HEVC_ClearDPB
	mvn	r0, #3
	b	.L3307
.L3315:
	.align	2
.L3314:
	.word	.LC428
	.word	.LC425
	.word	.LC426
	.word	.LC430
	.word	.LC431
	.word	.LC427
	.word	.LC429
	.fnend
	.size	HEVC_CreateLostPicture, .-HEVC_CreateLostPicture
	.align	2
	.global	HEVC_RefPicProcess
	.type	HEVC_RefPicProcess, %function
HEVC_RefPicProcess:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, fp, ip, lr, pc}
	.pad #4
	.save {r4, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #20
	sub	sp, sp, #20
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r4, r0
	bl	HEVC_RemoveDummyFrame
	mov	r0, r4
	bl	HEVC_ApplyReferencePictureSet
	mov	r0, r4
	bl	HEVC_RemoveUnusedApcStore
	mov	r0, r4
	bl	HEVC_RemoveUnUsedFrameStore
	b	.L3317
.L3320:
	ldr	r2, [fp, #-24]
	bl	dprint_vfmw
	ldr	r3, [r4, #2324]
	mov	r0, r4
	ldr	r2, [r3, #4]
	cmp	r2, #0
	beq	.L3318
	ldr	r1, [fp, #-24]
	bl	HEVC_CreateLostPicture
	cmp	r0, #0
	bne	.L3323
.L3317:
	sub	r1, fp, #24
	mov	r0, r4
	bl	HEVC_CheckThatAllRefPicsAreAvailable
	ldr	r1, .L3324
	cmp	r0, #0
	mov	r0, #1
	beq	.L3320
	mov	r0, r4
	bl	HEVC_UpdateReflist
	mov	r0, r4
	bl	HEVC_UpdateLTReflist
	mov	r0, r4
	bl	HEVC_RecoverDPBProcess
	mov	r0, #0
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L3318:
	ldr	ip, [fp, #-24]
	add	r4, r4, #53248
	ldr	r1, .L3324+4
	mov	r0, #1
	ldr	r3, [r4, #968]
	str	ip, [sp]
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L3323:
	mov	r0, r4
	bl	HEVC_RemoveDummyFrame
	mvn	r0, #0
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L3325:
	.align	2
.L3324:
	.word	.LC432
	.word	.LC433
	.fnend
	.size	HEVC_RefPicProcess, .-HEVC_RefPicProcess
	.align	2
	.global	HEVC_DecSlice
	.type	HEVC_DecSlice, %function
HEVC_DecSlice:
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
	ldr	r3, [r0, #2332]
	add	r5, r0, #53248
	ldr	r2, .L3384
	mov	ip, #0
	mov	r4, r0
	ldr	r1, [r3, #16]
	str	r1, [r5, #992]
	ldr	r1, [r3, #32]
	str	r1, [r5, #988]
	ldr	r1, [r0, #244]
	strb	ip, [r0, #1]
	ldr	r2, [r2, r1, asl #2]
	ldrsb	r1, [r2, #160]
	cmp	r1, #1
	beq	.L3373
.L3327:
	ldr	r3, [r5, #2508]
	cmp	r3, #1
	beq	.L3374
.L3328:
	ldr	r2, [r4, #208]
	ldr	r3, [r4, #144]
	cmp	r2, r3
	bcs	.L3375
	ldrb	r3, [r5, #281]
	cmp	r3, #0
	beq	.L3376
	mov	r0, r4
	bl	HEVC_PicTypeStatistic
	mov	r0, r4
	bl	HEVC_CalcStreamBits
	ldr	r3, [r5, #2508]
	cmp	r3, #2
	beq	.L3341
	ldrb	r3, [r5, #923]
	cmp	r3, #0
	beq	.L3377
.L3342:
	mov	r0, r4
	bl	HEVC_WriteSliceMsg
	cmp	r0, #0
	bne	.L3378
.L3345:
	ldr	r3, [r5, #996]
	mov	r0, #0
	mov	r2, #1
	str	r3, [r4, #288]
	ldr	r3, [r5, #968]
	str	r2, [r4, #168]
	str	r3, [r4, #252]
.L3331:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L3377:
	mov	r0, r4
	bl	HEVC_DecList
	cmp	r0, #0
	bne	.L3379
	mov	r0, r4
	bl	HEVC_IsRefListWrong
	cmp	r0, #0
	beq	.L3342
	mov	r0, r4
	bl	HEVC_PrintDPBState
	ldr	r1, .L3384+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3331
.L3374:
	ldr	r3, [r5, #992]
	sub	r3, r3, #16
	cmp	r3, #4
	bls	.L3329
	mov	r0, r4
	bl	HEVC_IsPVRFlushPic
	cmp	r0, #0
	beq	.L3330
.L3329:
	mov	r0, r4
	bl	HEVC_FlushOutputFrmFromDPB
	cmp	r0, #0
	bne	.L3380
.L3330:
	ldrb	r6, [r4, #2]
	cmp	r6, #1
	beq	.L3381
.L3332:
	ldr	r2, [r4, #2324]
	ldr	r3, [r4, #220]
	add	r3, r3, #1
	str	r3, [r4, #220]
	ldr	r3, [r2, #8]
	cmp	r3, #2
	beq	.L3334
	ldr	r3, [r2, #12]
	mov	r0, r4
	cmp	r3, #2
	beq	.L3382
	bl	HEVC_RefPicProcess
	cmp	r0, #0
	bne	.L3347
.L3334:
	mov	r0, r4
	bl	HEVC_InitPic
	cmn	r0, #2
	beq	.L3331
	cmp	r0, #0
	bne	.L3383
	mov	r0, r4
	bl	HEVC_SetScalingList
	mov	r0, r4
	bl	HEVC_WritePicMsg
	cmp	r0, #0
	beq	.L3328
	ldr	r1, .L3384+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3331
.L3373:
	ldr	r1, [r2, #168]
	cmp	r1, ip
	bne	.L3327
	ldr	r2, [r2, #172]
	cmp	r2, #1
	bne	.L3327
	ldr	r1, [r3, #16]
	bl	HEVC_Get_Last_IDR_Frame_Info
	b	.L3327
.L3341:
	ldr	r1, [r4, #2332]
	cmp	r1, #0
	beq	.L3345
	ldr	r0, [r4, #244]
	bl	HEVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #2332]
	b	.L3345
.L3381:
	ldr	r3, [r4, #2508]
	cmp	r3, #0
	beq	.L3332
	mov	r0, r4
	bl	HEVC_EmptyFrmFromDPB
	cmp	r0, #0
	beq	.L3332
	mov	r0, r6
	ldr	r2, .L3384+12
	ldr	r1, .L3384+16
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3331
.L3382:
	bl	HEVC_UpdateReflist
	mov	r0, r4
	bl	HEVC_UpdateLTReflist
	b	.L3334
.L3376:
	ldr	r1, .L3384+20
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3331
.L3375:
	ldr	r1, .L3384+24
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r3, [r4, #208]
	ldr	r2, [r4, #144]
	cmp	r3, r2
	bcc	.L3339
	ldr	r1, .L3384+28
	ldr	ip, [r1]
	cmp	ip, #0
	beq	.L3339
	str	r3, [fp, #-36]
	mov	r1, #108
	str	r2, [fp, #-32]
	mov	r3, #8
	sub	r2, fp, #36
	ldr	r0, [r4, #244]
	blx	ip
.L3339:
	ldr	r1, .L3384+32
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	bl	HEVC_ClearCurrPic
	mvn	r0, #0
	b	.L3331
.L3379:
	mov	r2, r0
	ldr	r1, .L3384+36
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3331
.L3378:
	ldr	r1, .L3384+40
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3331
.L3383:
	ldr	r1, .L3384+44
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3331
.L3347:
	mvn	r0, #0
	b	.L3331
.L3380:
	ldr	r2, .L3384+12
	mov	r0, #1
	ldr	r1, .L3384+48
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3331
.L3385:
	.align	2
.L3384:
	.word	s_pstVfmwChan
	.word	.LC442
	.word	.LC437
	.word	.LANCHOR1+844
	.word	.LC435
	.word	.LC440
	.word	.LC438
	.word	g_event_report
	.word	.LC439
	.word	.LC441
	.word	.LC443
	.word	.LC436
	.word	.LC434
	.fnend
	.size	HEVC_DecSlice, .-HEVC_DecSlice
	.align	2
	.global	HEVCDEC_VDMPostProc
	.type	HEVCDEC_VDMPostProc, %function
HEVCDEC_VDMPostProc:
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
	add	r2, r0, #53248
	mov	r5, r3
	mov	r4, r0
	str	r1, [r2, #320]
	bl	HEVC_ClearAllSlice
	mov	r1, r5
	mov	r0, r4
	bl	HEVC_StorePicInDPB
	subs	r2, r0, #0
	bne	.L3389
	mov	r3, #1
	mov	r0, r2
	str	r3, [r4, #168]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L3389:
	ldr	r1, .L3390
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, r4
	bl	HEVC_ClearCurrPic
	mov	r0, r4
	bl	HEVC_ClearDPB
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L3391:
	.align	2
.L3390:
	.word	.LC444
	.fnend
	.size	HEVCDEC_VDMPostProc, .-HEVCDEC_VDMPostProc
	.align	2
	.global	HEVC_DecVDM
	.type	HEVC_DecVDM, %function
HEVC_DecVDM:
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
	ldr	r3, [r0, #172]
	mov	r4, r0
	cmp	r3, #2
	bhi	.L3393
	bl	HEVC_ClearCurrPic
	ldr	r3, [r4, #224]
	cmp	r3, #524288
	bhi	.L3444
	ldr	r1, .L3450
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
.L3438:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L3393:
	ldr	r3, [r0, #280]
	add	r6, r0, #53248
	ldr	r2, [r0, #284]
	add	r3, r3, #1
	ldr	r1, [r0, #2324]
	cmp	r3, r2
	movlt	r3, r2
	str	r3, [r0, #280]
	rsb	r3, r2, r3
	str	r3, [r1, #572]
	bl	HEVC_IsRefForCurrPic
	strb	r0, [r6, #280]
	ldr	r5, [r4, #232]
	ldr	r2, [r4, #248]
	ubfx	r5, r5, #16, #3
	cmp	r5, r2
	beq	.L3396
	sub	r1, r2, #2
	cmp	r1, #1
	movhi	r1, #0
	movls	r1, #1
	cmp	r5, #2
	moveq	r1, #0
	cmp	r1, #0
	beq	.L3396
	cmp	r5, #4
	cmpne	r5, #1
	bls	.L3445
.L3396:
	cmp	r5, #2
	str	r5, [r4, #248]
	beq	.L3398
	cmp	r5, #3
	beq	.L3399
	cmp	r5, #1
	beq	.L3446
	ldr	r3, [r4, #216]
	cmp	r3, #0
	beq	.L3441
	cmp	r5, #4
	beq	.L3447
.L3403:
	ldr	r2, [r6, #292]
.L3404:
	cmp	r2, #2
	beq	.L3448
	cmp	r2, #1
	streqb	r2, [r4, #4]
.L3409:
	ldr	r2, [r4, #220]
	mov	r0, #2
	ldr	r1, .L3450+4
	sub	r2, r2, #1
	bl	dprint_vfmw
	ldr	r5, [r4, #208]
	cmp	r5, #0
	beq	.L3449
	ldr	r1, [r6, #308]
	add	r3, r4, #61440
	clz	r2, r1
	mov	r2, r2, lsr #5
	str	r2, [r3, #1880]
	ldr	r2, [r6, #312]
	str	r5, [r3, #3112]
	str	r2, [r3, #1872]
	ldr	r2, [r4, #2324]
	ldr	r0, [r2, #588]
	str	r0, [r3, #1864]
	ldr	r2, [r2, #624]
	str	r2, [r3, #1868]
	ldr	r2, [r4, #220]
	cmp	r2, #0
	beq	.L3440
	add	r0, r4, #61952
	add	r2, r1, #1
	add	r0, r0, #36
	str	r0, [r4, #2328]
	ldr	r1, [r6, #292]
	str	r2, [r6, #308]
	cmp	r1, #0
	bne	.L3440
	ldr	r2, [r3, #3116]
	cmp	r2, #0
	beq	.L3415
.L3414:
	ldr	r3, [r2]
	ldr	r0, [r2, #4]
	ldr	r2, [r2, #1356]
	add	r3, r3, r0
	add	r3, r3, #7
	cmp	r2, #0
	add	r1, r1, r3, lsr #3
	bne	.L3414
.L3413:
	ldr	r3, .L3450+8
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L3440
	sub	r2, fp, #28
	ldr	r0, [r4, #244]
	mov	r3, #4
	str	r1, [r2, #-4]!
	mov	r1, #20
	blx	ip
.L3440:
	mov	r0, #0
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L3444:
	ldr	r1, .L3450+12
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #7
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L3446:
	ldr	r3, [r6, #292]
	cmp	r0, #0
	cmpeq	r3, #2
	beq	.L3441
.L3401:
	ldr	r3, [r4, #216]
	cmp	r3, #0
	bne	.L3403
	b	.L3441
.L3445:
	mov	r3, r5
	ldr	r1, .L3450+16
	mov	r0, #1
	bl	dprint_vfmw
	str	r5, [r4, #248]
.L3399:
	mov	r0, r4
	bl	HEVC_ClearCurrPic
	mov	r0, r4
	bl	HEVC_ClearDPB
	mvn	r0, #0
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L3398:
	ldr	r3, [r6, #292]
	cmp	r3, #0
	beq	.L3401
	b	.L3441
.L3448:
	ldrb	r3, [r4, #4]
	cmp	r3, #2
	bne	.L3409
	ldr	r3, [r4, #2324]
	ldr	r3, [r3, #12]
	cmp	r3, #0
	bne	.L3409
	ldr	r3, .L3450+20
	ldrb	r3, [r3]
	cmp	r3, #1
	beq	.L3409
	mov	r3, r0
	ldr	r2, [r6, #288]
	ldr	r1, .L3450+24
	mov	r0, #1
	bl	dprint_vfmw
.L3441:
	mov	r0, r4
	bl	HEVC_ClearCurrPic
	mvn	r0, #0
	b	.L3438
.L3447:
	ldr	r2, [r6, #292]
	cmp	r2, #0
	moveq	r3, #2
	streqb	r3, [r4, #4]
	beq	.L3409
	b	.L3404
.L3415:
	mov	r1, r2
	b	.L3413
.L3449:
	mov	r0, r4
	bl	HEVC_ClearCurrPic
	mov	r0, r5
	ldr	r2, .L3450+28
	ldr	r1, .L3450+32
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3438
.L3451:
	.align	2
.L3450:
	.word	.LC446
	.word	.LC449
	.word	g_event_report
	.word	.LC445
	.word	.LC447
	.word	g_allow_B_before_P
	.word	.LC448
	.word	.LANCHOR1+860
	.word	.LC450
	.fnend
	.size	HEVC_DecVDM, .-HEVC_DecVDM
	.align	2
	.global	HEVC_VES_Splitter
	.type	HEVC_VES_Splitter, %function
HEVC_VES_Splitter:
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
	mov	r4, r0
	mov	r5, r1
	ldr	r0, [r0, #2308]
	mov	r1, #16
	mov	r9, r2
	str	r3, [fp, #-56]
	mov	r6, #0
	str	r6, [fp, #-48]
	bl	BsGet
	mov	r1, #8
	add	r7, r4, #53248
	mov	r10, r0
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #24
	and	r8, r0, #31
	ldr	r0, [r4, #2308]
	bl	BsBack
	movw	r2, #53808
	str	r6, [r7, #552]
	cmp	r5, r6
	ldr	r2, [r4, r2]
	str	r2, [fp, #-48]
	beq	.L3454
	cmp	r5, #1
	beq	.L3455
	mov	r2, r5
	ldr	r1, .L3605
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #1
.L3462:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3455:
	cmp	r9, #0
	bne	.L3472
	ldr	r3, [fp, #-56]
	movw	r2, #31745
	cmp	r10, r2
	cmpeq	r3, #1
	moveq	r0, #1
	movne	r0, #0
	cmp	r8, #25
	movne	r8, #0
	andeq	r8, r0, #1
	cmp	r8, #0
	bne	.L3601
	movw	r1, #32257
	cmp	r10, r1
	beq	.L3602
	cmp	r10, r2
	bne	.L3603
	ldr	r1, [r4, #2332]
	cmp	r1, #0
	beq	.L3471
	ldr	r0, [r4, #244]
	bl	HEVC_ReleaseNAL
	str	r8, [r4, #2332]
	mov	r0, r8
	b	.L3462
.L3454:
	cmp	r9, #0
	bne	.L3456
	movw	r1, #31745
	cmp	r8, #25
	cmpeq	r10, r1
	moveq	r5, #1
	movne	r5, #0
	bne	.L3457
	ldr	r8, .L3605+4
	ldr	ip, [r8]
	cmp	ip, #0
	beq	.L3458
	mov	r3, r9
	mov	r2, r9
	mov	r1, #112
	ldr	r0, [r4, #244]
	blx	ip
.L3458:
	mov	r0, r4
	bl	HEVC_DecVDM
	subs	r6, r0, #0
	bne	.L3597
	ldr	r3, [r4, #2332]
	ldr	r3, [r3, #48]
	sub	r2, r3, #2
	sub	r3, r3, #7
	cmp	r2, #1024
	str	r3, [r7, #552]
	movwhi	r3, #799
	bhi	.L3595
	ldr	r5, .L3605+8
	mov	r2, r3
	sub	r1, fp, #48
	ldr	r0, [r7, #556]
	bl	MEM_MapMemBlock
	mov	r2, #5
	ldr	r3, [r5, #52]
	ldr	r1, .L3605+12
	ldr	r0, [fp, #-48]
	blx	r3
	ldr	r2, [r4, #2332]
	ldr	r0, [fp, #-48]
	ldr	r3, [r5, #52]
	ldr	r1, [r2, #44]
	add	r0, r0, #5
	ldr	r2, [r7, #552]
	add	r1, r1, #6
	blx	r3
	ldr	r0, [r7, #552]
	add	r3, r0, #5
	str	r3, [r7, #552]
	ldr	r1, [r4, #2332]
	ldr	r2, [r1, #76]
	cmp	r2, #0
	beq	.L3466
	add	ip, r3, r2
	cmp	ip, #1024
	addhi	r2, r0, #10
	movwhi	r3, #814
	bhi	.L3595
.L3467:
	ldr	r0, [fp, #-48]
	ldr	r1, [r1, #72]
	add	r0, r0, r3
	ldr	r3, [r5, #52]
	blx	r3
	ldr	r3, [r4, #2332]
	ldr	r2, [r7, #552]
	ldr	r3, [r3, #76]
	add	r3, r3, r2
	str	r3, [r7, #552]
.L3466:
	ldr	r6, .L3605+16
	ldr	r3, [r4, #244]
	ldr	r3, [r6, r3, asl #2]
	cmp	r3, #0
	beq	.L3469
	ldr	r3, [r5, #16]
	mov	r0, #0
	blx	r3
	ldr	r2, [r4, #244]
	ldr	r3, [r5, #44]
	ldr	r1, [r7, #552]
	ldr	r2, [r6, r2, asl #2]
	ldr	r0, [fp, #-48]
	blx	r3
	ldr	r3, [r5, #12]
	mov	r0, #0
	blx	r3
.L3469:
	ldr	r0, [fp, #-48]
	bl	MEM_UnMapMemBlock
.L3579:
	ldr	r1, [r4, #2332]
	cmp	r1, #0
	beq	.L3471
	ldr	r0, [r4, #244]
	bl	HEVC_ReleaseNAL
	mov	r3, #0
	mov	r0, r3
	str	r3, [r4, #2332]
	b	.L3462
.L3456:
	bic	r3, r10, #512
	movw	r2, #31745
	cmp	r3, r2
	beq	.L3604
.L3491:
	mov	r0, #1
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3472:
	movw	r1, #31745
	cmp	r8, #25
	cmpeq	r10, r1
	moveq	r8, #1
	movne	r8, #0
	bne	.L3480
	ldr	r8, .L3605+4
	ldr	ip, [r8]
	cmp	ip, #0
	beq	.L3481
	mov	r3, r6
	mov	r2, r6
	mov	r1, #112
	ldr	r0, [r4, #244]
	blx	ip
.L3481:
	mov	r0, r4
	bl	HEVC_DecVDM
	subs	r6, r0, #0
	beq	.L3482
.L3597:
	ldr	r1, [r4, #2332]
.L3593:
	cmp	r1, #0
	beq	.L3488
	ldr	r0, [r4, #244]
	bl	HEVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #2332]
.L3488:
	ldr	ip, [r8]
	cmp	ip, #0
	beq	.L3575
	mov	r3, #0
	ldr	r0, [r4, #244]
	mov	r2, r3
	mov	r1, #113
	blx	ip
.L3575:
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3457:
	movw	r2, #32257
	cmp	r10, r2
	bne	.L3491
	ldr	r1, [r4, #2332]
	cmp	r1, #0
	beq	.L3471
.L3577:
	ldr	r0, [r4, #244]
	bl	HEVC_ReleaseNAL
	str	r5, [r4, #2332]
	mov	r0, r5
	b	.L3462
.L3480:
	movw	r2, #32257
	cmp	r10, r2
	movne	r0, r5
	bne	.L3462
	ldr	r1, .L3605+20
	movw	r3, #978
	ldr	r2, .L3605+24
	mov	r0, r8
	bl	dprint_vfmw
	ldr	r1, [r4, #2332]
	cmp	r1, #0
	beq	.L3575
	ldr	r0, [r4, #244]
	bl	HEVC_ReleaseNAL
	str	r8, [r4, #2332]
	mvn	r0, #0
	b	.L3462
.L3604:
	ldr	r1, .L3605+28
	movw	r3, #859
	ldr	r2, .L3605+24
	mov	r0, r5
	bl	dprint_vfmw
	ldr	r1, [r4, #2332]
	cmp	r1, #0
	beq	.L3575
	ldr	r0, [r4, #244]
	bl	HEVC_ReleaseNAL
	str	r5, [r4, #2332]
	mvn	r0, #0
	b	.L3462
.L3601:
	ldr	r8, .L3605+4
	ldr	ip, [r8]
	cmp	ip, #0
	beq	.L3474
	mov	r3, r9
	mov	r2, r9
	mov	r1, #112
	ldr	r0, [r4, #244]
	blx	ip
.L3474:
	mov	r0, r4
	bl	HEVC_DecVDM
	ldr	r1, [r4, #2332]
	subs	r5, r0, #0
	bne	.L3593
	cmp	r1, #0
	bne	.L3577
.L3471:
	mov	r0, #0
	b	.L3462
.L3482:
	ldr	r3, [r4, #2332]
	ldr	r3, [r3, #48]
	sub	r2, r3, #2
	sub	r3, r3, #7
	cmp	r2, #1024
	str	r3, [r7, #552]
	movwhi	r3, #937
	bhi	.L3595
	ldr	r5, .L3605+8
	mov	r2, r3
	sub	r1, fp, #48
	ldr	r0, [r7, #556]
	bl	MEM_MapMemBlock
	mov	r2, #5
	ldr	r3, [r5, #52]
	ldr	r1, .L3605+12
	ldr	r0, [fp, #-48]
	blx	r3
	ldr	r2, [r4, #2332]
	ldr	r0, [fp, #-48]
	ldr	r3, [r5, #52]
	ldr	r1, [r2, #44]
	add	r0, r0, #5
	ldr	r2, [r7, #552]
	add	r1, r1, #6
	blx	r3
	ldr	r0, [r7, #552]
	add	r3, r0, #5
	str	r3, [r7, #552]
	ldr	r1, [r4, #2332]
	ldr	r2, [r1, #76]
	cmp	r2, #0
	beq	.L3466
	add	ip, r3, r2
	cmp	ip, #1024
	bls	.L3467
	add	r2, r0, #10
	mov	r3, #952
.L3595:
	ldr	r1, .L3605+32
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r1, [r4, #2332]
	cmp	r1, #0
	beq	.L3488
	ldr	r0, [r4, #244]
	bl	HEVC_ReleaseNAL
	str	r6, [r4, #2332]
	b	.L3488
.L3603:
	mov	r1, #8
	ldr	r0, [r4, #2308]
	bl	BsGet
	mov	r1, #8
	mov	r5, r0
	ldr	r0, [r4, #2308]
	ubfx	r5, r5, #1, #6
	bl	BsSkip
	cmp	r5, #49
	bne	.L3579
	mov	r0, r4
	bl	HEVC_IsEosNal
	cmp	r0, #1
	bne	.L3579
	mov	r1, #16
	ldr	r0, [r4, #2308]
	bl	BsBack
	mov	r1, #32
	ldr	r0, [r4, #2308]
	bl	BsBack
	ldr	r0, [r4, #2308]
	mov	r1, #32
	bl	BsBack
	mov	r0, #2
	b	.L3462
.L3602:
	ldr	r0, [r4, #2308]
	mov	r1, #16
	bl	BsSkip
	mov	r0, r5
	b	.L3462
.L3606:
	.align	2
.L3605:
	.word	.LC454
	.word	g_event_report
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR4+208
	.word	vfmw_save_metadata_file
	.word	.LC453
	.word	.LANCHOR1+872
	.word	.LC452
	.word	.LC451
	.fnend
	.size	HEVC_VES_Splitter, .-HEVC_VES_Splitter
	.align	2
	.global	HEVC_DecOneNal
	.type	HEVC_DecOneNal, %function
HEVC_DecOneNal:
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
	mov	r4, r0
	ldr	r0, [r0, #2332]
	ldr	r3, [r0, #8]
	cmp	r3, #0
	ldrne	r1, [r4, #224]
	movne	r2, r0
	movne	r3, #0
	beq	.L3612
.L3611:
	ldr	ip, [r2, #48]
	add	r3, r3, #1
	add	r2, r2, #28
	add	r1, r1, ip
	str	r1, [r4, #224]
	ldr	ip, [r0, #8]
	cmp	ip, r3
	bhi	.L3611
.L3612:
	mov	r3, #0
	strb	r3, [r0, #1]
	ldr	r3, [r4, #2332]
	ldr	r2, [r3, #16]
	sub	r2, r2, #36
	cmp	r2, #1
	bls	.L3742
.L3610:
	ldr	r2, [r3, #4]
	add	r2, r2, #16
	str	r2, [r3, #4]
	ldr	r1, [r4, #2332]
	ldr	r2, [r1, #16]
	cmp	r2, #49
	ldrls	pc, [pc, r2, asl #2]
	b	.L3613
.L3615:
	.word	.L3614
	.word	.L3614
	.word	.L3614
	.word	.L3614
	.word	.L3614
	.word	.L3614
	.word	.L3614
	.word	.L3614
	.word	.L3614
	.word	.L3614
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3614
	.word	.L3614
	.word	.L3614
	.word	.L3614
	.word	.L3614
	.word	.L3614
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3616
	.word	.L3617
	.word	.L3618
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3619
	.word	.L3619
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3613
	.word	.L3620
	.word	.L3621
.L3742:
	mov	r2, #1
	strb	r2, [r4, #1]
	b	.L3610
.L3621:
	mov	r0, r4
	bl	HEVC_IsEosNal
	cmp	r0, #1
	beq	.L3743
.L3637:
	ldr	r1, [r4, #2332]
	cmp	r1, #0
	beq	.L3730
.L3732:
	ldr	r0, [r4, #244]
	bl	HEVC_ReleaseNAL
	mov	r3, #0
	mov	r0, r3
	str	r3, [r4, #2332]
.L3729:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3614:
	mov	r0, r4
	bl	HEVC_DecSlice
	cmn	r0, #2
	beq	.L3729
	cmp	r0, #0
	beq	.L3730
	ldr	r1, [r4, #2332]
	cmp	r1, #0
	beq	.L3740
	ldr	r0, [r4, #244]
	bl	HEVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #2332]
.L3740:
	ldr	r3, .L3745
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L3731
.L3733:
	mov	r3, #0
	ldr	r0, [r4, #244]
	mov	r2, r3
	mov	r1, #113
	blx	ip
.L3731:
	mvn	r0, #0
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3616:
	mov	r0, r4
	bl	HEVC_DecVPS
	ldr	r1, [r4, #2332]
	cmp	r1, #0
	mov	r5, r0
	beq	.L3622
	ldr	r0, [r4, #244]
	bl	HEVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #2332]
.L3622:
	cmp	r5, #0
	bne	.L3744
.L3730:
	mov	r0, #0
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3617:
	mov	r0, r4
	bl	HEVC_DecSPS
	ldr	r1, [r4, #2332]
	cmp	r1, #0
	mov	r5, r0
	beq	.L3627
	ldr	r0, [r4, #244]
	bl	HEVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #2332]
.L3627:
	cmp	r5, #0
	beq	.L3730
	ldr	r6, .L3745
	mov	r0, #1
	ldr	r1, .L3745+4
	bl	dprint_vfmw
	ldr	ip, [r6]
	cmp	ip, #0
	bne	.L3735
	b	.L3731
.L3618:
	mov	r0, r4
	bl	HEVC_DecPPS
	ldr	r1, [r4, #2332]
	cmp	r1, #0
	mov	r5, r0
	beq	.L3629
	ldr	r0, [r4, #244]
	bl	HEVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #2332]
.L3629:
	cmp	r5, #0
	beq	.L3730
	ldr	r6, .L3745
	mov	r0, #1
	ldr	r1, .L3745+8
	bl	dprint_vfmw
	ldr	ip, [r6]
	cmp	ip, #0
	beq	.L3731
.L3735:
	sub	r2, fp, #28
	mvn	r5, #0
	mov	r3, #4
	mov	r1, #100
	str	r5, [r2, #-4]!
	ldr	r0, [r4, #244]
	blx	ip
	ldr	ip, [r6]
	cmp	ip, #0
	bne	.L3733
	b	.L3731
.L3619:
	mov	r0, r4
	bl	HEVC_DecSEI
	ldr	r1, [r4, #2332]
	cmp	r1, #0
	mov	r5, r0
	beq	.L3630
	ldr	r0, [r4, #244]
	bl	HEVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #2332]
.L3630:
	cmp	r5, #0
	beq	.L3730
	ldr	r1, .L3745+12
	mov	r0, #1
	bl	dprint_vfmw
	b	.L3740
.L3620:
	ldrb	r3, [r4, #6]
	cmp	r3, #1
	beq	.L3635
	cmp	r1, #0
	beq	.L3634
	ldr	r0, [r4, #244]
	bl	HEVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #2332]
.L3634:
	add	r3, r4, #53248
	ldrb	r3, [r3, #281]
	cmp	r3, #0
	beq	.L3730
.L3635:
	add	r5, r4, #2464
	mov	r1, #32
	add	r5, r5, #8
	mov	r6, #0
	strb	r6, [r4, #6]
	mov	r0, r5
	bl	BsGet
	mov	r1, #32
	mov	r7, r0
	mov	r0, r5
	bl	BsGet
	movw	r1, #20036
	movw	r2, #20553
	movt	r1, 17221
	movt	r2, 18515
	cmp	r0, r1
	cmpeq	r7, r2
	bne	.L3730
	ldr	r5, .L3745
	ldr	ip, [r5]
	cmp	ip, #0
	beq	.L3636
	mov	r3, r6
	mov	r2, r6
	mov	r1, #112
	ldr	r0, [r4, #244]
	blx	ip
.L3636:
	mov	r0, r4
	bl	HEVC_DecVDM
	cmp	r0, #0
	beq	.L3730
.L3738:
	ldr	ip, [r5]
	cmp	ip, #0
	bne	.L3733
	b	.L3731
.L3613:
	ldr	r1, .L3745+16
	mov	r0, #22
	bl	dprint_vfmw
	ldr	r1, [r4, #2332]
	ldr	r3, [r1, #16]
	cmp	r3, #63
	bhi	.L3639
	cmp	r1, #0
	bne	.L3732
	b	.L3730
.L3639:
	ldr	r5, .L3745
	ldr	ip, [r5]
	cmp	ip, #0
	beq	.L3640
	mov	r3, #0
	mov	r1, #102
	mov	r2, r3
	ldr	r0, [r4, #244]
	blx	ip
	ldr	r1, [r4, #2332]
	cmp	r1, #0
	beq	.L3641
.L3642:
	ldr	r0, [r4, #244]
	bl	HEVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #2332]
.L3641:
	ldr	ip, [r5]
	cmp	ip, #0
	beq	.L3730
	mov	r3, #0
	ldr	r0, [r4, #244]
	mov	r2, r3
	mov	r1, #113
	blx	ip
	b	.L3730
.L3640:
	cmp	r1, #0
	bne	.L3642
	b	.L3730
.L3744:
	ldr	r6, .L3745
	mov	r0, #1
	ldr	r1, .L3745+20
	bl	dprint_vfmw
	ldr	ip, [r6]
	cmp	ip, #0
	bne	.L3735
	b	.L3731
.L3743:
	ldr	r5, .L3745
	strb	r0, [r4, #7]
	ldr	ip, [r5]
	cmp	ip, #0
	beq	.L3638
	mov	r3, #0
	mov	r1, #112
	mov	r2, r3
	ldr	r0, [r4, #244]
	blx	ip
.L3638:
	mov	r0, r4
	bl	HEVC_DecVDM
	cmp	r0, #0
	beq	.L3637
	b	.L3738
.L3746:
	.align	2
.L3745:
	.word	g_event_report
	.word	.LC456
	.word	.LC457
	.word	.LC458
	.word	.LC459
	.word	.LC455
	.fnend
	.size	HEVC_DecOneNal, .-HEVC_DecOneNal
	.align	2
	.global	HEVC_UnMarkFrameStoreRef
	.type	HEVC_UnMarkFrameStoreRef, %function
HEVC_UnMarkFrameStoreRef:
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
	mov	r2, r3
	strb	r3, [r1, #1]
	ldr	r1, [r1, #32]
	ldr	r0, [r0, #244]
	bl	FSP_SetRef
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_UnMarkFrameStoreRef, .-HEVC_UnMarkFrameStoreRef
	.align	2
	.global	HEVC_InquireSliceProperty
	.type	HEVC_InquireSliceProperty, %function
HEVC_InquireSliceProperty:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #12
	sub	sp, sp, #12
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	ip, .L3777
	mov	r4, r0
	mov	r3, #0
	mov	r6, r1
	add	r0, r0, #54016
	str	r3, [r2]
	mov	r1, r3
	str	r3, [r6]
	mov	r5, r2
	ldr	r3, [ip, #48]
	movw	r2, #3732
	add	r0, r0, #152
	blx	r3
	ldr	r3, [r4, #2332]
	add	r7, r4, #53248
	mov	r0, r4
	ldr	r2, [r3, #16]
	str	r2, [r7, #992]
	ldr	r3, [r3, #32]
	str	r3, [r7, #988]
	bl	HEVC_DecSliceSegmentHeader
	cmp	r0, #0
	bne	.L3773
	ldr	r0, [r7, #2508]
	movw	r1, #2024
	add	ip, r4, #24576
	movw	r3, #26164
	sub	r0, r0, #1
	clz	r0, r0
	mov	r0, r0, lsr #5
	str	r0, [r6]
	ldr	r0, [r7, #996]
	ldr	r2, [r4, #2320]
	ldr	lr, [r4, #2324]
	ldr	r6, [r4, #2316]
	mla	r1, r1, r0, r2
	ldr	r2, [ip, #2780]
	ldr	r0, [lr, #824]
	ldr	r7, [r2, #76]
	cmp	r0, #1
	ldr	r0, [r2, #72]
	ldr	r2, [r1, #32]
	mla	r3, r3, r2, r6
	ldr	r6, [r3, #72]
	ldr	r1, [r3, #76]
	beq	.L3774
.L3752:
	ldrb	r3, [r3, #2]
	cmp	r3, #0
	beq	.L3775
.L3755:
	mov	r3, #1
	str	r3, [r5]
.L3757:
	ldr	r3, [r4, #220]
	cmp	r3, #0
	beq	.L3772
	ldr	r3, .L3777+4
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L3772
	mov	r3, #0
	ldr	r0, [r4, #244]
	mov	r2, r3
	mov	r1, #120
	blx	ip
.L3772:
	mov	r0, #0
.L3750:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L3775:
	cmp	r1, r7
	cmpeq	r6, r0
	bne	.L3755
	ldr	r3, [r5]
	cmp	r3, #1
	bne	.L3772
	b	.L3757
.L3773:
	ldr	r1, .L3777+8
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L3777+4
	ldr	ip, [r3]
	cmp	ip, #0
	mvneq	r0, #0
	beq	.L3750
	sub	r2, fp, #36
	ldr	r0, [r4, #244]
	mov	r3, #4
	mvn	r4, #0
	mov	r1, #100
	str	r4, [r2, #-4]!
	blx	ip
	mov	r0, r4
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L3774:
	ldr	r2, [r3, #108]
	ldr	r8, [r3, #100]
	cmp	r2, r8
	movcc	r2, r8
	str	r2, [lr, #876]
	ldr	ip, [ip, #2780]
	ldr	lr, [r4, #2324]
	ldr	r2, [ip, #108]
	ldr	ip, [ip, #100]
	ldr	r8, [lr, #876]
	cmp	r2, ip
	movcc	r2, ip
	cmp	r2, #8
	movls	ip, #0
	movhi	ip, #1
	cmp	r8, #8
	movne	ip, #0
	cmp	ip, #0
	beq	.L3776
.L3753:
	mov	r2, #1
	str	r2, [lr, #880]
	str	r2, [r5]
	b	.L3752
.L3776:
	sub	r2, r2, #8
	cmp	r8, #8
	clz	r2, r2
	mov	r2, r2, lsr #5
	movle	r2, #0
	cmp	r2, #0
	beq	.L3752
	b	.L3753
.L3778:
	.align	2
.L3777:
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_event_report
	.word	.LC460
	.fnend
	.size	HEVC_InquireSliceProperty, .-HEVC_InquireSliceProperty
	.align	2
	.global	HEVCDEC_DecodePacket
	.type	HEVCDEC_DecodePacket, %function
HEVCDEC_DecodePacket:
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
	cmp	r1, #0
	mov	ip, #0
	mov	r4, r0
	str	ip, [fp, #-64]
	str	ip, [fp, #-60]
	str	ip, [fp, #-56]
	beq	.L3858
	ldrb	r3, [r0]
	cmp	r3, #1
	bne	.L3859
	ldr	r2, [r0, #2324]
	ldrb	lr, [r0, #5]
	ldr	r3, [r2, #8]
	cmp	lr, #1
	mov	r3, r3, asl #16
	and	r3, r3, #458752
	str	r3, [r0, #232]
	ldr	r3, [r2]
	str	r3, [r0, #236]
	ldr	r3, [r2, #4]
	str	r3, [r0, #240]
	beq	.L3783
	ldr	r3, [r2, #824]
	cmp	r3, #1
	addne	r5, r0, #81920
	beq	.L3860
.L3784:
	mov	r0, r4
	bl	HEVC_ReceivePacket
	ldr	r3, [r4, #2332]
	str	r3, [r5, #2900]
	mov	r6, r0
.L3785:
	cmp	r6, #0
	mov	r3, #0
	strb	r3, [r4, #5]
	beq	.L3786
.L3811:
	mov	r0, #0
.L3855:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3860:
	ldr	r3, [r2, #864]
	add	r5, r0, #81920
	cmp	r3, #1
	bne	.L3784
	ldr	r3, [r5, #2896]
	cmp	r3, #1
	bne	.L3784
	ldr	r3, [r5, #2900]
	mov	r0, ip
	str	r3, [r4, #2332]
	str	ip, [r5, #2896]
	strb	ip, [r4, #5]
	b	.L3855
.L3786:
	ldr	r3, [r4, #2332]
	ldr	r8, .L3869
	str	r6, [r3, #4]
	ldr	r3, [r4, #2332]
	ldr	r0, [r4, #2308]
	ldr	r1, [r3, #44]
	ldr	r2, [r3, #48]
	bl	BsInit
	mov	r1, #24
	ldr	r0, [r4, #2308]
	bl	BsSkip
	ldr	r3, [r4, #244]
	ldr	r3, [r8, r3, asl #2]
	ldrsb	r7, [r3, #160]
	cmp	r7, #1
	movne	r5, #2
	movne	r9, r5
	beq	.L3861
.L3787:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	ldr	r7, [r4, #2332]
	bl	BsGet
	mov	r1, #6
	str	r0, [r7, #24]
	ldr	r0, [r4, #2308]
	ldr	r7, [r4, #2332]
	bl	BsGet
	mov	r1, #6
	str	r0, [r7, #16]
	ldr	r0, [r4, #2308]
	ldr	r7, [r4, #2332]
	bl	BsGet
	mov	r1, #3
	str	r0, [r7, #28]
	ldr	r0, [r4, #2308]
	ldr	r7, [r4, #2332]
	bl	BsGet
	sub	r0, r0, #1
	str	r0, [r7, #32]
	ldr	r7, [r4, #2332]
	ldr	r0, [r7, #16]
	bl	HEVC_IsSliceUnit
	cmp	r0, #1
	mov	r10, r0
	beq	.L3862
.L3788:
	mov	r3, #0
	str	r3, [r7, #4]
	ldr	r3, [r4, #2332]
	add	r0, r4, #2464
	add	r0, r0, #8
	ldr	r2, [r3, #48]
	ldr	r1, [r3, #44]
	bl	BsInit
	mov	r1, #24
	ldr	r0, [r4, #2308]
	bl	BsSkip
	cmp	r5, #0
	cmpeq	r9, #1
	moveq	r2, #1
	movne	r2, #0
	cmp	r6, #1
	moveq	r0, #0
	andne	r0, r2, #1
	cmp	r0, #0
	beq	.L3810
	mov	r1, #16
	ldr	r0, [r4, #2308]
	bl	BsSkip
.L3810:
	mov	r1, #1
	ldr	r0, [r4, #2308]
	ldr	r5, [r4, #2332]
	bl	BsGet
	mov	r1, #6
	str	r0, [r5, #24]
	ldr	r0, [r4, #2308]
	ldr	r5, [r4, #2332]
	bl	BsGet
	mov	r1, #6
	str	r0, [r5, #16]
	ldr	r0, [r4, #2308]
	ldr	r5, [r4, #2332]
	bl	BsGet
	mov	r1, #3
	str	r0, [r5, #28]
	ldr	r0, [r4, #2308]
	ldr	r5, [r4, #2332]
	bl	BsGet
	sub	r0, r0, #1
	str	r0, [r5, #32]
.L3809:
	mov	r0, r4
	bl	HEVC_DecOneNal
	cmn	r0, #2
	beq	.L3855
	cmp	r0, #0
	beq	.L3811
	ldr	r1, .L3869+4
	mov	r0, #22
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3855
.L3783:
	ldr	r3, [r0, #2332]
	cmp	r3, #0
	movne	r6, #0
	mvneq	r6, #0
	cmp	r3, #0
	bne	.L3785
	mov	r0, ip
	ldr	r1, .L3869+8
	bl	dprint_vfmw
	mov	r0, r6
	b	.L3855
.L3861:
	ldr	r9, [r3, #164]
	mov	r0, r4
	ldr	r5, [r3, #168]
	ldr	r3, [r3, #172]
	mov	r1, r9
	mov	r2, r5
	bl	HEVC_VES_Splitter
	cmp	r0, #2
	beq	.L3813
	cmp	r0, #1
	bne	.L3855
	b	.L3787
.L3862:
	sub	r2, fp, #48
	sub	r1, fp, #52
	mov	r0, r4
	bl	HEVC_InquireSliceProperty
	subs	r3, r0, #0
	bne	.L3789
	ldr	r7, [fp, #-52]
	cmp	r7, #1
	beq	.L3863
.L3790:
	ldr	r7, [fp, #-48]
	cmp	r7, #1
	beq	.L3864
.L3806:
	ldr	r7, [r4, #2332]
	ldr	r0, [r7, #16]
	bl	HEVC_IsSliceUnit
	cmp	r0, #1
	beq	.L3809
	b	.L3788
.L3859:
	mov	r0, ip
	ldr	r1, .L3869+12
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3855
.L3813:
	mov	r6, r7
	b	.L3787
.L3789:
	ldr	r1, .L3869+16
	mov	r0, r10
	bl	dprint_vfmw
	ldr	r1, [r4, #2332]
	cmp	r1, #0
	beq	.L3807
	ldr	r0, [r4, #244]
	bl	HEVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #2332]
.L3807:
	ldr	r3, .L3869+20
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L3808
	mov	r3, #0
	mov	r1, #113
	mov	r2, r3
	ldr	r0, [r4, #244]
	blx	ip
.L3808:
	ldr	r3, [r4, #244]
	ldr	r3, [r8, r3, asl #2]
	ldrsb	r2, [r3, #160]
	cmp	r2, #1
	bne	.L3818
	ldr	r2, [r3, #168]
	cmp	r2, #0
	bne	.L3818
	ldr	r3, [r3, #172]
	cmp	r3, #1
	bne	.L3818
	add	r3, r4, #24576
	ldrb	r5, [r3, #2768]
	cmp	r5, #0
	beq	.L3865
.L3818:
	mvn	r0, #0
	b	.L3855
.L3863:
	ldr	r2, [r4, #208]
	cmp	r2, #0
	bne	.L3791
	add	r3, r4, #53248
	ldrb	r3, [r3, #281]
	cmp	r3, #0
	beq	.L3790
	ldr	r2, .L3869+24
	ldr	r1, .L3869+28
	bl	dprint_vfmw
	mov	r0, r4
	bl	HEVC_ClearCurrPic
	b	.L3790
.L3864:
	add	r3, r4, #53248
	ldr	r3, [r3, #992]
	sub	r3, r3, #16
	cmp	r3, #4
	bls	.L3866
.L3795:
	ldrb	r7, [r4, #2]
	cmp	r7, #1
	beq	.L3867
.L3798:
	ldr	r0, [r4, #244]
	bl	FSP_GetFspType
	cmp	r0, #0
	bne	.L3806
	sub	r3, fp, #56
	ldr	r0, [r4, #244]
	sub	r2, fp, #60
	sub	r1, fp, #64
	bl	VCTRL_GetChanImgNum
	ldr	r3, [r4, #2324]
	ldr	r0, [r3, #700]
	cmp	r0, #1
	bne	.L3806
	ldr	r2, [fp, #-60]
	ldr	r3, [fp, #-56]
	add	r1, r2, r3
	cmp	r1, #1
	bgt	.L3801
	cmp	r2, #0
	cmpeq	r3, #1
	beq	.L3801
	cmp	r2, #1
	cmpeq	r3, #0
	bne	.L3806
	add	r7, r4, #61440
	ldrh	r3, [r7, #196]
	add	r3, r3, #15360
	add	r3, r3, #50
	add	r3, r4, r3, lsl #2
	ldr	r3, [r3, #4]
	ldr	r3, [r3, #44]
	cmp	r3, #0
	beq	.L3806
	cmp	r2, #32
	ble	.L3802
	mov	r3, #32
	ldr	r1, .L3869+32
	bl	dprint_vfmw
	ldr	r2, [fp, #-60]
.L3802:
	mov	lr, #0
.L3803:
	sxth	r10, lr
	cmp	r10, r2
	add	ip, r10, #14784
	add	ip, ip, #53
	bge	.L3868
	ldrh	r3, [r7, #196]
	mov	ip, ip, asl #4
	add	r3, lr, r3
	add	lr, lr, #1
	and	r3, r3, #63
	add	r3, r4, r3, lsl #2
	add	r3, r3, #61440
	ldr	r1, [r3, #204]
	ldr	r0, [r1, #44]
	cmp	r0, #0
	beq	.L3803
	ldr	r1, [r4, #244]
	ldr	r1, [r8, r1, asl #2]
	add	r1, r1, r10, lsl #4
	add	r1, r1, #236544
	str	r0, [r1, #844]
	ldr	r3, [r3, #204]
	ldr	r1, [r4, #244]
	add	r3, r3, #480
	ldr	r10, [r8, r1, asl #2]
	ldrd	r0, [r3, #-8]
	strd	r0, [r10, ip]
	b	.L3803
.L3791:
	ldr	ip, [r4, #2332]
	add	r0, r4, #2464
	mov	r2, #13
	add	r0, r0, #8
	ldr	r1, .L3869+36
	str	r3, [ip, #4]
	bl	BsInit
	mov	r1, #40
	ldr	r0, [r4, #2308]
	bl	BsSkip
	ldr	r3, [r4, #2332]
	mov	r2, #48
	mov	r0, r4
	str	r2, [r3, #16]
	strb	r7, [r4, #6]
	bl	HEVC_DecOneNal
	ldr	r3, [r4, #272]
	mvn	r0, #1
	strb	r7, [r4, #5]
	add	r3, r3, #1
	str	r3, [r4, #272]
	b	.L3855
.L3858:
	mov	r0, r1
	ldr	r1, .L3869+40
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3855
.L3865:
	ldr	r3, .L3869+44
	add	r0, r4, #27136
	mov	r2, #80
	add	r0, r0, #136
	mov	r1, r5
	mov	r6, #0
	ldr	r3, [r3, #48]
	mov	r7, #0
	blx	r3
	add	r3, r4, #4544
	add	r2, r3, #2096
	add	r4, r4, #4096
	add	r3, r3, #2080
	mvn	r0, #0
	strd	r6, [r2]
	strd	r6, [r3, #-8]
	strd	r6, [r3]
	strd	r6, [r2, #-8]
	str	r5, [r4, #428]
	str	r5, [r4, #432]
	str	r5, [r4, #420]
	str	r5, [r4, #424]
	b	.L3855
.L3866:
	mov	r0, r4
	bl	HEVC_FlushOutputFrmFromDPB
	cmp	r0, #0
	beq	.L3795
	mov	r0, r7
	ldr	r2, .L3869+48
	ldr	r1, .L3869+52
	bl	dprint_vfmw
	b	.L3795
.L3867:
	mov	r0, r4
	bl	HEVC_EmptyFrmFromDPB
	cmp	r0, #0
	beq	.L3798
	mov	r0, r7
	ldr	r2, .L3869+48
	ldr	r1, .L3869+56
	bl	dprint_vfmw
	b	.L3798
.L3801:
	add	r2, r4, #81920
	mov	r1, #0
	mov	r3, #1
	mvn	r0, #1
	str	r1, [r2, #2916]
	strb	r3, [r4, #5]
	b	.L3855
.L3868:
	ldr	r3, [r4, #244]
	ldr	r3, [r8, r3, asl #2]
	add	r3, r3, #237568
	str	r2, [r3, #328]
	b	.L3806
.L3870:
	.align	2
.L3869:
	.word	s_pstVfmwChan
	.word	.LC467
	.word	.LC463
	.word	.LC462
	.word	.LC466
	.word	g_event_report
	.word	.LANCHOR1+892
	.word	.LC464
	.word	.LC465
	.word	.LANCHOR1+936
	.word	.LC461
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR1+912
	.word	.LC434
	.word	.LC435
	.fnend
	.size	HEVCDEC_DecodePacket, .-HEVCDEC_DecodePacket
	.align	2
	.global	HEVC_HaveSliceToDec
	.type	HEVC_HaveSliceToDec, %function
HEVC_HaveSliceToDec:
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
	ldr	r0, [r0, #208]
	cmp	r0, #0
	bne	.L3873
	add	r3, r4, #53248
	ldrb	r3, [r3, #281]
	cmp	r3, #0
	bne	.L3875
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L3873:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L3875:
	ldr	r2, .L3876
	ldr	r1, .L3876+4
	bl	dprint_vfmw
	mov	r0, r4
	bl	HEVC_ClearCurrPic
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L3877:
	.align	2
.L3876:
	.word	.LANCHOR1+892
	.word	.LC464
	.fnend
	.size	HEVC_HaveSliceToDec, .-HEVC_HaveSliceToDec
	.align	2
	.global	HEVC_GetPicStreamSize
	.type	HEVC_GetPicStreamSize, %function
HEVC_GetPicStreamSize:
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
	add	r0, r0, #61440
	ldr	r2, [r0, #3116]
	cmp	r2, #0
	beq	.L3881
	mov	r0, #0
.L3880:
	ldr	r3, [r2]
	ldr	r1, [r2, #4]
	ldr	r2, [r2, #1356]
	add	r3, r3, r1
	add	r3, r3, #7
	cmp	r2, #0
	add	r0, r0, r3, lsr #3
	bne	.L3880
	ldmfd	sp, {fp, sp, pc}
.L3881:
	mov	r0, r2
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVC_GetPicStreamSize, .-HEVC_GetPicStreamSize
	.align	2
	.global	HEVCDEC_GetRemainImg
	.type	HEVCDEC_GetRemainImg, %function
HEVCDEC_GetRemainImg:
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
	ldr	r3, [r0, #2508]
	mov	r4, r0
	cmp	r3, #0
	addne	r8, r0, #61440
	addne	r8, r8, #192
	mvnne	r6, #0
	movne	r7, #1
	bne	.L3894
	b	.L3895
.L3886:
	mov	r0, r4
	bl	HEVC_RemoveApcStore
	ldr	r1, [fp, #-52]
	mov	r0, r4
	bl	HEVC_RemoveFrameStoreOutDPB
	ldr	r2, [r4, #2508]
	cmp	r2, #0
	beq	.L3903
.L3894:
	sub	r1, fp, #48
	sub	r2, fp, #52
	mov	r0, r4
	bl	HEVC_GetMinPOC
	ldr	r1, [fp, #-52]
	add	r3, r1, #632
	ldr	r5, [r4, r3, asl #2]
	cmp	r5, #0
	beq	.L3886
	ldrb	r3, [r5, #2]
	cmp	r3, #0
	bne	.L3886
	mov	r1, r5
	mov	r0, r4
	strb	r7, [r5, #2]
	bl	HEVC_GetImagePara
	mov	r1, r5
	mov	r0, r4
	bl	HEVC_CheckFrameStore
	subs	r6, r0, #0
	beq	.L3904
.L3893:
	ldr	r1, [fp, #-52]
	b	.L3886
.L3903:
	cmp	r6, #0
	bne	.L3895
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3904:
	mov	r2, #1
	ldr	r1, [r5, #32]
	ldr	r0, [r4, #244]
	bl	FSP_SetDisplay
	ldr	r1, [r5, #32]
	ldr	r0, [r4, #244]
	bl	FSP_GetFsImagePtr
	subs	r9, r0, #0
	beq	.L3905
	ldr	r3, [r4, #2508]
	mov	r2, r4
	mov	r1, #16
	cmp	r3, #1
	streq	r3, [r9, #188]
	mov	r3, r8
	ldr	r0, [r4, #244]
	str	r9, [sp]
	bl	InsertImgToVoQueue
	cmp	r0, #1
	mov	r10, r0
	beq	.L3890
	mov	r3, r0
	ldr	r2, .L3907
	ldr	r1, .L3907+4
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r1, [r5, #32]
	ldr	r0, [r4, #244]
	mov	r2, #0
	bl	FSP_SetDisplay
	mov	r1, #1
	mov	r0, r4
	mvn	r10, #0
	bl	HEVC_ClearAll
.L3890:
	ldr	r3, [r4, #2324]
	ldr	r2, [r3, #600]
	add	r2, r2, #2032
	add	r2, r2, #15
	cmp	r2, #4096
	movcc	r3, #0
	strcc	r3, [r9, #24]
	bcs	.L3906
.L3892:
	ldr	r1, [r4, #2508]
	ldr	r3, [r4, #284]
	ldr	r2, [r4, #276]
	cmp	r1, #1
	add	r3, r3, #1
	str	r3, [r4, #284]
	add	r2, r2, #1
	str	r2, [r4, #276]
	beq	.L3893
	mov	r6, r10
	ldr	r1, [fp, #-52]
	b	.L3886
.L3895:
	add	r0, r4, #61440
	add	r0, r0, #192
	bl	GetVoLastImageID
	mov	r6, r0
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3906:
	mov	r1, r9
	mov	r0, r4
	bl	HEVC_SetFrmRepeatCount.part.4
	b	.L3892
.L3905:
	ldr	r1, .L3907+8
	mvn	r6, #0
	ldr	r2, .L3907
	bl	dprint_vfmw
	ldr	r1, [fp, #-52]
	b	.L3886
.L3908:
	.align	2
.L3907:
	.word	.LANCHOR1+952
	.word	.LC469
	.word	.LC468
	.fnend
	.size	HEVCDEC_GetRemainImg, .-HEVCDEC_GetRemainImg
	.align	2
	.global	HEVCDEC_GetImageWidth
	.type	HEVCDEC_GetImageWidth, %function
HEVCDEC_GetImageWidth:
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
	add	r0, r0, #24576
	ldr	r2, [r0, #2780]
	ldr	r3, [r2, #152]
	ldr	r2, [r2, #72]
	rsb	r0, r3, #0
	add	r3, r3, r2
	sub	r3, r3, #1
	and	r0, r0, r3
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVCDEC_GetImageWidth, .-HEVCDEC_GetImageWidth
	.align	2
	.global	HEVCDEC_GetImageHeight
	.type	HEVCDEC_GetImageHeight, %function
HEVCDEC_GetImageHeight:
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
	add	r0, r0, #24576
	ldr	r2, [r0, #2780]
	ldr	r3, [r2, #152]
	ldr	r2, [r2, #76]
	rsb	r0, r3, #0
	add	r3, r3, r2
	sub	r3, r3, #1
	and	r0, r0, r3
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HEVCDEC_GetImageHeight, .-HEVCDEC_GetImageHeight
	.global	g_IsDeced
	.global	g_TsToRsMap
	.global	s_TmpParam
	.global	RPU_START_CODE
	.section	.rodata
	.align	2
.LANCHOR1 = . + 0
	.type	SarTable.14749, %object
	.size	SarTable.14749, 136
SarTable.14749:
	.word	1
	.word	1
	.word	1
	.word	1
	.word	12
	.word	11
	.word	10
	.word	11
	.word	16
	.word	11
	.word	40
	.word	33
	.word	24
	.word	11
	.word	20
	.word	11
	.word	32
	.word	11
	.word	80
	.word	33
	.word	18
	.word	11
	.word	15
	.word	11
	.word	64
	.word	33
	.word	160
	.word	99
	.word	4
	.word	3
	.word	3
	.word	2
	.word	2
	.word	1
	.type	__func__.14928, %object
	.size	__func__.14928, 18
__func__.14928:
	.ascii	"HEVC_CalcTileInfo\000"
	.space	2
	.type	__func__.15358, %object
	.size	__func__.15358, 27
__func__.15358:
	.ascii	"HEVC_GetUnRefPicWithMinPoc\000"
	.space	1
	.type	__func__.15366, %object
	.size	__func__.15366, 21
__func__.15366:
	.ascii	"HEVC_IncreaseDPBSize\000"
	.space	3
	.type	__func__.15597, %object
	.size	__func__.15597, 17
__func__.15597:
	.ascii	"HEVC_WritePicMsg\000"
	.space	3
	.type	__func__.15626, %object
	.size	__func__.15626, 16
__func__.15626:
	.ascii	"HEVC_CheckListX\000"
	.type	__func__.15749, %object
	.size	__func__.15749, 16
__func__.15749:
	.ascii	"HEVC_RepairList\000"
	.type	__func__.16118, %object
	.size	__func__.16118, 21
__func__.16118:
	.ascii	"HEVC_CheckFrameStore\000"
	.space	3
	.type	__func__.15965, %object
	.size	__func__.15965, 19
__func__.15965:
	.ascii	"HEVC_OutputCurrPic\000"
	.space	1
	.type	__func__.15970, %object
	.size	__func__.15970, 23
__func__.15970:
	.ascii	"HEVC_FirstFrameFastOut\000"
	.space	1
	.type	__func__.16256, %object
	.size	__func__.16256, 14
__func__.16256:
	.ascii	"HEVC_IsNewPic\000"
	.space	2
	.type	quant8_inter_default, %object
	.size	quant8_inter_default, 64
quant8_inter_default:
	.word	269488144
	.word	403968529
	.word	286265360
	.word	421008402
	.word	303108112
	.word	471406612
	.word	336728336
	.word	555489560
	.word	403968529
	.word	690035737
	.word	421008402
	.word	908665116
	.word	471406612
	.word	1194731809
	.word	555489560
	.word	1531393577
	.type	quant_ts_default, %object
	.size	quant_ts_default, 16
quant_ts_default:
	.word	269488144
	.word	269488144
	.word	269488144
	.word	269488144
	.type	__func__.16537, %object
	.size	__func__.16537, 16
__func__.16537:
	.ascii	"HEVC_ReleaseNAL\000"
.LC0:
	.word	1
	.word	2
	.word	2
	.word	1
.LC1:
	.word	1
	.word	2
	.word	1
	.word	1
	.type	g_CropUnitX, %object
	.size	g_CropUnitX, 16
g_CropUnitX:
	.word	1
	.word	2
	.word	2
	.word	1
	.type	g_CropUnitY, %object
	.size	g_CropUnitY, 16
g_CropUnitY:
	.word	1
	.word	2
	.word	1
	.word	1
	.type	__func__.15828, %object
	.size	__func__.15828, 13
__func__.15828:
	.ascii	"HEVC_InitDPB\000"
	.space	3
	.type	__func__.16589, %object
	.size	__func__.16589, 13
__func__.16589:
	.ascii	"HEVCDEC_Init\000"
	.space	3
	.type	__func__.16110, %object
	.size	__func__.16110, 19
__func__.16110:
	.ascii	"HEVC_OutputFrmToVO\000"
	.space	1
	.type	__func__.16077, %object
	.size	__func__.16077, 22
__func__.16077:
	.ascii	"HEVC_OutputFrmFromDPB\000"
	.space	2
	.type	__func__.15372, %object
	.size	__func__.15372, 30
__func__.15372:
	.ascii	"HEVC_OutputUnRefPicWithMinPoc\000"
	.space	2
	.type	__func__.16090, %object
	.size	__func__.16090, 27
__func__.16090:
	.ascii	"HEVC_FlushOutputFrmFromDPB\000"
	.space	1
	.type	__func__.16577, %object
	.size	__func__.16577, 23
__func__.16577:
	.ascii	"HEVCDEC_GetImageBuffer\000"
	.space	1
	.type	__func__.16628, %object
	.size	__func__.16628, 14
__func__.16628:
	.ascii	"HEVC_ClearDPB\000"
	.space	2
	.type	__func__.15377, %object
	.size	__func__.15377, 23
__func__.15377:
	.ascii	"HEVC_RecoverDPBProcess\000"
	.space	1
	.type	__func__.15448, %object
	.size	__func__.15448, 27
__func__.15448:
	.ascii	"HEVC_DecSliceSegmentHeader\000"
	.space	1
	.type	__func__.16058, %object
	.size	__func__.16058, 20
__func__.16058:
	.ascii	"HEVC_InsertFrmInDPB\000"
	.type	__func__.15975, %object
	.size	__func__.15975, 22
__func__.15975:
	.ascii	"HEVC_SimpleDPBProcess\000"
	.space	2
	.type	__func__.15980, %object
	.size	__func__.15980, 21
__func__.15980:
	.ascii	"HEVC_DecOrderProcess\000"
	.space	3
	.type	__func__.15985, %object
	.size	__func__.15985, 22
__func__.15985:
	.ascii	"HEVC_DispOrderProcess\000"
	.space	2
	.type	__func__.16001, %object
	.size	__func__.16001, 19
__func__.16001:
	.ascii	"HEVC_StorePicInDPB\000"
	.space	1
	.type	__func__.15404, %object
	.size	__func__.15404, 14
__func__.15404:
	.ascii	"HEVC_DecSlice\000"
	.space	2
	.type	__func__.15703, %object
	.size	__func__.15703, 12
__func__.15703:
	.ascii	"HEVC_DecVDM\000"
	.type	__func__.14852, %object
	.size	__func__.14852, 18
__func__.14852:
	.ascii	"HEVC_VES_Splitter\000"
	.space	2
	.type	__func__.16689, %object
	.size	__func__.16689, 20
__func__.16689:
	.ascii	"HEVC_HaveSliceToDec\000"
	.type	__func__.14870, %object
	.size	__func__.14870, 21
__func__.14870:
	.ascii	"HEVCDEC_DecodePacket\000"
	.space	3
	.type	g_HEVCNalTypeEOPIC, %object
	.size	g_HEVCNalTypeEOPIC, 13
g_HEVCNalTypeEOPIC:
	.byte	0
	.byte	0
	.byte	1
	.byte	96
	.byte	0
	.byte	72
	.byte	83
	.byte	80
	.byte	73
	.byte	67
	.byte	69
	.byte	78
	.byte	68
	.space	3
	.type	__func__.16706, %object
	.size	__func__.16706, 21
__func__.16706:
	.ascii	"HEVCDEC_GetRemainImg\000"
	.data
	.align	2
.LANCHOR4 = . + 0
	.type	quant8_intra_default, %object
	.size	quant8_intra_default, 64
quant8_intra_default:
	.word	269488144
	.word	404034065
	.word	269488144
	.word	420877073
	.word	303108112
	.word	488183316
	.word	353505296
	.word	606018328
	.word	403968273
	.word	791225118
	.word	454431506
	.word	1094069283
	.word	521737749
	.word	1480996393
	.word	605886744
	.word	1935163695
	.type	g_quantTSDefault4x4, %object
	.size	g_quantTSDefault4x4, 16
g_quantTSDefault4x4:
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.type	g_quantInterDefault8x8, %object
	.size	g_quantInterDefault8x8, 64
g_quantInterDefault8x8:
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	17
	.byte	18
	.byte	20
	.byte	24
	.byte	16
	.byte	16
	.byte	16
	.byte	17
	.byte	18
	.byte	20
	.byte	24
	.byte	25
	.byte	16
	.byte	16
	.byte	17
	.byte	18
	.byte	20
	.byte	24
	.byte	25
	.byte	28
	.byte	16
	.byte	17
	.byte	18
	.byte	20
	.byte	24
	.byte	25
	.byte	28
	.byte	33
	.byte	17
	.byte	18
	.byte	20
	.byte	24
	.byte	25
	.byte	28
	.byte	33
	.byte	41
	.byte	18
	.byte	20
	.byte	24
	.byte	25
	.byte	28
	.byte	33
	.byte	41
	.byte	54
	.byte	20
	.byte	24
	.byte	25
	.byte	28
	.byte	33
	.byte	41
	.byte	54
	.byte	71
	.byte	24
	.byte	25
	.byte	28
	.byte	33
	.byte	41
	.byte	54
	.byte	71
	.byte	91
	.type	g_quantIntraDefault8x8, %object
	.size	g_quantIntraDefault8x8, 64
g_quantIntraDefault8x8:
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	17
	.byte	18
	.byte	21
	.byte	24
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	17
	.byte	19
	.byte	22
	.byte	25
	.byte	16
	.byte	16
	.byte	17
	.byte	18
	.byte	20
	.byte	22
	.byte	25
	.byte	29
	.byte	16
	.byte	16
	.byte	18
	.byte	21
	.byte	24
	.byte	27
	.byte	31
	.byte	36
	.byte	17
	.byte	17
	.byte	20
	.byte	24
	.byte	30
	.byte	35
	.byte	41
	.byte	47
	.byte	18
	.byte	19
	.byte	22
	.byte	27
	.byte	35
	.byte	44
	.byte	54
	.byte	65
	.byte	21
	.byte	22
	.byte	25
	.byte	31
	.byte	41
	.byte	54
	.byte	70
	.byte	88
	.byte	24
	.byte	25
	.byte	29
	.byte	36
	.byte	47
	.byte	65
	.byte	88
	.byte	115
	.type	RPU_START_CODE, %object
	.size	RPU_START_CODE, 5
RPU_START_CODE:
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	25
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC2:
	.ascii	"dar=%d\012\000"
.LC3:
	.ascii	"--------------- PrintNaluArraySlot START ----------"
	.ascii	"-----\012\000"
	.space	2
.LC4:
	.ascii	"\012\000"
	.space	2
.LC5:
	.ascii	"--------------- PrintNaluArraySlot END ------------"
	.ascii	"---\012\000"
.LC6:
	.ascii	"NalArray[%d]=%p,is_valid=%d   \000"
	.space	1
.LC7:
	.ascii	"--------------- PrintCurrSlicelistX START ---------"
	.ascii	"------\012\000"
	.space	1
.LC8:
	.ascii	"List0, size: %d\012\000"
	.space	3
.LC9:
	.ascii	"List1, size: %d\012\000"
	.space	3
.LC10:
	.ascii	"pListX[0][%d]:%p \000"
	.space	2
.LC11:
	.ascii	"pFrameStore:%p \000"
.LC12:
	.ascii	"pLogicFs:%p \000"
	.space	3
.LC13:
	.ascii	"--------------- PrintCurrSlicelistX END -----------"
	.ascii	"----\012\000"
	.space	3
.LC14:
	.ascii	"pListX[1][%d]: %p\000"
	.space	2
.LC15:
	.ascii	"--------------- PrintFrameStoreState START --------"
	.ascii	"-------\012\000"
.LC16:
	.ascii	"--------------- PrintFrameStoreState END ----------"
	.ascii	"-----\012\000"
	.space	2
.LC17:
	.ascii	"Fs=%d, pFs=%p, state=%d, is_reference=%d, is_displa"
	.ascii	"yed=%d \000"
	.space	1
.LC18:
	.ascii	"p_usrdat[%d]=%p \000"
	.space	3
.LC19:
	.ascii	"--------------- PrintAPCState START ---------------"
	.ascii	"\012\000"
	.space	3
.LC20:
	.ascii	"APC.used_size:%d, APC.size:%d\012\000"
	.space	1
.LC21:
	.ascii	"%d: is_used=%d, idc=%d, poc=%d\012\000"
.LC22:
	.ascii	"--------------- PrintAPCState END ---------------\012"
	.ascii	"\000"
	.space	1
.LC23:
	.ascii	"--------------- PrintDPBState START ---------------"
	.ascii	"\012\000"
	.space	3
.LC24:
	.ascii	"DPB: size:%d, used_size:%d, negative:%d, positive:%"
	.ascii	"d, longterm:%d\012\000"
	.space	1
.LC25:
	.ascii	"fs[%d]:%p non_existing:%d state:%d is_ref:%d displa"
	.ascii	"yed:%d poc:%d long_term:%d LogicFs:%p, fsp_ref:%d f"
	.ascii	"sp_disp:%d logic_id:%d img_id:%d\012\000"
.LC26:
	.ascii	"--------------- PrintDPBState END ---------------\012"
	.ascii	"\000"
	.space	1
.LC27:
	.ascii	"fs[%d]\011\000"
.LC28:
	.ascii	"LogicFs:%p\011\000"
.LC29:
	.ascii	"LogicTick:%d\011\000"
	.space	2
.LC30:
	.ascii	"IsRef:%d\011\000"
	.space	2
.LC31:
	.ascii	"s32DispState:%d\011\000"
	.space	3
.LC32:
	.ascii	"LogicFs:Null\011\000"
	.space	2
.LC33:
	.ascii	"DecFs:%p\011\000"
	.space	2
.LC34:
	.ascii	"DecTick:%d\011\000"
.LC35:
	.ascii	"DecFs:Null\011\000"
.LC36:
	.ascii	"DispFs:%p\011\000"
	.space	1
.LC37:
	.ascii	"DispTick:%d\011\000"
	.space	3
.LC38:
	.ascii	"DispFs:Null\011\000"
	.space	3
.LC39:
	.ascii	"%s num_tile_columns(%d) out of range(0, %d].\012\000"
	.space	2
.LC40:
	.ascii	"%s num_tile_rows(%d) out of range(0, %d].\012\000"
	.space	1
.LC41:
	.ascii	"%s 0 idx(%d) out of range(0, 512).\012\000"
.LC42:
	.ascii	"%s 1 idx(%d) out of range(0, 512).\012\000"
.LC43:
	.ascii	"/home/share/HiSTBAndroid5.x/release/HiSTBAndroid5.x"
	.ascii	"/master/HiSTBAndroidV6_release/HiSTBAndroidV600R002"
	.ascii	"C00SPC030/device/hisilicon/bigfish/sdk/source/kerne"
	.ascii	"l/linux-3.18.y/drivers/msp/vfmw/vfmw_v5.0/firmware/"
	.ascii	"common/syntax/hevc.c\000"
	.space	3
.LC44:
	.ascii	"NULL pointer: %s, L%d\012\000"
	.space	1
.LC45:
	.ascii	"HEVC_Sei_User_Data_Unregistered payloadSize < 16\012"
	.ascii	"\000"
	.space	2
.LC46:
	.ascii	"pListX[0][%d] = NULL, listXsize[0] = %d\012\000"
	.space	3
.LC47:
	.ascii	"pListX[0][%d]->frame_store = NULL, listXsize[0] = %"
	.ascii	"d\012\000"
	.space	2
.LC48:
	.ascii	"pListX[0][%d] frame_store(%p), pstLogicFs(%p) inval"
	.ascii	"id\012\000"
	.space	1
.LC49:
	.ascii	"pListX[1][%d] = NULL, listXsize[1] = %d\012\000"
	.space	3
.LC50:
	.ascii	"pListX[1][%d]->frame_store = NULL, listXsize[1] = %"
	.ascii	"d\012\000"
	.space	2
.LC51:
	.ascii	"pListX[i][%d] pstLogicFs(%p) invalid\012\000"
	.space	2
.LC52:
	.ascii	"%s DPB.used_size(%d) >= 17.\012\000"
	.space	3
.LC53:
	.ascii	"%s can't find such pic.\012\000"
	.space	3
.LC54:
	.ascii	"%s find pos=%d, poc=%d.\012\000"
	.space	3
.LC55:
	.ascii	"%s DPB.size(%d) already reached max(%d).\012\000"
	.space	2
.LC56:
	.ascii	"%s increase DPB size to %d\012\000"
.LC57:
	.ascii	"%s no enough fs(total_fs_num=%d) to increase DPB si"
	.ascii	"ze.\012\000"
.LC58:
	.ascii	"TileWidthInCtb is 0\012\000"
	.space	3
.LC59:
	.ascii	"image_id=%d, pmv_idc=%d\012\000"
	.space	3
.LC60:
	.ascii	"pic msg burst0:\012\000"
	.space	3
.LC61:
	.ascii	"%s call HEVC_CalcTileInfo failed.\012\000"
	.space	1
.LC62:
	.ascii	"logic frame id(=%d): get LogicFs error!\012\000"
	.space	3
.LC63:
	.ascii	"phy fs is null: pstDecodeFs = %p, pstDispOutFs = %p"
	.ascii	"\012\000"
	.space	3
.LC64:
	.ascii	"%s ERROR: bHaveIndependentSlice = 0\012\012\000"
	.space	2
.LC65:
	.ascii	"ListX ERROR: list0size >= %d\012\000"
	.space	2
.LC66:
	.ascii	"ListX ERROR: list1size >= %d\012\000"
	.space	2
.LC67:
	.ascii	"pListX[0][%d] = NULL\012\000"
	.space	2
.LC68:
	.ascii	"pListX[0][%d]->frame_store = NULL\012\000"
	.space	1
.LC69:
	.ascii	"pListX[1][%d] = NULL\012\000"
	.space	2
.LC70:
	.ascii	"pListX[1][%d]->frame_store = NULL\012\000"
	.space	1
.LC71:
	.ascii	"NumSlicePara(%d) >= MaxSliceNum(%d)\012\000"
	.space	3
.LC72:
	.ascii	"line:%d pic_parameter_set_id(%d) out of range(0,%d)"
	.ascii	".\012\000"
	.space	2
.LC73:
	.ascii	"line:%d seq_parameter_set_id(%d) out of range[0,%d]"
	.ascii	".\012\000"
	.space	2
.LC74:
	.ascii	"line:%d, i(%d) > Max(%d) num_of_pics %d\012\000"
	.space	3
.LC75:
	.ascii	"line:%d, i(%d) > Max(%d)(neg%d + pos%d)\012\000"
	.space	3
.LC76:
	.ascii	"%s unkown slice type(%d).\012\000"
	.space	1
.LC77:
	.ascii	"%s pListX[%d] no available pic to repair.\012\000"
	.space	1
.LC78:
	.ascii	"%s: pListX[%d][%d] = NULL, repair it with pos(%d).\012"
	.ascii	"\000"
.LC79:
	.ascii	"HEVC_InitListX error.\012\000"
	.space	1
.LC80:
	.ascii	"HEVC_RepairList error.\012\000"
.LC81:
	.ascii	"release(apc=%d, pmvIdc=%d)\011\000"
.LC82:
	.ascii	"framestore %d allocate apc %d\012\000"
	.space	1
.LC83:
	.ascii	"find APC, but logic_fs_id %d abnormal(poc=%d, ref=%"
	.ascii	"d, logic_fs=%p, dec_fs=%p)\012\000"
	.space	1
.LC84:
	.ascii	"%s frame logic_fs_id=%d, state=%d\012\000"
	.space	1
.LC85:
	.ascii	"LogicFs(fs=%p, poc=%d, FirstFrameState=%d) is null,"
	.ascii	" logic_fs_id = %d\012\000"
	.space	2
.LC86:
	.ascii	"%s frame poc=%d, is already output\012\000"
.LC87:
	.ascii	"%s frame(%p) invalid, state:%d, non_existing:%d\012"
	.ascii	"\000"
	.space	3
.LC88:
	.ascii	"%s: pImg is NULL!\012\000"
	.space	1
.LC89:
	.ascii	"%s, REPORT_IFRAME_ERR\012\000"
	.space	1
.LC90:
	.ascii	"%s: InsertImgToVoQueue failed!\012\000"
.LC91:
	.ascii	"%s: ImgErrorLevel = %d, OutErrThr:%d, discarded!\012"
	.ascii	"\000"
	.space	2
.LC92:
	.ascii	"%s output current picture failed\012\000"
	.space	2
.LC93:
	.ascii	"HEVC_DECRecycleImage ERROR, DispState = FS_DISP_STA"
	.ascii	"TE_NOT_USED\012\000"
.LC94:
	.ascii	"hevc partition fs memory fail!\012\000"
.LC95:
	.ascii	"ERROR: HEVC FSP_ConfigInstance fail!\012\000"
	.space	2
.LC96:
	.ascii	"FS_ALLOC_ERR, ClearAll\012\000"
.LC97:
	.ascii	"Can not new logic fs! ClearAll\012\000"
.LC98:
	.ascii	"FSP_GetFspType -1\012\000"
	.space	1
.LC99:
	.ascii	"FSP_GetLogicFs return NULL\012\000"
.LC100:
	.ascii	"%s: pHevcCtx->DPB.used_size(%d) > DPB.size(%d), err"
	.ascii	"or resilence.\012\000"
	.space	2
.LC101:
	.ascii	"nal_segment = %d is not expected value\012\000"
.LC102:
	.ascii	"HEVC_VpsSpsPpsCheck pic_parameter_set_id(%d) out of"
	.ascii	" range\012\000"
	.space	1
.LC103:
	.ascii	"pps with this pic_parameter_set_id = %d havn't be d"
	.ascii	"ecoded\012\000"
	.space	1
.LC104:
	.ascii	"HEVC_VpsSpsPpsCheck seq_parameter_set_id(%d) out of"
	.ascii	" range\012\000"
	.space	1
.LC105:
	.ascii	"sps with this seq_parameter_set_id = %d havn't be d"
	.ascii	"ecoded\012\000"
	.space	1
.LC106:
	.ascii	"HEVC_VpsSpsPpsCheck video_parameter_set_id out of r"
	.ascii	"ange\012\000"
	.space	3
.LC107:
	.ascii	"vps with this video_parameter_set_id = %d havn't be"
	.ascii	" decoded\012\000"
	.space	3
.LC108:
	.ascii	"%s, %d, CurrSlice.poc = %d, PocRandomAccess = %d, n"
	.ascii	"al_unit_type = %d, should skip this frame\012\000"
	.space	2
.LC109:
	.ascii	"%s, %d, CurrSlice.poc = %d, bNoRaslOutputFlag = %d,"
	.ascii	" nal_unit_type = %d, should skip this frame\012\000"
.LC110:
	.ascii	"%s, %d, PrevRAPIsBLA = %d, CurrSlice.poc = %d, PocC"
	.ascii	"RA = %d, nal_unit_type = %d, should skip this frame"
	.ascii	"\012\000"
.LC111:
	.ascii	"HEVC_ReadByteAlignment: code should not be zero.\012"
	.ascii	"\000"
	.space	2
.LC112:
	.ascii	"HEVC_ReadByteAlignment: code:%d\012\000"
	.space	3
.LC113:
	.ascii	"general_profile_compatibility_flag[][%d]\000"
	.space	3
.LC114:
	.ascii	"reserved_zero_2bits not equal 0.\012\000"
	.space	2
.LC115:
	.ascii	"HEVC_GetScalingListDefaultAddress NULL.\012\000"
	.space	3
.LC116:
	.ascii	"Error, BsLen: 0x%x, TotalPos: 0x%x\012\000"
.LC117:
	.ascii	"Panic: All zero data sequence in RBSP \012\000"
.LC118:
	.ascii	"nal_trail_zero_bit_num err\012\000"
.LC119:
	.ascii	"%s release streambuff=%p, bitstream_length=%d\012\000"
	.space	1
.LC120:
	.ascii	"HEVC_CombinePacket FATAL: pCurrNal=NULL!\012\000"
	.space	2
.LC121:
	.ascii	"END of the bit buffer, copy the first packet!\012\000"
	.space	1
.LC122:
	.ascii	"HEVC_ue_v ERROR: LeadingZeros (%d) >= 32, return 0x"
	.ascii	"%x\012\000"
	.space	1
.LC123:
	.ascii	"tone_map_id\000"
.LC124:
	.ascii	"Unsupport: target_bit_depth(%d) > 8\012\000"
	.space	3
.LC125:
	.ascii	"pTon->num_pivots > 256\012\000"
.LC126:
	.ascii	"frame_packing_arrangement_id\000"
	.space	3
.LC127:
	.ascii	"frame_packing_arrangement_type(%d) out of range\012"
	.ascii	"\000"
	.space	3
.LC128:
	.ascii	"decoding_unit_idx\000"
	.space	2
.LC129:
	.ascii	"num_sps_ids_minus1\000"
	.space	1
.LC130:
	.ascii	"pAct->num_sps_ids_minus1 > 15\012\000"
	.space	1
.LC131:
	.ascii	"active_seq_parameter_set_id\000"
.LC132:
	.ascii	"bp_seq_parameter_set_id\000"
.LC133:
	.ascii	"Wrong bp_seq_parameter_set_id = %d, should be 0 to "
	.ascii	"15!\012\000"
.LC134:
	.ascii	"HEVC_Sei_Buf_Period cpb_cnt_minus1(%d) out of range"
	.ascii	"(0,31).\012\000"
.LC135:
	.ascii	"num_decoding_units_minus1\000"
	.space	2
.LC136:
	.ascii	"pPic->num_decoding_units_minus1 > 255\012\000"
	.space	1
.LC137:
	.ascii	"num_nalus_in_du_minus1\000"
	.space	1
.LC138:
	.ascii	"delta_idx_minus1\000"
	.space	3
.LC139:
	.ascii	"delta_idx(%d) > idx(%d).\012\000"
	.space	2
.LC140:
	.ascii	"rIdx(%d) > (idx-1)(%d) or < 0).\012\000"
	.space	3
.LC141:
	.ascii	"abs_delta_rps_minus1\000"
	.space	3
.LC142:
	.ascii	"pTempRPset->num_of_pics(%d) out of range(0,15).\012"
	.ascii	"\000"
	.space	3
.LC143:
	.ascii	"num_of_pics out of range(0,15).\012\000"
	.space	3
.LC144:
	.ascii	"num_negative_pics\000"
	.space	2
.LC145:
	.ascii	"pTempRPset->num_negative_pics(%d) out of range(0,15"
	.ascii	").\012\000"
	.space	1
.LC146:
	.ascii	"num_positive_pics\000"
	.space	2
.LC147:
	.ascii	"pTempRPset->num_positive_pics(%d) out of range(0,15"
	.ascii	").\012\000"
	.space	1
.LC148:
	.ascii	"pShortTermRpset->num_of_pics(%d) out of range[0,%d]"
	.ascii	".\012\000"
	.space	2
.LC149:
	.ascii	"delta_poc_s0_minus1\000"
.LC150:
	.ascii	"delta_poc_s0_minus1(%d) out of range.\012\000"
	.space	1
.LC151:
	.ascii	"delta_poc_s1_minus1\000"
.LC152:
	.ascii	"elemental_duration_in_tc_minus1\000"
.LC153:
	.ascii	"cpb_cnt_minus1\000"
	.space	1
.LC154:
	.ascii	"cpb_cnt_minus1(%d) out of range(0,31).\012\000"
.LC155:
	.ascii	"bit_rate_value_minus1\000"
	.space	2
.LC156:
	.ascii	"cpb_size_value_minus1\000"
	.space	2
.LC157:
	.ascii	"cpb_size_du_value_minus1\000"
	.space	3
.LC158:
	.ascii	"bit_rate_du_value_minus1\000"
	.space	3
.LC159:
	.ascii	"vps_reserved_three_2bits(%d) not equal 0x3.\012\000"
	.space	3
.LC160:
	.ascii	"vps_max_layers_minus1 out of range(0,63).\012\000"
	.space	1
.LC161:
	.ascii	"vps_max_sub_layers_minus1=%d\012\000"
	.space	2
.LC162:
	.ascii	"vps_reserved_0xffff_16bits not equal 0xffff.\012\000"
	.space	2
.LC163:
	.ascii	"VPS HEVC_DecPTL error.\012\000"
.LC164:
	.ascii	"vps_num_layer_sets_minus1\000"
	.space	2
.LC165:
	.ascii	"vps_max_dec_pic_buffering_minus1[i]\000"
.LC166:
	.ascii	"vps_num_reorder_pics[i]\000"
.LC167:
	.ascii	"vps_max_latency_increase_plus1[i]\000"
	.space	2
.LC168:
	.ascii	"vps_num_layer_sets_minus1(%d) out of range(0,%d).\012"
	.ascii	"\000"
	.space	1
.LC169:
	.ascii	"layer_id_included_flag[%d][%d]\000"
	.space	1
.LC170:
	.ascii	"vps_num_ticks_poc_diff_one_minus1\000"
	.space	2
.LC171:
	.ascii	"vps_num_hrd_parameters\000"
	.space	1
.LC172:
	.ascii	"vps_num_hrd_parameters(%d) out of range(0,%d).\012\000"
.LC173:
	.ascii	"hrd_layer_set_idx\000"
	.space	2
.LC174:
	.ascii	"VPS HEVC_DecHrdParam error.\012\000"
	.space	3
.LC175:
	.ascii	"pVPS->vps_video_parameter_set_id out of range(0,15)"
	.ascii	".\012\000"
	.space	2
.LC176:
	.ascii	"VPS[%d] decode error0.\012\000"
.LC177:
	.ascii	"VPS[%d] decode error1.\012\000"
.LC178:
	.ascii	"chroma_sample_loc_type_top_field\000"
	.space	3
.LC179:
	.ascii	"chroma_sample_loc_type_bottom_field\000"
.LC180:
	.ascii	"def_disp_win_left_offset\000"
	.space	3
.LC181:
	.ascii	"VUI pSps->chroma_format_idc out of range(0,3).\012\000"
.LC182:
	.ascii	"def_disp_win_right_offset\000"
	.space	2
.LC183:
	.ascii	"def_disp_win_top_offset\000"
.LC184:
	.ascii	"def_disp_win_bottom_offset\000"
	.space	1
.LC185:
	.ascii	"vui_num_ticks_poc_diff_one_minus1\000"
	.space	2
.LC186:
	.ascii	"VUI HEVC_DecHrdParam error.\012\000"
	.space	3
.LC187:
	.ascii	"min_spatial_segmentation_idc\000"
	.space	3
.LC188:
	.ascii	"VUI min_spatial_segmentation_idc out of range(0,409"
	.ascii	"5).\012\000"
.LC189:
	.ascii	"max_bytes_per_pic_denom\000"
.LC190:
	.ascii	"max_bits_per_min_cu_denom\000"
	.space	2
.LC191:
	.ascii	"log2_max_mv_length_horizontal\000"
	.space	2
.LC192:
	.ascii	"log2_max_mv_length_vertical\000"
.LC193:
	.ascii	"sop_seq_parameter_set_id\000"
	.space	3
.LC194:
	.ascii	"num_entries_in_sop_minus1\000"
	.space	2
.LC195:
	.ascii	"num_entries_in_sop_minus1 out of range(0,1024)\012\000"
.LC196:
	.ascii	"sop_short_term_rps_idx\000"
	.space	1
.LC197:
	.ascii	"sop_poc_delta\000"
	.space	2
.LC198:
	.ascii	"recovery_poc_cnt\000"
	.space	3
.LC199:
	.ascii	"reserved_payload_extension_data\000"
.LC200:
	.ascii	"line:%d Cosume TotalPos(%d > %d)!!!\012\000"
	.space	3
.LC201:
	.ascii	"HEVC_SeiMessage HEVC_Sei_Payload error.\012\000"
	.space	3
.LC202:
	.ascii	"SEI HEVC_SeiMessage error.\012\000"
.LC203:
	.ascii	"SEI BsIsByteAligned error.\012\000"
.LC204:
	.ascii	"SEI rbsp_trailing_bits(%d) not equal 0x80.\012\000"
.LC205:
	.ascii	"nesting_num_ops_minus1\000"
	.space	1
.LC206:
	.ascii	"nesting_num_ops_minus1 out of range(0,%d)\012\000"
	.space	1
.LC207:
	.ascii	"nesting_op_idx\000"
	.space	1
.LC208:
	.ascii	"nesting_num_layers_minus1\000"
	.space	2
.LC209:
	.ascii	"nesting_num_layers_minus1 out of range(0,63)\012\000"
	.space	2
.LC210:
	.ascii	"scaling_list_pred_matrix_id_delta\000"
	.space	2
.LC211:
	.ascii	"scaling_list_pred_matrix_id_delta out of range(0,ma"
	.ascii	"trixId).\012\000"
	.space	3
.LC212:
	.ascii	"HEVC_DecScalingListData pMatrixAddress NULL.\012\000"
	.space	2
.LC213:
	.ascii	"scaling_list_dc_coef_minus8\000"
.LC214:
	.ascii	"scaling_list_dc_coef_minus8 out of range(-7,247).\012"
	.ascii	"\000"
	.space	1
.LC215:
	.ascii	"scaling_list_delta_coef\000"
.LC216:
	.ascii	"scaling_list_dc_coef_minus8 out of range(-128,127)."
	.ascii	"\012\000"
	.space	3
.LC217:
	.ascii	"chroma_format_idc\000"
	.space	2
.LC218:
	.ascii	"pSPS->chroma_format_idc out of range(0,3).\012\000"
.LC219:
	.ascii	"pSPS->chroma_format_idc not equal(%d) 1.\012\000"
	.space	2
.LC220:
	.ascii	"pic_width_in_luma_samples\000"
	.space	2
.LC221:
	.ascii	"pic_width_in_luma_samples out of range(0,8192).\012"
	.ascii	"\000"
	.space	3
.LC222:
	.ascii	"pic_height_in_luma_samples\000"
	.space	1
.LC223:
	.ascii	"pic_height_in_luma_samples out of range(0,4096).\012"
	.ascii	"\000"
	.space	2
.LC224:
	.ascii	"ERROR Unkown level: %d\012\000"
.LC225:
	.ascii	"conf_win_left_offset\000"
	.space	3
.LC226:
	.ascii	"conf_win_right_offset\000"
	.space	2
.LC227:
	.ascii	"conf_win_left_offset+conf_win_right_offset out of r"
	.ascii	"ange.\012\000"
	.space	2
.LC228:
	.ascii	"conf_win_top_offset\000"
.LC229:
	.ascii	"conf_win_bottom_offset\000"
	.space	1
.LC230:
	.ascii	"conf_win_top_offset+conf_win_bottom_offset out of r"
	.ascii	"ange.\012\000"
	.space	2
.LC231:
	.ascii	"bit_depth_luma_minus8\000"
	.space	2
.LC232:
	.ascii	"bit_depth_luma(%d) out of range(8,14).\012\000"
.LC233:
	.ascii	"bit_depth_chroma_minus8\000"
.LC234:
	.ascii	"bit_depth_chroma(%d) out of range[8,14].\012\000"
	.space	2
.LC235:
	.ascii	"log2_max_pic_order_cnt_lsb_minus4\000"
	.space	2
.LC236:
	.ascii	"log2_max_pic_order_cnt_lsb_minus4 out of range[0,12"
	.ascii	"].\012\000"
	.space	1
.LC237:
	.ascii	"sps_max_dec_pic_buffering_minus1\000"
	.space	3
.LC238:
	.ascii	"sps_num_reorder_pics\000"
	.space	3
.LC239:
	.ascii	"sps_max_latency_increase_plus1\000"
	.space	1
.LC240:
	.ascii	"log2_min_coding_block_size_minus3\000"
	.space	2
.LC241:
	.ascii	"log2_min_luma_coding_block_size_minus3 out of range"
	.ascii	"(0,3).\012\000"
	.space	1
.LC242:
	.ascii	"log2_diff_max_min_coding_block_size\000"
.LC243:
	.ascii	"log2_diff_max_min_luma_coding_block_size out of ran"
	.ascii	"ge(0,3).\012\000"
	.space	3
.LC244:
	.ascii	"log2_ctb_sizeY out of range(4,6).\012\000"
	.space	1
.LC245:
	.ascii	"log2_min_transform_block_size_minus2\000"
	.space	3
.LC246:
	.ascii	"log2_min_transform_block_size_minus2 out of range(0"
	.ascii	",3).\012\000"
	.space	3
.LC247:
	.ascii	"log2_diff_max_min_transform_block_size\000"
	.space	1
.LC248:
	.ascii	"log2_diff_max_min_transform_block_size out of range"
	.ascii	"(0,3).\012\000"
	.space	1
.LC249:
	.ascii	"quadtree_tu_log2_min_size not less than log2_min_cb"
	.ascii	"_sizeY.\012\000"
.LC250:
	.ascii	"quadtree_tu_log2_max_size greater than Min( CtbLog2"
	.ascii	"SizeY, 5 ).\012\000"
.LC251:
	.ascii	"max_transform_hierarchy_depth_inter\000"
.LC252:
	.ascii	"max_transform_hierarchy_depth_inter out of range(0,"
	.ascii	"CtbLog2SizeY-Log2MinTrafoSize).\012\000"
.LC253:
	.ascii	"max_transform_hierarchy_depth_intra\000"
.LC254:
	.ascii	"max_transform_hierarchy_depth_intra out of range(0,"
	.ascii	"CtbLog2SizeY-Log2MinTrafoSize).\012\000"
.LC255:
	.ascii	"SPS HEVC_DecScalingListData error.\012\000"
.LC256:
	.ascii	"SPS sao is off and pic height(%d) is too small.(Log"
	.ascii	"ic Unsupported).\012\000"
	.space	3
.LC257:
	.ascii	"log2_min_pcm_luma_coding_block_size_minus3\000"
	.space	1
.LC258:
	.ascii	"log2_min_pcm_coding_block_size_minus3(%d) out of ra"
	.ascii	"nge[0,2].\012\000"
	.space	2
.LC259:
	.ascii	"log2_diff_max_min_pcm_luma_coding_block_size\000"
	.space	3
.LC260:
	.ascii	"log2_diff_max_min_pcm_coding_block_size(%d) out of "
	.ascii	"range[0,2].\012\000"
.LC261:
	.ascii	"pcm_log2_max_size greater than Min( CtbLog2SizeY, 5"
	.ascii	" ).\012\000"
.LC262:
	.ascii	"num_short_term_ref_pic_sets\000"
.LC263:
	.ascii	"num_short_term_ref_pic_sets out of range[0,%d].\012"
	.ascii	"\000"
	.space	3
.LC264:
	.ascii	"SPS HEVC_DecShortTermRefPicSet error.\012\000"
	.space	1
.LC265:
	.ascii	"num_long_term_ref_pic_sps\000"
	.space	2
.LC266:
	.ascii	"num_long_term_ref_pic_sps out of range[0,32].\012\000"
	.space	1
.LC267:
	.ascii	"SPS HEVC_DecVuiParam error.\012\000"
	.space	3
.LC268:
	.ascii	"sps_video_parameter_set_id out of range(0,%d).\012\000"
.LC269:
	.ascii	"sps_max_sub_layers_minus1 out of range(0,%d).\012\000"
	.space	1
.LC270:
	.ascii	"SPS HEVC_DecPTL error.\012\000"
.LC271:
	.ascii	"sps_seq_parameter_set_id\000"
	.space	3
.LC272:
	.ascii	"sps_seq_parameter_set_id out of range(0,%d).\012\000"
	.space	2
.LC273:
	.ascii	"SPS[%d] decode error0.\012\000"
.LC274:
	.ascii	"SPS[%d] decode error.\012\000"
	.space	1
.LC275:
	.ascii	"pps_seq_parameter_set_id\000"
	.space	3
.LC276:
	.ascii	"pic_parameter_set_id(%d) out of range[0,15].\012\000"
	.space	2
.LC277:
	.ascii	"SPS(%d) haven't decode.\012\000"
	.space	3
.LC278:
	.ascii	"num_ref_idx_l0_default_active_minus1\000"
	.space	3
.LC279:
	.ascii	"num_ref_idx_l0_default_active out of range[0,15].\012"
	.ascii	"\000"
	.space	1
.LC280:
	.ascii	"num_ref_idx_l1_default_active_minus1\000"
	.space	3
.LC281:
	.ascii	"num_ref_idx_l1_default_active out of range[0,15].\012"
	.ascii	"\000"
	.space	1
.LC282:
	.ascii	"init_qp_minus26\000"
.LC283:
	.ascii	"pic_init_qp(%d) out of range[-%d,51].\012\000"
	.space	1
.LC284:
	.ascii	"diff_cu_qp_delta_depth\000"
	.space	1
.LC285:
	.ascii	"diff_cu_qp_delta_depth out of range[0,3].\012\000"
	.space	1
.LC286:
	.ascii	"pps_cb_qp_offset\000"
	.space	3
.LC287:
	.ascii	"pic_cb_qp_offset out of range[-12,12].\012\000"
.LC288:
	.ascii	"pps_cr_qp_offset\000"
	.space	3
.LC289:
	.ascii	"pic_cr_qp_offset out of range[-12,12].\012\000"
.LC290:
	.ascii	"num_tile_columns_minus1\000"
.LC291:
	.ascii	"num_tile_columns(%d) out of range(0,%d).\012\000"
	.space	2
.LC292:
	.ascii	"num_tile_rows_minus1\000"
	.space	3
.LC293:
	.ascii	"num_tile_rows out(%d) of range(0,%d).\012\000"
	.space	1
.LC294:
	.ascii	"Logic limit(%d), num_tile_columns(%d) exceed.\012\000"
	.space	1
.LC295:
	.ascii	"Logic limit(%d), num_tile_rows(%d) exceed.\012\000"
.LC296:
	.ascii	"column_width_minus1\000"
.LC297:
	.ascii	"column_width[%d](%d) out of range (0 %d)\012\000"
	.space	2
.LC298:
	.ascii	"row_height_minus1\000"
	.space	2
.LC299:
	.ascii	"row_height[%d](%d) out of range (0 %d)\012\000"
.LC300:
	.ascii	"column_bd[%d](%d) <= 0, invalid!\012\000"
	.space	2
.LC301:
	.ascii	"row_bd[%d](%d) <= 0, invalid!\012\000"
	.space	1
.LC302:
	.ascii	"PPS tile width(%d) is too small.(Logic Unsupport)\012"
	.ascii	"\000"
	.space	1
.LC303:
	.ascii	"PPS tile height(%d) is too small.(Logic Unsupport)\012"
	.ascii	"\000"
.LC304:
	.ascii	"pps_beta_offset_div2\000"
	.space	3
.LC305:
	.ascii	"pps_beta_offset_div2(%d) out of range(-6,6).\012\000"
	.space	2
.LC306:
	.ascii	"pps_tc_offset_div2\000"
	.space	1
.LC307:
	.ascii	"pps_tc_offset_div2(%d) out of range(-6,6).\012\000"
.LC308:
	.ascii	"PPS HEVC_DecScalingListData error.\012\000"
.LC309:
	.ascii	"log2_parallel_merge_level_minus2\000"
	.space	3
.LC310:
	.ascii	"log2_parallel_merge_level(%d) out of range(2,log2_c"
	.ascii	"tb_sizeY).\012\000"
	.space	1
.LC311:
	.ascii	"pps_pic_parameter_set_id\000"
	.space	3
.LC312:
	.ascii	"pic_parameter_set_id(%d) out of range(0,%d).\012\000"
	.space	2
.LC313:
	.ascii	"PPS[%d] decode error.\012\000"
	.space	1
.LC314:
	.ascii	"luma_log2_weight_denom\000"
	.space	1
.LC315:
	.ascii	"luma_log2_weight_denom out of range(0,7).\012\000"
	.space	1
.LC316:
	.ascii	"delta_chroma_log2_weight_denom\000"
	.space	1
.LC317:
	.ascii	"delta_chroma_log2_weight_denom out of range(-7,7).\012"
	.ascii	"\000"
.LC318:
	.ascii	"delta_luma_weight_l0\000"
	.space	3
.LC319:
	.ascii	"delta_luma_weight_l0(%d) out of range(-128,127).\012"
	.ascii	"\000"
	.space	2
.LC320:
	.ascii	"luma_offset_l0\000"
	.space	1
.LC321:
	.ascii	"luma_offset_l0(%d) out of range(-128,127).\012\000"
.LC322:
	.ascii	"delta_chroma_weight_l0\000"
	.space	1
.LC323:
	.ascii	"delta_chroma_weight_l0 out of range(-128,127).\012\000"
.LC324:
	.ascii	"delta_chroma_offset_l0\000"
	.space	1
.LC325:
	.ascii	"delta_chroma_offset_l0 out of range(-512,511).\012\000"
.LC326:
	.ascii	"delta_luma_weight_l1\000"
	.space	3
.LC327:
	.ascii	"delta_luma_weight_l1 out of range(-128,127).\012\000"
	.space	2
.LC328:
	.ascii	"luma_offset_l1\000"
	.space	1
.LC329:
	.ascii	"luma_offset_l1 out of range(-128,127).\012\000"
.LC330:
	.ascii	"delta_chroma_weight_l1\000"
	.space	1
.LC331:
	.ascii	"delta_chroma_weight_l1 out of range(-128,127).\012\000"
.LC332:
	.ascii	"delta_chroma_offset_l1\000"
	.space	1
.LC333:
	.ascii	"delta_chroma_offset_l1 out of range(-512,511).\012\000"
.LC334:
	.ascii	"%s arrange mem failed.\012\000"
.LC335:
	.ascii	"Init dec para\012\000"
	.space	1
.LC336:
	.ascii	"%s: Get context addr failed!\012\000"
	.space	2
.LC337:
	.ascii	"%s FATAL: MemOffset %d > ContextMemSize %d.\012\000"
	.space	3
.LC338:
	.ascii	"%s: VCTRL_GetChanIDByCtx() return -1!\012\000"
	.space	1
.LC339:
	.ascii	"BitDepthChange ReRange FS Luma(%d-->%d),Chroma(%d -"
	.ascii	"->%d)\012\000"
	.space	2
.LC340:
	.ascii	"HEVC_InitDPB error, return %d\012\000"
	.space	1
.LC341:
	.ascii	"HEVC_AllocFrameStore error\012\000"
.LC342:
	.ascii	"%s: pstLogicFsImage is NULL!\012\000"
	.space	2
.LC343:
	.ascii	"HEVC InsertVO Failed return %d, ClearAll\012\000"
	.space	2
.LC344:
	.ascii	"HEVC.c line %d: frame para err(ret=%d), recycle ima"
	.ascii	"ge self\012\000"
.LC345:
	.ascii	"%s: FirstFrameFastOut LastPoc: %d, CurPos: %d!\012\000"
.LC346:
	.ascii	"%s call HEVC_GetUnRefPicWithMinPoc failed\012\000"
	.space	1
.LC347:
	.ascii	"%s call HEVC_OutputOneFrmFromDPB failed\012\000"
	.space	3
.LC348:
	.ascii	"%s: HEVC_OutputFrmToVO err!\012\000"
	.space	3
.LC349:
	.ascii	"cann't find slot for current nal\012\000"
	.space	2
.LC350:
	.ascii	"receive a zero packet\012\000"
	.space	1
.LC351:
	.ascii	"nal_release_err\012\000"
	.space	3
.LC352:
	.ascii	"No frame store available!\012\000"
	.space	1
.LC353:
	.ascii	"%s ReadImgNum = %d, NewImgNum = %d, FrameStore leak"
	.ascii	", ClearAll!\012\000"
.LC354:
	.ascii	"%s: flush dpb failed, return %d\012\000"
	.space	3
.LC355:
	.ascii	"%s: DPB.used_size(%d) >= DPB.size(%d), need to incr"
	.ascii	"ease DPB size.\012\000"
	.space	1
.LC356:
	.ascii	"%s call HEVC_IncreaseDPBSize failed\012\000"
	.space	3
.LC357:
	.ascii	"%s: DPB.used_size(%d) >= DPB.size(%d), output minpo"
	.ascii	"c frame.\012\000"
	.space	3
.LC358:
	.ascii	"slice_pic_parameter_set_id\000"
	.space	1
.LC359:
	.ascii	"%s: pic_parameter_set_id(%d) out of range(0 %d)!\012"
	.ascii	"\000"
	.space	2
.LC360:
	.ascii	"HEVC_VpsSpsPpsCheck != HEVC_DEC_NORMAL\012\000"
.LC361:
	.ascii	"max_cu_width(%d)/max_cu_height(%d) = 0\012\000"
.LC362:
	.ascii	"slice_segment_address(%d) out of range(0,%d).\012\000"
	.space	1
.LC363:
	.ascii	"slice_type\000"
	.space	1
.LC364:
	.ascii	"slice_reserved_flag: %d\012\000"
	.space	3
.LC365:
	.ascii	"slice_type(%d) out of range(0,2].\012\000"
	.space	1
.LC366:
	.ascii	"HEVC_ClearDPB,LastDisplayPoc:%d poc:%d \012\000"
	.space	3
.LC367:
	.ascii	"SH HEVC_DecShortTermRefPicSet error.\012\000"
	.space	2
.LC368:
	.ascii	"short_term_ref_pic_set_idx(%d) out of range[0,%d].\012"
	.ascii	"\000"
.LC369:
	.ascii	"num_long_term_sps\000"
	.space	2
.LC370:
	.ascii	"num_long_term_sps(%d) out of range[0,%d].\012\000"
	.space	1
.LC371:
	.ascii	"num_long_term_pics\000"
	.space	1
.LC372:
	.ascii	"SH ERROR: (num_negative_pics(%d) + num_positive_pic"
	.ascii	"s(%d) + num_of_longterm_pics(%d)) > %d\012\000"
	.space	1
.LC373:
	.ascii	"lt_idx_sps[%d] = %d, but out of range[0,%d].\012\000"
	.space	2
.LC374:
	.ascii	"delta_poc_msb_cycle_lt\000"
	.space	1
.LC375:
	.ascii	"ERROR: pRPS->num_of_pics(%d) > %d.\012\000"
.LC376:
	.ascii	"num_ref_idx_l0_active_minus1\000"
	.space	3
.LC377:
	.ascii	"num_ref_idx_l0_active(%d) out of range(0,%d).\012\000"
	.space	1
.LC378:
	.ascii	"num_ref_idx_l1_active_minus1\000"
	.space	3
.LC379:
	.ascii	"num_ref_idx_l1_active(%d) out of range(0,%d).\012\000"
	.space	1
.LC380:
	.ascii	"pRPS is null.\012\000"
	.space	1
.LC381:
	.ascii	"pRPS->num_of_pics out(%d) of range(0,%d).\012\000"
	.space	1
.LC382:
	.ascii	"SH HEVC_DecRefPicListsModification error.\012\000"
	.space	1
.LC383:
	.ascii	"collocated_ref_idx\000"
	.space	1
.LC384:
	.ascii	"collocated_from_l0_flag=%d, collocated_ref_idx(%d) "
	.ascii	"out of range(0,%d).\012\000"
.LC385:
	.ascii	"SH HEVC_DecPredWeightTable error.\012\000"
	.space	1
.LC386:
	.ascii	"five_minus_max_num_merge_cand\000"
	.space	2
.LC387:
	.ascii	"SH max_num_merge_cand(%d) out of range(1,5).\012\000"
	.space	2
.LC388:
	.ascii	"slice_qp_delta\000"
	.space	1
.LC389:
	.ascii	"SH slice_qp(%d) out of range [-%d,51].\012\000"
.LC390:
	.ascii	"slice_cb_qp_offset\000"
	.space	1
.LC391:
	.ascii	"SH slice_cb_qp_offset(%d) out of range[-12,12].\012"
	.ascii	"\000"
	.space	3
.LC392:
	.ascii	"SH slice_cb_qp_offset(%d)+pic_cb_qp_offset(%d) out "
	.ascii	"of range[-12,12].\012\000"
	.space	2
.LC393:
	.ascii	"slice_cr_qp_offset\000"
	.space	1
.LC394:
	.ascii	"SH slice_cr_qp_offset(%d) out of range[-12,12].\012"
	.ascii	"\000"
	.space	3
.LC395:
	.ascii	"SH slice_cr_qp_offset+pPPS->pic_cr_qp_offset(%d) ou"
	.ascii	"t of range[-12,12].\012\000"
.LC396:
	.ascii	"slice_beta_offset_div2\000"
	.space	1
.LC397:
	.ascii	"SH slice_beta_offset_div2(%d) out of range(-6,6).\012"
	.ascii	"\000"
	.space	1
.LC398:
	.ascii	"slice_tc_offset_div2\000"
	.space	3
.LC399:
	.ascii	"SH slice_tc_offset_div2(%d) out of range(-6,6).\012"
	.ascii	"\000"
	.space	3
.LC400:
	.ascii	"num_entry_point_offsets\000"
.LC401:
	.ascii	"CurrSlice.num_entry_point_offsets(%d) out of range["
	.ascii	"0,%d].\012\000"
	.space	1
.LC402:
	.ascii	"offset_len_minus1\000"
	.space	2
.LC403:
	.ascii	"CurrSlice.offset_len(%d) out of range[1,32].\012\000"
	.space	2
.LC404:
	.ascii	"slice_segment_header_extension_length\000"
	.space	2
.LC405:
	.ascii	"slice_segment_header_extension_length(%d) out of ra"
	.ascii	"nge [0,256]\012\000"
.LC406:
	.ascii	"bitsLeft(%d) < slice_segment_header_extension_lengt"
	.ascii	"h(%d)\012\000"
	.space	2
.LC407:
	.ascii	"%s with invalid pos(%d)\012\000"
	.space	3
.LC408:
	.ascii	"%s get APC error, ret %d\012\000"
	.space	2
.LC409:
	.ascii	"%s %d: InsertFrmInDPB failed, return %d\012\000"
	.space	3
.LC410:
	.ascii	"%s call HEVC_CheckFrameStore failed!\012\000"
	.space	2
.LC411:
	.ascii	"%s call HEVC_RemoveUnUsedFrameStore Failed.\012\000"
	.space	3
.LC412:
	.ascii	"%s call HEVC_InsertFrmInDPB Failed.\012\000"
	.space	3
.LC413:
	.ascii	"%s call HEVC_FirstFrameFastOut Failed\012\000"
	.space	1
.LC414:
	.ascii	"DPB.used_size may bigger than DPB.size\012\000"
.LC415:
	.ascii	"HEVC_InsertFrmInDPB Failed, ret = %d\012\000"
	.space	2
.LC416:
	.ascii	"%s call HEVC_OutputFrmFromDPB failed\012\000"
	.space	2
.LC417:
	.ascii	"%s CurrPic.state = HEVC_PIC_EMPTY, return HEVC_DEC_"
	.ascii	"NORMAL\012\000"
	.space	1
.LC418:
	.ascii	"Discard cur pic, ErrLevel(%d) > OutErrThr(%d)\012\000"
	.space	1
.LC419:
	.ascii	"%s call HEVC_IModeProcess Failed\012\000"
	.space	2
.LC420:
	.ascii	"HEVC_StorePicInDpb return(%d) from L%d\012\000"
.LC421:
	.ascii	"%s call HEVC_SimpleDPBProcess Failed\012\000"
	.space	2
.LC422:
	.ascii	"%s call HEVC_DecOrderProcess Failed\012\000"
	.space	3
.LC423:
	.ascii	"%s call HEVC_DispOrderProcess Failed\012\000"
	.space	2
.LC424:
	.ascii	"%s return HEVC_DEC_ERR\012\000"
.LC425:
	.ascii	"No frame store for lost pic.\012\000"
	.space	2
.LC426:
	.ascii	"DPB ERROR: Can not get ref_fs!\012\000"
.LC427:
	.ascii	"DPB no suited fs for lost pic.\012\000"
.LC428:
	.ascii	"Take poc(%d) to creat lost poc(%d).\012\000"
	.space	3
.LC429:
	.ascii	"DPB ERROR: Ref DecodeFs = NULL, ClearDPB!\012\000"
	.space	1
.LC430:
	.ascii	"ERROR: Can not new logic fs!\012\000"
	.space	2
.LC431:
	.ascii	"Lost pic insert in DPB Failed!\012\000"
.LC432:
	.ascii	"Ref frame(poc %d) lost.\012\000"
	.space	3
.LC433:
	.ascii	"s32OutErrThr = %d,drop poc %d because lost ref fram"
	.ascii	"e(pod %d)\012\000"
	.space	2
.LC434:
	.ascii	"%s call HEVC_FlushOutputFrmFromDPB failed\012\000"
	.space	1
.LC435:
	.ascii	"%s call HEVC_EmptyFrmFromDPB failed\012\000"
	.space	3
.LC436:
	.ascii	"Init pic err, exit\012\000"
.LC437:
	.ascii	"HEVC_WritePicMsg failed!\012\000"
	.space	2
.LC438:
	.ascii	"Start Reason: SliceParaNum= %d\012\000"
.LC439:
	.ascii	"Too many slice , err!\012\000"
	.space	1
.LC440:
	.ascii	"Cur pic not init yet, discard this slice!\012\000"
	.space	1
.LC441:
	.ascii	"Dec List error, ret=%d\012\000"
.LC442:
	.ascii	"Ref List is Wrong!\012\000"
.LC443:
	.ascii	"HEVC_WriteSliceMsg err.\012\000"
	.space	3
.LC444:
	.ascii	"HEVC_StorePicInDPB failed, ret = %d\012\000"
	.space	3
.LC445:
	.ascii	"DecVDM no slice and needn't start VDM, but MaxBytes"
	.ascii	"Received exceed threshold!\012\000"
	.space	1
.LC446:
	.ascii	"DecVDM no slice and needn't start VDM\012\000"
	.space	1
.LC447:
	.ascii	"IPBDecMode Changed (%d -> %d)\012\000"
	.space	1
.LC448:
	.ascii	"Discard this B(poc=%d) before P, is_ref_idc=%d.\012"
	.ascii	"\000"
	.space	3
.LC449:
	.ascii	"VDM start, TotalPicNum=%d.\012\000"
.LC450:
	.ascii	"%s no correct slice in the pic\012\000"
.LC451:
	.ascii	"metadatasize is too large:%d at line:%d\012\000"
	.space	3
.LC452:
	.ascii	"*****[%s][%d],BL Codec can only dec BL stream!!****"
	.ascii	"*\012\000"
	.space	2
.LC453:
	.ascii	"*****[%s][%d],EL Codec can only dec EL stream in DV"
	.ascii	"_DUAL_VES_IMP stream!!*****\012\000"
.LC454:
	.ascii	"***** VES Splitter: UNSUPPORT, HDR_capacity=%d*****"
	.ascii	"\012\000"
	.space	3
.LC455:
	.ascii	"VPS decode error.\012\000"
	.space	1
.LC456:
	.ascii	"SPS decode error.\012\000"
	.space	1
.LC457:
	.ascii	"PPS decode error.\012\000"
	.space	1
.LC458:
	.ascii	"SEI decode error.\012\000"
	.space	1
.LC459:
	.ascii	"***** NAL: UNSUPPORT, nal_unit_type=%d\012\000"
.LC460:
	.ascii	"HEVC_DecSliceSegmentHeader dec err\012\000"
.LC461:
	.ascii	"HEVCDEC_DecodePacket NULL == pPacket!\012\000"
	.space	1
.LC462:
	.ascii	"HevcCtx not init!\012\000"
	.space	1
.LC463:
	.ascii	"HEVCDEC_DecodePacket NULL == pHevcCtx->pCurrNal!\012"
	.ascii	"\000"
	.space	2
.LC464:
	.ascii	"%s last frame fs unrelease, fix it!\012\000"
	.space	3
.LC465:
	.ascii	"ERROR:ReadNum = %d larger than VFMW_MAX_RESERVE_NUM"
	.ascii	"(%d)\012\000"
	.space	3
.LC466:
	.ascii	"HEVC_InquireSliceProperty error.\012\000"
	.space	2
.LC467:
	.ascii	"HEVC_DecOneNal ERR\012\000"
.LC468:
	.ascii	"%s pstLogicFsImage is NULL!\012\000"
	.space	3
.LC469:
	.ascii	"%s InsertVO err:%d, ClearAll\012\000"
	.bss
	.align	2
.LANCHOR0 = . + 0
.LANCHOR2 = . + 458304
.LANCHOR3 = . + 605616
.LANCHOR5 = . + 646536
	.type	s_auiSigLastScan, %object
	.size	s_auiSigLastScan, 458752
s_auiSigLastScan:
	.space	458752
	.type	g_TsToRsMap, %object
	.size	g_TsToRsMap, 147456
g_TsToRsMap:
	.space	147456
	.type	g_IsDeced, %object
	.size	g_IsDeced, 36864
g_IsDeced:
	.space	36864
	.type	s_TmpParam, %object
	.size	s_TmpParam, 26164
s_TmpParam:
	.space	26164
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
