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
	.file	"pq_mng_dm_alg.c"

	.global	__aeabi_idiv
	.text
	.align	2
	.type	DM_GetDetRate, %function
DM_GetDetRate:
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
	subs	lr, r0, #0
	beq	.L8
	ldr	r1, [lr, #140]
	ldr	r3, [lr, #152]
	cmp	r1, #0
	beq	.L3
	movle	r0, #0
	ble	.L5
	mov	r2, #0
	add	r4, lr, #12
	mov	r0, r2
.L7:
	ldr	ip, [r3], #-4
	add	r2, r2, #1
	cmp	r3, r4
	add	r0, r0, ip
	addcc	r3, lr, #136
	cmp	r2, r1
	bne	.L7
.L5:
	bl	__aeabi_idiv
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L3:
	ldr	r0, [r3]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L8:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	DM_GetDetRate, .-DM_GetDetRate
	.global	__aeabi_uidiv
	.align	2
	.global	PQ_MNG_ALG_UpdateDMCfg
	.type	PQ_MNG_ALG_UpdateDMCfg, %function
PQ_MNG_ALG_UpdateDMCfg:
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
	subs	r9, r2, #0
	mov	r7, r0
	mov	r4, r1
	beq	.L85
	ldr	r3, [r9, #8]
	mov	r2, #6
	ldr	r5, [r9, #56]
	cmp	r3, #720
	str	r2, [r0, #140]
	mov	r3, #1
	str	r3, [r0, #156]
	ldrls	r6, .L167
	ldrhi	r8, .L167+4
	addls	ip, r6, #408
	addhi	ip, r8, #408
	subhi	r6, r8, #480
	movls	r8, r6
	cmp	r5, #2
	beq	.L154
	cmp	r5, #0
	bne	.L18
	ldr	r10, .L167+8
	ldrb	r3, [r10]
	cmp	r3, #1
	beq	.L16
.L17:
	mov	r3, #1
	str	r3, [r4, #4]
	ldr	r3, [r7, #156]
	cmp	r3, #0
	bne	.L84
.L83:
	ldr	r3, [r9, #8]
	cmp	r3, #720
	bls	.L155
.L63:
	cmp	r3, #2160
	ldr	r2, .L167+12
	bhi	.L64
	ldrb	r3, [r6, #1065]
	ldrh	r0, [r2, #2]
.L62:
	sxth	r3, r3
	mov	r2, #0
	str	r2, [r4, #8]
	mov	r2, r3, asl #6
	add	r3, r2, r3, lsl #2
	b	.L26
.L18:
	cmp	r5, #1
	beq	.L156
	cmp	r5, #3
	beq	.L157
	cmp	r5, #4
	beq	.L158
	str	r3, [r1, #4]
	ldr	r3, [r0, #156]
	cmp	r3, #0
	beq	.L83
.L33:
	cmp	r5, #3
	bhi	.L28
	cmp	r5, #4
	bhi	.L28
.L39:
	cmp	r5, #4
	beq	.L74
	ldr	r1, [r9, #60]
	cmp	r1, #0
	beq	.L42
	cmp	r1, #51
	movcs	r1, #51
	uxth	r1, r1
.L42:
	cmp	r7, #0
	beq	.L78
	ldr	r10, .L167+8
.L77:
	ldr	r3, [r10, #8]
	mov	r0, r7
	str	ip, [fp, #-48]
	cmp	r3, #31
	addls	r2, r3, #1
	movhi	r3, #0
	add	r3, r3, #2
	movhi	r2, #1
	str	r2, [r10, #8]
	add	r3, r7, r3, lsl #2
	str	r1, [r3, #4]!
	str	r3, [r7, #152]
	bl	DM_GetDetRate
	cmp	r5, #2
	ldr	ip, [fp, #-48]
	uxth	r0, r0
	beq	.L79
	cmp	r5, #3
	beq	.L75
.L46:
	cmp	r5, #0
	bne	.L48
	ldrh	r2, [ip, #28]
	add	r3, ip, #28
	ldr	r1, .L167+16
	add	lr, ip, #36
.L49:
	cmp	r2, r0
	ldrhib	r3, [lr]
	bhi	.L54
	ldrh	r2, [r3, #2]
	cmp	r2, r0
	ldrhib	r3, [lr, #1]
	bhi	.L54
	ldrh	r2, [r3, #4]
	cmp	r2, r0
	ldrhib	r3, [lr, #2]
	bhi	.L54
	ldrh	r3, [r3, #6]
	cmp	r3, r0
	ldrhib	r3, [lr, #3]
	ldrlsb	r3, [lr, #4]
.L54:
	cmp	r5, #4
	beq	.L60
	cmp	r0, #59
	movls	r0, r0, lsr #2
	movhi	r0, #15
.L60:
	ldr	r2, [r7, #156]
	ldrb	r0, [r1, r0]
	cmp	r2, #0
	bne	.L62
	b	.L83
.L84:
	cmp	r5, #0
	bne	.L29
	ldrb	r3, [r6, #1056]
	cmp	r3, #1
	beq	.L27
.L30:
	ldr	r3, [r7, #156]
	cmp	r3, #0
	beq	.L28
	cmp	r5, #2
	beq	.L159
	cmp	r5, #3
	bne	.L39
	ldr	r1, [r9, #60]
	cmp	r1, #0
	beq	.L40
	cmp	r1, #255
	movcs	r1, #255
	uxth	r1, r1
.L40:
	cmp	r7, #0
	bne	.L77
	mov	r0, r7
	str	ip, [fp, #-48]
	bl	DM_GetDetRate
	ldr	ip, [fp, #-48]
	uxth	r0, r0
.L75:
	movs	r0, r0, lsr #2
	beq	.L82
	cmp	r0, #63
	movcs	r0, #63
	uxth	r0, r0
.L82:
	add	r3, ip, #42
	add	lr, ip, #50
	ldrh	r2, [ip, #42]
	ldr	r1, .L167+20
	b	.L49
.L29:
	cmp	r5, #1
	beq	.L160
	cmp	r5, #2
	beq	.L161
	cmp	r5, #3
	bne	.L33
	ldrb	r3, [r6, #1059]
	cmp	r3, #1
	bne	.L30
.L27:
	ldr	r3, [r7, #156]
	cmp	r3, #0
	beq	.L28
	mov	r5, #4
.L74:
	ldr	r1, [r9, #8]
	cmp	r1, #0
	beq	.L42
	ldr	r3, [r7, #148]
	ldr	r0, [r7, #144]
	str	ip, [fp, #-48]
	mul	r0, r3, r0
	mov	r0, r0, asl #4
	bl	__aeabi_uidiv
	ldr	ip, [fp, #-48]
	cmp	r0, #0
	moveq	r1, r0
	beq	.L42
	cmp	r0, #15
	movcc	r1, r0
	movcs	r1, #15
	uxth	r1, r1
	b	.L42
.L156:
	ldr	r10, .L167+8
	ldrb	r3, [r10, #1]
	cmp	r3, #1
	bne	.L17
.L16:
	mov	r2, #0
	mov	r3, #1
	str	r2, [r4, #4]
	str	r3, [r7, #156]
	ldr	r1, [r9, #8]
	cmp	r1, r2
	bne	.L162
.L23:
	add	r1, r6, r1
	cmp	r7, #0
	ldrb	r2, [r1, #1040]
	beq	.L24
	ldr	r3, [r10, #8]
	cmp	r3, #31
	addls	r1, r3, #1
	movhi	r3, #0
	add	r3, r3, #2
	movhi	r1, #1
	str	r1, [r10, #8]
	add	r3, r7, r3, lsl #2
	str	r2, [r3, #4]!
	str	r3, [r7, #152]
.L24:
	mov	r0, r7
	bl	DM_GetDetRate
	mov	r3, #340
	uxth	r0, r0
	cmp	r0, #3
	movhi	r2, #0
	movls	r2, #1
	str	r2, [r4, #8]
.L26:
	ldrh	r2, [r8, r3]
	add	r3, r8, r3
	str	r2, [r4, #12]
	ldrh	r2, [r3, #2]
	str	r2, [r4, #16]
	ldrh	r2, [r3, #4]
	str	r2, [r4, #20]
	ldrh	r2, [r3, #6]
	str	r2, [r4, #24]
	ldrb	r2, [r3, #8]
	str	r2, [r4, #28]
	ldrb	r2, [r3, #9]
	str	r2, [r4, #32]
	ldrsh	r5, [r3, #10]
	str	r5, [r4, #36]
	ldrsh	ip, [r3, #12]
	str	ip, [r4, #40]
	ldrsh	lr, [r3, #14]
	str	lr, [r4, #44]
	ldrsh	r1, [r3, #16]
	str	r1, [r4, #48]
	ldrb	r2, [r3, #18]
	cmp	r2, #1
	str	r2, [r4, #52]
	beq	.L163
.L66:
	ldrh	r1, [r3, #20]
	cmp	r2, #1
	str	r1, [r4, #56]
	ldrh	r2, [r3, #22]
	str	r2, [r4, #60]
	ldrh	lr, [r3, #24]
	str	lr, [r4, #64]
	ldrh	r1, [r3, #26]
	str	r1, [r4, #68]
	ldrh	ip, [r3, #28]
	str	ip, [r4, #72]
	ldrh	r2, [r3, #30]
	str	r2, [r4, #76]
	beq	.L164
.L67:
	ldrh	r2, [r3, #32]
	str	r2, [r4, #80]
	ldrh	r2, [r3, #34]
	str	r2, [r4, #84]
	ldrb	r2, [r3, #36]
	str	r2, [r4, #88]
	ldrb	r2, [r3, #37]
	str	r2, [r4, #92]
	ldrb	r2, [r3, #38]
	str	r2, [r4, #96]
	ldrh	r2, [r3, #40]
	str	r2, [r4, #100]
	ldrh	r2, [r3, #42]
	str	r2, [r4, #104]
	ldrh	r2, [r3, #44]
	str	r2, [r4, #108]
	ldrh	r2, [r3, #46]
	str	r2, [r4, #112]
	ldrb	r2, [r3, #48]
	str	r2, [r4, #116]
	ldrsh	r5, [r3, #50]
	str	r5, [r4, #120]
	ldrsh	ip, [r3, #52]
	str	ip, [r4, #124]
	ldrsh	lr, [r3, #54]
	str	lr, [r4, #128]
	ldrsh	r1, [r3, #56]
	str	r1, [r4, #132]
	ldrb	r2, [r3, #58]
	cmp	r2, #1
	beq	.L165
.L150:
	str	r2, [r4, #136]
	rsb	r1, r0, #8
	ldrh	lr, [r3, #60]
	mov	r7, r0, asl #2
	mov	r2, r1, asl #6
	mov	ip, r0, lsr #1
	sub	r2, r2, r1, asl #2
	add	r0, r7, r0
	str	lr, [r4, #140]
	adds	r5, r2, #4
	ldrh	r8, [r3, #62]
	add	r0, r1, r0
	addmi	r5, r2, #11
	rsb	lr, ip, #4
	adds	r1, r7, #4
	str	r8, [r4, #144]
	addmi	r1, r7, #11
	ldrh	r8, [r3, #64]
	adds	r2, r0, #4
	addmi	r2, r0, #11
	uxtb	lr, lr
	ubfx	r0, r5, #3, #8
	cmp	lr, #3
	str	r8, [r4, #148]
	mov	r7, #1
	ldrh	r5, [r3, #66]
	ubfx	r1, r1, #3, #8
	ubfx	r3, r2, #3, #8
	str	r0, [r4, #172]
	str	r1, [r4, #176]
	mov	r2, r7, asl ip
	mov	r1, #2
	mov	r0, #24
	str	r3, [r4, #180]
	mov	r3, #4
	str	r5, [r4, #152]
	str	r2, [r4, #184]
	str	r0, [r4, #156]
	str	r1, [r4, #160]
	str	r1, [r4, #164]
	str	r3, [r4, #168]
	bhi	.L71
	cmp	lr, r1
	movge	r3, lr
	movlt	r3, r1
.L71:
	ldr	r2, [r6, #1076]
	mov	r0, #0
	str	r3, [r4, #188]
	str	r2, [r4, #192]
.L149:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L154:
	ldr	r10, .L167+8
	ldrb	r3, [r10, #2]
	cmp	r3, #1
	bne	.L17
	b	.L16
.L157:
	ldr	r10, .L167+8
	ldrb	r3, [r10, #3]
	cmp	r3, #1
	bne	.L17
	b	.L16
.L162:
	ldr	r3, [r7, #148]
	ldr	r0, [r7, #144]
	mul	r0, r3, r0
	mov	r0, r0, asl #4
	bl	__aeabi_uidiv
	cmp	r0, #0
	moveq	r1, r0
	beq	.L23
	cmp	r0, #15
	movcc	r1, r0
	movcs	r1, #15
	uxth	r1, r1
	b	.L23
.L158:
	ldr	r10, .L167+8
	ldrb	r2, [r10, #4]
	cmp	r2, #1
	beq	.L16
	str	r3, [r1, #4]
	ldr	r3, [r0, #156]
	cmp	r3, #0
	beq	.L83
	ldrb	r3, [r6, #1060]
	cmp	r3, #1
	beq	.L27
.L28:
	mov	r3, #0
	str	r3, [r7, #156]
	ldr	r3, [r9, #8]
	cmp	r3, #720
	bhi	.L63
.L155:
	movw	r2, #1068
	ldrb	r3, [r6, #1064]
	ldrh	r0, [r6, r2]
	b	.L62
.L160:
	ldrb	r3, [r6, #1057]
	cmp	r3, #1
	bne	.L30
	b	.L27
.L161:
	ldrb	r3, [r6, #1058]
	cmp	r3, #1
	bne	.L30
	b	.L27
.L165:
	cmp	ip, r1
	cmpgt	r5, lr
	movle	r2, #0
	b	.L150
.L163:
	cmp	ip, r1
	cmpgt	r5, lr
	movle	r2, #0
	strle	r2, [r4, #52]
	b	.L66
.L164:
	cmp	r1, r2
	cmpls	lr, ip
	movhi	r2, #0
	strhi	r2, [r4, #52]
	b	.L67
.L64:
	cmp	r3, #3840
	ldrlsb	r3, [r6, #1066]
	ldrlsh	r0, [r2, #4]
	ldrhib	r3, [r6, #1067]
	ldrhih	r0, [r2, #6]
	b	.L62
.L48:
	cmp	r5, #1
	beq	.L166
	cmp	r5, #2
	beq	.L81
	cmp	r5, #3
	beq	.L82
	ldrh	r2, [ip, #56]
	add	r3, ip, #56
	ldr	r1, .L167+24
	add	lr, ip, #64
	b	.L49
.L159:
	ldr	r1, [r9, #60]
	cmp	r1, #0
	beq	.L38
	cmp	r1, #112
	movcs	r1, #112
	uxth	r1, r1
.L38:
	cmp	r7, #0
	bne	.L77
	mov	r0, r7
	str	ip, [fp, #-48]
	bl	DM_GetDetRate
	ldr	ip, [fp, #-48]
	uxth	r0, r0
.L79:
	movs	r0, r0, lsr #1
	beq	.L81
	cmp	r0, #56
	movcs	r0, #56
	uxth	r0, r0
.L81:
	mov	r3, ip
	ldr	r1, .L167+28
	add	lr, ip, #8
	ldrh	r2, [ip]
	b	.L49
.L166:
	add	r3, ip, #14
	add	lr, ip, #22
	ldrh	r2, [ip, #14]
	ldr	r1, .L167+32
	b	.L49
.L85:
	mvn	r0, #0
	b	.L149
.L78:
	mov	r0, r7
	str	ip, [fp, #-48]
	bl	DM_GetDetRate
	ldr	ip, [fp, #-48]
	uxth	r0, r0
	b	.L46
.L168:
	.align	2
.L167:
	.word	.LANCHOR0
	.word	.LANCHOR0+480
	.word	.LANCHOR1
	.word	.LANCHOR0+1068
	.word	.LANCHOR0+992
	.word	.LANCHOR0+1008
	.word	.LANCHOR0+1024
	.word	.LANCHOR0+960
	.word	.LANCHOR0+976
	.fnend
	.size	PQ_MNG_ALG_UpdateDMCfg, .-PQ_MNG_ALG_UpdateDMCfg
	.global	g_MV410En
	.global	g_QPmndetEn
	.global	g_DefaultStrIdx
	.global	g_DefaultImgQPFlag
	.global	DMRatIdxLut
	.global	DMParaHD4k
	.global	DMParaSD
	.global	QPLimitFlagLutHD4k
	.global	QPLimitFlagLutSD
	.global	g_u32DmStr
	.data
	.align	2
.LANCHOR0 = . + 0
	.type	DMParaSD, %object
	.size	DMParaSD, 408
DMParaSD:
	.short	15
	.short	9
	.short	35
	.short	140
	.byte	4
	.byte	5
	.short	20
	.short	80
	.short	1
	.short	4
	.byte	1
	.space	1
	.short	2
	.short	8
	.short	3
	.short	12
	.short	6
	.short	24
	.short	10
	.short	40
	.byte	6
	.byte	6
	.byte	6
	.space	1
	.short	2
	.short	8
	.short	0
	.short	0
	.byte	9
	.space	1
	.short	20
	.short	80
	.short	0
	.short	0
	.byte	0
	.space	1
	.short	30
	.short	120
	.short	0
	.short	0
	.short	20
	.short	18
	.short	40
	.short	160
	.byte	4
	.byte	5
	.short	25
	.short	100
	.short	0
	.short	0
	.byte	1
	.space	1
	.short	3
	.short	12
	.short	2
	.short	8
	.short	5
	.short	20
	.short	18
	.short	72
	.byte	7
	.byte	8
	.byte	7
	.space	1
	.short	2
	.short	8
	.short	0
	.short	0
	.byte	9
	.space	1
	.short	20
	.short	80
	.short	0
	.short	0
	.byte	0
	.space	1
	.short	30
	.short	120
	.short	0
	.short	0
	.short	20
	.short	18
	.short	45
	.short	180
	.byte	4
	.byte	5
	.short	25
	.short	100
	.short	-1
	.short	-4
	.byte	1
	.space	1
	.short	3
	.short	12
	.short	2
	.short	8
	.short	5
	.short	20
	.short	20
	.short	80
	.byte	7
	.byte	8
	.byte	7
	.space	1
	.short	2
	.short	8
	.short	0
	.short	0
	.byte	9
	.space	1
	.short	20
	.short	80
	.short	0
	.short	0
	.byte	0
	.space	1
	.short	30
	.short	120
	.short	0
	.short	0
	.short	25
	.short	18
	.short	50
	.short	200
	.byte	4
	.byte	4
	.short	30
	.short	120
	.short	-2
	.short	-8
	.byte	1
	.space	1
	.short	3
	.short	12
	.short	2
	.short	8
	.short	5
	.short	20
	.short	25
	.short	100
	.byte	8
	.byte	8
	.byte	8
	.space	1
	.short	2
	.short	8
	.short	0
	.short	0
	.byte	9
	.space	1
	.short	20
	.short	80
	.short	0
	.short	0
	.byte	0
	.space	1
	.short	30
	.short	120
	.short	0
	.short	0
	.short	25
	.short	18
	.short	50
	.short	200
	.byte	4
	.byte	4
	.short	30
	.short	120
	.short	-3
	.short	-12
	.byte	1
	.space	1
	.short	3
	.short	12
	.short	2
	.short	8
	.short	5
	.short	20
	.short	25
	.short	100
	.byte	8
	.byte	8
	.byte	8
	.space	1
	.short	2
	.short	8
	.short	0
	.short	0
	.byte	9
	.space	1
	.short	20
	.short	80
	.short	0
	.short	0
	.byte	0
	.space	1
	.short	30
	.short	120
	.short	0
	.short	0
	.short	18
	.short	25
	.short	45
	.short	180
	.byte	4
	.byte	4
	.short	25
	.short	100
	.short	0
	.short	0
	.byte	0
	.space	1
	.short	2
	.short	8
	.short	3
	.short	12
	.short	6
	.short	24
	.short	8
	.short	32
	.byte	8
	.byte	8
	.byte	6
	.space	1
	.short	2
	.short	8
	.short	0
	.short	0
	.byte	9
	.space	1
	.short	20
	.short	80
	.short	0
	.short	0
	.byte	0
	.space	1
	.short	30
	.short	120
	.short	0
	.short	0
	.type	QPLimitFlagLutSD, %object
	.size	QPLimitFlagLutSD, 70
QPLimitFlagLutSD:
	.short	5
	.short	15
	.short	50
	.short	55
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	2
	.space	1
	.short	5
	.short	15
	.short	45
	.short	50
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	2
	.space	1
	.short	5
	.short	15
	.short	45
	.short	50
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	2
	.space	1
	.short	5
	.short	15
	.short	55
	.short	60
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	2
	.space	1
	.short	2
	.short	6
	.short	10
	.short	14
	.byte	1
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.space	1
	.space	2
	.type	DMParaHD4k, %object
	.size	DMParaHD4k, 408
DMParaHD4k:
	.short	15
	.short	9
	.short	35
	.short	140
	.byte	4
	.byte	4
	.short	20
	.short	80
	.short	1
	.short	4
	.byte	1
	.space	1
	.short	2
	.short	8
	.short	3
	.short	12
	.short	6
	.short	24
	.short	10
	.short	40
	.byte	8
	.byte	8
	.byte	6
	.space	1
	.short	2
	.short	8
	.short	0
	.short	0
	.byte	9
	.space	1
	.short	20
	.short	80
	.short	0
	.short	0
	.byte	0
	.space	1
	.short	30
	.short	120
	.short	0
	.short	0
	.short	20
	.short	18
	.short	40
	.short	160
	.byte	4
	.byte	4
	.short	25
	.short	100
	.short	0
	.short	0
	.byte	1
	.space	1
	.short	3
	.short	12
	.short	2
	.short	8
	.short	5
	.short	20
	.short	18
	.short	72
	.byte	8
	.byte	8
	.byte	7
	.space	1
	.short	2
	.short	8
	.short	0
	.short	0
	.byte	9
	.space	1
	.short	20
	.short	80
	.short	0
	.short	0
	.byte	0
	.space	1
	.short	30
	.short	120
	.short	0
	.short	0
	.short	20
	.short	18
	.short	45
	.short	180
	.byte	4
	.byte	4
	.short	25
	.short	100
	.short	-1
	.short	-4
	.byte	1
	.space	1
	.short	3
	.short	12
	.short	2
	.short	8
	.short	5
	.short	20
	.short	20
	.short	80
	.byte	8
	.byte	8
	.byte	7
	.space	1
	.short	2
	.short	8
	.short	0
	.short	0
	.byte	9
	.space	1
	.short	20
	.short	80
	.short	0
	.short	0
	.byte	0
	.space	1
	.short	30
	.short	120
	.short	0
	.short	0
	.short	25
	.short	18
	.short	50
	.short	200
	.byte	3
	.byte	3
	.short	30
	.short	120
	.short	-2
	.short	-8
	.byte	1
	.space	1
	.short	3
	.short	12
	.short	2
	.short	8
	.short	5
	.short	20
	.short	25
	.short	100
	.byte	8
	.byte	8
	.byte	8
	.space	1
	.short	2
	.short	8
	.short	0
	.short	0
	.byte	9
	.space	1
	.short	20
	.short	80
	.short	0
	.short	0
	.byte	0
	.space	1
	.short	30
	.short	120
	.short	0
	.short	0
	.short	25
	.short	18
	.short	50
	.short	200
	.byte	3
	.byte	3
	.short	30
	.short	120
	.short	-3
	.short	-12
	.byte	1
	.space	1
	.short	3
	.short	12
	.short	2
	.short	8
	.short	5
	.short	20
	.short	25
	.short	100
	.byte	8
	.byte	8
	.byte	8
	.space	1
	.short	2
	.short	8
	.short	0
	.short	0
	.byte	9
	.space	1
	.short	20
	.short	80
	.short	0
	.short	0
	.byte	0
	.space	1
	.short	30
	.short	120
	.short	0
	.short	0
	.short	18
	.short	25
	.short	45
	.short	180
	.byte	4
	.byte	4
	.short	25
	.short	100
	.short	0
	.short	0
	.byte	0
	.space	1
	.short	2
	.short	8
	.short	3
	.short	12
	.short	6
	.short	24
	.short	8
	.short	32
	.byte	8
	.byte	8
	.byte	6
	.space	1
	.short	2
	.short	8
	.short	0
	.short	0
	.byte	9
	.space	1
	.short	20
	.short	80
	.short	0
	.short	0
	.byte	0
	.space	1
	.short	30
	.short	120
	.short	0
	.short	0
	.type	QPLimitFlagLutHD4k, %object
	.size	QPLimitFlagLutHD4k, 70
QPLimitFlagLutHD4k:
	.short	5
	.short	15
	.short	38
	.short	55
	.byte	1
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.space	1
	.short	5
	.short	15
	.short	38
	.short	50
	.byte	1
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.space	1
	.short	5
	.short	15
	.short	38
	.short	50
	.byte	1
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.space	1
	.short	5
	.short	15
	.short	38
	.short	60
	.byte	1
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.space	1
	.short	1
	.short	6
	.short	10
	.short	14
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.space	1
	.space	2
	.type	DMRatIdxLut, %object
	.size	DMRatIdxLut, 96
DMRatIdxLut:
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	6
	.byte	6
	.byte	6
	.byte	7
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	6
	.byte	6
	.byte	6
	.byte	7
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	6
	.byte	6
	.byte	6
	.byte	7
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	7
	.byte	7
	.byte	8
	.byte	8
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	5
	.byte	6
	.byte	6
	.byte	7
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	5
	.byte	6
	.byte	6
	.byte	7
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.type	g_QPmndetEn, %object
	.size	g_QPmndetEn, 5
g_QPmndetEn:
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.space	3
	.type	g_DefaultImgQPFlag, %object
	.size	g_DefaultImgQPFlag, 4
g_DefaultImgQPFlag:
	.byte	1
	.byte	2
	.byte	2
	.byte	1
	.type	g_DefaultStrIdx, %object
	.size	g_DefaultStrIdx, 8
g_DefaultStrIdx:
	.short	3
	.short	4
	.short	4
	.short	3
	.type	g_u32DmStr, %object
	.size	g_u32DmStr, 4
g_u32DmStr:
	.word	8
	.bss
	.align	2
.LANCHOR1 = . + 0
	.type	g_MV410En, %object
	.size	g_MV410En, 5
g_MV410En:
	.space	5
	.space	3
	.type	i.7989, %object
	.size	i.7989, 4
i.7989:
	.space	4
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
