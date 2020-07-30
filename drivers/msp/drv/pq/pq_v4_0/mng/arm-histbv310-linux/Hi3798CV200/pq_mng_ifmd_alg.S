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
	.file	"pq_mng_ifmd_alg.c"

	.text
	.align	2
	.type	Check32PdPattern, %function
Check32PdPattern:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #108
	sub	sp, sp, #108
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r7, [fp, #4]
	mov	r6, r3
	mov	r4, r0
	mov	r8, r1
	mov	r5, r2
	sub	r0, fp, #136
	mov	r2, #100
	ldr	r1, .L11
	bl	memcpy
	cmp	r7, r6, asl #1
	movlt	r0, #0
	blt	.L2
	mov	r3, r4, asl #4
	mov	r1, r8
	add	lr, r3, r4, lsl #2
	sub	r3, fp, #136
	sub	ip, lr, #4
	add	lr, lr, #16
	mov	r0, #0
	add	ip, r3, ip
	add	lr, r3, lr
	b	.L5
.L10:
	ldr	r3, [r1]
	add	r1, r1, #4
	cmp	r3, r6
	addeq	r0, r0, #1
	cmp	ip, lr
	beq	.L9
.L5:
	ldr	r4, [ip, #4]!
	cmp	r4, #0
	beq	.L10
	ldr	r4, [r1]
	add	r1, r1, #4
	mov	r4, r4, asl #5
	cmp	r4, r5
	addgt	r0, r0, #1
	cmp	ip, lr
	bne	.L5
.L9:
	cmp	r0, #4
	movle	r0, #0
	movgt	r0, #1
.L2:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L12:
	.align	2
.L11:
	.word	.LANCHOR0
	.fnend
	.size	Check32PdPattern, .-Check32PdPattern
	.global	__aeabi_idiv
	.align	2
	.type	Detect22Pld, %function
Detect22Pld:
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
	ldr	lr, [fp, #4]
	ldmib	r3, {r5, ip}
	cmp	lr, #1
	stmia	r3, {r5, ip}
	beq	.L160
	ldr	r5, [r1, #128]
	clz	r4, r0
	ldr	ip, [r1, #124]
	mov	r4, r4, lsr #5
	ldr	r0, [r1, #120]
	str	r5, [fp, #-56]
	cmp	r4, #1
	ldr	r5, [r1, #132]
	ldr	r10, [r1]
	str	r5, [fp, #-60]
	ldr	r5, [r2, #92]
	str	r5, [fp, #-48]
	beq	.L161
	cmp	lr, #0
	bne	.L117
	ldr	lr, [r1, #24]
	ldr	r5, [r2, #48]
	ldr	r6, [r2, #52]
	add	lr, r5, lr
	str	lr, [r2, #68]
	ldr	r5, [r1, #28]
	ldr	r7, [r2, #56]
	add	r6, r6, r5
	str	r6, [r2, #72]
	ldr	r5, [r1, #32]
	add	r5, r7, r5
	str	r5, [r2, #76]
	ldr	r7, [r1, #24]
	ldr	r8, [r1, #40]
	str	r7, [r2, #48]
	ldr	r7, [r1, #28]
	str	r8, [fp, #-68]
	str	r7, [r2, #52]
	ldr	r7, [r1, #32]
	str	r7, [r2, #56]
.L51:
	ldmib	r1, {r8, r9}
	cmp	r5, r6
	ldr	r7, [r1, #12]
	add	ip, r0, ip, lsl #1
	ldr	r1, [r1, #16]
	movge	r0, r5
	movlt	r0, r6
	str	r0, [fp, #-52]
	cmp	r9, r8
	mov	r0, r1
	str	r1, [fp, #-80]
	ldr	r1, [fp, #-56]
	add	ip, ip, r1, lsl #2
	movge	r1, r9
	movlt	r1, r8
	str	r1, [fp, #-72]
	ldr	r1, [fp, #-60]
	cmp	r0, r7
	add	r1, ip, r1, lsl #3
	str	r1, [fp, #-64]
	mov	r1, r0
	ldr	r0, [fp, #-52]
	movlt	r1, r7
	str	r1, [fp, #-76]
	cmp	lr, #4
	cmple	r0, #4
	bgt	.L52
	ldr	r0, [fp, #-76]
	movw	ip, #499
	ldr	r1, [fp, #-72]
	cmp	r1, ip
	cmple	r0, ip
	ldr	r1, [fp, #-56]
	movle	ip, #1
	movgt	ip, #0
	cmp	r1, #1
	movgt	ip, #0
	andle	ip, ip, #1
	ldr	r1, [fp, #-60]
	cmp	r1, #1
	movgt	ip, #0
	andle	ip, ip, #1
	cmp	ip, #0
	movne	r0, #1
	strne	r0, [r2, #92]
	bne	.L49
.L52:
	cmp	lr, #800
	ble	.L53
	add	r0, r2, r4
	ldrb	r1, [r0, #88]
	sub	r1, r1, #15
	strb	r1, [r0, #88]
.L54:
	ldr	r1, [fp, #-68]
	mov	r1, r1, asl #5
	cmp	r1, #127
	addgt	r4, r2, r4
	ldrgtb	r1, [r4, #88]
	subgt	r1, r1, #5
	strgtb	r1, [r4, #88]
.L111:
	ldr	ip, [r2, #36]
	mov	r9, #1
	add	ip, ip, r9
.L113:
	ldrsb	r0, [r2, #88]
	ldrsb	r1, [r2, #89]
	cmp	r0, #32
	str	ip, [r2, #36]
	movge	r0, #32
	cmp	r1, #32
	bic	r0, r0, r0, asr #31
	movge	r1, #32
	bic	r1, r1, r1, asr #31
	uxtb	r0, r0
	strb	r0, [r2, #88]
	uxtb	r1, r1
	sxtb	r0, r0
	strb	r1, [r2, #89]
	sxtb	r1, r1
	cmp	r0, #24
	cmpgt	r1, #24
	movgt	r1, #1
	movgt	ip, #1
	movle	ip, #0
	strgt	r1, [r2, #92]
	bgt	.L100
	cmp	r1, #19
	cmpgt	r0, #19
	strle	ip, [r2, #92]
.L100:
	ldr	ip, [r2, #12]
	movw	r4, #26215
	ldr	r7, [r2, #8]
	movt	r4, 26214
	ldr	r6, [r2, #4]
	movw	r0, #62536
	ldr	lr, [r2]
	add	r1, ip, r7
	add	r1, r6, r1
	ldr	r8, [r2, #20]
	add	r1, lr, r1
	movt	r0, 65535
	add	r1, r10, r1
	stmia	r2, {r10, lr}
	ldr	lr, [r2, #28]
	smull	r4, r5, r1, r4
	mov	r1, r1, asr #31
	str	ip, [r2, #16]
	movw	ip, #3000
	str	r7, [r2, #12]
	str	r6, [r2, #8]
	rsb	r1, r1, r5, asr #1
	str	r1, [r2, #24]
	add	r10, r1, lr
	str	r1, [r2, #20]
	rsb	r8, r8, r10
	cmp	r8, r0
	movlt	r8, r0
	cmp	r8, ip
	movge	r8, ip
	cmp	r8, #1000
	str	r8, [r2, #28]
	blt	.L101
	ldr	r1, [fp, #-48]
	cmp	r1, #1
	movne	r9, #0
	andeq	r9, r9, #1
	cmp	r9, #0
	bne	.L162
.L101:
	ldr	r1, [fp, #-48]
	ldr	r0, [r2, #92]
	cmp	r0, #1
	cmpeq	r1, #0
	moveq	r1, #0
	streq	r1, [r2, #28]
.L102:
	ldr	r1, [fp, #-64]
	str	r1, [r2, #32]
	str	r0, [r3, #8]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L161:
	cmp	lr, #0
	beq	.L163
.L117:
	ldr	r0, [fp, #-48]
.L49:
	str	r0, [r3, #8]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L53:
	ldr	r1, [fp, #-52]
	cmp	lr, #120
	cmple	r1, #120
	ble	.L55
	cmp	r5, r6
	movlt	r1, r5
	movge	r1, r6
	cmp	lr, #10
	mov	ip, r1, asl #1
	movlt	lr, #10
	mov	r7, lr, asl #2
	cmp	r7, ip
	bge	.L56
	cmp	r1, #120
	ldr	r0, [fp, #-52]
	ble	.L57
	cmp	r0, #800
	ble	.L58
	add	r5, lr, lr, lsl #1
	cmp	ip, r5
	ble	.L58
	cmp	r0, ip
	bgt	.L143
	ldr	r0, [fp, #-52]
	mov	lr, r1, asl #2
	add	r6, lr, r1
	cmp	r6, r0, asl #2
	ble	.L60
	cmp	r1, r5
	ble	.L54
.L144:
	add	r0, r2, r4
	ldrb	r1, [r0, #88]
	add	r1, r1, #1
	strb	r1, [r0, #88]
.L61:
	ldr	r1, [fp, #-68]
	mov	r1, r1, asl #5
	cmp	r1, #127
	movle	r9, #0
	movle	ip, r9
	ble	.L113
	add	r4, r2, r4
	mov	r9, #0
	mov	ip, r9
	ldrb	r1, [r4, #88]
	sub	r1, r1, #5
	strb	r1, [r4, #88]
	b	.L113
.L55:
	ldr	r1, [fp, #-52]
	cmp	r1, #120
	cmple	lr, #120
	bgt	.L54
	movw	r0, #5499
	cmp	r8, r0
	cmple	r7, r0
	bgt	.L143
	cmp	lr, #39
	ble	.L72
	cmp	lr, r6, asl #1
	bge	.L143
.L72:
	ldr	r1, [fp, #-72]
	add	r0, r8, r8, lsl #2
	mov	r5, r9, asl #2
	movw	ip, #2500
	cmp	r0, r5
	cmpgt	r1, ip
	movgt	lr, #1
	movle	lr, #0
	bgt	.L143
	ldr	r1, [fp, #-80]
	add	r0, r7, r7, lsl #2
	mov	r6, r1, asl #2
	ldr	r1, [fp, #-76]
	cmp	r0, r6
	cmpgt	r1, ip
	addgt	r1, r2, r4
	strgtb	lr, [r1, #88]
	bgt	.L54
	ldr	r1, [fp, #-72]
	movw	ip, #10000
	cmp	r1, ip
	ble	.L75
	mov	r0, r9, asl #1
	cmp	r0, r8, asl #4
	bgt	.L158
	mov	r1, r7, asl #1
	cmp	r9, r1
	bgt	.L61
	add	r1, r1, r7
	cmp	r0, r1
	add	r0, r2, r4
	ldrb	r1, [r0, #88]
	bgt	.L142
.L92:
	sub	r1, r1, #5
	strb	r1, [r0, #88]
	b	.L54
.L162:
	mov	r1, #0
	strb	r1, [r2, #88]
	strb	r1, [r2, #89]
	mov	r0, r1
	str	r1, [r2, #92]
	b	.L102
.L163:
	ldr	r5, [r1, #20]
	ldr	lr, [r2, #68]
	ldr	r6, [r2, #72]
	str	r5, [r2, #48]
	ldr	r7, [r1, #24]
	ldr	r5, [r2, #76]
	str	r7, [r2, #52]
	ldr	r7, [r1, #32]
	str	r7, [r2, #56]
	ldr	r7, [r1, #44]
	str	r7, [fp, #-68]
	b	.L51
.L56:
	add	r1, ip, r1
	cmp	r7, r1
	ble	.L164
.L143:
	add	r1, r2, r4
	mov	r0, #0
	strb	r0, [r1, #88]
	b	.L54
.L160:
	ldr	ip, [r1, #28]
	clz	r0, r0
	ldr	r8, [r1, #132]
	mov	r0, r0, lsr #5
	ldr	r10, [r1, #44]
	cmp	r0, #1
	str	ip, [fp, #-56]
	ldmib	r1, {r9, ip}
	ldr	r7, [r1, #124]
	ldr	r4, [r1, #32]
	str	r8, [fp, #-48]
	ldrne	r8, [fp, #-56]
	ldr	lr, [r1, #40]
	moveq	lr, r10
	ldr	r6, [r1, #128]
	ldreq	r10, [r2, #44]
	movne	r10, r8
	ldreq	r4, [r2, #40]
	str	ip, [fp, #-52]
	ldr	ip, [r1, #120]
	ldr	r5, [r1, #24]
	add	ip, ip, r7, lsl #1
	ldr	r1, [r1]
	ldreq	r5, [fp, #-56]
	add	r6, ip, r6, lsl #2
	strne	r4, [r2, #40]
	strne	r8, [r2, #44]
	cmp	r4, r10
	ldr	ip, [fp, #-48]
	movlt	r7, r4
	movge	r7, r10
	cmp	r5, #80
	cmple	r10, #80
	mov	r7, r7, asl #1
	add	r6, r6, ip, lsl #3
	ble	.L17
	add	ip, r5, r5, lsl #1
	mov	r9, r10, asl #1
	cmp	ip, r9
	ble	.L165
.L33:
	add	ip, r2, r0
	mov	r4, #0
	strb	r4, [ip, #88]
.L19:
	mov	lr, lr, asl #5
	cmp	lr, #127
	addgt	r0, r2, r0
	ldrgtb	ip, [r0, #88]
	subgt	ip, ip, #5
	strgtb	ip, [r0, #88]
.L106:
	ldr	lr, [r2, #36]
	add	lr, lr, #1
	cmp	lr, #50
	movge	lr, #50
	bic	lr, lr, lr, asr #31
.L42:
	ldrsb	ip, [r2, #88]
	ldrsb	r0, [r2, #89]
	cmp	ip, #32
	str	lr, [r2, #36]
	movge	ip, #32
	cmp	r0, #32
	bic	ip, ip, ip, asr #31
	movge	r0, #32
	bic	r0, r0, r0, asr #31
	uxtb	ip, ip
	strb	ip, [r2, #88]
	uxtb	r0, r0
	sxtb	ip, ip
	strb	r0, [r2, #89]
	sxtb	r0, r0
	cmp	ip, #24
	cmpgt	r0, #24
	movgt	r0, #1
	movgt	lr, #1
	movle	lr, #0
	strgt	r0, [r2, #92]
	bgt	.L44
	cmp	r0, #19
	cmpgt	ip, #19
	strle	lr, [r2, #92]
	ldrgt	r0, [r2, #92]
	movle	r0, lr
.L44:
	ldr	r5, [r2, #12]
	movw	r4, #26215
	ldr	r10, [r2, #8]
	movt	r4, 26214
	ldr	r9, [r2, #4]
	movw	r7, #62537
	add	ip, r5, r10
	ldr	r8, [r2]
	add	ip, r9, ip
	str	r5, [r2, #16]
	add	ip, r8, ip
	ldr	lr, [r2, #28]
	add	ip, r1, ip
	movt	r7, 65535
	stmia	r2, {r1, r8, r9, r10}
	smull	r4, r5, ip, r4
	mov	ip, ip, asr #31
	ldr	r1, [r2, #20]
	rsb	ip, ip, r5, asr #1
	str	ip, [r2, #24]
	add	lr, ip, lr
	rsb	lr, r1, lr
	str	lr, [r2, #28]
	cmp	lr, r7
	blt	.L46
	movw	r1, #3000
	cmp	lr, r1
	str	ip, [r2, #20]
	movge	lr, r1
	cmp	r0, #0
	str	lr, [r2, #28]
	beq	.L109
	cmp	lr, #1000
	movge	r1, #0
	strgeb	r1, [r2, #88]
	movge	r0, r1
	strgeb	r1, [r2, #89]
	strge	r1, [r2, #92]
.L48:
	str	r6, [r2, #32]
	str	r0, [r3, #8]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L46:
	cmp	r0, #0
	movw	r1, #62536
	movt	r1, 65535
	str	ip, [r2, #20]
	str	r1, [r2, #28]
	bne	.L48
.L109:
	mov	r1, #0
	str	r1, [r2, #28]
	b	.L48
.L17:
	movw	ip, #5499
	cmp	r9, ip
	bgt	.L33
	ldr	ip, [fp, #-52]
	cmp	ip, #0
	moveq	ip, #20
	cmp	r9, ip
	bgt	.L33
	cmp	r5, #39
	ble	.L35
	cmp	r5, r10, asl #1
	bge	.L33
.L35:
	cmp	r4, #80
	ble	.L36
	rsb	r4, r4, r10
	add	r7, r7, #50
	eor	ip, r4, r4, asr #31
	sub	ip, ip, r4, asr #31
	cmp	ip, r7
	ble	.L36
	ldr	ip, [r2, #32]
	cmp	ip, #10
	ble	.L36
	ldr	r4, [r2, #92]
	cmp	r4, #1
	beq	.L41
	movw	r4, #5000
	cmp	ip, r4
	ble	.L19
.L41:
	add	r4, r2, r0
	ldr	ip, [r2, #36]
	ldrb	r5, [r4, #88]
	mvn	ip, ip
	add	ip, ip, r5
	strb	ip, [r4, #88]
	b	.L19
.L164:
	add	r0, r2, r4
	ldrb	r1, [r0, #88]
	sub	r1, r1, #5
	strb	r1, [r0, #88]
	b	.L54
.L57:
	cmp	r0, #119
	ble	.L143
	add	ip, ip, r1
	cmp	r0, ip
	bgt	.L143
	rsb	ip, r6, r5
	eor	r0, ip, ip, asr #31
	sub	r0, r0, ip, asr #31
	cmp	r0, #40
	ble	.L69
	cmp	r1, #1
	ldr	r0, [fp, #-52]
	add	r5, r2, r4
	str	r3, [fp, #-56]
	movlt	r1, #1
	str	r2, [fp, #-52]
	bl	__aeabi_idiv
	ldrb	ip, [r5, #88]
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-56]
	rsb	r0, r0, ip
	strb	r0, [r5, #88]
	b	.L54
.L165:
	add	ip, r10, r10, lsl #2
	add	ip, ip, ip, lsr #31
	cmp	r4, ip, asr #1
	bgt	.L38
	cmp	r4, #1000
	ble	.L22
	add	ip, r4, r4, lsl #2
	rsb	r8, r10, r10, lsl #3
	cmp	ip, r8
	bge	.L38
.L22:
	cmp	r5, #99
	ble	.L23
	cmp	r5, #500
	add	ip, r2, r0
	movlt	r8, r5, asr #31
	movwlt	r4, #34079
	ldrb	r7, [ip, #88]
	movtlt	r4, 20971
	movge	r4, #5
	smulllt	r4, r5, r5, r4
	rsblt	r4, r8, r5, asr #5
	uxtblt	r4, r4
	rsb	r4, r4, r7
	strb	r4, [ip, #88]
	b	.L19
.L58:
	ldr	r0, [fp, #-52]
	cmp	r0, ip
	bgt	.L143
	ldr	r0, [fp, #-52]
	mov	r5, r0, asl #1
	add	r0, r5, r0
	cmp	r0, r1, asl #2
	bge	.L65
	add	lr, r7, lr
	cmp	ip, lr
	ble	.L54
	b	.L144
.L38:
	add	r4, r2, r0
	ldrb	ip, [r4, #88]
.L139:
	sub	ip, ip, #1
	strb	ip, [r4, #88]
	b	.L19
.L158:
	ldr	r1, [fp, #-76]
	cmp	r1, ip
	bgt	.L151
	ldr	r1, [fp, #-76]
	cmp	r1, #1000
	ble	.L144
	cmp	r6, r7, asl #4
	bgt	.L144
	ldr	r1, [fp, #-80]
	add	r7, r7, r7, lsl #1
	cmp	r7, r1, asl #1
	blt	.L54
.L97:
	ldr	r1, [r2, #92]
	cmp	r1, #1
	beq	.L166
.L93:
	add	r0, r2, r4
	ldrb	r1, [r0, #88]
.L142:
	sub	r1, r1, #1
	strb	r1, [r0, #88]
	b	.L54
.L75:
	ldr	r1, [fp, #-72]
	cmp	r1, #1000
	ble	.L84
	cmp	r5, r8, asl #4
	bgt	.L158
	add	r7, r7, r7, lsl #1
	add	r0, r2, r4
	cmp	r7, r9, asl #1
	ldrb	r1, [r0, #88]
	blt	.L142
	b	.L92
.L36:
	ldr	ip, [fp, #-52]
	cmp	ip, #1000
	ble	.L38
	mov	r8, r9, asl #4
	mov	ip, ip, asl #1
	cmp	ip, r8
	ble	.L39
	ldr	r4, [fp, #-52]
	movw	ip, #9000
	cmp	r4, ip
	ble	.L19
.L140:
	add	ip, r2, r0
	mov	lr, lr, asl #5
	cmp	lr, #127
	ldrb	r0, [ip, #88]
	add	r0, r0, #1
	strb	r0, [ip, #88]
	ldrgtb	r0, [ip, #88]
	subgt	r0, r0, #5
	strgtb	r0, [ip, #88]
.L108:
	mov	lr, #0
	b	.L42
.L65:
	add	r0, r2, r4
	add	r1, ip, r1
	cmp	r1, r5
	ldrb	r1, [r0, #88]
	suble	r1, r1, #2
	strleb	r1, [r0, #88]
	ble	.L54
	b	.L142
.L23:
	mov	ip, r5, asl #3
	str	ip, [fp, #-52]
	cmp	r10, ip
	blt	.L25
	cmp	r5, #10
	mov	ip, r4, asl #1
	movge	r8, r5
	movlt	r8, #10
	cmp	ip, r8, asl #3
	bge	.L26
.L25:
	rsb	ip, r4, r10
	cmp	ip, #0
	rsblt	ip, ip, #0
	cmp	r7, #150
	mov	r8, ip
	movlt	r7, #150
	add	ip, r7, #50
	cmp	r8, ip
	ble	.L26
	ldr	ip, [r2, #32]
	cmp	ip, #10
	ble	.L26
	add	r4, r2, r0
	ldrb	ip, [r4, #88]
	sub	ip, ip, #5
	strb	ip, [r4, #88]
	b	.L19
.L26:
	ldr	ip, [fp, #-52]
	cmp	ip, r9
	bge	.L27
	cmp	ip, r4, asl #1
	blt	.L28
	ldr	ip, [r2, #32]
	cmp	ip, #9
	bgt	.L27
.L28:
	ldr	ip, [fp, #-48]
	add	ip, ip, #100
	cmp	ip, r5, asl #2
	bge	.L140
	add	r4, r2, r0
	ldrb	ip, [r4, #88]
	sub	ip, ip, #15
	strb	ip, [r4, #88]
	b	.L19
.L69:
	cmp	r0, #19
	bgt	.L54
	b	.L144
.L84:
	bge	.L93
	ldr	r1, [fp, #-76]
	cmp	r1, ip
	bgt	.L151
	ldr	r1, [fp, #-76]
	cmp	r1, #1000
	ble	.L54
	cmp	r6, r7, asl #4
	ble	.L97
	b	.L144
.L151:
	ldr	r1, [fp, #-80]
	mov	r7, r7, asl #4
	cmp	r7, r1, asl #1
	bge	.L97
	b	.L144
.L27:
	add	r10, r10, #150
	cmp	r5, r10
	bgt	.L31
	ldr	ip, [fp, #-56]
	add	ip, ip, #150
	cmp	r5, ip
	ble	.L19
.L31:
	ldr	ip, [r2, #92]
	add	r4, r2, r0
	cmp	ip, #1
	ldrb	ip, [r4, #88]
	subne	ip, ip, #3
	strneb	ip, [r4, #88]
	bne	.L19
	b	.L139
.L60:
	ldr	r0, [fp, #-52]
	add	r5, r0, r0, lsl #1
	cmp	lr, r5
	bgt	.L93
	ldr	r0, [fp, #-52]
	add	r1, ip, r1, lsl #3
	rsb	r0, r0, r0, lsl #3
	cmp	r1, r0
	add	r0, r2, r4
	ldrb	r1, [r0, #88]
	suble	r1, r1, #15
	strleb	r1, [r0, #88]
	ble	.L54
	b	.L92
.L39:
	ldr	r4, [r2, #92]
	cmp	r4, #1
	bne	.L38
	cmp	ip, r8
	bge	.L41
	add	ip, r2, r0
	ldr	r5, [r2, #36]
	ldrb	r4, [ip, #88]
	mvn	r5, r5
	add	r4, r4, r5, lsl #1
	strb	r4, [ip, #88]
	b	.L19
.L166:
	add	r1, r2, r4
	ldr	ip, [r2, #36]
	ldrb	r0, [r1, #88]
	mvn	ip, ip
	add	r0, r0, ip, lsl #1
	strb	r0, [r1, #88]
	b	.L54
	.fnend
	.size	Detect22Pld, .-Detect22Pld
	.align	2
	.global	PQ_MNG_ALG_FmdSet
	.type	PQ_MNG_ALG_FmdSet, %function
PQ_MNG_ALG_FmdSet:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #132
	sub	sp, sp, #132
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r3, [r0]
	mov	r4, r0
	mov	r5, r1
	mov	r6, r2
	cmp	r3, #0
	ldr	r7, [r1, #8]
	beq	.L428
	mov	r1, #28
	mov	r0, r2
	bl	__memzero
	ldr	r3, [r5, #68]
	cmp	r3, #1
	beq	.L429
	ldrb	r3, [r4, #7]
	cmp	r3, #255
	beq	.L171
	ldrb	r3, [r4, #8]
	cmp	r3, #255
	beq	.L171
	ldrb	r3, [r4, #9]
	cmp	r3, #255
	beq	.L171
	ldrb	r3, [r4, #4]
	cmp	r3, #255
	beq	.L173
.L432:
	ldrb	r3, [r4, #5]
	cmp	r3, #255
	beq	.L173
.L174:
	ldr	r3, [r5, #48]
	cmp	r3, #0
	ldrneb	r1, [r4, #9]
	ldreqb	r1, [r4, #8]
	str	r1, [r4, #20]
	ldr	r3, [r5, #48]
	cmp	r3, #0
	ldrneb	r3, [r4, #6]
	ldreqb	r3, [r4, #5]
	str	r3, [r4, #24]
	ldr	r2, [r5, #48]
	cmp	r2, #0
	movne	r2, #1
	moveq	r2, #2
	str	r2, [r4, #28]
	ldr	r2, [r5, #48]
	cmp	r2, #0
	ldrne	r2, [r5, #64]
	ldrne	r0, [r5, #60]
	ldreqb	r2, [r4, #6]
	ldreqb	r0, [r4, #9]
	orrs	r8, r3, r1
	beq	.L188
	cmp	r3, #1
	cmpeq	r1, #1
	moveq	r8, #1
	movne	r8, #0
	eor	r8, r8, #1
.L188:
	orrs	r3, r2, r0
	moveq	r2, r3
	beq	.L189
	cmp	r2, #1
	cmpeq	r0, #1
	moveq	r2, #1
	movne	r2, #0
	eor	r2, r2, #1
.L189:
	ldr	r1, [r4, #448]
	cmp	r7, #1
	ldr	r3, [r4, #452]
	str	r8, [r4, #12]
	str	r1, [r4, #444]
	str	r3, [r4, #448]
	str	r2, [r4, #16]
	ldr	r3, [r4, #464]
	ldr	r2, [r5, #52]
	ldr	r1, [r4, #460]
	str	r3, [r4, #460]
	str	r2, [r4, #452]
	str	r1, [r4, #456]
	ldr	r3, [r5, #56]
	str	r3, [r4, #464]
	bls	.L430
.L190:
	ldrb	r2, [r4, #8]
	ldrb	r3, [r4, #9]
	strb	r2, [r4, #7]
	strb	r3, [r4, #8]
	ldr	r3, [r5, #20]
	cmp	r3, #1
	beq	.L431
.L304:
	mov	r2, #28
	mov	r1, r6
	add	r0, r4, #472
	bl	memcpy
	ldrb	r3, [r4, #6]
	ldrb	r2, [r4, #5]
	strb	r3, [r4, #5]
	strb	r2, [r4, #4]
	ldr	r3, [r5, #64]
	strb	r3, [r4, #6]
.L406:
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L171:
	ldr	r3, [r5, #60]
	strb	r3, [r4, #7]
	ldr	r3, [r5, #60]
	strb	r3, [r4, #8]
	ldr	r3, [r5, #60]
	strb	r3, [r4, #9]
	ldrb	r3, [r4, #4]
	cmp	r3, #255
	bne	.L432
.L173:
	ldr	r3, [r5, #48]
	cmp	r3, #0
	ldrne	r3, [r5, #60]
	ldreqb	r3, [r5, #60]
	clzne	r3, r3
	movne	r3, r3, lsr #5
	strb	r3, [r4, #4]
	ldr	r3, [r5, #48]
	cmp	r3, #0
	ldreq	r3, [r5, #60]
	ldrneb	r3, [r5, #60]
	clzeq	r3, r3
	moveq	r3, r3, lsr #5
	strb	r3, [r4, #5]
	ldr	r3, [r5, #48]
	cmp	r3, #0
	ldrne	r3, [r5, #60]
	ldreqb	r3, [r5, #60]
	clzne	r3, r3
	movne	r3, r3, lsr #5
	strb	r3, [r4, #6]
	b	.L174
.L428:
	str	r3, [r2]
	mov	r1, r2
	str	r3, [r2, #8]
	str	r3, [r2, #4]
	mov	r2, #28
	str	r3, [r6, #12]
	ldr	r3, [r5, #60]
	str	r3, [r6, #20]
	ldr	r3, [r4]
	add	r3, r3, #1
	str	r3, [r0], #472
	bl	memcpy
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L431:
	ldr	r3, [r6, #20]
	cmp	r3, #2
	strneb	r3, [r4, #9]
	b	.L304
.L430:
	ldr	r0, [r5, #44]
	add	r7, r4, #96
	ldr	r1, [r5, #40]
	mov	r2, r4
	mov	r3, r4
	mov	ip, #0
	str	ip, [fp, #-108]
	mul	r0, r1, r0
	str	ip, [fp, #-104]
	str	ip, [fp, #-100]
	mov	r0, r0, asr #11
	str	r0, [r4, #468]
.L191:
	ldrh	ip, [r3, #150]
	add	r3, r3, #6
	ldrh	r1, [r3, #142]
	strh	ip, [r3, #146]
	strh	r1, [r3, #144]
	cmp	r3, r7
	bne	.L191
	add	r3, r5, #232
	mov	r1, #0
.L193:
	ldrh	ip, [r2, #152]
	cmp	r0, ip
	ble	.L192
	ldrh	ip, [r2, #148]
	cmp	r0, ip
	ble	.L192
	ldrh	ip, [r2, #150]
	cmp	r0, ip
	addgt	r1, r1, #1
.L192:
	ldr	ip, [r3, #4]!
	add	r2, r2, #6
	strh	ip, [r2, #142]
	cmp	r2, r7
	bne	.L193
	ldr	r3, [r5, #20]
	str	r1, [r5, #232]
	cmp	r3, #1
	beq	.L433
	cmp	r3, #2
	beq	.L325
	cmp	r3, #3
	moveq	r3, #1
	movne	r3, #2
	str	r3, [fp, #-112]
.L195:
	ldr	lr, [r5, #212]
	mov	r1, r4
	ldr	r3, [r5, #208]
	mov	r0, #0
	ldr	ip, [r5, #216]
	mov	r2, r0
	add	r3, r3, lr, lsl #1
	ldr	r9, [r1, #124]!
	add	ip, r3, ip, lsl #2
	mov	lr, r9
	mov	ip, ip, asl #1
.L234:
	ldr	r3, [r1], #4
	cmp	r9, r3
	add	r0, r0, r3
	movge	r9, r3
	cmp	lr, r3
	movlt	lr, r3
	cmp	r2, #4
	add	r2, r2, #1
	strgt	ip, [r4, #144]
	ldrle	r3, [r1]
	strle	r3, [r1, #-4]
	cmp	r2, #6
	bne	.L234
	rsb	r0, r9, r0
	mov	r2, #3392
	rsb	r0, lr, r0
	movt	r2, 3
	add	r1, r0, #3
	cmp	r0, #0
	add	r3, r4, r8
	movlt	r0, r1
	mov	r0, r0, asr #2
	cmp	ip, r0, asl #1
	movgt	r1, #1
	movle	r1, #0
	cmp	ip, r2
	movle	ip, #0
	andgt	ip, r1, #1
	cmp	r8, #0
	strb	ip, [r3, #111]
	streq	r8, [fp, #-116]
	moveq	r9, r8
	beq	.L235
	ldrsb	r3, [r4, #111]
	cmp	r3, #0
	beq	.L329
	ldrsb	r3, [r4, #112]
	cmp	r3, #0
	beq	.L329
	mov	r3, #1
	str	r3, [fp, #-116]
	mov	r9, r3
.L235:
	ldr	r10, [r5, #24]
	cmp	r10, #0
	beq	.L236
	ldr	r3, .L444
	add	r1, r5, #84
	ldr	r3, [r3, #64]
	cmp	r3, #1
	beq	.L434
	ldr	r10, [r5, #76]
	cmp	r10, #1
	beq	.L435
.L244:
	ldr	r3, [r5, #40]
	cmp	r3, #288
	bgt	.L245
	ldr	r10, [r5, #72]
.L425:
	cmp	r10, #1
	beq	.L236
.L245:
	ldr	r3, [r4, #444]
	cmp	r3, #0
	beq	.L436
	ldr	r3, [r5, #28]
	ldr	r10, [r4, #252]
	cmp	r3, #0
	bne	.L437
	ldrsb	ip, [r4, #108]
	ldrsb	r2, [r4, #109]
	cmp	ip, #1
	beq	.L282
	cmp	ip, #2
	beq	.L281
.L288:
	cmp	r10, #1
	beq	.L340
.L420:
	uxtb	r2, r2
.L283:
	ldr	r7, .L444+4
	sub	lr, fp, #84
	strb	r2, [r4, #109]
	cmp	ip, #1
	strb	ip, [r4, #108]
	ldmia	r7!, {r0, r1, r2, r3}
	ldr	r10, [r5, #8]
	ldr	r8, [r4, #16]
	ldr	r9, [r4, #28]
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	r7!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	r7, {r0, r1}
	ldrb	r7, [fp, #-98]
	stmia	lr, {r0, r1}
	beq	.L290
	cmp	ip, #2
	beq	.L291
	cmp	ip, #0
	beq	.L292
	mov	r3, #0
	str	r3, [r6, #4]
	str	r3, [r6, #8]
	tst	r9, #1
	ldr	r3, [fp, #-112]
	clzne	r8, r8
	movne	r8, r8, lsr #5
	cmp	ip, #2
	str	r3, [r6, #20]
	ldr	r3, [fp, #-116]
	str	r8, [r6]
	str	r3, [r6, #16]
	mov	r3, #0
	str	r3, [r6, #12]
	beq	.L341
	subs	ip, ip, #1
	mvnne	ip, #0
	mov	r3, ip
.L308:
	cmp	ip, #1
	bls	.L300
.L303:
	str	r3, [r6, #24]
	b	.L190
.L429:
	add	r1, r4, #472
	mov	r0, r6
	mov	r2, #28
	bl	memcpy
	b	.L406
.L433:
	ldr	r3, [r4, #444]
	cmp	r3, #0
	movne	r3, #2
	strne	r3, [fp, #-112]
	bne	.L195
	ldr	r3, [r5, #8]
	ldr	r2, [r5, #40]
	cmp	r3, #2
	ldr	ip, [r5, #44]
	str	r2, [fp, #-116]
	beq	.L416
	cmp	r3, #1
	beq	.L438
	ldr	r3, [r4, #12]
	cmp	r3, #0
	beq	.L415
	ldr	r3, [r4, #20]
	ldr	r9, [r5, #220]
	cmp	r3, #1
	ldr	r10, [r5, #224]
	beq	.L306
.L203:
	ldr	r3, [r5, #228]
	str	r3, [fp, #-112]
.L204:
	ldr	r3, [fp, #-112]
	cmp	r10, r3
	movlt	r0, r3
	movge	r0, r10
	cmp	r0, #254
	movgt	lr, r0, asr #31
	movwgt	r2, #26215
	movle	lr, #50
	movtgt	r2, 26214
	smullgt	r2, r3, r0, r2
	rsbgt	lr, lr, r3, asr #1
	add	r0, r0, lr
	cmp	r0, r9
	movge	r3, #0
	movlt	r3, #1
	str	r3, [fp, #-132]
	ldr	r3, [fp, #-112]
	cmp	r9, r3
	movlt	r0, r3
	movge	r0, r9
	cmp	r0, #254
	movgt	lr, r0, asr #31
	movwgt	r2, #26215
	movle	lr, #50
	movtgt	r2, 26214
	smullgt	r2, r3, r0, r2
	rsbgt	lr, lr, r3, asr #1
	add	lr, r0, lr
	cmp	r10, lr
	movgt	r3, #1
	movle	r3, #0
	cmp	r9, r10
	str	r3, [fp, #-136]
	movge	r3, r9
	movlt	r3, r10
	cmp	r3, #254
	str	r3, [fp, #-120]
	movgt	r0, r3, asr #31
	movwgt	r2, #26215
	movle	r3, #50
	movtgt	r2, 26214
	smullgt	r2, r3, r3, r2
	rsbgt	r3, r0, r3, asr #1
	str	r3, [fp, #-144]
	ldr	r3, [fp, #-112]
	cmp	r10, r3
	movge	r0, r3
	movlt	r0, r10
	cmp	r0, #254
	movgt	lr, r0, asr #31
	movwgt	r2, #26215
	movle	lr, #50
	movtgt	r2, 26214
	smullgt	r2, r3, r0, r2
	rsbgt	lr, lr, r3, asr #1
	rsb	lr, lr, r0
	cmp	r9, lr
	movge	r3, #0
	movlt	r3, #1
	str	r3, [fp, #-124]
	ldr	r3, [fp, #-112]
	cmp	r9, r3
	movge	r0, r3
	movlt	r0, r9
	cmp	r0, #254
	movgt	lr, r0, asr #31
	movwgt	r2, #26215
	movle	lr, #50
	movtgt	r2, 26214
	smullgt	r2, r3, r0, r2
	rsbgt	lr, lr, r3, asr #1
	rsb	lr, lr, r0
	cmp	r10, lr
	rsb	lr, r1, #16
	movge	r3, #0
	movlt	r3, #1
	cmp	r9, r10
	str	r3, [fp, #-128]
	movlt	r3, r9
	movge	r3, r10
	cmp	r3, #254
	str	r3, [fp, #-140]
	movgt	r0, r3, asr #31
	ldr	r1, [fp, #-140]
	movwgt	r2, #26215
	movle	r0, #50
	movtgt	r2, 26214
	smullgt	r2, r3, r3, r2
	rsbgt	r0, r0, r3, asr #1
	ldr	r3, [fp, #-116]
	rsb	r1, r0, r1
	str	r1, [fp, #-152]
	rsb	r0, r10, r9
	mul	r2, r3, ip
	ldr	r3, .L444
	str	r3, [fp, #-156]
	mov	r2, r2, asr #9
	add	r1, r2, #31
	cmp	r2, #0
	movlt	r2, r1
	ldr	r1, [r3]
	mov	r2, r2, asr #5
	mul	r2, lr, r2
	str	r1, [r3, #4]
	str	r1, [r3, #8]
	str	r1, [r3, #12]
	cmp	r2, #0
	str	r1, [fp, #-148]
	add	r1, r2, #15
	movge	r1, r2
	mov	r1, r1, asr #4
	add	r1, r1, r1, lsl #1
	add	r1, r1, r1, lsr #31
	mov	r1, r1, asr #1
	cmp	r1, #6
	movlt	r1, #6
	bl	__aeabi_idiv
	subs	r3, r0, #0
	str	r3, [fp, #-116]
	ldr	r3, [fp, #-156]
	ble	.L212
	cmp	r10, #254
	movle	r0, #50
	ble	.L213
	mov	r1, #5
	mov	r0, r10
	bl	__aeabi_idiv
	ldr	r3, [fp, #-156]
.L213:
	add	r0, r10, r0
	cmp	r9, r0
	movgt	r2, #1
	strgt	r2, [r3]
	bgt	.L215
.L214:
	mov	r2, #0
	str	r2, [r3]
.L215:
	ldr	r2, [fp, #-120]
	cmp	r2, #100
	ble	.L217
	str	r3, [fp, #-156]
	mov	r3, r2
	ldr	r2, [fp, #-140]
	mov	r0, #100
	mov	r1, r3
	rsb	r2, r2, r3
	mul	r0, r0, r2
	bl	__aeabi_idiv
	ldr	r3, [fp, #-116]
	cmp	r0, #19
	movle	r3, #0
	str	r3, [fp, #-116]
	ldr	r3, [fp, #-156]
.L217:
	ldr	r0, [fp, #-116]
	movw	r1, #65036
	movt	r1, 65535
	ldr	r2, [r3]
	cmp	r0, r1
	ldr	lr, [r3, #8]
	ldr	r3, [r3, #12]
	movge	r1, r0
	ldr	r0, [fp, #-148]
	cmp	r1, #500
	rsb	r0, r2, r0
	clz	r0, r0
	movge	r1, #500
	cmp	lr, r2
	mov	r0, r0, lsr #5
	addeq	r0, r0, #1
	cmp	r3, r2
	addeq	r0, r0, #1
	cmp	r0, #0
	moveq	r1, r0
	beq	.L220
	ldr	r3, [fp, #-132]
	ldr	r2, [fp, #-128]
	cmp	r3, r2
	bls	.L221
	eor	r3, r1, r1, asr #31
	sub	r3, r3, r1, asr #31
	cmp	r3, #20
	ble	.L220
	cmp	r1, #50
	movlt	r1, #50
.L220:
	ldr	r3, [fp, #-112]
	ldr	r2, [fp, #-152]
	cmp	r3, r2
	blt	.L224
	ldr	r3, [fp, #-120]
	ldr	r2, [fp, #-144]
	add	r0, r3, r2
	ldr	r3, [fp, #-112]
	cmp	r3, r0
	movgt	r1, #0
	bgt	.L224
	ldr	r3, [fp, #-128]
	ldr	r2, [fp, #-132]
	tst	r3, r2
	bne	.L223
	ldr	r3, [fp, #-124]
	ldr	r2, [fp, #-136]
	ands	r3, r3, r2
	bne	.L223
	ldr	r2, [fp, #-128]
	ldr	r0, [fp, #-124]
	orrs	r2, r2, r0
	movne	r1, r3
	bne	.L224
.L223:
	ldr	r2, [fp, #-132]
	ldr	r3, [fp, #-136]
	orr	r3, r3, r2
	ldr	r2, [fp, #-124]
	orr	r3, r2, r3
	ldr	r2, [fp, #-128]
	orrs	r3, r2, r3
	bne	.L224
	cmp	r1, #50
	mvn	r3, #49
	movge	r1, #50
	cmp	r1, r3
	movlt	r1, r3
.L224:
	add	r2, r1, #49
	ldr	r3, [r4, #116]
	cmp	r2, #98
	movls	r1, #0
	add	r1, r1, r3
	cmp	r1, #1000
	str	r1, [r4, #116]
	movgt	r3, #1000
	strgt	r3, [r4, #116]
	bgt	.L227
	cmn	r1, #1000
	movw	r3, #64536
	movt	r3, 65535
	strlt	r3, [r4, #116]
	bge	.L439
.L229:
	mov	r3, #1
	str	r3, [r4, #120]
	str	r3, [fp, #-112]
	b	.L195
.L325:
	mov	r3, #0
	str	r3, [fp, #-112]
	b	.L195
.L434:
	ldr	r3, [r5, #76]
	ldr	r10, [r5, #72]
	cmp	r3, #1
	bne	.L425
	cmp	r10, #0
	bne	.L425
	ldr	r0, .L444+8
	ldr	r2, [r5, #80]
	ldr	ip, [r0]
	cmp	r2, ip
	bcc	.L245
	ldr	r0, [r0, #4]
	cmp	r2, r0
	bcs	.L245
	mov	r10, r3
.L236:
	ldr	r3, [r5, #28]
	cmp	r3, #0
	bne	.L440
.L246:
	ldrsb	ip, [r4, #108]
	ldrsb	r2, [r4, #109]
	cmp	ip, #1
	beq	.L282
	cmp	ip, #2
	bne	.L288
	mov	r3, #0
.L281:
	cmp	r10, #1
	beq	.L420
	sub	ip, r3, #1
	mov	r2, #2
	clz	ip, ip
	mov	ip, ip, lsr #5
	b	.L283
.L329:
	str	r3, [fp, #-116]
	mov	r9, r3
	b	.L235
.L340:
	mov	r10, #0
.L284:
	ldr	r8, [r4, #16]
	mov	r3, #2
	ldr	r9, [r4, #28]
	strb	r10, [r4, #109]
	strb	r3, [r4, #108]
.L291:
	mov	r3, #1
	str	r3, [r6, #4]
	str	r3, [r6, #8]
	tst	r9, #1
	ldr	r3, [fp, #-112]
	clzne	r8, r8
	mov	r2, #1
	str	r2, [r6, #12]
	movne	r8, r8, lsr #5
	str	r8, [r6]
	str	r3, [r6, #20]
	ldr	r3, [fp, #-116]
	str	r3, [r6, #16]
	mov	r3, r2
.L300:
	ldr	r2, .L444+12
	add	r3, r2, r3, lsl #2
	ldr	r3, [r3, #140]
	b	.L303
.L440:
	ldr	r3, [r4, #444]
	ldr	r2, [r4, #28]
	cmp	r3, #0
	ldr	ip, [r5, #212]
	ldr	r3, [r5, #208]
	str	r2, [fp, #-120]
	ldr	r0, [r5, #216]
	bne	.L247
	ldr	r2, [r4, #456]
	cmp	r2, #1
	ble	.L248
	add	r7, r4, #364
	mov	r1, #60
	mov	r0, r7
	bl	__memzero
	ldmia	r7, {r0, r1, r2}
	sub	r3, fp, #108
	stmia	r3, {r0, r1, r2}
	mov	r1, #20
	add	r0, r4, #424
	bl	__memzero
	b	.L246
.L337:
	cmp	r3, #1
	beq	.L420
.L282:
	cmp	r10, #1
	beq	.L284
	ldr	r8, [r4, #16]
	mov	r2, #0
	ldr	r9, [r4, #28]
	mov	r3, #1
	strb	r2, [r4, #108]
	strb	r3, [r4, #109]
.L292:
	tst	r9, #1
	mvn	ip, #0
	clzne	r8, r8
	mov	r3, #0
	str	r3, [r6, #4]
	mov	r2, #0
	str	r3, [r6, #8]
	mov	r3, ip
	movne	r8, r8, lsr #5
	str	r2, [r6, #12]
	str	r8, [r6]
.L295:
	ldr	r2, [fp, #-112]
	str	r2, [r6, #20]
	ldr	r2, [fp, #-116]
	str	r2, [r6, #16]
	b	.L308
.L248:
	ldr	r1, [r4, #104]
	ldr	r2, [r4, #100]
	cmp	r1, #0
	beq	.L253
	add	r3, r3, ip, lsl #1
	add	r3, r3, r0, lsl #2
	mov	r3, r3, asl #1
	str	r3, [r1]
	ldr	r3, [r4, #104]
	ldr	r1, [r4, #32]
	add	r3, r3, #4
	cmp	r3, r7
	addhi	r3, r4, #36
	str	r1, [fp, #-128]
	cmp	r3, #0
	str	r3, [r4, #104]
	add	r3, r1, #1
	str	r3, [r4, #32]
	beq	.L253
	cmp	r3, #4
	ble	.L253
	ldr	r3, [r2]
	sub	r1, fp, #44
	mov	r0, r1
	mov	r1, #0
	str	r3, [r0, #-40]!
	mov	lr, r1
	str	r3, [fp, #-124]
	mov	ip, r0
	str	r0, [fp, #-152]
	mov	r8, r3
	str	r0, [fp, #-132]
	b	.L254
.L257:
	ldr	r3, [r2]
	ldr	r0, [fp, #-124]
	cmp	r3, r0
	str	r3, [ip, #4]!
	strlt	r3, [fp, #-124]
	movlt	lr, r1
.L254:
	cmp	r8, r3
	add	r2, r2, #4
	add	r1, r1, #1
	movlt	r8, r3
	cmp	r7, r2
	addcc	r2, r4, #36
	cmp	r1, #5
	bne	.L257
	ldr	r0, [fp, #-132]
	mov	r3, #0
	str	r8, [fp, #-148]
.L259:
	ldr	r2, [r0], #4
	cmp	r3, lr
	cmpne	r2, r8
	add	r3, r3, #1
	movlt	r8, r2
	cmp	r3, #5
	bne	.L259
	ldr	r3, [r4, #100]
	mov	r2, #0
	mov	r0, r2
	str	r10, [fp, #-160]
	add	r3, r3, #4
	ldr	r10, [fp, #-152]
	cmp	r7, r3
	str	r9, [fp, #-156]
	addcc	r3, r4, #36
	str	r3, [r4, #100]
	add	r3, r4, #424
	str	r3, [fp, #-144]
	str	r4, [fp, #-136]
	mov	r7, r0
	mov	ip, r3
	ldr	r3, [fp, #-128]
	mov	r9, r0
	str	r3, [r4, #32]
	mvn	r3, #0
	ldr	r2, [r5, #124]
	mov	r1, r3
	str	r3, [fp, #-132]
	ldr	r3, [r5, #128]
	str	r1, [fp, #-128]
	cmp	r3, r2
	movge	r3, r2
	cmp	r3, #64
	movle	r3, #0
	movgt	r3, #1
	str	r3, [r4, #356]
	ldr	r4, [fp, #-148]
	str	r5, [fp, #-148]
	ldr	r5, [fp, #-124]
	str	r6, [fp, #-124]
	mov	r6, ip
	str	r3, [fp, #-140]
.L266:
	str	r8, [sp]
	mov	r3, r5
	mov	r2, r4
	mov	r1, r10
	mov	r0, r7
	bl	Check32PdPattern
	cmp	r0, #0
	beq	.L261
	cmp	r0, #1
	bne	.L336
	ldr	r3, [fp, #-136]
	ldrsb	r3, [r3, #113]
	add	r2, r3, #1
	cmp	r7, r2
	beq	.L262
	add	r2, r7, #4
	cmp	r2, r3
	beq	.L262
.L336:
	str	r7, [fp, #-132]
.L261:
	add	r9, r9, #1
.L265:
	add	r7, r7, #1
	add	r6, r6, #4
	cmp	r7, #5
	bne	.L266
	mov	r1, r9
	ldr	r2, [fp, #-140]
	ldr	r9, [fp, #-156]
	ldr	r10, [fp, #-160]
	cmp	r9, #0
	moveq	r3, r2
	orrne	r3, r2, #1
	ldr	r4, [fp, #-136]
	cmp	r1, #4
	orrgt	r3, r3, #1
	ldr	r5, [fp, #-148]
	cmp	r3, #0
	ldr	r6, [fp, #-124]
	bne	.L441
	ldr	r3, [fp, #-128]
	cmp	r3, #4
	bhi	.L270
	add	r2, r4, r3, lsl #2
	ldr	r1, [r4, #12]
	mov	ip, r3
	and	r3, r3, #1
	ldr	r2, [r2, #424]
	cmp	r2, #3
	strb	r2, [r4, #360]
	movle	r0, #0
	movgt	r0, #1
	cmp	r1, r3
	str	r0, [r4, #352]
	ldreqb	r3, [fp, #-128]
	movne	r3, ip
	addne	r3, r3, #5
	uxtbne	r3, r3
	strb	r3, [r4, #362]
.L270:
	ldr	r2, [fp, #-128]
	cmp	r2, #0
	mov	r3, r2
	moveq	r3, #1
	movne	r3, #0
	strb	r3, [r4, #361]
	blt	.L273
	uxtb	r3, r2
.L274:
	add	r2, r4, #352
	strb	r3, [r4, #113]
	ldr	ip, [r4, #400]
	sub	r9, fp, #96
	ldmia	r2, {r0, r1, r2}
	cmp	ip, #1
	mov	r3, r0
	stmia	r9, {r0, r1, r2}
	beq	.L442
.L251:
	add	r7, r4, #376
	add	lr, r4, #388
	add	r8, r4, #364
	add	ip, r4, #400
	ldmia	r7, {r0, r1, r2}
	str	r3, [fp, #-96]
	add	r3, r4, #412
	stmia	r8, {r0, r1, r2}
	ldmia	lr, {r0, r1, r2}
	stmia	r7, {r0, r1, r2}
	ldmia	ip, {r0, r1, r2}
	stmia	lr, {r0, r1, r2}
	ldmia	r3, {r0, r1, r2}
	stmia	ip, {r0, r1, r2}
	ldmia	r9, {r0, r1, r2}
	stmia	r3, {r0, r1, r2}
.L247:
	ldr	r3, [r4, #452]
	cmp	r3, #0
	ldr	r3, [r4, #448]
	bne	.L443
	cmp	r3, #0
	bne	.L276
	ldr	r2, [fp, #-120]
	sub	ip, fp, #108
	mov	r3, r2, asl #4
.L419:
	sub	r3, r3, r2, asl #2
	add	r2, r4, r3
	mov	r3, r2
	add	r2, r2, #364
	ldr	r3, [r3, #364]
	ldmia	r2, {r0, r1, r2}
	stmia	ip, {r0, r1, r2}
	ldrsb	ip, [r4, #108]
	ldrsb	r2, [r4, #109]
	cmp	ip, #1
	beq	.L337
	cmp	ip, #2
	beq	.L281
	cmp	r3, #1
	bne	.L288
	ldr	lr, .L444+4
	sub	ip, fp, #84
	strb	r3, [r4, #108]
	mov	r8, #0
	ldrb	r7, [fp, #-98]
	ldmia	lr!, {r0, r1, r2, r3}
	strb	r8, [r4, #109]
	ldr	r10, [r5, #8]
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr, {r0, r1}
	stmia	ip, {r0, r1}
.L290:
	cmp	r10, #0
	mov	r2, #1
	mov	r3, #0
	stmib	r6, {r2, r3}
	bne	.L296
	sxtb	r3, r7
	movw	r0, #26215
	add	r3, r3, r2
.L421:
	movt	r0, 26214
	mov	r2, r3, asr #31
	smull	r0, r1, r3, r0
	rsb	r2, r2, r1, asr #2
	mov	r1, r2, asl #3
	add	r2, r1, r2, lsl #1
	rsb	r3, r2, r3
	sub	r2, fp, #44
	add	r3, r2, r3, lsl #2
	ldr	r3, [r3, #-40]
	str	r3, [r6]
.L297:
	mov	ip, #0
	str	ip, [r6, #12]
	mov	r3, ip
	b	.L295
.L296:
	cmp	r10, #1
	bne	.L297
	sxtb	r3, r7
	movw	r0, #26215
	add	r3, r3, #2
	b	.L421
.L436:
	ldr	ip, [r5, #8]
	mov	r0, r8
	add	r3, r4, #244
	add	r2, r4, #256
	str	ip, [sp]
	bl	Detect22Pld
	mov	r10, r0
	b	.L236
.L276:
	ldr	r3, [fp, #-120]
	sub	ip, fp, #108
	sub	r2, r3, #1
	mov	r3, r2, asl #4
	b	.L419
.L435:
	ldr	r2, .L444+8
	ldr	r3, [r5, #80]
	ldr	r0, [r2]
	cmp	r3, r0
	bcc	.L244
	ldr	r2, [r2, #4]
	cmp	r3, r2
	bcc	.L236
	b	.L244
.L443:
	cmp	r3, #0
	beq	.L276
	ldr	r3, [fp, #-120]
	sub	ip, fp, #108
	sub	r2, r3, #2
	mov	r3, r2, asl #4
	b	.L419
.L227:
	mov	r3, #0
.L416:
	str	r3, [r4, #120]
	str	r3, [fp, #-112]
	b	.L195
.L341:
	mov	r3, #1
	b	.L300
.L253:
	add	r2, r4, #352
	mov	r3, #0
	mvn	r1, #0
	strb	r3, [r4, #360]
	str	r3, [r4, #352]
	sub	r9, fp, #96
	strb	r3, [r4, #361]
	strb	r1, [r4, #113]
	ldmia	r2, {r0, r1, r2}
	ldr	ip, [r4, #400]
	cmp	ip, #1
	stmia	r9, {r0, r1, r2}
	bne	.L251
.L250:
	mov	r1, #2
	mov	r2, #0
	strb	r1, [r4, #420]
	strb	r1, [r4, #408]
	strb	r1, [r4, #396]
	strb	r1, [r4, #384]
	str	r2, [r4, #412]
	str	r2, [r4, #400]
	str	r2, [r4, #388]
	str	r2, [r4, #376]
	b	.L251
.L439:
	cmp	r1, #200
	bgt	.L227
	cmn	r1, #200
	blt	.L229
.L415:
	ldr	r3, [r4, #120]
	str	r3, [fp, #-112]
	b	.L195
.L441:
	cmp	r2, #0
	movne	r3, #0
	strneb	r3, [r4, #360]
	bne	.L269
	ldrb	r3, [r4, #360]
	sub	r3, r3, #1
	sxtb	r3, r3
	cmp	r3, #4
	movge	r3, #4
	bic	r3, r3, r3, asr #31
	strb	r3, [r4, #360]
.L269:
	add	r3, r4, #360
	mov	r2, #0
	ldrsb	r3, [r3]
	str	r2, [r4, #352]
	strb	r2, [r4, #362]
	str	r3, [r4, #424]
	str	r3, [r4, #428]
	str	r3, [r4, #432]
	str	r3, [r4, #436]
	str	r3, [r4, #440]
	strb	r2, [r4, #361]
.L273:
	ldrb	r3, [fp, #-132]
	b	.L274
.L262:
	ldr	r3, [r6]
	add	r3, r3, #1
	cmp	r3, #5
	movge	r3, #5
	bic	r3, r3, r3, asr #31
	str	r3, [r6]
	cmp	r3, #3
	ble	.L418
	ldr	r2, [fp, #-144]
	mov	r3, #0
.L264:
	cmp	r7, r3
	add	r3, r3, #1
	add	r2, r2, #4
	movne	r1, #3
	strne	r1, [r2, #-4]
	cmp	r3, #5
	bne	.L264
.L418:
	str	r7, [fp, #-132]
	str	r7, [fp, #-128]
	b	.L265
.L442:
	cmp	r0, #0
	bne	.L251
	b	.L250
.L221:
	ldr	r3, [fp, #-136]
	ldr	r2, [fp, #-124]
	cmp	r3, r2
	bls	.L220
	eor	r3, r1, r1, asr #31
	sub	r3, r3, r1, asr #31
	cmp	r3, #20
	ble	.L220
	mvn	r3, #49
	cmp	r1, r3
	movge	r1, r3
	b	.L220
.L438:
	ldr	r3, [r4, #20]
	cmp	r3, #0
	bne	.L198
	ldr	r3, [r4, #24]
	cmp	r3, #0
	beq	.L415
.L407:
	ldr	r3, [r4, #12]
	cmp	r3, #0
	ldrne	r9, [r5, #220]
	ldrne	r10, [r5, #224]
	bne	.L203
	b	.L415
.L212:
	bge	.L214
	cmp	r9, #254
	movle	r0, #50
	ble	.L216
	mov	r1, #5
	mov	r0, r9
	str	r3, [fp, #-156]
	bl	__aeabi_idiv
	ldr	r3, [fp, #-156]
.L216:
	add	r0, r9, r0
	cmp	r10, r0
	ble	.L214
	mov	r2, #2
	str	r2, [r3]
	b	.L215
.L198:
	cmp	r3, #1
	bne	.L407
	ldr	r3, [r4, #24]
	cmp	r3, #1
	beq	.L415
	ldr	r3, [r4, #12]
	cmp	r3, #0
	ldrne	r9, [r5, #220]
	ldrne	r10, [r5, #224]
	beq	.L415
.L306:
	ldr	r2, [r5, #228]
	mov	r3, r10
	mov	r10, r9
	mov	r9, r3
	str	r2, [fp, #-112]
	b	.L204
.L437:
	ldr	r3, [r4, #28]
	str	r3, [fp, #-120]
	b	.L247
.L445:
	.align	2
.L444:
	.word	.LANCHOR1
	.word	.LANCHOR0+100
	.word	.LANCHOR2
	.word	.LANCHOR0
	.fnend
	.size	PQ_MNG_ALG_FmdSet, .-PQ_MNG_ALG_FmdSet
	.global	g_u32FrmRateThr_H
	.global	g_u32FrmRateThr_L
	.global	g_u32IPDetect
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
.LC0:
	.word	1
	.word	1
	.word	1
	.word	1
	.word	0
	.word	1
	.word	1
	.word	1
	.word	0
	.word	1
	.word	1
	.word	1
	.word	0
	.word	1
	.word	1
	.word	1
	.word	0
	.word	1
	.word	1
	.word	1
	.word	0
	.word	1
	.word	1
	.word	1
	.word	1
.LC1:
	.word	0
	.word	1
	.word	0
	.word	1
	.word	0
	.word	0
	.word	1
	.word	0
	.word	1
	.word	0
	.type	g_u32PDTypeNum, %object
	.size	g_u32PDTypeNum, 8
g_u32PDTypeNum:
	.word	32
	.word	22
	.data
	.align	2
.LANCHOR2 = . + 0
	.type	g_u32FrmRateThr_L, %object
	.size	g_u32FrmRateThr_L, 4
g_u32FrmRateThr_L:
	.word	23800
	.type	g_u32FrmRateThr_H, %object
	.size	g_u32FrmRateThr_H, 4
g_u32FrmRateThr_H:
	.word	24200
	.bss
	.align	2
.LANCHOR1 = . + 0
	.type	stastlasi1432big.7856, %object
	.size	stastlasi1432big.7856, 64
stastlasi1432big.7856:
	.space	64
	.type	g_u32IPDetect, %object
	.size	g_u32IPDetect, 4
g_u32IPDetect:
	.space	4
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
