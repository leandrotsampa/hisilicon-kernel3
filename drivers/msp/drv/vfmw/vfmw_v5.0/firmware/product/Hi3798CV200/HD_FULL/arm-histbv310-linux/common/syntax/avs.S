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
	.file	"avs.c"

	.text
	.align	2
	.global	avs_u_v
	.type	avs_u_v, %function
avs_u_v:
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
	mov	r6, r1
	mov	r5, r2
	bl	BsGet
	str	r6, [sp]
	mov	r2, r5
	ldr	r1, .L2
	mov	r4, r0
	mov	r3, r0
	mov	r0, #7
	bl	dprint_vfmw
	mov	r0, r4
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L3:
	.align	2
.L2:
	.word	.LC0
	.fnend
	.size	avs_u_v, .-avs_u_v
	.align	2
	.global	avs_f_v
	.type	avs_f_v, %function
avs_f_v:
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
	mov	r6, r1
	mov	r5, r2
	bl	BsGet
	str	r6, [sp]
	mov	r2, r5
	ldr	r1, .L5
	mov	r4, r0
	mov	r3, r0
	mov	r0, #7
	bl	dprint_vfmw
	mov	r0, r4
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L6:
	.align	2
.L5:
	.word	.LC0
	.fnend
	.size	avs_f_v, .-avs_f_v
	.align	2
	.global	avs_ue_v
	.type	avs_ue_v, %function
avs_ue_v:
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
	mov	r6, r1
	mov	r1, #32
	mov	r7, r0
	bl	BsShow
	bl	ZerosMS_32
	cmp	r0, #31
	mov	r4, r0
	mvnhi	r5, #0
	movhi	r4, #32
	bls	.L11
.L8:
	str	r4, [sp]
	mov	r2, r6
	mov	r3, r5
	ldr	r1, .L12
	mov	r0, #7
	bl	dprint_vfmw
	mov	r0, r5
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L11:
	add	r5, r4, #1
	mov	r1, r4
	mov	r0, r7
	mov	r4, r4, asl #1
	bl	BsSkip
	mov	r1, r5
	mov	r0, r7
	add	r4, r4, #1
	bl	BsShow
	mov	r1, r5
	sub	r5, r0, #1
	mov	r0, r7
	bl	BsSkip
	b	.L8
.L13:
	.align	2
.L12:
	.word	.LC0
	.fnend
	.size	avs_ue_v, .-avs_ue_v
	.align	2
	.global	avs_se_v
	.type	avs_se_v, %function
avs_se_v:
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
	mov	r1, #32
	mov	r7, r0
	bl	BsShow
	bl	ZerosMS_32
	cmp	r0, #31
	mov	r4, r0
	mvnhi	r5, #-2147483648
	movhi	r4, #32
	bls	.L19
.L15:
	str	r4, [sp]
	mov	r2, r6
	mov	r3, r5
	ldr	r1, .L20
	mov	r0, #7
	bl	dprint_vfmw
	mov	r0, r5
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L19:
	add	r8, r4, #1
	mov	r1, r4
	mov	r0, r7
	mov	r4, r4, asl #1
	bl	BsSkip
	mov	r1, r8
	mov	r0, r7
	add	r4, r4, #1
	bl	BsShow
	mov	r1, r8
	sub	r0, r0, #1
	tst	r0, #1
	mov	r5, r0, asr #1
	mov	r0, r7
	addne	r5, r5, #1
	rsbeq	r5, r5, #0
	bl	BsSkip
	b	.L15
.L21:
	.align	2
.L20:
	.word	.LC0
	.fnend
	.size	avs_se_v, .-avs_se_v
	.align	2
	.global	AVS_next_start_code
	.type	AVS_next_start_code, %function
AVS_next_start_code:
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
	bgt	.L25
	b	.L26
.L31:
	bl	BsSkip
	cmp	r4, r6
	beq	.L26
.L25:
	mov	r1, #24
	mov	r0, r5
	bl	BsShow
	add	r4, r4, #1
	mov	r1, #8
	mov	r3, r0
	cmp	r3, #1
	mov	r0, r5
	bne	.L31
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L26:
	mov	r3, #0
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	AVS_next_start_code, .-AVS_next_start_code
	.align	2
	.global	AVS_sequence_header
	.type	AVS_sequence_header, %function
