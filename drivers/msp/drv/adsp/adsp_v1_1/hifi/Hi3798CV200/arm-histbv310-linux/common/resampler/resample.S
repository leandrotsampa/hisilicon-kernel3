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
	.file	"resample.c"

	.text
	.align	2
	.type	cvtShortShort, %function
cvtShortShort:
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
	ldr	ip, [fp, #4]
	sub	lr, ip, #2
	cmp	r3, #0
	cmpeq	ip, #2
	clz	lr, lr
	mov	lr, lr, lsr #5
	bne	.L2
	add	r2, r1, r2, lsl #1
	cmp	r1, r2
	beq	.L8
	add	r0, r0, #4
	sub	ip, r2, #2
	mov	r3, r1
.L4:
	ldrh	lr, [r3], #2
	add	r0, r0, #4
	cmp	r2, r3
	strh	lr, [r0, #-8]
	ldrh	lr, [ip, #2]!
	strh	lr, [r0, #-6]
	bne	.L4
	add	r0, r1, #2
	rsb	r0, r0, r2
	mov	r0, r0, lsr #1
	add	r0, r0, #1
	mov	r0, r0, asl #2
	mov	r0, r0, asr #1
	ldmfd	sp, {fp, sp, pc}
.L2:
	cmp	lr, #0
	movne	r2, r2, asl #1
	add	r2, r1, r2, lsl #1
	cmp	r1, r2
	beq	.L8
	mov	r3, r1
.L6:
	ldrh	ip, [r3], #2
	cmp	r2, r3
	strh	ip, [r0], #2
	bne	.L6
	add	r0, r1, #2
	rsb	r0, r0, r2
	bic	r0, r0, #1
	add	r0, r0, #2
	mov	r0, r0, asr #1
	ldmfd	sp, {fp, sp, pc}
.L8:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	cvtShortShort, .-cvtShortShort
	.align	2
	.type	cvt2int, %function
cvt2int:
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
	ldr	ip, [fp, #8]
	ldr	lr, [fp, #4]
	sub	r4, ip, #2
	clz	r4, r4
	cmp	lr, #0
	cmpeq	ip, #2
	mov	r4, r4, lsr #5
	bne	.L16
	cmp	r3, #16
	beq	.L36
	add	r2, r1, r2, lsl #2
	cmp	r1, r2
	beq	.L28
	add	r3, r0, #8
	sub	lr, r2, #4
	mov	ip, r1
.L20:
	ldr	r0, [ip], #4
	add	r3, r3, #8
	cmp	r2, ip
	str	r0, [r3, #-16]
	ldr	r0, [lr, #4]!
	str	r0, [r3, #-12]
	bne	.L20
	add	r0, r1, #4
	rsb	r0, r0, r2
	mov	r0, r0, lsr #2
	add	r0, r0, #1
	mov	r0, r0, asl #3
	mov	r0, r0, asr #2
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L16:
	cmp	r4, #0
	movne	r2, r2, asl #1
	cmp	r3, #16
	beq	.L37
	add	r2, r1, r2, lsl #2
	cmp	r1, r2
	beq	.L28
	mov	ip, r1
.L24:
	ldr	r3, [ip], #4
	cmp	r2, ip
	str	r3, [r0], #4
	bne	.L24
	add	r0, r1, #4
	rsb	r0, r0, r2
	bic	r0, r0, #3
	add	r0, r0, #4
	mov	r0, r0, asr #2
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L37:
	add	r2, r1, r2, lsl #1
	cmp	r1, r2
	beq	.L28
	mov	lr, r1
.L23:
	ldrsh	ip, [lr], #2
	cmp	r2, lr
	mov	ip, ip, asl #16
	str	ip, [r0], #4
	bne	.L23
	add	r0, r1, #2
	rsb	r2, r0, r2
	mov	r0, r2, lsr #1
	add	r0, r0, #1
	sbfx	r0, r0, #0, #30
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L36:
	add	r2, r1, r2, lsl #1
	cmp	r1, r2
	beq	.L28
	add	r0, r0, #8
	sub	lr, r2, #2
	mov	ip, r1
.L19:
	ldrsh	r3, [ip], #2
	add	r0, r0, #8
	cmp	r2, ip
	mov	r3, r3, asl #16
	str	r3, [r0, #-16]
	ldrsh	r3, [lr, #2]!
	mov	r3, r3, asl #16
	str	r3, [r0, #-12]
	bne	.L19
	add	r0, r1, #2
	rsb	r2, r0, r2
	mov	r0, r2, lsr #1
	add	r0, r0, #1
	mov	r0, r0, asl #3
	mov	r0, r0, asr #2
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L28:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	cvt2int, .-cvt2int
	.align	2
	.type	ResamplerStereoProcess24, %function
ResamplerStereoProcess24:
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
	ldr	r4, [fp, #4]
	mov	r5, r0
	ldr	lr, [r0, #40]
	mov	ip, #2
	str	r0, [fp, #-68]
	mov	r8, r3
	ldr	r0, [r0, #56]
	str	r4, [sp]
	str	ip, [sp, #4]
	ldr	ip, [r5, #72]
	str	r3, [fp, #-72]
	mov	r3, lr
	ldr	r4, [r5, #20]
	ldr	r10, [r5, #28]
	str	ip, [fp, #-52]
	bl	cvt2int
	sub	r2, r4, #1
	ldr	r3, [r5, #56]
	mov	ip, r5
	ldr	r7, [r5, #32]
	sub	r3, r3, r2, asl #3
	ldr	r2, [ip, #68]
	ldr	r6, [r5, #64]
	add	r7, r3, r7, lsl #2
	ldr	r5, [r5, #60]
	str	r2, [fp, #-60]
	mov	r2, r0, asl #2
	str	r2, [fp, #-64]
	add	r2, r3, r2
	str	r2, [fp, #-56]
	cmp	r2, r7
	bls	.L47
	add	r8, r8, #8
.L46:
	cmp	r4, #0
	ble	.L48
	mov	lr, #0
	sub	r1, r7, #20
	add	r2, r7, #16
	mov	r9, lr
	mov	r3, lr
	str	r7, [fp, #-48]
.L41:
	ldr	ip, [r6], #4
	ldr	r0, [r5], #4
	ldr	r7, [r1, #16]
#APP
	smlawb r3, r7, ip, r3
	ldr	r7, [r2, #-16]
#APP
	smlawb r9, r7, r0, r9
	ldr	r7, [r1, #12]
#APP
	smlawb r9, r7, ip, r9
	ldr	r7, [r2, #-12]
#APP
	smlawb r3, r7, r0, r3
	ldr	r7, [r1, #8]
#APP
	smlawt r3, r7, ip, r3
	ldr	r7, [r2, #-8]
#APP
	smlawt r9, r7, r0, r9
	ldr	r7, [r1, #4]
#APP
	smlawt r9, r7, ip, r9
	ldr	ip, [r2, #-4]
#APP
	smlawt r3, ip, r0, r3
	add	lr, lr, #2
	sub	r1, r1, #16
	cmp	r4, lr
	add	r2, r2, #16
	bgt	.L41
	add	r9, r9, #64
	ldr	r7, [fp, #-48]
	mov	r2, r9, asr #31
	mov	r0, r9, asr #7
	cmp	r2, r9, asr #30
	beq	.L51
	movw	r0, #65535
	add	r3, r3, #64
	movt	r0, 127
	eor	r0, r0, r2
	mov	r1, r3, asr #31
	mov	r2, r3, asr #7
	mov	r0, r0, asl #8
	mov	r3, r3, asr #30
.L43:
	cmp	r1, r3
	str	r0, [r8, #-8]
	biceq	r2, r2, #-16777216
	mov	r3, r8
	movwne	r2, #65535
	add	r8, r8, #8
	movtne	r2, 127
	eorne	r2, r2, r1
	mov	r2, r2, asl #8
	str	r2, [r8, #-12]
	ldr	r2, [fp, #-52]
	ldr	r2, [r2, r10, asl #2]
	ubfx	r5, r2, #8, #12
	mov	r6, r2, lsr #20
	uxtb	r1, r2
	mul	r5, r5, r4
	add	r7, r7, r1, lsl #2
	mul	r6, r6, r4
	ldr	r1, [fp, #-56]
	mov	r10, r2, asr #20
	ldr	r2, [fp, #-60]
	cmp	r1, r7
	add	r5, r2, r5, lsl #1
	add	r6, r2, r6, lsl #1
	bhi	.L46
	ldr	r2, [fp, #-72]
	rsb	r3, r2, r3
	mov	r3, r3, asr #2
	add	r3, r3, r3, lsr #31
	mov	r4, r3, asr #1
.L39:
	ldr	ip, [fp, #-68]
	mov	r3, #0
	ldr	r1, [fp, #-64]
	ldr	r2, [ip, #24]
	ldr	r0, [ip, #52]
	str	r10, [ip, #28]
	add	r1, r0, r1
	str	r6, [ip, #64]
	str	r5, [ip, #60]
	mov	r2, r2, asl #2
	str	r3, [ip, #32]
	bl	memmove
	mov	r0, r4
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L51:
	add	r3, r3, #64
	mov	r0, r0, asl #8
	mov	r2, r3, asr #7
	mov	r1, r3, asr #31
	mov	r3, r3, asr #30
	b	.L43
.L48:
	mov	r3, #0
	mov	r1, r3
	mov	r2, r3
	mov	r0, r3
	b	.L43
.L47:
	mov	r4, #0
	b	.L39
	.fnend
	.size	ResamplerStereoProcess24, .-ResamplerStereoProcess24
	.align	2
	.type	ResamplerMonoProcess24, %function
ResamplerMonoProcess24:
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
	mov	r5, r0
	mov	ip, #1
	str	r3, [fp, #-68]
	mov	r9, r3
	ldr	r3, [r0, #40]
	ldr	r0, [r0, #56]
	str	ip, [sp, #4]
	str	ip, [sp]
	ldr	ip, [r5, #28]
	ldr	r4, [r5, #20]
	str	ip, [fp, #-48]
	ldr	ip, [r5, #72]
	str	ip, [fp, #-60]
	bl	cvt2int
	ldr	r3, [r5, #56]
	mov	r2, r4, asl #2
	ldr	r8, [r5, #32]
	rsb	r2, r2, #4
	add	r3, r3, r2
	ldr	r6, [r5, #64]
	ldr	r7, [r5, #60]
	add	r8, r3, r8, lsl #2
	mov	r2, r0, asl #2
	str	r2, [fp, #-64]
	add	r2, r3, r2
	str	r2, [fp, #-56]
	cmp	r2, r8
	bls	.L70
	mov	r3, r9
	add	r10, r9, #4
	mov	r9, r5
.L68:
	cmp	r4, #0
	ble	.L54
	mov	ip, #0
	sub	r0, r8, #12
	add	r1, r8, #8
	mov	r3, ip
	mov	r2, ip
	str	r8, [fp, #-52]
.L55:
	ldr	r8, [r6], #4
	ldr	r5, [r7], #4
	ldr	lr, [r0, #8]
#APP
	smlawb r2, lr, r8, r2
	ldr	lr, [r1, #-8]
#APP
	smlawb r3, lr, r5, r3
	ldr	lr, [r0, #4]
#APP
	smlawt r2, lr, r8, r2
	ldr	r8, [r1, #-4]
#APP
	smlawt r3, r8, r5, r3
	add	ip, ip, #2
	sub	r0, r0, #8
	cmp	r4, ip
	add	r1, r1, #8
	bgt	.L55
	ldr	r1, [r9, #40]
	add	r3, r3, r2
	ldr	r8, [fp, #-52]
	cmp	r1, #16
	beq	.L77
	cmp	r1, #18
	beq	.L78
.L60:
	cmp	r1, #20
	beq	.L79
	add	r3, r3, #64
	mov	r1, r3, asr #31
	mov	r2, r3, asr #7
	cmp	r1, r3, asr #30
	biceq	r3, r2, #-16777216
	movwne	r3, #65535
	movtne	r3, 127
	eorne	r3, r3, r1
	mov	r1, r10
.L75:
	str	r3, [r10, #-4]
.L59:
	ldr	r2, [fp, #-48]
	add	r10, r10, #4
	ldr	r3, [fp, #-60]
	ldr	r3, [r3, r2, asl #2]
	ldr	r2, [r9, #68]
	ubfx	r7, r3, #8, #12
	ubfx	r0, r3, #1, #7
	mov	r6, r3, lsr #20
	mov	r3, r3, asr #20
	mul	r7, r4, r7
	str	r3, [fp, #-48]
	mul	r3, r4, r6
	add	r8, r8, r0, lsl #2
	ldr	r0, [fp, #-56]
	cmp	r0, r8
	add	r7, r2, r7, lsl #1
	add	r6, r2, r3, lsl #1
	bhi	.L68
	ldr	r3, [fp, #-68]
	mov	r5, r9
	rsb	r1, r3, r1
	mov	r4, r1, asr #2
.L53:
	ldr	r3, [fp, #-56]
	ldr	r1, [fp, #-48]
	rsb	r3, r3, r8
	ldr	r2, [r5, #24]
	ldr	r0, [r5, #52]
	mov	r3, r3, asr #2
	str	r3, [r5, #32]
	ldr	r3, [fp, #-64]
	mov	r2, r2, asl #2
	str	r1, [r5, #28]
	str	r6, [r5, #64]
	add	r1, r0, r3
	str	r7, [r5, #60]
	bl	memmove
	mov	r0, r4
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L77:
	add	r3, r3, #16384
	mov	r1, r10
	mov	r2, r3, asr #31
	mov	r0, r3, asr #15
	cmp	r2, r3, asr #30
	eorne	r3, r2, #32512
	sxtheq	r3, r0
	eorne	r3, r3, #255
	sxthne	r3, r3
	b	.L75
.L78:
	add	r3, r3, #4096
	mov	r1, r3, asr #31
	mov	r2, r3, asr #13
	cmp	r1, r3, asr #30
	beq	.L61
	movw	r3, #65535
	movt	r3, 1
	eor	r3, r3, r1
.L65:
	str	r3, [r10, #-4]
	mov	r1, r10
	b	.L59
.L79:
	add	r3, r3, #1024
	mov	r1, r3, asr #31
	mov	r2, r3, asr #11
	cmp	r1, r3, asr #30
	ubfxeq	r3, r2, #0, #20
	movwne	r3, #65535
	movtne	r3, 7
	eorne	r3, r3, r1
	b	.L65
.L54:
	ldr	r1, [r9, #40]
	cmp	r1, #16
	beq	.L69
	cmp	r1, #18
	movne	r3, #0
	bne	.L60
	mov	r2, #0
.L61:
	ubfx	r3, r2, #0, #18
	b	.L65
.L70:
	mov	r4, #0
	b	.L53
.L69:
	mov	r1, r10
	mov	r3, #0
	b	.L75
	.fnend
	.size	ResamplerMonoProcess24, .-ResamplerMonoProcess24
	.global	__aeabi_idiv
	.align	2
	.global	ResampleConfig
	.type	ResampleConfig, %function
ResampleConfig:
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
	cmp	r1, r2
	mov	r4, r1
	mov	r8, r2
	mov	r7, r0
	beq	.L93
	mov	r3, r2
	mov	r5, r1
.L84:
	cmp	r5, r3
	rsbgt	r5, r3, r5
	rsble	r3, r5, r3
	cmp	r3, r5
	bne	.L84
.L81:
	mov	r1, r5
	mov	r0, r8
	bl	__aeabi_idiv
	mov	r1, r5
	mov	r9, r0
	mov	r0, r4
	bl	__aeabi_idiv
	cmp	r9, #1280
	mov	r10, r0
	bgt	.L96
	ldr	r3, [r7, #16]
	add	r0, r0, r9
	mov	r1, r9
	sub	r0, r0, #1
	mov	r5, r3
	str	r3, [fp, #-48]
	bl	__aeabi_idiv
	mul	r0, r0, r5
	cmp	r0, #255
	bgt	.L96
	cmp	r4, #0
	add	r5, r4, #3
	add	r2, r8, #3
	add	r6, r4, r4, lsr #31
	movge	r5, r4
	cmp	r8, #0
	add	r0, r8, r8, lsr #31
	ldr	ip, .L105
	movge	r2, r8
	mov	r5, r5, asr #2
	mov	r2, r2, asr #2
	mov	r6, r6, asr #1
	mov	r0, r0, asr #1
	mov	lr, #0
	b	.L90
.L86:
	cmp	r3, r6
	beq	.L103
	cmp	r3, r5
	beq	.L104
.L89:
	add	lr, lr, #1
	add	ip, ip, #24
	cmp	lr, #40
	beq	.L96
.L90:
	ldr	r3, [ip]
	cmp	r3, r4
	bne	.L86
	ldr	r1, [ip, #4]
	cmp	r1, r8
	bne	.L86
.L87:
	cmp	lr, #40
	beq	.L96
	ldr	lr, [ip, #20]
	mov	r0, #0
	ldr	r5, [ip, #12]
	ldr	r3, [r7, #40]
	str	lr, [r7, #68]
	ldr	r1, [ip, #16]
	mov	r2, r5, asl #1
	str	r0, [r7, #36]
	cmp	r3, #16
	ldr	r0, [fp, #-48]
	str	r1, [r7, #72]
	mul	r2, r2, r0
	beq	.L102
	sub	r1, r3, #18
	bics	r1, r1, #2
	moveq	r1, #1
	movne	r1, #0
	cmp	r3, #24
	movne	r3, r1
	orreq	r3, r1, #1
	cmp	r3, #0
	bne	.L102
.L92:
	sub	r3, r9, #1
	mov	r1, #0
	mov	r0, r1
	str	r4, [r7, #8]
	mul	r3, r3, r5
	str	r8, [r7, #12]
	stmia	r7, {r9, r10}
	str	r5, [r7, #20]
	str	r2, [r7, #24]
	str	lr, [r7, #64]
	add	r3, lr, r3, lsl #1
	str	r1, [r7, #28]
	str	r3, [r7, #60]
	str	r1, [r7, #32]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L103:
	ldr	r1, [ip, #4]
	cmp	r1, r0
	beq	.L87
	cmp	r3, r5
	bne	.L89
.L104:
	ldr	r3, [ip, #4]
	cmp	r3, r2
	beq	.L87
	add	lr, lr, #1
	add	ip, ip, #24
	cmp	lr, #40
	bne	.L90
.L96:
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L102:
	ldr	r3, [r7, #52]
	add	r3, r3, r2, lsl #2
	str	r3, [r7, #56]
	b	.L92
.L93:
	mov	r5, r1
	b	.L81
.L106:
	.align	2
.L105:
	.word	.LANCHOR0
	.fnend
	.size	ResampleConfig, .-ResampleConfig
	.align	2
	.global	ResamplerCreate
	.type	ResamplerCreate, %function
ResamplerCreate:
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
	cmp	r0, #32000
	mov	r5, r0
	mov	r9, r1
	mov	r10, r2
	beq	.L109
	ble	.L189
	movw	r2, #22664
	movt	r2, 1
	cmp	r0, r2
	beq	.L109
	ble	.L190
	movw	r2, #45328
	movt	r2, 2
	cmp	r0, r2
	beq	.L109
	mov	r2, #60928
	movt	r2, 2
	cmp	r0, r2
	beq	.L109
	mov	r2, #30464
	movt	r2, 1
	cmp	r0, r2
	beq	.L109
.L108:
	sub	r0, fp, #48
	str	r10, [sp]
	mov	r2, r9
	mov	r1, r5
	bl	LSRC_Create
	ldr	r0, [fp, #-48]
	cmp	r0, #0
	beq	.L137
	mov	r1, #88
	mov	r0, #26
	bl	HI_ADSP_MALLOC
	subs	r4, r0, #0
	beq	.L191
	ldr	r3, [fp, #-48]
	mov	r0, r4
	mov	r2, #1
	str	r2, [r4, #80]
	str	r3, [r4, #84]
.L137:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L198:
	cmp	r0, #8000
	beq	.L109
	movw	r2, #11025
	cmp	r0, r2
	bne	.L108
.L109:
	cmp	r9, #32000
	beq	.L113
	ble	.L192
	movw	r2, #22664
	movt	r2, 1
	cmp	r9, r2
	beq	.L113
	ble	.L193
	movw	r2, #45328
	movt	r2, 2
	cmp	r9, r2
	beq	.L113
	mov	r2, #60928
	movt	r2, 2
	cmp	r9, r2
	beq	.L113
	mov	r2, #30464
	movt	r2, 1
	cmp	r9, r2
	bne	.L108
.L113:
	cmp	r5, r9
	bge	.L108
	sub	r2, r10, #1
	cmp	r2, #1
	bhi	.L108
	bic	r2, r3, #2
	cmp	r2, #16
	beq	.L141
	sub	r2, r3, #20
	bics	r2, r2, #4
	bne	.L108
.L141:
	mov	r4, r9
	mov	r2, r5
.L121:
	cmp	r2, r4
	rsbgt	r2, r4, r2
	rsble	r4, r2, r4
	cmp	r4, r2
	bne	.L121
	mov	r1, r4
	mov	r0, r9
	str	r3, [fp, #-56]
	bl	__aeabi_idiv
	mov	r1, r4
	mov	r8, r0
	mov	r0, r5
	bl	__aeabi_idiv
	cmp	r8, #1280
	ldr	r3, [fp, #-56]
	str	r0, [fp, #-60]
	bgt	.L108
	add	r0, r8, r0
	mov	r1, r8
	sub	r0, r0, #1
	bl	__aeabi_idiv
	ldr	r3, [fp, #-56]
	mul	r0, r0, r10
	cmp	r0, #255
	bgt	.L108
	cmp	r5, #0
	add	r6, r5, #3
	add	r1, r9, #3
	add	r7, r5, r5, lsr #31
	movge	r6, r5
	cmp	r9, #0
	add	r0, r9, r9, lsr #31
	ldr	r4, .L202
	movge	r1, r9
	mov	r6, r6, asr #2
	mov	r1, r1, asr #2
	mov	r7, r7, asr #1
	mov	r0, r0, asr #1
	mov	lr, #0
	b	.L126
.L122:
	cmp	r2, r7
	beq	.L194
.L124:
	cmp	r2, r6
	beq	.L195
.L125:
	add	lr, lr, #1
	add	r4, r4, #24
	cmp	lr, #40
	beq	.L108
.L126:
	ldr	r2, [r4]
	cmp	r5, r2
	bne	.L122
	ldr	ip, [r4, #4]
	cmp	r9, ip
	bne	.L122
	ldr	ip, [r4, #8]
	cmp	ip, #2
	bne	.L122
.L123:
	cmp	lr, #40
	beq	.L108
	ldr	r2, [r4, #12]
	mov	r1, #88
	mov	r0, #26
	str	r3, [fp, #-64]
	mov	r6, r2, asl #1
	str	r2, [fp, #-56]
	bl	HI_ADSP_MALLOC
	ldr	r3, [fp, #-64]
	mul	r6, r6, r10
	subs	r7, r0, #0
	beq	.L108
	ldr	r1, [r4, #20]
	cmp	r3, #16
	mov	ip, #0
	ldr	r2, [fp, #-56]
	str	r1, [r7, #68]
	ldr	r0, [r4, #16]
	str	r3, [r7, #40]
	str	ip, [r7, #36]
	str	r0, [r7, #72]
	beq	.L196
	sub	r0, r3, #18
	bics	r0, r0, #2
	moveq	r0, #1
	movne	r0, #0
	cmp	r3, #24
	orreq	r0, r0, #1
	cmp	r0, #0
	bne	.L197
.L132:
	sub	r3, r8, #1
	ldr	r0, [fp, #-60]
	mov	ip, #0
	str	r5, [r7, #8]
	mul	r3, r3, r2
	str	r0, [r7, #4]
	str	r9, [r7, #12]
	mov	r0, r7
	str	r8, [r7]
	str	r10, [r7, #16]
	str	r2, [r7, #20]
	add	r3, r1, r3, lsl #1
	str	r3, [r7, #60]
	ldr	r3, [fp, #4]
	str	r6, [r7, #24]
	str	r1, [r7, #64]
	str	r3, [r7, #76]
	str	ip, [r7, #28]
	str	ip, [r7, #32]
	str	ip, [r7, #80]
	str	ip, [r7, #84]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L189:
	movw	r2, #12000
	cmp	r0, r2
	beq	.L109
	ble	.L198
	movw	r2, #22050
	cmp	r0, r2
	beq	.L109
	movw	r2, #24000
	cmp	r0, r2
	beq	.L109
	cmp	r0, #16000
	bne	.L108
	b	.L109
.L192:
	movw	r2, #12000
	cmp	r9, r2
	beq	.L113
	ble	.L199
	movw	r2, #22050
	cmp	r9, r2
	beq	.L113
	movw	r2, #24000
	cmp	r9, r2
	beq	.L113
	cmp	r9, #16000
	bne	.L108
	b	.L113
.L194:
	ldr	ip, [r4, #4]
	cmp	ip, r0
	bne	.L124
	ldr	ip, [r4, #8]
	cmp	ip, #2
	beq	.L123
	cmp	r2, r6
	bne	.L125
.L195:
	ldr	r2, [r4, #4]
	cmp	r2, r1
	bne	.L125
	ldr	r2, [r4, #8]
	cmp	r2, #2
	bne	.L125
	b	.L123
.L190:
	movw	r2, #44100
	cmp	r0, r2
	beq	.L109
	movw	r2, #48000
	cmp	r0, r2
	beq	.L109
	b	.L108
.L199:
	cmp	r9, #8000
	beq	.L113
	movw	r2, #11025
	cmp	r9, r2
	beq	.L113
	b	.L108
.L193:
	movw	r2, #44100
	cmp	r9, r2
	beq	.L113
	movw	r2, #48000
	cmp	r9, r2
	beq	.L113
	b	.L108
.L197:
	str	r3, [fp, #-64]
	str	r2, [fp, #-56]
.L188:
	mov	r1, #16640
	mov	r0, #26
	bl	HI_ADSP_MALLOC
	ldr	r2, [fp, #-56]
	ldr	r3, [fp, #-64]
	cmp	r0, #0
	mov	ip, r0
	str	r0, [r7, #52]
	beq	.L184
	movs	r4, r6, asl #2
	bne	.L200
.L136:
	add	r3, ip, r4
	ldr	r1, [r7, #68]
	str	r3, [r7, #56]
	b	.L132
.L196:
	ldr	r1, [fp, #4]
	cmp	r1, ip
	bne	.L188
	add	r1, r6, #4096
	mov	r0, #26
	str	r3, [fp, #-64]
	mov	r1, r1, asl #1
	str	r2, [fp, #-56]
	bl	HI_ADSP_MALLOC
	ldr	r2, [fp, #-56]
	ldr	r3, [fp, #-64]
	cmp	r0, #0
	mov	ip, r0
	str	r0, [r7, #44]
	beq	.L184
	movs	r4, r6, asl #1
	bne	.L201
.L134:
	add	r3, ip, r4
	ldr	r1, [r7, #68]
	str	r3, [r7, #48]
	b	.L132
.L200:
	mov	r1, r4
	str	r2, [fp, #-56]
	bl	__memzero
	ldr	ip, [r7, #52]
	ldr	r2, [fp, #-56]
	b	.L136
.L201:
	mov	r1, r4
	str	r2, [fp, #-56]
	bl	__memzero
	ldr	ip, [r7, #44]
	ldr	r2, [fp, #-56]
	b	.L134
.L191:
	ldr	r0, [fp, #-48]
	bl	LSRC_Destroy
	mov	r0, r4
	b	.L137
.L184:
	mov	r1, r7
	mov	r0, #26
	str	r3, [fp, #-56]
	bl	HI_ADSP_FREE
	ldr	r3, [fp, #-56]
	b	.L108
.L203:
	.align	2
.L202:
	.word	.LANCHOR0
	.fnend
	.size	ResamplerCreate, .-ResamplerCreate
	.align	2
	.global	ResamplerFree
	.type	ResamplerFree, %function
ResamplerFree:
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
	subs	r4, r0, #0
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r3, [r4, #80]
	cmp	r3, #0
	beq	.L229
	ldr	r0, [r4, #84]
	bl	LSRC_Destroy
.L226:
	mov	r1, r4
	mov	r0, #26
	bl	HI_ADSP_FREE
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L229:
	ldr	r3, [r4, #40]
	cmp	r3, #16
	beq	.L230
	sub	r2, r3, #18
	bics	r2, r2, #2
	moveq	r2, #1
	movne	r2, #0
	cmp	r3, #24
	movne	r3, r2
	orreq	r3, r2, #1
	cmp	r3, #0
	beq	.L226
.L228:
	ldr	r1, [r4, #52]
	cmp	r1, #0
	beq	.L226
.L225:
	mov	r0, #26
	bl	HI_ADSP_FREE
	b	.L226
.L230:
	ldr	r3, [r4, #76]
	cmp	r3, #0
	bne	.L228
	ldr	r1, [r4, #44]
	cmp	r1, #0
	bne	.L225
	b	.L226
	.fnend
	.size	ResamplerFree, .-ResamplerFree
	.align	2
	.global	ResampleFlush
	.type	ResampleFlush, %function
ResampleFlush:
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
	subs	r4, r0, #0
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r3, [r4, #80]
	cmp	r3, #0
	ldmnefd	sp, {r4, r5, fp, sp, pc}
	ldr	r1, [r4]
	ldr	r0, [r4, #20]
	sub	r1, r1, #1
	ldr	ip, [r4, #40]
	ldr	r2, [r4, #68]
	mul	r1, r0, r1
	cmp	ip, #16
	str	r2, [r4, #64]
	str	r3, [r4, #28]
	str	r3, [r4, #32]
	str	r3, [r4, #36]
	add	r2, r2, r1, lsl #1
	str	r2, [r4, #60]
	beq	.L246
	sub	r3, ip, #18
	bics	r3, r3, #2
	moveq	r3, #1
	movne	r3, #0
	cmp	ip, #24
	movne	ip, r3
	orreq	ip, r3, #1
	cmp	ip, #0
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r3, [r4, #24]
	ldr	r0, [r4, #52]
	add	r1, r3, #4096
	movs	r1, r1, asl #2
	bne	.L247
.L239:
	add	r0, r0, r3, lsl #2
	str	r0, [r4, #56]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L246:
	ldr	r3, [r4, #76]
	cmp	r3, #0
	ldr	r3, [r4, #24]
	beq	.L236
	add	r1, r3, #4096
	ldr	r0, [r4, #52]
	movs	r1, r1, asl #2
	beq	.L237
	bl	__memzero
	ldr	r0, [r4, #52]
	ldr	r3, [r4, #24]
.L237:
	add	r3, r0, r3, lsl #2
	str	r3, [r4, #56]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L236:
	add	r1, r3, #4096
	ldr	r0, [r4, #44]
	movs	r1, r1, asl #1
	beq	.L238
	bl	__memzero
	ldr	r0, [r4, #44]
	ldr	r3, [r4, #24]
.L238:
	add	r3, r0, r3, lsl #1
	str	r3, [r4, #48]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L247:
	bl	__memzero
	ldr	r0, [r4, #52]
	ldr	r3, [r4, #24]
	b	.L239
	.fnend
	.size	ResampleFlush, .-ResampleFlush
	.align	2
	.global	NEW_ResamplerCheck
	.type	NEW_ResamplerCheck, %function
NEW_ResamplerCheck:
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
	mov	r4, r3
	mov	lr, r1
	mov	r3, r2
	beq	.L251
	ldr	ip, [r0, #80]
	cmp	ip, #0
	bne	.L250
	ldr	r1, [r0, #8]
	cmp	lr, r1
	beq	.L255
.L254:
	mov	r0, #1
.L249:
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L255:
	ldr	r2, [r0, #12]
	cmp	r3, r2
	bne	.L254
	ldr	r3, [r0, #16]
	cmp	r4, r3
	bne	.L254
	ldr	r0, [r0, #40]
	ldr	r3, [fp, #4]
	subs	r0, r3, r0
	movne	r0, #1
	b	.L249
.L250:
	ldr	r0, [r0, #84]
	ldr	r3, [fp, #4]
	str	r4, [sp]
	bl	LSRC_CheckUpdate
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L251:
	mov	r0, #-2147483647
	b	.L249
	.fnend
	.size	NEW_ResamplerCheck, .-NEW_ResamplerCheck
	.align	2
	.global	ResamplerGetMaxOutputNum
	.type	ResamplerGetMaxOutputNum, %function
ResamplerGetMaxOutputNum:
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
	mov	r3, r1
	beq	.L259
	ldr	r2, [r0, #80]
	cmp	r2, #0
	bne	.L258
	cmp	r1, #2048
	bgt	.L261
	tst	r1, #1
	bne	.L261
	ldr	r2, [r0, #16]
	ldr	ip, [r0, #12]
	sub	r2, r2, #1
	ldr	r1, [r0, #8]
	add	r0, r3, r2
	mul	r0, ip, r0
	bl	__aeabi_idiv
	add	r0, r0, #1
	ldmfd	sp, {fp, sp, pc}
.L261:
	mov	r0, #-2147483645
	ldmfd	sp, {fp, sp, pc}
.L258:
	ldr	r0, [r0, #84]
	bl	LSRC_GetMaxOutputNum
	ldmfd	sp, {fp, sp, pc}
.L259:
	mov	r0, #-2147483647
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	ResamplerGetMaxOutputNum, .-ResamplerGetMaxOutputNum
	.global	__aeabi_idivmod
	.align	2
	.global	ResamplerGetMinInputNum
	.type	ResamplerGetMinInputNum, %function
ResamplerGetMinInputNum:
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
	subs	r5, r0, #0
	mov	r4, r1
	beq	.L267
	ldr	r3, [r5, #80]
	cmp	r3, #0
	bne	.L264
	ldr	r6, [r5, #8]
	ldr	r7, [r5, #12]
	mul	r6, r6, r1
	mov	r1, r7
	mov	r0, r6
	bl	__aeabi_idiv
	mov	r1, r7
	mov	r4, r0
	mov	r0, r6
	bl	__aeabi_idivmod
	ldr	r3, [r5, #16]
	cmp	r1, #0
	addne	r4, r4, #1
	mul	r3, r3, r4
	tst	r3, #1
	addne	r4, r4, #1
	cmp	r4, #2048
	movle	r0, r4
	movgt	r0, #-2147483645
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L264:
	ldr	r0, [r5, #84]
	bl	LSRC_GetMinInputNum
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L267:
	mov	r0, r1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	ResamplerGetMinInputNum, .-ResamplerGetMinInputNum
	.align	2
	.global	ResamplerProcessFrame
	.type	ResamplerProcessFrame, %function
ResamplerProcessFrame:
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
	subs	r4, r0, #0
	mov	r6, r1
	str	r2, [fp, #-48]
	mov	r5, r3
	beq	.L284
	ldr	r0, [r4, #80]
	cmp	r0, #0
	beq	.L320
	ldr	r0, [r4, #84]
	bl	LSRC_ProcessFrame
	mov	r9, r0
.L317:
	mov	r0, r9
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L320:
	cmp	r1, #0
	beq	.L304
	cmp	r3, #2048
	bgt	.L280
	tst	r3, #1
	bne	.L280
	ldr	r3, [fp, #-48]
	cmp	r3, #0
	beq	.L304
	ldr	r3, [r4, #8]
	ldr	r2, [fp, #4]
	cmp	r2, r3
	beq	.L321
.L281:
	ldmib	fp, {r1, r2}
	mov	r0, r4
	bl	ResampleConfig
.L282:
	mov	r1, r5
	mov	r0, r4
	bl	ResamplerGetMaxOutputNum
	cmp	r0, #0
	blt	.L322
	ldr	ip, [r4, #16]
	cmp	ip, #2
	beq	.L323
	cmp	ip, #1
	bne	.L306
	ldr	r3, [r4, #40]
	cmp	r3, #16
	beq	.L324
	sub	r2, r3, #18
	bics	r2, r2, #2
	moveq	r2, #1
	movne	r2, #0
	cmp	r3, #24
	movne	r3, r2
	orreq	r3, r2, #1
	cmp	r3, #0
	beq	.L319
.L296:
	ldr	r3, [fp, #-48]
	mov	r2, r5
	mov	r1, r6
	mov	r0, r4
	bl	ResamplerMonoProcess24
	mov	r9, r0
	mov	r0, r9
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L321:
	ldr	r3, [r4, #12]
	ldr	r2, [fp, #8]
	cmp	r2, r3
	bne	.L281
	b	.L282
.L323:
	ldr	r3, [r4, #40]
	cmp	r3, #16
	beq	.L325
	sub	r2, r3, #18
	bics	r2, r2, #2
	moveq	r2, #1
	movne	r2, #0
	cmp	r3, #24
	movne	r3, r2
	orreq	r3, r2, #1
	cmp	r3, #0
	beq	.L319
.L287:
	ldr	r3, [fp, #12]
	mov	r2, r5
	mov	r1, r6
	mov	r0, r4
	str	r3, [sp]
	ldr	r3, [fp, #-48]
	bl	ResamplerStereoProcess24
	mov	r9, r0
	b	.L317
.L322:
	cmp	r0, #-2147483647
	beq	.L284
	cmp	r0, #-2147483645
	movne	r9, #-2147483640
	bne	.L317
.L280:
	mov	r9, #-2147483645
	b	.L317
.L319:
	mov	r9, #-2147483642
	b	.L317
.L324:
	ldr	r9, [r4, #76]
	cmp	r9, #0
	bne	.L296
	ldr	r3, [r4, #28]
	mov	r2, r5
	ldr	lr, [r4, #72]
	mov	r1, r6
	ldr	r5, [r4, #20]
	ldr	r0, [r4, #48]
	str	r3, [fp, #-52]
	str	ip, [sp]
	ldr	r3, [fp, #12]
	str	lr, [fp, #-64]
	bl	cvtShortShort
	mov	r2, r5, asl #1
	ldr	r3, [r4, #48]
	ldr	r8, [r4, #32]
	rsb	r2, r2, #2
	add	r3, r3, r2
	ldr	r6, [r4, #64]
	ldr	r7, [r4, #60]
	add	r8, r3, r8, lsl #1
	mov	r2, r0, asl #1
	str	r2, [fp, #-68]
	add	r3, r3, r2
	str	r3, [fp, #-56]
	cmp	r3, r8
	bls	.L297
	ldr	r3, [fp, #-48]
	str	r4, [fp, #-60]
	add	r3, r3, #2
	mov	r9, r3
.L302:
	cmp	r5, #0
	ble	.L298
	mov	ip, #0
	sub	r0, r8, #6
	add	r1, r8, #4
	mov	r3, ip
	mov	r2, ip
.L299:
	ldr	lr, [r6], #4
	ldr	r4, [r7], #4
	ldrsh	r10, [r0, #4]
#APP
	smlabb r2, r10, lr, r2
	ldrsh	r10, [r1, #-4]
#APP
	smlabb r3, r10, r4, r3
	ldrsh	r10, [r0, #2]
#APP
	smlabt r2, r10, lr, r2
	ldrsh	lr, [r1, #-2]
#APP
	smlabt r3, lr, r4, r3
	add	ip, ip, #2
	sub	r0, r0, #4
	cmp	r5, ip
	add	r1, r1, #4
	bgt	.L299
	add	r3, r3, r2
	mov	r1, r9
	add	r3, r3, #16384
	mov	r2, r3, asr #31
	mov	r0, r3, asr #15
	cmp	r2, r3, asr #30
	eorne	r3, r2, #32512
	uxtheq	r3, r0
	eorne	r3, r3, #255
	uxthne	r3, r3
.L301:
	strh	r3, [r9, #-2]
	add	r9, r9, #2
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-64]
	ldr	r3, [r3, r2, asl #2]
	ldr	r2, [fp, #-60]
	ubfx	r7, r3, #8, #12
	and	r0, r3, #254
	add	r8, r8, r0
	ldr	r0, [fp, #-56]
	ldr	r6, [r2, #68]
	mov	r2, r3, lsr #20
	mul	r7, r7, r5
	cmp	r0, r8
	mul	r2, r2, r5
	mov	r3, r3, asr #20
	str	r3, [fp, #-52]
	add	r7, r6, r7, lsl #1
	add	r6, r6, r2, lsl #1
	bhi	.L302
	ldr	r3, [fp, #-48]
	ldr	r4, [fp, #-60]
	rsb	r1, r3, r1
	mov	r9, r1, asr #1
.L297:
	ldr	r3, [fp, #-56]
	ldr	r1, [fp, #-52]
	rsb	r3, r3, r8
	ldr	r0, [r4, #44]
	ldr	r2, [r4, #24]
	mov	r3, r3, asr #1
	str	r3, [r4, #32]
	ldr	r3, [fp, #-68]
	str	r1, [r4, #28]
.L318:
	add	r1, r0, r3
	str	r6, [r4, #64]
	str	r7, [r4, #60]
	mov	r2, r2, asl #1
	bl	memmove
	b	.L317
.L298:
	mov	r1, r9
	mov	r3, #0
	b	.L301
.L325:
	ldr	r9, [r4, #76]
	cmp	r9, #0
	bne	.L287
	ldr	r3, [r4, #28]
	mov	r2, r5
	ldr	lr, [r4, #72]
	mov	r1, r6
	ldr	r5, [r4, #20]
	ldr	r0, [r4, #48]
	str	r3, [fp, #-56]
	str	ip, [sp]
	ldr	r3, [fp, #12]
	str	lr, [fp, #-68]
	bl	cvtShortShort
	sub	r1, r5, #1
	ldr	r3, [r4, #48]
	ldr	r2, [r4, #32]
	sub	r3, r3, r1, asl #2
	ldr	r6, [r4, #64]
	ldr	r7, [r4, #60]
	add	r2, r3, r2, lsl #1
	str	r2, [fp, #-52]
	mov	r1, r0, asl #1
	str	r1, [fp, #-72]
	add	r3, r3, r1
	str	r3, [fp, #-60]
	cmp	r3, r2
	bls	.L288
	ldr	r3, [fp, #-48]
	str	r9, [fp, #-76]
	add	r3, r3, #4
	str	r4, [fp, #-64]
	mov	r10, r3
.L294:
	cmp	r5, #0
	ble	.L289
	ldr	r3, [fp, #-52]
	mov	r9, #0
	mov	r2, r9
	mov	r1, r9
	sub	r8, r3, #12
	add	r4, r3, #8
.L290:
	ldr	ip, [r6], #4
	ldr	r0, [r7], #4
	ldr	r3, [r8, #8]
	ldr	lr, [r4, #-8]
#APP
	smlabb r1, r3, ip, r1
	smlatb r3, r3, ip, r2
	smlabb r1, lr, r0, r1
	smlatb r3, lr, r0, r3
	ldr	r2, [r8, #4]
	ldr	lr, [r4, #-4]
#APP
	smlabt r1, r2, ip, r1
	smlatt r3, r2, ip, r3
	smlabt r1, lr, r0, r1
	smlatt r2, lr, r0, r3
	add	r9, r9, #2
	sub	r8, r8, #8
	cmp	r5, r9
	add	r4, r4, #8
	bgt	.L290
	add	r1, r1, #16384
	mov	r3, r1, asr #31
	mov	r0, r1, asr #15
	cmp	r3, r1, asr #30
	addeq	r2, r2, #16384
	eorne	r3, r3, #32512
	addne	r2, r2, #16384
	eorne	r3, r3, #255
	moveq	r1, r2, asr #31
	uxtheq	r3, r0
	movne	r1, r2, asr #31
	moveq	r0, r2, asr #30
	movne	r0, r2, asr #30
	uxthne	r3, r3
	cmp	r1, r0
	mov	r2, r2, asr #15
	eorne	r2, r1, #32512
	strh	r3, [r10, #-4]
	eorne	r2, r2, #255
	movne	r1, r10
	moveq	r1, r10
.L293:
	strh	r2, [r10, #-2]
	add	r10, r10, #4
	ldr	r2, [fp, #-56]
	ldr	r3, [fp, #-68]
	ldr	ip, [fp, #-52]
	ldr	r3, [r3, r2, asl #2]
	ldr	r2, [fp, #-64]
	ubfx	r7, r3, #8, #12
	uxtb	r0, r3
	ldr	r6, [r2, #68]
	mov	r2, r3, lsr #20
	mul	r7, r7, r5
	add	r0, ip, r0, lsl #1
	mul	r2, r2, r5
	ldr	ip, [fp, #-60]
	mov	r3, r3, asr #20
	str	r0, [fp, #-52]
	cmp	ip, r0
	str	r3, [fp, #-56]
	add	r7, r6, r7, lsl #1
	add	r6, r6, r2, lsl #1
	bhi	.L294
	ldr	r3, [fp, #-48]
	ldr	r4, [fp, #-64]
	rsb	r1, r3, r1
	mov	r9, r1, asr #1
	add	r9, r9, r9, lsr #31
	mov	r9, r9, asr #1
.L288:
	ldr	r2, [fp, #-60]
	ldr	r3, [fp, #-52]
	ldr	r1, [fp, #-56]
	rsb	r3, r2, r3
	ldr	r0, [r4, #44]
	ldr	r2, [r4, #24]
	mov	r3, r3, asr #1
	str	r1, [r4, #28]
	str	r3, [r4, #32]
	ldr	r3, [fp, #-72]
	b	.L318
.L306:
	mov	r9, #-2147483643
	b	.L317
.L289:
	ldrh	r3, [fp, #-76]
	mov	r1, r10
	mov	r2, #0
	strh	r3, [r10, #-4]
	b	.L293
.L284:
	mov	r9, #-2147483647
	b	.L317
.L304:
	mov	r9, #-2147483646
	b	.L317
	.fnend
	.size	ResamplerProcessFrame, .-ResamplerProcessFrame
	.data
	.align	2
.LANCHOR0 = . + 0
	.type	resampler_info, %object
	.size	resampler_info, 960
resampler_info:
	.word	32000
	.word	48000
	.word	1
	.word	8
	.word	SRC_res_32_48_mid_nextphasetab
	.word	SRC_res_32_48_mid_filttab
	.word	44100
	.word	48000
	.word	1
	.word	8
	.word	SRC_res_44_48_mid_nextphasetab
	.word	SRC_res_44_48_mid_filttab
	.word	48000
	.word	48000
	.word	1
	.word	8
	.word	res_48_48_nextphasetab
	.word	res_48_48_good_filttab
	.word	8000
	.word	11025
	.word	2
	.word	8
	.word	SRC_res_8_11_good_nextphasetab
	.word	SRC_res_8_11_mid_filttab
	.word	16000
	.word	22050
	.word	2
	.word	8
	.word	SRC_res_8_11_good_nextphasetab
	.word	SRC_res_8_11_mid_filttab
	.word	8000
	.word	22050
	.word	2
	.word	8
	.word	SRC_res_8_22_good_nextphasetab
	.word	SRC_res_8_22_mid_filttab
	.word	16000
	.word	44100
	.word	2
	.word	8
	.word	SRC_res_8_22_good_nextphasetab
	.word	SRC_res_8_22_mid_filttab
	.word	8000
	.word	44100
	.word	2
	.word	8
	.word	SRC_res_8_44_good_nextphasetab
	.word	SRC_res_8_44_mid_filttab
	.word	11025
	.word	12000
	.word	2
	.word	8
	.word	SRC_res_11_12_good_nextphasetab
	.word	SRC_res_11_12_mid_filttab
	.word	22050
	.word	24000
	.word	2
	.word	8
	.word	SRC_res_11_12_good_nextphasetab
	.word	SRC_res_11_12_mid_filttab
	.word	11025
	.word	16000
	.word	2
	.word	8
	.word	SRC_res_11_16_good_nextphasetab
	.word	SRC_res_11_16_mid_filttab
	.word	22050
	.word	32000
	.word	2
	.word	8
	.word	SRC_res_11_16_good_nextphasetab
	.word	SRC_res_11_16_mid_filttab
	.word	11025
	.word	24000
	.word	2
	.word	8
	.word	SRC_res_11_24_good_nextphasetab
	.word	SRC_res_11_24_mid_filttab
	.word	22050
	.word	48000
	.word	2
	.word	8
	.word	SRC_res_11_24_good_nextphasetab
	.word	SRC_res_11_24_mid_filttab
	.word	11025
	.word	32000
	.word	2
	.word	8
	.word	SRC_res_11_32_good_nextphasetab
	.word	SRC_res_11_32_mid_filttab
	.word	11025
	.word	48000
	.word	2
	.word	8
	.word	SRC_res_11_48_good_nextphasetab
	.word	SRC_res_11_48_mid_filttab
	.word	12000
	.word	22050
	.word	2
	.word	8
	.word	SRC_res_12_22_good_nextphasetab
	.word	SRC_res_12_22_mid_filttab
	.word	24000
	.word	44100
	.word	2
	.word	8
	.word	SRC_res_12_22_good_nextphasetab
	.word	SRC_res_12_22_mid_filttab
	.word	12000
	.word	44100
	.word	2
	.word	8
	.word	SRC_res_12_44_good_nextphasetab
	.word	SRC_res_12_44_mid_filttab
	.word	8000
	.word	12000
	.word	2
	.word	16
	.word	SRC_res_8_12_good_nextphasetab
	.word	SRC_res_8_12_good_filttab
	.word	8000
	.word	16000
	.word	2
	.word	16
	.word	SRC_res_8_16_good_nextphasetab
	.word	SRC_res_8_16_good_filttab
	.word	8000
	.word	24000
	.word	2
	.word	16
	.word	SRC_res_8_24_good_nextphasetab
	.word	SRC_res_8_24_good_filttab
	.word	8000
	.word	32000
	.word	2
	.word	16
	.word	SRC_res_8_32_good_nextphasetab
	.word	SRC_res_8_32_good_filttab
	.word	8000
	.word	48000
	.word	2
	.word	16
	.word	SRC_res_8_48_good_nextphasetab
	.word	SRC_res_8_48_good_filttab
	.word	11025
	.word	22050
	.word	2
	.word	16
	.word	SRC_res_8_16_good_nextphasetab
	.word	SRC_res_8_16_good_filttab
	.word	11025
	.word	44100
	.word	2
	.word	16
	.word	SRC_res_8_32_good_nextphasetab
	.word	SRC_res_8_32_good_filttab
	.word	12000
	.word	16000
	.word	2
	.word	16
	.word	SRC_res_12_16_good_nextphasetab
	.word	SRC_res_12_16_good_filttab
	.word	12000
	.word	24000
	.word	2
	.word	16
	.word	SRC_res_8_16_good_nextphasetab
	.word	SRC_res_8_16_good_filttab
	.word	12000
	.word	32000
	.word	2
	.word	16
	.word	SRC_res_12_32_good_nextphasetab
	.word	SRC_res_12_32_good_filttab
	.word	12000
	.word	48000
	.word	2
	.word	16
	.word	SRC_res_8_32_good_nextphasetab
	.word	SRC_res_8_32_good_filttab
	.word	16000
	.word	24000
	.word	2
	.word	16
	.word	SRC_res_8_12_good_nextphasetab
	.word	SRC_res_8_12_good_filttab
	.word	16000
	.word	32000
	.word	2
	.word	16
	.word	SRC_res_8_16_good_nextphasetab
	.word	SRC_res_8_16_good_filttab
	.word	16000
	.word	48000
	.word	2
	.word	16
	.word	SRC_res_8_24_good_nextphasetab
	.word	SRC_res_8_24_good_filttab
	.word	22050
	.word	44100
	.word	2
	.word	16
	.word	SRC_res_8_16_good_nextphasetab
	.word	SRC_res_8_16_good_filttab
	.word	24000
	.word	32000
	.word	2
	.word	16
	.word	SRC_res_12_16_good_nextphasetab
	.word	SRC_res_12_16_good_filttab
	.word	24000
	.word	48000
	.word	2
	.word	16
	.word	SRC_res_8_16_good_nextphasetab
	.word	SRC_res_8_16_good_filttab
	.word	32000
	.word	44100
	.word	2
	.word	16
	.word	SRC_res_8_11_good_nextphasetab
	.word	SRC_res_8_11_good_filttab
	.word	32000
	.word	48000
	.word	2
	.word	16
	.word	SRC_res_8_12_good_nextphasetab
	.word	SRC_res_8_12_good_filttab
	.word	44100
	.word	48000
	.word	2
	.word	36
	.word	SRC_res_11_12_good_nextphasetab
	.word	SRC_res_11_12_good_filttab
	.word	48000
	.word	48000
	.word	2
	.word	8
	.word	res_48_48_nextphasetab
	.word	res_48_48_good_filttab
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
