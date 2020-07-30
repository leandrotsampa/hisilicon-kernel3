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
	.file	"vp9.c"

	.global	__aeabi_uidiv
	.text
	.align	2
	.type	Vp9_ModeMvMergeProbs, %function
Vp9_ModeMvMergeProbs:
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
	ldmia	r1, {r3, r4}
	mov	r5, r0
	adds	r4, r3, r4
	beq	.L3
	mov	r0, r3, asl #8
	mov	r1, r4
	add	r0, r0, r4, lsr #1
	bl	__aeabi_uidiv
	ldr	r2, .L5
	cmp	r0, #1
	movge	r3, r0
	movlt	r3, #1
	cmp	r4, #20
	movcs	r4, #20
	cmp	r3, #255
	ldrb	r0, [r2, r4]
	movge	r3, #255
	uxtb	r3, r3
	rsb	r2, r0, #256
	mul	r3, r0, r3
	mla	r5, r2, r5, r3
	add	r5, r5, #128
	ubfx	r0, r5, #8, #8
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L3:
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L6:
	.align	2
.L5:
	.word	.LANCHOR0
	.fnend
	.size	Vp9_ModeMvMergeProbs, .-Vp9_ModeMvMergeProbs
	.align	2
	.global	VP9_u_v_x
	.type	VP9_u_v_x, %function
VP9_u_v_x:
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
	.size	VP9_u_v_x, .-VP9_u_v_x
	.align	2
	.global	VP9_s_v
	.type	VP9_s_v, %function
VP9_s_v:
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
	add	r1, r1, #1
	bl	BsGet
	tst	r0, #1
	mov	r0, r0, asr #1
	rsbne	r0, r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VP9_s_v, .-VP9_s_v
	.align	2
	.global	Vp9_Cabac_ReadIsValid
	.type	Vp9_Cabac_ReadIsValid, %function
Vp9_Cabac_ReadIsValid:
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
	cmp	r2, #0
	cmpne	r0, #0
	moveq	r2, #0
	beq	.L12
	add	r1, r0, r1
	cmp	r2, r1
	movcs	r2, #1
	movcc	r2, #0
	cmp	r0, r1
	movcs	r2, #0
.L12:
	mov	r0, r2
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Vp9_Cabac_ReadIsValid, .-Vp9_Cabac_ReadIsValid
	.align	2
	.global	Vp9_Cabac_ReaderFill
	.type	Vp9_Cabac_ReaderFill, %function
Vp9_Cabac_ReaderFill:
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
	ldr	r5, [r0, #32]
	mov	r7, r0
	ldr	r8, [r0, #28]
	rsb	r6, r5, #24
	rsb	r4, r5, #16
	bic	r6, r6, #7
	rsb	r4, r6, r4
	add	r5, r5, r6
	mov	r1, r6
	and	r4, r4, #7
	bl	BsGet
	str	r5, [r7, #32]
	orr	r0, r8, r0, asl r4
	str	r0, [r7, #28]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	Vp9_Cabac_ReaderFill, .-Vp9_Cabac_ReaderFill
	.align	2
	.global	Vp9_Cabac_Read
	.type	Vp9_Cabac_Read, %function
Vp9_Cabac_Read:
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
	ldr	r4, [r0, #36]
	ldr	r7, [r0, #32]
	mov	r5, r0
	sub	r4, r4, #1
	cmp	r7, #0
	mul	r1, r4, r1
	mov	r4, r1, lsr #8
	add	r4, r4, #1
	blt	.L16
	ldr	r3, [r0, #28]
.L17:
	mov	r2, r4, asl #24
	cmp	r2, r3
	rsbls	r3, r2, r3
	ldr	r2, .L20
	ldrls	r1, [r5, #36]
	movls	r0, #1
	movhi	r0, #0
	rsbls	r4, r4, r1
	add	r2, r2, r4
	ldrb	r1, [r2, #24]
	mov	r3, r3, asl r1
	rsb	r7, r1, r7
	mov	r4, r4, asl r1
	str	r3, [r5, #28]
	str	r7, [r5, #32]
	str	r4, [r5, #36]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L16:
	rsb	r1, r7, #24
	rsb	r8, r7, #16
	bic	r1, r1, #7
	ldr	r6, [r0, #28]
	rsb	r8, r1, r8
	add	r7, r7, r1
	bl	BsGet
	and	r3, r8, #7
	orr	r3, r6, r0, asl r3
	b	.L17
.L21:
	.align	2
.L20:
	.word	.LANCHOR0
	.fnend
	.size	Vp9_Cabac_Read, .-Vp9_Cabac_Read
	.align	2
	.global	Vp9_Cabac_ReadLiteral
	.type	Vp9_Cabac_ReadLiteral, %function
Vp9_Cabac_ReadLiteral:
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
	subs	r7, r1, #1
	mov	r6, r0
	bmi	.L27
	ldr	r8, [r0, #28]
	mov	r9, #0
	ldr	r4, [r0, #36]
	mov	r3, #1
	ldr	r5, [r0, #32]
	ldr	r10, .L31
	b	.L26
.L24:
	mov	r2, r4, asl #24
	mov	r1, r3, asl r7
	cmp	r2, r0
	sub	r7, r7, #1
	rsbls	r0, r2, r0
	ldrls	ip, [r6, #36]
	movhi	r1, #0
	orr	r9, r9, r1
	rsbls	r4, r4, ip
	cmn	r7, #1
	add	r2, r10, r4
	ldrb	r2, [r2, #24]
	mov	r8, r0, asl r2
	rsb	r5, r2, r5
	mov	r4, r4, asl r2
	str	r8, [r6, #28]
	str	r5, [r6, #32]
	str	r4, [r6, #36]
	beq	.L23
.L26:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r8
	add	r4, r4, #1
	bge	.L24
	rsb	r1, r5, #24
	rsb	r2, r5, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	r3, [fp, #-52]
	str	r2, [fp, #-48]
	add	r5, r1, r5
	bl	BsGet
	ldr	r2, [fp, #-48]
	ldr	r3, [fp, #-52]
	and	r2, r2, #7
	orr	r0, r8, r0, asl r2
	b	.L24
.L27:
	mov	r9, #0
.L23:
	mov	r0, r9
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L32:
	.align	2
.L31:
	.word	.LANCHOR0
	.fnend
	.size	Vp9_Cabac_ReadLiteral, .-Vp9_Cabac_ReadLiteral
	.align	2
	.global	Vp9_Cabac_ReaderInit
	.type	Vp9_Cabac_ReaderInit, %function
Vp9_Cabac_ReaderInit:
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
	mvn	r2, #7
	mov	r3, #255
	mov	r5, #0
	str	r2, [r0, #32]
	mov	r1, #32
	str	r3, [r0, #36]
	mov	r4, r0
	str	r5, [r0, #28]
	bl	BsGet
	mov	r2, r0
	ldr	r0, [r4, #36]
	sub	r3, r0, #1
	ubfx	r3, r3, #1, #24
	add	r3, r3, #1
	mov	r1, r3, asl #24
	cmp	r2, r1
	rsbcs	r2, r1, r2
	ldr	r1, .L36
	rsbcs	r3, r3, r0
	movcc	r0, r5
	add	r1, r1, r3
	movcs	r0, #1
	ldrb	r1, [r1, #24]
	mov	r2, r2, asl r1
	mov	r3, r3, asl r1
	str	r2, [r4, #28]
	rsb	r1, r1, #24
	str	r3, [r4, #36]
	str	r1, [r4, #32]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L37:
	.align	2
.L36:
	.word	.LANCHOR0
	.fnend
	.size	Vp9_Cabac_ReaderInit, .-Vp9_Cabac_ReaderInit
	.align	2
	.global	Vp9_ReadTxMode
	.type	Vp9_ReadTxMode, %function
Vp9_ReadTxMode:
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
	mov	r7, #1
	mov	r6, r0
	ldr	r10, .L52
	mov	r3, r7
	ldr	r4, [r0, #36]
	mov	r9, #0
	ldr	r5, [r0, #32]
	ldr	r8, [r0, #28]
	b	.L41
.L39:
	mov	r2, r4, asl #24
	mov	r1, r3, asl r7
	cmp	r2, r0
	sub	r7, r7, #1
	rsbls	r0, r2, r0
	ldrls	ip, [r6, #36]
	movhi	r1, #0
	orr	r9, r9, r1
	rsbls	r4, r4, ip
	cmn	r7, #1
	add	r2, r10, r4
	ldrb	r2, [r2, #24]
	mov	r8, r0, asl r2
	rsb	r5, r2, r5
	mov	r4, r4, asl r2
	str	r8, [r6, #28]
	str	r5, [r6, #32]
	str	r4, [r6, #36]
	beq	.L49
.L41:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r8
	add	r4, r4, #1
	bge	.L39
	rsb	r1, r5, #24
	rsb	r2, r5, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	r3, [fp, #-52]
	str	r2, [fp, #-48]
	add	r5, r1, r5
	bl	BsGet
	ldr	r2, [fp, #-48]
	ldr	r3, [fp, #-52]
	and	r2, r2, #7
	orr	r0, r8, r0, asl r2
	b	.L39
.L49:
	cmp	r9, #3
	beq	.L50
	mov	r0, r9
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L50:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	add	r4, r4, #1
	movge	r0, r8
	blt	.L51
.L43:
	mov	r3, r4, asl #24
	cmp	r3, r0
	rsbls	r0, r3, r0
	ldrls	r2, [r6, #36]
	movls	r9, #4
	rsbls	r4, r4, r2
	add	r10, r10, r4
	ldrb	r3, [r10, #24]
	mov	r8, r0, asl r3
	rsb	r5, r3, r5
	mov	r4, r4, asl r3
	mov	r0, r9
	str	r8, [r6, #28]
	str	r5, [r6, #32]
	str	r4, [r6, #36]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L51:
	rsb	r1, r5, #24
	rsb	r7, r5, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r7, r1, r7
	add	r5, r1, r5
	bl	BsGet
	and	r7, r7, #7
	orr	r0, r8, r0, asl r7
	b	.L43
.L53:
	.align	2
.L52:
	.word	.LANCHOR0
	.fnend
	.size	Vp9_ReadTxMode, .-Vp9_ReadTxMode
	.align	2
	.global	Vp9_ReaderHasError
	.type	Vp9_ReaderHasError, %function
Vp9_ReaderHasError:
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
	ldr	r0, [r0, #32]
	sub	r0, r0, #33
	cmn	r0, #-1073741790
	movhi	r0, #0
	movls	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Vp9_ReaderHasError, .-Vp9_ReaderHasError
	.align	2
	.global	Vp9_DiffUpdateProb
	.type	Vp9_DiffUpdateProb, %function
Vp9_DiffUpdateProb:
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
	ldr	r4, [r0, #36]
	mov	r6, r0
	ldr	r5, [r0, #32]
	mov	r9, r1
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	add	r4, r4, #1
	blt	.L56
	ldr	r8, [r0, #28]
.L57:
	mov	r3, r4, asl #24
	cmp	r3, r8
	bhi	.L58
	ldr	r2, [r6, #36]
	rsb	r8, r3, r8
	ldr	r3, .L111
	rsb	r4, r4, r2
	add	r2, r3, r4
	ldrb	r1, [r2, #24]
	mov	r2, r4, asl r1
	rsb	r4, r1, r5
	cmp	r4, #0
	sub	r5, r2, #1
	ubfx	r5, r5, #1, #24
	mov	r8, r8, asl r1
	str	r2, [r6, #36]
	add	r5, r5, #1
	str	r4, [r6, #32]
	str	r8, [r6, #28]
	blt	.L105
.L60:
	mov	r1, r5, asl #24
	cmp	r1, r8
	bhi	.L65
	ldr	r2, [r6, #36]
	rsb	r8, r1, r8
	rsb	r5, r5, r2
	add	r2, r3, r5
	ldrb	ip, [r2, #24]
	mov	r2, r5, asl ip
	rsb	r5, ip, r4
	sub	r1, r2, #1
	cmp	r5, #0
	ubfx	r1, r1, #1, #24
	mov	r8, r8, asl ip
	str	r2, [r6, #36]
	add	r4, r1, #1
	str	r5, [r6, #32]
	str	r8, [r6, #28]
	blt	.L106
.L67:
	mov	r1, r4, asl #24
	cmp	r1, r8
	bhi	.L71
	ldr	r2, [r6, #36]
	rsb	r8, r1, r8
	mov	r7, #0
	mov	r10, #6
	rsb	r1, r4, r2
	mov	r2, #1
	add	r0, r3, r1
	ldrb	r4, [r0, #24]
	mov	r8, r8, asl r4
	rsb	r5, r4, r5
	str	r8, [r6, #28]
	mov	r4, r1, asl r4
	str	r5, [r6, #32]
	str	r4, [r6, #36]
	b	.L72
.L76:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r10
	cmp	r1, r0
	sub	r10, r10, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r6, #36]
	movhi	ip, #0
	orr	r7, r7, ip
	rsbls	r4, r4, lr
	cmn	r10, #1
	add	r1, r3, r4
	ldrb	r1, [r1, #24]
	mov	r8, r0, asl r1
	rsb	r5, r1, r5
	mov	r4, r4, asl r1
	str	r8, [r6, #28]
	str	r5, [r6, #32]
	str	r4, [r6, #36]
	beq	.L107
.L72:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r8
	add	r4, r4, #1
	bge	.L76
	rsb	r1, r5, #24
	rsb	ip, r5, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	ip, r1, ip
	str	r2, [fp, #-56]
	str	r3, [fp, #-52]
	add	r5, r1, r5
	str	ip, [fp, #-48]
	bl	BsGet
	ldr	ip, [fp, #-48]
	ldr	r3, [fp, #-52]
	and	ip, ip, #7
	ldr	r2, [fp, #-56]
	orr	r0, r8, r0, asl ip
	b	.L76
.L65:
	add	r1, r3, r5
	mov	r7, #0
	mov	r10, #3
	mov	r2, #1
	ldrb	r1, [r1, #24]
	mov	r8, r8, asl r1
	rsb	r4, r1, r4
	mov	r5, r5, asl r1
	str	r8, [r6, #28]
	str	r4, [r6, #32]
	str	r5, [r6, #36]
	b	.L70
.L68:
	mov	r1, r5, asl #24
	mov	ip, r2, asl r10
	cmp	r1, r0
	sub	r10, r10, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r6, #36]
	movhi	ip, #0
	orr	r7, r7, ip
	rsbls	r5, r5, lr
	cmn	r10, #1
	add	r1, r3, r5
	ldrb	r1, [r1, #24]
	mov	r8, r0, asl r1
	rsb	r4, r1, r4
	mov	r5, r5, asl r1
	str	r8, [r6, #28]
	str	r4, [r6, #32]
	str	r5, [r6, #36]
	beq	.L108
.L70:
	sub	r5, r5, #1
	cmp	r4, #0
	ubfx	r5, r5, #1, #24
	mov	r0, r8
	add	r5, r5, #1
	bge	.L68
	rsb	r1, r4, #24
	rsb	ip, r4, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	ip, r1, ip
	str	r2, [fp, #-56]
	str	r3, [fp, #-52]
	add	r4, r1, r4
	str	ip, [fp, #-48]
	bl	BsGet
	ldr	ip, [fp, #-48]
	ldr	r3, [fp, #-52]
	and	ip, ip, #7
	ldr	r2, [fp, #-56]
	orr	r0, r8, r0, asl ip
	b	.L68
.L58:
	ldr	r3, .L111
	mov	r7, #0
	mov	r10, #3
	mov	r2, #1
	add	r1, r3, r4
	ldrb	r1, [r1, #24]
	mov	r8, r8, asl r1
	rsb	r5, r1, r5
	mov	r4, r4, asl r1
	str	r8, [r6, #28]
	str	r5, [r6, #32]
	str	r4, [r6, #36]
	b	.L63
.L61:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r10
	cmp	r1, r0
	sub	r10, r10, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r6, #36]
	movhi	ip, #0
	orr	r7, r7, ip
	rsbls	r4, r4, lr
	cmn	r10, #1
	add	r1, r3, r4
	ldrb	r1, [r1, #24]
	mov	r8, r0, asl r1
	rsb	r5, r1, r5
	mov	r4, r4, asl r1
	str	r8, [r6, #28]
	str	r5, [r6, #32]
	str	r4, [r6, #36]
	beq	.L64
.L63:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r8
	add	r4, r4, #1
	bge	.L61
	rsb	r1, r5, #24
	rsb	ip, r5, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	ip, r1, ip
	str	r2, [fp, #-56]
	str	r3, [fp, #-52]
	add	r5, r1, r5
	str	ip, [fp, #-48]
	bl	BsGet
	ldr	ip, [fp, #-48]
	ldr	r3, [fp, #-52]
	and	ip, ip, #7
	ldr	r2, [fp, #-56]
	orr	r0, r8, r0, asl ip
	b	.L61
.L107:
	cmp	r7, #64
	ble	.L78
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r7, r7, asl #1
	add	r4, r4, #1
	sub	r7, r7, #65
	movge	r0, r8
	blt	.L109
.L79:
	mov	r2, r4, asl #24
	cmp	r2, r0
	rsbls	r0, r2, r0
	ldrls	ip, [r6, #36]
	movls	r1, #1
	movhi	r1, #0
	add	r7, r7, r1
	rsbls	r4, r4, ip
	add	r2, r3, r4
	ldrb	r2, [r2, #24]
	mov	r8, r0, asl r2
	rsb	r5, r2, r5
	mov	r4, r4, asl r2
	str	r8, [r6, #28]
	str	r5, [r6, #32]
	str	r4, [r6, #36]
.L78:
	add	r7, r7, #64
.L64:
	ldrb	r2, [r9]
	add	r3, r3, r7
	sub	ip, r2, #1
	ldrb	r1, [r3, #280]
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L81
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L82
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L82:
	add	r3, r3, #1
	strb	r3, [r9]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L81:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	bgt	.L85
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
.L85:
	rsb	r3, r3, #255
	strb	r3, [r9]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L108:
	add	r7, r7, #16
	b	.L64
.L71:
	add	r1, r3, r4
	mov	r7, #0
	mov	r10, #4
	mov	r2, #1
	ldrb	r1, [r1, #24]
	mov	r8, r8, asl r1
	rsb	r5, r1, r5
	str	r8, [r6, #28]
	mov	r1, r4, asl r1
	str	r5, [r6, #32]
	str	r1, [r6, #36]
	b	.L75
.L73:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r10
	cmp	r1, r0
	sub	r10, r10, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r6, #36]
	movhi	ip, #0
	orr	r7, r7, ip
	rsbls	r4, r4, lr
	cmn	r10, #1
	add	r1, r3, r4
	ldrb	r1, [r1, #24]
	mov	r8, r0, asl r1
	rsb	r5, r1, r5
	str	r8, [r6, #28]
	mov	r1, r4, asl r1
	str	r5, [r6, #32]
	str	r1, [r6, #36]
	beq	.L110
.L75:
	sub	r1, r1, #1
	cmp	r5, #0
	ubfx	r1, r1, #1, #24
	mov	r0, r8
	add	r4, r1, #1
	bge	.L73
	rsb	r1, r5, #24
	rsb	ip, r5, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	ip, r1, ip
	str	r2, [fp, #-56]
	str	r3, [fp, #-52]
	add	r5, r1, r5
	str	ip, [fp, #-48]
	bl	BsGet
	ldr	ip, [fp, #-48]
	ldr	r3, [fp, #-52]
	and	ip, ip, #7
	ldr	r2, [fp, #-56]
	orr	r0, r8, r0, asl ip
	b	.L73
.L110:
	add	r7, r7, #32
	b	.L64
.L56:
	rsb	r10, r5, #24
	ldr	r7, [r0, #28]
	bic	r10, r10, #7
	rsb	r8, r5, #16
	rsb	r8, r10, r8
	add	r5, r5, r10
	mov	r1, r10
	and	r8, r8, #7
	bl	BsGet
	str	r5, [r6, #32]
	orr	r0, r7, r0, asl r8
	str	r0, [r6, #28]
	mov	r8, r0
	b	.L57
.L105:
	rsb	r10, r4, #24
	mov	r0, r6
	bic	r10, r10, #7
	str	r3, [fp, #-48]
	rsb	r7, r4, #16
	add	r4, r4, r10
	mov	r1, r10
	rsb	r7, r10, r7
	bl	BsGet
	and	r7, r7, #7
	str	r4, [r6, #32]
	ldr	r3, [fp, #-48]
	orr	r0, r8, r0, asl r7
	str	r0, [r6, #28]
	mov	r8, r0
	b	.L60
.L106:
	rsb	r10, r5, #24
	mov	r0, r6
	bic	r10, r10, #7
	str	r3, [fp, #-48]
	rsb	r7, r5, #16
	add	r5, r5, r10
	mov	r1, r10
	rsb	r7, r10, r7
	bl	BsGet
	and	r7, r7, #7
	str	r5, [r6, #32]
	ldr	r3, [fp, #-48]
	orr	r0, r8, r0, asl r7
	str	r0, [r6, #28]
	mov	r8, r0
	b	.L67
.L109:
	rsb	r1, r5, #24
	rsb	r10, r5, #16
	bic	r1, r1, #7
	mov	r0, r6
	str	r3, [fp, #-48]
	rsb	r10, r1, r10
	add	r5, r1, r5
	bl	BsGet
	and	r10, r10, #7
	ldr	r3, [fp, #-48]
	orr	r0, r8, r0, asl r10
	b	.L79
.L112:
	.align	2
.L111:
	.word	.LANCHOR0
	.fnend
	.size	Vp9_DiffUpdateProb, .-Vp9_DiffUpdateProb
	.align	2
	.global	Vp9_ReadTxProbs
	.type	Vp9_ReadTxProbs, %function
Vp9_ReadTxProbs:
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
	ldr	r6, .L405
	add	r9, r0, #10
	ldr	r4, [r1, #28]
	mov	r5, r1
	ldr	r3, [r1, #36]
	add	r2, r0, #12
	ldr	r8, [r1, #32]
	str	r0, [fp, #-52]
	str	r2, [fp, #-48]
.L144:
	sub	r10, r3, #1
	cmp	r8, #0
	mov	r3, r10, asl #8
	sub	r10, r3, r10, asl #2
	mov	r10, r10, lsr #8
	add	r10, r10, #1
	blt	.L357
.L114:
	mov	r7, r10, asl #24
	cmp	r7, r4
	bhi	.L115
	ldr	r3, [r5, #36]
	rsb	r7, r7, r4
	rsb	r10, r10, r3
	add	r3, r6, r10
	ldrb	r3, [r3, #24]
	mov	r10, r10, asl r3
	rsb	r8, r3, r8
	sub	r4, r10, #1
	cmp	r8, #0
	ubfx	r4, r4, #1, #24
	mov	r7, r7, asl r3
	str	r10, [r5, #36]
	add	r4, r4, #1
	str	r8, [r5, #32]
	str	r7, [r5, #28]
	blt	.L358
.L116:
	mov	r3, r4, asl #24
	cmp	r3, r7
	bhi	.L117
	ldr	r2, [r5, #36]
	rsb	r3, r3, r7
	rsb	r4, r4, r2
	add	r2, r6, r4
	ldrb	r0, [r2, #24]
	mov	r2, r4, asl r0
	rsb	r4, r0, r8
	sub	r7, r2, #1
	cmp	r4, #0
	ubfx	r7, r7, #1, #24
	mov	r8, r3, asl r0
	str	r2, [r5, #36]
	add	r7, r7, #1
	str	r4, [r5, #32]
	str	r8, [r5, #28]
	blt	.L359
.L119:
	mov	r3, r7, asl #24
	cmp	r3, r8
	bhi	.L124
	ldr	r1, [r5, #36]
	rsb	r3, r3, r8
	rsb	r7, r7, r1
	add	r2, r6, r7
	ldrb	r2, [r2, #24]
	rsb	r8, r2, r4
	mov	r1, r7, asl r2
	sub	r7, r1, #1
	cmp	r8, #0
	ubfx	r7, r7, #1, #24
	mov	r4, r3, asl r2
	str	r1, [r5, #36]
	add	r7, r7, #1
	str	r8, [r5, #32]
	str	r4, [r5, #28]
	blt	.L360
.L126:
	mov	r2, r7, asl #24
	cmp	r2, r4
	bhi	.L130
	ldr	r1, [r5, #36]
	rsb	r2, r2, r4
	mov	r10, #0
	mov	r3, #6
	rsb	r7, r7, r1
	str	r9, [fp, #-64]
	add	r1, r6, r7
	mov	r9, r10
	mov	ip, #1
	ldrb	r4, [r1, #24]
	mov	r2, r2, asl r4
	rsb	r8, r4, r8
	str	r2, [r5, #28]
	mov	r4, r7, asl r4
	str	r8, [r5, #32]
	mov	r7, r3
	str	r4, [r5, #36]
	mov	r10, r2
	b	.L131
.L135:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r7
	cmp	r2, r0
	sub	r7, r7, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r9, r9, r1
	rsbls	r4, r4, lr
	cmn	r7, #1
	add	r2, r6, r4
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r8, r2, r8
	mov	r4, r4, asl r2
	str	r10, [r5, #28]
	str	r8, [r5, #32]
	str	r4, [r5, #36]
	beq	.L361
.L131:
	sub	r4, r4, #1
	cmp	r8, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L135
	rsb	r1, r8, #24
	rsb	r2, r8, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-60]
	str	r2, [fp, #-56]
	add	r8, r1, r8
	bl	BsGet
	ldr	r2, [fp, #-56]
	ldr	ip, [fp, #-60]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L135
.L115:
	add	r3, r6, r10
	ldrb	r3, [r3, #24]
	mov	r4, r4, asl r3
	rsb	r8, r3, r8
	str	r4, [r5, #28]
	mov	r3, r10, asl r3
	str	r8, [r5, #32]
	str	r3, [r5, #36]
.L272:
	ldr	r2, [fp, #-48]
	add	r9, r9, #1
	cmp	r9, r2
	bne	.L144
	ldr	r2, [fp, #-52]
	add	r1, r2, #4
	str	r1, [fp, #-48]
	mov	r9, r2
.L207:
	sub	r7, r3, #1
	cmp	r8, #0
	mov	r3, r7, asl #8
	sub	r7, r3, r7, asl #2
	mov	r7, r7, lsr #8
	add	r7, r7, #1
	blt	.L362
.L145:
	mov	r10, r7, asl #24
	cmp	r10, r4
	bhi	.L146
	ldr	r3, [r5, #36]
	rsb	r10, r10, r4
	rsb	r7, r7, r3
	add	r3, r6, r7
	ldrb	r2, [r3, #24]
	mov	r3, r7, asl r2
	rsb	r4, r2, r8
	sub	r7, r3, #1
	cmp	r4, #0
	ubfx	r7, r7, #1, #24
	mov	r10, r10, asl r2
	str	r3, [r5, #36]
	add	r7, r7, #1
	str	r4, [r5, #32]
	str	r10, [r5, #28]
	blt	.L363
.L147:
	mov	r2, r7, asl #24
	cmp	r2, r10
	bhi	.L148
	ldr	ip, [r5, #36]
	rsb	r10, r2, r10
	rsb	r7, r7, ip
	add	r3, r6, r7
	ldrb	r0, [r3, #24]
	mov	ip, r7, asl r0
	rsb	r4, r0, r4
	sub	r7, ip, #1
	cmp	r4, #0
	ubfx	r7, r7, #1, #24
	mov	r10, r10, asl r0
	str	ip, [r5, #36]
	add	r7, r7, #1
	str	r4, [r5, #32]
	str	r10, [r5, #28]
	blt	.L364
.L150:
	mov	r3, r7, asl #24
	cmp	r3, r10
	bhi	.L155
	ldr	r1, [r5, #36]
	rsb	r3, r3, r10
	rsb	r7, r7, r1
	add	r2, r6, r7
	ldrb	ip, [r2, #24]
	rsb	r10, ip, r4
	mov	r1, r7, asl ip
	sub	r7, r1, #1
	cmp	r10, #0
	ubfx	r7, r7, #1, #24
	mov	r4, r3, asl ip
	str	r1, [r5, #36]
	add	r7, r7, #1
	str	r10, [r5, #32]
	str	r4, [r5, #28]
	blt	.L365
.L157:
	mov	r2, r7, asl #24
	cmp	r2, r4
	bhi	.L161
	ldr	r1, [r5, #36]
	rsb	r2, r2, r4
	mov	r8, #0
	mov	r3, #6
	rsb	r7, r7, r1
	str	r9, [fp, #-64]
	add	r1, r6, r7
	mov	r9, r8
	mov	ip, #1
	ldrb	r4, [r1, #24]
	mov	r2, r2, asl r4
	rsb	r10, r4, r10
	str	r2, [r5, #28]
	mov	r4, r7, asl r4
	str	r10, [r5, #32]
	mov	r7, r3
	str	r4, [r5, #36]
	mov	r8, r2
	b	.L162
.L166:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r7
	cmp	r2, r0
	sub	r7, r7, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r9, r9, r1
	rsbls	r4, r4, lr
	cmn	r7, #1
	add	r2, r6, r4
	ldrb	r2, [r2, #24]
	mov	r8, r0, asl r2
	rsb	r10, r2, r10
	mov	r4, r4, asl r2
	str	r8, [r5, #28]
	str	r10, [r5, #32]
	str	r4, [r5, #36]
	beq	.L366
.L162:
	sub	r4, r4, #1
	cmp	r10, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r8
	add	r4, r4, #1
	bge	.L166
	rsb	r1, r10, #24
	rsb	r2, r10, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-60]
	str	r2, [fp, #-56]
	add	r10, r1, r10
	bl	BsGet
	ldr	r2, [fp, #-56]
	ldr	ip, [fp, #-60]
	and	r2, r2, #7
	orr	r0, r8, r0, asl r2
	b	.L166
.L146:
	add	r3, r6, r7
	ldrb	r3, [r3, #24]
	mov	r4, r4, asl r3
	rsb	r8, r3, r8
	mov	r7, r7, asl r3
	str	r4, [r5, #28]
	str	r8, [r5, #32]
	str	r7, [r5, #36]
.L273:
	sub	r7, r7, #1
	cmp	r8, #0
	mov	r3, r7, asl #8
	sub	r7, r3, r7, asl #2
	mov	r7, r7, lsr #8
	add	r7, r7, #1
	blt	.L367
.L177:
	mov	r0, r7, asl #24
	cmp	r0, r4
	bhi	.L178
	ldr	r3, [r5, #36]
	rsb	r0, r0, r4
	rsb	r7, r7, r3
	add	r3, r6, r7
	ldrb	r2, [r3, #24]
	rsb	r4, r2, r8
	mov	r3, r7, asl r2
	sub	r7, r3, #1
	cmp	r4, #0
	ubfx	r7, r7, #1, #24
	mov	r8, r0, asl r2
	str	r3, [r5, #36]
	add	r7, r7, #1
	str	r4, [r5, #32]
	str	r8, [r5, #28]
	blt	.L368
.L179:
	mov	r2, r7, asl #24
	cmp	r2, r8
	bhi	.L180
	ldr	ip, [r5, #36]
	rsb	r8, r2, r8
	rsb	r7, r7, ip
	add	r3, r6, r7
	ldrb	r0, [r3, #24]
	mov	ip, r7, asl r0
	rsb	r4, r0, r4
	sub	r7, ip, #1
	cmp	r4, #0
	ubfx	r7, r7, #1, #24
	mov	r8, r8, asl r0
	str	ip, [r5, #36]
	add	r7, r7, #1
	str	r4, [r5, #32]
	str	r8, [r5, #28]
	blt	.L369
.L182:
	mov	r3, r7, asl #24
	cmp	r3, r8
	bhi	.L187
	ldr	r1, [r5, #36]
	rsb	r3, r3, r8
	rsb	r7, r7, r1
	add	r2, r6, r7
	ldrb	ip, [r2, #24]
	rsb	r8, ip, r4
	mov	r1, r7, asl ip
	sub	r7, r1, #1
	cmp	r8, #0
	ubfx	r7, r7, #1, #24
	mov	r4, r3, asl ip
	str	r1, [r5, #36]
	add	r7, r7, #1
	str	r8, [r5, #32]
	str	r4, [r5, #28]
	blt	.L370
.L189:
	mov	r2, r7, asl #24
	cmp	r2, r4
	bhi	.L193
	ldr	r1, [r5, #36]
	rsb	r2, r2, r4
	mov	r10, #0
	mov	r3, #6
	rsb	r7, r7, r1
	str	r9, [fp, #-64]
	add	r1, r6, r7
	mov	r9, r10
	mov	ip, #1
	ldrb	r4, [r1, #24]
	mov	r2, r2, asl r4
	rsb	r8, r4, r8
	str	r2, [r5, #28]
	mov	r4, r7, asl r4
	str	r8, [r5, #32]
	mov	r7, r3
	str	r4, [r5, #36]
	mov	r10, r2
	b	.L194
.L198:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r7
	cmp	r2, r0
	sub	r7, r7, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r9, r9, r1
	rsbls	r4, r4, lr
	cmn	r7, #1
	add	r2, r6, r4
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r8, r2, r8
	mov	r4, r4, asl r2
	str	r10, [r5, #28]
	str	r8, [r5, #32]
	str	r4, [r5, #36]
	beq	.L371
.L194:
	sub	r4, r4, #1
	cmp	r8, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L198
	rsb	r1, r8, #24
	rsb	r2, r8, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-60]
	str	r2, [fp, #-56]
	add	r8, r1, r8
	bl	BsGet
	ldr	r2, [fp, #-56]
	ldr	ip, [fp, #-60]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L198
.L178:
	add	r3, r6, r7
	ldrb	r3, [r3, #24]
	mov	r4, r4, asl r3
	rsb	r8, r3, r8
	str	r4, [r5, #28]
	mov	r3, r7, asl r3
	str	r8, [r5, #32]
	str	r3, [r5, #36]
.L274:
	ldr	r2, [fp, #-48]
	add	r9, r9, #2
	cmp	r9, r2
	bne	.L207
	ldr	r2, [fp, #-52]
	mov	r9, r4
	mov	r10, r3
	add	r7, r2, #1
	add	r2, r2, #7
	str	r2, [fp, #-48]
.L271:
	sub	r10, r10, #1
	cmp	r8, #0
	mov	r2, r10, asl #8
	sub	r10, r2, r10, asl #2
	mov	r10, r10, lsr #8
	add	r10, r10, #1
	blt	.L372
.L208:
	mov	r0, r10, asl #24
	cmp	r0, r9
	bhi	.L209
	ldr	r3, [r5, #36]
	rsb	r9, r0, r9
	rsb	r10, r10, r3
	add	r3, r6, r10
	ldrb	r3, [r3, #24]
	rsb	r4, r3, r8
	mov	r10, r10, asl r3
	sub	r8, r10, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r9, r9, asl r3
	str	r10, [r5, #36]
	add	r8, r8, #1
	str	r4, [r5, #32]
	str	r9, [r5, #28]
	blt	.L373
.L210:
	mov	r3, r8, asl #24
	cmp	r3, r9
	bhi	.L211
	ldr	r2, [r5, #36]
	rsb	r9, r3, r9
	rsb	r8, r8, r2
	add	r3, r6, r8
	ldrb	r0, [r3, #24]
	mov	r2, r8, asl r0
	rsb	r4, r0, r4
	sub	r8, r2, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r9, r9, asl r0
	str	r2, [r5, #36]
	add	r8, r8, #1
	str	r4, [r5, #32]
	str	r9, [r5, #28]
	blt	.L374
.L213:
	mov	r3, r8, asl #24
	cmp	r3, r9
	bhi	.L218
	ldr	r1, [r5, #36]
	rsb	r3, r3, r9
	rsb	r8, r8, r1
	add	r2, r6, r8
	ldrb	r2, [r2, #24]
	rsb	r9, r2, r4
	mov	r1, r8, asl r2
	sub	r8, r1, #1
	cmp	r9, #0
	ubfx	r8, r8, #1, #24
	mov	r4, r3, asl r2
	str	r1, [r5, #36]
	add	r8, r8, #1
	str	r9, [r5, #32]
	str	r4, [r5, #28]
	blt	.L375
.L220:
	mov	r2, r8, asl #24
	cmp	r2, r4
	bhi	.L224
	ldr	r1, [r5, #36]
	rsb	r2, r2, r4
	mov	r10, #0
	mov	r3, #6
	rsb	r8, r8, r1
	str	r7, [fp, #-60]
	add	r1, r6, r8
	mov	r7, r10
	mov	ip, #1
	ldrb	r4, [r1, #24]
	mov	r2, r2, asl r4
	rsb	r9, r4, r9
	str	r2, [r5, #28]
	mov	r4, r8, asl r4
	str	r9, [r5, #32]
	mov	r8, r3
	str	r4, [r5, #36]
	mov	r10, r2
	b	.L225
.L229:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r8
	cmp	r2, r0
	sub	r8, r8, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r2, r6, r4
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r9, r2, r9
	mov	r4, r4, asl r2
	str	r10, [r5, #28]
	str	r9, [r5, #32]
	str	r4, [r5, #36]
	beq	.L376
.L225:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L229
	rsb	r1, r9, #24
	rsb	r2, r9, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L229
.L209:
	add	r3, r6, r10
	ldrb	r3, [r3, #24]
	mov	r9, r9, asl r3
	rsb	r4, r3, r8
	mov	r10, r10, asl r3
	str	r9, [r5, #28]
	str	r4, [r5, #32]
	str	r10, [r5, #36]
.L275:
	sub	r10, r10, #1
	cmp	r4, #0
	mov	r3, r10, asl #8
	sub	r10, r3, r10, asl #2
	mov	r10, r10, lsr #8
	add	r10, r10, #1
	blt	.L377
.L238:
	mov	r8, r10, asl #24
	cmp	r8, r9
	bhi	.L239
	ldr	r3, [r5, #36]
	rsb	r8, r8, r9
	mov	r1, r7
	mov	r0, r5
	rsb	r10, r10, r3
	add	r3, r6, r10
	ldrb	r3, [r3, #24]
	mov	r8, r8, asl r3
	rsb	r4, r3, r4
	mov	r10, r10, asl r3
	str	r8, [r5, #28]
	str	r4, [r5, #32]
	str	r10, [r5, #36]
	bl	Vp9_DiffUpdateProb
	ldr	r8, [r5, #28]
	ldr	r10, [r5, #36]
	ldr	r4, [r5, #32]
.L276:
	sub	r10, r10, #1
	cmp	r4, #0
	mov	r3, r10, asl #8
	sub	r10, r3, r10, asl #2
	mov	r10, r10, lsr #8
	add	r10, r10, #1
	blt	.L378
.L240:
	mov	r9, r10, asl #24
	cmp	r9, r8
	bhi	.L241
	ldr	r3, [r5, #36]
	rsb	r9, r9, r8
	rsb	r10, r10, r3
	add	r3, r6, r10
	ldrb	r3, [r3, #24]
	mov	r10, r10, asl r3
	rsb	r4, r3, r4
	sub	r8, r10, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r9, r9, asl r3
	str	r10, [r5, #36]
	add	r8, r8, #1
	str	r4, [r5, #32]
	str	r9, [r5, #28]
	blt	.L379
.L242:
	mov	r3, r8, asl #24
	cmp	r3, r9
	bhi	.L243
	ldr	r2, [r5, #36]
	rsb	r9, r3, r9
	rsb	r8, r8, r2
	add	r3, r6, r8
	ldrb	r0, [r3, #24]
	mov	r2, r8, asl r0
	rsb	r4, r0, r4
	sub	r8, r2, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r9, r9, asl r0
	str	r2, [r5, #36]
	add	r8, r8, #1
	str	r4, [r5, #32]
	str	r9, [r5, #28]
	blt	.L380
.L245:
	mov	r3, r8, asl #24
	cmp	r3, r9
	bhi	.L250
	ldr	r1, [r5, #36]
	rsb	r3, r3, r9
	rsb	r8, r8, r1
	add	r2, r6, r8
	ldrb	r2, [r2, #24]
	rsb	r9, r2, r4
	mov	r1, r8, asl r2
	sub	r8, r1, #1
	cmp	r9, #0
	ubfx	r8, r8, #1, #24
	mov	r4, r3, asl r2
	str	r1, [r5, #36]
	add	r8, r8, #1
	str	r9, [r5, #32]
	str	r4, [r5, #28]
	blt	.L381
.L252:
	mov	r2, r8, asl #24
	cmp	r2, r4
	bhi	.L256
	ldr	r1, [r5, #36]
	rsb	r2, r2, r4
	mov	r10, #0
	mov	r3, #6
	rsb	r8, r8, r1
	str	r7, [fp, #-60]
	add	r1, r6, r8
	mov	r7, r10
	mov	ip, #1
	ldrb	r4, [r1, #24]
	mov	r2, r2, asl r4
	rsb	r9, r4, r9
	str	r2, [r5, #28]
	mov	r4, r8, asl r4
	str	r9, [r5, #32]
	mov	r8, r3
	str	r4, [r5, #36]
	mov	r10, r2
	b	.L257
.L261:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r8
	cmp	r2, r0
	sub	r8, r8, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r2, r6, r4
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r9, r2, r9
	mov	r4, r4, asl r2
	str	r10, [r5, #28]
	str	r9, [r5, #32]
	str	r4, [r5, #36]
	beq	.L382
.L257:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L261
	rsb	r1, r9, #24
	rsb	r2, r9, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L261
.L239:
	add	r3, r6, r10
	ldrb	r3, [r3, #24]
	mov	r8, r9, asl r3
	rsb	r4, r3, r4
	mov	r10, r10, asl r3
	str	r8, [r5, #28]
	str	r4, [r5, #32]
	str	r10, [r5, #36]
	b	.L276
.L241:
	add	r3, r6, r10
	ldrb	r3, [r3, #24]
	mov	r8, r8, asl r3
	rsb	r4, r3, r4
	mov	r10, r10, asl r3
	str	r8, [r5, #28]
	str	r4, [r5, #32]
	str	r10, [r5, #36]
.L277:
	ldr	r3, [fp, #-48]
	add	r7, r7, #3
	cmp	r7, r3
	ldrne	r9, [r5, #28]
	ldrne	r10, [r5, #36]
	ldrne	r8, [r5, #32]
	bne	.L271
.L113:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L211:
	add	r3, r6, r8
	mov	r10, #0
	mov	r2, #3
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r5, #28]
	mov	r8, r8, asl r1
	mov	r10, r9
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	mov	r9, r2
	b	.L216
.L214:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r9, #1
	add	r2, r6, r8
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	beq	.L383
.L216:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r10
	add	r8, r8, #1
	bge	.L214
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L214
.L180:
	add	r3, r6, r7
	mov	r10, #0
	mov	r2, #3
	str	r9, [fp, #-64]
	ldrb	r1, [r3, #24]
	mov	r9, r10
	mov	ip, #1
	mov	r8, r8, asl r1
	rsb	r4, r1, r4
	str	r8, [r5, #28]
	mov	r7, r7, asl r1
	mov	r10, r8
	str	r4, [r5, #32]
	str	r7, [r5, #36]
	mov	r8, r2
	b	.L185
.L183:
	mov	r2, r7, asl #24
	mov	r1, ip, asl r8
	cmp	r2, r0
	sub	r8, r8, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r9, r9, r1
	rsbls	r7, r7, lr
	cmn	r8, #1
	add	r2, r6, r7
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r7, r7, asl r2
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r7, [r5, #36]
	beq	.L384
.L185:
	sub	r7, r7, #1
	cmp	r4, #0
	ubfx	r7, r7, #1, #24
	mov	r0, r10
	add	r7, r7, #1
	bge	.L183
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-60]
	str	r2, [fp, #-56]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-56]
	ldr	ip, [fp, #-60]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L183
.L148:
	add	r3, r6, r7
	mov	r8, #0
	mov	r2, #3
	str	r9, [fp, #-64]
	ldrb	r1, [r3, #24]
	mov	r9, r8
	mov	ip, #1
	mov	r10, r10, asl r1
	rsb	r4, r1, r4
	str	r10, [r5, #28]
	mov	r7, r7, asl r1
	mov	r8, r10
	str	r4, [r5, #32]
	str	r7, [r5, #36]
	mov	r10, r2
	b	.L153
.L151:
	mov	r2, r7, asl #24
	mov	r1, ip, asl r10
	cmp	r2, r0
	sub	r10, r10, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r9, r9, r1
	rsbls	r7, r7, lr
	cmn	r10, #1
	add	r2, r6, r7
	ldrb	r2, [r2, #24]
	mov	r8, r0, asl r2
	rsb	r4, r2, r4
	mov	r7, r7, asl r2
	str	r8, [r5, #28]
	str	r4, [r5, #32]
	str	r7, [r5, #36]
	beq	.L385
.L153:
	sub	r7, r7, #1
	cmp	r4, #0
	ubfx	r7, r7, #1, #24
	mov	r0, r8
	add	r7, r7, #1
	bge	.L151
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-60]
	str	r2, [fp, #-56]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-56]
	ldr	ip, [fp, #-60]
	and	r2, r2, #7
	orr	r0, r8, r0, asl r2
	b	.L151
.L117:
	add	r3, r6, r4
	mov	r10, #0
	mov	r2, #3
	str	r9, [fp, #-64]
	ldrb	r1, [r3, #24]
	mov	r9, r10
	mov	ip, #1
	mov	r7, r7, asl r1
	rsb	r8, r1, r8
	str	r7, [r5, #28]
	mov	r4, r4, asl r1
	mov	r10, r7
	str	r8, [r5, #32]
	str	r4, [r5, #36]
	mov	r7, r2
	b	.L122
.L120:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r7
	cmp	r2, r0
	sub	r7, r7, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r9, r9, r1
	rsbls	r4, r4, lr
	cmn	r7, #1
	add	r2, r6, r4
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r8, r2, r8
	mov	r4, r4, asl r2
	str	r10, [r5, #28]
	str	r8, [r5, #32]
	str	r4, [r5, #36]
	beq	.L386
.L122:
	sub	r4, r4, #1
	cmp	r8, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L120
	rsb	r1, r8, #24
	rsb	r2, r8, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-60]
	str	r2, [fp, #-56]
	add	r8, r1, r8
	bl	BsGet
	ldr	r2, [fp, #-56]
	ldr	ip, [fp, #-60]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L120
.L243:
	add	r3, r6, r8
	mov	r10, #0
	mov	r2, #3
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r5, #28]
	mov	r8, r8, asl r1
	mov	r10, r9
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	mov	r9, r2
	b	.L248
.L246:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r9, #1
	add	r2, r6, r8
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	beq	.L387
.L248:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r10
	add	r8, r8, #1
	bge	.L246
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L246
.L406:
	.align	2
.L405:
	.word	.LANCHOR0
.L372:
	rsb	r2, r8, #24
	rsb	r4, r8, #16
	bic	r2, r2, #7
	mov	r0, r5
	rsb	r4, r2, r4
	str	r2, [fp, #-52]
	mov	r1, r2
	bl	BsGet
	ldr	r2, [fp, #-52]
	and	r3, r4, #7
	add	r4, r2, r8
	str	r4, [r5, #32]
	mov	r8, r4
	orr	r0, r9, r0, asl r3
	str	r0, [r5, #28]
	mov	r9, r0
	b	.L208
.L357:
	rsb	r3, r8, #24
	rsb	r7, r8, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r7, r3, r7
	str	r3, [fp, #-56]
	mov	r1, r3
	and	r7, r7, #7
	bl	BsGet
	ldr	r3, [fp, #-56]
	add	r8, r3, r8
	str	r8, [r5, #32]
	orr	r0, r4, r0, asl r7
	str	r0, [r5, #28]
	mov	r4, r0
	b	.L114
.L367:
	rsb	r3, r8, #24
	rsb	r10, r8, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-56]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-56]
	add	r8, r3, r8
	str	r8, [r5, #32]
	orr	r0, r4, r0, asl r10
	str	r0, [r5, #28]
	mov	r4, r0
	b	.L177
.L362:
	rsb	r3, r8, #24
	rsb	r10, r8, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-56]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-56]
	add	r8, r3, r8
	str	r8, [r5, #32]
	orr	r0, r4, r0, asl r10
	str	r0, [r5, #28]
	mov	r4, r0
	b	.L145
.L377:
	rsb	r3, r4, #24
	rsb	r8, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r8, r3, r8
	str	r3, [fp, #-52]
	mov	r1, r3
	and	r8, r8, #7
	bl	BsGet
	ldr	r3, [fp, #-52]
	add	r4, r3, r4
	str	r4, [r5, #32]
	orr	r0, r9, r0, asl r8
	str	r0, [r5, #28]
	mov	r9, r0
	b	.L238
.L378:
	rsb	r3, r4, #24
	rsb	r9, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r9, r3, r9
	str	r3, [fp, #-52]
	mov	r1, r3
	and	r9, r9, #7
	bl	BsGet
	ldr	r3, [fp, #-52]
	add	r4, r3, r4
	str	r4, [r5, #32]
	orr	r0, r8, r0, asl r9
	str	r0, [r5, #28]
	mov	r8, r0
	b	.L240
.L387:
	mov	r10, r7
	ldr	r7, [fp, #-60]
.L249:
	ldrb	r2, [r7, #1]
	add	r10, r6, r10
	sub	ip, r2, #1
	ldrb	r1, [r10, #280]
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L264
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L265
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L265:
	add	r3, r3, #1
.L267:
	strb	r3, [r7, #1]
	b	.L277
.L264:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	ble	.L388
	rsb	r3, r3, #255
	b	.L267
.L383:
	mov	r10, r7
	ldr	r7, [fp, #-60]
.L217:
	ldrb	r2, [r7, #-1]
	add	r10, r6, r10
	sub	ip, r2, #1
	ldrb	r1, [r10, #280]
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L232
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L233
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L233:
	add	r3, r3, #1
.L235:
	strb	r3, [r7, #-1]
	ldr	r9, [r5, #28]
	ldr	r10, [r5, #36]
	ldr	r4, [r5, #32]
	b	.L275
.L232:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	ble	.L389
	rsb	r3, r3, #255
	b	.L235
.L386:
	mov	r10, r9
	ldr	r9, [fp, #-64]
.L123:
	ldrb	r2, [r9]
	add	r10, r6, r10
	sub	ip, r2, #1
	ldrb	r1, [r10, #280]
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L138
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L139
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L139:
	add	r3, r3, #1
.L141:
	strb	r3, [r9]
	ldr	r4, [r5, #28]
	ldr	r3, [r5, #36]
	ldr	r8, [r5, #32]
	b	.L272
.L138:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	ble	.L390
	rsb	r3, r3, #255
	b	.L141
.L384:
	mov	r10, r9
	ldr	r9, [fp, #-64]
.L186:
	ldrb	r2, [r9, #7]
	add	r10, r6, r10
	sub	ip, r2, #1
	ldrb	r1, [r10, #280]
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L201
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L202
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L202:
	add	r3, r3, #1
.L204:
	strb	r3, [r9, #7]
	ldr	r4, [r5, #28]
	ldr	r3, [r5, #36]
	ldr	r8, [r5, #32]
	b	.L274
.L201:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	ble	.L391
	rsb	r3, r3, #255
	b	.L204
.L385:
	mov	r8, r9
	ldr	r9, [fp, #-64]
.L154:
	ldrb	r2, [r9, #6]
	add	r8, r6, r8
	sub	ip, r2, #1
	ldrb	r1, [r8, #280]
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L171
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L172
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L172:
	add	r3, r3, #1
.L174:
	strb	r3, [r9, #6]
	ldr	r4, [r5, #28]
	ldr	r7, [r5, #36]
	ldr	r8, [r5, #32]
	b	.L273
.L171:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	ble	.L392
	rsb	r3, r3, #255
	b	.L174
.L389:
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
	rsb	r3, r3, #255
	b	.L235
.L388:
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
	rsb	r3, r3, #255
	b	.L267
.L391:
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
	rsb	r3, r3, #255
	b	.L204
.L390:
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
	rsb	r3, r3, #255
	b	.L141
.L392:
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
	rsb	r3, r3, #255
	b	.L174
.L224:
	add	r3, r6, r8
	mov	r10, #0
	mov	ip, #4
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	r2, #1
	mov	r3, r4, asl r1
	mov	r8, r8, asl r1
	rsb	r9, r1, r9
	str	r8, [r5, #36]
	mov	r4, r8
	str	r3, [r5, #28]
	str	r9, [r5, #32]
	mov	r10, r3
	mov	r8, ip
	b	.L228
.L226:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r8
	cmp	r1, r0
	sub	r8, r8, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r5, #36]
	movhi	ip, #0
	orr	r7, r7, ip
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r1, r6, r4
	ldrb	r1, [r1, #24]
	mov	r10, r0, asl r1
	rsb	r9, r1, r9
	mov	r4, r4, asl r1
	str	r10, [r5, #28]
	str	r9, [r5, #32]
	str	r4, [r5, #36]
	beq	.L393
.L228:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L226
	rsb	r1, r9, #24
	rsb	ip, r9, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	ip, r1, ip
	str	r2, [fp, #-56]
	str	ip, [fp, #-52]
	add	r9, r1, r9
	bl	BsGet
	ldr	ip, [fp, #-52]
	ldr	r2, [fp, #-56]
	and	ip, ip, #7
	orr	r0, r10, r0, asl ip
	b	.L226
.L161:
	add	r3, r6, r7
	mov	r8, #0
	mov	ip, #4
	str	r9, [fp, #-64]
	ldrb	r1, [r3, #24]
	mov	r9, r8
	mov	r2, #1
	mov	r3, r4, asl r1
	mov	r7, r7, asl r1
	rsb	r10, r1, r10
	str	r7, [r5, #36]
	mov	r4, r7
	str	r3, [r5, #28]
	str	r10, [r5, #32]
	mov	r8, r3
	mov	r7, ip
	b	.L165
.L163:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r7
	cmp	r1, r0
	sub	r7, r7, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r5, #36]
	movhi	ip, #0
	orr	r9, r9, ip
	rsbls	r4, r4, lr
	cmn	r7, #1
	add	r1, r6, r4
	ldrb	r1, [r1, #24]
	mov	r8, r0, asl r1
	rsb	r10, r1, r10
	mov	r4, r4, asl r1
	str	r8, [r5, #28]
	str	r10, [r5, #32]
	str	r4, [r5, #36]
	beq	.L394
.L165:
	sub	r4, r4, #1
	cmp	r10, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r8
	add	r4, r4, #1
	bge	.L163
	rsb	r1, r10, #24
	rsb	ip, r10, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	ip, r1, ip
	str	r2, [fp, #-60]
	str	ip, [fp, #-56]
	add	r10, r1, r10
	bl	BsGet
	ldr	ip, [fp, #-56]
	ldr	r2, [fp, #-60]
	and	ip, ip, #7
	orr	r0, r8, r0, asl ip
	b	.L163
.L130:
	add	r3, r6, r7
	mov	r10, #0
	mov	ip, #4
	str	r9, [fp, #-64]
	ldrb	r1, [r3, #24]
	mov	r9, r10
	mov	r2, #1
	mov	r3, r4, asl r1
	mov	r7, r7, asl r1
	rsb	r8, r1, r8
	str	r7, [r5, #36]
	mov	r4, r7
	str	r3, [r5, #28]
	str	r8, [r5, #32]
	mov	r10, r3
	mov	r7, ip
	b	.L134
.L132:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r7
	cmp	r1, r0
	sub	r7, r7, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r5, #36]
	movhi	ip, #0
	orr	r9, r9, ip
	rsbls	r4, r4, lr
	cmn	r7, #1
	add	r1, r6, r4
	ldrb	r1, [r1, #24]
	mov	r10, r0, asl r1
	rsb	r8, r1, r8
	mov	r4, r4, asl r1
	str	r10, [r5, #28]
	str	r8, [r5, #32]
	str	r4, [r5, #36]
	beq	.L395
.L134:
	sub	r4, r4, #1
	cmp	r8, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L132
	rsb	r1, r8, #24
	rsb	ip, r8, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	ip, r1, ip
	str	r2, [fp, #-60]
	str	ip, [fp, #-56]
	add	r8, r1, r8
	bl	BsGet
	ldr	ip, [fp, #-56]
	ldr	r2, [fp, #-60]
	and	ip, ip, #7
	orr	r0, r10, r0, asl ip
	b	.L132
.L193:
	add	r3, r6, r7
	mov	r10, #0
	mov	ip, #4
	str	r9, [fp, #-64]
	ldrb	r1, [r3, #24]
	mov	r9, r10
	mov	r2, #1
	mov	r3, r4, asl r1
	mov	r7, r7, asl r1
	rsb	r8, r1, r8
	str	r7, [r5, #36]
	mov	r4, r7
	str	r3, [r5, #28]
	str	r8, [r5, #32]
	mov	r10, r3
	mov	r7, ip
	b	.L197
.L195:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r7
	cmp	r1, r0
	sub	r7, r7, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r5, #36]
	movhi	ip, #0
	orr	r9, r9, ip
	rsbls	r4, r4, lr
	cmn	r7, #1
	add	r1, r6, r4
	ldrb	r1, [r1, #24]
	mov	r10, r0, asl r1
	rsb	r8, r1, r8
	mov	r4, r4, asl r1
	str	r10, [r5, #28]
	str	r8, [r5, #32]
	str	r4, [r5, #36]
	beq	.L396
.L197:
	sub	r4, r4, #1
	cmp	r8, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L195
	rsb	r1, r8, #24
	rsb	ip, r8, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	ip, r1, ip
	str	r2, [fp, #-60]
	str	ip, [fp, #-56]
	add	r8, r1, r8
	bl	BsGet
	ldr	ip, [fp, #-56]
	ldr	r2, [fp, #-60]
	and	ip, ip, #7
	orr	r0, r10, r0, asl ip
	b	.L195
.L256:
	add	r3, r6, r8
	mov	r10, #0
	mov	ip, #4
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	r2, #1
	mov	r3, r4, asl r1
	mov	r8, r8, asl r1
	rsb	r9, r1, r9
	str	r8, [r5, #36]
	mov	r4, r8
	str	r3, [r5, #28]
	str	r9, [r5, #32]
	mov	r10, r3
	mov	r8, ip
	b	.L260
.L258:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r8
	cmp	r1, r0
	sub	r8, r8, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r5, #36]
	movhi	ip, #0
	orr	r7, r7, ip
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r1, r6, r4
	ldrb	r1, [r1, #24]
	mov	r10, r0, asl r1
	rsb	r9, r1, r9
	mov	r4, r4, asl r1
	str	r10, [r5, #28]
	str	r9, [r5, #32]
	str	r4, [r5, #36]
	beq	.L397
.L260:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L258
	rsb	r1, r9, #24
	rsb	ip, r9, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	ip, r1, ip
	str	r2, [fp, #-56]
	str	ip, [fp, #-52]
	add	r9, r1, r9
	bl	BsGet
	ldr	ip, [fp, #-52]
	ldr	r2, [fp, #-56]
	and	ip, ip, #7
	orr	r0, r10, r0, asl ip
	b	.L258
.L187:
	add	r3, r6, r7
	mov	r10, #0
	mov	r2, #3
	str	r9, [fp, #-64]
	ldrb	r1, [r3, #24]
	mov	r9, r10
	mov	ip, #1
	mov	r8, r8, asl r1
	rsb	r4, r1, r4
	str	r8, [r5, #28]
	mov	r7, r7, asl r1
	mov	r10, r8
	str	r4, [r5, #32]
	str	r7, [r5, #36]
	mov	r8, r2
	b	.L192
.L190:
	mov	r2, r7, asl #24
	mov	r1, ip, asl r8
	cmp	r2, r0
	sub	r8, r8, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r9, r9, r1
	rsbls	r7, r7, lr
	cmn	r8, #1
	add	r2, r6, r7
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r7, r7, asl r2
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r7, [r5, #36]
	beq	.L398
.L192:
	sub	r7, r7, #1
	cmp	r4, #0
	ubfx	r7, r7, #1, #24
	mov	r0, r10
	add	r7, r7, #1
	bge	.L190
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-60]
	str	r2, [fp, #-56]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-56]
	ldr	ip, [fp, #-60]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L190
.L124:
	add	r3, r6, r7
	mov	r10, #0
	mov	r2, #3
	str	r9, [fp, #-64]
	ldrb	r1, [r3, #24]
	mov	r9, r10
	mov	ip, #1
	mov	r8, r8, asl r1
	rsb	r4, r1, r4
	str	r8, [r5, #28]
	mov	r7, r7, asl r1
	mov	r10, r8
	str	r4, [r5, #32]
	str	r7, [r5, #36]
	mov	r8, r2
	b	.L129
.L127:
	mov	r2, r7, asl #24
	mov	r1, ip, asl r8
	cmp	r2, r0
	sub	r8, r8, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r9, r9, r1
	rsbls	r7, r7, lr
	cmn	r8, #1
	add	r2, r6, r7
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r7, r7, asl r2
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r7, [r5, #36]
	beq	.L399
.L129:
	sub	r7, r7, #1
	cmp	r4, #0
	ubfx	r7, r7, #1, #24
	mov	r0, r10
	add	r7, r7, #1
	bge	.L127
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-60]
	str	r2, [fp, #-56]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-56]
	ldr	ip, [fp, #-60]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L127
.L155:
	add	r3, r6, r7
	mov	r8, #0
	mov	r2, #3
	str	r9, [fp, #-64]
	ldrb	r1, [r3, #24]
	mov	r9, r8
	mov	ip, #1
	mov	r10, r10, asl r1
	rsb	r4, r1, r4
	str	r10, [r5, #28]
	mov	r7, r7, asl r1
	mov	r8, r10
	str	r4, [r5, #32]
	str	r7, [r5, #36]
	mov	r10, r2
	b	.L160
.L158:
	mov	r2, r7, asl #24
	mov	r1, ip, asl r10
	cmp	r2, r0
	sub	r10, r10, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r9, r9, r1
	rsbls	r7, r7, lr
	cmn	r10, #1
	add	r2, r6, r7
	ldrb	r2, [r2, #24]
	mov	r8, r0, asl r2
	rsb	r4, r2, r4
	mov	r7, r7, asl r2
	str	r8, [r5, #28]
	str	r4, [r5, #32]
	str	r7, [r5, #36]
	beq	.L400
.L160:
	sub	r7, r7, #1
	cmp	r4, #0
	ubfx	r7, r7, #1, #24
	mov	r0, r8
	add	r7, r7, #1
	bge	.L158
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-60]
	str	r2, [fp, #-56]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-56]
	ldr	ip, [fp, #-60]
	and	r2, r2, #7
	orr	r0, r8, r0, asl r2
	b	.L158
.L218:
	add	r3, r6, r8
	mov	r10, #0
	mov	r2, #3
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r5, #28]
	mov	r8, r8, asl r1
	mov	r10, r9
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	mov	r9, r2
	b	.L223
.L221:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r9, #1
	add	r2, r6, r8
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	beq	.L401
.L223:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r10
	add	r8, r8, #1
	bge	.L221
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L221
.L250:
	add	r3, r6, r8
	mov	r10, #0
	mov	r2, #3
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r5, #28]
	mov	r8, r8, asl r1
	mov	r10, r9
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	mov	r9, r2
	b	.L255
.L253:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r9, #1
	add	r2, r6, r8
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	beq	.L402
.L255:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r10
	add	r8, r8, #1
	bge	.L253
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L253
.L402:
	mov	r10, r7
	ldr	r7, [fp, #-60]
	add	r10, r10, #16
	b	.L249
.L398:
	mov	r10, r9
	ldr	r9, [fp, #-64]
	add	r10, r10, #16
	b	.L186
.L401:
	mov	r10, r7
	ldr	r7, [fp, #-60]
	add	r10, r10, #16
	b	.L217
.L400:
	mov	r8, r9
	ldr	r9, [fp, #-64]
	add	r8, r8, #16
	b	.L154
.L399:
	mov	r10, r9
	ldr	r9, [fp, #-64]
	add	r10, r10, #16
	b	.L123
.L371:
	mov	r10, r9
	cmp	r10, #64
	ldr	r9, [fp, #-64]
	ble	.L200
	mov	r1, #128
	mov	r0, r5
	bl	Vp9_Cabac_Read
	add	r0, r0, r10, lsl #1
	sub	r10, r0, #65
.L200:
	add	r10, r10, #64
	b	.L186
.L382:
	mov	r10, r7
	cmp	r10, #64
	ldr	r7, [fp, #-60]
	ble	.L263
	mov	r1, #128
	mov	r0, r5
	bl	Vp9_Cabac_Read
	add	r0, r0, r10, lsl #1
	sub	r10, r0, #65
.L263:
	add	r10, r10, #64
	b	.L249
.L361:
	mov	r10, r9
	cmp	r10, #64
	ldr	r9, [fp, #-64]
	ble	.L137
	mov	r1, #128
	mov	r0, r5
	bl	Vp9_Cabac_Read
	add	r0, r0, r10, lsl #1
	sub	r10, r0, #65
.L137:
	add	r10, r10, #64
	b	.L123
.L366:
	mov	r2, r8
	mov	r8, r9
	cmp	r8, #64
	ldr	r9, [fp, #-64]
	bgt	.L403
.L168:
	add	r8, r8, #64
	b	.L154
.L376:
	mov	r10, r7
	cmp	r10, #64
	ldr	r7, [fp, #-60]
	ble	.L231
	mov	r1, #128
	mov	r0, r5
	bl	Vp9_Cabac_Read
	add	r0, r0, r10, lsl #1
	sub	r10, r0, #65
.L231:
	add	r10, r10, #64
	b	.L217
.L393:
	mov	r10, r7
	ldr	r7, [fp, #-60]
	add	r10, r10, #32
	b	.L217
.L397:
	mov	r10, r7
	ldr	r7, [fp, #-60]
	add	r10, r10, #32
	b	.L249
.L395:
	mov	r10, r9
	ldr	r9, [fp, #-64]
	add	r10, r10, #32
	b	.L123
.L394:
	mov	r8, r9
	ldr	r9, [fp, #-64]
	add	r8, r8, #32
	b	.L154
.L396:
	mov	r10, r9
	ldr	r9, [fp, #-64]
	add	r10, r10, #32
	b	.L186
.L373:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-52]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-52]
	add	r4, r4, r3
	str	r4, [r5, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r5, #28]
	mov	r9, r0
	b	.L210
.L368:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-56]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-56]
	add	r4, r4, r3
	str	r4, [r5, #32]
	orr	r0, r8, r0, asl r10
	str	r0, [r5, #28]
	mov	r8, r0
	b	.L179
.L379:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-52]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-52]
	add	r4, r4, r3
	str	r4, [r5, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r5, #28]
	mov	r9, r0
	b	.L242
.L363:
	rsb	r3, r4, #24
	rsb	r8, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r8, r3, r8
	str	r3, [fp, #-56]
	mov	r1, r3
	bl	BsGet
	and	r2, r8, #7
	ldr	r3, [fp, #-56]
	add	r4, r4, r3
	str	r4, [r5, #32]
	orr	r0, r10, r0, asl r2
	str	r0, [r5, #28]
	mov	r10, r0
	b	.L147
.L358:
	rsb	r3, r8, #24
	rsb	r10, r8, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-56]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-56]
	add	r8, r8, r3
	str	r8, [r5, #32]
	orr	r0, r7, r0, asl r10
	str	r0, [r5, #28]
	mov	r7, r0
	b	.L116
.L403:
	sub	r4, r4, #1
	cmp	r10, #0
	ubfx	r4, r4, #1, #24
	mov	r8, r8, asl #1
	add	r4, r4, #1
	sub	r8, r8, #65
	movge	r0, r2
	blt	.L404
.L169:
	mov	r3, r4, asl #24
	cmp	r3, r0
	rsbls	r0, r3, r0
	ldrls	r2, [r5, #36]
	movls	r1, #1
	movhi	r1, #0
	add	r8, r8, r1
	rsbls	r4, r4, r2
	add	r3, r6, r4
	ldrb	r3, [r3, #24]
	mov	r2, r0, asl r3
	rsb	r10, r3, r10
	mov	r4, r4, asl r3
	str	r2, [r5, #28]
	str	r10, [r5, #32]
	str	r4, [r5, #36]
	b	.L168
.L360:
	rsb	r2, r8, #24
	rsb	r10, r8, #16
	bic	r2, r2, #7
	mov	r0, r5
	rsb	r10, r2, r10
	str	r2, [fp, #-56]
	mov	r1, r2
	bl	BsGet
	and	r3, r10, #7
	ldr	r2, [fp, #-56]
	add	r8, r8, r2
	str	r8, [r5, #32]
	orr	r0, r4, r0, asl r3
	str	r0, [r5, #28]
	mov	r4, r0
	b	.L126
.L381:
	rsb	r2, r9, #24
	rsb	r10, r9, #16
	bic	r2, r2, #7
	mov	r0, r5
	rsb	r10, r2, r10
	str	r2, [fp, #-52]
	mov	r1, r2
	bl	BsGet
	and	r3, r10, #7
	ldr	r2, [fp, #-52]
	add	r9, r9, r2
	str	r9, [r5, #32]
	orr	r0, r4, r0, asl r3
	str	r0, [r5, #28]
	mov	r4, r0
	b	.L252
.L375:
	rsb	r2, r9, #24
	rsb	r10, r9, #16
	bic	r2, r2, #7
	mov	r0, r5
	rsb	r10, r2, r10
	str	r2, [fp, #-52]
	mov	r1, r2
	bl	BsGet
	and	r3, r10, #7
	ldr	r2, [fp, #-52]
	add	r9, r9, r2
	str	r9, [r5, #32]
	orr	r0, r4, r0, asl r3
	str	r0, [r5, #28]
	mov	r4, r0
	b	.L220
.L365:
	rsb	r2, r10, #24
	rsb	r8, r10, #16
	bic	r2, r2, #7
	mov	r0, r5
	rsb	r8, r2, r8
	str	r2, [fp, #-56]
	mov	r1, r2
	bl	BsGet
	and	r3, r8, #7
	ldr	r2, [fp, #-56]
	add	r10, r10, r2
	str	r10, [r5, #32]
	orr	r0, r4, r0, asl r3
	str	r0, [r5, #28]
	mov	r4, r0
	b	.L157
.L370:
	rsb	r2, r8, #24
	rsb	r10, r8, #16
	bic	r2, r2, #7
	mov	r0, r5
	rsb	r10, r2, r10
	str	r2, [fp, #-56]
	mov	r1, r2
	bl	BsGet
	and	r3, r10, #7
	ldr	r2, [fp, #-56]
	add	r8, r8, r2
	str	r8, [r5, #32]
	orr	r0, r4, r0, asl r3
	str	r0, [r5, #28]
	mov	r4, r0
	b	.L189
.L404:
	rsb	r1, r10, #24
	rsb	r7, r10, #16
	bic	r1, r1, #7
	mov	r0, r5
	str	r2, [fp, #-56]
	rsb	r7, r1, r7
	add	r10, r1, r10
	bl	BsGet
	ldr	r2, [fp, #-56]
	and	r7, r7, #7
	orr	r0, r2, r0, asl r7
	b	.L169
.L374:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-52]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-52]
	add	r4, r4, r3
	str	r4, [r5, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r5, #28]
	mov	r9, r0
	b	.L213
.L364:
	rsb	r2, r4, #24
	rsb	r8, r4, #16
	bic	r2, r2, #7
	mov	r0, r5
	rsb	r8, r2, r8
	str	r2, [fp, #-56]
	mov	r1, r2
	bl	BsGet
	and	r3, r8, #7
	ldr	r2, [fp, #-56]
	add	r4, r4, r2
	str	r4, [r5, #32]
	orr	r0, r10, r0, asl r3
	str	r0, [r5, #28]
	mov	r10, r0
	b	.L150
.L369:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-56]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-56]
	add	r4, r4, r3
	str	r4, [r5, #32]
	orr	r0, r8, r0, asl r10
	str	r0, [r5, #28]
	mov	r8, r0
	b	.L182
.L380:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-52]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-52]
	add	r4, r4, r3
	str	r4, [r5, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r5, #28]
	mov	r9, r0
	b	.L245
.L359:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-56]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-56]
	add	r4, r4, r3
	str	r4, [r5, #32]
	orr	r0, r8, r0, asl r10
	str	r0, [r5, #28]
	mov	r8, r0
	b	.L119
	.fnend
	.size	Vp9_ReadTxProbs, .-Vp9_ReadTxProbs
	.align	2
	.global	Vp9_ReadCoefProbsCommon
	.type	Vp9_ReadCoefProbsCommon, %function
Vp9_ReadCoefProbsCommon:
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
	ldr	r4, [r1, #36]
	mov	r6, r1
	ldr	ip, [r1, #32]
	mov	r7, r0
	sub	r4, r4, #1
	cmp	ip, #0
	ubfx	r4, r4, #1, #24
	add	r4, r4, #1
	blt	.L408
	ldr	r3, [r1, #28]
.L409:
	mov	r1, r4, asl #24
	cmp	r1, r3
	bhi	.L410
	ldr	r2, [r6, #36]
	rsb	r3, r1, r3
	ldr	r5, .L602
	add	r1, r7, #648
	rsb	r4, r4, r2
	add	r2, r1, #2
	str	r2, [fp, #-80]
	add	r2, r5, r4
	mov	r10, r6
	add	r1, r7, #218
	ldrb	r2, [r2, #24]
	str	r1, [fp, #-76]
	mov	r3, r3, asl r2
	rsb	r1, r2, ip
	mov	r4, r4, asl r2
	str	r3, [r6, #28]
	str	r1, [r6, #32]
	str	r4, [r6, #36]
.L411:
	ldr	r3, [fp, #-76]
	mov	r6, r10
	sub	r3, r3, #216
	str	r3, [fp, #-72]
.L516:
	ldr	r3, [fp, #-72]
	str	r3, [fp, #-56]
	mov	r3, #0
	str	r3, [fp, #-52]
.L514:
	ldr	r7, [fp, #-56]
	mov	r3, #0
	str	r3, [fp, #-48]
.L512:
	ldr	r3, [fp, #-52]
	ldr	r2, [fp, #-48]
	cmp	r3, #0
	moveq	r3, #3
	movne	r3, #6
	cmp	r2, r3
	bge	.L572
	ldr	r8, [r6, #36]
	ldr	r4, [r6, #32]
	sub	r8, r8, #1
	cmp	r4, #0
	mov	r3, r8, asl #8
	sub	r8, r3, r8, asl #2
	mov	r8, r8, lsr #8
	add	r8, r8, #1
	blt	.L412
	ldr	r10, [r6, #28]
.L413:
	mov	r9, r8, asl #24
	cmp	r9, r10
	bhi	.L414
	ldr	r3, [r6, #36]
	rsb	r10, r9, r10
	rsb	r8, r8, r3
	add	r3, r5, r8
	ldrb	r9, [r3, #24]
	mov	r3, r8, asl r9
	rsb	r4, r9, r4
	sub	r8, r3, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r10, r10, asl r9
	str	r3, [r6, #36]
	add	r8, r8, #1
	str	r4, [r6, #32]
	str	r10, [r6, #28]
	blt	.L573
.L415:
	mov	r9, r8, asl #24
	cmp	r9, r10
	bhi	.L416
	ldr	r2, [r6, #36]
	rsb	r9, r9, r10
	rsb	r8, r8, r2
	add	r3, r5, r8
	ldrb	r0, [r3, #24]
	mov	r2, r8, asl r0
	rsb	r4, r0, r4
	sub	r8, r2, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r9, r9, asl r0
	str	r2, [r6, #36]
	add	r8, r8, #1
	str	r4, [r6, #32]
	str	r9, [r6, #28]
	blt	.L574
.L418:
	mov	r3, r8, asl #24
	cmp	r3, r9
	bhi	.L423
	ldr	r1, [r6, #36]
	rsb	r3, r3, r9
	rsb	r8, r8, r1
	add	r2, r5, r8
	ldrb	r2, [r2, #24]
	rsb	r9, r2, r4
	mov	r1, r8, asl r2
	sub	r8, r1, #1
	cmp	r9, #0
	ubfx	r8, r8, #1, #24
	mov	r4, r3, asl r2
	str	r1, [r6, #36]
	add	r8, r8, #1
	str	r9, [r6, #32]
	str	r4, [r6, #28]
	blt	.L575
.L425:
	mov	r2, r8, asl #24
	cmp	r2, r4
	bhi	.L429
	ldr	r1, [r6, #36]
	rsb	r2, r2, r4
	mov	r10, #0
	mov	r3, #6
	rsb	r8, r8, r1
	str	r7, [fp, #-68]
	add	r1, r5, r8
	mov	r7, r10
	mov	ip, #1
	ldrb	r4, [r1, #24]
	mov	r2, r2, asl r4
	rsb	r9, r4, r9
	str	r2, [r6, #28]
	mov	r4, r8, asl r4
	str	r9, [r6, #32]
	mov	r8, r3
	str	r4, [r6, #36]
	mov	r10, r2
	b	.L430
.L434:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r8
	cmp	r2, r0
	sub	r8, r8, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r2, r5, r4
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r9, r2, r9
	mov	r4, r4, asl r2
	str	r10, [r6, #28]
	str	r9, [r6, #32]
	str	r4, [r6, #36]
	beq	.L576
.L430:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L434
	rsb	r1, r9, #24
	rsb	r2, r9, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-64]
	str	r2, [fp, #-60]
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-60]
	ldr	ip, [fp, #-64]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L434
.L414:
	add	r3, r5, r8
	ldrb	r3, [r3, #24]
	mov	r10, r10, asl r3
	rsb	r4, r3, r4
	mov	r8, r8, asl r3
	str	r10, [r6, #28]
	str	r4, [r6, #32]
	str	r8, [r6, #36]
.L517:
	sub	r8, r8, #1
	cmp	r4, #0
	mov	r3, r8, asl #8
	sub	r8, r3, r8, asl #2
	mov	r8, r8, lsr #8
	add	r8, r8, #1
	blt	.L577
.L445:
	mov	r9, r8, asl #24
	cmp	r9, r10
	bhi	.L446
	ldr	r3, [r6, #36]
	rsb	r10, r9, r10
	rsb	r8, r8, r3
	add	r3, r5, r8
	ldrb	r9, [r3, #24]
	mov	r3, r8, asl r9
	rsb	r4, r9, r4
	sub	r8, r3, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r10, r10, asl r9
	str	r3, [r6, #36]
	add	r8, r8, #1
	str	r4, [r6, #32]
	str	r10, [r6, #28]
	blt	.L578
.L447:
	mov	r9, r8, asl #24
	cmp	r9, r10
	bhi	.L448
	ldr	r2, [r6, #36]
	rsb	r9, r9, r10
	rsb	r8, r8, r2
	add	r3, r5, r8
	ldrb	r0, [r3, #24]
	mov	r2, r8, asl r0
	rsb	r4, r0, r4
	sub	r8, r2, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r9, r9, asl r0
	str	r2, [r6, #36]
	add	r8, r8, #1
	str	r4, [r6, #32]
	str	r9, [r6, #28]
	blt	.L579
.L450:
	mov	r3, r8, asl #24
	cmp	r3, r9
	bhi	.L455
	ldr	r1, [r6, #36]
	rsb	r3, r3, r9
	rsb	r8, r8, r1
	add	r2, r5, r8
	ldrb	r2, [r2, #24]
	rsb	r9, r2, r4
	mov	r1, r8, asl r2
	sub	r8, r1, #1
	cmp	r9, #0
	ubfx	r8, r8, #1, #24
	mov	r4, r3, asl r2
	str	r1, [r6, #36]
	add	r8, r8, #1
	str	r9, [r6, #32]
	str	r4, [r6, #28]
	blt	.L580
.L457:
	mov	r2, r8, asl #24
	cmp	r2, r4
	bhi	.L461
	ldr	r1, [r6, #36]
	rsb	r2, r2, r4
	mov	r10, #0
	mov	r3, #6
	rsb	r8, r8, r1
	str	r7, [fp, #-68]
	add	r1, r5, r8
	mov	r7, r10
	mov	ip, #1
	ldrb	r4, [r1, #24]
	mov	r2, r2, asl r4
	rsb	r9, r4, r9
	str	r2, [r6, #28]
	mov	r4, r8, asl r4
	str	r9, [r6, #32]
	mov	r8, r3
	str	r4, [r6, #36]
	mov	r10, r2
	b	.L462
.L466:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r8
	cmp	r2, r0
	sub	r8, r8, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r2, r5, r4
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r9, r2, r9
	mov	r4, r4, asl r2
	str	r10, [r6, #28]
	str	r9, [r6, #32]
	str	r4, [r6, #36]
	beq	.L581
.L462:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L466
	rsb	r1, r9, #24
	rsb	r2, r9, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-64]
	str	r2, [fp, #-60]
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-60]
	ldr	ip, [fp, #-64]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L466
.L446:
	add	r3, r5, r8
	ldrb	r3, [r3, #24]
	mov	r10, r10, asl r3
	rsb	r4, r3, r4
	mov	r8, r8, asl r3
	str	r10, [r6, #28]
	str	r4, [r6, #32]
	str	r8, [r6, #36]
.L518:
	sub	r8, r8, #1
	cmp	r4, #0
	mov	r3, r8, asl #8
	sub	r8, r3, r8, asl #2
	mov	r8, r8, lsr #8
	add	r8, r8, #1
	blt	.L582
.L477:
	mov	r9, r8, asl #24
	cmp	r9, r10
	bhi	.L478
	ldr	r3, [r6, #36]
	rsb	r10, r9, r10
	rsb	r8, r8, r3
	add	r3, r5, r8
	ldrb	r9, [r3, #24]
	mov	r3, r8, asl r9
	rsb	r4, r9, r4
	sub	r8, r3, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r10, r10, asl r9
	str	r3, [r6, #36]
	add	r8, r8, #1
	str	r4, [r6, #32]
	str	r10, [r6, #28]
	blt	.L583
.L479:
	mov	r9, r8, asl #24
	cmp	r9, r10
	bhi	.L480
	ldr	r2, [r6, #36]
	rsb	r9, r9, r10
	rsb	r8, r8, r2
	add	r3, r5, r8
	ldrb	r0, [r3, #24]
	mov	r2, r8, asl r0
	rsb	r4, r0, r4
	sub	r8, r2, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r9, r9, asl r0
	str	r2, [r6, #36]
	add	r8, r8, #1
	str	r4, [r6, #32]
	str	r9, [r6, #28]
	blt	.L584
.L482:
	mov	r3, r8, asl #24
	cmp	r3, r9
	bhi	.L487
	ldr	r1, [r6, #36]
	rsb	r3, r3, r9
	rsb	r8, r8, r1
	add	r2, r5, r8
	ldrb	r2, [r2, #24]
	rsb	r9, r2, r4
	mov	r1, r8, asl r2
	sub	r8, r1, #1
	cmp	r9, #0
	ubfx	r8, r8, #1, #24
	mov	r4, r3, asl r2
	str	r1, [r6, #36]
	add	r8, r8, #1
	str	r9, [r6, #32]
	str	r4, [r6, #28]
	blt	.L585
.L489:
	mov	r2, r8, asl #24
	cmp	r2, r4
	bhi	.L493
	ldr	r1, [r6, #36]
	rsb	r2, r2, r4
	mov	r10, #0
	mov	r3, #6
	rsb	r8, r8, r1
	str	r7, [fp, #-68]
	add	r1, r5, r8
	mov	r7, r10
	mov	ip, #1
	ldrb	r4, [r1, #24]
	mov	r2, r2, asl r4
	rsb	r9, r4, r9
	str	r2, [r6, #28]
	mov	r4, r8, asl r4
	str	r9, [r6, #32]
	mov	r8, r3
	str	r4, [r6, #36]
	mov	r10, r2
	b	.L494
.L498:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r8
	cmp	r2, r0
	sub	r8, r8, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r2, r5, r4
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r9, r2, r9
	mov	r4, r4, asl r2
	str	r10, [r6, #28]
	str	r9, [r6, #32]
	str	r4, [r6, #36]
	beq	.L586
.L494:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L498
	rsb	r1, r9, #24
	rsb	r2, r9, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-64]
	str	r2, [fp, #-60]
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-60]
	ldr	ip, [fp, #-64]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L498
.L478:
	add	r3, r5, r8
	ldrb	r3, [r3, #24]
	mov	r10, r10, asl r3
	rsb	r4, r3, r4
	mov	r8, r8, asl r3
	str	r10, [r6, #28]
	str	r4, [r6, #32]
	str	r8, [r6, #36]
.L519:
	ldr	r3, [fp, #-48]
	add	r7, r7, #3
	add	r3, r3, #1
	str	r3, [fp, #-48]
	b	.L512
.L582:
	rsb	r3, r4, #24
	rsb	r9, r4, #16
	bic	r3, r3, #7
	mov	r0, r6
	rsb	r9, r3, r9
	str	r3, [fp, #-60]
	mov	r1, r3
	bl	BsGet
	and	r2, r9, #7
	ldr	r3, [fp, #-60]
	add	r4, r3, r4
	str	r4, [r6, #32]
	orr	r0, r10, r0, asl r2
	str	r0, [r6, #28]
	mov	r10, r0
	b	.L477
.L577:
	rsb	r3, r4, #24
	rsb	r9, r4, #16
	bic	r3, r3, #7
	mov	r0, r6
	rsb	r9, r3, r9
	str	r3, [fp, #-60]
	mov	r1, r3
	bl	BsGet
	and	r2, r9, #7
	ldr	r3, [fp, #-60]
	add	r4, r3, r4
	str	r4, [r6, #32]
	orr	r0, r10, r0, asl r2
	str	r0, [r6, #28]
	mov	r10, r0
	b	.L445
.L412:
	rsb	r9, r4, #24
	rsb	r3, r4, #16
	bic	r9, r9, #7
	mov	r0, r6
	rsb	r3, r9, r3
	ldr	r10, [r6, #28]
	mov	r1, r9
	str	r3, [fp, #-60]
	bl	BsGet
	ldr	r3, [fp, #-60]
	add	r4, r4, r9
	str	r4, [r6, #32]
	and	r3, r3, #7
	orr	r0, r10, r0, asl r3
	str	r0, [r6, #28]
	mov	r10, r0
	b	.L413
.L480:
	add	r1, r5, r8
	mov	r3, #0
	mov	r2, #3
	str	r7, [fp, #-68]
	ldrb	r1, [r1, #24]
	mov	ip, #1
	mov	r7, r3
	mov	r9, r10, asl r1
	rsb	r4, r1, r4
	mov	r8, r8, asl r1
	str	r9, [r6, #28]
	str	r4, [r6, #32]
	mov	r10, r2
	str	r8, [r6, #36]
	b	.L485
.L483:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r10
	cmp	r2, r0
	sub	r10, r10, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r10, #1
	add	r2, r5, r8
	ldrb	r2, [r2, #24]
	mov	r9, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r9, [r6, #28]
	str	r4, [r6, #32]
	str	r8, [r6, #36]
	beq	.L587
.L485:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r9
	add	r8, r8, #1
	bge	.L483
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-64]
	str	r2, [fp, #-60]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-60]
	ldr	ip, [fp, #-64]
	and	r2, r2, #7
	orr	r0, r9, r0, asl r2
	b	.L483
.L448:
	add	r1, r5, r8
	mov	r3, #0
	mov	r2, #3
	str	r7, [fp, #-68]
	ldrb	r1, [r1, #24]
	mov	ip, #1
	mov	r7, r3
	mov	r9, r10, asl r1
	rsb	r4, r1, r4
	mov	r8, r8, asl r1
	str	r9, [r6, #28]
	str	r4, [r6, #32]
	mov	r10, r2
	str	r8, [r6, #36]
	b	.L453
.L451:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r10
	cmp	r2, r0
	sub	r10, r10, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r10, #1
	add	r2, r5, r8
	ldrb	r2, [r2, #24]
	mov	r9, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r9, [r6, #28]
	str	r4, [r6, #32]
	str	r8, [r6, #36]
	beq	.L588
.L453:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r9
	add	r8, r8, #1
	bge	.L451
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-64]
	str	r2, [fp, #-60]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-60]
	ldr	ip, [fp, #-64]
	and	r2, r2, #7
	orr	r0, r9, r0, asl r2
	b	.L451
.L416:
	add	r1, r5, r8
	mov	r3, #0
	mov	r2, #3
	str	r7, [fp, #-68]
	ldrb	r1, [r1, #24]
	mov	ip, #1
	mov	r7, r3
	mov	r9, r10, asl r1
	rsb	r4, r1, r4
	mov	r8, r8, asl r1
	str	r9, [r6, #28]
	str	r4, [r6, #32]
	mov	r10, r2
	str	r8, [r6, #36]
	b	.L421
.L419:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r10
	cmp	r2, r0
	sub	r10, r10, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r10, #1
	add	r2, r5, r8
	ldrb	r2, [r2, #24]
	mov	r9, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r9, [r6, #28]
	str	r4, [r6, #32]
	str	r8, [r6, #36]
	beq	.L589
.L421:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r9
	add	r8, r8, #1
	bge	.L419
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-64]
	str	r2, [fp, #-60]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-60]
	ldr	ip, [fp, #-64]
	and	r2, r2, #7
	orr	r0, r9, r0, asl r2
	b	.L419
.L589:
	mov	r3, r7
	ldr	r7, [fp, #-68]
.L422:
	ldrb	r2, [r7, #-2]
	add	r10, r5, r3
	sub	ip, r2, #1
	ldrb	r1, [r10, #280]
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L439
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L440
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L440:
	add	r3, r3, #1
.L442:
	strb	r3, [r7, #-2]
	ldr	r8, [r6, #36]
	ldr	r4, [r6, #32]
	ldr	r10, [r6, #28]
	b	.L517
.L439:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	bgt	.L443
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
.L443:
	rsb	r3, r3, #255
	b	.L442
.L588:
	mov	r3, r7
	ldr	r7, [fp, #-68]
.L454:
	ldrb	r2, [r7, #-1]
	add	r10, r5, r3
	sub	ip, r2, #1
	ldrb	r1, [r10, #280]
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L471
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L472
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L472:
	add	r3, r3, #1
.L474:
	strb	r3, [r7, #-1]
	ldr	r8, [r6, #36]
	ldr	r4, [r6, #32]
	ldr	r10, [r6, #28]
	b	.L518
.L471:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	bgt	.L475
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
.L475:
	rsb	r3, r3, #255
	b	.L474
.L587:
	mov	r3, r7
	ldr	r7, [fp, #-68]
.L486:
	ldrb	r2, [r7]
	add	r10, r5, r3
	sub	ip, r2, #1
	ldrb	r1, [r10, #280]
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L503
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L504
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L504:
	add	r3, r3, #1
.L506:
	strb	r3, [r7]
	b	.L519
.L503:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	bgt	.L507
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
.L507:
	rsb	r3, r3, #255
	b	.L506
.L572:
	ldr	r3, [fp, #-52]
	ldr	r2, [fp, #-56]
	add	r3, r3, #1
	str	r3, [fp, #-52]
	cmp	r3, #6
	add	r2, r2, #18
	str	r2, [fp, #-56]
	bne	.L514
	ldr	r3, [fp, #-72]
	ldr	r2, [fp, #-76]
	add	r3, r3, #108
	str	r3, [fp, #-72]
	cmp	r2, r3
	bne	.L516
	ldr	r3, [fp, #-76]
	mov	r10, r6
	ldr	r2, [fp, #-80]
	add	r3, r3, #216
	str	r3, [fp, #-76]
	cmp	r3, r2
	bne	.L411
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L455:
	add	r3, r5, r8
	mov	r10, #0
	mov	r2, #3
	str	r7, [fp, #-68]
	ldrb	r3, [r3, #24]
	mov	r7, r10
	mov	ip, #1
	mov	r9, r9, asl r3
	rsb	r4, r3, r4
	str	r9, [r6, #28]
	mov	r8, r8, asl r3
	mov	r10, r9
	str	r4, [r6, #32]
	str	r8, [r6, #36]
	mov	r9, r2
	b	.L460
.L458:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r9, #1
	add	r2, r5, r8
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r10, [r6, #28]
	str	r4, [r6, #32]
	str	r8, [r6, #36]
	beq	.L590
.L460:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r10
	add	r8, r8, #1
	bge	.L458
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-64]
	str	r2, [fp, #-60]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-60]
	ldr	ip, [fp, #-64]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L458
.L423:
	add	r3, r5, r8
	mov	r10, #0
	mov	r2, #3
	str	r7, [fp, #-68]
	ldrb	r3, [r3, #24]
	mov	r7, r10
	mov	ip, #1
	mov	r9, r9, asl r3
	rsb	r4, r3, r4
	str	r9, [r6, #28]
	mov	r8, r8, asl r3
	mov	r10, r9
	str	r4, [r6, #32]
	str	r8, [r6, #36]
	mov	r9, r2
	b	.L428
.L426:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r9, #1
	add	r2, r5, r8
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r10, [r6, #28]
	str	r4, [r6, #32]
	str	r8, [r6, #36]
	beq	.L591
.L428:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r10
	add	r8, r8, #1
	bge	.L426
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-64]
	str	r2, [fp, #-60]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-60]
	ldr	ip, [fp, #-64]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L426
.L487:
	add	r3, r5, r8
	mov	r10, #0
	mov	r2, #3
	str	r7, [fp, #-68]
	ldrb	r3, [r3, #24]
	mov	r7, r10
	mov	ip, #1
	mov	r9, r9, asl r3
	rsb	r4, r3, r4
	str	r9, [r6, #28]
	mov	r8, r8, asl r3
	mov	r10, r9
	str	r4, [r6, #32]
	str	r8, [r6, #36]
	mov	r9, r2
	b	.L492
.L490:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r9, #1
	add	r2, r5, r8
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r10, [r6, #28]
	str	r4, [r6, #32]
	str	r8, [r6, #36]
	beq	.L592
.L492:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r10
	add	r8, r8, #1
	bge	.L490
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-64]
	str	r2, [fp, #-60]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-60]
	ldr	ip, [fp, #-64]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L490
.L592:
	mov	r10, r7
	ldr	r7, [fp, #-68]
	add	r3, r10, #16
	b	.L486
.L591:
	mov	r10, r7
	ldr	r7, [fp, #-68]
	add	r3, r10, #16
	b	.L422
.L590:
	mov	r10, r7
	ldr	r7, [fp, #-68]
	add	r3, r10, #16
	b	.L454
.L576:
	mov	r2, r10
	mov	r10, r7
	cmp	r10, #64
	ldr	r7, [fp, #-68]
	bgt	.L593
.L436:
	add	r3, r10, #64
	b	.L422
.L586:
	mov	r2, r10
	mov	r10, r7
	cmp	r10, #64
	ldr	r7, [fp, #-68]
	bgt	.L594
.L500:
	add	r3, r10, #64
	b	.L486
.L581:
	mov	r2, r10
	mov	r10, r7
	cmp	r10, #64
	ldr	r7, [fp, #-68]
	bgt	.L595
.L468:
	add	r3, r10, #64
	b	.L454
.L429:
	add	r3, r5, r8
	mov	r10, #0
	mov	ip, #4
	str	r7, [fp, #-68]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	r2, #1
	mov	r3, r4, asl r1
	mov	r8, r8, asl r1
	rsb	r9, r1, r9
	str	r8, [r6, #36]
	mov	r4, r8
	str	r3, [r6, #28]
	str	r9, [r6, #32]
	mov	r10, r3
	mov	r8, ip
	b	.L433
.L603:
	.align	2
.L602:
	.word	.LANCHOR0
.L431:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r8
	cmp	r1, r0
	sub	r8, r8, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r6, #36]
	movhi	ip, #0
	orr	r7, r7, ip
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r1, r5, r4
	ldrb	r1, [r1, #24]
	mov	r10, r0, asl r1
	rsb	r9, r1, r9
	mov	r4, r4, asl r1
	str	r10, [r6, #28]
	str	r9, [r6, #32]
	str	r4, [r6, #36]
	beq	.L596
.L433:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L431
	rsb	r1, r9, #24
	rsb	ip, r9, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	ip, r1, ip
	str	r2, [fp, #-64]
	str	ip, [fp, #-60]
	add	r9, r1, r9
	bl	BsGet
	ldr	ip, [fp, #-60]
	ldr	r2, [fp, #-64]
	and	ip, ip, #7
	orr	r0, r10, r0, asl ip
	b	.L431
.L493:
	add	r3, r5, r8
	mov	r10, #0
	mov	ip, #4
	str	r7, [fp, #-68]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	r2, #1
	mov	r3, r4, asl r1
	mov	r8, r8, asl r1
	rsb	r9, r1, r9
	str	r8, [r6, #36]
	mov	r4, r8
	str	r3, [r6, #28]
	str	r9, [r6, #32]
	mov	r10, r3
	mov	r8, ip
	b	.L497
.L495:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r8
	cmp	r1, r0
	sub	r8, r8, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r6, #36]
	movhi	ip, #0
	orr	r7, r7, ip
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r1, r5, r4
	ldrb	r1, [r1, #24]
	mov	r10, r0, asl r1
	rsb	r9, r1, r9
	mov	r4, r4, asl r1
	str	r10, [r6, #28]
	str	r9, [r6, #32]
	str	r4, [r6, #36]
	beq	.L597
.L497:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L495
	rsb	r1, r9, #24
	rsb	ip, r9, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	ip, r1, ip
	str	r2, [fp, #-64]
	str	ip, [fp, #-60]
	add	r9, r1, r9
	bl	BsGet
	ldr	ip, [fp, #-60]
	ldr	r2, [fp, #-64]
	and	ip, ip, #7
	orr	r0, r10, r0, asl ip
	b	.L495
.L461:
	add	r3, r5, r8
	mov	r10, #0
	mov	ip, #4
	str	r7, [fp, #-68]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	r2, #1
	mov	r3, r4, asl r1
	mov	r8, r8, asl r1
	rsb	r9, r1, r9
	str	r8, [r6, #36]
	mov	r4, r8
	str	r3, [r6, #28]
	str	r9, [r6, #32]
	mov	r10, r3
	mov	r8, ip
	b	.L465
.L463:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r8
	cmp	r1, r0
	sub	r8, r8, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r6, #36]
	movhi	ip, #0
	orr	r7, r7, ip
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r1, r5, r4
	ldrb	r1, [r1, #24]
	mov	r10, r0, asl r1
	rsb	r9, r1, r9
	mov	r4, r4, asl r1
	str	r10, [r6, #28]
	str	r9, [r6, #32]
	str	r4, [r6, #36]
	beq	.L598
.L465:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L463
	rsb	r1, r9, #24
	rsb	ip, r9, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	ip, r1, ip
	str	r2, [fp, #-64]
	str	ip, [fp, #-60]
	add	r9, r1, r9
	bl	BsGet
	ldr	ip, [fp, #-60]
	ldr	r2, [fp, #-64]
	and	ip, ip, #7
	orr	r0, r10, r0, asl ip
	b	.L463
.L598:
	mov	r10, r7
	ldr	r7, [fp, #-68]
	add	r3, r10, #32
	b	.L454
.L597:
	mov	r10, r7
	ldr	r7, [fp, #-68]
	add	r3, r10, #32
	b	.L486
.L596:
	mov	r10, r7
	ldr	r7, [fp, #-68]
	add	r3, r10, #32
	b	.L422
.L583:
	rsb	r3, r4, #24
	rsb	r9, r4, #16
	bic	r3, r3, #7
	mov	r0, r6
	rsb	r9, r3, r9
	str	r3, [fp, #-60]
	mov	r1, r3
	bl	BsGet
	and	r2, r9, #7
	ldr	r3, [fp, #-60]
	add	r4, r4, r3
	str	r4, [r6, #32]
	orr	r0, r10, r0, asl r2
	str	r0, [r6, #28]
	mov	r10, r0
	b	.L479
.L573:
	rsb	r3, r4, #24
	rsb	r9, r4, #16
	bic	r3, r3, #7
	mov	r0, r6
	rsb	r9, r3, r9
	str	r3, [fp, #-60]
	mov	r1, r3
	bl	BsGet
	and	r2, r9, #7
	ldr	r3, [fp, #-60]
	add	r4, r4, r3
	str	r4, [r6, #32]
	orr	r0, r10, r0, asl r2
	str	r0, [r6, #28]
	mov	r10, r0
	b	.L415
.L578:
	rsb	r3, r4, #24
	rsb	r9, r4, #16
	bic	r3, r3, #7
	mov	r0, r6
	rsb	r9, r3, r9
	str	r3, [fp, #-60]
	mov	r1, r3
	bl	BsGet
	and	r2, r9, #7
	ldr	r3, [fp, #-60]
	add	r4, r4, r3
	str	r4, [r6, #32]
	orr	r0, r10, r0, asl r2
	str	r0, [r6, #28]
	mov	r10, r0
	b	.L447
.L595:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r10, r10, asl #1
	add	r4, r4, #1
	sub	r10, r10, #65
	movge	r0, r2
	blt	.L599
.L469:
	mov	r3, r4, asl #24
	cmp	r3, r0
	rsbls	r0, r3, r0
	ldrls	r1, [r6, #36]
	movls	r3, #1
	movhi	r3, #0
	add	r10, r10, r3
	rsbls	r4, r4, r1
	add	r1, r5, r4
	ldrb	r3, [r1, #24]
	mov	r2, r0, asl r3
	rsb	r9, r3, r9
	mov	r4, r4, asl r3
	str	r2, [r6, #28]
	str	r9, [r6, #32]
	str	r4, [r6, #36]
	b	.L468
.L593:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r10, r10, asl #1
	add	r4, r4, #1
	sub	r10, r10, #65
	movge	r0, r2
	blt	.L600
.L437:
	mov	r3, r4, asl #24
	cmp	r3, r0
	rsbls	r0, r3, r0
	ldrls	r1, [r6, #36]
	movls	r3, #1
	movhi	r3, #0
	add	r10, r10, r3
	rsbls	r4, r4, r1
	add	r1, r5, r4
	ldrb	r3, [r1, #24]
	mov	r2, r0, asl r3
	rsb	r9, r3, r9
	mov	r4, r4, asl r3
	str	r2, [r6, #28]
	str	r9, [r6, #32]
	str	r4, [r6, #36]
	b	.L436
.L594:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r10, r10, asl #1
	add	r4, r4, #1
	sub	r10, r10, #65
	movge	r0, r2
	blt	.L601
.L501:
	mov	r3, r4, asl #24
	cmp	r3, r0
	rsbls	r0, r3, r0
	ldrls	r1, [r6, #36]
	movls	r3, #1
	movhi	r3, #0
	add	r10, r10, r3
	rsbls	r4, r4, r1
	add	r1, r5, r4
	ldrb	r3, [r1, #24]
	mov	r2, r0, asl r3
	rsb	r9, r3, r9
	mov	r4, r4, asl r3
	str	r2, [r6, #28]
	str	r9, [r6, #32]
	str	r4, [r6, #36]
	b	.L500
.L584:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r6
	rsb	r10, r3, r10
	str	r3, [fp, #-60]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-60]
	add	r4, r4, r3
	str	r4, [r6, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r6, #28]
	mov	r9, r0
	b	.L482
.L579:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r6
	rsb	r10, r3, r10
	str	r3, [fp, #-60]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-60]
	add	r4, r4, r3
	str	r4, [r6, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r6, #28]
	mov	r9, r0
	b	.L450
.L574:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r6
	rsb	r10, r3, r10
	str	r3, [fp, #-60]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-60]
	add	r4, r4, r3
	str	r4, [r6, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r6, #28]
	mov	r9, r0
	b	.L418
.L575:
	rsb	r2, r9, #24
	rsb	r10, r9, #16
	bic	r2, r2, #7
	mov	r0, r6
	rsb	r10, r2, r10
	str	r2, [fp, #-60]
	mov	r1, r2
	bl	BsGet
	and	r3, r10, #7
	ldr	r2, [fp, #-60]
	add	r9, r9, r2
	str	r9, [r6, #32]
	orr	r0, r4, r0, asl r3
	str	r0, [r6, #28]
	mov	r4, r0
	b	.L425
.L580:
	rsb	r2, r9, #24
	rsb	r10, r9, #16
	bic	r2, r2, #7
	mov	r0, r6
	rsb	r10, r2, r10
	str	r2, [fp, #-60]
	mov	r1, r2
	bl	BsGet
	and	r3, r10, #7
	ldr	r2, [fp, #-60]
	add	r9, r9, r2
	str	r9, [r6, #32]
	orr	r0, r4, r0, asl r3
	str	r0, [r6, #28]
	mov	r4, r0
	b	.L457
.L585:
	rsb	r2, r9, #24
	rsb	r10, r9, #16
	bic	r2, r2, #7
	mov	r0, r6
	rsb	r10, r2, r10
	str	r2, [fp, #-60]
	mov	r1, r2
	bl	BsGet
	and	r3, r10, #7
	ldr	r2, [fp, #-60]
	add	r9, r9, r2
	str	r9, [r6, #32]
	orr	r0, r4, r0, asl r3
	str	r0, [r6, #28]
	mov	r4, r0
	b	.L489
.L601:
	rsb	r1, r9, #24
	rsb	r8, r9, #16
	bic	r1, r1, #7
	mov	r0, r6
	str	r2, [fp, #-60]
	rsb	r8, r1, r8
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-60]
	and	r8, r8, #7
	orr	r0, r2, r0, asl r8
	b	.L501
.L599:
	rsb	r1, r9, #24
	rsb	r8, r9, #16
	bic	r1, r1, #7
	mov	r0, r6
	str	r2, [fp, #-60]
	rsb	r8, r1, r8
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-60]
	and	r8, r8, #7
	orr	r0, r2, r0, asl r8
	b	.L469
.L600:
	rsb	r1, r9, #24
	rsb	r8, r9, #16
	bic	r1, r1, #7
	mov	r0, r6
	str	r2, [fp, #-60]
	rsb	r8, r1, r8
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-60]
	and	r8, r8, #7
	orr	r0, r2, r0, asl r8
	b	.L437
.L410:
	ldr	r2, .L602
	add	r2, r2, r4
	ldrb	r2, [r2, #24]
	mov	r3, r3, asl r2
	rsb	r5, r2, ip
	mov	r4, r4, asl r2
	str	r3, [r6, #28]
	str	r5, [r6, #32]
	str	r4, [r6, #36]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L408:
	rsb	r8, ip, #24
	ldr	r10, [r1, #28]
	bic	r8, r8, #7
	mov	r0, r1
	rsb	r9, ip, #16
	str	ip, [fp, #-48]
	mov	r1, r8
	rsb	r9, r8, r9
	bl	BsGet
	ldr	ip, [fp, #-48]
	and	r3, r9, #7
	add	r5, ip, r8
	str	r5, [r6, #32]
	mov	ip, r5
	orr	r0, r10, r0, asl r3
	str	r0, [r6, #28]
	mov	r3, r0
	b	.L409
	.fnend
	.size	Vp9_ReadCoefProbsCommon, .-Vp9_ReadCoefProbsCommon
	.align	2
	.global	Vp9_ReadCoefProbs
	.type	Vp9_ReadCoefProbs, %function
Vp9_ReadCoefProbs:
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
	mov	r1, r2
	mov	r5, r2
	mov	r6, r0
	bl	Vp9_ReadCoefProbsCommon
	cmp	r4, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	mov	r1, r5
	add	r0, r6, #432
	bl	Vp9_ReadCoefProbsCommon
	cmp	r4, #1
	bls	.L606
	mov	r1, r5
	add	r0, r6, #864
	bl	Vp9_ReadCoefProbsCommon
.L606:
	cmp	r4, #2
	ldmlsfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	mov	r1, r5
	add	r0, r6, #1296
	bl	Vp9_ReadCoefProbsCommon
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	Vp9_ReadCoefProbs, .-Vp9_ReadCoefProbs
	.align	2
	.global	Vp9_ReadInterModeProbs
	.type	Vp9_ReadInterModeProbs, %function
Vp9_ReadInterModeProbs:
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
	ldr	r6, .L782
	mov	r7, r0
	mov	r5, r1
	add	r3, r0, #21
	str	r3, [fp, #-48]
.L703:
	ldr	r3, [r5, #36]
	ldr	r4, [r5, #32]
	sub	r3, r3, #1
	cmp	r4, #0
	mov	r2, r3, asl #8
	sub	r3, r2, r3, asl #2
	mov	r3, r3, lsr #8
	add	r8, r3, #1
	blt	.L610
	ldr	r10, [r5, #28]
.L611:
	mov	r9, r8, asl #24
	cmp	r9, r10
	bhi	.L612
	ldr	r3, [r5, #36]
	rsb	r10, r9, r10
	rsb	r3, r8, r3
	add	r2, r6, r3
	ldrb	r9, [r2, #24]
	mov	r3, r3, asl r9
	rsb	r4, r9, r4
	sub	r8, r3, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r9, r10, asl r9
	str	r3, [r5, #36]
	add	r8, r8, #1
	str	r4, [r5, #32]
	str	r9, [r5, #28]
	blt	.L757
.L613:
	mov	r10, r8, asl #24
	cmp	r10, r9
	bhi	.L614
	ldr	r2, [r5, #36]
	rsb	r9, r10, r9
	rsb	r8, r8, r2
	add	r3, r6, r8
	ldrb	r0, [r3, #24]
	mov	r2, r8, asl r0
	rsb	r4, r0, r4
	sub	r8, r2, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r9, r9, asl r0
	str	r2, [r5, #36]
	add	r8, r8, #1
	str	r4, [r5, #32]
	str	r9, [r5, #28]
	blt	.L758
.L616:
	mov	r3, r8, asl #24
	cmp	r3, r9
	bhi	.L621
	ldr	r1, [r5, #36]
	rsb	r3, r3, r9
	rsb	r8, r8, r1
	add	r2, r6, r8
	ldrb	r2, [r2, #24]
	rsb	r9, r2, r4
	mov	r1, r8, asl r2
	sub	r8, r1, #1
	cmp	r9, #0
	ubfx	r8, r8, #1, #24
	mov	r4, r3, asl r2
	str	r1, [r5, #36]
	add	r8, r8, #1
	str	r9, [r5, #32]
	str	r4, [r5, #28]
	blt	.L759
.L623:
	mov	r2, r8, asl #24
	cmp	r2, r4
	bhi	.L627
	ldr	r1, [r5, #36]
	rsb	r2, r2, r4
	mov	r10, #0
	mov	r3, #6
	rsb	r8, r8, r1
	str	r7, [fp, #-60]
	add	r1, r6, r8
	mov	r7, r10
	mov	ip, #1
	ldrb	r4, [r1, #24]
	mov	r2, r2, asl r4
	rsb	r9, r4, r9
	str	r2, [r5, #28]
	mov	r4, r8, asl r4
	str	r9, [r5, #32]
	mov	r8, r3
	str	r4, [r5, #36]
	mov	r10, r2
	b	.L628
.L632:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r8
	cmp	r2, r0
	sub	r8, r8, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r2, r6, r4
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r9, r2, r9
	mov	r4, r4, asl r2
	str	r10, [r5, #28]
	str	r9, [r5, #32]
	str	r4, [r5, #36]
	beq	.L760
.L628:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L632
	rsb	r1, r9, #24
	rsb	r2, r9, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L632
.L612:
	add	r3, r6, r8
	ldrb	r3, [r3, #24]
	mov	r10, r10, asl r3
	rsb	r4, r3, r4
	str	r10, [r5, #28]
	mov	r3, r8, asl r3
	str	r4, [r5, #32]
	str	r3, [r5, #36]
.L704:
	sub	r3, r3, #1
	cmp	r4, #0
	mov	r8, r3, asl #8
	sub	r8, r8, r3, asl #2
	mov	r8, r8, lsr #8
	add	r8, r8, #1
	blt	.L761
.L641:
	mov	r9, r8, asl #24
	cmp	r9, r10
	bhi	.L642
	ldr	r3, [r5, #36]
	rsb	r9, r9, r10
	rsb	r8, r8, r3
	add	r3, r6, r8
	ldrb	r2, [r3, #24]
	mov	r3, r8, asl r2
	rsb	r4, r2, r4
	sub	r8, r3, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r9, r9, asl r2
	str	r3, [r5, #36]
	add	r8, r8, #1
	str	r4, [r5, #32]
	str	r9, [r5, #28]
	blt	.L762
.L643:
	mov	r2, r8, asl #24
	cmp	r2, r9
	bhi	.L644
	ldr	ip, [r5, #36]
	rsb	r9, r2, r9
	rsb	r8, r8, ip
	add	r3, r6, r8
	ldrb	r0, [r3, #24]
	mov	ip, r8, asl r0
	rsb	r4, r0, r4
	sub	r8, ip, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r9, r9, asl r0
	str	ip, [r5, #36]
	add	r8, r8, #1
	str	r4, [r5, #32]
	str	r9, [r5, #28]
	blt	.L763
.L646:
	mov	r3, r8, asl #24
	cmp	r3, r9
	bhi	.L651
	ldr	r1, [r5, #36]
	rsb	r3, r3, r9
	rsb	r8, r8, r1
	add	r2, r6, r8
	ldrb	ip, [r2, #24]
	rsb	r9, ip, r4
	mov	r1, r8, asl ip
	sub	r8, r1, #1
	cmp	r9, #0
	ubfx	r8, r8, #1, #24
	mov	r4, r3, asl ip
	str	r1, [r5, #36]
	add	r8, r8, #1
	str	r9, [r5, #32]
	str	r4, [r5, #28]
	blt	.L764
.L653:
	mov	r2, r8, asl #24
	cmp	r2, r4
	bhi	.L657
	ldr	r1, [r5, #36]
	rsb	r2, r2, r4
	mov	r10, #0
	mov	r3, #6
	rsb	r8, r8, r1
	str	r7, [fp, #-60]
	add	r1, r6, r8
	mov	r7, r10
	mov	ip, #1
	ldrb	r4, [r1, #24]
	mov	r2, r2, asl r4
	rsb	r9, r4, r9
	str	r2, [r5, #28]
	mov	r4, r8, asl r4
	str	r9, [r5, #32]
	mov	r8, r3
	str	r4, [r5, #36]
	mov	r10, r2
	b	.L658
.L662:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r8
	cmp	r2, r0
	sub	r8, r8, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r2, r6, r4
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r9, r2, r9
	mov	r4, r4, asl r2
	str	r10, [r5, #28]
	str	r9, [r5, #32]
	str	r4, [r5, #36]
	beq	.L765
.L658:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L662
	rsb	r1, r9, #24
	rsb	r2, r9, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L662
.L642:
	add	r3, r6, r8
	ldrb	r3, [r3, #24]
	mov	r10, r10, asl r3
	rsb	r4, r3, r4
	mov	r8, r8, asl r3
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r8, [r5, #36]
.L705:
	sub	r8, r8, #1
	cmp	r4, #0
	mov	r3, r8, asl #8
	sub	r8, r3, r8, asl #2
	mov	r8, r8, lsr #8
	add	r8, r8, #1
	blt	.L766
.L671:
	mov	r9, r8, asl #24
	cmp	r9, r10
	bhi	.L672
	ldr	r3, [r5, #36]
	rsb	r9, r9, r10
	rsb	r8, r8, r3
	add	r3, r6, r8
	ldrb	r2, [r3, #24]
	mov	r3, r8, asl r2
	rsb	r4, r2, r4
	sub	r8, r3, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r9, r9, asl r2
	str	r3, [r5, #36]
	add	r8, r8, #1
	str	r4, [r5, #32]
	str	r9, [r5, #28]
	blt	.L767
.L673:
	mov	r2, r8, asl #24
	cmp	r2, r9
	bhi	.L674
	ldr	ip, [r5, #36]
	rsb	r9, r2, r9
	rsb	r8, r8, ip
	add	r3, r6, r8
	ldrb	r0, [r3, #24]
	mov	ip, r8, asl r0
	rsb	r4, r0, r4
	sub	r8, ip, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r9, r9, asl r0
	str	ip, [r5, #36]
	add	r8, r8, #1
	str	r4, [r5, #32]
	str	r9, [r5, #28]
	blt	.L768
.L676:
	mov	r3, r8, asl #24
	cmp	r3, r9
	bhi	.L681
	ldr	r1, [r5, #36]
	rsb	r3, r3, r9
	rsb	r8, r8, r1
	add	r2, r6, r8
	ldrb	ip, [r2, #24]
	rsb	r9, ip, r4
	mov	r1, r8, asl ip
	sub	r8, r1, #1
	cmp	r9, #0
	ubfx	r8, r8, #1, #24
	mov	r4, r3, asl ip
	str	r1, [r5, #36]
	add	r8, r8, #1
	str	r9, [r5, #32]
	str	r4, [r5, #28]
	blt	.L769
.L683:
	mov	r2, r8, asl #24
	cmp	r2, r4
	bhi	.L687
	ldr	r1, [r5, #36]
	rsb	r2, r2, r4
	mov	r10, #0
	mov	r3, #6
	rsb	r8, r8, r1
	str	r7, [fp, #-60]
	add	r1, r6, r8
	mov	r7, r10
	mov	ip, #1
	ldrb	r4, [r1, #24]
	mov	r2, r2, asl r4
	rsb	r9, r4, r9
	str	r2, [r5, #28]
	mov	r4, r8, asl r4
	str	r9, [r5, #32]
	mov	r8, r3
	str	r4, [r5, #36]
	mov	r10, r2
	b	.L688
.L692:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r8
	cmp	r2, r0
	sub	r8, r8, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r2, r6, r4
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r9, r2, r9
	mov	r4, r4, asl r2
	str	r10, [r5, #28]
	str	r9, [r5, #32]
	str	r4, [r5, #36]
	beq	.L770
.L688:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L692
	rsb	r1, r9, #24
	rsb	r2, r9, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L692
.L672:
	add	r3, r6, r8
	ldrb	r3, [r3, #24]
	mov	r10, r10, asl r3
	rsb	r4, r3, r4
	mov	r8, r8, asl r3
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r8, [r5, #36]
.L706:
	ldr	r3, [fp, #-48]
	add	r7, r7, #3
	cmp	r7, r3
	bne	.L703
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L766:
	rsb	r2, r4, #24
	rsb	r9, r4, #16
	bic	r2, r2, #7
	mov	r0, r5
	rsb	r9, r2, r9
	str	r2, [fp, #-52]
	mov	r1, r2
	bl	BsGet
	and	r3, r9, #7
	ldr	r2, [fp, #-52]
	add	r4, r2, r4
	str	r4, [r5, #32]
	orr	r0, r10, r0, asl r3
	str	r0, [r5, #28]
	mov	r10, r0
	b	.L671
.L761:
	rsb	r2, r4, #24
	rsb	r9, r4, #16
	bic	r2, r2, #7
	mov	r0, r5
	rsb	r9, r2, r9
	str	r2, [fp, #-52]
	mov	r1, r2
	bl	BsGet
	and	r3, r9, #7
	ldr	r2, [fp, #-52]
	add	r4, r2, r4
	str	r4, [r5, #32]
	orr	r0, r10, r0, asl r3
	str	r0, [r5, #28]
	mov	r10, r0
	b	.L641
.L610:
	rsb	r9, r4, #24
	rsb	r3, r4, #16
	bic	r9, r9, #7
	mov	r0, r5
	rsb	r3, r9, r3
	ldr	r10, [r5, #28]
	mov	r1, r9
	str	r3, [fp, #-52]
	bl	BsGet
	ldr	r3, [fp, #-52]
	add	r4, r4, r9
	str	r4, [r5, #32]
	and	r3, r3, #7
	orr	r0, r10, r0, asl r3
	str	r0, [r5, #28]
	mov	r10, r0
	b	.L611
.L614:
	add	r3, r6, r8
	mov	r10, #0
	mov	r2, #3
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r5, #28]
	mov	r8, r8, asl r1
	mov	r10, r9
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	mov	r9, r2
	b	.L619
.L617:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r9, #1
	add	r2, r6, r8
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	beq	.L771
.L619:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r10
	add	r8, r8, #1
	bge	.L617
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L617
.L674:
	add	r3, r6, r8
	mov	r10, #0
	mov	r2, #3
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r5, #28]
	mov	r8, r8, asl r1
	mov	r10, r9
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	mov	r9, r2
	b	.L679
.L677:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r9, #1
	add	r2, r6, r8
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	beq	.L772
.L679:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r10
	add	r8, r8, #1
	bge	.L677
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L677
.L644:
	add	r3, r6, r8
	mov	r10, #0
	mov	r2, #3
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r5, #28]
	mov	r8, r8, asl r1
	mov	r10, r9
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	mov	r9, r2
	b	.L649
.L647:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r9, #1
	add	r2, r6, r8
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	beq	.L773
.L649:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r10
	add	r8, r8, #1
	bge	.L647
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L647
.L773:
	mov	r10, r7
	ldr	r7, [fp, #-60]
.L650:
	ldrb	r2, [r7, #1959]
	add	r10, r6, r10
	sub	ip, r2, #1
	ldrb	r1, [r10, #280]
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L665
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L666
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L666:
	add	r3, r3, #1
.L668:
	strb	r3, [r7, #1959]
	ldr	r10, [r5, #28]
	ldr	r8, [r5, #36]
	ldr	r4, [r5, #32]
	b	.L705
.L665:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	bgt	.L669
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
.L669:
	rsb	r3, r3, #255
	b	.L668
.L772:
	mov	r10, r7
	ldr	r7, [fp, #-60]
.L680:
	ldrb	r2, [r7, #1960]
	add	r10, r6, r10
	sub	ip, r2, #1
	ldrb	r1, [r10, #280]
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L697
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L698
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L698:
	add	r3, r3, #1
.L700:
	strb	r3, [r7, #1960]
	b	.L706
.L697:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	bgt	.L701
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
.L701:
	rsb	r3, r3, #255
	b	.L700
.L771:
	mov	r10, r7
	ldr	r7, [fp, #-60]
.L620:
	ldrb	r2, [r7, #1958]
	add	r10, r6, r10
	sub	ip, r2, #1
	ldrb	r1, [r10, #280]
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L635
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L636
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L636:
	add	r3, r3, #1
.L638:
	strb	r3, [r7, #1958]
	ldr	r10, [r5, #28]
	ldr	r3, [r5, #36]
	ldr	r4, [r5, #32]
	b	.L704
.L635:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	bgt	.L639
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
.L639:
	rsb	r3, r3, #255
	b	.L638
.L627:
	add	r3, r6, r8
	mov	r10, #0
	mov	ip, #4
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	r2, #1
	mov	r3, r4, asl r1
	mov	r8, r8, asl r1
	rsb	r9, r1, r9
	str	r8, [r5, #36]
	mov	r4, r8
	str	r3, [r5, #28]
	str	r9, [r5, #32]
	mov	r10, r3
	mov	r8, ip
	b	.L631
.L629:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r8
	cmp	r1, r0
	sub	r8, r8, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r5, #36]
	movhi	ip, #0
	orr	r7, r7, ip
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r1, r6, r4
	ldrb	r1, [r1, #24]
	mov	r10, r0, asl r1
	rsb	r9, r1, r9
	mov	r4, r4, asl r1
	str	r10, [r5, #28]
	str	r9, [r5, #32]
	str	r4, [r5, #36]
	beq	.L774
.L631:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L629
	rsb	r1, r9, #24
	rsb	ip, r9, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	ip, r1, ip
	str	r2, [fp, #-56]
	str	ip, [fp, #-52]
	add	r9, r1, r9
	bl	BsGet
	ldr	ip, [fp, #-52]
	ldr	r2, [fp, #-56]
	and	ip, ip, #7
	orr	r0, r10, r0, asl ip
	b	.L629
.L687:
	add	r3, r6, r8
	mov	r10, #0
	mov	ip, #4
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	r2, #1
	mov	r3, r4, asl r1
	mov	r8, r8, asl r1
	rsb	r9, r1, r9
	str	r8, [r5, #36]
	mov	r4, r8
	str	r3, [r5, #28]
	str	r9, [r5, #32]
	mov	r10, r3
	mov	r8, ip
	b	.L691
.L689:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r8
	cmp	r1, r0
	sub	r8, r8, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r5, #36]
	movhi	ip, #0
	orr	r7, r7, ip
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r1, r6, r4
	ldrb	r1, [r1, #24]
	mov	r10, r0, asl r1
	rsb	r9, r1, r9
	mov	r4, r4, asl r1
	str	r10, [r5, #28]
	str	r9, [r5, #32]
	str	r4, [r5, #36]
	beq	.L775
.L691:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L689
	rsb	r1, r9, #24
	rsb	ip, r9, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	ip, r1, ip
	str	r2, [fp, #-56]
	str	ip, [fp, #-52]
	add	r9, r1, r9
	bl	BsGet
	ldr	ip, [fp, #-52]
	ldr	r2, [fp, #-56]
	and	ip, ip, #7
	orr	r0, r10, r0, asl ip
	b	.L689
.L657:
	add	r3, r6, r8
	mov	r10, #0
	mov	ip, #4
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	r2, #1
	mov	r3, r4, asl r1
	mov	r8, r8, asl r1
	rsb	r9, r1, r9
	str	r8, [r5, #36]
	mov	r4, r8
	str	r3, [r5, #28]
	str	r9, [r5, #32]
	mov	r10, r3
	mov	r8, ip
	b	.L661
.L659:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r8
	cmp	r1, r0
	sub	r8, r8, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r5, #36]
	movhi	ip, #0
	orr	r7, r7, ip
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r1, r6, r4
	ldrb	r1, [r1, #24]
	mov	r10, r0, asl r1
	rsb	r9, r1, r9
	mov	r4, r4, asl r1
	str	r10, [r5, #28]
	str	r9, [r5, #32]
	str	r4, [r5, #36]
	beq	.L776
.L661:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L659
	rsb	r1, r9, #24
	rsb	ip, r9, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	ip, r1, ip
	str	r2, [fp, #-56]
	str	ip, [fp, #-52]
	add	r9, r1, r9
	bl	BsGet
	ldr	ip, [fp, #-52]
	ldr	r2, [fp, #-56]
	and	ip, ip, #7
	orr	r0, r10, r0, asl ip
	b	.L659
.L681:
	add	r3, r6, r8
	mov	r10, #0
	mov	r2, #3
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r5, #28]
	mov	r8, r8, asl r1
	mov	r10, r9
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	mov	r9, r2
	b	.L686
.L684:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r9, #1
	add	r2, r6, r8
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	beq	.L777
.L686:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r10
	add	r8, r8, #1
	bge	.L684
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L684
.L651:
	add	r3, r6, r8
	mov	r10, #0
	mov	r2, #3
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r5, #28]
	mov	r8, r8, asl r1
	mov	r10, r9
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	mov	r9, r2
	b	.L656
.L654:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r9, #1
	add	r2, r6, r8
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	beq	.L778
.L656:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r10
	add	r8, r8, #1
	bge	.L654
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L654
.L621:
	add	r3, r6, r8
	mov	r10, #0
	mov	r2, #3
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r5, #28]
	mov	r8, r8, asl r1
	mov	r10, r9
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	mov	r9, r2
	b	.L626
.L783:
	.align	2
.L782:
	.word	.LANCHOR0
.L624:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r9, #1
	add	r2, r6, r8
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	beq	.L779
.L626:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r10
	add	r8, r8, #1
	bge	.L624
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L624
.L779:
	mov	r10, r7
	ldr	r7, [fp, #-60]
	add	r10, r10, #16
	b	.L620
.L778:
	mov	r10, r7
	ldr	r7, [fp, #-60]
	add	r10, r10, #16
	b	.L650
.L777:
	mov	r10, r7
	ldr	r7, [fp, #-60]
	add	r10, r10, #16
	b	.L680
.L770:
	mov	r2, r10
	mov	r10, r7
	cmp	r10, #64
	ldr	r7, [fp, #-60]
	bgt	.L780
.L694:
	add	r10, r10, #64
	b	.L680
.L760:
	mov	r10, r7
	cmp	r10, #64
	ldr	r7, [fp, #-60]
	ble	.L634
	mov	r1, #128
	mov	r0, r5
	bl	Vp9_Cabac_Read
	add	r0, r0, r10, lsl #1
	sub	r10, r0, #65
.L634:
	add	r10, r10, #64
	b	.L620
.L765:
	mov	r10, r7
	cmp	r10, #64
	ldr	r7, [fp, #-60]
	ble	.L664
	mov	r1, #128
	mov	r0, r5
	bl	Vp9_Cabac_Read
	add	r0, r0, r10, lsl #1
	sub	r10, r0, #65
.L664:
	add	r10, r10, #64
	b	.L650
.L776:
	mov	r10, r7
	ldr	r7, [fp, #-60]
	add	r10, r10, #32
	b	.L650
.L775:
	mov	r10, r7
	ldr	r7, [fp, #-60]
	add	r10, r10, #32
	b	.L680
.L774:
	mov	r10, r7
	ldr	r7, [fp, #-60]
	add	r10, r10, #32
	b	.L620
.L762:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-52]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-52]
	add	r4, r4, r3
	str	r4, [r5, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r5, #28]
	mov	r9, r0
	b	.L643
.L767:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-52]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-52]
	add	r4, r4, r3
	str	r4, [r5, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r5, #28]
	mov	r9, r0
	b	.L673
.L757:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-52]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-52]
	add	r4, r4, r3
	str	r4, [r5, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r5, #28]
	mov	r9, r0
	b	.L613
.L780:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r10, r10, asl #1
	add	r4, r4, #1
	sub	r10, r10, #65
	movge	r0, r2
	blt	.L781
.L695:
	mov	r3, r4, asl #24
	cmp	r3, r0
	rsbls	r0, r3, r0
	ldrls	r2, [r5, #36]
	movls	r1, #1
	movhi	r1, #0
	add	r10, r10, r1
	rsbls	r4, r4, r2
	add	r3, r6, r4
	ldrb	r3, [r3, #24]
	mov	r2, r0, asl r3
	rsb	r9, r3, r9
	mov	r4, r4, asl r3
	str	r2, [r5, #28]
	str	r9, [r5, #32]
	str	r4, [r5, #36]
	b	.L694
.L768:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-52]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-52]
	add	r4, r4, r3
	str	r4, [r5, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r5, #28]
	mov	r9, r0
	b	.L676
.L763:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-52]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-52]
	add	r4, r4, r3
	str	r4, [r5, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r5, #28]
	mov	r9, r0
	b	.L646
.L758:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-52]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-52]
	add	r4, r4, r3
	str	r4, [r5, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r5, #28]
	mov	r9, r0
	b	.L616
.L769:
	rsb	r2, r9, #24
	rsb	r10, r9, #16
	bic	r2, r2, #7
	mov	r0, r5
	rsb	r10, r2, r10
	str	r2, [fp, #-52]
	mov	r1, r2
	bl	BsGet
	and	r3, r10, #7
	ldr	r2, [fp, #-52]
	add	r9, r9, r2
	str	r9, [r5, #32]
	orr	r0, r4, r0, asl r3
	str	r0, [r5, #28]
	mov	r4, r0
	b	.L683
.L764:
	rsb	r2, r9, #24
	rsb	r10, r9, #16
	bic	r2, r2, #7
	mov	r0, r5
	rsb	r10, r2, r10
	str	r2, [fp, #-52]
	mov	r1, r2
	bl	BsGet
	and	r3, r10, #7
	ldr	r2, [fp, #-52]
	add	r9, r9, r2
	str	r9, [r5, #32]
	orr	r0, r4, r0, asl r3
	str	r0, [r5, #28]
	mov	r4, r0
	b	.L653
.L759:
	rsb	r2, r9, #24
	rsb	r10, r9, #16
	bic	r2, r2, #7
	mov	r0, r5
	rsb	r10, r2, r10
	str	r2, [fp, #-52]
	mov	r1, r2
	bl	BsGet
	and	r3, r10, #7
	ldr	r2, [fp, #-52]
	add	r9, r9, r2
	str	r9, [r5, #32]
	orr	r0, r4, r0, asl r3
	str	r0, [r5, #28]
	mov	r4, r0
	b	.L623
.L781:
	rsb	r1, r9, #24
	rsb	r8, r9, #16
	bic	r1, r1, #7
	mov	r0, r5
	str	r2, [fp, #-52]
	rsb	r8, r1, r8
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-52]
	and	r8, r8, #7
	orr	r0, r2, r0, asl r8
	b	.L695
	.fnend
	.size	Vp9_ReadInterModeProbs, .-Vp9_ReadInterModeProbs
	.align	2
	.global	Vp9_ReadSwitchableInterpProbs
	.type	Vp9_ReadSwitchableInterpProbs, %function
Vp9_ReadSwitchableInterpProbs:
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
	ldr	r6, .L909
	mov	r7, r0
	mov	r5, r1
	add	r3, r0, #8
	str	r3, [fp, #-48]
.L850:
	ldr	r8, [r5, #36]
	ldr	r4, [r5, #32]
	sub	r8, r8, #1
	cmp	r4, #0
	mov	r3, r8, asl #8
	sub	r8, r3, r8, asl #2
	mov	r8, r8, lsr #8
	add	r8, r8, #1
	blt	.L785
	ldr	r0, [r5, #28]
.L786:
	mov	r10, r8, asl #24
	cmp	r10, r0
	bhi	.L787
	ldr	r3, [r5, #36]
	rsb	r0, r10, r0
	rsb	r8, r8, r3
	add	r3, r6, r8
	ldrb	r9, [r3, #24]
	mov	r3, r8, asl r9
	rsb	r4, r9, r4
	sub	r8, r3, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r9, r0, asl r9
	str	r3, [r5, #36]
	add	r8, r8, #1
	str	r4, [r5, #32]
	str	r9, [r5, #28]
	blt	.L890
.L788:
	mov	r0, r8, asl #24
	cmp	r0, r9
	bhi	.L789
	ldr	r2, [r5, #36]
	rsb	r9, r0, r9
	rsb	r8, r8, r2
	add	r3, r6, r8
	ldrb	r0, [r3, #24]
	mov	r2, r8, asl r0
	rsb	r4, r0, r4
	sub	r8, r2, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r9, r9, asl r0
	str	r2, [r5, #36]
	add	r8, r8, #1
	str	r4, [r5, #32]
	str	r9, [r5, #28]
	blt	.L891
.L791:
	mov	r3, r8, asl #24
	cmp	r3, r9
	bhi	.L796
	ldr	r1, [r5, #36]
	rsb	r3, r3, r9
	rsb	r8, r8, r1
	add	r2, r6, r8
	ldrb	r2, [r2, #24]
	rsb	r9, r2, r4
	mov	r1, r8, asl r2
	sub	r8, r1, #1
	cmp	r9, #0
	ubfx	r8, r8, #1, #24
	mov	r4, r3, asl r2
	str	r1, [r5, #36]
	add	r8, r8, #1
	str	r9, [r5, #32]
	str	r4, [r5, #28]
	blt	.L892
.L798:
	mov	r2, r8, asl #24
	cmp	r2, r4
	bhi	.L802
	ldr	r1, [r5, #36]
	rsb	r2, r2, r4
	mov	r10, #0
	mov	r3, #6
	rsb	r8, r8, r1
	str	r7, [fp, #-60]
	add	r1, r6, r8
	mov	r7, r10
	mov	ip, #1
	ldrb	r4, [r1, #24]
	mov	r2, r2, asl r4
	rsb	r9, r4, r9
	str	r2, [r5, #28]
	mov	r4, r8, asl r4
	str	r9, [r5, #32]
	mov	r8, r3
	str	r4, [r5, #36]
	mov	r10, r2
	b	.L803
.L807:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r8
	cmp	r2, r0
	sub	r8, r8, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r2, r6, r4
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r9, r2, r9
	mov	r4, r4, asl r2
	str	r10, [r5, #28]
	str	r9, [r5, #32]
	str	r4, [r5, #36]
	beq	.L893
.L803:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L807
	rsb	r1, r9, #24
	rsb	r2, r9, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L807
.L787:
	add	r3, r6, r8
	ldrb	r3, [r3, #24]
	mov	r10, r0, asl r3
	rsb	r4, r3, r4
	mov	r8, r8, asl r3
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r8, [r5, #36]
.L851:
	sub	r8, r8, #1
	cmp	r4, #0
	mov	r3, r8, asl #8
	sub	r8, r3, r8, asl #2
	mov	r8, r8, lsr #8
	add	r8, r8, #1
	blt	.L894
.L818:
	mov	r9, r8, asl #24
	cmp	r9, r10
	bhi	.L819
	ldr	r3, [r5, #36]
	rsb	r9, r9, r10
	rsb	r8, r8, r3
	add	r3, r6, r8
	ldrb	r2, [r3, #24]
	mov	r3, r8, asl r2
	rsb	r4, r2, r4
	sub	r8, r3, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r9, r9, asl r2
	str	r3, [r5, #36]
	add	r8, r8, #1
	str	r4, [r5, #32]
	str	r9, [r5, #28]
	blt	.L895
.L820:
	mov	r2, r8, asl #24
	cmp	r2, r9
	bhi	.L821
	ldr	ip, [r5, #36]
	rsb	r9, r2, r9
	rsb	r8, r8, ip
	add	r3, r6, r8
	ldrb	r0, [r3, #24]
	mov	ip, r8, asl r0
	rsb	r4, r0, r4
	sub	r8, ip, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r9, r9, asl r0
	str	ip, [r5, #36]
	add	r8, r8, #1
	str	r4, [r5, #32]
	str	r9, [r5, #28]
	blt	.L896
.L823:
	mov	r3, r8, asl #24
	cmp	r3, r9
	bhi	.L828
	ldr	r1, [r5, #36]
	rsb	r3, r3, r9
	rsb	r8, r8, r1
	add	r2, r6, r8
	ldrb	ip, [r2, #24]
	rsb	r9, ip, r4
	mov	r1, r8, asl ip
	sub	r8, r1, #1
	cmp	r9, #0
	ubfx	r8, r8, #1, #24
	mov	r4, r3, asl ip
	str	r1, [r5, #36]
	add	r8, r8, #1
	str	r9, [r5, #32]
	str	r4, [r5, #28]
	blt	.L897
.L830:
	mov	r2, r8, asl #24
	cmp	r2, r4
	bhi	.L834
	ldr	r1, [r5, #36]
	rsb	r2, r2, r4
	mov	r10, #0
	mov	r3, #6
	rsb	r8, r8, r1
	str	r7, [fp, #-60]
	add	r1, r6, r8
	mov	r7, r10
	mov	ip, #1
	ldrb	r4, [r1, #24]
	mov	r2, r2, asl r4
	rsb	r9, r4, r9
	str	r2, [r5, #28]
	mov	r4, r8, asl r4
	str	r9, [r5, #32]
	mov	r8, r3
	str	r4, [r5, #36]
	mov	r10, r2
	b	.L835
.L839:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r8
	cmp	r2, r0
	sub	r8, r8, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r2, r6, r4
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r9, r2, r9
	mov	r4, r4, asl r2
	str	r10, [r5, #28]
	str	r9, [r5, #32]
	str	r4, [r5, #36]
	beq	.L898
.L835:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L839
	rsb	r1, r9, #24
	rsb	r2, r9, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L839
.L819:
	add	r3, r6, r8
	ldrb	r3, [r3, #24]
	mov	r10, r10, asl r3
	rsb	r4, r3, r4
	mov	r8, r8, asl r3
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r8, [r5, #36]
.L852:
	ldr	r3, [fp, #-48]
	add	r7, r7, #2
	cmp	r7, r3
	bne	.L850
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L894:
	rsb	r2, r4, #24
	rsb	r9, r4, #16
	bic	r2, r2, #7
	mov	r0, r5
	rsb	r9, r2, r9
	str	r2, [fp, #-52]
	mov	r1, r2
	bl	BsGet
	and	r3, r9, #7
	ldr	r2, [fp, #-52]
	add	r4, r2, r4
	str	r4, [r5, #32]
	orr	r0, r10, r0, asl r3
	str	r0, [r5, #28]
	mov	r10, r0
	b	.L818
.L785:
	rsb	r9, r4, #24
	rsb	r3, r4, #16
	bic	r9, r9, #7
	mov	r0, r5
	rsb	r3, r9, r3
	ldr	r10, [r5, #28]
	mov	r1, r9
	str	r3, [fp, #-52]
	bl	BsGet
	ldr	r3, [fp, #-52]
	add	r4, r4, r9
	str	r4, [r5, #32]
	and	r3, r3, #7
	orr	r0, r10, r0, asl r3
	str	r0, [r5, #28]
	b	.L786
.L796:
	add	r3, r6, r8
	mov	r10, #0
	mov	r2, #3
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r5, #28]
	mov	r8, r8, asl r1
	mov	r10, r9
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	mov	r9, r2
	b	.L801
.L799:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r9, #1
	add	r2, r6, r8
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	beq	.L899
.L801:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r10
	add	r8, r8, #1
	bge	.L799
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L799
.L828:
	add	r3, r6, r8
	mov	r10, #0
	mov	r2, #3
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r5, #28]
	mov	r8, r8, asl r1
	mov	r10, r9
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	mov	r9, r2
	b	.L833
.L831:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r9, #1
	add	r2, r6, r8
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	beq	.L900
.L833:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r10
	add	r8, r8, #1
	bge	.L831
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L831
.L789:
	add	r3, r6, r8
	mov	r10, #0
	mov	r2, #3
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r5, #28]
	mov	r8, r8, asl r1
	mov	r10, r9
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	mov	r9, r2
	b	.L794
.L792:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r9, #1
	add	r2, r6, r8
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	beq	.L901
.L794:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r10
	add	r8, r8, #1
	bge	.L792
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L792
.L821:
	add	r3, r6, r8
	mov	r10, #0
	mov	r2, #3
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r5, #28]
	mov	r8, r8, asl r1
	mov	r10, r9
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	mov	r9, r2
	b	.L826
.L824:
	mov	r2, r8, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r5, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r8, r8, lr
	cmn	r9, #1
	add	r2, r6, r8
	ldrb	r2, [r2, #24]
	mov	r10, r0, asl r2
	rsb	r4, r2, r4
	mov	r8, r8, asl r2
	str	r10, [r5, #28]
	str	r4, [r5, #32]
	str	r8, [r5, #36]
	beq	.L902
.L826:
	sub	r8, r8, #1
	cmp	r4, #0
	ubfx	r8, r8, #1, #24
	mov	r0, r10
	add	r8, r8, #1
	bge	.L824
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	r2, r1, r2
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-52]
	ldr	ip, [fp, #-56]
	and	r2, r2, #7
	orr	r0, r10, r0, asl r2
	b	.L824
.L902:
	mov	r10, r7
	ldr	r7, [fp, #-60]
.L827:
	ldrb	r2, [r7, #1951]
	add	r10, r6, r10
	sub	ip, r2, #1
	ldrb	r1, [r10, #280]
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L844
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L845
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L845:
	add	r3, r3, #1
.L847:
	strb	r3, [r7, #1951]
	b	.L852
.L844:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	bgt	.L848
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
.L848:
	rsb	r3, r3, #255
	b	.L847
.L901:
	mov	r10, r7
	ldr	r7, [fp, #-60]
.L795:
	ldrb	r2, [r7, #1950]
	add	r10, r6, r10
	sub	ip, r2, #1
	ldrb	r1, [r10, #280]
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L812
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L813
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L813:
	add	r3, r3, #1
.L815:
	strb	r3, [r7, #1950]
	ldr	r10, [r5, #28]
	ldr	r8, [r5, #36]
	ldr	r4, [r5, #32]
	b	.L851
.L812:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	bgt	.L816
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
.L816:
	rsb	r3, r3, #255
	b	.L815
.L900:
	mov	r10, r7
	ldr	r7, [fp, #-60]
	add	r10, r10, #16
	b	.L827
.L899:
	mov	r10, r7
	ldr	r7, [fp, #-60]
	add	r10, r10, #16
	b	.L795
.L893:
	mov	r2, r10
	mov	r10, r7
	cmp	r10, #64
	ldr	r7, [fp, #-60]
	bgt	.L903
	add	r10, r10, #64
	b	.L795
.L898:
	mov	r2, r10
	mov	r10, r7
	cmp	r10, #64
	ldr	r7, [fp, #-60]
	addle	r10, r10, #64
	ble	.L827
.L904:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r10, r10, asl #1
	add	r4, r4, #1
	sub	r10, r10, #65
	movge	r0, r2
	blt	.L905
.L842:
	mov	r3, r4, asl #24
	cmp	r3, r0
	rsbls	r0, r3, r0
	ldrls	r2, [r5, #36]
	movls	r1, #1
	movhi	r1, #0
	add	r10, r10, r1
	rsbls	r4, r4, r2
	add	r10, r10, #64
	add	r3, r6, r4
	ldrb	r3, [r3, #24]
	mov	r2, r0, asl r3
	rsb	r9, r3, r9
	mov	r4, r4, asl r3
	str	r2, [r5, #28]
	str	r9, [r5, #32]
	str	r4, [r5, #36]
	b	.L827
.L903:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r10, r10, asl #1
	add	r4, r4, #1
	sub	r10, r10, #65
	movge	r0, r2
	blt	.L906
.L810:
	mov	r3, r4, asl #24
	cmp	r3, r0
	rsbls	r0, r3, r0
	ldrls	r2, [r5, #36]
	movls	r1, #1
	movhi	r1, #0
	add	r10, r10, r1
	rsbls	r4, r4, r2
	add	r10, r10, #64
	add	r3, r6, r4
	ldrb	r3, [r3, #24]
	mov	r2, r0, asl r3
	rsb	r9, r3, r9
	mov	r4, r4, asl r3
	str	r2, [r5, #28]
	str	r9, [r5, #32]
	str	r4, [r5, #36]
	b	.L795
.L802:
	add	r3, r6, r8
	mov	r10, #0
	mov	ip, #4
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	r2, #1
	mov	r3, r4, asl r1
	mov	r8, r8, asl r1
	rsb	r9, r1, r9
	str	r8, [r5, #36]
	mov	r4, r8
	str	r3, [r5, #28]
	str	r9, [r5, #32]
	mov	r10, r3
	mov	r8, ip
	b	.L806
.L804:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r8
	cmp	r1, r0
	sub	r8, r8, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r5, #36]
	movhi	ip, #0
	orr	r7, r7, ip
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r1, r6, r4
	ldrb	r1, [r1, #24]
	mov	r10, r0, asl r1
	rsb	r9, r1, r9
	mov	r4, r4, asl r1
	str	r10, [r5, #28]
	str	r9, [r5, #32]
	str	r4, [r5, #36]
	beq	.L907
.L806:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L804
	rsb	r1, r9, #24
	rsb	ip, r9, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	ip, r1, ip
	str	r2, [fp, #-56]
	str	ip, [fp, #-52]
	add	r9, r1, r9
	bl	BsGet
	ldr	ip, [fp, #-52]
	ldr	r2, [fp, #-56]
	and	ip, ip, #7
	orr	r0, r10, r0, asl ip
	b	.L804
.L834:
	add	r3, r6, r8
	mov	r10, #0
	mov	ip, #4
	str	r7, [fp, #-60]
	ldrb	r1, [r3, #24]
	mov	r7, r10
	mov	r2, #1
	mov	r3, r4, asl r1
	mov	r8, r8, asl r1
	rsb	r9, r1, r9
	str	r8, [r5, #36]
	mov	r4, r8
	str	r3, [r5, #28]
	str	r9, [r5, #32]
	mov	r10, r3
	mov	r8, ip
	b	.L838
.L836:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r8
	cmp	r1, r0
	sub	r8, r8, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r5, #36]
	movhi	ip, #0
	orr	r7, r7, ip
	rsbls	r4, r4, lr
	cmn	r8, #1
	add	r1, r6, r4
	ldrb	r1, [r1, #24]
	mov	r10, r0, asl r1
	rsb	r9, r1, r9
	mov	r4, r4, asl r1
	str	r10, [r5, #28]
	str	r9, [r5, #32]
	str	r4, [r5, #36]
	beq	.L908
.L838:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r10
	add	r4, r4, #1
	bge	.L836
	rsb	r1, r9, #24
	rsb	ip, r9, #16
	bic	r1, r1, #7
	mov	r0, r5
	rsb	ip, r1, ip
	str	r2, [fp, #-56]
	str	ip, [fp, #-52]
	add	r9, r1, r9
	bl	BsGet
	ldr	ip, [fp, #-52]
	ldr	r2, [fp, #-56]
	and	ip, ip, #7
	orr	r0, r10, r0, asl ip
	b	.L836
.L907:
	mov	r10, r7
	ldr	r7, [fp, #-60]
	add	r10, r10, #32
	b	.L795
.L908:
	mov	r10, r7
	ldr	r7, [fp, #-60]
	add	r10, r10, #32
	b	.L827
.L895:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-52]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-52]
	add	r4, r4, r3
	str	r4, [r5, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r5, #28]
	mov	r9, r0
	b	.L820
.L890:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-52]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-52]
	add	r4, r4, r3
	str	r4, [r5, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r5, #28]
	mov	r9, r0
	b	.L788
.L891:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-52]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-52]
	add	r4, r4, r3
	str	r4, [r5, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r5, #28]
	mov	r9, r0
	b	.L791
.L896:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r5
	rsb	r10, r3, r10
	str	r3, [fp, #-52]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-52]
	add	r4, r4, r3
	str	r4, [r5, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r5, #28]
	mov	r9, r0
	b	.L823
.L892:
	rsb	r2, r9, #24
	rsb	r10, r9, #16
	bic	r2, r2, #7
	mov	r0, r5
	rsb	r10, r2, r10
	str	r2, [fp, #-52]
	mov	r1, r2
	bl	BsGet
	and	r3, r10, #7
	ldr	r2, [fp, #-52]
	add	r9, r9, r2
	str	r9, [r5, #32]
	orr	r0, r4, r0, asl r3
	str	r0, [r5, #28]
	mov	r4, r0
	b	.L798
.L897:
	rsb	r2, r9, #24
	rsb	r10, r9, #16
	bic	r2, r2, #7
	mov	r0, r5
	rsb	r10, r2, r10
	str	r2, [fp, #-52]
	mov	r1, r2
	bl	BsGet
	and	r3, r10, #7
	ldr	r2, [fp, #-52]
	add	r9, r9, r2
	str	r9, [r5, #32]
	orr	r0, r4, r0, asl r3
	str	r0, [r5, #28]
	mov	r4, r0
	b	.L830
.L905:
	rsb	r1, r9, #24
	rsb	r8, r9, #16
	bic	r1, r1, #7
	mov	r0, r5
	str	r2, [fp, #-52]
	rsb	r8, r1, r8
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-52]
	and	r8, r8, #7
	orr	r0, r2, r0, asl r8
	b	.L842
.L906:
	rsb	r1, r9, #24
	rsb	r8, r9, #16
	bic	r1, r1, #7
	mov	r0, r5
	str	r2, [fp, #-52]
	rsb	r8, r1, r8
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-52]
	and	r8, r8, #7
	orr	r0, r2, r0, asl r8
	b	.L810
.L910:
	.align	2
.L909:
	.word	.LANCHOR0
	.fnend
	.size	Vp9_ReadSwitchableInterpProbs, .-Vp9_ReadSwitchableInterpProbs
	.align	2
	.global	Vp9_ReadCompPred
	.type	Vp9_ReadCompPred, %function
Vp9_ReadCompPred:
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
	cmp	r2, #0
	str	r0, [fp, #-56]
	mov	r6, r1
	str	r3, [fp, #-60]
	bne	.L1074
	ldr	r4, [r1, #28]
	ldr	r3, [r1, #36]
	ldr	r5, [r1, #32]
	ldr	r7, .L1104
	str	r2, [fp, #-52]
.L920:
	ldr	r2, [fp, #-56]
	mov	r9, r4
	mov	r10, r3
	add	r1, r2, #10
	str	r1, [fp, #-48]
	mov	r8, r2
.L983:
	sub	r10, r10, #1
	cmp	r5, #0
	mov	r2, r10, asl #8
	sub	r10, r2, r10, asl #2
	mov	r10, r10, lsr #8
	add	r10, r10, #1
	blt	.L1075
.L922:
	mov	r0, r10, asl #24
	cmp	r0, r9
	bhi	.L923
	ldr	r3, [r6, #36]
	rsb	r9, r0, r9
	rsb	r10, r10, r3
	add	r3, r7, r10
	ldrb	r3, [r3, #24]
	rsb	r4, r3, r5
	mov	r10, r10, asl r3
	sub	r5, r10, #1
	cmp	r4, #0
	ubfx	r5, r5, #1, #24
	mov	r9, r9, asl r3
	str	r10, [r6, #36]
	add	r5, r5, #1
	str	r4, [r6, #32]
	str	r9, [r6, #28]
	blt	.L1076
.L924:
	mov	r3, r5, asl #24
	cmp	r3, r9
	bhi	.L925
	ldr	r2, [r6, #36]
	rsb	r9, r3, r9
	rsb	r5, r5, r2
	add	r3, r7, r5
	ldrb	r0, [r3, #24]
	mov	r2, r5, asl r0
	rsb	r4, r0, r4
	sub	r5, r2, #1
	cmp	r4, #0
	ubfx	r5, r5, #1, #24
	mov	r9, r9, asl r0
	str	r2, [r6, #36]
	add	r5, r5, #1
	str	r4, [r6, #32]
	str	r9, [r6, #28]
	blt	.L1077
.L927:
	mov	r3, r5, asl #24
	cmp	r3, r9
	bhi	.L932
	ldr	r1, [r6, #36]
	rsb	r3, r3, r9
	rsb	r5, r5, r1
	add	r2, r7, r5
	ldrb	r2, [r2, #24]
	rsb	r9, r2, r4
	mov	r1, r5, asl r2
	sub	r5, r1, #1
	cmp	r9, #0
	ubfx	r5, r5, #1, #24
	mov	r4, r3, asl r2
	str	r1, [r6, #36]
	add	r5, r5, #1
	str	r9, [r6, #32]
	str	r4, [r6, #28]
	blt	.L1078
.L934:
	mov	r2, r5, asl #24
	cmp	r2, r4
	bhi	.L938
	ldr	r1, [r6, #36]
	rsb	r2, r2, r4
	mov	r3, #6
	str	r8, [fp, #-72]
	rsb	r5, r5, r1
	mov	r8, r7
	add	r1, r7, r5
	mov	r10, #0
	mov	ip, #1
	ldrb	r4, [r1, #24]
	mov	r2, r2, asl r4
	rsb	r9, r4, r9
	str	r2, [r6, #28]
	mov	r4, r5, asl r4
	str	r9, [r6, #32]
	mov	r5, r3
	str	r4, [r6, #36]
	mov	r7, r2
	b	.L939
.L943:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r5
	cmp	r2, r0
	sub	r5, r5, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r4, r4, lr
	cmn	r5, #1
	add	r2, r8, r4
	ldrb	r2, [r2, #24]
	mov	r7, r0, asl r2
	rsb	r9, r2, r9
	mov	r4, r4, asl r2
	str	r7, [r6, #28]
	str	r9, [r6, #32]
	str	r4, [r6, #36]
	beq	.L1079
.L939:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r7
	add	r4, r4, #1
	bge	.L943
	rsb	r1, r9, #24
	rsb	r2, r9, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-68]
	str	r2, [fp, #-64]
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-64]
	ldr	ip, [fp, #-68]
	and	r2, r2, #7
	orr	r0, r7, r0, asl r2
	b	.L943
.L923:
	add	r3, r7, r10
	ldrb	r3, [r3, #24]
	mov	r9, r9, asl r3
	rsb	r4, r3, r5
	mov	r10, r10, asl r3
	str	r9, [r6, #28]
	str	r4, [r6, #32]
	str	r10, [r6, #36]
.L1018:
	sub	r10, r10, #1
	cmp	r4, #0
	mov	r3, r10, asl #8
	sub	r10, r3, r10, asl #2
	mov	r10, r10, lsr #8
	add	r10, r10, #1
	blt	.L1080
.L952:
	mov	r0, r10, asl #24
	cmp	r0, r9
	bhi	.L953
	ldr	r3, [r6, #36]
	rsb	r9, r0, r9
	rsb	r10, r10, r3
	add	r3, r7, r10
	ldrb	r3, [r3, #24]
	mov	r10, r10, asl r3
	rsb	r4, r3, r4
	sub	r5, r10, #1
	cmp	r4, #0
	ubfx	r5, r5, #1, #24
	mov	r9, r9, asl r3
	str	r10, [r6, #36]
	add	r5, r5, #1
	str	r4, [r6, #32]
	str	r9, [r6, #28]
	blt	.L1081
.L954:
	mov	r3, r5, asl #24
	cmp	r3, r9
	bhi	.L955
	ldr	r2, [r6, #36]
	rsb	r9, r3, r9
	rsb	r5, r5, r2
	add	r3, r7, r5
	ldrb	r0, [r3, #24]
	mov	r2, r5, asl r0
	rsb	r4, r0, r4
	sub	r5, r2, #1
	cmp	r4, #0
	ubfx	r5, r5, #1, #24
	mov	r9, r9, asl r0
	str	r2, [r6, #36]
	add	r5, r5, #1
	str	r4, [r6, #32]
	str	r9, [r6, #28]
	blt	.L1082
.L957:
	mov	r3, r5, asl #24
	cmp	r3, r9
	bhi	.L962
	ldr	r1, [r6, #36]
	rsb	r3, r3, r9
	rsb	r5, r5, r1
	add	r2, r7, r5
	ldrb	r2, [r2, #24]
	rsb	r9, r2, r4
	mov	r1, r5, asl r2
	sub	r5, r1, #1
	cmp	r9, #0
	ubfx	r5, r5, #1, #24
	mov	r4, r3, asl r2
	str	r1, [r6, #36]
	add	r5, r5, #1
	str	r9, [r6, #32]
	str	r4, [r6, #28]
	blt	.L1083
.L964:
	mov	r2, r5, asl #24
	cmp	r2, r4
	bhi	.L968
	ldr	r1, [r6, #36]
	rsb	r2, r2, r4
	mov	r3, #6
	str	r8, [fp, #-72]
	rsb	r5, r5, r1
	mov	r8, r7
	add	r1, r7, r5
	mov	r10, #0
	mov	ip, #1
	ldrb	r4, [r1, #24]
	mov	r2, r2, asl r4
	rsb	r9, r4, r9
	str	r2, [r6, #28]
	mov	r4, r5, asl r4
	str	r9, [r6, #32]
	mov	r5, r3
	str	r4, [r6, #36]
	mov	r7, r2
	b	.L969
.L973:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r5
	cmp	r2, r0
	sub	r5, r5, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r4, r4, lr
	cmn	r5, #1
	add	r2, r8, r4
	ldrb	r2, [r2, #24]
	mov	r7, r0, asl r2
	rsb	r9, r2, r9
	mov	r4, r4, asl r2
	str	r7, [r6, #28]
	str	r9, [r6, #32]
	str	r4, [r6, #36]
	beq	.L1084
.L969:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r7
	add	r4, r4, #1
	bge	.L973
	rsb	r1, r9, #24
	rsb	r2, r9, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-68]
	str	r2, [fp, #-64]
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-64]
	ldr	ip, [fp, #-68]
	and	r2, r2, #7
	orr	r0, r7, r0, asl r2
	b	.L973
.L953:
	add	r3, r7, r10
	ldrb	r3, [r3, #24]
	mov	r9, r9, asl r3
	rsb	r4, r3, r4
	mov	r10, r10, asl r3
	str	r9, [r6, #28]
	str	r4, [r6, #32]
	str	r10, [r6, #36]
.L1019:
	ldr	r3, [fp, #-48]
	add	r8, r8, #2
	cmp	r8, r3
	ldrne	r9, [r6, #28]
	ldrne	r10, [r6, #36]
	ldrne	r5, [r6, #32]
	bne	.L983
.L982:
	ldr	r3, [fp, #-52]
	cmp	r3, #0
	bne	.L1085
.L1014:
	ldr	r3, [fp, #-60]
	ldr	r2, [fp, #-52]
	str	r2, [r3]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1085:
	ldr	r4, [r6, #28]
	ldr	r3, [r6, #36]
	ldr	r5, [r6, #32]
.L921:
	ldr	r2, [fp, #-56]
	mov	r10, r3
	add	r8, r2, #1984
	add	r2, r2, #2000
	add	r8, r8, #14
	add	r2, r2, #3
	str	r2, [fp, #-48]
.L1015:
	sub	r10, r10, #1
	cmp	r5, #0
	mov	r2, r10, asl #8
	sub	r10, r2, r10, asl #2
	mov	r10, r10, lsr #8
	add	r10, r10, #1
	blt	.L1086
.L984:
	mov	r9, r10, asl #24
	cmp	r9, r4
	bhi	.L985
	ldr	r3, [r6, #36]
	rsb	r9, r9, r4
	rsb	r10, r10, r3
	add	r3, r7, r10
	ldrb	r3, [r3, #24]
	mov	r10, r10, asl r3
	rsb	r5, r3, r5
	sub	r4, r10, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r9, r9, asl r3
	str	r10, [r6, #36]
	add	r4, r4, #1
	str	r5, [r6, #32]
	str	r9, [r6, #28]
	blt	.L1087
.L986:
	mov	r3, r4, asl #24
	cmp	r3, r9
	bhi	.L987
	ldr	r2, [r6, #36]
	rsb	r9, r3, r9
	rsb	r4, r4, r2
	add	r3, r7, r4
	ldrb	r0, [r3, #24]
	mov	r2, r4, asl r0
	rsb	r4, r0, r5
	cmp	r4, #0
	sub	r5, r2, #1
	ubfx	r5, r5, #1, #24
	mov	r9, r9, asl r0
	str	r2, [r6, #36]
	add	r5, r5, #1
	str	r4, [r6, #32]
	str	r9, [r6, #28]
	blt	.L1088
.L989:
	mov	r3, r5, asl #24
	cmp	r3, r9
	bhi	.L994
	ldr	r1, [r6, #36]
	rsb	r3, r3, r9
	rsb	r5, r5, r1
	add	r2, r7, r5
	ldrb	r2, [r2, #24]
	mov	r1, r5, asl r2
	rsb	r5, r2, r4
	sub	r9, r1, #1
	cmp	r5, #0
	ubfx	r9, r9, #1, #24
	mov	r4, r3, asl r2
	str	r1, [r6, #36]
	add	r9, r9, #1
	str	r5, [r6, #32]
	str	r4, [r6, #28]
	blt	.L1089
.L996:
	mov	r3, r9, asl #24
	cmp	r3, r4
	bhi	.L1000
	ldr	r1, [r6, #36]
	rsb	r0, r3, r4
	mov	r2, #6
	mov	r3, #0
	rsb	r4, r9, r1
	str	r8, [fp, #-68]
	add	r1, r7, r4
	mov	r8, r7
	mov	ip, #1
	mov	r7, r3
	ldrb	r1, [r1, #24]
	rsb	r10, r1, r5
	mov	r9, r0, asl r1
	mov	r4, r4, asl r1
	str	r9, [r6, #28]
	str	r10, [r6, #32]
	mov	r5, r2
	str	r4, [r6, #36]
	b	.L1001
.L1005:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r5
	cmp	r2, r0
	sub	r5, r5, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r7, r7, r1
	rsbls	r4, r4, lr
	cmn	r5, #1
	add	r2, r8, r4
	ldrb	r2, [r2, #24]
	mov	r9, r0, asl r2
	rsb	r10, r2, r10
	mov	r4, r4, asl r2
	str	r9, [r6, #28]
	str	r10, [r6, #32]
	str	r4, [r6, #36]
	beq	.L1090
.L1001:
	sub	r4, r4, #1
	cmp	r10, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r9
	add	r4, r4, #1
	bge	.L1005
	rsb	r1, r10, #24
	rsb	r2, r10, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-64]
	str	r2, [fp, #-56]
	add	r10, r1, r10
	bl	BsGet
	ldr	r2, [fp, #-56]
	ldr	ip, [fp, #-64]
	and	r2, r2, #7
	orr	r0, r9, r0, asl r2
	b	.L1005
.L962:
	add	r3, r7, r5
	mov	r2, #3
	str	r8, [fp, #-72]
	mov	r10, #0
	ldrb	r1, [r3, #24]
	mov	r8, r7
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r6, #28]
	mov	r5, r5, asl r1
	mov	r7, r9
	str	r4, [r6, #32]
	str	r5, [r6, #36]
	mov	r9, r2
	b	.L967
.L965:
	mov	r2, r5, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r5, r5, lr
	cmn	r9, #1
	add	r2, r8, r5
	ldrb	r2, [r2, #24]
	mov	r7, r0, asl r2
	rsb	r4, r2, r4
	mov	r5, r5, asl r2
	str	r7, [r6, #28]
	str	r4, [r6, #32]
	str	r5, [r6, #36]
	beq	.L1091
.L967:
	sub	r5, r5, #1
	cmp	r4, #0
	ubfx	r5, r5, #1, #24
	mov	r0, r7
	add	r5, r5, #1
	bge	.L965
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-68]
	str	r2, [fp, #-64]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-64]
	ldr	ip, [fp, #-68]
	and	r2, r2, #7
	orr	r0, r7, r0, asl r2
	b	.L965
.L932:
	add	r3, r7, r5
	mov	r2, #3
	str	r8, [fp, #-72]
	mov	r10, #0
	ldrb	r1, [r3, #24]
	mov	r8, r7
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r6, #28]
	mov	r5, r5, asl r1
	mov	r7, r9
	str	r4, [r6, #32]
	str	r5, [r6, #36]
	mov	r9, r2
	b	.L937
.L935:
	mov	r2, r5, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r5, r5, lr
	cmn	r9, #1
	add	r2, r8, r5
	ldrb	r2, [r2, #24]
	mov	r7, r0, asl r2
	rsb	r4, r2, r4
	mov	r5, r5, asl r2
	str	r7, [r6, #28]
	str	r4, [r6, #32]
	str	r5, [r6, #36]
	beq	.L1092
.L937:
	sub	r5, r5, #1
	cmp	r4, #0
	ubfx	r5, r5, #1, #24
	mov	r0, r7
	add	r5, r5, #1
	bge	.L935
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-68]
	str	r2, [fp, #-64]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-64]
	ldr	ip, [fp, #-68]
	and	r2, r2, #7
	orr	r0, r7, r0, asl r2
	b	.L935
.L985:
	add	r3, r7, r10
	ldrb	r3, [r3, #24]
	mov	r4, r4, asl r3
	rsb	r5, r3, r5
	mov	r10, r10, asl r3
	str	r4, [r6, #28]
	str	r5, [r6, #32]
	str	r10, [r6, #36]
.L1020:
	ldr	r3, [fp, #-48]
	add	r8, r8, #1
	cmp	r8, r3
	beq	.L1014
	add	r4, r6, #28
	ldmia	r4, {r4, r5, r10}
	b	.L1015
.L1080:
	rsb	r3, r4, #24
	rsb	r5, r4, #16
	bic	r3, r3, #7
	mov	r0, r6
	rsb	r5, r3, r5
	str	r3, [fp, #-64]
	mov	r1, r3
	and	r5, r5, #7
	bl	BsGet
	ldr	r3, [fp, #-64]
	add	r4, r3, r4
	str	r4, [r6, #32]
	orr	r0, r9, r0, asl r5
	str	r0, [r6, #28]
	mov	r9, r0
	b	.L952
.L1075:
	rsb	r2, r5, #24
	rsb	r4, r5, #16
	bic	r2, r2, #7
	mov	r0, r6
	rsb	r4, r2, r4
	str	r2, [fp, #-64]
	mov	r1, r2
	bl	BsGet
	ldr	r2, [fp, #-64]
	and	r3, r4, #7
	add	r4, r2, r5
	str	r4, [r6, #32]
	mov	r5, r4
	orr	r0, r9, r0, asl r3
	str	r0, [r6, #28]
	mov	r9, r0
	b	.L922
.L955:
	add	r3, r7, r5
	mov	r2, #3
	str	r8, [fp, #-72]
	mov	r10, #0
	ldrb	r1, [r3, #24]
	mov	r8, r7
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r6, #28]
	mov	r5, r5, asl r1
	mov	r7, r9
	str	r4, [r6, #32]
	str	r5, [r6, #36]
	mov	r9, r2
	b	.L960
.L958:
	mov	r2, r5, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r5, r5, lr
	cmn	r9, #1
	add	r2, r8, r5
	ldrb	r2, [r2, #24]
	mov	r7, r0, asl r2
	rsb	r4, r2, r4
	mov	r5, r5, asl r2
	str	r7, [r6, #28]
	str	r4, [r6, #32]
	str	r5, [r6, #36]
	beq	.L1093
.L960:
	sub	r5, r5, #1
	cmp	r4, #0
	ubfx	r5, r5, #1, #24
	mov	r0, r7
	add	r5, r5, #1
	bge	.L958
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-68]
	str	r2, [fp, #-64]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-64]
	ldr	ip, [fp, #-68]
	and	r2, r2, #7
	orr	r0, r7, r0, asl r2
	b	.L958
.L925:
	add	r3, r7, r5
	mov	r2, #3
	str	r8, [fp, #-72]
	mov	r10, #0
	ldrb	r1, [r3, #24]
	mov	r8, r7
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r6, #28]
	mov	r5, r5, asl r1
	mov	r7, r9
	str	r4, [r6, #32]
	str	r5, [r6, #36]
	mov	r9, r2
	b	.L930
.L928:
	mov	r2, r5, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r5, r5, lr
	cmn	r9, #1
	add	r2, r8, r5
	ldrb	r2, [r2, #24]
	mov	r7, r0, asl r2
	rsb	r4, r2, r4
	mov	r5, r5, asl r2
	str	r7, [r6, #28]
	str	r4, [r6, #32]
	str	r5, [r6, #36]
	beq	.L1094
.L930:
	sub	r5, r5, #1
	cmp	r4, #0
	ubfx	r5, r5, #1, #24
	mov	r0, r7
	add	r5, r5, #1
	bge	.L928
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-68]
	str	r2, [fp, #-64]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-64]
	ldr	ip, [fp, #-68]
	and	r2, r2, #7
	orr	r0, r7, r0, asl r2
	b	.L928
.L1086:
	rsb	r3, r5, #24
	rsb	r9, r5, #16
	bic	r3, r3, #7
	mov	r0, r6
	rsb	r9, r3, r9
	str	r3, [fp, #-56]
	mov	r1, r3
	and	r9, r9, #7
	bl	BsGet
	ldr	r3, [fp, #-56]
	add	r5, r3, r5
	str	r5, [r6, #32]
	orr	r0, r4, r0, asl r9
	str	r0, [r6, #28]
	mov	r4, r0
	b	.L984
.L1094:
	mov	r7, r8
	ldr	r8, [fp, #-72]
.L931:
	ldrb	r2, [r8, #1988]
	add	r10, r7, r10
	sub	ip, r2, #1
	ldrb	r1, [r10, #280]
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L946
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L947
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L947:
	add	r3, r3, #1
.L949:
	strb	r3, [r8, #1988]
	ldr	r9, [r6, #28]
	ldr	r10, [r6, #36]
	ldr	r4, [r6, #32]
	b	.L1018
.L946:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	bgt	.L950
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
.L950:
	rsb	r3, r3, #255
	b	.L949
.L1093:
	mov	r7, r8
	ldr	r8, [fp, #-72]
.L961:
	ldrb	r2, [r8, #1989]
	add	r10, r7, r10
	sub	ip, r2, #1
	ldrb	r1, [r10, #280]
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L976
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L977
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L977:
	add	r3, r3, #1
.L979:
	strb	r3, [r8, #1989]
	b	.L1019
.L976:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	bgt	.L980
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
.L980:
	rsb	r3, r3, #255
	b	.L979
.L987:
	add	r3, r7, r4
	mov	r2, #3
	str	r8, [fp, #-68]
	mov	r10, #0
	ldrb	r1, [r3, #24]
	mov	r8, r7
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r5, r1, r5
	str	r9, [r6, #28]
	mov	r4, r4, asl r1
	mov	r7, r9
	str	r5, [r6, #32]
	str	r4, [r6, #36]
	mov	r9, r2
	b	.L992
.L990:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r4, r4, lr
	cmn	r9, #1
	add	r2, r8, r4
	ldrb	r2, [r2, #24]
	mov	r7, r0, asl r2
	rsb	r5, r2, r5
	mov	r4, r4, asl r2
	str	r7, [r6, #28]
	str	r5, [r6, #32]
	str	r4, [r6, #36]
	beq	.L1095
.L992:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r7
	add	r4, r4, #1
	bge	.L990
	rsb	r1, r5, #24
	rsb	r2, r5, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-64]
	str	r2, [fp, #-56]
	add	r5, r1, r5
	bl	BsGet
	ldr	r2, [fp, #-56]
	ldr	ip, [fp, #-64]
	and	r2, r2, #7
	orr	r0, r7, r0, asl r2
	b	.L990
.L1095:
	mov	r7, r8
	ldr	r8, [fp, #-68]
.L993:
	ldrb	r2, [r8]
	add	r10, r7, r10
	sub	ip, r2, #1
	ldrb	r1, [r10, #280]
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L1008
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L1009
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L1009:
	add	r3, r3, #1
.L1011:
	strb	r3, [r8]
	b	.L1020
.L1008:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	bgt	.L1012
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
.L1012:
	rsb	r3, r3, #255
	b	.L1011
.L1074:
	ldr	r8, [r1, #36]
	ldr	r5, [r1, #32]
	sub	r8, r8, #1
	cmp	r5, #0
	ubfx	r8, r8, #1, #24
	add	r8, r8, #1
	blt	.L913
	ldr	r0, [r1, #28]
.L914:
	mov	r4, r8, asl #24
	cmp	r4, r0
	bhi	.L915
	ldr	r3, [r6, #36]
	rsb	r4, r4, r0
	ldr	r7, .L1104
	mov	r1, #128
	rsb	r8, r8, r3
	mov	r0, r6
	add	r3, r7, r8
	ldrb	r3, [r3, #24]
	mov	r4, r4, asl r3
	rsb	r5, r3, r5
	mov	r8, r8, asl r3
	str	r4, [r6, #28]
	str	r5, [r6, #32]
	str	r8, [r6, #36]
	bl	Vp9_Cabac_Read
	ldr	r4, [r6, #28]
	ldr	r3, [r6, #36]
	ldr	r5, [r6, #32]
	add	r2, r0, #1
	str	r2, [fp, #-52]
	cmp	r2, #2
	bne	.L916
	ldr	r2, [fp, #-56]
	add	r10, r2, #1968
	add	r9, r2, #1984
	add	r10, r10, #15
	add	r9, r9, #4
	b	.L919
.L1097:
	ldr	r3, [r6, #36]
	rsb	r8, r8, r3
	add	r3, r7, r8
	ldrb	r3, [r3, #24]
	rsb	r5, r3, r5
	mov	r2, r2, asl r3
	mov	r8, r8, asl r3
	str	r5, [r6, #32]
	str	r2, [r6, #28]
	str	r8, [r6, #36]
	bl	Vp9_DiffUpdateProb
	ldr	r4, [r6, #28]
	ldr	r3, [r6, #36]
	ldr	r5, [r6, #32]
.L1017:
	add	r10, r10, #1
	cmp	r10, r9
	beq	.L920
.L919:
	sub	r8, r3, #1
	cmp	r5, #0
	mov	r3, r8, asl #8
	sub	r8, r3, r8, asl #2
	mov	r8, r8, lsr #8
	add	r8, r8, #1
	blt	.L1096
.L917:
	mov	r3, r8, asl #24
	mov	r1, r10
	cmp	r3, r4
	mov	r0, r6
	rsb	r2, r3, r4
	bls	.L1097
	add	r3, r7, r8
	ldrb	r3, [r3, #24]
	mov	r4, r4, asl r3
	rsb	r5, r3, r5
	str	r4, [r6, #28]
	mov	r3, r8, asl r3
	str	r5, [r6, #32]
	str	r3, [r6, #36]
	b	.L1017
.L1091:
	mov	r7, r8
	add	r10, r10, #16
	ldr	r8, [fp, #-72]
	b	.L961
.L1092:
	mov	r7, r8
	add	r10, r10, #16
	ldr	r8, [fp, #-72]
	b	.L931
.L1084:
	cmp	r10, #64
	mov	r7, r8
	ldr	r8, [fp, #-72]
	bgt	.L1098
.L975:
	add	r10, r10, #64
	b	.L961
.L1079:
	cmp	r10, #64
	mov	r7, r8
	ldr	r8, [fp, #-72]
	bgt	.L1099
.L945:
	add	r10, r10, #64
	b	.L931
.L994:
	add	r3, r7, r5
	mov	r2, #3
	str	r8, [fp, #-68]
	mov	r10, #0
	ldrb	r1, [r3, #24]
	mov	r8, r7
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r6, #28]
	mov	r5, r5, asl r1
	mov	r7, r9
	str	r4, [r6, #32]
	str	r5, [r6, #36]
	mov	r9, r2
	b	.L999
.L997:
	mov	r2, r5, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r5, r5, lr
	cmn	r9, #1
	add	r2, r8, r5
	ldrb	r2, [r2, #24]
	mov	r7, r0, asl r2
	rsb	r4, r2, r4
	mov	r5, r5, asl r2
	str	r7, [r6, #28]
	str	r4, [r6, #32]
	str	r5, [r6, #36]
	beq	.L1100
.L999:
	sub	r5, r5, #1
	cmp	r4, #0
	ubfx	r5, r5, #1, #24
	mov	r0, r7
	add	r5, r5, #1
	bge	.L997
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-64]
	str	r2, [fp, #-56]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-56]
	ldr	ip, [fp, #-64]
	and	r2, r2, #7
	orr	r0, r7, r0, asl r2
	b	.L997
.L1105:
	.align	2
.L1104:
	.word	.LANCHOR0
.L915:
	ldr	r7, .L1104
	mov	r3, #0
	str	r3, [fp, #-52]
	add	r3, r7, r8
	ldrb	r3, [r3, #24]
	mov	r4, r0, asl r3
	rsb	r5, r3, r5
	str	r4, [r6, #28]
	mov	r3, r8, asl r3
	str	r5, [r6, #32]
	str	r3, [r6, #36]
	b	.L920
.L1098:
	mov	r1, #128
	mov	r0, r6
	bl	Vp9_Cabac_Read
	add	r0, r0, r10, lsl #1
	sub	r10, r0, #65
	b	.L975
.L1099:
	mov	r1, #128
	mov	r0, r6
	bl	Vp9_Cabac_Read
	add	r0, r0, r10, lsl #1
	sub	r10, r0, #65
	b	.L945
.L1100:
	mov	r7, r8
	add	r10, r10, #16
	ldr	r8, [fp, #-68]
	b	.L993
.L1096:
	rsb	r2, r5, #24
	rsb	r3, r5, #16
	bic	r2, r2, #7
	mov	r0, r6
	rsb	r3, r2, r3
	str	r2, [fp, #-48]
	mov	r1, r2
	str	r3, [fp, #-64]
	bl	BsGet
	ldr	r3, [fp, #-64]
	ldr	r2, [fp, #-48]
	and	r3, r3, #7
	add	r5, r2, r5
	str	r5, [r6, #32]
	orr	r0, r4, r0, asl r3
	str	r0, [r6, #28]
	mov	r4, r0
	b	.L917
.L1090:
	mov	r3, r7
	cmp	r3, #64
	mov	r7, r8
	ldr	r8, [fp, #-68]
	movle	r10, r3
	ble	.L1007
	mov	r1, #128
	mov	r0, r6
	str	r3, [fp, #-56]
	bl	Vp9_Cabac_Read
	ldr	r3, [fp, #-56]
	add	r0, r0, r3, lsl #1
	sub	r10, r0, #65
.L1007:
	add	r10, r10, #64
	b	.L993
.L938:
	add	r3, r7, r5
	mov	ip, #4
	str	r8, [fp, #-72]
	mov	r10, #0
	ldrb	r1, [r3, #24]
	mov	r8, r7
	mov	r2, #1
	mov	r3, r4, asl r1
	mov	r5, r5, asl r1
	rsb	r9, r1, r9
	str	r5, [r6, #36]
	mov	r4, r5
	str	r3, [r6, #28]
	str	r9, [r6, #32]
	mov	r5, ip
	mov	r7, r3
	b	.L942
.L940:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r5
	cmp	r1, r0
	sub	r5, r5, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r6, #36]
	movhi	ip, #0
	orr	r10, r10, ip
	rsbls	r4, r4, lr
	cmn	r5, #1
	add	r1, r8, r4
	ldrb	r1, [r1, #24]
	mov	r7, r0, asl r1
	rsb	r9, r1, r9
	mov	r4, r4, asl r1
	str	r7, [r6, #28]
	str	r9, [r6, #32]
	str	r4, [r6, #36]
	beq	.L1101
.L942:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r7
	add	r4, r4, #1
	bge	.L940
	rsb	r1, r9, #24
	rsb	ip, r9, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	ip, r1, ip
	str	r2, [fp, #-68]
	str	ip, [fp, #-64]
	add	r9, r1, r9
	bl	BsGet
	ldr	ip, [fp, #-64]
	ldr	r2, [fp, #-68]
	and	ip, ip, #7
	orr	r0, r7, r0, asl ip
	b	.L940
.L968:
	add	r3, r7, r5
	mov	ip, #4
	str	r8, [fp, #-72]
	mov	r10, #0
	ldrb	r1, [r3, #24]
	mov	r8, r7
	mov	r2, #1
	mov	r3, r4, asl r1
	mov	r5, r5, asl r1
	rsb	r9, r1, r9
	str	r5, [r6, #36]
	mov	r4, r5
	str	r3, [r6, #28]
	str	r9, [r6, #32]
	mov	r5, ip
	mov	r7, r3
	b	.L972
.L970:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r5
	cmp	r1, r0
	sub	r5, r5, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r6, #36]
	movhi	ip, #0
	orr	r10, r10, ip
	rsbls	r4, r4, lr
	cmn	r5, #1
	add	r1, r8, r4
	ldrb	r1, [r1, #24]
	mov	r7, r0, asl r1
	rsb	r9, r1, r9
	mov	r4, r4, asl r1
	str	r7, [r6, #28]
	str	r9, [r6, #32]
	str	r4, [r6, #36]
	beq	.L1102
.L972:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r7
	add	r4, r4, #1
	bge	.L970
	rsb	r1, r9, #24
	rsb	ip, r9, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	ip, r1, ip
	str	r2, [fp, #-68]
	str	ip, [fp, #-64]
	add	r9, r1, r9
	bl	BsGet
	ldr	ip, [fp, #-64]
	ldr	r2, [fp, #-68]
	and	ip, ip, #7
	orr	r0, r7, r0, asl ip
	b	.L970
.L1102:
	mov	r7, r8
	add	r10, r10, #32
	ldr	r8, [fp, #-72]
	b	.L961
.L1101:
	mov	r7, r8
	add	r10, r10, #32
	ldr	r8, [fp, #-72]
	b	.L931
.L1081:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r6
	rsb	r10, r3, r10
	str	r3, [fp, #-64]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-64]
	add	r4, r4, r3
	str	r4, [r6, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r6, #28]
	mov	r9, r0
	b	.L954
.L1076:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r6
	rsb	r10, r3, r10
	str	r3, [fp, #-64]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-64]
	add	r4, r4, r3
	str	r4, [r6, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r6, #28]
	mov	r9, r0
	b	.L924
.L1000:
	add	r3, r7, r9
	mov	r2, #4
	str	r8, [fp, #-68]
	mov	r10, #0
	ldrb	r1, [r3, #24]
	mov	r8, r7
	mov	ip, #1
	mov	r3, r4, asl r1
	mov	r9, r9, asl r1
	rsb	r5, r1, r5
	str	r9, [r6, #36]
	mov	r4, r9
	str	r3, [r6, #28]
	str	r5, [r6, #32]
	mov	r9, r2
	mov	r7, r3
	b	.L1004
.L1002:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r4, r4, lr
	cmn	r9, #1
	add	r2, r8, r4
	ldrb	r2, [r2, #24]
	mov	r7, r0, asl r2
	rsb	r5, r2, r5
	mov	r4, r4, asl r2
	str	r7, [r6, #28]
	str	r5, [r6, #32]
	str	r4, [r6, #36]
	beq	.L1103
.L1004:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r7
	add	r4, r4, #1
	bge	.L1002
	rsb	r1, r5, #24
	rsb	r2, r5, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-64]
	str	r2, [fp, #-56]
	add	r5, r1, r5
	bl	BsGet
	ldr	r2, [fp, #-56]
	ldr	ip, [fp, #-64]
	and	r2, r2, #7
	orr	r0, r7, r0, asl r2
	b	.L1002
.L1103:
	mov	r7, r8
	add	r10, r10, #32
	ldr	r8, [fp, #-68]
	b	.L993
.L1087:
	rsb	r2, r5, #24
	rsb	r10, r5, #16
	bic	r2, r2, #7
	mov	r0, r6
	rsb	r10, r2, r10
	str	r2, [fp, #-56]
	mov	r1, r2
	bl	BsGet
	and	r3, r10, #7
	ldr	r2, [fp, #-56]
	add	r5, r5, r2
	str	r5, [r6, #32]
	orr	r0, r9, r0, asl r3
	str	r0, [r6, #28]
	mov	r9, r0
	b	.L986
.L1077:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r6
	rsb	r10, r3, r10
	str	r3, [fp, #-64]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-64]
	add	r4, r4, r3
	str	r4, [r6, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r6, #28]
	mov	r9, r0
	b	.L927
.L1082:
	rsb	r3, r4, #24
	rsb	r10, r4, #16
	bic	r3, r3, #7
	mov	r0, r6
	rsb	r10, r3, r10
	str	r3, [fp, #-64]
	mov	r1, r3
	and	r10, r10, #7
	bl	BsGet
	ldr	r3, [fp, #-64]
	add	r4, r4, r3
	str	r4, [r6, #32]
	orr	r0, r9, r0, asl r10
	str	r0, [r6, #28]
	mov	r9, r0
	b	.L957
.L1088:
	rsb	r2, r4, #24
	rsb	r10, r4, #16
	bic	r2, r2, #7
	mov	r0, r6
	rsb	r10, r2, r10
	str	r2, [fp, #-56]
	mov	r1, r2
	bl	BsGet
	and	r3, r10, #7
	ldr	r2, [fp, #-56]
	add	r4, r4, r2
	str	r4, [r6, #32]
	orr	r0, r9, r0, asl r3
	str	r0, [r6, #28]
	mov	r9, r0
	b	.L989
.L1083:
	rsb	r2, r9, #24
	rsb	r10, r9, #16
	bic	r2, r2, #7
	mov	r0, r6
	rsb	r10, r2, r10
	str	r2, [fp, #-64]
	mov	r1, r2
	bl	BsGet
	and	r3, r10, #7
	ldr	r2, [fp, #-64]
	add	r9, r9, r2
	str	r9, [r6, #32]
	orr	r0, r4, r0, asl r3
	str	r0, [r6, #28]
	mov	r4, r0
	b	.L964
.L1078:
	rsb	r2, r9, #24
	rsb	r10, r9, #16
	bic	r2, r2, #7
	mov	r0, r6
	rsb	r10, r2, r10
	str	r2, [fp, #-64]
	mov	r1, r2
	bl	BsGet
	and	r3, r10, #7
	ldr	r2, [fp, #-64]
	add	r9, r9, r2
	str	r9, [r6, #32]
	orr	r0, r4, r0, asl r3
	str	r0, [r6, #28]
	mov	r4, r0
	b	.L934
.L1089:
	rsb	r2, r5, #24
	rsb	r10, r5, #16
	bic	r2, r2, #7
	mov	r0, r6
	rsb	r10, r2, r10
	str	r2, [fp, #-56]
	mov	r1, r2
	bl	BsGet
	ldr	r2, [fp, #-56]
	and	r3, r10, #7
	add	r10, r5, r2
	str	r10, [r6, #32]
	mov	r5, r10
	orr	r0, r4, r0, asl r3
	str	r0, [r6, #28]
	mov	r4, r0
	b	.L996
.L913:
	rsb	r7, r5, #24
	ldr	r4, [r1, #28]
	bic	r7, r7, #7
	mov	r0, r1
	rsb	r9, r5, #16
	add	r5, r5, r7
	mov	r1, r7
	rsb	r9, r7, r9
	bl	BsGet
	and	r9, r9, #7
	str	r5, [r6, #32]
	orr	r0, r4, r0, asl r9
	str	r0, [r6, #28]
	b	.L914
.L916:
	ldr	r2, [fp, #-52]
	cmp	r2, #1
	beq	.L921
	b	.L920
	.fnend
	.size	Vp9_ReadCompPred, .-Vp9_ReadCompPred
	.align	2
	.global	Vp9_ReadMvProbs
	.type	Vp9_ReadMvProbs, %function
Vp9_ReadMvProbs:
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
	ldr	r4, [r0, #36]
	mov	r3, r1
	ldr	r5, [r0, #32]
	mov	ip, r0
	ldr	r6, [r0, #28]
	mov	r9, r3
	mov	r7, r0
	str	r1, [fp, #-76]
	str	r2, [fp, #-80]
	add	r1, r1, #3
	str	r3, [fp, #-84]
	str	r1, [fp, #-48]
.L1112:
	sub	r3, r4, #1
	cmp	r5, #0
	mov	r4, r3, asl #8
	sub	r3, r4, r3, asl #2
	mov	r3, r3, lsr #8
	add	r4, r3, #1
	blt	.L1211
.L1107:
	mov	r2, r4, asl #24
	cmp	r2, r6
	bhi	.L1108
	ldr	r3, [r7, #36]
	rsb	r6, r2, r6
	ldr	r1, .L1229
	mov	r10, #0
	rsb	r3, r4, r3
	mov	r8, #6
	add	r1, r1, r3
	mov	r2, #1
	str	r9, [fp, #-56]
	ldrb	r4, [r1, #24]
	mov	r6, r6, asl r4
	rsb	r5, r4, r5
	str	r6, [r7, #28]
	mov	r4, r3, asl r4
	str	r5, [r7, #32]
	str	r4, [r7, #36]
	b	.L1111
.L1109:
	mov	r3, r4, asl #24
	mov	r1, r2, asl r8
	cmp	r3, r0
	sub	r8, r8, #1
	rsbls	r0, r3, r0
	ldr	r3, .L1229
	ldrls	ip, [r7, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r4, r4, ip
	cmn	r8, #1
	add	r3, r3, r4
	ldrb	r3, [r3, #24]
	mov	r6, r0, asl r3
	rsb	r5, r3, r5
	mov	r4, r4, asl r3
	str	r6, [r7, #28]
	str	r5, [r7, #32]
	str	r4, [r7, #36]
	beq	.L1212
.L1111:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r6
	add	r4, r4, #1
	bge	.L1109
	rsb	r1, r5, #24
	rsb	r3, r5, #16
	bic	r1, r1, #7
	mov	r0, r7
	str	r2, [fp, #-52]
	rsb	r9, r1, r3
	add	r5, r1, r5
	bl	BsGet
	and	r3, r9, #7
	ldr	r2, [fp, #-52]
	orr	r0, r6, r0, asl r3
	b	.L1109
.L1108:
	ldr	r3, .L1229
	add	r3, r3, r4
	ldrb	r3, [r3, #24]
	mov	r6, r6, asl r3
	rsb	r5, r3, r5
	mov	r4, r4, asl r3
	str	r6, [r7, #28]
	str	r5, [r7, #32]
	str	r4, [r7, #36]
.L1165:
	ldr	r3, [fp, #-48]
	add	r9, r9, #1
	cmp	r9, r3
	bne	.L1112
	ldr	r3, [fp, #-76]
	mov	ip, r7
	add	r2, r3, #25
	add	r3, r3, #91
	str	r2, [fp, #-48]
	str	r3, [fp, #-64]
.L1135:
	sub	r4, r4, #1
	cmp	r5, #0
	mov	r3, r4, asl #8
	sub	r4, r3, r4, asl #2
	mov	r4, r4, lsr #8
	add	r4, r4, #1
	blt	.L1213
.L1113:
	mov	r2, r4, asl #24
	cmp	r2, r6
	bhi	.L1114
	ldr	r3, [r7, #36]
	rsb	r6, r2, r6
	mov	r9, #0
	mov	r8, #6
	rsb	r4, r4, r3
	ldr	r3, .L1229
	mov	r10, #1
	add	r3, r3, r4
	ldrb	r3, [r3, #24]
	mov	r6, r6, asl r3
	rsb	r5, r3, r5
	mov	r4, r4, asl r3
	str	r6, [r7, #28]
	str	r5, [r7, #32]
	str	r4, [r7, #36]
	b	.L1117
.L1115:
	mov	r3, r4, asl #24
	mov	r2, r10, asl r8
	cmp	r3, r0
	sub	r8, r8, #1
	rsbls	r0, r3, r0
	ldr	r3, .L1229
	ldrls	r1, [r7, #36]
	movhi	r2, #0
	orr	r9, r9, r2
	rsbls	r4, r4, r1
	cmn	r8, #1
	add	r3, r3, r4
	ldrb	r3, [r3, #24]
	mov	r6, r0, asl r3
	rsb	r5, r3, r5
	mov	r4, r4, asl r3
	str	r6, [r7, #28]
	str	r5, [r7, #32]
	str	r4, [r7, #36]
	beq	.L1214
.L1117:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r6
	add	r4, r4, #1
	bge	.L1115
	rsb	r1, r5, #24
	rsb	r3, r5, #16
	bic	r1, r1, #7
	mov	r0, r7
	rsb	r3, r1, r3
	add	r5, r1, r5
	str	r3, [fp, #-52]
	bl	BsGet
	ldr	r3, [fp, #-52]
	and	r3, r3, #7
	orr	r0, r6, r0, asl r3
	b	.L1115
.L1212:
	ldr	r9, [fp, #-56]
	mov	r3, r10, asl #1
	orr	r3, r3, #1
	strb	r3, [r9]
	ldr	r4, [r7, #36]
	ldr	r5, [r7, #32]
	ldr	r6, [r7, #28]
	b	.L1165
.L1114:
	ldr	r3, .L1229
	add	r3, r3, r4
	ldrb	r3, [r3, #24]
	mov	r6, r6, asl r3
	rsb	r5, r3, r5
	mov	r4, r4, asl r3
	str	r6, [r7, #28]
	str	r5, [r7, #32]
	str	r4, [r7, #36]
.L1166:
	ldr	r3, [fp, #-48]
	sub	r10, r3, #21
	sub	r3, r3, #11
	str	r3, [fp, #-52]
	mov	r9, r10
.L1123:
	sub	r4, r4, #1
	cmp	r5, #0
	mov	r3, r4, asl #8
	sub	r4, r3, r4, asl #2
	mov	r4, r4, lsr #8
	add	r4, r4, #1
	blt	.L1215
.L1118:
	mov	r2, r4, asl #24
	cmp	r2, r6
	bhi	.L1119
	ldr	r3, [r7, #36]
	rsb	r6, r2, r6
	ldr	r1, .L1229
	mov	r10, #0
	rsb	r3, r4, r3
	mov	r8, #6
	add	r1, r1, r3
	mov	r2, #1
	str	r9, [fp, #-60]
	ldrb	r4, [r1, #24]
	mov	r6, r6, asl r4
	rsb	r5, r4, r5
	str	r6, [r7, #28]
	mov	r4, r3, asl r4
	str	r5, [r7, #32]
	str	r4, [r7, #36]
	b	.L1122
.L1120:
	mov	r3, r4, asl #24
	mov	r1, r2, asl r8
	cmp	r3, r0
	sub	r8, r8, #1
	rsbls	r0, r3, r0
	ldr	r3, .L1229
	ldrls	ip, [r7, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r4, r4, ip
	cmn	r8, #1
	add	r3, r3, r4
	ldrb	r3, [r3, #24]
	mov	r6, r0, asl r3
	rsb	r5, r3, r5
	mov	r4, r4, asl r3
	str	r6, [r7, #28]
	str	r5, [r7, #32]
	str	r4, [r7, #36]
	beq	.L1216
.L1122:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r6
	add	r4, r4, #1
	bge	.L1120
	rsb	r1, r5, #24
	rsb	r3, r5, #16
	bic	r1, r1, #7
	mov	r0, r7
	str	r2, [fp, #-56]
	rsb	r9, r1, r3
	add	r5, r1, r5
	bl	BsGet
	and	r3, r9, #7
	ldr	r2, [fp, #-56]
	orr	r0, r6, r0, asl r3
	b	.L1120
.L1119:
	ldr	r3, .L1229
	add	r3, r3, r4
	ldrb	r3, [r3, #24]
	mov	r6, r6, asl r3
	rsb	r5, r3, r5
	mov	r4, r4, asl r3
	str	r6, [r7, #28]
	str	r5, [r7, #32]
	str	r4, [r7, #36]
.L1167:
	ldr	r3, [fp, #-52]
	add	r9, r9, #1
	cmp	r9, r3
	bne	.L1123
	sub	r4, r4, #1
	cmp	r5, #0
	mov	r3, r4, asl #8
	sub	r4, r3, r4, asl #2
	mov	r4, r4, lsr #8
	add	r4, r4, #1
	blt	.L1217
.L1124:
	mov	r2, r4, asl #24
	cmp	r2, r6
	bhi	.L1125
	ldr	r3, [r7, #36]
	rsb	r6, r2, r6
	mov	r9, #0
	mov	r8, #6
	rsb	r4, r4, r3
	ldr	r3, .L1229
	mov	r10, #1
	add	r3, r3, r4
	ldrb	r3, [r3, #24]
	mov	r6, r6, asl r3
	rsb	r5, r3, r5
	mov	r4, r4, asl r3
	str	r6, [r7, #28]
	str	r5, [r7, #32]
	str	r4, [r7, #36]
	b	.L1128
.L1126:
	mov	r3, r4, asl #24
	mov	r2, r10, asl r8
	cmp	r3, r0
	sub	r8, r8, #1
	rsbls	r0, r3, r0
	ldr	r3, .L1229
	ldrls	r1, [r7, #36]
	movhi	r2, #0
	orr	r9, r9, r2
	rsbls	r4, r4, r1
	cmn	r8, #1
	add	r3, r3, r4
	ldrb	r3, [r3, #24]
	mov	r6, r0, asl r3
	rsb	r5, r3, r5
	mov	r4, r4, asl r3
	str	r6, [r7, #28]
	str	r5, [r7, #32]
	str	r4, [r7, #36]
	beq	.L1218
.L1128:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r6
	add	r4, r4, #1
	bge	.L1126
	rsb	r1, r5, #24
	rsb	r3, r5, #16
	bic	r1, r1, #7
	mov	r0, r7
	rsb	r3, r1, r3
	add	r5, r1, r5
	str	r3, [fp, #-52]
	bl	BsGet
	ldr	r3, [fp, #-52]
	and	r3, r3, #7
	orr	r0, r6, r0, asl r3
	b	.L1126
.L1216:
	ldr	r9, [fp, #-60]
	mov	r10, r10, asl #1
	orr	r10, r10, #1
	strb	r10, [r9]
	ldr	r4, [r7, #36]
	ldr	r5, [r7, #32]
	ldr	r6, [r7, #28]
	b	.L1167
.L1215:
	rsb	r10, r5, #24
	mov	r0, r7
	bic	r10, r10, #7
	rsb	r8, r5, #16
	rsb	r8, r10, r8
	add	r5, r10, r5
	mov	r1, r10
	and	r8, r8, #7
	bl	BsGet
	str	r5, [r7, #32]
	orr	r0, r6, r0, asl r8
	str	r0, [r7, #28]
	mov	r6, r0
	b	.L1118
.L1125:
	ldr	r3, .L1229
	add	r3, r3, r4
	ldrb	r3, [r3, #24]
	mov	r6, r6, asl r3
	rsb	r5, r3, r5
	mov	r4, r4, asl r3
	str	r6, [r7, #28]
	str	r5, [r7, #32]
	str	r4, [r7, #36]
.L1168:
	ldr	r3, [fp, #-48]
	sub	r2, r3, #10
	mov	r9, r2
.L1134:
	sub	r4, r4, #1
	cmp	r5, #0
	mov	r3, r4, asl #8
	sub	r4, r3, r4, asl #2
	mov	r4, r4, lsr #8
	add	r4, r4, #1
	blt	.L1219
.L1129:
	mov	r1, r4, asl #24
	cmp	r1, r6
	bhi	.L1130
	ldr	r3, [r7, #36]
	rsb	r6, r1, r6
	ldr	r2, .L1229
	mov	r10, #0
	rsb	r3, r4, r3
	mov	r8, #6
	add	r1, r2, r3
	mov	ip, #1
	str	r9, [fp, #-56]
	ldrb	r4, [r1, #24]
	mov	r6, r6, asl r4
	rsb	r5, r4, r5
	str	r6, [r7, #28]
	mov	r4, r3, asl r4
	str	r5, [r7, #32]
	str	r4, [r7, #36]
	b	.L1133
.L1131:
	mov	r3, r4, asl #24
	mov	r2, ip, asl r8
	cmp	r3, r0
	sub	r8, r8, #1
	rsbls	r0, r3, r0
	ldr	r3, .L1229
	ldrls	r1, [r7, #36]
	movhi	r2, #0
	orr	r10, r10, r2
	rsbls	r4, r4, r1
	cmn	r8, #1
	add	r3, r3, r4
	ldrb	r3, [r3, #24]
	mov	r6, r0, asl r3
	rsb	r5, r3, r5
	mov	r4, r4, asl r3
	str	r6, [r7, #28]
	str	r5, [r7, #32]
	str	r4, [r7, #36]
	beq	.L1220
.L1133:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r6
	add	r4, r4, #1
	bge	.L1131
	rsb	r1, r5, #24
	rsb	r3, r5, #16
	bic	r1, r1, #7
	mov	r0, r7
	str	ip, [fp, #-52]
	rsb	r9, r1, r3
	add	r5, r1, r5
	bl	BsGet
	and	r3, r9, #7
	ldr	ip, [fp, #-52]
	orr	r0, r6, r0, asl r3
	b	.L1131
.L1130:
	ldr	r3, .L1229
	add	r3, r3, r4
	ldrb	r3, [r3, #24]
	mov	r6, r6, asl r3
	rsb	r5, r3, r5
	mov	r4, r4, asl r3
	str	r6, [r7, #28]
	str	r5, [r7, #32]
	str	r4, [r7, #36]
.L1169:
	ldr	r3, [fp, #-48]
	add	r9, r9, #1
	cmp	r9, r3
	bne	.L1134
	ldr	r2, [fp, #-64]
	add	r3, r9, #33
	str	r3, [fp, #-48]
	cmp	r3, r2
	bne	.L1135
	ldr	r3, [fp, #-76]
	mov	r10, #1
	add	r2, r3, #31
	add	r3, r3, #97
	str	r2, [fp, #-68]
	str	r3, [fp, #-72]
.L1136:
	ldr	r3, [fp, #-68]
	sub	r3, r3, #6
	str	r3, [fp, #-48]
	mov	r3, #2
	str	r3, [fp, #-64]
.L1151:
	ldr	ip, [fp, #-48]
	mov	r2, #0
.L1142:
	sub	r4, r4, #1
	cmp	r5, #0
	mov	r3, r4, asl #8
	sub	r4, r3, r4, asl #2
	mov	r4, r4, lsr #8
	add	r4, r4, #1
	blt	.L1221
.L1137:
	mov	r1, r4, asl #24
	cmp	r1, r6
	bhi	.L1138
	ldr	r3, [r7, #36]
	rsb	r6, r1, r6
	ldr	r1, .L1229
	mov	r9, #0
	rsb	r3, r4, r3
	mov	r8, #6
	add	r1, r1, r3
	str	r2, [fp, #-56]
	str	ip, [fp, #-60]
	ldrb	r4, [r1, #24]
	mov	r6, r6, asl r4
	rsb	r5, r4, r5
	mov	r4, r3, asl r4
	str	r6, [r7, #28]
	mov	r3, r6
	str	r5, [r7, #32]
	mov	r6, r9
	str	r4, [r7, #36]
	mov	r9, r3
	b	.L1141
.L1139:
	mov	r3, r4, asl #24
	mov	r1, r10, asl r8
	cmp	r3, r0
	sub	r8, r8, #1
	rsbls	r0, r3, r0
	ldr	r3, .L1229
	ldrls	ip, [r7, #36]
	movhi	r1, #0
	orr	r6, r6, r1
	rsbls	r4, r4, ip
	cmn	r8, #1
	add	r3, r3, r4
	ldrb	r1, [r3, #24]
	mov	r9, r0, asl r1
	rsb	r5, r1, r5
	mov	r4, r4, asl r1
	str	r9, [r7, #28]
	str	r5, [r7, #32]
	str	r4, [r7, #36]
	beq	.L1222
.L1141:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r9
	add	r4, r4, #1
	bge	.L1139
	rsb	r1, r5, #24
	rsb	ip, r5, #16
	bic	r1, r1, #7
	mov	r0, r7
	rsb	ip, r1, ip
	add	r5, r1, r5
	str	ip, [fp, #-52]
	bl	BsGet
	ldr	ip, [fp, #-52]
	and	ip, ip, #7
	orr	r0, r9, r0, asl ip
	b	.L1139
.L1220:
	ldr	r9, [fp, #-56]
	mov	r10, r10, asl #1
	orr	r10, r10, #1
	strb	r10, [r9]
	ldr	r4, [r7, #36]
	ldr	r5, [r7, #32]
	ldr	r6, [r7, #28]
	b	.L1169
.L1138:
	ldr	r3, .L1229
	add	r3, r3, r4
	ldrb	r3, [r3, #24]
	mov	r6, r6, asl r3
	rsb	r5, r3, r5
	mov	r4, r4, asl r3
	str	r6, [r7, #28]
	str	r5, [r7, #32]
	str	r4, [r7, #36]
.L1170:
	add	r2, r2, #1
	add	ip, ip, #1
	cmp	r2, #3
	bne	.L1142
	ldr	r3, [fp, #-64]
	subs	r3, r3, #1
	str	r3, [fp, #-64]
	ldr	r3, [fp, #-48]
	add	r3, r3, #3
	str	r3, [fp, #-48]
	bne	.L1151
	ldr	r3, [fp, #-64]
	ldr	r2, [fp, #-68]
.L1143:
	sub	r4, r4, #1
	cmp	r5, #0
	mov	r1, r4, asl #8
	sub	r4, r1, r4, asl #2
	mov	r4, r4, lsr #8
	add	r4, r4, #1
	blt	.L1223
.L1144:
	mov	r0, r4, asl #24
	cmp	r0, r6
	bhi	.L1145
	ldr	r1, [r7, #36]
	rsb	r6, r0, r6
	ldr	r0, .L1229
	mov	r9, #0
	rsb	r1, r4, r1
	str	r3, [fp, #-52]
	add	r0, r0, r1
	mov	r8, #6
	str	r2, [fp, #-56]
	ldrb	r4, [r0, #24]
	mov	r6, r6, asl r4
	rsb	r5, r4, r5
	str	r6, [r7, #28]
	mov	r4, r1, asl r4
	mov	r3, r6
	str	r5, [r7, #32]
	mov	r6, r9
	str	r4, [r7, #36]
	mov	r9, r3
	b	.L1148
.L1146:
	mov	r3, r4, asl #24
	mov	r1, r10, asl r8
	cmp	r3, r0
	sub	r8, r8, #1
	rsbls	r0, r3, r0
	ldr	r3, .L1229
	ldrls	ip, [r7, #36]
	movhi	r1, #0
	orr	r6, r6, r1
	rsbls	r4, r4, ip
	cmn	r8, #1
	add	r3, r3, r4
	ldrb	r1, [r3, #24]
	mov	r9, r0, asl r1
	rsb	r5, r1, r5
	mov	r4, r4, asl r1
	str	r9, [r7, #28]
	str	r5, [r7, #32]
	str	r4, [r7, #36]
	beq	.L1224
.L1148:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r9
	add	r4, r4, #1
	bge	.L1146
	rsb	r1, r5, #24
	rsb	ip, r5, #16
	bic	r1, r1, #7
	mov	r0, r7
	rsb	ip, r1, ip
	add	r5, r1, r5
	str	ip, [fp, #-48]
	bl	BsGet
	ldr	ip, [fp, #-48]
	and	ip, ip, #7
	orr	r0, r9, r0, asl ip
	b	.L1146
.L1222:
	ldr	ip, [fp, #-60]
	mov	r9, r6, asl #1
	orr	r9, r9, #1
	ldr	r2, [fp, #-56]
	strb	r9, [ip]
	ldr	r4, [r7, #36]
	ldr	r5, [r7, #32]
	ldr	r6, [r7, #28]
	b	.L1170
.L1219:
	rsb	r10, r5, #24
	mov	r0, r7
	bic	r10, r10, #7
	rsb	r8, r5, #16
	rsb	r8, r10, r8
	add	r5, r10, r5
	mov	r1, r10
	and	r8, r8, #7
	bl	BsGet
	str	r5, [r7, #32]
	orr	r0, r6, r0, asl r8
	str	r0, [r7, #28]
	mov	r6, r0
	b	.L1129
.L1145:
	ldr	r1, .L1229
	add	r3, r3, #1
	cmp	r3, #3
	add	r2, r2, #1
	add	r1, r1, r4
	ldrb	r1, [r1, #24]
	mov	r6, r6, asl r1
	rsb	r5, r1, r5
	mov	r4, r4, asl r1
	str	r6, [r7, #28]
	str	r5, [r7, #32]
	str	r4, [r7, #36]
	beq	.L1149
.L1225:
	ldr	r4, [r7, #36]
	ldr	r5, [r7, #32]
	ldr	r6, [r7, #28]
	b	.L1143
.L1224:
	ldr	r3, [fp, #-52]
	mov	r9, r6, asl #1
	ldr	r2, [fp, #-56]
	orr	r9, r9, #1
	add	r3, r3, #1
	cmp	r3, #3
	add	r2, r2, #1
	strb	r9, [r2, #-1]
	bne	.L1225
.L1149:
	ldr	r3, [fp, #-68]
	ldr	r2, [fp, #-72]
	add	r3, r3, #33
	str	r3, [fp, #-68]
	cmp	r3, r2
	beq	.L1150
	ldr	r4, [r7, #36]
	ldr	r5, [r7, #32]
	ldr	r6, [r7, #28]
	b	.L1136
.L1221:
	rsb	r9, r5, #24
	mov	r0, r7
	bic	r9, r9, #7
	str	ip, [fp, #-56]
	str	r2, [fp, #-52]
	rsb	r8, r5, #16
	mov	r1, r9
	rsb	r8, r9, r8
	bl	BsGet
	and	r8, r8, #7
	add	r5, r9, r5
	ldr	ip, [fp, #-56]
	str	r5, [r7, #32]
	ldr	r2, [fp, #-52]
	orr	r0, r6, r0, asl r8
	str	r0, [r7, #28]
	mov	r6, r0
	b	.L1137
.L1223:
	rsb	r9, r5, #24
	mov	r0, r7
	bic	r9, r9, #7
	str	r2, [fp, #-52]
	str	r3, [fp, #-48]
	rsb	r8, r5, #16
	mov	r1, r9
	rsb	r8, r9, r8
	bl	BsGet
	and	r8, r8, #7
	add	r5, r9, r5
	ldr	r2, [fp, #-52]
	str	r5, [r7, #32]
	ldr	r3, [fp, #-48]
	orr	r0, r6, r0, asl r8
	str	r0, [r7, #28]
	mov	r6, r0
	b	.L1144
.L1218:
	ldr	r2, [fp, #-48]
	mov	r3, r9, asl #1
	orr	r3, r3, #1
	strb	r3, [r2, #-11]
	ldr	r4, [r7, #36]
	ldr	r5, [r7, #32]
	ldr	r6, [r7, #28]
	b	.L1168
.L1214:
	ldr	r2, [fp, #-48]
	mov	r3, r9, asl #1
	orr	r3, r3, #1
	strb	r3, [r2, #-22]
	ldr	r4, [r7, #36]
	ldr	r5, [r7, #32]
	ldr	r6, [r7, #28]
	b	.L1166
.L1150:
	ldr	r3, [fp, #-80]
	mov	ip, r7
	cmp	r3, #0
	beq	.L1106
	ldr	r3, [fp, #-76]
	add	r6, r3, #66
	str	r6, [fp, #-48]
	ldr	r6, [fp, #-84]
.L1163:
	ldr	r3, [r7, #36]
	ldr	r5, [r7, #32]
	sub	r2, r3, #1
	cmp	r5, #0
	mov	r3, r2, asl #8
	sub	r3, r3, r2, asl #2
	mov	r3, r3, lsr #8
	add	r4, r3, #1
	blt	.L1152
	ldr	r8, [r7, #28]
.L1153:
	mov	r2, r4, asl #24
	cmp	r2, r8
	bhi	.L1154
	ldr	r3, [r7, #36]
	rsb	r8, r2, r8
	ldr	r1, .L1229
	mov	r10, #0
	rsb	r3, r4, r3
	mov	r9, #6
	add	r1, r1, r3
	mov	r2, #1
	str	r6, [fp, #-56]
	ldrb	r4, [r1, #24]
	mov	r8, r8, asl r4
	rsb	r5, r4, r5
	str	r8, [r7, #28]
	mov	r4, r3, asl r4
	str	r5, [r7, #32]
	str	r4, [r7, #36]
	b	.L1157
.L1155:
	mov	r3, r4, asl #24
	mov	r1, r2, asl r9
	cmp	r3, r0
	sub	r9, r9, #1
	rsbls	r0, r3, r0
	ldr	r3, .L1229
	ldrls	ip, [r7, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r4, r4, ip
	cmn	r9, #1
	add	r3, r3, r4
	ldrb	r3, [r3, #24]
	mov	r8, r0, asl r3
	rsb	r5, r3, r5
	mov	r4, r4, asl r3
	str	r8, [r7, #28]
	str	r5, [r7, #32]
	str	r4, [r7, #36]
	beq	.L1226
.L1157:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r8
	add	r4, r4, #1
	bge	.L1155
	rsb	r1, r5, #24
	rsb	r3, r5, #16
	bic	r1, r1, #7
	mov	r0, r7
	str	r2, [fp, #-52]
	rsb	r6, r1, r3
	add	r5, r1, r5
	bl	BsGet
	and	r3, r6, #7
	ldr	r2, [fp, #-52]
	orr	r0, r8, r0, asl r3
	b	.L1155
.L1159:
	ldr	r3, .L1229
	add	r3, r3, r4
	ldrb	r3, [r3, #24]
	mov	r8, r8, asl r3
	rsb	r5, r3, r5
	str	r8, [r7, #28]
	mov	r3, r4, asl r3
	str	r5, [r7, #32]
	str	r3, [r7, #36]
.L1173:
	ldr	r3, [fp, #-48]
	add	r6, r6, #33
	cmp	r6, r3
	bne	.L1163
.L1106:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1154:
	ldr	r3, .L1229
	add	r3, r3, r4
	ldrb	r3, [r3, #24]
	mov	r8, r8, asl r3
	rsb	r5, r3, r5
	str	r8, [r7, #28]
	mov	r3, r4, asl r3
	str	r5, [r7, #32]
	str	r3, [r7, #36]
.L1172:
	sub	r3, r3, #1
	cmp	r5, #0
	mov	r2, r3, asl #8
	sub	r3, r2, r3, asl #2
	mov	r3, r3, lsr #8
	add	r4, r3, #1
	blt	.L1227
.L1158:
	mov	r2, r4, asl #24
	cmp	r2, r8
	bhi	.L1159
	ldr	r3, [r7, #36]
	rsb	r8, r2, r8
	ldr	r1, .L1229
	mov	r10, #0
	rsb	r3, r4, r3
	mov	r9, #6
	add	r1, r1, r3
	mov	r2, #1
	str	r6, [fp, #-56]
	ldrb	r4, [r1, #24]
	mov	r8, r8, asl r4
	rsb	r5, r4, r5
	str	r8, [r7, #28]
	mov	r4, r3, asl r4
	str	r5, [r7, #32]
	str	r4, [r7, #36]
	b	.L1162
.L1160:
	mov	r3, r4, asl #24
	mov	r1, r2, asl r9
	cmp	r3, r0
	sub	r9, r9, #1
	rsbls	r0, r3, r0
	ldr	r3, .L1229
	ldrls	ip, [r7, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r4, r4, ip
	cmn	r9, #1
	add	r3, r3, r4
	ldrb	r3, [r3, #24]
	mov	r8, r0, asl r3
	rsb	r5, r3, r5
	mov	r4, r4, asl r3
	str	r8, [r7, #28]
	str	r5, [r7, #32]
	str	r4, [r7, #36]
	beq	.L1228
.L1162:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r8
	add	r4, r4, #1
	bge	.L1160
	rsb	r1, r5, #24
	rsb	r3, r5, #16
	bic	r1, r1, #7
	mov	r0, r7
	str	r2, [fp, #-52]
	rsb	r6, r1, r3
	add	r5, r1, r5
	bl	BsGet
	and	r3, r6, #7
	ldr	r2, [fp, #-52]
	orr	r0, r8, r0, asl r3
	b	.L1160
.L1228:
	ldr	r6, [fp, #-56]
	mov	r3, r10, asl #1
	orr	r3, r3, #1
	strb	r3, [r6, #35]
	b	.L1173
.L1226:
	ldr	r6, [fp, #-56]
	mov	r3, r10, asl #1
	orr	r3, r3, #1
	strb	r3, [r6, #34]
	ldr	r3, [r7, #36]
	ldr	r5, [r7, #32]
	ldr	r8, [r7, #28]
	b	.L1172
.L1211:
	rsb	r10, r5, #24
	mov	r0, r7
	bic	r10, r10, #7
	rsb	r8, r5, #16
	rsb	r8, r10, r8
	add	r5, r10, r5
	mov	r1, r10
	and	r8, r8, #7
	bl	BsGet
	str	r5, [r7, #32]
	orr	r0, r6, r0, asl r8
	str	r0, [r7, #28]
	mov	r6, r0
	b	.L1107
.L1217:
	rsb	r9, r5, #24
	mov	r0, r7
	bic	r9, r9, #7
	rsb	r8, r5, #16
	rsb	r8, r9, r8
	add	r5, r9, r5
	mov	r1, r9
	and	r8, r8, #7
	bl	BsGet
	str	r5, [r7, #32]
	orr	r0, r6, r0, asl r8
	str	r0, [r7, #28]
	mov	r6, r0
	b	.L1124
.L1213:
	rsb	r9, r5, #24
	mov	r0, r7
	bic	r9, r9, #7
	rsb	r8, r5, #16
	rsb	r8, r9, r8
	add	r5, r9, r5
	mov	r1, r9
	and	r8, r8, #7
	bl	BsGet
	str	r5, [r7, #32]
	orr	r0, r6, r0, asl r8
	str	r0, [r7, #28]
	mov	r6, r0
	b	.L1113
.L1152:
	rsb	r9, r5, #24
	mov	r0, r7
	bic	r9, r9, #7
	ldr	r8, [r7, #28]
	rsb	r10, r5, #16
	add	r5, r5, r9
	mov	r1, r9
	rsb	r10, r9, r10
	bl	BsGet
	and	r10, r10, #7
	str	r5, [r7, #32]
	orr	r0, r8, r0, asl r10
	str	r0, [r7, #28]
	mov	r8, r0
	b	.L1153
.L1227:
	rsb	r10, r5, #24
	mov	r0, r7
	bic	r10, r10, #7
	rsb	r9, r5, #16
	rsb	r9, r10, r9
	add	r5, r10, r5
	mov	r1, r10
	and	r9, r9, #7
	bl	BsGet
	str	r5, [r7, #32]
	orr	r0, r8, r0, asl r9
	str	r0, [r7, #28]
	mov	r8, r0
	b	.L1158
.L1230:
	.align	2
.L1229:
	.word	.LANCHOR0
	.fnend
	.size	Vp9_ReadMvProbs, .-Vp9_ReadMvProbs
	.align	2
	.global	Vp9_PrepareReadModeInfo
	.type	Vp9_PrepareReadModeInfo, %function
Vp9_PrepareReadModeInfo:
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
	add	r10, r0, #2000
	ldr	r7, .L1381
	add	r10, r10, #15
	str	r0, [fp, #-72]
	mov	r6, r1
	add	r0, r0, #2016
	mov	r8, r10
	add	r0, r0, #2
	mov	r9, r3
	str	r0, [fp, #-76]
	mov	r3, #0
	str	r2, [fp, #-56]
	str	r3, [fp, #-48]
.L1235:
	ldr	r4, [r6, #36]
	ldr	r5, [r6, #32]
	sub	r4, r4, #1
	cmp	r5, #0
	mov	r2, r4, asl #8
	sub	r4, r2, r4, asl #2
	mov	r4, r4, lsr #8
	add	r4, r4, #1
	blt	.L1232
	ldr	r10, [r6, #28]
.L1233:
	mov	ip, r4, asl #24
	mov	r1, r8
	cmp	ip, r10
	mov	r0, r6
	rsb	r2, ip, r10
	bhi	.L1234
	ldr	ip, [r6, #36]
	rsb	r4, r4, ip
	add	ip, r7, r4
	ldrb	ip, [ip, #24]
	mov	r2, r2, asl ip
	rsb	r5, ip, r5
	mov	r4, r4, asl ip
	str	r2, [r6, #28]
	str	r5, [r6, #32]
	str	r4, [r6, #36]
	bl	Vp9_DiffUpdateProb
.L1312:
	ldr	r3, [fp, #-76]
	add	r8, r8, #1
	cmp	r8, r3
	bne	.L1235
	ldr	r8, [fp, #-56]
	adds	r8, r8, #0
	movne	r8, #1
	cmp	r9, #0
	movne	r8, #0
	cmp	r8, #0
	bne	.L1358
.L1236:
	ldr	r3, [fp, #-48]
	ldr	r2, [fp, #16]
	str	r3, [r2]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1234:
	add	r2, r7, r4
	ldrb	r2, [r2, #24]
	mov	r10, r10, asl r2
	rsb	r5, r2, r5
	mov	r4, r4, asl r2
	str	r10, [r6, #28]
	str	r5, [r6, #32]
	str	r4, [r6, #36]
	b	.L1312
.L1232:
	rsb	r2, r5, #24
	rsb	ip, r5, #16
	bic	r2, r2, #7
	mov	r0, r6
	rsb	ip, r2, ip
	ldr	r10, [r6, #28]
	mov	r1, r2
	str	ip, [fp, #-64]
	str	r2, [fp, #-60]
	bl	BsGet
	ldr	ip, [fp, #-64]
	ldr	r2, [fp, #-60]
	and	ip, ip, #7
	add	r5, r5, r2
	str	r5, [r6, #32]
	orr	r0, r10, r0, asl ip
	str	r0, [r6, #28]
	mov	r10, r0
	b	.L1233
.L1358:
	mov	r1, r6
	ldr	r0, [fp, #-72]
	bl	Vp9_ReadInterModeProbs
	ldr	r3, [fp, #4]
	cmp	r3, #4
	beq	.L1359
.L1237:
	ldr	r3, [fp, #-72]
	add	r10, r3, #1968
	mov	r3, r10
	add	r3, r3, #15
	add	r10, r10, #11
	mov	r5, r3
.L1241:
	ldr	r4, [r6, #36]
	ldr	r8, [r6, #32]
	sub	r4, r4, #1
	cmp	r8, #0
	mov	r3, r4, asl #8
	sub	r4, r3, r4, asl #2
	mov	r4, r4, lsr #8
	add	r4, r4, #1
	blt	.L1238
	ldr	r3, [r6, #28]
.L1239:
	mov	r2, r4, asl #24
	mov	r1, r10
	cmp	r2, r3
	mov	r0, r6
	rsb	ip, r2, r3
	bhi	.L1240
	ldr	r3, [r6, #36]
	rsb	r4, r4, r3
	add	r3, r7, r4
	ldrb	r3, [r3, #24]
	mov	ip, ip, asl r3
	rsb	r8, r3, r8
	mov	r4, r4, asl r3
	str	ip, [r6, #28]
	str	r8, [r6, #32]
	str	r4, [r6, #36]
	bl	Vp9_DiffUpdateProb
.L1313:
	add	r10, r10, #1
	cmp	r10, r5
	bne	.L1241
	ldr	ip, [fp, #-72]
	sub	r3, fp, #48
	ldr	r2, [fp, #8]
	mov	r1, r6
	add	lr, ip, #1728
	mov	r0, ip
	add	ip, ip, #1760
	mov	r4, lr
	mov	r5, ip
	bl	Vp9_ReadCompPred
	add	r3, r4, #9
	mov	lr, r4
	add	r4, r6, #28
	str	r3, [fp, #-56]
	add	r3, r5, #13
	str	r3, [fp, #-80]
	ldmia	r4, {r4, r5, r9}
	mov	r8, r5
.L1242:
	ldr	r3, [fp, #-56]
	sub	r10, r3, #9
.L1275:
	sub	r5, r9, #1
	cmp	r8, #0
	mov	r3, r5, asl #8
	sub	r5, r3, r5, asl #2
	mov	r5, r5, lsr #8
	add	r5, r5, #1
	blt	.L1360
.L1243:
	mov	r9, r5, asl #24
	cmp	r9, r4
	bhi	.L1244
	ldr	r3, [r6, #36]
	rsb	r9, r9, r4
	rsb	r5, r5, r3
	add	r3, r7, r5
	ldrb	r2, [r3, #24]
	mov	r3, r5, asl r2
	rsb	r5, r2, r8
	sub	r4, r3, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r9, r9, asl r2
	str	r3, [r6, #36]
	add	r4, r4, #1
	str	r5, [r6, #32]
	str	r9, [r6, #28]
	blt	.L1361
.L1245:
	mov	r2, r4, asl #24
	cmp	r2, r9
	bhi	.L1246
	ldr	r3, [r6, #36]
	rsb	r9, r2, r9
	rsb	r4, r4, r3
	add	r3, r7, r4
	ldrb	r0, [r3, #24]
	mov	r3, r4, asl r0
	rsb	r4, r0, r5
	cmp	r4, #0
	sub	r5, r3, #1
	ubfx	r5, r5, #1, #24
	mov	r9, r9, asl r0
	str	r3, [r6, #36]
	add	r5, r5, #1
	str	r4, [r6, #32]
	str	r9, [r6, #28]
	blt	.L1362
.L1248:
	mov	r3, r5, asl #24
	cmp	r3, r9
	bhi	.L1253
	ldr	r1, [r6, #36]
	rsb	r3, r3, r9
	rsb	r5, r5, r1
	add	r2, r7, r5
	ldrb	r2, [r2, #24]
	rsb	r9, r2, r4
	mov	r1, r5, asl r2
	sub	r5, r1, #1
	cmp	r9, #0
	ubfx	r5, r5, #1, #24
	mov	r4, r3, asl r2
	str	r1, [r6, #36]
	add	r5, r5, #1
	str	r9, [r6, #32]
	str	r4, [r6, #28]
	blt	.L1363
.L1255:
	mov	r2, r5, asl #24
	cmp	r2, r4
	bhi	.L1259
	ldr	r1, [r6, #36]
	rsb	r2, r2, r4
	mov	r8, #0
	mov	r3, #6
	rsb	r5, r5, r1
	str	r10, [fp, #-68]
	add	r1, r7, r5
	mov	r10, r8
	mov	ip, #1
	ldrb	r4, [r1, #24]
	mov	r2, r2, asl r4
	rsb	r9, r4, r9
	str	r2, [r6, #28]
	mov	r4, r5, asl r4
	str	r9, [r6, #32]
	mov	r5, r3
	str	r4, [r6, #36]
	mov	r8, r2
	b	.L1260
.L1264:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r5
	cmp	r2, r0
	sub	r5, r5, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r4, r4, lr
	cmn	r5, #1
	add	r2, r7, r4
	ldrb	r2, [r2, #24]
	mov	r8, r0, asl r2
	rsb	r9, r2, r9
	mov	r4, r4, asl r2
	str	r8, [r6, #28]
	str	r9, [r6, #32]
	str	r4, [r6, #36]
	beq	.L1364
.L1260:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r8
	add	r4, r4, #1
	bge	.L1264
	rsb	r1, r9, #24
	rsb	r2, r9, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-64]
	str	r2, [fp, #-60]
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-60]
	ldr	ip, [fp, #-64]
	and	r2, r2, #7
	orr	r0, r8, r0, asl r2
	b	.L1264
.L1244:
	add	r3, r7, r5
	ldrb	r9, [r3, #24]
	mov	r4, r4, asl r9
	rsb	r8, r9, r8
	str	r4, [r6, #28]
	mov	r9, r5, asl r9
	str	r8, [r6, #32]
	str	r9, [r6, #36]
.L1314:
	ldr	r3, [fp, #-56]
	add	r10, r10, #1
	cmp	r10, r3
	bne	.L1275
	ldr	r2, [fp, #-80]
	add	r3, r10, #9
	str	r3, [fp, #-56]
	cmp	r3, r2
	bne	.L1242
	ldr	r3, [fp, #-72]
	add	r2, r3, #1888
	add	r3, r3, #1936
	add	r3, r3, #14
	str	r3, [fp, #-64]
	mov	r3, r9
	add	r2, r2, #14
	str	r2, [fp, #-60]
.L1276:
	ldr	r2, [fp, #-60]
	mov	r10, #0
	mov	r9, r3
	str	r2, [fp, #-56]
.L1311:
	sub	r9, r9, #1
	cmp	r8, #0
	mov	r2, r9, asl #8
	sub	r9, r2, r9, asl #2
	mov	r9, r9, lsr #8
	add	r9, r9, #1
	blt	.L1365
.L1277:
	mov	r0, r9, asl #24
	cmp	r0, r4
	bhi	.L1278
	ldr	r3, [r6, #36]
	rsb	r0, r0, r4
	rsb	r3, r9, r3
	add	r2, r7, r3
	ldrb	r2, [r2, #24]
	mov	r3, r3, asl r2
	rsb	r5, r2, r8
	sub	r4, r3, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r9, r0, asl r2
	str	r3, [r6, #36]
	add	r4, r4, #1
	str	r5, [r6, #32]
	str	r9, [r6, #28]
	blt	.L1366
.L1279:
	mov	r2, r4, asl #24
	cmp	r2, r9
	bhi	.L1280
	ldr	ip, [r6, #36]
	rsb	r9, r2, r9
	rsb	r4, r4, ip
	add	r3, r7, r4
	ldrb	r0, [r3, #24]
	mov	ip, r4, asl r0
	rsb	r4, r0, r5
	cmp	r4, #0
	sub	r5, ip, #1
	ubfx	r5, r5, #1, #24
	mov	r9, r9, asl r0
	str	ip, [r6, #36]
	add	r5, r5, #1
	str	r4, [r6, #32]
	str	r9, [r6, #28]
	blt	.L1367
.L1282:
	mov	r3, r5, asl #24
	cmp	r3, r9
	bhi	.L1287
	ldr	r1, [r6, #36]
	rsb	r3, r3, r9
	rsb	r5, r5, r1
	add	r2, r7, r5
	ldrb	ip, [r2, #24]
	mov	r1, r5, asl ip
	rsb	r5, ip, r4
	sub	r9, r1, #1
	cmp	r5, #0
	ubfx	r9, r9, #1, #24
	mov	r4, r3, asl ip
	str	r1, [r6, #36]
	add	r9, r9, #1
	str	r5, [r6, #32]
	str	r4, [r6, #28]
	blt	.L1368
.L1289:
	mov	r3, r9, asl #24
	cmp	r3, r4
	bhi	.L1293
	ldr	r1, [r6, #36]
	rsb	r0, r3, r4
	mov	r2, #6
	mov	r3, #0
	rsb	r4, r9, r1
	str	r10, [fp, #-80]
	add	r1, r7, r4
	mov	ip, #1
	mov	r10, r3
	ldrb	r1, [r1, #24]
	rsb	r8, r1, r5
	mov	r9, r0, asl r1
	mov	r4, r4, asl r1
	str	r9, [r6, #28]
	str	r8, [r6, #32]
	mov	r5, r2
	str	r4, [r6, #36]
	b	.L1294
.L1298:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r5
	cmp	r2, r0
	sub	r5, r5, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r4, r4, lr
	cmn	r5, #1
	add	r2, r7, r4
	ldrb	r2, [r2, #24]
	mov	r9, r0, asl r2
	rsb	r8, r2, r8
	mov	r4, r4, asl r2
	str	r9, [r6, #28]
	str	r8, [r6, #32]
	str	r4, [r6, #36]
	beq	.L1369
.L1294:
	sub	r4, r4, #1
	cmp	r8, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r9
	add	r4, r4, #1
	bge	.L1298
	rsb	r1, r8, #24
	rsb	r2, r8, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-72]
	str	r2, [fp, #-68]
	add	r8, r1, r8
	bl	BsGet
	ldr	r2, [fp, #-68]
	ldr	ip, [fp, #-72]
	and	r2, r2, #7
	orr	r0, r9, r0, asl r2
	b	.L1298
.L1278:
	add	r3, r7, r9
	ldrb	r3, [r3, #24]
	mov	r4, r4, asl r3
	rsb	r5, r3, r8
	mov	r9, r9, asl r3
	str	r4, [r6, #28]
	str	r5, [r6, #32]
	str	r9, [r6, #36]
.L1315:
	add	r10, r10, #1
	ldr	r3, [fp, #-56]
	cmp	r10, #3
	add	r3, r3, #1
	str	r3, [fp, #-56]
	addne	r4, r6, #28
	ldmneia	r4, {r4, r8, r9}
	bne	.L1311
.L1370:
	ldr	r3, [fp, #-60]
	ldr	r2, [fp, #-64]
	add	r3, r3, #3
	str	r3, [fp, #-60]
	cmp	r3, r2
	beq	.L1310
	ldr	r4, [r6, #28]
	ldr	r3, [r6, #36]
	ldr	r8, [r6, #32]
	b	.L1276
.L1365:
	rsb	r2, r8, #24
	rsb	r5, r8, #16
	bic	r2, r2, #7
	mov	r0, r6
	rsb	r5, r2, r5
	str	r2, [fp, #-68]
	mov	r1, r2
	bl	BsGet
	ldr	r2, [fp, #-68]
	and	r3, r5, #7
	add	r5, r2, r8
	str	r5, [r6, #32]
	mov	r8, r5
	orr	r0, r4, r0, asl r3
	str	r0, [r6, #28]
	mov	r4, r0
	b	.L1277
.L1280:
	add	r3, r7, r4
	mov	r8, #0
	mov	r2, #3
	str	r10, [fp, #-80]
	ldrb	r1, [r3, #24]
	mov	r10, r8
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r5, r1, r5
	str	r9, [r6, #28]
	mov	r4, r4, asl r1
	mov	r8, r9
	str	r5, [r6, #32]
	str	r4, [r6, #36]
	mov	r9, r2
	b	.L1285
.L1283:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r4, r4, lr
	cmn	r9, #1
	add	r2, r7, r4
	ldrb	r2, [r2, #24]
	mov	r8, r0, asl r2
	rsb	r5, r2, r5
	mov	r4, r4, asl r2
	str	r8, [r6, #28]
	str	r5, [r6, #32]
	str	r4, [r6, #36]
	beq	.L1371
.L1285:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r8
	add	r4, r4, #1
	bge	.L1283
	rsb	r1, r5, #24
	rsb	r2, r5, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-72]
	str	r2, [fp, #-68]
	add	r5, r1, r5
	bl	BsGet
	ldr	r2, [fp, #-68]
	ldr	ip, [fp, #-72]
	and	r2, r2, #7
	orr	r0, r8, r0, asl r2
	b	.L1283
.L1371:
	mov	r8, r10
	ldr	r10, [fp, #-80]
.L1286:
	ldr	r3, [fp, #-56]
	add	r8, r7, r8
	ldrb	r1, [r8, #280]
	ldrb	r2, [r3]
	sub	ip, r2, #1
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L1303
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L1304
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L1304:
	add	r3, r3, #1
.L1306:
	ldr	r2, [fp, #-56]
	strb	r3, [r2]
	b	.L1315
.L1303:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	bgt	.L1307
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
.L1307:
	rsb	r3, r3, #255
	b	.L1306
.L1360:
	rsb	r3, r8, #24
	rsb	r9, r8, #16
	bic	r3, r3, #7
	mov	r0, r6
	rsb	r9, r3, r9
	str	r3, [fp, #-60]
	mov	r1, r3
	and	r9, r9, #7
	bl	BsGet
	ldr	r3, [fp, #-60]
	add	r8, r3, r8
	str	r8, [r6, #32]
	orr	r0, r4, r0, asl r9
	str	r0, [r6, #28]
	mov	r4, r0
	b	.L1243
.L1246:
	add	r3, r7, r4
	mov	r8, #0
	mov	r2, #3
	str	r10, [fp, #-68]
	ldrb	r1, [r3, #24]
	mov	r10, r8
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r5, r1, r5
	str	r9, [r6, #28]
	mov	r4, r4, asl r1
	mov	r8, r9
	str	r5, [r6, #32]
	str	r4, [r6, #36]
	mov	r9, r2
	b	.L1251
.L1249:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r4, r4, lr
	cmn	r9, #1
	add	r2, r7, r4
	ldrb	r2, [r2, #24]
	mov	r8, r0, asl r2
	rsb	r5, r2, r5
	mov	r4, r4, asl r2
	str	r8, [r6, #28]
	str	r5, [r6, #32]
	str	r4, [r6, #36]
	beq	.L1372
.L1251:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r8
	add	r4, r4, #1
	bge	.L1249
	rsb	r1, r5, #24
	rsb	r2, r5, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-64]
	str	r2, [fp, #-60]
	add	r5, r1, r5
	bl	BsGet
	ldr	r2, [fp, #-60]
	ldr	ip, [fp, #-64]
	and	r2, r2, #7
	orr	r0, r8, r0, asl r2
	b	.L1249
.L1372:
	mov	r8, r10
	ldr	r10, [fp, #-68]
.L1252:
	ldrb	r2, [r10]
	add	r8, r7, r8
	sub	ip, r2, #1
	ldrb	r1, [r8, #280]
	mov	r0, ip, asl #1
	cmp	r0, #255
	bgt	.L1269
	add	r3, r1, #1
	cmp	r3, r0
	bgt	.L1270
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, ip, r3, asr #1
	addeq	r3, ip, r3, asr #1
.L1270:
	add	r3, r3, #1
.L1272:
	add	r4, r6, #28
	strb	r3, [r10]
	ldmia	r4, {r4, r8, r9}
	b	.L1314
.L1269:
	rsb	r2, r2, #255
	add	r3, r1, #1
	cmp	r3, r2, asl #1
	bgt	.L1273
	tst	r3, #1
	addne	r3, r1, #2
	addeq	r3, r3, r3, lsr #31
	subne	r3, r2, r3, asr #1
	addeq	r3, r2, r3, asr #1
.L1273:
	rsb	r3, r3, #255
	b	.L1272
.L1287:
	add	r3, r7, r5
	mov	r8, #0
	mov	r2, #3
	str	r10, [fp, #-80]
	ldrb	r1, [r3, #24]
	mov	r10, r8
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r6, #28]
	mov	r5, r5, asl r1
	mov	r8, r9
	str	r4, [r6, #32]
	str	r5, [r6, #36]
	mov	r9, r2
	b	.L1292
.L1290:
	mov	r2, r5, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r5, r5, lr
	cmn	r9, #1
	add	r2, r7, r5
	ldrb	r2, [r2, #24]
	mov	r8, r0, asl r2
	rsb	r4, r2, r4
	mov	r5, r5, asl r2
	str	r8, [r6, #28]
	str	r4, [r6, #32]
	str	r5, [r6, #36]
	beq	.L1373
.L1292:
	sub	r5, r5, #1
	cmp	r4, #0
	ubfx	r5, r5, #1, #24
	mov	r0, r8
	add	r5, r5, #1
	bge	.L1290
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-72]
	str	r2, [fp, #-68]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-68]
	ldr	ip, [fp, #-72]
	and	r2, r2, #7
	orr	r0, r8, r0, asl r2
	b	.L1290
.L1373:
	mov	r8, r10
	ldr	r10, [fp, #-80]
	add	r8, r8, #16
	b	.L1286
.L1369:
	mov	r3, r10
	cmp	r3, #64
	ldr	r10, [fp, #-80]
	bgt	.L1374
.L1300:
	add	r8, r3, #64
	b	.L1286
.L1253:
	add	r3, r7, r5
	mov	r8, #0
	mov	r2, #3
	str	r10, [fp, #-68]
	ldrb	r1, [r3, #24]
	mov	r10, r8
	mov	ip, #1
	mov	r9, r9, asl r1
	rsb	r4, r1, r4
	str	r9, [r6, #28]
	mov	r5, r5, asl r1
	mov	r8, r9
	str	r4, [r6, #32]
	str	r5, [r6, #36]
	mov	r9, r2
	b	.L1258
.L1256:
	mov	r2, r5, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r5, r5, lr
	cmn	r9, #1
	add	r2, r7, r5
	ldrb	r2, [r2, #24]
	mov	r8, r0, asl r2
	rsb	r4, r2, r4
	mov	r5, r5, asl r2
	str	r8, [r6, #28]
	str	r4, [r6, #32]
	str	r5, [r6, #36]
	beq	.L1375
.L1258:
	sub	r5, r5, #1
	cmp	r4, #0
	ubfx	r5, r5, #1, #24
	mov	r0, r8
	add	r5, r5, #1
	bge	.L1256
	rsb	r1, r4, #24
	rsb	r2, r4, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-64]
	str	r2, [fp, #-60]
	add	r4, r1, r4
	bl	BsGet
	ldr	r2, [fp, #-60]
	ldr	ip, [fp, #-64]
	and	r2, r2, #7
	orr	r0, r8, r0, asl r2
	b	.L1256
.L1375:
	mov	r8, r10
	ldr	r10, [fp, #-68]
	add	r8, r8, #16
	b	.L1252
.L1364:
	mov	r2, r8
	mov	r8, r10
	cmp	r8, #64
	ldr	r10, [fp, #-68]
	bgt	.L1376
.L1266:
	add	r8, r8, #64
	b	.L1252
.L1293:
	add	r3, r7, r9
	mov	r8, #0
	mov	r2, #4
	str	r10, [fp, #-80]
	ldrb	r1, [r3, #24]
	mov	r10, r8
	mov	ip, #1
	mov	r3, r4, asl r1
	mov	r9, r9, asl r1
	rsb	r5, r1, r5
	str	r9, [r6, #36]
	mov	r4, r9
	str	r3, [r6, #28]
	str	r5, [r6, #32]
	mov	r8, r3
	mov	r9, r2
	b	.L1297
.L1295:
	mov	r2, r4, asl #24
	mov	r1, ip, asl r9
	cmp	r2, r0
	sub	r9, r9, #1
	rsbls	r0, r2, r0
	ldrls	lr, [r6, #36]
	movhi	r1, #0
	orr	r10, r10, r1
	rsbls	r4, r4, lr
	cmn	r9, #1
	add	r2, r7, r4
	ldrb	r2, [r2, #24]
	mov	r8, r0, asl r2
	rsb	r5, r2, r5
	mov	r4, r4, asl r2
	str	r8, [r6, #28]
	str	r5, [r6, #32]
	str	r4, [r6, #36]
	beq	.L1377
.L1297:
	sub	r4, r4, #1
	cmp	r5, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r8
	add	r4, r4, #1
	bge	.L1295
	rsb	r1, r5, #24
	rsb	r2, r5, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r2, r1, r2
	str	ip, [fp, #-72]
	str	r2, [fp, #-68]
	add	r5, r1, r5
	bl	BsGet
	ldr	r2, [fp, #-68]
	ldr	ip, [fp, #-72]
	and	r2, r2, #7
	orr	r0, r8, r0, asl r2
	b	.L1295
.L1377:
	mov	r8, r10
	ldr	r10, [fp, #-80]
	add	r8, r8, #32
	b	.L1286
.L1366:
	rsb	r3, r5, #24
	rsb	r8, r5, #16
	bic	r3, r3, #7
	mov	r0, r6
	rsb	r8, r3, r8
	str	r3, [fp, #-68]
	mov	r1, r3
	bl	BsGet
	and	r2, r8, #7
	ldr	r3, [fp, #-68]
	add	r5, r5, r3
	str	r5, [r6, #32]
	orr	r0, r9, r0, asl r2
	str	r0, [r6, #28]
	mov	r9, r0
	b	.L1279
.L1240:
	add	r2, r7, r4
	ldrb	r2, [r2, #24]
	mov	r3, r3, asl r2
	rsb	r8, r2, r8
	mov	r4, r4, asl r2
	str	r3, [r6, #28]
	str	r8, [r6, #32]
	str	r4, [r6, #36]
	b	.L1313
.L1259:
	add	r3, r7, r5
	mov	r8, #0
	mov	ip, #4
	str	r10, [fp, #-68]
	ldrb	r1, [r3, #24]
	mov	r10, r8
	mov	r2, #1
	mov	r3, r4, asl r1
	rsb	r9, r1, r9
	mov	r4, r5, asl r1
	str	r3, [r6, #28]
	str	r9, [r6, #32]
	mov	r5, ip
	str	r4, [r6, #36]
	mov	r8, r3
	b	.L1263
.L1261:
	mov	r1, r4, asl #24
	mov	ip, r2, asl r5
	cmp	r1, r0
	sub	r5, r5, #1
	rsbls	r0, r1, r0
	ldrls	lr, [r6, #36]
	movhi	ip, #0
	orr	r10, r10, ip
	rsbls	r4, r4, lr
	cmn	r5, #1
	add	r1, r7, r4
	ldrb	r1, [r1, #24]
	mov	r8, r0, asl r1
	rsb	r9, r1, r9
	mov	r4, r4, asl r1
	str	r8, [r6, #28]
	str	r9, [r6, #32]
	str	r4, [r6, #36]
	beq	.L1378
.L1263:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r0, r8
	add	r4, r4, #1
	bge	.L1261
	rsb	r1, r9, #24
	rsb	ip, r9, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	ip, r1, ip
	str	r2, [fp, #-64]
	str	ip, [fp, #-60]
	add	r9, r1, r9
	bl	BsGet
	ldr	ip, [fp, #-60]
	ldr	r2, [fp, #-64]
	and	ip, ip, #7
	orr	r0, r8, r0, asl ip
	b	.L1261
.L1378:
	mov	r8, r10
	ldr	r10, [fp, #-68]
	add	r8, r8, #32
	b	.L1252
.L1361:
	rsb	r3, r5, #24
	rsb	r8, r5, #16
	bic	r3, r3, #7
	mov	r0, r6
	rsb	r8, r3, r8
	str	r3, [fp, #-60]
	mov	r1, r3
	bl	BsGet
	and	r2, r8, #7
	ldr	r3, [fp, #-60]
	add	r5, r5, r3
	str	r5, [r6, #32]
	orr	r0, r9, r0, asl r2
	str	r0, [r6, #28]
	mov	r9, r0
	b	.L1245
.L1374:
	sub	r4, r4, #1
	cmp	r8, #0
	ubfx	r4, r4, #1, #24
	mov	r3, r3, asl #1
	add	r4, r4, #1
	sub	r5, r3, #65
	movge	r0, r9
	blt	.L1379
.L1301:
	mov	r3, r4, asl #24
	cmp	r3, r0
	rsbls	r0, r3, r0
	ldrls	r2, [r6, #36]
	movls	r3, #1
	movhi	r3, #0
	add	r3, r5, r3
	rsbls	r4, r4, r2
	add	r2, r7, r4
	ldrb	r1, [r2, #24]
	mov	r9, r0, asl r1
	rsb	r2, r1, r8
	mov	r4, r4, asl r1
	str	r9, [r6, #28]
	str	r2, [r6, #32]
	str	r4, [r6, #36]
	b	.L1300
.L1367:
	rsb	r2, r4, #24
	rsb	r8, r4, #16
	bic	r2, r2, #7
	mov	r0, r6
	rsb	r8, r2, r8
	str	r2, [fp, #-68]
	mov	r1, r2
	bl	BsGet
	and	r3, r8, #7
	ldr	r2, [fp, #-68]
	add	r4, r4, r2
	str	r4, [r6, #32]
	orr	r0, r9, r0, asl r3
	str	r0, [r6, #28]
	mov	r9, r0
	b	.L1282
.L1310:
	ldr	r1, [fp, #-76]
	mov	r0, r6
	ldr	r2, [fp, #12]
	bl	Vp9_ReadMvProbs
	b	.L1236
.L1376:
	sub	r4, r4, #1
	cmp	r9, #0
	ubfx	r4, r4, #1, #24
	mov	r8, r8, asl #1
	add	r4, r4, #1
	sub	r5, r8, #65
	movge	r0, r2
	blt	.L1380
.L1267:
	mov	r3, r4, asl #24
	cmp	r3, r0
	rsbls	r0, r3, r0
	ldrls	r1, [r6, #36]
	movls	r8, #1
	movhi	r8, #0
	add	r8, r5, r8
	rsbls	r4, r4, r1
	add	r3, r7, r4
	ldrb	r3, [r3, #24]
	mov	r2, r0, asl r3
	rsb	r9, r3, r9
	mov	r4, r4, asl r3
	str	r2, [r6, #28]
	str	r9, [r6, #32]
	str	r4, [r6, #36]
	b	.L1266
.L1382:
	.align	2
.L1381:
	.word	.LANCHOR0
.L1362:
	rsb	r2, r4, #24
	rsb	r8, r4, #16
	bic	r2, r2, #7
	mov	r0, r6
	rsb	r8, r2, r8
	str	r2, [fp, #-60]
	mov	r1, r2
	bl	BsGet
	and	r3, r8, #7
	ldr	r2, [fp, #-60]
	add	r4, r4, r2
	str	r4, [r6, #32]
	orr	r0, r9, r0, asl r3
	str	r0, [r6, #28]
	mov	r9, r0
	b	.L1248
.L1368:
	rsb	r2, r5, #24
	rsb	r8, r5, #16
	bic	r2, r2, #7
	mov	r0, r6
	rsb	r8, r2, r8
	str	r2, [fp, #-68]
	mov	r1, r2
	bl	BsGet
	ldr	r2, [fp, #-68]
	and	r3, r8, #7
	add	r8, r5, r2
	str	r8, [r6, #32]
	mov	r5, r8
	orr	r0, r4, r0, asl r3
	str	r0, [r6, #28]
	mov	r4, r0
	b	.L1289
.L1238:
	rsb	r2, r8, #24
	rsb	r3, r8, #16
	bic	r2, r2, #7
	mov	r0, r6
	rsb	r3, r2, r3
	ldr	r9, [r6, #28]
	mov	r1, r2
	str	r3, [fp, #-60]
	str	r2, [fp, #-56]
	bl	BsGet
	ldr	r3, [fp, #-60]
	ldr	r2, [fp, #-56]
	and	r3, r3, #7
	add	r8, r8, r2
	str	r8, [r6, #32]
	orr	r0, r9, r0, asl r3
	str	r0, [r6, #28]
	mov	r3, r0
	b	.L1239
.L1363:
	rsb	r2, r9, #24
	rsb	r8, r9, #16
	bic	r2, r2, #7
	mov	r0, r6
	rsb	r8, r2, r8
	str	r2, [fp, #-60]
	mov	r1, r2
	bl	BsGet
	and	r3, r8, #7
	ldr	r2, [fp, #-60]
	add	r9, r9, r2
	str	r9, [r6, #32]
	orr	r0, r4, r0, asl r3
	str	r0, [r6, #28]
	mov	r4, r0
	b	.L1255
.L1379:
	rsb	r1, r8, #24
	rsb	r3, r8, #16
	bic	r1, r1, #7
	mov	r0, r6
	rsb	r3, r1, r3
	add	r8, r1, r8
	str	r3, [fp, #-68]
	bl	BsGet
	ldr	r3, [fp, #-68]
	and	r3, r3, #7
	orr	r0, r9, r0, asl r3
	b	.L1301
.L1359:
	mov	r1, r6
	ldr	r0, [fp, #-72]
	bl	Vp9_ReadSwitchableInterpProbs
	b	.L1237
.L1380:
	rsb	r1, r9, #24
	rsb	r8, r9, #16
	bic	r1, r1, #7
	mov	r0, r6
	str	r2, [fp, #-60]
	rsb	r8, r1, r8
	add	r9, r1, r9
	bl	BsGet
	ldr	r2, [fp, #-60]
	and	r8, r8, #7
	orr	r0, r2, r0, asl r8
	b	.L1267
	.fnend
	.size	Vp9_PrepareReadModeInfo, .-Vp9_PrepareReadModeInfo
	.global	__aeabi_idiv
	.align	2
	.global	Vp9_AdaptCoefProbs
	.type	Vp9_AdaptCoefProbs, %function
Vp9_AdaptCoefProbs:
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
	mov	lr, #432
	mov	ip, r3, asl #9
	mul	lr, lr, r3
	add	ip, ip, r3, lsl #6
	ldr	r9, [fp, #4]
	mov	r4, r3, asl #11
	add	ip, ip, #9216
	add	r3, r4, r3, lsl #8
	add	ip, ip, #8
	add	r0, r0, lr
	add	r3, r2, r3
	str	r0, [fp, #-92]
	str	r3, [fp, #-116]
	add	r0, r2, ip
	add	r3, r1, lr
	str	r0, [fp, #-112]
	str	r3, [fp, #-96]
	mov	r3, #0
	str	r3, [fp, #-84]
.L1384:
	ldr	r3, [fp, #-112]
	str	r3, [fp, #-100]
	ldr	r3, [fp, #-116]
	str	r3, [fp, #-108]
	mov	r3, #0
	str	r3, [fp, #-104]
.L1395:
	mov	r3, #0
	str	r3, [fp, #-72]
	str	r3, [fp, #-64]
	ldr	r3, [fp, #-108]
	ldr	r2, [fp, #-100]
	str	r3, [fp, #-76]
	ldr	r3, [fp, #-104]
	str	r2, [fp, #-80]
	add	r3, r3, #2
	str	r3, [fp, #-88]
.L1393:
	ldr	r2, [fp, #-72]
	ldr	r3, [fp, #-88]
	ldr	r7, [fp, #-76]
	add	r3, r3, r2
	ldr	r2, [fp, #-80]
	str	r2, [fp, #-52]
	ldr	r2, [fp, #-84]
	add	r3, r3, r2
	ldr	r2, [fp, #-92]
	add	r10, r2, r3
	ldr	r2, [fp, #-96]
	add	r8, r2, r3
	mov	r3, #0
	str	r3, [fp, #-48]
	b	.L1391
.L1389:
	ldr	r2, [fp, #-52]
	ldr	r0, [r7]
	ldr	r4, [r7, #8]
	ldr	r3, [r2, #4]!
	str	r0, [fp, #-56]
	subs	r1, r3, #0
	ldrb	r5, [r8, #-2]
	str	r2, [fp, #-52]
	ldr	r2, [r7, #4]
	moveq	r6, #128
	add	r4, r2, r4
	str	r2, [fp, #-60]
	ldr	r2, [r7, #12]
	beq	.L1385
	mov	r0, r1, asr #1
	str	r3, [fp, #-68]
	add	r0, r0, r2, lsl #8
	bl	__aeabi_idiv
	ldr	r3, [fp, #-68]
	cmp	r0, #1
	movlt	r0, #1
	cmp	r0, #255
	movge	r0, #255
	uxtb	r6, r0
.L1385:
	cmp	r9, r3
	mov	r1, r9
	movcs	r0, r3
	ldr	r3, [fp, #8]
	movcc	r0, r9
	mul	r0, r3, r0
	bl	__aeabi_uidiv
	ldr	ip, [fp, #-56]
	adds	r3, r4, ip
	rsb	r2, r0, #256
	mul	r6, r6, r0
	mla	r5, r2, r5, r6
	moveq	r6, #128
	add	r5, r5, #128
	mov	r5, r5, asr #8
	strb	r5, [r10, #-2]
	ldrb	r5, [r8, #-1]
	beq	.L1386
	mov	r0, r3, asr #1
	mov	r1, r3
	add	r0, r0, ip, lsl #8
	str	r3, [fp, #-56]
	bl	__aeabi_idiv
	ldr	r3, [fp, #-56]
	cmp	r0, #1
	movlt	r0, #1
	cmp	r0, #255
	movge	r0, #255
	uxtb	r6, r0
.L1386:
	cmp	r3, r9
	mov	r1, r9
	movcc	r0, r3
	ldr	r3, [fp, #8]
	movcs	r0, r9
	mul	r0, r3, r0
	bl	__aeabi_uidiv
	cmp	r4, #0
	rsb	r3, r0, #256
	mul	r6, r6, r0
	mla	r5, r3, r5, r6
	moveq	r6, #128
	add	r5, r5, #128
	mov	r5, r5, asr #8
	strb	r5, [r10, #-1]
	ldrb	r5, [r8]
	beq	.L1387
	ldr	r3, [fp, #-60]
	mov	r0, r4, asr #1
	mov	r1, r4
	add	r0, r0, r3, lsl #8
	bl	__aeabi_idiv
	cmp	r0, #1
	movlt	r0, #1
	cmp	r0, #255
	movge	r0, #255
	uxtb	r6, r0
.L1387:
	ldr	r3, [fp, #-48]
	cmp	r4, r9
	mov	r1, r9
	add	r8, r8, #3
	add	r3, r3, #1
	str	r3, [fp, #-48]
	ldr	r3, [fp, #8]
	movcc	r0, r4
	movcs	r0, r9
	add	r7, r7, #16
	mul	r0, r3, r0
	bl	__aeabi_uidiv
	rsb	r3, r0, #256
	mul	r6, r6, r0
	mla	r5, r3, r5, r6
	add	r5, r5, #128
	ubfx	r5, r5, #8, #8
	strb	r5, [r10], #3
.L1391:
	ldr	r3, [fp, #-64]
	ldr	r2, [fp, #-48]
	cmp	r3, #0
	moveq	r3, #3
	movne	r3, #6
	cmp	r2, r3
	blt	.L1389
	ldr	r3, [fp, #-64]
	ldr	r2, [fp, #-72]
	add	r3, r3, #1
	str	r3, [fp, #-64]
	cmp	r3, #6
	ldr	r3, [fp, #-76]
	add	r2, r2, #18
	str	r2, [fp, #-72]
	add	r3, r3, #96
	str	r3, [fp, #-76]
	ldr	r3, [fp, #-80]
	add	r3, r3, #24
	str	r3, [fp, #-80]
	bne	.L1393
	ldr	r3, [fp, #-104]
	ldr	r2, [fp, #-108]
	add	r3, r3, #108
	str	r3, [fp, #-104]
	cmp	r3, #216
	ldr	r3, [fp, #-100]
	add	r2, r2, #576
	str	r2, [fp, #-108]
	add	r3, r3, #144
	str	r3, [fp, #-100]
	bne	.L1395
	ldr	r3, [fp, #-84]
	ldr	r2, [fp, #-116]
	add	r3, r3, #216
	str	r3, [fp, #-84]
	cmp	r3, #432
	ldr	r3, [fp, #-112]
	add	r2, r2, #1152
	str	r2, [fp, #-116]
	add	r3, r3, #288
	str	r3, [fp, #-112]
	bne	.L1384
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	.fnend
	.size	Vp9_AdaptCoefProbs, .-Vp9_AdaptCoefProbs
	.align	2
	.global	Vp9_AdaptResidualProbs
	.type	Vp9_AdaptResidualProbs, %function
Vp9_AdaptResidualProbs:
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
	ldr	r5, [fp, #12]
	mov	r7, r0
	ldr	ip, [fp, #8]
	mov	r6, r1
	clz	r3, r5
	ldr	r5, [fp, #4]
	adds	ip, ip, #0
	mov	r8, r2
	mov	r3, r3, lsr #5
	mov	r4, #0
	movne	ip, #1
	cmp	r5, #0
	orreq	ip, ip, #1
	cmp	r3, ip
	mov	r9, #24
	movhi	r5, #128
	movls	r5, #112
.L1402:
	mov	r3, r4
	str	r5, [sp, #4]
	str	r9, [sp]
	add	r4, r4, #1
	mov	r2, r8
	mov	r1, r6
	mov	r0, r7
	bl	Vp9_AdaptCoefProbs
	cmp	r4, #4
	bne	.L1402
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	Vp9_AdaptResidualProbs, .-Vp9_AdaptResidualProbs
	.align	2
	.global	Vp9_AdaptProbs
	.type	Vp9_AdaptProbs, %function
Vp9_AdaptProbs:
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
	mov	r4, r0
	ldrsb	r0, [r1, r0]
	mov	r5, r1
	mov	r7, r2
	cmp	r0, #0
	mov	r8, r3
	ldr	r6, [fp, #4]
	ble	.L1410
	str	r6, [sp]
	bl	Vp9_AdaptProbs
	add	r3, r5, r4
	mov	r9, r0
	ldrsb	r0, [r3, #1]
	cmp	r0, #0
	ble	.L1411
.L1408:
	mov	r1, r5
	str	r6, [sp]
	mov	r3, r8
	mov	r2, r7
	bl	Vp9_AdaptProbs
	mov	r5, r0
.L1409:
	ldrb	r0, [r8, r4, lsr #1]
	sub	r1, fp, #44
	str	r9, [fp, #-44]
	str	r5, [fp, #-40]
	bl	Vp9_ModeMvMergeProbs
	strb	r0, [r7, r4, lsr #1]
	add	r0, r5, r9
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1410:
	mov	r0, r0, asl #2
	add	r3, r5, r4
	rsb	r0, r0, #0
	ldr	r9, [r6, r0]
	ldrsb	r0, [r3, #1]
	cmp	r0, #0
	bgt	.L1408
.L1411:
	mov	r0, r0, asl #2
	rsb	r0, r0, #0
	ldr	r5, [r6, r0]
	b	.L1409
	.fnend
	.size	Vp9_AdaptProbs, .-Vp9_AdaptProbs
	.align	2
	.global	Vp9_AdaptModeProbs
	.type	Vp9_AdaptModeProbs, %function
Vp9_AdaptModeProbs:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #92
	sub	sp, sp, #92
	push	{lr}
	bl	__gnu_mcount_nc
	add	r10, r0, #1968
	add	r8, r1, #1968
	add	r4, r2, #8192
	add	r8, r8, #10
	add	r10, r10, #10
	mov	r6, r0
	mov	r7, r1
	mov	r9, r3
	mov	r5, #0
.L1413:
	ldr	r1, [r4, #3348]
	ldrb	r0, [r8, #1]!
	add	r1, r1, r5, lsl #3
	add	r5, r5, #1
	bl	Vp9_ModeMvMergeProbs
	cmp	r5, #4
	strb	r0, [r10, #1]!
	bne	.L1413
	add	r8, r7, #1968
	add	r10, r6, #1968
	add	r8, r8, #14
	add	r10, r10, #14
	mov	r5, #0
.L1414:
	ldr	r1, [r4, #3352]
	ldrb	r0, [r8, #1]!
	add	r1, r1, r5, lsl #3
	add	r5, r5, #1
	bl	Vp9_ModeMvMergeProbs
	cmp	r5, #5
	strb	r0, [r10, #1]!
	bne	.L1414
	add	r8, r7, #1984
	add	r10, r6, #1984
	add	r8, r8, #13
	add	r10, r10, #13
	mov	r5, #0
.L1415:
	ldr	r1, [r4, #3360]
	ldrb	r0, [r8, #1]!
	add	r1, r1, r5, lsl #3
	add	r5, r5, #1
	bl	Vp9_ModeMvMergeProbs
	cmp	r5, #5
	strb	r0, [r10, #1]!
	bne	.L1415
	mov	r10, r6
	mov	r8, r7
	mov	r5, #8
	str	r7, [fp, #-100]
	str	r6, [fp, #-96]
.L1416:
	ldr	r1, [r4, #3356]
	sub	r3, r5, #8
	ldrb	r0, [r8, #1988]
	add	r10, r10, #2
	add	r1, r1, r3
	add	r8, r8, #2
	bl	Vp9_ModeMvMergeProbs
	strb	r0, [r10, #1986]
	ldr	r1, [r4, #3356]
	ldrb	r0, [r8, #1987]
	add	r1, r1, r5
	add	r5, r5, #16
	bl	Vp9_ModeMvMergeProbs
	cmp	r5, #88
	strb	r0, [r10, #1987]
	bne	.L1416
	mov	r8, #0
	mov	r5, r8
.L1417:
	ldr	r0, [r4, #3344]
	add	r2, r8, #1952
	add	r2, r2, #6
	ldr	r1, .L1457
	add	r0, r0, r5
	add	r3, r7, r2
	str	r0, [sp]
	add	r2, r6, r2
	add	r5, r5, #16
	mov	r0, #0
	bl	Vp9_AdaptProbs
	cmp	r5, #112
	add	r8, r8, #3
	bne	.L1417
	mov	r8, #0
	mov	r5, r8
.L1418:
	ldr	r0, [r4, #1024]
	add	r2, r8, #1728
	add	r3, r7, r2
	ldr	r1, .L1457+4
	add	r0, r0, r5
	add	r2, r6, r2
	str	r0, [sp]
	add	r5, r5, #40
	mov	r0, #0
	add	r8, r8, #9
	bl	Vp9_AdaptProbs
	cmp	r5, #160
	bne	.L1418
	mov	r8, #0
	mov	r5, r8
.L1419:
	ldr	r0, [r4, #1028]
	add	r2, r8, #1760
	add	r2, r2, #4
	ldr	r1, .L1457+4
	add	r0, r0, r5
	add	r3, r7, r2
	str	r0, [sp]
	add	r2, r6, r2
	add	r5, r5, #40
	mov	r0, #0
	bl	Vp9_AdaptProbs
	cmp	r5, #400
	add	r8, r8, #9
	bne	.L1419
	mov	r8, #0
	mov	r5, r8
.L1420:
	ldr	r0, [r4, #1032]
	add	r2, r8, #1888
	add	r2, r2, #14
	ldr	r1, .L1457+8
	add	r0, r0, r5
	add	r3, r7, r2
	str	r0, [sp]
	add	r2, r6, r2
	add	r5, r5, #16
	mov	r0, #0
	bl	Vp9_AdaptProbs
	cmp	r5, #256
	add	r8, r8, #3
	bne	.L1420
	cmp	r9, #4
	beq	.L1455
	ldr	r3, [fp, #4]
	cmp	r3, #4
	beq	.L1456
.L1431:
	add	r7, r7, #2000
	add	r6, r6, #2000
	add	r7, r7, #14
	add	r6, r6, #14
	mov	r5, #0
.L1427:
	ldr	r1, [r4, #3376]
	ldrb	r0, [r7, #1]!
	add	r1, r1, r5, lsl #3
	add	r5, r5, #1
	bl	Vp9_ModeMvMergeProbs
	cmp	r5, #3
	strb	r0, [r6, #1]!
	bne	.L1427
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1455:
	mov	r9, #0
	mov	r5, r9
.L1422:
	ldr	ip, [r4, #3340]
	add	r2, r9, #1936
	add	r2, r2, #14
	ldr	r1, .L1457+12
	add	ip, ip, r5
	add	r3, r7, r2
	mov	r0, #0
	add	r2, r6, r2
	str	ip, [sp]
	add	r5, r5, #12
	bl	Vp9_AdaptProbs
	cmp	r5, #48
	add	r9, r9, #2
	bne	.L1422
	ldr	r3, [fp, #4]
	cmp	r3, #4
	bne	.L1431
.L1456:
	mov	r8, #0
	add	r3, r7, #2000
	add	r2, r6, #2000
	str	r6, [fp, #-120]
	str	r7, [fp, #-124]
	mov	r7, r8
	ldr	r6, [fp, #-96]
	mov	r1, r3
	ldr	r8, [fp, #-100]
	add	r3, r3, #12
	str	r3, [fp, #-116]
	add	r3, r2, #12
	str	r3, [fp, #-112]
	add	r3, r1, #2
	str	r3, [fp, #-108]
	add	r3, r2, #2
	str	r3, [fp, #-104]
.L1426:
	ldr	r3, [fp, #-116]
	sub	r1, fp, #92
	ldr	ip, [r4, #3372]
	mov	r5, r7, asl #4
	ldr	r10, [fp, #-104]
	ldrb	r0, [r3, #1]!
	ldr	r9, [fp, #-108]
	str	r3, [fp, #-116]
	ldr	r3, [ip, r7, asl #3]
	add	ip, ip, r7, lsl #3
	str	r3, [fp, #-92]
	ldr	r3, [ip, #4]
	str	r3, [fp, #-88]
	bl	Vp9_ModeMvMergeProbs
	ldr	r3, [fp, #-112]
	sub	ip, r5, r7, asl #2
	sub	r1, fp, #84
	str	r5, [fp, #-96]
	mov	r5, #0
	strb	r0, [r3, #1]!
	ldr	r0, [r4, #3368]
	str	r3, [fp, #-112]
	ldr	lr, [r0, ip]
	add	r0, r0, ip
	str	lr, [fp, #-84]
	ldmib	r0, {ip, lr}
	add	ip, ip, lr
	str	ip, [fp, #-80]
	ldr	ip, [r0, #4]
	str	ip, [fp, #-76]
	ldr	ip, [r0, #8]
	ldrb	r0, [r8, #2009]
	str	ip, [fp, #-72]
	bl	Vp9_ModeMvMergeProbs
	sub	r1, fp, #76
	strb	r0, [r6, #2009]
	ldrb	r0, [r8, #2010]
	bl	Vp9_ModeMvMergeProbs
	ldr	r3, [fp, #-96]
	strb	r0, [r6, #2010]
	ldr	r1, [r4, #3364]
	add	r3, r1, r3
	ldr	r1, [r1, r7, asl #4]
	str	r1, [fp, #-68]
	ldmib	r3, {r0, r1}
	add	r1, r1, r0
	ldr	r0, [r3, #12]
	add	r1, r1, r0
	str	r1, [fp, #-64]
	ldr	r1, [r3, #4]
	str	r1, [fp, #-60]
	ldr	r1, [r3, #8]
	add	r1, r1, r0
	str	r1, [fp, #-56]
	ldr	r1, [r3, #8]
	str	r1, [fp, #-52]
	ldr	r3, [r3, #12]
	str	r3, [fp, #-48]
.L1425:
	sub	r3, fp, #68
	ldrb	r0, [r9, #1]!
	add	r1, r3, r5
	add	r5, r5, #8
	bl	Vp9_ModeMvMergeProbs
	cmp	r5, #24
	strb	r0, [r10, #1]!
	bne	.L1425
	ldr	r3, [fp, #-108]
	add	r7, r7, #1
	cmp	r7, #2
	add	r8, r8, #2
	add	r3, r3, #3
	str	r3, [fp, #-108]
	ldr	r3, [fp, #-104]
	add	r6, r6, #2
	add	r3, r3, #3
	str	r3, [fp, #-104]
	bne	.L1426
	ldr	r6, [fp, #-120]
	ldr	r7, [fp, #-124]
	b	.L1431
.L1458:
	.align	2
.L1457:
	.word	.LANCHOR0+536
	.word	.LANCHOR0+544
	.word	.LANCHOR0+564
	.word	.LANCHOR0+572
	.fnend
	.size	Vp9_AdaptModeProbs, .-Vp9_AdaptModeProbs
	.align	2
	.global	Vp9_AdaptMvProbs
	.type	Vp9_AdaptMvProbs, %function
Vp9_AdaptMvProbs:
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
	mov	r7, r0
	mov	r8, r1
	mov	r4, r2
	str	r2, [fp, #-92]
	ldr	r1, .L1468
	mov	r2, #6
	sub	r0, fp, #84
	str	r3, [fp, #-96]
	bl	memcpy
	mov	r2, #20
	ldr	r1, .L1468+4
	sub	r0, fp, #64
	bl	memcpy
	mov	r2, #6
	ldr	r1, .L1468
	sub	r0, fp, #78
	bl	memcpy
	add	r1, r4, #8192
	add	r3, r8, #2016
	add	r2, r7, #2016
	ldr	ip, [r1, #3380]
	add	r3, r3, #2
	sub	r1, fp, #84
	add	r2, r2, #2
	mov	r0, #0
	str	ip, [sp]
	bl	Vp9_AdaptProbs
	mov	r3, #0
	str	r3, [fp, #-88]
.L1462:
	ldr	r2, [fp, #-88]
	mov	r4, #0
	ldr	r3, [fp, #-92]
	mov	r6, r8
	ldrb	r0, [r8, #2021]
	mov	r5, r7
	add	r9, r3, r2, lsl #5
	add	r3, r9, #11520
	add	r10, r9, #11584
	add	r10, r10, #4
	ldr	r1, [r3, #56]
	bl	Vp9_ModeMvMergeProbs
	add	lr, r9, #11520
	add	lr, lr, #60
	add	r3, r8, #2016
	add	r2, r7, #2016
	add	r3, r3, #6
	add	r2, r2, #6
	sub	r1, fp, #64
	strb	r0, [r7, #2021]
	mov	r0, r4
	ldr	lr, [lr]
	str	lr, [sp]
	bl	Vp9_AdaptProbs
	add	r3, r9, #11584
	ldrb	r0, [r6, #2032]!
	sub	r1, fp, #72
	ldr	r3, [r3]
	ldmia	r3, {r2, r3}
	str	r2, [fp, #-72]
	str	r3, [fp, #-68]
	bl	Vp9_ModeMvMergeProbs
	strb	r0, [r5, #2032]!
.L1460:
	ldr	r1, [r10]
	ldrb	r0, [r6, #1]!
	add	r1, r1, r4, lsl #3
	add	r4, r4, #1
	bl	Vp9_ModeMvMergeProbs
	cmp	r4, #10
	strb	r0, [r5, #1]!
	bne	.L1460
	add	r4, r9, #11584
	add	r3, r8, #2032
	add	r2, r7, #2032
	add	r3, r3, #11
	ldr	ip, [r4, #8]
	add	r2, r2, #11
	sub	r1, fp, #78
	mov	r0, #0
	str	ip, [sp]
	bl	Vp9_AdaptProbs
	ldr	r1, [r4, #8]
	add	r3, r8, #2032
	add	r2, r7, #2032
	add	r1, r1, #16
	add	r3, r3, #14
	str	r1, [sp]
	add	r2, r2, #14
	sub	r1, fp, #78
	mov	r0, #0
	bl	Vp9_AdaptProbs
	add	r1, r9, #11584
	add	r3, r8, #2048
	add	r2, r7, #2048
	ldr	ip, [r1, #12]
	add	r3, r3, #1
	add	r2, r2, #1
	sub	r1, fp, #78
	mov	r0, #0
	str	ip, [sp]
	bl	Vp9_AdaptProbs
	ldr	r3, [fp, #-96]
	cmp	r3, #0
	beq	.L1461
	add	r3, r9, #11584
	ldrb	r0, [r8, #2052]
	add	r9, r9, #11584
	ldr	r1, [r3, #16]
	bl	Vp9_ModeMvMergeProbs
	strb	r0, [r7, #2052]
	ldr	r1, [r9, #20]
	ldrb	r0, [r8, #2053]
	bl	Vp9_ModeMvMergeProbs
	strb	r0, [r7, #2053]
.L1461:
	ldr	r3, [fp, #-88]
	add	r8, r8, #33
	add	r7, r7, #33
	add	r3, r3, #1
	str	r3, [fp, #-88]
	cmp	r3, #2
	bne	.L1462
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1469:
	.align	2
.L1468:
	.word	.LANCHOR0+576
	.word	.LANCHOR0+584
	.fnend
	.size	Vp9_AdaptMvProbs, .-Vp9_AdaptMvProbs
	.align	2
	.global	Lf_Init_Lut
	.type	Lf_Init_Lut, %function
Lf_Init_Lut:
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
	mov	r2, #1
	strb	r3, [r0, #64]
	strb	r3, [r0, #67]
	strb	r3, [r0, #68]
	strb	r3, [r0, #69]
	strb	r3, [r0, #70]
	strb	r3, [r0, #71]
	strb	r3, [r0, #72]
	strb	r3, [r0, #65]
	strb	r3, [r0, #66]
	strb	r3, [r0, #73]
	strb	r3, [r0, #76]
	strb	r2, [r0, #74]
	strb	r2, [r0, #75]
	strb	r2, [r0, #77]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Lf_Init_Lut, .-Lf_Init_Lut
	.align	2
	.global	VP9_Loop_Filter_Init
	.type	VP9_Loop_Filter_Init, %function
VP9_Loop_Filter_Init:
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
	mov	r2, #1
	strb	r3, [r1, #64]
	strb	r3, [r1, #67]
	strb	r3, [r1, #68]
	strb	r3, [r1, #69]
	strb	r3, [r1, #70]
	strb	r3, [r1, #71]
	strb	r3, [r1, #72]
	strb	r3, [r1, #65]
	strb	r3, [r1, #66]
	strb	r3, [r1, #73]
	strb	r3, [r1, #76]
	strb	r2, [r1, #74]
	strb	r2, [r1, #75]
	strb	r2, [r1, #77]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VP9_Loop_Filter_Init, .-VP9_Loop_Filter_Init
	.align	2
	.global	VP9_InitDecPara
	.type	VP9_InitDecPara, %function
VP9_InitDecPara:
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
	ldr	r7, .L1473
	add	r4, r0, #266240
	mov	r6, r0
	add	r8, r4, #2064
	add	r6, r6, #270336
	mov	r1, #0
	movw	r2, #2860
	ldr	r3, [r7, #48]
	mov	r0, r8
	mov	r5, r1
	blx	r3
	mov	r3, #3
	add	r0, r6, #832
	str	r3, [r6, #408]
	bl	ResetVoQueue
	ldr	r3, [r7, #48]
	mov	r2, #2
	add	r0, r8, #56
	str	r2, [r4, #2292]
	mov	r1, r5
	str	r5, [r4, #2288]
	mov	r2, #16
	blx	r3
	mov	r3, #1
	strb	r5, [r4, #2376]
	strb	r5, [r4, #2379]
	strb	r5, [r4, #2380]
	strb	r5, [r4, #2381]
	strb	r5, [r4, #2382]
	strb	r5, [r4, #2383]
	strb	r5, [r4, #2384]
	strb	r5, [r4, #2377]
	strb	r5, [r4, #2378]
	strb	r5, [r4, #2385]
	strb	r5, [r4, #2388]
	strb	r3, [r4, #2386]
	strb	r3, [r4, #2387]
	strb	r3, [r4, #2389]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1474:
	.align	2
.L1473:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VP9_InitDecPara, .-VP9_InitDecPara
	.align	2
	.global	VP9DEC_Init
	.type	VP9DEC_Init, %function
VP9DEC_Init:
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
	add	r4, r0, #270336
	mov	r5, r0
	mov	r6, r1
	mov	r0, #2
	ldr	r1, .L1485
	ldr	r8, .L1485+4
	bl	dprint_vfmw
	ldr	r9, [r4, #1176]
	movw	r2, #31640
	movt	r2, 4
	mov	r1, #0
	ldr	r3, [r8, #48]
	mov	r0, r5
	blx	r3
	add	r0, r4, #832
	str	r9, [r4, #1176]
	add	r7, r5, #290816
	bl	ResetVoQueue
	str	r6, [r5]
	mov	r0, r5
	bl	VCTRL_GetChanIDByCtx
	cmn	r0, #1
	str	r0, [r7, #2948]
	beq	.L1484
	add	r6, r5, #266240
	mvn	r3, #0
	mov	r4, #0
	mov	r2, #3
	str	r3, [r6, #2004]
	ldr	r3, [r5]
	ldr	r1, [r3, #8]
	str	r2, [r6, #2060]
	str	r2, [r6, #2008]
	str	r1, [r6, #2000]
	str	r4, [r6, #2012]
	ldr	r0, [r3, #48]
	str	r0, [r6, #2016]
	ldr	r3, [r3, #52]
	str	r3, [r6, #2020]
	bl	MEM_Phy2Vir
	ldr	r3, [r8, #48]
	mov	r1, r4
	mov	r2, #2048
	str	r2, [r6, #2028]
	mov	r2, #32
	str	r0, [r6, #2024]
	movw	r0, #31532
	str	r4, [r7, #2824]
	movt	r0, 4
	str	r4, [r7, #2828]
	add	r0, r5, r0
	str	r4, [r7, #2852]
	str	r4, [r7, #2856]
	str	r4, [r7, #2892]
	str	r4, [r7, #2896]
	blx	r3
	mov	r0, r5
	bl	VP9_InitDecPara
	movw	r2, #6228
	movw	r0, #6264
	movt	r2, 4
	movt	r0, 4
	add	r2, r5, r2
	add	r0, r5, r0
	mov	r1, r4
	mov	r3, r2
	mov	ip, r0
.L1478:
	str	r1, [r3, #4]!
	cmp	r3, r0
	str	r1, [ip, #4]!
	bne	.L1478
	movw	r3, #6344
	movw	r1, #6380
	movt	r3, 4
	movt	r1, 4
	add	r3, r5, r3
	add	r1, r5, r1
	mvn	r0, #0
.L1479:
	str	r0, [r3, #4]!
	cmp	r3, r1
	bne	.L1479
	movw	r1, #6300
	mov	r3, #0
	movt	r1, 4
	add	r1, r5, r1
	mov	r0, #1
.L1480:
	str	r3, [r1, #4]!
	add	r3, r3, #1
	cmp	r3, #8
	str	r0, [r2, #4]!
	bne	.L1480
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1484:
	ldr	r1, .L1485+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #19
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1486:
	.align	2
.L1485:
	.word	.LC3
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC4
	.fnend
	.size	VP9DEC_Init, .-VP9DEC_Init
	.align	2
	.global	Vp9_ParseSuperFrameIndex
	.type	Vp9_ParseSuperFrameIndex, %function
Vp9_ParseSuperFrameIndex:
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
	ble	.L1499
	add	ip, r0, r1
	mov	r5, #0
	ldrb	ip, [ip, #-1]
	str	r5, [r3]
	and	lr, ip, #224
	cmp	lr, #192
	ldmnefd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	and	r6, ip, #7
	ubfx	r8, ip, #3, #2
	add	r6, r6, #1
	add	r7, r8, #1
	mul	r4, r6, r7
	add	r4, r4, #2
	cmp	r1, r4
	ldmltfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	rsb	lr, r4, r1
	ldrb	lr, [r0, lr]
	cmp	lr, ip
	ldmnefd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	add	r1, r1, #1
	cmp	r6, r5
	rsb	r1, r4, r1
	add	r4, r0, r1
	beq	.L1490
	sub	r9, r2, #4
.L1491:
	cmp	r7, #0
	beq	.L1494
	mov	r2, #0
	sub	r1, r4, #1
	add	lr, r4, r8
	mov	r0, r2
.L1492:
	ldrb	ip, [r1, #1]!
	cmp	r1, lr
	orr	r0, r0, ip, asl r2
	add	r2, r2, #8
	bne	.L1492
	add	r4, r4, r7
.L1493:
	add	r5, r5, #1
	str	r0, [r9, #4]!
	cmp	r6, r5
	bhi	.L1491
.L1490:
	str	r6, [r3]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1499:
	ldr	r1, .L1500
	mov	r0, #1
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1494:
	mov	r0, r7
	b	.L1493
.L1501:
	.align	2
.L1500:
	.word	.LC5
	.fnend
	.size	Vp9_ParseSuperFrameIndex, .-Vp9_ParseSuperFrameIndex
	.align	2
	.global	VP9_GetImageBuffer
	.type	VP9_GetImageBuffer, %function
VP9_GetImageBuffer:
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
	add	r5, r0, #270336
	add	r4, r0, #290816
	add	r6, r0, #266240
	ldr	r3, [r5, #428]
	ldr	r0, [r4, #2948]
	cmp	r3, #1
	moveq	r1, #0
	movne	r1, #1
	bl	FSP_NewLogicFs
	cmp	r0, #0
	str	r0, [r6, #2048]
	blt	.L1514
	mov	r1, r0
	ldr	r0, [r4, #2948]
	bl	FSP_GetLogicFs
	subs	r7, r0, #0
	beq	.L1515
	ldr	r2, [r6, #2048]
	mov	r0, #18
	ldr	r1, .L1518
	bl	dprint_vfmw
	ldr	r2, [r7, #608]
	cmp	r2, #0
	beq	.L1513
	ldr	r3, [r7, #612]
	cmp	r3, #0
	beq	.L1513
	ldr	r1, [r7, #616]
	cmp	r1, #0
	beq	.L1513
	ldr	ip, [r1, #16]
	mov	r0, #18
	ldr	r3, [r3, #16]
	ldr	r2, [r2, #16]
	ldr	r1, .L1518+4
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [r5, #428]
	cmp	r3, #1
	beq	.L1516
	ldr	r2, [r7, #608]
	mov	r3, #0
	mov	r0, r3
	str	r3, [r2, #4]
	b	.L1506
.L1513:
	mvn	r0, #0
.L1506:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1514:
	ldr	r1, .L1518+8
	mov	r0, #0
	bl	dprint_vfmw
	add	r1, r5, #832
	ldr	r0, [r4, #2948]
	bl	FSP_ClearNotInVoQueue
	mvn	r0, #0
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1515:
	movw	r2, #2037
	ldr	r1, .L1518+12
	mov	r0, #22
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1516:
	ldr	r3, [r5, #432]
	cmp	r3, #8
	bls	.L1509
	ldr	r2, .L1518+16
	mov	r0, #0
	ldr	r1, .L1518+20
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1506
.L1509:
	add	r6, r6, r3, lsl #2
	ldr	r0, [r4, #2948]
	ldr	r1, [r6, #2252]
	bl	FSP_GetLogicFs
	subs	r3, r0, #0
	beq	.L1517
	ldr	ip, [r3, #608]
	add	r1, r3, #8
	mov	r2, #592
	add	r0, r7, #8
	str	ip, [r7, #608]
	ldr	lr, [r3, #608]
	str	lr, [r7, #612]
	ldr	r3, [r3, #616]
	str	r3, [r7, #616]
	ldr	r3, [ip, #88]
	str	r3, [r7, #600]
	bl	memcpy
	ldrsb	r2, [r7, #3]
	mov	r3, #0
	strb	r3, [r7, #2]
	mov	r0, r3
	str	r2, [r7, #164]
	b	.L1506
.L1517:
	ldr	r3, .L1518+24
	movw	r2, #2060
	ldr	r1, .L1518+28
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1506
.L1519:
	.align	2
.L1518:
	.word	.LC8
	.word	.LC9
	.word	.LC6
	.word	.LC7
	.word	.LANCHOR0+604
	.word	.LC10
	.word	.LC11
	.word	.LC12
	.fnend
	.size	VP9_GetImageBuffer, .-VP9_GetImageBuffer
	.align	2
	.global	VP9_SetImgFormat
	.type	VP9_SetImgFormat, %function
VP9_SetImgFormat:
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
	subs	r3, r0, #0
	str	r3, [fp, #-48]
	beq	.L1520
	add	r8, r3, #266240
	mov	r4, r3
	add	r3, r3, #290816
	ldr	r1, [r8, #2048]
	ldr	r0, [r3, #2948]
	bl	FSP_GetFsImagePtr
	subs	r10, r0, #0
	beq	.L1520
	ldr	r3, [r4]
	add	ip, r10, #576
	mvn	r6, #0
	mvn	r7, #0
	mov	r1, #0
	ldrd	r2, [r3, #56]
	strd	r2, [ip, #-8]
	ldr	r3, [r4]
	strd	r6, [r3, #56]
	ldr	r3, [r8, #2056]
	and	r3, r3, #3
	str	r3, [r10, #100]
	orr	r2, r3, #7168
	str	r3, [r10, #104]
	orr	r2, r2, #32
	str	r2, [r10, #108]
	bl	SetAspectRatio
	ldr	lr, [r8, #2076]
	str	lr, [r10, #112]
	ldr	ip, [r8, #2080]
	str	ip, [r10, #116]
	ldr	r3, [r4]
	ldr	r3, [r3, #28]
	cmp	r3, #25
	addne	r6, r10, #480
	beq	.L1532
.L1524:
	add	r1, lr, #255
	add	r0, ip, #63
	bic	r2, r1, #255
	bic	r1, r0, #63
	mov	r3, r2, asl #4
	str	r3, [r10, #140]
	ldr	r3, [fp, #-48]
	mul	r1, r2, r1
	ldr	r3, [r3, #4]
	add	r3, r3, #266240
	ldr	r3, [r3, #1948]
	cmp	r3, #1
	movne	r2, #0
	movne	r3, r2
	beq	.L1533
.L1525:
	ldr	r7, [r10, #44]
	mov	r0, lr, lsr #1
	str	r3, [r10, #144]
	mov	r5, ip, lsr #1
	str	r2, [r10, #148]
	add	r3, r1, r7
	str	r3, [r10, #48]
	ldrd	r2, [r6, #-8]
	adds	r8, r2, r1
	adc	r9, r3, r1, asr #31
	strd	r8, [r6]
	str	lr, [r10, #120]
	str	r0, [r10, #128]
	str	ip, [r10, #124]
	str	r5, [r10, #132]
.L1520:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1533:
	add	r3, lr, #508
	mov	r2, r0, lsr #6
	add	r3, r3, #3
	bic	r3, r3, #508
	mov	r2, r2, asl #5
	bic	r3, r3, #3
	mov	r3, r3, lsr #5
	mul	r2, r3, r2
	add	r1, r1, r2
	b	.L1525
.L1532:
	ldr	r2, [r10, #140]
	add	r3, ip, #15
	add	r6, r10, #480
	ldr	ip, [r10, #44]
	mov	r3, r3, lsr #4
	add	r1, r10, #496
	mov	r0, r2, asl #4
	add	r7, ip, r2
	mul	r3, r3, r0
	add	lr, r3, ip
	str	lr, [r10, #48]
	ldrd	r8, [r6, #-8]
	add	r2, lr, r2
	mov	r0, lr
	adds	r4, r8, r3
	adc	r5, r9, r3, asr #31
	strd	r4, [r6]
	str	lr, [r10, #32]
	str	ip, [r10, #28]
	str	r7, [r10, #36]
	mov	r7, r1
	str	r2, [r10, #40]
	strd	r8, [r1, #-8]
	str	ip, [r10, #60]
	bl	MEM_Phy2Vir
	mov	r3, #0
	str	r0, [r10, #496]
	str	r3, [r7, #4]
	ldr	r3, [r10, #32]
	ldr	lr, [r10, #112]
	ldr	ip, [r10, #116]
	str	r3, [r10, #64]
	b	.L1524
	.fnend
	.size	VP9_SetImgFormat, .-VP9_SetImgFormat
	.align	2
	.global	VP9DEC_RecycleImage
	.type	VP9DEC_RecycleImage, %function
VP9DEC_RecycleImage:
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
	add	r4, r0, #290816
	mov	r5, r1
	mov	r2, #0
	ldr	r0, [r4, #2948]
	bl	FSP_SetDisplay
	mov	r1, r5
	ldr	r0, [r4, #2948]
	bl	FSP_GetFsImagePtr
	cmp	r0, #0
	beq	.L1535
	add	r5, r0, #544
	add	r8, r0, #528
	ldr	r1, [r0, #528]
	mov	r6, #0
	ldr	r0, [r4, #2948]
	mov	r7, #0
	bl	FreeUsdByDec
	strd	r6, [r8]
	ldr	r0, [r4, #2948]
	ldr	r1, [r5, #-8]
	bl	FreeUsdByDec
	strd	r6, [r5, #-8]
.L1535:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	VP9DEC_RecycleImage, .-VP9DEC_RecycleImage
	.align	2
	.global	VP9DEC_GetRemainImg
	.type	VP9DEC_GetRemainImg, %function
VP9DEC_GetRemainImg:
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
	add	r0, r0, #270336
	add	r0, r0, #832
	bl	GetVoLastImageID
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VP9DEC_GetRemainImg, .-VP9DEC_GetRemainImg
	.align	2
	.global	VP9DEC_GetImageBuffer
	.type	VP9DEC_GetImageBuffer, %function
VP9DEC_GetImageBuffer:
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
	add	r4, r0, #290816
	mov	r5, r0
	ldr	r0, [r4, #2948]
	bl	FSP_IsNewFsAvalible
	cmp	r0, #1
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r0, [r4, #2948]
	bl	FSP_IsNewFsAvalible
	cmn	r0, #1
	beq	.L1546
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1546:
	add	r1, r5, #270336
	ldr	r0, [r4, #2948]
	add	r1, r1, #832
	bl	FSP_ClearNotInVoQueue
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	VP9DEC_GetImageBuffer, .-VP9DEC_GetImageBuffer
	.align	2
	.global	Check_Sync_Code
	.type	Check_Sync_Code, %function
Check_Sync_Code:
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
	mov	r1, #8
	mov	r4, r0
	bl	BsGet
	cmp	r0, #73
	beq	.L1548
.L1550:
	ldr	r1, .L1551
	mov	r0, #1
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1548:
	mov	r1, #8
	mov	r0, r4
	bl	BsGet
	cmp	r0, #131
	bne	.L1550
	mov	r0, r4
	mov	r1, #8
	bl	BsGet
	cmp	r0, #66
	bne	.L1550
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1552:
	.align	2
.L1551:
	.word	.LC13
	.fnend
	.size	Check_Sync_Code, .-Check_Sync_Code
	.align	2
	.global	Read_Frame_Size
	.type	Read_Frame_Size, %function
Read_Frame_Size:
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
	mov	r5, r1
	mov	r1, #16
	mov	r4, r2
	mov	r6, r0
	bl	BsGet
	mov	r1, #16
	add	r3, r0, #1
	mov	r0, r6
	str	r3, [r5]
	bl	BsGet
	add	r0, r0, #1
	str	r0, [r4]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	Read_Frame_Size, .-Read_Frame_Size
	.align	2
	.global	get_free_fb
	.type	get_free_fb, %function
get_free_fb:
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
	ldr	r0, [r1, #72]
	cmp	r0, #0
	beq	.L1555
	add	r3, r1, #72
	mov	r0, #1
.L1556:
	ldr	r2, [r3, #4]!
	cmp	r2, #0
	beq	.L1555
	add	r0, r0, #1
	cmp	r0, #9
	bne	.L1556
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1555:
	add	r3, r0, #18
	mov	r2, #1
	str	r2, [r1, r3, asl #2]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	get_free_fb, .-get_free_fb
	.align	2
	.global	Setup_Display_Size
	.type	Setup_Display_Size, %function
Setup_Display_Size:
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
	mov	r3, r1
	mov	r1, #1
	ldr	lr, [r3, #52]
	mov	r2, #0
	ldr	ip, [r3, #56]
	mov	r4, r0
	str	r2, [fp, #-28]
	str	lr, [r3, #60]
	str	ip, [r3, #64]
	str	r2, [fp, #-24]
	bl	BsGet
	cmp	r0, #0
	beq	.L1564
	mov	r0, r4
	sub	r2, fp, #24
	sub	r1, fp, #28
	bl	Read_Frame_Size
.L1564:
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
	.fnend
	.size	Setup_Display_Size, .-Setup_Display_Size
	.align	2
	.global	VP9_Update_CP_Size
	.type	VP9_Update_CP_Size, %function
VP9_Update_CP_Size:
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
	ldr	lr, [r0, #2484]
	ldr	ip, [r0, #2488]
	ldr	r3, [r0, #2432]
	add	r1, lr, #7
	add	r2, ip, #7
	bic	r1, r1, #7
	bic	r2, r2, #7
	add	r3, r0, r3, lsl #4
	mov	r5, r1, asr #3
	mov	r4, r2, asr #3
	str	r5, [r0, #2524]
	str	r4, [r0, #2528]
	str	r1, [r3, #2668]
	str	r2, [r3, #2672]
	str	lr, [r3, #2676]
	str	ip, [r3, #2680]
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	VP9_Update_CP_Size, .-VP9_Update_CP_Size
	.align	2
	.global	Setup_Frame_Size
	.type	Setup_Frame_Size, %function
Setup_Frame_Size:
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
	ldr	ip, [r1, #2484]
	ldr	r3, [r1, #2488]
	mov	r4, r1
	add	r5, r1, #2432
	mov	r6, r0
	add	r2, r5, #56
	add	r1, r5, #52
	str	ip, [r4, #2504]
	str	r3, [r4, #2508]
	bl	Read_Frame_Size
	ldr	r7, [r4, #2484]
	ldr	lr, [r4, #2488]
	mov	r1, r5
	ldr	r3, [r4, #2432]
	add	ip, r7, #7
	add	r2, lr, #7
	bic	ip, ip, #7
	bic	r2, r2, #7
	mov	r0, r6
	add	r3, r4, r3, lsl #4
	mov	r6, ip, asr #3
	mov	r5, r2, asr #3
	str	r6, [r4, #2524]
	str	r5, [r4, #2528]
	str	ip, [r3, #2668]
	str	r2, [r3, #2672]
	str	r7, [r3, #2676]
	str	lr, [r3, #2680]
	bl	Setup_Display_Size
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	Setup_Frame_Size, .-Setup_Frame_Size
	.align	2
	.global	setup_frame_size_with_refs
	.type	setup_frame_size_with_refs, %function
setup_frame_size_with_refs:
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
	add	r7, r1, #2432
	mov	r4, r1
	mov	r6, r0
	mov	r5, #0
.L1574:
	mov	r1, #1
	mov	r0, r6
	bl	BsGet
	cmp	r0, #0
	bne	.L1580
	add	r5, r5, #1
	cmp	r5, #3
	bne	.L1574
	ldr	ip, [r4, #2484]
	add	r2, r7, #56
	ldr	r3, [r4, #2488]
	add	r1, r7, #52
	mov	r0, r6
	str	ip, [r4, #2504]
	str	r3, [r4, #2508]
	bl	Read_Frame_Size
	ldr	r5, [r4, #2484]
	ldr	lr, [r4, #2488]
.L1573:
	ldr	r3, [r4, #2432]
	add	ip, r5, #7
	add	r2, lr, #7
	bic	ip, ip, #7
	bic	r2, r2, #7
	mov	r1, r7
	add	r3, r4, r3, lsl #4
	mov	r0, r6
	mov	r7, ip, asr #3
	mov	r6, r2, asr #3
	str	r7, [r4, #2524]
	str	r6, [r4, #2528]
	str	ip, [r3, #2668]
	str	r5, [r3, #2676]
	str	lr, [r3, #2680]
	str	r2, [r3, #2672]
	bl	Setup_Display_Size
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1580:
	add	r5, r5, #44
	ldr	r1, [r4, #2484]
	ldr	r2, [r4, #2488]
	ldr	r3, [r4, r5, asl #2]
	str	r1, [r4, #2504]
	str	r2, [r4, #2508]
	add	r3, r4, r3, lsl #4
	ldr	r5, [r3, #2676]
	str	r5, [r4, #2484]
	ldr	lr, [r3, #2680]
	str	lr, [r4, #2488]
	b	.L1573
	.fnend
	.size	setup_frame_size_with_refs, .-setup_frame_size_with_refs
	.align	2
	.global	Set_Default_Lf_Deltas
	.type	Set_Default_Lf_Deltas, %function
Set_Default_Lf_Deltas:
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
	mov	r2, #1
	mov	r3, #0
	mvn	r1, #0
	strb	r2, [r0]
	strb	r2, [r0, #1]
	strb	r2, [r0, #2]
	strb	r3, [r0, #3]
	strb	r3, [r0, #6]
	strb	r3, [r0, #7]
	strb	r1, [r0, #4]
	strb	r1, [r0, #5]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Set_Default_Lf_Deltas, .-Set_Default_Lf_Deltas
	.align	2
	.global	VP9_Clearall_Segfeatures
	.type	VP9_Clearall_Segfeatures, %function
VP9_Clearall_Segfeatures:
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
	ldr	r5, .L1583
	mov	r4, r0
	mov	r2, #64
	mov	r1, #0
	add	r0, r0, #16
	ldr	r3, [r5, #48]
	blx	r3
	ldr	r3, [r5, #48]
	add	r0, r4, #80
	mov	r2, #32
	mov	r1, #0
	blx	r3
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1584:
	.align	2
.L1583:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VP9_Clearall_Segfeatures, .-VP9_Clearall_Segfeatures
	.align	2
	.global	VP9_Setup_Past_Independence
	.type	VP9_Setup_Past_Independence, %function
VP9_Setup_Past_Independence:
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
	ldr	r5, .L1586
	mov	r4, r0
	add	r0, r0, #2624
	mov	r2, #32
	mov	r1, #0
	ldr	r3, [r5, #48]
	add	r0, r0, #12
	blx	r3
	mov	r3, #0
	mov	ip, #1
	mvn	lr, #0
	ldr	r5, [r5, #48]
	mov	r1, r3
	strb	r3, [r4, #2559]
	add	r0, r4, #56
	strb	r3, [r4, #331]
	mov	r2, #16
	strb	r3, [r4, #334]
	strb	r3, [r4, #335]
	strb	ip, [r4, #328]
	strb	ip, [r4, #329]
	strb	ip, [r4, #330]
	strb	lr, [r4, #332]
	strb	lr, [r4, #333]
	blx	r5
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1587:
	.align	2
.L1586:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VP9_Setup_Past_Independence, .-VP9_Setup_Past_Independence
	.align	2
	.global	Setup_LoopFilter
	.type	Setup_LoopFilter, %function
Setup_LoopFilter:
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
	mov	r1, #6
	mov	r5, r0
	bl	BsGet
	mov	r1, #3
	str	r0, [r4, #8]
	mov	r0, r5
	bl	BsGet
	mov	r3, #0
	mov	r1, #1
	strb	r3, [r4, #1]
	str	r0, [r4, #12]
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4]
	cmp	r0, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #1]
	cmp	r0, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	add	r6, r4, #2
	add	r7, r4, #6
.L1592:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	cmp	r0, #0
	bne	.L1606
.L1591:
	add	r6, r6, #1
	cmp	r6, r7
	bne	.L1592
	add	r4, r4, #8
.L1594:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	cmp	r0, #0
	bne	.L1607
.L1593:
	add	r7, r7, #1
	cmp	r7, r4
	bne	.L1594
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1606:
	ldr	r2, .L1608
	mov	r1, #6
	mov	r0, r5
	bl	VP9_s_v
	strb	r0, [r6]
	b	.L1591
.L1607:
	ldr	r2, .L1608+4
	mov	r1, #6
	mov	r0, r5
	bl	VP9_s_v
	strb	r0, [r7]
	b	.L1593
.L1609:
	.align	2
.L1608:
	.word	.LC14
	.word	.LC15
	.fnend
	.size	Setup_LoopFilter, .-Setup_LoopFilter
	.align	2
	.global	Read_Delta_Q
	.type	Read_Delta_Q, %function
Read_Delta_Q:
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
	mov	r1, #1
	ldr	r5, [r4]
	mov	r6, r0
	bl	BsGet
	cmp	r0, #0
	beq	.L1611
	mov	r0, r6
	ldr	r2, .L1615
	mov	r1, #4
	bl	VP9_s_v
.L1611:
	str	r0, [r4]
	subs	r0, r0, r5
	movne	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1616:
	.align	2
.L1615:
	.word	.LC16
	.fnend
	.size	Read_Delta_Q, .-Read_Delta_Q
	.align	2
	.global	Setup_Quantization
	.type	Setup_Quantization, %function
Setup_Quantization:
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
	mov	r1, #8
	mov	r5, r0
	bl	BsGet
	add	r1, r4, #236
	str	r0, [r4, #232]
	mov	r0, r5
	bl	Read_Delta_Q
	add	r1, r4, #240
	mov	r0, r5
	bl	Read_Delta_Q
	mov	r0, r5
	add	r1, r4, #244
	bl	Read_Delta_Q
	ldr	r3, [r4, #232]
	cmp	r3, #0
	movne	r3, #0
	bne	.L1618
	ldr	r2, [r4, #236]
	cmp	r2, #0
	bne	.L1618
	ldr	r2, [r4, #240]
	cmp	r2, #0
	ldreq	r3, [r4, #244]
	clzeq	r3, r3
	moveq	r3, r3, lsr #5
.L1618:
	str	r3, [r4, #44]
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	Setup_Quantization, .-Setup_Quantization
	.align	2
	.global	VP9_Enable_Segfeature
	.type	VP9_Enable_Segfeature, %function
VP9_Enable_Segfeature:
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
	add	r1, r0, r1, lsl #2
	mov	r0, #1
	ldr	r3, [r1, #80]
	orr	r2, r3, r0, asl r2
	str	r2, [r1, #80]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VP9_Enable_Segfeature, .-VP9_Enable_Segfeature
	.align	2
	.global	VP9_Seg_Feature_Data_Max
	.type	VP9_Seg_Feature_Data_Max, %function
VP9_Seg_Feature_Data_Max:
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
	ldr	r3, .L1623
	add	r0, r3, r0, lsl #2
	ldr	r0, [r0, #624]
	ldmfd	sp, {fp, sp, pc}
.L1624:
	.align	2
.L1623:
	.word	.LANCHOR0
	.fnend
	.size	VP9_Seg_Feature_Data_Max, .-VP9_Seg_Feature_Data_Max
	.align	2
	.global	Get_Unsigned_Bits
	.type	Get_Unsigned_Bits, %function
Get_Unsigned_Bits:
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
	cmp	r0, #1
	bls	.L1629
	subs	r3, r0, #1
	beq	.L1630
	mov	r0, #0
.L1628:
	movs	r3, r3, lsr #1
	add	r0, r0, #1
	bne	.L1628
	ldmfd	sp, {fp, sp, pc}
.L1629:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1630:
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Get_Unsigned_Bits, .-Get_Unsigned_Bits
	.align	2
	.global	Decode_Unsigned_Max
	.type	Decode_Unsigned_Max, %function
Decode_Unsigned_Max:
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
	cmp	r1, #1
	mov	r4, r1
	movls	r1, #0
	bls	.L1633
	subs	r3, r4, #1
	beq	.L1637
	mov	r2, #0
.L1635:
	movs	r3, r3, lsr #1
	add	r2, r2, #1
	bne	.L1635
.L1634:
	mov	r1, r2
.L1633:
	bl	BsGet
	cmp	r0, r4
	movge	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1637:
	mov	r2, r3
	b	.L1634
	.fnend
	.size	Decode_Unsigned_Max, .-Decode_Unsigned_Max
	.align	2
	.global	VP9_Is_Segfeature_Signed
	.type	VP9_Is_Segfeature_Signed, %function
VP9_Is_Segfeature_Signed:
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
	ldr	r3, .L1640
	add	r0, r3, r0, lsl #2
	ldr	r0, [r0, #640]
	ldmfd	sp, {fp, sp, pc}
.L1641:
	.align	2
.L1640:
	.word	.LANCHOR0
	.fnend
	.size	VP9_Is_Segfeature_Signed, .-VP9_Is_Segfeature_Signed
	.align	2
	.global	VP9_Set_Segdata
	.type	VP9_Set_Segdata, %function
VP9_Set_Segdata:
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
	ldr	r7, .L1651
	mov	r9, r2, asl #2
	mov	r5, r3
	add	r3, r7, r9
	mov	r4, r2
	mov	r6, r0
	mov	r10, r1
	ldr	r8, [r3, #624]
	cmp	r8, r5
	blt	.L1648
.L1643:
	cmp	r5, #0
	blt	.L1649
.L1645:
	add	r4, r4, r10, lsl #2
	add	r4, r6, r4, lsl #1
	strh	r5, [r4, #16]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1649:
	add	r7, r7, r9
	ldr	r0, [r7, #640]
	cmp	r0, #0
	beq	.L1650
.L1646:
	rsb	r3, r5, #0
	cmp	r8, r3
	bge	.L1645
	mov	r3, #2736
	ldr	r2, .L1651+4
	ldr	r1, .L1651+8
	mov	r0, #0
	bl	dprint_vfmw
	b	.L1645
.L1648:
	movw	r3, #2725
	add	r2, r7, #656
	ldr	r1, .L1651+8
	mov	r0, #0
	bl	dprint_vfmw
	b	.L1643
.L1650:
	movw	r3, #2731
	ldr	r2, .L1651+4
	ldr	r1, .L1651+8
	bl	dprint_vfmw
	b	.L1646
.L1652:
	.align	2
.L1651:
	.word	.LANCHOR0
	.word	.LANCHOR0+656
	.word	.LC17
	.fnend
	.size	VP9_Set_Segdata, .-VP9_Set_Segdata
	.align	2
	.global	Mi_Cols_Aligned_To_Sb
	.type	Mi_Cols_Aligned_To_Sb, %function
Mi_Cols_Aligned_To_Sb:
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
	add	r0, r0, #7
	bic	r0, r0, #7
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Mi_Cols_Aligned_To_Sb, .-Mi_Cols_Aligned_To_Sb
	.align	2
	.global	To_Sbs
	.type	To_Sbs, %function
To_Sbs:
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
	add	r0, r0, #7
	mov	r0, r0, asr #3
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	To_Sbs, .-To_Sbs
	.align	2
	.global	VP9_Get_Tile_N_Bits
	.type	VP9_Get_Tile_N_Bits, %function
VP9_Get_Tile_N_Bits:
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
	add	r0, r0, #7
	mov	r3, #0
	mov	r0, r0, asr #3
	cmp	r0, #3
	ble	.L1656
.L1657:
	add	r3, r3, #1
	mov	ip, r0, asr r3
	cmp	ip, #3
	bgt	.L1657
	sub	r3, r3, #1
	bic	r3, r3, r3, asr #31
.L1656:
	cmp	r0, #64
	mov	ip, #0
	ble	.L1658
	mov	lr, #64
.L1659:
	add	ip, ip, #1
	cmp	r0, lr, asl ip
	bgt	.L1659
.L1658:
	str	ip, [r1]
	str	r3, [r2]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VP9_Get_Tile_N_Bits, .-VP9_Get_Tile_N_Bits
	.align	2
	.global	Setup_Tile_Info
	.type	Setup_Tile_Info, %function
Setup_Tile_Info:
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
	ldr	r2, [r1, #92]
	mov	r6, r1
	mov	r5, r0
	add	r2, r2, #7
	mov	r2, r2, asr #3
	cmp	r2, #3
	ble	.L1665
	mov	r4, #0
	b	.L1666
.L1677:
	mov	r4, r3
.L1666:
	add	r3, r4, #1
	mov	r1, r2, asr r3
	cmp	r1, #3
	bgt	.L1677
	cmp	r2, #64
	bic	r4, r4, r4, asr #31
	ble	.L1688
.L1675:
	mov	r3, #0
	mov	r1, #64
.L1668:
	add	r3, r3, #1
	cmp	r2, r1, asl r3
	bgt	.L1668
.L1667:
	subs	r4, r4, r3
	str	r3, [r6, #100]
	bne	.L1671
	b	.L1670
.L1673:
	ldr	r3, [r6, #100]
	subs	r4, r4, #1
	add	r3, r3, #1
	str	r3, [r6, #100]
	beq	.L1670
.L1671:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	cmp	r0, #0
	bne	.L1673
.L1670:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	cmp	r0, #0
	str	r0, [r6, #104]
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	mov	r0, r5
	mov	r1, #1
	bl	BsGet
	ldr	r3, [r6, #104]
	add	r0, r3, r0
	str	r0, [r6, #104]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1665:
	cmp	r2, #64
	movgt	r4, #0
	bgt	.L1675
	mov	r3, #0
	str	r3, [r6, #100]
	b	.L1670
.L1688:
	mov	r3, #0
	b	.L1667
	.fnend
	.size	Setup_Tile_Info, .-Setup_Tile_Info
	.align	2
	.global	Setup_Segmentation
	.type	Setup_Segmentation, %function
Setup_Segmentation:
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
	mov	r5, r1
	mov	r3, #0
	mov	r1, #1
	strb	r3, [r5, #1]
	strb	r3, [r5, #2]
	mov	r6, r0
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r5]
	cmp	r0, #0
	bne	.L1726
.L1690:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1726:
	mov	r1, #1
	mov	r0, r6
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r5, #1]
	cmp	r0, #0
	beq	.L1693
	add	r4, r5, #4
	add	r7, r5, #11
	b	.L1695
.L1694:
	strb	r3, [r4, #1]!
	cmp	r4, r7
	beq	.L1727
.L1695:
	mov	r1, #1
	mov	r0, r6
	bl	BsGet
	mov	r3, #255
	cmp	r0, #0
	beq	.L1694
	mov	r1, #8
	mov	r0, r6
	bl	BsGet
	uxtb	r3, r0
	strb	r3, [r4, #1]!
	cmp	r4, r7
	bne	.L1695
.L1727:
	mov	r1, #1
	mov	r0, r6
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r5, #4]
	cmp	r0, #0
	addne	r4, r5, #14
	bne	.L1698
	mvn	r3, #0
	strb	r3, [r5, #12]
	strb	r3, [r5, #13]
	strb	r3, [r5, #14]
.L1693:
	mov	r1, #1
	mov	r0, r6
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r5, #2]
	cmp	r0, #0
	beq	.L1690
	mov	r1, #1
	mov	r0, r6
	bl	BsGet
	add	r8, r5, #80
	mov	r7, #0
	ldr	r10, .L1730
	strb	r0, [r5, #3]
	mov	r0, r5
	bl	VP9_Clearall_Segfeatures
.L1700:
	mov	r4, #0
	mov	r9, #1
.L1703:
	mov	r1, #1
	mov	r0, r6
	bl	BsGet
	cmp	r0, #0
	moveq	r3, r0
	bne	.L1728
.L1702:
	mov	r2, r4
	mov	r1, r7
	add	r4, r4, #1
	mov	r0, r5
	bl	VP9_Set_Segdata
	cmp	r4, #4
	bne	.L1703
	add	r7, r7, #1
	add	r8, r8, #4
	cmp	r7, #8
	bne	.L1700
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1728:
	ldr	r3, [r8]
	mov	r0, r6
	ldr	r1, [r10, r4, asl #2]
	orr	r3, r3, r9, asl r4
	str	r3, [r8]
	bl	Decode_Unsigned_Max
	ldr	r2, .L1730+4
	ldr	r2, [r2, r4, asl #2]
	cmp	r2, #0
	mov	r3, r0
	beq	.L1702
	str	r0, [fp, #-48]
	mov	r1, #1
	mov	r0, r6
	bl	BsGet
	ldr	r3, [fp, #-48]
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r2, r0, #0
	eor	r3, r3, r2
	add	r3, r3, r0
	b	.L1702
.L1698:
	mov	r1, #1
	mov	r0, r6
	bl	BsGet
	mov	r3, #255
	cmp	r0, #0
	bne	.L1729
.L1697:
	strb	r3, [r7, #1]!
	cmp	r7, r4
	bne	.L1698
	b	.L1693
.L1729:
	mov	r1, #8
	mov	r0, r6
	bl	BsGet
	uxtb	r3, r0
	b	.L1697
.L1731:
	.align	2
.L1730:
	.word	.LANCHOR0+624
	.word	.LANCHOR0+640
	.fnend
	.size	Setup_Segmentation, .-Setup_Segmentation
	.align	2
	.global	read_interp_filter_type
	.type	read_interp_filter_type, %function
read_interp_filter_type:
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
	ldr	r3, .L1736
	mov	r4, r0
	sub	ip, fp, #20
	ldmia	r3, {r0, r1, r2, r3}
	stmdb	ip, {r0, r1, r2, r3}
	mov	r0, r4
	mov	r1, #1
	bl	BsGet
	cmp	r0, #0
	movne	r0, #4
	beq	.L1735
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L1735:
	mov	r0, r4
	mov	r1, #2
	bl	BsGet
	sub	r3, fp, #20
	add	r0, r3, r0, lsl #2
	ldr	r0, [r0, #-16]
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L1737:
	.align	2
.L1736:
	.word	.LANCHOR0+672
	.fnend
	.size	read_interp_filter_type, .-read_interp_filter_type
	.align	2
	.global	setup_inter_inter
	.type	setup_inter_inter, %function
setup_inter_inter:
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
	ldr	r3, [r0, #60]
	ldr	r1, [r0, #68]
	ldr	r2, [r0, #64]
	cmp	r2, r3
	cmpeq	r3, r1
	movne	r3, #1
	moveq	r3, #0
	str	r3, [r0, #52]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	setup_inter_inter, .-setup_inter_inter
	.align	2
	.global	ref_cnt_fb
	.type	ref_cnt_fb, %function
ref_cnt_fb:
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
	ldr	ip, [r1]
	ldr	r3, [r0, ip, asl #2]
	cmp	r3, #0
	subgt	r3, r3, #1
	strgt	r3, [r0, ip, asl #2]
	str	r2, [r1]
	ldr	r3, [r0, r2, asl #2]
	add	r3, r3, #1
	str	r3, [r0, r2, asl #2]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	ref_cnt_fb, .-ref_cnt_fb
	.align	2
	.global	VP9_get_fixed_point_scale_factor
	.type	VP9_get_fixed_point_scale_factor, %function
VP9_get_fixed_point_scale_factor:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	.pad #4
	.save {fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #8
	sub	sp, sp, #8
	push	{lr}
	bl	__gnu_mcount_nc
	subs	r3, r1, #0
	beq	.L1744
	mov	r0, r0, asl #14
	bl	__aeabi_idiv
.L1743:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L1744:
	str	r3, [sp]
	mov	r0, #1
	movw	r3, #2916
	ldr	r2, .L1745
	ldr	r1, .L1745+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1743
.L1746:
	.align	2
.L1745:
	.word	.LANCHOR0+688
	.word	.LC18
	.fnend
	.size	VP9_get_fixed_point_scale_factor, .-VP9_get_fixed_point_scale_factor
	.align	2
	.global	check_scale_factors
	.type	check_scale_factors, %function
check_scale_factors:
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
	cmp	r0, r2, asl #1
	bgt	.L1751
	cmp	r1, r3, asl #1
	bgt	.L1751
	cmp	r2, r0, asl #4
	bgt	.L1751
	cmp	r3, r1, asl #4
	movle	r0, #1
	movgt	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1751:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	check_scale_factors, .-check_scale_factors
	.align	2
	.global	VP9_scaled_val
	.type	VP9_scaled_val, %function
VP9_scaled_val:
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
	smull	r2, r3, r0, r1
	mov	r0, r2, lsr #14
	orr	r0, r0, r3, asl #18
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VP9_scaled_val, .-VP9_scaled_val
	.align	2
	.global	vp9_setup_scale_factors
	.type	vp9_setup_scale_factors, %function
vp9_setup_scale_factors:
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
	cmp	r1, r3, asl #1
	mov	ip, r1
	mov	r4, r0
	mov	r7, r2
	ldr	r6, [fp, #4]
	bgt	.L1754
	cmp	r2, r6, asl #1
	ble	.L1764
.L1754:
	mvn	r2, #0
	mov	r3, #16
	str	r2, [r4]
	stmib	r4, {r2, r3}
	str	r3, [r4, #12]
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1764:
	cmp	r3, r1, asl #4
	bgt	.L1754
	cmp	r6, r2, asl #4
	bgt	.L1754
	cmp	r3, #0
	beq	.L1765
	mov	r1, r3
	mov	r0, ip, asl #14
	bl	__aeabi_idiv
	cmp	r6, #0
	mov	r5, r0
	str	r5, [r4]
	beq	.L1766
.L1757:
	mov	r1, r6
	mov	r0, r7, asl #14
	bl	__aeabi_idiv
	mov	r7, r0, asr #31
	ubfx	r3, r0, #10, #18
	mov	r1, r7, asl #4
	orr	r1, r1, r0, lsr #28
	orr	r1, r3, r1, asl #18
.L1758:
	mov	r7, r5, asr #31
	ubfx	r3, r5, #10, #18
	str	r0, [r4, #4]
	mov	r2, r7, asl #4
	str	r1, [r4, #12]
	orr	r2, r2, r5, lsr #28
	orr	r3, r3, r2, asl #18
	str	r3, [r4, #8]
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1765:
	str	r3, [sp]
	mov	r0, #1
	movw	r3, #2916
	ldr	r2, .L1767
	ldr	r1, .L1767+4
	mvn	r5, #0
	bl	dprint_vfmw
	cmp	r6, #0
	str	r5, [r4]
	bne	.L1757
.L1766:
	ldr	r1, .L1767+4
	movw	r3, #2916
	str	r6, [sp]
	mov	r0, #1
	ldr	r2, .L1767
	bl	dprint_vfmw
	mvn	r1, #0
	mov	r0, r1
	ldr	r5, [r4]
	b	.L1758
.L1768:
	.align	2
.L1767:
	.word	.LANCHOR0+688
	.word	.LC18
	.fnend
	.size	vp9_setup_scale_factors, .-vp9_setup_scale_factors
	.align	2
	.global	Vp9_Vfmw_ReadProfile
	.type	Vp9_Vfmw_ReadProfile, %function
Vp9_Vfmw_ReadProfile:
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
	mov	r5, r0
	bl	BsGet
	mov	r1, #1
	mov	r4, r0
	mov	r0, r5
	bl	BsGet
	orr	r4, r4, r0, asl #1
	cmp	r4, #2
	ble	.L1770
	mov	r0, r5
	mov	r1, #1
	bl	BsGet
	add	r4, r0, r4
.L1770:
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	Vp9_Vfmw_ReadProfile, .-Vp9_Vfmw_ReadProfile
	.align	2
	.global	Vp9_ReadBitDepthColorSpaceSampling
	.type	Vp9_ReadBitDepthColorSpaceSampling, %function
Vp9_ReadBitDepthColorSpaceSampling:
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
	ldr	r3, [r1, #2444]
	mov	r2, #8
	mov	r4, r1
	cmp	r3, #1
	mov	r5, r0
	str	r2, [r1, #2500]
	bls	.L1772
	mov	r1, #1
	bl	BsGet
	cmp	r0, #0
	movne	r3, #12
	moveq	r3, #10
	str	r3, [r4, #2500]
.L1772:
	mov	r1, #3
	mov	r0, r5
	bl	BsGet
	cmp	r0, #7
	str	r0, [r4, #2448]
	beq	.L1774
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	ldr	r6, [r4, #2444]
	bic	r6, r6, #2
	cmp	r6, #1
	movne	r3, #1
	str	r0, [r4, #2452]
	strne	r3, [r4, #2480]
	strne	r3, [r4, #2476]
	ldmnefd	sp, {r4, r5, r6, r7, fp, sp, pc}
	mov	r1, r6
	mov	r0, r5
	bl	BsGet
	mov	r1, r6
	str	r0, [r4, #2476]
	mov	r0, r5
	bl	BsGet
	mov	r1, r6
	str	r0, [r4, #2480]
	mov	r0, r5
	bl	BsGet
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1774:
	ldr	r1, [r4, #2444]
	bic	r1, r1, #2
	cmp	r1, #1
	beq	.L1779
	movw	r3, #3013
	ldr	r2, .L1780
	ldr	r1, .L1780+4
	mov	r0, #1
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1779:
	mov	r3, #0
	mov	r0, r5
	str	r3, [r4, #2480]
	str	r3, [r4, #2476]
	bl	BsGet
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1781:
	.align	2
.L1780:
	.word	.LANCHOR0+724
	.word	.LC19
	.fnend
	.size	Vp9_ReadBitDepthColorSpaceSampling, .-Vp9_ReadBitDepthColorSpaceSampling
	.align	2
	.global	Vp9_ReadCompressedHeader
	.type	Vp9_ReadCompressedHeader, %function
Vp9_ReadCompressedHeader:
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
	ldr	lr, [fp, #16]
	mov	r4, #0
	mov	r7, r1
	mov	r6, r2
	cmp	lr, #0
	mov	r8, r3
	mov	r5, r0
	str	r4, [fp, #-48]
	ldr	r10, [fp, #8]
	ldr	r9, [fp, #12]
	beq	.L1787
.L1783:
	mov	r2, r5
	mov	r1, r4
	mov	r0, r7
	bl	Vp9_ReadCoefProbs
	ldr	r2, [fp, #4]
	mov	r0, r7
	mov	r3, r8
	sub	ip, fp, #48
	stmib	sp, {r9, r10}
	str	r2, [sp]
	mov	r1, r5
	mov	r2, r6
	str	ip, [sp, #12]
	bl	Vp9_PrepareReadModeInfo
	ldr	r3, [r5, #32]
	sub	r3, r3, #33
	cmn	r3, #-1073741790
	ldrhi	r3, [fp, #-48]
	movhi	r0, #0
	ldrhi	r2, [fp, #20]
	mvnls	r0, #0
	strhi	r3, [r2]
	ldrhi	r3, [fp, #24]
	strhi	r4, [r3]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1787:
	bl	Vp9_ReadTxMode
	cmp	r0, #4
	mov	r4, r0
	bne	.L1783
	add	r0, r7, #2000
	mov	r1, r5
	add	r0, r0, #3
	bl	Vp9_ReadTxProbs
	b	.L1783
	.fnend
	.size	Vp9_ReadCompressedHeader, .-Vp9_ReadCompressedHeader
	.align	2
	.global	Read_UnCompressed_Header
	.type	Read_UnCompressed_Header, %function
Read_UnCompressed_Header:
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
	mov	r4, r1
	mov	r1, #2
	ldr	r3, [r4, #2440]
	mov	r5, r0
	str	r3, [r4, #2436]
	bl	BsGet
	cmp	r0, #2
	beq	.L1789
	ldr	r1, .L1823
	mov	r0, #1
	bl	dprint_vfmw
.L1789:
	mov	r0, r5
	bl	Vp9_Vfmw_ReadProfile
	mov	r1, #1
	str	r0, [r4, #2444]
	mov	r0, r5
	bl	BsGet
	subs	r6, r0, #0
	bne	.L1819
	mov	r1, #1
	str	r6, [r4, #2460]
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	str	r0, [r4, #2440]
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	str	r0, [r4, #2456]
	mov	r0, r5
	bl	BsGet
	ldr	r2, [r4, #2440]
	cmp	r2, #0
	mov	r3, r0
	str	r0, [r4, #2472]
	beq	.L1820
	ldr	r2, [r4, #2456]
	cmp	r2, #0
	strne	r6, [r4, #2540]
	beq	.L1821
.L1795:
	cmp	r3, #0
	beq	.L1796
	mov	r3, #0
	str	r3, [r4, #2544]
.L1797:
	ldr	r3, [r4, #2540]
	cmp	r3, #0
	beq	.L1798
	mov	r0, r5
	bl	Check_Sync_Code
	ldr	r3, [r4, #2444]
	cmp	r3, #1
	bls	.L1799
	mov	r1, r4
	mov	r0, r5
	bl	Vp9_ReadBitDepthColorSpaceSampling
.L1800:
	mov	r1, #8
	mov	r0, r5
	bl	BsGet
	mov	r1, r4
	str	r0, [r4, #2548]
	mov	r0, r5
	bl	Setup_Frame_Size
	b	.L1793
.L1819:
	mov	r0, r5
	mov	r1, #3
	bl	BsGet
	mov	r2, #0
	mov	r3, r2
	mov	r1, #1
	add	r0, r0, #36
	ldr	r0, [r4, r0, asl #2]
	str	r2, [r4, #2548]
	str	r2, [r4, #336]
	str	r0, [r4, #2464]
	mov	r0, r3
	str	r1, [r4, #2460]
	str	r1, [r4, #2456]
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L1798:
	mov	r1, #8
	mov	r0, r5
	bl	BsGet
	add	r8, r4, #172
	add	r7, r4, #184
	mov	r6, r8
	str	r0, [r4, #2548]
.L1801:
	mov	r1, #3
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	add	r3, r0, #36
	mov	r0, r5
	ldr	r3, [r4, r3, asl #2]
	str	r3, [r6, #4]!
	bl	BsGet
	cmp	r6, r7
	str	r0, [r6, #-116]
	bne	.L1801
	mov	r1, r4
	mov	r0, r5
	bl	setup_frame_size_with_refs
	ldr	r2, [r4, #2484]
	sub	r3, r2, #1
	cmp	r3, #4096
	ldr	r3, [r4, #2488]
	bcs	.L1803
	sub	r1, r3, #1
	cmp	r1, #4096
	bcc	.L1804
.L1803:
	str	r3, [sp, #4]
	mov	r0, #1
	str	r2, [sp]
	movw	r3, #3160
	ldr	r2, .L1823+4
	ldr	r1, .L1823+8
	bl	dprint_vfmw
	mvn	r3, #0
	mov	r0, r3
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L1820:
	mov	r0, r5
	bl	Check_Sync_Code
	mov	r1, r4
	mov	r0, r5
	bl	Vp9_ReadBitDepthColorSpaceSampling
	ldr	r3, [r4, #2432]
	mov	r2, #255
	mov	r1, r4
	str	r2, [r4, #2548]
	mov	r0, r5
	str	r3, [r4, #176]
	str	r3, [r4, #180]
	str	r3, [r4, #184]
	bl	Setup_Frame_Size
.L1793:
	ldr	r3, [r4, #2472]
	cmp	r3, #0
	movne	r3, #0
	strne	r3, [r4, #2512]
	strne	r3, [r4, #2516]
	beq	.L1822
.L1807:
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	ldr	r3, [r4, #2440]
	cmp	r3, #0
	str	r0, [r4, #2520]
	beq	.L1808
	ldr	r3, [r4, #2472]
	cmp	r3, #0
	bne	.L1808
	ldr	r3, [r4, #2540]
	cmp	r3, #0
	bne	.L1808
.L1810:
	ldr	r3, [r4, #60]
	ldr	r1, [r4, #68]
	ldr	r2, [r4, #64]
	cmp	r2, r3
	cmpeq	r3, r1
	movne	r3, #1
	moveq	r3, #0
	str	r3, [r4, #52]
.L1809:
	add	r1, r4, #328
	mov	r0, r5
	bl	Setup_LoopFilter
	mov	r1, r4
	mov	r0, r5
	bl	Setup_Quantization
	add	r1, r4, #2544
	mov	r0, r5
	add	r1, r1, #12
	bl	Setup_Segmentation
	add	r1, r4, #2432
	mov	r0, r5
	bl	Setup_Tile_Info
	mov	r0, r5
	mov	r1, #16
	bl	BsGet
	mov	r3, r0
	mov	r0, r3
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L1799:
	mov	r3, #1
	mov	r2, #8
	str	r3, [r4, #2476]
	str	r2, [r4, #2500]
	str	r3, [r4, #2480]
	str	r3, [r4, #2448]
	b	.L1800
.L1808:
	mov	r0, r4
	bl	VP9_Setup_Past_Independence
	ldr	r3, [r4, #2440]
	cmp	r3, #0
	beq	.L1809
	b	.L1810
.L1796:
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	str	r0, [r4, #2544]
	b	.L1797
.L1821:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	ldr	r3, [r4, #2472]
	str	r0, [r4, #2540]
	b	.L1795
.L1822:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	str	r0, [r4, #2512]
	mov	r0, r5
	bl	BsGet
	str	r0, [r4, #2516]
	b	.L1807
.L1804:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	add	r6, r4, #2800
	add	r6, r6, #12
	str	r0, [r4, #48]
	mov	r0, r5
	bl	read_interp_filter_type
	str	r0, [r4, #2552]
.L1805:
	ldr	r1, [r8, #4]!
	mov	r0, r6
	ldr	ip, [r4, #2488]
	add	r6, r6, #16
	ldr	r3, [r4, #2484]
	add	r1, r4, r1, lsl #4
	add	r1, r1, #2656
	ldr	r2, [r1, #24]
	add	r1, r1, #12
	ldr	r1, [r1, #8]
	str	ip, [sp]
	bl	vp9_setup_scale_factors
	cmp	r7, r8
	bne	.L1805
	ldr	r3, [r4, #60]
	ldr	r1, [r4, #68]
	ldr	r2, [r4, #64]
	cmp	r2, r3
	cmpeq	r3, r1
	movne	r3, #1
	moveq	r3, #0
	str	r3, [r4, #52]
	b	.L1793
.L1824:
	.align	2
.L1823:
	.word	.LC20
	.word	.LANCHOR0+760
	.word	.LC21
	.fnend
	.size	Read_UnCompressed_Header, .-Read_UnCompressed_Header
	.align	2
	.global	swap_frame_buffers
	.type	swap_frame_buffers, %function
swap_frame_buffers:
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
	ldr	r3, [r0, #2548]
	cmp	r3, #0
	addne	r2, r0, #144
	addne	lr, r0, #72
	beq	.L1830
.L1829:
	tst	r3, #1
	beq	.L1827
	ldr	r4, [r2]
	ldr	ip, [r0, #2432]
	ldr	r1, [lr, r4, asl #2]
	cmp	r1, #0
	sub	r1, r1, #1
	strgt	r1, [lr, r4, asl #2]
	str	ip, [r2]
	ldr	r1, [lr, ip, asl #2]
	add	r1, r1, #1
	str	r1, [lr, ip, asl #2]
.L1827:
	movs	r3, r3, asr #1
	add	r2, r2, #4
	bne	.L1829
.L1830:
	ldr	r3, [r0, #2432]
	mvn	r2, #-2147483648
	add	r3, r0, r3, lsl #2
	ldr	r1, [r3, #72]
	sub	r1, r1, #1
	str	r1, [r3, #72]
	str	r2, [r0, #176]
	str	r2, [r0, #180]
	str	r2, [r0, #184]
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	swap_frame_buffers, .-swap_frame_buffers
	.align	2
	.global	VP9_Set_DecParam
	.type	VP9_Set_DecParam, %function
VP9_Set_DecParam:
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
	add	r9, r0, #270336
	mov	r5, r0
	add	r4, r0, #266240
	ldr	r6, [r9, #428]
	cmp	r6, #1
	beq	.L1872
	add	r8, r0, #262144
	mov	r3, #0
	strb	r3, [r8, #1036]
	ldr	r3, [r9, #408]
	ldr	ip, [r4, #2060]
	ldr	r0, [r4, #2068]
	ldr	r1, [r4, #2072]
	ldr	r2, [r4, #1992]
	str	ip, [r4, #1604]
	str	r0, [r4, #1584]
	bic	r2, r2, #15
	str	r3, [r4, #2056]
	str	r2, [r4, #1616]
	str	r3, [r4, #1600]
	str	r1, [r4, #1588]
	ldr	r1, [r5]
	ldr	r2, [r4, #2248]
	ldr	ip, [r4, #2016]
	ldr	lr, [r1, #588]
	cmp	r2, #8
	ldr	r0, [r4, #2028]
	addgt	r6, r5, #290816
	addle	r2, r4, r2, lsl #2
	addle	r6, r5, #290816
	str	lr, [r4, #1956]
	ldr	r1, [r1, #624]
	str	ip, [r4, #1948]
	str	r0, [r4, #1952]
	str	r1, [r4, #1960]
	ldrgt	r2, [r6, #2848]
	addgt	r2, r4, r2, lsl #2
	ldr	r2, [r2, #2252]
	str	r2, [r4, #2040]
	ldr	r2, [r4, #2244]
	cmp	r2, #8
	ldrgt	r2, [r6, #2848]
	add	r2, r4, r2, lsl #2
	ldr	r2, [r2, #2252]
	str	r2, [r4, #2036]
	ldr	r2, [r4, #2240]
	cmp	r2, #8
	ldrgt	r2, [r6, #2848]
	cmp	r3, #0
	add	r2, r4, r2, lsl #2
	ldr	r2, [r2, #2252]
	str	r2, [r4, #2044]
	bne	.L1873
.L1849:
	ldr	r1, [r4, #2048]
	str	r1, [r4, #2040]
	str	r1, [r4, #2036]
	str	r1, [r4, #2044]
.L1850:
	ldr	r0, [r6, #2948]
	bl	FSP_GetLogicFs
	ldr	r1, [r4, #2040]
	mov	r7, r0
	ldr	r0, [r6, #2948]
	bl	FSP_GetLogicFs
	ldr	r1, [r4, #2036]
	str	r0, [fp, #-48]
	ldr	r0, [r6, #2948]
	bl	FSP_GetLogicFs
	ldr	r1, [r4, #2044]
	mov	r10, r0
	ldr	r0, [r6, #2948]
	bl	FSP_GetLogicFs
	cmp	r10, #0
	cmpne	r7, #0
	beq	.L1851
	ldr	r2, [fp, #-48]
	cmp	r0, #0
	cmpne	r2, #0
	beq	.L1851
	ldr	r1, [r7, #608]
	cmp	r1, #0
	beq	.L1874
	ldr	r1, [r7, #620]
	str	r1, [r4, #1944]
	ldr	r1, [r7, #608]
	ldr	r1, [r1, #28]
	str	r1, [r4, #1968]
	ldr	r1, [r7, #608]
	ldr	r1, [r1, #16]
	str	r1, [r4, #1928]
	ldr	r2, [r2, #608]
	cmp	r2, #0
	ldreq	r2, [r7, #608]
	ldr	r2, [r2, #16]
	str	r2, [r4, #1932]
	ldr	r2, [r10, #608]
	cmp	r2, #0
	ldreq	r2, [r7, #608]
	ldr	r2, [r2, #16]
	str	r2, [r4, #1936]
	ldr	r3, [r0, #608]
	ldr	r2, [r4, #1956]
	cmp	r3, #0
	ldreq	r3, [r7, #608]
	cmp	r2, #1
	ldr	r3, [r3, #16]
	str	r3, [r4, #1940]
	ldr	r3, [r7, #608]
	ldr	r3, [r3, #36]
	str	r3, [r4, #1980]
	ldr	r3, [r7, #608]
	ldr	r3, [r3, #40]
	str	r3, [r4, #1984]
	ldr	ip, [r9, #452]
	add	r2, ip, #255
	bic	r2, r2, #255
	mov	r3, r2, asl #4
	str	r3, [r4, #1592]
	ldr	lr, [r9, #456]
	add	r0, lr, #63
	bic	r1, r0, #63
	mul	r1, r1, r2
	str	r1, [r4, #1596]
	beq	.L1875
.L1859:
	ldr	r3, [r6, #2956]
	mov	r0, #0
	add	r2, r5, #8
	str	r3, [r6, #2952]
	str	r3, [r8, #1032]
	str	r2, [r5, #4]
.L1839:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1873:
	ldr	r3, [r9, #508]
	cmp	r3, #1
	beq	.L1849
	ldr	r1, [r4, #2048]
	b	.L1850
.L1875:
	add	r3, ip, #508
	add	ip, ip, #1020
	add	r3, r3, #3
	add	ip, ip, #2
	cmp	r3, #0
	movlt	r3, ip
	bic	r3, r3, #508
	bic	r3, r3, #3
	add	r2, r3, #63
	cmp	r3, #0
	movlt	r3, r2
	cmp	r0, #0
	addlt	r0, lr, #126
	mov	r3, r3, asr #6
	mov	r0, r0, asr #6
	mov	r2, r3, asl #1
	str	r2, [r4, #1972]
	mov	r3, r0, asl #5
	mul	r3, r2, r3
	add	r2, r3, r1
	str	r2, [r4, #1596]
	str	r3, [r4, #1976]
	b	.L1859
.L1872:
	add	r3, r0, #262144
	add	r7, r0, #290816
	strb	r6, [r3, #1036]
	ldr	r3, [r0]
	ldr	r1, [r4, #2048]
	ldr	r2, [r3, #588]
	str	r2, [r4, #1956]
	ldr	r3, [r3, #624]
	str	r3, [r4, #1960]
	ldr	r0, [r7, #2948]
	bl	FSP_GetLogicFs
	ldr	r3, [r9, #432]
	add	r3, r4, r3, lsl #2
	ldr	r1, [r3, #2252]
	mov	r8, r0
	ldr	r0, [r7, #2948]
	bl	FSP_GetLogicFs
	ldr	r3, [r9, #432]
	add	r3, r4, r3, lsl #2
	ldr	r1, [r3, #2252]
	mov	r10, r0
	ldr	r0, [r7, #2948]
	bl	FSP_GetFsImagePtr
	cmp	r8, #0
	cmpne	r10, #0
	moveq	r3, #1
	movne	r3, #0
	cmp	r0, #0
	orreq	r3, r3, #1
	mov	r2, r0
	cmp	r3, #0
	bne	.L1851
	ldr	r3, [r8, #608]
	cmp	r3, #0
	beq	.L1876
	ldr	r3, [r3, #16]
	mov	r1, #0
	mov	r0, r1
	str	r3, [r4, #1928]
	ldr	r3, [r10, #608]
	cmp	r3, #0
	ldreq	r3, [r8, #608]
	ldr	r3, [r3, #16]
	str	r3, [r4, #1936]
	ldr	r3, [r8, #608]
	ldr	r3, [r3, #28]
	str	r3, [r4, #1968]
	ldr	r3, [r2, #112]
	add	r3, r3, #63
	mov	r3, r3, lsr #6
	str	r3, [r4, #1584]
	ldr	r3, [r2, #116]
	add	r3, r3, #63
	mov	r3, r3, lsr #6
	str	r3, [r4, #1588]
	str	r1, [r5, #4]
	ldr	r3, [r2, #112]
	str	r3, [r4, #2076]
	ldr	r3, [r2, #116]
	str	r3, [r4, #2080]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1851:
	ldr	r1, .L1877
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1839
.L1874:
	ldr	r1, .L1877+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1839
.L1876:
	mov	r0, r6
	ldr	r1, .L1877+8
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1839
.L1878:
	.align	2
.L1877:
	.word	.LC22
	.word	.LC24
	.word	.LC23
	.fnend
	.size	VP9_Set_DecParam, .-VP9_Set_DecParam
	.align	2
	.global	VP9_ArrangeVHBMem
	.type	VP9_ArrangeVHBMem, %function
VP9_ArrangeVHBMem:
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
	add	r4, r0, #266240
	mov	r5, r0
	ldr	r3, [r4, #2080]
	ldr	r2, [r4, #2076]
	cmp	r3, #31
	bls	.L1881
	cmp	r2, #31
	bhi	.L1882
.L1881:
	ldr	r1, .L1913
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r6, #0
.L1883:
	mov	r0, r6
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1882:
	ldr	r1, .L1913+4
	mov	r0, #22
	bl	dprint_vfmw
	ldr	r1, [r5]
	ldr	r3, [r1, #700]
	cmp	r3, #0
	ldr	r3, [r1, #28]
	bne	.L1884
	cmp	r3, #25
	beq	.L1885
.L1890:
	ldr	r6, [r4, #2004]
	mov	r8, #5
.L1886:
	cmn	r6, #1
	beq	.L1909
	add	r6, r5, #290816
	ldr	r8, .L1913+8
	ldr	r2, .L1913+12
	mov	r7, #1
	ldr	r3, [r6, #2948]
	mov	r1, #0
	ldr	r9, [r6, #2820]
	sub	r0, fp, #68
	ldr	ip, [r2, #48]
	mov	r2, #32
	ldr	r3, [r8, r3, asl #2]
	add	r3, r3, #233472
	str	r7, [r3, #384]
	blx	ip
	ldr	r2, [r4, #2080]
	ldr	r0, [r5]
	mov	r1, #0
	ldr	r3, [r4, #2076]
	str	r2, [fp, #-40]
	ldr	r0, [r0, #28]
	strb	r1, [fp, #-67]
	sub	r1, fp, #68
	cmp	r0, #24
	ldr	r0, [r6, #2948]
	uxtbne	r7, r9
	str	r3, [fp, #-60]
	str	r3, [fp, #-44]
	mov	r3, #0
	str	r2, [fp, #-56]
	strb	r7, [fp, #-65]
	strb	r3, [fp, #-63]
	strb	r3, [fp, #-62]
	strb	r3, [fp, #-66]
	bl	FSP_ConfigInstance
	cmp	r0, #0
	beq	.L1910
.L1895:
	ldr	r1, .L1913+16
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r6, #0
	b	.L1883
.L1884:
	cmp	r3, #25
	bne	.L1890
	ldr	r2, [r4, #2076]
	ldr	r0, [r1, #660]
	ldr	r3, [r4, #2080]
	cmp	r2, r0
	ldr	ip, [r1, #664]
	bhi	.L1892
	cmp	r3, ip
	bls	.L1893
.L1892:
	stmia	sp, {r0, ip}
	mov	r0, #0
	ldr	r1, .L1913+20
	mvn	r6, #0
	bl	dprint_vfmw
	b	.L1883
.L1909:
	add	r9, r5, #290816
	ldr	r3, .L1913+8
	ldr	r2, .L1913+12
	mov	r7, #0
	ldr	lr, [r9, #2948]
	mov	r1, r7
	sub	r0, fp, #68
	ldr	ip, [r2, #48]
	mov	r2, #32
	ldr	r3, [r3, lr, asl #2]
	add	r3, r3, #233472
	str	r7, [r3, #384]
	blx	ip
	ldr	ip, [r4, #2076]
	ldr	r2, [r4, #2080]
	sub	r1, fp, #68
	ldr	r0, [r9, #2948]
	mov	r3, #1
	strb	r7, [fp, #-67]
	strb	r7, [fp, #-66]
	strb	r8, [fp, #-63]
	str	ip, [fp, #-60]
	str	ip, [fp, #-44]
	str	r2, [fp, #-56]
	str	r2, [fp, #-40]
	strb	r3, [fp, #-65]
	strb	r3, [fp, #-62]
	bl	FSP_ConfigInstance
	subs	r7, r0, #0
	bne	.L1895
	ldr	r1, [r5]
	sub	r3, fp, #72
	ldr	r0, [r9, #2948]
	ldr	r2, [r1, #24]
	ldr	r1, [r1, #20]
	bl	FSP_ConfigFrameBuf
	cmp	r0, #0
	bne	.L1911
.L1896:
	mov	r6, #0
	str	r6, [r4, #2004]
	b	.L1883
.L1910:
	ldr	r1, [r5]
	sub	r3, fp, #72
	ldr	r0, [r6, #2948]
	ldr	r2, [r1, #24]
	ldr	r1, [r1, #20]
	bl	FSP_ConfigFrameBuf
	cmp	r0, #0
	bne	.L1912
.L1898:
	ldr	r3, [r6, #2948]
	mov	r2, #0
	ldr	r3, [r8, r3, asl #2]
	str	r2, [r3, #1464]
	b	.L1896
.L1885:
	ldr	r2, [r4, #2076]
	ldr	r0, [r1, #660]
	ldr	r3, [r4, #2080]
	cmp	r2, r0
	ldr	ip, [r1, #664]
	bhi	.L1892
	cmp	r3, ip
	bhi	.L1892
	ldr	r6, [r4, #2004]
	cmp	r6, #0
	ldrne	r8, [r1, #708]
	bne	.L1886
	b	.L1883
.L1912:
	ldr	r1, .L1913+24
	mov	r0, #2
	bl	dprint_vfmw
	b	.L1898
.L1893:
	ldr	r8, [r1, #708]
	ldr	r6, [r4, #2004]
	b	.L1886
.L1911:
	mov	r0, r7
	ldr	r1, .L1913+28
	bl	dprint_vfmw
	b	.L1883
.L1914:
	.align	2
.L1913:
	.word	.LC25
	.word	.LC26
	.word	s_pstVfmwChan
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC29
	.word	.LC27
	.word	.LC30
	.word	.LC28
	.fnend
	.size	VP9_ArrangeVHBMem, .-VP9_ArrangeVHBMem
	.align	2
	.global	VP9_GetRefNum
	.type	VP9_GetRefNum, %function
VP9_GetRefNum:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #76
	sub	sp, sp, #76
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r7, .L1934
	add	r8, r0, #266240
	sub	r4, fp, #72
	add	r6, r0, #270336
	add	r1, r8, #2128
	mov	r2, #36
	add	r1, r1, #8
	ldr	r3, [r7, #52]
	mov	r0, r4
	ldr	r5, [r6, #400]
	blx	r3
	ldr	r3, [r7, #52]
	add	r1, r8, #2208
	sub	r0, fp, #104
	mov	r2, #32
	blx	r3
	ldr	r3, [r6, #428]
	cmp	r3, #1
	beq	.L1933
.L1916:
	ldr	r3, [r6, #516]
	mov	lr, r5, asl #2
	cmp	r3, #0
	subne	r2, fp, #104
	addne	r0, r4, lr
	beq	.L1923
.L1922:
	tst	r3, #1
	beq	.L1920
	ldr	ip, [r2]
	str	r5, [r2]
	ldr	r1, [r4, ip, asl #2]
	cmp	r1, #0
	sub	r1, r1, #1
	strgt	r1, [r4, ip, asl #2]
	ldr	r1, [r0]
	add	r1, r1, #1
	str	r1, [r0]
.L1920:
	movs	r3, r3, asr #1
	add	r2, r2, #4
	bne	.L1922
.L1923:
	sub	r3, fp, #36
	sub	r1, fp, #40
	add	r2, r3, lr
	sub	r3, fp, #76
	mov	r0, #0
	ldr	ip, [r2, #-36]
	sub	ip, ip, #1
	str	ip, [r2, #-36]
.L1919:
	ldr	r2, [r3, #4]!
	cmp	r2, #0
	addne	r0, r0, #1
	cmp	r3, r1
	bne	.L1919
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L1933:
	ldr	r3, [r4, r5, asl #2]
	ldr	r2, [r6, #432]
	cmp	r3, #0
	subgt	r3, r3, #1
	strgt	r3, [r4, r5, asl #2]
	ldr	r3, [r4, r2, asl #2]
	mov	r5, r2
	add	r3, r3, #1
	str	r3, [r4, r2, asl #2]
	b	.L1916
.L1935:
	.align	2
.L1934:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VP9_GetRefNum, .-VP9_GetRefNum
	.align	2
	.global	Vp9_DefaultCoefProbs
	.type	Vp9_DefaultCoefProbs, %function
Vp9_DefaultCoefProbs:
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
	ldr	r5, .L1937
	ldr	r4, .L1937+4
	mov	r2, #432
	mov	r6, r0
	ldr	r3, [r5, #52]
	mov	r1, r4
	blx	r3
	ldr	r3, [r5, #52]
	add	r1, r4, #432
	add	r0, r6, #432
	mov	r2, #432
	blx	r3
	ldr	r3, [r5, #52]
	add	r1, r4, #864
	add	r0, r6, #864
	mov	r2, #432
	blx	r3
	ldr	r3, [r5, #52]
	add	r1, r4, #1296
	add	r0, r6, #1296
	mov	r2, #432
	blx	r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1938:
	.align	2
.L1937:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR1
	.fnend
	.size	Vp9_DefaultCoefProbs, .-Vp9_DefaultCoefProbs
	.align	2
	.global	Vp9_InitMbmodeProbs
	.type	Vp9_InitMbmodeProbs, %function
Vp9_InitMbmodeProbs:
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
	ldr	r5, .L1940
	ldr	r6, .L1940+4
	mov	r4, r0
	add	r0, r0, #1760
	mov	r2, #90
	ldr	r3, [r5, #52]
	add	r1, r6, #1728
	add	r0, r0, #4
	blx	r3
	add	r1, r6, #1808
	ldr	r3, [r5, #52]
	add	r1, r1, #12
	add	r0, r4, #1728
	mov	r2, #36
	blx	r3
	add	r0, r4, #1936
	ldr	r3, [r5, #52]
	add	r1, r6, #1856
	mov	r2, #8
	add	r0, r0, #14
	blx	r3
	add	r1, r6, #1856
	add	r0, r4, #1840
	ldr	r3, [r5, #52]
	add	r1, r1, #8
	mov	r2, #96
	add	r0, r0, #14
	blx	r3
	add	r1, r6, #1952
	add	r0, r4, #1968
	ldr	r3, [r5, #52]
	add	r1, r1, #8
	mov	r2, #4
	add	r0, r0, #11
	blx	r3
	add	r1, r6, #1952
	add	r0, r4, #1968
	ldr	r3, [r5, #52]
	add	r1, r1, #12
	mov	r2, #5
	add	r0, r0, #15
	blx	r3
	add	r1, r6, #1968
	add	r0, r4, #1984
	ldr	r3, [r5, #52]
	add	r1, r1, #4
	mov	r2, #5
	add	r0, r0, #14
	blx	r3
	add	r1, r6, #1968
	add	r0, r4, #1984
	ldr	r3, [r5, #52]
	add	r1, r1, #12
	mov	r2, #10
	add	r0, r0, #4
	blx	r3
	add	r0, r4, #2000
	mov	r2, #12
	ldr	r1, .L1940+8
	add	r0, r0, #3
	bl	memcpy
	add	r1, r6, #1984
	add	r0, r4, #2000
	add	r1, r1, #8
	ldr	r3, [r5, #52]
	mov	r2, #3
	add	r0, r0, #15
	blx	r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1941:
	.align	2
.L1940:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR1
	.word	.LANCHOR0+788
	.fnend
	.size	Vp9_InitMbmodeProbs, .-Vp9_InitMbmodeProbs
	.align	2
	.global	Vp9_InitMvProbs
	.type	Vp9_InitMvProbs, %function
Vp9_InitMvProbs:
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
	add	r0, r0, #2016
	mov	r2, #69
	ldr	r1, .L1943
	add	r0, r0, #2
	bl	memcpy
	ldmfd	sp, {fp, sp, pc}
.L1944:
	.align	2
.L1943:
	.word	.LANCHOR0+800
	.fnend
	.size	Vp9_InitMvProbs, .-Vp9_InitMvProbs
	.align	2
	.global	Vp9_SetupPastIndependence
	.type	Vp9_SetupPastIndependence, %function
Vp9_SetupPastIndependence:
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
	mov	r4, r3
	mov	r6, r1
	mov	r7, r2
	ldr	r9, [fp, #4]
	ldr	r8, [fp, #8]
	bl	Vp9_DefaultCoefProbs
	mov	r0, r5
	bl	Vp9_InitMbmodeProbs
	add	r0, r5, #2016
	mov	r2, #69
	ldr	r1, .L1953
	add	r0, r0, #2
	bl	memcpy
	ldr	r3, .L1953+4
	add	r0, r5, #1952
	mov	r2, #21
	add	r0, r0, #6
	ldr	r1, .L1953+8
	ldr	r3, [r3, #52]
	blx	r3
	sub	lr, r4, #3
	clz	lr, lr
	mov	lr, lr, lsr #5
	cmp	r9, #0
	moveq	ip, lr
	orrne	ip, lr, #1
	cmp	r8, #0
	orreq	ip, ip, #1
	cmp	ip, #0
	bne	.L1951
	cmp	r4, #2
	beq	.L1952
.L1948:
	mov	r3, #0
	str	r3, [r7]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1951:
	mov	r4, #0
	movw	r8, #8348
.L1947:
	add	r0, r6, r4
	add	r4, r4, #2080
	add	r4, r4, #7
	movw	r2, #2087
	mov	r1, r5
	bl	memcpy
	cmp	r4, r8
	bne	.L1947
	b	.L1948
.L1952:
	ldr	r0, [r7]
	movw	r2, #2087
	mov	r1, r5
	mla	r0, r2, r0, r6
	bl	memcpy
	b	.L1948
.L1954:
	.align	2
.L1953:
	.word	.LANCHOR0+800
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR1+1996
	.fnend
	.size	Vp9_SetupPastIndependence, .-Vp9_SetupPastIndependence
	.align	2
	.global	Vp9_Vfmw_SegfeatureActive
	.type	Vp9_Vfmw_SegfeatureActive, %function
Vp9_Vfmw_SegfeatureActive:
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
	ldrb	r3, [r0]
	cmp	r3, #0
	beq	.L1957
	add	r1, r1, #20
	mov	ip, #1
	ldr	r3, [r0, r1, asl #2]
	ands	r3, r3, ip, asl r2
	movne	r0, ip
	moveq	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1957:
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Vp9_Vfmw_SegfeatureActive, .-Vp9_Vfmw_SegfeatureActive
	.align	2
	.global	Vp9_Vfmw_GetSegdata
	.type	Vp9_Vfmw_GetSegdata, %function
Vp9_Vfmw_GetSegdata:
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
	add	r2, r2, r1, lsl #2
	add	r0, r0, r2, lsl #1
	ldrsh	r0, [r0, #16]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Vp9_Vfmw_GetSegdata, .-Vp9_Vfmw_GetSegdata
	.align	2
	.global	Vp9_Vfmw_Clamp
	.type	Vp9_Vfmw_Clamp, %function
Vp9_Vfmw_Clamp:
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
	cmp	r0, r1
	movlt	r0, r1
	cmp	r0, r2
	movge	r0, r2
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Vp9_Vfmw_Clamp, .-Vp9_Vfmw_Clamp
	.align	2
	.global	Vp9_Vfmw_LoopFilterFrameInit
	.type	Vp9_Vfmw_LoopFilterFrameInit, %function
Vp9_Vfmw_LoopFilterFrameInit:
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
	add	r7, r2, #80
	mov	r9, r2
	mov	r5, r1
	mov	r6, r0
	mov	r8, r2
	mov	r10, r3
	mov	r4, r3, asr #5
	add	r3, r2, #112
	str	r3, [fp, #-48]
.L1966:
	ldrb	r3, [r9]
	cmp	r3, #0
	beq	.L1968
	ldr	r3, [r7]
	tst	r3, #2
	beq	.L1968
	ldrb	r3, [r9, #3]
	ldrsh	r1, [r8, #18]
	cmp	r3, #1
	addne	r1, r10, r1
	usatne	r1, #6, r1
.L1961:
	ldrb	r3, [r5]
	cmp	r3, #0
	beq	.L1973
.L1963:
	mov	r0, r5
	add	lr, r5, #5
	ldrsb	r3, [r0, #2]!
	mov	ip, r6
	add	r3, r1, r3, asl r4
	usat	r3, #6, r3
	strb	r3, [r6]
.L1965:
	ldrsb	r3, [r0, #1]!
	add	ip, ip, #2
	ldrsb	r2, [r5, #6]
	cmp	r0, lr
	add	r3, r1, r3, asl r4
	add	r3, r3, r2, asl r4
	usat	r3, #6, r3
	strb	r3, [ip]
	ldrsb	r3, [r0]
	ldrsb	r2, [r5, #7]
	add	r3, r1, r3, asl r4
	add	r3, r3, r2, asl r4
	usat	r3, #6, r3
	strb	r3, [ip, #1]
	bne	.L1965
.L1964:
	ldr	r3, [fp, #-48]
	add	r7, r7, #4
	add	r6, r6, #8
	add	r8, r8, #8
	cmp	r7, r3
	bne	.L1966
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1968:
	ldrb	r3, [r5]
	mov	r1, r10
	cmp	r3, #0
	bne	.L1963
.L1973:
	ldr	r3, .L1974
	mov	r2, #8
	mov	r0, r6
	ldr	r3, [r3, #48]
	blx	r3
	b	.L1964
.L1975:
	.align	2
.L1974:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	Vp9_Vfmw_LoopFilterFrameInit, .-Vp9_Vfmw_LoopFilterFrameInit
	.align	2
	.global	Vp9_MiColsAlignedToSb
	.type	Vp9_MiColsAlignedToSb, %function
Vp9_MiColsAlignedToSb:
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
	add	r0, r0, #7
	bic	r0, r0, #7
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Vp9_MiColsAlignedToSb, .-Vp9_MiColsAlignedToSb
	.align	2
	.global	Vp9_ToSbs
	.type	Vp9_ToSbs, %function
Vp9_ToSbs:
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
	add	r0, r0, #7
	mov	r0, r0, asr #3
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Vp9_ToSbs, .-Vp9_ToSbs
	.align	2
	.global	Vp9_GetTileOffsets
	.type	Vp9_GetTileOffsets, %function
Vp9_GetTileOffsets:
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
	ldr	lr, [fp, #4]
	add	ip, lr, #7
	mov	ip, ip, asr #3
	mul	r2, ip, r2
	add	ip, r2, ip
	mov	r2, r2, asr r3
	mov	r3, ip, asr r3
	mov	r2, r2, asl #3
	mov	r3, r3, asl #3
	cmp	r2, lr
	movge	r2, lr
	cmp	r3, lr
	str	r2, [r0]
	movge	r3, lr
	str	r3, [r1]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Vp9_GetTileOffsets, .-Vp9_GetTileOffsets
	.align	2
	.global	Vp9_GetTileRowOffsets
	.type	Vp9_GetTileRowOffsets, %function
Vp9_GetTileRowOffsets:
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
	add	ip, r1, #7
	ldr	lr, [fp, #4]
	mov	ip, ip, asr #3
	mul	r0, ip, r0
	add	ip, r0, ip
	mov	r0, r0, asr r2
	mov	r2, ip, asr r2
	mov	r0, r0, asl #3
	mov	r2, r2, asl #3
	cmp	r0, r1
	movge	r0, r1
	cmp	r2, r1
	str	r0, [r3]
	movge	r2, r1
	str	r2, [lr]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Vp9_GetTileRowOffsets, .-Vp9_GetTileRowOffsets
	.align	2
	.global	Vp9_Vfmw_GetTileColOffsets
	.type	Vp9_Vfmw_GetTileColOffsets, %function
Vp9_Vfmw_GetTileColOffsets:
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
	add	ip, r1, #7
	ldr	lr, [fp, #4]
	mov	ip, ip, asr #3
	mul	r0, ip, r0
	add	ip, r0, ip
	mov	r0, r0, asr r2
	mov	r2, ip, asr r2
	mov	r0, r0, asl #3
	mov	r2, r2, asl #3
	cmp	r0, r1
	movge	r0, r1
	cmp	r2, r1
	str	r0, [r3]
	movge	r2, r1
	str	r2, [lr]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Vp9_Vfmw_GetTileColOffsets, .-Vp9_Vfmw_GetTileColOffsets
	.align	2
	.global	Vp9_SetPoolInfoFrame
	.type	Vp9_SetPoolInfoFrame, %function
Vp9_SetPoolInfoFrame:
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
	add	r3, r0, #266240
	add	ip, r0, #270336
	add	r9, r0, #290816
	ldr	r2, [r3, #2288]
	ldr	r7, [r3, #2292]
	and	r2, r2, #7
	ldr	lr, [ip, #408]
	and	r7, r7, #3
	ldr	r6, [ip, #404]
	ldr	r5, [ip, #484]
	mov	r2, r2, asl #10
	ldr	r4, [ip, #508]
	orr	r2, r2, r7, asl #13
	and	lr, lr, #1
	and	r6, r6, #3
	ldr	r7, [ip, #480]
	orr	r2, r2, lr
	and	r5, r5, #1
	orr	r2, r2, r6, asl #1
	ldr	lr, [ip, #448]
	and	r7, r7, #1
	mov	r4, r4, asl #7
	orr	r5, r2, r5, asl #9
	ldr	r6, [ip, #444]
	orr	r5, r5, r7, asl #8
	ldr	r2, [ip, #440]
	uxtb	r4, r4
	and	lr, lr, #1
	orr	r4, r5, r4
	and	r6, r6, #1
	ldr	r5, [ip, #436]
	orr	lr, r4, lr, asl #6
	and	r2, r2, #1
	orr	lr, lr, r6, asl #5
	and	r4, r5, #1
	orr	r2, lr, r2, asl #4
	orr	r2, r2, r4, asl #3
	str	r2, [r1]
	ldr	lr, [ip, #452]
	ldr	r2, [r9, #2840]
	cmp	lr, r2
	movne	r6, #1048576
	beq	.L2006
.L1982:
	ldr	r2, [r3, #2244]
	mov	r7, #0
	ldr	lr, [r3, #2248]
	ldr	r5, [r3, #2132]
	mov	r2, r2, asl #12
	ldr	r8, [ip, #520]
	ldr	r4, [r3, #2240]
	and	lr, lr, #15
	uxth	r2, r2
	and	r8, r8, #7
	orr	r2, r2, lr, asl #16
	and	r4, r4, #15
	ldr	lr, [r3, #2128]
	mov	r5, r5, asl #7
	ldr	r10, [r3, #2124]
	orr	r2, r2, r8
	orr	r4, r2, r4, asl #8
	ldr	r8, [r3, #2120]
	uxtb	r5, r5
	and	lr, lr, #1
	orr	r4, r4, r5
	and	r10, r10, #1
	ldr	r5, [r3, #2112]
	orr	r4, r4, lr, asl #6
	and	r2, r8, #1
	orr	lr, r4, r10, asl #5
	and	r4, r5, #1
	orr	lr, lr, r2, asl #4
	orr	r2, lr, r4, asl #3
	orr	r2, r2, r6
	str	r2, [r1, #4]
	ldr	lr, [ip, #456]
	ldr	r2, [ip, #452]
	add	lr, lr, #7
	add	r2, r2, #7
	mov	lr, lr, asr #3
	sub	lr, lr, #1
	mov	r2, r2, asr #3
	sub	r2, r2, #1
	orr	r2, r2, lr, asl #16
	str	r2, [r1, #8]
	ldr	lr, [r3, #2400]
	ldr	r2, [r3, #2404]
	and	lr, lr, #63
	and	r2, r2, #7
	orr	r2, r2, lr, asl #8
	str	r2, [r1, #12]
.L1983:
	add	r5, r1, r7, lsl #3
	mov	r8, r7, asl #2
	add	r5, r5, #12
	mov	r6, #0
.L1984:
	mov	lr, r6, asl #1
	add	r6, r6, #1
	add	r4, lr, #1
	add	lr, r8, lr
	add	r4, r8, r4
	cmp	r6, #2
	add	r10, r3, lr, lsl #1
	add	r2, r3, r4, lsl #1
	mov	lr, r10
	ldrb	r10, [r10, #2312]
	mov	r4, r2
	ldrb	r2, [r2, #2312]
	ldrb	r4, [r4, #2313]
	and	r10, r10, #63
	and	r2, r2, #63
	ldrb	lr, [lr, #2313]
	and	r4, r4, #63
	mov	r2, r2, asl #16
	and	lr, lr, #63
	orr	r2, r2, r4, asl #24
	orr	r10, r2, r10
	orr	r2, r10, lr, asl #8
	str	r2, [r5, #4]!
	bne	.L1984
	add	r7, r7, #1
	cmp	r7, #8
	bne	.L1983
	ldr	r10, [r3, #2308]
	mov	r2, #0
	ldr	r6, [r3, #2304]
	add	r4, ip, #600
	cmp	r10, r2
	ldrb	r8, [r3, #2296]
	eor	r7, r10, r10, asr #31
	mov	lr, r2
	movlt	r5, #268435456
	movge	r5, r2
	str	r5, [fp, #-48]
	eor	r5, r6, r6, asr #31
	cmp	r6, r2
	sub	r5, r5, r6, asr #31
	ldr	r6, [r3, #2300]
	sub	r7, r7, r10, asr #31
	movlt	r10, #1048576
	movge	r10, r2
	cmp	r6, r2
	and	r5, r5, #15
	str	r10, [fp, #-52]
	and	r7, r7, #15
	movlt	r10, #4096
	movge	r10, r2
	cmp	r6, #0
	mov	r5, r5, asl #16
	rsblt	r6, r6, #0
	orr	r5, r5, r7, asl #24
	and	r6, r6, #15
	orr	r5, r5, r8
	orr	r6, r5, r6, asl #8
	ldr	r5, [fp, #-48]
	orr	r6, r6, r5
	ldr	r5, [fp, #-52]
	orr	r6, r6, r5
	orr	r10, r6, r10
	str	r10, [r1, #80]
	ldrb	r6, [ip, #527]
	ldrb	r5, [ip, #528]
	and	r6, r6, #1
	ldrb	r7, [ip, #524]
	ldrb	r8, [ip, #525]
	and	r10, r5, #1
	mov	r6, r6, asl #2
	and	r7, r7, #1
	orr	r5, r6, r10, asl #3
	and	r6, r8, #1
	orr	r5, r5, r7
	orr	r5, r5, r6, asl #1
	str	r5, [r1, #84]
.L1989:
	ldr	r5, [r4, #4]!
	and	r5, r5, #15
	orr	lr, lr, r5, asl r2
	add	r2, r2, #4
	cmp	r2, #32
	bne	.L1989
	add	r5, r3, #2064
	movw	r4, #2580
	str	lr, [r1, #88]
	movw	r2, #2588
	ldrh	lr, [r5, r4]
	movw	r6, #2572
	ldrh	r2, [r5, r2]
	movw	r4, #2604
	ubfx	lr, lr, #0, #9
	ldrh	r7, [r5, r6]
	ubfx	r2, r2, #0, #9
	movw	r6, #2612
	mov	lr, lr, asl #9
	ubfx	r7, r7, #0, #9
	orr	r2, lr, r2, asl #18
	movw	r8, #2596
	orr	r2, r2, r7
	str	r2, [r1, #92]
	ldrh	r4, [r5, r4]
	movw	r7, #2628
	ldrh	r10, [r5, r6]
	movw	r6, #2620
	ubfx	r4, r4, #0, #9
	ldrh	r8, [r5, r8]
	ubfx	r10, r10, #0, #9
	mov	r2, #0
	mov	r4, r4, asl #9
	ubfx	r8, r8, #0, #9
	orr	lr, r4, r10, asl #18
	mov	r4, r2
	orr	lr, lr, r8
	str	lr, [r1, #96]
	ldrh	r7, [r5, r7]
	ldrh	lr, [r5, r6]
	ubfx	r5, r7, #0, #9
	ubfx	lr, lr, #0, #9
	orr	lr, lr, r5, asl #9
	str	lr, [r1, #100]
.L1990:
	movw	lr, #8734
	movt	lr, 4
	add	lr, r2, lr
	ldrb	lr, [r0, lr]
	orr	r4, r4, lr, asl r2
	add	r2, r2, #8
	cmp	r2, #32
	bne	.L1990
	mov	r2, #0
	str	r4, [r1, #104]
	mov	r4, r2
.L1991:
	movw	lr, #8766
	movt	lr, 4
	add	lr, r2, lr
	ldrb	lr, [r0, lr]
	orr	r4, r4, lr, asl r2
	add	r2, r2, #8
	cmp	r2, #32
	bne	.L1991
	mov	r7, #0
	add	r8, ip, #544
	mov	r10, r7
	str	r4, [r1, #108]
.L1992:
	ldrh	r4, [r8, #2]
	mov	r2, r7, asl #1
	ldrh	lr, [r8], #8
	add	r5, r7, #16
	and	r4, r4, #1
	add	r7, r7, #1
	and	lr, lr, #3
	cmp	r7, #8
	mov	lr, lr, asl r2
	orr	r2, lr, r4, asl r5
	orr	r10, r10, r2
	bne	.L1992
	str	r10, [r1, #112]
	ldr	r2, [r3, #2016]
	str	r2, [r1, #116]
	ldr	r2, [r3, #2028]
	str	r2, [r1, #120]
	ldr	r2, [r3, #2092]
	str	r2, [r1, #128]
	ldr	r2, [r3, #2096]
	str	r2, [r1, #132]
	ldr	r2, [r3, #2100]
	str	r2, [r1, #136]
	ldr	r2, [r3, #2104]
	str	r2, [r1, #140]
	ldr	r2, [ip, #784]
	ldr	lr, [ip, #780]
	uxth	r2, r2
	orr	r2, r2, lr, asl #16
	str	r2, [r1, #180]
	ldr	r2, [ip, #800]
	ldr	lr, [ip, #796]
	uxth	r2, r2
	orr	r2, r2, lr, asl #16
	str	r2, [r1, #184]
	ldr	r2, [ip, #816]
	ldr	lr, [ip, #812]
	uxth	r2, r2
	orr	r2, r2, lr, asl #16
	str	r2, [r1, #188]
	ldr	lr, [ip, #808]
	ldr	r2, [ip, #824]
	and	lr, lr, #63
	ldr	r4, [ip, #792]
	and	r2, r2, #63
	mov	lr, lr, asl #8
	and	r4, r4, #63
	orr	r2, lr, r2, asl #16
	orr	r2, r2, r4
	str	r2, [r1, #192]
	ldr	r2, [ip, #804]
	ldr	r4, [ip, #820]
	and	r2, r2, #63
	ldr	lr, [ip, #788]
	and	r4, r4, #63
	mov	ip, r2, asl #8
	and	lr, lr, #63
	orr	r2, ip, r4, asl #16
	orr	r2, r2, lr
	str	r2, [r1, #196]
	ldr	r2, [r3, #2240]
	add	r2, r0, r2, lsl #4
	add	r2, r2, #270336
	ldr	ip, [r2, #644]
	ldr	lr, [r2, #648]
	uxth	r2, ip
	orr	r2, r2, lr, asl #16
	str	r2, [r1, #200]
	ldr	r2, [r3, #2244]
	add	r2, r0, r2, lsl #4
	add	r2, r2, #270336
	ldr	ip, [r2, #644]
	ldr	lr, [r2, #648]
	uxth	r2, ip
	orr	r2, r2, lr, asl #16
	str	r2, [r1, #204]
	ldr	r2, [r3, #2248]
	add	r2, r0, r2, lsl #4
	add	r2, r2, #270336
	ldr	ip, [r2, #644]
	ldr	lr, [r2, #648]
	uxth	r2, ip
	orr	r2, r2, lr, asl #16
	str	r2, [r1, #208]
	ldr	r2, [r9, #2840]
	ldr	ip, [r9, #2844]
	uxth	r2, r2
	orr	r2, r2, ip, asl #16
	str	r2, [r1, #212]
	ldr	ip, [r3, #2240]
	add	ip, r0, ip, lsl #4
	add	ip, ip, #270336
	ldr	r2, [ip, #644]
	add	r2, r2, #255
	bic	r2, r2, #255
	mov	r2, r2, asl #4
	str	r2, [r1, #216]
	ldr	r2, [r0]
	ldr	r5, [ip, #644]
	ldr	r6, [ip, #648]
	ldr	r7, [r2, #588]
	add	lr, r5, #255
	add	r4, r6, #63
	bic	r2, lr, #255
	cmp	r7, #1
	bic	lr, r4, #63
	mul	lr, lr, r2
	beq	.L2007
.L1993:
	str	lr, [r1, #220]
	ldr	lr, [ip, #644]
	ldr	r4, [ip, #648]
	add	r2, lr, #508
	add	lr, lr, #1020
	add	r2, r2, #3
	adds	ip, r4, #63
	addmi	ip, r4, #126
	add	lr, lr, #2
	cmp	r2, #0
	mov	ip, ip, asr #6
	movlt	r2, lr
	bic	r2, r2, #508
	bic	r2, r2, #3
	mov	ip, ip, asl #5
	add	lr, r2, #63
	cmp	r2, #0
	movlt	r2, lr
	mov	r2, r2, asr #6
	mov	r2, r2, asl #1
	mul	r2, r2, ip
	str	r2, [r1, #224]
	ldr	ip, [r3, #2244]
	add	ip, r0, ip, lsl #4
	add	ip, ip, #270336
	ldr	r2, [ip, #644]
	add	r2, r2, #255
	bic	r2, r2, #255
	mov	r2, r2, asl #4
	str	r2, [r1, #228]
	ldr	r2, [r0]
	ldr	r5, [ip, #644]
	ldr	r6, [ip, #648]
	ldr	r7, [r2, #588]
	add	lr, r5, #255
	add	r4, r6, #63
	bic	r2, lr, #255
	cmp	r7, #1
	bic	lr, r4, #63
	mul	lr, lr, r2
	beq	.L2008
.L1994:
	str	lr, [r1, #232]
	ldr	lr, [ip, #644]
	ldr	r4, [ip, #648]
	add	r2, lr, #508
	add	lr, lr, #1020
	add	r2, r2, #3
	adds	ip, r4, #63
	addmi	ip, r4, #126
	add	lr, lr, #2
	cmp	r2, #0
	mov	ip, ip, asr #6
	movlt	r2, lr
	bic	r2, r2, #508
	bic	r2, r2, #3
	mov	ip, ip, asl #5
	add	lr, r2, #63
	cmp	r2, #0
	movlt	r2, lr
	mov	r2, r2, asr #6
	mov	r2, r2, asl #1
	mul	r2, r2, ip
	str	r2, [r1, #236]
	ldr	r2, [r3, #2248]
	add	r2, r0, r2, lsl #4
	add	r2, r2, #270336
	ldr	r3, [r2, #644]
	add	r3, r3, #255
	bic	r3, r3, #255
	mov	r3, r3, asl #4
	str	r3, [r1, #240]
	ldr	r3, [r0]
	ldr	lr, [r2, #644]
	ldr	r4, [r2, #648]
	ldr	r5, [r3, #588]
	add	ip, lr, #255
	add	r0, r4, #63
	bic	r3, ip, #255
	cmp	r5, #1
	bic	ip, r0, #63
	mul	ip, ip, r3
	bne	.L1995
	add	r3, lr, #508
	cmp	r0, #0
	add	r3, r3, #3
	add	lr, lr, #1020
	add	lr, lr, #2
	addlt	r0, r4, #126
	cmp	r3, #0
	mov	r0, r0, asr #6
	movlt	r3, lr
	bic	r3, r3, #508
	bic	r3, r3, #3
	mov	r0, r0, asl #5
	add	lr, r3, #63
	cmp	r3, #0
	movlt	r3, lr
	mov	r3, r3, asr #6
	mov	r3, r3, asl #1
	mla	ip, r3, r0, ip
.L1995:
	str	ip, [r1, #244]
	ldr	r0, [r2, #644]
	ldr	ip, [r2, #648]
	add	r3, r0, #508
	add	r0, r0, #1020
	add	r3, r3, #3
	adds	r2, ip, #63
	addmi	r2, ip, #126
	add	r0, r0, #2
	cmp	r3, #0
	mov	r2, r2, asr #6
	movlt	r3, r0
	bic	r3, r3, #508
	bic	r3, r3, #3
	mov	r2, r2, asl #5
	add	r0, r3, #63
	cmp	r3, #0
	movlt	r3, r0
	mov	r3, r3, asr #6
	mov	r3, r3, asl #1
	mul	r3, r3, r2
	str	r3, [r1, #248]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2008:
	add	r2, r5, #508
	cmp	r4, #0
	add	r2, r2, #3
	add	r5, r5, #1020
	add	r5, r5, #2
	addlt	r4, r6, #126
	cmp	r2, #0
	mov	r4, r4, asr #6
	movlt	r2, r5
	bic	r2, r2, #508
	bic	r2, r2, #3
	mov	r4, r4, asl #5
	add	r5, r2, #63
	cmp	r2, #0
	movlt	r2, r5
	mov	r2, r2, asr #6
	mov	r2, r2, asl #1
	mla	lr, r2, r4, lr
	b	.L1994
.L2007:
	add	r2, r5, #508
	cmp	r4, #0
	add	r2, r2, #3
	add	r5, r5, #1020
	add	r5, r5, #2
	addlt	r4, r6, #126
	cmp	r2, #0
	mov	r4, r4, asr #6
	movlt	r2, r5
	bic	r2, r2, #508
	bic	r2, r2, #3
	mov	r4, r4, asl #5
	add	r5, r2, #63
	cmp	r2, #0
	movlt	r2, r5
	mov	r2, r2, asr #6
	mov	r2, r2, asl #1
	mla	lr, r2, r4, lr
	b	.L1993
.L2006:
	ldr	r6, [ip, #456]
	ldr	r2, [r9, #2844]
	cmp	r6, r2
	movne	r6, #1048576
	moveq	r6, #0
	b	.L1982
	.fnend
	.size	Vp9_SetPoolInfoFrame, .-Vp9_SetPoolInfoFrame
	.align	2
	.global	Vp9_SetPoolInfoTile
	.type	Vp9_SetPoolInfoTile, %function
Vp9_SetPoolInfoTile:
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
	ldr	r2, [r3]
	str	r2, [r1]
	ldrb	r2, [r3, #4]
	and	r2, r2, #127
	str	r2, [r1, #4]
	ldr	r2, [r3, #8]
	add	r2, r2, #128
	str	r2, [r1, #8]
	ldr	r2, [r3, #12]
	str	r2, [r1, #12]
	ldrb	r2, [r3, #16]
	and	r2, r2, #127
	str	r2, [r1, #16]
	ldr	r2, [r3, #20]
	str	r2, [r1, #20]
	ldrh	r2, [r3, #26]
	ldrh	ip, [r3, #24]
	cmp	ip, r2
	add	r0, ip, #7
	addne	r2, r2, #7
	ubfx	r0, r0, #3, #7
	movne	r2, r2, asr #3
	mov	r0, r0, asl #16
	subne	r2, r2, #1
	orreq	r2, r0, #255
	andne	r2, r2, #127
	orrne	r2, r2, r0
	str	r2, [r1, #24]
	ldrh	r0, [r3, #30]
	ldrh	ip, [r3, #28]
	cmp	ip, r0
	add	r2, ip, #7
	addne	r0, r0, #7
	ubfx	r2, r2, #3, #7
	movne	r0, r0, asr #3
	mov	r2, r2, asl #16
	subne	r0, r0, #1
	orreq	r2, r2, #255
	andne	r0, r0, #127
	orrne	r2, r0, r2
	str	r2, [r1, #28]
	ldr	r2, [r3, #32]
	mov	r0, #0
	ubfx	r2, r2, #0, #17
	str	r2, [r1, #32]
	ldr	r2, [r3, #36]
	ubfx	r2, r2, #0, #17
	str	r2, [r1, #36]
	ldr	r2, [r3, #40]
	ubfx	r2, r2, #0, #17
	str	r2, [r1, #40]
	ldr	r3, [r3, #44]
	str	r0, [r1, #252]
	ubfx	r3, r3, #0, #17
	str	r3, [r1, #44]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Vp9_SetPoolInfoTile, .-Vp9_SetPoolInfoTile
	.align	2
	.global	Vp9_DecodeTilesCtrl
	.type	Vp9_DecodeTilesCtrl, %function
Vp9_DecodeTilesCtrl:
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
	add	r3, r0, #270336
	mov	r7, r1
	mov	ip, #1
	add	r4, r0, #266240
	ldr	r1, [r3, #504]
	ldr	r9, [r3, #492]
	ldr	r8, [r7]
	mov	lr, r1
	str	r1, [fp, #-208]
	add	r1, r0, #290816
	mov	r2, ip, asl lr
	str	r1, [fp, #-188]
	mov	r5, r1
	ldr	r1, [r3, #500]
	ldr	r3, [r3, #496]
	mov	r10, r2
	str	r2, [fp, #-200]
	ldr	r2, [r7, #16]
	mov	r6, r1
	str	r1, [fp, #-160]
	add	r1, r0, #8
	mov	ip, ip, asl r6
	str	r3, [fp, #-204]
	str	r0, [fp, #-184]
	add	r3, r8, r2
	str	ip, [fp, #-132]
	str	r3, [fp, #-128]
	bl	Vp9_SetPoolInfoFrame
	mov	r1, #0
	str	r1, [r5, #2956]
	ldr	r2, [r4, #1988]
	cmp	r10, #0
	ldr	r3, [r4, #1992]
	str	r2, [fp, #-172]
	and	r3, r3, #15
	str	r3, [fp, #-168]
	ble	.L2024
	ldr	r2, [fp, #-204]
	add	r3, r9, #7
	mov	r10, r1
	str	r1, [fp, #-192]
	add	r2, r2, #7
	mov	r0, r3, asr #3
	str	r1, [fp, #-176]
	mov	r3, r2, asr #3
	str	r0, [fp, #-164]
	str	r0, [fp, #-216]
	str	r3, [fp, #-212]
	str	r1, [fp, #-196]
.L2023:
	ldr	r3, [fp, #-192]
	ldr	r2, [fp, #-212]
	ldr	r0, [fp, #-208]
	add	r3, r3, r2
	str	r3, [fp, #-192]
	ldr	r2, [fp, #-204]
	mov	r1, r3
	ldr	r3, [fp, #-196]
	mov	r1, r1, asr r0
	str	r1, [fp, #-196]
	ldr	lr, [fp, #-132]
	mov	r3, r3, asl #3
	mov	r0, r1
	cmp	r3, r2
	movge	r3, r2
	str	r3, [fp, #-144]
	mov	r1, r3
	mov	r3, r0, asl #3
	cmp	r3, r2
	movge	r3, r2
	str	r3, [fp, #-148]
	mov	r0, r3
	rsb	r3, r1, r0
	add	r3, r3, #7
	cmp	lr, #0
	mov	r2, r1
	mov	r3, r3, asr #3
	str	r3, [fp, #-140]
	ble	.L2017
	add	r3, r0, #7
	ldr	r4, [fp, #-216]
	add	r1, r2, #7
	mov	r2, #0
	mov	r3, r3, asr #3
	mov	r0, r2
	sub	r3, r3, #1
	mov	r1, r1, asr #3
	str	r2, [fp, #-108]
	mul	r3, r4, r3
	str	r10, [fp, #-116]
	mul	r1, r1, r4
	ldr	r2, [r7, #16]
	str	r0, [fp, #-112]
	str	r3, [fp, #-152]
	sub	r3, lr, #1
	str	r3, [fp, #-136]
	ldr	r3, [fp, #-200]
	str	r1, [fp, #-156]
	sub	r3, r3, #1
	str	r3, [fp, #-180]
	mov	r3, r10
	mov	r10, r0
	mov	ip, r3
	b	.L2022
.L2034:
	ldr	r2, [fp, #-180]
	ldr	lr, [fp, #-176]
	cmp	r2, lr
	bgt	.L2018
.L2020:
	ldr	r1, [fp, #-104]
	rsb	r2, r4, r5
	ldr	r3, [fp, #-172]
	add	r2, r2, #7
	ldr	lr, [fp, #-152]
	add	r10, r10, #1
	rsb	r3, r3, r1
	ldr	r1, [fp, #-168]
	mov	r2, r2, asr #3
	strh	r4, [fp, #-68]
	add	r3, r3, r1
	ldrh	r1, [fp, #-144]
	and	r0, r3, #15
	add	r4, r4, #7
	bic	r3, r3, #15
	strh	r5, [fp, #-66]
	strh	r1, [fp, #-72]
	mov	r0, r0, asl #3
	ldrh	r1, [fp, #-148]
	strb	r0, [fp, #-92]
	str	r3, [fp, #-96]
	strh	r1, [fp, #-70]
	ldr	r1, [fp, #-140]
	mul	r2, r1, r2
	add	r1, r5, #7
	add	r1, lr, r1, asr #3
	mov	lr, #0
	add	ip, ip, r2
	cmp	r2, lr
	sub	r2, fp, #44
	str	r2, [fp, #-48]
	ldr	r2, [fp, #-116]
	sub	r1, r1, #1
	str	lr, [fp, #-84]
	strb	lr, [fp, #-80]
	str	r2, [fp, #-52]
	ldr	r2, [fp, #-156]
	str	lr, [fp, #-76]
	add	r4, r2, r4, asr #3
	str	ip, [fp, #-116]
	sub	r2, ip, #1
	str	r1, [fp, #-64]
	str	r2, [fp, #-60]
	mov	r2, r6, asl #3
	str	r4, [fp, #-56]
	str	r2, [fp, #-88]
	bne	.L2032
.L2021:
	ldr	r3, [fp, #-132]
	add	r8, r8, r6
	ldr	r2, [r7, #16]
	cmp	r10, r3
	rsb	r2, r6, r2
	str	r2, [r7, #16]
	beq	.L2033
.L2022:
	ldr	r3, [fp, #-108]
	mov	r0, r7
	ldr	r1, [fp, #-164]
	str	ip, [fp, #-124]
	add	r3, r3, r1
	str	r3, [fp, #-108]
	mov	r1, r3
	ldr	r3, [fp, #-112]
	mov	r4, r3, asl #3
	add	r3, r8, #4
	str	r3, [fp, #-120]
	mov	r3, r1
	ldr	r1, [fp, #-160]
	cmp	r4, r9
	mov	r3, r3, asr r1
	movge	r4, r9
	str	r3, [fp, #-112]
	mov	r1, r8
	mov	r5, r3, asl #3
	ldr	r3, [fp, #-128]
	cmp	r5, r9
	rsb	r6, r8, r3
	movge	r5, r9
	bl	BsInit
	ldr	r3, [fp, #-136]
	mov	r1, #32
	str	r8, [fp, #-104]
	mov	r0, r7
	cmp	r10, r3
	ldr	ip, [fp, #-124]
	ldr	r3, [fp, #-120]
	bge	.L2034
.L2018:
	ldr	r2, [fp, #-128]
	str	ip, [fp, #-120]
	cmp	r2, #0
	cmpne	r8, #0
	beq	.L2026
	cmp	r8, r3
	mov	ip, r2
	mov	r8, r3
	movcc	r2, #1
	movcs	r2, #0
	cmp	ip, r3
	movcc	r2, #0
	cmp	r2, #0
	beq	.L2026
	bl	BsGet
	str	r8, [fp, #-104]
	ldr	ip, [fp, #-120]
	mov	r6, r0
	b	.L2020
.L2032:
	ldr	r4, [fp, #-188]
	sub	r3, fp, #96
	ldr	r1, [fp, #-184]
	str	ip, [fp, #-104]
	ldr	r2, [r4, #2956]
	mov	r0, r1
	add	r1, r1, r2, lsl #8
	add	r1, r1, #1024
	add	r1, r1, #8
	bl	Vp9_SetPoolInfoTile
	ldr	r3, [r4, #2956]
	ldr	ip, [fp, #-104]
	add	r3, r3, #1
	str	r3, [r4, #2956]
	b	.L2021
.L2033:
	mov	r10, ip
.L2017:
	ldr	r3, [fp, #-176]
	ldr	r2, [fp, #-200]
	add	r3, r3, #1
	str	r3, [fp, #-176]
	cmp	r3, r2
	bne	.L2023
.L2024:
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2026:
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	.fnend
	.size	Vp9_DecodeTilesCtrl, .-Vp9_DecodeTilesCtrl
	.align	2
	.global	Vp9_TxCoefProbConvert2
	.type	Vp9_TxCoefProbConvert2, %function
Vp9_TxCoefProbConvert2:
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
	ldr	r4, .L2036
	mov	r2, #18
	mov	r5, r0
	mov	r6, r1
	add	r7, r1, #108
	ldr	r3, [r4, #52]
	blx	r3
	ldr	r3, [r4, #52]
	add	r1, r6, #18
	add	r0, r5, #32
	mov	r2, #18
	blx	r3
	ldr	r3, [r4, #52]
	add	r1, r6, #36
	add	r0, r5, #64
	mov	r2, #18
	blx	r3
	ldr	r3, [r4, #52]
	add	r1, r6, #54
	add	r0, r5, #96
	mov	r2, #18
	blx	r3
	ldr	r3, [r4, #52]
	add	r1, r6, #72
	add	r0, r5, #128
	mov	r2, #18
	blx	r3
	ldr	r3, [r4, #52]
	add	r1, r6, #90
	add	r0, r5, #160
	mov	r2, #18
	blx	r3
	mov	r1, r7
	ldr	r3, [r4, #52]
	add	r0, r5, #192
	mov	r2, #18
	blx	r3
	mov	r1, r7
	ldr	r3, [r4, #52]
	add	r0, r5, #256
	mov	r2, #18
	blx	r3
	ldr	r3, [r4, #52]
	add	r1, r6, #126
	add	r0, r5, #288
	mov	r2, #18
	blx	r3
	ldr	r3, [r4, #52]
	add	r1, r6, #144
	add	r0, r5, #320
	mov	r2, #18
	blx	r3
	ldr	r3, [r4, #52]
	add	r1, r6, #162
	add	r0, r5, #352
	mov	r2, #18
	blx	r3
	ldr	r3, [r4, #52]
	add	r1, r6, #180
	add	r0, r5, #384
	mov	r2, #18
	blx	r3
	ldr	r3, [r4, #52]
	add	r1, r6, #198
	add	r0, r5, #416
	mov	r2, #18
	blx	r3
	ldr	r3, [r4, #52]
	add	r1, r6, #216
	add	r0, r5, #448
	mov	r2, #18
	blx	r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2037:
	.align	2
.L2036:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	Vp9_TxCoefProbConvert2, .-Vp9_TxCoefProbConvert2
	.align	2
	.global	Vp9_ProbBurstConvert
	.type	Vp9_ProbBurstConvert, %function
Vp9_ProbBurstConvert:
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
	mov	r5, r1
	mov	r9, r3
	mov	r6, r0
	mov	r8, r2
	ldr	r7, [fp, #4]
	bl	Vp9_TxCoefProbConvert2
	add	r1, r5, #216
	add	r0, r6, #512
	add	r4, r5, #1728
	bl	Vp9_TxCoefProbConvert2
	add	r1, r5, #432
	add	r0, r6, #1024
	add	r10, r5, #1760
	bl	Vp9_TxCoefProbConvert2
	add	r1, r5, #648
	add	r0, r6, #1536
	add	r4, r4, #8
	bl	Vp9_TxCoefProbConvert2
	add	r1, r5, #864
	add	r0, r6, #2048
	add	r10, r10, #12
	bl	Vp9_TxCoefProbConvert2
	add	r1, r5, #1072
	add	r1, r1, #8
	add	r0, r6, #2560
	bl	Vp9_TxCoefProbConvert2
	add	r1, r5, #1296
	add	r0, r6, #3072
	bl	Vp9_TxCoefProbConvert2
	add	r1, r5, #1504
	add	r0, r6, #3584
	add	r1, r1, #8
	bl	Vp9_TxCoefProbConvert2
	add	r0, r6, #4096
	mov	r3, #0
.L2039:
	mov	r1, r4
	mov	r2, #8
	ldrb	ip, [r1, #-8]!
	b	.L2043
.L2041:
	ldrb	lr, [r1, #1]!
	orr	ip, ip, lr, asl r2
	add	r2, r2, #8
	cmp	r2, #32
	streq	ip, [r0, r3, asl #2]
	addeq	r3, r3, #1
	moveq	ip, #0
	moveq	r2, ip
.L2043:
	cmp	r4, r1
	bne	.L2041
	add	r4, r4, #9
	str	ip, [r0, r3, asl #2]
	cmp	r4, r10
	add	r3, r3, #2
	bne	.L2039
	add	r2, r5, #1856
	add	r2, r2, #6
.L2042:
	mov	lr, r10
	mov	ip, #8
	ldrb	r4, [lr, #-8]!
	b	.L2047
.L2045:
	ldrb	r1, [lr, #1]!
	orr	r4, r4, r1, asl ip
	add	ip, ip, #8
	cmp	ip, #32
	streq	r4, [r0, r3, asl #2]
	addeq	r3, r3, #1
	moveq	r4, #0
	moveq	ip, r4
.L2047:
	cmp	r10, lr
	bne	.L2045
	add	r10, r10, #9
	str	r4, [r0, r3, asl #2]
	cmp	r10, r2
	add	r3, r3, #2
	bne	.L2042
	ldrb	r1, [r8, #7]
	cmp	r7, #0
	ldrb	r3, [r8, #8]
	mov	ip, #0
	ldrb	r2, [r8, #5]
	movne	r9, ip
	ldrb	lr, [r8, #6]
	mov	r1, r1, asl #16
	orr	r3, r1, r3, asl #24
	mov	r7, r9, asl #6
	orr	r3, r3, r2
	sub	r7, r7, r9, asl #4
	orr	r3, r3, lr, asl #8
	str	r3, [r0, #256]
	ldrb	r3, [r8, #10]
	add	lr, r7, #1840
	ldrb	r1, [r8, #11]
	add	r7, r7, #1888
	ldrb	r2, [r8, #9]
	add	lr, lr, #13
	mov	r3, r3, asl #8
	add	r7, r7, #13
	orr	r3, r3, r1, asl #16
	add	r6, r6, #4352
	orr	r3, r3, r2
	str	r3, [r0, #260]
	ldrb	r3, [r8, #13]
	add	lr, r5, lr
	ldrb	r1, [r8, #14]
	add	r7, r5, r7
	ldrb	r8, [r8, #12]
	mov	r2, ip
	mov	r3, r3, asl #8
	mov	r4, #3
	orr	r3, r3, r1, asl #16
	orr	r3, r3, r8
	str	r3, [r0, #264]
.L2049:
	mov	r1, lr
	mov	r3, #0
.L2051:
	ldrb	r0, [r1, #1]!
	add	r3, r3, #1
	orr	r2, r2, r0, asl ip
	add	ip, ip, #8
	cmp	ip, #32
	streq	r2, [r6, r4, asl #2]
	addeq	r4, r4, #1
	moveq	r2, #0
	moveq	ip, r2
	cmp	r3, #3
	bne	.L2051
	add	lr, lr, #3
	cmp	lr, r7
	bne	.L2049
	ldrb	r2, [r5, #2016]
	add	r1, r6, r4, lsl #2
	ldrb	r0, [r5, #2017]
	add	lr, r4, #11
	ldrb	ip, [r5, #2015]
	mov	r7, #0
	mov	r2, r2, asl #8
	mov	r3, r7
	orr	r2, r2, r0, asl #16
	mov	r0, r7
	orr	r2, r2, ip
	str	r2, [r6, r4, asl #2]
	ldrb	r8, [r5, #2009]
	mov	r2, #1
	ldrb	ip, [r5, #2010]
	ldrb	r4, [r5, #2013]
	ldrb	r9, [r5, #2014]
	mov	r8, r8, asl #16
	orr	ip, r8, ip, asl #24
	orr	ip, ip, r4
	orr	ip, ip, r9, asl #8
	str	ip, [r1, #4]
	ldrb	r8, [r5, #2003]
	ldrb	ip, [r5, #2004]
	ldrb	r4, [r5, #2011]
	ldrb	r9, [r5, #2012]
	mov	r8, r8, asl #16
	orr	ip, r8, ip, asl #24
	orr	ip, ip, r4
	orr	ip, ip, r9, asl #8
	str	ip, [r1, #8]
	ldrb	r8, [r5, #2007]
	ldrb	ip, [r5, #2008]
	ldrb	r4, [r5, #2005]
	ldrb	r9, [r5, #2006]
	mov	r8, r8, asl #16
	orr	ip, r8, ip, asl #24
	orr	ip, ip, r4
	orr	ip, ip, r9, asl #8
	str	ip, [r1, #12]
	ldrb	r8, [r5, #1981]
	ldrb	ip, [r5, #1982]
	ldrb	r4, [r5, #1979]
	ldrb	r9, [r5, #1980]
	mov	r8, r8, asl #16
	orr	ip, r8, ip, asl #24
	orr	ip, ip, r4
	orr	ip, ip, r9, asl #8
	str	ip, [r1, #16]
	ldrb	r8, [r5, #1985]
	ldrb	ip, [r5, #1986]
	ldrb	r4, [r5, #1983]
	ldrb	r9, [r5, #1984]
	mov	r8, r8, asl #16
	orr	ip, r8, ip, asl #24
	orr	ip, ip, r4
	orr	ip, ip, r9, asl #8
	str	ip, [r1, #20]
	ldrb	r8, [r5, #1999]
	ldrb	ip, [r5, #2000]
	ldrb	r4, [r5, #1987]
	ldrb	r9, [r5, #1998]
	mov	r8, r8, asl #16
	orr	ip, r8, ip, asl #24
	orr	ip, ip, r4
	orr	ip, ip, r9, asl #8
	str	ip, [r1, #24]
	ldrb	r4, [r5, #2002]
	ldrb	ip, [r5, #2001]
	orr	ip, ip, r4, asl #8
	str	ip, [r1, #28]
	ldrb	r8, [r5, #1990]
	ldrb	ip, [r5, #1991]
	ldrb	r4, [r5, #1988]
	ldrb	r9, [r5, #1989]
	mov	r8, r8, asl #16
	orr	ip, r8, ip, asl #24
	orr	ip, ip, r4
	orr	ip, ip, r9, asl #8
	str	ip, [r1, #32]
	ldrb	r8, [r5, #1994]
	ldrb	ip, [r5, #1995]
	ldrb	r4, [r5, #1992]
	ldrb	r9, [r5, #1993]
	mov	r8, r8, asl #16
	orr	ip, r8, ip, asl #24
	orr	ip, ip, r4
	orr	ip, ip, r9, asl #8
	str	ip, [r1, #36]
	ldrb	ip, [r5, #1997]
	ldrb	r8, [r5, #1958]
	ldrb	r4, [r5, #1996]
	mov	ip, ip, asl #8
	orr	ip, ip, r8, asl #16
	orr	ip, ip, r4
	str	ip, [r1, #40]
.L2053:
	add	ip, r2, r7
	add	ip, ip, #1952
	add	ip, ip, #5
	add	ip, r5, ip
.L2055:
	ldrb	r1, [ip, #1]!
	add	r2, r2, #1
	orr	r0, r0, r1, asl r3
	add	r3, r3, #8
	cmp	r3, #32
	streq	r0, [r6, lr, asl #2]
	addeq	lr, lr, #1
	moveq	r0, #0
	moveq	r3, r0
	cmp	r2, #2
	ble	.L2055
	add	r7, r7, #3
	mov	r2, #0
	cmp	r7, #21
	bne	.L2053
	add	r4, r5, #8
	mov	r3, r5
	mov	r1, r2
.L2056:
	add	r0, r2, #8
	ldrb	ip, [r3, #1950]
	cmp	r0, #32
	orr	r1, r1, ip, asl r2
	add	r2, r2, #16
	beq	.L2086
	ldrb	ip, [r3, #1951]
	cmp	r2, #32
	orr	r1, r1, ip, asl r0
	streq	r1, [r6, lr, asl #2]
	moveq	r1, #0
	addeq	lr, lr, #1
	moveq	r2, r1
.L2059:
	add	r3, r3, #2
	cmp	r3, r4
	bne	.L2056
	ldrb	r1, [r5, #2054]
	add	ip, r5, #2016
	ldrb	r2, [r5, #2021]
	add	r4, r5, #2096
	add	r0, r6, lr, lsl #2
	mov	r3, #0
	orr	r2, r2, r1, asl #8
	str	r2, [r6, lr, asl #2]
	ldrb	r2, [r5, #2019]
	add	lr, lr, #2
	ldrb	r8, [r5, #2020]
	add	ip, ip, #15
	ldrb	r7, [r5, #2018]
	add	r4, r4, #1
	mov	r2, r2, asl #8
	mov	r1, r3
	orr	r2, r2, r8, asl #16
	orr	r2, r2, r7
	str	r2, [r0, #4]
.L2061:
	sub	r2, ip, #10
.L2063:
	ldrb	r0, [r2, #1]!
	orr	r1, r1, r0, asl r3
	add	r3, r3, #8
	cmp	r3, #32
	streq	r1, [r6, lr, asl #2]
	addeq	lr, lr, #1
	moveq	r1, #0
	moveq	r3, r1
	cmp	ip, r2
	bne	.L2063
	add	ip, ip, #33
	cmp	ip, r4
	bne	.L2061
	ldrb	r1, [r5, #2065]
	add	r4, r5, #2032
	ldrb	r2, [r5, #2032]
	add	r4, r4, #10
	add	r7, r5, #2096
	mov	r3, #0
	add	r7, r7, #12
	orr	r2, r2, r1, asl #8
	add	ip, lr, #1
	str	r2, [r6, lr, asl #2]
	mov	r1, r3
	mov	lr, r4
.L2065:
	sub	r2, lr, #10
.L2067:
	ldrb	r0, [r2, #1]!
	orr	r1, r1, r0, asl r3
	add	r3, r3, #8
	cmp	r3, #32
	streq	r1, [r6, ip, asl #2]
	addeq	ip, ip, #1
	moveq	r1, #0
	moveq	r3, r1
	cmp	r2, lr
	bne	.L2067
	add	lr, r2, #33
	cmp	lr, r7
	bne	.L2065
	mov	r3, #0
	mov	r1, r3
.L2068:
	mov	r8, r4
	mov	r9, #2
.L2073:
	mov	r0, r8
	mov	r2, #0
.L2070:
	ldrb	lr, [r0, #1]!
	add	r2, r2, #1
	orr	r1, r1, lr, asl r3
	add	r3, r3, #8
	cmp	r3, #32
	streq	r1, [r6, ip, asl #2]
	addeq	ip, ip, #1
	moveq	r1, #0
	moveq	r3, r1
	cmp	r2, #3
	bne	.L2070
	subs	r9, r9, #1
	add	r8, r8, #3
	bne	.L2073
	add	r4, r4, #33
	cmp	r4, r7
	bne	.L2068
	ldrb	r3, [r5, #2050]
	add	r0, r6, ip, lsl #2
	ldrb	r1, [r5, #2051]
	ldrb	r2, [r5, #2049]
	mov	r3, r3, asl #8
	orr	r3, r3, r1, asl #16
	orr	r3, r3, r2
	str	r3, [r6, ip, asl #2]
	ldrb	r3, [r5, #2083]
	ldrb	r1, [r5, #2084]
	ldrb	r2, [r5, #2082]
	mov	r3, r3, asl #8
	orr	r3, r3, r1, asl #16
	orr	r3, r3, r2
	str	r3, [r0, #4]
	ldrb	r1, [r5, #2053]
	ldrb	r3, [r5, #2086]
	ldrb	r2, [r5, #2052]
	ldrb	ip, [r5, #2085]
	mov	r1, r1, asl #16
	orr	r3, r1, r3, asl #24
	orr	r3, r3, r2
	orr	r3, r3, ip, asl #8
	str	r3, [r0, #8]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2086:
	str	r1, [r6, lr, asl #2]
	mov	r2, #8
	add	lr, lr, #1
	ldrb	r1, [r3, #1951]
	b	.L2059
	.fnend
	.size	Vp9_ProbBurstConvert, .-Vp9_ProbBurstConvert
	.align	2
	.global	Vp9_DecodeTiles
	.type	Vp9_DecodeTiles, %function
Vp9_DecodeTiles:
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
	add	r5, r0, #270336
	add	r9, r0, #266240
	add	r4, r0, #290816
	mov	lr, #0
	ldr	r3, [r5, #512]
	mov	r6, r0
	ldr	r7, [r5, #408]
	sub	r0, fp, #84
	ldr	r10, [r5, #488]
	str	r3, [fp, #-112]
	clz	r8, r7
	ldr	r3, [r9, #2116]
	mov	r8, r8, lsr #5
	str	r10, [fp, #-96]
	str	lr, [fp, #-92]
	str	r3, [fp, #-104]
	ldr	r3, [r9, #2108]
	str	r8, [r4, #2912]
	str	r7, [r4, #2924]
	ldr	r8, [r5, #440]
	str	lr, [fp, #-88]
	str	r3, [fp, #-108]
	str	r8, [r4, #2932]
	mov	r8, r2
	ldr	r10, [r5, #508]
	str	r1, [fp, #-116]
	str	r10, [r4, #2916]
	add	r10, r5, #1216
	ldr	lr, [r5, #484]
	str	lr, [r4, #2936]
	ldr	lr, [r9, #2112]
	str	lr, [r4, #2940]
	ldr	lr, [r5, #520]
	str	lr, [r4, #2944]
	ldr	lr, [r5, #404]
	str	lr, [r4, #2928]
	bl	BsInit
	ldr	r2, [r4, #2912]
	ldr	r3, [fp, #-112]
	cmp	r2, #0
	ldr	r2, [r4, #2932]
	bne	.L2089
	cmp	r2, #0
	beq	.L2098
.L2089:
	movw	r1, #11495
	stmia	sp, {r2, r7}
	mov	r0, r10
	sub	r2, fp, #96
	movt	r1, 4
	add	r1, r6, r1
	bl	Vp9_SetupPastIndependence
	ldr	r3, .L2101
	add	r0, r9, #2112
	mov	r2, #16
	add	r0, r0, #8
	mov	r1, #0
	ldr	r3, [r3, #48]
	blx	r3
.L2090:
	ldr	r3, [fp, #-96]
	movw	r0, #2087
	movw	r1, #11495
	mov	r2, r0
	movt	r1, 4
	mla	r3, r0, r3, r6
	add	r0, r5, #1216
	add	r1, r3, r1
	bl	memcpy
	sub	r0, fp, #84
	bl	Vp9_Cabac_ReaderInit
	ldr	ip, [fp, #-108]
	ldr	r1, [r4, #2940]
	mov	r2, r7
	ldr	r0, [r4, #2944]
	sub	lr, fp, #88
	ldr	r3, [r4, #2916]
	sub	r7, fp, #92
	str	ip, [sp, #12]
	ldr	ip, [fp, #-104]
	str	r1, [sp, #4]
	mov	r1, r10
	str	r0, [sp]
	sub	r0, fp, #84
	str	ip, [sp, #8]
	str	lr, [sp, #20]
	str	r7, [sp, #16]
	bl	Vp9_ReadCompressedHeader
	cmp	r0, #0
	bne	.L2099
	ldr	r3, [fp, #-88]
	add	r7, r9, #4608
	ldr	r2, [fp, #-92]
	str	r3, [r9, #2288]
	str	r3, [r4, #2920]
	ldr	r3, [r9, #2400]
	str	r2, [r9, #2292]
	cmp	r3, #0
	addeq	r7, r7, #12
	bne	.L2100
.L2094:
	ldr	lr, [r4, #2916]
	movw	r0, #1037
	ldr	r3, [r5, #408]
	mov	r2, r7
	mov	r1, r10
	movt	r0, 4
	str	lr, [sp]
	add	r0, r6, r0
	bl	Vp9_ProbBurstConvert
	ldr	r3, [r9, #2064]
	ldr	r2, [fp, #-116]
	sub	r1, fp, #84
	mov	r0, r6
	rsb	r8, r3, r8
	add	r9, r2, r3
	str	r8, [fp, #-68]
	str	r9, [fp, #-84]
	bl	Vp9_DecodeTilesCtrl
	mov	r0, #0
.L2092:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2098:
	ldr	r1, [r4, #2916]
	cmp	r1, #0
	beq	.L2090
	b	.L2089
.L2100:
	add	r7, r7, #12
	add	r0, r9, #2064
	add	r1, r0, #328
	add	r0, r0, #248
	mov	r2, r7
	bl	Vp9_Vfmw_LoopFilterFrameInit
	b	.L2094
.L2099:
	ldr	r1, .L2101+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2092
.L2102:
	.align	2
.L2101:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC31
	.fnend
	.size	Vp9_DecodeTiles, .-Vp9_DecodeTiles
	.align	2
	.global	Vp9_CoefCountRestore
	.type	Vp9_CoefCountRestore, %function
Vp9_CoefCountRestore:
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
	add	r7, r1, #1152
	add	r3, r1, #3456
	add	r7, r7, #4
	add	r3, r3, #4
	str	r0, [fp, #-52]
	str	r2, [fp, #-48]
	str	r3, [fp, #-56]
.L2104:
	ldr	r9, [fp, #-48]
	sub	r8, r7, #1152
	ldr	r4, [fp, #-52]
.L2110:
	add	r6, r4, #576
	mov	r5, r8
	mov	ip, r9
.L2108:
	add	lr, ip, #24
	mov	r0, r5
	mov	r1, r4
.L2105:
	ldr	r3, [r1]
	add	r0, r0, #16
	add	r1, r1, #16
	bic	r2, r3, #-67108864
	str	r2, [ip], #4
	ldr	r2, [r1, #-12]
	mov	r3, r3, lsr #26
	cmp	lr, ip
	ubfx	r10, r2, #0, #20
	mov	r2, r2, lsr #20
	orr	r3, r3, r10, asl #6
	str	r3, [r0, #-20]
	ldr	r3, [r1, #-8]
	ubfx	r10, r3, #0, #14
	mov	r3, r3, lsr #14
	orr	r2, r2, r10, asl #12
	str	r2, [r0, #-16]
	ldr	r2, [r1, #-4]
	uxtb	r10, r2
	mov	r2, r2, lsr #8
	str	r2, [r0, #-8]
	orr	r3, r3, r10, asl #18
	str	r3, [r0, #-12]
	bne	.L2105
	add	r4, r4, #96
	add	r5, r5, #96
	cmp	r6, r4
	mov	ip, lr
	bne	.L2108
	add	r8, r8, #576
	add	r9, r9, #144
	cmp	r7, r8
	mov	r4, r6
	bne	.L2110
	ldr	r3, [fp, #-52]
	add	r7, r7, #1152
	add	r3, r3, #1152
	str	r3, [fp, #-52]
	ldr	r3, [fp, #-56]
	cmp	r7, r3
	ldr	r3, [fp, #-48]
	add	r3, r3, #288
	str	r3, [fp, #-48]
	bne	.L2104
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	.fnend
	.size	Vp9_CoefCountRestore, .-Vp9_CoefCountRestore
	.align	2
	.global	Vp9_RestoreCounts
	.type	Vp9_RestoreCounts, %function
Vp9_RestoreCounts:
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
	mov	r5, r2
	mov	r4, r1
	add	r2, r2, #9216
	mov	r6, r0
	add	r2, r2, #12
	mov	r1, r5
	mov	r0, r4
	bl	Vp9_CoefCountRestore
	add	r2, r5, #9792
	add	r2, r2, #12
	add	r1, r5, #2304
	add	r0, r4, #2304
	bl	Vp9_CoefCountRestore
	add	r2, r5, #10368
	add	r2, r2, #12
	add	r1, r5, #4608
	add	r0, r4, #4608
	bl	Vp9_CoefCountRestore
	add	r2, r5, #10944
	add	r0, r4, #6912
	add	r2, r2, #12
	add	r1, r5, #6912
	bl	Vp9_CoefCountRestore
	add	r0, r6, #290816
	ldr	r3, [r0, #2912]
	cmp	r3, #0
	bne	.L2112
	ldr	r3, [r0, #2916]
	cmp	r3, #0
	bne	.L2112
	add	r2, r5, #8192
	add	r0, r4, #10368
	add	r6, r4, #10176
	add	r9, r4, #9600
	add	r10, r4, #9216
	add	r9, r9, #32
	add	r7, r4, #10048
	str	r10, [r2, #1032]
	str	r9, [r2, #1028]
	add	r10, r4, #9472
	add	r9, r4, #10432
	str	r10, [r2, #1024]
	add	r10, r4, #10496
	str	r10, [fp, #-52]
	mov	r5, r6
	mov	r1, r0
	mov	r3, r0
	add	r7, r7, #32
	add	r6, r6, #16
	add	r0, r0, #16
	add	r3, r3, #56
	add	ip, r4, #10304
	str	r7, [r2, #3344]
	add	r7, r9, #24
	str	r6, [r2, #3348]
	add	r9, r9, #48
	add	r6, r4, #10560
	str	r0, [r2, #3372]
	str	r3, [r2, #3364]
	add	r0, r4, #10752
	add	r3, r4, #10816
	str	r7, [r2, #3376]
	str	r9, [r2, #3380]
	add	r9, r4, #10880
	ldr	r7, [fp, #-52]
	add	ip, ip, #40
	add	r8, r4, #9984
	add	lr, r4, #10240
	str	ip, [r2, #3360]
	add	ip, r4, #10688
	add	r8, r8, #48
	add	r5, r5, #48
	add	lr, lr, #24
	add	r1, r1, #32
	str	r8, [r2, #3340]
	add	r7, r7, #60
	mov	r8, r10
	str	r5, [r2, #3352]
	add	r10, r10, #8
	mov	r5, r6
	str	lr, [r2, #3356]
	add	r5, r5, #48
	mov	lr, r6
	str	r1, [r2, #3368]
	str	r10, [r2, #3416]
	mov	r1, r0
	mov	r10, r3
	add	r1, r1, #56
	str	r8, [r2, #3384]
	add	r6, r6, #40
	add	r8, r8, #16
	add	lr, lr, #56
	str	r8, [r2, #3388]
	add	ip, ip, #8
	mov	r8, r9
	add	r0, r0, #24
	str	r1, [r2, #3432]
	add	r3, r3, #24
	add	r1, r10, #40
	str	r9, [r2, #3440]
	add	r10, r10, #56
	add	r9, r9, #8
	add	r8, r8, #16
	str	r7, [r2, #3420]
	str	r6, [r2, #3392]
	str	r5, [r2, #3424]
	str	lr, [r2, #3396]
	str	ip, [r2, #3428]
	str	r0, [r2, #3400]
	str	r3, [r2, #3404]
	str	r1, [r2, #3436]
	str	r10, [r2, #3408]
	str	r9, [r2, #3412]
	str	r8, [r2, #3444]
.L2112:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	.fnend
	.size	Vp9_RestoreCounts, .-Vp9_RestoreCounts
	.align	2
	.global	VP9DEC_VDMPostProc
	.type	VP9DEC_VDMPostProc, %function
VP9DEC_VDMPostProc:
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
	add	r6, r0, #290816
	add	r2, r0, #270336
	mov	r4, r1
	mov	r7, r0
	ldr	r3, [r6, #2856]
	ldr	r1, [r2, #488]
	cmp	r3, #0
	ldr	r3, [r2, #480]
	str	r2, [fp, #-48]
	str	r1, [fp, #-56]
	str	r3, [fp, #-52]
	beq	.L2115
	ldr	r2, [r6, #2896]
	ldr	r3, [r6, #2892]
	cmp	r2, r3
	beq	.L2115
.L2116:
	add	r8, r7, #266240
	ldr	r0, [r6, #2948]
	ldr	r1, [r8, #2048]
	bl	FSP_GetFsImagePtr
	subs	r5, r0, #0
	beq	.L2160
	cmp	r4, #0
	blt	.L2119
	cmp	r4, #100
	movlt	r2, r4
	movge	r2, #100
	str	r2, [r5, #160]
	ldr	r3, [r7]
	ldr	r3, [r3]
	cmp	r2, r3
	bhi	.L2161
.L2120:
	mov	r0, r7
	bl	VP9_SetImgFormat
	ldr	r3, [r7]
	ldr	r3, [r3, #592]
	cmp	r3, #1
	beq	.L2162
.L2121:
	mov	r3, #0
	str	r3, [r5, #80]
	str	r3, [r5, #84]
.L2124:
	movw	r4, #6264
	movw	r9, #6228
	movw	r5, #6344
	movw	r10, #6300
	movt	r4, 4
	movt	r9, 4
	movt	r5, 4
	movt	r10, 4
	add	r4, r7, r4
	add	r9, r7, r9
	add	r5, r7, r5
	add	r10, r7, r10
	b	.L2127
.L2125:
	clz	r3, r3
	cmp	r0, #0
	mov	r3, r3, lsr #5
	moveq	r3, #0
	cmp	r3, #0
	bne	.L2163
.L2126:
	cmp	r4, r10
	beq	.L2164
.L2127:
	ldr	r3, [r9, #4]!
	ldr	r0, [r4, #4]!
	adds	r2, r3, #0
	ldr	r1, [r5, #4]!
	movne	r2, #1
	cmp	r0, #0
	movne	r2, #0
	cmp	r2, #0
	beq	.L2125
	mov	r2, #1
	ldr	r0, [r6, #2948]
	bl	FSP_SetRef
	cmp	r4, r10
	bne	.L2127
.L2164:
	ldr	r4, .L2171
	add	r0, r8, #2064
	add	r1, r0, #72
	mov	r2, #36
	add	r0, r0, #108
	ldr	r3, [r4, #52]
	blx	r3
	ldr	r3, [r8, #2000]
	cmp	r3, #2
	beq	.L2165
.L2128:
	ldr	r3, [fp, #-48]
	ldr	r3, [r3, #424]
	cmp	r3, #0
	bne	.L2130
.L2129:
	mvn	r3, #0
	ldr	r1, [r8, #2048]
	str	r3, [r8, #2052]
	mov	r2, #0
	ldr	r0, [r6, #2948]
	bl	FSP_SetDisplay
	ldr	r1, [r8, #2052]
.L2131:
	cmn	r1, #1
	beq	.L2132
	ldr	r0, [r6, #2948]
	bl	FSP_GetFsImagePtr
	subs	r5, r0, #0
	beq	.L2166
	mov	r2, #1
	ldr	r1, [r8, #2052]
	ldr	r0, [r6, #2948]
	bl	FSP_SetDisplay
	ldr	r3, [fp, #-48]
	ldr	r0, [r6, #2948]
	mov	r2, r7
	add	r3, r3, #832
	str	r5, [sp]
	mov	r1, #17
	bl	InsertImgToVoQueue
	cmp	r0, #1
	mov	r3, r0
	bne	.L2167
.L2132:
	ldr	r3, [fp, #-48]
	ldr	r5, [r3, #428]
	cmp	r5, #0
	beq	.L2134
.L2139:
	mov	r5, #0
.L2159:
	mov	r0, r5
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2163:
	ldr	r0, [r6, #2948]
	bl	FSP_SetRef
	b	.L2126
.L2130:
	ldr	r1, [r8, #2048]
	str	r1, [r8, #2052]
	b	.L2131
.L2134:
	ldr	r0, [r8, #1844]
	bl	MEM_Phy2Vir
	subs	r3, r0, #0
	beq	.L2168
	ldr	r2, [r6, #2912]
	cmp	r2, #0
	ldr	r2, [r6, #2932]
	bne	.L2169
	cmp	r2, #0
	movne	r9, r5
	bne	.L2138
	ldr	r2, [r6, #2916]
	cmp	r2, #0
	ldr	r2, [fp, #-56]
	movne	r9, #0
	moveq	r9, r2
.L2137:
	ldr	r2, [r6, #2936]
	cmp	r2, #0
	beq	.L2170
.L2138:
	ldr	r3, [fp, #-52]
	cmp	r3, #0
	beq	.L2139
	movw	r2, #2087
	ldr	r3, [fp, #-48]
	mla	r7, r2, r9, r7
	movw	r0, #11495
	add	r1, r3, #1216
	movt	r0, 4
	add	r0, r7, r0
	bl	memcpy
	mov	r0, r5
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2115:
	mov	r1, r7
	mov	r0, #17
	bl	ReleasePacket
	mov	r3, #0
	str	r3, [r6, #2856]
	b	.L2116
.L2119:
	mov	r3, #0
	str	r3, [r5, #160]
	b	.L2120
.L2165:
	ldr	r3, [r8, #2056]
	cmp	r3, #0
	bne	.L2129
	b	.L2128
.L2162:
	ldr	r2, [fp, #-48]
	ldr	r2, [r2, #428]
	cmp	r2, #0
	bne	.L2121
	ldr	r2, .L2171+4
	ldr	r2, [r2]
	add	r2, r2, #4096
	ldr	r0, [r2, #84]
	ldr	r1, [r2, #88]
	str	r3, [r5, #80]
	cmp	r1, #0
	moveq	r1, #1
	bl	__aeabi_uidiv
	str	r0, [r5, #84]
	b	.L2124
.L2167:
	add	r4, r5, #544
	add	r7, r5, #528
	ldr	r1, [r5, #528]
	mov	r5, r3
	ldr	r0, [r6, #2948]
	bl	FreeUsdByDec
	mov	r2, #0
	mov	r3, #0
	strd	r2, [r7]
	ldr	r1, [r4, #-8]
	ldr	r0, [r6, #2948]
	bl	FreeUsdByDec
	mov	r2, #0
	mov	r3, #0
	strd	r2, [r4, #-8]
	ldr	r1, [r8, #2052]
	ldr	r0, [r6, #2948]
	bl	FSP_SetDisplay
	ldr	r1, .L2171+8
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, r5
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2169:
	cmp	r2, #0
	mov	r9, r5
	bne	.L2138
	b	.L2137
.L2170:
	ldr	r2, [fp, #-56]
	movw	lr, #2087
	ldr	ip, [r4, #136]
	mov	r0, r3
	ldr	r1, [r8, #1844]
	movw	r4, #11495
	mla	lr, lr, r2, r7
	mov	r2, #11264
	str	r3, [fp, #-56]
	movw	r10, #19844
	movt	r4, 4
	movt	r10, 4
	add	r4, lr, r4
	blx	ip
	ldr	r3, [fp, #-56]
	add	r10, r7, r10
	mov	r0, r7
	mov	r2, r10
	mov	r1, r3
	bl	Vp9_RestoreCounts
	ldr	r3, [fp, #-48]
	ldr	r0, [r6, #2916]
	mov	r2, r10
	ldr	lr, [r6, #2928]
	add	r8, r3, #1216
	ldr	r3, [r6, #2924]
	mov	r1, r4
	stmib	sp, {r0, lr}
	mov	r0, r8
	str	r3, [sp]
	mov	r3, r9
	bl	Vp9_AdaptResidualProbs
	ldr	r3, [r6, #2912]
	cmp	r3, #0
	bne	.L2138
	ldr	r3, [r6, #2916]
	cmp	r3, #0
	bne	.L2138
	ldr	lr, [r6, #2920]
	mov	r2, r10
	ldr	r3, [r6, #2944]
	mov	r1, r4
	mov	r0, r8
	str	lr, [sp]
	bl	Vp9_AdaptModeProbs
	ldr	r3, [r6, #2940]
	mov	r2, r10
	mov	r1, r4
	mov	r0, r8
	bl	Vp9_AdaptMvProbs
	b	.L2138
.L2161:
	ldr	r1, .L2171+12
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r5, #0
	b	.L2159
.L2166:
	movw	r2, #2369
	ldr	r1, .L2171+16
	bl	dprint_vfmw
	mvn	r5, #0
	b	.L2159
.L2160:
	ldr	r1, .L2171+20
	mvn	r5, #0
	bl	dprint_vfmw
	b	.L2159
.L2168:
	ldr	r1, .L2171+24
	mvn	r5, #0
	bl	dprint_vfmw
	b	.L2159
.L2172:
	.align	2
.L2171:
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_HwMem
	.word	.LC35
	.word	.LC33
	.word	.LC34
	.word	.LC32
	.word	.LC36
	.fnend
	.size	VP9DEC_VDMPostProc, .-VP9DEC_VDMPostProc
	.align	2
	.global	VP9DEC_DecodeFame
	.type	VP9DEC_DecodeFame, %function
VP9DEC_DecodeFame:
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
	add	r4, r0, #290816
	add	r5, r0, #270336
	add	r6, r0, #266240
	mov	r9, r0
	ldr	r3, [r4, #2852]
	add	r7, r5, #1184
	str	r1, [fp, #-48]
	add	r8, r6, #2064
	cmp	r3, #0
	beq	.L2174
	ldr	r3, [r5, #400]
	cmp	r3, #0
	blt	.L2174
.L2175:
	str	r3, [r4, #2848]
	mov	r1, r8
	mov	r0, r7
	bl	Read_UnCompressed_Header
	str	r0, [r6, #2064]
	ldr	r3, [r5, #428]
	cmp	r3, #0
	bne	.L2180
	ldr	r2, [r6, #1996]
	cmp	r2, #7
	ble	.L2240
.L2180:
	ldr	r3, [r5, #452]
	sub	r2, r3, #128
	cmp	r2, #3968
	bls	.L2241
.L2181:
	ldr	r3, .L2256
	ldr	ip, [r3]
	cmp	ip, #0
	mvneq	r0, #0
	beq	.L2234
	mov	r3, #0
	ldr	r0, [r4, #2948]
	mov	r2, r3
	mov	r1, #102
	blx	ip
	mvn	r0, #0
.L2234:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2174:
	ldr	r3, [r6, #2136]
	cmp	r3, #0
	beq	.L2176
	movw	r2, #6232
	mov	r3, #1
	movt	r2, 4
	add	r2, r9, r2
.L2177:
	ldr	r1, [r2, #4]!
	cmp	r1, #0
	beq	.L2176
	add	r3, r3, #1
	cmp	r3, #9
	bne	.L2177
	mvn	r3, #0
	str	r3, [r5, #400]
.L2209:
	ldr	r1, .L2256+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2234
.L2241:
	ldr	r2, [r5, #456]
	sub	r1, r2, #128
	cmp	r1, #3968
	bhi	.L2181
	adds	r1, r3, #63
	str	r3, [r6, #2076]
	addmi	r1, r3, #126
	adds	r3, r2, #63
	addmi	r3, r2, #126
	str	r2, [r6, #2080]
	mov	r0, r9
	mov	r2, r1, asr #6
	mov	r3, r3, asr #6
	str	r2, [r6, #2068]
	str	r3, [r6, #2072]
	bl	VP9_GetRefNum
	str	r0, [r4, #2824]
	ldr	r0, [r4, #2948]
	ldr	r2, [r6, #2080]
	ldr	r1, [r6, #2076]
	bl	VCTRL_GetFsSize
	mov	r1, r0
	str	r0, [r4, #2812]
	ldr	r0, [r4, #2948]
	bl	FSP_GetPhyFsNum
	ldr	r3, .L2256+8
	ldr	r1, [r4, #2948]
	ldr	r2, [r3, r1, asl #2]
	str	r0, [r4, #2816]
	ldr	r3, [r2, #1432]
	str	r3, [r4, #2820]
	ldr	r0, [r6, #2076]
	cmp	r0, #1920
	bls	.L2242
.L2183:
	ldr	lr, [r4, #2828]
	ldr	r2, [r4, #2824]
	ldr	r10, [r4, #2832]
	cmp	r2, lr
	movge	lr, r2
	cmp	r0, r10
	add	r3, lr, r3
	str	r3, [r4, #2820]
	beq	.L2243
.L2184:
	str	r2, [r4, #2828]
.L2186:
	mov	r0, r1
	mov	r1, #0
	bl	FSP_GetPhyFsNum
	ldr	r2, [r4, #2816]
	cmp	r0, r2
	ble	.L2187
	rsb	r3, r2, r0
	cmp	r3, #0
	ble	.L2187
	str	r5, [fp, #-52]
	mov	r10, #0
	mov	r5, r4
	mov	r4, r0
	b	.L2189
.L2188:
	ldr	r2, [r5, #2816]
	rsb	r1, r2, r4
	cmp	r1, r10
	ble	.L2244
.L2189:
	ldr	r1, [r5, #2812]
	add	r10, r10, #1
	ldr	r0, [r5, #2948]
	bl	FSP_RelsePhyFs
	cmp	r0, #0
	beq	.L2188
	mov	r4, r5
	ldr	r5, [fp, #-52]
	ldr	r2, [r4, #2816]
.L2187:
	ldr	r3, [r4, #2820]
	cmp	r3, r2
	bge	.L2193
	rsb	r2, r3, r2
	cmp	r2, #0
	ble	.L2193
	mov	r10, #0
	b	.L2194
.L2245:
	ldr	r3, [r4, #2816]
	ldr	r2, [r4, #2820]
	rsb	r3, r2, r3
	cmp	r3, r10
	ble	.L2193
.L2194:
	mov	r1, #0
	ldr	r0, [r4, #2948]
	bl	FSP_RelsePhyFs
	add	r10, r10, #1
	cmp	r0, #0
	beq	.L2245
.L2193:
	mov	r1, #0
	ldr	r0, [r4, #2948]
	bl	FSP_GetPhyFsNum
	ldr	r1, [r4, #2812]
	mov	r10, r0
	ldr	r0, [r4, #2948]
	bl	FSP_GetPhyFsNum
	ldr	ip, [r4, #2824]
	ldr	r3, [r4, #2820]
	add	r1, ip, #2
	add	r2, r0, #1
	rsb	lr, r10, r0
	cmp	r2, r1
	add	r3, lr, r3
	str	r0, [r4, #2816]
	movge	r2, r1
	cmp	r3, r2
	str	r0, [sp, #4]
	mov	r0, #2
	movge	r1, r3
	movlt	r1, r2
	str	r10, [sp]
	str	r1, [r4, #2820]
	ldr	r3, [r6, #2080]
	ldr	r2, [r6, #2076]
	str	r1, [sp, #12]
	str	ip, [sp, #8]
	ldr	r1, .L2256+12
	bl	dprint_vfmw
	ldr	r3, [r6, #2004]
	cmn	r3, #1
	beq	.L2191
	ldr	r2, [r4, #2832]
	ldr	r3, [r6, #2076]
	cmp	r2, r3
	beq	.L2246
.L2191:
	mov	r0, r9
	bl	VP9_ArrangeVHBMem
	ldr	r10, [r6, #2004]
	cmn	r10, #1
	beq	.L2247
.L2195:
	ldr	r3, [r5, #428]
	ldr	r0, [r4, #2948]
	cmp	r3, #0
	ldreq	r3, [r6, #2076]
	streq	r3, [r4, #2832]
	ldreq	r3, [r6, #2080]
	streq	r3, [r4, #2836]
	bl	FSP_IsNewFsAvalible
	cmp	r0, #1
	bne	.L2248
	mov	r0, r7
	bl	BsBitsToNextByte
	subs	r1, r0, #0
	bne	.L2249
.L2198:
	ldr	r3, [r5, #428]
	cmp	r3, #0
	beq	.L2250
.L2199:
	mov	r0, r9
	bl	VP9_GetImageBuffer
	cmp	r0, #0
	bne	.L2251
	ldr	r3, [r4, #2848]
	mov	r0, r9
	ldr	r2, [r6, #2048]
	add	r3, r6, r3, lsl #2
	str	r2, [r3, #2252]
	bl	VP9_Set_DecParam
	cmp	r0, #0
	bne	.L2252
	ldr	r3, [r5, #428]
	cmp	r3, #1
	beq	.L2253
	ldr	r3, [r6, #2076]
	str	r3, [r4, #2840]
	ldr	r3, [r6, #2080]
	str	r3, [r4, #2844]
.L2204:
	mov	r0, r8
	bl	swap_frame_buffers
	ldr	r2, [r4, #2900]
	ldr	r0, [r4, #2904]
	cmp	r2, r0
	bcs	.L2205
	ldrb	r3, [r2]
	cmp	r3, #0
	bne	.L2205
	add	r3, r2, #1
	b	.L2206
.L2254:
	ldrb	r1, [r2]
	cmp	r1, #0
	bne	.L2205
.L2206:
	cmp	r3, r0
	str	r3, [r4, #2900]
	mov	r2, r3
	add	r3, r3, #1
	bne	.L2254
.L2205:
	ldr	r3, [r4, #2856]
	cmp	r3, #1
	beq	.L2255
.L2207:
	mov	r6, #0
	str	r6, [r4, #2852]
	ldr	r0, [r5, #428]
	cmp	r0, r6
	bne	.L2208
	ldr	r3, [r5, #424]
	str	r3, [r5, #436]
	b	.L2234
.L2176:
	add	r2, r6, r3, lsl #2
	cmp	r3, #0
	mov	r1, #1
	str	r1, [r2, #2136]
	str	r3, [r5, #400]
	bge	.L2175
	b	.L2209
.L2242:
	ldr	lr, [r6, #2080]
	cmp	lr, #1088
	bhi	.L2183
	ldr	r2, [r2, #44]
	cmp	r2, #24
	addne	r3, r3, #4
	b	.L2183
.L2250:
	ldr	r1, [r5, #1208]
	mov	r0, r9
	ldr	r2, [r5, #1200]
	adds	r3, r1, #7
	addmi	r3, r1, #14
	ldr	r1, [fp, #-48]
	mov	r3, r3, asr #3
	add	r1, r1, r3
	rsb	r2, r3, r2
	bl	Vp9_DecodeTiles
	b	.L2199
.L2249:
	mov	r0, r7
	bl	BsGet
	b	.L2198
.L2253:
	ldr	r1, [r5, #400]
	add	r6, r6, #2128
	add	r6, r6, #8
	ldr	r3, [r5, #432]
	ldr	r2, [r6, r1, asl #2]
	cmp	r2, #0
	subgt	r2, r2, #1
	strgt	r2, [r6, r1, asl #2]
	str	r3, [r5, #400]
	ldr	r2, [r6, r3, asl #2]
	add	r2, r2, #1
	str	r2, [r6, r3, asl #2]
	b	.L2204
.L2246:
	ldr	r2, [r4, #2836]
	ldr	r3, [r6, #2080]
	cmp	r2, r3
	bne	.L2191
	ldr	r2, [r4, #2816]
	ldr	r3, [r4, #2820]
	cmp	r2, r3
	bge	.L2195
	b	.L2191
.L2240:
	ldr	r1, .L2256+16
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2234
.L2243:
	ldr	r3, [r6, #2080]
	ldr	r0, [r4, #2836]
	cmp	r0, r3
	streq	lr, [r4, #2828]
	bne	.L2184
	b	.L2186
.L2208:
	mov	r0, r9
	mov	r3, r6
	mov	r2, r6
	mov	r1, r6
	bl	VP9DEC_VDMPostProc
	mov	r0, r6
	b	.L2234
.L2255:
	ldr	r1, [r4, #2896]
	movw	r3, #7882
	movt	r3, 1
	add	r3, r1, r3
	add	r1, r1, #1
	add	r3, r9, r3, lsl #2
	ldr	r3, [r3, #4]
	str	r1, [r4, #2896]
	add	r2, r2, r3
	str	r2, [r4, #2900]
	b	.L2207
.L2244:
	mov	r4, r5
	ldr	r5, [fp, #-52]
	b	.L2187
.L2248:
	movw	r3, #3720
	ldr	r2, .L2256+20
	ldr	r1, .L2256+24
	mov	r0, #23
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2234
.L2251:
	ldr	r1, .L2256+28
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2234
.L2252:
	ldr	r1, .L2256+32
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2234
.L2247:
	ldr	r1, .L2256+36
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r10
	b	.L2234
.L2257:
	.align	2
.L2256:
	.word	g_event_report
	.word	.LC37
	.word	s_pstVfmwChan
	.word	.LC39
	.word	.LC38
	.word	.LANCHOR0+872
	.word	.LC41
	.word	.LC42
	.word	.LC43
	.word	.LC40
	.fnend
	.size	VP9DEC_DecodeFame, .-VP9DEC_DecodeFame
	.align	2
	.global	VP9DEC_DecodePacket
	.type	VP9DEC_DecodePacket, %function
VP9DEC_DecodePacket:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #44
	sub	sp, sp, #44
	push	{lr}
	bl	__gnu_mcount_nc
	cmp	r1, #0
	cmpne	r0, #0
	mov	r3, #0
	mov	r5, r0
	str	r3, [fp, #-72]
	beq	.L2269
	ldr	r0, [r1]
	add	r8, r5, #266240
	add	r4, r5, #290816
	str	r0, [r8, #1988]
	ldr	r3, [r1, #8]
	str	r3, [r8, #1992]
	ldr	r1, [r1, #12]
	str	r1, [r8, #1996]
	ldr	r6, [r4, #2856]
	cmp	r6, #0
	beq	.L2278
	ldr	r2, [r4, #2908]
	ldr	r7, [r4, #2900]
	b	.L2263
.L2280:
	ldrb	ip, [r7]
	and	r3, ip, #7
	and	r0, ip, #224
	ubfx	r1, ip, #3, #2
	add	r3, r3, #1
	cmp	r0, #192
	mla	r3, r1, r3, r3
	bne	.L2266
	add	r1, r3, #2
	cmp	r1, r2
	bls	.L2279
.L2263:
	cmp	r2, #0
	bne	.L2280
.L2266:
	cmp	r6, #1
	beq	.L2281
.L2268:
	add	r0, r5, #270336
	mov	r1, r7
	add	r0, r0, #1184
	bl	BsInit
	mov	r0, r5
	mov	r1, r7
	bl	VP9DEC_DecodeFame
	subs	r5, r0, #0
	moveq	r0, r5
	beq	.L2259
	mov	r3, #1
	ldr	r1, .L2283
	str	r3, [r4, #2852]
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r5
.L2259:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L2279:
	add	r3, r7, r3
	ldrb	r3, [r3, #1]
	cmp	r3, ip
	bne	.L2263
	ldr	r3, [r4, #2904]
	add	r7, r7, r1
	rsb	r2, r1, r2
	str	r7, [r4, #2900]
	cmp	r7, r3
	str	r2, [r4, #2908]
	bcc	.L2263
	b	.L2266
.L2278:
	sub	r3, fp, #72
	sub	r2, fp, #68
	bl	Vp9_ParseSuperFrameIndex
	ldr	r3, [fp, #-72]
	cmp	r3, #0
	bne	.L2282
.L2261:
	ldr	r7, [r8, #1988]
	ldr	r6, [r4, #2856]
	str	r7, [r4, #2900]
	ldr	r2, [r8, #1996]
	add	r3, r7, r2
	str	r3, [r4, #2904]
	str	r2, [r4, #2908]
	b	.L2263
.L2281:
	ldr	r2, [r4, #2896]
	movw	r3, #7882
	movt	r3, 1
	add	r3, r2, r3
	add	r3, r5, r3, lsl #2
	ldr	r2, [r3, #4]
	b	.L2268
.L2282:
	ldr	r2, .L2283+4
	movw	r0, #31532
	str	r3, [r4, #2892]
	mov	ip, #1
	str	r6, [r4, #2896]
	sub	r1, fp, #68
	ldr	r3, [r2, #52]
	movt	r0, 4
	mov	r2, #32
	add	r0, r5, r0
	str	ip, [r4, #2856]
	blx	r3
	b	.L2261
.L2269:
	mvn	r0, #0
	b	.L2259
.L2284:
	.align	2
.L2283:
	.word	.LC44
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VP9DEC_DecodePacket, .-VP9DEC_DecodePacket
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	count_to_update_factor, %object
	.size	count_to_update_factor, 21
count_to_update_factor:
	.byte	0
	.byte	6
	.byte	12
	.byte	19
	.byte	25
	.byte	32
	.byte	38
	.byte	44
	.byte	51
	.byte	57
	.byte	64
	.byte	70
	.byte	76
	.byte	83
	.byte	89
	.byte	96
	.byte	102
	.byte	108
	.byte	115
	.byte	121
	.byte	-128
	.space	3
	.type	vp9_cabac_norm, %object
	.size	vp9_cabac_norm, 256
vp9_cabac_norm:
	.byte	0
	.byte	7
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
	.byte	4
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
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
	.byte	0
	.byte	0
	.type	vp9_inv_map_table, %object
	.size	vp9_inv_map_table, 254
vp9_inv_map_table:
	.byte	6
	.byte	19
	.byte	32
	.byte	45
	.byte	58
	.byte	71
	.byte	84
	.byte	97
	.byte	110
	.byte	123
	.byte	-120
	.byte	-107
	.byte	-94
	.byte	-81
	.byte	-68
	.byte	-55
	.byte	-42
	.byte	-29
	.byte	-16
	.byte	-3
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.byte	16
	.byte	17
	.byte	18
	.byte	20
	.byte	21
	.byte	22
	.byte	23
	.byte	24
	.byte	25
	.byte	26
	.byte	27
	.byte	28
	.byte	29
	.byte	30
	.byte	31
	.byte	33
	.byte	34
	.byte	35
	.byte	36
	.byte	37
	.byte	38
	.byte	39
	.byte	40
	.byte	41
	.byte	42
	.byte	43
	.byte	44
	.byte	46
	.byte	47
	.byte	48
	.byte	49
	.byte	50
	.byte	51
	.byte	52
	.byte	53
	.byte	54
	.byte	55
	.byte	56
	.byte	57
	.byte	59
	.byte	60
	.byte	61
	.byte	62
	.byte	63
	.byte	64
	.byte	65
	.byte	66
	.byte	67
	.byte	68
	.byte	69
	.byte	70
	.byte	72
	.byte	73
	.byte	74
	.byte	75
	.byte	76
	.byte	77
	.byte	78
	.byte	79
	.byte	80
	.byte	81
	.byte	82
	.byte	83
	.byte	85
	.byte	86
	.byte	87
	.byte	88
	.byte	89
	.byte	90
	.byte	91
	.byte	92
	.byte	93
	.byte	94
	.byte	95
	.byte	96
	.byte	98
	.byte	99
	.byte	100
	.byte	101
	.byte	102
	.byte	103
	.byte	104
	.byte	105
	.byte	106
	.byte	107
	.byte	108
	.byte	109
	.byte	111
	.byte	112
	.byte	113
	.byte	114
	.byte	115
	.byte	116
	.byte	117
	.byte	118
	.byte	119
	.byte	120
	.byte	121
	.byte	122
	.byte	124
	.byte	125
	.byte	126
	.byte	127
	.byte	-128
	.byte	-127
	.byte	-126
	.byte	-125
	.byte	-124
	.byte	-123
	.byte	-122
	.byte	-121
	.byte	-119
	.byte	-118
	.byte	-117
	.byte	-116
	.byte	-115
	.byte	-114
	.byte	-113
	.byte	-112
	.byte	-111
	.byte	-110
	.byte	-109
	.byte	-108
	.byte	-106
	.byte	-105
	.byte	-104
	.byte	-103
	.byte	-102
	.byte	-101
	.byte	-100
	.byte	-99
	.byte	-98
	.byte	-97
	.byte	-96
	.byte	-95
	.byte	-93
	.byte	-92
	.byte	-91
	.byte	-90
	.byte	-89
	.byte	-88
	.byte	-87
	.byte	-86
	.byte	-85
	.byte	-84
	.byte	-83
	.byte	-82
	.byte	-80
	.byte	-79
	.byte	-78
	.byte	-77
	.byte	-76
	.byte	-75
	.byte	-74
	.byte	-73
	.byte	-72
	.byte	-71
	.byte	-70
	.byte	-69
	.byte	-67
	.byte	-66
	.byte	-65
	.byte	-64
	.byte	-63
	.byte	-62
	.byte	-61
	.byte	-60
	.byte	-59
	.byte	-58
	.byte	-57
	.byte	-56
	.byte	-54
	.byte	-53
	.byte	-52
	.byte	-51
	.byte	-50
	.byte	-49
	.byte	-48
	.byte	-47
	.byte	-46
	.byte	-45
	.byte	-44
	.byte	-43
	.byte	-41
	.byte	-40
	.byte	-39
	.byte	-38
	.byte	-37
	.byte	-36
	.byte	-35
	.byte	-34
	.byte	-33
	.byte	-32
	.byte	-31
	.byte	-30
	.byte	-28
	.byte	-27
	.byte	-26
	.byte	-25
	.byte	-24
	.byte	-23
	.byte	-22
	.byte	-21
	.byte	-20
	.byte	-19
	.byte	-18
	.byte	-17
	.byte	-15
	.byte	-14
	.byte	-13
	.byte	-12
	.byte	-11
	.byte	-10
	.byte	-9
	.byte	-8
	.byte	-7
	.byte	-6
	.byte	-5
	.byte	-4
	.space	2
	.type	vp9_inter_mode_tree, %object
	.size	vp9_inter_mode_tree, 6
vp9_inter_mode_tree:
	.byte	-2
	.byte	2
	.byte	0
	.byte	4
	.byte	-1
	.byte	-3
	.space	2
	.type	vp9_intra_mode_tree, %object
	.size	vp9_intra_mode_tree, 18
vp9_intra_mode_tree:
	.byte	0
	.byte	2
	.byte	-9
	.byte	4
	.byte	-1
	.byte	6
	.byte	8
	.byte	12
	.byte	-2
	.byte	10
	.byte	-4
	.byte	-5
	.byte	-3
	.byte	14
	.byte	-8
	.byte	16
	.byte	-6
	.byte	-7
	.space	2
	.type	vp9_partition_tree, %object
	.size	vp9_partition_tree, 6
vp9_partition_tree:
	.byte	0
	.byte	2
	.byte	-1
	.byte	4
	.byte	-2
	.byte	-3
	.space	2
	.type	vp9_switchable_interp_tree, %object
	.size	vp9_switchable_interp_tree, 4
vp9_switchable_interp_tree:
	.byte	0
	.byte	2
	.byte	-1
	.byte	-2
.LC0:
	.byte	0
	.byte	2
	.byte	-1
	.byte	4
	.byte	-2
	.byte	-3
	.space	2
.LC1:
	.byte	0
	.byte	2
	.byte	-1
	.byte	4
	.byte	6
	.byte	8
	.byte	-2
	.byte	-3
	.byte	10
	.byte	12
	.byte	-4
	.byte	-5
	.byte	-6
	.byte	14
	.byte	16
	.byte	18
	.byte	-7
	.byte	-8
	.byte	-9
	.byte	-10
	.type	__func__.15174, %object
	.size	__func__.15174, 19
__func__.15174:
	.ascii	"VP9_GetImageBuffer\000"
	.space	1
	.type	seg_feature_data_max, %object
	.size	seg_feature_data_max, 16
seg_feature_data_max:
	.word	255
	.word	63
	.word	3
	.word	0
	.type	seg_feature_data_signed, %object
	.size	seg_feature_data_signed, 16
seg_feature_data_signed:
	.word	1
	.word	1
	.word	0
	.word	0
	.type	__func__.15355, %object
	.size	__func__.15355, 16
__func__.15355:
	.ascii	"VP9_Set_Segdata\000"
.LC2:
	.word	1
	.word	0
	.word	2
	.word	3
	.type	__FUNCTION__.15431, %object
	.size	__FUNCTION__.15431, 33
__FUNCTION__.15431:
	.ascii	"VP9_get_fixed_point_scale_factor\000"
	.space	3
	.type	__FUNCTION__.15460, %object
	.size	__FUNCTION__.15460, 35
__FUNCTION__.15460:
	.ascii	"Vp9_ReadBitDepthColorSpaceSampling\000"
	.space	1
	.type	__FUNCTION__.15491, %object
	.size	__FUNCTION__.15491, 25
__FUNCTION__.15491:
	.ascii	"Read_UnCompressed_Header\000"
	.space	3
	.type	vp9_default_tx_probs, %object
	.size	vp9_default_tx_probs, 12
vp9_default_tx_probs:
	.byte	3
	.byte	-120
	.byte	37
	.byte	5
	.byte	52
	.byte	13
	.byte	20
	.byte	-104
	.byte	15
	.byte	101
	.byte	100
	.byte	66
	.type	vp9_default_nmv_context, %object
	.size	vp9_default_nmv_context, 69
vp9_default_nmv_context:
	.byte	32
	.byte	64
	.byte	96
	.byte	-128
	.byte	-32
	.byte	-112
	.byte	-64
	.byte	-88
	.byte	-64
	.byte	-80
	.byte	-64
	.byte	-58
	.byte	-58
	.byte	-11
	.byte	-40
	.byte	-120
	.byte	-116
	.byte	-108
	.byte	-96
	.byte	-80
	.byte	-64
	.byte	-32
	.byte	-22
	.byte	-22
	.byte	-16
	.byte	-128
	.byte	-128
	.byte	64
	.byte	96
	.byte	112
	.byte	64
	.byte	64
	.byte	96
	.byte	64
	.byte	-96
	.byte	-128
	.byte	-128
	.byte	-40
	.byte	-128
	.byte	-80
	.byte	-96
	.byte	-80
	.byte	-80
	.byte	-64
	.byte	-58
	.byte	-58
	.byte	-48
	.byte	-48
	.byte	-120
	.byte	-116
	.byte	-108
	.byte	-96
	.byte	-80
	.byte	-64
	.byte	-32
	.byte	-22
	.byte	-22
	.byte	-16
	.byte	-128
	.byte	-128
	.byte	64
	.byte	96
	.byte	112
	.byte	64
	.byte	64
	.byte	96
	.byte	64
	.byte	-96
	.byte	-128
	.space	3
	.type	__func__.15574, %object
	.size	__func__.15574, 18
__func__.15574:
	.ascii	"VP9DEC_DecodeFame\000"
	.data
	.align	2
.LANCHOR1 = . + 0
	.type	vp9_default_coef_probs_4x4, %object
	.size	vp9_default_coef_probs_4x4, 432
vp9_default_coef_probs_4x4:
	.byte	-61
	.byte	29
	.byte	-73
	.byte	84
	.byte	49
	.byte	-120
	.byte	8
	.byte	42
	.byte	71
	.space	9
	.byte	31
	.byte	107
	.byte	-87
	.byte	35
	.byte	99
	.byte	-97
	.byte	17
	.byte	82
	.byte	-116
	.byte	8
	.byte	66
	.byte	114
	.byte	2
	.byte	44
	.byte	76
	.byte	1
	.byte	19
	.byte	32
	.byte	40
	.byte	-124
	.byte	-55
	.byte	29
	.byte	114
	.byte	-69
	.byte	13
	.byte	91
	.byte	-99
	.byte	7
	.byte	75
	.byte	127
	.byte	3
	.byte	58
	.byte	95
	.byte	1
	.byte	28
	.byte	47
	.byte	69
	.byte	-114
	.byte	-35
	.byte	42
	.byte	122
	.byte	-55
	.byte	15
	.byte	91
	.byte	-97
	.byte	6
	.byte	67
	.byte	121
	.byte	1
	.byte	42
	.byte	77
	.byte	1
	.byte	17
	.byte	31
	.byte	102
	.byte	-108
	.byte	-28
	.byte	67
	.byte	117
	.byte	-52
	.byte	17
	.byte	82
	.byte	-102
	.byte	6
	.byte	59
	.byte	114
	.byte	2
	.byte	39
	.byte	75
	.byte	1
	.byte	15
	.byte	29
	.byte	-100
	.byte	57
	.byte	-23
	.byte	119
	.byte	57
	.byte	-44
	.byte	58
	.byte	48
	.byte	-93
	.byte	29
	.byte	40
	.byte	124
	.byte	12
	.byte	30
	.byte	81
	.byte	3
	.byte	12
	.byte	31
	.byte	-65
	.byte	107
	.byte	-30
	.byte	124
	.byte	117
	.byte	-52
	.byte	25
	.byte	99
	.byte	-101
	.space	9
	.byte	29
	.byte	-108
	.byte	-46
	.byte	37
	.byte	126
	.byte	-62
	.byte	8
	.byte	93
	.byte	-99
	.byte	2
	.byte	68
	.byte	118
	.byte	1
	.byte	39
	.byte	69
	.byte	1
	.byte	17
	.byte	33
	.byte	41
	.byte	-105
	.byte	-43
	.byte	27
	.byte	123
	.byte	-63
	.byte	3
	.byte	82
	.byte	-112
	.byte	1
	.byte	58
	.byte	105
	.byte	1
	.byte	32
	.byte	60
	.byte	1
	.byte	13
	.byte	26
	.byte	59
	.byte	-97
	.byte	-36
	.byte	23
	.byte	126
	.byte	-58
	.byte	4
	.byte	88
	.byte	-105
	.byte	1
	.byte	66
	.byte	114
	.byte	1
	.byte	38
	.byte	71
	.byte	1
	.byte	18
	.byte	34
	.byte	114
	.byte	-120
	.byte	-24
	.byte	51
	.byte	114
	.byte	-49
	.byte	11
	.byte	83
	.byte	-101
	.byte	3
	.byte	56
	.byte	105
	.byte	1
	.byte	33
	.byte	65
	.byte	1
	.byte	17
	.byte	34
	.byte	-107
	.byte	65
	.byte	-22
	.byte	121
	.byte	57
	.byte	-41
	.byte	61
	.byte	49
	.byte	-90
	.byte	28
	.byte	36
	.byte	114
	.byte	12
	.byte	25
	.byte	76
	.byte	3
	.byte	16
	.byte	42
	.byte	-42
	.byte	49
	.byte	-36
	.byte	-124
	.byte	63
	.byte	-68
	.byte	42
	.byte	65
	.byte	-119
	.space	9
	.byte	85
	.byte	-119
	.byte	-35
	.byte	104
	.byte	-125
	.byte	-40
	.byte	49
	.byte	111
	.byte	-64
	.byte	21
	.byte	87
	.byte	-101
	.byte	2
	.byte	49
	.byte	87
	.byte	1
	.byte	16
	.byte	28
	.byte	89
	.byte	-93
	.byte	-26
	.byte	90
	.byte	-119
	.byte	-36
	.byte	29
	.byte	100
	.byte	-73
	.byte	10
	.byte	70
	.byte	-121
	.byte	2
	.byte	42
	.byte	81
	.byte	1
	.byte	17
	.byte	33
	.byte	108
	.byte	-89
	.byte	-19
	.byte	55
	.byte	-123
	.byte	-34
	.byte	15
	.byte	97
	.byte	-77
	.byte	4
	.byte	72
	.byte	-121
	.byte	1
	.byte	45
	.byte	85
	.byte	1
	.byte	19
	.byte	38
	.byte	124
	.byte	-110
	.byte	-16
	.byte	66
	.byte	124
	.byte	-32
	.byte	17
	.byte	88
	.byte	-81
	.byte	4
	.byte	58
	.byte	122
	.byte	1
	.byte	36
	.byte	75
	.byte	1
	.byte	18
	.byte	37
	.byte	-115
	.byte	79
	.byte	-15
	.byte	126
	.byte	70
	.byte	-29
	.byte	66
	.byte	58
	.byte	-74
	.byte	30
	.byte	44
	.byte	-120
	.byte	12
	.byte	34
	.byte	96
	.byte	2
	.byte	20
	.byte	47
	.byte	-27
	.byte	99
	.byte	-7
	.byte	-113
	.byte	111
	.byte	-21
	.byte	46
	.byte	109
	.byte	-64
	.space	9
	.byte	82
	.byte	-98
	.byte	-20
	.byte	94
	.byte	-110
	.byte	-32
	.byte	25
	.byte	117
	.byte	-65
	.byte	9
	.byte	87
	.byte	-107
	.byte	3
	.byte	56
	.byte	99
	.byte	1
	.byte	33
	.byte	57
	.byte	83
	.byte	-89
	.byte	-19
	.byte	68
	.byte	-111
	.byte	-34
	.byte	10
	.byte	103
	.byte	-79
	.byte	2
	.byte	72
	.byte	-125
	.byte	1
	.byte	41
	.byte	79
	.byte	1
	.byte	20
	.byte	39
	.byte	99
	.byte	-89
	.byte	-17
	.byte	47
	.byte	-115
	.byte	-32
	.byte	10
	.byte	104
	.byte	-78
	.byte	2
	.byte	73
	.byte	-123
	.byte	1
	.byte	44
	.byte	85
	.byte	1
	.byte	22
	.byte	47
	.byte	127
	.byte	-111
	.byte	-13
	.byte	71
	.byte	-127
	.byte	-28
	.byte	17
	.byte	93
	.byte	-79
	.byte	3
	.byte	61
	.byte	124
	.byte	1
	.byte	41
	.byte	84
	.byte	1
	.byte	21
	.byte	52
	.byte	-99
	.byte	78
	.byte	-12
	.byte	-116
	.byte	72
	.byte	-25
	.byte	69
	.byte	58
	.byte	-72
	.byte	31
	.byte	44
	.byte	-119
	.byte	14
	.byte	38
	.byte	105
	.byte	8
	.byte	23
	.byte	61
	.type	vp9_default_coef_probs_8x8, %object
	.size	vp9_default_coef_probs_8x8, 432
vp9_default_coef_probs_8x8:
	.byte	125
	.byte	34
	.byte	-69
	.byte	52
	.byte	41
	.byte	-123
	.byte	6
	.byte	31
	.byte	56
	.space	9
	.byte	37
	.byte	109
	.byte	-103
	.byte	51
	.byte	102
	.byte	-109
	.byte	23
	.byte	87
	.byte	-128
	.byte	8
	.byte	67
	.byte	101
	.byte	1
	.byte	41
	.byte	63
	.byte	1
	.byte	19
	.byte	29
	.byte	31
	.byte	-102
	.byte	-71
	.byte	17
	.byte	127
	.byte	-81
	.byte	6
	.byte	96
	.byte	-111
	.byte	2
	.byte	73
	.byte	114
	.byte	1
	.byte	51
	.byte	82
	.byte	1
	.byte	28
	.byte	45
	.byte	23
	.byte	-93
	.byte	-56
	.byte	10
	.byte	-125
	.byte	-71
	.byte	2
	.byte	93
	.byte	-108
	.byte	1
	.byte	67
	.byte	111
	.byte	1
	.byte	41
	.byte	69
	.byte	1
	.byte	14
	.byte	24
	.byte	29
	.byte	-80
	.byte	-39
	.byte	12
	.byte	-111
	.byte	-55
	.byte	3
	.byte	101
	.byte	-100
	.byte	1
	.byte	69
	.byte	111
	.byte	1
	.byte	39
	.byte	63
	.byte	1
	.byte	14
	.byte	23
	.byte	57
	.byte	-64
	.byte	-23
	.byte	25
	.byte	-102
	.byte	-41
	.byte	6
	.byte	109
	.byte	-89
	.byte	3
	.byte	78
	.byte	118
	.byte	1
	.byte	48
	.byte	69
	.byte	1
	.byte	21
	.byte	29
	.byte	-54
	.byte	105
	.byte	-11
	.byte	108
	.byte	106
	.byte	-40
	.byte	18
	.byte	90
	.byte	-112
	.space	9
	.byte	33
	.byte	-84
	.byte	-37
	.byte	64
	.byte	-107
	.byte	-50
	.byte	14
	.byte	117
	.byte	-79
	.byte	5
	.byte	90
	.byte	-115
	.byte	2
	.byte	61
	.byte	95
	.byte	1
	.byte	37
	.byte	57
	.byte	33
	.byte	-77
	.byte	-36
	.byte	11
	.byte	-116
	.byte	-58
	.byte	1
	.byte	89
	.byte	-108
	.byte	1
	.byte	60
	.byte	104
	.byte	1
	.byte	33
	.byte	57
	.byte	1
	.byte	12
	.byte	21
	.byte	30
	.byte	-75
	.byte	-35
	.byte	8
	.byte	-115
	.byte	-58
	.byte	1
	.byte	87
	.byte	-111
	.byte	1
	.byte	58
	.byte	100
	.byte	1
	.byte	31
	.byte	55
	.byte	1
	.byte	12
	.byte	20
	.byte	32
	.byte	-70
	.byte	-32
	.byte	7
	.byte	-114
	.byte	-58
	.byte	1
	.byte	86
	.byte	-113
	.byte	1
	.byte	58
	.byte	100
	.byte	1
	.byte	31
	.byte	55
	.byte	1
	.byte	12
	.byte	22
	.byte	57
	.byte	-64
	.byte	-29
	.byte	20
	.byte	-113
	.byte	-52
	.byte	3
	.byte	96
	.byte	-102
	.byte	1
	.byte	68
	.byte	112
	.byte	1
	.byte	42
	.byte	69
	.byte	1
	.byte	19
	.byte	32
	.byte	-44
	.byte	35
	.byte	-41
	.byte	113
	.byte	47
	.byte	-87
	.byte	29
	.byte	48
	.byte	105
	.space	9
	.byte	74
	.byte	-127
	.byte	-53
	.byte	106
	.byte	120
	.byte	-53
	.byte	49
	.byte	107
	.byte	-78
	.byte	19
	.byte	84
	.byte	-112
	.byte	4
	.byte	50
	.byte	84
	.byte	1
	.byte	15
	.byte	25
	.byte	71
	.byte	-84
	.byte	-39
	.byte	44
	.byte	-115
	.byte	-47
	.byte	15
	.byte	102
	.byte	-83
	.byte	6
	.byte	76
	.byte	-123
	.byte	2
	.byte	51
	.byte	89
	.byte	1
	.byte	24
	.byte	42
	.byte	64
	.byte	-71
	.byte	-25
	.byte	31
	.byte	-108
	.byte	-40
	.byte	8
	.byte	103
	.byte	-81
	.byte	3
	.byte	74
	.byte	-125
	.byte	1
	.byte	46
	.byte	81
	.byte	1
	.byte	18
	.byte	30
	.byte	65
	.byte	-60
	.byte	-21
	.byte	25
	.byte	-99
	.byte	-35
	.byte	5
	.byte	105
	.byte	-82
	.byte	1
	.byte	67
	.byte	120
	.byte	1
	.byte	38
	.byte	69
	.byte	1
	.byte	15
	.byte	30
	.byte	65
	.byte	-52
	.byte	-18
	.byte	30
	.byte	-100
	.byte	-32
	.byte	7
	.byte	107
	.byte	-79
	.byte	2
	.byte	70
	.byte	124
	.byte	1
	.byte	42
	.byte	73
	.byte	1
	.byte	18
	.byte	34
	.byte	-31
	.byte	86
	.byte	-5
	.byte	-112
	.byte	104
	.byte	-21
	.byte	42
	.byte	99
	.byte	-75
	.space	9
	.byte	85
	.byte	-81
	.byte	-17
	.byte	112
	.byte	-91
	.byte	-27
	.byte	29
	.byte	-120
	.byte	-56
	.byte	12
	.byte	103
	.byte	-94
	.byte	6
	.byte	77
	.byte	123
	.byte	2
	.byte	53
	.byte	84
	.byte	75
	.byte	-73
	.byte	-17
	.byte	30
	.byte	-101
	.byte	-35
	.byte	3
	.byte	106
	.byte	-85
	.byte	1
	.byte	74
	.byte	-128
	.byte	1
	.byte	44
	.byte	76
	.byte	1
	.byte	17
	.byte	28
	.byte	73
	.byte	-71
	.byte	-16
	.byte	27
	.byte	-97
	.byte	-34
	.byte	2
	.byte	107
	.byte	-84
	.byte	1
	.byte	75
	.byte	127
	.byte	1
	.byte	42
	.byte	73
	.byte	1
	.byte	17
	.byte	29
	.byte	62
	.byte	-66
	.byte	-18
	.byte	21
	.byte	-97
	.byte	-34
	.byte	2
	.byte	107
	.byte	-84
	.byte	1
	.byte	72
	.byte	122
	.byte	1
	.byte	40
	.byte	71
	.byte	1
	.byte	18
	.byte	32
	.byte	61
	.byte	-57
	.byte	-16
	.byte	27
	.byte	-95
	.byte	-30
	.byte	4
	.byte	113
	.byte	-76
	.byte	1
	.byte	76
	.byte	-127
	.byte	1
	.byte	46
	.byte	80
	.byte	1
	.byte	23
	.byte	41
	.type	vp9_default_coef_probs_16x16, %object
	.size	vp9_default_coef_probs_16x16, 432
vp9_default_coef_probs_16x16:
	.byte	7
	.byte	27
	.byte	-103
	.byte	5
	.byte	30
	.byte	95
	.byte	1
	.byte	16
	.byte	30
	.space	9
	.byte	50
	.byte	75
	.byte	127
	.byte	57
	.byte	75
	.byte	124
	.byte	27
	.byte	67
	.byte	108
	.byte	10
	.byte	54
	.byte	86
	.byte	1
	.byte	33
	.byte	52
	.byte	1
	.byte	12
	.byte	18
	.byte	43
	.byte	125
	.byte	-105
	.byte	26
	.byte	108
	.byte	-108
	.byte	7
	.byte	83
	.byte	122
	.byte	2
	.byte	59
	.byte	89
	.byte	1
	.byte	38
	.byte	60
	.byte	1
	.byte	17
	.byte	27
	.byte	23
	.byte	-112
	.byte	-93
	.byte	13
	.byte	112
	.byte	-102
	.byte	2
	.byte	75
	.byte	117
	.byte	1
	.byte	50
	.byte	81
	.byte	1
	.byte	31
	.byte	51
	.byte	1
	.byte	14
	.byte	23
	.byte	18
	.byte	-94
	.byte	-71
	.byte	6
	.byte	123
	.byte	-85
	.byte	1
	.byte	78
	.byte	125
	.byte	1
	.byte	51
	.byte	86
	.byte	1
	.byte	31
	.byte	54
	.byte	1
	.byte	14
	.byte	23
	.byte	15
	.byte	-57
	.byte	-29
	.byte	3
	.byte	-106
	.byte	-52
	.byte	1
	.byte	91
	.byte	-110
	.byte	1
	.byte	55
	.byte	95
	.byte	1
	.byte	30
	.byte	53
	.byte	1
	.byte	11
	.byte	20
	.byte	19
	.byte	55
	.byte	-16
	.byte	19
	.byte	59
	.byte	-60
	.byte	3
	.byte	52
	.byte	105
	.space	9
	.byte	41
	.byte	-90
	.byte	-49
	.byte	104
	.byte	-103
	.byte	-57
	.byte	31
	.byte	123
	.byte	-75
	.byte	14
	.byte	101
	.byte	-104
	.byte	5
	.byte	72
	.byte	106
	.byte	1
	.byte	36
	.byte	52
	.byte	35
	.byte	-80
	.byte	-45
	.byte	12
	.byte	-125
	.byte	-66
	.byte	2
	.byte	88
	.byte	-112
	.byte	1
	.byte	60
	.byte	101
	.byte	1
	.byte	36
	.byte	60
	.byte	1
	.byte	16
	.byte	28
	.byte	28
	.byte	-73
	.byte	-43
	.byte	8
	.byte	-122
	.byte	-65
	.byte	1
	.byte	86
	.byte	-114
	.byte	1
	.byte	56
	.byte	96
	.byte	1
	.byte	30
	.byte	53
	.byte	1
	.byte	12
	.byte	20
	.byte	20
	.byte	-66
	.byte	-41
	.byte	4
	.byte	-121
	.byte	-64
	.byte	1
	.byte	84
	.byte	-117
	.byte	1
	.byte	53
	.byte	91
	.byte	1
	.byte	28
	.byte	49
	.byte	1
	.byte	11
	.byte	20
	.byte	13
	.byte	-60
	.byte	-40
	.byte	2
	.byte	-119
	.byte	-64
	.byte	1
	.byte	86
	.byte	-113
	.byte	1
	.byte	57
	.byte	99
	.byte	1
	.byte	32
	.byte	56
	.byte	1
	.byte	13
	.byte	24
	.byte	-45
	.byte	29
	.byte	-39
	.byte	96
	.byte	47
	.byte	-100
	.byte	22
	.byte	43
	.byte	87
	.space	9
	.byte	78
	.byte	120
	.byte	-63
	.byte	111
	.byte	116
	.byte	-70
	.byte	46
	.byte	102
	.byte	-92
	.byte	15
	.byte	80
	.byte	-128
	.byte	2
	.byte	49
	.byte	76
	.byte	1
	.byte	18
	.byte	28
	.byte	71
	.byte	-95
	.byte	-53
	.byte	42
	.byte	-124
	.byte	-64
	.byte	10
	.byte	98
	.byte	-106
	.byte	3
	.byte	69
	.byte	109
	.byte	1
	.byte	44
	.byte	70
	.byte	1
	.byte	18
	.byte	29
	.byte	57
	.byte	-70
	.byte	-45
	.byte	30
	.byte	-116
	.byte	-60
	.byte	4
	.byte	93
	.byte	-110
	.byte	1
	.byte	62
	.byte	102
	.byte	1
	.byte	38
	.byte	65
	.byte	1
	.byte	16
	.byte	27
	.byte	47
	.byte	-57
	.byte	-39
	.byte	14
	.byte	-111
	.byte	-60
	.byte	1
	.byte	88
	.byte	-114
	.byte	1
	.byte	57
	.byte	98
	.byte	1
	.byte	36
	.byte	62
	.byte	1
	.byte	15
	.byte	26
	.byte	26
	.byte	-37
	.byte	-27
	.byte	5
	.byte	-101
	.byte	-49
	.byte	1
	.byte	94
	.byte	-105
	.byte	1
	.byte	60
	.byte	104
	.byte	1
	.byte	36
	.byte	62
	.byte	1
	.byte	16
	.byte	28
	.byte	-23
	.byte	29
	.byte	-8
	.byte	-110
	.byte	47
	.byte	-36
	.byte	43
	.byte	52
	.byte	-116
	.space	9
	.byte	100
	.byte	-93
	.byte	-24
	.byte	-77
	.byte	-95
	.byte	-34
	.byte	63
	.byte	-114
	.byte	-52
	.byte	37
	.byte	113
	.byte	-82
	.byte	26
	.byte	89
	.byte	-119
	.byte	18
	.byte	68
	.byte	97
	.byte	85
	.byte	-75
	.byte	-26
	.byte	32
	.byte	-110
	.byte	-47
	.byte	7
	.byte	100
	.byte	-92
	.byte	3
	.byte	71
	.byte	121
	.byte	1
	.byte	45
	.byte	77
	.byte	1
	.byte	18
	.byte	30
	.byte	65
	.byte	-69
	.byte	-26
	.byte	20
	.byte	-108
	.byte	-49
	.byte	2
	.byte	97
	.byte	-97
	.byte	1
	.byte	68
	.byte	116
	.byte	1
	.byte	40
	.byte	70
	.byte	1
	.byte	14
	.byte	29
	.byte	40
	.byte	-62
	.byte	-29
	.byte	8
	.byte	-109
	.byte	-52
	.byte	1
	.byte	94
	.byte	-101
	.byte	1
	.byte	65
	.byte	112
	.byte	1
	.byte	39
	.byte	66
	.byte	1
	.byte	14
	.byte	26
	.byte	16
	.byte	-48
	.byte	-28
	.byte	3
	.byte	-105
	.byte	-49
	.byte	1
	.byte	98
	.byte	-96
	.byte	1
	.byte	67
	.byte	117
	.byte	1
	.byte	41
	.byte	74
	.byte	1
	.byte	17
	.byte	31
	.type	vp9_default_coef_probs_32x32, %object
	.size	vp9_default_coef_probs_32x32, 432
vp9_default_coef_probs_32x32:
	.byte	17
	.byte	38
	.byte	-116
	.byte	7
	.byte	34
	.byte	80
	.byte	1
	.byte	17
	.byte	29
	.space	9
	.byte	37
	.byte	75
	.byte	-128
	.byte	41
	.byte	76
	.byte	-128
	.byte	26
	.byte	66
	.byte	116
	.byte	12
	.byte	52
	.byte	94
	.byte	2
	.byte	32
	.byte	55
	.byte	1
	.byte	10
	.byte	16
	.byte	50
	.byte	127
	.byte	-102
	.byte	37
	.byte	109
	.byte	-104
	.byte	16
	.byte	82
	.byte	121
	.byte	5
	.byte	59
	.byte	85
	.byte	1
	.byte	35
	.byte	54
	.byte	1
	.byte	13
	.byte	20
	.byte	40
	.byte	-114
	.byte	-89
	.byte	17
	.byte	110
	.byte	-99
	.byte	2
	.byte	71
	.byte	112
	.byte	1
	.byte	44
	.byte	72
	.byte	1
	.byte	27
	.byte	45
	.byte	1
	.byte	11
	.byte	17
	.byte	30
	.byte	-81
	.byte	-68
	.byte	9
	.byte	124
	.byte	-87
	.byte	1
	.byte	74
	.byte	116
	.byte	1
	.byte	48
	.byte	78
	.byte	1
	.byte	30
	.byte	49
	.byte	1
	.byte	11
	.byte	18
	.byte	10
	.byte	-34
	.byte	-33
	.byte	2
	.byte	-106
	.byte	-62
	.byte	1
	.byte	83
	.byte	-128
	.byte	1
	.byte	48
	.byte	79
	.byte	1
	.byte	27
	.byte	45
	.byte	1
	.byte	11
	.byte	17
	.byte	36
	.byte	41
	.byte	-21
	.byte	29
	.byte	36
	.byte	-63
	.byte	10
	.byte	27
	.byte	111
	.space	9
	.byte	85
	.byte	-91
	.byte	-34
	.byte	-79
	.byte	-94
	.byte	-41
	.byte	110
	.byte	-121
	.byte	-61
	.byte	57
	.byte	113
	.byte	-88
	.byte	23
	.byte	83
	.byte	120
	.byte	10
	.byte	49
	.byte	61
	.byte	85
	.byte	-66
	.byte	-33
	.byte	36
	.byte	-117
	.byte	-56
	.byte	5
	.byte	90
	.byte	-110
	.byte	1
	.byte	60
	.byte	103
	.byte	1
	.byte	38
	.byte	65
	.byte	1
	.byte	18
	.byte	30
	.byte	72
	.byte	-54
	.byte	-33
	.byte	23
	.byte	-115
	.byte	-57
	.byte	2
	.byte	86
	.byte	-116
	.byte	1
	.byte	56
	.byte	97
	.byte	1
	.byte	36
	.byte	61
	.byte	1
	.byte	16
	.byte	27
	.byte	55
	.byte	-38
	.byte	-31
	.byte	13
	.byte	-111
	.byte	-56
	.byte	1
	.byte	86
	.byte	-115
	.byte	1
	.byte	57
	.byte	99
	.byte	1
	.byte	35
	.byte	61
	.byte	1
	.byte	13
	.byte	22
	.byte	15
	.byte	-21
	.byte	-44
	.byte	1
	.byte	-124
	.byte	-72
	.byte	1
	.byte	84
	.byte	-117
	.byte	1
	.byte	57
	.byte	97
	.byte	1
	.byte	34
	.byte	56
	.byte	1
	.byte	14
	.byte	23
	.byte	-75
	.byte	21
	.byte	-55
	.byte	61
	.byte	37
	.byte	123
	.byte	10
	.byte	38
	.byte	71
	.space	9
	.byte	47
	.byte	106
	.byte	-84
	.byte	95
	.byte	104
	.byte	-83
	.byte	42
	.byte	93
	.byte	-97
	.byte	18
	.byte	77
	.byte	-125
	.byte	4
	.byte	50
	.byte	81
	.byte	1
	.byte	17
	.byte	23
	.byte	62
	.byte	-109
	.byte	-57
	.byte	44
	.byte	-126
	.byte	-67
	.byte	28
	.byte	102
	.byte	-102
	.byte	18
	.byte	75
	.byte	115
	.byte	2
	.byte	44
	.byte	65
	.byte	1
	.byte	12
	.byte	19
	.byte	55
	.byte	-103
	.byte	-46
	.byte	24
	.byte	-126
	.byte	-62
	.byte	3
	.byte	93
	.byte	-110
	.byte	1
	.byte	61
	.byte	97
	.byte	1
	.byte	31
	.byte	50
	.byte	1
	.byte	10
	.byte	16
	.byte	49
	.byte	-70
	.byte	-33
	.byte	17
	.byte	-108
	.byte	-52
	.byte	1
	.byte	96
	.byte	-114
	.byte	1
	.byte	53
	.byte	83
	.byte	1
	.byte	26
	.byte	44
	.byte	1
	.byte	11
	.byte	17
	.byte	13
	.byte	-39
	.byte	-44
	.byte	2
	.byte	-120
	.byte	-76
	.byte	1
	.byte	78
	.byte	124
	.byte	1
	.byte	50
	.byte	83
	.byte	1
	.byte	29
	.byte	49
	.byte	1
	.byte	14
	.byte	23
	.byte	-59
	.byte	13
	.byte	-9
	.byte	82
	.byte	17
	.byte	-34
	.byte	25
	.byte	17
	.byte	-94
	.space	9
	.byte	126
	.byte	-70
	.byte	-9
	.byte	-22
	.byte	-65
	.byte	-13
	.byte	-80
	.byte	-79
	.byte	-22
	.byte	104
	.byte	-98
	.byte	-36
	.byte	66
	.byte	-128
	.byte	-70
	.byte	55
	.byte	90
	.byte	-119
	.byte	111
	.byte	-59
	.byte	-14
	.byte	46
	.byte	-98
	.byte	-37
	.byte	9
	.byte	104
	.byte	-85
	.byte	2
	.byte	65
	.byte	125
	.byte	1
	.byte	44
	.byte	80
	.byte	1
	.byte	17
	.byte	91
	.byte	104
	.byte	-48
	.byte	-11
	.byte	39
	.byte	-88
	.byte	-32
	.byte	3
	.byte	109
	.byte	-94
	.byte	1
	.byte	79
	.byte	124
	.byte	1
	.byte	50
	.byte	102
	.byte	1
	.byte	43
	.byte	102
	.byte	84
	.byte	-36
	.byte	-10
	.byte	31
	.byte	-79
	.byte	-25
	.byte	2
	.byte	115
	.byte	-76
	.byte	1
	.byte	79
	.byte	-122
	.byte	1
	.byte	55
	.byte	77
	.byte	1
	.byte	60
	.byte	79
	.byte	43
	.byte	-13
	.byte	-16
	.byte	8
	.byte	-76
	.byte	-39
	.byte	1
	.byte	115
	.byte	-90
	.byte	1
	.byte	84
	.byte	121
	.byte	1
	.byte	51
	.byte	67
	.byte	1
	.byte	16
	.byte	6
	.type	vp9_default_if_uv_probs, %object
	.size	vp9_default_if_uv_probs, 90
vp9_default_if_uv_probs:
	.byte	120
	.byte	7
	.byte	76
	.byte	-80
	.byte	-48
	.byte	126
	.byte	28
	.byte	54
	.byte	103
	.byte	48
	.byte	12
	.byte	-102
	.byte	-101
	.byte	-117
	.byte	90
	.byte	34
	.byte	117
	.byte	119
	.byte	67
	.byte	6
	.byte	25
	.byte	-52
	.byte	-13
	.byte	-98
	.byte	13
	.byte	21
	.byte	96
	.byte	97
	.byte	5
	.byte	44
	.byte	-125
	.byte	-80
	.byte	-117
	.byte	48
	.byte	68
	.byte	97
	.byte	83
	.byte	5
	.byte	42
	.byte	-100
	.byte	111
	.byte	-104
	.byte	26
	.byte	49
	.byte	-104
	.byte	80
	.byte	5
	.byte	58
	.byte	-78
	.byte	74
	.byte	83
	.byte	33
	.byte	62
	.byte	-111
	.byte	86
	.byte	5
	.byte	32
	.byte	-102
	.byte	-64
	.byte	-88
	.byte	14
	.byte	22
	.byte	-93
	.byte	85
	.byte	5
	.byte	32
	.byte	-100
	.byte	-40
	.byte	-108
	.byte	19
	.byte	29
	.byte	73
	.byte	77
	.byte	7
	.byte	64
	.byte	116
	.byte	-124
	.byte	122
	.byte	37
	.byte	126
	.byte	120
	.byte	101
	.byte	21
	.byte	107
	.byte	-75
	.byte	-64
	.byte	103
	.byte	19
	.byte	67
	.byte	125
	.space	2
	.type	vp9_default_if_y_probs, %object
	.size	vp9_default_if_y_probs, 36
vp9_default_if_y_probs:
	.byte	65
	.byte	32
	.byte	18
	.byte	-112
	.byte	-94
	.byte	-62
	.byte	41
	.byte	51
	.byte	98
	.byte	-124
	.byte	68
	.byte	18
	.byte	-91
	.byte	-39
	.byte	-60
	.byte	45
	.byte	40
	.byte	78
	.byte	-83
	.byte	80
	.byte	19
	.byte	-80
	.byte	-16
	.byte	-63
	.byte	64
	.byte	35
	.byte	46
	.byte	-35
	.byte	-121
	.byte	38
	.byte	-62
	.byte	-8
	.byte	121
	.byte	96
	.byte	85
	.byte	29
	.type	vp9_default_switchable_interp_prob, %object
	.size	vp9_default_switchable_interp_prob, 8
vp9_default_switchable_interp_prob:
	.byte	-21
	.byte	-94
	.byte	36
	.byte	-1
	.byte	34
	.byte	3
	.byte	-107
	.byte	-112
	.type	vp9_default_partition_probs, %object
	.size	vp9_default_partition_probs, 96
vp9_default_partition_probs:
	.byte	-98
	.byte	97
	.byte	94
	.byte	93
	.byte	24
	.byte	99
	.byte	85
	.byte	119
	.byte	44
	.byte	62
	.byte	59
	.byte	67
	.byte	-107
	.byte	53
	.byte	53
	.byte	94
	.byte	20
	.byte	48
	.byte	83
	.byte	53
	.byte	24
	.byte	52
	.byte	18
	.byte	18
	.byte	-106
	.byte	40
	.byte	39
	.byte	78
	.byte	12
	.byte	26
	.byte	67
	.byte	33
	.byte	11
	.byte	24
	.byte	7
	.byte	5
	.byte	-82
	.byte	35
	.byte	49
	.byte	68
	.byte	11
	.byte	27
	.byte	57
	.byte	15
	.byte	9
	.byte	12
	.byte	3
	.byte	3
	.byte	-57
	.byte	122
	.byte	-115
	.byte	-109
	.byte	63
	.byte	-97
	.byte	-108
	.byte	-123
	.byte	118
	.byte	121
	.byte	104
	.byte	114
	.byte	-82
	.byte	73
	.byte	87
	.byte	92
	.byte	41
	.byte	83
	.byte	82
	.byte	99
	.byte	50
	.byte	53
	.byte	39
	.byte	39
	.byte	-79
	.byte	58
	.byte	59
	.byte	68
	.byte	26
	.byte	63
	.byte	52
	.byte	79
	.byte	25
	.byte	17
	.byte	14
	.byte	12
	.byte	-34
	.byte	34
	.byte	30
	.byte	72
	.byte	16
	.byte	44
	.byte	58
	.byte	32
	.byte	12
	.byte	10
	.byte	7
	.byte	6
	.type	vp9_default_intra_inter_p, %object
	.size	vp9_default_intra_inter_p, 4
vp9_default_intra_inter_p:
	.byte	9
	.byte	102
	.byte	-69
	.byte	-31
	.type	vp9_default_comp_inter_p, %object
	.size	vp9_default_comp_inter_p, 5
vp9_default_comp_inter_p:
	.byte	-17
	.byte	-73
	.byte	119
	.byte	96
	.byte	41
	.space	3
	.type	vp9_default_comp_ref_p, %object
	.size	vp9_default_comp_ref_p, 5
vp9_default_comp_ref_p:
	.byte	50
	.byte	126
	.byte	123
	.byte	-35
	.byte	-30
	.space	3
	.type	vp9_default_single_ref_p, %object
	.size	vp9_default_single_ref_p, 10
vp9_default_single_ref_p:
	.byte	33
	.byte	16
	.byte	77
	.byte	74
	.byte	-114
	.byte	-114
	.byte	-84
	.byte	-86
	.byte	-18
	.byte	-9
	.space	2
	.type	vp9_default_mbskip_probs, %object
	.size	vp9_default_mbskip_probs, 3
vp9_default_mbskip_probs:
	.byte	-64
	.byte	-128
	.byte	64
	.space	1
	.type	vp9_default_inter_mode_probs, %object
	.size	vp9_default_inter_mode_probs, 21
vp9_default_inter_mode_probs:
	.byte	2
	.byte	-83
	.byte	34
	.byte	7
	.byte	-111
	.byte	85
	.byte	7
	.byte	-90
	.byte	63
	.byte	7
	.byte	94
	.byte	66
	.byte	8
	.byte	64
	.byte	46
	.byte	17
	.byte	81
	.byte	31
	.byte	25
	.byte	29
	.byte	30
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC3:
	.ascii	"IN VP9DEC_Init\012\000"
.LC4:
	.ascii	"-1 == VCTRL_GetChanIDByCtx() Err! \012\000"
.LC5:
	.ascii	"data_sz == 0\012\000"
	.space	2
.LC6:
	.ascii	"get frame store fail!\012\000"
	.space	1
.LC7:
	.ascii	"line: %d, pImage is NULL!\012\000"
	.space	1
.LC8:
	.ascii	"get image buffer ok: LogicFsID = %d\012\000"
	.space	3
.LC9:
	.ascii	"decode %p, disp %p, tf %p\012\000"
	.space	1
.LC10:
	.ascii	"%s  idx=%d\012\000"
.LC11:
	.ascii	"FSP_GetLogicFs err\000"
	.space	1
.LC12:
	.ascii	"fsp.c,L%d: %s\012\000"
	.space	1
.LC13:
	.ascii	"Invalid frame sync code\012\000"
	.space	3
.LC14:
	.ascii	"ref_deltas\000"
	.space	1
.LC15:
	.ascii	"mode_deltas\000"
.LC16:
	.ascii	"delta_q\000"
.LC17:
	.ascii	"%s  %d ERR\012\000"
.LC18:
	.ascii	"%s:%d this_size:%d is invalid!\012\000"
.LC19:
	.ascii	"4:4:4 color is not supported in profile 0 or 2 (%s "
	.ascii	": %d)\012\000"
	.space	2
.LC20:
	.ascii	"Invalid frame marker\012\000"
	.space	2
.LC21:
	.ascii	"%s:%d w&h=%dx%d is invalid!\012\000"
	.space	3
.LC22:
	.ascii	"VP9_Set_DecParam but logic fs is null!\012\000"
.LC23:
	.ascii	"Decord FS is NULL!\012\000"
.LC24:
	.ascii	"VP9_Set_DecParam but cur logic pstDecodeFs is null!"
	.ascii	"\012\000"
	.space	3
.LC25:
	.ascii	"image size abnormal(%dx%d)\012\000"
.LC26:
	.ascii	"pic_width_in_pix:%d, pic_height_in_pix:%d\012\000"
	.space	1
.LC27:
	.ascii	"vp9 actual frame size(%dx%d) exeed max config(%dx%d"
	.ascii	")\012\000"
	.space	2
.LC28:
	.ascii	"partition fs memory fail!\012\000"
	.space	1
.LC29:
	.ascii	"FSP_ConfigInstance fail!\012\000"
	.space	2
.LC30:
	.ascii	"vp9 alloc frame only\012\000"
	.space	2
.LC31:
	.ascii	"ERROR:Vp9_ReadCompressedHeader\012\000"
.LC32:
	.ascii	"pCurImg is null\012\000"
	.space	3
.LC33:
	.ascii	"err_level(%d) over ref_thr(%d)\012\000"
.LC34:
	.ascii	"line: %d pToQueImg is null\012\000"
.LC35:
	.ascii	"insert img to Voqueue failed!\012\000"
	.space	1
.LC36:
	.ascii	"pu8ProbCntVir == NULL\012\000"
	.space	1
.LC37:
	.ascii	"get_free_fb failed!\012\000"
	.space	3
.LC38:
	.ascii	"ERROR: pCtx->StreamParam.Length(%d) < 8\012\000"
	.space	3
.LC39:
	.ascii	"%dx%d, all=%d,cur=%d,ref=%d,ned=%d\012\000"
.LC40:
	.ascii	"ERROR: No Img buffer is allocated\012\000"
	.space	1
.LC41:
	.ascii	"%s %d, no fsp\012\000"
	.space	1
.LC42:
	.ascii	"VP9_GetImageBuffer From Queue err\012\000"
	.space	1
.LC43:
	.ascii	"ERROR: VP9_Set_DecParam\012\000"
	.space	3
.LC44:
	.ascii	"VP9_DecOneNal ERR\012\000"
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
