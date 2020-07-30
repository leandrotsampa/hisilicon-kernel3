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
	.file	"pq_mng_db_alg.c"

	.text
	.align	2
	.type	CheckStartEndBorder, %function
CheckStartEndBorder:
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
	cmp	r0, #0
	ble	.L2
	add	r6, r1, r1, lsr #31
	mov	lr, r2
	mov	ip, #0
	mov	r6, r6, asr #1
	b	.L4
.L3:
	add	ip, ip, #1
	cmp	ip, r0
	beq	.L2
.L4:
	mov	r4, lr
	add	lr, lr, #1
	ldrb	r5, [r4]
	cmp	r5, #1
	bne	.L3
	cmp	r6, ip
	blt	.L3
	mov	ip, #0
	strb	ip, [r4]
	ldr	ip, [r3]
	sub	ip, ip, #1
	str	ip, [r3]
.L2:
	cmp	r0, #1
	ldmlefd	sp, {r4, r5, r6, r7, fp, sp, pc}
	add	r1, r1, r1, lsr #31
	sub	ip, r0, #1
	add	r2, r2, ip
	mov	ip, #1
	mov	r4, r1, asr ip
	b	.L7
.L6:
	add	ip, ip, #1
	cmp	ip, r0
	beq	.L11
.L7:
	mov	r1, r2
	sub	r2, r2, #1
	ldrb	lr, [r1]
	cmp	lr, #1
	bne	.L6
	cmp	r4, ip
	blt	.L6
	mov	r2, #0
	strb	r2, [r1]
	ldr	r2, [r3]
	sub	r2, r2, #1
	str	r2, [r3]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L11:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	CheckStartEndBorder, .-CheckStartEndBorder
	.align	2
	.type	DetBorderOffsetRuler, %function
