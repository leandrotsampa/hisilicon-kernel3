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
	.file	"vc1.c"

	.text
	.align	2
	.type	VC1_Vfmw_GenerateIntensityMap, %function
VC1_Vfmw_GenerateIntensityMap:
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
	cmp	r2, #31
	subgt	r2, r2, #64
	cmp	r1, #0
	addne	ip, r1, #32
	moveq	r2, r2, asl #7
	mvneq	ip, #63
	rsbeq	r2, r2, #16320
	movne	r2, r2, asl #6
	cmp	r3, #0
	bne	.L13
	add	r3, r2, #32
	sub	r2, r0, #1
	add	r0, r0, #255
.L5:
	usat	r1, #8, r3, asr #6
	strb	r1, [r2, #1]!
	cmp	r2, r0
	add	r3, r3, ip
	bne	.L5
	ldmfd	sp, {fp, sp, pc}
.L13:
	mov	r3, ip, asl #7
	sub	r2, r0, #1
	rsb	r3, r3, #8192
	add	r0, r0, #255
	add	r3, r3, #32
.L6:
	usat	r1, #8, r3, asr #6
	strb	r1, [r2, #1]!
	cmp	r2, r0
	add	r3, r3, ip
	bne	.L6
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VC1_Vfmw_GenerateIntensityMap, .-VC1_Vfmw_GenerateIntensityMap
	.align	2
	.type	VC1_Vfmw_UpdataLastPicRNDCTRL.part.5, %function
VC1_Vfmw_UpdataLastPicRNDCTRL.part.5:
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
	add	r2, r0, #8192
	ldrb	r3, [r2, #2415]
	tst	r3, #251
	moveq	r3, #1
	moveq	r1, r3
	beq	.L15
	cmp	r3, #1
	ldreqsb	r3, [r0, #10]
	ldrneb	r1, [r0, #10]
	clzeq	r3, r3
	moveq	r3, r3, lsr #5
	uxtbne	r3, r1
	uxtbeq	r1, r3
.L15:
	strb	r1, [r0, #10]
	strb	r3, [r2, #2434]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VC1_Vfmw_UpdataLastPicRNDCTRL.part.5, .-VC1_Vfmw_UpdataLastPicRNDCTRL.part.5
	.align	2
	.global	emp_print
	.type	emp_print, %function
emp_print:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r1, r2, r3}
	.save {r1, r2, r3}
	stmfd	sp!, {r4, fp, ip, lr, pc}
	.pad #4
	.save {r4, fp, ip, lr}
	.setfp fp, ip, #-16
	sub	fp, ip, #16
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r0, #0
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
	.fnend
	.size	emp_print, .-emp_print
	.align	2
	.global	AbandonBitsLenthNoUse
	.type	AbandonBitsLenthNoUse, %function
AbandonBitsLenthNoUse:
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
	moveq	r2, r3
	bne	.L31
.L23:
	ldrb	r3, [r0, #-1]!
	add	r2, r2, #8
	cmp	r3, #0
	beq	.L23
	add	r0, r2, #1
.L24:
	tst	r3, #1
	bne	.L32
.L25:
	mov	r3, r3, lsr #1
	add	r2, r2, #1
	tst	r3, #1
	beq	.L25
	add	r0, r2, #1
	ldmfd	sp, {fp, sp, pc}
.L31:
	mov	r0, #1
	mov	r2, #0
	b	.L24
.L32:
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	AbandonBitsLenthNoUse, .-AbandonBitsLenthNoUse
	.align	2
	.global	VC1DEC_Init
	.type	VC1DEC_Init, %function
VC1DEC_Init:
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
	ldr	r3, .L37
	add	r7, r0, #49152
	mov	r8, r1
	movw	r2, #49384
	mov	r1, #0
	ldr	r9, [r7, #216]
	mov	r6, r0
	ldr	r3, [r3, #48]
	mov	r5, r1
	blx	r3
	add	r0, r6, #48896
	add	r0, r0, #128
	str	r9, [r7, #216]
	bl	ResetVoQueue
	add	r1, r6, #12288
	ldr	r3, [r8, #32]
	mov	r4, #1
	str	r8, [r6]
	add	r2, r6, #45056
	strb	r4, [r1, #449]
	add	r3, r3, #255
	ldr	ip, [r8, #8]
	bic	r3, r3, #255
	add	lr, r3, #2048
	str	r3, [r2, #3896]
	str	lr, [r2, #3900]
	mov	r0, r6
	add	lr, r3, #4096
	str	ip, [r2, #3924]
	str	lr, [r2, #3904]
	add	ip, r3, #6144
	add	lr, r3, #8192
	str	ip, [r2, #3908]
	str	lr, [r2, #3912]
	add	ip, r3, #10240
	add	r3, r3, #12288
	str	ip, [r2, #3916]
	str	r3, [r2, #3920]
	strb	r4, [r1, #450]
	str	r5, [r2, #3856]
	str	r5, [r2, #3860]
	bl	VCTRL_GetChanIDByCtx
	cmn	r0, #1
	str	r0, [r7, #224]
	beq	.L36
	ldr	r1, .L37+4
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L36:
	mov	r0, r5
	ldr	r1, .L37+8
	bl	dprint_vfmw
	mvn	r0, #19
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L38:
	.align	2
.L37:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC14
	.word	.LC13
	.fnend
	.size	VC1DEC_Init, .-VC1DEC_Init
	.align	2
	.global	Vc1SMPSeqHdr
	.type	Vc1SMPSeqHdr, %function
Vc1SMPSeqHdr:
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
	mov	r4, r2
	mov	r2, r1, asl #3
	mov	r1, r0
	sub	r0, fp, #52
	bl	BsInit
	mov	r1, #8
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #8
	mov	r5, r0
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #8
	add	r5, r5, r0, lsl #8
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #8
	add	r5, r5, r0, lsl #16
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #8
	add	r5, r5, r0, lsl #24
	sub	r0, fp, #52
	str	r5, [r4, #8]
	bl	BsGet
	mov	r1, #8
	mov	r5, r0
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #8
	add	r5, r5, r0, lsl #8
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #8
	add	r5, r5, r0, lsl #16
	sub	r0, fp, #52
	bl	BsGet
	ldr	r3, [r4, #8]
	cmp	r3, #8192
	add	r0, r5, r0, lsl #24
	str	r0, [r4, #12]
	bgt	.L43
	cmp	r0, #8192
	bgt	.L44
	cmp	r3, #31
	ble	.L43
	cmp	r0, #31
	ble	.L44
	mov	r1, #2
	sub	r0, fp, #52
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #16]
	cmp	r0, #1
	bhi	.L46
	mov	r1, #2
	sub	r0, fp, #52
	bl	BsGet
	cmp	r0, #0
	bne	.L46
	mov	r1, #3
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #5
	strb	r0, [r4, #17]
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #18]
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #19]
	sub	r0, fp, #52
	bl	BsGet
	cmp	r0, #0
	bne	.L46
	mov	r1, #1
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #20]
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #21]
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #22]
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #2
	strb	r0, [r4, #23]
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #24]
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #25]
	sub	r0, fp, #52
	bl	BsGet
	subs	r5, r0, #0
	bne	.L46
	mov	r1, #1
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #26]
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #27]
	sub	r0, fp, #52
	bl	BsGet
	ldrb	r3, [r4, #16]
	mov	r1, #3
	cmp	r3, #0
	strb	r0, [r4, #28]
	sub	r0, fp, #52
	streqb	r5, [r4, #28]
	bl	BsGet
	mov	r1, #2
	strb	r0, [r4, #29]
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #30]
	sub	r0, fp, #52
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #31]
	sub	r0, fp, #52
	bl	BsGet
	sub	r0, fp, #52
	mov	r1, #32
	bl	BsGet
	cmp	r0, #0
	bne	.L52
	mov	r0, r5
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L52:
	ldr	r1, .L53
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, r5
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L46:
	ldr	r3, .L53+4
.L51:
	ldr	r2, .L53+8
	mov	r0, #0
	ldr	r1, .L53+12
	mvn	r5, #0
	bl	dprint_vfmw
	mov	r0, r5
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L44:
	ldr	r3, .L53+16
	b	.L51
.L43:
	ldr	r3, .L53+20
	b	.L51
.L54:
	.align	2
.L53:
	.word	.LC19
	.word	.LC18
	.word	.LANCHOR0
	.word	.LC16
	.word	.LC17
	.word	.LC15
	.fnend
	.size	Vc1SMPSeqHdr, .-Vc1SMPSeqHdr
	.align	2
	.global	VC1_SetImgFormat
	.type	VC1_SetImgFormat, %function
VC1_SetImgFormat:
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
	add	r5, r0, #32768
	add	r3, r0, #49152
	mov	r6, r0
	add	r7, r0, #12288
	ldr	r1, [r5, #3796]
	ldr	r0, [r3, #224]
	bl	FSP_GetFsImagePtr
	subs	r4, r0, #0
	beq	.L55
	mov	r3, #1
	str	r3, [r4, #340]
	ldrb	r3, [r7, #443]
	cmp	r3, #3
	movne	r2, #0
	movne	r3, #7168
	strneb	r2, [r4, #328]
	beq	.L65
.L64:
	str	r3, [r4, #108]
	mov	r1, #0
	ldr	r3, [r5, #3740]
	mov	r0, r4
	add	r10, r4, #496
	str	r3, [r4, #116]
	ldr	r3, [r5, #3736]
	str	r3, [r4, #112]
	bl	SetAspectRatio
	ldr	lr, [r7, #240]
	ldr	r3, [r4, #44]
	add	ip, r4, #480
	ldr	r2, [r4, #140]
	add	r1, r3, lr
	str	r1, [r4, #48]
	ldrd	r6, [ip, #-8]
	add	r0, r1, r2
	str	r0, [fp, #-48]
	mov	r0, r1
	adds	r8, r6, lr
	add	r2, r3, r2
	adc	r9, r7, #0
	strd	r8, [ip]
	str	r1, [r4, #32]
	ldr	r1, [fp, #-48]
	str	r3, [r4, #28]
	str	r2, [r4, #36]
	str	r1, [r4, #40]
	strd	r6, [r10, #-8]
	str	r3, [r4, #60]
	bl	MEM_Phy2Vir
	mov	r3, #0
	str	r3, [r4, #500]
	mov	r2, #8
	ldr	r3, [r4, #112]
	mov	r1, #1
	add	r3, r3, #508
	add	r3, r3, #3
	bic	r3, r3, #508
	bic	r3, r3, #3
	mov	r3, r3, lsr #5
	str	r0, [r4, #496]
	ldr	r0, [r4, #32]
	str	r0, [r4, #64]
	ldr	r0, [r5, #3740]
	str	r0, [r4, #124]
	ldr	r0, [r5, #3736]
	strb	r1, [r4, #335]
	str	r3, [r4, #144]
	str	r0, [r4, #120]
	strb	r1, [r4, #333]
	str	r2, [r4, #344]
	str	r2, [r4, #352]
	str	r2, [r4, #348]
.L55:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L65:
	mov	r2, #4
	ldr	r3, [r4, #108]
	strb	r2, [r4, #328]
	ldrb	r1, [r6, #16]
	ubfx	r2, r3, #10, #2
	add	r3, r1, #1
	orr	r3, r3, r2
	cmp	r3, #3
	movls	r3, r3, asl #10
	orrls	r3, r3, #4352
	movhi	r3, #4352
	b	.L64
	.fnend
	.size	VC1_SetImgFormat, .-VC1_SetImgFormat
	.align	2
	.global	VC1DEC_Destroy
	.type	VC1DEC_Destroy, %function
VC1DEC_Destroy:
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
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VC1DEC_Destroy, .-VC1DEC_Destroy
	.align	2
	.global	VC1DEC_RecycleImage
	.type	VC1DEC_RecycleImage, %function
VC1DEC_RecycleImage:
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
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	add	r4, r0, #49152
	mov	r2, #0
	ldr	r0, [r4, #224]
	bl	FSP_SetDisplay
	mov	r1, r5
	ldr	r0, [r4, #224]
	bl	FSP_GetFsImagePtr
	cmp	r0, #0
	beq	.L70
	add	r5, r0, #544
	add	r8, r0, #528
	ldr	r1, [r0, #528]
	mov	r6, #0
	ldr	r0, [r4, #224]
	mov	r7, #0
	bl	FreeUsdByDec
	strd	r6, [r8]
	ldr	r0, [r4, #224]
	ldr	r1, [r5, #-8]
	bl	FreeUsdByDec
	strd	r6, [r5, #-8]
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L70:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	VC1DEC_RecycleImage, .-VC1DEC_RecycleImage
	.align	2
	.global	VC1DEC_GetRemainImg
	.type	VC1DEC_GetRemainImg, %function
VC1DEC_GetRemainImg:
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
	add	r5, r0, #32768
	mov	r4, r0
	add	r9, r0, #12288
	ldr	r3, [r5, #3708]
	cmp	r3, #0
	beq	.L78
	ldr	r3, [r0]
	ldr	r3, [r3, #12]
	cmp	r3, #1
	beq	.L89
	add	r6, r0, #49152
	ldr	r1, [r5, #3792]
	ldr	r0, [r6, #224]
	bl	FSP_GetFsImagePtr
	subs	r8, r0, #0
	beq	.L89
	ldr	r1, [r5, #3792]
	ldr	r0, [r6, #224]
	bl	FSP_GetDisplay
	cmp	r0, #2
	beq	.L87
.L89:
	add	r5, r4, #48896
	add	r5, r5, #128
.L77:
	mov	r0, r5
	bl	GetVoLastImageID
.L88:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L87:
	add	r10, r8, #528
	add	r7, r8, #544
	mov	r0, r4
	bl	VC1_SetImgFormat
	mov	r2, #1
	mov	r0, #0
	str	r2, [r8, #188]
	mov	r1, #0
	strd	r0, [r10]
	strd	r0, [r7, #-8]
	ldr	r1, [r8, #156]
	ldr	r0, [r6, #224]
	bl	FSP_SetDisplay
	ldr	r3, [r5, #3708]
	ldrb	r2, [r3]
	cmp	r2, #1
	beq	.L90
.L74:
	add	r5, r4, #48896
	ldr	r0, [r6, #224]
	add	r5, r5, #128
	str	r8, [sp]
	mov	r2, r4
	mov	r1, #1
	mov	r3, r5
	bl	InsertImgToVoQueue
	cmp	r0, #1
	beq	.L75
	ldr	r1, [r8, #156]
	mov	r0, r4
	bl	VC1DEC_RecycleImage
	ldr	r1, [r8, #528]
	ldr	r0, [r6, #224]
	mov	r8, #0
	bl	FreeUsdByDec
	mov	r9, #0
	strd	r8, [r10]
	ldr	r0, [r6, #224]
	ldr	r1, [r7, #-8]
	bl	FreeUsdByDec
	strd	r8, [r7, #-8]
	b	.L77
.L75:
	ldr	r3, [r8, #160]
	cmp	r3, #100
	bhi	.L77
	ldr	r3, [r8, #112]
	cmp	r3, #31
	bls	.L77
	ldr	r3, [r8, #116]
	cmp	r3, #31
	movhi	r0, #0
	bhi	.L88
	b	.L77
.L90:
	strb	r2, [r3, #1]
	mov	r1, #0
	ldr	r2, [r5, #3708]
	mov	r3, #3
	strb	r1, [r2]
	strb	r3, [r9, #441]
	b	.L74
.L78:
	mvn	r0, #0
	b	.L88
	.fnend
	.size	VC1DEC_GetRemainImg, .-VC1DEC_GetRemainImg
	.align	2
	.global	VC1_ArrangeVahbMem
	.type	VC1_ArrangeVahbMem, %function
VC1_ArrangeVahbMem:
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
	mov	r5, r1
	sub	r1, r1, #32
	movw	r3, #8160
	cmp	r1, r3
	mov	r7, r0
	mov	r6, r2
	bhi	.L92
	sub	r2, r2, #32
	cmp	r2, r3
	bhi	.L92
	add	ip, r0, #28160
	mov	lr, #0
	add	ip, ip, #152
	mov	r4, lr
.L95:
	str	lr, [ip, #-436]
	add	lr, lr, #1
	cmp	lr, #5
	strb	r4, [ip, #-1631]
	strb	r4, [ip, #-1632]
	add	ip, ip, #1632
	bne	.L95
	ldr	r3, [r7]
	ldr	r4, [r3, #700]
	ldr	r2, [r3, #28]
	cmp	r4, #0
	bne	.L96
	cmp	r2, #25
	beq	.L118
.L114:
	mov	r4, lr
	mov	r8, #3
	mov	r9, #2
.L97:
	ldr	r3, .L121
	mov	r2, #32
	mov	r1, #0
	sub	r0, fp, #68
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r2, [r7]
	str	r6, [fp, #-40]
	mov	r3, #0
	str	r5, [fp, #-60]
	ldr	r2, [r2, #28]
	str	r6, [fp, #-56]
	cmp	r2, #24
	str	r5, [fp, #-44]
	strb	r3, [fp, #-68]
	strb	r3, [fp, #-67]
	beq	.L107
	uxtb	r3, r9
	strb	r8, [fp, #-65]
	strb	r4, [fp, #-63]
.L110:
	add	r6, r7, #49152
	sub	r1, fp, #68
	strb	r3, [fp, #-62]
	mov	r5, #0
	ldr	r0, [r6, #224]
	strb	r5, [fp, #-66]
	bl	FSP_ConfigInstance
	subs	r4, r0, #0
	bne	.L108
	ldr	r1, [r7]
	sub	r3, fp, #72
	ldr	r0, [r6, #224]
	ldr	r2, [r1, #24]
	ldr	r1, [r1, #20]
	bl	FSP_ConfigFrameBuf
	cmp	r0, r5
	bne	.L119
.L112:
	mov	r4, #1
	mov	r0, r4
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L92:
	mov	r3, r6
	mov	r2, r5
	ldr	r1, .L121+4
	mov	r0, #0
	bl	dprint_vfmw
	mov	r4, #0
.L117:
	mov	r0, r4
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L96:
	cmp	r2, #25
	bne	.L114
	ldr	r2, [r3, #660]
	ldr	r1, [r3, #664]
	cmp	r5, r2
	bhi	.L104
	cmp	r6, r1
	bhi	.L104
	ldr	r1, [r3, #688]
	ldr	r2, [r3, #684]
	cmp	r1, #0
	add	r8, r2, #2
	moveq	r9, #1
	bne	.L120
.L106:
	ldrb	r4, [r3, #708]
	b	.L97
.L108:
	ldr	r1, .L121+8
	mov	r0, r5
	bl	dprint_vfmw
	mov	r4, r5
	mov	r0, r4
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L118:
	ldr	r2, [r3, #660]
	cmp	r5, r2
	ldrhi	r0, [r3, #664]
	bhi	.L99
	ldr	r1, [r3, #664]
	cmp	r6, r1
	mov	r0, r1
	bhi	.L99
	add	r0, r7, #12288
	ldrb	r0, [r0, #440]
	tst	r0, #8
	bne	.L112
	ldr	ip, [r3, #688]
	ldr	r0, [r3, #684]
	cmp	ip, #0
	add	r8, r0, #2
	moveq	r9, #1
	beq	.L102
	add	r9, r0, #1
	cmp	r9, #17
	movcs	r9, #17
.L102:
	ldrb	r4, [r3, #708]
	mov	r6, r1
	mov	r5, r2
	b	.L97
.L107:
	mov	r3, #1
	strb	r4, [fp, #-63]
	strb	r3, [fp, #-65]
	b	.L110
.L104:
	str	r1, [sp, #4]
	mov	r3, r6
	str	r2, [sp]
	mov	r0, #0
	mov	r2, r5
	ldr	r1, .L121+12
	bl	dprint_vfmw
	mov	r4, #0
	b	.L117
.L119:
	ldr	r1, .L121+16
	mov	r0, r4
	bl	dprint_vfmw
	b	.L117
.L120:
	add	r9, r2, #1
	cmp	r9, #17
	movcs	r9, #17
	b	.L106
.L99:
	str	r0, [sp, #4]
	mov	r3, r6
	str	r2, [sp]
	mov	r0, #0
	mov	r2, r5
	ldr	r1, .L121+12
	bl	dprint_vfmw
	b	.L117
.L122:
	.align	2
.L121:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC20
	.word	.LC23
	.word	.LC21
	.word	.LC22
	.fnend
	.size	VC1_ArrangeVahbMem, .-VC1_ArrangeVahbMem
	.align	2
	.global	VC1_WritePicMsg
	.type	VC1_WritePicMsg, %function
VC1_WritePicMsg:
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
	add	r6, r0, #32768
	add	r7, r0, #49152
	mov	r5, r0
	mov	r4, r1
	add	r8, r0, #12288
	ldr	r1, [r6, #3796]
	ldr	r0, [r7, #224]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	beq	.L147
	add	r3, r8, #3536
	ldrsb	r2, [r3]
	add	r3, r5, #20480
	cmp	r2, #0
	bne	.L148
	strb	r2, [r4, #5]
	add	r1, r5, #45056
	ldrb	ip, [r3, #2604]
	strb	ip, [r4, #4]
	ldrb	ip, [r3, #2855]
	cmp	ip, #4
	moveq	ip, #3
	strb	ip, [r4, #3]
	ldr	ip, [r1, #3876]
	sub	ip, ip, #1
	strh	ip, [r4, #80]
	ldr	ip, [r1, #3872]
	strb	r2, [r4, #8]
	sub	ip, ip, #1
	strh	ip, [r4, #78]
	ldrb	ip, [r3, #2607]
	strb	r2, [r4, #9]
	strb	ip, [r4, #6]
	ldrb	ip, [r8, #448]
	strb	r2, [r4, #10]
	strb	r2, [r4, #11]
	strb	ip, [r4, #7]
	ldrb	ip, [r3, #2610]
	strb	ip, [r4, #13]
	ldrb	ip, [r3, #2614]
	strb	ip, [r4, #14]
	ldrb	ip, [r3, #2874]
	strb	ip, [r4, #12]
	ldrb	ip, [r3, #2884]
	strb	ip, [r4, #18]
	ldrb	ip, [r3, #2859]
	strb	ip, [r4, #19]
	ldrb	ip, [r3, #2858]
	strb	ip, [r4, #17]
	ldr	ip, [r3, #2944]
	strb	ip, [r4, #16]
	ldrb	ip, [r3, #2618]
	cmp	ip, #0
	bne	.L139
	ldrb	r2, [r3, #2858]
	cmp	r2, #8
	movhi	r2, #0
	movls	r2, #1
	strb	r2, [r4, #20]
.L140:
	ldrb	ip, [r3, #2878]
	add	r2, r4, #12288
	strb	ip, [r4, #24]
	ldrb	ip, [r3, #2877]
	strb	ip, [r4, #23]
	ldrb	ip, [r3, #2612]
	strb	ip, [r4, #22]
	ldrb	ip, [r3, #2876]
	strb	ip, [r4, #25]
	ldr	ip, [r3, #2888]
	strb	ip, [r4, #26]
	ldrb	ip, [r3, #2879]
	strb	ip, [r4, #21]
	ldrb	ip, [r3, #2863]
	strb	ip, [r4, #27]
	ldrb	ip, [r3, #2864]
	strb	ip, [r4, #28]
	ldr	ip, [r6, #3708]
	ldrb	ip, [ip, #1029]
	strb	ip, [r4, #30]
	ldr	ip, [r6, #3704]
	ldrb	ip, [ip, #1029]
	strb	ip, [r4, #29]
	ldrb	ip, [r3, #2861]
	strb	ip, [r4, #31]
	ldrb	ip, [r3, #2983]
	strb	ip, [r4, #32]
	ldrb	ip, [r3, #2873]
	strb	ip, [r4, #35]
	ldrb	ip, [r3, #2613]
	strb	ip, [r4, #36]
	ldrb	ip, [r3, #2869]
	strb	ip, [r4, #37]
	ldrb	ip, [r3, #2871]
	strb	ip, [r4, #38]
	ldrb	ip, [r3, #2872]
	strb	ip, [r4, #39]
	ldrb	ip, [r3, #2870]
	strb	ip, [r4, #40]
	ldr	ip, [r3, #2936]
	clz	ip, ip
	mov	ip, ip, lsr #5
	strb	ip, [r4, #42]
	ldr	ip, [r3, #2932]
	clz	ip, ip
	mov	ip, ip, lsr #5
	strb	ip, [r4, #43]
	ldr	ip, [r3, #2940]
	clz	ip, ip
	mov	ip, ip, lsr #5
	strb	ip, [r4, #45]
	ldrb	ip, [r3, #2856]
	strb	ip, [r4, #50]
	ldrb	ip, [r3, #2868]
	strb	ip, [r4, #49]
	ldrb	ip, [r3, #2867]
	strb	ip, [r4, #48]
	ldr	ip, [r3, #2948]
	str	ip, [r2, #84]
	ldrb	ip, [r3, #2616]
	cmp	ip, #1
	beq	.L149
	mov	ip, #0
	mov	lr, ip
	mov	r9, ip
	mov	r10, ip
.L143:
	strb	r10, [r4, #59]
	strb	r9, [r4, #60]
	strb	lr, [r4, #61]
	str	ip, [r0, #364]
	ldrb	r3, [r3, #2604]
	strb	r3, [r0, #342]
.L137:
	ldr	r3, [r6, #3804]
	add	r5, r5, #12736
	ldr	r0, .L153
	add	r5, r5, #5
	strh	r3, [r4, #72]
	ldr	r3, [r6, #3736]
	strh	r3, [r4, #74]
	ldr	r3, [r6, #3740]
	strh	r3, [r4, #76]
	ldrb	r3, [r8, #451]
	strb	r3, [r4, #63]
	ldrb	r3, [r8, #452]
	strb	r3, [r4, #62]
	ldr	ip, [r6, #3720]
	adds	r3, ip, #127
	addmi	r3, ip, #254
	mov	r3, r3, asr #7
	mov	r3, r3, asl #4
	str	r3, [r2, #116]
	ldr	r3, [r1, #3896]
	str	r3, [r2, #120]
	ldr	r3, [r1, #3900]
	str	r3, [r2, #124]
	ldr	r3, [r1, #3904]
	str	r3, [r2, #128]
	ldr	r3, [r1, #3908]
	str	r3, [r2, #132]
	ldr	r3, [r1, #3912]
	str	r3, [r2, #136]
	ldr	r3, [r1, #3916]
	str	r3, [r2, #140]
	ldr	r3, [r1, #3920]
	str	r3, [r2, #144]
	str	r5, [r4, #64]
	ldr	r2, [r7, #224]
	ldrh	r3, [r4, #78]
	ldr	r2, [r0, r2, asl #2]
	add	r3, r3, #1
	str	r3, [r2, #1468]
	ldr	r3, [r7, #224]
	ldr	r2, [r0, r3, asl #2]
	ldrh	r3, [r4, #80]
	add	r3, r3, #1
	str	r3, [r2, #1472]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L148:
	ldr	r2, [r3, #2996]
	add	r1, r5, #45056
	mov	lr, #1632
	strb	r2, [r4, #5]
	ldrb	r2, [r3, #2620]
	strb	r2, [r4, #4]
	ldrb	r2, [r3, #2953]
	cmp	r2, #4
	moveq	r2, #3
	strb	r2, [r4, #3]
	ldr	r2, [r3, #2996]
	cmp	r2, #3
	ldr	r2, [r1, #3876]
	addeq	r2, r2, #1
	addeq	r2, r2, r2, lsr #31
	moveq	r2, r2, asr #1
	sub	r2, r2, #1
	strh	r2, [r4, #80]
	ldr	r2, [r1, #3872]
	sub	r2, r2, #1
	strh	r2, [r4, #78]
	ldrb	r2, [r3, #2993]
	strb	r2, [r4, #8]
	ldrb	r2, [r3, #2796]
	strb	r2, [r4, #6]
	ldrb	r2, [r3, #2984]
	strb	r2, [r4, #9]
	ldrb	r2, [r8, #448]
	strb	r2, [r4, #7]
	ldr	ip, [r6, #3760]
	mla	ip, lr, ip, r8
	add	ip, ip, #15360
	ldrb	r2, [ip, #59]
	strb	r2, [r4, #10]
	ldr	r2, [r6, #3776]
	mla	r2, lr, r2, r8
	add	r2, r2, #15360
	add	r2, r2, #56
	ldrb	r2, [r2, #3]
	strb	r2, [r4, #11]
	ldrb	r2, [r3, #2982]
	strb	r2, [r4, #15]
	ldrb	r2, [r3, #2797]
	strb	r2, [r4, #13]
	ldrb	r2, [r3, #2801]
	strb	r2, [r4, #14]
	ldrb	r2, [r3, #2952]
	strb	r2, [r4, #12]
	ldrb	r2, [r3, #3120]
	strb	r2, [r4, #18]
	ldrb	r2, [r3, #2955]
	strb	r2, [r4, #19]
	ldrb	r2, [r3, #2962]
	strb	r2, [r4, #17]
	ldr	r2, [r3, #3068]
	strb	r2, [r4, #16]
	ldrb	r2, [r3, #2802]
	cmp	r2, #0
	bne	.L130
	ldrb	r2, [r3, #2962]
	cmp	r2, #8
	movhi	r2, #0
	movls	r2, #1
	strb	r2, [r4, #20]
.L131:
	ldrb	ip, [r3, #3114]
	add	r2, r4, #12288
	strb	ip, [r4, #24]
	ldrb	ip, [r3, #3113]
	strb	ip, [r4, #23]
	ldrb	ip, [r3, #2799]
	strb	ip, [r4, #22]
	ldrb	ip, [r3, #3112]
	strb	ip, [r4, #25]
	ldr	ip, [r3, #3124]
	strb	ip, [r4, #26]
	ldrb	ip, [r3, #3115]
	strb	ip, [r4, #21]
	ldrb	ip, [r3, #2966]
	strb	ip, [r4, #27]
	ldrb	ip, [r3, #2967]
	strb	ip, [r4, #28]
	ldrb	ip, [r3, #2985]
	strb	ip, [r4, #34]
	ldrb	ip, [r3, #2977]
	strb	ip, [r4, #33]
	ldrb	lr, [r3, #2993]
	ldr	ip, [r6, #3708]
	add	ip, ip, lr
	ldrb	ip, [ip, #1029]
	strb	ip, [r4, #30]
	ldr	ip, [r6, #3704]
	ldrb	lr, [r3, #2993]
	add	ip, ip, lr
	ldrb	ip, [ip, #1029]
	strb	ip, [r4, #29]
	ldrb	ip, [r3, #2965]
	strb	ip, [r4, #31]
	ldrb	ip, [r3, #2983]
	strb	ip, [r4, #32]
	ldrb	ip, [r3, #2976]
	strb	ip, [r4, #35]
	ldrb	ip, [r3, #2800]
	strb	ip, [r4, #36]
	ldrb	ip, [r3, #2972]
	strb	ip, [r4, #37]
	ldrb	ip, [r3, #2974]
	strb	ip, [r4, #38]
	ldrb	ip, [r3, #2975]
	strb	ip, [r4, #39]
	ldrb	ip, [r3, #2973]
	strb	ip, [r4, #40]
	ldrb	ip, [r3, #2989]
	clz	ip, ip
	mov	ip, ip, lsr #5
	strb	ip, [r4, #46]
	ldrb	ip, [r3, #2987]
	clz	ip, ip
	mov	ip, ip, lsr #5
	strb	ip, [r4, #42]
	ldrb	ip, [r3, #2991]
	clz	ip, ip
	mov	ip, ip, lsr #5
	strb	ip, [r4, #44]
	ldrb	ip, [r3, #2992]
	clz	ip, ip
	mov	ip, ip, lsr #5
	strb	ip, [r4, #41]
	ldrb	ip, [r3, #2986]
	clz	ip, ip
	mov	ip, ip, lsr #5
	strb	ip, [r4, #43]
	ldrb	ip, [r3, #2990]
	clz	ip, ip
	mov	ip, ip, lsr #5
	strb	ip, [r4, #47]
	ldrb	ip, [r3, #2988]
	clz	ip, ip
	mov	ip, ip, lsr #5
	strb	ip, [r4, #45]
	ldrb	ip, [r3, #2954]
	strb	ip, [r4, #50]
	ldrb	ip, [r3, #2971]
	strb	ip, [r4, #49]
	ldrb	ip, [r3, #2970]
	strb	ip, [r4, #48]
	ldrb	ip, [r3, #2981]
	strb	ip, [r4, #53]
	ldrb	ip, [r3, #2978]
	strb	ip, [r4, #54]
	ldrb	ip, [r3, #2979]
	strb	ip, [r4, #51]
	ldrb	ip, [r3, #2980]
	strb	ip, [r4, #52]
	ldr	ip, [r3, #3100]
	str	ip, [r2, #84]
	ldr	ip, [r1, #3848]
	str	ip, [r2, #88]
	ldr	ip, [r1, #3852]
	str	ip, [r2, #92]
	ldrb	ip, [r3, #2805]
	strb	ip, [r4, #55]
	ldrb	ip, [r3, #2806]
	strb	ip, [r4, #56]
	ldrb	ip, [r3, #2807]
	strb	ip, [r4, #57]
	ldrb	ip, [r3, #2808]
	strb	ip, [r4, #58]
	ldr	ip, [r3, #2996]
	cmp	ip, #3
	beq	.L150
	ldrb	ip, [r3, #2805]
	strb	ip, [r0, #337]
	ldrb	ip, [r3, #2806]
	strb	ip, [r0, #338]
	ldrb	ip, [r3, #2807]
	strb	ip, [r0, #339]
	ldrb	ip, [r3, #2808]
	strb	ip, [r0, #340]
.L136:
	ldrb	r3, [r3, #2620]
	strb	r3, [r0, #342]
	ldrb	r3, [r8, #451]
	strb	r3, [r4, #63]
	b	.L137
.L139:
	cmp	ip, #1
	beq	.L151
	cmp	ip, #2
	movne	r2, #1
	strb	r2, [r4, #20]
	b	.L140
.L130:
	cmp	r2, #1
	beq	.L152
	cmp	r2, #2
	moveq	r2, #0
	movne	r2, #1
	strb	r2, [r4, #20]
	b	.L131
.L152:
	ldrb	r2, [r3, #2963]
	adds	r2, r2, #0
	movne	r2, #1
	strb	r2, [r4, #20]
	b	.L131
.L151:
	ldrb	r2, [r3, #2860]
	adds	r2, r2, #0
	movne	r2, #1
	strb	r2, [r4, #20]
	b	.L140
.L150:
	ldrb	ip, [r3, #2993]
	cmp	ip, #0
	bne	.L135
	ldrb	ip, [r3, #2805]
	strb	ip, [r0, #337]
	ldrb	ip, [r3, #2806]
	strb	ip, [r0, #338]
	ldrb	ip, [r3, #2807]
	strb	ip, [r0, #339]
	ldrb	ip, [r3, #2808]
	strb	ip, [r0, #340]
	ldrb	ip, [r3, #2993]
.L135:
	cmp	ip, #1
	bne	.L136
	ldrb	ip, [r3, #2805]
	strb	ip, [r0, #332]
	ldrb	ip, [r3, #2806]
	strb	ip, [r0, #333]
	ldrb	ip, [r3, #2807]
	strb	ip, [r0, #334]
	ldrb	ip, [r3, #2808]
	strb	ip, [r0, #335]
	b	.L136
.L149:
	ldr	lr, [r6, #3760]
	mov	r10, #1632
	ldr	ip, [r6, #3776]
	ldrb	r9, [r3, #2855]
	mla	lr, r10, lr, r8
	sub	r9, r9, #2
	mla	ip, r10, ip, r8
	tst	r9, #253
	add	lr, lr, #14336
	ldrneb	r10, [r3, #2854]
	add	ip, ip, #14336
	ldrb	r9, [lr, #58]
	ldrb	lr, [ip, #58]
	movne	ip, r10
	moveq	ip, lr
	moveq	r10, lr
	b	.L143
.L147:
	movw	r2, #1107
	ldr	r1, .L153+4
	mov	r0, #22
	bl	dprint_vfmw
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L154:
	.align	2
.L153:
	.word	s_pstVfmwChan
	.word	.LC24
	.fnend
	.size	VC1_WritePicMsg, .-VC1_WritePicMsg
	.align	2
	.global	VC1_WriteSliceMsg
	.type	VC1_WriteSliceMsg, %function
VC1_WriteSliceMsg:
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
	add	r3, r0, #20480
	mov	r2, r1
	ldr	ip, .L156
	ldr	lr, [r3, #3364]
	add	r1, r0, #23808
	add	r0, r2, #84
	add	r1, r1, #40
	ldr	ip, [ip, #52]
	strb	lr, [r2, #70]
	ldr	r3, [r3, #3364]
	mov	r2, r3, asl #6
	sub	r2, r2, r3, asl #4
	blx	ip
	ldmfd	sp, {fp, sp, pc}
.L157:
	.align	2
.L156:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VC1_WriteSliceMsg, .-VC1_WriteSliceMsg
	.align	2
	.global	VC1_CfgVDH
	.type	VC1_CfgVDH, %function
VC1_CfgVDH:
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
	ldrb	r3, [r0, #3096]
	cmp	r3, #0
	beq	.L159
	add	r3, r0, #8192
	ldr	r3, [r3, #2556]
	cmp	r3, #3
	beq	.L164
.L159:
	add	r3, r0, #32768
	add	r6, r1, #12288
	ldr	r3, [r3, #3440]
	sub	r3, r3, #1
	str	r3, [r6, #164]
.L160:
	add	r4, r0, #20480
	ldr	r3, [r6, #256]
	mov	ip, #0
	mov	r5, #1632
	ldr	r2, [r4, #3304]
	and	r7, r3, #1
	movw	lr, #15088
	add	r3, r2, #63
	cmp	r2, ip
	movlt	r2, r3
	mov	r2, r2, asr #6
	mov	r2, r2, asl #4
	add	r3, r2, #536870913
	add	r3, r3, #81920
	orr	r3, r3, r7, asl #30
	str	r3, [r6, #168]
	ldr	r2, [r4, #3336]
	ldr	r3, [r4, #3320]
	ldr	r6, [r4, #3264]
	mla	r4, r5, r2, r0
	mla	r0, r5, r3, r0
	ldr	r2, [r6, #1136]
	and	r2, r2, #3
	ldr	r3, [r4, lr]
	mov	r2, r2, asl #4
	ldr	r0, [r0, lr]
	and	r3, r3, #3
	strb	ip, [r1, #69]
	orr	r3, r2, r3, asl #2
	and	r2, r0, #3
	orr	r3, r3, r2
	strb	r3, [r1, #68]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L164:
	add	r2, r0, #32768
	add	r6, r1, #12288
	ldr	r3, [r2, #3436]
	ldr	r2, [r2, #3432]
	add	r3, r3, #1
	add	r3, r3, r3, lsr #31
	mov	r3, r3, asr #1
	mul	r3, r2, r3
	sub	r3, r3, #1
	str	r3, [r6, #164]
	b	.L160
	.fnend
	.size	VC1_CfgVDH, .-VC1_CfgVDH
	.align	2
	.global	VC1_Vfmw_GenerateDecPara
	.type	VC1_Vfmw_GenerateDecPara, %function
VC1_Vfmw_GenerateDecPara:
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
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VC1_Vfmw_GenerateDecPara, .-VC1_Vfmw_GenerateDecPara
	.align	2
	.global	VC1DEC_GetImageBuffer
	.type	VC1DEC_GetImageBuffer, %function
VC1DEC_GetImageBuffer:
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
	add	r3, r0, #12288
	mov	r4, r0
	ldrb	r2, [r3, #443]
	cmp	r2, #3
	beq	.L177
.L167:
	add	r5, r4, #49152
	ldr	r0, [r5, #224]
	bl	FSP_IsNewFsAvalible
	cmp	r0, #1
	beq	.L169
	ldr	r0, [r5, #224]
	bl	FSP_IsNewFsAvalible
	cmn	r0, #1
	beq	.L178
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L177:
	ldrb	r3, [r3, #449]
	cmp	r3, #1
	beq	.L167
.L169:
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L178:
	add	r1, r4, #48896
	ldr	r0, [r5, #224]
	add	r1, r1, #128
	bl	FSP_ClearNotInVoQueue
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	VC1DEC_GetImageBuffer, .-VC1DEC_GetImageBuffer
	.align	2
	.global	VC1_Vfmw_GetImageBuffer
	.type	VC1_Vfmw_GetImageBuffer, %function
VC1_Vfmw_GetImageBuffer:
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
	add	r6, r0, #49152
	add	r4, r0, #32768
	mov	r5, r0
	mov	r1, #1
	ldr	r0, [r6, #224]
	bl	FSP_NewLogicFs
	cmp	r0, #0
	str	r0, [r4, #3796]
	blt	.L199
	add	r3, r5, #26624
	add	r2, r3, #56
	ldrh	r3, [r3, #56]
	cmp	r3, #0
	beq	.L183
	add	r3, r5, #28160
	add	lr, r5, #34816
	add	r3, r3, #152
	add	lr, lr, #24
.L186:
	ldrh	ip, [r3]
	mov	r2, r3
	add	r3, r3, #1632
	cmp	ip, #0
	beq	.L183
	cmp	r3, lr
	bne	.L186
	mov	r1, r0
	mov	r2, #1
	ldr	r0, [r6, #224]
	bl	FSP_ClearLogicFs
	ldr	r1, .L200
	mov	r0, #1
	bl	dprint_vfmw
	add	r3, r5, #26624
	add	r5, r5, #34816
	add	r3, r3, #57
	add	r5, r5, #25
	mov	r2, #0
.L188:
	strb	r2, [r3]
	add	r3, r3, #1632
	strb	r2, [r3, #-1633]
	cmp	r3, r5
	bne	.L188
	mov	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L183:
	mov	r3, #0
	str	r2, [r4, #3704]
	mov	r1, #1
	strb	r1, [r2, #1]
.L185:
	ldr	r1, [r4, #3704]
	uxtb	r2, r3
	add	r1, r1, r3
	strb	r2, [r1, #3]
	ldr	r1, [r4, #3704]
	add	r1, r1, r3
	strb	r2, [r1, #259]
	ldr	r1, [r4, #3704]
	add	r1, r1, r3
	strb	r2, [r1, #515]
	ldr	r1, [r4, #3704]
	add	r1, r1, r3
	add	r3, r3, #1
	cmp	r3, #256
	strb	r2, [r1, #771]
	bne	.L185
	mov	r0, #1
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L199:
	ldr	r1, .L200+4
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r1, [r4, #3792]
	ldr	r0, [r6, #224]
	bl	FSP_GetFsImagePtr
	subs	r7, r0, #0
	beq	.L181
	ldr	r1, [r7, #528]
	add	r9, r7, #544
	ldr	r0, [r6, #224]
	add	r8, r7, #560
	bl	FreeUsdByDec
	ldr	r1, [r7, #536]
	ldr	r0, [r6, #224]
	add	r10, r7, #528
	bl	FreeUsdByDec
	ldr	r1, [r7, #544]
	ldr	r0, [r6, #224]
	bl	FreeUsdByDec
	ldr	r1, [r7, #552]
	ldr	r0, [r6, #224]
	bl	FreeUsdByDec
	mov	r0, #0
	mov	r1, #0
	mov	r2, #1
	strd	r0, [r10]
	strd	r0, [r9, #-8]
	strd	r0, [r9]
	strd	r0, [r8, #-8]
	ldr	r1, [r4, #3792]
	ldr	r0, [r6, #224]
	bl	FSP_ClearLogicFs
	mov	r2, #1
	ldr	r1, [r4, #3788]
	ldr	r0, [r6, #224]
	bl	FSP_ClearLogicFs
	mov	r3, #0
	str	r3, [r4, #3788]
	str	r3, [r4, #3792]
	ldr	r0, [r6, #224]
	bl	FSP_GetNullLogicFs
	str	r0, [r4, #3792]
	str	r0, [r4, #3788]
.L181:
	add	r1, r5, #48896
	mov	r5, #0
	add	r1, r1, #128
	str	r5, [r4, #3784]
	ldr	r0, [r6, #224]
	bl	FSP_ClearNotInVoQueue
	ldr	r1, .L200+8
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r5
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L201:
	.align	2
.L200:
	.word	.LC27
	.word	.LC25
	.word	.LC26
	.fnend
	.size	VC1_Vfmw_GetImageBuffer, .-VC1_Vfmw_GetImageBuffer
	.align	2
	.global	VC1_Vfmw_MemMove
	.type	VC1_Vfmw_MemMove, %function
VC1_Vfmw_MemMove:
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
	ldr	ip, .L203
	ldr	r3, [r0, #3284]
	ldr	r2, [r0, #3304]
	add	r3, r3, #1
	ldr	r1, [r0, #3268]
	ldr	r0, [r0, #3264]
	add	r3, r3, r3, lsr #31
	ldr	ip, [ip, #52]
	ldr	r1, [r1, #1512]
	mov	r3, r3, asr #1
	ldr	r0, [r0, #1512]
	mov	r3, r3, asl #5
	mul	r3, r2, r3
	add	r2, r3, r3, lsl #1
	mov	r2, r2, asr #1
	blx	ip
	ldmfd	sp, {fp, sp, pc}
.L204:
	.align	2
.L203:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VC1_Vfmw_MemMove, .-VC1_Vfmw_MemMove
	.align	2
	.global	VC1_Vfmw_BuildRefList
	.type	VC1_Vfmw_BuildRefList, %function
VC1_Vfmw_BuildRefList:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #540
	sub	sp, sp, #540
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r6, .L280
	mov	r7, r0
	add	r0, r0, #23552
	mov	r10, r1
	mov	r4, r2
	mov	r1, #0
	ldr	ip, [r6, #48]
	mov	r2, #16
	add	r0, r0, #240
	mov	r5, r3
	blx	ip
	ldr	r3, [r6, #48]
	add	r0, r7, #23808
	mov	r2, #16
	mov	r1, #0
	blx	r3
	ldrsb	r3, [r7, #4]
	bics	r3, r3, #2
	bne	.L206
	cmp	r10, #1
	beq	.L267
	cmp	r10, #2
	addne	ip, r7, #20480
	beq	.L268
.L215:
	mov	r0, #1
	mov	r3, #0
	str	r3, [ip, #3332]
	str	r3, [ip, #3316]
.L249:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L206:
	add	r6, r7, #8192
	ldrb	r3, [r6, #2516]
	cmp	r3, #1
	ldrb	r3, [r6, #2553]
	beq	.L269
	cmp	r3, #0
	beq	.L270
.L225:
	add	ip, r7, #20480
	ldr	r3, [ip, #3272]
	ldr	r9, [r3, #1196]
	mov	r8, r9
.L224:
	cmp	r10, #1
	beq	.L271
.L226:
	cmp	r10, #2
	bne	.L215
	cmp	r4, #0
	mov	r2, #0
	mov	r3, #1
	str	r10, [ip, #3332]
	str	r10, [ip, #3316]
	strb	r2, [ip, #3312]
	strb	r3, [ip, #3313]
	beq	.L238
	cmp	r5, r2
	beq	.L272
.L238:
	ldr	r3, [ip, #3272]
	ldr	lr, [ip, #3264]
	ldr	r2, [r3, #1196]
.L265:
	ldr	r0, [ip, #3268]
	mov	r1, #1
	str	r2, [ip, #3320]
	mov	r3, #0
	strb	r1, [ip, #3329]
	strb	r3, [ip, #3328]
	ldr	r1, [r0, #1196]
	str	r1, [ip, #3336]
	ldr	r0, [r0, #1196]
	str	r0, [ip, #3340]
	ldr	r0, [r6, #2640]
	ldr	r8, [lr, #1196]
	cmp	r0, #1
	bls	.L273
	bics	r0, r0, #2
	beq	.L244
.L243:
	mov	ip, #1632
	mov	r3, r7
	mul	r8, ip, r8
	mul	r0, ip, r2
	mov	r2, #0
	mul	r1, ip, r1
	str	r2, [fp, #-572]
	add	r2, r8, #13952
	str	r2, [fp, #-568]
	add	r2, r8, #14208
	str	r2, [fp, #-560]
	ldr	r2, [fp, #-568]
	add	r10, r0, #13952
	add	r9, r0, #14208
	add	r5, r1, #13952
	add	r2, r2, #2
	str	r2, [fp, #-568]
	ldr	r2, [fp, #-560]
	add	r4, r1, #14208
	add	lr, r1, #14464
	add	ip, r1, #14720
	add	r1, r8, #14464
	add	r9, r9, #2
	add	r2, r2, #2
	add	r1, r1, #2
	add	r10, r10, #2
	str	r1, [fp, #-576]
	add	ip, ip, #2
	add	r7, r7, r10
	add	r8, r8, #14720
	str	r7, [fp, #-560]
	add	r7, r3, r9
	add	r9, r3, r2
	ldr	r2, [fp, #-576]
	add	r6, r0, #14464
	add	r8, r8, #2
	add	r1, r3, ip
	str	r8, [fp, #-580]
	add	r0, r0, #14720
	ldr	ip, [fp, #-568]
	add	r6, r6, #2
	add	r0, r0, #2
	add	r5, r5, #2
	add	r4, r4, #2
	add	lr, lr, #2
	add	r8, r3, r2
	ldr	r2, [fp, #-580]
	add	r6, r3, r6
	add	r0, r3, r0
	add	r5, r3, r5
	add	r4, r3, r4
	add	lr, r3, lr
	add	ip, r3, ip
	str	r7, [fp, #-564]
	add	r7, r3, r2
	mov	r2, #0
	str	r1, [fp, #-568]
.L245:
	ldr	r1, [fp, #-560]
	add	r2, r2, #1
	cmp	r2, #256
	add	r3, r3, #1
	ldrb	r10, [r1, #1]!
	str	r1, [fp, #-560]
	ldr	r1, [fp, #-564]
	strb	r10, [r3, #12]
	ldrb	r10, [r1, #1]!
	strb	r10, [r3, #268]
	ldrb	r10, [r6, #1]!
	str	r1, [fp, #-564]
	ldr	r1, [fp, #-568]
	strb	r10, [r3, #524]
	ldrb	r10, [r0, #1]!
	strb	r10, [r3, #780]
	ldrb	r10, [r5, #1]!
	strb	r10, [r3, #1036]
	ldrb	r10, [r4, #1]!
	strb	r10, [r3, #1292]
	ldrb	r10, [lr, #1]!
	strb	r10, [r3, #1548]
	ldrb	r10, [r1, #1]!
	strb	r10, [r3, #1804]
	ldrb	r10, [ip, #1]!
	str	r1, [fp, #-568]
	strb	r10, [r3, #2060]
	ldrb	r10, [r9, #1]!
	strb	r10, [r3, #2316]
	ldrb	r10, [r8, #1]!
	strb	r10, [r3, #2572]
	ldrb	r10, [r7, #1]!
	strb	r10, [r3, #2828]
	bne	.L245
	mov	r0, #1
.L277:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L270:
	add	ip, r7, #20480
	cmp	r10, #1
	ldr	r2, [ip, #3272]
	ldr	r3, [ip, #3268]
	ldr	r9, [r2, #1196]
	ldr	r8, [r3, #1196]
	bne	.L226
.L271:
	ldrb	r3, [r6, #2544]
	cmp	r4, #0
	mov	r2, #0
	strb	r10, [ip, #3313]
	add	r3, r3, #1
	str	r2, [ip, #3332]
	str	r3, [ip, #3316]
	strb	r2, [ip, #3312]
	beq	.L227
	cmp	r5, r2
	beq	.L274
.L227:
	ldr	r3, [ip, #3272]
	ldr	r2, [ip, #3264]
	ldr	r5, [r3, #1196]
.L264:
	str	r5, [ip, #3320]
	ldr	r3, [r3, #1196]
	str	r3, [ip, #3324]
	ldr	r3, [r6, #2640]
	ldr	r4, [r2, #1196]
	cmp	r3, #1
	bls	.L275
.L231:
	bics	r2, r3, #2
	bne	.L232
	ldrb	r2, [r6, #2526]
	cmp	r2, #4
	beq	.L276
.L232:
	mov	r1, #1632
	mov	r3, r7
	mul	r0, r1, r5
	mov	r2, #0
	mul	r1, r1, r4
	add	r8, r0, #13952
	add	r6, r0, #14208
	add	r5, r0, #14464
	add	r0, r0, #14720
	add	r4, r1, #13952
	add	lr, r1, #14208
	add	ip, r1, #14464
	add	r1, r1, #14720
	add	r8, r8, #2
	add	r6, r6, #2
	add	r5, r5, #2
	add	r0, r0, #2
	add	r4, r4, #2
	add	lr, lr, #2
	add	ip, ip, #2
	add	r1, r1, #2
	add	r7, r7, r8
	add	r6, r3, r6
	add	r5, r3, r5
	add	r0, r3, r0
	add	r4, r3, r4
	add	lr, r3, lr
	add	ip, r3, ip
	add	r1, r3, r1
.L237:
	ldrb	r8, [r7, #1]!
	add	r2, r2, #1
	cmp	r2, #256
	add	r3, r3, #1
	strb	r8, [r3, #12]
	ldrb	r8, [r6, #1]!
	strb	r8, [r3, #268]
	ldrb	r8, [r5, #1]!
	strb	r8, [r3, #524]
	ldrb	r8, [r0, #1]!
	strb	r8, [r3, #780]
	ldrb	r8, [r4, #1]!
	strb	r8, [r3, #2060]
	ldrb	r8, [lr, #1]!
	strb	r8, [r3, #2316]
	ldrb	r8, [ip, #1]!
	strb	r8, [r3, #2572]
	ldrb	r8, [r1, #1]!
	strb	r8, [r3, #2828]
	bne	.L237
	mov	r0, #1
	b	.L277
.L267:
	add	r2, r7, #20480
	ldr	r1, [r2, #3272]
	str	r10, [r2, #3316]
	str	r3, [r2, #3332]
	strb	r3, [r2, #3312]
	ldr	r4, [r1, #1196]
	str	r4, [r2, #3320]
	ldrb	r3, [r7, #3096]
	cmp	r3, #0
	add	r3, r7, #8192
	beq	.L208
	ldr	r2, [r3, #2556]
	ldrb	r5, [r3, #2528]
	cmp	r2, #2
	ldrb	r6, [r3, #2529]
	ldrb	r0, [r3, #2526]
	beq	.L278
.L209:
	cmp	r0, #4
	beq	.L210
.L211:
	mov	r3, #1632
	add	r6, r7, #12
	mul	r2, r3, r4
	add	r5, r7, #268
	add	r4, r7, #524
	add	lr, r7, #780
	mov	r3, #0
	add	ip, r2, #13952
	add	r0, r2, #14208
	add	r1, r2, #14464
	add	r2, r2, #14720
	add	ip, ip, #2
	add	r0, r0, #2
	add	r1, r1, #2
	add	r2, r2, #2
	add	ip, r7, ip
	add	r0, r7, r0
	add	r1, r7, r1
	add	r7, r7, r2
.L213:
	ldrb	r2, [ip, #1]!
	add	r3, r3, #1
	cmp	r3, #256
	strb	r2, [r6, #1]!
	ldrb	r2, [r0, #1]!
	strb	r2, [r5, #1]!
	ldrb	r2, [r1, #1]!
	strb	r2, [r4, #1]!
	ldrb	r2, [r7, #1]!
	strb	r2, [lr, #1]!
	bne	.L213
	mov	r0, #1
	b	.L277
.L269:
	cmp	r3, #0
	beq	.L225
	add	ip, r7, #20480
	ldr	r2, [ip, #3268]
	ldr	r3, [ip, #3272]
	ldr	r9, [r2, #1196]
	ldr	r8, [r3, #1196]
	b	.L224
.L268:
	add	r2, r7, #20480
	mov	r1, #1
	ldr	r0, [r2, #3272]
	str	r1, [r2, #3332]
	str	r1, [r2, #3316]
	strb	r3, [r2, #3312]
	ldr	r1, [r2, #3268]
	ldr	r5, [r0, #1196]
	strb	r3, [r2, #3328]
	str	r5, [r2, #3320]
	ldr	r4, [r1, #1196]
	str	r4, [r2, #3336]
	ldrb	r3, [r7, #3096]
	cmp	r3, #0
	add	r3, r7, #8192
	ldrneb	r6, [r3, #2528]
	ldrneb	r8, [r3, #2529]
	ldreqb	r6, [r3, #2425]
	ldreqb	r8, [r3, #2426]
	ldrneb	r3, [r3, #2526]
	ldreqb	r3, [r3, #2423]
	cmp	r3, #4
	beq	.L279
.L218:
	mov	r0, #1632
	mov	r3, r7
	mul	r1, r0, r5
	mov	r2, #0
	mul	r0, r0, r4
	add	r8, r1, #13952
	add	r6, r1, #14208
	add	r5, r1, #14464
	add	r1, r1, #14720
	add	r4, r0, #13952
	add	lr, r0, #14208
	add	ip, r0, #14464
	add	r0, r0, #14720
	add	r8, r8, #2
	add	r6, r6, #2
	add	r5, r5, #2
	add	r1, r1, #2
	add	r4, r4, #2
	add	lr, lr, #2
	add	ip, ip, #2
	add	r0, r0, #2
	add	r7, r7, r8
	add	r6, r3, r6
	add	r5, r3, r5
	add	r1, r3, r1
	add	r4, r3, r4
	add	lr, r3, lr
	add	ip, r3, ip
	add	r0, r3, r0
.L220:
	ldrb	r8, [r7, #1]!
	add	r2, r2, #1
	cmp	r2, #256
	add	r3, r3, #1
	strb	r8, [r3, #12]
	ldrb	r8, [r6, #1]!
	strb	r8, [r3, #268]
	ldrb	r8, [r5, #1]!
	strb	r8, [r3, #524]
	ldrb	r8, [r1, #1]!
	strb	r8, [r3, #780]
	ldrb	r8, [r4, #1]!
	strb	r8, [r3, #1036]
	ldrb	r8, [lr, #1]!
	strb	r8, [r3, #1292]
	ldrb	r8, [ip, #1]!
	strb	r8, [r3, #1548]
	ldrb	r8, [r0, #1]!
	strb	r8, [r3, #1804]
	bne	.L220
	mov	r0, #1
	b	.L277
.L208:
	ldrb	r5, [r3, #2425]
	ldrb	r6, [r3, #2426]
	ldrb	r0, [r3, #2423]
	b	.L209
.L244:
	ldrb	r3, [r6, #2526]
	cmp	r3, #4
	bne	.L243
	b	.L249
.L274:
	ldr	r2, [ip, #3264]
	ldr	r3, [ip, #3272]
	ldr	r5, [r2, #1196]
	b	.L264
.L272:
	ldr	lr, [ip, #3264]
	ldr	r2, [lr, #1196]
	b	.L265
.L275:
	ldrb	r3, [r6, #2526]
	cmp	r3, #4
	bne	.L232
	ldrb	ip, [r6, #2529]
	mov	r3, #0
	ldrb	r10, [r6, #2528]
	sub	r0, fp, #556
	mov	r2, ip
	str	ip, [fp, #-560]
	mov	r1, r10
	bl	VC1_Vfmw_GenerateIntensityMap
	ldr	ip, [fp, #-560]
	mov	r1, r10
	sub	r0, fp, #300
	mov	r3, #1
	mov	r2, ip
	bl	VC1_Vfmw_GenerateIntensityMap
	mov	r2, #1632
	mul	r2, r2, r9
	mov	r0, #0
	add	r1, r2, #13952
	add	r2, r2, #14208
	add	r1, r1, #3
	add	r2, r2, #3
	add	r1, r7, r1
	add	r2, r7, r2
.L233:
	ldrb	r3, [r1]
	sub	ip, fp, #44
	add	r0, r0, #1
	add	r3, ip, r3
	cmp	r0, #256
	ldrb	r3, [r3, #-512]
	strb	r3, [r1], #1
	ldrb	r3, [r2]
	add	r3, ip, r3
	ldrb	r3, [r3, #-256]
	strb	r3, [r2], #1
	bne	.L233
	ldr	r3, [r6, #2640]
	b	.L231
.L273:
	ldrb	r0, [r6, #2526]
	cmp	r0, #4
	bne	.L243
	mov	r0, r3
	b	.L249
.L276:
	cmp	r3, #0
	sub	r0, fp, #556
	mov	r3, #0
	ldreqb	r9, [r6, #2644]
	ldrneb	r9, [r6, #2528]
	ldreqb	r6, [r6, #2648]
	ldrneb	r6, [r6, #2529]
	mov	r1, r9
	mov	r2, r6
	bl	VC1_Vfmw_GenerateIntensityMap
	mov	r2, r6
	mov	r1, r9
	mov	r3, #1
	sub	r0, fp, #300
	bl	VC1_Vfmw_GenerateIntensityMap
	mov	r3, #1632
	mul	r2, r3, r8
	mov	r0, #0
	add	r1, r2, #14464
	add	r2, r2, #14720
	add	r1, r1, #3
	add	r2, r2, #3
	add	r1, r7, r1
	add	r2, r7, r2
.L236:
	ldrb	r3, [r1]
	sub	ip, fp, #44
	add	r0, r0, #1
	add	r3, ip, r3
	cmp	r0, #256
	ldrb	r3, [r3, #-512]
	strb	r3, [r1], #1
	ldrb	r3, [r2]
	add	r3, ip, r3
	ldrb	r3, [r3, #-256]
	strb	r3, [r2], #1
	bne	.L236
	b	.L232
.L278:
	ldr	r3, [r3, #2632]
	cmp	r3, #1
	bne	.L209
.L210:
	mov	r3, #0
	mov	r2, r6
	mov	r1, r5
	sub	r0, fp, #556
	bl	VC1_Vfmw_GenerateIntensityMap
	mov	r2, r6
	mov	r1, r5
	mov	r3, #1
	sub	r0, fp, #300
	bl	VC1_Vfmw_GenerateIntensityMap
	mov	r3, #1632
	mul	r3, r3, r4
	mov	lr, #0
	add	ip, r3, #13952
	add	r0, r3, #14208
	add	r1, r3, #14464
	add	r3, r3, #14720
	add	ip, ip, #3
	add	r0, r0, #3
	add	r1, r1, #3
	add	r3, r3, #3
	add	ip, r7, ip
	add	r0, r7, r0
	add	r1, r7, r1
	add	r2, r7, r3
.L212:
	ldrb	r3, [ip]
	sub	r5, fp, #44
	add	lr, lr, #1
	add	r3, r5, r3
	cmp	lr, #256
	ldrb	r3, [r3, #-512]
	strb	r3, [ip], #1
	ldrb	r3, [r0]
	add	r3, r5, r3
	ldrb	r3, [r3, #-256]
	strb	r3, [r0], #1
	ldrb	r3, [r1]
	add	r3, r5, r3
	ldrb	r3, [r3, #-512]
	strb	r3, [r1], #1
	ldrb	r3, [r2]
	add	r3, r5, r3
	ldrb	r3, [r3, #-256]
	strb	r3, [r2], #1
	bne	.L212
	b	.L211
.L279:
	mov	r2, r8
	mov	r1, r6
	mov	r3, #0
	sub	r0, fp, #556
	bl	VC1_Vfmw_GenerateIntensityMap
	mov	r2, r8
	mov	r1, r6
	sub	r0, fp, #300
	mov	r3, #1
	mov	r10, #0
	bl	VC1_Vfmw_GenerateIntensityMap
	mov	r2, #1632
	mul	r1, r2, r5
	str	r4, [fp, #-560]
	mul	r2, r2, r4
	add	r9, r1, #13952
	add	r8, r1, #14208
	add	r6, r1, #14464
	add	r1, r1, #14720
	add	lr, r2, #13952
	add	ip, r2, #14208
	add	r0, r2, #14464
	add	r2, r2, #14720
	add	r9, r9, #3
	add	r8, r8, #3
	add	r6, r6, #3
	add	r1, r1, #3
	add	lr, lr, #3
	add	ip, ip, #3
	add	r0, r0, #3
	add	r2, r2, #3
	add	r9, r7, r9
	add	r8, r7, r8
	add	r6, r7, r6
	add	r1, r7, r1
	add	lr, r7, lr
	add	ip, r7, ip
	add	r0, r7, r0
	add	r2, r7, r2
.L219:
	ldrb	r3, [r9]
	sub	r4, fp, #44
	add	r10, r10, #1
	add	r3, r4, r3
	cmp	r10, #256
	ldrb	r3, [r3, #-512]
	strb	r3, [r9], #1
	ldrb	r3, [r8]
	add	r3, r4, r3
	ldrb	r3, [r3, #-256]
	strb	r3, [r8], #1
	ldrb	r3, [r6]
	add	r3, r4, r3
	ldrb	r3, [r3, #-512]
	strb	r3, [r6], #1
	ldrb	r3, [r1]
	add	r3, r4, r3
	ldrb	r3, [r3, #-256]
	strb	r3, [r1], #1
	ldrb	r3, [lr]
	add	r3, r4, r3
	ldrb	r3, [r3, #-512]
	strb	r3, [lr], #1
	ldrb	r3, [ip]
	add	r3, r4, r3
	ldrb	r3, [r3, #-256]
	strb	r3, [ip], #1
	ldrb	r3, [r0]
	add	r3, r4, r3
	ldrb	r3, [r3, #-512]
	strb	r3, [r0], #1
	ldrb	r3, [r2]
	add	r3, r4, r3
	ldrb	r3, [r3, #-256]
	strb	r3, [r2], #1
	bne	.L219
	ldr	r4, [fp, #-560]
	b	.L218
.L281:
	.align	2
.L280:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VC1_Vfmw_BuildRefList, .-VC1_Vfmw_BuildRefList
	.align	2
	.global	VC1_Vfmw_GetStreamInfo
	.type	VC1_Vfmw_GetStreamInfo, %function
VC1_Vfmw_GetStreamInfo:
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
	add	r8, r0, #12288
	add	r4, r0, #32768
	mov	r5, r0
	ldrb	r3, [r8, #3536]
	ldr	r9, [r4, #3720]
	cmp	r3, #0
	beq	.L283
	add	r3, r0, #20480
	add	r2, r8, #3776
	ldr	r3, [r3, #2996]
	cmp	r3, #3
	ldr	r3, [r4, #3724]
	addeq	r3, r3, #1
	addeq	r3, r3, r3, lsr #31
	moveq	r3, r3, asr #1
	mul	r3, r3, r9
	str	r3, [fp, #-48]
	mov	r3, r2
	ldrh	r2, [r2, #2]
	ldrh	r3, [r3]
	adds	r1, r2, #15
	addmi	r1, r2, #30
	adds	r0, r3, #15
	addmi	r0, r3, #30
	mov	r1, r1, asr #4
	mov	r0, r0, asr #4
.L335:
	mov	r2, r0, asl #4
	movw	ip, #8160
	sub	r3, r2, #32
	cmp	r3, ip
	mov	r3, r1, asl #4
	bhi	.L286
	sub	lr, r3, #32
	cmp	lr, ip
	bhi	.L286
	ldr	r3, [r4, #3732]
	cmp	r3, r1
	beq	.L370
.L289:
	ldr	r2, [r4, #3724]
	mov	r3, r9, asl #4
	add	r3, r3, #63
	str	r9, [r4, #3728]
	bic	r3, r3, #63
	str	r3, [r4, #3744]
	str	r2, [r4, #3732]
	ldrb	r3, [r8, #448]
	cmp	r3, #0
	beq	.L297
	mov	r3, #1
.L291:
	ldrb	r2, [r8, #443]
	cmp	r2, #3
	beq	.L371
.L294:
	ldrb	r2, [r8, #440]
	eor	r2, r2, #8
	ubfx	r2, r2, #3, #1
	orrs	r3, r3, r2
	bne	.L297
.L301:
	mov	r0, r5
	bl	VC1_Vfmw_GetImageBuffer
	subs	r6, r0, #0
	beq	.L372
	add	r10, r5, #49152
	ldr	r1, [r4, #3796]
	ldr	r0, [r10, #224]
	bl	FSP_GetFsImagePtr
	subs	r3, r0, #0
	beq	.L303
	ldr	r0, [r5]
	add	r2, r3, #576
	add	ip, r3, #592
	ldr	r1, .L380
	ldrd	r6, [r0, #56]
	mov	r0, #29
	strd	r6, [r2, #-8]
	ldr	lr, [r5]
	ldrd	r6, [lr, #72]
	strd	r6, [r2]
	ldr	lr, [r5]
	ldrd	r6, [lr, #88]
	strd	r6, [ip, #-8]
	mvn	r6, #0
	ldr	ip, [r5]
	mvn	r7, #0
	ldr	ip, [ip, #104]
	str	ip, [r3, #8]
	ldr	ip, [r5]
	ldr	ip, [ip, #108]
	str	ip, [r3, #12]
	ldr	ip, [r5]
	ldr	ip, [ip, #112]
	str	ip, [r3, #16]
	ldr	ip, [r5]
	ldr	ip, [ip, #128]
	str	ip, [r3, #20]
	ldr	r3, [r5]
	strd	r6, [r3, #56]
	ldrd	r6, [r2]
	ldrd	r2, [r2, #-8]
	strd	r6, [sp]
	bl	dprint_vfmw
.L303:
	ldrb	r3, [r8, #3536]
	cmp	r3, #0
	beq	.L304
	add	r3, r5, #20480
	ldr	r3, [r3, #2996]
	cmp	r3, #3
	beq	.L373
.L304:
	ldr	r3, [r4, #3704]
	mov	r2, #0
	str	r2, [r3, #1136]
.L305:
	ldr	r3, [r4, #3704]
	mov	r2, #0
	strb	r2, [r3, #2]
	ldrb	r3, [r8, #3536]
	cmp	r3, r2
	bne	.L306
	add	r3, r5, #20480
	ldrb	r2, [r3, #2616]
	cmp	r2, #1
	ldreqb	r2, [r3, #2854]
	ldreq	r3, [r4, #3704]
	streqb	r2, [r3, #2]
.L306:
	ldrb	r3, [r8, #442]
	cmp	r3, #5
	cmpne	r3, #1
	ldr	r3, [r4, #3784]
	movls	r7, #1
	movhi	r7, #0
	bhi	.L307
	cmp	r3, #0
	ldr	r2, [r4, #3788]
	ldr	r3, [r4, #3792]
	movne	r1, #2
	moveq	r1, #1
	cmp	r2, r3
	str	r1, [r4, #3784]
	beq	.L309
	ldr	r1, .L380+4
	mov	r0, #13
	bl	dprint_vfmw
	mov	r2, #0
	ldr	r1, [r4, #3788]
	ldr	r0, [r10, #224]
	bl	FSP_SetRef
	ldr	r3, [r4, #3792]
.L309:
	ldr	r1, [r4, #3796]
	mov	r2, #1
	str	r3, [r4, #3788]
	str	r1, [r4, #3792]
	ldr	r0, [r10, #224]
	bl	FSP_SetRef
	ldr	r1, [r4, #3788]
	ldr	r0, [r10, #224]
	bl	FSP_RemovePmv
	ldrb	r3, [r8, #442]
	cmp	r3, #5
	cmpne	r3, #1
	bhi	.L311
	ldr	r3, [r4, #3712]
	mov	r1, #0
	mov	r2, #1
	strb	r1, [r3]
	ldr	r3, [r4, #3704]
	strb	r2, [r3]
	ldr	r2, [r4, #3708]
	ldr	r3, [r4, #3704]
	str	r2, [r4, #3712]
	str	r3, [r4, #3708]
.L311:
	ldr	r1, [r4, #3796]
	ldr	r0, [r10, #224]
	bl	FSP_GetLogicFs
	ldr	r1, [r4, #3788]
	mov	r6, r0
	ldr	r0, [r10, #224]
	bl	FSP_GetLogicFs
	ldr	r1, [r4, #3792]
	mov	r7, r0
	ldr	r0, [r10, #224]
	bl	FSP_GetLogicFs
	cmp	r6, #0
	cmpne	r7, #0
	moveq	r3, #1
	movne	r3, #0
	cmp	r0, #0
	orreq	r3, r3, #1
	mov	ip, r0
	cmp	r3, #0
	bne	.L374
	ldrb	r3, [r8, #3536]
	cmp	r3, #0
	bne	.L375
.L317:
	mov	r3, #0
.L365:
	str	r3, [r6, #104]
	ldrb	r3, [r8, #442]
	cmp	r3, #5
	beq	.L376
.L319:
	ldr	r3, [r6, #608]
	cmp	r3, #0
	beq	.L320
	ldr	r2, [r6, #616]
	cmp	r2, #0
	beq	.L320
	ldr	r2, [r6, #612]
	cmp	r2, #0
	beq	.L320
	ldr	r2, [ip, #608]
	cmp	r2, #0
	ldrne	r3, [r2, #16]
	ldreq	r3, [r3, #16]
	str	r3, [r8, #112]
	ldr	r3, [r7, #608]
	mov	r7, #0
	cmp	r3, #0
	ldreq	r3, [r6, #608]
	ldr	r3, [r3, #16]
	str	r3, [r8, #108]
	ldr	r3, [r6, #608]
	ldr	r3, [r3, #16]
	str	r3, [r8, #232]
	ldr	r3, [r6, #620]
	str	r3, [r8, #116]
	ldr	r3, [ip, #620]
	str	r3, [r8, #120]
	ldr	r3, [r6, #612]
	ldr	r3, [r3, #16]
	str	r3, [r8, #104]
	ldr	r3, [r6, #612]
	ldr	r3, [r3, #32]
	str	r3, [r8, #184]
	ldr	r3, [r6, #612]
	ldr	r3, [r3, #76]
	str	r3, [r8, #188]
	ldr	r3, [r6, #612]
	ldr	r3, [r3, #60]
	str	r3, [r8, #192]
	ldr	r3, [r6, #612]
	ldr	r3, [r3, #64]
	str	r3, [r8, #196]
	ldr	r3, [r6, #608]
	ldr	r6, [r4, #3704]
	ldr	r0, [r3, #16]
	bl	MEM_Phy2Vir
	str	r7, [r6, #1516]
	str	r0, [r6, #1512]
	ldr	r0, [r8, #108]
	ldr	r6, [r4, #3712]
	bl	MEM_Phy2Vir
	str	r7, [r6, #1516]
	str	r0, [r6, #1512]
	ldr	r0, [r8, #112]
	ldr	r6, [r4, #3708]
	bl	MEM_Phy2Vir
	str	r7, [r6, #1516]
	str	r0, [r6, #1512]
.L296:
	add	r3, r8, #3536
	ldrsb	r3, [r3]
	cmp	r3, #0
	beq	.L377
	add	ip, r5, #20480
	ldr	r3, [r4, #3704]
	ldr	r2, [ip, #2996]
	strb	r2, [r3, #1027]
	ldr	r3, [r4, #3704]
	ldrb	r2, [ip, #2953]
	strb	r2, [r3, #1028]
	ldrb	r2, [ip, #2966]
	ldr	r3, [r4, #3704]
	sub	r0, r2, #2
	ldrb	r1, [ip, #2993]
	cmp	r0, #1
	movls	r2, #1
	bls	.L329
	cmp	r2, #4
	movne	r2, #0
	beq	.L378
.L329:
	add	r3, r3, r1
	strb	r2, [r3, #1029]
	ldr	r0, [r4, #3804]
	cmp	r0, #0
	beq	.L330
	sub	r0, r0, #1
	cmp	r0, #0
	mov	lr, r0
	uxtble	r1, r0
	ble	.L332
	add	r2, r5, #36352
	mov	r1, #0
	add	r2, r2, #232
.L333:
	ldr	r3, [r2, #64]
	add	r2, r2, #48
	strb	r1, [r2, #-48]
	add	r1, r1, #1
	cmp	r1, lr
	mul	r3, r3, r9
	sub	r3, r3, #1
	str	r3, [r2, #-32]
	bne	.L333
	uxtb	r1, r1
.L332:
	mov	r3, r0, asl #6
	movw	r2, #24312
	sub	r0, r3, r0, asl #4
	ldr	r3, [fp, #-48]
	add	r0, r8, r0
	movw	lr, #24296
	sub	r3, r3, #1
	strb	r1, [r0, lr]
	str	r3, [r0, r2]
	ldrb	r1, [r8, #442]
	cmp	r1, #2
	bne	.L328
	ldrb	r3, [ip, #2983]
	add	r0, r5, #45056
	ldr	r2, [ip, #3100]
	mul	r2, r2, r3
	mov	r2, r2, asr #8
	str	r2, [r0, #3848]
	rsb	r3, r2, r3
	subs	r3, r3, #1
	movmi	r3, #0
	str	r3, [r0, #3852]
	b	.L328
.L286:
	ldr	r1, .L380+8
	mov	r0, #0
	bl	dprint_vfmw
	mov	r6, #0
.L362:
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L283:
	ldr	r1, [r4, #3724]
	mov	r0, r9
	mul	r3, r1, r9
	str	r3, [fp, #-48]
	b	.L335
.L297:
	add	r10, r5, #49152
	add	r3, r5, #34816
	add	r3, r3, #24
	ldr	r1, [r4, #3792]
	str	r3, [r4, #3704]
	str	r3, [r4, #3716]
	str	r3, [r4, #3712]
	str	r3, [r4, #3708]
	ldr	r0, [r10, #224]
	bl	FSP_GetFsImagePtr
	subs	r6, r0, #0
	beq	.L293
	ldr	r1, [r6, #528]
	add	r3, r6, #560
	ldr	r0, [r10, #224]
	add	r7, r6, #544
	str	r3, [fp, #-52]
	bl	FreeUsdByDec
	ldr	r1, [r6, #536]
	add	r3, r6, #528
	ldr	r0, [r10, #224]
	str	r3, [fp, #-56]
	bl	FreeUsdByDec
	ldr	r1, [r6, #544]
	ldr	r0, [r10, #224]
	bl	FreeUsdByDec
	ldr	r6, [fp, #-52]
	ldr	r0, [r10, #224]
	ldr	r1, [r6, #-8]
	bl	FreeUsdByDec
	ldr	r3, [fp, #-56]
	mov	r0, #0
	mov	r1, #0
	mov	r2, #1
	strd	r0, [r3]
	strd	r0, [r7, #-8]
	strd	r0, [r7]
	strd	r0, [r6, #-8]
	ldr	r1, [r4, #3792]
	ldr	r0, [r10, #224]
	bl	FSP_ClearLogicFs
	mov	r2, #1
	ldr	r1, [r4, #3788]
	ldr	r0, [r10, #224]
	bl	FSP_ClearLogicFs
	mov	r3, #0
	str	r3, [r4, #3788]
	str	r3, [r4, #3792]
	ldr	r0, [r10, #224]
	bl	FSP_GetNullLogicFs
	str	r0, [r4, #3792]
	str	r0, [r4, #3788]
.L293:
	add	r3, r5, #26624
	add	r1, r5, #34816
	add	r3, r3, #57
	add	r1, r1, #25
	mov	r2, #0
	str	r2, [r4, #3784]
.L299:
	strb	r2, [r3]
	add	r3, r3, #1632
	strb	r2, [r3, #-1633]
	cmp	r3, r1
	bne	.L299
	add	r7, r5, #48896
	ldr	r0, [r10, #224]
	add	r7, r7, #128
	mov	r1, r7
	bl	FSP_ClearNotInVoQueue
	ldrb	r6, [r8, #440]
	and	r6, r6, #8
	ands	r6, r6, #255
	bne	.L301
	mov	r0, r7
	bl	ResetVoQueue
	ldr	r1, [r5]
	mov	r3, #2
	mov	r0, r5
	ldr	r2, [r1, #660]
	ldr	ip, [r1, #664]
	adds	r1, r2, #15
	addmi	r1, r2, #30
	adds	r2, ip, #15
	addmi	r2, ip, #30
	mov	r1, r1, asr #4
	str	r1, [r8, #272]
	mov	r2, r2, asr #4
	str	r2, [r8, #276]
	add	r2, r2, #1
	mov	r1, r1, asl #4
	add	r2, r2, r2, lsr #31
	mov	r2, r2, asr #1
	mov	r2, r2, asl #5
	bl	VC1_ArrangeVahbMem
	cmp	r0, #1
	bne	.L300
	ldrb	r3, [r8, #440]
	orr	r3, r3, #8
	strb	r3, [r8, #440]
	b	.L301
.L372:
	ldr	r1, .L380+12
	mov	r0, #1
	bl	dprint_vfmw
	b	.L362
.L370:
	ldr	r3, [r4, #3728]
	cmp	r3, r0
	bne	.L289
	mov	r3, r9, asl #4
	add	r3, r3, #63
	bic	r3, r3, #63
	str	r3, [r4, #3744]
	ldrb	r3, [r8, #448]
	cmp	r3, #0
	movne	r3, #0
	bne	.L291
	b	.L294
.L307:
	cmp	r3, #1
	bhi	.L311
	ldr	r0, [r10, #224]
	mov	r2, #1
	ldr	r1, [r4, #3796]
	mov	r6, r7
	bl	FSP_ClearLogicFs
	ldr	r3, [r4, #3704]
	ldr	r1, .L380+16
	mov	r0, #1
	strb	r7, [r3]
	ldr	r3, [r4, #3704]
	strb	r7, [r3, #1]
	bl	dprint_vfmw
	b	.L362
.L374:
	ldr	r1, [r4, #3796]
	mov	r2, #1
	str	r0, [fp, #-48]
	ldr	r0, [r10, #224]
	bl	FSP_ClearLogicFs
	ldr	r1, [r4, #3704]
	mov	lr, #0
	ldr	ip, [fp, #-48]
	mov	r3, r6
	mov	r0, lr
	strb	lr, [r1]
	movw	r2, #2387
	ldr	r4, [r4, #3704]
	ldr	r1, .L380+20
	strb	lr, [r4, #1]
	stmia	sp, {r7, ip}
	bl	dprint_vfmw
	ldrb	r3, [r8, #442]
	cmp	r3, #5
	beq	.L369
.L315:
	ldr	r1, .L380+24
	mov	r0, #1
	bl	dprint_vfmw
	mov	r6, #0
	b	.L362
.L377:
	ldr	r1, [r4, #3704]
	add	r2, r5, #20480
	strb	r3, [r1, #1027]
	ldr	r1, [r4, #3704]
	ldrb	r0, [r2, #2855]
	strb	r0, [r1, #1028]
	ldrb	r0, [r2, #2863]
	ldr	r1, [r4, #3704]
	sub	ip, r0, #2
	cmp	ip, #1
	movls	r3, #1
	bls	.L327
	cmp	r0, #4
	beq	.L379
.L327:
	add	r6, r5, #45056
	strb	r3, [r1, #1030]
	strb	r3, [r1, #1029]
	mov	r2, #1
	mov	r3, #0
	str	r2, [r4, #3804]
	strb	r3, [r4, #3816]
	ldr	r0, [r8, #3568]
	ldr	r7, [r6, #3812]
	bl	BsPos
	add	r3, r0, #7
	cmp	r0, #0
	movlt	r0, r3
	add	r0, r7, r0, asr #3
	str	r0, [r4, #3808]
	ldr	r0, [r8, #3568]
	ldr	r7, [r6, #3824]
	bl	BsPos
	add	r3, r0, #7
	cmp	r0, #0
	movlt	r0, r3
	add	r0, r7, r0, asr #3
	str	r0, [r4, #3820]
	ldr	r0, [r8, #3568]
	bl	BsPos
	and	r0, r0, #7
	str	r0, [r4, #3824]
	ldr	r0, [r8, #3568]
	ldr	r7, [r6, #3832]
	bl	BsPos
	mov	r7, r7, asl #3
	rsb	r0, r0, r7
	str	r0, [r4, #3828]
	ldr	r2, [r6, #3872]
	ldr	r3, [r6, #3876]
	mul	r3, r3, r2
	sub	r3, r3, #1
	str	r3, [r4, #3832]
	ldrb	r1, [r8, #442]
.L328:
	add	r0, r5, #12672
	mov	r3, #1
	add	r0, r0, #56
	mov	r2, #0
	bl	VC1_Vfmw_BuildRefList
	subs	r6, r0, #0
	movne	r6, #1
	bne	.L362
	add	r5, r5, #49152
	ldr	r1, [r4, #3796]
	mov	r2, #1
	ldr	r0, [r5, #224]
	bl	FSP_ClearLogicFs
	ldr	r3, [r4, #3704]
	ldr	r1, .L380+28
	mov	r0, #1
	strb	r6, [r3]
	ldr	r3, [r4, #3704]
	strb	r6, [r3, #1]
	bl	dprint_vfmw
	b	.L362
.L375:
	add	r3, r5, #20480
	ldr	r3, [r3, #2996]
	cmp	r3, #3
	bne	.L317
	ldr	r3, .L380+32
	ldr	r3, [r3]
	cmp	r3, #1
	bne	.L317
	b	.L365
.L320:
	ldr	r0, [r10, #224]
	mov	r2, #1
	ldr	r1, [r4, #3796]
	bl	FSP_ClearLogicFs
	ldr	r2, [r4, #3704]
	mov	r3, #0
	ldr	r1, .L380+36
	mov	r0, r3
	strb	r3, [r2]
	ldr	r2, [r4, #3704]
	strb	r3, [r2, #1]
	ldr	ip, [r6, #612]
	ldr	r3, [r4, #3796]
	ldr	r2, [r4, #3788]
	str	ip, [sp, #12]
	ldr	ip, [r6, #616]
	ldr	lr, [r4, #3792]
	str	ip, [sp, #8]
	ldr	ip, [r6, #608]
	str	lr, [sp]
	str	ip, [sp, #4]
	bl	dprint_vfmw
	ldrb	r3, [r8, #442]
	cmp	r3, #5
	bne	.L315
.L369:
	add	r5, r5, #45056
	ldr	r3, [r5, #3892]
	cmp	r3, #0
	subgt	r3, r3, #1
	strgt	r3, [r5, #3892]
	b	.L315
.L371:
	ldrb	r2, [r8, #449]
	cmp	r2, #1
	bne	.L296
	b	.L294
.L376:
	ldr	r3, [r7, #104]
	add	r2, r5, #45056
	str	r3, [r6, #104]
	ldr	r1, [r4, #3712]
	ldr	r3, [r4, #3704]
	ldr	r1, [r1, #1136]
	str	r1, [r3, #1136]
	ldr	r3, [r2, #3892]
	add	r3, r3, #1
	str	r3, [r2, #3892]
	b	.L319
.L330:
	mov	r3, #1
	mov	r1, r0
	str	r3, [r4, #3804]
	b	.L332
.L373:
	ldr	r3, .L380+32
	ldr	r3, [r3]
	cmp	r3, #1
	ldreq	r2, [r4, #3704]
	streq	r3, [r2, #1136]
	bne	.L304
	b	.L305
.L300:
	ldr	r1, .L380+40
	mov	r0, #1
	bl	dprint_vfmw
	ldrb	r3, [r8, #440]
	bic	r3, r3, #8
	strb	r3, [r8, #440]
	b	.L362
.L378:
	ldrb	r2, [ip, #2967]
	sub	r2, r2, #2
	cmp	r2, #1
	movhi	r2, #0
	movls	r2, #1
	b	.L329
.L379:
	ldrb	r3, [r2, #2864]
	sub	r3, r3, #2
	cmp	r3, #1
	movhi	r3, #0
	movls	r3, #1
	b	.L327
.L381:
	.align	2
.L380:
	.word	.LC30
	.word	.LC31
	.word	.LC20
	.word	.LC29
	.word	.LC32
	.word	.LC33
	.word	.LC34
	.word	.LC36
	.word	USE_FF_APT_EN
	.word	.LC35
	.word	.LC28
	.fnend
	.size	VC1_Vfmw_GetStreamInfo, .-VC1_Vfmw_GetStreamInfo
	.align	2
	.global	VC1_Vfmw_PrepareDecode
	.type	VC1_Vfmw_PrepareDecode, %function
VC1_Vfmw_PrepareDecode:
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
	bl	VC1_Vfmw_GetStreamInfo
	subs	r4, r0, #0
	movne	r4, #1
	bne	.L383
	ldr	r1, .L385
	bl	dprint_vfmw
.L383:
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L386:
	.align	2
.L385:
	.word	.LC37
	.fnend
	.size	VC1_Vfmw_PrepareDecode, .-VC1_Vfmw_PrepareDecode
	.align	2
	.global	VC1_DecMvrange
	.type	VC1_DecMvrange, %function
VC1_DecMvrange:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, fp, ip, lr, pc}
	.pad #4
	.save {r4, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #68
	sub	sp, sp, #68
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	lr, .L388
	mov	r4, r0
	sub	ip, fp, #84
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
	mov	r0, r4
	mov	r1, #3
	bl	BsShow
	sub	r3, fp, #20
	add	r3, r3, r0, lsl #3
	mov	r0, r4
	ldr	r1, [r3, #-60]
	ldr	r4, [r3, #-64]
	bl	BsSkip
	mov	r0, r4
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L389:
	.align	2
.L388:
	.word	.LANCHOR0+16
	.fnend
	.size	VC1_DecMvrange, .-VC1_DecMvrange
	.align	2
	.global	VC1_DecTransacfrm
	.type	VC1_DecTransacfrm, %function
VC1_DecTransacfrm:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, fp, ip, lr, pc}
	.pad #4
	.save {r4, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #68
	sub	sp, sp, #68
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r2, #64
	mov	r4, r0
	mov	r1, #0
	sub	r0, fp, #84
	bl	memset
	mov	r3, #2
	mov	r1, r3
	mov	r0, r4
	mov	r2, #1
	str	r3, [fp, #-64]
	str	r3, [fp, #-60]
	str	r3, [fp, #-56]
	str	r2, [fp, #-80]
	str	r2, [fp, #-72]
	str	r2, [fp, #-68]
	bl	BsShow
	sub	r3, fp, #20
	add	r3, r3, r0, lsl #3
	mov	r0, r4
	ldr	r1, [r3, #-60]
	ldr	r4, [r3, #-64]
	bl	BsSkip
	mov	r0, r4
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
	.fnend
	.size	VC1_DecTransacfrm, .-VC1_DecTransacfrm
	.align	2
	.global	VC1_SetCurPicResolutionInfo
	.type	VC1_SetCurPicResolutionInfo, %function
VC1_SetCurPicResolutionInfo:
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
	add	r3, r0, #20480
	cmp	r1, #1
	add	r0, r0, #32768
	ldr	r2, [r3, #3280]
	beq	.L393
	cmp	r1, #2
	beq	.L399
	cmp	r1, #0
	beq	.L398
	add	r2, r2, #1
	add	r2, r2, r2, lsr #31
	mov	r2, r2, asr #1
.L399:
	str	r2, [r0, #3432]
	ldr	r3, [r3, #3284]
	add	r3, r3, #1
	add	r3, r3, r3, lsr #31
	mov	r3, r3, asr #1
	str	r3, [r0, #3436]
	b	.L396
.L393:
	add	r2, r2, #1
	add	r2, r2, r2, lsr #31
	mov	r2, r2, asr #1
.L398:
	str	r2, [r0, #3432]
	ldr	r3, [r3, #3284]
	str	r3, [r0, #3436]
.L396:
	mul	r1, r3, r2
	mov	r2, r2, asl #4
	mov	r3, r3, asl #4
	str	r2, [r0, #3424]
	str	r3, [r0, #3428]
	str	r1, [r0, #3440]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VC1_SetCurPicResolutionInfo, .-VC1_SetCurPicResolutionInfo
	.align	2
	.global	VC1_DecMvmodeProgrP
	.type	VC1_DecMvmodeProgrP, %function
VC1_DecMvmodeProgrP:
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
	mov	r6, r1
	mov	r1, #4
	mov	r7, r0
	bl	BsShow
	ldr	ip, .L411
	sub	r4, fp, #76
	sub	lr, fp, #56
	mov	r5, r0
	cmp	r0, #1
	ldmia	ip!, {r0, r1, r2, r3}
	ldr	r8, [ip], #4
	stmia	r4!, {r0, r1, r2, r3}
	ldmia	ip!, {r0, r1, r2, r3}
	str	r8, [r4]
	ldr	ip, [ip]
	stmia	lr!, {r0, r1, r2, r3}
	str	ip, [lr]
	ble	.L409
	cmp	r5, #3
	movle	r1, #3
	movle	r4, #2
	bgt	.L410
.L402:
	mov	r0, r7
	bl	BsSkip
	sub	r3, fp, #36
	add	r4, r3, r4, lsl #2
	cmp	r6, #12
	ldrhi	r0, [r4, #-40]
	ldrls	r0, [r4, #-20]
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L410:
	cmp	r5, #8
	movlt	r1, #2
	movge	r1, #1
	movlt	r4, #1
	movge	r4, #0
	b	.L402
.L409:
	cmp	r5, #0
	mov	r1, #4
	moveq	r4, #3
	movne	r4, r1
	b	.L402
.L412:
	.align	2
.L411:
	.word	.LANCHOR0+80
	.fnend
	.size	VC1_DecMvmodeProgrP, .-VC1_DecMvmodeProgrP
	.align	2
	.global	VC1_DecMvmodeProgrB
	.type	VC1_DecMvmodeProgrB, %function
VC1_DecMvmodeProgrB:
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
	mov	r1, #1
	bl	BsSkip
	ldr	r2, .L414
	sub	r3, fp, #12
	add	r3, r3, r0, lsl #2
	ldmia	r2, {r0, r1}
	sub	r2, fp, #12
	stmdb	r2, {r0, r1}
	ldr	r0, [r3, #-8]
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L415:
	.align	2
.L414:
	.word	.LANCHOR0+120
	.fnend
	.size	VC1_DecMvmodeProgrB, .-VC1_DecMvmodeProgrB
	.align	2
	.global	VC1_DecMvmodeInterB
	.type	VC1_DecMvmodeInterB, %function
VC1_DecMvmodeInterB:
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
	mov	r1, #3
	mov	r6, r0
	bl	BsShow
	ldr	r3, .L424
	sub	lr, fp, #72
	mov	r8, #0
	mov	r9, #1
	mov	ip, #2
	mov	r4, #3
	str	r8, [fp, #-52]
	str	r8, [fp, #-40]
	str	r9, [fp, #-56]
	str	ip, [fp, #-48]
	str	r4, [fp, #-44]
	mov	r7, r0
	cmp	r0, #1
	ldmia	r3, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	ble	.L423
	cmp	r7, #4
	movlt	r1, #2
	movge	r1, #1
	movlt	r4, #1
	movge	r4, #0
.L418:
	mov	r0, r6
	bl	BsSkip
	sub	r3, fp, #36
	add	ip, r3, r4, lsl #2
	cmp	r5, #12
	ldrhi	r0, [ip, #-36]
	ldrls	r0, [ip, #-20]
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L423:
	cmp	r7, r8
	mov	r1, r4
	movne	r4, ip
	b	.L418
.L425:
	.align	2
.L424:
	.word	.LANCHOR0+128
	.fnend
	.size	VC1_DecMvmodeInterB, .-VC1_DecMvmodeInterB
	.align	2
	.global	VC1_DecMvmode2
	.type	VC1_DecMvmode2, %function
VC1_DecMvmode2:
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
	mov	r5, r1
	mov	r1, #3
	mov	r6, r0
	bl	BsShow
	ldr	r3, .L435
	sub	lr, fp, #60
	add	ip, r3, #16
	mov	r4, r0
	cmp	r0, #1
	ldmia	r3, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	sub	ip, fp, #28
	stmdb	ip, {r0, r1, r2, r3}
	ble	.L434
	cmp	r4, #4
	movlt	r1, #2
	movge	r1, #1
	movlt	r4, #1
	movge	r4, #0
.L428:
	mov	r0, r6
	bl	BsSkip
	sub	r3, fp, #28
	add	r4, r3, r4, lsl #2
	cmp	r5, #12
	ldrhi	r0, [r4, #-32]
	ldrls	r0, [r4, #-16]
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L434:
	cmp	r4, #0
	mov	r1, #3
	moveq	r4, r1
	movne	r4, #2
	b	.L428
.L436:
	.align	2
.L435:
	.word	.LANCHOR0+128
	.fnend
	.size	VC1_DecMvmode2, .-VC1_DecMvmode2
	.align	2
	.global	VC1_DecBfractionSMP
	.type	VC1_DecBfractionSMP, %function
VC1_DecBfractionSMP:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #220
	sub	sp, sp, #220
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	ip, .L443
	sub	r10, fp, #244
	str	r0, [fp, #-248]
	sub	r8, fp, #216
	str	r1, [fp, #-252]
	sub	r5, fp, #156
	str	r2, [fp, #-256]
	sub	lr, fp, #100
	ldmia	ip!, {r0, r1, r2, r3}
	sub	r7, fp, #188
	add	r9, ip, #12
	add	r6, ip, #40
	stmia	r10!, {r0, r1, r2, r3}
	add	r4, ip, #96
	ldmia	ip, {r0, r1, r2}
	add	ip, ip, #152
	stmia	r10, {r0, r1, r2}
	ldmia	r9!, {r0, r1, r2, r3}
	stmia	r8!, {r0, r1, r2, r3}
	ldmia	r9, {r0, r1, r2}
	stmia	r8, {r0, r1, r2}
	ldmia	r6!, {r0, r1, r2, r3}
	stmia	r5!, {r0, r1, r2, r3}
	ldmia	r6!, {r0, r1, r2, r3}
	stmia	r5!, {r0, r1, r2, r3}
	ldmia	r6!, {r0, r1, r2, r3}
	stmia	r5!, {r0, r1, r2, r3}
	ldmia	r6, {r0, r1}
	stmia	r5, {r0, r1}
	ldmia	r4!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	r4!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	r4!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	r4, {r0, r1}
	stmia	lr, {r0, r1}
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	r7!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	r7, {r0, r1, r2, r3}
	mov	r1, #3
	ldr	r0, [fp, #-248]
	bl	BsShow
	mov	r4, r0
	cmp	r4, #6
	ldr	r0, [fp, #-248]
	bgt	.L438
	mov	r1, #3
	bl	BsSkip
	sub	r3, fp, #44
	add	r3, r3, r4, lsl #2
	ldr	r1, [r3, #-200]
	ldr	r2, [r3, #-172]
.L439:
	sub	r3, fp, #44
	mov	r0, r4
	add	r2, r3, r2, lsl #2
	ldr	r3, [r2, #-148]
	ldr	r2, [fp, #-252]
	mul	r3, r3, r1
	str	r3, [r2]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L438:
	mov	r1, #7
	bl	BsGet
	and	r4, r0, #15
	cmp	r4, #15
	beq	.L442
	sub	r0, r0, #112
	sub	r3, fp, #44
	add	r4, r4, #7
	add	r0, r3, r0, lsl #2
	ldr	r1, [r0, #-112]
	ldr	r2, [r0, #-56]
	b	.L439
.L442:
	ldr	r2, [fp, #-256]
	mov	r3, #4
	mov	r0, #22
	strb	r3, [r2]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L444:
	.align	2
.L443:
	.word	.LANCHOR0+160
	.fnend
	.size	VC1_DecBfractionSMP, .-VC1_DecBfractionSMP
	.align	2
	.global	VC1_DecBfraction
	.type	VC1_DecBfraction, %function
VC1_DecBfraction:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #212
	sub	sp, sp, #212
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	ip, .L449
	sub	r10, fp, #244
	str	r0, [fp, #-248]
	sub	r8, fp, #216
	str	r1, [fp, #-252]
	sub	r5, fp, #156
	ldmia	ip!, {r0, r1, r2, r3}
	sub	lr, fp, #100
	sub	r7, fp, #188
	add	r9, ip, #12
	add	r6, ip, #40
	stmia	r10!, {r0, r1, r2, r3}
	add	r4, ip, #96
	ldmia	ip, {r0, r1, r2}
	add	ip, ip, #152
	stmia	r10, {r0, r1, r2}
	ldmia	r9!, {r0, r1, r2, r3}
	stmia	r8!, {r0, r1, r2, r3}
	ldmia	r9, {r0, r1, r2}
	stmia	r8, {r0, r1, r2}
	ldmia	r6!, {r0, r1, r2, r3}
	stmia	r5!, {r0, r1, r2, r3}
	ldmia	r6!, {r0, r1, r2, r3}
	stmia	r5!, {r0, r1, r2, r3}
	ldmia	r6!, {r0, r1, r2, r3}
	stmia	r5!, {r0, r1, r2, r3}
	ldmia	r6, {r0, r1}
	stmia	r5, {r0, r1}
	ldmia	r4!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	r4!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	r4!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	r4, {r0, r1}
	stmia	lr, {r0, r1}
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	r7!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	r7, {r0, r1, r2, r3}
	mov	r1, #3
	ldr	r0, [fp, #-248]
	bl	BsShow
	mov	r4, r0
	cmp	r4, #6
	ldr	r0, [fp, #-248]
	ble	.L448
	mov	r1, #7
	bl	BsGet
	sub	r3, fp, #44
	sub	r2, r0, #112
	and	r0, r0, #15
	add	r4, r0, #7
	add	r2, r3, r2, lsl #2
	ldr	r1, [r2, #-112]
	ldr	r2, [r2, #-56]
.L447:
	sub	r3, fp, #44
	mov	r0, r4
	add	r2, r3, r2, lsl #2
	ldr	r3, [r2, #-148]
	ldr	r2, [fp, #-252]
	mul	r3, r3, r1
	str	r3, [r2]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L448:
	mov	r1, #3
	bl	BsSkip
	sub	r3, fp, #44
	add	r3, r3, r4, lsl #2
	ldr	r1, [r3, #-200]
	ldr	r2, [r3, #-172]
	b	.L447
.L450:
	.align	2
.L449:
	.word	.LANCHOR0+160
	.fnend
	.size	VC1_DecBfraction, .-VC1_DecBfraction
	.align	2
	.global	VC1_VopDQuant
	.type	VC1_VopDQuant, %function
VC1_VopDQuant:
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
	cmp	r1, #2
	mov	r6, r2
	mov	r4, r3
	mov	r7, r0
	beq	.L469
	mov	r1, #1
	bl	BsGet
	uxtb	r5, r0
	strb	r5, [r4]
	cmp	r5, #1
	beq	.L470
.L455:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L469:
	mov	r3, #1
	mov	r1, #3
	strb	r3, [r4, #3]
	strb	r3, [r4]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #4]
	cmp	r0, #7
	addne	r6, r6, #1
	addne	r3, r0, r6
	strneb	r3, [r4, #8]
	beq	.L471
.L454:
	mov	r3, #1
	mov	r0, #1
	str	r3, [r4, #12]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L470:
	mov	r1, #2
	mov	r0, r7
	bl	BsGet
	uxtb	r1, r0
	strb	r1, [r4, #1]
	cmp	r1, #0
	streq	r5, [r4, #12]
	beq	.L458
	cmp	r1, #2
	beq	.L472
	cmp	r1, #1
	beq	.L473
	cmp	r1, #3
	movne	r3, #0
	strne	r3, [r4, #12]
	beq	.L474
.L458:
	ldr	r3, [r4]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #768
	beq	.L455
	mov	r3, #1
	mov	r1, #3
	strb	r3, [r4, #3]
	mov	r0, r7
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #4]
	cmp	r0, #7
	addne	r6, r6, #1
	addne	r6, r0, r6
	strneb	r6, [r4, #8]
	bne	.L455
	mov	r0, r7
	mov	r1, #5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #5]
	strb	r0, [r4, #8]
	b	.L455
.L474:
	mov	r1, r5
	mov	r0, r7
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #2]
	cmp	r0, #0
	movne	r3, #10
	moveq	r3, #11
	str	r3, [r4, #12]
	b	.L458
.L471:
	mov	r0, r7
	mov	r1, #5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #5]
	strb	r0, [r4, #8]
	b	.L454
.L472:
	mov	r0, r7
	bl	BsGet
	uxtb	r3, r0
	strb	r0, [r4, #6]
	add	r3, r3, #6
	str	r3, [r4, #12]
	b	.L458
.L473:
	mov	r1, #2
	mov	r0, r7
	bl	BsGet
	uxtb	r3, r0
	strb	r0, [r4, #7]
	add	r3, r3, #2
	str	r3, [r4, #12]
	b	.L458
	.fnend
	.size	VC1_VopDQuant, .-VC1_VopDQuant
	.align	2
	.global	VC1_DecNormDiff6Tile
	.type	VC1_DecNormDiff6Tile, %function
VC1_DecNormDiff6Tile:
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
	ldr	r9, [r1]
	mov	r8, r1
	mov	r5, r0
	mov	r6, #0
.L476:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	mov	r1, #3
	subs	r7, r0, #0
	mov	r0, r5
	bne	.L485
	bl	BsGet
	mov	r4, r0
	cmp	r4, #1
	mov	r1, r0
	mov	r0, r5
	bgt	.L495
	bne	.L479
	bl	BsGet
	cmp	r0, #0
	beq	.L480
	cmp	r6, #0
	mov	r6, r4
	beq	.L476
.L493:
	str	r9, [r8]
	mov	r0, r7
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L485:
	mov	r0, #0
.L477:
	cmp	r6, #0
	mov	r7, #1
	eorne	r0, r0, #63
.L494:
	str	r0, [r8]
	mov	r0, r7
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L495:
	sub	r4, r4, #2
	mov	r0, #1
	mov	r0, r0, asl r4
	b	.L477
.L479:
	mov	r0, r5
	mov	r1, #4
	bl	BsGet
	cmp	r0, #255
	beq	.L493
	ldr	r3, .L496
	add	r3, r3, r0, lsl #2
	ldr	r0, [r3, #488]
	b	.L477
.L480:
	mov	r0, r5
	mov	r1, #5
	bl	BsGet
	ldr	r3, .L496
	add	r3, r3, r0, lsl #2
	ldr	r3, [r3, #360]
	cmp	r3, #2
	orreq	r0, r0, #32
	beq	.L477
	cmp	r3, #3
	bne	.L494
	b	.L477
.L497:
	.align	2
.L496:
	.word	.LANCHOR0
	.fnend
	.size	VC1_DecNormDiff6Tile, .-VC1_DecNormDiff6Tile
	.align	2
	.global	VC1_Vfmw_ParseAdvSeqHdr
	.type	VC1_Vfmw_ParseAdvSeqHdr, %function
VC1_Vfmw_ParseAdvSeqHdr:
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
	ldr	r3, .L515
	mov	r5, r0
	mov	r4, r2
	mov	r1, #0
	add	r0, r2, #16
	ldr	r3, [r3, #48]
	mov	r2, #172
	blx	r3
	mov	r0, r5
	bl	BsPos
	mov	r6, #2
	mov	r1, r6
	str	r0, [r4, #184]
	mov	r0, r5
	bl	BsGet
	strb	r6, [r4, #16]
	mov	r1, #3
	mov	r0, r5
	bl	BsGet
	mov	r1, r6
	strb	r0, [r4, #17]
	mov	r0, r5
	bl	BsGet
	mov	r1, #3
	strb	r0, [r4, #18]
	mov	r0, r5
	bl	BsGet
	mov	r1, #5
	strb	r0, [r4, #19]
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #20]
	mov	r0, r5
	bl	BsGet
	mov	r1, #12
	strb	r0, [r4, #21]
	mov	r0, r5
	bl	BsGet
	mov	r1, #12
	uxth	r3, r0
	mov	r0, r5
	add	r3, r3, #1
	mov	r3, r3, asl #1
	strh	r3, [r4, #172]
	bl	BsGet
	mov	r1, #1
	uxth	r3, r0
	mov	r0, r5
	add	r3, r3, r1
	mov	r3, r3, asl r1
	strh	r3, [r4, #174]
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #22]
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #23]
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #24]
	mov	r0, r5
	bl	BsGet
	mov	r1, r6
	strb	r0, [r4, #25]
	mov	r0, r5
	bl	BsSkip
	mov	r0, r5
	mov	r1, #1
	bl	BsGet
	uxtb	r6, r0
	strb	r6, [r4, #26]
	cmp	r6, #1
	beq	.L512
	ldrh	r2, [r4, #172]
	ldrh	r3, [r4, #174]
	strh	r2, [r4, #176]
	strh	r3, [r4, #178]
.L505:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #39]
	cmp	r0, #1
	beq	.L506
.L508:
	mov	r0, r5
	bl	BsPos
	ldr	r3, [r4, #184]
	mov	r2, #1
	rsb	r0, r3, r0
	str	r0, [r4, #184]
.L507:
	mov	r0, r2
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L506:
	mov	r1, #5
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #40]
	cmp	r0, #31
	movhi	r2, #0
	bhi	.L507
	mov	r1, #4
	mov	r0, r5
	bl	BsGet
	mov	r1, #4
	strb	r0, [r4, #41]
	mov	r0, r5
	bl	BsGet
	ldrb	r3, [r4, #40]
	cmp	r3, #0
	strb	r0, [r4, #42]
	ble	.L508
	add	r7, r4, #42
	mov	r6, #0
.L509:
	mov	r1, #16
	mov	r0, r5
	bl	BsGet
	mov	r1, #16
	add	r6, r6, #1
	strh	r0, [r7, #2]!
	mov	r0, r5
	bl	BsGet
	strh	r0, [r7, #64]
	ldrb	r3, [r4, #40]
	cmp	r3, r6
	bgt	.L509
	b	.L508
.L512:
	mov	r1, #14
	mov	r0, r5
	bl	BsGet
	mov	r1, #14
	add	r3, r0, #1
	mov	r0, r5
	strh	r3, [r4, #176]
	bl	BsGet
	mov	r1, r6
	add	r3, r0, #1
	mov	r0, r5
	strh	r3, [r4, #178]
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #27]
	cmp	r0, #1
	beq	.L513
.L501:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	uxtb	r1, r0
	strb	r1, [r4, #31]
	cmp	r1, #1
	beq	.L514
.L503:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #35]
	cmp	r0, #1
	bne	.L505
	mov	r1, #8
	mov	r0, r5
	bl	BsGet
	mov	r1, #8
	strb	r0, [r4, #36]
	mov	r0, r5
	bl	BsGet
	mov	r1, #8
	strb	r0, [r4, #37]
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #38]
	b	.L505
.L514:
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #32]
	cmp	r0, #0
	bne	.L504
	mov	r1, #8
	mov	r0, r5
	bl	BsGet
	mov	r1, #4
	strb	r0, [r4, #33]
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #34]
	b	.L503
.L513:
	mov	r1, #4
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #28]
	cmp	r0, #15
	bne	.L501
	mov	r1, #8
	mov	r0, r5
	bl	BsGet
	mov	r1, #8
	strb	r0, [r4, #29]
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #30]
	b	.L501
.L504:
	mov	r1, #16
	mov	r0, r5
	bl	BsGet
	strh	r0, [r4, #180]
	b	.L503
.L516:
	.align	2
.L515:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VC1_Vfmw_ParseAdvSeqHdr, .-VC1_Vfmw_ParseAdvSeqHdr
	.align	2
	.global	VC1_Vfmw_ParseAdvEntptHdr
	.type	VC1_Vfmw_ParseAdvEntptHdr, %function
VC1_Vfmw_ParseAdvEntptHdr:
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
	ldr	r3, .L542
	mov	r4, r2
	mov	r5, r0
	mov	r1, #0
	add	r0, r2, #188
	ldr	r3, [r3, #48]
	mov	r2, #60
	blx	r3
	mov	r0, r5
	bl	BsPos
	mov	r1, #1
	str	r0, [r4, #244]
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #188]
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #189]
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #190]
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #191]
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #192]
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #193]
	mov	r0, r5
	bl	BsGet
	mov	r1, #2
	strb	r0, [r4, #194]
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #195]
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #196]
	mov	r0, r5
	bl	BsGet
	mov	r1, #2
	strb	r0, [r4, #197]
	mov	r0, r5
	bl	BsGet
	ldrb	r3, [r4, #39]
	cmp	r3, #1
	strb	r0, [r4, #198]
	beq	.L518
.L521:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #199]
	cmp	r0, #1
	ldrneh	r2, [r4, #240]
	beq	.L538
.L523:
	ldrh	r1, [r4, #238]
	ldrh	r0, [r4, #172]
	cmp	r1, #15
	movhi	r3, #0
	movls	r3, #1
	cmp	r1, r0
	orrhi	r3, r3, #1
	ldrb	r1, [r4, #194]
	cmp	r3, #0
	ldrh	r3, [r4, #174]
	strneh	r0, [r4, #238]
	cmp	r3, r2
	cmpcs	r2, #15
	strlsh	r3, [r4, #240]
	cmp	r1, #1
	beq	.L539
.L526:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #201]
	cmp	r0, #1
	beq	.L540
.L527:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #203]
	cmp	r0, #1
	beq	.L541
.L528:
	mov	r0, r5
	bl	BsPos
	ldr	r3, [r4, #244]
	rsb	r3, r3, r0
	mov	r0, #1
	str	r3, [r4, #244]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L518:
	ldrb	r3, [r4, #40]
	cmp	r3, #0
	ble	.L521
	add	r7, r4, #204
	mov	r6, #0
.L522:
	mov	r1, #8
	mov	r0, r5
	bl	BsGet
	add	r6, r6, #1
	strb	r0, [r7, #1]!
	ldrb	r3, [r4, #40]
	cmp	r3, r6
	bgt	.L522
	b	.L521
.L541:
	mov	r1, #3
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #204]
	b	.L528
.L538:
	mov	r1, #12
	mov	r0, r5
	bl	BsGet
	mov	r1, #12
	add	r3, r0, #1
	mov	r0, r5
	mov	r3, r3, asl #1
	strh	r3, [r4, #238]
	bl	BsGet
	add	r0, r0, #1
	mov	r2, r0, asl #1
	uxth	r2, r2
	strh	r2, [r4, #240]
	b	.L523
.L539:
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #200]
	b	.L526
.L540:
	mov	r1, #3
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #202]
	b	.L527
.L543:
	.align	2
.L542:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VC1_Vfmw_ParseAdvEntptHdr, .-VC1_Vfmw_ParseAdvEntptHdr
	.align	2
	.global	VC1_DecFcm
	.type	VC1_DecFcm, %function
VC1_DecFcm:
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
	mov	r1, #2
	mov	r5, r0
	bl	BsShow
	mov	r4, r0
	cmp	r4, #1
	mov	r0, r5
	ble	.L547
	mov	r1, #2
	bl	BsSkip
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L547:
	mov	r1, #1
	mov	r4, #0
	bl	BsSkip
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	VC1_DecFcm, .-VC1_DecFcm
	.align	2
	.global	VC1_DecAdvPtype
	.type	VC1_DecAdvPtype, %function
VC1_DecAdvPtype:
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
	mov	r1, #4
	mov	r4, r0
	bl	BsShow
	cmp	r0, #7
	movle	r1, #1
	movle	r5, r1
	ble	.L549
	cmp	r0, #11
	movle	r1, #2
	movle	r5, r1
	bgt	.L554
.L549:
	mov	r0, r4
	bl	BsSkip
	mov	r0, r5
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L554:
	cmp	r0, #13
	movle	r1, #3
	movle	r5, #0
	ble	.L549
	cmp	r0, #14
	mov	r1, #4
	movne	r5, #5
	moveq	r5, r1
	b	.L549
	.fnend
	.size	VC1_DecAdvPtype, .-VC1_DecAdvPtype
	.align	2
	.global	VC1_DecRefdist
	.type	VC1_DecRefdist, %function
VC1_DecRefdist:
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
	mov	r1, #5
	mov	r5, r0
	bl	BsShow
	cmp	r0, #23
	bgt	.L556
	mov	r4, r0, asr #3
	mov	r1, #2
	mov	r0, r5
	bl	BsSkip
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L556:
	cmp	r0, #27
	movle	r4, #3
	bgt	.L562
.L558:
	mov	r0, r5
	mov	r1, r4
	bl	BsSkip
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L562:
	cmp	r0, #29
	movgt	r4, #5
	movle	r4, #4
	b	.L558
	.fnend
	.size	VC1_DecRefdist, .-VC1_DecRefdist
	.align	2
	.global	VC1_DecIntCompField
	.type	VC1_DecIntCompField, %function
VC1_DecIntCompField:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, fp, ip, lr, pc}
	.pad #4
	.save {r4, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #36
	sub	sp, sp, #36
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	lr, .L564
	mov	r4, r0
	sub	ip, fp, #52
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
	mov	r0, r4
	mov	r1, #2
	bl	BsShow
	sub	r3, fp, #20
	add	r3, r3, r0, lsl #3
	mov	r0, r4
	ldr	r1, [r3, #-28]
	ldr	r4, [r3, #-32]
	bl	BsSkip
	mov	r0, r4
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L565:
	.align	2
.L564:
	.word	.LANCHOR0+548
	.fnend
	.size	VC1_DecIntCompField, .-VC1_DecIntCompField
	.align	2
	.global	VC1_Vfmw_next_start_code
	.type	VC1_Vfmw_next_start_code, %function
VC1_Vfmw_next_start_code:
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
	mov	r5, r0
	bl	BsToNextByte
	mov	r0, r5
	bl	BsResidBits
	add	r6, r0, #7
	cmp	r0, #0
	movlt	r0, r6
	mov	r6, r0, asr #3
	sub	r6, r6, #3
	cmp	r6, #0
	movgt	r4, #0
	bgt	.L569
	b	.L570
.L575:
	bl	BsSkip
	cmp	r4, r6
	beq	.L570
.L569:
	mov	r1, #24
	mov	r0, r5
	bl	BsShow
	add	r4, r4, #1
	mov	r1, #8
	mov	r3, r0
	cmp	r3, #1
	mov	r0, r5
	bne	.L575
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L570:
	mov	r3, #0
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	VC1_Vfmw_next_start_code, .-VC1_Vfmw_next_start_code
	.align	2
	.global	VC1_Vfmw_UserData
	.type	VC1_Vfmw_UserData, %function
VC1_Vfmw_UserData:
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
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VC1_Vfmw_UserData, .-VC1_Vfmw_UserData
	.align	2
	.global	VC1_RecordSlcStream
	.type	VC1_RecordSlcStream, %function
VC1_RecordSlcStream:
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
	add	r9, r0, #20480
	mov	r5, r0
	ldr	r0, [r0, #3128]
	movw	r3, #23856
	ldr	r6, [r9, #3364]
	movw	ip, #23848
	str	r1, [fp, #-48]
	mov	r8, r6, asl #4
	mov	r7, r6, asl #6
	rsb	r4, r8, r7
	add	r4, r5, r4
	add	lr, r4, #23808
	strb	r6, [r4, r3]
	ldr	r3, [r0, #24]
	mov	r10, lr
	cmp	r3, #0
	add	r1, r3, #7
	movlt	r3, r1
	add	r1, lr, #40
	add	r2, r2, r3, asr #3
	str	r2, [r4, ip]
	ldr	r3, [r0, #24]
	movw	r2, #23864
	str	r1, [fp, #-52]
	and	r3, r3, #7
	str	r3, [r4, r2]
	ldr	r3, [r0, #16]
	ldr	r2, [r0, #24]
	str	r1, [fp, #-56]
	rsb	r3, r2, r3, lsl #3
	str	r3, [lr, #60]
	ldr	r0, [r4, ip]
	bl	MEM_Vir2Phy
	add	r3, r5, #32768
	movw	ip, #23888
	add	r2, r10, #80
	str	r0, [r10, #52]
	ldr	r0, [r3, #3400]
	str	r0, [r4, ip]
	ldr	r0, [r3, #3376]
	cmp	r0, #0
	beq	.L578
	ldr	ip, [r3, #3388]
	ldr	r1, [fp, #-52]
	cmp	ip, #0
	bne	.L597
.L578:
	rsb	r3, r8, r7
	movw	ip, #23880
	add	r3, r5, r3
	mov	r2, #0
	add	r4, r3, #23808
	add	lr, r4, #72
	str	r2, [r4, #44]
	str	r2, [r3, ip]
	str	r2, [r4, #76]
	str	r2, [r4, #68]
	str	r2, [r4, #84]
.L579:
	ldr	r0, [r9, #3284]
	sub	r6, r8, r6, asl #2
	ldr	ip, [r9, #3280]
	ldrb	r4, [r5, #8]
	mul	ip, ip, r0
	cmp	r4, #0
	sub	ip, ip, #1
	beq	.L580
	ldr	r2, [fp, #-48]
	add	r3, r0, #1
	rsb	r1, r8, r7
	movw	lr, #23872
	add	r6, r2, r6
	add	r3, r3, r3, lsr #31
	add	r1, r5, r1
	add	r6, r6, #520
	ldr	r2, [r6, #8]
	sub	r3, r2, r3, asr #1
	str	r3, [r1, lr]
	cmp	ip, r3
	movcs	ip, #0
	movcc	ip, #1
	cmp	r3, #0
	movle	ip, #0
	cmp	ip, #0
	bne	.L598
.L581:
	rsb	r7, r8, r7
	add	r5, r5, r7
	add	r3, r5, #23808
	add	r3, r3, #56
	ldr	r3, [r3, #4]
	cmp	r3, #0
	ble	.L583
	add	r3, r5, #23808
	add	r3, r3, #40
	ldr	r3, [r3, #4]
	cmp	r3, #0
	beq	.L584
	add	r5, r5, #23808
	ldr	r3, [r5, #76]
	cmp	r3, #0
	ble	.L583
.L584:
	ldr	r3, [r9, #3364]
	mov	r0, #1
	add	r3, r3, r0
	str	r3, [r9, #3364]
.L582:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L580:
	ldr	r3, [fp, #-48]
	rsb	r2, r8, r7
	add	r2, r5, r2
	movw	r1, #23872
	add	r6, r3, r6
	add	r6, r6, #520
	ldr	r3, [r6, #8]
	cmp	ip, r3
	str	r3, [r2, r1]
	bcs	.L581
	ldr	r2, [r6, #8]
	mov	r0, #1
	str	ip, [sp]
	ldr	r1, .L599
	bl	dprint_vfmw
	mov	r0, r4
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L597:
	movw	lr, #23880
	str	r0, [r1, #4]
	mov	r0, #0
	str	r0, [r4, lr]
	ldr	r0, [r3, #3396]
	add	r1, r4, #23808
	str	ip, [r1, #68]
	mov	r0, r0, asl #3
	str	r0, [r1, #76]
	ldr	r3, [r3, #3404]
	str	r3, [r2, #4]
	b	.L579
.L598:
	ldr	r2, [r6, #8]
	ldr	r1, .L599+4
	str	r0, [sp]
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	b	.L582
.L583:
	ldr	r1, .L599+8
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L600:
	.align	2
.L599:
	.word	.LC39
	.word	.LC38
	.word	.LC40
	.fnend
	.size	VC1_RecordSlcStream, .-VC1_RecordSlcStream
	.align	2
	.global	VC1_Vfmw_UpdateAdvSPS
	.type	VC1_Vfmw_UpdateAdvSPS, %function
VC1_Vfmw_UpdateAdvSPS:
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
	add	r5, r0, #8192
	movw	r3, #2402
	ldrh	r2, [r1, #238]
	ldrh	r3, [r5, r3]
	mov	r4, r1
	cmp	r3, r2
	beq	.L602
	adds	r3, r2, #15
	add	r0, r0, #20480
	addmi	r3, r2, #30
	movw	r1, #2404
	mov	r3, r3, asr #4
	str	r3, [r0, #3280]
	ldrh	r3, [r4, #238]
	str	r3, [r0, #3296]
	ldrh	r2, [r4, #240]
	ldrh	r3, [r5, r1]
	cmp	r3, r2
	beq	.L603
.L604:
	adds	r3, r2, #15
	addmi	r3, r2, #30
	mov	r3, r3, asr #4
	str	r3, [r0, #3284]
	ldrh	r3, [r4, #240]
	str	r3, [r0, #3300]
.L603:
	add	r0, r5, #2176
	add	r1, r4, #16
	mov	r2, #172
	add	r0, r0, #4
	bl	memcpy
	add	lr, r4, #188
	add	ip, r5, #2352
	mov	r4, #1
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr, {r0, r1, r2}
	stmia	ip, {r0, r1, r2}
.L607:
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L602:
	movw	r3, #2404
	ldrh	r2, [r1, #240]
	ldrh	r3, [r5, r3]
	cmp	r3, r2
	addne	r0, r0, #20480
	bne	.L604
	mov	r4, #0
	b	.L607
	.fnend
	.size	VC1_Vfmw_UpdateAdvSPS, .-VC1_Vfmw_UpdateAdvSPS
	.align	2
	.global	VC1_Vfmw_UpdataLastPicRNDCTRL
	.type	VC1_Vfmw_UpdataLastPicRNDCTRL, %function
VC1_Vfmw_UpdataLastPicRNDCTRL:
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
	ldrb	r3, [r0, #3096]
	cmp	r3, #0
	bne	.L610
	bl	VC1_Vfmw_UpdataLastPicRNDCTRL.part.5
.L610:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VC1_Vfmw_UpdataLastPicRNDCTRL, .-VC1_Vfmw_UpdataLastPicRNDCTRL
	.align	2
	.global	VC1_Vfmw_DecPQUANT
	.type	VC1_Vfmw_DecPQUANT, %function
VC1_Vfmw_DecPQUANT:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #128
	sub	sp, sp, #128
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r2, #128
	mov	r4, r1
	mov	r5, r0
	ldr	r1, .L614
	sub	r0, fp, #148
	bl	memcpy
	cmp	r5, #0
	subeq	r3, fp, #20
	movne	r0, r4
	addeq	r4, r3, r4, lsl #2
	ldreq	r0, [r4, #-128]
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L615:
	.align	2
.L614:
	.word	.LANCHOR0+580
	.fnend
	.size	VC1_Vfmw_DecPQUANT, .-VC1_Vfmw_DecPQUANT
	.align	2
	.global	VC1_Vfmw_ParseSMPIPicHdr
	.type	VC1_Vfmw_ParseSMPIPicHdr, %function
VC1_Vfmw_ParseSMPIPicHdr:
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
	mov	r8, r1
	mov	r1, #7
	mov	r4, r2
	mov	r6, r0
	bl	BsGet
	mov	r1, #5
	strb	r0, [r4, #253]
	mov	r0, r6
	bl	BsGet
	uxtb	r5, r0
	strb	r5, [r4, #254]
	cmp	r5, #0
	beq	.L617
	ldrb	r7, [r4, #14]
	mov	r1, r5
	mov	r0, r7
	bl	VC1_Vfmw_DecPQUANT
	cmp	r5, #8
	movhi	r3, #0
	str	r0, [r4, #340]
	strhib	r3, [r4, #255]
	bls	.L628
.L619:
	cmp	r7, #1
	movne	r3, #0
	strneb	r3, [r4, #256]
	beq	.L629
.L621:
	ldrb	r3, [r4, #7]
	cmp	r3, #1
	movne	r3, #0
	strneb	r3, [r4, #257]
	beq	.L630
.L623:
	ldrb	r3, [r4, #251]
	sub	r3, r3, #2
	tst	r3, #253
	bne	.L624
.L626:
	ldrb	r1, [r4, #258]
.L625:
	mov	r0, r8
	mov	r5, #1
	bl	VC1_SetCurPicResolutionInfo
	mov	r0, r6
	bl	VC1_DecTransacfrm
	strb	r0, [r4, #267]
	mov	r0, r6
	bl	VC1_DecTransacfrm
	mov	r1, #1
	strb	r0, [r4, #268]
	mov	r0, r6
	bl	BsGet
	strb	r0, [r4, #269]
.L617:
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L624:
	ldrb	r3, [r4, #4]
	cmp	r3, #1
	bne	.L626
	mov	r1, #2
	mov	r0, r6
	bl	BsGet
	uxtb	r1, r0
	strb	r1, [r4, #258]
	b	.L625
.L628:
	mov	r1, #1
	mov	r0, r6
	bl	BsGet
	ldrb	r7, [r4, #14]
	strb	r0, [r4, #255]
	b	.L619
.L629:
	mov	r1, r7
	mov	r0, r6
	bl	BsGet
	strb	r0, [r4, #256]
	b	.L621
.L630:
	mov	r0, r6
	bl	VC1_DecMvrange
	strb	r0, [r4, #257]
	b	.L623
	.fnend
	.size	VC1_Vfmw_ParseSMPIPicHdr, .-VC1_Vfmw_ParseSMPIPicHdr
	.align	2
	.global	VC1_Vfmw_ParseSMPPPicHdr
	.type	VC1_Vfmw_ParseSMPPPicHdr, %function
VC1_Vfmw_ParseSMPPPicHdr:
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
	mov	r7, r1
	mov	r1, #5
	mov	r4, r2
	mov	r5, r0
	bl	BsGet
	uxtb	r6, r0
	strb	r6, [r4, #254]
	cmp	r6, #0
	beq	.L643
	ldrb	r8, [r4, #14]
	mov	r1, r6
	mov	r0, r8
	bl	VC1_Vfmw_DecPQUANT
	cmp	r6, #8
	movhi	r3, #0
	str	r0, [r4, #340]
	strhib	r3, [r4, #255]
	bls	.L654
.L635:
	cmp	r8, #1
	movne	r3, #0
	strneb	r3, [r4, #256]
	beq	.L655
.L637:
	ldrb	r3, [r4, #7]
	cmp	r3, #1
	movne	r3, #0
	strneb	r3, [r4, #257]
	beq	.L656
.L639:
	ldrb	r3, [r4, #4]
	cmp	r3, #1
	beq	.L640
	ldrb	r1, [r4, #258]
.L641:
	mov	r0, r7
	bl	VC1_SetCurPicResolutionInfo
	mov	r0, r5
	bl	BsPos
	ldr	r1, .L660
	mov	r2, r0
	mov	r0, #18
	bl	dprint_vfmw
	ldrb	r1, [r4, #340]
	mov	r0, r5
	bl	VC1_DecMvmodeProgrP
	uxtb	r0, r0
	strb	r0, [r4, #259]
	cmp	r0, #4
	beq	.L657
.L642:
	mov	r1, r7
	mov	r3, #0
	mov	r2, r4
	mov	r0, r5
	bl	BPD_Drv
	cmp	r0, #1
	beq	.L643
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	mov	r1, #2
	strb	r0, [r4, #263]
	mov	r0, r5
	bl	BsGet
	ldrb	r1, [r4, #8]
	cmp	r1, #0
	strb	r0, [r4, #264]
	bne	.L658
.L644:
	mov	r0, r5
	bl	BsPos
	ldr	r1, .L660+4
	mov	r2, r0
	mov	r0, #18
	bl	dprint_vfmw
	ldrb	r1, [r4, #9]
	cmp	r1, #1
	beq	.L659
.L646:
	mov	r0, r5
	bl	VC1_DecTransacfrm
	mov	r1, #1
	strb	r0, [r4, #267]
	mov	r0, r5
	bl	BsGet
	mov	r3, #1
	strb	r0, [r4, #269]
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L643:
	mov	r3, #0
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L654:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	ldrb	r8, [r4, #14]
	strb	r0, [r4, #255]
	b	.L635
.L658:
	add	r3, r4, #272
	ldrb	r2, [r4, #340]
	mov	r0, r5
	bl	VC1_VopDQuant
	b	.L644
.L656:
	mov	r0, r5
	bl	VC1_DecMvrange
	strb	r0, [r4, #257]
	b	.L639
.L640:
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	uxtb	r1, r0
	strb	r1, [r4, #258]
	b	.L641
.L655:
	mov	r1, r8
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #256]
	b	.L637
.L657:
	ldrb	r1, [r4, #340]
	mov	r0, r5
	bl	VC1_DecMvmode2
	mov	r1, #6
	strb	r0, [r4, #260]
	mov	r0, r5
	bl	BsGet
	mov	r1, #6
	strb	r0, [r4, #261]
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #262]
	b	.L642
.L659:
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #265]
	cmp	r0, #1
	bne	.L646
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #266]
	b	.L646
.L661:
	.align	2
.L660:
	.word	.LC41
	.word	.LC42
	.fnend
	.size	VC1_Vfmw_ParseSMPPPicHdr, .-VC1_Vfmw_ParseSMPPPicHdr
	.align	2
	.global	VC1_Vfmw_ParseMPBPicHdr
	.type	VC1_Vfmw_ParseMPBPicHdr, %function
VC1_Vfmw_ParseMPBPicHdr:
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
	mov	r8, r1
	mov	r1, #5
	mov	r4, r2
	mov	r5, r0
	bl	BsGet
	uxtb	r6, r0
	strb	r6, [r4, #254]
	cmp	r6, #0
	beq	.L672
	ldrb	r7, [r4, #14]
	mov	r1, r6
	mov	r0, r7
	bl	VC1_Vfmw_DecPQUANT
	cmp	r6, #8
	movhi	r3, #0
	str	r0, [r4, #340]
	strhib	r3, [r4, #255]
	bls	.L684
.L666:
	cmp	r7, #1
	movne	r3, #0
	strneb	r3, [r4, #256]
	beq	.L685
.L668:
	ldrb	r3, [r4, #7]
	cmp	r3, #1
	movne	r3, #0
	strneb	r3, [r4, #257]
	beq	.L686
.L670:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	mov	r3, #0
	mov	r1, r8
	mov	r2, r4
	cmp	r0, r3
	mov	r0, r5
	moveq	ip, #3
	movne	ip, #1
	strb	ip, [r4, #259]
	bl	BPD_Drv
	cmp	r0, #1
	beq	.L672
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	mov	r1, #2
	strb	r0, [r4, #263]
	mov	r0, r5
	bl	BsGet
	ldrb	r1, [r4, #8]
	cmp	r1, #0
	strb	r0, [r4, #264]
	bne	.L687
.L673:
	ldrb	r1, [r4, #9]
	cmp	r1, #1
	beq	.L688
.L675:
	mov	r0, r5
	bl	VC1_DecTransacfrm
	mov	r1, #1
	strb	r0, [r4, #267]
	mov	r0, r5
	bl	BsGet
	mov	r3, #1
	strb	r0, [r4, #269]
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L672:
	mov	r3, #0
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L684:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	ldrb	r7, [r4, #14]
	strb	r0, [r4, #255]
	b	.L666
.L687:
	add	r3, r4, #272
	ldrb	r2, [r4, #340]
	mov	r0, r5
	bl	VC1_VopDQuant
	b	.L673
.L685:
	mov	r1, r7
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #256]
	b	.L668
.L686:
	mov	r0, r5
	bl	VC1_DecMvrange
	strb	r0, [r4, #257]
	b	.L670
.L688:
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #265]
	cmp	r0, #1
	bne	.L675
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #266]
	b	.L675
	.fnend
	.size	VC1_Vfmw_ParseMPBPicHdr, .-VC1_Vfmw_ParseMPBPicHdr
	.align	2
	.global	VC1_Vfmw_ParseSMPPicHdr
	.type	VC1_Vfmw_ParseSMPPicHdr, %function
VC1_Vfmw_ParseSMPPicHdr:
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
	ldrb	r7, [r2, #258]
	mov	r5, r0
	mov	r6, r1
	mov	r0, r1
	mov	r4, r2
	mov	r1, r7
	bl	VC1_SetCurPicResolutionInfo
	ldr	r3, [r5, #16]
	cmp	r3, #1
	ble	.L727
	ldr	r9, .L732
	mov	r2, #100
	mov	r1, #0
	add	r0, r4, #248
	add	r8, r6, #32768
	ldr	r3, [r9, #48]
	blx	r3
	add	r0, r6, #23808
	ldr	r3, [r9, #48]
	mov	r2, #12288
	mov	r1, #0
	add	r0, r0, #40
	strb	r7, [r4, #258]
	blx	r3
	ldr	r2, [r8, #3368]
	ldr	r1, .L732+4
	mov	r0, #18
	bl	dprint_vfmw
	mov	r0, r5
	bl	BsPos
	ldrb	r3, [r4, #15]
	cmp	r3, #0
	str	r0, [r4, #324]
	bne	.L692
	ldrb	r2, [r4, #248]
.L693:
	ldr	r1, .L732+8
	mov	r0, #18
	bl	dprint_vfmw
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	ldrb	r3, [r4, #12]
	cmp	r3, #0
	strb	r0, [r4, #249]
	bne	.L728
.L694:
	ldrb	r3, [r4, #13]
	mov	r1, #1
	mov	r0, r5
	cmp	r3, #0
	bne	.L695
	bl	BsGet
	adds	r0, r0, #0
	movne	r0, #1
	strb	r0, [r4, #251]
.L696:
	mov	r3, #0
	strb	r0, [r6, #2]
	strb	r3, [r6, #4]
	ldrb	r3, [r4, #251]
	cmp	r3, #4
	ldrls	pc, [pc, r3, asl #2]
	b	.L708
.L701:
	.word	.L700
	.word	.L702
	.word	.L703
	.word	.L708
	.word	.L704
.L704:
	ldrb	r7, [r6, #3112]
	cmp	r7, #1
	beq	.L729
.L708:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L727:
	mov	r3, #5
	mov	r0, #1
	strb	r3, [r4, #251]
	strb	r3, [r6, #2]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L695:
	bl	BsGet
	cmp	r0, #1
	beq	.L725
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	cmp	r0, #1
	beq	.L730
	mov	r2, r4
	mov	r3, #2
	add	r1, r4, #344
	strb	r3, [r2, #251]!
	mov	r0, r5
	bl	VC1_DecBfractionSMP
	uxtb	r0, r0
	strb	r0, [r4, #252]
	cmp	r0, #21
	ldrneb	r0, [r4, #251]
	bne	.L696
	b	.L708
.L692:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	uxtb	r2, r0
	strb	r2, [r4, #248]
	b	.L693
.L730:
	mov	r0, #0
.L725:
	strb	r0, [r4, #251]
	b	.L696
.L703:
	ldrb	r7, [r6, #3112]
	cmp	r7, #1
	bne	.L708
	mov	r1, r6
	mov	r2, r4
	mov	r0, r5
	bl	VC1_Vfmw_ParseMPBPicHdr
	cmp	r0, #1
	mov	r6, r0
	beq	.L705
	mov	r0, r7
	ldr	r1, .L732+12
	bl	dprint_vfmw
	b	.L705
.L702:
	mov	r1, r6
	mov	r2, r4
	mov	r0, r5
	bl	VC1_Vfmw_ParseSMPPPicHdr
	mov	r6, r0
.L705:
	mov	r0, r5
	bl	BsPos
	ldr	r3, [r4, #324]
	rsb	r0, r3, r0
	str	r0, [r4, #324]
	mov	r0, r5
	ldr	r4, [r8, #3392]
	bl	BsPos
	mov	r4, r4, asl #3
	rsb	r0, r0, r4
	cmp	r0, #0
	ble	.L731
	mov	r0, r6
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L700:
	mov	r1, r6
	mov	r2, r4
	mov	r0, r5
	bl	VC1_Vfmw_ParseSMPIPicHdr
	mov	r6, r0
	b	.L705
.L728:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #250]
	b	.L694
.L731:
	ldr	r1, .L732+16
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L729:
	mov	r1, r6
	mov	r2, r4
	mov	r0, r5
	bl	VC1_Vfmw_ParseSMPIPicHdr
	cmp	r0, #1
	mov	r6, r0
	beq	.L705
	mov	r0, r7
	ldr	r1, .L732+20
	bl	dprint_vfmw
	b	.L705
.L733:
	.align	2
.L732:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC43
	.word	.LC44
	.word	.LC45
	.word	.LC47
	.word	.LC46
	.fnend
	.size	VC1_Vfmw_ParseSMPPicHdr, .-VC1_Vfmw_ParseSMPPicHdr
	.align	2
	.global	VC1_Vfmw_ParseAdvIPicHdr
	.type	VC1_Vfmw_ParseAdvIPicHdr, %function
VC1_Vfmw_ParseAdvIPicHdr:
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
	mov	r8, r1
	mov	r1, #1
	mov	r4, r2
	mov	r5, r0
	bl	BsGet
	ldrb	r1, [r4, #23]
	cmp	r1, #1
	strb	r0, [r4, #348]
	beq	.L749
.L735:
	ldr	r3, [r4, #392]
	cmp	r3, #0
	bne	.L736
	ldrb	r1, [r4, #25]
	cmp	r1, #1
	beq	.L750
.L736:
	mov	r1, #5
	mov	r0, r5
	bl	BsGet
	uxtb	r6, r0
	strb	r6, [r4, #358]
	cmp	r6, #0
	beq	.L744
	ldrb	r7, [r4, #198]
	mov	r1, r6
	mov	r0, r7
	bl	VC1_Vfmw_DecPQUANT
	cmp	r6, #8
	movhi	r3, #0
	str	r0, [r4, #464]
	strhib	r3, [r4, #351]
	bls	.L751
.L740:
	cmp	r7, #1
	movne	r3, #0
	strneb	r3, [r4, #359]
	beq	.L752
.L742:
	ldrb	r3, [r4, #21]
	cmp	r3, #1
	beq	.L753
.L743:
	mov	r1, r8
	mov	r3, #0
	mov	r2, r4
	mov	r0, r5
	bl	BPD_Drv
	cmp	r0, #1
	beq	.L744
	mov	r0, r5
	bl	VC1_DecTransacfrm
	strb	r0, [r4, #370]
	mov	r0, r5
	bl	VC1_DecTransacfrm
	mov	r1, #1
	strb	r0, [r4, #371]
	mov	r0, r5
	bl	BsGet
	ldrb	r1, [r4, #195]
	cmp	r1, #0
	strb	r0, [r4, #372]
	bne	.L754
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L744:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L751:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	ldrb	r7, [r4, #198]
	strb	r0, [r4, #351]
	b	.L740
.L750:
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #357]
	b	.L736
.L754:
	mov	r0, r5
	add	r3, r4, #508
	ldrb	r2, [r4, #464]
	bl	VC1_VopDQuant
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L749:
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #356]
	b	.L735
.L752:
	mov	r1, r7
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #359]
	b	.L742
.L753:
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #360]
	b	.L743
	.fnend
	.size	VC1_Vfmw_ParseAdvIPicHdr, .-VC1_Vfmw_ParseAdvIPicHdr
	.align	2
	.global	VC1_Vfmw_ParseAdvPPicHdr
	.type	VC1_Vfmw_ParseAdvPPicHdr, %function
VC1_Vfmw_ParseAdvPPicHdr:
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
	mov	r8, r1
	mov	r1, #1
	mov	r4, r2
	mov	r5, r0
	bl	BsGet
	ldrb	r3, [r4, #23]
	cmp	r3, #1
	strb	r0, [r4, #348]
	beq	.L756
	ldr	r3, [r4, #392]
	cmp	r3, #2
	beq	.L756
	ldrb	r1, [r4, #25]
	cmp	r1, #1
	beq	.L792
.L758:
	mov	r1, #5
	mov	r0, r5
	bl	BsGet
	uxtb	r6, r0
	strb	r6, [r4, #358]
	cmp	r6, #0
	beq	.L772
	ldrb	r7, [r4, #198]
	mov	r1, r6
	mov	r0, r7
	bl	VC1_Vfmw_DecPQUANT
	cmp	r6, #8
	movhi	r3, #0
	str	r0, [r4, #464]
	strhib	r3, [r4, #351]
	bls	.L793
.L762:
	cmp	r7, #1
	movne	r3, #0
	strneb	r3, [r4, #359]
	beq	.L794
.L764:
	ldrb	r3, [r4, #21]
	cmp	r3, #1
	beq	.L795
.L765:
	ldrb	r3, [r4, #194]
	cmp	r3, #1
	beq	.L796
.L766:
	ldr	r3, [r4, #392]
	cmp	r3, #0
	beq	.L797
	ldrb	r3, [r4, #200]
	cmp	r3, #1
	movne	r3, #0
	strneb	r3, [r4, #373]
	beq	.L798
.L770:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #374]
	mov	r0, r5
	bl	BsGet
	cmp	r0, #1
	str	r0, [r4, #468]
	beq	.L799
.L771:
	mov	r3, #0
	strb	r3, [r4, #382]
.L768:
	mov	r1, r8
	mov	r3, #0
	mov	r2, r4
	mov	r0, r5
	bl	BPD_Drv
	cmp	r0, #1
	beq	.L772
	ldr	r1, [r4, #392]
	cmp	r1, #2
	beq	.L800
.L773:
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	ldr	r3, [r4, #392]
	cmp	r3, #0
	moveq	r1, #2
	movne	r1, #3
	strb	r0, [r4, #366]
	mov	r0, r5
	bl	BsGet
	ldr	r6, [r4, #392]
	cmp	r6, #2
	uxtb	r0, r0
	strb	r0, [r4, #367]
	beq	.L801
.L776:
	ldrb	r1, [r4, #195]
	cmp	r1, #0
	bne	.L802
.L778:
	ldrb	r1, [r4, #196]
	cmp	r1, #1
	beq	.L803
.L780:
	mov	r0, r5
	bl	VC1_DecTransacfrm
	mov	r1, #1
	strb	r0, [r4, #370]
	mov	r0, r5
	bl	BsGet
	mov	r3, #1
	strb	r0, [r4, #372]
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L772:
	mov	r3, #0
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L756:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	ldrb	r1, [r4, #25]
	cmp	r1, #1
	strb	r0, [r4, #356]
	bne	.L758
.L792:
	ldr	r2, [r4, #392]
	cmp	r2, #0
	bne	.L758
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #357]
	b	.L758
.L797:
	ldrb	r1, [r4, #464]
	mov	r0, r5
	bl	VC1_DecMvmodeProgrP
	uxtb	r0, r0
	strb	r0, [r4, #362]
	cmp	r0, #4
	bne	.L768
	ldrb	r1, [r4, #464]
	mov	r0, r5
	bl	VC1_DecMvmode2
	mov	r1, #6
	strb	r0, [r4, #363]
	mov	r0, r5
	bl	BsGet
	mov	r1, #6
	strb	r0, [r4, #364]
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #365]
	b	.L768
.L793:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	ldrb	r7, [r4, #198]
	strb	r0, [r4, #351]
	b	.L762
.L802:
	add	r3, r4, #508
	ldrb	r2, [r4, #464]
	mov	r0, r5
	bl	VC1_VopDQuant
	b	.L778
.L796:
	mov	r0, r5
	bl	VC1_DecMvrange
	strb	r0, [r4, #361]
	b	.L766
.L794:
	mov	r1, r7
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #359]
	b	.L764
.L795:
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #360]
	b	.L765
.L803:
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #368]
	cmp	r0, #1
	bne	.L780
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #369]
	b	.L780
.L801:
	mov	r1, r6
	mov	r0, r5
	bl	BsGet
	ldrb	r3, [r4, #374]
	cmp	r3, #1
	strb	r0, [r4, #376]
	movne	r0, #0
	beq	.L804
.L777:
	strb	r0, [r4, #377]
	b	.L776
.L800:
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #375]
	b	.L773
.L798:
	mov	r0, r5
	bl	VC1_DecMvrange
	strb	r0, [r4, #373]
	b	.L770
.L799:
	mov	r1, #6
	mov	r0, r5
	bl	BsGet
	mov	r1, #6
	strb	r0, [r4, #364]
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #365]
	b	.L771
.L804:
	mov	r1, r6
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	b	.L777
	.fnend
	.size	VC1_Vfmw_ParseAdvPPicHdr, .-VC1_Vfmw_ParseAdvPPicHdr
	.align	2
	.global	VC1_Vfmw_ParseAdvBPicHdr
	.type	VC1_Vfmw_ParseAdvBPicHdr, %function
VC1_Vfmw_ParseAdvBPicHdr:
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
	mov	r7, r1
	mov	r1, #1
	mov	r4, r2
	mov	r5, r0
	bl	BsGet
	ldrb	r3, [r4, #23]
	cmp	r3, #1
	strb	r0, [r4, #348]
	beq	.L806
	ldr	r3, [r4, #392]
	cmp	r3, #2
	beq	.L806
	ldrb	r1, [r4, #25]
	cmp	r1, #1
	beq	.L847
.L808:
	cmp	r3, #0
	bne	.L812
	add	r1, r4, #496
	mov	r0, r5
	bl	VC1_DecBfraction
	uxtb	r0, r0
	strb	r0, [r4, #350]
	cmp	r0, #21
	beq	.L810
.L812:
	mov	r1, #5
	mov	r0, r5
	bl	BsGet
	uxtb	r6, r0
	strb	r6, [r4, #358]
	cmp	r6, #0
	beq	.L810
	ldrb	r8, [r4, #198]
	mov	r1, r6
	mov	r0, r8
	bl	VC1_Vfmw_DecPQUANT
	cmp	r6, #8
	movhi	r3, #0
	str	r0, [r4, #464]
	strhib	r3, [r4, #351]
	bls	.L848
	cmp	r8, #1
	movne	r3, #0
	strneb	r3, [r4, #359]
	beq	.L849
.L817:
	ldrb	r3, [r4, #21]
	cmp	r3, #1
	beq	.L850
.L818:
	ldr	r3, [r4, #392]
	cmp	r3, #2
	beq	.L851
.L819:
	ldrb	r3, [r4, #194]
	cmp	r3, #1
	beq	.L852
.L820:
	ldr	r3, [r4, #392]
	cmp	r3, #0
	beq	.L853
	ldrb	r3, [r4, #200]
	cmp	r3, #1
	beq	.L854
.L824:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	str	r0, [r4, #468]
.L823:
	mov	r1, r7
	mov	r3, #0
	mov	r2, r4
	mov	r0, r5
	bl	BPD_Drv
	cmp	r0, #1
	beq	.L810
	ldr	r1, [r4, #392]
	cmp	r1, #2
	beq	.L855
.L825:
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	ldr	r3, [r4, #392]
	cmp	r3, #0
	moveq	r1, #2
	movne	r1, #3
	strb	r0, [r4, #366]
	mov	r0, r5
	bl	BsGet
	ldr	r6, [r4, #392]
	cmp	r6, #2
	uxtb	r0, r0
	strb	r0, [r4, #367]
	beq	.L856
.L828:
	ldrb	r1, [r4, #195]
	cmp	r1, #0
	bne	.L857
.L829:
	ldrb	r1, [r4, #196]
	cmp	r1, #1
	beq	.L858
.L831:
	mov	r0, r5
	bl	VC1_DecTransacfrm
	mov	r1, #1
	strb	r0, [r4, #370]
	mov	r0, r5
	bl	BsGet
	mov	r3, #1
	strb	r0, [r4, #372]
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L810:
	mov	r3, #0
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L806:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	ldrb	r1, [r4, #25]
	ldr	r3, [r4, #392]
	cmp	r1, #1
	strb	r0, [r4, #356]
	bne	.L808
.L847:
	cmp	r3, #0
	bne	.L812
	mov	r0, r5
	bl	BsGet
	ldr	r3, [r4, #392]
	strb	r0, [r4, #357]
	b	.L808
.L853:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	cmp	r0, #0
	moveq	r3, #3
	movne	r3, #1
	strb	r3, [r4, #362]
	b	.L823
.L848:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	ldrb	r8, [r4, #198]
	cmp	r8, #1
	movne	r3, #0
	strb	r0, [r4, #351]
	strneb	r3, [r4, #359]
	bne	.L817
.L849:
	mov	r1, r8
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #359]
	b	.L817
.L851:
	add	r1, r4, #496
	mov	r0, r5
	bl	VC1_DecBfraction
	strb	r0, [r4, #350]
	b	.L819
.L852:
	mov	r0, r5
	bl	VC1_DecMvrange
	strb	r0, [r4, #361]
	b	.L820
.L850:
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #360]
	b	.L818
.L857:
	add	r3, r4, #508
	ldrb	r2, [r4, #464]
	mov	r0, r5
	bl	VC1_VopDQuant
	b	.L829
.L858:
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #368]
	cmp	r0, #1
	bne	.L831
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #369]
	b	.L831
.L856:
	mov	r1, r6
	mov	r0, r5
	bl	BsGet
	mov	r1, r6
	strb	r0, [r4, #376]
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #377]
	b	.L828
.L855:
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #375]
	b	.L825
.L854:
	mov	r0, r5
	bl	VC1_DecMvrange
	strb	r0, [r4, #373]
	b	.L824
	.fnend
	.size	VC1_Vfmw_ParseAdvBPicHdr, .-VC1_Vfmw_ParseAdvBPicHdr
	.align	2
	.global	VC1_Vfmw_ParseAdvFramePicHdr
	.type	VC1_Vfmw_ParseAdvFramePicHdr, %function
VC1_Vfmw_ParseAdvFramePicHdr:
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
	mov	r6, r1
	mov	r1, #4
	mov	r4, r2
	mov	r5, r0
	bl	BsShow
	cmp	r0, #7
	movle	r7, #1
	movle	r1, r7
	ble	.L860
	cmp	r0, #11
	movle	r7, #2
	movle	r1, r7
	bgt	.L891
.L860:
	mov	r0, r5
	bl	BsSkip
	strb	r7, [r4, #349]
	ldrb	r3, [r6, #3513]
	strb	r3, [r6, #2]
	ldrb	r3, [r4, #24]
	cmp	r3, #0
	bne	.L892
.L861:
	ldrb	r3, [r4, #22]
	cmp	r3, #0
	ldrb	r3, [r4, #23]
	beq	.L862
	cmp	r3, #0
	beq	.L893
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #352]
	mov	r0, r5
	bl	BsGet
	ldrb	r2, [r4, #23]
	ldrb	r3, [r4, #22]
	cmp	r2, #1
	strb	r0, [r4, #353]
	beq	.L894
.L866:
	cmp	r3, #1
	bne	.L868
	ldrb	r1, [r4, #190]
	ldrb	r3, [r4, #354]
	cmp	r1, #1
	add	r3, r3, #1
	str	r3, [r4, #492]
	bne	.L877
.L869:
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #355]
	cmp	r0, #1
	bne	.L877
	ldr	r3, [r4, #492]
	cmp	r3, #0
	ble	.L877
	mov	r7, r4
	mov	r8, #0
.L878:
	mov	r1, #18
	mov	r0, r5
	bl	BsGet
	mov	r1, #18
	add	r8, r8, #1
	add	r7, r7, #4
	str	r0, [r7, #396]
	mov	r0, r5
	bl	BsGet
	mov	r1, #14
	str	r0, [r7, #412]
	mov	r0, r5
	bl	BsGet
	mov	r1, #14
	str	r0, [r7, #428]
	mov	r0, r5
	bl	BsGet
	str	r0, [r7, #444]
	ldr	r3, [r4, #492]
	cmp	r3, r8
	bgt	.L878
	b	.L877
.L862:
	mov	r2, #1
	cmp	r3, r2
	strb	r2, [r4, #352]
	beq	.L865
.L868:
	mov	r3, #1
	str	r3, [r4, #492]
.L867:
	ldrb	r1, [r4, #190]
	cmp	r1, #1
	beq	.L869
.L877:
	ldrb	r3, [r4, #349]
	cmp	r3, #5
	ldrls	pc, [pc, r3, asl #2]
	b	.L870
.L872:
	.word	.L875
	.word	.L873
	.word	.L874
	.word	.L870
	.word	.L875
	.word	.L883
.L875:
	mov	r2, r4
	mov	r1, r6
	mov	r0, r5
	bl	VC1_Vfmw_ParseAdvIPicHdr
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L893:
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	ldrb	r2, [r4, #23]
	ldrb	r3, [r4, #22]
	cmp	r2, #1
	strb	r0, [r4, #354]
	bne	.L866
.L894:
	cmp	r3, #1
	beq	.L895
.L865:
	mov	r3, #2
	str	r3, [r4, #492]
	b	.L867
.L891:
	cmp	r0, #13
	movle	r7, #0
	movle	r1, #3
	ble	.L860
	cmp	r0, #14
	moveq	r7, #4
	movne	r7, #5
	movne	r1, #4
	moveq	r1, r7
	b	.L860
.L892:
	mov	r1, #8
	mov	r0, r5
	bl	BsGet
	str	r0, [r4, #396]
	b	.L861
.L883:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L873:
	mov	r2, r4
	mov	r1, r6
	mov	r0, r5
	bl	VC1_Vfmw_ParseAdvPPicHdr
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L874:
	mov	r2, r4
	mov	r1, r6
	mov	r0, r5
	bl	VC1_Vfmw_ParseAdvBPicHdr
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L870:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L895:
	ldrb	r3, [r4, #353]
	add	r3, r3, #2
	str	r3, [r4, #492]
	b	.L867
	.fnend
	.size	VC1_Vfmw_ParseAdvFramePicHdr, .-VC1_Vfmw_ParseAdvFramePicHdr
	.align	2
	.global	VC1_Vfmw_ParseAdvIFieldHdr
	.type	VC1_Vfmw_ParseAdvIFieldHdr, %function
VC1_Vfmw_ParseAdvIFieldHdr:
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
	mov	r8, r1
	mov	r1, #5
	mov	r4, r2
	mov	r6, r0
	bl	BsGet
	uxtb	r5, r0
	strb	r5, [r4, #358]
	cmp	r5, #0
	beq	.L904
	ldrb	r7, [r4, #198]
	mov	r1, r5
	mov	r0, r7
	bl	VC1_Vfmw_DecPQUANT
	cmp	r5, #8
	movhi	r3, #0
	str	r0, [r4, #464]
	strhib	r3, [r4, #351]
	bls	.L909
.L900:
	cmp	r7, #1
	movne	r3, #0
	strneb	r3, [r4, #359]
	beq	.L910
.L902:
	ldrb	r3, [r4, #21]
	cmp	r3, #1
	beq	.L911
.L903:
	mov	r1, r8
	mov	r3, #0
	mov	r2, r4
	mov	r0, r6
	bl	BPD_Drv
	cmp	r0, #1
	beq	.L904
	mov	r0, r6
	bl	VC1_DecTransacfrm
	strb	r0, [r4, #370]
	mov	r0, r6
	bl	VC1_DecTransacfrm
	mov	r1, #1
	strb	r0, [r4, #371]
	mov	r0, r6
	bl	BsGet
	ldrb	r1, [r4, #195]
	cmp	r1, #0
	strb	r0, [r4, #372]
	bne	.L912
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L904:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L909:
	mov	r1, #1
	mov	r0, r6
	bl	BsGet
	ldrb	r7, [r4, #198]
	strb	r0, [r4, #351]
	b	.L900
.L912:
	mov	r0, r6
	add	r3, r4, #508
	ldrb	r2, [r4, #464]
	bl	VC1_VopDQuant
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L910:
	mov	r1, r7
	mov	r0, r6
	bl	BsGet
	strb	r0, [r4, #359]
	b	.L902
.L911:
	mov	r1, #2
	mov	r0, r6
	bl	BsGet
	strb	r0, [r4, #360]
	b	.L903
	.fnend
	.size	VC1_Vfmw_ParseAdvIFieldHdr, .-VC1_Vfmw_ParseAdvIFieldHdr
	.align	2
	.global	VC1_Vfmw_ParseAdvPFieldHdr
	.type	VC1_Vfmw_ParseAdvPFieldHdr, %function
VC1_Vfmw_ParseAdvPFieldHdr:
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
	mov	r1, #5
	mov	r4, r2
	mov	r5, r0
	bl	BsGet
	uxtb	r6, r0
	strb	r6, [r4, #358]
	cmp	r6, #0
	beq	.L914
	ldrb	r7, [r4, #198]
	mov	r1, r6
	mov	r0, r7
	bl	VC1_Vfmw_DecPQUANT
	cmp	r6, #8
	movhi	r3, #0
	str	r0, [r4, #464]
	strhib	r3, [r4, #351]
	bls	.L941
.L916:
	cmp	r7, #1
	movne	r3, #0
	strneb	r3, [r4, #359]
	beq	.L942
.L918:
	ldrb	r3, [r4, #21]
	cmp	r3, #1
	beq	.L943
.L919:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #380]
	cmp	r0, #0
	beq	.L944
.L920:
	ldrb	r3, [r4, #194]
	cmp	r3, #1
	beq	.L945
.L921:
	ldrb	r3, [r4, #200]
	cmp	r3, #1
	beq	.L946
.L922:
	ldrb	r1, [r4, #464]
	mov	r0, r5
	bl	VC1_DecMvmodeProgrP
	uxtb	r0, r0
	strb	r0, [r4, #362]
	cmp	r0, #4
	beq	.L947
.L924:
	mov	r1, #3
	mov	r0, r5
	bl	BsGet
	ldrb	r3, [r4, #380]
	cmp	r3, #0
	moveq	r1, #2
	movne	r1, #3
	strb	r0, [r4, #375]
	mov	r0, r5
	bl	BsGet
	mov	r1, #3
	uxtb	r0, r0
	strb	r0, [r4, #366]
	mov	r0, r5
	bl	BsGet
	ldrb	r3, [r4, #362]
	cmp	r3, #0
	strb	r0, [r4, #367]
	beq	.L928
	movw	r3, #362
	ldrh	r3, [r4, r3]
	cmp	r3, #4
	beq	.L928
	ldrb	r1, [r4, #195]
	cmp	r1, #0
	bne	.L948
.L930:
	ldrb	r1, [r4, #196]
	cmp	r1, #1
	beq	.L949
.L932:
	mov	r0, r5
	mov	r6, #1
	bl	VC1_DecTransacfrm
	mov	r1, #1
	strb	r0, [r4, #370]
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #372]
.L914:
	mov	r0, r6
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L928:
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	ldrb	r1, [r4, #195]
	cmp	r1, #0
	strb	r0, [r4, #377]
	beq	.L930
.L948:
	add	r3, r4, #508
	ldrb	r2, [r4, #464]
	mov	r0, r5
	bl	VC1_VopDQuant
	b	.L930
.L944:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	clz	r0, r0
	mov	r0, r0, lsr #5
	strb	r0, [r4, #381]
	b	.L920
.L941:
	mov	r1, #1
	mov	r0, r5
	bl	BsGet
	ldrb	r7, [r4, #198]
	strb	r0, [r4, #351]
	b	.L916
.L945:
	mov	r0, r5
	bl	VC1_DecMvrange
	strb	r0, [r4, #361]
	b	.L921
.L946:
	mov	r0, r5
	bl	VC1_DecMvrange
	strb	r0, [r4, #373]
	b	.L922
.L942:
	mov	r1, r7
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #359]
	b	.L918
.L949:
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #368]
	cmp	r0, #1
	bne	.L932
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #369]
	b	.L932
.L943:
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #360]
	b	.L919
.L947:
	ldrb	r1, [r4, #464]
	mov	r0, r5
	bl	VC1_DecMvmode2
	strb	r0, [r4, #363]
	mov	r0, r5
	bl	VC1_DecIntCompField
	mov	r1, #6
	str	r0, [r4, #476]
	mov	r0, r5
	bl	BsGet
	mov	r1, #6
	strb	r0, [r4, #364]
	mov	r0, r5
	bl	BsGet
	ldr	r3, [r4, #476]
	cmp	r3, #0
	strb	r0, [r4, #365]
	bne	.L924
	mov	r1, #6
	mov	r0, r5
	bl	BsGet
	mov	r1, #6
	str	r0, [r4, #480]
	mov	r0, r5
	bl	BsGet
	str	r0, [r4, #484]
	b	.L924
	.fnend
	.size	VC1_Vfmw_ParseAdvPFieldHdr, .-VC1_Vfmw_ParseAdvPFieldHdr
	.align	2
	.global	VC1_Vfmw_ParseAdvBFieldHdr
	.type	VC1_Vfmw_ParseAdvBFieldHdr, %function
VC1_Vfmw_ParseAdvBFieldHdr:
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
	mov	r7, #1
	mov	r9, r1
	strb	r7, [r2, #380]
	mov	r1, #5
	mov	r4, r2
	mov	r5, r0
	bl	BsGet
	uxtb	r6, r0
	strb	r6, [r4, #358]
	cmp	r6, #0
	beq	.L960
	ldrb	r8, [r4, #198]
	mov	r1, r6
	mov	r0, r8
	bl	VC1_Vfmw_DecPQUANT
	cmp	r6, #8
	movhi	r3, #0
	str	r0, [r4, #464]
	strhib	r3, [r4, #351]
	bls	.L972
.L954:
	cmp	r8, #1
	movne	r3, #0
	strneb	r3, [r4, #359]
	beq	.L973
.L956:
	ldrb	r3, [r4, #21]
	cmp	r3, #1
	beq	.L974
.L957:
	ldrb	r3, [r4, #194]
	cmp	r3, #1
	beq	.L975
.L958:
	ldrb	r3, [r4, #200]
	cmp	r3, #1
	beq	.L976
.L959:
	ldrb	r1, [r4, #464]
	mov	r0, r5
	bl	VC1_DecMvmodeInterB
	mov	r1, r9
	mov	r3, #0
	mov	r2, r4
	strb	r0, [r4, #362]
	mov	r0, r5
	bl	BPD_Drv
	cmp	r0, #1
	beq	.L960
	mov	r1, #3
	mov	r0, r5
	bl	BsGet
	mov	r1, #3
	strb	r0, [r4, #375]
	mov	r0, r5
	bl	BsGet
	mov	r1, #3
	strb	r0, [r4, #366]
	mov	r0, r5
	bl	BsGet
	ldrb	r3, [r4, #362]
	cmp	r3, #0
	strb	r0, [r4, #367]
	beq	.L977
.L961:
	ldrb	r1, [r4, #195]
	cmp	r1, #0
	bne	.L978
.L962:
	ldrb	r1, [r4, #196]
	cmp	r1, #1
	beq	.L979
.L964:
	mov	r0, r5
	bl	VC1_DecTransacfrm
	mov	r1, #1
	strb	r0, [r4, #370]
	mov	r0, r5
	bl	BsGet
	mov	r3, #1
	strb	r0, [r4, #372]
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L960:
	mov	r3, #0
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L972:
	mov	r1, r7
	mov	r0, r5
	bl	BsGet
	ldrb	r8, [r4, #198]
	strb	r0, [r4, #351]
	b	.L954
.L978:
	add	r3, r4, #508
	ldrb	r2, [r4, #464]
	mov	r0, r5
	bl	VC1_VopDQuant
	b	.L962
.L977:
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #377]
	b	.L961
.L974:
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #360]
	b	.L957
.L975:
	mov	r0, r5
	bl	VC1_DecMvrange
	strb	r0, [r4, #361]
	b	.L958
.L973:
	mov	r1, r8
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #359]
	b	.L956
.L976:
	mov	r0, r5
	bl	VC1_DecMvrange
	strb	r0, [r4, #373]
	b	.L959
.L979:
	mov	r0, r5
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #368]
	cmp	r0, #1
	bne	.L964
	mov	r1, #2
	mov	r0, r5
	bl	BsGet
	strb	r0, [r4, #369]
	b	.L964
	.fnend
	.size	VC1_Vfmw_ParseAdvBFieldHdr, .-VC1_Vfmw_ParseAdvBFieldHdr
	.align	2
	.global	VC1_Vfmw_ParseAdvFieldPicHdr
	.type	VC1_Vfmw_ParseAdvFieldPicHdr, %function
VC1_Vfmw_ParseAdvFieldPicHdr:
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
	ldrb	r3, [r1, #8]
	mov	r5, r1
	mov	r6, r0
	cmp	r3, #0
	mov	r4, r2
	beq	.L981
	add	r3, r1, #20480
	ldr	r3, [r3, #3364]
	cmp	r3, #0
	ble	.L982
.L981:
	mov	r1, #3
	mov	r0, r6
	bl	BsGet
	ldr	r3, .L1026
	str	r0, [r4, #472]
	add	r0, r3, r0, lsl #3
	ldr	r3, [r0, #712]
	ldr	r2, [r0, #708]
	str	r3, [r4, #504]
	str	r2, [r4, #500]
	ldrb	r1, [r5, #8]
	cmp	r1, #0
	uxtbeq	r3, r2
	uxtbne	r3, r3
	strb	r3, [r4, #349]
	ldrb	r3, [r5, #3513]
	strb	r3, [r5, #2]
	ldrb	r3, [r4, #24]
	cmp	r3, #0
	bne	.L1020
.L985:
	ldrb	r3, [r4, #22]
	cmp	r3, #0
	ldrb	r3, [r4, #23]
	bne	.L1021
	mov	r2, #1
	cmp	r3, r2
	strb	r2, [r4, #352]
	beq	.L989
.L992:
	mov	r3, #1
	str	r3, [r4, #492]
.L991:
	ldrb	r1, [r4, #190]
	cmp	r1, #1
	beq	.L993
.L996:
	mov	r1, #1
	mov	r0, r6
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #348]
	mov	r0, r6
	bl	BsGet
	ldrb	r3, [r4, #191]
	cmp	r3, #1
	strb	r0, [r4, #356]
	beq	.L1022
.L995:
	ldr	r3, [r4, #472]
	cmp	r3, #3
	bgt	.L1000
.L999:
	ldrb	r3, [r4, #349]
	cmp	r3, #4
	ldrls	pc, [pc, r3, asl #2]
	b	.L1008
.L1003:
	.word	.L1002
	.word	.L1004
	.word	.L1005
	.word	.L1008
	.word	.L1002
.L1021:
	cmp	r3, #0
	bne	.L987
	mov	r1, #2
	mov	r0, r6
	bl	BsGet
	ldrb	r3, [r4, #22]
	strb	r0, [r4, #354]
.L988:
	ldrb	r2, [r4, #23]
	cmp	r2, #1
	beq	.L1023
	cmp	r3, #1
	bne	.L992
	ldrb	r1, [r4, #190]
	ldrb	r3, [r4, #354]
	cmp	r1, #1
	add	r3, r3, #1
	str	r3, [r4, #492]
	bne	.L996
.L993:
	mov	r0, r6
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #355]
	cmp	r0, #1
	bne	.L996
	ldr	r3, [r4, #492]
	cmp	r3, #0
	ble	.L996
	mov	r7, r4
	mov	r8, #0
.L997:
	mov	r1, #18
	mov	r0, r6
	bl	BsGet
	mov	r1, #18
	add	r8, r8, #1
	add	r7, r7, #4
	str	r0, [r7, #396]
	mov	r0, r6
	bl	BsGet
	mov	r1, #14
	str	r0, [r7, #412]
	mov	r0, r6
	bl	BsGet
	mov	r1, #14
	str	r0, [r7, #428]
	mov	r0, r6
	bl	BsGet
	str	r0, [r7, #444]
	ldr	r3, [r4, #492]
	cmp	r3, r8
	bgt	.L997
	b	.L996
.L1005:
	mov	r0, r6
	mov	r2, r4
	mov	r1, r5
	bl	VC1_Vfmw_ParseAdvBFieldHdr
.L1001:
	ldrb	r3, [r4, #352]
	cmp	r3, #0
	ldrb	r3, [r5, #8]
	bne	.L1024
.L1006:
	subs	r3, r3, #1
	movne	r3, #1
	strb	r3, [r4, #389]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1004:
	mov	r0, r6
	mov	r2, r4
	mov	r1, r5
	bl	VC1_Vfmw_ParseAdvPFieldHdr
	ldrb	r3, [r4, #352]
	cmp	r3, #0
	ldrb	r3, [r5, #8]
	beq	.L1006
.L1024:
	adds	r3, r3, #0
	movne	r3, #1
	strb	r3, [r4, #389]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1002:
	mov	r0, r6
	mov	r2, r4
	mov	r1, r5
	bl	VC1_Vfmw_ParseAdvIFieldHdr
	b	.L1001
.L1022:
	ldr	r3, [r4, #472]
	cmp	r3, #3
	ble	.L998
.L1000:
	add	r1, r4, #496
	mov	r0, r6
	bl	VC1_DecBfraction
	strb	r0, [r4, #350]
	b	.L999
.L1020:
	mov	r1, #8
	mov	r0, r6
	bl	BsGet
	str	r0, [r4, #396]
	b	.L985
.L1023:
	cmp	r3, #1
	beq	.L1025
.L989:
	mov	r3, #2
	str	r3, [r4, #492]
	b	.L991
.L987:
	mov	r1, #1
	mov	r0, r6
	bl	BsGet
	mov	r1, #1
	strb	r0, [r4, #352]
	mov	r0, r6
	bl	BsGet
	ldrb	r3, [r4, #22]
	strb	r0, [r4, #353]
	b	.L988
.L1008:
	mov	r0, #0
	b	.L1001
.L998:
	mov	r0, r6
	bl	VC1_DecRefdist
	strb	r0, [r4, #379]
	b	.L995
.L1025:
	ldrb	r3, [r4, #353]
	add	r3, r3, #2
	str	r3, [r4, #492]
	b	.L991
.L982:
	ldr	r3, [r2, #504]
	strb	r3, [r2, #349]
	ldrb	r3, [r1, #3513]
	strb	r3, [r1, #2]
	b	.L999
.L1027:
	.align	2
.L1026:
	.word	.LANCHOR0
	.fnend
	.size	VC1_Vfmw_ParseAdvFieldPicHdr, .-VC1_Vfmw_ParseAdvFieldPicHdr
	.align	2
	.global	VC1_Vfmw_ParseAdvPicHdr
	.type	VC1_Vfmw_ParseAdvPicHdr, %function
VC1_Vfmw_ParseAdvPicHdr:
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
	mov	r4, r1
	mov	r6, r0
	mov	r1, #0
	mov	r0, r4
	mov	r5, r2
	bl	VC1_SetCurPicResolutionInfo
	ldrb	r3, [r4, #8]
	cmp	r3, #0
	beq	.L1029
	add	r3, r4, #20480
	ldr	r3, [r3, #3364]
	cmp	r3, #0
	ldrle	r3, [r5, #392]
	bicle	r3, r3, #2
	ble	.L1030
.L1029:
	ldrb	r8, [r5, #23]
	cmp	r8, #1
	movne	r3, #0
	movne	r0, r3
	beq	.L1039
.L1031:
	str	r0, [r5, #392]
.L1030:
	cmp	r3, #0
	mov	r2, r5
	mov	r1, r4
	mov	r0, r6
	beq	.L1040
	bl	VC1_Vfmw_ParseAdvFieldPicHdr
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1040:
	bl	VC1_Vfmw_ParseAdvFramePicHdr
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1039:
	mov	r1, #2
	mov	r0, r6
	bl	BsShow
	cmp	r0, #1
	mov	r7, r0
	ble	.L1041
	mov	r1, #2
	mov	r0, r6
	bl	BsSkip
	bic	r3, r7, #2
	mov	r0, r7
	b	.L1031
.L1041:
	mov	r1, r8
	mov	r0, r6
	bl	BsSkip
	mov	r3, #0
	mov	r0, r3
	b	.L1031
	.fnend
	.size	VC1_Vfmw_ParseAdvPicHdr, .-VC1_Vfmw_ParseAdvPicHdr
	.align	2
	.global	VC1_Vfmw_ParseAdvSlcHdr
	.type	VC1_Vfmw_ParseAdvSlcHdr, %function
VC1_Vfmw_ParseAdvSlcHdr:
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
	add	r3, r1, #20480
	mov	r7, r1
	mov	r1, #9
	mov	r5, r2
	ldr	r4, [r3, #3364]
	mov	r6, r0
	bl	BsGet
	mov	r1, #1
	mov	r3, r4, asl #4
	sub	r4, r3, r4, asl #2
	add	r4, r5, r4
	add	r4, r4, #520
	str	r0, [r4, #8]
	mov	r0, r6
	bl	BsGet
	uxtb	r0, r0
	strb	r0, [r4, #4]
	cmp	r0, #1
	beq	.L1045
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1045:
	add	lr, r5, #188
	add	ip, r7, #6912
	add	ip, ip, #36
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr, {r0, r1, r2}
	stmia	ip, {r0, r1, r2}
	add	r0, r7, #6720
	add	r1, r5, #16
	mov	r2, #172
	add	r0, r0, #56
	bl	memcpy
	add	r0, r7, #7104
	add	r1, r5, #348
	mov	r2, #176
	add	r0, r0, #4
	bl	memcpy
	add	r2, r7, #6720
	mov	r0, r6
	add	r2, r2, #40
	mov	r1, r7
	bl	VC1_Vfmw_ParseAdvPicHdr
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	VC1_Vfmw_ParseAdvSlcHdr, .-VC1_Vfmw_ParseAdvSlcHdr
	.align	2
	.global	VC1_ClearCurPacket
	.type	VC1_ClearCurPacket, %function
VC1_ClearCurPacket:
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
	ldr	r1, [r1, #28]
	mov	r5, r0
	bl	SM_ReleaseStreamSeg
	ldrsb	r3, [r4, #8]
	cmp	r3, #1
	beq	.L1047
	mov	r0, r5
	ldr	r1, [r4, #32]
	bl	SM_ReleaseStreamSeg
.L1047:
	ldr	r3, .L1051
	mov	r0, r4
	mov	r2, #36
	mov	r1, #0
	ldr	r3, [r3, #48]
	blx	r3
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1052:
	.align	2
.L1051:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VC1_ClearCurPacket, .-VC1_ClearCurPacket
	.align	2
	.global	VC1_ClearCurPic
	.type	VC1_ClearCurPic, %function
VC1_ClearCurPic:
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
	ldrb	r3, [r0, #3096]
	mov	r6, r1
	cmp	r3, #0
	beq	.L1054
	add	r7, r0, #20480
	ldr	r3, [r7, #3364]
	cmp	r3, #0
	ble	.L1068
	add	r4, r0, #23808
	mov	r5, #0
	add	r4, r4, #80
	b	.L1058
.L1057:
	ldr	r3, [r7, #3364]
	add	r4, r4, #48
	cmp	r3, r5
	ble	.L1069
.L1058:
	ldr	r1, [r4]
	mov	r0, r6
	bl	SM_ReleaseStreamSeg
	ldr	r3, [r4, #-36]
	add	r5, r5, #1
	cmp	r3, #0
	beq	.L1057
	ldr	r3, [r4, #-12]
	cmp	r3, #0
	beq	.L1057
	ldr	r1, [r4, #4]
	mov	r0, r6
	bl	SM_ReleaseStreamSeg
	ldr	r3, [r7, #3364]
	add	r4, r4, #48
	cmp	r3, r5
	bgt	.L1058
.L1069:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1054:
	add	r1, r0, #36096
	mov	r0, r6
	add	r1, r1, #44
	bl	VC1_ClearCurPacket
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1068:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	VC1_ClearCurPic, .-VC1_ClearCurPic
	.align	2
	.global	VC1DEC_VDMPostProc
	.type	VC1DEC_VDMPostProc, %function
VC1DEC_VDMPostProc:
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
	add	r5, r0, #49152
	mov	r7, r0
	add	r0, r0, #12672
	add	r4, r7, #32768
	add	r0, r0, #56
	mov	r6, r1
	ldr	r1, [r5, #224]
	bl	VC1_ClearCurPic
	ldr	r1, [r4, #3796]
	ldr	r0, [r5, #224]
	bl	FSP_GetFsImagePtr
	ldr	r1, [r4, #3792]
	mov	r8, r0
	ldr	r0, [r5, #224]
	bl	FSP_GetFsImagePtr
	ldr	r1, [r4, #3788]
	mov	r9, r0
	ldr	r0, [r5, #224]
	bl	FSP_GetFsImagePtr
	cmp	r8, #0
	beq	.L1103
	cmp	r6, #0
	movlt	r3, #0
	blt	.L1073
	cmp	r6, #100
	movlt	r3, r6
	movge	r3, #100
.L1073:
	add	r6, r7, #12288
	str	r3, [r8, #160]
	mov	r0, r7
	bl	VC1_SetImgFormat
	ldrb	r3, [r6, #443]
	cmp	r3, #3
	beq	.L1104
.L1074:
	add	r3, r8, #544
	add	r2, r8, #528
	mov	r0, #0
	mov	r1, #0
	strd	r0, [r2]
	strd	r0, [r3, #-8]
	ldr	r3, [r7]
	ldr	r3, [r3, #12]
	cmp	r3, #1
	beq	.L1075
	ldrb	r10, [r6, #442]
	sub	r10, r10, #2
	ands	r10, r10, #253
	beq	.L1076
	ldr	r10, [r4, #3784]
	cmp	r10, #1
	ldrhi	r1, [r4, #3788]
	mvnls	r1, #0
	cmp	r10, #1
	movls	r10, #0
	movhi	r10, #1
	str	r1, [r4, #3800]
.L1078:
	add	r2, r7, #45056
	cmn	r1, #1
	ldr	r3, [r2, #3808]
	add	r3, r3, #1
	str	r3, [r2, #3808]
	beq	.L1079
	ldr	r0, [r5, #224]
	bl	FSP_GetFsImagePtr
	subs	r9, r0, #0
	beq	.L1105
	ldr	r2, [r9, #160]
	cmp	r2, #0
	beq	.L1081
	ldr	r3, [r7]
	ldr	r3, [r3, #4]
	cmp	r2, r3
	bhi	.L1082
.L1081:
	ldr	r8, [r4, #3800]
	ldr	r0, [r5, #224]
	mov	r1, r8
	bl	FSP_GetRef
	mov	r2, r8
	ldr	r1, .L1108
	mov	r3, r0
	mov	r0, #12
	bl	dprint_vfmw
	mov	r2, #1
	ldr	r1, [r4, #3800]
	ldr	r0, [r5, #224]
	bl	FSP_SetDisplay
	cmp	r10, #1
	ldreq	r3, [r4, #3712]
	movne	r1, #1
	ldrne	r2, [r4, #3704]
	movne	r3, #2
	strneb	r1, [r2, #1]
	mov	r2, r7
	streqb	r10, [r3, #1]
	mov	r1, #1
	strneb	r3, [r6, #441]
	add	r3, r7, #48896
	streqb	r10, [r6, #441]
	add	r3, r3, #128
	ldr	r0, [r5, #224]
	str	r9, [sp]
	bl	InsertImgToVoQueue
	cmp	r0, #1
	beq	.L1085
	ldr	r1, [r9, #528]
	add	r3, r9, #528
	ldr	r0, [r5, #224]
	add	r8, r9, #544
	str	r3, [fp, #-48]
	bl	FreeUsdByDec
	ldr	r3, [fp, #-48]
	mov	r6, #0
	mov	r7, #0
	strd	r6, [r3]
	ldr	r1, [r9, #536]
	ldr	r0, [r5, #224]
	bl	FreeUsdByDec
	mov	r2, #0
	strd	r6, [r8, #-8]
	ldr	r0, [r5, #224]
	ldr	r1, [r4, #3800]
	bl	FSP_SetDisplay
	cmp	r10, #1
	mov	r3, #0
	ldreq	r2, [r4, #3712]
	mov	r0, r3
	ldrne	r2, [r4, #3704]
	strb	r3, [r2, #1]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1076:
	ldr	r1, [r4, #3796]
	cmp	r9, #0
	moveq	r10, r9
	str	r1, [r4, #3800]
	beq	.L1078
	add	ip, r9, #576
	add	r0, r8, #576
	ldrd	r2, [ip, #-8]
	ldrd	r8, [r0, #-8]
	cmp	r2, r8
	sbcs	lr, r3, r9
	strltd	r2, [r0, #-8]
	strltd	r8, [ip, #-8]
	ldrlt	r1, [r4, #3800]
	b	.L1078
.L1106:
	ldr	r2, [r4, #3708]
	mov	r3, #0
	strb	r3, [r2, #1]
	strb	r3, [r6, #441]
.L1079:
	mov	r0, #1
.L1072:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1104:
	ldrb	r3, [r6, #449]
	cmp	r3, #1
	bne	.L1079
	b	.L1074
.L1075:
	ldr	r1, [r4, #3796]
	mov	r10, #0
	str	r1, [r4, #3800]
	b	.L1078
.L1085:
	ldrb	r3, [r6, #441]
	sxtb	r3, r3
	cmp	r3, #3
	beq	.L1106
	cmp	r3, #1
	beq	.L1107
	cmp	r3, #2
	bne	.L1079
	ldr	r2, [r4, #3704]
	mov	r3, #0
	strb	r3, [r2, #1]
	strb	r3, [r6, #441]
	b	.L1072
.L1082:
	ldr	r1, .L1108+4
	mov	r0, #1
	add	ip, r9, #528
	str	ip, [fp, #-48]
	bl	dprint_vfmw
	ldr	r1, [r9, #528]
	ldr	r0, [r5, #224]
	add	r8, r9, #544
	bl	FreeUsdByDec
	ldr	ip, [fp, #-48]
	mov	r6, #0
	mov	r7, #0
	strd	r6, [ip]
	ldr	r1, [r9, #536]
	ldr	r0, [r5, #224]
	bl	FreeUsdByDec
	strd	r6, [r8, #-8]
	mov	r2, #0
	ldr	r0, [r5, #224]
	ldr	r1, [r4, #3800]
	bl	FSP_SetDisplay
	cmp	r10, #1
	mov	r2, #0
	ldreq	r3, [r4, #3712]
	moveq	r0, r10
	ldrne	r3, [r4, #3704]
	movne	r0, #1
	strb	r2, [r3, #1]
	b	.L1072
.L1107:
	ldr	r2, [r4, #3712]
	mov	r0, r3
	mov	r3, #0
	strb	r3, [r2, #1]
	strb	r3, [r6, #441]
	b	.L1072
.L1103:
	str	r0, [sp]
	mov	r3, r9
	mov	r2, r8
	ldr	r1, .L1108+8
	mov	r0, r8
	bl	dprint_vfmw
	mov	r0, r8
	b	.L1072
.L1105:
	mov	r2, #720
	ldr	r1, .L1108+12
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r9
	b	.L1072
.L1109:
	.align	2
.L1108:
	.word	.LC50
	.word	.LC51
	.word	.LC48
	.word	.LC49
	.fnend
	.size	VC1DEC_VDMPostProc, .-VC1DEC_VDMPostProc
	.align	2
	.global	VC1_Vfmw_DecodeArbiter
	.type	VC1_Vfmw_DecodeArbiter, %function
VC1_Vfmw_DecodeArbiter:
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
	add	r5, r0, #12288
	mov	r4, r0
	ldrb	r3, [r5, #440]
	tst	r3, #16
	beq	.L1163
	add	r7, r0, #45056
	bic	r3, r3, #20
	strb	r3, [r5, #440]
	ldr	r3, [r7, #3924]
	sub	r3, r3, #2
	cmp	r3, #1
	bls	.L1113
.L1115:
	ldr	r3, [r4]
	add	r6, r4, #32768
	ldr	r1, [r6, #3784]
	ldr	r2, [r3, #8]
.L1114:
	sub	r3, r2, #1
	str	r2, [r7, #3924]
	cmp	r3, #3
	ldrls	pc, [pc, r3, asl #2]
	b	.L1144
.L1125:
	.word	.L1119
	.word	.L1121
	.word	.L1143
	.word	.L1123
.L1142:
	mov	r1, #0
.L1123:
	ldrb	r3, [r5, #442]
	cmp	r3, #0
	streq	r3, [r7, #3856]
	moveq	r3, #1
	beq	.L1126
	cmp	r3, #2
	bne	.L1128
	ldr	r3, [r7, #3856]
	adds	r3, r3, #0
	movne	r3, #1
	cmp	r1, #0
	bne	.L1130
.L1129:
	ldr	r1, .L1165
	mov	r0, #1
	bl	dprint_vfmw
.L1137:
	add	r5, r4, #49152
	add	r0, r4, #12672
	add	r0, r0, #56
	ldr	r1, [r5, #224]
	bl	VC1_ClearCurPic
	ldr	r3, .L1165+4
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L1163
	mov	r3, #0
	ldr	r0, [r5, #224]
	mov	r2, r3
	mov	r1, #113
	blx	ip
.L1163:
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1113:
	ldr	r3, [r0]
	ldr	r2, [r3, #8]
	cmp	r2, #4
	cmpne	r2, #1
	bhi	.L1115
	add	r6, r0, #32768
	add	r8, r0, #49152
	ldr	r1, .L1165+8
	mov	r0, #2
	bl	dprint_vfmw
	ldr	r1, [r6, #3792]
	ldr	r0, [r8, #224]
	bl	FSP_GetFsImagePtr
	subs	r9, r0, #0
	beq	.L1116
	ldr	r1, [r9, #528]
	add	r3, r9, #560
	ldr	r0, [r8, #224]
	add	r10, r9, #544
	str	r3, [fp, #-48]
	bl	FreeUsdByDec
	ldr	r1, [r9, #536]
	add	ip, r9, #528
	ldr	r0, [r8, #224]
	str	ip, [fp, #-52]
	bl	FreeUsdByDec
	ldr	r1, [r9, #544]
	ldr	r0, [r8, #224]
	bl	FreeUsdByDec
	ldr	r9, [fp, #-48]
	ldr	r0, [r8, #224]
	ldr	r1, [r9, #-8]
	bl	FreeUsdByDec
	ldr	ip, [fp, #-52]
	mov	r0, #0
	mov	r1, #0
	mov	r2, #1
	strd	r0, [ip]
	strd	r0, [r10, #-8]
	strd	r0, [r10]
	strd	r0, [r9, #-8]
	ldr	r1, [r6, #3792]
	ldr	r0, [r8, #224]
	bl	FSP_ClearLogicFs
	mov	r2, #1
	ldr	r1, [r6, #3788]
	ldr	r0, [r8, #224]
	bl	FSP_ClearLogicFs
	mov	r3, #0
	str	r3, [r6, #3788]
	str	r3, [r6, #3792]
	ldr	r0, [r8, #224]
	bl	FSP_GetNullLogicFs
	str	r0, [r6, #3792]
	str	r0, [r6, #3788]
.L1116:
	ldr	r2, [r6, #3708]
	mov	r3, #0
	str	r3, [r6, #3784]
	cmp	r2, r3
	beq	.L1124
	ldr	r1, [r6, #3712]
	cmp	r1, #0
	beq	.L1124
	strb	r3, [r2, #1]
	ldr	r2, [r6, #3712]
	strb	r3, [r2, #1]
	ldr	r2, [r6, #3708]
	strb	r3, [r2]
	ldr	r2, [r6, #3712]
	strb	r3, [r2]
	ldr	r3, [r4]
	ldr	r1, [r6, #3784]
	ldr	r2, [r3, #8]
	b	.L1114
.L1143:
	mov	r3, #0
.L1126:
	cmp	r1, #0
	beq	.L1122
.L1130:
	cmp	r1, #1
	bls	.L1164
.L1133:
	cmp	r3, #0
	beq	.L1137
	ldrb	r3, [r5, #3536]
	cmp	r3, #0
	bne	.L1136
	add	r3, r5, #3600
	add	ip, r4, #23040
	add	r3, r3, #4
	add	ip, ip, #44
	ldmia	r3, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
	add	r1, r5, #3840
	add	r0, r4, #23296
	add	r1, r1, #12
	mov	r2, #100
	add	r0, r0, #36
	bl	memcpy
	mov	r0, #1
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1139:
	mov	r1, #0
.L1119:
	ldrb	r3, [r5, #442]
	sub	r3, r3, #2
	tst	r3, #253
	movne	r3, #1
	moveq	r3, #0
	cmp	r1, #0
	bne	.L1130
.L1122:
	ldrb	r2, [r5, #442]
	sub	r0, r2, #4
	sub	r1, r2, #1
	cmp	r1, #1
	cmphi	r0, #1
	bls	.L1129
.L1131:
	sub	r2, r2, #2
	tst	r2, #253
	bne	.L1133
	ldr	r1, .L1165+12
	mov	r0, #1
	bl	dprint_vfmw
	b	.L1137
.L1140:
	mov	r1, #0
.L1121:
	ldrb	r3, [r5, #442]
	clz	r3, r3
	mov	r3, r3, lsr #5
	b	.L1126
.L1136:
	add	r1, r5, #3616
	add	r0, r4, #23040
	add	r1, r1, #4
	mov	r2, #172
	add	r0, r0, #60
	bl	memcpy
	add	lr, r5, #3792
	add	ip, r4, #23040
	ldmia	lr!, {r0, r1, r2, r3}
	add	ip, ip, #232
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr, {r0, r1, r2}
	stmia	ip, {r0, r1, r2}
	add	r0, r4, #23296
	add	r1, r5, #3952
	mov	r2, #176
	add	r0, r0, #136
	bl	memcpy
	ldr	r3, [r5, #3996]
	ldr	r2, .L1165+16
	add	r1, r4, #16384
	add	r0, r4, #23552
	add	r1, r1, #32
	strb	r3, [r5, #444]
	add	r0, r0, #56
	ldr	r3, [r6, #3804]
	ldr	ip, [r2, #52]
	mov	r2, r3, asl #4
	sub	r2, r2, r3, asl #2
	blx	ip
	mov	r0, #1
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1138:
	mov	r1, #0
.L1144:
	mov	r3, #1
	b	.L1126
.L1128:
	and	r3, r3, #251
	cmp	r3, #1
	bne	.L1144
	str	r3, [r7, #3856]
	b	.L1126
.L1124:
	ldr	r3, [r4]
	ldr	r2, [r3, #8]
	sub	r3, r2, #1
	str	r2, [r7, #3924]
	cmp	r3, #3
	ldrls	pc, [pc, r3, asl #2]
	b	.L1138
.L1120:
	.word	.L1139
	.word	.L1140
	.word	.L1141
	.word	.L1142
.L1141:
	mov	r3, #0
	b	.L1122
.L1164:
	ldrb	r2, [r5, #442]
	b	.L1131
.L1166:
	.align	2
.L1165:
	.word	.LC53
	.word	g_event_report
	.word	.LC52
	.word	.LC54
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VC1_Vfmw_DecodeArbiter, .-VC1_Vfmw_DecodeArbiter
	.align	2
	.global	VC1_Vfmw_StartDecode
	.type	VC1_Vfmw_StartDecode, %function
VC1_Vfmw_StartDecode:
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
	ldr	r3, [r0]
	add	r5, r0, #12288
	add	r6, r0, #12672
	mov	r4, r0
	add	r6, r6, #56
	ldr	r2, [r3, #588]
	add	r8, r0, #8
	ldrb	r1, [r5, #3536]
	str	r2, [r5, #264]
	cmp	r1, #0
	ldr	r3, [r3, #624]
	str	r3, [r5, #268]
	beq	.L1182
.L1168:
	add	r7, r4, #32768
	mov	r1, r8
	mov	r0, r4
	bl	VC1_WritePicMsg
	ldr	r3, [r7, #3804]
	ldr	ip, .L1187
	add	r1, r6, #23808
	add	r1, r1, #40
	add	r0, r4, #92
	mov	r2, r3, asl #6
	strb	r3, [r4, #78]
	sub	r2, r2, r3, asl #4
	ldr	r3, [ip, #52]
	blx	r3
	mov	r1, r8
	mov	r0, r6
	bl	VC1_CfgVDH
	ldrb	r3, [r5, #442]
	cmp	r3, #1
	ldrlsb	r2, [r5, #444]
	strlsb	r2, [r5, #445]
	cmp	r3, #5
	beq	.L1183
	mov	r3, #0
	strb	r3, [r4, #9]
	ldrb	r3, [r5, #444]
	ldrb	r2, [r5, #448]
.L1171:
	strb	r3, [r4, #8]
	strb	r3, [r5, #443]
	strb	r2, [r5, #449]
	ldrb	r3, [r4, #11]
	cmp	r3, #2
	beq	.L1184
	and	r2, r3, #251
	cmp	r2, #1
	addeq	r1, r4, #45056
	streq	r2, [r1, #3856]
.L1173:
	ldr	r2, [r4]
	str	r8, [r4, #4]
	ldr	r0, [r2, #856]
	cmp	r0, #1
	beq	.L1185
	cmp	r0, #2
	beq	.L1186
.L1178:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1186:
	ldr	r2, [r2, #860]
	cmp	r8, #0
	cmpne	r2, #0
	ble	.L1178
	sub	r3, r3, #2
	ands	r5, r3, #253
	bne	.L1178
	ldr	r3, [r7, #3704]
	add	r1, r4, #49152
	mov	r0, r6
	strb	r5, [r3, #1]
	ldr	r2, [r4]
	ldr	r3, [r2, #860]
	sub	r3, r3, #1
	str	r3, [r2, #860]
	ldr	r1, [r1, #224]
	bl	VC1_ClearCurPic
	str	r5, [r4, #4]
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1184:
	add	r9, r4, #45056
	ldr	r5, [r9, #3856]
	cmp	r5, #0
	bne	.L1173
	add	r3, r4, #49152
	mov	r0, r6
	ldr	r1, [r3, #224]
	bl	VC1_ClearCurPic
	ldr	r3, [r7, #3704]
	mov	r0, r5
	strb	r5, [r3]
	ldr	r3, [r9, #3860]
	add	r3, r3, #1
	str	r3, [r9, #3860]
	str	r5, [r4, #4]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1183:
	mov	r2, #1
	strb	r2, [r4, #9]
	ldrb	r3, [r5, #445]
	add	r1, r4, #45056
	strb	r2, [r5, #448]
	strb	r3, [r5, #444]
	ldr	r1, [r1, #3880]
	sub	r1, r1, #1
	str	r1, [r5, #172]
	b	.L1171
.L1185:
	cmp	r8, #0
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	sub	r3, r3, #2
	ands	r5, r3, #253
	ldmnefd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	ldr	r2, [r7, #3704]
	add	r3, r4, #49152
	mov	r0, r6
	strb	r5, [r2, #1]
	ldr	r1, [r3, #224]
	bl	VC1_ClearCurPic
	str	r5, [r4, #4]
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1182:
	mov	r0, r6
	bl	VC1_Vfmw_UpdataLastPicRNDCTRL.part.5
	b	.L1168
.L1188:
	.align	2
.L1187:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VC1_Vfmw_StartDecode, .-VC1_Vfmw_StartDecode
	.align	2
	.global	VC1_Vfmw_ParseAdvHdr
	.type	VC1_Vfmw_ParseAdvHdr, %function
VC1_Vfmw_ParseAdvHdr:
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
	ldr	r5, [r0, #3128]
	add	r8, r0, #32768
	mov	r4, r0
	str	r1, [fp, #-52]
	mov	r10, #0
	mov	r1, #32
	strb	r10, [r0, #6]
	mov	r0, r5
	str	r2, [fp, #-48]
	bl	BsGet
	ldr	r3, [r5, #24]
	add	r7, r4, #36096
	ldr	r6, [r8, #3372]
	add	r7, r7, #44
	cmp	r3, r10
	add	r1, r3, #7
	ldr	r2, [r8, #3392]
	movlt	r3, r1
	mov	r3, r3, asr #3
	add	r6, r6, r3
	rsb	r2, r3, r2
	mov	r1, r6
	uxtb	r9, r0
	mov	r0, r5
	bl	BsInit
	sub	r2, r9, #10
	cmp	r2, #5
	bhi	.L1190
	cmp	r9, #11
	ldrb	r3, [r4]
	beq	.L1259
	and	r1, r3, #7
	cmp	r1, #7
	beq	.L1260
	add	r9, r4, #20480
	strb	r10, [r4, #8]
	str	r10, [r9, #3364]
	cmp	r2, #5
	ldrls	pc, [pc, r2, asl #2]
	b	.L1222
.L1206:
	.word	.L1205
	.word	.L1222
	.word	.L1207
	.word	.L1224
	.word	.L1209
	.word	.L1210
.L1190:
	sub	r2, r9, #27
	cmp	r2, #4
	bls	.L1223
	cmp	r9, #254
	beq	.L1261
.L1222:
	ldr	r0, [fp, #-48]
	mov	r1, r7
	bl	VC1_ClearCurPacket
	mov	r0, #0
.L1195:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1261:
	mov	r1, #32
	mov	r0, r5
	bl	BsGet
	mov	r1, #32
	mov	r6, r0
	mov	r0, r5
	bl	BsGet
	movw	r2, #20036
	movw	r3, #20553
	movt	r2, 17221
	movt	r3, 18515
	cmp	r0, r2
	cmpeq	r6, r3
	bne	.L1222
	ldrb	r3, [r4]
	mov	r2, #1
	strb	r2, [r4, #7]
	and	r2, r3, #7
	cmp	r2, #7
	orreq	r3, r3, #16
	streqb	r3, [r4]
.L1223:
	ldr	r0, [fp, #-48]
	mov	r1, r7
	bl	VC1_ClearCurPacket
	mov	r0, #1
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1259:
	and	r3, r3, #7
	cmp	r3, #7
	beq	.L1262
.L1220:
	ldr	r0, [fp, #-48]
	mov	r1, r7
	bl	VC1_ClearCurPacket
	mov	r0, r10
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1224:
	ldr	r10, .L1265
.L1252:
	ldr	r0, [fp, #-52]
	mov	r2, #176
	ldr	ip, [r10, #48]
	mov	r1, #0
	add	r0, r0, #348
	ldrb	r3, [r0, #31]
	str	r3, [fp, #-56]
	blx	ip
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-56]
	strb	r3, [r2, #379]
.L1211:
	add	r0, r4, #23808
	ldr	r3, [r10, #48]
	mov	r2, #12288
	mov	r1, #0
	add	r0, r0, #40
	blx	r3
	mov	r0, r5
	bl	BsPos
	ldr	r3, [fp, #-52]
	mov	r1, r4
	mov	r2, r3
	str	r0, [r3, #488]
	mov	r0, r5
	bl	VC1_Vfmw_ParseAdvPicHdr
	cmp	r0, #1
	mov	r10, r0
	beq	.L1263
	mov	r1, r7
	ldr	r0, [fp, #-48]
	bl	VC1_ClearCurPacket
	movw	r2, #6091
	ldr	r1, .L1265+4
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r10
	b	.L1195
.L1260:
	mov	r10, #1
	orr	r3, r3, #16
	strb	r10, [r4, #6]
	mov	r0, r10
	strb	r3, [r4]
	b	.L1195
.L1207:
	ldr	r10, .L1265
	mov	r3, #1
	strb	r3, [r4, #8]
	mov	r2, #16
	ldr	r3, [fp, #-52]
	mov	r1, #0
	add	r0, r3, #508
	ldr	r3, [r10, #48]
	blx	r3
	ldrb	r3, [r4, #8]
	cmp	r3, #0
	bne	.L1211
	b	.L1252
.L1210:
	ldr	r2, [fp, #-52]
	mov	r0, r5
	mov	r1, r4
	bl	VC1_Vfmw_ParseAdvSeqHdr
	cmp	r0, #1
	mov	r10, r0
	ldreqb	r3, [r4]
	orreq	r3, r3, #1
	streqb	r3, [r4]
	b	.L1220
.L1209:
	mov	r0, r5
	ldr	r2, [fp, #-52]
	mov	r1, r4
	bl	VC1_Vfmw_ParseAdvEntptHdr
	cmp	r0, #1
	mov	r10, r0
	bne	.L1220
	ldr	r1, [fp, #-52]
	mov	r0, r4
	bl	VC1_Vfmw_UpdateAdvSPS
	ldrb	r3, [r4]
	orr	r3, r3, #2
	strb	r3, [r4]
	b	.L1220
.L1205:
	orr	r3, r3, #32
	ldr	r0, [fp, #-48]
	mov	r1, r7
	strb	r3, [r4]
	bl	VC1_ClearCurPacket
	mov	r0, #1
	b	.L1195
.L1262:
	mov	r0, r5
	ldr	r2, [fp, #-52]
	mov	r1, r4
	bl	VC1_Vfmw_ParseAdvSlcHdr
	cmp	r0, #1
	mov	r5, r0
	bne	.L1193
	add	r9, r4, #20480
	ldr	r7, [r9, #3364]
	cmp	r7, #255
	bgt	.L1264
	mov	r3, r7, asl #4
	mov	r2, r7, asl #6
	rsb	r5, r3, r2
	str	r3, [fp, #-48]
	ldr	r3, [r4, #3128]
	add	r5, r4, r5
	str	r2, [fp, #-56]
	movw	r2, #23856
	strb	r7, [r5, r2]
	movw	ip, #23848
	ldr	r1, [r3, #24]
	movw	r0, #23864
	cmp	r1, #0
	add	r2, r1, #7
	movlt	r1, r2
	add	r2, r5, #23808
	add	r1, r6, r1, asr #3
	str	r1, [r5, ip]
	ldr	r1, [r3, #24]
	mov	r6, r2
	and	r1, r1, #7
	str	r1, [r5, r0]
	ldr	r1, [r3, #16]
	ldr	r0, [r3, #24]
	add	r3, r2, #40
	str	r3, [fp, #-60]
	rsb	r1, r0, r1, lsl #3
	str	r1, [r2, #60]
	ldr	r0, [r5, ip]
	str	r3, [fp, #-64]
	bl	MEM_Vir2Phy
	movw	r1, #23888
	add	r2, r6, #80
	str	r0, [r6, #52]
	ldr	r0, [r8, #3400]
	str	r0, [r5, r1]
	ldr	r1, [r8, #3376]
	cmp	r1, #0
	beq	.L1196
	ldr	r0, [r8, #3388]
	ldr	r3, [fp, #-60]
	cmp	r0, #0
	beq	.L1196
	movw	ip, #23880
	str	r1, [r3, #4]
	str	r10, [r5, ip]
	add	r3, r5, #23808
	ldr	r1, [r8, #3396]
	str	r0, [r3, #68]
	mov	r1, r1, asl #3
	str	r1, [r3, #76]
	ldr	r3, [r8, #3404]
	str	r3, [r2, #4]
.L1197:
	ldr	r0, [r9, #3284]
	ldr	r1, [r9, #3280]
	ldrb	r10, [r4, #8]
	mul	r1, r1, r0
	cmp	r10, #0
	sub	r1, r1, #1
	beq	.L1198
	ldr	r2, [fp, #-48]
	add	r3, r0, #1
	ldr	lr, [fp, #-52]
	movw	r5, #23872
	sub	ip, r2, r7, asl #2
	add	r3, r3, r3, lsr #31
	add	ip, lr, ip
	ldr	lr, [fp, #-56]
	add	ip, ip, #520
	rsb	lr, r2, lr
	ldr	r2, [ip, #8]
	add	lr, r4, lr
	sub	r3, r2, r3, asr #1
	cmp	r1, r3
	str	r3, [lr, r5]
	movcs	r1, #0
	movcc	r1, #1
	cmp	r3, #0
	movle	r1, #0
	cmp	r1, #0
	bne	.L1253
.L1199:
	ldr	r3, [fp, #-56]
	ldr	r2, [fp, #-48]
	rsb	r3, r2, r3
	add	r4, r4, r3
.L1258:
	add	r3, r4, #23808
	add	r3, r3, #56
	ldr	r3, [r3, #4]
	cmp	r3, #0
	ble	.L1202
	add	r3, r4, #23808
	add	r3, r3, #40
	ldr	r3, [r3, #4]
	cmp	r3, #0
	beq	.L1218
	add	r4, r4, #23808
	ldr	r3, [r4, #76]
	cmp	r3, #0
	ble	.L1202
.L1218:
	ldr	r3, [r9, #3364]
	mov	r0, #1
	add	r3, r3, r0
	str	r3, [r9, #3364]
	b	.L1195
.L1263:
	mov	r0, r5
	bl	BsPos
	ldr	r2, [fp, #-52]
	ldr	r3, [r2, #488]
	rsb	r0, r3, r0
	str	r0, [r2, #488]
	ldrb	r3, [r4]
	mov	r0, r5
	orr	r3, r3, #4
	strb	r3, [r4]
	bl	BsPos
	ldr	r3, [r8, #3392]
	add	r0, r0, #32
	cmp	r0, r3, asl #3
	bge	.L1213
	ldr	r7, [r9, #3364]
	movw	r3, #23856
	ldr	r2, [r4, #3128]
	movw	ip, #23864
	mov	r1, r7, asl #6
	mov	r10, r7, asl #4
	rsb	r5, r10, r1
	str	r1, [fp, #-48]
	add	r5, r4, r5
	add	r0, r5, #23808
	strb	r7, [r5, r3]
	ldr	r1, [r2, #24]
	cmp	r1, #0
	add	r3, r1, #7
	movlt	r1, r3
	add	r3, r0, #48
	str	r3, [fp, #-56]
	add	r1, r6, r1, asr #3
	str	r3, [fp, #-60]
	movw	r3, #23848
	str	r1, [r5, r3]
	add	r6, r0, #40
	ldr	r1, [r2, #24]
	and	r1, r1, #7
	str	r1, [r5, ip]
	ldr	r1, [r2, #16]
	ldr	r2, [r2, #24]
	rsb	r2, r2, r1, lsl #3
	str	r2, [r0, #60]
	ldr	r0, [r5, r3]
	bl	MEM_Vir2Phy
	ldr	r3, [fp, #-56]
	movw	r1, #23888
	add	r2, r5, #23808
	add	r2, r2, #80
	str	r0, [r3, #4]
	ldr	r3, [r8, #3400]
	str	r3, [r5, r1]
	ldr	r3, [r8, #3376]
	cmp	r3, #0
	beq	.L1214
	ldr	r1, [r8, #3388]
	cmp	r1, #0
	beq	.L1214
	movw	r0, #23880
	str	r3, [r6, #4]
	mov	ip, #0
	str	ip, [r5, r0]
	ldr	r0, [r8, #3396]
	add	r3, r5, #23808
	str	r1, [r3, #68]
	mov	r0, r0, asl #3
	str	r0, [r3, #76]
	ldr	r3, [r8, #3404]
	str	r3, [r2, #4]
.L1215:
	ldr	r0, [r9, #3284]
	ldr	r1, [r9, #3280]
	ldrb	r5, [r4, #8]
	mul	r1, r1, r0
	cmp	r5, #0
	sub	r1, r1, #1
	beq	.L1216
	ldr	r2, [fp, #-52]
	sub	ip, r10, r7, asl #2
	add	r3, r0, #1
	movw	r5, #23872
	add	ip, r2, ip
	ldr	r2, [fp, #-48]
	add	r3, r3, r3, lsr #31
	add	ip, ip, #520
	rsb	lr, r10, r2
	ldr	r2, [ip, #8]
	add	lr, r4, lr
	sub	r3, r2, r3, asr #1
	cmp	r1, r3
	str	r3, [lr, r5]
	movcs	r1, #0
	movcc	r1, #1
	cmp	r3, #0
	movle	r1, #0
	cmp	r1, #0
	bne	.L1253
.L1217:
	ldr	r3, [fp, #-48]
	rsb	r7, r10, r3
	add	r4, r4, r7
	b	.L1258
.L1193:
	mov	r1, r7
	ldr	r0, [fp, #-48]
	bl	VC1_ClearCurPacket
	movw	r2, #6002
	ldr	r1, .L1265+8
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r5
	b	.L1195
.L1213:
	mov	r1, r7
	ldr	r0, [fp, #-48]
	bl	VC1_ClearCurPacket
	movw	r2, #6085
	ldr	r1, .L1265+4
	mov	r0, r10
	bl	dprint_vfmw
	mov	r0, r10
	b	.L1195
.L1214:
	ldr	r3, [fp, #-48]
	movw	ip, #23880
	mov	r2, #0
	rsb	r3, r10, r3
	add	r3, r4, r3
	add	r5, r3, #23808
	add	lr, r5, #72
	str	r2, [r5, #44]
	str	r2, [r3, ip]
	str	r2, [r5, #76]
	str	r2, [r5, #68]
	str	r2, [r5, #84]
	b	.L1215
.L1264:
	ldr	r1, [fp, #-48]
	mov	r0, r4
	bl	VC1_ClearCurPic
	ldr	r2, [r9, #3364]
	mov	r0, r5
	ldr	r1, .L1265+12
	bl	dprint_vfmw
	mov	r0, r10
	b	.L1195
.L1196:
	ldr	r2, [fp, #-48]
	movw	ip, #23880
	ldr	r3, [fp, #-56]
	rsb	r3, r2, r3
	mov	r2, #0
	add	r3, r4, r3
	add	r5, r3, #23808
	add	lr, r5, #72
	str	r2, [r5, #44]
	str	r2, [r3, ip]
	str	r2, [r5, #76]
	str	r2, [r5, #68]
	str	r2, [r5, #84]
	b	.L1197
.L1216:
	ldr	r3, [fp, #-48]
	sub	r2, r10, r7, asl #2
	movw	ip, #23872
	rsb	r0, r10, r3
	ldr	r3, [fp, #-52]
	add	r0, r4, r0
	add	r2, r3, r2
	add	r2, r2, #520
	ldr	r3, [r2, #8]
	cmp	r1, r3
	str	r3, [r0, ip]
	bcs	.L1217
	ldr	r2, [r2, #8]
	mov	r0, #1
	str	r1, [sp]
	ldr	r1, .L1265+16
	bl	dprint_vfmw
	mov	r0, r5
	b	.L1195
.L1198:
	ldr	r3, [fp, #-48]
	movw	ip, #23872
	ldr	r0, [fp, #-56]
	sub	r2, r3, r7, asl #2
	rsb	r0, r3, r0
	ldr	r3, [fp, #-52]
	add	r0, r4, r0
	add	r2, r3, r2
	add	r2, r2, #520
	ldr	r3, [r2, #8]
	cmp	r1, r3
	str	r3, [r0, ip]
	bcs	.L1199
	ldr	r2, [r2, #8]
	mov	r0, #1
	str	r1, [sp]
	ldr	r1, .L1265+16
	bl	dprint_vfmw
	mov	r0, r10
	b	.L1195
.L1202:
	ldr	r1, .L1265+20
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	b	.L1195
.L1253:
	ldr	r2, [ip, #8]
	ldr	r1, .L1265+24
	str	r0, [sp]
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	b	.L1195
.L1266:
	.align	2
.L1265:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC57
	.word	.LC56
	.word	.LC55
	.word	.LC39
	.word	.LC40
	.word	.LC38
	.fnend
	.size	VC1_Vfmw_ParseAdvHdr, .-VC1_Vfmw_ParseAdvHdr
	.align	2
	.global	VC1_Vfmw_ParseHeader
	.type	VC1_Vfmw_ParseHeader, %function
VC1_Vfmw_ParseHeader:
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
	ldrb	r3, [r0, #3096]
	mov	r4, r0
	cmp	r3, #0
	bne	.L1268
	ldrb	r3, [r0]
	mov	r2, r1
	mov	r1, r0
	ldr	r0, [r0, #3128]
	orr	r3, r3, #3
	strb	r3, [r4]
	bl	VC1_Vfmw_ParseSMPPicHdr
	cmp	r0, #1
	ldreqb	r3, [r4]
	orreq	r3, r3, #20
	streqb	r3, [r4]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1268:
	bl	VC1_Vfmw_ParseAdvHdr
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	VC1_Vfmw_ParseHeader, .-VC1_Vfmw_ParseHeader
	.align	2
	.global	VC1_SetCodeInfo
	.type	VC1_SetCodeInfo, %function
VC1_SetCodeInfo:
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
	add	r4, r0, #12288
	mov	r5, r0
	add	r0, r0, #15808
	ldrb	r3, [r4, #3538]
	add	r0, r0, #52
	str	r0, [r4, #3568]
	cmp	r3, #8
	strneb	r3, [r4, #451]
	moveq	r3, #6
	movne	r3, #0
	streqb	r3, [r4, #451]
	moveq	r2, #1
	strneb	r3, [r4, #452]
	ldrb	r3, [r4, #3536]
	streqb	r2, [r4, #452]
	cmp	r3, #0
	ldr	r2, [r1, #20]
	ldr	r1, [r1]
	beq	.L1275
	bl	BsInit
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1275:
	bl	BsInit
	ldr	r0, [r4, #3544]
	add	r5, r5, #32768
	add	r2, r4, #3552
	adds	r3, r0, #15
	add	ip, r4, #3600
	addmi	r3, r0, #30
	add	ip, ip, #4
	mov	r3, r3, asr #4
	str	r3, [r5, #3720]
	ldr	r1, [r4, #3548]
	str	r0, [r5, #3736]
	adds	r3, r1, #15
	addmi	r3, r1, #30
	str	r1, [r5, #3740]
	mov	r3, r3, asr #4
	str	r3, [r5, #3724]
	ldmia	r2, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	VC1_SetCodeInfo, .-VC1_SetCodeInfo
	.align	2
	.global	VC1_ReceivePacket
	.type	VC1_ReceivePacket, %function
VC1_ReceivePacket:
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
	subs	r4, r1, #0
	add	r1, r0, #48640
	add	r1, r1, #228
	beq	.L1284
	ldr	r2, [r4, #8]
	add	r3, r0, #45056
	str	r2, [r3, #3824]
	ldr	r2, [r4]
	str	r2, [r3, #3812]
	ldr	r2, [r4, #12]
	str	r2, [r3, #3832]
	ldrb	r2, [r4, #5]
	strb	r2, [r3, #3820]
	ldr	r2, [r4, #16]
	str	r2, [r3, #3840]
	ldrb	r2, [r4, #5]
	cmp	r2, #1
	beq	.L1279
	ldr	r2, [r4, #88]
	str	r2, [r3, #3828]
	ldr	r2, [r4, #80]
	str	r2, [r3, #3816]
	ldr	r2, [r4, #92]
	str	r2, [r3, #3836]
	ldrb	r2, [r4, #85]
	strb	r2, [r3, #3821]
	ldr	r2, [r4, #96]
	str	r2, [r3, #3844]
	ldrb	r3, [r4, #85]
	cmp	r3, #1
	bne	.L1285
.L1280:
	bl	VC1_SetCodeInfo
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1285:
	add	r0, r0, #49152
	ldr	r0, [r0, #224]
	bl	VC1_ClearCurPacket
	ldrb	r2, [r4, #85]
	ldr	r1, .L1286
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1279:
	mov	r2, #0
	str	r2, [r3, #3828]
	str	r2, [r3, #3816]
	str	r2, [r3, #3836]
	strb	r2, [r3, #3821]
	str	r2, [r3, #3844]
	b	.L1280
.L1284:
	ldr	r1, .L1286+4
	mov	r0, r4
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1287:
	.align	2
.L1286:
	.word	.LC59
	.word	.LC58
	.fnend
	.size	VC1_ReceivePacket, .-VC1_ReceivePacket
	.align	2
	.global	VC1DEC_Decode
	.type	VC1DEC_Decode, %function
VC1DEC_Decode:
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
	ldr	r3, .L1317
	add	r5, r0, #12544
	mov	r4, r0
	add	r5, r5, #24
	mov	r2, #160
	ldr	r3, [r3, #52]
	mov	r0, r5
	blx	r3
	mov	r1, r5
	mov	r0, r4
	bl	VC1_ReceivePacket
	subs	r6, r0, #0
	beq	.L1312
	ldr	r3, [r4]
	ldr	r2, [r3, #824]
	cmp	r2, #1
	beq	.L1313
.L1291:
	add	r2, r4, #12288
	add	r3, r4, #45056
	ldrb	r2, [r2, #440]
	strb	r2, [r3, #3928]
.L1292:
	add	r5, r4, #12672
	add	r7, r4, #49152
	add	r5, r5, #56
	add	r1, r4, #15872
	ldr	r2, [r7, #224]
	add	r1, r1, #20
	mov	r0, r5
	bl	VC1_Vfmw_ParseHeader
	subs	r8, r0, #0
	beq	.L1314
	mov	r0, r4
	bl	VC1_Vfmw_DecodeArbiter
	cmp	r0, #0
	bne	.L1315
.L1295:
	mov	r6, #0
.L1290:
	mov	r0, r6
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1314:
	add	r1, r4, #48640
	ldr	r0, [r7, #224]
	add	r1, r1, #228
	bl	VC1_ClearCurPacket
	ldr	r3, .L1317+4
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L1295
	ldr	r0, [r7, #224]
	mov	r3, r8
	mov	r2, r8
	mov	r1, #113
	mov	r6, r8
	blx	ip
	mov	r0, r6
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1313:
	ldr	r3, [r3, #864]
	cmp	r3, #1
	bne	.L1291
	add	r2, r4, #45056
	add	r3, r4, #12288
	ldrb	r2, [r2, #3928]
	strb	r2, [r3, #440]
	b	.L1292
.L1312:
	add	r4, r4, #45056
	ldr	r1, .L1317+8
	ldr	r2, [r4, #3808]
	bl	dprint_vfmw
	mov	r0, r6
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1315:
	mov	r0, r4
	bl	VC1_Vfmw_PrepareDecode
	subs	r6, r0, #0
	bne	.L1296
	ldr	r3, [r4]
	ldr	r2, [r3, #824]
	cmp	r2, #1
	beq	.L1316
.L1297:
	mov	r0, r5
	ldr	r1, [r7, #224]
	bl	VC1_ClearCurPic
.L1298:
	ldr	r3, .L1317+4
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L1295
	mov	r3, #0
	ldr	r0, [r7, #224]
	mov	r2, r3
	mov	r1, #113
	blx	ip
	b	.L1290
.L1316:
	ldr	r3, [r3, #864]
	cmp	r3, #1
	bne	.L1297
	b	.L1298
.L1296:
	mov	r0, r4
	bl	VC1_Vfmw_StartDecode
	subs	r6, r0, #0
	movne	r6, r8
	bne	.L1290
	add	r4, r4, #32768
	mov	r2, #1
	ldr	r0, [r7, #224]
	ldr	r1, [r4, #3796]
	bl	FSP_ClearLogicFs
	ldr	r2, [r4, #3704]
	ldr	r3, .L1317+4
	strb	r6, [r2]
	ldr	r2, [r4, #3704]
	strb	r6, [r2, #1]
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L1295
	ldr	r0, [r7, #224]
	mov	r3, r6
	mov	r2, r6
	mov	r1, #113
	blx	ip
	b	.L1290
.L1318:
	.align	2
.L1317:
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_event_report
	.word	.LC60
	.fnend
	.size	VC1DEC_Decode, .-VC1DEC_Decode
	.align	2
	.global	VC1_GetPacketState
	.type	VC1_GetPacketState, %function
VC1_GetPacketState:
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
	add	r0, r0, #12672
	ldrsb	r3, [r0, #62]
	cmp	r3, #1
	moveq	r0, #2
	movne	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VC1_GetPacketState, .-VC1_GetPacketState
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	__func__.14788, %object
	.size	__func__.14788, 13
__func__.14788:
	.ascii	"Vc1SMPSeqHdr\000"
	.space	3
.LC0:
	.word	0
	.word	1
	.word	0
	.word	1
	.word	0
	.word	1
	.word	0
	.word	1
	.word	1
	.word	2
	.word	1
	.word	2
	.word	2
	.word	3
	.word	3
	.word	3
.LC1:
	.word	3
	.word	1
	.word	2
	.word	0
	.word	4
.LC2:
	.word	1
	.word	0
	.word	2
	.word	3
	.word	4
.LC3:
	.word	3
	.word	1
.LC4:
	.word	3
	.word	1
	.word	2
	.word	0
.LC5:
	.word	1
	.word	0
	.word	2
	.word	3
.LC6:
	.word	1
	.word	1
	.word	2
	.word	1
	.word	3
	.word	1
	.word	2
.LC7:
	.word	2
	.word	3
	.word	3
	.word	4
	.word	4
	.word	5
	.word	5
.LC8:
	.word	3
	.word	4
	.word	1
	.word	5
	.word	1
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	1
	.word	3
	.word	5
	.word	7
.LC9:
	.word	5
	.word	5
	.word	6
	.word	6
	.word	7
	.word	7
	.word	7
	.word	7
	.word	7
	.word	7
	.word	8
	.word	8
	.word	8
	.word	8
.LC10:
	.word	256
	.word	128
	.word	85
	.word	64
	.word	51
	.word	43
	.word	37
	.word	32
	.type	aCount, %object
	.size	aCount, 128
aCount:
	.word	0
	.word	1
	.word	1
	.word	2
	.word	1
	.word	2
	.word	2
	.word	3
	.word	1
	.word	2
	.word	2
	.word	3
	.word	2
	.word	3
	.word	3
	.word	4
	.word	1
	.word	2
	.word	2
	.word	3
	.word	2
	.word	3
	.word	3
	.word	4
	.word	2
	.word	3
	.word	3
	.word	4
	.word	3
	.word	4
	.word	4
	.word	5
	.type	a2On4Off, %object
	.size	a2On4Off, 60
a2On4Off:
	.word	3
	.word	5
	.word	6
	.word	9
	.word	10
	.word	12
	.word	17
	.word	18
	.word	20
	.word	24
	.word	33
	.word	34
	.word	36
	.word	40
	.word	48
.LC11:
	.word	1
	.word	2
	.word	2
	.word	2
	.word	0
	.word	1
	.word	0
	.word	1
.LC12:
	.word	0
	.word	1
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	7
	.word	8
	.word	6
	.word	7
	.word	8
	.word	9
	.word	10
	.word	11
	.word	12
	.word	13
	.word	14
	.word	15
	.word	16
	.word	17
	.word	18
	.word	19
	.word	20
	.word	21
	.word	22
	.word	23
	.word	24
	.word	25
	.word	27
	.word	29
	.word	31
	.type	FldPTypeTab, %object
	.size	FldPTypeTab, 64
FldPTypeTab:
	.word	0
	.word	0
	.word	0
	.word	1
	.word	1
	.word	0
	.word	1
	.word	1
	.word	2
	.word	2
	.word	2
	.word	4
	.word	4
	.word	2
	.word	4
	.word	4
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC13:
	.ascii	"-1 == VCTRL_GetChanIDByCtx() Err! \012\000"
.LC14:
	.ascii	"VC1 INIT!!!\012\000"
	.space	3
.LC15:
	.ascii	"picture width out of range\000"
	.space	1
.LC16:
	.ascii	"%s: %s\012\000"
.LC17:
	.ascii	"picture height out of range\000"
.LC18:
	.ascii	"Vc1SMPSeqHdr Err, BS is wrong\000"
	.space	2
.LC19:
	.ascii	"Vc1SMPSeqHdr Err, BS is wrong\012\000"
	.space	1
.LC20:
	.ascii	"image size abnormal(%dx%d)\012\000"
.LC21:
	.ascii	"vc1 actual frame size(%dx%d) exeed max config(%dx%d"
	.ascii	")\012\000"
	.space	2
.LC22:
	.ascii	"partition fs memory fail!\012\000"
	.space	1
.LC23:
	.ascii	"ERROR: FSP_ConfigInstance fail!\012\000"
	.space	3
.LC24:
	.ascii	"line: %d, pImage is NULL!\012\000"
	.space	1
.LC25:
	.ascii	"get frame store fail!\012\000"
	.space	1
.LC26:
	.ascii	"VC1_Vfmw_GetImageBuffer get imgbuf err, clear all r"
	.ascii	"ef!\012\000"
.LC27:
	.ascii	"VC1_Vfmw_GetImageBuffer get_flag!=1, FSP_ClearLogic"
	.ascii	"Fs.\012\000"
.LC28:
	.ascii	"VC1_Vfmw_GetStreamInfo VC1_ArrangeVahbMem err!\012\000"
.LC29:
	.ascii	"VC1_Vfmw_GetStreamInfo VC1_Vfmw_GetImageBuffer err!"
	.ascii	"\012\000"
	.space	3
.LC30:
	.ascii	"dec_pts: %lld Usertag = %lld\012\000"
	.space	2
.LC31:
	.ascii	"---------- unref %d\012\000"
	.space	3
.LC32:
	.ascii	"VC1_Vfmw_GetStreamInfo B pic pCodecInf->RefNum < 2 "
	.ascii	"err!\012\000"
	.space	3
.LC33:
	.ascii	"line: %d (pCur,pFwd,pBwd)(%p,%p,%p)\012\000"
	.space	3
.LC34:
	.ascii	"VC1_Vfmw_GetStreamInfo imgbuf = NULL err!\012\000"
	.space	1
.LC35:
	.ascii	"CurFsID(fwd%d,%d,bwd%d) abnormal!(%p,%p,%p)\012\000"
	.space	3
.LC36:
	.ascii	"VC1_Vfmw_GetStreamInfo VC1_Vfmw_BuildRefList err!\012"
	.ascii	"\000"
	.space	1
.LC37:
	.ascii	"VC1_Vfmw_GetStreamInfo error! Release all packets!\012"
	.ascii	"\000"
.LC38:
	.ascii	"SLICE_ADDR = %d,SlcEndMbn = %d, MbHeight = %d\012\000"
	.space	1
.LC39:
	.ascii	"SLICE_ADDR = %d,SlcEndMbn = %d, totalMbMin1 = %d\012"
	.ascii	"\000"
	.space	2
.LC40:
	.ascii	"VC1_RecordSlcStream stream len <= 0\012\000"
	.space	3
.LC41:
	.ascii	"Check Pos 2: %d\012\000"
	.space	3
.LC42:
	.ascii	"Check Pos 3: %d\012\000"
	.space	3
.LC43:
	.ascii	"\012======PicNum  :%6d=========\012\000"
	.space	2
.LC44:
	.ascii	"INTERPFRM  :%#x\012\000"
	.space	3
.LC45:
	.ascii	"VC1_Vfmw_ParseMPBPicHdr err!\012\000"
	.space	2
.LC46:
	.ascii	"VC1_Vfmw_ParseSMPIPicHdr err!\012\000"
	.space	1
.LC47:
	.ascii	"After VC1_Vfmw_ParseSMPPicHdr BS Len <= 0 err!\012\000"
.LC48:
	.ascii	"pImg is null, pCurImg %p pBwdImg %p pFwdImg %p\012\000"
.LC49:
	.ascii	"line: %d, pToQueImg is Null!\012\000"
	.space	2
.LC50:
	.ascii	"insert buf %d ref %d\012\000"
	.space	2
.LC51:
	.ascii	"err(%d) > out_thr(%d)\012\000"
	.space	1
.LC52:
	.ascii	"----------------- VC1 Imode -> %d -----------------"
	.ascii	"-\012\000"
	.space	2
.LC53:
	.ascii	"NOTE: Drop non-I\012\000"
	.space	2
.LC54:
	.ascii	"NOTE: Drop B\012\000"
	.space	2
.LC55:
	.ascii	" pCodecInf->SlcNum = %d >= 256 \012\000"
	.space	3
.LC56:
	.ascii	"line %d, Code = VC1_SCSLC failed!\012\000"
	.space	1
.LC57:
	.ascii	"line %d, Code = VC1_SCFRM failed!\012\000"
	.space	1
.LC58:
	.ascii	"bitsream para error -----\012\000"
	.space	1
.LC59:
	.ascii	"line %d, pPacket->StreamPack[1].IsLastSeg = %d\012\000"
.LC60:
	.ascii	"ERROR: frm %d, Invalid packet pointer!\012\000"
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
