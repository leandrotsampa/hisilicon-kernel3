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
	.file	"vfmw_ctrl.c"

	.text
	.align	2
	.global	VCTRL_EventReport
	.type	VCTRL_EventReport, %function
VCTRL_EventReport:
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
	cmp	r0, #15
	bhi	.L13
	ldr	lr, .L17
	ldr	ip, [lr, r0, asl #2]
	cmp	ip, #0
	beq	.L14
	ldr	ip, [ip, #40]
	cmp	ip, #0
	beq	.L6
	cmp	ip, #1
	bne	.L15
	ldr	r3, [lr, #308]
	cmp	r3, #0
	beq	.L16
.L9:
	blx	r3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L15:
	str	r3, [sp]
	mov	r0, #0
	mov	r3, ip
	ldr	r2, .L17+4
	ldr	r1, .L17+8
	bl	dprint_vfmw
	mvn	r0, #0
.L3:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L6:
	ldr	r3, [lr, #304]
	cmp	r3, #0
	bne	.L9
	mov	r0, r3
	ldr	r1, .L17+12
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3
.L16:
	mov	r0, r3
	ldr	r1, .L17+16
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3
.L13:
	ldr	r3, .L17+20
	mov	r2, #1056
	ldr	r1, .L17+24
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3
.L14:
	mov	r0, ip
	ldr	r3, .L17+28
	movw	r2, #1057
	ldr	r1, .L17+24
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3
.L18:
	.align	2
.L17:
	.word	.LANCHOR0
	.word	.LANCHOR1
	.word	.LC5
	.word	.LC3
	.word	.LC4
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.fnend
	.size	VCTRL_EventReport, .-VCTRL_EventReport
	.align	2
	.global	VCTRL_Isr_0
	.type	VCTRL_Isr_0, %function
VCTRL_Isr_0:
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
	bl	VDMDRV_VdmIntServProc
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VCTRL_Isr_0, .-VCTRL_Isr_0
	.align	2
	.global	VCTRL_Scd_Isr
	.type	VCTRL_Scd_Isr, %function
VCTRL_Scd_Isr:
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
	bl	SM_SCDIntServeProc
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VCTRL_Scd_Isr, .-VCTRL_Scd_Isr
	.align	2
	.global	VCTRL_MMU_ISR
	.type	VCTRL_MMU_ISR, %function
VCTRL_MMU_ISR:
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
	bl	VDMDRV_MMUIntServeProc
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VCTRL_MMU_ISR, .-VCTRL_MMU_ISR
	.align	2
	.type	VCTRL_StopTask.part.0, %function
VCTRL_StopTask.part.0:
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
	ldr	r5, .L34
	ldr	r3, [r5, #68]
	cmp	r3, #1
	beq	.L25
	ldr	r6, .L34+4
	mov	r0, #10
	mov	r4, #49
	ldr	r3, [r6, #116]
	blx	r3
	b	.L26
.L33:
	ldr	r3, [r6, #116]
	blx	r3
	subs	r4, r4, #1
	beq	.L32
.L26:
	ldr	r3, [r5, #68]
	mov	r0, #10
	cmp	r3, #1
	bne	.L33
.L25:
	mov	r0, #0
.L24:
	mov	r3, #0
	str	r3, [r5, #72]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L32:
	mvn	r0, #0
	b	.L24
.L35:
	.align	2
.L34:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VCTRL_StopTask.part.0, .-VCTRL_StopTask.part.0
	.align	2
	.type	VCTRL_StartTask.part.1, %function
VCTRL_StartTask.part.1:
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
	ldr	r5, .L48
	ldr	r3, [r5, #68]
	cmp	r3, #2
	beq	.L39
	ldr	r6, .L48+4
	mov	r0, #10
	mov	r4, #49
	ldr	r3, [r6, #116]
	blx	r3
	b	.L40
.L47:
	ldr	r3, [r6, #116]
	blx	r3
	subs	r4, r4, #1
	beq	.L46
.L40:
	ldr	r3, [r5, #68]
	mov	r0, #10
	cmp	r3, #2
	bne	.L47
.L39:
	mov	r0, #0
.L38:
	mov	r3, #0
	str	r3, [r5, #72]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L46:
	mvn	r0, #0
	b	.L38
.L49:
	.align	2
.L48:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VCTRL_StartTask.part.1, .-VCTRL_StartTask.part.1
	.align	2
	.type	VCTRL_SetSendStreamAgainFlag.part.2, %function
VCTRL_SetSendStreamAgainFlag.part.2:
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
	ldr	r3, .L51
	movw	r2, #1388
	ldr	r1, .L51+4
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L52:
	.align	2
.L51:
	.word	.LC2
	.word	.LC1
	.fnend
	.size	VCTRL_SetSendStreamAgainFlag.part.2, .-VCTRL_SetSendStreamAgainFlag.part.2
	.align	2
	.global	VCTRL_RegisterSoftDecoder
	.type	VCTRL_RegisterSoftDecoder, %function
VCTRL_RegisterSoftDecoder:
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
	mov	r1, r0
	ldr	r0, [r0]
	cmp	r0, #0
	beq	.L62
	ldr	r0, [r1, #4]
	cmp	r0, #0
	beq	.L63
	ldr	r0, [r1, #8]
	cmp	r0, #0
	beq	.L64
	ldr	r0, [r1, #12]
	cmp	r0, #0
	beq	.L65
	ldr	r0, [r1, #16]
	cmp	r0, #0
	beq	.L66
	ldr	r0, [r1, #20]
	cmp	r0, #0
	beq	.L67
	ldr	r0, [r1, #24]
	cmp	r0, #0
	beq	.L68
	ldr	r3, .L69
	mov	r2, #28
	ldr	r0, .L69+4
	ldr	r3, [r3, #52]
	blx	r3
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L68:
	ldr	r2, .L69+8
	ldr	r1, .L69+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L67:
	ldr	r2, .L69+16
	ldr	r1, .L69+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L66:
	ldr	r2, .L69+20
	ldr	r1, .L69+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L65:
	ldr	r2, .L69+24
	ldr	r1, .L69+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L64:
	ldr	r2, .L69+28
	ldr	r1, .L69+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L63:
	ldr	r2, .L69+32
	ldr	r1, .L69+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L62:
	ldr	r2, .L69+36
	ldr	r1, .L69+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L70:
	.align	2
.L69:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0+336
	.word	.LC13
	.word	.LC7
	.word	.LC12
	.word	.LC11
	.word	.LC10
	.word	.LC9
	.word	.LC8
	.word	.LC6
	.fnend
	.size	VCTRL_RegisterSoftDecoder, .-VCTRL_RegisterSoftDecoder
	.align	2
	.global	VCTRL_UnRegisterSoftDecoder
	.type	VCTRL_UnRegisterSoftDecoder, %function
VCTRL_UnRegisterSoftDecoder:
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
	ldr	r3, .L72
	mov	r2, #28
	mov	r1, #0
	ldr	r0, .L72+4
	ldr	r3, [r3, #48]
	blx	r3
	ldmfd	sp, {fp, sp, pc}
.L73:
	.align	2
.L72:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0+336
	.fnend
	.size	VCTRL_UnRegisterSoftDecoder, .-VCTRL_UnRegisterSoftDecoder
	.align	2
	.global	VCTRL_Suspend
	.type	VCTRL_Suspend, %function
VCTRL_Suspend:
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
	ldr	r6, .L122
	mov	r5, #0
	mov	r7, r5
	mov	r4, #32
	ldr	r3, [r6]
	blx	r3
	mov	r8, r0
	mov	r0, r5
	bl	VDEC_Set_ClockSkip
	mov	r0, r5
	bl	SCDDRV_PrepareSleep
	mov	r0, r5
	bl	VDMDRV_PrepareSleep
	ldr	r3, [r6]
	blx	r3
	mov	r9, r0
.L83:
	mov	r0, #0
	bl	SCDDRV_GetSleepStage
	cmp	r0, #2
	bne	.L114
	mov	r0, #0
	bl	VDMDRV_GetSleepStage
	cmp	r0, #2
	bne	.L115
.L78:
	ldr	r3, .L122+4
	ldrb	r3, [r3]
	cmp	r3, #1
	beq	.L116
.L84:
	ldr	r3, .L122+8
	ldr	r2, [r3, #64]
	cmp	r2, #1
	beq	.L117
.L89:
	ldr	r3, [r6]
	blx	r3
	ldr	r1, .L122+12
	cmp	r8, r0
	rsbls	r2, r8, r0
	mvnhi	r8, r8
	addhi	r2, r8, r0
	mov	r0, #0
	bl	dprint_vfmw
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L114:
	mov	r0, #0
	mov	r10, r7
	bl	VDMDRV_GetSleepStage
	cmp	r0, #2
	bne	.L92
	mov	r5, #1
	mov	r3, r5
.L93:
	tst	r3, r10
	bne	.L78
	subs	r4, r4, #1
	beq	.L118
	ldr	r3, [r6, #116]
	mov	r0, #10
	blx	r3
	eor	r2, r5, #1
	eor	r3, r7, #1
	orrs	r3, r2, r3
	bne	.L83
	ldr	r3, .L122+4
	ldrb	r3, [r3]
	cmp	r3, #1
	bne	.L84
.L116:
	ldr	r4, .L122+16
	ldr	r3, [r4, #28]
	cmp	r3, #0
	beq	.L85
	mov	r0, #0
	blx	r3
.L85:
	ldr	r3, [r4, #20]
	cmp	r3, #0
	beq	.L119
	mov	r0, #0
	blx	r3
	ldr	r3, [r4, #4]
	cmp	r3, #0
	beq	.L87
.L121:
	mov	r0, #0
	blx	r3
	ldr	r3, .L122+8
	ldr	r2, [r3, #64]
	cmp	r2, #1
	bne	.L89
.L117:
	mov	r2, #2
	str	r2, [r3, #72]
	bl	VCTRL_StopTask.part.0
	b	.L89
.L115:
	mov	r7, #1
	mov	r10, r7
.L92:
	mov	r3, r5
	b	.L93
.L118:
	ldr	r3, [r6]
	blx	r3
	str	r5, [sp]
	mov	r3, r7
	ldr	r1, .L122+20
	cmp	r9, r0
	rsbls	r2, r9, r0
	mvnhi	r9, r9
	addhi	r2, r9, r0
	mov	r0, #0
	bl	dprint_vfmw
	cmp	r7, #1
	beq	.L120
	mov	r2, #0
	ldr	r1, .L122+24
	mov	r0, r2
	bl	dprint_vfmw
	mov	r0, #0
	bl	SCDDRV_ForceSleep
	cmp	r5, #1
	beq	.L78
.L98:
	mov	r2, #0
	ldr	r1, .L122+28
	mov	r0, r2
	bl	dprint_vfmw
	mov	r0, #0
	bl	VDMDRV_ForceSleep
	b	.L78
.L120:
	cmp	r5, #1
	bne	.L98
	b	.L78
.L119:
	mov	r0, r3
	movw	r2, #467
	ldr	r1, .L122+32
	bl	dprint_vfmw
	ldr	r3, [r4, #4]
	cmp	r3, #0
	bne	.L121
.L87:
	mov	r0, r3
	mov	r2, #472
	ldr	r1, .L122+32
	bl	dprint_vfmw
	b	.L84
.L123:
	.align	2
.L122:
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_HalDisable
	.word	.LANCHOR0
	.word	.LC16
	.word	g_vdm_hal_fun_ptr
	.word	.LC17
	.word	.LC18
	.word	.LC14
	.word	.LC15
	.fnend
	.size	VCTRL_Suspend, .-VCTRL_Suspend
	.align	2
	.global	VCTRL_Resume
	.type	VCTRL_Resume, %function
VCTRL_Resume:
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
	ldr	r5, .L144
	ldr	r3, [r5]
	blx	r3
	ldr	r3, .L144+4
	ldrb	r3, [r3]
	cmp	r3, #1
	mov	r4, r0
	beq	.L140
.L125:
	mov	r0, #0
	bl	SCDDRV_ExitSleep
	mov	r0, #0
	bl	VDMDRV_ExitSleep
	ldr	r3, .L144+8
	ldr	r2, [r3, #64]
	cmp	r2, #1
	beq	.L141
.L134:
	ldr	r3, [r5]
	blx	r3
	ldr	r1, .L144+12
	cmp	r4, r0
	rsbls	r2, r4, r0
	mvnhi	r2, r4
	addhi	r2, r2, r0
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L140:
	ldr	r6, .L144+16
	ldr	r3, [r6]
	cmp	r3, #0
	beq	.L142
	mov	r0, #0
	blx	r3
.L127:
	ldr	r3, [r6, #16]
	cmp	r3, #0
	beq	.L143
	mov	r0, #0
	blx	r3
.L129:
	ldr	r3, [r6, #24]
	cmp	r3, #0
	beq	.L130
	mov	r0, #0
	blx	r3
.L130:
	ldr	r3, [r6, #60]
	cmp	r3, #0
	beq	.L131
	mov	r0, #0
	blx	r3
.L132:
	ldr	r0, [r6, #64]
	cmp	r0, #0
	beq	.L133
	blx	r0
	b	.L125
.L141:
	str	r2, [r3, #72]
	bl	VCTRL_StartTask.part.1
	b	.L134
.L143:
	mov	r0, r3
	movw	r2, #513
	ldr	r1, .L144+20
	bl	dprint_vfmw
	b	.L129
.L131:
	mov	r0, r3
	movw	r2, #519
	ldr	r1, .L144+20
	bl	dprint_vfmw
	b	.L132
.L133:
	mov	r2, #520
	ldr	r1, .L144+20
	bl	dprint_vfmw
	b	.L125
.L142:
	mov	r0, r3
	mov	r2, #508
	ldr	r1, .L144+20
	bl	dprint_vfmw
	b	.L127
.L145:
	.align	2
.L144:
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_HalDisable
	.word	.LANCHOR0
	.word	.LC19
	.word	g_vdm_hal_fun_ptr
	.word	.LC15
	.fnend
	.size	VCTRL_Resume, .-VCTRL_Resume
	.align	2
	.global	ChanCtx_Init
	.type	ChanCtx_Init, %function
ChanCtx_Init:
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
	ldr	r3, .L149
	mov	r2, #192
	mov	r1, #0
	ldr	r0, .L149+4
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r3, .L149+8
	mvn	r1, #0
	add	r2, r3, #64
.L147:
	str	r1, [r3, #4]!
	cmp	r3, r2
	bne	.L147
	ldmfd	sp, {fp, sp, pc}
.L150:
	.align	2
.L149:
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_ChanCtx
	.word	g_ChanCtx+60
	.fnend
	.size	ChanCtx_Init, .-ChanCtx_Init
	.align	2
	.global	VCTRL_Isr_1
	.type	VCTRL_Isr_1, %function
VCTRL_Isr_1:
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
	bl	VDMDRV_VdmIntServProc
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VCTRL_Isr_1, .-VCTRL_Isr_1
	.align	2
	.global	VCTRL_Isr_2
	.type	VCTRL_Isr_2, %function
VCTRL_Isr_2:
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
	mov	r0, #2
	bl	VDMDRV_VdmIntServProc
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VCTRL_Isr_2, .-VCTRL_Isr_2
	.align	2
	.global	VCTRL_Scd_Isr_1
	.type	VCTRL_Scd_Isr_1, %function
VCTRL_Scd_Isr_1:
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
	bl	SM_SCDIntServeProc
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VCTRL_Scd_Isr_1, .-VCTRL_Scd_Isr_1
	.align	2
	.global	VCTRL_Scd_Isr_2
	.type	VCTRL_Scd_Isr_2, %function
VCTRL_Scd_Isr_2:
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
	mov	r0, #2
	bl	SM_SCDIntServeProc
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VCTRL_Scd_Isr_2, .-VCTRL_Scd_Isr_2
	.align	2
	.global	VCTRL_InformVdmFree
	.type	VCTRL_InformVdmFree, %function
VCTRL_InformVdmFree:
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
	ldr	r6, .L159
	ldr	r5, .L159+4
	ldr	r3, [r6]
	blx	r3
	ldr	r3, [r5, #364]
	cmp	r0, r3
	mov	r4, r0
	bls	.L156
	rsb	r3, r3, r0
	cmp	r3, #9
	ldmlsfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	b	.L157
.L156:
	str	r0, [r5, #364]
.L157:
	ldr	r3, [r6, #124]
	mov	r0, #0
	blx	r3
	str	r4, [r5, #364]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L160:
	.align	2
.L159:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_InformVdmFree, .-VCTRL_InformVdmFree
	.align	2
	.global	VCTRL_ExtraWakeUpThread
	.type	VCTRL_ExtraWakeUpThread, %function
VCTRL_ExtraWakeUpThread:
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
	ldr	r3, .L162
	mov	r0, #0
	ldr	r3, [r3, #124]
	blx	r3
	ldmfd	sp, {fp, sp, pc}
.L163:
	.align	2
.L162:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VCTRL_ExtraWakeUpThread, .-VCTRL_ExtraWakeUpThread
	.align	2
	.global	VCTRL_SetMoreGapEnable
	.type	VCTRL_SetMoreGapEnable, %function
VCTRL_SetMoreGapEnable:
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
	bhi	.L170
	ldr	r3, .L173
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	beq	.L171
	ldr	r2, [r3, #12]
	cmp	r2, #1
	bne	.L172
	cmp	r1, #1
	strls	r1, [r3, #1196]
	movls	r0, #0
	movhi	r2, #0
	strhi	r2, [r3, #1196]
	mvnhi	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L172:
	ldr	r3, .L173+4
	movw	r2, #989
	ldr	r1, .L173+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L170:
	ldr	r3, .L173+12
	movw	r2, #987
	ldr	r1, .L173+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L171:
	mov	r0, r3
	mov	r2, #988
	ldr	r3, .L173+16
	ldr	r1, .L173+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L174:
	.align	2
.L173:
	.word	.LANCHOR0
	.word	.LC21
	.word	.LC1
	.word	.LC20
	.word	.LC2
	.fnend
	.size	VCTRL_SetMoreGapEnable, .-VCTRL_SetMoreGapEnable
	.align	2
	.global	VCTRL_SetCallBack
	.type	VCTRL_SetCallBack, %function
VCTRL_SetCallBack:
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
	beq	.L183
	cmp	r0, #0
	beq	.L179
	cmp	r0, #1
	bne	.L184
	ldr	r3, .L185
	mov	r0, #0
	str	r1, [r3, #308]
	ldmfd	sp, {fp, sp, pc}
.L184:
	mov	r3, r0
	ldr	r2, .L185+4
	ldr	r1, .L185+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L179:
	ldr	r3, .L185
	str	r1, [r3, #304]
	ldmfd	sp, {fp, sp, pc}
.L183:
	mov	r0, r1
	ldr	r3, .L185+12
	movw	r2, #1098
	ldr	r1, .L185+16
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L186:
	.align	2
.L185:
	.word	.LANCHOR0
	.word	.LANCHOR1+20
	.word	.LC23
	.word	.LC22
	.word	.LC1
	.fnend
	.size	VCTRL_SetCallBack, .-VCTRL_SetCallBack
	.align	2
	.global	VCTRL_StopTask
	.type	VCTRL_StopTask, %function
VCTRL_StopTask:
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
	ldr	r3, .L190
	ldr	r2, [r3, #64]
	cmp	r2, #1
	bne	.L189
	mov	r2, #2
	str	r2, [r3, #72]
	bl	VCTRL_StopTask.part.0
	ldmfd	sp, {fp, sp, pc}
.L189:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L191:
	.align	2
.L190:
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_StopTask, .-VCTRL_StopTask
	.align	2
	.global	VCTRL_StartTask
	.type	VCTRL_StartTask, %function
VCTRL_StartTask:
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
	ldr	r3, .L195
	ldr	r2, [r3, #64]
	cmp	r2, #1
	bne	.L194
	str	r2, [r3, #72]
	bl	VCTRL_StartTask.part.1
	ldmfd	sp, {fp, sp, pc}
.L194:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L196:
	.align	2
.L195:
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_StartTask, .-VCTRL_StartTask
	.align	2
	.global	VCTRL_SetStreamInterface
	.type	VCTRL_SetStreamInterface, %function
VCTRL_SetStreamInterface:
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
	subs	r7, r1, #0
	mov	r5, r0
	beq	.L201
	ldr	r4, .L203
	ldr	r0, [r4, r0, asl #2]
	cmp	r0, #0
	beq	.L202
	ldr	r6, .L203+4
	mov	r2, #12
	add	r0, r0, #176
	add	r4, r4, #368
	ldr	r3, [r6, #52]
	blx	r3
	mov	r0, r5, asl #4
	sub	r0, r0, r5, asl #2
	ldr	r3, [r6, #52]
	mov	r1, r7
	add	r0, r4, r0
	mov	r2, #12
	blx	r3
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L202:
	ldr	r3, .L203+8
	movw	r2, #1375
	ldr	r1, .L203+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L201:
	mov	r0, r7
	ldr	r3, .L203+16
	movw	r2, #1374
	ldr	r1, .L203+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L204:
	.align	2
.L203:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC2
	.word	.LC1
	.word	.LC24
	.fnend
	.size	VCTRL_SetStreamInterface, .-VCTRL_SetStreamInterface
	.align	2
	.global	VCTRL_SetSendStreamAgainFlag
	.type	VCTRL_SetSendStreamAgainFlag, %function
VCTRL_SetSendStreamAgainFlag:
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
	ldr	r3, .L209
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	beq	.L208
	add	r3, r3, #233472
	mov	r0, #0
	str	r1, [r3, #412]
	ldmfd	sp, {fp, sp, pc}
.L208:
	bl	VCTRL_SetSendStreamAgainFlag.part.2
	ldmfd	sp, {fp, sp, pc}
.L210:
	.align	2
.L209:
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_SetSendStreamAgainFlag, .-VCTRL_SetSendStreamAgainFlag
	.align	2
	.global	VCTRL_GetSendStreamAgainFlag
	.type	VCTRL_GetSendStreamAgainFlag, %function
VCTRL_GetSendStreamAgainFlag:
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
	ldr	r3, .L215
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	beq	.L214
	add	r0, r0, #233472
	ldr	r0, [r0, #412]
	ldmfd	sp, {fp, sp, pc}
.L214:
	ldr	r3, .L215+4
	movw	r2, #1395
	ldr	r1, .L215+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L216:
	.align	2
.L215:
	.word	.LANCHOR0
	.word	.LC2
	.word	.LC1
	.fnend
	.size	VCTRL_GetSendStreamAgainFlag, .-VCTRL_GetSendStreamAgainFlag
	.align	2
	.global	VCTRL_GetStreamInterface
	.type	VCTRL_GetStreamInterface, %function
VCTRL_GetStreamInterface:
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
	ldr	r5, .L223
	mov	r4, r0
	ldr	r1, [r5, r0, asl #2]
	cmp	r1, #0
	beq	.L221
	ldr	r2, .L223+4
	mov	r3, r0, asl #4
	sub	r3, r3, r0, asl #2
	add	r0, r5, #368
	add	r0, r0, r3
	add	r1, r1, #176
	ldr	r3, [r2, #60]
	mov	r2, #12
	blx	r3
	cmp	r0, #0
	bne	.L222
	ldr	r1, [r5, r4, asl #2]
	add	r0, r1, #176
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L222:
	mov	r3, r4
	movw	r2, #1413
	ldr	r1, .L223+8
	mov	r0, #0
	bl	dprint_vfmw
.L221:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L224:
	.align	2
.L223:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC25
	.fnend
	.size	VCTRL_GetStreamInterface, .-VCTRL_GetStreamInterface
	.align	2
	.global	VCTRL_SetFrameInterface
	.type	VCTRL_SetFrameInterface, %function
VCTRL_SetFrameInterface:
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
	subs	r3, r1, #0
	beq	.L229
	ldr	r3, .L231
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	beq	.L230
	ldr	r3, .L231+4
	mov	r2, #12
	add	r0, r0, #200
	ldr	r3, [r3, #52]
	blx	r3
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L230:
	ldr	r3, .L231+8
	movw	r2, #1427
	ldr	r1, .L231+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L229:
	mov	r0, r3
	movw	r2, #1426
	ldr	r3, .L231+16
	ldr	r1, .L231+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L232:
	.align	2
.L231:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC2
	.word	.LC1
	.word	.LC26
	.fnend
	.size	VCTRL_SetFrameInterface, .-VCTRL_SetFrameInterface
	.align	2
	.global	VCTRL_GetFrameInterface
	.type	VCTRL_GetFrameInterface, %function
VCTRL_GetFrameInterface:
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
	ldr	r3, .L236
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	addne	r0, r0, #200
	ldmfd	sp, {fp, sp, pc}
.L237:
	.align	2
.L236:
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_GetFrameInterface, .-VCTRL_GetFrameInterface
	.align	2
	.global	VCTRL_GetStreamSize
	.type	VCTRL_GetStreamSize, %function
VCTRL_GetStreamSize:
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
	bhi	.L243
	ldr	r3, .L246
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	beq	.L244
	ldr	r3, [r0, #12]
	cmp	r3, #1
	bne	.L245
	add	r0, r0, #99328
	add	r0, r0, #616
	bl	GetSegStreamSize
	ldmfd	sp, {fp, sp, pc}
.L245:
	ldr	r3, .L246+4
	movw	r2, #1468
	ldr	r1, .L246+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L243:
	ldr	r3, .L246+12
	movw	r2, #1466
	ldr	r1, .L246+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L244:
	ldr	r3, .L246+16
	movw	r2, #1467
	ldr	r1, .L246+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L247:
	.align	2
.L246:
	.word	.LANCHOR0
	.word	.LC28
	.word	.LC1
	.word	.LC20
	.word	.LC27
	.fnend
	.size	VCTRL_GetStreamSize, .-VCTRL_GetStreamSize
	.align	2
	.global	VCTRL_SetDiscardPicParam
	.type	VCTRL_SetDiscardPicParam, %function
VCTRL_SetDiscardPicParam:
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
	mov	r4, r0
	mov	r0, r1
	bhi	.L254
	cmp	r1, #0
	beq	.L255
	ldr	r5, .L257
	ldr	r0, [r5, r4, asl #2]
	cmp	r0, #0
	beq	.L256
	ldr	r3, .L257+4
	mov	r2, #8
	add	r0, r0, #1456
	ldr	r3, [r3, #52]
	blx	r3
	ldr	r2, [r5, r4, asl #2]
	mov	r0, #0
	ldr	r3, [r2, #1456]
	sub	r3, r3, #1
	cmp	r3, #1
	strhi	r0, [r2, #1456]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L254:
	ldr	r3, .L257+8
	movw	r2, #1480
	ldr	r1, .L257+12
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L256:
	ldr	r3, .L257+16
	movw	r2, #1482
	ldr	r1, .L257+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L255:
	ldr	r3, .L257+20
	movw	r2, #1481
	ldr	r1, .L257+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L258:
	.align	2
.L257:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC20
	.word	.LC1
	.word	.LC2
	.word	.LC29
	.fnend
	.size	VCTRL_SetDiscardPicParam, .-VCTRL_SetDiscardPicParam
	.align	2
	.global	VCTRL_GetSyntaxCtx
	.type	VCTRL_GetSyntaxCtx, %function
VCTRL_GetSyntaxCtx:
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
	ldr	r3, .L262
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	addne	r0, r0, #237568
	addne	r0, r0, #368
	ldmfd	sp, {fp, sp, pc}
.L263:
	.align	2
.L262:
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_GetSyntaxCtx, .-VCTRL_GetSyntaxCtx
	.align	2
	.global	VCTRL_GetImageInterface
	.type	VCTRL_GetImageInterface, %function
VCTRL_GetImageInterface:
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
	ldr	r3, .L267
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	addne	r0, r0, #188
	ldmfd	sp, {fp, sp, pc}
.L268:
	.align	2
.L267:
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_GetImageInterface, .-VCTRL_GetImageInterface
	.align	2
	.global	VCTRL_PartitionMemForStdUser
	.type	VCTRL_PartitionMemForStdUser, %function
VCTRL_PartitionMemForStdUser:
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
	ldr	r4, .L286
	cmp	r2, #31
	cmpgt	r1, #31
	mov	r7, r2
	mov	r8, r1
	movle	r2, #1
	movgt	r2, #0
	mov	r9, r0
	ldr	r5, [r4, r0, asl #2]
	ble	.L282
	ldr	r1, [fp, #4]
	cmp	r1, #0
	cmpne	r3, #0
	moveq	r6, #1
	movne	r6, #0
	beq	.L283
	ldr	r10, .L286+4
	mov	r2, #32
	mov	r1, r6
	sub	r0, fp, #76
	str	r3, [fp, #-88]
	ldr	ip, [r10, #48]
	blx	ip
	sub	r1, fp, #76
	mov	r0, r9
	mov	r2, #1
	str	r7, [fp, #-64]
	str	r7, [fp, #-48]
	strb	r6, [fp, #-75]
	str	r8, [fp, #-68]
	str	r8, [fp, #-52]
	strb	r6, [fp, #-73]
	strb	r6, [fp, #-71]
	strb	r6, [fp, #-70]
	strb	r2, [fp, #-74]
	bl	FSP_ConfigInstance
	subs	r7, r0, #0
	bne	.L273
	ldr	r3, [fp, #-88]
	mov	r0, r9
	ldr	r2, [fp, #4]
	mov	r1, r3
	sub	r3, fp, #80
	bl	FSP_ConfigFrameBuf
	subs	r6, r0, #0
	bne	.L284
	mov	r0, r9
	add	r1, r4, #560
	bl	FSP_GetInstInfo
	movw	r3, #561
	ldrsb	r3, [r4, r3]
	cmp	r3, #16
	movge	r3, #16
	cmp	r3, #2
	str	r3, [r5, #528]
	ble	.L285
	ldr	ip, [r4, #3768]
	mov	r2, #64
	ldr	r3, [r10, #48]
	mov	r1, r7
	add	r0, r5, #460
	str	ip, [r5, #524]
	blx	r3
	mov	r1, r7
	ldr	r3, [r10, #48]
	mov	r2, #64
	add	r0, r5, #396
	blx	r3
	ldr	r1, [r5, #528]
	cmp	r1, #0
	ble	.L271
	add	r4, r4, #560
	add	r5, r5, #456
	mov	r3, r7
.L278:
	ldr	r2, [r4, #24]
	add	r3, r3, #1
	cmp	r3, r1
	add	r4, r4, #100
	str	r2, [r5, #4]!
	bne	.L278
.L271:
	mov	r0, r7
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L283:
	mov	r0, r2
	ldr	r1, .L286+8
	bl	dprint_vfmw
	mvn	r7, #0
	b	.L271
.L273:
	mov	r0, r6
	ldr	r1, .L286+12
	bl	dprint_vfmw
.L281:
	mvn	r7, #0
	mov	r0, r7
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L284:
	mov	r0, r7
	ldr	r1, .L286+16
	bl	dprint_vfmw
	b	.L281
.L285:
	mov	r0, r6
	movw	r3, #1723
	ldr	r2, .L286+20
	ldr	r1, .L286+24
	bl	dprint_vfmw
	b	.L281
.L282:
	mov	r3, r7
	mov	r2, r1
	mov	r0, #0
	ldr	r1, .L286+28
	bl	dprint_vfmw
	mvn	r7, #0
	b	.L271
.L287:
	.align	2
.L286:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC31
	.word	.LC34
	.word	.LC32
	.word	.LANCHOR1+40
	.word	.LC33
	.word	.LC30
	.fnend
	.size	VCTRL_PartitionMemForStdUser, .-VCTRL_PartitionMemForStdUser
	.align	2
	.global	VCTRL_UnInstallChan
	.type	VCTRL_UnInstallChan, %function
VCTRL_UnInstallChan:
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
	bl	FSP_DisableInstance
	mov	r0, r4
	bl	CloseUsdPool_WithMem
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	VCTRL_UnInstallChan, .-VCTRL_UnInstallChan
	.align	2
	.global	DelAllFrameMemRecord
	.type	DelAllFrameMemRecord, %function
DelAllFrameMemRecord:
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
	movne	r4, r1
	addne	r5, r4, #2304
	beq	.L306
.L295:
	ldr	r3, [r4]
	cmp	r3, #255
	beq	.L292
	ldr	r2, [r4, #12]
	ldr	r1, [r4, #24]
	ldr	r0, [r4, #32]
	bl	MEM_DelMemRecord
.L292:
	ldr	r3, [r4, #4]
	cmp	r3, #255
	beq	.L293
	ldr	r2, [r4, #16]
	ldr	r1, [r4, #40]
	ldr	r0, [r4, #48]
	bl	MEM_DelMemRecord
.L293:
	ldr	r3, [r4, #8]
	cmp	r3, #255
	beq	.L294
	ldr	r2, [r4, #20]
	ldr	r1, [r4, #56]
	ldr	r0, [r4, #64]
	bl	MEM_DelMemRecord
.L294:
	add	r4, r4, #72
	cmp	r4, r5
	bne	.L295
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L306:
	mov	r0, r1
	ldr	r3, .L307
	movw	r2, #1780
	ldr	r1, .L307+4
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L308:
	.align	2
.L307:
	.word	.LC35
	.word	.LC1
	.fnend
	.size	DelAllFrameMemRecord, .-DelAllFrameMemRecord
	.align	2
	.global	VCTRL_FreeChanResource
	.type	VCTRL_FreeChanResource, %function
VCTRL_FreeChanResource:
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
	beq	.L335
	ldr	r5, [r4]
	cmp	r5, #0
	beq	.L336
	ldr	r3, [r4, #20]
	cmp	r3, #1
	beq	.L314
	ldr	r2, [r5, #16]
	ldr	r1, [r5, #4]
	ldr	r0, [r5, #8]
	bl	MEM_DelMemRecord
.L315:
	ldr	r3, [r4, #24]
	cmp	r3, #1
	beq	.L337
.L313:
	ldr	r5, [r4, #4]
	cmp	r5, #0
	beq	.L338
	ldr	r2, [r5, #16]
	ldr	r1, [r5, #4]
	ldr	r0, [r5, #8]
	bl	MEM_DelMemRecord
	ldr	r3, [r4, #28]
	cmp	r3, #1
	beq	.L339
.L318:
	ldr	r0, [r4, #12]
	cmp	r0, #0
	beq	.L340
	bl	SM_DeletDSPCtxMem
	ldr	r5, [r4, #8]
	cmp	r5, #0
	beq	.L341
.L321:
	ldr	r2, [r5, #16]
	ldr	r1, [r5, #4]
	ldr	r0, [r5, #8]
	bl	MEM_DelMemRecord
	ldr	r3, [r4, #32]
	cmp	r3, #1
	bne	.L322
	ldr	r0, [r5, #8]
	cmp	r0, #0
	bne	.L342
.L322:
	ldr	r3, .L344
	ldr	r0, [r5, #4]
	ldr	r3, [r3, #160]
	blx	r3
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L314:
	ldr	r1, [r4, #16]
	cmp	r1, #0
	beq	.L343
	bl	DelAllFrameMemRecord
	cmp	r0, #0
	beq	.L315
	ldr	r1, .L344+4
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r3, [r4, #24]
	cmp	r3, #1
	bne	.L313
.L337:
	ldr	r0, [r5, #8]
	cmp	r0, #0
	beq	.L313
	ldr	r1, [r5, #4]
	bl	MEM_ReleaseMemBlock
	b	.L313
.L339:
	ldr	r0, [r5, #8]
	cmp	r0, #0
	beq	.L318
	ldr	r1, [r5, #4]
	bl	MEM_ReleaseMemBlock
	b	.L318
.L340:
	ldr	r2, .L344+8
	ldr	r1, .L344+12
	bl	dprint_vfmw
	ldr	r5, [r4, #8]
	cmp	r5, #0
	bne	.L321
.L341:
	ldr	r2, .L344+8
	mov	r0, r5
	ldr	r1, .L344+16
	bl	dprint_vfmw
	mov	r0, r5
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L338:
	mov	r0, r5
	ldr	r2, .L344+8
	ldr	r1, .L344+20
	bl	dprint_vfmw
	b	.L318
.L342:
	ldr	r1, [r5, #4]
	bl	MEM_ReleaseMemBlock
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L343:
	mov	r0, r1
	ldr	r2, .L344+8
	ldr	r1, .L344+24
	bl	dprint_vfmw
	b	.L315
.L336:
	mov	r0, r5
	ldr	r2, .L344+8
	ldr	r1, .L344+28
	bl	dprint_vfmw
	b	.L313
.L335:
	mov	r0, r4
	ldr	r2, .L344+8
	ldr	r1, .L344+32
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L345:
	.align	2
.L344:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC39
	.word	.LANCHOR1+72
	.word	.LC41
	.word	.LC42
	.word	.LC40
	.word	.LC38
	.word	.LC37
	.word	.LC36
	.fnend
	.size	VCTRL_FreeChanResource, .-VCTRL_FreeChanResource
	.align	2
	.global	VCTRL_GetChanCtxSize
	.type	VCTRL_GetChanCtxSize, %function
VCTRL_GetChanCtxSize:
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
	cmp	r0, #26
	moveq	r3, #2448
	movwne	r3, #17176
	movteq	r3, 177
	movtne	r3, 11
	str	r3, [r1]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VCTRL_GetChanCtxSize, .-VCTRL_GetChanCtxSize
	.align	2
	.global	VCTRL_GetChanCfg
	.type	VCTRL_GetChanCfg, %function
VCTRL_GetChanCfg:
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
	mov	r3, r1
	bhi	.L354
	cmp	r1, #0
	beq	.L355
	ldr	r2, .L357
	ldr	r1, [r2, r0, asl #2]
	cmp	r1, #0
	beq	.L356
	ldr	ip, .L357+4
	add	r1, r1, #52
	mov	r0, r3
	mov	r2, #124
	ldr	r3, [ip, #52]
	blx	r3
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L354:
	ldr	r3, .L357+8
	movw	r2, #3106
	ldr	r1, .L357+12
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L356:
	mov	r0, r1
	ldr	r3, .L357+16
	movw	r2, #3108
	ldr	r1, .L357+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L355:
	mov	r0, r1
	ldr	r3, .L357+20
	movw	r2, #3107
	ldr	r1, .L357+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L358:
	.align	2
.L357:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC20
	.word	.LC1
	.word	.LC2
	.word	.LC43
	.fnend
	.size	VCTRL_GetChanCfg, .-VCTRL_GetChanCfg
	.align	2
	.global	RefreshDecCore
	.type	RefreshDecCore, %function
RefreshDecCore:
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
	ldr	r4, .L376
	mov	r5, r0
	ldr	r0, [r4, r0, asl #2]
	ldr	r3, [r0, #592]
	ldr	r2, [r0, #1500]
	cmp	r3, #4
	beq	.L361
	cmp	r3, #14
	moveq	r3, #2
	streq	r3, [r0, #1500]
	bne	.L375
.L363:
	cmp	r2, r3
	beq	.L367
	sub	r2, r2, #1
	cmp	r2, #4
	bhi	.L366
	ldr	r3, [r4, #340]
	cmp	r3, #0
	beq	.L366
	add	r0, r0, #237568
	str	r1, [fp, #-24]
	add	r0, r0, #376
	blx	r3
	ldr	r1, [fp, #-24]
.L366:
	ldr	r2, [r4, r5, asl #2]
	ldr	r0, .L376
	ldr	r3, [r2, #1500]
	sub	r3, r3, #1
	cmp	r3, #4
	bhi	.L367
	ldr	r3, [r0, #336]
	add	r0, r2, #237568
	ldr	ip, [r2, #44]
	cmp	r3, #0
	str	ip, [r0, #388]
	beq	.L369
	ldr	r2, [r2, #592]
	add	r0, r0, #376
	blx	r3
	cmp	r0, #0
	bne	.L369
.L367:
	mov	r0, #0
.L365:
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L375:
	mov	r3, #0
	str	r3, [r0, #1500]
	b	.L363
.L361:
	mov	r3, #1
	str	r3, [r0, #1500]
	b	.L363
.L369:
	ldr	r1, .L376+4
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L365
.L377:
	.align	2
.L376:
	.word	.LANCHOR0
	.word	.LC44
	.fnend
	.size	RefreshDecCore, .-RefreshDecCore
	.align	2
	.global	VCTRL_CmpConfigParameter
	.type	VCTRL_CmpConfigParameter, %function
VCTRL_CmpConfigParameter:
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
	ldr	r3, .L397
	ldr	r3, [r3, r0, asl #2]
	ldr	r2, [r3, #592]
	cmp	r2, #21
	beq	.L394
	ldr	r2, [r3, #52]
	ldr	r0, [r1]
	cmp	r2, r0
	bne	.L394
	ldr	ip, [r3, #68]
	ldr	r0, [r1, #16]
	cmp	ip, r0
	bne	.L394
	ldr	ip, [r3, #64]
	ldr	r0, [r1, #12]
	cmp	ip, r0
	bne	.L394
	ldr	ip, [r3, #72]
	ldr	r0, [r1, #20]
	cmp	ip, r0
	bne	.L394
	ldr	ip, [r3, #76]
	ldr	r0, [r1, #24]
	cmp	ip, r0
	bne	.L394
	ldr	ip, [r3, #80]
	ldr	r0, [r1, #28]
	cmp	ip, r0
	bne	.L394
	ldr	ip, [r3, #84]
	ldr	r0, [r1, #32]
	cmp	ip, r0
	bne	.L394
	ldr	ip, [r3, #104]
	ldr	r0, [r1, #52]
	cmp	ip, r0
	bne	.L394
	ldr	ip, [r3, #120]
	ldr	r0, [r1, #68]
	cmp	ip, r0
	bne	.L394
	ldr	ip, [r3, #116]
	ldr	r0, [r1, #64]
	cmp	ip, r0
	bne	.L394
	ldr	ip, [r3, #108]
	ldr	r0, [r1, #56]
	cmp	ip, r0
	bne	.L394
	ldr	ip, [r3, #124]
	ldr	r0, [r1, #72]
	cmp	ip, r0
	bne	.L394
	cmp	r2, #1
	beq	.L396
	sub	r2, r2, #10
	cmp	r2, #2
	bhi	.L395
	ldr	r3, [r3, #56]
	ldr	r0, [r1, #4]
	subs	r0, r3, r0
	mvnne	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L394:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L395:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L396:
	ldr	r0, [r3, #56]
	ldr	r2, [r1, #4]
	cmp	r0, r2
	bne	.L394
	ldr	r3, [r3, #60]
	ldr	r0, [r1, #8]
	subs	r0, r3, r0
	mvnne	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L398:
	.align	2
.L397:
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_CmpConfigParameter, .-VCTRL_CmpConfigParameter
	.align	2
	.global	VCTRL_CheckChanWH
	.type	VCTRL_CheckChanWH, %function
VCTRL_CheckChanWH:
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
	ldr	r3, .L404
	ldr	r2, .L404+4
	ldr	r3, [r3, r0, asl #2]
	ldr	r2, [r2]
	ldr	r0, [r3, #1260]
	ldr	r3, [r3, #1264]
	cmp	r0, r2
	bgt	.L400
	ldr	r0, .L404+8
	ldr	r0, [r0]
	cmp	r3, r0
	ble	.L402
.L400:
	ldr	r0, [r1]
	cmp	r0, #20
	cmpne	r0, #0
	bic	r0, r0, #2
	movne	r3, #1
	moveq	r3, #0
	cmp	r0, #13
	moveq	r0, #0
	andne	r0, r3, #1
	cmp	r0, #0
	ldmeqfd	sp, {fp, sp, pc}
	ldr	r3, .L404+8
	mov	r0, #0
	ldr	r1, .L404+12
	ldr	r3, [r3]
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L402:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L405:
	.align	2
.L404:
	.word	.LANCHOR0
	.word	g_ChipMaxWidth
	.word	g_ChipMaxHeight
	.word	.LC45
	.fnend
	.size	VCTRL_CheckChanWH, .-VCTRL_CheckChanWH
	.align	2
	.global	VCTRL_SeekPts
	.type	VCTRL_SeekPts, %function
VCTRL_SeekPts:
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
	ldr	r2, .L414
	ldr	r3, [r2, r0, asl #2]
	cmp	r3, #0
	beq	.L412
	ldr	r3, [r3, #592]
	sub	ip, r3, #10
	cmp	ip, #2
	bls	.L413
.L409:
	cmp	r3, #14
	cmpne	r3, #4
	beq	.L411
	bl	SM_SeekPts
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r0, r0, #0
	ldmfd	sp, {fp, sp, pc}
.L413:
	ldr	r2, [r2, #3772]
	tst	r2, #1
	bne	.L409
.L411:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L412:
	mov	r0, r3
	movw	r2, #3761
	ldr	r3, .L414+4
	ldr	r1, .L414+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L415:
	.align	2
.L414:
	.word	.LANCHOR0
	.word	.LC2
	.word	.LC1
	.fnend
	.size	VCTRL_SeekPts, .-VCTRL_SeekPts
	.align	2
	.global	VCTRL_ReleaseStream
	.type	VCTRL_ReleaseStream, %function
VCTRL_ReleaseStream:
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
	ldr	r3, .L420
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	beq	.L419
	bl	SM_Reset
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r0, r0, #0
	ldmfd	sp, {fp, sp, pc}
.L419:
	mov	r0, r3
	movw	r2, #4191
	ldr	r3, .L420+4
	ldr	r1, .L420+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L421:
	.align	2
.L420:
	.word	.LANCHOR0
	.word	.LC2
	.word	.LC1
	.fnend
	.size	VCTRL_ReleaseStream, .-VCTRL_ReleaseStream
	.align	2
	.global	VCTRL_ImageOutputEnable
	.type	VCTRL_ImageOutputEnable, %function
VCTRL_ImageOutputEnable:
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
	mov	r4, r0
	mov	r6, r1
	bhi	.L425
	ldr	r5, .L426
	mov	r0, #4
	ldr	r3, [r5, #12]
	blx	r3
	ldr	r2, .L426+4
	ldr	r1, [r6]
	mov	r0, #4
	ldr	r3, [r5, #16]
	ldr	r2, [r2, r4, asl #2]
	str	r1, [r2, #20]
	blx	r3
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L425:
	ldr	r3, .L426+8
	movw	r2, #4313
	ldr	r1, .L426+12
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L427:
	.align	2
.L426:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.word	.LC20
	.word	.LC1
	.fnend
	.size	VCTRL_ImageOutputEnable, .-VCTRL_ImageOutputEnable
	.align	2
	.global	VCTRL_TryToRelSpecialFrm
	.type	VCTRL_TryToRelSpecialFrm, %function
VCTRL_TryToRelSpecialFrm:
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
	bhi	.L454
	ldr	r7, .L458
	ldr	ip, [r7, r0, asl #2]
	cmp	ip, #0
	beq	.L455
	add	r3, ip, #237568
	ldr	lr, [r3, #328]
	cmp	lr, #0
	beq	.L443
	add	r3, ip, #233472
	ldr	r3, [r3, #3916]
	cmp	r1, r3
	movne	r2, #0
	bne	.L434
	b	.L456
.L436:
	add	r3, r3, #844
	ldr	r3, [ip, r3]
	cmp	r1, r3
	beq	.L432
.L434:
	add	r2, r2, #1
	cmp	r2, lr
	mov	r3, r2, asl #4
	mov	r5, r2
	add	r3, r3, #236544
	bne	.L436
.L443:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L456:
	mov	r5, #0
.L432:
	add	r2, ip, #204800
	movw	r3, #1522
	ldrsb	r0, [r2, r3]
	cmp	r0, #0
	ble	.L443
	add	r3, ip, #225280
	ldr	r3, [r3, #1428]
	cmp	r3, r1
	addne	r3, ip, #226304
	movne	r4, #0
	addne	r3, r3, #504
	bne	.L439
	b	.L457
.L442:
	ldr	r2, [r3], #100
	cmp	r2, r1
	beq	.L437
.L439:
	add	r4, r4, #1
	cmp	r4, r0
	bne	.L442
	b	.L443
.L457:
	mov	r4, #0
.L437:
	ldr	r9, .L458+4
	mov	r0, #3
	sub	r8, lr, #1
	ldr	r3, [r9, #12]
	blx	r3
	ldr	ip, [r7, r6, asl #2]
	mov	r3, #100
	mov	r2, #0
	ldr	r1, [r9, #16]
	mov	r0, #3
	mla	r4, r3, r4, ip
	add	r3, r4, #226304
	add	r4, r4, #229376
	strb	r2, [r3, #390]
	strb	r2, [r4, #518]
	blx	r1
	cmp	r8, r5
	bls	.L446
	mov	r4, r5, asl #4
.L441:
	add	r5, r5, #1
	add	r0, r4, #236544
	ldr	r1, [r7, r6, asl #2]
	add	r0, r0, #840
	mov	r4, r5, asl #4
	ldr	ip, [r9, #52]
	add	r3, r4, #236544
	add	r0, r1, r0
	add	r3, r3, #840
	mov	r2, #16
	add	r1, r1, r3
	blx	ip
	cmp	r8, r5
	bhi	.L441
.L440:
	mov	lr, r8, asl #4
	ldr	r0, [r7, r6, asl #2]
	add	lr, lr, #236544
	ldr	r3, [r9, #48]
	add	lr, lr, #840
	mov	r2, #16
	add	r0, r0, lr
	mov	r1, #0
	blx	r3
	ldr	r3, [r7, r6, asl #2]
	mov	r0, #0
	add	r3, r3, #237568
	ldr	r2, [r3, #328]
	sub	r2, r2, #1
	str	r2, [r3, #328]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L446:
	mov	r8, r5
	b	.L440
.L454:
	ldr	r3, .L458+8
	movw	r2, #4432
	ldr	r1, .L458+12
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L455:
	mov	r0, ip
	ldr	r3, .L458+8
	movw	r2, #4433
	ldr	r1, .L458+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L459:
	.align	2
.L458:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC20
	.word	.LC1
	.fnend
	.size	VCTRL_TryToRelSpecialFrm, .-VCTRL_TryToRelSpecialFrm
	.align	2
	.global	VCTRL_ReleaseChanImage
	.type	VCTRL_ReleaseChanImage, %function
VCTRL_ReleaseChanImage:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #596
	sub	sp, sp, #596
	push	{lr}
	bl	__gnu_mcount_nc
	cmp	r0, #15
	mov	r4, r0
	mov	r7, r1
	bhi	.L481
	ldr	r8, .L489
	ldr	r0, [r8, r0, asl #2]
	cmp	r0, #0
	beq	.L482
	ldr	r3, [r0, #12]
	cmp	r3, #1
	bne	.L483
	cmp	r1, #0
	beq	.L484
	ldr	r6, .L489+4
	mov	r2, r4
	ldr	r3, [r1, #156]
	mov	r0, #2
	ldr	r1, .L489+8
	bl	dprint_vfmw
	ldr	r3, [r6, #12]
	mov	r0, #4
	blx	r3
	ldr	r0, [r8, r4, asl #2]
	cmp	r0, #0
	movweq	r2, #4915
	ldreq	r1, .L489+12
	beq	.L480
	ldr	r3, [r0, #12]
	cmp	r3, #1
	bne	.L485
	ldr	r1, [r7, #28]
	mov	r0, r4
	bl	VCTRL_TryToRelSpecialFrm
	subs	r5, r0, #0
	beq	.L486
	ldr	r0, [r8, r4, asl #2]
	mov	r1, r7
	add	r0, r0, #237568
	add	r0, r0, #368
	bl	SYNTAX_ReleaseImage
	ldr	r3, [r7, #196]
	cmn	r3, #1
	mov	r5, r0
	beq	.L469
	ldr	r0, [r8, r4, asl #2]
	sub	r1, fp, #628
	str	r3, [fp, #-472]
	add	r0, r0, #237568
	add	r0, r0, #368
	bl	SYNTAX_ReleaseImage
	mov	r5, r0
.L469:
	mov	r0, #13
	bl	CHECK_REC_POS_ENABLE
	cmp	r0, #0
	bne	.L487
.L471:
	subs	r4, r5, #1
	mvnne	r4, #0
	cmp	r4, #0
	bne	.L488
.L473:
	ldr	r3, [r6, #16]
	mov	r0, #4
	blx	r3
.L462:
	mov	r0, r4
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L486:
	ldr	r3, [r6, #16]
	mov	r0, #4
	blx	r3
	movw	r2, #4936
	ldr	r1, .L489+16
	mov	r0, r5
	bl	dprint_vfmw
	mov	r4, r5
	mov	r0, r4
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L488:
	ldr	r2, .L489+20
	mov	r0, #0
	ldr	r1, .L489+24
	bl	dprint_vfmw
	b	.L473
.L487:
	ldr	r3, [r6]
	add	r8, r8, r4, lsl #2
	blx	r3
	ldr	r2, .L489+28
	ldr	r3, [r8, #3776]
	ldr	r2, [r2]
	rsb	r3, r3, r0
	mov	ip, r0
	cmp	r3, r2
	bls	.L471
	mov	r2, r4, asl #24
	movw	r1, #4971
	add	r2, r2, #851968
	ldr	r0, .L489+32
	cmp	r5, #1
	addeq	r2, r2, #1
	str	ip, [r8, #3776]
	bl	DBG_AddTrace
	b	.L471
.L485:
	ldr	r1, .L489+36
	movw	r2, #4924
	mov	r0, #0
.L480:
	bl	dprint_vfmw
	ldr	r3, [r6, #16]
	mov	r0, #4
	mvn	r4, #0
	blx	r3
	b	.L462
.L483:
	ldr	r3, .L489+40
	movw	r2, #4907
	ldr	r1, .L489+44
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r4, #0
	b	.L462
.L481:
	ldr	r3, .L489+48
	movw	r2, #4905
	ldr	r1, .L489+44
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r4, #0
	b	.L462
.L484:
	mov	r0, r1
	ldr	r3, .L489+52
	movw	r2, #4908
	ldr	r1, .L489+44
	bl	dprint_vfmw
	mvn	r4, #0
	b	.L462
.L482:
	ldr	r3, .L489+56
	movw	r2, #4906
	ldr	r1, .L489+44
	mvn	r4, #0
	bl	dprint_vfmw
	b	.L462
.L490:
	.align	2
.L489:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC48
	.word	.LC49
	.word	.LC51
	.word	.LANCHOR1+120
	.word	.LC52
	.word	g_TraceImgPeriod
	.word	.LANCHOR1+96
	.word	.LC50
	.word	.LC46
	.word	.LC1
	.word	.LC20
	.word	.LC47
	.word	.LC2
	.fnend
	.size	VCTRL_ReleaseChanImage, .-VCTRL_ReleaseChanImage
	.align	2
	.global	VCTRL_GetVidStd
	.type	VCTRL_GetVidStd, %function
VCTRL_GetVidStd:
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
	bhi	.L492
	ldr	r3, .L496
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	beq	.L492
	ldr	r2, [r3, #12]
	cmp	r2, #1
	beq	.L495
	mov	r3, r0
	movw	r2, #5004
	ldr	r1, .L496+4
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #21
	ldmfd	sp, {fp, sp, pc}
.L492:
	movw	r2, #4997
	ldr	r1, .L496+8
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #21
	ldmfd	sp, {fp, sp, pc}
.L495:
	ldr	r0, [r3, #592]
	ldmfd	sp, {fp, sp, pc}
.L497:
	.align	2
.L496:
	.word	.LANCHOR0
	.word	.LC54
	.word	.LC53
	.fnend
	.size	VCTRL_GetVidStd, .-VCTRL_GetVidStd
	.align	2
	.global	VCTRL_GetDecParam
	.type	VCTRL_GetDecParam, %function
VCTRL_GetDecParam:
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
	bhi	.L499
	ldr	r2, .L530
	ldr	r4, [r2, r0, asl #2]
	cmp	r4, #0
	beq	.L499
	ldr	r3, [r4, #12]
	cmp	r3, #1
	bne	.L518
	ldr	r3, [r4, #16]
	cmp	r3, #1
	bne	.L518
	ldr	r3, [r4, #592]
	cmp	r3, #17
	ldrls	pc, [pc, r3, asl #2]
	b	.L502
.L504:
	.word	.L503
	.word	.L529
	.word	.L506
	.word	.L529
	.word	.L518
	.word	.L529
	.word	.L510
	.word	.L502
	.word	.L529
	.word	.L529
	.word	.L513
	.word	.L513
	.word	.L513
	.word	.L529
	.word	.L518
	.word	.L515
	.word	.L516
	.word	.L529
.L502:
	ldr	r2, .L530+4
	mov	r0, #0
	ldr	r1, .L530+8
	bl	dprint_vfmw
.L518:
	mov	r3, #0
.L528:
	mov	r0, r3
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L513:
	ldr	r3, [r2, #3772]
	tst	r3, #1
	beq	.L518
.L529:
	add	r3, r4, #237568
	ldr	r5, [r3, #380]
.L508:
	cmp	r5, #0
	beq	.L518
	ldr	r3, .L530+12
	ldr	r3, [r3]
	blx	r3
	mov	r3, r5
	str	r0, [r4, #48]
	mov	r0, r3
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L499:
	mov	r3, r0
	movw	r2, #5021
	ldr	r1, .L530+16
	mov	r0, #22
	bl	dprint_vfmw
	mov	r3, #0
	b	.L528
.L503:
	add	r3, r4, #237568
	ldr	r5, [r3, #736]
	b	.L508
.L510:
	add	r3, r4, #237568
	ldr	r5, [r3, #392]
	b	.L508
.L515:
	add	r3, r4, #237568
	ldr	r5, [r3, #604]
	b	.L508
.L516:
	add	r3, r4, #237568
	ldr	r5, [r3, #2704]
	b	.L508
.L506:
	add	r3, r4, #237568
	ldr	r5, [r3, #1412]
	b	.L508
.L531:
	.align	2
.L530:
	.word	.LANCHOR0
	.word	.LANCHOR1+144
	.word	.LC56
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC55
	.fnend
	.size	VCTRL_GetDecParam, .-VCTRL_GetDecParam
	.align	2
	.global	VCTRL_ChanDecparamInValidFlag
	.type	VCTRL_ChanDecparamInValidFlag, %function
VCTRL_ChanDecparamInValidFlag:
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
	cmp	r0, #15
	mov	r2, r0
	bhi	.L533
	ldr	r5, .L544
	ldr	r3, [r5, r0, asl #2]
	cmp	r3, #0
	beq	.L533
	ldr	r1, [r3, #12]
	cmp	r1, #1
	bne	.L536
	ldr	r6, [r3, #16]
	cmp	r6, #1
	beq	.L537
.L536:
	ldr	r1, .L544+4
	mov	r0, #22
	mov	r4, #0
	bl	dprint_vfmw
.L535:
	mov	r0, r4
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L533:
	mov	r3, r2
	ldr	r1, .L544+8
	movw	r2, #5153
	mov	r0, #22
	bl	dprint_vfmw
	mov	r4, #0
	mov	r0, r4
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L537:
	str	r0, [fp, #-40]
	bl	VCTRL_GetDecParam
	ldr	r2, [fp, #-40]
	subs	r7, r0, #0
	beq	.L542
	ldr	r2, [r5, r2, asl #2]
	mov	r3, #0
	mov	r4, r3
	str	r3, [r2, #388]
	str	r3, [r2, #392]
	b	.L535
.L542:
	ldr	r8, [r5, r2, asl #2]
	ldr	r4, [r8, #388]
	cmp	r4, #0
	beq	.L543
	ldr	r3, .L544+12
	str	r2, [fp, #-40]
	ldr	r3, [r3]
	blx	r3
	ldr	r2, [fp, #-40]
	ldr	r3, [r5, r2, asl #2]
	ldr	r2, [r3, #392]
	cmp	r0, r2
	bls	.L540
	rsb	r0, r2, r0
	cmp	r0, #40
	movls	r4, r7
	bls	.L535
.L540:
	str	r7, [r3, #388]
	mov	r4, r6
	str	r7, [r3, #392]
	b	.L535
.L543:
	ldr	r3, .L544+12
	str	r6, [r8, #388]
	ldr	r3, [r3]
	blx	r3
	str	r0, [r8, #392]
	b	.L535
.L545:
	.align	2
.L544:
	.word	.LANCHOR0
	.word	.LC57
	.word	.LC55
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VCTRL_ChanDecparamInValidFlag, .-VCTRL_ChanDecparamInValidFlag
	.align	2
	.global	VCTRL_FlushDecoder
	.type	VCTRL_FlushDecoder, %function
VCTRL_FlushDecoder:
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
	ldr	r4, .L576
	mov	r5, r0
	ldr	r0, [r4, r0, asl #2]
	cmp	r0, #0
	beq	.L573
	add	r0, r0, #237568
	ldr	r2, [r0, #368]
	cmp	r2, #17
	ldrls	pc, [pc, r2, asl #2]
	b	.L566
.L550:
	.word	.L549
	.word	.L551
	.word	.L552
	.word	.L553
	.word	.L566
	.word	.L554
	.word	.L555
	.word	.L566
	.word	.L556
	.word	.L557
	.word	.L558
	.word	.L558
	.word	.L558
	.word	.L559
	.word	.L566
	.word	.L560
	.word	.L561
	.word	.L562
.L562:
	add	r0, r0, #376
	bl	VP9DEC_GetRemainImg
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L549:
	add	r0, r0, #376
	bl	H264_FlushDecoder
	bl	VDMDRV_WakeUpVdm
	bl	VDMDRV_WakeUpVdm
	ldr	r0, [r4, r5, asl #2]
	add	r0, r0, #237568
	add	r0, r0, #376
	bl	FlushDPB
	cmp	r0, #0
	bne	.L574
.L566:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L552:
	add	r0, r0, #376
	bl	MPEG4DEC_GetRemainImg
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L553:
	add	r0, r0, #376
	bl	MPEG2DEC_GetRemainImg
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L551:
	add	r0, r0, #376
	bl	VC1DEC_GetRemainImg
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L554:
	add	r0, r0, #376
	bl	DIVX3DEC_GetRemainImg
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L555:
	add	r0, r0, #376
	bl	AVSDEC_GetRemainImg
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L556:
	add	r0, r0, #376
	bl	REAL8DEC_GetRemainImg
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L557:
	add	r0, r0, #376
	bl	REAL9DEC_GetRemainImg
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L558:
	add	r0, r0, #376
	bl	VP6DEC_GetRemainImg
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L559:
	add	r0, r0, #376
	bl	VP8DEC_GetRemainImg
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L560:
	add	r0, r0, #376
	bl	MVC_FlushDecoder
	bl	VDMDRV_WakeUpVdm
	bl	VDMDRV_WakeUpVdm
	ldr	r0, [r4, r5, asl #2]
	mvn	r1, #0
	add	r0, r0, #237568
	add	r0, r0, #376
	bl	MVC_FlushDPB
	cmp	r0, #0
	beq	.L566
	movw	r3, #5482
	ldr	r2, .L576+4
	ldr	r1, .L576+8
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L561:
	add	r0, r0, #376
	bl	HEVC_FlushOutputFrmFromDPB
	cmp	r0, #0
	bne	.L575
.L564:
	ldr	r1, .L576+12
	mov	r0, #32
	bl	dprint_vfmw
	bl	VDMDRV_WakeUpVdm
	bl	VDMDRV_WakeUpVdm
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L575:
	movw	r2, #5459
	ldr	r1, .L576+16
	mov	r0, #0
	bl	dprint_vfmw
	b	.L564
.L574:
	movw	r2, #5449
	ldr	r1, .L576+16
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L573:
	ldr	r3, .L576+20
	movw	r2, #5423
	ldr	r1, .L576+24
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L577:
	.align	2
.L576:
	.word	.LANCHOR0
	.word	.LANCHOR1+164
	.word	.LC60
	.word	.LC59
	.word	.LC58
	.word	.LC2
	.word	.LC1
	.fnend
	.size	VCTRL_FlushDecoder, .-VCTRL_FlushDecoder
	.align	2
	.global	VCTRL_GetImageBuffer
	.type	VCTRL_GetImageBuffer, %function
VCTRL_GetImageBuffer:
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
	bhi	.L602
	ldr	r1, .L605
	ldr	r3, [r1, r0, asl #2]
	cmp	r3, #0
	beq	.L603
	ldr	r0, [r3, #16]
	cmp	r0, #1
	bne	.L604
	ldr	r2, [r3, #592]
	cmp	r2, #17
	ldrls	pc, [pc, r2, asl #2]
	b	.L598
.L584:
	.word	.L583
	.word	.L585
	.word	.L586
	.word	.L587
	.word	.L580
	.word	.L589
	.word	.L590
	.word	.L598
	.word	.L591
	.word	.L592
	.word	.L593
	.word	.L593
	.word	.L593
	.word	.L594
	.word	.L580
	.word	.L595
	.word	.L596
	.word	.L597
.L598:
	mov	r0, #0
.L580:
	ldmfd	sp, {fp, sp, pc}
.L597:
	add	r0, r3, #237568
	add	r0, r0, #376
	bl	VP9DEC_GetImageBuffer
	ldmfd	sp, {fp, sp, pc}
.L583:
	add	r0, r3, #237568
	add	r0, r0, #376
	bl	H264DEC_GetImageBuffer
	ldmfd	sp, {fp, sp, pc}
.L585:
	add	r0, r3, #237568
	add	r0, r0, #376
	bl	VC1DEC_GetImageBuffer
	ldmfd	sp, {fp, sp, pc}
.L586:
	add	r0, r3, #237568
	add	r0, r0, #376
	bl	MPEG4DEC_GetImageBuffer
	ldmfd	sp, {fp, sp, pc}
.L587:
	add	r0, r3, #237568
	add	r0, r0, #376
	bl	MPEG2DEC_GetImageBuffer
	ldmfd	sp, {fp, sp, pc}
.L589:
	add	r0, r3, #237568
	add	r0, r0, #376
	bl	DIVX3DEC_GetImageBuffer
	ldmfd	sp, {fp, sp, pc}
.L590:
	add	r0, r3, #237568
	add	r0, r0, #376
	bl	AVSDEC_GetImageBuffer
	ldmfd	sp, {fp, sp, pc}
.L591:
	add	r0, r3, #237568
	add	r0, r0, #376
	bl	REAL8DEC_GetImageBuffer
	ldmfd	sp, {fp, sp, pc}
.L592:
	add	r0, r3, #237568
	add	r0, r0, #376
	bl	REAL9DEC_GetImageBuffer
	ldmfd	sp, {fp, sp, pc}
.L593:
	ldr	r2, [r1, #3772]
	tst	r2, #1
	ldmeqfd	sp, {fp, sp, pc}
	add	r0, r3, #237568
	add	r0, r0, #376
	bl	VP6DEC_GetImageBuffer
	ldmfd	sp, {fp, sp, pc}
.L594:
	add	r0, r3, #237568
	add	r0, r0, #376
	bl	VP8DEC_GetImageBuffer
	ldmfd	sp, {fp, sp, pc}
.L595:
	add	r0, r3, #237568
	add	r0, r0, #376
	bl	MVC_DEC_GetImageBuffer
	ldmfd	sp, {fp, sp, pc}
.L596:
	add	r0, r3, #237568
	add	r0, r0, #376
	bl	HEVCDEC_GetImageBuffer
	ldmfd	sp, {fp, sp, pc}
.L604:
	ldr	r3, .L605+4
	movw	r2, #5547
	ldr	r1, .L605+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L602:
	ldr	r3, .L605+12
	movw	r2, #5545
	ldr	r1, .L605+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L603:
	mov	r0, r3
	movw	r2, #5546
	ldr	r3, .L605+16
	ldr	r1, .L605+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L606:
	.align	2
.L605:
	.word	.LANCHOR0
	.word	.LC62
	.word	.LC1
	.word	.LC61
	.word	.LC46
	.fnend
	.size	VCTRL_GetImageBuffer, .-VCTRL_GetImageBuffer
	.align	2
	.global	VCTRL_ConfigFFFBSpeed
	.type	VCTRL_ConfigFFFBSpeed, %function
VCTRL_ConfigFFFBSpeed:
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
	bhi	.L613
	ldr	r3, .L617
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	beq	.L614
	ldr	r2, [r3, #12]
	cmp	r2, #1
	bne	.L615
	cmp	r1, #0
	beq	.L616
	ldr	r2, [r1]
	mov	r0, #0
	str	r2, [r3, #1200]
	ldmfd	sp, {fp, sp, pc}
.L615:
	ldr	r3, .L617+4
	movw	r2, #5665
	ldr	r1, .L617+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L613:
	ldr	r3, .L617+12
	movw	r2, #5663
	ldr	r1, .L617+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L614:
	mov	r0, r3
	movw	r2, #5664
	ldr	r3, .L617+16
	ldr	r1, .L617+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L616:
	mov	r0, r1
	ldr	r3, .L617+20
	movw	r2, #5666
	ldr	r1, .L617+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L618:
	.align	2
.L617:
	.word	.LANCHOR0
	.word	.LC64
	.word	.LC1
	.word	.LC20
	.word	.LC63
	.word	.LC65
	.fnend
	.size	VCTRL_ConfigFFFBSpeed, .-VCTRL_ConfigFFFBSpeed
	.align	2
	.global	VCTRL_ConfigPVRInfo
	.type	VCTRL_ConfigPVRInfo, %function
VCTRL_ConfigPVRInfo:
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
	bhi	.L625
	ldr	r3, .L629
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	beq	.L626
	ldr	r3, [r0, #12]
	cmp	r3, #1
	bne	.L627
	cmp	r1, #0
	beq	.L628
	ldr	r3, .L629+4
	add	r0, r0, #1216
	mov	r2, #20
	add	r0, r0, #12
	ldr	r3, [r3, #52]
	blx	r3
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L627:
	ldr	r3, .L629+8
	movw	r2, #5678
	ldr	r1, .L629+12
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L625:
	ldr	r3, .L629+16
	movw	r2, #5676
	ldr	r1, .L629+12
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L628:
	mov	r0, r1
	ldr	r3, .L629+20
	movw	r2, #5679
	ldr	r1, .L629+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L626:
	ldr	r3, .L629+24
	movw	r2, #5677
	ldr	r1, .L629+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L630:
	.align	2
.L629:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC64
	.word	.LC1
	.word	.LC20
	.word	.LC65
	.word	.LC63
	.fnend
	.size	VCTRL_ConfigPVRInfo, .-VCTRL_ConfigPVRInfo
	.align	2
	.global	VCTRL_IsChanDecable
	.type	VCTRL_IsChanDecable, %function
VCTRL_IsChanDecable:
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
	ldr	r5, .L637
	mov	r4, r0
	ldr	r3, [r5, r0, asl #2]
	cmp	r3, #0
	beq	.L634
	sub	r1, fp, #44
	bl	SM_GetInfo
	cmp	r0, #0
	bne	.L634
	ldr	r3, [fp, #-36]
	cmp	r3, #16
	bgt	.L635
	ldr	r3, [fp, #-28]
	cmp	r3, #524288
	ble	.L634
.L635:
	mov	r0, r4
	bl	VCTRL_GetImageBuffer
	subs	r0, r0, #1
	mvnne	r0, #0
	cmp	r0, #0
	bne	.L633
	ldr	r3, .L637+4
	ldr	r3, [r3]
	blx	r3
	ldr	r3, [r5, r4, asl #2]
	ldr	r3, [r3, #48]
	rsb	r0, r3, r0
	cmp	r0, #50
	movls	r0, #0
	mvnhi	r0, #0
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L634:
	mvn	r0, #0
.L633:
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L638:
	.align	2
.L637:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VCTRL_IsChanDecable, .-VCTRL_IsChanDecable
	.align	2
	.global	VCTRL_IsChanSegEnough
	.type	VCTRL_IsChanSegEnough, %function
VCTRL_IsChanSegEnough:
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
	ldr	r3, .L640
	ldr	r3, [r3, r0, asl #2]
	ldr	r0, [r3, #376]
	subs	r0, r0, #1
	movne	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L641:
	.align	2
.L640:
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_IsChanSegEnough, .-VCTRL_IsChanSegEnough
	.align	2
	.global	VCTRL_IsChanActive
	.type	VCTRL_IsChanActive, %function
VCTRL_IsChanActive:
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
	bhi	.L648
	ldr	r3, .L649
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	beq	.L648
	ldr	r2, [r3, #12]
	cmp	r2, #0
	beq	.L648
	ldr	r2, [r3, #16]
	cmp	r2, #0
	beq	.L648
	ldr	r2, [r3, #28]
	cmp	r2, #0
	beq	.L648
	ldr	r0, [r3, #592]
	cmp	r0, #21
	movne	r0, #0
	mvneq	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L648:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L650:
	.align	2
.L649:
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_IsChanActive, .-VCTRL_IsChanActive
	.align	2
	.global	USERDEC_Init
	.type	USERDEC_Init, %function
USERDEC_Init:
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
	ldr	r3, .L668
	ldr	r6, [r0, #352]
	mov	r4, r0
	mov	r2, #368
	mov	r5, r1
	ldr	r3, [r3, #48]
	mov	r1, #0
	blx	r3
	str	r6, [r4, #352]
	add	r0, r4, #8
	bl	ResetVoQueue
	ldr	ip, .L668+4
	mov	r2, #0
	str	r5, [r4]
.L655:
	ldr	r1, [ip], #4
	cmp	r1, #0
	add	r3, r1, #237568
	add	r3, r3, #376
	beq	.L652
	cmp	r4, r3
	beq	.L667
.L652:
	add	r2, r2, #1
	cmp	r2, #16
	bne	.L655
	mvn	r3, #0
	str	r3, [r4, #360]
.L653:
	ldr	r1, .L668+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #19
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L667:
	cmn	r2, #1
	str	r2, [r4, #360]
	beq	.L653
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L669:
	.align	2
.L668:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.word	.LC66
	.fnend
	.size	USERDEC_Init, .-USERDEC_Init
	.align	2
	.global	USERDEC_RecycleImage
	.type	USERDEC_RecycleImage, %function
USERDEC_RecycleImage:
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
	beq	.L672
	mov	r2, #0
	ldr	r0, [r4, #360]
	bl	FSP_SetDisplay
	mov	r1, r5
	ldr	r0, [r4, #360]
	bl	FSP_GetFsImagePtr
	cmp	r0, #0
	beq	.L673
	add	r5, r0, #544
	add	r8, r0, #528
	ldr	r1, [r0, #528]
	mov	r6, #0
	ldr	r0, [r4, #360]
	mov	r7, #0
	bl	FreeUsdByDec
	strd	r6, [r8]
	ldr	r0, [r4, #360]
	ldr	r1, [r5, #-8]
	bl	FreeUsdByDec
	strd	r6, [r5, #-8]
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L673:
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L672:
	mvn	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	USERDEC_RecycleImage, .-USERDEC_RecycleImage
	.align	2
	.global	VCTRL_GetUsrdecFrame
	.type	VCTRL_GetUsrdecFrame, %function
VCTRL_GetUsrdecFrame:
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
	ldr	r6, .L696
	mov	r5, r0
	mov	r7, r1
	ldr	r3, [r6, r0, asl #2]
	cmp	r3, #0
	beq	.L691
	ldr	r2, [r3, #592]
	cmp	r2, #20
	bne	.L692
	ldr	r3, [r3, #528]
	cmp	r3, #2
	ble	.L693
	mov	r1, #1
	bl	FSP_NewLogicFs
	subs	r8, r0, #0
	blt	.L694
	mov	r1, r8
	mov	r0, r5
	bl	FSP_GetLogicFs
	mov	r2, r8
	ldr	r1, .L696+4
	mov	r4, r0
	mov	r0, #18
	bl	dprint_vfmw
	cmp	r4, #0
	beq	.L695
	ldr	r2, [r4, #608]
	cmp	r2, #0
	beq	.L681
	ldr	r3, [r4, #612]
	cmp	r3, #0
	beq	.L681
	ldr	r1, [r4, #616]
	cmp	r1, #0
	beq	.L681
	ldr	ip, [r1, #16]
	mov	r0, #18
	ldr	r3, [r3, #16]
	ldr	r2, [r2, #16]
	ldr	r1, .L696+8
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [r4, #608]
	mov	r0, #0
	ldr	r3, [r3, #16]
	str	r3, [r7]
	ldr	r3, [r6, r5, asl #2]
	ldr	r3, [r3, #524]
	str	r3, [r7, #16]
.L676:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L692:
	ldr	r1, .L696+12
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L676
.L693:
	ldr	r1, .L696+16
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L676
.L681:
	ldr	r1, .L696+20
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L676
.L694:
	ldr	r1, .L696+24
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L676
.L691:
	mov	r0, r3
	movw	r2, #6019
	ldr	r3, .L696+28
	ldr	r1, .L696+32
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L676
.L695:
	movw	r2, #6049
	ldr	r1, .L696+36
	mov	r0, #22
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L676
.L697:
	.align	2
.L696:
	.word	.LANCHOR0
	.word	.LC70
	.word	.LC72
	.word	.LC67
	.word	.LC68
	.word	.LC73
	.word	.LC69
	.word	.LC2
	.word	.LC1
	.word	.LC71
	.fnend
	.size	VCTRL_GetUsrdecFrame, .-VCTRL_GetUsrdecFrame
	.align	2
	.global	InitSyntaxCtx
	.type	InitSyntaxCtx, %function
InitSyntaxCtx:
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
	ldr	r2, .L721
	ldr	r1, [r2, r0, asl #2]
	cmp	r1, #0
	beq	.L720
	ldr	r3, [r1, #592]
	cmp	r3, #20
	ldrls	pc, [pc, r3, asl #2]
	b	.L698
.L702:
	.word	.L701
	.word	.L703
	.word	.L704
	.word	.L705
	.word	.L706
	.word	.L707
	.word	.L708
	.word	.L698
	.word	.L709
	.word	.L710
	.word	.L711
	.word	.L711
	.word	.L711
	.word	.L712
	.word	.L706
	.word	.L713
	.word	.L714
	.word	.L715
	.word	.L698
	.word	.L698
	.word	.L716
.L716:
	add	r0, r1, #237568
	add	r1, r1, #600
	add	r0, r0, #376
	bl	USERDEC_Init
.L698:
	ldmfd	sp, {fp, sp, pc}
.L701:
	add	r0, r1, #237568
	add	r1, r1, #600
	add	r0, r0, #376
	bl	H264DEC_Init
	ldmfd	sp, {fp, sp, pc}
.L703:
	add	r0, r1, #237568
	add	r1, r1, #600
	add	r0, r0, #376
	bl	VC1DEC_Init
	ldmfd	sp, {fp, sp, pc}
.L704:
	add	r0, r1, #237568
	add	r1, r1, #600
	add	r0, r0, #376
	bl	MPEG4DEC_Init
	ldmfd	sp, {fp, sp, pc}
.L705:
	add	r0, r1, #237568
	add	r1, r1, #600
	add	r0, r0, #376
	bl	MPEG2DEC_Init
	ldmfd	sp, {fp, sp, pc}
.L706:
	ldr	r3, [r2, #344]
	cmp	r3, #0
	ldmeqfd	sp, {fp, sp, pc}
	add	r0, r1, #237568
	add	r1, r1, #600
	add	r0, r0, #376
	blx	r3
	ldmfd	sp, {fp, sp, pc}
.L707:
	add	r0, r1, #237568
	add	r1, r1, #600
	add	r0, r0, #376
	bl	DIVX3DEC_Init
	ldmfd	sp, {fp, sp, pc}
.L708:
	add	r0, r1, #237568
	add	r1, r1, #600
	add	r0, r0, #376
	bl	AVSDEC_Init
	ldmfd	sp, {fp, sp, pc}
.L709:
	add	r0, r1, #237568
	add	r1, r1, #600
	add	r0, r0, #376
	bl	REAL8DEC_Init
	ldmfd	sp, {fp, sp, pc}
.L710:
	add	r0, r1, #237568
	add	r1, r1, #600
	add	r0, r0, #376
	bl	REAL9DEC_Init
	ldmfd	sp, {fp, sp, pc}
.L711:
	add	r0, r1, #237568
	add	r1, r1, #600
	add	r0, r0, #376
	bl	VP6DEC_Init
	ldmfd	sp, {fp, sp, pc}
.L712:
	add	r0, r1, #237568
	add	r1, r1, #600
	add	r0, r0, #376
	bl	VP8DEC_Init
	ldmfd	sp, {fp, sp, pc}
.L713:
	add	r0, r1, #237568
	add	r1, r1, #600
	add	r0, r0, #376
	bl	MVC_DEC_Init
	ldmfd	sp, {fp, sp, pc}
.L714:
	add	r0, r1, #237568
	add	r1, r1, #600
	add	r0, r0, #376
	bl	HEVCDEC_Init
	ldmfd	sp, {fp, sp, pc}
.L715:
	add	r0, r1, #237568
	add	r1, r1, #600
	add	r0, r0, #376
	bl	VP9DEC_Init
	ldmfd	sp, {fp, sp, pc}
.L720:
	mov	r0, r1
	ldr	r3, .L721+4
	movw	r2, #6102
	ldr	r1, .L721+8
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L722:
	.align	2
.L721:
	.word	.LANCHOR0
	.word	.LC2
	.word	.LC1
	.fnend
	.size	InitSyntaxCtx, .-InitSyntaxCtx
	.align	2
	.global	VCTRL_GetChanRpuSize
	.type	VCTRL_GetChanRpuSize, %function
VCTRL_GetChanRpuSize:
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
	ldr	r3, .L726
	mov	r4, r0
	mov	r5, r1
	ldr	r3, [r3, #148]
	cmp	r3, #0
	mvneq	r0, #0
	beq	.L724
	blx	r3
.L724:
	mul	r4, r4, r0
	str	r4, [r5]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L727:
	.align	2
.L726:
	.word	g_vdm_hal_fun_ptr
	.fnend
	.size	VCTRL_GetChanRpuSize, .-VCTRL_GetChanRpuSize
	.align	2
	.global	VCTRL_GetChanMemSizeWithOption
	.type	VCTRL_GetChanMemSizeWithOption, %function
VCTRL_GetChanMemSizeWithOption:
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
	movw	ip, #17176
	cmp	r0, #26
	mov	r5, #2448
	movt	ip, 11
	movt	r5, 177
	movne	r5, ip
	cmp	r3, #2
	mov	r7, r0
	mov	r8, r3
	mov	r4, r1
	mov	r6, r2
	beq	.L730
	ldr	r1, .L768
	ldr	r2, [r4, #36]
	ldr	r0, [r4, #60]
	ldr	ip, [r1, #3844]
	ldr	r3, [r1, #3840]
	add	r9, r0, ip
	add	r1, r2, r3
	orrs	lr, r9, r1
	bmi	.L760
	cmp	r1, #16
	strle	r1, [r4, #36]
	strle	r9, [r4, #60]
	bgt	.L761
.L734:
	subs	r3, r7, #25
	movne	r3, #1
	cmp	r8, #0
	movne	r3, #0
	cmp	r3, #0
	bne	.L762
.L730:
	ldr	r1, [r4, #36]
	cmp	r1, #0
	blt	.L735
	ldr	r2, [r4, #12]
	cmp	r2, #31
	ble	.L735
	ldr	r3, [r4, #16]
	cmp	r3, #31
	ble	.L735
	ldr	r0, [r4, #56]
	cmp	r0, #262144
	blt	.L735
	ldr	r0, [r4, #44]
	cmp	r0, #1
	beq	.L763
	cmp	r0, #2
	beq	.L764
.L737:
	ldr	r0, [r4, #40]
	cmp	r0, #0
	moveq	r0, #1
	bne	.L765
.L739:
	ldr	ip, .L768+4
	sub	r8, r7, #27
	cmp	r8, #6
	ldr	r10, [r4, #60]
	ldr	ip, [ip, #52]
	mvncc	r9, #1
	mvncs	r9, #0
	cmp	ip, #0
	beq	.L741
	ldr	lr, .L768+8
	add	r1, r1, r10
	add	r1, r1, #2
	str	r9, [sp, #12]
	stmia	sp, {r0, r1}
	mov	r0, #0
	str	lr, [sp, #16]
	mvn	r1, #-2147483648
	str	r0, [sp, #8]
	mov	r0, #1
	blx	ip
	ldr	r9, .L768
	cmp	r0, #0
	bne	.L741
	ldr	r3, [r9, #3852]
	add	r2, r3, #16
	str	r2, [r6]
	ldr	r2, [r4, #176]
	cmp	r2, #1
	addne	r3, r3, #307200
	addne	r3, r3, #2576
	ldreq	r3, [r4, #56]
	strne	r3, [r6]
	ldrne	r3, [r4, #56]
	addeq	r3, r3, #339968
	addeq	r3, r3, #2576
	str	r5, [r6, #8]
	addne	r3, r3, #32768
	str	r3, [r6, #4]
	ldr	r3, [r4, #44]
	cmp	r3, #0
	beq	.L744
	ldr	r2, [r4, #20]
	movw	r0, #4060
	ldr	lr, [r4, #28]
	mov	r3, #4000
	ldr	ip, [r4, #32]
	mov	r1, #2208
	mul	r2, r0, r2
	mla	r3, r3, lr, r2
	mla	r3, r1, ip, r3
	cmp	r3, #0
	movcc	r3, #0
	cmp	r7, #26
	beq	.L766
.L744:
	cmp	r8, #5
	bhi	.L745
.L767:
	movw	r2, #38076
	movt	r2, 19
	cmp	r3, r2
	movcc	r3, r2
.L745:
	mov	r0, #0
	add	r3, r3, r5
	str	r3, [r6, #8]
.L732:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L765:
	add	r0, r1, #1
	cmp	r0, #17
	movge	r0, #17
	b	.L739
.L764:
	ldr	r0, [r4, #20]
	cmp	r0, #0
	ble	.L735
	ldr	r0, [r4, #24]
	cmp	r0, #0
	ble	.L735
.L759:
	ldr	r0, [r4, #28]
	cmp	r0, #0
	ble	.L735
	ldr	r0, [r4, #32]
	cmp	r0, #0
	bgt	.L737
.L735:
	ldr	r1, .L768+12
	mov	r0, #32
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L741:
	movw	r2, #6396
	ldr	r1, .L768+16
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L763:
	ldr	r0, [r4, #20]
	cmp	r0, #0
	bgt	.L759
	b	.L735
.L761:
	ldr	r1, .L768+20
	mov	r0, #32
	bl	dprint_vfmw
	mov	r3, #16
	str	r9, [r4, #60]
	str	r3, [r4, #36]
	b	.L734
.L766:
	movw	r0, #3992
	mov	r1, #2240
	mla	r2, r0, lr, r2
	mla	ip, r1, ip, r2
	cmp	r3, ip
	movcc	r3, ip
	cmp	r8, #5
	bls	.L767
	b	.L745
.L762:
	ldr	r1, .L768+24
	mov	r0, #32
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L732
.L760:
	stmia	sp, {r0, ip}
	mov	r0, #32
	ldr	r1, .L768+28
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L732
.L769:
	.align	2
.L768:
	.word	.LANCHOR0
	.word	g_vdm_hal_fun_ptr
	.word	.LANCHOR0+3848
	.word	.LC77
	.word	.LC78
	.word	.LC75
	.word	.LC76
	.word	.LC74
	.fnend
	.size	VCTRL_GetChanMemSizeWithOption, .-VCTRL_GetChanMemSizeWithOption
	.align	2
	.global	VCTRL_GetChanMemSize
	.type	VCTRL_GetChanMemSize, %function
VCTRL_GetChanMemSize:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #60
	sub	sp, sp, #60
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r10, .L795
	mov	r3, r0, asl #2
	mov	r5, r0, asl #5
	str	r3, [fp, #-68]
	rsb	r3, r3, r5
	str	r2, [fp, #-52]
	add	r3, r10, r3
	mov	r4, r0
	sub	r0, r0, #18
	str	r1, [fp, #-48]
	ldr	r2, [r3, #16]
	ldr	r9, [r3, #12]
	ldr	ip, [r3, #8]
	str	r2, [fp, #-60]
	ldr	r2, [r3, #20]
	str	r2, [fp, #-64]
	cmp	r0, #7
	ldrls	pc, [pc, r0, asl #2]
	b	.L771
.L773:
	.word	.L786
	.word	.L786
	.word	.L786
	.word	.L786
	.word	.L786
	.word	.L774
	.word	.L774
	.word	.L774
.L786:
	mov	r3, #3
.L772:
	ldr	r8, .L795+4
	rsb	r3, r3, r9
	sub	r3, r3, #2
	ldr	r2, [r8, #3840]
	cmp	r2, #0
	movlt	r2, #0
	strlt	r2, [r8, #3840]
	cmp	r3, #15
	movgt	r7, #0
	bgt	.L776
	ldr	r7, [r8, #3840]
	add	r3, r3, r7
	cmp	r3, #16
	rsbgt	r3, r3, #16
	addgt	r7, r7, r3
.L776:
	add	r3, ip, r7
	ldr	r6, [r8, #3844]
	cmp	r3, #0
	ble	.L793
	cmp	r3, #17
	movge	r3, #17
	str	r3, [fp, #-56]
.L778:
	cmp	r4, #23
	bhi	.L779
	ldr	r3, [fp, #-60]
	add	r6, r7, r6
	add	r2, r6, r9
	add	r1, r3, r6
	ldr	r3, [fp, #-64]
	cmp	r2, #0
	cmpgt	r1, #0
	add	r6, r3, r6
	movle	r3, #1
	movgt	r3, #0
	cmp	r6, #0
	orrle	r3, r3, #1
	cmp	r3, #0
	streq	r6, [fp, #-64]
	streq	r1, [fp, #-60]
	moveq	r9, r2
	bne	.L794
.L779:
	cmp	r4, #32
	bhi	.L789
	ldr	r6, .L795+8
	ldr	ip, [r6, #52]
	cmp	ip, #0
	beq	.L781
	ldr	r3, [fp, #-68]
	mov	r0, #0
	ldr	r1, [fp, #-56]
	rsb	r5, r3, r5
	ldr	r8, .L795+12
	add	r4, r10, r5
	str	r9, [sp, #4]
	ldr	r2, [r10, r5]
	mvn	r9, #0
	ldr	r3, [r4, #4]
	str	r1, [sp]
	mvn	r1, #-2147483648
	str	r0, [sp, #8]
	mov	r0, #1
	str	r8, [sp, #16]
	str	r9, [sp, #12]
	blx	ip
	ldr	r10, .L795
	ldr	r7, .L795+16
	cmp	r0, #0
	bne	.L781
	ldr	r3, [r7, #-3188]
	ldr	r2, [fp, #-48]
	add	r3, r3, #307200
	add	r3, r3, #2576
	str	r3, [r2]
	ldr	r2, [fp, #-52]
	ldr	r3, [r4, #24]
	add	r3, r3, #32768
	str	r3, [r2]
	ldr	ip, [r6, #52]
	cmp	ip, #0
	beq	.L783
	ldr	r3, [r4, #4]
	mvn	r1, #-2147483648
	ldr	lr, [fp, #-56]
	str	r0, [sp, #8]
	ldr	r0, [fp, #-60]
	str	lr, [sp]
	ldr	r2, [r10, r5]
	str	r0, [sp, #4]
	mov	r0, #1
	str	r8, [sp, #16]
	str	r9, [sp, #12]
	blx	ip
	subs	lr, r0, #0
	bne	.L783
	ldr	r3, [r7, #-3188]
	ldr	r2, [fp, #-48]
	add	r3, r3, #307200
	add	r3, r3, #2576
	str	r3, [r2, #4]
	ldr	r2, [fp, #-52]
	ldr	r3, [r4, #24]
	add	r3, r3, #32768
	str	r3, [r2, #4]
	ldr	ip, [r6, #52]
	cmp	ip, #0
	beq	.L785
	ldr	r3, [r4, #4]
	mvn	r1, #-2147483648
	str	lr, [sp, #8]
	mov	r0, #1
	ldr	lr, [fp, #-64]
	ldr	r2, [r10, r5]
	str	r8, [sp, #16]
	str	lr, [sp, #4]
	ldr	lr, [fp, #-56]
	str	r9, [sp, #12]
	str	lr, [sp]
	blx	ip
	cmp	r0, #0
	bne	.L785
	ldr	r2, [fp, #-48]
	ldr	r3, [r7, #-3188]
	add	r3, r3, #307200
	add	r3, r3, #2576
	str	r3, [r2, #8]
	ldr	r2, [fp, #-52]
	ldr	r3, [r4, #24]
	add	r3, r3, #32768
	str	r3, [r2, #8]
.L780:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L774:
	mov	r3, #1
	b	.L772
.L794:
	ldr	r1, [r8, #3844]
	mov	r3, r7
	ldr	r0, [fp, #-64]
	mov	r2, r9
	str	r7, [sp, #20]
	str	r1, [sp, #24]
	str	r1, [sp, #12]
	str	r1, [sp]
	ldr	r1, [fp, #-60]
	str	r0, [sp, #16]
	mov	r0, #32
	str	r7, [sp, #8]
	str	r1, [sp, #4]
	ldr	r1, .L795+20
	bl	dprint_vfmw
	b	.L779
.L771:
	mov	r3, #6
	b	.L772
.L781:
	movw	r2, #6568
	ldr	r1, .L795+24
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L783:
	mov	r2, #6592
	ldr	r1, .L795+24
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L785:
	movw	r2, #6616
	ldr	r1, .L795+24
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L793:
	mov	r3, r7
	mov	r2, ip
	ldr	r1, .L795+28
	mov	r0, #32
	str	ip, [fp, #-56]
	bl	dprint_vfmw
	ldr	ip, [fp, #-56]
	cmp	ip, #17
	movlt	r3, ip
	movge	r3, #17
	str	r3, [fp, #-56]
	b	.L778
.L789:
	mvn	r0, #0
	b	.L780
.L796:
	.align	2
.L795:
	.word	CapItem
	.word	.LANCHOR0
	.word	g_vdm_hal_fun_ptr
	.word	.LANCHOR2-3192
	.word	.LANCHOR2
	.word	.LC80
	.word	.LC81
	.word	.LC79
	.fnend
	.size	VCTRL_GetChanMemSize, .-VCTRL_GetChanMemSize
	.align	2
	.global	CloseDrivers
	.type	CloseDrivers, %function
CloseDrivers:
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
	ldr	r5, [r0, #72]
	mov	r4, r0
	cmp	r5, #0
	beq	.L798
	ldr	r5, [r0, #88]
	adds	r5, r5, #0
	movne	r5, #1
.L798:
	ldr	r6, [r4, #16]
	ldr	r7, [r4, #8]
	cmp	r6, #0
	ldr	r8, [r4, #4]
	beq	.L799
	ldr	r3, .L854
	ldr	r3, [r3, #48]
	cmp	r3, #0
	beq	.L800
	mov	r0, #0
	blx	r3
.L801:
	cmp	r5, #0
	beq	.L843
.L802:
	ldr	r3, .L854+4
	mov	r2, #24
	mov	r1, #0
	mov	r0, r4
	ldr	r3, [r3, #48]
	blx	r3
.L799:
	mov	r2, r6
	mov	r1, r8
	mov	r0, r7
	bl	MEM_DelMemRecord
	ldr	r6, [r4, #64]
	ldr	r7, [r4, #56]
	cmp	r6, #0
	ldr	r8, [r4, #52]
	beq	.L803
	ldr	r3, .L854
	ldr	r3, [r3, #48]
	cmp	r3, #0
	beq	.L804
	mov	r0, #0
	blx	r3
.L805:
	cmp	r5, #0
	beq	.L844
.L806:
	ldr	r3, .L854+4
	mov	r2, #24
	mov	r1, #0
	add	r0, r4, #48
	ldr	r3, [r3, #48]
	blx	r3
.L803:
	mov	r2, r6
	mov	r1, r8
	mov	r0, r7
	bl	MEM_DelMemRecord
	ldr	r6, [r4, #40]
	ldr	r7, [r4, #32]
	cmp	r6, #0
	ldr	r8, [r4, #28]
	bne	.L845
.L807:
	mov	r2, r6
	mov	r1, r8
	mov	r0, r7
	bl	MEM_DelMemRecord
	bl	SM_InstInit
	ldr	r5, [r4, #112]
	ldr	r6, [r4, #104]
	cmp	r5, #0
	ldr	r7, [r4, #100]
	bne	.L846
.L810:
	mov	r2, r5
	mov	r1, r7
	mov	r0, r6
	bl	MEM_DelMemRecord
	ldr	r5, [r4, #184]
	ldr	r6, [r4, #176]
	cmp	r5, #0
	ldr	r7, [r4, #172]
	bne	.L847
.L811:
	mov	r2, r5
	mov	r1, r7
	mov	r0, r6
	bl	MEM_DelMemRecord
	ldr	r5, [r4, #160]
	ldr	r6, [r4, #152]
	cmp	r5, #0
	ldr	r7, [r4, #148]
	bne	.L848
.L812:
	mov	r2, r5
	mov	r1, r7
	mov	r0, r6
	bl	MEM_DelMemRecord
	ldr	r5, [r4, #136]
	ldr	r6, [r4, #128]
	cmp	r5, #0
	ldr	r7, [r4, #124]
	bne	.L849
.L813:
	mov	r2, r5
	mov	r1, r7
	mov	r0, r6
	bl	MEM_DelMemRecord
	ldr	r5, [r4, #208]
	ldr	r6, [r4, #200]
	cmp	r5, #0
	ldr	r7, [r4, #196]
	bne	.L850
.L814:
	ldr	r4, .L854+8
	mov	r2, r5
	mov	r1, r7
	mov	r0, r6
	bl	MEM_DelMemRecord
	ldr	r3, [r4, #312]
	cmp	r3, #1
	beq	.L851
	ldr	r3, [r4, #316]
	ldr	r5, .L854+8
	cmp	r3, #1
	beq	.L852
.L816:
	ldr	r3, [r4, #320]
	ldr	r4, .L854+8
	cmp	r3, #1
	beq	.L853
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L845:
	mov	r0, #0
	bl	SM_CloseSCDDrv
	cmp	r5, #0
	beq	.L808
.L809:
	ldr	r3, .L854+4
	mov	r2, #24
	mov	r1, #0
	add	r0, r4, r2
	ldr	r3, [r3, #48]
	blx	r3
	b	.L807
.L846:
	mov	r1, r7
	mov	r0, r6
	bl	MEM_UnmapRegisterAddr
	ldr	r3, .L854+4
	mov	r2, #24
	mov	r1, #0
	add	r0, r4, #96
	ldr	r3, [r3, #48]
	blx	r3
	b	.L810
.L850:
	mov	r1, r7
	mov	r0, r6
	bl	MEM_UnmapRegisterAddr
	ldr	r3, .L854+4
	add	r0, r4, #192
	mov	r2, #24
	mov	r1, #0
	ldr	r3, [r3, #48]
	blx	r3
	b	.L814
.L849:
	mov	r1, r7
	mov	r0, r6
	bl	MEM_UnmapRegisterAddr
	ldr	r3, .L854+4
	mov	r2, #24
	mov	r1, #0
	add	r0, r4, #120
	ldr	r3, [r3, #48]
	blx	r3
	b	.L813
.L848:
	mov	r1, r7
	mov	r0, r6
	bl	MEM_UnmapRegisterAddr
	ldr	r3, .L854+4
	mov	r2, #24
	mov	r1, #0
	add	r0, r4, #144
	ldr	r3, [r3, #48]
	blx	r3
	b	.L812
.L847:
	mov	r1, r7
	mov	r0, r6
	bl	MEM_UnmapRegisterAddr
	ldr	r3, .L854+4
	mov	r2, #24
	mov	r1, #0
	add	r0, r4, #168
	ldr	r3, [r3, #48]
	blx	r3
	b	.L811
.L800:
	mov	r0, r3
	mov	r2, #7104
	ldr	r1, .L854+12
	bl	dprint_vfmw
	b	.L801
.L804:
	mov	r0, r3
	movw	r2, #7125
	ldr	r1, .L854+12
	bl	dprint_vfmw
	b	.L805
.L853:
	ldr	r3, .L854+4
	mov	r1, #0
	mov	r0, #181
	ldr	r3, [r3, #180]
	blx	r3
	mov	r3, #0
	mov	r0, #0
	str	r3, [r4, #320]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L844:
	ldr	r1, [r4, #52]
	ldr	r0, [r4, #56]
	bl	MEM_ReleaseMemBlock
	b	.L806
.L843:
	ldr	r1, [r4, #4]
	ldr	r0, [r4, #8]
	bl	MEM_ReleaseMemBlock
	b	.L802
.L851:
	ldr	r3, .L854+4
	mov	r1, #0
	mov	r0, #127
	ldr	r5, .L854+8
	ldr	r3, [r3, #180]
	blx	r3
	mov	r3, #0
	str	r3, [r4, #312]
	ldr	r3, [r4, #316]
	cmp	r3, #1
	bne	.L816
.L852:
	ldr	r3, .L854+4
	mov	r1, #0
	mov	r0, #136
	ldr	r3, [r3, #180]
	blx	r3
	mov	r3, #0
	str	r3, [r5, #316]
	b	.L816
.L808:
	ldr	r1, [r4, #28]
	ldr	r0, [r4, #32]
	bl	MEM_ReleaseMemBlock
	b	.L809
.L855:
	.align	2
.L854:
	.word	g_vdm_hal_fun_ptr
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.word	.LC15
	.fnend
	.size	CloseDrivers, .-CloseDrivers
	.align	2
	.global	OpenDrivers
	.type	OpenDrivers, %function
OpenDrivers:
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
	add	r6, r0, #96
	mov	r4, r0
	mov	r0, #0
	mov	r1, #65536
	mov	r2, r6
	movt	r0, 63683
	bl	MEM_MapRegisterAddr
	subs	r5, r0, #0
	bne	.L857
	ldr	r2, [r4, #112]
	add	r6, r4, #168
	ldr	r1, [r4, #100]
	ldr	r0, [r4, #104]
	bl	MEM_AddMemRecord
	mov	r0, #53248
	mov	r2, r6
	movt	r0, 63683
	mov	r1, #4096
	bl	MEM_MapRegisterAddr
	subs	r7, r0, #0
	beq	.L899
	mov	r2, #53248
	ldr	r1, .L904
	movt	r2, 63683
	mov	r0, r5
	bl	dprint_vfmw
	ldr	r3, .L904+4
	mov	r1, r5
.L894:
	mov	r0, r6
.L896:
	mov	r2, #24
.L893:
	ldr	r3, [r3, #48]
	blx	r3
	mov	r0, r4
	bl	CloseDrivers
	mvn	r0, #0
.L860:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L899:
	ldr	r2, [r4, #184]
	add	r6, r4, #144
	ldr	r1, [r4, #172]
	ldr	r0, [r4, #176]
	bl	MEM_AddMemRecord
	mov	r0, #49152
	mov	r2, r6
	movt	r0, 63683
	mov	r1, #4096
	bl	MEM_MapRegisterAddr
	cmp	r0, #0
	bne	.L861
	ldr	r2, [r4, #160]
	ldr	r1, [r4, #148]
	ldr	r0, [r4, #152]
	bl	MEM_AddMemRecord
	ldr	r3, [r4, #72]
	cmp	r3, #0
	bne	.L862
.L863:
	ldr	r5, .L904+4
	mov	r3, #0
	ldr	r7, .L904+8
	sub	r0, fp, #64
	ldr	r2, .L904+12
	mov	r1, #20
	ldr	ip, [r5, #68]
	blx	ip
	ldr	r3, [r7, #36]
	cmp	r3, #0
	beq	.L869
	blx	r3
	subs	r2, r0, #0
	ble	.L869
	mov	r6, #0
	mov	r8, #3
	str	r6, [sp]
	mov	r1, r6
	mov	r3, r4
	str	r8, [r4, #20]
	sub	r0, fp, #64
	bl	MEM_AllocMemBlock
	subs	r9, r0, #0
	bne	.L870
	ldr	r2, [r4, #16]
	ldr	r1, [r4, #4]
	ldr	r0, [r4, #8]
	bl	MEM_AddMemRecord
	ldr	r3, [r5, #48]
	mov	r2, #20
	mov	r1, r9
	sub	r0, fp, #84
	blx	r3
	ldr	r3, [r7, #44]
	ldr	r1, [r4, #8]
	ldr	r2, [r4, #16]
	cmp	r3, r6
	str	r9, [fp, #-76]
	str	r1, [fp, #-84]
	str	r2, [fp, #-80]
	beq	.L872
	sub	r0, fp, #84
	blx	r3
	subs	r7, r0, #0
	bne	.L872
	add	r9, r4, #48
	str	r8, [r4, #68]
	mov	r3, r7
	ldr	ip, [r5, #68]
	ldr	r2, .L904+16
	mov	r1, #20
	sub	r0, fp, #64
	blx	ip
	mov	r1, #1
	mov	r3, r9
	str	r1, [sp]
	mov	r2, #16384
	mov	r1, r7
	sub	r0, fp, #64
	bl	MEM_AllocMemBlock
	subs	r6, r0, #0
	bne	.L873
	ldr	r1, [r4, #52]
	add	r7, r4, #24
	ldr	r2, [r4, #64]
	ldr	r0, [r4, #56]
	bl	MEM_AddMemRecord
	ldr	r3, [r4, #56]
	ldr	r2, .L904+20
	mov	r0, r6
	str	r3, [r2, #1196]
	ldr	r3, [r4, #56]
	add	r3, r3, #5120
	str	r3, [r2, #1200]
	bl	VDMDRV_Init
	ldr	ip, [r5, #68]
	mov	r3, r6
	ldr	r2, .L904+24
	mov	r1, #20
	sub	r0, fp, #64
	blx	ip
	str	r8, [r4, #44]
	sub	r0, fp, #64
	str	r6, [sp]
	mov	r3, r7
	mov	r2, #716800
	mov	r1, r6
	bl	MEM_AllocMemBlock
	subs	r8, r0, #0
	bne	.L900
	ldr	r2, [r4, #40]
	ldr	r1, [r4, #28]
	ldr	r0, [r4, #32]
	bl	MEM_AddMemRecord
	mov	r2, r8
	ldr	r1, [r4, #40]
	ldr	r0, [r4, #32]
	bl	SM_OpenSCDDrv
	cmp	r0, #0
	bne	.L901
.L867:
	bl	SM_InstInit
	mov	r6, #0
	ldr	ip, [r5, #176]
	mov	r2, #32
	str	r6, [sp]
	mov	r0, #127
	ldr	r3, .L904+28
	ldr	r1, .L904+32
	blx	ip
	ldr	r8, .L904+4
	subs	r9, r0, #0
	bne	.L902
	ldr	r5, .L904+36
	mov	r6, #1
	str	r9, [sp]
	mov	r2, #32
	ldr	ip, [r8, #176]
	mov	r0, #136
	str	r6, [r5, #312]
	ldr	r3, .L904+40
	ldr	r1, .L904+44
	blx	ip
	subs	r10, r0, #0
	bne	.L903
	str	r6, [r5, #316]
	mov	r2, #32
	str	r10, [sp]
	mov	r0, #181
	ldr	ip, [r8, #176]
	ldr	r3, .L904+48
	ldr	r1, .L904+52
	blx	ip
	cmp	r0, #0
	streq	r6, [r5, #320]
	beq	.L860
	ldr	r1, .L904+56
	mov	r2, #181
	mov	r0, r10
	bl	dprint_vfmw
	ldr	r3, [r8, #48]
	mov	r1, r10
.L891:
	mov	r0, r7
.L892:
	mov	r2, #24
	blx	r3
	mov	r0, r4
	bl	CloseDrivers
	mvn	r0, #0
	b	.L860
.L862:
	ldr	r2, [r4, #88]
	cmp	r2, #0
	beq	.L863
	ldr	r6, .L904+8
	ldr	r2, [r6, #36]
	cmp	r2, #0
	mvneq	r5, #0
	beq	.L864
	blx	r2
	ldr	r3, [r4, #72]
	mov	r5, r0
.L864:
	ldr	r1, [r4, #80]
	mov	r0, r3
	str	r3, [r4, #8]
	mov	r2, r5
	str	r5, [r4, #16]
	str	r1, [r4, #4]
	bl	MEM_AddMemRecord
	ldr	r3, [r6, #44]
	ldr	r1, [r4, #8]
	mov	r0, #0
	ldr	r2, [r4, #16]
	cmp	r3, r0
	str	r0, [fp, #-76]
	str	r1, [fp, #-84]
	str	r2, [fp, #-80]
	beq	.L865
	sub	r0, fp, #84
	blx	r3
	subs	r6, r0, #0
	bne	.L865
	bl	VDMDRV_Init
	ldr	r3, [r4, #72]
	ldr	r1, [r4, #80]
	mov	r2, #716800
	add	r0, r5, r3
	str	r2, [r4, #40]
	add	r1, r5, r1
	str	r0, [r4, #32]
	str	r1, [r4, #28]
	add	r7, r4, #24
	bl	MEM_AddMemRecord
	mov	r2, r6
	ldr	r1, [r4, #40]
	ldr	r0, [r4, #32]
	bl	SM_OpenSCDDrv
	cmp	r0, #0
	bne	.L866
	ldr	r5, .L904+4
	b	.L867
.L857:
	mov	r2, #0
	ldr	r1, .L904
	movt	r2, 63683
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r3, .L904+4
	mov	r0, r6
	mov	r2, #24
	mov	r1, #0
	b	.L893
.L869:
	mov	r2, #0
	ldr	r1, .L904+60
	mov	r0, r2
	bl	dprint_vfmw
	ldr	r3, [r5, #48]
	mov	r2, #24
	mov	r1, #0
	mov	r0, r6
	blx	r3
	mov	r0, r4
	bl	CloseDrivers
	mvn	r0, #0
	b	.L860
.L903:
	ldr	r1, .L904+56
	mov	r2, #136
	mov	r0, r9
	bl	dprint_vfmw
	ldr	r3, [r8, #48]
	mov	r1, r9
	b	.L891
.L902:
	ldr	r1, .L904+56
	mov	r2, #127
	mov	r0, r6
	bl	dprint_vfmw
	ldr	r3, [r8, #48]
	mov	r1, r6
	b	.L891
.L872:
	mov	r2, #0
	ldr	r1, .L904+64
	mov	r0, r2
	bl	dprint_vfmw
	ldr	r3, [r5, #48]
	mov	r2, #24
	mov	r1, #0
.L895:
	mov	r0, r4
	blx	r3
	mov	r0, r4
	bl	CloseDrivers
	mvn	r0, #0
	b	.L860
.L901:
	ldr	r1, .L904+68
	mov	r2, r8
	mov	r0, r8
	bl	dprint_vfmw
	ldr	r3, [r5, #48]
	mov	r1, r8
	b	.L891
.L900:
	ldr	r1, .L904+72
	mov	r2, r6
	mov	r0, r6
	bl	dprint_vfmw
	ldr	r3, [r5, #48]
	mov	r1, r6
	b	.L891
.L873:
	ldr	r1, .L904+76
	mov	r2, r7
	mov	r0, r7
	bl	dprint_vfmw
	ldr	r3, [r5, #48]
	mov	r1, r7
	mov	r0, r9
	b	.L892
.L861:
	mov	r2, #49152
	ldr	r1, .L904
	movt	r2, 63683
	mov	r0, r7
	bl	dprint_vfmw
	ldr	r3, .L904+4
	mov	r1, r7
	b	.L894
.L870:
	mov	r2, r6
	ldr	r1, .L904+80
	mov	r0, r6
	bl	dprint_vfmw
	ldr	r3, [r5, #48]
	mov	r1, r6
	mov	r2, #24
	b	.L895
.L865:
	mov	r2, #0
	ldr	r1, .L904+64
	mov	r0, r2
	bl	dprint_vfmw
	ldr	r3, .L904+4
	mov	r2, #24
	mov	r1, #0
	mov	r0, r4
	b	.L893
.L866:
	ldr	r1, .L904+84
	mov	r2, r6
	mov	r0, r6
	bl	dprint_vfmw
	ldr	r3, .L904+4
	mov	r1, r6
	mov	r0, r7
	b	.L896
.L905:
	.align	2
.L904:
	.word	.LC82
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_vdm_hal_fun_ptr
	.word	.LC85
	.word	.LC88
	.word	g_HwMem
	.word	.LC89
	.word	.LC93
	.word	VCTRL_Isr_0
	.word	.LANCHOR0
	.word	.LC95
	.word	VCTRL_Scd_Isr
	.word	.LC96
	.word	VCTRL_MMU_ISR
	.word	.LC94
	.word	.LC86
	.word	.LC83
	.word	.LC91
	.word	.LC92
	.word	.LC90
	.word	.LC87
	.word	.LC84
	.fnend
	.size	OpenDrivers, .-OpenDrivers
	.align	2
	.global	VCTRL_OpenVfmw
	.type	VCTRL_OpenVfmw, %function
VCTRL_OpenVfmw:
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
	ldr	r4, .L941
	mov	r6, r0
	ldr	r7, .L941+4
	mov	r2, #8
	sub	r0, fp, #44
	mov	r1, #0
	ldr	r3, [r4, #48]
	blx	r3
	ldr	r5, [r7, #64]
	cmp	r5, #0
	bne	.L936
	mov	r1, #1024
	ldr	r3, [r4, #80]
	str	r5, [fp, #-48]
	ldr	r0, .L941+8
	blx	r3
	ldr	r3, [r4, #96]
	ldr	r1, .L941+12
	ldr	r0, .L941+8
	blx	r3
	cmp	r0, #0
	str	r0, [fp, #-48]
	beq	.L909
	ldr	r3, [r4, #92]
	sub	r0, fp, #48
	ldr	r1, .L941+16
	blx	r3
	cmp	r0, #0
	beq	.L928
	sub	r0, fp, #48
	ldr	r3, [r4, #92]
	ldr	r1, .L941+20
	blx	r3
	cmp	r0, #0
	beq	.L937
	mov	r2, r5
	ldr	r3, [r4, #84]
	mov	r1, r5
	blx	r3
	mov	r2, r0
	str	r0, [r7, #3840]
.L913:
	add	r3, r2, #4992
	movw	r1, #10000
	add	r3, r3, #8
	movw	r8, #5000
	cmp	r3, r1
	bhi	.L914
	cmp	r2, r8
	movw	r3, #60536
.L935:
	movt	r3, 65535
	movge	r2, r8
	cmp	r2, r3
	movlt	r2, r3
.L910:
	str	r2, [r7, #3840]
.L912:
	mov	r9, #0
	ldr	r3, [r4, #80]
	mov	r1, #1024
	str	r9, [fp, #-48]
	ldr	r0, .L941+8
	blx	r3
	ldr	r3, [r4, #96]
	ldr	r1, .L941+24
	ldr	r0, .L941+8
	blx	r3
	ldr	r8, .L941
	cmp	r0, r9
	str	r0, [fp, #-48]
	beq	.L915
	ldr	r3, [r8, #92]
	sub	r0, fp, #48
	ldr	r1, .L941+16
	blx	r3
	cmp	r0, r9
	beq	.L916
	sub	r0, fp, #48
	ldr	r3, [r8, #92]
	ldr	r1, .L941+20
	blx	r3
	cmp	r0, r9
	beq	.L938
	mov	r2, r9
	ldr	r3, [r8, #84]
	mov	r1, r9
	blx	r3
	mov	r2, r0
	str	r0, [r7, #3844]
.L919:
	add	r3, r2, #4992
	movw	r1, #10000
	add	r3, r3, #8
	movw	r8, #5000
	cmp	r3, r1
	bhi	.L920
	cmp	r2, r8
	movw	r3, #60536
	movt	r3, 65535
	movlt	r5, r2
	movge	r5, r8
	cmp	r5, r3
	movlt	r5, r3
.L916:
	str	r5, [r7, #3844]
.L918:
	ldr	r7, .L941+28
	mov	r3, #0
	str	r3, [fp, #-48]
	ldr	r5, [r7, #-1024]
	cmp	r5, r3
	beq	.L921
	ldr	r2, .L941+32
	ubfx	r1, r5, #1, #1
	and	r0, r5, #1
	ubfx	r3, r5, #2, #1
	strb	r0, [r7, #-1020]
	ubfx	r5, r5, #3, #1
	strb	r1, [r2]
	strb	r3, [r7, #-1019]
	strb	r5, [r7, #-1018]
.L922:
	ldr	r5, .L941+4
	mov	r2, #272
	ldr	r3, [r4, #48]
	mov	r1, #0
	add	r0, r5, #64
	ldr	r8, .L941
	blx	r3
	ldr	r3, [r4, #48]
	mov	r2, #64
	mov	r1, #0
	mov	r0, r5
	blx	r3
	ldr	r2, .L941+36
	sub	r0, fp, #44
	mov	r1, #134217728
	mov	r3, #75497472
	str	r1, [fp, #-44]
	str	r2, [r7, #-1016]
	str	r3, [fp, #-40]
	bl	MEM_InitMemManager
	bl	FSP_Init
	bl	ChanCtx_Init
	ldr	r3, [r4, #48]
	mov	r2, #64
	mov	r1, #0
	ldr	r0, .L941+40
	blx	r3
	ldr	r3, [r4, #52]
	add	r1, r6, #8
	mov	r2, #24
	add	r0, r5, #160
	blx	r3
	add	r0, r5, #88
	bl	OpenDrivers
	cmp	r0, #0
	bne	.L936
	ldr	r3, [r8, #120]
	mov	r1, #1
	blx	r3
	ldr	r3, [r8, #172]
	ldr	r2, .L941+44
	add	r0, r5, #76
	ldr	r1, .L941+48
	blx	r3
	cmp	r0, #0
	moveq	r3, #1
	streq	r3, [r5, #64]
	bne	.L939
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L921:
	ldr	r3, [r4, #80]
	mov	r1, #1024
	sub	r0, r7, #2048
	ldr	r8, .L941
	blx	r3
	ldr	r3, [r4, #96]
	ldr	r1, .L941+52
	sub	r0, r7, #2048
	blx	r3
	cmp	r0, #0
	str	r0, [fp, #-48]
	beq	.L922
	ldr	r3, [r8, #92]
	sub	r0, fp, #48
	ldr	r1, .L941+16
	blx	r3
	cmp	r0, #0
	ldreq	r0, [r7, #-1024]
	beq	.L924
	sub	r0, fp, #48
	ldr	r3, [r8, #92]
	ldr	r1, .L941+20
	blx	r3
	cmp	r0, #0
	beq	.L940
	ldr	r3, [r8, #84]
	mov	r2, r5
	mov	r1, r5
	blx	r3
	str	r0, [r7, #-1024]
.L924:
	ldr	r2, .L941+32
	ubfx	r1, r0, #1, #1
	and	ip, r0, #1
	ubfx	r3, r0, #2, #1
	strb	ip, [r7, #-1020]
	ubfx	r0, r0, #3, #1
	strb	r1, [r2]
	strb	r3, [r7, #-1019]
	strb	r0, [r7, #-1018]
	b	.L922
.L915:
	ldr	r2, [r7, #3844]
	b	.L919
.L909:
	ldr	r2, [r7, #3840]
	b	.L913
.L920:
	ldr	r1, .L941+56
	mov	r0, #32
	bl	dprint_vfmw
	ldr	r5, [r7, #3844]
	movw	r3, #60536
	cmp	r5, r8
	movt	r3, 65535
	movge	r5, r8
	cmp	r5, r3
	movlt	r5, r3
	b	.L916
.L914:
	ldr	r1, .L941+60
	mov	r0, #32
	bl	dprint_vfmw
	ldr	r2, [r7, #3840]
	movw	r3, #60536
	cmp	r2, r8
	b	.L935
.L928:
	mov	r2, r5
	b	.L910
.L939:
	add	r0, r5, #88
	bl	CloseDrivers
.L936:
	mvn	r0, #0
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L937:
	movw	r3, #8406
	ldr	r2, .L941+64
	ldr	r1, .L941+68
	mov	r0, #22
	bl	dprint_vfmw
	b	.L912
.L938:
	movw	r3, #8453
	ldr	r2, .L941+72
	ldr	r1, .L941+68
	mov	r0, #22
	bl	dprint_vfmw
	b	.L918
.L940:
	movw	r3, #8510
	ldr	r2, .L941+76
	ldr	r1, .L941+68
	mov	r0, #22
	bl	dprint_vfmw
	b	.L922
.L942:
	.align	2
.L941:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.word	.LANCHOR2-2048
	.word	.LC97
	.word	.LC98
	.word	.LC99
	.word	.LC102
	.word	.LANCHOR2
	.word	.LANCHOR3
	.word	VCTRL_EventReport
	.word	.LANCHOR2-1012
	.word	VFMW_CTRL_thread_proc
	.word	.LC105
	.word	.LC104
	.word	.LC103
	.word	.LC101
	.word	.LANCHOR1+184
	.word	.LC100
	.word	.LANCHOR1+204
	.word	.LANCHOR1+224
	.fnend
	.size	VCTRL_OpenVfmw, .-VCTRL_OpenVfmw
	.align	2
	.global	GetNextDecodeMode
	.type	GetNextDecodeMode, %function
GetNextDecodeMode:
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
	movw	r6, #21846
	mov	r3, r2, asl #1
	cmp	r2, #0
	movt	r6, 21845
	add	r5, r2, #7
	str	r2, [sp]
	smull	r6, r7, r3, r6
	movge	r5, r2
	mov	r5, r5, asr #3
	mov	r6, r0
	str	r1, [sp, #4]
	mov	r4, r2
	mov	r8, r1
	sub	r3, r7, r3, asr #31
	ldr	r1, .L951
	mov	r2, r5
	mov	r0, #30
	bl	dprint_vfmw
	cmp	r6, #3
	beq	.L949
	cmp	r4, r8
	movge	r4, r6
	blt	.L950
.L945:
	mov	r2, r6
	mov	r3, r4
	ldr	r1, .L951+4
	mov	r0, #30
	bl	dprint_vfmw
	mov	r0, r4
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L950:
	ldr	r1, .L951+8
	mov	r0, #30
	bl	dprint_vfmw
.L948:
	mov	r4, #3
	b	.L945
.L949:
	cmp	r5, r8
	ble	.L948
	ldr	r1, .L951+12
	mov	r0, #30
	bl	dprint_vfmw
	mov	r4, #0
	b	.L945
.L952:
	.align	2
.L951:
	.word	.LC106
	.word	.LC109
	.word	.LC108
	.word	.LC107
	.fnend
	.size	GetNextDecodeMode, .-GetNextDecodeMode
	.align	2
	.global	VCTRL_GetChanIDByCtx
	.type	VCTRL_GetChanIDByCtx, %function
VCTRL_GetChanIDByCtx:
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
	ldr	ip, .L962
	mov	r2, #0
.L956:
	ldr	r1, [ip], #4
	cmp	r1, #0
	add	r3, r1, #237568
	add	r3, r3, #376
	beq	.L954
	cmp	r0, r3
	beq	.L957
.L954:
	add	r2, r2, #1
	cmp	r2, #16
	bne	.L956
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L957:
	mov	r0, r2
	ldmfd	sp, {fp, sp, pc}
.L963:
	.align	2
.L962:
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_GetChanIDByCtx, .-VCTRL_GetChanIDByCtx
	.align	2
	.global	VCTRL_GetChanIDByMemAddr
	.type	VCTRL_GetChanIDByMemAddr, %function
VCTRL_GetChanIDByMemAddr:
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
	ldr	ip, .L975
	mov	r2, #0
.L968:
	ldr	r3, [ip], #4
	cmp	r3, #0
	beq	.L965
	ldr	r1, [r3, #232]
	cmp	r1, r0
	bhi	.L966
	ldr	lr, [r3, #240]
	add	r1, r1, lr
	cmp	r0, r1
	bcc	.L970
.L966:
	ldr	r1, [r3, #256]
	cmp	r0, r1
	bcc	.L965
	ldr	r3, [r3, #264]
	add	r1, r1, r3
	cmp	r0, r1
	bcc	.L970
.L965:
	add	r2, r2, #1
	cmp	r2, #16
	bne	.L968
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L970:
	mov	r0, r2
	ldmfd	sp, {fp, sp, pc}
.L976:
	.align	2
.L975:
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_GetChanIDByMemAddr, .-VCTRL_GetChanIDByMemAddr
	.align	2
	.global	DecChanSyntax
	.type	DecChanSyntax, %function
DecChanSyntax:
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
	cmp	r0, #15
	mov	r4, r0
	bhi	.L1043
	ldr	r7, .L1059
	ldr	r0, [r7, r0, asl #2]
	cmp	r0, #0
	beq	.L1044
	ldr	r10, [r0, #16]
	cmp	r10, #1
	bne	.L1045
	ldr	r5, [r0, #32]
	cmp	r5, #0
	bne	.L1046
	ldr	r6, .L1059+4
	mov	r3, r4, asl #2
	str	r5, [r0, #376]
	mov	r8, r3
	str	r3, [fp, #-52]
	ldr	r3, [r6]
	blx	r3
	ldr	r2, .L1059+8
	ldr	r1, .L1059+12
	add	r2, r2, r8
	ldr	r3, [r2, #-948]
	ldr	r1, [r1]
	rsb	r3, r3, r0
	cmp	r3, r1
	ldr	r3, [r7, r4, asl #2]
	strhi	r0, [r2, #-948]
	strhi	r10, [fp, #-48]
	ldr	r3, [r3, #592]
	strls	r5, [fp, #-48]
	sub	r2, r3, #10
	ldr	r1, .L1059
	cmp	r2, #2
	bhi	.L984
	ldr	r2, [r1, #3772]
	tst	r2, #1
	bne	.L984
.L985:
	mov	r0, r4
	bl	VCTRL_GetImageBuffer
	cmp	r0, #1
	beq	.L986
	ldr	r3, [fp, #-48]
	cmp	r3, #1
	mvnne	r5, #2
	beq	.L1047
.L1023:
	mov	r0, r5
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L984:
	bic	r2, r3, #16
	cmp	r2, #4
	cmpne	r3, #14
	beq	.L985
	mov	r0, r4
	bl	VCTRL_GetDecParam
	cmp	r0, #0
	beq	.L985
	ldr	r3, [fp, #-48]
	cmp	r3, #1
	mvnne	r5, #1
	bne	.L1023
	mov	r2, r4
	ldr	r1, .L1059+16
	mov	r0, #23
	mvn	r5, #1
	bl	dprint_vfmw
	b	.L1023
.L986:
	ldr	r10, [r7, r4, asl #2]
	ldr	r2, [r10, #1424]
	cmp	r2, #0
	bne	.L1048
.L987:
	ldrb	r3, [r10, #737]
	cmp	r3, #0
	bne	.L990
	ldr	r3, [r10, #1464]
	cmp	r3, #0
	beq	.L1049
.L990:
	add	r3, r10, #736
	str	r3, [fp, #-56]
	ldr	r1, .L1059+20
	mov	r0, r3
	ldrd	r2, [r3, #48]
	ldrd	r8, [r0, #32]
	mov	r0, #29
	strd	r2, [sp]
	mov	r2, r8
	mov	r3, r9
	bl	dprint_vfmw
	ldr	ip, [r7, r4, asl #2]
	ldr	r1, [ip, #52]
	cmp	r1, #1
	beq	.L1050
	sub	r3, r1, #2
	cmp	r1, #6
	cmpne	r3, #1
	bls	.L1010
.L993:
	ldr	r3, [fp, #-56]
	mvn	r2, #0
	ldrd	r0, [r3, #32]
	mvn	r3, #0
	cmp	r1, r3
	add	r3, ip, #656
	cmpeq	r0, r2
	beq	.L1051
	strd	r0, [r3]
.L1003:
	ldr	r3, [fp, #-56]
	add	lr, ip, #688
	ldrd	r2, [r3, #48]
	mov	r8, r2
	add	r2, ip, #672
	str	r2, [fp, #-68]
	mov	r2, r0
	ldr	r0, [fp, #-68]
	mov	r9, r3
	strd	r8, [fp, #-68]
	mov	r3, r1
	ldr	r1, .L1059+24
	strd	r8, [r0]
	ldr	r0, [fp, #-56]
	ldrd	r8, [r0, #56]
	mov	r0, #29
	strd	r8, [lr]
	ldr	lr, [r10, #800]
	ldrd	r8, [fp, #-68]
	str	lr, [ip, #704]
	ldr	lr, [r10, #804]
	str	lr, [ip, #708]
	ldr	lr, [r10, #808]
	str	lr, [ip, #712]
	ldr	lr, [r10, #812]
	str	lr, [ip, #728]
	strd	r8, [sp]
	bl	dprint_vfmw
.L1001:
	mov	r0, #3
	bl	CHECK_REC_POS_ENABLE
	ldr	r3, [fp, #-48]
	adds	r2, r0, #0
	movne	r2, #1
	cmp	r3, #1
	movne	r2, #0
	cmp	r2, #0
	bne	.L1052
.L1004:
	ldr	r3, [r7, r4, asl #2]
	ldr	r0, [fp, #-56]
	add	r2, r3, #237568
	ldr	r10, .L1059
	ldr	r1, [r3, #592]
	add	r2, r2, #376
	bl	DecodeStream
	ldr	r0, [r7, r4, asl #2]
	ldr	r3, [r0, #592]
	cmp	r3, #16
	beq	.L1053
.L1005:
	mov	r0, #4
	bl	CHECK_REC_POS_ENABLE
	cmp	r0, #0
	beq	.L1023
	ldr	r3, [r6]
	blx	r3
	ldr	r3, .L1059+8
	ldr	r1, [fp, #-52]
	add	r8, r3, r1
	ldr	r1, .L1059+28
	ldr	r3, [r8, #-884]
	ldr	r1, [r1]
	rsb	r3, r3, r0
	mov	r2, r0
	cmp	r3, r1
	bls	.L1023
	mov	r0, r4
	str	r2, [r8, #-884]
	bl	VCTRL_GetDecParam
	cmp	r0, #0
	beq	.L1023
	mov	r2, r4, asl #24
	movw	r1, #7899
	add	r2, r2, #262144
	ldr	r0, .L1059+32
	bl	DBG_AddTrace
	b	.L1023
.L1048:
	cmp	r2, #1
	addne	r10, r10, #233472
	ldrne	r3, [r10, #368]
	beq	.L1054
.L1009:
	ldr	r1, .L1059+36
	mov	r0, #31
	bl	dprint_vfmw
	mvn	r5, #0
	b	.L1023
.L1047:
	mov	r2, r4
	ldr	r1, .L1059+40
	mov	r0, #23
	mvn	r5, #2
	bl	dprint_vfmw
	b	.L1023
.L1050:
	add	r3, ip, #237568
	ldr	r3, [r3, #376]
	ldr	r1, [r3, #556]
	sxtb	r1, r1
	cmp	r1, #1
	bne	.L993
.L1010:
	add	r0, ip, #1152
	add	r2, r10, #744
	bl	IsNewpicSeg
	cmp	r0, #0
	bne	.L994
	ldr	lr, [r7, r4, asl #2]
	add	r0, lr, #672
	ldr	r3, [lr, #52]
	cmp	r3, #3
	beq	.L1055
	ldrd	r8, [r0, #-8]
	mvn	r3, #0
	mvn	r2, #0
	cmp	r9, r3
	add	r3, lr, #656
	cmpeq	r8, r2
	beq	.L1056
	strd	r8, [r3]
.L996:
	add	ip, lr, #688
	mvn	r2, #0
	mvn	r3, #0
	strd	r2, [r0, #-8]
	mov	r3, r9
	mov	r2, r8
	ldrd	r8, [ip, #-8]
	add	r1, lr, #704
	str	r1, [fp, #-68]
	ldr	r1, .L1059+44
	strd	r8, [r0]
	mov	r0, #29
	ldr	r8, [fp, #-68]
	ldrd	r8, [r8, #-8]
	strd	r8, [ip]
	ldr	ip, [lr, #716]
	str	ip, [lr, #704]
	ldr	ip, [lr, #720]
	str	ip, [lr, #708]
	ldr	ip, [lr, #724]
	str	ip, [lr, #712]
	ldr	ip, [lr, #732]
	str	ip, [lr, #728]
	bl	dprint_vfmw
	ldr	ip, [r7, r4, asl #2]
	ldr	r3, [ip, #52]
	cmp	r3, #3
	beq	.L1057
.L998:
	ldr	r3, [fp, #-56]
	mvn	r1, #0
	mvn	r0, #0
	ldrd	r2, [r3, #32]
	cmp	r3, r1
	add	r1, ip, #672
	cmpeq	r2, r0
	strned	r2, [r1, #-8]
.L1000:
	ldr	r0, [fp, #-56]
	ldrd	r2, [r0, #48]
	mov	r8, r2
	add	r2, ip, #688
	mov	r9, r3
	add	r3, ip, #704
	strd	r8, [r2, #-8]
	ldrd	r8, [r0, #56]
	strd	r8, [r3, #-8]
	ldr	r3, [r10, #800]
	str	r3, [ip, #716]
	ldr	r3, [r10, #804]
	str	r3, [ip, #720]
	ldr	r3, [r10, #808]
	str	r3, [ip, #724]
	ldr	r3, [r10, #812]
	str	r3, [ip, #732]
.L999:
	ldrd	r2, [r1]
	mov	r0, #29
	ldr	r1, .L1059+48
	bl	dprint_vfmw
	b	.L1001
.L1049:
	add	r1, r10, #744
	mov	r0, r4
	bl	SM_ReadStreamSeg
	cmp	r0, #0
	beq	.L990
	ldr	r3, [fp, #-48]
	cmp	r3, #1
	beq	.L1058
.L991:
	ldr	r3, [r7, r4, asl #2]
	mov	r2, #1
	mvn	r5, #3
	str	r2, [r3, #376]
	b	.L1023
.L1045:
	ldr	r3, .L1059+52
	movw	r2, #7655
	ldr	r1, .L1059+56
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r5, #0
	b	.L1023
.L1046:
	ldr	r3, .L1059+60
	movw	r2, #7656
	ldr	r1, .L1059+56
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r5, #0
	b	.L1023
.L1053:
	ldr	r3, [r0, #1488]
	cmp	r3, #1
	beq	.L1005
	add	r0, r0, #237568
	add	r0, r0, #376
	bl	IsMain10Profile
	cmp	r0, #0
	ldreq	r3, [r10, r4, asl #2]
	streq	r0, [r3, #1488]
	beq	.L1005
	mov	r3, r4
	ldr	r2, .L1059+32
	ldr	r1, .L1059+64
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r3, [r10, r4, asl #2]
	mov	r2, #1
	str	r2, [r3, #1488]
	bl	VDMDRV_AddMatchMode
	b	.L1005
.L1054:
	add	r3, r10, #233472
	ldr	r3, [r3, #368]
	bics	r1, r3, #2
	beq	.L987
	cmp	r3, #1
	bne	.L1009
	ldr	r1, .L1059+68
	mov	r0, #31
	bl	dprint_vfmw
	mvn	r5, #2
	b	.L1023
.L1057:
	ldr	lr, [fp, #-56]
	add	r1, ip, #672
	ldrd	r2, [lr, #32]
	mov	r8, r2
	mov	r9, r3
	strd	r8, [r1, #-8]
	add	r2, ip, #688
	ldrd	r0, [lr, #48]
	add	r3, ip, #704
	strd	r0, [r2, #-8]
	ldrd	r0, [lr, #56]
	strd	r0, [r3, #-8]
	ldr	r3, [r10, #800]
	str	r3, [ip, #716]
	ldr	r3, [r10, #804]
	str	r3, [ip, #720]
	ldr	r3, [r10, #808]
	str	r3, [ip, #724]
	ldr	r3, [r10, #812]
	str	r3, [ip, #732]
.L994:
	ldr	ip, [r7, r4, asl #2]
	ldr	r3, [ip, #52]
	cmp	r3, #3
	addeq	r1, ip, #672
	bne	.L998
	b	.L999
.L1051:
	ldrd	r0, [r3]
	b	.L1003
.L1043:
	ldr	r3, .L1059+72
	movw	r2, #7653
	ldr	r1, .L1059+56
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r5, #0
	b	.L1023
.L1052:
	mov	r2, r4, asl #24
	movw	r1, #7861
	add	r2, r2, #196608
	ldr	r0, .L1059+32
	bl	DBG_AddTrace
	b	.L1004
.L1055:
	ldrd	r8, [r0, #-8]
	add	r3, lr, #656
	strd	r8, [r3]
	b	.L996
.L1056:
	ldrd	r2, [r3]
	mov	r8, r2
	mov	r9, r3
	b	.L996
.L1044:
	ldr	r3, .L1059+76
	movw	r2, #7654
	ldr	r1, .L1059+56
	mvn	r5, #0
	bl	dprint_vfmw
	b	.L1023
.L1058:
	mov	r2, r4
	ldr	r1, .L1059+80
	mov	r0, #23
	bl	dprint_vfmw
	b	.L991
.L1060:
	.align	2
.L1059:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR2
	.word	g_TraceBsPeriod
	.word	.LC111
	.word	.LC114
	.word	.LC117
	.word	g_TraceFramePeriod
	.word	.LANCHOR1+240
	.word	.LC120
	.word	.LC112
	.word	.LC115
	.word	.LC116
	.word	.LC62
	.word	.LC1
	.word	.LC110
	.word	.LC118
	.word	.LC119
	.word	.LC20
	.word	.LC46
	.word	.LC113
	.fnend
	.size	DecChanSyntax, .-DecChanSyntax
	.align	2
	.global	DecSyntax
	.type	DecSyntax, %function
DecSyntax:
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
	ldr	r0, .L1090
	ldr	r1, .L1090+4
	sub	r3, r0, #64
.L1064:
	ldr	r2, [r1, #4]!
	add	r3, r3, #4
	cmp	r2, #0
	ldrne	r2, [r2, #28]
	str	r2, [r3, #-4]
	cmp	r3, r0
	bne	.L1064
	ldr	r7, .L1090+8
	mvn	ip, #0
	ldr	r6, .L1090+12
	mov	r8, #0
	ldr	r10, .L1090+16
	mov	r9, r7
.L1065:
	mov	r3, #0
	ldr	r0, [r6, #-820]
	mov	r4, r3
	ldr	r1, .L1090+20
	b	.L1066
.L1068:
	ldr	r2, [r1, #4]!
	cmp	r0, r2
	movlt	r0, r2
	movlt	r4, r3
.L1066:
	add	r3, r3, #1
	cmp	r3, #16
	bne	.L1068
	add	r3, r6, r4, lsl #2
	cmp	r0, #0
	add	r2, r4, #1
	mov	r1, #0
	str	r8, [r3, #-820]
	str	r2, [r7, #84]
	ldr	r3, .L1090+8
	ble	.L1069
	ldr	r3, [r9, r4, asl #2]
	cmp	r3, r1
	beq	.L1065
	ldr	r2, [r3, #16]
	cmp	r2, #1
	bne	.L1065
	ldr	r2, [r3, #72]
	cmp	r2, r1
	ble	.L1071
	ldr	r5, [r3, #76]
	cmp	r5, r1
	beq	.L1088
.L1071:
	mov	r5, #200
	b	.L1076
.L1074:
	cmp	r0, #0
	bne	.L1065
	subs	r5, r5, #1
	beq	.L1065
.L1076:
	mov	r0, r4
	bl	DecChanSyntax
	cmn	r0, #1
	mov	ip, r0
	bne	.L1074
	ldr	r5, [r6, #-1016]
	cmp	r5, #0
	beq	.L1082
	mov	r3, #0
	str	r0, [fp, #-72]
	mov	r2, r3
	mov	r0, r4
	mov	r1, #102
	blx	r5
	ldr	ip, [fp, #-72]
.L1082:
	mov	r0, ip
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1088:
	mov	r0, r4
	sub	r1, fp, #68
	bl	SM_GetInfo
	cmp	r0, #0
	bne	.L1089
.L1072:
	ldr	r5, [r7, r4, asl #2]
	ldr	r1, [fp, #-56]
	ldr	r2, [r5, #72]
	ldr	r0, [r5, #608]
	bl	GetNextDecodeMode
	ldr	r3, [r7, r4, asl #2]
	str	r0, [r5, #608]
	ldr	r2, [r3, #608]
	cmp	r2, #0
	strne	r8, [r3, #604]
	strne	r8, [r3, #600]
	ldreq	r2, [r3, #68]
	streq	r2, [r3, #604]
	streq	r2, [r3, #600]
	b	.L1071
.L1069:
	mov	r0, ip
	str	r1, [r3, #84]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1089:
	mov	r1, r5
	sub	r0, fp, #68
	ldr	r3, [r10, #48]
	mov	r2, #24
	blx	r3
	b	.L1072
.L1091:
	.align	2
.L1090:
	.word	.LANCHOR2-756
	.word	.LANCHOR0-4
	.word	.LANCHOR0
	.word	.LANCHOR2
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR2-820
	.fnend
	.size	DecSyntax, .-DecSyntax
	.align	2
	.global	VCTRL_RunProcess
	.type	VCTRL_RunProcess, %function
VCTRL_RunProcess:
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
	ldr	r4, .L1101
	ldr	r5, .L1101+4
	mov	r3, #100
	ldr	r6, .L1101+8
	ldr	r0, [r4, #-756]
	str	r3, [r5, #80]
	cmp	r0, #0
	ble	.L1093
	ldr	r3, [r6, #116]
	blx	r3
.L1093:
	ldr	r3, [r6, #12]
	mov	r0, #0
	blx	r3
	bl	SM_Wakeup
	ldr	r3, [r4, #-752]
	mov	r2, #101
	str	r2, [r5, #80]
	cmp	r3, #0
	movne	r7, #0
	beq	.L1100
.L1094:
	mov	r3, #102
	str	r3, [r5, #80]
	bl	VDMDRV_WakeUpVdm
	mov	r4, #0
.L1095:
	mov	r0, r4
	mov	r1, #0
	add	r4, r4, #1
	bl	DeleteRawPacketInBuffer
	cmp	r4, #16
	bne	.L1095
	ldr	r3, [r6, #16]
	mov	r0, #0
	blx	r3
	mov	r2, #105
	ldr	r3, [r6, #128]
	mov	r1, #10
	str	r2, [r5, #80]
	mov	r0, #0
	blx	r3
	mov	r0, r7
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1100:
	bl	DecSyntax
	mov	r7, r0
	b	.L1094
.L1102:
	.align	2
.L1101:
	.word	.LANCHOR2
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VCTRL_RunProcess, .-VCTRL_RunProcess
	.align	2
	.global	VFMW_CTRL_thread_proc
	.type	VFMW_CTRL_thread_proc, %function
VFMW_CTRL_thread_proc:
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
	ldr	r4, .L1130
	ldr	r6, .L1130+4
.L1104:
.L1111:
	ldr	r1, .L1130+8
	mov	r0, #2
	mov	r3, #0
	str	r3, [r4, #80]
	bl	dprint_vfmw
	ldr	r3, [r4, #72]
	mov	r5, #2
	str	r5, [r4, #68]
	cmp	r3, r5
	bne	.L1126
	b	.L1109
.L1128:
	str	r5, [r4, #80]
	bl	VCTRL_RunProcess
	ldr	r1, .L1130+12
	mov	r0, #22
	bl	dprint_vfmw
	ldr	r3, [r4, #72]
	cmp	r3, #2
	beq	.L1109
.L1126:
	cmp	r3, #3
	bne	.L1128
.L1107:
	ldr	r1, .L1130+16
	mov	r0, #2
	mov	r3, #6
	str	r3, [r4, #80]
	bl	dprint_vfmw
	mov	r3, #0
	mov	r0, r3
	str	r3, [r4, #68]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1109:
	ldr	r1, .L1130+20
	mov	r0, #2
	mov	r3, #4
	str	r3, [r4, #80]
	bl	dprint_vfmw
	mov	r3, #1
	str	r3, [r4, #68]
	b	.L1106
.L1129:
	ldr	r3, [r6, #116]
	blx	r3
.L1106:
	ldr	r1, .L1130+24
	mov	r0, #22
	mov	r3, #5
	str	r3, [r4, #80]
	bl	dprint_vfmw
	ldr	r3, [r4, #72]
	mov	r0, #10
	cmp	r3, #1
	beq	.L1111
	cmp	r3, #3
	bne	.L1129
	b	.L1107
.L1131:
	.align	2
.L1130:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC121
	.word	.LC123
	.word	.LC125
	.word	.LC122
	.word	.LC124
	.fnend
	.size	VFMW_CTRL_thread_proc, .-VFMW_CTRL_thread_proc
	.align	2
	.global	VCTRL_GetChanVoQue
	.type	VCTRL_GetChanVoQue, %function
VCTRL_GetChanVoQue:
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
	ldr	r3, .L1152
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	beq	.L1150
	ldr	r2, [r3, #592]
	cmp	r2, #20
	ldrls	pc, [pc, r2, asl #2]
	b	.L1151
.L1135:
	.word	.L1149
	.word	.L1136
	.word	.L1137
	.word	.L1138
	.word	.L1139
	.word	.L1140
	.word	.L1141
	.word	.L1151
	.word	.L1142
	.word	.L1143
	.word	.L1144
	.word	.L1144
	.word	.L1144
	.word	.L1145
	.word	.L1139
	.word	.L1146
	.word	.L1147
	.word	.L1148
	.word	.L1151
	.word	.L1151
	.word	.L1149
.L1149:
	add	r0, r3, #237568
	add	r0, r0, #384
	ldmfd	sp, {fp, sp, pc}
.L1136:
	add	r0, r3, #286720
	add	r0, r0, #248
	ldmfd	sp, {fp, sp, pc}
.L1137:
	add	r0, r3, #260096
	add	r0, r0, #472
	ldmfd	sp, {fp, sp, pc}
.L1138:
	add	r0, r3, #323584
	add	r0, r0, #16
	ldmfd	sp, {fp, sp, pc}
.L1139:
	add	r0, r3, #266240
	add	r0, r0, #1792
	ldmfd	sp, {fp, sp, pc}
.L1140:
	movw	r0, #15256
	movt	r0, 4
	add	r0, r3, r0
	ldmfd	sp, {fp, sp, pc}
.L1141:
	add	r0, r3, #253952
	add	r0, r0, #120
	ldmfd	sp, {fp, sp, pc}
.L1142:
	add	r0, r3, #286720
	add	r0, r0, #3008
	ldmfd	sp, {fp, sp, pc}
.L1143:
	add	r0, r3, #286720
	add	r0, r0, #2992
	ldmfd	sp, {fp, sp, pc}
.L1144:
	add	r0, r3, #249856
	add	r0, r0, #752
	ldmfd	sp, {fp, sp, pc}
.L1145:
	add	r0, r3, #245760
	add	r0, r0, #368
	ldmfd	sp, {fp, sp, pc}
.L1146:
	add	r0, r3, #237568
	add	r0, r0, #960
	ldmfd	sp, {fp, sp, pc}
.L1147:
	add	r0, r3, #299008
	add	r0, r0, #568
	ldmfd	sp, {fp, sp, pc}
.L1148:
	movw	r0, #50360
	movt	r0, 7
	add	r0, r3, r0
	ldmfd	sp, {fp, sp, pc}
.L1151:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1150:
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L1153:
	.align	2
.L1152:
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_GetChanVoQue, .-VCTRL_GetChanVoQue
	.align	2
	.global	VCTRL_FindOccupiedFrame
	.type	VCTRL_FindOccupiedFrame, %function
VCTRL_FindOccupiedFrame:
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
	mov	r6, r0
	bhi	.L1171
	bl	VCTRL_GetChanVoQue
	ldr	r7, .L1174
	ldr	r4, [r7, r6, asl #2]
	subs	r10, r0, #0
	beq	.L1164
	sub	r2, fp, #44
	mov	r3, #0
	sub	r1, fp, #52
	str	r3, [fp, #-52]
	str	r3, [r2, #-4]!
	bl	GetQueueImgNum
	ldr	r2, [fp, #-52]
	cmp	r2, #0
	beq	.L1164
	cmp	r2, #32
	bhi	.L1172
.L1158:
	add	r3, r4, #233472
	add	r4, r4, #235520
	mov	r5, #0
	add	r4, r4, #672
	mov	ip, r5
	add	r3, r3, #416
	str	r6, [fp, #-56]
	str	r3, [fp, #-60]
.L1163:
	ldrh	r3, [r10, #4]
	ldr	r6, [fp, #-60]
	add	r3, r3, ip
	ldr	r8, [fp, #-56]
	and	r3, r3, #63
	add	r3, r10, r3, lsl #2
	ldr	r1, [r3, #12]
	b	.L1162
.L1160:
	add	r6, r6, #72
	cmp	r6, r4
	beq	.L1173
.L1162:
	ldr	r3, [r6]
	cmp	r3, #255
	beq	.L1160
	ldr	r3, [r6, #32]
	ldr	r0, [r1, #44]
	cmp	r0, r3
	bne	.L1160
	ldr	r1, [r7, r8, asl #2]
	movw	r3, #4252
	str	r8, [fp, #-56]
	add	r1, r1, ip, lsl #4
	add	r1, r1, #236544
	add	lr, r1, #848
	add	r2, r1, #840
	str	r0, [r1, #844]
	mov	r0, #1
	ldrd	r8, [r6, #24]
	mov	r9, #0
	str	r2, [fp, #-64]
	ldr	r2, .L1174+4
	strd	r8, [lr]
	ldr	r6, [r6, #12]
	str	r6, [r1, #840]
	str	r6, [sp, #16]
	ldrd	r8, [lr]
	ldr	lr, [fp, #-64]
	ldr	r1, .L1174+8
	strd	r8, [sp, #8]
	ldr	lr, [lr, #4]
	stmia	sp, {ip, lr}
	bl	dprint_vfmw
	ldr	r2, [fp, #-52]
.L1161:
	add	r5, r5, #1
	uxth	r5, r5
	sxth	ip, r5
	cmp	ip, r2
	bcc	.L1163
	ldr	r6, [fp, #-56]
.L1159:
	ldr	r3, [r7, r6, asl #2]
	mov	r0, #0
	add	r3, r3, #237568
	str	r2, [r3, #328]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1164:
	mvn	r0, #0
.L1156:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1173:
	str	r8, [fp, #-56]
	b	.L1161
.L1172:
	mov	r3, #32
	ldr	r1, .L1174+12
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r2, [fp, #-52]
	cmp	r2, #0
	bne	.L1158
	b	.L1159
.L1171:
	ldr	r3, .L1174+16
	movw	r2, #4211
	ldr	r1, .L1174+20
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1156
.L1175:
	.align	2
.L1174:
	.word	.LANCHOR0
	.word	.LANCHOR1+256
	.word	.LC127
	.word	.LC126
	.word	.LC20
	.word	.LC1
	.fnend
	.size	VCTRL_FindOccupiedFrame, .-VCTRL_FindOccupiedFrame
	.align	2
	.global	VCTRL_ReportOccupiedFrame
	.type	VCTRL_ReportOccupiedFrame, %function
VCTRL_ReportOccupiedFrame:
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
	cmp	r0, #15
	mov	r4, r0
	mov	r9, r1
	bhi	.L1199
	cmp	r1, #0
	beq	.L1200
	bl	VCTRL_GetChanVoQue
	ldr	r3, .L1202
	ldr	r4, [r3, r4, asl #2]
	subs	r8, r0, #0
	mvneq	r0, #0
	beq	.L1178
	ldr	r2, .L1202+4
	sub	r5, fp, #44
	mov	r3, #0
	mov	r0, #4
	str	r3, [r5, #-4]!
	ldr	r2, [r2, #12]
	str	r3, [fp, #-52]
	blx	r2
	mov	r2, r5
	sub	r1, fp, #52
	mov	r0, r8
	bl	GetQueueImgNum
	ldr	r2, [fp, #-52]
	cmp	r2, #0
	beq	.L1180
	cmp	r2, #32
	bhi	.L1201
.L1181:
	add	r3, r4, #233472
	ldrh	ip, [r8, #4]
	add	r4, r4, #235520
	add	r3, r3, #416
	mov	r5, #0
	add	r4, r4, #672
	mov	lr, r5
	mov	r10, r3
.L1186:
	add	r3, ip, lr
	mov	r1, r10
	and	r3, r3, #63
	add	r3, r8, r3, lsl #2
	ldr	r0, [r3, #12]
	b	.L1185
.L1183:
	add	r1, r1, #72
	cmp	r1, r4
	beq	.L1184
.L1185:
	ldr	r3, [r1]
	cmp	r3, #255
	beq	.L1183
	ldr	r3, [r1, #32]
	ldr	r6, [r0, #44]
	cmp	r6, r3
	bne	.L1183
	add	ip, r9, lr, lsl #4
	ldr	r2, .L1202+8
	movw	r3, #4379
	mov	r0, #1
	str	r6, [ip, #4]
	ldrd	r6, [r1, #24]
	mov	r7, #0
	strd	r6, [ip, #8]
	ldr	r6, [r1, #12]
	str	lr, [sp]
	ldr	r1, .L1202+12
	str	r6, [fp, #-56]
	str	r6, [r9, lr, asl #4]
	ldr	lr, [fp, #-56]
	ldrd	r6, [ip, #8]
	ldr	ip, [ip, #4]
	str	lr, [sp, #16]
	strd	r6, [sp, #8]
	str	ip, [sp, #4]
	bl	dprint_vfmw
	ldrh	ip, [r8, #4]
	ldr	r2, [fp, #-52]
.L1184:
	add	r5, r5, #1
	uxth	r5, r5
	sxth	lr, r5
	cmp	lr, r2
	bcc	.L1186
	uxth	r3, r2
.L1187:
	add	r3, ip, r3
	and	r3, r3, #63
	strh	r3, [r8, #4]
	str	r2, [r9, #512]
.L1180:
	ldr	r3, .L1202+4
	mov	r0, #4
	ldr	r3, [r3, #16]
	blx	r3
	mov	r0, #0
.L1178:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1201:
	mov	r3, #32
	ldr	r1, .L1202+16
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r2, [fp, #-52]
	cmp	r2, #0
	bne	.L1181
	ldrh	ip, [r8, #4]
	mov	r3, r2
	b	.L1187
.L1199:
	ldr	r3, .L1202+20
	movw	r2, #4336
	ldr	r1, .L1202+24
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1178
.L1200:
	mov	r0, r1
	ldr	r3, .L1202+28
	movw	r2, #4337
	ldr	r1, .L1202+24
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1178
.L1203:
	.align	2
.L1202:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR1+280
	.word	.LC127
	.word	.LC126
	.word	.LC20
	.word	.LC1
	.word	.LC128
	.fnend
	.size	VCTRL_ReportOccupiedFrame, .-VCTRL_ReportOccupiedFrame
	.align	2
	.global	VCTRL_GetChanImgNum
	.type	VCTRL_GetChanImgNum, %function
VCTRL_GetChanImgNum:
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
	ldr	r4, .L1215
	mov	r5, r0
	mov	r6, r1
	mov	r7, r2
	mov	r8, r3
	ldr	ip, [r4, r0, asl #2]
	cmp	ip, #0
	beq	.L1212
	bl	VCTRL_GetChanVoQue
	subs	r3, r0, #0
	beq	.L1207
	mov	r2, r8
	mov	r1, r7
	bl	GetQueueImgNum
	ldr	r3, [r4, r5, asl #2]
	ldr	r2, [r3, #592]
	cmp	r2, #0
	beq	.L1213
	cmp	r2, #16
	beq	.L1214
	cmp	r2, #17
	moveq	r3, #9
	streq	r3, [r6]
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	cmp	r2, #15
	addeq	r3, r3, #11337728
	addeq	r3, r3, #20480
	movne	r3, #2
	ldreq	r3, [r3, #3104]
	str	r3, [r6]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1213:
	add	r3, r3, #262144
	ldr	r3, [r3, #2520]
	str	r3, [r6]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1207:
	str	r3, [r8]
	str	r3, [r7]
	str	r3, [r6]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1214:
	add	r3, r3, #237568
	ldr	r3, [r3, #2880]
	str	r3, [r6]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1212:
	mov	r0, ip
	ldr	r3, .L1215+4
	movw	r2, #8044
	ldr	r1, .L1215+8
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1216:
	.align	2
.L1215:
	.word	.LANCHOR0
	.word	.LC2
	.word	.LC1
	.fnend
	.size	VCTRL_GetChanImgNum, .-VCTRL_GetChanImgNum
	.align	2
	.global	VCTRL_GetChanState
	.type	VCTRL_GetChanState, %function
VCTRL_GetChanState:
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
	cmp	r0, #15
	mov	r6, r0
	mov	r5, r1
	bhi	.L1230
	cmp	r1, #0
	mov	r4, #0
	str	r4, [fp, #-56]
	str	r4, [fp, #-60]
	str	r4, [fp, #-64]
	beq	.L1217
	ldr	r3, .L1231
	mov	r2, #100
	ldr	r7, .L1231+4
	mov	r1, r4
	mov	r0, r5
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r3, [r7, r6, asl #2]
	cmp	r3, r4
	beq	.L1217
	ldr	r2, [r3, #1164]
	movw	r3, #1522
	str	r2, [r5, #32]
	ldr	r2, [r7, r6, asl #2]
	ldr	r2, [r2, #1168]
	str	r2, [r5, #36]
	ldr	r2, [r7, r6, asl #2]
	ldr	r2, [r2, #1172]
	str	r2, [r5, #44]
	ldr	ip, [r7, r6, asl #2]
	add	r0, ip, #204800
	ldrsb	r1, [r0, r3]
	cmp	r1, r4
	ble	.L1222
	movw	r3, #30086
	mov	r2, r4
	movt	r3, 3
	add	r3, ip, r3
.L1224:
	ldrsb	ip, [r3]
	add	r2, r2, #1
	add	r3, r3, #100
	cmp	ip, #3
	addeq	r4, r4, #1
	cmp	r2, r1
	bne	.L1224
.L1222:
	movw	r3, #1522
	str	r4, [r5, #84]
	ldrsb	ip, [r0, r3]
	sub	r2, fp, #60
	sub	r3, fp, #56
	sub	r1, fp, #64
	mov	r0, r6
	str	ip, [r5, #92]
	bl	VCTRL_GetChanImgNum
	ldr	ip, .L1231+8
	mov	r3, #300
	ldr	r0, [fp, #-56]
	ldr	r2, [fp, #-60]
	sub	r1, fp, #52
	mla	r3, r3, r6, ip
	add	r2, r2, r0
	str	r2, [r5, #48]
	mov	r0, r6
	ldr	r2, [r3, #-728]
	str	r2, [r5, #96]
	ldr	r3, [r3, #-740]
	str	r3, [r5, #20]
	bl	SM_GetInfo
	ldr	r3, [fp, #-44]
	ldr	r1, [fp, #-36]
	ldr	r2, [fp, #-32]
	str	r3, [r5, #56]
	str	r1, [r5, #52]
	cmp	r2, #10
	ldr	r3, [r7, r6, asl #2]
	movle	r2, #0
	movgt	r2, #1
	add	r3, r3, #249856
	str	r2, [r5, #80]
	ldrb	r3, [r3, #3968]
	and	r3, r3, #1
	str	r3, [r5, #88]
.L1217:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1230:
	ldr	r3, .L1231+12
	movw	r2, #1527
	ldr	r1, .L1231+16
	mov	r0, #0
	bl	dprint_vfmw
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1232:
	.align	2
.L1231:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.word	.LANCHOR2
	.word	.LC129
	.word	.LC1
	.fnend
	.size	VCTRL_GetChanState, .-VCTRL_GetChanState
	.align	2
	.global	VCTRL_GetChanWidth
	.type	VCTRL_GetChanWidth, %function
VCTRL_GetChanWidth:
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
	bhi	.L1237
	ldr	r3, .L1239
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	beq	.L1238
	ldr	r0, [r0, #1260]
	ldmfd	sp, {fp, sp, pc}
.L1237:
	ldr	r3, .L1239+4
	movw	r2, #8101
	ldr	r1, .L1239+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1238:
	ldr	r3, .L1239+12
	movw	r2, #8102
	ldr	r1, .L1239+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1240:
	.align	2
.L1239:
	.word	.LANCHOR0
	.word	.LC20
	.word	.LC1
	.word	.LC2
	.fnend
	.size	VCTRL_GetChanWidth, .-VCTRL_GetChanWidth
	.align	2
	.global	VCTRL_GetChanHeight
	.type	VCTRL_GetChanHeight, %function
VCTRL_GetChanHeight:
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
	bhi	.L1245
	ldr	r3, .L1247
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	beq	.L1246
	ldr	r0, [r0, #1264]
	ldmfd	sp, {fp, sp, pc}
.L1245:
	ldr	r3, .L1247+4
	movw	r2, #8109
	ldr	r1, .L1247+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1246:
	ldr	r3, .L1247+12
	movw	r2, #8110
	ldr	r1, .L1247+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1248:
	.align	2
.L1247:
	.word	.LANCHOR0
	.word	.LC20
	.word	.LC1
	.word	.LC2
	.fnend
	.size	VCTRL_GetChanHeight, .-VCTRL_GetChanHeight
	.align	2
	.global	VCTRL_GetChanCapLevel
	.type	VCTRL_GetChanCapLevel, %function
VCTRL_GetChanCapLevel:
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
	bhi	.L1253
	ldr	r3, .L1254
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	ldrne	r0, [r3, #44]
	moveq	r0, #33
	ldmfd	sp, {fp, sp, pc}
.L1253:
	ldr	r3, .L1254+4
	movw	r2, #8117
	ldr	r1, .L1254+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1255:
	.align	2
.L1254:
	.word	.LANCHOR0
	.word	.LC20
	.word	.LC1
	.fnend
	.size	VCTRL_GetChanCapLevel, .-VCTRL_GetChanCapLevel
	.align	2
	.global	VCTRL_SetVdecExtra
	.type	VCTRL_SetVdecExtra, %function
VCTRL_SetVdecExtra:
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
	add	r3, r0, #4992
	add	r3, r3, #8
	ldr	r5, .L1263
	movw	r2, #10000
	cmp	r3, r2
	mov	r4, r1
	str	r0, [r5, #3840]
	bhi	.L1261
.L1257:
	movw	r1, #5000
	cmp	r0, r1
	movw	r2, #60536
	add	r3, r4, #4992
	movge	r0, r1
	movt	r2, 65535
	cmp	r0, r2
	add	r3, r3, #8
	movw	r1, #10000
	str	r4, [r5, #3844]
	movlt	r0, r2
	cmp	r3, r1
	str	r0, [r5, #3840]
	ldr	r6, .L1263
	bhi	.L1262
.L1258:
	movw	r2, #5000
	cmp	r4, r2
	movw	r3, #60536
	movge	r4, r2
	movt	r3, 65535
	cmp	r4, r3
	movlt	r4, r3
	str	r4, [r5, #3844]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1261:
	mov	r2, r0
	ldr	r1, .L1263+4
	mov	r0, #32
	bl	dprint_vfmw
	ldr	r0, [r5, #3840]
	b	.L1257
.L1262:
	mov	r2, r4
	ldr	r1, .L1263+8
	mov	r0, #32
	bl	dprint_vfmw
	ldr	r4, [r6, #3844]
	b	.L1258
.L1264:
	.align	2
.L1263:
	.word	.LANCHOR0
	.word	.LC130
	.word	.LC131
	.fnend
	.size	VCTRL_SetVdecExtra, .-VCTRL_SetVdecExtra
	.align	2
	.global	VCTRL_ExtAccGetDecParam
	.type	VCTRL_ExtAccGetDecParam, %function
VCTRL_ExtAccGetDecParam:
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
	ldr	r6, .L1294
	mov	r7, r0
	mov	r0, #0
	ldr	r3, [r6, #12]
	blx	r3
	ldr	r3, [r6, #12]
	mov	r0, #5
	blx	r3
	ldr	r4, [r7]
	cmn	r4, #1
	beq	.L1286
	mov	r0, r4
	bl	VCTRL_IsChanActive
	subs	r5, r0, #0
	bne	.L1287
	mov	r0, r4
	bl	VDMDRV_IsChanDec
	cmp	r0, #1
	beq	.L1288
	mov	r0, r4
	bl	VCTRL_GetDecParam
	subs	r2, r0, #0
	beq	.L1289
	cmp	r4, #15
	bhi	.L1281
	ldr	r3, .L1294+4
	ldr	r3, [r3, r4, asl #2]
	cmp	r3, #0
	beq	.L1281
	ldr	r1, [r3, #592]
	sub	r0, fp, #56
	ldr	r3, .L1294+8
	str	r4, [fp, #-56]
	str	r1, [fp, #-52]
	str	r2, [fp, #-48]
	ldr	r3, [r3, #4052]
	blx	r3
	cmp	r0, #1
	bne	.L1283
	ldr	ip, [fp, #-56]
	mov	r0, r4
.L1284:
	ldr	r2, [fp, #-52]
	mov	r1, #4
	ldr	r3, [fp, #-48]
	str	ip, [r7]
	stmib	r7, {r2, r3}
	bl	VDMDRV_SetChanIsDec
	ldr	r3, [r6, #16]
	mov	r0, #5
	blx	r3
	ldr	r3, [r6, #16]
	mov	r0, r5
	blx	r3
.L1276:
	mov	r0, r5
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1286:
	ldr	r8, .L1294+12
	ldr	r9, [r8, #64]
	cmp	r9, #0
	blt	.L1267
	add	r4, r8, #64
	ldr	r10, .L1294+8
	add	r8, r8, #124
	b	.L1268
.L1290:
	mov	r3, r9
	ldr	r2, .L1294+16
	ldr	r1, .L1294+20
	mov	r0, #1
	bl	dprint_vfmw
.L1270:
	cmp	r4, r8
	beq	.L1267
.L1277:
	ldr	r9, [r4, #4]!
	cmp	r9, #0
	blt	.L1267
.L1268:
	mov	r0, r9
	bl	VCTRL_IsChanActive
	subs	r5, r0, #0
	bne	.L1290
	mov	r0, r9
	bl	VDMDRV_IsChanDec
	cmp	r0, #1
	beq	.L1291
	mov	r0, r9
	bl	VCTRL_GetDecParam
	subs	r1, r0, #0
	beq	.L1292
	cmp	r9, #15
	bhi	.L1273
	ldr	r3, .L1294+4
	ldr	r2, [r3, r9, asl #2]
	cmp	r2, #0
	beq	.L1273
	ldr	r2, [r2, #592]
	sub	r0, fp, #56
	str	r9, [fp, #-56]
	str	r1, [fp, #-48]
	str	r2, [fp, #-52]
	ldr	r2, [r10, #4052]
	blx	r2
	cmp	r0, #1
	beq	.L1293
	cmp	r4, r8
	str	r5, [r7, #8]
	bne	.L1277
.L1267:
	ldr	r3, [r6, #16]
	mov	r0, #5
	blx	r3
	ldr	r3, [r6, #16]
	mov	r0, #0
	mvn	r5, #0
	blx	r3
	mov	r0, r5
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1273:
	mov	r3, r9
	movw	r2, #8239
	ldr	r1, .L1294+24
	mov	r0, #1
	bl	dprint_vfmw
	b	.L1270
.L1291:
	mov	r2, r9
	ldr	r1, .L1294+28
	mov	r0, #22
	bl	dprint_vfmw
	b	.L1270
.L1288:
	mov	r2, r4
	ldr	r1, .L1294+28
	mov	r0, #22
	bl	dprint_vfmw
.L1283:
	str	r5, [r7, #8]
	mov	r0, #5
	ldr	r3, [r6, #16]
	blx	r3
	ldr	r3, [r6, #16]
	mov	r0, r5
	mvn	r5, #0
	blx	r3
	b	.L1276
.L1292:
	mov	r2, r9
	ldr	r1, .L1294+32
	mov	r0, #22
	bl	dprint_vfmw
	b	.L1270
.L1293:
	ldr	ip, [fp, #-56]
	mov	r0, r9
	b	.L1284
.L1287:
	ldr	r2, .L1294+16
	mov	r3, r4
	ldr	r1, .L1294+36
.L1285:
	mov	r0, #1
	mov	r4, #0
	bl	dprint_vfmw
	str	r4, [r7, #8]
	mov	r0, #5
	ldr	r3, [r6, #16]
	blx	r3
	mov	r0, r4
	ldr	r3, [r6, #16]
	mvn	r5, #0
	blx	r3
	b	.L1276
.L1281:
	mov	r3, r4
	movw	r2, #8324
	ldr	r1, .L1294+24
	b	.L1285
.L1289:
	ldr	r3, [r6, #124]
	blx	r3
	mov	r2, r4
	ldr	r1, .L1294+32
	mov	r0, #22
	bl	dprint_vfmw
	b	.L1283
.L1295:
	.align	2
.L1294:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.word	.LANCHOR2
	.word	g_ChanCtx
	.word	.LANCHOR1+308
	.word	.LC132
	.word	.LC55
	.word	.LC133
	.word	.LC134
	.word	.LC135
	.fnend
	.size	VCTRL_ExtAccGetDecParam, .-VCTRL_ExtAccGetDecParam
	.align	2
	.global	VCTRL_GetLastFrameIdPlus2
	.type	VCTRL_GetLastFrameIdPlus2, %function
VCTRL_GetLastFrameIdPlus2:
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
	bhi	.L1300
	ldr	r3, .L1301
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	ldrne	r0, [r3, #380]
	mvneq	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1300:
	ldr	r3, .L1301+4
	movw	r2, #9283
	ldr	r1, .L1301+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L1302:
	.align	2
.L1301:
	.word	.LANCHOR0
	.word	.LC20
	.word	.LC1
	.fnend
	.size	VCTRL_GetLastFrameIdPlus2, .-VCTRL_GetLastFrameIdPlus2
	.align	2
	.global	VCTRL_SetLastFrameIdPlus2
	.type	VCTRL_SetLastFrameIdPlus2, %function
VCTRL_SetLastFrameIdPlus2:
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
	bhi	.L1309
	ldr	r3, .L1310
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	strne	r1, [r3, #380]
	ldmfd	sp, {fp, sp, pc}
.L1309:
	ldr	r3, .L1310+4
	movw	r2, #9295
	ldr	r1, .L1310+8
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L1311:
	.align	2
.L1310:
	.word	.LANCHOR0
	.word	.LC20
	.word	.LC1
	.fnend
	.size	VCTRL_SetLastFrameIdPlus2, .-VCTRL_SetLastFrameIdPlus2
	.align	2
	.global	VCTRL_SetLastFrameState
	.type	VCTRL_SetLastFrameState, %function
VCTRL_SetLastFrameState:
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
	bhi	.L1318
	ldr	r3, .L1319
	ldr	r3, [r3, r0, asl #2]
	cmp	r3, #0
	strne	r1, [r3, #384]
	ldmfd	sp, {fp, sp, pc}
.L1318:
	ldr	r3, .L1319+4
	movw	r2, #9307
	ldr	r1, .L1319+8
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L1320:
	.align	2
.L1319:
	.word	.LANCHOR0
	.word	.LC20
	.word	.LC1
	.fnend
	.size	VCTRL_SetLastFrameState, .-VCTRL_SetLastFrameState
	.align	2
	.global	VCTRL_ReportLastFrame
	.type	VCTRL_ReportLastFrame, %function
VCTRL_ReportLastFrame:
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
	subs	r5, r1, #0
	mov	r4, r0
	moveq	r2, #2
	beq	.L1323
	cmp	r5, #1
	moveq	r2, #3
	movne	r2, #4
.L1323:
	cmp	r4, #15
	bhi	.L1335
	ldr	r6, .L1336
	ldr	r3, [r6, r4, asl #2]
	cmp	r3, #0
	strne	r2, [r3, #384]
.L1326:
	ldr	r3, .L1336+4
	ldr	ip, [r3, #-1016]
	cmp	ip, #0
	beq	.L1327
	sub	r2, fp, #28
	mov	r3, #4
	mov	r1, #115
	mov	r0, r4
	str	r5, [r2, #-4]!
	blx	ip
.L1327:
	ldr	ip, [r6, r4, asl #2]
	mov	r3, r5
	mov	r2, r4
	ldr	r1, .L1336+8
	mov	r0, #1
	ldr	ip, [ip, #384]
	str	ip, [sp]
	bl	dprint_vfmw
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L1335:
	ldr	r3, .L1336+12
	movw	r2, #9307
	ldr	r1, .L1336+16
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r6, .L1336
	b	.L1326
.L1337:
	.align	2
.L1336:
	.word	.LANCHOR0
	.word	.LANCHOR2
	.word	.LC136
	.word	.LC20
	.word	.LC1
	.fnend
	.size	VCTRL_ReportLastFrame, .-VCTRL_ReportLastFrame
	.align	2
	.global	VCTRL_OutputLastFrame
	.type	VCTRL_OutputLastFrame, %function
VCTRL_OutputLastFrame:
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
	ldr	r3, .L1364
	mov	r5, r0
	ldr	r3, [r3, r0, asl #2]
	add	r0, r3, #237568
	ldr	r2, [r0, #368]
	cmp	r2, #17
	ldrls	pc, [pc, r2, asl #2]
	b	.L1358
.L1341:
	.word	.L1340
	.word	.L1342
	.word	.L1343
	.word	.L1344
	.word	.L1358
	.word	.L1345
	.word	.L1346
	.word	.L1358
	.word	.L1347
	.word	.L1348
	.word	.L1349
	.word	.L1349
	.word	.L1349
	.word	.L1350
	.word	.L1358
	.word	.L1351
	.word	.L1352
	.word	.L1353
.L1353:
	add	r0, r0, #376
	bl	VP9DEC_GetRemainImg
	mov	r4, r0
.L1339:
	cmn	r4, #1
	beq	.L1355
	cmp	r4, #0
	bne	.L1363
	mov	r0, r5
	mov	r1, r4
	bl	VCTRL_ReportLastFrame
	ldr	r1, .L1364+4
	mov	r0, #2
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1340:
	add	r0, r0, #376
	bl	H264DEC_GetRemainImg
	mov	r4, r0
	b	.L1339
.L1342:
	add	r0, r0, #376
	bl	VC1DEC_GetRemainImg
	mov	r4, r0
	b	.L1339
.L1343:
	add	r0, r0, #376
	bl	MPEG4DEC_GetRemainImg
	mov	r4, r0
	b	.L1339
.L1344:
	add	r0, r0, #376
	bl	MPEG2DEC_GetRemainImg
	mov	r4, r0
	b	.L1339
.L1345:
	add	r0, r0, #376
	bl	DIVX3DEC_GetRemainImg
	mov	r4, r0
	b	.L1339
.L1346:
	add	r0, r0, #376
	bl	AVSDEC_GetRemainImg
	mov	r4, r0
	b	.L1339
.L1347:
	add	r0, r0, #376
	bl	REAL8DEC_GetRemainImg
	mov	r4, r0
	b	.L1339
.L1348:
	add	r0, r0, #376
	bl	REAL9DEC_GetRemainImg
	mov	r4, r0
	b	.L1339
.L1349:
	add	r0, r0, #376
	bl	VP6DEC_GetRemainImg
	mov	r4, r0
	b	.L1339
.L1350:
	add	r0, r0, #376
	bl	VP8DEC_GetRemainImg
	mov	r4, r0
	b	.L1339
.L1351:
	add	r0, r0, #376
	bl	MVC_DEC_GetRemainImg
	mov	r4, r0
	b	.L1339
.L1352:
	add	r0, r0, #376
	bl	HEVCDEC_GetRemainImg
	mov	r4, r0
	b	.L1339
.L1363:
	mov	r0, r5
	mov	r1, r4
	bl	VCTRL_ReportLastFrame
	sub	r2, r4, #2
	ldr	r1, .L1364+8
	mov	r0, #2
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1358:
	mvn	r4, #0
.L1355:
	mov	r0, r5
	mov	r1, #1
	bl	VCTRL_ReportLastFrame
	ldr	r1, .L1364+12
	mov	r0, #2
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1365:
	.align	2
.L1364:
	.word	.LANCHOR0
	.word	.LC138
	.word	.LC139
	.word	.LC137
	.fnend
	.size	VCTRL_OutputLastFrame, .-VCTRL_OutputLastFrame
	.align	2
	.global	VCTRL_PostProc
	.type	VCTRL_PostProc, %function
VCTRL_PostProc:
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
	ldr	r5, .L1397
	mov	r4, r0
	ldr	r0, [r5, r0, asl #2]
	cmp	r0, #0
	beq	.L1390
	ldr	ip, [r0, #592]
	cmp	ip, #17
	ldrls	pc, [pc, ip, asl #2]
	b	.L1366
.L1370:
	.word	.L1369
	.word	.L1371
	.word	.L1372
	.word	.L1373
	.word	.L1366
	.word	.L1374
	.word	.L1375
	.word	.L1366
	.word	.L1376
	.word	.L1377
	.word	.L1378
	.word	.L1378
	.word	.L1378
	.word	.L1379
	.word	.L1366
	.word	.L1380
	.word	.L1381
	.word	.L1382
.L1380:
	add	r0, r0, #237568
	mov	r2, #1
	add	r0, r0, #376
	bl	MVC_DEC_VDMPostProc
	ldr	r3, [r5, r4, asl #2]
	ldr	r5, .L1397
	add	r3, r3, #237568
	ldrb	r2, [r3, #377]
	cmp	r2, #1
	beq	.L1391
.L1389:
	mov	r2, #0
	str	r2, [r3, #604]
.L1366:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L1382:
	add	r0, r0, #237568
	ldr	r3, [fp, #4]
	mov	r2, #0
	add	r0, r0, #376
	bl	VP9DEC_VDMPostProc
	ldr	r3, [r5, r4, asl #2]
	mov	r2, #0
	add	r3, r3, #237568
	str	r2, [r3, #380]
	b	.L1366
.L1369:
	ldr	r2, [fp, #4]
	add	r0, r0, #237568
	add	r0, r0, #376
	mov	r6, #0
	str	r6, [sp]
	str	r2, [sp, #4]
	mov	r2, #1
	bl	H264DEC_VDMPostProc
	ldr	r3, [r5, r4, asl #2]
	ldr	r5, .L1397
	add	r2, r3, #249856
	ldrb	r2, [r2, #1648]
	cmp	r2, #1
	beq	.L1392
.L1383:
	add	r3, r3, #237568
	mov	r2, #0
	str	r2, [r3, #736]
	b	.L1366
.L1371:
	add	r0, r0, #237568
	ldr	r6, .L1397
	add	r0, r0, #376
	bl	VC1DEC_VDMPostProc
	ldr	r3, [r5, r4, asl #2]
	add	r2, r3, #249856
	ldrb	r2, [r2, #823]
	cmp	r2, #1
	beq	.L1393
.L1388:
	add	r3, r3, #237568
	mov	r2, #0
	str	r2, [r3, #380]
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L1372:
	add	r0, r0, #237568
	mov	r2, r3
	add	r0, r0, #376
	bl	MPEG4DEC_VDMPostProc
	ldr	r3, [r5, r4, asl #2]
	ldr	r5, .L1397
	add	r2, r3, #258048
	ldrb	r2, [r2, #2908]
	cmp	r2, #1
	beq	.L1394
.L1386:
	add	r3, r3, #237568
	mov	r2, #0
	str	r2, [r3, #1412]
	b	.L1366
.L1373:
	add	r0, r0, #237568
	ldr	r6, .L1397
	add	r0, r0, #376
	bl	MPEG2DEC_VDMPostProc
	ldr	r3, [r5, r4, asl #2]
	add	r2, r3, #323584
	ldrb	r2, [r2, #386]
	cmp	r2, #1
	bne	.L1388
	mov	r0, r4
	bl	VCTRL_OutputLastFrame
	ldr	r3, [r6, r4, asl #2]
	mov	r1, #0
	add	r2, r3, #323584
	strb	r1, [r2, #386]
	b	.L1388
.L1374:
	add	r0, r0, #237568
	add	r0, r0, #376
	bl	DIVX3DEC_VDMPostProc
	ldr	r3, [r5, r4, asl #2]
	mov	r2, #0
	add	r3, r3, #237568
	str	r2, [r3, #380]
	b	.L1366
.L1375:
	add	r0, r0, #237568
	ldr	r6, .L1397
	add	r0, r0, #376
	bl	AVSDEC_VDMPostProc
	ldr	r3, [r5, r4, asl #2]
	add	r3, r3, #237568
	ldrb	r2, [r3, #376]
	cmp	r2, #1
	beq	.L1395
.L1387:
	mov	r2, #0
	str	r2, [r3, #392]
	b	.L1366
.L1376:
	add	r0, r0, #237568
	add	r0, r0, #376
	bl	REAL8DEC_VDMPostProc
	ldr	r3, [r5, r4, asl #2]
	mov	r2, #0
	add	r3, r3, #237568
	str	r2, [r3, #380]
	b	.L1366
.L1377:
	add	r0, r0, #237568
	add	r0, r0, #376
	bl	REAL9DEC_VDMPostProc
	ldr	r3, [r5, r4, asl #2]
	mov	r2, #0
	add	r3, r3, #237568
	str	r2, [r3, #380]
	b	.L1366
.L1378:
	add	r0, r0, #237568
	add	r0, r0, #376
	bl	VP6DEC_VDMPostProc
	ldr	r3, [r5, r4, asl #2]
	mov	r2, #0
	add	r3, r3, #237568
	str	r2, [r3, #380]
	b	.L1366
.L1379:
	add	r0, r0, #237568
	add	r0, r0, #376
	bl	VP8DEC_VDMPostProc
	ldr	r3, [r5, r4, asl #2]
	mov	r2, #0
	add	r3, r3, #237568
	str	r2, [r3, #380]
	b	.L1366
.L1381:
	ldr	r2, [fp, #4]
	add	r0, r0, #237568
	add	r0, r0, #376
	mov	r6, #0
	str	r6, [sp]
	str	r2, [sp, #4]
	mov	r2, #1
	bl	HEVCDEC_VDMPostProc
	ldr	r3, [r5, r4, asl #2]
	ldr	r5, .L1397
	add	r3, r3, #237568
	ldrb	r2, [r3, #383]
	cmp	r2, #1
	beq	.L1396
.L1384:
	mov	r2, #0
	str	r2, [r3, #2704]
	b	.L1366
.L1390:
	ldr	r3, .L1397+4
	movw	r2, #5217
	ldr	r1, .L1397+8
	bl	dprint_vfmw
	b	.L1366
.L1393:
	mov	r0, r4
	bl	VCTRL_OutputLastFrame
	ldr	r3, [r6, r4, asl #2]
	mov	r1, #0
	add	r2, r3, #249856
	strb	r1, [r2, #823]
	b	.L1388
.L1392:
	mov	r0, r4
	bl	VCTRL_OutputLastFrame
	ldr	r3, [r5, r4, asl #2]
	add	r2, r3, #249856
	strb	r6, [r2, #1648]
	b	.L1383
.L1394:
	mov	r0, r4
	bl	VCTRL_OutputLastFrame
	ldr	r3, [r5, r4, asl #2]
	mov	r1, #0
	add	r2, r3, #258048
	strb	r1, [r2, #2908]
	b	.L1386
.L1396:
	mov	r0, r4
	bl	VCTRL_OutputLastFrame
	ldr	r2, [r5, r4, asl #2]
	add	r2, r2, #237568
	mov	r3, r2
	strb	r6, [r2, #383]
	b	.L1384
.L1395:
	mov	r0, r4
	bl	VCTRL_OutputLastFrame
	ldr	r2, [r6, r4, asl #2]
	mov	r1, #0
	add	r2, r2, #237568
	mov	r3, r2
	strb	r1, [r2, #376]
	b	.L1387
.L1391:
	mov	r0, r4
	bl	VCTRL_OutputLastFrame
	ldr	r2, [r5, r4, asl #2]
	mov	r1, #0
	add	r2, r2, #237568
	mov	r3, r2
	strb	r1, [r2, #377]
	b	.L1389
.L1398:
	.align	2
.L1397:
	.word	.LANCHOR0
	.word	.LC2
	.word	.LC1
	.fnend
	.size	VCTRL_PostProc, .-VCTRL_PostProc
	.align	2
	.global	VCTRL_VdmPostProc
	.type	VCTRL_VdmPostProc, %function
VCTRL_VdmPostProc:
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
	cmp	r0, #15
	mov	r4, r0
	mov	r5, r1
	mov	r6, r2
	mov	r7, r3
	bhi	.L1407
	ldr	ip, .L1409
	ldr	ip, [ip, r0, asl #2]
	cmp	ip, #0
	beq	.L1408
	ldr	ip, [ip, #16]
	cmp	ip, #1
	beq	.L1403
	ldr	r3, .L1409+4
	movw	r2, #5409
	ldr	r1, .L1409+8
	mov	r0, #0
	bl	dprint_vfmw
.L1399:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1403:
	bl	VCTRL_GetDecParam
	cmp	r0, #0
	beq	.L1399
	ldr	r3, [fp, #4]
	mov	r2, r6
	mov	r1, r5
	mov	r0, r4
	str	r3, [sp]
	mov	r3, r7
	bl	VCTRL_PostProc
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1407:
	ldr	r3, .L1409+12
	movw	r2, #5407
	ldr	r1, .L1409+8
	mov	r0, #0
	bl	dprint_vfmw
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1408:
	mov	r0, ip
	ldr	r3, .L1409+16
	movw	r2, #5408
	ldr	r1, .L1409+8
	bl	dprint_vfmw
	b	.L1399
.L1410:
	.align	2
.L1409:
	.word	.LANCHOR0
	.word	.LC62
	.word	.LC1
	.word	.LC61
	.word	.LC46
	.fnend
	.size	VCTRL_VdmPostProc, .-VCTRL_VdmPostProc
	.align	2
	.global	VCTRL_ExtAccPostProcess
	.type	VCTRL_ExtAccPostProcess, %function
VCTRL_ExtAccPostProcess:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #144
	sub	sp, sp, #144
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r4, .L1412
	mov	r6, r0
	mov	r2, #136
	mov	r7, r1
	sub	r0, fp, #164
	mov	r1, #0
	ldr	r3, [r4, #48]
	blx	r3
	ldr	r3, [r4, #12]
	mov	r0, #0
	mov	r5, r0
	blx	r3
	ldr	r3, [r4, #12]
	mov	r0, #5
	blx	r3
	mov	r1, r7
	mov	r2, r5
	sub	r3, fp, #164
	mov	r0, r6
	str	r5, [sp]
	bl	VCTRL_VdmPostProc
	mov	r0, r6
	bl	VDMDRV_ClearChanIsDec
	ldr	r3, [r4, #16]
	mov	r0, #5
	blx	r3
	ldr	r3, [r4, #16]
	mov	r0, r5
	blx	r3
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1413:
	.align	2
.L1412:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VCTRL_ExtAccPostProcess, .-VCTRL_ExtAccPostProcess
	.align	2
	.global	VCTRL_SvdecLastFrame
	.type	VCTRL_SvdecLastFrame, %function
VCTRL_SvdecLastFrame:
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
	add	r1, r1, #2
	bl	VCTRL_ReportLastFrame
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VCTRL_SvdecLastFrame, .-VCTRL_SvdecLastFrame
	.align	2
	.global	Get_YuvFormat
	.type	Get_YuvFormat, %function
Get_YuvFormat:
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
	cmp	r1, #6
	ldrls	pc, [pc, r1, asl #2]
	b	.L1416
.L1418:
	.word	.L1417
	.word	.L1419
	.word	.L1420
	.word	.L1421
	.word	.L1422
	.word	.L1423
	.word	.L1424
.L1424:
	cmp	r0, #1
	moveq	r0, #1
	movne	r0, #7
	ldmfd	sp, {fp, sp, pc}
.L1417:
	cmp	r0, #1
	moveq	r0, #0
	movne	r0, #6
	ldmfd	sp, {fp, sp, pc}
.L1419:
	cmp	r0, #1
	moveq	r0, #2
	movne	r0, #8
	ldmfd	sp, {fp, sp, pc}
.L1420:
	cmp	r0, #1
	moveq	r0, #4
	movne	r0, #10
	ldmfd	sp, {fp, sp, pc}
.L1421:
	cmp	r0, #1
	moveq	r0, #3
	movne	r0, #9
	ldmfd	sp, {fp, sp, pc}
.L1422:
	cmp	r0, #1
	moveq	r0, #5
	movne	r0, #11
	ldmfd	sp, {fp, sp, pc}
.L1423:
	cmp	r0, #1
	moveq	r0, #13
	movne	r0, #12
	ldmfd	sp, {fp, sp, pc}
.L1416:
	mov	r3, r1
	movw	r2, #9816
	ldr	r1, .L1433
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, #13
	ldmfd	sp, {fp, sp, pc}
.L1434:
	.align	2
.L1433:
	.word	.LC140
	.fnend
	.size	Get_YuvFormat, .-Get_YuvFormat
	.align	2
	.global	VDH_PutUsrdecFrame
	.type	VDH_PutUsrdecFrame, %function
VDH_PutUsrdecFrame:
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
	mov	r5, r1
	ldr	r1, [r1, #20]
	mov	r7, r0
	bl	FSP_GetLogicIdByPhyAddr
	cmn	r0, #1
	mov	r8, r0
	beq	.L1443
	ldr	r3, [r5, #4]
	cmp	r3, #1
	beq	.L1438
	mov	r1, r0
	mov	r2, #0
	mov	r0, r7
	bl	FSP_ClearLogicFs
	mov	r0, #0
.L1437:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1438:
	ldr	r0, [r5, #28]
	bl	MEM_Phy2Vir
	cmp	r0, #0
	beq	.L1444
.L1439:
	mov	r1, r8
	mov	r0, r7
	bl	FSP_GetFsImagePtr
	subs	r4, r0, #0
	beq	.L1445
	str	r8, [r4, #156]
	add	r3, r4, #560
	ldrd	r0, [r5, #48]
	add	r2, r4, #496
	str	r2, [fp, #-48]
	add	ip, r4, #576
	add	lr, r4, #592
	mov	r6, #0
	strd	r0, [r3]
	mov	r10, #1
	ldrd	r2, [r5, #48]
	strd	r2, [ip, #-8]
	ldrd	r2, [r5, #48]
	strd	r2, [ip]
	ldrd	r2, [r5, #48]
	strd	r2, [lr, #-8]
	str	r10, [r4, #8]
	str	r6, [r4, #12]
	str	r6, [r4, #16]
	str	r6, [r4, #20]
	ldr	r1, [r5, #20]
	str	r1, [r4, #28]
	mov	r0, r1
	str	r1, [r4, #60]
	str	r1, [r4, #44]
	ldr	r1, [r5, #28]
	str	r1, [r4, #32]
	str	r1, [r4, #64]
	str	r1, [r4, #48]
	bl	MEM_Phy2Vir
	ldr	r2, [fp, #-48]
	stmdb	r2, {r0, r6}
	str	r0, [r4, #472]
	str	r6, [r4, #476]
	ldr	r0, [r4, #32]
	bl	MEM_Phy2Vir
	ldr	r2, [fp, #-48]
	add	r1, r4, #512
	str	r0, [r4, #496]
	str	r6, [r2, #4]
	movw	r2, #11296
	str	r0, [r4, #480]
	str	r6, [r4, #484]
	ldr	r0, [r4, #28]
	ldr	r3, [r5, #24]
	ldr	lr, [r4, #32]
	add	r0, r3, r0
	str	r0, [r4, #36]
	ldr	r3, [r5, #24]
	str	r6, [r4, #96]
	add	r3, r3, lr
	str	r3, [r4, #40]
	ldr	r3, [r5, #12]
	str	r3, [r4, #112]
	ldr	r3, [r5, #16]
	str	r3, [r4, #116]
	ldr	r3, [r5, #12]
	str	r3, [r4, #120]
	mov	r0, r3, lsr r10
	ldr	r3, [r5, #16]
	str	r0, [r4, #128]
	str	r3, [r4, #124]
	mov	r3, r3, lsr r10
	str	r3, [r4, #132]
	ldr	r3, [r5, #24]
	str	r2, [r4, #108]
	mov	r2, #0
	str	r6, [r4, #136]
	str	r3, [r4, #140]
	mov	r3, #0
	str	r6, [r4, #160]
	str	r10, [r4, #172]
	str	r6, [r4, #220]
	strd	r2, [r1, #-8]
	ldr	r1, [r5]
	ldr	r0, [r5, #8]
	bl	Get_YuvFormat
	cmp	r0, #13
	beq	.L1446
	str	r0, [r4, #432]
	mov	r2, r10
	ldr	r3, [r5, #36]
	mov	r10, #20
	mov	r1, r8
	mov	r0, r7
	str	r3, [r4, #408]
	ldr	r3, [r5, #40]
	str	r3, [r4, #404]
	ldr	r3, [r5, #32]
	str	r10, [r4, #340]
	str	r3, [r4, #412]
	bl	FSP_SetDisplay
	ldr	r3, .L1447
	str	r4, [sp]
	mov	r1, r10
	mov	r0, r7
	ldr	r2, [r3, r7, asl #2]
	add	r2, r2, #237568
	add	r3, r2, #384
	add	r2, r2, #376
	bl	InsertImgToVoQueue
	cmp	r0, #1
	moveq	r0, r6
	beq	.L1437
	add	r10, r4, #528
	ldr	r1, [r4, #528]
	mov	r0, r7
	add	r5, r4, #544
	bl	FreeUsdByDec
	mov	r2, #0
	mov	r3, #0
	mov	r0, r7
	strd	r2, [r10]
	ldr	r1, [r4, #536]
	bl	FreeUsdByDec
	mov	r2, #0
	mov	r3, #0
	mov	r0, r7
	strd	r2, [r5, #-8]
	mov	r1, r8
	mov	r2, r6
	bl	FSP_SetDisplay
	mvn	r0, #0
	b	.L1437
.L1444:
	ldr	r3, [r5, #4]
	cmp	r3, #1
	bne	.L1439
	ldr	r2, [r5, #28]
	ldr	r1, .L1447+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1437
.L1443:
	ldr	r2, [r5, #20]
	mov	r0, #0
	ldr	r1, .L1447+8
	bl	dprint_vfmw
	mov	r0, r8
	b	.L1437
.L1446:
	mov	r2, r0
	ldr	r1, .L1447+12
	mov	r0, r10
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1437
.L1445:
	movw	r2, #5865
	ldr	r1, .L1447+16
	mov	r0, #22
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1437
.L1448:
	.align	2
.L1447:
	.word	.LANCHOR0
	.word	.LC142
	.word	.LC141
	.word	.LC144
	.word	.LC143
	.fnend
	.size	VDH_PutUsrdecFrame, .-VDH_PutUsrdecFrame
	.align	2
	.global	VCTRL_PutUsrdecFrame
	.type	VCTRL_PutUsrdecFrame, %function
VCTRL_PutUsrdecFrame:
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
	ldr	r3, .L1460
	mov	r4, r0
	mov	r5, r1
	ldr	r0, [r3, r0, asl #2]
	cmp	r0, #0
	beq	.L1457
	cmp	r1, #0
	beq	.L1458
	ldr	r2, [r0, #592]
	cmp	r2, #20
	bne	.L1459
	ldr	ip, .L1460+4
	mov	r2, #56
	add	r0, r0, #536
	ldr	r3, [ip, #52]
	blx	r3
	mov	r1, r5
	mov	r0, r4
	bl	VDH_PutUsrdecFrame
	cmp	r0, #0
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r1, .L1460+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1459:
	ldr	r1, .L1460+12
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1458:
	mov	r0, r1
	ldr	r3, .L1460+16
	movw	r2, #6076
	ldr	r1, .L1460+20
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1457:
	ldr	r3, .L1460+24
	movw	r2, #6075
	ldr	r1, .L1460+20
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1461:
	.align	2
.L1460:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC147
	.word	.LC146
	.word	.LC145
	.word	.LC1
	.word	.LC2
	.fnend
	.size	VCTRL_PutUsrdecFrame, .-VCTRL_PutUsrdecFrame
	.align	2
	.global	VCTRL_ResetHardware
	.type	VCTRL_ResetHardware, %function
VCTRL_ResetHardware:
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
	bl	SCDDRV_ResetSCD
	mov	r0, r4
	bl	VDMDRV_ResetVDH
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	VCTRL_ResetHardware, .-VCTRL_ResetHardware
	.align	2
	.global	VCTRL_OpenHardware
	.type	VCTRL_OpenHardware, %function
VCTRL_OpenHardware:
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
	bhi	.L1503
	ldr	r6, .L1511
	ldr	r0, [r6, r0, asl #2]
	cmp	r0, #0
	beq	.L1504
	ldr	r3, [r0, #12]
	cmp	r3, #1
	bne	.L1467
	ldr	r3, [r0, #592]
	cmp	r3, #21
	beq	.L1467
	bic	r7, r3, #16
	cmp	r7, #4
	cmpne	r3, #7
	moveq	r7, #1
	movne	r7, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	cmp	r3, #14
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	mov	r4, r7
.L1472:
	mov	r0, r4
	bl	VCTRL_IsChanActive
	cmp	r0, #0
	bne	.L1471
	ldr	r3, [r6, r4, asl #2]
	ldr	r3, [r3, #592]
	cmp	r3, #14
	cmpne	r3, #7
	bic	r3, r3, #16
	movne	r2, #1
	moveq	r2, #0
	cmp	r3, #4
	moveq	r3, #0
	andne	r3, r2, #1
	cmp	r3, #0
	addne	r7, r7, #1
.L1471:
	add	r4, r4, #1
	cmp	r4, #16
	bne	.L1472
	cmp	r7, #1
	beq	.L1505
.L1473:
	ldr	r1, .L1511+4
	mov	ip, #0
	add	lr, r1, #64
.L1481:
	ldr	r2, [r1, #4]!
	mov	r3, #0
	cmp	r2, r3
	beq	.L1479
	ldr	r0, [r2, #592]
	cmp	r0, r3
	ldreq	r2, [r2, #1216]
	subeq	r3, r2, #1
	clzeq	r3, r3
	moveq	r3, r3, lsr #5
	cmp	r0, #6
	orreq	r3, r3, #1
	cmp	r3, #0
	movne	ip, #1
.L1479:
	cmp	r1, lr
	bne	.L1481
	cmp	ip, #1
	beq	.L1506
.L1482:
	ldr	r3, [r6, r5, asl #2]
	ldr	r3, [r3, #592]
	cmp	r3, #1
	ldmnefd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	r3, .L1511+8
	ldrb	r3, [r3]
	cmp	r3, #1
	bne	.L1507
	ldr	r3, .L1511+12
	ldr	r3, [r3, #24]
	cmp	r3, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	mov	r0, #0
	blx	r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1467:
	movw	r2, #9862
	ldr	r1, .L1511+16
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1503:
	movw	r2, #9850
	ldr	r1, .L1511+20
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1507:
	mov	r1, #0
	mov	r0, #2
	bl	VDH_Need_Module
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1506:
	ldr	r3, .L1511+8
	ldrb	r3, [r3]
	cmp	r3, #1
	bne	.L1483
	ldr	r3, .L1511+12
	ldr	r3, [r3, #8]
	cmp	r3, #0
	beq	.L1508
	mov	r0, #0
	blx	r3
	b	.L1482
.L1505:
	ldr	r4, .L1511+8
	ldrb	r3, [r4]
	cmp	r3, #1
	bne	.L1474
	ldr	r3, .L1511+12
	ldr	r3, [r3]
	cmp	r3, #0
	beq	.L1509
	mov	r0, #0
	blx	r3
.L1476:
	ldrb	r3, [r4]
	cmp	r3, #1
	bne	.L1477
	ldr	r3, .L1511+12
	ldr	r3, [r3, #16]
	cmp	r3, #0
	beq	.L1510
	mov	r0, #0
	blx	r3
	b	.L1473
.L1504:
	mov	r2, #9856
	ldr	r1, .L1511+24
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1477:
	mov	r1, #0
	mov	r0, r1
	bl	VDH_Need_Module
	b	.L1473
.L1474:
	mov	r0, r7
	mov	r1, #0
	bl	VDH_Need_Module
	b	.L1476
.L1483:
	mov	r1, #0
	mov	r0, #3
	bl	VDH_Need_Module
	b	.L1482
.L1508:
	mov	r0, r3
	movw	r2, #9953
	ldr	r1, .L1511+28
	bl	dprint_vfmw
	b	.L1482
.L1510:
	mov	r0, r3
	movw	r2, #9918
	ldr	r1, .L1511+28
	bl	dprint_vfmw
	b	.L1473
.L1509:
	mov	r0, r3
	movw	r2, #9904
	ldr	r1, .L1511+28
	bl	dprint_vfmw
	b	.L1476
.L1512:
	.align	2
.L1511:
	.word	.LANCHOR0
	.word	.LANCHOR0-4
	.word	g_HalDisable
	.word	g_vdm_hal_fun_ptr
	.word	.LC150
	.word	.LC148
	.word	.LC149
	.word	.LC15
	.fnend
	.size	VCTRL_OpenHardware, .-VCTRL_OpenHardware
	.align	2
	.global	VCTRL_StartChan
	.type	VCTRL_StartChan, %function
VCTRL_StartChan:
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
	bhi	.L1524
	ldr	r4, .L1528
	ldr	r3, [r4, r0, asl #2]
	cmp	r3, #0
	beq	.L1525
	ldr	r6, [r3, #12]
	cmp	r6, #1
	bne	.L1526
	ldr	r3, [r3, #592]
	cmp	r3, #21
	beq	.L1527
	bl	SM_Start
	ldr	r3, [r4, r5, asl #2]
	mov	r2, #0
	str	r6, [r3, #16]
	ldr	r3, [r4, r5, asl #2]
	str	r6, [r3, #20]
	ldr	r3, [r4, r5, asl #2]
	str	r2, [r3, #32]
	ldr	r3, [r4, r5, asl #2]
	str	r6, [r3, #24]
	ldr	r2, [r4, r5, asl #2]
	ldr	r3, [r2, #28]
	cmp	r3, #0
	bne	.L1519
	ldr	r3, .L1528+4
	sub	ip, r4, #4
	ldr	r1, .L1528+8
	add	r0, r3, #64
	str	r6, [r2, #28]
.L1522:
	ldr	r2, [ip, #4]!
	add	r3, r3, #4
	add	r1, r1, #4
	cmp	r2, #0
	streq	r2, [r3, #-4]
	ldrne	lr, [r2, #28]
	strne	lr, [r3, #-4]
	ldrne	r2, [r2, #28]
	cmp	r3, r0
	str	r2, [r1, #-4]
	bne	.L1522
	ldr	r0, .L1528+4
	bl	VDMDRV_SetPriority
	mov	r0, r5
	bl	VDMDRV_ClearChanIsDec
.L1519:
	mov	r0, r5
	bl	VDMDRV_ClearChanIsDec
	mov	r0, r5
	bl	VCTRL_OpenHardware
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1526:
	ldr	r3, .L1528+12
	movw	r2, #2947
	ldr	r1, .L1528+16
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1524:
	ldr	r3, .L1528+20
	movw	r2, #2945
	ldr	r1, .L1528+16
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1527:
	ldr	r3, .L1528+24
	movw	r2, #2948
	ldr	r1, .L1528+16
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1525:
	mov	r0, r3
	movw	r2, #2946
	ldr	r3, .L1528+28
	ldr	r1, .L1528+16
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1529:
	.align	2
.L1528:
	.word	.LANCHOR0
	.word	.LANCHOR2+4056
	.word	g_ChanCtx
	.word	.LC64
	.word	.LC1
	.word	.LC20
	.word	.LC151
	.word	.LC27
	.fnend
	.size	VCTRL_StartChan, .-VCTRL_StartChan
	.align	2
	.global	VCTRL_CloseHardware
	.type	VCTRL_CloseHardware, %function
VCTRL_CloseHardware:
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
	ldr	ip, .L1583
	mov	r5, #0
	mov	r8, r0
	mov	r4, r5
	add	r6, ip, #64
	mov	r7, r5
	b	.L1536
.L1573:
	ldr	r1, [r3, #12]
	cmp	r1, #1
	beq	.L1571
.L1533:
	cmp	r2, #0
	ldreq	lr, [r3, #1216]
	movne	lr, #0
	cmp	r5, #0
	bne	.L1531
	cmp	r2, #6
	cmpne	lr, #1
	bne	.L1531
	ldr	r2, [r3, #12]
	cmp	r2, #1
	ldreq	r5, [r3, #16]
	subeq	r5, r5, #1
	clzeq	r5, r5
	moveq	r5, r5, lsr #5
.L1531:
	cmp	ip, r6
	beq	.L1572
.L1536:
	ldr	r3, [ip, #4]!
	cmp	r3, #0
	beq	.L1531
	cmp	r7, #0
	ldr	r2, [r3, #592]
	beq	.L1573
	cmp	r4, #0
	cmpeq	r2, #1
	bne	.L1533
	ldr	r1, [r3, #12]
	cmp	r1, #1
	bne	.L1533
	ldr	r1, [r3, #16]
.L1552:
	cmp	r1, #1
	moveq	r4, #1
	b	.L1533
.L1571:
	ldr	r1, [r3, #16]
	cmp	r1, #1
	beq	.L1574
.L1534:
	cmp	r4, #0
	cmpeq	r2, #1
	beq	.L1552
	b	.L1533
.L1572:
	cmp	r7, #0
	beq	.L1575
.L1537:
	cmp	r5, #0
	bne	.L1547
	ldr	r3, .L1583+4
	ldrb	r3, [r3]
	cmp	r3, #1
	beq	.L1576
	mov	r1, r5
	mov	r0, #3
	bl	VDH_UnNeed_Module
.L1547:
	cmp	r4, #0
	ldmnefd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1582:
	ldr	r3, .L1583+4
	ldrb	r3, [r3]
	cmp	r3, #1
	bne	.L1577
	ldr	r3, .L1583+8
	ldr	r3, [r3, #28]
	cmp	r3, #0
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	mov	r0, r4
	blx	r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1575:
	ldr	r6, .L1583+4
	ldrb	r3, [r6]
	cmp	r3, #1
	beq	.L1542
	mov	r0, r8
	bl	SCDDRV_ResetSCD
	mov	r0, r8
	bl	VDMDRV_ResetVDH
	ldrb	r3, [r6]
	cmp	r3, #1
	beq	.L1542
	mov	r1, r7
	mov	r0, #1
	bl	VDH_UnNeed_Module
.L1543:
	ldrb	r2, [r6]
	mov	r1, #0
	ldr	r3, .L1583+12
	cmp	r2, #1
	str	r1, [r3]
	bne	.L1544
	ldr	r3, .L1583+8
	ldr	r3, [r3, #20]
	cmp	r3, r1
	beq	.L1578
	mov	r0, r1
	blx	r3
.L1546:
	ldr	r3, .L1583+16
	mov	r2, #0
	str	r2, [r3, #84]
	b	.L1537
.L1574:
	sub	r0, r2, #5
	cmp	r0, #1
	cmphi	r2, #3
	bhi	.L1579
.L1554:
	mov	r7, r1
	b	.L1534
.L1579:
	sub	r0, r2, #8
	cmp	r0, #5
	bls	.L1554
	sub	r7, r2, #15
	cmp	r7, #2
	movhi	r7, #0
	movls	r7, #1
	b	.L1534
.L1577:
	mov	r1, r4
	mov	r0, #2
	bl	VDH_UnNeed_Module
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1542:
	ldr	r3, .L1583+8
	ldr	r3, [r3, #4]
	cmp	r3, #0
	beq	.L1580
	mov	r0, #0
	blx	r3
	b	.L1543
.L1576:
	ldr	r3, .L1583+8
	mov	r0, r5
	ldr	r3, [r3, #12]
	cmp	r3, #0
	beq	.L1581
	blx	r3
	cmp	r4, #0
	beq	.L1582
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1544:
	mov	r0, r1
	bl	VDH_UnNeed_Module
	b	.L1546
.L1581:
	movw	r2, #10096
	ldr	r1, .L1583+20
	bl	dprint_vfmw
	b	.L1547
.L1578:
	mov	r0, r3
	movw	r2, #10078
	ldr	r1, .L1583+20
	bl	dprint_vfmw
	b	.L1546
.L1580:
	mov	r0, r3
	movw	r2, #10062
	ldr	r1, .L1583+20
	bl	dprint_vfmw
	b	.L1543
.L1584:
	.align	2
.L1583:
	.word	.LANCHOR0-4
	.word	g_HalDisable
	.word	g_vdm_hal_fun_ptr
	.word	g_VdmDrvParam
	.word	g_ScdDrvParam
	.word	.LC15
	.fnend
	.size	VCTRL_CloseHardware, .-VCTRL_CloseHardware
	.align	2
	.global	VCTRL_StopChan
	.type	VCTRL_StopChan, %function
VCTRL_StopChan:
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
	mov	r4, r0
	bhi	.L1591
	ldr	r6, .L1593
	ldr	r3, [r6, r0, asl #2]
	cmp	r3, #0
	beq	.L1592
	ldr	r2, [r3, #12]
	cmp	r2, #1
	bne	.L1590
	str	r2, [r3, #32]
	mov	r3, #0
	ldr	r2, [r6, r0, asl #2]
	str	r3, [r2, #20]
	ldr	r2, [r6, r0, asl #2]
	str	r3, [r2, #16]
	bl	SM_Stop
	subs	r5, r0, #0
	bne	.L1590
	mov	r1, r5
	mov	r0, r4
	bl	DeleteRawPacketInBuffer
	mov	r0, r4
	bl	VDMDRV_ClearChanIsDec
	ldr	r3, [r6, r4, asl #2]
	mov	r0, r4
	str	r5, [r3, #32]
	bl	VCTRL_CloseHardware
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1590:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1591:
	ldr	r3, .L1593+4
	movw	r2, #3054
	ldr	r1, .L1593+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1592:
	mov	r0, r3
	movw	r2, #3055
	ldr	r3, .L1593+12
	ldr	r1, .L1593+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1594:
	.align	2
.L1593:
	.word	.LANCHOR0
	.word	.LC20
	.word	.LC1
	.word	.LC152
	.fnend
	.size	VCTRL_StopChan, .-VCTRL_StopChan
	.align	2
	.global	VCTRL_StopChanWithCheck
	.type	VCTRL_StopChanWithCheck, %function
VCTRL_StopChanWithCheck:
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
	ldr	r5, .L1602
	mov	r7, r0
	mov	r4, #0
	mov	r8, r5
	b	.L1597
.L1601:
	add	r4, r4, #1
	ldr	r3, [r8, #116]
	blx	r3
	cmp	r4, #50
	beq	.L1599
.L1597:
	ldr	r3, [r5, #12]
	mov	r0, #0
	blx	r3
	mov	r0, r7
	bl	VCTRL_StopChan
	ldr	r3, [r5, #16]
	mov	r6, r0
	mov	r0, #0
	blx	r3
	cmp	r6, #0
	mov	r0, #10
	bne	.L1601
	cmp	r4, #49
	bgt	.L1599
	mov	r0, r6
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1599:
	ldr	r1, .L1602+4
	mvn	r6, #0
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, r6
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1603:
	.align	2
.L1602:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC153
	.fnend
	.size	VCTRL_StopChanWithCheck, .-VCTRL_StopChanWithCheck
	.align	2
	.global	VCTRL_ResetChan
	.type	VCTRL_ResetChan, %function
VCTRL_ResetChan:
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
	ldr	r5, .L1631
	mov	r4, r0
	ldr	r3, [r5, r0, asl #2]
	cmp	r3, #0
	beq	.L1627
	ldr	r8, [r3, #16]
	bl	VCTRL_StopChan
	ldr	r7, .L1631+4
	mov	r6, #0
	ldr	r3, [r5, r4, asl #2]
	mov	r0, #4
	ldr	r2, [r7, #12]
	str	r6, [r3, #388]
	str	r6, [r3, #392]
	blx	r2
	ldr	r3, [r5, r4, asl #2]
	ldr	r2, [r3, #1424]
	cmp	r2, #1
	beq	.L1628
.L1607:
	ldr	r0, .L1631+8
	mov	r2, #300
	ldr	r3, [r7, #48]
	mov	r1, #0
	mla	r0, r2, r4, r0
	blx	r3
	ldr	r3, [r5, r4, asl #2]
	cmp	r3, #0
	addne	r3, r3, #233472
	movne	r2, #0
	strne	r2, [r3, #412]
	beq	.L1629
.L1609:
	mov	r2, #896
	mov	r1, #0
	ldr	r3, [r7, #48]
	mov	r6, #0
	ldr	r0, .L1631+12
	blx	r3
	ldr	r3, [r5, r4, asl #2]
	mov	r0, r4
	str	r6, [r3, #1204]
	bl	InitSyntaxCtx
	ldr	r0, [r5, r4, asl #2]
	mov	r1, r6
	ldr	r3, [r7, #48]
	mov	r2, #416
	add	r0, r0, #736
	blx	r3
	ldr	r1, [r5, r4, asl #2]
	mvn	r2, #0
	mvn	r3, #0
	add	r0, r1, #237568
	add	lr, r1, #656
	add	ip, r1, #672
	strd	r2, [lr]
	strd	r2, [ip, #-8]
	str	r6, [r1, #1152]
	str	r6, [r0, #352]
	str	r6, [r0, #344]
	str	r6, [r0, #348]
	ldr	r3, [r1, #1424]
	cmp	r3, #1
	streq	r6, [r1, #1464]
	streq	r6, [r0, #332]
	mov	r0, r4
	bl	FSP_SwitchNotify
	ldr	r3, [r5, r4, asl #2]
	mov	r0, r4
	ldr	r3, [r3, #592]
	cmp	r3, #20
	beq	.L1611
	bl	FSP_ResetInstance
.L1612:
	ldr	r3, [r7, #16]
	mov	r0, #4
	blx	r3
	mov	r0, r4
	bl	InitUsdPool
	mov	r0, r4
	bl	SM_Reset
	ldr	r3, .L1631+16
	ldr	r2, [r3, #-4064]
	cmp	r2, #0
	beq	.L1613
	add	r5, r3, r4, lsl #2
	str	r4, [fp, #-40]
	ldr	r3, [r5, #-4060]
	cmp	r3, #0
	beq	.L1615
	mov	r0, #512
	sub	r1, fp, #40
	bl	VCTRL_SetDbgOption
	ldr	r3, [r5, #-4060]
	cmp	r3, #0
	beq	.L1615
	sub	r1, fp, #40
	mov	r0, #512
	bl	VCTRL_SetDbgOption
.L1615:
	ldr	r1, .L1631+20
	mov	r0, #32
	bl	dprint_vfmw
.L1613:
	cmp	r8, #0
	bne	.L1630
.L1617:
	mov	r0, r4
	bl	VDMDRV_ClearChanIsDec
	mov	r0, #0
.L1606:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L1630:
	mov	r0, r4
	bl	VCTRL_StartChan
	b	.L1617
.L1611:
	bl	FSP_EmptyInstance
	b	.L1612
.L1628:
	add	r2, r3, #237568
	ldr	r1, [r3, #592]
	ldr	r2, [r2, #368]
	cmp	r2, r1
	bne	.L1607
	str	r6, [r3, #20]
	mov	r0, r4
	bl	VCTRL_FindOccupiedFrame
	b	.L1607
.L1629:
	bl	VCTRL_SetSendStreamAgainFlag.part.2
	b	.L1609
.L1627:
	mov	r0, r3
	movw	r2, #4478
	ldr	r3, .L1631+24
	ldr	r1, .L1631+28
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1606
.L1632:
	.align	2
.L1631:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR2-748
	.word	g_stLowdlyInfo
	.word	.LANCHOR4
	.word	.LC154
	.word	.LC2
	.word	.LC1
	.fnend
	.size	VCTRL_ResetChan, .-VCTRL_ResetChan
	.align	2
	.global	VCTRL_CreateChanWithOption
	.type	VCTRL_CreateChanWithOption, %function
VCTRL_CreateChanWithOption:
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
	ldr	r6, .L1713
	mov	r8, r0
	mov	r7, r1
	mov	r4, r2
	mov	r1, #0
	mov	r2, #24
	ldr	r3, [r6, #48]
	sub	r0, fp, #204
	blx	r3
	ldr	r3, [r6, #48]
	mov	r2, #24
	mov	r1, #0
	sub	r0, fp, #180
	ldr	r10, .L1713+4
	blx	r3
	ldr	r3, [r6, #48]
	mov	r2, #24
	mov	r1, #0
	sub	r0, fp, #156
	blx	r3
	ldr	r3, [r6, #48]
	mov	r2, #24
	mov	r1, #0
	sub	r0, fp, #132
	blx	r3
	ldr	r3, [r6, #48]
	sub	r0, fp, #84
	mov	r2, #40
	mov	r1, #0
	blx	r3
	subs	r3, r8, #25
	str	r7, [r10, #-3932]
	movne	r3, #1
	cmp	r4, #0
	movne	r3, #0
	cmp	r3, #0
	bne	.L1695
	ldr	r3, [r7, #36]
	cmp	r3, #0
	blt	.L1636
	ldr	r3, [r7, #12]
	cmp	r3, #31
	ble	.L1636
	ldr	r3, [r7, #16]
	cmp	r3, #31
	ble	.L1636
	ldr	r3, [r7, #56]
	cmp	r3, #262144
	blt	.L1636
	ldr	r3, [r7, #44]
	cmp	r3, #1
	beq	.L1696
	cmp	r3, #2
	beq	.L1697
.L1638:
	ldr	r3, [r7, #176]
	movw	ip, #17176
	movt	ip, 11
	mov	lr, #2448
	cmp	r3, #1
	sub	r2, fp, #220
	mov	r1, r7
	mov	r0, r8
	movhi	r3, #0
	strhi	r3, [r7, #176]
	cmp	r8, #26
	mov	r3, r4
	mov	r4, #1
	str	r4, [r7, #200]
	str	r4, [r7, #204]
	movt	lr, 177
	movne	lr, ip
	str	lr, [fp, #-224]
	bl	VCTRL_GetChanMemSizeWithOption
	subs	r9, r0, #0
	bne	.L1698
	ldrd	r2, [r7, #136]
	orrs	r3, r2, r3
	beq	.L1643
	ldr	r3, [r7, #144]
	cmp	r3, #0
	bne	.L1644
.L1643:
	ldr	r2, [fp, #-212]
	mov	r9, #1
	sub	r3, fp, #108
	str	r9, [sp]
	mov	r1, #0
	ldr	r0, .L1713+8
	mov	ip, #3
	str	ip, [fp, #-88]
	bl	MEM_AllocMemBlock
	subs	r4, r0, #0
	bne	.L1699
	ldr	r2, [fp, #-92]
	ldr	r1, [fp, #-104]
	ldr	r0, [fp, #-100]
	bl	MEM_AddMemRecord
	ldr	r1, [fp, #-100]
	ldr	r2, [fp, #-104]
	ldr	r3, [fp, #-92]
	str	r4, [fp, #-144]
	str	r1, [fp, #-156]
	str	r2, [fp, #-148]
	str	r3, [fp, #-140]
.L1646:
	ldrd	r2, [r7, #88]
	orrs	r3, r2, r3
	bne	.L1700
.L1648:
	ldr	r3, [r7, #176]
	cmp	r3, #1
	beq	.L1650
	mov	r3, #0
	ldr	r2, [fp, #-220]
	mov	r1, r3
	str	r3, [sp]
	ldr	r0, .L1713+12
	sub	r3, fp, #108
	mov	ip, #3
	str	ip, [fp, #-88]
	bl	MEM_AllocMemBlock
	subs	r4, r0, #0
	bne	.L1701
	ldr	r2, [fp, #-92]
	mov	r3, #1
	ldr	r1, [fp, #-104]
	ldr	r0, [fp, #-100]
	str	r3, [fp, #-228]
	bl	MEM_AddMemRecord
	ldr	r1, [fp, #-100]
	ldr	r2, [fp, #-104]
	ldr	r3, [fp, #-92]
	str	r4, [fp, #-192]
	str	r1, [fp, #-204]
	str	r2, [fp, #-196]
	str	r3, [fp, #-188]
.L1653:
	ldrd	r2, [r7, #112]
	orrs	r3, r2, r3
	beq	.L1657
	ldr	r3, [r7, #120]
	cmp	r3, #0
	bne	.L1658
.L1657:
	mov	r3, #0
	ldr	r2, [fp, #-216]
	mov	r1, r3
	str	r3, [sp]
	ldr	r0, .L1713+16
	sub	r3, fp, #108
	mov	ip, #3
	str	ip, [fp, #-88]
	bl	MEM_AllocMemBlock
	subs	r4, r0, #0
	bne	.L1702
	ldr	r2, [fp, #-92]
	mov	r3, #1
	ldr	r1, [fp, #-104]
	ldr	r0, [fp, #-100]
	str	r3, [fp, #-232]
	bl	MEM_AddMemRecord
	ldr	r1, [fp, #-100]
	ldr	r2, [fp, #-104]
	ldr	r3, [fp, #-92]
	str	r4, [fp, #-168]
	str	r1, [fp, #-180]
	str	r2, [fp, #-172]
	str	r3, [fp, #-164]
.L1662:
	ldr	r5, .L1713+20
	mov	r0, #0
	ldr	r3, [r6, #12]
	blx	r3
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L1676
	mov	r3, r5
	mov	r4, #1
.L1669:
	ldr	r2, [r3, #4]!
	cmp	r2, #0
	beq	.L1703
	add	r4, r4, #1
	cmp	r4, #16
	bne	.L1669
	mov	r2, r4
	ldr	r1, .L1713+24
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r6, #16]
	mov	r0, #0
	blx	r3
	mvn	r0, #0
.L1691:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1700:
	ldr	r3, [r7, #96]
	cmp	r3, #0
	beq	.L1648
	ldr	r3, [r6, #52]
	mov	r2, #24
	sub	r0, fp, #204
	add	r1, r7, #80
	blx	r3
	ldr	r3, [r7, #176]
	ldr	r2, [fp, #-188]
	cmp	r3, #1
	beq	.L1655
	ldr	r3, [fp, #-220]
	cmp	r2, r3
	blt	.L1704
.L1655:
	ldr	r1, [fp, #-196]
	mov	r3, #0
	ldr	r0, [fp, #-204]
	str	r3, [fp, #-228]
	bl	MEM_AddMemRecord
	b	.L1653
.L1650:
	mov	r3, #0
	mov	r0, #0
	mov	r1, #0
	str	r3, [fp, #-204]
	str	r3, [fp, #-228]
	str	r3, [fp, #-188]
	strd	r0, [fp, #-196]
	b	.L1653
.L1697:
	ldr	r3, [r7, #20]
	cmp	r3, #0
	ble	.L1636
	ldr	r3, [r7, #24]
	cmp	r3, #0
	ble	.L1636
.L1693:
	ldr	r3, [r7, #28]
	cmp	r3, #0
	ble	.L1636
	ldr	r3, [r7, #32]
	cmp	r3, #0
	bgt	.L1638
.L1636:
	ldr	r1, .L1713+28
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1703:
	uxtb	r3, r4
	str	r3, [fp, #-236]
.L1667:
	ldr	r3, [fp, #-224]
	mov	r1, #0
	ldr	r0, [fp, #-148]
	sub	r2, r3, #205824
	ldr	ip, [r6, #48]
	sub	r2, r2, #520
	str	r1, [fp, #-240]
	str	r0, [r5, r4, asl #2]
	blx	ip
	ldr	r0, [r5, r4, asl #2]
	ldr	ip, [r6, #52]
	mov	r2, #208
	mov	r1, r7
	add	r0, r0, #1248
	blx	ip
	ldr	r0, [r5, r4, asl #2]
	ldr	r3, [fp, #-224]
	mov	r1, r4, asl #6
	mov	r2, r4, asl #3
	str	r1, [fp, #-248]
	str	r8, [r0, #44]
	mov	ip, #21
	str	r3, [r0, #1176]
	str	r2, [fp, #-244]
	rsb	r2, r2, r1
	ldr	r3, [fp, #-240]
	ldr	r1, [r5, r4, asl #2]
	ldr	lr, .L1713+32
	str	r4, [r1, #8]
	add	r2, lr, r2
	str	r3, [r1, #1196]
	mov	lr, #30
	str	r8, [r1, #628]
	mov	r1, r4
	ldr	r8, [r7]
	ldr	r0, [r5, r4, asl #2]
	str	r8, [r0, #40]
	ldr	r0, [r5, r4, asl #2]
	add	r8, r0, #237568
	str	ip, [r0, #592]
	str	ip, [r8, #368]
	str	r3, [r0, #36]
	ldr	ip, [r5, r4, asl #2]
	add	r0, ip, #1504
	str	r0, [r2, #48]
	ldr	r8, [r7, #200]
	add	r2, ip, #205824
	ldr	r0, .L1713+36
	add	r2, r2, #488
	str	r8, [ip, #1604]
	ldr	r8, [r7, #204]
	str	r2, [r0, r4, asl #2]
	mov	r0, #1
	ldr	r2, [r6, #20]
	str	r8, [ip, #1608]
	mov	r8, r3
	str	lr, [ip, #1496]
	blx	r2
	mov	r0, r4
	bl	VCTRL_ResetChan
	ldr	r1, [r5, r4, asl #2]
	ldr	r3, [fp, #-228]
	add	r2, r1, #233472
	add	r0, r1, #237568
	str	r9, [r1, #304]
	str	r3, [r1, #296]
	ldr	r3, [fp, #-232]
	str	r3, [r1, #300]
	ldr	r3, [fp, #-240]
	str	r3, [r2, #388]
	str	r3, [r2, #392]
	str	r3, [r2, #400]
	str	r3, [r2, #404]
	str	r3, [r2, #396]
	str	r3, [r2, #408]
	ldr	r2, [r7, #176]
	str	r3, [r0, #332]
	str	r2, [r0, #336]
.L1671:
	mov	r9, r8, asl #6
	ldr	r0, [r5, r4, asl #2]
	add	r9, r9, r8, lsl #3
	mov	r2, #72
	add	r3, r9, #233472
	mov	r1, #0
	add	r3, r3, #416
	ldr	ip, [r6, #48]
	add	r0, r0, r3
	add	r8, r8, #1
	blx	ip
	ldr	r0, [r5, r4, asl #2]
	cmp	r8, #32
	mov	r1, #255
	add	r2, r0, r9
	ldr	r3, .L1713
	add	r2, r2, #233472
	ldr	r9, .L1713+20
	str	r1, [r2, #416]
	str	r1, [r2, #420]
	str	r1, [r2, #424]
	bne	.L1671
	add	r0, r0, #235520
	ldr	ip, [r3, #48]
	movw	r2, #1156
	mov	r1, #0
	add	r0, r0, #672
	str	r3, [fp, #-228]
	blx	ip
	ldr	r0, [r9, r4, asl #2]
	ldr	r3, [fp, #-228]
	mov	r2, #24
	add	r0, r0, #236544
	mov	r1, #0
	add	r0, r0, #804
	add	r10, r10, r4, lsl #2
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r3, [r9, r4, asl #2]
	ldr	r2, [fp, #-196]
	mov	ip, #0
	ldr	r1, [fp, #-172]
	add	r8, r3, #233472
	ldr	lr, [fp, #-156]
	ldr	r9, [fp, #-148]
	str	r2, [r3, #228]
	ldr	r0, [fp, #-204]
	str	r1, [r3, #252]
	ldr	r2, [fp, #-188]
	str	lr, [r3, #280]
	str	r9, [r3, #276]
	ldr	lr, [fp, #-180]
	ldr	r1, [fp, #-164]
	ldr	r9, [fp, #-140]
	str	r0, [r3, #232]
	str	r0, [r3, #332]
	str	r9, [r3, #288]
	str	r2, [r3, #240]
	str	r2, [r3, #336]
	str	lr, [r3, #256]
	str	r1, [r3, #264]
	str	ip, [r8, #368]
	ldr	r8, [r3, #1424]
	str	ip, [r10, #-3928]
	cmp	r8, #1
	beq	.L1672
	ldr	r8, [r3, #324]
	ldr	ip, [r3, #4]
	rsb	r2, r8, r2
	str	r1, [r3, #340]
	rsb	r2, ip, r2
	add	ip, r8, ip
	sub	r2, r2, #307200
	add	ip, ip, r0
	sub	r2, r2, #2576
	str	r2, [r3, #316]
	add	r1, r2, ip
	str	lr, [r3, #328]
	add	r0, r1, #14848
	add	r2, r1, #47616
	add	r0, r0, #15
	add	r2, r2, #15
	add	r1, r1, #15
	bic	r2, r2, #15
	bic	r1, r1, #15
	bic	r0, r0, #15
	str	r2, [r3, #360]
	mov	r2, #14848
	str	r1, [r3, #344]
	mov	r1, #32768
	str	r2, [r3, #348]
	mov	r2, #262144
	str	ip, [r3, #312]
	str	r0, [r3, #352]
	str	r1, [r3, #356]
	str	r2, [r3, #364]
.L1673:
	ldr	r3, [r5, r4, asl #2]
	mov	r0, r4
	ldr	r8, .L1713+20
	str	r4, [r3, #8]
	ldr	r3, [r5, r4, asl #2]
	add	r1, r3, #204800
	add	r2, r3, #188416
	str	r4, [r3, #212]
	str	r4, [r3, #216]
	ldrb	r3, [fp, #-236]
	strb	r3, [r1, #1512]
	str	r4, [r2, #3856]
	bl	FSP_EnableInstance
	subs	r9, r0, #0
	bne	.L1705
	mov	r0, r4
	mov	r5, #1
	bl	SM_ClearInst
	ldr	r3, [r8, r4, asl #2]
	ldr	r2, [fp, #-224]
	mov	r0, r4
	sub	r1, r2, #203776
	ldr	r3, [r3, #276]
	sub	r1, r1, #520
	add	r1, r3, r1
	bl	OpenUsdPool_WithMem
	ldr	r3, [r8, r4, asl #2]
	mov	r0, r4
	str	r5, [r3, #12]
	bl	VDMDRV_ClearChanIsDec
	bl	VDMDRV_ParamInit
	ldr	r3, [r6, #16]
	mov	r0, r9
	blx	r3
	str	r5, [r7, #48]
	mov	r0, r4
	bl	SM_AllocDSPCtxMem
	mov	r0, r4
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1696:
	ldr	r3, [r7, #20]
	cmp	r3, #0
	bgt	.L1693
	b	.L1636
.L1644:
	ldr	r3, [r6, #52]
	mov	r2, #24
	sub	r0, fp, #156
	add	r1, r7, #128
	blx	r3
	ldr	r2, [fp, #-140]
	ldr	r3, [fp, #-212]
	cmp	r2, r3
	blt	.L1706
	ldr	r1, [fp, #-148]
	ldr	r0, [fp, #-156]
	bl	MEM_AddMemRecord
	b	.L1646
.L1672:
	sub	r1, r1, #307200
	str	ip, [r3, #312]
	sub	r1, r1, #2576
	str	r1, [r3, #340]
	add	r2, r1, lr
	str	ip, [r3, #316]
	add	r0, r2, #14848
	add	r1, r2, #47616
	add	r0, r0, #15
	add	r1, r1, #15
	add	r2, r2, #15
	bic	r0, r0, #15
	bic	r1, r1, #15
	bic	r2, r2, #15
	str	r0, [r3, #352]
	mov	r0, #14848
	str	r1, [r3, #360]
	mov	r1, #32768
	str	r2, [r3, #344]
	mov	r2, #262144
	str	lr, [r3, #328]
	str	r0, [r3, #348]
	str	r1, [r3, #356]
	str	r2, [r3, #364]
	b	.L1673
.L1658:
	ldr	r3, [r6, #52]
	add	r1, r7, #104
	sub	r0, fp, #180
	mov	r2, #24
	blx	r3
	ldrd	r0, [fp, #-172]
	orrs	r3, r0, r1
	beq	.L1663
	ldr	r2, [fp, #-164]
	ldr	r3, [fp, #-216]
	cmp	r2, r3
	blt	.L1663
	mov	r1, r0
	ldr	r0, [fp, #-180]
	mov	r3, #0
	str	r3, [fp, #-232]
	bl	MEM_AddMemRecord
	b	.L1662
.L1702:
	cmp	r9, #1
	beq	.L1707
.L1660:
	ldr	r3, [fp, #-228]
	cmp	r3, #1
	beq	.L1708
.L1661:
	movw	r2, #2411
	ldr	r1, .L1713+40
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1691
.L1708:
	ldr	r1, [fp, #-196]
	ldr	r0, [fp, #-204]
	bl	MEM_ReleaseMemBlock
	ldr	r2, [fp, #-188]
	ldr	r1, [fp, #-196]
	ldr	r0, [fp, #-204]
	bl	MEM_DelMemRecord
	b	.L1661
.L1707:
	ldr	r1, [fp, #-148]
	ldr	r0, [fp, #-156]
	bl	MEM_ReleaseMemBlock
	ldr	r2, [fp, #-140]
	ldr	r1, [fp, #-148]
	ldr	r0, [fp, #-156]
	bl	MEM_DelMemRecord
	b	.L1660
.L1701:
	cmp	r9, #1
	beq	.L1709
.L1652:
	movw	r2, #2353
	ldr	r1, .L1713+44
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1691
.L1676:
	str	r3, [fp, #-236]
	mov	r4, r3
	b	.L1667
.L1699:
	mov	r0, r9
	movw	r2, #2315
	ldr	r1, .L1713+48
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1691
.L1705:
	ldr	r1, .L1713+52
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	bl	FSP_DisableInstance
	mov	r0, r4
	bl	CloseUsdPool_WithMem
	ldr	r3, [r8, r4, asl #2]
	ldr	r2, [fp, #-248]
	mov	r5, #0
	add	ip, r3, #237568
	ldr	r1, [fp, #-244]
	ldr	lr, [r3, #300]
	mov	r0, r4
	ldr	r7, [r3, #304]
	rsb	r1, r1, r2
	ldr	r10, [r3, #296]
	add	r2, r3, #233472
	ldr	r9, [ip, #336]
	add	r2, r2, #416
	ldr	ip, .L1713+32
	str	r2, [fp, #-68]
	add	r1, ip, r1
	str	lr, [fp, #-56]
	add	ip, r3, #224
	str	r1, [fp, #-72]
	str	ip, [fp, #-84]
	add	r1, r3, #248
	str	r9, [fp, #-64]
	add	r3, r3, #272
	str	r1, [fp, #-80]
	str	r3, [fp, #-76]
	str	r7, [fp, #-52]
	str	r10, [fp, #-60]
	str	r5, [r8, r4, asl #2]
	bl	VDMDRV_ClearChanIsDec
	ldr	r3, [r6, #16]
	mov	r0, r5
	blx	r3
	sub	r1, fp, #84
	mov	r0, r4
	bl	VCTRL_FreeChanResource
	mvn	r0, #0
	b	.L1691
.L1663:
	cmp	r9, #1
	beq	.L1710
.L1665:
	ldr	r3, [fp, #-228]
	cmp	r3, #1
	beq	.L1711
.L1666:
	movw	r2, #2440
	ldr	r1, .L1713+56
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1691
.L1695:
	ldr	r1, .L1713+60
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1691
.L1698:
	movw	r2, #2305
	ldr	r1, .L1713+64
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1691
.L1709:
	ldr	r1, [fp, #-148]
	ldr	r0, [fp, #-156]
	bl	MEM_ReleaseMemBlock
	ldr	r2, [fp, #-140]
	ldr	r1, [fp, #-148]
	ldr	r0, [fp, #-156]
	bl	MEM_DelMemRecord
	b	.L1652
.L1706:
	mov	r0, r4
	movw	r2, #2331
	ldr	r1, .L1713+68
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1691
.L1704:
	cmp	r9, #1
	beq	.L1712
.L1656:
	str	r3, [sp]
	mov	r0, #1
	mov	r3, r2
	ldr	r1, .L1713+72
	movw	r2, #2385
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1691
.L1711:
	ldr	r1, [fp, #-196]
	ldr	r0, [fp, #-204]
	bl	MEM_ReleaseMemBlock
	ldr	r2, [fp, #-188]
	ldr	r1, [fp, #-196]
	ldr	r0, [fp, #-204]
	bl	MEM_DelMemRecord
	b	.L1666
.L1710:
	ldr	r1, [fp, #-148]
	ldr	r0, [fp, #-156]
	bl	MEM_ReleaseMemBlock
	ldr	r2, [fp, #-140]
	ldr	r1, [fp, #-148]
	ldr	r0, [fp, #-156]
	bl	MEM_DelMemRecord
	b	.L1665
.L1712:
	ldr	r1, [fp, #-148]
	ldr	r0, [fp, #-156]
	bl	MEM_ReleaseMemBlock
	ldr	r2, [fp, #-140]
	ldr	r1, [fp, #-148]
	ldr	r0, [fp, #-156]
	bl	MEM_DelMemRecord
	ldr	r2, [fp, #-188]
	ldr	r3, [fp, #-220]
	b	.L1656
.L1714:
	.align	2
.L1713:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR4
	.word	.LC157
	.word	.LC160
	.word	.LC163
	.word	.LANCHOR0
	.word	.LC167
	.word	.LC77
	.word	s_SmIIS
	.word	s_pFspInst
	.word	.LC164
	.word	.LC161
	.word	.LC158
	.word	.LC166
	.word	.LC165
	.word	.LC155
	.word	.LC156
	.word	.LC159
	.word	.LC162
	.fnend
	.size	VCTRL_CreateChanWithOption, .-VCTRL_CreateChanWithOption
	.align	2
	.global	VCTRL_CreateChan
	.type	VCTRL_CreateChan, %function
VCTRL_CreateChan:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #296
	sub	sp, sp, #296
	push	{lr}
	bl	__gnu_mcount_nc
	cmp	r0, #32
	mov	r4, r0
	mov	r6, r1
	bhi	.L1739
	ldr	r5, .L1742
	mov	r2, #208
	mov	r1, #0
	sub	r0, fp, #244
	mov	r7, #136
	ldr	r3, [r5, #48]
	blx	r3
	ldr	r3, [r5, #48]
	mov	r2, #24
	mov	r1, #0
	sub	r0, fp, #292
	blx	r3
	ldr	r3, [r5, #48]
	mov	r2, #24
	mov	r1, #0
	sub	r0, fp, #268
	blx	r3
	ldr	r2, .L1742+4
	mov	r1, r4, asl #2
	mov	r0, r4, asl #5
	rsb	r3, r1, r0
	sub	ip, r4, #18
	add	r8, r2, r3
	mov	lr, #2
	ldr	r3, [r2, r3]
	ldr	r8, [r8, #4]
	str	lr, [fp, #-236]
	mov	lr, #32
	str	r3, [fp, #-232]
	mov	r3, #256
	str	r8, [fp, #-228]
	str	r7, [fp, #-224]
	str	lr, [fp, #-216]
	str	r3, [fp, #-212]
	cmp	ip, #7
	ldrls	pc, [pc, ip, asl #2]
	b	.L1718
.L1720:
	.word	.L1730
	.word	.L1730
	.word	.L1730
	.word	.L1730
	.word	.L1730
	.word	.L1721
	.word	.L1721
	.word	.L1721
.L1730:
	mov	lr, #5
	mov	ip, #3
.L1719:
	rsb	r3, r1, r0
	rsb	r0, r1, r0
	add	r3, r2, r3
	add	r2, r2, r0
	mov	r1, #0
	str	ip, [fp, #-184]
	ldr	r3, [r3, #12]
	ldr	r2, [r2, #24]
	cmp	r3, lr
	str	r1, [fp, #-180]
	rsbgt	r3, ip, r3
	str	r1, [fp, #-176]
	movle	r3, #1
	subgt	r3, r3, #2
	cmp	r4, #24
	str	r3, [fp, #-208]
	str	r2, [fp, #-188]
	mov	r3, #1
	streq	r1, [fp, #-208]
	str	r3, [fp, #-204]
	str	r3, [fp, #-200]
	str	r3, [fp, #-192]
	streq	r3, [fp, #-184]
	beq	.L1725
	cmp	r4, #26
	beq	.L1740
	cmp	r4, #18
	moveq	r2, #4
	moveq	r3, #2
	streq	r2, [fp, #-208]
	streq	r3, [fp, #-184]
.L1725:
	sub	r2, fp, #304
	sub	r1, fp, #316
	mov	r0, r4
	bl	VCTRL_GetChanMemSize
	cmp	r0, #0
	bne	.L1741
	cmp	r6, #0
	beq	.L1731
	ldr	r3, [r6, #16]
	cmp	r3, #0
	beq	.L1728
	ldr	r2, [r6]
	cmp	r2, #0
	beq	.L1729
	ldrd	r8, [r6, #8]
	orrs	r1, r8, r9
	beq	.L1729
	ldr	r1, [fp, #-316]
	ldr	r0, [fp, #-304]
	add	r1, r1, r0
	cmp	r3, r1
	blt	.L1729
	ldr	r0, [fp, #-300]
	sub	lr, fp, #260
	str	r2, [fp, #-268]
	mov	ip, #3
	add	r2, r0, r2
	str	r2, [fp, #-292]
	sub	r2, fp, #284
	strd	r8, [lr]
	adds	r8, r8, r0
	rsb	r3, r0, r3
	adc	r9, r9, r0, asr #31
	sub	r1, fp, #268
	strd	r8, [r2]
	mov	r2, #24
	str	r0, [fp, #-252]
	sub	r0, fp, #140
	str	r3, [fp, #-276]
	str	ip, [fp, #-236]
	ldr	r3, [r5, #52]
	blx	r3
	ldr	r3, [r5, #52]
	sub	r1, fp, #292
	mov	r2, #24
	sub	r0, fp, #164
	blx	r3
	mov	r3, #1
.L1728:
	sub	r1, fp, #244
	mov	r0, r4
	mov	r2, #1
	bl	VCTRL_CreateChanWithOption
	orr	r0, r0, r0, asr #31
.L1717:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1721:
	mov	lr, #3
	mov	ip, #1
	b	.L1719
.L1718:
	mov	lr, #8
	mov	ip, #6
	b	.L1719
.L1740:
	mov	r2, #16
	mov	r3, #6
	str	r2, [fp, #-208]
	str	r3, [fp, #-184]
	b	.L1725
.L1731:
	mov	r3, r6
	b	.L1728
.L1729:
	ldr	r1, .L1742+8
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r6, #16]
	ldrd	r4, [r6, #8]
	mov	r0, #1
	ldr	r2, [r6]
	ldr	r1, .L1742+12
	str	r3, [sp, #8]
	strd	r4, [sp]
	bl	dprint_vfmw
	ldr	r2, [fp, #-316]
	ldr	r3, [fp, #-304]
	mov	r0, #1
	ldr	r1, .L1742+16
	add	r2, r2, r3
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1717
.L1739:
	mov	r2, r0
	ldr	r1, .L1742+20
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1717
.L1741:
	ldr	r1, .L1742+24
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1717
.L1743:
	.align	2
.L1742:
	.word	vfmw_Osal_Func_Ptr_S
	.word	CapItem
	.word	.LC170
	.word	.LC171
	.word	.LC172
	.word	.LC168
	.word	.LC169
	.fnend
	.size	VCTRL_CreateChan, .-VCTRL_CreateChan
	.align	2
	.global	VCTRL_ConfigChan
	.type	VCTRL_ConfigChan, %function
VCTRL_ConfigChan:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #124
	sub	sp, sp, #124
	push	{lr}
	bl	__gnu_mcount_nc
	cmp	r0, #15
	mov	r7, #0
	mov	r5, r0
	mov	r4, r1
	str	r7, [fp, #-136]
	bhi	.L1828
	ldr	r6, .L1845
	ldr	r3, [r6, r0, asl #2]
	cmp	r3, #0
	beq	.L1829
	ldr	r9, [r3, #12]
	cmp	r9, #1
	bne	.L1830
	bl	VCTRL_CheckChanWH
	subs	r8, r0, #0
	bne	.L1831
	ldr	r7, .L1845+4
	ldr	r0, .L1845+8
	bl	GetVdecCapability
	ldr	r2, [r4]
	ldr	r3, [r7, #-3844]
	cmp	r3, #20
	bhi	.L1751
	cmp	r3, r2
	beq	.L1752
	ldr	r3, .L1845+12
	add	r0, r3, #124
.L1754:
	ldr	r1, [r3, #4]!
	cmp	r1, #20
	bhi	.L1751
	cmp	r1, r2
	beq	.L1752
	cmp	r3, r0
	bne	.L1754
.L1752:
	cmp	r2, #8
	beq	.L1832
.L1755:
	cmp	r2, #9
	beq	.L1757
.L1761:
	mov	r1, r4
	mov	r0, r5
	bl	VCTRL_CmpConfigParameter
	subs	r7, r0, #0
	beq	.L1833
	ldr	r3, [r4, #84]
	cmp	r3, #0
	bne	.L1762
	ldr	r3, [r4]
	sub	r2, r3, #10
	cmp	r2, #2
	bls	.L1834
	ldr	r10, [r6, r5, asl #2]
	cmp	r3, #14
	cmpne	r3, #4
	ldr	r1, .L1845
	moveq	r9, #1
	movne	r9, #0
	ldr	r3, [r10, #52]
	sub	r2, r3, #10
	cmp	r2, #2
	bhi	.L1766
	ldr	r2, [r1, #3772]
	tst	r2, #1
	eoreq	r9, r9, #1
	beq	.L1767
.L1766:
	cmp	r3, #14
	cmpne	r3, #4
	moveq	r3, #1
	movne	r3, #0
	eor	r9, r9, r3
	and	r9, r9, #1
.L1767:
	cmp	r9, #0
	ldr	r7, .L1845+16
	bne	.L1835
.L1768:
	ldr	r3, [r7, #52]
	mov	r2, #124
	mov	r1, r4
	add	r0, r10, #52
	blx	r3
	ldr	ip, [r4, #12]
	ldr	r3, [r6, r5, asl #2]
	mov	r2, #60
	mov	r1, #0
	sub	r0, fp, #108
	add	r9, r4, #4
	str	ip, [r3, #28]
	ldr	r3, [r6, r5, asl #2]
	ldr	lr, [r4]
	ldr	ip, [r7, #48]
	str	lr, [r3, #592]
	ldr	lr, [r4, #96]
	str	lr, [r3, #1432]
	blx	ip
	ldr	r3, [r6, r5, asl #2]
	ldr	r3, [r3, #328]
	mov	r0, r3
	str	r3, [fp, #-96]
	bl	MEM_Phy2Vir
	ldr	lr, [r6, r5, asl #2]
	ldr	r1, [r4, #84]
	mov	r2, #49152
	movt	r2, 63683
	ldr	r3, [r4]
	cmp	r1, #1
	ldr	ip, [r4, #12]
	str	r0, [fp, #-108]
	ldr	r0, [lr, #340]
	str	r2, [fp, #-88]
	ldreq	r2, [r4, #92]
	str	r0, [fp, #-92]
	ldreq	r0, [r4, #88]
	streq	r1, [fp, #-68]
	mov	r1, r9
	streq	r2, [fp, #-60]
	mov	r2, #8
	streq	r0, [fp, #-64]
	cmp	r3, #0
	ldr	r0, [r4, #80]
	ldreq	r8, [r4, #48]
	strb	ip, [fp, #-104]
	str	r3, [fp, #-100]
	str	r0, [fp, #-72]
	sub	r0, fp, #84
	ldr	r3, [r7, #52]
	str	r8, [fp, #-76]
	blx	r3
	sub	r1, fp, #108
	mov	r0, r5
	bl	SM_Config
	ldr	r3, [r7, #48]
	sub	r0, fp, #137
	mov	r2, #1
	mov	r1, #0
	blx	r3
	ldr	r3, [r4, #84]
	cmp	r3, #1
	beq	.L1836
.L1786:
	ldr	r3, [r6, r5, asl #2]
	mov	r1, r9
	mov	r8, #1
	mov	ip, #0
	add	r0, r3, #1152
	mov	r2, #8
	ldr	lr, [r3, #312]
	add	r0, r0, #4
	ldr	r10, [r3, #280]
	ldr	r9, [r3, #288]
	str	lr, [r3, #620]
	ldr	lr, [r3, #356]
	str	r10, [r3, #1180]
	str	r9, [r3, #1184]
	str	lr, [fp, #-144]
	ldr	lr, [r3, #316]
	ldr	r9, [r3, #352]
	ldr	r10, [r3, #348]
	str	lr, [r3, #624]
	ldr	lr, [r3, #344]
	str	r9, [r3, #640]
	str	r10, [r3, #636]
	str	lr, [r3, #632]
	ldr	lr, [fp, #-144]
	ldr	r9, .L1845
	str	lr, [r3, #644]
	ldr	lr, [r3, #360]
	str	lr, [r3, #648]
	ldr	lr, [r3, #364]
	str	lr, [r3, #652]
	ldr	lr, [r4, #16]
	str	lr, [r3, #604]
	ldr	lr, [r4, #16]
	str	lr, [r3, #600]
	ldr	lr, [r4, #24]
	str	lr, [r3, #608]
	ldr	lr, [r4, #28]
	str	lr, [r3, #612]
	ldr	lr, [r4, #32]
	str	lr, [r3, #616]
	ldr	lr, [r4, #52]
	ldr	r7, [r7, #52]
	str	lr, [r3, #1188]
	ldr	lr, [r4, #60]
	str	r8, [r3, #1220]
	str	r8, [r3, #1224]
	str	lr, [r3, #1192]
	ldr	lr, [r4, #72]
	rsb	lr, r8, lr
	clz	lr, lr
	mov	lr, lr, lsr #5
	str	lr, [r3, #1208]
	ldr	lr, [r4, #76]
	str	lr, [r3, #1212]
	ldr	lr, [r4, #48]
	str	ip, [r3, #1464]
	str	ip, [r3, #1484]
	str	lr, [r3, #1216]
	blx	r7
	ldr	ip, [r6, r5, asl #2]
	add	r3, ip, #237568
	ldr	r2, [ip, #592]
	ldr	r1, [r3, #368]
	cmp	r1, r2
	beq	.L1787
	mov	r0, r5
	bl	VCTRL_ResetChan
	ldr	r3, [r4]
	ldr	ip, [r9, r5, asl #2]
	cmp	r3, #20
	beq	.L1788
	ldr	r2, [ip, #592]
	add	r3, ip, #237568
.L1787:
	str	r2, [r3, #368]
	ldr	r3, [ip, #332]
	mov	r0, r3
	str	r3, [fp, #-132]
	bl	MEM_Phy2Vir
	ldr	r3, [r6, r5, asl #2]
	sub	r1, fp, #132
	mov	r2, #0
	str	r2, [fp, #-120]
	ldr	r3, [r3, #336]
	str	r3, [fp, #-116]
	str	r0, [fp, #-124]
	mov	r0, r5
	bl	RefreshDecCore
	subs	r7, r0, #0
	bne	.L1825
	ldr	r3, .L1845+20
	ldr	r0, .L1845+24
	ldr	r1, .L1845+28
	add	lr, r3, #64
.L1792:
	ldr	r2, [r0, #4]!
	add	r3, r3, #4
	add	r1, r1, #4
	cmp	r2, #0
	streq	r2, [r3, #-4]
	ldrne	ip, [r2, #28]
	strne	ip, [r3, #-4]
	ldrne	r2, [r2, #28]
	cmp	r3, lr
	str	r2, [r1, #-4]
	bne	.L1792
	ldr	r0, .L1845+20
	bl	VDMDRV_SetPriority
	mov	r0, r5
	bl	VDMDRV_ClearChanIsDec
	mov	r0, r7
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1751:
	ldr	r1, .L1845+32
	mov	r0, #0
	mvn	r7, #0
	bl	dprint_vfmw
.L1818:
	mov	r0, r7
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1834:
	ldr	r1, [r6, #3772]
	ldr	r2, .L1845
	tst	r1, #1
	bne	.L1837
	ldr	r10, [r2, r5, asl #2]
	ldr	r3, [r10, #52]
	sub	r2, r3, #10
	cmp	r2, #2
	bhi	.L1766
	ldr	r7, .L1845+16
	b	.L1768
.L1833:
	ldr	r1, .L1845+36
	bl	dprint_vfmw
	mov	r0, r7
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1757:
	sub	r0, fp, #136
	bl	REAL9DEC_Support
	ldr	r3, [fp, #-136]
	cmp	r3, #0
	bne	.L1761
.L1825:
	mvn	r7, #0
	b	.L1818
.L1832:
	sub	r0, fp, #136
	bl	REAL8DEC_Support
	ldr	r3, [fp, #-136]
	cmp	r3, #0
	ldrne	r2, [r4]
	bne	.L1755
	b	.L1825
.L1762:
	ldr	r10, [r6, r5, asl #2]
	ldr	r7, .L1845+16
	b	.L1768
.L1830:
	mov	r0, r7
	ldr	r3, .L1845+40
	movw	r2, #3303
	ldr	r1, .L1845+44
	bl	dprint_vfmw
	mvn	r7, #0
	b	.L1818
.L1835:
	add	r3, r10, #248
	mov	r0, #0
	str	r3, [fp, #-144]
	add	r9, r10, #224
	ldr	r3, [r7, #16]
	blx	r3
	ldr	r3, [r10, #264]
	cmp	r3, #0
	bne	.L1838
.L1769:
	ldr	r3, [r7, #160]
	ldr	r0, [r10, #228]
	blx	r3
	ldr	r3, [r4]
	sub	r2, r3, #10
	cmp	r2, #2
	bhi	.L1770
	ldr	r2, [r6, #3772]
	tst	r2, #1
	bne	.L1770
.L1771:
	mov	r0, r9
	ldr	r3, [r7, #164]
	blx	r3
	ldr	r3, .L1845+48
	ldr	ip, [r3, #-1016]
	cmp	ip, #0
	mov	r9, r0
	beq	.L1773
	mov	r2, #0
	str	r0, [fp, #-108]
	str	r2, [fp, #-104]
	mov	r3, #8
	sub	r2, fp, #108
	mov	r1, #127
	mov	r0, r5
	blx	ip
.L1773:
	ldr	r3, [r10, #264]
	mov	r2, #1
	strb	r2, [r10, #224]
	cmp	r3, #0
	bne	.L1839
.L1794:
	str	r3, [fp, #-144]
.L1774:
	ldr	r3, [r7, #12]
	mov	r0, #0
	blx	r3
	ldr	r0, [r6, r5, asl #2]
	cmp	r0, #0
	beq	.L1840
	cmp	r9, #0
	beq	.L1777
	ldr	r3, [fp, #-144]
	ldr	r2, [r10, #264]
	clz	r3, r3
	cmp	r2, #0
	mov	r3, r3, lsr #5
	moveq	r3, #0
	cmp	r3, #0
	bne	.L1777
	ldr	r2, [r10, #240]
	ldr	r1, [r10, #228]
	ldr	r0, [r10, #232]
	str	r3, [fp, #-148]
	bl	MEM_DelMemRecord
	subs	r3, r0, #0
	str	r3, [fp, #-152]
	ldr	r3, [fp, #-148]
	bne	.L1841
	str	r9, [r10, #228]
	mov	r1, r9
	ldr	r2, [r10, #240]
	ldr	r0, [r10, #232]
	bl	MEM_AddMemRecord
	subs	r9, r0, #0
	bne	.L1842
	ldr	r2, [r10, #264]
	cmp	r2, #0
	bne	.L1843
.L1823:
	ldr	r3, .L1845
	ldr	r10, [r3, r5, asl #2]
	b	.L1768
.L1770:
	cmp	r3, #14
	cmpne	r3, #4
	moveq	r1, #1
	movne	r1, #0
	beq	.L1771
	mov	r0, r9
	ldr	r3, [r7, #156]
	str	r1, [fp, #-148]
	blx	r3
	ldr	r3, [r10, #264]
	ldr	r1, [fp, #-148]
	cmp	r3, #0
	ldr	r2, .L1845+16
	strb	r1, [r10, #224]
	mov	r9, r0
	beq	.L1794
	ldr	r3, [r2, #156]
	ldr	r0, [fp, #-144]
	blx	r3
	ldr	r1, [fp, #-148]
	strb	r1, [r10, #248]
	str	r0, [fp, #-144]
	b	.L1774
.L1837:
	ldr	r10, [r2, r5, asl #2]
	cmp	r3, #14
	cmpne	r3, #4
	moveq	r9, #1
	movne	r9, #0
	ldr	r3, [r10, #52]
	b	.L1766
.L1836:
	sub	r1, fp, #137
	mov	r0, r5
	strb	r3, [fp, #-137]
	bl	FSP_ConfigAttribute
	b	.L1786
.L1839:
	ldr	r3, [r7, #164]
	ldr	r0, [fp, #-144]
	blx	r3
	ldr	r3, .L1845+48
	ldr	ip, [r3, #-1016]
	cmp	ip, #0
	str	r0, [fp, #-144]
	beq	.L1775
	mov	r2, #0
	str	r0, [fp, #-108]
	str	r2, [fp, #-104]
	mov	r3, #8
	sub	r2, fp, #108
	mov	r1, #126
	mov	r0, r5
	blx	ip
.L1775:
	mov	r3, #1
	strb	r3, [r10, #248]
	b	.L1774
.L1788:
	ldr	r3, [ip, #332]
	mov	r0, r5
	ldr	r2, [ip, #1264]
	ldr	r1, [ip, #1260]
	ldr	ip, [ip, #336]
	str	ip, [sp]
	bl	VCTRL_PartitionMemForStdUser
	cmp	r0, #0
	bne	.L1789
	ldr	ip, [r9, r5, asl #2]
	add	r3, ip, #237568
	ldr	r2, [ip, #592]
	b	.L1787
.L1831:
	mov	r0, r7
	ldr	r1, .L1845+52
	bl	dprint_vfmw
	mvn	r7, #0
	b	.L1818
.L1838:
	ldr	r3, [r7, #160]
	ldr	r0, [r10, #252]
	blx	r3
	b	.L1769
.L1843:
	ldr	r1, [r10, #252]
	ldr	r0, [r10, #256]
	bl	MEM_DelMemRecord
	subs	r3, r0, #0
	str	r3, [fp, #-148]
	bne	.L1844
	ldr	r3, [fp, #-144]
	ldr	r2, [r10, #264]
	ldr	r0, [r10, #256]
	str	r3, [r10, #252]
	mov	r1, r3
	bl	MEM_AddMemRecord
	cmp	r0, #0
	beq	.L1823
	ldr	r3, [r10, #264]
	mvn	r7, #0
	ldr	r0, [fp, #-148]
	ldr	r1, .L1845+56
	str	r3, [sp]
	ldr	r3, [r10, #252]
	ldr	r2, [r10, #256]
	bl	dprint_vfmw
	b	.L1818
.L1828:
	mov	r0, r7
	ldr	r3, .L1845+60
	movw	r2, #3301
	ldr	r1, .L1845+44
	bl	dprint_vfmw
	mvn	r7, #0
	b	.L1818
.L1841:
	ldr	r1, [r10, #228]
	mov	r0, r3
	ldr	ip, [r10, #240]
	mvn	r7, #0
	ldr	r2, [r10, #232]
	mov	r3, r1
	ldr	r1, .L1845+56
	str	ip, [sp]
	bl	dprint_vfmw
	b	.L1818
.L1829:
	mov	r0, r3
	movw	r2, #3302
	ldr	r3, .L1845+64
	mvn	r7, #0
	ldr	r1, .L1845+44
	bl	dprint_vfmw
	b	.L1818
.L1789:
	mov	r0, r8
	ldr	r1, .L1845+68
	bl	dprint_vfmw
	b	.L1825
.L1844:
	ldr	r1, [r10, #252]
	mov	r0, r9
	ldr	ip, [r10, #264]
	mvn	r7, #0
	ldr	r2, [r10, #256]
	mov	r3, r1
	ldr	r1, .L1845+56
	str	ip, [sp]
	bl	dprint_vfmw
	b	.L1818
.L1842:
	ldr	ip, [r10, #240]
	mvn	r7, #0
	ldr	r3, [r10, #228]
	ldr	r2, [r10, #232]
	ldr	r0, [fp, #-152]
	ldr	r1, .L1845+56
	str	ip, [sp]
	bl	dprint_vfmw
	b	.L1818
.L1777:
	mov	r2, r5
	ldr	r1, .L1845+72
	mov	r0, #0
	mvn	r7, #0
	bl	dprint_vfmw
	b	.L1818
.L1840:
	movw	r3, #3426
	ldr	r2, .L1845+76
	ldr	r1, .L1845+80
	mvn	r7, #0
	bl	dprint_vfmw
	b	.L1818
.L1846:
	.align	2
.L1845:
	.word	.LANCHOR0
	.word	.LANCHOR4
	.word	.LANCHOR4-3864
	.word	.LANCHOR4-3844
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR4-3716
	.word	.LANCHOR0-4
	.word	g_ChanCtx
	.word	.LC174
	.word	.LC175
	.word	.LC21
	.word	.LC1
	.word	.LANCHOR2
	.word	.LC173
	.word	.LC178
	.word	.LC20
	.word	.LC2
	.word	.LC179
	.word	.LC177
	.word	.LANCHOR1+332
	.word	.LC176
	.fnend
	.size	VCTRL_ConfigChan, .-VCTRL_ConfigChan
	.align	2
	.global	VCTRL_SetDbgOption
	.type	VCTRL_SetDbgOption, %function
VCTRL_SetDbgOption:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #140
	sub	sp, sp, #140
	push	{lr}
	bl	__gnu_mcount_nc
	cmp	r1, #0
	beq	.L1940
	cmp	r0, #544
	ldr	r4, [r1]
	beq	.L1849
	bls	.L1963
	cmp	r0, #1280
	beq	.L1872
	bhi	.L1873
	movw	r3, #897
	cmp	r0, r3
	beq	.L1874
	bls	.L1964
	cmp	r0, #1024
	beq	.L1881
	bhi	.L1882
	movw	r3, #898
	cmp	r0, r3
	beq	.L1958
	movw	r3, #899
	cmp	r0, r3
	bne	.L1940
	mov	r0, r4
	bl	VCTRL_StopChan
	mov	r2, r4
	ldr	r1, .L1979
	mov	r3, r0
	mov	r0, #32
	bl	dprint_vfmw
	mov	r0, r4
	bl	VCTRL_ResetChan
	mov	r2, r4
	ldr	r1, .L1979+4
	mov	r3, r0
	mov	r0, #32
	bl	dprint_vfmw
.L1958:
	mov	r0, r4
	bl	VCTRL_StartChan
	mov	r2, r4
	ldr	r1, .L1979+8
	mov	r3, r0
	mov	r0, #32
	bl	dprint_vfmw
.L1961:
	mov	r0, #1
.L1848:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1873:
	movw	r3, #1537
	cmp	r0, r3
	beq	.L1887
	bls	.L1965
	movw	r3, #1540
	cmp	r0, r3
	beq	.L1893
	bhi	.L1894
	movw	r3, #1538
	cmp	r0, r3
	beq	.L1895
	movw	r3, #1539
	cmp	r0, r3
	bne	.L1940
	mov	r2, r4, asl #6
	ldr	r3, .L1979+12
	sub	r4, r2, r4, asl #3
	mov	r2, #1
	add	r4, r3, r4
	mov	r0, r2
	ldr	r3, [r4, #48]
	str	r2, [r3, #80]
	b	.L1848
.L1963:
	cmp	r0, #11
	beq	.L1851
	bls	.L1966
	cmp	r0, #512
	beq	.L1860
	bls	.L1967
	movw	r3, #515
	cmp	r0, r3
	beq	.L1866
	cmp	r0, #516
	bcs	.L1867
	movw	r3, #513
	cmp	r0, r3
	beq	.L1868
	movw	r3, #514
	cmp	r0, r3
	bne	.L1940
	cmp	r4, #15
	bhi	.L1961
	ldr	r5, .L1979+16
	add	r6, r5, r4, lsl #2
	ldr	r7, [r6, #-3504]
	cmp	r7, #0
	beq	.L1968
	ldr	r7, .L1979+20
	mov	r0, #32
	ldr	r1, .L1979+24
	mov	r4, #0
	bl	dprint_vfmw
	ldr	r0, [r6, #-3504]
	ldr	r3, [r7, #36]
	blx	r3
	ldr	r0, [r5, #-3364]
	ldr	r3, .L1979+28
	mvn	r2, #0
	cmp	r0, r4
	str	r4, [r6, #-3504]
	str	r4, [r5, #-3348]
	str	r2, [r3, #68]
	str	r4, [r5, #-3344]
	str	r4, [r5, #-3340]
	str	r4, [r5, #-3336]
	beq	.L1961
	ldr	r1, [r5, #-3368]
	bl	MEM_ReleaseMemBlock
	ldr	r2, [r5, #-3356]
	ldr	r1, [r5, #-3368]
	ldr	r0, [r5, #-3364]
	bl	MEM_DelMemRecord
	ldr	r3, [r7, #48]
	mov	r1, r4
	mov	r2, #24
	ldr	r0, .L1979+32
	blx	r3
	b	.L1961
.L1967:
	cmp	r0, #13
	beq	.L1862
	bcc	.L1863
	cmp	r0, #256
	beq	.L1864
	movw	r3, #257
	cmp	r0, r3
	bne	.L1940
	ldr	r5, .L1979+36
	mov	r0, r4
	mov	r1, #1
	mov	r3, #67108864
	ldr	r4, [r5]
	str	r3, [r5]
	bl	PrintScdRawState
	mov	r0, #1
	str	r4, [r5]
	b	.L1848
.L1964:
	cmp	r0, #768
	beq	.L1876
	bls	.L1969
	movw	r3, #769
	cmp	r0, r3
	beq	.L1879
	cmp	r0, #896
	bne	.L1940
	mov	r0, r4
	bl	VCTRL_StopChan
	mov	r2, r4
	ldr	r1, .L1979
	mov	r3, r0
	mov	r0, #32
	bl	dprint_vfmw
	mov	r0, #1
	b	.L1848
.L1965:
	movw	r3, #1282
	cmp	r0, r3
	beq	.L1889
	bcc	.L1890
	movw	r3, #1283
	cmp	r0, r3
	beq	.L1891
	cmp	r0, #1536
	bne	.L1940
	cmp	r4, #15
	bhi	.L1937
	ldr	r3, .L1979+40
	mov	r5, #1
	mov	r2, r4
	ldr	r1, .L1979+44
	mov	r0, #32
	ldr	r3, [r3, r4, asl #2]
	str	r5, [r3, #1212]
	bl	dprint_vfmw
	mov	r0, r5
	b	.L1848
.L1966:
	cmp	r0, #4
	beq	.L1853
	bhi	.L1854
	cmp	r0, #1
	beq	.L1961
	bcc	.L1856
	cmp	r0, #2
	bne	.L1970
	mov	r5, r4, lsr #24
	bic	r4, r4, #-16777216
	ldr	r1, .L1979+48
	mov	r0, #32
	mov	r3, r4
	mov	r2, r5
	bl	dprint_vfmw
	ldr	r3, .L1979+20
	mov	r2, #124
	mov	r1, #0
	sub	r0, fp, #168
	ldr	r3, [r3, #48]
	blx	r3
	sub	r1, fp, #168
	mov	r0, r5
	bl	VCTRL_GetChanCfg
	cmp	r0, #0
	bne	.L1961
	sub	r1, fp, #168
	mov	r0, r5
	str	r4, [fp, #-152]
	bl	VCTRL_ConfigChan
	b	.L1961
.L1854:
	cmp	r0, #6
	beq	.L1961
	bcc	.L1858
	cmp	r0, #7
	bne	.L1971
	mov	r5, r4, lsr #24
	bic	r4, r4, #-16777216
	ldr	r1, .L1979+52
	mov	r0, #32
	mov	r3, r4
	mov	r2, r5
	bl	dprint_vfmw
	ldr	r3, .L1979+20
	mov	r2, #124
	mov	r1, #0
	sub	r0, fp, #168
	ldr	r3, [r3, #48]
	blx	r3
	sub	r1, fp, #168
	mov	r0, r5
	bl	VCTRL_GetChanCfg
	cmp	r0, #0
	bne	.L1961
	sub	r1, fp, #168
	mov	r0, r5
	str	r4, [fp, #-148]
	bl	VCTRL_ConfigChan
	b	.L1961
.L1882:
	movw	r3, #1025
	cmp	r0, r3
	beq	.L1885
	movw	r3, #1026
	cmp	r0, r3
	bne	.L1940
	ldr	r3, .L1979+56
	mov	r2, r4
	ldr	r1, .L1979+60
	mov	r0, #32
	str	r4, [r3, #-752]
	bl	dprint_vfmw
	mov	r0, #1
	b	.L1848
.L1867:
	beq	.L1870
	cmp	r0, #528
	bne	.L1940
	cmp	r4, #15
	bhi	.L1961
	ldr	r6, .L1979+16
	add	r5, r6, r4, lsl #2
	ldr	r7, [r5, #-3332]
	cmp	r7, #0
	beq	.L1972
	ldr	r1, .L1979+64
	mov	r0, #32
	bl	dprint_vfmw
	ldr	r3, .L1979+20
	ldr	r0, [r5, #-3332]
	ldr	r3, [r3, #36]
	blx	r3
	mov	r3, #0
	mov	r0, #1
	str	r3, [r5, #-3332]
	b	.L1848
.L1894:
	movw	r3, #1541
	cmp	r0, r3
	beq	.L1897
	cmp	r0, #1792
	bne	.L1940
	cmp	r4, #0
	bne	.L1961
	ldr	r5, .L1979+28
	ldr	r6, [r5, #72]
	cmp	r6, #1
	beq	.L1973
	ldr	r1, .L1979+68
	mov	r0, #32
	bl	dprint_vfmw
	mov	r3, #1
	mov	r0, r3
	str	r3, [r5, #72]
	b	.L1848
.L1895:
	ldr	r3, .L1979+72
	mov	r2, r4
	ldr	r1, .L1979+44
	mov	r0, #32
	str	r4, [r3]
	bl	dprint_vfmw
	mov	r0, #1
	b	.L1848
.L1868:
	cmp	r4, #15
	bhi	.L1961
	ldr	r6, .L1979+16
	add	r5, r6, r4, lsl #2
	ldr	r7, [r5, #-3640]
	cmp	r7, #0
	beq	.L1974
	ldr	r1, .L1979+76
	mov	r0, #32
	bl	dprint_vfmw
	ldr	r3, .L1979+20
	ldr	r0, [r5, #-3640]
	ldr	r3, [r3, #36]
	blx	r3
	mov	r3, #0
	mov	r0, #1
	str	r3, [r5, #-3640]
	b	.L1848
.L1891:
	ldr	r3, .L1979+80
	mov	r2, r4
	ldr	r1, .L1979+84
	mov	r0, #32
	str	r4, [r3]
	bl	dprint_vfmw
	mov	r0, #1
	b	.L1848
.L1864:
	ldr	r1, .L1979+88
	mov	r0, #32
	bl	dprint_vfmw
	mov	r0, r4
	bl	DBG_PrintTracer
	mov	r0, #1
	b	.L1848
.L1879:
	bl	VCTRL_Resume
	mov	r0, #1
	b	.L1848
.L1885:
	ldr	r3, .L1979+16
	mov	r2, r4
	ldr	r1, .L1979+92
	mov	r0, #32
	str	r4, [r3, #-2924]
	bl	dprint_vfmw
	mov	r0, #1
	b	.L1848
.L1856:
	ldr	r3, .L1979+36
	mov	r0, #1
	str	r4, [r3]
	b	.L1848
.L1897:
	ldr	r3, .L1979+16
	mov	r2, r4
	ldr	r1, .L1979+96
	mov	r0, #32
	str	r4, [r3, #-2920]
	bl	dprint_vfmw
	b	.L1961
.L1870:
	ldr	r5, .L1979+20
	mov	r0, r4
	ldmib	r1, {r8, r9}
	ldr	r3, [r5, #184]
	blx	r3
	subs	r7, r0, #0
	beq	.L1962
	sub	r6, fp, #168
	str	r4, [sp]
	mov	r1, #50
	ldr	ip, [r5, #68]
	ldr	r3, .L1979+100
	mov	r0, r6
	ldr	r2, .L1979+104
	blx	ip
	mov	r0, r6
	ldr	r3, [r5, #32]
	mov	r2, #0
	mov	r1, #66
	blx	r3
	subs	r4, r0, #0
	beq	.L1924
	ldr	r3, .L1979+108
	ldr	ip, [r3, #140]
	cmp	ip, #0
	beq	.L1925
	mov	lr, #1
	mov	r3, r9
	mov	r2, r8
	mov	r1, r7
	str	lr, [sp]
	blx	ip
.L1926:
	mov	r0, r4
	ldr	r3, [r5, #36]
	blx	r3
	mov	r2, r6
	ldr	r1, .L1979+112
	mov	r0, #32
	bl	dprint_vfmw
.L1923:
	mov	r0, r7
	ldr	r3, [r5, #152]
	blx	r3
	mov	r0, #1
	b	.L1848
.L1858:
	mov	r5, r4, lsr #24
	and	r4, r4, #7
	ldr	r1, .L1979+116
	mov	r0, #32
	mov	r3, r4
	mov	r2, r5
	bl	dprint_vfmw
	ldr	r3, .L1979+20
	sub	r6, fp, #168
	mov	r2, #124
	mov	r1, #0
	ldr	r3, [r3, #48]
	mov	r0, r6
	blx	r3
	mov	r1, r6
	mov	r0, r5
	bl	VCTRL_GetChanCfg
	cmp	r0, #0
	bne	.L1901
	mov	r1, r6
	mov	r0, r5
	str	r4, [fp, #-144]
	bl	VCTRL_ConfigChan
	b	.L1961
.L1970:
	cmp	r0, #3
	beq	.L1961
.L1940:
	mvn	r0, #1
	b	.L1848
.L1969:
	cmp	r0, #560
	bne	.L1940
	cmp	r4, #15
	bhi	.L1961
	ldr	r6, .L1979+16
	add	r5, r6, r4, lsl #2
	ldr	r7, [r5, #-3060]
	cmp	r7, #0
	beq	.L1975
	ldr	r1, .L1979+120
	mov	r0, #32
	bl	dprint_vfmw
	ldr	r3, .L1979+20
	ldr	r0, [r5, #-3060]
	ldr	r3, [r3, #36]
	blx	r3
	mov	r3, #0
	mov	r0, #1
	str	r3, [r5, #-3060]
	b	.L1848
.L1881:
	ldr	r3, .L1979+56
	mov	r2, r4
	ldr	r1, .L1979+124
	mov	r0, #32
	str	r4, [r3, #-756]
	bl	dprint_vfmw
	mov	r0, #1
	b	.L1848
.L1887:
	cmp	r4, #15
	bhi	.L1937
	ldr	r3, .L1979+40
	mov	ip, #0
	mov	r2, r4
	ldr	r1, .L1979+44
	mov	r0, #32
	ldr	r3, [r3, r4, asl #2]
	str	ip, [r3, #1212]
	bl	dprint_vfmw
	mov	r0, #1
	b	.L1848
.L1876:
	bl	VCTRL_Suspend
	mov	r0, #1
	b	.L1848
.L1866:
	ldr	r5, .L1979+20
	mov	r0, r4
	ldr	r3, [r5, #184]
	blx	r3
	subs	r7, r0, #0
	beq	.L1962
	sub	r6, fp, #168
	str	r4, [sp]
	mov	r1, #50
	ldr	ip, [r5, #68]
	ldr	r3, .L1979+100
	mov	r0, r6
	ldr	r2, .L1979+128
	blx	ip
	mov	r0, r6
	ldr	r3, [r5, #32]
	mov	r2, #0
	mov	r1, #66
	blx	r3
	subs	r4, r0, #0
	beq	.L1924
	mov	r2, r4
	ldr	r3, [r5, #44]
	mov	r1, #3145728
	mov	r0, r7
	blx	r3
	mov	r0, r4
	ldr	r3, [r5, #36]
	blx	r3
	mov	r2, r6
	ldr	r1, .L1979+132
	mov	r0, #32
	bl	dprint_vfmw
	b	.L1923
.L1937:
	ldr	r1, .L1979+136
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #1
	b	.L1848
.L1853:
	mov	r5, r4, lsr #24
	and	r4, r4, #3
	ldr	r1, .L1979+140
	mov	r0, #32
	mov	r3, r4
	mov	r2, r5
	bl	dprint_vfmw
	ldr	r3, .L1979+20
	mov	r2, #124
	mov	r1, #0
	sub	r0, fp, #168
	ldr	r3, [r3, #48]
	blx	r3
	sub	r1, fp, #168
	mov	r0, r5
	bl	VCTRL_GetChanCfg
	cmp	r0, #0
	bne	.L1961
	sub	r1, fp, #168
	mov	r0, r5
	str	r4, [fp, #-140]
	bl	VCTRL_ConfigChan
	b	.L1961
.L1893:
	mov	r2, r4, asl #6
	ldr	r3, .L1979+12
	sub	r4, r2, r4, asl #3
	mov	r0, #1
	add	r4, r3, r4
	mov	r2, #0
	ldr	r3, [r4, #48]
	str	r2, [r3, #80]
	b	.L1848
.L1890:
	ldr	r3, .L1979+144
	mov	r2, r4
	ldr	r1, .L1979+148
	mov	r0, #32
	str	r4, [r3]
	bl	dprint_vfmw
	mov	r0, #1
	b	.L1848
.L1889:
	ldr	r3, .L1979+152
	mov	r2, r4
	ldr	r1, .L1979+156
	mov	r0, #32
	str	r4, [r3]
	bl	dprint_vfmw
	mov	r0, #1
	b	.L1848
.L1874:
	mov	r0, r4
	bl	VCTRL_ResetChan
	mov	r2, r4
	ldr	r1, .L1979+4
	mov	r3, r0
	mov	r0, #32
	bl	dprint_vfmw
	mov	r0, #1
	b	.L1848
.L1851:
	cmp	r4, #1
	ldrls	r3, .L1979+160
	movls	r2, r4
	ldrls	r1, .L1979+164
	movls	r0, #32
	movhi	r2, r4
	ldrhi	r1, .L1979+168
	strls	r4, [r3]
	movhi	r0, #32
	bl	dprint_vfmw
	mov	r0, #1
	b	.L1848
.L1860:
	cmp	r4, #15
	bhi	.L1961
	ldr	r6, .L1979+16
	add	r5, r6, r4, lsl #2
	ldr	r7, [r5, #-4060]
	cmp	r7, #0
	beq	.L1976
	ldr	r1, .L1979+172
	mov	r0, #32
	bl	dprint_vfmw
	ldr	r3, .L1979+20
	ldr	r0, [r5, #-4060]
	ldr	r3, [r3, #36]
	blx	r3
	mov	r3, #0
	mov	r0, #1
	str	r3, [r5, #-4060]
	b	.L1848
.L1872:
	ldr	r3, .L1979+176
	mov	r2, r4
	ldr	r1, .L1979+180
	mov	r0, #32
	str	r4, [r3]
	bl	dprint_vfmw
	mov	r0, #1
	b	.L1848
.L1863:
	cmp	r4, #1
	bls	.L1977
	mov	r2, r4
	ldr	r1, .L1979+184
	mov	r0, #32
	bl	dprint_vfmw
	mov	r0, #1
	b	.L1848
.L1862:
	cmp	r4, #16
	bls	.L1906
	mov	r2, r4
	ldr	r1, .L1979+188
	mov	r0, #32
	bl	dprint_vfmw
	b	.L1961
.L1849:
	cmp	r4, #15
	bhi	.L1961
	ldr	r6, .L1979+16
	add	r5, r6, r4, lsl #2
	ldr	r7, [r5, #-3196]
	cmp	r7, #0
	beq	.L1978
	ldr	r1, .L1979+64
	mov	r0, #32
	bl	dprint_vfmw
	ldr	r3, .L1979+20
	ldr	r0, [r5, #-3196]
	ldr	r3, [r3, #36]
	blx	r3
	mov	r3, #0
	mov	r0, #1
	str	r3, [r5, #-3196]
	b	.L1848
.L1901:
	mov	r2, r5
	ldr	r1, .L1979+192
	mov	r0, #32
	bl	dprint_vfmw
	b	.L1961
.L1906:
	ldr	r3, .L1979+16
	mov	r2, r4
	ldr	r1, .L1979+196
	mov	r0, #32
	str	r4, [r3, #-3652]
	bl	dprint_vfmw
	mov	r0, #1
	b	.L1848
.L1971:
	cmp	r0, #8
	beq	.L1961
	b	.L1940
.L1962:
	mov	r2, r4
	ldr	r1, .L1979+200
	mov	r0, #32
	bl	dprint_vfmw
	b	.L1923
.L1977:
	ldr	r3, .L1979+16
	mov	r2, r4
	ldr	r1, .L1979+204
	mov	r0, #32
	str	r4, [r3, #-4064]
	bl	dprint_vfmw
	b	.L1961
.L1924:
	mov	r2, r6
	ldr	r1, .L1979+208
	mov	r0, #32
	bl	dprint_vfmw
	b	.L1923
.L1973:
	ldr	r1, .L1979+212
	mov	r0, #32
	bl	dprint_vfmw
	str	r4, [r5, #72]
	mov	r0, r6
	b	.L1848
.L1975:
	ldr	r2, [r6, #-2932]
	mov	r1, #50
	ldr	r8, .L1979+20
	sub	r0, fp, #168
	add	ip, r2, #1
	ldr	r3, .L1979+100
	str	r2, [sp]
	ldr	r2, .L1979+216
	str	ip, [r6, #-2932]
	ldr	r9, [r8, #68]
	blx	r9
	ldr	r3, [r8, #32]
	mov	r2, r7
	sub	r0, fp, #168
	mov	r1, #66
	blx	r3
	str	r4, [r6, #-2928]
	cmp	r0, #0
	str	r0, [r5, #-3060]
	beq	.L1934
	mov	r3, r4
	sub	r2, fp, #168
	ldr	r1, .L1979+220
	mov	r0, #32
	bl	dprint_vfmw
	b	.L1961
.L1972:
	ldr	r2, [r6, #-3204]
	mov	r1, #50
	ldr	r8, .L1979+20
	sub	r0, fp, #168
	add	ip, r2, #1
	ldr	r3, .L1979+100
	str	r2, [sp]
	ldr	r2, .L1979+224
	str	ip, [r6, #-3204]
	ldr	r9, [r8, #68]
	blx	r9
	ldr	r3, [r8, #32]
	mov	r2, r7
	sub	r0, fp, #168
	mov	r1, #66
	blx	r3
	str	r4, [r6, #-3200]
	cmp	r0, #0
	str	r0, [r5, #-3332]
	beq	.L1928
	mov	r3, r4
	sub	r2, fp, #168
	ldr	r1, .L1979+228
	mov	r0, #32
	bl	dprint_vfmw
	b	.L1961
.L1976:
	ldr	r2, [r6, #-3648]
	mov	r1, #50
	ldr	r8, .L1979+20
	sub	r0, fp, #168
	add	ip, r2, #1
	ldr	r3, .L1979+100
	str	r2, [sp]
	ldr	r2, .L1979+232
	str	ip, [r6, #-3648]
	ldr	r9, [r8, #68]
	blx	r9
	ldr	r3, [r8, #32]
	mov	r2, r7
	sub	r0, fp, #168
	mov	r1, #66
	blx	r3
	str	r4, [r6, #-3644]
	cmp	r0, #0
	str	r0, [r5, #-4060]
	beq	.L1909
	mov	r3, r4
	sub	r2, fp, #168
	ldr	r1, .L1979+236
	mov	r0, #32
	bl	dprint_vfmw
	b	.L1961
.L1978:
	ldr	r2, [r6, #-3068]
	mov	r1, #50
	ldr	r8, .L1979+20
	sub	r0, fp, #168
	add	ip, r2, #1
	ldr	r3, .L1979+100
	str	r2, [sp]
	ldr	r2, .L1979+240
	str	ip, [r6, #-3068]
	ldr	r9, [r8, #68]
	blx	r9
	ldr	r3, [r8, #32]
	mov	r2, r7
	sub	r0, fp, #168
	mov	r1, #66
	blx	r3
	str	r4, [r6, #-3064]
	cmp	r0, #0
	str	r0, [r5, #-3196]
	beq	.L1931
	mov	r3, r4
	sub	r2, fp, #168
	ldr	r1, .L1979+244
	mov	r0, #32
	bl	dprint_vfmw
	b	.L1961
.L1974:
	ldr	r2, [r6, #-3512]
	mov	r1, #50
	ldr	r8, .L1979+20
	sub	r0, fp, #168
	add	ip, r2, #1
	ldr	r3, .L1979+100
	str	r2, [sp]
	ldr	r2, .L1979+248
	str	ip, [r6, #-3512]
	ldr	r9, [r8, #68]
	blx	r9
	ldr	r3, [r8, #32]
	mov	r2, r7
	sub	r0, fp, #168
	mov	r1, #66
	blx	r3
	str	r4, [r6, #-3508]
	cmp	r0, #0
	str	r0, [r5, #-3640]
	beq	.L1913
	mov	r3, r4
	sub	r2, fp, #168
	ldr	r1, .L1979+252
	mov	r0, #32
	bl	dprint_vfmw
	b	.L1961
.L1925:
	mov	r0, ip
	movw	r2, #9007
	ldr	r1, .L1979+256
	bl	dprint_vfmw
	b	.L1926
.L1968:
	ldr	r3, [r5, #-3376]
	mov	r1, #100
	ldr	r9, .L1979+20
	sub	r0, fp, #168
	ldr	r8, .L1979+28
	add	ip, r3, #1
	str	r3, [sp]
	ldr	r2, .L1979+260
	add	r3, r8, #4
	str	ip, [r5, #-3376]
	ldr	r10, [r9, #68]
	blx	r10
	ldr	r3, [r9, #32]
	sub	r0, fp, #168
	mov	r2, r7
	movw	r1, #578
	blx	r3
	cmp	r0, #0
	str	r0, [r6, #-3504]
	beq	.L1916
	ldr	r3, [r9, #48]
	mov	r2, #24
	mov	r1, r7
	ldr	r0, .L1979+32
	blx	r3
	str	r7, [sp]
	ldr	r3, .L1979+32
	mov	r2, #14155776
	mov	r1, r7
	ldr	r0, .L1979+264
	bl	MEM_AllocMemBlock
	cmp	r0, #0
	beq	.L1917
	ldr	r1, .L1979+268
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r9, #36]
	ldr	r0, [r6, #-3504]
	blx	r3
	mvn	r3, #0
	str	r7, [r6, #-3504]
	str	r7, [r5, #-3348]
	str	r7, [r5, #-3344]
	str	r7, [r5, #-3340]
	str	r7, [r5, #-3336]
	str	r3, [r8, #68]
	b	.L1961
.L1917:
	ldr	r2, [r5, #-3356]
	ldr	r1, [r5, #-3368]
	ldr	r0, [r5, #-3364]
	bl	MEM_AddMemRecord
	ldr	ip, [r5, #-3368]
	mov	lr, r4, lsr #24
	sub	r2, fp, #168
	and	r4, r4, #3
	add	r6, ip, #9437184
	str	r4, [sp]
	mov	r3, lr
	str	ip, [r5, #-3340]
	mov	r0, #32
	add	ip, ip, #11796480
	ldr	r1, .L1979+272
	str	r6, [r5, #-3344]
	str	ip, [r5, #-3348]
	str	lr, [r8, #68]
	str	r4, [r5, #-3336]
	bl	dprint_vfmw
	b	.L1961
.L1934:
	sub	r2, fp, #168
	ldr	r1, .L1979+276
	mov	r0, #32
	bl	dprint_vfmw
	b	.L1961
.L1928:
	sub	r2, fp, #168
	ldr	r1, .L1979+280
	mov	r0, #32
	bl	dprint_vfmw
	b	.L1961
.L1931:
	sub	r2, fp, #168
	ldr	r1, .L1979+284
	mov	r0, #32
	bl	dprint_vfmw
	b	.L1961
.L1909:
	sub	r2, fp, #168
	ldr	r1, .L1979+288
	mov	r0, #32
	bl	dprint_vfmw
	b	.L1961
.L1913:
	sub	r2, fp, #168
	ldr	r1, .L1979+292
	mov	r0, #32
	bl	dprint_vfmw
	b	.L1961
.L1916:
	sub	r2, fp, #168
	ldr	r1, .L1979+296
	mov	r0, #32
	bl	dprint_vfmw
	b	.L1961
.L1980:
	.align	2
.L1979:
	.word	.LC223
	.word	.LC224
	.word	.LC225
	.word	s_SmIIS
	.word	.LANCHOR4
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC205
	.word	.LANCHOR3
	.word	.LANCHOR4-3372
	.word	g_PrintEnable
	.word	.LANCHOR0
	.word	.LC234
	.word	.LC180
	.word	.LC184
	.word	.LANCHOR2
	.word	.LC228
	.word	.LC215
	.word	.LC237
	.word	g_TunnelLineNumber
	.word	.LC199
	.word	g_TraceImgPeriod
	.word	.LC232
	.word	.LC191
	.word	.LC227
	.word	.LC235
	.word	.LANCHOR3+4
	.word	.LC210
	.word	g_vdm_hal_fun_ptr
	.word	.LC211
	.word	.LC182
	.word	.LC222
	.word	.LC226
	.word	.LC207
	.word	.LC208
	.word	.LC233
	.word	.LC181
	.word	g_TraceBsPeriod
	.word	.LC230
	.word	g_TraceFramePeriod
	.word	.LC231
	.word	USE_FF_APT_EN
	.word	.LC185
	.word	.LC186
	.word	.LC195
	.word	g_TraceCtrl
	.word	.LC229
	.word	.LC188
	.word	.LC189
	.word	.LC183
	.word	.LC190
	.word	.LC206
	.word	.LC187
	.word	.LC209
	.word	.LC236
	.word	.LC219
	.word	.LC220
	.word	.LC212
	.word	.LC213
	.word	.LC192
	.word	.LC193
	.word	.LC216
	.word	.LC217
	.word	.LC196
	.word	.LC197
	.word	.LC15
	.word	.LC200
	.word	.LC201
	.word	.LC202
	.word	.LC203
	.word	.LC221
	.word	.LC214
	.word	.LC218
	.word	.LC194
	.word	.LC198
	.word	.LC204
	.fnend
	.size	VCTRL_SetDbgOption, .-VCTRL_SetDbgOption
	.align	2
	.global	VCTRL_ResetChanWithOption
	.type	VCTRL_ResetChanWithOption, %function
VCTRL_ResetChanWithOption:
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
	ldr	r5, .L2014
	mov	r4, r0
	mov	r6, r1
	ldr	r3, [r5, r0, asl #2]
	cmp	r3, #0
	beq	.L2008
	ldr	r2, [r1]
	cmp	r2, #1
	bhi	.L2009
	ldr	r9, [r3, #16]
	bl	VCTRL_StopChan
	ldr	r7, .L2014+4
	mov	r8, #0
	ldr	r3, [r5, r4, asl #2]
	mov	r2, #300
	ldr	r0, .L2014+8
	mov	r1, r8
	ldr	ip, [r7, #48]
	str	r8, [r3, #388]
	str	r8, [r3, #392]
	mla	r0, r2, r4, r0
	blx	ip
	ldr	r3, [r5, r4, asl #2]
	cmp	r3, r8
	addne	r3, r3, #233472
	strne	r8, [r3, #412]
	beq	.L2010
.L1986:
	ldr	r3, [r7, #12]
	mov	r0, #4
	blx	r3
	mov	r0, r4
	bl	VCTRL_FindOccupiedFrame
	ldr	r3, [r7, #16]
	mov	r0, #4
	blx	r3
	ldr	r2, [r6, #4]
	ldr	r3, [r5, r4, asl #2]
	mov	r0, r4
	str	r2, [r3, #1204]
	bl	InitSyntaxCtx
	ldr	r3, [r5, r4, asl #2]
	add	r1, r3, #237568
	ldr	r0, [r3, #592]
	add	r1, r1, #376
	bl	ReleaseCurPic
	ldr	r0, [r5, r4, asl #2]
	ldr	r3, [r7, #48]
	mov	r2, #416
	mov	r1, #0
	add	r0, r0, #736
	blx	r3
	ldr	r3, [r5, r4, asl #2]
	mvn	r0, #0
	mvn	r1, #0
	add	lr, r3, #656
	add	ip, r3, #672
	mov	r2, #0
	strd	r0, [lr]
	strd	r0, [ip, #-8]
	mov	r0, r4
	ldr	r1, [r3, #1424]
	str	r2, [r3, #1152]
	cmp	r1, #1
	streq	r2, [r3, #1464]
	ldr	r3, [r3, #592]
	cmp	r3, #20
	beq	.L1988
	ldr	r3, [r6, #8]
	cmp	r3, #0
	beq	.L2011
.L1988:
	bl	FSP_EmptyInstance
.L1989:
	mov	r0, r4
	bl	InitUsdPool
	ldr	r3, [r6]
	cmp	r3, #0
	beq	.L2012
.L1990:
	ldr	r3, .L2014+12
	ldr	r2, [r3, #-4064]
	cmp	r2, #0
	beq	.L1991
	add	r5, r3, r4, lsl #2
	str	r4, [fp, #-40]
	ldr	r3, [r5, #-4060]
	cmp	r3, #0
	beq	.L1993
	mov	r0, #512
	sub	r1, fp, #40
	bl	VCTRL_SetDbgOption
	ldr	r3, [r5, #-4060]
	cmp	r3, #0
	beq	.L1993
	sub	r1, fp, #40
	mov	r0, #512
	bl	VCTRL_SetDbgOption
.L1993:
	ldr	r1, .L2014+16
	mov	r0, #32
	bl	dprint_vfmw
.L1991:
	cmp	r9, #0
	bne	.L2013
.L1995:
	mov	r0, r4
	bl	VDMDRV_ClearChanIsDec
	mov	r0, #0
.L1983:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2012:
	mov	r0, r4
	bl	SM_Reset
	b	.L1990
.L2013:
	mov	r0, r4
	bl	VCTRL_StartChan
	b	.L1995
.L2011:
	bl	FSP_ResetInstance
	b	.L1989
.L2009:
	movw	r2, #4072
	ldr	r1, .L2014+20
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2010:
	bl	VCTRL_SetSendStreamAgainFlag.part.2
	b	.L1986
.L2008:
	mov	r0, r3
	movw	r2, #4068
	ldr	r3, .L2014+24
	ldr	r1, .L2014+28
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1983
.L2015:
	.align	2
.L2014:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR2-748
	.word	.LANCHOR4
	.word	.LC154
	.word	.LC238
	.word	.LC2
	.word	.LC1
	.fnend
	.size	VCTRL_ResetChanWithOption, .-VCTRL_ResetChanWithOption
	.align	2
	.global	VCTRL_DestroyChanWithOption
	.type	VCTRL_DestroyChanWithOption, %function
VCTRL_DestroyChanWithOption:
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
	ldr	r5, .L2031
	mov	r4, r0
	mov	r0, #0
	ldr	r3, [r5, #12]
	blx	r3
	cmp	r4, #15
	ldrhi	r3, .L2031+4
	movwhi	r2, #2799
	bhi	.L2026
	ldr	r7, .L2031+8
	ldr	r6, [r7, r4, asl #2]
	cmp	r6, #0
	beq	.L2027
	ldr	r3, [r6, #12]
	cmp	r3, #1
	bne	.L2028
	ldr	r3, [r5, #12]
	mov	r0, #4
	blx	r3
	mov	r0, r4
	bl	VCTRL_StopChan
	ldr	r3, [r5, #16]
	subs	r8, r0, #0
	mov	r0, #4
	bne	.L2029
	blx	r3
	mov	r0, r4
	bl	VCTRL_ResetChan
	bl	VDMDRV_ParamInit
	ldr	r3, .L2031+12
	ldr	r2, [r5, #12]
	mov	r0, #4
	add	r3, r3, r4, lsl #2
	str	r8, [r3, #-1012]
	blx	r2
	ldr	r3, [r6, #592]
	cmp	r3, #4
	beq	.L2030
.L2022:
	mov	r0, r4
	ldr	r8, .L2031+16
	bl	FSP_DisableInstance
	mov	r0, r4
	bl	CloseUsdPool_WithMem
	ldr	r3, [r7, r4, asl #2]
	ldr	r0, .L2031+20
	mov	r2, r4, asl #6
	add	r1, r3, #237568
	sub	r2, r2, r4, asl #3
	add	r2, r2, r0
	ldr	lr, [r3, #300]
	ldr	r10, [r3, #304]
	mov	r6, #0
	ldr	r9, [r3, #296]
	mov	r0, r4
	ldr	ip, [r1, #336]
	add	r1, r3, #233472
	str	r6, [r2, #48]
	add	r1, r1, #416
	str	r2, [fp, #-72]
	str	r1, [fp, #-68]
	str	lr, [fp, #-56]
	add	lr, r3, #224
	str	ip, [fp, #-64]
	add	ip, r3, #248
	str	lr, [fp, #-84]
	add	r3, r3, #272
	str	ip, [fp, #-80]
	str	r3, [fp, #-76]
	str	r10, [fp, #-52]
	str	r9, [fp, #-60]
	str	r6, [r7, r4, asl #2]
	str	r6, [r8, r4, asl #2]
	bl	VDMDRV_ClearChanIsDec
	mov	r0, r4
	bl	SCDDRV_ResetSCD
	mov	r0, r4
	bl	VDMDRV_ResetVDH
	ldr	r3, [r5, #16]
	mov	r0, #4
	blx	r3
	ldr	r3, [r5, #16]
	mov	r0, r6
	blx	r3
	ldr	r3, [r5, #24]
	mov	r1, r4
	mov	r0, #1
	blx	r3
	sub	r1, fp, #84
	mov	r0, r4
	bl	VCTRL_FreeChanResource
	mov	r0, #1
	ldr	r3, [r5, #28]
	mov	r1, r4
	blx	r3
	mov	r0, r6
.L2018:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2030:
	ldr	r3, [r7, #340]
	cmp	r3, #0
	beq	.L2022
	add	r0, r6, #237568
	add	r0, r0, #376
	blx	r3
	b	.L2022
.L2028:
	ldr	r3, .L2031+24
	movw	r2, #2823
.L2026:
	ldr	r1, .L2031+28
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r3, [r5, #16]
	mov	r0, #0
	blx	r3
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2029:
	blx	r3
	ldr	r3, [r5, #16]
	mov	r0, #0
	blx	r3
	mvn	r0, #0
	b	.L2018
.L2027:
	ldr	r3, .L2031+32
	movw	r2, #2809
	ldr	r1, .L2031+28
	mov	r0, r6
	bl	dprint_vfmw
	ldr	r3, [r5, #16]
	mov	r0, r6
	blx	r3
	mvn	r0, #0
	b	.L2018
.L2032:
	.align	2
.L2031:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC20
	.word	.LANCHOR0
	.word	.LANCHOR2
	.word	s_pFspInst
	.word	s_SmIIS
	.word	.LC241
	.word	.LC239
	.word	.LC240
	.fnend
	.size	VCTRL_DestroyChanWithOption, .-VCTRL_DestroyChanWithOption
	.align	2
	.global	VCTRL_DestroyChan
	.type	VCTRL_DestroyChan, %function
VCTRL_DestroyChan:
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
	bl	VCTRL_DestroyChanWithOption
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VCTRL_DestroyChan, .-VCTRL_DestroyChan
	.align	2
	.global	VCTRL_CloseVfmw
	.type	VCTRL_CloseVfmw, %function
VCTRL_CloseVfmw:
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
	ldr	r6, .L2052
	ldr	r3, [r6, #64]
	cmp	r3, #1
	bne	.L2041
	sub	r5, r6, #4
	mov	r4, #0
.L2037:
	ldr	r3, [r5, #4]!
	mov	r0, r4
	add	r4, r4, #1
	cmp	r3, #0
	beq	.L2036
	bl	VCTRL_DestroyChanWithOption
.L2036:
	cmp	r4, #16
	bne	.L2037
	bl	FSP_Exit
	ldr	r3, [r6, #68]
	mov	r2, #3
	ldr	r5, .L2052+4
	cmp	r3, #0
	str	r2, [r6, #72]
	beq	.L2039
	mov	r0, #10
	ldr	r3, [r5, #116]
	mov	r4, #49
	blx	r3
	b	.L2040
.L2051:
	ldr	r3, [r5, #116]
	blx	r3
	subs	r4, r4, #1
	beq	.L2039
.L2040:
	ldr	r3, [r6, #68]
	mov	r0, #10
	cmp	r3, #0
	bne	.L2051
.L2039:
	ldr	r3, [r5, #48]
	mov	r2, #64
	mov	r1, #0
	ldr	r0, .L2052+8
	blx	r3
	ldr	r0, .L2052+12
	bl	CloseDrivers
	mov	r3, #0
	mov	r0, r3
	str	r3, [r6, #64]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2041:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2053:
	.align	2
.L2052:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR2-1012
	.word	.LANCHOR0+88
	.fnend
	.size	VCTRL_CloseVfmw, .-VCTRL_CloseVfmw
	.align	2
	.global	VCTRL_InitDspCode
	.type	VCTRL_InitDspCode, %function
VCTRL_InitDspCode:
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
	cmp	r1, #6
	mov	r5, r0
	moveq	r4, #1
	beq	.L2055
	cmp	r1, #0
	moveq	r4, #2
	movne	r4, #0
.L2055:
	ldr	r3, .L2070
	ldrb	r3, [r3]
	cmp	r3, #1
	beq	.L2066
	mov	r1, r4
	mov	r0, #0
	bl	VDH_Require_DspCode
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2066:
	ldr	r6, .L2070+4
	ldr	r3, [r6]
	cmp	r3, #0
	beq	.L2067
	mov	r0, #0
	blx	r3
.L2058:
	ldr	r3, [r6, #16]
	cmp	r3, #0
	beq	.L2068
	mov	r0, #0
	blx	r3
.L2060:
	ldr	r3, [r6, #8]
	cmp	r3, #0
	beq	.L2069
	mov	r0, #0
	blx	r3
.L2062:
	mov	r1, r4
	mov	r0, #0
	bl	SCDDRV_LoadDspCode
	mov	r0, r5
	bl	VCTRL_CloseHardware
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2067:
	mov	r0, r3
	movw	r2, #3820
	ldr	r1, .L2070+8
	bl	dprint_vfmw
	b	.L2058
.L2068:
	mov	r0, r3
	movw	r2, #3821
	ldr	r1, .L2070+8
	bl	dprint_vfmw
	b	.L2060
.L2069:
	mov	r0, r3
	movw	r2, #3822
	ldr	r1, .L2070+8
	bl	dprint_vfmw
	b	.L2062
.L2071:
	.align	2
.L2070:
	.word	g_HalDisable
	.word	g_vdm_hal_fun_ptr
	.word	.LC15
	.fnend
	.size	VCTRL_InitDspCode, .-VCTRL_InitDspCode
	.align	2
	.global	VCTRL_LoadDspCode
	.type	VCTRL_LoadDspCode, %function
VCTRL_LoadDspCode:
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
	ldr	r3, .L2096
	mov	r5, r0
	ldr	r3, [r3, r0, asl #2]
	ldr	r1, [r3, #592]
	cmp	r1, #0
	movne	r3, #1
	movne	r6, #0
	ldreq	r6, [r3, #1216]
	clzeq	r3, r6
	moveq	r3, r3, lsr #5
.L2073:
	cmp	r1, #6
	moveq	r3, #0
	andne	r3, r3, #1
	cmp	r3, #0
	beq	.L2094
.L2085:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2094:
	ldr	r7, .L2096+4
	ldr	r4, [r7, #-1012]
	cmp	r4, #0
	bne	.L2074
	sub	r3, r7, #1012
	sub	r2, r7, #952
.L2075:
	ldr	r4, [r3, #4]!
	cmp	r4, #0
	bne	.L2074
	cmp	r3, r2
	bne	.L2075
	mov	r0, r5
	add	r5, r7, r5, lsl #2
	bl	VCTRL_InitDspCode
	cmp	r6, #1
	mov	r0, r4
	streq	r6, [r5, #-1012]
	movne	r3, #2
	strne	r3, [r5, #-1012]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2074:
	cmp	r4, #1
	beq	.L2095
	cmp	r1, #6
	beq	.L2085
	ldr	r1, .L2096+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2095:
	cmp	r6, #1
	beq	.L2085
	ldr	r1, .L2096+12
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2097:
	.align	2
.L2096:
	.word	.LANCHOR0
	.word	.LANCHOR2
	.word	.LC243
	.word	.LC242
	.fnend
	.size	VCTRL_LoadDspCode, .-VCTRL_LoadDspCode
	.align	2
	.global	VCTRL_SetChanFsPartitionState
	.type	VCTRL_SetChanFsPartitionState, %function
VCTRL_SetChanFsPartitionState:
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
	ldr	r3, .L2099
	ldr	r3, [r3, r0, asl #2]
	add	r3, r3, #233472
	str	r1, [r3, #368]
	ldmfd	sp, {fp, sp, pc}
.L2100:
	.align	2
.L2099:
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_SetChanFsPartitionState, .-VCTRL_SetChanFsPartitionState
	.align	2
	.global	VCTRL_GetCurChanFsSize
	.type	VCTRL_GetCurChanFsSize, %function
VCTRL_GetCurChanFsSize:
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
	ldr	r3, .L2102
	ldr	r3, [r3, r0, asl #2]
	add	r3, r3, #233472
	ldr	r0, [r3, #388]
	ldmfd	sp, {fp, sp, pc}
.L2103:
	.align	2
.L2102:
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_GetCurChanFsSize, .-VCTRL_GetCurChanFsSize
	.align	2
	.global	VCTRT_SetChanCtrlState
	.type	VCTRT_SetChanCtrlState, %function
VCTRT_SetChanCtrlState:
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
	ldr	r4, .L2116
	mov	r6, r0
	mov	r0, #0
	mov	r5, r1
	ldr	r3, [r4, #12]
	blx	r3
	cmp	r5, #1
	beq	.L2106
	bcc	.L2107
	cmp	r5, #2
	bne	.L2115
	ldr	r3, .L2116+4
	add	r6, r3, r6, lsl #2
	ldr	r3, [r6, #-3928]
	cmp	r3, #1
	beq	.L2111
.L2113:
	str	r5, [r6, #-3928]
	mov	r5, #0
	b	.L2105
.L2115:
	mov	r5, #0
.L2105:
	ldr	r3, [r4, #16]
	mov	r0, #0
	blx	r3
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2107:
	ldr	r3, .L2116+4
	mov	r2, #0
	mov	r5, r2
	add	r6, r3, r6, lsl #2
	str	r2, [r6, #-3928]
	b	.L2105
.L2106:
	ldr	r3, .L2116+4
	add	r6, r3, r6, lsl #2
	ldr	r3, [r6, #-3928]
	cmp	r3, #0
	beq	.L2113
.L2111:
	mvn	r5, #0
	b	.L2105
.L2117:
	.align	2
.L2116:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR4
	.fnend
	.size	VCTRT_SetChanCtrlState, .-VCTRT_SetChanCtrlState
	.align	2
	.global	VCTRL_SetFsParamToChan
	.type	VCTRL_SetFsParamToChan, %function
VCTRL_SetFsParamToChan:
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
	ldr	r3, .L2119
	ldr	ip, [r1, #4]
	ldr	r3, [r3, r0, asl #2]
	add	r2, r3, #233472
	str	ip, [r3, #316]
	ldr	r0, [r1]
	str	r0, [r3, #312]
	ldr	r0, [r1]
	str	r0, [r3, #232]
	ldr	r0, [r1, #16]
	str	r0, [r3, #228]
	ldr	r0, [r1, #4]
	str	r0, [r3, #240]
	ldr	r3, [r1, #8]
	str	r3, [r2, #396]
	ldmfd	sp, {fp, sp, pc}
.L2120:
	.align	2
.L2119:
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_SetFsParamToChan, .-VCTRL_SetFsParamToChan
	.align	2
	.global	VCTRL_SetSingleFrameBufToChan
	.type	VCTRL_SetSingleFrameBufToChan, %function
VCTRL_SetSingleFrameBufToChan:
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
	ldr	r8, .L2194
	mov	r9, r0
	ldr	r3, .L2194+4
	mov	r5, r1
	ldr	r7, .L2194+8
	mov	r0, #8
	ldr	r10, [r8, r9, asl #2]
	ldr	r6, [r3, r9, asl #2]
	add	r4, r10, #233472
	ldr	r2, [r7, #12]
	ldr	r3, [r4, #396]
	ldr	r1, [r4, #3864]
	cmp	r3, #32
	movge	r3, #32
	str	r3, [r4, #3672]
	str	r1, [fp, #-48]
	blx	r2
	ldr	lr, [r8, r9, asl #2]
	add	r3, lr, #233472
	ldr	r2, [r3, #416]
	cmp	r2, #255
	beq	.L2151
	add	r3, r3, #488
	mov	r2, #1
	b	.L2123
.L2190:
	add	r2, r2, #1
	cmp	r2, #32
	beq	.L2184
.L2123:
	ldr	r1, [r3]
	add	r3, r3, #72
	cmp	r1, #255
	bne	.L2190
.L2122:
	mov	r0, r2, asl #6
	ldr	r3, [r7, #52]
	add	r0, r0, r2, lsl #3
	mov	r1, r5
	add	r0, r0, #233472
	mov	r2, #72
	add	r0, r0, #416
	add	r0, lr, r0
	blx	r3
	ldr	r3, [r8, r9, asl #2]
	add	r3, r3, #233472
	ldr	r2, [r3, #3900]
	add	r2, r2, #1
	str	r2, [r3, #3900]
	ldr	r3, [r5]
	cmp	r3, #255
	beq	.L2145
	ldr	r2, [r5, #12]
	ldr	r1, [r5, #24]
	ldr	r0, [r5, #32]
	bl	MEM_AddMemRecord
.L2145:
	ldr	r3, [r5, #4]
	cmp	r3, #255
	beq	.L2125
	ldr	r2, [r5, #16]
	ldr	r1, [r5, #40]
	ldr	r0, [r5, #48]
	bl	MEM_AddMemRecord
.L2125:
	ldr	r3, [r5, #8]
	cmp	r3, #255
	beq	.L2126
	ldr	r2, [r5, #20]
	ldr	r1, [r5, #56]
	ldr	r0, [r5, #64]
	bl	MEM_AddMemRecord
.L2126:
	ldr	r3, [r8, r9, asl #2]
	add	r2, r3, #233472
	ldr	r8, [r2, #3904]
	cmp	r8, #0
	beq	.L2143
	ldrsb	r2, [r6, #1]
	cmp	r2, #0
	bne	.L2191
.L2129:
	ldr	r3, [r4, #3672]
	strb	r3, [r6, #10]
.L2130:
	mov	r0, #0
	strb	r0, [r6, #11]
	ldr	r3, [r4, #3840]
	strb	r3, [r6, #13]
	ldr	r3, [r5]
	cmp	r3, #255
	beq	.L2192
	ldrb	r0, [r4, #2736]
	cmp	r0, #0
	beq	.L2131
	add	r3, r10, #235520
	mov	r0, #1
	add	r3, r3, #700
	b	.L2132
.L2193:
	add	r0, r0, #1
	cmp	r0, #32
	beq	.L2184
.L2132:
	ldrb	r2, [r3]
	add	r3, r3, #12
	cmp	r2, #0
	bne	.L2193
.L2131:
	ldr	r3, [r5, #32]
	mov	r2, r0, asl #4
	sub	r2, r2, r0, asl #2
	ldr	r8, [fp, #-48]
	add	r3, r3, #1020
	add	r2, r4, r2
	add	r3, r3, #3
	mov	r1, #1
	bic	r3, r3, #1020
	add	ip, r4, r0, lsl #2
	bic	r3, r3, #3
	str	r3, [r2, #2728]
	ldr	lr, [r5, #12]
	add	r9, r3, r8
	strb	r1, [r2, #2736]
	str	lr, [r2, #2732]
	ldr	r3, [r4, #3844]
	add	r3, r3, r1
	str	r3, [r4, #3844]
	str	r9, [ip, #3496]
	ldr	r3, [r5, #48]
	strb	r1, [r2, #3120]
	str	r3, [r2, #3112]
	ldr	r3, [r4, #3852]
	add	r3, r3, r1
	str	r3, [r4, #3852]
	ldr	r3, [r5, #8]
	cmp	r3, #255
	bne	.L2148
.L2134:
	add	r1, r6, #16384
	ldr	ip, [r1, #4092]
	cmp	ip, #0
	beq	.L2154
	add	r2, r6, #20480
	mov	r3, #1
	add	r2, r2, #96
	b	.L2139
.L2138:
	add	r3, r3, #1
	cmp	r3, #32
	beq	.L2184
.L2139:
	ldr	ip, [r2]
	add	r2, r2, #100
	cmp	ip, #0
	bne	.L2138
	mov	ip, r3
.L2137:
	mov	lr, #100
	add	r2, r6, #24576
	mla	r3, lr, r3, r6
	mov	lr, r0, asl #4
	sub	lr, lr, r0, asl #2
	ldr	r8, [r2, #2956]
	add	lr, r4, lr
	add	r0, r4, r0, lsl #2
	str	r0, [fp, #-56]
	add	r0, r3, #20224
	add	r8, r8, #1
	str	r8, [r2, #2956]
	str	ip, [r0, #164]
	mov	r10, r0
	ldr	ip, [lr, #2728]
	mov	r8, r0
	mov	r9, r0
	add	r3, r0, #248
	str	r3, [fp, #-52]
	str	ip, [r10, #172]
	ldr	ip, [lr, #2732]
	str	ip, [r10, #176]
	add	ip, r0, #216
	ldr	r10, [r4, #2720]
	str	ip, [fp, #-48]
	add	ip, r0, #192
	ldr	r3, [fp, #-48]
	str	r10, [r8, #188]
	mov	r10, r0
	ldr	lr, [r4, #3644]
	str	ip, [fp, #-60]
	add	ip, r0, #224
	str	lr, [r0, #204]
	ldr	lr, [r4, #3652]
	str	lr, [r0, #208]
	ldr	lr, [r4, #3656]
	str	lr, [r9, #212]
	ldr	lr, [r4, #3636]
	str	lr, [r9, #216]
	mov	r9, #0
	ldr	lr, [r4, #3640]
	str	lr, [r3, #4]
	ldr	lr, [fp, #-56]
	ldr	lr, [lr, #3496]
	str	lr, [r8, #192]
	ldr	lr, [fp, #-60]
	ldr	r8, [r4, #3624]
	str	r8, [lr, #4]
	ldr	r8, [r4, #3628]
	str	r8, [lr, #8]
	ldr	lr, [r6, #28]
	str	lr, [r3, #8]
	ldr	r3, [r6, #32]
	str	r3, [ip, #4]
	ldr	r8, [r4, #3660]
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-52]
	str	r8, [ip, #8]
	ldr	r8, [r4, #3664]
	str	r8, [r10, #236]
	ldr	r8, [r4, #3668]
	str	r8, [r10, #240]
	strb	r9, [r0, #156]
	strb	r9, [r0, #157]
	strb	r9, [r0, #158]
	mov	r0, #1
	str	r0, [r3, #4]
	ldr	r3, [r2, #2300]
	cmp	r3, r9
	bne	.L2150
	mov	r0, #1
	ldr	ip, [fp, #-48]
	strb	r0, [r6, #12]
	str	r3, [r2, #2212]
	str	r3, [r2, #2220]
	ldr	r0, [r4, #2720]
	str	lr, [r2, #2272]
	str	ip, [r2, #2276]
	str	r0, [r2, #2236]
	ldr	r0, [r4, #3660]
	str	r0, [r2, #2280]
	ldr	r0, [r4, #3664]
	str	r0, [r2, #2284]
	ldr	r0, [r4, #3668]
	strb	r3, [r2, #2204]
	strb	r3, [r2, #2205]
	strb	r3, [r2, #2206]
	mov	r3, #1
	str	r0, [r2, #2288]
	str	r3, [r2, #2300]
.L2150:
	ldr	r3, [r2, #2960]
	ldrsb	r0, [r6, #13]
	cmp	r3, r0
	bcs	.L2141
	add	r8, r4, r3, lsl #3
	add	r0, r6, r3, lsl #3
	add	r0, r0, #24576
	add	r3, r3, #1
	ldr	r8, [r8, #3676]
	mov	r10, #0
	mov	r9, #1
	strb	r10, [r0, #2797]
	strb	r9, [r0, #2796]
	str	r8, [r0, #2792]
	str	r3, [r2, #2960]
.L2141:
	ldr	r3, [r2, #2964]
	ldr	r0, [r4, #3672]
	cmp	r3, r0
	bcs	.L2142
	ldr	r0, [r5, #4]
	cmp	r0, #255
	beq	.L2142
	ldr	r9, [r4, #3852]
	mov	r0, #100
	mla	r0, r0, r3, r6
	sub	r9, r9, #1
	mov	r10, r3, asl #4
	add	r5, r3, #1
	mov	r8, r9, asl #4
	sub	r3, r10, r3, asl #2
	sub	r8, r8, r9, asl #2
	add	r6, r6, r3
	add	r8, r4, r8
	add	r3, r6, #26880
	add	r0, r0, #20224
	mov	r9, #0
	ldr	r10, [r8, #3112]
	mov	r8, #1
	str	r10, [r0, #180]
	str	r9, [r3, #108]
	str	r8, [r3, #104]
	str	r5, [r2, #2964]
.L2142:
	ldr	r3, [r4, #3836]
	str	r3, [r2, #2788]
	ldr	r3, [r1, #3992]
	cmp	r3, #0
	bne	.L2143
	ldr	r0, [r1, #4012]
	mov	r2, #1
	str	r3, [r1, #3904]
	ldr	ip, [fp, #-48]
	str	r0, [r1, #3912]
	ldr	r0, [r4, #2720]
	str	lr, [r1, #3964]
	str	ip, [r1, #3968]
	str	r0, [r1, #3928]
	ldr	r0, [r4, #3660]
	str	r0, [r1, #3972]
	ldr	r0, [r4, #3664]
	str	r0, [r1, #3976]
	ldr	r0, [r4, #3668]
	strb	r3, [r1, #3896]
	strb	r3, [r1, #3897]
	str	r0, [r1, #3980]
	strb	r3, [r1, #3898]
	str	r2, [r1, #3992]
.L2143:
	ldr	r3, [r7, #16]
	mov	r0, #8
	blx	r3
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2184:
	ldr	r3, [r7, #16]
	mov	r0, #8
	blx	r3
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2192:
	ldr	r3, [r5, #8]
	cmp	r3, #255
	beq	.L2134
.L2148:
	ldrb	r1, [r4, #3680]
	cmp	r1, #0
	beq	.L2135
	mov	r3, #1
.L2136:
	mov	r1, r3, asl #3
	add	r3, r3, #1
	add	r2, r1, #236544
	add	r2, r2, #608
	ldrb	r2, [r10, r2]
	cmp	r2, #0
	beq	.L2135
	cmp	r3, #20
	bne	.L2136
	b	.L2134
.L2191:
	add	r3, r3, #237568
	ldr	r3, [r3, #336]
	cmp	r3, #0
	bne	.L2129
	ldrsb	r3, [r6, #23]
	ldr	r2, [r4, #3672]
	add	r3, r3, #4
	cmp	r3, r2
	movge	r3, r2
	strb	r3, [r6, #10]
	b	.L2130
.L2135:
	ldr	r2, [r5, #64]
	add	r1, r10, r1
	add	r1, r1, #233472
	mov	r3, #1
	str	r2, [r1, #3676]
	strb	r3, [r1, #3680]
	ldr	r3, [r4, #3848]
	add	r3, r3, #1
	str	r3, [r4, #3848]
	b	.L2134
.L2151:
	mov	r2, #0
	b	.L2122
.L2154:
	mov	r3, ip
	b	.L2137
.L2195:
	.align	2
.L2194:
	.word	.LANCHOR0
	.word	s_pFspInst
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	VCTRL_SetSingleFrameBufToChan, .-VCTRL_SetSingleFrameBufToChan
	.align	2
	.global	DBG_WriteBigTileYuv
	.type	DBG_WriteBigTileYuv, %function
DBG_WriteBigTileYuv:
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
	mov	r5, r3
	ldr	r3, [fp, #20]
	mov	r7, r1
	ldr	lr, [fp, #28]
	ldr	r1, [fp, #4]
	rsb	ip, r3, r5
	ldr	r3, [fp, #32]
	cmp	r0, #0
	rsb	r1, lr, r1
	str	r0, [fp, #-60]
	rsb	r3, r3, r1
	mov	r1, r5, lsr #1
	str	r1, [fp, #-64]
	mov	r6, r2
	ldr	r1, [fp, #4]
	ldr	r0, [fp, #24]
	str	r3, [fp, #-68]
	rsb	r2, r0, ip
	mov	r1, r1, lsr #1
	str	r2, [fp, #-72]
	str	r1, [fp, #-52]
	ldr	r4, [fp, #8]
	beq	.L2196
	ldr	r1, .L2296
	mov	r0, #32
	bl	dprint_vfmw
	cmp	r4, #0
	cmpne	r4, #3
	bne	.L2199
	ldr	r3, [fp, #4]
	ldr	r4, .L2296+4
	cmp	r3, #0
	beq	.L2201
	ldr	r10, .L2296+8
	mov	r3, #0
	mov	r8, r3
	str	r3, [fp, #-48]
	str	r6, [fp, #-56]
.L2203:
	cmp	r5, #0
	beq	.L2204
	ldr	r3, [fp, #-48]
	mov	r9, #0
	and	r6, r3, #15
	mov	r2, r3, lsr #4
	ldr	r3, [fp, #12]
	mul	r2, r3, r2
	add	r6, r2, r6, lsl #8
.L2202:
	mov	r1, r9, lsr #8
	ldr	r0, [r4, #-3340]
	add	r2, r8, r9
	ldr	r3, [r10, #52]
	add	r1, r6, r1, lsl #12
	add	r0, r0, r2
	add	r1, r7, r1
	add	r9, r9, #256
	mov	r2, #256
	blx	r3
	cmp	r5, r9
	bhi	.L2202
.L2204:
	ldr	r3, [fp, #-48]
	add	r8, r8, r5
	ldr	r2, [fp, #4]
	add	r3, r3, #1
	str	r3, [fp, #-48]
	cmp	r3, r2
	bne	.L2203
	ldr	r6, [fp, #-56]
.L2201:
	ldr	r3, [fp, #-72]
	ldr	r2, [fp, #-68]
	ldr	r1, [fp, #4]
	cmp	r3, r5
	cmpeq	r2, r1
	moveq	r3, #1
	movne	r3, #0
	str	r3, [fp, #-76]
	beq	.L2291
	ldr	r2, [fp, #20]
	ldr	r3, [fp, #28]
	ldr	r7, [r4, #-3340]
	mla	r3, r3, r5, r2
	ldr	r2, [fp, #-68]
	cmp	r2, #0
	add	r7, r7, r3
	beq	.L2209
	ldr	r10, .L2296+8
	mov	r9, r2
	str	r6, [fp, #-48]
	str	r4, [fp, #-56]
	ldr	r8, [fp, #-76]
	mov	r4, r10
	ldr	r6, [fp, #-72]
	ldr	r10, [fp, #-60]
.L2210:
	mov	r0, r7
	add	r8, r8, #1
	ldr	r3, [r4, #44]
	mov	r2, r10
	mov	r1, r6
	add	r7, r7, r5
	blx	r3
	cmp	r8, r9
	bne	.L2210
	ldr	r6, [fp, #-48]
	ldr	r4, [fp, #-56]
.L2209:
	ldr	r3, [fp, #-52]
	cmp	r3, #0
	beq	.L2206
	ldr	r3, [fp, #12]
	mov	r8, #0
	ldr	r10, .L2296+8
	str	r8, [fp, #-48]
	mov	r3, r3, lsr #1
	str	r3, [fp, #-56]
.L2207:
	cmp	r5, #0
	beq	.L2214
	ldr	r3, [fp, #-48]
	mov	r9, #0
	and	r7, r3, #7
	mov	r2, r3, lsr #3
	ldr	r3, [fp, #-56]
	mul	r2, r3, r2
	add	r7, r2, r7, lsl #8
.L2212:
	mov	r1, r9, lsr #8
	ldr	r0, [r4, #-3340]
	add	r2, r8, r9
	ldr	r3, [r10, #52]
	add	r1, r7, r1, lsl #11
	add	r0, r0, r2
	add	r1, r6, r1
	add	r9, r9, #256
	mov	r2, #256
	blx	r3
	cmp	r5, r9
	bhi	.L2212
.L2214:
	ldr	r3, [fp, #-48]
	add	r8, r8, r5
	ldr	r2, [fp, #-52]
	add	r3, r3, #1
	str	r3, [fp, #-48]
	cmp	r3, r2
	bne	.L2207
	ldr	r3, [fp, #16]
	ldr	lr, [r4, #-3340]
	cmp	r3, #1
	beq	.L2292
.L2216:
	ldr	r3, [fp, #16]
	cmp	r3, #0
	beq	.L2293
.L2217:
	ldr	r3, [fp, #-76]
	cmp	r3, #0
	bne	.L2294
	ldr	r1, [fp, #-68]
	ldr	r3, [fp, #28]
	ldr	r2, [fp, #20]
	movs	r5, r1, lsr #1
	ldr	r1, [fp, #-64]
	mov	r3, r3, lsr #1
	ldr	r7, [r4, #-3344]
	mov	r2, r2, lsr #1
	ldr	r4, [r4, #-3348]
	mla	r3, r3, r1, r2
	add	r7, r7, r3
	add	r4, r4, r3
	beq	.L2196
	ldr	r3, [fp, #-72]
	mov	r9, r1
	str	r4, [fp, #-48]
	ldr	r10, .L2296+8
	ldr	r8, [fp, #-76]
	mov	r6, r3, lsr #1
	ldr	r4, [fp, #-60]
.L2224:
	mov	r0, r7
	add	r8, r8, #1
	ldr	r3, [r10, #44]
	mov	r2, r4
	mov	r1, r6
	add	r7, r7, r9
	blx	r3
	cmp	r8, r5
	bne	.L2224
	ldr	r4, [fp, #-48]
	mov	r7, #0
	ldr	r8, [fp, #-64]
	ldr	r9, [fp, #-60]
.L2225:
	mov	r0, r4
	add	r7, r7, #1
	ldr	r3, [r10, #44]
	mov	r2, r9
	mov	r1, r6
	add	r4, r4, r8
	blx	r3
	cmp	r7, r5
	bne	.L2225
.L2196:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2199:
	subs	r3, r4, #1
	ldr	r2, [fp, #4]
	ldr	r10, .L2296+8
	movne	r3, #1
	cmp	r2, r3
	str	r3, [fp, #-68]
	ldrls	r4, .L2296+4
	bls	.L2227
	ldr	r3, [fp, #-68]
	ldr	r4, .L2296+4
	str	r6, [fp, #-56]
	str	r3, [fp, #-48]
.L2229:
	cmp	r5, #0
	beq	.L2230
	ldr	r3, [fp, #-48]
	mov	r6, #0
	and	r8, r3, #15
	mov	r2, r3, lsr #4
	mov	r9, r3, lsr #1
	ldr	r3, [fp, #12]
	mul	r9, r5, r9
	mul	r2, r3, r2
	add	r8, r2, r8, lsl #8
.L2228:
	mov	r1, r6, lsr #8
	ldr	r0, [r4, #-3340]
	add	r2, r6, r9
	ldr	r3, [r10, #52]
	add	r1, r8, r1, lsl #12
	add	r0, r0, r2
	add	r1, r7, r1
	add	r6, r6, #256
	mov	r2, #256
	blx	r3
	cmp	r5, r6
	bhi	.L2228
.L2230:
	ldr	r3, [fp, #-48]
	ldr	r2, [fp, #4]
	add	r3, r3, #2
	str	r3, [fp, #-48]
	cmp	r2, r3
	bhi	.L2229
	ldr	r6, [fp, #-56]
.L2227:
	ldr	r3, [fp, #4]
	ldr	ip, [r10, #44]
	ldr	r2, [fp, #-60]
	mul	r1, r3, r5
	ldr	r0, [r4, #-3340]
	mov	r1, r1, lsr #1
	blx	ip
	ldr	r3, [fp, #-52]
	cmp	r3, #0
	beq	.L2231
	ldr	r3, [fp, #12]
	mov	r8, #0
	str	r8, [fp, #-48]
	mov	r3, r3, lsr #1
	str	r3, [fp, #-56]
.L2232:
	cmp	r5, #0
	beq	.L2235
	ldr	r3, [fp, #-48]
	mov	r7, #0
	and	r9, r3, #7
	mov	r2, r3, lsr #3
	ldr	r3, [fp, #-56]
	mul	r2, r3, r2
	add	r9, r2, r9, lsl #8
.L2233:
	mov	r1, r7, lsr #8
	ldr	r0, [r4, #-3340]
	add	r2, r8, r7
	ldr	r3, [r10, #52]
	add	r1, r9, r1, lsl #11
	add	r0, r0, r2
	add	r1, r6, r1
	add	r7, r7, #256
	mov	r2, #256
	blx	r3
	cmp	r5, r7
	bhi	.L2233
.L2235:
	ldr	r3, [fp, #-48]
	add	r8, r8, r5
	ldr	r2, [fp, #-52]
	add	r3, r3, #1
	str	r3, [fp, #-48]
	cmp	r3, r2
	bne	.L2232
	ldr	r3, [fp, #16]
	ldr	r2, [r4, #-3340]
	cmp	r3, #1
	beq	.L2295
	ldr	r3, [fp, #16]
	cmp	r3, #0
	bne	.L2238
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-68]
	cmp	r2, r3
	bls	.L2243
.L2244:
	add	r3, r3, #2
	cmp	r2, r3
	bhi	.L2244
.L2243:
	ldr	ip, [r10, #48]
	mov	r2, #1048576
	mov	r1, #128
	ldr	r0, [r4, #-3348]
	blx	ip
	ldr	ip, [r10, #48]
	mov	r2, #1048576
	mov	r1, #128
	ldr	r0, [r4, #-3344]
	blx	ip
.L2238:
	ldr	r3, [fp, #-52]
	ldr	r2, [fp, #-64]
	ldr	r6, [fp, #-60]
	ldr	ip, [r10, #44]
	mul	r5, r3, r2
	ldr	r0, [r4, #-3344]
	mov	r2, r6
	mov	r5, r5, lsr #1
	mov	r1, r5
	blx	ip
	mov	r1, r5
	ldr	r3, [r10, #44]
	mov	r2, r6
	ldr	r0, [r4, #-3348]
	blx	r3
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2291:
	ldr	r10, .L2296+8
	ldr	r2, [fp, #-60]
	mul	r1, r1, r5
	ldr	r0, [r4, #-3340]
	ldr	r3, [r10, #44]
	blx	r3
	b	.L2209
.L2295:
	ldr	r3, [fp, #-68]
	mov	r6, #0
	ldr	lr, [fp, #-64]
	ldr	r8, [fp, #-52]
	mla	r2, r3, r5, r2
	mov	r5, r5, asl #1
	add	r7, r2, #1
.L2239:
	cmp	lr, #0
	beq	.L2242
	mov	r3, r6, lsr #1
	mov	r2, r7
	mul	r3, lr, r3
	add	ip, r3, lr
.L2240:
	ldrb	r0, [r2, #-1]
	ldr	r1, [r4, #-3348]
	strb	r0, [r1, r3]
	ldrb	r0, [r2], #2
	ldr	r1, [r4, #-3344]
	strb	r0, [r1, r3]
	add	r3, r3, #1
	cmp	r3, ip
	bne	.L2240
.L2242:
	add	r6, r6, #2
	add	r7, r7, r5
	cmp	r8, r6
	bhi	.L2239
	b	.L2238
.L2292:
	ldr	r7, [fp, #-64]
	mov	r3, #0
	ldr	r8, [fp, #-52]
	add	lr, lr, #1
	mov	r6, r3
.L2218:
	cmp	r7, #0
	moveq	ip, r3
	beq	.L2221
	add	ip, r3, r7
	mov	r2, lr
.L2219:
	ldrb	r0, [r2, #-1]
	ldr	r1, [r4, #-3348]
	strb	r0, [r1, r3]
	ldrb	r0, [r2], #2
	ldr	r1, [r4, #-3344]
	strb	r0, [r1, r3]
	add	r3, r3, #1
	cmp	r3, ip
	bne	.L2219
.L2221:
	add	r6, r6, #1
	mov	r3, ip
	cmp	r6, r8
	add	lr, lr, r5
	bne	.L2218
	b	.L2217
.L2293:
	ldr	r10, .L2296+8
	mov	r2, #1048576
	mov	r1, #128
	ldr	r0, [r4, #-3348]
	ldr	ip, [r10, #48]
	blx	ip
	ldr	r3, [r10, #48]
	mov	r2, #1048576
	mov	r1, #128
	ldr	r0, [r4, #-3344]
	blx	r3
	b	.L2217
.L2294:
	ldr	r3, [fp, #-52]
	ldr	r2, [fp, #-64]
	ldr	r7, [fp, #-60]
	ldr	r6, .L2296+8
	mul	r5, r3, r2
	ldr	r0, [r4, #-3344]
	mov	r2, r7
	ldr	r3, [r6, #44]
	mov	r1, r5
	blx	r3
	ldr	r3, [r6, #44]
	mov	r1, r5
	mov	r2, r7
	ldr	r0, [r4, #-3348]
	blx	r3
	b	.L2196
.L2231:
	ldr	r3, [fp, #16]
	cmp	r3, #1
	beq	.L2238
	cmp	r3, #0
	beq	.L2243
	b	.L2238
.L2206:
	ldr	r3, [fp, #16]
	cmp	r3, #1
	bne	.L2216
	b	.L2217
.L2297:
	.align	2
.L2296:
	.word	.LC244
	.word	.LANCHOR4
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	DBG_WriteBigTileYuv, .-DBG_WriteBigTileYuv
	.align	2
	.global	VCTRL_GetChanImage
	.type	VCTRL_GetChanImage, %function
VCTRL_GetChanImage:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #644
	sub	sp, sp, #644
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r5, r0
	mov	r2, r0
	mov	r4, r1
	mov	r0, #2
	ldr	r1, .L2356
	bl	dprint_vfmw
	cmp	r5, #15
	bhi	.L2345
	ldr	r6, .L2356+4
	ldr	r0, [r6, r5, asl #2]
	cmp	r0, #0
	beq	.L2346
	ldr	r3, [r0, #12]
	cmp	r3, #1
	bne	.L2347
	ldr	r7, .L2356+8
	mov	r0, #4
	ldr	r3, [r7, #12]
	blx	r3
	ldr	r0, [r6, r5, asl #2]
	ldr	r3, [r0, #20]
	cmp	r3, #1
	bne	.L2348
	add	r0, r0, #237568
	mov	r1, r4
	add	r0, r0, #368
	bl	SYNTAX_ReceiveImage
	sub	r9, r0, #1
	mov	r8, r0
	clz	r9, r9
	mov	r9, r9, lsr #5
	cmp	r4, #0
	moveq	r3, #0
	andne	r3, r9, #1
	cmp	r3, #0
	beq	.L2305
	ldr	r10, .L2356+12
	mov	r3, r5, asl #2
	str	r3, [fp, #-640]
	add	r3, r10, r3
	ldr	r0, [r3, #-3504]
	cmp	r0, #0
	beq	.L2306
	ldr	r3, [r4, #108]
	ldr	ip, [r10, #-3336]
	tst	r3, #28
	ldr	r3, [r4, #112]
	moveq	lr, #1
	movne	lr, #0
	cmp	ip, #0
	beq	.L2307
	ldr	ip, [r4, #308]
	ldr	r2, [r4, #480]
	ldr	r1, [r4, #472]
	str	lr, [sp, #12]
	ldr	lr, [r4, #304]
	str	ip, [sp, #28]
	ldr	ip, [r4, #300]
	str	lr, [sp, #24]
	ldr	lr, [r4, #296]
	str	ip, [sp, #20]
	ldr	ip, [r4, #140]
	str	lr, [sp, #16]
	ldr	lr, [r4, #116]
	str	ip, [sp, #8]
	mov	ip, #0
	str	ip, [sp, #4]
	str	lr, [sp]
	bl	DBG_WriteBigTileYuv
.L2306:
	ldr	r3, [fp, #-640]
	add	r10, r10, r3
	ldr	r2, [r10, #-3196]
	cmp	r2, #0
	beq	.L2305
	ldrd	r0, [r4, #232]
	orrs	r3, r0, r1
	beq	.L2305
	ldr	r3, [r4, #224]
	cmp	r3, #0
	bne	.L2349
.L2305:
	cmp	r9, #0
	bne	.L2350
.L2309:
	subs	r9, r8, #1
	mvnne	r9, #0
.L2311:
	mov	r0, #12
	bl	CHECK_REC_POS_ENABLE
	cmp	r0, #0
	bne	.L2322
.L2320:
	cmp	r9, #0
	beq	.L2323
.L2321:
	ldr	r3, [r6, r5, asl #2]
	mov	r0, #4
	ldr	r2, [r7, #16]
	add	r3, r3, #249856
	ldrb	r3, [r3, #3844]
	strb	r3, [r4, #436]
	blx	r2
.L2343:
	mov	r0, r9
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2350:
	ldr	r3, [r4, #200]
	mvn	r9, #0
	str	r9, [r4, #196]
	cmp	r3, #1
	bne	.L2309
	ldr	r2, [r4, #188]
	cmp	r2, #0
	beq	.L2351
	ldr	r0, [r4, #32]
	mov	r2, #3
	ldr	r1, [r4, #28]
	str	r9, [r4, #196]
	str	r3, [r4, #188]
	str	r0, [r4, #208]
	str	r1, [r4, #204]
	str	r2, [r4, #320]
.L2319:
	mov	r0, #12
	bl	CHECK_REC_POS_ENABLE
	cmp	r0, #0
	bne	.L2352
.L2323:
	mov	r2, #0
	mov	r1, #12
	mov	r0, r5
	mov	r9, r2
	bl	DBG_CountTimeInfo
	ldr	r2, [r4, #108]
	ldr	r3, [r6, r5, asl #2]
	str	r2, [r3, #368]
	ldr	r2, [r4, #320]
	str	r2, [r3, #372]
	b	.L2321
.L2352:
	mov	r9, #0
	mov	r8, #1
.L2322:
	ldr	r3, [r7]
	blx	r3
	ldr	r3, .L2356+12
	ldr	r1, .L2356+16
	add	r3, r3, r5, lsl #2
	ldr	r2, [r3, #-2916]
	ldr	r1, [r1]
	rsb	r2, r2, r0
	mov	ip, r0
	cmp	r2, r1
	bls	.L2320
	mov	r2, r5, asl #24
	movw	r1, #4860
	add	r2, r2, #786432
	ldr	r0, .L2356+20
	cmp	r8, #1
	addeq	r2, r2, #1
	str	ip, [r3, #-2916]
	bl	DBG_AddTrace
	b	.L2320
.L2307:
	str	r3, [fp, #-644]
	ldr	r3, [r4, #140]
	ldr	r2, [r4, #480]
	ldr	r1, [r4, #472]
	str	r3, [fp, #-648]
	str	ip, [sp, #28]
	str	ip, [sp, #24]
	str	ip, [sp, #20]
	str	ip, [sp, #16]
	str	lr, [sp, #12]
	ldr	lr, [r4, #116]
	str	ip, [sp, #4]
	ldr	ip, [fp, #-648]
	ldr	r3, [fp, #-644]
	str	lr, [sp]
	str	ip, [sp, #8]
	bl	DBG_WriteBigTileYuv
	b	.L2306
.L2347:
	ldr	r3, .L2356+24
	movw	r2, #4627
	ldr	r1, .L2356+28
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r9, #0
	b	.L2343
.L2348:
	str	r3, [sp]
	mov	r0, #0
	movw	r3, #4661
	ldr	r2, .L2356+32
	ldr	r1, .L2356+36
	mvn	r9, #0
	bl	dprint_vfmw
	ldr	r3, [r7, #16]
	mov	r0, #4
	blx	r3
	b	.L2343
.L2349:
	mov	r1, r3
	ldr	r3, [r7, #44]
	blx	r3
	b	.L2305
.L2351:
	ldr	r0, [r6, r5, asl #2]
	sub	r1, fp, #636
	str	r2, [fp, #-640]
	add	r0, r0, #237568
	ldr	r10, .L2356+4
	add	r0, r0, #368
	bl	SYNTAX_ReceiveImage
	ldr	r2, [fp, #-640]
	cmp	r0, #1
	mov	r8, r0
	bne	.L2353
	ldr	r3, [r4, #192]
	ldr	r1, [fp, #-444]
	cmp	r3, r1
	bge	.L2314
	ldr	r9, [fp, #-448]
	mov	r3, #3
	ldr	r10, [fp, #-604]
	ldr	lr, [fp, #-608]
	cmp	r9, #0
	ldr	ip, [fp, #-600]
	ldr	r0, [fp, #-596]
	movne	r9, r2
	ldr	r1, [fp, #-480]
	str	r10, [r4, #208]
	str	lr, [r4, #204]
	str	ip, [r4, #212]
	str	r0, [r4, #216]
	str	r1, [r4, #196]
	str	r3, [r4, #320]
	strne	r8, [r4, #188]
	b	.L2311
.L2345:
	ldr	r3, .L2356+40
	movw	r2, #4623
	ldr	r1, .L2356+28
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r9, #0
	b	.L2343
.L2353:
	ldr	r0, [r10, r5, asl #2]
	mov	r9, r8
	add	r0, r0, #237568
	add	r0, r0, #368
	bl	SYNTAX_ReturnImage
	ldr	r3, [r7, #16]
	mov	r0, #4
	blx	r3
	b	.L2343
.L2314:
	ldr	r0, [r10, r5, asl #2]
	bgt	.L2354
	cmp	r3, #0
	bne	.L2317
	add	r0, r0, #237568
	add	r0, r0, #368
	bl	SYNTAX_ReturnImage
	ldr	r0, [r10, r5, asl #2]
	mov	r1, r4
	add	r0, r0, #237568
	add	r0, r0, #368
	bl	SYNTAX_ReleaseImage
	mov	r0, r8
	ldr	r3, [r4, #192]
	mvn	r8, #1
	ldr	r2, .L2356+32
	ldr	r1, .L2356+44
	bl	dprint_vfmw
	b	.L2311
.L2317:
	add	r0, r0, #237568
	mov	r1, r4
	add	r0, r0, #368
	bl	SYNTAX_ReleaseImage
	ldr	r3, [fp, #-448]
	cmp	r3, #0
	beq	.L2355
	ldr	r3, [r4, #192]
	mov	r0, r8
	ldr	r2, .L2356+32
	ldr	r1, .L2356+48
	bl	dprint_vfmw
	sub	r1, fp, #636
	ldr	r3, [r7, #52]
	mov	r2, #592
	mov	r0, r4
	blx	r3
	ldr	r1, [fp, #-604]
	ldr	r2, [fp, #-608]
	mov	r3, #3
	str	r9, [r4, #196]
	str	r8, [r4, #188]
	str	r1, [r4, #208]
	str	r2, [r4, #204]
	str	r3, [r4, #320]
	b	.L2319
.L2346:
	ldr	r3, .L2356+52
	movw	r2, #4624
	ldr	r1, .L2356+28
	mvn	r9, #0
	bl	dprint_vfmw
	b	.L2343
.L2354:
	add	r0, r0, #237568
	add	r0, r0, #368
	bl	SYNTAX_ReturnImage
	ldr	r0, [r10, r5, asl #2]
	mov	r1, r4
	add	r0, r0, #237568
	add	r0, r0, #368
	bl	SYNTAX_ReleaseImage
	ldr	ip, [fp, #-444]
	ldr	r3, [r4, #192]
	mov	r0, r8
	ldr	r2, .L2356+32
	mvn	r8, #1
	ldr	r1, .L2356+56
	str	ip, [sp]
	bl	dprint_vfmw
	b	.L2311
.L2355:
	ldr	r0, [r10, r5, asl #2]
	sub	r1, fp, #636
	add	r0, r0, #237568
	add	r0, r0, #368
	bl	SYNTAX_ReleaseImage
	mov	r0, r8
	ldr	r3, [r4, #192]
	mvn	r8, #1
	ldr	r2, .L2356+32
	ldr	r1, .L2356+48
	bl	dprint_vfmw
	b	.L2311
.L2357:
	.align	2
.L2356:
	.word	.LC245
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR4
	.word	g_TraceImgPeriod
	.word	.LANCHOR1+372
	.word	.LC46
	.word	.LC1
	.word	.LANCHOR1+352
	.word	.LC246
	.word	.LC20
	.word	.LC248
	.word	.LC249
	.word	.LC2
	.word	.LC247
	.fnend
	.size	VCTRL_GetChanImage, .-VCTRL_GetChanImage
	.align	2
	.global	VCTRL_GetImageWidth
	.type	VCTRL_GetImageWidth, %function
VCTRL_GetImageWidth:
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
	ldr	r3, .L2367
	ldr	r0, [r3, r0, asl #2]
	add	r0, r0, #237568
	ldr	r3, [r0, #368]
	cmp	r3, #2
	beq	.L2360
	cmp	r3, #16
	beq	.L2361
	cmp	r3, #0
	beq	.L2366
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L2366:
	add	r0, r0, #376
	bl	H264DEC_GetImageWidth
	ldmfd	sp, {fp, sp, pc}
.L2361:
	add	r0, r0, #376
	bl	HEVCDEC_GetImageWidth
	ldmfd	sp, {fp, sp, pc}
.L2360:
	add	r0, r0, #376
	bl	MPEG4DEC_GetImageWidth
	ldmfd	sp, {fp, sp, pc}
.L2368:
	.align	2
.L2367:
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_GetImageWidth, .-VCTRL_GetImageWidth
	.align	2
	.global	VCTRL_GetImageHeight
	.type	VCTRL_GetImageHeight, %function
VCTRL_GetImageHeight:
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
	ldr	r3, .L2378
	ldr	r0, [r3, r0, asl #2]
	add	r0, r0, #237568
	ldr	r3, [r0, #368]
	cmp	r3, #2
	beq	.L2371
	cmp	r3, #16
	beq	.L2372
	cmp	r3, #0
	beq	.L2377
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L2377:
	add	r0, r0, #376
	bl	H264DEC_GetImageHeight
	ldmfd	sp, {fp, sp, pc}
.L2372:
	add	r0, r0, #376
	bl	HEVCDEC_GetImageHeight
	ldmfd	sp, {fp, sp, pc}
.L2371:
	add	r0, r0, #376
	bl	MPEG4DEC_GetImageHeight
	ldmfd	sp, {fp, sp, pc}
.L2379:
	.align	2
.L2378:
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_GetImageHeight, .-VCTRL_GetImageHeight
	.align	2
	.global	VCTRL_GetFsSize
	.type	VCTRL_GetFsSize, %function
VCTRL_GetFsSize:
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
	ldr	r3, .L2385
	mov	r4, r0
	ldr	r6, .L2385+4
	ldr	r5, [r3, #40]
	cmp	r5, #0
	beq	.L2381
	ldr	ip, [r6, r0, asl #2]
	mov	r3, #0
	str	r3, [sp, #4]
	add	ip, ip, #237568
	ldr	ip, [ip, #368]
	str	ip, [sp]
	blx	r5
.L2381:
	ldr	r3, [r6, r4, asl #2]
	add	r3, r3, #233472
	ldr	r0, [r3, #3864]
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L2386:
	.align	2
.L2385:
	.word	g_vdm_hal_fun_ptr
	.word	.LANCHOR0
	.fnend
	.size	VCTRL_GetFsSize, .-VCTRL_GetFsSize
	.global	s_VfmwSavePath
	.global	g_DnrIrqHandle
	.global	g_VdecIrqHandle
	.global	g_StopDec
	.global	g_DnrSleepTime
	.global	g_SleepTime
	.global	MemRecord_YUV
	.global	pVl
	.global	pUl
	.global	pY
	.global	g_u32DFSMaxAllocTime
	.global	pOption
	.global	g_eVdmVersion
	.global	g_VdmCharacter
	.global	g_CurProcChan
	.global	g_ResetCreateNewSave
	.global	save_yuv_with_crop
	.global	save_yuv_chan_num
	.global	save_el_chan_num
	.global	vfmw_save_el_file
	.global	save_metadata_reorder_chan_num
	.global	vfmw_save_metadata_reorder_file
	.global	save_metadata_chan_num
	.global	vfmw_save_metadata_file
	.global	vfmw_save_yuv_file
	.global	save_seg_chan_num
	.global	vfmw_save_seg_file
	.global	save_str_chan_num
	.global	vfmw_save_str_file
	.global	g_apple_airplay_mirrorinig_flag
	.global	g_not_allow_H264FullPictureRepair_flag
	.global	g_not_direct_8x8_inference_flag
	.global	g_allow_B_before_P
	.global	extra_cmd
	.global	extra_disp
	.global	extra_ref
	.global	g_VfmwGlobalStat
	.global	g_VfmwChanStat
	.global	s_pstVfmwChan
	.global	AcceleratorCharacter
	.global	g_event_report
	.global	g_SdecFunc
	.global	g_SCDID
	.global	g_DSPState
	.global	mask_mmu_err_int
	.section	.rodata
	.align	2
.LANCHOR1 = . + 0
	.type	__func__.55233, %object
	.size	__func__.55233, 18
__func__.55233:
	.ascii	"VCTRL_EventReport\000"
	.space	2
	.type	__func__.55245, %object
	.size	__func__.55245, 18
__func__.55245:
	.ascii	"VCTRL_SetCallBack\000"
	.space	2
	.type	__FUNCTION__.55339, %object
	.size	__FUNCTION__.55339, 29
__FUNCTION__.55339:
	.ascii	"VCTRL_PartitionMemForStdUser\000"
	.space	3
	.type	__func__.55363, %object
	.size	__func__.55363, 23
__func__.55363:
	.ascii	"VCTRL_FreeChanResource\000"
	.space	1
	.type	__FUNCTION__.55642, %object
	.size	__FUNCTION__.55642, 23
__FUNCTION__.55642:
	.ascii	"VCTRL_ReleaseChanImage\000"
	.space	1
	.type	__func__.55643, %object
	.size	__func__.55643, 23
__func__.55643:
	.ascii	"VCTRL_ReleaseChanImage\000"
	.space	1
	.type	__func__.55671, %object
	.size	__func__.55671, 18
__func__.55671:
	.ascii	"VCTRL_GetDecParam\000"
	.space	2
	.type	__FUNCTION__.55720, %object
	.size	__FUNCTION__.55720, 19
__FUNCTION__.55720:
	.ascii	"VCTRL_FlushDecoder\000"
	.space	1
	.type	__FUNCTION__.56057, %object
	.size	__FUNCTION__.56057, 18
__FUNCTION__.56057:
	.ascii	"GetExtraRefFrmNum\000"
	.space	2
	.type	__FUNCTION__.56063, %object
	.size	__FUNCTION__.56063, 19
__FUNCTION__.56063:
	.ascii	"GetExtraDispFrmNum\000"
	.space	1
	.type	__FUNCTION__.56069, %object
	.size	__FUNCTION__.56069, 16
__FUNCTION__.56069:
	.ascii	"GetExtraCtrlCmd\000"
	.type	__FUNCTION__.55987, %object
	.size	__FUNCTION__.55987, 14
__FUNCTION__.55987:
	.ascii	"DecChanSyntax\000"
	.space	2
	.type	__func__.55556, %object
	.size	__func__.55556, 24
__func__.55556:
	.ascii	"VCTRL_FindOccupiedFrame\000"
	.type	__func__.55580, %object
	.size	__func__.55580, 26
__func__.55580:
	.ascii	"VCTRL_ReportOccupiedFrame\000"
	.space	2
	.type	__func__.56047, %object
	.size	__func__.56047, 24
__func__.56047:
	.ascii	"VCTRL_ExtAccGetDecParam\000"
	.type	__func__.55504, %object
	.size	__func__.55504, 17
__func__.55504:
	.ascii	"VCTRL_ConfigChan\000"
	.space	3
	.type	__func__.55624, %object
	.size	__func__.55624, 19
__func__.55624:
	.ascii	"VCTRL_GetChanImage\000"
	.space	1
	.type	__FUNCTION__.55632, %object
	.size	__FUNCTION__.55632, 19
__FUNCTION__.55632:
	.ascii	"VCTRL_GetChanImage\000"
	.data
	.align	2
.LANCHOR3 = . + 0
	.type	g_not_direct_8x8_inference_flag, %object
	.size	g_not_direct_8x8_inference_flag, 1
g_not_direct_8x8_inference_flag:
	.byte	1
	.space	3
	.type	s_VfmwSavePath, %object
	.size	s_VfmwSavePath, 64
s_VfmwSavePath:
	.byte	47
	.byte	109
	.byte	110
	.byte	116
	.byte	0
	.space	59
	.type	save_yuv_chan_num, %object
	.size	save_yuv_chan_num, 4
save_yuv_chan_num:
	.word	-1
	.type	mask_mmu_err_int, %object
	.size	mask_mmu_err_int, 4
mask_mmu_err_int:
	.word	1
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"InstID out of range\000"
.LC1:
	.ascii	"vfmw_ctrl.c,L%d: %s\012\000"
	.space	3
.LC2:
	.ascii	"Chan inactive\000"
	.space	2
.LC3:
	.ascii	"s_VfmwCTrl.event_report_vdec = NULL\012\000"
	.space	3
.LC4:
	.ascii	"s_VfmwCTrl.event_report_omxvdec = NULL\012\000"
.LC5:
	.ascii	"%s Unkown Adapter Type: %d, Len: %d\012\000"
	.space	3
.LC6:
	.ascii	"pfun_iMediaSoftDEC_Create\000"
	.space	2
.LC7:
	.ascii	"register soft decoder fail: '%s' can not be NULL\012"
	.ascii	"\000"
	.space	2
.LC8:
	.ascii	"pfun_iMediaSoftDEC_Destroy\000"
	.space	1
.LC9:
	.ascii	"pfun_iMediaSoftDEC_Init\000"
.LC10:
	.ascii	"pfun_iMediaSoftDEC_Decode\000"
	.space	2
.LC11:
	.ascii	"pfun_iMediaSoftDEC_RecycleImage\000"
.LC12:
	.ascii	"pfun_iMediaSoftDEC_GetRemainImg\000"
.LC13:
	.ascii	"pfun_iMediaSoftDEC_GetImageBuffer\000"
	.space	2
.LC14:
	.ascii	"Force vdm %d sleep.\012\000"
	.space	3
.LC15:
	.ascii	"VDMHAL_NULL_FUN_PRINT,L%d\012\000"
	.space	1
.LC16:
	.ascii	"Vfmw suspend totally take %d ms\012\000"
	.space	3
.LC17:
	.ascii	"Wait sleep time out %d ms (isScdSleep=%d, isVdmSlee"
	.ascii	"p=%d)!\012\000"
	.space	1
.LC18:
	.ascii	"Force scd %d sleep.\012\000"
	.space	3
.LC19:
	.ascii	"Vfmw resume totally take %d ms\012\000"
.LC20:
	.ascii	"ChanID out of range\000"
.LC21:
	.ascii	"can NOT config a not-opened Chan\000"
	.space	3
.LC22:
	.ascii	"event_report null!\000"
	.space	1
.LC23:
	.ascii	"%s Unkown Adapter Type: %d\012\000"
.LC24:
	.ascii	"pstStreamParam is NULL\000"
	.space	1
.LC25:
	.ascii	"L: %d, Stream Interface Error!!, ChanID: %d\012\000"
	.space	3
.LC26:
	.ascii	"pstStreamIntf is NULL\000"
	.space	2
.LC27:
	.ascii	"This Chan has not been created!!!\000"
	.space	2
.LC28:
	.ascii	"can NOT get a not-opened Chan's information of bits"
	.ascii	"tream\000"
	.space	3
.LC29:
	.ascii	"pArgs is null\000"
	.space	2
.LC30:
	.ascii	"image size abnormal(%dx%d)\012\000"
.LC31:
	.ascii	"no mem to arrange for soft dec\012\000"
.LC32:
	.ascii	"partition fs memory fail!\012\000"
	.space	1
.LC33:
	.ascii	"%s: L%d : vdm chan memory is too small to support u"
	.ascii	"ser decoder\012\000"
.LC34:
	.ascii	"FSP_ConfigInstance fail!\012\000"
	.space	2
.LC35:
	.ascii	"parameter err, null pointer!!!\000"
	.space	1
.LC36:
	.ascii	"%s FATAL: pstChan = NULL!\012\000"
	.space	1
.LC37:
	.ascii	"%s FATAL: pChanMem_vdh = NULL!\012\000"
.LC38:
	.ascii	"%s FATAL: pChanMem_frm = NULL!\012\000"
.LC39:
	.ascii	"DelAllFrameMemRecord err in VCTRL_FreeChanResource "
	.ascii	"!\012\000"
	.space	2
.LC40:
	.ascii	"%s FATAL: pChanMem_scd = NULL!\012\000"
.LC41:
	.ascii	"%s FATAL: pChanMem_dsp = NULL!\012\000"
.LC42:
	.ascii	"%s FATAL: pChanMem_ctx = NULL!\012\000"
.LC43:
	.ascii	"pstCfg is null\000"
	.space	1
.LC44:
	.ascii	"create soft-decoder fail!\012\000"
	.space	1
.LC45:
	.ascii	"Chip not support beyond %dx%d when Std != H264/VP8/"
	.ascii	"MVC/USER.\012\000"
	.space	2
.LC46:
	.ascii	"This channel is not opened\000"
	.space	1
.LC47:
	.ascii	"pImage is NULL\000"
	.space	1
.LC48:
	.ascii	"call VCTRL_ReleaseChanImage, ChanID, ImgID = %d,%d\012"
	.ascii	"\000"
.LC49:
	.ascii	"vdm_ctrl.c,L%d: Chan inactive\012\000"
	.space	1
.LC50:
	.ascii	"vdm_ctrl.c,L%d: This channel is not opened\012\000"
.LC51:
	.ascii	"vdm_ctrl.c,L%d: VCTRL_TryToRelSpecialFrm success!\012"
	.ascii	"\000"
	.space	1
.LC52:
	.ascii	"%s call SYNTAX_ReleaseImage failed\012\000"
.LC53:
	.ascii	"vfmw_ctrl.c, line %d: ChanID out of range\012\000"
	.space	1
.LC54:
	.ascii	"vfmw_ctrl.c, line %d: Chan %d is not open or not ru"
	.ascii	"nning\012\000"
	.space	2
.LC55:
	.ascii	"vfmw_ctrl.c, line %d: ChanID out of range is %d\012"
	.ascii	"\000"
	.space	3
.LC56:
	.ascii	"%s VidStd=%d Error!\012\000"
	.space	3
.LC57:
	.ascii	"Chan %d is not open or not running\012\000"
.LC58:
	.ascii	"line: %d Flush DPB failed!\012\000"
.LC59:
	.ascii	"VCTRL_FlushDecoder\012\000"
.LC60:
	.ascii	"fuction return value is null,%s %d MVC_OK != MVC_Fl"
	.ascii	"ushDPB!!\012\000"
	.space	3
.LC61:
	.ascii	"ChanId out of range\000"
.LC62:
	.ascii	"This channel is not running\000"
.LC63:
	.ascii	"chan not create\000"
.LC64:
	.ascii	"can NOT start a not-opened Chan\000"
.LC65:
	.ascii	"NULL == pArgs\000"
	.space	2
.LC66:
	.ascii	"-1 == VCTRL_GetChanIDByCtx() Err! \012\000"
.LC67:
	.ascii	"VCTRL_GetUsrdecFrame but VFMW_USER != s_pstVfmwChan"
	.ascii	"[ChanID]->eVidStd!\012\000"
	.space	1
.LC68:
	.ascii	"VCTRL_GetUsrdecFrame but s_pstVfmwChan[ChanID]->s32"
	.ascii	"UsrdecFrameNum < MIN_USERDEC_FRAME_NUM!\012\000"
.LC69:
	.ascii	"get frame store fail!\012\000"
	.space	1
.LC70:
	.ascii	"get image buffer ok: LogicFsID = %d\012\000"
	.space	3
.LC71:
	.ascii	"line: %d, pLf is NULL!\012\000"
.LC72:
	.ascii	"decode %p, disp %p, tf %p\012\000"
	.space	1
.LC73:
	.ascii	"VCTRL_GetUsrdecFrame get LogicFs fail!\012\000"
.LC74:
	.ascii	"ERROR: s32MaxRefFrameNum(%d), extra_ref(%d), s32Dis"
	.ascii	"playFrameNum(%d), extra_disp(%d)\012\000"
	.space	3
.LC75:
	.ascii	"ERROR: (MaxRefFrameNum(%d) + extra_ref(%d)) > 16\012"
	.ascii	"\000"
	.space	2
.LC76:
	.ascii	"VDEC_CID_GET_CHAN_DETAIL_MEMSIZE_BY_OPTION is desig"
	.ascii	"ned for CAP_LEVEL_USER_DEFINE_WITH_OPTION, please c"
	.ascii	"hange channel's capability or use VDEC_CID_GET_CHAN"
	.ascii	"_MEMSIZE.\012\000"
.LC77:
	.ascii	"CAP_LEVEL_USER_DEFINE_WITH_OPTION option is illegal"
	.ascii	".\012\000"
	.space	2
.LC78:
	.ascii	"VCTRL_GetChanMemSizeByOption L%d: arrange return fa"
	.ascii	"ilure\012\000"
	.space	2
.LC79:
	.ascii	"ERROR: (nPmv(%d) + extra_ref(%d)) <= 0\012\000"
.LC80:
	.ascii	"ERROR: TempMinFrame(%d + %d + %d), TempMiddleFrame("
	.ascii	"%d + %d + %d), TempFluentFrame(%d + %d + %d)\012\000"
	.space	3
.LC81:
	.ascii	"VCTRL_GetChanMemSize L%d: arrange return failure\012"
	.ascii	"\000"
	.space	2
.LC82:
	.ascii	"MEM_MapRegisterAddr reg 0x%x failed!\012\000"
	.space	2
.LC83:
	.ascii	"VDMHAL_OpenHAL Vdh %d failed!\012\000"
	.space	1
.LC84:
	.ascii	"VDMHAL_OpenHAL Scd %d failed!\012\000"
	.space	1
.LC85:
	.ascii	"VFMW_Hal_%d\000"
.LC86:
	.ascii	"VDMHAL_GetHalMemSize Vdh %d failed!\012\000"
	.space	3
.LC87:
	.ascii	"MEM_AllocMemBlock Vdh %d failed!\012\000"
	.space	2
.LC88:
	.ascii	"VFMW_VP9Prob_%d\000"
.LC89:
	.ascii	"VFMW_ScdMsg_%d\000"
	.space	1
.LC90:
	.ascii	"MEM_AllocMemBlock VFMW_VP9Prob %d failed!\012\000"
	.space	1
.LC91:
	.ascii	"SM_OpenSCDDrv Scd %d failed!\012\000"
	.space	2
.LC92:
	.ascii	"MEM_AllocMemBlock Scd %d failed!\012\000"
	.space	2
.LC93:
	.ascii	"hi_vdec_vdh_irq\000"
.LC94:
	.ascii	"Register irq %d failed!\012\000"
	.space	3
.LC95:
	.ascii	"hi_vdec_scd_irq\000"
.LC96:
	.ascii	"hi_vdec_vdh_mmu_irq\000"
.LC97:
	.ascii	"extra_ref=\000"
	.space	1
.LC98:
	.ascii	"=\000"
	.space	2
.LC99:
	.ascii	" \000"
	.space	2
.LC100:
	.ascii	"fuction return value is null,%s %d unknow error!!\012"
	.ascii	"\000"
	.space	1
.LC101:
	.ascii	"ERROR: extra_ref = %d is out of [ -5000, 5000 ]!\012"
	.ascii	"\000"
	.space	2
.LC102:
	.ascii	"extra_disp=\000"
.LC103:
	.ascii	"ERROR: extra_disp = %d is out of [ -5000, 5000 ]!\012"
	.ascii	"\000"
	.space	1
.LC104:
	.ascii	"extra_cmd=\000"
	.space	1
.LC105:
	.ascii	"HI_VFMW_VideoDecode\000"
.LC106:
	.ascii	"(safe,warn,danger) :amount = %d,%d,%d,%d\012\000"
	.space	2
.LC107:
	.ascii	"strm_ctrl: I->IPB\012\000"
	.space	1
.LC108:
	.ascii	"strm_ctrl: IPB->I\012\000"
	.space	1
.LC109:
	.ascii	"(CurrMode,NextMode) = %d,%d\012\000"
	.space	3
.LC110:
	.ascii	"Syntax is stopped from This channel\000"
.LC111:
	.ascii	"[%d] vdm busy\012\000"
	.space	1
.LC112:
	.ascii	"[%d] no frame\012\000"
	.space	1
.LC113:
	.ascii	"[%d] no stream\012\000"
.LC114:
	.ascii	"seg_pts: %lld, seg_usertag = %lld\012\000"
	.space	1
.LC115:
	.ascii	"pic_pts: %lld\012\000"
	.space	1
.LC116:
	.ascii	"pic_usertag: %lld\012\000"
	.space	1
.LC117:
	.ascii	"pic_pts: %lld pic_usertag = %lld\012\000"
	.space	2
.LC118:
	.ascii	"%s:ChanId %d this hevc file is 10bit!!!\012\000"
	.space	3
.LC119:
	.ascii	"DFS, Wait Partition\012\000"
	.space	3
.LC120:
	.ascii	"DFS, Partition fail, u32DynamicFrameStoreAllocEn: %"
	.ascii	"d, eFspPartitionState: %d\012\000"
	.space	2
.LC121:
	.ascii	"Thread running...\012\000"
	.space	1
.LC122:
	.ascii	"Thread stopped!\012\000"
	.space	3
.LC123:
	.ascii	"thread running...\012\000"
	.space	1
.LC124:
	.ascii	"thread stopped...\012\000"
	.space	1
.LC125:
	.ascii	"Thread killed!\012\000"
.LC126:
	.ascii	"ERROR:ReadNum = %d larger than VFMW_MAX_RESERVE_NUM"
	.ascii	"(%d)\012\000"
	.space	3
.LC127:
	.ascii	"%s,%d,specialFrmRec[%d]->PhyAddr = 0x%x,VirAddr = 0"
	.ascii	"x%x,Length = %d\012\000"
.LC128:
	.ascii	"pSpecialFrmInfo = null!!!\000"
	.space	2
.LC129:
	.ascii	"ChanID out of range!\000"
	.space	3
.LC130:
	.ascii	"SetVdecExtra ERROR: extra_ref = %d is out of [ -500"
	.ascii	"0, 5000 ]!\012\000"
	.space	1
.LC131:
	.ascii	"SetVdecExtra ERROR: extra_disp = %d is out of [ -50"
	.ascii	"00, 5000 ]!\012\000"
.LC132:
	.ascii	"%s 1 The channel %d is not active\012\000"
	.space	1
.LC133:
	.ascii	"The channel %d is deced\012\000"
	.space	3
.LC134:
	.ascii	"The pDecParam of channel %d is NULL\012\000"
	.space	3
.LC135:
	.ascii	"%s 2 The channel %d is not active\012\000"
	.space	1
.LC136:
	.ascii	"Chan %d Report Last Frame, Value=%d, LastFrameState"
	.ascii	"=%d\012\000"
.LC137:
	.ascii	"Last frame output failed!\012\000"
	.space	1
.LC138:
	.ascii	"Last frame output successed!\012\000"
	.space	2
.LC139:
	.ascii	"Last frame already output, image id: %d!\012\000"
	.space	2
.LC140:
	.ascii	"line %d can not know YuvFormat = %d\012\000"
	.space	3
.LC141:
	.ascii	"userdec frame(phy=%#x) address error!\012\000"
	.space	1
.LC142:
	.ascii	"can not map vir addr for usrdat frame(cbphy=%#x)\012"
	.ascii	"\000"
	.space	2
.LC143:
	.ascii	"line: %d, pLogic is Null!\012\000"
	.space	1
.LC144:
	.ascii	"eYuvFormat %d is not support!!\012\000"
.LC145:
	.ascii	"pUsrdecFrame == NULL\000"
	.space	3
.LC146:
	.ascii	"VCTRL_PutUsrdecFrame: VidStd is %d\012\000"
.LC147:
	.ascii	"VCTRL_PutUsrdecFrame return err\012\000"
	.space	3
.LC148:
	.ascii	"L:%d ChanID out of range\012\000"
	.space	2
.LC149:
	.ascii	"L:%d This Chan has not been created!!!\012\000"
.LC150:
	.ascii	"L:%d WARNING: vidio std not setted!\012\000"
	.space	3
.LC151:
	.ascii	"WARNING: vidio std not setted!\000"
	.space	1
.LC152:
	.ascii	"This Chan has not been created or has been destroye"
	.ascii	"d !\000"
	.space	1
.LC153:
	.ascii	"VCTRL_StopChanWithCheck fail!\012\000"
	.space	1
.LC154:
	.ascii	"---------------------------------------------------"
	.ascii	"----------------------\012\000"
	.space	1
.LC155:
	.ascii	"VDEC_CID_CREATE_CHAN_WITH_OPTION is designed for CA"
	.ascii	"P_LEVEL_USER_DEFINE_WITH_OPTION, please change chan"
	.ascii	"nel's capability.\012\000"
	.space	3
.LC156:
	.ascii	"line %d VCTRL_GetChanMemSizeWithOption failed!\012\000"
.LC157:
	.ascii	"VFMW_Chan_Ctx\000"
	.space	2
.LC158:
	.ascii	"L: %d : part we can NOT alloc buffer for channel co"
	.ascii	"ntext\012\000"
	.space	2
.LC159:
	.ascii	"L: %d : can NOT alloc buffer for channel context\012"
	.ascii	"\000"
	.space	2
.LC160:
	.ascii	"VFMW_Chan_Vdh\000"
	.space	2
.LC161:
	.ascii	"L: %d : can NOT alloc buffer for channel vdh\012\000"
	.space	2
.LC162:
	.ascii	"L: %d : can NOT alloc buffer for channel vdh, %#x <"
	.ascii	" %#x\012\000"
	.space	3
.LC163:
	.ascii	"VFMW_Chan_Scd\000"
	.space	2
.LC164:
	.ascii	"L: %d : can NOT alloc buffer for channel scd\012\000"
	.space	2
.LC165:
	.ascii	"L: %d : can NOT alloc buffer for SCD\012\000"
	.space	2
.LC166:
	.ascii	"can NOT enable FSP instance\012\000"
	.space	3
.LC167:
	.ascii	"vfmw have max(%d) channels opened, can NOT create m"
	.ascii	"ore channels\012\000"
	.space	3
.LC168:
	.ascii	"VCTRL_CreateChan eCapLevel = %d error! Try to use V"
	.ascii	"CTRL_CreateChanWithOption(CAP_LEVEL_USER_DEFINE_WIT"
	.ascii	"H_OPTION, ...)\012\000"
	.space	2
.LC169:
	.ascii	"VCTRL_GetChanMemSize ERROR\012\000"
.LC170:
	.ascii	"channel memory have been allocated outside, but the"
	.ascii	" mem-info is not correct!\012\000"
	.space	2
.LC171:
	.ascii	"mem-info(phy, vir, size) = (%#x, %x, %d)\012\000"
	.space	2
.LC172:
	.ascii	"this channel totally need %d bytes memory\012\000"
	.space	1
.LC173:
	.ascii	"VCTRL_CheckChanWH return err.\012\000"
	.space	1
.LC174:
	.ascii	"VFMW didn't support std %d.\012\000"
	.space	3
.LC175:
	.ascii	"VCTRL_ConfigChan with same config paramater.\012\000"
	.space	2
.LC176:
	.ascii	"%s %d: s_pstVfmwChan has been destroyed!!\012\000"
	.space	1
.LC177:
	.ascii	"====== Fatal Error0: can NOT re-map vir address for"
	.ascii	" channel %d ======\012\000"
	.space	1
.LC178:
	.ascii	"fatal error: can not del mem record(phy=0x%x,vir=%p"
	.ascii	",len=%d)\012\000"
	.space	3
.LC179:
	.ascii	"can NOT VCTRL_PartitionMemForStdUser\012\000"
	.space	2
.LC180:
	.ascii	"chan %d: new ChanErrThr = %d\012\000"
	.space	2
.LC181:
	.ascii	"chan %d: new DecOrderOutput = %d\012\000"
	.space	2
.LC182:
	.ascii	"chan %d: new DecMode = %d\012\000"
	.space	1
.LC183:
	.ascii	"chan %d: GetChanCfg failed!\012\000"
	.space	3
.LC184:
	.ascii	"chan %d: new StrmOFThr = %d\012\000"
	.space	3
.LC185:
	.ascii	"USE_FF_APT_EN = %d\012\000"
.LC186:
	.ascii	"USE_FF_APT_EN can NOT be set to %d, must be 0 or 1\012"
	.ascii	"\000"
.LC187:
	.ascii	"ResetCreateNewSave = %d\012\000"
	.space	3
.LC188:
	.ascii	"ResetCreateNewSave can NOT be set to %d, must be 0 "
	.ascii	"or 1\012\000"
	.space	3
.LC189:
	.ascii	"NO SUCH CHANNEL : %d\012\000"
	.space	2
.LC190:
	.ascii	"Pay attention to  CHANNEL : %d\012\000"
.LC191:
	.ascii	"print memory tracer...\012\000"
.LC192:
	.ascii	"%s/vfmw_raw_save_%d.dat\000"
.LC193:
	.ascii	"OK create file '%s' for channel %d raw stream save\012"
	.ascii	"\000"
.LC194:
	.ascii	"failed create file '%s' for raw stream save!\012\000"
	.space	2
.LC195:
	.ascii	">>>> close raw stream saving >>>>\012\000"
	.space	1
.LC196:
	.ascii	"%s/vfmw_seg_save_%d.dat\000"
.LC197:
	.ascii	"OK create file '%s' for channel %d seg stream save\012"
	.ascii	"\000"
.LC198:
	.ascii	"failed create file '%s' for seg stream save!\012\000"
	.space	2
.LC199:
	.ascii	">>>> close seg stream saving >>>>\012\000"
	.space	1
.LC200:
	.ascii	"%s/vfmw_yuv_save_%d.yuv\000"
.LC201:
	.ascii	"VFMW_BigTile1d_YUV\000"
	.space	1
.LC202:
	.ascii	"Failed Alloc VFMW_BigTile1d_YUV for yuv save!\012\000"
	.space	1
.LC203:
	.ascii	"OK create file '%s' for chan %d yuv save.(crop %d)\012"
	.ascii	"\000"
.LC204:
	.ascii	"failed create file '%s' for yuv save!\012\000"
	.space	1
.LC205:
	.ascii	"OK close yuv save.\012\000"
.LC206:
	.ascii	"address '0x%x' is not valid!\012\000"
	.space	2
.LC207:
	.ascii	"%s/2d_0x%x.yuv\000"
	.space	1
.LC208:
	.ascii	"2d image has been saved to '%s'\012\000"
	.space	3
.LC209:
	.ascii	"open file '%s' fail!\012\000"
	.space	2
.LC210:
	.ascii	"%s/1d_0x%x.yuv\000"
	.space	1
.LC211:
	.ascii	"1d image has been saved to '%s'\012\000"
	.space	3
.LC212:
	.ascii	"%s/vfmw_metadata_save_%d.dat\000"
	.space	3
.LC213:
	.ascii	"OK create file '%s' for channel %d metadata stream "
	.ascii	"save\012\000"
	.space	3
.LC214:
	.ascii	"failed create file '%s' for metadata stream save!\012"
	.ascii	"\000"
	.space	1
.LC215:
	.ascii	">>>> close metadata stream saving >>>>\012\000"
.LC216:
	.ascii	"%s/vfmw_metadata_reorder_save_%d.dat\000"
	.space	3
.LC217:
	.ascii	"OK create file '%s' for channel %d metadata_reorder"
	.ascii	" stream save\012\000"
	.space	3
.LC218:
	.ascii	"failed create file '%s' for metadata_reorder stream"
	.ascii	" save!\012\000"
	.space	1
.LC219:
	.ascii	"%s/vfmw_el_save_%d.dat\000"
	.space	1
.LC220:
	.ascii	"OK create file '%s' for channel %d el stream save\012"
	.ascii	"\000"
	.space	1
.LC221:
	.ascii	"failed create file '%s' for el stream save!\012\000"
	.space	3
.LC222:
	.ascii	">>>> close el stream saving >>>>\012\000"
	.space	2
.LC223:
	.ascii	"stop chan %d: VCTRL_StopChan return %d\012\000"
.LC224:
	.ascii	"reset chan %d: VCTRL_ResetChan return %d\012\000"
	.space	2
.LC225:
	.ascii	"start chan %d: VCTRL_StartChan return %d\012\000"
	.space	2
.LC226:
	.ascii	"------ dec task delay %d ms ------\012\000"
.LC227:
	.ascii	"------ dnr active per %d ms ------\012\000"
.LC228:
	.ascii	"------ dec stop = %d ------\012\000"
	.space	3
.LC229:
	.ascii	"------ g_TraceCtrl = %x ------\012\000"
.LC230:
	.ascii	"------ g_TraceBsPeriod = %x ------\012\000"
.LC231:
	.ascii	"------ g_TraceFramePeriod = %x ------\012\000"
	.space	1
.LC232:
	.ascii	"------ g_TraceImgPeriod = %x ------\012\000"
	.space	3
.LC233:
	.ascii	"The channel number is to Large.\012\000"
	.space	3
.LC234:
	.ascii	"------ s_pstVfmwChan[%d]->stSynExtraData.s32ModuleL"
	.ascii	"owlyEnable = 1 ------\012\000"
	.space	2
.LC235:
	.ascii	"------ Set SCD[%d] to work  ------\012\000"
.LC236:
	.ascii	"unmask vfmw mmu err int!\012\000"
	.space	2
.LC237:
	.ascii	"mask vfmw mmu err int!\012\000"
.LC238:
	.ascii	"vdm_ctrl.c,L%d: pOption->s32KeepBS error\012\000"
	.space	2
.LC239:
	.ascii	"vdm_ctrl.c,L%d: %s\012\000"
.LC240:
	.ascii	"This Chan has not been created or has been destroye"
	.ascii	"d !!!\000"
	.space	3
.LC241:
	.ascii	"can NOT stop a not-opened Chan\000"
	.space	1
.LC242:
	.ascii	"WARNNING: dsp in lowdelay state, we can not support"
	.ascii	"ed  avs in the same time!!!\012\000"
.LC243:
	.ascii	"WARNNING: dsp in avs state, we can not supported  l"
	.ascii	"owdelay in the same time!!!\012\000"
.LC244:
	.ascii	"VFMW: WriteBigTileYuv %dx%d...\012\000"
.LC245:
	.ascii	"call VCTRL_GetChanImage, ChanID = %d,\012\000"
	.space	1
.LC246:
	.ascii	"%s,%d,ImgOutputEn = %d, should not be output!\012\000"
	.space	1
.LC247:
	.ascii	"%s: view_0 id(%d) > view_1 id(%d), error!\012\000"
	.space	1
.LC248:
	.ascii	"%s: continuous view0 id(%d)!\012\000"
	.space	2
.LC249:
	.ascii	"%s: continuous view1 id(%d)!\012\000"
	.bss
	.align	3
.LANCHOR0 = . + 0
.LANCHOR2 = . + 8184
.LANCHOR4 = . + 16368
	.type	s_pstVfmwChan, %object
	.size	s_pstVfmwChan, 64
s_pstVfmwChan:
	.space	64
	.type	s_VfmwCTrl, %object
	.size	s_VfmwCTrl, 272
s_VfmwCTrl:
	.space	272
	.type	g_SdecFunc, %object
	.size	g_SdecFunc, 28
g_SdecFunc:
	.space	28
	.type	LastEventTime.55211, %object
	.size	LastEventTime.55211, 4
LastEventTime.55211:
	.space	4
	.type	s_StreamIntf, %object
	.size	s_StreamIntf, 192
s_StreamIntf:
	.space	192
	.type	FspInstInfo.55335, %object
	.size	FspInstInfo.55335, 3212
FspInstInfo.55335:
	.space	3212
	.type	g_VdmCharacter, %object
	.size	g_VdmCharacter, 4
g_VdmCharacter:
	.space	4
	.type	last_rec_pos_time.55639, %object
	.size	last_rec_pos_time.55639, 64
last_rec_pos_time.55639:
	.space	64
	.type	extra_ref, %object
	.size	extra_ref, 4
extra_ref:
	.space	4
	.type	extra_disp, %object
	.size	extra_disp, 4
extra_disp:
	.space	4
	.type	MemArrange.55842, %object
	.size	MemArrange.55842, 1144
MemArrange.55842:
	.space	1144
	.type	MemArrange.55876, %object
	.size	MemArrange.55876, 1144
MemArrange.55876:
	.space	1144
	.type	cmdline, %object
	.size	cmdline, 1024
cmdline:
	.space	1024
	.type	extra_cmd, %object
	.size	extra_cmd, 4
extra_cmd:
	.space	4
	.type	g_allow_B_before_P, %object
	.size	g_allow_B_before_P, 1
g_allow_B_before_P:
	.space	1
	.type	g_not_allow_H264FullPictureRepair_flag, %object
	.size	g_not_allow_H264FullPictureRepair_flag, 1
g_not_allow_H264FullPictureRepair_flag:
	.space	1
	.type	g_apple_airplay_mirrorinig_flag, %object
	.size	g_apple_airplay_mirrorinig_flag, 1
g_apple_airplay_mirrorinig_flag:
	.space	1
	.space	1
	.type	g_event_report, %object
	.size	g_event_report, 4
g_event_report:
	.space	4
	.type	g_DSPState, %object
	.size	g_DSPState, 64
g_DSPState:
	.space	64
	.type	last_rec_pos_time.55981, %object
	.size	last_rec_pos_time.55981, 64
last_rec_pos_time.55981:
	.space	64
	.type	last_rec_pos_decparam_time.55982, %object
	.size	last_rec_pos_decparam_time.55982, 64
last_rec_pos_decparam_time.55982:
	.space	64
	.type	ChanPriTab.55942, %object
	.size	ChanPriTab.55942, 64
ChanPriTab.55942:
	.space	64
	.type	g_SleepTime, %object
	.size	g_SleepTime, 4
g_SleepTime:
	.space	4
	.type	g_StopDec, %object
	.size	g_StopDec, 4
g_StopDec:
	.space	4
	.type	g_VfmwChanStat, %object
	.size	g_VfmwChanStat, 4800
g_VfmwChanStat:
	.space	4800
	.type	AcceleratorCharacter, %object
	.size	AcceleratorCharacter, 4
AcceleratorCharacter:
	.space	4
	.type	PrioArray.55436, %object
	.size	PrioArray.55436, 64
PrioArray.55436:
	.space	64
	.type	g_ResetCreateNewSave, %object
	.size	g_ResetCreateNewSave, 4
g_ResetCreateNewSave:
	.space	4
	.type	vfmw_save_str_file, %object
	.size	vfmw_save_str_file, 128
vfmw_save_str_file:
	.space	128
	.type	pOption, %object
	.size	pOption, 4
pOption:
	.space	4
	.type	s_ChanControlState, %object
	.size	s_ChanControlState, 64
s_ChanControlState:
	.space	64
	.type	Capability.55488, %object
	.size	Capability.55488, 148
Capability.55488:
	.space	148
	.type	PrioArray.55487, %object
	.size	PrioArray.55487, 64
PrioArray.55487:
	.space	64
	.type	g_CurProcChan, %object
	.size	g_CurProcChan, 4
g_CurProcChan:
	.space	4
	.type	save_file_cnt.56108, %object
	.size	save_file_cnt.56108, 4
save_file_cnt.56108:
	.space	4
	.type	save_str_chan_num, %object
	.size	save_str_chan_num, 4
save_str_chan_num:
	.space	4
	.type	vfmw_save_seg_file, %object
	.size	vfmw_save_seg_file, 128
vfmw_save_seg_file:
	.space	128
	.type	save_file_cnt.56111, %object
	.size	save_file_cnt.56111, 4
save_file_cnt.56111:
	.space	4
	.type	save_seg_chan_num, %object
	.size	save_seg_chan_num, 4
save_seg_chan_num:
	.space	4
	.type	vfmw_save_yuv_file, %object
	.size	vfmw_save_yuv_file, 128
vfmw_save_yuv_file:
	.space	128
	.type	save_file_cnt.56116, %object
	.size	save_file_cnt.56116, 4
save_file_cnt.56116:
	.space	4
	.type	MemRecord_YUV, %object
	.size	MemRecord_YUV, 24
MemRecord_YUV:
	.space	24
	.type	pVl, %object
	.size	pVl, 4
pVl:
	.space	4
	.type	pUl, %object
	.size	pUl, 4
pUl:
	.space	4
	.type	pY, %object
	.size	pY, 4
pY:
	.space	4
	.type	save_yuv_with_crop, %object
	.size	save_yuv_with_crop, 4
save_yuv_with_crop:
	.space	4
	.type	vfmw_save_metadata_file, %object
	.size	vfmw_save_metadata_file, 128
vfmw_save_metadata_file:
	.space	128
	.type	save_file_cnt.56129, %object
	.size	save_file_cnt.56129, 4
save_file_cnt.56129:
	.space	4
	.type	save_metadata_chan_num, %object
	.size	save_metadata_chan_num, 4
save_metadata_chan_num:
	.space	4
	.type	vfmw_save_metadata_reorder_file, %object
	.size	vfmw_save_metadata_reorder_file, 128
vfmw_save_metadata_reorder_file:
	.space	128
	.type	save_file_cnt.56132, %object
	.size	save_file_cnt.56132, 4
save_file_cnt.56132:
	.space	4
	.type	save_metadata_reorder_chan_num, %object
	.size	save_metadata_reorder_chan_num, 4
save_metadata_reorder_chan_num:
	.space	4
	.type	vfmw_save_el_file, %object
	.size	vfmw_save_el_file, 128
vfmw_save_el_file:
	.space	128
	.type	save_file_cnt.56135, %object
	.size	save_file_cnt.56135, 4
save_file_cnt.56135:
	.space	4
	.type	save_el_chan_num, %object
	.size	save_el_chan_num, 4
save_el_chan_num:
	.space	4
	.type	g_DnrSleepTime, %object
	.size	g_DnrSleepTime, 4
g_DnrSleepTime:
	.space	4
	.type	g_SCDID, %object
	.size	g_SCDID, 4
g_SCDID:
	.space	4
	.type	last_rec_pos_time.55629, %object
	.size	last_rec_pos_time.55629, 64
last_rec_pos_time.55629:
	.space	64
	.type	g_DnrIrqHandle, %object
	.size	g_DnrIrqHandle, 4
g_DnrIrqHandle:
	.space	4
	.type	g_VdecIrqHandle, %object
	.size	g_VdecIrqHandle, 4
g_VdecIrqHandle:
	.space	4
	.type	g_u32DFSMaxAllocTime, %object
	.size	g_u32DFSMaxAllocTime, 4
g_u32DFSMaxAllocTime:
	.space	4
	.type	g_eVdmVersion, %object
	.size	g_eVdmVersion, 4
g_eVdmVersion:
	.space	4
	.type	g_VfmwGlobalStat, %object
	.size	g_VfmwGlobalStat, 84
g_VfmwGlobalStat:
	.space	84
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
