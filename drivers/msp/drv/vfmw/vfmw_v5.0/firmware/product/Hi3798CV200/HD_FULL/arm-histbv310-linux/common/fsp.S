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
	.file	"fsp.c"

	.text
	.align	2
	.global	FSP_Init
	.type	FSP_Init, %function
FSP_Init:
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
	ldr	r4, .L5
	mov	r2, #64
	mov	r1, #0
	ldr	r0, .L5+4
	ldr	r3, [r4, #48]
	blx	r3
	ldr	r3, [r4, #48]
	mov	r2, #4224
	mov	r1, #0
	ldr	r0, .L5+8
	blx	r3
	ldr	r3, .L5+8
	mvn	r1, #0
	add	r2, r3, #4224
.L2:
	strh	r1, [r3, #2]
	add	r3, r3, #264
	cmp	r3, r2
	bne	.L2
	ldr	lr, .L5+12
	mov	r3, #0
	ldr	ip, [r4, #48]
	mov	r1, r3
	mov	r2, #16
	ldr	r0, .L5+16
	str	r3, [lr, #-3896]
	blx	ip
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L6:
	.align	2
.L5:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.word	.LANCHOR0+64
	.word	.LANCHOR1
	.word	.LANCHOR1-3892
	.fnend
	.size	FSP_Init, .-FSP_Init
	.align	2
	.global	FSP_ConfigAttribute
	.type	FSP_ConfigAttribute, %function
FSP_ConfigAttribute:
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
	cmp	r0, #15
	bhi	.L11
	ldr	r3, .L13
	ldr	r3, [r3, r0, asl #2]
	ldr	r2, [r3, #4]
	cmp	r2, #1
	bne	.L12
	ldrb	r2, [r1]
	mov	r0, #0
	strb	r2, [r3, #1]
	ldmfd	sp, {fp, sp, pc}
.L12:
	ldr	r3, .L13+4
	mov	r2, #234
	ldr	r1, .L13+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L11:
	ldr	r3, .L13+12
	mov	r2, #233
	ldr	r1, .L13+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L14:
	.align	2
.L13:
	.word	.LANCHOR0
	.word	.LC2
	.word	.LC1
	.word	.LC0
	.fnend
	.size	FSP_ConfigAttribute, .-FSP_ConfigAttribute
	.align	2
	.global	FSP_ClearContext
	.type	FSP_ClearContext, %function
FSP_ClearContext:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #636
	sub	sp, sp, #636
	push	{lr}
	bl	__gnu_mcount_nc
	subs	r4, r0, #0
	beq	.L32
	ldr	r5, .L34
	mov	r2, #632
	mov	r1, #0
	sub	r0, fp, #668
	ldr	r3, [r5, #48]
	blx	r3
	ldrsb	r0, [r4]
	bl	VCTRL_GetChanVoQue
	cmp	r0, #0
	beq	.L31
	ldrh	r3, [r0, #4]
	ldrh	r2, [r0, #6]
	cmp	r2, r3
	beq	.L31
	cmp	r3, #63
	bls	.L33
.L31:
	ldrb	r6, [r4]
.L19:
	ldr	r3, [r5, #48]
	movw	r2, #27544
	mov	r1, #0
	mov	r0, r4
	ldrb	r5, [r4, #10]
	ldrb	r8, [r4, #1]
	ldr	r7, [r4, #4]
	blx	r3
	ldr	r0, [fp, #-548]
	strb	r8, [r4, #1]
	cmp	r0, #0
	str	r7, [r4, #4]
	strb	r5, [r4, #10]
	strb	r6, [r4]
	ldr	ip, .L34
	beq	.L17
	sub	r2, fp, #36
	mvn	r3, #628
	mov	r0, #632
	sub	r1, fp, #668
	ldrsb	r3, [r2, r3]
	mov	r2, r0
	ldr	ip, [ip, #52]
	mla	r0, r0, r3, r4
	add	r0, r0, #56
	blx	ip
	mov	r0, #0
.L17:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L33:
	add	r0, r0, r3, lsl #2
	ldrb	r6, [r4]
	ldr	r3, [r0, #12]
	sxtb	r2, r6
	ldr	r3, [r3, #156]
	cmp	r2, #15
	cmpls	r3, #31
	bhi	.L19
	ldr	r1, .L34+4
	ldr	r1, [r1, r2, asl #2]
	cmp	r1, #0
	beq	.L19
	mov	r2, #632
	mla	r1, r2, r3, r1
	adds	r1, r1, #56
	beq	.L19
	ldr	r3, [r5, #52]
	sub	r0, fp, #668
	blx	r3
	b	.L31
.L32:
	ldr	r3, .L34+8
	movw	r2, #257
	ldr	r1, .L34+12
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L17
.L35:
	.align	2
.L34:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.word	.LC3
	.word	.LC1
	.fnend
	.size	FSP_ClearContext, .-FSP_ClearContext
	.align	2
	.global	FSP_EnableInstance
	.type	FSP_EnableInstance, %function
FSP_EnableInstance:
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
	cmp	r0, #15
	mov	r6, r0
	bhi	.L41
	ldr	r3, .L43
	ldr	r4, [r3, r0, asl #2]
	cmp	r4, #0
	beq	.L42
	ldr	r5, [r4, #4]
	cmp	r5, #0
	bne	.L40
	ldr	r3, .L43+4
	movw	r2, #27544
	mov	r1, r5
	mov	r0, r4
	ldr	r3, [r3, #48]
	blx	r3
	add	r3, r4, #24576
	strb	r6, [r4]
	mov	r2, #1
	mov	r0, r5
	str	r2, [r4, #4]
	str	r5, [r3, #2952]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L40:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L41:
	ldr	r3, .L43+8
	movw	r2, #310
	ldr	r1, .L43+12
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L42:
	mov	r0, r4
	ldr	r3, .L43+16
	movw	r2, #311
	ldr	r1, .L43+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L44:
	.align	2
.L43:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC0
	.word	.LC1
	.word	.LC4
	.fnend
	.size	FSP_EnableInstance, .-FSP_EnableInstance
	.align	2
	.global	FSP_DisableInstance
	.type	FSP_DisableInstance, %function
FSP_DisableInstance:
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
	cmp	r0, #15
	bhi	.L49
	ldr	r3, .L51
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	beq	.L50
	ldr	r3, [r0, #4]
	cmp	r3, #1
	moveq	r3, #0
	streq	r3, [r0, #4]
	ldmfd	sp, {fp, sp, pc}
.L49:
	ldr	r3, .L51+4
	movw	r2, #334
	ldr	r1, .L51+8
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L50:
	ldr	r3, .L51+12
	movw	r2, #335
	ldr	r1, .L51+8
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L52:
	.align	2
.L51:
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.word	.LC4
	.fnend
	.size	FSP_DisableInstance, .-FSP_DisableInstance
	.align	2
	.global	FSP_Exit
	.type	FSP_Exit, %function
FSP_Exit:
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
	ldr	r5, .L64
	mov	r4, #0
	b	.L55
.L54:
	add	r4, r4, #1
	cmp	r4, #16
	beq	.L63
.L55:
	ldr	r3, [r5, #4]!
	cmp	r3, #0
	beq	.L54
	ldr	r3, [r3, #4]
	cmp	r3, #0
	beq	.L54
	mov	r0, r4
	add	r4, r4, #1
	bl	FSP_DisableInstance
	cmp	r4, #16
	bne	.L55
.L63:
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L65:
	.align	2
.L64:
	.word	.LANCHOR0-4
	.fnend
	.size	FSP_Exit, .-FSP_Exit
	.align	2
	.global	FSP_ResetInstance
	.type	FSP_ResetInstance, %function
FSP_ResetInstance:
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
	cmp	r0, #15
	mov	r6, r0
	bhi	.L87
	ldr	r3, .L93
	ldr	r7, [r3, r0, asl #2]
	cmp	r7, #0
	beq	.L88
	ldr	r9, .L93+4
	add	r4, r7, #20224
	add	r5, r7, #23552
	add	r4, r4, #158
	add	r5, r5, #30
	mov	r8, r9
	b	.L76
.L73:
	ldrsb	r3, [r4]
	cmp	r3, #0
	bne	.L89
.L71:
	add	r4, r4, #100
	cmp	r4, r5
	beq	.L90
.L76:
	ldr	r1, [r4, #14]
	cmp	r1, #0
	beq	.L71
	ldr	r3, [r9, #-3896]
	cmp	r3, #0
	beq	.L71
	ldrsb	r3, [r4, #-2]
	cmp	r3, #0
	beq	.L73
	ldr	r3, [r8, #-3880]
	cmp	r3, #0
	beq	.L91
	mov	r2, #0
	mov	r0, r6
	blx	r3
	ldrsb	r3, [r4]
	cmp	r3, #0
	beq	.L71
.L89:
	ldr	r3, [r9, #-3884]
	ldr	r1, [r4, #14]
	cmp	r3, #0
	beq	.L92
	mov	r0, r6
	add	r4, r4, #100
	blx	r3
	cmp	r4, r5
	bne	.L76
.L90:
	mov	r0, r7
	bl	FSP_ClearContext
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L87:
	ldr	r3, .L93+8
	movw	r2, #355
	ldr	r1, .L93+12
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L92:
	mov	r0, r3
	ldr	r1, .L93+16
	bl	dprint_vfmw
	b	.L71
.L91:
	mov	r0, r3
	ldr	r1, .L93+20
	bl	dprint_vfmw
	b	.L73
.L88:
	mov	r0, r7
	ldr	r3, .L93+24
	mov	r2, #356
	ldr	r1, .L93+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L94:
	.align	2
.L93:
	.word	.LANCHOR0
	.word	.LANCHOR1
	.word	.LC0
	.word	.LC1
	.word	.LC6
	.word	.LC5
	.word	.LC4
	.fnend
	.size	FSP_ResetInstance, .-FSP_ResetInstance
	.align	2
	.global	FSP_EmptyInstance
	.type	FSP_EmptyInstance, %function
FSP_EmptyInstance:
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
	cmp	r0, #15
	mov	r6, r0
	bhi	.L150
	ldr	r3, .L156
	ldr	r7, [r3, r0, asl #2]
	cmp	r7, #0
	beq	.L151
	ldr	r3, .L156+4
	mov	r2, #20224
	mov	r1, #0
	add	r0, r7, #56
	ldr	r3, [r3, #48]
	blx	r3
	ldrsb	r3, [r7, #10]
	cmp	r3, #0
	ble	.L111
	ldr	r9, .L156+8
	add	r4, r7, #20224
	ldr	r10, .L156+12
	add	r4, r4, #248
	mov	r5, #0
	mov	r8, r9
	b	.L110
.L106:
	mov	r3, #0
	strb	r3, [r4, #-90]
.L120:
	mov	r3, #0
	strb	r3, [r4, #-92]
	strb	r3, [r4]
	add	r5, r5, #1
	str	r3, [r4, #-4]
	add	r4, r4, #100
	ldrsb	r3, [r7, #10]
	cmp	r3, r5
	ble	.L111
.L110:
	ldr	r1, [r4, #-76]
	cmp	r1, #0
	beq	.L102
	ldr	r3, [r9, #-3896]
	cmp	r3, #0
	beq	.L102
	ldrsb	r3, [r4, #-92]
	cmp	r3, #0
	bne	.L152
.L103:
	ldrsb	r3, [r4, #-90]
	cmp	r3, #0
	bne	.L153
.L102:
	cmp	r6, #15
	bgt	.L106
	ldr	r0, [r10, r6, asl #2]
	cmp	r0, #0
	beq	.L106
	add	r3, r0, #237568
	ldr	ip, [r3, #328]
	cmp	ip, #0
	beq	.L106
	add	r3, r0, #233472
	ldr	r3, [r3, #3916]
	cmp	r1, r3
	beq	.L107
	mov	r2, #0
.L108:
	add	r2, r2, #1
	cmp	r2, ip
	mov	r3, r2, asl #4
	add	r3, r3, #236544
	beq	.L106
	add	r3, r3, #844
	ldr	r3, [r0, r3]
	cmp	r1, r3
	bne	.L108
.L107:
	mov	r3, #4
	strb	r3, [r4, #-90]
	b	.L120
.L111:
	ldrsb	r8, [r7, #11]
	cmp	r8, #0
	ble	.L101
	add	r1, r7, #23552
	mov	r0, #0
	ldr	r9, .L156+12
	add	r1, r1, #44
	mov	ip, r0
	mov	r10, #4
	b	.L118
.L114:
	strb	ip, [r1, #-14]
.L121:
	add	r0, r0, #1
	strb	ip, [r1, #-16]
	cmp	r0, r8
	strb	ip, [r1, #76]
	str	ip, [r1, #72]
	add	r1, r1, #100
	beq	.L101
.L118:
	cmp	r6, #15
	ldr	lr, [r1]
	bgt	.L114
	ldr	r4, [r9, r6, asl #2]
	cmp	r4, #0
	beq	.L114
	add	r3, r4, #237568
	ldr	r5, [r3, #328]
	cmp	r5, #0
	beq	.L114
	add	r3, r4, #233472
	ldr	r3, [r3, #3916]
	cmp	lr, r3
	beq	.L115
	mov	r2, #0
.L116:
	add	r2, r2, #1
	cmp	r2, r5
	mov	r3, r2, asl #4
	add	r3, r3, #236544
	beq	.L114
	add	r3, r3, #844
	ldr	r3, [r4, r3]
	cmp	lr, r3
	bne	.L116
.L115:
	strb	r10, [r1, #-14]
	b	.L121
.L101:
	ldrsb	r1, [r7, #13]
	cmp	r1, #0
	movgt	r2, #0
	movgt	r0, r2
	ble	.L113
.L119:
	mov	r3, r2, asl #3
	add	r2, r2, #1
	add	r3, r3, #27136
	cmp	r2, r1
	add	r3, r3, #232
	str	r0, [r7, r3]
	bne	.L119
.L113:
	mov	r0, #0
	str	r0, [r7, #16]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L153:
	ldr	r3, [r9, #-3884]
	cmp	r3, #0
	beq	.L154
	mov	r0, r6
	blx	r3
	ldr	r1, [r4, #-76]
	b	.L102
.L152:
	ldr	r3, [r8, #-3880]
	cmp	r3, #0
	beq	.L155
	mov	r2, #0
	mov	r0, r6
	blx	r3
	ldr	r1, [r4, #-76]
	b	.L103
.L150:
	ldr	r3, .L156+16
	movw	r2, #410
	ldr	r1, .L156+20
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L155:
	ldr	r1, .L156+24
	mov	r0, r3
	bl	dprint_vfmw
	ldr	r1, [r4, #-76]
	b	.L103
.L154:
	ldr	r1, .L156+28
	mov	r0, r3
	bl	dprint_vfmw
	ldr	r1, [r4, #-76]
	b	.L102
.L151:
	mov	r0, r7
	ldr	r3, .L156+32
	movw	r2, #411
	ldr	r1, .L156+20
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L157:
	.align	2
.L156:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR1
	.word	s_pstVfmwChan
	.word	.LC0
	.word	.LC1
	.word	.LC5
	.word	.LC6
	.word	.LC4
	.fnend
	.size	FSP_EmptyInstance, .-FSP_EmptyInstance
	.align	2
	.global	FSP_GetUsedBufferNum
	.type	FSP_GetUsedBufferNum, %function
FSP_GetUsedBufferNum:
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
	ldr	r2, .L164
	movw	r3, #1522
	ldr	r2, [r2, r0, asl #2]
	add	r1, r2, #204800
	ldrsb	ip, [r1, r3]
	cmp	ip, #0
	ble	.L162
	movw	r3, #30086
	mov	r0, #0
	movt	r3, 3
	add	r3, r2, r3
	mov	r2, r0
.L161:
	ldrsb	r1, [r3]
	add	r2, r2, #1
	add	r3, r3, #100
	cmp	r1, #3
	addeq	r0, r0, #1
	cmp	r2, ip
	bne	.L161
	ldmfd	sp, {fp, sp, pc}
.L162:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L165:
	.align	2
.L164:
	.word	s_pstVfmwChan
	.fnend
	.size	FSP_GetUsedBufferNum, .-FSP_GetUsedBufferNum
	.align	2
	.global	FSP_ConfigInstance
	.type	FSP_ConfigInstance, %function
FSP_ConfigInstance:
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
	cmp	r0, #15
	bhi	.L176
	cmp	r1, #0
	beq	.L177
	ldr	r3, .L179
	ldr	r4, [r3, r0, asl #2]
	cmp	r4, #0
	beq	.L170
	ldr	r3, [r4, #4]
	cmp	r3, #1
	bne	.L170
	ldr	r3, .L179+4
	ldr	r3, [r3, r0, asl #2]
	add	r3, r3, #233472
	ldr	r3, [r3, #384]
	cmp	r3, #0
	beq	.L178
.L172:
	ldr	r3, .L179+8
	add	r0, r4, #20
	mov	r2, #32
	ldr	r3, [r3, #52]
	blx	r3
	mov	r0, #0
.L168:
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L178:
	mov	r0, r4
	str	r1, [fp, #-24]
	bl	FSP_ClearContext
	ldr	r1, [fp, #-24]
	b	.L172
.L170:
	ldr	r3, .L179+12
	movw	r2, #539
	ldr	r1, .L179+16
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L168
.L176:
	ldr	r3, .L179+20
	mov	r2, #536
	ldr	r1, .L179+16
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L168
.L177:
	mov	r0, r1
	ldr	r3, .L179+24
	movw	r2, #537
	ldr	r1, .L179+16
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L168
.L180:
	.align	2
.L179:
	.word	.LANCHOR0
	.word	s_pstVfmwChan
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC8
	.word	.LC1
	.word	.LC0
	.word	.LC7
	.fnend
	.size	FSP_ConfigInstance, .-FSP_ConfigInstance
	.align	2
	.global	FSP_ConfigFrameBuf
	.type	FSP_ConfigFrameBuf, %function
FSP_ConfigFrameBuf:
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
	mov	r5, r0
	ldr	r0, .L251
	mov	r7, r1
	mov	r8, r2
	mov	r1, #0
	movw	r2, #1144
	ldr	ip, [r0, #48]
	ldr	r0, .L251+4
	str	r3, [fp, #-116]
	blx	ip
	cmp	r5, #15
	bhi	.L242
	ldr	r3, .L251+8
	ldr	r4, [r3, r5, asl #2]
	cmp	r4, #0
	beq	.L243
	ldr	r6, .L251+12
	ldr	r0, [r6, r5, asl #2]
	add	r3, r0, #237568
	ldr	r9, [r3, #336]
	cmp	r9, #0
	beq	.L244
	ldr	lr, [r4, #28]
	ldr	ip, [r4, #32]
	mul	r1, lr, ip
.L188:
	ldr	r2, [r0, #152]
	ldr	r3, [r0, #156]
	mul	r9, r3, r2
	cmp	r9, r1
	blt	.L245
	ldr	r3, [r0, #1424]
	add	r0, r0, #233472
	ldrsb	r2, [r4, #23]
	cmp	r3, #1
	str	r2, [fp, #-48]
	beq	.L246
.L191:
	ldr	r3, [r0, #392]
	ldr	r2, [fp, #-48]
	cmp	r2, r3
	ldr	r2, .L251+16
	movne	r3, #1
	moveq	r3, #0
	ldr	ip, [r2, #52]
	str	r3, [r0, #408]
	ldrsb	r3, [r4, #23]
	cmp	ip, #0
	str	r3, [r0, #392]
	beq	.L195
	ldr	lr, .L251+4
	mov	r10, #32
	ldr	r3, [r4, #32]
	mov	r1, r8
	ldr	r2, [r4, #28]
	mov	r0, r7
	str	lr, [sp, #16]
	str	r5, [sp, #12]
	ldrsb	lr, [r4, #22]
	str	r10, [sp, #4]
	ldr	r9, .L251+20
	str	lr, [sp, #8]
	ldrsb	lr, [r4, #26]
	ldr	r7, .L251+12
	str	lr, [sp]
	blx	ip
	ldr	r3, [r6, r5, asl #2]
	add	r3, r3, #233472
	ldr	r3, [r3, #3840]
	cmp	r3, #20
	movge	r3, #20
	strb	r3, [r4, #13]
	cmp	r0, #2
	mov	r8, r0
	beq	.L247
	cmp	r0, #0
	bne	.L198
	ldr	r3, [r9, #-2924]
	mov	r0, #31
	ldr	r1, .L251+24
	strb	r3, [r4, #9]
	ldr	r3, [r7, r5, asl #2]
	str	r8, [r3, #1464]
	bl	dprint_vfmw
	ldr	r3, [r9, #-2924]
	ldr	r2, [fp, #-48]
	cmp	r2, r3
	bgt	.L248
	ldrsb	r3, [r4, #1]
	strb	r8, [r4, #11]
	cmp	r3, #0
	strb	r8, [r4, #12]
	bne	.L249
.L201:
	ldr	r3, [r9, #-2924]
	cmp	r3, #32
	movge	r3, #32
	strb	r3, [r4, #10]
.L202:
	ldr	r3, .L251
	mov	r0, #8
	ldr	r3, [r3, #12]
	blx	r3
	ldr	ip, [r9, #-2752]
	ldr	r1, .L251+20
	cmp	ip, #0
	beq	.L250
	add	r3, r4, #24576
	str	r3, [fp, #-52]
	sub	lr, r1, #3104
	str	lr, [fp, #-48]
	mov	r2, r3
	mov	r3, #100
	ldr	r2, [r2, #2956]
	mov	r8, #0
	ldr	lr, [r1, #-3876]
	add	ip, r2, ip
	str	ip, [fp, #-108]
	ldr	ip, [r1, #-2944]
	mla	r3, r3, r2, r4
	ldr	r0, [r6, r5, asl #2]
	str	ip, [fp, #-72]
	ldr	ip, [r1, #-2940]
	str	lr, [fp, #-56]
	mov	r7, r0
	ldr	lr, [r1, #-2952]
	add	r0, r0, #237568
	str	ip, [fp, #-76]
	ldr	ip, [r1, #-2960]
	str	lr, [fp, #-68]
	str	r4, [fp, #-120]
	str	ip, [fp, #-80]
	ldr	ip, [r1, #-2956]
	str	r7, [fp, #-112]
	str	ip, [fp, #-84]
	ldr	ip, [r1, #-2972]
	str	ip, [fp, #-88]
	ldr	ip, [r1, #-2968]
	str	ip, [fp, #-92]
	ldr	ip, [r4, #28]
	str	ip, [fp, #-60]
	ldr	ip, [r4, #32]
	str	ip, [fp, #-64]
	ldr	ip, [r1, #-2936]
	str	ip, [fp, #-96]
	ldr	ip, [r1, #-2932]
	ldr	r1, [r1, #-2928]
	str	ip, [fp, #-100]
	ldr	ip, .L251+4
	str	r1, [fp, #-104]
.L206:
	add	lr, r3, #20224
	add	r1, lr, #172
	str	r2, [lr, #164]
	mov	r4, lr
	ldr	r5, [ip, #8]
	mov	r10, lr
	mov	r6, lr
	str	r5, [r1]
	mov	r5, lr
	ldr	r7, [ip, #12]
	str	r7, [r4, #176]
	mov	r4, lr
	ldr	r7, [fp, #-56]
	str	r7, [r10, #188]
	ldr	r7, [fp, #-68]
	str	r7, [lr, #204]
	ldr	r7, [fp, #-72]
	str	r7, [r6, #208]
	ldr	r6, [fp, #-76]
	ldr	r7, [fp, #-88]
	str	r6, [r5, #212]
	mov	r6, lr
	ldr	r5, [fp, #-80]
	str	r5, [r4, #216]
	mov	r5, lr
	ldr	r4, [fp, #-84]
	str	r4, [lr, #220]
	mov	r4, r6
	ldr	lr, [fp, #-48]
	ldr	r10, [lr, #4]!
	str	r10, [r6, #192]
	str	r7, [r5, #196]
	mov	r5, r6
	ldr	r7, [fp, #-92]
	str	lr, [fp, #-48]
	mov	lr, r6
	str	r7, [r4, #200]
	mov	r4, r6
	ldr	r7, [fp, #-60]
	str	r7, [lr, #224]
	mov	lr, r6
	ldr	r7, [fp, #-64]
	str	r7, [r6, #228]
	ldr	r7, [fp, #-96]
	str	r7, [r5, #232]
	ldr	r7, [fp, #-100]
	str	r7, [r4, #236]
	add	r4, r6, #158
	ldr	r7, [fp, #-104]
	str	r7, [lr, #240]
	strb	r8, [r6, #156]
	strb	r8, [r6, #157]
	strb	r8, [r4]
	ldr	lr, [r0, #332]
	cmp	lr, #0
	bne	.L207
	ldr	r5, [r0, #328]
	cmp	r5, #0
	beq	.L207
	ldr	r5, [r1]
	ldr	r7, [fp, #-112]
.L209:
	mov	r1, lr, asl #4
	add	lr, lr, #1
	add	r1, r1, #236544
	add	r1, r1, #844
	ldr	r1, [r7, r1]
	cmp	r5, r1
	moveq	r1, #4
	streqb	r1, [r4]
	ldr	r1, [r0, #328]
	cmp	r1, lr
	bhi	.L209
	str	r7, [fp, #-112]
.L207:
	add	r1, r3, #20224
	ldr	lr, [fp, #-108]
	add	r2, r2, #1
	add	ip, ip, #12
	cmp	r2, lr
	mov	lr, #1
	str	lr, [r1, #252]
	add	r3, r3, #100
	ldr	r1, [fp, #-52]
	str	r2, [r1, #2956]
	bne	.L206
	ldr	r4, [fp, #-120]
.L204:
	ldr	lr, [r9, #-2744]
	cmp	lr, #0
	beq	.L214
	ldr	r3, [fp, #-52]
	mov	r5, #100
	ldr	r1, .L251+4
	ldr	r0, [r3, #2964]
	add	lr, lr, r0
	mov	r2, r0
.L213:
	mla	r3, r5, r2, r4
	ldr	ip, [r1, #392]
	add	r2, r0, #1
	add	r1, r1, #12
	cmp	r2, lr
	add	r3, r3, #20224
	mov	r0, r2
	str	ip, [r3, #180]
	bne	.L213
	ldr	r3, [fp, #-52]
	str	r2, [r3, #2964]
.L214:
	ldr	r6, [fp, #-52]
	mov	lr, #0
	mov	r5, #1
	strb	r5, [r4, #12]
	ldr	r7, [fp, #-56]
	str	lr, [r6, #2212]
	ldrsb	r3, [r4, #10]
	ldr	r0, [r9, #-2944]
	cmp	r3, #31
	str	r7, [r6, #2236]
	ldr	r7, [fp, #-60]
	movge	r3, #31
	ldr	r2, [r9, #-2756]
	mov	r1, r3, asl #4
	str	r0, [r6, #2256]
	sub	r3, r1, r3, asl #2
	ldr	r1, [r9, #-2952]
	add	r3, r9, r3
	str	r7, [r6, #2272]
	ldr	ip, [r9, #-2940]
	cmp	r2, #20
	ldr	r3, [r3, #-3868]
	str	r1, [r6, #2252]
	movge	r2, #20
	ldr	r1, [r9, #-2932]
	str	r3, [r6, #2220]
	ldr	r0, [r9, #-2928]
	ldr	r3, [r9, #-2936]
	ldr	r7, [fp, #-64]
	strb	lr, [r6, #2204]
	strb	lr, [r6, #2205]
	strb	lr, [r6, #2206]
	str	r5, [r6, #2300]
	str	r7, [r6, #2276]
	str	ip, [r6, #2260]
	str	r3, [r6, #2280]
	str	r1, [r6, #2284]
	str	r0, [r6, #2288]
	strb	r2, [r4, #13]
	ldr	r6, [r9, #-2748]
	cmp	r6, lr
	beq	.L212
	ldr	r3, [fp, #-52]
	ldr	r0, .L251+4
	ldr	r3, [r3, #2960]
	add	r2, r3, #3408
	add	r6, r3, r6
	add	r2, r2, #13
	add	r1, r4, r2, lsl #3
.L215:
	ldr	r7, [r0, #956]
	add	r3, r3, #1
	add	ip, r4, r2, lsl #3
	cmp	r3, r6
	add	r2, r3, #3408
	add	r0, r0, #8
	str	r7, [r1]
	add	r2, r2, #13
	strb	lr, [ip, #5]
	add	r1, r1, #8
	strb	r5, [r1, #-4]
	bne	.L215
	ldr	r2, [fp, #-52]
	str	r3, [r2, #2960]
.L212:
	ldr	r0, [r9, #-2760]
	add	r4, r4, #16384
	ldr	ip, [fp, #-52]
	mov	r3, #1
	ldr	r7, [fp, #-56]
	mov	r5, #0
	ldr	r1, [r9, #-2952]
	str	r0, [ip, #2788]
	mov	r0, #8
	str	r7, [r4, #3928]
	ldr	r7, [fp, #-60]
	ldr	r2, [r9, #-2944]
	ldr	lr, [r9, #-2940]
	ldr	r6, [r9, #-2936]
	ldr	r8, [r9, #-2932]
	ldr	r10, [r9, #-2928]
	ldr	ip, [r4, #4012]
	str	r7, [r4, #3964]
	str	r3, [r4, #3992]
	ldr	r7, [r9, #-3872]
	ldr	r3, [fp, #-116]
	ldr	r9, [fp, #-64]
	str	ip, [r4, #3912]
	str	r1, [r4, #3944]
	str	r9, [r4, #3968]
	str	r2, [r4, #3948]
	str	lr, [r4, #3952]
	str	r6, [r4, #3972]
	str	r8, [r4, #3976]
	str	r10, [r4, #3980]
	str	r5, [r4, #3904]
	strb	r5, [r4, #3896]
	strb	r5, [r4, #3897]
	strb	r5, [r4, #3898]
	str	r7, [r3]
	ldr	r3, .L251
	ldr	r3, [r3, #16]
	blx	r3
	mov	r0, r5
.L234:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L244:
	mov	r0, r5
	bl	VCTRL_GetChanCapLevel
	cmp	r0, #32
	bhi	.L186
	ldr	r1, .L251+28
	mov	r3, r0, asl #5
	sub	r3, r3, r0, asl #2
	ldr	lr, [r4, #28]
	add	r2, r1, r3
	ldr	ip, [r4, #32]
	ldr	r3, [r1, r3]
	ldr	r10, [r2, #4]
	mul	r1, ip, lr
	mul	r2, r10, r3
	cmp	r0, #25
	cmpne	r1, r2
	ble	.L239
	ldrsb	r2, [r4, #22]
	cmp	r2, #1
	bne	.L217
.L239:
	ldr	r0, [r6, r5, asl #2]
	b	.L188
.L245:
	str	ip, [sp, #4]
	mov	r0, #0
	str	lr, [sp]
	ldr	r1, .L251+32
	bl	dprint_vfmw
	ldr	r3, .L251+36
	ldr	ip, [r3]
	cmp	ip, #0
	mvneq	r0, #0
	beq	.L234
	mov	r3, #0
	mov	r0, r5
	mov	r2, r3
	mov	r1, #102
	blx	ip
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L247:
	ldr	r3, [r9, #-2924]
	mov	r2, #1
	strb	r3, [r4, #9]
	ldr	r3, [r7, r5, asl #2]
	str	r2, [r3, #1464]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L246:
	ldr	r3, [r0, #368]
	bics	r2, r3, #2
	beq	.L191
	cmp	r3, #1
	moveq	r0, #0
	beq	.L234
	mov	r3, #0
	strb	r3, [r4, #9]
	ldr	r3, [r6, r5, asl #2]
	mov	r0, #31
	ldr	r1, .L251+40
	add	r3, r3, #233472
	ldr	r2, [r3, #368]
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L234
.L195:
	ldr	r3, [r0, #3840]
	mvn	r8, #0
	cmp	r3, #20
	movge	r3, #20
	strb	r3, [r4, #13]
.L198:
	mov	r3, #0
	strb	r3, [r4, #9]
	ldr	ip, [r6, r5, asl #2]
	mov	r2, r8
	mov	r0, r3
	ldr	r1, .L251+44
	str	r3, [ip, #1464]
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L234
.L249:
	ldr	r3, [r7, r5, asl #2]
	ldr	r3, [r3, #1424]
	cmp	r3, #1
	beq	.L201
	ldrsb	r3, [r4, #23]
	ldr	r2, [r9, #-2924]
	add	r3, r3, #4
	cmp	r3, r2
	movge	r3, r2
	strb	r3, [r4, #10]
	b	.L202
.L186:
	ldrsb	r3, [r4, #22]
	cmp	r3, #1
	bne	.L216
	ldr	lr, [r4, #28]
	ldr	ip, [r4, #32]
	ldr	r0, [r6, r5, asl #2]
	mul	r1, lr, ip
	b	.L188
.L250:
	ldr	r3, [r1, #-3876]
	str	r3, [fp, #-56]
	add	r3, r4, #24576
	str	r3, [fp, #-52]
	ldr	r3, [r4, #28]
	str	r3, [fp, #-60]
	ldr	r3, [r4, #32]
	str	r3, [fp, #-64]
	b	.L204
.L242:
	ldr	r3, .L251+48
	mov	r2, #576
	ldr	r1, .L251+52
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L234
.L216:
	mov	r2, r0
	ldr	r1, .L251+56
	mov	r0, r9
	bl	dprint_vfmw
.L189:
	mov	r3, #0
	mvn	r0, #0
	strb	r3, [r4, #9]
	b	.L234
.L217:
	mov	r2, r0
	str	ip, [sp, #8]
	str	lr, [sp, #4]
	mov	r0, r9
	str	r10, [sp]
	ldr	r1, .L251+60
	bl	dprint_vfmw
	b	.L189
.L248:
	str	r3, [sp]
	mov	r2, r8
	ldr	r3, [fp, #-48]
	mov	r0, r8
	ldr	r1, .L251+64
	bl	dprint_vfmw
	ldr	r3, .L251
	mov	r0, #8
	ldr	r3, [r3, #16]
	blx	r3
	mvn	r0, #0
	b	.L234
.L243:
	mov	r0, r4
	ldr	r3, .L251+68
	movw	r2, #577
	ldr	r1, .L251+52
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L234
.L252:
	.align	2
.L251:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR1-3876
	.word	.LANCHOR0
	.word	s_pstVfmwChan
	.word	g_vdm_hal_fun_ptr
	.word	.LANCHOR1
	.word	.LC13
	.word	CapItem
	.word	.LC11
	.word	g_event_report
	.word	.LC12
	.word	.LC14
	.word	.LC0
	.word	.LC1
	.word	.LC9
	.word	.LC10
	.word	.LC15
	.word	.LC4
	.fnend
	.size	FSP_ConfigFrameBuf, .-FSP_ConfigFrameBuf
	.align	2
	.global	FSP_GetDecodeFrameTable
	.type	FSP_GetDecodeFrameTable, %function
FSP_GetDecodeFrameTable:
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
	cmp	r0, #15
	bhi	.L263
	cmp	r1, #0
	beq	.L264
	cmp	r2, #0
	beq	.L265
	ldr	r3, .L267
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	beq	.L266
	ldrsb	r3, [r0, #10]
	str	r3, [r2]
	ldrsb	r3, [r0, #10]
	cmp	r3, #0
	ldmlefd	sp, {fp, sp, pc}
	add	r2, r0, #20224
	sub	r1, r1, #4
	add	r2, r2, #172
	mov	r3, #0
.L260:
	ldr	ip, [r2], #100
	add	r3, r3, #1
	str	ip, [r1, #4]!
	ldrsb	ip, [r0, #10]
	cmp	ip, r3
	bgt	.L260
	ldmfd	sp, {fp, sp, pc}
.L263:
	ldr	r3, .L267+4
	mov	r2, #860
	ldr	r1, .L267+8
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L264:
	mov	r0, r1
	ldr	r3, .L267+12
	movw	r2, #861
	ldr	r1, .L267+8
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L265:
	mov	r0, r2
	ldr	r3, .L267+16
	movw	r2, #862
	ldr	r1, .L267+8
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L266:
	ldr	r3, .L267+20
	movw	r2, #863
	ldr	r1, .L267+8
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L268:
	.align	2
.L267:
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.word	.LC16
	.word	.LC17
	.word	.LC4
	.fnend
	.size	FSP_GetDecodeFrameTable, .-FSP_GetDecodeFrameTable
	.align	2
	.global	FSP_GetDecodePmvTable
	.type	FSP_GetDecodePmvTable, %function
FSP_GetDecodePmvTable:
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
	cmp	r0, #15
	bhi	.L279
	cmp	r1, #0
	beq	.L280
	cmp	r2, #0
	beq	.L281
	ldr	r3, .L283
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	beq	.L282
	ldrsb	r3, [r0, #13]
	str	r3, [r2]
	ldrsb	r3, [r0, #13]
	cmp	r3, #0
	ldmlefd	sp, {fp, sp, pc}
	sub	r1, r1, #4
	mov	r2, #0
.L276:
	mov	r3, r2, asl #3
	add	r2, r2, #1
	add	r3, r3, #27136
	add	r3, r3, #232
	ldr	r3, [r0, r3]
	str	r3, [r1, #4]!
	ldrsb	r3, [r0, #13]
	cmp	r3, r2
	bgt	.L276
	ldmfd	sp, {fp, sp, pc}
.L279:
	ldr	r3, .L283+4
	movw	r2, #886
	ldr	r1, .L283+8
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L280:
	mov	r0, r1
	ldr	r3, .L283+12
	movw	r2, #887
	ldr	r1, .L283+8
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L281:
	mov	r0, r2
	ldr	r3, .L283+16
	mov	r2, #888
	ldr	r1, .L283+8
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L282:
	ldr	r3, .L283+20
	movw	r2, #889
	ldr	r1, .L283+8
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L284:
	.align	2
.L283:
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.word	.LC16
	.word	.LC17
	.word	.LC4
	.fnend
	.size	FSP_GetDecodePmvTable, .-FSP_GetDecodePmvTable
	.align	2
	.global	FSP_IsFsLeak
	.type	FSP_IsFsLeak, %function
FSP_IsFsLeak:
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
	ldr	r3, .L288
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	beq	.L286
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L286:
	ldr	r1, .L288+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L289:
	.align	2
.L288:
	.word	.LANCHOR0
	.word	.LC18
	.fnend
	.size	FSP_IsFsLeak, .-FSP_IsFsLeak
	.align	2
	.global	FindLeastTickPhyFs
	.type	FindLeastTickPhyFs, %function
FindLeastTickPhyFs:
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
	cmp	r1, #0
	mov	r2, r0
	mov	r0, #0
	ble	.L294
	mvn	lr, #0
	mov	r3, r0
.L293:
	ldr	ip, [r2, #88]
	add	r2, r2, #96
	cmp	ip, lr
	movcc	r0, r3
	add	r3, r3, #1
	movcc	lr, ip
	cmp	r3, r1
	bne	.L293
	ldmfd	sp, {fp, sp, pc}
.L294:
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	FindLeastTickPhyFs, .-FindLeastTickPhyFs
	.align	2
	.global	FSP_NewLogicFs
	.type	FSP_NewLogicFs, %function
FSP_NewLogicFs:
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
	cmp	r0, #15
	mov	r9, r0
	bhi	.L340
	ldr	r4, .L346
	ldr	r0, [r4, r0, asl #2]
	cmp	r0, #0
	beq	.L341
	ldr	r8, .L346+4
	mov	r0, #3
	str	r1, [fp, #-84]
	mov	r6, #0
	ldr	r3, [r8, #12]
	blx	r3
	ldr	r5, [r4, r9, asl #2]
	ldr	r1, [fp, #-84]
	mov	r3, r5
.L302:
	ldrsb	r2, [r3, #56]
	cmp	r2, #0
	bne	.L300
	ldrsb	r7, [r3, #57]
	cmp	r7, #0
	beq	.L342
.L300:
	add	r6, r6, #1
	add	r3, r3, #632
	cmp	r6, #32
	bne	.L302
.L303:
	ldr	r1, .L346+8
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r3, [r8, #16]
	mov	r0, #3
	blx	r3
	mvn	r0, #0
.L337:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L342:
	mov	r4, #632
	mul	r4, r4, r6
	add	r10, r5, r4
	add	r4, r4, #56
	add	r2, r10, #56
	adds	r4, r5, r4
	strb	r6, [r2, #3]
	strb	r7, [r2, #2]
	beq	.L303
	cmp	r1, #0
	str	r7, [r10, #664]
	str	r7, [r10, #668]
	str	r7, [r10, #672]
	str	r7, [r10, #676]
	bne	.L304
	add	r1, r5, #24576
	add	r3, r5, #20224
	add	r3, r3, #56
	str	r3, [r10, #664]
	str	r3, [r10, #668]
	mov	ip, #1
	str	r3, [r10, #672]
	ldr	r3, [r1, #2792]
	str	r3, [r10, #676]
	ldrb	r3, [r5, #13]
	strb	ip, [r2, #2]
	sub	r3, r3, #1
	strb	r3, [r2, #4]
.L305:
	mov	r0, #632
	mov	lr, #1
	mul	r6, r0, r6
	mov	r1, #0
	mov	r2, #592
	mov	r7, r1
	add	r9, r4, #480
	add	r3, r5, r6
	add	r0, r6, #64
	add	ip, r3, #56
	add	r0, r5, r0
	strb	lr, [ip, #1]
	ldr	r6, [r3, #668]
	str	ip, [fp, #-88]
	strb	lr, [r6, #2]
	str	lr, [r3, #660]
	ldr	r6, [r3, #664]
	ldr	lr, [r5, #16]
	str	lr, [r3, #656]
	str	lr, [r6, #88]
	ldr	lr, [r3, #668]
	ldr	r6, [r3, #656]
	str	r6, [lr, #88]
	ldr	lr, [r5, #16]
	add	lr, lr, #1
	str	lr, [r5, #16]
	ldr	r5, [r3, #664]
	ldr	r6, [r3, #668]
	ldr	r3, [r3, #672]
	str	r3, [fp, #-84]
	ldr	r3, [r8, #48]
	blx	r3
	ldr	ip, [fp, #-88]
	ldrsb	r2, [ip, #3]
	str	r2, [r4, #164]
	ldr	r2, [r5, #68]
	str	r2, [r4, #120]
	ldr	r2, [r5, #72]
	str	r2, [r4, #124]
	ldr	r2, [r6, #32]
	str	r2, [r4, #148]
	ldr	r2, [r6, #60]
	str	r2, [r4, #152]
	ldr	r2, [r6, #64]
	str	r2, [r4, #156]
	ldr	r1, [r5, #16]
	str	r1, [r4, #52]
	mov	r0, r1
	ldr	r2, [r5, #76]
	add	r2, r2, r1
	str	r2, [r4, #56]
	bl	MEM_Phy2Vir
	str	r7, [r4, #484]
	str	r0, [r4, #480]
	ldr	r0, [r4, #56]
	bl	MEM_Phy2Vir
	str	r7, [r4, #492]
	str	r0, [r4, #488]
	ldr	r0, [r5, #24]
	str	r0, [r4, #236]
	bl	MEM_Phy2Vir
	str	r7, [r4, #244]
	str	r0, [r4, #240]
	ldr	r0, [r6, #16]
	str	r0, [r4, #36]
	ldr	r2, [r6, #76]
	add	r2, r0, r2
	str	r2, [r4, #40]
	ldr	r1, [r6, #32]
	add	r1, r1, r0
	str	r1, [r4, #44]
	ldr	r1, [r6, #32]
	add	r2, r2, r1
	str	r2, [r4, #48]
	ldr	r1, [r6, #16]
	str	r1, [r4, #68]
	mov	r0, r1
	ldr	r2, [r6, #76]
	add	r2, r2, r1
	str	r2, [r4, #72]
	bl	MEM_Phy2Vir
	str	r7, [r4, #500]
	str	r0, [r4, #496]
	ldr	r0, [r4, #72]
	bl	MEM_Phy2Vir
	ldr	r3, [fp, #-84]
	str	r7, [r4, #508]
	add	ip, r4, #528
	ldr	r1, [r4, #52]
	str	r0, [r4, #504]
	ldr	r2, [r3, #16]
	str	r2, [r4, #60]
	ldr	r3, [r5, #76]
	add	r3, r3, r2
	str	r3, [r4, #64]
	ldr	r3, [r5, #48]
	str	r3, [r4, #160]
	ldr	r2, [r5, #52]
	add	r2, r2, r1
	str	r2, [r4, #76]
	ldr	r2, [r5, #52]
	ldr	r3, [r5, #56]
	add	r3, r2, r3
	add	r3, r3, r1
	str	r3, [r4, #80]
	ldrd	r2, [r9]
	ldr	lr, [r5, #52]
	strd	r2, [fp, #-84]
	adds	r2, r2, lr
	adc	r3, r3, lr, asr #31
	strd	r2, [ip, #-8]
	ldr	r2, [r5, #56]
	ldr	lr, [r5, #52]
	mov	r3, r2, asr #31
	adds	r0, r2, lr
	adc	r1, r3, lr, asr #31
	mov	r2, r0
	mov	r3, r1
	ldrd	r0, [fp, #-84]
	adds	r0, r0, r2
	adc	r1, r1, r3
	mov	r2, r0
	mov	r3, r1
	strd	r2, [ip]
	ldr	r3, [r6, #40]
	str	r3, [r4, #96]
	ldr	r3, [r6, #44]
	str	r3, [r4, #100]
	ldr	r3, [r5, #36]
	str	r3, [r4, #84]
	ldr	r0, [r5, #36]
	bl	MEM_Phy2Vir
	str	r7, [r4, #476]
	ldr	r3, [r8, #16]
	str	r7, [r4, #88]
	str	r7, [r4, #92]
	str	r0, [r4, #472]
	mov	r0, #3
	blx	r3
	ldr	ip, [fp, #-88]
	ldrsb	r0, [ip, #3]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L304:
	mov	r0, r9
	bl	VCTRL_GetVidStd
	cmp	r0, #17
	beq	.L306
	ldrsb	r1, [r5, #10]
	cmp	r1, #0
	ldrle	r0, [r10, #664]
	ble	.L308
	add	r3, r5, #20224
	add	r3, r3, #252
	b	.L310
.L309:
	add	r7, r7, #1
	add	r3, r3, #100
	cmp	r7, r1
	beq	.L339
.L310:
	ldr	r2, [r3]
	cmp	r2, #1
	bne	.L309
	ldrsb	r2, [r3, #-96]
	cmp	r2, #0
	bne	.L309
	ldrsb	r2, [r3, #-94]
	cmp	r2, #0
	bne	.L309
.L338:
	mov	r3, #632
	mov	r0, #100
	mla	r3, r3, r6, r5
	mla	r7, r0, r7, r5
	add	r0, r7, #20224
	add	r0, r0, #156
	str	r0, [r3, #664]
.L308:
	cmp	r0, #0
	beq	.L343
	mov	r7, #632
	add	r3, r5, #26624
	mla	r7, r7, r6, r5
	add	r3, r3, #156
	add	r10, r7, #672
	str	r3, [r7, #672]
	ldrsb	r3, [r5, #13]
	cmp	r3, #0
	ble	.L315
	mov	r0, r9
	bl	VCTRL_GetVidStd
	cmp	r0, #17
	beq	.L316
	ldrsb	r0, [r5, #13]
	cmp	r0, #0
	addgt	r3, r5, #27136
	movgt	r2, #0
	addgt	r3, r3, #236
	bgt	.L322
	b	.L318
.L319:
	add	r2, r2, #1
	add	r3, r3, #8
	cmp	r2, r0
	beq	.L318
.L322:
	ldrb	r1, [r3]
	cmp	r1, #1
	bne	.L319
	ldrb	r1, [r3, #1]
	cmp	r1, #0
	bne	.L319
	mov	r3, #632
	add	r1, r2, #3408
	mla	r3, r3, r6, r5
	add	r1, r1, #13
	cmp	r0, r2
	add	ip, r5, #24576
	strb	r2, [r3, #60]
	ldr	r2, [r5, r1, asl #3]
	str	r2, [r3, #676]
	ldr	lr, [ip, #2788]
	str	lr, [r3, #680]
	ble	.L320
.L315:
	mov	r7, #632
	ldr	r10, .L346+12
	mla	r7, r7, r6, r5
	ldr	r3, [r10, #-3896]
	cmp	r3, #0
	ldr	r3, [r7, #664]
	str	r3, [r7, #668]
	beq	.L305
	mov	r0, r9
	bl	VCTRL_GetImageWidth
	str	r0, [fp, #-84]
	mov	r0, r9
	bl	VCTRL_GetImageHeight
	ldr	ip, [r10, #-3888]
	ldr	r2, [fp, #-84]
	cmp	ip, #0
	mov	r3, r0
	beq	.L344
	mov	r0, r9
	sub	r1, fp, #72
	blx	ip
	cmp	r0, #0
	bne	.L326
	ldr	r9, [fp, #-68]
	cmp	r9, #0
	beq	.L345
	ldr	r3, [r7, #664]
	str	r9, [r3, #16]
	ldrsb	r3, [r7, #60]
	ldr	r2, [fp, #-52]
	add	r3, r3, #3408
	add	r3, r3, #13
	str	r2, [r7, #676]
	str	r2, [r5, r3, asl #3]
	b	.L305
.L339:
	mov	r3, #632
	mla	r3, r3, r6, r5
	ldr	r0, [r3, #664]
	b	.L308
.L318:
	add	ip, r5, #24576
	cmp	r0, #0
	ldr	lr, [ip, #2788]
	ble	.L324
.L320:
	mov	r2, #0
	mov	r1, r2
.L323:
	mov	r3, r2, asl #3
	add	r2, r2, #1
	add	r3, r3, #27136
	cmp	r2, r0
	add	r3, r3, #237
	strb	r1, [r5, r3]
	bne	.L323
.L324:
	mov	r3, #632
	mov	r2, #0
	mla	r3, r3, r6, r5
	mov	r0, r2
	ldr	r1, .L346+16
	strb	r2, [r3, #60]
	ldr	r2, [ip, #2792]
	str	lr, [r3, #680]
	str	r2, [r3, #676]
	bl	dprint_vfmw
	b	.L315
.L306:
	ldr	r2, .L346+20
	add	r3, r5, #20224
	add	r3, r3, #252
	ldr	r2, [r2, r9, asl #2]
	add	r2, r2, #528384
	ldr	r1, [r2, #3188]
	b	.L312
.L311:
	add	r7, r7, #1
	add	r3, r3, #100
	cmp	r7, #32
	beq	.L339
.L312:
	ldr	r2, [r3]
	cmp	r2, #1
	bne	.L311
	ldrsb	r2, [r3, #-96]
	cmp	r2, #0
	bne	.L311
	ldrsb	r2, [r3, #-94]
	cmp	r2, #0
	bne	.L311
	ldr	r2, [r3, #-76]
	cmp	r2, r1
	bne	.L311
	b	.L338
.L316:
	add	r3, r5, #24576
	mov	r1, #0
	strb	r1, [r7, #60]
	ldr	r2, [r3, #2792]
	str	r2, [r10, #4]
	ldr	r3, [r3, #2788]
	str	r3, [r7, #680]
	b	.L315
.L340:
	ldr	r3, .L346+24
	movw	r2, #1182
	ldr	r1, .L346+28
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L337
.L341:
	ldr	r3, .L346+32
	movw	r2, #1183
	ldr	r1, .L346+28
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L337
.L345:
	ldr	r3, [r8, #16]
	mov	r0, #3
	blx	r3
	mov	r0, r9
	ldr	r1, .L346+36
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L337
.L344:
	mov	r0, ip
	ldr	r1, .L346+40
	bl	dprint_vfmw
.L326:
	ldr	r3, [r8, #16]
	mov	r0, #3
	blx	r3
	ldr	r1, .L346+44
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L337
.L343:
	ldr	r2, .L346+48
	ldr	r1, .L346+52
	bl	dprint_vfmw
	ldr	r3, [r8, #16]
	mov	r0, #3
	blx	r3
	mvn	r0, #0
	b	.L337
.L347:
	.align	2
.L346:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC19
	.word	.LANCHOR1
	.word	.LC21
	.word	s_pstVfmwChan
	.word	.LC0
	.word	.LC1
	.word	.LC4
	.word	.LC23
	.word	.LC5
	.word	.LC22
	.word	.LANCHOR2
	.word	.LC20
	.fnend
	.size	FSP_NewLogicFs, .-FSP_NewLogicFs
	.align	2
	.global	FSP_GetPhyFsNum
	.type	FSP_GetPhyFsNum, %function
FSP_GetPhyFsNum:
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
	ldr	r6, .L356
	mov	r7, r0
	mov	r0, #3
	mov	r4, r1
	mov	r5, #0
	ldr	r3, [r6, #12]
	blx	r3
	ldr	r3, .L356+4
	ldr	ip, [r3, r7, asl #2]
	add	r3, ip, #20224
	add	ip, ip, #23552
	add	r3, r3, #252
	add	ip, ip, #124
	b	.L350
.L349:
	add	r3, r3, #100
	cmp	r3, ip
	beq	.L355
.L350:
	ldr	r2, [r3]
	cmp	r2, #1
	bne	.L349
	ldr	r2, [r3, #-76]
	add	r3, r3, #100
	cmp	r4, #0
	cmpne	r2, r4
	addeq	r5, r5, #1
	cmp	r3, ip
	bne	.L350
.L355:
	ldr	r3, [r6, #16]
	mov	r0, #3
	blx	r3
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L357:
	.align	2
.L356:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.fnend
	.size	FSP_GetPhyFsNum, .-FSP_GetPhyFsNum
	.align	2
	.global	FSP_RelsePhyFs
	.type	FSP_RelsePhyFs, %function
FSP_RelsePhyFs:
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
	ldr	r7, .L388
	mov	r6, r0
	mov	r0, #3
	mov	r8, r1
	mov	r4, #0
	ldr	r3, [r7, #12]
	blx	r3
	ldr	r3, .L388+4
	ldr	r1, [r3, r6, asl #2]
	add	r3, r1, #20224
	add	r3, r3, #252
	b	.L362
.L359:
	add	r4, r4, #1
	add	r3, r3, #100
	cmp	r4, #32
	beq	.L383
.L362:
	ldr	r2, [r3]
	cmp	r2, #1
	bne	.L359
	ldrsb	r2, [r3, #-96]
	cmp	r2, #0
	bne	.L359
	ldrsb	r5, [r3, #-94]
	cmp	r5, #0
	bne	.L359
	ldr	r2, [r3, #-76]
	cmp	r2, r8
	beq	.L359
	mov	r3, #100
	mla	r10, r3, r4, r1
	add	r3, r10, #20224
	add	r3, r3, #168
	ldr	r8, [r3, #4]
	str	r3, [fp, #-64]
	mov	r0, r8
	bl	MEM_Phy2Vir
	ldr	r3, [fp, #-64]
	cmp	r4, #31
	ldr	r2, [r3, #8]
	mov	r9, r0
	bgt	.L383
	add	r3, r10, #20224
	mov	r1, r0
	mov	r0, r8
	str	r5, [r3, #252]
	bl	MEM_DelMemRecord
	ldr	r3, [r7, #16]
	mov	r0, #3
	blx	r3
	ldr	r3, [r7, #12]
	mov	r0, #8
	blx	r3
	ldr	r2, .L388+8
	mov	r3, r5
	ldr	r0, [r2, r6, asl #2]
	add	r2, r0, #235520
	add	r2, r2, #688
	b	.L366
.L364:
	add	r3, r3, #1
	add	r2, r2, #12
	cmp	r3, #32
	beq	.L387
.L366:
	ldrb	r1, [r2]
	cmp	r1, #1
	bne	.L364
	ldr	r1, [r2, #-8]
	cmp	r8, r1
	bne	.L364
	cmp	r3, #31
	bgt	.L387
	mov	r1, r3, asl #4
	add	r2, r0, #233472
	sub	r3, r1, r3, asl #2
	mov	r1, #0
	add	r3, r2, r3
	strb	r1, [r3, #2736]
.L367:
	add	r3, r2, #416
	mov	r4, #0
	b	.L370
.L368:
	add	r4, r4, #1
	add	r3, r3, #72
	cmp	r4, #32
	beq	.L371
.L370:
	ldr	r2, [r3]
	cmp	r2, #255
	beq	.L368
	ldr	r2, [r3, #32]
	cmp	r8, r2
	bne	.L368
	cmp	r4, #31
	bgt	.L371
	ldr	r1, .L388+12
	mov	r3, r4, asl #6
	add	r3, r3, r4, lsl #3
	mov	r2, #255
	add	r3, r0, r3
	ldr	ip, [r1]
	add	r3, r3, #233472
	cmp	ip, #0
	str	r2, [r3, #416]
	beq	.L371
	mov	r2, #0
	str	r8, [fp, #-60]
	str	r2, [fp, #-56]
	mov	r0, r6
	str	r2, [fp, #-48]
	mov	r3, #16
	str	r9, [fp, #-52]
	sub	r2, fp, #60
	mov	r1, #123
	blx	ip
.L371:
	ldr	r3, [r7, #16]
	mov	r0, #8
	blx	r3
	cmp	r4, #31
	movle	r0, #0
	mvngt	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L383:
	ldr	r3, [r7, #16]
	mov	r0, #3
	blx	r3
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L387:
	add	r2, r0, #233472
	b	.L367
.L389:
	.align	2
.L388:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.word	s_pstVfmwChan
	.word	g_event_report
	.fnend
	.size	FSP_RelsePhyFs, .-FSP_RelsePhyFs
	.align	2
	.global	FSP_RemovePmv
	.type	FSP_RemovePmv, %function
FSP_RemovePmv:
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
	cmp	r0, #15
	bhi	.L396
	cmp	r1, #31
	bhi	.L397
	ldr	r3, .L399
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	beq	.L398
	mov	r3, #632
	mla	r3, r3, r1, r0
	ldr	r2, [r3, #660]
	cmp	r2, #2
	ldmnefd	sp, {fp, sp, pc}
	ldrb	r3, [r3, #60]
	cmp	r3, #19
	bhi	.L395
	sxtb	r3, r3
	mov	r2, #0
	add	r3, r3, #3408
	add	r3, r3, #13
	add	r3, r0, r3, lsl #3
	strb	r2, [r3, #5]
.L395:
	mov	r2, #632
	mov	r3, #0
	mla	r1, r2, r1, r0
	str	r3, [r1, #660]
	ldmfd	sp, {fp, sp, pc}
.L396:
	ldr	r3, .L399+4
	movw	r2, #1577
	ldr	r1, .L399+8
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L397:
	ldr	r3, .L399+12
	movw	r2, #1578
	ldr	r1, .L399+8
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L398:
	ldr	r3, .L399+16
	movw	r2, #1579
	ldr	r1, .L399+8
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L400:
	.align	2
.L399:
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.word	.LC24
	.word	.LC4
	.fnend
	.size	FSP_RemovePmv, .-FSP_RemovePmv
	.align	2
	.global	FSP_SetRef
	.type	FSP_SetRef, %function
FSP_SetRef:
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
	cmp	r0, #15
	mov	r4, r1
	mov	r6, r2
	bhi	.L432
	cmp	r1, #31
	bhi	.L433
	ldr	r1, .L443
	ldr	r7, [r1, r0, asl #2]
	cmp	r7, #0
	beq	.L434
	mov	r5, #632
	uxtb	r8, r2
	mla	r5, r5, r4, r7
	ldrsb	r3, [r5, #58]
	strb	r8, [r5, #56]
	cmp	r3, #0
	ldmnefd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	ldr	r3, [r5, #664]
	cmp	r3, #0
	beq	.L407
	ldr	ip, [r3, #88]
	ldr	r1, [r5, #656]
	cmp	ip, r1
	beq	.L435
.L407:
	mov	r2, #632
	mla	r2, r2, r4, r7
	ldrb	r3, [r2, #60]
	cmp	r3, #19
	bhi	.L410
	cmp	r6, #1
	beq	.L436
	cmp	r6, #0
	bne	.L413
	ldr	r0, [r2, #660]
	cmp	r0, #2
	beq	.L437
.L420:
	mov	r3, #632
	mla	r3, r3, r4, r7
	ldr	r3, [r3, #668]
	cmp	r3, #0
	beq	.L424
	ldrsb	r2, [r3, #2]
	cmp	r2, #1
	moveq	r2, #0
	streqb	r2, [r3, #2]
.L424:
	mov	r3, #632
	mla	r4, r3, r4, r7
	str	r6, [r4, #664]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L432:
	ldr	r3, .L443+4
	movw	r2, #1607
	ldr	r1, .L443+8
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L436:
	ldr	r1, [r2, #660]
	add	r2, r2, #656
	cmp	r1, #1
	beq	.L438
.L412:
	mov	r3, #632
	mla	r3, r3, r4, r7
	ldr	r2, [r3, #668]
	cmp	r2, #0
	beq	.L439
.L419:
	mov	r3, #632
	ldr	r0, [r2, #88]
	mla	r3, r3, r4, r7
	ldr	r1, [r3, #656]
	cmp	r6, #1
	cmpeq	r0, r1
	beq	.L440
.L416:
	cmp	r6, #0
	beq	.L424
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L433:
	ldr	r3, .L443+12
	movw	r2, #1608
	ldr	r1, .L443+8
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L410:
	sxtb	r3, r3
	movw	r2, #1681
	ldr	r1, .L443+16
	mov	r0, #0
	bl	dprint_vfmw
	cmp	r6, #0
	beq	.L420
	b	.L412
.L435:
	ldrsb	r1, [r3]
	cmp	r2, r1
	beq	.L408
	ldr	r1, .L443+20
	ldr	ip, [r1, #-3896]
	cmp	ip, #0
	bne	.L441
.L408:
	strb	r8, [r3]
	b	.L407
.L438:
	sxtb	r3, r3
	mov	r1, #2
	add	r3, r3, #3408
	add	r3, r3, #13
	add	r3, r7, r3, lsl #3
	strb	r6, [r3, #5]
	str	r1, [r2, #4]
.L413:
	mov	r3, #632
	mla	r3, r3, r4, r7
	ldr	r2, [r3, #668]
	cmp	r2, #0
	bne	.L419
	b	.L416
.L441:
	ldr	ip, [r1, #-3880]
	ldr	r1, [r3, #16]
	cmp	ip, #0
	beq	.L442
	blx	ip
	ldr	r3, [r5, #664]
	b	.L408
.L437:
	sxtb	r3, r3
	add	r3, r3, #3408
	add	r3, r3, #13
	add	r3, r7, r3, lsl #3
	strb	r6, [r3, #5]
	str	r6, [r2, #676]
	str	r6, [r2, #660]
	b	.L420
.L434:
	mov	r0, r7
	ldr	r3, .L443+24
	movw	r2, #1609
	ldr	r1, .L443+8
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L440:
	ldrsb	r1, [r2, #2]
	cmp	r1, #1
	moveq	r1, #2
	streqb	r1, [r2, #2]
	streqb	r1, [r3, #57]
	b	.L416
.L439:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L442:
	mov	r0, ip
	ldr	r1, .L443+28
	bl	dprint_vfmw
	ldr	r3, [r5, #664]
	b	.L408
.L444:
	.align	2
.L443:
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.word	.LC24
	.word	.LC25
	.word	.LANCHOR1
	.word	.LC4
	.word	.LC5
	.fnend
	.size	FSP_SetRef, .-FSP_SetRef
	.align	2
	.global	FSP_GetRef
	.type	FSP_GetRef, %function
FSP_GetRef:
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
	cmp	r0, #15
	bhi	.L450
	cmp	r1, #31
	bhi	.L451
	ldr	r3, .L453
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	beq	.L452
	mov	r0, #632
	mla	r1, r0, r1, r3
	ldrsb	r0, [r1, #56]
	ldmfd	sp, {fp, sp, pc}
.L450:
	ldr	r3, .L453+4
	movw	r2, #1720
	ldr	r1, .L453+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L451:
	ldr	r3, .L453+12
	movw	r2, #1721
	ldr	r1, .L453+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L452:
	mov	r0, r3
	movw	r2, #1722
	ldr	r3, .L453+16
	ldr	r1, .L453+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L454:
	.align	2
.L453:
	.word	.LANCHOR0
	.word	.LC26
	.word	.LC1
	.word	.LC27
	.word	.LC28
	.fnend
	.size	FSP_GetRef, .-FSP_GetRef
	.align	2
	.global	FSP_SetDisplay
	.type	FSP_SetDisplay, %function
FSP_SetDisplay:
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
	cmp	r0, #15
	mov	r5, r0
	mov	r4, r1
	mov	r8, r2
	bhi	.L497
	cmp	r1, #31
	bhi	.L498
	ldr	r9, .L505
	ldr	r0, [r9, r0, asl #2]
	cmp	r0, #0
	beq	.L499
	ldr	r7, .L505+4
	mov	r0, #3
	clz	r6, r2
	ldr	r3, [r7, #12]
	mov	r6, r6, lsr #5
	blx	r3
	ldr	r9, [r9, r5, asl #2]
	mov	r3, #632
	mla	r3, r3, r4, r9
	add	r2, r3, #56
	ldrsb	r1, [r3, #58]
	cmp	r1, #0
	cmpeq	r8, #0
	bne	.L460
	ldr	r3, [r3, #668]
	cmp	r3, #0
	beq	.L460
	ldrsb	r2, [r2, #1]
	cmp	r2, #0
	beq	.L460
	ldr	r2, .L505+8
	ldr	r1, [r2, #-3896]
	cmp	r1, #0
	bne	.L500
.L460:
	mov	r2, #632
	cmp	r6, #0
	mla	r2, r2, r4, r9
	movne	r3, #0
	moveq	r3, #3
	add	r1, r2, #56
	ldrsb	ip, [r1, #2]
	strb	r3, [r1, #1]
	cmp	ip, #0
	bne	.L471
	add	r8, r2, #664
	ldr	r3, [r8, #4]
	cmp	r3, #0
	beq	.L471
	ldr	r3, [r3, #88]
	ldr	r2, [r2, #656]
	cmp	r3, r2
	bne	.L501
	cmp	r6, #0
	beq	.L466
	strb	ip, [r1, #1]
	mov	r0, r5
	ldr	r3, [r8, #4]
	strb	ip, [r3, #2]
	bl	VCTRL_GetVidStd
	cmp	r0, #17
	beq	.L502
.L468:
	mov	r2, #632
	mov	r3, #0
	mla	r4, r2, r4, r9
	add	r4, r4, #664
	str	r3, [r4, #4]
.L471:
	ldr	r3, [r7, #16]
	mov	r0, #3
	blx	r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L497:
	ldr	r3, .L505+12
	movw	r2, #1739
	ldr	r1, .L505+16
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L466:
	mov	r0, r5
	bl	VCTRL_GetVidStd
	cmp	r0, #17
	beq	.L503
.L470:
	mov	r3, #632
	mov	r2, #3
	mla	r4, r3, r4, r9
	ldr	r3, [r4, #668]
	strb	r2, [r4, #57]
	strb	r2, [r3, #2]
	b	.L471
.L498:
	ldr	r3, .L505+20
	movw	r2, #1740
	ldr	r1, .L505+16
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L501:
	mov	r0, ip
	ldr	r1, .L505+24
	bl	dprint_vfmw
	ldr	r3, [r7, #16]
	mov	r0, #3
	blx	r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L499:
	ldr	r3, .L505+28
	movw	r2, #1741
	ldr	r1, .L505+16
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L500:
	ldr	r2, [r2, #-3884]
	ldr	r1, [r3, #16]
	cmp	r2, #0
	beq	.L504
	mov	r0, r5
	blx	r2
	b	.L460
.L502:
	ldr	r3, [r8, #4]
	cmp	r3, #0
	beq	.L468
	ldr	r2, [r3, #4]
	cmp	r2, #0
	beq	.L468
	sub	r2, r2, #1
	str	r2, [r3, #4]
	ldr	r3, [r8, #4]
	ldr	r2, [r3, #4]
	cmp	r2, #0
	movne	r2, #3
	strneb	r2, [r3, #2]
	b	.L468
.L503:
	ldr	r3, [r8, #4]
	cmp	r3, #0
	ldrne	r2, [r3, #4]
	addne	r2, r2, #1
	strne	r2, [r3, #4]
	b	.L470
.L504:
	mov	r0, r2
	ldr	r1, .L505+32
	bl	dprint_vfmw
	b	.L460
.L506:
	.align	2
.L505:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR1
	.word	.LC0
	.word	.LC1
	.word	.LC24
	.word	.LC29
	.word	.LC4
	.word	.LC6
	.fnend
	.size	FSP_SetDisplay, .-FSP_SetDisplay
	.align	2
	.global	FSP_ClearNotInVoQueue
	.type	FSP_ClearNotInVoQueue, %function
FSP_ClearNotInVoQueue:
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
	cmp	r0, #15
	mov	r5, r0
	mov	r7, r1
	bhi	.L518
	cmp	r1, #0
	beq	.L519
	ldr	r3, .L522
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	addne	r6, r0, #20224
	addne	r4, r0, #64
	addne	r6, r6, #64
	bne	.L513
	b	.L520
.L512:
	add	r4, r4, #632
	cmp	r4, r6
	beq	.L521
.L513:
	mov	r2, #0
	ldr	r1, [r4, #156]
	mov	r0, r5
	bl	FSP_SetRef
	mov	r1, r4
	mov	r0, r7
	bl	IsImageInVoQueue
	cmp	r0, #0
	beq	.L512
	ldr	r1, [r4, #156]
	mov	r2, #0
	mov	r0, r5
	add	r4, r4, #632
	bl	FSP_SetDisplay
	cmp	r4, r6
	bne	.L513
.L521:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L518:
	ldr	r3, .L522+4
	mov	r2, #508
	ldr	r1, .L522+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L520:
	ldr	r3, .L522+12
	movw	r2, #510
	ldr	r1, .L522+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L519:
	mov	r0, r1
	ldr	r3, .L522+16
	movw	r2, #509
	ldr	r1, .L522+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L523:
	.align	2
.L522:
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.word	.LC4
	.word	.LC30
	.fnend
	.size	FSP_ClearNotInVoQueue, .-FSP_ClearNotInVoQueue
	.align	2
	.global	FSP_GetDisplay
	.type	FSP_GetDisplay, %function
FSP_GetDisplay:
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
	ldr	r3, .L528
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	beq	.L527
	mov	r0, #632
	mla	r1, r0, r1, r3
	ldrsb	r0, [r1, #57]
	ldmfd	sp, {fp, sp, pc}
.L527:
	mov	r0, r3
	movw	r2, #1832
	ldr	r3, .L528+4
	ldr	r1, .L528+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L529:
	.align	2
.L528:
	.word	.LANCHOR0
	.word	.LC4
	.word	.LC1
	.fnend
	.size	FSP_GetDisplay, .-FSP_GetDisplay
	.align	2
	.global	FSP_SetStoreType
	.type	FSP_SetStoreType, %function
FSP_SetStoreType:
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
	cmp	r0, #15
	bhi	.L538
	ldr	ip, .L541
	ldr	ip, [ip, r0, asl #2]
	cmp	ip, #0
	beq	.L539
	cmp	r1, #0
	bne	.L534
	ldrsb	r0, [ip, #10]
	cmp	r0, r2
	ble	.L537
	mov	lr, #100
	mov	r0, r1
	mla	r2, lr, r2, ip
	add	r2, r2, #20224
	str	r3, [r2, #168]
	ldmfd	sp, {fp, sp, pc}
.L534:
	cmp	r1, #1
	beq	.L540
.L537:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L540:
	ldrsb	r1, [ip, #11]
	cmp	r2, r1
	bge	.L537
	mov	r1, #100
	mov	r0, #0
	mla	r2, r1, r2, ip
	add	r2, r2, #23552
	str	r3, [r2, #40]
	ldmfd	sp, {fp, sp, pc}
.L538:
	ldr	r3, .L541+4
	movw	r2, #1848
	ldr	r1, .L541+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L539:
	mov	r0, ip
	ldr	r3, .L541+12
	movw	r2, #1849
	ldr	r1, .L541+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L542:
	.align	2
.L541:
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.word	.LC4
	.fnend
	.size	FSP_SetStoreType, .-FSP_SetStoreType
	.align	2
	.global	FSP_GetStoreType
	.type	FSP_GetStoreType, %function
FSP_GetStoreType:
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
	cmp	r0, #15
	bhi	.L551
	ldr	r3, .L554
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	beq	.L552
	cmp	r1, #0
	bne	.L547
	ldrsb	r3, [r0, #10]
	cmp	r3, r2
	ble	.L550
	mov	r3, #100
	mla	r2, r3, r2, r0
	add	r2, r2, #20224
	ldr	r0, [r2, #168]
	ldmfd	sp, {fp, sp, pc}
.L547:
	cmp	r1, #1
	beq	.L553
.L550:
	mov	r0, #2
	ldmfd	sp, {fp, sp, pc}
.L551:
	ldr	r3, .L554+4
	movw	r2, #1881
	ldr	r1, .L554+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L552:
	ldr	r3, .L554+12
	movw	r2, #1882
	ldr	r1, .L554+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L553:
	ldrsb	r3, [r0, #11]
	cmp	r2, r3
	bge	.L550
	mov	r3, #100
	mla	r2, r3, r2, r0
	add	r2, r2, #23552
	ldr	r0, [r2, #40]
	ldmfd	sp, {fp, sp, pc}
.L555:
	.align	2
.L554:
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.word	.LC4
	.fnend
	.size	FSP_GetStoreType, .-FSP_GetStoreType
	.align	2
	.global	FSP_ClearLogicFs
	.type	FSP_ClearLogicFs, %function
FSP_ClearLogicFs:
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
	cmp	r0, #15
	cmpls	r1, #31
	mov	r4, r0
	mov	r5, r1
	ldmhifd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	r6, .L566
	ldr	r3, [r6, r0, asl #2]
	cmp	r3, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	mov	r2, #0
	bl	FSP_SetRef
	ldr	r2, [r6, r4, asl #2]
	mov	r3, #632
	mla	r3, r3, r5, r2
	ldrsb	r3, [r3, #57]
	cmp	r3, #3
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	mov	r1, r5
	mov	r0, r4
	mov	r2, #0
	bl	FSP_SetDisplay
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L567:
	.align	2
.L566:
	.word	.LANCHOR0
	.fnend
	.size	FSP_ClearLogicFs, .-FSP_ClearLogicFs
	.align	2
	.global	FSP_GetLogicFs
	.type	FSP_GetLogicFs, %function
FSP_GetLogicFs:
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
	cmp	r0, #15
	cmpls	r1, #31
	movls	r3, #1
	movhi	r3, #0
	bhi	.L570
	ldr	r3, .L572
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	movne	r3, #632
	mlane	r1, r3, r1, r0
	addne	r0, r1, #56
	ldmfd	sp, {fp, sp, pc}
.L570:
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L573:
	.align	2
.L572:
	.word	.LANCHOR0
	.fnend
	.size	FSP_GetLogicFs, .-FSP_GetLogicFs
	.align	2
	.global	FSP_GetFsImagePtr
	.type	FSP_GetFsImagePtr, %function
FSP_GetFsImagePtr:
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
	cmp	r0, #15
	cmpls	r1, #31
	movls	r3, #1
	movhi	r3, #0
	bhi	.L576
	ldr	r3, .L578
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	movne	r3, #632
	mlane	r1, r3, r1, r0
	addne	r0, r1, #64
	ldmfd	sp, {fp, sp, pc}
.L576:
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L579:
	.align	2
.L578:
	.word	.LANCHOR0
	.fnend
	.size	FSP_GetFsImagePtr, .-FSP_GetFsImagePtr
	.align	2
	.global	FSP_GetDecPhyFs
	.type	FSP_GetDecPhyFs, %function
FSP_GetDecPhyFs:
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
	cmp	r0, #15
	cmpls	r1, #31
	movls	r3, #1
	movhi	r3, #0
	bhi	.L582
	ldr	r3, .L584
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	movne	r3, #632
	mlane	r0, r3, r1, r0
	ldrne	r0, [r0, #664]
	ldmfd	sp, {fp, sp, pc}
.L582:
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L585:
	.align	2
.L584:
	.word	.LANCHOR0
	.fnend
	.size	FSP_GetDecPhyFs, .-FSP_GetDecPhyFs
	.align	2
	.global	FSP_GetDispPhyFs
	.type	FSP_GetDispPhyFs, %function
FSP_GetDispPhyFs:
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
	cmp	r0, #15
	cmpls	r1, #31
	movls	r3, #1
	movhi	r3, #0
	bhi	.L588
	ldr	r3, .L590
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	movne	r3, #632
	mlane	r0, r3, r1, r0
	ldrne	r0, [r0, #668]
	ldmfd	sp, {fp, sp, pc}
.L588:
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L591:
	.align	2
.L590:
	.word	.LANCHOR0
	.fnend
	.size	FSP_GetDispPhyFs, .-FSP_GetDispPhyFs
	.align	2
	.global	FSP_GetPmvAddr
	.type	FSP_GetPmvAddr, %function
FSP_GetPmvAddr:
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
	cmp	r0, #15
	cmpls	r1, #31
	movls	r3, #1
	movhi	r3, #0
	bhi	.L594
	ldr	r3, .L596
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	movne	r3, #632
	mlane	r0, r3, r1, r0
	ldrne	r0, [r0, #676]
	ldmfd	sp, {fp, sp, pc}
.L594:
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L597:
	.align	2
.L596:
	.word	.LANCHOR0
	.fnend
	.size	FSP_GetPmvAddr, .-FSP_GetPmvAddr
	.align	2
	.global	FSP_GetDecFsAddrTab
	.type	FSP_GetDecFsAddrTab, %function
FSP_GetDecFsAddrTab:
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
	cmp	r0, #15
	bhi	.L608
	cmp	r2, #0
	beq	.L609
	cmp	r1, #0
	beq	.L610
	ldr	r3, .L612
	ldr	ip, [r3, r0, asl #2]
	cmp	ip, #0
	beq	.L611
	mov	ip, #0
	str	ip, [r1]
	ldr	lr, [r3, r0, asl #2]
	ldrsb	lr, [lr, #10]
	cmp	lr, ip
	str	lr, [r1]
	ldr	r3, [r3, r0, asl #2]
	add	r3, r3, #20224
	add	r3, r3, #156
	ldmlefd	sp, {fp, sp, pc}
	sub	r2, r2, #4
.L605:
	ldr	lr, [r3, #16]
	add	ip, ip, #1
	add	r3, r3, #100
	str	lr, [r2, #4]!
	ldr	lr, [r1]
	cmp	lr, ip
	bgt	.L605
	ldmfd	sp, {fp, sp, pc}
.L608:
	ldr	r3, .L612+4
	movw	r2, #2028
	ldr	r1, .L612+8
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L609:
	mov	r0, r2
	ldr	r3, .L612+12
	movw	r2, #2029
	ldr	r1, .L612+8
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L610:
	mov	r0, r1
	ldr	r3, .L612+16
	movw	r2, #2030
	ldr	r1, .L612+8
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L611:
	mov	r0, ip
	ldr	r3, .L612+20
	movw	r2, #2031
	ldr	r1, .L612+8
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L613:
	.align	2
.L612:
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.word	.LC31
	.word	.LC32
	.word	.LC4
	.fnend
	.size	FSP_GetDecFsAddrTab, .-FSP_GetDecFsAddrTab
	.align	2
	.global	FSP_GetPmvAddrTab
	.type	FSP_GetPmvAddrTab, %function
FSP_GetPmvAddrTab:
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
	cmp	r0, #15
	bhi	.L624
	cmp	r2, #0
	beq	.L625
	cmp	r1, #0
	beq	.L626
	ldr	ip, .L628
	ldr	r3, [ip, r0, asl #2]
	cmp	r3, #0
	beq	.L627
	mov	r3, #0
	str	r3, [r1]
	ldr	ip, [ip, r0, asl #2]
	ldrsb	r0, [ip, #13]
	str	r0, [r1]
	ldrsb	r1, [ip, #13]
	cmp	r1, r3
	ldmlefd	sp, {fp, sp, pc}
	sub	r2, r2, #4
	mov	r1, r3
.L621:
	mov	r3, r1, asl #3
	add	r1, r1, #1
	add	r3, r3, #27136
	add	r3, r3, #232
	ldr	r3, [ip, r3]
	str	r3, [r2, #4]!
	ldrsb	r3, [ip, #13]
	cmp	r3, r1
	bgt	.L621
	ldmfd	sp, {fp, sp, pc}
.L624:
	ldr	r3, .L628+4
	movw	r2, #2061
	ldr	r1, .L628+8
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L625:
	mov	r0, r2
	ldr	r3, .L628+12
	movw	r2, #2062
	ldr	r1, .L628+8
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L626:
	mov	r0, r1
	ldr	r3, .L628+16
	movw	r2, #2063
	ldr	r1, .L628+8
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L627:
	mov	r0, r3
	mov	r2, #2064
	ldr	r3, .L628+20
	ldr	r1, .L628+8
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L629:
	.align	2
.L628:
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.word	.LC33
	.word	.LC34
	.word	.LC4
	.fnend
	.size	FSP_GetPmvAddrTab, .-FSP_GetPmvAddrTab
	.align	2
	.global	FSP_GetInstInfo
	.type	FSP_GetInstInfo, %function
FSP_GetInstInfo:
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
	ldr	r3, .L634
	mov	ip, r1
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	beq	.L633
	ldrb	lr, [r3, #10]
	add	r2, r3, #20480
	add	r5, r3, #16384
	ldr	r4, .L634+4
	mov	r0, r1
	add	r1, r3, #20224
	strb	lr, [ip, #1]
	add	r1, r1, #156
	ldr	lr, [r2, #16]
	mov	r2, #3200
	ldr	r5, [r5, #4012]
	rsb	lr, r5, lr
	str	lr, [ip, #3208]
	ldrb	lr, [r3, #11]
	strb	lr, [ip, #2]
	ldrb	lr, [r3, #12]
	strb	lr, [ip, #3]
	ldrb	lr, [r3]
	strb	lr, [ip, #4]
	ldrb	r3, [r3, #13]
	strb	r3, [r0], #8
	ldr	r3, [r4, #52]
	blx	r3
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L633:
	mov	r0, r3
	movw	r2, #2082
	ldr	r3, .L634+8
	ldr	r1, .L634+12
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L635:
	.align	2
.L634:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC4
	.word	.LC1
	.fnend
	.size	FSP_GetInstInfo, .-FSP_GetInstInfo
	.align	2
	.global	FSP_GetLogicIdByPhyAddr
	.type	FSP_GetLogicIdByPhyAddr, %function
FSP_GetLogicIdByPhyAddr:
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
	cmp	r0, #15
	bhi	.L647
	ldr	r3, .L649
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	movne	r3, r0
	movne	r0, #0
	beq	.L648
.L641:
	ldr	r2, [r3, #664]
	add	r3, r3, #632
	cmp	r2, #0
	beq	.L640
	ldr	r2, [r2, #16]
	cmp	r2, r1
	ldmeqfd	sp, {fp, sp, pc}
.L640:
	add	r0, r0, #1
	cmp	r0, #32
	bne	.L641
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L647:
	ldr	r3, .L649+4
	movw	r2, #2105
	ldr	r1, .L649+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L648:
	ldr	r3, .L649+12
	movw	r2, #2106
	ldr	r1, .L649+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L650:
	.align	2
.L649:
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.word	.LC4
	.fnend
	.size	FSP_GetLogicIdByPhyAddr, .-FSP_GetLogicIdByPhyAddr
	.align	2
	.global	FSP_PrintContext
	.type	FSP_PrintContext, %function
FSP_PrintContext:
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
	cmp	r0, #15
	bhi	.L682
	ldr	r3, .L685
	ldr	r7, [r3, r0, asl #2]
	cmp	r7, #0
	beq	.L683
	ldr	r1, .L685+4
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r3, [r7, #4]
	ldr	r2, .L685+8
	mov	r0, #0
	ldr	r1, .L685+12
	mov	r5, r7
	bl	dprint_vfmw
	ldr	r3, [r7, #28]
	ldr	r2, .L685+16
	mov	r0, #0
	ldr	r1, .L685+12
	mov	r6, #1
	bl	dprint_vfmw
	mov	r0, #0
	mov	r4, r0
	ldr	r3, [r7, #32]
	ldr	r2, .L685+20
	ldr	r1, .L685+12
	bl	dprint_vfmw
	ldr	r3, [r7, #44]
	ldr	r2, .L685+24
	mov	r0, r4
	ldr	r1, .L685+12
	bl	dprint_vfmw
	ldr	r3, [r7, #48]
	ldr	r2, .L685+28
	mov	r0, r4
	ldr	r1, .L685+12
	bl	dprint_vfmw
	ldrsb	r3, [r7, #23]
	ldr	r2, .L685+32
	mov	r0, r4
	ldr	r1, .L685+12
	bl	dprint_vfmw
	ldrsb	r3, [r7, #25]
	ldr	r2, .L685+36
	mov	r0, r4
	ldr	r1, .L685+12
	bl	dprint_vfmw
	ldrsb	r3, [r7, #26]
	ldr	r2, .L685+40
	mov	r0, r4
	ldr	r1, .L685+12
	bl	dprint_vfmw
	ldrsb	r3, [r7, #10]
	ldr	r2, .L685+44
	mov	r0, r4
	ldr	r1, .L685+12
	bl	dprint_vfmw
	ldrsb	r3, [r7, #11]
	ldr	r2, .L685+48
	mov	r0, r4
	ldr	r1, .L685+12
	bl	dprint_vfmw
	ldrsb	r3, [r7, #13]
	ldr	r2, .L685+52
	mov	r0, r4
	ldr	r1, .L685+12
	bl	dprint_vfmw
	mov	r2, #32
	ldr	r1, .L685+56
	mov	r0, r4
	bl	dprint_vfmw
	b	.L655
.L657:
	ldrsb	r3, [r5, #57]
	mov	r0, #0
	ldrsb	r2, [r5, #56]
	ldr	r1, .L685+60
	bl	dprint_vfmw
	cmp	r6, #31
	bgt	.L684
.L658:
	add	r4, r4, #1
	add	r6, r6, #1
	add	r5, r5, #632
.L655:
	cmp	r4, #0
	beq	.L656
	ands	r0, r4, #7
	bne	.L657
	ldr	r1, .L685+64
	bl	dprint_vfmw
	b	.L657
.L684:
	ldrsb	r2, [r7, #10]
	mov	r0, #0
	ldr	r1, .L685+68
	bl	dprint_vfmw
	ldrsb	r3, [r7, #10]
	cmp	r3, #0
	addgt	r5, r7, #20224
	movgt	r4, #0
	addgt	r5, r5, #156
	ble	.L665
.L662:
	ldrsb	r3, [r5, #2]
	mov	r0, #0
	ldrsb	r2, [r5]
	add	r4, r4, #1
	ldr	r1, .L685+60
	add	r5, r5, #100
	bl	dprint_vfmw
	ldrsb	r3, [r7, #10]
	cmp	r3, r4
	ble	.L665
	cmp	r4, #0
	beq	.L662
	ands	r0, r4, #7
	bne	.L662
	ldr	r1, .L685+64
	bl	dprint_vfmw
	b	.L662
.L665:
	ldrsb	r2, [r7, #11]
	mov	r0, #0
	ldr	r1, .L685+72
	bl	dprint_vfmw
	ldrsb	r3, [r7, #11]
	cmp	r3, #0
	addgt	r5, r7, #23552
	movgt	r4, #0
	addgt	r5, r5, #28
	ble	.L661
.L668:
	ldrsb	r3, [r5, #2]
	mov	r0, #0
	ldrsb	r2, [r5]
	add	r4, r4, #1
	ldr	r1, .L685+60
	add	r5, r5, #100
	bl	dprint_vfmw
	ldrsb	r3, [r7, #11]
	cmp	r3, r4
	ble	.L661
	cmp	r4, #0
	beq	.L668
	ands	r0, r4, #7
	bne	.L668
	ldr	r1, .L685+64
	bl	dprint_vfmw
	b	.L668
.L661:
	ldrsb	r2, [r7, #13]
	mov	r0, #0
	ldr	r1, .L685+76
	bl	dprint_vfmw
	ldrsb	r3, [r7, #13]
	cmp	r3, #0
	ble	.L666
	mov	r4, #0
.L667:
	mov	r3, r4, asl #3
	ldr	r1, .L685+80
	add	r3, r3, #27136
	mov	r0, #0
	add	r3, r3, #237
	add	r4, r4, #1
	ldrb	r2, [r7, r3]
	bl	dprint_vfmw
	ldrsb	r3, [r7, #13]
	cmp	r3, r4
	ble	.L666
	cmp	r4, #0
	beq	.L667
	ands	r0, r4, #15
	bne	.L667
	ldr	r1, .L685+64
	bl	dprint_vfmw
	b	.L667
.L666:
	ldr	r1, .L685+84
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L682:
	ldr	r3, .L685+88
	movw	r2, #2137
	ldr	r1, .L685+92
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L683:
	mov	r0, r7
	ldr	r3, .L685+96
	movw	r2, #2138
	ldr	r1, .L685+92
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L656:
	ldrsb	r3, [r5, #57]
	mov	r0, r4
	ldrsb	r2, [r5, #56]
	ldr	r1, .L685+60
	bl	dprint_vfmw
	b	.L658
.L686:
	.align	2
.L685:
	.word	.LANCHOR0
	.word	.LC35
	.word	.LC36
	.word	.LC37
	.word	.LC38
	.word	.LC39
	.word	.LC40
	.word	.LC41
	.word	.LC42
	.word	.LC43
	.word	.LC44
	.word	.LC45
	.word	.LC46
	.word	.LC47
	.word	.LC48
	.word	.LC50
	.word	.LC49
	.word	.LC51
	.word	.LC52
	.word	.LC53
	.word	.LC55
	.word	.LC54
	.word	.LC0
	.word	.LC1
	.word	.LC4
	.fnend
	.size	FSP_PrintContext, .-FSP_PrintContext
	.align	2
	.global	FSP_IsRefLeak
	.type	FSP_IsRefLeak, %function
FSP_IsRefLeak:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #16
	sub	sp, sp, #16
	push	{lr}
	bl	__gnu_mcount_nc
	ldrsb	lr, [r0, #10]
	mov	r4, #0
	mov	r6, r0
	mov	r7, r1
	cmp	lr, r4
	str	r4, [fp, #-40]
	str	r4, [fp, #-36]
	str	r4, [fp, #-32]
	ble	.L694
	add	r3, r0, #20224
	mov	r5, r4
	add	r3, r3, #252
	mov	r2, r4
	b	.L691
.L689:
	add	r2, r2, #1
	add	r3, r3, #100
	cmp	r2, lr
	beq	.L688
.L691:
	ldr	ip, [r3]
	cmp	ip, #1
	bne	.L689
	ldrb	r1, [r3, #-96]
	cmp	r1, #1
	addeq	r5, r5, #1
	beq	.L689
	ldrsb	r0, [r3, #-94]
	cmp	r0, #2
	bne	.L689
	cmp	r1, #0
	add	r2, r2, #1
	addeq	r4, r4, #1
	cmp	r2, lr
	add	r3, r3, #100
	bne	.L691
.L688:
	sub	r3, fp, #36
	sub	r2, fp, #32
	sub	r1, fp, #40
	mov	r0, r7
	bl	VCTRL_GetChanImgNum
	ldrsb	r3, [r6, #10]
	ldr	r2, [fp, #-40]
	cmp	r3, r2
	bgt	.L696
	add	r4, r5, r4
	cmp	r3, r4
	ble	.L701
.L696:
	mov	r0, #0
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L701:
	mov	r0, r7
	bl	FSP_PrintContext
	mov	r0, #1
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L694:
	mov	r5, r4
	b	.L688
	.fnend
	.size	FSP_IsRefLeak, .-FSP_IsRefLeak
	.align	2
	.global	FSP_IsNewFsAvalible
	.type	FSP_IsNewFsAvalible, %function
FSP_IsNewFsAvalible:
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
	cmp	r0, #15
	mov	r5, r0
	bhi	.L749
	ldr	r3, .L753
	ldr	r4, [r3, r0, asl #2]
	cmp	r4, #0
	beq	.L750
	ldr	r3, .L753+4
	ldr	r2, [r3, #-3896]
	cmp	r2, #0
	bne	.L706
.L710:
	ldrsb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L751
.L707:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L751:
	mov	r0, r5
	bl	VCTRL_GetVidStd
	cmp	r0, #17
	beq	.L711
	mov	r0, r5
	bl	VCTRL_GetVidStd
	cmp	r0, #16
	beq	.L712
.L715:
	ldrsb	r1, [r4, #10]
	cmp	r1, #0
	addgt	r3, r4, #20224
	movgt	r2, #0
	addgt	r3, r3, #252
	bgt	.L718
	b	.L714
.L716:
	add	r2, r2, #1
	add	r3, r3, #100
	cmp	r2, r1
	beq	.L714
.L718:
	ldr	ip, [r3]
	cmp	ip, #1
	bne	.L716
	ldrsb	r0, [r3, #-96]
	cmp	r0, #0
	bne	.L716
	ldrsb	r0, [r3, #-94]
	cmp	r0, #0
	bne	.L716
	cmp	r1, r2
	ble	.L714
.L723:
	mov	r0, r5
	bl	VCTRL_GetVidStd
	cmp	r0, #17
	beq	.L707
	ldrsb	r0, [r4, #13]
	cmp	r0, #0
	ble	.L731
	add	r3, r4, #27136
	mov	r2, #0
	add	r3, r3, #236
	b	.L727
.L725:
	add	r2, r2, #1
	add	r3, r3, #8
	cmp	r2, r0
	beq	.L728
.L727:
	ldrb	r1, [r3]
	cmp	r1, #1
	bne	.L725
	ldrb	r1, [r3, #1]
	cmp	r1, #0
	bne	.L725
	cmp	r2, r0
	blt	.L707
.L728:
	cmp	r0, r2
	bne	.L714
	mov	r0, r5
	bl	VCTRL_GetVidStd
	cmp	r0, #0
	beq	.L707
	mov	r0, r5
	bl	VCTRL_GetVidStd
	cmp	r0, #16
	beq	.L707
	mov	r0, r5
	bl	VCTRL_GetVidStd
	cmp	r0, #15
	beq	.L707
.L714:
	mov	r0, r5
	bl	FSP_IsFsLeak
	cmp	r0, #1
	movne	r0, #0
	mvneq	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L706:
	ldr	r6, [r3, #-3892]
	cmp	r6, #0
	beq	.L752
	blx	r6
	cmp	r0, #0
	beq	.L710
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L711:
	ldr	r1, .L753+8
	add	r3, r4, #20224
	add	r3, r3, #252
	mov	r2, #0
	ldr	r1, [r1, r5, asl #2]
	add	r1, r1, #528384
	ldr	r0, [r1, #3188]
	b	.L722
.L720:
	add	r2, r2, #1
	add	r3, r3, #100
	cmp	r2, #32
	beq	.L714
.L722:
	ldr	ip, [r3]
	cmp	ip, #1
	bne	.L720
	ldrsb	r1, [r3, #-96]
	cmp	r1, #0
	bne	.L720
	ldrsb	r1, [r3, #-94]
	cmp	r1, #0
	bne	.L720
	ldr	r1, [r3, #-76]
	cmp	r1, r0
	bne	.L720
	cmp	r2, #31
	ble	.L723
	b	.L714
.L712:
	mov	r1, r5
	mov	r0, r4
	bl	FSP_IsRefLeak
	cmp	r0, #0
	beq	.L715
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L749:
	ldr	r3, .L753+12
	movw	r2, #1011
	ldr	r1, .L753+16
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L731:
	mov	r2, #0
	b	.L728
.L750:
	mov	r0, r4
	ldr	r3, .L753+20
	mov	r2, #1012
	ldr	r1, .L753+16
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L752:
	ldr	r1, .L753+24
	mov	r0, r6
	bl	dprint_vfmw
	mov	r0, r6
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L754:
	.align	2
.L753:
	.word	.LANCHOR0
	.word	.LANCHOR1
	.word	s_pstVfmwChan
	.word	.LC0
	.word	.LC1
	.word	.LC4
	.word	.LC5
	.fnend
	.size	FSP_IsNewFsAvalible, .-FSP_IsNewFsAvalible
	.align	2
	.global	FSP_GetQueSwitchFlag
	.type	FSP_GetQueSwitchFlag, %function
FSP_GetQueSwitchFlag:
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
	cmp	r0, #15
	bhi	.L758
	mov	r2, r0, asl #8
	ldr	r3, .L759
	add	r0, r2, r0, lsl #3
	add	r0, r3, r0
	ldrb	r0, [r0, #64]
	ldmfd	sp, {fp, sp, pc}
.L758:
	ldr	r3, .L759+4
	movw	r2, #2226
	ldr	r1, .L759+8
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #255
	ldmfd	sp, {fp, sp, pc}
.L760:
	.align	2
.L759:
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.fnend
	.size	FSP_GetQueSwitchFlag, .-FSP_GetQueSwitchFlag
	.align	2
	.global	FSP_SetQueSwitchFlag
	.type	FSP_SetQueSwitchFlag, %function
FSP_SetQueSwitchFlag:
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
	cmp	r0, #15
	bhi	.L764
	mov	r2, r0, asl #8
	ldr	r3, .L765
	add	r0, r2, r0, lsl #3
	mov	r2, #1
	add	r0, r3, r0
	strb	r2, [r0, #64]
	ldmfd	sp, {fp, sp, pc}
.L764:
	ldr	r3, .L765+4
	movw	r2, #2236
	ldr	r1, .L765+8
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L766:
	.align	2
.L765:
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.fnend
	.size	FSP_SetQueSwitchFlag, .-FSP_SetQueSwitchFlag
	.align	2
	.global	FSP_IsFsInVO
	.type	FSP_IsFsInVO, %function
FSP_IsFsInVO:
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
	ldr	ip, .L781
	ldr	r2, [ip, r0, asl #2]
	cmp	r2, #0
	beq	.L776
	mov	r3, r0, asl #8
	add	r3, r3, r0, lsl #3
	add	r3, ip, r3
	add	r3, r3, #64
	ldrsh	lr, [r3, #2]
	cmn	lr, #1
	beq	.L776
	ldrh	r3, [r3, #4]
	cmp	r3, lr
	beq	.L776
	ldr	r2, [r2, #4]
	cmp	r2, #1
	beq	.L780
.L776:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L780:
	and	r3, r3, #63
	cmp	lr, r3
	beq	.L776
	mov	r4, r0, asl #6
	add	r0, r4, r0, lsl #1
	add	r4, r0, r3
	add	r4, ip, r4, lsl #2
	ldr	r4, [r4, #72]
	cmp	r4, r1
	bne	.L770
	b	.L778
.L771:
	ldr	r2, [r2, #72]
	cmp	r2, r1
	beq	.L778
.L770:
	add	r3, r3, #1
	and	r3, r3, #63
	add	r2, r0, r3
	cmp	lr, r3
	add	r2, ip, r2, lsl #2
	bne	.L771
	b	.L776
.L778:
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L782:
	.align	2
.L781:
	.word	.LANCHOR0
	.fnend
	.size	FSP_IsFsInVO, .-FSP_IsFsInVO
	.align	2
	.global	FSP_ProcFspQue
	.type	FSP_ProcFspQue, %function
FSP_ProcFspQue:
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
	cmp	r1, #0
	beq	.L804
	cmp	r2, #1
	bhi	.L805
	beq	.L806
	mov	r3, r0, asl #8
	mov	r10, r0, asl #3
	ldr	r5, .L807
	add	r9, r10, r3
	str	r3, [fp, #-48]
	add	r9, r5, r9
	ldrh	r7, [r9, #68]
	ldrh	r8, [r9, #70]
	and	r3, r7, #63
	cmp	r8, r3
	beq	.L788
	mov	r6, r0, asl #6
	add	r6, r6, r0, lsl #1
.L793:
	add	r2, r6, r3
	ldr	r0, [r1, #28]
	add	r2, r5, r2, lsl #2
	ldr	r2, [r2, #72]
	cmp	r0, r2
	beq	.L794
	cmp	r2, #0
	movne	ip, r3
	bne	.L790
	mov	lr, #2
.L789:
	mov	ip, r7
.L792:
	cmp	r3, #0
	mov	r4, #63
	subne	r4, r3, #1
	add	r2, r6, r3
	add	r0, r6, r4
	cmp	r3, r7
	add	r2, r5, r2, lsl #2
	mov	r3, r4
	add	r0, r5, r0, lsl #2
	ldr	r0, [r0, #72]
	str	r0, [r2, #72]
	bne	.L792
	cmp	lr, #1
	add	r7, r7, #1
	and	r7, r7, #63
	strh	r7, [r9, #68]
	beq	.L788
.L790:
	add	r3, ip, #1
	and	r3, r3, #63
	cmp	r3, r8
	bne	.L793
.L788:
	ldr	r3, [fp, #-48]
	add	r10, r10, r3
	add	r5, r5, r10
	ldrsh	r2, [r5, #66]
	cmp	r7, r2
	moveq	r1, #0
	mvneq	r2, #0
	streqb	r1, [r5, #64]
	streqh	r2, [r5, #66]
.L783:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L794:
	mov	lr, #1
	b	.L789
.L805:
	ldr	r3, .L807+4
	movw	r2, #2297
	ldr	r1, .L807+8
	mov	r0, #0
	bl	dprint_vfmw
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L806:
	ldr	ip, .L807
	mov	r3, r0, asl #8
	add	r3, r3, r0, lsl #3
	mov	r2, r0, asl #6
	add	r3, ip, r3
	add	r0, r2, r0, lsl #1
	ldr	lr, [r1, #28]
	ldrh	r2, [r3, #70]
	add	r1, r0, r2
	add	r2, r2, #1
	and	r2, r2, #63
	strh	r2, [r3, #70]
	add	r1, ip, r1, lsl #2
	str	lr, [r1, #72]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L804:
	mov	r0, r1
	ldr	r3, .L807+12
	movw	r2, #2296
	ldr	r1, .L807+8
	bl	dprint_vfmw
	b	.L783
.L808:
	.align	2
.L807:
	.word	.LANCHOR0
	.word	.LC57
	.word	.LC1
	.word	.LC56
	.fnend
	.size	FSP_ProcFspQue, .-FSP_ProcFspQue
	.align	2
	.global	FSP_GetNullLogicFs
	.type	FSP_GetNullLogicFs, %function
FSP_GetNullLogicFs:
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
	ldr	r3, .L817
	ldr	ip, [r3, r0, asl #2]
	add	r3, ip, #19456
	ldrsb	r3, [r3, #193]
	cmp	r3, #0
	beq	.L814
	add	r2, ip, #18944
	mov	r3, #30
	add	r2, r2, #73
	b	.L813
.L811:
	subs	r3, r3, #1
	bcc	.L816
.L813:
	ldrsb	r1, [r2]
	sub	r2, r2, #632
	cmp	r1, #0
	bne	.L811
.L812:
	mov	r2, #632
	mov	r0, r3
	mla	r3, r2, r3, ip
	mov	r2, #0
	str	r2, [r3, #664]
	str	r2, [r3, #668]
	ldmfd	sp, {fp, sp, pc}
.L816:
	mov	r3, #0
	b	.L812
.L814:
	mov	r3, #31
	b	.L812
.L818:
	.align	2
.L817:
	.word	.LANCHOR0
	.fnend
	.size	FSP_GetNullLogicFs, .-FSP_GetNullLogicFs
	.align	2
	.global	FSP_SwitchNotify
	.type	FSP_SwitchNotify, %function
FSP_SwitchNotify:
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
	cmp	r0, #15
	ldmlsfd	sp, {fp, sp, pc}
	ldr	r3, .L821
	movw	r2, #2408
	ldr	r1, .L821+4
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L822:
	.align	2
.L821:
	.word	.LC0
	.word	.LC1
	.fnend
	.size	FSP_SwitchNotify, .-FSP_SwitchNotify
	.align	2
	.global	FSP_GetFspType
	.type	FSP_GetFspType, %function
FSP_GetFspType:
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
	cmp	r0, #15
	bhi	.L827
	ldr	r3, .L829
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	beq	.L828
	ldr	r0, [r0, #4]
	subs	r0, r0, #1
	mvnne	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L827:
	ldr	r3, .L829+4
	movw	r2, #2439
	ldr	r1, .L829+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L828:
	ldr	r3, .L829+12
	movw	r2, #2440
	ldr	r1, .L829+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L830:
	.align	2
.L829:
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.word	.LC4
	.fnend
	.size	FSP_GetFspType, .-FSP_GetFspType
	.align	2
	.global	FSP_GetTotalValidFsNum
	.type	FSP_GetTotalValidFsNum, %function
FSP_GetTotalValidFsNum:
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
	cmp	r0, #15
	bhi	.L835
	ldr	r3, .L837
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	beq	.L836
	ldrsb	r0, [r0, #9]
	ldmfd	sp, {fp, sp, pc}
.L835:
	ldr	r3, .L837+4
	movw	r2, #2457
	ldr	r1, .L837+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L836:
	ldr	r3, .L837+12
	movw	r2, #2458
	ldr	r1, .L837+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L838:
	.align	2
.L837:
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.word	.LC4
	.fnend
	.size	FSP_GetTotalValidFsNum, .-FSP_GetTotalValidFsNum
	.global	s_FspVoQue
	.global	s_pFspInst
	.section	.rodata
	.align	2
.LANCHOR2 = . + 0
	.type	__func__.14888, %object
	.size	__func__.14888, 15
__func__.14888:
	.ascii	"FSP_NewLogicFs\000"
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"InstID out of range\000"
.LC1:
	.ascii	"fsp.c,L%d: %s\012\000"
	.space	1
.LC2:
	.ascii	"fsp instance not in used\000"
	.space	3
.LC3:
	.ascii	"pFspInst = NULL\000"
.LC4:
	.ascii	"fsp is not inited\000"
	.space	2
.LC5:
	.ascii	"%s : AllocFrame func null\012\000"
	.space	1
.LC6:
	.ascii	"%s : RleaseFrame func null\012\000"
.LC7:
	.ascii	"pstFspInstCfg = NULL\000"
	.space	3
.LC8:
	.ascii	"This inst is not active\000"
.LC9:
	.ascii	"eChanCapLevel = %d is not expected!\012\000"
	.space	3
.LC10:
	.ascii	"decode channel CapLevel is %d(w=%d,h=%d), this stre"
	.ascii	"am (w=%d,h=%d) can NOT be decoded!\012\000"
	.space	1
.LC11:
	.ascii	"user set decode channel max resolution is (w=%d,h=%"
	.ascii	"d), this stream (w=%d,h=%d) can NOT be decoded!\012"
	.ascii	"\000"
.LC12:
	.ascii	"DFS, Wrong Partition State. State: 0x%x\012\000"
	.space	3
.LC13:
	.ascii	"DFS, Mem Element Fill Successed! Ready to Decode!\012"
	.ascii	"\000"
	.space	1
.LC14:
	.ascii	"Fsp arrange failed, return %d\012\000"
	.space	1
.LC15:
	.ascii	"arrange ret %d, min = %d, actual = %d\012\000"
	.space	1
.LC16:
	.ascii	"PhyAddr is NULL\012\000"
	.space	3
.LC17:
	.ascii	"pFsNum is NULL\012\000"
.LC18:
	.ascii	"FSP_IsFsLeak: fsp is not inited \012\000"
	.space	2
.LC19:
	.ascii	"no logic frame store!!!\012\000"
	.space	3
.LC20:
	.ascii	"%s no decode phy fs\012\000"
	.space	3
.LC21:
	.ascii	"no pmv memory\012\000"
	.space	1
.LC22:
	.ascii	"FSP_AllocFrame failed\012\000"
	.space	1
.LC23:
	.ascii	"invalid stFrameInfo PhyAddr\012\000"
	.space	3
.LC24:
	.ascii	"LogicFrameID out of range\000"
	.space	2
.LC25:
	.ascii	"fsp.c, line %d: pstLogicFs->PmvIdc out of range(=%d"
	.ascii	")\012\000"
	.space	2
.LC26:
	.ascii	"FSP_GetRef: InstID out of range\000"
.LC27:
	.ascii	"FSP_GetRef: LogicFrameID out of range\000"
	.space	2
.LC28:
	.ascii	"FSP_GetRef: Fsp is not inited\000"
	.space	2
.LC29:
	.ascii	"FSP_SetDisplay: LogicTick=%d, DispTick=%d!\012\000"
.LC30:
	.ascii	"pstVoQue is NULL\000"
	.space	3
.LC31:
	.ascii	"DecFsAddrTab is NULL\012\000"
	.space	2
.LC32:
	.ascii	"DecFsNum is NULL\012\000"
	.space	2
.LC33:
	.ascii	"PmvAddrTab is NULL\012\000"
.LC34:
	.ascii	"PmvNum is NULL\012\000"
.LC35:
	.ascii	"FSP CONTEXT:\012\000"
	.space	2
.LC36:
	.ascii	"FspInstState\000"
	.space	3
.LC37:
	.ascii	"%-35s :%d\012\000"
	.space	1
.LC38:
	.ascii	"DecFsWidth\000"
	.space	1
.LC39:
	.ascii	"DecFsHeight\000"
.LC40:
	.ascii	"DispFsWidth\000"
.LC41:
	.ascii	"DispFsHeight\000"
	.space	3
.LC42:
	.ascii	"ExpectedDecFsNum\000"
	.space	3
.LC43:
	.ascii	"ExpectedDispFsNum\000"
	.space	2
.LC44:
	.ascii	"ExpectedPmvNum\000"
	.space	1
.LC45:
	.ascii	"DecFsNum\000"
	.space	3
.LC46:
	.ascii	"DispFsNum\000"
	.space	2
.LC47:
	.ascii	"PmvNum\000"
	.space	1
.LC48:
	.ascii	"logic fs: %d\012\000"
	.space	2
.LC49:
	.ascii	"\012\000"
	.space	2
.LC50:
	.ascii	"%d%d \000"
	.space	2
.LC51:
	.ascii	"\012dec fs: %d\012\000"
	.space	3
.LC52:
	.ascii	"\012disp fs: %d\012\000"
	.space	2
.LC53:
	.ascii	"\012pmv: %d\012\000"
	.space	2
.LC54:
	.ascii	"\012\012\000"
	.space	1
.LC55:
	.ascii	"%d \000"
.LC56:
	.ascii	"p_image NULL\000"
	.space	3
.LC57:
	.ascii	"Flag Invalid\000"
	.bss
	.align	2
.LANCHOR0 = . + 0
.LANCHOR1 = . + 8184
	.type	s_pFspInst, %object
	.size	s_pFspInst, 64
s_pFspInst:
	.space	64
	.type	s_FspVoQue, %object
	.size	s_FspVoQue, 4224
s_FspVoQue:
	.space	4224
	.type	g_IsFrameIntfValid, %object
	.size	g_IsFrameIntfValid, 4
g_IsFrameIntfValid:
	.space	4
	.type	g_FspFrameIntf, %object
	.size	g_FspFrameIntf, 16
g_FspFrameIntf:
	.space	16
	.type	MemArrange.14778, %object
	.size	MemArrange.14778, 1144
MemArrange.14778:
	.space	1144
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
