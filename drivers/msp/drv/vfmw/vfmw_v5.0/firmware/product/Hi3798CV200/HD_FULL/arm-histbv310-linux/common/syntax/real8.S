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
	.file	"real8.c"

	.text
	.align	2
	.global	Real8_CB_GetBits
	.type	Real8_CB_GetBits, %function
Real8_CB_GetBits:
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
	.size	Real8_CB_GetBits, .-Real8_CB_GetBits
	.align	2
	.global	Real8_CB_Get1Bit
	.type	Real8_CB_Get1Bit, %function
Real8_CB_Get1Bit:
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
	.size	Real8_CB_Get1Bit, .-Real8_CB_Get1Bit
	.align	2
	.global	Real8_CB_GetVLCBits
	.type	Real8_CB_GetVLCBits, %function
Real8_CB_GetVLCBits:
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
	.size	Real8_CB_GetVLCBits, .-Real8_CB_GetVLCBits
	.align	2
	.global	Real8_GetImageBuffer
	.type	Real8_GetImageBuffer, %function
Real8_GetImageBuffer:
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
	ldr	r0, [r4, #2984]
	bl	FSP_NewLogicFs
	cmp	r0, #0
	str	r0, [r4, #2588]
	blt	.L17
	mov	r1, r0
	ldr	r0, [r4, #2984]
	bl	FSP_GetLogicFs
	subs	r5, r0, #0
	beq	.L18
	ldr	r2, [r4, #2588]
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
	ldr	r1, [r4, #2584]
	ldr	r0, [r4, #2984]
	mov	r2, #1
	bl	FSP_ClearLogicFs
	mov	r2, #1
	ldr	r1, [r4, #2580]
	mov	r5, #0
	ldr	r0, [r4, #2984]
	bl	FSP_ClearLogicFs
	str	r5, [r4, #2580]
	str	r5, [r4, #2584]
	ldr	r0, [r4, #2984]
	bl	FSP_GetNullLogicFs
	add	r1, r6, #51712
	add	r1, r1, #72
	str	r0, [r4, #2584]
	str	r0, [r4, #2580]
	strb	r5, [r7, #3199]
	ldr	r0, [r4, #2984]
	bl	FSP_ClearNotInVoQueue
	mov	r0, r5
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L18:
	mov	r2, #568
	ldr	r1, .L19+12
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r5
	b	.L12
.L20:
	.align	2
.L19:
	.word	.LC6
	.word	.LC7
	.word	.LC4
	.word	.LC5
	.fnend
	.size	Real8_GetImageBuffer, .-Real8_GetImageBuffer
	.align	2
	.global	Real8_ArrangeVHBMem
	.type	Real8_ArrangeVHBMem, %function
Real8_ArrangeVHBMem:
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
	ldr	r2, [r2, #96]
	mov	r5, r1
	ldr	r3, [r4, #92]
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
	ldr	r9, [r4, #88]
	mov	r7, #5
	ldr	r10, [r4, #84]
	mov	r6, #2
	mov	r8, #4
.L32:
	ldr	r3, .L53
	mov	r2, #32
	mov	r1, #0
	sub	r0, fp, #76
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r0, [r4, #84]
	ldr	r1, [r5]
	mov	r3, #0
	ldr	r2, [r4, #88]
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
	ldr	r0, [r6, #2984]
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
	ldr	r2, [r4, #88]
	ldr	r0, [r1, #660]
	cmp	r2, r0
	bhi	.L49
	ldr	r3, [r4, #84]
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
	ldr	r0, [r6, #2984]
	ldr	r2, [r1, #24]
	ldr	r1, [r1, #20]
	bl	FSP_ConfigFrameBuf
	cmp	r0, r4
	bne	.L51
	add	r5, r5, #8192
	mov	r3, #1
	mov	r0, r3
	strb	r3, [r5, #3196]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L38:
	mov	r3, #1
	strb	r7, [fp, #-71]
	strb	r3, [fp, #-73]
	b	.L40
.L47:
	ldr	r2, [r4, #88]
	ldr	r9, [r1, #660]
	cmp	r2, r9
	bhi	.L52
	ldr	r3, [r4, #84]
	ldr	r10, [r1, #664]
	cmp	r3, r10
	bhi	.L29
	add	r3, r5, #8192
	ldrb	r0, [r3, #3196]
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
	ldr	r3, [r4, #84]
.L35:
	stmia	sp, {r0, ip}
	mov	r0, #0
	ldr	r1, .L53+8
	bl	dprint_vfmw
	mov	r0, #0
	b	.L45
.L52:
	ldr	r10, [r1, #664]
	ldr	r3, [r4, #84]
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
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.fnend
	.size	Real8_ArrangeVHBMem, .-Real8_ArrangeVHBMem
	.align	2
	.global	Real8_CB_GetCPFMT
	.type	Real8_CB_GetCPFMT, %function
Real8_CB_GetCPFMT:
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
	str	r4, [r6, #88]
	bl	Real8_CB_Get1Bit
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
	str	r7, [r6, #84]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	Real8_CB_GetCPFMT, .-Real8_CB_GetCPFMT
	.align	2
	.global	Real8_CB_SetDimensions
	.type	Real8_CB_SetDimensions, %function
Real8_CB_SetDimensions:
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
	ldr	r3, [r0, #88]
	ldr	r2, [r0, #84]
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
	str	r3, [r0, #28]
	mul	r3, r3, r2
	str	r2, [r0, #24]
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
	str	r3, [r0, #32]
	ldmfd	sp, {fp, sp, pc}
.L80:
	cmp	r2, #1152
	bne	.L61
	mov	r2, #88
	mov	r3, #72
	str	r2, [r0, #28]
	str	r3, [r0, #24]
.L75:
	mov	r2, #4
	b	.L62
.L76:
	cmp	r2, #96
	bne	.L61
	mov	r2, #8
	mov	r3, #6
	str	r2, [r0, #28]
	mov	r2, #0
	str	r3, [r0, #24]
	b	.L62
.L77:
	cmp	r2, #144
	bne	.L61
	mov	r2, #11
	mov	r3, #9
	str	r2, [r0, #28]
	str	r3, [r0, #24]
.L71:
	mov	r2, #1
	b	.L62
.L78:
	cmp	r2, #288
	bne	.L61
	mov	r2, #22
	mov	r3, #18
	str	r2, [r0, #28]
	str	r3, [r0, #24]
.L72:
	mov	r2, #2
	b	.L62
.L79:
	cmp	r2, #576
	bne	.L61
	mov	r2, #44
	mov	r3, #36
	str	r2, [r0, #28]
	str	r3, [r0, #24]
.L73:
	mov	r2, #3
	b	.L62
.L82:
	.align	2
.L81:
	.word	.LANCHOR0
	.fnend
	.size	Real8_CB_SetDimensions, .-Real8_CB_SetDimensions
	.align	2
	.global	Real8_CB_GetPicSize
	.type	Real8_CB_GetPicSize, %function
Real8_CB_GetPicSize:
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
	ldr	ip, [r9, #32]
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
	bl	Real8_CB_Get1Bit
	cmp	r0, #0
	beq	.L84
	ldr	r3, [r9, #64]
	str	r3, [r8]
	ldr	r3, [r9, #68]
	str	r3, [r7]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L98:
	mov	r0, r4
	mov	r9, r9, asl #1
	bl	Real8_CB_Get1Bit
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
	.size	Real8_CB_GetPicSize, .-Real8_CB_GetPicSize
	.align	2
	.global	Real8_CB_FindNextSliceStartCode
	.type	Real8_CB_FindNextSliceStartCode, %function
Real8_CB_FindNextSliceStartCode:
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
	movgt	r4, #0
	bgt	.L104
	b	.L105
.L110:
	bl	BsSkip
	cmp	r4, r6
	beq	.L105
.L104:
	mov	r1, #17
	mov	r0, r5
	bl	BsShow
	add	r4, r4, #1
	mov	r1, #8
	mov	r3, r0
	cmp	r3, #1
	mov	r0, r5
	bne	.L110
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L105:
	mov	r3, #0
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	Real8_CB_FindNextSliceStartCode, .-Real8_CB_FindNextSliceStartCode
	.align	2
	.global	Real8_CB_SearchBits_IgnoreOnly0
	.type	Real8_CB_SearchBits_IgnoreOnly0, %function
Real8_CB_SearchBits_IgnoreOnly0:
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
	beq	.L112
	ands	r5, r4, r6
	bne	.L112
	ldr	r3, .L118
	add	r10, r3, r10, lsl #2
	ldr	r10, [r10, #360]
	b	.L113
.L114:
	tst	r4, r6
	bne	.L112
.L113:
	mov	r0, r8
	and	r4, r10, r4, asl #1
	bl	Real8_CB_Get1Bit
	add	r5, r5, #1
	orr	r4, r0, r4
	cmp	r7, r4
	cmpne	r9, r5
	bhi	.L114
.L112:
	rsb	r0, r7, r4
	clz	r0, r0
	mov	r0, r0, lsr #5
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L119:
	.align	2
.L118:
	.word	.LANCHOR0
	.fnend
	.size	Real8_CB_SearchBits_IgnoreOnly0, .-Real8_CB_SearchBits_IgnoreOnly0
	.align	2
	.global	Real8_CB_SetRPRSizes
	.type	Real8_CB_SetRPRSizes, %function
Real8_CB_SetRPRSizes:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #40
	sub	sp, sp, #40
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	lr, .L121
	sub	r3, fp, #28
	mov	r4, r0
	mov	r5, r1
	mov	r7, r2
	add	r6, r3, r1, lsl #2
	ldmia	lr!, {r0, r1, r2, r3}
	sub	ip, fp, #64
	str	r5, [r4, #16]
	str	r7, [r4, #12]
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	ldr	lr, [lr]
	stmia	ip!, {r0, r1, r2, r3}
	str	lr, [ip]
	ldr	r3, [r6, #-36]
	str	r3, [r4, #8]
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L122:
	.align	2
.L121:
	.word	.LANCHOR0+460
	.fnend
	.size	Real8_CB_SetRPRSizes, .-Real8_CB_SetRPRSizes
	.align	2
	.global	Real8_CB_GetSSC
	.type	Real8_CB_GetSSC, %function
Real8_CB_GetSSC:
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
	ldr	r3, [r1, #76]
	cmp	r3, #1
	beq	.L125
	bl	Real8_CB_FindNextSliceStartCode
	adds	r0, r0, #0
	movne	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L125:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Real8_CB_GetSSC, .-Real8_CB_GetSSC
	.align	2
	.global	Real8_CB_GetSliceHeader
	.type	Real8_CB_GetSliceHeader, %function
Real8_CB_GetSliceHeader:
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
	ldr	r4, [fp, #8]
	mov	r5, r2
	mov	r7, r3
	mov	r6, r0
	ldr	ip, [r4, #76]
	cmp	ip, #1
	beq	.L160
	cmp	r1, #0
	beq	.L161
	mov	r2, #0
	str	r2, [r5]
	ldr	r2, [fp, #4]
	mvn	r3, #0
	mov	r0, #1
	str	r3, [r2]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L160:
	cmp	r1, #0
	bne	.L129
	mov	r1, #3
	ldr	r9, [r4, #40]
	bl	BsShow
	mov	r1, #3
	mov	r8, r0
	mov	r0, r6
	bl	BsSkip
	cmp	r8, #7
	bhi	.L132
	ldr	r3, .L164
	add	r8, r3, r8, lsl #2
	ldr	r3, [r8, #496]
	cmp	r3, #2
	bhi	.L132
	cmn	r9, #1
	mov	r1, #2
	mov	r0, r6
	movne	r9, #0
	moveq	r9, #1
	cmp	r9, #0
	bne	.L162
	bl	BsShow
	mov	r1, #2
	mov	r8, r0
	mov	r0, r6
	bl	BsSkip
	ldr	r3, [r4, #36]
	cmp	r3, r8
	bne	.L132
.L134:
	mov	r0, r6
	bl	Real8_CB_Get1Bit
	cmp	r0, #0
	bne	.L132
	mov	r1, #5
	mov	r0, r6
	bl	BsShow
	mov	r1, #5
	mov	r8, r0
	mov	r0, r6
	bl	BsSkip
	uxtb	r0, r8
	cmp	r0, #31
	strb	r0, [r4, #6]
	bhi	.L132
	mov	r1, #1
	mov	r0, r6
	bl	BsShow
	mov	r1, #1
	mov	r8, r0
	mov	r0, r6
	bl	BsSkip
	adds	r8, r8, #0
	mov	r1, #13
	mov	r0, r6
	movne	r8, #1
	cmp	r9, #0
	strb	r8, [r4, #5]
	beq	.L135
	bl	BsShow
	mov	r1, #13
	mov	r9, r0
	mov	r0, r6
	bl	BsSkip
	ldr	r8, [r4, #8]
	str	r9, [r4, #44]
	cmp	r8, #0
	beq	.L153
	mov	r1, r8
	mov	r0, r6
	bl	BsShow
	mov	r1, r8
	mov	r9, r0
	mov	r0, r6
	bl	BsSkip
	ldr	r3, [r4, #12]
	str	r9, [r4, #56]
	cmp	r3, #0
	beq	.L132
	add	r1, r3, r9, lsl #3
	ldr	r2, [r3, r9, asl #3]
	mov	r0, r4
	ldr	r3, [r1, #4]
	str	r2, [r4, #60]
	str	r2, [r4, #88]
	str	r3, [r4, #64]
	str	r3, [r4, #84]
	bl	Real8_CB_SetDimensions
.L153:
	ldr	r8, [r4, #32]
	mov	r0, r6
	mov	r1, r8
	bl	BsShow
	mov	r1, r8
	mov	r9, r0
	mov	r0, r6
	bl	BsSkip
	mov	r1, #1
	str	r9, [r4, #40]
	mov	r0, r6
	bl	BsShow
	mov	r1, #1
	mov	r8, r0
	mov	r0, r6
	bl	BsSkip
	strb	r8, [r4, #4]
.L129:
	ldr	r2, [r4, #40]
	mov	r3, #0
	ldr	r1, [fp, #4]
	mov	r0, #1
	str	r2, [r5]
	ldrb	r2, [r4, #6]
	str	r2, [r1]
	str	r3, [r7]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L161:
	bl	Real8_CB_Get1Bit
	cmp	r0, #1
	beq	.L163
.L132:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L163:
	ldr	r8, [r4, #32]
	mov	r0, r6
	mov	r1, r8
	bl	BsShow
	mov	r1, r8
	mov	r9, r0
	mov	r0, r6
	bl	BsSkip
	str	r9, [r5]
	ldr	r3, [r4, #32]
	cmp	r3, #11
	bls	.L145
	mov	r0, r6
	bl	Real8_CB_Get1Bit
	cmp	r0, #1
	bne	.L132
.L145:
	mov	r1, #5
	mov	r0, r6
	bl	BsShow
	mov	r1, #5
	mov	r4, r0
	mov	r0, r6
	bl	BsSkip
	ldr	r3, [fp, #4]
	cmp	r4, #31
	str	r4, [r3]
	bgt	.L132
	mov	r0, r6
	bl	Real8_CB_Get1Bit
	cmp	r0, #1
	mov	r4, r0
	bne	.L132
	mov	r1, #2
	mov	r0, r6
	bl	BsShow
	mov	r1, #2
	mov	r5, r0
	mov	r0, r6
	bl	BsSkip
	str	r5, [r7]
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L162:
	bl	BsShow
	mov	r1, #2
	mov	r8, r0
	mov	r0, r6
	bl	BsSkip
	str	r8, [r4, #36]
	b	.L134
.L135:
	bl	BsShow
	mov	r1, #13
	mov	r8, r0
	mov	r0, r6
	bl	BsSkip
	ldr	r3, [r4, #44]
	cmp	r3, r8
	bne	.L132
	ldr	r8, [r4, #8]
	cmp	r8, #0
	beq	.L157
	mov	r1, r8
	mov	r0, r6
	bl	BsShow
	mov	r1, r8
	mov	r9, r0
	mov	r0, r6
	bl	BsSkip
	ldr	r3, [r4, #56]
	cmp	r3, r9
	bne	.L132
.L157:
	ldr	r8, [r4, #32]
	mov	r0, r6
	mov	r1, r8
	bl	BsShow
	mov	r1, r8
	mov	r9, r0
	mov	r0, r6
	bl	BsSkip
	mov	r1, #1
	str	r9, [r4, #40]
	mov	r0, r6
	bl	BsShow
	mov	r1, #1
	mov	r8, r0
	mov	r0, r6
	bl	BsSkip
	ldrb	r3, [r4, #4]
	cmp	r3, r8
	bne	.L132
	b	.L129
.L165:
	.align	2
.L164:
	.word	.LANCHOR0
	.fnend
	.size	Real8_CB_GetSliceHeader, .-Real8_CB_GetSliceHeader
	.align	2
	.global	Real8_CB_GetPictureHeader
	.type	Real8_CB_GetPictureHeader, %function
Real8_CB_GetPictureHeader:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #28
	sub	sp, sp, #28
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r3, [r1, #76]
	mov	r4, r1
	mov	r5, r0
	cmp	r3, #1
	beq	.L192
	ldr	r3, .L195
	mov	r2, #140
	mov	r1, #0
	mov	r0, r4
	ldr	r3, [r3, #48]
	blx	r3
	mov	r1, #24
	mov	r0, r5
	bl	BsShow
	mov	r1, #24
	mov	r6, r0
	mov	r0, r5
	bl	BsSkip
	cmp	r6, #1
	bne	.L185
	mov	r0, r5
	sub	r1, fp, #32
	bl	Real8_CB_GetVLCBits
	cmp	r0, #30
	bls	.L185
	ldr	r3, [fp, #-32]
	ands	r2, r3, #1
	bne	.L185
	tst	r3, #2
	mov	r0, r5
	strne	r2, [r4, #88]
	moveq	r1, #176
	moveq	r2, #144
	streq	r1, [r4, #88]
	sub	r1, fp, #32
	str	r2, [r4, #84]
	ubfx	r2, r3, #2, #5
	ubfx	r3, r3, #7, #8
	str	r2, [r4, #120]
	str	r3, [r4, #108]
	bl	Real8_CB_GetVLCBits
	cmp	r0, #1
	streq	r0, [r4, #80]
	beq	.L180
	cmp	r0, #3
	beq	.L193
	cmp	r0, #5
	bne	.L185
	ldr	r3, [fp, #-32]
	cmp	r3, #0
	bne	.L185
	mov	r3, #2
	str	r3, [r4, #80]
.L180:
	ldr	r3, [r4, #88]
	cmp	r3, #0
	beq	.L194
.L182:
	sub	r3, r3, #48
	movw	r2, #8144
	cmp	r3, r2
	bhi	.L185
.L191:
	ldr	r3, [r4, #84]
	sub	r3, r3, #48
	cmp	r3, r2
	bhi	.L185
	mov	r0, r4
	bl	Real8_CB_SetDimensions
	mov	r0, #1
.L168:
	ldr	r3, [r4, #88]
	ldr	r2, [r4, #84]
	add	r3, r3, #15
	add	r2, r2, #15
	mov	r3, r3, lsr #4
	str	r3, [r4, #96]
	mov	r2, r2, lsr #4
	str	r2, [r4, #92]
	mul	r3, r3, r2
	str	r3, [r4, #100]
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L193:
	ldr	r3, [fp, #-32]
	cmp	r3, #1
	moveq	r3, #0
	streq	r3, [r4, #80]
	beq	.L180
.L185:
	mvn	r0, #1
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L192:
	str	r1, [sp, #4]
	mvn	r2, #0
	sub	r3, fp, #32
	str	r2, [r1, #40]
	str	r3, [sp]
	sub	r2, fp, #36
	sub	r3, fp, #40
	mov	r1, #0
	bl	Real8_CB_GetSliceHeader
	cmp	r0, #1
	mvnne	r0, #1
	bne	.L168
	ldr	r3, [r4, #36]
	cmp	r3, #3
	ldrls	pc, [pc, r3, asl #2]
	b	.L169
.L171:
	.word	.L170
	.word	.L172
	.word	.L173
	.word	.L174
.L194:
	mov	r0, r5
	mov	r1, r4
	bl	Real8_CB_GetCPFMT
	cmp	r0, #0
	beq	.L185
	ldr	r3, [r4, #88]
	b	.L182
.L172:
	mov	r3, #0
	str	r3, [r4, #80]
	str	r3, [r4, #20]
.L169:
	ldr	r3, [r4, #88]
	add	r0, r4, #44
	movw	r2, #8144
	ldrb	r5, [r4, #4]
	sub	r3, r3, #48
	ldrb	lr, [r4, #5]
	cmp	r3, r2
	ldrb	ip, [r4, #6]
	ldmia	r0, {r0, r1, r3}
	str	r5, [r4, #112]
	str	lr, [r4, #116]
	str	ip, [r4, #120]
	str	r0, [r4, #108]
	str	r1, [r4, #128]
	str	r3, [r4, #132]
	bls	.L191
	b	.L185
.L174:
	mov	r3, #2
	str	r3, [r4, #80]
	b	.L169
.L173:
	mov	r3, #1
	str	r3, [r4, #80]
	b	.L169
.L170:
	mov	r2, #0
	mov	r3, #1
	str	r2, [r4, #80]
	str	r3, [r4, #20]
	b	.L169
.L196:
	.align	2
.L195:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	Real8_CB_GetPictureHeader, .-Real8_CB_GetPictureHeader
	.align	2
	.global	Real8_SetImgFormat
	.type	Real8_SetImgFormat, %function
Real8_SetImgFormat:
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
	ldr	r1, [r6, #2588]
	ldr	r0, [r6, #2984]
	bl	FSP_GetFsImagePtr
	subs	r4, r0, #0
	beq	.L197
	ldr	r3, [r6, #1304]
	mov	r5, #0
	str	r5, [r4, #96]
	mov	r1, r5
	and	r3, r3, #3
	str	r3, [r4, #100]
	orr	r2, r3, #7168
	str	r3, [r4, #104]
	orr	r2, r2, #32
	str	r2, [r4, #108]
	ldr	r3, [r6, #1312]
	str	r3, [r4, #112]
	ldr	r3, [r6, #1308]
	str	r3, [r4, #116]
	bl	SetAspectRatio
	ldr	r3, [r7]
	ldr	r3, [r3, #28]
	cmp	r3, #25
	beq	.L203
.L199:
	mov	r3, #8
	mov	r2, #1
	mov	r1, #0
	str	r3, [r4, #340]
	str	r3, [r4, #344]
	str	r3, [r4, #352]
	str	r3, [r4, #348]
	strb	r1, [r4, #328]
	strb	r2, [r4, #335]
	strb	r2, [r4, #333]
.L197:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L203:
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
	b	.L199
	.fnend
	.size	Real8_SetImgFormat, .-Real8_SetImgFormat
	.align	2
	.global	RV8_RecordVFMWState
	.type	RV8_RecordVFMWState, %function
RV8_RecordVFMWState:
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
	.size	RV8_RecordVFMWState, .-RV8_RecordVFMWState
	.align	2
	.global	Real8_WriteSliceMsg
	.type	Real8_WriteSliceMsg, %function
Real8_WriteSliceMsg:
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
	mov	r2, #44
	mla	r2, r2, r1, r0
	add	r3, r0, #49152
	add	r1, r1, #1
	ldr	r4, [r3, #1392]
	add	ip, r2, #128
	add	lr, r2, #136
	str	r4, [r2, #108]
	ldr	r4, [r3, #1384]
	str	r4, [r2, #116]
	ldr	r4, [r3, #1388]
	str	r4, [r2, #124]
	ldr	r4, [r3, #1404]
	str	r4, [r2, #112]
	ldr	r4, [r3, #1396]
	str	r4, [r2, #120]
	ldr	r4, [r3, #1400]
	str	r4, [r2, #128]
	ldr	r2, [r3, #1372]
	str	r2, [ip, #4]
	ldr	r2, [r3, #1368]
	str	r2, [ip, #8]
	ldr	r2, [r3, #1364]
	str	r2, [lr, #4]
	ldr	r3, [r3, #1376]
	str	r3, [lr, #8]
	str	r1, [r0, #44]
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	Real8_WriteSliceMsg, .-Real8_WriteSliceMsg
	.align	2
	.global	Real8_WritePicMsg
	.type	Real8_WritePicMsg, %function
Real8_WritePicMsg:
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
	ldr	r2, [r3, #1304]
	cmp	r2, #2
	strb	r2, [r0, #20]
	ldr	r2, [r3, #1320]
	str	r2, [r0, #12]
	ldr	r2, [r3, #1316]
	str	r2, [r0, #16]
	ldr	r2, [r3, #2504]
	str	r2, [r0, #24]
	ldr	r2, [r3, #2508]
	str	r2, [r0, #28]
	ldr	r2, [r3, #1344]
	str	r2, [r0, #32]
	ldr	r1, [r3, #1408]
	str	r1, [r0, #36]
	ldr	r1, [r3, #1412]
	str	r1, [r0, #40]
	strne	r2, [r3, #1408]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Real8_WritePicMsg, .-Real8_WritePicMsg
	.align	2
	.global	Real8_WriteReg
	.type	Real8_WriteReg, %function
Real8_WriteReg:
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
	str	r1, [r0, #48]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Real8_WriteReg, .-Real8_WriteReg
	.align	2
	.global	Real8_ModifySliceMsg
	.type	Real8_ModifySliceMsg, %function
Real8_ModifySliceMsg:
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
	ldr	r2, [r0, #144]
	ldr	r3, [r0, #12]
	cmp	r2, #0
	ldr	ip, [r0, #16]
	bne	.L216
	mul	ip, r3, ip
	ldr	r5, [r0, #44]
	cmp	r5, #2
	sub	ip, ip, #1
	bls	.L215
	ldr	r3, [r0, #188]
	sub	lr, r5, #1
	cmp	r3, #0
	cmpgt	ip, r3
	ble	.L216
	mov	r2, r0
	mov	r3, #1
	b	.L217
.L218:
	ldr	r1, [r2, #232]
	add	r2, r2, #44
	cmp	ip, r1
	cmpgt	r1, #0
	ble	.L216
.L217:
	add	r3, r3, #1
	cmp	r3, lr
	bne	.L218
.L215:
	cmp	r5, #1
	bls	.L219
	sub	r4, r5, #1
	mov	r3, r0
	mov	r2, #0
	b	.L220
.L221:
	ldr	lr, [r3, #144]
	add	r3, r3, #44
	add	r2, r2, #1
	ldr	r1, [r3, #144]
	cmp	lr, r1
	bge	.L216
.L220:
	cmp	r2, r4
	bne	.L221
	mov	r3, #44
	mla	r2, r3, r2, r0
	ldr	r3, [r2, #144]
	cmp	ip, r3
	cmpge	r3, #0
	ble	.L216
.L219:
	cmp	r5, #0
	beq	.L222
	sub	r7, r5, #1
	mov	r6, r0
	mov	lr, r0
	mov	r4, #0
	b	.L225
.L240:
	cmp	r4, r5
	beq	.L239
.L225:
	cmp	r4, r7
	streq	ip, [lr, #148]
	add	r4, r4, #1
	add	lr, lr, #44
	ldrne	r3, [lr, #144]
	moveq	r1, ip
	subne	r1, r3, #1
	ldr	r3, [lr, #100]
	strne	r1, [lr, #104]
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
	beq	.L240
.L216:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L239:
	ldr	r2, [r0, #108]
	mov	r1, r2
	b	.L228
.L241:
	ldr	r1, [r6, #108]
.L228:
	cmp	r2, r1
	ldr	ip, [r6, #112]
	add	r3, r3, #1
	movcs	r2, r1
	cmp	ip, r2
	bcs	.L226
	ldr	r1, [r6, #128]
	cmp	r1, #0
	movne	r2, ip
.L226:
	cmp	r5, r3
	add	r6, r6, #44
	bne	.L241
	bic	r2, r2, #15
	ldr	lr, [r0, #44]
	str	r2, [r0, #52]
	mov	r3, r0
	mov	ip, #0
	b	.L232
.L242:
	ldr	r4, [r3, #116]
	rsb	r2, r2, r1
	and	r1, r4, #7
	add	r2, r2, r4, lsr #3
	and	r4, r2, #15
	bic	r2, r2, #15
	str	r2, [r3, #108]
	add	r2, r1, r4, lsl #3
	str	r2, [r3, #116]
.L230:
	add	ip, ip, #1
	add	r3, r3, #44
	cmp	lr, ip
	bls	.L231
	ldr	r2, [r0, #52]
.L232:
	ldr	r1, [r3, #112]
	cmp	r1, #0
	rsb	r4, r2, r1
	ldr	r1, [r3, #108]
	beq	.L242
	ldr	r5, [r3, #116]
	rsb	r2, r2, r1
	ldr	r7, [r3, #120]
	and	r6, r5, #7
	add	r2, r2, r5, lsr #3
	and	r5, r7, #7
	add	r1, r4, r7, lsr #3
	and	r4, r2, #15
	and	r7, r1, #15
	bic	r2, r2, #15
	add	r4, r6, r4, lsl #3
	str	r2, [r3, #108]
	bic	r1, r1, #15
	add	r2, r5, r7, lsl #3
	str	r4, [r3, #116]
	str	r2, [r3, #120]
	str	r1, [r3, #112]
	b	.L230
.L222:
	ldr	r3, [r0, #108]
	bic	r3, r3, #15
	str	r3, [r0, #52]
.L231:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	Real8_ModifySliceMsg, .-Real8_ModifySliceMsg
	.align	2
	.global	REAL8DEC_Init
	.type	REAL8DEC_Init, %function
REAL8DEC_Init:
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
	ldr	r3, .L247
	add	r4, r0, #49152
	mov	r7, r1
	movw	r2, #52144
	mov	r1, #0
	ldr	r8, [r4, #2976]
	mov	r5, r0
	ldr	r3, [r3, #48]
	mov	r6, r1
	blx	r3
	add	r0, r5, #51712
	add	r0, r0, #72
	str	r8, [r4, #2976]
	bl	ResetVoQueue
	str	r7, [r5]
	mov	r3, #15
	str	r3, [r4, #1408]
	str	r3, [r4, #1412]
	add	r2, r5, #8192
	ldr	ip, [r7, #8]
	mov	r3, #1
	strb	r6, [r2, #3196]
	mov	r1, #8192
	mov	r0, r5
	strb	ip, [r2, #3194]
	str	r1, [r4, #1328]
	str	r3, [r4, #1300]
	strb	r3, [r4, #1224]
	bl	VCTRL_GetChanIDByCtx
	cmn	r0, #1
	str	r0, [r4, #2984]
	mov	r0, r6
	beq	.L246
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L246:
	ldr	r1, .L247+4
	bl	dprint_vfmw
	mvn	r0, #19
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L248:
	.align	2
.L247:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC11
	.fnend
	.size	REAL8DEC_Init, .-REAL8DEC_Init
	.align	2
	.global	REAL8DEC_Destroy
	.type	REAL8DEC_Destroy, %function
REAL8DEC_Destroy:
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
	ldr	r1, .L250
	mov	r0, #2
	ldr	r2, [r3, #2480]
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L251:
	.align	2
.L250:
	.word	.LC12
	.fnend
	.size	REAL8DEC_Destroy, .-REAL8DEC_Destroy
	.global	__aeabi_idiv
	.align	2
	.global	REAL8DEC_Decode
	.type	REAL8DEC_Decode, %function
REAL8DEC_Decode:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #308
	sub	sp, sp, #308
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r2, #140
	mov	r6, r0
	mov	r4, r1
	add	r10, r6, #49152
	mov	r1, #0
	sub	r0, fp, #184
	bl	memset
	mov	r2, #64
	mov	r1, #0
	sub	r0, fp, #248
	bl	memset
	ldr	r2, [r10, #1284]
	ldr	r3, [r10, #1288]
	cmp	r4, #0
	mov	r0, #1
	mov	r1, #8192
	add	ip, r6, #8
	str	r2, [r10, #1292]
	str	ip, [fp, #-300]
	str	r2, [fp, #-116]
	str	r2, [fp, #-124]
	str	r3, [r10, #1296]
	str	r3, [fp, #-112]
	str	r3, [fp, #-120]
	str	r0, [r10, #1300]
	str	r0, [fp, #-108]
	str	r1, [r10, #1328]
	str	r1, [fp, #-80]
	beq	.L370
	ldr	r3, .L390
	movw	r2, #11364
	mov	r1, #0
	ldr	r0, [fp, #-300]
	mov	r9, r1
	add	r5, r6, #8192
	ldr	r3, [r3, #48]
	blx	r3
	str	r9, [r10, #2444]
	ldr	r3, [r4, #12]
	str	r3, [r10, #2464]
	ldr	r3, [r4, #8]
	str	r3, [r10, #2448]
	ldr	r3, [r4]
	str	r3, [r5, #3184]
	ldr	r2, [r4, #12]
	str	r2, [r10, #2452]
	ldrb	r3, [r4, #5]
	strb	r3, [r5, #3192]
	ldrb	r3, [r4, #5]
	cmp	r3, #1
	beq	.L255
	ldr	r3, [r4, #88]
	str	r3, [r10, #2456]
	ldr	r3, [r4, #80]
	str	r3, [r5, #3188]
	ldr	r3, [r4, #92]
	str	r3, [r10, #2460]
	ldrb	r3, [r4, #85]
	strb	r3, [r5, #3193]
	ldrb	r3, [r4, #85]
	cmp	r3, #1
	bne	.L371
.L256:
	movw	r3, #65460
	sub	r1, r2, #75
	movt	r3, 47
	cmp	r1, r3
	bhi	.L366
	ldr	r1, [r5, #3184]
	cmp	r1, #0
	beq	.L366
	add	r4, r6, #51712
	add	r4, r4, #40
	mov	r0, r4
	bl	BsInit
	mov	r1, #8
	mov	r0, r4
	bl	BsShow
	mov	r1, #8
	mov	r7, r0
	str	r0, [fp, #-296]
	mov	r0, r4
	bl	BsSkip
	cmp	r7, #8
	bhi	.L366
	sub	r8, fp, #252
	sub	r7, fp, #188
.L259:
	mov	r1, #32
	mov	r0, r4
	bl	BsShow
	mov	r1, #32
	mov	r9, r0
	mov	r0, r4
	bl	BsSkip
	rev	r9, r9
	str	r9, [r8, #4]!
	cmp	r8, r7
	bne	.L259
	mov	r1, #8
	mov	r0, r4
	bl	BsShow
	mov	r1, #8
	mov	r7, r0
	mov	r0, r4
	bl	BsSkip
	cmp	r7, #255
	add	r0, r7, #1
	str	r0, [r10, #1416]
	bhi	.L366
	cmp	r0, #0
	beq	.L260
	add	r9, r6, #50432
	movw	r8, #65535
	add	r9, r9, #136
	str	r5, [fp, #-304]
	movt	r8, 47
	mov	r7, #0
	mov	r5, r9
	b	.L261
.L373:
	ldr	r0, [r10, #1416]
	cmp	r0, r7
	bls	.L372
.L261:
	mov	r1, #32
	mov	r0, r4
	bl	BsSkip
	mov	r1, #32
	mov	r0, r4
	add	r7, r7, #1
	bl	BsShow
	mov	r1, #32
	mov	r9, r0
	mov	r0, r4
	bl	BsSkip
	rev	r3, r9
	cmp	r3, r8
	str	r3, [r5, #4]!
	ble	.L373
.L366:
	mov	r3, #0
	str	r3, [fp, #-296]
.L355:
	ldr	r0, [fp, #-296]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L371:
	ldr	r1, [r4, #16]
	ldr	r0, [r10, #2984]
	str	r9, [fp, #-296]
	bl	SM_ReleaseStreamSeg
	ldr	r1, [r4, #96]
	ldr	r0, [r10, #2984]
	bl	SM_ReleaseStreamSeg
	ldr	r0, [fp, #-296]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L255:
	str	r9, [r10, #2456]
	str	r9, [r5, #3188]
	str	r9, [r10, #2460]
	strb	r9, [r5, #3193]
	b	.L256
.L370:
	ldr	r2, [r10, #2480]
	ldr	r1, .L390+4
	str	r4, [fp, #-296]
	bl	dprint_vfmw
	ldr	r0, [fp, #-296]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L372:
	ldr	r5, [fp, #-304]
.L260:
	add	r3, r6, #50432
	sub	r7, r0, #1
	add	r3, r3, #140
	mov	r2, #0
	b	.L262
.L263:
	ldr	ip, [r3, #4]!
	ldr	r1, [r3, #-4]
	cmp	ip, r1
	ble	.L366
.L262:
	cmp	r2, r7
	add	r2, r2, #1
	bne	.L263
	ldr	r2, [r10, #1420]
	mov	r0, r0, asl #3
	add	r1, r0, #66
	movw	r3, #65461
	add	r0, r1, r2
	cmp	r1, #3145728
	sub	r7, r0, #74
	movt	r3, 47
	movlt	r2, #0
	movge	r2, #1
	cmp	r7, r3
	movls	r7, r2
	orrhi	r7, r2, #1
	str	r1, [fp, #-304]
	cmp	r7, #0
	str	r0, [fp, #-308]
	bne	.L366
	ldr	r2, [r10, #2452]
	mov	r3, r0
	rsb	r2, r0, r2
	cmp	r2, #0
	ble	.L366
	ldr	r1, [r5, #3184]
	mov	r0, r4
	ldr	r9, .L390+8
	sub	r8, fp, #248
	add	r1, r1, r3
	bl	BsInit
	ldr	r3, [fp, #-296]
	sub	r2, fp, #44
	sub	lr, fp, #284
	str	r8, [fp, #-172]
	add	ip, r2, r3, lsl #2
	str	r3, [fp, #-168]
	ldmia	r9!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	r9!, {r0, r1, r2, r3}
	ldr	r9, [r9]
	stmia	lr!, {r0, r1, r2, r3}
	sub	r1, fp, #184
	str	r9, [lr]
	mov	r0, r4
	ldr	r3, [ip, #-240]
	str	r3, [fp, #-176]
	bl	Real8_CB_GetPictureHeader
	cmp	r0, #1
	str	r0, [fp, #-296]
	bne	.L374
	ldrb	r3, [r5, #3196]
	cmp	r3, #0
	bne	.L265
	ldr	r3, .L390+12
	ldr	r7, [r3]
	cmp	r7, #0
	beq	.L266
	ldr	lr, [r10, #1320]
	sub	r2, fp, #284
	ldr	r1, [r10, #1316]
	mov	r3, #8
	ldr	r0, [fp, #-88]
	strh	lr, [r2]
	sub	lr, fp, #280
	sub	lr, lr, #2
	ldr	ip, [fp, #-92]
	strh	r1, [lr]
	sub	lr, fp, #280
	mov	r1, #2
	strh	r0, [lr]
	sub	r0, fp, #276
	sub	r0, r0, #2
	strh	ip, [r0]
	ldr	r0, [r10, #2984]
	blx	r7
.L266:
	mov	r2, #1
	ldr	r1, [r10, #2584]
	ldr	r0, [r10, #2984]
	mov	r8, #0
	bl	FSP_ClearLogicFs
	mov	r2, #1
	ldr	r1, [r10, #2580]
	add	r7, r6, #51712
	ldr	r0, [r10, #2984]
	add	r7, r7, #72
	bl	FSP_ClearLogicFs
	ldr	r0, [r10, #2984]
	str	r8, [r10, #2580]
	str	r8, [r10, #2584]
	bl	FSP_GetNullLogicFs
	mov	r1, r7
	str	r0, [r10, #2584]
	str	r0, [r10, #2580]
	strb	r8, [r5, #3199]
	ldr	r0, [r10, #2984]
	bl	FSP_ClearNotInVoQueue
	ldr	r2, [fp, #-88]
	ldr	r3, [fp, #-92]
	cmp	r2, #512
	bhi	.L268
	cmp	r3, #512
	bhi	.L268
	ldr	r3, [r6]
	ldr	r2, [r3, #700]
	cmp	r2, #0
	bne	.L270
	ldr	r3, [r3, #28]
	cmp	r3, #25
	beq	.L375
.L270:
	ldr	r0, [r10, #2984]
	bl	FSP_GetFspType
	cmp	r0, #0
	beq	.L361
.L272:
	ldr	r3, [fp, #-92]
	mov	r0, #1
	ldr	r2, [fp, #-88]
	ldr	r1, .L390+16
	bl	dprint_vfmw
	sub	r2, fp, #184
	mov	r1, r6
	mov	r0, #6
	bl	Real8_ArrangeVHBMem
	subs	r3, r0, #0
	beq	.L376
.L265:
	add	r3, r6, #50176
	sub	r1, fp, #184
	mov	r2, r3
	ldr	r3, .L390
	add	r2, r2, #200
	str	r2, [fp, #-316]
	ldr	r3, [r3, #52]
	mov	r0, r2
	mov	r2, #140
	blx	r3
	ldr	r3, [r6]
	mov	r0, r6
	ldr	r3, [r3, #8]
	strb	r3, [r5, #3194]
	bl	Real8_GetImageBuffer
	subs	r3, r0, #0
	beq	.L377
	ldr	r1, [r10, #2588]
	ldr	r0, [r10, #2984]
	bl	FSP_GetFsImagePtr
	subs	lr, r0, #0
	beq	.L275
	ldr	r2, [r6]
	add	r3, lr, #576
	add	r7, lr, #592
	ldr	r1, .L390+20
	mov	r0, #29
	ldrd	r8, [r2, #56]
	strd	r8, [r3, #-8]
	ldr	r2, [r6]
	ldrd	r8, [r2, #72]
	strd	r8, [r3]
	ldr	r2, [r6]
	ldrd	r8, [r2, #88]
	strd	r8, [r7, #-8]
	mvn	r8, #0
	ldr	r2, [r6]
	mvn	r9, #0
	ldr	r2, [r2, #104]
	str	r2, [lr, #8]
	ldr	r2, [r6]
	ldr	r2, [r2, #108]
	str	r2, [lr, #12]
	ldr	r2, [r6]
	ldr	r2, [r2, #112]
	str	r2, [lr, #16]
	ldr	r2, [r6]
	ldr	r2, [r2, #128]
	str	r2, [lr, #20]
	ldr	r2, [r6]
	strd	r8, [r2, #56]
	ldrd	r8, [r3]
	ldrd	r2, [r3, #-8]
	strd	r8, [sp]
	bl	dprint_vfmw
	ldr	r3, [r10, #1304]
	cmp	r3, #2
	beq	.L378
	cmp	r3, #1
	ldrb	r3, [r5, #3199]
	beq	.L379
	cmp	r3, #0
	movne	r3, #2
	moveq	r3, #1
.L279:
	strb	r3, [r5, #3199]
	ldr	r2, [r10, #2580]
	ldr	r3, [r10, #2584]
	cmp	r2, r3
	beq	.L280
	ldr	r1, .L390+24
	mov	r0, #13
	bl	dprint_vfmw
	mov	r2, #0
	ldr	r1, [r10, #2580]
	ldr	r0, [r10, #2984]
	bl	FSP_SetRef
.L280:
	ldr	r3, [r10, #2584]
	mov	r2, #1
	ldr	r1, [r10, #2588]
	ldr	r0, [r10, #2984]
	str	r3, [r10, #2580]
	str	r1, [r10, #2584]
	bl	FSP_SetRef
	ldr	r1, [r10, #2580]
	ldr	r0, [r10, #2984]
	bl	FSP_RemovePmv
	ldr	r2, [r10, #2588]
	ldr	r1, .L390+28
	mov	r0, #13
	bl	dprint_vfmw
	ldrb	r3, [r5, #3194]
	cmp	r3, #4
	bne	.L282
	ldr	r3, [r10, #1304]
	cmp	r3, #0
	bne	.L380
.L362:
	str	r3, [r10, #2596]
.L282:
	ldr	r1, [r10, #2588]
	ldr	r0, [r10, #2984]
	bl	FSP_GetLogicFs
	ldr	r1, [r10, #2580]
	mov	r7, r0
	ldr	r0, [r10, #2984]
	bl	FSP_GetLogicFs
	ldr	r1, [r10, #2584]
	mov	r8, r0
	ldr	r0, [r10, #2984]
	bl	FSP_GetLogicFs
	cmp	r7, #0
	cmpne	r8, #0
	moveq	r3, #1
	movne	r3, #0
	cmp	r0, #0
	orreq	r3, r3, #1
	str	r0, [fp, #-312]
	cmp	r3, #0
	bne	.L381
	ldr	r3, [r7, #608]
	cmp	r3, #0
	beq	.L289
	ldr	r2, [r7, #616]
	cmp	r2, #0
	beq	.L289
	ldr	r2, [r7, #612]
	cmp	r2, #0
	beq	.L289
	ldr	r2, [fp, #-312]
	mov	r0, #13
	ldr	r1, .L390+32
	ldr	r2, [r2, #608]
	cmp	r2, #0
	ldrne	lr, [r2, #16]
	ldreq	lr, [r3, #16]
	str	lr, [r6, #56]
	ldr	r3, [r8, #608]
	cmp	r3, #0
	ldreq	r3, [r7, #608]
	ldr	ip, [r3, #16]
	str	ip, [r6, #60]
	ldr	r3, [r7, #608]
	ldr	r2, [r3, #16]
	str	r2, [r6, #64]
	ldr	r3, [r7, #620]
	str	r3, [r6, #80]
	mov	r9, r3
	ldr	r3, [fp, #-312]
	ldr	r3, [r3, #620]
	str	r3, [r6, #84]
	str	r3, [fp, #-320]
	ldr	r3, [r7, #612]
	ldr	r3, [r3, #16]
	str	r9, [sp, #8]
	ldr	r9, [fp, #-320]
	str	r9, [sp, #12]
	str	r3, [r6, #68]
	stmia	sp, {ip, lr}
	bl	dprint_vfmw
	ldr	r3, [r7, #612]
	ldr	r3, [r3, #32]
	str	r3, [r6, #72]
	ldr	r3, [r7, #612]
	ldr	r3, [r3, #76]
	str	r3, [r6, #96]
	ldr	r3, [r7, #612]
	ldr	r3, [r3, #60]
	str	r3, [r6, #100]
	ldr	r3, [r7, #612]
	ldr	r3, [r3, #64]
	str	r3, [r6, #104]
	ldr	r3, [r10, #1304]
	cmp	r3, #2
	beq	.L382
.L295:
	ldr	r3, [r10, #1332]
	mov	r0, r4
	str	r3, [r7, #628]
	ldr	r3, [r10, #1304]
	ldr	r2, [r10, #1344]
	cmp	r3, #2
	strb	r3, [r6, #20]
	ldr	r3, [r10, #1320]
	str	r2, [fp, #-312]
	str	r3, [r6, #12]
	ldr	r3, [r10, #1316]
	str	r3, [r6, #16]
	ldr	r3, [r10, #2504]
	str	r3, [r6, #24]
	ldr	r3, [r10, #2508]
	str	r2, [r6, #32]
	str	r3, [r6, #28]
	ldr	r3, [r10, #1408]
	str	r3, [r6, #36]
	ldr	r3, [r10, #1412]
	str	r3, [r6, #40]
	strne	r2, [r10, #1408]
	bl	BsPos
	ldr	r3, [r10, #1416]
	ands	r0, r0, #-2147483641
	submi	r0, r0, #1
	mvnmi	r0, r0, asl #29
	mvnmi	r0, r0, lsr #29
	addmi	r0, r0, #1
	cmp	r3, #1
	str	r0, [r10, #1384]
	ldreq	r3, [r10, #2452]
	moveq	r0, r4
	ldreq	r2, [fp, #-304]
	movne	r0, r4
	ldrne	r3, [r10, #1424]
	ldreq	r7, [r10, #1420]
	rsbeq	r3, r2, r3
	ldrne	r7, [r10, #1420]
	rsb	r7, r7, r3
	bl	BsPos
	ldr	r3, [fp, #-308]
	mov	r7, r7, asl #3
	rsb	r0, r0, r7
	ldr	r7, [r10, #2448]
	str	r0, [r10, #1388]
	mov	r0, r4
	add	r7, r3, r7
	bl	BsPos
	ldr	r2, [r10, #1348]
	mov	r1, #1
	ldr	lr, [r10, #1340]
	ldr	ip, [fp, #-312]
	str	r2, [r10, #1368]
	str	lr, [r10, #1372]
	str	ip, [r10, #1364]
	add	r3, r0, #7
	cmp	r0, #0
	movlt	r0, r3
	mov	r3, #0
	add	r0, r7, r0, asr #3
	str	r3, [r10, #1396]
	str	r0, [r10, #1392]
	str	r3, [r10, #1400]
	str	r3, [r10, #1404]
	str	r3, [r10, #1376]
	str	r0, [r6, #108]
	ldr	r0, [r10, #1384]
	str	r0, [r6, #116]
	ldr	r0, [r10, #1388]
	str	lr, [r6, #132]
	str	r3, [r6, #112]
	str	r0, [r6, #124]
	str	r3, [r6, #120]
	str	r3, [r6, #128]
	str	r2, [r6, #136]
	str	r3, [r6, #144]
	str	ip, [r6, #140]
	str	r1, [r6, #44]
	ldr	r2, [r10, #1416]
	cmp	r2, r1
	bls	.L323
	ldr	r8, [r10, #1424]
	movw	r0, #65535
	ldr	r2, [fp, #-304]
	movt	r0, 47
	add	r8, r2, r8
	cmp	r8, r0
	bgt	.L309
	cmp	r8, #73
	ble	.L309
	ldr	r2, [r10, #2452]
	rsb	r2, r8, r2
	cmp	r2, #0
	ble	.L309
	add	r7, r6, #50432
	mov	r9, r5
	add	r7, r7, #144
	str	r3, [fp, #-328]
	str	r0, [fp, #-320]
	mov	r5, r1
	str	r1, [fp, #-308]
	b	.L312
.L313:
	ldr	r3, [r10, #1416]
	add	r5, r5, #1
	cmp	r3, r5
	bls	.L323
	ldr	r3, [fp, #-304]
	ldr	r8, [r7, #4]!
	add	r8, r3, r8
	ldr	r3, [fp, #-320]
	cmp	r8, r3
	bgt	.L309
	cmp	r8, #73
	ble	.L309
	ldr	r2, [r10, #2452]
	rsb	r2, r8, r2
	cmp	r2, #0
	ble	.L309
.L312:
	ldr	r1, [r9, #3184]
	mov	r0, r4
	add	r1, r1, r8
	bl	BsInit
	ldr	r3, [fp, #-316]
	sub	r2, fp, #292
	mov	r1, #0
	mov	r0, r4
	str	r3, [sp, #4]
	sub	r3, fp, #284
	str	r3, [sp]
	sub	r3, fp, #288
	bl	Real8_CB_GetSliceHeader
	cmp	r0, #1
	bne	.L313
	ldr	r3, [r10, #1320]
	ldr	r2, [fp, #-292]
	cmp	r3, #0
	str	r2, [fp, #-324]
	beq	.L383
	ldr	r3, [fp, #-284]
	mov	r0, r4
	ldr	r2, [fp, #-312]
	cmp	r3, #0
	movge	r2, r3
	str	r2, [fp, #-312]
	bl	BsPos
	ldr	r3, [r10, #1416]
	sub	lr, r3, #1
	cmp	lr, r5
	mov	r2, r0, asr #31
	mov	r1, r2, lsr #29
	add	r2, r0, r1
	and	r2, r2, #7
	rsb	r2, r1, r2
	str	r2, [r10, #1384]
	beq	.L384
	cmp	r5, #254
	bhi	.L385
	ldr	r3, [r7, #4]
	mov	r0, r4
	ldr	r2, [r7]
	rsb	r3, r2, r3
.L365:
	mov	r3, r3, asl #3
	str	r3, [fp, #-332]
	bl	BsPos
	ldr	r3, [fp, #-332]
	ldr	r2, [r10, #2448]
	add	r8, r8, r2
	rsb	r0, r0, r3
	str	r0, [r10, #1388]
	mov	r0, r4
	bl	BsPos
	mov	r3, #44
	ldr	ip, [fp, #-328]
	ldr	r1, [r10, #1348]
	ldr	lr, [r10, #1340]
	str	ip, [r10, #1396]
	str	r1, [r10, #1368]
	str	ip, [r10, #1400]
	str	lr, [r10, #1372]
	add	r2, r0, #7
	cmp	r0, #0
	movlt	r0, r2
	ldr	r2, [fp, #-308]
	mla	r3, r3, r2, r6
	add	r2, r8, r0, asr #3
	ldr	r0, [fp, #-308]
	str	r2, [r10, #1392]
	add	r0, r0, #1
	str	r0, [fp, #-308]
	add	r1, r3, #136
	mov	r8, r0
	mov	r0, ip
	str	r0, [r10, #1404]
	cmp	r8, #131
	ldr	r0, [fp, #-312]
	mov	ip, r8
	mov	r8, #0
	str	r0, [r10, #1364]
	ldr	r0, [fp, #-324]
	str	r0, [r10, #1376]
	add	r0, r3, #128
	str	r2, [r3, #108]
	ldr	r2, [r10, #1384]
	str	r2, [r3, #116]
	ldr	r2, [r10, #1388]
	str	r2, [r3, #124]
	ldr	r2, [r10, #1404]
	str	r2, [r3, #112]
	ldr	r2, [r10, #1396]
	str	r2, [r3, #120]
	ldr	r2, [r10, #1400]
	str	r2, [r3, #128]
	ldr	r3, [r10, #1372]
	str	r3, [r0, #4]
	ldr	r3, [r10, #1368]
	str	r3, [r0, #8]
	ldr	r3, [r10, #1364]
	str	r3, [r1, #4]
	ldr	r3, [r10, #1376]
	str	r3, [r1, #8]
	str	ip, [r6, #44]
	ble	.L313
	mov	r0, r6
	bl	Real8_ModifySliceMsg
	cmp	r0, #1
	bne	.L386
	ldr	r3, [fp, #-300]
	cmp	r3, #0
	str	r3, [r6, #4]
	beq	.L387
	ldr	r3, [r6]
	ldr	r2, [r3, #856]
	cmp	r2, #1
	beq	.L388
	cmp	r2, #2
	bne	.L313
	ldr	r3, [r3, #860]
	cmp	r3, #0
	ble	.L313
	ldrb	r3, [r6, #20]
	cmp	r3, #2
	bne	.L313
	str	r8, [r6, #4]
	mov	r2, r8
	ldr	r1, [r10, #2588]
	ldr	r0, [r10, #2984]
	str	r8, [fp, #-296]
	bl	FSP_SetDisplay
	ldr	r2, [r6]
	mov	r1, r6
	mov	r0, #8
	ldr	r3, [r2, #860]
	sub	r3, r3, #1
	str	r3, [r2, #860]
	bl	ReleasePacket
	b	.L355
.L374:
	ldr	r1, .L390+36
	mov	r0, #1
	str	r7, [fp, #-296]
	bl	dprint_vfmw
	b	.L355
.L268:
	ldr	r1, .L390+40
	mov	r0, #18
	bl	dprint_vfmw
	b	.L366
.L377:
	ldr	r2, [r10, #2480]
	ldr	r1, .L390+44
	str	r3, [fp, #-296]
	bl	dprint_vfmw
	b	.L355
.L380:
	cmp	r3, #2
	beq	.L325
	cmp	r3, #1
	beq	.L362
	b	.L282
.L381:
	movw	r3, #2019
	ldr	r2, .L390+48
	ldr	r1, .L390+52
	mov	r0, #22
	bl	dprint_vfmw
	mov	r3, #0
	str	r3, [fp, #-296]
	b	.L355
.L378:
	ldrb	r3, [r5, #3199]
	cmp	r3, #1
	bls	.L309
	ldrb	r3, [r5, #3194]
	cmp	r3, #4
	bne	.L282
.L325:
	ldr	r3, [r10, #2596]
	cmp	r3, #0
	bne	.L282
	mov	r2, #1
	ldr	r1, [r10, #2588]
	ldr	r0, [r10, #2984]
	str	r3, [fp, #-296]
	bl	FSP_ClearLogicFs
	b	.L355
.L382:
	ldr	r1, [fp, #-312]
	ldr	r3, [r8, #628]
	ldr	r2, [r10, #1332]
	ldr	r8, [r1, #628]
	subs	r2, r2, r3
	rsb	r8, r3, r8
	ldrmi	r3, [r10, #1328]
	addmi	r2, r2, r3
	cmp	r8, #0
	ldrlt	r3, [r10, #1328]
	addlt	r8, r8, r3
	cmp	r2, r8
	movgt	r2, #0
	cmp	r8, #0
	ble	.L328
	mov	r1, r8
	mov	r0, r2, asl #14
	str	r2, [fp, #-312]
	bl	__aeabi_idiv
	ldr	r2, [fp, #-312]
	mov	r1, r8
	str	r0, [fp, #-320]
	rsb	r0, r2, r8
	mov	r0, r0, asl #14
	bl	__aeabi_idiv
	ldr	r2, [fp, #-312]
	ldr	r3, [fp, #-320]
.L299:
	str	r2, [r10, #2496]
	str	r8, [r10, #2500]
	str	r3, [r10, #2504]
	str	r0, [r10, #2508]
	b	.L295
.L289:
	ldr	r1, [r10, #2588]
	mov	r2, #1
	ldr	r0, [r10, #2984]
	mov	r3, #0
	str	r3, [fp, #-296]
	bl	FSP_ClearLogicFs
	ldr	r1, .L390+56
	mov	r0, #0
	bl	dprint_vfmw
	b	.L355
.L384:
	add	r3, r3, #9792
	ldr	r2, [r10, #2452]
	add	r3, r3, #5
	ldr	r1, [fp, #-304]
	mov	r0, r4
	add	r3, r9, r3, lsl #2
	rsb	r2, r1, r2
	ldr	r3, [r3, #3188]
	rsb	r3, r3, r2
	b	.L365
.L375:
	ldrb	r3, [r5, #3196]
	cmp	r3, #0
	bne	.L272
.L361:
	mov	r0, r7
	bl	ResetVoQueue
	b	.L272
.L379:
	cmp	r3, #0
	movne	r3, #2
	bne	.L279
.L309:
	mov	r2, #1
	ldr	r1, [r10, #2588]
	ldr	r0, [r10, #2984]
	mov	r3, #0
	str	r3, [fp, #-296]
	bl	FSP_ClearLogicFs
	b	.L355
.L376:
	ldr	r1, .L390+60
	mov	r0, #1
	str	r3, [fp, #-296]
	bl	dprint_vfmw
	b	.L355
.L323:
	ldr	r4, [r6, #4]
	mov	r5, #1
	str	r5, [r6, #48]
	cmp	r4, #0
	beq	.L389
.L306:
	ldr	r3, [r6]
	ldr	r2, [r3, #588]
	str	r2, [r6, #88]
	ldr	r3, [r3, #624]
	str	r3, [r6, #92]
	b	.L355
.L275:
	mov	r2, #1
	ldr	r1, [r10, #2588]
	ldr	r0, [r10, #2984]
	str	lr, [fp, #-296]
	bl	FSP_ClearLogicFs
	b	.L355
.L389:
	mov	r0, r6
	bl	Real8_ModifySliceMsg
	cmp	r0, #1
	ldreq	r3, [fp, #-300]
	streq	r3, [r6, #4]
	beq	.L306
	mov	r2, r5
	ldr	r1, [r10, #2588]
	ldr	r0, [r10, #2984]
	str	r4, [fp, #-296]
	bl	FSP_ClearLogicFs
	b	.L355
.L388:
	ldrb	r3, [r6, #20]
	cmp	r3, #2
	bne	.L313
	str	r8, [r6, #4]
	mov	r2, r8
	ldr	r1, [r10, #2588]
	ldr	r0, [r10, #2984]
	str	r8, [fp, #-296]
	bl	FSP_SetDisplay
	mov	r1, r6
	mov	r0, #8
	bl	ReleasePacket
	b	.L355
.L387:
	ldr	ip, [fp, #-300]
	movw	r3, #2219
	ldr	r2, .L390+48
	mov	r0, #22
	ldr	r1, .L390+64
	str	ip, [fp, #-296]
	bl	dprint_vfmw
	b	.L355
.L328:
	mov	r0, #0
	mov	r3, r0
	b	.L299
.L383:
	mov	r2, r0
	ldr	r1, [r10, #2588]
	ldr	r0, [r10, #2984]
	str	r3, [fp, #-296]
	bl	FSP_ClearLogicFs
	b	.L355
.L386:
	mov	r2, #1
	ldr	r1, [r10, #2588]
	ldr	r0, [r10, #2984]
	str	r8, [fp, #-296]
	bl	FSP_ClearLogicFs
	b	.L355
.L385:
	movw	r2, #2186
	ldr	r1, .L390+68
	mov	r0, #22
	mov	r3, #0
	str	r3, [fp, #-296]
	bl	dprint_vfmw
	b	.L355
.L391:
	.align	2
.L390:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC13
	.word	.LANCHOR0+460
	.word	g_event_report
	.word	.LC16
	.word	.LC19
	.word	.LC20
	.word	.LC21
	.word	.LC24
	.word	.LC14
	.word	.LC15
	.word	.LC18
	.word	.LANCHOR0+528
	.word	.LC22
	.word	.LC23
	.word	.LC17
	.word	.LC26
	.word	.LC25
	.fnend
	.size	REAL8DEC_Decode, .-REAL8DEC_Decode
	.align	2
	.global	REAL8DEC_RecycleImage
	.type	REAL8DEC_RecycleImage, %function
REAL8DEC_RecycleImage:
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
	ldr	r0, [r4, #2984]
	bl	FSP_SetDisplay
	mov	r1, r5
	ldr	r0, [r4, #2984]
	bl	FSP_GetFsImagePtr
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	REAL8DEC_RecycleImage, .-REAL8DEC_RecycleImage
	.align	2
	.global	REAL8DEC_GetRemainImg
	.type	REAL8DEC_GetRemainImg, %function
REAL8DEC_GetRemainImg:
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
	beq	.L411
	add	r6, r0, #49152
	ldr	r1, [r6, #2584]
	ldr	r0, [r6, #2984]
	bl	FSP_GetFsImagePtr
	subs	r7, r0, #0
	beq	.L411
	ldr	r1, [r6, #2584]
	ldr	r0, [r6, #2984]
	bl	FSP_GetDisplay
	cmp	r0, #2
	beq	.L409
.L411:
	add	r5, r4, #51712
	add	r5, r5, #72
.L400:
	mov	r0, r5
	bl	GetVoLastImageID
.L410:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L409:
	mov	r0, r4
	add	r5, r4, #51712
	bl	Real8_SetImgFormat
	add	r5, r5, #72
	mov	r3, #1
	str	r3, [r7, #188]
	mov	r2, r3
	ldr	r1, [r6, #2584]
	ldr	r0, [r6, #2984]
	bl	FSP_SetDisplay
	ldr	r0, [r6, #2984]
	mov	r2, r4
	str	r7, [sp]
	mov	r3, r5
	mov	r1, #8
	bl	InsertImgToVoQueue
	cmp	r0, #1
	beq	.L397
	mov	r2, #0
	ldr	r1, [r6, #2584]
	ldr	r0, [r6, #2984]
	bl	FSP_SetDisplay
	b	.L400
.L397:
	ldr	r3, [r7, #160]
	cmp	r3, #100
	bhi	.L400
	ldr	r3, [r7, #112]
	cmp	r3, #31
	bls	.L400
	ldr	r3, [r7, #116]
	cmp	r3, #31
	movhi	r0, #0
	bhi	.L410
	b	.L400
	.fnend
	.size	REAL8DEC_GetRemainImg, .-REAL8DEC_GetRemainImg
	.align	2
	.global	REAL8DEC_VDMPostProc
	.type	REAL8DEC_VDMPostProc, %function
REAL8DEC_VDMPostProc:
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
	ldr	r1, .L441
	add	r4, r5, #49152
	mov	r8, r2
	mov	r0, #22
	mov	r2, r6
	add	r7, r5, #8192
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, #8
	bl	ReleasePacket
	ldr	r1, [r4, #2588]
	ldr	r0, [r4, #2984]
	bl	FSP_GetFsImagePtr
	cmp	r0, #0
	beq	.L413
	ldr	r3, [r4, #1304]
	cmp	r3, #2
	andne	r8, r8, #31
	strb	r3, [r7, #3197]
	strne	r8, [r4, #1412]
	cmp	r6, #0
	movlt	r6, #0
	blt	.L415
	cmp	r6, #100
	movge	r6, #100
.L415:
	str	r6, [r0, #160]
	mov	r0, #22
	ldr	r1, .L441+4
	bl	dprint_vfmw
	mov	r0, r5
	bl	Real8_SetImgFormat
	ldrb	r3, [r7, #3194]
	cmp	r3, #2
	beq	.L418
	ldr	r3, [r5]
	ldr	r3, [r3, #12]
	cmp	r3, #1
	beq	.L418
	ldr	r3, [r4, #1304]
	cmp	r3, #2
	beq	.L418
	ldrb	r3, [r7, #3199]
	cmp	r3, #1
	ldrhi	r1, [r4, #2580]
	mvnls	r1, #0
	cmn	r1, #1
	str	r1, [r4, #2592]
	beq	.L420
.L440:
	ldr	r0, [r4, #2984]
	bl	FSP_GetFsImagePtr
	ldr	r6, [r4, #2592]
	mov	r1, r6
	mov	r7, r0
	ldr	r0, [r4, #2984]
	bl	FSP_GetRef
	mov	r2, r6
	ldr	r1, .L441+8
	mov	r3, r0
	mov	r0, #12
	bl	dprint_vfmw
	mov	r2, #1
	ldr	r1, [r4, #2592]
	ldr	r0, [r4, #2984]
	bl	FSP_SetDisplay
	add	r3, r5, #51712
	ldr	r0, [r4, #2984]
	add	r3, r3, #72
	str	r7, [sp]
	mov	r2, r5
	mov	r1, #8
	bl	InsertImgToVoQueue
	cmp	r0, #1
	bne	.L439
.L420:
	ldr	r3, [r4, #2480]
	mov	r0, #1
	add	r3, r3, r0
	str	r3, [r4, #2480]
.L413:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L418:
	ldr	r1, [r4, #2588]
	cmn	r1, #1
	str	r1, [r4, #2592]
	bne	.L440
	b	.L420
.L439:
	ldr	r0, [r4, #2984]
	mov	r2, #0
	ldr	r1, [r4, #2592]
	bl	FSP_SetDisplay
	mov	r0, #0
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L442:
	.align	2
.L441:
	.word	.LC27
	.word	.LC28
	.word	.LC29
	.fnend
	.size	REAL8DEC_VDMPostProc, .-REAL8DEC_VDMPostProc
	.align	2
	.global	REAL8DEC_GetImageBuffer
	.type	REAL8DEC_GetImageBuffer, %function
REAL8DEC_GetImageBuffer:
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
	ldr	r0, [r4, #2984]
	bl	FSP_IsNewFsAvalible
	cmp	r0, #1
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r0, [r4, #2984]
	bl	FSP_IsNewFsAvalible
	cmn	r0, #1
	beq	.L449
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L449:
	add	r1, r5, #51712
	ldr	r0, [r4, #2984]
	add	r1, r1, #72
	bl	FSP_ClearNotInVoQueue
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	REAL8DEC_GetImageBuffer, .-REAL8DEC_GetImageBuffer
	.align	2
	.global	REAL8DEC_Support
	.type	REAL8DEC_Support, %function
REAL8DEC_Support:
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
	.size	REAL8DEC_Support, .-REAL8DEC_Support
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
.LC3:
	.word	0
	.word	1
	.word	1
	.word	2
	.word	2
	.word	3
	.word	3
	.word	3
	.word	3
	.type	s_RVVersionEncodingToMinorVersion, %object
	.size	s_RVVersionEncodingToMinorVersion, 32
s_RVVersionEncodingToMinorVersion:
	.word	2
	.word	9999
	.word	9999
	.word	9999
	.word	9999
	.word	9999
	.word	9999
	.word	9999
	.type	__FUNCTION__.14968, %object
	.size	__FUNCTION__.14968, 16
__FUNCTION__.14968:
	.ascii	"REAL8DEC_Decode\000"
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC4:
	.ascii	"get frame store fail!\012\000"
	.space	1
.LC5:
	.ascii	"line: %d, pImage is NULL!\012\000"
	.space	1
.LC6:
	.ascii	"get image buffer ok: LogicFsID = %d\012\000"
	.space	3
.LC7:
	.ascii	"decode %p, disp %p, tf %p\012\000"
	.space	1
.LC8:
	.ascii	"image size abnormal (%dx%d) in MB\012\000"
	.space	1
.LC9:
	.ascii	"real8 actual frame size(%dx%d) exeed max config(%dx"
	.ascii	"%d)\012\000"
.LC10:
	.ascii	"partition fs memory fail!\012\000"
	.space	1
.LC11:
	.ascii	"-1 == VCTRL_GetChanIDByCtx() Err! \012\000"
.LC12:
	.ascii	"Decoding quits at frm %d\012\000"
	.space	2
.LC13:
	.ascii	"ERROR: frm %d, Invalid packet pointer!\012\000"
.LC14:
	.ascii	"Real8_CB_GetPictureHeader Error!\012\000"
	.space	2
.LC15:
	.ascii	"pic width/height to large,MbWidth = %d, MbHeight = "
	.ascii	"%d\000"
	.space	2
.LC16:
	.ascii	"new seq size %d * %d\012\000"
	.space	2
.LC17:
	.ascii	"Real8_ArrangeVHBMem err\012\000"
	.space	3
.LC18:
	.ascii	"Fatal Error: frm%d, get image buffer failed\012\000"
	.space	3
.LC19:
	.ascii	"dec_pts: %lld Usertag = %lld\012\000"
	.space	2
.LC20:
	.ascii	"---------- unref %d\012\000"
	.space	3
.LC21:
	.ascii	"++++++++++ ref %d\012\000"
	.space	1
.LC22:
	.ascii	"%s %d unknow error!!\012\000"
	.space	2
.LC23:
	.ascii	"CurFsID abnormal!\012\000"
	.space	1
.LC24:
	.ascii	"dec addr: cur,cur2d,fwd,bwd,currpmv,colpmv = %p,%p,"
	.ascii	"%p,%p,%p,%p\012\000"
.LC25:
	.ascii	"line:%d! i > (RV8_MAX_SLC_PARAM_NUM - 2)\012\000"
	.space	2
.LC26:
	.ascii	"%s %d NULL == pCtx->pRv8DecParam!!\012\000"
.LC27:
	.ascii	"ErrRatio = %d\012\000"
	.space	1
.LC28:
	.ascii	"DEBUG: DEC over\012\000"
	.space	3
.LC29:
	.ascii	"insert buf %d ref %d\012\000"
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
