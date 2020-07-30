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
	.file	"aoe_cast.c"

	.text
	.align	2
	.type	CASTCalcSize, %function
CASTCalcSize:
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
	.size	CASTCalcSize, .-CASTCalcSize
	.align	2
	.type	CAST_TimerHandle, %function
CAST_TimerHandle:
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
	ldr	r5, .L24
	add	r6, r5, #20
	add	r9, r5, #16
.L15:
	ldr	r4, [r5, #4]!
	cmp	r4, #0
	beq	.L7
	mov	r0, r6
	bl	_raw_spin_lock_bh
	ldr	r0, [r4, #36]
	ldr	r7, [r4, #32]
	bl	RBUF_QueryBusy
	mov	r8, r0
	ldr	r0, [r4, #40]
	bl	RBUF_QueryFree
	cmp	r7, r8
	bhi	.L8
	cmp	r7, r0
	mov	r2, r7
	bhi	.L14
.L20:
	mov	r3, #1
	ldr	r1, [r4, #40]
	ldr	r0, [r4, #36]
	bl	RBUF_CopyData
	ldr	r2, [r4, #44]
	add	r2, r2, #1
	str	r2, [r4, #44]
.L10:
	ldr	r3, [r4, #56]
	add	r3, r3, #1
	str	r3, [r4, #56]
	ldr	r3, [r5, #-16]
	str	r2, [r3, #28]
	ldr	r2, [r4, #48]
	str	r2, [r3, #32]
	ldr	r2, [r4, #52]
	str	r2, [r3, #36]
	ldr	r2, [r4, #56]
	str	r2, [r3, #40]
	ldr	r2, [r4, #60]
	str	r2, [r3, #24]
	ldr	r2, [r4, #64]
	str	r2, [r3, #16]
	ldr	r2, [r4, #68]
	str	r2, [r3, #20]
.L11:
	mov	r0, r6
	bl	_raw_spin_unlock_bh
.L7:
	cmp	r5, r9
	add	r6, r6, #4
	bne	.L15
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L8:
	cmp	r8, #0
	bne	.L12
	cmp	r7, r0
	bls	.L23
	ldr	r3, [r4, #52]
	add	r3, r3, #1
	str	r3, [r4, #52]
	b	.L11
.L12:
	cmp	r8, r0
	mov	r2, r8
	bls	.L20
.L14:
	mov	r1, #0
	ldr	r0, [r4, #36]
	bl	RBUF_ReadData
	ldr	r3, [r4, #52]
	add	r3, r3, #1
	str	r3, [r4, #52]
	b	.L11
.L23:
	mov	r2, r7
	mov	r1, r8
	ldr	r0, [r4, #40]
	bl	RBUF_WriteDataDma
	ldr	r3, [r4, #48]
	ldr	r2, [r4, #44]
	add	r3, r3, #1
	str	r3, [r4, #48]
	b	.L10
.L25:
	.align	2
.L24:
	.word	.LANCHOR0+48
	.fnend
	.size	CAST_TimerHandle, .-CAST_TimerHandle
	.align	2
	.global	CAST_SetAopBuf
	.type	CAST_SetAopBuf, %function
CAST_SetAopBuf:
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
	ldmeqfd	sp, {fp, sp, pc}
	ldr	r3, .L37
	ldr	r2, [r3, #20]
	cmp	r0, r2
	beq	.L30
	ldr	r2, [r3, #24]
	cmp	r0, r2
	beq	.L31
	ldr	r2, [r3, #28]
	cmp	r0, r2
	beq	.L32
	ldr	r2, [r3, #32]
	cmp	r0, r2
	moveq	r2, #3
	ldmnefd	sp, {fp, sp, pc}
.L28:
	add	r3, r3, r2, lsl #2
	ldr	r3, [r3, #52]
	str	r1, [r3, #40]
	ldmfd	sp, {fp, sp, pc}
.L30:
	mov	r2, #0
	b	.L28
.L31:
	mov	r2, #1
	b	.L28
.L32:
	mov	r2, #2
	b	.L28
.L38:
	.align	2
.L37:
	.word	.LANCHOR0
	.fnend
	.size	CAST_SetAopBuf, .-CAST_SetAopBuf
	.align	2
	.global	CAST_Destroy
	.type	CAST_Destroy, %function
CAST_Destroy:
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
	ldr	r3, .L50
	ldr	r2, [r3, #20]
	cmp	r0, r2
	beq	.L43
	ldr	r2, [r3, #24]
	cmp	r0, r2
	beq	.L44
	ldr	r2, [r3, #28]
	cmp	r0, r2
	beq	.L45
	ldr	r2, [r3, #32]
	cmp	r0, r2
	moveq	r5, #3
	ldmnefd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L40:
	add	r4, r5, #12
	ldr	r7, .L50
	add	r4, r3, r4, lsl #2
	ldr	r6, [r4, #4]
	cmp	r6, #0
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	add	r3, r7, #68
	ldr	r8, [r6, #40]
	add	r5, r3, r5, lsl #2
	mov	r0, r5
	bl	_raw_spin_lock_bh
	mov	r1, r6
	mov	r0, #26
	bl	HI_ADSP_FREE
	mov	r0, r5
	mov	r3, #0
	str	r3, [r4, #4]
	bl	_raw_spin_unlock_bh
	mov	r0, r8
	bl	RBUF_Destroy
	ldr	r3, [r7, #16]
	sub	r3, r3, #1
	str	r3, [r7, #16]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L43:
	mov	r5, #0
	b	.L40
.L44:
	mov	r5, #1
	b	.L40
.L45:
	mov	r5, #2
	b	.L40
.L51:
	.align	2
.L50:
	.word	.LANCHOR0
	.fnend
	.size	CAST_Destroy, .-CAST_Destroy
	.align	2
	.global	CAST_Create
	.type	CAST_Create, %function
CAST_Create:
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
	mov	r7, r0
	mov	r5, r1
	mov	r0, #26
	mov	r1, #72
	mov	r8, r2
	mov	r9, r3
	mov	r3, #0
	str	r3, [fp, #-48]
	bl	HI_ADSP_MALLOC
	subs	r4, r0, #0
	beq	.L57
	mov	r1, #72
	bl	__memzero
	ldr	r1, .L65
	ldr	r6, [r1, #52]
	cmp	r6, #0
	beq	.L54
	ldr	r3, [r1, #56]
	cmp	r3, #0
	beq	.L59
	ldr	r3, [r1, #60]
	cmp	r3, #0
	beq	.L60
	ldr	r3, [r1, #64]
	cmp	r3, #0
	moveq	r6, #3
	beq	.L54
.L56:
	mov	r0, #26
	mov	r1, r4
	bl	HI_ADSP_FREE
	mov	r0, #0
.L53:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L60:
	mov	r6, #2
.L54:
	ldr	r2, [fp, #4]
	add	r3, r1, r6, lsl #2
	add	r10, r4, #12
	str	r8, [r4, #12]
	str	r9, [r4, #16]
	mov	r0, #65
	str	r2, [r4, #20]
	mov	r1, r10
	ldr	r9, [r3, #36]
	mov	r3, #0
	str	r3, [r5]
	bl	CASTCalcSize
	add	r2, r9, #12
	add	r1, r9, #8
	str	r2, [r5, #16]
	str	r1, [r5, #12]
	ldr	r8, .L65
	str	r0, [r5, #8]
	ldr	r1, [r4, #12]
	ldr	r0, [r4, #16]
	bl	UTIL_CalcFrameSize
	ldr	r2, [r5, #8]
	mov	r1, r5
	str	r0, [r5, #24]
	sub	r0, fp, #48
	str	r2, [r9, #4]
	str	r7, [r9]
	bl	RBUF_Create
	ldr	r2, [fp, #-48]
	cmp	r2, #0
	beq	.L56
	add	ip, r8, r6, lsl #2
	ldr	r3, [r8, #16]
	str	r2, [r4, #36]
	mov	r1, r10
	mov	r0, #5
	add	r3, r3, #1
	str	r7, [ip, #20]
	str	r3, [r8, #16]
	bl	CASTCalcSize
	add	r3, r8, r6, lsl #2
	mov	r2, #0
	mov	r1, #28
	add	r6, r8, r6, lsl #2
	str	r2, [r3, #68]
	str	r0, [r4, #32]
	add	r0, r4, #44
	bl	__memzero
	ldr	r0, [fp, #-48]
	str	r4, [r6, #52]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L57:
	mov	r0, r4
	b	.L53
.L59:
	mov	r6, #1
	b	.L54
.L66:
	.align	2
.L65:
	.word	.LANCHOR0
	.fnend
	.size	CAST_Create, .-CAST_Create
	.align	2
	.global	CAST_FiFoTryCnt
	.type	CAST_FiFoTryCnt, %function
CAST_FiFoTryCnt:
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
	ldr	r3, .L78
	ldr	r2, [r3, #20]
	cmp	r0, r2
	beq	.L71
	ldr	r2, [r3, #24]
	cmp	r0, r2
	beq	.L72
	ldr	r2, [r3, #28]
	cmp	r0, r2
	beq	.L73
	ldr	r2, [r3, #32]
	cmp	r0, r2
	moveq	r2, #3
	ldmnefd	sp, {fp, sp, pc}
.L68:
	add	r3, r3, r2, lsl #2
	ldr	r3, [r3, #52]
	cmp	r3, #0
	ldrne	r2, [r3, #64]
	addne	r2, r2, #1
	strne	r2, [r3, #64]
	ldmfd	sp, {fp, sp, pc}
.L71:
	mov	r2, #0
	b	.L68
.L72:
	mov	r2, #1
	b	.L68
.L73:
	mov	r2, #2
	b	.L68
.L79:
	.align	2
.L78:
	.word	.LANCHOR0
	.fnend
	.size	CAST_FiFoTryCnt, .-CAST_FiFoTryCnt
	.align	2
	.global	CAST_FiFoFreeCnt
	.type	CAST_FiFoFreeCnt, %function
CAST_FiFoFreeCnt:
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
	ldr	r3, .L91
	ldr	r2, [r3, #20]
	cmp	r0, r2
	beq	.L84
	ldr	r2, [r3, #24]
	cmp	r0, r2
	beq	.L85
	ldr	r2, [r3, #28]
	cmp	r0, r2
	beq	.L86
	ldr	r2, [r3, #32]
	cmp	r0, r2
	moveq	r2, #3
	ldmnefd	sp, {fp, sp, pc}
.L81:
	add	r3, r3, r2, lsl #2
	ldr	r3, [r3, #52]
	cmp	r3, #0
	ldrne	r2, [r3, #68]
	addne	r2, r2, #1
	strne	r2, [r3, #68]
	ldmfd	sp, {fp, sp, pc}
.L84:
	mov	r2, #0
	b	.L81
.L85:
	mov	r2, #1
	b	.L81
.L86:
	mov	r2, #2
	b	.L81
.L92:
	.align	2
.L91:
	.word	.LANCHOR0
	.fnend
	.size	CAST_FiFoFreeCnt, .-CAST_FiFoFreeCnt
	.align	2
	.global	CAST_Init
	.type	CAST_Init, %function
CAST_Init:
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
	mov	r1, #68
	mov	r5, r0
	ldr	r0, .L96
	bl	__memzero
	ldr	r4, .L96
	mov	r6, #0
	add	r5, r5, #1024
	mov	r7, r6
.L94:
	mov	r0, r5
	add	r6, r6, #1
	mov	r1, #48
	str	r5, [r4, #36]
	bl	__memzero
	cmp	r6, #4
	str	r7, [r4, #52]
	mov	r3, #8
	add	r5, r5, #48
	str	r3, [r4, #20]
	add	r4, r4, #4
	bne	.L94
	ldr	r0, .L96+4
	bl	TIMER_RegIsrFunc
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L97:
	.align	2
.L96:
	.word	.LANCHOR0
	.word	CAST_TimerHandle
	.fnend
	.size	CAST_Init, .-CAST_Init
	.align	2
	.global	CAST_DeInit
	.type	CAST_DeInit, %function
CAST_DeInit:
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
	bl	TIMER_DelIsrFunc
	ldr	r3, .L99
	mov	r2, #0
	str	r2, [r3, #52]
	str	r2, [r3, #56]
	str	r2, [r3, #60]
	str	r2, [r3, #64]
	ldmfd	sp, {fp, sp, pc}
.L100:
	.align	2
.L99:
	.word	.LANCHOR0
	.fnend
	.size	CAST_DeInit, .-CAST_DeInit
	.bss
	.align	2
.LANCHOR0 = . + 0
	.type	g_stCastRm, %object
	.size	g_stCastRm, 68
g_stCastRm:
	.space	68
	.type	g_spinCasetLock, %object
	.size	g_spinCasetLock, 16
g_spinCasetLock:
	.space	16
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
