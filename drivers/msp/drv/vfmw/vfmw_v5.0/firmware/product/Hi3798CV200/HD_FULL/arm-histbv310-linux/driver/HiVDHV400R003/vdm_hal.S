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
	.file	"vdm_hal.c"

	.text
	.align	2
	.global	VDMHAL_V400R003_GetHalMemSize
	.type	VDMHAL_V400R003_GetHalMemSize, %function
VDMHAL_V400R003_GetHalMemSize:
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
	mov	r0, #6291456
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VDMHAL_V400R003_GetHalMemSize, .-VDMHAL_V400R003_GetHalMemSize
	.align	2
	.global	VDMHAL_V400R003_OpenHAL
	.type	VDMHAL_V400R003_OpenHAL, %function
VDMHAL_V400R003_OpenHAL:
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
	subs	r3, r0, #0
	beq	.L18
	ldr	r6, [r3]
	ldr	r5, [r3, #4]
	cmp	r6, #0
	ldr	r7, [r3, #8]
	beq	.L19
	cmp	r5, #6291456
	blt	.L20
	cmp	r7, #0
	bgt	.L21
	bne	.L16
	ldr	r9, .L23
	mov	r2, #140
	ldr	r8, .L23+4
	mov	r1, r7
	ldr	r4, .L23+8
	ldr	r3, [r9, #48]
	mov	r0, r8
	blx	r3
	ldr	r3, [r9, #48]
	mov	r1, r7
	mov	r2, #4
	mov	r0, r4
	str	r2, [r8]
	movw	r2, #1224
	blx	r3
	mov	r0, #0
	movt	r0, 63683
	bl	MEM_Phy2Vir
	ldr	r1, .L23+12
	mov	r3, r0
	mov	r2, r0
	str	r3, [r4]
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, #53248
	movt	r0, 63683
	bl	MEM_Phy2Vir
	ldr	r1, .L23+16
	mov	r3, r0
	mov	r2, r0
	str	r3, [r4, #8]
	mov	r0, #22
	bl	dprint_vfmw
	add	r0, r6, #1020
	add	r0, r0, #3
	add	r3, r5, r6
	bic	r0, r0, #1020
	add	r1, r4, #876
	bic	r0, r0, #3
	mov	r2, #1024
	rsb	r3, r0, r3
	str	r3, [r4, #20]
	add	r3, r4, #36
	str	r2, [r4, #24]
	mov	r2, r0
	str	r0, [r4, #16]
.L10:
	str	r2, [r3, #4]!
	cmp	r3, r1
	add	r2, r2, #1280
	bne	.L10
	mov	r3, #210
	str	r3, [r4, #1064]
	add	r3, r0, #274432
	add	r0, r0, #266240
	add	r0, r0, #3072
	str	r3, [r4, #1108]
	add	r2, r0, #38656
	str	r0, [r4, #1088]
	add	r2, r2, #255
	mov	r0, #0
	bic	r2, r2, #32512
	str	r0, [r4, #1168]
	bic	r2, r2, #255
	str	r0, [r4, #1140]
	add	r1, r2, #4390912
	add	r10, r2, #1769472
	add	ip, r10, #5248
	add	r3, r1, #37888
	cmp	ip, r3
	rsbcs	r6, r6, ip
	rsbcc	r6, r6, r3
	add	lr, r2, #4325376
	cmp	r5, r6
	add	r3, r2, #589824
	add	r9, r2, #1081344
	add	r8, r2, #2129920
	add	r7, r2, #3178496
	str	r6, [fp, #-48]
	str	ip, [r4, #1136]
	add	r6, r2, #4194304
	add	ip, r2, #1179648
	add	r10, r10, #2048
	add	r8, r8, #12288
	add	ip, ip, #2048
	str	r2, [r4, #1156]
	add	r9, r9, #12288
	str	r2, [r4, #1092]
	add	r7, r7, #12288
	str	r2, [r4, #1096]
	add	r6, r6, #45056
	str	r2, [r4, #1100]
	add	r2, r2, #45056
	str	r10, [r4, #1128]
	str	r10, [r4, #1132]
	add	r10, r1, #1024
	str	r8, [r4, #1152]
	add	r1, r1, #33792
	add	r8, r3, #2048
	str	r1, [r4, #1184]
	str	r10, [r4, #1204]
	add	r1, lr, #47104
	str	r10, [r4, #1188]
	add	lr, lr, #50176
	str	r9, [r4, #1148]
	str	r7, [r4, #1160]
	str	r6, [r4, #1192]
	str	r1, [r4, #1176]
	str	lr, [r4, #1180]
	str	r3, [r4, #1104]
	str	r3, [r4, #1112]
	str	r8, [r4, #1116]
	str	ip, [r4, #1120]
	str	ip, [r4, #1124]
	str	r2, [r4, #1144]
	bcc	.L11
	ldr	r0, .L23+8
	bl	H264HAL_V400R003_InitHal
	mov	r4, r0
	ldr	r0, .L23+8
	bl	HEVCHAL_V400R003_InitHal
	cmp	r0, #0
	mvnne	r4, #0
	beq	.L22
.L12:
	ldr	r0, .L23+8
	bl	H264HAL_V400R003_InitHal
	cmp	r0, #0
	moveq	r0, r4
	mvnne	r0, #0
.L4:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L22:
	adds	r4, r4, #0
	movne	r4, #1
	rsb	r4, r4, #0
	b	.L12
.L21:
	ldr	r1, .L23+20
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4
.L16:
	ldr	r1, .L23+24
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4
.L11:
	mov	r3, r5
	ldr	r2, [fp, #-48]
	ldr	r1, .L23+28
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4
.L19:
	mov	r0, r6
	ldr	r3, .L23+32
	ldr	r2, .L23+36
	ldr	r1, .L23+40
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4
.L20:
	ldr	r3, .L23+44
	mov	r0, #0
	ldr	r2, .L23+36
	ldr	r1, .L23+40
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4
.L18:
	ldr	r3, .L23+48
	ldr	r2, .L23+36
	ldr	r1, .L23+40
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4
.L24:
	.align	2
.L23:
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_VdmExtParam
	.word	g_HwMem
	.word	.LC5
	.word	.LC6
	.word	.LC4
	.word	.LC7
	.word	.LC8
	.word	.LC2
	.word	.LANCHOR0
	.word	.LC1
	.word	.LC3
	.word	.LC0
	.fnend
	.size	VDMHAL_V400R003_OpenHAL, .-VDMHAL_V400R003_OpenHAL
	.align	2
	.global	VDMHAL_V400R003_CloseHAL
	.type	VDMHAL_V400R003_CloseHAL, %function
VDMHAL_V400R003_CloseHAL:
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
	.size	VDMHAL_V400R003_CloseHAL, .-VDMHAL_V400R003_CloseHAL
	.align	2
	.global	VDMHAL_V400R003_CalcFsSize
	.type	VDMHAL_V400R003_CalcFsSize, %function
VDMHAL_V400R003_CalcFsSize:
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
	sub	lr, r1, #32
	movw	ip, #8160
	cmp	lr, ip
	mov	r8, r0
	mov	r5, r3
	bhi	.L27
	sub	r3, r2, #32
	mov	r10, r2
	cmp	r3, ip
	bhi	.L27
	ldr	r0, .L61
	add	r3, r1, #15
	add	ip, r2, #15
	mov	r3, r3, asr #4
	mov	ip, ip, asr #4
	ldrb	r4, [r0]
	cmp	r3, #45
	cmple	ip, #36
	mov	r0, r3, asl #4
	movle	lr, #64
	movgt	lr, #32
	cmp	r4, #1
	ldr	r4, [fp, #4]
	moveq	lr, #64
	cmp	r4, #16
	beq	.L32
	cmp	r4, #17
	beq	.L54
	mul	r3, r3, lr
	ldr	r9, .L61+4
	add	r0, r0, #255
	add	r10, r2, #31
	bic	r0, r0, #255
	str	r0, [fp, #-52]
	ldr	r0, [r9, r8, asl #2]
	bic	r10, r10, #31
	mov	lr, #0
	str	lr, [fp, #-72]
	mul	r3, r3, ip
	str	lr, [fp, #-68]
	add	r3, r3, #143
	bic	r3, r3, #127
	str	r3, [fp, #-48]
	mov	r3, r3, asr #1
	str	r3, [fp, #-64]
.L44:
	ldr	r3, [r0, #1188]
	cmp	r3, #1
	movne	r3, #0
	strne	r3, [fp, #-60]
	movne	r7, r3
	beq	.L55
.L35:
	ldr	lr, [fp, #4]
	ldr	r4, [fp, #4]
	cmp	lr, #3
	cmpne	lr, #0
	sub	r4, r4, #16
	movne	lr, #1
	moveq	lr, #0
	cmp	r4, #1
	movls	lr, #0
	andhi	lr, lr, #1
	cmp	lr, #0
	beq	.L56
	cmp	r5, #1
	mov	r6, #0
	mov	r2, #1024
	mov	r4, r6
	str	r2, [fp, #-56]
	beq	.L57
.L37:
	ldr	r2, [fp, #-52]
	add	ip, r7, r7, lsl #1
	ldr	r1, [fp, #-68]
	mul	r10, r2, r10
	ldr	r2, [fp, #-72]
	mul	r5, r2, r1
	add	r1, r10, r10, lsl #1
	mov	r1, r1, lsr #1
	add	r5, r5, r5, lsl #1
	add	r2, r1, r5, lsr #1
	add	r5, r2, ip, lsr #1
	add	r2, r0, #233472
	ldr	r1, [r2, #384]
	cmp	r1, #0
	beq	.L58
.L39:
	ldr	r1, [fp, #4]
	str	r3, [r2, #3640]
	cmp	r1, #17
	ldr	r3, [fp, #-64]
	ldr	r1, [fp, #-60]
	str	r4, [r2, #3624]
	str	r6, [r2, #3628]
	str	r1, [r2, #3636]
	str	r3, [r2, #3836]
	beq	.L40
	ldr	r1, [fp, #-52]
	ldr	r3, [r2, #392]
	mov	r1, r1, asl #4
	cmp	r3, #20
	str	r1, [r2, #2720]
	add	r1, r10, r7
	str	r1, [r2, #3660]
	movge	r3, #20
	ldr	r1, [fp, #4]
	str	r3, [r2, #3840]
	cmp	r1, #16
	beq	.L59
.L42:
	ldr	r2, [r9, r8, asl #2]
	mov	r0, #1024
	ldr	r3, [fp, #-56]
	ldr	ip, [fp, #-48]
	add	r5, r5, r3
	add	r3, r2, #233472
	add	r1, r5, ip
	str	r5, [r3, #3864]
	str	ip, [r3, #3868]
	str	r0, [r3, #3872]
	ldrsb	r3, [r2, #160]
	cmp	r3, #1
	ldr	r3, [fp, #8]
	addeq	r1, r1, r0
	cmp	r3, #0
	beq	.L49
	str	r5, [r3, #4]
	mov	r0, #0
	ldr	r3, [r9, r8, asl #2]
	mov	r2, #1024
	ldr	ip, [fp, #8]
	add	r3, r3, #233472
	ldr	lr, [fp, #-48]
	ldr	r3, [r3, #392]
	str	lr, [ip, #12]
	str	r3, [ip, #8]
	ldr	r3, [r9, r8, asl #2]
	add	r3, r3, #233472
	ldr	r3, [r3, #3840]
	str	r1, [ip]
	str	r2, [ip, #20]
	str	r3, [ip, #16]
.L50:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L56:
	add	r4, r1, #255
	cmp	r4, #0
	add	r1, r4, #255
	movlt	r4, r1
	adds	r6, r2, #63
	addmi	r6, r2, #126
	mov	r4, r4, asr #8
	bic	r6, r6, #63
	add	r2, r6, #7
	cmp	r6, #0
	mov	r4, r4, asl #6
	movlt	r6, r2
	cmp	r5, #1
	mov	r6, r6, asr #3
	mul	r6, r4, r6
	add	r2, r6, #1024
	str	r2, [fp, #-56]
	bne	.L37
.L57:
	ldr	r2, [fp, #-52]
	mov	r5, ip, asl #5
	add	r5, r5, ip, lsl #4
	mul	r10, r2, r10
	mul	r5, r2, r5
	add	r2, r0, #233472
	ldr	r1, [r2, #384]
	cmp	r1, #0
	bne	.L39
.L58:
	ldr	ip, .L61+8
	add	r0, r0, #235520
	movw	r2, #1156
	add	r0, r0, #672
	str	r3, [fp, #-76]
	ldr	ip, [ip, #48]
	blx	ip
	ldr	r0, [r9, r8, asl #2]
	ldr	r3, [fp, #-76]
	add	r2, r0, #233472
	b	.L39
.L32:
	ldr	r9, .L61+4
	add	r3, r1, #255
	mul	lr, r0, ip
	bic	r3, r3, #255
	ldr	r0, [r9, r8, asl #2]
	str	r3, [fp, #-52]
	add	lr, lr, #143
	ldr	r3, [r0, #1476]
	bic	lr, lr, #127
	str	lr, [fp, #-48]
	cmp	r3, #8
	ble	.L60
	ldr	r3, [fp, #-52]
	add	r7, r2, #31
	mov	r3, r3, lsr #2
	str	r3, [fp, #-68]
	bic	r3, r7, #31
	str	r3, [fp, #-72]
	ldr	r3, [fp, #-48]
	mov	r3, r3, asr #1
	str	r3, [fp, #-64]
	b	.L44
.L55:
	add	r3, r1, #508
	add	lr, r1, #1020
	add	r3, r3, #3
	add	lr, lr, #2
	cmp	r3, #0
	movlt	r3, lr
	bic	r3, r3, #508
	bic	r3, r3, #3
	cmp	r3, #0
	add	lr, r3, #63
	movlt	r3, lr
	adds	r7, r2, #63
	addmi	r7, r2, #126
	mov	r3, r3, asr #6
	mov	r7, r7, asr #6
	mov	r3, r3, asl #1
	str	r3, [fp, #-60]
	mov	r7, r7, asl #5
	mul	r7, r3, r7
	mov	r3, r7
	b	.L35
.L59:
	ldr	r3, [r0, #1476]
	cmp	r3, #8
	ble	.L42
	ldr	r0, [fp, #-68]
	add	r3, r7, r7, lsl #1
	ldr	r1, [fp, #-72]
	add	r10, r10, r10, lsl #1
	mov	r3, r3, lsr #1
	add	r10, r3, r10, lsr #1
	str	r10, [r2, #3652]
	mul	r1, r0, r1
	mov	r0, r0, asl #5
	str	r0, [r2, #3644]
	mov	r0, #31
	add	r7, r1, r7, lsr #1
	ldr	r1, .L61+12
	str	r7, [r2, #3656]
	bl	dprint_vfmw
	b	.L42
.L40:
	ldr	r3, [fp, #-52]
	add	r7, r10, r7
	str	r7, [r2, #3660]
	mov	r3, r3, asl #4
	str	r3, [r2, #2720]
	mov	r3, #1
	str	r3, [r2, #3840]
	b	.L42
.L54:
	mov	r0, #64
	ldr	r9, .L61+4
	mov	lr, r0
	add	r3, r1, #255
	mov	r0, #128
	bic	r3, r3, #255
	mov	r4, r0
	str	r3, [fp, #-52]
	mov	r3, lr
	mov	r0, #0
	movt	r3, 18
	add	r10, r2, #63
	str	r3, [fp, #-64]
	mov	r3, r4
	mov	r6, r0
	str	r0, [fp, #-72]
	movt	r3, 36
	ldr	r0, [r9, r8, asl #2]
	bic	r10, r10, #63
	str	r3, [fp, #-48]
	str	r6, [fp, #-68]
	b	.L44
.L60:
	mov	r3, #0
	mov	lr, lr, asr #1
	str	r3, [fp, #-72]
	str	lr, [fp, #-64]
	str	r3, [fp, #-68]
	b	.L44
.L49:
	ldr	r0, [fp, #8]
	b	.L50
.L27:
	ldr	r3, .L61+16
	mov	r0, #0
	ldr	r2, .L61+20
	ldr	r1, .L61+24
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L50
.L62:
	.align	2
.L61:
	.word	g_not_direct_8x8_inference_flag
	.word	s_pstVfmwChan
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC10
	.word	.LC9
	.word	.LANCHOR0+24
	.word	.LC1
	.fnend
	.size	VDMHAL_V400R003_CalcFsSize, .-VDMHAL_V400R003_CalcFsSize
	.align	2
	.global	VDMHAL_V400R003_GetRpuSize
	.type	VDMHAL_V400R003_GetRpuSize, %function
VDMHAL_V400R003_GetRpuSize:
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
	mov	r0, #1024
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VDMHAL_V400R003_GetRpuSize, .-VDMHAL_V400R003_GetRpuSize
	.global	__aeabi_idiv
	.align	2
	.global	VDMHAL_V400R003_ArrangeMem
	.type	VDMHAL_V400R003_ArrangeMem, %function
VDMHAL_V400R003_ArrangeMem:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #108
	sub	sp, sp, #108
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r4, r2
	ldr	r2, [fp, #16]
	mov	r8, #0
	str	r0, [fp, #-108]
	cmn	r2, #2
	str	r1, [fp, #-116]
	mov	r5, r3
	ldr	r7, [fp, #4]
	str	r8, [fp, #-100]
	str	r8, [fp, #-96]
	str	r8, [fp, #-92]
	str	r8, [fp, #-88]
	str	r8, [fp, #-84]
	str	r8, [fp, #-80]
	ldr	r9, [fp, #20]
	beq	.L134
	cmp	r2, r8
	blt	.L135
	mov	r0, r2
	ldr	r6, .L196
	bl	VCTRL_GetVidStd
	ldr	r3, [fp, #16]
	ldr	r3, [r6, r3, asl #2]
	ldr	r2, [r3, #1424]
	cmp	r2, #1
	str	r0, [fp, #-104]
	beq	.L180
.L66:
	ldr	r3, [fp, #-108]
	cmp	r3, #0
	subne	r2, r4, #32
	movwne	r3, #8160
	beq	.L181
	cmp	r2, r3
	bhi	.L94
	sub	r2, r5, #32
	cmp	r2, r3
	bhi	.L94
	cmp	r9, #0
	beq	.L182
	ldr	r3, .L196+4
	cmp	r7, #20
	movw	r2, #1144
	mov	r1, #0
	mov	r0, r9
	movlt	r8, r7
	ldr	r3, [r3, #48]
	movge	r8, #20
	blx	r3
	ldr	r1, .L196+8
	add	r2, r4, #15
	add	r3, r5, #15
	mov	r2, r2, asr #4
	mov	r3, r3, asr #4
	cmp	r2, #45
	cmple	r3, #36
	ldrb	ip, [r1]
	mov	r1, r2, asl #4
	movle	r0, #64
	movgt	r0, #32
	cmp	ip, #1
	ldr	ip, [fp, #-104]
	moveq	r0, #64
	cmp	ip, #16
	beq	.L183
	ldr	ip, [fp, #-104]
	cmp	ip, #17
	beq	.L102
	mul	r7, r2, r0
	ldr	r0, [fp, #-116]
	mul	r7, r7, r3
	add	r7, r7, #127
	bic	r7, r7, #127
	mul	r2, r7, r8
	cmp	r2, r0
	str	r2, [fp, #-120]
	bge	.L100
	ldr	r0, [fp, #-108]
	add	r10, r4, #255
	add	r2, r5, #31
	add	r1, r1, #255
	add	r6, r0, #1020
	mov	ip, #0
	add	r6, r6, #3
	bic	r1, r1, #255
	bic	r6, r6, #1020
	str	r1, [fp, #-112]
	bic	r6, r6, #3
	str	ip, [fp, #-132]
	rsb	r1, r0, r6
	str	r8, [r9, #1120]
	str	r1, [fp, #-124]
	add	r1, r5, #63
	str	ip, [fp, #-128]
	bic	r5, r2, #31
	mov	r2, r7, asr #1
	str	r2, [r9, #1116]
.L104:
	add	r2, r4, #508
	add	r4, r4, #1020
	add	r2, r2, #3
	add	r4, r4, #2
	cmp	r2, #0
	add	r0, r1, #63
	movge	r4, r2
	cmp	r1, #0
	bic	r4, r4, #508
	add	r2, r10, #255
	bic	r4, r4, #3
	movlt	r1, r0
	add	r0, r4, #63
	cmp	r4, #0
	mov	r1, r1, asr #6
	movlt	r4, r0
	cmp	r10, #0
	mov	r8, r1, asl #6
	mov	r4, r4, asr #6
	movge	r2, r10
	add	r0, r8, #7
	cmp	r8, #0
	mov	r2, r2, asr #8
	mov	r10, r4, asl #6
	mov	r4, r4, asl #1
	movlt	r8, r0
	mov	r2, r2, asl #6
	mov	r8, r8, asr #3
	ldr	r0, [fp, #12]
	mul	r10, r1, r10
	str	r2, [r9, #904]
	mul	r8, r2, r8
	ldr	r2, [fp, #-112]
	cmp	r0, #1
	str	r4, [r9, #916]
	mov	r2, r2, asl #4
	str	r10, [r9, #920]
	str	r2, [r9]
	str	r8, [r9, #908]
	beq	.L184
	ldr	r2, [fp, #-128]
	add	r4, r10, r10, lsl #1
	ldr	r3, [fp, #-132]
	mul	r3, r3, r2
	ldr	r2, [fp, #-112]
	mul	r2, r5, r2
	add	r3, r3, r3, lsl #1
	add	r3, r3, r3, lsr #31
	add	r2, r2, r2, lsl #1
	mov	r3, r3, asr #1
	add	r3, r3, r2, asr #1
	add	r4, r3, r4, lsr #1
.L107:
	ldr	r3, [fp, #16]
	cmp	r3, #0
	blt	.L108
	mov	r0, r3
	bl	VCTRL_GetChanWidth
	str	r0, [fp, #-136]
	ldr	r0, [fp, #16]
	bl	VCTRL_GetChanHeight
	ldr	r1, [fp, #-136]
	cmn	r0, #1
	cmnne	r1, #1
	beq	.L185
	ldr	r3, [fp, #12]
	add	r1, r1, #15
	bic	r1, r1, #15
	cmp	r3, #1
	add	r3, r0, #15
	add	r0, r1, #255
	bic	r3, r3, #15
	bic	r0, r0, #255
	beq	.L186
	add	r2, r1, #508
	adds	ip, r3, #63
	add	r2, r2, #3
	add	r1, r1, #1020
	addmi	ip, r3, #126
	add	r1, r1, #2
	cmp	r2, #0
	mov	ip, ip, asr #6
	movlt	r2, r1
	bic	r2, r2, #508
	bic	r2, r2, #3
	add	r3, r2, #63
	cmp	r2, #0
	mul	r0, ip, r0
	movlt	r2, r3
	mov	r2, r2, asr #6
	mov	r3, ip, asl #7
	sub	ip, r3, ip, asl #5
	mov	r2, r2, asl #1
	mul	r2, r2, ip
	mov	r1, r0, asl #8
	sub	r0, r1, r0, asl #6
	mov	r0, r0, asr #1
	add	r2, r0, r2, lsr #1
.L111:
	cmp	r4, r2
	ldrgt	r3, .L196+12
	bgt	.L178
	ldr	r3, [fp, #-112]
	mul	r5, r5, r3
	ldr	r3, [fp, #-104]
	cmp	r3, #16
	add	r3, r10, r5
	str	r3, [r9, #940]
	bne	.L139
	ldr	r3, .L196
	ldr	r2, [fp, #16]
	ldr	r0, [r3, r2, asl #2]
	add	r0, r0, #237568
	add	r0, r0, #376
	bl	IsMain10Profile
	cmp	r0, #0
	bne	.L187
.L139:
	mov	r10, #1
	b	.L113
.L135:
	mov	r3, #21
	str	r3, [fp, #-104]
	b	.L66
.L108:
	ldr	r3, [fp, #-112]
	mla	r5, r5, r3, r10
	mov	r10, #0
	str	r5, [r9, #940]
.L113:
	ldr	r3, [fp, #8]
	cmp	r3, #0
	streq	r3, [r9, #952]
	streq	r3, [r9, #912]
	bne	.L188
.L115:
	ldr	r3, .L196+16
.L178:
	mov	r0, #0
	ldr	r2, .L196+20
	ldr	r1, .L196+24
	bl	dprint_vfmw
	mvn	r3, #0
	b	.L173
.L188:
	ldr	r2, [fp, #-104]
	ldr	r1, [fp, #-120]
	cmp	r2, #3
	cmpne	r2, #0
	mov	r3, r2
	sub	r2, r2, #16
	movne	r3, #1
	moveq	r3, #0
	cmp	r2, #1
	movls	r3, #0
	andhi	r3, r3, #1
	ldr	r2, [fp, #-116]
	cmp	r3, #0
	ldr	r3, [fp, #-124]
	rsb	r0, r1, r2
	rsb	r0, r3, r0
	ldr	r3, [fp, #8]
	beq	.L116
	cmp	r3, #32
	mov	r1, r4
	movlt	r5, r3
	movge	r5, #32
	bl	__aeabi_idiv
	mov	r3, #0
	str	r3, [r9, #912]
	cmp	r5, r0
	movlt	r0, r5
	str	r0, [r9, #952]
.L117:
	cmp	r0, #0
	beq	.L115
	ldrgt	r1, [r9, #1124]
	movgt	r2, r9
	movgt	r3, #0
	ble	.L122
.L121:
	add	r3, r3, #1
	str	r6, [r2, #8]
	cmp	r3, r0
	add	r6, r6, r4
	add	r2, r2, #12
	bne	.L121
	add	r3, r0, r1
	str	r3, [r9, #1124]
.L122:
	ldr	ip, [r9, #912]
	ldr	r3, [fp, #-124]
	cmp	ip, #0
	mla	r4, r0, r4, r3
	beq	.L123
	ldr	r3, [fp, #-108]
	add	r1, r9, #772
	add	r2, r4, r3
	mov	r3, #0
.L124:
	add	r3, r3, #1
	str	r2, [r1, #4]!
	cmp	r3, ip
	add	r2, r2, r8
	bne	.L124
	mul	ip, r8, ip
.L123:
	ldr	lr, [r9, #1120]
	ldr	r3, [fp, #-108]
	add	r4, ip, r4
	cmp	lr, #0
	add	ip, r4, r3
	ble	.L129
	ldr	r5, [r9, #1128]
	mov	r1, r9
	mov	r2, ip
	mov	r3, #0
.L128:
	add	r3, r3, #1
	str	r2, [r1, #956]
	cmp	r3, lr
	add	r2, r2, r7
	add	r1, r1, #8
	bne	.L128
	add	r3, lr, r5
	str	r3, [r9, #1128]
.L129:
	mla	r7, r7, lr, r4
	cmp	r10, #0
	str	r7, [r9, #4]
	beq	.L127
	ldr	r3, .L196
	ldr	r2, [fp, #16]
	ldr	r3, [r3, r2, asl #2]
	cmp	r3, #0
	beq	.L127
	cmp	r0, #0
	ble	.L127
	add	r3, r7, ip
	mov	r1, r9
	mov	r2, #0
.L130:
	add	r2, r2, #1
	str	r3, [r1, #392]
	cmp	r2, r0
	add	r3, r3, #1024
	add	r1, r1, #12
	bne	.L130
.L127:
	mov	r3, #0
	add	r7, r7, r0, lsl #10
	str	r7, [r9, #4]
.L173:
	mov	r0, r3
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L134:
	mov	r3, #16
	str	r3, [fp, #-104]
	b	.L66
.L116:
	cmp	r3, #32
	add	r1, r4, r8
	movlt	r5, r3
	movge	r5, #32
	bl	__aeabi_idiv
	cmp	r5, r0
	movlt	r0, r5
	str	r0, [r9, #952]
	str	r0, [r9, #912]
	b	.L117
.L183:
	mul	r7, r1, r3
	ldr	r1, [fp, #-116]
	add	r7, r7, #127
	bic	r7, r7, #127
	mul	r2, r7, r8
	cmp	r2, r1
	str	r2, [fp, #-120]
	bge	.L100
	ldr	r2, [fp, #-108]
	add	r10, r4, #255
	ldr	r1, [fp, #16]
	add	r6, r2, #1020
	str	r8, [r9, #1120]
	add	r6, r6, #3
	cmp	r1, #0
	bic	r6, r6, #1020
	bic	r1, r10, #255
	bic	r6, r6, #3
	str	r1, [fp, #-112]
	rsb	r2, r2, r6
	str	r2, [fp, #-124]
	mov	r2, r7, asr #1
	str	r2, [r9, #1116]
	blt	.L176
	str	r3, [fp, #-128]
	ldr	r2, .L196
	ldr	r3, [fp, #16]
	ldr	r0, [r2, r3, asl #2]
	add	r0, r0, #237568
	add	r0, r0, #376
	bl	IsMain10Profile
	ldr	r3, [fp, #-128]
	cmp	r0, #0
	beq	.L176
	ldr	r0, [fp, #-112]
	add	r1, r5, #31
	bic	r1, r1, #31
	str	r1, [fp, #-132]
	cmp	r0, #0
	add	r2, r0, #3
	add	r1, r5, #63
	movge	r2, r0
	mov	r2, r2, asr #2
	str	r2, [fp, #-128]
	b	.L104
.L180:
	cmp	r0, #20
	bhi	.L189
	ldr	r0, [fp, #-104]
	add	r1, r3, #233472
	sub	ip, fp, #100
	ldr	r3, [fp, #12]
	ldr	r8, [r1, #388]
	mov	r2, r5
	str	r0, [sp]
	mov	r1, r4
	ldr	r0, [fp, #16]
	str	ip, [sp, #4]
	bl	VDMHAL_V400R003_CalcFsSize
	cmp	r0, #0
	bne	.L190
	ldr	r3, [fp, #16]
	ldr	r7, [fp, #-100]
	ldr	r3, [r6, r3, asl #2]
	cmp	r8, r7
	add	r10, r3, #233472
	ldr	r8, [r10, #392]
	ldr	r2, [r10, #408]
	bne	.L71
	cmp	r2, #1
	beq	.L71
	ldr	r1, [r10, #384]
	cmp	r1, #1
	beq	.L71
	cmp	r9, #0
	beq	.L191
	add	r2, r3, #235520
	cmp	r8, #0
	add	r2, r2, #672
	str	r2, [fp, #-112]
	ldr	r2, [r10, #3864]
	str	r2, [fp, #-104]
	movne	r2, r3
	beq	.L192
.L85:
	add	r2, r2, #233472
	ldr	r2, [r2, #396]
	cmp	r2, #30
	bgt	.L193
.L86:
	str	r3, [fp, #-108]
	mov	r0, #8
	ldr	r3, .L196+4
	str	r2, [r10, #3672]
	ldr	r2, [r3, #12]
	blx	r2
	ldr	r3, [fp, #16]
	ldr	r7, [r6, r3, asl #2]
	ldr	r3, [fp, #-108]
	add	r7, r7, #233472
	ldr	r2, [r7, #3900]
	cmp	r2, #0
	beq	.L91
	ldr	r0, [r10, #3840]
	add	r1, r7, #448
	ldr	r2, [r10, #3844]
	mov	ip, #0
	str	r9, [fp, #20]
	mov	r8, #1
	str	r0, [fp, #-108]
	add	r0, r2, #1
	add	r4, r2, #59136
	mov	lr, r0
	mov	r0, r2, asl #4
	sub	r0, r0, r2, asl #2
	add	r4, r4, #105
	add	r0, r0, #235520
	mov	r9, lr
	add	r0, r0, #680
	add	r4, r3, r4, lsl #2
	add	r0, r3, r0
.L90:
	ldr	r2, [r1]
	add	lr, r9, ip
	ldr	r5, [r1, #-20]
	add	ip, ip, #1
	add	r2, r2, #1020
	strb	r8, [r0, #8]
	add	r2, r2, #3
	add	r0, r0, #12
	str	r5, [r0, #-8]
	bic	r2, r2, #1020
	ldr	r5, [fp, #-104]
	bic	r2, r2, #3
	str	r2, [r0, #-12]
	add	r2, r2, r5
	str	r2, [r4, #4]!
	str	lr, [r10, #3844]
	ldr	r2, [r1, #-28]
	cmp	r2, #255
	beq	.L88
	ldr	lr, [r10, #3852]
	add	r5, lr, #1
	mov	r2, lr, asl #4
	sub	r2, r2, lr, asl #2
	ldr	lr, [r1, #16]
	add	r2, r10, r2
	str	lr, [r2, #3112]
	str	r5, [r10, #3852]
.L88:
	ldr	r2, [r10, #3848]
	add	r1, r1, #72
	ldr	lr, [fp, #-108]
	cmp	r2, lr
	add	lr, r2, #1
	add	r2, r3, r2, lsl #3
	ldrcc	r5, [r1, #-40]
	add	r2, r2, #233472
	strccb	r8, [r2, #3680]
	strcc	r5, [r2, #3676]
	strcc	lr, [r10, #3848]
	ldr	r2, [r7, #3900]
	cmp	ip, r2
	bcc	.L90
	ldr	r9, [fp, #20]
.L91:
	ldr	r3, .L196+4
	movw	r2, #1144
	ldr	r1, [fp, #-112]
	mov	r0, r9
	ldr	r3, [r3, #52]
	blx	r3
	ldr	r3, [fp, #16]
	ldr	r2, .L196+4
	mov	r1, #1
	mov	r0, #8
	ldr	r3, [r6, r3, asl #2]
	ldr	r2, [r2, #16]
	add	r3, r3, #233472
	str	r1, [r3, #3904]
	blx	r2
	mov	r3, #0
	b	.L173
.L184:
	mov	r4, r3, asl #4
	ldr	r3, [fp, #-112]
	mul	r4, r4, r3
	add	r4, r4, r4, lsl #1
	b	.L107
.L71:
	str	r2, [sp, #4]
	mov	r3, r7
	ldr	r1, .L196+28
	mov	r0, #31
	str	r8, [sp]
	ldr	r2, .L196+32
	bl	dprint_vfmw
	ldr	r3, [fp, #16]
	ldr	r1, [r6, r3, asl #2]
	add	r1, r1, #233472
	ldr	r9, [r1, #384]
	str	r7, [r1, #388]
	cmp	r9, #0
	beq	.L194
	ldr	r3, .L196+36
	ldr	r0, [fp, #-92]
	ldr	ip, [r3]
	str	r0, [r1, #396]
	cmp	ip, #0
	beq	.L83
	ldr	lr, [fp, #-84]
	mov	r3, #28
	ldr	r9, [fp, #-96]
	sub	r2, fp, #76
	ldr	r10, [fp, #-88]
	mov	r1, #122
	str	lr, [fp, #-68]
	ldr	lr, [fp, #-80]
	str	r0, [fp, #-76]
	str	r4, [fp, #-56]
	ldr	r0, [fp, #16]
	str	r5, [fp, #-52]
	str	r9, [fp, #-72]
	str	r10, [fp, #-64]
	str	lr, [fp, #-60]
	blx	ip
.L83:
	ldr	r3, [fp, #16]
	mov	r2, r7
	ldr	r1, .L196+40
	mov	r0, #31
	ldr	ip, [r6, r3, asl #2]
	mov	r3, r8
	add	ip, ip, #233472
	ldr	ip, [ip, #408]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, .L196+4
	ldr	r2, [fp, #16]
	ldr	r3, [r3]
	ldr	r4, [r6, r2, asl #2]
	blx	r3
	mov	r3, #2
	add	r4, r4, #233472
	str	r0, [r4, #3876]
	mov	r0, r3
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L176:
	mov	r2, #0
	add	r1, r5, #63
	str	r2, [fp, #-132]
	str	r2, [fp, #-128]
	b	.L104
.L102:
	mov	r2, r8, asl #21
	ldr	r1, [fp, #-116]
	add	r2, r2, r8, lsl #18
	str	r2, [fp, #-120]
	cmp	r2, r1
	bge	.L100
	ldr	r2, [fp, #-108]
	add	r1, r5, #63
	add	r10, r4, #255
	mov	r0, #0
	add	r6, r2, #1020
	str	r0, [fp, #-132]
	add	r6, r6, #3
	str	r8, [r9, #1120]
	bic	r6, r6, #1020
	bic	r5, r1, #63
	bic	r6, r6, #3
	str	r0, [fp, #-128]
	rsb	r2, r2, r6
	mov	r7, #2359296
	str	r2, [fp, #-124]
	bic	r2, r10, #255
	str	r2, [fp, #-112]
	mov	r2, #1179648
	str	r2, [r9, #1116]
	b	.L104
.L186:
	mul	r2, r3, r0
	add	r2, r2, r2, lsl #1
	b	.L111
.L187:
	ldr	r3, [fp, #-128]
	add	r5, r5, r5, lsl #1
	ldr	r2, [fp, #-132]
	add	r1, r10, r10, lsl #1
	mul	r0, r2, r3
	mov	r2, r3, asl #5
	mov	r3, r5, asr #1
	str	r2, [r9, #924]
	add	r3, r3, r1, lsr #1
	ldr	r1, .L196+44
	add	r0, r0, r10, lsr #1
	str	r3, [r9, #932]
	str	r0, [r9, #936]
	mov	r0, #0
	mov	r10, #1
	bl	dprint_vfmw
	b	.L113
.L189:
	ldr	r3, .L196+48
	mov	r0, r8
	ldr	r2, .L196+20
	ldr	r1, .L196+24
	bl	dprint_vfmw
	mvn	r3, #0
	b	.L173
.L194:
	add	r1, r1, #416
	mov	r0, r3
	bl	DelAllFrameMemRecord
	cmp	r0, #0
	bne	.L195
.L74:
	ldr	r3, [fp, #16]
	mov	r1, #255
	ldr	r2, [r6, r3, asl #2]
	mov	r3, #0
	add	r2, r2, #233472
	add	r2, r2, #416
.L75:
	str	r1, [r2, r3]
	add	r3, r3, #72
	cmp	r3, #2304
	bne	.L75
	ldr	r3, [fp, #16]
	ldr	r10, .L196
	ldr	r2, [r6, r3, asl #2]
	add	r1, r2, #237568
	ldr	r3, [r1, #328]
	cmp	r3, #0
	bne	.L76
	ldr	r3, .L196+36
	ldr	ip, [r3]
.L77:
	cmp	r4, #1920
	cmple	r5, #1088
	ldr	r0, [fp, #-92]
	bgt	.L80
	ldr	r3, [r2, #44]
	cmp	r3, #24
	addne	r0, r0, #4
	strne	r0, [fp, #-92]
.L80:
	ldr	r3, [r2, #1432]
	cmp	ip, #0
	add	r2, r2, #233472
	add	r3, r0, r3
	str	r3, [r2, #396]
	beq	.L82
	ldr	lr, [fp, #-84]
	mov	r3, #28
	ldr	r9, [fp, #-96]
	sub	r2, fp, #76
	ldr	r10, [fp, #-88]
	mov	r1, #121
	str	lr, [fp, #-68]
	ldr	lr, [fp, #-80]
	str	r0, [fp, #-76]
	str	r4, [fp, #-56]
	ldr	r0, [fp, #16]
	str	r5, [fp, #-52]
	str	r9, [fp, #-72]
	str	r10, [fp, #-64]
	str	lr, [fp, #-60]
	blx	ip
.L82:
	ldr	r3, [fp, #16]
	mov	r1, #1
	mov	r0, #0
	ldr	r3, [r6, r3, asl #2]
	add	r2, r3, #233472
	add	r3, r3, #237568
	str	r1, [r2, #368]
	str	r1, [r3, #332]
	str	r0, [r2, #3900]
	b	.L83
.L94:
	ldr	r3, .L196+52
	b	.L178
.L76:
	ldr	r9, .L196+36
	ldr	ip, [r9]
	cmp	ip, #0
	beq	.L78
	add	r2, r2, #236544
	mov	r1, #0
	str	r3, [fp, #-68]
	add	r2, r2, #840
	mov	r3, r3, asl #4
	str	r2, [fp, #-76]
	str	r1, [fp, #-72]
	sub	r2, fp, #76
	str	r1, [fp, #-64]
	mov	r1, #124
	ldr	r0, [fp, #16]
	blx	ip
	ldr	r3, [fp, #16]
	ldr	ip, [r9]
	ldr	r2, [r10, r3, asl #2]
	add	r1, r2, #237568
.L78:
	ldr	r3, [fp, #16]
	ldr	r2, [r6, r3, asl #2]
	mov	r3, #0
	str	r3, [r1, #328]
	b	.L77
.L195:
	mov	r0, r9
	ldr	r1, .L196+56
	bl	dprint_vfmw
	b	.L74
.L181:
	mov	r0, r3
	ldr	r2, .L196+20
	ldr	r3, .L196+60
	ldr	r1, .L196+24
	bl	dprint_vfmw
	mvn	r3, #0
	b	.L173
.L100:
	ldr	r3, .L196+64
	b	.L178
.L193:
	ldr	r1, .L196+68
	mov	r0, #31
	str	r3, [fp, #-108]
	bl	dprint_vfmw
	ldr	r3, [fp, #16]
	mov	r0, #30
	mov	r2, r0
	ldr	r1, [r6, r3, asl #2]
	ldr	r3, [fp, #-108]
	add	r1, r1, #233472
	str	r0, [r1, #396]
	b	.L86
.L192:
	ldr	r1, .L196+72
	mov	r0, #31
	str	r3, [fp, #-108]
	bl	dprint_vfmw
	ldr	r3, [fp, #16]
	ldr	r2, [r6, r3, asl #2]
	ldr	r3, [fp, #-108]
	b	.L85
.L185:
	ldr	r1, .L196+76
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r3, #0
	b	.L173
.L182:
	ldr	r3, .L196+80
	mov	r0, r9
	ldr	r2, .L196+20
	ldr	r1, .L196+24
	bl	dprint_vfmw
	mvn	r3, #0
	b	.L173
.L190:
	ldr	r1, .L196+84
	mov	r0, #31
	bl	dprint_vfmw
	mvn	r3, #0
	b	.L173
.L191:
	ldr	r3, .L196+88
	ldr	r2, .L196+92
	ldr	r1, .L196+24
	bl	dprint_vfmw
	mvn	r3, #0
	b	.L173
.L197:
	.align	2
.L196:
	.word	s_pstVfmwChan
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_not_direct_8x8_inference_flag
	.word	.LC23
	.word	.LC24
	.word	.LANCHOR0+52
	.word	.LC1
	.word	.LC13
	.word	.LANCHOR0+80
	.word	g_event_report
	.word	.LC15
	.word	.LC10
	.word	.LC11
	.word	.LC9
	.word	.LC14
	.word	.LC19
	.word	.LC21
	.word	.LC18
	.word	.LC17
	.word	.LC22
	.word	.LC20
	.word	.LC12
	.word	.LC16
	.word	.LANCHOR0+108
	.fnend
	.size	VDMHAL_V400R003_ArrangeMem, .-VDMHAL_V400R003_ArrangeMem
	.align	2
	.global	VDMHAL_V400R003_ResetVdm
	.type	VDMHAL_V400R003_ResetVdm, %function
VDMHAL_V400R003_ResetVdm:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #8
	sub	sp, sp, #8
	push	{lr}
	bl	__gnu_mcount_nc
	subs	r4, r0, #0
	bgt	.L217
	bne	.L214
	mov	r0, #0
	movt	r0, 63683
	bl	MEM_Phy2Vir
	subs	r2, r0, #0
	beq	.L218
	ldr	r7, .L220
	ldr	r9, .L220+4
	ldr	r2, [r7]
	ldr	r3, [r9]
	ldr	r8, [r2, #36]
	ldr	r6, [r3, #120]
	tst	r6, #1
	beq	.L198
	ldr	r5, .L220+8
	mov	r2, #2
	bfi	r6, r2, #8, #2
	str	r6, [r3, #120]
	orr	r6, r6, #64
	ldr	r3, [r5, #108]
	blx	r3
	ldr	r3, [r9]
	str	r6, [r3, #120]
	b	.L206
.L219:
	add	r4, r4, #1
	cmp	r4, #1000
	beq	.L207
.L206:
	ldr	r3, [r5, #112]
	mov	r0, #30
	blx	r3
	ldr	r3, [r9]
	ldr	r3, [r3, #372]
	tst	r3, #4
	beq	.L219
	cmp	r4, #1000
	bge	.L207
	mov	r3, #0
	ldr	r2, .L220+12
	mov	r0, r3
	ldr	r1, .L220+16
	bl	dprint_vfmw
.L209:
	ldr	r2, [r9]
	bfc	r6, #6, #1
	ldr	r3, [r5, #108]
	str	r6, [r2, #120]
	bfc	r6, #8, #2
	blx	r3
	ldr	r2, [r9]
	ldr	r3, [r7]
	str	r6, [r2, #120]
	str	r8, [r3, #36]
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L214:
	ldr	r1, .L220+20
	mov	r0, #0
	bl	dprint_vfmw
.L198:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L217:
	mov	r0, #0
	mov	r3, r4
	str	r0, [sp]
	ldr	r2, .L220+12
	ldr	r1, .L220+24
	bl	dprint_vfmw
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L207:
	mov	r3, #0
	ldr	r2, .L220+12
	mov	r0, r3
	ldr	r1, .L220+28
	bl	dprint_vfmw
	b	.L209
.L218:
	ldr	r1, .L220+32
	bl	dprint_vfmw
	b	.L198
.L221:
	.align	2
.L220:
	.word	g_HwMem
	.word	g_pstRegCrg
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0+144
	.word	.LC29
	.word	.LC26
	.word	.LC25
	.word	.LC28
	.word	.LC27
	.fnend
	.size	VDMHAL_V400R003_ResetVdm, .-VDMHAL_V400R003_ResetVdm
	.align	2
	.global	VDMHAL_V400R003_SetSmmuPageTableAddr
	.type	VDMHAL_V400R003_SetSmmuPageTableAddr, %function
VDMHAL_V400R003_SetSmmuPageTableAddr:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #24
	sub	sp, sp, #24
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r3, .L228
	mov	r4, r0
	ldr	ip, [r3, #168]
	cmp	ip, #0
	beq	.L222
	sub	r2, fp, #24
	sub	r1, fp, #28
	sub	r0, fp, #32
	blx	ip
	cmp	r4, #0
	bne	.L224
	ldr	r3, .L228+4
	ldr	r0, [fp, #-32]
	ldr	r1, [fp, #-28]
	ldr	r3, [r3]
	ldr	r2, [fp, #-24]
	add	r3, r3, #61440
	str	r0, [r3, #524]
	str	r1, [r3, #772]
	str	r2, [r3, #776]
.L222:
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L224:
	mov	r5, #1
	mov	r3, r4
	str	r5, [sp]
	mov	r0, #32
	ldr	r2, .L228+8
	ldr	r1, .L228+12
	bl	dprint_vfmw
	mov	r3, r4
	str	r5, [sp]
	mov	r0, #32
	ldr	r2, .L228+8
	ldr	r1, .L228+12
	bl	dprint_vfmw
	str	r5, [sp]
	mov	r3, r4
	ldr	r2, .L228+8
	ldr	r1, .L228+12
	mov	r0, #32
	bl	dprint_vfmw
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L229:
	.align	2
.L228:
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_HwMem
	.word	.LANCHOR0+172
	.word	.LC30
	.fnend
	.size	VDMHAL_V400R003_SetSmmuPageTableAddr, .-VDMHAL_V400R003_SetSmmuPageTableAddr
	.align	2
	.global	VDMHAL_V400R003_EnableSmmu
	.type	VDMHAL_V400R003_EnableSmmu, %function
VDMHAL_V400R003_EnableSmmu:
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
	ldr	r3, .L231
	mov	r2, #8
	ldr	r3, [r3]
	add	r3, r3, #61440
	str	r2, [r3]
	ldmfd	sp, {fp, sp, pc}
.L232:
	.align	2
.L231:
	.word	g_HwMem
	.fnend
	.size	VDMHAL_V400R003_EnableSmmu, .-VDMHAL_V400R003_EnableSmmu
	.align	2
	.global	VDMHAL_V400R003_GlbResetX
	.type	VDMHAL_V400R003_GlbResetX, %function
VDMHAL_V400R003_GlbResetX:
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
	mov	r0, #0
	movt	r0, 63683
	bl	MEM_Phy2Vir
	cmp	r0, #0
	beq	.L249
	cmp	r4, #0
	bne	.L248
	ldr	r5, .L251
	ldr	r3, [r5]
	ldr	r6, [r3, #120]
	tst	r6, #1
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	r7, .L251+4
	mov	r2, #2
	bfi	r6, r2, #8, #2
	str	r6, [r3, #120]
	orr	r6, r6, #16
	ldr	r3, [r7, #108]
	blx	r3
	ldr	r3, [r5]
	str	r6, [r3, #120]
	b	.L240
.L250:
	add	r4, r4, #1
	cmp	r4, #1000
	beq	.L241
.L240:
	ldr	r3, [r7, #112]
	mov	r0, #30
	blx	r3
	ldr	r3, [r5]
	ldr	r3, [r3, #372]
	tst	r3, #1
	beq	.L250
	cmp	r4, #1000
	bge	.L241
	mov	r3, #0
	ldr	r2, .L251+8
	mov	r0, r3
	ldr	r1, .L251+12
	bl	dprint_vfmw
.L243:
	ldr	r2, [r5]
	bfc	r6, #4, #1
	ldr	r3, [r7, #108]
	str	r6, [r2, #120]
	bfc	r6, #8, #2
	blx	r3
	ldr	r3, [r5]
	str	r6, [r3, #120]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L248:
	ldr	r1, .L251+16
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L241:
	mov	r3, #0
	ldr	r2, .L251+8
	mov	r0, r3
	ldr	r1, .L251+20
	bl	dprint_vfmw
	b	.L243
.L249:
	mov	r3, #0
	ldr	r2, .L251+8
	movt	r3, 63683
	ldr	r1, .L251+24
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L252:
	.align	2
.L251:
	.word	g_pstRegCrg
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0+212
	.word	.LC33
	.word	.LC34
	.word	.LC32
	.word	.LC31
	.fnend
	.size	VDMHAL_V400R003_GlbResetX, .-VDMHAL_V400R003_GlbResetX
	.align	2
	.global	VDMHAL_V400R003_GlbReset
	.type	VDMHAL_V400R003_GlbReset, %function
VDMHAL_V400R003_GlbReset:
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
	mov	r0, #0
	movt	r0, 63683
	bl	MEM_Phy2Vir
	cmp	r0, #0
	beq	.L256
	mov	r0, #0
	bl	VDMHAL_V400R003_GlbResetX
	ldmfd	sp, {fp, sp, pc}
.L256:
	mov	r3, #0
	ldr	r2, .L257
	movt	r3, 63683
	ldr	r1, .L257+4
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L258:
	.align	2
.L257:
	.word	.LANCHOR0+240
	.word	.LC31
	.fnend
	.size	VDMHAL_V400R003_GlbReset, .-VDMHAL_V400R003_GlbReset
	.align	2
	.global	VDMHAL_V400R003_ClearIntState
	.type	VDMHAL_V400R003_ClearIntState, %function
VDMHAL_V400R003_ClearIntState:
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
	cmp	r0, #0
	bne	.L265
	ldr	r4, .L267
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L266
.L263:
	mvn	r2, #0
	str	r2, [r3, #32]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L265:
	ldr	r1, .L267+4
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L266:
	mov	r0, #0
	movt	r0, 63683
	bl	MEM_Phy2Vir
	subs	r3, r0, #0
	strne	r3, [r4]
	bne	.L263
.L264:
	ldr	r1, .L267+8
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L268:
	.align	2
.L267:
	.word	g_HwMem
	.word	.LC35
	.word	.LC36
	.fnend
	.size	VDMHAL_V400R003_ClearIntState, .-VDMHAL_V400R003_ClearIntState
	.align	2
	.global	VDMHAL_V400R003_ClearMMUIntState
	.type	VDMHAL_V400R003_ClearMMUIntState, %function
VDMHAL_V400R003_ClearMMUIntState:
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
	cmp	r0, #0
	bne	.L275
	ldr	r4, .L277
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L276
.L273:
	add	r3, r3, #61440
	mov	r2, #7
	str	r2, [r3, #44]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L275:
	ldr	r1, .L277+4
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L276:
	mov	r0, #0
	movt	r0, 63683
	bl	MEM_Phy2Vir
	subs	r3, r0, #0
	strne	r3, [r4]
	bne	.L273
.L274:
	ldr	r1, .L277+8
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L278:
	.align	2
.L277:
	.word	g_HwMem
	.word	.LC35
	.word	.LC36
	.fnend
	.size	VDMHAL_V400R003_ClearMMUIntState, .-VDMHAL_V400R003_ClearMMUIntState
	.align	2
	.global	VDMHAL_V400R003_MaskInt
	.type	VDMHAL_V400R003_MaskInt, %function
VDMHAL_V400R003_MaskInt:
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
	cmp	r0, #0
	bne	.L285
	ldr	r4, .L287
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L286
.L283:
	mvn	r2, #0
	str	r2, [r3, #36]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L285:
	ldr	r1, .L287+4
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L286:
	mov	r0, #0
	movt	r0, 63683
	bl	MEM_Phy2Vir
	subs	r3, r0, #0
	strne	r3, [r4]
	bne	.L283
.L284:
	ldr	r1, .L287+8
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L288:
	.align	2
.L287:
	.word	g_HwMem
	.word	.LC37
	.word	.LC36
	.fnend
	.size	VDMHAL_V400R003_MaskInt, .-VDMHAL_V400R003_MaskInt
	.align	2
	.global	VDMHAL_V400R003_GetIntMaskCfg
	.type	VDMHAL_V400R003_GetIntMaskCfg, %function
VDMHAL_V400R003_GetIntMaskCfg:
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
	cmp	r0, #1
	mvneq	r0, #5
	mvnne	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VDMHAL_V400R003_GetIntMaskCfg, .-VDMHAL_V400R003_GetIntMaskCfg
	.align	2
	.global	VDMHAL_V400R003_EnableInt
	.type	VDMHAL_V400R003_EnableInt, %function
VDMHAL_V400R003_EnableInt:
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
	cmp	r0, #0
	bne	.L298
	ldr	r4, .L300
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L299
.L296:
	mvn	r2, #1
	str	r2, [r3, #36]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L298:
	ldr	r1, .L300+4
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L299:
	mov	r0, #0
	movt	r0, 63683
	bl	MEM_Phy2Vir
	subs	r3, r0, #0
	strne	r3, [r4]
	bne	.L296
.L297:
	ldr	r1, .L300+8
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L301:
	.align	2
.L300:
	.word	g_HwMem
	.word	.LC38
	.word	.LC36
	.fnend
	.size	VDMHAL_V400R003_EnableInt, .-VDMHAL_V400R003_EnableInt
	.align	2
	.global	VDMHAL_V400R003_CheckReg
	.type	VDMHAL_V400R003_CheckReg, %function
VDMHAL_V400R003_CheckReg:
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
	cmp	r1, #0
	mov	r5, r0
	bgt	.L324
	bne	.L322
	ldr	r4, .L326
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L325
.L308:
	sub	r2, r5, #1
	cmp	r2, #6
	ldrls	pc, [pc, r2, asl #2]
	b	.L314
.L316:
	.word	.L319
	.word	.L317
	.word	.L318
	.word	.L320
	.word	.L310
	.word	.L312
	.word	.L313
.L320:
	mov	r3, #40
.L315:
	ldr	r2, [r4]
	ldr	r0, [r2, r3]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L319:
	mov	r3, #28
	b	.L315
.L318:
	mov	r3, #36
	b	.L315
.L313:
	movw	r3, #62272
	b	.L315
.L317:
	mov	r3, #32
	b	.L315
.L310:
	movw	r3, #61480
	b	.L315
.L312:
	movw	r3, #62304
	b	.L315
.L322:
	ldr	r2, .L326+4
	mov	r0, #0
	ldr	r1, .L326+8
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L314:
	mov	r3, r5
	ldr	r2, .L326+4
	ldr	r1, .L326+12
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L325:
	mov	r0, #0
	movt	r0, 63683
	bl	MEM_Phy2Vir
	subs	r6, r0, #0
	strne	r6, [r4]
	bne	.L308
.L309:
	ldr	r2, .L326+4
	ldr	r1, .L326+16
	bl	dprint_vfmw
	mov	r0, r6
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L324:
	mov	r3, r1
	ldr	r2, .L326+4
	ldr	r1, .L326+20
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L327:
	.align	2
.L326:
	.word	g_HwMem
	.word	.LANCHOR0+268
	.word	.LC40
	.word	.LC42
	.word	.LC41
	.word	.LC39
	.fnend
	.size	VDMHAL_V400R003_CheckReg, .-VDMHAL_V400R003_CheckReg
	.align	2
	.global	VDMHAL_V400R003_ReadMMUMask
	.type	VDMHAL_V400R003_ReadMMUMask, %function
VDMHAL_V400R003_ReadMMUMask:
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
	subs	r3, r0, #0
	ble	.L331
	mov	r1, #1
	ldr	r2, .L332
	str	r1, [sp]
	mov	r0, #32
	ldr	r1, .L332+4
	bl	dprint_vfmw
	mov	r0, #0
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L331:
	movw	r0, #1224
	ldr	r2, .L332+8
	mul	r3, r0, r3
	ldr	r3, [r2, r3]
	add	r3, r3, #61440
	ldr	r0, [r3, #32]
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L333:
	.align	2
.L332:
	.word	.LANCHOR0+296
	.word	.LC43
	.word	g_HwMem
	.fnend
	.size	VDMHAL_V400R003_ReadMMUMask, .-VDMHAL_V400R003_ReadMMUMask
	.align	2
	.global	VDMHAL_V400R003_WriteMMUMask
	.type	VDMHAL_V400R003_WriteMMUMask, %function
VDMHAL_V400R003_WriteMMUMask:
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
	subs	r3, r1, #0
	ble	.L337
	mov	r1, #1
	ldr	r2, .L338
	str	r1, [sp]
	mov	r0, #32
	ldr	r1, .L338+4
	bl	dprint_vfmw
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L337:
	movw	r1, #1224
	ldr	r2, .L338+8
	mul	r3, r1, r3
	ldr	r3, [r2, r3]
	add	r3, r3, #61440
	str	r0, [r3, #32]
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L339:
	.align	2
.L338:
	.word	.LANCHOR0+324
	.word	.LC30
	.word	g_HwMem
	.fnend
	.size	VDMHAL_V400R003_WriteMMUMask, .-VDMHAL_V400R003_WriteMMUMask
	.align	2
	.global	VDMHAL_V400R003_PrepareDec
	.type	VDMHAL_V400R003_PrepareDec, %function
VDMHAL_V400R003_PrepareDec:
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
	subs	r7, r1, #0
	mov	r4, r0
	mov	r5, r2
	mov	r6, r3
	beq	.L360
	cmp	r2, #0
	bgt	.L361
	cmp	r0, #6
	mov	r2, #0
	beq	.L362
	mov	r1, r2
	mov	r0, r2
	bl	SCD_ConfigReg
	mov	r3, r6
	mov	r2, #0
	mov	r1, #1
	mov	r0, #8
	bl	SCD_ConfigReg
	cmp	r4, #17
	ldrls	pc, [pc, r4, asl #2]
	b	.L359
.L347:
	.word	.L356
	.word	.L348
	.word	.L349
	.word	.L350
	.word	.L359
	.word	.L351
	.word	.L345
	.word	.L359
	.word	.L352
	.word	.L353
	.word	.L354
	.word	.L354
	.word	.L354
	.word	.L355
	.word	.L359
	.word	.L356
	.word	.L357
	.word	.L358
.L362:
	mov	r0, r2
	mov	r1, #1
	bl	SCD_ConfigReg
	mov	r3, r6
	mov	r2, #0
	mov	r1, #1
	mov	r0, #8
	bl	SCD_ConfigReg
.L345:
	mov	r2, r6
	mov	r1, r5
	mov	r0, r7
	bl	AVSHAL_V400R003_StartDec
.L342:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L356:
	mov	r2, r6
	mov	r1, r5
	mov	r0, r7
	bl	H264HAL_V400R003_StartDec
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L357:
	mov	r2, r6
	mov	r1, r5
	mov	r0, r7
	bl	HEVCHAL_V400R003_StartDec
	b	.L342
.L358:
	mov	r2, r6
	mov	r1, r5
	mov	r0, r7
	bl	VP9HAL_V400R003_StartDec
	b	.L342
.L348:
	mov	r2, r6
	mov	r1, r5
	mov	r0, r7
	bl	VC1HAL_V400R003_StartDec
	b	.L342
.L349:
	mov	r2, r6
	mov	r1, r5
	mov	r0, r7
	bl	MP4HAL_V400R003_StartDec
	b	.L342
.L350:
	mov	r2, r6
	mov	r1, r5
	mov	r0, r7
	bl	MP2HAL_V400R003_StartDec
	b	.L342
.L351:
	mov	r2, r6
	mov	r1, r5
	mov	r0, r7
	bl	DIVX3HAL_V400R003_StartDec
	b	.L342
.L352:
	mov	r2, r6
	mov	r1, r5
	mov	r0, r7
	bl	RV8HAL_V400R003_StartDec
	b	.L342
.L353:
	mov	r2, r6
	mov	r1, r5
	mov	r0, r7
	bl	RV9HAL_V400R003_StartDec
	b	.L342
.L354:
	mov	r2, r6
	mov	r1, r5
	mov	r0, r7
	bl	VP6HAL_V400R003_StartDec
	b	.L342
.L355:
	mov	r2, r6
	mov	r1, r5
	mov	r0, r7
	bl	VP8HAL_V400R003_StartDec
	b	.L342
.L359:
	mvn	r0, #0
	b	.L342
.L361:
	mov	r0, #0
	mov	r3, r2
	str	r0, [sp]
	ldr	r2, .L363
	ldr	r1, .L363+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L342
.L360:
	mov	r3, r7
	mov	r0, r7
	ldr	r2, .L363
	ldr	r1, .L363+8
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L342
.L364:
	.align	2
.L363:
	.word	.LANCHOR0+356
	.word	.LC25
	.word	.LC44
	.fnend
	.size	VDMHAL_V400R003_PrepareDec, .-VDMHAL_V400R003_PrepareDec
	.align	2
	.global	VDMHAL_V400R003_IsVdmReady
	.type	VDMHAL_V400R003_IsVdmReady, %function
VDMHAL_V400R003_IsVdmReady:
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
	movw	r2, #1224
	ldr	r3, .L372
	mul	r2, r2, r0
	ldr	r3, [r3, r2]
	cmp	r3, #0
	beq	.L370
	cmp	r0, #0
	ble	.L371
	mov	r3, r0
	mov	r1, #1
	ldr	r2, .L372+4
	mov	r0, #32
	str	r1, [sp]
	ldr	r1, .L372+8
	bl	dprint_vfmw
	mov	r0, #0
.L367:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L371:
	ldr	r0, [r3, #28]
	ubfx	r0, r0, #17, #1
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L370:
	mov	r0, r3
	ldr	r2, .L372+4
	ldr	r3, .L372+12
	ldr	r1, .L372+16
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L367
.L373:
	.align	2
.L372:
	.word	g_HwMem
	.word	.LANCHOR0+384
	.word	.LC43
	.word	.LC45
	.word	.LC1
	.fnend
	.size	VDMHAL_V400R003_IsVdmReady, .-VDMHAL_V400R003_IsVdmReady
	.align	2
	.global	VDMHAL_V400R003_IsVdmRun
	.type	VDMHAL_V400R003_IsVdmRun, %function
VDMHAL_V400R003_IsVdmRun:
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
	movw	r2, #1224
	ldr	r3, .L381
	mul	r2, r2, r0
	ldr	r4, [r3, r2]
	cmp	r4, #0
	beq	.L379
	cmp	r0, #0
	ble	.L380
	mov	r3, r0
	mov	r4, #1
	ldr	r2, .L381+4
	mov	r0, #32
	str	r4, [sp]
	ldr	r1, .L381+8
	bl	dprint_vfmw
	mov	r0, r4
.L376:
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L380:
	ldr	r0, [r4, #40]
	subs	r0, r0, #1
	movne	r0, #1
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L379:
	ldr	r1, .L381+12
	mov	r0, r4
	bl	dprint_vfmw
	mov	r0, r4
	b	.L376
.L382:
	.align	2
.L381:
	.word	g_HwMem
	.word	.LANCHOR0+412
	.word	.LC43
	.word	.LC46
	.fnend
	.size	VDMHAL_V400R003_IsVdmRun, .-VDMHAL_V400R003_IsVdmRun
	.align	2
	.global	VDMHAL_V400R003_BackupInfo
	.type	VDMHAL_V400R003_BackupInfo, %function
VDMHAL_V400R003_BackupInfo:
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
	subs	r3, r0, #0
	beq	.L431
	ldr	r2, [r3, #4]
	ldr	r4, [r3]
	cmp	r2, #0
	bne	.L421
	ldr	r3, .L435
	ldr	r2, [r3]
	cmp	r2, #1
	addne	r1, r3, #60
	beq	.L388
.L390:
	ldr	r2, [r3, #4]!
	cmp	r2, #1
	beq	.L388
	cmp	r3, r1
	bne	.L390
	ldr	r5, .L435+4
	ldr	ip, [r5]
	cmp	ip, #0
	beq	.L432
	ldr	r8, [ip, #12]
	mov	r7, #0
	ldr	r6, .L435+8
	ldr	r3, [ip, #28]
	str	r8, [r6]
	str	r3, [r6, #4]
.L394:
	add	r2, ip, #4096
	cmp	r7, #0
	ldr	r3, .L435+8
	ldr	r1, [r2]
	ldr	r2, [r2, #20]
	ldr	lr, [ip, #208]
	ldr	r5, [ip, #212]
	str	r1, [r6, #16]
	str	r2, [r6, #20]
	str	lr, [r6, #8]
	str	r5, [r6, #12]
	bne	.L397
	ldr	r10, [ip, #176]
	ldr	r9, [ip, #180]
	ldr	r0, [ip, #184]
	ldr	r1, [ip, #188]
	ldr	r2, [ip, #192]
	str	r10, [r3, #24]
	str	r9, [r3, #28]
	str	r0, [r3, #32]
	str	r1, [r3, #36]
	str	r2, [r3, #40]
.L397:
	ldr	r3, .L435+12
	add	r2, ip, #33024
	add	r0, r3, #128
.L398:
	ldr	r1, [r2], #4
	str	r1, [r3, #4]!
	cmp	r3, r0
	bne	.L398
	cmp	r7, #0
	bne	.L402
	add	ip, ip, #32768
	ldr	r2, [ip, #384]
	ldr	r3, [ip, #388]
	str	r2, [r6, #48]
	str	r3, [r6, #44]
.L402:
	and	r3, r8, #15
	cmp	r3, #5
	andeq	r5, r5, #1
	andne	lr, lr, #31
	moveq	r0, #0
	streq	r5, [r4]
	strne	lr, [r4]
	movne	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L388:
	ldr	r5, .L435+4
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L433
	ldr	r2, [r3, #12]
	mov	r7, #1
	ldr	r3, [r3, #28]
	ldr	r6, .L435+8
	stmia	r6, {r2, r3}
.L393:
	ldr	r0, [r5, #40]
	ubfx	r8, r3, #0, #17
	bl	MEM_Phy2Vir
	subs	r2, r0, #0
	beq	.L434
	sub	r3, r8, #1
	ldr	ip, [r5]
	cmp	r3, #199
	subls	r3, r8, #-1073741823
	ldr	r8, [r6]
	movhi	r3, #0
	movhi	r1, #8
	movls	r3, r3, asl #4
	ldr	lr, [ip, #208]
	addls	r1, r3, #8
	ldr	r5, [ip, #212]
	ldr	r3, [r2, r3]
	str	r3, [r6, #16]
	ldr	r3, [r2, r1]
	str	lr, [r6, #8]
	str	r5, [r6, #12]
	str	r3, [r6, #20]
	b	.L397
.L432:
	mov	r7, ip
.L403:
	mov	r0, #0
	movt	r0, 63683
	bl	MEM_Phy2Vir
	subs	ip, r0, #0
	beq	.L392
	ldr	r8, [ip, #12]
	cmp	r7, #1
	ldr	r6, .L435+8
	ldr	r3, [ip, #28]
	str	ip, [r5]
	str	r8, [r6]
	str	r3, [r6, #4]
	bne	.L394
	b	.L393
.L433:
	mov	r7, #1
	b	.L403
.L421:
	ldr	r1, .L435+16
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L431:
	ldr	r3, .L435+20
	ldr	r2, .L435+24
	ldr	r1, .L435+28
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L392:
	ldr	r1, .L435+32
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L434:
	ldr	r3, .L435+36
	ldr	r2, .L435+24
	ldr	r1, .L435+28
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L436:
	.align	2
.L435:
	.word	g_DSPState
	.word	g_HwMem
	.word	g_BackUp
	.word	g_BackUp+48
	.word	.LC48
	.word	.LC47
	.word	.LANCHOR0+440
	.word	.LC1
	.word	.LC36
	.word	.LC49
	.fnend
	.size	VDMHAL_V400R003_BackupInfo, .-VDMHAL_V400R003_BackupInfo
	.align	2
	.global	VDMHAL_V400R003_ReadMsgSlot
	.type	VDMHAL_V400R003_ReadMsgSlot, %function
VDMHAL_V400R003_ReadMsgSlot:
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
	cmp	r1, #0
	cmpne	r0, #0
	mov	r3, r1
	moveq	r4, #1
	movne	r4, #0
	beq	.L441
	cmp	r2, #800
	bhi	.L442
	ldr	r3, .L443
	mov	r2, r2, asl #2
	ldr	r3, [r3, #52]
	blx	r3
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L442:
	mov	r0, r4
	ldr	r1, .L443+4
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L441:
	mov	r2, r0
	ldr	r1, .L443+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L444:
	.align	2
.L443:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC51
	.word	.LC50
	.fnend
	.size	VDMHAL_V400R003_ReadMsgSlot, .-VDMHAL_V400R003_ReadMsgSlot
	.align	2
	.global	VDMHAL_V400R003_WriteMsgSlot
	.type	VDMHAL_V400R003_WriteMsgSlot, %function
VDMHAL_V400R003_WriteMsgSlot:
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
	cmp	r1, #0
	cmpne	r0, #0
	moveq	r4, #1
	movne	r4, #0
	beq	.L446
	sub	r3, r2, #1
	cmp	r3, #255
	bhi	.L446
	ldr	r3, .L449
	mov	r2, r2, asl #2
	ldr	r3, [r3, #52]
	blx	r3
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L446:
	ldr	r1, .L449+4
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L450:
	.align	2
.L449:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC52
	.fnend
	.size	VDMHAL_V400R003_WriteMsgSlot, .-VDMHAL_V400R003_WriteMsgSlot
	.global	__aeabi_uidiv
	.global	__aeabi_uidivmod
	.align	2
	.global	VDMHAL_V400R003_CfgRpMsg
	.type	VDMHAL_V400R003_CfgRpMsg, %function
VDMHAL_V400R003_CfgRpMsg:
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
	str	r0, [fp, #-56]
	ldr	r0, [r1, #48]
	str	r2, [fp, #-80]
	bl	MEM_Phy2Vir
	subs	r3, r0, #0
	str	r3, [fp, #-76]
	beq	.L490
	ldr	r3, [fp, #-56]
	ldr	r2, [r3, #840]
	sub	r3, r2, #1
	cmp	r3, #199
	bhi	.L491
	ldr	r2, [fp, #-56]
	ldr	r3, [r2, #24]
	ldr	r1, [r2, #864]
	ldr	r0, [r2, #848]
	mov	r3, r3, asl r1
	ldr	r2, [r2, #28]
	add	lr, r3, #255
	cmp	r0, #1
	bic	lr, lr, #255
	mov	r1, r2, asl r1
	movne	r3, #0
	mov	ip, lr, asl #4
	beq	.L492
.L455:
	ldr	r2, [fp, #-56]
	ldr	r2, [r2]
	cmp	r2, #16
	beq	.L456
	add	r2, r1, #31
	mov	r1, #8
	bic	r2, r2, #31
	str	r1, [fp, #-100]
	mla	r2, r2, lr, r3
.L476:
	ldr	r4, [fp, #-56]
	ldr	r5, [fp, #-76]
	mov	r0, #0
	mov	r1, r0
	ldr	lr, [r4, #16]
	str	lr, [r5]
	ldr	lr, [r4, #16]
	add	lr, r2, lr
	str	lr, [r5, #4]
	ldr	lr, [r4, #4]
	str	lr, [r5, #8]
	ldr	lr, [r4, #4]
	add	r2, r2, lr
	str	r2, [r5, #12]
	str	ip, [r5, #16]
	str	r3, [r5, #20]
	ldr	r2, [r4, #24]
	ldr	r3, [r4, #28]
	sub	r2, r2, #1
	sub	r3, r3, #1
	bfi	r0, r2, #0, #9
	bfi	r1, r3, #0, #9
	strh	r0, [fp, #-48]
	strh	r1, [fp, #-46]
	ldr	r3, [fp, #-48]
	str	r3, [r5, #24]
	ldr	r3, [r4, #852]
	ldr	r2, [r4, #24]
	sub	r3, r3, #1
	cmp	r3, #1
	str	r2, [fp, #-84]
	movls	r3, r4
	ldrhi	r3, [fp, #-56]
	ldrls	r3, [r3, #28]
	ldrhi	r3, [r3, #28]
	addls	r3, r3, r3, lsr #31
	movls	r3, r3, asr #1
	str	r3, [fp, #-104]
	ldr	r3, [fp, #-56]
	ldr	r3, [r3, #864]
	cmp	r3, #6
	moveq	r4, #2
	beq	.L459
	cmp	r3, #5
	moveq	r4, #4
	beq	.L459
	cmp	r3, #4
	moveq	r4, #8
	beq	.L459
	ldr	r1, .L497
	mov	r0, #32
	bl	dprint_vfmw
	mov	r4, #1
.L459:
	ldr	r3, [fp, #-56]
	ldr	r3, [r3, #856]
	cmp	r3, #0
	bne	.L481
	ldr	r2, [fp, #-56]
	ldr	r10, [r2, #840]
	cmp	r10, #0
	strle	r3, [fp, #-64]
	ble	.L462
	ldr	r2, [fp, #-84]
	mov	r6, r3
	ldr	r1, [fp, #-104]
	sub	r7, r4, #1
	str	r3, [fp, #-64]
	str	r3, [fp, #-72]
	mul	r2, r2, r1
	sub	r3, r2, #1
	str	r3, [fp, #-92]
	str	r2, [fp, #-88]
	b	.L463
.L465:
	ldr	r3, [fp, #-56]
	add	r6, r6, #1
	ldr	r10, [r3, #840]
	cmp	r10, r6
	ble	.L493
	cmp	r6, #199
	bgt	.L494
.L463:
	ldr	r3, [fp, #-56]
	mov	r1, r4
	add	r8, r3, r6, lsl #2
	ldrsh	r2, [r8, #42]
	ldrh	r3, [r8, #40]
	sub	r0, r2, #1
	add	r0, r0, r4
	str	r2, [fp, #-60]
	str	r3, [fp, #-68]
	bl	__aeabi_uidiv
	cmp	r6, #0
	mul	r9, r4, r0
	ble	.L464
	ldrsh	r0, [r8, #38]
	mov	r1, r4
	sub	r0, r0, #1
	add	r0, r0, r4
	bl	__aeabi_uidiv
	ldr	r2, [fp, #-60]
	mul	r3, r4, r0
	cmp	r9, r3
	str	r3, [fp, #-72]
	ble	.L465
	b	.L466
.L481:
	mov	r2, #0
	str	r2, [fp, #-64]
.L460:
	cmp	r3, #1
	beq	.L473
.L462:
	ldr	r3, [fp, #-64]
	sub	r3, r3, #1
	uxth	r3, r3
.L475:
	ldr	lr, [fp, #-56]
	mov	r0, #0
	ldrb	r2, [fp, #-46]
	strh	r3, [fp, #-48]
	ldr	r1, [lr, #848]
	ldr	ip, [lr, #852]
	ldr	lr, [lr, #864]
	bfi	r2, r1, #0, #1
	ldrb	r1, [fp, #-45]
	and	ip, ip, #3
	sub	lr, lr, #4
	bfi	r2, ip, #4, #2
	bfi	r1, lr, #0, #2
	mov	r3, r2
	bfi	r3, ip, #6, #2
	mov	r2, r1
	ldr	r1, [fp, #-100]
	strb	r3, [fp, #-46]
	bfi	r2, r1, #2, #4
	strb	r2, [fp, #-45]
	ldr	r3, [fp, #-48]
	ldr	r2, [fp, #-76]
	str	r3, [r2, #28]
.L488:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L469:
	bl	__aeabi_uidiv
	mov	r1, r4
	mul	r9, r4, r0
	ldrsh	r0, [r8, #44]
	bl	__aeabi_uidiv
	mul	r0, r4, r0
	cmp	r9, r0
	add	r2, r0, #1
	bhi	.L470
	cmp	r9, r2
	mov	r1, r4
	beq	.L470
	ldrsh	r0, [r8, #38]
	add	r0, r0, r7
	bl	__aeabi_uidiv
	mul	r0, r4, r0
	cmp	r9, r0
	bhi	.L468
.L470:
	add	r3, r5, #1
	mov	r6, r5
	cmp	r3, #199
	add	r8, r8, #4
	bgt	.L495
	ldrsh	r2, [r8, #42]
.L466:
	add	r5, r6, #1
	mov	r1, r4
	cmp	r5, r10
	add	r0, r7, r2
	blt	.L469
	bl	__aeabi_uidiv
	mul	r9, r4, r0
.L468:
	ldr	r3, [fp, #-64]
	ldr	r5, [fp, #-92]
	add	r8, r3, #1
	ldr	r3, [fp, #-88]
	cmp	r3, r9
	movhi	r5, r9
	cmp	r8, #252
	bgt	.L496
	ldr	r3, [fp, #-80]
	cmp	r3, #0
	strne	r8, [fp, #-64]
	bne	.L465
	ldrsh	r0, [fp, #-68]
	mov	r1, r4
	bl	__aeabi_uidiv
	ldr	r3, [fp, #-64]
	ldr	r1, [fp, #-84]
	str	r8, [fp, #-64]
	mov	r10, r3, asl #3
	ldr	r3, [fp, #-80]
	mov	r2, r3, lsr #16
	mov	r9, r3
	mov	r8, r3
	str	r2, [fp, #-96]
	str	r2, [fp, #-68]
	mul	ip, r4, r0
	mov	r0, ip
	str	ip, [fp, #-60]
	bl	__aeabi_uidivmod
	ldr	ip, [fp, #-60]
	mov	r0, ip
	bfi	r9, r1, #0, #9
	strh	r9, [fp, #-48]
	ldr	r9, [fp, #-84]
	mov	r1, r9
	bl	__aeabi_uidiv
	ldr	r2, [fp, #-96]
	ldr	r3, [fp, #-76]
	add	ip, r10, #48
	mov	r1, r9
	add	r10, r10, #52
	bfi	r2, r0, #0, #9
	strh	r2, [fp, #-46]
	ldr	r2, [fp, #-48]
	mov	r0, r5
	str	r2, [r3, ip]
	bl	__aeabi_uidivmod
	mov	r0, r5
	bfi	r8, r1, #0, #9
	mov	r1, r9
	strh	r8, [fp, #-48]
	bl	__aeabi_uidiv
	ldr	r3, [fp, #-68]
	ldr	r2, [fp, #-76]
	bfi	r3, r0, #0, #9
	strh	r3, [fp, #-46]
	ldr	r3, [fp, #-48]
	str	r3, [r2, r10]
	b	.L465
.L464:
	ldr	r2, [fp, #-72]
	cmp	r9, r2
	movgt	r2, #0
	movle	r2, #1
	cmp	r6, #0
	moveq	r2, #0
	cmp	r2, #0
	bne	.L465
	b	.L468
.L495:
	ldr	r3, [fp, #-56]
	mov	r1, r4
	add	r3, r3, r5, lsl #2
	ldrsh	r0, [r3, #42]
	sub	r0, r0, #1
	add	r0, r0, r4
	bl	__aeabi_uidiv
	mul	r9, r4, r0
	b	.L468
.L456:
	mla	r2, lr, r1, r3
	mov	r1, #10
	str	r1, [fp, #-100]
	b	.L476
.L492:
	add	r0, r3, #508
	adds	r2, r1, #63
	add	r0, r0, #3
	addmi	r2, r1, #126
	add	r3, r3, #1020
	cmp	r0, #0
	add	r3, r3, #2
	mov	r2, r2, asr #6
	movge	r3, r0
	bic	r3, r3, #508
	bic	r3, r3, #3
	mov	r2, r2, asl #5
	add	r0, r3, #63
	cmp	r3, #0
	movlt	r3, r0
	mov	r3, r3, asr #6
	mov	r3, r3, asl #1
	mul	r3, r3, r2
	b	.L455
.L496:
	ldr	r2, [fp, #-56]
	mov	r3, #1
	str	r3, [r2, #856]
.L473:
	ldr	r3, [fp, #-80]
	ldr	r2, [fp, #-56]
	cmp	r3, #0
	mov	r3, #1
	str	r3, [r2, #840]
	movne	r3, #0
	bne	.L475
	ldr	lr, [fp, #-80]
	ldr	r3, [fp, #-84]
	ldr	r2, [fp, #-104]
	mov	r0, lr, lsr #16
	strh	lr, [fp, #-48]
	sub	r3, r3, #1
	sub	r2, r2, #1
	bfi	r0, lr, #0, #9
	mov	r1, lr, lsr #16
	strh	r0, [fp, #-46]
	bfi	r1, r2, #0, #9
	ldr	ip, [fp, #-48]
	mov	r0, lr
	strh	r1, [fp, #-46]
	bfi	r0, r3, #0, #9
	strh	r0, [fp, #-48]
	mov	r3, lr
	ldr	r1, [fp, #-76]
	ldr	r2, [fp, #-48]
	str	ip, [r1, #48]
	str	r2, [r1, #52]
	b	.L475
.L493:
	ldr	r3, [r3, #856]
	b	.L460
.L494:
	str	r6, [sp]
	movw	r3, #2556
	ldr	r2, .L497+4
	mov	r0, #0
	ldr	r1, .L497+8
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L491:
	ldr	r1, .L497+12
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L488
.L490:
	ldr	r3, .L497+16
	ldr	r2, .L497+4
	ldr	r1, .L497+20
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L488
.L498:
	.align	2
.L497:
	.word	.LC55
	.word	.LANCHOR0+468
	.word	.LC56
	.word	.LC54
	.word	.LC53
	.word	.LC1
	.fnend
	.size	VDMHAL_V400R003_CfgRpMsg, .-VDMHAL_V400R003_CfgRpMsg
	.align	2
	.global	VDMHAL_V400R003_CfgRpReg
	.type	VDMHAL_V400R003_CfgRpReg, %function
VDMHAL_V400R003_CfgRpReg:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #16
	sub	sp, sp, #16
	push	{lr}
	bl	__gnu_mcount_nc
	cmp	r3, #0
	mov	r0, #0
	str	r0, [fp, #-24]
	bne	.L534
	ldr	r3, [r1]
	cmp	r3, #0
	beq	.L535
.L503:
	ldr	r4, .L537
	ldr	r3, [r1, #48]
	ldrb	r2, [r4]
	bic	r3, r3, #15
	str	r3, [fp, #-24]
	cmp	r2, #1
	bne	.L536
	ldr	r2, .L537+4
	ldr	r1, [r2]
	str	r3, [r1, #16]
.L506:
	ldr	r1, [r2]
	movw	r3, #53763
	movt	r3, 8192
	str	r3, [r1, #12]
.L508:
	ldr	r1, [r2]
	movw	r3, #3075
	movt	r3, 48
	str	r3, [r1, #60]
.L510:
	ldr	r1, [r2]
	movw	r3, #3075
	movt	r3, 48
	str	r3, [r1, #64]
.L512:
	ldr	r1, [r2]
	movw	r3, #3075
	movt	r3, 48
	str	r3, [r1, #68]
.L514:
	ldr	r1, [r2]
	movw	r3, #3075
	movt	r3, 48
	str	r3, [r1, #72]
.L516:
	ldr	r1, [r2]
	movw	r3, #3075
	movt	r3, 48
	str	r3, [r1, #76]
.L518:
	ldr	r1, [r2]
	movw	r3, #3075
	movt	r3, 48
	str	r3, [r1, #80]
.L520:
	ldr	r2, [r2]
	movw	r3, #3075
	mov	r0, #0
	movt	r3, 48
	str	r3, [r2, #84]
.L523:
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L536:
	mov	r2, #16
	mov	r1, #2
	ldr	r0, [fp, #4]
	bl	VDH_Record_RegData
	ldrb	r2, [r4]
	movw	r3, #53763
	cmp	r2, #1
	movt	r3, 8192
	str	r3, [fp, #-24]
	ldreq	r2, .L537+4
	beq	.L506
	mov	r2, #12
	mov	r1, #2
	ldr	r0, [fp, #4]
	movw	r5, #3075
	bl	VDH_Record_RegData
	ldrb	r3, [r4]
	movt	r5, 48
	str	r5, [fp, #-24]
	cmp	r3, #1
	ldreq	r2, .L537+4
	beq	.L508
	mov	r3, r5
	mov	r2, #60
	mov	r1, #2
	ldr	r0, [fp, #4]
	bl	VDH_Record_RegData
	ldrb	r3, [r4]
	cmp	r3, #1
	ldreq	r2, .L537+4
	beq	.L510
	mov	r3, r5
	mov	r2, #64
	mov	r1, #2
	ldr	r0, [fp, #4]
	bl	VDH_Record_RegData
	ldrb	r3, [r4]
	cmp	r3, #1
	ldreq	r2, .L537+4
	beq	.L512
	mov	r3, r5
	mov	r2, #68
	mov	r1, #2
	ldr	r0, [fp, #4]
	bl	VDH_Record_RegData
	ldrb	r3, [r4]
	cmp	r3, #1
	ldreq	r2, .L537+4
	beq	.L514
	mov	r3, r5
	mov	r2, #72
	mov	r1, #2
	ldr	r0, [fp, #4]
	bl	VDH_Record_RegData
	ldrb	r3, [r4]
	cmp	r3, #1
	ldreq	r2, .L537+4
	beq	.L516
	mov	r3, r5
	mov	r2, #76
	mov	r1, #2
	ldr	r0, [fp, #4]
	bl	VDH_Record_RegData
	ldrb	r3, [r4]
	cmp	r3, #1
	ldreq	r2, .L537+4
	beq	.L518
	mov	r3, r5
	mov	r2, #80
	mov	r1, #2
	ldr	r0, [fp, #4]
	bl	VDH_Record_RegData
	ldrb	r3, [r4]
	cmp	r3, #1
	ldreq	r2, .L537+4
	beq	.L520
	ldr	r0, [fp, #4]
	mov	r3, r5
	mov	r2, #84
	mov	r1, #2
	bl	VDH_Record_RegData
	mov	r0, #0
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L535:
	mov	r0, #0
	str	r1, [fp, #-32]
	movt	r0, 63683
	bl	MEM_Phy2Vir
	subs	r3, r0, #0
	beq	.L504
	ldr	r1, [fp, #-32]
	str	r3, [r1]
	b	.L503
.L534:
	ldr	r1, .L537+8
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L523
.L504:
	ldr	r1, .L537+12
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L523
.L538:
	.align	2
.L537:
	.word	g_HalDisable
	.word	g_HwMem
	.word	.LC57
	.word	.LC36
	.fnend
	.size	VDMHAL_V400R003_CfgRpReg, .-VDMHAL_V400R003_CfgRpReg
	.align	2
	.global	VDMHAL_V400R003_MakeDecReport
	.type	VDMHAL_V400R003_MakeDecReport, %function
VDMHAL_V400R003_MakeDecReport:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #20
	sub	sp, sp, #20
	push	{lr}
	bl	__gnu_mcount_nc
	subs	r3, r0, #0
	beq	.L568
	ldmia	r3, {r7, r8}
	ldr	r5, [r3, #8]
	cmp	r8, #0
	beq	.L569
	movw	r3, #1224
	ldr	r6, .L575
	mul	r3, r3, r5
	ldr	r0, [r6, r3]
	cmp	r0, #0
	beq	.L543
	ldr	r3, .L575+4
	ldr	r2, [r3]
	cmp	r2, #1
	addne	r1, r3, #60
	beq	.L558
.L546:
	ldr	r2, [r3, #4]!
	cmp	r2, #1
	beq	.L558
	cmp	r3, r1
	bne	.L546
	mov	r4, #0
.L544:
	ldr	r3, .L575+8
	mov	r2, #816
	mov	r1, #0
	mov	r0, r8
	ldr	r3, [r3, #48]
	blx	r3
	movw	r3, #1224
	mla	r3, r3, r5, r6
	ldr	r1, .L575+12
	mov	r2, #180
	mla	r2, r2, r5, r1
	ldr	r3, [r3, #24]
	str	r3, [r8, #4]
	ldr	r3, [r2, #4]
	mov	r3, r3, lsr #17
	and	r2, r3, #3
	cmp	r2, #1
	moveq	r3, #0
	beq	.L547
	eor	r3, r3, #1
	and	r3, r3, #1
	cmp	r7, #3
	orrne	r3, r3, #1
.L547:
	mov	r2, #180
	str	r3, [r8]
	mla	r3, r2, r5, r1
	cmp	r7, #0
	cmpne	r7, #15
	ldr	r2, [r3, #4]
	ubfx	r2, r2, #0, #17
	str	r2, [r8, #8]
	beq	.L570
.L548:
	cmp	r2, #200
	bhi	.L571
.L550:
	movw	r3, #1224
	mla	r6, r3, r5, r6
	ldr	r7, [r6, #40]
	mov	r0, r7
	bl	MEM_Phy2Vir
	subs	r1, r0, #0
	beq	.L572
	ldr	r6, .L575+16
	mov	r3, #3200
	ldr	r2, [r8, #8]
	mla	r4, r3, r5, r6
	mov	r2, r2, asl #2
	mov	r0, r4
	bl	VDMHAL_V400R003_ReadMsgSlot
	ldr	ip, [r8, #8]
	cmp	ip, #0
	movne	r3, r4
	movne	r1, r8
	movne	r2, #0
	beq	.L555
.L554:
	ldr	r0, [r3, #4]
	add	r2, r2, #1
	cmp	r2, ip
	add	r3, r3, #16
	add	r1, r1, #4
	strh	r0, [r1, #8]
	ldr	r0, [r3, #-8]
	strh	r0, [r1, #10]
	bne	.L554
.L555:
	mov	r0, #6
	bl	IsDprintTypeEnable
	cmp	r0, #0
	bne	.L573
.L541:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L570:
	cmp	r4, #1
	beq	.L574
	ldr	r1, .L575+20
	ldrb	r1, [r1]
	cmp	r1, #0
	bne	.L548
	ldrb	r3, [r3, #19]
	and	r3, r3, #3
	cmp	r3, #2
	bne	.L548
	mov	r3, #1
	strh	r1, [r8, #12]
	mov	r0, r1
	strh	r1, [r8, #14]
	str	r3, [r8, #8]
	b	.L541
.L558:
	mov	r4, r2
	b	.L544
.L573:
	ldr	r2, [r8, #8]
	mov	r0, #6
	ldr	r1, .L575+24
	mov	r4, #0
	bl	dprint_vfmw
	mov	r2, r7
	ldr	r1, .L575+28
	mov	r0, #6
	bl	dprint_vfmw
	mov	r3, #3200
	mla	r5, r3, r5, r6
.L556:
	ldr	r1, [r5, #4]
	ldr	lr, [r5, #12]
	mov	r2, r4
	ldr	ip, [r5, #8]
	mov	r0, #6
	ldr	r3, [r5]
	add	r4, r4, #4
	str	r1, [sp]
	add	r5, r5, #16
	str	lr, [sp, #8]
	str	ip, [sp, #4]
	ldr	r1, .L575+32
	bl	dprint_vfmw
	ldr	r3, [r8, #8]
	mov	r3, r3, asl #2
	sub	r3, r3, #3
	cmp	r3, r4
	bhi	.L556
	ldr	r1, .L575+36
	mov	r0, #6
	bl	dprint_vfmw
	mov	r0, #0
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L571:
	mov	r3, #200
	ldr	r1, .L575+40
	mov	r0, #1
	bl	dprint_vfmw
	mov	r3, #0
	str	r3, [r8, #8]
	b	.L550
.L574:
	ldr	r3, [r3, #16]
	ubfx	r3, r3, #21, #2
	cmp	r3, #2
	bne	.L548
	mov	r3, #0
	str	r4, [r8, #8]
	strh	r3, [r8, #12]
	mov	r0, r3
	strh	r3, [r8, #14]
	b	.L541
.L572:
	ldr	r3, .L575+44
	ldr	r2, .L575+48
	ldr	r1, .L575+52
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L541
.L543:
	ldr	r3, .L575+56
	ldr	r2, .L575+48
	ldr	r1, .L575+52
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L541
.L569:
	mov	r0, r8
	ldr	r3, .L575+60
	ldr	r2, .L575+48
	ldr	r1, .L575+52
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L541
.L568:
	ldr	r3, .L575+64
	ldr	r2, .L575+48
	ldr	r1, .L575+52
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L541
.L576:
	.align	2
.L575:
	.word	g_HwMem
	.word	g_DSPState
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_BackUp
	.word	g_UpMsg
	.word	g_not_allow_H264FullPictureRepair_flag
	.word	.LC61
	.word	.LC62
	.word	.LC63
	.word	.LC64
	.word	.LC60
	.word	.LC49
	.word	.LANCHOR0+496
	.word	.LC1
	.word	.LC45
	.word	.LC59
	.word	.LC58
	.fnend
	.size	VDMHAL_V400R003_MakeDecReport, .-VDMHAL_V400R003_MakeDecReport
	.align	2
	.global	VDMHAL_V400R003_PrepareRepair
	.type	VDMHAL_V400R003_PrepareRepair, %function
VDMHAL_V400R003_PrepareRepair:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #20
	sub	sp, sp, #20
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r4, .L592
	cmp	r3, #0
	movw	r5, #1224
	mov	r6, r0
	mla	r5, r5, r3, r4
	bne	.L589
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L590
.L581:
	cmp	r2, #0
	bne	.L583
	ldr	r3, .L592+4
	ldr	r0, [r3, #840]
	cmp	r0, #0
	ble	.L584
	cmp	r6, #6
	bne	.L585
	ldrb	r2, [r1, #17]
	cmp	r2, #1
	movne	r2, #0
	str	r2, [r3, #1724]
.L585:
	ldr	r3, [fp, #4]
	mov	r2, r1
	mov	r0, r6
	mov	r1, r5
	str	r3, [sp]
	mov	r3, #0
	bl	VDMHAL_V400R003_CfgRpReg
	mov	r1, r5
	mov	r2, #0
	ldr	r0, .L592+4
	bl	VDMHAL_V400R003_CfgRpMsg
	mov	r0, #0
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L583:
	cmp	r2, #1
	movne	r0, #0
	beq	.L591
.L580:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L591:
	cmp	r6, #6
	bne	.L587
	ldrb	r3, [r1, #17]
	cmp	r3, #1
	bne	.L587
	ldr	r4, .L592+4
	ldr	r3, [r4, #1712]
	cmp	r3, #0
	ble	.L587
	ldr	r3, [fp, #4]
	mov	ip, #2
	mov	r2, r1
	mov	r0, r6
	mov	r1, r5
	str	r3, [sp]
	mov	r3, #0
	str	ip, [r4, #1724]
	bl	VDMHAL_V400R003_CfgRpReg
	mov	r1, r5
	add	r0, r4, #872
	mov	r2, #0
	bl	VDMHAL_V400R003_CfgRpMsg
	mov	r0, #0
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L590:
	mov	r0, #0
	str	r2, [fp, #-36]
	movt	r0, 63683
	str	r1, [fp, #-32]
	bl	MEM_Phy2Vir
	subs	r3, r0, #0
	beq	.L582
	str	r3, [r4]
	ldr	r1, [fp, #-32]
	ldr	r2, [fp, #-36]
	b	.L581
.L587:
	ldr	r1, .L592+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L580
.L589:
	ldr	r1, .L592+12
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L580
.L584:
	mov	r0, r2
	ldr	r1, .L592+16
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L580
.L582:
	ldr	r1, .L592+20
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L580
.L593:
	.align	2
.L592:
	.word	g_HwMem
	.word	g_RepairParam
	.word	.LC68
	.word	.LC65
	.word	.LC67
	.word	.LC66
	.fnend
	.size	VDMHAL_V400R003_PrepareRepair, .-VDMHAL_V400R003_PrepareRepair
	.align	2
	.global	VDMHAL_V400R003_StartHwRepair
	.type	VDMHAL_V400R003_StartHwRepair, %function
VDMHAL_V400R003_StartHwRepair:
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
	ldr	r6, .L624
	mov	r5, r0
	mov	r4, r1
	ldrb	r3, [r6]
	cmp	r3, #1
	bne	.L618
	cmp	r0, #0
	ble	.L619
	str	r3, [sp]
	mov	r3, r0
	ldr	r2, .L624+4
	mov	r0, #32
	ldr	r1, .L624+8
	bl	dprint_vfmw
	ldrb	r3, [r6]
	cmp	r3, #1
	bne	.L620
.L602:
	mov	r2, #1
	mov	r3, r5
	str	r2, [sp]
	mov	r0, #32
	ldr	r2, .L624+4
	ldr	r1, .L624+8
	bl	dprint_vfmw
	ldrb	r3, [r6]
	cmp	r3, #1
	beq	.L614
.L597:
	cmp	r4, #0
	beq	.L621
	ldr	r1, .L624+12
	mov	r3, #44
	mov	r2, #1
	str	r2, [r4, #4]
	mov	r0, r4
	mla	r3, r3, r5, r1
	ldr	r3, [r3, #8]
	strb	r2, [r4, #2]
	strb	r5, [r4]
	str	r3, [r4, #8]
	bl	VDH_PostTask
.L594:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L619:
	movw	r3, #1224
	ldr	r4, .L624+16
	mul	r3, r3, r0
	mov	r2, #67108864
	ldr	r3, [r4, r3]
	str	r2, [r3, #8]
.L600:
	movw	r3, #1224
	ldr	r2, .L624+20
	mul	r3, r3, r5
	mvn	r1, #1
	ldr	r3, [r4, r3]
	str	r1, [r3, #36]
	ldr	r3, [r2, #108]
	blx	r3
.L609:
	movw	r3, #1224
	mov	r2, #0
	mul	r5, r3, r5
	mov	r1, #1
	ldr	r3, [r4, r5]
	str	r2, [r3]
	ldr	r3, [r4, r5]
	str	r1, [r3]
	ldr	r3, [r4, r5]
	str	r2, [r3]
	b	.L594
.L618:
	mov	r3, #67108864
	mov	r2, #8
	mov	r1, #2
	mov	r0, r4
	bl	VDH_Record_RegData
	ldrb	r3, [r6]
	cmp	r3, #1
	bne	.L622
	cmp	r5, #0
	ldrle	r4, .L624+16
	bgt	.L602
	b	.L600
.L622:
	mvn	r3, #1
	mov	r2, #36
	mov	r1, #2
	mov	r0, r4
	bl	VDH_Record_RegData
	ldrb	r3, [r6]
	cmp	r3, #1
	bne	.L597
	ldr	r3, .L624+20
	ldr	r3, [r3, #108]
	blx	r3
	cmp	r5, #0
	ble	.L623
.L607:
	mov	r4, #1
	mov	r3, r5
	str	r4, [sp]
	mov	r0, #32
	ldr	r2, .L624+24
	ldr	r1, .L624+8
	bl	dprint_vfmw
	mov	r3, r5
	str	r4, [sp]
	mov	r0, #32
	ldr	r2, .L624+24
	ldr	r1, .L624+8
	bl	dprint_vfmw
	str	r4, [sp]
	mov	r3, r5
	ldr	r2, .L624+24
	ldr	r1, .L624+8
	mov	r0, #32
	bl	dprint_vfmw
	b	.L594
.L620:
	mvn	r3, #1
	mov	r2, #36
	mov	r1, #2
	mov	r0, r4
	bl	VDH_Record_RegData
	ldrb	r3, [r6]
	cmp	r3, #1
	bne	.L597
.L614:
	ldr	r3, .L624+20
	ldr	r3, [r3, #108]
	blx	r3
	b	.L607
.L621:
	mov	r3, r4
	mov	r0, r4
	ldr	r2, .L624+24
	ldr	r1, .L624+28
	bl	dprint_vfmw
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L623:
	ldr	r4, .L624+16
	b	.L609
.L625:
	.align	2
.L624:
	.word	g_HalDisable
	.word	.LANCHOR0+528
	.word	.LC30
	.word	g_VdmDrvParam
	.word	g_HwMem
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0+544
	.word	.LC69
	.fnend
	.size	VDMHAL_V400R003_StartHwRepair, .-VDMHAL_V400R003_StartHwRepair
	.align	2
	.global	VDMHAL_V400R003_CalVdhClkSkip
	.type	VDMHAL_V400R003_CalVdhClkSkip, %function
VDMHAL_V400R003_CalVdhClkSkip:
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
	ldr	r9, .L651
	ldr	r4, [r9, #64]
	cmp	r4, #0
	blt	.L647
	ldr	r10, .L651+4
	add	r6, r9, #64
	add	r9, r9, #124
	mov	r7, #30
	mov	r8, #0
.L628:
	mov	r0, r4
	bl	VCTRL_IsChanActive
	cmp	r0, #0
	bne	.L650
	ldr	r2, .L651+8
	mov	r0, r4
	ldr	r3, [r10, r4, asl #2]
	ldr	r2, [r2, r4, asl #2]
	ldr	r1, [r3, #28]
	ldr	r3, [r3, #32]
	adds	r4, r1, #15
	ldr	r2, [r2, #1496]
	addmi	r4, r1, #30
	adds	r5, r3, #15
	addmi	r5, r3, #30
	cmp	r2, #30
	mov	r4, r4, asr #4
	movgt	r7, r2
	mov	r5, r5, asr #4
	bl	VCTRL_GetVidStd
	cmp	r0, #17
	ldrls	pc, [pc, r0, asl #2]
	b	.L630
.L633:
	.word	.L642
	.word	.L642
	.word	.L642
	.word	.L642
	.word	.L630
	.word	.L642
	.word	.L642
	.word	.L630
	.word	.L642
	.word	.L642
	.word	.L642
	.word	.L642
	.word	.L642
	.word	.L642
	.word	.L630
	.word	.L643
	.word	.L642
	.word	.L642
.L642:
	mul	r4, r5, r4
	mla	r8, r7, r4, r8
.L630:
	cmp	r6, r9
	beq	.L649
	ldr	r4, [r6, #4]!
	cmp	r4, #0
	bge	.L628
.L649:
	mov	r3, r8, asl #8
	movw	r2, #23813
	sub	r8, r3, r8, asl #6
	movt	r2, 56143
	umull	r8, r9, r8, r2
	mov	r0, r9, lsr #21
	rsb	r0, r0, #32
	cmp	r0, #25
	movge	r0, #25
	bic	r0, r0, r0, asr #31
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L650:
	mov	r3, r4
	ldr	r2, .L651+12
	ldr	r1, .L651+16
	mov	r0, #1
	bl	dprint_vfmw
	b	.L630
.L643:
	mul	r4, r5, r4
	mul	r4, r7, r4
	add	r8, r8, r4, lsl #1
	b	.L630
.L647:
	mov	r0, #25
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L652:
	.align	2
.L651:
	.word	g_ChanCtx
	.word	s_pFspInst
	.word	s_pstVfmwChan
	.word	.LANCHOR0+576
	.word	.LC70
	.fnend
	.size	VDMHAL_V400R003_CalVdhClkSkip, .-VDMHAL_V400R003_CalVdhClkSkip
	.align	2
	.global	VDMHAL_V400R003_StartHwDecode
	.type	VDMHAL_V400R003_StartHwDecode, %function
VDMHAL_V400R003_StartHwDecode:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #8
	sub	sp, sp, #8
	push	{lr}
	bl	__gnu_mcount_nc
	subs	r5, r0, #0
	mov	r4, r1
	ble	.L654
	mov	r0, #0
	mov	r3, r5
	str	r0, [sp]
	ldr	r2, .L690
	ldr	r1, .L690+4
	bl	dprint_vfmw
.L653:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L654:
	ldr	r6, .L690+8
	ldrb	r3, [r6]
	cmp	r3, #1
	bne	.L685
	ldr	r3, .L690+12
	ldr	r2, [r3]
	ldr	r3, [r2, #120]
	bfc	r3, #8, #2
	str	r3, [r2, #120]
.L657:
	ldr	r2, .L690+16
	mov	r3, #44
	ldr	r9, .L690+20
	mla	r3, r3, r5, r2
	ldr	r7, [r3, #8]
	ldr	r3, [r9, r7, asl #2]
	ldr	r8, [r3, #1212]
	cmp	r8, #0
	movne	r3, #0
	beq	.L686
.L658:
	ldrb	r2, [r6]
	cmp	r2, #1
	bne	.L687
	ldr	r2, .L690+12
	ldr	r1, [r2]
	ldr	r2, [r1, #120]
	bfi	r2, r3, #12, #5
	bfc	r2, #17, #1
	str	r2, [r1, #120]
	ldr	r2, [r1, #120]
	orr	r2, r2, #131072
	str	r2, [r1, #120]
.L660:
	ldr	r1, [r9, r7, asl #2]
	mov	r2, r5
	mov	r3, r4
	mov	r0, #12
	ldr	r9, .L690+8
	ldr	r1, [r1, #592]
	cmp	r1, #16
	movne	r1, #3
	moveq	r1, #0
	bl	SCD_ConfigReg
	ldrb	r2, [r6]
	cmp	r2, #1
	bne	.L688
	movw	r2, #1224
	ldr	r3, .L690+24
	mul	r2, r2, r5
	ldr	r4, .L690+28
	ldr	r1, [r3]
	movw	r3, #43690
	bfi	r3, r3, #16, #16
	cmp	r1, #1
	ldr	r2, [r4, r2]
	moveq	r1, #7
	movne	r1, #0
	str	r3, [r2, #156]
.L663:
	movw	r2, #1224
	cmp	r8, #1
	mul	r2, r2, r5
	mvneq	r3, #5
	mvnne	r3, #1
	ldr	r2, [r4, r2]
	add	r2, r2, #61440
	str	r1, [r2, #32]
.L665:
	movw	r2, #1224
	mul	r2, r2, r5
	ldr	r2, [r4, r2]
	str	r3, [r2, #36]
.L667:
	ldr	r6, .L690+32
	mov	r0, #30
	ldr	r3, [r6, #112]
	blx	r3
	ldr	r3, [r6, #108]
	blx	r3
	movw	r3, #1224
	mul	r5, r3, r5
	mov	r3, #0
	mov	r1, #1
	ldr	r2, [r4, r5]
	str	r3, [r2]
	ldr	r2, [r4, r5]
	str	r1, [r2]
	ldr	r2, [r4, r5]
	str	r3, [r2]
	b	.L653
.L688:
	movw	r3, #43690
	mov	r1, #2
	mov	r2, #156
	movt	r3, 43690
	mov	r0, r4
	bl	VDH_Record_RegData
	ldr	r3, .L690+24
	ldrb	r2, [r9]
	ldr	r3, [r3]
	cmp	r3, #1
	moveq	r1, #7
	movne	r1, #0
	cmp	r2, #1
	ldreq	r4, .L690+28
	beq	.L663
	mov	r3, r1
	movw	r2, #61472
	mov	r0, r4
	mov	r1, #2
	bl	VDH_Record_RegData
	cmp	r8, #1
	ldrb	r2, [r6]
	mvneq	r3, #5
	mvnne	r3, #1
	cmp	r2, #1
	ldreq	r4, .L690+28
	beq	.L665
	mov	r0, r4
	mov	r2, #36
	mov	r1, #2
	bl	VDH_Record_RegData
	ldrb	r3, [r6]
	cmp	r3, #1
	ldreq	r4, .L690+28
	beq	.L667
	cmp	r4, #0
	beq	.L689
	mov	r3, #1
	str	r7, [r4, #8]
	strb	r5, [r4]
	mov	r0, r4
	str	r3, [r4, #4]
	bl	VDH_PostTask
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L687:
	mov	r2, #1
	mov	r1, #0
	mov	r0, r4
	bl	VDH_Record_RegData
	b	.L660
.L685:
	mov	r3, #0
	mov	r0, r1
	mov	r2, r3
	mov	r1, r3
	bl	VDH_Record_RegData
	b	.L657
.L686:
	mov	r0, r5
	bl	VDMHAL_V400R003_CalVdhClkSkip
	mov	r3, r0
	b	.L658
.L689:
	mov	r3, r4
	mov	r0, r4
	ldr	r2, .L690
	ldr	r1, .L690+36
	bl	dprint_vfmw
	b	.L653
.L691:
	.align	2
.L690:
	.word	.LANCHOR0+608
	.word	.LC25
	.word	g_HalDisable
	.word	g_pstRegCrg
	.word	g_VdmDrvParam
	.word	s_pstVfmwChan
	.word	mask_mmu_err_int
	.word	g_HwMem
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC69
	.fnend
	.size	VDMHAL_V400R003_StartHwDecode, .-VDMHAL_V400R003_StartHwDecode
	.align	2
	.global	VDMHAL_V400R003_GetCharacter
	.type	VDMHAL_V400R003_GetCharacter, %function
VDMHAL_V400R003_GetCharacter:
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
	ldr	r1, .L693
	ldr	r3, .L693+4
	mov	r0, #15
	mov	r2, #4
	str	r0, [r1]
	str	r2, [r3]
	ldmfd	sp, {fp, sp, pc}
.L694:
	.align	2
.L693:
	.word	g_VdmCharacter
	.word	g_eVdmVersion
	.fnend
	.size	VDMHAL_V400R003_GetCharacter, .-VDMHAL_V400R003_GetCharacter
	.align	2
	.global	VDMHAL_V400R003_WriteBigTitle1DYuv
	.type	VDMHAL_V400R003_WriteBigTitle1DYuv, %function
VDMHAL_V400R003_WriteBigTitle1DYuv:
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
	mov	r9, r3
	ubfx	r3, r3, #29, #2
	cmp	r3, #1
	mov	r4, #0
	str	r0, [fp, #-108]
	mov	r7, r1
	mov	r6, r2
	str	r4, [fp, #-92]
	str	r4, [fp, #-88]
	str	r4, [fp, #-84]
	str	r4, [fp, #-80]
	str	r4, [fp, #-76]
	str	r4, [fp, #-72]
	str	r4, [fp, #-68]
	str	r4, [fp, #-64]
	str	r4, [fp, #-60]
	str	r4, [fp, #-56]
	str	r4, [fp, #-52]
	str	r4, [fp, #-48]
	beq	.L696
	cmp	r3, #2
	moveq	r4, #1
	movne	r4, #2
.L696:
	ldr	r3, [fp, #-108]
	cmp	r3, #0
	beq	.L695
	mov	r3, #0
	mov	r2, #4194304
	mov	r1, r3
	str	r3, [sp]
	ldr	r0, .L786
	sub	r3, fp, #92
	bl	MEM_AllocMemBlock
	subs	r1, r0, #0
	beq	.L698
.L700:
	ldr	r1, .L786+4
	mov	r0, #1
	bl	dprint_vfmw
.L695:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L698:
	str	r1, [sp]
	mov	r2, #4194304
	sub	r3, fp, #68
	ldr	r0, .L786+8
	bl	MEM_AllocMemBlock
	cmp	r0, #0
	bne	.L700
	add	r10, r9, #15
	add	r5, r6, #15
	bic	r3, r10, #15
	bic	r5, r5, #15
	str	r3, [fp, #-100]
	mov	ip, r6, lsr #1
	mov	r1, r3
	add	r3, r5, #255
	bic	r3, r3, #255
	ldr	r2, [fp, #-64]
	str	ip, [fp, #-120]
	mov	ip, r9, lsr #1
	mov	r3, r3, asl #4
	str	r3, [fp, #-104]
	str	r2, [fp, #-112]
	add	r2, r2, #2097152
	str	r2, [fp, #-124]
	mov	r2, r3
	cmp	r2, #0
	add	r3, r3, #15
	str	ip, [fp, #-116]
	movge	r3, r2
	adds	r2, r1, #31
	addmi	r2, r1, #62
	mov	r3, r3, asr #4
	cmp	r4, #0
	cmpne	r4, #3
	ldr	r6, [fp, #-88]
	mov	r2, r2, asr #5
	mla	r3, r2, r3, r7
	str	r3, [fp, #-128]
	bne	.L701
	cmp	r1, #0
	movne	r8, r0
	ldrne	r10, .L786+12
	strne	r8, [fp, #-96]
	beq	.L783
.L702:
	cmp	r5, #0
	beq	.L706
	ldr	r2, [fp, #-96]
	mov	r4, #0
	and	r9, r2, #15
	mov	r3, r2, lsr #4
	ldr	r2, [fp, #-104]
	mul	r3, r2, r3
	add	r9, r3, r9, lsl #8
.L704:
	mov	r1, r4, lsr #8
	add	r0, r8, r4
	add	r0, r6, r0
	add	r4, r4, #256
	add	r1, r9, r1, lsl #12
	ldr	r3, [r10, #52]
	add	r1, r7, r1
	mov	r2, #256
	blx	r3
	cmp	r5, r4
	bhi	.L704
.L706:
	ldr	r3, [fp, #-96]
	add	r8, r8, r5
	ldr	r2, [fp, #-100]
	add	r3, r3, #1
	str	r3, [fp, #-96]
	cmp	r2, r3
	bne	.L702
	ldr	r4, [fp, #-100]
	mov	r0, r6
	ldr	ip, [r10, #44]
	ldr	r2, [fp, #-108]
	mul	r1, r4, r5
	blx	ip
	movs	r3, r4, lsr #1
	str	r3, [fp, #-100]
	beq	.L737
	ldr	r3, [fp, #-104]
	mov	r7, #0
	ldr	r8, [fp, #-128]
	str	r7, [fp, #-96]
	mov	r3, r3, asr #1
	str	r3, [fp, #-104]
.L708:
	cmp	r5, #0
	beq	.L710
	ldr	r2, [fp, #-96]
	mov	r4, #0
	and	r9, r2, #7
	mov	r3, r2, lsr #3
	ldr	r2, [fp, #-104]
	mul	r3, r2, r3
	add	r9, r3, r9, lsl #8
.L709:
	mov	r1, r4, lsr #8
	add	r0, r7, r4
	add	r0, r6, r0
	add	r4, r4, #256
	add	r1, r9, r1, lsl #11
	ldr	r3, [r10, #52]
	add	r1, r8, r1
	mov	r2, #256
	blx	r3
	cmp	r5, r4
	bhi	.L709
.L710:
	ldr	r3, [fp, #-96]
	add	r7, r7, r5
	ldr	r2, [fp, #-100]
	add	r3, r3, #1
	str	r3, [fp, #-96]
	cmp	r3, r2
	bne	.L708
.L737:
	ldr	r3, [fp, #4]
	cmp	r3, #1
	beq	.L784
	ldr	r3, [fp, #4]
	cmp	r3, #0
	beq	.L735
.L730:
	ldr	r3, [fp, #-116]
	ldr	r2, [fp, #-120]
	ldr	r5, [fp, #-108]
	ldr	ip, [r10, #44]
	mul	r4, r3, r2
	ldr	r0, [fp, #-112]
	mov	r2, r5
	mov	r1, r4
	blx	ip
	mov	r2, r5
	ldr	ip, [r10, #44]
	mov	r1, r4
	ldr	r0, [fp, #-124]
	blx	ip
	ldr	r1, [fp, #-88]
	ldr	r0, [fp, #-84]
	bl	MEM_ReleaseMemBlock
	ldr	ip, [r10, #48]
	mov	r2, #24
	sub	r0, fp, #92
	mov	r1, #0
	blx	ip
	ldr	r1, [fp, #-64]
	ldr	r0, [fp, #-60]
	bl	MEM_ReleaseMemBlock
	ldr	r3, [r10, #48]
	sub	r0, fp, #68
	mov	r2, #24
	mov	r1, #0
	blx	r3
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L701:
	subs	r3, r4, #1
	ldr	r2, [fp, #-100]
	ldr	r10, .L786+12
	movne	r3, #1
	cmp	r2, r3
	str	r3, [fp, #-132]
	ldrhi	r3, [fp, #-132]
	strhi	r3, [fp, #-96]
	bls	.L720
.L722:
	cmp	r5, #0
	beq	.L723
	ldr	r2, [fp, #-96]
	mov	r4, #0
	and	r8, r2, #15
	mov	r3, r2, lsr #4
	mov	r9, r2, lsr #1
	ldr	r2, [fp, #-104]
	mul	r9, r5, r9
	mul	r3, r2, r3
	add	r8, r3, r8, lsl #8
.L721:
	mov	r1, r4, lsr #8
	add	r0, r4, r9
	add	r0, r6, r0
	add	r4, r4, #256
	add	r1, r8, r1, lsl #12
	ldr	r3, [r10, #52]
	add	r1, r7, r1
	mov	r2, #256
	blx	r3
	cmp	r5, r4
	bhi	.L721
.L723:
	ldr	r3, [fp, #-96]
	ldr	r2, [fp, #-100]
	add	r3, r3, #2
	str	r3, [fp, #-96]
	cmp	r2, r3
	bhi	.L722
.L720:
	ldr	r4, [fp, #-100]
	mov	r0, r6
	ldr	ip, [r10, #44]
	ldr	r2, [fp, #-108]
	mul	r1, r4, r5
	mov	r1, r1, lsr #1
	blx	ip
	movs	r3, r4, lsr #1
	str	r3, [fp, #-100]
	beq	.L724
	ldr	r3, [fp, #-104]
	mov	r7, #0
	ldr	r8, [fp, #-128]
	str	r7, [fp, #-96]
	mov	r3, r3, asr #1
	str	r3, [fp, #-104]
.L725:
	cmp	r5, #0
	beq	.L727
	ldr	r2, [fp, #-96]
	mov	r4, #0
	and	r9, r2, #7
	mov	r3, r2, lsr #3
	ldr	r2, [fp, #-104]
	mul	r3, r2, r3
	add	r9, r3, r9, lsl #8
.L726:
	mov	r1, r4, lsr #8
	add	r0, r7, r4
	add	r0, r6, r0
	add	r4, r4, #256
	add	r1, r9, r1, lsl #11
	ldr	r3, [r10, #52]
	add	r1, r8, r1
	mov	r2, #256
	blx	r3
	cmp	r5, r4
	bhi	.L726
.L727:
	ldr	r3, [fp, #-96]
	add	r7, r7, r5
	ldr	r2, [fp, #-100]
	add	r3, r3, #1
	str	r3, [fp, #-96]
	cmp	r3, r2
	bne	.L725
.L724:
	ldr	r3, [fp, #4]
	cmp	r3, #1
	beq	.L785
	ldr	r3, [fp, #4]
	cmp	r3, #0
	bne	.L730
	ldr	r2, [fp, #-116]
	ldr	r3, [fp, #-132]
	cmp	r2, r3
	bls	.L735
.L736:
	add	r3, r3, #2
	cmp	r2, r3
	bhi	.L736
.L735:
	ldr	ip, [r10, #48]
	mov	r2, #1048576
	mov	r1, #128
	ldr	r0, [fp, #-124]
	blx	ip
	ldr	ip, [r10, #48]
	mov	r2, #1048576
	mov	r1, #128
	ldr	r0, [fp, #-112]
	blx	ip
	b	.L730
.L785:
	ldr	r3, [fp, #-116]
	cmp	r3, #0
	beq	.L730
	ldr	r2, [fp, #-132]
	mov	r4, #0
	ldr	r0, [fp, #-120]
	mov	lr, r3
	ldr	ip, [fp, #-112]
	mla	r6, r5, r2, r6
	mov	r5, r5, asl #1
	add	r6, r6, #1
.L731:
	cmp	r0, #0
	beq	.L734
	mov	r3, r4, lsr #1
	mov	r2, r6
	mul	r3, r0, r3
	sub	r1, r3, #-67108863
	add	r8, r3, r0
	sub	r1, r1, #65011712
	add	r8, ip, r8
	add	r1, ip, r1
	add	r3, ip, r3
.L732:
	ldrb	r7, [r2, #-1]
	strb	r7, [r1, #1]!
	ldrb	r7, [r2], #2
	strb	r7, [r3], #1
	cmp	r3, r8
	bne	.L732
.L734:
	add	r4, r4, #2
	add	r6, r6, r5
	cmp	lr, r4
	bhi	.L731
	b	.L730
.L784:
	ldr	r3, [fp, #-116]
	cmp	r3, #0
	beq	.L730
	ldr	r2, [fp, #-112]
	add	r6, r6, #1
	ldr	lr, [fp, #-120]
	mov	r7, r3
	mov	r4, #0
	mov	r3, r2
.L714:
	cmp	lr, #0
	moveq	ip, r3
	beq	.L717
	sub	r1, r3, #-67108863
	add	ip, r3, lr
	sub	r1, r1, #65011712
	mov	r2, r6
.L715:
	ldrb	r0, [r2, #-1]
	strb	r0, [r1, #1]!
	ldrb	r0, [r2], #2
	strb	r0, [r3], #1
	cmp	ip, r3
	bne	.L715
.L717:
	add	r4, r4, #1
	mov	r3, ip
	cmp	r4, r7
	add	r6, r6, r5
	bne	.L714
	b	.L730
.L783:
	ldr	r10, .L786+12
	mov	r0, r6
	ldr	r1, [fp, #-100]
	ldr	r2, [fp, #-108]
	ldr	ip, [r10, #44]
	blx	ip
	b	.L737
.L787:
	.align	2
.L786:
	.word	.LC71
	.word	.LC72
	.word	.LC73
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VDMHAL_V400R003_WriteBigTitle1DYuv, .-VDMHAL_V400R003_WriteBigTitle1DYuv
	.align	2
	.global	CRG_ConfigReg
	.type	CRG_ConfigReg, %function
CRG_ConfigReg:
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
	ldr	ip, .L794
	mov	lr, r2
	ldrb	ip, [ip]
	cmp	ip, #1
	bne	.L793
	cmp	r0, #0
	bne	.L791
	ldr	r3, .L794+4
	ldr	r3, [r3]
	ldr	r2, [r3, #120]
	bfi	r2, r1, #8, #2
	str	r2, [r3, #120]
	ldmfd	sp, {fp, sp, pc}
.L791:
	cmp	r0, #1
	ldmnefd	sp, {fp, sp, pc}
	ldr	r3, .L794+4
	ldr	r3, [r3]
	ldr	r2, [r3, #120]
	bfi	r2, r1, #12, #5
	bfc	r2, #17, #1
	str	r2, [r3, #120]
	ldr	r2, [r3, #120]
	orr	r2, r2, #131072
	str	r2, [r3, #120]
	ldmfd	sp, {fp, sp, pc}
.L793:
	mov	r3, r1
	mov	r2, r0
	mov	r1, #0
	mov	r0, lr
	bl	VDH_Record_RegData
	ldmfd	sp, {fp, sp, pc}
.L795:
	.align	2
.L794:
	.word	g_HalDisable
	.word	g_pstRegCrg
	.fnend
	.size	CRG_ConfigReg, .-CRG_ConfigReg
	.align	2
	.global	MFDE_ConfigReg
	.type	MFDE_ConfigReg, %function
MFDE_ConfigReg:
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
	ldr	ip, .L802
	mov	lr, r3
	ldrb	ip, [ip]
	cmp	ip, #1
	bne	.L800
	cmp	r2, #0
	ble	.L801
	mov	r3, r2
	str	ip, [sp]
	ldr	r2, .L802+4
	mov	r0, #32
	ldr	r1, .L802+8
	bl	dprint_vfmw
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L801:
	movw	r3, #1224
	ldr	ip, .L802+12
	mul	r2, r3, r2
	ldr	r3, [ip, r2]
	str	r1, [r3, r0]
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L800:
	mov	r3, r1
	mov	r2, r0
	mov	r1, #2
	mov	r0, lr
	bl	VDH_Record_RegData
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L803:
	.align	2
.L802:
	.word	g_HalDisable
	.word	.LANCHOR0+528
	.word	.LC30
	.word	g_HwMem
	.fnend
	.size	MFDE_ConfigReg, .-MFDE_ConfigReg
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	__func__.57489, %object
	.size	__func__.57489, 24
__func__.57489:
	.ascii	"VDMHAL_V400R003_OpenHAL\000"
	.type	__func__.57526, %object
	.size	__func__.57526, 27
__func__.57526:
	.ascii	"VDMHAL_V400R003_CalcFsSize\000"
	.space	1
	.type	__func__.57595, %object
	.size	__func__.57595, 27
__func__.57595:
	.ascii	"VDMHAL_V400R003_ArrangeMem\000"
	.space	1
	.type	__FUNCTION__.57596, %object
	.size	__FUNCTION__.57596, 27
__FUNCTION__.57596:
	.ascii	"VDMHAL_V400R003_ArrangeMem\000"
	.space	1
	.type	__func__.57540, %object
	.size	__func__.57540, 35
__func__.57540:
	.ascii	"VDMHAL_V400R003_FillMemArrangeInfo\000"
	.space	1
	.type	__func__.57623, %object
	.size	__func__.57623, 25
__func__.57623:
	.ascii	"VDMHAL_V400R003_ResetVdm\000"
	.space	3
	.type	__func__.57636, %object
	.size	__func__.57636, 37
__func__.57636:
	.ascii	"VDMHAL_V400R003_SetSmmuPageTableAddr\000"
	.space	3
	.type	__func__.57657, %object
	.size	__func__.57657, 26
__func__.57657:
	.ascii	"VDMHAL_V400R003_GlbResetX\000"
	.space	2
	.type	__func__.57646, %object
	.size	__func__.57646, 25
__func__.57646:
	.ascii	"VDMHAL_V400R003_GlbReset\000"
	.space	3
	.type	__func__.57714, %object
	.size	__func__.57714, 25
__func__.57714:
	.ascii	"VDMHAL_V400R003_CheckReg\000"
	.space	3
	.type	__func__.57731, %object
	.size	__func__.57731, 28
__func__.57731:
	.ascii	"VDMHAL_V400R003_ReadMMUMask\000"
	.type	__func__.57736, %object
	.size	__func__.57736, 29
__func__.57736:
	.ascii	"VDMHAL_V400R003_WriteMMUMask\000"
	.space	3
	.type	__func__.57743, %object
	.size	__func__.57743, 27
__func__.57743:
	.ascii	"VDMHAL_V400R003_PrepareDec\000"
	.space	1
	.type	__func__.57765, %object
	.size	__func__.57765, 27
__func__.57765:
	.ascii	"VDMHAL_V400R003_IsVdmReady\000"
	.space	1
	.type	__func__.57770, %object
	.size	__func__.57770, 25
__func__.57770:
	.ascii	"VDMHAL_V400R003_IsVdmRun\000"
	.space	3
	.type	__func__.57784, %object
	.size	__func__.57784, 27
__func__.57784:
	.ascii	"VDMHAL_V400R003_BackupInfo\000"
	.space	1
	.type	__func__.57833, %object
	.size	__func__.57833, 25
__func__.57833:
	.ascii	"VDMHAL_V400R003_CfgRpMsg\000"
	.space	3
	.type	__func__.57867, %object
	.size	__func__.57867, 30
__func__.57867:
	.ascii	"VDMHAL_V400R003_MakeDecReport\000"
	.space	2
	.type	__func__.58030, %object
	.size	__func__.58030, 15
__func__.58030:
	.ascii	"MFDE_ConfigReg\000"
	.space	1
	.type	__func__.57901, %object
	.size	__func__.57901, 30
__func__.57901:
	.ascii	"VDMHAL_V400R003_StartHwRepair\000"
	.space	2
	.type	__func__.57917, %object
	.size	__func__.57917, 30
__func__.57917:
	.ascii	"VDMHAL_V400R003_CalVdhClkSkip\000"
	.space	2
	.type	__func__.57948, %object
	.size	__func__.57948, 30
__func__.57948:
	.ascii	"VDMHAL_V400R003_StartHwDecode\000"
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"pOpenParam = NULL error!\000"
	.space	3
.LC1:
	.ascii	"%s: %s\012\000"
.LC2:
	.ascii	"MemBaseAddr = 0 error!\000"
	.space	1
.LC3:
	.ascii	"VDMHAL_V400R003_OpenHAL: Size error!\000"
	.space	3
.LC4:
	.ascii	"VdhId is wrong!!!\012\000"
	.space	1
.LC5:
	.ascii	"g_VdmRegVirAddr, g_VdmResetVirAddr = %p\012\000"
	.space	3
.LC6:
	.ascii	"BPDRegVirAddr %p\012\000"
	.space	2
.LC7:
	.ascii	"VdhId is wrong! VDMHAL_V200R003_OpenHAL\012\000"
	.space	3
.LC8:
	.ascii	"!!!!!! HAL memory not enouph! need %d, have %d\012\000"
.LC9:
	.ascii	"image size out of range\000"
.LC10:
	.ascii	"VDMHAL ArrangeMem HEVC 10 bit\012\000"
	.space	1
.LC11:
	.ascii	"VidStd Invalid\000"
	.space	1
.LC12:
	.ascii	"VDMHAL_V400R003_CalcFsSize err!\012\000"
	.space	3
.LC13:
	.ascii	"%s, need arrange, Size: %#x, Num: %#x, RefChanged: "
	.ascii	"%#x\012\000"
.LC14:
	.ascii	"DelAllFrameMemRecord err in VDMHAL_V400R003_Arrange"
	.ascii	"Mem!\012\000"
	.space	3
.LC15:
	.ascii	"DFS, report event. Size: %#x, Num: %#x, RefChanged:"
	.ascii	" %#x\012\000"
	.space	3
.LC16:
	.ascii	"pVdmMemArrange is NULL\000"
	.space	1
.LC17:
	.ascii	"DFS, no ref frame!\012\000"
.LC18:
	.ascii	"DFS, Frame number = %d > 30, Then, Frame num = 30, "
	.ascii	"\012\000"
	.space	3
.LC19:
	.ascii	"VDMHAL_V400R003_ArrangeMem Mem addr is NULL\000"
.LC20:
	.ascii	"'pVdmMemArrange' is NULL\000"
	.space	3
.LC21:
	.ascii	"MemSize not enough for pmv slot\000"
.LC22:
	.ascii	"VDMHAL_V200R003_ArrangeMem get ChanWidth/ChanHeight"
	.ascii	" failed!\012\000"
	.space	3
.LC23:
	.ascii	"ImgSlotLen > ChanSlotLen\000"
	.space	3
.LC24:
	.ascii	"cann't allocate img slot\000"
	.space	3
.LC25:
	.ascii	"%s: VdhId(%d) > %d\012\000"
.LC26:
	.ascii	"VdhId is wrong! VDMHAL_V400R003_ResetVdm\012\000"
	.space	2
.LC27:
	.ascii	"VDMHAL_V400R003_ResetVdm: map vdm register fail, vi"
	.ascii	"r(reg) = (%p)\012\000"
	.space	2
.LC28:
	.ascii	"%s module id %d failed!\012\000"
	.space	3
.LC29:
	.ascii	"%s module id %d success!\012\000"
	.space	2
.LC30:
	.ascii	"%s: WR_VREG but VdhId(%d) > MAX_VDH_NUM(%d)\012\000"
	.space	3
.LC31:
	.ascii	"%s: map vdm register 0x%x failed!\012\000"
	.space	1
.LC32:
	.ascii	"%s VdhId %d failed!\012\000"
	.space	3
.LC33:
	.ascii	"%s VdhId %d success!\012\000"
	.space	2
.LC34:
	.ascii	"GLB Reset failed, wrong VDH ID!\012\000"
	.space	3
.LC35:
	.ascii	"VdhId is wrong! VDMHAL_V200R003_ClearIntState\012\000"
	.space	1
.LC36:
	.ascii	"vdm register virtual address not mapped, reset fail"
	.ascii	"ed!\012\000"
.LC37:
	.ascii	"VdhId is wrong! VDMHAL_V200_MaskInt\012\000"
	.space	3
.LC38:
	.ascii	"VdhId is wrong! VDMHAL_V200R003_EnableInt\012\000"
	.space	1
.LC39:
	.ascii	"%s: VdhId(%d) Invalid!\012\000"
.LC40:
	.ascii	"%s: VdhId is wrong!\012\000"
	.space	3
.LC41:
	.ascii	"%s: vdm register virtual address not mapped, reset "
	.ascii	"failed!\012\000"
.LC42:
	.ascii	"%s: unkown reg_id = %d\012\000"
.LC43:
	.ascii	"%s: RD_VREG but VdhId(%d) > MAX_VDH_NUM(%d)\012\000"
	.space	3
.LC44:
	.ascii	"%s: pDecParam(%p) = NULL\012\000"
	.space	2
.LC45:
	.ascii	"VDM register not mapped yet!\000"
	.space	3
.LC46:
	.ascii	"VDM register not mapped yet!\012\000"
	.space	2
.LC47:
	.ascii	"pBackUpInfo = NULL!\000"
.LC48:
	.ascii	"VdhId is wrong! VDMHAL_V200R003_BackupInfo\012\000"
.LC49:
	.ascii	"can NOT map vir addr for up-msg\000"
.LC50:
	.ascii	"ReadUpMsgSlot error! pDst=%p, pSrc=%p\012\000"
	.space	1
.LC51:
	.ascii	"ReadUpMsgSlot error! upmsg_size(%d) > 512\012\000"
	.space	1
.LC52:
	.ascii	"WriteMsgSlot error!\012\000"
	.space	3
.LC53:
	.ascii	"can not map repair msg virtual address!\000"
.LC54:
	.ascii	"ValidGroupNum=%d out of range!\012\000"
.LC55:
	.ascii	"align_mb error\012\000"
.LC56:
	.ascii	"[%s][%d]sclie_num is wrong! %d \012\000"
	.space	3
.LC57:
	.ascii	"VdhId is wrong! VDMHAL_V400_CfgRpReg\012\000"
	.space	2
.LC58:
	.ascii	"'pMakeDecReport' is NULL\000"
	.space	3
.LC59:
	.ascii	"'pDecReport' is NULL\000"
	.space	3
.LC60:
	.ascii	"pDecReport->DecSliceNum(%d) > %d, set to 0 for full"
	.ascii	" repair.\012\000"
	.space	3
.LC61:
	.ascii	"\012***** UpMsg DecSliceNum=%d\012\000"
	.space	3
.LC62:
	.ascii	"\012***** Up Msg (phy addr: %#8x) *****\012\000"
	.space	2
.LC63:
	.ascii	"\0120x%02x 0x%08x 0x%08x 0x%08x 0x%08x\012\000"
	.space	3
.LC64:
	.ascii	"\012***** Up Msg print finished *****\012\000"
.LC65:
	.ascii	"VdhId is wrong! VDMHAL_V200R003_PrepareRepair\012\000"
	.space	1
.LC66:
	.ascii	"vdm register virtual address not mapped, VDMHAL_V20"
	.ascii	"0R003_PrepareRepair failed!\012\000"
.LC67:
	.ascii	"FIRST_REPAIR Parameter Error!\012\000"
	.space	1
.LC68:
	.ascii	"SECOND_REPAIR Parameter Error!\012\000"
.LC69:
	.ascii	"%s: pMfdeTask(%p) = NULL\012\000"
	.space	2
.LC70:
	.ascii	"%s The channel %d is not active\012\000"
	.space	3
.LC71:
	.ascii	"BigTile1d_y\000"
.LC72:
	.ascii	"failed mem_allocMemBlock BigTile_yuv save!\012\000"
.LC73:
	.ascii	"BigTile1d_uv\000"
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
