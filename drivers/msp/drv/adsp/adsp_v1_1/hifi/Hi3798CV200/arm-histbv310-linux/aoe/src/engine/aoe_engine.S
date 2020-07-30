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
	.file	"aoe_engine.c"

	.text
	.align	2
	.type	ENGINECheckAipData, %function
ENGINECheckAipData:
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
	ldr	ip, [r0, #56]
	ldr	r1, [r0, #60]
	adds	r3, ip, #0
	ldr	r0, [r0, #64]
	movne	r3, #1
	adds	r4, r1, #0
	movne	r4, #1
	tst	r3, r4
	beq	.L2
	cmp	r3, #0
	beq	.L3
	mov	r2, #0
	mov	r5, #1
	mov	r3, r2
.L5:
	mov	lr, r5, asl r2
	tst	lr, ip
	beq	.L6
	ands	lr, lr, r0
	mov	r3, #1
	beq	.L20
.L6:
	add	r2, r2, #1
	cmp	r2, #8
	bne	.L5
.L3:
	cmp	r4, #0
	beq	.L9
	mov	r2, #0
	mov	lr, #1
.L8:
	mov	ip, lr, asl r2
	tst	ip, r1
	beq	.L11
	tst	ip, r0
	beq	.L21
	orr	r3, r3, #2
.L11:
	add	r2, r2, #1
	cmp	r2, #8
	bne	.L8
.L9:
	and	r0, r3, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L2:
	adds	r0, r0, #0
	movne	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L20:
	mov	r3, lr
	b	.L3
.L21:
	bic	r3, r3, #2
	b	.L9
	.fnend
	.size	ENGINECheckAipData, .-ENGINECheckAipData
	.align	2
	.type	ENGINECheckAopSpace, %function
ENGINECheckAopSpace:
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
	ldr	r3, [r0, #88]
	ldr	lr, [r0, #72]
	cmp	r3, #0
	ldr	r0, [r0, #76]
	beq	.L37
	cmp	lr, #0
	beq	.L24
	mov	r2, #0
	mov	r4, #1
	mov	ip, r2
.L26:
	mov	r1, r4, asl r2
	tst	r1, lr
	beq	.L28
	ands	r1, r1, r3
	mov	ip, #1
	beq	.L45
.L28:
	add	r2, r2, #1
	cmp	r2, #8
	bne	.L26
.L27:
	cmp	r0, #0
	beq	.L34
.L36:
	mov	r2, #0
	mov	r4, #1
.L30:
	mov	r1, r4, asl r2
	tst	r1, r0
	beq	.L33
	tst	r1, r3
	beq	.L46
	orr	ip, ip, #2
.L33:
	add	r2, r2, #1
	cmp	r2, #8
	bne	.L30
.L31:
	cmp	lr, #0
	bne	.L34
	ubfx	r0, ip, #1, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L24:
	cmp	r0, #0
	movne	ip, lr
	bne	.L36
.L47:
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L37:
	mov	r0, r3
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L34:
	and	r0, ip, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L45:
	mov	ip, r1
	b	.L27
.L46:
	bic	ip, ip, #2
	b	.L31
	.fnend
	.size	ENGINECheckAopSpace, .-ENGINECheckAopSpace
	.align	2
	.type	ENGINEDestroyChn, %function
ENGINEDestroyChn:
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
	ldr	r5, [r4, #12]
	cmp	r5, #0
	bne	.L50
	ldr	r1, [r4, #164]
	cmp	r1, #0
	beq	.L50
	mov	r0, #26
	bl	HI_ADSP_FREE
	str	r5, [r4, #164]
.L50:
	mov	r1, r4
	mov	r0, #26
	bl	HI_ADSP_FREE
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	ENGINEDestroyChn, .-ENGINEDestroyChn
	.global	__aeabi_uidiv
	.align	2
	.type	ENGINECreateChn, %function
ENGINECreateChn:
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
	ldr	r6, .L79
	mov	r1, #52
	mov	r5, r0
	ldr	r4, [r6, r0, asl #2]
	sub	r0, fp, #96
	bl	__memzero
	sub	r0, fp, #96
	ldr	r1, [r4]
	and	r1, r1, #3
	bl	AOE_REG_ReadBitDepth
	cmp	r0, #0
	bne	.L58
	ldr	r1, [r4]
	sub	r0, fp, #92
	ubfx	r1, r1, #2, #2
	bl	AOE_REG_ReadChannel
	cmp	r0, #0
	bne	.L58
	ldr	r1, [r4]
	sub	r0, fp, #88
	ubfx	r1, r1, #4, #4
	bl	AOE_REG_ReadSampelRate
	cmp	r0, #0
	bne	.L58
	ldr	r1, [r4]
	sub	r0, fp, #84
	ubfx	r1, r1, #8, #2
	bl	AOE_REG_ReadDataFormat
	subs	r2, r0, #0
	bne	.L58
	ldr	r3, [r6, r5, asl #2]
	mov	r1, #332
	str	r2, [fp, #-104]
	mov	r0, #26
	str	r2, [fp, #-100]
	ldr	ip, [r3, #80]
	str	ip, [fp, #-104]
	ldr	lr, [fp, #-104]
	ldr	ip, [r3, #84]
	str	lr, [fp, #-68]
	str	ip, [fp, #-100]
	ldr	ip, [r3, #88]
	bic	ip, ip, #-16777216
	str	ip, [fp, #-64]
	ldr	ip, [r3, #88]
	str	r2, [fp, #-104]
	str	r2, [fp, #-100]
	ubfx	r2, ip, #24, #4
	ldr	ip, [r3, #100]
	str	r2, [fp, #-60]
	str	ip, [fp, #-104]
	ldr	ip, [fp, #-104]
	ldr	r2, [r3, #104]
	str	ip, [fp, #-56]
	str	r2, [fp, #-100]
	ldr	r2, [r3, #108]
	bic	r2, r2, #-16777216
	str	r2, [fp, #-52]
	ldr	r3, [r3, #108]
	ubfx	r3, r3, #24, #4
	str	r3, [fp, #-48]
	bl	HI_ADSP_MALLOC
	subs	r4, r0, #0
	beq	.L58
	mov	r1, #332
	bl	__memzero
	mov	r2, #52
	sub	r1, fp, #96
	mov	r0, r4
	bl	memcpy
	ldr	r1, [r4]
	ldr	r0, [r4, #4]
	bl	UTIL_CalcFrameSize
	ldr	r3, [r4, #8]
	movw	r2, #19923
	movw	r1, #48000
	cmp	r3, r1
	movt	r2, 4194
	add	r3, r3, r3, lsl #2
	umull	r2, r3, r3, r2
	mov	r3, r3, lsr #6
	beq	.L76
	tst	r3, #3
	bicne	r3, r3, #3
	addne	r3, r3, #4
.L61:
	mul	r3, r0, r3
	ldr	r1, [r4]
	ldr	r0, [r4, #4]
	str	r3, [r4, #108]
	bl	UTIL_CalcFrameSize
	ldr	r6, [r4, #108]
	mov	r1, r0
	str	r0, [r4, #112]
	mov	r0, r6
	bl	__aeabi_uidiv
	ldr	r3, [r4, #12]
	cmp	r3, #0
	mov	ip, r0
	str	r0, [r4, #16]
	beq	.L77
.L62:
	mov	r0, r4
	mov	r3, #1
	str	r5, [r4, #104]
	str	r3, [r4, #116]
.L75:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L77:
	ldr	lr, [r4, #8]
	add	r7, r4, #164
	ldr	r8, [r4]
	add	r9, r4, #192
	ldr	r10, [r4, #4]
	mov	r1, r7
	str	ip, [r4, #172]
	mov	r2, #28
	str	lr, [r4, #184]
	mov	r0, r9
	str	r3, [r4, #164]
	str	r3, [r4, #188]
	str	r6, [r4, #168]
	str	r8, [r4, #176]
	str	r10, [r4, #180]
	bl	memcpy
	mov	r1, r7
	mov	r2, #28
	add	r0, r4, #220
	bl	memcpy
	mov	r3, #8
	mov	r0, r3
	str	r3, [r4, #236]
	ldr	r1, [r4, #232]
	ldr	r6, [r4, #228]
	bl	UTIL_CalcFrameSize
	mov	r1, r7
	mov	r2, #28
	mul	r8, r6, r0
	add	r0, r4, #248
	str	r8, [r4, #224]
	bl	memcpy
	mov	r1, r9
	mov	r2, #28
	add	r0, r4, #276
	bl	memcpy
	mov	r1, r7
	mov	r2, #28
	add	r0, r4, #304
	bl	memcpy
	ldr	r1, [r4, #196]
	ldr	r2, [r4, #168]
	mov	r0, #26
	ldr	r6, [r4, #252]
	add	r2, r1, r2
	ldr	r3, [r4, #280]
	add	r2, r2, r6
	ldr	r6, [r4, #308]
	add	r3, r2, r3
	add	r3, r3, r6
	add	r6, r3, r8
	mov	r1, r6
	bl	HI_ADSP_MALLOC
	subs	r7, r0, #0
	beq	.L63
	cmp	r6, #0
	bne	.L78
.L64:
	ldr	r0, [r4, #168]
	ldr	r1, [r4, #196]
	add	r0, r7, r0
	ldr	r2, [r4, #224]
	add	r1, r0, r1
	ldr	r3, [r4, #252]
	add	r2, r1, r2
	ldr	ip, [r4, #280]
	add	r3, r2, r3
	str	r0, [r4, #192]
	str	r7, [r4, #164]
	add	r0, r3, ip
	str	r1, [r4, #220]
	str	r2, [r4, #248]
	str	r3, [r4, #276]
	str	r0, [r4, #304]
	b	.L62
.L58:
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L76:
	tst	r3, #255
	bicne	r3, r3, #255
	addne	r3, r3, #256
	b	.L61
.L78:
	mov	r1, r6
	bl	__memzero
	b	.L64
.L63:
	mov	r0, r4
	bl	ENGINEDestroyChn
	mov	r0, r7
	b	.L75
.L80:
	.align	2
.L79:
	.word	.LANCHOR0
	.fnend
	.size	ENGINECreateChn, .-ENGINECreateChn
	.align	2
	.type	ENGINEOutRawFrame, %function
ENGINEOutRawFrame:
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
	mov	r6, r2
	bl	AIP_GetRingIn
	mov	r4, r0
	mov	r0, r5
	bl	AOP_GetRingOut
	cmp	r0, #0
	cmpne	r4, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	mov	r1, r0
	mov	r2, r6
	mov	r0, r4
	mov	r3, #3
	bl	RBUF_CopyData
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	ENGINEOutRawFrame, .-ENGINEOutRawFrame
	.align	2
	.type	ENGINEMixData, %function
ENGINEMixData:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #40
	sub	sp, sp, #40
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r5, r1
	mov	r4, r0
	sub	r1, fp, #72
	mov	r0, r5
	mov	r7, r2
	ldr	r8, [r4, #4]
	ldr	r9, [r4]
	bl	AIP_QueryFiFoInfo
	ldr	r0, [r4, #108]
	ldr	r3, [fp, #-52]
	ldr	r6, [fp, #-56]
	cmp	r3, r0
	bls	.L86
	cmp	r6, r0
	ldr	r1, [r4, #112]
	bcc	.L90
	bl	__aeabi_uidiv
	ldr	r2, [fp, #-68]
	ldr	r1, [fp, #-72]
	mov	r3, r9
	add	r1, r1, r2
	mul	r2, r8, r0
	mov	r0, r7
	bl	UTIL_MixerPro
.L89:
	ldr	r1, [r4, #108]
	mov	r0, r5
	bl	AIP_ReadDataComplete
.L86:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L90:
	mov	r0, r6
	bl	__aeabi_uidiv
	ldr	r2, [fp, #-68]
	ldr	r1, [fp, #-72]
	mov	r3, r9
	add	r1, r1, r2
	mul	r2, r8, r0
	mov	r0, r7
	bl	UTIL_MixerPro
	ldr	r0, [r4, #108]
	ldr	r1, [r4, #112]
	rsb	r0, r6, r0
	bl	__aeabi_uidiv
	mov	r3, r9
	ldr	r1, [fp, #-72]
	mul	r2, r8, r0
	add	r0, r7, r6
	bl	UTIL_MixerPro
	b	.L89
	.fnend
	.size	ENGINEMixData, .-ENGINEMixData
	.align	2
	.type	ENGINEOutFrame, %function
ENGINEOutFrame:
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
	ldr	r2, [r0, #12]
	mov	r8, r0
	ldr	r6, [r0, #72]
	ldr	r3, [r0, #76]
	cmp	r2, #0
	str	r6, [fp, #-116]
	str	r3, [fp, #-112]
	bne	.L91
	sub	r9, fp, #116
	sub	r10, fp, #112
	mov	r7, #1
.L101:
	mov	r4, #0
	b	.L99
.L94:
	add	r4, r4, #1
	cmp	r4, #8
	beq	.L116
.L99:
	mov	r5, r7, asl r4
	tst	r5, r6
	beq	.L94
	mov	r0, r4
	bl	AOP_WriteBuffProcTryCnt
	sub	r1, fp, #80
	mov	r0, r4
	bl	AOP_GetChnStatus
	ldr	r3, [r8, #88]
	tst	r5, r3
	beq	.L94
	mov	r0, r4
	bl	AOP_WriteBuffProcOKCnt
	ldr	r3, [r8, #92]
	cmp	r3, #0
	beq	.L96
	ldr	r3, [fp, #-60]
	cmp	r3, #0
	beq	.L117
.L96:
	ldr	r3, [fp, #-56]
	cmp	r3, #0
	beq	.L98
	ldr	r3, [r8, #152]
	cmp	r3, #0
	bne	.L118
.L98:
	sub	r3, fp, #108
	mov	r2, #28
	add	r1, r8, #164
	mov	r0, r3
	bl	memcpy
	mov	r3, r0
.L97:
	mov	r1, r3
	mov	r0, r4
	bl	AOP_WriteRbfData
	mov	r0, r4
	sub	r1, fp, #80
	add	r4, r4, #1
	bl	AOP_ProcDelayCompensation
	cmp	r4, #8
	bne	.L99
.L116:
	cmp	r9, r10
	ldrne	r6, [r9, #4]!
	bne	.L101
.L91:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L117:
	sub	r3, fp, #108
	mov	r2, #28
	add	r1, r8, #304
	mov	r0, r3
	bl	memcpy
	mov	r3, r0
	b	.L97
.L118:
	sub	r3, fp, #108
	mov	r2, #28
	add	r1, r8, #192
	mov	r0, r3
	bl	memcpy
	mov	r3, r0
	b	.L97
	.fnend
	.size	ENGINEOutFrame, .-ENGINEOutFrame
	.align	2
	.type	ENGINECheckRbfInData, %function
ENGINECheckRbfInData:
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
	ldr	r3, [r1, #12]
	mov	r4, r1
	mov	r6, r0
	ldr	r5, [r1, #108]
	cmp	r3, #0
	beq	.L120
	bl	AIP_QueryBusy
	cmp	r5, r0
	movls	r3, r5
	movhi	r3, #0
	mov	r0, r3
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L120:
	sub	r1, fp, #32
	bl	AIP_GetPcmType
	ldr	r3, [fp, #-32]
	cmp	r3, #3
	ldreq	r4, [r4, #224]
	beq	.L123
	cmp	r3, #4
	ldreq	r4, [r4, #196]
	ldrne	r4, [r4, #168]
.L123:
	mov	r0, r6
	bl	AIP_QueryFiFoBusy
	cmp	r0, r4
	movhi	r3, r4
	movls	r3, #0
	mov	r0, r3
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
	.fnend
	.size	ENGINECheckRbfInData, .-ENGINECheckRbfInData
	.align	2
	.global	UTIL_MixerMcPro
	.type	UTIL_MixerMcPro, %function
UTIL_MixerMcPro:
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
	ldmeqfd	sp, {fp, sp, pc}
	cmp	r3, #16
	beq	.L135
	cmp	r3, #24
	ldmnefd	sp, {fp, sp, pc}
	sub	r1, r1, #4
	mov	r3, #0
.L132:
	add	r3, r3, #1
	ldr	ip, [r1, #4]!
	cmp	r3, r2
	str	ip, [r0], #4
	bne	.L132
	ldmfd	sp, {fp, sp, pc}
.L135:
	sub	r1, r1, #2
	mov	r3, #0
.L130:
	add	r3, r3, #1
	ldrh	ip, [r1, #2]!
	cmp	r3, r2
	strh	ip, [r0], #2
	bne	.L130
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	UTIL_MixerMcPro, .-UTIL_MixerMcPro
	.align	2
	.type	ENGINEMixFrame, %function
ENGINEMixFrame:
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
	ldr	r2, [r0, #12]
	mov	r3, #5
	mov	r5, r0
	str	r3, [fp, #-80]
	cmp	r2, #0
	bne	.L145
	ldr	r1, [r0, #168]
	ldr	r0, [r0, #164]
	cmp	r1, #0
	bne	.L187
.L138:
	mov	r4, #0
	mov	r6, #1
.L142:
	ldr	r3, [r5, #52]
	mov	r0, r4
	sub	r1, fp, #80
	ands	r3, r3, r6, asl r4
	beq	.L139
	cmp	r2, #0
	bne	.L140
	bl	AIP_GetPcmType
	ldr	r3, [fp, #-80]
	cmp	r3, #1
	bls	.L188
.L186:
	ldr	r2, [r5, #12]
.L139:
	add	r4, r4, #1
	cmp	r4, #8
	bne	.L142
.L140:
	cmp	r2, #0
	mov	r3, #5
	str	r3, [fp, #-96]
	bne	.L145
	ldr	r3, [r5, #52]
	mov	r4, r2
	mov	r6, #1
	str	r2, [r5, #156]
	b	.L154
.L146:
	add	r4, r4, #1
	cmp	r4, #8
	beq	.L153
.L154:
	ands	r2, r3, r6, asl r4
	beq	.L146
	sub	r1, fp, #96
	mov	r0, r4
	bl	AIP_GetPcmType
	ldr	r3, [fp, #-96]
	cmp	r3, #3
	beq	.L147
	add	r4, r4, #1
	ldr	r3, [r5, #52]
	cmp	r4, #8
	bne	.L154
.L153:
	mov	r4, #0
	mov	r6, #1
	b	.L158
.L155:
	add	r4, r4, #1
	cmp	r4, #8
	beq	.L157
.L158:
	ands	r2, r3, r6, asl r4
	beq	.L155
	sub	r1, fp, #96
	mov	r0, r4
	bl	AIP_GetPcmType
	ldr	r3, [fp, #-96]
	cmp	r3, #2
	beq	.L156
	add	r4, r4, #1
	ldr	r3, [r5, #52]
	cmp	r4, #8
	bne	.L158
.L157:
	mov	r2, #0
	mov	r6, #1
	mov	r4, r2
	str	r2, [r5, #152]
	b	.L160
.L159:
	add	r4, r4, #1
	cmp	r4, #8
	beq	.L145
	ldr	r3, [r5, #52]
.L160:
	ands	r3, r3, r6, asl r4
	mov	r7, #1
	beq	.L159
	sub	r1, fp, #96
	mov	r0, r4
	bl	AIP_GetPcmType
	ldr	r3, [fp, #-96]
	cmp	r3, #4
	bne	.L159
	ldr	r2, [r5, #168]
	ldr	r1, [r5, #164]
	ldr	r0, [r5, #192]
	bl	memcpy
	mov	r1, r4
	ldr	r2, [r5, #192]
	mov	r0, r5
	bl	ENGINEMixData
	str	r7, [r5, #152]
.L145:
	ldr	r3, [r5, #128]
	cmp	r3, #2
	ldreq	r3, [r5, #120]
	addeq	r3, r3, #1
	streq	r3, [r5, #120]
.L136:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L188:
	ldr	r2, [r5, #164]
	mov	r1, r4
	mov	r0, r5
	bl	ENGINEMixData
	b	.L186
.L187:
	bl	__memzero
	ldr	r2, [r5, #12]
	b	.L138
.L147:
	ldr	r2, [r5, #168]
	ldr	r1, [r5, #164]
	ldr	r0, [r5, #220]
	bl	memcpy
	ldr	r1, [r5, #232]
	mov	r0, #8
	ldr	r7, [r5, #220]
	ldr	r6, [r5, #160]
	ldr	r8, [r5, #236]
	ldr	r9, [r5]
	bl	UTIL_CalcFrameSize
	sub	r1, fp, #80
	mov	r10, r0
	mov	r0, r4
	bl	AIP_QueryFiFoInfo
	ldr	r0, [r5, #224]
	ldr	r3, [fp, #-60]
	ldr	ip, [fp, #-64]
	cmp	r3, r0
	bcc	.L148
	cmp	r6, #0
	beq	.L149
	cmp	ip, r0
	mov	r1, r10
	bcs	.L150
	mov	r0, ip
	str	ip, [fp, #-104]
	bl	__aeabi_uidiv
	ldr	r2, [fp, #-76]
	ldr	r1, [fp, #-80]
	mov	r3, r9
	add	r1, r1, r2
	mul	r2, r8, r0
	mov	r0, r7
	bl	UTIL_MixerMcPro
	ldr	ip, [fp, #-104]
	ldr	r0, [r5, #224]
	mov	r1, r10
	rsb	r0, ip, r0
	bl	__aeabi_uidiv
	ldr	ip, [fp, #-104]
	mov	r3, r9
	ldr	r1, [fp, #-80]
	mul	r2, r8, r0
	add	r0, r7, ip
	bl	UTIL_MixerMcPro
	ldr	r0, [r5, #224]
.L149:
	mov	r1, r0
	mov	r0, r4
	bl	AIP_ReadDataComplete
.L151:
	mov	r2, #1
	ldr	r3, [r5, #52]
	str	r2, [r5, #156]
	b	.L153
.L156:
	mov	r1, r4
	ldr	r2, [r5, #164]
	mov	r0, r5
	bl	ENGINEMixData
	ldr	r3, [r5, #52]
	b	.L157
.L148:
	sub	r1, fp, #92
	mov	r0, r4
	bl	AIP_GetChnStatus
	ldr	r3, [fp, #-92]
	cmp	r3, #1
	bne	.L151
	mov	r0, r4
	bl	AIP_UnderFlowCalc
	b	.L151
.L150:
	bl	__aeabi_uidiv
	ldr	r2, [fp, #-76]
	ldr	r1, [fp, #-80]
	mov	r3, r9
	add	r1, r1, r2
	mul	r2, r8, r0
	mov	r0, r7
	bl	UTIL_MixerMcPro
	ldr	r0, [r5, #224]
	b	.L149
	.fnend
	.size	ENGINEMixFrame, .-ENGINEMixFrame
	.align	2
	.global	ENGINE_Process
	.type	ENGINE_Process, %function
ENGINE_Process:
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
	ldr	r3, .L375
	mov	r2, #0
	mov	r6, r2
	add	r9, r3, #24
	mov	r7, r3
	b	.L259
.L206:
	add	r6, r6, #1
	add	r9, r9, #4
	cmp	r6, #6
	beq	.L357
.L259:
	ldr	r3, [r7], #4
	ldr	r2, [r3, #4]
	ubfx	r2, r2, #2, #1
	cmp	r2, #0
	bne	.L352
	ldr	r1, [r3, #4]
	ands	r1, r1, #3
	beq	.L192
	cmp	r1, #1
	beq	.L193
	ldr	r2, [r3, #4]
	mov	r1, #4
	bfi	r2, r1, #3, #4
	str	r2, [r3, #4]
	ldr	r2, [r3, #4]
	orr	r2, r2, r1
	str	r2, [r3, #4]
.L352:
	ldr	r4, [r9]
	cmp	r4, #0
	beq	.L206
.L205:
	ldr	r10, [r4, #116]
.L260:
	cmp	r10, #1
	bne	.L206
	ldr	r1, [r4]
	ldr	r3, [r7, #-4]
	str	r1, [fp, #-132]
	ldr	r1, [r4, #4]
	mov	r2, r3
	str	r3, [fp, #-124]
	mov	r3, #0
	mov	r8, r3
	str	r1, [fp, #-140]
	ldr	ip, [r2, #12]
	ldr	r2, [r4, #16]
	str	r4, [fp, #-112]
	mov	r4, r3
	str	r3, [fp, #-104]
	uxth	r5, ip
	str	r2, [fp, #-136]
	str	r3, [fp, #-120]
	str	r3, [fp, #-108]
	str	r3, [fp, #-116]
	str	r6, [fp, #-128]
	b	.L213
.L208:
	add	r8, r8, #1
	cmp	r8, #8
	beq	.L358
.L213:
	mov	r6, r10, asl r8
	tst	r6, r5
	beq	.L208
	sub	r1, fp, #80
	mov	r0, r8
	bl	AOP_GetChnStatus
	ldr	r1, [fp, #-80]
	cmp	r1, #1
	bne	.L208
	ldr	r1, [fp, #-76]
	cmp	r1, #1
	ldr	r1, [fp, #-72]
	ldreq	r3, [fp, #-116]
	ldrne	r3, [fp, #-108]
	orreq	r3, r3, r6
	orrne	r3, r3, r6
	streq	r3, [fp, #-116]
	strne	r3, [fp, #-108]
	ldr	r3, [fp, #-132]
	cmp	r3, r1
	beq	.L359
.L211:
	ldr	r3, [fp, #-104]
	orr	r3, r3, r6
	str	r3, [fp, #-104]
.L212:
	ldr	r1, [fp, #-64]
	mov	r0, r8
	ldr	r3, [fp, #-136]
	add	r8, r8, #1
	mul	r1, r1, r3
	bl	AOP_QueryRbfFree
	cmp	r0, #0
	orrne	r4, r4, r6
	cmp	r8, #8
	bne	.L213
.L358:
	mov	r3, r4
	ldr	r1, [fp, #-116]
	ldr	r4, [fp, #-112]
	mov	r2, #0
	str	r2, [fp, #-112]
	mov	r8, #1
	str	r2, [fp, #-116]
	str	r1, [r4, #72]
	ldr	r1, [fp, #-108]
	str	r3, [r4, #88]
	ldr	r3, [fp, #-124]
	str	r1, [r4, #76]
	ldr	r1, [fp, #-120]
	str	r5, [r4, #68]
	mov	r5, r2
	str	r2, [fp, #-108]
	str	r1, [r4, #80]
	ldr	r1, [fp, #-104]
	ldr	r6, [fp, #-128]
	str	r1, [r4, #84]
	ldr	r2, [r3, #8]
	mov	r3, r9
	str	r6, [fp, #-104]
	mov	r9, r7
	mov	r6, r4
	uxth	r10, r2
	mov	r7, r10
	mov	r10, r3
	b	.L219
.L214:
	add	r5, r5, #1
	cmp	r5, #8
	beq	.L360
.L219:
	mov	r4, r8, asl r5
	tst	r4, r7
	beq	.L214
	sub	r1, fp, #80
	mov	r0, r5
	bl	AIP_GetChnStatus
	ldr	r2, [fp, #-80]
	cmp	r2, #1
	beq	.L361
	ldr	r2, [r6, #12]
	cmp	r2, #0
	bne	.L214
	mov	r1, r6
	mov	r0, r5
	bl	ENGINECheckRbfInData
	cmp	r0, #0
	beq	.L214
	ldr	r2, [fp, #-76]
	add	r5, r5, #1
	ldr	r3, [fp, #-112]
	cmp	r2, #1
	orr	r3, r3, r4
	str	r3, [fp, #-112]
	ldreq	r3, [fp, #-116]
	ldrne	r3, [fp, #-108]
	orreq	r3, r3, r4
	orrne	r3, r3, r4
	streq	r3, [fp, #-116]
	strne	r3, [fp, #-108]
	cmp	r5, #8
	bne	.L219
.L360:
	mov	r3, r10
	mov	r10, r7
	mov	r7, r9
	mov	r9, r3
	ldr	r3, [fp, #-116]
	mov	r4, r6
	str	r10, [r4, #52]
	ldr	r6, [fp, #-104]
	str	r3, [r4, #56]
	ldr	r3, [fp, #-108]
	str	r3, [r4, #60]
	ldr	r3, [fp, #-112]
	str	r3, [r4, #64]
	ldr	r8, [r9]
	ldr	r5, [r8, #12]
	cmp	r5, #0
	bne	.L362
	ldr	r2, [r8, #128]
	sub	r1, r2, #1
	cmp	r1, #1
	bls	.L243
	mov	r3, r5
	str	r5, [fp, #-112]
	str	r5, [fp, #-104]
	mov	r4, r5
	mov	ip, #1
	mov	r5, r8
	mov	r8, r7
	mov	r7, r6
	mov	r6, r3
	b	.L246
.L244:
	add	r4, r4, #1
	cmp	r4, #8
	beq	.L363
.L246:
	ldr	r1, [r5, #52]
	mov	r10, ip, asl r4
	tst	r10, r1
	beq	.L244
	sub	r1, fp, #80
	mov	r0, r4
	str	ip, [fp, #-108]
	bl	AIP_GetChnStatus
	ldr	r1, [fp, #-80]
	ldr	ip, [fp, #-108]
	cmp	r1, #0
	bne	.L245
	ldr	r1, [fp, #-72]
	add	r4, r4, #1
	ldr	r3, [fp, #-104]
	cmp	r1, #1
	orreq	r6, r6, r10
	cmp	r4, #8
	orr	r3, r3, r10
	str	r3, [fp, #-104]
	bne	.L246
.L363:
	mov	r3, r6
	mov	r6, r7
	mov	r7, r8
	mov	r8, r5
	mov	r5, r3
	ldr	r3, [r8, #124]
	mov	r4, #0
	mov	r10, #1
	str	r3, [fp, #-108]
	ldr	r3, [fp, #-104]
	str	r3, [r8, #124]
	b	.L248
.L247:
	add	r4, r4, #1
	cmp	r4, #8
	beq	.L364
.L248:
	ands	r3, r5, r10, asl r4
	beq	.L247
	mov	r0, r4
	add	r4, r4, #1
	bl	AIP_FlushCutoffFlag
	cmp	r4, #8
	bne	.L248
.L364:
	ldr	r3, [fp, #-112]
	cmp	r3, #0
	ldrne	r2, [r8, #128]
	bne	.L243
	ldr	r3, [fp, #-104]
	ldr	r2, [fp, #-108]
	rsb	r3, r2, r3
	cmp	r3, r5
	bls	.L365
	ldr	r3, [fp, #-112]
	mov	r2, #2
	str	r2, [r8, #128]
	str	r3, [r8, #120]
.L263:
	ldr	r2, [r8, #120]
	cmp	r2, #2
	bne	.L252
.L262:
	mov	r4, #0
	mov	r5, #1
.L255:
	ldr	r2, [r8, #72]
	mov	r3, r5, asl r4
	mov	r0, r4
	add	r4, r4, #1
	tst	r3, r2
	bne	.L253
	ldr	r2, [r8, #76]
	tst	r3, r2
	beq	.L254
.L253:
	bl	AOP_Flush
.L254:
	cmp	r4, #8
	bne	.L255
	ldr	r2, [r8, #92]
	mov	r3, #0
	str	r3, [r8, #128]
	cmp	r2, #0
	str	r3, [r8, #120]
	bne	.L366
.L256:
	mov	r0, r8
	bl	ENGINECheckAopSpace
	cmp	r0, #0
	beq	.L206
	mov	r0, r8
	bl	ENGINECheckAipData
	cmp	r0, #0
	beq	.L206
	mov	r0, r8
	bl	ENGINEMixFrame
	mov	r0, r8
	bl	ENGINEOutFrame
	b	.L206
.L193:
	ldr	r4, [r9]
	cmp	r4, #0
	beq	.L206
	ldr	r10, [r4, #116]
	cmp	r10, #1
	beq	.L367
	ldr	r2, [r3, #4]
	tst	r2, #4
	bne	.L260
.L261:
	ldr	r2, [r3, #4]
	bfc	r2, #3, #4
	str	r2, [r3, #4]
	ldr	r2, [r3, #4]
	orr	r2, r2, #4
	str	r2, [r3, #4]
	b	.L205
.L192:
	ldr	r0, [r9]
	cmp	r0, #0
	beq	.L368
	ldr	r2, [r0, #116]
	cmp	r2, #0
	beq	.L369
.L199:
	mov	r2, #1
	str	r2, [r0, #116]
.L198:
	ldr	r2, [r3, #4]
	ubfx	r2, r2, #2, #1
	cmp	r2, #0
	ldreq	r1, [r3, #4]
	bfieq	r1, r2, #3, #4
	streq	r1, [r3, #4]
	ldreq	r2, [r3, #4]
	orreq	r2, r2, #4
	streq	r2, [r3, #4]
	b	.L352
.L357:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L361:
	ldr	r2, [fp, #-76]
	mov	r1, r6
	mov	r0, r5
	cmp	r2, #1
	ldreq	r3, [fp, #-116]
	ldrne	r3, [fp, #-108]
	orreq	r3, r3, r4
	orrne	r3, r3, r4
	streq	r3, [fp, #-116]
	strne	r3, [fp, #-108]
	bl	ENGINECheckRbfInData
	cmp	r0, #0
	ldrne	r3, [fp, #-112]
	orrne	r3, r3, r4
	strne	r3, [fp, #-112]
	b	.L214
.L245:
	ldr	r3, [fp, #-112]
	orr	r3, r3, r10
	str	r3, [fp, #-112]
	b	.L244
.L243:
	cmp	r2, #1
	beq	.L262
	cmp	r2, #2
	beq	.L263
.L252:
	ldr	r2, [r8, #92]
	cmp	r2, #0
	beq	.L256
.L366:
	tst	r2, #15
	bne	.L256
	ldr	r2, [r8, #96]
	cmp	r2, #0
	beq	.L258
	mov	r0, r8
	bl	ENGINECheckAipData
	cmp	r0, #0
	bne	.L370
.L258:
	ldr	r2, [r8, #100]
	cmp	r2, #0
	beq	.L206
	mov	r0, r8
	bl	ENGINECheckAopSpace
	cmp	r0, #0
	beq	.L206
	mov	r0, r8
	bl	ENGINEOutFrame
	b	.L206
.L362:
	ldr	r2, [r8, #68]
	mov	r3, #0
	str	r3, [fp, #-100]
	tst	r2, #1
	str	r3, [fp, #-96]
	bne	.L221
	mov	r5, #1
	mov	r1, r5
.L225:
	ands	r3, r2, r1, asl r5
	bne	.L371
	add	r5, r5, #1
	cmp	r5, #8
	bne	.L225
	ldr	r2, [r8, #52]
	tst	r2, #1
	bne	.L206
	mov	r0, #1
.L224:
	mov	r4, #1
	mov	r1, r4
	b	.L228
.L227:
	add	r4, r4, #1
	cmp	r4, #8
	beq	.L206
.L228:
	ands	r3, r2, r1, asl r4
	beq	.L227
	sub	r2, r4, #8
	clz	r2, r2
	mov	r2, r2, lsr #5
.L223:
	orrs	r3, r2, r0
	bne	.L206
.L265:
	sub	r1, fp, #92
	mov	r0, r4
	bl	AIP_GetChnStatus
	ldr	r10, [fp, #-92]
	ldr	r2, [r8, #12]
	cmp	r10, #0
	bne	.L229
	cmp	r2, #2
	str	r10, [r8, #20]
	str	r10, [r8, #24]
	beq	.L206
.L230:
	mov	r0, r8
	bl	ENGINECheckAopSpace
	cmp	r0, #0
	beq	.L206
	mov	r0, r8
	bl	ENGINECheckAipData
	cmp	r0, #0
	beq	.L206
	ldr	r2, [r8, #108]
	mov	r0, r4
	mov	r1, r5
	bl	ENGINEOutRawFrame
	sub	r1, fp, #80
	mov	r0, r5
	bl	AOP_GetChnStatus
	sub	r1, fp, #80
	mov	r0, r5
	bl	AOP_ProcDelayCompensation
	b	.L206
.L369:
	bl	ENGINEDestroyChn
	mov	r0, r6
	bl	ENGINECreateChn
	cmp	r0, #0
	str	r0, [r9]
	ldr	r3, [r7, #-4]
	bne	.L199
	ldr	r2, [r3, #4]
	tst	r2, #4
	bne	.L206
.L353:
	ldr	r2, [r3, #4]
	mov	r1, #3
	bfi	r2, r1, #3, #4
	str	r2, [r3, #4]
	ldr	r2, [r3, #4]
	orr	r2, r2, #4
	str	r2, [r3, #4]
	b	.L206
.L367:
	str	r2, [r4, #116]
	ldr	r2, [r3, #4]
	tst	r2, #4
	beq	.L261
	b	.L205
.L359:
	ldr	r1, [fp, #-68]
	ldr	r3, [fp, #-140]
	cmp	r3, r1
	bne	.L211
	ldr	r3, [fp, #-120]
	orr	r3, r3, r6
	str	r3, [fp, #-120]
	b	.L212
.L229:
	cmp	r2, #2
	bne	.L230
	mov	r0, r8
	bl	ENGINECheckAopSpace
	adds	r0, r0, #0
	movne	r0, #1
	cmp	r10, #1
	movne	r0, #0
	cmp	r0, #0
	beq	.L206
	ldr	r3, [r8, #20]
	ldr	r2, [r8, #24]
	orrs	r1, r2, r3
	str	r3, [fp, #-100]
	str	r2, [fp, #-96]
	beq	.L372
.L233:
	cmp	r3, #0
	beq	.L236
	ldr	r10, [r8, #108]
	cmp	r10, r3
	bhi	.L237
	mov	r0, r8
	bl	ENGINECheckAipData
	cmp	r0, #0
	beq	.L206
.L238:
	mov	r1, r5
	mov	r0, r4
	mov	r2, r10
	bl	ENGINEOutRawFrame
	ldr	r3, [fp, #-100]
	rsb	r1, r10, r3
	str	r1, [fp, #-100]
	cmp	r1, #0
	bne	.L239
	ldr	r0, [r8, #108]
	cmp	r10, r0
	bcs	.L239
	ldr	r2, [fp, #-96]
	rsb	r4, r10, r0
	cmp	r4, r2
	bls	.L373
.L239:
	mov	r0, r5
	sub	r1, fp, #80
	bl	AOP_GetChnStatus
	sub	r1, fp, #80
	mov	r0, r5
	bl	AOP_ProcDelayCompensation
	ldr	r2, [fp, #-100]
	ldr	r3, [fp, #-96]
.L241:
	str	r2, [r8, #20]
	str	r3, [r8, #24]
	b	.L206
.L365:
	mov	r2, #1
	str	r2, [r8, #128]
	b	.L262
.L368:
	mov	r0, r6
	bl	ENGINECreateChn
	cmp	r0, #0
	str	r0, [r9]
	beq	.L374
	mov	r3, #1
	str	r3, [r0, #116]
	ldr	r3, [r7, #-4]
	b	.L198
.L371:
	ldr	r2, [r8, #52]
	sub	r0, r5, #8
	clz	r0, r0
	tst	r2, #1
	mov	r0, r0, lsr #5
	beq	.L224
	mov	r2, #0
	mov	r4, r2
	b	.L223
.L370:
	mov	r0, r8
	bl	ENGINEMixFrame
	b	.L258
.L221:
	ldr	r2, [r8, #52]
	ands	r0, r2, #1
	bne	.L271
	mov	r5, r0
	b	.L224
.L374:
	ldr	r3, [r7, #-4]
	ldr	r2, [r3, #4]
	tst	r2, #4
	bne	.L206
	b	.L353
.L236:
	ldr	r2, [fp, #-96]
	cmp	r2, #0
	beq	.L241
	ldr	r1, [r8, #108]
	mov	r0, r5
	str	r3, [fp, #-104]
	cmp	r2, r1
	movcc	r4, r2
	movcs	r4, r1
	bl	AOP_GetRingOut
	cmp	r0, #0
	beq	.L242
	ldr	r3, [fp, #-104]
	mov	r2, r4
	mov	r1, r3
	bl	RBUF_WriteDataDma
.L242:
	ldr	r1, [fp, #-96]
	ldr	r2, [fp, #-100]
	rsb	r3, r4, r1
	b	.L241
.L372:
	mov	r0, r4
	bl	AIP_QueryBusy
	cmp	r0, #3
	bls	.L206
	sub	r2, fp, #96
	sub	r1, fp, #100
	mov	r0, r4
	bl	AIP_GetCompressInfo
	ldr	r3, [fp, #-100]
	ldr	r2, [fp, #-96]
	cmp	r3, #0
	bne	.L235
	cmp	r2, #0
	bne	.L235
	mov	r0, r4
	bl	AIP_GetRingIn
	bl	RBUF_Flush
	ldr	r3, [fp, #-100]
	ldr	r2, [fp, #-96]
.L235:
	str	r3, [r8, #20]
	str	r2, [r8, #24]
	b	.L233
.L271:
	mov	r4, #0
	mov	r5, r4
	b	.L265
.L237:
	mov	r0, r4
	str	r3, [fp, #-104]
	bl	AIP_QueryBusy
	ldr	r3, [fp, #-104]
	cmp	r0, r3
	bcc	.L206
	mov	r10, r3
	b	.L238
.L373:
	mov	r0, r5
	str	r1, [fp, #-104]
	bl	AOP_GetRingOut
	cmp	r0, #0
	beq	.L240
	ldr	r1, [fp, #-104]
	mov	r2, r4
	bl	RBUF_WriteDataDma
.L240:
	ldr	r2, [fp, #-96]
	rsb	r4, r4, r2
	str	r4, [fp, #-96]
	b	.L239
.L376:
	.align	2
.L375:
	.word	.LANCHOR0
	.fnend
	.size	ENGINE_Process, .-ENGINE_Process
	.align	2
	.global	ENGINE_Init
	.type	ENGINE_Init, %function
ENGINE_Init:
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
	ldr	r5, .L380
	mov	r4, r0
	mov	r7, #1
	add	r6, r5, #24
.L378:
	mov	r0, r4
	mov	r1, #128
	str	r4, [r5], #4
	bl	__memzero
	ldr	r3, [r4, #4]
	cmp	r5, r6
	mov	r2, #0
	add	r4, r4, #128
	orr	r3, r3, #4
	str	r3, [r4, #-124]
	ldr	r3, [r4, #-124]
	bfi	r3, r7, #0, #2
	str	r3, [r4, #-124]
	str	r2, [r5, #20]
	bne	.L378
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L381:
	.align	2
.L380:
	.word	.LANCHOR0
	.fnend
	.size	ENGINE_Init, .-ENGINE_Init
	.align	2
	.global	ENGINE_DeInit
	.type	ENGINE_DeInit, %function
ENGINE_DeInit:
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
	ldr	r4, .L385
	mov	r6, #0
	add	r5, r4, #24
.L383:
	ldr	r0, [r4, #4]!
	bl	ENGINEDestroyChn
	cmp	r4, r5
	str	r6, [r4]
	bne	.L383
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L386:
	.align	2
.L385:
	.word	.LANCHOR0+20
	.fnend
	.size	ENGINE_DeInit, .-ENGINE_DeInit
	.bss
	.align	2
.LANCHOR0 = . + 0
	.type	g_stEneRm, %object
	.size	g_stEneRm, 48
g_stEneRm:
	.space	48
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
