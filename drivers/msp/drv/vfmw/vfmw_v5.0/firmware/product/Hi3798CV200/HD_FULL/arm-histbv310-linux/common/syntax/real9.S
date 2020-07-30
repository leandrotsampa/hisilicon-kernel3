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
	.file	"real9.c"

	.text
	.align	2
	.global	Real9_CB_GetBits
	.type	Real9_CB_GetBits, %function
Real9_CB_GetBits:
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
	mov	r6, r1
	bl	BsShow
	mov	r1, r6
	mov	r4, r0
	mov	r0, r5
	bl	BsSkip
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	Real9_CB_GetBits, .-Real9_CB_GetBits
	.align	2
	.global	Real9_CB_Get1Bit
	.type	Real9_CB_Get1Bit, %function
Real9_CB_Get1Bit:
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
	mov	r1, #1
	mov	r5, r0
	bl	BsShow
	mov	r1, #1
	mov	r4, r0
	mov	r0, r5
	bl	BsSkip
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	Real9_CB_Get1Bit, .-Real9_CB_Get1Bit
	.align	2
	.global	Real9_CB_GetVLCBits
	.type	Real9_CB_GetVLCBits, %function
Real9_CB_GetVLCBits:
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
	ldr	r7, .L8
	mov	r4, #0
	mov	r6, r0
	mov	r8, r1
	mov	r5, r4
.L4:
	mov	r1, #8
	mov	r0, r6
	bl	BsShow
	ldrb	r3, [r7, r0]
	mov	r0, r6
	and	r2, r3, #15
	mov	r1, r3, lsr #4
	mov	r3, r3, lsr #5
	add	r4, r4, r1
	orr	r5, r2, r5, asl r3
	bl	BsSkip
	tst	r4, #1
	beq	.L4
	str	r5, [r8]
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L9:
	.align	2
.L8:
	.word	.LANCHOR0
	.fnend
	.size	Real9_CB_GetVLCBits, .-Real9_CB_GetVLCBits
	.align	2
	.global	Real9_GetImageBuffer
	.type	Real9_GetImageBuffer, %function
