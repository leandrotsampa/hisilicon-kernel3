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
	.file	"aoe_aop.c"

	.text
	.align	2
	.type	AOPCalcSize, %function
AOPCalcSize:
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
	mov	r5, r0
	ldr	r1, [r1]
	ldr	r0, [r4, #4]
	bl	UTIL_CalcFrameSize
	ldr	r3, [r4, #8]
	movw	r1, #19923
	movt	r1, 4194
	mul	r3, r3, r5
	umull	r2, r3, r3, r1
	mov	r3, r3, lsr #6
	tst	r3, #3
	bicne	r3, r3, #3
	addne	r3, r3, #4
	mul	r0, r0, r3
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	AOPCalcSize, .-AOPCalcSize
	.align	2
	.global	AOP_Flush
	.type	AOP_Flush, %function
AOP_Flush:
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
	.size	AOP_Flush, .-AOP_Flush
	.align	2
	.global	AOPFlushChnBuf
	.type	AOPFlushChnBuf, %function
AOPFlushChnBuf:
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
	ldr	r0, [r0, #116]
	cmp	r0, #0
	ldmeqfd	sp, {fp, sp, pc}
	bl	RBUF_Flush
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	AOPFlushChnBuf, .-AOPFlushChnBuf
	.align	2
	.global	AOP_ProcDelayCompensation
	.type	AOP_ProcDelayCompensation, %function
AOP_ProcDelayCompensation:
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
	ldr	r3, .L29
	add	r2, r0, #8
	mov	ip, r1
	ldr	r4, [r3, r2, asl #2]
	cmp	r4, #0
	beq	.L13
	ldr	r2, [r4, #120]
	cmp	r2, #0
	beq	.L13
	ldr	r2, [r4, #136]
	cmp	r2, #1
	beq	.L28
.L13:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L28:
	ldr	r5, [r3, r0, asl #2]
	sub	r1, fp, #64
	ldr	r3, [r5, #4]
	orr	r3, r3, #1048576
	str	r3, [r5, #4]
	ldr	r0, [r4, #116]
	ldr	r6, [ip, #32]
	bl	RBUF_QueryInfo
	ldr	r0, [r4, #132]
	cmp	r0, #0
	bgt	.L27
	ldr	r0, [r4, #116]
	cmp	r0, #0
	beq	.L17
	bl	RBUF_Flush
.L17:
	mov	r0, r6
.L27:
	add	r1, r4, #48
	bl	AOPCalcSize
	ldr	r3, [fp, #-36]
	mov	r1, #0
	cmp	r0, r3
	movcc	r2, r0
	movcs	r2, r3
	ldr	r0, [r4, #116]
	bl	RBUF_WriteData
	ldr	r3, [r5, #100]
	add	r3, r3, #1
	str	r3, [r5, #100]
	mov	r3, #0
	str	r3, [r4, #136]
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L30:
	.align	2
.L29:
	.word	.LANCHOR0
	.fnend
	.size	AOP_ProcDelayCompensation, .-AOP_ProcDelayCompensation
	.align	2
	.global	AOP_CheckIsCast
	.type	AOP_CheckIsCast, %function
AOP_CheckIsCast:
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
	ldr	r3, .L34
	ldr	r3, [r3, r0, asl #2]
	ldr	r2, [r3, #4]
	tst	r2, #524288
	ldrne	r0, [r3, #4]
	ubfxne	r0, r0, #18, #1
	moveq	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L35:
	.align	2
.L34:
	.word	.LANCHOR0
	.fnend
	.size	AOP_CheckIsCast, .-AOP_CheckIsCast
	.align	2
	.global	AOP_DestroyChn
	.type	AOP_DestroyChn, %function
AOP_DestroyChn:
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
	ldr	r3, .L43
	add	r2, r0, #8
	ldr	r4, [r3, r2, asl #2]
	cmp	r4, #0
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r3, [r4, #112]
	cmp	r3, #1
	beq	.L42
.L38:
	ldr	r0, [r4, #116]
	bl	RBUF_Destroy
	mov	r1, r4
	mov	r0, #26
	bl	HI_ADSP_FREE
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L42:
	bl	CAST_Destroy
	b	.L38
.L44:
	.align	2
.L43:
	.word	.LANCHOR0
	.fnend
	.size	AOP_DestroyChn, .-AOP_DestroyChn
	.align	2
	.global	AOP_Init
	.type	AOP_Init, %function
AOP_Init:
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
	ldr	r5, .L48
	mov	r8, r0
	mov	r4, r0
	add	r6, r5, #32
	mov	r7, #0
.L46:
	mov	r0, r4
	mov	r1, #128
	str	r4, [r5, #4]!
	bl	__memzero
	ldr	r3, [r4, #4]
	cmp	r5, r6
	add	r4, r4, #128
	orr	r3, r3, #4
	str	r3, [r4, #-124]
	str	r7, [r5, #32]
	bne	.L46
	mov	r0, r8
	bl	CAST_Init
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L49:
	.align	2
.L48:
	.word	.LANCHOR0-4
	.fnend
	.size	AOP_Init, .-AOP_Init
	.align	2
	.global	AOP_DeInit
	.type	AOP_DeInit, %function
AOP_DeInit:
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
	ldr	r5, .L53
	mov	r4, #0
	mov	r6, r4
.L51:
	mov	r0, r4
	add	r4, r4, #1
	bl	AOP_DestroyChn
	cmp	r4, #8
	str	r6, [r5, #4]!
	bne	.L51
	mov	r0, r4
	bl	CAST_DeInit
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L54:
	.align	2
.L53:
	.word	.LANCHOR0+28
	.fnend
	.size	AOP_DeInit, .-AOP_DeInit
	.align	2
	.global	AOP_Process
	.type	AOP_Process, %function
AOP_Process:
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
	ldr	r6, .L104
	mov	r5, #0
	mov	r9, r5
	sub	r7, r6, #32
	b	.L78
.L72:
	add	r5, r5, #1
	cmp	r5, #8
	beq	.L101
.L78:
	ldr	r4, [r7, #4]!
	ldr	r8, [r6, #4]!
	ldr	r10, [r4, #4]
	ubfx	r10, r10, #2, #1
	cmp	r10, #0
	bne	.L70
	ldr	r3, [r4, #4]
	ands	r3, r3, #3
	beq	.L58
	cmp	r3, #1
	beq	.L59
	ldr	r3, [r4, #4]
	mov	r2, #4
	bfi	r3, r2, #3, #4
	str	r3, [r4, #4]
	ldr	r3, [r4, #4]
	orr	r3, r3, r2
	str	r3, [r4, #4]
.L70:
	cmp	r8, #0
	beq	.L72
	ldr	r3, [r8, #120]
	cmp	r3, #1
	bne	.L72
	ldr	r4, [r6]
	ldr	r8, [r7]
	cmp	r4, #0
	beq	.L72
	str	r9, [r4, #20]
	add	r5, r5, #1
	ldr	r3, [r8, #12]
	ldr	r1, [r4, #48]
	ldr	r0, [r4, #52]
	uxtb	r3, r3
	str	r3, [r4, #24]
	ldr	r3, [r8, #12]
	ubfx	r3, r3, #8, #8
	str	r3, [r4, #28]
	ldr	r3, [r8, #12]
	tst	r3, #524288
	ldr	r3, [r8, #12]
	ubfx	r3, r3, #16, #3
	rsbne	r3, r3, #0
	str	r3, [r4, #32]
	str	r3, [r4, #36]
	ldr	r3, [r8, #12]
	tst	r3, #1073741824
	ldr	r3, [r8, #12]
	ubfx	r3, r3, #24, #6
	rsbne	r3, r3, #0
	str	r3, [r4, #40]
	ldr	r3, [r8, #12]
	mov	r3, r3, lsr #31
	str	r3, [r4, #44]
	ldr	r3, [r8, #4]
	ubfx	r3, r3, #8, #1
	str	r3, [r4, #104]
	ldr	r3, [r8, #4]
	ubfx	r3, r3, #10, #1
	str	r3, [r4, #108]
	ldr	r10, [r8]
	ubfx	r10, r10, #11, #9
	str	r10, [r4, #100]
	bl	UTIL_CalcFrameSize
	ldr	r2, [r4, #56]
	mov	r1, r0
	mov	r0, r10
	bl	UTIL_LatencyMs2ByteSize
	add	r1, r4, #68
	str	r0, [r4, #96]
	ldr	r0, [r4, #116]
	bl	RBUF_UpdateAttr
	ldr	r3, [r8, #4]
	ldr	r2, [r4, #128]
	ubfx	r3, r3, #21, #9
	str	r3, [r4, #124]
	cmp	r3, r2
	strne	r3, [r4, #128]
	rsbne	r2, r2, r3
	strne	r2, [r4, #132]
	movne	r3, #1
	strne	r3, [r4, #136]
	cmp	r5, #8
	bne	.L78
.L101:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L59:
	mov	r0, r5
	bl	AOP_DestroyChn
	str	r10, [r6]
	ldr	r2, [r7]
.L67:
	ldr	r3, [r2, #4]
	ubfx	r3, r3, #2, #1
	cmp	r3, #0
	bne	.L70
	ldr	r1, [r2, #4]
	bfi	r1, r3, #3, #4
	str	r1, [r2, #4]
	ldr	r3, [r2, #4]
	orr	r3, r3, #4
	str	r3, [r2, #4]
	b	.L70
.L58:
	str	r3, [fp, #-116]
	sub	r0, fp, #100
	ldr	r1, [r4]
	and	r1, r1, #3
	bl	AOE_REG_ReadBitDepth
	cmp	r0, #0
	bne	.L63
	ldr	r1, [r4]
	sub	r0, fp, #96
	ubfx	r1, r1, #2, #2
	bl	AOE_REG_ReadChannel
	cmp	r0, #0
	bne	.L63
	ldr	r1, [r4]
	sub	r0, fp, #92
	ubfx	r1, r1, #4, #4
	bl	AOE_REG_ReadSampelRate
	cmp	r0, #0
	bne	.L63
	ldr	r1, [r4]
	sub	r0, fp, #88
	ubfx	r1, r1, #8, #2
	bl	AOE_REG_ReadDataFormat
	cmp	r0, #0
	bne	.L63
	ldr	r1, [r4]
	sub	r0, fp, #112
	ubfx	r1, r1, #11, #9
	bl	AOE_REG_ReadBufLatencyMs
	subs	r10, r0, #0
	bne	.L63
	ldr	r3, [r4]
	ldr	r1, [fp, #-100]
	ldr	r0, [fp, #-96]
	ubfx	r3, r3, #10, #1
	str	r3, [fp, #-84]
	bl	UTIL_CalcFrameSize
	mov	r3, #1
	str	r3, [fp, #-80]
	ldr	r3, [r4, #24]
	str	r10, [fp, #-108]
	ubfx	r3, r3, #24, #1
	str	r10, [fp, #-104]
	str	r3, [fp, #-60]
	cmp	r3, #0
	ldr	r3, [r4, #16]
	str	r3, [fp, #-108]
	ldr	r2, [fp, #-108]
	ldr	r3, [r4, #20]
	str	r2, [fp, #-76]
	str	r3, [fp, #-104]
	ldr	r3, [r4, #24]
	bic	r3, r3, #-16777216
	str	r3, [fp, #-72]
	beq	.L61
	str	r10, [fp, #-108]
	str	r10, [fp, #-104]
	ldr	r3, [r4, #28]
	str	r3, [fp, #-108]
	ldr	r3, [r4, #32]
	ldr	r2, [fp, #-108]
	str	r3, [fp, #-104]
	str	r10, [fp, #-108]
	str	r10, [fp, #-104]
	ldr	r3, [r4, #36]
	str	r2, [fp, #-68]
	str	r3, [fp, #-108]
	ldr	r2, [fp, #-108]
	ldr	r3, [r4, #40]
	str	r2, [fp, #-64]
	str	r3, [fp, #-104]
.L62:
	ldr	r3, [fp, #-112]
	mov	r1, r0
	ldr	r2, [fp, #-92]
	str	r0, [fp, #-56]
	mov	r0, r3
	str	r3, [fp, #-48]
	bl	UTIL_LatencyMs2ByteSize
	sub	r1, fp, #80
	str	r0, [fp, #-52]
	sub	r0, fp, #116
	bl	RBUF_Create
	ldr	r3, [fp, #-116]
	cmp	r3, #0
	beq	.L63
	mov	r1, #140
	mov	r0, #26
	bl	HI_ADSP_MALLOC
	subs	r4, r0, #0
	beq	.L64
	mov	r1, #140
	bl	__memzero
	mov	r2, #56
	sub	r1, fp, #100
	add	r0, r4, #48
	bl	memcpy
	ldr	r3, [fp, #-116]
	str	r3, [r4, #116]
	ldr	r3, [r7]
	ldr	r2, [r3, #4]
	tst	r2, #524288
	bne	.L102
.L65:
	str	r9, [r4, #112]
.L80:
	mov	r3, #121
	str	r9, [r4, #20]
	str	r9, [r4, #32]
	mov	r2, #1
	str	r9, [r4, #36]
	str	r9, [r4]
	str	r9, [r4, #12]
	str	r9, [r4, #16]
	str	r9, [r4, #128]
	str	r9, [r4, #124]
	str	r3, [r4, #24]
	str	r3, [r4, #28]
	str	r3, [r4, #4]
	str	r3, [r4, #8]
	str	r2, [r4, #120]
	str	r4, [r6]
	ldr	r2, [r7]
	b	.L67
.L103:
.L68:
.L69:
	mov	r1, r4
	mov	r0, #26
	bl	HI_ADSP_FREE
.L64:
	ldr	r0, [fp, #-116]
	bl	RBUF_Destroy
.L63:
	str	r9, [r6]
	ldr	r2, [r7]
	ldr	r3, [r2, #4]
	tst	r3, #4
	bne	.L67
	ldr	r3, [r2, #4]
	mov	r1, #1
	bfi	r3, r1, #3, #4
	str	r3, [r2, #4]
	ldr	r3, [r2, #4]
	orr	r3, r3, #4
	str	r3, [r2, #4]
	ldr	r2, [r7]
	b	.L67
.L61:
	add	r3, r4, #28
	add	r4, r4, #36
	str	r3, [fp, #-68]
	str	r4, [fp, #-64]
	b	.L62
.L102:
	ldr	ip, [r3, #4]
	ubfx	ip, ip, #18, #1
	cmp	ip, #1
	bne	.L65
	ldr	lr, [r4, #56]
	add	r1, r4, #68
	ldr	r3, [r4, #52]
	mov	r0, r5
	ldr	r2, [r4, #48]
	str	ip, [r4, #112]
	str	lr, [sp]
	bl	CAST_Create
	subs	r10, r0, #0
	beq	.L103
	ldr	r1, [r4, #116]
	mov	r0, r5
	bl	CAST_SetAopBuf
	str	r10, [r4, #116]
	b	.L80
.L105:
	.align	2
.L104:
	.word	.LANCHOR0+28
	.fnend
	.size	AOP_Process, .-AOP_Process
	.align	2
	.global	AOP_GetChnStatus
	.type	AOP_GetChnStatus, %function
AOP_GetChnStatus:
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
	ldr	r3, .L109
	add	r0, r0, #8
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	streq	r3, [r1]
	ldmeqfd	sp, {fp, sp, pc}
	ldr	r2, [r3, #120]
	str	r2, [r1]
	ldr	r2, [r3, #64]
	str	r2, [r1, #4]
	ldr	r2, [r3, #92]
	str	r2, [r1, #16]
	ldr	r2, [r3, #48]
	str	r2, [r1, #8]
	ldr	r2, [r3, #52]
	str	r2, [r1, #12]
	ldr	r2, [r3, #104]
	str	r2, [r1, #20]
	ldr	r2, [r3, #112]
	str	r2, [r1, #28]
	ldr	r2, [r3, #108]
	str	r2, [r1, #24]
	ldr	r3, [r3, #124]
	str	r3, [r1, #32]
	ldmfd	sp, {fp, sp, pc}
.L110:
	.align	2
.L109:
	.word	.LANCHOR0
	.fnend
	.size	AOP_GetChnStatus, .-AOP_GetChnStatus
	.align	2
	.global	AOP_QueryRbfFree
	.type	AOP_QueryRbfFree, %function
AOP_QueryRbfFree:
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
	ldr	r3, .L116
	add	r0, r0, #8
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	beq	.L113
	ldr	r0, [r3, #120]
	cmp	r0, #0
	ldmeqfd	sp, {fp, sp, pc}
	ldr	r0, [r3, #116]
	cmp	r0, #0
	ldmeqfd	sp, {fp, sp, pc}
	bl	RBUF_CheckFree
	ldmfd	sp, {fp, sp, pc}
.L113:
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L117:
	.align	2
.L116:
	.word	.LANCHOR0
	.fnend
	.size	AOP_QueryRbfFree, .-AOP_QueryRbfFree
	.align	2
	.global	AOP_WriteBuffProcTryCnt
	.type	AOP_WriteBuffProcTryCnt, %function
AOP_WriteBuffProcTryCnt:
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
	ldr	r3, .L120
	add	r2, r0, #8
	ldr	r3, [r3, r2, asl #2]
	ldr	r3, [r3, #112]
	cmp	r3, #1
	ldmnefd	sp, {fp, sp, pc}
	bl	CAST_FiFoTryCnt
	ldmfd	sp, {fp, sp, pc}
.L121:
	.align	2
.L120:
	.word	.LANCHOR0
	.fnend
	.size	AOP_WriteBuffProcTryCnt, .-AOP_WriteBuffProcTryCnt
	.align	2
	.global	AOP_WriteBuffProcOKCnt
	.type	AOP_WriteBuffProcOKCnt, %function
AOP_WriteBuffProcOKCnt:
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
	ldr	r3, .L124
	add	r2, r0, #8
	ldr	r3, [r3, r2, asl #2]
	ldr	r3, [r3, #112]
	cmp	r3, #1
	ldmnefd	sp, {fp, sp, pc}
	bl	CAST_FiFoFreeCnt
	ldmfd	sp, {fp, sp, pc}
.L125:
	.align	2
.L124:
	.word	.LANCHOR0
	.fnend
	.size	AOP_WriteBuffProcOKCnt, .-AOP_WriteBuffProcOKCnt
	.align	2
	.global	AOP_WriteRbfData
	.type	AOP_WriteRbfData, %function
AOP_WriteRbfData:
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
	ldr	r3, .L160
	add	r0, r0, #8
	mov	r5, r1
	ldr	r4, [r3, r0, asl #2]
	cmp	r4, #0
	beq	.L142
	ldr	r0, [r4, #120]
	cmp	r0, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	r3, [r1, #24]
	cmp	r3, #0
	beq	.L154
.L129:
	ldr	r3, [r4, #112]
	ldr	r0, [r4, #116]
	cmp	r3, #1
	ldmia	r5, {r1, r2}
	beq	.L155
	bl	RBUF_WriteDataDma
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L154:
	ldr	r2, [r1, #12]
	ldr	r3, [r4, #48]
	cmp	r2, r3
	beq	.L153
	bl	AOE_GetWKBuf
	mov	r2, r5
	mov	r1, r0
	ldr	r0, [r4, #48]
	bl	UTIL_UnifyBitDepthPcmData
.L153:
	ldr	r2, [r5, #16]
	ldr	r3, [r4, #52]
	cmp	r2, r3
	beq	.L132
	bl	AOE_GetWKBuf
	mov	r2, r5
	mov	r1, r0
	ldr	r0, [r4, #52]
	bl	UTIL_UpmixPcmData
.L132:
	ldr	r3, [r4, #44]
	cmp	r3, #0
	bne	.L156
.L134:
	ldr	r3, [r4, #24]
	ldr	r2, [r4, #4]
	cmp	r3, r2
	beq	.L157
.L136:
	ldr	r2, [r4, #112]
	cmp	r2, #1
	beq	.L137
	bl	AOE_GetWKBuf
	ldmia	r5, {r1, r2}
	bl	memcpy
	add	r6, r4, #20
	mov	r2, r4
	mov	r3, r6
	str	r0, [r5]
	mov	r0, r5
	ldr	r1, [r4, #40]
	bl	UTIL_LRFadeGainProcess
	mov	r1, r6
	mov	r2, #20
	mov	r0, r4
	bl	memcpy
	b	.L129
.L155:
	bl	RBUF_WriteData
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L142:
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L157:
	ldr	r1, [r4, #32]
	ldr	r2, [r4, #12]
	cmp	r1, r2
	bne	.L136
.L137:
	cmp	r3, #121
	bne	.L139
	ldr	r3, [r4, #28]
	cmp	r3, #121
	beq	.L158
.L139:
	bl	AOE_GetWKBuf
	ldmia	r5, {r1, r2}
	bl	memcpy
	add	r2, r4, #20
	str	r0, [r5]
	mov	r0, r5
	ldr	r1, [r4, #40]
	bl	UTIL_LRGainProcess
	b	.L129
.L156:
	bl	AOE_GetWKBuf
	ldr	r1, [r5, #4]
	cmp	r1, #0
	mov	r6, r0
	bne	.L159
.L135:
	str	r6, [r5]
	b	.L134
.L158:
	ldr	r3, [r4, #32]
	cmp	r3, #0
	bne	.L139
	ldr	r3, [r4, #36]
	cmp	r3, #0
	bne	.L139
	ldr	r3, [r4, #40]
	cmp	r3, #0
	beq	.L129
	b	.L139
.L159:
	bl	__memzero
	b	.L135
.L161:
	.align	2
.L160:
	.word	.LANCHOR0
	.fnend
	.size	AOP_WriteRbfData, .-AOP_WriteRbfData
	.align	2
	.global	AOP_GetRingOut
	.type	AOP_GetRingOut, %function
AOP_GetRingOut:
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
	ldr	r3, .L165
	add	r0, r0, #8
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	ldrne	r0, [r0, #116]
	ldmfd	sp, {fp, sp, pc}
.L166:
	.align	2
.L165:
	.word	.LANCHOR0
	.fnend
	.size	AOP_GetRingOut, .-AOP_GetRingOut
	.bss
	.align	2
.LANCHOR0 = . + 0
	.type	g_stAopRm, %object
	.size	g_stAopRm, 64
g_stAopRm:
	.space	64
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
