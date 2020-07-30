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
	.file	"vfmw.c"

	.text
	.align	2
	.global	BPD_OpenHardware
	.type	BPD_OpenHardware, %function
BPD_OpenHardware:
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
	ldr	r3, .L2
	ldr	r2, [r3]
	ldr	r3, [r2, #136]
	orr	r3, r3, #1
	bfc	r3, #4, #1
	str	r3, [r2, #136]
	ldmfd	sp, {fp, sp, pc}
.L3:
	.align	2
.L2:
	.word	g_pstRegCrg
	.fnend
	.size	BPD_OpenHardware, .-BPD_OpenHardware
	.align	2
	.global	BPD_CloseHardware
	.type	BPD_CloseHardware, %function
BPD_CloseHardware:
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
	ldr	r3, .L5
	ldr	r2, [r3]
	ldr	r3, [r2, #136]
	bic	r3, r3, #17
	orr	r3, r3, #16
	str	r3, [r2, #136]
	ldmfd	sp, {fp, sp, pc}
.L6:
	.align	2
.L5:
	.word	g_pstRegCrg
	.fnend
	.size	BPD_CloseHardware, .-BPD_CloseHardware
	.align	2
	.global	VDM_OpenHardware
	.type	VDM_OpenHardware, %function
VDM_OpenHardware:
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
	subs	r2, r0, #0
	bne	.L8
	ldr	r1, .L12
	mov	lr, #25
	ldr	r3, .L12+4
	mov	r0, #30
	ldr	r1, [r1]
	ldr	ip, [r3, #112]
	ldr	r3, [r1, #120]
	orr	r3, r3, #1
	bfi	r3, r2, #4, #1
	bfi	r3, r2, #6, #1
	bfi	r3, r2, #8, #2
	bfi	r3, r2, #12, #5
	bfi	r3, r2, #17, #1
	str	r3, [r1, #120]
	ldr	r3, [r1, #120]
	bfi	r3, lr, #12, #5
	bfi	r3, r2, #17, #1
	str	r3, [r1, #120]
	orr	r3, r3, #131072
	str	r3, [r1, #120]
	blx	ip
.L9:
	ldr	r3, .L12+8
	movw	r1, #41463
	movt	r1, 1
	ldr	r0, [r3]
	add	r0, r0, #4
	bl	MEM_WritePhyWord
	ldmfd	sp, {fp, sp, pc}
.L8:
	ldr	r1, .L12+12
	mov	r0, #0
	bl	dprint_vfmw
	b	.L9
.L13:
	.align	2
.L12:
	.word	g_pstRegCrg
	.word	.LANCHOR0
	.word	s_ScdRegPhyBaseAddr
	.word	.LC0
	.fnend
	.size	VDM_OpenHardware, .-VDM_OpenHardware
	.align	2
	.global	VDM_CloseHardware
	.type	VDM_CloseHardware, %function
VDM_CloseHardware:
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
	subs	r2, r0, #0
	bne	.L15
	ldr	r5, .L19
	ldr	r6, .L19+4
	ldr	r3, [r5, #292]
	ldr	r2, [r6]
	cmp	r3, #0
	ldr	r4, [r2, #120]
	beq	.L16
	blx	r3
.L17:
	ldr	r2, [r6]
	bfc	r4, #0, #1
	ldr	r3, [r5, #112]
	mov	r0, #30
	str	r4, [r2, #120]
	blx	r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L15:
	ldr	r1, .L19+8
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L16:
	movw	r2, #282
	ldr	r1, .L19+12
	bl	dprint_vfmw
	b	.L17
.L20:
	.align	2
.L19:
	.word	.LANCHOR0
	.word	g_pstRegCrg
	.word	.LC2
	.word	.LC1
	.fnend
	.size	VDM_CloseHardware, .-VDM_CloseHardware
	.align	2
	.global	DSP_OpenHardware
	.type	DSP_OpenHardware, %function
DSP_OpenHardware:
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
	subs	r2, r0, #0
	beq	.L24
	ldr	r1, .L25
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L24:
	ldr	r2, .L25+4
	mov	r0, #30
	ldr	r3, .L25+8
	ldr	r2, [r2]
	ldr	r1, [r3, #112]
	ldr	r3, [r2, #120]
	orr	r3, r3, #2
	str	r3, [r2, #120]
	blx	r1
	ldmfd	sp, {fp, sp, pc}
.L26:
	.align	2
.L25:
	.word	.LC3
	.word	g_pstRegCrg
	.word	.LANCHOR0
	.fnend
	.size	DSP_OpenHardware, .-DSP_OpenHardware
	.align	2
	.global	DSP_CloseHardware
	.type	DSP_CloseHardware, %function
DSP_CloseHardware:
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
	subs	r2, r0, #0
	beq	.L30
	ldr	r1, .L31
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L30:
	ldr	r1, .L31+4
	mov	r0, #30
	ldr	r3, .L31+8
	ldr	r1, [r1]
	ldr	ip, [r3, #112]
	ldr	r3, [r1, #120]
	bfi	r3, r2, #1, #1
	str	r3, [r1, #120]
	blx	ip
	ldmfd	sp, {fp, sp, pc}
.L32:
	.align	2
.L31:
	.word	.LC4
	.word	g_pstRegCrg
	.word	.LANCHOR0
	.fnend
	.size	DSP_CloseHardware, .-DSP_CloseHardware
	.align	2
	.global	SCD_OpenHardware
	.type	SCD_OpenHardware, %function
SCD_OpenHardware:
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
	subs	r2, r0, #0
	bne	.L34
	ldr	r3, .L36
	ldr	r1, [r3]
	ldr	r3, [r1, #120]
	bfi	r3, r2, #5, #1
	str	r3, [r1, #120]
	ldmfd	sp, {fp, sp, pc}
.L34:
	ldr	r1, .L36+4
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L37:
	.align	2
.L36:
	.word	g_pstRegCrg
	.word	.LC5
	.fnend
	.size	SCD_OpenHardware, .-SCD_OpenHardware
	.align	2
	.global	SCD_CloseHardware
	.type	SCD_CloseHardware, %function
SCD_CloseHardware:
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
	subs	r2, r0, #0
	bne	.L39
	ldr	r3, .L41
	ldr	r2, [r3]
	ldr	r3, [r2, #120]
	orr	r3, r3, #32
	str	r3, [r2, #120]
	ldmfd	sp, {fp, sp, pc}
.L39:
	ldr	r1, .L41+4
	mov	r0, #0
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L42:
	.align	2
.L41:
	.word	g_pstRegCrg
	.word	.LC6
	.fnend
	.size	SCD_CloseHardware, .-SCD_CloseHardware
	.align	2
	.global	VDEC_OpenModule
	.type	VDEC_OpenModule, %function
VDEC_OpenModule:
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
	ldr	r4, .L44
	mvn	r1, #0
	mov	r0, #0
	ldr	r3, [r4, #20]
	blx	r3
	ldr	r3, [r4, #196]
	blx	r3
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L45:
	.align	2
.L44:
	.word	.LANCHOR0
	.fnend
	.size	VDEC_OpenModule, .-VDEC_OpenModule
	.align	2
	.global	VDEC_ExitModule
	.type	VDEC_ExitModule, %function
VDEC_ExitModule:
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
	ldr	r3, .L47
	ldr	r3, [r3, #200]
	blx	r3
	ldmfd	sp, {fp, sp, pc}
.L48:
	.align	2
.L47:
	.word	.LANCHOR0
	.fnend
	.size	VDEC_ExitModule, .-VDEC_ExitModule
	.align	2
	.global	VDEC_Set_ClockSkip
	.type	VDEC_Set_ClockSkip, %function
VDEC_Set_ClockSkip:
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
	ldr	r3, .L50
	ldr	r2, [r3]
	ldr	r3, [r2, #120]
	bfi	r3, r0, #12, #5
	bfc	r3, #17, #1
	str	r3, [r2, #120]
	orr	r3, r3, #131072
	str	r3, [r2, #120]
	ldmfd	sp, {fp, sp, pc}
.L51:
	.align	2
.L50:
	.word	g_pstRegCrg
	.fnend
	.size	VDEC_Set_ClockSkip, .-VDEC_Set_ClockSkip
	.align	2
	.global	VDEC_SpinLockInit
	.type	VDEC_SpinLockInit, %function
VDEC_SpinLockInit:
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
	ldr	r4, .L53
	mov	r0, #0
	ldr	r3, [r4, #8]
	blx	r3
	ldr	r3, [r4, #8]
	mov	r0, #1
	blx	r3
	ldr	r3, [r4, #8]
	mov	r0, #2
	blx	r3
	ldr	r3, [r4, #8]
	mov	r0, #3
	blx	r3
	ldr	r3, [r4, #8]
	mov	r0, #8
	blx	r3
	ldr	r3, [r4, #8]
	mov	r0, #4
	blx	r3
	ldr	r3, [r4, #8]
	mov	r0, #5
	blx	r3
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L54:
	.align	2
.L53:
	.word	.LANCHOR0
	.fnend
	.size	VDEC_SpinLockInit, .-VDEC_SpinLockInit
	.align	2
	.global	VDH_InitEntry
	.type	VDH_InitEntry, %function
VDH_InitEntry:
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
	bl	VDH_Normal_Init
	cmp	r0, #0
	ldmeqfd	sp, {fp, sp, pc}
	mov	r2, r0
	ldr	r1, .L58
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L59:
	.align	2
.L58:
	.word	.LC7
	.fnend
	.size	VDH_InitEntry, .-VDH_InitEntry
	.align	2
	.global	VDH_ExitEntry
	.type	VDH_ExitEntry, %function
VDH_ExitEntry:
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
	bl	VDH_Exit
	subs	r2, r0, #0
	ldmeqfd	sp, {fp, sp, pc}
	ldr	r1, .L65
	mov	r0, #1
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L66:
	.align	2
.L65:
	.word	.LC8
	.fnend
	.size	VDH_ExitEntry, .-VDH_ExitEntry
	.align	2
	.global	VDEC_InitWithOperation
	.type	VDEC_InitWithOperation, %function
VDEC_InitWithOperation:
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
	ldr	r4, .L93
	mov	r5, r0
	mvn	r1, #0
	mov	r0, #0
	ldr	r3, [r4, #24]
	blx	r3
	cmp	r5, #0
	beq	.L89
	ldr	r3, [r4, #368]
	cmp	r3, #1
	beq	.L90
	ldr	r3, .L93+4
	mov	r10, #0
	ldr	r9, .L93+8
	ldr	r8, .L93+12
	str	r3, [r4, #252]
	ldr	r3, .L93+16
	ldr	r7, .L93+20
	ldr	r6, .L93+24
	str	r3, [r4, #256]
	ldr	r3, .L93+28
	ldr	lr, .L93+32
	ldr	ip, .L93+36
	str	r3, [r4, #260]
	ldr	r3, .L93+40
	ldr	r0, .L93+44
	ldr	r1, .L93+48
	str	r3, [r4, #304]
	ldr	r3, .L93+52
	ldr	r2, .L93+56
	str	r10, [r9]
	str	r3, [r4, #308]
	ldr	r3, .L93+60
	ldr	r9, .L93+64
	ldr	r10, .L93+68
	str	r8, [r4, #216]
	str	r7, [r4, #220]
	ldr	r8, .L93+72
	ldr	r7, .L93+76
	str	r6, [r4, #224]
	str	lr, [r4, #228]
	ldr	r6, .L93+80
	ldr	lr, .L93+84
	str	ip, [r4, #232]
	str	r0, [r4, #236]
	ldr	ip, .L93+88
	ldr	r0, .L93+92
	str	r1, [r4, #240]
	str	r2, [r4, #244]
	ldr	r1, .L93+96
	ldr	r2, .L93+100
	str	r3, [r4, #312]
	ldr	r3, .L93+104
	str	r9, [r4, #264]
	str	r10, [r4, #268]
	str	r8, [r4, #284]
	str	r7, [r4, #364]
	str	r6, [r4, #276]
	str	lr, [r4, #280]
	str	ip, [r4, #288]
	ldr	lr, .L93+108
	str	r0, [r4, #292]
	ldr	ip, .L93+112
	str	r1, [r4, #296]
	ldr	r0, .L93+116
	str	r2, [r4, #300]
	ldr	r1, .L93+120
	ldr	r2, .L93+124
	str	r3, [r4, #316]
	ldr	r10, .L93+128
	ldr	r3, .L93+132
	ldr	r9, .L93+136
	ldr	r8, .L93+140
	ldr	r7, .L93+144
	ldr	r6, .L93+148
	str	lr, [r4, #340]
	str	ip, [r4, #344]
	str	r10, [r4, #320]
	str	r9, [r4, #324]
	str	r8, [r4, #328]
	str	r7, [r4, #332]
	str	r6, [r4, #336]
	str	r0, [r4, #348]
	str	r3, [r4, #356]
	str	r1, [r4, #352]
	str	r2, [r4, #248]
	bl	VDEC_SpinLockInit
	ldr	r3, [r4, #248]
	cmp	r3, #0
	beq	.L72
	blx	r3
.L72:
	mov	r0, r5
	bl	MEM_ManagerWithOperation
	mov	r0, r5
	bl	VCTRL_OpenVfmw
	subs	r6, r0, #0
	bne	.L91
	ldr	r3, .L93+152
	ldrb	r3, [r3]
	cmp	r3, #1
	beq	.L74
	mov	r0, r5
	bl	VDH_InitEntry
	subs	r7, r0, #0
	bne	.L92
.L75:
	mov	r3, #1
	str	r3, [r4, #368]
	str	r3, [r4, #372]
.L71:
	ldr	r1, [r5, #44]
	ldr	r0, [r5]
	bl	VCTRL_SetCallBack
	ldr	r3, [r4, #28]
	mvn	r1, #0
	mov	r0, #0
	blx	r3
	mov	r0, r6
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L90:
	ldr	r3, [r4, #372]
	mov	r6, #0
	add	r3, r3, #1
	str	r3, [r4, #372]
	b	.L71
.L74:
	bl	VDM_OpenHardware
	ldr	r3, [r4, #288]
	cmp	r3, #0
	beq	.L76
	blx	r3
.L77:
	ldr	r3, [r4, #276]
	cmp	r3, #0
	beq	.L78
	mov	r0, #0
	blx	r3
.L79:
	ldr	r0, [r4, #280]
	cmp	r0, #0
	beq	.L80
	blx	r0
.L81:
	mov	r0, #0
	bl	VDM_CloseHardware
	b	.L75
.L92:
	bl	VCTRL_CloseVfmw
	str	r6, [r4, #368]
	str	r6, [r4, #372]
	mov	r6, r7
	b	.L71
.L76:
	movw	r2, #687
	ldr	r1, .L93+156
	mov	r0, r6
	bl	dprint_vfmw
	b	.L77
.L80:
	movw	r2, #691
	ldr	r1, .L93+156
	bl	dprint_vfmw
	b	.L81
.L78:
	mov	r0, r3
	movw	r2, #690
	ldr	r1, .L93+156
	bl	dprint_vfmw
	b	.L79
.L91:
	ldr	r1, .L93+160
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L89:
	ldr	r3, [r4, #28]
	mov	r0, r5
	mvn	r1, #0
	blx	r3
	ldr	r1, .L93+164
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L94:
	.align	2
.L93:
	.word	.LANCHOR0
	.word	VDMHAL_V400R003_GetHalMemSize
	.word	AcceleratorCharacter
	.word	VDM_OpenHardware
	.word	VDMHAL_V400R003_CalcFsSize
	.word	VDM_CloseHardware
	.word	DSP_OpenHardware
	.word	VDMHAL_V400R003_OpenHAL
	.word	DSP_CloseHardware
	.word	SCD_OpenHardware
	.word	VDMHAL_V400R003_MaskInt
	.word	SCD_CloseHardware
	.word	BPD_OpenHardware
	.word	VDMHAL_V400R003_EnableInt
	.word	BPD_CloseHardware
	.word	VDMHAL_V400R003_CheckReg
	.word	VDMHAL_V400R003_CloseHAL
	.word	VDMHAL_V400R003_ArrangeMem
	.word	VDMHAL_V400R003_ResetVdm
	.word	VDMHAL_V400R003_GetRpuSize
	.word	VDMHAL_V400R003_SetSmmuPageTableAddr
	.word	VDMHAL_V400R003_EnableSmmu
	.word	VDMHAL_V400R003_GlbReset
	.word	VDMHAL_V400R003_GlbResetX
	.word	VDMHAL_V400R003_ClearIntState
	.word	VDMHAL_V400R003_ClearMMUIntState
	.word	VDMHAL_V400R003_ReadMMUMask
	.word	VDMHAL_V400R003_IsVdmRun
	.word	VDMHAL_V400R003_PrepareRepair
	.word	VDMHAL_V400R003_MakeDecReport
	.word	VDMHAL_V400R003_BackupInfo
	.word	VDMHAL_V400R003_GetCharacter
	.word	VDMHAL_V400R003_WriteMMUMask
	.word	VDMHAL_V400R003_WriteBigTitle1DYuv
	.word	VDMHAL_V400R003_StartHwRepair
	.word	VDMHAL_V400R003_StartHwDecode
	.word	VDMHAL_V400R003_PrepareDec
	.word	VDMHAL_V400R003_IsVdmReady
	.word	g_HalDisable
	.word	.LC1
	.word	.LC10
	.word	.LC9
	.fnend
	.size	VDEC_InitWithOperation, .-VDEC_InitWithOperation
	.align	2
	.global	VDEC_Init
	.type	VDEC_Init, %function
VDEC_Init:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, fp, ip, lr, pc}
	.pad #4
	.save {r4, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #60
	sub	sp, sp, #60
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r3, .L96
	mov	r4, r0
	mov	r2, #56
	mov	r1, #0
	sub	r0, fp, #76
	ldr	r3, [r3, #48]
	blx	r3
	sub	r0, fp, #76
	mov	r3, #0
	str	r4, [fp, #-32]
	str	r3, [fp, #-28]
	str	r3, [fp, #-24]
	bl	VDEC_InitWithOperation
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r0, r0, #0
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L97:
	.align	2
.L96:
	.word	.LANCHOR0
	.fnend
	.size	VDEC_Init, .-VDEC_Init
	.align	2
	.global	VDEC_Exit
	.type	VDEC_Exit, %function
VDEC_Exit:
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
	ldr	r4, .L110
	mvn	r1, #0
	mov	r0, #0
	ldr	r3, [r4, #24]
	blx	r3
	cmp	r0, #0
	bne	.L109
.L99:
	ldr	r3, [r4, #372]
	ldr	r6, .L110
	sub	r3, r3, #1
	str	r3, [r4, #372]
	cmp	r3, #0
	ble	.L100
	ldr	r3, [r6, #28]
	mvn	r1, #0
	mov	r0, #0
	blx	r3
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L100:
	bl	VCTRL_CloseVfmw
	mov	r5, r0
	bl	MEM_ManagerClearOperation
	ldr	r3, .L110+4
	mov	r2, #0
	str	r2, [r6, #368]
	ldrb	r3, [r3]
	cmp	r3, #1
	beq	.L102
	bl	VDH_ExitEntry
.L102:
	ldr	r3, [r4, #28]
	mvn	r1, #0
	mov	r0, #0
	blx	r3
	adds	r0, r5, #0
	movne	r0, #1
	rsb	r0, r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L109:
	ldr	r1, .L110+8
	mov	r0, #0
	bl	dprint_vfmw
	b	.L99
.L111:
	.align	2
.L110:
	.word	.LANCHOR0
	.word	g_HalDisable
	.word	.LC11
	.fnend
	.size	VDEC_Exit, .-VDEC_Exit
	.align	2
	.global	GetVdecCapability
	.type	GetVdecCapability, %function
GetVdecCapability:
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
	ldr	r3, .L113
	mov	r2, #148
	mov	r1, #0
	mov	r4, r0
	ldr	r3, [r3, #48]
	blx	r3
	mov	r3, #0
	mov	r2, #50
	movt	r3, 6480
	mov	r1, #4096
	str	r2, [r4, #4]
	str	r3, [r4, #16]
	mov	r2, #2304
	mov	r3, #3
	str	r2, [r4, #12]
	str	r3, [r4, #24]
	mov	r2, #0
	mov	r3, #6
	str	r2, [r4, #20]
	str	r3, [r4, #32]
	mov	r2, #2
	mov	r3, #9
	str	r2, [r4, #28]
	str	r3, [r4, #40]
	mov	r2, #8
	mov	r3, #5
	str	r2, [r4, #36]
	str	r3, [r4, #48]
	mov	r2, #1
	mov	r3, #14
	str	r2, [r4, #44]
	str	r3, [r4, #56]
	mov	r2, #4
	mov	r3, #11
	str	r2, [r4, #52]
	str	r3, [r4, #64]
	mov	r2, #10
	mov	r3, #13
	str	r2, [r4, #60]
	str	r3, [r4, #72]
	mov	r2, #12
	mov	r3, #17
	str	r2, [r4, #68]
	str	r3, [r4, #84]
	mov	r2, #15
	mov	r3, #20
	str	r2, [r4, #76]
	str	r3, [r4, #92]
	mov	r2, #19
	mov	r3, #16
	str	r2, [r4, #88]
	str	r1, [r4, #8]
	mov	r2, #21
	str	r3, [r4]
	str	r2, [r4, #96]
	str	r3, [r4, #80]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L114:
	.align	2
.L113:
	.word	.LANCHOR0
	.fnend
	.size	GetVdecCapability, .-GetVdecCapability
	.align	2
	.global	VDEC_Control
	.type	VDEC_Control, %function
VDEC_Control:
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
	ldr	r4, .L244
	mov	r6, r0
	mov	r7, r2
	ldr	r3, [r4, #368]
	cmp	r3, #1
	bne	.L217
	cmp	r1, #63
	ldrls	pc, [pc, r1, asl #2]
	b	.L118
.L120:
	.word	.L119
	.word	.L121
	.word	.L119
	.word	.L119
	.word	.L122
	.word	.L123
	.word	.L119
	.word	.L119
	.word	.L124
	.word	.L125
	.word	.L119
	.word	.L119
	.word	.L119
	.word	.L119
	.word	.L126
	.word	.L127
	.word	.L128
	.word	.L118
	.word	.L129
	.word	.L130
	.word	.L118
	.word	.L131
	.word	.L119
	.word	.L119
	.word	.L132
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L133
	.word	.L134
	.word	.L118
	.word	.L135
	.word	.L136
	.word	.L119
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L119
	.word	.L119
	.word	.L137
	.word	.L138
	.word	.L139
	.word	.L140
	.word	.L141
	.word	.L142
	.word	.L118
	.word	.L143
	.word	.L144
	.word	.L118
	.word	.L145
	.word	.L146
.L119:
	cmp	r1, #63
	ldrls	pc, [pc, r1, asl #2]
	b	.L118
.L172:
	.word	.L202
	.word	.L147
	.word	.L202
	.word	.L202
	.word	.L173
	.word	.L174
	.word	.L175
	.word	.L176
	.word	.L152
	.word	.L153
	.word	.L177
	.word	.L178
	.word	.L179
	.word	.L180
	.word	.L154
	.word	.L155
	.word	.L156
	.word	.L118
	.word	.L157
	.word	.L158
	.word	.L118
	.word	.L159
	.word	.L181
	.word	.L182
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L161
	.word	.L162
	.word	.L118
	.word	.L160
	.word	.L118
	.word	.L183
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L202
	.word	.L202
	.word	.L163
	.word	.L164
	.word	.L165
	.word	.L166
	.word	.L118
	.word	.L118
	.word	.L118
	.word	.L167
	.word	.L168
	.word	.L118
	.word	.L170
	.word	.L169
.L142:
	cmp	r2, #0
	bne	.L118
	mov	r0, r2
	ldr	r1, .L244+4
	movw	r2, #1061
	bl	dprint_vfmw
.L118:
	mvn	r5, #0
.L213:
	mov	r0, r5
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L136:
	cmp	r2, #0
	bne	.L118
	mov	r0, r2
	ldr	r1, .L244+4
	movw	r2, #1034
	bl	dprint_vfmw
	b	.L118
.L135:
	cmp	r2, #0
	beq	.L218
.L160:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	mov	r1, r7
	mov	r0, r6
	bl	VCTRL_SetDiscardPicParam
	ldr	r3, [r4, #16]
	mov	r5, r0
	mov	r0, #0
	blx	r3
	b	.L213
.L134:
	cmp	r2, #0
	beq	.L219
.L162:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	mov	r1, r7
	mov	r0, r6
	bl	VCTRL_PutUsrdecFrame
.L214:
	adds	r5, r0, #0
	ldr	r3, [r4, #16]
	mov	r0, #0
	movne	r5, #1
	blx	r3
	rsb	r5, r5, #0
	mov	r0, r5
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L133:
	cmp	r2, #0
	beq	.L220
.L161:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	mov	r0, r6
	sub	r1, fp, #60
	bl	VCTRL_GetUsrdecFrame
	ldr	r2, [fp, #-60]
	ldr	r3, [fp, #-44]
	stmia	r7, {r2, r3}
	b	.L214
.L132:
	cmp	r2, #0
	bne	.L118
	mov	r0, r2
	ldr	r1, .L244+8
	movw	r2, #823
	bl	dprint_vfmw
	b	.L118
.L146:
	cmp	r2, #0
	beq	.L221
.L169:
	mov	r1, r7
	mov	r0, r6
	bl	VCTRL_ReportOccupiedFrame
	subs	r5, r0, #0
	beq	.L213
.L216:
	mov	r2, r6
	ldr	r1, .L244+12
	mov	r0, #1
	bl	dprint_vfmw
	b	.L213
.L137:
	cmp	r2, #0
	beq	.L222
.L163:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	sub	r1, fp, #60
	mov	r0, r6
	mov	r3, #0
	mov	r2, #1
	str	r3, [fp, #-56]
	str	r2, [fp, #-60]
	str	r3, [fp, #-52]
	bl	VCTRL_ResetChanWithOption
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r5, r0, #0
	cmp	r5, #0
	beq	.L223
.L215:
	ldr	r3, [r4, #16]
	mov	r0, #0
	blx	r3
	mov	r0, r5
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L131:
	cmp	r2, #0
	beq	.L224
.L159:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	ldr	r0, [r7]
	bl	VCTRL_GetChanIDByMemAddr
	mov	r5, r0
	cmn	r5, #1
	str	r5, [r7]
	mov	r0, #0
	ldr	r3, [r4, #16]
	movne	r5, #0
	moveq	r5, #1
	rsb	r5, r5, #0
	blx	r3
	b	.L213
.L130:
	cmp	r2, #0
	beq	.L225
.L158:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	mov	r3, #1
	sub	r2, fp, #60
	ldr	r1, [r7, #8]
	ldr	r0, [r7]
	bl	VCTRL_GetChanMemSizeWithOption
	cmp	r0, #0
	bne	.L204
	ldr	r1, [fp, #-60]
	mov	r5, r0
	ldr	r2, [fp, #-56]
	ldr	r3, [fp, #-52]
	stmia	r7, {r1, r2, r3}
	b	.L215
.L129:
	cmp	r2, #0
	beq	.L226
.L157:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	sub	r2, fp, #60
	sub	r1, fp, #72
	ldr	r0, [r7]
	bl	VCTRL_GetChanMemSize
	cmp	r0, #0
	bne	.L204
	ldr	r3, [fp, #-72]
	mov	r5, r0
	ldr	r1, [fp, #-60]
	ldr	r2, [fp, #-68]
	ldr	ip, [fp, #-56]
	add	r1, r3, r1
	ldr	r0, [fp, #-52]
	ldr	r3, [fp, #-64]
	add	r2, r2, ip
	stmia	r7, {r1, r2}
	add	r3, r3, r0
	str	r3, [r7, #8]
	b	.L215
.L128:
	cmp	r2, #0
	beq	.L227
.L156:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	mov	r1, r7
	mov	r0, r6
	bl	VCTRL_GetStreamSize
	mov	r5, r0
	b	.L215
.L127:
	cmp	r2, #0
	beq	.L228
.L155:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	ldr	r2, .L244+16
	ldr	r3, .L244+20
	mov	r0, #0
	str	r6, [r7]
	mov	r5, r0
	stmib	r7, {r2, r3}
	ldr	r3, [r4, #16]
	blx	r3
	b	.L213
.L126:
	cmp	r2, #0
	beq	.L229
.L154:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	mov	r1, r7
	mov	r0, r6
	bl	VCTRL_SetStreamInterface
	b	.L214
.L139:
	cmp	r2, #0
	beq	.L230
.L165:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	mov	r1, r7
	mov	r0, r6
	bl	VCTRL_ConfigPVRInfo
	b	.L214
.L140:
	cmp	r2, #0
	beq	.L231
.L166:
	ldr	r3, .L244+24
	mov	r5, #0
	ldr	r2, [r7]
	ldr	r3, [r3, r6, asl #2]
	str	r2, [r3, #1496]
	b	.L213
.L138:
	cmp	r2, #0
	beq	.L232
.L164:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	mov	r1, r7
	mov	r0, r6
	bl	VCTRL_ConfigFFFBSpeed
	b	.L214
.L141:
	cmp	r2, #0
	bne	.L118
	mov	r0, r2
	ldr	r1, .L244+4
	movw	r2, #1052
	bl	dprint_vfmw
	b	.L118
.L125:
	cmp	r2, #0
	beq	.L233
.L153:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	mov	r1, r7
	mov	r0, r6
	bl	VCTRL_ConfigChan
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r5, r0, #0
	cmp	r5, #0
	bne	.L215
	mov	r0, r6
	bl	VCTRL_LoadDspCode
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r5, r0, #0
	b	.L215
.L124:
	cmp	r2, #0
	beq	.L234
.L152:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	mov	r1, r7
	mov	r0, r6
	bl	VCTRL_GetChanCfg
	b	.L214
.L143:
	cmp	r2, #0
	beq	.L235
.L167:
	mov	r1, #1
	mov	r0, r6
	bl	VCTRT_SetChanCtrlState
	subs	r8, r0, #0
	beq	.L194
	mov	r2, r6
	ldr	r1, .L244+28
	mov	r0, #31
	mvn	r5, #0
	bl	dprint_vfmw
	b	.L213
.L123:
	cmp	r2, #0
	beq	.L236
	ldrd	r0, [r2]
	cmp	r1, #0
	cmpeq	r0, #33
	bhi	.L237
.L151:
	mov	r3, #0
	mov	r2, #2
	ldr	r1, [r7, #8]
	bl	VCTRL_CreateChanWithOption
	mov	r5, r0, asr #31
	str	r0, [r7]
	b	.L213
.L122:
	cmp	r2, #0
	beq	.L238
	ldr	r0, [r2]
	cmp	r0, #33
	bgt	.L239
.L149:
	add	r1, r7, #4
	bl	VCTRL_CreateChan
	ldr	r1, .L244+32
	mov	r4, r0
	mov	r2, r0
	mov	r0, #2
	mov	r5, r4, asr #31
	bl	dprint_vfmw
	str	r4, [r7]
	b	.L213
.L144:
	cmp	r2, #0
	beq	.L240
.L168:
	ldr	r3, .L244+24
	ldr	r3, [r3, r6, asl #2]
	cmp	r3, #0
	beq	.L118
	ldr	r2, [r7]
	add	r3, r3, #233472
	mov	r5, #0
	str	r2, [r3, #396]
	b	.L213
.L145:
	cmp	r2, #0
	beq	.L241
.L170:
	mov	r1, r7
	mov	r0, r6
	bl	VCTRL_ImageOutputEnable
	subs	r5, r0, #0
	beq	.L213
	b	.L216
.L121:
	cmp	r2, #0
	beq	.L242
.L147:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	mov	r0, r7
	bl	GetVdecCapability
	ldr	r3, [r4, #16]
	mov	r0, #0
	mov	r5, r0
	blx	r3
	b	.L213
.L202:
	mov	r5, #0
	b	.L213
.L174:
	ldrd	r0, [r2]
	b	.L151
.L173:
	ldr	r0, [r2]
	b	.L149
.L180:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	mov	r0, r6
	bl	VCTRL_ResetChan
	b	.L214
.L182:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	mov	r1, r7
	mov	r0, r6
	bl	VCTRL_ResetChanWithOption
	b	.L214
.L181:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	mov	r0, r6
	bl	VCTRL_ReleaseStream
	b	.L214
.L183:
	ldr	r3, [r4, #12]
	mov	r5, #0
	mov	r0, #0
	blx	r3
	bl	VCTRL_ExtraWakeUpThread
	ldr	r3, [r4, #16]
	mov	r0, r5
	blx	r3
	b	.L213
.L179:
	bl	VCTRL_StopChanWithCheck
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r5, r0, #0
	b	.L213
.L177:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	mov	r0, r6
	mov	r1, r7
	bl	VCTRL_GetChanState
	ldr	r3, [r4, #16]
	mov	r0, #0
	mov	r5, r0
	blx	r3
	b	.L213
.L178:
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
	mov	r0, r6
	bl	VCTRL_StartChan
	b	.L214
.L175:
	mov	r5, #500
	b	.L185
.L186:
	ldr	r3, [r4, #116]
	sub	r5, r5, #1
	blx	r3
.L185:
	mov	r1, #2
	mov	r0, r6
	bl	VCTRT_SetChanCtrlState
	adds	r3, r5, #0
	movne	r3, #1
	cmn	r0, #1
	mov	r0, #1
	movne	r3, #0
	cmp	r3, #0
	bne	.L186
	cmp	r5, #0
	ble	.L243
	mov	r0, r6
	bl	VCTRL_DestroyChan
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r5, r0, #0
	b	.L213
.L176:
	mov	r5, #500
	b	.L184
.L188:
	ldr	r3, [r4, #116]
	sub	r5, r5, #1
	blx	r3
.L184:
	mov	r1, #2
	mov	r0, r6
	bl	VCTRT_SetChanCtrlState
	adds	r3, r5, #0
	movne	r3, #1
	cmn	r0, #1
	mov	r0, #1
	movne	r3, #0
	cmp	r3, #0
	bne	.L188
	cmp	r5, #0
	ble	.L118
	mov	r0, r6
	bl	VCTRL_DestroyChanWithOption
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r5, r0, #0
	b	.L213
.L217:
	ldr	r1, .L244+36
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r5, #0
	b	.L213
.L204:
	mvn	r5, #0
	b	.L215
.L194:
	mov	r1, r7
	mov	r0, r6
	bl	VCTRL_SetSingleFrameBufToChan
	subs	r5, r0, #0
	bne	.L195
	ldr	r3, [r4, #12]
	blx	r3
	mov	r1, #2
	mov	r0, r6
	bl	VCTRL_SetChanFsPartitionState
	ldr	r1, .L244+40
	mov	r0, #31
	bl	dprint_vfmw
	ldr	r3, [r4, #16]
	mov	r0, r5
	blx	r3
.L196:
	mov	r0, r6
	mov	r1, #0
	bl	VCTRT_SetChanCtrlState
	orrs	r3, r0, r5
	mvnne	r5, #0
	moveq	r5, #0
	b	.L213
.L239:
	movw	r2, #842
	ldr	r1, .L244+44
	mov	r0, #0
	bl	dprint_vfmw
	b	.L118
.L237:
	movw	r2, #861
	ldr	r1, .L244+44
	mov	r0, #0
	bl	dprint_vfmw
	b	.L118
.L223:
	mov	r1, r7
	mov	r0, r6
	bl	VCTRL_SeekPts
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r5, r0, #0
	b	.L215
.L243:
	mvn	r2, #0
	mov	r0, r3
	ldr	r1, .L244+48
	mov	r5, r2
	bl	dprint_vfmw
	b	.L213
.L195:
	mov	r0, r6
	bl	VCTRL_GetCurChanFsSize
	cmp	r0, #0
	beq	.L196
	mov	r2, r6
	ldr	r1, .L244+52
	mov	r0, #31
	bl	dprint_vfmw
	ldr	r3, [r4, #12]
	mov	r0, r8
	blx	r3
	mov	r0, r6
	mov	r1, #3
	bl	VCTRL_SetChanFsPartitionState
	ldr	r1, .L244+56
	mov	r0, #31
	bl	dprint_vfmw
	ldr	r3, [r4, #16]
	mov	r0, r8
	blx	r3
	b	.L196
.L236:
	mov	r0, r2
	ldr	r1, .L244+4
	mov	r2, #852
	bl	dprint_vfmw
	b	.L118
.L221:
	mov	r0, r2
	ldr	r1, .L244+60
	mov	r2, #1088
	bl	dprint_vfmw
	b	.L118
.L235:
	mov	r0, r2
	ldr	r1, .L244+60
	movw	r2, #1071
	bl	dprint_vfmw
	b	.L118
.L222:
	mov	r0, r2
	ldr	r1, .L244+4
	mov	r2, #1004
	bl	dprint_vfmw
	b	.L118
.L224:
	mov	r0, r2
	ldr	r1, .L244+4
	mov	r2, #960
	bl	dprint_vfmw
	b	.L118
.L225:
	mov	r0, r2
	ldr	r1, .L244+4
	movw	r2, #951
	bl	dprint_vfmw
	b	.L118
.L220:
	mov	r0, r2
	ldr	r1, .L244+4
	movw	r2, #986
	bl	dprint_vfmw
	b	.L118
.L238:
	mov	r0, r2
	ldr	r1, .L244+4
	movw	r2, #833
	bl	dprint_vfmw
	b	.L118
.L219:
	mov	r0, r2
	ldr	r1, .L244+4
	movw	r2, #995
	bl	dprint_vfmw
	b	.L118
.L218:
	mov	r0, r2
	ldr	r1, .L244+4
	movw	r2, #970
	bl	dprint_vfmw
	b	.L118
.L228:
	mov	r0, r2
	ldr	r1, .L244+4
	mov	r2, #924
	bl	dprint_vfmw
	b	.L118
.L226:
	mov	r0, r2
	ldr	r1, .L244+4
	movw	r2, #942
	bl	dprint_vfmw
	b	.L118
.L241:
	mov	r0, r2
	ldr	r1, .L244+60
	movw	r2, #1096
	bl	dprint_vfmw
	b	.L118
.L242:
	mov	r0, r2
	ldr	r1, .L244+4
	mov	r2, #808
	bl	dprint_vfmw
	b	.L118
.L232:
	mov	r0, r2
	ldr	r1, .L244+4
	movw	r2, #1013
	bl	dprint_vfmw
	b	.L118
.L230:
	mov	r0, r2
	ldr	r1, .L244+4
	movw	r2, #1022
	bl	dprint_vfmw
	b	.L118
.L231:
	mov	r0, r2
	ldr	r1, .L244+4
	movw	r2, #1043
	bl	dprint_vfmw
	b	.L118
.L240:
	mov	r0, r2
	ldr	r1, .L244+60
	movw	r2, #1079
	bl	dprint_vfmw
	b	.L118
.L227:
	mov	r0, r2
	ldr	r1, .L244+4
	movw	r2, #933
	bl	dprint_vfmw
	b	.L118
.L233:
	mov	r0, r2
	ldr	r1, .L244+4
	movw	r2, #886
	bl	dprint_vfmw
	b	.L118
.L229:
	mov	r0, r2
	ldr	r1, .L244+4
	movw	r2, #915
	bl	dprint_vfmw
	b	.L118
.L234:
	mov	r0, r2
	ldr	r1, .L244+4
	movw	r2, #877
	bl	dprint_vfmw
	b	.L118
.L245:
	.align	2
.L244:
	.word	.LANCHOR0
	.word	.LC13
	.word	.LC14
	.word	.LC23
	.word	VCTRL_GetChanImage
	.word	VCTRL_ReleaseChanImage
	.word	s_pstVfmwChan
	.word	.LC19
	.word	.LC17
	.word	.LC12
	.word	.LC20
	.word	.LC15
	.word	.LC18
	.word	.LC21
	.word	.LC22
	.word	.LC16
	.fnend
	.size	VDEC_Control, .-VDEC_Control
	.align	2
	.global	VDEC_Suspend
	.type	VDEC_Suspend, %function
VDEC_Suspend:
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
	bl	VCTRL_Suspend
	ldr	r1, .L247
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L248:
	.align	2
.L247:
	.word	.LC24
	.fnend
	.size	VDEC_Suspend, .-VDEC_Suspend
	.align	2
	.global	VDEC_Resume
	.type	VDEC_Resume, %function
VDEC_Resume:
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
	bl	VCTRL_Resume
	ldr	r1, .L250
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L251:
	.align	2
.L250:
	.word	.LC25
	.fnend
	.size	VDEC_Resume, .-VDEC_Resume
	.global	g_vdm_hal_fun_ptr
	.global	g_ChipMaxHeight
	.global	g_ChipMaxWidth
	.global	g_VfmwInitCount
	.global	g_VfmwEnableFlag
	.global	vfmw_Osal_Func_Ptr_S
	.data
	.align	2
	.type	g_ChipMaxHeight, %object
	.size	g_ChipMaxHeight, 4
g_ChipMaxHeight:
	.word	8192
	.type	g_ChipMaxWidth, %object
	.size	g_ChipMaxWidth, 4
g_ChipMaxWidth:
	.word	8192
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"VDM_OpenHardware failed, wrong VdhId %d\012\000"
	.space	3
.LC1:
	.ascii	"VDMHAL_NULL_FUN_PRINT,L%d\012\000"
	.space	1
.LC2:
	.ascii	"VDM_CloseHardware failed, wrong VdhId %d\012\000"
	.space	2
.LC3:
	.ascii	"DSP_OpenHardware failed, wrong VdhId %d\012\000"
	.space	3
.LC4:
	.ascii	"DSP_CloseHardware failed, wrong VdhId %d\012\000"
	.space	2
.LC5:
	.ascii	"SCD_OpenHardware Wrong ScdId %d\012\000"
	.space	3
.LC6:
	.ascii	"SCD_CloseHardware Wrong ScdId %d\012\000"
	.space	2
.LC7:
	.ascii	"VDH_Init failed, return %d\012\000"
.LC8:
	.ascii	"VDH_Exit failed, return %d\012\000"
.LC9:
	.ascii	"VDEC_InitWithOperation has NULL parameter, error!\012"
	.ascii	"\000"
	.space	1
.LC10:
	.ascii	"VCTRL_OpenVfmw Failed!\012\000"
.LC11:
	.ascii	"OSAL_DOWN_INTERRUPTIBLE ERR\012\000"
	.space	3
.LC12:
	.ascii	"VFMW has been destroyed, so any operation is unusef"
	.ascii	"ul!\012\000"
.LC13:
	.ascii	"vfmw.c,L%d: pArgs is NULL!\012\000"
.LC14:
	.ascii	"vfmw.c, L%d: pArgs is NULL!\012\000"
	.space	3
.LC15:
	.ascii	"vfmw.c,L%d: capability level out of range\012\000"
	.space	1
.LC16:
	.ascii	"vfmw.c, Line(%d): pArgs is NULL!\012\000"
	.space	2
.LC17:
	.ascii	"VCTRL_CreateChan() return %d\012\000"
	.space	2
.LC18:
	.ascii	"VCTRT_SetChanCtrlState ERR: %d\012\000"
.LC19:
	.ascii	"DFS, rls chan %d frame store fail!\012\000"
.LC20:
	.ascii	"DFS, set decoding thread state to success!\012 \000"
	.space	3
.LC21:
	.ascii	"DFS, request frame store fail!, chanid: %d\012\000"
.LC22:
	.ascii	"DFS, set decoding thread state to fail\012\000"
.LC23:
	.ascii	"VCTRL_FindOccupiedFrame[Chan %d] failed!\012\000"
	.space	2
.LC24:
	.ascii	"VDEC_Suspend ok !\012\000"
	.space	1
.LC25:
	.ascii	"VDEC_Resume ok !\012\000"
	.bss
	.align	2
.LANCHOR0 = . + 0
	.type	vfmw_Osal_Func_Ptr_S, %object
	.size	vfmw_Osal_Func_Ptr_S, 216
vfmw_Osal_Func_Ptr_S:
	.space	216
	.type	g_vdm_hal_fun_ptr, %object
	.size	g_vdm_hal_fun_ptr, 152
g_vdm_hal_fun_ptr:
	.space	152
	.type	g_VfmwEnableFlag, %object
	.size	g_VfmwEnableFlag, 4
g_VfmwEnableFlag:
	.space	4
	.type	g_VfmwInitCount, %object
	.size	g_VfmwInitCount, 4
g_VfmwInitCount:
	.space	4
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
