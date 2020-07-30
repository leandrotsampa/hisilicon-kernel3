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
	.file	"vdm_drv.c"

	.text
	.align	2
	.global	VDMDRV_Init
	.type	VDMDRV_Init, %function
VDMDRV_Init:
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
	ldr	r5, .L2
	ldr	r3, .L2+4
	mov	r2, #44
	mov	r4, r0
	mov	r1, #0
	mla	r0, r2, r0, r5
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r2, .L2+8
	mov	r1, #84
	add	r5, r5, r4, lsl #2
	mov	r3, #0
	mla	r4, r1, r4, r2
	str	r3, [r5, #44]
	str	r3, [r5, #48]
	add	r4, r4, #8
	str	r3, [r4, #4]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L3:
	.align	2
.L2:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_VfmwGlobalStat
	.fnend
	.size	VDMDRV_Init, .-VDMDRV_Init
	.align	2
	.global	VDMDRV_Reset
	.type	VDMDRV_Reset, %function
VDMDRV_Reset:
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
	ldr	ip, .L5
	ldr	r3, .L5+4
	mov	r2, #44
	mov	r1, #0
	mla	r0, r2, r0, ip
	ldr	r3, [r3, #48]
	blx	r3
	ldmfd	sp, {fp, sp, pc}
.L6:
	.align	2
.L5:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VDMDRV_Reset, .-VDMDRV_Reset
	.align	2
	.global	VDMDRV_SetPriority
	.type	VDMDRV_SetPriority, %function
VDMDRV_SetPriority:
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
	ldr	r5, .L20
	mov	r4, #0
	sub	r7, r0, #4
	mov	lr, r4
	mov	r6, r4
.L14:
	mov	ip, #0
	mov	r1, r7
	mov	r3, ip
.L9:
	ldr	r2, [r1, #4]!
	cmp	r2, ip
	movgt	lr, r3
	add	r3, r3, #1
	movgt	ip, r2
	cmp	r3, #16
	bne	.L9
	cmp	ip, #0
	ble	.L19
	add	r4, r4, #1
	str	lr, [r5, #4]!
	cmp	r4, #16
	str	r6, [r0, lr, asl #2]
	bne	.L14
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L19:
	cmp	r4, #15
	ldmgtfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	r0, .L20+4
	mov	r2, r4, asl #2
	mvn	r1, #0
.L12:
	add	r4, r4, #1
	add	r3, r0, r2
	cmp	r4, #16
	add	r2, r2, #4
	str	r1, [r3, #120]
	bne	.L12
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L21:
	.align	2
.L20:
	.word	.LANCHOR0+116
	.word	.LANCHOR0
	.fnend
	.size	VDMDRV_SetPriority, .-VDMDRV_SetPriority
	.align	2
	.global	VDMDRV_AdjustPriorityAfterDec
	.type	VDMDRV_AdjustPriorityAfterDec, %function
VDMDRV_AdjustPriorityAfterDec:
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
	ldr	r5, .L35
	add	ip, r5, #120
	ldr	r3, [r5, #120]
	cmp	r3, r0
	beq	.L31
	mov	r3, #1
	mov	r2, ip
.L27:
	ldr	r1, [r2, #4]!
	cmp	r1, r0
	beq	.L33
	add	r3, r3, #1
	cmp	r3, #16
	bne	.L27
	mov	r3, #0
	mov	r6, #4
	mov	lr, r3
.L28:
	ldr	r0, [ip, r6]
	add	r6, ip, r6
	cmp	r0, #0
	ldmltfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	add	r2, r3, #2
	mov	r2, r2, asl #2
	b	.L26
.L30:
	ldr	r0, [ip, r2]
	add	r2, r2, #4
	cmp	r0, #0
	ldmltfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L26:
	ldr	r4, [ip, lr, asl #2]
	add	r1, r5, r0, lsl #2
	add	r3, r3, #1
	ldr	r7, [r1, #56]
	add	r1, r5, r4, lsl #2
	ldr	r1, [r1, #56]
	cmp	r7, r1
	strge	r0, [ip, lr, asl #2]
	strge	r4, [r6]
	cmp	r3, #14
	add	r6, ip, r2
	mov	lr, r3
	ble	.L30
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L33:
	cmp	r3, #14
	bgt	.L34
.L23:
	add	r6, r3, #1
	mov	lr, r3
	mov	r6, r6, asl #2
	b	.L28
.L31:
	mov	r3, #0
	b	.L23
.L34:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L36:
	.align	2
.L35:
	.word	.LANCHOR0
	.fnend
	.size	VDMDRV_AdjustPriorityAfterDec, .-VDMDRV_AdjustPriorityAfterDec
	.align	2
	.global	VDMDRV_PrepareSleep
	.type	VDMDRV_PrepareSleep, %function
VDMDRV_PrepareSleep:
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
	ldr	r1, .L41
	add	ip, r1, r0, lsl #2
	ldr	r3, [ip, #44]
	cmp	r3, #0
	bne	.L40
	mov	r2, #44
	mul	r0, r2, r0
	ldr	r0, [r1, r0]
	cmp	r0, #0
	moveq	r3, #2
	movne	r0, r3
	movne	r3, #1
	str	r3, [ip, #44]
	ldmfd	sp, {fp, sp, pc}
.L40:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L42:
	.align	2
.L41:
	.word	.LANCHOR0
	.fnend
	.size	VDMDRV_PrepareSleep, .-VDMDRV_PrepareSleep
	.align	2
	.global	VDMDRV_GetSleepStage
	.type	VDMDRV_GetSleepStage, %function
VDMDRV_GetSleepStage:
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
	ldr	r3, .L44
	add	r0, r3, r0, lsl #2
	ldr	r0, [r0, #44]
	ldmfd	sp, {fp, sp, pc}
.L45:
	.align	2
.L44:
	.word	.LANCHOR0
	.fnend
	.size	VDMDRV_GetSleepStage, .-VDMDRV_GetSleepStage
	.align	2
	.global	VDMDRV_ForceSleep
	.type	VDMDRV_ForceSleep, %function
VDMDRV_ForceSleep:
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
	ldr	r3, .L51
	add	r4, r3, r0, lsl #2
	ldr	r2, [r4, #44]
	cmp	r2, #2
	beq	.L47
	ldr	r1, .L51+4
	mov	r2, #44
	mla	r0, r2, r0, r3
	ldr	r3, [r1, #48]
	mov	r1, #0
	blx	r3
	mov	r3, #2
	str	r3, [r4, #44]
.L47:
	ldr	r1, .L51+8
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L52:
	.align	2
.L51:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC0
	.fnend
	.size	VDMDRV_ForceSleep, .-VDMDRV_ForceSleep
	.align	2
	.global	VDMDRV_ExitSleep
	.type	VDMDRV_ExitSleep, %function
VDMDRV_ExitSleep:
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
	ldr	r3, .L54
	mov	r2, #0
	add	r0, r3, r0, lsl #2
	str	r2, [r0, #44]
	ldmfd	sp, {fp, sp, pc}
.L55:
	.align	2
.L54:
	.word	.LANCHOR0
	.fnend
	.size	VDMDRV_ExitSleep, .-VDMDRV_ExitSleep
	.align	2
	.global	VDMDRV_StartRepair
	.type	VDMDRV_StartRepair, %function
VDMDRV_StartRepair:
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
	ldr	r3, .L59
	mov	r5, r0
	mov	r4, r1
	ldr	r3, [r3, #108]
	cmp	r3, #0
	beq	.L57
	mov	r1, r2
	mov	r0, r4
	blx	r3
.L58:
	mov	r3, #44
	ldr	r2, .L59+4
	mul	r1, r3, r4
	str	r5, [r2, r1]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L57:
	mov	r0, r3
	movw	r2, #295
	ldr	r1, .L59+8
	bl	dprint_vfmw
	b	.L58
.L60:
	.align	2
.L59:
	.word	g_vdm_hal_fun_ptr
	.word	.LANCHOR0
	.word	.LC1
	.fnend
	.size	VDMDRV_StartRepair, .-VDMDRV_StartRepair
	.align	2
	.global	VDMDRV_StartDec
	.type	VDMDRV_StartDec, %function
VDMDRV_StartDec:
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
	ldr	r3, .L64
	mov	r4, r0
	ldr	r3, [r3, #112]
	cmp	r3, #0
	beq	.L62
	blx	r3
.L63:
	mov	r3, #44
	ldr	r2, .L64+4
	mul	r0, r3, r4
	mov	r3, #1
	str	r3, [r2, r0]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L62:
	mov	r0, r3
	movw	r2, #303
	ldr	r1, .L64+8
	bl	dprint_vfmw
	b	.L63
.L65:
	.align	2
.L64:
	.word	g_vdm_hal_fun_ptr
	.word	.LANCHOR0
	.word	.LC1
	.fnend
	.size	VDMDRV_StartDec, .-VDMDRV_StartDec
	.align	2
	.global	VDMDRV_IsChanDec
	.type	VDMDRV_IsChanDec, %function
VDMDRV_IsChanDec:
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
	ldr	r3, .L67
	add	r0, r3, r0, lsl #2
	ldr	r0, [r0, #184]
	adds	r0, r0, #0
	movne	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L68:
	.align	2
.L67:
	.word	.LANCHOR0
	.fnend
	.size	VDMDRV_IsChanDec, .-VDMDRV_IsChanDec
	.align	2
	.global	VDMDRV_SetChanIsDec
	.type	VDMDRV_SetChanIsDec, %function
VDMDRV_SetChanIsDec:
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
	ldr	r3, .L70
	add	r1, r1, #1
	add	r3, r3, r0, lsl #2
	str	r1, [r3, #184]
	bl	VDMDRV_AdjustPriorityAfterDec
	ldmfd	sp, {fp, sp, pc}
.L71:
	.align	2
.L70:
	.word	.LANCHOR0
	.fnend
	.size	VDMDRV_SetChanIsDec, .-VDMDRV_SetChanIsDec
	.align	2
	.global	VDMDRV_ClearChanIsDec
	.type	VDMDRV_ClearChanIsDec, %function
VDMDRV_ClearChanIsDec:
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
	ldr	r3, .L73
	add	r0, r0, #32
	mov	r2, #0
	add	r0, r3, r0, lsl #2
	str	r2, [r0, #56]
	ldmfd	sp, {fp, sp, pc}
.L74:
	.align	2
.L73:
	.word	.LANCHOR0
	.fnend
	.size	VDMDRV_ClearChanIsDec, .-VDMDRV_ClearChanIsDec
	.align	2
	.global	VDMDRV_ParamInit
	.type	VDMDRV_ParamInit, %function
VDMDRV_ParamInit:
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
	ldr	r3, .L82
	mov	r0, #1
	add	r1, r3, #64
.L77:
	ldr	r2, [r3, #4]!
	cmp	r2, #0
	strne	r0, [r2, #24]
	cmp	r3, r1
	bne	.L77
	ldmfd	sp, {fp, sp, pc}
.L83:
	.align	2
.L82:
	.word	s_pstVfmwChan-4
	.fnend
	.size	VDMDRV_ParamInit, .-VDMDRV_ParamInit
	.align	2
	.global	VDMDRV_AddMatchMode
	.type	VDMDRV_AddMatchMode, %function
VDMDRV_AddMatchMode:
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
	.size	VDMDRV_AddMatchMode, .-VDMDRV_AddMatchMode
	.align	2
	.global	VDMDRV_CheckAttachMode
	.type	VDMDRV_CheckAttachMode, %function
VDMDRV_CheckAttachMode:
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
	cmp	r0, #15
	mov	r4, r0
	bgt	.L85
	ldr	r6, .L111
	ldr	r2, [r6, r0, asl #2]
	cmp	r2, #0
	beq	.L85
	add	r3, r2, #204800
	ldr	r5, .L111+4
	mov	r8, r0, asl #2
	ldr	r1, [r3, #1560]
	ldr	r3, [r3, #1556]
	cmp	r1, #2160
	cmpcs	r3, #3840
	movcs	r7, #1
	movcc	r7, #0
	bcs	.L110
	add	r3, r5, r8
	ldr	r3, [r3, #312]
.L93:
	cmp	r3, #10
	beq	.L95
.L94:
	ldr	r3, [r2, #24]
	cmp	r3, #0
	beq	.L96
.L95:
	ldr	r3, [r2, #1496]
	cmp	r3, #35
	ble	.L97
	cmp	r7, #0
	beq	.L96
	mov	r1, #1
	movw	r3, #558
	str	r1, [r2, #1484]
	mov	r0, #0
	str	r1, [sp, #4]
	ldr	r2, .L111+8
	str	r4, [sp]
	ldr	r1, .L111+12
	bl	dprint_vfmw
	ldr	r2, [r6, r4, asl #2]
.L96:
	mov	r3, #0
	str	r3, [r2, #24]
	ldr	r3, [r6, r4, asl #2]
	add	r5, r5, r8
	ldr	r3, [r3, #1496]
	str	r3, [r5, #248]
.L85:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L110:
	add	r3, r5, r8
	ldr	r2, [r2, #1496]
	mov	r0, #22
	ldr	r1, .L111+16
	ldr	r3, [r3, #248]
	str	r2, [sp]
	cmp	r2, r3
	rsbhi	r9, r3, r2
	rsbls	r9, r2, r3
	str	r3, [sp, #4]
	movw	r3, #530
	ldr	r2, .L111+8
	bl	dprint_vfmw
	cmp	r9, #2
	bgt	.L90
	add	r2, r5, r8
	ldr	r3, [r2, #312]
	add	r3, r3, #1
	str	r3, [r2, #312]
.L91:
	cmn	r3, #1
	beq	.L92
	ldr	r2, [r6, r4, asl #2]
	b	.L93
.L97:
	mov	r3, #0
	str	r3, [r2, #1484]
	ldr	r2, [r6, r4, asl #2]
	b	.L96
.L90:
	add	r9, r5, r8
	movw	r3, #539
	ldr	r2, .L111+8
	mov	r0, #22
	ldr	r1, .L111+20
	mov	ip, #0
	str	ip, [r9, #312]
	bl	dprint_vfmw
	ldr	r3, [r9, #312]
	b	.L91
.L92:
	add	r3, r5, r8
	mov	r1, #11
	ldr	r2, [r6, r4, asl #2]
	str	r1, [r3, #312]
	b	.L94
.L112:
	.align	2
.L111:
	.word	s_pstVfmwChan
	.word	.LANCHOR0
	.word	.LANCHOR1
	.word	.LC4
	.word	.LC2
	.word	.LC3
	.fnend
	.size	VDMDRV_CheckAttachMode, .-VDMDRV_CheckAttachMode
	.align	2
	.global	VDMDRV_ChnDecReady
	.type	VDMDRV_ChnDecReady, %function
VDMDRV_ChnDecReady:
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
	mov	r5, r0
	bl	VCTRL_IsChanActive
	cmp	r0, #0
	bne	.L117
	ldr	ip, .L120
	add	ip, ip, r5, lsl #2
	ldr	r4, [ip, #184]
	cmp	r4, #0
	bne	.L118
	str	r4, [r6]
	mov	r0, r5
	bl	VCTRL_GetDecParam
	cmp	r0, #0
	str	r0, [r6]
	beq	.L119
.L115:
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L117:
	mov	r3, r5
	ldr	r2, .L120+4
	ldr	r1, .L120+8
	mov	r4, #1
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L118:
	mov	r2, r5
	ldr	r1, .L120+12
	mov	r4, #1
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L119:
	mov	r2, r5
	ldr	r1, .L120+16
	mov	r0, #22
	mov	r4, #1
	bl	dprint_vfmw
	b	.L115
.L121:
	.align	2
.L120:
	.word	.LANCHOR0
	.word	.LANCHOR1+24
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.fnend
	.size	VDMDRV_ChnDecReady, .-VDMDRV_ChnDecReady
	.align	2
	.global	VDMDRV_MMUIntServeProc
	.type	VDMDRV_MMUIntServeProc, %function
VDMDRV_MMUIntServeProc:
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
	ldr	r7, .L143
	ldr	r4, .L143+4
	mov	r5, r0
	mov	r0, #0
	ldr	r3, [r7, #12]
	blx	r3
	ldr	r3, [r4, #96]
	cmp	r3, #0
	beq	.L128
	mov	r1, r5
	mov	r0, #5
	blx	r3
	ldr	r3, [r4, #96]
	cmp	r3, #0
	mov	r8, r0
	beq	.L128
	mov	r1, r5
	mov	r0, #6
	blx	r3
	ldr	ip, [r4, #96]
	and	r9, r8, #7
	cmp	ip, #0
	moveq	r6, ip
	mov	r10, r0
	beq	.L123
	mov	r1, r5
	mov	r0, #7
	blx	ip
	mov	r6, r0
.L123:
	cmp	r9, #0
	beq	.L128
	cmp	r10, #0
	bne	.L141
	cmp	r6, #0
	bne	.L142
.L128:
	ldr	r3, [r4, #84]
	cmp	r3, #0
	beq	.L129
	mov	r0, r5
	blx	r3
.L130:
	ldr	r3, [r7, #16]
	mov	r0, #0
	blx	r3
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L129:
	mov	r0, r3
	movw	r2, #1673
	ldr	r1, .L143+8
	bl	dprint_vfmw
	b	.L130
.L142:
	mov	r3, r6
	mov	r2, r8
	ldr	r1, .L143+12
	mov	r0, #32
	bl	dprint_vfmw
	b	.L128
.L141:
	mov	r3, r10
	mov	r2, r8
	ldr	r1, .L143+16
	mov	r0, #32
	bl	dprint_vfmw
	cmp	r6, #0
	beq	.L128
	b	.L142
.L144:
	.align	2
.L143:
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_vdm_hal_fun_ptr
	.word	.LC1
	.word	.LC9
	.word	.LC8
	.fnend
	.size	VDMDRV_MMUIntServeProc, .-VDMDRV_MMUIntServeProc
	.align	2
	.global	VDMDRV_IsVdmInISR
	.type	VDMDRV_IsVdmInISR, %function
VDMDRV_IsVdmInISR:
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
	ldr	r3, .L146
	add	r0, r3, r0, lsl #2
	ldr	r0, [r0, #376]
	ldmfd	sp, {fp, sp, pc}
.L147:
	.align	2
.L146:
	.word	.LANCHOR0
	.fnend
	.size	VDMDRV_IsVdmInISR, .-VDMDRV_IsVdmInISR
	.align	2
	.global	VDMDRV_IsVdmIdle
	.type	VDMDRV_IsVdmIdle, %function
VDMDRV_IsVdmIdle:
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
	mul	r0, r3, r0
	ldr	r2, .L149
	ldr	r0, [r2, r0]
	adds	r0, r0, #0
	movne	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L150:
	.align	2
.L149:
	.word	.LANCHOR0
	.fnend
	.size	VDMDRV_IsVdmIdle, .-VDMDRV_IsVdmIdle
	.align	2
	.global	VDMDRV_GetCurrChanID
	.type	VDMDRV_GetCurrChanID, %function
VDMDRV_GetCurrChanID:
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
	ldr	r2, .L152
	mov	r3, #44
	mla	r0, r3, r0, r2
	ldr	r0, [r0, #8]
	ldmfd	sp, {fp, sp, pc}
.L153:
	.align	2
.L152:
	.word	.LANCHOR0
	.fnend
	.size	VDMDRV_GetCurrChanID, .-VDMDRV_GetCurrChanID
	.align	2
	.global	VDMDRV_WaitVdmReadyIfNoIsr
	.type	VDMDRV_WaitVdmReadyIfNoIsr, %function
VDMDRV_WaitVdmReadyIfNoIsr:
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
	ldr	r6, .L163
	mov	r5, r0
	mov	r4, #0
	b	.L156
.L158:
	add	r4, r4, #1
	cmp	r4, #400
	beq	.L157
.L156:
	ldr	r3, [r6, #120]
	mov	r0, r5
	cmp	r3, #0
	beq	.L158
	blx	r3
	cmp	r0, #0
	beq	.L158
.L157:
	cmp	r4, #400
	movcc	r0, #0
	movcs	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L164:
	.align	2
.L163:
	.word	g_vdm_hal_fun_ptr
	.fnend
	.size	VDMDRV_WaitVdmReadyIfNoIsr, .-VDMDRV_WaitVdmReadyIfNoIsr
	.align	2
	.global	VDMDRV_AvsFirstFldNeedRepair
	.type	VDMDRV_AvsFirstFldNeedRepair, %function
VDMDRV_AvsFirstFldNeedRepair:
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
	cmp	r0, #6
	beq	.L169
.L168:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L169:
	ldrb	r3, [r1, #17]
	cmp	r3, #1
	bne	.L168
	ldr	r3, .L170
	mov	r1, #1744
	mla	r2, r1, r2, r3
	ldr	r3, [r2, #1220]
	cmp	r3, #0
	movgt	r0, #1
	movle	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L171:
	.align	2
.L170:
	.word	.LANCHOR0
	.fnend
	.size	VDMDRV_AvsFirstFldNeedRepair, .-VDMDRV_AvsFirstFldNeedRepair
	.align	2
	.global	VDMDRV_AvsSecondFldNeedRepair
	.type	VDMDRV_AvsSecondFldNeedRepair, %function
VDMDRV_AvsSecondFldNeedRepair:
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
	cmp	r0, #6
	beq	.L176
.L175:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L176:
	ldrb	r3, [r1, #17]
	cmp	r3, #1
	bne	.L175
	ldr	r3, .L177
	mov	r1, #1744
	mla	r2, r1, r2, r3
	ldr	r3, [r2, #1712]
	cmp	r3, #0
	movgt	r0, #1
	movle	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L178:
	.align	2
.L177:
	.word	.LANCHOR0+380
	.fnend
	.size	VDMDRV_AvsSecondFldNeedRepair, .-VDMDRV_AvsSecondFldNeedRepair
	.align	2
	.global	VDMDRV_IsMpeg4NvopCopy
	.type	VDMDRV_IsMpeg4NvopCopy, %function
VDMDRV_IsMpeg4NvopCopy:
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
	beq	.L183
	cmp	r0, #2
	ldreqb	r0, [r4, #158]
	subeq	r0, r0, #1
	clzeq	r0, r0
	moveq	r0, r0, lsr #5
	movne	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L183:
	ldr	r1, .L184
	mov	r0, r4
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L185:
	.align	2
.L184:
	.word	.LC10
	.fnend
	.size	VDMDRV_IsMpeg4NvopCopy, .-VDMDRV_IsMpeg4NvopCopy
	.align	2
	.global	VDMDRV_IsVc1SkpicCopy
	.type	VDMDRV_IsVc1SkpicCopy, %function
VDMDRV_IsVc1SkpicCopy:
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
	beq	.L190
	cmp	r0, #1
	ldreqb	r0, [r4, #1]
	subeq	r0, r0, #1
	clzeq	r0, r0
	moveq	r0, r0, lsr #5
	movne	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L190:
	ldr	r1, .L191
	mov	r0, r4
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L192:
	.align	2
.L191:
	.word	.LC11
	.fnend
	.size	VDMDRV_IsVc1SkpicCopy, .-VDMDRV_IsVc1SkpicCopy
	.align	2
	.global	VDMDRV_IsVp6NvopCopy
	.type	VDMDRV_IsVp6NvopCopy, %function
VDMDRV_IsVp6NvopCopy:
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
	beq	.L197
	sub	r0, r0, #10
	cmp	r0, #2
	ldrlsb	r0, [r4, #1]
	subls	r0, r0, #1
	clzls	r0, r0
	movls	r0, r0, lsr #5
	movhi	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L197:
	ldr	r1, .L198
	mov	r0, r4
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L199:
	.align	2
.L198:
	.word	.LC12
	.fnend
	.size	VDMDRV_IsVp6NvopCopy, .-VDMDRV_IsVp6NvopCopy
	.align	2
	.global	VDMDRV_DoBeforeDec
	.type	VDMDRV_DoBeforeDec, %function
VDMDRV_DoBeforeDec:
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
	ldr	r3, .L249
	mov	r6, r0
	mov	r5, r1
	mov	r7, r2
	ldrb	r3, [r3]
	cmp	r3, #1
	moveq	r9, #0
	beq	.L201
	ldr	r3, .L249+4
	sub	r0, fp, #224
	mov	r2, #180
	mov	r1, #0
	mov	r9, r0
	ldr	r3, [r3, #48]
	blx	r3
.L201:
	ldr	r3, [r7]
	cmp	r3, #0
	beq	.L242
	mov	r0, r5
	ldr	r8, .L249+8
	bl	VCTRL_GetVidStd
	mov	r4, #44
	ldr	r3, .L249+12
	mla	r4, r4, r6, r8
	ldr	r3, [r3]
	cmp	r3, #0
	add	r4, r4, #8
	str	r0, [r4, #4]
	mov	r10, r0
	beq	.L204
	ldr	r2, [r7]
	sub	r0, fp, #236
	str	r5, [fp, #-236]
	str	r10, [fp, #-232]
	str	r2, [fp, #-228]
	blx	r3
	cmp	r0, #1
	mov	ip, r0
	beq	.L233
	ldr	r10, [r4, #4]
.L204:
	ldr	r1, [r7]
	cmp	r1, #0
	beq	.L243
	cmp	r10, #2
	beq	.L244
.L208:
	cmp	r10, #1
	beq	.L245
.L210:
	mov	r0, r10
	bl	VDMDRV_IsVp6NvopCopy
	cmp	r0, #1
	beq	.L246
	ldr	r3, .L249+16
	ldr	ip, [r3, #116]
	cmp	ip, #0
	beq	.L215
	mov	r4, #44
	ldr	r1, [r7]
	mla	r4, r4, r6, r8
	mov	r3, r9
	mov	r2, r6
	ldr	r7, .L249+8
	ldr	r0, [r4, #12]
	blx	ip
	subs	ip, r0, #0
	beq	.L247
.L215:
	mov	r7, #44
	ldr	r1, .L249+20
	mul	r9, r7, r6
	mov	r0, #0
	bl	dprint_vfmw
	str	r6, [sp]
	mov	r4, #0
	mov	lr, #100
	add	r6, r8, r9
	mov	r1, lr
	mov	r0, r5
	mov	r3, r4
	mov	r2, #15
	str	r4, [r8, r9]
	str	lr, [r6, #4]
	add	r5, r5, #32
	str	r4, [fp, #-240]
	bl	VCTRL_VdmPostProc
	ldr	r3, .L249+4
	mov	r0, r6
	mov	r2, r7
	mov	r1, r4
	add	r8, r8, r5, lsl #2
	ldr	r3, [r3, #48]
	blx	r3
	ldr	ip, [fp, #-240]
	str	r4, [r8, #56]
.L233:
	mov	r0, ip
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L244:
	ldrb	r3, [r1, #158]
	cmp	r3, #1
	bne	.L210
	mov	r0, r1
	mov	r2, r9
	mov	r1, r6
	bl	PostPro_CopyYuv
	subs	ip, r0, #0
	beq	.L248
.L212:
	mov	ip, #0
	mov	r0, ip
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L245:
	ldrb	r3, [r1, #1]
	cmp	r3, #1
	bne	.L210
	ldr	r1, .L249+24
	mov	r0, #22
	bl	dprint_vfmw
	mov	r2, r9
	mov	r1, r6
	ldr	r0, [r7]
	bl	PostPro_CopyYuv_Vc1
	subs	ip, r0, #0
	bne	.L212
	mov	r4, #44
	ldr	r7, .L249+4
	mla	r4, r4, r6, r8
	mov	r2, r9
	mov	r1, r6
	mov	r0, #2
	str	ip, [fp, #-240]
	add	r8, r8, r5, lsl #2
	ldr	r9, .L249+8
	str	ip, [r4, #4]
	bl	VDMDRV_StartRepair
	ldr	r3, [r7]
	blx	r3
	ldr	lr, .L249+28
	mov	r3, #84
	add	r1, r6, #1
	str	r1, [r8, #184]
	mla	r3, r3, r6, lr
	mov	r2, r0
	mov	r0, r5
	str	r2, [r4, #16]
	str	r2, [r3, #4]
	bl	VDMDRV_AdjustPriorityAfterDec
	mov	r0, #7
	bl	CHECK_REC_POS_ENABLE
	cmp	r0, #0
	beq	.L212
	ldr	r3, [r7]
	add	r9, r9, r5, lsl #2
	blx	r3
	ldr	r2, .L249+32
	ldr	r3, [r9, #2124]
	ldr	r2, [r2]
	rsb	r3, r3, r0
	mov	lr, r0
	cmp	r3, r2
	addhi	r2, r6, r5, lsl #24
	movhi	r1, #704
	bls	.L212
.L235:
	add	r2, r2, #458752
	ldr	r0, .L249+36
	str	lr, [r9, #2124]
	bl	DBG_AddTrace
	ldr	ip, [fp, #-240]
	b	.L233
.L247:
	ldr	r8, .L249+4
	mov	r1, r9
	mov	r0, r6
	str	ip, [fp, #-240]
	bl	VDMDRV_StartDec
	ldr	r9, .L249+28
	ldr	r3, [r8]
	blx	r3
	mov	r3, #84
	mla	r3, r3, r6, r9
	add	r1, r7, r5, lsl #2
	add	lr, r6, #1
	str	lr, [r1, #184]
	mov	r2, r0
	mov	r0, r5
	str	r2, [r3, #4]
	str	r2, [r4, #16]
	bl	VDMDRV_AdjustPriorityAfterDec
	ldr	ip, [fp, #-240]
	mov	r1, #5
	mov	r0, r5
	mov	r2, ip
	bl	DBG_CountTimeInfo
	mov	r0, #5
	bl	CHECK_REC_POS_ENABLE
	cmp	r0, #0
	beq	.L212
	ldr	r3, [r8]
	add	r7, r7, r5, lsl #2
	blx	r3
	ldr	r2, .L249+32
	ldr	r3, [r7, #2124]
	ldr	r2, [r2]
	rsb	r3, r3, r0
	mov	lr, r0
	cmp	r3, r2
	bls	.L212
	add	r2, r6, r5, lsl #24
	movw	r1, #778
	add	r2, r2, #327680
	ldr	r0, .L249+36
	str	lr, [r7, #2124]
	bl	DBG_AddTrace
	ldr	ip, [fp, #-240]
	b	.L233
.L242:
	mov	r2, r5
	ldr	r1, .L249+40
	mov	r0, #22
	mov	ip, #1
	str	ip, [fp, #-240]
	bl	dprint_vfmw
	ldr	ip, [fp, #-240]
	mov	r0, ip
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L246:
	ldr	r1, .L249+24
	mov	r0, #22
	bl	dprint_vfmw
	mov	r2, r9
	mov	r1, r6
	ldr	r0, [r7]
	bl	PostPro_CopyYuv_Vp6
	subs	ip, r0, #0
	bne	.L212
	mov	r4, #44
	ldr	r7, .L249+4
	mla	r4, r4, r6, r8
	mov	r2, r9
	mov	r1, r6
	mov	r0, #2
	str	ip, [fp, #-240]
	add	r8, r8, r5, lsl #2
	ldr	r9, .L249+8
	str	ip, [r4, #4]
	bl	VDMDRV_StartRepair
	ldr	r3, [r7]
	blx	r3
	ldr	lr, .L249+28
	mov	r3, #84
	add	r1, r6, #1
	str	r1, [r8, #184]
	mla	r3, r3, r6, lr
	mov	r2, r0
	mov	r0, r5
	str	r2, [r4, #16]
	str	r2, [r3, #4]
	bl	VDMDRV_AdjustPriorityAfterDec
	mov	r0, #7
	bl	CHECK_REC_POS_ENABLE
	cmp	r0, #0
	beq	.L212
	ldr	r3, [r7]
	add	r9, r9, r5, lsl #2
	blx	r3
	ldr	r2, .L249+32
	ldr	r3, [r9, #2124]
	ldr	r2, [r2]
	rsb	r3, r3, r0
	mov	lr, r0
	cmp	r3, r2
	bls	.L212
	add	r2, r6, r5, lsl #24
	movw	r1, #737
	b	.L235
.L243:
	mov	r4, #44
	mov	r0, r1
	mla	r4, r4, r6, r8
	ldr	r1, .L249+44
	bl	dprint_vfmw
	ldr	r1, [r7]
	add	r4, r4, #8
	cmp	r1, #0
	ldr	r10, [r4, #4]
	bne	.L208
	mov	r0, r1
	ldr	r1, .L249+48
	bl	dprint_vfmw
	ldr	r10, [r4, #4]
	ldr	r1, [r7]
	b	.L210
.L248:
	mov	r7, #44
	ldr	r4, .L249+4
	mla	r7, r7, r6, r8
	mov	r2, r9
	mov	r1, r6
	mov	r0, r10
	str	ip, [fp, #-240]
	add	r8, r8, r5, lsl #2
	ldr	r9, .L249+8
	str	ip, [r7, #4]
	bl	VDMDRV_StartRepair
	ldr	r3, [r4]
	blx	r3
	ldr	lr, .L249+28
	mov	r3, #84
	add	r1, r6, #1
	str	r1, [r8, #184]
	mla	r3, r3, r6, lr
	mov	r2, r0
	mov	r0, r5
	str	r2, [r7, #16]
	str	r2, [r3, #4]
	bl	VDMDRV_AdjustPriorityAfterDec
	mov	r0, #7
	bl	CHECK_REC_POS_ENABLE
	ldr	ip, [fp, #-240]
	cmp	r0, #0
	beq	.L212
	ldr	r3, [r4]
	add	r9, r9, r5, lsl #2
	str	ip, [fp, #-240]
	blx	r3
	ldr	r2, .L249+32
	ldr	r3, [r9, #2124]
	ldr	r2, [r2]
	rsb	r3, r3, r0
	mov	lr, r0
	cmp	r3, r2
	addhi	r2, r6, r5, lsl #24
	movwhi	r1, #671
	bls	.L212
	b	.L235
.L250:
	.align	2
.L249:
	.word	g_HalDisable
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.word	AcceleratorCharacter
	.word	g_vdm_hal_fun_ptr
	.word	.LC15
	.word	.LC14
	.word	g_VfmwGlobalStat
	.word	g_TraceFramePeriod
	.word	.LANCHOR1+44
	.word	.LC13
	.word	.LC10
	.word	.LC11
	.fnend
	.size	VDMDRV_DoBeforeDec, .-VDMDRV_DoBeforeDec
	.align	2
	.global	VDMDRV_ActivateVDH
	.type	VDMDRV_ActivateVDH, %function
VDMDRV_ActivateVDH:
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
	ldr	r9, .L258
	ldr	r6, .L258+4
	mov	r5, #44
	mul	r5, r5, r0
	ldr	r3, [r9, #12]
	mov	r8, r0
	mov	r0, #5
	blx	r3
	ldr	r3, [r6, #120]
	add	r7, r5, #40
	cmp	r3, #0
	add	r7, r6, r7
	blt	.L252
	add	r5, r6, r5
	add	r4, r6, #120
	add	r6, r6, #180
	b	.L253
.L256:
	cmp	r4, r6
	beq	.L252
	ldr	r3, [r4, #4]!
	cmp	r3, #0
	blt	.L252
.L253:
	mov	r0, r3
	mov	r1, r7
	str	r3, [r5, #8]
	bl	VDMDRV_ChnDecReady
	cmp	r0, #0
	bne	.L256
	mov	r2, r7
	ldr	r1, [r5, #8]
	mov	r0, r8
	bl	VDMDRV_DoBeforeDec
	cmp	r0, #0
	bne	.L256
.L252:
	ldr	r3, [r9, #16]
	mov	r0, #5
	blx	r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L259:
	.align	2
.L258:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.fnend
	.size	VDMDRV_ActivateVDH, .-VDMDRV_ActivateVDH
	.align	2
	.global	VDMDRV_AfterDec
	.type	VDMDRV_AfterDec, %function
VDMDRV_AfterDec:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #356
	sub	sp, sp, #356
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r3, .L317
	mov	r6, r0
	mov	r9, r1
	ldr	r8, .L317+4
	ldrb	r3, [r3]
	cmp	r3, #1
	moveq	r3, #0
	streq	r3, [fp, #-384]
	beq	.L261
	sub	r0, fp, #224
	mov	r2, #180
	mov	r1, #0
	ldr	r3, [r8, #48]
	str	r0, [fp, #-384]
	blx	r3
.L261:
	ldr	r4, .L317+8
	mov	r2, #136
	ldr	r3, [r8, #48]
	mov	r1, #0
	sub	r0, fp, #360
	mov	r5, #44
	blx	r3
	mov	r3, #180
	mla	r3, r3, r6, r4
	ldr	r1, .L317+12
	mul	r5, r5, r6
	mov	r0, #2
	ldr	r2, [r3, #2188]
	add	r10, r4, r5
	and	r2, r2, #15
	ldr	lr, [r10, #4]
	cmp	r2, #5
	ldr	r2, [r4, r5]
	ldreq	r7, [r3, #2200]
	ldrne	r7, [r3, #2196]
	ldr	r3, [r10, #24]
	andeq	r7, r7, #1
	str	lr, [sp]
	andne	r7, r7, #31
	bl	dprint_vfmw
	ldr	r5, [r4, r5]
	cmp	r5, #1
	beq	.L307
	cmp	r5, #2
	beq	.L308
	cmp	r5, #3
	beq	.L309
	ldr	r2, [r10, #8]
	mov	r3, r5
	str	r9, [sp]
	mov	r0, #0
	ldr	r1, .L317+16
	bl	dprint_vfmw
	ldr	r3, [r10, #8]
	ldr	r1, .L317+8
	mov	r2, #0
	add	r3, r3, #32
	add	r9, r1, r3, lsl #2
	str	r2, [r9, #56]
.L260:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L309:
	ldr	r3, [r10, #24]
	cmp	r3, #1
	moveq	r3, #0
	streq	r3, [r10, #24]
.L284:
	mov	r9, #44
	mov	r2, r7
	mul	ip, r9, r6
	str	r6, [sp]
	sub	r3, fp, #360
	mov	r5, #0
	add	r7, r4, ip
	ldr	r1, [r7, #4]
	ldr	r0, [r7, #8]
	cmp	r1, #100
	str	r5, [r4, ip]
	movge	r1, #100
	bic	r1, r1, r1, asr #31
	str	r1, [r7, #4]
.L303:
	bl	VCTRL_VdmPostProc
	ldr	r3, [r7, #8]
	mov	r2, r9
	ldr	ip, [r8, #48]
	add	r3, r3, #32
	mov	r1, r5
	mov	r0, r7
	add	r4, r4, r3, lsl #2
	str	r5, [r4, #56]
	blx	ip
	mov	r0, r6
	bl	VDMDRV_ActivateVDH
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L307:
	ldr	r3, [r10, #24]
	cmp	r3, #1
	beq	.L310
	mov	r1, #0
	ldr	r3, [r8, #48]
	mov	r2, #12
	sub	r0, fp, #372
	blx	r3
	ldr	r2, [r10, #12]
	ldr	r3, [r10, #40]
	sub	r0, fp, #372
	str	r6, [fp, #-372]
	str	r2, [fp, #-368]
	str	r3, [fp, #-364]
	bl	PostPro_GetErrRatio
	ldr	r2, [r10, #8]
	ldr	r1, .L317+20
	mov	lr, r0
	mov	r0, r5
	mov	r3, lr
	str	lr, [r10, #4]
	bl	dprint_vfmw
	ldr	r3, [r10, #12]
	sub	r2, r3, #8
	cmp	r3, #5
	cmpne	r2, #1
	movls	lr, #0
	bls	.L266
	ldr	lr, [r10, #4]
	cmp	lr, #0
	beq	.L266
	ldr	r3, .L317+24
	ldr	r5, [r3]
	cmp	r5, #0
	beq	.L301
	sub	r2, fp, #44
	mov	r3, #4
	mov	r1, #114
	ldr	r0, [r10, #8]
	str	lr, [r2, #-332]!
	blx	r5
.L302:
	ldr	lr, [r10, #4]
.L301:
	cmp	lr, #100
	movge	lr, #100
	bic	lr, lr, lr, asr #31
.L266:
	mov	r9, #44
	str	r6, [sp]
	mul	ip, r9, r6
	mov	r1, lr
	sub	r3, fp, #360
	mov	r2, r7
	mov	r7, #0
	add	r5, r4, ip
	str	r7, [r4, ip]
	str	lr, [r5, #4]
	ldr	r0, [r5, #8]
	bl	VCTRL_VdmPostProc
	ldr	r3, [r5, #8]
	mov	r2, r9
	ldr	ip, [r8, #48]
	add	r3, r3, #32
	mov	r1, r7
	mov	r0, r5
	add	r4, r4, r3, lsl #2
	str	r7, [r4, #56]
	blx	ip
	mov	r0, r6
	bl	VDMDRV_ActivateVDH
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L308:
	mov	r5, #44
	ldr	r3, [r10, #24]
	mla	r5, r5, r6, r4
	cmp	r3, #1
	ldr	r9, .L317+8
	moveq	r3, #0
	streq	r3, [r10, #24]
	ldr	r0, [r5, #12]
	ldr	r10, [r5, #40]
	cmp	r0, #6
	beq	.L311
.L271:
	cmp	r10, #0
	beq	.L312
	cmp	r0, #2
	beq	.L313
	mov	r3, #44
	mla	r3, r3, r6, r4
	ldr	r0, [r3, #12]
	ldr	r1, [r3, #40]
.L277:
	cmp	r0, #1
	beq	.L314
.L281:
	bl	VDMDRV_IsVp6NvopCopy
	cmp	r0, #1
	beq	.L279
	mov	r9, #44
	ldr	r10, .L317+8
	mul	ip, r9, r6
	add	r5, r4, ip
	ldr	r0, [r5, #40]
	ldr	r3, [r5, #12]
	cmp	r0, #0
	beq	.L315
	cmp	r3, #17
	bne	.L284
	add	r0, r0, #262144
	ldrb	r3, [r0, #1028]
	cmp	r3, #1
	bne	.L284
	mov	r4, #0
	ldr	r0, [r5, #8]
	sub	r3, fp, #360
	str	r6, [sp]
	mov	r2, r7
	str	r4, [r10, ip]
	mov	r1, r4
	str	r4, [r5, #4]
	bl	VCTRL_VdmPostProc
	ldr	r3, [r5, #8]
	mov	r2, r9
	ldr	ip, [r8, #48]
	add	r3, r3, #32
	mov	r1, r4
	mov	r0, r5
	add	r10, r10, r3, lsl #2
	str	r4, [r10, #56]
	blx	ip
	mov	r0, r6
	bl	VDMDRV_ActivateVDH
	b	.L260
.L311:
	ldrb	r2, [r10, #17]
	cmp	r2, #1
	bne	.L271
	mov	r3, #1744
	mla	r3, r3, r6, r9
	ldr	r3, [r3, #2092]
	cmp	r3, #0
	ble	.L271
	ldr	r3, .L317+28
	ldr	ip, [r3, #128]
	cmp	ip, #0
	beq	.L273
	ldr	r3, [fp, #-384]
	mov	r1, r10
	str	r3, [sp]
	mov	r3, r6
	blx	ip
	cmp	r0, #0
	beq	.L316
.L273:
	mov	r3, #44
	str	r6, [sp]
	mul	r6, r3, r6
	mov	r2, r7
	sub	r3, fp, #360
	mov	r1, #100
	add	r5, r4, r6
	ldr	r0, [r5, #8]
	bl	VCTRL_VdmPostProc
	ldr	r3, [r5, #8]
	mov	r2, #0
	str	r2, [r4, r6]
	add	r3, r3, #32
	add	r4, r4, r3, lsl #2
	str	r2, [r4, #56]
	b	.L260
.L310:
	mov	r2, r6
	ldr	r1, [r10, #40]
	ldr	r0, [r10, #12]
	bl	PostPro_SetFullRepair
	mov	r3, #0
	mov	lr, #100
	mov	r2, r9
	mov	r0, r3
	ldr	r1, .L317+32
	str	r3, [r10, #24]
	str	lr, [r10, #4]
	bl	dprint_vfmw
	b	.L302
.L313:
	ldrb	r3, [r10, #158]
	cmp	r3, #1
	beq	.L279
	mov	r3, #44
	mla	r3, r3, r6, r4
	ldr	r0, [r3, #12]
	ldr	r1, [r3, #40]
	b	.L281
.L314:
	ldrb	r3, [r1, #1]
	cmp	r3, #1
	bne	.L281
.L279:
	mov	r9, #44
	mov	r2, r7
	mul	ip, r9, r6
	mov	r5, #0
	str	r6, [sp]
	sub	r3, fp, #360
	mov	r1, r5
	add	r7, r4, ip
	str	r5, [r4, ip]
	ldr	r0, [r7, #8]
	str	r5, [r7, #4]
	b	.L303
.L316:
	ldr	r2, [fp, #-384]
	mov	r1, r6
	mov	r0, #3
	ldr	r4, .L317+4
	bl	VDMDRV_StartRepair
	ldr	r3, [r8]
	blx	r3
	ldr	r1, .L317+36
	mov	r3, #84
	mla	r3, r3, r6, r1
	mov	r2, r0
	mov	r0, #7
	str	r2, [r5, #16]
	str	r2, [r3, #4]
	bl	CHECK_REC_POS_ENABLE
	cmp	r0, #0
	beq	.L260
	ldr	r3, [r4]
	blx	r3
	ldr	r2, [r5, #8]
	ldr	r3, .L317+40
	add	r9, r9, r2, lsl #2
	ldr	r1, [r3]
	ldr	r3, [r9, #2368]
	rsb	r3, r3, r0
	mov	ip, r0
	cmp	r3, r1
	bls	.L260
	add	r2, r6, r2, lsl #24
	movw	r1, #1169
	add	r2, r2, #458752
	ldr	r0, .L317+44
	str	ip, [r9, #2368]
	bl	DBG_AddTrace
	b	.L260
.L312:
	mov	r5, #44
	ldr	r1, .L317+48
	mla	r5, r5, r6, r4
	mov	r0, r10
	bl	dprint_vfmw
	add	r9, r5, #8
	ldr	r1, [r5, #40]
	ldr	r0, [r9, #4]
	cmp	r1, #0
	bne	.L277
	ldr	r1, .L317+52
	mov	r0, r10
	bl	dprint_vfmw
	ldr	r0, [r9, #4]
	ldr	r1, [r5, #40]
	b	.L281
.L315:
	ldr	r1, .L317+56
	bl	dprint_vfmw
	b	.L284
.L318:
	.align	2
.L317:
	.word	g_HalDisable
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.word	.LC16
	.word	.LC20
	.word	.LC18
	.word	g_event_report
	.word	g_vdm_hal_fun_ptr
	.word	.LC17
	.word	g_VfmwGlobalStat
	.word	g_TraceFramePeriod
	.word	.LANCHOR1+64
	.word	.LC10
	.word	.LC11
	.word	.LC19
	.fnend
	.size	VDMDRV_AfterDec, .-VDMDRV_AfterDec
	.align	2
	.global	VDMDRV_CheckDevice
	.type	VDMDRV_CheckDevice, %function
VDMDRV_CheckDevice:
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
	mov	r5, #44
	mul	r5, r5, r0
	ldr	r4, .L353
	mov	r6, r0
	add	r7, r4, r5
	ldr	r0, [r7, #8]
	bl	VCTRL_GetDecParam
	cmp	r0, #0
	beq	.L349
.L320:
	mov	r3, #44
	mul	r3, r3, r6
	add	r5, r4, r3
	ldr	r3, [r4, r3]
	cmp	r3, #0
	bne	.L350
.L321:
	add	r4, r4, r6, lsl #2
	ldr	r0, [r4, #44]
	cmp	r0, #0
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	cmp	r0, #1
	beq	.L351
.L326:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L350:
	ldr	r3, .L353+4
	ldr	r3, [r3]
	blx	r3
	ldr	r3, [r5, #16]
	cmp	r0, r3
	str	r0, [r5, #20]
	bcc	.L324
	clz	r2, r3
	rsb	r3, r3, r0
	mov	r2, r2, lsr #5
	orrs	r7, r2, r3, lsr #31
	bne	.L324
	cmp	r3, #1000
	bls	.L326
	ldr	r2, [r5, #8]
	mov	r0, #1
	ldr	r1, .L353+8
	bl	dprint_vfmw
	ldr	r3, .L353+12
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L329
	ldr	r0, [r5, #8]
	mov	r3, r7
	mov	r2, r7
	mov	r1, #101
	blx	ip
.L329:
	ldr	r3, .L353+16
	ldrb	r3, [r3]
	cmp	r3, #1
	beq	.L330
	mov	r1, r6
	mov	r0, #1
	bl	VDH_Reset_Module
.L331:
	mov	r3, #44
	mov	r5, #1
	mul	r3, r3, r6
	ldr	r2, .L353
	add	r4, r4, r3
	ldr	r1, [r4, #32]
	str	r5, [r4, #24]
	cmp	r1, r5
	bne	.L333
	ldr	ip, [r4, #8]
	mov	r1, #0
	str	r1, [r2, r3]
	mov	r0, r1
	add	ip, ip, #32
	str	r1, [r4, #32]
	str	r1, [r4, #24]
	add	r2, r2, ip, lsl #2
	str	r1, [r2, #56]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L324:
	str	r0, [r5, #16]
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L351:
	mov	r3, #2
	str	r3, [r4, #44]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L349:
	ldr	r3, [r4, r5]
	cmp	r3, #0
	beq	.L321
	ldr	r2, .L353+20
	ldr	r2, [r2, #124]
	cmp	r2, #0
	beq	.L322
	mov	r0, r6
	blx	r2
	ldr	r3, [r4, r5]
	cmp	r0, #0
	bne	.L352
.L322:
	mov	r8, #44
	ldr	r1, .L353+24
	mul	r9, r8, r6
	mov	r0, #1
	mov	r7, #0
	add	r5, r4, r9
	ldr	r2, [r5, #8]
	bl	dprint_vfmw
	ldr	r2, [r4, r9]
	movw	r1, #1286
	ldr	r0, .L353+28
	str	r7, [r5, #32]
	bl	DBG_AddTrace
	ldr	r3, .L353+4
	mov	r2, r8
	mov	r0, r5
	mov	r1, r7
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r3, [r5, #8]
	add	r3, r3, #32
	add	r3, r4, r3, lsl #2
	str	r7, [r3, #56]
	b	.L320
.L333:
	mov	r0, r6
	mov	r1, #0
	bl	VDMDRV_AfterDec
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L330:
	ldr	r3, .L353+20
	ldr	r3, [r3, #68]
	cmp	r3, #0
	beq	.L332
	mov	r0, r6
	blx	r3
	b	.L331
.L352:
	mov	r0, #1
	ldr	r2, [r7, #8]
	ldr	r1, .L353+32
	bl	dprint_vfmw
	mov	r3, #1
	str	r3, [r7, #32]
	b	.L320
.L332:
	mov	r0, r3
	movw	r2, #1337
	ldr	r1, .L353+36
	bl	dprint_vfmw
	b	.L331
.L354:
	.align	2
.L353:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC23
	.word	g_event_report
	.word	g_HalDisable
	.word	g_vdm_hal_fun_ptr
	.word	.LC22
	.word	.LANCHOR1+80
	.word	.LC21
	.word	.LC1
	.fnend
	.size	VDMDRV_CheckDevice, .-VDMDRV_CheckDevice
	.align	2
	.global	VDMDRV_WakeUpVdm
	.type	VDMDRV_WakeUpVdm, %function
VDMDRV_WakeUpVdm:
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
	bl	VDMDRV_CheckDevice
	cmp	r0, #0
	ldmnefd	sp, {fp, sp, pc}
	bl	VDMDRV_ActivateVDH
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VDMDRV_WakeUpVdm, .-VDMDRV_WakeUpVdm
	.global	__aeabi_uidiv
	.align	2
	.global	VDMDRV_VdmIntServProc
	.type	VDMDRV_VdmIntServProc, %function
VDMDRV_VdmIntServProc:
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
	subs	r4, r0, #0
	mov	r3, #15
	str	r3, [fp, #-56]
	ble	.L358
	mov	r0, #0
	mov	r3, r4
	str	r0, [sp]
	ldr	r2, .L401
	ldr	r1, .L401+4
	bl	dprint_vfmw
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L358:
	ldr	r5, .L401+8
	mov	r0, #0
	ldr	r8, .L401+12
	ldr	r3, [r5, #12]
	blx	r3
	ldr	r3, [r8, #96]
	cmp	r3, #0
	beq	.L362
	mov	r1, r4
	mov	r0, #2
	blx	r3
	tst	r0, #1
	bne	.L394
.L362:
	mov	r3, #44
	ldr	r2, .L401+16
	mul	r3, r3, r4
	mov	r1, #0
	str	r1, [r2, r3]
.L361:
	ldr	r3, .L401+20
	ldrb	r3, [r3]
	cmp	r3, #1
	beq	.L381
	mov	r1, r4
	mov	r0, #1
	bl	VDH_Notify_ModuleIdle
.L381:
	ldr	r3, [r5, #16]
	mov	r0, #0
	blx	r3
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L394:
	ldr	r6, .L401+16
	mov	r7, r4, asl #2
	mov	ip, #1
	ldr	r3, [r5, #48]
	add	r1, r6, r7
	mov	r2, #8
	sub	r0, fp, #52
	str	ip, [r1, #376]
	mov	r1, #0
	blx	r3
	ldr	r3, [r8, #136]
	sub	r2, fp, #56
	str	r4, [fp, #-48]
	cmp	r3, #0
	str	r2, [fp, #-52]
	beq	.L363
	sub	r0, fp, #52
	blx	r3
.L364:
	ldr	r3, [r8, #80]
	cmp	r3, #0
	beq	.L365
	mov	r0, r4
	blx	r3
.L366:
	mov	r8, #44
	mov	r2, #0
	mla	r8, r8, r4, r6
	mov	r1, #6
	ldr	r9, .L401+16
	ldr	r0, [r8, #8]
	bl	DBG_CountTimeInfo
	mov	r0, #6
	bl	CHECK_REC_POS_ENABLE
	cmp	r0, #0
	bne	.L395
.L368:
	mov	r2, #44
	ldr	r3, .L401+16
	mul	r2, r2, r4
	add	r1, r6, r2
	ldr	r0, [r1, #32]
	cmp	r0, #1
	beq	.L396
	mov	r10, #84
	mov	r1, #180
	mul	r10, r10, r4
	ldr	r8, .L401+24
	mla	r1, r1, r4, r3
	add	r3, r3, r7
	add	r9, r8, r10
	ldr	r2, [r3, #2496]
	ldr	r0, [r9, #4]
	ldr	r1, [r1, #2212]
	cmp	r0, #0
	add	r2, r2, r1
	str	r2, [r3, #2496]
	bne	.L397
.L372:
	mov	r3, #44
	mul	r3, r3, r4
	add	r8, r6, r3
	ldr	r2, [r6, r3]
	cmp	r2, #0
	beq	.L376
	ldr	r9, [r8, #40]
	cmp	r9, #0
	beq	.L398
.L376:
	mov	r9, #44
	ldr	r8, .L401+16
	mul	r9, r9, r4
	add	r10, r6, r9
	ldr	r0, [r10, #8]
	bl	VCTRL_IsChanActive
	cmp	r0, #0
	bne	.L399
	ldr	r0, [r10, #8]
	bl	VCTRL_GetDecParam
	subs	ip, r0, #0
	beq	.L400
	mov	r1, #1
	mov	r0, r4
	bl	VDMDRV_AfterDec
.L379:
	mov	r3, #44
	add	r7, r6, r7
	mla	r6, r3, r4, r6
	mov	r3, #0
	str	r3, [r7, #376]
	ldr	r0, [r6, #8]
	bl	VCTRL_InformVdmFree
	b	.L361
.L399:
	ldr	r3, [r10, #8]
	movw	r2, #1574
	ldr	r1, .L401+28
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r3, [r10, #8]
	mov	r2, #0
	str	r2, [r8, r9]
	add	r3, r3, #32
	add	r3, r8, r3, lsl #2
	str	r2, [r3, #56]
	b	.L379
.L395:
	ldr	r3, [r5]
	blx	r3
	ldr	r2, [r8, #8]
	ldr	r3, .L401+32
	add	r9, r9, r2, lsl #2
	ldr	r1, [r3]
	ldr	r3, [r9, #2432]
	rsb	r3, r3, r0
	mov	ip, r0
	cmp	r3, r1
	bls	.L368
	add	r2, r4, r2, lsl #24
	movw	r1, #1501
	add	r2, r2, #393216
	ldr	r0, .L401+36
	str	ip, [r9, #2432]
	bl	DBG_AddTrace
	b	.L368
.L396:
	ldr	r0, [r1, #8]
	mov	ip, #0
	str	ip, [r1, #32]
	add	r1, r0, #32
	str	ip, [r3, r2]
	add	r3, r3, r1, lsl #2
	str	ip, [r3, #56]
	b	.L361
.L397:
	ldr	r3, [r5]
	blx	r3
	mov	ip, #180
	ldr	r1, [r8, r10]
	mov	lr, #84
	mla	ip, ip, r4, r6
	ldr	r2, [r9, #4]
	mul	lr, lr, r4
	add	r3, r1, #49920
	add	r3, r3, #80
	cmp	r3, r2
	strcc	r2, [r8, r10]
	add	r8, r8, lr
	ldr	r10, [ip, #2212]
	ldrcs	r3, [r9, #8]
	movcc	r1, r2
	movcc	r3, #0
	str	lr, [fp, #-64]
	ldr	lr, [r8, #52]
	ldr	ip, .L401+24
	add	r10, lr, r10, lsr #10
	str	r10, [r8, #52]
	rsb	r9, r1, r0
	ldr	r1, [r8, #48]
	cmp	r9, #1000
	rsb	r0, r2, r0
	add	r0, r0, r3
	add	r1, r1, #1
	add	r3, r8, #8
	add	r2, r8, #48
	str	r3, [fp, #-68]
	mov	r3, #0
	str	r0, [r8, #8]
	str	r1, [r8, #48]
	str	r3, [r8, #4]
	bcc	.L372
	mov	lr, #1000
	mov	r1, r9
	mul	r0, lr, r0
	str	r2, [fp, #-80]
	str	r3, [fp, #-76]
	str	ip, [fp, #-72]
	bl	__aeabi_uidiv
	ldr	r3, [fp, #-76]
	ldr	r2, [fp, #-64]
	ldr	ip, [fp, #-72]
	str	r3, [r8, #48]
	str	r10, [r8, #56]
	str	r3, [ip, r2]
	ldr	r2, [fp, #-80]
	str	r9, [r8, #60]
	str	r3, [r2, #4]
	ldr	r3, [fp, #-68]
	str	r0, [r3, #4]
	b	.L372
.L365:
	mov	r0, r3
	movw	r2, #1487
	ldr	r1, .L401+40
	bl	dprint_vfmw
	b	.L366
.L363:
	mov	r0, r3
	movw	r2, #1485
	ldr	r1, .L401+40
	bl	dprint_vfmw
	b	.L364
.L400:
	ldr	r3, [r10, #8]
	mov	r2, #1584
	ldr	r1, .L401+44
	str	ip, [fp, #-64]
	bl	dprint_vfmw
	ldr	r3, [r10, #8]
	ldr	ip, [fp, #-64]
	add	r3, r8, r3, lsl #2
	str	ip, [r8, r9]
	str	ip, [r3, #184]
	b	.L379
.L398:
	ldr	r1, .L401+48
	mov	r0, r9
	bl	dprint_vfmw
	ldr	r0, [r8, #8]
	bl	VCTRL_GetDecParam
	cmp	r0, #0
	beq	.L377
	ldr	r0, [r8, #8]
	mov	r3, r9
	ldr	r2, [fp, #-56]
	mov	r1, #100
	str	r4, [sp]
	bl	VCTRL_VdmPostProc
.L377:
	mov	r2, #44
	mov	r1, #0
	mul	r2, r2, r4
	add	r3, r6, r2
	ldr	r3, [r3, #8]
	str	r1, [r6, r2]
	add	r3, r3, #32
	add	r6, r6, r3, lsl #2
	str	r1, [r6, #56]
	b	.L361
.L402:
	.align	2
.L401:
	.word	.LANCHOR1+100
	.word	.LC24
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_vdm_hal_fun_ptr
	.word	.LANCHOR0
	.word	g_HalDisable
	.word	g_VfmwGlobalStat
	.word	.LC26
	.word	g_TraceFramePeriod
	.word	.LANCHOR1+124
	.word	.LC1
	.word	.LC27
	.word	.LC25
	.fnend
	.size	VDMDRV_VdmIntServProc, .-VDMDRV_VdmIntServProc
	.align	2
	.global	VDMDRV_IsVp9RptFrmCopy
	.type	VDMDRV_IsVp9RptFrmCopy, %function
VDMDRV_IsVp9RptFrmCopy:
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
	beq	.L407
	cmp	r0, #17
	addeq	r0, r4, #262144
	ldreqb	r0, [r0, #1028]
	subeq	r0, r0, #1
	clzeq	r0, r0
	moveq	r0, r0, lsr #5
	movne	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L407:
	ldr	r1, .L408
	mov	r0, r4
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L409:
	.align	2
.L408:
	.word	.LC19
	.fnend
	.size	VDMDRV_IsVp9RptFrmCopy, .-VDMDRV_IsVp9RptFrmCopy
	.align	2
	.global	VDMDRV_ResetVDH
	.type	VDMDRV_ResetVDH, %function
VDMDRV_ResetVDH:
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
	ldr	r4, .L415
	ldr	r3, [r4, #8]
	cmp	r3, r0
	ldmnefd	sp, {r4, r5, fp, sp, pc}
	ldr	r3, .L415+4
	ldrb	r3, [r3]
	cmp	r3, #1
	beq	.L412
	mov	r1, #0
	mov	r0, #1
	bl	VDH_Reset_Module
.L413:
	mov	r3, #0
	str	r3, [r4]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L412:
	ldr	r3, .L415+8
	ldr	r3, [r3, #68]
	cmp	r3, #0
	beq	.L414
	mov	r0, #0
	blx	r3
	b	.L413
.L414:
	mov	r0, r3
	movw	r2, #1908
	ldr	r1, .L415+12
	bl	dprint_vfmw
	b	.L413
.L416:
	.align	2
.L415:
	.word	.LANCHOR0
	.word	g_HalDisable
	.word	g_vdm_hal_fun_ptr
	.word	.LC1
	.fnend
	.size	VDMDRV_ResetVDH, .-VDMDRV_ResetVDH
	.align	2
	.global	VDMDRV_MarkReloadDsp
	.type	VDMDRV_MarkReloadDsp, %function
VDMDRV_MarkReloadDsp:
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
	subs	lr, r0, #0
	mov	ip, r1
	bne	.L417
	add	r3, r1, #1
	cmp	r3, #16
	bhi	.L417
	ldr	r3, .L424
	cmn	r1, #1
	mov	r2, #1
	str	r2, [r3, #36]
	beq	.L417
	ldr	r4, .L424+4
	mvn	r5, #0
	movw	r3, #1938
	ldr	r2, .L424+8
	ldr	r1, .L424+12
	mov	r0, #22
	ldr	ip, [r4, ip, asl #2]
	str	r5, [ip, #36]
	ldr	ip, [r4]
	ldr	ip, [ip, #36]
	str	lr, [sp]
	str	ip, [sp, #4]
	bl	dprint_vfmw
.L417:
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L425:
	.align	2
.L424:
	.word	.LANCHOR0
	.word	s_pstVfmwChan
	.word	.LANCHOR1+148
	.word	.LC28
	.fnend
	.size	VDMDRV_MarkReloadDsp, .-VDMDRV_MarkReloadDsp
	.align	2
	.global	VDMDRV_UpdateMatchMode
	.type	VDMDRV_UpdateMatchMode, %function
VDMDRV_UpdateMatchMode:
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
	cmp	r0, #0
	mov	ip, r1
	bne	.L426
	cmp	r1, #15
	bls	.L428
.L426:
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L428:
	ldr	lr, .L429
	mov	r5, #1
	movw	r3, #1951
	ldr	r2, .L429+4
	ldr	r1, .L429+8
	mov	r0, #22
	ldr	r4, [lr, ip, asl #2]
	str	r5, [r4, #36]
	ldr	lr, [lr, ip, asl #2]
	str	ip, [sp, #4]
	ldr	ip, [lr, #36]
	str	ip, [sp]
	bl	dprint_vfmw
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L430:
	.align	2
.L429:
	.word	s_pstVfmwChan
	.word	.LANCHOR1+172
	.word	.LC29
	.fnend
	.size	VDMDRV_UpdateMatchMode, .-VDMDRV_UpdateMatchMode
	.global	g_VdmExtParam
	.global	g_DspDrvState
	.global	g_VdmDrvParam
	.global	USE_FF_APT_EN
	.global	g_ChanCtx
	.global	g_BackUp
	.global	g_DecReport
	.global	g_RepairParam
	.global	g_HwMem
	.global	g_UpMsg
	.global	CapItem
	.section	.rodata
	.align	2
.LANCHOR1 = . + 0
	.type	__func__.14771, %object
	.size	__func__.14771, 23
__func__.14771:
	.ascii	"VDMDRV_CheckAttachMode\000"
	.space	1
	.type	__func__.14776, %object
	.size	__func__.14776, 19
__func__.14776:
	.ascii	"VDMDRV_ChnDecReady\000"
	.space	1
	.type	__FUNCTION__.14794, %object
	.size	__FUNCTION__.14794, 19
__FUNCTION__.14794:
	.ascii	"VDMDRV_DoBeforeDec\000"
	.space	1
	.type	__FUNCTION__.14828, %object
	.size	__FUNCTION__.14828, 16
__FUNCTION__.14828:
	.ascii	"VDMDRV_AfterDec\000"
	.type	__FUNCTION__.14838, %object
	.size	__FUNCTION__.14838, 19
__FUNCTION__.14838:
	.ascii	"VDMDRV_CheckDevice\000"
	.space	1
	.type	__func__.14853, %object
	.size	__func__.14853, 22
__func__.14853:
	.ascii	"VDMDRV_VdmIntServProc\000"
	.space	2
	.type	__FUNCTION__.14855, %object
	.size	__FUNCTION__.14855, 22
__FUNCTION__.14855:
	.ascii	"VDMDRV_VdmIntServProc\000"
	.space	2
	.type	__func__.14933, %object
	.size	__func__.14933, 21
__func__.14933:
	.ascii	"VDMDRV_MarkReloadDsp\000"
	.space	3
	.type	__func__.14938, %object
	.size	__func__.14938, 23
__func__.14938:
	.ascii	"VDMDRV_UpdateMatchMode\000"
	.data
	.align	2
	.type	USE_FF_APT_EN, %object
	.size	USE_FF_APT_EN, 4
USE_FF_APT_EN:
	.word	1
	.type	CapItem, %object
	.size	CapItem, 924
CapItem:
	.word	176
	.word	144
	.word	4
	.word	10
	.word	11
	.word	12
	.word	524288
	.word	352
	.word	288
	.word	4
	.word	10
	.word	11
	.word	12
	.word	786432
	.word	720
	.word	576
	.word	4
	.word	10
	.word	11
	.word	12
	.word	1048576
	.word	1280
	.word	736
	.word	4
	.word	10
	.word	11
	.word	12
	.word	2097152
	.word	1920
	.word	1088
	.word	4
	.word	10
	.word	11
	.word	12
	.word	3145728
	.word	176
	.word	144
	.word	15
	.word	19
	.word	22
	.word	24
	.word	524288
	.word	352
	.word	288
	.word	15
	.word	19
	.word	22
	.word	24
	.word	786432
	.word	720
	.word	576
	.word	9
	.word	15
	.word	16
	.word	17
	.word	1048576
	.word	1280
	.word	736
	.word	6
	.word	13
	.word	13
	.word	14
	.word	2097152
	.word	1920
	.word	1088
	.word	6
	.word	13
	.word	13
	.word	13
	.word	2097152
	.word	5632
	.word	4224
	.word	1
	.word	3
	.word	3
	.word	3
	.word	16777216
	.word	1280
	.word	800
	.word	6
	.word	13
	.word	13
	.word	14
	.word	2097152
	.word	800
	.word	1280
	.word	6
	.word	13
	.word	13
	.word	14
	.word	2097152
	.word	1488
	.word	1280
	.word	6
	.word	13
	.word	13
	.word	14
	.word	3145728
	.word	1280
	.word	1488
	.word	6
	.word	13
	.word	13
	.word	14
	.word	3145728
	.word	2160
	.word	1280
	.word	6
	.word	13
	.word	13
	.word	13
	.word	3145728
	.word	1280
	.word	2176
	.word	6
	.word	13
	.word	13
	.word	13
	.word	3145728
	.word	2160
	.word	2176
	.word	4
	.word	11
	.word	11
	.word	11
	.word	4194304
	.word	4096
	.word	2304
	.word	2
	.word	9
	.word	9
	.word	9
	.word	5242880
	.word	2304
	.word	4096
	.word	2
	.word	9
	.word	9
	.word	9
	.word	5242880
	.word	4096
	.word	4096
	.word	2
	.word	9
	.word	9
	.word	9
	.word	8388608
	.word	8192
	.word	4096
	.word	2
	.word	9
	.word	9
	.word	9
	.word	10485760
	.word	4096
	.word	8192
	.word	2
	.word	9
	.word	9
	.word	9
	.word	10485760
	.word	8192
	.word	8192
	.word	1
	.word	3
	.word	3
	.word	3
	.word	20971520
	.word	1920
	.word	1088
	.word	1
	.word	3
	.word	3
	.word	3
	.word	2097152
	.word	1920
	.word	1088
	.word	1
	.word	3
	.word	3
	.word	3
	.word	2097152
	.word	1920
	.word	1088
	.word	17
	.word	26
	.word	26
	.word	26
	.word	2097152
	.word	192
	.word	192
	.word	15
	.word	19
	.word	22
	.word	24
	.word	524288
	.word	384
	.word	320
	.word	15
	.word	19
	.word	22
	.word	24
	.word	786432
	.word	768
	.word	576
	.word	9
	.word	15
	.word	16
	.word	17
	.word	1048576
	.word	1280
	.word	768
	.word	6
	.word	13
	.word	13
	.word	14
	.word	2097152
	.word	1920
	.word	1088
	.word	6
	.word	13
	.word	13
	.word	13
	.word	2097152
	.word	4096
	.word	2304
	.word	4
	.word	4
	.word	4
	.word	4
	.word	16777216
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"====== forece VDM sleep! ======\012\000"
	.space	3
.LC1:
	.ascii	"VDMHAL_NULL_FUN_PRINT,L%d\012\000"
	.space	1
.LC2:
	.ascii	"%s,%d,  frameRate = %d,last = %d\012\000"
	.space	2
.LC3:
	.ascii	"%s,%d, the frameRate change!\012\000"
	.space	2
.LC4:
	.ascii	"%s,%d,chanid = %d,s32Is4k60fpsb = %d\012\000"
	.space	2
.LC5:
	.ascii	"%s The channel %d is not active\012\000"
	.space	3
.LC6:
	.ascii	"The channel %d is decoding\012\000"
.LC7:
	.ascii	"The channel %d DEC PARAM is not ready\012\000"
	.space	1
.LC8:
	.ascii	"SMMU_READ_ERR  MODULE : VFMW \011 SMMU INT STATE: 0"
	.ascii	"x%x \011 read_err_addr  = 0x%x\012\000"
	.space	3
.LC9:
	.ascii	"SMMU_WRITE_ERR MODULE : VFMW \011 SMMU INT STATE: 0"
	.ascii	"x%x \011 write_err_addr = 0x%x\012\000"
	.space	3
.LC10:
	.ascii	"VDMHAL_V200_IsMpeg4NvopCopy point of picture para n"
	.ascii	"ull, wait forever!!!\012\000"
	.space	3
.LC11:
	.ascii	"VDMDRV_IsVc1SkpicCopy point of picture para null, w"
	.ascii	"ait forever!!!\012\000"
	.space	1
.LC12:
	.ascii	"VDMDRV_IsVp6NvopCopy point of picture para null, wa"
	.ascii	"it forever!!!\012\000"
	.space	2
.LC13:
	.ascii	"The channel %d DEC PARAM is not ready(pDecParam == "
	.ascii	"NULL)\012\000"
	.space	2
.LC14:
	.ascii	"---SKIP REPAIR!---\012\000"
.LC15:
	.ascii	"VDM Start Fail 2 !\012\000"
.LC16:
	.ascii	"isr begin: *pVdmStateMachine = %d, timeout = %d, Er"
	.ascii	"rRatio = %d\012\000"
.LC17:
	.ascii	"ISR process vdm timeout! FromInt = %d\012\000"
	.space	1
.LC18:
	.ascii	"Chan %d: ErrRatio = %d\012\000"
.LC19:
	.ascii	"VDMDRV_IsVp9RptFrmCopy point of picture para null, "
	.ascii	"wait forever!!!\012\000"
.LC20:
	.ascii	"Chan %d VdmStateMachine=%d Error! FromInt = %d.\012"
	.ascii	"\000"
	.space	3
.LC21:
	.ascii	"Chan %d Mfde Running VdmStateMachine = %d, but DecP"
	.ascii	"aram = NULL!\012\000"
	.space	3
.LC22:
	.ascii	"Chan %d VdmStateMachine = %d, but DecParam = NULL, "
	.ascii	"Reset VDH MFDE!\012\000"
.LC23:
	.ascii	"Chan %d VDM Time Out(%d ms), Reset VDM!\012\000"
	.space	3
.LC24:
	.ascii	"%s: VdhId(%d) > %d\012\000"
.LC25:
	.ascii	"vdm state machine = %d, but DecParam is null!\012\000"
	.space	1
.LC26:
	.ascii	"line :%d ISR called but chan %d is not active!\012\000"
.LC27:
	.ascii	"lline: %d ISR called but chan %d param = NULL!\012\000"
.LC28:
	.ascii	"%s,%d, i = %d, MatchVdhIdPlus1 = %d\012\000"
	.space	3
.LC29:
	.ascii	"%s,%d, MatchVdhIdPlus1 = %d,chanId = %d\012\000"
	.bss
	.align	2
.LANCHOR0 = . + 0
	.type	g_VdmDrvParam, %object
	.size	g_VdmDrvParam, 44
g_VdmDrvParam:
	.space	44
	.type	s_eVdmDrvSleepState, %object
	.size	s_eVdmDrvSleepState, 4
s_eVdmDrvSleepState:
	.space	4
	.type	g_DspDrvState, %object
	.size	g_DspDrvState, 8
g_DspDrvState:
	.space	8
	.type	g_ChanCtx, %object
	.size	g_ChanCtx, 192
g_ChanCtx:
	.space	192
	.type	g_LastFPS.14768, %object
	.size	g_LastFPS.14768, 64
g_LastFPS.14768:
	.space	64
	.type	DiffFrameCnt.14767, %object
	.size	DiffFrameCnt.14767, 64
DiffFrameCnt.14767:
	.space	64
	.type	s_VdmIsInISR, %object
	.size	s_VdmIsInISR, 4
s_VdmIsInISR:
	.space	4
	.type	g_RepairParam, %object
	.size	g_RepairParam, 1744
g_RepairParam:
	.space	1744
	.type	last_rec_pos_time.14790, %object
	.size	last_rec_pos_time.14790, 64
last_rec_pos_time.14790:
	.space	64
	.type	g_BackUp, %object
	.size	g_BackUp, 180
g_BackUp:
	.space	180
	.type	last_rec_pos_time.14821, %object
	.size	last_rec_pos_time.14821, 64
last_rec_pos_time.14821:
	.space	64
	.type	last_rec_pos_time.14849, %object
	.size	last_rec_pos_time.14849, 64
last_rec_pos_time.14849:
	.space	64
	.type	cycle.14848, %object
	.size	cycle.14848, 8
cycle.14848:
	.space	8
	.type	g_VdmExtParam, %object
	.size	g_VdmExtParam, 140
g_VdmExtParam:
	.space	140
	.type	g_DecReport, %object
	.size	g_DecReport, 816
g_DecReport:
	.space	816
	.type	g_HwMem, %object
	.size	g_HwMem, 1224
g_HwMem:
	.space	1224
	.type	g_UpMsg, %object
	.size	g_UpMsg, 3200
g_UpMsg:
	.space	3200
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
