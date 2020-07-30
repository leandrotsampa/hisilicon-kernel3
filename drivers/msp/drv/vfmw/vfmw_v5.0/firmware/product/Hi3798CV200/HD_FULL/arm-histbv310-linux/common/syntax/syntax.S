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
	.file	"syntax.c"

	.text
	.align	2
	.global	InitVoQueue
	.type	InitVoQueue, %function
InitVoQueue:
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
	ldr	r1, .L2
	mov	r4, r0
	mov	r0, #12
	bl	dprint_vfmw
	mov	r2, #0
	mov	r3, #64
	strh	r2, [r4, #2]
	strh	r3, [r4]
	mov	r0, #1
	mvn	r3, #0
	strh	r2, [r4, #4]
	strh	r2, [r4, #6]
	strh	r2, [r4, #8]
	str	r2, [r4, #344]
	str	r2, [r4, #316]
	str	r3, [r4, #272]
	str	r3, [r4, #292]
	str	r3, [r4, #288]
	str	r3, [r4, #284]
	str	r3, [r4, #276]
	str	r3, [r4, #280]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L3:
	.align	2
.L2:
	.word	.LC0
	.fnend
	.size	InitVoQueue, .-InitVoQueue
	.align	2
	.global	PrintVoQueue
	.type	PrintVoQueue, %function
PrintVoQueue:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #8
	sub	sp, sp, #8
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r5, r0
	ldrh	r3, [r0, #4]
	ldrh	ip, [r5, #8]
	mov	r0, #1
	ldrh	r2, [r5, #6]
	ldr	r1, .L11
	str	ip, [sp]
	bl	dprint_vfmw
	ldrh	r3, [r5, #4]
	ldrh	r2, [r5, #8]
	and	r4, r3, #63
	cmp	r2, r4
	bne	.L8
	b	.L7
.L6:
	add	r3, r5, r4, lsl #2
	ldr	r1, .L11+4
	mov	r0, #1
	ldr	r3, [r3, #12]
	ldr	r2, [r3, #156]
	bl	dprint_vfmw
	add	r3, r4, #1
	ldrh	r2, [r5, #8]
	and	r4, r3, #63
	cmp	r2, r4
	beq	.L7
.L8:
	tst	r3, #7
	bne	.L6
	ldr	r1, .L11+8
	mov	r0, #1
	bl	dprint_vfmw
	b	.L6
.L7:
	ldr	r1, .L11+8
	mov	r0, #1
	bl	dprint_vfmw
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L12:
	.align	2
.L11:
	.word	.LC1
	.word	.LC3
	.word	.LC2
	.fnend
	.size	PrintVoQueue, .-PrintVoQueue
	.align	2
	.global	ResetVoQueue
	.type	ResetVoQueue, %function
ResetVoQueue:
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
	ldr	r5, .L18
	mov	r4, r0
	mov	r0, #2
	ldr	r3, [r5, #12]
	blx	r3
	ldrh	r2, [r4, #6]
	ldrh	r3, [r4, #4]
	ldrh	r1, [r4, #8]
	cmp	r2, r3
	beq	.L17
.L15:
	str	r1, [sp]
	mov	r0, #1
	ldr	r1, .L18+4
	bl	dprint_vfmw
.L16:
	ldr	r2, [r4, #344]
	add	r1, r4, #336
	mov	r3, #0
	mov	r0, #64
	strh	r3, [r4, #2]
	add	r2, r2, #100
	strh	r0, [r4]
	mvn	r8, #0
	str	r2, [r4, #344]
	mvn	r9, #0
	mvn	r2, #0
	strh	r3, [r4, #4]
	strh	r3, [r4, #6]
	mov	r6, #0
	strh	r3, [r4, #8]
	mov	r7, #0
	str	r3, [r4, #316]
	mov	r0, #2
	str	r2, [r4, #272]
	str	r2, [r4, #292]
	str	r2, [r4, #288]
	str	r2, [r4, #284]
	str	r2, [r4, #276]
	str	r2, [r4, #280]
	ldr	ip, [r5, #16]
	strd	r8, [r1, #-8]
	str	r3, [r4, #324]
	strd	r6, [r1]
	blx	ip
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L17:
	cmp	r2, r1
	bne	.L15
	b	.L16
.L19:
	.align	2
.L18:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC4
	.fnend
	.size	ResetVoQueue, .-ResetVoQueue
	.align	2
	.global	ReturnImageToSyntax
	.type	ReturnImageToSyntax, %function
ReturnImageToSyntax:
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
	mov	r3, r1
	cmp	r0, #20
	ldrls	pc, [pc, r0, asl #2]
	b	.L20
.L23:
	.word	.L22
	.word	.L24
	.word	.L25
	.word	.L26
	.word	.L27
	.word	.L28
	.word	.L29
	.word	.L20
	.word	.L30
	.word	.L31
	.word	.L32
	.word	.L32
	.word	.L32
	.word	.L33
	.word	.L27
	.word	.L34
	.word	.L35
	.word	.L36
	.word	.L20
	.word	.L20
	.word	.L37
.L37:
	ldr	r1, [r2, #156]
	mov	r0, r3
	bl	USERDEC_RecycleImage
.L20:
	ldmfd	sp, {fp, sp, pc}
.L22:
	ldr	r1, [r2, #156]
	mov	r0, r3
	bl	H264DEC_RecycleImage
	ldmfd	sp, {fp, sp, pc}
.L24:
	ldr	r1, [r2, #156]
	mov	r0, r3
	bl	VC1DEC_RecycleImage
	ldmfd	sp, {fp, sp, pc}
.L25:
	ldr	r1, [r2, #156]
	mov	r0, r3
	bl	MPEG4DEC_RecycleImage
	ldmfd	sp, {fp, sp, pc}
.L26:
	ldr	r1, [r2, #156]
	mov	r0, r3
	bl	MPEG2DEC_RecycleImage
	ldmfd	sp, {fp, sp, pc}
.L27:
	ldr	r1, .L41
	ldr	ip, [r1, #16]
	cmp	ip, #0
	ldmeqfd	sp, {fp, sp, pc}
	ldr	r1, [r2, #156]
	mov	r0, r3
	blx	ip
	ldmfd	sp, {fp, sp, pc}
.L28:
	ldr	r1, [r2, #156]
	mov	r0, r3
	bl	DIVX3DEC_RecycleImage
	ldmfd	sp, {fp, sp, pc}
.L29:
	ldr	r1, [r2, #156]
	mov	r0, r3
	bl	AVSDEC_RecycleImage
	ldmfd	sp, {fp, sp, pc}
.L30:
	ldr	r1, [r2, #156]
	mov	r0, r3
	bl	REAL8DEC_RecycleImage
	ldmfd	sp, {fp, sp, pc}
.L31:
	ldr	r1, [r2, #156]
	mov	r0, r3
	bl	REAL9DEC_RecycleImage
	ldmfd	sp, {fp, sp, pc}
.L32:
	ldr	r1, [r2, #156]
	mov	r0, r3
	bl	VP6DEC_RecycleImage
	ldmfd	sp, {fp, sp, pc}
.L33:
	ldr	r1, [r2, #156]
	mov	r0, r3
	bl	VP8DEC_RecycleImage
	ldmfd	sp, {fp, sp, pc}
.L34:
	ldr	r1, [r2, #156]
	mov	r0, r3
	bl	MVC_DEC_RecycleImage
	ldmfd	sp, {fp, sp, pc}
.L35:
	ldr	r1, [r2, #156]
	mov	r0, r3
	bl	HEVC_DECRecycleImage
	ldmfd	sp, {fp, sp, pc}
.L36:
	ldr	r1, [r2, #156]
	mov	r0, r3
	bl	VP9DEC_RecycleImage
	ldmfd	sp, {fp, sp, pc}
.L42:
	.align	2
.L41:
	.word	g_SdecFunc
	.fnend
	.size	ReturnImageToSyntax, .-ReturnImageToSyntax
	.align	2
	.global	ProduceTimeStamp
	.type	ProduceTimeStamp, %function
ProduceTimeStamp:
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
	mov	r3, r1
	cmp	r2, #20
	add	r1, r1, #576
	ldrd	r6, [r1, #-8]
	beq	.L44
	add	r0, r0, #272
	sub	r2, r2, #8
	ldrd	r4, [r0, #56]
	subs	r0, r6, r4
	and	r4, r4, r5
	sbc	r1, r7, r5
	cmp	r1, #0
	cmpeq	r0, #5
	movls	r1, #1
	movhi	r1, #0
	adds	r4, r4, #1
	movne	r4, #1
	tst	r1, r4
	beq	.L54
	cmp	r2, #1
	mvnhi	r6, #0
	mvnhi	r7, #0
	bls	.L46
.L44:
	mov	r0, r6
	mov	r1, r7
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L54:
	cmp	r2, #1
	bhi	.L44
	ldr	r2, [r3, #108]
	and	r2, r2, #3
	cmp	r2, #2
	bne	.L44
.L46:
	mvn	r1, #0
	str	r1, [r3, #560]
	mov	r6, r1
	mov	r7, r1
	str	r1, [r3, #564]
	b	.L44
	.fnend
	.size	ProduceTimeStamp, .-ProduceTimeStamp
	.global	__aeabi_uidiv
	.align	2
	.global	InsertImgToVoQueue
	.type	InsertImgToVoQueue, %function
InsertImgToVoQueue:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #44
	sub	sp, sp, #44
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r5, [fp, #4]
	mov	r8, r0
	str	r1, [fp, #-56]
	mov	r10, r2
	cmp	r5, #0
	mov	r4, r3
	beq	.L118
	ldr	r1, .L124
	mov	r0, #2
	bl	dprint_vfmw
	ldr	r3, .L124+4
	mov	r0, #2
	ldr	r3, [r3, #12]
	blx	r3
	ldrh	r9, [r4, #4]
	ldrh	r3, [r4, #8]
	and	r9, r9, #63
	cmp	r3, r9
	ldrne	r7, [fp, #-56]
	bne	.L63
	b	.L62
.L61:
	add	r9, r9, #1
	ldrh	r3, [r4, #8]
	and	r9, r9, #63
	cmp	r3, r9
	beq	.L119
.L63:
	add	r3, r4, r9, lsl #2
	ldr	r1, [r5, #156]
	ldr	r3, [r3, #12]
	ldr	r2, [r3, #156]
	cmp	r2, r1
	bne	.L61
	ldr	r1, .L124+8
	mov	r0, #0
	bl	dprint_vfmw
	mov	r3, #1000
	str	r3, [r5, #160]
	b	.L61
.L119:
	str	r7, [fp, #-56]
.L62:
	ldr	r2, [r5, #160]
	cmp	r2, #100
	bhi	.L59
	ldr	r3, [r5, #112]
	cmp	r3, #31
	bhi	.L120
.L59:
	ldr	r3, [r5, #112]
	ldr	r1, [r5, #116]
.L64:
	str	r1, [sp]
	mov	r0, #0
	ldr	r1, .L124+12
	bl	dprint_vfmw
	ldr	r3, [r5, #160]
	cmp	r3, #1000
	beq	.L66
	mov	r2, r5
	mov	r1, r10
	ldr	r0, [fp, #-56]
	bl	ReturnImageToSyntax
.L66:
	ldr	r3, .L124+4
	mov	r0, #2
	ldr	r3, [r3, #16]
	blx	r3
	mov	r0, #1
.L57:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L120:
	ldr	r1, [r5, #116]
	cmp	r1, #31
	bls	.L64
	add	r10, r5, #576
	add	r9, r5, #560
	ldr	r2, [fp, #-56]
	mov	r1, r5
	ldrd	r6, [r10, #-8]
	mov	r0, r4
	strd	r6, [r9]
	bl	ProduceTimeStamp
	mov	r6, r0
	mov	r7, r1
	ldrd	r0, [r10]
	strd	r6, [r10, #-8]
	ldrd	r2, [r9]
	strd	r0, [fp, #-68]
	mov	r0, #29
	strd	r6, [sp]
	ldrd	r6, [fp, #-68]
	ldr	r1, .L124+16
	strd	r6, [sp, #8]
	bl	dprint_vfmw
	ldr	r3, [r5, #120]
	cmp	r3, #0
	beq	.L67
	ldr	r3, [r5, #124]
	cmp	r3, #0
	bne	.L121
.L67:
	ldr	r2, [r5, #112]
	ldr	r3, [r5, #116]
	mov	r1, r2, lsr #1
	str	r2, [r5, #120]
	str	r3, [r5, #124]
	mov	r3, r3, lsr #1
	str	r1, [r5, #128]
	str	r3, [r5, #132]
.L68:
	str	r2, [r4, #300]
	ldr	r3, [r5, #116]
	ldr	r2, [r4, #280]
	ldr	r10, .L124+20
	str	r3, [r4, #304]
	ldr	r3, [r5, #108]
	ubfx	r3, r3, #5, #3
	str	r3, [r4, #308]
	ldr	r3, [r5, #108]
	str	r3, [r4, #312]
	ldr	r3, [r5, #164]
	ldr	r1, [r5, #128]
	cmp	r3, r2
	ldrh	r2, [r5, #132]
	ldr	r7, [r5, #108]
	ldr	r9, [r5, #124]
	orr	r2, r2, r1, asl #16
	ldrh	r0, [r5, #120]
	ubfx	ip, r7, #14, #3
	strne	r3, [r4, #320]
	mov	r6, r2
	ldr	r3, [r4, #316]
	orr	r9, r0, r9, asl #16
	ubfx	r7, r7, #8, #2
	add	r2, r3, #1
	str	r2, [r4, #316]
	str	r3, [r5, #168]
	ldr	r3, [r4, #272]
	cmp	r3, ip
	beq	.L70
	ldr	r2, [r10]
	subs	lr, r2, #0
	beq	.L71
	strb	r3, [fp, #-52]
	sub	r2, fp, #52
	strb	ip, [fp, #-51]
	mov	r3, #2
	str	ip, [fp, #-56]
	mov	r1, #7
	mov	ip, lr
	mov	r0, r8
	blx	ip
	ldr	ip, [fp, #-56]
.L71:
	str	ip, [r4, #272]
.L70:
	ldr	r3, [r4, #276]
	cmp	r3, r7
	beq	.L72
	ldr	ip, [r10]
	cmp	ip, #0
	beq	.L73
	sub	r2, fp, #44
	mov	r3, #1
	mov	r1, #4
	mov	r0, r8
	strb	r7, [r2, #-8]!
	blx	ip
.L73:
	str	r7, [r4, #276]
.L72:
	ldr	r3, [r4, #288]
	cmp	r3, r9
	beq	.L122
.L74:
	ldr	ip, [r10]
	str	r9, [r4, #288]
	cmp	ip, #0
	str	r6, [r4, #292]
	beq	.L75
	ldr	lr, [r5, #128]
	mov	r3, #8
	ldr	r9, [r5, #120]
	sub	r2, fp, #52
	ldr	r7, [r5, #124]
	mov	r1, #1
	strh	lr, [fp, #-48]
	mov	r0, r8
	ldrh	lr, [r5, #132]
	strh	r9, [fp, #-52]
	strh	r7, [fp, #-50]
	strh	lr, [fp, #-46]
	blx	ip
.L75:
	ldr	r1, [r5, #48]
	mov	r0, #12
	ldr	r2, [r5, #44]
	mov	r9, #300
	ldr	r3, [r5, #140]
	str	r1, [r5, #32]
	str	r2, [r5, #28]
	add	r2, r3, r2
	add	r3, r1, r3
	str	r2, [r5, #36]
	str	r3, [r5, #40]
	ldr	r1, [r5, #156]
	ldrh	ip, [r4, #8]
	ldrh	r3, [r4, #6]
	ldrh	r2, [r4, #4]
	ldr	r7, .L124+24
	str	r1, [sp, #4]
	str	ip, [sp]
	ldr	r1, .L124+28
	bl	dprint_vfmw
	ldrh	r3, [r4, #8]
	mla	r9, r9, r8, r7
	mov	r2, #0
	add	r1, r4, r3, lsl #2
	add	r3, r3, #1
	and	r3, r3, #63
	mov	r0, #2
	str	r5, [r1, #12]
	strh	r3, [r4, #8]
	ldr	r3, [r5, #96]
	str	r2, [r5, #312]
	ldr	r2, .L124+4
	str	r3, [r9, #20]
	ldr	r3, [r5, #156]
	ldr	r2, [r2, #16]
	add	r3, r3, r0
	str	r3, [r4, #296]
	blx	r2
	ldr	r3, .L124+32
	ldr	r3, [r3, r8, asl #2]
	ldr	r3, [r3, #136]
	cmp	r3, #0
	beq	.L77
	ldr	r3, [r9, #8]
	cmp	r3, #0
	movne	r2, #100
	mulne	r3, r2, r3
	strne	r3, [r5, #136]
.L77:
	ldr	ip, [r10]
	cmp	ip, #0
	beq	.L78
	mov	r2, r5
	mov	r3, #592
	mov	r1, #5
	mov	r0, r8
	blx	ip
.L78:
	mov	r0, #8
	bl	CHECK_REC_POS_ENABLE
	cmp	r0, #0
	bne	.L123
.L80:
	mov	r4, #300
	ldr	r3, .L124+4
	mul	r4, r4, r8
	ldr	r2, [r3]
	add	r5, r7, r4
	ldr	r3, [r5, #4]
	add	r3, r3, #1
	str	r3, [r5, #4]
	blx	r2
	ldr	r1, [r7, r4]
	rsb	r1, r1, r0
	mov	r6, r0
	cmp	r1, #300
	movcc	r0, #1
	bcc	.L57
	ldr	r3, [r5, #4]
	cmp	r3, #0
	beq	.L82
	movw	r0, #10000
	mul	r0, r0, r3
	bl	__aeabi_uidiv
	str	r0, [r5, #8]
.L82:
	mov	r3, #300
	mov	r2, #0
	mul	r8, r3, r8
	mov	r0, #1
	add	r3, r7, r8
	str	r6, [r7, r8]
	str	r2, [r3, #4]
	b	.L57
.L121:
	ldr	r2, [fp, #-56]
	sub	r3, r2, #15
	cmp	r2, #0
	cmpne	r3, #1
	ldrls	r2, [r5, #112]
	bhi	.L67
	b	.L68
.L123:
	ldr	r3, .L124+4
	ldr	r3, [r3]
	blx	r3
	ldr	ip, .L124+36
	ldr	r2, .L124+40
	ldr	r3, [ip, r8, asl #2]
	ldr	r2, [r2]
	rsb	r3, r3, r0
	mov	lr, r0
	cmp	r3, r2
	bls	.L80
	mov	r2, r8, asl #24
	mov	r1, #636
	add	r2, r2, #524288
	ldr	r0, .L124+44
	str	lr, [ip, r8, asl #2]
	bl	DBG_AddTrace
	b	.L80
.L122:
	ldr	r3, [r4, #292]
	cmp	r3, r6
	bne	.L74
	b	.L75
.L118:
	mov	r0, r5
	ldr	r1, .L124+48
	bl	dprint_vfmw
	mvn	r0, #1
	b	.L57
.L125:
	.align	2
.L124:
	.word	.LC6
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	g_event_report
	.word	g_VfmwChanStat
	.word	.LC10
	.word	s_pstVfmwChan
	.word	.LANCHOR0
	.word	g_TraceFramePeriod
	.word	.LANCHOR1
	.word	.LC5
	.fnend
	.size	InsertImgToVoQueue, .-InsertImgToVoQueue
	.align	2
	.global	GetQueueImgNum
	.type	GetQueueImgNum, %function
GetQueueImgNum:
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
	ldrh	r3, [r0, #6]
	ldrh	ip, [r0, #4]
	ldrh	r0, [r0, #8]
	cmp	r3, ip
	addcc	lr, r3, #64
	rsbcs	ip, ip, r3
	rsbcc	ip, ip, lr
	cmp	r3, r0
	addhi	r0, r0, #64
	str	ip, [r1]
	rsb	r3, r3, r0
	str	r3, [r2]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	GetQueueImgNum, .-GetQueueImgNum
	.align	2
	.global	SYNTAX_ReceiveImage
	.type	SYNTAX_ReceiveImage, %function
SYNTAX_ReceiveImage:
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
	cmp	r0, #0
	cmpne	r1, #0
	mov	r7, r1
	beq	.L153
	ldr	r3, [r0]
	cmp	r3, #20
	ldrls	pc, [pc, r3, asl #2]
	b	.L153
.L135:
	.word	.L149
	.word	.L136
	.word	.L137
	.word	.L138
	.word	.L139
	.word	.L140
	.word	.L141
	.word	.L153
	.word	.L142
	.word	.L143
	.word	.L144
	.word	.L144
	.word	.L144
	.word	.L145
	.word	.L139
	.word	.L146
	.word	.L147
	.word	.L148
	.word	.L153
	.word	.L153
	.word	.L149
.L149:
	add	r4, r0, #16
.L150:
	ldr	r6, .L155
	mov	r0, #2
	ldr	r3, [r6, #12]
	blx	r3
	ldrh	r3, [r4, #6]
	ldrh	r2, [r4, #8]
	cmp	r2, r3
	mvneq	r5, #2
	beq	.L151
	add	r3, r4, r3, lsl #2
	ldr	ip, [r6, #52]
	mov	r2, #592
	mov	r0, r7
	ldr	r1, [r3, #12]
	mov	r5, #1
	blx	ip
	ldr	r1, [r7, #156]
	ldrh	r3, [r4, #6]
	mov	r0, #12
	ldrh	r2, [r4, #4]
	str	r1, [sp, #4]
	ldrh	ip, [r4, #8]
	ldr	r1, .L155+4
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [r7, #156]
	ldr	r2, [r4, #344]
	add	r3, r3, r2
	str	r3, [r7, #156]
	ldrh	r3, [r4, #6]
	add	r3, r3, r5
	and	r3, r3, #63
	strh	r3, [r4, #6]
.L151:
	ldr	r3, [r6, #16]
	mov	r0, #2
	blx	r3
	mov	r0, r5
.L133:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L136:
	add	r4, r0, #48896
	add	r4, r4, #136
	b	.L150
.L137:
	add	r4, r0, #22528
	add	r4, r4, #104
	b	.L150
.L138:
	add	r4, r0, #84992
	add	r4, r4, #672
	b	.L150
.L139:
	add	r4, r0, #29952
	add	r4, r4, #144
	b	.L150
.L140:
	add	r4, r0, #39424
	add	r4, r4, #40
	b	.L150
.L141:
	add	r4, r0, #16128
	add	r4, r4, #8
	b	.L150
.L142:
	add	r4, r0, #51712
	add	r4, r4, #80
	b	.L150
.L143:
	add	r4, r0, #51712
	add	r4, r4, #64
	b	.L150
.L144:
	add	r4, r0, #12672
	b	.L150
.L145:
	add	r4, r0, #8192
	b	.L150
.L146:
	add	r4, r0, #592
	b	.L150
.L147:
	add	r4, r0, #61440
	add	r4, r4, #200
	b	.L150
.L148:
	add	r4, r0, #270336
	add	r4, r4, #840
	b	.L150
.L153:
	mvn	r0, #1
	b	.L133
.L156:
	.align	2
.L155:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC11
	.fnend
	.size	SYNTAX_ReceiveImage, .-SYNTAX_ReceiveImage
	.align	2
	.global	SYNTAX_ReleaseImage
	.type	SYNTAX_ReleaseImage, %function
SYNTAX_ReleaseImage:
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
	subs	r6, r1, #0
	mov	r8, r0
	beq	.L252
	ldr	r3, [r0]
	cmp	r3, #20
	ldrls	pc, [pc, r3, asl #2]
	b	.L204
.L161:
	.word	.L175
	.word	.L162
	.word	.L163
	.word	.L164
	.word	.L165
	.word	.L166
	.word	.L167
	.word	.L204
	.word	.L168
	.word	.L169
	.word	.L170
	.word	.L170
	.word	.L170
	.word	.L171
	.word	.L165
	.word	.L172
	.word	.L173
	.word	.L174
	.word	.L204
	.word	.L204
	.word	.L175
.L175:
	add	r5, r0, #16
.L176:
	ldr	r7, .L254
	mov	r0, #2
	ldr	r3, [r7, #12]
	blx	r3
	ldr	r3, [r6, #156]
	ldr	r2, [r5, #344]
	rsb	r2, r2, r3
	str	r2, [r6, #156]
	ldrh	r4, [r5, #4]
	ldrh	r3, [r5, #6]
	and	r4, r4, #63
	cmp	r3, r4
	bne	.L202
	b	.L203
.L181:
	add	r4, r4, #1
	ldrh	r3, [r5, #6]
	and	r4, r4, #63
	cmp	r3, r4
	beq	.L253
.L202:
	add	r9, r4, #2
	add	r3, r5, r9, lsl #2
	ldr	r3, [r3, #4]
	cmp	r3, #0
	beq	.L179
	ldr	r3, [r3, #156]
	ldr	r0, [r6, #156]
	rsb	r0, r3, r0
	clz	r0, r0
	mov	r0, r0, lsr #5
	cmp	r0, #0
	beq	.L181
.L180:
	ldrh	r2, [r5, #4]
	b	.L183
.L206:
	mov	r4, ip
.L183:
	cmp	r4, #0
	mov	ip, #63
	subne	ip, r4, #1
	add	r1, r5, r9, lsl #2
	add	r3, ip, #2
	cmp	r2, r4
	add	lr, r5, r3, lsl #2
	mov	r9, r3
	ldr	r3, [lr, #4]
	str	r3, [r1, #4]
	bne	.L206
	cmp	r0, #1
	add	r2, r2, #1
	and	r2, r2, #63
	strh	r2, [r5, #4]
	bne	.L181
	ldrh	lr, [r5, #8]
	mov	r0, #12
	ldr	ip, [r6, #156]
	ldrh	r3, [r5, #6]
	ldr	r1, .L254+4
	str	lr, [sp]
	str	ip, [sp, #4]
	bl	dprint_vfmw
	ldr	r3, [r8]
	cmp	r3, #20
	ldrls	pc, [pc, r3, asl #2]
	b	.L207
.L185:
	.word	.L184
	.word	.L186
	.word	.L187
	.word	.L188
	.word	.L189
	.word	.L190
	.word	.L191
	.word	.L207
	.word	.L192
	.word	.L193
	.word	.L194
	.word	.L194
	.word	.L194
	.word	.L195
	.word	.L189
	.word	.L196
	.word	.L197
	.word	.L198
	.word	.L207
	.word	.L207
	.word	.L199
.L167:
	add	r5, r0, #16128
	add	r5, r5, #8
	b	.L176
.L168:
	add	r5, r0, #51712
	add	r5, r5, #80
	b	.L176
.L169:
	add	r5, r0, #51712
	add	r5, r5, #64
	b	.L176
.L170:
	add	r5, r0, #12672
	b	.L176
.L171:
	add	r5, r0, #8192
	b	.L176
.L172:
	add	r5, r0, #592
	b	.L176
.L173:
	add	r5, r0, #61440
	add	r5, r5, #200
	b	.L176
.L174:
	add	r5, r0, #270336
	add	r5, r5, #840
	b	.L176
.L163:
	add	r5, r0, #22528
	add	r5, r5, #104
	b	.L176
.L164:
	add	r5, r0, #84992
	add	r5, r5, #672
	b	.L176
.L165:
	add	r5, r0, #29952
	add	r5, r5, #144
	b	.L176
.L166:
	add	r5, r0, #39424
	add	r5, r5, #40
	b	.L176
.L162:
	add	r5, r0, #48896
	add	r5, r5, #136
	b	.L176
.L179:
	mov	r2, r4
	ldr	r1, .L254+8
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #2
	b	.L180
.L253:
	ldr	r2, [r6, #156]
.L203:
	ldr	r1, .L254+12
	mov	r0, #1
	mvn	r4, #1
	bl	dprint_vfmw
.L178:
	ldr	r3, [r7, #16]
	mov	r0, #2
	blx	r3
	mov	r0, r4
.L159:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L204:
	mvn	r0, #1
	b	.L159
.L199:
	ldr	r1, [r6, #156]
	add	r0, r8, #8
	bl	USERDEC_RecycleImage
	cmp	r0, #1
	beq	.L201
.L208:
	mvn	r4, #19
	b	.L178
.L198:
	ldr	r1, [r6, #156]
	add	r0, r8, #8
	bl	VP9DEC_RecycleImage
	cmp	r0, #0
	bne	.L208
.L201:
	mov	r4, #1
	b	.L178
.L190:
	ldr	r1, [r6, #156]
	add	r0, r8, #8
	bl	DIVX3DEC_RecycleImage
	cmp	r0, #1
	bne	.L208
	b	.L201
.L189:
	ldr	r3, .L254+16
	ldr	r3, [r3, #16]
	cmp	r3, #0
	beq	.L208
	ldr	r1, [r6, #156]
	add	r0, r8, #8
	blx	r3
	cmp	r0, #0
	beq	.L201
	b	.L208
.L188:
	ldr	r1, [r6, #156]
	add	r0, r8, #8
	bl	MPEG2DEC_RecycleImage
	cmp	r0, #1
	bne	.L208
	b	.L201
.L187:
	ldr	r1, [r6, #156]
	add	r0, r8, #8
	bl	MPEG4DEC_RecycleImage
	cmp	r0, #1
	bne	.L208
	b	.L201
.L186:
	ldr	r1, [r6, #156]
	add	r0, r8, #8
	bl	VC1DEC_RecycleImage
	cmp	r0, #1
	bne	.L208
	b	.L201
.L184:
	ldr	r1, [r6, #156]
	add	r0, r8, #8
	bl	H264DEC_RecycleImage
	cmp	r0, #0
	bne	.L208
	b	.L201
.L194:
	ldr	r1, [r6, #156]
	add	r0, r8, #8
	bl	VP6DEC_RecycleImage
	cmp	r0, #1
	bne	.L208
	b	.L201
.L193:
	ldr	r1, [r6, #156]
	add	r0, r8, #8
	bl	REAL9DEC_RecycleImage
	cmp	r0, #1
	bne	.L208
	b	.L201
.L192:
	ldr	r1, [r6, #156]
	add	r0, r8, #8
	bl	REAL8DEC_RecycleImage
	cmp	r0, #1
	bne	.L208
	b	.L201
.L191:
	ldr	r1, [r6, #156]
	add	r0, r8, #8
	bl	AVSDEC_RecycleImage
	cmp	r0, #1
	bne	.L208
	b	.L201
.L196:
	ldr	r1, [r6, #156]
	add	r0, r8, #8
	bl	MVC_DEC_RecycleImage
	cmp	r0, #0
	beq	.L201
	b	.L208
.L197:
	ldr	r1, [r6, #156]
	add	r0, r8, #8
	bl	HEVC_DECRecycleImage
	cmp	r0, #0
	beq	.L201
	b	.L208
.L195:
	ldr	r1, [r6, #156]
	add	r0, r8, #8
	bl	VP8DEC_RecycleImage
	cmp	r0, #1
	bne	.L208
	b	.L201
.L207:
	mvn	r4, #1
	b	.L178
.L252:
	mov	r0, r6
	ldr	r1, .L254+20
	bl	dprint_vfmw
	mvn	r0, #1
	b	.L159
.L255:
	.align	2
.L254:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC15
	.word	.LC14
	.word	.LC13
	.word	g_SdecFunc
	.word	.LC12
	.fnend
	.size	SYNTAX_ReleaseImage, .-SYNTAX_ReleaseImage
	.align	2
	.global	SYNTAX_ReturnImage
	.type	SYNTAX_ReturnImage, %function
SYNTAX_ReturnImage:
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
	ldr	r3, [r0]
	cmp	r3, #20
	ldrls	pc, [pc, r3, asl #2]
	b	.L275
.L259:
	.word	.L273
	.word	.L260
	.word	.L261
	.word	.L262
	.word	.L263
	.word	.L264
	.word	.L265
	.word	.L275
	.word	.L266
	.word	.L267
	.word	.L268
	.word	.L268
	.word	.L268
	.word	.L269
	.word	.L263
	.word	.L270
	.word	.L271
	.word	.L272
	.word	.L275
	.word	.L275
	.word	.L273
.L273:
	add	r4, r0, #16
.L274:
	ldr	r5, .L276
	mov	r0, #2
	ldr	r3, [r5, #12]
	blx	r3
	ldrh	r3, [r4, #6]
	mov	r0, #2
	sub	r3, r3, #1
	and	r3, r3, #63
	strh	r3, [r4, #6]
	ldr	r3, [r5, #16]
	blx	r3
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L260:
	add	r4, r0, #48896
	add	r4, r4, #136
	b	.L274
.L261:
	add	r4, r0, #22528
	add	r4, r4, #104
	b	.L274
.L262:
	add	r4, r0, #84992
	add	r4, r4, #672
	b	.L274
.L263:
	add	r4, r0, #29952
	add	r4, r4, #144
	b	.L274
.L264:
	add	r4, r0, #39424
	add	r4, r4, #40
	b	.L274
.L265:
	add	r4, r0, #16128
	add	r4, r4, #8
	b	.L274
.L266:
	add	r4, r0, #51712
	add	r4, r4, #80
	b	.L274
.L267:
	add	r4, r0, #51712
	add	r4, r4, #64
	b	.L274
.L268:
	add	r4, r0, #12672
	b	.L274
.L269:
	add	r4, r0, #8192
	b	.L274
.L270:
	add	r4, r0, #592
	b	.L274
.L271:
	add	r4, r0, #61440
	add	r4, r4, #200
	b	.L274
.L272:
	add	r4, r0, #270336
	add	r4, r4, #840
	b	.L274
.L275:
	mvn	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L277:
	.align	2
.L276:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	SYNTAX_ReturnImage, .-SYNTAX_ReturnImage
	.align	2
	.global	SegMan
	.type	SegMan, %function
SegMan:
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
	subs	r4, r1, #0
	mov	r6, r0
	beq	.L279
	ldr	r3, [r4, #8]
	cmp	r3, #0
	beq	.L279
	ldr	r3, .L303
	ldr	r3, [r3, r0, asl #2]
	ldr	r2, [r3, #1424]
	cmp	r2, #1
	beq	.L299
.L282:
	ldrb	r5, [r4, #13]
	mov	r7, #0
	strb	r7, [r4, #408]
	cmp	r5, #1
	beq	.L300
	cmp	r5, #0
	beq	.L301
.L287:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L301:
	ldr	r9, .L303+4
	add	r8, r4, #88
	add	r7, r4, #168
	mov	r2, #80
	add	r1, r4, #8
	mov	r0, r8
	ldr	r3, [r9, #52]
	blx	r3
	ldr	r3, [r9, #48]
	mov	r0, r7
	mov	r2, #80
	mov	r1, r5
	blx	r3
	ldrb	r3, [r4, #2]
	add	r3, r3, #1
	uxtb	r3, r3
	strb	r3, [r4, #2]
	cmp	r3, #1
	bls	.L287
	ldr	r1, [r4, #104]
	mov	r0, r6
	bl	SM_ReleaseStreamSeg
	ldr	r1, [r4, #184]
	mov	r0, r6
	bl	SM_ReleaseStreamSeg
	ldr	r3, [r9, #48]
	mov	r2, #80
	mov	r1, r5
	mov	r0, r8
	blx	r3
	ldr	r3, [r9, #48]
	mov	r2, #80
	mov	r1, r5
	mov	r0, r7
	blx	r3
	ldr	r1, .L303+8
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L303+12
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L286
	mov	r0, r6
	mov	r3, r5
	mov	r2, r5
	mov	r1, #113
	blx	ip
.L286:
	mov	r3, #0
	mvn	r0, #0
	strb	r3, [r4, #2]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L299:
	ldr	r3, [r3, #1464]
	cmp	r3, #1
	bne	.L282
	ldrb	r3, [r4, #408]
	cmp	r3, #1
	bne	.L282
	mov	r2, #160
	add	r1, r4, #248
	add	r0, r4, #88
	bl	memcpy
	mov	r3, #0
	mov	r0, r3
	strb	r3, [r4, #408]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L300:
	ldrb	r5, [r4, #2]
	cmp	r5, r7
	beq	.L302
	cmp	r5, #1
	bne	.L287
	ldr	r3, [r4, #100]
	cmp	r3, #1024
	bge	.L288
	ldr	r1, .L303+16
	mov	r0, #22
	ldr	r8, .L303+4
	bl	dprint_vfmw
	ldr	r2, [r4, #100]
	ldr	r0, [r4, #8]
	ldr	r3, [r8, #52]
	rsb	r0, r2, r0
	ldr	r1, [r4, #88]
	blx	r3
	ldr	r3, [r4, #100]
	ldr	ip, [r4, #20]
	mov	r0, r6
	ldr	r1, [r4, #8]
	ldr	r2, [r4, #16]
	rsb	r1, r3, r1
	strb	r5, [r4, #93]
	rsb	r2, r3, r2
	str	r1, [r4, #88]
	add	r3, r3, ip
	str	r2, [r4, #96]
	str	r3, [r4, #100]
	ldr	r1, [r4, #104]
	bl	SM_ReleaseStreamSeg
	ldr	ip, [r4, #24]
	ldr	r3, [r8, #48]
	mov	r1, r7
	mov	r2, #80
	add	r0, r4, #168
	str	ip, [r4, #104]
	blx	r3
.L289:
	mov	r5, #0
	mov	r3, #1
	strb	r5, [r4, #2]
	mov	r2, #160
	strb	r3, [r4, #408]
	add	r1, r4, #88
	add	r0, r4, #248
	bl	memcpy
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L302:
	ldr	r6, .L303+4
	add	r1, r4, #8
	mov	r2, #80
	add	r0, r4, #88
	ldr	r3, [r6, #52]
	blx	r3
	ldr	r3, [r6, #48]
	mov	r2, #80
	mov	r1, r5
	add	r0, r4, #168
	blx	r3
	strb	r5, [r4, #2]
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L288:
	ldr	r1, .L303+20
	mov	r0, #22
	bl	dprint_vfmw
	ldr	r3, .L303+4
	mov	r2, #80
	add	r1, r4, #8
	add	r0, r4, #168
	ldr	r3, [r3, #52]
	blx	r3
	b	.L289
.L279:
	ldr	r1, .L303+24
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L304:
	.align	2
.L303:
	.word	s_pstVfmwChan
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC17
	.word	g_event_report
	.word	.LC18
	.word	.LC19
	.word	.LC16
	.fnend
	.size	SegMan, .-SegMan
	.align	2
	.global	DecodeStream
	.type	DecodeStream, %function
DecodeStream:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #32
	sub	sp, sp, #32
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r4, r0
	mov	r5, r2
	cmp	r1, #17
	ldrls	pc, [pc, r1, asl #2]
	b	.L305
.L308:
	.word	.L307
	.word	.L309
	.word	.L310
	.word	.L311
	.word	.L312
	.word	.L313
	.word	.L314
	.word	.L305
	.word	.L315
	.word	.L316
	.word	.L317
	.word	.L317
	.word	.L317
	.word	.L318
	.word	.L312
	.word	.L319
	.word	.L320
	.word	.L321
.L309:
	ldrb	r2, [r0, #13]
	mov	r0, #22
	ldr	r1, .L410
	bl	dprint_vfmw
	ldr	r2, [r4, #16]
	ldr	r1, .L410+4
	mov	r0, #22
	bl	dprint_vfmw
	ldr	r2, [r4, #20]
	ldr	r1, .L410+8
	mov	r0, #22
	bl	dprint_vfmw
	ldr	r2, [r5]
	ldr	r3, [r2, #556]
	cmp	r3, #1
	bhi	.L391
	ldr	r1, [r2, #560]
	cmp	r1, #8
	bgt	.L392
	add	r6, r5, #12288
	uxtb	r3, r3
	cmp	r3, #1
	strb	r3, [r6, #3536]
	ldr	r3, [r2, #560]
	strb	r3, [r6, #3538]
	beq	.L393
	ldrb	r3, [r4, #14]
	cmp	r3, #1
	beq	.L394
	ldr	r6, .L410+12
	add	r7, r4, #88
	mov	r2, #80
	add	r1, r4, #8
	mov	r0, r7
	ldr	r3, [r6, #52]
	blx	r3
	ldr	r3, [r6, #48]
	mov	r2, #80
	mov	r1, #0
	add	r0, r4, #168
	blx	r3
	ldr	r3, [r4, #100]
	cmp	r3, #15
	bgt	.L341
	ldr	r1, .L410+16
	add	r5, r5, #49152
.L390:
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r1, [r4, #104]
	ldr	r0, [r5, #224]
	bl	SM_ReleaseStreamSeg
	ldr	r3, .L410+20
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L305
	mov	r3, #0
	ldr	r0, [r5, #224]
	mov	r2, r3
	mov	r1, #113
	blx	ip
.L305:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L321:
	ldrb	r3, [r0, #14]
	cmp	r3, #1
	beq	.L395
	ldr	r8, .L410+12
	add	r7, r0, #88
	add	r1, r0, #8
	mov	r2, #80
	mov	r0, r7
	add	r6, r5, #290816
	ldr	r3, [r8, #52]
	blx	r3
	ldr	r3, [r8, #48]
	mov	r2, #80
	mov	r1, #0
	add	r0, r4, #168
	blx	r3
	mov	r1, r7
	mov	r0, r5
	bl	VP9DEC_DecodePacket
	ldr	r3, [r6, #2856]
	cmp	r3, #0
	bne	.L396
.L329:
	ldr	r3, [r6, #2852]
	cmp	r3, #0
	beq	.L387
.L330:
	mov	r3, #1
.L387:
	strb	r3, [r4, #1]
	ldr	r3, [r5, #4]
	cmp	r3, #0
	bne	.L305
	add	r5, r5, #262144
	ldrb	r5, [r5, #1036]
	cmp	r5, #0
	bne	.L305
	ldr	r3, [r8, #48]
	mov	r2, #160
	mov	r1, r5
	mov	r0, r7
	blx	r3
	ldr	r1, [r4, #24]
	ldr	r0, [r6, #2948]
	bl	SM_ReleaseStreamSeg
	ldr	r3, .L410+20
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L305
	ldr	r0, [r6, #2948]
	mov	r3, r5
	mov	r2, r5
	mov	r1, #113
	blx	ip
	b	.L305
.L307:
	ldrd	r2, [r0, #32]
	sub	r1, fp, #68
	ldr	r9, [r0, #8]
	mov	r0, r5
	ldr	r8, [r4, #16]
	ldr	r7, [r4, #20]
	ldrb	r6, [r4, #13]
	ldr	lr, [r4, #24]
	ldrb	ip, [r4, #15]
	strd	r2, [fp, #-44]
	str	r9, [fp, #-64]
	str	r8, [fp, #-60]
	str	r7, [fp, #-56]
	strb	r6, [fp, #-68]
	str	lr, [fp, #-52]
	strb	ip, [fp, #-67]
	bl	H264DEC_DecodePacket
	cmn	r0, #2
	moveq	r3, #1
	movne	r3, #0
	strb	r3, [r4, #1]
	ldr	r4, [r5, #360]
	cmp	r4, #0
	bne	.L305
	add	r6, r5, #12288
	ldrb	r3, [r6, #1272]
	cmp	r3, #1
	bne	.L305
	add	r5, r5, #57344
	ldr	r0, [r5, #3888]
	bl	VCTRL_OutputLastFrame
	strb	r4, [r6, #1272]
	b	.L305
.L310:
	add	r6, r2, #20480
	mov	r0, r2
	ldr	r7, [r6, #2496]
	bl	MP4_GetPacketState
	cmp	r0, #3
	beq	.L397
.L347:
	mov	r1, r4
	ldr	r0, [r6, #2496]
	bl	SegMan
	cmp	r0, #0
	beq	.L398
.L349:
	ldr	r4, [r5, #1036]
	cmp	r4, #0
	bne	.L305
	ldrb	r3, [r6, #2532]
	cmp	r3, #1
	bne	.L305
	ldr	r0, [r6, #2496]
	bl	VCTRL_OutputLastFrame
	strb	r4, [r6, #2532]
	b	.L305
.L311:
	add	r6, r2, #81920
	mov	r0, r2
	ldr	r7, [r6, #4088]
	bl	MP2_GetPacketState
	cmp	r0, #2
	beq	.L399
.L343:
	mov	r1, r4
	ldr	r0, [r6, #4088]
	bl	SegMan
	cmp	r0, #0
	beq	.L400
.L345:
	ldr	r4, [r5, #4]
	cmp	r4, #0
	bne	.L305
	add	r5, r5, #86016
	ldrb	r3, [r5, #10]
	cmp	r3, #1
	bne	.L305
	ldr	r0, [r6, #4088]
	bl	VCTRL_OutputLastFrame
	strb	r4, [r5, #10]
	b	.L305
.L312:
	ldr	r3, .L410+12
	add	r6, r0, #88
	mov	r1, #1
	mov	r2, #80
	strb	r1, [r0, #1]
	mov	r0, r6
	ldr	r3, [r3, #52]
	add	r1, r4, #8
	blx	r3
	ldr	r3, .L410+24
	ldr	r3, [r3, #12]
	cmp	r3, #0
	beq	.L359
	mov	r1, r6
	mov	r0, r5
	blx	r3
	cmn	r0, #2
	beq	.L305
.L359:
	ldr	r0, [r5]
	ldr	r1, [r4, #24]
	bl	SM_ReleaseStreamSeg
	mov	r3, #0
	strb	r3, [r4, #1]
	b	.L305
.L313:
	ldrb	r3, [r0, #14]
	cmp	r3, #1
	beq	.L401
	ldr	r7, .L410+12
	add	r6, r0, #88
	add	r1, r0, #8
	mov	r2, #80
	mov	r0, r6
	ldr	r3, [r7, #52]
	blx	r3
	ldr	r3, [r7, #48]
	mov	r2, #80
	mov	r1, #0
	add	r0, r4, #168
	blx	r3
	mov	r1, r6
	mov	r0, r5
	bl	DIVX3DEC_Decode
	ldr	r8, [r5, #4]
	cmp	r8, #0
	bne	.L305
	add	r5, r5, #36864
	ldr	r3, [r7, #48]
	mov	r2, #160
	mov	r1, r8
	mov	r0, r6
	blx	r3
	ldr	r1, [r4, #24]
	ldr	r0, [r5, #2944]
	bl	SM_ReleaseStreamSeg
	ldr	r3, .L410+20
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L305
	ldr	r0, [r5, #2944]
	mov	r3, r8
	mov	r2, r8
	mov	r1, #113
	blx	ip
	b	.L305
.L314:
	mov	r0, r2
	ldr	r6, [r2, #4]
	bl	AVS_GetPacketState
	cmp	r0, #0
	bne	.L350
	ldr	r3, .L410+28
	ldr	r3, [r3, r6, asl #2]
	ldr	r2, [r3, #1424]
	cmp	r2, #1
	bne	.L351
	ldr	r3, [r3, #1464]
	cmp	r3, #0
	bne	.L350
.L351:
	add	r1, r5, #16384
	mov	r0, r5
	add	r1, r1, #104
	bl	AVSDEC_Decode
.L350:
	mov	r1, r4
	ldr	r0, [r5, #4]
	bl	SegMan
	cmp	r0, #0
	beq	.L402
.L352:
	ldr	r4, [r5, #16]
	cmp	r4, #0
	bne	.L305
	ldrb	r3, [r5]
	cmp	r3, #1
	bne	.L305
	ldr	r0, [r5, #4]
	bl	VCTRL_OutputLastFrame
	strb	r4, [r5]
	b	.L305
.L315:
	ldrb	r3, [r0, #14]
	cmp	r3, #1
	beq	.L403
	ldr	r7, .L410+12
	add	r6, r0, #88
	add	r1, r0, #8
	mov	r2, #80
	mov	r0, r6
	ldr	r3, [r7, #52]
	blx	r3
	ldr	r3, [r7, #48]
	mov	r2, #80
	mov	r1, #0
	add	r0, r4, #168
	blx	r3
	mov	r1, r6
	mov	r0, r5
	bl	REAL8DEC_Decode
	ldr	r8, [r5, #4]
	cmp	r8, #0
	bne	.L305
	add	r5, r5, #49152
	ldr	r3, [r7, #48]
	mov	r2, #160
	mov	r1, r8
	mov	r0, r6
	blx	r3
	ldr	r1, [r4, #24]
	ldr	r0, [r5, #2984]
	bl	SM_ReleaseStreamSeg
	ldr	r3, .L410+20
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L305
	ldr	r0, [r5, #2984]
	mov	r3, r8
	mov	r2, r8
	mov	r1, #113
	blx	ip
	b	.L305
.L317:
	ldrb	r3, [r0, #14]
	cmp	r3, #1
	beq	.L404
	ldr	r7, .L410+12
	add	r6, r0, #88
	add	r1, r0, #8
	mov	r2, #80
	mov	r0, r6
	ldr	r3, [r7, #52]
	blx	r3
	ldr	r3, [r7, #48]
	mov	r2, #80
	mov	r1, #0
	add	r0, r4, #168
	blx	r3
	mov	r1, r6
	mov	r0, r5
	bl	VP6DEC_Decode
	ldr	r8, [r5, #4]
	cmp	r8, #0
	bne	.L305
	add	r5, r5, #12288
	ldr	r3, [r7, #48]
	mov	r2, #160
	mov	r1, r8
	mov	r0, r6
	blx	r3
	ldr	r1, [r4, #24]
	ldr	r0, [r5, #728]
	bl	SM_ReleaseStreamSeg
	ldr	r3, .L410+20
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L305
	ldr	r0, [r5, #728]
	mov	r3, r8
	mov	r2, r8
	mov	r1, #113
	blx	ip
	b	.L305
.L318:
	ldrb	r3, [r0, #14]
	cmp	r3, #1
	beq	.L405
	ldr	r7, .L410+12
	add	r6, r0, #88
	add	r1, r0, #8
	mov	r2, #80
	mov	r0, r6
	ldr	r3, [r7, #52]
	blx	r3
	ldr	r3, [r7, #48]
	mov	r2, #80
	mov	r1, #0
	add	r0, r4, #168
	blx	r3
	mov	r1, r6
	mov	r0, r5
	bl	VP8DEC_Decode
	ldr	r8, [r5, #4]
	cmp	r8, #0
	bne	.L305
	add	r5, r5, #8192
	ldr	r3, [r7, #48]
	mov	r2, #160
	mov	r1, r8
	mov	r0, r6
	blx	r3
	ldr	r1, [r4, #24]
	ldr	r0, [r5, #344]
	bl	SM_ReleaseStreamSeg
	ldr	r3, .L410+20
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L305
	ldr	r0, [r5, #344]
	mov	r3, r8
	mov	r2, r8
	mov	r1, #113
	blx	ip
	b	.L305
.L319:
	ldrd	r2, [r0, #32]
	sub	r1, fp, #68
	ldr	r8, [r0, #8]
	mov	r0, r5
	ldr	r7, [r4, #16]
	ldr	r6, [r4, #20]
	ldrb	lr, [r4, #13]
	ldr	ip, [r4, #24]
	strd	r2, [fp, #-44]
	str	r8, [fp, #-64]
	str	r7, [fp, #-60]
	str	r6, [fp, #-56]
	strb	lr, [fp, #-68]
	str	ip, [fp, #-52]
	bl	MVC_DEC_DecodePacket
	cmn	r0, #2
	moveq	r3, #1
	movne	r3, #0
	strb	r3, [r4, #1]
	ldr	r4, [r5, #228]
	cmp	r4, #0
	bne	.L305
	ldrb	r3, [r5, #1]
	cmp	r3, #1
	bne	.L305
	ldr	r0, [r5, #120]
	bl	VCTRL_OutputLastFrame
	strb	r4, [r5, #1]
	b	.L305
.L320:
	ldrd	r2, [r0, #32]
	sub	r1, fp, #68
	ldr	r9, [r0, #8]
	mov	r0, r5
	ldr	r8, [r4, #16]
	ldr	r7, [r4, #20]
	ldrb	r6, [r4, #13]
	ldr	lr, [r4, #24]
	ldrb	ip, [r4, #15]
	strd	r2, [fp, #-44]
	str	r9, [fp, #-64]
	str	r8, [fp, #-60]
	str	r7, [fp, #-56]
	strb	r6, [fp, #-68]
	str	lr, [fp, #-52]
	strb	ip, [fp, #-67]
	bl	HEVCDEC_DecodePacket
	cmn	r0, #2
	moveq	r3, #1
	movne	r3, #0
	strb	r3, [r4, #1]
	ldr	r4, [r5, #2328]
	cmp	r4, #0
	bne	.L305
	ldrb	r3, [r5, #7]
	cmp	r3, #1
	bne	.L305
	ldr	r0, [r5, #244]
	bl	VCTRL_OutputLastFrame
	strb	r4, [r5, #7]
	b	.L305
.L316:
	ldrb	r3, [r0, #14]
	cmp	r3, #1
	beq	.L406
	ldr	r7, .L410+12
	add	r6, r0, #88
	add	r1, r0, #8
	mov	r2, #80
	mov	r0, r6
	ldr	r3, [r7, #52]
	blx	r3
	ldr	r3, [r7, #48]
	mov	r2, #80
	mov	r1, #0
	add	r0, r4, #168
	blx	r3
	mov	r1, r6
	mov	r0, r5
	bl	REAL9DEC_Decode
	ldr	r8, [r5, #4]
	cmp	r8, #0
	bne	.L305
	add	r5, r5, #49152
	ldr	r3, [r7, #48]
	mov	r2, #160
	mov	r1, r8
	mov	r0, r6
	blx	r3
	ldr	r1, [r4, #24]
	ldr	r0, [r5, #2968]
	bl	SM_ReleaseStreamSeg
	ldr	r3, .L410+20
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L305
	ldr	r0, [r5, #2968]
	mov	r3, r8
	mov	r2, r8
	mov	r1, #113
	blx	ip
	b	.L305
.L391:
	ldr	r1, .L410+32
	mov	r0, #0
	bl	dprint_vfmw
	b	.L305
.L396:
	ldr	r2, [r6, #2896]
	ldr	r3, [r6, #2892]
	cmp	r2, r3
	bne	.L330
	b	.L329
.L402:
	add	r1, r4, #88
	mov	r0, r5
	bl	AVSDEC_Decode
	b	.L352
.L400:
	add	r1, r4, #88
	mov	r0, r5
	bl	MPEG2DEC_Decode
	add	r3, r5, #86016
	ldrb	r3, [r3, #9]
	cmp	r3, #1
	movne	r3, #0
	strb	r3, [r4, #1]
	b	.L345
.L398:
	add	r1, r4, #88
	mov	r0, r5
	bl	MPEG4DEC_Decode
	b	.L349
.L399:
	ldr	r3, .L410+28
	ldr	r3, [r3, r7, asl #2]
	ldr	r2, [r3, #1424]
	cmp	r2, #1
	bne	.L344
	ldr	r3, [r3, #1464]
	cmp	r3, #0
	bne	.L343
.L344:
	add	r1, r5, #84992
	mov	r0, r5
	add	r1, r1, #120
	bl	MPEG2DEC_Decode
	b	.L343
.L397:
	ldr	r3, .L410+28
	ldr	r3, [r3, r7, asl #2]
	ldr	r2, [r3, #1424]
	cmp	r2, #1
	bne	.L348
	ldr	r3, [r3, #1464]
	cmp	r3, #0
	bne	.L347
.L348:
	add	r1, r5, #15680
	mov	r0, r5
	add	r1, r1, #40
	bl	MPEG4DEC_Decode
	b	.L347
.L404:
	add	r5, r2, #12288
	ldr	r0, [r5, #728]
	bl	VCTRL_OutputLastFrame
	ldr	r0, [r5, #728]
	ldr	r1, [r4, #24]
	bl	SM_ReleaseStreamSeg
	b	.L305
.L403:
	add	r5, r2, #49152
	ldr	r0, [r5, #2984]
	bl	VCTRL_OutputLastFrame
	ldr	r0, [r5, #2984]
	ldr	r1, [r4, #24]
	bl	SM_ReleaseStreamSeg
	b	.L305
.L406:
	add	r5, r2, #49152
	ldr	r0, [r5, #2968]
	bl	VCTRL_OutputLastFrame
	ldr	r0, [r5, #2968]
	ldr	r1, [r4, #24]
	bl	SM_ReleaseStreamSeg
	b	.L305
.L401:
	add	r5, r2, #36864
	ldr	r0, [r5, #2944]
	bl	VCTRL_OutputLastFrame
	ldr	r0, [r5, #2944]
	ldr	r1, [r4, #24]
	bl	SM_ReleaseStreamSeg
	b	.L305
.L395:
	add	r5, r2, #290816
	ldr	r0, [r5, #2948]
	bl	VCTRL_OutputLastFrame
	ldr	r0, [r5, #2948]
	ldr	r1, [r4, #24]
	bl	SM_ReleaseStreamSeg
	b	.L305
.L405:
	add	r5, r2, #8192
	ldr	r0, [r5, #344]
	bl	VCTRL_OutputLastFrame
	ldr	r0, [r5, #344]
	ldr	r1, [r4, #24]
	bl	SM_ReleaseStreamSeg
	b	.L305
.L341:
	add	r2, r5, #15808
	mov	r1, #16
	ldr	r0, [r4, #88]
	add	r2, r2, r1
	bl	Vc1SMPSeqHdr
	subs	r8, r0, #0
	beq	.L407
	add	r5, r5, #49152
	ldr	r1, .L410+36
	b	.L390
.L392:
	ldr	r1, .L410+40
	mov	r0, #0
	bl	dprint_vfmw
	b	.L305
.L394:
	add	r5, r5, #49152
	ldr	r0, [r5, #224]
	bl	VCTRL_OutputLastFrame
	ldr	r0, [r5, #224]
	ldr	r1, [r4, #24]
	bl	SM_ReleaseStreamSeg
	b	.L305
.L393:
	add	r7, r5, #49152
	mov	r0, r5
	ldr	r8, [r7, #224]
	bl	VC1_GetPacketState
	cmp	r0, #2
	beq	.L408
.L337:
	mov	r1, r4
	ldr	r0, [r7, #224]
	bl	SegMan
	subs	r8, r0, #0
	beq	.L409
.L339:
	ldr	r4, [r5, #4]
	cmp	r4, #0
	bne	.L305
	ldrb	r3, [r6, #447]
	cmp	r3, #1
	bne	.L305
	ldr	r0, [r7, #224]
	bl	VCTRL_OutputLastFrame
	strb	r4, [r6, #447]
	b	.L305
.L407:
	ldr	ip, [r4, #100]
	mov	r1, r7
	ldr	r2, [r4, #88]
	mov	r0, r5
	ldr	r3, [r4, #96]
	sub	ip, ip, #16
	add	r2, r2, #16
	str	ip, [r4, #100]
	str	r2, [r4, #88]
	add	r3, r3, #16
	str	r3, [r4, #96]
	bl	VC1DEC_Decode
	ldr	r3, [r6, #48]
	mov	r1, r8
	mov	r0, r7
	mov	r2, #160
	blx	r3
	b	.L305
.L409:
	add	r4, r4, #88
	mov	r0, r5
	mov	r1, r4
	bl	VC1DEC_Decode
	ldr	r3, .L410+12
	mov	r0, r4
	mov	r1, r8
	mov	r2, #160
	ldr	r3, [r3, #48]
	blx	r3
	b	.L339
.L408:
	ldr	r3, .L410+28
	ldr	r3, [r3, r8, asl #2]
	ldr	r2, [r3, #1424]
	cmp	r2, #1
	bne	.L338
	ldr	r3, [r3, #1464]
	cmp	r3, #0
	bne	.L337
.L338:
	add	r1, r5, #12544
	mov	r0, r5
	add	r1, r1, #24
	bl	VC1DEC_Decode
	b	.L337
.L411:
	.align	2
.L410:
	.word	.LC20
	.word	.LC21
	.word	.LC22
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC25
	.word	g_event_report
	.word	g_SdecFunc
	.word	s_pstVfmwChan
	.word	.LC23
	.word	.LC26
	.word	.LC24
	.fnend
	.size	DecodeStream, .-DecodeStream
	.align	2
	.global	ReleasePacket
	.type	ReleasePacket, %function
ReleasePacket:
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
	sub	r3, r0, #5
	cmp	r3, #12
	ldrls	pc, [pc, r3, asl #2]
	b	.L413
.L415:
	.word	.L414
	.word	.L413
	.word	.L413
	.word	.L416
	.word	.L417
	.word	.L418
	.word	.L418
	.word	.L418
	.word	.L419
	.word	.L413
	.word	.L413
	.word	.L413
	.word	.L420
.L420:
	ldr	r4, [r1]
	add	r1, r1, #290816
	ldr	r0, [r1, #2948]
	ldr	r1, [r4, #240]
	bl	SM_ReleaseStreamSeg
	ldrb	r3, [r4, #229]
	cmp	r3, #1
	beq	.L427
	ldr	r1, .L437
	mov	r0, #1
	bl	dprint_vfmw
.L427:
	ldr	r3, .L437+4
	add	r0, r4, #224
	mov	r2, #160
	mov	r1, #0
	ldr	r3, [r3, #48]
	blx	r3
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L414:
	ldr	r4, [r1]
	ldrb	r3, [r4, #229]
	cmp	r3, #1
	bne	.L427
	add	r3, r1, #36864
	ldr	r1, [r4, #240]
	ldr	r0, [r3, #2944]
	bl	SM_ReleaseStreamSeg
	b	.L427
.L416:
	ldr	r4, [r1]
	ldrb	r3, [r4, #229]
	cmp	r3, #1
	bne	.L427
	add	r3, r1, #49152
	ldr	r1, [r4, #240]
	ldr	r0, [r3, #2984]
	bl	SM_ReleaseStreamSeg
	b	.L427
.L417:
	ldr	r4, [r1]
	ldrb	r3, [r4, #229]
	cmp	r3, #1
	bne	.L427
	add	r3, r1, #49152
	ldr	r1, [r4, #240]
	ldr	r0, [r3, #2968]
	bl	SM_ReleaseStreamSeg
	b	.L427
.L418:
	ldr	r4, [r1]
	add	r1, r1, #12288
	ldr	r0, [r1, #728]
	ldr	r1, [r4, #240]
	bl	SM_ReleaseStreamSeg
	ldrb	r3, [r4, #229]
	cmp	r3, #1
	beq	.L427
	ldr	r1, .L437+8
	mov	r0, #1
	bl	dprint_vfmw
	b	.L427
.L419:
	ldr	r4, [r1]
	add	r1, r1, #8192
	ldr	r0, [r1, #344]
	ldr	r1, [r4, #240]
	bl	SM_ReleaseStreamSeg
	ldrb	r3, [r4, #229]
	cmp	r3, #1
	beq	.L427
	ldr	r1, .L437+12
	mov	r0, #1
	bl	dprint_vfmw
	b	.L427
.L413:
	mov	r2, r0
	ldr	r1, .L437+16
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L438:
	.align	2
.L437:
	.word	.LC29
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC28
	.word	.LC27
	.word	.LC30
	.fnend
	.size	ReleasePacket, .-ReleasePacket
	.align	2
	.global	ReleaseCurPic
	.type	ReleaseCurPic, %function
ReleaseCurPic:
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
	cmp	r0, #17
	ldrls	pc, [pc, r0, asl #2]
	b	.L440
.L442:
	.word	.L441
	.word	.L443
	.word	.L444
	.word	.L445
	.word	.L440
	.word	.L446
	.word	.L447
	.word	.L440
	.word	.L448
	.word	.L449
	.word	.L450
	.word	.L450
	.word	.L450
	.word	.L451
	.word	.L440
	.word	.L452
	.word	.L453
	.word	.L454
.L454:
	ldr	r4, [r1]
	add	r1, r1, #290816
	ldr	r0, [r1, #2948]
	ldr	r1, [r4, #240]
	bl	SM_ReleaseStreamSeg
	ldrb	r3, [r4, #229]
	cmp	r3, #1
	beq	.L461
	ldr	r1, .L472
	mov	r0, #1
	bl	dprint_vfmw
	b	.L461
.L441:
	mov	r0, r1
	bl	H264_ClearCurrPic
.L439:
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L444:
	mov	r0, r1
	str	r1, [fp, #-24]
	bl	MP4_ClearCurPic
	ldr	r1, [fp, #-24]
	mov	r0, r1
	bl	MP4_Clean_HeadPacket
	b	.L439
.L445:
	mov	r0, r1
	bl	MP2_ClearCurPic
	b	.L439
.L443:
	add	r3, r1, #49152
	add	r0, r1, #12672
	add	r0, r0, #56
	ldr	r1, [r3, #224]
	bl	VC1_ClearCurPic
	b	.L439
.L446:
	ldr	r4, [r1]
	ldrb	r3, [r4, #229]
	cmp	r3, #1
	beq	.L471
.L461:
	ldr	r3, .L472+4
	add	r0, r4, #224
	mov	r2, #160
	mov	r1, #0
	ldr	r3, [r3, #48]
	blx	r3
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L447:
	mov	r0, r1
	bl	AVS_ClearCurPic
	b	.L439
.L448:
	ldr	r4, [r1]
	ldrb	r3, [r4, #229]
	cmp	r3, #1
	bne	.L461
	add	r3, r1, #49152
	ldr	r1, [r4, #240]
	ldr	r0, [r3, #2984]
	bl	SM_ReleaseStreamSeg
	b	.L461
.L449:
	ldr	r4, [r1]
	ldrb	r3, [r4, #229]
	cmp	r3, #1
	bne	.L461
	add	r3, r1, #49152
	ldr	r1, [r4, #240]
	ldr	r0, [r3, #2968]
	bl	SM_ReleaseStreamSeg
	b	.L461
.L450:
	ldr	r4, [r1]
	add	r1, r1, #12288
	ldr	r0, [r1, #728]
	ldr	r1, [r4, #240]
	bl	SM_ReleaseStreamSeg
	ldrb	r3, [r4, #229]
	cmp	r3, #1
	beq	.L461
	ldr	r1, .L472+8
	mov	r0, #1
	bl	dprint_vfmw
	b	.L461
.L451:
	ldr	r4, [r1]
	add	r1, r1, #8192
	ldr	r0, [r1, #344]
	ldr	r1, [r4, #240]
	bl	SM_ReleaseStreamSeg
	ldrb	r3, [r4, #229]
	cmp	r3, #1
	beq	.L461
	ldr	r1, .L472+12
	mov	r0, #1
	bl	dprint_vfmw
	b	.L461
.L452:
	mov	r0, r1
	bl	MVC_ClearCurrPic
	b	.L439
.L453:
	mov	r0, r1
	bl	HEVC_ClearCurrPic
	b	.L439
.L440:
	mov	r2, r0
	ldr	r1, .L472+16
	mov	r0, #0
	bl	dprint_vfmw
	b	.L439
.L471:
	add	r3, r1, #36864
	ldr	r1, [r4, #240]
	ldr	r0, [r3, #2944]
	bl	SM_ReleaseStreamSeg
	b	.L461
.L473:
	.align	2
.L472:
	.word	.LC29
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC28
	.word	.LC27
	.word	.LC30
	.fnend
	.size	ReleaseCurPic, .-ReleaseCurPic
	.align	2
	.global	IsNewpicSeg
	.type	IsNewpicSeg, %function
IsNewpicSeg:
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
	cmp	r1, #2
	ldr	ip, [r2]
	movne	lr, #0
	beq	.L518
.L475:
	ldrb	r2, [ip]
	ldrb	r3, [ip, #1]
	cmp	r2, #0
	ldrb	r4, [ip, #2]
	bne	.L478
	cmp	r3, #0
	bne	.L478
	cmp	r4, #1
	bne	.L478
	cmp	r1, #16
	ldrls	pc, [pc, r1, asl #2]
	b	.L498
.L483:
	.word	.L482
	.word	.L484
	.word	.L485
	.word	.L486
	.word	.L498
	.word	.L498
	.word	.L487
	.word	.L498
	.word	.L498
	.word	.L498
	.word	.L498
	.word	.L498
	.word	.L498
	.word	.L498
	.word	.L498
	.word	.L488
	.word	.L489
.L518:
	ldrb	lr, [r2, #72]
	ands	lr, lr, #1
	beq	.L475
	ldrb	r2, [ip, #3]
	cmp	r2, #179
	cmpne	r2, #176
	add	r3, r2, #75
	moveq	r1, #1
	movne	r1, #0
	cmp	r2, #254
	orreq	r1, r1, #1
	uxtb	r3, r3
	cmp	r2, #47
	orrls	r1, r1, #1
	cmp	r3, #1
	movhi	r3, r1
	orrls	r3, r1, #1
	cmp	r3, #0
	bne	.L496
.L492:
	mov	r2, #1
	str	r2, [r0]
	ldrb	r2, [ip, #3]
	mov	r3, #0
.L493:
	cmp	r2, #182
	beq	.L516
.L509:
	mov	r0, r3
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L496:
	ldr	r3, [r0]
	cmp	r3, #0
	beq	.L492
	b	.L491
.L482:
	mov	r1, ip
	bl	H264_IsNewPicNal
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r3, r0, #0
	mov	r0, r3
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L484:
	ldrb	r2, [ip, #3]
	sub	r3, r2, #12
	cmp	r2, #10
	cmpne	r3, #3
	bls	.L519
.L505:
	mvn	r3, #0
.L495:
	cmp	r2, #13
	bne	.L509
	b	.L516
.L485:
	ldrb	r2, [ip, #3]
	cmp	r2, #179
	cmpne	r2, #176
	add	r4, r2, #75
	moveq	r3, #1
	movne	r3, #0
	cmp	r2, #254
	orreq	r3, r3, #1
	cmp	r2, #47
	movhi	r1, r3
	orrls	r1, r3, #1
	uxtb	r3, r4
	cmp	r3, #1
	movhi	r3, r1
	orrls	r3, r1, #1
	cmp	r3, #0
	bne	.L496
.L491:
	cmp	lr, #1
	mvnne	r3, #0
	bne	.L493
	b	.L492
.L486:
	ldrb	r2, [ip, #3]
	add	r3, r2, #73
	cmp	r2, #0
	cmpne	r2, #179
	uxtb	r3, r3
	moveq	r1, #1
	movne	r1, #0
	cmp	r3, #1
	movhi	r3, r1
	orrls	r3, r1, #1
	cmp	r3, #0
	bne	.L520
.L500:
	mvn	r3, #0
.L490:
	cmp	r2, #0
	bne	.L509
.L517:
	str	r2, [r0]
	mov	r0, r3
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L487:
	ldrb	r2, [ip, #3]
	sub	r1, r2, #179
	add	r3, r2, #74
	clz	r1, r1
	uxtb	r3, r3
	mov	r1, r1, lsr #5
	cmp	r2, #176
	movne	lr, r1
	orreq	lr, r1, #1
	cmp	r3, #1
	movhi	r3, lr
	orrls	r3, lr, #1
	cmp	r3, #0
	bne	.L521
.L503:
	mvn	r3, #0
.L494:
	cmp	r2, #182
	movne	r2, r1
	orreq	r2, r1, #1
	cmp	r2, #0
	beq	.L509
.L516:
	mov	r2, #0
	b	.L517
.L488:
	mov	r1, ip
	bl	MVC_IsNewPicNal
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r3, r0, #0
	mov	r0, r3
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L489:
	mov	r1, ip
	bl	HEVC_IsNewPicNal
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r3, r0, #0
	mov	r0, r3
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L498:
	mvn	r3, #0
	b	.L509
.L478:
	str	r4, [sp]
	mov	r0, #22
	ldr	r1, .L522
	bl	dprint_vfmw
	mvn	r3, #0
	mov	r0, r3
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L519:
	ldr	r3, [r0]
	cmp	r3, #0
	bne	.L505
	mov	r2, #1
	str	r2, [r0]
	ldrb	r2, [ip, #3]
	b	.L495
.L521:
	ldr	r3, [r0]
	cmp	r3, #0
	bne	.L503
	mov	r2, #1
	str	r2, [r0]
	ldrb	r2, [ip, #3]
	sub	r1, r2, #179
	clz	r1, r1
	mov	r1, r1, lsr #5
	b	.L494
.L520:
	ldr	r3, [r0]
	cmp	r3, #0
	bne	.L500
	mov	r2, #1
	str	r2, [r0]
	ldrb	r2, [ip, #3]
	b	.L490
.L523:
	.align	2
.L522:
	.word	.LC31
	.fnend
	.size	IsNewpicSeg, .-IsNewpicSeg
	.align	2
	.global	OpenUsdPool
	.type	OpenUsdPool, %function
OpenUsdPool:
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
	ldr	r4, .L531
	add	r4, r4, r0, lsl #2
	ldr	ip, [r4, #64]
	cmp	ip, #0
	beq	.L530
.L525:
	add	r1, ip, #203776
	mov	r0, #0
	add	r1, r1, #512
	mov	r3, ip
	mov	r2, r0
	str	r0, [ip]
.L527:
	str	r2, [r3, #1048]
	add	r3, r3, #1056
	str	r2, [r3, #-12]
	add	r3, r3, #8
	cmp	r3, r1
	bne	.L527
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L530:
	ldr	r3, .L531+4
	movw	r0, #7688
	movt	r0, 3
	ldr	r3, [r3, #188]
	blx	r3
	cmp	r0, #0
	str	r0, [r4, #64]
	movne	ip, r0
	bne	.L525
.L528:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L532:
	.align	2
.L531:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	OpenUsdPool, .-OpenUsdPool
	.align	2
	.global	CloseUsdPool
	.type	CloseUsdPool, %function
CloseUsdPool:
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
	ldr	r4, .L538
	add	r4, r4, r0, lsl #2
	ldr	r0, [r4, #64]
	cmp	r0, #0
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r3, .L538+4
	ldr	r3, [r3, #192]
	blx	r3
	mov	r3, #0
	str	r3, [r4, #64]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L539:
	.align	2
.L538:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	CloseUsdPool, .-CloseUsdPool
	.align	2
	.global	OpenUsdPool_WithMem
	.type	OpenUsdPool_WithMem, %function
OpenUsdPool_WithMem:
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
	ldr	r3, .L547
	add	r0, r3, r0, lsl #2
	ldr	ip, [r0, #64]
	cmp	ip, #0
	beq	.L546
.L541:
	add	r1, ip, #203776
	mov	r0, #0
	add	r1, r1, #512
	mov	r3, ip
	mov	r2, r0
	str	r0, [ip]
.L543:
	str	r2, [r3, #1048]
	add	r3, r3, #1056
	str	r2, [r3, #-12]
	add	r3, r3, #8
	cmp	r3, r1
	bne	.L543
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L546:
	cmp	r1, #0
	str	r1, [r0, #64]
	movne	ip, r1
	bne	.L541
.L544:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L548:
	.align	2
.L547:
	.word	.LANCHOR0
	.fnend
	.size	OpenUsdPool_WithMem, .-OpenUsdPool_WithMem
	.align	2
	.global	CloseUsdPool_WithMem
	.type	CloseUsdPool_WithMem, %function
CloseUsdPool_WithMem:
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
	ldr	r3, .L554
	add	r0, r3, r0, lsl #2
	ldr	r3, [r0, #64]
	cmp	r3, #0
	movne	r3, #0
	strne	r3, [r0, #64]
	ldmfd	sp, {fp, sp, pc}
.L555:
	.align	2
.L554:
	.word	.LANCHOR0
	.fnend
	.size	CloseUsdPool_WithMem, .-CloseUsdPool_WithMem
	.align	2
	.global	InitUsdPool
	.type	InitUsdPool, %function
InitUsdPool:
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
	ldr	r3, .L561
	add	r0, r3, r0, lsl #2
	ldr	r0, [r0, #64]
	cmp	r0, #0
	beq	.L559
	add	r1, r0, #203776
	mov	ip, #0
	add	r1, r1, #512
	mov	r3, r0
	mov	r2, ip
	str	ip, [r0]
.L558:
	str	r2, [r3, #1048]
	add	r3, r3, #1056
	str	r2, [r3, #-12]
	add	r3, r3, #8
	cmp	r3, r1
	bne	.L558
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L559:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L562:
	.align	2
.L561:
	.word	.LANCHOR0
	.fnend
	.size	InitUsdPool, .-InitUsdPool
	.align	2
	.global	GetUsd
	.type	GetUsd, %function
GetUsd:
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
	ldr	r3, .L570
	add	r0, r3, r0, lsl #2
	ldr	ip, [r0, #64]
	cmp	ip, #0
	beq	.L567
	mov	r3, ip
	mov	r2, #0
	b	.L566
.L565:
	add	r2, r2, #1
	add	r3, r3, #1056
	cmp	r2, #192
	add	r3, r3, #8
	beq	.L569
.L566:
	ldr	r1, [r3, #1048]
	cmp	r1, #0
	bne	.L565
	ldr	r1, [r3, #1044]
	cmp	r1, #0
	bne	.L565
	movw	r0, #1064
	mov	r4, #0
	mul	r3, r0, r2
	mov	r5, #0
	mla	r2, r2, r0, r0
	add	r6, ip, r3
	add	r3, r3, #8
	add	lr, r6, #1024
	add	r0, ip, r3
	str	r1, [r6, #1044]
	add	lr, lr, #8
	strd	r4, [ip, r2]
	str	r1, [r6, #1060]
	str	r1, [r6, #1056]
	str	r1, [r6, #1052]
	strb	r1, [r6, #1034]
	strb	r1, [r6, #1035]
	strb	r1, [r6, #1036]
	strh	r1, [lr, #6]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L569:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L567:
	mov	r0, ip
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L571:
	.align	2
.L570:
	.word	.LANCHOR0
	.fnend
	.size	GetUsd, .-GetUsd
	.align	2
	.global	FreeUsdByDec
	.type	FreeUsdByDec, %function
FreeUsdByDec:
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
	movne	r3, #0
	strne	r3, [r1, #1040]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	FreeUsdByDec, .-FreeUsdByDec
	.align	2
	.global	MarkUsdByDnr
	.type	MarkUsdByDnr, %function
MarkUsdByDnr:
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
	movne	r3, #1
	strne	r3, [r1, #1036]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MarkUsdByDnr, .-MarkUsdByDnr
	.align	2
	.global	UnMarkUsdByDnr
	.type	UnMarkUsdByDnr, %function
UnMarkUsdByDnr:
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
	movne	r3, #0
	strne	r3, [r1, #1036]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	UnMarkUsdByDnr, .-UnMarkUsdByDnr
	.align	2
	.global	IsImageInVoQueue
	.type	IsImageInVoQueue, %function
IsImageInVoQueue:
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
	beq	.L598
	ldrh	r3, [r0, #4]
	ldrh	lr, [r0, #8]
	and	r3, r3, #63
	cmp	lr, r3
	beq	.L592
.L591:
	add	r2, r0, r3, lsl #2
	add	r3, r3, #1
	and	r3, r3, #63
	ldr	r2, [r2, #12]
	cmp	r2, #0
	beq	.L590
	ldr	ip, [r2, #156]
	ldr	r2, [r1, #156]
	cmp	ip, r2
	beq	.L593
.L590:
	cmp	r3, lr
	bne	.L591
.L592:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L593:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L598:
	mov	r0, r1
	ldr	r1, .L599
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L600:
	.align	2
.L599:
	.word	.LC5
	.fnend
	.size	IsImageInVoQueue, .-IsImageInVoQueue
	.align	2
	.global	IsVoQueueEmpty
	.type	IsVoQueueEmpty, %function
IsVoQueueEmpty:
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
	beq	.L605
	ldrh	r0, [r4, #8]
	ldrh	r3, [r4, #6]
	cmp	r0, r3
	ldreqh	r3, [r4, #4]
	rsbeq	r0, r0, r3
	clzeq	r0, r0
	moveq	r0, r0, lsr #5
	movne	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L605:
	ldr	r2, .L606
	ldr	r1, .L606+4
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L607:
	.align	2
.L606:
	.word	.LANCHOR1+20
	.word	.LC32
	.fnend
	.size	IsVoQueueEmpty, .-IsVoQueueEmpty
	.align	2
	.global	SetAspectRatio
	.type	SetAspectRatio, %function
SetAspectRatio:
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
	mov	r3, r0
	cmp	r1, #5
	ldrls	pc, [pc, r1, asl #2]
	b	.L609
.L611:
	.word	.L610
	.word	.L612
	.word	.L613
	.word	.L614
	.word	.L615
	.word	.L616
.L616:
	mov	r1, #0
	mov	r2, #2
	stmia	r0, {r1, r2}
	ldmfd	sp, {fp, sp, pc}
.L610:
	mov	r1, #0
	mov	r2, #1
	stmia	r0, {r1, r2}
	ldmfd	sp, {fp, sp, pc}
.L612:
	mov	r1, #4
	mov	r2, #3
	stmia	r0, {r1, r2}
	ldmfd	sp, {fp, sp, pc}
.L613:
	mov	r1, #16
	mov	r2, #9
	stmia	r0, {r1, r2}
	ldmfd	sp, {fp, sp, pc}
.L614:
	mov	r1, #221
	mov	r2, #100
	stmia	r0, {r1, r2}
	ldmfd	sp, {fp, sp, pc}
.L615:
	mov	r1, #235
	mov	r2, #100
	stmia	r0, {r1, r2}
	ldmfd	sp, {fp, sp, pc}
.L609:
	mov	r2, r1
	mov	ip, #0
	mov	r0, #1
	ldr	r1, .L618
	str	r0, [r3, #4]
	str	ip, [r3]
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L619:
	.align	2
.L618:
	.word	.LC33
	.fnend
	.size	SetAspectRatio, .-SetAspectRatio
	.align	2
	.global	GetVoLastImageID
	.type	GetVoLastImageID, %function
GetVoLastImageID:
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
	ldr	r0, [r0, #296]
	cmp	r0, #1
	mvnls	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	GetVoLastImageID, .-GetVoLastImageID
	.align	2
	.global	IsMain10Profile
	.type	IsMain10Profile, %function
IsMain10Profile:
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
	add	r0, r0, #81920
	ldr	r3, [r0, #2904]
	cmp	r3, #1
	beq	.L627
	ldr	r2, [r0, #2908]
	cmp	r2, #1
	beq	.L627
	cmp	r3, #2
	moveq	r3, #1
	ldrne	r3, [r0, #2912]
	subne	r3, r3, #1
	clzne	r3, r3
	movne	r3, r3, lsr #5
.L625:
	ldr	r0, [r0, #2912]
	cmp	r0, #1
	movne	r0, r3
	orreq	r0, r3, #1
	ldmfd	sp, {fp, sp, pc}
.L627:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	IsMain10Profile, .-IsMain10Profile
	.global	pstVdecUsdPool
	.global	g_DnrEnable
	.section	.rodata
	.align	2
.LANCHOR1 = . + 0
	.type	__FUNCTION__.15067, %object
	.size	__FUNCTION__.15067, 19
__FUNCTION__.15067:
	.ascii	"InsertImgToVoQueue\000"
	.space	1
	.type	__func__.15322, %object
	.size	__func__.15322, 15
__func__.15322:
	.ascii	"IsVoQueueEmpty\000"
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Initializing VO queue\012\000"
	.space	1
.LC1:
	.ascii	"VoQueue state: head(%d) history(%d) tail(%d)\000"
	.space	3
.LC2:
	.ascii	"\012\000"
	.space	2
.LC3:
	.ascii	"%d \000"
.LC4:
	.ascii	"ResetVoQueue but queue not empty: head(%d) history("
	.ascii	"%d) tail(%d)\012\000"
	.space	3
.LC5:
	.ascii	"image point NULL\012\000"
	.space	2
.LC6:
	.ascii	"call InsertVOQueue\012\000"
.LC7:
	.ascii	"FATAL: p_image(id=%d) has already in the VoQueue!\012"
	.ascii	"\000"
	.space	1
.LC8:
	.ascii	"error=%d,W=%d,H=%d,not acceptable!\012\000"
.LC9:
	.ascii	"out_pts: %lld -> %lld Usertag %lld\012\000"
.LC10:
	.ascii	"Queue=(%02d,%02d,%02d) + F%d\012\000"
	.space	2
.LC11:
	.ascii	"Queue=(%02d,%02d,%02d) - F%d\012\000"
	.space	2
.LC12:
	.ascii	"SYNTAX_ReleaseImage p_image is null\012\000"
	.space	3
.LC13:
	.ascii	"Image %d not found in vo queue.\012\000"
	.space	3
.LC14:
	.ascii	"image[%d] null\012\000"
.LC15:
	.ascii	"Queue=(%02d,%02d,%02d) x F%d\012\000"
	.space	2
.LC16:
	.ascii	"pSegMan error!\012\000"
.LC17:
	.ascii	"More than two packet!!!ERROR!!!\012\000"
	.space	3
.LC18:
	.ascii	"*****************copy packets tobe one*************"
	.ascii	"****\012\000"
	.space	3
.LC19:
	.ascii	"*****************two packet*****************\012\000"
	.space	2
.LC20:
	.ascii	"pSegMan->CurrSeg.IsLastSeg=%d\012\000"
	.space	1
.LC21:
	.ascii	"pSegMan->CurrSeg.PhyAddr=%#x\012\000"
	.space	2
.LC22:
	.ascii	"pSegMan->CurrSeg.LenInByte=%#x\012\000"
.LC23:
	.ascii	"ERROR: Wrong PreParseInfo about Vc1 IsAdvProfile!\012"
	.ascii	"\000"
	.space	1
.LC24:
	.ascii	"ERROR: Wrong PreParseInfo about Vc1 CodecVersion!\012"
	.ascii	"\000"
	.space	1
.LC25:
	.ascii	"LENTH ERROR: VC1 S/MP BS is wrong!\012\000"
.LC26:
	.ascii	"SYNTAX ERROR: VC1 S/MP BS is wrong!\012\000"
	.space	3
.LC27:
	.ascii	"ERROR: VFMW_VP8 one packet stream, but IsLastSeg =="
	.ascii	" 0\012\000"
	.space	1
.LC28:
	.ascii	"ERROR: VFMW_VP6 one packet stream, but IsLastSeg =="
	.ascii	" 0\012\000"
	.space	1
.LC29:
	.ascii	"ERROR: VFMW_VP9 one packet stream, but IsLastSeg =="
	.ascii	" 0\012\000"
	.space	1
.LC30:
	.ascii	"VidStd=%d Error!\012\000"
	.space	2
.LC31:
	.ascii	"pu8[0] = %x,pu8[1] = %x, pu8[2] = %x\012\000"
	.space	2
.LC32:
	.ascii	"%s pstVoQue NULL\012\000"
	.space	2
.LC33:
	.ascii	"WARNNING: aspect ration (%d) is not expected!\012\000"
	.bss
	.align	2
.LANCHOR0 = . + 0
	.type	last_rec_pos_time.15059, %object
	.size	last_rec_pos_time.15059, 64
last_rec_pos_time.15059:
	.space	64
	.type	pstVdecUsdPool, %object
	.size	pstVdecUsdPool, 64
pstVdecUsdPool:
	.space	64
	.type	g_DnrEnable, %object
	.size	g_DnrEnable, 4
g_DnrEnable:
	.space	4
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