DetBorderOffsetRuler:
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
	cmp	r1, #1
	mov	r3, #0
	str	r0, [fp, #-88]
	ldr	r5, [fp, #4]
	str	r3, [fp, #-76]
	str	r3, [fp, #-72]
	str	r3, [fp, #-68]
	str	r3, [fp, #-64]
	str	r3, [fp, #-60]
	str	r3, [fp, #-56]
	str	r3, [fp, #-52]
	str	r3, [fp, #-48]
	str	r3, [fp, #-80]
	strb	r3, [fp, #-81]
	beq	.L78
	cmp	r1, #2
	subne	r3, fp, #81
	strne	r3, [fp, #-92]
	ldreq	r3, [fp, #8]
	subne	r3, fp, #80
	addeq	r1, r3, #8192
	addeq	r3, r3, #8640
	addeq	r3, r3, #16
	ldreq	r1, [r1, #440]
	streq	r1, [fp, #-92]
.L14:
	ldrsb	r4, [r2]
	ldr	r2, [fp, #-88]
	cmp	r4, #8
	beq	.L15
	sub	r0, r2, #3
	cmp	r0, #4
	bls	.L54
	ldrb	r2, [r5, #4]
	cmp	r2, #1
	beq	.L54
	add	r1, r5, #4
	mov	r8, r0
	mov	r2, #4
	b	.L17
.L28:
	ldrb	ip, [r1, #1]!
	cmp	ip, #1
	beq	.L56
.L17:
	add	r2, r2, #1
	cmp	r2, r0
	bne	.L28
.L16:
	rsb	lr, r4, r8
	cmp	lr, #3
	ble	.L33
	rsb	r1, r4, lr
	rsb	r7, r4, #0
	add	lr, r5, lr
	mov	r2, #0
	mov	r6, #1
.L32:
	add	r1, r1, r7
	strb	r6, [lr, r2]
	add	ip, r4, r1
	rsb	r2, r4, r2
	cmp	ip, #3
	bgt	.L32
.L33:
	cmp	r0, #0
	mov	r6, r0
	ble	.L31
	ldrb	r1, [r5, r0]
	add	r2, r5, r0
	cmp	r1, #1
	bne	.L34
	b	.L31
.L35:
	ldrb	r1, [r2, #-1]!
	cmp	r1, #1
	beq	.L31
.L34:
	subs	r6, r6, #1
	bne	.L35
.L31:
	add	r2, r4, r6
	cmp	r2, r0
	movcc	r1, #1
	bcs	.L40
.L39:
	strb	r1, [r5, r2]
	add	r2, r2, r4
	cmp	r2, r0
	bcc	.L39
.L40:
	cmp	r8, r6
	mov	r2, r8
	bgt	.L37
	mov	ip, r8
	mov	r1, r8
	mov	r9, #1
	str	r3, [fp, #-96]
	sub	r7, r4, #1
	rsb	r10, r4, #0
	add	r8, r4, r9
	mov	r3, r2
	b	.L38
.L42:
	mov	r3, lr
.L38:
	add	lr, r3, #1
	cmp	lr, r6
	bgt	.L79
	cmp	lr, ip
	moveq	r1, ip
	beq	.L42
	ldrb	r2, [r5, lr]
	cmp	r2, #1
	bne	.L42
	add	r1, r1, r4
	rsb	r2, r1, lr
	cmp	r2, r7
	blt	.L58
	add	r2, r4, r1
	rsb	r3, r2, r3
.L43:
	add	r3, r3, r10
	strb	r9, [r5, r1]
	add	r0, r8, r3
	mov	r1, r2
	cmp	r0, r7
	add	r2, r4, r2
	bge	.L43
.L58:
	mov	r1, lr
	b	.L42
.L79:
	ldr	r3, [fp, #-96]
.L37:
	ldr	r2, [fp, #-88]
	mov	r6, #0
	str	r6, [r3]
	cmp	r2, #4
	bls	.L27
	ldr	r2, [fp, #-88]
	add	r0, r5, #3
	sub	ip, r2, #1
	ldr	r2, [fp, #8]
	add	lr, r2, #8192
	ldr	r2, [fp, #-92]
	add	ip, r2, ip
	add	r2, r2, #3
	b	.L49
.L45:
	ldrb	r1, [r2]
	sub	r7, r1, #1
	sxtb	r1, r1
	cmp	r1, #0
	strleb	r6, [r2]
	ble	.L47
.L76:
	strb	r7, [r2]
.L47:
	add	r2, r2, #1
	cmp	r2, ip
	beq	.L27
.L49:
	ldrb	r1, [r0, #1]!
	cmp	r1, #1
	bne	.L45
	ldr	r7, [r3]
	add	r7, r7, #1
	str	r7, [r3]
	strb	r6, [r0]
	strb	r1, [r0, #-1]
	ldrb	r1, [r2]
	ldrb	r7, [lr, #452]
	add	r8, r1, #1
	sxtb	r1, r1
	cmp	r1, r7
	strltb	r8, [r2]
	bge	.L76
	add	r2, r2, #1
	cmp	r2, ip
	bne	.L49
.L27:
	mov	r2, r5
	mov	r1, r4
	ldr	r0, [fp, #-88]
	bl	CheckStartEndBorder
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L56:
	mov	r8, r2
	b	.L16
.L15:
	sub	ip, r2, #3
	cmp	ip, #4
	bls	.L55
	add	r1, r5, #3
	mov	r2, #4
	b	.L20
.L19:
	add	r2, r2, #1
	cmp	r2, ip
	beq	.L80
.L20:
	ldrb	r0, [r1, #1]!
	cmp	r0, #1
	bne	.L19
	and	r0, r2, #7
	sub	lr, fp, #44
	add	r2, r2, #1
	add	r0, lr, r0, lsl #2
	cmp	r2, ip
	ldr	lr, [r0, #-32]
	add	lr, lr, #1
	str	lr, [r0, #-32]
	bne	.L20
.L80:
	ldr	r0, [fp, #-76]
.L18:
	mov	r2, #0
	sub	ip, fp, #76
	mov	lr, r2
	mov	r1, r2
	b	.L50
.L22:
	ldr	r0, [ip, #4]!
.L50:
	cmp	r0, lr
	movhi	r2, r1
	add	r1, r1, #1
	movhi	lr, r0
	cmp	r1, #8
	bne	.L22
	ldr	r1, [fp, #-88]
	uxtb	r6, r2
	cmp	r1, #0
	bne	.L81
	ldr	r2, [fp, #-88]
	cmp	r6, #0
	str	r2, [r3]
	beq	.L27
.L51:
	sxtb	r2, r6
	mov	r1, #1
	add	r0, r5, r2
	strb	r1, [r0, #-1]
	str	r1, [r3]
.L24:
	ldr	r1, [fp, #-88]
	add	r2, r2, #7
	cmp	r1, r2
	movhi	r0, #1
	ldrhi	ip, [fp, #-88]
	bls	.L27
.L26:
	strb	r0, [r5, r2]
	add	r2, r2, #8
	ldr	r1, [r3]
	cmp	ip, r2
	add	r1, r1, #1
	str	r1, [r3]
	bhi	.L26
	b	.L27
.L78:
	ldr	r3, [fp, #8]
	add	r1, r3, #8192
	add	r3, r3, #8640
	add	r3, r3, #12
	ldr	r1, [r1, #444]
	str	r1, [fp, #-92]
	b	.L14
.L81:
	mov	r0, r5
	str	r3, [fp, #-92]
	bl	__memzero
	ldr	r3, [fp, #-92]
	cmp	r6, #0
	mov	r2, #0
	str	r2, [r3]
	moveq	r2, r6
	beq	.L24
	b	.L51
.L54:
	mov	r2, #4
	mov	r8, r2
	b	.L16
.L55:
	mov	r0, #0
	b	.L18
	.fnend
	.size	DetBorderOffsetRuler, .-DetBorderOffsetRuler
	.align	2
	.global	DB_CountBorderNum
	.type	DB_CountBorderNum, %function
DB_CountBorderNum:
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
	cmp	r1, #1
	bls	.L86
	sub	r1, r1, #2
	mov	r3, r0
	mov	r0, #0
	uxth	r1, r1
	add	r1, r1, #1
	add	r1, r3, r1
.L85:
	ldrb	r2, [r3, #1]!
	cmp	r2, #1
	addeq	r0, r0, #1
	uxtheq	r0, r0
	cmp	r3, r1
	bne	.L85
	ldmfd	sp, {fp, sp, pc}
.L86:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	DB_CountBorderNum, .-DB_CountBorderNum
	.global	__aeabi_uidiv
	.align	2
	.global	PQ_MNG_ALG_GetDbDetInfo
	.type	PQ_MNG_ALG_GetDbDetInfo, %function
PQ_MNG_ALG_GetDbDetInfo:
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
	mov	r5, r2
	mov	r8, r0
	mov	r6, r1
	ldr	r0, .L325
	movw	r1, #20508
	ldr	r7, .L325+4
	bl	__memzero
	mov	r1, r5
	movw	r2, #8808
	mov	r0, r8
	bl	memcpy
	ldr	r2, [r5, #48]
	ldr	r0, .L325
	add	r3, r2, #1
	strb	r2, [r7, #12]
	ldr	r2, [r5, #64]
	uxtb	r3, r3
	cmp	r3, #64
	strb	r2, [r7, #13]
	add	r2, r2, #1
	ldr	r3, [r5, #56]
	uxtb	r2, r2
	strb	r3, [r7, #14]
	add	r3, r3, #1
	ldr	r1, [r5, #44]
	uxtb	r3, r3
	str	r1, [r7]
	ldr	r1, [r5, #60]
	str	r1, [r7, #4]
	ldr	r1, [r5, #52]
	str	r1, [r7, #8]
	mvnhi	r1, #0
	strhib	r1, [r7, #12]
	cmp	r2, #64
	mov	r1, #16384
	mvnhi	r2, #0
	strhib	r2, [r7, #13]
	cmp	r3, #64
	mvnhi	r3, #0
	strhib	r3, [r7, #14]
	bl	__memzero
	ldr	r2, .L325+8
	add	r1, r5, #576
	add	ip, r2, #16384
.L92:
	ldr	r3, [r1, #4]!
	ubfx	r0, r3, #0, #11
	ubfx	r3, r3, #16, #11
	str	r0, [r2, #-4]
	str	r3, [r2], #8
	cmp	r2, ip
	bne	.L92
	mov	r1, #4096
	ldr	r0, .L325+12
	ldr	r4, .L325
	bl	__memzero
	add	ip, r5, #64
	mov	lr, #1
	movw	r9, #4097
.L93:
	add	r3, lr, #16384
	ldr	r2, [ip, #4]!
	add	r3, r3, #14
	mov	r1, lr
	and	r2, r2, #1
	mov	r0, #1
	strb	r2, [r4, r3]
	b	.L95
.L301:
	mov	r2, r2, asr r0
	add	r0, r0, #1
	cmp	r0, #32
	and	r2, r2, #1
	add	r1, r1, #1
	strb	r2, [r3]
	beq	.L300
.L95:
	add	r3, r4, r1
	cmp	r1, #4096
	add	r3, r3, #16384
	ldr	r2, [ip]
	add	r3, r3, #15
	bcc	.L301
.L94:
	ldr	r0, .L325+12
	movw	r3, #3836
	ldr	ip, .L325+16
	add	r1, r0, #1920
	add	r2, r0, #2880
	str	r0, [ip, #16]
	str	r1, [ip, #20]
	str	r2, [ip, #24]
	ldr	r2, [r5]
	ldr	r1, [r5, #8]
	str	r2, [fp, #-80]
	sub	r2, r2, #4
	str	r1, [fp, #-88]
	cmp	r2, r3
	ldr	r1, [r5, #4]
	str	r1, [fp, #-84]
	bhi	.L97
	sub	r3, r1, #1
	cmp	r3, #2160
	bcs	.L97
.L98:
	ldr	r2, [fp, #-84]
	movw	r3, #1080
	ldr	r1, [fp, #-80]
	cmp	r1, #1920
	cmple	r2, r3
	movgt	r3, #0
	strgt	r3, [r5, #36]
	strgt	r3, [r5, #40]
	ldr	r3, [fp, #-88]
	cmp	r3, #960
	movgt	r3, #0
	strgt	r3, [r5, #36]
	ldr	r3, [r5, #32]
	cmp	r3, #1
	beq	.L302
.L101:
	add	r4, r6, #8192
	mvn	r3, #0
	strb	r3, [r6]
.L170:
	ldr	r3, [r5, #36]
	cmp	r3, #1
	beq	.L303
.L173:
	mvn	r3, #0
	strb	r3, [r6, #1]
.L197:
	ldr	r3, [r5, #40]
	cmp	r3, #1
	beq	.L304
.L200:
	mvn	r3, #0
	strb	r3, [r6, #2]
.L224:
	ldr	r3, [r6, #4]
	mov	r0, #0
	str	r3, [r8, #44]
	ldrsb	r3, [r6]
	str	r3, [r8, #48]
	ldr	r3, [r6, #8]
	str	r3, [r8, #52]
	ldrsb	r3, [r6, #2]
	str	r3, [r8, #56]
	ldr	r3, [r6, #12]
	str	r3, [r8, #60]
	ldrsb	r3, [r6, #1]
	str	r3, [r8, #64]
	ldr	r3, [r4, #456]
	str	r3, [r8, #16]
	ldr	r3, [r4, #460]
	str	r3, [r8, #20]
	ldr	r3, [r4, #464]
	str	r3, [r8, #24]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L97:
	mov	r3, #0
	str	r3, [r5, #28]
	b	.L98
.L300:
	add	lr, lr, #32
	cmp	lr, r9
	bne	.L93
	b	.L94
.L302:
	ldr	r3, [r5, #28]
	cmp	r3, #1
	bne	.L101
	add	r10, r6, #4096
	ldr	r1, [r7]
	ldr	r3, .L325+4
	ldrb	r2, [r10, #30]
	cmp	r1, r2
	bcc	.L102
	ldrb	r0, [r3, #12]
	add	r3, r0, #1
	uxtb	r3, r3
	cmp	r3, #1
	bls	.L103
.L104:
	ldrb	r1, [r10, #28]
	add	r3, r6, #4096
	add	r3, r3, #52
	sub	r2, r1, #1
	uxtb	r2, r2
	sxtb	ip, r2
	cmp	ip, #0
	ble	.L105
.L106:
	sxtb	ip, r2
	sub	r2, r2, #1
	ands	r2, r2, #255
	sxth	ip, ip
	mov	r0, ip, asl #3
	sub	r1, r0, #8
	add	r0, r3, r0
	add	lr, r3, r1
	ldrb	r1, [r3, r1]
	strb	r1, [r3, ip, asl #3]
	ldr	r1, [lr, #4]
	str	r1, [r0, #4]
	bne	.L106
	ldrb	r0, [r7, #12]
	ldrb	r1, [r10, #28]
.L105:
	ldr	r2, [r10, #36]
	strb	r0, [r10, #52]
	cmp	r2, r1
	ldr	r0, [r7]
	addcc	r2, r2, #1
	strcc	r2, [r10, #36]
	cmp	r1, r2
	str	r0, [r10, #56]
	beq	.L108
.L113:
	ldrb	r3, [r6]
	ldrb	r2, [r7, #12]
.L109:
	cmp	r2, r3
	sxtb	r2, r3
	str	r2, [fp, #-112]
	beq	.L305
	ldr	r3, [fp, #-80]
	add	r4, r6, #8192
	cmp	r3, #0
	ldr	r0, [r4, #436]
	bne	.L306
.L172:
	mov	r3, #0
	strb	r3, [r4, #448]
	b	.L170
.L304:
	ldr	r3, [r5, #28]
	cmp	r3, #1
	bne	.L200
	add	r10, r6, #4096
	ldr	r1, [r7, #8]
	ldr	r3, .L325+4
	ldrb	r2, [r10, #32]
	cmp	r1, r2
	bcc	.L201
	ldrb	r0, [r3, #14]
	add	r3, r0, #1
	uxtb	r3, r3
	cmp	r3, #1
	bls	.L202
.L203:
	ldrb	r1, [r10, #28]
	add	r3, r6, #4224
	add	r3, r3, #52
	sub	r2, r1, #1
	uxtb	r2, r2
	sxtb	ip, r2
	cmp	ip, #0
	ble	.L204
.L205:
	sxtb	r0, r2
	sub	r2, r2, #1
	ands	r2, r2, #255
	sxth	r0, r0
	mov	r1, r0, asl #3
	sub	ip, r1, #8
	add	r1, r3, r1
	add	lr, r3, ip
	ldrb	ip, [r3, ip]
	strb	ip, [r3, r0, asl #3]
	ldr	r0, [lr, #4]
	str	r0, [r1, #4]
	bne	.L205
	ldrb	r0, [r7, #14]
	ldrb	r1, [r10, #28]
.L204:
	ldr	r2, [r10, #44]
	strb	r0, [r10, #180]
	cmp	r2, r1
	ldr	r0, [r7, #8]
	addcc	r2, r2, #1
	strcc	r2, [r10, #44]
	cmp	r1, r2
	str	r0, [r10, #184]
	beq	.L207
.L212:
	ldrb	r2, [r6, #2]
	ldrb	r3, [r7, #14]
.L208:
	cmp	r3, r2
	beq	.L307
	ldr	r3, [fp, #-84]
	ldr	r0, [r4, #444]
	cmp	r3, #0
	bne	.L308
.L226:
	mov	r3, #0
	strb	r3, [r4, #450]
	b	.L224
.L303:
	ldr	r3, [r5, #28]
	cmp	r3, #1
	bne	.L173
	add	r10, r6, #4096
	ldr	r1, [r7, #4]
	ldr	r3, .L325+4
	ldrb	r2, [r10, #31]
	cmp	r1, r2
	bcc	.L174
	ldrb	r0, [r3, #13]
	add	r3, r0, #1
	uxtb	r3, r3
	cmp	r3, #1
	bls	.L175
.L176:
	ldrb	r1, [r10, #28]
	add	r3, r6, #4352
	add	r3, r3, #52
	sub	r2, r1, #1
	uxtb	r2, r2
	sxtb	ip, r2
	cmp	ip, #0
	ble	.L177
.L178:
	sxtb	ip, r2
	sub	r2, r2, #1
	ands	r2, r2, #255
	sxth	ip, ip
	mov	r0, ip, asl #3
	sub	r1, r0, #8
	add	r0, r3, r0
	add	lr, r3, r1
	ldrb	r1, [r3, r1]
	strb	r1, [r3, ip, asl #3]
	ldr	r1, [lr, #4]
	str	r1, [r0, #4]
	bne	.L178
	ldrb	r0, [r7, #13]
	ldrb	r1, [r10, #28]
.L177:
	ldr	r2, [r10, #40]
	strb	r0, [r10, #308]
	cmp	r2, r1
	ldr	r0, [r7, #4]
	addcc	r2, r2, #1
	strcc	r2, [r10, #40]
	cmp	r1, r2
	str	r0, [r10, #312]
	beq	.L180
.L185:
	ldrb	r2, [r6, #1]
	ldrb	r3, [r7, #13]
.L181:
	cmp	r3, r2
	beq	.L309
	ldr	r3, [fp, #-88]
	ldr	r0, [r4, #440]
	cmp	r3, #0
	bne	.L310
.L199:
	mov	r3, #0
	strb	r3, [r4, #449]
	b	.L197
.L174:
	mov	r0, #255
	mvn	r2, #0
	strb	r2, [r3, #13]
.L175:
	mov	r3, #100
	str	r3, [r7, #4]
	b	.L176
.L102:
	mov	r0, #255
	mvn	r2, #0
	strb	r2, [r3, #12]
.L103:
	mov	r3, #100
	str	r3, [r7]
	b	.L104
.L201:
	mov	r0, #255
	mvn	r2, #0
	strb	r2, [r3, #14]
.L202:
	mov	r3, #100
	str	r3, [r7, #8]
	b	.L203
.L308:
	mov	r1, r3
	bl	__memzero
	b	.L226
.L306:
	mov	r1, r3
	bl	__memzero
	b	.L172
.L310:
	mov	r1, r3
	bl	__memzero
	b	.L199
.L309:
	add	r2, r2, #1
	uxtb	r3, r2
	cmp	r3, #1
	bls	.L187
	ldr	r3, .L325+16
	mov	r1, #2
	ldr	r0, [fp, #-88]
	ldr	r2, [r3, #20]
	ldr	r3, .L325+20
	str	r6, [sp, #4]
	str	r2, [sp]
	add	r2, r3, #9
	bl	DetBorderOffsetRuler
	ldrsb	r2, [r6, #1]
	ldr	r3, .L325+16
	cmp	r2, #8
	beq	.L188
	ldrb	r3, [r4, #449]
	ldrb	r2, [r4, #451]
	cmp	r3, r2
	addcc	r3, r3, #1
	uxtbcc	r3, r3
	strccb	r3, [r4, #449]
	cmp	r2, r3
	beq	.L311
	ldr	r3, .L325+16
	ldr	r2, [fp, #-88]
	ldr	r0, [r10, #24]
	ldr	r1, [r3, #20]
	bl	memcpy
.L196:
	ldr	r3, [r7, #4]
	str	r3, [r6, #12]
	b	.L197
.L180:
	cmp	r1, #1
	ldrb	r2, [r7, #13]
	ble	.L241
	mov	ip, #1
	sxtb	r0, r2
	mov	r9, r2
	str	r0, [fp, #-92]
	mov	r0, ip
	b	.L184
.L183:
	cmp	ip, r1
	add	r3, r3, #8
	beq	.L312
.L184:
	ldrsb	r2, [r3, #8]
	add	ip, ip, #1
	ldr	lr, [fp, #-92]
	cmp	r2, lr
	bne	.L183
	add	r2, r0, #1
	ldrb	lr, [r10, #50]
	str	r2, [fp, #-80]
	ldr	r2, [r3, #12]
	cmp	r2, lr
	ldrcsb	r0, [fp, #-80]
	b	.L183
.L305:
	uxtb	r3, r3
	str	r3, [fp, #-100]
	mov	r2, r3
	add	r3, r3, #1
	uxtb	r3, r3
	cmp	r3, #1
	bls	.L115
	cmp	r2, #8
	ldr	r2, .L325+16
	mov	r3, #0
	str	r3, [fp, #-76]
	str	r3, [fp, #-72]
	ldr	r2, [r2, #16]
	str	r3, [fp, #-68]
	str	r3, [fp, #-64]
	str	r2, [fp, #-92]
	str	r3, [fp, #-60]
	str	r3, [fp, #-56]
	str	r3, [fp, #-52]
	str	r3, [fp, #-48]
	beq	.L116
	ldr	r3, [fp, #-80]
	sub	r9, r3, #3
	cmp	r9, #4
	bls	.L234
	ldrb	r3, [r2, #4]
	cmp	r3, #1
	beq	.L234
	add	r3, r2, #4
	mov	r2, #4
	b	.L118
.L130:
	ldrb	r1, [r3, #1]!
	cmp	r1, #1
	beq	.L295
.L118:
	add	r2, r2, #1
	str	r2, [fp, #-96]
	cmp	r2, r9
	bne	.L130
.L295:
	str	r2, [fp, #-108]
.L117:
	ldr	r3, [fp, #-96]
	ldr	r2, [fp, #-100]
	rsb	r3, r2, r3
	cmp	r3, #4
	ble	.L137
.L136:
	sub	r2, r3, #-1073741823
	mov	r1, #0
	mov	ip, r1
	mov	r0, r1
	add	r2, r4, r2, lsl #2
.L135:
	ldr	lr, [r2], #4
	cmp	lr, ip
	movhi	r1, r0
	add	r0, r0, #1
	movhi	ip, lr
	cmp	r0, #3
	bne	.L135
	sub	r3, r3, #1
	ldr	r0, [fp, #-92]
	add	r1, r3, r1
	ldr	r3, [fp, #-100]
	mov	r2, #1
	rsb	r3, r3, r1
	strb	r2, [r0, r1]
	cmp	r3, #4
	bgt	.L136
.L137:
	cmp	r9, #0
	mov	r3, r9
	ble	.L296
	ldr	r2, [fp, #-92]
	ldrb	r1, [r2, r9]
	add	r2, r2, r9
	cmp	r1, #1
	bne	.L140
	b	.L296
.L141:
	ldrb	r1, [r2, #-1]!
	cmp	r1, #1
	beq	.L237
.L140:
	subs	r3, r3, #1
	bne	.L141
.L237:
	str	r3, [fp, #-104]
.L138:
	ldr	r3, [fp, #-104]
	ldr	r2, [fp, #-100]
	add	r3, r3, r2
	cmp	r3, r9
	bcs	.L148
.L147:
	sub	r2, r3, #-1073741823
	mov	r1, #0
	mov	ip, r1
	mov	r0, r1
	add	r2, r4, r2, lsl #2
.L146:
	ldr	lr, [r2], #4
	cmp	lr, ip
	movhi	r1, r0
	add	r0, r0, #1
	movhi	ip, lr
	cmp	r0, #3
	bne	.L146
	sub	r3, r3, #1
	ldr	r0, [fp, #-92]
	add	r1, r3, r1
	ldr	r3, [fp, #-100]
	mov	r2, #1
	add	r3, r1, r3
	strb	r2, [r0, r1]
	cmp	r3, r9
	bcc	.L147
.L148:
	ldr	r3, [fp, #-96]
	ldr	r2, [fp, #-104]
	cmp	r3, r2
	bhi	.L144
	ldr	r3, [fp, #-96]
	mov	r9, #0
	str	r5, [fp, #-120]
	str	r6, [fp, #-116]
	mov	r5, r3
	b	.L155
.L151:
	ldr	r3, [fp, #-108]
	ldr	r2, [fp, #-104]
	add	r3, r3, #1
	str	r3, [fp, #-108]
	cmp	r3, r2
	mov	r5, r3
	bhi	.L313
.L155:
	ldr	r3, [fp, #-92]
	ldrb	ip, [r3, r5]
	cmp	ip, #1
	bne	.L151
	ldr	r3, [fp, #-96]
	str	ip, [fp, #-124]
	cmp	r3, r5
	beq	.L238
	ldr	r1, [fp, #-100]
	rsb	r0, r9, r5
	bl	__aeabi_uidiv
	cmp	r0, #1
	mov	r6, r0
	bls	.L239
	ldr	ip, [fp, #-124]
.L154:
	ldr	r3, [fp, #-100]
	add	r1, r9, r3
	mov	r9, #0
	sub	r2, r1, #-1073741823
	mov	r0, r9
	mov	r3, r9
	add	r2, r4, r2, lsl #2
.L153:
	ldr	lr, [r2], #4
	cmp	lr, r0
	movhi	r9, r3
	add	r3, r3, #1
	movhi	r0, lr
	cmp	r3, #3
	bne	.L153
	sub	r1, r1, #1
	add	ip, ip, #1
	ldr	r2, [fp, #-92]
	add	r9, r1, r9
	cmp	ip, r6
	mov	r3, #1
	strb	r3, [r2, r9]
	bne	.L154
.L239:
	mov	r9, r5
	b	.L151
.L108:
	cmp	r1, #1
	ldrb	lr, [r7, #12]
	ble	.L232
	mov	r2, #1
	sxtb	r0, lr
	mov	r9, lr
	str	r0, [fp, #-96]
	str	r1, [fp, #-100]
	mov	r0, r2
	mov	lr, r8
	b	.L112
.L111:
	ldr	r1, [fp, #-100]
	add	r3, r3, #8
	cmp	ip, r1
	bge	.L314
.L112:
	ldrsb	ip, [r3, #8]
	add	r2, r2, #1
	ldr	r8, [fp, #-96]
	uxtb	r2, r2
	cmp	ip, r8
	sxtb	ip, r2
	bne	.L111
	add	r1, r0, #1
	ldrb	r8, [r10, #49]
	str	r1, [fp, #-92]
	ldr	r1, [r3, #12]
	cmp	r1, r8
	ldrcsb	r0, [fp, #-92]
	b	.L111
.L307:
	add	r2, r2, #1
	uxtb	r3, r2
	cmp	r3, #1
	bls	.L214
	ldr	r3, .L325+16
	mov	r1, #1
	ldr	r0, [fp, #-84]
	ldr	r2, [r3, #24]
	ldr	r3, .L325+24
	str	r6, [sp, #4]
	str	r2, [sp]
	add	r2, r3, #6
	bl	DetBorderOffsetRuler
	ldrsb	r2, [r6, #2]
	ldr	r3, .L325+16
	cmp	r2, #8
	beq	.L215
	ldrb	r3, [r4, #450]
	ldrb	r2, [r4, #451]
	cmp	r3, r2
	addcc	r3, r3, #1
	uxtbcc	r3, r3
	strccb	r3, [r4, #450]
	cmp	r2, r3
	beq	.L315
	ldr	r3, .L325+16
	ldr	r2, [fp, #-84]
	ldr	r0, [r10, #20]
	ldr	r1, [r3, #24]
	bl	memcpy
.L223:
	ldr	r3, [r7, #8]
	str	r3, [r6, #8]
	b	.L224
.L207:
	cmp	r1, #1
	ldrb	r2, [r7, #14]
	ble	.L243
	mov	ip, #1
	sxtb	lr, r2
	mov	r0, ip
	mov	r9, r2
	b	.L211
.L210:
	cmp	ip, r1
	add	r3, r3, #8
	beq	.L316
.L211:
	ldrsb	r2, [r3, #8]
	add	ip, ip, #1
	cmp	r2, lr
	bne	.L210
	add	r2, r0, #1
	ldrb	r5, [r10, #51]
	str	r2, [fp, #-80]
	ldr	r2, [r3, #12]
	cmp	r2, r5
	ldrcsb	r0, [fp, #-80]
	b	.L210
.L316:
	mov	r2, r9
.L209:
	ldrb	r3, [r10, #48]
	cmp	r3, r0
	bhi	.L212
	strb	r2, [r6, #2]
	ldrb	r3, [r7, #14]
	b	.L208
.L314:
	mov	r8, lr
	mov	lr, r9
.L110:
	ldrb	r3, [r10, #48]
	cmp	r3, r0
	bhi	.L113
	strb	lr, [r6]
	mov	r3, lr
	ldrb	r2, [r7, #12]
	b	.L109
.L315:
	ldr	r3, [fp, #-84]
	cmp	r3, #4
	ble	.L244
	add	r3, r3, #1
	mov	r2, #0
	str	r3, [fp, #-80]
	mov	r3, #5
	str	r6, [fp, #-84]
	b	.L222
.L219:
	ldr	r1, [fp, #-80]
	add	r3, r3, #1
	cmp	r3, r1
	beq	.L317
.L222:
	ldr	ip, [r10, #20]
	sub	r1, r3, #1
	ldrb	r9, [ip, r1]
	cmp	r9, #1
	bne	.L219
	ldr	r0, [r4, #444]
	sub	r6, r3, #2
	ldrb	r5, [r4, #451]
	add	r2, r2, #1
	ldrsb	lr, [r0, r1]
	cmp	lr, r5
	bge	.L219
	ldrsb	lr, [r0, r6]
	ldrsb	r0, [r0, r3]
	cmp	r5, lr
	bgt	.L221
	cmp	lr, r0
	blt	.L221
	strb	r9, [ip, r6]
	mov	ip, #0
	ldr	r0, [r10, #20]
	strb	ip, [r0, r1]
	b	.L219
.L214:
	ldr	r3, [fp, #-84]
	ldr	r0, [r10, #20]
	cmp	r3, #0
	bne	.L318
	ldr	r3, [fp, #-84]
	str	r3, [r6, #8]
	mvn	r3, #0
	strb	r3, [r6, #2]
.L231:
	mov	r3, #0
	strb	r3, [r4, #450]
	str	r3, [r4, #460]
	b	.L224
.L187:
	ldr	r3, [fp, #-88]
	ldr	r0, [r10, #24]
	cmp	r3, #0
	bne	.L319
	ldr	r3, [fp, #-88]
	str	r3, [r6, #12]
	mvn	r3, #0
	strb	r3, [r6, #1]
.L230:
	mov	r3, #0
	strb	r3, [r4, #449]
	str	r3, [r4, #464]
	b	.L197
.L115:
	ldr	r3, [fp, #-80]
	ldr	r0, [r10, #16]
	cmp	r3, #0
	bne	.L320
	ldr	r3, [fp, #-80]
	add	r4, r6, #8192
	str	r3, [r6, #4]
	mvn	r3, #0
	strb	r3, [r6]
.L229:
	mov	r3, #0
	strb	r3, [r4, #448]
	str	r3, [r4, #456]
	b	.L170
.L311:
	ldr	r3, [fp, #-88]
	cmp	r3, #4
	ble	.L242
	add	r3, r3, #1
	mov	r9, #0
	str	r3, [fp, #-80]
	mov	r3, #5
	str	r8, [fp, #-88]
	str	r5, [fp, #-92]
	b	.L195
.L192:
	ldr	r2, [fp, #-80]
	add	r3, r3, #1
	cmp	r3, r2
	beq	.L321
.L195:
	ldr	r0, [r10, #24]
	sub	r2, r3, #1
	ldrb	r5, [r0, r2]
	cmp	r5, #1
	bne	.L192
	ldr	r1, [r4, #440]
	sub	r8, r3, #2
	ldrb	lr, [r4, #451]
	add	r9, r9, #1
	ldrsb	ip, [r1, r2]
	cmp	ip, lr
	bge	.L192
	ldrsb	ip, [r1, r8]
	ldrsb	r1, [r1, r3]
	cmp	lr, ip
	bgt	.L194
	cmp	ip, r1
	blt	.L194
	strb	r5, [r0, r8]
	mov	r0, #0
	ldr	r1, [r10, #24]
	strb	r0, [r1, r2]
	b	.L192
.L312:
	mov	r2, r9
.L182:
	ldrb	r3, [r10, #48]
	cmp	r3, r0
	bhi	.L185
	strb	r2, [r6, #1]
	ldrb	r3, [r7, #13]
	b	.L181
.L242:
	mov	r9, #0
.L191:
	str	r9, [r4, #464]
	b	.L196
.L243:
	mov	r0, #1
	b	.L209
.L241:
	mov	r0, #1
	b	.L182
.L215:
	ldr	r2, [fp, #-84]
	ldr	r1, [r3, #24]
	ldr	r0, [r10, #20]
	bl	memcpy
	b	.L223
.L221:
	cmp	r5, r0
	cmple	lr, r0
	movlt	r0, #1
	strltb	r0, [ip, r3]
	ldrlt	r0, [r10, #20]
	movlt	ip, #0
	strltb	ip, [r0, r1]
	b	.L219
.L232:
	mov	r0, #1
	b	.L110
.L317:
	ldr	r6, [fp, #-84]
.L218:
	str	r2, [r4, #460]
	b	.L223
.L244:
	mov	r2, #0
	b	.L218
.L321:
	ldr	r8, [fp, #-88]
	ldr	r5, [fp, #-92]
	b	.L191
.L234:
	mov	r3, #4
	str	r3, [fp, #-108]
	str	r3, [fp, #-96]
	b	.L117
.L238:
	ldr	r9, [fp, #-96]
	b	.L151
.L313:
	ldr	r6, [fp, #-116]
	ldr	r5, [fp, #-120]
.L144:
	ldr	r3, [fp, #-80]
	mov	r9, #0
	cmp	r3, #4
	addls	r4, r6, #8192
	bls	.L150
	ldr	r3, [fp, #-92]
	add	r4, r6, #8192
	add	lr, r3, #3
	ldr	r3, [fp, #-80]
	sub	r3, r3, #1
	str	r3, [fp, #-96]
	mov	r3, #3
	b	.L160
.L156:
	ldr	r1, [r4, #436]
	ldrb	r2, [r1, r3]
	sub	r0, r2, #1
	sxtb	r2, r2
	cmp	r2, #0
	ble	.L159
.L297:
	strb	r0, [r1, r3]
.L158:
	ldr	r2, [fp, #-96]
	add	r3, r3, #1
	cmp	r3, r2
	beq	.L150
.L160:
	ldrb	r2, [lr, #1]!
	cmp	r2, #1
	bne	.L156
	strb	r2, [lr, #-1]
	mov	r1, #0
	strb	r1, [lr]
	add	r9, r9, #1
	ldr	r1, [r4, #436]
	ldrb	r0, [r4, #452]
	ldrb	r2, [r1, r3]
	add	ip, r2, #1
	sxtb	r2, r2
	cmp	r2, r0
	movlt	r2, ip
	strltb	r2, [r1, r3]
	blt	.L158
	b	.L297
.L150:
	str	r9, [r4, #456]
.L129:
	add	r3, r6, #8640
	ldr	r2, [fp, #-92]
	add	r3, r3, #8
	ldr	r1, [fp, #-112]
	ldr	r0, [fp, #-80]
	bl	CheckStartEndBorder
	ldrsb	r3, [r6]
	cmp	r3, #8
	beq	.L161
	ldrb	r3, [r4, #448]
	ldrb	r2, [r4, #451]
	cmp	r3, r2
	addcc	r3, r3, #1
	uxtbcc	r3, r3
	strccb	r3, [r4, #448]
	cmp	r2, r3
	beq	.L322
.L161:
	ldr	r3, .L325+16
	ldr	r2, [fp, #-80]
	ldr	r0, [r10, #16]
	ldr	r1, [r3, #16]
	bl	memcpy
.L169:
	ldr	r3, [r7]
	str	r3, [r6, #4]
	b	.L170
.L159:
	mov	r2, #0
	strb	r2, [r1, r3]
	b	.L158
.L322:
	ldr	r3, [fp, #-80]
	cmp	r3, #4
	ble	.L240
	add	r3, r3, #1
	mov	r9, #0
	str	r3, [fp, #-80]
	mov	r3, #5
	str	r8, [fp, #-92]
	str	r5, [fp, #-96]
	b	.L168
.L165:
	ldr	r2, [fp, #-80]
	add	r3, r3, #1
	cmp	r3, r2
	beq	.L323
.L168:
	ldr	r0, [r10, #16]
	sub	r2, r3, #1
	ldrb	r5, [r0, r2]
	cmp	r5, #1
	bne	.L165
	ldr	r1, [r4, #436]
	sub	r8, r3, #2
	ldrb	lr, [r4, #451]
	add	r9, r9, #1
	ldrsb	ip, [r1, r2]
	cmp	ip, lr
	bge	.L165
	ldrsb	ip, [r1, r8]
	ldrsb	r1, [r1, r3]
	cmp	lr, ip
	bgt	.L167
	cmp	ip, r1
	blt	.L167
	strb	r5, [r0, r8]
	mov	r0, #0
	ldr	r1, [r10, #16]
	strb	r0, [r1, r2]
	b	.L165
.L240:
	mov	r9, #0
.L164:
	str	r9, [r4, #456]
	b	.L169
.L323:
	ldr	r8, [fp, #-92]
	ldr	r5, [fp, #-96]
	b	.L164
.L188:
	ldr	r2, [fp, #-88]
	ldr	r1, [r3, #20]
	ldr	r0, [r10, #24]
	bl	memcpy
	b	.L196
.L318:
	mov	r5, r3
	mov	r1, r3
	bl	__memzero
	mov	r2, #0
	mvn	r3, #0
	str	r2, [r6, #8]
	strb	r3, [r6, #2]
	mov	r1, r5
	ldr	r0, [r4, #444]
	bl	__memzero
	b	.L231
.L320:
	add	r4, r6, #8192
	mov	r9, r3
	mov	r1, r3
	bl	__memzero
	mov	r2, #0
	mvn	r3, #0
	str	r2, [r6, #4]
	strb	r3, [r6]
	mov	r1, r9
	ldr	r0, [r4, #436]
	bl	__memzero
	b	.L229
.L194:
	cmp	lr, r1
	cmple	ip, r1
	movlt	r1, #1
	strltb	r1, [r0, r3]
	ldrlt	r1, [r10, #24]
	movlt	r0, #0
	strltb	r0, [r1, r2]
	b	.L192
.L116:
	ldr	r2, [fp, #-80]
	sub	ip, r2, #3
	cmp	ip, #4
	bls	.L119
	ldr	r3, [fp, #-92]
	add	r0, r3, #3
	mov	r3, #4
.L121:
	ldrb	r2, [r0, #1]!
	cmp	r2, #1
	bne	.L120
	and	r2, r3, #7
	sub	r1, fp, #44
	add	r2, r1, r2, lsl #2
	ldr	r1, [r2, #-32]
	add	r1, r1, #1
	str	r1, [r2, #-32]
.L120:
	add	r3, r3, #1
	cmp	r3, ip
	bne	.L121
	ldr	r3, [fp, #-76]
.L119:
	mov	r4, #0
	sub	r1, fp, #76
	mov	r0, r4
	mov	r2, r4
	b	.L227
.L123:
	ldr	r3, [r1, #4]!
.L227:
	cmp	r0, r3
	movcc	r4, r2
	add	r2, r2, #1
	movcc	r0, r3
	cmp	r2, #8
	bne	.L123
	ldr	r3, [fp, #-80]
	cmp	r3, #0
	bne	.L324
	cmp	r4, #0
	ldreq	r3, [fp, #-80]
	bne	.L228
.L127:
	add	r4, r6, #8192
	str	r3, [r4, #456]
	b	.L129
.L296:
	str	r9, [fp, #-104]
	b	.L138
.L326:
	.align	2
.L325:
	.word	.LANCHOR0
	.word	.LANCHOR0+16384
	.word	.LANCHOR0+4
	.word	.LANCHOR0+16399
	.word	.LANCHOR0+20480
	.word	.LANCHOR0+16388
	.word	.LANCHOR0+16392
.L319:
	mov	r9, r3
	mov	r1, r3
	bl	__memzero
	mov	r2, #0
	mvn	r3, #0
	str	r2, [r6, #12]
	strb	r3, [r6, #1]
	mov	r1, r9
	ldr	r0, [r4, #440]
	bl	__memzero
	b	.L230
.L167:
	cmp	lr, r1
	cmple	ip, r1
	movlt	r1, #1
	strltb	r1, [r0, r3]
	ldrlt	r1, [r10, #16]
	movlt	r0, #0
	strltb	r0, [r1, r2]
	b	.L165
.L324:
	mov	r1, r3
	ldr	r0, [fp, #-92]
	bl	__memzero
	cmp	r4, #0
	moveq	r3, r4
	beq	.L125
.L228:
	ldr	r3, [fp, #-92]
	mov	r1, #1
	add	r2, r3, r4
	mov	r3, r1
	strb	r1, [r2, #-1]
.L125:
	ldr	r2, [fp, #-80]
	add	r4, r4, #7
	cmp	r2, r4
	bls	.L127
	mov	r2, #1
.L128:
	ldr	r1, [fp, #-92]
	add	r3, r3, #1
	strb	r2, [r1, r4]
	add	r4, r4, #8
	ldr	r1, [fp, #-80]
	cmp	r1, r4
	bhi	.L128
	b	.L127
	.fnend
	.size	PQ_MNG_ALG_GetDbDetInfo, .-PQ_MNG_ALG_GetDbDetInfo
	.align	2
	.global	PQ_MNG_ALG_VDHTransinfoUpdata
	.type	PQ_MNG_ALG_VDHTransinfoUpdata, %function
PQ_MNG_ALG_VDHTransinfoUpdata:
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
	ldr	r3, [r1, #60]
	str	r3, [r0, #604]
	ldr	r3, [r1, #56]
	cmp	r3, #0
	cmpne	r3, #3
	str	r3, [r0, #608]
	ldr	r3, [r1, #68]
	moveq	r2, #1
	movne	r2, #0
	str	r3, [r0, #612]
	ldr	r3, [r1, #8]
	add	r3, r3, #7
	mov	r3, r3, lsr #3
	strb	r3, [r0, #650]
	ldr	r3, [r1, #12]
	add	r3, r3, #7
	mov	r3, r3, lsr #3
	strb	r3, [r0, #651]
	beq	.L330
	ldr	r3, [r1, #72]
	cmp	r3, #0
	beq	.L330
	ldr	r3, [r1, #48]
	cmp	r3, #1
	beq	.L331
	ldr	r3, [r1, #52]
	cmp	r3, #1
	ldreq	r3, [r1, #64]
	ldreq	r2, [r1, #68]
	ldreq	ip, [r1, #76]
	ldrne	r3, [r1, #64]
	mlaeq	r3, ip, r2, r3
	str	r3, [r0, #620]
	mov	r3, #1
	str	r3, [r0, #616]
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L330:
	mov	r3, #0
	str	r3, [r0, #616]
	ldr	r3, [r1, #64]
	str	r3, [r0, #620]
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L331:
	ldr	ip, [r1, #52]
	cmp	ip, #1
	streq	r2, [r0, #616]
	strne	r3, [r0, #616]
	ldr	r2, [r1, #68]
	ldr	ip, [r1, #76]
	ldr	r3, [r1, #64]
	mla	r3, ip, r2, r3
	str	r3, [r0, #620]
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	PQ_MNG_ALG_VDHTransinfoUpdata, .-PQ_MNG_ALG_VDHTransinfoUpdata
	.global	__aeabi_idiv
	.align	2
	.global	PQ_MNG_ALG_DBCfgDetector
	.type	PQ_MNG_ALG_DBCfgDetector, %function
PQ_MNG_ALG_DBCfgDetector:
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
	ldr	r7, [r1]
	ldmib	r1, {r6, r8}
	mov	r4, r0
	mov	r5, r2
	str	r7, [r0, #668]
	ldr	r3, [r1, #4]
	str	r3, [r0, #672]
	ldr	r3, [r1, #48]
	cmp	r3, #8
	movne	r3, #90
	strneh	r3, [r0, #24]
	beq	.L365
.L341:
	ldr	r3, [r1, #64]
	cmp	r3, #8
	movne	r3, #60
	strneh	r3, [r4, #26]
	beq	.L366
.L343:
	ldr	r1, [r1, #56]
	add	r3, r1, #1
	cmp	r3, #1
	bls	.L344
	mov	r0, r6
	bl	__aeabi_idiv
	cmp	r6, #0
	add	r2, r6, #7
	add	r3, r6, #63
	movge	r2, r6
	mov	r2, r2, asr #3
	uxth	r0, r0
	cmp	r0, r2
	movge	r0, r2
	cmp	r6, #0
	movge	r3, r6
	mov	r3, r3, asr #6
	cmp	r0, r3
	movlt	r0, r3
	strh	r0, [r4, #28]
.L344:
	movw	r3, #1080
	cmp	r7, #1920
	cmple	r6, r3
	mov	r2, #0
	mov	r3, #1
	strh	r3, [r4, #22]
	strh	r3, [r4, #16]
	strh	r3, [r4, #18]
	movle	r3, #6
	movgt	r3, #8
	strgth	r2, [r4, #22]
	cmp	r7, #720
	strh	r3, [r4, #30]
	strh	r2, [r4, #20]
	movle	r3, #16
	strleh	r3, [r4, #32]
	ble	.L348
	cmp	r7, #1920
	movle	r3, #42
	movgt	r3, #63
	strh	r3, [r4, #32]
.L348:
	cmp	r6, #576
	movle	r3, #16
	strleh	r3, [r4, #36]
	ble	.L351
	movw	r3, #1080
	cmp	r6, r3
	movle	r3, #36
	movgt	r3, #63
	strh	r3, [r4, #36]
.L351:
	cmp	r8, #360
	movle	r3, #16
	strleh	r3, [r4, #34]
	ble	.L354
	cmp	r8, #960
	movle	r3, #42
	movgt	r3, #63
	strh	r3, [r4, #34]
.L354:
	mov	r1, #512
	add	r0, r4, #40
	bl	__memzero
	add	r5, r5, #16
	add	ip, r4, #36
	mov	lr, #0
.L356:
	mov	r0, r5
	ldr	r2, [ip, #4]!
	ldrb	r1, [r0, lr]!
	mov	r3, #1
	and	r1, r1, r3
	orr	r1, r1, r2
	str	r1, [ip]
	b	.L358
.L368:
	ldrb	r2, [r0, #1]!
	and	r2, r2, #1
	orr	r1, r1, r2, asl r3
	add	r3, r3, #1
	cmp	r3, #32
	str	r1, [ip]
	beq	.L367
.L358:
	add	r2, r3, lr
	cmp	r2, #4096
	bcc	.L368
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L367:
	add	lr, lr, #32
	cmp	lr, #4096
	bne	.L356
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L365:
	cmp	r7, #0
	add	r3, r7, #7
	movge	r3, r7
	mov	r3, r3, asr #3
	strh	r3, [r0, #24]
	b	.L341
.L366:
	cmp	r8, #0
	add	r3, r8, #7
	movge	r3, r8
	mov	r3, r3, asr #3
	strh	r3, [r4, #26]
	b	.L343
	.fnend
	.size	PQ_MNG_ALG_DBCfgDetector, .-PQ_MNG_ALG_DBCfgDetector
	.bss
	.align	2
.LANCHOR0 = . + 0
	.type	stDetStaticInfo, %object
	.size	stDetStaticInfo, 20508
stDetStaticInfo:
	.space	20508
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
