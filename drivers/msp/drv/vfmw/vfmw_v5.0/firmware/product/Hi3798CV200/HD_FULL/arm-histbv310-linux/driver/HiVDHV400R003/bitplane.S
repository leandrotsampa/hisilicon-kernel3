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
	.file	"bitplane.c"

	.text
	.align	2
	.global	BPD_CfgReg
	.type	BPD_CfgReg, %function
BPD_CfgReg:
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
	ldr	ip, [r3, #8]
	mov	r4, r0
	mov	r0, #0
	str	r0, [fp, #-48]
	cmp	ip, r0
	beq	.L31
.L2:
	ldr	r0, .L36
	mvn	ip, #0
	mvn	r3, #1
	ldr	r5, [r0, #8]
	str	ip, [r5, #68]
	str	r3, [r5, #68]
	ldr	lr, [r1, #24]
	ldr	r7, [r1, #20]
	adds	ip, lr, #31
	add	r3, lr, #7
	addmi	ip, lr, #62
	cmp	lr, #0
	bic	ip, ip, #31
	ldrb	r6, [r4, #3096]
	add	ip, ip, r7
	ldr	r7, [r1]
	rsb	r1, lr, ip
	movge	r3, lr
	mov	ip, r3, asr #3
	mov	r3, r1, asr #31
	mov	r3, r3, lsr #27
	add	r1, r1, r3
	and	r1, r1, #31
	rsb	r3, r3, r1
	cmp	r3, #0
	add	r1, r3, #7
	movlt	r3, r1
	cmp	r6, #0
	add	r3, ip, r3, asr #3
	add	r3, r7, r3
	beq	.L5
	ldrb	r1, [r2, #362]
	cmp	r1, #0
	beq	.L6
	movw	r1, #362
	ldrh	r1, [r2, r1]
	cmp	r1, #4
	beq	.L6
	ldrb	r1, [r2, #197]
	cmp	r1, #1
	beq	.L32
.L8:
	ldrb	r1, [r2, #349]
	ldr	r6, [r2, #392]
	cmp	r1, #4
	ldrb	r7, [r2, #16]
	andne	ip, r1, #3
	ldrb	r1, [fp, #-46]
	moveq	ip, #3
	cmp	r6, #3
	bfi	r1, r6, #0, #2
	ldrb	r6, [fp, #-47]
	bfi	r1, r7, #2, #2
	strb	r1, [fp, #-46]
	bfi	r6, ip, #6, #2
	strb	r6, [fp, #-47]
	beq	.L33
.L11:
	add	r1, r4, #20480
	movw	r6, #21846
	movt	r6, 21845
	ldrb	r8, [fp, #-47]
	ldr	ip, [r1, #3284]
	smull	r6, r7, ip, r6
	sub	r6, r7, ip, asr #31
	add	r6, r6, r6, lsl #1
	rsb	ip, r6, ip
	bfi	r8, ip, #2, #2
	strb	r8, [fp, #-47]
.L15:
	ldr	r9, [r1, #3280]
	movw	r6, #21846
	movt	r6, 21845
	add	ip, r4, #32768
	ldrb	r8, [fp, #-46]
	and	lr, lr, #7
	smull	r6, r7, r9, r6
	ldr	r6, [ip, #3372]
	ldr	r10, [ip, #3384]
	and	r8, r8, #239
	rsb	r6, r6, r3
	sub	r7, r7, r9, asr #31
	add	r6, r6, r10
	ldrb	r10, [fp, #-47]
	and	r6, r6, #15
	add	r7, r7, r7, lsl #1
	rsb	r9, r7, r9
	orr	r8, r8, #32
	add	lr, lr, r6, lsl #3
	bfi	r10, r9, #0, #2
	strb	lr, [fp, #-48]
	strb	r10, [fp, #-47]
	strb	r8, [fp, #-46]
	ldr	lr, [fp, #-48]
	str	lr, [r5, #4]
	ldr	r6, [ip, #3372]
	ldr	r5, [ip, #3384]
	ldr	lr, [r0, #8]
	rsb	r3, r6, r3
	add	r3, r3, r5
	bic	r3, r3, #15
	str	r3, [lr, #8]
	ldrb	r3, [r4, #3096]
	cmp	r3, #0
	beq	.L16
	ldr	r3, [r2, #392]
	cmp	r3, #3
	beq	.L34
.L16:
	ldr	r3, [r1, #3284]
	sub	r3, r3, #1
	strh	r3, [fp, #-46]
.L17:
	ldr	r2, [r1, #3280]
	mov	r4, #3
	ldr	r3, [r0, #8]
	mov	lr, #0
	sub	r2, r2, #1
	strh	r2, [fp, #-48]
	ldr	r2, [fp, #-48]
	mov	r5, #0
	str	lr, [fp, #-48]
	bfi	r5, r4, #4, #4
	mov	r0, lr
	str	r2, [r3, #12]
	ldr	r1, [r1, #3280]
	adds	r2, r1, #127
	addmi	r2, r1, #254
	mov	r2, r2, lsr r4
	and	r2, r2, #4080
	strh	r2, [fp, #-48]
	ldr	r2, [fp, #-48]
	str	lr, [fp, #-48]
	strb	r5, [fp, #-48]
	str	r2, [r3, #16]
	ldr	r1, [ip, #3456]
	strb	r4, [fp, #-47]
	ldr	r2, [fp, #-48]
	str	r1, [r3, #20]
	ldr	r1, [ip, #3460]
	str	r1, [r3, #24]
	ldr	r1, [ip, #3464]
	str	r1, [r3, #28]
	ldr	r1, [ip, #3468]
	str	r1, [r3, #32]
	ldr	r1, [ip, #3472]
	str	r1, [r3, #36]
	ldr	r1, [ip, #3476]
	str	r1, [r3, #40]
	ldr	r1, [ip, #3480]
	str	r1, [r3, #44]
	str	r2, [r3, #48]
.L4:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L5:
	ldrb	r1, [r2, #259]
	cmp	r1, #0
	beq	.L12
	cmp	r1, #4
	beq	.L35
.L13:
	ldrb	r1, [r2, #251]
	ldrb	r6, [fp, #-47]
	cmp	r1, #4
	ldrb	r7, [r2]
	andne	ip, r1, #3
	ldrb	r1, [fp, #-46]
	moveq	ip, #3
	bfi	r6, ip, #6, #2
	and	r1, r1, #252
	strb	r6, [fp, #-47]
	bfi	r1, r7, #2, #2
	strb	r1, [fp, #-46]
	b	.L11
.L6:
	ldrb	r1, [fp, #-47]
	orr	r1, r1, #16
	strb	r1, [fp, #-47]
	ldrb	r1, [r2, #197]
	cmp	r1, #1
	bne	.L8
.L32:
	ldr	r1, [r2, #464]
	cmp	r1, #8
	ldrleb	r1, [fp, #-47]
	orrle	r1, r1, #32
	strleb	r1, [fp, #-47]
	b	.L8
.L35:
	ldrb	r1, [r2, #260]
	cmp	r1, #0
	bne	.L13
.L12:
	ldrb	r1, [fp, #-47]
	orr	r1, r1, #16
	strb	r1, [fp, #-47]
	b	.L13
.L34:
	ldr	r3, [r1, #3284]
	add	r3, r3, #1
	add	r3, r3, r3, lsr #31
	mov	r3, r3, asr #1
	sub	r3, r3, #1
	strh	r3, [fp, #-46]
	b	.L17
.L33:
	add	r1, r4, #20480
	movw	r6, #21846
	movt	r6, 21845
	ldrb	r8, [fp, #-47]
	ldr	ip, [r1, #3284]
	add	ip, ip, #1
	add	ip, ip, ip, lsr #31
	mov	r9, ip, asr #1
	smull	r6, r7, r9, r6
	sub	ip, r7, ip, asr #31
	add	ip, ip, ip, lsl #1
	rsb	ip, ip, r9
	bfi	r8, ip, #2, #2
	strb	r8, [fp, #-47]
	b	.L15
.L31:
	mov	r0, #53248
	str	r3, [fp, #-64]
	movt	r0, 63683
	str	r2, [fp, #-60]
	str	r1, [fp, #-56]
	bl	MEM_Phy2Vir
	subs	ip, r0, #0
	beq	.L3
	ldr	r3, [fp, #-64]
	ldr	r1, [fp, #-56]
	ldr	r2, [fp, #-60]
	str	ip, [r3, #8]
	b	.L2
.L3:
	ldr	r1, .L36+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4
.L37:
	.align	2
.L36:
	.word	g_HwMem
	.word	.LC0
	.fnend
	.size	BPD_CfgReg, .-BPD_CfgReg
	.align	2
	.global	BPD_Reset
	.type	BPD_Reset, %function
BPD_Reset:
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
	mov	r0, #53248
	movt	r0, 63683
	bl	MEM_Phy2Vir
	subs	r2, r0, #0
	beq	.L53
	ldr	r5, .L56
	ldr	r2, [r5]
	ldr	r4, [r2, #136]
	orr	r4, r4, #16
	str	r4, [r2, #136]
	ldr	r3, [r2, #372]
	tst	r3, #8
	bne	.L41
	movw	r0, #9999
	b	.L42
.L55:
	subs	r0, r0, #1
	beq	.L54
.L42:
	ldr	r3, [r2, #372]
	tst	r3, #8
	beq	.L55
.L41:
	ldr	r3, .L56+4
	bfc	r4, #4, #1
	mvn	r1, #1
	str	r4, [r2, #136]
	ldr	r3, [r3, #8]
	str	r1, [r3, #52]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L54:
	ldr	r1, .L56+8
	bl	dprint_vfmw
	ldr	r2, [r5]
	b	.L41
.L53:
	ldr	r1, .L56+12
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L57:
	.align	2
.L56:
	.word	g_pstRegCrg
	.word	g_HwMem
	.word	.LC2
	.word	.LC1
	.fnend
	.size	BPD_Reset, .-BPD_Reset
	.align	2
	.global	BPD_Start
	.type	BPD_Start, %function
BPD_Start:
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
	ldr	r3, .L59
	mov	r2, #0
	mov	r0, #1
	ldr	r1, [r3, #8]
	str	r2, [r1]
	ldr	r1, [r3, #8]
	str	r0, [r1]
	ldr	r3, [r3, #8]
	str	r2, [r3]
	ldmfd	sp, {fp, sp, pc}
.L60:
	.align	2
.L59:
	.word	g_HwMem
	.fnend
	.size	BPD_Start, .-BPD_Start
	.align	2
	.global	IsBpd_Ready
	.type	IsBpd_Ready, %function
IsBpd_Ready:
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
	ldr	r3, .L65
	ldr	r0, [r3, #8]
	cmp	r0, #0
	beq	.L64
	ldr	r0, [r0, #64]
	and	r0, r0, #1
	ldmfd	sp, {fp, sp, pc}
.L64:
	ldr	r3, .L65+4
	ldr	r2, .L65+8
	ldr	r1, .L65+12
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L66:
	.align	2
.L65:
	.word	g_HwMem
	.word	.LC3
	.word	.LANCHOR0
	.word	.LC4
	.fnend
	.size	IsBpd_Ready, .-IsBpd_Ready
	.align	2
	.global	BPDDRV_WaitBpdReadyIfNoIsr
	.type	BPDDRV_WaitBpdReadyIfNoIsr, %function
BPDDRV_WaitBpdReadyIfNoIsr:
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
	ldr	r6, .L75
	mov	r4, #0
	ldr	r3, [r6]
	blx	r3
	mov	r5, r0
	b	.L70
.L74:
	ldr	r3, [r6]
	blx	r3
	cmp	r0, r5
	movcc	r5, #0
	rsb	r4, r5, r0
	cmp	r4, #4000
	bcs	.L72
.L70:
	bl	IsBpd_Ready
	cmp	r0, #0
	beq	.L74
	cmp	r4, #4000
	bcs	.L72
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L72:
	ldr	r1, .L75+4
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L76:
	.align	2
.L75:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC5
	.fnend
	.size	BPDDRV_WaitBpdReadyIfNoIsr, .-BPDDRV_WaitBpdReadyIfNoIsr
	.align	2
	.global	BPD_GetParam
	.type	BPD_GetParam, %function
BPD_GetParam:
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
	ldr	ip, .L84
	ldr	r4, [r2, #16]
	ldr	r3, [r2, #24]
	ldr	ip, [ip, #8]
	rsb	r5, r3, r4, lsl #3
	ldr	lr, [ip, #80]
	ldr	ip, [ip, #84]
	cmp	lr, r5
	bcs	.L82
	ldrb	r3, [r0, #3096]
	cmp	r3, #0
	bne	.L83
	and	r0, ip, #15
	ubfx	r3, ip, #8, #4
	str	r0, [r1, #328]
	ubfx	ip, ip, #4, #4
	str	r3, [r1, #332]
	str	ip, [r1, #336]
.L81:
	mov	r1, lr
	mov	r0, r2
	bl	BsLongSkip
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L83:
	ubfx	r3, ip, #0, #4
	ubfx	r0, ip, #12, #4
	strb	r3, [r1, #382]
	ubfx	r3, ip, #16, #4
	strb	r0, [r1, #385]
	ubfx	r0, ip, #20, #4
	strb	r3, [r1, #386]
	ubfx	r3, ip, #8, #4
	strb	r0, [r1, #387]
	ubfx	r0, ip, #24, #4
	strb	r3, [r1, #383]
	ubfx	r3, ip, #4, #4
	strb	r0, [r1, #388]
	ubfx	ip, ip, #28, #2
	strb	r3, [r1, #384]
	strb	ip, [r1, #378]
	b	.L81
.L82:
	rsb	r3, r3, r4
	mov	r2, lr
	ldr	r1, .L84+4
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L85:
	.align	2
.L84:
	.word	g_HwMem
	.word	.LC6
	.fnend
	.size	BPD_GetParam, .-BPD_GetParam
	.align	2
	.global	BPD_Drv
	.type	BPD_Drv, %function
BPD_Drv:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #24
	sub	sp, sp, #24
	push	{lr}
	bl	__gnu_mcount_nc
	add	ip, r1, #20480
	mov	r7, r0
	mov	r0, #2
	mov	r6, r2
	ldr	r3, [ip, #3284]
	mov	r2, #0
	mov	r5, r1
	str	r2, [fp, #-44]
	cmp	r3, r0
	mov	r2, #1
	str	r0, [fp, #-48]
	str	r2, [fp, #-40]
	ldr	ip, [ip, #3280]
	ble	.L88
	cmp	r3, #128
	sub	r4, ip, #3
	movle	r1, #0
	movgt	r1, #1
	cmp	r4, #125
	movls	r4, r1
	orrhi	r4, r1, #1
	cmp	r4, #0
	bne	.L88
	ldr	r8, .L100
	ldrb	r3, [r8]
	cmp	r3, #1
	beq	.L91
	mov	r1, r4
	str	r2, [sp]
	mov	r3, #400
	bl	VDH_Acquire_Usage
	mov	r0, r4
	sub	r1, fp, #48
	bl	VDH_Set_Parameter
.L91:
	ldr	r9, .L100+4
	bl	BPD_Reset
	mov	r2, r6
	mov	r1, r7
	mov	r0, r5
	mov	r3, r9
	bl	BPD_CfgReg
	cmp	r0, #0
	bne	.L92
	ldr	r3, [r9, #8]
	mov	r4, #1
	str	r0, [r3]
	ldr	r3, [r9, #8]
	str	r4, [r3]
	ldr	r3, [r9, #8]
	str	r0, [r3]
	bl	BPDDRV_WaitBpdReadyIfNoIsr
	cmp	r0, #0
	beq	.L99
.L93:
	ldrb	r3, [r8]
	cmp	r3, #1
	moveq	r0, r4
	beq	.L90
	mov	r5, #0
	sub	r1, fp, #48
	mov	r0, r5
	str	r5, [fp, #-40]
	bl	VDH_Set_Parameter
	mov	r1, r5
	mov	r2, #1
	mov	r0, #2
	bl	VDH_Loose_Usage
	mov	r0, r4
	b	.L90
.L88:
	mov	r3, r3, asl #4
	mov	r2, ip, asl #4
	ldr	r1, .L100+8
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #1
.L90:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L92:
	ldr	r1, .L100+12
	mov	r0, #0
	bl	dprint_vfmw
	mov	r4, #1
	b	.L93
.L99:
	mov	r2, r7
	mov	r1, r6
	mov	r0, r5
	bl	BPD_GetParam
	adds	r4, r0, #0
	movne	r4, #1
	b	.L93
.L101:
	.align	2
.L100:
	.word	g_HalDisable
	.word	g_HwMem
	.word	.LC7
	.word	.LC8
	.fnend
	.size	BPD_Drv, .-BPD_Drv
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	__func__.48783, %object
	.size	__func__.48783, 12
__func__.48783:
	.ascii	"IsBpd_Ready\000"
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"BPD register virtual address not mapped, reset fail"
	.ascii	"ed!\012\000"
.LC1:
	.ascii	"VDMHAL_ResetBPD: map BPD register fail, vir(reg) = "
	.ascii	"(%p)\012\000"
	.space	3
.LC2:
	.ascii	"Reset BPD Failed!\012\000"
	.space	1
.LC3:
	.ascii	"BPD register not mapped yet!\000"
	.space	3
.LC4:
	.ascii	"%s: %s\012\000"
.LC5:
	.ascii	"BPD TimeOut!\012\000"
	.space	2
.LC6:
	.ascii	" BPD ERROR: EAT TOO MUCH BS %#x, but available bs n"
	.ascii	"um %#x!!!\012\000"
	.space	2
.LC7:
	.ascii	"NOT SUPPORT SIZE %d*%d\012\000"
.LC8:
	.ascii	"BPD error: no map reg!\012\000"
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
