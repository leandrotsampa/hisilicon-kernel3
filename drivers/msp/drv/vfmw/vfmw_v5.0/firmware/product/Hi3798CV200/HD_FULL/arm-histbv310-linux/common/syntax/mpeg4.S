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
	.file	"mpeg4.c"

	.text
	.align	2
	.global	log2bin
	.type	log2bin, %function
log2bin:
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
	cmp	r0, #0
	ldmeqfd	sp, {fp, sp, pc}
	mov	r3, #0
.L3:
	add	r3, r3, #1
	movs	r0, r0, lsr #1
	uxth	r3, r3
	bne	.L3
	sxth	r0, r3
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	log2bin, .-log2bin
	.align	2
	.global	bs_get_spritetrajectory
	.type	bs_get_spritetrajectory, %function
bs_get_spritetrajectory:
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
	ldr	r6, .L13
	mov	r7, r0
	mov	r4, #0
	mov	r5, r6
.L10:
	ldrb	r1, [r5, #4]
	mov	r0, r7
	bl	BsShow
	ldr	r3, [r6, r4, asl #3]
	ldr	r2, .L13
	mov	r1, r4, asl #3
	add	r5, r5, #8
	cmp	r0, r3
	beq	.L12
	add	r4, r4, #1
	cmp	r4, #12
	bne	.L10
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L12:
	add	r2, r2, r1
	mov	r0, r7
	ldrb	r1, [r2, #4]
	bl	BsSkip
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L14:
	.align	2
.L13:
	.word	.LANCHOR0
	.fnend
	.size	bs_get_spritetrajectory, .-bs_get_spritetrajectory
	.global	__aeabi_idiv
	.align	2
	.global	MP4_GetGMCparam
	.type	MP4_GetGMCparam, %function
MP4_GetGMCparam:
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
	ldrb	r5, [r0, #65]
	mov	r3, #2
	mov	r10, r0
	mov	r9, r1
	mov	r3, r3, asl r5
	mov	r0, #16
	rsb	r2, r5, #3
	str	r3, [fp, #-56]
	mov	r1, r3
	str	r2, [fp, #-100]
	bl	__aeabi_idiv
	ldr	r8, [r10, #708]
	ldr	r3, [r10, #704]
	cmp	r8, #1
	mov	r2, r8, asl #4
	str	r2, [r9, #8]
	str	r2, [fp, #-64]
	ldr	r2, [r10, #704]
	mov	r2, r2, asl #4
	str	r2, [r9, #12]
	ldrb	r2, [r10, #65]
	str	r2, [r9, #4]
	ldrb	r2, [r10, #64]
	str	r2, [r9]
	str	r2, [fp, #-68]
	ldr	r2, [r10, #696]
	ldr	ip, [r10, #680]
	str	r2, [fp, #-52]
	ldr	r2, [r10, #700]
	str	r2, [fp, #-72]
	str	r0, [fp, #-48]
	add	r0, r10, #684
	ldmia	r0, {r0, r1, lr}
	ble	.L40
	mov	r5, #0
	mov	r2, #1
.L17:
	add	r5, r5, #1
	mov	r6, r2, asl r5
	cmp	r8, r6
	bgt	.L17
	mov	r2, r6, asl #4
	str	r2, [fp, #-96]
.L16:
	cmp	r3, #1
	ble	.L41
	mov	r4, #0
	mov	r2, #1
.L19:
	add	r4, r4, #1
	mov	r7, r2, asl r4
	cmp	r3, r7
	bgt	.L19
	mov	r2, r7, asl #4
	str	r2, [fp, #-104]
.L18:
	ldrb	r2, [r10, #12]
	cmp	r2, #1
	beq	.L45
	add	r2, ip, r8, lsl #1
	add	lr, r0, lr
	add	r1, r1, r2
	ldr	r2, [fp, #-56]
	str	lr, [fp, #-76]
	add	r10, r0, r3, lsl #1
	ldr	lr, [fp, #-52]
	mov	r2, r2, asr #1
	str	r2, [fp, #-52]
	ldr	r2, [fp, #-72]
	add	lr, ip, lr
	add	r10, r2, r10
	ldr	r2, [fp, #-52]
	mul	ip, r2, ip
	mul	r1, r1, r2
	str	ip, [fp, #-60]
	ldr	ip, [fp, #-76]
	mul	ip, ip, r2
	str	ip, [fp, #-84]
	mul	ip, lr, r2
	str	ip, [fp, #-88]
	mul	ip, r10, r2
	mul	r2, r2, r0
	str	ip, [fp, #-92]
	str	r2, [fp, #-52]
.L21:
	ldr	r2, [fp, #-64]
	ldr	ip, [fp, #-48]
	ldr	lr, [fp, #-60]
	rsb	r0, r2, #0
	rsb	r2, r6, r8
	str	r3, [fp, #-72]
	mla	r0, r1, ip, r0
	mov	r1, r8
	mul	r10, lr, ip
	mov	ip, r8, asr #1
	str	r2, [fp, #-76]
	str	ip, [fp, #-80]
	mul	r0, r6, r0
	mla	r0, r10, r2, r0
	cmp	r0, #0
	addgt	r0, r0, ip
	rsble	r0, ip, r0
	bl	__aeabi_idiv
	ldr	r2, [fp, #-84]
	ldr	r3, [fp, #-48]
	ldr	ip, [fp, #-80]
	mul	r1, r2, r3
	ldr	r2, [fp, #-52]
	mul	r3, r2, r3
	ldr	r2, [fp, #-76]
	mul	r1, r6, r1
	mla	r2, r3, r2, r1
	str	r3, [fp, #-64]
	ldr	r3, [fp, #-96]
	mov	r1, r8
	cmp	r2, #0
	add	r3, r0, r3
	str	r3, [fp, #-76]
	ldr	r3, [fp, #-72]
	addgt	r0, r2, ip
	rsble	r0, ip, r2
	str	r3, [fp, #-72]
	bl	__aeabi_idiv
	ldr	r3, [fp, #-88]
	ldr	r2, [fp, #-48]
	ldr	r8, [fp, #-92]
	mul	lr, r3, r2
	ldr	r3, [fp, #-72]
	rsb	r2, r7, r3
	mov	r1, r3, asr #1
	mov	ip, r0
	mul	r0, r7, lr
	ldr	lr, [fp, #-48]
	mla	r10, r2, r10, r0
	mov	r0, r3, asl #4
	rsb	r0, r0, #0
	mla	r0, r8, lr, r0
	ldr	lr, [fp, #-64]
	cmp	r10, #0
	addgt	r10, r10, r1
	rsble	r10, r1, r10
	mul	r0, r7, r0
	mla	r0, r2, lr, r0
	cmp	r0, #0
	addgt	r2, r0, r1
	rsble	r2, r1, r0
	str	r2, [fp, #-72]
	ldr	r2, [fp, #-68]
	cmp	r2, #3
	ldrls	pc, [pc, r2, asl #2]
	b	.L30
.L32:
	.word	.L42
	.word	.L33
	.word	.L34
	.word	.L35
.L42:
	mov	r0, #0
	mov	r3, r0
	mov	r8, r0
	mov	r10, r0
.L31:
	mov	r5, #0
	mov	ip, r5
.L39:
	ldr	r1, [fp, #-56]
	mov	r10, r10, asr r5
	mov	r3, r3, asr ip
	mov	r5, r8, asr r5
	mov	r0, r0, asr ip
	str	r3, [r9, #40]
	mov	r2, #1
	mov	r3, #0
	str	r10, [r9, #32]
	str	r5, [r9, #36]
	str	r0, [r9, #44]
	str	r1, [r9, #16]
	str	r1, [r9, #28]
	str	r3, [r9, #20]
	str	r3, [r9, #24]
	str	r2, [r9]
	b	.L15
.L35:
	ldr	r2, [fp, #-48]
	cmp	r4, r5
	ldr	r1, [fp, #-60]
	rsb	r2, r2, #0
	ldr	lr, [fp, #-100]
	str	ip, [fp, #-84]
	mov	r0, r2
	add	r2, r5, r4
	add	r2, r2, lr
	movge	r4, r5
	mul	ip, r1, r0
	rsb	r5, r4, r2
	mov	lr, #1
	sub	r8, r5, #1
	mov	r8, lr, asl r8
	ldr	lr, [fp, #-76]
	mov	r7, r7, asr r4
	str	r0, [fp, #-68]
	add	r2, lr, ip
	ldr	lr, [fp, #-52]
	mov	r0, r10
	add	r10, r8, r1, asl r5
	mov	r1, r3
	str	r10, [r9, #32]
	add	r8, r8, lr, asl r5
	str	r8, [r9, #36]
	mov	r4, r6, asr r4
	str	ip, [fp, #-80]
	str	r3, [fp, #-76]
	str	r4, [fp, #-64]
	mul	r4, r7, r2
	bl	__aeabi_idiv
	ldr	r3, [fp, #-76]
	mov	r2, r6, asl #1
	ldr	lr, [fp, #-52]
	mov	r6, r6, asl #4
	ldr	ip, [fp, #-84]
	mov	r1, r3
	ldr	r3, [fp, #-68]
	rsb	r6, r6, #0
	mul	r2, r7, r2
	mul	r6, r7, r6
	mul	r3, lr, r3
	str	r6, [fp, #-68]
	mov	r6, #1
	mov	lr, r3
	add	r3, r5, #1
	mov	r3, r6, asl r3
	ldr	r6, [fp, #-48]
	add	ip, ip, lr
	str	r3, [fp, #-76]
	ldr	r3, [fp, #-64]
	mul	r2, r6, r2
	str	lr, [fp, #-48]
	mul	r6, r7, ip
	ldr	r7, [fp, #-80]
	ldr	ip, [fp, #-60]
	add	r7, r0, r7
	ldr	r0, [fp, #-72]
	str	r2, [fp, #-72]
	mul	r7, r3, r7
	add	r3, r4, r7
	mla	r3, ip, r2, r3
	ldr	ip, [fp, #-68]
	ldr	r2, [fp, #-76]
	add	r3, r3, ip
	add	r3, r3, r2
	str	r3, [r9, #40]
	str	r3, [fp, #-60]
	bl	__aeabi_idiv
	ldr	r1, [fp, #-104]
	add	ip, r5, #2
	ldr	r2, [fp, #-64]
	ldr	r3, [fp, #-52]
	str	r7, [r9, #20]
	str	r4, [r9, #16]
	str	r6, [r9, #24]
	add	r0, r0, r1
	ldr	r1, [fp, #-48]
	add	lr, r0, r1
	mul	lr, r2, lr
	ldr	r2, [fp, #-72]
	add	r0, r6, lr
	mla	r2, r3, r2, r0
	ldr	r3, [fp, #-68]
	str	lr, [r9, #28]
	add	r0, r3, r2
	ldr	r3, [fp, #-60]
	ldr	r2, [fp, #-76]
	add	r0, r2, r0
	str	r0, [r9, #44]
.L36:
	ldr	r2, [fp, #-56]
	cmp	r4, r2, asl r5
	beq	.L46
.L37:
	rsb	r5, r5, #16
	rsb	r1, ip, #16
	mov	r2, r4, asl r5
	mov	r10, r10, asl r5
	mov	r4, r7, asl r5
	mov	r8, r8, asl r5
	mov	r7, r6, asl r5
	mov	r3, r3, asl r1
	mov	r5, lr, asl r5
	mov	r0, r0, asl r1
	str	r10, [r9, #32]
	str	r8, [r9, #36]
	str	r2, [r9, #16]
	str	r4, [r9, #20]
	str	r7, [r9, #24]
	str	r5, [r9, #28]
	str	r3, [r9, #40]
	str	r0, [r9, #44]
.L15:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L34:
	ldr	lr, [fp, #-48]
	mov	r1, r6, asl #1
	ldr	r10, [fp, #-60]
	ldr	r0, [fp, #-76]
	rsb	r3, lr, #0
	ldr	r2, [fp, #-64]
	mul	r1, lr, r1
	rsb	r7, ip, r2
	mla	r4, r10, r3, r0
	ldr	r0, [fp, #-52]
	ldr	r2, [fp, #-100]
	ldr	r8, [fp, #-52]
	add	r5, r5, r2
	mov	r2, r6, asl #4
	mla	r6, r0, r3, ip
	add	r3, r7, r4
	mov	ip, #1
	rsb	r2, r2, #0
	mla	r3, r10, r1, r3
	add	lr, r4, r6
	add	r0, r5, #1
	str	r7, [r9, #20]
	mla	r1, r8, r1, lr
	mov	r0, ip, asl r0
	add	r3, r3, r2
	sub	r8, r5, #1
	add	r3, r3, r0
	mov	r8, ip, asl r8
	add	r2, r2, r1
	add	r10, r8, r10, asl r5
	add	r0, r0, r2
	ldr	r2, [fp, #-52]
	str	r4, [r9, #16]
	mov	lr, r4
	str	r6, [r9, #24]
	add	ip, r5, #2
	add	r8, r8, r2, asl r5
	ldr	r2, [fp, #-56]
	str	r4, [r9, #28]
	str	r3, [r9, #40]
	cmp	r4, r2, asl r5
	str	r10, [r9, #32]
	str	r0, [r9, #44]
	str	r8, [r9, #36]
	bne	.L37
.L46:
	cmp	r7, #0
	bne	.L37
	cmp	r6, #0
	bne	.L37
	cmp	r4, lr
	bne	.L37
	b	.L39
.L33:
	ldr	r2, [fp, #-60]
	ldr	r1, [fp, #-52]
	and	r3, r2, #1
	and	r0, r1, #1
	orr	r3, r3, r2, asr #1
	mov	r10, r2
	orr	r0, r0, r1, asr #1
	mov	r8, r1
	b	.L31
.L45:
	ldr	r2, [fp, #-56]
	add	lr, r0, lr
	str	lr, [fp, #-84]
	ldr	lr, [fp, #-52]
	mla	r10, r8, r2, ip
	str	r0, [fp, #-52]
	mla	r2, r3, r2, r0
	ldr	r0, [fp, #-72]
	add	lr, ip, lr
	add	r1, r1, r10
	str	lr, [fp, #-88]
	add	r2, r0, r2
	str	ip, [fp, #-60]
	str	r2, [fp, #-92]
	b	.L21
.L30:
	mov	ip, #0
	ldr	r4, [r9, #16]
	mov	r5, ip
	ldr	r10, [r9, #32]
	ldr	r8, [r9, #36]
	ldr	r3, [r9, #40]
	ldr	r0, [r9, #44]
	ldr	r7, [r9, #20]
	ldr	r6, [r9, #24]
	ldr	lr, [r9, #28]
	b	.L36
.L40:
	mov	r2, #16
	mov	r6, #1
	str	r2, [fp, #-96]
	mov	r5, #0
	b	.L16
.L41:
	mov	r2, #16
	mov	r7, #1
	str	r2, [fp, #-104]
	mov	r4, #0
	b	.L18
	.fnend
	.size	MP4_GetGMCparam, .-MP4_GetGMCparam
	.align	2
	.global	Mp4_GetUserDataBuf
	.type	Mp4_GetUserDataBuf, %function
Mp4_GetUserDataBuf:
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
	ldr	r3, [r1, r2, asl #2]
	cmp	r3, #0
	beq	.L52
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L52:
	str	r2, [fp, #-20]
	str	r1, [fp, #-16]
	bl	GetUsd
	ldr	r2, [fp, #-20]
	ldr	r1, [fp, #-16]
	cmp	r0, #0
	mov	r3, r0
	str	r0, [r1, r2, asl #2]
	addne	r0, r2, #4
	strne	r0, [r3, #1040]
	ldrne	r3, [r1, r2, asl #2]
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Mp4_GetUserDataBuf, .-Mp4_GetUserDataBuf
	.align	2
	.global	Mp4_ClearUsrData
	.type	Mp4_ClearUsrData, %function
Mp4_ClearUsrData:
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
	sub	r4, r1, #4
	add	r5, r1, #12
	mov	r7, r0
	mov	r6, #0
.L54:
	ldr	r1, [r4, #4]!
	mov	r0, r7
	bl	FreeUsdByDec
	cmp	r4, r5
	str	r6, [r4]
	bne	.L54
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	Mp4_ClearUsrData, .-Mp4_ClearUsrData
	.align	2
	.global	Mp4_Syntax_Init
	.type	Mp4_Syntax_Init, %function
Mp4_Syntax_Init:
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
	ldr	r5, .L61
	mov	r4, r0
	add	r0, r0, #19968
	mov	r2, #24
	mov	r1, #0
	add	r0, r0, r2
	ldr	r3, [r5, #48]
	blx	r3
	add	r0, r4, #19968
	ldr	r3, [r5, #48]
	mov	r2, #604
	mov	r1, #0
	add	r0, r0, #48
	blx	r3
	add	r0, r4, #20992
	ldr	r3, [r5, #48]
	mov	r2, #60
	mov	r1, #0
	add	r0, r0, #232
	blx	r3
	add	r0, r4, #21248
	ldr	r3, [r5, #48]
	mov	r2, #768
	mov	r1, #0
	add	r0, r0, #36
	blx	r3
	add	r0, r4, #22016
	ldr	r3, [r5, #48]
	mov	r2, #7
	mov	r1, #0
	add	r0, r0, #36
	blx	r3
	add	r2, r4, #19968
	add	r3, r4, #20224
	ldr	r1, .L61+4
	add	r0, r4, #20480
	add	r2, r2, #132
	add	r3, r3, #132
	mov	ip, #1
	strb	ip, [r0, #821]
	str	ip, [r0, #2136]
.L57:
	ldr	ip, [r1, #4]!
	str	ip, [r2, #4]!
	cmp	r2, r3
	bne	.L57
	add	r0, r4, #20480
	ldr	r2, .L61+8
	add	r0, r0, #132
.L58:
	ldr	r1, [r2, #4]!
	str	r1, [r3, #4]!
	cmp	r3, r0
	bne	.L58
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L62:
	.align	2
.L61:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR1-4
	.word	.LANCHOR1+252
	.fnend
	.size	Mp4_Syntax_Init, .-Mp4_Syntax_Init
	.align	2
	.global	Global_Data_Init
	.type	Global_Data_Init, %function
Global_Data_Init:
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
	ldr	r5, .L64
	mov	r4, r0
	add	r0, r0, #22016
	mov	r2, #24
	mov	r1, #0
	ldr	r3, [r5, #48]
	add	r0, r0, #64
	blx	r3
	add	r0, r4, #22016
	ldr	r3, [r5, #48]
	mov	r2, #16
	mov	r1, #0
	add	r0, r0, #44
	blx	r3
	mov	r0, r4
	bl	Mp4_Syntax_Init
	add	r3, r4, #20480
	mov	r2, #0
	mov	r0, r2
	str	r2, [r3, #2116]
	str	r2, [r3, #2120]
	str	r2, [r3, #2124]
	str	r2, [r3, #2128]
	str	r2, [r3, #2088]
	str	r2, [r3, #1628]
	str	r2, [r3, #2072]
	str	r2, [r3, #2076]
	str	r2, [r3, #2080]
	str	r2, [r3, #2132]
	str	r2, [r3, #2092]
	str	r2, [r3, #2096]
	str	r2, [r3, #2100]
	str	r2, [r3, #2104]
	str	r2, [r3, #2108]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L65:
	.align	2
.L64:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	Global_Data_Init, .-Global_Data_Init
	.align	2
	.global	Bs_Get_Matrix
	.type	Bs_Get_Matrix, %function
Bs_Get_Matrix:
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
	mov	r5, #0
	mov	r8, r0
	mov	r6, r1
	mov	r4, r5
	ldr	r7, .L76
	b	.L67
.L71:
	mov	r5, r0
.L67:
	mov	r1, #8
	mov	r0, r8
	bl	BsGet
	add	ip, r4, #1
	sxth	r9, r4
	uxth	r3, ip
	add	r1, r7, r9, lsl #2
	sxth	r2, r3
	uxth	r3, r3
	ldr	r1, [r1, #512]
	mov	r4, r3
	adds	lr, r0, #0
	str	r0, [r6, r1, asl #2]
	movne	lr, #1
	cmp	r2, #63
	movgt	r2, #0
	andle	r2, lr, #1
	cmp	r2, #0
	bne	.L71
	cmp	lr, #0
	ldmnefd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	cmp	r9, #63
	ldmgtfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L70:
	uxth	r4, ip
	str	r5, [r6, r1, asl #2]
	add	ip, r4, #1
	sxth	r3, r4
	cmp	r3, #64
	add	r3, r7, r3, lsl #2
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	ldr	r1, [r3, #512]
	b	.L70
.L77:
	.align	2
.L76:
	.word	.LANCHOR1
	.fnend
	.size	Bs_Get_Matrix, .-Bs_Get_Matrix
	.align	2
	.global	NextStartCode
	.type	NextStartCode, %function
NextStartCode:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #32
	sub	sp, sp, #32
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r6, r0
	sub	r0, fp, #60
	mov	r7, r3
	mov	r4, r2, asl #3
	movw	r5, #438
	bl	BsInit
	mov	r0, #0
	b	.L79
.L83:
	cmp	lr, #256
	beq	.L92
.L87:
	bl	BsSkip
	sub	r0, fp, #60
	bl	BsPos
.L79:
	rsb	ip, r0, r4
	mov	r1, #32
	cmp	ip, #31
	sub	r0, fp, #60
	ble	.L93
	bl	BsShow
	mov	r1, #8
	mov	ip, r0
	cmp	ip, r5
	bic	r3, r0, #1020
	bic	r2, r0, #15
	bic	lr, r0, #255
	bic	r3, r3, #3
	sub	r0, fp, #60
	beq	.L82
	cmp	r2, #288
	beq	.L82
	cmp	r3, #32768
	bne	.L83
	ldrb	r3, [r6, #9]
	mov	r1, #8
	sub	r0, fp, #60
	cmp	r3, #2
	bne	.L94
	ldr	r3, [r6, #744]
	add	r3, r3, #1
	str	r3, [r6, #744]
	cmp	r3, #18
	bls	.L87
	mov	r2, #196
	mov	r3, #1
	str	r2, [r7]
	sub	r0, fp, #60
	strb	r3, [r6, #9]
	bl	BsPos
	b	.L81
.L82:
	mov	r2, #2
	mov	r3, #0
	strb	r2, [r6, #9]
	sub	r0, fp, #60
	str	r3, [r6, #744]
	str	ip, [r7]
	bl	BsPos
.L81:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L93:
	mov	r3, #197
	str	r3, [r7]
	bl	BsPos
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L92:
	str	ip, [r7]
	sub	r0, fp, #60
	bl	BsPos
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L94:
	mov	r2, #1
	mov	r3, #196
	strb	r2, [r6, #9]
	str	r3, [r7]
	bl	BsPos
	b	.L81
	.fnend
	.size	NextStartCode, .-NextStartCode
	.align	2
	.global	Mp4SearchStartCode
	.type	Mp4SearchStartCode, %function
Mp4SearchStartCode:
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
	ble	.L107
	add	lr, r0, r1
	add	r3, r0, #2
.L112:
	cmp	lr, r3
	bls	.L97
.L113:
	ldrb	r2, [r3]
	cmp	r2, #1
	bls	.L98
	and	ip, r2, #252
	cmp	ip, #128
	beq	.L98
.L105:
	add	r3, r3, #3
	cmp	lr, r3
	bhi	.L113
.L97:
	sub	r0, r1, #2
	ldmfd	sp, {fp, sp, pc}
.L98:
	cmp	r2, #0
	bne	.L100
	ldrb	r2, [r3, #-1]
	cmp	r2, #0
	addeq	r3, r3, #1
	beq	.L112
	ldrb	r2, [r3, #1]
	cmp	r2, #0
	addeq	r3, r3, #2
	addne	r3, r3, #4
	b	.L112
.L100:
	cmp	r2, #1
	ldrb	r2, [r3, #-2]
	beq	.L114
	cmp	r2, #0
	bne	.L105
	ldrb	r2, [r3, #-1]
	cmp	r2, #0
	bne	.L105
	rsb	r0, r0, r3
	sub	r0, r0, #2
	ldmfd	sp, {fp, sp, pc}
.L114:
	cmp	r2, #0
	bne	.L105
	ldrb	r2, [r3, #-1]
	cmp	r2, #0
	bne	.L105
	rsb	r3, r0, r3
	sub	r0, r3, #2
	ldmfd	sp, {fp, sp, pc}
.L107:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Mp4SearchStartCode, .-Mp4SearchStartCode
	.align	2
	.global	Mp4_Syntax_Gop
	.type	Mp4_Syntax_Gop, %function
Mp4_Syntax_Gop:
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
	mov	r4, r0
	sub	r0, fp, #60
	bl	BsInit
	mov	r1, #32
	sub	r0, fp, #60
	bl	BsSkip
	mov	r1, #5
	sub	r0, fp, #60
	bl	BsGet
	mov	r1, #6
	sub	r0, fp, #60
	bl	BsGet
	sub	r0, fp, #60
	mov	r1, #1
	bl	BsGet
	subs	r6, r0, #0
	bne	.L116
	add	r4, r4, #20480
	ldr	r1, .L119
	mov	r0, #1
	bl	dprint_vfmw
	strb	r6, [r4, #1574]
	sub	r0, fp, #60
	bl	BsPos
	ldr	r3, .L119+4
	ldr	ip, [r3]
	cmp	ip, #0
	mov	r5, r0
	beq	.L117
	ldr	r0, [r4, #2496]
	mov	r3, r6
	mov	r2, r6
	mov	r1, #103
	blx	ip
	mov	r0, r5
.L117:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L116:
	mov	r1, #6
	sub	r0, fp, #60
	bl	BsGet
	mov	r1, #1
	sub	r0, fp, #60
	add	r4, r4, #20480
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #806]
	sub	r0, fp, #60
	bl	BsGet
	mov	r3, #1
	strb	r3, [r4, #1574]
	strb	r0, [r4, #807]
	sub	r0, fp, #60
	bl	BsPos
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L120:
	.align	2
.L119:
	.word	.LC0
	.word	g_event_report
	.fnend
	.size	Mp4_Syntax_Gop, .-Mp4_Syntax_Gop
	.align	2
	.global	Mp4_Syntax_UserData
	.type	Mp4_Syntax_UserData, %function
Mp4_Syntax_UserData:
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
	cmp	r2, #6
	mov	r3, #0
	mov	r4, r0
	str	r3, [fp, #-60]
	str	r3, [fp, #-56]
	str	r3, [fp, #-52]
	str	r3, [fp, #-48]
	strb	r3, [fp, #-61]
	ble	.L122
	cmp	r2, #4
	ble	.L123
	mov	r5, r0
	ldrb	r0, [r1, #4]!
	mov	ip, #4
	movw	r7, #1030
	mvn	r3, r0, asl #24
	strb	r0, [r5, #3]!
	mvn	r3, r3, lsr #24
	mov	r0, r5
	mov	r3, r3, asl #8
	b	.L124
.L129:
	ldrb	lr, [r1, #1]!
	orr	r3, r3, lr
	mov	r3, r3, asl #8
	cmp	r3, #256
	beq	.L183
	cmp	ip, r7
	strb	lr, [r0, #1]!
	beq	.L184
.L124:
	sub	r6, ip, #3
	add	ip, ip, #1
	cmp	ip, r2
	bne	.L129
.L180:
	add	r8, r4, #20480
	cmp	r6, #2
	mov	r3, #1
	mov	r10, r6
	mov	r7, r2, asl #3
	strb	r3, [r8, #1578]
	bhi	.L185
.L161:
	mov	r0, r7
.L179:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L122:
	add	r4, r0, #20480
	add	r7, r2, #1
	strb	r3, [r4, #1578]
	mov	r0, r7, asl #3
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L183:
	sub	ip, ip, #2
	cmp	r2, ip
	bge	.L186
.L128:
	add	r7, r2, #1
	mov	r0, r7, asl #3
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L185:
	add	r1, r4, #22528
	ldr	r2, [r8, #2108]
	add	r1, r1, #68
	ldr	r0, [r8, #2496]
	bl	Mp4_GetUserDataBuf
	ldr	r9, .L190
	cmp	r0, #0
	str	r0, [r8, #2132]
	beq	.L132
	cmn	r6, #-2147483648
	ldr	r3, [r9, #52]
	sub	r6, r6, #2
	str	r6, [r0, #1052]
	movpl	r2, #0
	ldr	r0, [r8, #2132]
	bmi	.L187
.L133:
	mov	r1, r5
	blx	r3
	ldr	r1, .L190+4
	ldr	r2, [r8, #1596]
	ldr	r3, [r8, #2132]
	ldr	ip, [r1]
	ldrd	r0, [r2, #56]
	add	r3, r3, #1056
	cmp	ip, #0
	strd	r0, [r3]
	beq	.L132
	movw	r3, #1064
	ldr	r2, [r8, #2132]
	mov	r1, #6
	ldr	r0, [r8, #2496]
	blx	ip
.L132:
	cmn	r6, #-2147483646
	movpl	r6, #0
	bmi	.L188
.L134:
	add	r6, r4, r6
	mov	r2, #0
	sub	r0, fp, #61
	sub	r3, fp, #56
	strb	r2, [r6, #3]
	sub	r2, fp, #60
	str	r0, [sp]
	mov	r0, r5
	ldr	ip, [r9, #72]
	ldr	r1, .L190+8
	blx	ip
	ldr	r2, .L190
	cmp	r0, #1
	ble	.L189
.L135:
	ldr	r3, [fp, #-56]
	cmp	r0, #3
	ldr	r2, [fp, #-60]
	str	r3, [r8, #1556]
	movne	r3, #0
	ldreqsb	r3, [fp, #-61]
	str	r2, [r8, #1552]
	subeq	r3, r3, #112
	clzeq	r3, r3
	moveq	r3, r3, lsr #5
	str	r3, [r8, #1560]
.L136:
	ldr	r3, [r9, #72]
	sub	r2, fp, #56
	ldr	r1, .L190+12
	mov	r0, r5
	blx	r3
	ldr	r4, .L190
	cmp	r0, #1
	beq	.L138
	sub	r3, fp, #56
	sub	r6, fp, #48
	str	r3, [sp, #4]
	sub	r2, fp, #60
	ldr	ip, [r4, #72]
	sub	r3, fp, #52
	str	r6, [sp]
	mov	r0, r5
	ldr	r1, .L190+16
	blx	ip
	cmp	r0, #4
	beq	.L138
	str	r6, [sp]
	sub	r3, fp, #52
	ldr	ip, [r4, #72]
	sub	r2, fp, #60
	ldr	r1, .L190+20
	mov	r0, r5
	blx	ip
	add	r0, r0, #1
	cmp	r0, #1
	ble	.L139
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-60]
	ldr	r1, [fp, #-48]
	mov	r2, r2, asl #8
	add	r3, r2, r3, lsl #16
	add	r3, r3, r1
	str	r3, [fp, #-56]
.L139:
	cmp	r0, #4
	beq	.L138
	ldr	r3, [r9, #76]
	mov	r2, #7
	ldr	r1, .L190+24
	mov	r0, r5
	blx	r3
	cmp	r0, #0
	movweq	r3, #4600
	streq	r3, [r8, #1568]
.L150:
	sub	r2, fp, #56
	ldr	r3, [r9, #72]
	ldr	r1, .L190+28
	mov	r0, r5
	blx	r3
	mov	r3, #0
	ldr	r1, [r8, #1552]
	strb	r3, [r8, #817]
	strb	r3, [r8, #818]
	strb	r3, [r8, #815]
	strb	r3, [r8, #814]
	strb	r3, [r8, #816]
	cmp	r0, #1
	ldreq	r2, [fp, #-56]
	ldrne	r2, [r8, #1564]
	streq	r2, [r8, #1564]
	cmp	r2, #0
	beq	.L143
	cmp	r1, r3
	strne	r3, [r8, #1552]
	strne	r3, [r8, #1556]
	cmp	r2, #1
	mvnne	r0, #0
	movne	r1, #0
	beq	.L182
.L153:
	movw	r3, #502
	cmp	r1, r3
	bls	.L145
.L152:
	mov	r3, #1
	strb	r3, [r8, #818]
.L145:
	sub	r2, r2, #1
	cmp	r2, #11
	bhi	.L146
.L154:
	mov	r3, #1
	strb	r3, [r8, #815]
.L146:
	ldr	r3, [r8, #1568]
	movw	r2, #4668
	sub	r3, r3, #1
	cmp	r3, r2
	movls	r3, #1
	strlsb	r3, [r8, #815]
	movw	r3, #498
	cmp	r0, r3
	movls	r3, #1
	strlsb	r3, [r8, #815]
	cmp	r1, #500
	bne	.L161
	ldr	r2, [r8, #1556]
	movw	r3, #413
	mov	r0, r7
	cmp	r2, r3
	moveq	r3, #1
	streqb	r3, [r8, #816]
	b	.L179
.L184:
	add	r4, r4, #20480
	mov	r3, #0
	movw	r0, #8224
	strb	r3, [r4, #1578]
	b	.L179
.L138:
	ldr	r3, [fp, #-56]
	str	r3, [r8, #1568]
	b	.L150
.L187:
	cmp	r10, #1024
	movlt	r2, r10
	movge	r2, #1024
	b	.L133
.L143:
	cmp	r1, #500
	subcs	r0, r1, #1
	movcs	r3, #1
	strcsb	r3, [r8, #817]
	bcs	.L153
	movw	r3, #502
	cmp	r1, r3
	sub	r0, r1, #1
	bhi	.L152
	b	.L146
.L188:
	add	r6, r6, #2
	cmp	r6, #1024
	movge	r6, #1024
	b	.L134
.L123:
	cmp	r2, #3
	ble	.L128
	add	r4, r4, #20480
	mov	r3, #1
	mov	r0, #32
	strb	r3, [r4, #1578]
	b	.L179
.L186:
	mov	r2, ip
	b	.L180
.L189:
	sub	r3, fp, #61
	ldr	r1, .L190+32
	str	r3, [sp]
	mov	r0, r5
	ldr	ip, [r2, #72]
	sub	r3, fp, #56
	sub	r2, fp, #60
	blx	ip
	cmp	r0, #1
	ble	.L136
	b	.L135
.L182:
	strb	r2, [r8, #817]
	mvn	r0, #0
	mov	r1, #0
	b	.L154
.L191:
	.align	2
.L190:
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_event_report
	.word	.LC1
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC2
	.fnend
	.size	Mp4_Syntax_UserData, .-Mp4_Syntax_UserData
	.align	2
	.global	Mp4_Syntax_Vo
	.type	Mp4_Syntax_Vo, %function
Mp4_Syntax_Vo:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #32
	sub	sp, sp, #32
	push	{lr}
	bl	__gnu_mcount_nc
	add	r4, r0, #20480
	mov	r5, r0
	sub	r0, fp, #60
	mov	r7, r2
	mov	r6, #1
	bl	BsInit
	mov	r3, #0
	mov	r1, #32
	strb	r3, [r4, #820]
	sub	r0, fp, #60
	strb	r3, [r4, #822]
	add	r5, r5, #16384
	strb	r3, [r4, #823]
	strb	r3, [r4, #824]
	strb	r3, [r4, #825]
	strb	r3, [r4, #826]
	strb	r3, [r4, #827]
	str	r3, [r4, #832]
	str	r3, [r4, #836]
	str	r3, [r4, #840]
	strb	r6, [r4, #821]
	bl	BsSkip
	mov	r1, r6
	sub	r0, fp, #60
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r5, #3608]
	cmp	r0, #0
	streqb	r6, [r5, #3609]
	bne	.L207
.L194:
	mov	r1, #4
	sub	r0, fp, #60
	bl	BsGet
	uxtb	r6, r0
	strb	r6, [r5, #3611]
	cmp	r6, #1
	beq	.L208
	mov	r6, #0
	sub	r0, fp, #60
	strb	r6, [r4, #1573]
	bl	BsPos
	ldr	r3, .L210
	ldr	ip, [r3]
	cmp	ip, r6
	mov	r5, r0
	beq	.L198
	ldr	r0, [r4, #2496]
	mov	r3, r6
	mov	r2, r6
	mov	r1, #102
	blx	ip
	mov	r0, r5
.L198:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L207:
	mov	r1, #4
	sub	r0, fp, #60
	bl	BsGet
	mov	r1, #3
	strb	r0, [r5, #3609]
	sub	r0, fp, #60
	bl	BsGet
	strb	r0, [r5, #3610]
	b	.L194
.L208:
	mov	r1, r6
	sub	r0, fp, #60
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r5, #3612]
	cmp	r0, #0
	bne	.L209
.L197:
	mov	r3, #1
	sub	r0, fp, #60
	strb	r3, [r4, #1573]
	bl	BsPos
	cmp	r0, r7, asl #3
	bgt	.L199
	ldrb	r3, [r5, #3608]
	strb	r3, [r4, #820]
	ldrb	r3, [r5, #3609]
	strb	r3, [r4, #821]
	ldrb	r3, [r5, #3610]
	strb	r3, [r4, #822]
	ldrb	r3, [r5, #3611]
	strb	r3, [r4, #823]
	ldrb	r3, [r5, #3612]
	strb	r3, [r4, #824]
	ldrb	r3, [r5, #3613]
	strb	r3, [r4, #825]
	ldrb	r3, [r5, #3614]
	strb	r3, [r4, #826]
	ldrb	r3, [r5, #3615]
	strb	r3, [r4, #827]
	ldr	r3, [r5, #3620]
	str	r3, [r4, #832]
	ldr	r3, [r5, #3624]
	str	r3, [r4, #836]
	ldr	r3, [r5, #3628]
	str	r3, [r4, #840]
.L199:
	sub	r0, fp, #60
	bl	BsPos
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L209:
	mov	r1, #3
	sub	r0, fp, #60
	bl	BsGet
	mov	r1, r6
	strb	r0, [r5, #3613]
	sub	r0, fp, #60
	bl	BsGet
	mov	r1, r6
	strb	r0, [r5, #3614]
	sub	r0, fp, #60
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r5, #3615]
	cmp	r0, #0
	beq	.L197
	mov	r1, #8
	sub	r0, fp, #60
	bl	BsGet
	mov	r1, #8
	str	r0, [r5, #3620]
	sub	r0, fp, #60
	bl	BsGet
	mov	r1, #8
	str	r0, [r5, #3624]
	sub	r0, fp, #60
	bl	BsGet
	str	r0, [r5, #3628]
	b	.L197
.L211:
	.align	2
.L210:
	.word	g_event_report
	.fnend
	.size	Mp4_Syntax_Vo, .-Mp4_Syntax_Vo
	.align	2
	.global	Mp4_Syntax_Vol
	.type	Mp4_Syntax_Vol, %function
Mp4_Syntax_Vol:
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
	add	r5, r0, #20480
	mov	r6, r0
	ldr	r3, .L374
	add	r7, r6, #19968
	ldr	r0, [r5, #2496]
	add	r7, r7, #48
	ldr	r8, .L374+4
	add	r4, r6, #16384
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	ldrne	r0, [r3, #1260]
	moveq	r9, #8192
	ldrne	r9, [r3, #1264]
	streq	r9, [fp, #-80]
	strne	r0, [fp, #-80]
	sub	r0, fp, #76
	bl	BsInit
	ldr	r3, [r8, #48]
	mov	r2, #604
	mov	r1, #0
	mov	r0, r7
	strb	r1, [r5, #805]
	blx	r3
	mov	r1, #32
	sub	r0, fp, #76
	bl	BsSkip
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, #8
	strb	r0, [r4, #3636]
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, #1
	str	r0, [r4, #3660]
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #3632]
	cmp	r0, #0
	ldreqb	r3, [r5, #821]
	streqb	r3, [r4, #3633]
	bne	.L363
.L215:
	mov	r1, #4
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #3635]
	cmp	r0, #15
	beq	.L364
.L216:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #3637]
	cmp	r0, #0
	moveq	r3, #1
	streqb	r3, [r4, #3638]
	bne	.L365
.L221:
	mov	r1, #2
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r10, r0
	strb	r10, [r4, #3640]
	cmp	r10, #0
	subne	r0, fp, #76
	movne	r6, #0
	beq	.L366
.L357:
	strb	r6, [r5, #1575]
	bl	BsPos
	ldr	r3, .L374+8
	ldr	ip, [r3]
	cmp	ip, r6
	mov	r4, r0
	beq	.L292
	ldr	r0, [r5, #2496]
	mov	r3, r6
	mov	r2, r6
	mov	r1, #102
	blx	ip
	mov	r0, r4
.L327:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L366:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	subs	r3, r0, #0
	beq	.L342
	mov	r1, #16
	sub	r0, fp, #76
	bl	BsGet
	cmp	r0, #0
	str	r0, [r4, #3704]
	beq	.L229
	subs	r0, r0, #1
	beq	.L229
	mov	r2, r10
	mov	r3, r0
.L231:
	add	r2, r2, #1
	movs	r3, r3, lsr #1
	uxth	r2, r2
	bne	.L231
	sxth	r2, r2
	cmp	r2, #0
	ble	.L229
.L233:
	add	r3, r3, #1
	movs	r0, r0, lsr #1
	uxth	r3, r3
	bne	.L233
	sxth	r3, r3
.L329:
	str	r3, [r4, #3700]
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	subs	r3, r0, #0
	beq	.L342
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #3641]
	cmp	r0, #0
	bne	.L367
.L236:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	subs	r3, r0, #0
	beq	.L342
	mov	r1, #13
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, #1
	str	r0, [r4, #3712]
	sub	r0, fp, #76
	bl	BsGet
	subs	r3, r0, #0
	beq	.L342
	mov	r1, #13
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, #1
	str	r0, [r4, #3716]
	sub	r0, fp, #76
	bl	BsGet
	subs	r3, r0, #0
	beq	.L342
	ldr	r3, [r4, #3712]
	cmp	r3, #31
	bls	.L240
	ldr	r2, [r4, #3716]
	cmp	r2, #31
	bls	.L240
	mul	r3, r3, r2
	ldr	r2, [fp, #-80]
	mul	r9, r9, r2
	cmp	r3, r9
	bls	.L241
.L240:
	mov	r6, #0
	sub	r0, fp, #76
	strb	r6, [r5, #1575]
	bl	BsPos
	ldr	r3, .L374+8
	ldr	ip, [r3]
	cmp	ip, r6
	mov	r4, r0
	beq	.L292
.L336:
	ldr	r0, [r5, #2496]
	mov	r3, r6
	mov	r2, r6
	mov	r1, #103
	blx	ip
	mov	r0, r4
	b	.L327
.L342:
	ldr	r1, .L374+12
	mov	r0, #1
	str	r3, [fp, #-80]
.L344:
	bl	dprint_vfmw
	ldr	r3, [fp, #-80]
	sub	r0, fp, #76
	strb	r3, [r5, #1575]
	bl	BsPos
	ldr	r2, .L374+8
	ldr	ip, [r2]
	cmp	ip, #0
	mov	r4, r0
	beq	.L292
	ldr	r3, [fp, #-80]
	mov	r1, #103
	ldr	r0, [r5, #2496]
	mov	r2, r3
	blx	ip
	mov	r0, r4
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L365:
	mov	r1, #2
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r10, r0
	strb	r10, [r4, #3638]
	cmp	r10, #1
	beq	.L218
	mov	r3, #0
	sub	r0, fp, #76
	strb	r3, [r5, #1575]
	bl	BsPos
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L363:
	mov	r1, #4
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, #3
	strb	r0, [r4, #3633]
	sub	r0, fp, #76
	bl	BsGet
	strb	r0, [r4, #3634]
	b	.L215
.L218:
	mov	r1, r10
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, r10
	strb	r0, [r4, #3639]
	sub	r0, fp, #76
	bl	BsGet
	cmp	r0, #0
	str	r0, [r4, #3672]
	beq	.L221
	mov	r1, #15
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, r10
	str	r0, [r4, #3676]
	sub	r0, fp, #76
	bl	BsGet
	subs	r3, r0, #0
	beq	.L359
	mov	r1, #15
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, r10
	str	r0, [r4, #3680]
	sub	r0, fp, #76
	bl	BsGet
	subs	r3, r0, #0
	beq	.L359
	mov	r1, #15
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, r10
	str	r0, [r4, #3684]
	sub	r0, fp, #76
	bl	BsGet
	subs	r3, r0, #0
	beq	.L359
	mov	r1, #3
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, #11
	str	r0, [r4, #3688]
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, r10
	str	r0, [r4, #3692]
	sub	r0, fp, #76
	bl	BsGet
	subs	r3, r0, #0
	beq	.L359
	mov	r1, #15
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, r10
	str	r0, [r4, #3696]
	sub	r0, fp, #76
	bl	BsGet
	subs	r3, r0, #0
	str	r3, [fp, #-84]
	bne	.L221
	ldr	r1, .L374+12
	mov	r0, r10
	bl	dprint_vfmw
	ldr	r6, [fp, #-84]
	sub	r0, fp, #76
	strb	r6, [r5, #1575]
	bl	BsPos
	ldr	r3, .L374+8
	ldr	ip, [r3]
	cmp	ip, #0
	mov	r4, r0
	bne	.L336
.L292:
	mov	r0, r4
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L364:
	mov	r1, #8
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, #8
	str	r0, [r4, #3664]
	sub	r0, fp, #76
	bl	BsGet
	str	r0, [r4, #3668]
	b	.L216
.L229:
	mov	r3, #1
	b	.L329
.L359:
	str	r3, [fp, #-80]
	mov	r0, r10
	ldr	r1, .L374+12
	b	.L344
.L367:
	ldr	r1, [r4, #3700]
	sub	r0, fp, #76
	bl	BsGet
	str	r0, [r4, #3708]
	b	.L236
.L241:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #3642]
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r3, r0
	strb	r3, [r4, #3643]
	cmp	r3, #0
	bne	.L243
	ldr	r2, .L374+8
	strb	r3, [r5, #1575]
	ldr	ip, [r2]
	cmp	ip, #0
	beq	.L243
	mov	r2, r3
	mov	r1, #102
	ldr	r0, [r5, #2496]
	blx	ip
.L243:
	ldrb	r3, [r4, #3633]
	sub	r0, fp, #76
	cmp	r3, #1
	moveq	r1, #1
	movne	r1, #2
	bl	BsGet
	uxtb	r9, r0
	strb	r9, [r4, #3644]
	cmp	r9, #0
	beq	.L246
	ldr	r3, .L374+16
	ldr	r10, [r3]
	ands	r10, r10, #8
	beq	.L368
	sub	r3, r9, #1
	cmp	r3, #1
	bls	.L369
	mov	r6, #0
	sub	r0, fp, #76
	strb	r6, [r5, #1575]
	bl	BsPos
	ldr	r3, .L374+8
	ldr	ip, [r3]
	cmp	ip, r6
	mov	r4, r0
	beq	.L253
	ldr	r0, [r5, #2496]
	mov	r3, r6
	mov	r2, r6
	mov	r1, #102
	blx	ip
.L253:
	ldr	r1, .L374+20
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	b	.L327
.L370:
	mov	r1, #6
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, r9
	strb	r0, [r4, #3656]
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #3657]
	sub	r0, fp, #76
	bl	BsGet
	ldrb	r3, [r4, #3644]
	cmp	r3, #2
	strb	r0, [r4, #3658]
	bne	.L361
.L246:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #3645]
	cmp	r0, #0
	beq	.L254
	mov	r6, #0
	sub	r0, fp, #76
	strb	r6, [r5, #1575]
	bl	BsPos
	ldr	r3, .L374+8
	ldr	ip, [r3]
	cmp	ip, r6
	mov	r4, r0
	beq	.L255
	ldr	r0, [r5, #2496]
	mov	r3, r6
	mov	r2, r6
	mov	r1, #102
	blx	ip
.L255:
	ldr	r1, .L374+24
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	b	.L327
.L369:
	cmp	r9, #2
	beq	.L370
.L361:
	mov	r6, #0
	sub	r0, fp, #76
	strb	r6, [r5, #1575]
	bl	BsPos
	ldr	r3, .L374+8
	ldr	ip, [r3]
	cmp	ip, r6
	mov	r4, r0
	beq	.L252
	ldr	r0, [r5, #2496]
	mov	r3, r6
	mov	r2, r6
	mov	r1, #102
	blx	ip
.L252:
	ldr	r1, .L374+28
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	b	.L327
.L254:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #3646]
	cmp	r0, #0
	bne	.L371
.L257:
	ldrb	r3, [r4, #3633]
	cmp	r3, #1
	moveq	r3, #0
	streqb	r3, [r4, #3649]
	beq	.L264
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	strb	r0, [r4, #3649]
.L264:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r9, r0
	strb	r9, [r4, #3650]
	cmp	r9, #0
	ldreq	r1, .L374+32
	beq	.L353
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #3651]
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r10, r0
	strb	r10, [r4, #3652]
	cmp	r10, #0
	ldrne	r1, .L374+36
	bne	.L355
	ldrb	r3, [r4, #3633]
	cmp	r3, #1
	beq	.L267
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r9, r0
	strb	r9, [r4, #3653]
	cmp	r9, #0
	beq	.L268
	ldr	r1, .L374+40
	mov	r0, #1
	bl	dprint_vfmw
	strb	r10, [r5, #1575]
	sub	r0, fp, #76
	bl	BsPos
	ldr	r3, .L374+8
	ldr	ip, [r3]
	cmp	ip, #0
	mov	r4, r0
	beq	.L292
	ldr	r0, [r5, #2496]
	mov	r3, r10
	mov	r2, r10
	mov	r1, #102
	blx	ip
	mov	r0, r4
	b	.L327
.L368:
	strb	r10, [r5, #1575]
	sub	r0, fp, #76
	bl	BsPos
	ldr	r3, .L374+8
	ldr	ip, [r3]
	cmp	ip, #0
	mov	r4, r0
	beq	.L248
	ldr	r0, [r5, #2496]
	mov	r3, r10
	mov	r2, r10
	mov	r1, #102
	blx	ip
.L248:
	ldr	r1, .L374+44
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	b	.L327
.L371:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #3647]
	cmp	r0, #0
	bne	.L372
	add	r3, r6, #19968
	add	r1, r6, #20224
	ldr	r2, .L374+48
	add	r3, r3, #132
	add	r1, r1, #132
.L260:
	ldr	r0, [r2, #4]!
	str	r0, [r3, #4]!
	cmp	r3, r1
	bne	.L260
.L259:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #3648]
	cmp	r0, #0
	bne	.L272
	add	r3, r6, #20224
	add	r1, r6, #20480
	ldr	r2, .L374+52
	add	r3, r3, #132
	add	r1, r1, #132
.L261:
	ldr	r0, [r2, #4]!
	str	r0, [r3, #4]!
	cmp	r3, r1
	bne	.L261
	b	.L257
.L373:
	ldr	r1, .L374+56
.L353:
	mov	r0, #1
	bl	dprint_vfmw
	strb	r9, [r5, #1575]
	sub	r0, fp, #76
	bl	BsPos
	ldr	r3, .L374+8
	ldr	ip, [r3]
	cmp	ip, #0
	mov	r4, r0
	beq	.L292
	ldr	r0, [r5, #2496]
	mov	r3, r9
	mov	r2, r9
	mov	r1, #102
	blx	ip
	mov	r0, r4
	b	.L327
.L268:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #3654]
	cmp	r0, #0
	bne	.L373
.L269:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #3655]
	cmp	r0, #0
	beq	.L270
	ldr	r1, .L374+60
.L355:
	mov	r0, #1
	mov	r6, #0
	bl	dprint_vfmw
	sub	r0, fp, #76
	b	.L357
.L372:
	add	r1, r6, #19968
	sub	r0, fp, #76
	add	r1, r1, #136
	bl	Bs_Get_Matrix
	b	.L259
.L272:
	add	r1, r6, #20224
	sub	r0, fp, #76
	add	r1, r1, #136
	bl	Bs_Get_Matrix
	b	.L257
.L267:
	strb	r10, [r4, #3653]
	strb	r10, [r4, #3654]
	b	.L269
.L270:
	add	r0, r6, #20480
	mov	r3, #1
	ldr	ip, [r8, #52]
	mov	r1, r7
	mov	r2, #604
	strb	r3, [r5, #1575]
	strb	r3, [r5, #805]
	add	r0, r0, #140
	strb	r3, [r5, #1576]
	blx	ip
	sub	r0, fp, #76
	bl	BsPos
	b	.L327
.L375:
	.align	2
.L374:
	.word	s_pstVfmwChan
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_event_report
	.word	.LC8
	.word	g_VdmCharacter
	.word	.LC11
	.word	.LC12
	.word	.LC10
	.word	.LC13
	.word	.LC14
	.word	.LC15
	.word	.LC9
	.word	.LANCHOR1-4
	.word	.LANCHOR1+252
	.word	.LC16
	.word	.LC17
	.fnend
	.size	Mp4_Syntax_Vol, .-Mp4_Syntax_Vol
	.align	2
	.global	Mp4_Syntax_Vos
	.type	Mp4_Syntax_Vos, %function
Mp4_Syntax_Vos:
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
	add	r5, r0, #20480
	add	r4, r0, #16384
	sub	r0, fp, #52
	bl	BsInit
	mov	r3, #0
	mov	r1, #32
	str	r3, [r5, #828]
	sub	r0, fp, #52
	bl	BsSkip
	sub	r0, fp, #52
	mov	r1, #8
	bl	BsGet
	sub	r3, r0, #1
	sub	r2, r0, #240
	cmp	r2, #5
	cmphi	r3, #2
	str	r0, [r4, #3616]
	movls	r3, #1
	movhi	r3, #0
	cmp	r0, #8
	orreq	r3, r3, #1
	cmp	r3, #0
	strne	r0, [r5, #828]
	movne	r3, #1
	strneb	r3, [r5, #1572]
	bne	.L378
	cmp	r0, #0
	beq	.L383
	ldr	r2, .L384
	strb	r3, [r5, #1572]
	ldr	ip, [r2]
	cmp	ip, #0
	beq	.L378
	ldr	r0, [r5, #2496]
	mov	r2, r3
	mov	r1, #102
	blx	ip
.L378:
	sub	r0, fp, #52
	bl	BsPos
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L383:
	mov	r2, r0
	ldr	r1, .L384+4
	mov	r0, #1
	bl	dprint_vfmw
	mov	r3, #1
	strb	r3, [r5, #1572]
	ldr	r3, [r4, #3616]
	str	r3, [r5, #828]
	b	.L378
.L385:
	.align	2
.L384:
	.word	g_event_report
	.word	.LC18
	.fnend
	.size	Mp4_Syntax_Vos, .-Mp4_Syntax_Vos
	.align	2
	.global	Frame_Init
	.type	Frame_Init, %function
Frame_Init:
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
	add	r4, r0, #20480
	mov	r6, r1
	mov	r7, r2
	ldr	lr, [r4, #1596]
	ldr	r5, [lr, #700]
	ldr	r3, [lr, #28]
	cmp	r5, #0
	bne	.L387
	cmp	r3, #25
	beq	.L418
.L411:
	mov	r5, #2
	mov	r9, #5
	mov	r10, #3
.L388:
	ldr	r3, [lr, #824]
	cmp	r3, #1
	beq	.L399
	ldr	r3, .L421
	ldr	ip, [r3, #52]
	cmp	ip, #0
	beq	.L401
	ldr	r8, .L421+4
	mov	r2, #0
	ldr	r1, [lr, #24]
	ldr	r0, [lr, #20]
	mov	lr, #2
	str	r8, [sp, #16]
	ldr	r3, [r4, #2496]
	str	r2, [sp, #8]
	mov	r2, r6
	str	lr, [sp]
	str	r3, [sp, #12]
	mov	r3, #40
	str	r3, [sp, #4]
	mov	r3, r7
	blx	ip
	cmp	r0, #0
	bne	.L401
	ldr	r2, [r8, #1120]
	ldr	r3, [r8, #952]
	cmp	r2, #1
	ble	.L403
	cmp	r3, #2
	ble	.L403
	ldr	r0, [r8, #8]
	str	r0, [r4, #1616]
	bl	MEM_Phy2Vir
	str	r0, [r4, #1604]
.L399:
	ldr	r3, .L421+8
	mov	r2, #32
	mov	r1, #0
	sub	r0, fp, #76
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r2, [r4, #1596]
	str	r7, [fp, #-48]
	mov	r3, #0
	str	r6, [fp, #-68]
	ldr	r2, [r2, #28]
	str	r7, [fp, #-64]
	cmp	r2, #24
	str	r6, [fp, #-52]
	strb	r3, [fp, #-75]
	beq	.L405
	uxtb	r5, r5
	strb	r10, [fp, #-73]
	strb	r9, [fp, #-71]
.L408:
	sub	r1, fp, #76
	ldr	r0, [r4, #2496]
	strb	r5, [fp, #-70]
	mov	r6, #0
	strb	r6, [fp, #-74]
	bl	FSP_ConfigInstance
	subs	r5, r0, #0
	bne	.L406
	ldr	r1, [r4, #1596]
	sub	r3, fp, #80
	ldr	r0, [r4, #2496]
	ldr	r2, [r1, #24]
	ldr	r1, [r1, #20]
	bl	FSP_ConfigFrameBuf
	cmp	r0, r6
	moveq	r3, #1
	streq	r3, [r4, #2500]
	bne	.L419
.L414:
	mov	r0, r5
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L387:
	cmp	r3, #25
	bne	.L411
	ldr	r2, [lr, #660]
	ldr	r3, [lr, #664]
	cmp	r1, r2
	bhi	.L395
	cmp	r7, r3
	bhi	.L395
	ldr	r3, [lr, #688]
	ldr	r5, [lr, #684]
	cmp	r3, #0
	add	r10, r5, #2
	moveq	r5, #1
	bne	.L420
	ldr	r9, [lr, #708]
	b	.L388
.L405:
	mov	r5, #1
	strb	r9, [fp, #-71]
	strb	r5, [fp, #-73]
	b	.L408
.L418:
	ldr	r2, [lr, #660]
	cmp	r2, r1
	ldrcc	r1, [lr, #664]
	bcc	.L390
	ldr	r3, [lr, #664]
	cmp	r3, r7
	mov	r1, r3
	bcc	.L390
	ldr	r1, [r4, #2500]
	cmp	r1, #1
	beq	.L414
	ldr	r1, [lr, #688]
	ldr	r5, [lr, #684]
	cmp	r1, #0
	add	r10, r5, #2
	moveq	r5, #1
	beq	.L393
	add	r5, r5, #1
	cmp	r5, #17
	movge	r5, #17
.L393:
	mov	r7, r3
	mov	r6, r2
	ldr	r9, [lr, #708]
	b	.L388
.L420:
	add	r5, r5, #1
	ldr	r9, [lr, #708]
	cmp	r5, #17
	movge	r5, #17
	b	.L388
.L403:
	ldr	r1, .L421+12
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r5, #0
	b	.L414
.L401:
	ldr	r1, .L421+16
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r5, #0
	b	.L414
.L406:
	mov	r0, r6
	ldr	r1, .L421+20
	bl	dprint_vfmw
	mvn	r5, #0
	b	.L414
.L395:
	str	r3, [sp, #4]
.L417:
	str	r2, [sp]
	mov	r3, r7
	mov	r2, r6
	ldr	r1, .L421+24
	mov	r0, #0
	mvn	r5, #0
	bl	dprint_vfmw
	b	.L414
.L419:
	mov	r0, r5
	ldr	r1, .L421+28
	bl	dprint_vfmw
	str	r5, [r4, #2500]
	mvn	r5, #0
	b	.L414
.L390:
	str	r1, [sp, #4]
	b	.L417
.L422:
	.align	2
.L421:
	.word	g_vdm_hal_fun_ptr
	.word	.LANCHOR2
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC21
	.word	.LC20
	.word	.LC23
	.word	.LC19
	.word	.LC22
	.fnend
	.size	Frame_Init, .-Frame_Init
	.align	2
	.global	Mp4_RecordVFMWState
	.type	Mp4_RecordVFMWState, %function
Mp4_RecordVFMWState:
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
	.size	Mp4_RecordVFMWState, .-Mp4_RecordVFMWState
	.global	__aeabi_uidiv
	.align	2
	.global	Mp4_RecordFrameAtr
	.type	Mp4_RecordFrameAtr, %function
Mp4_RecordFrameAtr:
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
	add	r5, r0, #20480
	str	r0, [fp, #-52]
	mov	r4, r1
	ldrb	r3, [r5, #847]
	cmp	r3, #15
	beq	.L442
	sub	r2, r3, #2
	cmp	r2, #1
	bls	.L435
	sub	r2, r3, #4
	cmp	r2, #1
	bls	.L436
	cmp	r3, #1
	moveq	r3, #5
	movne	r3, #0
	str	r3, [fp, #-48]
.L426:
	mov	r1, r4
	ldr	r0, [r5, #2496]
	bl	FSP_GetFsImagePtr
	subs	r4, r0, #0
	beq	.L424
	ldr	r3, [r5, #1512]
	ldr	r1, [fp, #-48]
	str	r3, [r4, #112]
	ldr	r3, [r5, #1508]
	str	r3, [r4, #116]
	bl	SetAspectRatio
	ldr	r3, [r5, #1596]
	ldr	r3, [r3, #28]
	cmp	r3, #25
	beq	.L443
.L430:
	ldr	r2, [r5, #1512]
	mov	r8, #0
	ldr	r3, [fp, #-52]
	add	lr, r4, #552
	mov	ip, r8
	str	r2, [r4, #120]
	add	r6, r3, #22528
	ldr	r2, [r5, #1508]
	add	r6, r6, #64
	add	r3, r4, #520
	str	r2, [r4, #124]
	ldr	r2, [r5, #1512]
	mov	r2, r2, lsr #1
	str	r2, [r4, #128]
	ldr	r2, [r5, #1508]
	mov	r2, r2, lsr #1
	str	r2, [r4, #132]
	ldr	r2, [r5, #2076]
	str	r2, [r4, #168]
	ldr	r2, [r5, #2072]
	str	r2, [r4, #164]
	ldrb	r0, [r5, #825]
	ldrb	r2, [r5, #1448]
	ldrb	r9, [r5, #1453]
	ldrb	r1, [r5, #854]
	and	r2, r2, #3
	mov	r0, r0, asl #5
	orr	r2, r2, r9, asl #12
	and	r1, r1, #1
	uxtb	r0, r0
	orr	r2, r2, #3072
	orr	r2, r2, r0
	orr	r1, r2, r1, asl #8
	ldr	r2, [fp, #-48]
	orr	r7, r1, r2, asl #14
	str	r7, [r4, #108]
	ldrb	r2, [r5, #1448]
	and	r2, r2, #3
	str	r2, [r4, #100]
	ldrb	r2, [r5, #1448]
	str	r8, [r4, #96]
	and	r2, r2, #3
	str	r2, [r4, #104]
.L431:
	ldr	r2, [r6, #4]!
	mov	r8, #0
	str	r2, [r3, #8]!
	cmp	r3, lr
	str	ip, [r3, #4]
	bne	.L431
	ldr	r3, [r5, #1596]
	add	ip, r4, #576
	add	lr, r4, #592
	mvn	r6, #0
	mvn	r7, #0
	ldr	r1, .L444
	ldrd	r2, [r3, #56]
	mov	r0, #29
	strd	r2, [ip, #-8]
	ldr	r3, [r5, #1596]
	ldrd	r2, [r3, #72]
	strd	r2, [ip]
	ldr	r3, [r5, #1596]
	ldrd	r2, [r3, #88]
	strd	r2, [lr, #-8]
	ldr	r3, [r5, #1596]
	ldr	r3, [r3, #104]
	str	r3, [r4, #8]
	ldr	r3, [r5, #1596]
	ldr	r3, [r3, #108]
	str	r3, [r4, #12]
	ldr	r3, [r5, #1596]
	ldr	r3, [r3, #112]
	str	r3, [r4, #16]
	ldr	r3, [r5, #1596]
	ldr	r3, [r3, #128]
	str	r3, [r4, #20]
	ldr	r3, [r5, #1596]
	strd	r6, [r3, #56]
	ldrd	r6, [ip]
	ldrd	r2, [ip, #-8]
	strd	r6, [sp]
	bl	dprint_vfmw
	mov	r3, #8
	mov	r2, #2
	strb	r8, [r4, #328]
	str	r2, [r4, #340]
	mov	r2, #1
	strb	r8, [r4, #335]
	str	r3, [r4, #344]
	str	r3, [r4, #352]
	str	r3, [r4, #348]
	strb	r2, [r4, #333]
.L424:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L436:
	mov	r3, #2
	str	r3, [fp, #-48]
	b	.L426
.L435:
	mov	r3, #1
	str	r3, [fp, #-48]
	b	.L426
.L443:
	ldr	r1, [r4, #116]
	add	r9, r4, #480
	ldr	ip, [r4, #140]
	add	r1, r1, #15
	ldr	lr, [r4, #44]
	mov	r3, r1, lsr #4
	mov	r1, ip, asl #4
	add	r10, lr, ip
	mul	r1, r3, r1
	add	r8, r1, lr
	str	r8, [r4, #48]
	ldrd	r2, [r9, #-8]
	add	ip, r8, ip
	mov	r0, r8
	adds	r6, r2, r1
	adc	r7, r3, r1, asr #31
	strd	r6, [r9]
	str	r8, [r4, #32]
	add	r8, r4, #496
	str	lr, [r4, #28]
	str	ip, [r4, #40]
	str	r10, [r4, #36]
	strd	r2, [r8, #-8]
	str	lr, [r4, #60]
	bl	MEM_Phy2Vir
	mov	r3, #0
	str	r3, [r4, #500]
	ldr	r3, [r4, #32]
	str	r3, [r4, #64]
	str	r0, [r4, #496]
	b	.L430
.L442:
	ldr	r2, [r5, #876]
	ldr	r1, [r5, #880]
	cmp	r2, #0
	cmpne	r1, #0
	moveq	r3, #0
	streq	r3, [fp, #-48]
	beq	.L426
	ldr	r3, [r5, #928]
	mul	r1, r3, r1
	cmp	r1, #0
	beq	.L433
	ldr	r0, [r5, #924]
	mov	r2, r2, asl #10
	mul	r0, r0, r2
	bl	__aeabi_uidiv
	sub	r7, r0, #1360
	sub	r3, r0, #1808
	sub	r7, r7, #5
	sub	r3, r3, #12
	cmp	r7, #0
	rsblt	r7, r0, #1360
	addlt	r7, r7, #5
	cmp	r3, #0
	rsblt	r3, r0, #1808
	addlt	r3, r3, #12
	cmp	r7, r3
	movlt	r3, #1
	movge	r3, #2
	str	r3, [fp, #-48]
	b	.L426
.L433:
	str	r1, [fp, #-48]
	b	.L426
.L445:
	.align	2
.L444:
	.word	.LC24
	.fnend
	.size	Mp4_RecordFrameAtr, .-Mp4_RecordFrameAtr
	.align	2
	.global	Mp4_Frame_Atr
	.type	Mp4_Frame_Atr, %function
Mp4_Frame_Atr:
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
	add	r4, r0, #20480
	mov	r5, r0
	mov	r1, #1
	ldrb	r3, [r4, #1448]
	cmp	r3, #4
	strb	r3, [r0, #2]
	ldreq	r2, .L456
	moveq	r3, #300
	ldr	r0, [r4, #2496]
	mlaeq	r3, r3, r0, r2
	ldreq	r2, [r3, #12]
	addeq	r2, r2, #1
	streq	r2, [r3, #12]
	bl	FSP_NewLogicFs
	cmp	r0, #0
	str	r0, [r4, #2524]
	blt	.L449
	ldr	r3, [r4, #2500]
	cmp	r3, #0
	beq	.L449
	mov	r1, r0
	mov	r0, r5
	bl	Mp4_RecordFrameAtr
	mov	r3, #0
	mov	r0, r3
	str	r3, [r4, #2080]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L449:
	ldr	r1, .L456+4
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r1, [r4, #2516]
	ldr	r0, [r4, #2496]
	bl	FSP_GetFsImagePtr
	subs	r6, r0, #0
	beq	.L451
	ldr	r1, [r6, #528]
	add	r7, r6, #544
	ldr	r0, [r4, #2496]
	add	r8, r6, #560
	bl	FreeUsdByDec
	ldr	r1, [r6, #536]
	ldr	r0, [r4, #2496]
	add	r9, r6, #528
	bl	FreeUsdByDec
	ldr	r1, [r6, #544]
	ldr	r0, [r4, #2496]
	bl	FreeUsdByDec
	ldr	r1, [r6, #552]
	ldr	r0, [r4, #2496]
	bl	FreeUsdByDec
	mov	r0, #0
	mov	r1, #0
	mov	r2, #1
	strd	r0, [r9]
	strd	r0, [r7, #-8]
	strd	r0, [r7]
	strd	r0, [r8, #-8]
	ldr	r1, [r4, #2516]
	ldr	r0, [r4, #2496]
	bl	FSP_ClearLogicFs
	mov	r2, #1
	ldr	r1, [r4, #2508]
	ldr	r0, [r4, #2496]
	bl	FSP_ClearLogicFs
	mov	r3, #0
	ldr	r0, [r4, #2496]
	str	r3, [r4, #2508]
	str	r3, [r4, #2516]
	bl	FSP_GetNullLogicFs
	str	r0, [r4, #2516]
	str	r0, [r4, #2508]
.L451:
	add	r1, r5, #22528
	mov	r3, #0
	add	r1, r1, #96
	str	r3, [r4, #2504]
	ldr	r0, [r4, #2496]
	bl	FSP_ClearNotInVoQueue
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L457:
	.align	2
.L456:
	.word	g_VfmwChanStat
	.word	.LC25
	.fnend
	.size	Mp4_Frame_Atr, .-Mp4_Frame_Atr
	.align	2
	.global	Mp4_Set_DecPar
	.type	Mp4_Set_DecPar, %function
Mp4_Set_DecPar:
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
	ldr	r3, .L486
	mov	r6, r2
	mov	r4, r0
	mov	r2, #48
	sub	r0, fp, #92
	mov	r1, #0
	ldr	r3, [r3, #48]
	blx	r3
	ldrb	r3, [r6, #5]
	cmp	r3, #1
	beq	.L483
	ldr	r3, [r6, #88]
	add	r5, r4, #20480
	mov	r1, #0
	bic	r3, r3, #3
	str	r3, [r4, #1208]
	ldr	r3, [r5, #1584]
	and	r2, r3, #3
	str	r3, [r4, #1220]
	ldr	r3, [r5, #1580]
	str	r3, [r4, #1056]
	ldr	r3, [r5, #1592]
	add	r2, r3, r2, lsl #3
	str	r2, [r4, #1228]
	ldr	r2, [r5, #1588]
	rsb	r3, r3, r2, lsl #3
	str	r3, [r4, #1236]
	ldr	r3, [r6, #88]
	str	r3, [r4, #1224]
	ldr	r3, [r6, #80]
	str	r3, [r4, #1060]
	ldr	r3, [r6, #88]
	and	r3, r3, #3
	mov	r3, r3, asl #3
	str	r3, [r4, #1232]
	ldr	r3, [r6, #92]
	str	r1, [r4, #1216]
	mov	r3, r3, asl #3
	str	r3, [r4, #1240]
.L460:
	ldr	r2, [r5, #1512]
	add	r7, r4, #1040
	add	r6, r4, #12288
	add	r3, r2, #15
	mov	r3, r3, lsr #4
	strh	r3, [r7, #164]
	ldr	r1, [r5, #1508]
	add	r3, r1, #15
	mov	r3, r3, lsr #4
	strh	r3, [r7, #166]
	ldrb	r3, [r5, #1448]
	strb	r3, [r4, #1040]
	ldrb	r0, [r5, #858]
	strb	r0, [r4, #1041]
	ldrb	r0, [r5, #813]
	strb	r0, [r4, #1042]
	ldrb	r0, [r5, #1455]
	strb	r0, [r4, #1043]
	ldrb	r0, [r5, #1460]
	strb	r0, [r4, #1044]
	ldrb	r0, [r5, #1459]
	strb	r0, [r4, #1045]
	ldr	r0, [r5, #912]
	strb	r0, [r4, #1046]
	ldrb	r0, [r5, #1456]
	strb	r0, [r4, #1047]
	ldrb	r0, [r5, #1457]
	strb	r0, [r4, #1048]
	ldrb	r0, [r5, #1452]
	strb	r0, [r4, #1049]
	ldrb	r0, [r5, #863]
	strb	r0, [r4, #1050]
	ldrb	r0, [r5, #861]
	strb	r0, [r4, #1051]
	ldrb	r0, [r5, #1450]
	strb	r0, [r4, #1052]
	ldrb	r0, [r5, #1454]
	strb	r0, [r4, #1053]
	ldrb	r0, [r5, #1453]
	strb	r0, [r4, #1054]
	ldrb	r0, [r5, #854]
	strb	r0, [r4, #1055]
	ldr	r0, [r5, #1544]
	str	r0, [r4, #1244]
	ldr	r0, [r5, #1540]
	str	r0, [r4, #1248]
	ldrb	r0, [r5, #816]
	strb	r0, [r4, #1194]
	ldrb	r0, [r5, #815]
	strb	r0, [r4, #1193]
	ldrb	r0, [r5, #814]
	strb	r0, [r4, #1192]
	ldrb	r0, [r5, #817]
	strb	r0, [r4, #1195]
	ldrb	r0, [r5, #818]
	strb	r0, [r4, #1196]
	ldrb	r0, [r5, #819]
	strb	r0, [r4, #1197]
	str	r1, [r6, #3368]
	str	r2, [r6, #3372]
	ldrb	r2, [r5, #856]
	cmp	r2, #2
	cmpeq	r3, #3
	str	r2, [r6, #3376]
	moveq	r3, #1
	movne	r3, #0
	beq	.L484
	ldrb	r2, [r5, #869]
	str	r3, [r6, #3380]
	str	r3, [r6, #3388]
	str	r2, [r6, #3384]
	str	r3, [r6, #3392]
	str	r3, [r6, #3396]
	str	r3, [r6, #3400]
	str	r3, [r6, #3404]
	str	r3, [r6, #3408]
	str	r3, [r6, #3412]
	str	r3, [r6, #3416]
.L462:
	ldr	r1, [r5, #2524]
	ldr	r0, [r5, #2496]
	bl	FSP_GetLogicFs
	ldr	r1, [r5, #2508]
	mov	r8, r0
	ldr	r0, [r5, #2496]
	bl	FSP_GetLogicFs
	ldr	r1, [r5, #2516]
	mov	r9, r0
	ldr	r0, [r5, #2496]
	bl	FSP_GetLogicFs
	cmp	r8, #0
	cmpne	r9, #0
	moveq	r3, #1
	movne	r3, #0
	cmp	r0, #0
	orreq	r3, r3, #1
	cmp	r3, #0
	bne	.L485
	ldr	r1, [r8, #608]
	ldr	ip, [r8, #616]
	cmp	r1, #0
	ldr	lr, [r8, #612]
	beq	.L466
	cmp	ip, #0
	beq	.L466
	cmp	lr, #0
	beq	.L466
	ldr	r3, [r8, #620]
	add	ip, r4, #21248
	add	r1, r4, #1056
	add	r2, r4, #21504
	add	r4, r4, #1120
	add	ip, ip, #160
	str	r3, [r4, #144]
	add	r1, r1, #7
	ldr	r3, [r0, #620]
	add	r2, r2, #160
	str	r3, [r4, #148]
	ldr	r3, [r0, #608]
	cmp	r3, #0
	ldreq	r3, [r8, #608]
	ldr	r3, [r3, #16]
	str	r3, [r4, #140]
	ldr	r3, [r9, #608]
	cmp	r3, #0
	ldreq	r3, [r8, #608]
	ldr	r3, [r3, #16]
	str	r3, [r4, #136]
	ldr	r3, [r8, #608]
	ldr	r3, [r3, #16]
	str	r3, [r4, #132]
	add	r4, r4, #7
	ldr	r3, [r0, #616]
	cmp	r3, #0
	ldreq	r3, [r8, #616]
	ldr	r3, [r3, #16]
	str	r3, [r6, #3328]
	ldr	r3, [r9, #616]
	cmp	r3, #0
	ldreq	r3, [r8, #616]
	ldr	r3, [r3, #16]
	str	r3, [r6, #3332]
	ldr	r3, [r8, #616]
	ldr	r0, [r3, #16]
	mov	r3, #0
	str	r0, [r6, #3336]
	ldr	r0, [r8, #612]
	ldr	r0, [r0, #16]
	str	r0, [r6, #3340]
	ldr	r0, [r8, #612]
	ldr	r0, [r0, #32]
	str	r0, [r6, #3352]
	ldr	r0, [r8, #612]
	ldr	r0, [r0, #76]
	str	r0, [r6, #3356]
	ldr	r0, [r8, #612]
	ldr	r0, [r0, #60]
	str	r0, [r6, #3360]
	ldr	r0, [r8, #612]
	ldr	r0, [r0, #64]
	str	r0, [r6, #3364]
.L477:
	ldr	r0, [ip, #4]!
	add	r3, r3, #1
	cmp	r3, #64
	strb	r0, [r1, #1]!
	ldr	r0, [r2, #4]!
	strb	r0, [r4, #1]!
	bne	.L477
	ldrh	r1, [r7, #164]
	ldrh	r3, [r7, #166]
	ldr	r2, [r5, #1596]
	mul	r3, r3, r1
	str	r3, [r5, #1480]
	ldr	r3, [r2, #588]
	str	r3, [r6, #3420]
	ldr	r3, [r2, #624]
	str	r3, [r6, #3424]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L485:
	movw	r3, #3519
	ldr	r2, .L486+4
	ldr	r1, .L486+8
	mov	r0, #0
	bl	dprint_vfmw
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L483:
	add	r5, r4, #20480
	mov	r0, #0
	ldr	r2, [r5, #1584]
	bic	r1, r2, #3
	str	r1, [r4, #1220]
	str	r2, [r4, #1208]
	and	r2, r2, #3
	ldr	r1, [r5, #1580]
	str	r1, [r4, #1056]
	ldr	r1, [r5, #1592]
	add	r2, r1, r2, lsl #3
	str	r2, [r4, #1228]
	ldr	r2, [r5, #1588]
	str	r3, [r4, #1216]
	str	r0, [r4, #1224]
	rsb	r1, r1, r2, lsl #3
	str	r0, [r4, #1232]
	str	r1, [r4, #1236]
	str	r0, [r4, #1240]
	b	.L460
.L466:
	ldr	r4, [r5, #2516]
	mov	r0, #0
	ldr	r3, [r5, #2524]
	ldr	r2, [r5, #2508]
	stmib	sp, {r1, ip, lr}
	str	r4, [sp]
	ldr	r1, .L486+12
	bl	dprint_vfmw
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L484:
	add	r0, r4, #21248
	sub	r1, fp, #92
	add	r0, r0, #36
	bl	MP4_GetGMCparam
	sub	r0, fp, #64
	ldrb	r10, [r5, #869]
	ldmia	r0, {r0, r1, r2, r3}
	ldr	r9, [fp, #-92]
	ldr	r8, [fp, #-76]
	ldr	lr, [fp, #-72]
	ldr	ip, [fp, #-68]
	str	r3, [r6, #3412]
	ldr	r3, [fp, #-48]
	str	r10, [r6, #3384]
	str	r9, [r6, #3380]
	str	r8, [r6, #3388]
	str	lr, [r6, #3392]
	str	ip, [r6, #3396]
	str	r0, [r6, #3400]
	str	r1, [r6, #3404]
	str	r2, [r6, #3408]
	str	r3, [r6, #3416]
	b	.L462
.L487:
	.align	2
.L486:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR1+1280
	.word	.LC26
	.word	.LC27
	.fnend
	.size	Mp4_Set_DecPar, .-Mp4_Set_DecPar
	.align	2
	.global	Mp4_Get_DecMode
	.type	Mp4_Get_DecMode, %function
Mp4_Get_DecMode:
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
	add	r0, r0, #20480
	ldr	r3, [r0, #1628]
	cmp	r3, #2
	ldr	r3, [r0, #1596]
	beq	.L500
.L490:
	ldr	r3, [r3, #8]
	cmp	r3, #2
	beq	.L493
	cmp	r3, #1
	beq	.L499
	cmp	r3, #4
	movne	r3, #0
.L499:
	str	r3, [r0, #1628]
	ldmfd	sp, {fp, sp, pc}
.L500:
	ldr	r2, [r3, #8]
	cmp	r2, #2
	movne	r2, #1
	strne	r2, [r0, #2136]
	bne	.L490
.L493:
	mov	r3, #2
	str	r3, [r0, #1628]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Mp4_Get_DecMode, .-Mp4_Get_DecMode
	.align	2
	.global	GetTrailingOneLen
	.type	GetTrailingOneLen, %function
GetTrailingOneLen:
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
	add	r1, r0, r1
	ldrb	r3, [r1, #-1]
	tst	r3, #1
	beq	.L504
	mov	r0, #0
.L503:
	mov	r3, r3, lsr #1
	add	r0, r0, #1
	tst	r3, #1
	bne	.L503
	cmp	r0, #0
	addne	r0, r0, #1
	ldmfd	sp, {fp, sp, pc}
.L504:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	GetTrailingOneLen, .-GetTrailingOneLen
	.align	2
	.global	MPEG4DEC_Init
	.type	MPEG4DEC_Init, %function
MPEG4DEC_Init:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #780
	sub	sp, sp, #780
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r4, r0
	mov	r6, r1
	mov	r0, #2
	ldr	r1, .L520
	bl	dprint_vfmw
	cmp	r6, #0
	cmpne	r4, #0
	beq	.L514
	ldr	r3, [r6, #604]
	ldr	r7, .L520+4
	cmp	r3, #1
	beq	.L517
.L512:
	add	r5, r4, #20480
	ldr	r3, [r7, #48]
	movw	r2, #23024
	mov	r1, #0
	ldr	r8, [r5, #2488]
	mov	r0, r4
	blx	r3
	add	r0, r4, #22528
	add	r0, r0, #96
	mov	r7, #0
	str	r8, [r5, #2488]
	bl	ResetVoQueue
	str	r6, [r5, #1596]
	mov	r0, r4
	str	r7, [r6, #864]
	bl	VCTRL_GetChanIDByCtx
	ldr	r8, .L520+4
	cmn	r0, #1
	str	r0, [r5, #2496]
	beq	.L518
	mov	r0, r4
	bl	Global_Data_Init
	subs	r7, r0, #0
	bne	.L514
	mov	r3, #1
	str	r7, [r5, #2112]
	ldr	r1, .L520+8
	mov	r0, #2
	str	r3, [r5, #2084]
	bl	dprint_vfmw
	ldr	r6, [r6, #604]
	cmp	r6, #1
	beq	.L519
.L511:
	mov	r0, r7
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L519:
	add	r0, r4, #21248
	ldr	r3, [r8, #52]
	sub	r1, fp, #804
	mov	r2, #768
	add	r0, r0, #36
	blx	r3
	add	r0, r4, #19968
	ldr	r3, [r8, #52]
	sub	r1, fp, #788
	mov	r2, #24
	add	r0, r0, #24
	blx	r3
	add	r0, r4, #19968
	ldr	r3, [r8, #52]
	sub	r1, fp, #764
	mov	r2, #604
	add	r0, r0, #48
	blx	r3
	add	r0, r4, #22016
	sub	r1, fp, #808
	ldr	r3, [r8, #52]
	mov	r2, #7
	sub	r1, r1, #3
	add	r0, r0, #36
	blx	r3
	mov	r0, r7
	strb	r6, [r5, #2533]
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L517:
	add	r1, r4, #21248
	ldr	r3, [r7, #52]
	add	r1, r1, #36
	mov	r2, #768
	sub	r0, fp, #804
	blx	r3
	add	r1, r4, #19968
	ldr	r3, [r7, #52]
	add	r1, r1, #24
	mov	r2, #24
	sub	r0, fp, #788
	blx	r3
	add	r1, r4, #19968
	ldr	r3, [r7, #52]
	add	r1, r1, #48
	mov	r2, #604
	sub	r0, fp, #764
	blx	r3
	add	r1, r4, #22016
	sub	r0, fp, #808
	ldr	r3, [r7, #52]
	add	r1, r1, #36
	mov	r2, #7
	sub	r0, r0, #3
	blx	r3
	b	.L512
.L514:
	mvn	r7, #0
	mov	r0, r7
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L518:
	mov	r0, r7
	ldr	r1, .L520+12
	bl	dprint_vfmw
	mvn	r7, #19
	b	.L511
.L521:
	.align	2
.L520:
	.word	.LC28
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC30
	.word	.LC29
	.fnend
	.size	MPEG4DEC_Init, .-MPEG4DEC_Init
	.align	2
	.global	MPEG4DEC_Destroy
	.type	MPEG4DEC_Destroy, %function
MPEG4DEC_Destroy:
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
	add	r4, r4, #20480
	ldr	r1, .L523
	mov	r0, #2
	bl	dprint_vfmw
	mov	r3, #0
	str	r3, [r4, #2084]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L524:
	.align	2
.L523:
	.word	.LC31
	.fnend
	.size	MPEG4DEC_Destroy, .-MPEG4DEC_Destroy
	.align	2
	.global	MPEG4DEC_RecycleImage
	.type	MPEG4DEC_RecycleImage, %function
MPEG4DEC_RecycleImage:
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
	beq	.L527
	add	r4, r0, #20480
	mov	r2, #0
	ldr	r0, [r4, #2496]
	bl	FSP_SetDisplay
	mov	r1, r5
	ldr	r0, [r4, #2496]
	bl	FSP_GetFsImagePtr
	cmp	r0, #0
	beq	.L528
	add	r5, r0, #544
	add	r8, r0, #528
	ldr	r1, [r0, #528]
	mov	r6, #0
	ldr	r0, [r4, #2496]
	mov	r7, #0
	bl	FreeUsdByDec
	strd	r6, [r8]
	ldr	r0, [r4, #2496]
	ldr	r1, [r5, #-8]
	bl	FreeUsdByDec
	strd	r6, [r5, #-8]
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L528:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L527:
	mvn	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	MPEG4DEC_RecycleImage, .-MPEG4DEC_RecycleImage
	.align	2
	.global	MP4_SetImgFormat
	.type	MP4_SetImgFormat, %function
MP4_SetImgFormat:
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
	add	r4, r0, #20480
	ldr	r1, [r4, #2524]
	ldr	r0, [r4, #2496]
	bl	FSP_GetFsImagePtr
	subs	r3, r0, #0
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r2, [r4, #1512]
	cmp	r2, #0
	beq	.L531
	ldr	r1, [r4, #1508]
	cmp	r1, #0
	beq	.L531
	ldr	r0, [r3, #112]
	ldr	r1, [r3, #116]
	cmp	r0, r2
	movcs	r0, r2
	str	r0, [r3, #120]
	ldr	r2, [r4, #1508]
	cmp	r1, r2
	movcs	r1, r2
	str	r1, [r3, #124]
	b	.L532
.L531:
	ldr	r1, [r3, #112]
	ldr	r2, [r3, #116]
	str	r1, [r3, #120]
	str	r2, [r3, #124]
.L532:
	mov	r2, #2
	mov	r1, #0
	str	r2, [r3, #340]
	mov	r0, #1
	mov	r2, #8
	strb	r1, [r3, #328]
	strb	r1, [r3, #335]
	str	r2, [r3, #344]
	str	r2, [r3, #352]
	str	r2, [r3, #348]
	strb	r0, [r3, #333]
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	MP4_SetImgFormat, .-MP4_SetImgFormat
	.align	2
	.global	MPEG4DEC_GetRemainImg
	.type	MPEG4DEC_GetRemainImg, %function
MPEG4DEC_GetRemainImg:
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
	add	r4, r0, #20480
	mov	r6, r0
	ldr	r3, [r4, #1596]
	ldr	r3, [r3, #12]
	cmp	r3, #1
	beq	.L558
	ldr	r1, [r4, #2516]
	ldr	r0, [r4, #2496]
	bl	FSP_GetFsImagePtr
	subs	r7, r0, #0
	beq	.L558
	ldr	r1, [r4, #2516]
	ldr	r0, [r4, #2496]
	bl	FSP_GetDisplay
	cmp	r0, #2
	mov	r8, r0
	beq	.L556
.L558:
	add	r5, r6, #22528
	add	r5, r5, #96
.L547:
	mov	r0, r5
	bl	GetVoLastImageID
.L557:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L556:
	mov	r0, r6
	add	r5, r6, #22528
	bl	MP4_SetImgFormat
	add	r5, r5, #96
	mov	r3, #1
	ldr	r1, [r7, #156]
	mov	r2, r3
	str	r3, [r7, #188]
	ldr	r0, [r4, #2496]
	bl	FSP_SetDisplay
	ldr	r0, [r4, #2496]
	mov	r1, r8
	str	r7, [sp]
	mov	r3, r5
	mov	r2, r6
	bl	InsertImgToVoQueue
	cmp	r0, #1
	beq	.L544
	mov	r0, r6
	ldr	r1, [r7, #156]
	add	r10, r7, #528
	bl	MPEG4DEC_RecycleImage
	add	r6, r7, #544
	ldr	r1, [r7, #528]
	ldr	r0, [r4, #2496]
	mov	r8, #0
	bl	FreeUsdByDec
	mov	r9, #0
	strd	r8, [r10]
	ldr	r0, [r4, #2496]
	ldr	r1, [r7, #536]
	bl	FreeUsdByDec
	strd	r8, [r6, #-8]
	b	.L547
.L544:
	ldr	r3, [r7, #160]
	cmp	r3, #100
	bhi	.L547
	ldr	r3, [r7, #112]
	cmp	r3, #31
	bls	.L547
	ldr	r3, [r7, #116]
	cmp	r3, #31
	movhi	r0, #0
	bhi	.L557
	b	.L547
	.fnend
	.size	MPEG4DEC_GetRemainImg, .-MPEG4DEC_GetRemainImg
	.align	2
	.global	MPEG4DEC_GetImageBuffer
	.type	MPEG4DEC_GetImageBuffer, %function
MPEG4DEC_GetImageBuffer:
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
	add	r4, r0, #20480
	mov	r5, r0
	ldr	r0, [r4, #2496]
	bl	FSP_IsNewFsAvalible
	cmp	r0, #1
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r0, [r4, #2496]
	bl	FSP_IsNewFsAvalible
	cmn	r0, #1
	beq	.L565
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L565:
	add	r1, r5, #22528
	ldr	r0, [r4, #2496]
	add	r1, r1, #96
	bl	FSP_ClearNotInVoQueue
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	MPEG4DEC_GetImageBuffer, .-MPEG4DEC_GetImageBuffer
	.align	2
	.global	MP4_GetPacketState
	.type	MP4_GetPacketState, %function
MP4_GetPacketState:
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
	add	r0, r0, #16384
	ldr	r3, [r0, #3604]
	cmp	r3, #1
	mvnne	r0, #0
	moveq	r0, #3
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MP4_GetPacketState, .-MP4_GetPacketState
	.align	2
	.global	MP4_ClearCurPacket
	.type	MP4_ClearCurPacket, %function
MP4_ClearCurPacket:
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
	ldr	r1, [r1, #16]
	mov	r5, r0
	bl	SM_ReleaseStreamSeg
	ldrb	r3, [r4, #5]
	cmp	r3, #0
	bne	.L570
	ldrb	r3, [r4, #85]
	cmp	r3, #1
	beq	.L571
.L570:
	ldr	r3, .L572
	mov	r0, r4
	mov	r2, #160
	mov	r1, #0
	ldr	r3, [r3, #48]
	blx	r3
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L571:
	mov	r0, r5
	ldr	r1, [r4, #96]
	bl	SM_ReleaseStreamSeg
	b	.L570
.L573:
	.align	2
.L572:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	MP4_ClearCurPacket, .-MP4_ClearCurPacket
	.align	2
	.global	MP4_ClearCurPic
	.type	MP4_ClearCurPic, %function
MP4_ClearCurPic:
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
	add	r8, r0, #16384
	add	r3, r0, #20480
	ldr	r6, [r8, #3596]
	ldr	r7, [r3, #2496]
	cmp	r6, #0
	addgt	r5, r0, #15872
	movgt	r4, #0
	addgt	r5, r5, #8
	ble	.L577
.L576:
	add	r4, r4, #1
	ldr	r1, [r5, #4]!
	mov	r0, r7
	bl	SM_ReleaseStreamSeg
	cmp	r6, r4
	bne	.L576
.L577:
	mov	r3, #0
	str	r3, [r8, #3596]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	MP4_ClearCurPic, .-MP4_ClearCurPic
	.align	2
	.global	Vdm_Mem_Move
	.type	Vdm_Mem_Move, %function
Vdm_Mem_Move:
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
	mov	r4, r0
	mov	r5, r1
	mov	r0, #2
	ldr	r1, .L592
	mov	r6, r2
	mov	r10, r3
	ldr	r7, [fp, #4]
	ldr	r8, [fp, #8]
	bl	dprint_vfmw
	add	r0, r4, #12288
	ldr	r3, [fp, #12]
	str	r6, [r4, #1252]
	add	r8, r8, #15
	str	r10, [r0, #3340]
	add	r6, r3, #15
	ldr	ip, [r5, #620]
	movw	r2, #1204
	movw	r3, #1206
	str	r7, [r4, #1256]
	mov	r8, r8, lsr #4
	mov	r6, r6, lsr #4
	str	ip, [r4, #1264]
	add	r9, r4, #20480
	strh	r8, [r4, r2]
	add	r1, r4, #1040
	strh	r6, [r4, r3]
	ldr	r3, [r5, #612]
	ldr	r3, [r3, #32]
	str	r3, [r0, #3352]
	ldr	r3, [r5, #612]
	ldr	r3, [r3, #76]
	str	r3, [r0, #3356]
	ldr	r3, [r5, #612]
	ldr	r3, [r3, #60]
	str	r3, [r0, #3360]
	ldr	r3, [r5, #612]
	ldr	r3, [r3, #64]
	str	r3, [r0, #3364]
	ldr	r3, [r9, #1596]
	ldr	r2, [r3, #588]
	str	r2, [r0, #3420]
	ldr	r2, [r3, #624]
	str	r2, [r0, #3424]
	str	r1, [r4, #1036]
	ldr	r2, [r3, #856]
	cmp	r2, #1
	beq	.L590
	cmp	r2, #2
	beq	.L591
.L582:
	mov	r3, #1
	strb	r3, [r4, #1198]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L590:
	cmp	r1, #0
	beq	.L582
	mov	r2, #0
	str	r2, [r4, #1036]
	ldr	r0, [r9, #2496]
	ldr	r1, [r9, #2524]
	bl	FSP_SetDisplay
	mov	r0, r4
	bl	MP4_ClearCurPic
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L591:
	ldr	r3, [r3, #860]
	cmp	r1, #0
	cmpne	r3, #0
	ble	.L582
	mov	r2, #0
	str	r2, [r4, #1036]
	ldr	r0, [r9, #2496]
	ldr	r1, [r9, #2524]
	bl	FSP_SetDisplay
	ldr	r2, [r9, #1596]
	mov	r0, r4
	ldr	r3, [r2, #860]
	sub	r3, r3, #1
	str	r3, [r2, #860]
	bl	MP4_ClearCurPic
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L593:
	.align	2
.L592:
	.word	.LC32
	.fnend
	.size	Vdm_Mem_Move, .-Vdm_Mem_Move
	.align	2
	.global	MP4_GetScdUpMsg
	.type	MP4_GetScdUpMsg, %function
MP4_GetScdUpMsg:
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
	add	r2, r0, #20480
	add	r3, r0, #15872
	add	r4, r0, #22784
	ldr	r2, [r2, #1596]
	add	r3, r3, #8
	add	r4, r4, #236
	ldr	r0, [r2, #824]
	cmp	r0, #1
	beq	.L597
.L595:
	ldr	r6, .L598
	add	r5, r1, #72
	mov	r0, r3
	mov	r2, #4
	mov	r1, r5
	ldr	r3, [r6, #52]
	blx	r3
	ldr	r3, [r6, #52]
	mov	r1, r5
	mov	r0, r4
	mov	r2, #4
	blx	r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L597:
	ldr	r2, [r2, #864]
	cmp	r2, #1
	bne	.L595
	ldr	ip, .L598
	mov	r1, r4
	mov	r0, r3
	mov	r2, #4
	ldr	r3, [ip, #52]
	blx	r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L599:
	.align	2
.L598:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	MP4_GetScdUpMsg, .-MP4_GetScdUpMsg
	.align	2
	.global	Mp4_Check_Slice_NotSH
	.type	Mp4_Check_Slice_NotSH, %function
Mp4_Check_Slice_NotSH:
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
	add	r3, r0, #16384
	add	r1, r0, #20480
	ldrb	r3, [r3, #3651]
	ldrb	r2, [r1, #744]
	cmp	r3, #0
	bne	.L608
	add	r0, r0, #12288
	ldrb	r3, [r0, #3592]
	tst	r3, #120
	bne	.L608
	movw	r3, #3592
	ldrh	r0, [r0, r3]
	ubfx	r0, r0, #7, #4
	add	r0, r0, #17
	cmp	r2, #3
	ldrls	pc, [pc, r2, asl #2]
	b	.L602
.L604:
	.word	.L609
	.word	.L605
	.word	.L606
	.word	.L605
.L608:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L609:
	mov	r3, #17
.L603:
	subs	r0, r3, r0
	mvnne	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L606:
	ldrb	r3, [r1, #753]
	ldrb	r2, [r1, #752]
	cmp	r3, r2
	movcc	r3, r2
	add	r3, r3, #16
	cmp	r3, #18
	movlt	r3, #18
	b	.L603
.L605:
	ldrb	r3, [r1, #752]
	add	r3, r3, #16
	b	.L603
.L602:
	ldr	r1, .L610
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L611:
	.align	2
.L610:
	.word	.LC33
	.fnend
	.size	Mp4_Check_Slice_NotSH, .-Mp4_Check_Slice_NotSH
	.align	2
	.global	Mp4_Combine_SliceData
	.type	Mp4_Combine_SliceData, %function
Mp4_Combine_SliceData:
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
	add	r2, r0, #16384
	add	r3, r0, #12288
	add	r0, r0, #1264
	ldr	ip, [r2, #3600]
	add	r0, r0, #12
	ldr	r2, [r3, #3324]
	tst	ip, #2
	beq	.L613
	ldrb	lr, [r3, #3437]
	cmp	lr, #1
	beq	.L627
	cmp	lr, #0
	bne	.L621
	ldrb	ip, [r3, #3517]
	cmp	ip, #1
	bne	.L621
	mov	ip, r2, asl #5
	sub	r2, ip, r2, asl #2
	sub	r2, r2, #28
	add	r2, r0, r2
	ldr	r0, [r2, #12]
	cmp	r0, #0
	bne	.L623
	ldr	r0, [r2, #20]
	cmp	r0, #0
	bne	.L623
	ldr	ip, [r2, #8]
	add	r1, ip, r1, lsl #3
	str	r1, [r2, #8]
	ldr	r1, [r3, #3520]
	str	r1, [r2, #20]
	ldr	r3, [r3, #3524]
	mov	r3, r3, asl #3
	str	r3, [r2, #12]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L627:
	sub	r4, r2, #1
	movw	ip, #510
	cmp	r4, ip
	bhi	.L628
	mov	ip, r2, asl #5
	sub	r2, ip, r2, asl #2
	sub	r2, r2, #28
	add	r2, r0, r2
	ldr	r0, [r2, #12]
	cmp	r0, #0
	beq	.L617
	ldr	ip, [r2, #20]
	cmp	ip, #0
	beq	.L617
	ldr	r3, [r3, #3440]
	cmp	ip, r3
	bhi	.L629
	add	r1, r0, r1, lsl #3
	mov	r0, #0
	str	r1, [r2, #12]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L617:
	ldr	ip, [r3, #3440]
	ldr	r0, [r2, #16]
	cmp	ip, r0
	movls	r1, r1, asl #3
	strls	r1, [r2, #12]
	ldrls	r3, [r3, #3440]
	movhi	r0, #0
	ldrhi	r3, [r2, #8]
	movls	r0, #0
	addhi	r1, r3, r1, lsl #3
	strls	r3, [r2, #20]
	strhi	r1, [r2, #8]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L621:
	movw	r2, #4887
	ldr	r1, .L630
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L623:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L613:
	movw	r2, #4893
	ldr	r1, .L630
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L628:
	mov	r0, lr
	ldr	r1, .L630+4
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L629:
	mov	r0, lr
	movw	r2, #4863
	ldr	r1, .L630
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L631:
	.align	2
.L630:
	.word	.LC35
	.word	.LC34
	.fnend
	.size	Mp4_Combine_SliceData, .-Mp4_Combine_SliceData
	.align	2
	.global	MP4_Check_StreamType
	.type	MP4_Check_StreamType, %function
MP4_Check_StreamType:
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
	add	r2, r0, #12288
	add	r0, r0, #20480
	ldrb	r3, [r2, #3592]
	tst	r3, #1
	bne	.L633
	mov	r3, #2
	strb	r3, [r0, #813]
	ldr	r3, [r1]
	mov	r3, r3, lsr #8
	sub	r3, r3, #128
	cmp	r3, #3
	ldrlsb	r3, [r2, #3592]
	orrls	r3, r3, #2
	strlsb	r3, [r2, #3592]
.L634:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L633:
	mov	r2, #196
	mov	r3, #1
	str	r2, [r1]
	strb	r3, [r0, #813]
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MP4_Check_StreamType, .-MP4_Check_StreamType
	.align	2
	.global	MP4_Clean_HeadPacket
	.type	MP4_Clean_HeadPacket, %function
MP4_Clean_HeadPacket:
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
	add	r3, r0, #20480
	mov	r8, r0
	ldr	r6, [r3, #2052]
	ldr	r7, [r3, #2496]
	cmp	r6, #64
	movge	r6, #64
	cmp	r6, #0
	addgt	r5, r0, #22272
	movgt	r4, #0
	ble	.L638
.L637:
	add	r4, r4, #1
	ldr	r1, [r5, #4]!
	mov	r0, r7
	bl	SM_ReleaseStreamSeg
	cmp	r4, r6
	bne	.L637
.L638:
	ldr	r3, .L641
	add	r0, r8, #22016
	mov	r2, #440
	mov	r1, #0
	add	r0, r0, #96
	ldr	r3, [r3, #48]
	blx	r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L642:
	.align	2
.L641:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	MP4_Clean_HeadPacket, .-MP4_Clean_HeadPacket
	.align	2
	.global	MPEG4DEC_VDMPostProc
	.type	MPEG4DEC_VDMPostProc, %function
MPEG4DEC_VDMPostProc:
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
	ldr	r3, .L694
	movw	r2, #14676
	mov	r5, r0
	mov	r6, r1
	add	r0, r0, #1040
	mov	r1, #0
	ldr	r3, [r3, #48]
	add	r4, r5, #20480
	blx	r3
	mov	r0, r5
	bl	MP4_ClearCurPic
	mov	r0, r5
	bl	MP4_Clean_HeadPacket
	str	r6, [r4, #2080]
	ldr	r1, [r4, #2524]
	ldr	r0, [r4, #2496]
	bl	FSP_GetFsImagePtr
	ldr	r1, [r4, #2516]
	mov	r6, r0
	ldr	r0, [r4, #2496]
	bl	FSP_GetFsImagePtr
	cmp	r6, #0
	mov	r8, r0
	beq	.L689
	ldr	r2, [r4, #2088]
	mov	r0, #11
	ldr	r1, .L694+4
	bl	dprint_vfmw
	ldrb	r2, [r4, #1448]
	ldr	r1, .L694+8
	mov	r0, #11
	bl	dprint_vfmw
	ldr	r3, [r4, #2080]
	add	r1, r5, #22528
	add	r1, r1, #68
	str	r3, [r6, #160]
	ldr	r0, [r4, #2496]
	bl	Mp4_ClearUsrData
	ldrb	r2, [r4, #1448]
	cmp	r2, #2
	beq	.L646
	ldr	r2, [r4, #1596]
	ldr	r3, [r4, #2080]
	ldr	r1, [r2]
	cmp	r3, r1
	bhi	.L690
.L646:
	mov	r3, #0
	mov	r0, r5
	str	r3, [r4, #2136]
	bl	MP4_SetImgFormat
	ldr	r3, [r4, #1596]
	ldr	r3, [r3, #12]
	cmp	r3, #1
	beq	.L649
	ldrb	ip, [r4, #1448]
	cmp	ip, #2
	beq	.L650
	ldr	r3, [r4, #2504]
	cmp	r3, #1
	ble	.L651
	ldr	r1, [r4, #2508]
	ldr	r7, [r4, #2512]
	str	r1, [r4, #2528]
	ldrb	r6, [r5]
.L652:
	cmn	r1, #1
	beq	.L654
	ldr	r0, [r4, #2496]
	bl	FSP_GetFsImagePtr
	subs	r8, r0, #0
	beq	.L691
	cmp	r7, #0
	cmpeq	r6, #4
	beq	.L692
	ldr	r2, [r8, #160]
	cmp	r2, #0
	beq	.L657
	ldr	r3, [r4, #1596]
	ldr	r1, [r3, #4]
	cmp	r2, r1
	bhi	.L658
.L657:
	ldr	r1, [r4, #2528]
	ldr	r0, [r4, #2496]
	bl	FSP_GetLogicFs
	subs	r7, r0, #0
	beq	.L693
	cmp	r6, #2
	beq	.L660
	ldrsb	r3, [r7, #1]
	cmp	r3, #2
	beq	.L660
	ldr	r2, [r4, #2528]
	mov	r0, #11
	ldr	r1, .L694+12
	bl	dprint_vfmw
.L654:
	ldr	r3, [r4, #2088]
	mov	r0, #0
	add	r3, r3, #1
	str	r3, [r4, #2088]
.L687:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L649:
	ldr	r1, [r4, #2524]
	ldrb	r6, [r4, #1448]
	ldr	r7, [r4, #1540]
	str	r1, [r4, #2528]
	b	.L652
.L650:
	ldr	r1, [r4, #2524]
	cmp	r8, #0
	ldr	r7, [r4, #1540]
	str	r1, [r4, #2528]
	beq	.L665
	add	r0, r8, #576
	add	r6, r6, #576
	ldrd	r8, [r0, #-8]
	ldrd	r2, [r6, #-8]
	cmp	r8, r2
	sbcs	lr, r9, r3
	bge	.L665
	strd	r8, [r6, #-8]
	mov	r6, ip
	strd	r2, [r0, #-8]
	ldr	r1, [r4, #2528]
	b	.L652
.L658:
	ldr	r3, .L694+16
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L663
	str	r2, [fp, #-44]
	mov	r3, #8
	str	r1, [fp, #-40]
	sub	r2, fp, #44
	mov	r1, #104
	ldr	r0, [r4, #2496]
	blx	ip
	ldr	r3, [r4, #1596]
	ldr	r2, [r8, #160]
	ldr	r1, [r3, #4]
.L663:
	mov	r3, r1
	add	r9, r8, #528
	ldr	r1, .L694+20
	mov	r0, #1
	bl	dprint_vfmw
	add	r5, r8, #544
	ldr	r1, [r8, #528]
	mov	r6, #0
	ldr	r0, [r4, #2496]
	mov	r7, #0
	bl	FreeUsdByDec
	strd	r6, [r9]
	ldr	r1, [r8, #536]
	ldr	r0, [r4, #2496]
	bl	FreeUsdByDec
	strd	r6, [r5, #-8]
	mov	r2, #0
	ldr	r1, [r4, #2528]
	ldr	r0, [r4, #2496]
	bl	FSP_SetDisplay
	b	.L654
.L660:
	mov	r2, #1
	ldr	r1, [r4, #2528]
	ldr	r0, [r4, #2496]
	bl	FSP_SetDisplay
	add	r3, r5, #22528
	ldr	r0, [r4, #2496]
	add	r3, r3, #96
	str	r8, [sp]
	mov	r2, r5
	mov	r1, #2
	bl	InsertImgToVoQueue
	cmp	r0, #1
	beq	.L654
	ldr	r1, [r8, #528]
	add	r9, r8, #528
	ldr	r0, [r4, #2496]
	add	r5, r8, #544
	mov	r6, #0
	mov	r7, #0
.L688:
	bl	FreeUsdByDec
	strd	r6, [r9]
	ldr	r1, [r8, #536]
	ldr	r0, [r4, #2496]
	bl	FreeUsdByDec
	strd	r6, [r5, #-8]
	mov	r2, #0
	ldr	r0, [r4, #2496]
	ldr	r1, [r4, #2528]
	bl	FSP_SetDisplay
	mvn	r0, #0
	b	.L687
.L651:
	mvn	r3, #0
	str	r3, [r4, #2528]
	b	.L654
.L665:
	mov	r6, ip
	b	.L652
.L690:
	ldr	r1, .L694+16
	ldr	ip, [r1]
	cmp	ip, #0
	beq	.L647
	str	r3, [fp, #-44]
	mov	r1, #104
	ldr	lr, [r2]
	mov	r3, #8
	sub	r2, fp, #44
	ldr	r0, [r4, #2496]
	str	lr, [fp, #-40]
	blx	ip
.L647:
	mov	r6, #1
	ldr	r1, [r4, #2516]
	str	r6, [r4, #2136]
	ldr	r0, [r4, #2496]
	bl	FSP_GetFsImagePtr
	subs	r5, r0, #0
	beq	.L648
	ldr	r1, [r5, #528]
	add	r7, r5, #544
	ldr	r0, [r4, #2496]
	add	r8, r5, #560
	bl	FreeUsdByDec
	ldr	r1, [r5, #536]
	ldr	r0, [r4, #2496]
	add	r9, r5, #528
	bl	FreeUsdByDec
	ldr	r1, [r5, #544]
	ldr	r0, [r4, #2496]
	bl	FreeUsdByDec
	ldr	r1, [r5, #552]
	ldr	r0, [r4, #2496]
	bl	FreeUsdByDec
	mov	r0, #0
	mov	r1, #0
	mov	r2, r6
	strd	r0, [r9]
	strd	r0, [r7, #-8]
	strd	r0, [r7]
	strd	r0, [r8, #-8]
	ldr	r1, [r4, #2516]
	ldr	r0, [r4, #2496]
	bl	FSP_ClearLogicFs
	mov	r2, r6
	ldr	r1, [r4, #2508]
	ldr	r0, [r4, #2496]
	bl	FSP_ClearLogicFs
	mov	r3, #0
	ldr	r0, [r4, #2496]
	str	r3, [r4, #2508]
	str	r3, [r4, #2516]
	bl	FSP_GetNullLogicFs
	str	r0, [r4, #2516]
	str	r0, [r4, #2508]
.L648:
	mov	r3, #0
	mvn	r0, #0
	str	r3, [r4, #2504]
	b	.L687
.L692:
	ldr	r2, [r4, #2496]
	mov	r1, #300
	ldr	r3, .L694+24
	add	r9, r8, #528
	add	r5, r8, #544
	mov	r6, #0
	mov	r0, r2
	mov	r7, #0
	mla	r3, r1, r2, r3
	ldr	r2, [r3, #16]
	add	r2, r2, #1
	str	r2, [r3, #16]
	ldr	r1, [r8, #528]
	b	.L688
.L689:
	mov	r3, r0
	mov	r2, r6
	mov	r0, r6
	ldr	r1, .L694+28
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L687
.L691:
	movw	r2, #4594
	ldr	r1, .L694+32
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L687
.L693:
	add	r5, r8, #544
	add	r6, r8, #528
	ldr	r1, [r8, #528]
	mov	r9, #0
	ldr	r0, [r4, #2496]
	mov	r8, #0
	bl	FreeUsdByDec
	strd	r8, [r6]
	ldr	r1, [r5, #-8]
	ldr	r0, [r4, #2496]
	bl	FreeUsdByDec
	strd	r8, [r5, #-8]
	mov	r2, r7
	ldr	r0, [r4, #2496]
	ldr	r1, [r4, #2528]
	bl	FSP_SetDisplay
	mvn	r0, #0
	b	.L687
.L695:
	.align	2
.L694:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC37
	.word	.LC38
	.word	.LC40
	.word	g_event_report
	.word	.LC41
	.word	g_VfmwChanStat
	.word	.LC36
	.word	.LC39
	.fnend
	.size	MPEG4DEC_VDMPostProc, .-MPEG4DEC_VDMPostProc
	.align	2
	.global	MP4_Record_SlcSegID
	.type	MP4_Record_SlcSegID, %function
MP4_Record_SlcSegID:
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
	add	r5, r0, #16384
	movw	r6, #1022
	mov	r4, r0
	ldr	r2, [r5, #3596]
	cmp	r2, r6
	bhi	.L699
	add	r1, r0, #12288
	add	r4, r0, r2, lsl #2
	add	r4, r4, #12288
	add	r3, r2, #1
	ldr	r0, [r1, #3448]
	str	r0, [r4, #3596]
	str	r3, [r5, #3596]
	ldrb	r3, [r1, #3437]
	cmp	r3, #0
	ldmnefd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldrb	r3, [r1, #3517]
	cmp	r3, #1
	addeq	r2, r2, #2
	ldreq	r3, [r1, #3528]
	streq	r3, [r4, #3600]
	streq	r2, [r5, #3596]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L699:
	bl	MP4_Clean_HeadPacket
	mov	r0, r4
	bl	MP4_ClearCurPic
	add	r3, r4, #20480
	add	r1, r4, #15680
	ldr	r0, [r3, #2496]
	add	r1, r1, #40
	bl	MP4_ClearCurPacket
	mov	r3, r6
	ldr	r2, [r5, #3596]
	mov	r0, #0
	ldr	r1, .L700
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L701:
	.align	2
.L700:
	.word	.LC42
	.fnend
	.size	MP4_Record_SlcSegID, .-MP4_Record_SlcSegID
	.align	2
	.global	Mp4_Syntax_ShortHeader
	.type	Mp4_Syntax_ShortHeader, %function
Mp4_Syntax_ShortHeader:
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
	add	r7, r0, #12288
	mov	r4, r2
	mov	r6, r0
	mov	r5, r1
	ldr	r2, [r7, #3324]
	cmp	r2, #0
	bne	.L738
.L703:
	mov	r1, r5
	mov	r2, r4
	sub	r0, fp, #76
	add	r5, r6, #20480
	bl	BsInit
	ldr	r3, .L743
	add	r0, r6, #20992
	mov	r2, #60
	mov	r1, #0
	add	r0, r0, #232
	ldr	r3, [r3, #48]
	blx	r3
	mov	r1, #22
	sub	r0, fp, #76
	bl	BsSkip
	mov	r1, #13
	sub	r0, fp, #76
	bl	BsSkip
	sub	r0, fp, #76
	mov	r1, #3
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r5, #754]
	sub	r0, r0, #1
	cmp	r0, #3
	ldrls	pc, [pc, r0, asl #2]
	b	.L704
.L706:
	.word	.L705
	.word	.L707
	.word	.L708
	.word	.L709
.L709:
	mov	r2, #18
	mov	r3, #88
	strb	r2, [r5, #755]
	mov	r2, #704
	strb	r3, [r5, #756]
	mov	r3, #576
	str	r2, [r5, #1512]
	str	r3, [r5, #1508]
.L710:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	ldrb	r3, [r5, #811]
	cmp	r3, #2
	uxtb	r0, r0
	strb	r0, [r5, #744]
	beq	.L712
	adds	r0, r0, #0
	ldr	r3, [r5, #2136]
	movne	r0, #1
	cmp	r3, #1
	movne	r0, #0
	cmp	r0, #0
	bne	.L712
	mov	r1, #4
	sub	r0, fp, #76
	bl	BsSkip
	mov	r1, #5
	sub	r0, fp, #76
	mov	r9, r4, asl #3
	bl	BsGet
	mov	r1, #1
	mov	r4, #0
	uxtb	r0, r0
	cmp	r0, #0
	strneb	r0, [r5, #751]
	sub	r0, fp, #76
	moveq	r3, #1
	streqb	r3, [r5, #751]
	bl	BsSkip
.L718:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	cmp	r0, #1
	beq	.L739
	add	r4, r4, #1
	cmp	r4, #15
	bls	.L719
.L737:
	mov	r4, #0
	sub	r0, fp, #76
	strb	r4, [r5, #1577]
	bl	BsPos
	ldr	r3, .L743+4
	ldr	ip, [r3]
	cmp	ip, r4
	mov	r8, r0
	beq	.L725
	ldr	r0, [r5, #2496]
	mov	r3, r4
	mov	r2, r4
	mov	r1, #103
	blx	ip
	mov	r0, r8
.L736:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L708:
	mov	r2, #18
	mov	r3, #22
	strb	r2, [r5, #755]
	mov	r2, #352
	strb	r3, [r5, #756]
	mov	r3, #288
	str	r2, [r5, #1512]
	str	r3, [r5, #1508]
	b	.L710
.L707:
	mov	r2, #9
	mov	r3, #11
	strb	r2, [r5, #755]
	mov	r2, #176
	strb	r3, [r5, #756]
	mov	r3, #144
	str	r2, [r5, #1512]
	str	r3, [r5, #1508]
	b	.L710
.L705:
	mov	r2, #6
	mov	r3, #8
	strb	r2, [r5, #755]
	mov	r2, #128
	strb	r3, [r5, #756]
	mov	r3, #96
	str	r2, [r5, #1512]
	str	r3, [r5, #1508]
	b	.L710
.L739:
	sub	r0, fp, #76
	add	r4, r4, #1
	bl	BsPos
	mov	r1, #8
	cmp	r0, r9
	sub	r0, fp, #76
	bgt	.L740
	bl	BsSkip
	cmp	r4, #15
	bls	.L718
	b	.L737
.L738:
	ldr	r1, .L743+8
	mov	r0, #1
	bl	dprint_vfmw
	mov	r3, #0
	str	r3, [r7, #3324]
	b	.L703
.L719:
	add	r10, r6, #16384
	mov	r2, #1
	strb	r2, [r5, #1577]
	sub	r0, fp, #76
	ldr	r3, [r10, #3600]
	orr	r3, r3, #2
	str	r3, [r10, #3600]
	ldr	r3, [r7, #3324]
	add	r3, r3, r2
	str	r3, [r7, #3324]
	strb	r2, [r5, #752]
	bl	BsPos
	mov	r3, r0, asr #31
	mov	r8, r0
	add	r1, r0, #7
	rsb	r4, r0, r9
	mov	r3, r3, lsr #29
	str	r4, [r6, #1284]
	add	r2, r8, r3
	ldr	r0, [r5, #1592]
	and	r2, r2, #7
	cmp	r8, #0
	rsb	r3, r3, r2
	add	r3, r3, r0
	strb	r3, [r6, #1282]
	ldr	r3, [r5, #1584]
	movge	r1, r8
	add	r3, r3, r1, asr #3
	str	r3, [r6, #1292]
	ldrb	r3, [r7, #3437]
	cmp	r3, #0
	beq	.L741
.L720:
	mov	r3, #0
	str	r3, [r6, #1288]
	strb	r3, [r6, #1283]
	str	r3, [r6, #1296]
.L721:
	ldrb	r3, [r5, #744]
	strb	r3, [r6, #1280]
	ldrb	r3, [r5, #753]
	strb	r3, [r6, #1278]
	ldrb	r3, [r5, #752]
	strb	r3, [r6, #1277]
	ldrb	r3, [r5, #751]
	strb	r3, [r6, #1281]
	ldrb	r3, [r5, #748]
	strb	r3, [r6, #1279]
	ldr	r2, [r10, #3596]
	cmp	r2, #0
	bne	.L742
.L722:
	mov	r0, r6
	bl	MP4_Record_SlcSegID
	mov	r0, r8
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L712:
	sub	r0, fp, #76
	bl	BsPos
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L704:
	mov	r4, #0
	sub	r0, fp, #76
	strb	r4, [r5, #1577]
	bl	BsPos
	ldr	r3, .L743+4
	ldr	ip, [r3]
	cmp	ip, r4
	mov	r8, r0
	beq	.L725
	ldr	r0, [r5, #2496]
	mov	r3, r4
	mov	r2, r4
	mov	r1, #102
	blx	ip
	mov	r0, r8
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L741:
	ldrb	r2, [r7, #3517]
	cmp	r2, #1
	bne	.L720
	ldr	r2, [r7, #3524]
	strb	r3, [r6, #1283]
	mov	r3, r2, asl #3
	str	r3, [r6, #1288]
	ldr	r3, [r7, #3520]
	str	r3, [r6, #1296]
	b	.L721
.L742:
	ldr	r1, .L743+12
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r6
	bl	MP4_ClearCurPic
	b	.L722
.L725:
	mov	r0, r8
	b	.L736
.L740:
	bl	BsPos
	b	.L736
.L744:
	.align	2
.L743:
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_event_report
	.word	.LC43
	.word	.LC44
	.fnend
	.size	Mp4_Syntax_ShortHeader, .-Mp4_Syntax_ShortHeader
	.align	2
	.global	Mp4_Syntax_Vop
	.type	Mp4_Syntax_Vop, %function
Mp4_Syntax_Vop:
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
	add	r7, r0, #12288
	mov	r6, r2
	mov	r5, r0
	mov	r10, r1
	ldr	r2, [r7, #3324]
	cmp	r2, #0
	bne	.L823
	add	r4, r5, #20480
	ldrb	r3, [r4, #805]
	cmp	r3, #0
	bne	.L747
.L824:
	mov	r0, #32
	strb	r3, [r4, #1577]
.L748:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L823:
	add	r4, r5, #20480
	ldr	r1, .L839
	mov	r0, #1
	bl	dprint_vfmw
	mov	r3, #0
	str	r3, [r7, #3324]
	ldrb	r3, [r4, #805]
	cmp	r3, #0
	beq	.L824
.L747:
	add	r8, r5, #20992
	ldr	r9, .L839+4
	add	r8, r8, #232
	mov	r1, r10
	sub	r0, fp, #76
	mov	r2, r6
	bl	BsInit
	mov	r2, #60
	ldr	r3, [r9, #48]
	mov	r1, #0
	mov	r0, r8
	blx	r3
	mov	r3, #0
	mov	r1, #32
	strb	r3, [r4, #1577]
	sub	r0, fp, #76
	bl	BsSkip
	mov	r1, #2
	sub	r0, fp, #76
	bl	BsGet
	ldr	r1, .L839+8
	uxtb	r2, r0
	strb	r0, [r4, #744]
	mov	r0, #18
	bl	dprint_vfmw
	ldrb	r10, [r4, #744]
	cmp	r10, #3
	beq	.L825
.L749:
	adds	r10, r10, #0
	ldrb	r3, [r4, #811]
	movne	r10, #1
	cmp	r3, #1
	movne	r2, #0
	andeq	r2, r10, #1
	cmp	r2, #0
	bne	.L752
	cmp	r3, #2
	beq	.L752
	ldr	r3, [r4, #2136]
	cmp	r3, #1
	movne	r10, #0
	andeq	r10, r10, #1
	cmp	r10, #0
	bne	.L752
	mov	r6, r6, asl #3
	b	.L755
.L827:
	bl	BsPos
	add	r10, r10, #1
	cmp	r0, r6
	bgt	.L826
	cmp	r10, #6400
	beq	.L756
.L755:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	cmp	r0, #0
	sub	r0, fp, #76
	bne	.L827
	cmp	r10, #6400
	bcs	.L756
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	subs	r3, r0, #0
	beq	.L828
	ldr	r1, [r4, #912]
	cmp	r1, #0
	moveq	r0, r1
	bne	.L829
.L759:
	str	r10, [r4, #1516]
	mov	r1, #1
	str	r0, [r4, #1520]
	sub	r0, fp, #76
	bl	BsGet
	subs	r10, r0, #0
	bne	.L760
	ldr	r1, .L839+12
	mov	r0, #1
	bl	dprint_vfmw
	strb	r10, [r4, #1577]
	sub	r0, fp, #76
	bl	BsPos
	ldr	r3, .L839+16
	ldr	ip, [r3]
	cmp	ip, #0
	mov	r5, r0
	beq	.L786
	ldr	r0, [r4, #2496]
	mov	r3, r10
	mov	r2, r10
	mov	r1, #103
	blx	ip
	mov	r0, r5
	b	.L748
.L756:
	mov	r3, #0
	sub	r0, fp, #76
	strb	r3, [r4, #1577]
	bl	BsPos
	mov	r2, r10
	ldr	r1, .L839+20
	mov	r4, r0
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	b	.L748
.L826:
	sub	r0, fp, #76
	bl	BsPos
	ldr	r1, .L839+24
	mov	r4, r0
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	b	.L748
.L825:
	ldr	r3, .L839+28
	ldr	r3, [r3]
	ands	r3, r3, #8
	bne	.L749
	strb	r3, [r4, #1577]
	sub	r0, fp, #76
	str	r3, [fp, #-80]
	bl	BsPos
	ldr	r2, .L839+16
	ldr	ip, [r2]
	cmp	ip, #0
	mov	r5, r0
	beq	.L750
	ldr	r3, [fp, #-80]
	mov	r1, #103
	ldr	r0, [r4, #2496]
	mov	r2, r3
	blx	ip
.L750:
	ldr	r1, .L839+32
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r5
	b	.L748
.L752:
	sub	r0, fp, #76
	bl	BsPos
	b	.L748
.L760:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #745]
	cmp	r0, #0
	beq	.L830
	ldrb	r3, [r4, #744]
	cmp	r3, #1
	beq	.L762
	cmp	r3, #3
	beq	.L831
.L763:
	mov	r3, #0
	strb	r3, [r4, #746]
.L764:
	ldrb	r3, [r4, #852]
	mov	r2, #0
	strb	r2, [r4, #747]
	cmp	r3, #2
	addeq	r10, r5, #16384
	beq	.L765
	mov	r1, #3
	sub	r0, fp, #76
	bl	BsGet
	add	r10, r5, #16384
	strb	r0, [r4, #748]
	ldrb	r3, [r10, #3642]
	cmp	r3, #0
	streqb	r3, [r4, #750]
	moveq	r3, #2
	streqb	r3, [r4, #749]
	bne	.L832
.L767:
	ldrb	r3, [r4, #856]
	sub	r3, r3, #1
	cmp	r3, #1
	bls	.L768
.L771:
	mov	r1, #5
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r0, r0
	cmp	r0, #0
	moveq	r3, #1
	streqb	r3, [r4, #751]
	strneb	r0, [r4, #751]
.L777:
	ldrb	r3, [r4, #744]
	cmp	r3, #0
	bne	.L833
.L765:
	mov	r3, #1
	strb	r3, [r4, #1577]
	ldr	r3, [r10, #3600]
	add	r0, r5, #21760
	mov	r1, r8
	mov	r2, #60
	orr	r3, r3, #2
	str	r3, [r10, #3600]
	ldr	r3, [r7, #3324]
	add	r0, r0, #168
	ldr	ip, [r9, #52]
	add	r3, r3, #1
	str	r3, [r7, #3324]
	blx	ip
	sub	r0, fp, #76
	bl	BsPos
	mov	r3, r0, asr #31
	mov	r8, r0
	add	r1, r0, #7
	rsb	r6, r0, r6
	mov	r3, r3, lsr #29
	str	r6, [r5, #1284]
	add	r2, r8, r3
	ldr	r0, [r4, #1592]
	and	r2, r2, #7
	cmp	r8, #0
	rsb	r3, r3, r2
	add	r3, r3, r0
	strb	r3, [r5, #1282]
	ldr	r3, [r4, #1584]
	movge	r1, r8
	add	r3, r3, r1, asr #3
	str	r3, [r5, #1292]
	ldrb	r3, [r7, #3437]
	cmp	r3, #0
	bne	.L781
	ldrb	r2, [r7, #3517]
	cmp	r2, #1
	beq	.L834
.L781:
	mov	r3, #0
	str	r3, [r5, #1288]
	strb	r3, [r5, #1283]
	str	r3, [r5, #1296]
.L782:
	ldrb	r3, [r4, #744]
	strb	r3, [r5, #1280]
	ldrb	r3, [r4, #753]
	strb	r3, [r5, #1278]
	ldrb	r3, [r4, #752]
	strb	r3, [r5, #1277]
	ldrb	r3, [r4, #751]
	strb	r3, [r5, #1281]
	ldrb	r3, [r4, #748]
	strb	r3, [r5, #1279]
	ldr	r2, [r10, #3596]
	cmp	r2, #0
	bne	.L835
.L783:
	mov	r0, r5
	bl	MP4_Record_SlcSegID
	mov	r0, r8
	b	.L748
.L828:
	ldr	r1, .L839+12
	mov	r0, #1
	str	r3, [fp, #-80]
	bl	dprint_vfmw
	ldr	r3, [fp, #-80]
	sub	r0, fp, #76
	strb	r3, [r4, #1577]
	bl	BsPos
	ldr	r2, .L839+16
	ldr	ip, [r2]
	cmp	ip, #0
	mov	r5, r0
	beq	.L786
	ldr	r3, [fp, #-80]
	mov	r1, #103
	ldr	r0, [r4, #2496]
	mov	r2, r3
	blx	ip
	mov	r0, r5
	b	.L748
.L829:
	sub	r0, fp, #76
	bl	BsGet
	b	.L759
.L786:
	mov	r0, r5
	b	.L748
.L835:
	ldr	r1, .L839+36
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r5
	bl	MP4_ClearCurPic
	b	.L783
.L830:
	add	r5, r5, #16384
	mov	r3, #4
	mov	r2, #1
	strb	r3, [r4, #744]
	strb	r3, [r4, #1448]
	sub	r0, fp, #76
	strb	r2, [r4, #1577]
	ldr	r3, [r5, #3600]
	orr	r3, r3, #128
	str	r3, [r5, #3600]
	bl	BsPos
	b	.L748
.L831:
	ldrb	r3, [r4, #856]
	cmp	r3, #2
	bne	.L763
.L762:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	strb	r0, [r4, #746]
	b	.L764
.L833:
	mov	r1, #3
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r2, r0
	strb	r2, [r4, #752]
	cmp	r2, #0
	beq	.L836
	ldrb	r3, [r4, #744]
	cmp	r3, #2
	bne	.L765
	mov	r1, #3
	sub	r0, fp, #76
	bl	BsGet
	uxtb	r2, r0
	strb	r2, [r4, #753]
	cmp	r2, #0
	bne	.L765
	strb	r2, [r4, #1577]
	sub	r0, fp, #76
	str	r2, [fp, #-80]
	bl	BsPos
	ldr	r3, .L839+16
	ldr	ip, [r3]
	cmp	ip, #0
	mov	r5, r0
	beq	.L780
	ldr	r2, [fp, #-80]
	mov	r1, #103
	ldr	r0, [r4, #2496]
	mov	r3, r2
	blx	ip
.L780:
	ldr	r1, .L839+40
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r5
	b	.L748
.L832:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #749]
	sub	r0, fp, #76
	bl	BsGet
	strb	r0, [r4, #750]
	b	.L767
.L768:
	ldrb	r3, [r4, #744]
	cmp	r3, #3
	bne	.L771
	ldrb	r3, [r4, #868]
	cmp	r3, #0
	beq	.L771
	add	r3, r5, #21248
	mov	r2, #0
	add	r3, r3, #12
	str	r6, [fp, #-84]
	str	r5, [fp, #-88]
	mov	r6, r2
	str	r8, [fp, #-80]
	mov	r5, r3
	str	r7, [fp, #-92]
	b	.L776
.L772:
	ldr	r3, [r4, #1552]
	cmp	r3, #500
	bne	.L773
	ldr	r2, [r4, #1556]
	movw	r3, #413
	cmp	r2, r3
	beq	.L774
.L773:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsSkip
.L774:
	sub	r0, fp, #76
	bl	bs_get_spritetrajectory
	subs	r3, r0, #0
	moveq	r7, r3
	bne	.L837
.L775:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsSkip
	str	r8, [r5]
	str	r7, [r5, #4]
	add	r6, r6, #1
	ldrb	r3, [r4, #868]
	add	r5, r5, #8
	cmp	r3, r6
	bls	.L838
.L776:
	sub	r0, fp, #76
	bl	bs_get_spritetrajectory
	subs	r7, r0, #0
	moveq	r8, r7
	beq	.L772
	mov	r1, r7
	sub	r0, fp, #76
	bl	BsGet
	sub	r2, r7, #1
	movs	r3, r0, asr r2
	mov	r8, r0
	moveq	r3, #1
	moveq	r3, r3, asl r7
	subeq	r3, r3, #1
	eoreq	r8, r8, r3
	rsbeq	r8, r8, #0
	b	.L772
.L837:
	mov	r1, r3
	sub	r0, fp, #76
	str	r3, [fp, #-96]
	bl	BsGet
	ldr	r3, [fp, #-96]
	sub	r2, r3, #1
	movs	r2, r0, asr r2
	mov	r7, r0
	moveq	r2, #1
	moveq	r3, r2, asl r3
	subeq	r2, r3, #1
	eoreq	r3, r0, r2
	rsbeq	r7, r3, #0
	b	.L775
.L834:
	ldr	r2, [r7, #3524]
	strb	r3, [r5, #1283]
	mov	r3, r2, asl #3
	str	r3, [r5, #1288]
	ldr	r3, [r7, #3520]
	str	r3, [r5, #1296]
	b	.L782
.L836:
	strb	r2, [r4, #1577]
	sub	r0, fp, #76
	str	r2, [fp, #-80]
	bl	BsPos
	ldr	r3, .L839+16
	ldr	ip, [r3]
	cmp	ip, #0
	mov	r5, r0
	beq	.L779
	ldr	r2, [fp, #-80]
	mov	r1, #103
	ldr	r0, [r4, #2496]
	mov	r3, r2
	blx	ip
.L779:
	ldrb	r2, [r4, #744]
	mov	r0, #1
	ldr	r1, .L839+44
	bl	dprint_vfmw
	mov	r0, r5
	b	.L748
.L838:
	sub	r5, fp, #88
	ldr	r7, [fp, #-92]
	ldmia	r5, {r5, r6, r8}
	b	.L771
.L840:
	.align	2
.L839:
	.word	.LC43
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC45
	.word	.LC8
	.word	g_event_report
	.word	.LC48
	.word	.LC47
	.word	g_VdmCharacter
	.word	.LC46
	.word	.LC44
	.word	.LC50
	.word	.LC49
	.fnend
	.size	Mp4_Syntax_Vop, .-Mp4_Syntax_Vop
	.align	2
	.global	Mp4_Syntax_Slice_NotSH
	.type	Mp4_Syntax_Slice_NotSH, %function
Mp4_Syntax_Slice_NotSH:
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
	add	r6, r0, #12288
	mov	r4, r0
	movw	r3, #510
	mov	r7, r2
	ldr	r8, [r6, #3324]
	sub	r0, r8, #1
	cmp	r0, r3
	bhi	.L862
	movw	r3, #3592
	sub	r0, fp, #76
	ldrh	r9, [r6, r3]
	add	r5, r4, #20480
	add	r3, r8, #1
	str	r3, [r6, #3324]
	ubfx	r9, r9, #7, #4
	bl	BsInit
	add	r9, r9, #17
	sub	r0, fp, #76
	mov	r1, r9
	bl	BsSkip
	ldr	r2, [r5, #1508]
	ldr	r9, [r5, #1512]
	add	r2, r2, #15
	add	r9, r9, #15
	mov	r2, r2, lsr #4
	mov	r9, r9, lsr #4
	mul	r9, r9, r2
	cmp	r9, #0
	beq	.L844
	mov	lr, r9
	mov	r1, #0
.L845:
	add	ip, r1, #1
	movs	lr, lr, lsr #1
	uxth	r1, ip
	bne	.L845
	sxth	r1, r1
	sub	r0, fp, #76
	bl	BsGet
	mov	r10, r8, asl #2
	mov	r8, r8, asl #5
	sub	r1, r9, #1
	rsb	r3, r10, r8
	add	r3, r4, r3
	cmp	r0, r1
	str	r0, [r3, #1300]
	bhi	.L863
.L846:
	mov	r1, #5
	sub	r0, fp, #76
	bl	BsGet
	rsb	r9, r10, r8
	add	r9, r4, r9
	mov	r1, #1
	add	r9, r9, #1264
	add	r9, r9, #8
	strb	r0, [r9, #9]
	sub	r0, fp, #76
	bl	BsGet
	cmp	r0, #0
	beq	.L847
.L857:
	mov	r1, #1
	sub	r0, fp, #76
	bl	BsGet
	cmp	r0, #0
	bne	.L857
	mov	r1, #1
	sub	r0, fp, #76
	add	r2, r4, #16384
	str	r2, [fp, #-80]
	bl	BsSkip
	ldr	r2, [fp, #-80]
	ldr	r1, [r2, #3700]
	cmp	r1, #0
	bne	.L864
.L849:
	mov	r1, #1
	sub	r0, fp, #76
	str	r2, [fp, #-80]
	bl	BsSkip
	mov	r1, #2
	sub	r0, fp, #76
	bl	BsGet
	rsb	r9, r10, r8
	add	r9, r4, r9
	mov	r1, #3
	add	r9, r9, #1264
	strb	r0, [r9, #16]
	sub	r0, fp, #76
	bl	BsGet
	ldrb	r3, [r9, #16]
	ldr	r2, [fp, #-80]
	cmp	r3, #0
	strb	r0, [r9, #15]
	add	r9, r9, #8
	bne	.L865
.L851:
	ldrb	ip, [r5, #752]
	rsb	r3, r10, r8
	add	r3, r4, r3
	sub	r0, fp, #76
	add	r1, r3, #1264
	str	r3, [fp, #-84]
	strb	ip, [r3, #1277]
	add	r1, r1, #8
	ldrb	ip, [r5, #753]
	str	r1, [fp, #-80]
	strb	ip, [r3, #1278]
	ldr	ip, [r2, #3600]
	orr	ip, ip, #16
	str	ip, [r2, #3600]
	bl	BsPos
	ldr	r3, [fp, #-84]
	ldr	r1, [fp, #-80]
	mov	r2, r0, asr #31
	mov	r9, r0
	add	ip, r0, #7
	rsb	r7, r0, r7, lsl #3
	mov	r2, r2, lsr #29
	str	r7, [r3, #1284]
	add	r0, r0, r2
	ldr	lr, [r5, #1592]
	and	r0, r0, #7
	cmp	r9, #0
	rsb	r2, r2, r0
	add	r2, r2, lr
	strb	r2, [r1, #10]
	ldr	r2, [r5, #1584]
	movge	ip, r9
	add	ip, r2, ip, asr #3
	str	ip, [r3, #1292]
	ldrb	r2, [r6, #3437]
	cmp	r2, #0
	bne	.L853
	ldrb	r1, [r6, #3517]
	cmp	r1, #1
	beq	.L866
.L853:
	rsb	r8, r10, r8
	mov	r3, #0
	add	r8, r4, r8
	add	r1, r8, #1280
	add	r2, r8, #1264
	str	r3, [r1, #8]
	mov	r8, r1
	strb	r3, [r2, #19]
	str	r3, [r8, #16]
.L854:
	mov	r0, r4
	bl	MP4_Record_SlcSegID
	mov	r0, r9
.L861:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L847:
	ldrb	r3, [r5, #744]
	add	r2, r4, #16384
	strb	r3, [r9, #8]
	ldrb	r3, [r5, #748]
	strb	r3, [r9, #7]
	b	.L851
.L862:
	add	r3, r4, #20480
	add	r1, r4, #15680
	add	r1, r1, #40
	ldr	r0, [r3, #2496]
	bl	MP4_ClearCurPacket
	mov	r0, r4
	add	r4, r4, #16384
	bl	MP4_ClearCurPic
	ldr	r2, .L867
	mov	r0, #1
	ldr	r3, [r4, #3600]
	ldr	r1, .L867+4
	bic	r3, r3, #432
	bic	r3, r3, #2
	str	r3, [r4, #3600]
	ldr	r3, [r6, #3324]
	bl	dprint_vfmw
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L864:
	sub	r0, fp, #76
	bl	BsSkip
	ldr	r2, [fp, #-80]
	b	.L849
.L865:
	mov	r1, #3
	sub	r0, fp, #76
	bl	BsSkip
	ldrb	r3, [r9, #8]
	ldr	r2, [fp, #-80]
	cmp	r3, #2
	bne	.L851
	mov	r1, #3
	sub	r0, fp, #76
	bl	BsSkip
	ldr	r2, [fp, #-80]
	b	.L851
.L866:
	ldr	r1, [r6, #3524]
	strb	r2, [r3, #1283]
	mov	r2, r1, asl #3
	str	r2, [r3, #1288]
	ldr	r2, [r6, #3520]
	str	r2, [r3, #1296]
	b	.L854
.L844:
	mov	r1, r9
	sub	r0, fp, #76
	bl	BsGet
	mov	r10, r8, asl #2
	mov	r8, r8, asl #5
	rsb	r3, r10, r8
	add	r3, r4, r3
	str	r0, [r3, #1300]
	b	.L846
.L863:
	mov	r2, r0
	mov	r3, r9
	ldr	r1, .L867+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L861
.L868:
	.align	2
.L867:
	.word	.LANCHOR1+1296
	.word	.LC51
	.word	.LC52
	.fnend
	.size	Mp4_Syntax_Slice_NotSH, .-Mp4_Syntax_Slice_NotSH
	.align	2
	.global	Mp4_Syntax_Slice_SH
	.type	Mp4_Syntax_Slice_SH, %function
Mp4_Syntax_Slice_SH:
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
	add	r10, r0, #12288
	mov	r5, r0
	movw	r3, #510
	mov	r9, r2
	ldr	r4, [r10, #3324]
	sub	r0, r4, #1
	str	r0, [fp, #-80]
	cmp	r0, r3
	bhi	.L883
	ldrb	r7, [r10, #3592]
	add	r3, r4, #1
	sub	r0, fp, #76
	str	r3, [r10, #3324]
	ubfx	r7, r7, #3, #4
	bl	BsInit
	add	r7, r7, #17
	sub	r0, fp, #76
	add	r6, r5, #20480
	mov	r1, r7
	bl	BsSkip
	mov	r3, r4, asl #2
	mov	r1, #5
	sub	r0, fp, #76
	mov	r8, r3
	str	r3, [fp, #-88]
	bl	BsGet
	ldrb	r7, [r6, #756]
	mov	ip, r4, asl #5
	movw	lr, #1206
	rsb	r2, r8, ip
	movw	r1, #1204
	add	r4, r5, r2
	mul	r0, r7, r0
	str	r0, [r4, #1300]
	ldrh	lr, [r5, lr]
	ldrh	r1, [r5, r1]
	mul	r1, r1, lr
	sub	r3, r1, #1
	cmp	r0, r3
	bhi	.L884
	mov	r1, #2
	sub	r0, fp, #76
	str	ip, [fp, #-84]
	bl	BsSkip
	mov	r1, #5
	sub	r0, fp, #76
	bl	BsGet
	strb	r0, [r4, #1281]
	sub	r0, fp, #76
	ldrb	r1, [r6, #744]
	strb	r1, [r4, #1280]
	ldrb	r1, [r6, #748]
	strb	r1, [r4, #1279]
	ldrb	r1, [r6, #752]
	strb	r1, [r4, #1277]
	ldrb	r1, [r6, #753]
	strb	r1, [r4, #1278]
	bl	BsPos
	ldr	ip, [fp, #-84]
	mov	r7, r0
	mov	r0, r0, asr #31
	rsb	r9, r7, r9, lsl #3
	str	r9, [r4, #1284]
	mov	r0, r0, lsr #29
	ldr	r3, [r6, #1592]
	add	r1, r7, r0
	cmp	r7, #0
	and	r1, r1, #7
	add	lr, r7, #7
	rsb	r1, r0, r1
	add	r9, r5, #16384
	add	r1, r1, r3
	strb	r1, [r4, #1282]
	ldr	r3, [r6, #1584]
	movge	lr, r7
	add	lr, r3, lr, asr #3
	str	lr, [r4, #1292]
	ldr	r3, [r9, #3600]
	orr	r3, r3, #16
	str	r3, [r9, #3600]
	ldrb	r3, [r10, #3437]
	cmp	r3, #0
	beq	.L885
.L873:
	ldr	r3, [fp, #-88]
	rsb	r4, r3, ip
	mov	r3, #0
	add	r4, r5, r4
	add	r1, r4, #1280
	add	r2, r4, #1264
	str	r3, [r1, #8]
	mov	r4, r1
	strb	r3, [r2, #19]
	str	r3, [r4, #16]
.L874:
	ldr	r3, [fp, #-80]
	mov	r2, r3, asl #2
	mov	r6, r3, asl #5
	rsb	r3, r2, r6
	add	r3, r5, r3
	ldr	r1, [r3, #1296]
	cmp	r1, #0
	bne	.L886
.L875:
	rsb	r6, r2, r6
	ldrb	r3, [r10, #3592]
	add	r6, r5, r6
	ubfx	r3, r3, #3, #4
	ldr	r2, [r6, #1284]
	add	r3, r3, r2
	str	r3, [r6, #1284]
.L876:
	mov	r0, r5
	bl	MP4_Record_SlcSegID
	mov	r0, r7
.L871:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L886:
	ldr	r1, [r3, #1288]
	add	r3, r3, #1280
	add	r3, r3, #4
	cmp	r1, #0
	beq	.L875
	ldrb	r2, [r10, #3592]
	ubfx	r2, r2, #3, #4
	add	r2, r2, r1
	str	r2, [r3, #4]
	b	.L876
.L885:
	ldrb	r1, [r10, #3517]
	cmp	r1, #1
	bne	.L873
	ldr	r1, [r10, #3524]
	strb	r3, [r4, #1283]
	mov	r3, r1, asl #3
	str	r3, [r4, #1288]
	ldr	r3, [r10, #3520]
	str	r3, [r4, #1296]
	b	.L874
.L883:
	add	r3, r5, #20480
	add	r1, r5, #15680
	add	r1, r1, #40
	ldr	r0, [r3, #2496]
	bl	MP4_ClearCurPacket
	mov	r0, r5
	add	r5, r5, #16384
	bl	MP4_ClearCurPic
	ldr	r2, .L887
	mov	r0, #1
	ldr	r3, [r5, #3600]
	ldr	r1, .L887+4
	bic	r3, r3, #432
	bic	r3, r3, #2
	str	r3, [r5, #3600]
	ldr	r3, [r10, #3324]
	bl	dprint_vfmw
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L884:
	mov	r2, r0
	ldr	r1, .L887+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L871
.L888:
	.align	2
.L887:
	.word	.LANCHOR1+1320
	.word	.LC51
	.word	.LC53
	.fnend
	.size	Mp4_Syntax_Slice_SH, .-Mp4_Syntax_Slice_SH
	.align	2
	.global	MP4_Dec_Slice
	.type	MP4_Dec_Slice, %function
MP4_Dec_Slice:
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
	add	ip, r0, #12288
	mov	r4, r0
	ldrb	r3, [ip, #3592]
	tst	r3, #1
	beq	.L899
	tst	r3, #4
	beq	.L900
	mov	r0, r4
	bl	Mp4_Syntax_Slice_SH
	cmn	r0, #1
	beq	.L897
.L893:
	mov	r0, #0
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L900:
	movw	r0, #3592
	ldrh	r0, [ip, r0]
	ubfx	r0, r0, #7, #4
	sub	lr, r0, #1
	cmp	lr, #6
	bfils	r3, r0, #3, #4
	mov	r0, r4
	strlsb	r3, [ip, #3592]
	bl	Mp4_Syntax_Slice_SH
	cmn	r0, #1
	bne	.L893
.L897:
	add	r3, r4, #20480
	add	r1, r4, #15680
	add	r1, r1, #40
	ldr	r0, [r3, #2496]
	bl	MP4_ClearCurPacket
	ldr	r2, .L902
	ldr	r1, .L902+4
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L899:
	str	r2, [fp, #-28]
	str	r1, [fp, #-24]
	bl	Mp4_Check_Slice_NotSH
	ldr	r1, [fp, #-24]
	ldr	r2, [fp, #-28]
	cmp	r0, #0
	beq	.L901
	mov	r1, r2
	mov	r0, r4
	bl	Mp4_Combine_SliceData
	cmp	r0, #0
	bne	.L897
	mov	r0, r4
	bl	MP4_Record_SlcSegID
	b	.L893
.L901:
	mov	r0, r4
	bl	Mp4_Syntax_Slice_NotSH
	cmn	r0, #1
	beq	.L897
	mov	r0, #0
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L903:
	.align	2
.L902:
	.word	.LANCHOR1+1340
	.word	.LC54
	.fnend
	.size	MP4_Dec_Slice, .-MP4_Dec_Slice
	.align	2
	.global	MP4_Record_PacketID
	.type	MP4_Record_PacketID, %function
MP4_Record_PacketID:
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
	add	r5, r0, #20480
	mov	r4, r0
	ldr	r3, [r5, #2052]
	cmp	r3, #62
	bgt	.L907
	add	r1, r0, #12288
	add	r4, r0, r3, lsl #2
	add	r4, r4, #20480
	add	r2, r3, #1
	ldr	r0, [r1, #3448]
	str	r0, [r4, #1796]
	str	r2, [r5, #2052]
	ldrb	r2, [r1, #3437]
	cmp	r2, #0
	ldmnefd	sp, {r4, r5, fp, sp, pc}
	ldrb	r2, [r1, #3517]
	cmp	r2, #1
	addeq	r3, r3, #2
	ldreq	r2, [r1, #3528]
	streq	r2, [r4, #1800]
	streq	r3, [r5, #2052]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L907:
	bl	MP4_Clean_HeadPacket
	add	r1, r4, #15680
	ldr	r0, [r5, #2496]
	add	r1, r1, #40
	bl	MP4_ClearCurPacket
	ldr	r2, [r5, #2052]
	mov	r3, #62
	ldr	r1, .L908
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L909:
	.align	2
.L908:
	.word	.LC42
	.fnend
	.size	MP4_Record_PacketID, .-MP4_Record_PacketID
	.align	2
	.global	MP4_Record_HeadPacketInfo
	.type	MP4_Record_HeadPacketInfo, %function
MP4_Record_HeadPacketInfo:
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
	subs	r4, r0, #0
	mov	r7, r1
	beq	.L914
	ldr	r6, .L916
	add	r1, r4, #15680
	add	r0, r4, #22016
	add	r1, r1, #40
	mov	r2, #160
	add	r0, r0, #96
	ldr	r3, [r6, #52]
	add	r5, r4, #20480
	blx	r3
	add	r1, r4, #15872
	ldr	r3, [r6, #52]
	add	r1, r1, #8
	mov	r2, #4
	add	r0, r4, #22272
	blx	r3
	ldr	r3, [r5, #2060]
	str	r7, [r5, #2056]
	cmp	r3, #0
	beq	.L915
.L913:
	ldr	r3, [r5, #2064]
	add	r3, r3, #1
	str	r3, [r5, #2064]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L915:
	mov	r0, r4
	bl	MP4_Record_PacketID
	mov	r3, #1
	str	r3, [r5, #2060]
	b	.L913
.L914:
	ldr	r1, .L916+4
	mov	r0, #1
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L917:
	.align	2
.L916:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC55
	.fnend
	.size	MP4_Record_HeadPacketInfo, .-MP4_Record_HeadPacketInfo
	.align	2
	.global	Mp4_Syntax_Parse
	.type	Mp4_Syntax_Parse, %function
Mp4_Syntax_Parse:
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
	ldr	r9, .L1069
	mov	r6, r0
	mov	r7, r1
	mov	r4, r2
	str	r2, [fp, #-120]
	mov	r1, #0
	ldr	r3, [r9, #48]
	mov	r2, #32
	sub	r0, fp, #108
	add	r8, r6, #16384
	blx	r3
	mov	r2, r4
	mov	r1, r7
	sub	r0, fp, #108
	bl	BsInit
	sub	r0, fp, #108
	mov	r1, #32
	mov	r10, #0
	bl	BsShow
	movw	r3, #510
	str	r10, [r8, #3604]
	cmp	r0, r3
	mov	r5, r0
	beq	.L1048
	add	r1, r6, #12288
	ldrb	r3, [r1, #3592]
	tst	r3, #1
	beq	.L1049
.L924:
	add	r4, r6, #20480
	mov	r5, #196
	mov	r2, #1
	strb	r2, [r4, #813]
.L925:
	and	r3, r3, #2
	ands	r3, r3, #255
	bne	.L926
	ldr	r2, [r8, #3600]
	ands	r10, r2, #130
	bne	.L1050
	cmp	r5, #197
	beq	.L1051
	cmp	r5, #432
	beq	.L1052
	movw	r3, #437
	cmp	r5, r3
	beq	.L1053
	bic	r3, r5, #15
	cmp	r3, #288
	beq	.L1054
	movw	r3, #435
	cmp	r5, r3
	beq	.L1055
	movw	r3, #438
	cmp	r5, r3
	beq	.L1056
	cmp	r5, #196
	beq	.L1057
	movw	r3, #434
	cmp	r5, r3
	beq	.L1058
	movw	r3, #286
	cmp	r5, r3
	bne	.L941
	ldr	r3, .L1069+4
	ldr	r10, [r3]
	cmp	r10, #0
	beq	.L942
	mov	r3, #0
	mov	r1, #112
	mov	r2, r3
	ldr	r0, [r4, #2496]
	blx	r10
.L942:
	ldr	r3, [fp, #-120]
	add	r1, r6, #15680
	ldr	r0, [r4, #2496]
	add	r1, r1, #40
	sub	r3, r3, #4
	str	r3, [fp, #-120]
	bl	MP4_ClearCurPacket
	ldr	r3, [r8, #3600]
	add	r2, r7, #4
	str	r2, [fp, #-124]
	tst	r3, #2
	orrne	r3, r3, #256
	strne	r3, [r8, #3600]
.L943:
	ldrb	r3, [r4, #2533]
	mov	r10, #0
	cmp	r3, #1
	beq	.L980
.L949:
	ldrb	r3, [r4, #1575]
	cmp	r3, #1
	bne	.L1043
	ldr	r3, [r4, #2072]
	add	r1, r6, #19968
	add	r0, r6, #21248
	add	r1, r1, #48
	add	r3, r3, #1
	mov	r2, #604
	str	r3, [r4, #2072]
	add	r0, r0, #76
	mov	r3, #0
	ldr	r5, [r9, #52]
	str	r3, [r4, #2076]
	blx	r5
	ldr	r2, [r4, #1508]
	ldr	r0, [r8, #3716]
	ldr	r1, [r8, #3712]
	cmp	r2, r0
	beq	.L1059
.L968:
	ldr	r3, .L1069+4
	ldr	r5, [r3]
	cmp	r5, #0
	beq	.L970
	ldr	lr, [r4, #1512]
	mov	r3, #8
	strh	r2, [fp, #-114]
	sub	r2, fp, #116
	strh	r1, [fp, #-112]
	mov	r1, #2
	strh	r0, [fp, #-110]
	strh	lr, [fp, #-116]
	ldr	r0, [r4, #2496]
	blx	r5
	ldr	r0, [r8, #3716]
	ldr	r1, [r8, #3712]
.L970:
	mov	r5, #1
	str	r0, [r4, #1508]
	str	r1, [r4, #1512]
.L969:
	sxtb	r5, r5
	cmp	r5, #1
	beq	.L1060
.L972:
	ldr	r3, [r4, #1508]
	mov	r2, #0
	ldr	r1, [r4, #1512]
	str	r3, [r4, #2096]
	str	r1, [r4, #2092]
	ldr	r3, [r8, #3716]
	str	r3, [r4, #1508]
	ldr	r3, [r8, #3712]
	strb	r2, [r4, #1575]
	str	r3, [r4, #1512]
	b	.L1043
.L1050:
	orr	r2, r2, #32
	mov	r10, r3
	str	r2, [r8, #3600]
	mov	r3, #1
	str	r3, [r8, #3604]
.L1043:
	mov	r0, r10
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L926:
	ldr	r2, [fp, #-120]
	mov	r1, r7
	mov	r0, r6
	bl	MP4_Dec_Slice
	mov	r10, r0
.L930:
	ldrb	r3, [r4, #2533]
	str	r7, [fp, #-124]
	cmp	r3, #1
	beq	.L980
	ldr	r3, [fp, #-120]
	cmp	r10, r3, asl #3
	bhi	.L948
.L1065:
	movw	r3, #438
	cmp	r5, r3
	cmpne	r5, #196
	bne	.L949
	ldr	r3, [r8, #3600]
	tst	r3, #130
	beq	.L949
	ldrb	r3, [r4, #813]
	cmp	r3, #2
	beq	.L1061
	ldr	r1, [r4, #1512]
	ldr	r0, [r4, #1508]
	cmp	r1, #0
	str	r1, [r4, #2100]
	str	r0, [r4, #2104]
	beq	.L953
	ldr	r3, [r4, #2092]
	cmp	r1, r3
	beq	.L953
.L988:
	mov	r8, #1
.L954:
	ldr	r3, .L1069+4
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L958
	ldr	lr, [r4, #2092]
	mov	r3, #8
	ldr	r5, [r4, #2096]
	sub	r2, fp, #116
	strh	r1, [fp, #-112]
	mov	r1, #2
	strh	r0, [fp, #-110]
	strh	lr, [fp, #-116]
	strh	r5, [fp, #-114]
	ldr	r0, [r4, #2496]
	blx	ip
.L958:
	sxtb	r8, r8
	cmp	r8, #1
	beq	.L1062
.L960:
	ldr	r2, [r4, #2100]
	ldr	r3, [r4, #2104]
	str	r2, [r4, #2092]
	str	r3, [r4, #2096]
.L952:
	add	r1, r6, #20992
	add	r0, r6, #21760
	ldr	r3, [r9, #52]
	mov	r2, #60
	add	r1, r1, #232
	add	r0, r0, #168
	blx	r3
	ldr	r1, .L1069+8
	mov	r0, #2
	bl	dprint_vfmw
	ldr	r3, [fp, #-124]
	ldr	r2, [r4, #2076]
	rsb	r3, r7, r3
	add	r10, r10, r3, lsl #3
	add	r3, r2, #1
	str	r3, [r4, #2076]
	mov	r0, r10
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1049:
	mov	r2, r0, lsr #8
	add	r4, r6, #20480
	sub	r2, r2, #128
	mov	r0, #2
	cmp	r2, #3
	strb	r0, [r4, #813]
	ldrlsb	r3, [r1, #3592]
	orrls	r3, r3, r0
	strlsb	r3, [r1, #3592]
	b	.L925
.L953:
	cmp	r0, #0
	beq	.L955
	ldr	r3, [r4, #2096]
	cmp	r0, r3
	beq	.L1063
	cmp	r1, #0
	beq	.L988
	ldr	r3, [r4, #2092]
	cmp	r1, r3
	bne	.L988
	mov	r8, #1
	b	.L981
.L980:
	ldr	r1, [r8, #3712]
	cmp	r1, #0
	beq	.L946
	ldr	r2, [r8, #3716]
	cmp	r2, #0
	bne	.L1064
.L946:
	mov	r3, #0
	strb	r3, [r4, #2533]
	ldr	r3, [fp, #-120]
	cmp	r10, r3, asl #3
	bls	.L1065
.L948:
	ldr	r1, .L1069+12
	mov	r0, #2
	bl	dprint_vfmw
	ldr	r2, [fp, #-124]
	ldr	r3, [r8, #3600]
	rsb	r10, r7, r2
	bic	r3, r3, #432
	mov	r10, r10, asl #3
	bic	r3, r3, #2
	str	r3, [r8, #3600]
	mov	r0, r10
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1048:
	ldr	r3, [r9, #52]
	mov	r2, #32
	sub	r1, fp, #108
	sub	r0, fp, #76
	blx	r3
	mov	r1, #32
	sub	r0, fp, #76
	bl	BsSkip
	mov	r1, #32
	sub	r0, fp, #76
	bl	BsGet
	mov	r1, #32
	mov	r4, r0
	sub	r0, fp, #76
	bl	BsGet
	movw	r2, #20036
	movw	r3, #20553
	movt	r2, 17221
	movt	r3, 18515
	cmp	r0, r2
	cmpeq	r4, r3
	bne	.L920
	ldr	r3, .L1069+4
	add	r4, r6, #20480
	mov	r2, #1
	strb	r2, [r4, #2532]
	ldr	r5, [r3]
	cmp	r5, r10
	beq	.L921
	mov	r3, r10
	mov	r2, r10
	mov	r1, #117
	ldr	r0, [r4, #2496]
	blx	r5
.L921:
	ldr	r3, [r8, #3600]
	add	r1, r6, #15680
	add	r1, r1, #40
	mov	r10, #0
	tst	r3, #130
	orrne	r3, r3, #32
	strne	r3, [r8, #3600]
	movne	r2, #1
	strne	r2, [r8, #3604]
	ldr	r0, [r4, #2496]
	bl	MP4_ClearCurPacket
	b	.L1043
.L920:
	add	r3, r6, #12288
	ldrb	r3, [r3, #3592]
	tst	r3, #1
	bne	.L924
	add	r4, r6, #20480
	mov	r2, #2
	strb	r2, [r4, #813]
	b	.L925
.L941:
	ldr	r3, [fp, #-120]
	add	r1, r6, #15680
	ldr	r0, [r4, #2496]
	add	r1, r1, #40
	sub	r3, r3, #4
	str	r3, [fp, #-120]
	add	r3, r7, #4
	str	r3, [fp, #-124]
	bl	MP4_ClearCurPacket
	b	.L943
.L1052:
	ldr	r1, .L1069+16
	mov	r0, #2
	bl	dprint_vfmw
	str	r10, [r4, #2108]
	mov	r1, r7
	ldr	r2, [fp, #-120]
	mov	r0, r6
	bl	Mp4_Syntax_Vos
	mov	r1, r5
	mov	r10, r0
	mov	r0, r6
	bl	MP4_Record_HeadPacketInfo
	b	.L930
.L955:
	ldr	r8, [r4, #2500]
	subs	r8, r8, #1
	movne	r8, #1
	cmp	r1, #0
	beq	.L958
.L982:
	ldr	r3, [r4, #2092]
	cmp	r1, r3
	bne	.L954
.L957:
	cmp	r0, #0
	beq	.L958
.L981:
	ldr	r3, [r4, #2096]
	cmp	r3, r0
	beq	.L958
	b	.L954
.L1056:
	ldr	r1, .L1069+20
	mov	r0, #2
	bl	dprint_vfmw
	ldr	r3, [fp, #-120]
	cmp	r3, #4
	beq	.L1066
	ldr	r2, [fp, #-120]
	mov	r1, r7
	mov	r0, r6
	bl	Mp4_Syntax_Vop
	ldr	r3, [r8, #3600]
	tst	r3, #2
	mov	r10, r0
	bne	.L937
	add	r1, r6, #15680
	ldr	r0, [r4, #2496]
	add	r1, r1, #40
	bl	MP4_ClearCurPacket
.L936:
	mov	r2, r10
	ldr	r1, .L1069+24
	mov	r0, #7
	bl	dprint_vfmw
	b	.L930
.L1059:
	ldr	r3, [r4, #1512]
	cmp	r3, r1
	bne	.L968
	ldr	r5, [r4, #2500]
	subs	r5, r5, #1
	movne	r5, #1
	b	.L969
.L1053:
	ldr	r1, .L1069+28
	mov	r0, #2
	bl	dprint_vfmw
	mov	r3, #1
	mov	r1, r7
	ldr	r2, [fp, #-120]
	str	r3, [r4, #2108]
	mov	r0, r6
	bl	Mp4_Syntax_Vo
	mov	r1, r5
	mov	r10, r0
	mov	r0, r6
	bl	MP4_Record_HeadPacketInfo
	b	.L930
.L1054:
	ldr	r1, .L1069+32
	mov	r0, #2
	bl	dprint_vfmw
	mov	r3, #2
	ldr	r2, [fp, #-120]
	mov	r1, r7
	str	r3, [r4, #2108]
	mov	r0, r6
	bl	Mp4_Syntax_Vol
	mov	r1, r5
	mov	r10, r0
	mov	r0, r6
	bl	MP4_Record_HeadPacketInfo
	ldrb	r3, [r4, #1575]
	cmp	r3, #1
	beq	.L930
	ldrb	r3, [r4, #1576]
	cmp	r3, #1
	bne	.L930
	add	r1, r6, #20480
	add	r0, r6, #19968
	add	r1, r1, #140
	add	r0, r0, #48
	ldr	ip, [r9, #52]
	mov	r2, #604
	str	r3, [fp, #-124]
	blx	ip
	ldr	r3, [fp, #-124]
	strb	r3, [r4, #1575]
	strb	r3, [r4, #805]
	b	.L930
.L1051:
	ldr	r1, .L1069+36
	mov	r0, #2
	bl	dprint_vfmw
	add	r1, r6, #15680
	add	r1, r1, #40
	ldr	r0, [r4, #2496]
	bl	MP4_ClearCurPacket
	b	.L1043
.L1063:
	ldr	r8, [r4, #2500]
	subs	r8, r8, #1
	movne	r8, #1
	cmp	r1, #0
	beq	.L957
	b	.L982
.L1061:
	ldrb	r3, [r4, #744]
	cmp	r3, #2
	beq	.L951
	ldr	r2, [r4, #1524]
	ldr	r3, [r4, #1516]
	ldr	r0, [r4, #1520]
	str	r2, [r4, #1528]
	add	r2, r2, r3
	str	r2, [r4, #1524]
	ldr	r3, [r8, #3704]
	ldr	r1, [r4, #1536]
	mla	r3, r3, r2, r0
	rsb	r2, r1, r3
	str	r2, [r4, #1540]
	str	r3, [r4, #1532]
	str	r3, [r4, #1536]
	b	.L952
.L1055:
	ldr	r1, .L1069+40
	mov	r0, #2
	bl	dprint_vfmw
	mov	r3, #3
	mov	r1, r7
	ldr	r2, [fp, #-120]
	str	r3, [r4, #2108]
	mov	r0, r6
	bl	Mp4_Syntax_Gop
	mov	r1, r5
	mov	r10, r0
	mov	r0, r6
	bl	MP4_Record_HeadPacketInfo
	b	.L930
.L1064:
	mov	r0, r6
	bl	Frame_Init
	cmp	r0, #0
	beq	.L946
	ldr	r1, .L1069+44
	mov	r0, #0
	bl	dprint_vfmw
	b	.L946
.L1057:
	ldr	r1, .L1069+48
	mov	r0, #2
	bl	dprint_vfmw
	ldr	r2, [fp, #-120]
	mov	r1, r7
	mov	r0, r6
	bl	Mp4_Syntax_ShortHeader
	ldr	r3, [r8, #3600]
	tst	r3, #2
	mov	r10, r0
	beq	.L1044
	mov	r1, #196
	mov	r0, r6
	bl	MP4_Record_HeadPacketInfo
	b	.L930
.L1058:
	ldr	r1, .L1069+52
	mov	r0, #2
	bl	dprint_vfmw
	ldr	r2, [fp, #-120]
	mov	r1, r7
	mov	r0, r6
	bl	Mp4_Syntax_UserData
	mov	r10, r0
.L1044:
	add	r1, r6, #15680
	ldr	r0, [r4, #2496]
	add	r1, r1, #40
	bl	MP4_ClearCurPacket
	b	.L930
.L1062:
	ldr	r1, [r4, #2516]
	ldr	r0, [r4, #2496]
	bl	FSP_GetFsImagePtr
	subs	r2, r0, #0
	beq	.L961
	ldr	r1, [r2, #528]
	add	r3, r2, #560
	ldr	r0, [r4, #2496]
	add	r5, r2, #544
	str	r3, [fp, #-120]
	str	r2, [fp, #-128]
	bl	FreeUsdByDec
	ldr	r2, [fp, #-128]
	ldr	r1, [r5, #-8]
	ldr	r0, [r4, #2496]
	add	ip, r2, #528
	str	r2, [fp, #-132]
	str	ip, [fp, #-128]
	bl	FreeUsdByDec
	ldr	r2, [fp, #-132]
	ldr	r0, [r4, #2496]
	ldr	r1, [r2, #544]
	bl	FreeUsdByDec
	ldr	r3, [fp, #-120]
	ldr	r0, [r4, #2496]
	ldr	r1, [r3, #-8]
	bl	FreeUsdByDec
	ldr	ip, [fp, #-128]
	ldr	r3, [fp, #-120]
	mov	r0, #0
	mov	r1, #0
	mov	r2, r8
	strd	r0, [ip]
	strd	r0, [r5, #-8]
	strd	r0, [r5]
	strd	r0, [r3, #-8]
	ldr	r1, [r4, #2516]
	ldr	r0, [r4, #2496]
	bl	FSP_ClearLogicFs
	mov	r2, r8
	ldr	r1, [r4, #2508]
	ldr	r0, [r4, #2496]
	bl	FSP_ClearLogicFs
	mov	r3, #0
	ldr	r0, [r4, #2496]
	str	r3, [r4, #2508]
	str	r3, [r4, #2516]
	bl	FSP_GetNullLogicFs
	str	r0, [r4, #2516]
	str	r0, [r4, #2508]
.L961:
	add	r5, r6, #22528
	mov	r3, #0
	add	r5, r5, #96
	str	r3, [r4, #2504]
	ldr	r0, [r4, #2496]
	mov	r1, r5
	bl	FSP_ClearNotInVoQueue
	ldr	r3, [r4, #1596]
	ldr	r2, [r3, #700]
	cmp	r2, #0
	bne	.L962
	ldr	r3, [r3, #28]
	cmp	r3, #25
	beq	.L1067
.L962:
	ldr	r0, [r4, #2496]
	bl	FSP_GetFspType
	cmp	r0, #0
	beq	.L1045
.L964:
	ldr	r2, [r4, #2104]
	mov	r0, r6
	ldr	r1, [r4, #2100]
	bl	Frame_Init
	cmp	r0, #0
	beq	.L960
	ldr	r1, .L1069+56
	mov	r0, #0
	bl	dprint_vfmw
	b	.L960
.L937:
	movw	r1, #438
	mov	r0, r6
	bl	MP4_Record_HeadPacketInfo
	b	.L936
.L951:
	ldr	r1, [r4, #1528]
	ldr	r2, [r4, #1516]
	ldr	r3, [r8, #3704]
	ldr	ip, [r4, #1520]
	add	r2, r2, r1
	ldr	r0, [r4, #1536]
	ldr	r1, [r4, #1540]
	mla	r3, r3, r2, ip
	rsb	r2, r0, r1
	add	r2, r2, r3
	str	r2, [r4, #1544]
	str	r3, [r4, #1532]
	b	.L952
.L1066:
	mov	r1, r5
	mov	r0, r6
	bl	MP4_Record_HeadPacketInfo
	b	.L936
.L1060:
	ldr	r1, [r4, #2516]
	ldr	r0, [r4, #2496]
	bl	FSP_GetFsImagePtr
	subs	r7, r0, #0
	beq	.L973
	ldr	r1, [r7, #528]
	add	r3, r7, #560
	ldr	r0, [r4, #2496]
	add	r9, r7, #544
	str	r3, [fp, #-120]
	bl	FreeUsdByDec
	ldr	r1, [r7, #536]
	add	r3, r7, #528
	ldr	r0, [r4, #2496]
	str	r3, [fp, #-124]
	bl	FreeUsdByDec
	ldr	r1, [r7, #544]
	ldr	r0, [r4, #2496]
	bl	FreeUsdByDec
	ldr	r7, [fp, #-120]
	ldr	r0, [r4, #2496]
	ldr	r1, [r7, #-8]
	bl	FreeUsdByDec
	ldr	r3, [fp, #-124]
	mov	r0, #0
	mov	r1, #0
	mov	r2, r5
	strd	r0, [r3]
	strd	r0, [r9, #-8]
	strd	r0, [r9]
	strd	r0, [r7, #-8]
	ldr	r1, [r4, #2516]
	ldr	r0, [r4, #2496]
	bl	FSP_ClearLogicFs
	mov	r2, r5
	ldr	r1, [r4, #2508]
	ldr	r0, [r4, #2496]
	bl	FSP_ClearLogicFs
	mov	r3, #0
	ldr	r0, [r4, #2496]
	str	r3, [r4, #2508]
	str	r3, [r4, #2516]
	bl	FSP_GetNullLogicFs
	str	r0, [r4, #2516]
	str	r0, [r4, #2508]
.L973:
	add	r5, r6, #22528
	mov	r3, #0
	add	r5, r5, #96
	str	r3, [r4, #2504]
	ldr	r0, [r4, #2496]
	mov	r1, r5
	bl	FSP_ClearNotInVoQueue
	ldr	r3, [r4, #1596]
	ldr	r2, [r3, #700]
	cmp	r2, #0
	bne	.L974
	ldr	r3, [r3, #28]
	cmp	r3, #25
	beq	.L1068
.L974:
	ldr	r0, [r4, #2496]
	bl	FSP_GetFspType
	cmp	r0, #0
	beq	.L1046
.L976:
	mov	r0, r6
	ldr	r2, [r4, #1508]
	ldr	r1, [r4, #1512]
	bl	Frame_Init
	cmp	r0, #0
	beq	.L972
	ldr	r1, .L1069+60
	mov	r0, #0
	bl	dprint_vfmw
	b	.L972
.L1067:
	ldr	r3, [r4, #2500]
	cmp	r3, #0
	bne	.L964
.L1045:
	mov	r0, r5
	bl	ResetVoQueue
	b	.L964
.L1068:
	ldr	r3, [r4, #2500]
	cmp	r3, #0
	bne	.L976
.L1046:
	mov	r0, r5
	bl	ResetVoQueue
	b	.L976
.L1070:
	.align	2
.L1069:
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_event_report
	.word	.LC67
	.word	.LC69
	.word	.LC57
	.word	.LC61
	.word	.LC62
	.word	.LC58
	.word	.LC59
	.word	.LC56
	.word	.LC60
	.word	.LC65
	.word	.LC63
	.word	.LC64
	.word	.LC66
	.word	.LC68
	.fnend
	.size	Mp4_Syntax_Parse, .-Mp4_Syntax_Parse
	.align	2
	.global	MP4_Combine_HdPacket
	.type	MP4_Combine_HdPacket, %function
MP4_Combine_HdPacket:
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
	add	r5, r0, #20480
	ldr	r3, [r5, #1632]
	cmp	r3, #0
	beq	.L1083
	add	r3, r0, #12288
	ldrb	r4, [r3, #3437]
	cmp	r4, #1
	beq	.L1084
	cmp	r4, #0
	bne	.L1079
	ldrb	r2, [r3, #3517]
	cmp	r2, #1
	bne	.L1079
	ldr	ip, .L1087
	add	r1, r0, #15744
	ldr	r2, [r3, #3444]
	add	r0, r0, #22016
	ldr	r3, [r5, #1644]
	add	r1, r1, #56
	ldr	ip, [ip, #52]
	add	r0, r0, #176
	add	r3, r3, r2
	mov	r2, #80
	str	r3, [r5, #1644]
	blx	ip
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1084:
	ldrb	r4, [r5, #1637]
	cmp	r4, #1
	beq	.L1085
	cmp	r4, #0
	bne	.L1078
	ldrb	r2, [r5, #1717]
	cmp	r2, #1
	bne	.L1078
	ldr	r2, [r3, #3444]
	mov	r0, r4
	ldr	r3, [r5, #1724]
	add	r3, r3, r2
	str	r3, [r5, #1724]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1079:
	movw	r2, #5432
	ldr	r1, .L1087+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1085:
	ldr	r1, [r3, #3440]
	ldr	r2, [r5, #1640]
	cmp	r1, r2
	bcc	.L1086
	ldr	r2, [r3, #3444]
	mov	r0, #0
	ldr	r3, [r5, #1644]
	add	r3, r3, r2
	str	r3, [r5, #1644]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1078:
	movw	r2, #5418
	ldr	r1, .L1087+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1086:
	ldr	r3, .L1087
	add	r1, r0, #15680
	add	r0, r0, #22016
	add	r1, r1, #40
	mov	r2, #80
	add	r0, r0, #176
	ldr	r3, [r3, #52]
	blx	r3
	mov	r3, #0
	strb	r4, [r5, #1717]
	mov	r0, r3
	strb	r3, [r5, #1637]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1083:
	ldr	r2, .L1087+8
	ldr	ip, [r2]
	cmp	ip, #0
	beq	.L1073
	ldr	r0, [r5, #2496]
	mov	r2, r3
	mov	r1, #103
	blx	ip
.L1073:
	ldr	r1, .L1087+12
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1088:
	.align	2
.L1087:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC35
	.word	g_event_report
	.word	.LC70
	.fnend
	.size	MP4_Combine_HdPacket, .-MP4_Combine_HdPacket
	.align	2
	.global	MP4_Renew_CurPacket
	.type	MP4_Renew_CurPacket, %function
MP4_Renew_CurPacket:
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
	bl	MP4_Combine_HdPacket
	cmn	r0, #1
	mov	r5, r0
	beq	.L1092
	ldr	r5, .L1093
	mov	r0, r4
	bl	MP4_Record_PacketID
	add	r1, r4, #22016
	add	r0, r4, #15680
	add	r1, r1, #96
	ldr	r3, [r5, #52]
	mov	r2, #160
	add	r0, r0, #40
	blx	r3
	add	r0, r4, #15744
	ldr	r3, [r5, #52]
	add	r1, r4, #22272
	mov	r2, #4
	add	r0, r0, #48
	blx	r3
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1092:
	add	r3, r4, #20480
	add	r1, r4, #15680
	add	r1, r1, #40
	ldr	r0, [r3, #2496]
	bl	MP4_ClearCurPacket
	movw	r2, #5448
	ldr	r1, .L1093+4
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r5
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1094:
	.align	2
.L1093:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC71
	.fnend
	.size	MP4_Renew_CurPacket, .-MP4_Renew_CurPacket
	.align	2
	.global	MP4_Check_CurPacket
	.type	MP4_Check_CurPacket, %function
MP4_Check_CurPacket:
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
	add	r4, r0, #12288
	add	r5, r0, #20480
	mov	r3, #0
	mov	r6, r0
	ldr	r2, [r4, #3440]
	sub	r0, fp, #60
	str	r2, [r5, #1584]
	ldr	r1, [r4, #3432]
	str	r1, [r5, #1580]
	ldr	r2, [r4, #3444]
	str	r3, [r5, #1592]
	str	r2, [r5, #1588]
	bl	BsInit
	sub	r0, fp, #60
	mov	r1, #32
	bl	BsShow
	ldrb	r2, [r4, #3592]
	tst	r2, #1
	mov	r3, r0
	beq	.L1121
	mov	r3, #1
	strb	r3, [r5, #813]
	ldrb	r3, [r4, #3592]
	tst	r3, #2
	bne	.L1098
	ldr	r2, [r5, #2056]
	mov	r0, #196
.L1102:
	movw	r3, #438
	cmp	r0, r3
	cmpeq	r2, r3
	beq	.L1109
	cmp	r0, #196
	cmpeq	r2, #196
	bne	.L1119
.L1109:
	ldr	r3, [r5, #2064]
	cmp	r3, #1
	bgt	.L1101
	b	.L1119
.L1121:
	mov	r2, r0, lsr #8
	mov	r1, #2
	sub	r2, r2, #128
	strb	r1, [r5, #813]
	cmp	r2, #3
	bls	.L1122
.L1097:
	ldrb	r2, [r4, #3592]
	tst	r2, #2
	ldr	r2, [r5, #2056]
	bne	.L1100
	movw	r1, #438
	cmp	r2, r1
	cmpne	r3, #196
	beq	.L1102
.L1101:
	mov	r0, r6
	bl	MP4_Clean_HeadPacket
.L1119:
	mov	r0, #0
.L1106:
	ldr	r3, [r4, #3432]
	cmp	r3, #0
	beq	.L1112
	ldr	r3, [r4, #3440]
	cmp	r3, #0
	mvneq	r0, #0
.L1118:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L1100:
	movw	r1, #438
	sub	r3, r3, #196
	rsb	r2, r1, r2
	clz	r3, r3
	clz	r2, r2
	mov	r3, r3, lsr #5
	mov	r2, r2, lsr #5
	orrs	r1, r3, r2
	beq	.L1103
	ldrb	r0, [r5, #1577]
	cmp	r0, #1
	orreq	r3, r3, #1
	cmp	r3, #0
	bne	.L1111
.L1103:
	mov	r0, r6
	bl	MP4_Renew_CurPacket
	b	.L1106
.L1098:
	ldr	r3, [r5, #2056]
	movw	r2, #438
	rsb	r2, r2, r3
	clz	r2, r2
	mov	r2, r2, lsr #5
.L1111:
	ldr	r3, [r5, #2060]
	cmp	r3, #1
	movne	r2, #0
	andeq	r2, r2, #1
	cmp	r2, #0
	beq	.L1119
	ldr	r3, [r5, #1644]
	cmp	r3, #4
	bne	.L1119
	b	.L1103
.L1122:
	ldrb	r2, [r4, #3592]
	orr	r2, r2, r1
	strb	r2, [r4, #3592]
	b	.L1097
.L1112:
	mvn	r0, #0
	b	.L1118
	.fnend
	.size	MP4_Check_CurPacket, .-MP4_Check_CurPacket
	.align	2
	.global	MPEG4DEC_Decode
	.type	MPEG4DEC_Decode, %function
MPEG4DEC_Decode:
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
	add	r4, r0, #20480
	mov	r6, r0
	mov	r5, r1
	ldr	r3, [r4, #2084]
	cmp	r3, #0
	beq	.L1124
	ldr	r3, [r1, #12]
	cmp	r3, #0
	ble	.L1124
	ldr	r3, [r1, #8]
	cmp	r3, #0
	beq	.L1124
	ldr	r3, [r1]
	cmp	r3, #0
	beq	.L1124
	ldr	r1, .L1226
	mov	r0, #2
	bl	dprint_vfmw
	ldr	r2, [r5, #8]
	ldr	r1, .L1226+4
	mov	r0, #7
	bl	dprint_vfmw
	ldr	r2, [r5, #12]
	ldr	r1, .L1226+8
	mov	r0, #7
	bl	dprint_vfmw
	ldrb	r2, [r5, #5]
	ldr	r1, .L1226+12
	mov	r0, #7
	bl	dprint_vfmw
	ldr	r2, [r5, #88]
	ldr	r1, .L1226+16
	mov	r0, #7
	bl	dprint_vfmw
	ldr	r2, [r5, #92]
	ldr	r1, .L1226+20
	mov	r0, #7
	bl	dprint_vfmw
	ldrb	r2, [r5, #85]
	ldr	r1, .L1226+24
	mov	r0, #7
	bl	dprint_vfmw
	ldr	r2, [r5, #12]
	ldr	r1, .L1226+28
	mov	r0, #7
	bl	dprint_vfmw
	ldr	r3, [r5]
	ldr	r1, .L1226+32
	mov	r0, #7
	add	r8, r6, #15680
	ldrb	r2, [r3]
	add	r8, r8, #40
	bl	dprint_vfmw
	ldr	r3, [r5]
	ldr	r1, .L1226+36
	mov	r0, #7
	ldrb	r2, [r3, #1]
	bl	dprint_vfmw
	ldr	r3, [r5]
	ldr	r1, .L1226+40
	mov	r0, #7
	ldrb	r2, [r3, #2]
	bl	dprint_vfmw
	ldr	r3, [r5]
	ldr	r1, .L1226+44
	mov	r0, #7
	ldrb	r2, [r3, #3]
	bl	dprint_vfmw
	ldr	r3, .L1226+48
	mov	r2, #160
	mov	r1, r5
	mov	r0, r8
	ldr	r3, [r3, #52]
	blx	r3
	mov	r1, r8
	mov	r0, r6
	bl	MP4_GetScdUpMsg
	mov	r0, r6
	bl	MP4_Check_CurPacket
	cmn	r0, #1
	mov	r7, r0
	beq	.L1212
	mov	r1, r8
	mov	r0, r6
	bl	MP4_GetScdUpMsg
	add	r3, r6, #12288
	mov	r2, #0
	mov	r0, r6
	ldr	r1, [r3, #3440]
	str	r1, [r4, #1584]
	ldr	r1, [r3, #3432]
	str	r1, [r4, #1580]
	ldr	r3, [r3, #3444]
	str	r2, [r4, #1592]
	str	r3, [r4, #1588]
	bl	Mp4_Get_DecMode
	ldr	r3, [r4, #1596]
	ldr	r2, [r3, #824]
	cmp	r2, #1
	beq	.L1213
.L1128:
	add	r7, r6, #16384
	ldr	r3, [r7, #3600]
	str	r3, [r4, #2536]
.L1129:
	ldr	r2, [r4, #1588]
	mov	r0, r6
	ldr	r1, [r4, #1580]
	bl	Mp4_Syntax_Parse
	ldr	lr, [r4, #1596]
	ldr	ip, [r4, #1580]
	ldr	r2, [r4, #1584]
	ldr	r3, [r4, #1588]
	mov	r1, r0, lsr #3
	and	r0, r0, #7
	rsb	r3, r1, r3
	add	ip, ip, r1
	str	r0, [r4, #1592]
	add	r2, r1, r2
	str	ip, [r4, #1580]
	str	r2, [r4, #1584]
	str	r3, [r4, #1588]
	ldr	r3, [lr, #824]
	cmp	r3, #1
	beq	.L1214
.L1130:
	ldr	r3, [r7, #3600]
	tst	r3, #288
	beq	.L1131
	bic	r3, r3, #432
	bic	r3, r3, #2
	str	r3, [r7, #3600]
	ldr	r3, [r4, #1628]
	cmp	r3, #2
	beq	.L1215
	cmp	r3, #1
	beq	.L1216
	cmp	r3, #4
	bne	.L1134
	ldrb	r3, [r4, #1448]
	cmp	r3, #0
	bne	.L1136
	ldr	r3, [r4, #2112]
	cmp	r3, #0
	moveq	r3, #2
	movne	r3, #1
	str	r3, [r4, #2112]
.L1134:
	mov	r0, r6
	bl	Mp4_Frame_Atr
	cmn	r0, #1
	mov	r7, r0
	beq	.L1217
	ldr	r1, [r4, #2508]
	ldr	r0, [r4, #2496]
	bl	FSP_GetFsImagePtr
	ldr	r1, [r4, #2516]
	mov	r8, r0
	ldr	r0, [r4, #2496]
	bl	FSP_GetFsImagePtr
	clz	r3, r8
	mov	r3, r3, lsr #5
	clz	r2, r0
	mov	ip, r0
	mov	r2, r2, lsr #5
	orrs	r9, r2, r3
	bne	.L1218
	ldrb	r1, [r4, #811]
	and	r10, r1, #253
	cmp	r10, #1
	beq	.L1219
	cmp	r1, #2
	beq	.L1220
.L1145:
	ldrb	r3, [r4, #1448]
	cmp	r3, #2
	beq	.L1155
	ldr	r3, [r4, #2504]
	ldr	r1, [r4, #2508]
	cmp	r3, #0
	ldr	r3, [r4, #2516]
	movgt	r2, #2
	movle	r2, #1
	cmp	r1, r3
	str	r2, [r4, #2504]
	beq	.L1153
	mov	r2, #0
	ldr	r0, [r4, #2496]
	bl	FSP_SetRef
	ldr	r1, [r4, #2508]
	ldr	r0, [r4, #2496]
	bl	FSP_GetDisplay
	cmp	r0, #3
	beq	.L1210
	mov	r2, #0
	ldr	r1, [r4, #2508]
	ldr	r0, [r4, #2496]
	bl	FSP_SetDisplay
.L1210:
	ldr	r3, [r4, #2516]
.L1153:
	str	r3, [r4, #2508]
	mov	r2, #1
	ldrb	r3, [r6, #1]
	strb	r3, [r6]
	ldr	r3, [r4, #2520]
	ldr	r1, [r4, #2524]
	str	r3, [r4, #2512]
	str	r1, [r4, #2516]
	ldrb	r3, [r6, #2]
	strb	r3, [r6, #1]
	ldr	r3, [r4, #1540]
	ldr	r0, [r4, #2496]
	str	r3, [r4, #2520]
	bl	FSP_SetRef
	ldr	r1, [r4, #2508]
	ldr	r0, [r4, #2496]
	bl	FSP_RemovePmv
	ldrb	r3, [r4, #1448]
	cmp	r3, #4
	bne	.L1155
	ldrb	r8, [r4, #808]
	cmp	r8, #0
	beq	.L1221
.L1165:
	mov	r7, #0
.L1205:
	mov	r0, r7
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1219:
	cmp	r3, #0
	bne	.L1143
	ldr	r3, [r4, #1596]
	ldr	r2, [r8, #160]
	ldr	r3, [r3]
	cmp	r2, r3
	bls	.L1145
	mov	r2, r10
	ldr	r1, [r4, #2524]
	ldr	r0, [r4, #2496]
	mvn	r7, #0
	bl	FSP_ClearLogicFs
	mov	r0, r6
	bl	MP4_ClearCurPic
	mov	r0, r6
	bl	MP4_Clean_HeadPacket
	ldr	r3, [r4, #1596]
	ldr	r2, [r8, #160]
	mov	r0, r10
	ldr	r1, .L1226+52
	ldr	r3, [r3]
	bl	dprint_vfmw
	mov	r0, r7
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1136:
	sub	r2, r3, #2
	tst	r2, #253
	bne	.L1139
	ldr	r2, [r4, #2112]
	cmp	r2, #2
	beq	.L1172
.L1139:
	cmp	r3, #1
	streq	r3, [r4, #2112]
	b	.L1134
.L1214:
	ldr	r3, [lr, #864]
	cmp	r3, #0
	beq	.L1130
	b	.L1165
.L1213:
	ldr	r3, [r3, #864]
	cmp	r3, #1
	bne	.L1128
	ldr	r3, [r4, #2536]
	add	r7, r6, #16384
	str	r3, [r7, #3600]
	b	.L1129
.L1155:
	mov	r2, r5
	mov	r1, #0
	mov	r0, r6
	bl	Mp4_Set_DecPar
	ldrb	r7, [r4, #1448]
	cmp	r7, #0
	bne	.L1222
	ldr	r3, [r4, #2112]
	cmp	r3, #0
	moveq	r3, #2
	movne	r3, #1
	str	r3, [r4, #2112]
	add	r3, r6, #1040
	str	r3, [r6, #1036]
	ldr	r1, [r4, #1596]
	ldr	r2, [r1, #856]
	cmp	r2, #1
	beq	.L1164
.L1163:
	cmp	r2, #2
	beq	.L1170
.L1164:
	cmp	r7, #0
	mov	r3, #0
	strb	r3, [r6, #1198]
	bne	.L1165
	ldr	r3, .L1226+56
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L1165
	sub	r2, fp, #44
	ldr	r0, [r4, #2496]
	mov	r3, #4
	mov	r1, #20
	str	r7, [r2, #-4]!
	blx	ip
	mov	r0, r7
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1222:
	sub	r3, r7, #2
	sub	r9, r7, #2
	clz	r9, r9
	tst	r3, #253
	mov	r9, r9, lsr #5
	bne	.L1159
	ldr	r3, [r4, #2112]
	cmp	r3, #2
	beq	.L1223
.L1159:
	cmp	r7, #1
	beq	.L1224
	add	r3, r6, #1040
	str	r3, [r6, #1036]
	ldr	r1, [r4, #1596]
	ldr	r2, [r1, #856]
	cmp	r2, #1
	bne	.L1163
	cmp	r3, #0
	moveq	r9, #0
	andne	r9, r9, #1
	cmp	r9, #0
	beq	.L1164
	mov	r3, #0
	str	r3, [r6, #1036]
	ldr	r1, [r4, #2524]
	mvn	r7, #0
	ldr	r0, [r4, #2496]
	bl	FSP_ClearLogicFs
	mov	r0, r6
	bl	MP4_ClearCurPic
	mov	r0, r6
	bl	MP4_Clean_HeadPacket
	b	.L1205
.L1215:
	ldrb	r3, [r4, #1448]
	cmp	r3, #0
	beq	.L1134
.L1133:
	mov	r0, r6
	mvn	r7, #0
	bl	MP4_ClearCurPic
	mov	r0, r6
	bl	MP4_Clean_HeadPacket
	b	.L1205
.L1216:
	ldrb	r3, [r4, #1448]
	cmp	r3, #2
	bne	.L1134
	b	.L1133
.L1221:
	ldr	r1, .L1226+60
	mov	r0, #11
	bl	dprint_vfmw
	ldr	r1, [r4, #2524]
	ldr	r0, [r4, #2496]
	bl	FSP_GetLogicFs
	ldr	r1, [r4, #2508]
	mov	r5, r0
	ldr	r0, [r4, #2496]
	bl	FSP_GetLogicFs
	cmp	r5, #0
	cmpne	r0, #0
	mov	r9, r0
	beq	.L1225
	ldr	r3, [r5, #608]
	cmp	r3, #0
	beq	.L1167
	ldr	r2, [r5, #616]
	cmp	r2, #0
	beq	.L1167
	ldr	r1, [r5, #612]
	cmp	r1, #0
	beq	.L1167
	ldr	r0, [r0, #608]
	mov	r7, #0
	ldr	r2, [r3, #16]
	cmp	r0, #0
	ldr	r3, [r1, #16]
	ldr	lr, [r4, #1508]
	ldrne	r1, [r0, #16]
	moveq	r1, r2
	ldr	ip, [r4, #1512]
	mov	r0, r6
	str	r1, [sp]
	mov	r1, r5
	stmib	sp, {ip, lr}
	bl	Vdm_Mem_Move
	b	.L1205
.L1224:
	str	r7, [r4, #2112]
	add	r3, r6, #1040
	str	r3, [r6, #1036]
	ldr	r1, [r4, #1596]
	ldr	r2, [r1, #856]
	cmp	r2, #1
	beq	.L1161
	cmp	r2, #2
	beq	.L1170
.L1161:
	mov	r3, #0
	strb	r3, [r6, #1198]
	b	.L1165
.L1220:
	cmp	r3, #0
	bne	.L1146
	ldr	r3, [r4, #1596]
	ldr	r1, [r8, #160]
	ldr	r3, [r3]
	cmp	r1, r3
	bhi	.L1147
	cmp	r2, #0
	bne	.L1148
	ldr	r2, [r0, #160]
	cmp	r3, r2
	bcs	.L1145
.L1148:
	ldr	r1, [r4, #2524]
	mov	r2, #1
	ldr	r0, [r4, #2496]
	mvn	r7, #0
	str	ip, [fp, #-56]
	bl	FSP_ClearLogicFs
	mov	r0, r6
	bl	MP4_ClearCurPic
	mov	r0, r6
	bl	MP4_Clean_HeadPacket
	ldr	r3, [r4, #1596]
	ldr	ip, [fp, #-56]
	mov	r0, #1
	ldr	r1, .L1226+64
	ldr	r3, [r3]
	ldr	r2, [ip, #160]
	bl	dprint_vfmw
	b	.L1205
.L1124:
	ldr	r1, .L1226+68
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r7, #0
	b	.L1205
.L1147:
	ldr	r1, [r4, #2524]
	mov	r2, #1
	ldr	r0, [r4, #2496]
	mvn	r7, #0
	bl	FSP_ClearLogicFs
	mov	r0, r6
	bl	MP4_ClearCurPic
	mov	r0, r6
	bl	MP4_Clean_HeadPacket
	ldr	r3, [r4, #1596]
	ldr	r2, [r8, #160]
	mov	r0, #1
	ldr	r1, .L1226+72
	ldr	r3, [r3]
	bl	dprint_vfmw
	b	.L1205
.L1172:
	mvn	r7, #0
	b	.L1205
.L1223:
	mov	r2, #1
	ldr	r1, [r4, #2524]
	ldr	r0, [r4, #2496]
	mvn	r7, #0
	bl	FSP_ClearLogicFs
	b	.L1205
.L1170:
	ldr	r2, [r1, #860]
	cmp	r2, #0
	andgt	r9, r9, #1
	movle	r9, #0
	cmp	r3, #0
	moveq	r3, #0
	andne	r3, r9, #1
	cmp	r3, #0
	beq	.L1164
	mov	r3, #0
	mov	r2, #1
	str	r3, [r6, #1036]
	mvn	r7, #0
	ldr	r1, [r4, #2524]
	ldr	r0, [r4, #2496]
	bl	FSP_ClearLogicFs
	ldr	r2, [r4, #1596]
	mov	r0, r6
	ldr	r3, [r2, #860]
	add	r3, r3, r7
	str	r3, [r2, #860]
	bl	MP4_ClearCurPic
	mov	r0, r6
	bl	MP4_Clean_HeadPacket
	b	.L1205
.L1143:
	mov	r2, r10
	ldr	r1, [r4, #2524]
	ldr	r0, [r4, #2496]
	mvn	r7, #0
	bl	FSP_ClearLogicFs
	mov	r0, r6
	bl	MP4_ClearCurPic
	mov	r0, r6
	bl	MP4_Clean_HeadPacket
	mov	r0, r10
	movw	r3, #3997
	ldr	r2, .L1226+76
	ldr	r1, .L1226+80
	bl	dprint_vfmw
	b	.L1205
.L1212:
	ldr	r1, .L1226+84
	mov	r0, #1
	bl	dprint_vfmw
	b	.L1205
.L1131:
	ldr	r1, .L1226+88
	mov	r0, #2
	bl	dprint_vfmw
	mvn	r7, #0
	b	.L1205
.L1218:
	movw	r3, #3983
	ldr	r2, .L1226+76
	ldr	r1, .L1226+92
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r7, #0
	b	.L1205
.L1217:
	ldr	r1, .L1226+96
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r6
	bl	MP4_ClearCurPic
	mov	r0, r6
	bl	MP4_Clean_HeadPacket
	b	.L1205
.L1146:
	ldr	r1, [r4, #2524]
	mov	r2, #1
	ldr	r0, [r4, #2496]
	mvn	r7, #0
	bl	FSP_ClearLogicFs
	mov	r0, r6
	bl	MP4_ClearCurPic
	mov	r0, r6
	bl	MP4_Clean_HeadPacket
	movw	r3, #4017
	ldr	r2, .L1226+76
	mov	r0, #1
	ldr	r1, .L1226+80
	bl	dprint_vfmw
	b	.L1205
.L1167:
	ldr	r1, [r4, #2524]
	mov	r2, #1
	ldr	r0, [r4, #2496]
	mvn	r7, #0
	bl	FSP_ClearLogicFs
	ldr	r1, [r5, #612]
	ldr	r3, [r4, #2524]
	mov	r0, #0
	ldr	r2, [r4, #2508]
	str	r1, [sp, #12]
	ldr	ip, [r5, #616]
	ldr	lr, [r4, #2516]
	ldr	r1, .L1226+100
	str	ip, [sp, #8]
	ldr	ip, [r5, #608]
	str	lr, [sp]
	str	ip, [sp, #4]
	bl	dprint_vfmw
	mov	r0, r6
	bl	MP4_ClearCurPic
	mov	r0, r6
	bl	MP4_Clean_HeadPacket
	b	.L1205
.L1225:
	ldr	r1, [r4, #2524]
	mov	r2, #1
	ldr	r0, [r4, #2496]
	mvn	r7, #0
	bl	FSP_ClearLogicFs
	mov	r3, r5
	movw	r2, #4222
	ldr	r1, .L1226+104
	str	r9, [sp]
	mov	r0, r8
	bl	dprint_vfmw
	mov	r0, r6
	bl	MP4_ClearCurPic
	mov	r0, r6
	bl	MP4_Clean_HeadPacket
	b	.L1205
.L1227:
	.align	2
.L1226:
	.word	.LC73
	.word	.LC74
	.word	.LC75
	.word	.LC76
	.word	.LC77
	.word	.LC78
	.word	.LC79
	.word	.LC80
	.word	.LC81
	.word	.LC82
	.word	.LC83
	.word	.LC84
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC93
	.word	g_event_report
	.word	.LC88
	.word	.LC95
	.word	.LC72
	.word	.LC94
	.word	.LANCHOR1+1356
	.word	.LC92
	.word	.LC85
	.word	.LC91
	.word	.LC87
	.word	.LC86
	.word	.LC90
	.word	.LC89
	.fnend
	.size	MPEG4DEC_Decode, .-MPEG4DEC_Decode
	.align	2
	.global	MPEG4DEC_GetImageWidth
	.type	MPEG4DEC_GetImageWidth, %function
MPEG4DEC_GetImageWidth:
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
	add	r0, r0, #20480
	ldr	r0, [r0, #1512]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MPEG4DEC_GetImageWidth, .-MPEG4DEC_GetImageWidth
	.align	2
	.global	MPEG4DEC_GetImageHeight
	.type	MPEG4DEC_GetImageHeight, %function
MPEG4DEC_GetImageHeight:
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
	add	r0, r0, #20480
	ldr	r0, [r0, #1508]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MPEG4DEC_GetImageHeight, .-MPEG4DEC_GetImageHeight
	.global	sprite_trajectory_len
	.global	default_inter_matrix
	.global	default_intra_matrix
	.global	scan_tables
	.section	.rodata
	.align	2
.LANCHOR1 = . + 0
	.type	default_intra_matrix, %object
	.size	default_intra_matrix, 256
default_intra_matrix:
	.word	8
	.word	17
	.word	18
	.word	19
	.word	21
	.word	23
	.word	25
	.word	27
	.word	17
	.word	18
	.word	19
	.word	21
	.word	23
	.word	25
	.word	27
	.word	28
	.word	20
	.word	21
	.word	22
	.word	23
	.word	24
	.word	26
	.word	28
	.word	30
	.word	21
	.word	22
	.word	23
	.word	24
	.word	26
	.word	28
	.word	30
	.word	32
	.word	22
	.word	23
	.word	24
	.word	26
	.word	28
	.word	30
	.word	32
	.word	35
	.word	23
	.word	24
	.word	26
	.word	28
	.word	30
	.word	32
	.word	35
	.word	38
	.word	25
	.word	26
	.word	28
	.word	30
	.word	32
	.word	35
	.word	38
	.word	41
	.word	27
	.word	28
	.word	30
	.word	32
	.word	35
	.word	38
	.word	41
	.word	45
	.type	default_inter_matrix, %object
	.size	default_inter_matrix, 256
default_inter_matrix:
	.word	16
	.word	17
	.word	18
	.word	19
	.word	20
	.word	21
	.word	22
	.word	23
	.word	17
	.word	18
	.word	19
	.word	20
	.word	21
	.word	22
	.word	23
	.word	24
	.word	18
	.word	19
	.word	20
	.word	21
	.word	22
	.word	23
	.word	24
	.word	25
	.word	19
	.word	20
	.word	21
	.word	22
	.word	23
	.word	24
	.word	26
	.word	27
	.word	20
	.word	21
	.word	22
	.word	23
	.word	25
	.word	26
	.word	27
	.word	28
	.word	21
	.word	22
	.word	23
	.word	24
	.word	26
	.word	27
	.word	28
	.word	30
	.word	22
	.word	23
	.word	24
	.word	26
	.word	27
	.word	28
	.word	30
	.word	31
	.word	23
	.word	24
	.word	25
	.word	27
	.word	28
	.word	30
	.word	31
	.word	33
	.type	scan_tables, %object
	.size	scan_tables, 768
scan_tables:
	.word	0
	.word	1
	.word	8
	.word	16
	.word	9
	.word	2
	.word	3
	.word	10
	.word	17
	.word	24
	.word	32
	.word	25
	.word	18
	.word	11
	.word	4
	.word	5
	.word	12
	.word	19
	.word	26
	.word	33
	.word	40
	.word	48
	.word	41
	.word	34
	.word	27
	.word	20
	.word	13
	.word	6
	.word	7
	.word	14
	.word	21
	.word	28
	.word	35
	.word	42
	.word	49
	.word	56
	.word	57
	.word	50
	.word	43
	.word	36
	.word	29
	.word	22
	.word	15
	.word	23
	.word	30
	.word	37
	.word	44
	.word	51
	.word	58
	.word	59
	.word	52
	.word	45
	.word	38
	.word	31
	.word	39
	.word	46
	.word	53
	.word	60
	.word	61
	.word	54
	.word	47
	.word	55
	.word	62
	.word	63
	.word	0
	.word	1
	.word	2
	.word	3
	.word	8
	.word	9
	.word	16
	.word	17
	.word	10
	.word	11
	.word	4
	.word	5
	.word	6
	.word	7
	.word	15
	.word	14
	.word	13
	.word	12
	.word	19
	.word	18
	.word	24
	.word	25
	.word	32
	.word	33
	.word	26
	.word	27
	.word	20
	.word	21
	.word	22
	.word	23
	.word	28
	.word	29
	.word	30
	.word	31
	.word	34
	.word	35
	.word	40
	.word	41
	.word	48
	.word	49
	.word	42
	.word	43
	.word	36
	.word	37
	.word	38
	.word	39
	.word	44
	.word	45
	.word	46
	.word	47
	.word	50
	.word	51
	.word	56
	.word	57
	.word	58
	.word	59
	.word	52
	.word	53
	.word	54
	.word	55
	.word	60
	.word	61
	.word	62
	.word	63
	.word	0
	.word	8
	.word	16
	.word	24
	.word	1
	.word	9
	.word	2
	.word	10
	.word	17
	.word	25
	.word	32
	.word	40
	.word	48
	.word	56
	.word	57
	.word	49
	.word	41
	.word	33
	.word	26
	.word	18
	.word	3
	.word	11
	.word	4
	.word	12
	.word	19
	.word	27
	.word	34
	.word	42
	.word	50
	.word	58
	.word	35
	.word	43
	.word	51
	.word	59
	.word	20
	.word	28
	.word	5
	.word	13
	.word	6
	.word	14
	.word	21
	.word	29
	.word	36
	.word	44
	.word	52
	.word	60
	.word	37
	.word	45
	.word	53
	.word	61
	.word	22
	.word	30
	.word	7
	.word	15
	.word	23
	.word	31
	.word	38
	.word	46
	.word	54
	.word	62
	.word	39
	.word	47
	.word	55
	.word	63
	.type	__FUNCTION__.15026, %object
	.size	__FUNCTION__.15026, 15
__FUNCTION__.15026:
	.ascii	"Mp4_Set_DecPar\000"
	.space	1
	.type	__FUNCTION__.15160, %object
	.size	__FUNCTION__.15160, 23
__FUNCTION__.15160:
	.ascii	"Mp4_Syntax_Slice_NotSH\000"
	.space	1
	.type	__FUNCTION__.15174, %object
	.size	__FUNCTION__.15174, 20
__FUNCTION__.15174:
	.ascii	"Mp4_Syntax_Slice_SH\000"
	.type	__FUNCTION__.15189, %object
	.size	__FUNCTION__.15189, 14
__FUNCTION__.15189:
	.ascii	"MP4_Dec_Slice\000"
	.space	2
	.type	__FUNCTION__.15063, %object
	.size	__FUNCTION__.15063, 16
__FUNCTION__.15063:
	.ascii	"MPEG4DEC_Decode\000"
	.data
	.align	2
.LANCHOR0 = . + 0
	.type	sprite_trajectory_len, %object
	.size	sprite_trajectory_len, 120
sprite_trajectory_len:
	.word	0
	.byte	2
	.space	3
	.word	2
	.byte	3
	.space	3
	.word	3
	.byte	3
	.space	3
	.word	4
	.byte	3
	.space	3
	.word	5
	.byte	3
	.space	3
	.word	6
	.byte	3
	.space	3
	.word	14
	.byte	4
	.space	3
	.word	30
	.byte	5
	.space	3
	.word	62
	.byte	6
	.space	3
	.word	126
	.byte	7
	.space	3
	.word	254
	.byte	8
	.space	3
	.word	510
	.byte	9
	.space	3
	.word	1022
	.byte	10
	.space	3
	.word	2046
	.byte	11
	.space	3
	.word	4094
	.byte	12
	.space	3
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"fatal stream error --- GOP marker_bit = 0\012\000"
	.space	1
.LC1:
	.ascii	"DivX%4dBuild%4d%c\000"
	.space	2
.LC2:
	.ascii	"DivX%4db%4d%c\000"
	.space	2
.LC3:
	.ascii	"FFmpe%*[^b]b%4d\000"
.LC4:
	.ascii	"FFmpeg v%4d.%4d.%4d / libavcodec build: %d\000"
	.space	1
.LC5:
	.ascii	"Lavc%d.%d.%d\000"
	.space	3
.LC6:
	.ascii	"ffmpeg\000"
	.space	1
.LC7:
	.ascii	"XviD%4d\000"
.LC8:
	.ascii	"fatal stream error --- VOP marker_bit = 0\012\000"
	.space	1
.LC9:
	.ascii	"VDH doesn't support SPRITE_STATIC & SPRITE_GMC\012\000"
.LC10:
	.ascii	"VDH doesn't support SPRITE_STATIC\012\000"
	.space	1
.LC11:
	.ascii	"Unknown sprite_enable\012\000"
	.space	1
.LC12:
	.ascii	"ERROR: not_8_bit !=0\012\000"
	.space	2
.LC13:
	.ascii	"not support no complexity_estimation_disable\012\000"
	.space	2
.LC14:
	.ascii	"not support data_partitioned\012\000"
	.space	2
.LC15:
	.ascii	"not support newpred_enable\012\000"
.LC16:
	.ascii	"not support reduced_resolution_vop_eanble\012\000"
	.space	1
.LC17:
	.ascii	"not support scalability\012\000"
	.space	3
.LC18:
	.ascii	"warning! profile_and_level_indication=%#x, maybe HD"
	.ascii	" pic...\012\000"
.LC19:
	.ascii	"actual frame size(%dx%d) exeed max config(%dx%d)\012"
	.ascii	"\000"
	.space	2
.LC20:
	.ascii	"MPEG4 Frame_Init return err!\012\000"
	.space	2
.LC21:
	.ascii	"MPEG4 Frame_Init PmvNum=%d, FrameNum=%d, error!\012"
	.ascii	"\000"
	.space	3
.LC22:
	.ascii	"partition fs memory fail!\012\000"
	.space	1
.LC23:
	.ascii	"ERROR: FSP_ConfigInstance fail!\012\000"
	.space	3
.LC24:
	.ascii	"dec_pts: %lld Usertag: %lld\012\000"
	.space	3
.LC25:
	.ascii	"get frame store fail!\012\000"
	.space	1
.LC26:
	.ascii	"%s %d  abnormal!\012\000"
	.space	2
.LC27:
	.ascii	"CurFsID(fwd%d,%d,bwd%d) abnormal!(%p,%p,%p)\012\000"
	.space	3
.LC28:
	.ascii	"MPEG4DEC Init  -----\012\000"
	.space	2
.LC29:
	.ascii	"-1 == VCTRL_GetChanIDByCtx() Err! \012\000"
.LC30:
	.ascii	"MPEG4DEC Init success -----\012\000"
	.space	3
.LC31:
	.ascii	"MPEG4 destroy\012\000"
	.space	1
.LC32:
	.ascii	"NVOP VDM copy process................\012\000"
	.space	1
.LC33:
	.ascii	"vop_coding_type = %d is not expected!\012\000"
	.space	1
.LC34:
	.ascii	" slice num %d is not extpected!\012\000"
	.space	3
.LC35:
	.ascii	" line %d packet is wrong!\012\000"
	.space	1
.LC36:
	.ascii	"pImg is null, pCurImg %#x pBwdImg %#x\012\000"
	.space	1
.LC37:
	.ascii	"FrameNum=%d\012\000"
	.space	3
.LC38:
	.ascii	"vop_coding_type=%d\012\000"
.LC39:
	.ascii	"line: %d pToQueImg is null!\012\000"
	.space	3
.LC40:
	.ascii	"CurImage %d is already out put\012\000"
.LC41:
	.ascii	"err(%d) > out_thr(%d)\012\000"
	.space	1
.LC42:
	.ascii	"StreamIDNum = %d > (%d)\012\000"
	.space	3
.LC43:
	.ascii	"Warning : vop slice num %d != 0\012\000"
	.space	3
.LC44:
	.ascii	"warning streamIDNum %d != 0 \012\000"
	.space	2
.LC45:
	.ascii	"vop ---%d\012\000"
	.space	1
.LC46:
	.ascii	"VDH doesn't support S_VOP\012\000"
	.space	1
.LC47:
	.ascii	"parse time_module_base stream not enough\012\000"
	.space	2
.LC48:
	.ascii	"module time base parse error, more than %d '1' was "
	.ascii	"found!\012\000"
	.space	1
.LC49:
	.ascii	"error: vop_coding_type = %d, but vop_fcode_forward "
	.ascii	"= 0\012\000"
.LC50:
	.ascii	"error: B vop, but vop_fcode_backward = 0\012\000"
	.space	2
.LC51:
	.ascii	"FUN: %s Invalid SlcNum = %d\012\000"
	.space	3
.LC52:
	.ascii	" pSlcPara->mb_start_num = %d, MbCnt = %d\012\000"
	.space	2
.LC53:
	.ascii	"pSlcPara->mb_start_num = %d, totalMbMin1 = %d\012\000"
	.space	1
.LC54:
	.ascii	"FUN: %s MP4_ClearCurPacket\012\000"
.LC55:
	.ascii	"pCtx is NUL!!!\012\000"
.LC56:
	.ascii	"Not find start code \012\000"
	.space	2
.LC57:
	.ascii	"VOS beginning ~ !\012\000"
	.space	1
.LC58:
	.ascii	"VO beginning ~ !\012\000"
	.space	2
.LC59:
	.ascii	"VOL beginning ~ !\012\000"
	.space	1
.LC60:
	.ascii	"GOP beginning ~ !\012\000"
	.space	1
.LC61:
	.ascii	"VOP beginning ~ !\012\000"
	.space	1
.LC62:
	.ascii	"BitUsed=%d\012\000"
.LC63:
	.ascii	"SHVOP beginning ~ !\012\000"
	.space	3
.LC64:
	.ascii	"USERDATA beginning ~ !\012\000"
.LC65:
	.ascii	"MPEG4 Frame_Init return err 3!\012\000"
.LC66:
	.ascii	"MPEG4 Frame_Init return err 1!\012\000"
.LC67:
	.ascii	"vop right\012\000"
	.space	1
.LC68:
	.ascii	"MPEG4 Frame_Init return err 2!\012\000"
.LC69:
	.ascii	"bits over boundary\012\000"
.LC70:
	.ascii	"pLastPacket->StreamPack[0].VirAddr is NULL!!\012\000"
	.space	2
.LC71:
	.ascii	"line %d MP4_Combine_HdPacket failed!!\012\000"
	.space	1
.LC72:
	.ascii	"bitsream para error -----\012\000"
	.space	1
.LC73:
	.ascii	"MPEG4DEC Decode -----\012\000"
	.space	1
.LC74:
	.ascii	"ptr_strm_para->PhyAddr0=0x%x\012\000"
	.space	2
.LC75:
	.ascii	"ptr_strm_para->Length0=%d\012\000"
	.space	1
.LC76:
	.ascii	"ptr_strm_para->IsLastSeg0=%d\012\000"
	.space	2
.LC77:
	.ascii	"ptr_strm_para->PhyAddr1=0x%x\012\000"
	.space	2
.LC78:
	.ascii	"ptr_strm_para->Length1=%d\012\000"
	.space	1
.LC79:
	.ascii	"ptr_strm_para->IsLastSeg1=%d\012\000"
	.space	2
.LC80:
	.ascii	"ptr_strm_para->Length0 = %d\012\000"
	.space	3
.LC81:
	.ascii	"byte0: = 0x%x\012\000"
	.space	1
.LC82:
	.ascii	"byte1: = 0x%x\012\000"
	.space	1
.LC83:
	.ascii	"byte2: = 0x%x\012\000"
	.space	1
.LC84:
	.ascii	"byte3: = 0x%x\012\000"
	.space	1
.LC85:
	.ascii	"MP4_Check_CurPacket failed!\012\000"
	.space	3
.LC86:
	.ascii	"Mp4_Frame_Atr return fail\012\000"
	.space	1
.LC87:
	.ascii	"fuction return value is null, %s %d!!\012\000"
	.space	1
.LC88:
	.ascii	"NVOP mem move--\012\000"
	.space	3
.LC89:
	.ascii	"line: %d pCur = %p, pFwd = %p\012\000"
	.space	1
.LC90:
	.ascii	"CurFsID(f%d,%d,b%d) abnormal!(%p,%p,%p)\012\000"
	.space	3
.LC91:
	.ascii	"bits not enought\012\000"
	.space	2
.LC92:
	.ascii	"fuction return value is null,%s %d!!\012\000"
	.space	2
.LC93:
	.ascii	"dec P/S frame, fwd ref err(%d) > ref_thr(%d)\012\000"
	.space	2
.LC94:
	.ascii	"dec B frame, bwd ref err(%d) > ref_thr(%d)\012\000"
.LC95:
	.ascii	"dec B frame, fwd ref err(%d) > ref_thr(%d)\012\000"
	.bss
	.align	2
.LANCHOR2 = . + 0
	.type	MemArrange.14964, %object
	.size	MemArrange.14964, 1144
MemArrange.14964:
	.space	1144
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