AVS_sequence_header:
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
	add	r6, r0, #12288
	mov	r4, r1
	ldr	r2, .L40
	mov	r1, #32
	ldr	r5, [r6, #3120]
	mov	r7, r0
	ldr	r3, [r6, #2732]
	mov	r0, r5
	bic	r3, r3, #65536
	str	r3, [r6, #2732]
	bl	avs_f_v
	ldr	r2, .L40+4
	mov	r1, #8
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L40+8
	mov	r1, #8
	str	r0, [r4, #16]
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L40+12
	mov	r1, #1
	str	r0, [r4, #20]
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L40+16
	mov	r1, #14
	strb	r0, [r4, #15]
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L40+20
	mov	r1, #14
	str	r0, [r4, #24]
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L40+24
	mov	r1, #2
	str	r0, [r4, #28]
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L40+28
	mov	r1, #3
	strb	r0, [r4, #11]
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L40+32
	mov	r1, #4
	strb	r0, [r4, #12]
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L40+36
	mov	r1, #4
	strb	r0, [r4, #13]
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L40+40
	mov	r1, #18
	strb	r0, [r4, #14]
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L40+44
	mov	r1, #1
	str	r0, [r4, #32]
	mov	r0, r5
	bl	avs_f_v
	ldr	r2, .L40+48
	mov	r1, #12
	strb	r0, [r4, #10]
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L40+52
	mov	r1, #1
	str	r0, [r4, #36]
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L40+44
	mov	r1, #1
	strb	r0, [r4, #9]
	mov	r0, r5
	bl	avs_f_v
	ldr	r2, .L40+56
	mov	r1, #18
	strb	r0, [r4, #10]
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L40+60
	mov	r1, #3
	str	r0, [r4, #40]
	mov	r0, r5
	bl	avs_u_v
	ldr	r3, [r4, #24]
	strb	r0, [r4, #8]
	ldr	r0, [r6, #2772]
	cmp	r3, r0
	beq	.L39
.L33:
	ldr	r3, .L40+64
	mov	r2, #1
	str	r2, [r6, #2744]
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L34
	ldr	r8, [r6, #2776]
	mov	r3, #8
	ldr	r5, [r4, #24]
	sub	r2, fp, #44
	ldr	lr, [r4, #28]
	mov	r1, #2
	strh	r0, [fp, #-44]
	strh	r8, [fp, #-42]
	ldr	r0, [r7, #4]
	strh	r5, [fp, #-40]
	strh	lr, [fp, #-38]
	blx	ip
.L34:
	add	r0, r6, #2736
	mov	r1, r4
	mov	r2, #372
	add	r0, r0, #12
	bl	memcpy
	ldr	r2, [r6, #2740]
	ldr	r3, [r6, #2732]
	mov	r0, #1
	add	r2, r2, r0
	str	r0, [r6, #2736]
	orr	r3, r3, #65536
	str	r2, [r6, #2740]
	str	r3, [r6, #2732]
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L39:
	ldr	r2, [r4, #28]
	ldr	r3, [r6, #2776]
	cmp	r2, r3
	bne	.L33
	b	.L34
.L41:
	.align	2
.L40:
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	.LC11
	.word	.LC12
	.word	.LC13
	.word	.LC14
	.word	.LC15
	.word	.LC16
	.word	g_event_report
	.fnend
	.size	AVS_sequence_header, .-AVS_sequence_header
	.align	2
	.global	AVS_i_picture_header
	.type	AVS_i_picture_header, %function
AVS_i_picture_header:
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
	ldr	r3, .L81
	ldr	r5, [r0, #492]
	mov	r6, r0
	mov	r4, r1
	add	r0, r1, #76
	mov	r2, #272
	ldr	r3, [r3, #48]
	mov	r1, #0
	blx	r3
	ldr	r3, [r6, #104]
	ldr	r2, .L81+4
	mov	r1, #32
	bic	r3, r3, #262144
	mov	r0, r5
	str	r3, [r6, #104]
	bl	avs_f_v
	mov	r0, r5
	ldr	r2, .L81+8
	mov	r1, #16
	bl	avs_u_v
	ldr	r3, [r4, #16]
	cmp	r3, #72
	str	r0, [r4, #92]
	beq	.L73
.L43:
	ldr	r2, .L81+12
	mov	r1, #1
	mov	r0, r5
	bl	avs_u_v
	uxtb	r0, r0
	strb	r0, [r4, #86]
	cmp	r0, #1
	beq	.L74
.L44:
	ldr	r2, .L81+16
	mov	r1, #1
	mov	r0, r5
	bl	avs_f_v
	ldr	r2, .L81+20
	mov	r1, #8
	str	r0, [r4, #104]
	mov	r0, r5
	bl	avs_u_v
	ldrb	r3, [r4, #9]
	cmp	r3, #1
	str	r0, [r4, #108]
	beq	.L75
.L45:
	ldr	r2, .L81+24
	mov	r1, #1
	mov	r0, r5
	bl	avs_u_v
	ldrb	r3, [r4, #15]
	cmp	r3, #1
	uxtb	r0, r0
	strb	r0, [r4, #76]
	streqb	r3, [r4, #76]
	beq	.L47
	cmp	r0, #0
	beq	.L76
.L47:
	mov	r3, #1
	strb	r3, [r4, #77]
.L48:
	ldr	r2, .L81+28
	mov	r1, #1
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L81+32
	mov	r1, #1
	strb	r0, [r4, #78]
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L81+36
	mov	r1, #1
	strb	r0, [r4, #79]
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L81+40
	mov	r1, #6
	strb	r0, [r4, #80]
	mov	r0, r5
	bl	avs_u_v
	ldrh	r3, [r4, #76]
	cmp	r3, #0
	strb	r0, [r4, #81]
	beq	.L77
.L49:
	ldr	r2, .L81+44
	mov	r1, #4
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L81+48
	mov	r1, #1
	strb	r0, [r4, #83]
	mov	r0, r5
	bl	avs_u_v
	mov	r3, #0
	str	r3, [r4, #116]
	str	r3, [r4, #120]
	uxtb	r0, r0
	strb	r0, [r4, #84]
	cmp	r0, r3
	beq	.L78
.L51:
	ldr	r3, [r4, #16]
	cmp	r3, #72
	beq	.L79
.L53:
	mov	r0, #1
	mov	r3, #0
	strb	r0, [r4, #89]
	str	r3, [r4, #344]
	ldr	r3, [r6, #104]
	orr	r3, r3, #262144
	str	r3, [r6, #104]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L76:
	ldr	r2, .L81+52
	mov	r1, #1
	mov	r0, r5
	bl	avs_u_v
	strb	r0, [r4, #77]
	b	.L48
.L78:
	ldr	r2, .L81+56
	mov	r1, #1
	mov	r0, r5
	bl	avs_u_v
	uxtb	r0, r0
	strb	r0, [r4, #85]
	cmp	r0, #0
	beq	.L51
	ldr	r1, .L81+60
	mov	r0, r5
	bl	avs_se_v
	ldr	r1, .L81+64
	str	r0, [r4, #116]
	mov	r0, r5
	bl	avs_se_v
	str	r0, [r4, #120]
	b	.L51
.L77:
	ldr	r2, .L81+68
	mov	r1, #1
	mov	r0, r5
	bl	avs_u_v
	strb	r0, [r4, #82]
	b	.L49
.L79:
	ldr	r2, .L81+72
	mov	r1, #1
	mov	r0, r5
	bl	avs_u_v
	cmp	r0, #0
	str	r0, [r4, #124]
	bne	.L54
.L63:
	mov	r0, r5
	ldr	r2, .L81+76
	mov	r1, #1
	bl	avs_u_v
	str	r0, [r4, #328]
	b	.L53
.L73:
	ldr	r2, .L81+16
	mov	r1, #1
	mov	r0, r5
	bl	avs_f_v
	ldr	r2, .L81+80
	mov	r1, #7
	str	r0, [r4, #104]
	mov	r0, r5
	bl	avs_u_v
	ldr	r3, [r4, #92]
	mov	r2, #1
	strb	r2, [r4]
	str	r0, [r4, #96]
	orr	r0, r0, r3, asl #7
	str	r0, [r4, #92]
	b	.L43
.L74:
	ldr	r2, .L81+84
	mov	r1, #24
	mov	r0, r5
	bl	avs_u_v
	str	r0, [r4, #100]
	b	.L44
.L75:
	ldr	r1, .L81+88
	mov	r0, r5
	bl	avs_ue_v
	str	r0, [r4, #112]
	b	.L45
.L54:
	ldr	r2, .L81+92
	mov	r1, #1
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L81+96
	mov	r1, #1
	str	r0, [r4, #128]
	mov	r0, r5
	bl	avs_u_v
	cmp	r0, #0
	str	r0, [r4, #132]
	beq	.L80
.L55:
	ldr	r2, .L81+100
	mov	r1, #2
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L81+104
	mov	r1, #2
	str	r0, [r4, #144]
	mov	r0, r5
	bl	avs_u_v
	ldr	r3, [r4, #144]
	cmp	r3, #1
	str	r0, [r4, #148]
	beq	.L58
	ldr	r2, [r4, #128]
	cmp	r2, #0
	cmpeq	r3, #3
	beq	.L58
	cmp	r3, #2
	addeq	r7, r4, #172
	bne	.L63
.L62:
	add	r8, r4, #196
.L61:
	ldr	r1, .L81+108
	mov	r0, r5
	bl	avs_se_v
	str	r0, [r7, #4]!
	cmp	r7, r8
	bne	.L61
	b	.L63
.L80:
	ldr	r1, .L81+112
	mov	r0, r5
	bl	avs_se_v
	ldr	r1, .L81+116
	str	r0, [r4, #136]
	mov	r0, r5
	bl	avs_se_v
	str	r0, [r4, #140]
	b	.L55
.L58:
	add	r8, r4, #148
	add	r7, r4, #172
.L57:
	ldr	r1, .L81+120
	mov	r0, r5
	bl	avs_se_v
	str	r0, [r8, #4]!
	cmp	r8, r7
	bne	.L57
	ldr	r3, [r4, #144]
	cmp	r3, #2
	beq	.L62
	ldr	r2, [r4, #128]
	cmp	r2, #0
	cmpeq	r3, #3
	bne	.L63
	b	.L62
.L82:
	.align	2
.L81:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC17
	.word	.LC18
	.word	.LC20
	.word	.LC12
	.word	.LC22
	.word	.LC24
	.word	.LC26
	.word	.LC27
	.word	.LC28
	.word	.LC29
	.word	.LC16
	.word	.LC31
	.word	.LC25
	.word	.LC32
	.word	.LC33
	.word	.LC34
	.word	.LC30
	.word	.LC35
	.word	.LC36
	.word	.LC19
	.word	.LC21
	.word	.LC23
	.word	.LC37
	.word	.LC38
	.word	.LC41
	.word	.LC42
	.word	.LC44
	.word	.LC39
	.word	.LC40
	.word	.LC43
	.fnend
	.size	AVS_i_picture_header, .-AVS_i_picture_header
	.align	2
	.global	AVS_pb_picture_header
	.type	AVS_pb_picture_header, %function
AVS_pb_picture_header:
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
	ldr	r3, .L135
	ldr	r5, [r0, #492]
	mov	r6, r0
	mov	r4, r1
	add	r0, r1, #76
	mov	r2, #272
	ldr	r3, [r3, #48]
	mov	r1, #0
	blx	r3
	ldr	r3, [r6, #104]
	ldr	r2, .L135+4
	mov	r1, #32
	bic	r3, r3, #262144
	mov	r0, r5
	str	r3, [r6, #104]
	bl	avs_f_v
	mov	r0, r5
	ldr	r2, .L135+8
	mov	r1, #16
	bl	avs_u_v
	ldr	r3, [r4, #16]
	cmp	r3, #72
	str	r0, [r4, #92]
	beq	.L127
.L84:
	ldr	r2, .L135+12
	mov	r1, #2
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L135+16
	mov	r1, #8
	strb	r0, [r4, #87]
	mov	r0, r5
	bl	avs_u_v
	ldrb	r3, [r4, #9]
	cmp	r3, #1
	str	r0, [r4, #108]
	beq	.L128
.L85:
	ldr	r2, .L135+20
	mov	r1, #1
	mov	r0, r5
	bl	avs_u_v
	uxtb	r0, r0
	strb	r0, [r4, #76]
	cmp	r0, #0
	movne	r3, #1
	strneb	r3, [r4, #77]
	beq	.L129
.L87:
	ldr	r2, .L135+24
	mov	r1, #1
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L135+28
	mov	r1, #1
	strb	r0, [r4, #78]
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L135+32
	mov	r1, #1
	strb	r0, [r4, #79]
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L135+36
	mov	r1, #6
	strb	r0, [r4, #80]
	mov	r0, r5
	bl	avs_u_v
	ldrb	r3, [r4, #87]
	cmp	r3, #2
	strb	r0, [r4, #81]
	beq	.L130
.L88:
	ldr	r2, .L135+40
	mov	r1, #1
	mov	r0, r5
	bl	avs_u_v
	strb	r0, [r4, #89]
.L90:
	ldr	r2, .L135+44
	mov	r1, #1
	mov	r0, r5
	bl	avs_u_v
	ldrb	r2, [r4, #87]
	mov	r3, #0
	str	r3, [r4, #336]
	cmp	r2, #2
	str	r3, [r4, #340]
	strb	r0, [r4, #90]
	beq	.L131
	ldr	r2, .L135+48
	mov	r1, #1
	mov	r0, r5
	bl	avs_u_v
	str	r0, [r4, #336]
.L92:
	ldrb	r3, [r4, #77]
	cmp	r3, #1
	beq	.L93
	ldr	r3, [r4, #16]
	cmp	r3, #72
	beq	.L94
.L93:
	mov	r3, #0
	str	r3, [r4, #336]
	str	r3, [r4, #340]
.L94:
	ldr	r2, .L135+52
	mov	r1, #2
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L135+56
	mov	r1, #1
	strb	r0, [r4, #83]
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L135+60
	mov	r1, #1
	strb	r0, [r4, #82]
	mov	r0, r5
	bl	avs_u_v
	mov	r3, #0
	str	r3, [r4, #116]
	str	r3, [r4, #120]
	uxtb	r0, r0
	strb	r0, [r4, #84]
	cmp	r0, r3
	beq	.L132
.L96:
	ldr	r3, [r4, #16]
	cmp	r3, #72
	beq	.L133
.L98:
	ldrb	r3, [r4, #87]
	mov	r0, #1
	cmp	r3, #1
	movne	r3, #2
	str	r3, [r4, #344]
	ldr	r3, [r6, #104]
	orr	r3, r3, #262144
	str	r3, [r6, #104]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L130:
	ldrb	r3, [r4, #77]
	cmp	r3, #1
	streqb	r3, [r4, #89]
	bne	.L88
	b	.L90
.L129:
	ldr	r2, .L135+64
	mov	r1, #1
	mov	r0, r5
	bl	avs_u_v
	uxtb	r0, r0
	strb	r0, [r4, #77]
	cmp	r0, #0
	bne	.L87
	ldr	r2, .L135+68
	mov	r1, #1
	mov	r0, r5
	bl	avs_u_v
	strb	r0, [r4, #88]
	b	.L87
.L132:
	ldr	r2, .L135+72
	mov	r1, #1
	mov	r0, r5
	bl	avs_u_v
	uxtb	r0, r0
	strb	r0, [r4, #85]
	cmp	r0, #0
	beq	.L96
	ldr	r1, .L135+76
	mov	r0, r5
	bl	avs_se_v
	ldr	r1, .L135+80
	str	r0, [r4, #116]
	mov	r0, r5
	bl	avs_se_v
	str	r0, [r4, #120]
	b	.L96
.L131:
	ldr	r2, .L135+84
	mov	r1, #1
	mov	r0, r5
	bl	avs_u_v
	str	r0, [r4, #340]
	b	.L92
.L133:
	ldr	r2, .L135+88
	mov	r1, #1
	mov	r0, r5
	bl	avs_u_v
	cmp	r0, #1
	mov	r7, r0
	str	r0, [r4, #124]
	beq	.L99
.L108:
	mov	r0, r5
	ldr	r2, .L135+92
	mov	r1, #1
	bl	avs_u_v
	str	r0, [r4, #328]
	b	.L98
.L127:
	ldr	r2, .L135+96
	mov	r1, #1
	mov	r0, r5
	bl	avs_f_v
	ldr	r2, .L135+100
	mov	r1, #7
	str	r0, [r4, #104]
	mov	r0, r5
	bl	avs_u_v
	ldr	r3, [r4, #92]
	mov	r2, #1
	strb	r2, [r4]
	str	r0, [r4, #96]
	orr	r0, r0, r3, asl #7
	str	r0, [r4, #92]
	b	.L84
.L128:
	ldr	r1, .L135+104
	mov	r0, r5
	bl	avs_ue_v
	str	r0, [r4, #112]
	b	.L85
.L99:
	mov	r1, r0
	ldr	r2, .L135+108
	mov	r0, r5
	bl	avs_u_v
	mov	r1, r7
	ldr	r2, .L135+112
	str	r0, [r4, #128]
	mov	r0, r5
	bl	avs_u_v
	cmp	r0, #0
	str	r0, [r4, #132]
	beq	.L134
.L100:
	ldr	r2, .L135+116
	mov	r1, #2
	mov	r0, r5
	bl	avs_u_v
	ldr	r2, .L135+120
	mov	r1, #2
	str	r0, [r4, #144]
	mov	r0, r5
	bl	avs_u_v
	ldr	r3, [r4, #144]
	cmp	r3, #1
	str	r0, [r4, #148]
	beq	.L103
	ldr	r2, [r4, #128]
	cmp	r2, #0
	cmpeq	r3, #3
	beq	.L103
	cmp	r3, #2
	addeq	r7, r4, #172
	bne	.L108
.L107:
	add	r8, r4, #196
.L106:
	ldr	r1, .L135+124
	mov	r0, r5
	bl	avs_se_v
	str	r0, [r7, #4]!
	cmp	r7, r8
	bne	.L106
	b	.L108
.L103:
	add	r8, r4, #148
	add	r7, r4, #172
.L102:
	ldr	r1, .L135+128
	mov	r0, r5
	bl	avs_se_v
	str	r0, [r8, #4]!
	cmp	r8, r7
	bne	.L102
	ldr	r3, [r4, #144]
	cmp	r3, #2
	beq	.L107
	ldr	r2, [r4, #128]
	cmp	r2, #0
	cmpeq	r3, #3
	bne	.L108
	b	.L107
.L134:
	ldr	r1, .L135+132
	mov	r0, r5
	bl	avs_se_v
	ldr	r1, .L135+136
	str	r0, [r4, #136]
	mov	r0, r5
	bl	avs_se_v
	str	r0, [r4, #140]
	b	.L100
.L136:
	.align	2
.L135:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC45
	.word	.LC18
	.word	.LC46
	.word	.LC22
	.word	.LC24
	.word	.LC26
	.word	.LC27
	.word	.LC28
	.word	.LC29
	.word	.LC48
	.word	.LC49
	.word	.LC51
	.word	.LC16
	.word	.LC30
	.word	.LC31
	.word	.LC25
	.word	.LC47
	.word	.LC32
	.word	.LC33
	.word	.LC34
	.word	.LC50
	.word	.LC35
	.word	.LC36
	.word	.LC12
	.word	.LC19
	.word	.LC23
	.word	.LC37
	.word	.LC38
	.word	.LC41
	.word	.LC42
	.word	.LC44
	.word	.LC43
	.word	.LC39
	.word	.LC40
	.fnend
	.size	AVS_pb_picture_header, .-AVS_pb_picture_header
	.align	2
	.global	AVS_user_data
	.type	AVS_user_data, %function
AVS_user_data:
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
	add	r4, r0, #12288
	mov	r6, r1
	mov	r5, r0
	ldr	r2, .L170
	mov	r1, #32
	ldr	r0, [r4, #3120]
	bl	avs_f_v
	ldr	r3, [r4, #2732]
	cmp	r6, #0
	orr	r3, r3, #1048576
	str	r3, [r4, #2732]
	bne	.L138
	ldr	r1, [r4, #3412]
	cmp	r1, #0
	beq	.L139
	ldr	r0, [r5, #4]
	bl	FreeUsdByDec
	str	r6, [r4, #3412]
.L139:
	ldr	r0, [r5, #4]
	bl	GetUsd
	cmp	r0, #0
	str	r0, [r4, #3412]
	beq	.L149
	ldr	r3, [r5, #12]
	add	r0, r0, #1056
	mov	r1, #9
	add	r6, r5, #16384
	ldr	r7, .L170+4
	ldrd	r2, [r3, #56]
	strd	r2, [r0]
	ldr	r3, [r4, #3412]
	str	r1, [r3, #1040]
	ldr	r3, [r4, #3412]
	ldr	r2, [r4, #2740]
	str	r2, [r3, #1044]
	ldr	r2, [r4, #3412]
	ldr	r3, [r6, #116]
	sub	r3, r3, #4
	str	r3, [r2, #1052]
	ldr	r0, [r4, #3412]
	ldr	r2, [r0, #1052]
	cmp	r2, #1024
	movgt	r3, #1024
	strgt	r3, [r0, #1052]
	ldrgt	r0, [r4, #3412]
	ldr	r1, [r6, #104]
	ldr	r3, [r7, #52]
	ldrgt	r2, [r0, #1052]
	add	r1, r1, #4
	blx	r3
	ldrb	r3, [r6, #109]
	cmp	r3, #0
	bne	.L144
	ldr	r2, [r4, #3412]
	ldr	r1, [r6, #196]
	ldr	r3, [r2, #1052]
	add	r3, r3, r1
	str	r3, [r2, #1052]
	ldr	r1, [r4, #3412]
	ldr	r2, [r1, #1052]
	cmp	r2, #1024
	movgt	r3, #1024
	strgt	r3, [r1, #1052]
	ldrgt	r1, [r4, #3412]
	ldr	r0, [r6, #116]
	ldrgt	r2, [r1, #1052]
	rsb	r3, r0, #4
	add	r2, r3, r2
	cmp	r2, #0
	ble	.L144
	sub	r0, r0, #4
	ldr	r3, [r7, #52]
	add	r0, r1, r0
	ldr	r1, [r6, #184]
	blx	r3
.L144:
	ldr	r3, .L170+8
	ldr	ip, [r3]
	cmp	ip, #0
	ldrne	r2, [r4, #3412]
	bne	.L169
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L138:
	ldr	r1, [r4, #3416]
	cmp	r1, #0
	beq	.L148
	ldr	r0, [r5, #4]
	bl	FreeUsdByDec
	mov	r3, #0
	str	r3, [r4, #3416]
.L148:
	ldr	r0, [r5, #4]
	bl	GetUsd
	cmp	r0, #0
	str	r0, [r4, #3416]
	beq	.L149
	ldr	r3, [r5, #12]
	add	r0, r0, #1056
	mov	r1, #10
	add	r6, r5, #16384
	ldr	r7, .L170+4
	ldrd	r2, [r3, #56]
	strd	r2, [r0]
	ldr	r3, [r4, #3416]
	str	r1, [r3, #1040]
	ldr	r3, [r4, #3416]
	ldr	r2, [r4, #2740]
	str	r2, [r3, #1044]
	ldr	r2, [r4, #3416]
	ldr	r3, [r6, #116]
	sub	r3, r3, #4
	str	r3, [r2, #1052]
	ldr	r0, [r4, #3416]
	ldr	r2, [r0, #1052]
	cmp	r2, #1024
	movgt	r3, #1024
	strgt	r3, [r0, #1052]
	ldrgt	r0, [r4, #3416]
	ldr	r1, [r6, #104]
	ldr	r3, [r7, #52]
	ldrgt	r2, [r0, #1052]
	add	r1, r1, #4
	blx	r3
	ldrb	r3, [r6, #109]
	cmp	r3, #0
	bne	.L152
	ldr	r2, [r4, #3416]
	ldr	r1, [r6, #196]
	ldr	r3, [r2, #1052]
	add	r3, r3, r1
	str	r3, [r2, #1052]
	ldr	r1, [r4, #3416]
	ldr	r2, [r1, #1052]
	cmp	r2, #1024
	movgt	r3, #1024
	strgt	r3, [r1, #1052]
	ldrgt	r1, [r4, #3416]
	ldr	r0, [r6, #116]
	ldrgt	r2, [r1, #1052]
	rsb	r3, r0, #4
	add	r2, r3, r2
	cmp	r2, #0
	ble	.L152
	sub	r0, r0, #4
	ldr	r3, [r7, #52]
	add	r0, r1, r0
	ldr	r1, [r6, #184]
	blx	r3
.L152:
	ldr	r3, .L170+8
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L168
	ldr	r2, [r4, #3416]
.L169:
	movw	r3, #1064
	ldr	r0, [r5, #4]
	mov	r1, #6
	blx	ip
.L168:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L149:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L171:
	.align	2
.L170:
	.word	.LC52
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_event_report
	.fnend
	.size	AVS_user_data, .-AVS_user_data
	.align	2
	.global	AVS_sequence_display_extension
	.type	AVS_sequence_display_extension, %function
AVS_sequence_display_extension:
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
	ldr	r4, [r0, #492]
	mov	r5, r1
	ldr	r2, .L175
	mov	r1, #4
	mov	r6, r0
	mov	r0, r4
	bl	avs_u_v
	ldr	r2, .L175+4
	mov	r1, #3
	mov	r0, r4
	bl	avs_u_v
	ldr	r2, .L175+8
	mov	r1, #1
	strb	r0, [r5, #46]
	mov	r0, r4
	bl	avs_u_v
	ldr	r2, .L175+12
	mov	r1, #1
	strb	r0, [r5, #47]
	mov	r0, r4
	bl	avs_u_v
	uxtb	r0, r0
	strb	r0, [r5, #48]
	cmp	r0, #1
	beq	.L174
.L173:
	ldr	r2, .L175+16
	mov	r1, #14
	mov	r0, r4
	bl	avs_u_v
	ldr	r2, .L175+20
	mov	r1, #1
	str	r0, [r5, #64]
	mov	r0, r4
	bl	avs_f_v
	ldr	r2, .L175+24
	mov	r1, #14
	strb	r0, [r5, #45]
	mov	r0, r4
	bl	avs_u_v
	ldr	r2, .L175+28
	mov	r1, #2
	str	r0, [r5, #68]
	mov	r0, r4
	bl	avs_u_v
	strb	r0, [r5, #44]
	mov	r0, r4
	bl	AVS_next_start_code
	ldr	r3, [r6, #104]
	mov	r0, #1
	orr	r3, r3, #131072
	str	r3, [r6, #104]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L174:
	ldr	r2, .L175+32
	mov	r1, #8
	mov	r0, r4
	bl	avs_u_v
	ldr	r2, .L175+36
	mov	r1, #8
	str	r0, [r5, #52]
	mov	r0, r4
	bl	avs_u_v
	ldr	r2, .L175+40
	mov	r1, #8
	str	r0, [r5, #56]
	mov	r0, r4
	bl	avs_u_v
	str	r0, [r5, #60]
	b	.L173
.L176:
	.align	2
.L175:
	.word	.LC53
	.word	.LC54
	.word	.LC55
	.word	.LC56
	.word	.LC60
	.word	.LC12
	.word	.LC61
	.word	.LC16
	.word	.LC57
	.word	.LC58
	.word	.LC59
	.fnend
	.size	AVS_sequence_display_extension, .-AVS_sequence_display_extension
	.align	2
	.global	AVS_copyright_extension
	.type	AVS_copyright_extension, %function
AVS_copyright_extension:
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
	ldr	r4, [r0, #492]
	mov	r5, r0
	ldr	r2, .L178
	mov	r1, #4
	ldr	r6, .L178+4
	mov	r0, r4
	bl	avs_u_v
	mov	r0, r4
	ldr	r2, .L178+8
	mov	r1, #1
	bl	avs_u_v
	mov	r0, r4
	ldr	r2, .L178+12
	mov	r1, #8
	bl	avs_u_v
	mov	r0, r4
	ldr	r2, .L178+16
	mov	r1, #1
	bl	avs_u_v
	mov	r0, r4
	ldr	r2, .L178+20
	mov	r1, #7
	bl	avs_u_v
	mov	r2, r6
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r0, r4
	ldr	r2, .L178+24
	mov	r1, #20
	bl	avs_u_v
	mov	r2, r6
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r0, r4
	ldr	r2, .L178+28
	mov	r1, #22
	bl	avs_u_v
	mov	r2, r6
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	ldr	r2, .L178+32
	mov	r1, #22
	mov	r0, r4
	bl	avs_u_v
	mov	r0, r4
	bl	AVS_next_start_code
	ldr	r3, [r5, #104]
	mov	r0, #1
	orr	r3, r3, #2097152
	str	r3, [r5, #104]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L179:
	.align	2
.L178:
	.word	.LC53
	.word	.LC12
	.word	.LC62
	.word	.LC63
	.word	.LC64
	.word	.LC16
	.word	.LC65
	.word	.LC66
	.word	.LC67
	.fnend
	.size	AVS_copyright_extension, .-AVS_copyright_extension
	.align	2
	.global	AVS_camera_parameters_extension
	.type	AVS_camera_parameters_extension, %function
AVS_camera_parameters_extension:
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
	ldr	r4, [r0, #492]
	ldr	r7, .L181
	mov	r6, r0
	ldr	r5, .L181+4
	mov	r1, #4
	ldr	r2, .L181+8
	mov	r0, r4
	bl	avs_u_v
	mov	r2, r7
	mov	r0, r4
	mov	r1, #1
	bl	avs_u_v
	mov	r0, r4
	ldr	r2, .L181+12
	mov	r1, #7
	bl	avs_u_v
	mov	r2, r5
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r0, r4
	ldr	r2, .L181+16
	mov	r1, #22
	bl	avs_u_v
	mov	r2, r5
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r0, r4
	ldr	r2, .L181+20
	mov	r1, #22
	bl	avs_u_v
	mov	r2, r5
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r0, r4
	ldr	r2, .L181+24
	mov	r1, #22
	bl	avs_u_v
	mov	r2, r5
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r0, r4
	ldr	r2, .L181+28
	mov	r1, #22
	bl	avs_u_v
	mov	r2, r5
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r0, r4
	ldr	r2, .L181+32
	mov	r1, #16
	bl	avs_u_v
	mov	r2, r5
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r0, r4
	ldr	r2, .L181+36
	mov	r1, #16
	bl	avs_u_v
	mov	r2, r5
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r0, r4
	ldr	r2, .L181+40
	mov	r1, #16
	bl	avs_u_v
	mov	r2, r5
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r0, r4
	ldr	r2, .L181+44
	mov	r1, #16
	bl	avs_u_v
	mov	r2, r5
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r0, r4
	ldr	r2, .L181+48
	mov	r1, #16
	bl	avs_u_v
	mov	r2, r5
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r0, r4
	ldr	r2, .L181+52
	mov	r1, #16
	bl	avs_u_v
	mov	r2, r5
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r0, r4
	ldr	r2, .L181+56
	mov	r1, #22
	bl	avs_u_v
	mov	r2, r5
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r0, r4
	ldr	r2, .L181+60
	mov	r1, #22
	bl	avs_u_v
	mov	r2, r5
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r0, r4
	ldr	r2, .L181+64
	mov	r1, #22
	bl	avs_u_v
	mov	r2, r5
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r0, r4
	ldr	r2, .L181+68
	mov	r1, #22
	bl	avs_u_v
	mov	r2, r5
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r0, r4
	ldr	r2, .L181+72
	mov	r1, #22
	bl	avs_u_v
	mov	r2, r5
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r0, r4
	ldr	r2, .L181+76
	mov	r1, #22
	bl	avs_u_v
	mov	r2, r5
	mov	r0, r4
	mov	r1, #1
	bl	avs_f_v
	mov	r2, r7
	mov	r1, #32
	mov	r0, r4
	bl	avs_u_v
	mov	r0, r4
	bl	AVS_next_start_code
	ldr	r3, [r6, #104]
	mov	r0, #1
	orr	r3, r3, #4194304
	str	r3, [r6, #104]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L182:
	.align	2
.L181:
	.word	.LC16
	.word	.LC12
	.word	.LC53
	.word	.LC68
	.word	.LC69
	.word	.LC70
	.word	.LC71
	.word	.LC72
	.word	.LC73
	.word	.LC74
	.word	.LC75
	.word	.LC76
	.word	.LC77
	.word	.LC78
	.word	.LC79
	.word	.LC80
	.word	.LC81
	.word	.LC82
	.word	.LC83
	.word	.LC84
	.fnend
	.size	AVS_camera_parameters_extension, .-AVS_camera_parameters_extension
	.align	2
	.global	AVS_picture_display_extension
	.type	AVS_picture_display_extension, %function
AVS_picture_display_extension:
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
	ldr	r4, [r0, #492]
	mov	r7, r1
	mov	r8, r0
	mov	r1, #4
	ldr	r2, .L202
	mov	r0, r4
	bl	avs_u_v
	ldrb	r3, [r7, #15]
	cmp	r3, #1
	beq	.L200
	ldrb	r3, [r7, #77]
	cmp	r3, #0
	bne	.L201
.L185:
	mov	r3, #1
	str	r3, [r7, #4]
.L187:
	add	r6, r7, #344
	mov	r5, #0
.L189:
	ldr	r2, .L202+4
	mov	r1, #16
	mov	r0, r4
	add	r5, r5, #1
	bl	avs_u_v
	ldr	r2, .L202+8
	mov	r1, #1
	str	r0, [r6, #4]!
	mov	r0, r4
	bl	avs_f_v
	ldr	r2, .L202+12
	mov	r1, #16
	mov	r0, r4
	bl	avs_u_v
	ldr	r2, .L202+8
	mov	r1, #1
	str	r0, [r6, #12]
	mov	r0, r4
	bl	avs_f_v
	ldr	r3, [r7, #4]
	cmp	r3, r5
	bgt	.L189
	mov	r0, r4
	bl	AVS_next_start_code
	ldr	r3, [r8, #104]
	mov	r0, #1
	orr	r3, r3, #524288
	str	r3, [r8, #104]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L201:
	ldrb	r3, [r7, #79]
	cmp	r3, #1
	beq	.L188
.L186:
	mov	r3, #2
	str	r3, [r7, #4]
	b	.L187
.L200:
	ldrb	r3, [r7, #79]
	cmp	r3, #1
	bne	.L185
	ldrb	r3, [r7, #78]
	cmp	r3, #1
	bne	.L186
.L188:
	mov	r3, #3
	str	r3, [r7, #4]
	b	.L187
.L203:
	.align	2
.L202:
	.word	.LC53
	.word	.LC85
	.word	.LC12
	.word	.LC86
	.fnend
	.size	AVS_picture_display_extension, .-AVS_picture_display_extension
	.align	2
	.global	AVS_extension
	.type	AVS_extension, %function
AVS_extension:
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
	ldr	r4, [r0, #492]
	ldr	r2, .L212
	mov	r5, r0
	mov	r6, r1
	mov	r1, #32
	mov	r0, r4
	bl	avs_f_v
	mov	r0, r4
	mov	r1, #4
	bl	BsShow
	sub	r0, r0, #2
	cmp	r0, #9
	ldrls	pc, [pc, r0, asl #2]
	b	.L205
.L207:
	.word	.L206
	.word	.L205
	.word	.L208
	.word	.L205
	.word	.L205
	.word	.L209
	.word	.L205
	.word	.L205
	.word	.L205
	.word	.L210
.L210:
	mov	r1, r6
	mov	r0, r5
	bl	AVS_camera_parameters_extension
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L209:
	mov	r1, r6
	mov	r0, r5
	bl	AVS_picture_display_extension
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L208:
	mov	r1, r6
	mov	r0, r5
	bl	AVS_copyright_extension
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L206:
	mov	r1, r6
	mov	r0, r5
	bl	AVS_sequence_display_extension
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L205:
	mov	r0, r4
	mov	r1, #4
	bl	BsSkip
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L213:
	.align	2
.L212:
	.word	.LC87
	.fnend
	.size	AVS_extension, .-AVS_extension
	.align	2
	.global	AVS_extension_and_userdata
	.type	AVS_extension_and_userdata, %function
AVS_extension_and_userdata:
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
	add	r3, r0, #12288
	add	r6, r0, #14912
	add	r5, r0, #15744
	mov	r7, r0
	mov	r8, r1
	ldr	r4, [r3, #3120]
	add	r6, r6, #4
	add	r5, r5, #12
	b	.L218
.L217:
	mov	r1, #32
	mov	r0, r4
	bl	BsShow
	uxtb	r0, r0
	cmp	r0, #178
	beq	.L222
.L218:
	mov	r0, r4
	bl	BsResidBits
	cmp	r0, #40
	mov	r0, r4
	ble	.L223
	bl	AVS_next_start_code
	mov	r1, #32
	mov	r0, r4
	bl	BsShow
	uxtb	r0, r0
	cmp	r0, #178
	cmpne	r0, #181
	bne	.L220
	cmp	r0, #181
	bne	.L217
	mov	r1, r5
	mov	r0, r6
	bl	AVS_extension
	b	.L217
.L223:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L220:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L222:
	mov	r1, r8
	mov	r0, r7
	bl	AVS_user_data
	b	.L218
	.fnend
	.size	AVS_extension_and_userdata, .-AVS_extension_and_userdata
	.align	2
	.global	AVS_AllocateVHB
	.type	AVS_AllocateVHB, %function
AVS_AllocateVHB:
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
	add	r3, r0, #12288
	mov	r4, r0
	ldr	r6, [r3, #2772]
	ldr	r7, [r3, #2776]
	cmp	r6, #31
	bls	.L225
	cmp	r7, #31
	bls	.L225
	ldr	r3, [r0, #12]
	ldr	r5, [r3, #700]
	ldr	r2, [r3, #28]
	cmp	r5, #0
	bne	.L228
	cmp	r2, #25
	beq	.L252
.L245:
	mov	r5, #4
	mov	r9, #5
	mov	r8, r5
.L229:
	ldr	r3, .L254
	mov	r2, #32
	mov	r1, #0
	sub	r0, fp, #68
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r2, [r4, #12]
	str	r7, [fp, #-40]
	mov	r3, #0
	str	r6, [fp, #-60]
	ldr	r2, [r2, #28]
	str	r7, [fp, #-56]
	cmp	r2, #24
	str	r6, [fp, #-44]
	strb	r3, [fp, #-67]
	beq	.L238
	uxtb	r5, r5
	strb	r8, [fp, #-65]
	strb	r9, [fp, #-63]
.L242:
	sub	r1, fp, #68
	ldr	r0, [r4, #4]
	strb	r5, [fp, #-62]
	mov	r6, #0
	strb	r6, [fp, #-66]
	bl	FSP_ConfigInstance
	subs	r5, r0, #0
	bne	.L239
	ldr	r1, [r4, #12]
	sub	r3, fp, #72
	ldr	r0, [r4, #4]
	ldr	r2, [r1, #24]
	ldr	r1, [r1, #20]
	bl	FSP_ConfigFrameBuf
	cmp	r0, #2
	moveq	r5, #3
	beq	.L249
	cmp	r0, r6
	moveq	r5, #1
	streq	r5, [r4, #8]
	beq	.L249
	ldr	r1, .L254+4
	mov	r0, r5
	bl	dprint_vfmw
	b	.L249
.L225:
	mov	r3, r7
	mov	r2, r6
	ldr	r1, .L254+8
	mov	r0, #0
	bl	dprint_vfmw
	mov	r5, #0
.L249:
	mov	r0, r5
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L228:
	cmp	r2, #25
	bne	.L245
	ldr	r2, [r3, #660]
	ldr	r1, [r3, #664]
	cmp	r2, r6
	bcc	.L235
	cmp	r1, r7
	bcc	.L235
	ldr	r2, [r3, #688]
	ldr	r5, [r3, #684]
	cmp	r2, #0
	add	r8, r5, #2
	bne	.L253
.L246:
	mov	r5, #1
	b	.L237
.L239:
	ldr	r1, .L254+12
	mov	r0, r6
	bl	dprint_vfmw
	mov	r5, r6
	mov	r0, r5
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L252:
	ldr	r2, [r3, #660]
	ldr	r1, [r3, #664]
	cmp	r2, r6
	bcc	.L231
	cmp	r1, r7
	bcc	.L231
	ldr	r5, [r0, #8]
	cmp	r5, #1
	beq	.L249
	ldr	r1, [r3, #688]
	ldr	r2, [r3, #684]
	cmp	r1, #0
	add	r8, r2, #2
	beq	.L246
	add	r5, r2, #1
	cmp	r5, #17
	movge	r5, #17
.L237:
	ldrb	r9, [r3, #708]
	b	.L229
.L238:
	mov	r5, #1
	strb	r9, [fp, #-63]
	strb	r5, [fp, #-65]
	b	.L242
.L235:
	str	r1, [sp, #4]
	mov	r3, r7
	str	r2, [sp]
	mov	r0, #0
	mov	r2, r6
	ldr	r1, .L254+16
	bl	dprint_vfmw
	mov	r5, #0
	b	.L249
.L253:
	add	r5, r5, #1
	cmp	r5, #17
	movge	r5, #17
	b	.L237
.L231:
	str	r1, [sp, #4]
	mov	r3, r7
	str	r2, [sp]
	mov	r0, #0
	mov	r2, r6
	ldr	r1, .L254+16
	bl	dprint_vfmw
	b	.L249
.L255:
	.align	2
.L254:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC90
	.word	.LC88
	.word	.LC91
	.word	.LC89
	.fnend
	.size	AVS_AllocateVHB, .-AVS_AllocateVHB
	.align	2
	.global	AVS_StartDecode
	.type	AVS_StartDecode, %function
AVS_StartDecode:
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
	add	r4, r0, #16384
	add	r6, r0, #12288
	mov	r5, r0
	ldr	r3, [r4, #264]
	strb	r3, [r0, #20]
	ldr	r3, [r4, #268]
	strb	r3, [r0, #21]
	ldr	r3, [r4, #272]
	strb	r3, [r0, #22]
	ldr	r3, [r4, #276]
	strb	r3, [r0, #23]
	ldr	r3, [r4, #280]
	strb	r3, [r0, #24]
	ldr	r3, [r4, #292]
	str	r3, [r0, #28]
	ldr	r3, [r4, #296]
	str	r3, [r0, #80]
	ldr	r3, [r4, #316]
	str	r3, [r0, #32]
	ldr	r3, [r4, #444]
	str	r3, [r0, #92]
	ldr	r3, [r4, #456]
	str	r3, [r0, #96]
	ldr	r3, [r4, #448]
	str	r3, [r0, #100]
	ldr	r3, [r4, #460]
	str	r3, [r0, #104]
	ldr	r3, [r4, #452]
	str	r3, [r0, #108]
	ldr	r3, [r4, #464]
	str	r3, [r0, #112]
	ldr	r3, [r4, #324]
	strh	r3, [r0, #76]
	ldr	r3, [r4, #320]
	strh	r3, [r0, #78]
	ldr	r3, [r4, #328]
	strb	r3, [r0, #59]
	ldr	r3, [r4, #332]
	strb	r3, [r0, #60]
	ldr	r3, [r4, #368]
	strb	r3, [r0, #36]
	ldr	r3, [r4, #372]
	strb	r3, [r0, #37]
	ldr	r3, [r4, #336]
	strb	r3, [r0, #38]
	ldr	r3, [r4, #340]
	strb	r3, [r0, #39]
	ldr	r3, [r4, #348]
	strb	r3, [r0, #40]
	ldr	r3, [r4, #352]
	strb	r3, [r0, #41]
	ldr	r3, [r4, #356]
	strb	r3, [r0, #42]
	ldr	r3, [r4, #360]
	strb	r3, [r0, #43]
	ldr	r3, [r4, #364]
	strb	r3, [r0, #44]
	ldr	r3, [r4, #376]
	strb	r3, [r0, #45]
	ldr	r3, [r4, #380]
	strb	r3, [r0, #46]
	ldr	r3, [r4, #384]
	strb	r3, [r0, #47]
	ldr	r3, [r4, #388]
	strb	r3, [r0, #48]
	ldr	r3, [r4, #392]
	strb	r3, [r0, #49]
	ldr	r3, [r4, #436]
	strb	r3, [r0, #50]
	ldr	r3, [r4, #344]
	strb	r3, [r0, #51]
	ldr	r3, [r4, #400]
	strb	r3, [r0, #52]
	ldr	r3, [r4, #396]
	strb	r3, [r0, #53]
	ldr	r3, [r4, #416]
	strb	r3, [r0, #54]
	ldr	r3, [r4, #412]
	strb	r3, [r0, #55]
	ldr	r3, [r4, #408]
	strb	r3, [r0, #56]
	ldr	r3, [r4, #404]
	strb	r3, [r0, #57]
	ldr	r3, [r4, #440]
	strb	r3, [r0, #58]
	ldr	r2, [r4, #420]
	ldr	r3, [r6, #2704]
	str	r2, [r6, #2168]
	ldr	r2, [r4, #424]
	str	r2, [r6, #2172]
	ldr	r2, [r4, #428]
	str	r2, [r6, #2176]
	ldr	r2, [r4, #496]
	str	r2, [r6, #2184]
	ldr	r2, [r4, #508]
	str	r2, [r6, #2188]
	ldr	r1, [r3, #4]
	ldr	r0, [r0, #4]
	bl	FSP_GetLogicFs
	subs	r7, r0, #0
	beq	.L271
	ldr	r2, [r7, #612]
	add	r0, r5, #14592
	add	r0, r0, #20
	add	r3, r5, #16896
	add	ip, r5, #17152
	add	r3, r3, #130
	ldr	r1, [r2, #32]
	add	ip, ip, #2
	mov	r2, r0
	str	r1, [r6, #2584]
	ldr	r1, [r7, #612]
	ldr	r1, [r1, #76]
	str	r1, [r6, #2592]
	ldr	r1, [r7, #612]
	ldr	r1, [r1, #60]
	str	r1, [r6, #2596]
	ldr	r1, [r7, #612]
	ldr	r1, [r1, #64]
	str	r1, [r6, #2600]
	ldr	r1, [r4, #316]
	str	r1, [r6, #2180]
	ldr	r1, [r4, #432]
	str	r1, [r6, #2192]
	ldr	r1, [r4, #640]
	str	r1, [r6, #2196]
	ldr	r1, [r4, #468]
	strb	r1, [r5, #61]
	ldr	r1, [r4, #472]
	strb	r1, [r5, #62]
	ldr	r1, [r4, #480]
	strb	r1, [r5, #63]
	ldr	r1, [r4, #476]
	strb	r1, [r5, #64]
	ldr	r1, [r4, #484]
	strb	r1, [r5, #65]
	ldr	r1, [r4, #488]
	strb	r1, [r5, #66]
	ldr	r1, [r4, #492]
	strb	r1, [r5, #67]
.L259:
	ldrsh	r1, [r3, #2]!
	cmp	r3, ip
	str	r1, [r2, #4]!
	bne	.L259
	ldr	r1, [r4, #300]
	add	r2, r5, #16640
	add	r3, r5, #14464
	add	r2, r2, #252
	add	r3, r3, #20
	str	r1, [r6, #2604]
	ldr	r1, [r4, #304]
	str	r1, [r6, #2608]
	ldr	r1, [r4, #308]
	str	r1, [r6, #2612]
	ldr	r1, [r4, #312]
	str	r1, [r6, #2616]
.L260:
	ldr	r1, [r2, #4]!
	str	r1, [r3, #4]!
	cmp	r3, r0
	bne	.L260
	ldr	r3, [r6, #3408]
	add	r1, r5, #20
	add	r3, r3, #1
	str	r3, [r6, #3408]
	ldr	r3, [r5, #12]
	str	r1, [r5, #16]
	ldr	r2, [r3, #856]
	cmp	r2, #1
	beq	.L272
	cmp	r2, #2
	beq	.L273
.L262:
	ldr	r2, [r3, #588]
	mov	r0, #1
	str	r2, [r6, #2620]
	ldr	r3, [r3, #624]
	str	r3, [r6, #2624]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L272:
	cmp	r1, #0
	beq	.L262
	ldr	r1, [r6, #2704]
	ldrb	r2, [r1, #1]
	cmp	r2, #2
	bne	.L262
	mov	r7, #0
	ldr	r0, [r5, #4]
	str	r7, [r5, #16]
	mov	r2, r7
	ldr	r1, [r1, #4]
	bl	FSP_SetDisplay
	mov	r0, r7
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L273:
	ldr	r2, [r3, #860]
	cmp	r1, #0
	cmpne	r2, #0
	ble	.L262
	ldr	r1, [r6, #2704]
	ldrb	r2, [r1, #1]
	cmp	r2, #2
	bne	.L262
	mov	r7, #0
	ldr	r0, [r5, #4]
	str	r7, [r5, #16]
	mov	r2, r7
	ldr	r1, [r1, #4]
	bl	FSP_SetDisplay
	ldr	r2, [r5, #12]
	mov	r0, r7
	ldr	r3, [r2, #860]
	sub	r3, r3, #1
	str	r3, [r2, #860]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L271:
	movw	r2, #2185
	ldr	r1, .L274
	bl	dprint_vfmw
	mov	r0, r7
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L275:
	.align	2
.L274:
	.word	.LC92
	.fnend
	.size	AVS_StartDecode, .-AVS_StartDecode
	.align	2
	.global	AVS_SetImgFormat
	.type	AVS_SetImgFormat, %function
AVS_SetImgFormat:
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
	mov	r6, r0
	ldrb	r3, [r5, #2763]
	ldr	r10, [r5, #3092]
	cmp	r3, #1
	ldrb	r7, [r5, #2794]
	beq	.L283
	ldrb	r3, [r5, #2824]
	subs	r3, r3, #1
	movne	r3, #1
	str	r3, [fp, #-52]
.L277:
	ldrb	r3, [r5, #2761]
	ldr	r0, [r6, #4]
	sub	r3, r3, #1
	ldrb	r9, [r5, #2826]
	uxtb	r3, r3
	cmp	r3, #3
	ldrls	r2, .L288
	movhi	r8, #0
	ldrls	r8, [r2, r3, asl #2]
	ldr	r2, [r5, #2704]
	ldr	r1, [r2, #4]
	bl	FSP_GetFsImagePtr
	subs	r4, r0, #0
	beq	.L286
	and	ip, r10, #3
	and	r9, r9, #3
	orr	r1, ip, #3072
	ldr	r3, [fp, #-52]
	and	r7, r7, #3
	orr	r9, r1, r9, asl #12
	and	lr, r8, #7
	mov	r1, r8
	orr	r2, r9, r7, asl #5
	orr	r3, r2, r3, asl #8
	orr	r3, r3, lr, asl #14
	str	r3, [r4, #108]
	ldr	r3, [r5, #3400]
	str	ip, [r4, #100]
	str	ip, [r4, #104]
	str	r3, [r4, #160]
	bl	SetAspectRatio
	ldr	r3, [r5, #2772]
	str	r3, [r4, #112]
	ldr	r3, [r5, #2776]
	str	r3, [r4, #116]
	ldr	r2, [r6, #12]
	ldr	r2, [r2, #28]
	cmp	r2, #25
	beq	.L287
.L281:
	mov	r3, #6
	str	r3, [r4, #340]
	ldrb	r1, [r5, #2825]
	mov	r2, #1
	mov	r3, #8
	strb	r2, [r4, #335]
	cmp	r1, r2
	strb	r2, [r4, #333]
	str	r3, [r4, #344]
	moveq	r2, #0
	movne	r2, #4
	str	r3, [r4, #352]
	strb	r2, [r4, #328]
	str	r3, [r4, #348]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L283:
	mov	r3, #0
	str	r3, [fp, #-52]
	b	.L277
.L287:
	ldr	r2, [r4, #140]
	add	r3, r3, #15
	ldr	ip, [r4, #44]
	add	r8, r4, #480
	mov	r3, r3, lsr #4
	add	r1, r4, #496
	mov	r0, r2, asl #4
	add	r9, ip, r2
	mul	r3, r3, r0
	add	lr, r3, ip
	str	lr, [r4, #48]
	ldrd	r6, [r8, #-8]
	add	r2, lr, r2
	mov	r0, lr
	strd	r6, [fp, #-52]
	adds	r6, r6, r3
	adc	r7, r7, r3, asr #31
	strd	r6, [r8]
	str	r2, [r4, #40]
	mov	r6, r1
	ldrd	r2, [fp, #-52]
	str	lr, [r4, #32]
	str	ip, [r4, #28]
	str	r9, [r4, #36]
	strd	r2, [r1, #-8]
	str	ip, [r4, #60]
	bl	MEM_Phy2Vir
	mov	r3, #0
	str	r0, [r4, #496]
	str	r3, [r6, #4]
	ldr	r3, [r4, #32]
	str	r3, [r4, #64]
	b	.L281
.L286:
	movw	r2, #2309
	ldr	r1, .L288+4
	bl	dprint_vfmw
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L289:
	.align	2
.L288:
	.word	.LANCHOR0
	.word	.LC93
	.fnend
	.size	AVS_SetImgFormat, .-AVS_SetImgFormat
	.align	2
	.global	AVS_GetImageBuffer
	.type	AVS_GetImageBuffer, %function
AVS_GetImageBuffer:
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
	add	r4, r0, #12288
	mov	r5, r0
	ldr	r3, [r4, #3812]
	cmp	r3, #2
	beq	.L291
	ldr	r6, [r4, #3132]
	add	r7, r0, #14912
	add	r7, r7, #4
	add	r2, r6, #1
	mov	r3, r6, asl #4
	mov	r1, r2, asr #31
	sub	r6, r3, r6, asl #2
	add	r6, r6, #16
	mov	r3, r1, lsr #30
	add	r6, r7, r6
	add	r2, r2, r3
	str	r6, [r4, #2704]
	and	r2, r2, #3
	rsb	r2, r3, r2
	str	r2, [r4, #3132]
.L292:
	mov	r1, #1
	ldr	r0, [r5, #4]
	bl	FSP_NewLogicFs
	str	r0, [r6, #4]
	ldr	r3, [r4, #2704]
	ldr	r1, [r3, #4]
	cmp	r1, #0
	blt	.L310
	ldr	r0, [r5, #4]
	bl	FSP_GetLogicFs
	subs	r5, r0, #0
	beq	.L311
	ldr	r3, [r4, #2704]
	mov	r0, #18
	ldr	r1, .L312
	ldr	r2, [r3, #4]
	bl	dprint_vfmw
	ldr	r2, [r5, #608]
	cmp	r2, #0
	beq	.L297
	ldr	r3, [r5, #612]
	cmp	r3, #0
	beq	.L297
	ldr	r1, [r5, #616]
	cmp	r1, #0
	beq	.L297
	ldr	ip, [r1, #16]
	mov	r0, #18
	ldr	r3, [r3, #16]
	ldr	r2, [r2, #16]
	ldr	r1, .L312+4
	str	ip, [sp]
	bl	dprint_vfmw
.L297:
	mov	r0, #1
	mov	r3, #0
	str	r3, [r5, #168]
.L295:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L291:
	add	r7, r0, #14912
	add	r6, r7, #68
	add	r7, r7, #4
	str	r6, [r4, #2704]
	b	.L292
.L310:
	ldr	r1, .L312+8
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r3, [r4, #2708]
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_GetFsImagePtr
	subs	r10, r0, #0
	beq	.L294
	ldr	r3, [r4, #2704]
	mov	r2, #1
	ldr	r0, [r5, #4]
	add	r8, r10, #544
	add	r6, r10, #560
	add	r9, r10, #528
	ldr	r1, [r3, #4]
	add	r7, r7, #4
	bl	FSP_ClearLogicFs
	ldr	r3, [r4, #2708]
	mov	r2, #1
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_ClearLogicFs
	ldr	r3, [r4, #2712]
	mov	r2, #1
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_ClearLogicFs
	ldr	r3, [r4, #2716]
	mov	r2, #1
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_ClearLogicFs
	ldr	r1, [r10, #528]
	ldr	r0, [r5, #4]
	bl	FreeUsdByDec
	ldr	r1, [r10, #536]
	ldr	r0, [r5, #4]
	bl	FreeUsdByDec
	ldr	r1, [r10, #544]
	ldr	r0, [r5, #4]
	bl	FreeUsdByDec
	ldr	r1, [r10, #552]
	ldr	r0, [r5, #4]
	bl	FreeUsdByDec
	mov	r2, #0
	mov	r3, #0
	strd	r2, [r9]
	strd	r2, [r8, #-8]
	strd	r2, [r8]
	strd	r2, [r6, #-8]
	str	r7, [r4, #2704]
	str	r7, [r4, #2716]
	str	r7, [r4, #2712]
	str	r7, [r4, #2708]
	ldr	r0, [r5, #4]
	bl	FSP_GetNullLogicFs
	str	r0, [r4, #2636]
.L294:
	mov	r6, #0
	add	r1, r5, #16128
	str	r6, [r4, #3396]
	ldr	r0, [r5, #4]
	bl	FSP_ClearNotInVoQueue
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L311:
	movw	r2, #2412
	ldr	r1, .L312+12
	bl	dprint_vfmw
	mov	r0, r5
	b	.L295
.L313:
	.align	2
.L312:
	.word	.LC95
	.word	.LC96
	.word	.LC94
	.word	.LC92
	.fnend
	.size	AVS_GetImageBuffer, .-AVS_GetImageBuffer
	.align	2
	.global	AVS_OutputOneFrame
	.type	AVS_OutputOneFrame, %function
AVS_OutputOneFrame:
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
	mov	r6, r0
	mov	r4, r1
	ldr	r0, [r1, #4]
	ldr	r1, [r6, #4]
	bl	FSP_GetFsImagePtr
	subs	r5, r0, #0
	beq	.L320
	mov	r2, #1
	ldr	r1, [r6, #4]
	ldr	r0, [r4, #4]
	bl	FSP_SetDisplay
	ldr	r0, [r4, #4]
	add	r3, r4, #16128
	str	r5, [sp]
	mov	r2, r4
	mov	r1, #6
	bl	InsertImgToVoQueue
	cmp	r0, #1
	beq	.L316
	ldr	r0, [r4, #4]
	mov	r2, #0
	ldr	r1, [r6, #4]
	bl	FSP_SetDisplay
	ldr	r2, [r6, #4]
	ldr	r1, .L321
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
.L316:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L320:
	movw	r2, #2453
	ldr	r1, .L321+4
	bl	dprint_vfmw
	mov	r0, r5
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L322:
	.align	2
.L321:
	.word	.LC98
	.word	.LC97
	.fnend
	.size	AVS_OutputOneFrame, .-AVS_OutputOneFrame
	.align	2
	.global	AVS_UpdateTableIdx2Dist
	.type	AVS_UpdateTableIdx2Dist, %function
AVS_UpdateTableIdx2Dist:
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
	ldrb	r3, [r0, #197]
	cmp	r3, #1
	ldr	r3, [r0, #464]
	beq	.L337
	cmp	r3, #0
	beq	.L338
	cmp	r3, #1
	bne	.L332
	ldr	r3, [r0, #84]
	add	r2, r0, #4
	ldr	r1, [r0, #76]
	cmp	r3, r2
	ldrne	r2, [r3, #8]
	ldr	r3, [r0, #80]
	ldreq	r2, [r0, #536]
	movne	r2, r2, asl #1
	strne	r2, [r0, #536]
	add	r2, r2, #1
	str	r2, [r0, #532]
	ldr	r3, [r3, #8]
	str	r2, [r0, #552]
	mov	r3, r3, asl #1
	str	r3, [r0, #528]
	str	r3, [r0, #548]
	add	r3, r3, #1
	str	r3, [r0, #524]
	str	r3, [r0, #544]
	ldr	r3, [r1, #8]
	mov	r3, r3, asl #1
	str	r3, [r0, #540]
.L328:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L338:
	ldr	r3, [r0, #80]
	ldr	r3, [r3, #8]
	mov	r3, r3, asl #1
	str	r3, [r0, #540]
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L337:
	cmp	r3, #1
	beq	.L339
	cmp	r3, #2
	bne	.L328
	ldr	r3, [r0, #84]
	add	r2, r0, #4
	cmp	r3, r2
	ldrne	r3, [r3, #8]
	movne	r3, r3, asl #1
	strne	r3, [r0, #524]
	ldr	r3, [r0, #80]
	ldr	r3, [r3, #8]
	mov	r3, r3, asl #1
	str	r3, [r0, #532]
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L332:
	cmp	r3, #2
	bne	.L328
	ldr	r3, [r0, #84]
	add	r2, r0, #4
	cmp	r3, r2
	ldrne	r2, [r3, #8]
	ldr	r3, [r0, #80]
	ldreq	r2, [r0, #528]
	movne	r2, r2, asl #1
	strne	r2, [r0, #528]
	add	r1, r2, #1
	str	r1, [r0, #524]
	ldr	r3, [r3, #8]
	str	r1, [r0, #540]
	str	r2, [r0, #544]
	mov	r3, r3, asl #1
	str	r3, [r0, #532]
	str	r3, [r0, #548]
	add	r3, r3, #1
	str	r3, [r0, #536]
	str	r3, [r0, #552]
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L339:
	ldr	r3, [r0, #80]
	add	r2, r0, #4
	ldr	r1, [r0, #84]
	ldr	r3, [r3, #8]
	cmp	r1, r2
	mov	r3, r3, asl #1
	str	r3, [r0, #524]
	ldrne	r3, [r1, #8]
	movne	r3, r3, asl #1
	strne	r3, [r0, #528]
	b	.L328
	.fnend
	.size	AVS_UpdateTableIdx2Dist, .-AVS_UpdateTableIdx2Dist
	.global	__aeabi_idiv
	.align	2
	.global	AVS_UpdateTableMvEScale
	.type	AVS_UpdateTableMvEScale, %function
AVS_UpdateTableMvEScale:
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
	mov	r6, r0
	ldrb	r0, [r0, #197]
	cmp	r0, #1
	beq	.L391
	ldr	r3, [r6, #464]
	cmp	r3, #0
	moveq	r3, #512
	streq	r3, [r6, #620]
	beq	.L377
	cmp	r3, #1
	bne	.L367
	ldr	r3, [r6, #76]
	add	r10, r6, #536
	str	r3, [fp, #-60]
	add	r3, r6, #520
	str	r3, [fp, #-48]
	add	r3, r6, #552
	str	r3, [fp, #-52]
	mov	r3, #0
	str	r3, [fp, #-56]
.L356:
	ldr	r3, [fp, #-60]
	mov	r8, r10
	ldr	r7, [fp, #-52]
	ldr	r6, [fp, #-48]
	ldr	r2, [r3, #8]
	ldr	r3, [fp, #-56]
	add	r9, r3, r2, lsl #1
	mov	r10, r9
.L352:
	ldr	r5, [r6, #4]!
	mov	r9, r7
	ldr	r4, [fp, #-48]
	rsb	r5, r5, r10
	ubfx	r5, r5, #0, #9
.L354:
	ldr	r1, [r4, #4]!
	mov	r0, #512
	mov	r3, #1
	rsb	r1, r1, r10
	ubfx	r1, r1, #0, #9
	cmp	r1, #0
	beq	.L353
	bl	__aeabi_idiv
	mov	r3, r0
.L353:
	mul	r3, r3, r5
	cmp	r8, r4
	str	r3, [r9, #4]!
	bne	.L354
	cmp	r8, r6
	add	r7, r7, #16
	bne	.L352
	ldr	r3, [fp, #-56]
	add	r10, r8, #16
	add	r3, r3, #1
	str	r3, [fp, #-56]
	cmp	r3, #2
	ldr	r3, [fp, #-48]
	add	r3, r3, #16
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-52]
	add	r3, r3, #64
	str	r3, [fp, #-52]
	bne	.L356
.L377:
	mov	r0, #1
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L391:
	ldr	r2, [r6, #76]
	ldr	r3, [r6, #464]
	ldr	r5, [r2, #8]
	cmp	r3, #1
	addeq	r9, r6, #520
	addeq	r7, r6, #32
	moveq	r8, r6
	mov	r5, r5, asl #1
	beq	.L343
	cmp	r3, #2
	bne	.L377
	ldr	r3, [r6, #524]
	rsb	r3, r3, r5
	ubfx	r4, r3, #0, #9
	cmp	r4, #0
	beq	.L349
	mov	r1, r4
	mov	r0, #512
	bl	__aeabi_idiv
.L349:
	mul	r3, r0, r4
	ldr	r4, [r6, #532]
	rsb	r4, r5, r4
	ubfx	r4, r4, #0, #9
	cmp	r4, #0
	str	r3, [r6, #556]
	moveq	r0, #1
	beq	.L350
	mov	r1, r4
	mov	r0, #512
	bl	__aeabi_idiv
.L350:
	mul	r4, r0, r4
	mov	r0, #1
	str	r4, [r6, #572]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L343:
	ldr	r1, [r6, #524]
	mov	r0, #512
	ldr	r4, [r9, #4]!
	mov	r3, #1
	rsb	r1, r1, r5
	ubfx	r1, r1, #0, #9
	rsb	r4, r4, r5
	cmp	r1, #0
	ubfx	r4, r4, #0, #9
	beq	.L345
	bl	__aeabi_idiv
	mov	r3, r0
.L345:
	mul	r3, r3, r4
	mov	r0, #1
	str	r3, [r8, #556]
	ldr	r1, [r6, #528]
	rsb	r1, r1, r5
	ubfx	r1, r1, #0, #9
	cmp	r1, #0
	beq	.L346
	mov	r0, #512
	bl	__aeabi_idiv
.L346:
	mul	r0, r0, r4
	add	r8, r8, #16
	str	r0, [r8, #544]
	cmp	r8, r7
	bne	.L343
	b	.L377
.L367:
	cmp	r3, #2
	bne	.L377
	ldr	r3, [r6, #76]
	mov	r7, r6
	add	r6, r6, #16
	add	r10, r7, #520
	mov	r8, #0
	str	r3, [fp, #-52]
.L366:
	ldr	r3, [fp, #-52]
	mov	r9, r10
	ldr	r4, [r3, #8]
	mov	r3, r7
	add	r4, r8, r4, lsl #1
.L357:
	ldr	r1, [r10, #4]
	mov	r0, #512
	ldr	r5, [r9, #4]!
	mov	ip, #1
	rsb	r1, r1, r4
	ubfx	r1, r1, #0, #9
	rsb	r5, r5, r4
	cmp	r1, #0
	ubfx	r5, r5, #0, #9
	beq	.L359
	str	r3, [fp, #-48]
	bl	__aeabi_idiv
	ldr	r3, [fp, #-48]
	mov	ip, r0
.L359:
	mul	ip, ip, r5
	mov	r0, #1
	str	ip, [r3, #556]
	ldr	r1, [r10, #8]
	rsb	r1, r1, r4
	ubfx	r1, r1, #0, #9
	cmp	r1, #0
	beq	.L360
	mov	r0, #512
	str	r3, [fp, #-48]
	bl	__aeabi_idiv
	ldr	r3, [fp, #-48]
.L360:
	mul	r0, r0, r5
	add	r3, r3, #8
	str	r0, [r3, #552]
	cmp	r3, r6
	bne	.L357
	add	r2, r10, #8
	mov	r9, r7
.L358:
	ldr	r1, [r10, #12]
	mov	r0, #512
	ldr	r5, [r2, #4]!
	mov	ip, #1
	rsb	r1, r4, r1
	ubfx	r1, r1, #0, #9
	rsb	r5, r4, r5
	cmp	r1, #0
	ubfx	r5, r5, #0, #9
	beq	.L363
	str	r2, [fp, #-48]
	bl	__aeabi_idiv
	ldr	r2, [fp, #-48]
	mov	ip, r0
.L363:
	mul	ip, ip, r5
	mov	r0, #1
	str	ip, [r9, #572]
	ldr	r1, [r10, #16]
	rsb	r1, r4, r1
	ubfx	r1, r1, #0, #9
	cmp	r1, #0
	beq	.L364
	mov	r0, #512
	str	r2, [fp, #-48]
	bl	__aeabi_idiv
	ldr	r2, [fp, #-48]
.L364:
	mul	r0, r0, r5
	add	r9, r9, #8
	str	r0, [r9, #568]
	cmp	r6, r9
	bne	.L358
	add	r8, r8, #1
	add	r6, r6, #32
	cmp	r8, #2
	add	r7, r7, #32
	add	r10, r10, #16
	bne	.L366
	mov	r0, #1
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	.fnend
	.size	AVS_UpdateTableMvEScale, .-AVS_UpdateTableMvEScale
	.align	2
	.global	AVS_UpdateTableDirectScale
	.type	AVS_UpdateTableDirectScale, %function
AVS_UpdateTableDirectScale:
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
	ldrb	r3, [r0, #197]
	mov	r6, r0
	cmp	r3, #1
	beq	.L415
	ldr	r8, [r0, #80]
	mov	r5, #1
	add	r9, r0, #4
	add	r7, r0, #684
	mov	r4, #0
	ldr	r10, [r8, #8]
	mov	r10, r10, asl r5
.L399:
	sub	r3, r5, #1
	mov	r0, #16384
	and	r1, r5, #1
	add	r3, r3, r3, lsr #31
	mov	r3, r3, asr #1
	add	r3, r3, #21
	ldr	r3, [r6, r3, asl #2]
	cmp	r9, r3
	beq	.L397
	ldr	r4, [r3, #8]
	add	r4, r1, r4, lsl #1
	rsb	r1, r4, r10
	ubfx	r1, r1, #0, #9
	cmp	r1, #0
	moveq	r3, #32
	streq	r3, [r7]
	beq	.L397
	bl	__aeabi_idiv
	str	r0, [r7]
.L397:
	add	r5, r5, #1
	add	r7, r7, #4
	cmp	r5, #5
	bne	.L399
	ldr	r2, [r8, #8]
	add	r10, r6, #700
	ldr	ip, [r6, #800]
	mov	r5, #1
	mov	r7, #0
	cmp	ip, #0
	moveq	r2, r2, asl #1
	movne	r8, r2, asl #1
	addeq	r8, r2, #1
.L409:
	cmp	ip, #0
	beq	.L402
	add	r3, r7, r7, lsr #31
	mov	r3, r3, asr #1
	add	r3, r3, #21
	ldr	r3, [r6, r3, asl #2]
	cmp	r9, r3
	beq	.L403
	ldr	r4, [r3, #8]
	and	r3, r5, #1
	add	r4, r3, r4, lsl #1
	rsb	r0, r4, r8
	add	r0, r0, #512
	mov	r1, r0, asr #31
	mov	r1, r1, lsr #23
	add	r0, r0, r1
	ubfx	r3, r0, #0, #9
	subs	r1, r3, r1
	moveq	r3, #32
	streq	r3, [r10, #-16]
	beq	.L405
	mov	r0, #16384
	str	ip, [fp, #-48]
	bl	__aeabi_idiv
	ldr	ip, [fp, #-48]
	str	r0, [r10, #-16]
.L406:
	str	r0, [r10]
.L408:
	add	r5, r5, #1
	add	r7, r7, #1
	cmp	r5, #5
	add	r10, r10, #4
	bne	.L409
	mov	r0, #1
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L402:
	add	r3, r5, r5, lsr #31
	mov	r3, r3, asr #1
	add	r3, r3, #20
	ldr	r3, [r6, r3, asl #2]
	cmp	r9, r3
	ldrne	r4, [r3, #8]
	andne	r3, r7, #1
	addne	r4, r3, r4, lsl #1
.L403:
	rsb	r0, r4, r8
	add	r0, r0, #512
	mov	r1, r0, asr #31
	mov	r1, r1, lsr #23
	add	r0, r0, r1
	ubfx	r3, r0, #0, #9
	subs	r1, r3, r1
	beq	.L405
	mov	r0, #16384
	str	ip, [fp, #-48]
	bl	__aeabi_idiv
	ldr	ip, [fp, #-48]
	b	.L406
.L405:
	mov	r3, #32
	str	r3, [r10]
	b	.L408
.L415:
	ldr	r3, [r0, #80]
	add	r7, r0, #4
	add	r4, r0, #80
	add	r6, r0, #88
	mov	r8, #32
	ldr	r5, [r3, #8]
	mov	r5, r5, asl #1
.L396:
	ldr	r3, [r4, #4]!
	mov	r0, #16384
	cmp	r3, r7
	beq	.L394
	ldr	r1, [r3, #8]
	sub	r1, r5, r1, asl #1
	ubfx	r1, r1, #0, #9
	cmp	r1, #0
	streq	r8, [r4, #600]
	beq	.L394
	bl	__aeabi_idiv
	str	r0, [r4, #600]
.L394:
	cmp	r4, r6
	bne	.L396
	mov	r0, #1
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	.fnend
	.size	AVS_UpdateTableDirectScale, .-AVS_UpdateTableDirectScale
	.align	2
	.global	AVS_UpdateTableSymScale
	.type	AVS_UpdateTableSymScale, %function
AVS_UpdateTableSymScale:
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
	ldr	r3, [r0, #84]
	add	r2, r0, #4
	mov	r5, r0
	cmp	r3, r2
	beq	.L423
	ldrb	r0, [r0, #197]
	cmp	r0, #1
	beq	.L418
	ldr	ip, [r5, #76]
	add	r2, r5, #520
	add	r5, r5, #712
	mov	r3, #0
.L421:
	ldr	r6, [ip, #8]
	add	r10, r2, #20
	mov	r9, r5
	mov	r8, r2
	mov	r7, #2
	add	r6, r3, r6, lsl #1
.L420:
	ldr	r1, [r8, #4]!
	mov	r0, #512
	ldr	r4, [r10, #-4]!
	mov	lr, #1
	rsb	r1, r1, r6
	ubfx	r1, r1, #0, #9
	rsb	r4, r6, r4
	cmp	r1, #0
	ubfx	r4, r4, #0, #9
	beq	.L419
	str	ip, [fp, #-56]
	str	r3, [fp, #-52]
	str	r2, [fp, #-48]
	bl	__aeabi_idiv
	ldr	r2, [fp, #-48]
	ldr	r3, [fp, #-52]
	ldr	ip, [fp, #-56]
	mov	lr, r0
.L419:
	mul	r4, lr, r4
	subs	r7, r7, #1
	str	r4, [r9, #4]!
	bne	.L420
	add	r3, r3, #1
	add	r2, r2, #16
	cmp	r3, #2
	add	r5, r5, #8
	bne	.L421
	mov	r0, #1
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L418:
	ldr	r2, [r5, #76]
	ldr	r1, [r3, #8]
	ldr	r3, [r5, #80]
	ldr	r2, [r2, #8]
	ldr	r4, [r3, #8]
	mov	r3, r2, asl #1
	sub	r1, r3, r1, asl #1
	ubfx	r1, r1, #0, #9
	rsb	r3, r3, r4, lsl #1
	cmp	r1, #0
	ubfx	r4, r3, #0, #9
	bne	.L428
.L422:
	mul	r3, r0, r4
	mov	r0, #1
	str	r3, [r5, #716]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L428:
	mov	r0, #512
	bl	__aeabi_idiv
	b	.L422
.L423:
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	.fnend
	.size	AVS_UpdateTableSymScale, .-AVS_UpdateTableSymScale
	.align	2
	.global	AVS_UpdateTabBBlkDist
	.type	AVS_UpdateTabBBlkDist, %function
AVS_UpdateTabBBlkDist:
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
	ldr	r2, [r0, #84]
	add	r1, r0, #4
	mov	r3, r0
	cmp	r2, r1
	beq	.L432
	ldrb	r0, [r0, #197]
	cmp	r0, #1
	beq	.L433
	ldr	r5, [r3, #76]
	mov	r0, #1
	ldr	r1, [r3, #536]
	ldr	r6, [r3, #524]
	ldr	r2, [r5, #8]
	ldr	lr, [r3, #532]
	ldr	ip, [r3, #528]
	mov	r2, r2, asl r0
	ldr	r4, [r3, #540]
	rsb	r6, r6, r2
	rsb	ip, ip, r2
	rsb	lr, r2, lr
	rsb	r2, r2, r1
	ubfx	lr, lr, #0, #9
	ubfx	r1, r6, #0, #9
	str	lr, [r3, #740]
	ubfx	r2, r2, #0, #9
	str	r1, [r3, #732]
	ubfx	r1, ip, #0, #9
	str	r2, [r3, #744]
	str	r1, [r3, #736]
	ldr	r2, [r5, #8]
	ldr	r1, [r3, #552]
	ldr	lr, [r3, #548]
	ldr	ip, [r3, #544]
	mov	r2, r2, asl r0
	add	r2, r2, r0
	rsb	r4, r4, r2
	rsb	ip, ip, r2
	rsb	lr, r2, lr
	rsb	r2, r2, r1
	ubfx	lr, lr, #0, #9
	ubfx	r1, r4, #0, #9
	ubfx	r2, r2, #0, #9
	str	r1, [r3, #748]
	str	lr, [r3, #756]
	ubfx	r1, ip, #0, #9
	str	r2, [r3, #760]
	str	r1, [r3, #752]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L433:
	ldr	r1, [r3, #76]
	ldr	lr, [r3, #80]
	ldr	ip, [r2, #8]
	ldr	r1, [r1, #8]
	ldr	lr, [lr, #8]
	mov	r2, r1, asl #1
	sub	r1, r2, ip, asl #1
	rsb	r2, r2, lr, lsl #1
	ubfx	r1, r1, #0, #9
	ubfx	r2, r2, #0, #9
	str	r1, [r3, #732]
	str	r2, [r3, #740]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L432:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	AVS_UpdateTabBBlkDist, .-AVS_UpdateTabBBlkDist
	.align	2
	.global	AVS_UpdatePmvTable
	.type	AVS_UpdatePmvTable, %function
AVS_UpdatePmvTable:
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
	ldr	r4, [r0, #464]
	mov	r5, r0
	cmp	r4, #1
	beq	.L443
	bcc	.L437
	cmp	r4, #2
	bne	.L445
	bl	AVS_UpdateTableIdx2Dist
	mov	r0, r5
	bl	AVS_UpdateTableMvEScale
	mov	r0, r5
	bl	AVS_UpdateTableDirectScale
	mov	r0, r5
	bl	AVS_UpdateTabBBlkDist
	mov	r0, r5
	bl	AVS_UpdateTableSymScale
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L445:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L437:
	ldrb	r4, [r0, #197]
	cmp	r4, #1
	beq	.L442
.L443:
	bl	AVS_UpdateTableIdx2Dist
	mov	r0, r5
	bl	AVS_UpdateTableMvEScale
.L442:
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	AVS_UpdatePmvTable, .-AVS_UpdatePmvTable
	.align	2
	.global	AVS_GetStreamInf
	.type	AVS_GetStreamInf, %function
AVS_GetStreamInf:
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
	add	r4, r0, #12288
	mov	r5, r0
	ldr	r2, [r4, #2744]
	ldrb	r3, [r4, #2760]
	cmp	r2, #1
	str	r3, [r4, #3424]
	beq	.L447
	ldr	r3, [r0, #8]
	cmp	r3, #1
	beq	.L448
.L447:
	ldr	r1, .L539
	mov	r0, #22
	bl	dprint_vfmw
	ldrb	r3, [r4, #2763]
	ldr	r2, [r4, #2772]
	cmp	r3, #1
	ldr	r3, [r4, #2776]
	add	r2, r2, #15
	addne	r3, r3, #31
	addeq	r3, r3, #15
	mov	r2, r2, lsr #4
	str	r2, [r4, #2724]
	movne	r3, r3, lsr #5
	moveq	r3, r3, lsr #4
	movne	r3, r3, asl #1
	cmp	r2, #512
	str	r3, [r4, #2728]
	bgt	.L451
	cmp	r3, #512
	ble	.L452
.L451:
	ldr	r1, .L539+4
	mov	r0, #18
	bl	dprint_vfmw
	mov	r7, #0
.L453:
	mov	r0, r7
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L452:
	ldr	r3, [r4, #2708]
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_GetFsImagePtr
	subs	r7, r0, #0
	addeq	r6, r5, #14912
	addeq	r6, r6, #8
	beq	.L455
	ldr	r3, [r4, #2704]
	mov	r2, #1
	ldr	r0, [r5, #4]
	add	r9, r7, #544
	add	r8, r7, #560
	add	r10, r7, #528
	ldr	r1, [r3, #4]
	add	r6, r5, #14912
	bl	FSP_ClearLogicFs
	ldr	r3, [r4, #2708]
	mov	r2, #1
	ldr	r0, [r5, #4]
	add	r6, r6, #8
	ldr	r1, [r3, #4]
	bl	FSP_ClearLogicFs
	ldr	r3, [r4, #2712]
	mov	r2, #1
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_ClearLogicFs
	ldr	r3, [r4, #2716]
	mov	r2, #1
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_ClearLogicFs
	ldr	r1, [r7, #528]
	ldr	r0, [r5, #4]
	bl	FreeUsdByDec
	ldr	r1, [r7, #536]
	ldr	r0, [r5, #4]
	bl	FreeUsdByDec
	ldr	r1, [r7, #544]
	ldr	r0, [r5, #4]
	bl	FreeUsdByDec
	ldr	r1, [r7, #552]
	ldr	r0, [r5, #4]
	bl	FreeUsdByDec
	mov	r2, #0
	mov	r3, #0
	strd	r2, [r10]
	strd	r2, [r9, #-8]
	strd	r2, [r9]
	strd	r2, [r8, #-8]
	str	r6, [r4, #2704]
	str	r6, [r4, #2716]
	str	r6, [r4, #2712]
	str	r6, [r4, #2708]
	ldr	r0, [r5, #4]
	bl	FSP_GetNullLogicFs
	str	r0, [r4, #2636]
.L455:
	add	r7, r5, #16128
	mov	r3, #0
	str	r3, [r4, #3396]
	mov	r1, r7
	ldr	r0, [r5, #4]
	bl	FSP_ClearNotInVoQueue
	ldr	r3, [r5, #12]
	ldr	r2, [r3, #700]
	cmp	r2, #0
	bne	.L456
	ldr	r3, [r3, #28]
	cmp	r3, #25
	beq	.L526
.L456:
	ldr	r0, [r5, #4]
	bl	FSP_GetFspType
	cmp	r0, #0
	beq	.L523
.L458:
	mov	r7, #0
	str	r6, [r4, #2704]
	str	r7, [r4, #2744]
	mov	r0, r5
	str	r6, [r4, #2716]
	str	r6, [r4, #2712]
	str	r6, [r4, #2708]
	bl	AVS_AllocateVHB
	cmp	r0, #3
	mov	ip, r0
	moveq	r7, r0
	beq	.L453
	cmp	r0, r7
	strne	r7, [r4, #2744]
	beq	.L527
.L448:
	ldrb	r1, [r4, #2759]
	mov	r0, r5
	ldr	r3, [r4, #2704]
	ldrb	r2, [r4, #2825]
	str	r1, [r4, #3420]
	strb	r2, [r3]
	bl	AVS_GetImageBuffer
	subs	r7, r0, #0
	beq	.L528
	ldr	r3, [r4, #2704]
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_GetFsImagePtr
	subs	ip, r0, #0
	beq	.L529
	ldr	r3, [r5, #12]
	add	lr, ip, #576
	add	r8, ip, #592
	mvn	r6, #0
	mvn	r7, #0
	ldr	r1, .L539+8
	ldrd	r2, [r3, #56]
	mov	r0, #29
	strd	r2, [lr, #-8]
	ldr	r3, [r5, #12]
	ldrd	r2, [r3, #72]
	strd	r2, [lr]
	ldr	r3, [r5, #12]
	ldrd	r2, [r3, #88]
	strd	r2, [r8, #-8]
	ldr	r3, [r5, #12]
	ldr	r3, [r3, #104]
	str	r3, [ip, #8]
	ldr	r3, [r5, #12]
	ldr	r3, [r3, #108]
	str	r3, [ip, #12]
	ldr	r3, [r5, #12]
	ldr	r3, [r3, #112]
	str	r3, [ip, #16]
	ldr	r3, [r5, #12]
	ldr	r3, [r3, #128]
	str	r3, [ip, #20]
	ldrb	r3, [r4, #2825]
	clz	r3, r3
	mov	r3, r3, lsr #5
	str	r3, [ip, #96]
	ldr	r3, [r5, #12]
	strd	r6, [r3, #56]
	ldrd	r6, [lr]
	ldrd	r2, [lr, #-8]
	strd	r6, [sp]
	bl	dprint_vfmw
	ldr	r3, [r4, #2704]
	ldr	r2, [r4, #2856]
	str	r2, [r3, #8]
	ldr	r3, [r4, #2704]
	ldrb	r2, [r4, #2825]
	strb	r2, [r3]
	ldr	r3, [r4, #2704]
	ldr	r2, [r4, #3092]
	strb	r2, [r3, #1]
	ldrb	r2, [r4, #2825]
	ldr	r3, [r4, #2704]
	cmp	r2, #0
	ldrneb	r2, [r4, #2826]
	moveq	r2, #1
	strb	r2, [r3, #2]
	ldrb	r3, [r4, #2825]
	cmp	r3, #0
	bne	.L524
	ldr	r7, [r4, #3092]
	cmp	r7, #0
	beq	.L521
.L524:
	add	r6, r5, #14912
	add	r6, r6, #4
.L464:
	ldr	r3, [r4, #3088]
	mov	r0, r6
	add	r6, r5, #16384
	mov	r7, #6
	str	r3, [r4, #3428]
	bl	AVS_UpdatePmvTable
	ldr	lr, [r4, #2724]
	ldr	ip, [r4, #2728]
	mov	r2, #0
	mov	r3, #1
	str	r2, [r6, #268]
	str	r3, [r6, #272]
	add	r2, r5, #16896
	mul	r1, ip, lr
	add	r3, r5, #15232
	add	r0, r5, #15360
	add	r3, r3, #2
	add	r2, r2, #130
	add	r0, r0, #2
	sub	r1, r1, #1
	str	r1, [r6, #264]
	ldr	r1, [r4, #3144]
	str	lr, [r6, #324]
	cmp	r1, #0
	add	lr, r1, #63
	str	ip, [r6, #320]
	movlt	r1, lr
	str	r7, [r6, #280]
	mov	r1, r1, asr r7
	str	r1, [r6, #276]
	ldr	r1, [r4, #3424]
	str	r1, [r6, #328]
	ldr	r1, [r4, #3420]
	str	r1, [r6, #332]
	ldrb	r1, [r4, #2838]
	str	r1, [r6, #336]
	ldrb	r1, [r4, #2837]
	str	r1, [r6, #340]
	ldrb	r1, [r4, #2836]
	str	r1, [r6, #344]
	ldrb	r1, [r4, #2830]
	str	r1, [r6, #348]
	ldrb	r1, [r4, #2829]
	str	r1, [r6, #352]
	ldrb	r1, [r4, #2828]
	str	r1, [r6, #356]
	ldrb	r1, [r4, #2827]
	str	r1, [r6, #360]
	ldrb	r1, [r4, #2826]
	str	r1, [r6, #364]
	ldr	r1, [r4, #3092]
	str	r1, [r6, #368]
	ldrb	r1, [r4, #2825]
	cmp	r1, #0
	moveq	r1, #1
	movne	r1, #3
	str	r1, [r6, #372]
	ldrb	r1, [r4, #2824]
	str	r1, [r6, #376]
	ldr	r1, [r4, #2868]
	str	r1, [r6, #380]
	ldr	r1, [r4, #2864]
	str	r1, [r6, #384]
	ldrb	r1, [r4, #2833]
	str	r1, [r6, #388]
	ldrb	r1, [r4, #2832]
	str	r1, [r6, #392]
	ldr	r1, [r4, #2872]
	str	r1, [r6, #468]
	ldr	r1, [r4, #2880]
	str	r1, [r6, #472]
	ldr	r1, [r4, #2884]
	str	r1, [r6, #480]
	ldr	r1, [r4, #2888]
	str	r1, [r6, #476]
.L467:
	ldrh	r1, [r3, #2]!
	cmp	r3, r0
	strh	r1, [r2, #2]!
	bne	.L467
	ldr	r3, [r4, #3076]
	str	r3, [r6, #484]
	ldr	r3, [r4, #3088]
	str	r3, [r6, #492]
	ldr	r3, [r4, #3084]
	str	r3, [r6, #488]
	ldr	r3, [r4, #2704]
	ldr	r0, [r5, #4]
	ldrb	r3, [r3, #1]
	cmp	r3, #2
	ldr	r3, [r4, #2708]
	ldr	r1, [r3, #4]
	beq	.L530
	bl	FSP_GetFsImagePtr
	subs	ip, r0, #0
	beq	.L531
	ldr	r3, [r4, #2708]
	ldrb	r2, [r3]
	cmp	r2, #1
	moveq	r2, #3
	movne	r2, #1
	str	r2, [r6, #396]
	ldrsb	r2, [r3, #2]
	str	r2, [r6, #400]
	ldr	r2, [ip, #44]
	str	r2, [r6, #420]
	ldrb	r2, [r3]
	cmp	r2, #1
	moveq	r2, #3
	movne	r2, #1
	str	r2, [r6, #412]
	ldrsb	r3, [r3, #2]
	str	r3, [r6, #416]
	ldr	r3, [ip, #44]
	str	r3, [r6, #424]
	ldr	r3, [r4, #2712]
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_GetFsImagePtr
	subs	ip, r0, #0
	ldrne	r3, [r4, #2712]
	beq	.L532
.L525:
	ldrb	r2, [r3]
	cmp	r2, #1
	moveq	r2, #3
	movne	r2, #1
	str	r2, [r6, #404]
	ldrsb	r3, [r3, #2]
	str	r3, [r6, #408]
	ldr	r3, [ip, #44]
	str	r3, [r6, #428]
	ldr	r3, [r4, #2708]
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_GetFsImagePtr
	subs	ip, r0, #0
	beq	.L533
	ldr	r3, [ip, #96]
	str	r3, [r6, #300]
	ldr	r3, [r4, #2712]
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_GetFsImagePtr
	subs	ip, r0, #0
	beq	.L534
	ldr	r3, [ip, #96]
	str	r3, [r6, #304]
	ldr	r3, [r4, #2716]
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_GetFsImagePtr
	subs	ip, r0, #0
	beq	.L535
	ldr	r3, [ip, #96]
	str	r3, [r6, #308]
	ldr	r3, [r4, #2704]
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_GetFsImagePtr
	subs	ip, r0, #0
	beq	.L536
	ldr	r3, [ip, #96]
	str	r3, [r6, #312]
	ldr	r3, [ip, #44]
	str	r3, [r6, #316]
	ldr	r3, [ip, #60]
	str	r3, [r6, #432]
	ldr	r3, [r4, #2708]
	ldrb	r2, [r3]
	cmp	r2, #1
	moveq	r2, #3
	movne	r2, #1
	str	r2, [r6, #436]
	ldrb	r3, [r3, #1]
	adds	r3, r3, #0
	movne	r3, #1
	str	r3, [r6, #440]
	ldr	r3, [r4, #2704]
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_GetPmvAddr
	str	r0, [r6, #496]
	ldr	r3, [r4, #2708]
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_GetPmvAddr
	add	ip, r5, #15424
	add	ip, ip, #44
	mov	r2, #0
	str	r0, [r6, #508]
	add	r0, r5, #16640
	ldr	r3, [r4, #3092]
	add	r0, r0, #252
	cmp	r3, #2
	movne	r1, #0
	moveq	r1, #4
	moveq	lr, #8
	moveq	r7, #16
	movne	r7, #32
	movne	lr, r1
.L488:
	add	r2, r2, #1
	ldr	r3, [ip, #4]!
	cmp	r2, r7
	ubfx	r3, r3, #0, #18
	str	r3, [r0, #4]!
	blt	.L488
	cmp	lr, #0
	ble	.L493
	add	ip, r5, #15552
	add	r0, r5, #16896
	add	ip, ip, #44
	add	r0, r0, #60
	mov	r2, #0
.L492:
	add	r2, r2, #1
	ldr	r3, [ip, #4]!
	cmp	r2, lr
	ubfx	r3, r3, #0, #15
	str	r3, [r0, #4]!
	bne	.L492
.L493:
	cmp	r1, #0
	ble	.L491
	add	r0, r5, #15616
	add	lr, r5, #16896
	add	r0, r0, #32
	add	lr, lr, #92
	mov	ip, #0
.L494:
	ldr	r2, [r0, #4]
	add	ip, ip, #1
	ldr	r3, [r0], #8
	cmp	ip, r1
	ubfx	r2, r2, #0, #9
	ubfx	r3, r3, #0, #9
	orr	r3, r3, r2, asl #9
	str	r3, [lr, #4]!
	bne	.L494
	add	r0, r5, #15616
	add	r5, r5, #16896
	add	r0, r0, #12
	add	r5, r5, #108
	mov	r2, #0
.L495:
	add	r2, r2, #1
	ldr	r3, [r0, #4]!
	cmp	r2, r1
	ubfx	r3, r3, #0, #18
	str	r3, [r5, #4]!
	bne	.L495
.L491:
	ldr	r3, [r4, #3140]
	mov	r7, #1
	mov	r0, r7
	str	r3, [r6, #640]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L528:
	ldr	r1, .L539+12
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r7
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L526:
	ldr	r3, [r5, #8]
	cmp	r3, #0
	bne	.L458
.L523:
	mov	r0, r7
	bl	ResetVoQueue
	b	.L458
.L530:
	bl	FSP_GetFsImagePtr
	subs	ip, r0, #0
	beq	.L537
	ldr	r3, [r4, #2708]
	ldrb	r2, [r3]
	cmp	r2, #1
	moveq	r2, #3
	movne	r2, #1
	str	r2, [r6, #396]
	ldrsb	r3, [r3, #2]
	str	r3, [r6, #400]
	ldr	r3, [ip, #44]
	str	r3, [r6, #420]
	ldr	r3, [r4, #2712]
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_GetFsImagePtr
	subs	ip, r0, #0
	beq	.L538
	ldr	r3, [r4, #2712]
	ldrb	r2, [r3]
	cmp	r2, #1
	moveq	r2, #3
	movne	r2, #1
	str	r2, [r6, #412]
	ldrsb	r3, [r3, #2]
	str	r3, [r6, #416]
	ldr	r3, [ip, #44]
	str	r3, [r6, #424]
	ldr	r3, [r4, #2716]
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_GetFsImagePtr
	subs	ip, r0, #0
	ldrne	r3, [r4, #2716]
	bne	.L525
	movw	r2, #1964
	ldr	r1, .L539+16
	mov	r7, ip
	bl	dprint_vfmw
	b	.L453
.L527:
	ldr	r1, .L539+20
	mov	r0, #1
	mov	r7, ip
	bl	dprint_vfmw
	b	.L453
.L529:
	movw	r2, #1857
	ldr	r1, .L539+16
	mov	r7, ip
	bl	dprint_vfmw
	b	.L453
.L538:
	movw	r2, #1958
	ldr	r1, .L539+16
	mov	r7, ip
	bl	dprint_vfmw
	b	.L453
.L521:
	ldr	r3, [r4, #2704]
	mov	r2, #1
	ldr	r0, [r5, #4]
	add	r6, r5, #14912
	add	r6, r6, #4
	ldr	r1, [r3, #4]
	bl	FSP_SetRef
	ldr	r3, [r4, #2716]
	add	r2, r6, #4
	cmp	r3, r2
	beq	.L465
	mov	r2, r7
	ldr	r1, [r3, #4]
	ldr	r0, [r5, #4]
	bl	FSP_SetRef
.L465:
	ldr	r1, [r4, #2712]
	ldr	r2, [r4, #2708]
	ldr	r3, [r4, #2704]
	str	r1, [r4, #2716]
	str	r2, [r4, #2712]
	str	r3, [r4, #2708]
	b	.L464
.L533:
	movw	r2, #1988
	ldr	r1, .L539+16
	mov	r7, ip
	bl	dprint_vfmw
	b	.L453
.L534:
	movw	r2, #1992
	ldr	r1, .L539+16
	mov	r7, ip
	bl	dprint_vfmw
	b	.L453
.L535:
	movw	r2, #1996
	ldr	r1, .L539+16
	mov	r7, ip
	bl	dprint_vfmw
	b	.L453
.L531:
	movw	r2, #1972
	ldr	r1, .L539+16
	mov	r7, ip
	bl	dprint_vfmw
	b	.L453
.L532:
	movw	r2, #1981
	ldr	r1, .L539+16
	mov	r7, ip
	bl	dprint_vfmw
	b	.L453
.L536:
	mov	r2, #2000
	ldr	r1, .L539+16
	mov	r7, ip
	bl	dprint_vfmw
	b	.L453
.L537:
	mov	r2, #1952
	ldr	r1, .L539+16
	mov	r7, ip
	bl	dprint_vfmw
	b	.L453
.L540:
	.align	2
.L539:
	.word	.LC99
	.word	.LC100
	.word	.LC103
	.word	.LC102
	.word	.LC97
	.word	.LC101
	.fnend
	.size	AVS_GetStreamInf, .-AVS_GetStreamInf
	.align	2
	.global	AVS_PrepareDecode
	.type	AVS_PrepareDecode, %function
AVS_PrepareDecode:
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
	bl	AVS_GetStreamInf
	cmp	r0, #3
	ldmeqfd	sp, {fp, sp, pc}
	adds	r0, r0, #0
	movne	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	AVS_PrepareDecode, .-AVS_PrepareDecode
	.align	2
	.global	AVS_VerifyMemPara
	.type	AVS_VerifyMemPara, %function
AVS_VerifyMemPara:
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
	.size	AVS_VerifyMemPara, .-AVS_VerifyMemPara
	.align	2
	.global	AVSDEC_Init
	.type	AVSDEC_Init, %function
AVSDEC_Init:
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
	add	r6, r0, #16384
	ldr	r8, .L549
	add	r7, r0, #16128
	ldr	r10, [r6, #88]
	movw	r2, #17160
	mov	r9, r1
	mov	r1, #0
	ldr	r3, [r8, #48]
	mov	r4, r0
	add	r5, r0, #14912
	blx	r3
	str	r10, [r6, #88]
	mov	r0, r7
	bl	ResetVoQueue
	str	r9, [r4, #12]
	mov	r0, r4
	add	r6, r4, #15680
	bl	VCTRL_GetChanIDByCtx
	add	r5, r5, #4
	add	r6, r6, #44
	cmn	r0, #1
	str	r0, [r4, #4]
	beq	.L548
	ldr	r3, [r8, #48]
	mov	r2, #808
	mov	r1, #0
	mov	r0, r5
	blx	r3
	add	r3, r4, #12288
	add	r5, r5, #4
	mov	r1, #1024
	str	r5, [r3, #2704]
	mov	r2, #0
	str	r6, [r3, #3120]
	mov	r0, #1
	str	r5, [r3, #2716]
	str	r5, [r3, #2712]
	str	r5, [r3, #2708]
	str	r7, [r3, #3148]
	str	r1, [r3, #3144]
	ldr	r3, [r4, #12]
	str	r2, [r3, #864]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L548:
	ldr	r1, .L549+4
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #19
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L550:
	.align	2
.L549:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC104
	.fnend
	.size	AVSDEC_Init, .-AVSDEC_Init
	.align	2
	.global	AVSDEC_Destroy
	.type	AVSDEC_Destroy, %function
AVSDEC_Destroy:
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
	.size	AVSDEC_Destroy, .-AVSDEC_Destroy
	.align	2
	.global	AVSDEC_RecycleImage
	.type	AVSDEC_RecycleImage, %function
AVSDEC_RecycleImage:
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
	subs	r4, r0, #0
	mov	r5, r1
	beq	.L554
	mov	r2, #0
	ldr	r0, [r4, #4]
	bl	FSP_SetDisplay
	mov	r1, r5
	ldr	r0, [r4, #4]
	bl	FSP_GetFsImagePtr
	cmp	r0, #0
	beq	.L555
	add	r5, r0, #544
	add	r8, r0, #528
	ldr	r1, [r0, #528]
	mov	r6, #0
	ldr	r0, [r4, #4]
	mov	r7, #0
	bl	FreeUsdByDec
	strd	r6, [r8]
	ldr	r0, [r4, #4]
	ldr	r1, [r5, #-8]
	bl	FreeUsdByDec
	strd	r6, [r5, #-8]
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L554:
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L555:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	AVSDEC_RecycleImage, .-AVSDEC_RecycleImage
	.align	2
	.global	AVSDEC_GetRemainImg
	.type	AVSDEC_GetRemainImg, %function
AVSDEC_GetRemainImg:
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
	ldr	r3, [r0, #12]
	mov	r4, r0
	ldr	r3, [r3, #12]
	cmp	r3, #1
	beq	.L563
	add	r10, r0, #14976
	mov	r8, #0
	add	r10, r10, #32
	mov	r9, #0
	mov	r5, #3
	mvn	r6, #0
.L562:
	ldr	r3, [r10, #-4]!
	ldr	r0, [r4, #4]
	ldr	r1, [r3, #4]
	bl	FSP_GetFsImagePtr
	subs	r7, r0, #0
	beq	.L559
	ldr	r3, [r10]
	ldr	r0, [r4, #4]
	ldr	r1, [r3, #4]
	bl	FSP_GetDisplay
	cmp	r0, #2
	movne	r6, #1
	beq	.L571
.L559:
	subs	r5, r5, #1
	bne	.L562
	cmp	r6, #0
	bne	.L563
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L563:
	add	r0, r4, #16128
	bl	GetVoLastImageID
	mov	r6, r0
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L571:
	mov	r0, r4
	bl	AVS_SetImgFormat
	cmp	r5, #1
	streq	r5, [r7, #188]
	mov	r2, #1
	ldr	r3, [r10]
	ldr	r0, [r4, #4]
	ldr	r1, [r3, #4]
	bl	FSP_SetDisplay
	ldr	r0, [r4, #4]
	add	r3, r4, #16128
	str	r7, [sp]
	mov	r2, r4
	mov	r1, #6
	bl	InsertImgToVoQueue
	cmp	r0, #1
	beq	.L561
	ldr	r1, [r7, #156]
	mov	r0, r4
	add	r3, r7, #528
	str	r3, [fp, #-52]
	add	r3, r7, #544
	str	r3, [fp, #-48]
	bl	AVSDEC_RecycleImage
	ldr	r1, [r7, #528]
	ldr	r0, [r4, #4]
	mvn	r6, #0
	bl	FreeUsdByDec
	ldr	r7, [fp, #-48]
	ldr	r3, [fp, #-52]
	strd	r8, [r3]
	ldr	r1, [r7, #-8]
	ldr	r0, [r4, #4]
	bl	FreeUsdByDec
	strd	r8, [r7, #-8]
	b	.L559
.L561:
	ldr	r3, [r7, #160]
	cmp	r3, #100
	bhi	.L566
	ldr	r3, [r7, #112]
	cmp	r3, #31
	bhi	.L572
.L566:
	mvn	r6, #0
	b	.L559
.L572:
	ldr	r6, [r7, #116]
	cmp	r6, #31
	movhi	r6, #0
	mvnls	r6, #0
	b	.L559
	.fnend
	.size	AVSDEC_GetRemainImg, .-AVSDEC_GetRemainImg
	.align	2
	.global	AVSDEC_GetImageBuffer
	.type	AVSDEC_GetImageBuffer, %function
AVSDEC_GetImageBuffer:
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
	ldr	r0, [r0, #4]
	bl	FSP_IsNewFsAvalible
	cmp	r0, #1
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r0, [r4, #4]
	bl	FSP_IsNewFsAvalible
	cmn	r0, #1
	beq	.L579
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L579:
	add	r1, r4, #16128
	ldr	r0, [r4, #4]
	bl	FSP_ClearNotInVoQueue
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	AVSDEC_GetImageBuffer, .-AVSDEC_GetImageBuffer
	.align	2
	.global	ClearSlice
	.type	ClearSlice, %function
ClearSlice:
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
	add	r4, r1, #4
	add	r8, r1, #12
	mov	r7, r1
	mov	r9, r0
	mov	r6, r1
	mov	r5, #0
.L582:
	ldr	r3, [r4, #4]!
	cmp	r3, #0
	ble	.L581
	ldr	r3, [r6]
	cmp	r3, #0
	bne	.L587
.L581:
	cmp	r4, r8
	str	r5, [r4]
	str	r5, [r6], #4
	str	r5, [r7, #16]
	bne	.L582
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L587:
	ldr	r1, [r4, #12]
	mov	r0, r9
	bl	SM_ReleaseStreamSeg
	b	.L581
	.fnend
	.size	ClearSlice, .-ClearSlice
	.align	2
	.global	AVS_ClearCurPic
	.type	AVS_ClearCurPic, %function
AVS_ClearCurPic:
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
	add	r6, r0, #12288
	mov	r7, r0
	ldr	r3, [r6, #2164]
	cmp	r3, #0
	ble	.L591
	add	r5, r0, #116
	mov	r4, #0
.L590:
	mov	r1, r5
	ldr	r0, [r7, #4]
	bl	ClearSlice
	ldr	r3, [r6, #2164]
	add	r4, r4, #1
	add	r5, r5, #28
	cmp	r3, r4
	bgt	.L590
.L591:
	mov	r3, #0
	mov	r0, #1
	str	r3, [r6, #2164]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	AVS_ClearCurPic, .-AVS_ClearCurPic
	.align	2
	.type	AVS_DecodeArbiter.part.3, %function
AVS_DecodeArbiter.part.3:
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
	ldr	r3, [r0, #12]
	mov	r6, r0
	add	r4, r0, #12288
	ldr	r3, [r3, #8]
	cmp	r3, #4
	ldrls	pc, [pc, r3, asl #2]
	b	.L609
.L597:
	.word	.L596
	.word	.L598
	.word	.L599
	.word	.L609
	.word	.L596
.L599:
	ldr	r5, [r4, #3812]
	clz	r5, r5
	mov	r5, r5, lsr #5
.L595:
	cmp	r5, #0
	str	r3, [r4, #3392]
	beq	.L615
.L602:
	ldr	r3, [r4, #3812]
	cmp	r3, #1
	beq	.L616
.L605:
	cmp	r3, #2
	bne	.L607
	ldr	r3, [r4, #3396]
	cmp	r3, #1
	ble	.L606
.L607:
	add	r1, r4, #3456
	add	r0, r4, #2736
	add	r1, r1, #12
	mov	r2, #372
	add	r0, r0, #12
	bl	memcpy
	ldrb	ip, [r4, #2825]
	ldr	r3, [r4, #3092]
	mov	r0, #18
	ldr	r2, [r4, #3408]
	ldr	r1, .L617
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [r4, #2732]
	mov	r0, #1
	bic	r3, r3, #311296
	str	r3, [r4, #2732]
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L598:
	ldr	r2, [r4, #3392]
	ldr	r5, [r4, #3812]
	cmp	r2, #2
	str	r3, [r4, #3392]
	moveq	r2, #0
	streq	r2, [r4, #3396]
	subs	r5, r5, #2
	movne	r5, #1
	cmp	r5, #0
	bne	.L602
.L615:
	mov	r0, r6
	bl	AVS_ClearCurPic
	ldr	r2, .L617+4
	ldr	r3, [r4, #2732]
	ldr	ip, [r2]
	bic	r3, r3, #311296
	str	r3, [r4, #2732]
	cmp	ip, #0
	beq	.L614
	ldr	r0, [r6, #4]
	mov	r3, r5
	mov	r2, r5
	mov	r1, #113
	blx	ip
	mov	r0, r5
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L596:
	ldr	r2, [r4, #3392]
	str	r3, [r4, #3392]
	cmp	r2, #2
	ldr	r3, [r4, #3812]
	moveq	r2, #0
	streq	r2, [r4, #3396]
	cmp	r3, #1
	bne	.L605
.L616:
	ldr	r3, [r4, #3396]
	cmp	r3, #0
	bgt	.L607
.L606:
	mov	r0, r6
	bl	AVS_ClearCurPic
	ldr	r2, .L617+4
	ldr	r3, [r4, #2732]
	ldr	ip, [r2]
	bic	r3, r3, #311296
	str	r3, [r4, #2732]
	cmp	ip, #0
	beq	.L614
	mov	r3, #0
	ldr	r0, [r6, #4]
	mov	r2, r3
	mov	r1, #113
	blx	ip
.L614:
	mov	r0, #0
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L609:
	mov	r5, #1
	b	.L595
.L618:
	.align	2
.L617:
	.word	.LC105
	.word	g_event_report
	.fnend
	.size	AVS_DecodeArbiter.part.3, .-AVS_DecodeArbiter.part.3
	.align	2
	.global	AVS_DecodeArbiter
	.type	AVS_DecodeArbiter, %function
AVS_DecodeArbiter:
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
	add	r3, r0, #12288
	ldr	r3, [r3, #2732]
	and	r3, r3, #376832
	cmp	r3, #376832
	beq	.L622
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L622:
	bl	AVS_DecodeArbiter.part.3
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	AVS_DecodeArbiter, .-AVS_DecodeArbiter
	.align	2
	.global	AVSDEC_VDMPostProc
	.type	AVSDEC_VDMPostProc, %function
AVSDEC_VDMPostProc:
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
	mov	r5, r0
	mov	r6, r1
	bl	AVS_ClearCurPic
	ldr	r3, .L682
	add	r4, r5, #12288
	add	r0, r5, #20
	movw	r2, #14896
	mov	r1, #0
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r3, [r4, #3092]
	cmp	r3, #0
	bne	.L624
	str	r6, [r4, #3400]
	ldr	r3, [r5, #12]
	ldr	r2, [r4, #3400]
	ldr	r3, [r3]
	cmp	r3, r2
	blt	.L673
.L629:
	mov	r0, r5
	bl	AVS_SetImgFormat
	ldr	r3, [r4, #2704]
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_GetFsImagePtr
	subs	r3, r0, #0
	beq	.L674
	ldr	r1, [r4, #3412]
	mov	r2, #0
	cmp	r1, #0
	strne	r1, [r3, #528]
	movne	r1, #0
	strne	r1, [r3, #532]
	ldr	r1, [r4, #3416]
	str	r2, [r4, #3412]
	cmp	r1, r2
	strne	r2, [r3, #540]
	strne	r1, [r3, #536]
	mov	r2, #0
	ldr	r3, [r4, #3092]
	str	r2, [r4, #3416]
	cmp	r3, #1
	bls	.L675
.L634:
	ldr	r7, [r4, #2704]
.L639:
	ldr	r1, [r7, #4]
	ldr	r0, [r5, #4]
	bl	FSP_GetFsImagePtr
	subs	r6, r0, #0
	beq	.L676
	add	r3, r5, #14912
	add	r3, r3, #8
	cmp	r7, r3
	beq	.L644
	ldr	r3, [r5, #12]
	ldr	r2, [r4, #3400]
	ldr	r3, [r3, #4]
	cmp	r3, r2
	bge	.L642
	ldr	r1, .L682+4
	mov	r0, #1
	add	r4, r6, #528
	bl	dprint_vfmw
	ldr	r1, [r7, #4]
	mov	r2, #0
	ldr	r0, [r5, #4]
	bl	FSP_SetDisplay
	ldrd	r2, [r4]
	orrs	r1, r2, r3
	bne	.L677
.L643:
	add	r6, r6, #544
	ldrd	r2, [r6, #-8]
	orrs	r1, r2, r3
	bne	.L678
.L644:
	mov	r4, #1
.L627:
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L642:
	mov	r0, r7
	mov	r1, r5
	bl	AVS_OutputOneFrame
	subs	r4, r0, #0
	bne	.L644
	add	r7, r6, #528
	ldrd	r2, [r7]
	orrs	r1, r2, r3
	bne	.L679
.L645:
	add	r6, r6, #544
	ldrd	r2, [r6, #-8]
	orrs	r1, r2, r3
	beq	.L627
	mov	r1, r2
	ldr	r0, [r5, #4]
	bl	FreeUsdByDec
	mov	r2, #0
	mov	r3, #0
	strd	r2, [r6, #-8]
	b	.L627
.L624:
	ldr	r3, [r4, #2708]
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_GetFsImagePtr
	subs	r3, r0, #0
	beq	.L680
	ldr	r2, [r4, #2712]
	ldr	r0, [r5, #4]
	ldr	r7, [r3, #160]
	ldr	r1, [r2, #4]
	bl	FSP_GetFsImagePtr
	subs	ip, r0, #0
	beq	.L681
	ldr	r1, [ip, #160]
	ldr	r2, [r4, #3092]
	add	r3, r7, r1
	add	r1, r6, r3
	cmp	r1, #100
	movge	r1, #100
	str	r1, [r4, #3400]
	ldr	r3, [r5, #12]
	cmp	r2, #2
	ldr	r3, [r3]
	beq	.L629
	ldr	r2, [r4, #3400]
	cmp	r3, r2
	bge	.L629
.L673:
	ldr	r1, .L682+8
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r4, #2708]
	mov	r2, #0
	str	r2, [r4, #3396]
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_GetFsImagePtr
	subs	r6, r0, #0
	beq	.L630
	ldr	r3, [r4, #2704]
	mov	r2, #1
	ldr	r0, [r5, #4]
	add	r8, r6, #544
	add	r7, r6, #560
	add	r9, r6, #528
	ldr	r1, [r3, #4]
	bl	FSP_ClearLogicFs
	ldr	r3, [r4, #2708]
	mov	r2, #1
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_ClearLogicFs
	ldr	r3, [r4, #2712]
	mov	r2, #1
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_ClearLogicFs
	ldr	r3, [r4, #2716]
	mov	r2, #1
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_ClearLogicFs
	ldr	r1, [r6, #528]
	ldr	r0, [r5, #4]
	bl	FreeUsdByDec
	ldr	r1, [r6, #536]
	ldr	r0, [r5, #4]
	bl	FreeUsdByDec
	ldr	r1, [r6, #544]
	ldr	r0, [r5, #4]
	bl	FreeUsdByDec
	ldr	r1, [r6, #552]
	ldr	r0, [r5, #4]
	bl	FreeUsdByDec
	add	r3, r5, #14912
	mov	r0, #0
	mov	r1, #0
	add	r3, r3, #8
	strd	r0, [r9]
	strd	r0, [r8, #-8]
	strd	r0, [r8]
	strd	r0, [r7, #-8]
	str	r3, [r4, #2704]
	str	r3, [r4, #2716]
	str	r3, [r4, #2712]
	str	r3, [r4, #2708]
	ldr	r0, [r5, #4]
	bl	FSP_GetNullLogicFs
	str	r0, [r4, #2636]
.L630:
	mov	r3, #0
	str	r3, [r4, #3396]
	mov	r4, r3
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L675:
	ldr	r2, [r4, #3396]
	ldrb	r1, [r4, #2825]
	cmp	r2, #1
	addle	r2, r2, #1
	adds	r3, r3, #0
	str	r2, [r4, #3396]
	movne	r3, #1
	cmp	r1, #1
	orreq	r3, r3, #1
	cmp	r3, #0
	beq	.L636
	ldr	r3, [r4, #2704]
	mov	r2, #1
	ldr	r0, [r5, #4]
	ldr	r1, [r3, #4]
	bl	FSP_SetRef
	add	r3, r5, #14912
	ldr	r2, [r4, #2716]
	add	r3, r3, #8
	cmp	r2, r3
	beq	.L637
	ldr	r1, [r2, #4]
	mov	r2, #0
	ldr	r0, [r5, #4]
	bl	FSP_SetRef
.L637:
	ldr	r1, [r4, #2712]
	ldr	r2, [r4, #2708]
	ldr	r3, [r4, #2704]
	str	r1, [r4, #2716]
	str	r2, [r4, #2712]
	str	r3, [r4, #2708]
.L636:
	ldr	r3, [r5, #12]
	ldr	r3, [r3, #12]
	cmp	r3, #0
	ldreq	r7, [r4, #2712]
	beq	.L639
	b	.L634
.L678:
	mov	r1, r2
	ldr	r0, [r5, #4]
	bl	FreeUsdByDec
	mov	r4, #1
	mov	r2, #0
	mov	r3, #0
	strd	r2, [r6, #-8]
	b	.L627
.L677:
	mov	r1, r2
	ldr	r0, [r5, #4]
	bl	FreeUsdByDec
	mov	r2, #0
	mov	r3, #0
	strd	r2, [r4]
	b	.L643
.L679:
	mov	r1, r2
	ldr	r0, [r5, #4]
	bl	FreeUsdByDec
	mov	r2, #0
	mov	r3, #0
	strd	r2, [r7]
	b	.L645
.L674:
	movw	r2, #3271
	ldr	r1, .L682+12
	mov	r4, r3
	bl	dprint_vfmw
	b	.L627
.L676:
	movw	r2, #3311
	ldr	r1, .L682+12
	mov	r4, r6
	bl	dprint_vfmw
	b	.L627
.L680:
	movw	r2, #3246
	ldr	r1, .L682+12
	mov	r4, r3
	bl	dprint_vfmw
	b	.L627
.L681:
	movw	r2, #3250
	ldr	r1, .L682+12
	mov	r4, ip
	bl	dprint_vfmw
	b	.L627
.L683:
	.align	2
.L682:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC107
	.word	.LC106
	.word	.LC97
	.fnend
	.size	AVSDEC_VDMPostProc, .-AVSDEC_VDMPostProc
	.align	2
	.global	ClearPacket
	.type	ClearPacket, %function
ClearPacket:
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
	add	r4, r0, #16384
	mov	r5, r0
	ldr	r0, [r0, #4]
	ldr	r1, [r4, #120]
	bl	SM_ReleaseStreamSeg
	ldrb	r3, [r4, #109]
	cmp	r3, #0
	bne	.L685
	ldrb	r3, [r4, #189]
	cmp	r3, #1
	beq	.L689
.L685:
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L689:
	ldr	r3, [r4, #192]
	cmp	r3, #0
	beq	.L685
	ldr	r1, [r4, #200]
	ldr	r0, [r5, #4]
	bl	SM_ReleaseStreamSeg
	b	.L685
	.fnend
	.size	ClearPacket, .-ClearPacket
	.align	2
	.global	WriteAvsSliceMsg
	.type	WriteAvsSliceMsg, %function
WriteAvsSliceMsg:
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
	add	r5, r0, #12288
	mov	r4, r0
	ldr	r2, [r5, #2164]
	cmp	r2, #512
	bge	.L698
	cmp	r2, #0
	ble	.L693
	add	lr, r0, #16384
	sub	r3, r2, #1
	ldr	r1, [r5, #3492]
	ldr	ip, [lr, #104]
	mov	r0, r3, asl #5
	add	r1, r1, #15
	sub	r3, r0, r3, asl #2
	add	r3, r4, r3
	ldrb	r0, [ip, #3]
	mov	r1, r1, lsr #4
	ldr	r3, [r3, #132]
	mul	r0, r0, r1
	cmp	r0, r3
	bls	.L699
.L694:
	mov	r0, r2, asl #5
	ldr	r3, [lr, #112]
	sub	r0, r0, r2, asl #2
	add	r0, r4, r0
	str	r3, [r0, #116]
	ldr	r3, [lr, #120]
	str	r3, [r0, #136]
	ldr	r3, [lr, #116]
	str	r3, [r0, #124]
	ldrb	r3, [ip, #3]
	mul	r1, r1, r3
	str	r1, [r0, #132]
	ldr	r3, [r5, #2772]
	ldr	r4, [r5, #2776]
	add	ip, r3, #15
	add	r4, r4, #15
	mov	r3, ip, lsr #4
	mov	r4, r4, lsr #4
	mul	r3, r3, r4
	sub	r3, r3, #1
	cmp	r1, r3
	bhi	.L697
	ldrb	r3, [lr, #109]
	add	r2, r2, #1
	cmp	r3, #1
	ldrne	r3, [lr, #192]
	moveq	r3, #0
	streq	r3, [r0, #120]
	streq	r3, [r0, #140]
	strne	r3, [r0, #120]
	ldrne	r3, [lr, #200]
	strne	r3, [r0, #140]
	ldrne	r3, [lr, #196]
	str	r3, [r0, #128]
	mov	r0, #1
	str	r2, [r5, #2164]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L697:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L693:
	ldr	r1, [r5, #3492]
	add	lr, r0, #16384
	add	r1, r1, #15
	ldr	ip, [lr, #104]
	mov	r1, r1, lsr #4
	b	.L694
.L698:
	mov	r3, #512
	ldr	r1, .L700
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L699:
	mov	r2, r0
	ldr	r1, .L700+4
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	bl	ClearPacket
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L701:
	.align	2
.L700:
	.word	.LC108
	.word	.LC109
	.fnend
	.size	WriteAvsSliceMsg, .-WriteAvsSliceMsg
	.align	2
	.global	AVS_GetPacketState
	.type	AVS_GetPacketState, %function
AVS_GetPacketState:
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
	add	r0, r0, #16384
	ldr	r0, [r0, #96]
	subs	r0, r0, #1
	movne	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	AVS_GetPacketState, .-AVS_GetPacketState
	.align	2
	.global	Avs_Vfmw_WQMatrix
	.type	Avs_Vfmw_WQMatrix, %function
Avs_Vfmw_WQMatrix:
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
	ldr	r8, [r0, #144]
	mov	r3, #0
	ldr	lr, [r0, #128]
	cmp	r8, #1
	str	r3, [fp, #-348]
	str	r3, [fp, #-344]
	str	r3, [fp, #-340]
	str	r3, [fp, #-336]
	str	r3, [fp, #-332]
	str	r3, [fp, #-328]
	beq	.L706
	clz	r3, lr
	cmp	r8, #3
	cmpeq	lr, #0
	mov	r3, r3, lsr #5
	beq	.L706
	cmp	r8, #2
	addeq	r3, r0, #172
	beq	.L708
	cmp	r3, #0
	bne	.L740
.L741:
	sub	r4, fp, #324
	cmp	r8, #0
	mov	r3, #128
	strh	r3, [r4]
	strh	r3, [r4, #2]
	strh	r3, [r4, #4]
	strh	r3, [r4, #6]
	strh	r3, [r4, #8]
	strh	r3, [r4, #10]
	strh	r3, [r4, #12]
	strh	r3, [r4, #14]
	strh	r3, [r4, #16]
	strh	r3, [r4, #18]
	strh	r3, [r4, #20]
	strh	r3, [r4, #22]
	bne	.L790
	ldr	r3, .L796
	add	r2, r4, #10
	add	ip, r3, #12
.L722:
	ldrh	r1, [r3, #2]!
	cmp	r3, ip
	strh	r1, [r2, #2]!
	bne	.L722
.L715:
	add	ip, r0, #198
	add	lr, r0, #324
	add	lr, lr, #2
	mov	r2, #128
	mov	r3, ip
.L726:
	strh	r2, [r3, #2]!
	cmp	r3, lr
	bne	.L726
	ldr	r3, [r0, #124]
	cmp	r3, #0
	beq	.L743
	ldr	r10, [r0, #148]
	mov	r9, #0
	ldr	r3, .L796+4
	mov	r10, r10, asl #6
	add	r7, r10, #64
	add	r10, r3, r10
	add	r7, r3, r7
.L744:
	sub	r3, fp, #300
	mov	r5, r9, asl #3
	add	r6, r3, r9, lsl #7
	sub	r5, r5, r9, asl #1
	sub	r6, r6, #2
	mov	r2, r10
.L734:
	add	r0, r2, #8
	mov	r1, r6
.L732:
	ldrb	r3, [r2], #1
	add	r3, r5, r3
	cmp	r0, r2
	mov	r3, r3, asl #1
	ldrh	r3, [r4, r3]
	strh	r3, [r1, #2]!
	bne	.L732
	cmp	r0, r7
	add	r6, r6, #16
	mov	r2, r0
	bne	.L734
	add	r9, r9, #1
	cmp	r9, #2
	bne	.L744
.L730:
	cmp	r8, #0
	subeq	r3, fp, #174
	subeq	r1, fp, #46
	beq	.L735
	cmp	r8, #1
	beq	.L791
	cmp	r8, #2
	beq	.L792
.L703:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L706:
	ldr	r4, .L796+8
	add	r1, r0, #148
	sub	ip, fp, #348
	add	r3, r0, #172
.L705:
	ldr	r5, [r1, #4]!
	ldrh	r2, [r4], #2
	cmp	r1, r3
	add	r2, r2, r5
	strh	r2, [ip], #2
	bne	.L705
	cmp	r8, #2
	beq	.L708
	cmp	lr, #0
	cmpeq	r8, #3
	bne	.L709
.L708:
	ldr	ip, .L796
	sub	r1, fp, #336
	add	r5, r0, #196
.L710:
	ldr	r4, [r3, #4]!
	ldrh	r2, [ip, #2]!
	cmp	r3, r5
	add	r2, r2, r4
	strh	r2, [r1], #2
	bne	.L710
.L709:
	cmp	lr, #0
	bne	.L741
.L740:
	ldr	r3, .L796+8
	sub	r4, fp, #324
	add	ip, r3, #12
	mov	r5, r4
	mov	r2, r4
.L713:
	ldrh	r1, [r3], #2
	cmp	r3, ip
	strh	r1, [r2], #2
	bne	.L713
	ldr	r3, .L796
	add	lr, r4, #10
	add	ip, r3, #12
	mov	r2, lr
.L714:
	ldrh	r1, [r3, #2]!
	cmp	r3, ip
	strh	r1, [r2, #2]!
	bne	.L714
	cmp	r8, #0
	beq	.L715
	cmp	r8, #1
	beq	.L793
	cmp	r8, #2
	beq	.L794
	cmp	r8, #3
	bne	.L715
	sub	r3, fp, #348
	sub	r1, fp, #336
.L720:
	ldrh	r2, [r3], #2
	cmp	r3, r1
	strh	r2, [r5], #2
	bne	.L720
	add	r1, r4, #22
.L721:
	ldrh	r2, [r3], #2
	strh	r2, [lr, #2]!
	cmp	lr, r1
	bne	.L721
	b	.L715
.L735:
	ldrh	r2, [r3, #2]!
	cmp	r3, r1
	strh	r2, [ip, #2]!
	beq	.L703
	ldrh	r2, [r3, #2]!
	cmp	r3, r1
	strh	r2, [ip, #2]!
	bne	.L735
	b	.L703
.L743:
	sub	r0, fp, #174
	add	r4, fp, #82
	mov	r1, #128
.L745:
	sub	r3, r0, #128
.L731:
	add	r2, r3, #16
.L728:
	strh	r1, [r3, #2]!
	cmp	r2, r3
	bne	.L728
	cmp	r2, r0
	mov	r3, r2
	bne	.L731
	add	r0, r0, #128
	cmp	r0, r4
	bne	.L745
	b	.L730
.L790:
	cmp	r8, #1
	beq	.L795
	cmp	r8, #2
	bne	.L715
	sub	r2, fp, #336
	add	r3, r4, #10
	add	ip, r4, #22
.L725:
	ldrh	r1, [r2], #2
	strh	r1, [r3, #2]!
	cmp	r3, ip
	bne	.L725
	b	.L715
.L795:
	sub	r3, fp, #348
	sub	ip, fp, #336
	mov	r2, r4
.L724:
	ldrh	r1, [r3], #2
	cmp	r3, ip
	strh	r1, [r2], #2
	bne	.L724
	b	.L715
.L793:
	sub	r3, fp, #348
	sub	r1, fp, #336
.L717:
	ldrh	r2, [r3], #2
	cmp	r3, r1
	strh	r2, [r5], #2
	bne	.L717
	b	.L715
.L792:
	sub	r3, fp, #174
	sub	r1, fp, #46
.L739:
	ldrh	r2, [r3, #2]!
	cmp	r3, r1
	strh	r2, [ip, #2]!
	bne	.L739
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L791:
	sub	r3, fp, #300
	sub	r3, r3, #2
.L737:
	ldrh	r2, [r3, #2]!
	strh	r2, [ip, #2]!
	cmp	lr, ip
	bne	.L737
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L794:
	sub	r3, fp, #336
	add	r1, r4, #22
.L719:
	ldrh	r2, [r3], #2
	strh	r2, [lr, #2]!
	cmp	lr, r1
	bne	.L719
	b	.L715
.L797:
	.align	2
.L796:
	.word	.LANCHOR1+10
	.word	.LANCHOR0+16
	.word	.LANCHOR1
	.fnend
	.size	Avs_Vfmw_WQMatrix, .-Avs_Vfmw_WQMatrix
	.align	2
	.global	AVS_ParseHeader
	.type	AVS_ParseHeader, %function
AVS_ParseHeader:
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
	add	r7, r0, #12288
	add	r8, r0, #16384
	mov	r3, #0
	ldr	r6, [r7, #3120]
	add	r9, r0, #14912
	str	r3, [r8, #96]
	add	r5, r0, #15744
	mov	r4, r0
	mov	r1, #32
	mov	r0, r6
	add	r9, r9, #4
	bl	BsShow
	add	r5, r5, #12
	uxtb	r0, r0
	sub	r3, r0, #176
	cmp	r3, #78
	ldrls	pc, [pc, r3, asl #2]
	b	.L799
.L801:
	.word	.L800
	.word	.L802
	.word	.L803
	.word	.L804
	.word	.L823
	.word	.L806
	.word	.L807
	.word	.L802
	.word	.L823
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L799
	.word	.L809
.L802:
	ldr	r3, [r7, #2732]
	ands	r5, r3, #32768
	bne	.L839
	tst	r3, #327680
	bne	.L847
.L842:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L799:
	cmp	r0, #175
	bhi	.L823
	ldr	r3, [r7, #2732]
	and	r2, r3, #327680
	cmp	r2, #327680
	beq	.L848
.L823:
	mov	r0, r4
	bl	ClearPacket
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L806:
	ldr	r3, [r7, #2732]
	tst	r3, #327680
	beq	.L818
	mov	r1, r5
	mov	r0, r9
	bl	AVS_extension
	mov	r0, r4
	bl	ClearPacket
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L803:
	ldr	r3, [r7, #2732]
	ands	r1, r3, #262144
	movne	r1, #1
	bne	.L841
	tst	r3, #65536
	beq	.L818
.L841:
	mov	r0, r4
	bl	AVS_user_data
	mov	r0, r4
	bl	ClearPacket
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L804:
	ldr	r3, [r7, #2732]
	ands	r6, r3, #32768
	bne	.L840
	tst	r3, #262144
	beq	.L814
	bic	r3, r3, #311296
	mov	r0, r9
	str	r3, [r7, #2732]
	mov	r1, r5
	bl	AVS_i_picture_header
	b	.L844
.L807:
	ldr	r3, [r7, #2732]
	ands	r6, r3, #32768
	bne	.L840
	tst	r3, #262144
	beq	.L816
	bic	r3, r3, #311296
	mov	r0, r9
	str	r3, [r7, #2732]
	mov	r1, r5
	bl	AVS_pb_picture_header
.L844:
	mov	r0, r5
	bl	Avs_Vfmw_WQMatrix
	mov	r0, r4
	bl	ClearPacket
	mov	r0, r6
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L809:
	mov	r1, #32
	mov	r0, r6
	bl	BsSkip
	mov	r1, #32
	mov	r0, r6
	bl	BsGet
	mov	r1, #32
	mov	r5, r0
	mov	r0, r6
	bl	BsGet
	movw	r2, #20036
	movw	r3, #20553
	movt	r2, 17221
	movt	r3, 18515
	cmp	r0, r2
	cmpeq	r5, r3
	bne	.L818
	mov	r5, #1
	strb	r5, [r4]
	str	r5, [r8, #96]
	mov	r0, r4
	ldr	r3, [r7, #2732]
	orr	r3, r3, #16384
	str	r3, [r7, #2732]
	bl	ClearPacket
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L800:
	ldr	r3, [r7, #2732]
	ands	r6, r3, #32768
	bne	.L839
	tst	r3, #65536
	beq	.L812
	bic	r3, r3, #311296
	mov	r1, r5
	str	r3, [r7, #2732]
	mov	r0, r4
	bl	AVS_sequence_header
	mov	r0, r4
	bl	ClearPacket
	mov	r0, r6
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L839:
	mov	r0, #1
	orr	r3, r3, #16384
	str	r0, [r8, #96]
	str	r3, [r7, #2732]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L848:
	orr	r3, r3, #32768
	mov	r0, r4
	str	r3, [r7, #2732]
	bl	WriteAvsSliceMsg
	cmp	r0, #0
	bne	.L842
.L818:
	mov	r0, r4
	bl	ClearPacket
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L816:
	mov	r0, r9
	mov	r1, r5
	bl	AVS_pb_picture_header
.L843:
	mov	r0, r5
	bl	Avs_Vfmw_WQMatrix
	mov	r0, r4
	bl	ClearPacket
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L814:
	mov	r0, r9
	mov	r1, r5
	bl	AVS_i_picture_header
	b	.L843
.L812:
	mov	r1, r5
	mov	r0, r4
	bl	AVS_sequence_header
	mov	r0, r4
	bl	ClearPacket
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L840:
	orr	r3, r3, #16384
	mov	r0, r5
	mov	r4, #1
	str	r4, [r8, #96]
	str	r3, [r7, #2732]
	bl	Avs_Vfmw_WQMatrix
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L847:
	bic	r3, r3, #311296
	mov	r0, r4
	str	r3, [r7, #2732]
	bl	ClearPacket
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	AVS_ParseHeader, .-AVS_ParseHeader
	.align	2
	.global	AVSDEC_Decode
	.type	AVSDEC_Decode, %function
AVSDEC_Decode:
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
	add	r0, r0, #15680
	mov	r5, r1
	ldr	r2, [r1, #12]
	add	r0, r0, #44
	ldr	r1, [r1]
	add	r6, r4, #12288
	bl	BsInit
	ldr	r3, .L864
	add	r0, r4, #16384
	mov	r1, r5
	mov	r2, #160
	add	r0, r0, #104
	ldr	r3, [r3, #52]
	blx	r3
	ldr	r3, [r6, #2732]
	mov	r0, r4
	str	r3, [r6, #3432]
	bl	AVS_ParseHeader
	subs	r5, r0, #0
	beq	.L862
	ldr	r3, [r6, #2732]
	and	r3, r3, #376832
	cmp	r3, #376832
	beq	.L852
.L853:
	mov	r5, #0
.L851:
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L862:
	ldr	r1, .L864+4
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	bl	AVS_ClearCurPic
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L852:
	mov	r0, r4
	bl	AVS_DecodeArbiter.part.3
	cmp	r0, #0
	beq	.L853
	mov	r0, r4
	bl	AVS_GetStreamInf
	cmp	r0, #3
	beq	.L854
	adds	r5, r0, #0
	movne	r5, #1
	cmp	r5, #0
	beq	.L863
	mov	r0, r4
	bl	AVS_StartDecode
	subs	r6, r0, #0
	bne	.L851
	ldr	r1, .L864+8
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	bl	AVS_ClearCurPic
	mov	r5, r6
	b	.L851
.L863:
	ldr	r1, .L864+12
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	bl	AVS_ClearCurPic
	b	.L851
.L854:
	ldr	r3, [r6, #3432]
	mov	r5, r0
	str	r3, [r6, #2732]
	b	.L851
.L865:
	.align	2
.L864:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC110
	.word	.LC112
	.word	.LC111
	.fnend
	.size	AVSDEC_Decode, .-AVSDEC_Decode
	.global	g_tmp
	.global	wq_param_default
	.global	g_AvsCfg
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	CSWTCH.50, %object
	.size	CSWTCH.50, 16
CSWTCH.50:
	.word	5
	.word	1
	.word	2
	.word	3
	.type	WeightQuantModel, %object
	.size	WeightQuantModel, 256
WeightQuantModel:
	.byte	0
	.byte	0
	.byte	0
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	0
	.byte	0
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	5
	.byte	5
	.byte	0
	.byte	3
	.byte	2
	.byte	2
	.byte	1
	.byte	1
	.byte	5
	.byte	5
	.byte	4
	.byte	3
	.byte	2
	.byte	2
	.byte	1
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	3
	.byte	1
	.byte	1
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	3
	.byte	1
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	0
	.byte	0
	.byte	0
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	0
	.byte	0
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	0
	.byte	3
	.byte	2
	.byte	2
	.byte	2
	.byte	1
	.byte	5
	.byte	5
	.byte	3
	.byte	3
	.byte	2
	.byte	2
	.byte	1
	.byte	5
	.byte	5
	.byte	5
	.byte	3
	.byte	3
	.byte	2
	.byte	1
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	3
	.byte	3
	.byte	1
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	0
	.byte	0
	.byte	0
	.byte	4
	.byte	4
	.byte	3
	.byte	5
	.byte	5
	.byte	0
	.byte	0
	.byte	4
	.byte	4
	.byte	3
	.byte	2
	.byte	5
	.byte	5
	.byte	0
	.byte	4
	.byte	4
	.byte	3
	.byte	2
	.byte	1
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	3
	.byte	2
	.byte	1
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	3
	.byte	2
	.byte	1
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	3
	.byte	2
	.byte	1
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	0
	.byte	0
	.byte	0
	.byte	3
	.byte	2
	.byte	1
	.byte	5
	.byte	5
	.byte	0
	.byte	0
	.byte	4
	.byte	3
	.byte	2
	.byte	1
	.byte	5
	.byte	5
	.byte	0
	.byte	4
	.byte	4
	.byte	3
	.byte	2
	.byte	1
	.byte	5
	.byte	5
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	1
	.byte	1
	.byte	1
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.data
	.align	2
.LANCHOR1 = . + 0
	.type	wq_param_default, %object
	.size	wq_param_default, 24
wq_param_default:
	.short	135
	.short	143
	.short	143
	.short	160
	.short	160
	.short	213
	.short	128
	.short	98
	.short	106
	.short	116
	.short	116
	.short	128
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"%-40s     %#-8x(%db)\012\000"
	.space	2
.LC1:
	.ascii	"video_sequence_start_code\000"
	.space	2
.LC2:
	.ascii	"profile_id\000"
	.space	1
.LC3:
	.ascii	"level_id\000"
	.space	3
.LC4:
	.ascii	"progressive_sequence\000"
	.space	3
.LC5:
	.ascii	"horizontal_size\000"
.LC6:
	.ascii	"vertical_size\000"
	.space	2
.LC7:
	.ascii	"chroma_format\000"
	.space	2
.LC8:
	.ascii	"sample_precision\000"
	.space	3
.LC9:
	.ascii	"aspect_ratio\000"
	.space	3
.LC10:
	.ascii	"frame_rate_code\000"
.LC11:
	.ascii	"bit_rate_lower\000"
	.space	1
.LC12:
	.ascii	"marker_bit\000"
	.space	1
.LC13:
	.ascii	"bit_rate_upper\000"
	.space	1
.LC14:
	.ascii	"low_delay\000"
	.space	2
.LC15:
	.ascii	"bbv_buffer_size\000"
.LC16:
	.ascii	"reserved_bits\000"
	.space	2
.LC17:
	.ascii	"i_picture_start_code\000"
	.space	3
.LC18:
	.ascii	"bbv_delay\000"
	.space	2
.LC19:
	.ascii	"bbv_delay_extension\000"
.LC20:
	.ascii	"time_code_flag\000"
	.space	1
.LC21:
	.ascii	"time_code\000"
	.space	2
.LC22:
	.ascii	"picture_distance\000"
	.space	3
.LC23:
	.ascii	"bbv_check_times\000"
.LC24:
	.ascii	"progressive_frame\000"
	.space	2
.LC25:
	.ascii	"picture_structure\000"
	.space	2
.LC26:
	.ascii	"top_field_first\000"
.LC27:
	.ascii	"repeat_first_field\000"
	.space	1
.LC28:
	.ascii	"fixed_picture_qp\000"
	.space	3
.LC29:
	.ascii	"picture_qp\000"
	.space	1
.LC30:
	.ascii	"skip_mode_flag\000"
	.space	1
.LC31:
	.ascii	"loop_filter_disable\000"
.LC32:
	.ascii	"loop_filter_parameter_flag\000"
	.space	1
.LC33:
	.ascii	"alpha_c_offset\000"
	.space	1
.LC34:
	.ascii	"beta_offset\000"
.LC35:
	.ascii	"weighting_quant_flag\000"
	.space	3
.LC36:
	.ascii	"aec_enable\000"
	.space	1
.LC37:
	.ascii	"mb_adapt_weighting_quant_disable\000"
	.space	3
.LC38:
	.ascii	"chroma_quant_param_disable\000"
	.space	1
.LC39:
	.ascii	"chroma_quant_param_delta_u\000"
	.space	1
.LC40:
	.ascii	"chroma_quant_param_delta_v\000"
	.space	1
.LC41:
	.ascii	"weighting_quant_param_index\000"
.LC42:
	.ascii	"weighting_quant_model\000"
	.space	2
.LC43:
	.ascii	"weighting_quant_param_deltal1\000"
	.space	2
.LC44:
	.ascii	"weighting_quant_param_deltal2\000"
	.space	2
.LC45:
	.ascii	"pb_picture_start_code\000"
	.space	2
.LC46:
	.ascii	"picture_coding_type\000"
.LC47:
	.ascii	"advanced_pred_mode_disable\000"
	.space	1
.LC48:
	.ascii	"picture_reference_flag\000"
	.space	1
.LC49:
	.ascii	"no_forward_reference_flag\000"
	.space	2
.LC50:
	.ascii	"b_filed_enhanced_flag\000"
	.space	2
.LC51:
	.ascii	"p_filed_enhanced_flag\000"
	.space	2
.LC52:
	.ascii	"user_data_start_code\000"
	.space	3
.LC53:
	.ascii	"extension_ID\000"
	.space	3
.LC54:
	.ascii	"video_format\000"
	.space	3
.LC55:
	.ascii	"sample_range\000"
	.space	3
.LC56:
	.ascii	"colour_description\000"
	.space	1
.LC57:
	.ascii	"colour_primaries\000"
	.space	3
.LC58:
	.ascii	"transfer_characteristics\000"
	.space	3
.LC59:
	.ascii	"matrix_coefficients\000"
.LC60:
	.ascii	"display_horizontal_size\000"
.LC61:
	.ascii	"display_vertical_size\000"
	.space	2
.LC62:
	.ascii	"copyright_flag\000"
	.space	1
.LC63:
	.ascii	"copyright_id\000"
	.space	3
.LC64:
	.ascii	"original_or_copy\000"
	.space	3
.LC65:
	.ascii	"copyright_number_1\000"
	.space	1
.LC66:
	.ascii	"copyright_number_2\000"
	.space	1
.LC67:
	.ascii	"copyright_number_3\000"
	.space	1
.LC68:
	.ascii	"camera_id\000"
	.space	2
.LC69:
	.ascii	"height_of_image_device\000"
	.space	1
.LC70:
	.ascii	"focal_length\000"
	.space	3
.LC71:
	.ascii	"f_number\000"
	.space	3
.LC72:
	.ascii	"vertical_angle_of_view\000"
	.space	1
.LC73:
	.ascii	"camera_position_x_upper\000"
.LC74:
	.ascii	"camera_position_x_lower\000"
.LC75:
	.ascii	"camera_position_y_upper\000"
.LC76:
	.ascii	"camera_position_y_lower\000"
.LC77:
	.ascii	"camera_position_z_upper\000"
.LC78:
	.ascii	"camera_position_z_lower\000"
.LC79:
	.ascii	"camera_direction_x\000"
	.space	1
.LC80:
	.ascii	"camera_direction_y\000"
	.space	1
.LC81:
	.ascii	"camera_direction_z\000"
	.space	1
.LC82:
	.ascii	"image_plane_vertical_x\000"
	.space	1
.LC83:
	.ascii	"image_plane_vertical_y\000"
	.space	1
.LC84:
	.ascii	"image_plane_vertical_z\000"
	.space	1
.LC85:
	.ascii	"frame_centre_horizontal_offset\000"
	.space	1
.LC86:
	.ascii	"frame_centre_vertical_offset\000"
	.space	3
.LC87:
	.ascii	"extension_start_code\000"
	.space	3
.LC88:
	.ascii	"ERROR: image size abnormal(%dx%d)\012\000"
	.space	1
.LC89:
	.ascii	"avs actual frame size(%dx%d) exeed max config(%dx%d"
	.ascii	")\012\000"
	.space	2
.LC90:
	.ascii	"ERROR: partition fs memory fail!\012\000"
	.space	2
.LC91:
	.ascii	"ERROR: FSP_ConfigInstance fail!\012\000"
	.space	3
.LC92:
	.ascii	"line: %d, pImage is NULL!\012\000"
	.space	1
.LC93:
	.ascii	"line: %d pImage is null\012\000"
	.space	3
.LC94:
	.ascii	"ERROR: get frame store fail!\012\000"
	.space	2
.LC95:
	.ascii	"get image buffer ok: LogicFsID = %d\012\000"
	.space	3
.LC96:
	.ascii	"decode %p, disp %p, tf %p\012\000"
	.space	1
.LC97:
	.ascii	"line: %d\012\000"
	.space	2
.LC98:
	.ascii	"ERROR: AVS_OutputOneFrame is err(%d)\012\000"
	.space	2
.LC99:
	.ascii	"size change\012\000"
	.space	3
.LC100:
	.ascii	"MbWidth = %d, MbHeight = %d, don't support!\012\000"
	.space	3
.LC101:
	.ascii	"ERROR: allocate vhb\012\000"
	.space	3
.LC102:
	.ascii	"ERROR: get img buf err\012\000"
.LC103:
	.ascii	"dec_pts: %lld Usertag = %lld\012\000"
	.space	2
.LC104:
	.ascii	"-1 == VCTRL_GetChanIDByCtx() Err! \012\000"
.LC105:
	.ascii	"-----Pic %5d, type %d, struct %d-----\012\000"
	.space	1
.LC106:
	.ascii	"ERROR: err_level(%d) over ref_thr(%d)\012\000"
	.space	1
.LC107:
	.ascii	"ERROR: err_level(%d) over out_thr(%d)\012\000"
	.space	1
.LC108:
	.ascii	"SlcNum %d > %d Write slice msg failed\012\000"
	.space	1
.LC109:
	.ascii	"This slice's start mbn %d <= LastSliceFirstMb %d, W"
	.ascii	"rite slice msg failed\012\000"
	.space	2
.LC110:
	.ascii	"ERROR: paseHeader err\012\000"
	.space	1
.LC111:
	.ascii	"ERROR: AVS_PrepareDecode err\012\000"
	.space	2
.LC112:
	.ascii	"ERROR: AVS_StartDecode err\012\000"
	.bss
	.align	2
	.type	g_tmp, %object
	.size	g_tmp, 1024
g_tmp:
	.space	1024
	.type	g_AvsCfg, %object
	.size	g_AvsCfg, 508
g_AvsCfg:
	.space	508
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