Real9_GetImageBuffer:
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
	add	r4, r0, #49152
	mov	r6, r0
	mov	r1, #1
	add	r7, r0, #8192
	ldr	r0, [r4, #2968]
	bl	FSP_NewLogicFs
	cmp	r0, #0
	str	r0, [r4, #2568]
	blt	.L17
	mov	r1, r0
	ldr	r0, [r4, #2968]
	bl	FSP_GetLogicFs
	subs	r5, r0, #0
	beq	.L18
	ldr	r2, [r4, #2568]
	mov	r0, #18
	ldr	r1, .L19
	bl	dprint_vfmw
	ldr	r2, [r5, #608]
	cmp	r2, #0
	beq	.L16
	ldr	r3, [r5, #612]
	cmp	r3, #0
	beq	.L16
	ldr	r1, [r5, #616]
	cmp	r1, #0
	beq	.L16
	ldr	ip, [r1, #16]
	mov	r0, #18
	ldr	r3, [r3, #16]
	ldr	r2, [r2, #16]
	ldr	r1, .L19+4
	str	ip, [sp]
	bl	dprint_vfmw
	mov	r0, #1
.L12:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L16:
	mov	r0, #1
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L17:
	ldr	r1, .L19+8
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r1, [r4, #2564]
	ldr	r0, [r4, #2968]
	mov	r2, #1
	bl	FSP_ClearLogicFs
	mov	r2, #1
	ldr	r1, [r4, #2560]
	mov	r5, #0
	ldr	r0, [r4, #2968]
	bl	FSP_ClearLogicFs
	str	r5, [r4, #2560]
	str	r5, [r4, #2564]
	ldr	r0, [r4, #2968]
	bl	FSP_GetNullLogicFs
	add	r1, r6, #51712
	add	r1, r1, #56
	str	r0, [r4, #2564]
	str	r0, [r4, #2560]
	strb	r5, [r7, #3189]
	ldr	r0, [r4, #2968]
	bl	FSP_ClearNotInVoQueue
	mov	r0, r5
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L18:
	movw	r2, #566
	ldr	r1, .L19+12
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r5
	b	.L12
.L20:
	.align	2
.L19:
	.word	.LC5
	.word	.LC6
	.word	.LC3
	.word	.LC4
	.fnend
	.size	Real9_GetImageBuffer, .-Real9_GetImageBuffer
	.align	2
	.global	Real9_ArrangeVHBMem
	.type	Real9_ArrangeVHBMem, %function
Real9_ArrangeVHBMem:
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
	mov	r4, r2
	ldr	r2, [r2, #24]
	mov	r5, r1
	ldr	r3, [r4, #20]
	cmp	r2, #1
	bls	.L23
	cmp	r3, #1
	bls	.L23
	ldr	r1, [r1]
	ldr	r3, [r1, #700]
	cmp	r3, #0
	ldr	r3, [r1, #28]
	bne	.L26
	cmp	r3, #25
	beq	.L47
.L27:
	ldr	r9, [r4, #16]
	mov	r7, #5
	ldr	r10, [r4, #12]
	mov	r6, #2
	mov	r8, #4
.L32:
	ldr	r3, .L53
	mov	r2, #32
	mov	r1, #0
	sub	r0, fp, #76
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r0, [r4, #12]
	ldr	r1, [r5]
	mov	r3, #0
	ldr	r2, [r4, #16]
	str	r0, [fp, #-48]
	ldr	r1, [r1, #28]
	str	r9, [fp, #-68]
	cmp	r1, #24
	str	r10, [fp, #-64]
	str	r2, [fp, #-52]
	strb	r3, [fp, #-75]
	beq	.L38
	uxtb	r3, r6
	strb	r8, [fp, #-73]
	strb	r7, [fp, #-71]
.L40:
	add	r6, r5, #49152
	sub	r1, fp, #76
	strb	r3, [fp, #-70]
	mov	r4, #0
	ldr	r0, [r6, #2968]
	strb	r4, [fp, #-74]
	bl	FSP_ConfigInstance
	subs	r7, r0, #0
	beq	.L48
.L46:
	mov	r0, #0
.L45:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L26:
	cmp	r3, #25
	bne	.L27
	ldr	r2, [r4, #16]
	ldr	r0, [r1, #660]
	cmp	r2, r0
	bhi	.L49
	ldr	r3, [r4, #12]
	ldr	ip, [r1, #664]
	cmp	r3, ip
	bhi	.L35
	ldr	r0, [r1, #688]
	mov	r9, r2
	ldr	r6, [r1, #684]
	mov	r10, r3
	cmp	r0, #0
	add	r8, r6, #2
	bne	.L50
.L43:
	mov	r6, #1
.L37:
	ldrb	r7, [r1, #708]
	b	.L32
.L23:
	ldr	r1, .L53+4
	mov	r0, #0
	bl	dprint_vfmw
	b	.L46
.L48:
	ldr	r1, [r5]
	sub	r3, fp, #80
	ldr	r0, [r6, #2968]
	ldr	r2, [r1, #24]
	ldr	r1, [r1, #20]
	bl	FSP_ConfigFrameBuf
	cmp	r0, r4
	bne	.L51
	add	r5, r5, #8192
	mov	r3, #1
	mov	r0, r3
	strb	r3, [r5, #3192]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L38:
	mov	r3, #1
	strb	r7, [fp, #-71]
	strb	r3, [fp, #-73]
	b	.L40
.L47:
	ldr	r2, [r4, #16]
	ldr	r9, [r1, #660]
	cmp	r2, r9
	bhi	.L52
	ldr	r3, [r4, #12]
	ldr	r10, [r1, #664]
	cmp	r3, r10
	bhi	.L29
	add	r3, r5, #8192
	ldrb	r0, [r3, #3192]
	cmp	r0, #1
	beq	.L45
	ldr	r2, [r1, #688]
	ldr	r3, [r1, #684]
	cmp	r2, #0
	add	r8, r3, #2
	beq	.L43
	add	r3, r3, #1
	cmp	r3, #17
	movlt	r6, r3
	movge	r6, #17
	b	.L37
.L49:
	ldr	ip, [r1, #664]
	ldr	r3, [r4, #12]
.L35:
	stmia	sp, {r0, ip}
	mov	r0, #0
	ldr	r1, .L53+8
	bl	dprint_vfmw
	mov	r0, #0
	b	.L45
.L52:
	ldr	r10, [r1, #664]
	ldr	r3, [r4, #12]
.L29:
	stmia	sp, {r9, r10}
	mov	r0, #0
	ldr	r1, .L53+8
	bl	dprint_vfmw
	mov	r0, #0
	b	.L45
.L51:
	ldr	r1, .L53+12
	mov	r0, r7
	bl	dprint_vfmw
	mov	r0, r7
	b	.L45
.L50:
	add	r3, r6, #1
	cmp	r3, #17
	movlt	r6, r3
	movge	r6, #17
	b	.L37
.L54:
	.align	2
.L53:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.fnend
	.size	Real9_ArrangeVHBMem, .-Real9_ArrangeVHBMem
	.align	2
	.global	Real9_CB_GetCPFMT
	.type	Real9_CB_GetCPFMT, %function
Real9_CB_GetCPFMT:
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
	mov	r6, r1
	mov	r1, #4
	mov	r5, r0
	bl	BsShow
	mov	r1, #4
	mov	r4, r0
	mov	r0, r5
	bl	BsSkip
	strb	r4, [r6]
	mov	r1, #9
	mov	r0, r5
	bl	BsShow
	mov	r1, #9
	mov	r4, r0
	add	r4, r4, #1
	mov	r0, r5
	bl	BsSkip
	mov	r4, r4, asl #2
	mov	r0, r5
	str	r4, [r6, #16]
	bl	Real9_CB_Get1Bit
	cmp	r0, #1
	mov	r4, r0
	beq	.L58
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L58:
	mov	r1, #9
	mov	r0, r5
	bl	BsShow
	mov	r1, #9
	mov	r7, r0
	mov	r0, r5
	bl	BsSkip
	mov	r7, r7, asl #2
	mov	r0, r4
	str	r7, [r6, #12]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	Real9_CB_GetCPFMT, .-Real9_CB_GetCPFMT
	.align	2
	.global	Real9_CB_SetDimensions
	.type	Real9_CB_SetDimensions, %function
Real9_CB_SetDimensions:
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
	ldr	r3, [r0, #16]
	ldr	r2, [r0, #12]
	cmp	r3, #128
	beq	.L76
	cmp	r3, #176
	beq	.L77
	cmp	r3, #352
	beq	.L78
	cmp	r3, #704
	beq	.L79
	cmp	r3, #1408
	beq	.L80
.L61:
	add	r3, r3, #15
	add	r2, r2, #15
	mov	r3, r3, lsr #4
	mov	r2, r2, lsr #4
	str	r3, [r0, #76]
	mul	r3, r3, r2
	str	r2, [r0, #72]
	sub	r3, r3, #1
	cmp	r3, #47
	movls	r2, #0
	bls	.L62
	cmp	r3, #98
	bls	.L71
	cmp	r3, #396
	bcc	.L72
	cmp	r3, #1584
	bcc	.L73
	cmp	r3, #6336
	movcs	r2, #5
	bcc	.L75
.L62:
	ldr	r3, .L81
	add	r3, r3, r2, lsl #2
	ldr	r3, [r3, #256]
	str	r3, [r0, #80]
	ldmfd	sp, {fp, sp, pc}
.L80:
	cmp	r2, #1152
	bne	.L61
	mov	r2, #88
	mov	r3, #72
	str	r2, [r0, #76]
	str	r3, [r0, #72]
.L75:
	mov	r2, #4
	b	.L62
.L76:
	cmp	r2, #96
	bne	.L61
	mov	r2, #8
	mov	r3, #6
	str	r2, [r0, #76]
	mov	r2, #0
	str	r3, [r0, #72]
	b	.L62
.L77:
	cmp	r2, #144
	bne	.L61
	mov	r2, #11
	mov	r3, #9
	str	r2, [r0, #76]
	str	r3, [r0, #72]
.L71:
	mov	r2, #1
	b	.L62
.L78:
	cmp	r2, #288
	bne	.L61
	mov	r2, #22
	mov	r3, #18
	str	r2, [r0, #76]
	str	r3, [r0, #72]
.L72:
	mov	r2, #2
	b	.L62
.L79:
	cmp	r2, #576
	bne	.L61
	mov	r2, #44
	mov	r3, #36
	str	r2, [r0, #76]
	str	r3, [r0, #72]
.L73:
	mov	r2, #3
	b	.L62
.L82:
	.align	2
.L81:
	.word	.LANCHOR0
	.fnend
	.size	Real9_CB_SetDimensions, .-Real9_CB_SetDimensions
	.align	2
	.global	Real9_CB_GetPicSize
	.type	Real9_CB_GetPicSize, %function
Real9_CB_GetPicSize:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #84
	sub	sp, sp, #84
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	ip, .L99
	mov	r9, r1
	mov	r4, r0
	mov	r8, r2
	mov	r7, r3
	sub	r6, fp, #108
	ldmia	ip!, {r0, r1, r2, r3}
	sub	lr, fp, #76
	add	r5, ip, #16
	add	r10, ip, #48
	stmia	r6!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	r6, {r0, r1, r2, r3}
	ldmia	r5!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	r5, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	ldmia	r10, {r0, r1, r2, r3}
	ldr	ip, [r9, #20]
	sub	ip, ip, #2
	cmp	ip, #1
	sub	ip, fp, #124
	stmia	ip, {r0, r1, r2, r3}
	bls	.L97
.L84:
	mov	r1, #3
	mov	r0, r4
	bl	BsShow
	mov	r1, #3
	mov	r5, r0
	mov	r0, r4
	bl	BsSkip
	sub	r3, fp, #44
	add	r5, r3, r5, lsl #2
	ldr	r6, [r5, #-64]
	cmp	r6, #0
	beq	.L87
.L86:
	mov	r1, #3
	mov	r0, r4
	bl	BsShow
	mov	r1, #3
	mov	r9, r0
	mov	r0, r4
	bl	BsSkip
	sub	r3, fp, #44
	add	r3, r3, r9, lsl #2
	ldr	r5, [r3, #-32]
	cmp	r5, #0
	beq	.L98
.L88:
	str	r6, [r8]
	str	r5, [r7]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L87:
	mov	r1, #8
	mov	r0, r4
	bl	BsShow
	mov	r1, #8
	mov	r5, r0
	mov	r0, r4
	bl	BsSkip
	cmp	r5, #255
	add	r6, r6, r5, lsl #2
	beq	.L87
	b	.L86
.L97:
	mov	r0, r4
	bl	Real9_CB_Get1Bit
	cmp	r0, #0
	beq	.L84
	ldr	r3, [r9, #52]
	str	r3, [r8]
	ldr	r3, [r9, #56]
	str	r3, [r7]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L98:
	mov	r0, r4
	mov	r9, r9, asl #1
	bl	Real9_CB_Get1Bit
	sub	r2, fp, #44
	orr	r0, r0, r9
	and	r3, r0, #3
	add	r3, r2, r3, lsl #2
	ldr	r5, [r3, #-80]
	cmp	r5, #0
	bne	.L88
.L89:
	mov	r1, #8
	mov	r0, r4
	bl	BsShow
	mov	r1, #8
	mov	r9, r0
	mov	r0, r4
	bl	BsSkip
	cmp	r9, #255
	add	r5, r5, r9, lsl #2
	beq	.L89
	b	.L88
.L100:
	.align	2
.L99:
	.word	.LANCHOR0+280
	.fnend
	.size	Real9_CB_GetPicSize, .-Real9_CB_GetPicSize
	.align	2
	.global	Real9_CB_FindNextSliceStartCode
	.type	Real9_CB_FindNextSliceStartCode, %function
Real9_CB_FindNextSliceStartCode:
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
	sub	r6, r6, #2
	cmp	r6, #0
	movwgt	r7, #7184
	movgt	r4, #0
	movtgt	r7, 29
	bgt	.L104
	b	.L105
.L108:
	bl	BsSkip
	cmp	r4, r6
	beq	.L105
.L104:
	mov	r1, #24
	mov	r0, r5
	bl	BsShow
	add	r4, r4, #1
	mov	r1, #8
	cmp	r0, r7
	mov	r0, r5
	bne	.L108
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L105:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	Real9_CB_FindNextSliceStartCode, .-Real9_CB_FindNextSliceStartCode
	.align	2
	.global	Real9_CB_SearchBits_IgnoreOnly0
	.type	Real9_CB_SearchBits_IgnoreOnly0, %function
Real9_CB_SearchBits_IgnoreOnly0:
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
	mov	r6, #1
	sub	ip, r1, #1
	mov	r7, r2
	mov	r9, r3
	mov	r10, r1
	mov	r8, r0
	mov	r6, r6, asl ip
	bl	BsShow
	mov	r1, r10
	mov	r4, r0
	mov	r0, r8
	bl	BsSkip
	cmp	r7, r4
	cmpne	r9, #0
	beq	.L110
	ands	r5, r4, r6
	bne	.L110
	ldr	r3, .L116
	add	r10, r3, r10, lsl #2
	ldr	r10, [r10, #360]
	b	.L111
.L112:
	tst	r4, r6
	bne	.L110
.L111:
	mov	r0, r8
	and	r4, r10, r4, asl #1
	bl	Real9_CB_Get1Bit
	add	r5, r5, #1
	orr	r4, r0, r4
	cmp	r7, r4
	cmpne	r9, r5
	bhi	.L112
.L110:
	rsb	r0, r7, r4
	clz	r0, r0
	mov	r0, r0, lsr #5
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L117:
	.align	2
.L116:
	.word	.LANCHOR0
	.fnend
	.size	Real9_CB_SearchBits_IgnoreOnly0, .-Real9_CB_SearchBits_IgnoreOnly0
	.align	2
	.global	Real9_CB_GetSSC
	.type	Real9_CB_GetSSC, %function
Real9_CB_GetSSC:
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
	ldr	r3, [r1, #4]
	cmp	r3, #1
	beq	.L120
	bl	Real9_CB_FindNextSliceStartCode
	adds	r0, r0, #0
	movne	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L120:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Real9_CB_GetSSC, .-Real9_CB_GetSSC
	.align	2
	.global	Real9_CB_GetSliceHeader
	.type	Real9_CB_GetSliceHeader, %function
Real9_CB_GetSliceHeader:
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
	ldr	r4, [fp, #8]
	mov	r5, r1
	mov	r7, r2
	mov	r8, r3
	mov	r9, r0
	ldr	r6, [r4, #4]
	cmp	r6, #1
	beq	.L157
	cmp	r1, #0
	beq	.L158
	mov	r2, #0
	str	r2, [r7]
	ldr	r2, [fp, #4]
	mov	r0, #1
	mvn	r3, #0
	str	r3, [r2]
.L146:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L157:
	cmp	r1, #0
	bne	.L123
	ldr	r3, [r4, #88]
	cmn	r3, #1
	beq	.L159
	bl	Real9_CB_Get1Bit
	cmp	r0, #0
	bne	.L136
	mov	r1, #2
	mov	r0, r9
	bl	BsShow
	mov	r1, #2
	mov	r6, r0
	mov	r0, r9
	bl	BsSkip
	ldr	r3, [r4, #84]
	cmp	r3, r6
	beq	.L126
.L136:
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L158:
	bl	Real9_CB_Get1Bit
	cmp	r0, #1
	bne	.L136
	ldr	r5, [r4, #80]
	mov	r0, r9
	mov	r1, r5
	bl	BsShow
	mov	r1, r5
	mov	r6, r0
	mov	r0, r9
	bl	BsSkip
	str	r6, [r7]
	ldr	r3, [r4, #80]
	cmp	r3, #11
	bls	.L141
	mov	r0, r9
	bl	Real9_CB_Get1Bit
	cmp	r0, #1
	bne	.L136
.L141:
	mov	r1, #5
	mov	r0, r9
	bl	BsShow
	mov	r1, #5
	mov	r5, r0
	mov	r0, r9
	bl	BsSkip
	ldr	r3, [fp, #4]
	cmp	r5, #31
	str	r5, [r3]
	bgt	.L136
	mov	r1, #2
	mov	r0, r9
	bl	BsShow
	mov	r1, #2
	mov	r5, r0
	mov	r0, r9
	bl	BsSkip
	str	r5, [r4, #52]
	mov	r0, r9
	bl	Real9_CB_Get1Bit
	cmp	r0, #1
	mov	r4, r0
	bne	.L136
	mov	r1, #2
	mov	r0, r9
	bl	BsShow
	mov	r1, #2
	mov	r5, r0
	mov	r0, r9
	bl	BsSkip
	str	r5, [r8]
	mov	r0, r4
	b	.L146
.L159:
	bl	Real9_CB_Get1Bit
	cmp	r0, #0
	bne	.L136
	mov	r1, #2
	mov	r0, r9
	bl	BsShow
	mov	r5, r6
	mov	r1, #2
	mov	r10, r0
	mov	r0, r9
	bl	BsSkip
	str	r10, [r4, #84]
.L126:
	mov	r1, #5
	mov	r0, r9
	bl	BsShow
	mov	r1, #5
	mov	r6, r0
	mov	r0, r9
	bl	BsSkip
	uxtb	r0, r6
	cmp	r0, #31
	strb	r0, [r4, #66]
	bhi	.L136
	mov	r0, r9
	bl	Real9_CB_Get1Bit
	cmp	r0, #0
	bne	.L136
	mov	r0, r9
	bl	Real9_CB_Get1Bit
	subs	r10, r0, #0
	bne	.L136
	mov	r1, #2
	mov	r0, r9
	bl	BsShow
	mov	r1, #2
	mov	r6, r0
	mov	r0, r9
	bl	BsSkip
	str	r6, [r4, #52]
	mov	r1, #1
	mov	r0, r9
	bl	BsShow
	mov	r1, #1
	mov	r6, r0
	mov	r0, r9
	bl	BsSkip
	adds	r6, r6, #0
	mov	r1, #13
	mov	r0, r9
	movne	r6, #1
	cmp	r5, #0
	strb	r6, [r4, #65]
	add	r5, r4, #64
	beq	.L129
	bl	BsShow
	mov	r1, #13
	mov	r6, r0
	mov	r0, r9
	bl	BsSkip
	ldr	r3, [r4, #84]
	str	r6, [r4, #92]
	cmp	r3, #1
	bls	.L131
	cmp	r3, #2
	ldreq	r2, [r4, #108]
	ldreq	r3, [r4, #112]
	streq	r2, [r4, #116]
	streq	r3, [r4, #120]
.L147:
	mov	r1, r5
	sub	r3, fp, #48
	sub	r2, fp, #52
	mov	r0, r9
	bl	Real9_CB_GetPicSize
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-48]
	movw	r1, #8144
	sub	r0, r2, #48
	cmp	r0, r1
	str	r2, [r4, #108]
	str	r2, [r4, #16]
	str	r3, [r4, #112]
	str	r3, [r4, #12]
	bhi	.L136
	sub	r3, r3, #48
	cmp	r3, r1
	bhi	.L136
	mov	r0, r4
	bl	Real9_CB_SetDimensions
.L137:
	ldr	r5, [r4, #80]
	mov	r0, r9
	mov	r1, r5
	bl	BsShow
	mov	r1, r5
	mov	r6, r0
	mov	r0, r9
	bl	BsSkip
	str	r6, [r4, #88]
.L123:
	ldr	r2, [r4, #88]
	mov	r3, #0
	ldr	r1, [fp, #4]
	mov	r0, #1
	str	r2, [r7]
	ldrb	r2, [r4, #66]
	str	r2, [r1]
	str	r3, [r8]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L129:
	bl	BsShow
	mov	r1, #13
	mov	r6, r0
	mov	r0, r9
	bl	BsSkip
	ldr	r3, [r4, #92]
	cmp	r3, r6
	bne	.L136
	sub	r3, fp, #48
	sub	r2, fp, #52
	mov	r1, r5
	mov	r0, r9
	bl	Real9_CB_GetPicSize
	ldr	r2, [r4, #108]
	ldr	r3, [fp, #-52]
	cmp	r2, r3
	bne	.L136
	ldr	r2, [r4, #112]
	ldr	r3, [fp, #-48]
	cmp	r2, r3
	bne	.L136
	b	.L137
.L131:
	str	r10, [r4, #116]
	str	r10, [r4, #120]
	b	.L147
	.fnend
	.size	Real9_CB_GetSliceHeader, .-Real9_CB_GetSliceHeader
	.align	2
	.global	Real9_CB_GetPictureHeader
	.type	Real9_CB_GetPictureHeader, %function
Real9_CB_GetPictureHeader:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #24
	sub	sp, sp, #24
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r3, [r1, #4]
	mov	r4, r1
	mov	r5, r0
	cmp	r3, #1
	beq	.L184
	ldr	r3, .L187
	mov	r2, #128
	mov	r1, #0
	mov	r0, r4
	ldr	r3, [r3, #48]
	blx	r3
	mov	r1, #16
	mov	r0, r5
	bl	BsShow
	mov	r1, #16
	mov	r6, r0
	mov	r0, r5
	bl	BsSkip
	movw	r3, #21845
	cmp	r6, r3
	bne	.L180
	mov	r1, #16
	mov	r0, r5
	bl	BsShow
	mov	r1, #16
	mov	r7, r0
	mov	r0, r5
	bl	BsSkip
	cmp	r7, r6
	bne	.L180
	mov	r0, r5
	sub	r1, fp, #32
	bl	Real9_CB_GetVLCBits
	cmp	r0, #30
	bls	.L180
	ldr	r3, [fp, #-32]
	ands	r2, r3, #1
	bne	.L180
	tst	r3, #2
	mov	r0, r5
	strne	r2, [r4, #16]
	moveq	r1, #176
	moveq	r2, #144
	streq	r1, [r4, #16]
	sub	r1, fp, #32
	str	r2, [r4, #12]
	ubfx	r2, r3, #2, #5
	ubfx	r3, r3, #7, #8
	str	r2, [r4, #48]
	str	r3, [r4, #36]
	bl	Real9_CB_GetVLCBits
	cmp	r0, #1
	streq	r0, [r4, #8]
	beq	.L174
	cmp	r0, #3
	beq	.L185
	cmp	r0, #5
	bne	.L180
	ldr	r3, [fp, #-32]
	cmp	r3, #0
	bne	.L180
	mov	r3, #2
	str	r3, [r4, #8]
.L174:
	ldr	r3, [r4, #16]
	cmp	r3, #0
	beq	.L186
.L176:
	sub	r3, r3, #48
	movw	r2, #8144
	cmp	r3, r2
	bhi	.L180
	ldr	r3, [r4, #12]
	sub	r3, r3, #48
	cmp	r3, r2
	bhi	.L180
	mov	r0, r4
	mov	r6, #1
	bl	Real9_CB_SetDimensions
	mov	r1, #2
	mov	r0, r5
	bl	BsShow
	mov	r1, #2
	mov	r7, r0
	mov	r0, r5
	bl	BsSkip
	str	r7, [r4, #52]
.L162:
	ldr	r3, [r4, #16]
	mov	r0, r6
	ldr	r2, [r4, #12]
	add	r3, r3, #15
	add	r2, r2, #15
	mov	r3, r3, lsr #4
	str	r3, [r4, #24]
	mov	r2, r2, lsr #4
	str	r2, [r4, #20]
	mul	r3, r3, r2
	str	r3, [r4, #28]
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L185:
	ldr	r3, [fp, #-32]
	cmp	r3, #1
	moveq	r3, #0
	streq	r3, [r4, #8]
	beq	.L174
.L180:
	mvn	r0, #1
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L184:
	str	r1, [sp, #4]
	mvn	r2, #0
	sub	r3, fp, #32
	str	r2, [r1, #88]
	str	r3, [sp]
	sub	r2, fp, #36
	sub	r3, fp, #40
	mov	r1, #0
	bl	Real9_CB_GetSliceHeader
	cmp	r0, #1
	mvnne	r6, #1
	bne	.L162
	ldr	r3, [r4, #84]
	cmp	r3, #3
	ldrls	pc, [pc, r3, asl #2]
	b	.L178
.L165:
	.word	.L164
	.word	.L166
	.word	.L167
	.word	.L168
.L186:
	mov	r1, r4
	mov	r0, r5
	bl	Real9_CB_GetCPFMT
	cmp	r0, #0
	beq	.L180
	ldr	r3, [r4, #16]
	b	.L176
.L168:
	mov	r6, #1
	mov	r3, #2
	str	r3, [r4, #8]
.L163:
	ldr	r3, [r4, #16]
	movw	r2, #8144
	ldrb	lr, [r4, #65]
	sub	r3, r3, #48
	ldrb	ip, [r4, #66]
	ldr	r0, [r4, #92]
	cmp	r3, r2
	ldr	r1, [r4, #96]
	ldr	r3, [r4, #100]
	str	lr, [r4, #44]
	str	ip, [r4, #48]
	str	r0, [r4, #36]
	str	r1, [r4, #56]
	str	r3, [r4, #60]
	bhi	.L180
	ldr	r3, [r4, #12]
	sub	r3, r3, #48
	cmp	r3, r2
	bhi	.L180
	mov	r0, r4
	bl	Real9_CB_SetDimensions
	b	.L162
.L167:
	mov	r0, #1
	str	r0, [r4, #8]
	mov	r6, r0
	b	.L163
.L166:
	mov	r3, #0
	mov	r6, #1
	str	r3, [r4, #8]
	str	r3, [r4, #68]
	b	.L163
.L164:
	mov	r0, #1
	mov	r3, #0
	str	r0, [r4, #68]
	mov	r6, r0
	str	r3, [r4, #8]
	b	.L163
.L178:
	mvn	r6, #1
	b	.L163
.L188:
	.align	2
.L187:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	Real9_CB_GetPictureHeader, .-Real9_CB_GetPictureHeader
	.align	2
	.global	Real9_SetImgFormat
	.type	Real9_SetImgFormat, %function
Real9_SetImgFormat:
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
	add	r6, r0, #49152
	mov	r7, r0
	ldr	r1, [r6, #2568]
	ldr	r0, [r6, #2968]
	bl	FSP_GetFsImagePtr
	subs	r4, r0, #0
	beq	.L189
	ldr	r3, [r6, #1224]
	mov	r5, #0
	str	r5, [r4, #96]
	mov	r1, r5
	and	r3, r3, #3
	str	r3, [r4, #100]
	orr	r2, r3, #7168
	str	r3, [r4, #104]
	orr	r2, r2, #32
	str	r2, [r4, #108]
	ldr	r3, [r6, #1232]
	str	r3, [r4, #112]
	ldr	r3, [r6, #1228]
	str	r3, [r4, #116]
	bl	SetAspectRatio
	ldr	r3, [r7]
	ldr	r3, [r3, #28]
	cmp	r3, #25
	beq	.L195
.L191:
	mov	r2, #9
	mov	r3, #0
	str	r2, [r4, #340]
	mov	r2, #1
	strb	r3, [r4, #328]
	mov	r3, #8
	strb	r2, [r4, #335]
	strb	r2, [r4, #333]
	str	r3, [r4, #344]
	str	r3, [r4, #352]
	str	r3, [r4, #348]
.L189:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L195:
	ldr	r3, [r4, #116]
	add	r8, r4, #480
	ldr	r2, [r4, #140]
	add	r1, r4, #496
	add	r3, r3, #15
	ldr	ip, [r4, #44]
	mov	r0, r2, asl #4
	mov	r3, r3, lsr #4
	add	r9, ip, r2
	mul	r3, r3, r0
	add	lr, r3, ip
	str	lr, [r4, #48]
	ldrd	r6, [r8, #-8]
	add	r2, lr, r2
	mov	r0, lr
	strd	r6, [fp, #-44]
	adds	r6, r6, r3
	adc	r7, r7, r3, asr #31
	strd	r6, [r8]
	str	r2, [r4, #40]
	mov	r6, r1
	ldrd	r2, [fp, #-44]
	str	lr, [r4, #32]
	str	ip, [r4, #28]
	str	r9, [r4, #36]
	strd	r2, [r1, #-8]
	str	ip, [r4, #60]
	bl	MEM_Phy2Vir
	str	r0, [r4, #496]
	str	r5, [r6, #4]
	ldr	r3, [r4, #32]
	str	r3, [r4, #64]
	b	.L191
	.fnend
	.size	Real9_SetImgFormat, .-Real9_SetImgFormat
	.align	2
	.global	RV9_RecordVFMWState
	.type	RV9_RecordVFMWState, %function
RV9_RecordVFMWState:
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
	.size	RV9_RecordVFMWState, .-RV9_RecordVFMWState
	.align	2
	.global	Real9_WriteSliceMsg
	.type	Real9_WriteSliceMsg, %function
Real9_WriteSliceMsg:
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
	mov	r3, #44
	mla	r3, r3, r1, r0
	add	r2, r0, #49152
	add	r1, r1, #1
	ldr	ip, [r2, #1372]
	str	ip, [r3, #104]
	ldr	ip, [r2, #1364]
	str	ip, [r3, #112]
	ldr	ip, [r2, #1368]
	str	ip, [r3, #120]
	ldr	ip, [r2, #1384]
	str	ip, [r3, #108]
	ldr	ip, [r2, #1376]
	str	ip, [r3, #116]
	ldr	ip, [r2, #1380]
	str	ip, [r3, #124]
	ldr	ip, [r2, #1352]
	str	ip, [r3, #128]
	ldr	ip, [r2, #1348]
	str	ip, [r3, #132]
	ldr	ip, [r2, #1344]
	str	ip, [r3, #136]
	ldr	r2, [r2, #1356]
	str	r2, [r3, #140]
	str	r1, [r0, #40]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Real9_WriteSliceMsg, .-Real9_WriteSliceMsg
	.align	2
	.global	Real9_WritePicMsg
	.type	Real9_WritePicMsg, %function
Real9_WritePicMsg:
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
	add	r3, r0, #49152
	ldr	r2, [r3, #1224]
	cmp	r2, #2
	strb	r2, [r0, #9]
	ldr	r2, [r3, #1240]
	str	r2, [r0, #12]
	ldr	r2, [r3, #1236]
	str	r2, [r0, #16]
	ldr	r2, [r3, #2484]
	str	r2, [r0, #20]
	ldr	r2, [r3, #2488]
	str	r2, [r0, #24]
	ldr	r2, [r3, #1264]
	str	r2, [r0, #28]
	ldr	r1, [r3, #1388]
	str	r1, [r0, #32]
	ldr	r1, [r3, #1392]
	str	r1, [r0, #36]
	strne	r2, [r3, #1388]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Real9_WritePicMsg, .-Real9_WritePicMsg
	.align	2
	.global	Real9_WriteReg
	.type	Real9_WriteReg, %function
Real9_WriteReg:
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
	str	r1, [r0, #44]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Real9_WriteReg, .-Real9_WriteReg
	.align	2
	.global	Real9_ModifySliceMsg
	.type	Real9_ModifySliceMsg, %function
Real9_ModifySliceMsg:
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
	ldr	r2, [r0, #140]
	ldr	r3, [r0, #12]
	cmp	r2, #0
	ldr	ip, [r0, #16]
	bne	.L208
	mul	ip, r3, ip
	ldr	r5, [r0, #40]
	cmp	r5, #2
	sub	ip, ip, #1
	bls	.L207
	ldr	r3, [r0, #184]
	sub	lr, r5, #1
	cmp	r3, #0
	cmpgt	ip, r3
	ble	.L208
	mov	r2, r0
	mov	r3, #1
	b	.L209
.L210:
	ldr	r1, [r2, #228]
	add	r2, r2, #44
	cmp	ip, r1
	cmpgt	r1, #0
	ble	.L208
.L209:
	add	r3, r3, #1
	cmp	r3, lr
	bne	.L210
.L207:
	cmp	r5, #1
	bls	.L211
	sub	r4, r5, #1
	mov	r3, r0
	mov	r2, #0
	b	.L212
.L213:
	ldr	lr, [r3, #140]
	add	r3, r3, #44
	add	r2, r2, #1
	ldr	r1, [r3, #140]
	cmp	lr, r1
	bge	.L208
.L212:
	cmp	r2, r4
	bne	.L213
	mov	r3, #44
	mla	r2, r3, r2, r0
	ldr	r3, [r2, #140]
	cmp	ip, r3
	cmpge	r3, #0
	ble	.L208
.L211:
	cmp	r5, #0
	beq	.L214
	sub	r7, r5, #1
	mov	r6, r0
	mov	lr, r0
	mov	r4, #0
	b	.L217
.L232:
	cmp	r4, r5
	beq	.L231
.L217:
	cmp	r4, r7
	streq	ip, [lr, #144]
	add	r4, r4, #1
	add	lr, lr, #44
	ldrne	r3, [lr, #140]
	moveq	r1, ip
	subne	r1, r3, #1
	ldr	r3, [lr, #96]
	strne	r1, [lr, #100]
	mov	r2, r3, lsr #31
	cmp	ip, r3
	orrlt	r2, r2, #1
	cmp	r3, r1
	movle	r3, r2
	orrgt	r3, r2, #1
	orr	r3, r3, r1, lsr #31
	cmp	ip, r1
	orrlt	r3, r3, #1
	cmp	r3, #0
	beq	.L232
.L208:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L231:
	ldr	r2, [r0, #104]
	mov	r1, r2
	b	.L220
.L233:
	ldr	r1, [r6, #104]
.L220:
	cmp	r2, r1
	ldr	ip, [r6, #108]
	add	r3, r3, #1
	movcs	r2, r1
	cmp	ip, r2
	bcs	.L218
	ldr	r1, [r6, #124]
	cmp	r1, #0
	movne	r2, ip
.L218:
	cmp	r5, r3
	add	r6, r6, #44
	bne	.L233
	bic	r2, r2, #15
	ldr	lr, [r0, #40]
	str	r2, [r0, #48]
	mov	r3, r0
	mov	ip, #0
	b	.L224
.L234:
	ldr	r4, [r3, #112]
	rsb	r2, r2, r1
	and	r1, r4, #7
	add	r2, r2, r4, lsr #3
	and	r4, r2, #15
	bic	r2, r2, #15
	str	r2, [r3, #104]
	add	r2, r1, r4, lsl #3
	str	r2, [r3, #112]
.L222:
	add	ip, ip, #1
	add	r3, r3, #44
	cmp	lr, ip
	bls	.L223
	ldr	r2, [r0, #48]
.L224:
	ldr	r1, [r3, #108]
	cmp	r1, #0
	rsb	r4, r2, r1
	ldr	r1, [r3, #104]
	beq	.L234
	ldr	r5, [r3, #112]
	rsb	r2, r2, r1
	ldr	r7, [r3, #116]
	and	r6, r5, #7
	add	r2, r2, r5, lsr #3
	and	r5, r7, #7
	add	r1, r4, r7, lsr #3
	and	r4, r2, #15
	and	r7, r1, #15
	bic	r2, r2, #15
	add	r4, r6, r4, lsl #3
	str	r2, [r3, #104]
	bic	r1, r1, #15
	add	r2, r5, r7, lsl #3
	str	r4, [r3, #112]
	str	r2, [r3, #116]
	str	r1, [r3, #108]
	b	.L222
.L214:
	ldr	r3, [r0, #104]
	bic	r3, r3, #15
	str	r3, [r0, #48]
.L223:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	Real9_ModifySliceMsg, .-Real9_ModifySliceMsg
	.align	2
	.global	REAL9DEC_Init
	.type	REAL9DEC_Init, %function
REAL9DEC_Init:
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
	ldr	r3, .L239
	mov	r7, r1
	movw	r2, #52128
	mov	r1, #0
	add	r4, r0, #49152
	ldr	r3, [r3, #48]
	mov	r5, r0
	mov	r6, r1
	blx	r3
	add	r0, r5, #51712
	add	r0, r0, #56
	bl	ResetVoQueue
	str	r7, [r5]
	mov	r3, #15
	str	r3, [r4, #1388]
	str	r3, [r4, #1392]
	add	r2, r5, #8192
	ldr	ip, [r7, #8]
	mov	r3, #1
	strb	r6, [r2, #3192]
	mov	r1, #8192
	mov	r0, r5
	strb	ip, [r2, #3188]
	str	r1, [r4, #1248]
	str	r3, [r4, #1220]
	strb	r3, [r4, #1216]
	bl	VCTRL_GetChanIDByCtx
	cmn	r0, #1
	str	r0, [r4, #2968]
	mov	r0, r6
	beq	.L238
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L238:
	ldr	r1, .L239+4
	bl	dprint_vfmw
	mvn	r0, #19
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L240:
	.align	2
.L239:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC10
	.fnend
	.size	REAL9DEC_Init, .-REAL9DEC_Init
	.align	2
	.global	REAL9DEC_Destroy
	.type	REAL9DEC_Destroy, %function
REAL9DEC_Destroy:
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
	add	r3, r0, #49152
	ldr	r1, .L242
	mov	r0, #2
	ldr	r2, [r3, #2460]
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L243:
	.align	2
.L242:
	.word	.LC11
	.fnend
	.size	REAL9DEC_Destroy, .-REAL9DEC_Destroy
	.global	__aeabi_idiv
	.align	2
	.global	REAL9DEC_Decode
	.type	REAL9DEC_Decode, %function
REAL9DEC_Decode:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #204
	sub	sp, sp, #204
	push	{lr}
	bl	__gnu_mcount_nc
	add	r9, r0, #49152
	mov	r7, r0
	mov	r4, r1
	mov	r2, #128
	mov	r1, #0
	sub	r0, fp, #172
	add	r3, r7, #8
	str	r3, [fp, #-192]
	bl	memset
	ldr	r2, [r9, #1324]
	ldr	r3, [r9, #1328]
	cmp	r4, #0
	mov	r0, #1
	mov	r1, #8192
	str	r2, [r9, #1332]
	str	r2, [fp, #-56]
	str	r2, [fp, #-64]
	str	r3, [r9, #1336]
	str	r3, [fp, #-52]
	str	r3, [fp, #-60]
	str	r0, [r9, #1220]
	str	r0, [fp, #-168]
	str	r1, [r9, #1248]
	str	r1, [fp, #-140]
	beq	.L375
	ldr	r3, .L395
	movw	r2, #11360
	mov	r1, #0
	ldr	r0, [fp, #-192]
	mov	r8, r1
	add	r6, r7, #8192
	ldr	r3, [r3, #48]
	blx	r3
	str	r8, [r9, #2424]
	ldr	r3, [r4, #12]
	str	r3, [r9, #2444]
	ldr	r3, [r4, #8]
	str	r3, [r9, #2428]
	ldr	r3, [r4]
	str	r3, [r6, #3176]
	ldr	r2, [r4, #12]
	str	r2, [r9, #2432]
	ldrb	r3, [r4, #5]
	strb	r3, [r6, #3180]
	ldrb	r3, [r4, #5]
	cmp	r3, #1
	beq	.L247
	ldr	r3, [r4, #88]
	str	r3, [r9, #2436]
	ldr	r3, [r4, #80]
	str	r3, [r6, #3184]
	ldr	r3, [r4, #92]
	str	r3, [r9, #2440]
	ldrb	r3, [r4, #85]
	strb	r3, [r6, #3181]
	ldrb	r3, [r4, #85]
	cmp	r3, #1
	bne	.L376
.L248:
	movw	r3, #65525
	sub	r1, r2, #10
	movt	r3, 47
	cmp	r1, r3
	bhi	.L369
	ldr	r1, [r6, #3176]
	cmp	r1, #0
	beq	.L369
	add	r3, r7, #51712
	add	r3, r3, #24
	str	r3, [fp, #-196]
	mov	r4, r3
	mov	r0, r3
	bl	BsInit
	mov	r1, #8
	mov	r0, r4
	bl	BsShow
	mov	r1, #8
	mov	r5, r0
	mov	r0, r4
	bl	BsSkip
	cmp	r5, #255
	add	r0, r5, #1
	str	r0, [r9, #1396]
	bhi	.L369
	cmp	r0, #0
	beq	.L251
	add	r10, r7, #50432
	movw	r8, #65535
	add	r10, r10, #116
	str	r6, [fp, #-200]
	movt	r8, 47
	mov	r5, #0
	mov	r6, r10
	b	.L252
.L378:
	ldr	r0, [r9, #1396]
	cmp	r0, r5
	bls	.L377
.L252:
	mov	r1, #32
	mov	r0, r4
	bl	BsSkip
	mov	r1, #32
	mov	r0, r4
	add	r5, r5, #1
	bl	BsShow
	mov	r1, #32
	mov	r10, r0
	mov	r0, r4
	bl	BsSkip
	rev	r3, r10
	cmp	r3, r8
	str	r3, [r6, #4]!
	ble	.L378
.L369:
	mov	r8, #0
.L359:
	mov	r0, r8
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L376:
	ldr	r1, [r4, #16]
	ldr	r0, [r9, #2968]
	bl	SM_ReleaseStreamSeg
	ldr	r1, [r4, #96]
	ldr	r0, [r9, #2968]
	bl	SM_ReleaseStreamSeg
	mov	r0, r8
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L247:
	str	r8, [r9, #2436]
	str	r8, [r6, #3184]
	str	r8, [r9, #2440]
	strb	r8, [r6, #3181]
	b	.L248
.L375:
	ldr	r2, [r9, #2460]
	mov	r8, r4
	ldr	r1, .L395+4
	bl	dprint_vfmw
	mov	r0, r8
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L377:
	ldr	r6, [fp, #-200]
	str	r4, [fp, #-196]
.L251:
	add	r3, r7, #50432
	sub	r5, r0, #1
	add	r3, r3, #120
	mov	r2, #0
	ldr	r4, [fp, #-196]
	b	.L253
.L254:
	ldr	ip, [r3, #4]!
	ldr	r1, [r3, #-4]
	cmp	ip, r1
	ble	.L369
.L253:
	cmp	r2, r5
	add	r2, r2, #1
	bne	.L254
	ldr	r2, [r9, #1400]
	mov	r0, r0, asl #3
	add	r1, r0, #1
	movw	r3, #65534
	cmp	r1, #3145728
	add	ip, r1, r2
	sub	r5, ip, #1
	movt	r3, 47
	movlt	r2, #0
	movge	r2, #1
	cmp	r5, r3
	movls	r5, r2
	orrhi	r5, r2, #1
	str	r4, [fp, #-196]
	cmp	r5, #0
	str	r1, [fp, #-200]
	bne	.L369
	ldr	r2, [r9, #2432]
	rsb	r2, ip, r2
	cmp	r2, #0
	ble	.L369
	ldr	r1, [r6, #3176]
	mov	r0, r4
	str	ip, [fp, #-204]
	add	r1, r1, ip
	bl	BsInit
	sub	r1, fp, #172
	mov	r0, r4
	bl	Real9_CB_GetPictureHeader
	ldr	ip, [fp, #-204]
	cmp	r0, #1
	mov	r8, r0
	bne	.L379
	ldrb	r3, [r6, #3192]
	cmp	r3, #0
	beq	.L256
	ldr	r2, [fp, #-148]
	ldr	r3, [r9, #1240]
	cmp	r2, r3
	beq	.L380
.L256:
	ldr	r3, .L395+8
	ldr	r5, [r3]
	cmp	r5, #0
	beq	.L258
	ldr	r0, [fp, #-148]
	mov	r3, #8
	ldr	r1, [r9, #1236]
	sub	r2, fp, #180
	ldr	lr, [r9, #1240]
	strh	r0, [fp, #-176]
	ldrh	r0, [fp, #-152]
	strh	r1, [fp, #-178]
	mov	r1, #2
	strh	lr, [fp, #-180]
	strh	r0, [fp, #-174]
	ldr	r0, [r9, #2968]
	str	ip, [fp, #-204]
	blx	r5
	ldr	ip, [fp, #-204]
.L258:
	mov	r2, #1
	ldr	r1, [r9, #2564]
	ldr	r0, [r9, #2968]
	add	r5, r7, #51712
	str	ip, [fp, #-208]
	bl	FSP_ClearLogicFs
	mov	r2, #1
	ldr	r1, [r9, #2560]
	ldr	r0, [r9, #2968]
	add	r5, r5, #56
	bl	FSP_ClearLogicFs
	mov	r3, #0
	ldr	r0, [r9, #2968]
	str	r3, [r9, #2560]
	str	r3, [r9, #2564]
	str	r3, [fp, #-204]
	bl	FSP_GetNullLogicFs
	ldr	r3, [fp, #-204]
	mov	r1, r5
	str	r0, [r9, #2564]
	str	r0, [r9, #2560]
	strb	r3, [r6, #3189]
	ldr	r0, [r9, #2968]
	bl	FSP_ClearNotInVoQueue
	ldr	r2, [fp, #-148]
	ldr	r3, [fp, #-152]
	cmp	r2, #512
	ldr	ip, [fp, #-208]
	bhi	.L260
	cmp	r3, #512
	bhi	.L260
	ldr	r3, [r7]
	ldr	r2, [r3, #700]
	cmp	r2, #0
	bne	.L262
	ldr	r3, [r3, #28]
	cmp	r3, #25
	beq	.L381
.L262:
	ldr	r0, [r9, #2968]
	str	ip, [fp, #-204]
	bl	FSP_GetFspType
	ldr	ip, [fp, #-204]
	cmp	r0, #0
	beq	.L382
.L264:
	ldr	r3, [fp, #-152]
	mov	r0, #1
	ldr	r2, [fp, #-148]
	ldr	r1, .L395+12
	str	ip, [fp, #-204]
	bl	dprint_vfmw
	sub	r2, fp, #172
	mov	r1, r7
	mov	r0, #6
	bl	Real9_ArrangeVHBMem
	ldr	ip, [fp, #-204]
	subs	r3, r0, #0
	beq	.L383
.L257:
	add	r3, r7, #50176
	sub	r1, fp, #172
	str	ip, [fp, #-204]
	mov	r2, r3
	ldr	r3, .L395
	add	r2, r2, #192
	str	r2, [fp, #-208]
	ldr	r3, [r3, #52]
	mov	r0, r2
	mov	r2, #128
	blx	r3
	ldr	r3, [r7]
	mov	r0, r7
	ldr	r3, [r3, #8]
	strb	r3, [r6, #3188]
	bl	Real9_GetImageBuffer
	ldr	ip, [fp, #-204]
	subs	r3, r0, #0
	beq	.L384
	ldr	r1, [r9, #2568]
	ldr	r0, [r9, #2968]
	str	ip, [fp, #-204]
	bl	FSP_GetFsImagePtr
	subs	r3, r0, #0
	beq	.L370
	ldr	r0, [r7]
	add	r2, r3, #576
	add	ip, r3, #592
	ldr	r1, .L395+16
	ldrd	r4, [r0, #56]
	mov	r0, #29
	strd	r4, [r2, #-8]
	ldr	lr, [r7]
	ldrd	r4, [lr, #72]
	strd	r4, [r2]
	ldr	lr, [r7]
	ldrd	r4, [lr, #88]
	strd	r4, [ip, #-8]
	mvn	r4, #0
	ldr	lr, [r7]
	mvn	r5, #0
	ldr	lr, [lr, #104]
	str	lr, [r3, #8]
	ldr	lr, [r7]
	ldr	lr, [lr, #108]
	str	lr, [r3, #12]
	ldr	lr, [r7]
	ldr	lr, [lr, #112]
	str	lr, [r3, #16]
	ldr	lr, [r7]
	ldr	lr, [lr, #128]
	str	lr, [r3, #20]
	ldr	r3, [r7]
	strd	r4, [r3, #56]
	ldrd	r4, [r2]
	ldrd	r2, [r2, #-8]
	strd	r4, [sp]
	bl	dprint_vfmw
	ldr	r3, [r9, #1224]
	ldr	ip, [fp, #-204]
	cmp	r3, #2
	beq	.L372
	cmp	r3, #1
	ldrb	r3, [r6, #3189]
	beq	.L385
	cmp	r3, #0
	movne	r3, #2
	moveq	r3, #1
.L271:
	strb	r3, [r6, #3189]
	ldr	r2, [r9, #2560]
	ldr	r3, [r9, #2564]
	cmp	r2, r3
	beq	.L272
	ldr	r1, .L395+20
	mov	r0, #13
	str	ip, [fp, #-204]
	bl	dprint_vfmw
	mov	r2, #0
	ldr	r1, [r9, #2560]
	ldr	r0, [r9, #2968]
	bl	FSP_SetRef
	ldr	ip, [fp, #-204]
.L272:
	ldr	r3, [r9, #2564]
	mov	r2, #1
	ldr	r1, [r9, #2568]
	ldr	r0, [r9, #2968]
	str	r3, [r9, #2560]
	str	r1, [r9, #2564]
	str	ip, [fp, #-204]
	bl	FSP_SetRef
	ldr	r1, [r9, #2560]
	ldr	r0, [r9, #2968]
	bl	FSP_RemovePmv
	ldr	r2, [r9, #2568]
	ldr	r1, .L395+24
	mov	r0, #13
	bl	dprint_vfmw
	ldrb	r3, [r6, #3188]
	ldr	ip, [fp, #-204]
	cmp	r3, #4
	bne	.L274
	ldr	r3, [r9, #1224]
	cmp	r3, #0
	beq	.L365
	cmp	r3, #2
	beq	.L315
	cmp	r3, #1
	beq	.L365
.L274:
	ldr	r1, [r9, #2568]
	ldr	r0, [r9, #2968]
	str	ip, [fp, #-204]
	bl	FSP_GetLogicFs
	ldr	r1, [r9, #2560]
	mov	r5, r0
	ldr	r0, [r9, #2968]
	bl	FSP_GetLogicFs
	ldr	r1, [r9, #2564]
	mov	r4, r0
	str	r0, [fp, #-212]
	ldr	r0, [r9, #2968]
	bl	FSP_GetLogicFs
	cmp	r5, #0
	cmpne	r4, #0
	mov	r3, r4
	ldr	ip, [fp, #-204]
	moveq	r3, #1
	movne	r3, #0
	cmp	r0, #0
	orreq	r3, r3, #1
	mov	r10, r0
	cmp	r3, #0
	bne	.L386
	ldr	r3, [r5, #608]
	cmp	r3, #0
	beq	.L280
	ldr	r2, [r5, #616]
	cmp	r2, #0
	beq	.L280
	ldr	r2, [r5, #612]
	cmp	r2, #0
	beq	.L280
	ldr	r2, [r0, #608]
	mov	r0, #13
	ldr	r1, .L395+28
	cmp	r2, #0
	ldrne	r3, [r2, #16]
	ldreq	r3, [r3, #16]
	str	r3, [fp, #-204]
	ldr	r3, [fp, #-204]
	str	r3, [r7, #52]
	ldr	r3, [fp, #-212]
	ldr	r3, [r3, #608]
	cmp	r3, #0
	ldreq	r3, [r5, #608]
	ldr	lr, [r3, #16]
	str	ip, [fp, #-216]
	str	lr, [r7, #56]
	ldr	r3, [r5, #608]
	ldr	r2, [r3, #16]
	str	r2, [r7, #60]
	ldr	r3, [r5, #620]
	str	r3, [r7, #76]
	mov	ip, r3
	ldr	r3, [r10, #620]
	str	r3, [r7, #80]
	mov	r4, r3
	ldr	r3, [r5, #612]
	ldr	r3, [r3, #16]
	str	ip, [sp, #8]
	ldr	ip, [fp, #-204]
	str	r4, [sp, #12]
	str	r3, [r7, #64]
	str	ip, [sp, #4]
	str	lr, [sp]
	bl	dprint_vfmw
	ldr	r3, [r5, #612]
	ldr	ip, [fp, #-216]
	ldr	r3, [r3, #32]
	str	r3, [r7, #68]
	ldr	r3, [r5, #612]
	ldr	r3, [r3, #32]
	str	r3, [r9, #2532]
	ldr	r3, [r5, #612]
	ldr	r3, [r3, #76]
	str	r3, [r7, #92]
	ldr	r3, [r5, #612]
	ldr	r3, [r3, #60]
	str	r3, [r7, #96]
	ldr	r3, [r5, #612]
	ldr	r3, [r3, #64]
	str	r3, [r7, #100]
	ldr	r3, [r9, #1224]
	cmp	r3, #2
	beq	.L387
.L286:
	ldr	r3, [r9, #1252]
	ldr	r0, [fp, #-196]
	str	ip, [fp, #-212]
	str	r3, [r5, #628]
	ldr	r3, [r9, #1224]
	ldr	r2, [r9, #1264]
	cmp	r3, #2
	strb	r3, [r7, #9]
	ldr	r3, [r9, #1240]
	str	r2, [fp, #-204]
	str	r3, [r7, #12]
	ldr	r3, [r9, #1236]
	str	r3, [r7, #16]
	ldr	r3, [r9, #2484]
	str	r3, [r7, #20]
	ldr	r3, [r9, #2488]
	str	r2, [r7, #28]
	str	r3, [r7, #24]
	ldr	r3, [r9, #1388]
	str	r3, [r7, #32]
	ldr	r3, [r9, #1392]
	str	r3, [r7, #36]
	strne	r2, [r9, #1388]
	bl	BsPos
	ldr	r1, [r9, #1396]
	ldr	ip, [fp, #-212]
	cmp	r1, #1
	ldreq	r5, [r9, #1400]
	ldrne	r5, [r9, #1400]
	strne	ip, [fp, #-212]
	mov	r3, r0, asr #31
	mov	r2, r3, lsr #29
	add	r3, r0, r2
	ldreq	r0, [fp, #-196]
	and	r3, r3, #7
	ldrne	r0, [fp, #-196]
	rsb	r3, r2, r3
	ldreq	r2, [fp, #-200]
	str	r3, [r9, #1364]
	ldreq	r3, [r9, #2432]
	ldrne	r3, [r9, #1404]
	rsbeq	r3, r2, r3
	rsb	r5, r5, r3
	bl	BsPos
	ldr	ip, [fp, #-212]
	mov	r5, r5, asl #3
	rsb	r0, r0, r5
	ldr	r5, [r9, #2428]
	str	r0, [r9, #1368]
	ldr	r0, [fp, #-196]
	add	r5, ip, r5
	bl	BsPos
	ldr	r2, [r9, #1268]
	ldr	lr, [r9, #1260]
	mov	r1, #1
	ldr	ip, [fp, #-204]
	str	r2, [r9, #1348]
	str	lr, [r9, #1352]
	str	ip, [r9, #1344]
	add	r3, r0, #7
	cmp	r0, #0
	movlt	r0, r3
	mov	r3, #0
	add	r0, r5, r0, asr #3
	str	r3, [r9, #1376]
	str	r0, [r9, #1372]
	str	r3, [r9, #1380]
	str	r3, [r9, #1384]
	str	r3, [r9, #1356]
	str	r0, [r7, #104]
	ldr	r0, [r9, #1364]
	str	r0, [r7, #112]
	ldr	r0, [r9, #1368]
	str	lr, [r7, #128]
	str	r3, [r7, #108]
	str	r0, [r7, #120]
	str	r3, [r7, #116]
	str	r3, [r7, #124]
	str	r2, [r7, #132]
	str	r3, [r7, #140]
	str	ip, [r7, #136]
	str	r1, [r7, #40]
	ldr	r2, [r9, #1396]
	cmp	r2, r1
	bls	.L311
	ldr	r10, [r9, #1404]
	movw	r0, #65535
	ldr	r2, [fp, #-200]
	movt	r0, 47
	add	r10, r2, r10
	cmp	r10, r0
	bgt	.L371
	cmp	r10, #0
	ble	.L371
	ldr	r2, [r9, #2432]
	rsb	r2, r10, r2
	cmp	r2, #0
	ble	.L371
	add	ip, r7, #50432
	mov	r5, r1
	add	r1, ip, #124
	str	r8, [fp, #-224]
	str	r3, [fp, #-220]
	mov	r8, r7
	str	r0, [fp, #-212]
	mov	r7, r6
	str	r5, [fp, #-216]
	mov	r6, r1
	ldr	r4, [fp, #-196]
	b	.L302
.L303:
	ldr	r3, [r9, #1396]
	add	r5, r5, #1
	cmp	r3, r5
	bls	.L388
	ldr	r3, [fp, #-200]
	ldr	ip, [r6, #4]!
	add	r10, r3, ip
	ldr	r3, [fp, #-212]
	cmp	r10, r3
	bgt	.L371
	cmp	r10, #0
	ble	.L371
	ldr	r2, [r9, #2432]
	rsb	r2, r10, r2
	cmp	r2, #0
	ble	.L371
.L302:
	ldr	r1, [r7, #3176]
	mov	r0, r4
	add	r1, r1, r10
	bl	BsInit
	ldr	r3, [fp, #-208]
	sub	r2, fp, #188
	mov	r1, #0
	mov	r0, r4
	str	r3, [sp, #4]
	sub	r3, fp, #180
	str	r3, [sp]
	sub	r3, fp, #184
	bl	Real9_CB_GetSliceHeader
	cmp	r0, #1
	bne	.L303
	ldr	r3, [r9, #1240]
	ldr	r2, [fp, #-188]
	cmp	r3, #0
	str	r2, [fp, #-196]
	beq	.L389
	ldr	r3, [fp, #-180]
	mov	r0, r4
	ldr	r2, [fp, #-204]
	cmp	r3, #0
	movge	r2, r3
	str	r2, [fp, #-204]
	bl	BsPos
	ldr	r2, [r9, #1396]
	sub	lr, r2, #1
	cmp	lr, r5
	mov	r3, r0, asr #31
	mov	r1, r3, lsr #29
	add	r3, r0, r1
	and	r3, r3, #7
	rsb	r3, r1, r3
	str	r3, [r9, #1364]
	beq	.L390
	cmp	r5, #254
	bhi	.L391
	ldr	r3, [r6, #4]
	mov	r0, r4
	ldr	r2, [r6]
.L368:
	rsb	r3, r2, r3
	mov	r3, r3, asl #3
	str	r3, [fp, #-228]
	bl	BsPos
	ldr	r3, [fp, #-228]
	rsb	r0, r0, r3
	ldr	r3, [r9, #2428]
	str	r0, [r9, #1368]
	mov	r0, r4
	add	r10, r10, r3
	bl	BsPos
	ldr	ip, [fp, #-220]
	mov	r3, #44
	ldr	lr, [fp, #-216]
	ldr	r1, [r9, #1260]
	str	ip, [r9, #1376]
	str	ip, [r9, #1380]
	str	ip, [r9, #1384]
	mla	r3, r3, lr, r8
	ldr	ip, [fp, #-204]
	str	r1, [r9, #1352]
	add	lr, lr, #1
	str	lr, [fp, #-216]
	str	ip, [r9, #1344]
	ldr	ip, [fp, #-196]
	str	ip, [r9, #1356]
	add	r2, r0, #7
	cmp	r0, #0
	movlt	r0, r2
	ldr	r2, [r9, #1268]
	add	r0, r10, r0, asr #3
	str	r0, [r9, #1372]
	cmp	lr, #131
	str	r2, [r9, #1348]
	str	r0, [r3, #104]
	ldr	r2, [r9, #1364]
	str	r2, [r3, #112]
	ldr	r2, [r9, #1368]
	str	r2, [r3, #120]
	ldr	r2, [r9, #1384]
	str	r2, [r3, #108]
	ldr	r2, [r9, #1376]
	str	r2, [r3, #116]
	ldr	r2, [r9, #1380]
	str	r2, [r3, #124]
	ldr	r2, [r9, #1352]
	str	r2, [r3, #128]
	ldr	r2, [r9, #1348]
	str	r2, [r3, #132]
	ldr	r2, [r9, #1344]
	str	r2, [r3, #136]
	ldr	r2, [r9, #1356]
	str	r2, [r3, #140]
	str	lr, [r8, #40]
	ble	.L303
	mov	r0, r8
	bl	Real9_ModifySliceMsg
	cmp	r0, #1
	bne	.L371
	ldr	r3, [fp, #-192]
	str	r3, [r8, #4]
	b	.L303
.L379:
	ldr	r1, .L395+32
	mov	r0, #1
	mov	r8, r5
	bl	dprint_vfmw
	b	.L359
.L260:
	ldr	r1, .L395+36
	mov	r0, #18
	bl	dprint_vfmw
	b	.L369
.L384:
	ldr	r2, [r9, #2460]
	mov	r8, r3
	ldr	r1, .L395+40
	bl	dprint_vfmw
	b	.L359
.L380:
	ldr	r2, [fp, #-152]
	ldr	r3, [r9, #1236]
	cmp	r2, r3
	bne	.L256
	b	.L257
.L382:
	mov	r0, r5
	bl	ResetVoQueue
	ldr	ip, [fp, #-204]
	b	.L264
.L383:
	ldr	r1, .L395+44
	mov	r0, #1
	mov	r8, r3
	bl	dprint_vfmw
	b	.L359
.L381:
	ldrb	r3, [r6, #3192]
	cmp	r3, #0
	bne	.L264
	mov	r0, r5
	str	ip, [fp, #-204]
	bl	ResetVoQueue
	ldr	ip, [fp, #-204]
	b	.L264
.L371:
	mov	r2, #1
	ldr	r1, [r9, #2568]
	ldr	r0, [r9, #2968]
	mov	r8, #0
	bl	FSP_ClearLogicFs
	b	.L359
.L372:
	ldrb	r3, [r6, #3189]
	cmp	r3, #1
	bls	.L371
	ldrb	r3, [r6, #3188]
	cmp	r3, #4
	bne	.L274
.L315:
	ldr	r3, [r9, #2576]
	cmp	r3, #0
	bne	.L274
.L370:
	mov	r2, #1
	ldr	r1, [r9, #2568]
	ldr	r0, [r9, #2968]
	mov	r8, r3
	bl	FSP_ClearLogicFs
	b	.L359
.L365:
	str	r3, [r9, #2576]
	b	.L274
.L390:
	add	r2, r2, #9792
	ldr	r3, [r9, #2432]
	add	r2, r2, #3
	ldr	r1, [fp, #-200]
	mov	r0, r4
	add	r2, r7, r2, lsl #2
	rsb	r3, r1, r3
	ldr	r2, [r2, #3176]
	b	.L368
.L385:
	cmp	r3, #0
	movne	r3, #2
	bne	.L271
	b	.L369
.L386:
	movw	r3, #1992
	ldr	r2, .L395+48
	ldr	r1, .L395+52
	mov	r0, #0
	bl	dprint_vfmw
	mov	r8, #0
	b	.L359
.L388:
	mov	r7, r8
	ldr	r8, [fp, #-224]
.L311:
	ldr	r4, [r7, #4]
	mov	r5, #1
	str	r5, [r7, #44]
	cmp	r4, #0
	beq	.L392
	ldr	r3, [r7]
	ldr	r2, [r3, #856]
	cmp	r2, #1
	beq	.L316
.L313:
	cmp	r2, #2
	beq	.L393
.L314:
	ldr	r2, [r3, #588]
	str	r2, [r7, #84]
	ldr	r3, [r3, #624]
	str	r3, [r7, #88]
	b	.L359
.L387:
	ldr	r3, [fp, #-212]
	ldr	r10, [r10, #628]
	ldr	r2, [r3, #628]
	ldr	r3, [r9, #1252]
	rsb	r10, r2, r10
	subs	r3, r3, r2
	ldrmi	r2, [r9, #1248]
	addmi	r3, r3, r2
	cmp	r10, #0
	ldrlt	r2, [r9, #1248]
	addlt	r10, r10, r2
	cmp	r3, r10
	movgt	r3, #0
	cmp	r10, #0
	ble	.L318
	mov	r1, r10
	mov	r0, r3, asl #14
	str	ip, [fp, #-216]
	str	r3, [fp, #-204]
	bl	__aeabi_idiv
	ldr	r3, [fp, #-204]
	mov	r1, r10
	str	r0, [fp, #-212]
	rsb	r0, r3, r10
	mov	r0, r0, asl #14
	bl	__aeabi_idiv
	ldr	r3, [fp, #-204]
	ldr	r2, [fp, #-212]
	ldr	ip, [fp, #-216]
.L290:
	str	r3, [r9, #2476]
	str	r10, [r9, #2480]
	str	r2, [r9, #2484]
	str	r0, [r9, #2488]
	b	.L286
.L280:
	ldr	r1, [r9, #2568]
	mov	r2, #1
	ldr	r0, [r9, #2968]
	mov	r8, #0
	bl	FSP_ClearLogicFs
	ldr	r1, .L395+56
	mov	r0, r8
	bl	dprint_vfmw
	b	.L359
.L392:
	mov	r0, r7
	bl	Real9_ModifySliceMsg
	cmp	r0, #1
	bne	.L394
	ldr	r2, [fp, #-192]
	ldr	r3, [r7]
	str	r2, [r7, #4]
	ldr	r2, [r3, #856]
	cmp	r2, #1
	bne	.L313
	ldr	r2, [fp, #-192]
	cmp	r2, #0
	beq	.L314
	mov	r4, r2
.L316:
	ldrb	r2, [r4, #1]
	cmp	r2, #2
	bne	.L314
	mov	r2, #0
	str	r2, [r7, #4]
	ldr	r1, [r9, #2568]
	mov	r8, r2
	ldr	r0, [r9, #2968]
	bl	FSP_SetDisplay
	mov	r1, r7
	mov	r0, #9
	bl	ReleasePacket
	b	.L359
.L391:
	mov	r2, #2224
	ldr	r1, .L395+60
	mov	r0, #22
	mov	r8, #0
	bl	dprint_vfmw
	b	.L359
.L393:
	ldr	r2, [r3, #860]
	cmp	r2, #0
	ble	.L314
	ldr	r2, [r7, #4]
	cmp	r2, #0
	beq	.L314
	ldrb	r2, [r2, #1]
	cmp	r2, #2
	bne	.L314
	mov	r2, #0
	str	r2, [r7, #4]
	ldr	r1, [r9, #2568]
	mov	r8, r2
	ldr	r0, [r9, #2968]
	bl	FSP_SetDisplay
	ldr	r2, [r7]
	mov	r1, r7
	mov	r0, #9
	ldr	r3, [r2, #860]
	sub	r3, r3, #1
	str	r3, [r2, #860]
	bl	ReleasePacket
	b	.L359
.L318:
	mov	r0, #0
	mov	r2, r0
	b	.L290
.L389:
	mov	r2, r0
	ldr	r1, [r9, #2568]
	ldr	r0, [r9, #2968]
	mov	r8, r3
	bl	FSP_ClearLogicFs
	b	.L359
.L394:
	mov	r2, r5
	ldr	r1, [r9, #2568]
	ldr	r0, [r9, #2968]
	mov	r8, r4
	bl	FSP_ClearLogicFs
	b	.L359
.L396:
	.align	2
.L395:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC12
	.word	g_event_report
	.word	.LC15
	.word	.LC18
	.word	.LC19
	.word	.LC20
	.word	.LC23
	.word	.LC13
	.word	.LC14
	.word	.LC17
	.word	.LC16
	.word	.LANCHOR0+460
	.word	.LC21
	.word	.LC22
	.word	.LC24
	.fnend
	.size	REAL9DEC_Decode, .-REAL9DEC_Decode
	.align	2
	.global	REAL9DEC_RecycleImage
	.type	REAL9DEC_RecycleImage, %function
REAL9DEC_RecycleImage:
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
	mov	r5, r1
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	add	r4, r0, #49152
	mov	r2, #0
	ldr	r0, [r4, #2968]
	bl	FSP_SetDisplay
	mov	r1, r5
	ldr	r0, [r4, #2968]
	bl	FSP_GetFsImagePtr
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	REAL9DEC_RecycleImage, .-REAL9DEC_RecycleImage
	.align	2
	.global	REAL9DEC_GetRemainImg
	.type	REAL9DEC_GetRemainImg, %function
REAL9DEC_GetRemainImg:
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
	ldr	r3, [r0]
	mov	r4, r0
	ldr	r3, [r3, #12]
	cmp	r3, #1
	beq	.L416
	add	r6, r0, #49152
	ldr	r1, [r6, #2564]
	ldr	r0, [r6, #2968]
	bl	FSP_GetFsImagePtr
	subs	r7, r0, #0
	beq	.L416
	ldr	r1, [r6, #2564]
	ldr	r0, [r6, #2968]
	bl	FSP_GetDisplay
	cmp	r0, #2
	beq	.L414
.L416:
	add	r5, r4, #51712
	add	r5, r5, #56
.L405:
	mov	r0, r5
	bl	GetVoLastImageID
.L415:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L414:
	mov	r0, r4
	add	r5, r4, #51712
	bl	Real9_SetImgFormat
	add	r5, r5, #56
	mov	r3, #1
	str	r3, [r7, #188]
	mov	r2, r3
	ldr	r1, [r6, #2564]
	ldr	r0, [r6, #2968]
	bl	FSP_SetDisplay
	ldr	r0, [r6, #2968]
	mov	r2, r4
	str	r7, [sp]
	mov	r3, r5
	mov	r1, #9
	bl	InsertImgToVoQueue
	cmp	r0, #1
	beq	.L402
	mov	r2, #0
	ldr	r1, [r6, #2564]
	ldr	r0, [r6, #2968]
	bl	FSP_SetDisplay
	b	.L405
.L402:
	ldr	r3, [r7, #160]
	cmp	r3, #100
	bhi	.L405
	ldr	r3, [r7, #112]
	cmp	r3, #31
	bls	.L405
	ldr	r3, [r7, #116]
	cmp	r3, #31
	movhi	r0, #0
	bhi	.L415
	b	.L405
	.fnend
	.size	REAL9DEC_GetRemainImg, .-REAL9DEC_GetRemainImg
	.align	2
	.global	REAL9DEC_VDMPostProc
	.type	REAL9DEC_VDMPostProc, %function
REAL9DEC_VDMPostProc:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #12
	sub	sp, sp, #12
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r6, r1
	mov	r5, r0
	ldr	r1, .L446
	add	r4, r5, #49152
	mov	r8, r2
	mov	r0, #22
	mov	r2, r6
	add	r7, r5, #8192
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, #9
	bl	ReleasePacket
	ldr	r1, [r4, #2568]
	ldr	r0, [r4, #2968]
	bl	FSP_GetFsImagePtr
	cmp	r0, #0
	beq	.L418
	ldr	r3, [r4, #1224]
	cmp	r3, #2
	andne	r8, r8, #31
	strb	r3, [r7, #3190]
	strne	r8, [r4, #1392]
	cmp	r6, #0
	movlt	r6, #0
	blt	.L420
	cmp	r6, #100
	movge	r6, #100
.L420:
	str	r6, [r0, #160]
	mov	r0, #22
	ldr	r1, .L446+4
	bl	dprint_vfmw
	mov	r0, r5
	bl	Real9_SetImgFormat
	ldrb	r3, [r7, #3188]
	cmp	r3, #2
	beq	.L423
	ldr	r3, [r5]
	ldr	r3, [r3, #12]
	cmp	r3, #1
	beq	.L423
	ldr	r3, [r4, #1224]
	cmp	r3, #2
	beq	.L423
	ldrb	r3, [r7, #3189]
	cmp	r3, #1
	ldrhi	r1, [r4, #2560]
	mvnls	r1, #0
	cmn	r1, #1
	str	r1, [r4, #2572]
	beq	.L425
.L445:
	ldr	r0, [r4, #2968]
	bl	FSP_GetFsImagePtr
	ldr	r6, [r4, #2572]
	mov	r1, r6
	mov	r7, r0
	ldr	r0, [r4, #2968]
	bl	FSP_GetRef
	mov	r2, r6
	ldr	r1, .L446+8
	mov	r3, r0
	mov	r0, #12
	bl	dprint_vfmw
	mov	r2, #1
	ldr	r1, [r4, #2572]
	ldr	r0, [r4, #2968]
	bl	FSP_SetDisplay
	add	r3, r5, #51712
	ldr	r0, [r4, #2968]
	add	r3, r3, #56
	str	r7, [sp]
	mov	r2, r5
	mov	r1, #9
	bl	InsertImgToVoQueue
	cmp	r0, #1
	bne	.L444
.L425:
	ldr	r3, [r4, #2460]
	mov	r0, #1
	add	r3, r3, r0
	str	r3, [r4, #2460]
.L418:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L423:
	ldr	r1, [r4, #2568]
	cmn	r1, #1
	str	r1, [r4, #2572]
	bne	.L445
	b	.L425
.L444:
	ldr	r0, [r4, #2968]
	mov	r2, #0
	ldr	r1, [r4, #2572]
	bl	FSP_SetDisplay
	mov	r0, #0
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L447:
	.align	2
.L446:
	.word	.LC25
	.word	.LC26
	.word	.LC27
	.fnend
	.size	REAL9DEC_VDMPostProc, .-REAL9DEC_VDMPostProc
	.align	2
	.global	REAL9DEC_GetImageBuffer
	.type	REAL9DEC_GetImageBuffer, %function
REAL9DEC_GetImageBuffer:
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
	add	r4, r0, #49152
	mov	r5, r0
	ldr	r0, [r4, #2968]
	bl	FSP_IsNewFsAvalible
	cmp	r0, #1
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r0, [r4, #2968]
	bl	FSP_IsNewFsAvalible
	cmn	r0, #1
	beq	.L454
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L454:
	add	r1, r5, #51712
	ldr	r0, [r4, #2968]
	add	r1, r1, #56
	bl	FSP_ClearNotInVoQueue
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	REAL9DEC_GetImageBuffer, .-REAL9DEC_GetImageBuffer
	.align	2
	.global	REAL9DEC_Support
	.type	REAL9DEC_Support, %function
REAL9DEC_Support:
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
	mov	r3, #1
	str	r3, [r0]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	REAL9DEC_Support, .-REAL9DEC_Support
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	gs_VLCDecodeTable, %object
	.size	gs_VLCDecodeTable, 256
gs_VLCDecodeTable:
	.byte	-128
	.byte	-127
	.byte	112
	.byte	112
	.byte	-126
	.byte	-125
	.byte	113
	.byte	113
	.byte	80
	.byte	80
	.byte	80
	.byte	80
	.byte	80
	.byte	80
	.byte	80
	.byte	80
	.byte	-124
	.byte	-123
	.byte	114
	.byte	114
	.byte	-122
	.byte	-121
	.byte	115
	.byte	115
	.byte	81
	.byte	81
	.byte	81
	.byte	81
	.byte	81
	.byte	81
	.byte	81
	.byte	81
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	48
	.byte	-120
	.byte	-119
	.byte	116
	.byte	116
	.byte	-118
	.byte	-117
	.byte	117
	.byte	117
	.byte	82
	.byte	82
	.byte	82
	.byte	82
	.byte	82
	.byte	82
	.byte	82
	.byte	82
	.byte	-116
	.byte	-115
	.byte	118
	.byte	118
	.byte	-114
	.byte	-113
	.byte	119
	.byte	119
	.byte	83
	.byte	83
	.byte	83
	.byte	83
	.byte	83
	.byte	83
	.byte	83
	.byte	83
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	49
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.type	MBA_FieldWidth, %object
	.size	MBA_FieldWidth, 24
MBA_FieldWidth:
	.word	6
	.word	7
	.word	9
	.word	11
	.word	13
	.word	14
.LC0:
	.word	160
	.word	176
	.word	240
	.word	320
	.word	352
	.word	640
	.word	704
	.word	0
.LC1:
	.word	120
	.word	132
	.word	144
	.word	240
	.word	288
	.word	480
	.word	0
	.word	0
.LC2:
	.word	180
	.word	360
	.word	576
	.word	0
	.type	GetBitsMask, %object
	.size	GetBitsMask, 100
GetBitsMask:
	.word	0
	.word	1
	.word	3
	.word	7
	.word	15
	.word	31
	.word	63
	.word	127
	.word	255
	.word	511
	.word	1023
	.word	2047
	.word	4095
	.word	8191
	.word	16383
	.word	32767
	.word	65535
	.word	131071
	.word	262143
	.word	524287
	.word	1048575
	.word	2097151
	.word	4194303
	.word	8388607
	.word	16777215
	.type	__FUNCTION__.14962, %object
	.size	__FUNCTION__.14962, 16
__FUNCTION__.14962:
	.ascii	"REAL9DEC_Decode\000"
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC3:
	.ascii	"get frame store fail!\012\000"
	.space	1
.LC4:
	.ascii	"line: %d, pImage is NULL!\012\000"
	.space	1
.LC5:
	.ascii	"get image buffer ok: LogicFsID = %d\012\000"
	.space	3
.LC6:
	.ascii	"decode %p, disp %p, tf %p\012\000"
	.space	1
.LC7:
	.ascii	"image size abnormal (%dx%d) in MB\012\000"
	.space	1
.LC8:
	.ascii	"real9 actual frame size(%dx%d) exeed max config(%dx"
	.ascii	"%d)\012\000"
.LC9:
	.ascii	"partition fs memory fail!\012\000"
	.space	1
.LC10:
	.ascii	"-1 == VCTRL_GetChanIDByCtx() Err! \012\000"
.LC11:
	.ascii	"Decoding quits at frm %d\012\000"
	.space	2
.LC12:
	.ascii	"ERROR: frm %d, Invalid packet pointer!\012\000"
.LC13:
	.ascii	"Real9_CB_GetPictureHeader Error!\012\000"
	.space	2
.LC14:
	.ascii	"pic width/height to large,MbWidth = %d, MbHeight = "
	.ascii	"%d\000"
	.space	2
.LC15:
	.ascii	"new seq size %d * %d\012\000"
	.space	2
.LC16:
	.ascii	"Real9_ArrangeVHBMem err\012\000"
	.space	3
.LC17:
	.ascii	"Fatal Error: frm%d, get image buffer failed\012\000"
	.space	3
.LC18:
	.ascii	"dec_pts: %lld Usertag = %lld\012\000"
	.space	2
.LC19:
	.ascii	"---------- unref %d\012\000"
	.space	3
.LC20:
	.ascii	"++++++++++ ref %d\012\000"
	.space	1
.LC21:
	.ascii	"CurFsID abnormal!,%s %d (NULL == pCur) || (NULL == "
	.ascii	"pFwd) || (NULL == pBwd)!!\012\000"
	.space	2
.LC22:
	.ascii	"CurFsID abnormal!\012\000"
	.space	1
.LC23:
	.ascii	"dec addr: cur,cur2d,fwd,bwd,currpmv,colpmv = %p,%p,"
	.ascii	"%p,%p,%p,%p\012\000"
.LC24:
	.ascii	"line:%d! i > (RV9_MAX_SLC_PARAM_NUM - 2)\012\000"
	.space	2
.LC25:
	.ascii	"ErrRatio = %d\012\000"
	.space	1
.LC26:
	.ascii	"DEBUG: DEC over\012\000"
	.space	3
.LC27:
	.ascii	"insert buf %d ref %d\012\000"
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
