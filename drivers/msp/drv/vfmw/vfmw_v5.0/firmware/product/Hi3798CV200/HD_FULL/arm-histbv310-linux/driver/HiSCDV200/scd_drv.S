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
	.file	"scd_drv.c"

	.text
	.align	2
	.global	WriteCabacTabDsp
	.type	WriteCabacTabDsp, %function
WriteCabacTabDsp:
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
	bl	MEM_Phy2Vir
	cmp	r0, #0
	beq	.L5
	ldr	r3, .L6
	mov	r2, #5120
	ldr	r1, .L6+4
	ldr	r3, [r3, #52]
	blx	r3
	ldmfd	sp, {fp, sp, pc}
.L5:
	mov	r2, #120
	ldr	r1, .L6+8
	mov	r0, #22
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L7:
	.align	2
.L6:
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_CabacMN
	.word	.LC2
	.fnend
	.size	WriteCabacTabDsp, .-WriteCabacTabDsp
	.align	2
	.global	SCDDRV_LoadDspCode
	.type	SCDDRV_LoadDspCode, %function
SCDDRV_LoadDspCode:
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
	subs	r4, r0, #0
	mov	r7, r1
	ldmnefd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	r5, .L28
	ldr	r0, [r5]
	bl	MEM_Phy2Vir
	cmp	r0, #0
	beq	.L23
	cmp	r7, #1
	beq	.L24
	cmp	r7, #2
	beq	.L25
	mov	r0, r4
	ldr	r1, .L28+4
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L25:
	ldr	r6, .L28+8
	mov	r2, #17920
	ldr	r1, .L28+12
	ldr	r3, [r6, #52]
	blx	r3
	mov	r1, r4
	ldr	r0, [r5, #4]
	bl	MEM_WritePhyWord
.L13:
	ldr	r0, [r5, #4]
	mov	r1, #4480
	mov	r4, #0
	add	r0, r0, #264
	bl	MEM_WritePhyWord
	ldr	r0, [r5, #4]
	ldr	r1, [r5]
	add	r0, r0, #268
	bl	MEM_WritePhyWord
	ldr	r0, [r5, #4]
	mov	r1, r4
	add	r0, r0, #256
	bl	MEM_WritePhyWord
	ldr	r0, [r5, #4]
	mov	r1, #5
	add	r0, r0, #256
	bl	MEM_WritePhyWord
	b	.L16
.L26:
	add	r4, r4, #1
	cmp	r4, #1000
	beq	.L17
.L16:
	ldr	r3, [r6, #112]
	mov	r0, #30
	blx	r3
	ldr	r0, [r5, #4]
	add	r0, r0, #260
	bl	MEM_ReadPhyWord
	tst	r0, #1
	beq	.L26
	cmp	r4, #1000
	bcs	.L17
	ldr	r2, .L28+16
	mov	r0, #0
	ldr	r1, .L28+20
	bl	dprint_vfmw
.L19:
	cmp	r7, #1
	beq	.L27
	cmp	r7, #2
	ldreq	r3, .L28+24
	moveq	r2, #1
	streq	r2, [r3]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L17:
	ldr	r2, .L28+16
	mov	r0, #0
	ldr	r1, .L28+28
	bl	dprint_vfmw
	b	.L19
.L24:
	ldr	r6, .L28+8
	mov	r2, #17920
	ldr	r1, .L28+32
	ldr	r3, [r6, #52]
	blx	r3
	mov	r1, r7
	ldr	r0, [r5, #4]
	bl	MEM_WritePhyWord
	b	.L13
.L27:
	ldr	r3, .L28+24
	mov	r2, #2
	str	r2, [r3]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L23:
	ldr	r2, [r5]
	ldr	r1, .L28+36
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L29:
	.align	2
.L28:
	.word	.LANCHOR0
	.word	.LC4
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR2+1552
	.word	.LANCHOR3
	.word	.LC6
	.word	g_DspDrvState
	.word	.LC5
	.word	.LANCHOR1
	.word	.LC3
	.fnend
	.size	SCDDRV_LoadDspCode, .-SCDDRV_LoadDspCode
	.align	2
	.global	GetInstIDByRawArray
	.type	GetInstIDByRawArray, %function
GetInstIDByRawArray:
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
	ldr	r2, .L39
	mov	r3, #0
.L33:
	ldr	r1, [r2, #48]
	add	r2, r2, #56
	cmp	r1, #0
	add	ip, r1, #112
	beq	.L31
	cmp	r0, ip
	beq	.L34
.L31:
	add	r3, r3, #1
	cmp	r3, #16
	bne	.L33
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L34:
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L40:
	.align	2
.L39:
	.word	.LANCHOR0+8
	.fnend
	.size	GetInstIDByRawArray, .-GetInstIDByRawArray
	.align	2
	.global	ResetSCD
	.type	ResetSCD, %function
ResetSCD:
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
	ldr	r5, .L62
	mov	r7, r0, asl #2
	mov	r4, r0
	add	r8, r5, r7
	mov	r1, #3
	ldr	r0, [r8, #4]
	add	r0, r0, #2176
	bl	MEM_WritePhyWord
	ldr	r0, [r8, #4]
	ldr	r8, .L62+4
	add	r0, r0, #2064
	add	r0, r0, #12
	bl	MEM_ReadPhyWord
	cmp	r4, #0
	ldr	lr, [r8]
	mov	r9, r0
	bne	.L45
	ldr	r6, [lr, #120]
	ands	r2, r6, #1
	orrne	r6, r6, #32
	strne	r6, [lr, #120]
	beq	.L59
.L45:
	mov	r3, #0
	movw	r2, #10000
	b	.L47
.L50:
	add	r3, r3, #1
	cmp	r3, r2
	beq	.L60
.L47:
	cmp	r4, #0
	ldr	ip, [lr, #372]
	bne	.L50
	tst	ip, #2
	beq	.L50
	movw	r2, #9999
	cmp	r3, r2
	bhi	.L61
.L52:
	bfc	r6, #5, #1
	str	r6, [lr, #120]
.L51:
	add	r5, r5, r7
	and	r1, r9, #1
	ldr	r0, [r5, #4]
	add	r0, r0, #2064
	add	r0, r0, #12
	bl	MEM_WritePhyWord
	ldr	r0, [r5, #4]
	mov	r1, #2
	add	r0, r0, #2176
	bl	MEM_WritePhyWord
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L60:
	mov	r2, r4
	ldr	r1, .L62+8
	mov	r0, #0
	bl	dprint_vfmw
	cmp	r4, #0
	bne	.L51
.L53:
	ldr	lr, [r8]
	b	.L52
.L59:
	ldr	r1, .L62+12
	mov	r0, #26
	bl	dprint_vfmw
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L61:
	mov	r2, r4
	mov	r0, r4
	ldr	r1, .L62+8
	bl	dprint_vfmw
	b	.L53
.L63:
	.align	2
.L62:
	.word	.LANCHOR0
	.word	g_pstRegCrg
	.word	.LC8
	.word	.LC7
	.fnend
	.size	ResetSCD, .-ResetSCD
	.align	2
	.global	SCDDRV_ResetSCD
	.type	SCDDRV_ResetSCD, %function
SCDDRV_ResetSCD:
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
	ldr	r4, .L68
	ldr	r3, [r4, #984]
	cmp	r3, r0
	ldmnefd	sp, {r4, r5, fp, sp, pc}
	ldr	r3, .L68+4
	ldrb	r3, [r3]
	cmp	r3, #1
	beq	.L66
	mov	r1, #0
	mov	r0, r1
	bl	VDH_Reset_Module
.L67:
	mov	r3, #0
	str	r3, [r4, #988]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L66:
	mov	r0, #0
	bl	ResetSCD
	b	.L67
.L69:
	.align	2
.L68:
	.word	.LANCHOR0
	.word	g_HalDisable
	.fnend
	.size	SCDDRV_ResetSCD, .-SCDDRV_ResetSCD
	.align	2
	.global	SCDDRV_MaskInt
	.type	SCDDRV_MaskInt, %function
SCDDRV_MaskInt:
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
	ldr	r3, .L71
	mov	r1, #1
	add	r0, r3, r0, lsl #2
	ldr	r0, [r0, #4]
	add	r0, r0, #2064
	add	r0, r0, #12
	bl	MEM_WritePhyWord
	ldmfd	sp, {fp, sp, pc}
.L72:
	.align	2
.L71:
	.word	.LANCHOR0
	.fnend
	.size	SCDDRV_MaskInt, .-SCDDRV_MaskInt
	.align	2
	.global	SCDDRV_EnableInt
	.type	SCDDRV_EnableInt, %function
SCDDRV_EnableInt:
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
	ldr	r3, .L74
	mov	r1, #0
	add	r0, r3, r0, lsl #2
	ldr	r0, [r0, #4]
	add	r0, r0, #2064
	add	r0, r0, #12
	bl	MEM_WritePhyWord
	ldmfd	sp, {fp, sp, pc}
.L75:
	.align	2
.L74:
	.word	.LANCHOR0
	.fnend
	.size	SCDDRV_EnableInt, .-SCDDRV_EnableInt
	.align	2
	.global	ResetRawStreamArray
	.type	ResetRawStreamArray, %function
ResetRawStreamArray:
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
	cmp	r0, #0
	ldmeqfd	sp, {fp, sp, pc}
	ldr	r3, .L81
	movw	r2, #32792
	movt	r2, 1
	mov	r1, #0
	ldr	r3, [r3, #48]
	blx	r3
	ldmfd	sp, {fp, sp, pc}
.L82:
	.align	2
.L81:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	ResetRawStreamArray, .-ResetRawStreamArray
	.align	2
	.global	InsertRawPacket
	.type	InsertRawPacket, %function
InsertRawPacket:
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
	moveq	r5, #1
	movne	r5, #0
	beq	.L85
	add	r4, r0, #98304
	ldmib	r4, {ip, lr}
	add	r3, ip, #1
	mov	r2, r3, asr #31
	mov	r2, r2, lsr #22
	add	r3, r3, r2
	ubfx	r3, r3, #0, #10
	rsb	r3, r2, r3
	cmp	r3, lr
	beq	.L86
	ldr	lr, .L87
	mov	r3, ip, asl #7
	sub	ip, r3, ip, asl #5
	mov	r2, #96
	add	r0, r0, ip
	ldr	r3, [lr, #52]
	blx	r3
	ldr	r3, [r4, #4]
	mov	r0, r5
	add	r3, r3, #1
	mov	r2, r3, asr #31
	mov	r2, r2, lsr #22
	add	r3, r3, r2
	ubfx	r3, r3, #0, #10
	rsb	r3, r2, r3
	str	r3, [r4, #4]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L85:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L86:
	mvn	r0, #3
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L88:
	.align	2
.L87:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	InsertRawPacket, .-InsertRawPacket
	.align	2
	.global	GetRawState
	.type	GetRawState, %function
GetRawState:
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
	bhi	.L92
	ldr	r3, .L94
	mov	r2, r0, asl #6
	sub	r0, r2, r0, asl #3
	add	r0, r3, r0
	ldr	r3, [r0, #56]
	cmp	r3, #0
	beq	.L92
	add	r2, r3, #98304
	ldr	r3, [r2, #116]
	ldr	r1, [r2, #120]
	add	r3, r3, #1
	mov	r2, r3, asr #31
	mov	r2, r2, lsr #22
	add	r3, r3, r2
	ubfx	r3, r3, #0, #10
	rsb	r3, r2, r3
	cmp	r3, r1
	mvneq	r0, #3
	movne	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L92:
	mvn	r0, #3
	ldmfd	sp, {fp, sp, pc}
.L95:
	.align	2
.L94:
	.word	.LANCHOR0
	.fnend
	.size	GetRawState, .-GetRawState
	.align	2
	.global	ShowFirstRawPacket
	.type	ShowFirstRawPacket, %function
ShowFirstRawPacket:
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
	mov	lr, r0
	moveq	r4, #1
	movne	r4, #0
	beq	.L98
	add	r2, r0, #98304
	ldr	r3, [r2]
	ldr	r0, [r2, #4]
	cmp	r3, r0
	beq	.L99
	ldr	r5, .L100
	mov	ip, r3, asl #7
	sub	ip, ip, r3, asl #5
	str	r3, [r2, #16]
	mov	r0, r1
	mov	r2, #96
	add	r1, lr, ip
	ldr	r3, [r5, #52]
	blx	r3
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L98:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L99:
	mvn	r0, #2
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L101:
	.align	2
.L100:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	ShowFirstRawPacket, .-ShowFirstRawPacket
	.align	2
	.global	ShowNextRawPacket
	.type	ShowNextRawPacket, %function
ShowNextRawPacket:
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
	mov	lr, r0
	moveq	r4, #1
	movne	r4, #0
	beq	.L104
	add	ip, r0, #98304
	ldr	r2, [ip, #16]
	ldr	r0, [ip, #4]
	add	r2, r2, #1
	mov	r3, r2, asr #31
	mov	r3, r3, lsr #22
	add	r2, r2, r3
	ubfx	r2, r2, #0, #10
	rsb	r3, r3, r2
	cmp	r0, r3
	beq	.L105
	ldr	r5, .L106
	mov	r2, r3, asl #7
	sub	r2, r2, r3, asl #5
	str	r3, [ip, #16]
	mov	r0, r1
	add	r1, lr, r2
	ldr	r3, [r5, #52]
	mov	r2, #96
	blx	r3
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L104:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L105:
	mvn	r0, #2
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L107:
	.align	2
.L106:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	ShowNextRawPacket, .-ShowNextRawPacket
	.align	2
	.global	SetFirstOffset
	.type	SetFirstOffset, %function
SetFirstOffset:
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
	cmp	r0, #0
	beq	.L112
	add	r3, r0, #98304
	ldmia	r3, {r2, ip}
	cmp	r2, ip
	beq	.L111
	mov	ip, r2, asl #7
	ldr	lr, [r3, #12]
	sub	r2, ip, r2, asl #5
	add	r0, r0, r2
	add	r1, r1, lr
	ldr	r2, [r0, #8]
	cmp	r1, r2
	bge	.L112
	str	r1, [r3, #12]
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L112:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L111:
	mvn	r0, #2
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	SetFirstOffset, .-SetFirstOffset
	.align	2
	.global	GetFirstOffset
	.type	GetFirstOffset, %function
GetFirstOffset:
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
	cmpne	r0, #0
	moveq	r2, #1
	movne	r2, #0
	beq	.L115
	add	r3, r0, #98304
	ldr	ip, [r3]
	ldr	r0, [r3, #4]
	cmp	ip, r0
	beq	.L116
	ldr	r3, [r3, #12]
	mov	r0, r2
	str	r3, [r1]
	ldmfd	sp, {fp, sp, pc}
.L115:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L116:
	mvn	r0, #2
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	GetFirstOffset, .-GetFirstOffset
	.align	2
	.global	DeleteRawPacket
	.type	DeleteRawPacket, %function
DeleteRawPacket:
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
	cmp	r1, #0
	cmpne	r0, #0
	mov	r9, r0
	mov	r8, r1
	moveq	r6, #1
	movne	r6, #0
	beq	.L133
	ldr	r3, .L147
.L122:
	ldr	r2, [r3, #48]
	add	r3, r3, #56
	cmp	r2, #0
	add	r1, r2, #112
	beq	.L119
	cmp	r9, r1
	beq	.L145
.L119:
	add	r6, r6, #1
	cmp	r6, #16
	bne	.L122
.L120:
	movw	r2, #674
	ldr	r1, .L147+4
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L140
.L145:
	cmp	r6, #0
	blt	.L120
	add	r3, r9, #98304
	str	r3, [fp, #-52]
	mov	r2, r3
	ldr	r3, [r3]
	ldr	r2, [r2, #4]
	cmp	r3, r2
	addgt	r2, r2, #1024
	rsb	r2, r3, r2
	cmp	r2, r8
	bcc	.L146
	cmp	r8, #0
	mov	r5, r3
	beq	.L126
	mov	r3, r6, asl #3
	mov	r6, r6, asl #6
	ldr	r10, .L147+8
	mov	r7, #0
	str	r3, [fp, #-48]
	mov	r3, r6
	mov	r6, r7
	mov	r7, r3
.L127:
	mov	r4, r5, asl #7
	ldr	r2, .L147+12
	sub	r4, r4, r5, asl #5
	ldr	r1, .L147+16
	add	r4, r9, r4
	mov	r0, #26
	add	r6, r6, #1
	add	r5, r5, #1
	ldmib	r4, {r3, lr}
	ubfx	r5, r5, #0, #10
	str	lr, [sp]
	bl	dprint_vfmw
	ldr	r3, [fp, #-48]
	ldr	r1, [r4, #8]
	cmp	r6, r8
	rsb	r2, r3, r7
	add	r2, r10, r2
	ldr	r2, [r2, #56]
	add	r2, r2, #98304
	ldr	r3, [r2, #132]
	rsb	r3, r1, r3
	bic	r3, r3, r3, asr #31
	str	r3, [r2, #132]
	bne	.L127
	ldr	r2, [fp, #-52]
	ldr	r3, [r2]
	add	r7, r6, r3
	str	r7, [r2]
	cmp	r7, #1024
	ldrge	r3, [fp, #-52]
	subge	r7, r7, #1024
	strge	r7, [r3]
.L132:
	ldr	r3, [fp, #-52]
	mov	r0, #0
	str	r0, [r3, #12]
.L140:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L126:
	ldr	r2, [fp, #-52]
	cmp	r3, #1024
	str	r3, [r2]
	ldrge	r2, [fp, #-52]
	subge	r3, r3, #1024
	strge	r3, [r2]
.L130:
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L133:
	mvn	r0, #0
	b	.L140
.L146:
	mov	r3, r8
	ldr	r1, .L147+20
	mov	r0, #26
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L140
.L148:
	.align	2
.L147:
	.word	.LANCHOR0+8
	.word	.LC9
	.word	.LANCHOR0
	.word	.LANCHOR3+20
	.word	.LC11
	.word	.LC10
	.fnend
	.size	DeleteRawPacket, .-DeleteRawPacket
	.align	2
	.global	GetRawNumOffsert
	.type	GetRawNumOffsert, %function
GetRawNumOffsert:
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
	clz	lr, r0
	mov	r7, r1
	add	r8, fp, #24
	str	r2, [fp, #-52]
	mov	lr, lr, lsr #5
	str	r3, [fp, #-56]
	orrs	r1, lr, r7, lsr #31
	mov	r5, r0
	ldr	r6, [fp, #4]
	ldmia	r8, {r8, r9, r10}
	bne	.L159
	cmp	r3, #0
	cmpne	r2, #0
	moveq	ip, #1
	movne	ip, #0
	beq	.L159
	add	r3, r0, #98304
	cmp	lr, #0
	str	r3, [fp, #-48]
	ldr	lr, [r3]
	ldr	r0, [r3, #12]
	mov	r1, lr, asl #5
	mov	r3, lr, asl #7
	rsb	r2, r1, r3
	add	r2, r5, r2
	ldr	r4, [r2, #8]
	rsb	r4, r0, r4
	bne	.L151
	ldr	r2, [fp, #-48]
	ldr	ip, [r2, #4]
	subs	ip, ip, lr
	addmi	ip, ip, #1024
.L157:
	rsb	r1, r1, r3
	ldr	r0, [fp, #8]
	add	r1, r5, r1
	add	lr, ip, lr
	ldrd	r2, [r1, #64]
	strd	r2, [r6]
	ldrd	r2, [r1, #48]
	strd	r2, [r0]
	ldrd	r2, [r1, #64]
	ldr	r0, [fp, #12]
	strd	r2, [r10]
	ldrd	r2, [r1, #56]
	strd	r2, [r0]
	ldr	r2, [fp, #16]
	ldr	r3, [r1, #20]
	str	r3, [r2]
	ldr	r2, [fp, #20]
	ldr	r3, [r1, #24]
	str	r3, [r2]
	ldr	r3, [r1, #28]
	str	r3, [r8]
	ldr	r3, [r1, #32]
	str	r3, [r9]
	ldr	r3, [fp, #-48]
	ldr	ip, [r3]
	cmp	r7, r4
	cmpge	lr, ip
	strgt	r8, [fp, #24]
	strgt	r9, [fp, #28]
	bgt	.L155
	b	.L156
.L154:
	strd	r0, [r6]
	cmp	r7, r4
	cmpge	lr, ip
	ldrd	r0, [r2, #48]
	ldr	r3, [fp, #8]
	strd	r0, [r3]
	ldrd	r0, [r2, #64]
	ldr	r3, [fp, #12]
	strd	r0, [r10]
	ldrd	r0, [r2, #56]
	strd	r0, [r3]
	ldr	r1, [fp, #16]
	ldr	r3, [r2, #20]
	str	r3, [r1]
	ldr	r1, [fp, #20]
	ldr	r3, [r2, #24]
	str	r3, [r1]
	ldr	r1, [fp, #24]
	ldr	r3, [r2, #28]
	str	r3, [r1]
	ldr	r1, [fp, #28]
	ldr	r3, [r2, #32]
	str	r3, [r1]
	ble	.L163
.L155:
	add	ip, ip, #1
	mvn	r9, #0
	mvn	r8, #0
	mov	r3, ip, asr #31
	mov	r2, r3, lsr #22
	add	r3, ip, r2
	ubfx	r3, r3, #0, #10
	rsb	r3, r2, r3
	mov	r1, r3, asl #5
	mov	r3, r3, asl #7
	rsb	r2, r1, r3
	add	r2, r5, r2
	ldrd	r0, [r2, #64]
	ldr	r3, [r2, #8]
	cmp	r1, r9
	cmpeq	r0, r8
	add	r4, r4, r3
	ldreqd	r0, [r6]
	b	.L154
.L163:
	ldr	r3, [fp, #-48]
	ldr	r1, [r3]
	cmp	r1, ip
	beq	.L156
	ldr	r3, [r2, #8]
	mov	r0, #0
	ldr	r2, [fp, #-52]
	rsb	ip, r1, ip
	rsb	r4, r3, r4
	ldr	r3, [fp, #-56]
	rsb	r7, r4, r7
	str	ip, [r2]
	str	r7, [r3]
.L162:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L156:
	ldr	r3, [fp, #-52]
	mov	r0, #0
	str	r0, [r3]
	ldr	r3, [fp, #-56]
	str	r7, [r3]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L151:
	movw	r3, #809
	ldr	r1, .L164
	ldr	r2, .L164+4
	mov	r0, #22
	str	ip, [fp, #-60]
	bl	dprint_vfmw
	ldr	r3, [fp, #-48]
	ldr	ip, [fp, #-60]
	ldr	lr, [r3]
	mov	r1, lr, asl #5
	mov	r3, lr, asl #7
	b	.L157
.L159:
	mvn	r0, #0
	b	.L162
.L165:
	.align	2
.L164:
	.word	.LC12
	.word	.LANCHOR3+36
	.fnend
	.size	GetRawNumOffsert, .-GetRawNumOffsert
	.align	2
	.global	DeleteRawLen
	.type	DeleteRawLen, %function
DeleteRawLen:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #88
	sub	sp, sp, #88
	push	{lr}
	bl	__gnu_mcount_nc
	clz	r3, r0
	mov	r5, r0
	mov	r3, r3, lsr #5
	orrs	ip, r3, r1, lsr #31
	bne	.L174
	cmp	r3, #0
	str	ip, [fp, #-92]
	str	ip, [fp, #-88]
	bne	.L174
	add	r4, r0, #98304
	ldr	r3, [r4, #20]
	ldr	ip, [r4, #12]
	rsb	r3, ip, r3
	movs	r6, r3, asr #31
	bne	.L176
	cmp	r1, r3
	bgt	.L174
	sub	r3, fp, #44
	sub	r2, fp, #72
	str	r3, [sp, #28]
	sub	r3, fp, #76
	str	r2, [sp, #24]
	sub	r2, fp, #80
	str	r3, [sp, #20]
	sub	r3, fp, #84
	str	r2, [sp, #16]
	sub	r2, fp, #52
	str	r3, [sp, #12]
	sub	r3, fp, #60
	str	r2, [sp, #8]
	sub	r2, fp, #68
	str	r3, [sp, #4]
	sub	r3, fp, #88
	str	r2, [sp]
	sub	r2, fp, #92
	bl	GetRawNumOffsert
	ldr	lr, [r4]
	ldr	r7, [fp, #-92]
	movw	r2, #925
	ldr	r8, [fp, #-88]
	mov	r0, #26
	add	lr, r7, lr
	ldr	r1, .L180
	mov	r3, r7
	mov	ip, lr, asr #31
	mov	ip, ip, lsr #22
	add	lr, lr, ip
	ubfx	lr, lr, #0, #10
	rsb	ip, ip, lr
	mov	r9, ip, asl #7
	sub	ip, r9, ip, asl #5
	add	r9, r5, ip
	ldrb	ip, [r9, #2]
	str	ip, [sp, #12]
	ldr	ip, [r9, #8]
	str	r7, [sp, #4]
	str	r8, [sp]
	str	ip, [sp, #8]
	bl	dprint_vfmw
	ldrb	r3, [r9, #2]
	cmp	r3, #0
	bne	.L170
	ldr	r1, [fp, #-92]
.L171:
	mov	r0, r5
	bl	DeleteRawPacket
	ldmia	r4, {r2, r3}
	ldr	r1, [fp, #-88]
	cmp	r2, r3
	beq	.L179
	mov	r3, r2, asl #7
	ldr	r0, [r4, #12]
	sub	r3, r3, r2, asl #5
	add	r5, r5, r3
	add	r1, r1, r0
	ldr	r3, [r5, #8]
	cmp	r1, r3
	strlt	r1, [r4, #12]
	bge	.L174
.L176:
	mov	r0, r6
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L174:
	mvn	r6, #0
	mov	r0, r6
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L170:
	ldr	r1, [r9, #8]
	movw	r2, #930
	ldr	ip, [fp, #-88]
	mov	r0, #26
	ldr	r3, [fp, #-92]
	str	r1, [sp, #4]
	str	ip, [sp]
	ldr	r1, .L180+4
	bl	dprint_vfmw
	ldr	r1, [fp, #-92]
	str	r6, [fp, #-88]
	add	r1, r1, #1
	str	r1, [fp, #-92]
	b	.L171
.L179:
	mvn	r6, #2
	mov	r0, r6
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L181:
	.align	2
.L180:
	.word	.LC13
	.word	.LC14
	.fnend
	.size	DeleteRawLen, .-DeleteRawLen
	.align	2
	.global	DeleteLastSendRaw
	.type	DeleteLastSendRaw, %function
DeleteLastSendRaw:
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
	cmp	r0, #15
	ldmhifd	sp, {r4, r5, fp, sp, pc}
	mov	r2, r0, asl #6
	ldr	r3, .L186
	sub	r0, r2, r0, asl #3
	add	r0, r3, r0
	ldr	r0, [r0, #56]
	cmp	r0, #0
	beq	.L185
	add	r4, r0, #188416
	ldr	r1, [r4, #2240]
	cmp	r1, #0
	ldmlefd	sp, {r4, r5, fp, sp, pc}
	add	r0, r0, #112
	bl	DeleteRawPacket
	mov	r3, #0
	str	r3, [r4, #2240]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L185:
	mov	r2, #968
	ldr	r1, .L186+4
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L187:
	.align	2
.L186:
	.word	.LANCHOR0
	.word	.LC15
	.fnend
	.size	DeleteLastSendRaw, .-DeleteLastSendRaw
	.align	2
	.global	GetRawStreamSize
	.type	GetRawStreamSize, %function
GetRawStreamSize:
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
	cmp	r0, #0
	addne	r0, r0, #98304
	ldrne	r3, [r0, #20]
	strne	r3, [r1]
	ldrne	r0, [r0, #12]
	rsbne	r0, r0, r3
	strne	r0, [r1]
	movne	r0, r0, asr #31
	mvneq	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	GetRawStreamSize, .-GetRawStreamSize
	.align	2
	.global	GetRawStreamNum
	.type	GetRawStreamNum, %function
GetRawStreamNum:
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
	cmp	r0, #0
	beq	.L194
	add	r0, r0, #98304
	ldmia	r0, {r2, r3}
	subs	r3, r3, r2
	strpl	r3, [r1]
	addmi	r3, r3, #1024
	strmi	r3, [r1]
	movpl	r0, #0
	movmi	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L194:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	GetRawStreamNum, .-GetRawStreamNum
	.align	2
	.global	GetRawStreamNumInBuffer
	.type	GetRawStreamNumInBuffer, %function
GetRawStreamNumInBuffer:
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
	cmp	r0, #0
	beq	.L198
	add	r0, r0, #98304
	ldr	r3, [r0, #4]
	ldr	r2, [r0, #8]
	subs	r3, r3, r2
	strpl	r3, [r1]
	addmi	r3, r3, #1024
	strmi	r3, [r1]
	movpl	r0, #0
	movmi	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L198:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	GetRawStreamNumInBuffer, .-GetRawStreamNumInBuffer
	.align	2
	.global	ConfigStreamSegArray
	.type	ConfigStreamSegArray, %function
ConfigStreamSegArray:
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
	cmp	r1, #0
	cmpne	r0, #0
	mov	r7, r2
	mov	r6, r3
	mov	r5, r1
	mov	r8, r0
	beq	.L202
	cmp	r3, #262144
	movcs	r4, #0
	movcc	r4, #1
	cmp	r2, #0
	orreq	r4, r4, #1
	cmp	r4, #0
	bne	.L202
	ldr	r3, .L203
	movw	r2, #26680
	movt	r2, 1
	mov	r1, r4
	ldr	r3, [r3, #48]
	blx	r3
	add	ip, r8, #90112
	mov	r0, r4
	str	r5, [ip, #2072]
	str	r7, [r8]
	str	r5, [ip, #2080]
	str	r5, [ip, #2084]
	str	r6, [ip, #2076]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L202:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L204:
	.align	2
.L203:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	ConfigStreamSegArray, .-ConfigStreamSegArray
	.align	2
	.global	ResetStreamSegArray
	.type	ResetStreamSegArray, %function
ResetStreamSegArray:
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
	ldr	r3, .L210
	mov	r2, #92160
	mov	r1, #0
	add	r0, r4, #8
	ldr	r3, [r3, #48]
	blx	r3
	add	r0, r4, #90112
	mov	r3, #0
	ldr	r2, [r0, #2072]
	str	r3, [r0, #2056]
	str	r3, [r0, #2060]
	str	r2, [r0, #2080]
	str	r2, [r0, #2084]
	str	r3, [r0, #2064]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L211:
	.align	2
.L210:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	ResetStreamSegArray, .-ResetStreamSegArray
	.align	2
	.global	GetSegBuf
	.type	GetSegBuf, %function
GetSegBuf:
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
	cmpne	r1, #0
	moveq	r3, #1
	movne	r3, #0
	cmp	r0, #0
	orreq	r3, r3, #1
	cmp	r3, #0
	addeq	r0, r0, #90112
	ldreq	r3, [r0, #2072]
	streq	r3, [r1]
	ldreq	r3, [r0, #2076]
	streq	r3, [r2]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	GetSegBuf, .-GetSegBuf
	.align	2
	.global	GetFreeSegBuf
	.type	GetFreeSegBuf, %function
GetFreeSegBuf:
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
	cmpne	r1, #0
	moveq	r3, #1
	movne	r3, #0
	cmp	r0, #0
	orreq	r3, r3, #1
	cmp	r3, #0
	ldmnefd	sp, {fp, sp, pc}
	add	r0, r0, #90112
	ldr	ip, [r0, #2084]
	str	ip, [r1]
	str	r3, [r2]
	ldr	r3, [r0, #2084]
	ldr	r1, [r0, #2080]
	cmp	r3, r1
	bhi	.L221
	ldrcs	r0, [r0, #2076]
	subcc	r1, r1, #1
	ldrcc	r0, [r0, #2076]
	rsbcc	r3, r3, r1
	subcs	r3, r0, #1
.L218:
	cmp	r3, r0
	strle	r3, [r2]
	ldmfd	sp, {fp, sp, pc}
.L221:
	ldr	r0, [r0, #2076]
	sub	r1, r1, #1
	add	r1, r1, r0
	rsb	r3, r3, r1
	b	.L218
	.fnend
	.size	GetFreeSegBuf, .-GetFreeSegBuf
	.align	2
	.global	CheckStream
	.type	CheckStream, %function
CheckStream:
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
	ldr	r3, .L267
	mov	r6, r1
	ldr	r5, [r3, r1, asl #2]
	ldr	r3, [r5, #592]
	sub	r1, r3, #3
	clz	r1, r1
	mov	r1, r1, lsr #5
	cmp	r3, #0
	movne	r3, r1
	orreq	r3, r1, #1
	cmp	r3, #0
	ldmeqfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	add	r4, r5, #237568
	ldr	r2, [r4, #352]
	cmp	r2, #199
	ldmgtfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	ldrb	ip, [r0]
	cmp	ip, #0
	bne	.L263
	ldrb	ip, [r0, #1]
	cmp	ip, #0
	bne	.L263
	ldrb	ip, [r0, #2]
	cmp	ip, #1
	beq	.L229
.L263:
	ldr	lr, [r4, #364]
	mov	ip, #0
	ldr	r7, [r4, #360]
	mov	r0, ip
	mov	r8, ip
	mov	r9, ip
	add	r2, r2, #1
	str	ip, [r4, #364]
	str	r2, [r4, #352]
	str	lr, [r4, #360]
	str	r7, [r4, #356]
.L230:
	cmp	r3, #0
	beq	.L264
.L231:
	ldr	r3, [r4, #348]
	add	r3, r3, #1
	str	r3, [r4, #348]
.L232:
	cmp	r0, #0
	beq	.L233
	rsb	r3, lr, r8
	cmp	r3, #1
	beq	.L265
.L234:
	cmp	lr, r8
	cmpeq	r7, lr
	bne	.L233
.L235:
	cmp	r8, #1
	cmpne	r8, #20
	beq	.L233
	ldr	r3, [r4, #344]
	cmp	r3, #0
	subgt	r3, r3, #1
	strgt	r3, [r4, #344]
	ldr	r3, [r4, #348]
	add	r3, r3, #1
	str	r3, [r4, #348]
.L233:
	cmp	r2, #199
	ldmlefd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	ldr	r0, [r4, #344]
	ldr	r3, [r4, #348]
	rsb	r2, r3, r0
	cmp	r2, #49
	movle	r1, #0
	andgt	r1, r1, #1
	cmp	r1, #0
	bne	.L266
.L237:
	rsb	r3, r0, r3
	cmp	r3, #49
	ldmlefd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	ldr	r3, [r5, #592]
	cmp	r3, #0
	ldmnefd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	ldr	r2, .L267+4
	ldr	ip, [r2]
	cmp	ip, #0
	ldmeqfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	mov	r0, r6
	mov	r2, r3
	mov	r1, #125
	blx	ip
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L264:
	add	r9, r9, #73
	uxtb	r9, r9
	cmp	r9, #3
	bhi	.L232
	b	.L231
.L266:
	ldr	r2, .L267+4
	ldr	ip, [r2]
	cmp	ip, #0
	beq	.L237
	mov	r3, #0
	mov	r1, #125
	mov	r2, r3
	mov	r0, r6
	blx	ip
	ldr	r3, [r4, #348]
	ldr	r0, [r4, #344]
	b	.L237
.L265:
	rsb	r3, r7, lr
	cmp	r3, #1
	bne	.L234
	b	.L235
.L229:
	ldrb	r9, [r0, #3]
	add	r2, r2, #1
	ldr	lr, [r4, #364]
	and	r8, r9, #31
	sub	r0, r9, #1
	sub	ip, r8, #30
	add	r7, r9, #79
	cmp	r8, #19
	cmpne	ip, #1
	uxtb	r3, r0
	sub	r10, r8, #1
	str	r2, [r4, #352]
	movls	ip, #1
	movhi	ip, #0
	cmp	r10, #12
	orrls	ip, ip, #1
	cmp	r3, #183
	uxtb	r3, r7
	ldr	r7, [r4, #360]
	movls	r0, #0
	movhi	r0, #1
	cmp	r3, #4
	movhi	r3, r0
	orrls	r3, r0, #1
	cmp	r8, #0
	cmpne	r2, #2
	str	r8, [r4, #364]
	movgt	r0, #1
	movle	r0, #0
	cmp	ip, #0
	str	lr, [r4, #360]
	str	r7, [r4, #356]
	ldrne	ip, [r4, #344]
	addne	ip, ip, #1
	strne	ip, [r4, #344]
	b	.L230
.L268:
	.align	2
.L267:
	.word	s_pstVfmwChan
	.word	g_event_report
	.fnend
	.size	CheckStream, .-CheckStream
	.align	2
	.global	InsertStreamSeg
	.type	InsertStreamSeg, %function
InsertStreamSeg:
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
	cmp	r1, #0
	cmpne	r0, #0
	mov	r5, r0
	mov	r7, r1
	moveq	r10, #1
	movne	r10, #0
	beq	.L271
	add	r4, r0, #90112
	movw	r6, #36409
	movt	r6, 14563
	ldr	r3, [r4, #2060]
	ldr	r1, [r4, #2056]
	add	r3, r3, #1
	smull	r8, r9, r3, r6
	mov	r0, r3, asr #31
	rsb	r0, r0, r9, asr #8
	mov	ip, r0, asl #10
	add	r0, ip, r0, lsl #7
	rsb	r3, r0, r3
	cmp	r3, r1
	beq	.L272
	mov	r1, r2
	ldr	r0, [r7]
	bl	CheckStream
	ldr	r3, [r4, #2060]
	ldr	r0, .L273
	mov	r1, r7
	mov	r2, #80
	mov	r8, r3, asl #6
	add	r8, r8, r3, lsl #4
	ldr	r3, [r0, #52]
	add	r0, r8, #8
	add	r0, r5, r0
	blx	r3
	ldr	ip, [r4, #2060]
	mov	lr, #1
	add	r3, r5, r8
	add	r2, ip, lr
	mov	r0, r10
	mov	r10, ip, asl #6
	smull	r8, r9, r2, r6
	mov	r1, r2, asr #31
	add	r6, r10, ip, lsl #4
	add	r5, r5, r6
	strb	lr, [r5, #12]
	rsb	r1, r1, r9, asr #8
	str	ip, [r3, #24]
	ldr	lr, [r4, #2088]
	mov	ip, r1, asl #10
	ldr	r3, [r4, #2092]
	add	r1, ip, r1, lsl #7
	ldr	ip, [r4, #2096]
	rsb	r2, r1, r2
	str	r2, [r4, #2060]
	add	r2, ip, #1
	ldr	r1, [r7, #12]
	ldr	ip, [r7, #8]
	add	r1, r1, ip
	str	r1, [r4, #2084]
	ldr	r1, [r7, #12]
	add	r1, lr, r1
	str	r1, [r4, #2088]
	ldr	r1, [r7, #12]
	str	r2, [r4, #2096]
	add	r3, r3, r1
	str	r3, [r4, #2092]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L272:
	mvn	r0, #3
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L271:
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L274:
	.align	2
.L273:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	InsertStreamSeg, .-InsertStreamSeg
	.align	2
	.global	GetStreamSeg
	.type	GetStreamSeg, %function
GetStreamSeg:
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
	cmp	r1, #0
	cmpne	r0, #0
	mov	r4, r0
	mov	r0, r1
	beq	.L282
	add	r5, r4, #90112
	ldr	r3, [r5, #2056]
	ldr	lr, [r5, #2060]
	cmp	lr, r3
	beq	.L284
	mov	ip, r3, asl #4
	mov	r6, r3, asl #6
	add	r2, ip, r6
	add	r2, r4, r2
	ldrsb	r2, [r2, #12]
	cmp	r2, #1
	movwne	r1, #36409
	movtne	r1, 14563
	bne	.L279
	b	.L277
.L290:
	add	r2, r4, r2
	ldrsb	r2, [r2, #12]
	cmp	r2, #1
	beq	.L277
.L279:
	add	ip, r3, #1
	smull	r2, r3, ip, r1
	mov	r2, ip, asr #31
	rsb	r3, r2, r3, asr #8
	mov	r2, r3, asl #10
	add	r3, r2, r3, lsl #7
	rsb	r3, r3, ip
	cmp	lr, r3
	mov	ip, r3, asl #4
	mov	r6, r3, asl #6
	add	r2, ip, r6
	bne	.L290
.L284:
	mvn	r0, #2
.L276:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L277:
	add	r6, ip, r6
	add	r1, r6, #8
	adds	r1, r4, r1
	beq	.L284
	ldr	r3, .L291
	add	r4, r4, r6
	mov	r2, #80
	ldr	r3, [r3, #52]
	blx	r3
	mov	r3, #2
	strb	r3, [r4, #12]
	mov	r0, #26
	ldr	r3, [r4, #20]
	ldr	ip, [r5, #2092]
	ldr	r2, [r5, #2096]
	rsb	ip, r3, ip
	ldr	r1, .L291+4
	sub	r2, r2, #1
	bic	ip, ip, ip, asr #31
	str	ip, [r5, #2092]
	bic	r2, r2, r2, asr #31
	str	r2, [r5, #2096]
	ldrb	ip, [r4, #13]
	ldr	r2, [r4, #16]
	str	ip, [sp]
	bl	dprint_vfmw
	mov	r0, #0
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L282:
	mvn	r0, #0
	b	.L276
.L292:
	.align	2
.L291:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC16
	.fnend
	.size	GetStreamSeg, .-GetStreamSeg
	.align	2
	.global	ReleaseStreamSeg
	.type	ReleaseStreamSeg, %function
ReleaseStreamSeg:
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
	beq	.L313
	movw	r3, #64382
	sub	r2, r1, #1152
	movt	r3, 65535
	cmp	r2, r3
	bls	.L313
	cmn	r1, #1
	add	r6, r5, #90112
	beq	.L327
	ldr	r3, [r6, #2056]
	ldr	ip, [r6, #2060]
	cmp	r3, ip
	beq	.L301
	cmp	r1, r3
	movwne	lr, #36409
	movtne	lr, 14563
	bne	.L304
	b	.L302
.L325:
	cmp	r4, r3
	beq	.L302
.L304:
	add	r2, r3, #1
	umull	r0, r1, r2, lr
	mov	r3, r1, lsr #8
	mov	r1, r3, asl #10
	add	r3, r1, r3, lsl #7
	rsb	r3, r3, r2
	cmp	r3, ip
	bne	.L325
.L301:
	mvn	r0, #2
.L323:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L302:
	mov	r2, r3, asl #6
	add	r3, r2, r3, lsl #4
	add	r2, r5, r3
	ldrsb	r2, [r2, #12]
	cmp	r2, #2
	addeq	r3, r3, #8
	addeq	r7, r5, r3
	bne	.L301
.L298:
	cmp	r7, #0
	beq	.L301
	ldr	r3, [r7, #12]
	mov	r2, #0
	strb	r2, [r7, #4]
	mov	r0, #26
	ldr	r2, [r7, #8]
	str	r4, [sp, #4]
	ldrb	ip, [r7, #5]
	ldr	r1, .L330
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [r6, #2056]
	cmp	r3, r4
	beq	.L328
.L306:
	ldr	r2, [r7, #12]
	mov	r0, #0
	ldr	r3, [r6, #2088]
	rsb	r3, r2, r3
	bic	r3, r3, r3, asr #31
	str	r3, [r6, #2088]
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L327:
	ldr	r9, [r6, #2056]
	ldr	r3, [r6, #2060]
	cmp	r9, r3
	beq	.L301
	mov	r3, r9, asl #6
	mov	r4, r9
	add	r9, r3, r9, lsl #4
	mov	r2, r4
	add	r7, r9, #8
	add	r9, r5, r9
	ldr	r1, .L330+4
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r3, [r9, #20]
	add	r7, r5, r7
	cmp	r3, #0
	movne	r8, #0
	beq	.L300
.L299:
	ldr	r3, [r9, #8]
	mov	r0, #0
	ldr	r1, .L330+8
	ldrb	r2, [r3, r8]
	add	r8, r8, #1
	bl	dprint_vfmw
	ldr	r3, [r9, #20]
	cmp	r3, r8
	movhi	r3, #1
	movls	r3, #0
	cmp	r8, #15
	movhi	r3, #0
	cmp	r3, #0
	bne	.L299
.L300:
	ldr	r1, .L330+12
	mov	r0, #0
	bl	dprint_vfmw
	b	.L298
.L328:
	movw	r8, #36409
	movt	r8, 14563
	b	.L309
.L307:
	ldr	r2, [r6, #2060]
	cmp	r2, r4
	beq	.L310
	ldrsb	r2, [r3, #12]
	cmp	r2, #0
	bne	.L329
.L314:
	add	r2, r4, #1
	umull	r0, r1, r2, r8
	mov	r4, r1, lsr #8
	mov	r3, r4, asl #10
	add	r4, r3, r4, lsl #7
	rsb	r4, r4, r2
.L309:
	mov	r3, r4, asl #6
	cmp	r4, #1152
	add	r3, r3, r4, lsl #4
	add	r3, r5, r3
	bcc	.L307
	ldr	r2, .L330+16
	mov	r0, #1
	ldr	r1, .L330+20
	bl	dprint_vfmw
	ldr	r2, [r6, #2060]
	cmp	r2, r4
	bne	.L314
.L310:
	ldr	r3, [r6, #2084]
	str	r2, [r6, #2056]
	str	r3, [r6, #2080]
	b	.L306
.L329:
	str	r4, [r6, #2056]
	ldr	r3, [r3, #16]
	str	r3, [r6, #2080]
	b	.L306
.L313:
	mvn	r0, #0
	b	.L323
.L331:
	.align	2
.L330:
	.word	.LC20
	.word	.LC17
	.word	.LC19
	.word	.LC18
	.word	.LANCHOR3+56
	.word	.LC21
	.fnend
	.size	ReleaseStreamSeg, .-ReleaseStreamSeg
	.align	2
	.global	GetSegStreamSize
	.type	GetSegStreamSize, %function
GetSegStreamSize:
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
	cmp	r0, #0
	addne	r3, r0, #90112
	movne	r0, #0
	mvneq	r0, #0
	ldrne	r3, [r3, #2088]
	strne	r3, [r1]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	GetSegStreamSize, .-GetSegStreamSize
	.align	2
	.global	GetSegStreamNum
	.type	GetSegStreamNum, %function
GetSegStreamNum:
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
	cmp	r0, #0
	beq	.L338
	add	r0, r0, #90112
	ldr	r3, [r0, #2060]
	ldr	r2, [r0, #2056]
	subs	r3, r3, r2
	strpl	r3, [r1]
	addmi	r3, r3, #1152
	strmi	r3, [r1]
	movpl	r0, #0
	movmi	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L338:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	GetSegStreamNum, .-GetSegStreamNum
	.align	2
	.global	GetFreshSegStream
	.type	GetFreshSegStream, %function
GetFreshSegStream:
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
	cmp	r0, #0
	addne	r0, r0, #90112
	ldrne	r3, [r0, #2096]
	strne	r3, [r1]
	ldrne	r3, [r0, #2092]
	strne	r3, [r2]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	GetFreshSegStream, .-GetFreshSegStream
	.align	2
	.global	SCDDRV_PrepareSleep
	.type	SCDDRV_PrepareSleep, %function
SCDDRV_PrepareSleep:
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
	ldr	r3, .L348
	add	ip, r3, r0, lsl #2
	ldr	r2, [ip, #1000]
	cmp	r2, #0
	bne	.L347
	mov	r1, r0, asl #7
	sub	r0, r1, r0, asl #5
	add	r3, r3, r0
	ldr	r0, [r3, #988]
	cmp	r0, #0
	moveq	r3, #2
	movne	r3, #1
	movne	r0, r2
	str	r3, [ip, #1000]
	ldmfd	sp, {fp, sp, pc}
.L347:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L349:
	.align	2
.L348:
	.word	.LANCHOR0
	.fnend
	.size	SCDDRV_PrepareSleep, .-SCDDRV_PrepareSleep
	.align	2
	.global	SCDDRV_GetSleepStage
	.type	SCDDRV_GetSleepStage, %function
SCDDRV_GetSleepStage:
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
	ldr	r3, .L351
	add	r0, r3, r0, lsl #2
	ldr	r0, [r0, #1000]
	ldmfd	sp, {fp, sp, pc}
.L352:
	.align	2
.L351:
	.word	.LANCHOR0
	.fnend
	.size	SCDDRV_GetSleepStage, .-SCDDRV_GetSleepStage
	.align	2
	.global	SCDDRV_ForceSleep
	.type	SCDDRV_ForceSleep, %function
SCDDRV_ForceSleep:
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
	ldr	r3, .L358
	add	r0, r3, r0, lsl #2
	ldr	r3, [r0, #1000]
	cmp	r3, #2
	movne	r3, #2
	strne	r3, [r0, #1000]
	ldmfd	sp, {fp, sp, pc}
.L359:
	.align	2
.L358:
	.word	.LANCHOR0
	.fnend
	.size	SCDDRV_ForceSleep, .-SCDDRV_ForceSleep
	.align	2
	.global	SCDDRV_ExitSleep
	.type	SCDDRV_ExitSleep, %function
SCDDRV_ExitSleep:
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
	ldr	r3, .L361
	mov	r2, #0
	add	r0, r3, r0, lsl #2
	str	r2, [r0, #1000]
	ldmfd	sp, {fp, sp, pc}
.L362:
	.align	2
.L361:
	.word	.LANCHOR0
	.fnend
	.size	SCDDRV_ExitSleep, .-SCDDRV_ExitSleep
	.align	2
	.global	SM_ClearInst
	.type	SM_ClearInst, %function
SM_ClearInst:
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
	cmp	r0, #15
	bhi	.L365
	mov	r4, r0, asl #6
	ldr	r3, .L366
	ldr	ip, .L366+4
	sub	r0, r4, r0, asl #3
	add	r4, r3, r0
	movw	r2, #8200
	movt	r2, 3
	mov	r1, #0
	ldr	r3, [ip, #48]
	mvn	r5, #0
	ldr	r0, [r4, #56]
	blx	r3
	ldr	r3, [r4, #56]
	mov	r0, #0
	mvn	r4, #0
	add	r3, r3, #203776
	add	r3, r3, #848
	strd	r4, [r3]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L365:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L367:
	.align	2
.L366:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	SM_ClearInst, .-SM_ClearInst
	.align	2
	.global	SM_AllocDSPCtxMem
	.type	SM_AllocDSPCtxMem, %function
SM_AllocDSPCtxMem:
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
	ldr	r7, .L378
	mov	r1, #0
	mov	r5, r1
	mov	r2, #24
	mov	r4, r0
	sub	r0, fp, #60
	ldr	r3, [r7, #48]
	blx	r3
	sub	r3, fp, #60
	str	r5, [sp]
	mov	r1, r5
	movw	r2, #9248
	ldr	r0, .L378+4
	mov	ip, #3
	str	ip, [fp, #-40]
	bl	MEM_AllocMemBlock
	subs	r6, r0, #0
	bne	.L369
	ldr	r5, .L378+8
	ldr	r2, [fp, #-44]
	ldr	r1, [fp, #-56]
	ldr	r0, [fp, #-52]
	bl	MEM_AddMemRecord
	mov	r3, r4, asl #6
	sub	r3, r3, r4, asl #3
	add	r0, r5, #8
	sub	r1, fp, #60
	add	r0, r0, r3
	ldr	ip, [r7, #52]
	mov	r2, #24
	add	r4, r5, r3
	blx	ip
	ldr	r8, [fp, #-52]
	add	r2, r8, #3
	bic	r0, r2, #3
	str	r0, [r4, #36]
	rsb	r5, r8, r0
	bl	MEM_Phy2Vir
	cmp	r0, #0
	str	r0, [r4, #32]
	beq	.L376
	mov	r2, #1024
	ldr	r3, [r7, #48]
	str	r2, [r4, #40]
	mov	r1, r6
	add	r5, r5, #1024
	blx	r3
	add	r0, r5, r8
	str	r0, [r4, #48]
	bl	MEM_Phy2Vir
	add	r9, r4, #40
	add	r4, r4, #48
	cmp	r0, #0
	str	r0, [r9, #4]
	beq	.L377
	mov	r2, #8192
	ldr	r3, [r7, #48]
	str	r2, [r4, #4]
	mov	r1, r6
	blx	r3
.L372:
	mov	r0, r6
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L369:
	mov	r0, r5
	ldr	r2, .L378+12
	ldr	r1, .L378+16
	mvn	r6, #6
	bl	dprint_vfmw
	b	.L372
.L377:
	ldr	r2, .L378+12
	mvn	r6, #6
	ldr	r1, .L378+20
	bl	dprint_vfmw
	b	.L372
.L376:
	ldr	r2, .L378+12
	mvn	r6, #6
	ldr	r1, .L378+24
	bl	dprint_vfmw
	b	.L372
.L379:
	.align	2
.L378:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC22
	.word	.LANCHOR0
	.word	.LANCHOR3+76
	.word	.LC23
	.word	.LC25
	.word	.LC24
	.fnend
	.size	SM_AllocDSPCtxMem, .-SM_AllocDSPCtxMem
	.align	2
	.global	SM_DeletDSPCtxMem
	.type	SM_DeletDSPCtxMem, %function
SM_DeletDSPCtxMem:
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
	ldr	r0, [r0, #8]
	cmp	r0, #0
	bne	.L383
	ldr	r1, .L384
	bl	dprint_vfmw
.L382:
	ldr	r2, [r4, #16]
	ldr	r1, [r4, #4]
	ldr	r0, [r4, #8]
	bl	MEM_DelMemRecord
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L383:
	ldr	r1, [r4, #4]
	bl	MEM_ReleaseMemBlock
	b	.L382
.L385:
	.align	2
.L384:
	.word	.LC26
	.fnend
	.size	SM_DeletDSPCtxMem, .-SM_DeletDSPCtxMem
	.align	2
	.global	SM_InstInit
	.type	SM_InstInit, %function
SM_InstInit:
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
	ldr	r4, .L389
	ldr	r6, .L389+4
	add	r5, r4, #896
.L387:
	mov	r2, #56
	mov	r0, r4
	ldr	r3, [r6, #48]
	add	r4, r4, r2
	mov	r1, #0
	blx	r3
	cmp	r4, r5
	bne	.L387
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L390:
	.align	2
.L389:
	.word	.LANCHOR0+8
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	SM_InstInit, .-SM_InstInit
	.align	2
	.global	SM_OpenSCDDrv
	.type	SM_OpenSCDDrv, %function
SM_OpenSCDDrv:
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
	subs	r10, r2, #0
	mov	r5, r0
	mov	r7, r1
	beq	.L393
	cmp	r10, #1
	bne	.L410
	movw	r3, #1838
	ldr	r2, .L416
	ldr	r1, .L416+4
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #6
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L393:
	ldr	r4, .L416+8
	mov	r3, #49152
	movt	r3, 63683
	ldr	r2, [r4, #980]
	str	r3, [r4, #4]
	cmp	r2, #1
	beq	.L409
	ldr	r9, .L416+12
	add	r6, r4, #904
	mov	r2, #96
	mov	r1, r10
	mov	r0, r6
	ldr	r3, [r9, #48]
	blx	r3
	ldr	r3, .L416+16
	cmp	r6, #0
	str	r10, [r4, #1000]
	str	r10, [r3, #76]
	beq	.L411
	add	r0, r5, #15
	str	r5, [r4, #904]
	bic	r0, r0, #15
	str	r7, [r4, #908]
	rsb	r6, r5, r0
	str	r0, [r4, #916]
	bl	MEM_Phy2Vir
	add	r3, r5, #12288
	add	r3, r3, r6
	mov	r2, #12288
	str	r3, [r4, #928]
	add	r8, r6, #21504
	str	r2, [r4, #920]
	str	r0, [r4, #912]
	mov	r0, r3
	bl	MEM_Phy2Vir
	add	r3, r8, r5
	mov	r2, #9216
	str	r3, [r4, #940]
	str	r2, [r4, #932]
	str	r0, [r4, #924]
	mov	r0, r3
	bl	MEM_Phy2Vir
	cmp	r0, #0
	str	r0, [r4, #936]
	beq	.L412
	ldr	r3, [r9, #48]
	mov	r2, #512
	mov	r1, r10
	blx	r3
	add	r0, r6, #22016
	add	r0, r0, r5
	mov	r3, #512
	str	r0, [r4, #952]
	str	r3, [r4, #944]
	bl	MEM_Phy2Vir
	cmp	r0, #0
	str	r0, [r4, #948]
	beq	.L413
	mov	r6, #278528
	ldr	r3, [r9, #48]
	mov	r2, r6
	mov	r1, r10
	str	r6, [r4, #956]
	blx	r3
	add	r0, r8, r6
	add	r0, r0, #512
	add	r0, r0, r5
	str	r0, [r4, #964]
	bl	MEM_Phy2Vir
	cmp	r0, #0
	str	r0, [r4, #960]
	beq	.L414
	ldr	r3, [r9, #48]
	mov	r1, r10
	mov	r2, r6
	add	r8, r8, #557056
	blx	r3
	ldr	r0, [r4, #964]
	str	r6, [r4, #968]
	bl	WriteCabacTabDsp
	add	r0, r5, r8
	add	r0, r0, #636
	add	r0, r0, #3
	bic	r0, r0, #127
	str	r0, [r4]
	bl	MEM_Phy2Vir
	cmp	r0, #0
	str	r0, [r4, #1004]
	beq	.L415
	add	r8, r8, #18432
	ldr	r2, [r4, #4]
	ldr	r3, [r4, #1012]
	cmp	r7, r8
	mov	r1, #17920
	str	r1, [r4, #1008]
	str	r2, [r4, #972]
	str	r3, [r4, #976]
	blt	.L409
	ldr	r3, [r4, #912]
	cmp	r3, #0
	beq	.L409
	ldr	r3, [r4, #924]
	cmp	r3, #0
	beq	.L409
	mov	r3, #1
	mov	r0, #0
	str	r3, [r4, #980]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L410:
	ldr	r2, .L416
	mov	r0, #0
	ldr	r1, .L416+20
	bl	dprint_vfmw
	mvn	r0, #6
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L411:
	mov	r0, r6
	movw	r3, #1861
	ldr	r2, .L416
	ldr	r1, .L416+24
	bl	dprint_vfmw
.L409:
	mvn	r0, #6
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L412:
	ldr	r2, .L416
	ldr	r1, .L416+28
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L414:
	ldr	r2, .L416
	ldr	r1, .L416+32
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L413:
	ldr	r2, .L416
	ldr	r1, .L416+36
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L415:
	ldr	r2, .L416
	ldr	r1, .L416+40
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L417:
	.align	2
.L416:
	.word	.LANCHOR3+96
	.word	.LC28
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_VfmwGlobalStat
	.word	.LC27
	.word	.LC29
	.word	.LC30
	.word	.LC32
	.word	.LC31
	.word	.LC33
	.fnend
	.size	SM_OpenSCDDrv, .-SM_OpenSCDDrv
	.align	2
	.global	SM_CloseSCDDrv
	.type	SM_CloseSCDDrv, %function
SM_CloseSCDDrv:
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
	ldr	r3, .L428
	mov	lr, r0
	mov	r4, #0
	add	r0, r3, #896
	mov	ip, r0
.L420:
	ldr	r2, [r3, #48]
	add	r3, r3, #56
	cmp	r2, #0
	add	r1, r2, #188416
	beq	.L419
	ldr	r2, [r1, #2368]
	cmp	r2, #0
	beq	.L419
	ldr	r2, [r1, #2356]
	cmp	r2, #0
	strle	r4, [r1, #2368]
.L419:
	cmp	r3, ip
	bne	.L420
	ldr	r1, .L428+4
	mov	ip, #84
	mov	r3, lr, asl #7
	ldr	r2, .L428+8
	sub	r3, r3, lr, asl #5
	mov	r4, #0
	mla	lr, ip, lr, r1
	add	r0, r0, r3
	mov	r1, r4
	ldr	r3, [r2, #48]
	mov	r2, #96
	str	r4, [lr, #76]
	blx	r3
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L429:
	.align	2
.L428:
	.word	.LANCHOR0+8
	.word	g_VfmwGlobalStat
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	SM_CloseSCDDrv, .-SM_CloseSCDDrv
	.align	2
	.global	SM_CfgBuf
	.type	SM_CfgBuf, %function
SM_CfgBuf:
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
	bhi	.L438
	cmp	r1, #0
	bne	.L439
	mov	r1, r0, asl #6
	ldr	r2, .L440
	sub	r0, r1, r0, asl #3
	add	r0, r2, r0
	ldr	r3, [r0, #56]
	cmn	r2, #904
	cmpne	r3, #0
	moveq	r1, #1
	movne	r1, #0
	beq	.L434
	add	r3, r3, #188416
	ldr	r0, [r3, #2356]
	cmp	r0, #0
	ldmeqfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	ldr	r10, [r2, #916]
	mov	r0, r1
	ldr	r9, [r2, #912]
	ldr	r8, [r2, #920]
	ldr	ip, [r2, #944]
	ldr	r7, [r2, #928]
	ldr	r6, [r2, #924]
	ldr	r5, [r2, #932]
	ldr	r4, [r2, #940]
	ldr	lr, [r2, #936]
	str	ip, [r3, #2316]
	str	r1, [r3, #2356]
	ldr	ip, [r2, #952]
	ldr	r1, [r2, #948]
	str	r10, [r3, #2264]
	str	r9, [r3, #2256]
	ldr	r10, [r2, #956]
	ldr	r9, [r2, #964]
	str	r8, [r3, #2260]
	ldr	r8, [r2, #960]
	ldr	r2, [r2, #968]
	str	ip, [r3, #2320]
	str	r7, [r3, #2272]
	str	r2, [r3, #2340]
	mov	r2, #1152
	str	r6, [r3, #2268]
	str	r5, [r3, #2276]
	str	r4, [r3, #2308]
	str	lr, [r3, #2312]
	str	r1, [r3, #2324]
	str	r10, [r3, #2328]
	str	r9, [r3, #2332]
	str	r8, [r3, #2336]
	str	r2, [r3, #2280]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L434:
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L438:
	mov	r3, r0
	movw	r2, #2133
	ldr	r1, .L440+4
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L439:
	mov	r3, r1
	movw	r2, #2139
	ldr	r1, .L440+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L441:
	.align	2
.L440:
	.word	.LANCHOR0
	.word	.LC34
	.word	.LC35
	.fnend
	.size	SM_CfgBuf, .-SM_CfgBuf
	.align	2
	.global	SM_Start
	.type	SM_Start, %function
SM_Start:
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
	ldr	r3, .L447
	mov	r2, r0, asl #6
	sub	r0, r2, r0, asl #3
	add	r0, r3, r0
	ldr	r3, [r0, #56]
	cmp	r3, #0
	beq	.L446
	ldr	r2, [r3, #64]
	cmp	r2, #0
	beq	.L446
	add	r3, r3, #188416
	ldr	r0, [r3, #2368]
	cmp	r0, #0
	bne	.L446
	mov	r2, #1
	str	r2, [r3, #2368]
	ldmfd	sp, {fp, sp, pc}
.L446:
	mvn	r0, #6
	ldmfd	sp, {fp, sp, pc}
.L448:
	.align	2
.L447:
	.word	.LANCHOR0
	.fnend
	.size	SM_Start, .-SM_Start
	.align	2
	.global	SM_Stop
	.type	SM_Stop, %function
SM_Stop:
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
	ldr	r3, .L456
	mov	r2, r0, asl #6
	sub	r0, r2, r0, asl #3
	add	r0, r3, r0
	ldr	r0, [r0, #56]
	cmp	r0, #0
	ldmeqfd	sp, {fp, sp, pc}
	add	r3, r0, #188416
	ldr	r0, [r3, #2368]
	cmp	r0, #0
	ldmeqfd	sp, {fp, sp, pc}
	ldr	r2, [r3, #2356]
	cmp	r2, #0
	movle	r0, #0
	strle	r0, [r3, #2368]
	mvngt	r0, #6
	ldmfd	sp, {fp, sp, pc}
.L457:
	.align	2
.L456:
	.word	.LANCHOR0
	.fnend
	.size	SM_Stop, .-SM_Stop
	.align	2
	.global	SM_GetInfo
	.type	SM_GetInfo, %function
SM_GetInfo:
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
	bhi	.L467
	mov	r2, r0, asl #6
	ldr	r3, .L476
	sub	r0, r2, r0, asl #3
	add	r0, r3, r0
	ldr	r0, [r0, #56]
	cmp	r0, #0
	beq	.L475
	add	r2, r0, #188416
	add	r3, r0, #200704
	cmn	r0, #112
	add	r0, r0, #98304
	ldr	ip, [r2, #2368]
	strb	ip, [r1]
	ldr	r3, [r3, #3948]
	str	r3, [r1, #20]
	beq	.L461
	ldr	r3, [r0, #116]
	ldr	ip, [r0, #112]
	subs	r3, r3, ip
	addmi	r3, r3, #1024
	strmi	r3, [r1, #4]
	strpl	r3, [r1, #4]
.L463:
	ldr	r3, [r0, #132]
	str	r3, [r1, #12]
	ldr	ip, [r0, #124]
	rsb	r3, ip, r3
	str	r3, [r1, #12]
.L461:
	adds	r0, r0, #136
	ldmeqfd	sp, {fp, sp, pc}
	ldr	r3, [r2, #2196]
	ldr	r0, [r2, #2192]
	subs	r3, r3, r0
	addmi	r3, r3, #1152
	strmi	r3, [r1, #8]
	strpl	r3, [r1, #8]
.L465:
	ldr	r3, [r2, #2224]
	mov	r0, #0
	str	r3, [r1, #16]
	ldmfd	sp, {fp, sp, pc}
.L475:
	cmp	r1, #0
	beq	.L467
	strb	r0, [r1]
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L467:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L477:
	.align	2
.L476:
	.word	.LANCHOR0
	.fnend
	.size	SM_GetInfo, .-SM_GetInfo
	.align	2
	.global	SM_PushRaw
	.type	SM_PushRaw, %function
SM_PushRaw:
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
	ldr	r3, .L482
	mov	r2, r0, asl #6
	ldr	lr, [r1, #4]
	sub	r0, r2, r0, asl #3
	add	r0, r3, r0
	cmp	lr, #0
	ldr	r0, [r0, #56]
	beq	.L481
	ldr	r3, [r1, #44]
	ldr	r2, [r1, #40]
	orrs	r3, r2, r3
	moveq	r3, #1
	movne	r3, #0
	cmp	r0, #0
	orreq	r3, r3, #1
	cmp	r3, #0
	bne	.L481
	add	r0, r0, #112
	bl	InsertRawPacket
	ldmfd	sp, {fp, sp, pc}
.L481:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L483:
	.align	2
.L482:
	.word	.LANCHOR0
	.fnend
	.size	SM_PushRaw, .-SM_PushRaw
	.align	2
	.global	SM_CopyRawToSeg
	.type	SM_CopyRawToSeg, %function
SM_CopyRawToSeg:
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
	ldr	r3, .L515
	mov	r2, r0, asl #6
	sub	r2, r2, r0, asl #3
	str	r0, [fp, #-72]
	add	r3, r3, r2
	mov	r7, r1
	ldr	r5, [r3, #56]
	cmp	r5, #0
	beq	.L502
	cmn	r5, #112
	add	r8, r5, #98304
	add	r2, r8, #136
	str	r2, [fp, #-68]
	movne	r3, #0
	moveq	r3, #1
	cmn	r8, #136
	add	r2, r5, #112
	str	r2, [fp, #-64]
	movne	r10, #0
	moveq	r10, #1
	orr	r3, r10, r3
	cmp	r7, #0
	orreq	r3, r3, #1
	cmp	r3, #0
	bne	.L502
	ldr	lr, [r8, #116]
	ldr	r3, [r8, #112]
	cmp	lr, r3
	beq	.L488
	mov	r2, r3, asl #5
	mov	r9, r3, asl #7
	rsb	r1, r2, r9
	str	r2, [fp, #-48]
	add	r1, r5, r1
	mov	ip, r2
	mov	r4, #1
	mov	r2, r9
	ldr	r6, [r1, #120]
	b	.L487
.L489:
	add	r4, r4, #1
	ldr	r0, [r0, #120]
	cmp	r4, #1024
	add	r6, r6, r0
	movls	r1, #0
	movhi	r1, #1
	cmp	r3, lr
	orreq	r1, r1, #1
	cmp	r1, #0
	bne	.L488
.L487:
	rsb	r1, ip, r2
	add	r3, r3, #1
	add	r1, r5, r1
	ubfx	r3, r3, #0, #10
	ldrb	r1, [r1, #112]
	mov	ip, r3, asl #5
	mov	r2, r3, asl #7
	cmp	r1, #0
	rsb	r0, ip, r2
	add	r0, r5, r0
	bne	.L489
	cmp	r10, #0
	addne	r3, r5, #188416
	bne	.L490
	ldr	r3, .L515+4
	mov	r2, #92160
	mov	r1, r10
	add	r0, r8, #144
	ldr	r3, [r3, #48]
	blx	r3
	add	r3, r5, #188416
	ldr	r2, [r3, #2208]
	str	r10, [r3, #2192]
	str	r10, [r3, #2196]
	str	r10, [r3, #2200]
	str	r2, [r3, #2216]
	str	r2, [r3, #2220]
.L490:
	ldr	r2, [r3, #2212]
	sub	r2, r2, #262144
	cmp	r2, r6
	blt	.L512
	ldr	r2, [r5, #56]
	ldr	r0, [r3, #2208]
	sub	r3, r2, #10
	ldr	r10, [r8, #136]
	bics	r3, r3, #2
	bne	.L492
	ldr	r3, .L515+8
	ldr	r3, [r3]
	ands	r3, r3, #1
	streqb	r3, [r10]
	addeq	r10, r10, #1
	ldreq	r2, [r5, #56]
.L492:
	ldr	r3, [fp, #-48]
	cmp	r2, #12
	ldr	ip, [r8, #112]
	rsb	r3, r3, r9
	add	r3, r5, r3
	ldr	r1, [r3, #152]
	ldr	r3, [r3, #120]
	str	r3, [fp, #-52]
	beq	.L513
.L493:
	str	r0, [r7, #8]
	str	ip, [fp, #-60]
	str	r1, [fp, #-56]
	bl	MEM_Phy2Vir
	ldr	r3, [fp, #-48]
	cmp	r4, #0
	ldr	ip, [fp, #-60]
	rsb	r9, r3, r9
	mov	r3, #1
	add	r9, r5, r9
	str	r0, [r7]
	rsb	r0, r0, r10
	str	r0, [r7, #12]
	ldrd	r0, [r9, #176]
	strd	r0, [r7, #24]
	ldrd	r0, [r9, #176]
	strd	r0, [r7, #32]
	ldrd	r0, [r9, #160]
	strb	r3, [r7, #5]
	strd	r0, [r7, #40]
	ldr	r1, [fp, #-56]
	beq	.L500
	cmp	r1, #0
	cmpne	r10, #0
	beq	.L488
	ldr	r3, .L515+4
	mov	r2, #0
	mov	r8, ip, asl #7
	str	r6, [fp, #-76]
	str	r4, [fp, #-60]
	mov	r6, ip
	str	r3, [fp, #-56]
	mov	r3, ip, asl #5
	mov	lr, r1
	mov	ip, r2
	mov	r4, r3
	mov	r3, r5
	ldr	r5, [fp, #-52]
	b	.L498
.L499:
	cmp	r10, #0
	cmpne	lr, #0
	beq	.L488
.L498:
	str	r3, [fp, #-48]
	mov	r1, lr
	ldr	r3, [fp, #-56]
	mov	r2, r5
	mov	r0, r10
	str	ip, [fp, #-52]
	rsb	r4, r4, r8
	add	r6, r6, #1
	ldr	r3, [r3, #52]
	ubfx	r6, r6, #0, #10
	blx	r3
	ldr	r3, [fp, #-48]
	ldr	r1, [r7, #12]
	add	r10, r10, r5
	add	r4, r3, r4
	ldr	ip, [fp, #-52]
	add	r5, r1, r5
	ldr	r1, [fp, #-60]
	ldrb	r0, [r4, #113]
	mov	r8, r6, asl #7
	mov	r4, r6, asl #5
	add	ip, ip, #1
	str	r5, [r7, #12]
	rsb	r2, r4, r8
	strb	r0, [r7, #6]
	cmp	ip, r1
	ldrd	r0, [r9, #168]
	add	r2, r3, r2
	ldr	lr, [r2, #152]
	ldr	r5, [r2, #120]
	strd	r0, [r7, #48]
	ldr	r2, [r9, #132]
	str	r2, [r7, #56]
	ldr	r2, [r9, #136]
	str	r2, [r7, #60]
	ldr	r2, [r9, #140]
	str	r2, [r7, #64]
	ldr	r2, [r9, #144]
	str	r2, [r7, #68]
	bne	.L499
	ldr	r6, [fp, #-76]
.L500:
	ldr	r2, [fp, #-72]
	mov	r1, r7
	ldr	r0, [fp, #-68]
	bl	InsertStreamSeg
	mov	r1, r6
	ldr	r0, [fp, #-64]
	bl	DeleteRawLen
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L488:
	mvn	r0, #3
.L485:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L513:
	ldr	r3, .L515+8
	ldr	r2, [fp, #-52]
	ldr	r3, [r3]
	cmp	r2, #0
	moveq	r3, #0
	andne	r3, r3, #1
	cmp	r3, #0
	beq	.L493
	cmp	r2, #2
	bgt	.L514
	cmp	r4, #1
	add	r3, ip, #1
	ubfx	ip, r3, #0, #10
	bls	.L488
	mov	r8, ip, asl #7
	sub	r3, r8, ip, asl #5
	add	r3, r5, r3
	ldr	r2, [r3, #120]
	ldr	r1, [r3, #152]
	ldr	r3, [fp, #-52]
	add	r2, r3, r2
	cmp	r2, #2
	ble	.L495
	add	r3, ip, #1020
	sub	r2, r2, #3
	add	r3, r3, #3
	str	r2, [fp, #-52]
	ubfx	r3, r3, #0, #10
	sub	r4, r4, #1
	mov	r2, r3, asl #7
	sub	r3, r2, r3, asl #5
	add	r3, r5, r3
	ldr	lr, [r3, #120]
	rsb	lr, lr, #3
	add	r1, r1, lr
	b	.L493
.L512:
	mov	r2, r6
	ldr	r1, .L515+12
	mov	r0, #0
	bl	dprint_vfmw
	mov	r1, r6
	ldr	r0, [fp, #-64]
	bl	DeleteRawLen
	cmp	r0, #0
	beq	.L485
	movw	r2, #2404
	ldr	r1, .L515+16
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #0
	b	.L485
.L514:
	sub	r3, r2, #3
	add	r1, r1, #3
	str	r3, [fp, #-52]
	b	.L493
.L502:
	mvn	r0, #0
	b	.L485
.L495:
	cmp	r4, #2
	add	r3, ip, #1
	ubfx	ip, r3, #0, #10
	bls	.L488
	mov	r8, ip, asl #7
	sub	r1, r8, ip, asl #5
	add	r1, r5, r1
	ldr	r3, [r1, #120]
	ldr	lr, [r1, #152]
	add	r2, r2, r3
	cmp	r2, #2
	ble	.L488
	add	r3, ip, #1020
	sub	r2, r2, #3
	str	r2, [fp, #-52]
	sub	r4, r4, #2
	mov	r1, r3
	add	r3, r3, #3
	add	r1, r1, #2
	ubfx	r3, r3, #0, #10
	ubfx	r8, r1, #0, #10
	mov	r1, r3, asl #7
	sub	r3, r1, r3, asl #5
	mov	r2, r8, asl #7
	sub	r2, r2, r8, asl #5
	add	r3, r5, r3
	add	r2, r5, r2
	ldr	r3, [r3, #120]
	ldr	r2, [r2, #120]
	rsb	r1, r3, #3
	rsb	r1, r2, r1
	add	r1, lr, r1
	b	.L493
.L516:
	.align	2
.L515:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_VdmCharacter
	.word	.LC36
	.word	.LC37
	.fnend
	.size	SM_CopyRawToSeg, .-SM_CopyRawToSeg
	.align	2
	.global	SM_CopyYuvToDnr
	.type	SM_CopyYuvToDnr, %function
SM_CopyYuvToDnr:
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
	ldr	r3, .L535
	mov	r2, r0, asl #6
	sub	r0, r2, r0, asl #3
	add	r0, r3, r0
	ldr	r7, [r0, #56]
	cmp	r7, #0
	beq	.L527
	add	r0, r7, #98304
	add	r5, r7, #112
	cmn	r0, #136
	movne	r4, #0
	moveq	r4, #1
	cmn	r0, #136
	cmnne	r7, #112
	beq	.L527
	ldr	r6, [r0, #112]
	ldr	r3, [r0, #116]
	cmp	r3, r6
	beq	.L528
	cmp	r4, #0
	bne	.L519
	ldr	r3, .L535+4
	mov	r2, #92160
	add	r0, r0, #144
	mov	r1, r4
	ldr	r3, [r3, #48]
	blx	r3
	add	r2, r7, #188416
	ldr	r3, [r2, #2208]
	str	r4, [r2, #2192]
	str	r4, [r2, #2196]
	str	r4, [r2, #2200]
	str	r3, [r2, #2216]
	str	r3, [r2, #2220]
.L519:
	mov	r4, r6, asl #5
	mov	r6, r6, asl #7
	rsb	r2, r4, r6
	add	r2, r7, r2
	ldr	r0, [r2, #152]
	ldr	ip, [r0]
	ldr	r3, [r0, #4]
	sub	r1, ip, #32
	cmp	r1, #1888
	bhi	.L520
	sub	r1, r3, #32
	cmp	r1, #1056
	bls	.L533
.L520:
	rsb	r6, r4, r6
	ldr	r1, .L535+8
	add	r6, r7, r6
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, r5
	ldr	r1, [r6, #120]
	bl	DeleteRawLen
	cmp	r0, #0
	bne	.L534
.L532:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L533:
	ldr	r1, [r2, #120]
	mov	r2, #51712
	movt	r2, 47
	sub	lr, r1, #1552
	cmp	lr, r2
	bhi	.L520
	mul	r3, r3, ip
	add	r2, r7, #188416
	ldr	r2, [r2, #2212]
	sub	r2, r2, #262144
	add	r3, r3, r3, lsl #1
	add	r3, r3, r3, lsr #31
	mov	r3, r3, asr #1
	cmp	r3, r2
	bgt	.L520
	add	r3, r3, #16
	cmp	r1, r3
	blt	.L520
	ldr	r3, [r0, #8]
	movw	ip, #1916
	ldr	r2, [r0, #12]
	sub	r3, r3, #4
	cmp	r3, ip
	bhi	.L523
	sub	r2, r2, #4
	movw	r3, #1084
	cmp	r2, r3
	bls	.L524
.L523:
	ldr	r1, .L535+12
	mov	r0, #0
	rsb	r6, r4, r6
	bl	dprint_vfmw
	add	r3, r7, r6
	mov	r0, r5
	ldr	r1, [r3, #120]
	bl	DeleteRawLen
	cmp	r0, #0
	beq	.L532
	movw	r2, #2631
	ldr	r1, .L535+16
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L534:
	movw	r2, #2616
	ldr	r1, .L535+16
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L527:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L528:
	mvn	r0, #3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L524:
	mov	r0, r5
	bl	DeleteRawLen
	b	.L532
.L536:
	.align	2
.L535:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC38
	.word	.LC39
	.word	.LC37
	.fnend
	.size	SM_CopyYuvToDnr, .-SM_CopyYuvToDnr
	.align	2
	.global	SM_ReadStreamSeg
	.type	SM_ReadStreamSeg, %function
SM_ReadStreamSeg:
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
	ldr	r3, .L552
	mov	r2, r0, asl #6
	mov	r5, r0
	sub	r2, r2, r0, asl #3
	mov	r6, r1
	add	r3, r3, r2
	ldr	r4, [r3, #56]
	cmp	r4, #0
	cmpne	r1, #0
	beq	.L543
	ldr	r2, [r4, #56]
	sub	r3, r2, #8
	sub	r1, r2, #4
	cmp	r1, #1
	cmphi	r3, #6
	movls	r3, #1
	movhi	r3, #0
	cmp	r2, #17
	orreq	r3, r3, #1
	cmp	r3, #0
	bne	.L539
	cmp	r2, #1
	beq	.L551
.L540:
	add	r0, r4, #98304
	mov	r1, r6
	add	r0, r0, #136
	bl	GetStreamSeg
	subs	r7, r0, #0
	bne	.L541
	ldr	r9, .L552+4
	ldr	r3, [r9, r5, asl #2]
	cmp	r3, #0
	beq	.L542
	ldr	r8, .L552+8
	ldr	r3, [r8, #16]
	blx	r3
	ldr	r3, [r8, #44]
	ldr	r2, [r9, r5, asl #2]
	ldr	r1, [r6, #12]
	ldr	r0, [r6]
	blx	r3
	ldr	r3, [r8, #12]
	mov	r0, r7
	blx	r3
.L542:
	add	r4, r4, #200704
	mov	r3, #0
	mov	r0, r3
	str	r3, [r4, #3948]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L551:
	ldr	r3, [r4, #72]
	cmp	r3, #0
	bne	.L540
.L539:
	mov	r1, r6
	mov	r0, r5
	bl	SM_CopyRawToSeg
	cmp	r0, #0
	beq	.L540
	ldr	r1, .L552+12
	mov	r0, #26
	bl	dprint_vfmw
	mvn	r7, #6
.L541:
	add	r4, r4, #200704
	mov	r0, r7
	ldr	r3, [r4, #3948]
	add	r3, r3, #1
	str	r3, [r4, #3948]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L543:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L553:
	.align	2
.L552:
	.word	.LANCHOR0
	.word	vfmw_save_seg_file
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC40
	.fnend
	.size	SM_ReadStreamSeg, .-SM_ReadStreamSeg
	.align	2
	.global	SM_ReleaseStreamSeg
	.type	SM_ReleaseStreamSeg, %function
SM_ReleaseStreamSeg:
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
	ldr	r3, .L557
	mov	r2, r0, asl #6
	sub	r0, r2, r0, asl #3
	add	r0, r3, r0
	ldr	r0, [r0, #56]
	cmp	r0, #0
	beq	.L556
	add	r0, r0, #98304
	add	r0, r0, #136
	bl	ReleaseStreamSeg
	ldmfd	sp, {fp, sp, pc}
.L556:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L558:
	.align	2
.L557:
	.word	.LANCHOR0
	.fnend
	.size	SM_ReleaseStreamSeg, .-SM_ReleaseStreamSeg
	.align	2
	.global	SM_GiveThreadEvent
	.type	SM_GiveThreadEvent, %function
SM_GiveThreadEvent:
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
	ldr	r7, .L571
	mov	r6, r0
	ldr	r4, .L571+4
	ldr	r3, [r7]
	blx	r3
	mov	r3, r6, asl #6
	sub	r3, r3, r6, asl #3
	add	r3, r4, r3
	ldr	r3, [r3, #56]
	cmp	r3, #0
	mov	r5, r0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldrsb	r3, [r3, #3]
	cmp	r3, #1
	beq	.L562
.L564:
	mov	r0, #0
.L563:
	ldr	r3, [r4, #1016]
	ldr	r2, .L571+4
	cmp	r5, r3
	movls	r3, #1
	strls	r5, [r2, #1016]
	bls	.L566
	rsb	r3, r3, r5
	cmp	r3, #1
	movls	r3, #0
	movhi	r3, #1
.L566:
	tst	r3, r0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	r3, [r7, #124]
	mov	r0, #0
	blx	r3
	str	r5, [r4, #1016]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L562:
	mov	r0, r6
	bl	VCTRL_GetDecParam
	cmp	r0, #0
	bne	.L564
	mov	r0, r6
	bl	VCTRL_IsChanSegEnough
	clz	r0, r0
	mov	r0, r0, lsr #5
	b	.L563
.L572:
	.align	2
.L571:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.fnend
	.size	SM_GiveThreadEvent, .-SM_GiveThreadEvent
	.align	2
	.global	CalcInstBlockTime
	.type	CalcInstBlockTime, %function
CalcInstBlockTime:
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
	ldr	r3, .L579
	mov	r2, r0, asl #6
	mov	r5, r1
	sub	r2, r2, r0, asl #3
	add	r3, r3, r2
	ldr	r4, [r3, #56]
	cmp	r4, #0
	beq	.L578
	ldr	r3, .L579+4
	add	r4, r4, #200704
	ldr	r3, [r3]
	blx	r3
	cmp	r5, #0
	mov	r2, r0
	beq	.L575
	mov	r3, #0
	str	r2, [r4, #3912]
	mov	r0, r3
	str	r3, [r4, #3908]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L575:
	ldr	r3, [r4, #3912]
	cmp	r0, r3
	strls	r5, [r4, #3908]
	rsbhi	r0, r3, r0
	strls	r2, [r4, #3912]
	strhi	r0, [r4, #3908]
	movls	r0, r5
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L578:
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L580:
	.align	2
.L579:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	CalcInstBlockTime, .-CalcInstBlockTime
	.align	2
	.global	SetInstMode
	.type	SetInstMode, %function
SetInstMode:
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
	ldr	r2, .L584
	mov	r3, r0, asl #6
	sub	ip, r3, r0, asl #3
	sub	r0, r1, #1
	add	r2, r2, ip
	ldr	r2, [r2, #56]
	clz	r3, r2
	mov	r3, r3, lsr #5
	cmp	r0, #1
	movls	r0, r3
	orrhi	r0, r3, #1
	cmp	r0, #0
	addeq	r2, r2, #188416
	mvnne	r0, #0
	streq	r1, [r2, #2368]
	ldmfd	sp, {fp, sp, pc}
.L585:
	.align	2
.L584:
	.word	.LANCHOR0
	.fnend
	.size	SetInstMode, .-SetInstMode
	.align	2
	.global	SCD_ConfigReg
	.type	SCD_ConfigReg, %function
SCD_ConfigReg:
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
	ldr	ip, .L594
	mov	r5, r0
	mov	r0, r3
	ldrb	ip, [ip]
	cmp	ip, #1
	bne	.L593
	cmp	r5, #4
	beq	.L592
	ldr	r6, .L594+4
	mov	r4, r2, asl #2
.L589:
	add	r2, r6, r4
	ldr	r0, [r2, #4]
	add	r0, r5, r0
	bl	MEM_WritePhyWord
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L593:
	mov	r3, r1
	mov	r2, r5
	mov	r1, #1
	bl	VDH_Record_RegData
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L592:
	ldr	r6, .L594+4
	mov	r4, r2, asl #2
	cmp	r1, #0
	add	r3, r6, r4
	ldr	r0, [r3, #4]
	add	r0, r0, #4
	bne	.L590
	bl	MEM_ReadPhyWord
	uxth	r1, r0
	b	.L589
.L590:
	bl	MEM_ReadPhyWord
	orr	r1, r0, #65536
	b	.L589
.L595:
	.align	2
.L594:
	.word	g_HalDisable
	.word	.LANCHOR0
	.fnend
	.size	SCD_ConfigReg, .-SCD_ConfigReg
	.align	2
	.global	CheckScdStateReg
	.type	CheckScdStateReg, %function
CheckScdStateReg:
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
	cmp	r3, #0
	mvneq	r0, #6
	movne	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	CheckScdStateReg, .-CheckScdStateReg
	.align	2
	.global	ScdParseUpMsgInfo
	.type	ScdParseUpMsgInfo, %function
ScdParseUpMsgInfo:
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
	beq	.L603
	ldr	ip, [r0, #12]
	mul	r3, r3, r2
	cmp	ip, #1
	ldrb	ip, [r1, #72]
	bfceq	ip, #0, #1
	orrne	ip, ip, #1
	strb	ip, [r1, #72]
	mov	ip, #0
	ldr	r2, [r0, #4]
	ldrb	lr, [r1, #72]
	ldr	r2, [r2, r3, asl #2]
	mov	r3, r3, asl #2
	add	r3, r3, #8
	mov	r2, r2, lsr #31
	bfi	lr, r2, #1, #1
	strb	lr, [r1, #72]
	ldr	r2, [r0, #4]
	uxtb	lr, lr
	ldr	r2, [r2, r3]
	mov	r2, r2, asr #16
	bfi	lr, r2, #2, #1
	strb	lr, [r1, #72]
	ldr	r2, [r0, #4]
	uxtb	lr, lr
	ldr	r2, [r2, r3]
	ubfx	r2, r2, #4, #3
	bfi	lr, r2, #3, #4
	strb	lr, [r1, #72]
	ldr	r0, [r0, #4]
	ldrh	r2, [r1, #72]
	ldr	r3, [r0, r3]
	and	r3, r3, #7
	bfi	r2, r3, #7, #4
	strh	r2, [r1, #72]
.L600:
	mov	r0, ip
	ldmfd	sp, {fp, sp, pc}
.L603:
	mvn	ip, #0
	b	.L600
	.fnend
	.size	ScdParseUpMsgInfo, .-ScdParseUpMsgInfo
	.align	2
	.global	ScdReturnSegFilter
	.type	ScdReturnSegFilter, %function
ScdReturnSegFilter:
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
	mov	r9, #0
	ldr	r7, [r0, #32]
	mov	r4, r0
	mov	r6, r1
	str	r9, [r2]
	mov	r0, #24
	ldr	r1, .L645
	str	r3, [fp, #-48]
	bl	dprint_vfmw
	ldr	r3, [r4, #8]
	cmp	r3, #2
	beq	.L605
	cmp	r7, r9
	ldrgt	r3, [fp, #4]
	movgt	r5, r9
	movgt	r8, r3, asl #2
	ble	.L610
.L609:
	ldr	r3, [r4, #4]
	mov	ip, r6
	ldr	lr, [r4, #20]
	mov	r2, r5
	ldr	r1, .L645+4
	mov	r0, #24
	ldr	r3, [r3, r9]
	bic	r3, r3, #-2147483648
	cmp	r3, lr
	orrcc	r3, r3, #-2147483648
	str	r3, [ip, r9]!
	ldr	r3, [r4, #4]
	add	r3, r3, r9
	add	r9, r9, r8
	ldr	r3, [r3, #4]
	str	r3, [ip, #4]
	ldr	r3, [r4, #4]
	ldr	r3, [r3, r5, asl #2]
	add	r5, r5, #1
	bl	dprint_vfmw
	cmp	r5, r7
	bne	.L609
.L610:
	ldr	r3, [fp, #-48]
	mov	r0, #0
	str	r0, [r4, #12]
	str	r0, [r4, #16]
	str	r7, [r3]
.L640:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L605:
	ldr	r0, [r4, #20]
	bl	MEM_Phy2Vir
	cmp	r0, #0
	beq	.L612
	ldrb	r2, [r0, #1]
	ldrb	r1, [r0]
	ldrb	r3, [r0, #3]
	ldrb	r5, [r0, #2]
	mov	r2, r2, asl #16
	orr	r2, r2, r1, asl #24
	ldr	r0, [r4, #28]
	orr	r3, r2, r3
	orr	r5, r3, r5, asl #8
	bl	MEM_Phy2Vir
	cmp	r0, #0
	beq	.L612
	cmp	r7, #0
	mov	r2, r5, lsr #24
	mov	r3, r5, lsr #16
	strb	r5, [r0, #3]
	strb	r2, [r0]
	mov	r5, r5, lsr #8
	strb	r3, [r0, #1]
	strb	r5, [r0, #2]
	ble	.L613
	add	r3, r7, #1
	str	r3, [fp, #-52]
	ldr	r3, [fp, #4]
	add	r10, r6, #4
	mov	r8, #4
	mov	r9, #1
	mov	r5, r3, asl #2
	b	.L621
.L642:
	mov	r3, #0
	mov	r2, #1
	str	r3, [r4, #16]
	mov	ip, r9
	str	r2, [r4, #12]
	str	r7, [r10, #-4]
	ldr	r3, [r4, #4]
	ldr	r3, [r3, r8]
	str	r3, [r6, r8]
.L616:
	ldr	r3, [fp, #-52]
	add	r9, r9, #1
	add	r8, r8, r5
	add	r10, r10, r5
	cmp	r9, r3
	beq	.L641
.L621:
	ldr	r3, [r4, #4]
	ldr	r2, [r4, #20]
	add	r3, r3, r8
	ldr	r7, [r3, #-4]
	bic	r7, r7, #-2147483648
	cmp	r7, r2
	orrcc	r7, r7, #-2147483648
	cmp	r7, #0
	beq	.L612
	mov	r0, r7
	bl	MEM_Phy2Vir
	cmp	r0, #0
	beq	.L612
	ldrb	r3, [r0, #1]
	ldrb	ip, [r0]
	ldrb	r1, [r0, #3]
	mov	r3, r3, asl #16
	ldrb	r2, [r0, #2]
	orr	r3, r3, ip, asl #24
	orr	r3, r3, r1
	orr	r2, r3, r2, asl #8
	movw	r3, #438
	cmp	r2, r3
	cmpne	r2, #288
	moveq	r3, #1
	movne	r3, #0
	beq	.L642
	bic	r2, r2, #1020
	bic	r2, r2, #3
	cmp	r2, #32768
	beq	.L643
.L617:
	str	r7, [r10, #-4]
	mov	ip, r9
	ldr	r3, [r4, #4]
	ldr	r3, [r3, r8]
	str	r3, [r6, r8]
	b	.L616
.L643:
	ldr	r2, [r4, #12]
	cmp	r2, #1
	beq	.L644
.L620:
	mov	r3, #2
	str	r3, [r4, #12]
	b	.L617
.L612:
	mvn	r0, #6
	b	.L640
.L644:
	ldr	r2, [r4, #16]
	add	r2, r2, #1
	str	r2, [r4, #16]
	cmp	r2, #12
	ble	.L617
	ldr	r2, .L645+8
	ldr	ip, [r2]
	cmp	ip, #0
	beq	.L620
	mov	r2, r3
	mov	r1, #102
	ldr	r0, [r4, #36]
	blx	ip
	b	.L620
.L641:
	ldr	r3, [fp, #-48]
	cmp	ip, #0
	movgt	r4, #0
	movgt	r7, ip
	str	ip, [r3]
	ble	.L624
.L623:
	mov	r2, r4
	ldr	r3, [r6], r5
	ldr	r1, .L645+4
	add	r4, r4, #1
	mov	r0, #24
	bl	dprint_vfmw
	cmp	r4, r7
	bne	.L623
.L624:
	mov	r0, #0
	b	.L640
.L613:
	ldr	r3, [fp, #-48]
	mov	r0, r9
	str	r9, [r3]
	b	.L640
.L646:
	.align	2
.L645:
	.word	.LC41
	.word	.LC42
	.word	g_event_report
	.fnend
	.size	ScdReturnSegFilter, .-ScdReturnSegFilter
	.align	2
	.global	CheckSegValid
	.type	CheckSegValid, %function
CheckSegValid:
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
	cmp	r0, #0
	beq	.L649
	ldr	r3, [r0, #8]
	cmp	r3, #0
	beq	.L651
	ldr	r3, [r0]
	cmp	r3, #0
	beq	.L651
	ldr	r3, [r0, #12]
	cmp	r3, r1
	mvngt	r0, #6
	movle	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L651:
	mvn	r0, #6
	ldmfd	sp, {fp, sp, pc}
.L649:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	CheckSegValid, .-CheckSegValid
	.align	2
	.global	GetSegPts
	.type	GetSegPts, %function
GetSegPts:
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
	mov	r4, r3
	sub	r3, fp, #28
	mvn	r6, #0
	mvn	r7, #0
	mov	lr, #0
	mov	r5, r2
	add	ip, r4, #32
	add	r2, r4, #68
	str	ip, [sp, #28]
	add	ip, r4, #64
	str	r2, [sp, #24]
	add	r2, r4, #60
	str	ip, [sp, #20]
	add	ip, r4, #56
	str	r2, [sp, #16]
	add	r2, r4, #48
	str	ip, [sp, #12]
	add	ip, r4, #40
	str	r2, [sp, #8]
	add	r2, r4, #24
	stmia	sp, {r2, ip}
	mvn	ip, #0
	str	lr, [r3, #-4]!
	sub	r2, fp, #36
	strd	r6, [r4, #24]
	strd	r6, [r4, #40]
	strd	r6, [r4, #32]
	strd	r6, [r4, #48]
	str	ip, [r4, #56]
	str	ip, [r4, #60]
	str	ip, [r4, #64]
	str	ip, [r4, #68]
	str	lr, [fp, #-36]
	bl	GetRawNumOffsert
	ldrd	r0, [r4, #24]
	ldrd	r2, [r5]
	cmp	r3, r1
	cmpeq	r2, r0
	beq	.L656
	strd	r0, [r5]
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L656:
	strd	r6, [r4, #24]
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	GetSegPts, .-GetSegPts
	.align	2
	.global	IsVopHeader
	.type	IsVopHeader, %function
IsVopHeader:
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
	beq	.L662
	cmp	r0, #2
	movne	r0, #0
	beq	.L663
.L659:
	mov	r2, #0
	movt	r2, 65025
	cmp	r1, r2
	moveq	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L662:
	mov	r3, #0
	movt	r3, 46593
	rsb	r0, r3, r1
	clz	r0, r0
	mov	r0, r0, lsr #5
	b	.L659
.L663:
	ubfx	r3, r1, #16, #8
	sub	r3, r3, #128
	cmp	r3, #3
	movhi	r0, #0
	movls	r0, #1
	b	.L659
	.fnend
	.size	IsVopHeader, .-IsVopHeader
	.align	2
	.global	SM_GetExteriorState
	.type	SM_GetExteriorState, %function
SM_GetExteriorState:
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
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	SM_GetExteriorState, .-SM_GetExteriorState
	.align	2
	.global	FillEopRawStream
	.type	FillEopRawStream, %function
FillEopRawStream:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #112
	sub	sp, sp, #112
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r2, .L680
	mov	r3, r0, asl #6
	sub	r3, r3, r0, asl #3
	mov	r5, r1
	add	r3, r2, r3
	sub	r0, fp, #120
	mov	r2, #100
	ldr	r1, .L680+4
	ldr	r4, [r3, #56]
	bl	memcpy
	cmp	r5, #0
	beq	.L678
	ldr	r3, [r4, #56]
	cmp	r3, #16
	bhi	.L668
	mov	r1, #1
	movw	r0, #65406
	mov	r2, r1, asl r3
	bfi	r0, r1, #16, #16
	ands	r4, r2, r0
	bne	.L669
	tst	r2, #1
	beq	.L668
	ldr	r3, [r5, #8]
	ldr	r2, [r5, #80]
	add	r1, r3, #15
	cmp	r1, r2
	bhi	.L679
	ldr	ip, .L680+8
	sub	r1, fp, #120
	ldr	r0, [r5, #40]
	mov	r2, #15
	ldr	ip, [ip, #52]
	add	r0, r3, r0
	blx	ip
	ldr	r3, [r5, #8]
	mov	r0, r4
	add	r3, r3, #15
	str	r3, [r5, #8]
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L669:
	ldr	r3, [r5, #8]
	ldr	r2, [r5, #80]
	cmp	r3, r2
	bhi	.L674
	mov	r0, #0
.L675:
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L668:
	ldr	r2, .L680+12
	mov	r0, #0
	ldr	r1, .L680+16
	bl	dprint_vfmw
	mvn	r0, #6
	b	.L675
.L674:
	mov	r1, #0
.L671:
	stmia	sp, {r1, r2}
	mov	r0, #0
	ldr	r2, .L680+12
	ldr	r1, .L680+20
	bl	dprint_vfmw
	mvn	r0, #6
	b	.L675
.L679:
	mov	r1, #15
	b	.L671
.L678:
	mov	r0, r5
	ldr	r2, .L680+12
	ldr	r1, .L680+24
	bl	dprint_vfmw
	mvn	r0, #6
	b	.L675
.L681:
	.align	2
.L680:
	.word	.LANCHOR0
	.word	.LANCHOR3+112
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR3+212
	.word	.LC44
	.word	.LC45
	.word	.LC43
	.fnend
	.size	FillEopRawStream, .-FillEopRawStream
	.align	2
	.global	FillEosRawStream
	.type	FillEosRawStream, %function
FillEosRawStream:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #112
	sub	sp, sp, #112
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r2, .L704
	mov	r3, r0, asl #6
	sub	r3, r3, r0, asl #3
	mov	r4, r1
	add	r3, r2, r3
	sub	r0, fp, #120
	mov	r2, #100
	ldr	r1, .L704+4
	ldr	r5, [r3, #56]
	bl	memcpy
	cmp	r4, #0
	beq	.L702
	ldr	r3, [r5, #56]
	cmp	r3, #17
	ldrls	pc, [pc, r3, asl #2]
	b	.L685
.L687:
	.word	.L686
	.word	.L688
	.word	.L689
	.word	.L690
	.word	.L700
	.word	.L700
	.word	.L696
	.word	.L685
	.word	.L700
	.word	.L700
	.word	.L700
	.word	.L700
	.word	.L700
	.word	.L700
	.word	.L700
	.word	.L686
	.word	.L692
	.word	.L700
.L686:
	sub	r1, fp, #120
	mov	r5, #15
.L691:
	ldr	r3, [r4, #8]
	cmp	r5, r3
	bhi	.L703
	ldr	r3, .L704+8
	mov	r2, r5
	ldr	r0, [r4, #40]
	ldr	r3, [r3, #52]
	blx	r3
	str	r5, [r4, #8]
.L700:
	mov	r0, #0
.L698:
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L696:
	mov	r5, #15
	sub	r1, fp, #100
	b	.L691
.L688:
	ldr	r3, [r5, #72]
	cmp	r3, #1
	bne	.L700
	sub	r1, fp, #100
	mov	r5, #15
	b	.L691
.L689:
	mov	r5, #19
	sub	r1, fp, #80
	b	.L691
.L690:
	mov	r5, #16
	sub	r1, fp, #60
	b	.L691
.L692:
	mov	r5, #16
	sub	r1, fp, #40
	b	.L691
.L685:
	ldr	r2, .L704+12
	mov	r0, #0
	ldr	r1, .L704+16
	bl	dprint_vfmw
	mvn	r0, #6
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L703:
	str	r3, [sp]
	mov	r0, #0
	mov	r3, r5
	ldr	r2, .L704+12
	ldr	r1, .L704+20
	bl	dprint_vfmw
	mvn	r0, #6
	b	.L698
.L702:
	mov	r0, r4
	ldr	r2, .L704+12
	ldr	r1, .L704+24
	bl	dprint_vfmw
	mvn	r0, #6
	b	.L698
.L705:
	.align	2
.L704:
	.word	.LANCHOR0
	.word	.LANCHOR3+232
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR3+332
	.word	.LC44
	.word	.LC46
	.word	.LC43
	.fnend
	.size	FillEosRawStream, .-FillEosRawStream
	.align	2
	.global	FillExtraData
	.type	FillExtraData, %function
FillExtraData:
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
	clz	r3, r1
	mov	r5, r1
	mov	r3, r3, lsr #5
	cmp	r0, #15
	movls	r4, r3
	orrhi	r4, r3, #1
	cmp	r4, #0
	bne	.L723
	ldr	r2, [r1, #8]
	cmp	r2, #0
	ble	.L728
	mov	ip, r0, asl #6
	ldr	r1, .L737
	sub	r0, ip, r0, asl #3
	add	r0, r1, r0
	ldr	r6, [r0, #56]
	ldr	r3, [r6, #56]
	cmp	r3, #5
	beq	.L709
	cmp	r3, #8
	beq	.L710
	cmp	r3, #1
	movne	r0, r4
	beq	.L729
.L707:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L710:
	ldr	ip, [r5, #76]
	ands	r7, ip, #128
	beq	.L720
	cmp	r2, #128
	bgt	.L730
.L721:
	ldr	r3, .L737+4
	add	r1, r6, #200704
	add	r0, r6, #203776
	str	r2, [r1, #3972]
	add	r0, r0, #904
	ldr	r2, [r5, #8]
	ldr	r1, [r5, #40]
	ldr	r3, [r3, #52]
	blx	r3
	mov	r0, r4
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L709:
	ldr	r0, [r5, #80]
	add	r1, r2, #8
	cmp	r1, r0
	bhi	.L731
	ldr	r6, .L737+4
	ldr	r1, [r5, #40]
	ldr	r3, [r6, #56]
	add	r0, r1, #8
	blx	r3
	ldr	r3, [r6, #52]
	add	r1, r5, #84
	mov	r2, #4
	ldr	r0, [r5, #40]
	blx	r3
	ldr	r0, [r5, #40]
	ldr	r3, [r6, #52]
	mov	r2, #4
	add	r1, r5, #88
	add	r0, r0, r2
	blx	r3
	ldr	r3, [r5, #8]
	mov	r0, r4
	add	r3, r3, #8
	str	r3, [r5, #8]
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L729:
	ldr	r1, [r6, #72]
	cmp	r1, #1
	beq	.L732
	ldr	ip, [r5, #76]
	ands	r4, ip, #128
	beq	.L716
	add	r1, r2, #12
	ldr	ip, [r5, #80]
	cmp	r1, #128
	movle	r0, #0
	movgt	r0, #1
	cmp	r1, ip
	movls	r4, r0
	orrhi	r4, r0, #1
	cmp	r4, #0
	bne	.L733
	ldr	r7, .L737+4
	ldr	r1, [r5, #40]
	ldr	r3, [r7, #56]
	add	r0, r1, #8
	blx	r3
	ldr	r3, [r7, #52]
	mov	r2, #4
	add	r1, r5, #84
	ldr	r0, [r5, #40]
	blx	r3
	ldr	r0, [r5, #40]
	mov	r2, #4
	ldr	r3, [r7, #52]
	add	r0, r0, r2
	add	r1, r5, #88
	blx	r3
	ldr	r0, [r5, #40]
	ldr	r3, [r7, #48]
	mov	r2, #4
	mov	r1, r4
	add	r0, r0, #12
	blx	r3
	add	r2, r6, #200704
	add	r0, r6, #203776
	mov	r3, #16
	add	r0, r0, #904
	str	r3, [r5, #8]
	str	r3, [r2, #3972]
	ldr	r3, [r7, #52]
	ldr	r2, [r5, #8]
	ldr	r1, [r5, #40]
	blx	r3
	mov	r0, r4
	b	.L707
.L720:
	add	r4, r6, #200704
	ldr	ip, [r5, #80]
	ldr	r0, [r4, #3972]
	add	r1, r2, r0
	cmp	r1, ip
	bhi	.L734
.L722:
	ldr	r8, .L737+4
	ldr	r1, [r5, #40]
	ldr	r3, [r8, #56]
	add	r0, r1, r0
	blx	r3
	add	r1, r6, #203776
	ldr	r3, [r8, #52]
	add	r1, r1, #904
	ldr	r2, [r4, #3972]
	ldr	r0, [r5, #40]
	blx	r3
	ldr	r2, [r4, #3972]
	ldr	r3, [r5, #8]
	mov	r0, r7
	add	r3, r3, r2
	str	r3, [r5, #8]
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L732:
	ldr	r0, [r5, #76]
	ands	r7, r0, #128
	bne	.L735
	ldrb	ip, [r5, #72]
	cmp	ip, #0
	moveq	r0, ip
	beq	.L707
	add	r4, r6, #200704
	ldr	r3, [r5, #80]
	ldr	r0, [r4, #3972]
	add	ip, r2, r0
	cmp	ip, r3
	strhi	r3, [sp, #4]
	strhi	ip, [sp]
	movhi	r3, r1
	bls	.L722
.L727:
	mov	r0, r3
	ldr	r2, .L737+8
	ldr	r1, .L737+12
	bl	dprint_vfmw
	mvn	r0, #1
	b	.L707
.L716:
	add	r7, r6, #200704
	ldr	ip, [r5, #80]
	ldr	r0, [r7, #3972]
	add	r1, r2, r0
	cmp	r1, ip
	bhi	.L736
	ldr	r8, .L737+4
	ldr	r1, [r5, #40]
	ldr	r3, [r8, #56]
	add	r0, r1, r0
	blx	r3
	add	r1, r6, #203776
	ldr	r3, [r8, #52]
	add	r1, r1, #904
	ldr	r2, [r7, #3972]
	ldr	r0, [r5, #40]
	blx	r3
	ldr	r2, [r7, #3972]
	ldr	r3, [r5, #8]
	mov	r0, r4
	add	r3, r3, r2
	str	r3, [r5, #8]
	b	.L707
.L735:
	cmp	r2, #128
	ble	.L721
	str	r2, [sp]
	mov	r3, r1
	mov	r2, #128
	mov	r0, r1
	str	r2, [sp, #4]
	ldr	r1, .L737+16
	ldr	r2, .L737+8
	bl	dprint_vfmw
	mvn	r0, #1
	b	.L707
.L731:
	str	r0, [sp, #4]
	mov	r0, #1
	str	r1, [sp]
	ldr	r2, .L737+8
	ldr	r1, .L737+20
	bl	dprint_vfmw
	mvn	r0, #1
	b	.L707
.L733:
	mov	r2, #128
	str	r1, [sp]
	str	r2, [sp, #8]
	mov	r0, r3
	str	ip, [sp, #4]
	ldr	r2, .L737+8
	ldr	r1, .L737+24
	bl	dprint_vfmw
	mvn	r0, #1
	b	.L707
.L723:
	mvn	r0, #0
	b	.L707
.L728:
	mov	r3, r2
	ldr	r1, .L737+28
	ldr	r2, .L737+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L707
.L734:
	stmia	sp, {r1, ip}
	mov	r0, #1
	ldr	r2, .L737+8
	ldr	r1, .L737+12
	bl	dprint_vfmw
	mvn	r0, #1
	b	.L707
.L730:
	str	r2, [sp]
	mov	r1, #128
	ldr	r2, .L737+8
	mov	r0, #1
	str	r1, [sp, #4]
	ldr	r1, .L737+16
	bl	dprint_vfmw
	mvn	r0, #1
	b	.L707
.L736:
	stmia	sp, {r1, ip}
	b	.L727
.L738:
	.align	2
.L737:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR3+352
	.word	.LC49
	.word	.LC48
	.word	.LC51
	.word	.LC50
	.word	.LC47
	.fnend
	.size	FillExtraData, .-FillExtraData
	.align	2
	.global	ReleaseRawStreamData
	.type	ReleaseRawStreamData, %function
ReleaseRawStreamData:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #112
	sub	sp, sp, #112
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r6, r1
	mov	r8, r0
	bl	VCTRL_GetStreamInterface
	ldr	r5, .L754
	mov	r2, #12
	mov	r1, #0
	ldr	r3, [r5, #48]
	mov	r4, r0
	sub	r0, fp, #144
	blx	r3
	cmp	r4, #0
	beq	.L751
	ldr	r3, [r5, #52]
	mov	r2, #12
	mov	r1, r4
	sub	r0, fp, #144
	blx	r3
	ldr	r3, [r5, #52]
	mov	r1, r6
	sub	r0, fp, #132
	mov	r2, #96
	blx	r3
	ldr	r3, [r4, #8]
	cmp	r3, #0
	beq	.L746
	mov	r9, r8, asl #3
	mov	r7, r8, asl #6
	ldr	r6, .L754+4
	rsb	r4, r9, r7
	add	r4, r6, r4
	ldr	r3, [r4, #56]
	ldr	r3, [r3, #88]
	cmp	r3, #1
	beq	.L752
	ldr	r3, [r5, #16]
	mov	r0, #0
	blx	r3
	ldr	r3, [r5, #24]
	mov	r1, r8
	mov	r0, #1
	blx	r3
	ldr	r3, [r4, #56]
	cmp	r3, #0
	mvneq	r4, #6
	beq	.L745
	sub	r1, fp, #132
	ldr	r3, [fp, #-136]
	ldr	r0, [fp, #-144]
	blx	r3
	mov	r4, r0
.L745:
	ldr	r3, [r5, #28]
	mov	r0, #1
	mov	r1, r8
	blx	r3
	ldr	r3, [r5, #12]
	mov	r0, #0
	blx	r3
.L744:
	cmp	r4, #0
	mvnne	r4, #6
.L742:
	rsb	r7, r9, r7
	add	r6, r6, r7
	ldr	r0, [r6, #56]
	cmp	r0, #0
	movne	r0, r4
	beq	.L753
.L741:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L752:
	sub	r1, fp, #132
	ldr	r3, [fp, #-136]
	ldr	r0, [fp, #-144]
	blx	r3
	mov	r4, r0
	b	.L744
.L746:
	ldr	r6, .L754+4
	mov	r9, r8, asl #3
	mov	r7, r8, asl #6
	mvn	r4, #6
	b	.L742
.L751:
	mov	r2, r8
	mov	r0, r4
	ldr	r1, .L754+8
	bl	dprint_vfmw
	mvn	r0, #6
	b	.L741
.L753:
	mov	r3, r8
	movw	r2, #5348
	ldr	r1, .L754+12
	bl	dprint_vfmw
	mvn	r0, #6
	b	.L741
.L755:
	.align	2
.L754:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.word	.LC52
	.word	.LC53
	.fnend
	.size	ReleaseRawStreamData, .-ReleaseRawStreamData
	.align	2
	.global	DeleteRawPacketInBuffer
	.type	DeleteRawPacketInBuffer, %function
DeleteRawPacketInBuffer:
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
	cmp	r0, #15
	mov	r7, r0
	bhi	.L772
	mov	r9, r0, asl #3
	mov	r10, r0, asl #6
	ldr	r2, .L776
	rsb	r3, r9, r10
	add	r3, r2, r3
	ldr	r6, [r3, #56]
	cmp	r6, #0
	beq	.L768
	cmp	r1, #0
	beq	.L773
.L759:
	adds	r3, r6, #112
	str	r3, [fp, #-52]
	beq	.L768
	add	r3, r6, #98304
	str	r3, [fp, #-56]
	mov	r2, r3
	ldr	r3, [r3, #112]
	ldr	r4, [r2, #120]
	cmp	r3, r4
	addlt	r3, r3, #1024
	rsb	r3, r4, r3
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-48]
	cmp	r3, #0
	beq	.L768
	mov	r8, #0
	mov	r3, r10
	mov	r10, r9
	mov	r9, r8
	mov	r8, r3
	b	.L763
.L775:
	ldr	r3, [fp, #-48]
	cmp	r9, r3
	beq	.L774
.L763:
	mov	r5, r4, asl #7
	ldr	r2, .L776+4
	sub	r5, r5, r4, asl #5
	ldr	r1, .L776+8
	add	lr, r6, r5
	mov	r0, #26
	add	r4, r4, #1
	add	r9, r9, #1
	ldr	r3, [lr, #116]
	ubfx	r4, r4, #0, #10
	ldr	lr, [lr, #120]
	str	lr, [sp]
	bl	dprint_vfmw
	ldr	r3, [fp, #-52]
	mov	r0, r7
	add	r1, r3, r5
	bl	ReleaseRawStreamData
	ldr	r2, .L776
	rsb	r3, r10, r8
	add	r3, r2, r3
	ldr	r3, [r3, #56]
	cmp	r3, #0
	bne	.L775
	mvn	r0, #6
.L758:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L773:
	add	r3, r6, #188416
	ldr	r3, [r3, #2368]
	cmp	r3, #0
	bne	.L759
.L768:
	mvn	r0, #0
	b	.L758
.L774:
	ldr	r3, [fp, #-56]
	ldr	r4, [r3, #120]
	add	r4, r4, r9
	cmp	r4, #1024
	strlt	r4, [r3, #120]
	subge	r4, r4, #1024
	ldrge	r3, [fp, #-56]
	movlt	r0, #0
	movge	r0, #0
	strge	r4, [r3, #120]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L772:
	mov	r2, r0
	ldr	r1, .L776+12
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L758
.L777:
	.align	2
.L776:
	.word	.LANCHOR0
	.word	.LANCHOR3+368
	.word	.LC11
	.word	.LC54
	.fnend
	.size	DeleteRawPacketInBuffer, .-DeleteRawPacketInBuffer
	.align	2
	.global	ReadRawStreamData
	.type	ReadRawStreamData, %function
ReadRawStreamData:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #16
	sub	sp, sp, #16
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r5, .L813
	mov	r3, r0, asl #6
	sub	r3, r3, r0, asl #3
	ldr	r7, .L813+4
	add	r5, r5, r3
	mov	r6, r0
	mov	r9, r1
	sub	r0, fp, #48
	ldr	r4, [r5, #56]
	mov	r2, #12
	ldr	r3, [r7, #48]
	mov	r1, #0
	blx	r3
	cmp	r4, #0
	beq	.L782
	mov	r0, r6
	bl	VCTRL_GetStreamInterface
	subs	r8, r0, #0
	beq	.L806
	ldr	r3, [r7, #52]
	sub	r0, fp, #48
	mov	r2, #12
	mov	r1, r8
	blx	r3
	ldr	r3, [r8, #4]
	cmp	r3, #0
	beq	.L782
	ldr	r3, [r4, #88]
	cmp	r3, #1
	beq	.L807
	ldr	r3, [r7, #16]
	mov	r0, #0
	blx	r3
	ldr	r3, [fp, #-44]
	mov	r1, r9
	ldr	r0, [fp, #-48]
	blx	r3
	ldr	r3, [r7, #12]
	mov	r8, r0
	mov	r0, #0
	blx	r3
	ldr	r0, [r5, #56]
	cmp	r0, #0
	beq	.L808
.L784:
	cmp	r8, #0
	bne	.L782
	ldrb	r5, [r9, #1]
	cmp	r5, #1
	beq	.L809
	ldr	r3, [r4, #88]
	cmp	r3, #1
	beq	.L810
.L787:
	add	r4, r4, #98304
	ldr	r2, [r9, #8]
	mov	r0, #0
	ldr	r3, [r4, #132]
	add	r3, r3, r2
	str	r3, [r4, #132]
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L782:
	mvn	r0, #6
.L803:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L807:
	ldr	r3, [fp, #-44]
	mov	r1, r9
	ldr	r0, [fp, #-48]
	blx	r3
	mov	r8, r0
	b	.L784
.L809:
	mov	r1, r9
	mov	r0, r6
	bl	FillEosRawStream
	cmp	r0, #0
	bne	.L811
	mov	r1, r5
	mov	r0, r6
	bl	VCTRL_SetLastFrameState
	b	.L787
.L810:
	mov	r1, r9
	mov	r0, r6
	bl	FillExtraData
	cmp	r0, #0
	bne	.L812
	add	r3, r4, #200704
	ldr	r3, [r3, #3968]
	cmp	r3, #0
	beq	.L787
	ldrb	r3, [r9]
	cmp	r3, #0
	bne	.L787
	mov	r0, r6
	mov	r1, r9
	bl	FillEopRawStream
	b	.L787
.L812:
	mov	r2, r6
	ldr	r1, .L813+8
	mov	r0, r8
	bl	dprint_vfmw
	mov	r1, r9
	ldr	r0, [fp, #-48]
	bl	ReleaseRawStreamData
	cmp	r0, #0
	beq	.L782
	mov	r0, r8
	ldr	r1, .L813+12
	bl	dprint_vfmw
	mvn	r0, #6
	b	.L803
.L806:
	mov	r2, r6
	ldr	r1, .L813+16
	bl	dprint_vfmw
	mvn	r0, #6
	b	.L803
.L811:
	mov	r2, r6
	mov	r0, r8
	ldr	r1, .L813+20
	bl	dprint_vfmw
	mvn	r0, #6
	b	.L803
.L808:
	mov	r3, r6
	movw	r2, #5247
	ldr	r1, .L813+24
	bl	dprint_vfmw
	mvn	r0, #6
	b	.L803
.L814:
	.align	2
.L813:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC58
	.word	.LC59
	.word	.LC55
	.word	.LC57
	.word	.LC56
	.fnend
	.size	ReadRawStreamData, .-ReadRawStreamData
	.align	2
	.global	SM_MoveRawData
	.type	SM_MoveRawData, %function
SM_MoveRawData:
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
	add	r7, r0, #98304
	mov	r5, r0
	ldr	r3, [r7, #116]
	subs	r6, r3, #1
	addmi	r6, r3, #1020
	addmi	r6, r6, #3
	subs	r8, r3, #2
	addmi	r8, r3, #1020
	addmi	r8, r8, #2
	mov	r1, r6, asl #7
	sub	r1, r1, r6, asl #5
	mov	r3, r8, asl #7
	add	r9, r0, r1
	sub	r8, r3, r8, asl #5
	add	r1, r1, #112
	add	r8, r0, r8
	ldr	r3, [r0, #96]
	add	r4, r0, r1
	ldr	r2, [r9, #120]
	ldr	r0, [r8, #120]
	add	r1, r0, r2
	cmp	r1, r3
	bgt	.L818
	ldr	r3, .L820
	add	r5, r5, #188416
	ldr	ip, [r8, #152]
	ldr	r1, [r9, #152]
	ldr	r3, [r3, #52]
	add	r0, r0, ip
	blx	r3
	ldr	r2, [r9, #120]
	ldr	r3, [r8, #120]
	mov	r1, r4
	add	r3, r3, r2
	str	r3, [r8, #120]
	ldr	r0, [r5, #2352]
	bl	ReleaseRawStreamData
	mov	r0, #0
	str	r6, [r7, #116]
.L819:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L818:
	str	r3, [sp]
	mov	r3, r2
	ldr	r1, .L820+4
	mov	r2, r0
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #6
	b	.L819
.L821:
	.align	2
.L820:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC60
	.fnend
	.size	SM_MoveRawData, .-SM_MoveRawData
	.align	2
	.global	SM_AddMatchMode
	.type	SM_AddMatchMode, %function
SM_AddMatchMode:
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
	ldr	r4, .L838
	ldr	r7, .L838+4
	add	r6, r4, #896
	b	.L827
.L826:
	bl	dprint_vfmw
.L835:
	add	r5, r5, #188416
	mov	r3, #0
	str	r3, [r5, #2364]
.L823:
	add	r4, r4, #56
	cmp	r4, r6
	beq	.L837
.L827:
	ldr	r5, [r4, #48]
	cmp	r5, #0
	beq	.L823
	ldr	r3, [r5, #80]
	mov	r0, #0
	ldr	r1, .L838+8
	cmp	r3, r0
	beq	.L823
	ldr	ip, [r7]
	ldr	r3, [r7, #4]
	cmp	ip, #1
	mov	r2, ip
	bne	.L826
	cmp	r3, #1
	beq	.L835
	cmp	r3, #2
	addeq	r5, r5, #188416
	streq	ip, [r5, #2364]
	bne	.L826
	add	r4, r4, #56
	cmp	r4, r6
	bne	.L827
.L837:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L839:
	.align	2
.L838:
	.word	.LANCHOR0+8
	.word	g_DspDrvState
	.word	.LC61
	.fnend
	.size	SM_AddMatchMode, .-SM_AddMatchMode
	.align	2
	.global	SCDDRV_CheckDevice
	.type	SCDDRV_CheckDevice, %function
SCDDRV_CheckDevice:
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
	subs	r6, r0, #0
	bne	.L848
	ldr	r4, .L853
	movw	r3, #6300
	str	r6, [sp]
	mov	r0, #26
	ldr	r2, .L853+4
	ldr	ip, [r4, #988]
	ldr	r1, .L853+8
	str	ip, [sp, #4]
	bl	dprint_vfmw
	ldr	r5, [r4, #988]
	cmp	r5, #0
	beq	.L852
	movw	r3, #6310
	ldr	r2, .L853+4
	ldr	r1, .L853+8
	mov	r0, #26
	str	r5, [sp, #4]
	str	r6, [sp]
	bl	dprint_vfmw
	ldr	r3, .L853+12
	ldr	r3, [r3]
	blx	r3
	ldr	r3, [r4, #992]
	cmp	r0, r3
	strcc	r0, [r4, #992]
	bcc	.L844
	rsb	r0, r3, r0
	cmp	r0, #2000
	bls	.L844
	ldr	r2, [r4, #984]
	mov	r3, r6
	str	r0, [sp]
	mov	r0, #1
	ldr	r1, .L853+16
	bl	dprint_vfmw
	ldr	r3, .L853+20
	ldrb	r3, [r3]
	cmp	r3, #1
	beq	.L845
	mov	r1, r6
	mov	r0, r6
	bl	VDH_Reset_Module
.L846:
	ldr	r0, [r4, #984]
	mov	r2, #0
	str	r2, [r4, #988]
	mov	r5, #0
	mov	r3, r0, asl #6
	sub	r3, r3, r0, asl #3
	add	r4, r4, r3
	ldr	r3, [r4, #56]
	cmp	r3, r2
	addne	r3, r3, #188416
	strne	r2, [r3, #2360]
	bl	DeleteLastSendRaw
	mov	r0, r5
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L844:
	mov	r2, #0
	movw	r3, #6359
	str	r2, [sp]
	mov	r0, #26
	ldr	r2, .L853+4
	mov	r5, #1
	ldr	r1, .L853+24
	bl	dprint_vfmw
.L841:
	mov	r0, r5
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L852:
	str	r5, [sp]
	movw	r3, #6304
	ldr	r2, .L853+4
	mov	r0, #26
	ldr	r1, .L853+28
	bl	dprint_vfmw
	mov	r0, r5
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L845:
	mov	r0, r6
	bl	ResetSCD
	b	.L846
.L848:
	mvn	r5, #0
	b	.L841
.L854:
	.align	2
.L853:
	.word	.LANCHOR0
	.word	.LANCHOR3+392
	.word	.LC62
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC64
	.word	g_HalDisable
	.word	.LC65
	.word	.LC63
	.fnend
	.size	SCDDRV_CheckDevice, .-SCDDRV_CheckDevice
	.align	2
	.global	SCDDRV_MarkReloadDsp
	.type	SCDDRV_MarkReloadDsp, %function
SCDDRV_MarkReloadDsp:
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
	cmp	r0, #0
	ldmnefd	sp, {fp, sp, pc}
	add	r3, r1, #1
	cmp	r3, #16
	ldmhifd	sp, {fp, sp, pc}
	ldr	r3, .L862
	cmn	r1, #1
	mov	r2, #1
	str	r2, [r3, #996]
	ldmeqfd	sp, {fp, sp, pc}
	mov	r2, r1, asl #6
	mvn	r0, #0
	sub	r1, r2, r1, asl #3
	add	r3, r3, r1
	ldr	r3, [r3, #56]
	add	r3, r3, #188416
	str	r0, [r3, #2364]
	ldmfd	sp, {fp, sp, pc}
.L863:
	.align	2
.L862:
	.word	.LANCHOR0
	.fnend
	.size	SCDDRV_MarkReloadDsp, .-SCDDRV_MarkReloadDsp
	.align	2
	.global	SM_UpdateMatchMode
	.type	SM_UpdateMatchMode, %function
SM_UpdateMatchMode:
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
	cmp	r0, #0
	ldmnefd	sp, {fp, sp, pc}
	cmp	r1, #15
	ldmhifd	sp, {fp, sp, pc}
	mov	r2, r1, asl #6
	ldr	r3, .L866
	sub	r1, r2, r1, asl #3
	mov	r2, #1
	add	r1, r3, r1
	ldr	r3, [r1, #56]
	add	r3, r3, #188416
	str	r2, [r3, #2364]
	ldmfd	sp, {fp, sp, pc}
.L867:
	.align	2
.L866:
	.word	.LANCHOR0
	.fnend
	.size	SM_UpdateMatchMode, .-SM_UpdateMatchMode
	.align	2
	.global	WaitSCDFinish
	.type	WaitSCDFinish, %function
WaitSCDFinish:
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
	ldr	r6, .L878
	mov	r3, r0, asl #7
	sub	r3, r3, r0, asl #5
	add	r3, r6, r3
	ldr	r3, [r3, #988]
	cmp	r3, #1
	beq	.L869
.L871:
	mov	r0, #0
.L870:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L869:
	ldr	r7, .L878+4
	add	r6, r6, r0, lsl #2
	movw	r5, #41248
	movt	r5, 7
	ldr	r3, [r7]
	blx	r3
	mov	r4, r0
	b	.L875
.L874:
	subs	r5, r5, #1
	beq	.L877
.L875:
	ldr	r0, [r6, #4]
	add	r0, r0, #2112
	bl	MEM_ReadPhyWord
	tst	r0, #1
	bne	.L871
	ldr	r3, [r7]
	blx	r3
	cmp	r4, r0
	rsb	r2, r0, r4
	rsb	r3, r4, r0
	mvnhi	r3, r2
	cmp	r3, #1000
	bls	.L874
	str	r3, [sp]
	mov	r2, r4
	mov	r3, r0
	ldr	r1, .L878+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #6
	b	.L870
.L877:
	mvn	r0, #6
	b	.L870
.L879:
	.align	2
.L878:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC66
	.fnend
	.size	WaitSCDFinish, .-WaitSCDFinish
	.align	2
	.global	PrintScdVtrlReg
	.type	PrintScdVtrlReg, %function
PrintScdVtrlReg:
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
	ldr	r4, .L881
	mov	r5, r0
	add	r4, r4, r0, lsl #2
	ldr	r0, [r4, #4]
	add	r0, r0, #2048
	add	r0, r0, #4
	bl	MEM_ReadPhyWord
	str	r0, [fp, #-52]
	ldr	r0, [r4, #4]
	add	r0, r0, #2048
	add	r0, r0, #8
	bl	MEM_ReadPhyWord
	str	r0, [fp, #-48]
	ldr	r0, [r4, #4]
	add	r0, r0, #2048
	add	r0, r0, #12
	bl	MEM_ReadPhyWord
	mov	r10, r0
	ldr	r0, [r4, #4]
	add	r0, r0, #2064
	bl	MEM_ReadPhyWord
	mov	r9, r0
	ldr	r0, [r4, #4]
	add	r0, r0, #2064
	add	r0, r0, #4
	bl	MEM_ReadPhyWord
	mov	r8, r0
	ldr	r0, [r4, #4]
	add	r0, r0, #2064
	add	r0, r0, #8
	bl	MEM_ReadPhyWord
	mov	r7, r0
	ldr	r0, [r4, #4]
	add	r0, r0, #2080
	bl	MEM_ReadPhyWord
	mov	r6, r0
	ldr	r0, [r4, #4]
	add	r0, r0, #2048
	bl	MEM_ReadPhyWord
	mov	r2, r5
	ldr	r1, .L881+4
	mov	r4, r0
	mov	r0, #24
	bl	dprint_vfmw
	ldr	ip, [fp, #-52]
	ldr	r1, .L881+8
	mov	r0, #24
	mov	r2, ip
	bl	dprint_vfmw
	ldr	r3, [fp, #-48]
	ldr	r1, .L881+12
	mov	r0, #24
	mov	r2, r3
	bl	dprint_vfmw
	mov	r2, r10
	ldr	r1, .L881+16
	mov	r0, #24
	bl	dprint_vfmw
	mov	r2, r9
	ldr	r1, .L881+20
	mov	r0, #24
	bl	dprint_vfmw
	mov	r2, r8
	ldr	r1, .L881+24
	mov	r0, #24
	bl	dprint_vfmw
	mov	r2, r7
	ldr	r1, .L881+28
	mov	r0, #24
	bl	dprint_vfmw
	mov	r2, r6
	ldr	r1, .L881+32
	mov	r0, #24
	bl	dprint_vfmw
	sxtb	r2, r4
	ldr	r1, .L881+36
	mov	r0, #24
	bl	dprint_vfmw
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L882:
	.align	2
.L881:
	.word	.LANCHOR0
	.word	.LC67
	.word	.LC68
	.word	.LC69
	.word	.LC70
	.word	.LC71
	.word	.LC72
	.word	.LC73
	.word	.LC74
	.word	.LC75
	.fnend
	.size	PrintScdVtrlReg, .-PrintScdVtrlReg
	.align	2
	.global	WriteScdVtrlReg
	.type	WriteScdVtrlReg, %function
WriteScdVtrlReg:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #188
	sub	sp, sp, #188
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r5, .L940
	mov	r8, r0
	mov	r4, r1
	mov	r6, r2
	ldrb	r3, [r5]
	cmp	r3, #1
	beq	.L884
	ldr	r3, .L940+4
	sub	r0, fp, #224
	mov	r2, #180
	mov	r1, #0
	mov	r7, r0
	ldr	r3, [r3, #48]
	blx	r3
.L885:
	ldrb	r2, [r5]
	ldr	r1, [r4, #4]
	cmp	r2, #1
	bne	.L922
	ldr	r2, .L940+8
	add	r3, r2, r6, lsl #2
	ldr	r0, [r3, #4]
	add	r0, r0, #2048
	add	r0, r0, #4
	bl	MEM_WritePhyWord
	ldrb	r2, [r5]
	ldr	r1, [r4, #16]
	cmp	r2, #1
	bne	.L923
.L888:
	ldr	r2, .L940+8
	add	r3, r2, r6, lsl #2
	ldr	r0, [r3, #4]
	add	r0, r0, #2048
	add	r0, r0, #8
	bl	MEM_WritePhyWord
	ldrb	r2, [r5]
	ldr	r1, [r4, #20]
	cmp	r2, #1
	bne	.L924
.L890:
	ldr	r2, .L940+8
	add	r3, r2, r6, lsl #2
	ldr	r0, [r3, #4]
	add	r0, r0, #2048
	add	r0, r0, #12
	bl	MEM_WritePhyWord
	ldrb	r2, [r5]
	ldr	r1, [r4, #24]
	cmp	r2, #1
	bne	.L925
.L892:
	ldr	r2, .L940+8
	add	r3, r2, r6, lsl #2
	ldr	r0, [r3, #4]
	add	r0, r0, #2064
	bl	MEM_WritePhyWord
	ldrb	r2, [r5]
	ldr	r1, [r4, #28]
	cmp	r2, #1
	bne	.L926
.L894:
	ldr	r2, .L940+8
	add	r3, r2, r6, lsl #2
	ldr	r0, [r3, #4]
	add	r0, r0, #2064
	add	r0, r0, #4
	bl	MEM_WritePhyWord
	ldrb	r2, [r5]
	ldr	r1, [r4, #32]
	cmp	r2, #1
	bne	.L927
.L896:
	ldr	r2, .L940+8
	add	r3, r2, r6, lsl #2
	ldr	r0, [r3, #4]
	add	r0, r0, #2064
	add	r0, r0, #8
	bl	MEM_WritePhyWord
.L897:
	ldr	r1, [r4, #112]
	ldr	ip, [r4, #104]
	ldrsb	r3, [r4, #1]
	ldr	r2, [r4, #36]
	mov	r1, r1, asl #9
	ldrb	r0, [r5]
	orr	r1, r1, ip, asl #8
	and	r2, r2, #15
	mov	r3, r3, asl #4
	cmp	r0, #1
	orr	r1, r1, r2
	and	r3, r3, #16
	orr	r1, r1, r3
	bne	.L928
	ldr	r3, .L940+8
	add	r3, r3, r6, lsl #2
	ldr	r0, [r3, #4]
	add	r0, r0, #2080
	bl	MEM_WritePhyWord
	ldr	r3, [r4, #104]
	cmp	r3, #0
	bne	.L929
.L900:
	ldrb	r2, [r5]
	ldr	r1, [r4, #44]
	cmp	r2, #1
	bne	.L930
	ldr	r2, .L940+8
	add	r3, r2, r6, lsl #2
	ldr	r0, [r3, #4]
	add	r0, r0, #2080
	add	r0, r0, #8
	bl	MEM_WritePhyWord
.L903:
	ldrb	r2, [r5]
	ldr	r1, [r4, #56]
	cmp	r2, #1
	bne	.L931
	ldr	r2, .L940+8
	add	r3, r2, r6, lsl #2
	ldr	r0, [r3, #4]
	add	r0, r0, #2080
	add	r0, r0, #12
	bl	MEM_WritePhyWord
.L905:
	ldrb	r2, [r5]
	ldr	r1, [r4, #68]
	cmp	r2, #1
	bne	.L932
	ldr	r2, .L940+8
	add	r3, r2, r6, lsl #2
	ldr	r0, [r3, #4]
	add	r0, r0, #2096
	bl	MEM_WritePhyWord
.L907:
	ldrb	r2, [r5]
	ldr	r1, [r4, #80]
	cmp	r2, #1
	bne	.L933
	ldr	r2, .L940+8
	add	r3, r2, r6, lsl #2
	ldr	r0, [r3, #4]
	add	r0, r0, #2096
	add	r0, r0, #4
	bl	MEM_WritePhyWord
.L909:
	ldrb	r2, [r5]
	ldr	r1, [r4, #92]
	cmp	r2, #1
	bne	.L934
	ldr	r2, .L940+8
	add	r3, r2, r6, lsl #2
	ldr	r0, [r3, #4]
	add	r0, r0, #2096
	add	r0, r0, #8
	bl	MEM_WritePhyWord
.L911:
	ldrb	r3, [r5]
	cmp	r3, #1
	bne	.L935
	ldr	r3, .L940+8
	mov	r1, #0
	ldr	r10, .L940
	add	r3, r3, r6, lsl #2
	ldr	r0, [r3, #4]
	add	r0, r0, #2064
	add	r0, r0, #12
	bl	MEM_WritePhyWord
	ldrb	r9, [r5]
	cmp	r9, #1
	beq	.L914
.L936:
	ldr	r2, [r4, #104]
	sub	r0, fp, #224
	mov	r3, #0
	str	r8, [fp, #-216]
	strb	r6, [fp, #-224]
	strb	r2, [fp, #-223]
	str	r3, [fp, #-220]
	bl	VDH_PostTask
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L922:
	mov	r3, r1
	movw	r2, #2052
	mov	r1, #1
	mov	r0, r7
	bl	VDH_Record_RegData
	ldrb	r2, [r5]
	ldr	r1, [r4, #16]
	cmp	r2, #1
	beq	.L888
.L923:
	mov	r3, r1
	movw	r2, #2056
	mov	r1, #1
	mov	r0, r7
	bl	VDH_Record_RegData
	ldrb	r2, [r5]
	ldr	r1, [r4, #20]
	cmp	r2, #1
	beq	.L890
.L924:
	mov	r3, r1
	movw	r2, #2060
	mov	r1, #1
	mov	r0, r7
	bl	VDH_Record_RegData
	ldrb	r2, [r5]
	ldr	r1, [r4, #24]
	cmp	r2, #1
	beq	.L892
.L925:
	mov	r3, r1
	mov	r2, #2064
	mov	r1, #1
	mov	r0, r7
	bl	VDH_Record_RegData
	ldrb	r2, [r5]
	ldr	r1, [r4, #28]
	cmp	r2, #1
	beq	.L894
.L926:
	mov	r3, r1
	movw	r2, #2068
	mov	r1, #1
	mov	r0, r7
	bl	VDH_Record_RegData
	ldrb	r2, [r5]
	ldr	r1, [r4, #32]
	cmp	r2, #1
	beq	.L896
.L927:
	mov	r3, r1
	movw	r2, #2072
	mov	r1, #1
	mov	r0, r7
	bl	VDH_Record_RegData
	b	.L897
.L935:
	mov	r3, #0
	movw	r2, #2076
	mov	r1, #1
	mov	r0, r7
	bl	VDH_Record_RegData
	ldrb	r9, [r5]
	ldr	r10, .L940
	cmp	r9, #1
	bne	.L936
.L914:
	mov	r0, r6
	bl	PrintScdVtrlReg
	ldrb	r3, [r10]
	cmp	r3, #1
	bne	.L937
	ldr	r3, .L940+8
	mov	r1, #0
	add	r3, r3, r6, lsl #2
	ldr	r0, [r3, #4]
	add	r0, r0, #2048
	bl	MEM_WritePhyWord
.L917:
	ldrb	r3, [r5]
	ldrb	r1, [r4, #2]
	cmp	r3, #1
	and	r1, r1, #1
	bne	.L938
	ldr	r3, .L940+8
	add	r6, r3, r6, lsl #2
	ldr	r0, [r6, #4]
	add	r0, r0, #2048
	bl	MEM_WritePhyWord
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L934:
	mov	r3, r1
	movw	r2, #2104
	mov	r1, #1
	mov	r0, r7
	bl	VDH_Record_RegData
	b	.L911
.L933:
	mov	r3, r1
	movw	r2, #2100
	mov	r1, #1
	mov	r0, r7
	bl	VDH_Record_RegData
	b	.L909
.L932:
	mov	r3, r1
	mov	r2, #2096
	mov	r1, #1
	mov	r0, r7
	bl	VDH_Record_RegData
	b	.L907
.L931:
	mov	r3, r1
	movw	r2, #2092
	mov	r1, #1
	mov	r0, r7
	bl	VDH_Record_RegData
	b	.L905
.L930:
	mov	r3, r1
	movw	r2, #2088
	mov	r1, #1
	mov	r0, r7
	bl	VDH_Record_RegData
	b	.L903
.L928:
	mov	r3, r1
	mov	r2, #2080
	mov	r1, #1
	mov	r0, r7
	bl	VDH_Record_RegData
	ldr	r3, [r4, #104]
	cmp	r3, #0
	beq	.L900
.L929:
	ldrb	r2, [r5]
	ldr	r1, [r4, #116]
	cmp	r2, #1
	bne	.L939
	ldr	r2, .L940+8
	add	r3, r2, r6, lsl #2
	ldr	r0, [r3, #4]
	bl	MEM_WritePhyWord
	b	.L900
.L884:
	mov	r0, r2
	mov	r7, #0
	bl	ResetSCD
	b	.L885
.L939:
	mov	r3, r1
	mov	r2, #0
	mov	r1, #1
	mov	r0, r7
	bl	VDH_Record_RegData
	b	.L900
.L938:
	mov	r3, r1
	mov	r0, r7
	mov	r2, #2048
	mov	r1, #1
	bl	VDH_Record_RegData
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L937:
	mov	r1, r9
	mov	r3, #0
	mov	r2, #2048
	mov	r0, r7
	bl	VDH_Record_RegData
	b	.L917
.L941:
	.align	2
.L940:
	.word	g_HalDisable
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.fnend
	.size	WriteScdVtrlReg, .-WriteScdVtrlReg
	.align	2
	.global	PrintDownMsg
	.type	PrintDownMsg, %function
PrintDownMsg:
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
	mov	r7, r1
	mov	r6, r2
	ldr	r1, .L947
	mov	r2, r3
	mov	r0, #24
	bl	dprint_vfmw
	mov	r2, r7
	ldr	r1, .L947+4
	mov	r0, #24
	bl	dprint_vfmw
	mov	r2, r4
	ldr	r1, .L947+8
	mov	r0, #24
	bl	dprint_vfmw
	cmp	r6, #0
	ldmlefd	sp, {r4, r5, r6, r7, fp, sp, pc}
	add	r6, r6, r6, lsl #1
	mov	r5, r7
	mov	r4, #0
.L944:
	ldr	r3, [r7, r4, asl #2]
	mov	r2, r4
	ldr	r1, .L947+12
	mov	r0, #24
	bl	dprint_vfmw
	ldr	r3, [r5, #4]
	add	r2, r4, #1
	ldr	r1, .L947+12
	mov	r0, #24
	add	r5, r5, #12
	bl	dprint_vfmw
	ldr	r3, [r5, #-4]
	add	r2, r4, #2
	ldr	r1, .L947+12
	mov	r0, #24
	add	r4, r4, #3
	bl	dprint_vfmw
	ldr	r1, .L947+16
	mov	r0, #24
	bl	dprint_vfmw
	cmp	r4, r6
	bne	.L944
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L948:
	.align	2
.L947:
	.word	.LC76
	.word	.LC77
	.word	.LC78
	.word	.LC79
	.word	.LC18
	.fnend
	.size	PrintDownMsg, .-PrintDownMsg
	.align	2
	.global	WriteScdMsg
	.type	WriteScdMsg, %function
WriteScdMsg:
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
	str	r1, [fp, #-148]
	mov	r7, r2
	mov	r8, r0
	mov	r2, #96
	sub	r0, fp, #140
	mov	r1, #0
	mov	r6, r3
	bl	memset
	cmp	r7, #0
	beq	.L960
	add	r3, r7, #98304
	ldmia	r3, {r1, r2}
	cmp	r1, r2
	beq	.L961
	ldr	r10, [r3, #12]
	mov	r5, r10, asr #31
	mov	r4, r10
	mov	r9, r10
.L950:
	sub	r1, fp, #140
	mov	r0, r7
	bl	ShowFirstRawPacket
	ldrd	r0, [fp, #-100]
	ldr	r3, [fp, #-132]
	adds	r4, r4, r0
	ldr	r2, [fp, #-136]
	adc	r5, r5, r1
	ldr	r1, [fp, #-148]
	rsb	r3, r10, r3
	add	r2, r2, r9
	cmp	r3, r1
	mov	r9, #0
	str	r3, [fp, #-132]
	str	r9, [r6]
	str	r9, [r6, #4]
	str	r9, [r6, #8]
	strd	r4, [fp, #-100]
	str	r2, [fp, #-136]
	str	r9, [r8, #4]
	bgt	.L951
	mov	r5, r3
	mov	r10, r9
	mov	lr, r3
	str	r1, [fp, #-144]
	b	.L954
.L971:
	ldr	lr, [fp, #-132]
	movw	r2, #1023
	ldr	r3, [fp, #-144]
	add	r5, r5, lr
	cmp	r3, r5
	movlt	r3, #0
	movge	r3, #1
	cmp	r10, r2
	movgt	r3, #0
	cmp	r3, #0
	beq	.L953
.L954:
	cmp	lr, #0
	mov	r3, r9, asl #2
	add	ip, r6, r3
	sub	r1, fp, #140
	mov	r0, r7
	add	r3, r3, #12
	ble	.L952
	ldr	r2, [fp, #4]
	ldr	r4, [fp, #-136]
	add	r3, r3, r2
	mov	r2, #0
	str	r2, [fp, #-132]
	ldr	r2, [fp, #-136]
	str	r4, [r6, r9, asl #2]
	add	r9, r9, #3
	sub	r2, r2, #1
	str	r3, [ip, #8]
	add	lr, r2, lr
	str	lr, [ip, #4]
.L952:
	str	r5, [r8, #4]
	add	r10, r10, #1
	bl	ShowNextRawPacket
	cmp	r0, #0
	beq	.L971
.L953:
	ldr	r3, [fp, #8]
	cmp	r3, #0
	bne	.L955
	ldr	r3, [fp, #-132]
	cmp	r3, #0
	bne	.L959
.L955:
	cmp	r10, #0
	beq	.L958
	sub	r9, r9, #-1073741823
	ldr	r0, [fp, #4]
	mov	r4, #0
	mov	ip, #1
	str	r4, [r6, r9, asl #2]
	mov	r2, r10
	mov	r1, r6
	str	r10, [r8]
	ldr	r3, [fp, #12]
	str	ip, [r8, #8]
	bl	PrintDownMsg
	mov	r0, r4
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L951:
	ldr	r2, [fp, #8]
	cmp	r2, #0
	bne	.L958
	cmp	r3, #0
	beq	.L958
	ldr	r9, [fp, #8]
	mov	r5, r3
	mov	r10, r9
.L959:
	ldr	r1, [fp, #-148]
	ldr	r2, [r8, #4]
	sub	r1, r1, #16
	cmp	r2, r1
	bge	.L955
	ldr	r1, [fp, #-148]
	cmp	r1, r5
	cmplt	r10, #1024
	bge	.L955
	rsb	r2, r2, r1
	cmp	r3, r2
	blt	.L955
	mov	r3, r9, asl #2
	ldr	ip, [fp, #-136]
	add	r0, r6, r3
	ldr	lr, [fp, #4]
	add	r3, r3, #12
	sub	r1, ip, #1
	str	ip, [r6, r9, asl #2]
	add	r1, r1, r2
	add	r3, r3, lr
	stmib	r0, {r1, r3}
	ldr	r3, [r8, #4]
	mov	r1, #0
	add	r10, r10, #1
	add	r9, r9, #3
	add	r2, r3, r2
	str	r1, [fp, #-132]
	str	r2, [r8, #4]
	b	.L955
.L961:
	mov	r9, #0
	mov	r4, #0
	mov	r5, #0
	mov	r10, r9
	b	.L950
.L960:
	mov	r4, #0
	mov	r5, #0
	mov	r9, r7
	mov	r10, r7
	b	.L950
.L958:
	mvn	r0, #5
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	.fnend
	.size	WriteScdMsg, .-WriteScdMsg
	.align	2
	.global	ScdDriver
	.type	ScdDriver, %function
ScdDriver:
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
	add	r5, r1, #188416
	ldr	lr, [r0, #104]
	ldr	r4, [fp, #4]
	mov	r6, r0
	ldr	r8, [r5, #2256]
	add	r0, r1, #190464
	ldr	r7, [r5, #2264]
	mov	r1, r2
	add	r0, r0, #192
	mov	r2, r3
	str	r4, [sp, #8]
	mov	r3, r8
	stmia	sp, {r7, lr}
	bl	WriteScdMsg
	subs	r7, r0, #0
	bne	.L973
	ldr	r3, .L974
	ldr	r3, [r3]
	blx	r3
	ldr	r3, .L974+4
	mov	ip, #84
	mov	r2, r4
	mov	r1, r6
	mla	r4, ip, r4, r3
	str	r0, [r4, #68]
	ldr	r0, [r5, #2352]
	bl	WriteScdVtrlReg
.L973:
	mov	r0, r7
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L975:
	.align	2
.L974:
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_VfmwGlobalStat
	.fnend
	.size	ScdDriver, .-ScdDriver
	.align	2
	.global	CutStreamWithSCD
	.type	CutStreamWithSCD, %function
CutStreamWithSCD:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #164
	sub	sp, sp, #164
	push	{lr}
	bl	__gnu_mcount_nc
	add	r5, r0, #98304
	ldr	r3, [r0, #80]
	cmn	r5, #136
	str	r1, [fp, #-176]
	mov	r4, r0
	mov	r1, #0
	movne	r6, #0
	moveq	r6, #1
	cmn	r0, #112
	str	r3, [fp, #-184]
	add	r9, r5, #136
	add	r3, r0, #112
	movne	r10, #0
	moveq	r10, #1
	orrs	r2, r10, r6
	ldr	r8, [r0, #56]
	str	r3, [fp, #-180]
	str	r1, [fp, #-168]
	bne	.L979
	ldr	r7, .L1002
	add	r0, r0, #190464
	str	r2, [fp, #-172]
	mov	r1, r2
	add	r0, r0, #192
	mov	r2, #12
	ldr	ip, [r7, #48]
	blx	ip
	cmp	r10, #0
	bne	.L979
	ldr	r2, [r5, #116]
	mov	r0, #26
	ldr	r3, [r5, #112]
	ldr	r1, .L1002+4
	subs	r10, r2, r3
	addmi	r10, r10, #1024
	mov	r2, r10
	bl	dprint_vfmw
	ldr	r1, [r5, #132]
	ldr	r2, [r5, #124]
	rsb	r5, r2, r1
	movs	ip, r5, asr #31
	beq	.L999
.L996:
	mov	r0, ip
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L979:
	mvn	ip, #0
	mov	r0, ip
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L999:
	mov	r2, r5
	ldr	r1, .L1002+8
	mov	r0, #26
	str	ip, [fp, #-188]
	bl	dprint_vfmw
	cmp	r5, #3
	cmpgt	r10, #0
	ble	.L993
	cmp	r6, #0
	bne	.L979
	add	r6, r4, #188416
	ldr	ip, [fp, #-188]
	ldr	r1, .L1002+12
	mov	r0, #26
	ldr	r2, [r6, #2192]
	ldr	r3, [r6, #2196]
	str	ip, [fp, #-188]
	subs	r3, r3, r2
	addmi	r3, r3, #1152
	rsb	r10, r3, #1152
	mov	r2, r10
	bl	dprint_vfmw
	cmp	r10, #288
	ldr	ip, [fp, #-188]
	ble	.L990
	mov	r0, r9
	sub	r2, fp, #172
	sub	r1, fp, #168
	str	ip, [fp, #-188]
	bl	GetFreeSegBuf
	ldr	r2, [fp, #-172]
	ldr	lr, [fp, #-168]
	mov	r0, #26
	sub	r2, r2, #79
	ldr	r1, .L1002+16
	add	lr, lr, #3
	str	r2, [fp, #-172]
	bic	lr, lr, #3
	str	lr, [fp, #-168]
	bl	dprint_vfmw
	ldr	r9, [r6, #2212]
	ldr	r2, [fp, #-172]
	ldr	ip, [fp, #-188]
	cmp	r2, r9, asr #3
	ble	.L990
	ldr	r2, [r6, #2208]
	ldr	r1, [fp, #-176]
	ldr	r0, [r6, #2352]
	str	ip, [fp, #-192]
	str	r2, [fp, #-188]
	bl	SM_CfgBuf
	ldr	r2, [fp, #-188]
	ldr	ip, [fp, #-192]
	cmp	r0, #0
	bne	.L1000
	add	r3, r4, #200704
	mov	r1, #1
	str	r10, [r6, #2280]
	add	r9, r9, r2
	str	r1, [r6, #2360]
	cmp	r8, r1
	cmpne	r8, #15
	ldr	lr, [r3, #3956]
	str	r3, [fp, #-188]
	str	r9, [fp, #-136]
	mul	r3, lr, r10
	ldr	r9, [r6, #2256]
	ldr	lr, [r6, #2264]
	str	r2, [fp, #-140]
	sub	r2, r8, #6
	str	r9, [fp, #-156]
	clz	r2, r2
	ldr	r9, [r6, #2284]
	str	r3, [fp, #-144]
	mov	r3, r3, asl #2
	str	lr, [fp, #-160]
	mov	r2, r2, lsr #5
	ldr	lr, [r6, #2272]
	str	r3, [r6, #2276]
	ldr	r3, [fp, #-168]
	ldr	r10, [fp, #-184]
	str	lr, [fp, #-148]
	str	r3, [fp, #-132]
	ldr	lr, [r6, #2296]
	ldr	r3, [r6, #2308]
	str	r9, [fp, #-120]
	ldr	r9, [r6, #2320]
	ldr	r6, [r6, #2332]
	str	r10, [fp, #-60]
	strb	r1, [fp, #-162]
	strb	r1, [fp, #-164]
	str	lr, [fp, #-108]
	str	r3, [fp, #-96]
	str	r9, [fp, #-84]
	str	r6, [fp, #-72]
	str	r2, [fp, #-48]
	beq	.L994
	cmp	r2, #0
	strneb	r1, [fp, #-163]
	movne	lr, r8
	beq	.L1001
.L987:
	ldr	r1, [fp, #-176]
	sub	r0, fp, #164
	ldr	r2, [fp, #-172]
	ldr	r3, [fp, #-180]
	str	r1, [sp]
	mov	r1, r4
	str	ip, [fp, #-184]
	str	lr, [fp, #-128]
	mov	lr, #1
	str	lr, [fp, #-124]
	str	lr, [fp, #-56]
	str	lr, [fp, #-52]
	bl	ScdDriver
	subs	r6, r0, #0
	movne	ip, r6
	bne	.L996
	ldr	r3, [fp, #-172]
	ldr	r8, [fp, #-188]
	cmp	r3, r5
	str	r5, [r8, #3928]
	movlt	r5, #0
	str	r3, [r8, #3932]
	movge	r5, #1
	strb	r6, [r4, #4]
	strb	r5, [r4, #2]
	ldr	r3, [r7]
	blx	r3
	ldr	ip, [fp, #-184]
	str	r0, [r8, #3952]
	strb	r6, [r4, #3]
	b	.L996
.L990:
	mvn	ip, #5
	b	.L996
.L994:
	mov	lr, r0
.L984:
	mov	r3, #0
	strb	r3, [fp, #-163]
	b	.L987
.L1000:
	mov	r2, r0
	ldr	r1, .L1002+20
	mov	r0, #26
	str	r2, [fp, #-176]
	bl	dprint_vfmw
	ldr	ip, [fp, #-176]
	b	.L996
.L1001:
	sub	r3, r8, #2
	mov	lr, r8
	cmp	r3, r1
	strlsb	r1, [fp, #-163]
	bls	.L987
	b	.L984
.L993:
	mvn	ip, #4
	b	.L996
.L1003:
	.align	2
.L1002:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC84
	.word	.LC80
	.word	.LC83
	.word	.LC81
	.word	.LC82
	.fnend
	.size	CutStreamWithSCD, .-CutStreamWithSCD
	.align	2
	.global	PrintScdStateReg
	.type	PrintScdStateReg, %function
PrintScdStateReg:
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
	mov	r2, r1
	mov	r0, #24
	ldr	r1, .L1005
	bl	dprint_vfmw
	ldr	r2, [r4]
	ldr	r1, .L1005+4
	mov	r0, #24
	bl	dprint_vfmw
	ldr	r2, [r4, #4]
	ldr	r1, .L1005+8
	mov	r0, #24
	bl	dprint_vfmw
	ldr	r2, [r4, #8]
	ldr	r1, .L1005+12
	mov	r0, #24
	bl	dprint_vfmw
	ldr	r2, [r4, #12]
	ldr	r1, .L1005+16
	mov	r0, #24
	bl	dprint_vfmw
	ldr	r2, [r4, #16]
	ldr	r1, .L1005+20
	mov	r0, #24
	bl	dprint_vfmw
	ldr	r2, [r4, #20]
	ldr	r1, .L1005+24
	mov	r0, #24
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1006:
	.align	2
.L1005:
	.word	.LC85
	.word	.LC86
	.word	.LC87
	.word	.LC88
	.word	.LC89
	.word	.LC90
	.word	.LC91
	.fnend
	.size	PrintScdStateReg, .-PrintScdStateReg
	.align	2
	.global	ReadScdStateReg
	.type	ReadScdStateReg, %function
ReadScdStateReg:
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
	ldr	r4, .L1008
	mov	r5, r0
	mov	r6, r1
	add	r4, r4, r1, lsl #2
	movw	r7, #2124
	ldr	r0, [r4, #4]
	add	r0, r0, #2112
	bl	MEM_ReadPhyWord
	and	r0, r0, #1
	str	r0, [r5]
	ldr	r0, [r4, #4]
	add	r0, r0, #2112
	add	r0, r0, #4
	bl	MEM_ReadPhyWord
	ldr	r2, [r4, #4]
	and	r3, r0, #1
	add	r0, r7, r2
	str	r3, [r5, #4]
	bl	MEM_ReadPhyWord
	ldr	r2, [r4, #4]
	mov	r3, r0, lsr #22
	add	r0, r7, r2
	str	r3, [r5, #8]
	bl	MEM_ReadPhyWord
	ldr	r2, [r4, #4]
	ubfx	r3, r0, #0, #22
	add	r0, r2, #2128
	str	r3, [r5, #12]
	bl	MEM_ReadPhyWord
	ldr	r3, [r4, #4]
	str	r0, [r5, #16]
	add	r0, r3, #2128
	add	r0, r0, #4
	bl	MEM_ReadPhyWord
	mov	r1, r6
	str	r0, [r5, #20]
	mov	r0, r5
	bl	PrintScdStateReg
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1009:
	.align	2
.L1008:
	.word	.LANCHOR0
	.fnend
	.size	ReadScdStateReg, .-ReadScdStateReg
	.align	2
	.global	GetNextVop
	.type	GetNextVop, %function
GetNextVop:
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
	ldr	r5, [fp, #4]
	mov	r8, r0
	ldr	r0, .L1031
	mov	r9, r2
	mov	r6, r3
	mov	r4, r1
	add	r0, r0, r5, lsl #2
	ldr	r0, [r0, #4]
	add	r0, r0, #2080
	bl	MEM_ReadPhyWord
	mov	r1, r5
	sub	r0, fp, #68
	bl	ReadScdStateReg
	ldr	r3, [fp, #-52]
	cmp	r3, #0
	mvneq	r5, #6
	movne	r5, #0
	cmp	r9, #0
	beq	.L1012
	add	r2, r9, #90112
	ldr	r3, [r2, #2060]
	ldr	r2, [r2, #2056]
	subs	r3, r3, r2
	addmi	r3, r3, #1152
	rsb	r3, r3, #1152
	str	r3, [fp, #-72]
.L1023:
	cmp	r5, #0
	bne	.L1027
	subs	r1, r6, #1
	bmi	.L1025
	add	r2, r8, #200704
	add	r3, r9, #90112
	mov	r6, #0
	ldr	r0, [r8, #20]
	ldr	r7, [r2, #3956]
	mov	r10, r6
	ldr	r8, [r3, #2072]
	movt	r6, 65025
	movt	r10, 46593
	ldr	r9, [r9]
	mov	r7, r7, asl #2
	mla	r4, r7, r1, r4
	b	.L1022
.L1030:
	cmp	r0, #2
	beq	.L1029
	cmp	r2, r6
	beq	.L1019
.L1021:
	sub	r3, r1, #1
	rsb	r4, r7, r4
	cmn	r3, #1
	beq	.L1028
	mov	r1, r3
.L1022:
	ldr	r3, [r4]
	cmp	r0, #1
	rsb	r3, r8, r3
	add	r2, r9, r3
	ldrb	r3, [r9, r3]
	ldrb	lr, [r2, #1]
	ldrb	ip, [r2, #2]
	ldrb	r2, [r2, #3]
	add	r3, r3, lr, lsl #8
	add	ip, r3, ip, lsl #16
	add	r2, ip, r2, lsl #24
	rsbeq	r3, r10, r2
	clzeq	r3, r3
	moveq	r3, r3, lsr #5
	bne	.L1030
.L1017:
	cmp	r2, r6
	beq	.L1019
	cmp	r3, #1
	bne	.L1021
.L1019:
	add	r5, r5, #1
	cmp	r5, #0
	ble	.L1021
	ldr	r3, [fp, #-72]
	cmp	r1, r3
	bhi	.L1021
.L1028:
	mov	r5, r1
.L1027:
	mov	r0, r5
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1029:
	ubfx	r3, r2, #16, #8
	sub	r3, r3, #128
	cmp	r3, #3
	movhi	r3, #0
	movls	r3, #1
	b	.L1017
.L1012:
	movw	r3, #3762
	ldr	r2, .L1031+4
	ldr	r1, .L1031+8
	mov	r0, #22
	bl	dprint_vfmw
	mov	r3, #1152
	str	r3, [fp, #-72]
	b	.L1023
.L1025:
	mov	r5, r6
	b	.L1027
.L1032:
	.align	2
.L1031:
	.word	.LANCHOR0
	.word	.LANCHOR3+412
	.word	.LC92
	.fnend
	.size	GetNextVop, .-GetNextVop
	.global	__aeabi_uidiv
	.align	2
	.global	ProcessScdReturn
	.type	ProcessScdReturn, %function
ProcessScdReturn:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #276
	sub	sp, sp, #276
	push	{lr}
	bl	__gnu_mcount_nc
	add	r3, r0, #188416
	str	r3, [fp, #-260]
	mov	r8, #0
	mov	r10, r0
	ldr	r3, [r3, #2248]
	mov	r5, r1
	str	r8, [fp, #-240]
	cmp	r3, #3
	str	r8, [fp, #-236]
	beq	.L1134
	ldr	r4, .L1147
	mov	r6, r1, asl #2
	add	r7, r10, #200704
	add	r3, r4, r6
	ldr	r0, [r3, #4]
	add	r0, r0, #2080
	bl	MEM_ReadPhyWord
	ldr	ip, [fp, #-260]
	ldr	r3, .L1147+4
	mov	r1, #2
	mov	r2, #80
	sub	r0, fp, #204
	str	r1, [ip, #2248]
	mov	r1, r8
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r3, .L1147+4
	mov	r2, #80
	mov	r1, r8
	sub	r0, fp, #124
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r3, .L1147+4
	mov	r1, r8
	mov	r2, #24
	sub	r0, fp, #228
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r3, [r7, #3956]
	sub	r0, fp, #228
	mov	r1, r5
	str	r3, [fp, #-272]
	bl	ReadScdStateReg
	ldr	r3, [fp, #-212]
	cmp	r3, #0
	beq	.L1130
	ldr	r3, [fp, #-216]
	add	r1, r10, #112
	str	r1, [fp, #-280]
	mov	r2, r3
	str	r3, [fp, #-296]
	movw	r3, #34464
	str	r2, [fp, #-244]
	movt	r3, 1
	cmp	r2, r3
	bls	.L1037
	ldr	r0, [r10, #56]
	cmp	r0, #0
	beq	.L1135
.L1037:
	add	r3, r10, #98304
	str	r3, [fp, #-268]
	adds	r3, r3, #136
	str	r3, [fp, #-264]
	add	r8, r4, r6
	ldrne	r3, [fp, #-260]
	ldreq	r3, [fp, #-264]
	ldr	r0, [r8, #4]
	ldrne	r2, [r3, #2208]
	ldrne	r3, [r3, #2212]
	add	r0, r0, #2080
	streq	r3, [fp, #-248]
	strne	r2, [fp, #-252]
	strne	r3, [fp, #-248]
	streq	r3, [fp, #-252]
	bl	MEM_ReadPhyWord
	ldr	r3, [fp, #-244]
	ldr	r2, [r8, #4]
	cmp	r3, #1152
	movlt	r9, r3
	movge	r9, #1152
	and	r3, r0, #15
	add	r0, r2, #2048
	str	r3, [r10, #16]
	add	r0, r0, #12
	bl	MEM_ReadPhyWord
	ldr	r1, [fp, #-272]
	bl	__aeabi_uidiv
	cmp	r9, r0
	bhi	.L1136
	ldr	r3, [fp, #-244]
	cmp	r3, #1152
	movlt	r0, r3
	movge	r0, #1152
.L1040:
	cmp	r0, r3
	str	r0, [r10, #40]
	bge	.L1041
	ldrsb	r3, [r10, #2]
	cmp	r3, #1
	moveq	r3, #0
	streqb	r3, [r10, #2]
.L1041:
	ldr	ip, [fp, #-260]
	add	r2, r10, #190464
	ldr	lr, [fp, #-252]
	mov	r1, r2
	add	r2, r1, #324
	ldr	r3, [ip, #2268]
	add	r1, r10, #8
	str	lr, [r10, #28]
	str	r2, [fp, #-256]
	mov	r8, r1
	str	r3, [r10, #12]
	str	r1, [fp, #-288]
	mov	r1, r2
	ldr	r3, [ip, #2208]
	ldr	r2, [fp, #-268]
	ldr	r0, [fp, #-212]
	rsb	r3, r3, lr
	ldr	lr, [fp, #-248]
	ldr	r2, [r2, #136]
	str	r0, [r10, #36]
	mov	r0, r8
	str	lr, [r10, #32]
	add	r3, r2, r3
	ldr	r2, [fp, #-272]
	str	r3, [r10, #8]
	sub	r3, fp, #244
	ldr	ip, [ip, #2352]
	str	r2, [sp]
	sub	r2, fp, #232
	str	ip, [r10, #44]
	bl	ScdReturnSegFilter
	subs	r9, r0, #0
	bne	.L1130
	ldr	r8, [fp, #-244]
	cmp	r8, #1
	ble	.L1137
	add	r4, r4, r6
	strb	r9, [r10]
	ldr	r0, [r4, #4]
	add	r0, r0, #2048
	add	r0, r0, #12
	bl	MEM_ReadPhyWord
	ldr	r6, [fp, #-272]
	mov	r1, r6
	bl	__aeabi_uidiv
	cmp	r8, r0
	bcs	.L1048
	ldr	r3, [fp, #-244]
	ldr	r2, [fp, #-256]
	sub	r3, r3, #1
	str	r3, [fp, #-292]
	str	r3, [fp, #-244]
	mul	r3, r6, r3
	add	r3, r3, #1
	ldr	r3, [r2, r3, asl #2]
	bic	r3, r3, #-2147483648
	str	r3, [fp, #-276]
.L1049:
	ldr	r3, [r10, #56]
	cmp	r3, #2
	beq	.L1138
.L1052:
	ldr	r3, [fp, #-260]
	mov	r8, #0
	mov	r7, r8
	str	r8, [fp, #-284]
	ldr	r5, [fp, #-256]
	ldr	r3, [r3, #2196]
	ldr	r1, [fp, #-292]
	str	r10, [fp, #-248]
	str	r3, [fp, #-300]
	ldr	r3, [fp, #-272]
	mov	r9, r3, asl #2
	b	.L1053
.L1142:
	ldr	r3, [fp, #-116]
	cmp	r3, #0
	bne	.L1139
	ldr	r3, [fp, #-248]
	ldr	r3, [r3, #56]
	cmp	r3, #2
	beq	.L1140
.L1062:
	ldr	r3, [fp, #-260]
	sub	r2, fp, #240
	str	r6, [fp, #-196]
	sub	r1, fp, #236
	ldr	r0, [fp, #-264]
	ldr	r3, [r3, #2208]
	str	r4, [fp, #-192]
	rsb	r6, r3, r6
	ldr	r3, [fp, #-268]
	ldr	r3, [r3, #136]
	add	r6, r3, r6
	mov	r3, #1
	str	r6, [fp, #-204]
	strb	r3, [fp, #-199]
	bl	GetFreeSegBuf
	ldr	r3, [fp, #-196]
	ldr	r2, [fp, #-240]
	cmp	r3, #0
	beq	.L1063
	ldr	r3, [fp, #-204]
	cmp	r3, #0
	beq	.L1063
	ldr	r3, [fp, #-192]
	cmp	r2, r3
	blt	.L1063
	ldr	r3, [fp, #-248]
	ldr	r1, [r5, #4]
	add	r2, r3, #203776
	ldr	r0, [fp, #-280]
	add	r2, r2, #848
	sub	r3, fp, #204
	bic	r1, r1, #-2147483648
	bl	GetSegPts
	ldr	r3, [fp, #-260]
	sub	r1, fp, #204
	ldr	r0, [fp, #-264]
	ldr	r2, [r3, #2352]
	bl	InsertStreamSeg
	cmp	r0, #0
	bne	.L1129
	ldrd	r6, [fp, #-180]
	mov	r0, #26
	ldr	r2, [r5, #4]
	ldr	r1, .L1147+8
	bic	r2, r2, #-2147483648
	strd	r6, [sp]
	bl	dprint_vfmw
	ldr	r3, [fp, #-192]
	ldr	r2, [fp, #-196]
	mov	r0, #26
.L1126:
	ldrb	ip, [fp, #-199]
	ldr	r1, .L1147+12
	str	ip, [sp]
	bl	dprint_vfmw
.L1127:
	ldr	r1, [fp, #-244]
.L1061:
	add	r5, r5, r9
	add	r8, r8, r9
	mov	r7, r10
.L1053:
	cmp	r7, r1
	bge	.L1141
	ldr	r3, [fp, #-256]
	add	r10, r7, #1
	ldr	r6, [r5]
	add	r2, r3, r9
	ldr	r3, [r5, #4]
	ldr	ip, [r2, r8]
	mov	r3, r3, lsr #31
	strb	r3, [fp, #-197]
	ldr	r3, [fp, #-252]
	cmp	ip, r3
	rsbne	r4, r6, ip
	ldreq	r4, [fp, #-212]
	rsbeq	r4, r6, r4
	cmp	r4, #3
	bgt	.L1142
	sub	r3, r4, #1
	cmp	r3, #2
	bhi	.L1065
	ldr	r3, [fp, #-248]
	ldr	r3, [r3, #56]
	cmp	r3, #2
	bne	.L1061
	mov	r0, ip
	bl	MEM_Phy2Vir
	cmp	r0, #0
	beq	.L1130
	ldrb	r2, [r0, #1]
	ldrb	r3, [r0]
	ldrb	r1, [r0, #2]
	mov	r2, r2, asl #16
	orr	r3, r2, r3, asl #24
	orr	r3, r3, r1, asl #8
	cmp	r3, #256
	beq	.L1127
	mov	r2, r7
	ldr	r3, [fp, #-272]
	sub	r1, fp, #124
	ldr	r0, [fp, #-288]
	bl	ScdParseUpMsgInfo
	ldr	r3, [fp, #-260]
	ldr	r2, [fp, #-268]
	sub	r1, fp, #236
	ldr	r0, [fp, #-264]
	ldr	r3, [r3, #2208]
	ldr	ip, [r2, #136]
	sub	r2, fp, #240
	rsb	r3, r3, r6
	str	r6, [fp, #-116]
	add	r3, ip, r3
	str	r4, [fp, #-112]
	mov	ip, #1
	str	r3, [fp, #-124]
	strb	ip, [fp, #-119]
	bl	GetFreeSegBuf
	ldr	r3, [fp, #-248]
	ldr	r1, [r5, #4]
	add	r2, r3, #203776
	ldr	r0, [fp, #-280]
	bic	r1, r1, #-2147483648
	add	r2, r2, #848
	sub	r3, fp, #124
	bl	GetSegPts
	ldr	r1, [fp, #-244]
	b	.L1061
.L1135:
	ldr	r1, .L1147+16
	movw	r2, #3913
	ldr	r3, [fp, #-296]
	bl	dprint_vfmw
	ldr	r0, [fp, #-280]
	mov	r1, #1
	bl	DeleteRawPacket
.L1130:
	mvn	r0, #6
.L1120:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1063:
	ldr	r1, .L1147+20
	mov	r0, #0
	ldr	r10, [fp, #-248]
	bl	dprint_vfmw
	ldr	r3, [fp, #-276]
	mov	r0, #0
	ldr	r2, [fp, #-240]
	mov	r4, #1
	ldr	r1, .L1147+24
	bl	dprint_vfmw
	ldrb	ip, [fp, #-199]
	ldr	r3, [fp, #-192]
	mov	r0, #0
	ldr	r2, [fp, #-196]
	ldr	r1, .L1147+12
	str	ip, [sp]
	bl	dprint_vfmw
.L1060:
	ldr	r3, [fp, #-260]
	ldr	r2, [fp, #-300]
	ldr	r3, [r3, #2196]
	cmp	r3, r2
	movne	r3, #1
	moveq	r3, #0
	cmp	r7, #0
	strb	r3, [r10, #3]
	ble	.L1079
	ldr	r3, [fp, #-272]
	ldr	r0, [fp, #-280]
	mul	r7, r3, r7
	ldr	r3, [fp, #-256]
	add	r7, r7, #1
	ldr	r1, [r3, r7, asl #2]
	bic	r1, r1, #-2147483648
	bl	DeleteRawLen
	cmp	r0, #0
	bne	.L1130
.L1080:
	cmp	r4, #1
	beq	.L1130
.L1082:
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1065:
	cmp	r4, #0
	bge	.L1061
	ldr	r3, [fp, #-248]
	ldr	r3, [r3, #56]
	cmp	r3, #2
	beq	.L1143
.L1067:
	ldr	r3, [fp, #-252]
	sub	r2, fp, #240
	ldr	r1, [fp, #-268]
	rsb	r4, r3, ip
	ldr	r3, [fp, #-260]
	ldr	r0, [fp, #-212]
	ldr	r1, [r1, #136]
	ldr	r3, [r3, #2208]
	add	r0, r4, r0
	str	r6, [fp, #-196]
	rsb	r3, r3, r6
	rsb	r6, r6, r0
	add	r3, r1, r3
	ldr	r0, [fp, #-264]
	sub	r1, fp, #236
	str	r3, [fp, #-204]
	str	r6, [fp, #-192]
	mov	r3, #0
	strb	r3, [fp, #-199]
	bl	GetFreeSegBuf
	ldr	r3, [fp, #-192]
	cmp	r3, #3
	ble	.L1127
	ldr	r3, [fp, #-264]
	cmp	r3, #0
	beq	.L1069
	ldr	r3, [fp, #-260]
	ldr	r2, [r3, #2196]
	ldr	r3, [r3, #2192]
	subs	r3, r2, r3
	str	r3, [fp, #-284]
	addmi	r3, r3, #1152
	strmi	r3, [fp, #-284]
.L1088:
	ldr	r0, [fp, #-196]
	ldr	r3, [fp, #-284]
	cmp	r0, #0
	rsb	r3, r3, #1152
	str	r3, [fp, #-284]
	ldr	r3, [fp, #-240]
	beq	.L1071
	ldr	r2, [fp, #-204]
	cmp	r2, #0
	beq	.L1071
	ldr	r2, [fp, #-192]
	cmp	r3, r2
	blt	.L1071
	ldr	r3, [fp, #-284]
	cmp	r3, #1
	ble	.L1125
	ldr	r3, [fp, #-248]
	ldr	r1, [r5, #4]
	ldr	ip, [fp, #-212]
	add	r2, r3, #203776
	add	r2, r2, #848
	bic	r1, r1, #-2147483648
	rsb	ip, r0, ip
	sub	r3, fp, #204
	ldr	r0, [fp, #-280]
	str	ip, [fp, #-192]
	bl	GetSegPts
	ldr	r3, [fp, #-260]
	sub	r1, fp, #204
	ldr	r0, [fp, #-264]
	ldr	r2, [r3, #2352]
	bl	InsertStreamSeg
	subs	r6, r0, #0
	bne	.L1129
	ldrd	r2, [fp, #-180]
	mov	r0, #26
	ldr	ip, [r5, #4]
	ldr	r1, .L1147+8
	strd	r2, [sp]
	bic	r2, ip, #-2147483648
	bl	dprint_vfmw
	ldrb	ip, [fp, #-199]
	ldr	r3, [fp, #-192]
	mov	r0, #26
	ldr	r2, [fp, #-196]
	ldr	r1, .L1147+12
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r2, [fp, #-260]
	ldr	r1, [fp, #-268]
	ldr	lr, [fp, #-252]
	ldr	r3, [r2, #2208]
	ldr	ip, [r1, #136]
	sub	r1, fp, #204
	rsb	r3, r3, lr
	ldr	r2, [r2, #2352]
	ldr	r0, [fp, #-264]
	add	r3, ip, r3
	str	lr, [fp, #-196]
	mov	ip, #1
	str	r4, [fp, #-192]
	str	r3, [fp, #-204]
	strb	ip, [fp, #-199]
	bl	InsertStreamSeg
	cmp	r0, #0
	bne	.L1144
	ldr	r3, [fp, #-192]
	mov	r0, #26
	ldr	r2, [fp, #-196]
	b	.L1126
.L1139:
	ldr	r3, [fp, #-112]
	sub	r2, fp, #240
	sub	r1, fp, #236
	ldr	r0, [fp, #-264]
	add	r4, r3, r4
	str	r4, [fp, #-112]
	bl	GetFreeSegBuf
	ldr	r3, [fp, #-116]
	ldr	r2, [fp, #-240]
	cmp	r3, #0
	beq	.L1058
	ldr	r3, [fp, #-124]
	cmp	r3, #0
	beq	.L1058
	ldr	r3, [fp, #-112]
	cmp	r2, r3
	blt	.L1058
	ldr	r3, [fp, #-260]
	sub	r1, fp, #124
	ldr	r0, [fp, #-264]
	ldr	r2, [r3, #2352]
	bl	InsertStreamSeg
	ldr	r3, .L1147+4
	mov	r2, #80
	mov	r1, #0
	ldr	r3, [r3, #48]
	mov	r4, r0
	sub	r0, fp, #124
	blx	r3
	cmp	r4, #0
	bne	.L1145
	ldrd	r6, [fp, #-100]
	mov	r0, #26
	ldr	r2, [r5, #4]
	ldr	r1, .L1147+28
	bic	r2, r2, #-2147483648
	strd	r6, [sp]
	bl	dprint_vfmw
	ldrb	ip, [fp, #-119]
	ldr	r1, .L1147+12
	mov	r0, #26
	ldr	r3, [fp, #-112]
	ldr	r2, [fp, #-116]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r1, [fp, #-244]
	b	.L1061
.L1058:
	movw	r2, #4084
	ldr	r1, .L1147+32
	mov	r0, #1
	ldr	r10, [fp, #-248]
	mov	r4, r0
	bl	dprint_vfmw
	ldr	r2, [fp, #-276]
	mov	r0, r4
	ldr	r3, [fp, #-240]
	ldr	r1, .L1147+36
	str	r2, [sp]
	movw	r2, #4085
	bl	dprint_vfmw
	ldr	r3, [fp, #-116]
	ldrb	ip, [fp, #-119]
	movw	r2, #4086
.L1128:
	ldr	r1, [fp, #-112]
	mov	r0, r4
	stmia	sp, {r1, ip}
	ldr	r1, .L1147+40
	bl	dprint_vfmw
	b	.L1060
.L1140:
	ldr	r3, [fp, #-272]
	mov	r2, r7
	sub	r1, fp, #204
	ldr	r0, [fp, #-288]
	bl	ScdParseUpMsgInfo
	b	.L1062
.L1137:
	ldr	r3, [r7, #3932]
	ldr	r2, [r7, #3928]
	cmp	r2, r3
	strleb	r9, [r10]
	movgt	r3, #1
	strgtb	r3, [r10]
	cmp	r8, #0
	bne	.L1046
	ldr	r3, [fp, #-260]
	ldr	r1, [r3, #2244]
	cmp	r1, #3
	subgt	r1, r1, #3
	movle	r1, r8
	b	.L1047
.L1079:
	ldr	r3, [fp, #-292]
	ldr	r2, [fp, #-296]
	clz	r3, r3
	cmp	r2, #1152
	mov	r3, r3, lsr #5
	movls	r3, #0
	cmp	r3, #0
	beq	.L1080
	ldr	r3, [r10, #56]
	cmp	r3, #2
	bne	.L1080
	ldr	r1, .L1147+44
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r0, [fp, #-280]
	mov	r1, #1
	bl	DeleteRawPacket
	b	.L1080
.L1046:
	cmp	r8, #1
	movne	r1, #0
	beq	.L1146
.L1047:
	ldr	r0, [fp, #-280]
	bl	DeleteRawLen
	cmp	r0, #0
	beq	.L1082
	b	.L1130
.L1071:
	ldr	r3, [fp, #-284]
	ldr	r10, [fp, #-248]
	cmp	r3, #1
	ble	.L1089
	movw	r2, #4240
	ldr	r1, .L1147+32
	mov	r0, #1
	mov	r4, r0
	bl	dprint_vfmw
	ldr	r2, [fp, #-276]
	mov	r0, r4
	ldr	r3, [fp, #-240]
	ldr	r1, .L1147+36
	str	r2, [sp]
	movw	r2, #4241
	bl	dprint_vfmw
	ldr	r3, [fp, #-116]
	ldrb	ip, [fp, #-119]
	movw	r2, #4242
	b	.L1128
.L1136:
	ldr	r0, [r8, #4]
	add	r0, r0, #2048
	add	r0, r0, #12
	bl	MEM_ReadPhyWord
	ldr	r1, [fp, #-272]
	bl	__aeabi_uidiv
	ldr	r3, [fp, #-244]
	b	.L1040
.L1141:
	ldr	r10, [fp, #-248]
	mov	r4, #0
	b	.L1060
.L1048:
	ldr	r0, [r4, #4]
	add	r0, r0, #2048
	add	r0, r0, #12
	bl	MEM_ReadPhyWord
	ldr	r4, [fp, #-272]
	mov	r1, r4
	rsb	r0, r4, r0
	bl	__aeabi_uidiv
	subs	r3, r0, #1
	str	r3, [fp, #-292]
	strmi	r9, [fp, #-244]
	mov	r2, r3
	movpl	r3, r4
	mulpl	r3, r3, r2
	strpl	r2, [fp, #-244]
	ldr	r2, [r10, #12]
	movmi	r3, #4
	strmi	r9, [fp, #-292]
	addpl	r3, r3, #1
	movpl	r3, r3, asl #2
	ldr	r3, [r2, r3]
	bic	r3, r3, #-2147483648
	str	r3, [fp, #-276]
	b	.L1049
.L1143:
	ldr	r3, [fp, #-272]
	mov	r2, r7
	sub	r1, fp, #204
	ldr	r0, [fp, #-288]
	str	ip, [fp, #-304]
	bl	ScdParseUpMsgInfo
	ldr	ip, [fp, #-304]
	b	.L1067
.L1069:
	movw	r3, #4191
	ldr	r2, .L1147+48
	ldr	r1, .L1147+52
	mov	r0, #22
	bl	dprint_vfmw
	b	.L1088
.L1138:
	str	r5, [sp]
	mov	r0, r10
	ldr	r3, [fp, #-292]
	ldr	r2, [fp, #-264]
	ldr	r1, [fp, #-256]
	bl	GetNextVop
	str	r0, [fp, #-292]
	str	r0, [fp, #-244]
	b	.L1052
.L1134:
	ldr	r2, [fp, #-260]
	mov	r3, #2
	mvn	r0, #6
	str	r3, [r2, #2248]
	b	.L1120
.L1146:
	ldr	r2, [fp, #-260]
	ldr	r3, [r2, #2212]
	ldr	r1, [r2, #2376]
	ldr	r2, [r2, #2244]
	add	r3, r3, r3, lsl #1
	cmp	r3, #0
	add	r0, r3, #3
	rsb	r2, r1, r2
	movlt	r3, r0
	cmp	r2, r3, asr #2
	ble	.L1047
	ldr	r1, .L1147+56
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r3, [fp, #-260]
	ldr	r1, [r3, #2244]
	b	.L1047
.L1129:
	ldrb	ip, [fp, #-199]
	mov	r0, #26
	ldr	r3, [fp, #-192]
	mov	r4, #0
	ldr	r2, [fp, #-196]
	ldr	r1, .L1147+60
	str	ip, [sp]
	ldr	r10, [fp, #-248]
	bl	dprint_vfmw
	b	.L1060
.L1145:
	ldrb	ip, [fp, #-119]
	mov	r0, #26
	ldr	r3, [fp, #-112]
	mov	r4, #0
	ldr	r2, [fp, #-116]
	ldr	r1, .L1147+60
	str	ip, [sp]
	ldr	r10, [fp, #-248]
	bl	dprint_vfmw
	b	.L1060
.L1144:
	ldrb	ip, [fp, #-199]
	mov	r0, #26
	ldr	r3, [fp, #-192]
	mov	r4, r6
	ldr	r2, [fp, #-196]
	ldr	r1, .L1147+60
	str	ip, [sp]
	ldr	r10, [fp, #-248]
	bl	dprint_vfmw
	b	.L1060
.L1125:
	ldr	r10, [fp, #-248]
.L1089:
	ldrb	ip, [fp, #-199]
	mov	r2, r0
	ldr	r3, [fp, #-192]
	mov	r0, #26
	ldr	r1, .L1147+64
	mov	r4, #0
	str	ip, [sp]
	bl	dprint_vfmw
	b	.L1060
.L1148:
	.align	2
.L1147:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC98
	.word	.LC97
	.word	.LC93
	.word	.LC104
	.word	.LC105
	.word	.LC96
	.word	.LC100
	.word	.LC101
	.word	.LC102
	.word	.LC103
	.word	.LANCHOR3+424
	.word	.LC106
	.word	.LC94
	.word	.LC95
	.word	.LC99
	.fnend
	.size	ProcessScdReturn, .-ProcessScdReturn
	.align	2
	.global	PrintScdInputRawAfterStart
	.type	PrintScdInputRawAfterStart, %function
PrintScdInputRawAfterStart:
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
	.size	PrintScdInputRawAfterStart, .-PrintScdInputRawAfterStart
	.align	2
	.global	PrintScdRawState
	.type	PrintScdRawState, %function
PrintScdRawState:
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
	mov	r6, r0
	mov	r0, #26
	mov	r5, r1
	bl	IsDprintTypeEnable
	cmp	r0, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	r1, .L1162
	mov	r3, r6, asl #6
	sub	r3, r3, r6, asl #3
	mov	r2, r6
	add	r3, r1, r3
	mov	r0, #26
	ldr	r1, .L1162+4
	ldr	r4, [r3, #56]
	bl	dprint_vfmw
	ldr	r1, .L1162+8
	mov	r0, #26
	add	r7, r4, #98304
	ldr	r2, [r7, #112]
	bl	dprint_vfmw
	ldr	r2, [r7, #116]
	ldr	r1, .L1162+12
	mov	r0, #26
	bl	dprint_vfmw
	ldr	r2, [r7, #120]
	ldr	r1, .L1162+16
	mov	r0, #26
	bl	dprint_vfmw
	ldr	r2, [r7, #124]
	ldr	r1, .L1162+20
	mov	r0, #26
	bl	dprint_vfmw
	ldr	r2, [r7, #128]
	ldr	r1, .L1162+24
	mov	r0, #26
	bl	dprint_vfmw
	cmp	r5, #1
	beq	.L1152
.L1156:
	mov	r2, r6
	ldr	r1, .L1162+28
	mov	r0, #26
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1152:
	cmn	r4, #112
	beq	.L1153
	ldr	r5, [r7, #112]
	ldr	r7, [r7, #116]
	subs	r7, r7, r5
	addmi	r7, r7, #1024
	cmp	r7, #0
	ble	.L1156
	mov	r3, r5, asl #7
	add	r7, r5, r7
	sub	r3, r3, r5, asl #5
	add	r4, r4, r3
.L1155:
	ldr	r2, [r4, #116]
	mov	r0, #26
	ldr	r1, .L1162+32
	add	r5, r5, #1
	bl	dprint_vfmw
	ldrd	r2, [r4, #152]
	ldr	r1, .L1162+36
	mov	r0, #26
	bl	dprint_vfmw
	ldr	r2, [r4, #120]
	ldr	r1, .L1162+40
	mov	r0, #26
	bl	dprint_vfmw
	ldrd	r2, [r4, #176]
	ldr	r1, .L1162+44
	mov	r0, #26
	bl	dprint_vfmw
	cmp	r5, r7
	add	r4, r4, #96
	bne	.L1155
	b	.L1156
.L1153:
	movw	r3, #6725
	ldr	r2, .L1162+48
	ldr	r1, .L1162+52
	mov	r0, #22
	bl	dprint_vfmw
	b	.L1156
.L1163:
	.align	2
.L1162:
	.word	.LANCHOR0
	.word	.LC107
	.word	.LC108
	.word	.LC109
	.word	.LC110
	.word	.LC111
	.word	.LC112
	.word	.LC113
	.word	.LC114
	.word	.LC115
	.word	.LC116
	.word	.LC117
	.word	.LANCHOR3+444
	.word	.LC12
	.fnend
	.size	PrintScdRawState, .-PrintScdRawState
	.align	2
	.global	FillRawData
	.type	FillRawData, %function
FillRawData:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #116
	sub	sp, sp, #116
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r9, .L1207
	mov	r2, r0, asl #6
	mov	r3, r0, asl #3
	str	r3, [fp, #-152]
	rsb	r3, r3, r2
	ldr	r6, .L1207+4
	add	r3, r9, r3
	str	r2, [fp, #-156]
	mov	r4, r0
	mov	r2, #96
	ldr	r5, [r3, #56]
	mov	r1, #0
	sub	r0, fp, #140
	ldr	r3, [r6, #48]
	blx	r3
	cmp	r5, #0
	beq	.L1164
	ldr	r3, [r5, #56]
	cmp	r3, #20
	beq	.L1164
	mov	r3, r4, asl #24
	str	r3, [fp, #-148]
.L1181:
	ldr	r3, [fp, #-156]
	ldr	r2, [fp, #-152]
	rsb	r7, r2, r3
	add	r7, r9, r7
	b	.L1176
.L1205:
	ldr	r3, [r7, #56]
	cmp	r3, #0
	beq	.L1166
	add	r2, r3, #98304
	ldr	r3, [r2, #116]
	ldr	r1, [r2, #120]
	add	r3, r3, #1
	mov	r2, r3, asr #31
	mov	r2, r2, lsr #22
	add	r3, r3, r2
	ubfx	r3, r3, #0, #10
	rsb	r3, r2, r3
	cmp	r3, r1
	beq	.L1166
	sub	r1, fp, #140
	mov	r0, r4
	bl	ReadRawStreamData
	subs	r8, r0, #0
	bne	.L1164
	add	r10, r5, #200704
	ldr	r2, [fp, #-132]
	ldr	r1, [r6]
	ldr	r0, [r10, #3936]
	ldr	ip, [r10, #3960]
	add	r0, r0, r2
	str	r0, [r10, #3936]
	ldr	r0, [r10, #3964]
	add	r2, r2, ip
	str	r2, [r10, #3960]
	add	r2, r0, #1
	str	r2, [r10, #3964]
	blx	r1
	ldr	r1, [r10, #3940]
	cmp	r1, #0
	streq	r0, [r10, #3940]
	beq	.L1169
	rsb	r1, r1, r0
	cmp	r1, #2000
	bls	.L1169
	str	r0, [fp, #-144]
	ldr	r0, [r10, #3936]
	mov	r0, r0, asl #3
	bl	__aeabi_uidiv
	mov	r1, #1000
	ldr	r2, [fp, #-144]
	str	r8, [r10, #3936]
	str	r2, [r10, #3940]
	mul	r0, r1, r0
	mov	r0, r0, lsr #10
	str	r0, [r10, #3944]
.L1169:
	ldrd	r2, [fp, #-76]
	mov	r0, #29
	ldr	r1, .L1207+8
	bl	dprint_vfmw
	ldr	r3, [fp, #-132]
	ldr	r2, [fp, #-136]
	mov	r0, #26
	ldr	r1, .L1207+12
	bl	dprint_vfmw
	ldrd	r2, [fp, #-76]
	mov	r1, #0
	mvn	r0, #0
	cmp	r3, r1
	cmpeq	r2, r0
	beq	.L1201
.L1170:
	sub	r1, fp, #140
	mov	r0, r4
	bl	SM_PushRaw
	subs	r8, r0, #0
	bne	.L1202
	mov	r3, #1
	mov	r2, r8
	strb	r3, [r5, #4]
	mov	r1, r8
	mov	r0, r4
	bl	DBG_CountTimeInfo
	mov	r0, r8
	bl	CHECK_REC_POS_ENABLE
	cmp	r0, #0
	bne	.L1203
.L1174:
	ldr	r8, .L1207+16
	ldr	r3, [r8, r4, asl #2]
	cmp	r3, #0
	bne	.L1204
.L1176:
	cmp	r4, #15
	bls	.L1205
.L1166:
	add	r5, r5, #188416
	ldr	r1, .L1207+20
	mov	r2, r4
	mov	r0, #23
	bl	dprint_vfmw
	mov	r1, #0
	ldr	r0, [r5, #2352]
	bl	PrintScdRawState
.L1164:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1203:
	ldr	r3, [r6]
	blx	r3
	add	ip, r9, r4, lsl #2
	ldr	r2, .L1207+24
	ldr	r3, [ip, #1020]
	ldr	r2, [r2]
	rsb	r3, r3, r0
	cmp	r3, r2
	bls	.L1174
	ldr	r8, .L1207+16
	movw	r1, #4624
	str	r0, [ip, #1020]
	ldr	r2, [fp, #-148]
	ldr	r0, .L1207+28
	bl	DBG_AddTrace
	ldr	r3, [r8, r4, asl #2]
	cmp	r3, #0
	beq	.L1176
.L1204:
	ldr	r3, [r6, #16]
	mov	r0, #0
	ldr	r7, [r5, #56]
	blx	r3
	ldrb	r3, [fp, #-138]
	cmp	r3, #0
	bne	.L1177
	sub	r3, r7, #4
	cmp	r3, #1
	bls	.L1178
	cmp	r7, #19
	beq	.L1178
	sub	r3, r7, #8
	cmp	r3, #6
	bls	.L1178
	cmp	r7, #1
	beq	.L1206
	cmp	r7, #17
	bne	.L1180
.L1178:
	ldr	r3, [r6, #44]
	mov	r1, #4
	ldr	r2, [r8, r4, asl #2]
	sub	r0, fp, #132
	blx	r3
.L1180:
	ldr	r2, [r8, r4, asl #2]
	ldr	r3, [r6, #44]
	ldr	r1, [fp, #-132]
	ldr	r0, [fp, #-100]
	blx	r3
.L1177:
	ldr	r3, [r6, #12]
	mov	r0, #0
	blx	r3
	b	.L1181
.L1201:
	mvn	r2, #0
	mvn	r3, #0
	strd	r2, [fp, #-76]
	b	.L1170
.L1202:
	ldr	r1, .L1207+32
	mov	r0, #0
	bl	dprint_vfmw
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1206:
	ldr	r3, [r5, #72]
	cmp	r3, #1
	bne	.L1178
	b	.L1180
.L1208:
	.align	2
.L1207:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC118
	.word	.LC119
	.word	vfmw_save_str_file
	.word	.LC121
	.word	g_TraceBsPeriod
	.word	.LANCHOR3+464
	.word	.LC120
	.fnend
	.size	FillRawData, .-FillRawData
	.align	2
	.global	SM_SeekPts
	.type	SM_SeekPts, %function
SM_SeekPts:
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
	ldr	r3, .L1317
	mov	r2, r0, asl #6
	sub	r2, r2, r0, asl #3
	str	r0, [fp, #-64]
	add	r3, r3, r2
	str	r1, [fp, #-68]
	ldr	r10, [r3, #56]
	cmp	r10, #0
	beq	.L1212
	add	r9, r10, #98304
	adds	r6, r9, #136
	beq	.L1212
	ldr	r3, [fp, #-68]
	add	r5, r10, #188416
	str	r10, [fp, #-52]
	ldr	r2, [r5, #2248]
	ldrd	r0, [r3]
	cmp	r2, #1
	ldr	r4, [r5, #2192]
	ldr	ip, [r5, #2196]
	strd	r0, [fp, #-60]
	ldrd	r0, [r3, #8]
	str	r2, [fp, #-80]
	strd	r0, [fp, #-100]
	ldrd	r0, [r3, #16]
	moveq	r3, #3
	streq	r3, [r5, #2248]
	movw	r3, #36409
	movt	r3, 14563
	str	r4, [r5, #2200]
	strd	r0, [fp, #-76]
	str	r3, [fp, #-48]
.L1214:
	mov	r7, r4, asl #4
	mov	r8, r4, asl #6
	cmp	r4, ip
	add	r3, r7, r8
	mov	r1, r4
	mov	r0, r6
	add	r3, r9, r3
	beq	.L1301
	ldrsb	r2, [r3, #148]
	cmp	r2, #1
	bne	.L1218
	ldrd	r2, [r3, #176]
	mvn	r1, #0
	mvn	r0, #0
	cmp	r3, r1
	cmpeq	r2, r0
	addeq	r1, r4, #1
	beq	.L1292
	ldrd	r0, [fp, #-60]
	add	lr, r4, #1
	cmp	r1, r3
	ldr	r1, [fp, #-48]
	cmpeq	r0, r2
	mov	r10, lr, asr #31
	smull	r0, r1, lr, r1
	bls	.L1221
	str	r4, [r5, #2200]
	rsb	r4, r10, r1, asr #8
	mov	r3, r4, asl #10
	add	r4, r3, r4, lsl #7
	rsb	r4, r4, lr
	b	.L1214
.L1218:
	bl	ReleaseStreamSeg
	ldr	ip, [r5, #2196]
	add	r1, r4, #1
.L1292:
	ldr	r3, [fp, #-48]
	mov	r4, r1, asr #31
	smull	r2, r3, r1, r3
	rsb	r4, r4, r3, asr #8
	mov	r3, r4, asl #10
	add	r4, r3, r4, lsl #7
	rsb	r4, r4, r1
	b	.L1214
.L1221:
	beq	.L1302
	bcs	.L1214
	ldr	ip, [r5, #2200]
	mvn	r1, #0
	mvn	r0, #0
	mov	r3, ip, asl #6
	add	r3, r3, ip, lsl #4
	add	r3, r9, r3
	ldrd	r2, [r3, #176]
	cmp	r3, r1
	cmpeq	r2, r0
	streq	r4, [r5, #2200]
	moveq	ip, r4
	beq	.L1226
	ldrd	r0, [fp, #-60]
	cmp	r1, r3
	cmpeq	r0, r2
	bhi	.L1303
.L1226:
	ldr	r7, [r5, #2192]
	cmp	ip, r7
	beq	.L1227
	movw	r4, #36409
	mov	r8, #2
	movt	r4, 14563
.L1228:
	mov	r3, r7, asl #6
	mov	r1, r7
	add	r3, r3, r7, lsl #4
	mov	r0, r6
	add	r3, r9, r3
	strb	r8, [r3, #148]
	ldr	ip, [r3, #156]
	ldr	r2, [r5, #2228]
	ldr	r3, [r5, #2232]
	rsb	r2, ip, r2
	sub	r3, r3, #1
	bic	r2, r2, r2, asr #31
	str	r2, [r5, #2228]
	bic	r3, r3, r3, asr #31
	str	r3, [r5, #2232]
	bl	ReleaseStreamSeg
	add	r1, r7, #1
	ldr	r0, [r5, #2200]
	smull	r2, r3, r1, r4
	mov	r7, r1, asr #31
	rsb	r7, r7, r3, asr #8
	mov	r3, r7, asl #10
	add	r7, r3, r7, lsl #7
	rsb	r7, r7, r1
	cmp	r0, r7
	bne	.L1228
.L1227:
	mov	r3, r7, asl #6
	ldr	r1, [fp, #-68]
	add	r3, r3, r7, lsl #4
	mov	r0, #0
	add	r3, r9, r3
	ldrd	r2, [r3, #176]
	strd	r2, [r1]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1301:
	ldr	r8, [r5, #2192]
	ldr	r10, [fp, #-52]
	cmp	r4, r8
	beq	.L1216
	movw	r4, #36409
	mov	r7, #2
	movt	r4, 14563
.L1217:
	mov	r3, r8, asl #6
	mov	r1, r8
	add	r3, r3, r8, lsl #4
	mov	r0, r6
	add	r3, r9, r3
	strb	r7, [r3, #148]
	ldr	ip, [r3, #156]
	ldr	r2, [r5, #2228]
	ldr	r3, [r5, #2232]
	rsb	r2, ip, r2
	sub	r3, r3, #1
	bic	r2, r2, r2, asr #31
	str	r2, [r5, #2228]
	bic	r3, r3, r3, asr #31
	str	r3, [r5, #2232]
	bl	ReleaseStreamSeg
	add	r1, r8, #1
	ldr	r0, [r5, #2196]
	smull	r2, r3, r1, r4
	mov	r8, r1, asr #31
	rsb	r8, r8, r3, asr #8
	mov	r3, r8, asl #10
	add	r8, r3, r8, lsl #7
	rsb	r8, r8, r1
	cmp	r0, r8
	bne	.L1217
.L1216:
	mov	r1, #0
	ldr	r0, [fp, #-64]
	bl	DeleteRawPacketInBuffer
	adds	r3, r10, #112
	str	r3, [fp, #-84]
	beq	.L1212
	ldr	r3, [r9, #112]
	ldr	r8, [r9, #116]
	cmp	r3, r8
	str	r3, [fp, #-52]
	addgt	r3, r8, #1024
	rsble	r3, r3, r8
	ldrgt	r2, [fp, #-52]
	rsbgt	r3, r2, r3
	str	r3, [fp, #-88]
	ldr	r3, [fp, #-52]
	cmp	r3, r8
	str	r3, [r9, #120]
	beq	.L1234
	str	r5, [fp, #-92]
	mvn	r6, #0
	mvn	r7, #0
	ldr	ip, [fp, #-52]
	str	r9, [fp, #-48]
	ldrd	r4, [fp, #-60]
	b	.L1233
.L1306:
	ldr	r3, [fp, #-48]
	str	ip, [r3, #120]
	mov	ip, r9, lsr #22
	add	r3, lr, ip
	ubfx	r3, r3, #0, #10
	rsb	ip, ip, r3
.L1238:
	cmp	r8, ip
	beq	.L1304
.L1233:
	mov	r3, ip, asl #7
	mvn	r0, #0
	sub	r3, r3, ip, asl #5
	mvn	r1, #0
	add	r3, r10, r3
	ldrd	r2, [r3, #176]
	cmp	r3, r7
	cmpeq	r2, r6
	beq	.L1305
	cmp	r5, r3
	add	lr, ip, #1
	cmpeq	r4, r2
	mov	r9, lr, asr #31
	bhi	.L1306
	beq	.L1307
	bcs	.L1238
	ldr	r9, [fp, #-48]
	strd	r2, [fp, #-76]
	ldr	r5, [fp, #-92]
	ldr	lr, [r9, #120]
	mov	r4, lr, asl #7
	sub	r4, r4, lr, asl #5
	add	r4, r10, r4
	ldrd	r6, [r4, #176]
	cmp	r7, r1
	cmpeq	r6, r0
	beq	.L1308
	ldrd	r0, [fp, #-60]
	cmp	r1, r7
	cmpeq	r0, r6
	bls	.L1246
	subs	r0, r0, r6
	ldrd	r2, [fp, #-100]
	sbc	r1, r1, r7
	cmp	r3, r1
	cmpeq	r2, r0
	bcc	.L1309
.L1246:
	ldr	r3, [fp, #-52]
	cmp	lr, r3
	addlt	lr, lr, #1024
	ldrlt	r3, [fp, #-52]
	rsb	r1, r3, lr
	cmp	r1, #0
	beq	.L1249
	ldr	r4, [r5, #2240]
	ldr	r3, [fp, #-80]
	cmp	r1, r4
	cmple	r3, #1
	moveq	r4, #1
	movne	r4, #0
	beq	.L1249
	ldr	r3, [fp, #-68]
	strd	r6, [r3]
.L1300:
	ldr	r3, [r9, #112]
	ldr	r0, [fp, #-84]
	str	r3, [r9, #120]
	bl	DeleteRawPacket
	mov	r1, r4
	ldr	r0, [fp, #-64]
	bl	DeleteRawPacketInBuffer
	mov	r0, r4
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1305:
	add	r3, ip, #1
	mov	ip, r3, asr #31
	mov	ip, ip, lsr #22
	add	r3, r3, ip
	ubfx	r3, r3, #0, #10
	rsb	ip, ip, r3
	cmp	r8, ip
	bne	.L1233
.L1304:
	ldr	r3, [fp, #-52]
	ldr	r9, [fp, #-48]
	cmp	r3, r8
	ble	.L1234
	add	r8, r8, #1024
	rsb	r1, r3, r8
	ldr	r3, [fp, #-52]
	cmp	r1, #0
	str	r3, [r9, #120]
	bne	.L1310
.L1236:
	ldr	r2, [fp, #-88]
	ldrd	r0, [fp, #-76]
	mov	r3, r2, asr #31
	cmp	r1, r3
	cmpeq	r0, r2
	bls	.L1311
	ldrd	r0, [fp, #-76]
	subs	r0, r0, r2
	sbc	r1, r1, r3
	mov	r2, r0
	movw	r0, #1023
	mov	r3, r1
	and	r0, r0, r2
	mov	r1, #0
	and	r1, r1, r3
	orrs	r1, r0, r1
	mov	r2, r2, lsr #10
	orrne	r2, r2, r3, asl #22
	orreq	r3, r2, r3, asl #22
	addne	r3, r2, #1
	add	r3, r3, #1
	str	r3, [fp, #-80]
	cmp	r3, #0
	ble	.L1274
	ldr	r4, [fp, #-64]
	mov	r1, #0
	mvn	r5, #0
	mov	r0, r4
	bl	DeleteRawPacketInBuffer
	mov	r0, r4
	bl	FillRawData
	ldrd	r6, [fp, #-60]
	mvn	r4, #0
	mov	r3, #0
	str	r9, [fp, #-48]
	str	r3, [fp, #-76]
.L1275:
	ldr	r3, [fp, #-48]
	ldr	r2, [r3, #112]
	ldr	r9, [r3, #116]
	mov	ip, r2
	str	r2, [fp, #-52]
	str	r2, [r3, #120]
.L1255:
	mov	r3, ip, asl #7
	cmp	ip, r9
	sub	r3, r3, ip, asl #5
	mvn	r0, #0
	mvn	r1, #0
	add	r3, r10, r3
	beq	.L1312
	ldrd	r2, [r3, #176]
	cmp	r3, r5
	cmpeq	r2, r4
	beq	.L1313
	cmp	r7, r3
	add	lr, ip, #1
	cmpeq	r6, r2
	mov	r8, lr, asr #31
	bls	.L1263
	ldr	r3, [fp, #-48]
	str	ip, [r3, #120]
	mov	ip, r8, lsr #22
	add	lr, lr, ip
	ubfx	lr, lr, #0, #10
	rsb	ip, ip, lr
	b	.L1255
.L1263:
	beq	.L1314
	bcs	.L1255
	ldr	r9, [fp, #-48]
	ldr	r8, [fp, #-52]
	ldr	lr, [r9, #120]
	mov	r4, lr, asl #7
	sub	r4, r4, lr, asl #5
	add	r4, r10, r4
	ldrd	r4, [r4, #176]
	cmp	r5, r1
	cmpeq	r4, r0
	beq	.L1315
	ldrd	r0, [fp, #-60]
	cmp	r1, r5
	cmpeq	r0, r4
	bls	.L1269
	subs	r0, r0, r4
	ldrd	r6, [fp, #-100]
	sbc	r1, r1, r5
	cmp	r7, r1
	cmpeq	r6, r0
	strcc	ip, [r9, #120]
	movcc	r4, r2
	movcc	r5, r3
	movcc	lr, ip
.L1269:
	cmp	r8, lr
	ldr	r3, [fp, #-68]
	addgt	lr, lr, #1024
	rsb	r1, r8, lr
	cmp	r1, #0
	strd	r4, [r3]
	bne	.L1272
.L1299:
	ldr	r3, [r9, #112]
	mov	r0, r1
	str	r3, [r9, #120]
.L1291:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1313:
	add	r3, ip, #1
	mov	ip, r3, asr #31
	mov	ip, ip, lsr #22
	add	r3, r3, ip
	ubfx	r3, r3, #0, #10
	rsb	ip, ip, r3
	b	.L1255
.L1312:
	ldr	r3, [fp, #-52]
	ldr	r2, [fp, #-52]
	cmp	r3, ip
	addgt	ip, ip, #1024
	ldrgt	r3, [fp, #-52]
	rsb	r1, r3, ip
	ldr	r3, [fp, #-48]
	cmp	r1, #0
	str	r2, [r3, #120]
	bne	.L1316
.L1260:
	ldr	r3, [fp, #-76]
	ldr	r2, [fp, #-80]
	add	r3, r3, #1
	str	r3, [fp, #-76]
	cmp	r3, r2
	beq	.L1274
	ldr	r8, [fp, #-64]
	mov	r1, #0
	mov	r0, r8
	bl	DeleteRawPacketInBuffer
	mov	r0, r8
	bl	FillRawData
	b	.L1275
.L1234:
	ldr	r3, [fp, #-52]
	rsb	r1, r3, r8
	ldr	r3, [fp, #-52]
	cmp	r1, #0
	str	r3, [r9, #120]
	beq	.L1236
.L1310:
	ldr	r0, [fp, #-84]
	bl	DeleteRawPacket
	mov	r1, #0
	ldr	r0, [fp, #-64]
	bl	DeleteRawPacketInBuffer
	b	.L1236
.L1314:
	ldr	r8, [fp, #-52]
	ldr	r0, [fp, #-68]
	cmp	r8, ip
	ldrd	r2, [fp, #-60]
	addgt	ip, ip, #1024
	ldr	r9, [fp, #-48]
	rsb	r1, r8, ip
	cmp	r1, #0
	strd	r2, [r0]
	beq	.L1299
.L1272:
	ldr	r3, [r9, #112]
	ldr	r0, [fp, #-84]
	str	r3, [r9, #120]
	bl	DeleteRawPacket
	ldr	r0, [fp, #-64]
	mov	r1, #0
	bl	DeleteRawPacketInBuffer
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1316:
	ldr	r0, [fp, #-84]
	bl	DeleteRawPacket
	mov	r1, #0
	ldr	r0, [fp, #-64]
	bl	DeleteRawPacketInBuffer
	b	.L1260
.L1307:
	ldr	r3, [fp, #-52]
	ldr	r9, [fp, #-48]
	cmp	r3, ip
	ldr	r5, [fp, #-92]
	addgt	ip, ip, #1024
	ldrgt	r3, [fp, #-52]
	rsb	r1, r3, ip
	cmp	r1, #0
	beq	.L1243
	ldr	r4, [r5, #2240]
	ldr	r3, [fp, #-80]
	cmp	r1, r4
	cmple	r3, #1
	moveq	r4, #1
	movne	r4, #0
	beq	.L1243
	ldr	r0, [fp, #-68]
	ldrd	r2, [fp, #-60]
	strd	r2, [r0]
	b	.L1300
.L1302:
	ldr	r10, [r5, #2192]
	cmp	r4, r10
	beq	.L1223
	movw	r3, #36409
	str	r7, [fp, #-48]
	movt	r3, 14563
	mov	r7, r5
	mov	r5, r3
.L1224:
	mov	r3, r10, asl #6
	mov	r2, #2
	add	r3, r3, r10, lsl #4
	mov	r1, r10
	add	r3, r9, r3
	mov	r0, r6
	strb	r2, [r3, #148]
	ldr	lr, [r3, #156]
	ldr	ip, [r7, #2228]
	ldr	r3, [r7, #2232]
	rsb	ip, lr, ip
	sub	r3, r3, #1
	bic	ip, ip, ip, asr #31
	str	ip, [r7, #2228]
	bic	r3, r3, r3, asr #31
	str	r3, [r7, #2232]
	bl	ReleaseStreamSeg
	add	ip, r10, #1
	smull	r0, r1, ip, r5
	mov	r10, ip, asr #31
	rsb	r10, r10, r1, asr #8
	mov	r3, r10, asl #10
	add	r10, r3, r10, lsl #7
	rsb	r10, r10, ip
	cmp	r4, r10
	bne	.L1224
	ldr	r7, [fp, #-48]
	add	r3, r7, r8
	add	r3, r9, r3
	ldrd	r2, [r3, #176]
.L1223:
	ldr	r1, [fp, #-68]
	mov	r0, #0
	strd	r2, [r1]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1243:
	ldr	r1, [fp, #-68]
	ldrd	r2, [fp, #-60]
	strd	r2, [r1]
.L1298:
	ldr	r3, [r9, #112]
	mov	r0, #0
	str	r3, [r9, #120]
	ldr	r3, [fp, #-80]
	str	r3, [r5, #2248]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1249:
	ldr	r3, [fp, #-68]
	strd	r6, [r3]
	b	.L1298
.L1315:
	str	ip, [r9, #120]
	mov	r4, r2
	mov	r5, r3
	mov	lr, ip
	b	.L1269
.L1303:
	subs	r0, r0, r2
	sbc	r1, r1, r3
	mov	r2, r0
	mov	r3, r1
	ldrd	r0, [fp, #-100]
	cmp	r1, r3
	cmpeq	r0, r2
	strcc	r4, [r5, #2200]
	movcc	ip, r4
	b	.L1226
.L1309:
	ldrd	r6, [fp, #-76]
	mov	lr, ip
	str	ip, [r9, #120]
	b	.L1246
.L1308:
	str	ip, [r9, #120]
	mov	r6, r2
	mov	r7, r3
	mov	lr, ip
	b	.L1246
.L1274:
	mvn	r0, #1
	b	.L1291
.L1212:
	mvn	r0, #0
	b	.L1291
.L1311:
	strd	r2, [sp]
	mov	r2, r0
	mov	r3, r1
	mov	r0, #1
	ldr	r1, .L1317+4
	bl	dprint_vfmw
	mvn	r0, #1
	b	.L1291
.L1318:
	.align	2
.L1317:
	.word	.LANCHOR0
	.word	.LC122
	.fnend
	.size	SM_SeekPts, .-SM_SeekPts
	.align	2
	.global	PrintSmInfo
	.type	PrintSmInfo, %function
PrintSmInfo:
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
	ldr	r2, .L1334
	mov	r3, r0, asl #6
	sub	r3, r3, r0, asl #3
	sub	r1, fp, #68
	add	r3, r2, r3
	mov	r6, #0
	mov	r5, r0
	str	r6, [fp, #-68]
	ldr	r4, [r3, #56]
	str	r6, [fp, #-64]
	str	r6, [fp, #-60]
	str	r6, [fp, #-56]
	str	r6, [fp, #-52]
	str	r6, [fp, #-48]
	bl	SM_GetInfo
	cmp	r4, r6
	beq	.L1319
	add	r9, r4, #188416
	mov	r2, r5
	ldr	r1, .L1334+4
	mov	r0, #32
	bl	dprint_vfmw
	ldr	r3, [r9, #2368]
	ldr	r2, .L1334+8
	mov	r0, #32
	ldr	r1, .L1334+12
	add	r7, r4, #200704
	bl	dprint_vfmw
	ldrb	r3, [r4, #52]
	ldr	r2, .L1334+16
	mov	r0, #32
	ldr	r1, .L1334+12
	mov	r10, r6
	bl	dprint_vfmw
	ldr	r3, [r4, #56]
	ldr	r2, .L1334+20
	mov	r0, #32
	ldr	r1, .L1334+12
	add	r5, r4, #98304
	bl	dprint_vfmw
	ldr	r3, [r4, #60]
	ldr	r2, .L1334+24
	mov	r0, #32
	ldr	r1, .L1334+28
	movw	r8, #26215
	bl	dprint_vfmw
	ldr	r3, [r4, #48]
	ldr	r2, .L1334+32
	mov	r0, #32
	ldr	r1, .L1334+28
	movt	r8, 26214
	bl	dprint_vfmw
	ldr	r3, [r4, #64]
	ldr	r2, .L1334+36
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	ldr	r3, [r4, #68]
	ldr	r2, .L1334+40
	mov	r0, #32
	ldr	r1, .L1334+28
	bl	dprint_vfmw
	ldr	r3, [r9, #2240]
	ldr	r2, .L1334+44
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	ldr	r3, [r9, #2244]
	ldr	r2, .L1334+48
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	ldr	r3, [r9, #2264]
	ldr	r2, .L1334+52
	mov	r0, #32
	ldr	r1, .L1334+28
	bl	dprint_vfmw
	ldr	r3, [r9, #2260]
	ldr	r2, .L1334+56
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	ldr	r3, [r9, #2272]
	ldr	r2, .L1334+60
	mov	r0, #32
	ldr	r1, .L1334+28
	bl	dprint_vfmw
	ldr	r3, [r9, #2280]
	ldr	r2, .L1334+64
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	ldr	r3, [r9, #2276]
	ldr	r2, .L1334+68
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	ldr	r3, [r9, #2344]
	ldr	r2, .L1334+72
	mov	r0, #32
	ldr	r1, .L1334+28
	bl	dprint_vfmw
	ldr	r3, [r9, #2348]
	ldr	r2, .L1334+76
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	ldr	r3, [fp, #-52]
	ldr	r2, .L1334+80
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	ldr	r3, [fp, #-60]
	ldr	r2, .L1334+84
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	ldr	r3, [fp, #-56]
	ldr	r2, .L1334+88
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	ldr	r3, [fp, #-64]
	ldr	r2, .L1334+92
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	ldr	r3, [r4, #16]
	ldr	r2, .L1334+96
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	ldr	r3, [r4, #20]
	ldr	r2, .L1334+100
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	ldr	r3, [r4, #24]
	ldr	r2, .L1334+104
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	ldr	r3, [r4, #28]
	ldr	r2, .L1334+108
	mov	r0, #32
	ldr	r1, .L1334+28
	bl	dprint_vfmw
	ldr	r3, [r4, #32]
	ldr	r2, .L1334+112
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	ldr	r3, [r4, #36]
	ldr	r2, .L1334+116
	mov	r0, #32
	ldr	r1, .L1334+28
	bl	dprint_vfmw
	ldr	r3, [r4, #12]
	ldr	r2, .L1334+120
	mov	r0, #32
	ldr	r1, .L1334+28
	bl	dprint_vfmw
	ldr	r3, [r4, #40]
	ldr	r2, .L1334+124
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	ldr	r3, [r7, #3908]
	ldr	r2, .L1334+128
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	ldr	r3, [r7, #3912]
	ldr	r2, .L1334+132
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	add	r3, r4, #203776
	add	r3, r3, #848
	ldr	r2, .L1334+136
	ldr	r1, .L1334+140
	mov	r0, #32
	ldrd	r6, [r3]
	strd	r6, [sp]
	bl	dprint_vfmw
	ldr	r3, [r9, #2352]
	ldr	r2, .L1334+144
	mov	r0, #32
	ldr	r1, .L1334+12
	bl	dprint_vfmw
	ldr	r3, .L1334
	ldr	r2, .L1334+148
	mov	r0, #32
	ldr	r1, .L1334+12
	ldr	r3, [r3, #988]
	bl	dprint_vfmw
	ldr	lr, [r5, #120]
	ldr	r3, [r5, #112]
	mov	r0, #32
	ldr	r2, .L1334+148
	ldr	r1, .L1334+152
	str	lr, [sp]
	bl	dprint_vfmw
	ldr	r2, [r5, #124]
	ldr	r1, .L1334+156
	mov	r0, #32
	bl	dprint_vfmw
	ldr	r6, [r5, #120]
.L1321:
	ldr	r2, [r5, #116]
	mov	r3, r6, asl #7
	sub	r3, r3, r6, asl #5
	add	r10, r10, #1
	cmp	r2, r6
	add	r3, r4, r3
	add	r7, r6, #1
	ldr	r1, .L1334+160
	mov	r0, #32
	beq	.L1327
	ldr	r2, [r3, #120]
	bl	dprint_vfmw
	smull	r2, r3, r10, r8
	cmp	r7, #1024
	subge	r7, r6, #1020
	mov	r1, r10, asr #31
	subge	r7, r7, #3
	cmp	r10, #1024
	mov	r6, r7
	rsb	r3, r1, r3, asr #2
	beq	.L1327
	cmp	r10, #0
	mov	r2, r3, asl #3
	add	r3, r2, r3, lsl #1
	beq	.L1321
	cmp	r10, r3
	bne	.L1321
	ldr	r1, .L1334+164
	mov	r0, #32
	bl	dprint_vfmw
	b	.L1321
.L1327:
	ldr	r1, .L1334+164
	mov	r0, #32
	bl	dprint_vfmw
.L1319:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1335:
	.align	2
.L1334:
	.word	.LANCHOR0
	.word	.LC123
	.word	.LC124
	.word	.LC125
	.word	.LC126
	.word	.LC127
	.word	.LC128
	.word	.LC129
	.word	.LC130
	.word	.LC131
	.word	.LC132
	.word	.LC133
	.word	.LC134
	.word	.LC135
	.word	.LC136
	.word	.LC137
	.word	.LC138
	.word	.LC139
	.word	.LC140
	.word	.LC141
	.word	.LC142
	.word	.LC143
	.word	.LC144
	.word	.LC145
	.word	.LC146
	.word	.LC147
	.word	.LC148
	.word	.LC149
	.word	.LC150
	.word	.LC151
	.word	.LC152
	.word	.LC153
	.word	.LC154
	.word	.LC155
	.word	.LC156
	.word	.LC157
	.word	.LC158
	.word	.LC159
	.word	.LC160
	.word	.LC161
	.word	.LC162
	.word	.LC18
	.fnend
	.size	PrintSmInfo, .-PrintSmInfo
	.align	2
	.global	PrintScdSegState
	.type	PrintScdSegState, %function
PrintScdSegState:
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
	mov	r6, r0
	mov	r0, #26
	mov	r5, r1
	bl	IsDprintTypeEnable
	cmp	r0, #0
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	ldr	r1, .L1348
	mov	r3, r6, asl #6
	sub	r3, r3, r6, asl #3
	mov	r2, r6
	add	r3, r1, r3
	mov	r0, #26
	ldr	r1, .L1348+4
	ldr	r8, [r3, #56]
	bl	dprint_vfmw
	ldr	r1, .L1348+8
	mov	r0, #26
	add	r4, r8, #188416
	add	r7, r8, #98304
	ldr	r2, [r4, #2192]
	bl	dprint_vfmw
	ldr	r2, [r4, #2196]
	ldr	r1, .L1348+12
	mov	r0, #26
	bl	dprint_vfmw
	ldr	r2, [r4, #2204]
	ldr	r1, .L1348+16
	mov	r0, #26
	bl	dprint_vfmw
	ldr	r2, [r4, #2208]
	ldr	r1, .L1348+20
	mov	r0, #26
	bl	dprint_vfmw
	ldr	r2, [r7, #136]
	ldr	r1, .L1348+24
	mov	r0, #26
	bl	dprint_vfmw
	ldr	r2, [r4, #2212]
	ldr	r1, .L1348+28
	mov	r0, #26
	bl	dprint_vfmw
	ldr	r2, [r4, #2216]
	ldr	r1, .L1348+32
	mov	r0, #26
	bl	dprint_vfmw
	ldr	r2, [r4, #2220]
	ldr	r1, .L1348+36
	mov	r0, #26
	bl	dprint_vfmw
	cmp	r5, #1
	beq	.L1338
.L1342:
	mov	r2, r6
	ldr	r1, .L1348+40
	mov	r0, #26
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1338:
	cmn	r7, #136
	beq	.L1339
	ldr	r5, [r4, #2192]
	ldr	r7, [r4, #2196]
	subs	r7, r7, r5
	addmi	r7, r7, #1152
	cmp	r7, #0
	ble	.L1342
	mov	r3, r5, asl #6
	add	r7, r5, r7
	add	r3, r3, r5, lsl #4
	add	r3, r3, #98304
	add	r3, r3, #152
	add	r4, r8, r3
.L1341:
	ldr	r2, [r4]
	mov	r0, #26
	ldr	r1, .L1348+44
	add	r5, r5, #1
	bl	dprint_vfmw
	ldr	r2, [r4, #-8]
	ldr	r1, .L1348+48
	mov	r0, #26
	bl	dprint_vfmw
	ldr	r2, [r4, #4]
	ldr	r1, .L1348+52
	mov	r0, #26
	bl	dprint_vfmw
	ldr	r2, [r4, #8]
	ldr	r1, .L1348+56
	mov	r0, #26
	bl	dprint_vfmw
	ldrsb	r2, [r4, #-4]
	ldr	r1, .L1348+60
	mov	r0, #26
	bl	dprint_vfmw
	ldrb	r2, [r4, #-3]
	ldr	r1, .L1348+64
	mov	r0, #26
	bl	dprint_vfmw
	ldrd	r2, [r4, #16]
	ldr	r1, .L1348+68
	mov	r0, #26
	bl	dprint_vfmw
	cmp	r5, r7
	add	r4, r4, #80
	bne	.L1341
	b	.L1342
.L1339:
	movw	r3, #6870
	ldr	r2, .L1348+72
	ldr	r1, .L1348+76
	mov	r0, #22
	bl	dprint_vfmw
	b	.L1342
.L1349:
	.align	2
.L1348:
	.word	.LANCHOR0
	.word	.LC163
	.word	.LC164
	.word	.LC165
	.word	.LC166
	.word	.LC167
	.word	.LC168
	.word	.LC169
	.word	.LC170
	.word	.LC171
	.word	.LC172
	.word	.LC173
	.word	.LC174
	.word	.LC175
	.word	.LC176
	.word	.LC177
	.word	.LC178
	.word	.LC179
	.word	.LANCHOR3+476
	.word	.LC180
	.fnend
	.size	PrintScdSegState, .-PrintScdSegState
	.align	2
	.global	SM_DoNextInstance
	.type	SM_DoNextInstance, %function
SM_DoNextInstance:
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
	cmp	r0, #0
	str	r1, [fp, #-72]
	bne	.L1397
	ldr	r8, .L1404
	ldr	r9, [r8, #1000]
	cmp	r9, #0
	bne	.L1398
	ldr	r4, [r8, #984]
	mov	r10, #16
	str	r9, [fp, #-80]
	str	r9, [fp, #-76]
.L1368:
	add	r3, r4, #1
	sub	r1, fp, #68
	mov	r4, r3, asr #31
	mov	r4, r4, lsr #28
	add	r3, r3, r4
	and	r3, r3, #15
	rsb	r4, r4, r3
	mov	r6, r4, asl #3
	mov	r5, r4, asl #6
	rsb	r3, r6, r5
	mov	r0, r4
	add	r3, r8, r3
	ldr	r7, [r3, #56]
	bl	SM_GetInfo
	ldrsb	r3, [fp, #-68]
	cmp	r3, #0
	beq	.L1355
	add	r2, r7, #188416
	ldr	r3, [r2, #2360]
	cmp	r3, #1
	beq	.L1355
	ldr	r3, [r7, #56]
	sub	r1, r3, #8
	cmp	r3, #5
	cmpne	r1, #1
	bls	.L1355
	cmp	r3, #1
	beq	.L1399
	bic	r1, r3, #16
	sub	r0, r3, #10
	cmp	r1, #4
	cmpne	r0, #4
	movls	r1, #1
	movhi	r1, #0
	cmp	r3, #17
	orreq	r1, r1, #1
	cmp	r1, #0
	bne	.L1355
	cmp	r3, #19
	beq	.L1400
.L1357:
	mov	r1, #0
	mov	r0, r4
	str	r2, [fp, #-84]
	bl	PrintScdRawState
	mov	r1, #0
	mov	r0, r4
	bl	PrintScdSegState
	ldr	r3, .L1404+4
	ldr	r3, [r3]
	blx	r3
	add	r1, r7, #200704
	ldr	r2, [fp, #-84]
	ldr	r3, [r1, #3952]
	subs	r3, r0, r3
	strmi	r0, [r1, #3952]
	ldrsb	ip, [r7, #2]
	movmi	r3, #200
	cmp	ip, #1
	beq	.L1401
.L1359:
	str	r0, [r1, #3952]
	ldrsb	r3, [r7]
	cmp	r3, #1
	movne	r3, #0
	strneb	r3, [r7, #1]
	beq	.L1402
.L1363:
	mov	r1, #0
	mov	r0, r7
	bl	CutStreamWithSCD
	cmn	r0, #6
	moveq	r3, #1
	streqb	r3, [r7]
	beq	.L1355
	cmp	r0, #0
	mov	r3, #0
	strb	r3, [r7]
	bne	.L1355
	ldr	r2, [fp, #-72]
	rsb	r3, r6, r5
	add	r3, r8, r3
	mov	r1, #1
	mov	r0, r4
	str	r4, [r2]
	ldr	r3, [r3, #56]
	cmp	r3, #0
	addne	r3, r3, #188416
	movne	r2, #1
	strne	r2, [r3, #2368]
	ldr	r2, [r7, #80]
	bl	DBG_CountTimeInfo
	mov	r0, #1
	bl	CHECK_REC_POS_ENABLE
	cmp	r0, #0
	bne	.L1403
.L1395:
	mov	r0, #0
	b	.L1352
.L1398:
	cmp	r9, #1
	beq	.L1354
.L1369:
	mvn	r0, #2
.L1352:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1400:
	mov	r0, r4
	bl	SM_CopyYuvToDnr
	cmp	r0, #0
	beq	.L1355
	ldr	r1, .L1404+8
	mov	r0, #26
	bl	dprint_vfmw
.L1355:
	subs	r10, r10, #1
	bne	.L1368
	b	.L1369
.L1399:
	ldr	r3, [r7, #72]
	cmp	r3, #0
	bne	.L1357
	subs	r10, r10, #1
	bne	.L1368
	b	.L1369
.L1354:
	mov	r3, #2
	mvn	r0, #2
	str	r3, [r8, #1000]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1401:
	cmp	r3, #500
	ldrsb	ip, [r7, #4]
	movge	r3, #0
	movlt	r3, #1
	cmp	ip, #0
	movne	r3, #0
	cmp	r3, #0
	bne	.L1355
	b	.L1359
.L1397:
	mov	r2, r0
	ldr	r1, .L1404+12
	mov	r0, #26
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1352
.L1402:
	mov	r1, #0
	mov	r0, r4
	str	r2, [fp, #-92]
	str	r3, [fp, #-88]
	add	r3, r7, #98304
	str	r3, [fp, #-84]
	bl	PrintScdRawState
	ldr	r3, [fp, #-88]
	mov	r0, r4
	mov	r1, r3
	ldr	r3, [fp, #-84]
	add	r3, r3, #136
	str	r3, [fp, #-84]
	bl	PrintScdSegState
	ldr	r3, [fp, #-84]
	cmp	r3, #0
	beq	.L1361
	ldr	r2, [fp, #-92]
	ldr	r3, [r2, #2232]
	ldr	r9, [r2, #2228]
	str	r3, [fp, #-76]
	ldr	r3, [r2, #2212]
	str	r3, [fp, #-80]
.L1361:
	ldrsb	r3, [r7, #1]
	cmp	r3, #0
	bne	.L1362
	ldr	r3, [fp, #-80]
	ldr	r2, [fp, #-76]
	add	r3, r3, r3, lsr #31
	cmp	r9, r3, asr #1
	movlt	r3, #1
	movge	r3, #0
	cmp	r2, #127
	movgt	r3, #0
	andle	r3, r3, #1
	cmp	r3, #0
	beq	.L1363
	mov	r3, #1
	mov	r0, r4
	strb	r3, [r7, #1]
	mov	r1, r3
	bl	CalcInstBlockTime
	b	.L1363
.L1362:
	mov	r1, #0
	mov	r0, r4
	bl	CalcInstBlockTime
	cmp	r0, #1000
	mov	r2, r0
	ble	.L1363
	ldr	r1, [fp, #-80]
	cmp	r1, #0
	add	r3, r1, #3
	movge	r3, r1
	ldr	r1, [fp, #-76]
	cmp	r9, r3, asr #2
	movlt	r3, #1
	movge	r3, #0
	cmp	r1, #63
	movgt	r3, #0
	andle	r3, r3, #1
	cmp	r3, #0
	beq	.L1363
	ldr	r1, .L1404+16
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r0, [fp, #-84]
	mvn	r1, #0
	bl	ReleaseStreamSeg
	mov	r3, #0
	strb	r3, [r7, #1]
	strb	r3, [r7]
	b	.L1363
.L1403:
	ldr	r3, .L1404+4
	add	r8, r8, r4, lsl #2
	ldr	r3, [r3]
	blx	r3
	ldr	r2, .L1404+20
	ldr	r3, [r8, #1084]
	ldr	r2, [r2]
	rsb	r3, r3, r0
	mov	ip, r0
	cmp	r3, r2
	bls	.L1395
	mov	r2, r4, asl #24
	movw	r1, #5972
	add	r2, r2, #65536
	ldr	r0, .L1404+24
	str	ip, [r8, #1084]
	bl	DBG_AddTrace
	b	.L1395
.L1405:
	.align	2
.L1404:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC182
	.word	.LC181
	.word	.LC183
	.word	g_TraceBsPeriod
	.word	.LANCHOR3+496
	.fnend
	.size	SM_DoNextInstance, .-SM_DoNextInstance
	.align	2
	.type	SCDDRV_ActivateSCD.part.8, %function
SCDDRV_ActivateSCD.part.8:
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
	sub	r1, fp, #24
	mov	r4, r0
	bl	SM_DoNextInstance
	cmp	r0, #0
	bne	.L1406
	mov	r2, r4, asl #7
	ldr	r3, .L1408
	ldr	r1, [fp, #-24]
	sub	r4, r2, r4, asl #5
	ldr	r2, .L1408+4
	add	r4, r3, r4
	mov	r3, #1
	str	r1, [r4, #984]
	str	r3, [r4, #988]
	ldr	r3, [r2]
	blx	r3
	movw	r3, #6381
	ldr	r2, .L1408+8
	ldr	r1, .L1408+12
	str	r0, [r4, #992]
	mov	r0, #26
	bl	dprint_vfmw
.L1406:
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L1409:
	.align	2
.L1408:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR3+516
	.word	.LC184
	.fnend
	.size	SCDDRV_ActivateSCD.part.8, .-SCDDRV_ActivateSCD.part.8
	.align	2
	.global	SCDDRV_ActivateSCD
	.type	SCDDRV_ActivateSCD, %function
SCDDRV_ActivateSCD:
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
	cmp	r0, #0
	ldmnefd	sp, {fp, sp, pc}
	bl	SCDDRV_ActivateSCD.part.8
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	SCDDRV_ActivateSCD, .-SCDDRV_ActivateSCD
	.align	2
	.global	SM_Wakeup
	.type	SM_Wakeup, %function
SM_Wakeup:
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
	ldr	r5, .L1422
	mov	r4, #0
	b	.L1414
.L1413:
	add	r4, r4, #1
	cmp	r4, #16
	beq	.L1421
.L1414:
	ldr	r3, [r5, #48]
	add	r5, r5, #56
	cmp	r3, #0
	add	r2, r3, #188416
	beq	.L1413
	ldr	r3, [r2, #2368]
	cmp	r3, #1
	bne	.L1413
	mov	r0, r4
	add	r4, r4, #1
	bl	FillRawData
	cmp	r4, #16
	bne	.L1414
.L1421:
	mov	r2, #1
	mov	r3, #0
	str	r2, [sp]
	mov	r0, #26
	ldr	r2, .L1422+4
	ldr	r1, .L1422+8
	bl	dprint_vfmw
	mov	r0, #0
	bl	SCDDRV_CheckDevice
	subs	r4, r0, #0
	beq	.L1415
	mov	r2, #0
	movw	r3, #6451
	str	r2, [sp]
	mov	r0, #26
	ldr	r2, .L1422+4
	ldr	r1, .L1422+12
	bl	dprint_vfmw
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1415:
	movw	r3, #6446
	ldr	r2, .L1422+4
	ldr	r1, .L1422+16
	mov	r0, #26
	str	r4, [sp]
	bl	dprint_vfmw
	mov	r0, r4
	bl	SCDDRV_ActivateSCD.part.8
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1423:
	.align	2
.L1422:
	.word	.LANCHOR0+8
	.word	.LANCHOR3+536
	.word	.LC185
	.word	.LC186
	.word	.LC187
	.fnend
	.size	SM_Wakeup, .-SM_Wakeup
	.align	2
	.global	SetMaxSegSize
	.type	SetMaxSegSize, %function
SetMaxSegSize:
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
	mov	r5, r0
	bl	VCTRL_GetChanCapLevel
	cmp	r0, #32
	bhi	.L1433
	cmp	r0, #25
	beq	.L1434
	ldr	r3, [r4, #8]
	bics	r3, r3, #16
	bne	.L1429
	sub	r0, r0, #13
	cmp	r0, #19
	bhi	.L1429
	mov	r2, #1
	mov	r3, #2016
	mov	r0, r2, asl r0
	movt	r3, 8
	and	r3, r3, r0
	cmp	r3, #0
	bne	.L1431
	tst	r0, #31
	movne	r0, #4194304
	moveq	r0, #3145728
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1434:
	mov	r0, r5
	bl	VCTRL_GetChanWidth
	mov	r4, r0
	mov	r0, r5
	bl	VCTRL_GetChanHeight
	cmn	r0, #1
	cmnne	r4, #1
	beq	.L1435
	mul	r3, r0, r4
	mov	r2, #57344
	movt	r2, 31
	cmp	r3, r2
	bgt	.L1431
.L1429:
	mov	r0, #3145728
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1431:
	mov	r0, #20971520
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1433:
	ldr	r1, .L1436
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1435:
	ldr	r1, .L1436+4
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1437:
	.align	2
.L1436:
	.word	.LC188
	.word	.LC189
	.fnend
	.size	SetMaxSegSize, .-SetMaxSegSize
	.align	2
	.global	SM_Config
	.type	SM_Config, %function
SM_Config:
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
	clz	r3, r1
	mov	r7, r0
	mov	r5, r1
	mov	r3, r3, lsr #5
	cmp	r0, #15
	orrhi	r3, r3, #1
	cmp	r3, #0
	bne	.L1455
	ldr	r2, .L1458
	mov	ip, r0, asl #6
	sub	ip, ip, r0, asl #3
	add	ip, r2, ip
	ldr	r6, [ip, #56]
	cmn	r2, #904
	cmpne	r6, #0
	beq	.L1444
	ldr	r3, [r1, #36]
	add	r8, r6, #200704
	str	r3, [r8, #3968]
	ldr	r3, [r1, #12]
	ldr	lr, [r6, #60]
	cmp	lr, r3
	beq	.L1456
	cmp	r3, #0
	beq	.L1444
	ldr	r3, [r1]
	cmp	r3, #0
	beq	.L1444
	ldr	r3, [r2, #928]
	add	r4, r6, #188416
	ldr	r10, [r2, #916]
	ldr	r9, [r2, #912]
	str	r3, [r4, #2272]
	ldr	r3, [r2, #944]
	ldr	lr, [r2, #920]
	str	r10, [r4, #2264]
	str	r3, [r4, #2316]
	ldr	r3, [r2, #924]
	ldr	r10, [r2, #932]
	str	r9, [r4, #2256]
	str	r3, [r4, #2268]
	ldr	r3, [r2, #952]
	ldr	r9, [r2, #940]
	str	lr, [r4, #2260]
	str	r3, [r4, #2320]
	mov	r3, #1152
	ldr	lr, [r2, #936]
	str	r3, [r4, #2280]
	ldr	r3, [r2, #956]
	str	r10, [r4, #2276]
	str	r9, [r4, #2308]
	ldr	r10, [r2, #948]
	ldr	r9, [r2, #964]
	str	lr, [r4, #2312]
	str	r3, [r4, #2328]
	ldr	lr, [r2, #960]
	ldr	r3, [ip, #36]
	ldr	r2, [r2, #968]
	str	r9, [r4, #2332]
	str	lr, [r4, #2336]
	str	r2, [r4, #2340]
	str	r3, [r4, #2284]
	str	r10, [r4, #2324]
	ldr	r10, [ip, #32]
	ldr	r9, [ip, #40]
	ldr	r2, [ip, #44]
	ldr	r3, [ip, #52]
	ldr	lr, [ip, #48]
	str	r9, [r4, #2292]
	str	r2, [r4, #2300]
	str	r10, [r4, #2288]
	str	lr, [r4, #2296]
	str	r3, [r4, #2304]
	ldr	r3, [r1, #12]
	ldr	ip, [r1]
	add	r2, r3, #3
	bic	r2, r2, #3
	rsb	r9, r3, r2
	add	r2, r2, #131072
	add	r3, r9, #131072
	str	r2, [r4, #2344]
	add	r3, ip, r3
	str	r3, [r4, #2252]
	bl	SetMaxSegSize
	ldr	r2, [r5, #16]
	rsb	r3, r9, r2
	cmn	r0, #1
	moveq	r0, #2097152
	cmp	r0, r3
	sublt	r3, r0, #132096
	strlt	r3, [r4, #2348]
	bge	.L1457
.L1447:
	ldr	r10, .L1458+4
	add	r0, r6, #98304
	add	r9, r6, #48
	ldr	r2, [r4, #2252]
	ldr	r1, [r4, #2344]
	add	r0, r0, #136
	bl	ConfigStreamSegArray
	ldr	r3, [r10, #52]
	mov	r0, r9
	mov	r2, #60
	mov	r1, r5
	blx	r3
	mov	r3, #0
	str	r3, [r4, #2356]
.L1443:
	ldr	r3, [r10, #52]
	mov	r0, r9
	mov	r2, #60
	mov	r1, r5
	blx	r3
	mov	r3, #2
	str	r3, [r8, #3956]
	mov	r0, #0
	ldr	r3, [r5, #8]
	cmp	r3, #2
	moveq	r3, #3
	streq	r3, [r8, #3956]
	str	r7, [r4, #2352]
.L1440:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1457:
	sub	r3, r3, #132096
	str	r3, [r4, #2348]
	cmp	r3, #262144
	bge	.L1447
.L1444:
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1456:
	add	r9, r6, #48
	add	r4, r6, #188416
	ldr	r10, .L1458+4
	b	.L1443
.L1455:
	str	r1, [sp]
	mov	r3, r0
	movw	r2, #2004
	ldr	r1, .L1458+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1440
.L1459:
	.align	2
.L1458:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC190
	.fnend
	.size	SM_Config, .-SM_Config
	.align	2
	.global	SM_Reset
	.type	SM_Reset, %function
SM_Reset:
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
	cmp	r0, #15
	mov	r5, r0
	bhi	.L1469
	mov	r3, r0, asl #6
	ldr	r2, .L1480
	sub	r3, r3, r0, asl #3
	add	r3, r2, r3
	ldr	r4, [r3, #56]
	cmp	r4, #0
	beq	.L1477
	ldr	r7, .L1480+4
	add	r10, r4, #188416
	mov	r2, #60
	add	r1, r4, #48
	sub	r0, fp, #232
	str	r3, [fp, #-248]
	ldr	ip, [r7, #52]
	add	r8, r4, #200704
	blx	ip
	ldr	r3, [r10, #2368]
	add	r6, r4, #203776
	ldr	ip, [r7, #52]
	add	r9, r6, #904
	sub	r0, fp, #172
	str	r3, [fp, #-240]
	mov	r2, #128
	ldr	r3, [r8, #3972]
	mov	r1, r9
	str	r3, [fp, #-244]
	blx	ip
	ldr	r3, [fp, #-248]
	ldr	r3, [r3, #56]
	cmp	r3, #0
	beq	.L1463
	add	r3, r3, #188416
	ldr	r2, [r3, #2368]
	cmp	r2, #0
	bne	.L1478
.L1463:
	adds	ip, r4, #112
	beq	.L1464
.L1479:
	add	r2, r4, #98304
	ldr	r3, [r2, #116]
	ldr	r1, [r2, #112]
	subs	r1, r3, r1
	addmi	r1, r1, #1024
.L1468:
	mov	r0, ip
	add	r6, r6, #848
	bl	DeleteRawPacket
	mov	r1, #1
	mov	r0, r5
	bl	DeleteRawPacketInBuffer
	movw	r2, #8200
	movt	r2, 3
	ldr	r3, [r7, #48]
	mov	r1, #0
	mov	r0, r4
	blx	r3
	mvn	r2, #0
	mvn	r3, #0
	mov	ip, #2
	strd	r2, [r6]
	sub	r1, fp, #232
	str	ip, [r8, #3956]
	mov	r0, r5
	bl	SM_Config
	ldr	r3, [fp, #-240]
	sub	r1, fp, #172
	mov	r0, r9
	sub	r3, r3, #1
	mov	r2, #128
	cmp	r3, #1
	movls	r3, #1
	movhi	r3, #0
	str	r3, [r10, #2368]
	ldr	r3, [fp, #-244]
	str	r3, [r8, #3972]
	ldr	r3, [r7, #52]
	blx	r3
	mov	r0, #0
.L1476:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1478:
	ldr	r2, [r3, #2356]
	cmp	r2, #0
	movle	r2, #0
	strle	r2, [r3, #2368]
	adds	ip, r4, #112
	bne	.L1479
.L1464:
	ldr	r1, .L1480+8
	movw	r3, #1646
	ldr	r2, .L1480+12
	mov	r0, #22
	str	ip, [fp, #-248]
	bl	dprint_vfmw
	ldr	ip, [fp, #-248]
	mov	r1, ip
	b	.L1468
.L1469:
	mvn	r0, #0
	b	.L1476
.L1477:
	mov	r0, r4
	movw	r2, #1613
	ldr	r1, .L1480+16
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1476
.L1481:
	.align	2
.L1480:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC192
	.word	.LANCHOR3+548
	.word	.LC191
	.fnend
	.size	SM_Reset, .-SM_Reset
	.align	2
	.global	SM_SCDIntServeProc
	.type	SM_SCDIntServeProc, %function
SM_SCDIntServeProc:
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
	subs	r4, r0, #0
	ble	.L1483
	mov	r0, #0
	mov	r3, r4
	str	r0, [sp]
	ldr	r2, .L1521
	ldr	r1, .L1521+4
	bl	dprint_vfmw
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1483:
	ldr	r6, .L1521+8
	mov	r7, r4, asl #2
	ldr	r5, .L1521+12
	mov	r0, #0
	add	r8, r5, r7
	ldr	r3, [r6, #12]
	blx	r3
	ldr	r0, [r8, #4]
	add	r0, r0, #2112
	bl	MEM_ReadPhyWord
	tst	r0, #1
	bne	.L1514
.L1485:
	ldr	r3, .L1521+16
	ldrb	r3, [r3]
	cmp	r3, #1
	beq	.L1503
	mov	r1, r4
	mov	r0, #0
	bl	VDH_Notify_ModuleIdle
.L1503:
	ldr	r3, [r6, #16]
	mov	r0, #0
	blx	r3
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1514:
	ldr	r0, [r8, #4]
	mov	r1, #1
	add	r0, r0, #2080
	add	r0, r0, #4
	bl	MEM_WritePhyWord
	mov	r0, #2
	mov	r3, #1
	str	r3, [r8, #1148]
	bl	CHECK_REC_POS_ENABLE
	cmp	r0, #0
	bne	.L1486
	mov	r10, r4, asl #5
	mov	ip, r4, asl #7
	rsb	r3, r10, ip
	add	r3, r5, r3
	ldr	r3, [r3, #984]
.L1487:
	mov	r2, r3, asl #6
	rsb	r1, r10, ip
	sub	r2, r2, r3, asl #3
	add	r1, r5, r1
	add	r2, r5, r2
	ldr	r0, .L1521+12
	ldr	r9, [r1, #980]
	ldr	r8, [r2, #56]
	cmp	r8, #0
	cmpne	r9, #0
	moveq	r9, #1
	movne	r9, #0
	beq	.L1515
	ldr	r1, .L1521+20
	mov	r2, #84
	mla	r2, r2, r4, r1
	add	r1, r2, #64
	ldr	r0, [r2, #68]
	cmp	r0, #0
	bne	.L1516
.L1490:
	rsb	r2, r10, ip
	add	r2, r5, r2
	ldr	r1, [r2, #988]
	cmp	r1, #1
	beq	.L1517
.L1494:
	add	r8, r8, #200704
	mov	r0, #0
	add	r5, r5, r7
	ldr	r2, [r8, #3968]
	str	r0, [r5, #1148]
	cmp	r2, r0
	beq	.L1502
	ldr	r3, [r6, #124]
	blx	r3
	b	.L1485
.L1515:
	add	r7, r0, r7
	mov	r3, #0
	str	r3, [r1, #988]
	str	r3, [r7, #1148]
	b	.L1485
.L1516:
	ldr	r0, [r6]
	str	ip, [fp, #-72]
	str	r1, [fp, #-68]
	str	r2, [fp, #-64]
	str	r3, [fp, #-60]
	blx	r0
	ldr	r2, [fp, #-64]
	ldr	r1, [fp, #-68]
	ldr	r3, [fp, #-60]
	ldr	lr, [r2, #64]
	ldr	ip, [fp, #-72]
	str	r0, [fp, #-56]
	ldr	r0, [r1, #4]
	add	r1, lr, #49920
	add	r1, r1, #80
	cmp	r1, r0
	ldr	r1, [fp, #-56]
	strcc	r0, [r2, #64]
	movcc	lr, r0
	rsb	r1, lr, r1
	ldr	lr, .L1521+20
	ldrcs	r9, [r2, #72]
	mov	r2, #84
	cmp	r1, #1000
	mla	r2, r2, r4, lr
	ldr	lr, [fp, #-56]
	rsb	r0, r0, lr
	add	r9, r0, r9
	add	lr, r2, #72
	str	lr, [fp, #-56]
	mov	lr, #0
	str	r9, [r2, #72]
	str	lr, [r2, #68]
	bcc	.L1490
	mov	r0, #1000
	str	ip, [fp, #-68]
	mul	r0, r0, r9
	str	r2, [fp, #-64]
	str	r3, [fp, #-60]
	bl	__aeabi_uidiv
	ldr	r2, [fp, #-64]
	mov	r3, #0
	ldr	ip, [fp, #-68]
	str	r3, [r2, #64]
	ldr	r3, [fp, #-56]
	str	r0, [r3, #4]
	ldr	r3, [fp, #-60]
	b	.L1490
.L1486:
	ldr	r3, [r6]
	mov	ip, r4, asl #7
	str	ip, [fp, #-56]
	blx	r3
	ldr	ip, [fp, #-56]
	mov	r10, r4, asl #5
	ldr	r2, .L1521+24
	rsb	r8, r10, ip
	add	r8, r5, r8
	ldr	r1, [r2]
	ldr	r3, [r8, #984]
	add	lr, r5, r3, lsl #2
	ldr	r2, [lr, #1152]
	rsb	r2, r2, r0
	mov	r9, r0
	cmp	r2, r1
	bls	.L1487
	mov	r2, r3, asl #24
	movw	r1, #6078
	add	r2, r2, #131072
	ldr	r0, .L1521+28
	str	r9, [lr, #1152]
	bl	DBG_AddTrace
	ldr	r3, [r8, #984]
	ldr	ip, [fp, #-56]
	b	.L1487
.L1502:
	mov	r0, r3
	bl	SM_GiveThreadEvent
	b	.L1485
.L1517:
	add	r9, r8, #188416
	ldr	r1, [r9, #2368]
	cmp	r1, #1
	beq	.L1518
.L1495:
	mov	r2, #0
	sub	r1, fp, #48
	str	r2, [r9, #2360]
	mov	r0, r4
	str	ip, [fp, #-64]
	str	r3, [fp, #-60]
	str	r2, [fp, #-56]
	bl	SM_DoNextInstance
	ldr	r2, [fp, #-56]
	ldr	r3, [fp, #-60]
	ldr	ip, [fp, #-64]
	cmp	r0, #0
	rsbne	r1, r10, ip
	addne	r1, r5, r1
	strne	r2, [r1, #988]
	bne	.L1494
.L1519:
	rsb	ip, r10, ip
	ldr	r0, [fp, #-48]
	add	r9, r5, ip
	mov	r1, #1
	ldr	r2, [r6]
	str	r0, [r9, #984]
	str	r1, [r9, #988]
	str	r3, [fp, #-56]
	blx	r2
	ldr	r3, [fp, #-56]
	str	r0, [r9, #992]
	b	.L1494
.L1518:
	ldr	r0, [r2, #984]
	mov	r1, #0
	str	ip, [fp, #-64]
	str	r3, [fp, #-60]
	str	r2, [fp, #-56]
	bl	PrintScdRawState
	ldr	r2, [fp, #-56]
	mov	r1, #0
	ldr	r0, [r2, #984]
	bl	PrintScdSegState
	ldr	r2, [fp, #-56]
	mov	r1, #2
	ldr	r0, [r2, #984]
	mov	r2, #0
	bl	DBG_CountTimeInfo
	mov	r1, r4
	mov	r0, r8
	bl	ProcessScdReturn
	ldr	r0, [r8, #88]
	ldr	r3, [fp, #-60]
	cmp	r0, #1
	ldr	ip, [fp, #-64]
	beq	.L1520
.L1497:
	rsb	r2, r10, ip
	mov	r1, #0
	add	r2, r5, r2
	str	r3, [fp, #-64]
	str	ip, [fp, #-60]
	ldr	r0, [r2, #984]
	str	r2, [fp, #-56]
	bl	PrintScdRawState
	ldr	r2, [fp, #-56]
	mov	r1, #0
	ldr	r0, [r2, #984]
	bl	PrintScdSegState
	ldr	r3, [fp, #-64]
	ldr	ip, [fp, #-60]
	b	.L1495
.L1520:
	adds	r2, r8, #112
	beq	.L1498
	add	r1, r8, #98304
	ldr	r2, [r1, #116]
	ldr	r1, [r1, #112]
	subs	r2, r2, r1
	addmi	r2, r2, #1024
.L1504:
	ldrsb	r1, [r8, #2]
	cmp	r1, #1
	bne	.L1497
	ldr	r0, [r8, #92]
	cmp	r0, r2
	bne	.L1497
	mov	r0, r8
	str	ip, [fp, #-64]
	str	r1, [fp, #-60]
	str	r3, [fp, #-56]
	bl	SM_MoveRawData
	ldr	r3, [fp, #-56]
	ldr	r1, [fp, #-60]
	ldr	ip, [fp, #-64]
	cmp	r0, #0
	beq	.L1497
	mov	r0, r1
	ldr	r1, .L1521+32
	str	ip, [fp, #-60]
	bl	dprint_vfmw
	ldr	r0, [r9, #2352]
	bl	SM_Reset
	ldr	ip, [fp, #-60]
	ldr	r3, [fp, #-56]
	b	.L1497
.L1498:
	ldr	r1, .L1521+36
	str	ip, [fp, #-64]
	str	r2, [fp, #-60]
	str	r3, [fp, #-56]
	bl	dprint_vfmw
	ldr	r2, [fp, #-60]
	ldr	r3, [fp, #-56]
	ldr	ip, [fp, #-64]
	b	.L1504
.L1522:
	.align	2
.L1521:
	.word	.LANCHOR3+560
	.word	.LC193
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.word	g_HalDisable
	.word	g_VfmwGlobalStat
	.word	g_TraceBsPeriod
	.word	.LANCHOR3+580
	.word	.LC194
	.word	.LC195
	.fnend
	.size	SM_SCDIntServeProc, .-SM_SCDIntServeProc
	.global	g_pSmIISBase
	.global	g_pScdDrvParamBase
	.global	s_ScdRegResetOKPhyAddr
	.global	s_ScdRegResetPhyAddr
	.global	s_ScdRegPhyBaseAddr
	.global	g_ScdDrvParam
	.global	s_SmIIS
	.global	ForceRelease
	.global	g_hex_flag
	.global	g_hex_len
	.global	g_hex_base_addr
	.global	g_hex_base_vir_addr
	.section	.rodata
	.align	2
.LANCHOR3 = . + 0
	.type	__func__.54930, %object
	.size	__func__.54930, 19
__func__.54930:
	.ascii	"SCDDRV_LoadDspCode\000"
	.space	1
	.type	__func__.55002, %object
	.size	__func__.55002, 16
__func__.55002:
	.ascii	"DeleteRawPacket\000"
	.type	__FUNCTION__.55038, %object
	.size	__FUNCTION__.55038, 17
__FUNCTION__.55038:
	.ascii	"GetRawNumOffsert\000"
	.space	3
	.type	__FUNCTION__.55130, %object
	.size	__FUNCTION__.55130, 17
__FUNCTION__.55130:
	.ascii	"ReleaseStreamSeg\000"
	.space	3
	.type	__func__.55181, %object
	.size	__func__.55181, 18
__func__.55181:
	.ascii	"SM_AllocDSPCtxMem\000"
	.space	2
	.type	__func__.55204, %object
	.size	__func__.55204, 14
__func__.55204:
	.ascii	"SM_OpenSCDDrv\000"
	.space	2
.LC0:
	.byte	0
	.byte	0
	.byte	1
	.byte	30
	.byte	72
	.byte	83
	.byte	80
	.byte	73
	.byte	67
	.byte	69
	.byte	78
	.byte	68
	.byte	0
	.byte	0
	.byte	1
	.byte	30
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	-2
	.byte	72
	.byte	83
	.byte	80
	.byte	73
	.byte	67
	.byte	69
	.byte	78
	.byte	68
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	-2
	.byte	72
	.byte	83
	.byte	80
	.byte	73
	.byte	67
	.byte	69
	.byte	78
	.byte	68
	.byte	0
	.byte	0
	.byte	1
	.byte	-2
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	-70
	.byte	72
	.byte	83
	.byte	80
	.byte	73
	.byte	67
	.byte	69
	.byte	78
	.byte	68
	.byte	0
	.byte	0
	.byte	1
	.byte	-70
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	96
	.byte	0
	.byte	72
	.byte	83
	.byte	80
	.byte	73
	.byte	67
	.byte	69
	.byte	78
	.byte	68
	.byte	0
	.byte	0
	.byte	1
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.type	__func__.55526, %object
	.size	__func__.55526, 17
__func__.55526:
	.ascii	"FillEopRawStream\000"
	.space	3
.LC1:
	.byte	0
	.byte	0
	.byte	1
	.byte	11
	.byte	72
	.byte	83
	.byte	80
	.byte	73
	.byte	67
	.byte	69
	.byte	78
	.byte	68
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	-2
	.byte	72
	.byte	83
	.byte	80
	.byte	73
	.byte	67
	.byte	69
	.byte	78
	.byte	68
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	-2
	.byte	72
	.byte	83
	.byte	80
	.byte	73
	.byte	67
	.byte	69
	.byte	78
	.byte	68
	.byte	0
	.byte	0
	.byte	1
	.byte	-2
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	-73
	.byte	72
	.byte	83
	.byte	80
	.byte	73
	.byte	67
	.byte	69
	.byte	78
	.byte	68
	.byte	0
	.byte	0
	.byte	1
	.byte	-73
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	98
	.byte	0
	.byte	72
	.byte	83
	.byte	80
	.byte	73
	.byte	67
	.byte	69
	.byte	78
	.byte	68
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.type	__func__.55553, %object
	.size	__func__.55553, 17
__func__.55553:
	.ascii	"FillEosRawStream\000"
	.space	3
	.type	__func__.55579, %object
	.size	__func__.55579, 14
__func__.55579:
	.ascii	"FillExtraData\000"
	.space	2
	.type	__func__.55016, %object
	.size	__func__.55016, 24
__func__.55016:
	.ascii	"DeleteRawPacketInBuffer\000"
	.type	__func__.55697, %object
	.size	__func__.55697, 19
__func__.55697:
	.ascii	"SCDDRV_CheckDevice\000"
	.space	1
	.type	__FUNCTION__.55458, %object
	.size	__FUNCTION__.55458, 11
__FUNCTION__.55458:
	.ascii	"GetNextVop\000"
	.space	1
	.type	__FUNCTION__.55497, %object
	.size	__FUNCTION__.55497, 17
__FUNCTION__.55497:
	.ascii	"ProcessScdReturn\000"
	.space	3
	.type	__FUNCTION__.55771, %object
	.size	__FUNCTION__.55771, 17
__FUNCTION__.55771:
	.ascii	"PrintScdRawState\000"
	.space	3
	.type	__FUNCTION__.55515, %object
	.size	__FUNCTION__.55515, 12
__FUNCTION__.55515:
	.ascii	"FillRawData\000"
	.type	__FUNCTION__.55794, %object
	.size	__FUNCTION__.55794, 17
__FUNCTION__.55794:
	.ascii	"PrintScdSegState\000"
	.space	3
	.type	__FUNCTION__.55661, %object
	.size	__FUNCTION__.55661, 18
__FUNCTION__.55661:
	.ascii	"SM_DoNextInstance\000"
	.space	2
	.type	__func__.55703, %object
	.size	__func__.55703, 19
__func__.55703:
	.ascii	"SCDDRV_ActivateSCD\000"
	.space	1
	.type	__func__.55723, %object
	.size	__func__.55723, 10
__func__.55723:
	.ascii	"SM_Wakeup\000"
	.space	2
	.type	__FUNCTION__.55168, %object
	.size	__FUNCTION__.55168, 9
__FUNCTION__.55168:
	.ascii	"SM_Reset\000"
	.space	3
	.type	__func__.55686, %object
	.size	__func__.55686, 19
__func__.55686:
	.ascii	"SM_SCDIntServeProc\000"
	.space	1
	.type	__FUNCTION__.55688, %object
	.size	__FUNCTION__.55688, 19
__FUNCTION__.55688:
	.ascii	"SM_SCDIntServeProc\000"
	.data
	.align	2
.LANCHOR1 = . + 0
.LANCHOR2 = . + 16368
	.type	g_avsp_firmware, %object
	.size	g_avsp_firmware, 17920
g_avsp_firmware:
	.word	0
	.word	16283648
	.word	16349954
	.word	9468936
	.word	-252085482
	.word	9468688
	.word	9468692
	.word	16284426
	.word	9468680
	.word	18807566
	.word	-258442240
	.word	10517258
	.word	18807566
	.word	-258442239
	.word	10517258
	.word	18807566
	.word	-258442238
	.word	10517258
	.word	18807566
	.word	-258442237
	.word	10517258
	.word	18807566
	.word	-258442236
	.word	10517258
	.word	18807566
	.word	-258442235
	.word	10517258
	.word	18807566
	.word	-258442234
	.word	10517258
	.word	18807566
	.word	-258442233
	.word	10517258
	.word	-251200754
	.word	10517258
	.word	17758990
	.word	33128448
	.word	24738824
	.word	-1879048192
	.word	16349954
	.word	0
	.word	18512896
	.word	33390592
	.word	24738817
	.word	-250447311
	.word	9468672
	.word	17988136
	.word	-795837688
	.word	12090128
	.word	18807566
	.word	24967950
	.word	-249398743
	.word	33259520
	.word	554859056
	.word	-258966784
	.word	19561007
	.word	-235307008
	.word	-1063027960
	.word	16349968
	.word	0
	.word	11041536
	.word	0
	.word	1073741824
	.word	33259520
	.word	554859057
	.word	9468672
	.word	0
	.word	-1342177280
	.word	0
	.word	33128448
	.word	-1592624595
	.word	-258966776
	.word	12090128
	.word	0
	.word	17988137
	.word	9468680
	.word	16349968
	.word	17988143
	.word	-258966784
	.word	0
	.word	33521664
	.word	-1879048192
	.word	0
	.word	-1610612736
	.word	-248874449
	.word	9468688
	.word	9468692
	.word	11041536
	.word	0
	.word	0
	.word	0
	.word	286948352
	.word	9467906
	.word	33128448
	.word	-1320519377
	.word	1630697896
	.word	33128448
	.word	-786269183
	.word	17988140
	.word	9468680
	.word	12090128
	.word	21953294
	.word	19400197
	.word	33128448
	.word	-1059883006
	.word	33062912
	.word	-1073741824
	.word	1358526466
	.word	-1342177280
	.word	-1879048192
	.word	17988009
	.word	1620081416
	.word	1354267408
	.word	21953294
	.word	19400216
	.word	33128448
	.word	-2133624830
	.word	33062912
	.word	-2147483648
	.word	-2131134462
	.word	19400222
	.word	33128448
	.word	0
	.word	19036462
	.word	33390592
	.word	33398784
	.word	1092253959
	.word	33128448
	.word	1362626056
	.word	17988013
	.word	9468680
	.word	12090128
	.word	21429006
	.word	1092253999
	.word	33128448
	.word	-250447444
	.word	9468680
	.word	12090128
	.word	24673282
	.word	-250447445
	.word	814775048
	.word	12090128
	.word	0
	.word	-785744896
	.word	556956675
	.word	33128448
	.word	-235298816
	.word	-235290624
	.word	25000964
	.word	-2147483648
	.word	33128448
	.word	-1050147328
	.word	18351619
	.word	18875907
	.word	554858927
	.word	33128448
	.word	-235290624
	.word	-1073741824
	.word	10517258
	.word	9468680
	.word	0
	.word	-1845493760
	.word	23594500
	.word	18875906
	.word	554858927
	.word	33128448
	.word	-1073741824
	.word	10517258
	.word	9468680
	.word	0
	.word	872415232
	.word	-2147483648
	.word	18351646
	.word	24926480
	.word	-2124785392
	.word	-2147483648
	.word	0
	.word	19028272
	.word	20601264
	.word	554858927
	.word	10517258
	.word	546339592
	.word	0
	.word	-268435456
	.word	-1592100601
	.word	12090128
	.word	33128448
	.word	1634207232
	.word	18351619
	.word	18875907
	.word	554859050
	.word	33128448
	.word	-235290624
	.word	-1073741824
	.word	10517258
	.word	9468680
	.word	0
	.word	17988139
	.word	9468680
	.word	0
	.word	-771751936
	.word	23594500
	.word	18875906
	.word	554859050
	.word	33128448
	.word	-1073741824
	.word	10517258
	.word	9468680
	.word	0
	.word	17988139
	.word	9468680
	.word	0
	.word	-1543503872
	.word	1073741824
	.word	18351646
	.word	24926480
	.word	1096440080
	.word	-2147483648
	.word	17988138
	.word	19028272
	.word	20601264
	.word	536870912
	.word	10517258
	.word	9468680
	.word	17988139
	.word	9468680
	.word	0
	.word	-1879048192
	.word	1366850566
	.word	33398784
	.word	17987886
	.word	33398784
	.word	33398784
	.word	-518882770
	.word	9468680
	.word	16349968
	.word	0
	.word	-536870912
	.word	1903720450
	.word	1092093440
	.word	17988010
	.word	9468680
	.word	12090128
	.word	18807566
	.word	33259520
	.word	293436421
	.word	25000967
	.word	-1055753810
	.word	9468680
	.word	12090128
	.word	0
	.word	33460224
	.word	33460224
	.word	33198080
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1011712
	.word	0
	.word	0
	.word	1013760
	.word	18687
	.word	0
	.word	0
	.word	18688
	.word	0
	.word	0
	.word	103084
	.word	0
	.word	0
	.word	102700
	.word	0
	.word	0
	.word	102700
	.word	0
	.word	0
	.word	102700
	.word	0
	.word	0
	.word	102700
	.word	0
	.word	0
	.word	102700
	.word	0
	.word	0
	.word	102700
	.word	0
	.word	0
	.word	102700
	.word	0
	.word	102700
	.word	0
	.word	18432
	.word	916608
	.word	0
	.word	1027074
	.word	0
	.word	1013760
	.word	18432
	.word	916620
	.word	908352
	.word	1027075
	.word	0
	.word	1013760
	.word	105964
	.word	0
	.word	1013760
	.word	0
	.word	1031171
	.word	916484
	.word	1031173
	.word	98348
	.word	1013760
	.word	904428
	.word	1027075
	.word	0
	.word	1013760
	.word	0
	.word	1013760
	.word	1027075
	.word	916484
	.word	1031173
	.word	0
	.word	1013760
	.word	1035269
	.word	1031168
	.word	916712
	.word	1031172
	.word	23807
	.word	0
	.word	1013760
	.word	0
	.word	0
	.word	0
	.word	1013760
	.word	98348
	.word	1013760
	.word	916484
	.word	1031170
	.word	1007616
	.word	1018885
	.word	18687
	.word	0
	.word	0
	.word	0
	.word	1013760
	.word	1018880
	.word	1007616
	.word	18432
	.word	20480
	.word	916688
	.word	1031175
	.word	23552
	.word	916696
	.word	1027078
	.word	0
	.word	0
	.word	0
	.word	1013760
	.word	108112
	.word	917096
	.word	1031174
	.word	917076
	.word	1027078
	.word	25600
	.word	1018887
	.word	23553
	.word	908752
	.word	19456
	.word	22528
	.word	1013760
	.word	108112
	.word	917096
	.word	1031175
	.word	917076
	.word	1027079
	.word	25601
	.word	108108
	.word	917076
	.word	222628
	.word	19456
	.word	917068
	.word	917072
	.word	1027086
	.word	917068
	.word	1027080
	.word	0
	.word	0
	.word	0
	.word	1013760
	.word	23552
	.word	917068
	.word	1027080
	.word	0
	.word	0
	.word	1013760
	.word	1027080
	.word	23552
	.word	0
	.word	1013760
	.word	19457
	.word	20480
	.word	916756
	.word	916908
	.word	916844
	.word	0
	.word	1027083
	.word	917068
	.word	1027082
	.word	105120
	.word	595340
	.word	105112
	.word	916816
	.word	916844
	.word	185196
	.word	0
	.word	0
	.word	1013760
	.word	989193
	.word	105120
	.word	595340
	.word	105112
	.word	916816
	.word	185196
	.word	0
	.word	0
	.word	1013760
	.word	989194
	.word	1018891
	.word	113316
	.word	112296
	.word	1031179
	.word	310092
	.word	113572
	.word	0
	.word	0
	.word	69916
	.word	0
	.word	23552
	.word	1013760
	.word	988170
	.word	23553
	.word	0
	.word	917068
	.word	1027085
	.word	105120
	.word	595340
	.word	105112
	.word	916816
	.word	916844
	.word	185196
	.word	0
	.word	0
	.word	1013760
	.word	0
	.word	0
	.word	1013760
	.word	989195
	.word	105120
	.word	595340
	.word	105112
	.word	916816
	.word	185196
	.word	0
	.word	0
	.word	1013760
	.word	0
	.word	0
	.word	1013760
	.word	989196
	.word	1018894
	.word	113316
	.word	112296
	.word	1031182
	.word	310092
	.word	113572
	.word	0
	.word	0
	.word	69916
	.word	0
	.word	0
	.word	1013760
	.word	0
	.word	1013760
	.word	988173
	.word	19456
	.word	917068
	.word	19456
	.word	917068
	.word	917064
	.word	1027086
	.word	0
	.word	0
	.word	1013760
	.word	1018894
	.word	23552
	.word	1027087
	.word	0
	.word	0
	.word	0
	.word	1013760
	.word	916712
	.word	23556
	.word	0
	.word	1027087
	.word	0
	.word	0
	.word	1013760
	.word	999424
	.word	999424
	.word	999424
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	65537
	.word	1900544
	.word	513
	.word	1537
	.word	352782197
	.word	352782197
	.word	65536
	.word	131074
	.word	4
	.word	0
	.word	65537
	.word	131073
	.word	131074
	.word	131074
	.word	131074
	.word	131074
	.word	131074
	.word	131074
	.word	131074
	.word	131074
	.word	2
	.word	327686
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	131072
	.word	1
	.word	131072
	.word	1
	.word	0
	.word	0
	.word	0
	.word	0
	.word	65538
	.word	1
	.word	0
	.word	0
	.word	131072
	.word	131073
	.word	131073
	.word	1
	.word	131072
	.word	1
	.word	131072
	.word	131073
	.word	131073
	.word	1
	.word	0
	.word	0
	.word	2
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	3
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	524289
	.word	4196352
	.word	1048608
	.word	8396800
	.word	0
	.word	0
	.word	0
	.word	0
	.word	65536
	.word	0
	.word	65536
	.word	1
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	65536
	.word	65537
	.word	65537
	.word	1
	.word	65536
	.word	1
	.word	65536
	.word	1
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	131073
	.word	33554688
	.word	1073741828
	.word	132096
	.word	65540
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.type	g_h264_firmware, %object
	.size	g_h264_firmware, 17920
g_h264_firmware:
	.word	0
	.word	823064910
	.word	8419328
	.word	9239400
	.word	16349184
	.word	285670144
	.word	33128448
	.word	-1879048192
	.word	1342177280
	.word	0
	.word	8420384
	.word	8420386
	.word	8420387
	.word	8420388
	.word	8420389
	.word	8420390
	.word	8420391
	.word	8420393
	.word	8420394
	.word	8420395
	.word	8420392
	.word	8420396
	.word	8715424
	.word	8715428
	.word	8682668
	.word	8682542
	.word	8682671
	.word	268435456
	.word	8420385
	.word	-1342177280
	.word	24673452
	.word	-268435456
	.word	24673326
	.word	1610612736
	.word	17234198
	.word	0
	.word	-2130020076
	.word	33259520
	.word	1610612736
	.word	1091206148
	.word	33259520
	.word	1610612736
	.word	17234274
	.word	822770726
	.word	33259520
	.word	1610612736
	.word	33325056
	.word	1610612736
	.word	-1342177280
	.word	16349184
	.word	286194442
	.word	805306368
	.word	0
	.word	33128448
	.word	-2147483648
	.word	268435456
	.word	16349184
	.word	277150492
	.word	9239324
	.word	805306368
	.word	8419328
	.word	0
	.word	805306368
	.word	8419328
	.word	17234796
	.word	17758530
	.word	0
	.word	-268435456
	.word	1342177280
	.word	-235044864
	.word	1628371250
	.word	0
	.word	17464358
	.word	0
	.word	-235044864
	.word	1610612736
	.word	0
	.word	536870912
	.word	1610612736
	.word	24673326
	.word	-536870912
	.word	17234200
	.word	0
	.word	-2130020076
	.word	33259520
	.word	1610612736
	.word	1091206148
	.word	33259520
	.word	1610612736
	.word	17234274
	.word	822770726
	.word	33259520
	.word	1610612736
	.word	33325056
	.word	1610612736
	.word	-1342177280
	.word	16349184
	.word	286194442
	.word	805306368
	.word	0
	.word	33128448
	.word	1879048192
	.word	0
	.word	16349184
	.word	277150492
	.word	9239324
	.word	805306368
	.word	8419328
	.word	0
	.word	805306368
	.word	8419328
	.word	17234796
	.word	17758530
	.word	0
	.word	-268435456
	.word	1342177280
	.word	-235044864
	.word	1628371250
	.word	0
	.word	17464358
	.word	0
	.word	-235044864
	.word	-536870912
	.word	268435456
	.word	536870912
	.word	1610612736
	.word	24673455
	.word	1610612736
	.word	24935457
	.word	1610612736
	.word	24706208
	.word	1610612736
	.word	0
	.word	536870912
	.word	16349184
	.word	17758488
	.word	8715034
	.word	9239322
	.word	0
	.word	17234228
	.word	17758984
	.word	17758980
	.word	268435456
	.word	0
	.word	-234913792
	.word	1342177280
	.word	21428994
	.word	23525654
	.word	21952790
	.word	20904718
	.word	17758520
	.word	0
	.word	17234288
	.word	18282794
	.word	18807142
	.word	-2147483648
	.word	19331382
	.word	17235072
	.word	18283652
	.word	0
	.word	8715418
	.word	0
	.word	9763996
	.word	33325056
	.word	-1610612736
	.word	18282774
	.word	824113430
	.word	9239710
	.word	17235098
	.word	1610612736
	.word	16349184
	.word	9239710
	.word	17235098
	.word	17758988
	.word	0
	.word	805306368
	.word	17235098
	.word	18283278
	.word	18807964
	.word	0
	.word	805306368
	.word	18283278
	.word	-1073741824
	.word	268435456
	.word	17988648
	.word	286194026
	.word	33128448
	.word	-1879048192
	.word	33128448
	.word	-1861813906
	.word	33128448
	.word	822540652
	.word	33128448
	.word	-536870912
	.word	0
	.word	-1073741824
	.word	24673280
	.word	805306368
	.word	16349184
	.word	17234704
	.word	19037185
	.word	-2129725162
	.word	18282848
	.word	18807144
	.word	-2147483648
	.word	805306368
	.word	805306368
	.word	24673296
	.word	805306368
	.word	16349184
	.word	17234706
	.word	19037201
	.word	-2129725088
	.word	18282848
	.word	18807144
	.word	-2147483648
	.word	805306368
	.word	17235098
	.word	17759388
	.word	18283678
	.word	8715424
	.word	9239714
	.word	9764004
	.word	14711981
	.word	822609409
	.word	17827328
	.word	1879048192
	.word	21952864
	.word	-2147483648
	.word	16349184
	.word	17234228
	.word	17758984
	.word	0
	.word	17758980
	.word	268435456
	.word	33062912
	.word	-2147483648
	.word	-235175936
	.word	0
	.word	-235110400
	.word	-2147483648
	.word	16349184
	.word	17234288
	.word	17758978
	.word	18282782
	.word	18807142
	.word	-2147483648
	.word	16349184
	.word	20904718
	.word	17758520
	.word	0
	.word	19331382
	.word	17235072
	.word	0
	.word	0
	.word	8715420
	.word	16349184
	.word	17235100
	.word	17758982
	.word	0
	.word	17758988
	.word	33259520
	.word	-805306368
	.word	17235100
	.word	17758982
	.word	805306368
	.word	18282774
	.word	18807062
	.word	1879048192
	.word	17235100
	.word	17758988
	.word	0
	.word	0
	.word	805306368
	.word	17235100
	.word	18283278
	.word	18807558
	.word	0
	.word	805306368
	.word	-1073741824
	.word	268435456
	.word	17988648
	.word	286194026
	.word	33128448
	.word	1073741824
	.word	33128448
	.word	1073741824
	.word	822609409
	.word	17827328
	.word	1879048192
	.word	0
	.word	8420524
	.word	24706208
	.word	-2147483648
	.word	17759396
	.word	33521664
	.word	-536870912
	.word	17235104
	.word	17759396
	.word	18282774
	.word	18807062
	.word	-1879048192
	.word	16349184
	.word	17235104
	.word	17758988
	.word	0
	.word	805306368
	.word	17235104
	.word	18283278
	.word	18807970
	.word	0
	.word	805306368
	.word	18283278
	.word	-1073741824
	.word	268435456
	.word	17988648
	.word	286194026
	.word	33390592
	.word	0
	.word	536870912
	.word	33390592
	.word	-2147483648
	.word	268435456
	.word	1879048192
	.word	268435456
	.word	268435456
	.word	8420524
	.word	0
	.word	0
	.word	8420398
	.word	0
	.word	16349184
	.word	17234708
	.word	8715430
	.word	17758498
	.word	0
	.word	8715432
	.word	17758488
	.word	18807562
	.word	1073741824
	.word	0
	.word	805306368
	.word	8419328
	.word	16940070
	.word	17758514
	.word	0
	.word	-250676968
	.word	-268435456
	.word	1342177280
	.word	17758488
	.word	-268435456
	.word	1610612736
	.word	0
	.word	-268435456
	.word	-268435456
	.word	268435456
	.word	0
	.word	8715104
	.word	268435456
	.word	-536870912
	.word	8715106
	.word	16349184
	.word	17234708
	.word	805306368
	.word	10516480
	.word	8715108
	.word	17235088
	.word	8715110
	.word	17234214
	.word	8715120
	.word	17234244
	.word	8715118
	.word	16940060
	.word	-268435456
	.word	-805306368
	.word	17464339
	.word	-268435456
	.word	-1073741824
	.word	17464340
	.word	-268435456
	.word	-1323894504
	.word	17464322
	.word	0
	.word	-268435456
	.word	-1610612736
	.word	17464324
	.word	-268435456
	.word	268435456
	.word	24673285
	.word	-2147483648
	.word	17758486
	.word	805306368
	.word	24673316
	.word	-512197595
	.word	-1055983330
	.word	805306368
	.word	17758488
	.word	805306368
	.word	24673286
	.word	286193958
	.word	805306368
	.word	17758486
	.word	805306368
	.word	-536870912
	.word	17464323
	.word	0
	.word	8715328
	.word	17235110
	.word	18282776
	.word	18807144
	.word	-2147483648
	.word	16349184
	.word	17234710
	.word	8715330
	.word	1090976934
	.word	0
	.word	286718232
	.word	18807144
	.word	-2147483648
	.word	17235112
	.word	8715332
	.word	1090976934
	.word	0
	.word	555153688
	.word	18807144
	.word	-2147483648
	.word	16349184
	.word	17234712
	.word	8715334
	.word	-2130248538
	.word	0
	.word	823589144
	.word	18807144
	.word	-2147483648
	.word	17235090
	.word	8715336
	.word	16940202
	.word	8715338
	.word	17235092
	.word	33259520
	.word	-1610612736
	.word	0
	.word	8715340
	.word	17235094
	.word	8715342
	.word	16940203
	.word	8715344
	.word	17235096
	.word	33259520
	.word	805306368
	.word	0
	.word	8715346
	.word	-1593672675
	.word	17464365
	.word	0
	.word	-268435456
	.word	-1342177280
	.word	822770723
	.word	0
	.word	-268435456
	.word	-1879048192
	.word	17464353
	.word	0
	.word	8715348
	.word	-251495381
	.word	0
	.word	-268435456
	.word	1628077098
	.word	0
	.word	-268435456
	.word	268435456
	.word	17464327
	.word	-536870912
	.word	17464354
	.word	18807064
	.word	33128448
	.word	0
	.word	33128448
	.word	536870912
	.word	1091500310
	.word	268435456
	.word	1073741824
	.word	536870912
	.word	1073741824
	.word	0
	.word	8715350
	.word	17235112
	.word	1092024672
	.word	18807144
	.word	-2147483648
	.word	16940070
	.word	17758514
	.word	0
	.word	-268435456
	.word	8715352
	.word	17235112
	.word	0
	.word	-1055459048
	.word	18807144
	.word	-2147483648
	.word	0
	.word	8715354
	.word	-1056506712
	.word	0
	.word	-787023592
	.word	18807144
	.word	-2147483648
	.word	0
	.word	554173952
	.word	17827336
	.word	1879048192
	.word	-251200684
	.word	0
	.word	8420526
	.word	822609408
	.word	17827352
	.word	1879048192
	.word	-1073741824
	.word	11566081
	.word	-250446847
	.word	33325056
	.word	-805306368
	.word	17988609
	.word	33325056
	.word	-805306368
	.word	20085934
	.word	554203411
	.word	33128448
	.word	0
	.word	33128448
	.word	0
	.word	-2130151150
	.word	33128448
	.word	0
	.word	33128448
	.word	0
	.word	-519538416
	.word	33128448
	.word	0
	.word	33128448
	.word	16808209
	.word	33128448
	.word	0
	.word	-805306368
	.word	1091074311
	.word	33128448
	.word	-1342177280
	.word	33128448
	.word	-1342177280
	.word	-1593280239
	.word	33128448
	.word	-1342177280
	.word	33128448
	.word	-1342177280
	.word	-805306368
	.word	-1073741824
	.word	11566082
	.word	17827329
	.word	0
	.word	0
	.word	33390592
	.word	-805306368
	.word	-1073741824
	.word	0
	.word	33390592
	.word	-805306368
	.word	-1073741824
	.word	0
	.word	33390592
	.word	-805306368
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	0
	.word	33390592
	.word	-805306368
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	268435456
	.word	33390592
	.word	-268435456
	.word	0
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566254
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	24673454
	.word	-1073741824
	.word	-2128083448
	.word	0
	.word	0
	.word	33128448
	.word	805306368
	.word	-805306368
	.word	18282786
	.word	0
	.word	17758564
	.word	0
	.word	0
	.word	33128448
	.word	1879048192
	.word	0
	.word	286193948
	.word	0
	.word	33062912
	.word	-1073741824
	.word	-1342177280
	.word	-234881024
	.word	0
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566254
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	24673454
	.word	-1342177280
	.word	-2128083448
	.word	0
	.word	0
	.word	33128448
	.word	536870912
	.word	-805306368
	.word	18282786
	.word	0
	.word	17758564
	.word	0
	.word	0
	.word	33128448
	.word	1610612736
	.word	0
	.word	286193964
	.word	0
	.word	33062912
	.word	-1342177280
	.word	-1610612736
	.word	-536870912
	.word	-268435456
	.word	268435456
	.word	8420354
	.word	-1073741824
	.word	11566088
	.word	-1073741824
	.word	33259520
	.word	1342177280
	.word	-805306368
	.word	-1073741824
	.word	11566089
	.word	0
	.word	33128448
	.word	268435456
	.word	268435456
	.word	33128448
	.word	1879048192
	.word	536870912
	.word	33128448
	.word	-805306368
	.word	-805306368
	.word	-1073741824
	.word	11566091
	.word	-1073741824
	.word	33521664
	.word	-805306368
	.word	-805306368
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	17234772
	.word	8420362
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	1879048192
	.word	1879048192
	.word	-1073741824
	.word	11566254
	.word	-268435456
	.word	33259520
	.word	-805306368
	.word	0
	.word	33521664
	.word	-805306368
	.word	16940206
	.word	0
	.word	1879048192
	.word	-1342177280
	.word	-1073741824
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	-1073741824
	.word	11566083
	.word	286193960
	.word	33325056
	.word	-805306368
	.word	33062912
	.word	-805306368
	.word	-1073741824
	.word	11566084
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566085
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	0
	.word	33128448
	.word	1610612736
	.word	-2147483648
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566086
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	286193946
	.word	20085764
	.word	33325056
	.word	-805306368
	.word	33062912
	.word	-805306368
	.word	825392131
	.word	33325056
	.word	-805306368
	.word	0
	.word	0
	.word	8420358
	.word	286193956
	.word	20085764
	.word	33325056
	.word	-805306368
	.word	33062912
	.word	-805306368
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566087
	.word	24673455
	.word	-805306368
	.word	822609409
	.word	17827329
	.word	1879048192
	.word	268435456
	.word	8420352
	.word	0
	.word	822609409
	.word	17827328
	.word	1879048192
	.word	0
	.word	8420352
	.word	0
	.word	-1073741824
	.word	11566097
	.word	17827583
	.word	33325056
	.word	-1342177280
	.word	33259520
	.word	-1342177280
	.word	-1073741824
	.word	11566098
	.word	17827359
	.word	33325056
	.word	-1342177280
	.word	33259520
	.word	-1342177280
	.word	16349184
	.word	286194442
	.word	805306368
	.word	0
	.word	33128448
	.word	-2147483648
	.word	268435456
	.word	16349184
	.word	17758992
	.word	19037202
	.word	-2130249450
	.word	18282848
	.word	18807142
	.word	-2147483648
	.word	24935424
	.word	-1342177280
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566099
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566101
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	-1073741824
	.word	0
	.word	33390592
	.word	-1342177280
	.word	-1073741824
	.word	11566103
	.word	-268435456
	.word	33259520
	.word	-1342177280
	.word	-1073741824
	.word	11566104
	.word	-268435456
	.word	33259520
	.word	-1342177280
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566106
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	554173952
	.word	17827330
	.word	1879048192
	.word	20380500
	.word	11566107
	.word	822609408
	.word	17827330
	.word	1879048192
	.word	805306368
	.word	33062912
	.word	-1342177280
	.word	-805306368
	.word	11566109
	.word	-805306368
	.word	-805306368
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566105
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566100
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566102
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	17234198
	.word	8420380
	.word	822541470
	.word	17759062
	.word	0
	.word	33521664
	.word	805306368
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566108
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	24935452
	.word	805306368
	.word	0
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	33390592
	.word	268435456
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	17235102
	.word	17759062
	.word	33521664
	.word	-536870912
	.word	-268435456
	.word	0
	.word	8420380
	.word	805306368
	.word	268435456
	.word	8420380
	.word	24673455
	.word	-1342177280
	.word	822609409
	.word	17827328
	.word	1879048192
	.word	268435456
	.word	8420368
	.word	0
	.word	822609409
	.word	17827328
	.word	1879048192
	.word	0
	.word	8420368
	.word	0
	.word	-1073741824
	.word	11566113
	.word	17758528
	.word	33062912
	.word	268435456
	.word	-1073741824
	.word	536870912
	.word	33128448
	.word	1610612736
	.word	1073741824
	.word	33128448
	.word	1610612736
	.word	1879048192
	.word	33128448
	.word	1610612736
	.word	-1879048192
	.word	33128448
	.word	1610612736
	.word	0
	.word	33128448
	.word	-1879048192
	.word	805306368
	.word	33128448
	.word	-1879048192
	.word	1342177280
	.word	33128448
	.word	-1879048192
	.word	-2147483648
	.word	33128448
	.word	-1879048192
	.word	268435456
	.word	33128448
	.word	-1073741824
	.word	1610612736
	.word	33128448
	.word	-1073741824
	.word	268435456
	.word	536870912
	.word	8944674
	.word	-536870912
	.word	0
	.word	8944674
	.word	-536870912
	.word	268435456
	.word	8944674
	.word	-1073741824
	.word	11566112
	.word	-268435456
	.word	33259520
	.word	268435456
	.word	16349184
	.word	286194442
	.word	805306368
	.word	0
	.word	33128448
	.word	-1610612736
	.word	805306368
	.word	16349184
	.word	17758994
	.word	19037216
	.word	-2130249376
	.word	18282848
	.word	18807142
	.word	-2147483648
	.word	24935440
	.word	268435456
	.word	16349184
	.word	17758992
	.word	19037202
	.word	-2130249450
	.word	18282848
	.word	18807142
	.word	-2147483648
	.word	24935424
	.word	268435456
	.word	822609408
	.word	1092254728
	.word	0
	.word	1879048192
	.word	0
	.word	8420388
	.word	8420389
	.word	24673285
	.word	1879048192
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566116
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	24673316
	.word	1879048192
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566117
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	16940035
	.word	17464324
	.word	-268435456
	.word	-268435456
	.word	-2147483648
	.word	8420390
	.word	24673285
	.word	-1610612736
	.word	24673316
	.word	-1610612736
	.word	554335270
	.word	-2147483648
	.word	8420390
	.word	554335236
	.word	-268435456
	.word	-2147483648
	.word	268435456
	.word	0
	.word	8420356
	.word	285375524
	.word	17464326
	.word	0
	.word	8420391
	.word	1359641640
	.word	33390592
	.word	1342177280
	.word	-1073741824
	.word	17758528
	.word	33259520
	.word	268435456
	.word	17464329
	.word	33390592
	.word	536870912
	.word	822609408
	.word	1092254731
	.word	0
	.word	1879048192
	.word	16940053
	.word	285899812
	.word	0
	.word	33521664
	.word	536870912
	.word	1879048192
	.word	16940041
	.word	285899786
	.word	0
	.word	33521664
	.word	-536870912
	.word	1879048192
	.word	16940053
	.word	285899812
	.word	0
	.word	33521664
	.word	-536870912
	.word	1879048192
	.word	24935446
	.word	1073741824
	.word	-1073741824
	.word	0
	.word	33259520
	.word	268435456
	.word	285899810
	.word	33390592
	.word	-536870912
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	17234772
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	16940055
	.word	17464344
	.word	8420394
	.word	8944683
	.word	554335266
	.word	33128448
	.word	1610612736
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566121
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	24935465
	.word	1610612736
	.word	-1073741824
	.word	11566122
	.word	285899810
	.word	33390592
	.word	1610612736
	.word	-1073741824
	.word	11566123
	.word	554335266
	.word	33390592
	.word	-1342177280
	.word	0
	.word	8420394
	.word	285899810
	.word	33128448
	.word	0
	.word	0
	.word	8420395
	.word	554335266
	.word	33390592
	.word	1073741824
	.word	1610612736
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566254
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	24935598
	.word	1610612736
	.word	0
	.word	554335274
	.word	0
	.word	-1073741824
	.word	805306368
	.word	33259520
	.word	268435456
	.word	805306368
	.word	33128448
	.word	1610612736
	.word	0
	.word	33128448
	.word	536870912
	.word	268435456
	.word	33128448
	.word	536870912
	.word	536870912
	.word	33128448
	.word	1073741824
	.word	1342177280
	.word	1879048192
	.word	1342177280
	.word	1879048192
	.word	268435456
	.word	285899810
	.word	33390592
	.word	-1342177280
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566254
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	24935598
	.word	-1342177280
	.word	0
	.word	554335275
	.word	0
	.word	-1073741824
	.word	805306368
	.word	33259520
	.word	268435456
	.word	805306368
	.word	33128448
	.word	-1342177280
	.word	0
	.word	33128448
	.word	1879048192
	.word	268435456
	.word	33128448
	.word	1879048192
	.word	536870912
	.word	33128448
	.word	-1879048192
	.word	-1610612736
	.word	1879048192
	.word	-1610612736
	.word	1879048192
	.word	1610612736
	.word	17464354
	.word	286948379
	.word	33390592
	.word	293108762
	.word	-2147483648
	.word	1879048192
	.word	17464354
	.word	33390592
	.word	1879048192
	.word	-235044864
	.word	1879048192
	.word	-2147483648
	.word	536870912
	.word	-1073741824
	.word	24673282
	.word	-1073741824
	.word	-1073741824
	.word	17464362
	.word	268435456
	.word	0
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566254
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	24673454
	.word	-1342177280
	.word	-805306368
	.word	-805306368
	.word	24673282
	.word	-1342177280
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566254
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	24673454
	.word	-1342177280
	.word	-805306368
	.word	-805306368
	.word	-805306368
	.word	-805306368
	.word	-268435456
	.word	285899810
	.word	17988635
	.word	33390592
	.word	536870912
	.word	-235044864
	.word	536870912
	.word	17464363
	.word	268435456
	.word	0
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566254
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	24673454
	.word	268435456
	.word	-805306368
	.word	-805306368
	.word	24673282
	.word	268435456
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566254
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	24673454
	.word	268435456
	.word	-805306368
	.word	-805306368
	.word	-805306368
	.word	-805306368
	.word	1342177280
	.word	24673324
	.word	-536870912
	.word	1359641640
	.word	33390592
	.word	-1342177280
	.word	822609408
	.word	17827330
	.word	1879048192
	.word	-536870912
	.word	554173952
	.word	17827329
	.word	1879048192
	.word	20380500
	.word	11566254
	.word	822609408
	.word	17827329
	.word	1879048192
	.word	24673454
	.word	-536870912
	.word	-1073741824
	.word	11566254
	.word	268435456
	.word	33128448
	.word	1879048192
	.word	536870912
	.word	33128448
	.word	1879048192
	.word	1073741824
	.word	33128448
	.word	1879048192
	.word	1610612736
	.word	33128448
	.word	1879048192
	.word	805306368
	.word	33128448
	.word	-1879048192
	.word	-1342177280
	.word	-1073741824
	.word	-1342177280
	.word	-1073741824
	.word	-1073741824
	.word	16940206
	.word	33259520
	.word	1342177280
	.word	24673299
	.word	-1073741824
	.word	16940066
	.word	33128448
	.word	1879048192
	.word	268435456
	.word	33128448
	.word	1879048192
	.word	-1073741824
	.word	-1073741824
	.word	11566115
	.word	805306368
	.word	33062912
	.word	268435456
	.word	-805306368
	.word	11566125
	.word	24935449
	.word	-1879048192
	.word	-1073741824
	.word	536870912
	.word	33259520
	.word	268435456
	.word	17827329
	.word	33128448
	.word	-1879048192
	.word	-805306368
	.word	-805306368
	.word	24673455
	.word	268435456
	.word	822609409
	.word	17827328
	.word	1879048192
	.word	268435456
	.word	8420398
	.word	0
	.word	822609409
	.word	17827328
	.word	1879048192
	.word	0
	.word	8420398
	.word	0
	.word	1073741824
	.word	9992192
	.word	-2147483648
	.word	-1610612736
	.word	-268435456
	.word	268435456
	.word	0
	.word	17827329
	.word	0
	.word	8715072
	.word	0
	.word	286194520
	.word	-268435456
	.word	-536870912
	.word	18282776
	.word	33128448
	.word	-1879048192
	.word	-1342177280
	.word	268435456
	.word	8420527
	.word	0
	.word	1073741824
	.word	11565056
	.word	19331386
	.word	20379926
	.word	33390592
	.word	-536870912
	.word	20379926
	.word	11336516
	.word	11860806
	.word	19855676
	.word	0
	.word	805306368
	.word	11336520
	.word	9239370
	.word	9763660
	.word	11860814
	.word	10287952
	.word	-536870912
	.word	20379926
	.word	11336516
	.word	0
	.word	0
	.word	11336518
	.word	19855676
	.word	0
	.word	805306368
	.word	11336520
	.word	9239370
	.word	11860812
	.word	19855676
	.word	0
	.word	805306368
	.word	11336526
	.word	10287952
	.word	268435456
	.word	8715074
	.word	0
	.word	1073741824
	.word	11565056
	.word	823064854
	.word	18282784
	.word	1879048192
	.word	554629398
	.word	18282848
	.word	1879048192
	.word	-251200684
	.word	17758502
	.word	1342177280
	.word	9468968
	.word	9993260
	.word	823064854
	.word	18282848
	.word	1879048192
	.word	0
	.word	0
	.word	33390592
	.word	-1342177280
	.word	16349184
	.word	-2129724670
	.word	18906285
	.word	-2130249360
	.word	18282782
	.word	18807142
	.word	-2147483648
	.word	17235074
	.word	17758488
	.word	-268435456
	.word	-268435456
	.word	268435456
	.word	0
	.word	8715394
	.word	16349184
	.word	-2130248958
	.word	18906285
	.word	-2129725072
	.word	18282782
	.word	18807144
	.word	-2147483648
	.word	1879048192
	.word	16349184
	.word	-2129724670
	.word	19331848
	.word	-268435456
	.word	-2130249360
	.word	18282782
	.word	18807142
	.word	-2147483648
	.word	16349184
	.word	17234694
	.word	17759362
	.word	0
	.word	9239686
	.word	17234694
	.word	17759360
	.word	18283276
	.word	33259520
	.word	-536870912
	.word	805306368
	.word	17235072
	.word	17758988
	.word	18283270
	.word	18283278
	.word	0
	.word	9239684
	.word	17235074
	.word	17758488
	.word	-268435456
	.word	-268435456
	.word	268435456
	.word	0
	.word	8715394
	.word	16349184
	.word	-2130248958
	.word	19331848
	.word	-268435456
	.word	-2129725072
	.word	18282794
	.word	18807144
	.word	-2147483648
	.word	16349184
	.word	287767304
	.word	0
	.word	8715016
	.word	0
	.word	536870912
	.word	10516480
	.word	8715042
	.word	277674784
	.word	546634532
	.word	33128448
	.word	1073741824
	.word	33128448
	.word	-2147483648
	.word	33128448
	.word	-1073741824
	.word	-268435456
	.word	268435456
	.word	8715046
	.word	0
	.word	-268435456
	.word	268435456
	.word	8715048
	.word	0
	.word	-268435456
	.word	268435456
	.word	8715050
	.word	0
	.word	0
	.word	1073741824
	.word	11565056
	.word	20380502
	.word	24935443
	.word	-1879048192
	.word	1898379590
	.word	0
	.word	0
	.word	0
	.word	16349184
	.word	0
	.word	33390592
	.word	-1879048192
	.word	17235104
	.word	17759394
	.word	33259520
	.word	1610612736
	.word	17235104
	.word	17758988
	.word	0
	.word	805306368
	.word	33259520
	.word	1610612736
	.word	9763988
	.word	19331386
	.word	18283278
	.word	0
	.word	9763984
	.word	17235104
	.word	19331386
	.word	0
	.word	19855676
	.word	0
	.word	0
	.word	825162046
	.word	0
	.word	0
	.word	805306368
	.word	11336850
	.word	19855662
	.word	0
	.word	11041962
	.word	0
	.word	10288278
	.word	19331388
	.word	18283278
	.word	0
	.word	805306368
	.word	9993387
	.word	17759394
	.word	0
	.word	805306368
	.word	10288280
	.word	1342177280
	.word	19331386
	.word	18283278
	.word	0
	.word	9763984
	.word	17235104
	.word	17758988
	.word	0
	.word	805306368
	.word	0
	.word	17234236
	.word	17758990
	.word	0
	.word	805306368
	.word	0
	.word	19855678
	.word	0
	.word	805306368
	.word	10288274
	.word	19855662
	.word	0
	.word	9993386
	.word	17234702
	.word	17759394
	.word	0
	.word	805306368
	.word	0
	.word	10288276
	.word	0
	.word	10288278
	.word	9993387
	.word	10288280
	.word	-1073741824
	.word	17235104
	.word	17759396
	.word	-1879048192
	.word	17235100
	.word	17758982
	.word	18283276
	.word	33259520
	.word	1342177280
	.word	17235100
	.word	17758988
	.word	0
	.word	805306368
	.word	33259520
	.word	805306368
	.word	9763988
	.word	19331386
	.word	18283278
	.word	0
	.word	9763984
	.word	17235100
	.word	19331386
	.word	0
	.word	19855676
	.word	0
	.word	0
	.word	825162046
	.word	0
	.word	0
	.word	805306368
	.word	11336850
	.word	19855662
	.word	0
	.word	11041962
	.word	0
	.word	10288278
	.word	19331388
	.word	18283278
	.word	0
	.word	805306368
	.word	9993387
	.word	17758982
	.word	823590036
	.word	0
	.word	10288280
	.word	1073741824
	.word	19331386
	.word	18283278
	.word	0
	.word	9763984
	.word	17235100
	.word	17758988
	.word	0
	.word	805306368
	.word	0
	.word	17234236
	.word	17758990
	.word	0
	.word	805306368
	.word	0
	.word	19855678
	.word	0
	.word	805306368
	.word	10288274
	.word	19855662
	.word	0
	.word	9993386
	.word	17234694
	.word	17759388
	.word	18283276
	.word	0
	.word	0
	.word	805306368
	.word	0
	.word	10288276
	.word	0
	.word	10288278
	.word	9993387
	.word	10288280
	.word	-1073741824
	.word	17235100
	.word	17758982
	.word	805306368
	.word	-1879048192
	.word	19331386
	.word	0
	.word	10288272
	.word	19331388
	.word	0
	.word	805306368
	.word	19331374
	.word	0
	.word	11041962
	.word	0
	.word	9239700
	.word	19331390
	.word	0
	.word	805306368
	.word	11336850
	.word	0
	.word	10288278
	.word	9993387
	.word	10288280
	.word	0
	.word	1090520577
	.word	9992192
	.word	-2147483648
	.word	-1610612736
	.word	17827329
	.word	0
	.word	8715072
	.word	0
	.word	17758538
	.word	20380498
	.word	18807090
	.word	0
	.word	33128448
	.word	-1055983284
	.word	0
	.word	286194514
	.word	-268435456
	.word	-805306368
	.word	18282776
	.word	33128448
	.word	-1879048192
	.word	286194520
	.word	-268435456
	.word	-536870912
	.word	18282776
	.word	33128448
	.word	-1879048192
	.word	-1342177280
	.word	268435456
	.word	8420527
	.word	0
	.word	1090520576
	.word	9992192
	.word	-2147483648
	.word	-1610612736
	.word	17827329
	.word	0
	.word	8715072
	.word	0
	.word	17234226
	.word	20380498
	.word	0
	.word	286194514
	.word	-268435456
	.word	-805306368
	.word	18282776
	.word	33128448
	.word	1073741824
	.word	286194520
	.word	-268435456
	.word	-536870912
	.word	18282776
	.word	33128448
	.word	1073741824
	.word	1610612736
	.word	268435456
	.word	8420527
	.word	0
	.word	18875904
	.word	0
	.word	1091044864
	.word	546863104
	.word	17827332
	.word	-2147483648
	.word	-1610612736
	.word	-268435456
	.word	268435456
	.word	0
	.word	17827329
	.word	0
	.word	8715072
	.word	0
	.word	17234772
	.word	0
	.word	17455440
	.word	16778756
	.word	33390592
	.word	-1342177280
	.word	1091044864
	.word	815298560
	.word	17827332
	.word	-2147483648
	.word	-1610612736
	.word	-268435456
	.word	268435456
	.word	0
	.word	17827329
	.word	0
	.word	8715072
	.word	0
	.word	17303041
	.word	17827336
	.word	33325056
	.word	-1879048192
	.word	17303072
	.word	33062912
	.word	268435456
	.word	285738497
	.word	18351620
	.word	-2147483648
	.word	0
	.word	17827352
	.word	33062912
	.word	1073741824
	.word	17303064
	.word	0
	.word	1091044864
	.word	815298560
	.word	17827352
	.word	-2147483648
	.word	-1610612736
	.word	-268435456
	.word	268435456
	.word	0
	.word	17827329
	.word	0
	.word	8715072
	.word	0
	.word	536870912
	.word	1091044864
	.word	815298560
	.word	0
	.word	-2147483648
	.word	-1610612736
	.word	-268435456
	.word	268435456
	.word	0
	.word	17827329
	.word	0
	.word	8715072
	.word	0
	.word	-536870912
	.word	1091044864
	.word	815298560
	.word	-2147483648
	.word	0
	.word	-2147483648
	.word	-1610612736
	.word	-268435456
	.word	268435456
	.word	0
	.word	17827329
	.word	0
	.word	8715072
	.word	0
	.word	286194520
	.word	-268435456
	.word	-536870912
	.word	18282776
	.word	33128448
	.word	1342177280
	.word	1879048192
	.word	268435456
	.word	8420527
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1011712
	.word	16384
	.word	0
	.word	0
	.word	0
	.word	17408
	.word	916484
	.word	1031168
	.word	1018880
	.word	16384
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035272
	.word	0
	.word	1031172
	.word	0
	.word	1027080
	.word	0
	.word	1035361
	.word	16391
	.word	916544
	.word	1031176
	.word	16388
	.word	916544
	.word	1031176
	.word	0
	.word	18432
	.word	916544
	.word	1031176
	.word	916552
	.word	1031176
	.word	1035284
	.word	0
	.word	16384
	.word	99972
	.word	590912
	.word	916544
	.word	1031171
	.word	1018883
	.word	16384
	.word	17408
	.word	0
	.word	16384
	.word	0
	.word	1013760
	.word	16384
	.word	0
	.word	0
	.word	0
	.word	593924
	.word	103056
	.word	103056
	.word	905516
	.word	1031176
	.word	589828
	.word	0
	.word	902208
	.word	916588
	.word	1031176
	.word	16384
	.word	1035355
	.word	1018888
	.word	0
	.word	1027079
	.word	0
	.word	1035361
	.word	16391
	.word	916544
	.word	1031176
	.word	16388
	.word	916544
	.word	1031176
	.word	0
	.word	18432
	.word	916544
	.word	1031176
	.word	916552
	.word	1031176
	.word	1035284
	.word	0
	.word	16384
	.word	99972
	.word	590912
	.word	916544
	.word	1031174
	.word	1018886
	.word	16384
	.word	17408
	.word	0
	.word	16384
	.word	0
	.word	1013760
	.word	16384
	.word	0
	.word	0
	.word	0
	.word	593924
	.word	103056
	.word	103056
	.word	905516
	.word	1031176
	.word	589828
	.word	0
	.word	902208
	.word	916588
	.word	1031175
	.word	16384
	.word	1035355
	.word	1018888
	.word	0
	.word	1031176
	.word	0
	.word	1027080
	.word	0
	.word	1027080
	.word	16384
	.word	1035355
	.word	0
	.word	16384
	.word	0
	.word	0
	.word	1007616
	.word	0
	.word	0
	.word	589828
	.word	99972
	.word	622596
	.word	901164
	.word	1031182
	.word	0
	.word	109184
	.word	0
	.word	0
	.word	0
	.word	597444
	.word	107044
	.word	100000
	.word	0
	.word	1035359
	.word	0
	.word	0
	.word	589840
	.word	98332
	.word	592016
	.word	100508
	.word	0
	.word	902272
	.word	1031178
	.word	0
	.word	67204
	.word	0
	.word	0
	.word	1018891
	.word	17408
	.word	0
	.word	0
	.word	0
	.word	902208
	.word	67204
	.word	0
	.word	0
	.word	0
	.word	904392
	.word	69260
	.word	0
	.word	1035351
	.word	1035354
	.word	0
	.word	16384
	.word	916608
	.word	1031181
	.word	916612
	.word	1031181
	.word	916608
	.word	1031180
	.word	916608
	.word	1031180
	.word	1018894
	.word	1035295
	.word	0
	.word	1027086
	.word	0
	.word	0
	.word	21506
	.word	300368
	.word	98324
	.word	0
	.word	1035359
	.word	1018894
	.word	1035312
	.word	0
	.word	1027086
	.word	0
	.word	0
	.word	21506
	.word	300368
	.word	98324
	.word	0
	.word	1035359
	.word	1018894
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	983049
	.word	0
	.word	0
	.word	0
	.word	589828
	.word	0
	.word	99972
	.word	916484
	.word	1031188
	.word	916524
	.word	1031184
	.word	916524
	.word	1031188
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1035359
	.word	0
	.word	0
	.word	0
	.word	597444
	.word	0
	.word	0
	.word	589840
	.word	98332
	.word	0
	.word	0
	.word	0
	.word	0
	.word	98308
	.word	0
	.word	916484
	.word	1031184
	.word	0
	.word	0
	.word	67204
	.word	0
	.word	0
	.word	1018897
	.word	0
	.word	0
	.word	902208
	.word	103044
	.word	67204
	.word	0
	.word	0
	.word	0
	.word	904400
	.word	69260
	.word	1035351
	.word	1035354
	.word	0
	.word	16384
	.word	916608
	.word	1031188
	.word	916612
	.word	1031188
	.word	16384
	.word	0
	.word	1035350
	.word	16384
	.word	0
	.word	0
	.word	1027092
	.word	16384
	.word	916544
	.word	1031186
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1018899
	.word	0
	.word	0
	.word	0
	.word	902208
	.word	67204
	.word	0
	.word	0
	.word	0
	.word	904392
	.word	69260
	.word	0
	.word	1035351
	.word	1035354
	.word	0
	.word	16384
	.word	916608
	.word	1031188
	.word	1018900
	.word	916612
	.word	1031188
	.word	1035322
	.word	1018900
	.word	1035322
	.word	16384
	.word	0
	.word	999424
	.word	16384
	.word	0
	.word	999424
	.word	0
	.word	0
	.word	0
	.word	0
	.word	98308
	.word	0
	.word	0
	.word	0
	.word	102028
	.word	592972
	.word	16384
	.word	0
	.word	0
	.word	0
	.word	589828
	.word	901164
	.word	67204
	.word	67204
	.word	606212
	.word	67204
	.word	67204
	.word	606212
	.word	69260
	.word	69260
	.word	69260
	.word	606220
	.word	0
	.word	16384
	.word	66176
	.word	0
	.word	0
	.word	0
	.word	20480
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	66176
	.word	66176
	.word	0
	.word	67204
	.word	67204
	.word	606212
	.word	67204
	.word	67204
	.word	606212
	.word	590920
	.word	67204
	.word	67204
	.word	606212
	.word	67204
	.word	67204
	.word	606212
	.word	1027096
	.word	0
	.word	1018905
	.word	0
	.word	1027096
	.word	1027096
	.word	1018905
	.word	0
	.word	1018905
	.word	0
	.word	1027097
	.word	1018905
	.word	0
	.word	1018905
	.word	67204
	.word	606212
	.word	606212
	.word	0
	.word	0
	.word	17410
	.word	0
	.word	1035359
	.word	0
	.word	0
	.word	0
	.word	17409
	.word	98308
	.word	17410
	.word	0
	.word	1035359
	.word	0
	.word	0
	.word	17410
	.word	98308
	.word	17410
	.word	0
	.word	1035359
	.word	0
	.word	0
	.word	0
	.word	17414
	.word	98308
	.word	17410
	.word	0
	.word	1035359
	.word	0
	.word	0
	.word	0
	.word	0
	.word	17408
	.word	901124
	.word	1031195
	.word	16384
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	17408
	.word	901124
	.word	1031196
	.word	16384
	.word	0
	.word	17409
	.word	98308
	.word	98308
	.word	66176
	.word	66176
	.word	18432
	.word	590980
	.word	67204
	.word	67204
	.word	606212
	.word	606212
	.word	0
	.word	18433
	.word	589832
	.word	66176
	.word	66176
	.word	590920
	.word	67204
	.word	67204
	.word	606212
	.word	67204
	.word	606212
	.word	18432
	.word	916552
	.word	1031198
	.word	916556
	.word	1031198
	.word	1018910
	.word	17408
	.word	1018910
	.word	17408
	.word	1018910
	.word	606212
	.word	0
	.word	0
	.word	17410
	.word	0
	.word	1035359
	.word	0
	.word	0
	.word	589828
	.word	901164
	.word	0
	.word	17419
	.word	98308
	.word	17410
	.word	0
	.word	1035359
	.word	16384
	.word	0
	.word	17423
	.word	98308
	.word	17410
	.word	0
	.word	1035359
	.word	999424
	.word	16384
	.word	0
	.word	1035350
	.word	17423
	.word	589828
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	1035374
	.word	0
	.word	16385
	.word	916488
	.word	1031215
	.word	16384
	.word	916608
	.word	1031215
	.word	0
	.word	16388
	.word	916864
	.word	1031202
	.word	916868
	.word	1031202
	.word	16389
	.word	916864
	.word	1031202
	.word	916868
	.word	1031202
	.word	16390
	.word	916864
	.word	1031202
	.word	916868
	.word	1031202
	.word	916864
	.word	1031202
	.word	1031215
	.word	16390
	.word	916864
	.word	1031202
	.word	916868
	.word	1031202
	.word	16391
	.word	916864
	.word	1031202
	.word	916868
	.word	1031202
	.word	1018920
	.word	1035374
	.word	0
	.word	17408
	.word	902532
	.word	903560
	.word	605256
	.word	1031215
	.word	1035374
	.word	17408
	.word	902532
	.word	1031215
	.word	1035374
	.word	17408
	.word	902532
	.word	1031215
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	17408
	.word	902532
	.word	1031215
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	17408
	.word	902532
	.word	1031208
	.word	29696
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	1027110
	.word	20480
	.word	30720
	.word	16384
	.word	916800
	.word	1031206
	.word	1035372
	.word	0
	.word	104840
	.word	104848
	.word	595332
	.word	16384
	.word	906560
	.word	1031206
	.word	103060
	.word	16384
	.word	112696
	.word	917380
	.word	1031206
	.word	1018917
	.word	990244
	.word	29696
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	1027112
	.word	20480
	.word	30720
	.word	16384
	.word	916800
	.word	1031208
	.word	1035372
	.word	0
	.word	104840
	.word	104848
	.word	595332
	.word	16384
	.word	906560
	.word	1031208
	.word	103060
	.word	16384
	.word	112696
	.word	917380
	.word	1031208
	.word	1018919
	.word	990246
	.word	1018920
	.word	16384
	.word	0
	.word	1035374
	.word	0
	.word	17408
	.word	916868
	.word	1027113
	.word	1018927
	.word	1035374
	.word	0
	.word	17408
	.word	916868
	.word	1031210
	.word	17408
	.word	916868
	.word	1031210
	.word	17408
	.word	916868
	.word	1031211
	.word	1018927
	.word	1035374
	.word	0
	.word	17408
	.word	916868
	.word	1031211
	.word	1018927
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	1035376
	.word	1035376
	.word	1035374
	.word	0
	.word	17423
	.word	916868
	.word	1031215
	.word	17408
	.word	916868
	.word	1031211
	.word	29696
	.word	110208
	.word	1035376
	.word	988203
	.word	1035374
	.word	16384
	.word	0
	.word	1035350
	.word	1035374
	.word	0
	.word	16384
	.word	916864
	.word	1031215
	.word	916868
	.word	1031215
	.word	1035374
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	17408
	.word	916868
	.word	1031213
	.word	1018926
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	16384
	.word	0
	.word	916864
	.word	1031215
	.word	916868
	.word	1031215
	.word	16384
	.word	916864
	.word	1031215
	.word	1018927
	.word	16384
	.word	0
	.word	16384
	.word	0
	.word	916864
	.word	1031215
	.word	916868
	.word	1031215
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	0
	.word	1031215
	.word	16384
	.word	0
	.word	1035350
	.word	16384
	.word	0
	.word	999424
	.word	16384
	.word	0
	.word	1035350
	.word	16384
	.word	0
	.word	999424
	.word	1035374
	.word	0
	.word	17408
	.word	916868
	.word	1031225
	.word	916872
	.word	1031225
	.word	1035374
	.word	0
	.word	17408
	.word	916868
	.word	1031225
	.word	916872
	.word	1031225
	.word	0
	.word	16384
	.word	99972
	.word	590912
	.word	916544
	.word	1031217
	.word	1018929
	.word	0
	.word	0
	.word	21506
	.word	300368
	.word	99412
	.word	0
	.word	1035359
	.word	0
	.word	1031225
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	1035374
	.word	17408
	.word	916868
	.word	1031225
	.word	1035374
	.word	0
	.word	17409
	.word	916868
	.word	1031225
	.word	1035374
	.word	0
	.word	17409
	.word	916868
	.word	1031225
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	17408
	.word	916868
	.word	1031225
	.word	1035372
	.word	0
	.word	1035372
	.word	1035372
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	18432
	.word	0
	.word	901124
	.word	901128
	.word	1031225
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	1031225
	.word	20480
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	916880
	.word	1031225
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	916484
	.word	1031224
	.word	1018935
	.word	16384
	.word	0
	.word	1018937
	.word	16384
	.word	0
	.word	0
	.word	1031225
	.word	16384
	.word	0
	.word	1035350
	.word	16384
	.word	0
	.word	999424
	.word	16384
	.word	0
	.word	1035350
	.word	16384
	.word	0
	.word	999424
	.word	1035374
	.word	0
	.word	0
	.word	916868
	.word	1031254
	.word	1035374
	.word	17408
	.word	916868
	.word	1031228
	.word	17408
	.word	916868
	.word	1031228
	.word	17408
	.word	916868
	.word	1031228
	.word	17408
	.word	916868
	.word	1031228
	.word	17408
	.word	916868
	.word	1031228
	.word	17408
	.word	916868
	.word	1031228
	.word	17408
	.word	916868
	.word	1031228
	.word	17408
	.word	916868
	.word	1031228
	.word	17408
	.word	916868
	.word	1031228
	.word	17408
	.word	916868
	.word	1031228
	.word	1018966
	.word	17408
	.word	0
	.word	1018940
	.word	17408
	.word	0
	.word	1018940
	.word	17408
	.word	0
	.word	1035374
	.word	0
	.word	17423
	.word	916868
	.word	1031254
	.word	0
	.word	16384
	.word	99972
	.word	590912
	.word	916544
	.word	1031229
	.word	1018941
	.word	0
	.word	0
	.word	21506
	.word	300368
	.word	99412
	.word	0
	.word	1035359
	.word	0
	.word	1031254
	.word	0
	.word	0
	.word	21506
	.word	300368
	.word	99412
	.word	0
	.word	1035359
	.word	0
	.word	1031254
	.word	16384
	.word	18432
	.word	100492
	.word	1035350
	.word	16384
	.word	0
	.word	0
	.word	0
	.word	1031232
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	1027136
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	98348
	.word	99436
	.word	294916
	.word	0
	.word	0
	.word	1031233
	.word	0
	.word	1031233
	.word	16384
	.word	294916
	.word	0
	.word	16384
	.word	99436
	.word	294916
	.word	17408
	.word	901124
	.word	0
	.word	18432
	.word	49160
	.word	589828
	.word	0
	.word	16384
	.word	916544
	.word	1031234
	.word	1035374
	.word	0
	.word	916868
	.word	1031254
	.word	16384
	.word	916544
	.word	1031235
	.word	16384
	.word	18432
	.word	100492
	.word	1035350
	.word	0
	.word	18432
	.word	50248
	.word	605188
	.word	1031235
	.word	1035376
	.word	0
	.word	18432
	.word	50308
	.word	605188
	.word	1031235
	.word	1035376
	.word	0
	.word	18432
	.word	50308
	.word	605188
	.word	1031235
	.word	1035376
	.word	0
	.word	1031236
	.word	1035374
	.word	17408
	.word	916868
	.word	1031254
	.word	16384
	.word	916484
	.word	1031236
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	0
	.word	0
	.word	16384
	.word	916544
	.word	1031238
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	1031238
	.word	1035374
	.word	0
	.word	16384
	.word	916484
	.word	1031238
	.word	1035374
	.word	0
	.word	16384
	.word	916484
	.word	1031238
	.word	16386
	.word	0
	.word	16384
	.word	916484
	.word	1031239
	.word	16386
	.word	0
	.word	16384
	.word	916484
	.word	1031239
	.word	1018953
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	1031241
	.word	28672
	.word	16384
	.word	108548
	.word	1035374
	.word	17408
	.word	916868
	.word	1031254
	.word	17408
	.word	916868
	.word	1031241
	.word	17408
	.word	916868
	.word	1031241
	.word	18432
	.word	916872
	.word	1031241
	.word	17408
	.word	916868
	.word	1031241
	.word	1018953
	.word	1035376
	.word	1018953
	.word	1035376
	.word	983112
	.word	16384
	.word	902148
	.word	1031243
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	1031243
	.word	28672
	.word	16384
	.word	108548
	.word	1035374
	.word	17408
	.word	916868
	.word	1031254
	.word	17408
	.word	916868
	.word	1031243
	.word	17408
	.word	916868
	.word	1031243
	.word	18432
	.word	916872
	.word	1031243
	.word	17408
	.word	916868
	.word	1031243
	.word	1018955
	.word	1035376
	.word	1018955
	.word	1035376
	.word	983114
	.word	16384
	.word	18432
	.word	901124
	.word	1031244
	.word	1031244
	.word	1018956
	.word	0
	.word	916612
	.word	1031244
	.word	130284
	.word	1031244
	.word	1018956
	.word	1018961
	.word	1035374
	.word	0
	.word	1027148
	.word	1035374
	.word	28672
	.word	16384
	.word	108548
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	1027149
	.word	1035372
	.word	1035372
	.word	0
	.word	1027150
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	1027150
	.word	1035372
	.word	1035372
	.word	1035372
	.word	1035372
	.word	983116
	.word	16384
	.word	0
	.word	916484
	.word	1031249
	.word	916652
	.word	1031249
	.word	28672
	.word	16384
	.word	108548
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	1027152
	.word	1035372
	.word	1035372
	.word	0
	.word	1027153
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	1027153
	.word	1035372
	.word	1035372
	.word	1035372
	.word	1035372
	.word	983119
	.word	0
	.word	1027155
	.word	16384
	.word	916544
	.word	1031249
	.word	16384
	.word	0
	.word	1035350
	.word	1018963
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	0
	.word	1027155
	.word	1035374
	.word	0
	.word	17408
	.word	916868
	.word	1031251
	.word	17408
	.word	916868
	.word	1031251
	.word	17408
	.word	916868
	.word	1031251
	.word	17408
	.word	916868
	.word	1031251
	.word	17408
	.word	916868
	.word	1031251
	.word	1018963
	.word	1035374
	.word	1018963
	.word	1035374
	.word	1035374
	.word	17408
	.word	916484
	.word	1031250
	.word	0
	.word	1027156
	.word	17408
	.word	916484
	.word	1031252
	.word	18432
	.word	916488
	.word	1031252
	.word	1018964
	.word	1035374
	.word	0
	.word	17408
	.word	916868
	.word	1031254
	.word	1035372
	.word	0
	.word	0
	.word	1031253
	.word	1035374
	.word	17408
	.word	916868
	.word	1031254
	.word	0
	.word	916872
	.word	1031253
	.word	1035372
	.word	1035372
	.word	0
	.word	1031254
	.word	16384
	.word	0
	.word	1035350
	.word	16384
	.word	0
	.word	999424
	.word	16384
	.word	0
	.word	1035350
	.word	16384
	.word	0
	.word	999424
	.word	19456
	.word	0
	.word	66176
	.word	67204
	.word	68232
	.word	68232
	.word	606212
	.word	606216
	.word	606216
	.word	0
	.word	1013760
	.word	16384
	.word	99972
	.word	99972
	.word	589888
	.word	916608
	.word	1031255
	.word	1018967
	.word	16384
	.word	0
	.word	999424
	.word	22528
	.word	0
	.word	0
	.word	0
	.word	916632
	.word	1031256
	.word	594960
	.word	0
	.word	0
	.word	0
	.word	594964
	.word	71316
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1018969
	.word	595088
	.word	0
	.word	593936
	.word	906516
	.word	0
	.word	0
	.word	594964
	.word	71316
	.word	0
	.word	0
	.word	0
	.word	0
	.word	595092
	.word	71316
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	999424
	.word	22528
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	16384
	.word	0
	.word	1035350
	.word	17409
	.word	591876
	.word	98944
	.word	592900
	.word	0
	.word	16384
	.word	0
	.word	1035350
	.word	999424
	.word	17408
	.word	916484
	.word	1031260
	.word	0
	.word	21504
	.word	0
	.word	300368
	.word	99652
	.word	0
	.word	1035359
	.word	0
	.word	0
	.word	67204
	.word	67204
	.word	67204
	.word	606212
	.word	0
	.word	0
	.word	21504
	.word	0
	.word	300368
	.word	98624
	.word	0
	.word	1035359
	.word	1018975
	.word	0
	.word	21504
	.word	0
	.word	905516
	.word	300368
	.word	99652
	.word	0
	.word	1035359
	.word	0
	.word	0
	.word	0
	.word	99392
	.word	0
	.word	0
	.word	0
	.word	99392
	.word	916552
	.word	1031261
	.word	1018974
	.word	0
	.word	0
	.word	902208
	.word	902276
	.word	99460
	.word	0
	.word	0
	.word	0
	.word	67204
	.word	67204
	.word	67204
	.word	606212
	.word	0
	.word	0
	.word	21504
	.word	0
	.word	905516
	.word	300368
	.word	98624
	.word	0
	.word	1035359
	.word	0
	.word	16384
	.word	98560
	.word	0
	.word	999424
	.word	20480
	.word	0
	.word	20480
	.word	21504
	.word	22528
	.word	916688
	.word	1031264
	.word	916692
	.word	1031264
	.word	916696
	.word	1031264
	.word	1018976
	.word	16384
	.word	0
	.word	1013760
	.word	1018976
	.word	16384
	.word	0
	.word	1013760
	.word	1018976
	.word	16384
	.word	0
	.word	1013760
	.word	999424
	.word	22528
	.word	0
	.word	0
	.word	108184
	.word	1031265
	.word	19456
	.word	104664
	.word	596248
	.word	108184
	.word	0
	.word	17408
	.word	916484
	.word	1031270
	.word	0
	.word	0
	.word	916544
	.word	1031270
	.word	104088
	.word	0
	.word	903232
	.word	68232
	.word	903316
	.word	1027172
	.word	0
	.word	0
	.word	0
	.word	592136
	.word	0
	.word	0
	.word	0
	.word	594176
	.word	905480
	.word	595264
	.word	102676
	.word	70288
	.word	102680
	.word	595220
	.word	104084
	.word	0
	.word	0
	.word	595220
	.word	0
	.word	19456
	.word	0
	.word	0
	.word	0
	.word	593040
	.word	69260
	.word	0
	.word	0
	.word	904264
	.word	69260
	.word	0
	.word	1018982
	.word	0
	.word	0
	.word	592136
	.word	0
	.word	0
	.word	0
	.word	903232
	.word	68232
	.word	903560
	.word	108168
	.word	0
	.word	589828
	.word	66176
	.word	100480
	.word	0
	.word	593044
	.word	102028
	.word	0
	.word	0
	.word	593044
	.word	0
	.word	0
	.word	0
	.word	904256
	.word	69260
	.word	904420
	.word	0
	.word	19456
	.word	0
	.word	0
	.word	0
	.word	1018988
	.word	0
	.word	0
	.word	1018987
	.word	0
	.word	0
	.word	98308
	.word	916608
	.word	1031275
	.word	104088
	.word	0
	.word	903232
	.word	68232
	.word	903316
	.word	1027177
	.word	0
	.word	0
	.word	0
	.word	592136
	.word	0
	.word	0
	.word	0
	.word	594176
	.word	905480
	.word	595264
	.word	102676
	.word	70288
	.word	102680
	.word	595220
	.word	104084
	.word	0
	.word	0
	.word	595220
	.word	0
	.word	19456
	.word	0
	.word	0
	.word	0
	.word	593040
	.word	69260
	.word	0
	.word	0
	.word	67204
	.word	904264
	.word	0
	.word	1018987
	.word	0
	.word	0
	.word	592136
	.word	0
	.word	0
	.word	0
	.word	903232
	.word	68232
	.word	903560
	.word	108168
	.word	0
	.word	589828
	.word	66176
	.word	100480
	.word	0
	.word	593044
	.word	102028
	.word	0
	.word	0
	.word	593044
	.word	0
	.word	0
	.word	0
	.word	0
	.word	903300
	.word	904200
	.word	69260
	.word	904420
	.word	0
	.word	19456
	.word	0
	.word	0
	.word	0
	.word	1018988
	.word	0
	.word	0
	.word	67204
	.word	1018987
	.word	0
	.word	592912
	.word	0
	.word	0
	.word	592912
	.word	69260
	.word	101592
	.word	595152
	.word	0
	.word	902244
	.word	0
	.word	0
	.word	595152
	.word	104084
	.word	0
	.word	19456
	.word	0
	.word	0
	.word	0
	.word	999424
	.word	19456
	.word	17408
	.word	66176
	.word	67204
	.word	606212
	.word	606216
	.word	0
	.word	1013760
	.word	16384
	.word	0
	.word	590936
	.word	596184
	.word	916544
	.word	1031277
	.word	612440
	.word	16384
	.word	99972
	.word	99972
	.word	589888
	.word	916608
	.word	1031278
	.word	16384
	.word	99972
	.word	99972
	.word	589888
	.word	916608
	.word	1031278
	.word	1018990
	.word	16384
	.word	0
	.word	999424
	.word	19456
	.word	17408
	.word	66176
	.word	67204
	.word	606212
	.word	606216
	.word	0
	.word	1013760
	.word	0
	.word	0
	.word	595992
	.word	16384
	.word	99972
	.word	99972
	.word	589888
	.word	916608
	.word	1031280
	.word	16384
	.word	99972
	.word	99972
	.word	589888
	.word	916608
	.word	1031280
	.word	1018992
	.word	16384
	.word	0
	.word	999424
	.word	21504
	.word	22528
	.word	19456
	.word	16384
	.word	0
	.word	66176
	.word	67204
	.word	68232
	.word	68232
	.word	606212
	.word	606216
	.word	606216
	.word	0
	.word	1013760
	.word	0
	.word	113280
	.word	0
	.word	102660
	.word	916544
	.word	1031282
	.word	19456
	.word	16384
	.word	0
	.word	66176
	.word	67204
	.word	68232
	.word	68232
	.word	606212
	.word	606216
	.word	606216
	.word	0
	.word	1013760
	.word	0
	.word	104836
	.word	916872
	.word	1031280
	.word	104080
	.word	916804
	.word	1031285
	.word	70288
	.word	102660
	.word	295128
	.word	905472
	.word	104080
	.word	916628
	.word	1031284
	.word	0
	.word	905476
	.word	19456
	.word	16384
	.word	0
	.word	66176
	.word	67204
	.word	68232
	.word	68232
	.word	606212
	.word	606216
	.word	606216
	.word	0
	.word	1013760
	.word	1018995
	.word	19456
	.word	16384
	.word	101008
	.word	66176
	.word	67204
	.word	68232
	.word	68232
	.word	606212
	.word	606216
	.word	606216
	.word	0
	.word	1013760
	.word	1018997
	.word	19456
	.word	16384
	.word	299224
	.word	903504
	.word	66176
	.word	67204
	.word	68232
	.word	68232
	.word	606212
	.word	606216
	.word	606216
	.word	0
	.word	1013760
	.word	16384
	.word	99972
	.word	99972
	.word	589888
	.word	916608
	.word	1031286
	.word	1018998
	.word	16384
	.word	0
	.word	999424
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	65537
	.word	7208960
	.word	513
	.word	1537
	.word	319365736
	.word	319365736
	.word	9437306
	.word	5046372
	.word	0
	.word	0
	.word	1
	.word	131
	.word	16
	.word	2
	.word	24
	.word	256
	.word	263
	.word	3
	.word	351
	.word	4
	.word	64
	.word	127
	.word	262143
	.word	1048575
	.word	4194303
	.word	2147483647
	.word	-2147483648
	.word	-16
	.word	15
	.word	-128
	.word	8192
	.word	1048576
	.word	96000
	.word	-8
	.word	-1
	.word	262144
	.word	-524288
	.word	65280000
	.word	196612
	.word	131074
	.word	65537
	.word	65537
	.word	0
	.word	0
	.word	0
	.word	0
	.word	8
	.word	8160
	.word	255
	.word	0
	.word	1
	.word	5
	.word	8
	.word	7
	.word	64
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.type	g_pSmIISBase, %object
	.size	g_pSmIISBase, 4
g_pSmIISBase:
	.word	s_SmIIS
	.type	g_pScdDrvParamBase, %object
	.size	g_pScdDrvParamBase, 4
g_pScdDrvParamBase:
	.word	g_ScdDrvParam
	.type	g_hex_flag, %object
	.size	g_hex_flag, 4
g_hex_flag:
	.word	1
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC2:
	.ascii	"line: %d, p = NULL is not expected value!\012\000"
	.space	1
.LC3:
	.ascii	"Fatal: get g_hex_base_addr(0x%x) vir addr failed!\012"
	.ascii	"\000"
	.space	1
.LC4:
	.ascii	"Warn: eVidStd = %d have not DSP vfmw bin file!!\012"
	.ascii	"\000"
	.space	3
.LC5:
	.ascii	"%s failed!\012\000"
.LC6:
	.ascii	"%s success!\012\000"
	.space	3
.LC7:
	.ascii	"Ignore the reset request when the SCD[%d] clock is "
	.ascii	"closed.\012\000"
.LC8:
	.ascii	"SCD[%d]   ResetSCD ERROR!!!\012\000"
	.space	3
.LC9:
	.ascii	"line: %d Get SmID fail!\000"
.LC10:
	.ascii	"DelRaw err PacketNum=%d,DelNum=%d\012\000"
	.space	1
.LC11:
	.ascii	"%s release RawPhyAddr=0x%x,Len=%d\012\000"
	.space	1
.LC12:
	.ascii	"%s %d FMW_OK !=  GetRawStreamNum!!\012\000"
.LC13:
	.ascii	"line: %d DelNum = %d,RawPacketOffSet = %d,DelNum = "
	.ascii	"%d,Next Length = %d,is_extern_eop_flag = %d\012\012"
	.ascii	"\000"
	.space	3
.LC14:
	.ascii	"line: %d DelNum = %d,RawPacketOffSet = %d,Next Leng"
	.ascii	"th = %d\012\012\000"
	.space	3
.LC15:
	.ascii	"line: %d pSmInstArray is NULL!\012\000"
.LC16:
	.ascii	"Read_seg SegPacket.PhyAddr=0x%x, LenByte=%d, IsLast"
	.ascii	"Seg=%d\012\000"
	.space	1
.LC17:
	.ascii	"-------- forece release seg[%d] -----------\012\000"
	.space	3
.LC18:
	.ascii	"\012\000"
	.space	2
.LC19:
	.ascii	"0x%02x,\000"
.LC20:
	.ascii	"Release SegPacket.PhyAddr=0x%x,LenByte=%d,IsLastSeg"
	.ascii	"=%d StreamID=%d\012\000"
.LC21:
	.ascii	"Array out of bound in function %s\012\000"
	.space	1
.LC22:
	.ascii	"VFMW_DspCtxMem\000"
	.space	1
.LC23:
	.ascii	"%s Alloc mem for DSP (SPS PPS) failed!\012\000"
.LC24:
	.ascii	"%s pDspSpsMsgMemVirAddr is NULL!\012\000"
	.space	2
.LC25:
	.ascii	"%s pDspPpsMsgMemVirAddr is NULL!\012\000"
	.space	2
.LC26:
	.ascii	"pstDSPMem->PhyAddr = 0 is not right address\012\000"
	.space	3
.LC27:
	.ascii	"ScdId is wrong! %s error\012\000"
	.space	2
.LC28:
	.ascii	"%s,line: %d\012\000"
	.space	3
.LC29:
	.ascii	"%s,line: %d,prt = NULL!\012\000"
	.space	3
.LC30:
	.ascii	"%s: pScdDrvParam->ScdDrvMem.pDvmMemVirAddr = NULL\012"
	.ascii	"\000"
	.space	1
.LC31:
	.ascii	"%s: pScdDrvParam->ScdDrvMem.pDspSedTopMemVirAddr = "
	.ascii	"NULL\012\000"
	.space	3
.LC32:
	.ascii	"%s: pScdDrvParam->ScdDrvMem.pDspCaMnMemVirAddr = NU"
	.ascii	"LL\012\000"
	.space	1
.LC33:
	.ascii	"%s: g_hex_base_vir_addr = NULL\012\000"
.LC34:
	.ascii	"line: %d, SmID = %d is not expected!\012\000"
	.space	2
.LC35:
	.ascii	"line: %d, SmID = %d, ScdId = %d is not expected!\012"
	.ascii	"\000"
	.space	2
.LC36:
	.ascii	"Raw packet TOO BIG! can't copy to seg! Len: %#x\012"
	.ascii	"\000"
	.space	3
.LC37:
	.ascii	"line: %d, delet raw failed!\012\000"
	.space	3
.LC38:
	.ascii	"Raw packet(VFMW_RAW YUV) TOO BIG(maybe caused by w/"
	.ascii	"h... err)! can't copy to seg!\012\000"
	.space	2
.LC39:
	.ascii	"VFMW_RAW YUV disp w/h err)! discard raw packet!\012"
	.ascii	"\000"
	.space	3
.LC40:
	.ascii	"copy raw to seg fail\012\000"
	.space	2
.LC41:
	.ascii	"***Print Up Msg Now\012\000"
	.space	3
.LC42:
	.ascii	"ScdUpMsg[%d] = 0x%x\012\000"
	.space	3
.LC43:
	.ascii	"%s: pRawPacket = NULL!\012\000"
.LC44:
	.ascii	"%s: unkown standard type = %d!\012\000"
.LC45:
	.ascii	"%s: Length(%d)+FlagLen(%d) > BufLen(%d)\012\000"
	.space	3
.LC46:
	.ascii	"%s: FlagLen(%d) > RawPacketLength(%d)\012\000"
	.space	1
.LC47:
	.ascii	"%s: RawPacket Length %d <= 0\012\000"
	.space	2
.LC48:
	.ascii	"%s(): Std(%d) buffer has no enough space,(act:%d, h"
	.ascii	"eader_buf:%d)\012\000"
	.space	2
.LC49:
	.ascii	"%s(): Std(%d) buffer has no enough space,(act:%d, s"
	.ascii	"tr_buf:%d)\012\000"
	.space	1
.LC50:
	.ascii	"%s(): Std(%d) buffer has no enough space,(act:%d, s"
	.ascii	"tr_buf:%d, header_buf:%d)\012\000"
	.space	2
.LC51:
	.ascii	"%s(): Std(%d) buffer has no enough space, (act:%d, "
	.ascii	"str_buf:%d)\012\000"
.LC52:
	.ascii	"Chan %d has been destroyed or the function pointer "
	.ascii	"-- ReleaseRawStreamData pStreamIntf is NULL!\000"
.LC53:
	.ascii	"line: %d s_SmIIS[%d].pSmInstArray is NULL\012\000"
	.space	1
.LC54:
	.ascii	"SmID = %d is not expected!\012\000"
.LC55:
	.ascii	"Chan %d has been destroyed or the function pointer "
	.ascii	"-- ReadRawStreamData pStreamIntf is NULL!\000"
	.space	3
.LC56:
	.ascii	"line: %d s_SmIIS.pSmInstArray[%d] is NULL\012\000"
	.space	1
.LC57:
	.ascii	"Chan %d FillEosRawStream failed!\012\000"
	.space	2
.LC58:
	.ascii	"Chan %d FillExtraData failed!\012\000"
	.space	1
.LC59:
	.ascii	"Release this packet failed!\012\000"
	.space	3
.LC60:
	.ascii	"No space for raw move, total:%d+%d > max:%d!\012\000"
	.space	2
.LC61:
	.ascii	"Error:now DspState[0]= %d,[1]= %d not except!!\012\000"
.LC62:
	.ascii	"%s,%d,SCD(ID = %d) SCDState = %d\012\000"
	.space	2
.LC63:
	.ascii	"%s,%d,SCD(ID = %d) return Idle!\012\000"
	.space	3
.LC64:
	.ascii	"Chan %d SCD[%d] Time Out(%d ms), Reset it!\012\000"
.LC65:
	.ascii	"%s,%d,SCD(ID = %d) really busy!\012\000"
	.space	3
.LC66:
	.ascii	"scd time out: t_start,t_now,t_wait = %d,%d,%d\012\000"
	.space	1
.LC67:
	.ascii	"***Print Scd[%d] Vtrl Reg Now\012\000"
	.space	1
.LC68:
	.ascii	"DownMsgPhyAddr = %x\012\000"
	.space	3
.LC69:
	.ascii	"UpMsgPhyAddr = %x\012\000"
	.space	1
.LC70:
	.ascii	"UpLen = %x\012\000"
.LC71:
	.ascii	"BufferFirst = %x\012\000"
	.space	2
.LC72:
	.ascii	"BufferLast = %x\012\000"
	.space	3
.LC73:
	.ascii	"BufferIni = %x\012\000"
.LC74:
	.ascii	"ScdProtocol = %x\012\000"
	.space	2
.LC75:
	.ascii	"ScdStart = %x\012\000"
	.space	1
.LC76:
	.ascii	"***Print SCD[%d] Down Msg Now\012\000"
	.space	1
.LC77:
	.ascii	"DownMsgVirAddr = %x   \012\000"
.LC78:
	.ascii	"DownMsgPhyAddr = %x   \012\000"
.LC79:
	.ascii	"DownMsg[%d] = %x   \000"
.LC80:
	.ascii	"RawStreamSize=%d\012\000"
	.space	2
.LC81:
	.ascii	"SegStreamSize=%d\012\000"
	.space	2
.LC82:
	.ascii	"SM_CfgBuf Err! ret =%d\012\000"
.LC83:
	.ascii	"SegStreamNum=%d\012\000"
	.space	3
.LC84:
	.ascii	"RawStreamNum=%d\012\000"
	.space	3
.LC85:
	.ascii	"***Print Scd[%d] State Reg\012\000"
.LC86:
	.ascii	"Scdover = %d \012\000"
	.space	1
.LC87:
	.ascii	"ScdInt = %d \012\000"
	.space	2
.LC88:
	.ascii	"ShortScdNum = %d \012\000"
	.space	1
.LC89:
	.ascii	"ScdNum = %d \012\000"
	.space	2
.LC90:
	.ascii	"ScdRollAddr = %0x \012\000"
.LC91:
	.ascii	"SrcEaten = %d \012\000"
.LC92:
	.ascii	"%s %d FMW_OK !=  GetSegStreamNum!!\012\000"
.LC93:
	.ascii	"line:%d ReadScdSegNum = %d, FilterScdSegNum = 0 rel"
	.ascii	"ease raw packet anyway!\012\000"
.LC94:
	.ascii	"Error! (PushRawTotalLen - SrcEaten) > SM_RAW_DISCAR"
	.ascii	"D_SIZE, packet discard...\012\000"
	.space	2
.LC95:
	.ascii	"Insert err Scd SegPacket.PhyAddr=0x%x,LenByte=%d,Is"
	.ascii	"LastSeg=%d\012\000"
	.space	1
.LC96:
	.ascii	"RawLen = %d, Pts = %ld, \012\000"
	.space	2
.LC97:
	.ascii	"Scd SegPacket.PhyAddr=0x%x,LenByte=%d,IsLastSeg=%d\012"
	.ascii	"\000"
.LC98:
	.ascii	"RawLen = %d, Pts =  %lld, \012\000"
.LC99:
	.ascii	"Insert 2 err Scd SegPacket.PhyAddr=0x%x,LenByte=%d,"
	.ascii	"IsLastSeg=%d\012\000"
	.space	3
.LC100:
	.ascii	"line %d CheckSeg err\012\000"
	.space	2
.LC101:
	.ascii	"line %d SegFreeBufLen=%d,SrcEaten=%d\000"
	.space	3
.LC102:
	.ascii	"line %d Scd SegPacket.PhyAddr=0x%x,LenByte=%d,IsLas"
	.ascii	"tSeg=%d\012\000"
.LC103:
	.ascii	"ReadScdSegNum = %d, FilterScdSegNum = 0 release raw"
	.ascii	" packet anyway!\012\000"
.LC104:
	.ascii	"CheckSeg err\012\000"
	.space	2
.LC105:
	.ascii	"SegFreeBufLen=%d,SrcEaten=%d\000"
	.space	3
.LC106:
	.ascii	"%s %d FMW_OK != GetSegStreamNum!!\012\000"
	.space	1
.LC107:
	.ascii	"********** SmID [%d] RawState begin **********\012\000"
.LC108:
	.ascii	"RawHead=%d\012\000"
.LC109:
	.ascii	"RawTail=%d\012\000"
.LC110:
	.ascii	"RawHistory=%d\012\000"
	.space	1
.LC111:
	.ascii	"RawFirstPacketOffset=%d\012\000"
	.space	3
.LC112:
	.ascii	"CurShowIndex=%d\012\000"
	.space	3
.LC113:
	.ascii	"********** SmID [%d] RawState end   **********\012\000"
.LC114:
	.ascii	"RawPhyAddr=0x%x\012\000"
	.space	3
.LC115:
	.ascii	"RawVirAddr=0x%x\012\000"
	.space	3
.LC116:
	.ascii	"RawLength=%d\012\000"
	.space	2
.LC117:
	.ascii	"RawPts=%ld\012\000"
.LC118:
	.ascii	"raw_pts: %lld\012\000"
	.space	1
.LC119:
	.ascii	"Get RawPhyAddr=0x%x,Len=%d\012\000"
.LC120:
	.ascii	"!!!push raw err!!!\012\000"
.LC121:
	.ascii	"Chan%d raw full\012\000"
	.space	3
.LC122:
	.ascii	"RawNum %lld <= RawNumInVfmw %lld\012\000"
	.space	2
.LC123:
	.ascii	"------------------ s_SmIIS[%d].SmInstArray --------"
	.ascii	"------------\012\000"
	.space	3
.LC124:
	.ascii	"Mode\000"
	.space	3
.LC125:
	.ascii	"%-25s :%d\012\000"
	.space	1
.LC126:
	.ascii	"Priority\000"
	.space	3
.LC127:
	.ascii	"VidStd\000"
	.space	1
.LC128:
	.ascii	"BufPhyAddr\000"
	.space	1
.LC129:
	.ascii	"%-25s :0x%x\012\000"
	.space	3
.LC130:
	.ascii	"pBufVirAddr\000"
.LC131:
	.ascii	"BufSize\000"
.LC132:
	.ascii	"RegPhyBaseAddr\000"
	.space	1
.LC133:
	.ascii	"SmPushRaw.PushRawNum\000"
	.space	3
.LC134:
	.ascii	"SmPushRaw.PushRawTotalLen\000"
	.space	2
.LC135:
	.ascii	"DownMsgPhyAddr\000"
	.space	1
.LC136:
	.ascii	"DownMsgSize\000"
.LC137:
	.ascii	"UpMsgPhyAddr\000"
	.space	3
.LC138:
	.ascii	"UpMsgNum\000"
	.space	3
.LC139:
	.ascii	"UpMsgSize\000"
	.space	2
.LC140:
	.ascii	"seg BufPhyAddr\000"
	.space	1
.LC141:
	.ascii	"seg BufSize\000"
.LC142:
	.ascii	"seg BufUsed\000"
.LC143:
	.ascii	"seg BufItemNum\000"
	.space	1
.LC144:
	.ascii	"raw StreamHold\000"
	.space	1
.LC145:
	.ascii	"raw StreamPacketNum\000"
.LC146:
	.ascii	"filter ProtocolType\000"
.LC147:
	.ascii	"filter ModeFlag\000"
.LC148:
	.ascii	"filter LastH263Num\000"
	.space	1
.LC149:
	.ascii	"filter SegBufPhyAddr\000"
	.space	3
.LC150:
	.ascii	"filter SegBufSize\000"
	.space	2
.LC151:
	.ascii	"filter SegBufRollAddr\000"
	.space	2
.LC152:
	.ascii	"filter pScdUpMsg\000"
	.space	3
.LC153:
	.ascii	"filter SegNum\000"
	.space	2
.LC154:
	.ascii	"BlockTimeInMs\000"
	.space	2
.LC155:
	.ascii	"LastBlockTime\000"
	.space	2
.LC156:
	.ascii	"LastPts\000"
.LC157:
	.ascii	"%-25s :%lld\012\000"
	.space	3
.LC158:
	.ascii	"ThisInstID\000"
	.space	1
.LC159:
	.ascii	"SCDState\000"
	.space	3
.LC160:
	.ascii	"\012raw packets Head : %d, Histroy : %d\012\000"
	.space	2
.LC161:
	.ascii	"\012raw packets length is(first packet %d bytes use"
	.ascii	"d):\012\000"
	.space	3
.LC162:
	.ascii	"%5d \000"
	.space	3
.LC163:
	.ascii	"********** SmID [%d] SegState begin **********\012\000"
.LC164:
	.ascii	"SegHead=%d\012\000"
.LC165:
	.ascii	"SegTail=%d\012\000"
.LC166:
	.ascii	"SegCurrent=%d\012\000"
	.space	1
.LC167:
	.ascii	"SegBufPhyAddr=%p\012\000"
	.space	2
.LC168:
	.ascii	"SegBufVirAddr=%p\012\000"
	.space	2
.LC169:
	.ascii	"SegBufSize=%d\012\000"
	.space	1
.LC170:
	.ascii	"SegBufReadAddr=%p\012\000"
	.space	1
.LC171:
	.ascii	"SegBufWriteAddr=%pd\012\000"
	.space	3
.LC172:
	.ascii	"********** SmID [%d] SegState end   **********\012\000"
.LC173:
	.ascii	"SegPhyAddr=0x%x\012\000"
	.space	3
.LC174:
	.ascii	"SegVirAddr=0x%x\012\000"
	.space	3
.LC175:
	.ascii	"SegLength=%d\012\000"
	.space	2
.LC176:
	.ascii	"SegStreamID=%d\012\000"
.LC177:
	.ascii	"SegState=%d\012\000"
	.space	3
.LC178:
	.ascii	"SegIsLastSeg=%d\012\000"
	.space	3
.LC179:
	.ascii	"SegPts=%lld\012\000"
	.space	3
.LC180:
	.ascii	"%s %d FMW_OK !=  GetSegStreamNum\012\000"
	.space	2
.LC181:
	.ascii	"SM_DoNextInstance parm 1:scdId(%d) Error!\012\000"
	.space	1
.LC182:
	.ascii	"VFMW_RAW SM_CopyYuvToDnr fail\012\000"
	.space	1
.LC183:
	.ascii	"long time(%d ms) not release stream seg, release an"
	.ascii	"yway!\012\000"
	.space	2
.LC184:
	.ascii	"%s,%d, active scd Success!\012\000"
.LC185:
	.ascii	"%s prepare to check SCD(%d)/(MAX_SCD_NUM = %d)\012\000"
.LC186:
	.ascii	"%s,%d,SCD(ID = %d) return BUSY!!\012\000"
	.space	2
.LC187:
	.ascii	"%s,%d,find idle SCD(ID = %d)\012\000"
	.space	2
.LC188:
	.ascii	"SetMaxSegSize get eCapLevel failed!\012\000"
	.space	3
.LC189:
	.ascii	"SetMaxSegSize get ChanWidth/ChanHeight failed!\012\000"
.LC190:
	.ascii	"line: %d, SmID = %d, pSmCfg = %p is not expected!\012"
	.ascii	"\000"
	.space	1
.LC191:
	.ascii	"line: %d, pSmInstArray is NULL!\012\000"
	.space	3
.LC192:
	.ascii	"%s %d FMW_OK !=  GetRawStreamNum !!\012\000"
	.space	3
.LC193:
	.ascii	"%s: ScdId(%d) > %d\012\000"
.LC194:
	.ascii	"Move raw data failed, force to reset scd.\012\000"
	.space	1
.LC195:
	.ascii	"SCD GetRawStreamNum Fail.\012\000"
	.bss
	.align	2
.LANCHOR0 = . + 0
	.type	g_hex_base_addr, %object
	.size	g_hex_base_addr, 4
g_hex_base_addr:
	.space	4
	.type	s_ScdRegPhyBaseAddr, %object
	.size	s_ScdRegPhyBaseAddr, 4
s_ScdRegPhyBaseAddr:
	.space	4
	.type	s_SmIIS, %object
	.size	s_SmIIS, 896
s_SmIIS:
	.space	896
	.type	g_ScdDrvParam, %object
	.size	g_ScdDrvParam, 96
g_ScdDrvParam:
	.space	96
	.type	s_eScdDrvSleepStage, %object
	.size	s_eScdDrvSleepStage, 4
s_eScdDrvSleepStage:
	.space	4
	.type	g_hex_base_vir_addr, %object
	.size	g_hex_base_vir_addr, 4
g_hex_base_vir_addr:
	.space	4
	.type	g_hex_len, %object
	.size	g_hex_len, 4
g_hex_len:
	.space	4
	.type	s_ScdRegResetPhyAddr, %object
	.size	s_ScdRegResetPhyAddr, 4
s_ScdRegResetPhyAddr:
	.space	4
	.type	LastEventTime.55304, %object
	.size	LastEventTime.55304, 4
LastEventTime.55304:
	.space	4
	.type	last_rec_pos_time.55510, %object
	.size	last_rec_pos_time.55510, 64
last_rec_pos_time.55510:
	.space	64
	.type	last_rec_pos_time.55657, %object
	.size	last_rec_pos_time.55657, 64
last_rec_pos_time.55657:
	.space	64
	.type	s_SCDInISR, %object
	.size	s_SCDInISR, 4
s_SCDInISR:
	.space	4
	.type	last_rec_pos_time.55685, %object
	.size	last_rec_pos_time.55685, 64
last_rec_pos_time.55685:
	.space	64
	.type	s_ScdRegResetOKPhyAddr, %object
	.size	s_ScdRegResetOKPhyAddr, 4
s_ScdRegResetOKPhyAddr:
	.space	4
	.type	ForceRelease, %object
	.size	ForceRelease, 4
ForceRelease:
	.space	4
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
