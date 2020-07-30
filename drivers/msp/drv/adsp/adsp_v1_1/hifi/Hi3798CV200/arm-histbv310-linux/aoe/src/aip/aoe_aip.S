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
	.file	"aoe_aip.c"

	.text
	.align	2
	.type	AIPDestroyChn, %function
AIPDestroyChn:
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
	ldr	r0, [r4, #128]
	mov	r3, #0
	str	r3, [r4, #152]
	cmp	r0, r3
	beq	.L3
	bl	RBUF_Destroy
.L3:
	ldr	r0, [r4, #132]
	cmp	r0, #0
	beq	.L4
	bl	RBUF_Destroy
.L4:
	ldr	r0, [r4, #144]
	cmp	r0, #0
	beq	.L5
	bl	FADE_Destroy
.L5:
	ldr	r0, [r4, #136]
	cmp	r0, #0
	beq	.L6
	bl	LSRC_Destroy
.L6:
	ldr	r0, [r4, #140]
	cmp	r0, #0
	beq	.L7
	ldr	r3, [r4, #240]
	cmp	r3, #2
	beq	.L35
.L8:
	bl	ResamplerFree
.L7:
	ldr	r1, [r4, #216]
	cmp	r1, #0
	beq	.L9
	mov	r0, #26
	bl	HI_ADSP_FREE
.L9:
	mov	r1, r4
	mov	r0, #26
	bl	HI_ADSP_FREE
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L35:
	ldr	r1, [r4, #148]
	cmp	r1, #0
	beq	.L8
	mov	r0, #26
	bl	HI_ADSP_FREE
	b	.L7
	.fnend
	.size	AIPDestroyChn, .-AIPDestroyChn
	.align	2
	.global	AIP_GetPcmType
	.type	AIP_GetPcmType, %function
AIP_GetPcmType:
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
	ldr	r3, .L39
	add	r0, r0, #8
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	ldrne	r3, [r3]
	moveq	r3, #5
	str	r3, [r1]
	ldmfd	sp, {fp, sp, pc}
.L40:
	.align	2
.L39:
	.word	.LANCHOR0
	.fnend
	.size	AIP_GetPcmType, .-AIP_GetPcmType
	.global	__aeabi_uidiv
	.align	2
	.global	AIPFadeoutChnData
	.type	AIPFadeoutChnData, %function
AIPFadeoutChnData:
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
	mov	r4, r0
	sub	r1, fp, #64
	ldr	r0, [r0, #132]
	bl	RBUF_QueryInfo
	ldr	r6, [r4, #116]
	ldr	r0, [fp, #-48]
	mov	r1, r6
	bl	__aeabi_uidiv
	mov	r1, r6
	mov	r5, r0
	ldr	r0, [fp, #-44]
	bl	__aeabi_uidiv
	mov	r2, #8
	mov	r1, #2
	mov	r6, r0
	ldr	r0, [r4, #144]
	bl	FADE_Active
	ldr	r3, [r4, #76]
	ldr	r2, [r4, #72]
	ldr	r1, [r4, #80]
	ldr	r0, [r4, #144]
	bl	FADE_Flush
	ldr	r3, [fp, #-60]
	ldr	r1, [fp, #-64]
	mov	r2, r5
	ldr	r0, [r4, #144]
	add	r1, r1, r3
	bl	FADE_OutProcess
	rsb	r2, r5, r6
	ldr	r0, [r4, #144]
	ldr	r1, [fp, #-64]
	bl	FADE_OutProcess
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
	.fnend
	.size	AIPFadeoutChnData, .-AIPFadeoutChnData
	.align	2
	.global	AIPGetRbfFiFoAttr
	.type	AIPGetRbfFiFoAttr, %function
AIPGetRbfFiFoAttr:
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
	ldr	r3, .L46
	mov	r4, r1
	ldr	r5, [r3, r0, asl #2]
	add	r0, r1, #72
	ldr	r1, [r5, #4]
	and	r1, r1, #3
	bl	AOE_REG_ReadBitDepth
	cmp	r0, #0
	bne	.L45
	ldr	r1, [r5, #4]
	add	r0, r4, #76
	ubfx	r1, r1, #2, #2
	bl	AOE_REG_ReadChannel
	cmp	r0, #0
	bne	.L45
	ldr	r1, [r5, #4]
	add	r0, r4, #80
	ubfx	r1, r1, #4, #4
	bl	AOE_REG_ReadSampelRate
	cmp	r0, #0
	bne	.L45
	ldr	r1, [r5, #4]
	add	r0, r4, #84
	ubfx	r1, r1, #8, #2
	bl	AOE_REG_ReadDataFormat
	cmp	r0, #0
	bne	.L45
	ldr	r1, [r5, #4]
	sub	r0, fp, #32
	ubfx	r1, r1, #10, #6
	bl	AOE_REG_ReadBufLatencyMs
	subs	r6, r0, #0
	bne	.L45
	ldr	r1, [r4, #72]
	ldr	r0, [r4, #76]
	bl	UTIL_CalcFrameSize
	ldr	r2, [r4, #80]
	mov	r7, r0
	mov	r1, r0
	ldr	r0, [fp, #-32]
	bl	UTIL_LatencyMs2ByteSize
	ldr	r3, [fp, #-32]
	add	r1, r5, #68
	str	r7, [r4, #116]
	add	r5, r5, #72
	str	r6, [r4, #92]
	str	r6, [r4, #112]
	str	r3, [r4, #124]
	str	r3, [r4, #88]
	str	r1, [r4, #104]
	str	r5, [r4, #108]
	str	r0, [r4, #100]
	str	r0, [r4, #120]
	mov	r0, r6
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L45:
	mvn	r6, #0
	mov	r0, r6
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L47:
	.align	2
.L46:
	.word	.LANCHOR0
	.fnend
	.size	AIPGetRbfFiFoAttr, .-AIPGetRbfFiFoAttr
	.align	2
	.global	AIPGetRbfInAttr
	.type	AIPGetRbfInAttr, %function
AIPGetRbfInAttr:
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
	ldr	r3, .L64
	mov	r4, r1
	ldr	r5, [r3, r0, asl #2]
	add	r0, r1, #16
	ldr	r1, [r5]
	and	r1, r1, #3
	bl	AOE_REG_ReadBitDepth
	cmp	r0, #0
	bne	.L51
	ldr	r1, [r5]
	add	r0, r4, #20
	ubfx	r1, r1, #2, #3
	bl	AOE_REG_ReadChannel
	cmp	r0, #0
	bne	.L51
	ldr	r1, [r5]
	add	r0, r4, #24
	ubfx	r1, r1, #5, #4
	bl	AOE_REG_ReadSampelRate
	cmp	r0, #0
	beq	.L54
	ldr	r3, [r5]
	ubfx	r3, r3, #5, #4
	cmp	r3, #15
	beq	.L63
.L54:
	ldr	r1, [r5]
	add	r0, r4, #28
	ubfx	r1, r1, #9, #2
	bl	AOE_REG_ReadDataFormat
	subs	r6, r0, #0
	bne	.L51
	ldr	r3, [r4, #28]
	cmp	r3, #0
	bne	.L58
	ldr	r1, [r5]
	mov	r0, r4
	ubfx	r1, r1, #11, #3
	bl	AOE_REG_ReadPcmType
	cmp	r0, #0
	bne	.L51
.L58:
	ldr	r3, [r5]
	ldr	r1, [r4, #16]
	ubfx	r3, r3, #14, #1
	ldr	r0, [r4, #20]
	str	r3, [r4, #4]
	bl	UTIL_CalcFrameSize
	mov	r2, #0
	mov	r3, #1
	str	r2, [fp, #-36]
	str	r3, [r4, #36]
	str	r2, [fp, #-32]
	ldr	r3, [r5, #16]
	str	r3, [fp, #-36]
	ldr	r1, [fp, #-36]
	ldr	r3, [r5, #20]
	str	r1, [r4, #40]
	str	r3, [fp, #-32]
	ldr	r3, [r5, #24]
	bic	r3, r3, #-16777216
	str	r3, [r4, #44]
	ldr	r1, [r5, #24]
	tst	r1, #16777216
	bne	.L56
	add	r1, r5, #28
	add	r2, r5, #36
	str	r1, [r4, #48]
	str	r2, [r4, #52]
.L59:
	ldr	r2, [r5, #24]
	mov	r1, #0
	str	r0, [r4, #60]
	mov	r0, #16
	ubfx	r2, r2, #24, #1
	str	r3, [r4, #64]
	str	r0, [r4, #8]
	mov	r3, #8
	mov	r0, r6
	str	r2, [r4, #56]
	str	r1, [r4, #68]
	str	r1, [r4, #32]
	str	r3, [r4, #12]
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L56:
	str	r2, [fp, #-36]
	str	r2, [fp, #-32]
	ldr	r1, [r5, #28]
	str	r1, [fp, #-36]
	ldr	ip, [fp, #-36]
	ldr	r1, [r5, #32]
	str	ip, [r4, #48]
	str	r1, [fp, #-32]
	str	r2, [fp, #-36]
	str	r2, [fp, #-32]
	ldr	r2, [r5, #36]
	str	r2, [fp, #-36]
	ldr	r1, [fp, #-36]
	ldr	r2, [r5, #40]
	str	r1, [r4, #52]
	str	r2, [fp, #-32]
	b	.L59
.L63:
	ldr	r3, [r5, #12]
	movw	r2, #56928
	movt	r2, 2
	bic	r3, r3, #-16777216
	str	r3, [r4, #24]
	sub	r3, r3, #4000
	cmp	r3, r2
	bhi	.L51
	ldr	r3, [r4, #20]
	cmp	r3, #2
	bhi	.L51
	ldr	r3, [r4, #16]
	cmp	r3, #16
	beq	.L54
.L51:
	mvn	r6, #0
	mov	r0, r6
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L65:
	.align	2
.L64:
	.word	.LANCHOR0
	.fnend
	.size	AIPGetRbfInAttr, .-AIPGetRbfInAttr
	.align	2
	.global	AIPGetChnCreateAttr
	.type	AIPGetChnCreateAttr, %function
AIPGetChnCreateAttr:
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
	bl	AIPGetRbfInAttr
	cmp	r0, #0
	bne	.L68
	mov	r1, r5
	mov	r0, r4
	bl	AIPGetRbfFiFoAttr
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r0, r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L68:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	AIPGetChnCreateAttr, .-AIPGetChnCreateAttr
	.align	2
	.global	AIPIsChnAttrChange
	.type	AIPIsChnAttrChange, %function
AIPIsChnAttrChange:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #132
	sub	sp, sp, #132
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r3, .L70
	add	r2, r0, #8
	sub	r1, fp, #156
	ldr	r5, [r3, r2, asl #2]
	bl	AIPGetChnCreateAttr
	ldr	lr, [fp, #-136]
	ldr	r3, [fp, #-140]
	ldr	r0, [r5, #20]
	ldr	ip, [r5, #16]
	subs	r4, r0, lr
	ldr	r2, [r5, #24]
	ldr	r0, [fp, #-132]
	movne	r4, #1
	cmp	ip, r3
	moveq	lr, r4
	addne	lr, r4, #1
	ldr	r3, [r5, #28]
	cmp	r2, r0
	moveq	ip, lr
	addne	ip, lr, #1
	ldr	r4, [fp, #-128]
	ldr	r0, [r5]
	ldr	lr, [fp, #-156]
	cmp	r3, r4
	moveq	r1, ip
	addne	r1, ip, #1
	ldr	r4, [r5, #4]
	ldr	ip, [fp, #-152]
	cmp	r0, lr
	moveq	r2, r1
	addne	r2, r1, #1
	ldr	lr, [r5, #40]
	ldr	r1, [fp, #-116]
	cmp	r4, ip
	moveq	r3, r2
	addne	r3, r2, #1
	ldr	ip, [r5, #44]
	ldr	r2, [fp, #-112]
	cmp	lr, r1
	moveq	r0, r3
	addne	r0, r3, #1
	ldr	r1, [r5, #56]
	ldr	r3, [fp, #-100]
	cmp	ip, r2
	moveq	r4, r0
	addne	r4, r0, #1
	ldr	r2, [r5, #72]
	ldr	r0, [fp, #-84]
	cmp	r1, r3
	moveq	lr, r4
	addne	lr, r4, #1
	ldr	r6, [fp, #-80]
	ldr	r3, [r5, #76]
	cmp	r2, r0
	moveq	ip, lr
	addne	ip, lr, #1
	ldr	r4, [fp, #-76]
	ldr	r0, [r5, #80]
	cmp	r3, r6
	moveq	r1, ip
	addne	r1, ip, #1
	ldr	lr, [r5, #84]
	ldr	ip, [fp, #-72]
	cmp	r0, r4
	moveq	r2, r1
	addne	r2, r1, #1
	ldr	r0, [r5, #88]
	ldr	r1, [fp, #-68]
	cmp	lr, ip
	moveq	r3, r2
	addne	r3, r2, #1
	cmp	r0, r1
	moveq	r0, r3
	addne	r0, r3, #1
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L71:
	.align	2
.L70:
	.word	.LANCHOR0
	.fnend
	.size	AIPIsChnAttrChange, .-AIPIsChnAttrChange
	.align	2
	.global	AIPCreateChn
	.type	AIPCreateChn, %function
AIPCreateChn:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #248
	sub	sp, sp, #248
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r3, .L140
	sub	r1, fp, #156
	mov	r4, #0
	mov	r6, r0
	str	r4, [fp, #-264]
	ldr	r5, [r3, r0, asl #2]
	str	r4, [fp, #-260]
	str	r4, [fp, #-256]
	str	r4, [fp, #-252]
	str	r4, [fp, #-248]
	bl	AIPGetChnCreateAttr
	subs	r7, r0, #0
	movne	r0, r4
	bne	.L136
	mov	r1, #292
	mov	r0, #26
	bl	HI_ADSP_MALLOC
	subs	r4, r0, #0
	beq	.L74
	mov	r1, #292
	bl	__memzero
	sub	r1, fp, #156
	mov	r2, #128
	mov	r0, r4
	bl	memcpy
	str	r6, [r4, #236]
	sub	r1, fp, #120
	sub	r0, fp, #252
	bl	RBUF_Create_EXT
	ldr	r3, [fp, #-252]
	cmp	r3, #0
	beq	.L74
	ldr	r2, [fp, #-128]
	str	r3, [r4, #128]
	cmp	r2, #0
	beq	.L137
	str	r7, [r5, #60]
	ldr	r3, [r5, #64]
	bfi	r3, r7, #0, #16
	str	r3, [r5, #64]
.L76:
	mov	r1, #768
	mov	r0, #26
	bl	HI_ADSP_MALLOC
	cmp	r0, #0
	str	r0, [r4, #216]
	beq	.L74
	ldr	r3, [fp, #-128]
	cmp	r3, #0
	bne	.L78
	ldr	ip, [fp, #-132]
	ldr	r2, [fp, #-76]
	cmp	ip, r2
	beq	.L79
	cmp	ip, #32000
	beq	.L80
	bls	.L138
	movw	r3, #22664
	movt	r3, 1
	cmp	ip, r3
	beq	.L80
	bhi	.L84
	movw	r3, #44100
	cmp	ip, r3
	bne	.L80
	ldr	lr, [fp, #-80]
	mov	r0, #2
	ldr	r3, [fp, #-84]
	sub	r1, fp, #240
	str	r0, [r4, #240]
	sub	r0, fp, #244
	str	ip, [fp, #-240]
	str	r2, [fp, #-236]
	str	lr, [fp, #-228]
	str	r3, [fp, #-232]
	bl	iMedia_ASRC_GetSize
	cmp	r0, #0
	bne	.L74
	ldr	r1, [fp, #-244]
	mov	r0, #26
	bl	HI_ADSP_MALLOC
	cmp	r0, #0
	str	r0, [r4, #148]
	beq	.L74
	ldr	r7, [fp, #-80]
	mov	r1, r0
	ldr	r6, [fp, #-84]
	sub	r3, fp, #224
	ldr	lr, [fp, #-132]
	sub	r0, fp, #264
	ldr	ip, [fp, #-76]
	ldr	r2, [fp, #-244]
	str	r7, [fp, #-212]
	str	r6, [fp, #-216]
	str	lr, [fp, #-224]
	str	ip, [fp, #-220]
	bl	iMedia_ASRC_Init
	cmp	r0, #0
	bne	.L74
	ldr	r0, [fp, #-264]
	b	.L91
.L138:
	movw	r3, #12000
	cmp	ip, r3
	beq	.L80
.L80:
	mov	r3, #1
	mov	r1, r2
	str	r3, [r4, #240]
	mov	r0, ip
	ldr	r3, [fp, #-84]
	mov	ip, #0
	ldr	r2, [fp, #-80]
	str	ip, [sp]
	bl	ResamplerCreate
	cmp	r0, #0
	str	r0, [fp, #-264]
	beq	.L74
.L91:
	ldr	r2, [fp, #-76]
	str	r0, [r4, #140]
.L79:
	ldr	ip, [fp, #-80]
	mov	r1, r2
	ldr	r3, [fp, #-84]
	sub	r0, fp, #260
	str	ip, [sp]
	bl	LSRC_Create
	ldr	r3, [fp, #-260]
	cmp	r3, #0
	beq	.L74
	str	r3, [r4, #136]
	mov	r6, #0
	str	r6, [r5, #80]
	ldr	r3, [r4]
	cmp	r3, r6
	beq	.L78
	ldr	r3, [fp, #-136]
	sub	r0, fp, #256
	ldr	r2, [fp, #-140]
	ldr	r1, [fp, #-132]
	bl	FADE_Create
	ldr	r3, [fp, #-256]
	cmp	r3, r6
	beq	.L74
	str	r3, [r4, #144]
	str	r6, [r4, #204]
.L78:
	mov	r3, #0
	mov	r2, #3
	mov	r1, #256
	str	r3, [r4, #156]
	str	r3, [r4, #160]
	str	r3, [r4, #164]
	str	r3, [r4, #188]
	str	r1, [r4, #268]
	str	r2, [r4, #272]
	ldr	r1, [r4, #72]
	ldr	r0, [r4, #76]
	bl	UTIL_CalcFrameSize
	ldr	r3, [r4, #80]
	movw	r2, #19923
	movw	r1, #48000
	cmp	r3, r1
	movt	r2, 4194
	add	r3, r3, r3, lsl #2
	umull	r2, r3, r3, r2
	mov	r3, r3, lsr #6
	beq	.L139
	tst	r3, #3
	bicne	r3, r3, #3
	addne	r3, r3, #4
.L90:
	mul	r3, r0, r3
	ldr	r1, [r4, #72]
	ldr	r0, [r4, #76]
	str	r3, [r4, #220]
	bl	UTIL_CalcFrameSize
	ldr	r2, [r4, #88]
	ldr	r3, [r4, #80]
	movw	ip, #19923
	movt	ip, 4194
	ldr	r1, [r4, #72]
	mul	r3, r3, r2
	umull	r2, r3, r3, ip
	mov	r3, r3, lsr #6
	mul	r3, r3, r0
	ldr	r0, [r4, #76]
	str	r3, [r4, #232]
	bl	UTIL_CalcFrameSize
	ldr	r1, [r4, #16]
	str	r0, [r4, #224]
	ldr	r0, [r4, #20]
	bl	UTIL_CalcFrameSize
	mov	r3, #1
	mov	r1, r3
	str	r3, [r4, #152]
	mov	r2, #8
	str	r0, [r4, #228]
	ldr	r0, [r4, #144]
	bl	FADE_Active
	mov	r0, r4
.L136:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L137:
	sub	r0, fp, #248
	sub	r1, fp, #64
	bl	RBUF_Create
	ldr	r0, [fp, #-248]
	cmp	r0, #0
	beq	.L74
	str	r0, [r4, #132]
	sub	r1, fp, #192
	bl	RBUF_QueryInfo
	ldrh	r2, [fp, #-180]
	ldr	r3, [r5, #64]
	bfi	r3, r2, #0, #16
	str	r3, [r5, #64]
	b	.L76
.L139:
	tst	r3, #255
	bicne	r3, r3, #255
	addne	r3, r3, #256
	b	.L90
.L84:
	b	.L80
.L74:
	mov	r0, r4
	bl	AIPDestroyChn
	mov	r0, #0
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L141:
	.align	2
.L140:
	.word	.LANCHOR0
	.fnend
	.size	AIPCreateChn, .-AIPCreateChn
	.align	2
	.global	AIPFlushChnCtx
	.type	AIPFlushChnCtx, %function
AIPFlushChnCtx:
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
	ldr	r0, [r0, #140]
	cmp	r0, #0
	beq	.L143
	ldr	r3, [r4, #240]
	cmp	r3, #2
	beq	.L156
	bl	ResampleFlush
.L143:
	ldr	r0, [r4, #136]
	cmp	r0, #0
	beq	.L145
	bl	LSRC_Flush
.L145:
	ldr	r0, [r4, #144]
	mov	r3, #0
	str	r3, [r4, #212]
	cmp	r0, r3
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	mov	r2, #8
	mov	r1, #1
	bl	FADE_Active
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L156:
	bl	iMedia_ASRC_Flush
	b	.L143
	.fnend
	.size	AIPFlushChnCtx, .-AIPFlushChnCtx
	.align	2
	.global	AIPFlushChnRufIn
	.type	AIPFlushChnRufIn, %function
AIPFlushChnRufIn:
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
	ldr	r0, [r0, #128]
	cmp	r0, #0
	ldmeqfd	sp, {fp, sp, pc}
	bl	RBUF_Flush
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	AIPFlushChnRufIn, .-AIPFlushChnRufIn
	.align	2
	.global	AIPFlushChnFifo
	.type	AIPFlushChnFifo, %function
AIPFlushChnFifo:
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
	ldr	r0, [r0, #132]
	cmp	r0, #0
	ldmeqfd	sp, {fp, sp, pc}
	bl	RBUF_Flush
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	AIPFlushChnFifo, .-AIPFlushChnFifo
	.align	2
	.global	AIPFlushChn
	.type	AIPFlushChn, %function
AIPFlushChn:
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
	tst	r1, #1
	mov	r4, r1
	mov	r5, r0
	bne	.L186
.L168:
	tst	r4, #2
	beq	.L169
	ldr	r0, [r5, #128]
	cmp	r0, #0
	beq	.L169
	bl	RBUF_Flush
.L169:
	tst	r4, #4
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r0, [r5, #132]
	cmp	r0, #0
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	bl	RBUF_Flush
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L186:
	bl	AIPFlushChnCtx
	b	.L168
	.fnend
	.size	AIPFlushChn, .-AIPFlushChn
	.align	2
	.global	AIPWriteMuteFrame
	.type	AIPWriteMuteFrame, %function
AIPWriteMuteFrame:
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
	ldr	r3, [r0, #224]
	ldr	r4, [r0, #220]
	mov	r5, r0
	add	r4, r3, r4
	bl	AOE_GetWKBuf
	cmp	r4, #0
	mov	r6, r0
	bne	.L195
.L188:
	ldr	r0, [r5, #132]
	cmp	r0, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	bl	RBUF_QueryFree
	cmp	r4, r0
	ldmcsfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	mov	r2, r4
	mov	r1, r6
	ldr	r0, [r5, #132]
	bl	RBUF_WriteData
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L195:
	mov	r1, r4
	bl	__memzero
	b	.L188
	.fnend
	.size	AIPWriteMuteFrame, .-AIPWriteMuteFrame
	.align	2
	.global	AIPGetChnCmd
	.type	AIPGetChnCmd, %function
AIPGetChnCmd:
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
	ldr	r3, .L206
	ldr	r3, [r3, r0, asl #2]
	ldr	r2, [r3, #8]
	tst	r2, #8
	movne	r0, #4
	beq	.L205
.L197:
	str	r0, [r1]
	ldmfd	sp, {fp, sp, pc}
.L205:
	ldr	r2, [r3, #8]
	and	r2, r2, #3
	cmp	r2, #3
	ldrls	pc, [pc, r2, asl #2]
	b	.L198
.L199:
	.word	.L204
	.word	.L200
	.word	.L201
	.word	.L202
.L204:
	mov	r0, #0
	b	.L197
.L202:
	mov	r0, #3
	b	.L197
.L201:
	mov	r0, #2
	b	.L197
.L200:
	mov	r0, #1
	b	.L197
.L198:
	ldr	r2, [r3, #8]
	mov	ip, #4
	mov	r0, ip
	bfi	r2, ip, #4, #4
	str	r2, [r3, #8]
	ldr	r2, [r3, #8]
	orr	r2, r2, #8
	str	r2, [r3, #8]
	b	.L197
.L207:
	.align	2
.L206:
	.word	.LANCHOR0
	.fnend
	.size	AIPGetChnCmd, .-AIPGetChnCmd
	.align	2
	.global	AIPAckChnCmd
	.type	AIPAckChnCmd, %function
AIPAckChnCmd:
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
	ldr	r3, .L210
	ldr	r3, [r3, r0, asl #2]
	ldr	r2, [r3, #8]
	tst	r2, #8
	ldmnefd	sp, {fp, sp, pc}
	ldr	r2, [r3, #8]
	bfi	r2, r1, #4, #4
	str	r2, [r3, #8]
	ldr	r2, [r3, #8]
	orr	r2, r2, #8
	str	r2, [r3, #8]
	ldmfd	sp, {fp, sp, pc}
.L211:
	.align	2
.L210:
	.word	.LANCHOR0
	.fnend
	.size	AIPAckChnCmd, .-AIPAckChnCmd
	.align	2
	.global	IsDataEnoughForFadeout
	.type	IsDataEnoughForFadeout, %function
IsDataEnoughForFadeout:
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
	mov	r4, r0
	ldr	r0, [r0, #128]
	bl	RBUF_QueryBusy
	ldr	r1, [r4, #16]
	mov	r5, r0
	ldr	r0, [r4, #20]
	bl	UTIL_CalcFrameSize
	ldr	r2, [r4, #24]
	mov	r1, r0
	mov	r0, r5
	bl	UTIL_LatencyMs
	mov	r5, r0
	ldr	r0, [r4, #132]
	bl	RBUF_QueryBusy
	ldr	r1, [r4, #72]
	mov	r6, r0
	ldr	r0, [r4, #76]
	bl	UTIL_CalcFrameSize
	ldr	r2, [r4, #80]
	mov	r1, r0
	mov	r0, r6
	bl	UTIL_LatencyMs
	ldr	r1, [r4, #80]
	mov	r6, r0
	ldr	r0, [r4, #212]
	bl	__aeabi_uidiv
	mov	r3, #1000
	mla	r0, r3, r0, r6
	cmp	r0, #4
	cmpls	r5, #4
	movls	r0, #1
	movhi	r0, #0
	eor	r0, r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	IsDataEnoughForFadeout, .-IsDataEnoughForFadeout
	.align	2
	.global	AIPStopChnCmdProc
	.type	AIPStopChnCmdProc, %function
AIPStopChnCmdProc:
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
	ldr	r6, .L223
	add	r3, r0, #8
	mov	r7, r0
	ldr	r5, [r6, r0, asl #2]
	ldr	r4, [r6, r3, asl #2]
	cmp	r4, #0
	cmpne	r5, #0
	moveq	r8, #1
	movne	r8, #0
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	ldr	r3, [r4, #152]
	sub	r3, r3, #1
	cmp	r3, #1
	movhi	r2, r5
	bls	.L221
.L216:
	ldr	r3, [r2, #8]
	ubfx	r3, r3, #3, #1
	cmp	r3, #0
	ldmnefd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	ldr	r1, [r2, #8]
	bfi	r1, r3, #4, #4
	str	r1, [r2, #8]
	ldr	r3, [r2, #8]
	orr	r3, r3, #8
	str	r3, [r2, #8]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L221:
	mov	r0, r4
	bl	IsDataEnoughForFadeout
	cmp	r0, #0
	bne	.L222
	mov	r1, #4
	mov	r0, r4
	bl	AIPFlushChn
	mov	r3, #1
	str	r3, [r4, #244]
.L218:
	mov	r1, #3
	mov	r0, r4
	bl	AIPFlushChn
	mov	r0, r4
	bl	AIPWriteMuteFrame
	mov	r3, #0
	ldr	r2, [r6, r7, asl #2]
	str	r3, [r4, #152]
	str	r3, [r5, #80]
	b	.L216
.L222:
	mov	r0, r4
	bl	AIPFadeoutChnData
	str	r8, [r4, #244]
	b	.L218
.L224:
	.align	2
.L223:
	.word	.LANCHOR0
	.fnend
	.size	AIPStopChnCmdProc, .-AIPStopChnCmdProc
	.align	2
	.global	AIFlushChnCmdProc
	.type	AIFlushChnCmdProc, %function
AIFlushChnCmdProc:
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
	ldr	r5, .L231
	add	r3, r0, #8
	mov	r6, r0
	ldr	r4, [r5, r3, asl #2]
	cmp	r4, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	r7, [r4, #152]
	cmp	r7, #1
	beq	.L230
.L228:
	ldr	r2, [r5, r6, asl #2]
	ldr	r3, [r2, #8]
	ubfx	r3, r3, #3, #1
	cmp	r3, #0
	ldmnefd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	r1, [r2, #8]
	bfi	r1, r3, #4, #4
	str	r1, [r2, #8]
	ldr	r3, [r2, #8]
	orr	r3, r3, #8
	str	r3, [r2, #8]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L230:
	mov	r0, r4
	bl	AIPFadeoutChnData
	mov	r1, #3
	mov	r0, r4
	bl	AIPFlushChn
	mov	r0, r4
	bl	AIPWriteMuteFrame
	mov	r1, r7
	ldr	r0, [r4, #144]
	mov	r2, #8
	bl	FADE_Active
	b	.L228
.L232:
	.align	2
.L231:
	.word	.LANCHOR0
	.fnend
	.size	AIFlushChnCmdProc, .-AIFlushChnCmdProc
	.align	2
	.global	AIPPauseChnCmdProc
	.type	AIPPauseChnCmdProc, %function
AIPPauseChnCmdProc:
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
	ldr	r5, .L239
	add	r3, r0, #8
	mov	r6, r0
	ldr	r4, [r5, r3, asl #2]
	cmp	r4, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	r7, [r4, #152]
	cmp	r7, #1
	beq	.L238
.L236:
	ldr	r2, [r5, r6, asl #2]
	ldr	r3, [r2, #8]
	ubfx	r3, r3, #3, #1
	cmp	r3, #0
	ldmnefd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	r1, [r2, #8]
	bfi	r1, r3, #4, #4
	str	r1, [r2, #8]
	ldr	r3, [r2, #8]
	orr	r3, r3, #8
	str	r3, [r2, #8]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L238:
	mov	r0, r4
	bl	AIPFadeoutChnData
	mov	r1, r7
	mov	r0, r4
	bl	AIPFlushChn
	mov	r3, #2
	str	r3, [r4, #152]
	b	.L236
.L240:
	.align	2
.L239:
	.word	.LANCHOR0
	.fnend
	.size	AIPPauseChnCmdProc, .-AIPPauseChnCmdProc
	.align	2
	.global	AIPStartChnCmdProc
	.type	AIPStartChnCmdProc, %function
AIPStartChnCmdProc:
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
	ldr	r4, .L254
	add	r7, r0, #8
	mov	r6, r0
	ldr	r5, [r4, r7, asl #2]
	cmp	r5, #0
	beq	.L250
	ldr	r3, [r5, #152]
	cmp	r3, #0
	beq	.L252
	cmp	r3, #2
	beq	.L251
.L246:
	ldr	r2, [r4, r6, asl #2]
	ldr	r3, [r2, #8]
	ubfx	r3, r3, #3, #1
	cmp	r3, #0
	ldmnefd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	r1, [r2, #8]
	bfi	r1, r3, #4, #4
	str	r1, [r2, #8]
	ldr	r3, [r2, #8]
	orr	r3, r3, #8
	str	r3, [r2, #8]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L252:
	bl	AIPIsChnAttrChange
	cmp	r0, #0
	bne	.L253
.L251:
	mov	r1, #1
	ldr	r0, [r5, #144]
	str	r1, [r5, #152]
	mov	r2, #8
	bl	FADE_Active
	ldr	r0, [r4, r7, asl #2]
.L243:
	cmp	r0, #0
	bne	.L246
	ldr	r3, [r4, r6, asl #2]
	ldr	r2, [r3, #8]
	tst	r2, #8
	ldmnefd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	r2, [r3, #8]
	mov	r1, #1
	bfi	r2, r1, #4, #4
	str	r2, [r3, #8]
	ldr	r2, [r3, #8]
	orr	r2, r2, #8
	str	r2, [r3, #8]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L253:
	ldr	r0, [r4, r7, asl #2]
	bl	AIPDestroyChn
	mov	r0, r6
.L250:
	bl	AIPCreateChn
	str	r0, [r4, r7, asl #2]
	b	.L243
.L255:
	.align	2
.L254:
	.word	.LANCHOR0
	.fnend
	.size	AIPStartChnCmdProc, .-AIPStartChnCmdProc
	.align	2
	.global	AIP_Init
	.type	AIP_Init, %function
AIP_Init:
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
	ldr	r5, .L259
	mov	r4, r0
	mov	r7, #121
	add	r6, r5, #32
.L257:
	mov	r1, #96
	mov	r0, r4
	str	r4, [r5, #4]!
	bl	__memzero
	ldr	r3, [r4, #8]
	cmp	r5, r6
	mov	r1, #5
	mov	r2, #0
	orr	r3, r3, #8
	str	r3, [r4, #8]
	ldr	r3, [r4, #8]
	bfi	r3, r7, #8, #7
	str	r3, [r4, #8]
	ldr	r3, [r4]
	bfi	r3, r1, #11, #3
	str	r3, [r4], #96
	str	r2, [r5, #32]
	bne	.L257
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L260:
	.align	2
.L259:
	.word	.LANCHOR0-4
	.fnend
	.size	AIP_Init, .-AIP_Init
	.align	2
	.global	AIP_DeInit
	.type	AIP_DeInit, %function
AIP_DeInit:
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
	ldr	r4, .L264
	mov	r6, #0
	add	r5, r4, #32
.L262:
	ldr	r0, [r4, #4]!
	bl	AIPDestroyChn
	cmp	r4, r5
	str	r6, [r4]
	bne	.L262
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L265:
	.align	2
.L264:
	.word	.LANCHOR0+28
	.fnend
	.size	AIP_DeInit, .-AIP_DeInit
	.align	2
	.global	AIP_Process
	.type	AIP_Process, %function
AIP_Process:
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
	ldr	r6, .L384
	mov	r5, #0
	sub	r7, r6, #28
.L312:
	sub	r1, fp, #72
	mov	r0, r5
	bl	AIPGetChnCmd
	cmp	r0, #4
	beq	.L267
	ldr	r3, [fp, #-72]
	cmp	r3, #3
	ldrls	pc, [pc, r3, asl #2]
	b	.L267
.L269:
	.word	.L268
	.word	.L270
	.word	.L271
	.word	.L272
.L272:
	mov	r0, r5
	bl	AIFlushChnCmdProc
.L267:
	ldr	r4, [r6, #4]!
	cmp	r4, #0
	beq	.L273
	ldr	r3, [r4, #152]
	cmp	r3, #1
	beq	.L373
.L273:
	add	r5, r5, #1
	cmp	r5, #8
	bne	.L312
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L271:
	mov	r0, r5
	bl	AIPPauseChnCmdProc
	b	.L267
.L268:
	mov	r0, r5
	bl	AIPStartChnCmdProc
	b	.L267
.L270:
	mov	r0, r5
	bl	AIPStopChnCmdProc
	b	.L267
.L373:
	ldr	r2, [r4, #28]
	cmp	r2, #0
	bne	.L273
	ldr	r3, [r6, #-32]
	str	r2, [r4, #156]
	ldr	r2, [r3, #48]
	uxtb	r2, r2
	str	r2, [r4, #160]
	ldr	r2, [r3, #48]
	ubfx	r2, r2, #8, #8
	str	r2, [r4, #164]
	ldr	r2, [r3, #76]
	uxtb	r2, r2
	str	r2, [r4, #176]
	ldr	r2, [r3, #76]
	tst	r2, #2048
	ldr	r2, [r3, #76]
	ubfxeq	r2, r2, #8, #3
	streq	r2, [r4, #180]
	beq	.L275
	tst	r2, #2048
	ldrne	r2, [r3, #76]
	ubfxne	r2, r2, #8, #3
	rsbne	r2, r2, #0
	strne	r2, [r4, #180]
.L275:
	ldr	r2, [r3, #48]
	ubfx	r2, r2, #16, #1
	str	r2, [r4, #184]
	ldr	r2, [r3, #48]
	ubfx	r2, r2, #17, #3
	str	r2, [r4, #188]
	ldr	r2, [r3, #48]
	ubfx	r2, r2, #20, #1
	str	r2, [r4, #192]
	ldr	r2, [r3, #48]
	mov	r2, r2, lsr #24
	add	r2, r2, #32
	str	r2, [r4, #268]
	ldr	r2, [r3, #48]
	ubfx	r2, r2, #21, #3
	str	r2, [r4, #272]
	ldr	r2, [r3, #8]
	tst	r2, #1610612736
	ldr	r2, [r3, #8]
	ubfxeq	r2, r2, #24, #5
	streq	r2, [r4, #208]
	bne	.L374
.L277:
	ldr	r2, [r3]
	ubfx	r2, r2, #14, #1
	str	r2, [r4, #4]
	ldr	r3, [r3, #4]
	ubfx	r3, r3, #22, #1
	str	r3, [r4, #248]
	cmp	r3, #1
	beq	.L279
	ldr	r8, [r4, #212]
	ldr	r1, [r4, #224]
	ldr	r9, [r4, #220]
	mul	r3, r8, r1
	cmp	r3, r9
	bcs	.L375
	mov	r0, r9
	bl	__aeabi_uidiv
	ldr	r2, [r4, #80]
	ldr	ip, [r4, #136]
	ldr	lr, [r4, #76]
	ldr	r3, [r4, #72]
	mov	r1, r2
	str	lr, [sp]
	rsb	r8, r8, r0
	mov	r0, ip
	bl	LSRC_UpdateChange
	ldr	r1, [r4, #208]
	ldr	r0, [r4, #136]
	bl	LSRC_SetSpeedAdjust
	mov	r1, r8
	ldr	r0, [r4, #136]
	bl	LSRC_GetMinInputNum
	mov	r3, r0
	ldr	r0, [r4, #140]
	cmp	r0, #0
	beq	.L283
	ldr	r2, [r4, #240]
	cmp	r2, #2
	bne	.L284
	ldr	r0, [r4, #24]
	ldr	r1, [r4, #80]
	mul	r0, r0, r3
	bl	__aeabi_uidiv
	subs	r3, r0, #0
	addne	r3, r3, #1
	beq	.L285
.L283:
	tst	r3, #3
	bicne	r3, r3, #3
	addne	r3, r3, #4
.L285:
	ldr	r8, [r4, #228]
	ldr	r0, [r4, #128]
	mul	r8, r8, r3
	bl	RBUF_QueryBusy
	cmp	r8, r0
	bcs	.L279
	cmp	r8, #0
	beq	.L279
	ldr	r0, [r4, #132]
	cmp	r0, #0
	beq	.L279
	mov	r1, r9
	bl	RBUF_CheckFree
	cmp	r0, #0
	beq	.L279
	cmp	r9, #0
	beq	.L279
	bl	AOE_GetWKBuf
	str	r8, [fp, #-68]
	mov	r9, r0
	mov	r0, r8
	str	r9, [fp, #-72]
	ldr	r1, [r4, #228]
	bl	__aeabi_uidiv
	mov	r2, r8
	mov	r1, r9
	str	r0, [fp, #-64]
	ldr	r3, [r4, #20]
	str	r3, [fp, #-56]
	ldr	r3, [r4, #16]
	str	r3, [fp, #-60]
	ldr	r3, [r4, #24]
	str	r3, [fp, #-52]
	ldr	r3, [r4, #28]
	str	r3, [fp, #-48]
	ldr	r0, [r4, #128]
	bl	RBUF_ReadDataDma
	ldr	r8, [r4, #28]
	cmp	r8, #0
	beq	.L376
.L288:
	ldr	r3, [r4, #184]
	cmp	r3, #1
	beq	.L377
.L307:
	ldr	r2, [r4, #224]
	ldr	r3, [r4, #212]
	ldr	r8, [r4, #220]
	mul	r2, r3, r2
	cmp	r2, #0
	bne	.L378
.L308:
	cmp	r8, #0
	ldr	r3, [fp, #-68]
	beq	.L310
	cmp	r8, r3
	movcs	r8, r3
	cmp	r8, #0
	beq	.L310
	mov	r2, r8
	ldr	r1, [fp, #-72]
	ldr	r0, [r4, #132]
	bl	RBUF_WriteData
	ldr	r3, [fp, #-68]
.L310:
	subs	r9, r3, r8
	beq	.L311
	ldr	r1, [fp, #-72]
	mov	r2, r9
	ldr	r0, [r4, #216]
	add	r1, r1, r8
	bl	memcpy
.L311:
	mov	r0, r9
	ldr	r1, [r4, #224]
	bl	__aeabi_uidiv
	str	r0, [r4, #212]
.L279:
	ldr	r4, [r6]
	ldr	r8, [r6, #-32]
	ldr	r0, [r4, #132]
	bl	RBUF_QueryBusy
	ldr	r2, [r4, #80]
	ldr	r1, [r4, #224]
	bl	UTIL_LatencyMs
	ldr	r3, [r8, #4]
	bfi	r3, r0, #16, #6
	str	r3, [r8, #4]
	b	.L273
.L374:
	ubfx	r2, r2, #29, #2
	cmp	r2, #1
	ldreq	r2, [r3, #8]
	ubfxeq	r2, r2, #24, #5
	rsbeq	r2, r2, #0
	streq	r2, [r4, #208]
	b	.L277
.L375:
	ldr	r0, [r4, #132]
	cmp	r0, #0
	beq	.L279
	mov	r1, r9
	bl	RBUF_CheckFree
	cmp	r0, #0
	beq	.L279
	cmp	r9, #0
	beq	.L279
	ldr	r2, [r4, #220]
	ldr	r1, [r4, #216]
	ldr	r0, [r4, #132]
	bl	RBUF_WriteData
	ldr	r1, [r4, #224]
	ldr	r0, [r4, #220]
	bl	__aeabi_uidiv
	ldr	r3, [r4, #212]
	rsb	r0, r0, r3
	str	r0, [r4, #212]
	b	.L279
.L376:
	ldr	r9, [r4, #76]
	ldr	r3, [fp, #-56]
	ldr	r10, [r4, #72]
	cmp	r9, r3
	beq	.L289
	bls	.L290
	bl	AOE_GetWKBuf
	sub	r2, fp, #72
	mov	r1, r0
	mov	r0, r9
	bl	UTIL_UpmixPcmData
.L289:
	ldr	r3, [fp, #-60]
	cmp	r10, r3
	beq	.L291
	bl	AOE_GetWKBuf
	sub	r2, fp, #72
	mov	r1, r0
	mov	r0, r10
	bl	UTIL_UnifyBitDepthPcmData
.L291:
	ldr	r3, [r4, #140]
	ldr	r10, [r4, #80]
	cmp	r3, #0
	subeq	r9, fp, #92
	beq	.L292
	bl	AOE_GetWKBuf
	ldr	r3, [r4, #240]
	cmp	r3, #2
	beq	.L379
	ldr	lr, [fp, #-52]
	mov	r2, r0
	ldr	r3, [fp, #-64]
	mov	r9, #1
	str	r0, [fp, #-96]
	ldr	r1, [fp, #-72]
	ldr	r0, [r4, #140]
	str	r9, [sp, #8]
	sub	r9, fp, #92
	str	r10, [sp, #4]
	str	lr, [sp]
	bl	ResamplerProcessFrame
	ldr	r3, [fp, #-56]
	ldr	ip, [fp, #-96]
	mov	r2, r0
.L294:
	mov	r0, r3
	ldr	r1, [fp, #-60]
	str	ip, [fp, #-72]
	str	r2, [fp, #-64]
	str	r10, [fp, #-52]
	bl	UTIL_CalcFrameSize
	ldr	r3, [fp, #-64]
	mul	r0, r3, r0
	str	r0, [fp, #-68]
.L292:
	ldr	r0, [r4, #136]
	ldr	r3, [r4, #236]
	cmp	r0, #0
	ldr	r10, [r7, r3, asl #2]
	beq	.L296
	bl	LSRC_CheckDoSRC
	cmp	r0, #0
	bne	.L380
.L296:
	ldr	r3, [r4, #192]
	cmp	r3, #1
	beq	.L381
.L298:
	mov	r2, #20
	add	r1, r4, #156
	mov	r0, r9
	bl	memcpy
	ldr	r3, [r4, #176]
	ldr	r2, [fp, #-88]
	ldr	r1, [fp, #-76]
	add	r2, r3, r2
	cmp	r2, #120
	subhi	r8, r2, #121
	strhi	r8, [fp, #-88]
	movls	r2, #0
	strls	r2, [fp, #-88]
	ldr	r2, [fp, #-84]
	add	r3, r3, r2
	ldr	r2, [fp, #-80]
	cmp	r3, #120
	subhi	r3, r3, #121
	movls	r3, #0
	cmp	r8, #121
	str	r3, [fp, #-84]
	ldr	r3, [r4, #180]
	add	r2, r3, r2
	add	r3, r3, r1
	str	r2, [fp, #-80]
	str	r3, [fp, #-76]
	beq	.L382
.L303:
	mov	r2, r9
	mov	r1, #0
	sub	r0, fp, #72
	bl	UTIL_LRGainProcess
.L304:
	ldr	r1, [r4, #188]
	ldr	r2, [r4, #72]
	sub	r3, r1, #1
	cmp	r3, #6
	bls	.L383
.L305:
	ldr	r0, [r4, #144]
	cmp	r0, #0
	beq	.L288
	ldr	r2, [fp, #-60]
	ldr	r1, [fp, #-52]
	ldr	r3, [fp, #-56]
	bl	FADE_Flush
	ldr	r2, [fp, #-64]
	ldr	r1, [fp, #-72]
	ldr	r0, [r4, #144]
	bl	FADE_InProcess
	b	.L288
.L377:
	ldr	r1, [fp, #-68]
	ldr	r0, [fp, #-72]
	cmp	r1, #0
	beq	.L307
	bl	__memzero
	b	.L307
.L284:
	mov	r1, r3
	bl	ResamplerGetMinInputNum
	mov	r3, r0
	b	.L283
.L378:
	ldr	r1, [r4, #216]
	rsb	r8, r2, r8
	ldr	r0, [r4, #132]
	bl	RBUF_WriteData
	b	.L308
.L382:
	ldr	r1, [fp, #-84]
	cmp	r2, #0
	cmpeq	r1, #121
	movne	r2, #1
	moveq	r2, #0
	cmp	r3, #0
	moveq	r3, r2
	orrne	r3, r2, #1
	cmp	r3, #0
	bne	.L303
	b	.L304
.L383:
	sub	r0, fp, #72
	bl	UTIL_ChannelModeProcess
	b	.L305
.L290:
	bl	AOE_GetWKBuf
	sub	r2, fp, #72
	mov	r1, r0
	mov	r0, r9
	bl	UTIL_DownmixPcmData
	b	.L289
.L380:
	ldr	r3, [fp, #-64]
	str	r3, [fp, #-96]
	bl	AOE_GetWKBuf
	ldr	r3, [fp, #-96]
	ldr	r1, [fp, #-72]
	mov	r2, r0
	str	r0, [fp, #-96]
	ldr	r0, [r4, #136]
	bl	LSRC_ProcessFrame
	ldr	ip, [fp, #-96]
	ldr	r1, [fp, #-60]
	str	ip, [fp, #-72]
	str	r0, [fp, #-64]
	ldr	r0, [fp, #-56]
	bl	UTIL_CalcFrameSize
	ldr	r3, [fp, #-64]
	mul	r0, r3, r0
	str	r0, [fp, #-68]
	ldr	r3, [r10, #80]
	add	r3, r3, #1
	str	r3, [r10, #80]
	b	.L296
.L379:
	ldr	r1, [fp, #-56]
	sub	r9, fp, #92
	ldr	r3, [fp, #-64]
	ldr	r2, [fp, #-72]
	str	r0, [fp, #-88]
	mul	r3, r3, r1
	str	r2, [fp, #-92]
	str	r0, [fp, #-100]
	str	r3, [fp, #-84]
	bl	kernel_neon_begin
	mov	r1, r9
	ldr	r0, [r4, #140]
	bl	iMedia_ASRC_Apply
	bl	kernel_neon_end
	ldr	r3, [fp, #-56]
	ldr	r0, [fp, #-80]
	mov	r1, r3
	str	r3, [fp, #-96]
	bl	__aeabi_uidiv
	ldr	r3, [fp, #-96]
	ldr	ip, [fp, #-100]
	mov	r2, r0
	b	.L294
.L381:
	add	r1, r4, #252
	sub	r0, fp, #72
	bl	UTIL_DRE_16BIT_Process
	b	.L298
.L385:
	.align	2
.L384:
	.word	.LANCHOR0+28
	.fnend
	.size	AIP_Process, .-AIP_Process
	.align	2
	.global	AIP_GetChnStatus
	.type	AIP_GetChnStatus, %function
AIP_GetChnStatus:
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
	ldr	r3, .L389
	add	r0, r0, #8
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	streq	r3, [r1]
	ldrne	r2, [r3, #152]
	strne	r2, [r1]
	ldrne	r2, [r3, #4]
	strne	r2, [r1, #4]
	ldrne	r3, [r3, #244]
	strne	r3, [r1, #8]
	ldmfd	sp, {fp, sp, pc}
.L390:
	.align	2
.L389:
	.word	.LANCHOR0
	.fnend
	.size	AIP_GetChnStatus, .-AIP_GetChnStatus
	.align	2
	.global	AIP_FlushCutoffFlag
	.type	AIP_FlushCutoffFlag, %function
AIP_FlushCutoffFlag:
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
	ldr	r3, .L396
	add	r0, r0, #8
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	movne	r2, #0
	strne	r2, [r3, #244]
	ldmfd	sp, {fp, sp, pc}
.L397:
	.align	2
.L396:
	.word	.LANCHOR0
	.fnend
	.size	AIP_FlushCutoffFlag, .-AIP_FlushCutoffFlag
	.align	2
	.global	AIP_QueryFiFoInfo
	.type	AIP_QueryFiFoInfo, %function
AIP_QueryFiFoInfo:
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
	ldr	r3, .L405
	add	r2, r0, #8
	mov	r0, r1
	ldr	r3, [r3, r2, asl #2]
	cmp	r3, #0
	beq	.L402
	ldr	r2, [r3, #248]
	cmp	r2, #0
	beq	.L403
	ldr	r2, [r3, #152]
	cmp	r2, #1
	beq	.L404
.L402:
	mov	r1, #36
	bl	__memzero
	ldmfd	sp, {fp, sp, pc}
.L404:
	ldr	r0, [r3, #128]
	bl	RBUF_QueryInfo
	ldmfd	sp, {fp, sp, pc}
.L403:
	ldr	r0, [r3, #132]
	bl	RBUF_QueryInfo
	ldmfd	sp, {fp, sp, pc}
.L406:
	.align	2
.L405:
	.word	.LANCHOR0
	.fnend
	.size	AIP_QueryFiFoInfo, .-AIP_QueryFiFoInfo
	.align	2
	.global	AIP_QueryFiFoBusy
	.type	AIP_QueryFiFoBusy, %function
AIP_QueryFiFoBusy:
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
	ldr	r3, .L411
	add	r0, r0, #8
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	ldmeqfd	sp, {fp, sp, pc}
	ldr	r3, [r0, #248]
	cmp	r3, #0
	ldreq	r0, [r0, #132]
	ldrne	r0, [r0, #128]
	bl	RBUF_QueryBusy
	ldmfd	sp, {fp, sp, pc}
.L412:
	.align	2
.L411:
	.word	.LANCHOR0
	.fnend
	.size	AIP_QueryFiFoBusy, .-AIP_QueryFiFoBusy
	.align	2
	.global	AIP_QueryBusy
	.type	AIP_QueryBusy, %function
AIP_QueryBusy:
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
	ldr	r3, .L417
	add	r0, r0, #8
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	ldmeqfd	sp, {fp, sp, pc}
	ldr	r0, [r0, #128]
	cmp	r0, #0
	ldmeqfd	sp, {fp, sp, pc}
	bl	RBUF_QueryBusy
	ldmfd	sp, {fp, sp, pc}
.L418:
	.align	2
.L417:
	.word	.LANCHOR0
	.fnend
	.size	AIP_QueryBusy, .-AIP_QueryBusy
	.align	2
	.global	AIP_ReadDataComplete
	.type	AIP_ReadDataComplete, %function
AIP_ReadDataComplete:
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
	ldr	r3, .L426
	add	r2, r0, #8
	ldr	r4, [r3, r2, asl #2]
	ldr	r5, [r3, r0, asl #2]
	cmp	r4, #0
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r3, [r4, #248]
	cmp	r3, #0
	beq	.L425
	ldr	r0, [r4, #128]
	bl	RBUF_ReadDataComplete
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L425:
	ldr	r0, [r4, #132]
	bl	RBUF_ReadDataComplete
	ldr	r0, [r4, #132]
	bl	RBUF_QueryBusy
	ldr	r2, [r4, #80]
	ldr	r1, [r4, #224]
	bl	UTIL_LatencyMs
	ldr	r3, [r5, #4]
	bfi	r3, r0, #16, #6
	str	r3, [r5, #4]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L427:
	.align	2
.L426:
	.word	.LANCHOR0
	.fnend
	.size	AIP_ReadDataComplete, .-AIP_ReadDataComplete
	.align	2
	.global	AIP_UnderFlowCalc
	.type	AIP_UnderFlowCalc, %function
AIP_UnderFlowCalc:
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
	ldr	r3, .L433
	add	r2, r0, #8
	ldr	r1, [r3, r2, asl #2]
	ldr	r2, [r3, r0, asl #2]
	cmp	r1, #0
	ldmeqfd	sp, {fp, sp, pc}
	ldr	r3, [r2, #64]
	ldr	r1, [r2, #64]
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	uxth	r3, r3
	bfi	r1, r3, #16, #16
	str	r1, [r2, #64]
	ldmfd	sp, {fp, sp, pc}
.L434:
	.align	2
.L433:
	.word	.LANCHOR0
	.fnend
	.size	AIP_UnderFlowCalc, .-AIP_UnderFlowCalc
	.align	2
	.global	AIP_GetRingIn
	.type	AIP_GetRingIn, %function
AIP_GetRingIn:
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
	ldr	r3, .L438
	add	r0, r0, #8
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	ldrne	r0, [r0, #128]
	ldmfd	sp, {fp, sp, pc}
.L439:
	.align	2
.L438:
	.word	.LANCHOR0
	.fnend
	.size	AIP_GetRingIn, .-AIP_GetRingIn
	.align	2
	.global	AIP_GetCompressInfo
	.type	AIP_GetCompressInfo, %function
AIP_GetCompressInfo:
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
	ldr	r3, .L443
	add	r0, r0, #8
	mov	lr, r1
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	streq	r3, [r1]
	streq	r3, [r2]
	ldmeqfd	sp, {fp, sp, pc}
	ldr	r0, [r3, #128]
	bl	RBUF_GetCompressInfo
	ldmfd	sp, {fp, sp, pc}
.L444:
	.align	2
.L443:
	.word	.LANCHOR0
	.fnend
	.size	AIP_GetCompressInfo, .-AIP_GetCompressInfo
	.bss
	.align	2
.LANCHOR0 = . + 0
	.type	g_stAipRm, %object
	.size	g_stAipRm, 64
g_stAipRm:
	.space	64
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
