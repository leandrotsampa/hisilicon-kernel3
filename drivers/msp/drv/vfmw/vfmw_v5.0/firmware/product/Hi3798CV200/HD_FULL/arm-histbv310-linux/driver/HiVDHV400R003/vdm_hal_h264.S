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
	.file	"vdm_hal_h264.c"

	.text
	.align	2
	.global	Write_V400R003_CabacTab
	.type	Write_V400R003_CabacTab, %function
Write_V400R003_CabacTab:
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
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L5:
	mov	r2, #121
	ldr	r1, .L6+8
	mov	r0, #22
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L7:
	.align	2
.L6:
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_CabacMN
	.word	.LC0
	.fnend
	.size	Write_V400R003_CabacTab, .-Write_V400R003_CabacTab
	.align	2
	.global	H264HAL_V400R003_InitHal
	.type	H264HAL_V400R003_InitHal, %function
H264HAL_V400R003_InitHal:
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
	ldr	r0, [r0, #1088]
	bl	Write_V400R003_CabacTab
	cmp	r0, #0
	ldmeqfd	sp, {fp, sp, pc}
	ldr	r1, .L13
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L14:
	.align	2
.L13:
	.word	.LC1
	.fnend
	.size	H264HAL_V400R003_InitHal, .-H264HAL_V400R003_InitHal
	.align	2
	.global	Get_V400R003_VirAddr
	.type	Get_V400R003_VirAddr, %function
Get_V400R003_VirAddr:
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
	add	r0, r1, r0, lsl #2
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Get_V400R003_VirAddr, .-Get_V400R003_VirAddr
	.align	2
	.global	Get_V400R003_PhyAddr
	.type	Get_V400R003_PhyAddr, %function
Get_V400R003_PhyAddr:
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
	add	r0, r1, r0, lsl #2
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	Get_V400R003_PhyAddr, .-Get_V400R003_PhyAddr
	.align	2
	.global	H264HAL_V400R003_CutSliceChain
	.type	H264HAL_V400R003_CutSliceChain, %function
H264HAL_V400R003_CutSliceChain:
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
	subs	r3, r0, #0
	beq	.L20
	mov	r0, #0
	str	r0, [r3, #252]
	ldmfd	sp, {fp, sp, pc}
.L20:
	ldr	r3, .L21
	ldr	r2, .L21+4
	ldr	r1, .L21+8
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L22:
	.align	2
.L21:
	.word	.LC2
	.word	.LANCHOR0
	.word	.LC3
	.fnend
	.size	H264HAL_V400R003_CutSliceChain, .-H264HAL_V400R003_CutSliceChain
	.align	2
	.global	Write_V400R003_Qmatrix
	.type	Write_V400R003_Qmatrix, %function
Write_V400R003_Qmatrix:
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
	subs	r9, r1, #0
	mov	r8, r0
	mov	r10, r2
	ldmeqfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	sub	r6, r3, #4
	sub	r7, r0, #4
	mov	r4, #0
.L25:
	ldr	r3, [r7, #4]!
	mov	r2, r4
	ldr	r1, .L28
	mov	r0, #4
	add	r4, r4, #1
	mov	r5, r7
	str	r3, [r6, #4]!
	ldr	r3, [r5], r10
	bl	dprint_vfmw
	ldr	r3, [r6]
	rsb	r2, r8, r5
	ldr	r1, .L28+4
	mov	r0, #4
	bl	dprint_vfmw
	cmp	r4, r9
	bne	.L25
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L29:
	.align	2
.L28:
	.word	.LC4
	.word	.LC5
	.fnend
	.size	Write_V400R003_Qmatrix, .-Write_V400R003_Qmatrix
	.align	2
	.global	H264HAL_V400R003_SetPicMsg
	.type	H264HAL_V400R003_SetPicMsg, %function
H264HAL_V400R003_SetPicMsg:
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
	mov	r5, r0
	mov	r0, r2
	str	r2, [fp, #-48]
	mov	r4, r3
	str	r1, [fp, #-52]
	bl	MEM_Phy2Vir
	subs	r7, r0, #0
	beq	.L62
	ldrb	r8, [r5]
	mov	r0, #4
	ldr	r3, [r5, #32]
	ldr	r1, [r5, #36]
	ldr	r6, [r5, #40]
	add	ip, r3, r8, lsl #1
	ldr	r8, .L65
	ldr	lr, [r5, #44]
	mov	r1, r1, asl #28
	ldr	r3, [r5, #28]
	add	r8, r8, ip, lsl #2
	ldr	ip, [r5, #20]
	orr	r1, r1, r6, asl #27
	ldr	r6, [r5, #16]
	orr	r1, r1, lr, asl #26
	ldr	r9, [r8, #60]
	sub	ip, ip, #1
	sub	r3, r3, #1
	cmp	r6, #0
	orr	r3, r1, r3
	ldrb	r8, [r5, #1]
	orr	lr, r3, ip, asl #16
	ldr	r10, [fp, #-48]
	orr	ip, lr, r9, asl #14
	movne	r6, #-2147483648
	cmp	r8, #1
	orr	ip, ip, r6
	mov	r2, r10
	ldr	r1, .L65+4
	moveq	r6, #33554432
	movne	r6, #0
	orr	ip, ip, r6
	str	ip, [r7]
	ldr	r3, [r7]
	bl	dprint_vfmw
	ldr	r3, [r5, #296]
	add	r2, r10, #4
	ldr	r1, .L65+8
	bic	r3, r3, #15
	mov	r0, #4
	str	r3, [r7, #4]
	ldr	r3, [r7, #4]
	bl	dprint_vfmw
	ldr	r3, [r5, #48]
	add	r2, r10, #8
	ldr	r1, .L65+12
	mov	r0, #4
	str	r3, [r7, #8]
	ldr	r3, [r7, #8]
	bl	dprint_vfmw
	ldr	r3, [r5, #32]
	cmp	r3, #0
	bne	.L63
	ldr	r6, [fp, #-48]
	mov	r0, #4
	str	r3, [r7, #12]
	ldr	r1, .L65+16
	add	r2, r6, #12
	str	r3, [r7, #16]
	ldr	r3, [r7, #12]
.L60:
	bl	dprint_vfmw
	add	r2, r6, #16
	ldr	r3, [r7, #16]
	mov	r0, #4
	ldr	r1, .L65+20
	bic	r4, r4, #15
	bl	dprint_vfmw
	ldr	r6, [fp, #-52]
	ldr	r8, [fp, #-48]
	mov	r0, #4
	ldr	r1, .L65+24
	ldr	r3, [r6, #1144]
	add	r2, r8, #20
	bic	r3, r3, #15
	str	r3, [r7, #20]
	ldr	r3, [r7, #20]
	bl	dprint_vfmw
	ldr	r3, [r6, #1148]
	add	r2, r8, #24
	ldr	r1, .L65+28
	bic	r3, r3, #15
	mov	r0, #4
	str	r3, [r7, #24]
	ldr	r3, [r7, #24]
	bl	dprint_vfmw
	ldrb	r3, [r5]
	ldr	r6, [fp, #-48]
	mov	r0, #4
	cmp	r3, #2
	ldreq	r2, [r5, #300]
	ldrne	r3, [r5, #300]
	ldreq	r1, [r5, #784]
	addne	r3, r5, r3, lsl #2
	ldrne	r3, [r3, #700]
	addeq	r2, r5, r2, lsl #2
	ldreq	r3, [r2, #700]
	add	r2, r6, #28
	addeq	r3, r3, r1
	ldr	r1, .L65+32
	bic	r3, r3, #15
	str	r3, [r7, #28]
	ldr	r3, [r7, #28]
	bl	dprint_vfmw
	ldr	r3, [fp, #-52]
	add	r2, r6, #32
	ldr	r1, .L65+36
	mov	r0, #4
	ldr	r3, [r3, #1152]
	bic	r3, r3, #15
	str	r3, [r7, #32]
	ldr	r3, [r7, #32]
	bl	dprint_vfmw
	str	r4, [r7, #36]
	add	r2, r6, #36
	ldr	r3, [r7, #36]
	ldr	r1, .L65+40
	mov	r0, #4
	bl	dprint_vfmw
	ldr	r4, [r5, #1000]
	cmp	r4, #0
	ldreq	r3, [fp, #-48]
	rsbeq	r10, r7, r3
	beq	.L39
	ldr	r3, [fp, #-48]
	add	r9, r5, #804
	add	r8, r7, #40
	mov	r6, #0
	rsb	r10, r7, r3
.L40:
	ldr	lr, [r9, #4]!
	mov	r3, r8
	add	r2, r6, #10
	mov	r0, #4
	ldr	r1, .L65+44
	add	r6, r6, #1
	add	lr, r5, lr, lsl #2
	ldr	lr, [lr, #308]
	bic	lr, lr, #15
	str	lr, [r3], r10
	ldr	ip, [r8]
	add	r8, r8, r0
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r4, [r5, #1000]
	cmp	r4, r6
	bhi	.L40
	cmp	r4, #15
	bhi	.L44
.L39:
	add	r2, r4, #10
	add	r6, r7, r2, lsl #2
.L43:
	ldr	lr, [r5, #808]
	mov	r3, r6
	add	r4, r4, #1
	mov	r0, #4
	ldr	r1, .L65+44
	add	lr, r5, lr, lsl #2
	ldr	lr, [lr, #308]
	bic	lr, lr, #15
	str	lr, [r3], r10
	ldr	ip, [r6]
	add	r6, r6, r0
	str	ip, [sp]
	bl	dprint_vfmw
	cmp	r4, #15
	add	r2, r4, #10
	bls	.L43
.L44:
	ldr	r3, [fp, #-52]
	mov	r0, #4
	ldr	r2, [fp, #-48]
	ldr	r1, .L65+48
	ldr	r3, [r3, #1088]
	add	r2, r2, #104
	bic	r3, r3, #15
	str	r3, [r7, #104]
	ldr	r3, [r7, #104]
	bl	dprint_vfmw
	ldr	r6, [r5, #1000]
	cmp	r6, #0
	beq	.L64
	add	ip, r5, #868
	ldr	r3, [fp, #-48]
	add	r9, r7, #108
	add	r8, r7, #112
	str	r7, [fp, #-60]
	mov	r4, #0
	mov	r6, ip
	mov	r7, r10
	add	r3, r3, #108
	str	r3, [fp, #-56]
.L46:
	ldr	r0, [r6, #4]!
	mov	r3, r9
	mov	r10, r4, asl #1
	ldr	r1, .L65+44
	add	r2, r10, #27
	add	r4, r4, #1
	str	r0, [r3], r7
	mov	r0, #4
	ldr	lr, [r8, #-4]
	add	r9, r9, #8
	str	lr, [sp]
	bl	dprint_vfmw
	ldr	lr, [r6, #64]
	mov	r3, r8
	add	r2, r10, #28
	ldr	r1, .L65+44
	mov	r0, #4
	str	lr, [r3], r7
	add	r8, r8, #8
	ldr	lr, [r9, #-4]
	str	lr, [sp]
	bl	dprint_vfmw
	ldr	r3, [r5, #1000]
	cmp	r3, r4
	bhi	.L46
	cmp	r3, #15
	ldr	r7, [fp, #-60]
	mov	r6, r3
	bhi	.L48
.L45:
	ldr	r3, [fp, #-56]
	mov	ip, r6, asl #1
	add	r9, ip, #27
	add	r4, r7, r6, lsl #3
	rsb	r10, r7, r3
	ldr	r3, [fp, #-48]
	str	r5, [fp, #-56]
	mov	r8, #0
	add	r3, r3, #112
	mov	r5, r6
	mov	r6, r3
.L47:
	str	r8, [r4, #108]
	add	r3, r10, r4
	ldr	lr, [r4, #108]
	mov	r2, r9
	ldr	r1, .L65+44
	mov	r0, #4
	add	r5, r5, #1
	str	lr, [sp]
	bl	dprint_vfmw
	str	r8, [r4, #112]
	ldr	lr, [r4, #112]
	rsb	r3, r7, r6
	add	r3, r3, r4
	add	r2, r9, #1
	ldr	r1, .L65+44
	mov	r0, #4
	str	lr, [sp]
	add	r4, r4, #8
	bl	dprint_vfmw
	cmp	r5, #15
	add	r9, r9, #2
	bls	.L47
	ldr	r5, [fp, #-56]
.L48:
	ldr	r3, [fp, #-52]
	add	r0, r5, #60
	ldr	r1, [r3, #1160]
	ldr	r3, [fp, #-48]
	bic	r1, r1, #15
	str	r1, [r7, #236]
	ldr	ip, [r5, #292]
	add	r2, r3, #256
	mov	r1, #56
	add	r3, r7, #256
	add	ip, r5, ip, lsl #2
	ldr	ip, [ip, #564]
	bic	ip, ip, #15
	str	ip, [r7, #240]
	ldr	ip, [r5, #692]
	str	ip, [r7, #244]
	bl	Write_V400R003_Qmatrix
	mov	r0, #0
.L32:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L63:
	ldr	r3, [r5, #52]
	mov	r0, #4
	ldr	r6, [fp, #-48]
	ldr	r1, .L65+16
	str	r3, [r7, #12]
	add	r2, r6, #12
	ldr	ip, [r5, #56]
	ldr	r3, [r7, #12]
	str	ip, [r7, #16]
	b	.L60
.L64:
	ldr	r3, [fp, #-48]
	add	r3, r3, #108
	str	r3, [fp, #-56]
	b	.L45
.L62:
	ldr	r3, .L65+52
	ldr	r2, .L65+56
	ldr	r1, .L65+60
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L32
.L66:
	.align	2
.L65:
	.word	.LANCHOR0
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
	.word	.LC17
	.word	.LC18
	.word	.LC6
	.word	.LANCHOR0+32
	.word	.LC3
	.fnend
	.size	H264HAL_V400R003_SetPicMsg, .-H264HAL_V400R003_SetPicMsg
	.global	__aeabi_idiv
	.align	2
	.global	H264HAL_V400R003_SetSliceMsg
	.type	H264HAL_V400R003_SetSliceMsg, %function
H264HAL_V400R003_SetSliceMsg:
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
	str	r0, [fp, #-52]
	mov	r0, r3
	str	r3, [fp, #-48]
	mov	r10, r2
	bl	MEM_Phy2Vir
	subs	r8, r0, #0
	beq	.L227
	ldr	r3, [fp, #-48]
	add	ip, r10, #4
	add	r5, r8, #4
	str	r8, [fp, #-72]
	add	r6, r3, #4
	mov	r9, r8
	str	r8, [fp, #-60]
	mov	r4, #0
	mov	r8, ip
	str	r10, [fp, #-64]
.L72:
	ldr	r7, [r8, #4]!
	sub	r3, r6, #4
	mov	r2, r4
	ldr	r1, .L246
	cmp	r7, #0
	mov	r0, #4
	add	ip, r4, #1
	beq	.L70
	ldr	r7, [r8, #16]
	mov	r2, ip
	ldr	r3, [r8, #8]
	ldr	r1, [fp, #-52]
	add	r10, r3, r7, lsl #3
	str	ip, [fp, #-68]
	and	r10, r10, #127
	ldr	lr, [r1, #800]
	str	r7, [sp, #4]
	bic	r7, r7, #15
	str	r3, [sp]
	bic	r3, lr, #15
	ldr	r1, .L246+4
	str	r3, [fp, #-56]
	mov	r3, r10
	bl	dprint_vfmw
	str	r10, [r5]
	ldr	ip, [fp, #-68]
	mov	r3, r6
	ldr	lr, [r9, #4]
	mov	r0, #4
	ldr	r1, .L246
	mov	r2, ip
	str	lr, [sp]
	bl	dprint_vfmw
	ldr	ip, [r8]
	add	r3, r6, #4
	add	r2, r4, #2
	ldr	r1, .L246
	mov	r0, #4
	str	ip, [r5, #4]
	ldr	ip, [r5, #4]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [fp, #-56]
	mov	r2, r4
	ldr	r1, .L246
	rsb	r7, r3, r7
	str	r7, [r9]
	ldr	ip, [r5, #-4]
	sub	r3, r6, #4
	mov	r0, #4
	str	ip, [sp]
	bl	dprint_vfmw
.L71:
	add	r4, r4, #3
	add	r5, r5, #12
	cmp	r4, #6
	add	r9, r9, #12
	add	r6, r6, #12
	bne	.L72
	ldr	r10, [fp, #-64]
	mov	r0, #4
	ldr	r3, [fp, #-48]
	ldr	r8, [fp, #-60]
	ldr	ip, [r10, #48]
	add	r2, r3, #24
	ldr	lr, [r10, #36]
	ldr	r3, [r10, #32]
	ubfx	ip, ip, #0, #20
	and	lr, lr, #3
	ldr	r1, .L246+8
	orr	r3, ip, r3, asl #26
	orr	r3, r3, lr, asl #24
	str	r3, [r8, #24]
	ldr	r3, [r8, #24]
	bl	dprint_vfmw
	ldr	r3, .L246+12
	ldrb	lr, [r10, #3]
	ldrb	r3, [r3]
	cmp	r3, #0
	bne	.L74
	cmp	lr, #0
	beq	.L228
.L74:
	ldr	r3, [r10, #56]
	mov	r0, #4
	ldrb	r1, [r10]
	ldr	r4, [r10, #52]
	ldr	ip, [r10, #40]
	mov	r3, r3, asl #8
	ldr	r9, .L246+16
	ldr	r5, [r10, #44]
	and	ip, ip, #31
	add	r1, r9, r1, lsl #2
	orr	r4, r3, r4, asl #2
	and	r5, r5, #31
	ldrb	r6, [r10, #2]
	ldr	r1, [r1, #124]
	orr	r4, r4, ip, asl #21
	orr	r3, r4, r5, asl #16
	ldr	r2, [fp, #-48]
	orr	r3, r3, r1
	ldr	r1, .L246+20
	orr	r3, r3, r6, asl #15
	add	r2, r2, #28
	orr	lr, r3, lr, asl #14
	str	lr, [r8, #28]
	ldr	r3, [r8, #28]
	bl	dprint_vfmw
	ldrb	r3, [r10]
	add	r3, r9, r3, lsl #2
	ldr	r3, [r3, #124]
	cmp	r3, #2
	movne	r3, #0
	movne	r2, r3
	beq	.L229
.L75:
	ldr	r5, [fp, #-48]
	mov	r0, #4
	str	r2, [r8, #32]
	ldr	r1, .L246+24
	add	r2, r5, #32
	str	r3, [r8, #36]
	ldr	r3, [r8, #32]
	bl	dprint_vfmw
	ldr	r3, [r8, #36]
	add	r2, r5, #36
	ldr	r1, .L246+28
	mov	r0, #4
	bl	dprint_vfmw
	ldr	ip, [r10, #60]
	ldrb	lr, [r10, #4]
	add	r2, r5, #40
	and	ip, ip, #31
	ldr	r3, [r10, #64]
	ldr	r1, .L246+32
	mov	r0, #4
	mov	ip, ip, asl #5
	and	r4, r3, #31
	orr	r3, ip, lr, asl #16
	orr	r3, r3, r4
	str	r3, [r8, #40]
	ldr	r3, [r8, #40]
	bl	dprint_vfmw
	ldr	ip, [r10, #68]
	ldr	r3, [r10, #72]
	add	r2, r5, #44
	and	ip, ip, #15
	ldr	lr, [r10, #76]
	and	r3, r3, #15
	ldr	r1, .L246+36
	mov	ip, ip, asl #16
	mov	r0, #4
	orr	r3, ip, r3, asl #8
	orr	r3, r3, lr
	str	r3, [r8, #44]
	ldr	r3, [r8, #44]
	bl	dprint_vfmw
	ldr	r3, [r10, #4056]
	cmp	r3, #0
	beq	.L79
	ldr	r0, [fp, #16]
.L80:
	ldr	r3, [fp, #8]
	str	r0, [r8, #176]
	bic	r3, r3, #15
	str	r3, [r8, #252]
	ldrb	r3, [r10]
	add	r3, r9, r3, lsl #2
	ldr	r3, [r3, #124]
	cmp	r3, #0
	beq	.L143
	ldr	r3, [fp, #-52]
	mov	r0, #4
	ldr	r2, [r10, #52]
	ldrb	r7, [r3]
	cmp	r7, #0
	beq	.L230
	ldr	r1, .L246+40
	bl	dprint_vfmw
	ldr	r3, [r10, #52]
	cmp	r3, #0
	beq	.L100
	mov	r7, #0
	mov	r3, #20
	str	r3, [fp, #-60]
	mov	r3, #12
	str	r3, [fp, #-56]
	mov	r3, r8
	mov	r4, r10
	mov	r5, r7
	mov	r8, r7
	mov	ip, r3
	b	.L118
.L101:
	cmp	r3, #2
	beq	.L109
	and	r6, r5, #3
	and	r3, r5, #7
.L108:
	cmp	r3, #7
	beq	.L231
.L116:
	cmp	r6, #3
	beq	.L232
.L117:
	ldr	r3, [r10, #52]
	add	r5, r5, #1
	add	r4, r4, #36
	cmp	r3, r5
	bls	.L233
.L118:
	ldrb	r3, [r4, #1624]
	cmp	r3, #1
	bne	.L101
	ldrb	r3, [r4, #1625]
	cmp	r3, #3
	beq	.L102
	ldr	r2, [fp, #-52]
	and	r3, r5, #7
	ldrb	r0, [r4, #1628]
	ldr	r1, [r2, #32]
	ldrb	r2, [r4, #1629]
	add	r1, r1, r0, lsl #1
	cmp	r2, #1
	add	r1, r9, r1, lsl #2
	moveq	lr, #8
	movne	lr, #0
	ldr	r2, [r1, #168]
	cmp	r0, #1
	mov	r0, r3, asl #2
	moveq	r1, #4
	movne	r1, #0
	and	r2, r2, #3
	orr	r1, r1, lr
	orr	r2, r1, r2
	orr	r7, r7, r2, asl r0
.L105:
	ldr	r2, [r4, #1644]
	and	r6, r5, #3
	cmp	r3, #7
	add	r1, r6, r6, lsl #2
	mov	r2, r2, asl #1
	and	r2, r2, #31
	orr	r8, r8, r2, asl r1
	bne	.L116
.L231:
	ldr	r2, [fp, #-56]
	mov	r0, #4
	ldr	r1, [fp, #-48]
	str	ip, [fp, #-64]
	str	r7, [ip, r2, asl #2]
	add	r3, r1, r2, lsl #2
	ldr	lr, [ip, r2, asl #2]
	add	ip, r2, #1
	ldr	r1, .L246+124
	mov	r7, #0
	str	ip, [fp, #-56]
	str	lr, [sp]
	bl	dprint_vfmw
	cmp	r6, #3
	ldr	ip, [fp, #-64]
	bne	.L117
.L232:
	ldr	r2, [fp, #-60]
	mov	r0, #4
	ldr	r1, [fp, #-48]
	str	ip, [fp, #-64]
	str	r8, [ip, r2, asl #2]
	add	r3, r1, r2, lsl #2
	ldr	lr, [ip, r2, asl #2]
	mov	r8, #0
	ldr	r1, .L246+124
	add	ip, r2, #1
	str	ip, [fp, #-60]
	str	lr, [sp]
	bl	dprint_vfmw
	ldr	ip, [fp, #-64]
	b	.L117
.L70:
	str	r7, [r9]
	ldr	ip, [r5, #-4]
	str	ip, [sp]
	bl	dprint_vfmw
	str	r7, [r5]
	ldr	ip, [r9, #4]
	mov	r3, r6
	add	r2, r4, #1
	ldr	r1, .L246
	mov	r0, #4
	str	ip, [sp]
	bl	dprint_vfmw
	str	r7, [r5, #4]
	ldr	ip, [r5, #4]
	add	r3, r6, #4
	add	r2, r4, #2
	ldr	r1, .L246
	mov	r0, #4
	str	ip, [sp]
	bl	dprint_vfmw
	b	.L71
.L240:
	ldr	r3, [fp, #-52]
	ldr	r3, [r3, #284]
	cmp	r3, #0
	beq	.L141
	ldrb	r3, [r10]
	add	r3, r9, r3, lsl #2
	ldr	r3, [r3, #124]
	cmp	r3, #1
	beq	.L142
.L141:
	ldr	r3, [fp, #-52]
	ldr	r3, [r3, #288]
	cmp	r3, #1
	bne	.L143
	ldrb	r3, [r10]
	add	r3, r9, r3, lsl #2
	ldr	r3, [r3, #124]
	cmp	r3, #2
	bne	.L143
.L142:
	ldr	r2, [r10, #44]
	mov	r0, #4
	ldr	r1, .L246+44
	mov	r4, r8
	bl	dprint_vfmw
	ldr	r6, [fp, #-48]
	mov	r7, r10
	mov	r5, r10
	mov	r8, #0
.L144:
	ldr	r0, [r5, #88]
	add	r3, r6, #256
	ldrb	r1, [r5, #856]
	add	r2, r8, #64
	ubfx	lr, r0, #0, #9
	ldr	r0, [r10, #80]
	add	r5, r5, #4
	mov	r1, r1, asl #12
	and	ip, r0, #7
	orr	r0, r1, lr, asl #3
	ldr	r1, .L246+124
	orr	r0, r0, ip
	str	r0, [r4, #256]
	ldr	ip, [r4, #256]
	mov	r0, #4
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r0, [r5, #212]
	ldrb	r1, [r5, #980]
	add	r3, r6, #512
	ubfx	lr, r0, #0, #9
	ldr	r0, [r10, #84]
	add	r2, r8, #128
	mov	r1, r1, asl #12
	and	ip, r0, #7
	orr	r0, r1, lr, asl #3
	ldr	r1, .L246+124
	orr	r0, r0, ip
	str	r0, [r4, #512]
	ldr	ip, [r4, #512]
	mov	r0, #4
	str	ip, [sp]
	bl	dprint_vfmw
	ldrb	r0, [r5, #1108]
	ldr	r1, [r5, #340]
	add	r3, r6, #768
	add	r2, r8, #192
	add	r8, r8, #1
	ubfx	r1, r1, #0, #9
	orr	r1, r1, r0, asl #9
	str	r1, [r4, #768]
	ldr	ip, [r4, #768]
	mov	r0, #4
	ldr	r1, .L246+124
	add	r4, r4, r0
	add	r6, r6, r0
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [r10, #44]
	cmp	r3, r8
	bcs	.L144
	ldr	r2, [r10, #80]
	mov	r0, #4
	ldr	r1, .L246+48
	add	r5, r10, #84
	bl	dprint_vfmw
	add	r4, r10, #852
	mov	r6, #0
.L145:
	ldr	r2, [r5, #4]!
	mov	r0, #4
	ldr	r1, .L246+52
	add	r6, r6, #1
	bl	dprint_vfmw
	ldr	r2, [r4, #4]!
	ldr	r1, .L246+56
	mov	r0, #4
	bl	dprint_vfmw
	ldr	r3, [r10, #44]
	cmp	r3, r6
	bcs	.L145
	ldrb	r3, [r10]
	add	r3, r9, r3, lsl #2
	ldr	r3, [r3, #124]
	cmp	r3, #2
	beq	.L146
.L149:
	ldr	r2, [r10, #84]
	mov	r0, #4
	ldr	r1, .L246+60
	add	r5, r10, #212
	bl	dprint_vfmw
	add	r4, r10, #980
	mov	r6, #0
.L147:
	ldr	r2, [r5, #4]!
	mov	r0, #4
	ldr	r1, .L246+64
	add	r6, r6, #1
	bl	dprint_vfmw
	ldr	r2, [r4, #4]!
	ldr	r1, .L246+68
	mov	r0, #4
	bl	dprint_vfmw
	ldr	r3, [r10, #44]
	cmp	r3, r6
	bcs	.L147
	ldrb	r3, [r10]
	add	r3, r9, r3, lsl #2
	ldr	r3, [r3, #124]
	cmp	r3, #2
	beq	.L234
.L150:
	add	r5, r10, #1104
	add	r6, r10, #340
	add	r5, r5, #4
	mov	r4, #0
.L152:
	ldr	r2, [r6, #4]!
	mov	r0, #4
	ldr	r1, .L246+72
	add	r4, r4, #1
	bl	dprint_vfmw
	ldr	r2, [r5, #4]!
	ldr	r1, .L246+76
	mov	r0, #4
	bl	dprint_vfmw
	ldr	r3, [r10, #44]
	cmp	r3, r4
	bcs	.L152
	ldrb	r3, [r10]
	add	r3, r9, r3, lsl #2
	ldr	r3, [r3, #124]
	cmp	r3, #2
	beq	.L235
.L143:
	mov	r0, #0
.L221:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L228:
	ldr	r3, [fp, #-52]
	movw	r2, #1620
	ldr	r1, [r3, #24]
	ldr	r3, [r3, #28]
	mul	r3, r3, r1
	cmp	r3, r2
	mvnhi	r0, #0
	bls	.L74
	b	.L221
.L230:
	ldr	r1, .L246+80
	bl	dprint_vfmw
	ldr	r3, [r10, #52]
	cmp	r3, #0
	beq	.L86
	mov	r3, #20
	mov	r5, r10
	str	r3, [fp, #-64]
	mov	ip, r10
	mov	r3, #12
	str	r8, [fp, #-56]
	mov	r4, r7
	str	r3, [fp, #-60]
	mov	r8, r7
	ldr	r10, [fp, #-52]
	b	.L90
.L88:
	cmp	r6, #3
	beq	.L236
.L89:
	ldr	r3, [ip, #52]
	cmp	r3, r4
	bls	.L237
.L90:
	ldrb	r1, [r5, #1626]
	and	r3, r4, #7
	ldr	r2, [r10, #32]
	and	r6, r4, #3
	add	r5, r5, #36
	add	r4, r4, #1
	add	r1, r2, r1, lsl #1
	ldrb	r2, [r5, #1591]
	add	r1, r9, r1, lsl #2
	cmp	r2, #1
	ldr	r2, [r5, #1608]
	ldr	r1, [r1, #136]
	moveq	r0, #8
	movne	r0, #0
	cmp	r3, #7
	and	r1, r1, #3
	mov	r2, r2, asl #1
	orr	r1, r0, r1
	and	r2, r2, #31
	mov	r3, r3, asl #2
	add	r0, r6, r6, lsl #2
	orr	r8, r8, r1, asl r3
	orr	r7, r7, r2, asl r0
	bne	.L88
	ldr	r1, [fp, #-56]
	str	ip, [fp, #-68]
	ldr	ip, [fp, #-60]
	ldr	r0, [fp, #-48]
	str	r8, [r1, ip, asl #2]
	add	r3, r0, ip, lsl #2
	ldr	lr, [r1, ip, asl #2]
	mov	r2, ip
	ldr	r1, .L246+124
	mov	r0, #4
	add	ip, ip, #1
	str	ip, [fp, #-60]
	str	lr, [sp]
	mov	r8, #0
	bl	dprint_vfmw
	cmp	r6, #3
	ldr	ip, [fp, #-68]
	bne	.L89
.L236:
	ldr	r1, [fp, #-56]
	str	ip, [fp, #-68]
	ldr	ip, [fp, #-64]
	ldr	r0, [fp, #-48]
	str	r7, [r1, ip, asl #2]
	add	r3, r0, ip, lsl #2
	ldr	lr, [r1, ip, asl #2]
	mov	r2, ip
	ldr	r1, .L246+124
	mov	r0, #4
	add	ip, ip, #1
	str	ip, [fp, #-64]
	str	lr, [sp]
	mov	r7, #0
	bl	dprint_vfmw
	ldr	ip, [fp, #-68]
	ldr	r3, [ip, #52]
	cmp	r3, r4
	bhi	.L90
.L237:
	tst	r3, #7
	mov	r10, ip
	mov	ip, r8
	ldr	r8, [fp, #-56]
	bne	.L238
.L86:
	ldr	r2, [r10, #56]
	mov	r0, #4
	ldr	r1, .L246+84
	bl	dprint_vfmw
	ldrb	r3, [r10]
	add	r3, r9, r3, lsl #2
	ldr	r3, [r3, #124]
	cmp	r3, #2
	beq	.L239
.L93:
	mov	r5, r10
	mov	r4, #0
	ldr	r1, [r5, #3928]!
	mov	r6, #36
	and	r1, r1, #31
.L138:
	add	r4, r4, #1
	and	r3, r4, #3
	cmp	r4, #32
	add	r0, r3, r3, lsl #2
	beq	.L240
	ldr	r2, [r5, #4]!
	cmp	r3, #3
	and	r3, r2, #31
	orr	r1, r1, r3, asl r0
	bne	.L138
	str	r1, [r8, r6, asl #2]
	mov	r2, r6
	ldr	ip, [r8, r6, asl #2]
	mov	r0, #4
	ldr	r3, [fp, #-48]
	ldr	r1, .L246+124
	add	r3, r3, r6, lsl #2
	str	ip, [sp]
	bl	dprint_vfmw
	add	r6, r6, #1
	mov	r1, #0
	b	.L138
.L109:
	ldrb	r3, [r4, #1625]
	cmp	r3, #3
	beq	.L110
	ldr	r2, [fp, #-52]
	and	r3, r5, #7
	ldrb	r0, [r4, #1630]
	ldr	r1, [r2, #32]
	ldrb	r2, [r4, #1631]
	add	r1, r1, r0, lsl #1
	cmp	r2, #1
	add	r1, r9, r1, lsl #2
	moveq	lr, #8
	movne	lr, #0
	ldr	r2, [r1, #168]
	cmp	r0, #1
	mov	r0, r3, asl #2
	moveq	r1, #4
	movne	r1, #0
	and	r2, r2, #3
	orr	r1, r1, lr
	orr	r2, r1, r2
	orr	r7, r7, r2, asl r0
.L113:
	ldr	r2, [r4, #1644]
	and	r6, r5, #3
	add	r1, r6, r6, lsl #2
	mov	r2, r2, asl #1
	and	r2, r2, #30
	orr	r2, r2, #1
	orr	r8, r8, r2, asl r1
	b	.L108
.L233:
	tst	r3, #7
	mov	r2, ip
	mov	ip, r7
	mov	r7, r8
	mov	r8, r2
	beq	.L100
	ldr	r2, [fp, #-56]
	mov	r0, #4
	ldr	r4, [fp, #-48]
	ldr	r1, .L246+124
	str	ip, [r8, r2, asl #2]
	add	r3, r4, r2, lsl #2
	ldr	ip, [r8, r2, asl #2]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r2, [fp, #-60]
	ldr	r1, .L246+124
	mov	r0, #4
	str	r7, [r8, r2, asl #2]
	add	r3, r4, r2, lsl #2
	ldr	ip, [r8, r2, asl #2]
	str	ip, [sp]
	bl	dprint_vfmw
.L100:
	ldrb	r3, [r10]
	add	r3, r9, r3, lsl #2
	ldr	r3, [r3, #124]
	cmp	r3, #2
	bne	.L93
	ldr	r2, [r10, #56]
	mov	r0, #4
	ldr	r1, .L246+88
	bl	dprint_vfmw
	ldr	r3, [r10, #56]
	cmp	r3, #0
	beq	.L93
	mov	r7, #0
	mov	r3, #28
	str	r8, [fp, #-64]
	mov	r5, r10
	str	r3, [fp, #-60]
	mov	r4, r7
	mov	r3, #16
	mov	r8, r7
	str	r3, [fp, #-56]
	ldr	ip, [fp, #-52]
	b	.L137
.L120:
	cmp	r3, #2
	beq	.L128
	and	r6, r4, #3
	and	r3, r4, #7
.L127:
	cmp	r3, #7
	beq	.L241
.L135:
	cmp	r6, #3
	beq	.L242
.L136:
	ldr	r3, [r10, #56]
	add	r4, r4, #1
	add	r5, r5, #36
	cmp	r3, r4
	bls	.L243
.L137:
	ldrb	r3, [r5, #2776]
	cmp	r3, #1
	bne	.L120
	ldrb	r3, [r5, #2777]
	cmp	r3, #3
	beq	.L121
	ldrb	r0, [r5, #2780]
	and	r3, r4, #7
	ldr	r2, [ip, #32]
	ldrb	r1, [r5, #2781]
	add	r2, r2, r0, lsl #1
.L223:
	cmp	r1, #1
	add	r2, r9, r2, lsl #2
	and	r6, r4, #3
	moveq	r1, #8
	movne	r1, #0
	ldr	r2, [r2, #168]
	cmp	r0, #1
	and	r2, r2, #3
	moveq	r0, #4
	movne	r0, #0
	orr	r1, r0, r1
	orr	r2, r1, r2
	mov	r0, r3, asl #2
	add	r1, r6, r6, lsl #2
	orr	r7, r7, r2, asl r0
	ldr	r2, [r5, #2796]
	mov	r2, r2, asl #1
	and	r2, r2, #31
	orr	r8, r8, r2, asl r1
	b	.L127
.L102:
	ldr	r2, [fp, #-52]
	and	r3, r5, #7
	ldrb	r0, [r4, #1626]
	ldrb	r1, [r4, #1629]
	ldr	r2, [r2, #32]
	cmp	r1, #1
	add	r2, r2, r0, lsl #1
	ldrb	r0, [r4, #1628]
	moveq	r1, #8
	movne	r1, #0
	add	r2, r9, r2, lsl #2
	cmp	r0, #1
	ldr	r2, [r2, #168]
	moveq	r0, #4
	movne	r0, #0
	orr	r1, r0, r1
	and	r2, r2, #3
	mov	r0, r3, asl #2
	orr	r2, r1, r2
	orr	r7, r7, r2, asl r0
	b	.L105
.L238:
	ldr	r2, [fp, #-60]
	mov	r0, #4
	ldr	r4, [fp, #-48]
	ldr	r1, .L246+124
	str	ip, [r8, r2, asl #2]
	add	r3, r4, r2, lsl #2
	ldr	ip, [r8, r2, asl #2]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r2, [fp, #-64]
	ldr	r1, .L246+124
	mov	r0, #4
	str	r7, [r8, r2, asl #2]
	add	r3, r4, r2, lsl #2
	ldr	ip, [r8, r2, asl #2]
	str	ip, [sp]
	bl	dprint_vfmw
	b	.L86
.L110:
	ldr	r2, [fp, #-52]
	and	r3, r5, #7
	ldrb	r0, [r4, #1626]
	ldrb	r1, [r4, #1631]
	ldr	r2, [r2, #32]
	cmp	r1, #1
	add	r2, r2, r0, lsl #1
	ldrb	r0, [r4, #1630]
	moveq	r1, #8
	movne	r1, #0
	add	r2, r9, r2, lsl #2
	cmp	r0, #1
	ldr	r2, [r2, #168]
	moveq	r0, #4
	movne	r0, #0
	orr	r1, r0, r1
	and	r2, r2, #3
	mov	r0, r3, asl #2
	orr	r2, r1, r2
	orr	r7, r7, r2, asl r0
	b	.L113
.L79:
	ldr	r3, [fp, #-52]
	ldrb	r1, [r10, #1]
	ldr	r0, [r3, #804]
	cmp	r0, #262144
	addgt	r1, r1, #1
	addle	r1, r1, #1
	movwgt	r0, #65535
	suble	r0, r0, #1
	movtgt	r0, 3
	bl	__aeabi_idiv
	b	.L80
.L229:
	ldr	r2, [r10, #2788]
	mov	r0, #4
	ldr	r1, .L246+92
	bl	dprint_vfmw
	ldr	r3, [fp, #-52]
	ldrb	r3, [r3]
	cmp	r3, #0
	bne	.L76
	ldrb	r3, [r10, #2778]
	cmp	r3, #3
	beq	.L77
.L78:
	ldr	r2, [r10, #2788]
	mov	r3, #0
	ldr	r1, [fp, #-52]
	add	r2, r1, r2, lsl #2
	ldr	r2, [r2, #700]
	bic	r2, r2, #15
	b	.L75
.L239:
	ldr	r3, [r10, #56]
	cmp	r3, #0
	beq	.L93
	mov	r7, #0
	mov	r3, #28
	mov	r5, r10
	str	r3, [fp, #-64]
	str	r8, [fp, #-56]
	mov	r3, #16
	mov	ip, r10
	mov	r4, r7
	str	r3, [fp, #-60]
	mov	r8, r7
	ldr	r10, [fp, #-52]
	b	.L97
.L95:
	cmp	r6, #3
	beq	.L244
.L96:
	ldr	r3, [ip, #56]
	cmp	r3, r4
	bls	.L245
.L97:
	ldrb	r1, [r5, #2778]
	and	r3, r4, #7
	ldr	r2, [r10, #32]
	and	r6, r4, #3
	add	r5, r5, #36
	add	r4, r4, #1
	add	r1, r2, r1, lsl #1
	ldrb	r2, [r5, #2743]
	add	r1, r9, r1, lsl #2
	cmp	r2, #1
	ldr	r2, [r5, #2760]
	ldr	r1, [r1, #136]
	moveq	r0, #8
	movne	r0, #0
	cmp	r3, #7
	and	r1, r1, #3
	mov	r2, r2, asl #1
	orr	r1, r0, r1
	and	r2, r2, #31
	mov	r3, r3, asl #2
	add	r0, r6, r6, lsl #2
	orr	r8, r8, r1, asl r3
	orr	r7, r7, r2, asl r0
	bne	.L95
	ldr	r1, [fp, #-56]
	str	ip, [fp, #-68]
	ldr	ip, [fp, #-60]
	ldr	r0, [fp, #-48]
	str	r8, [r1, ip, asl #2]
	add	r3, r0, ip, lsl #2
	ldr	lr, [r1, ip, asl #2]
	mov	r2, ip
	ldr	r1, .L246+124
	mov	r0, #4
	add	ip, ip, #1
	str	ip, [fp, #-60]
	str	lr, [sp]
	mov	r8, #0
	bl	dprint_vfmw
	cmp	r6, #3
	ldr	ip, [fp, #-68]
	bne	.L96
.L244:
	ldr	r1, [fp, #-56]
	str	ip, [fp, #-68]
	ldr	ip, [fp, #-64]
	ldr	r0, [fp, #-48]
	str	r7, [r1, ip, asl #2]
	add	r3, r0, ip, lsl #2
	ldr	lr, [r1, ip, asl #2]
	mov	r2, ip
	ldr	r1, .L246+124
	mov	r0, #4
	add	ip, ip, #1
	mov	r7, #0
	str	lr, [sp]
	str	ip, [fp, #-64]
	bl	dprint_vfmw
	ldr	ip, [fp, #-68]
	b	.L96
.L245:
	tst	r3, #7
	mov	r10, ip
	mov	ip, r8
	ldr	r8, [fp, #-56]
	beq	.L93
	ldr	r2, [fp, #-60]
	mov	r0, #4
	ldr	r4, [fp, #-48]
	ldr	r1, .L246+124
	str	ip, [r8, r2, asl #2]
	add	r3, r4, r2, lsl #2
	ldr	ip, [r8, r2, asl #2]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r2, [fp, #-64]
.L225:
	str	r7, [r8, r2, asl #2]
	add	r3, r4, r2, lsl #2
	ldr	ip, [r8, r2, asl #2]
	mov	r0, #4
	ldr	r1, .L246+124
	str	ip, [sp]
	bl	dprint_vfmw
	b	.L93
.L76:
	ldr	r3, [r10, #2776]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #768
	beq	.L78
	ldrb	r3, [r10, #2776]
	cmp	r3, #1
	beq	.L78
	ldr	r1, [r10, #2788]
	mov	r3, #0
	ldr	r2, [fp, #-52]
	add	r1, r2, r1, lsl #2
	ldr	r0, [r2, #784]
	ldr	r2, [r1, #700]
	add	r2, r2, r0
	bic	r2, r2, #15
	b	.L75
.L235:
	add	r5, r10, #1488
	add	r6, r10, #724
	add	r5, r5, #4
	mov	r4, #0
.L154:
	ldr	r2, [r6, #4]!
	mov	r0, #4
	ldr	r1, .L246+96
	add	r4, r4, #1
	bl	dprint_vfmw
	ldr	r2, [r5, #4]!
	ldr	r1, .L246+100
	mov	r0, #4
	bl	dprint_vfmw
	ldr	r2, [r10, #40]
	cmp	r2, r4
	bcs	.L154
	ldrb	r3, [r10]
	add	r3, r9, r3, lsl #2
	ldr	r3, [r3, #124]
	cmp	r3, #2
	bne	.L143
	ldr	r1, .L246+104
	mov	r0, #4
	ldr	r4, [fp, #-48]
	bl	dprint_vfmw
	ldr	r6, [fp, #-72]
	mov	r5, #0
.L155:
	ldr	r8, [r7, #472]
	add	r3, r4, #384
	ldrb	ip, [r7, #1240]
	add	r2, r5, #96
	ldr	lr, [r10, #80]
	ubfx	r8, r8, #0, #9
	ldr	r1, .L246+124
	mov	r0, #4
	mov	ip, ip, asl #12
	and	lr, lr, #7
	orr	ip, ip, r8, asl #3
	orr	ip, ip, lr
	str	ip, [r6, #384]
	ldr	ip, [r6, #384]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	ip, [r7, #600]
	ldrb	r0, [r7, #1368]
	add	r3, r4, #640
	ldr	lr, [r10, #84]
	ubfx	ip, ip, #0, #9
	add	r2, r5, #160
	ldr	r1, .L246+124
	mov	r0, r0, asl #12
	and	lr, lr, #7
	orr	ip, r0, ip, asl #3
	mov	r0, #4
	orr	ip, ip, lr
	str	ip, [r6, #640]
	ldr	ip, [r6, #640]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	ip, [r7, #728]
	ldrb	lr, [r7, #1496]
	mov	r0, #4
	ubfx	ip, ip, #0, #9
	add	r3, r4, #896
	add	r2, r5, #224
	ldr	r1, .L246+124
	orr	ip, ip, lr, asl #9
	str	ip, [r6, #896]
	ldr	ip, [r6, #896]
	add	r7, r7, r0
	add	r6, r6, r0
	add	r4, r4, r0
	add	r5, r5, #1
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [r10, #40]
	cmp	r3, r5
	bcs	.L155
	b	.L143
.L77:
	ldr	r2, [r10, #2788]
	ldr	r1, [fp, #-52]
	add	r2, r1, r2, lsl #2
	ldr	r3, [r1, #784]
	ldr	r2, [r2, #700]
	add	r3, r2, r3
	bic	r2, r2, #15
	bic	r3, r3, #15
	b	.L75
.L128:
	ldrb	r3, [r5, #2777]
	cmp	r3, #3
	beq	.L129
	ldrb	r0, [r5, #2782]
	and	r3, r4, #7
	ldr	r2, [ip, #32]
	ldrb	r1, [r5, #2783]
	add	r2, r2, r0, lsl #1
.L224:
	cmp	r1, #1
	add	r2, r9, r2, lsl #2
	and	r6, r4, #3
	moveq	r1, #8
	movne	r1, #0
	ldr	r2, [r2, #168]
	cmp	r0, #1
	and	r2, r2, #3
	moveq	r0, #4
	movne	r0, #0
	orr	r1, r0, r1
	orr	r2, r1, r2
	mov	r0, r3, asl #2
	add	r1, r6, r6, lsl #2
	orr	r7, r7, r2, asl r0
	ldr	r2, [r5, #2796]
	mov	r2, r2, asl #1
	and	r2, r2, #30
	orr	r2, r2, #1
	orr	r8, r8, r2, asl r1
	b	.L127
.L247:
	.align	2
.L246:
	.word	.LC20
	.word	.LC19
	.word	.LC21
	.word	g_not_direct_8x8_inference_flag
	.word	.LANCHOR0
	.word	.LC22
	.word	.LC24
	.word	.LC25
	.word	.LC26
	.word	.LC27
	.word	.LC31
	.word	.LC33
	.word	.LC34
	.word	.LC35
	.word	.LC36
	.word	.LC37
	.word	.LC40
	.word	.LC41
	.word	.LC44
	.word	.LC45
	.word	.LC28
	.word	.LC30
	.word	.LC32
	.word	.LC23
	.word	.LC46
	.word	.LC47
	.word	.LC48
	.word	.LC42
	.word	.LC43
	.word	.LC38
	.word	.LC39
	.word	.LC29
	.word	.LC2
	.word	.LANCHOR0+92
	.word	.LC3
.L241:
	ldr	r1, [fp, #-64]
	str	ip, [fp, #-68]
	ldr	ip, [fp, #-56]
	ldr	r0, [fp, #-48]
	str	r7, [r1, ip, asl #2]
	add	r3, r0, ip, lsl #2
	ldr	lr, [r1, ip, asl #2]
	mov	r2, ip
	ldr	r1, .L246+124
	mov	r0, #4
	add	ip, ip, #1
	mov	r7, #0
	str	lr, [sp]
	str	ip, [fp, #-56]
	bl	dprint_vfmw
	ldr	ip, [fp, #-68]
	b	.L135
.L242:
	ldr	r1, [fp, #-64]
	str	ip, [fp, #-68]
	ldr	ip, [fp, #-60]
	ldr	r0, [fp, #-48]
	str	r8, [r1, ip, asl #2]
	add	r3, r0, ip, lsl #2
	ldr	lr, [r1, ip, asl #2]
	mov	r2, ip
	ldr	r1, .L246+124
	mov	r0, #4
	add	ip, ip, #1
	mov	r8, #0
	str	lr, [sp]
	str	ip, [fp, #-60]
	bl	dprint_vfmw
	ldr	ip, [fp, #-68]
	b	.L136
.L234:
	add	r5, r10, #1360
	add	r6, r10, #596
	add	r5, r5, #4
	mov	r4, #0
.L151:
	ldr	r2, [r6, #4]!
	mov	r0, #4
	ldr	r1, .L246+108
	add	r4, r4, #1
	bl	dprint_vfmw
	ldr	r2, [r5, #4]!
	ldr	r1, .L246+112
	mov	r0, #4
	bl	dprint_vfmw
	ldr	r3, [r10, #40]
	cmp	r3, r4
	bcs	.L151
	b	.L150
.L146:
	add	r5, r10, #1232
	add	r6, r10, #468
	add	r5, r5, #4
	mov	r4, #0
.L148:
	ldr	r2, [r6, #4]!
	mov	r0, #4
	ldr	r1, .L246+116
	add	r4, r4, #1
	bl	dprint_vfmw
	ldr	r2, [r5, #4]!
	ldr	r1, .L246+120
	mov	r0, #4
	bl	dprint_vfmw
	ldr	r3, [r10, #40]
	cmp	r3, r4
	bcs	.L148
	b	.L149
.L243:
	tst	r3, #7
	mov	ip, r7
	mov	r7, r8
	ldr	r8, [fp, #-64]
	beq	.L93
	ldr	r2, [fp, #-56]
	mov	r0, #4
	ldr	r4, [fp, #-48]
	ldr	r1, .L246+124
	str	ip, [r8, r2, asl #2]
	add	r3, r4, r2, lsl #2
	ldr	ip, [r8, r2, asl #2]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r2, [fp, #-60]
	b	.L225
.L121:
	ldrb	r0, [r5, #2778]
	and	r3, r4, #7
	ldr	r2, [ip, #32]
	ldrb	r1, [r5, #2781]
	add	r2, r2, r0, lsl #1
	ldrb	r0, [r5, #2780]
	b	.L223
.L129:
	ldrb	r0, [r5, #2778]
	and	r3, r4, #7
	ldr	r2, [ip, #32]
	ldrb	r1, [r5, #2783]
	add	r2, r2, r0, lsl #1
	ldrb	r0, [r5, #2782]
	b	.L224
.L227:
	ldr	r3, .L246+128
	ldr	r2, .L246+132
	ldr	r1, .L246+136
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L221
	.fnend
	.size	H264HAL_V400R003_SetSliceMsg, .-H264HAL_V400R003_SetSliceMsg
	.align	2
	.global	H264HAL_V400R003_StartDec
	.type	H264HAL_V400R003_StartDec, %function
H264HAL_V400R003_StartDec:
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
	ldr	r4, .L312
	mov	ip, #44
	ldr	lr, .L312+4
	mov	r8, r2
	ldr	r3, .L312+8
	clz	r2, r2
	mla	ip, ip, r1, r4
	ldrb	lr, [lr]
	mov	r2, r2, lsr #5
	mov	r6, r0
	cmp	lr, #1
	moveq	r2, #0
	cmp	r2, #0
	ldr	ip, [ip, #8]
	ldr	r3, [r3, ip, asl #2]
	ldr	r9, [r3, #1192]
	bne	.L299
	cmp	r1, #0
	beq	.L252
	cmp	r1, #1
	bne	.L300
	str	r2, [sp]
	mov	r3, r1
	mov	r0, r2
	ldr	r1, .L312+12
	ldr	r2, .L312+16
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L250
.L252:
	cmp	r0, #0
	beq	.L301
	ldr	r3, [r0, #28]
	cmp	r3, #512
	bhi	.L256
	ldr	r3, [r0, #20]
	cmp	r3, #512
	bhi	.L256
	ldr	r0, [r0, #1008]
	cmp	r0, #0
	beq	.L302
	ldr	r7, .L312+20
	ldr	r3, [r7]
	cmp	r3, #0
	beq	.L303
.L258:
	ldr	r3, .L312+24
	mov	r0, #3
	ldr	r1, .L312+28
	mov	r5, #1
	ldr	r2, [r3]
	add	r2, r2, #1
	str	r2, [r3]
	bl	dprint_vfmw
	ldr	ip, [r6, #804]
	mov	r3, #0
	str	r3, [fp, #-48]
	cmp	ip, #262144
	ldr	r1, [fp, #-48]
	suble	ip, ip, #1
	mov	r3, r8
	movwgt	ip, #65535
	ubfxle	ip, ip, #0, #20
	movtgt	ip, 3
	bfi	r1, ip, #0, #20
	str	r1, [fp, #-48]
	mov	r2, #0
	mov	ip, r1, lsr #24
	mov	r1, r1, lsr #16
	and	ip, ip, #62
	and	r1, r1, #191
	orr	ip, ip, #65
	bfc	r1, #7, #1
	bfc	ip, #1, #1
	strb	r1, [fp, #-46]
	strb	ip, [fp, #-45]
	mov	r0, #8
	ldr	r10, [fp, #-48]
	mov	r4, r2
	mov	r1, r10
	str	r10, [r6, #1020]
	bl	MFDE_ConfigReg
	mov	r2, r10
	ldr	r1, .L312+32
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r1, [r6, #1272]
	mov	r3, #0
	bfi	r3, r9, #3, #1
	ldrb	r0, [r6, #2]
	bfi	r3, r1, #4, #1
	mov	r2, #0
	and	r3, r3, #223
	bfi	r2, r4, #5, #1
	strh	r5, [fp, #-46]
	bfi	r3, r0, #6, #1
	strb	r2, [fp, #-45]
	ldr	r0, [r6, #1268]
	uxtb	r1, r2
	mvn	r3, r3, asl #25
	mov	r2, #0
	bfi	r1, r0, #6, #1
	bfi	r2, r4, #0, #4
	mvn	r3, r3, lsr #25
	strb	r2, [fp, #-48]
	strb	r3, [fp, #-47]
	mov	r3, r1
	bfi	r3, r4, #7, #1
	strb	r3, [fp, #-45]
	ldr	r9, [fp, #-48]
	mov	r3, r8
	mov	r2, r4
	mov	r0, #12
	mov	r1, r9
	str	r9, [r6, #1024]
	bl	MFDE_ConfigReg
	mov	r2, r9
	ldr	r1, .L312+36
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r9, [r7, #56]
	mov	r3, r8
	mov	r2, r4
	bic	r9, r9, #15
	mov	r0, #16
	str	r9, [r6, #1028]
	mov	r1, r9
	bl	MFDE_ConfigReg
	mov	r2, r9
	ldr	r1, .L312+40
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r9, [r7, #40]
	mov	r3, r8
	mov	r2, r4
	bic	r9, r9, #15
	mov	r0, #20
	str	r9, [r6, #1032]
	mov	r1, r9
	bl	MFDE_ConfigReg
	mov	r2, r9
	ldr	r1, .L312+44
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r9, [r6, #800]
	mov	r3, r8
	mov	r2, r4
	bic	r9, r9, #15
	mov	r0, #24
	str	r9, [r6, #1036]
	mov	r1, r9
	str	r9, [fp, #-48]
	bl	MFDE_ConfigReg
	ldr	r1, .L312+48
	mov	r2, r9
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r3, [r6, #28]
	cmp	r3, #256
	movhi	r1, r4
	bls	.L304
.L261:
	mov	r3, r8
	mov	r2, #0
	mov	r0, #4
	bl	SCD_ConfigReg
	movw	r1, #3075
	mov	r3, r8
	mov	r2, #0
	movt	r1, 48
	mov	r0, #60
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r8
	mov	r2, #0
	movt	r1, 48
	mov	r0, #64
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r8
	mov	r2, #0
	movt	r1, 48
	mov	r0, #68
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r8
	mov	r2, #0
	movt	r1, 48
	mov	r0, #72
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r8
	mov	r2, #0
	movt	r1, 48
	mov	r0, #76
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r8
	mov	r2, #0
	movt	r1, 48
	mov	r0, #80
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r8
	mov	r2, #0
	movt	r1, 48
	mov	r0, #84
	bl	MFDE_ConfigReg
	ldr	r1, [r6, #292]
	mov	r3, r8
	mov	r2, #0
	mov	r0, #96
	mov	r4, r2
	add	r1, r6, r1, lsl #2
	ldr	r5, [r1, #308]
	bic	r5, r5, #15
	str	r5, [r6, #1072]
	mov	r1, r5
	bl	MFDE_ConfigReg
	mov	r2, r5
	ldr	r1, .L312+52
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r5, [r6, #788]
	mov	r3, r8
	mov	r2, r4
	mov	r0, #100
	mov	r1, r5
	str	r5, [r6, #1076]
	bl	MFDE_ConfigReg
	mov	r2, r5
	ldr	r1, .L312+56
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r5, [r6, #304]
	mov	r3, r8
	mov	r2, r4
	mov	r0, #104
	mov	r1, r5
	str	r5, [r6, #1080]
	bl	MFDE_ConfigReg
	mov	r2, r5
	ldr	r1, .L312+60
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r5, [r6, #796]
	mov	r3, r8
	mov	r2, r4
	mov	r0, #108
	mov	r1, r5
	bl	MFDE_ConfigReg
	mov	r2, r5
	ldr	r1, .L312+64
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r5, [r7, #1164]
	mov	r3, r8
	mov	r2, r4
	bic	r5, r5, #15
	mov	r0, #128
	str	r5, [r6, #1096]
	mov	r1, r5
	bl	MFDE_ConfigReg
	mov	r2, r5
	ldr	r1, .L312+68
	mov	r0, #3
	bl	dprint_vfmw
	ldr	r1, [r7, #1168]
	str	r4, [fp, #-48]
	mov	r2, r4
	mov	r3, r8
	mov	r0, #132
	strh	r1, [fp, #-48]
	ldr	r5, [fp, #-48]
	mov	r1, r5
	str	r5, [r6, #1100]
	bl	MFDE_ConfigReg
	mov	r2, r5
	ldr	r1, .L312+72
	mov	r0, #3
	bl	dprint_vfmw
	add	r2, r6, #1136
	mov	r0, r4
.L262:
	ldr	r3, [r2, #4]!
	and	r3, r3, #3
	orr	r4, r4, r3, asl r0
	add	r0, r0, #2
	cmp	r0, #32
	bne	.L262
	mov	r3, r8
	mov	r1, r4
	mov	r2, #0
	mov	r0, #148
	str	r4, [fp, #-48]
	bl	MFDE_ConfigReg
	mov	r2, r4
	ldr	r1, .L312+76
	mov	r0, #3
	ldr	r9, .L312+20
	bl	dprint_vfmw
	ldrb	r1, [r6]
	ldr	r3, [r6, #32]
	mov	r0, #152
	ldr	r2, .L312+80
	mvn	r5, #0
	add	r3, r3, r1, lsl #1
	add	r3, r2, r3, lsl #2
	mov	r2, #0
	ldr	r3, [r3, #60]
	cmp	r3, #0
	mov	r3, r8
	movne	r1, #0
	moveq	r1, #2
	mov	r4, r1
	bl	MFDE_ConfigReg
	mov	r2, r4
	ldr	r1, .L312+84
	mov	r0, #3
	bl	dprint_vfmw
	mov	r3, r8
	mov	r1, r5
	mov	r2, #0
	mov	r0, #32
	str	r5, [fp, #-48]
	bl	MFDE_ConfigReg
	mov	r1, r9
	ldr	r3, [r7, #60]
	mov	r0, r6
	ldr	r2, [r7, #56]
	bl	H264HAL_V400R003_SetPicMsg
	ldr	r4, [r6, #1008]
	cmp	r4, #0
	beq	.L305
	ldr	r8, [r4, #48]
	cmp	r8, #0
	streq	r8, [fp, #-60]
	moveq	r2, r4
	bne	.L306
.L265:
	ldr	r0, [r6, #1004]
	cmp	r0, #0
	ble	.L267
	ldr	r3, [fp, #-60]
	mov	r8, #0
	mov	r4, r8
	add	ip, r3, #4
	add	r9, r3, #5
.L279:
	ldr	r1, [r2, #48]
	add	r3, r4, ip
	add	r10, r4, r9
	add	r3, r3, #10
	cmp	r1, r8
	add	r5, r10, #10
	movhi	lr, #0
	movls	lr, #1
	cmp	r4, #0
	movle	lr, #0
	cmp	lr, #0
	ldr	lr, [r7, r3, asl #2]
	ldr	r3, [r7, r5, asl #2]
	beq	.L307
.L268:
	ldr	r0, [r6, #1004]
	add	r4, r4, #1
	cmp	r0, r4
	bgt	.L279
.L278:
	cmp	r0, #0
	ble	.L267
	ldr	r3, [fp, #-60]
	add	r3, r3, r0
	add	r3, r3, #14
	ldr	r0, [r7, r3, asl #2]
	bl	H264HAL_V400R003_CutSliceChain
	mov	r0, #0
	b	.L250
.L307:
	add	r4, r4, #1
	cmp	r4, r0
	bge	.L286
	ldr	r5, [r2, #4056]
	cmp	r5, #0
	bne	.L298
	b	.L270
.L272:
	add	r4, r4, #1
	cmp	r4, r0
	bge	.L269
	ldr	r5, [r5, #4056]
	cmp	r5, #0
	beq	.L270
.L298:
	ldr	r8, [r5, #48]
	cmp	r1, r8
	bcs	.L272
.L269:
	cmp	r10, #140
	cmpne	r4, r0
	beq	.L308
	add	r8, r4, r9
	ldr	r0, [r5, #48]
	add	r8, r8, #10
	sub	r0, r0, #1
	ldr	r10, [r7, r8, asl #2]
.L275:
	ldr	r8, [r6, #1004]
	sub	r4, r4, #1
	str	ip, [fp, #-56]
	sub	r8, r8, #1
	cmp	r8, r4
	moveq	r8, #0
	streq	r8, [r2, #4056]
	str	r0, [sp, #12]
	mov	r8, r1
	str	r1, [sp, #8]
	mov	r0, r6
	str	r10, [sp, #4]
	str	lr, [sp]
	ldr	r1, .L312+20
	bl	H264HAL_V400R003_SetSliceMsg
	ldr	ip, [fp, #-56]
	cmp	r0, #0
	bne	.L309
	cmp	r10, #0
	beq	.L310
	mov	r2, r5
	b	.L268
.L270:
	movw	r2, #1277
	ldr	r1, .L312+88
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
.L250:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L300:
	mov	r0, r2
	ldr	r1, .L312+92
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L304:
	cmp	r3, #119
	ldrhi	r1, [r6, #1276]
	movls	r1, r5
	clzhi	r1, r1
	movhi	r1, r1, lsr #5
	b	.L261
.L306:
	ldr	r3, [r4, #8]
	mov	r2, #0
	ldr	r10, [r4, #28]
	mov	ip, #1
	str	r2, [r4, #48]
	mov	r1, r9
	str	r3, [fp, #-56]
	sub	lr, r8, #1
	ldr	r3, [r4, #12]
	str	r2, [r4, #28]
	str	r2, [r4, #12]
	str	r3, [fp, #-64]
	ldr	r3, [r4, #16]
	str	ip, [r4, #8]
	str	r2, [r4, #16]
	str	r3, [fp, #-68]
	ldr	r3, [r4, #20]
	str	r2, [r4, #20]
	str	ip, [fp, #-60]
	str	r3, [fp, #-72]
	ldr	r3, [r4, #24]
	str	r2, [r4, #24]
	ldr	r0, [r9, #64]
	str	r3, [fp, #-76]
	ldr	r3, [r9, #60]
	ldr	r9, [r9, #56]
	stmib	sp, {r0, r2}
	mov	r2, r4
	mov	r0, r6
	str	lr, [sp, #12]
	str	r9, [sp]
	bl	H264HAL_V400R003_SetSliceMsg
	ldr	ip, [fp, #-60]
	cmp	r0, #0
	bne	.L311
	ldr	r3, [fp, #-56]
	str	r8, [r4, #48]
	str	r10, [r4, #28]
	str	r3, [r4, #8]
	ldr	r3, [fp, #-64]
	str	ip, [fp, #-60]
	str	r3, [r4, #12]
	ldr	r3, [fp, #-68]
	str	r3, [r4, #16]
	ldr	r3, [fp, #-72]
	str	r3, [r4, #20]
	ldr	r3, [fp, #-76]
	str	r3, [r4, #24]
	ldr	r2, [r6, #1008]
	b	.L265
.L308:
	ldr	r0, [r6, #28]
	mov	r10, #0
	ldr	r8, [r6, #20]
	str	r10, [r2, #4056]
	str	r0, [fp, #-56]
	ldr	r0, [fp, #-56]
	mul	r0, r0, r8
	sub	r0, r0, #1
	b	.L275
.L303:
	mov	r0, #0
	movt	r0, 63683
	bl	MEM_Phy2Vir
	subs	r3, r0, #0
	beq	.L259
	str	r3, [r7]
	b	.L258
.L286:
	mov	r5, r2
	b	.L269
.L309:
	movw	r2, #1303
	ldr	r1, .L312+96
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L250
.L310:
	ldr	r0, [r6, #1004]
	b	.L278
.L256:
	ldr	r3, .L312+100
	mov	r0, #0
	ldr	r2, .L312+16
	ldr	r1, .L312+104
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L250
.L267:
	ldr	r1, .L312+108
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L250
.L311:
	mov	r0, ip
	movw	r2, #1231
	ldr	r1, .L312+96
	bl	dprint_vfmw
	mov	r0, r5
	b	.L250
.L305:
	mov	r0, r4
	ldr	r1, .L312+112
	bl	dprint_vfmw
	mov	r0, r5
	b	.L250
.L299:
	mov	r3, r8
	ldr	r2, .L312+16
	ldr	r1, .L312+116
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L250
.L302:
	ldr	r3, .L312+120
	ldr	r2, .L312+16
	ldr	r1, .L312+104
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L250
.L301:
	ldr	r3, .L312+124
	ldr	r2, .L312+16
	ldr	r1, .L312+104
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L250
.L259:
	ldr	r1, .L312+128
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L250
.L313:
	.align	2
.L312:
	.word	g_VdmDrvParam
	.word	g_HalDisable
	.word	s_pstVfmwChan
	.word	.LC51
	.word	.LANCHOR0+200
	.word	g_HwMem
	.word	.LANCHOR1
	.word	.LC56
	.word	.LC57
	.word	.LC58
	.word	.LC59
	.word	.LC60
	.word	.LC61
	.word	.LC62
	.word	.LC63
	.word	.LC64
	.word	.LC65
	.word	.LC66
	.word	.LC67
	.word	.LC68
	.word	.LANCHOR0
	.word	.LC69
	.word	.LC72
	.word	.LC50
	.word	.LC71
	.word	.LC53
	.word	.LC3
	.word	.LC73
	.word	.LC70
	.word	.LC49
	.word	.LC54
	.word	.LC52
	.word	.LC55
	.fnend
	.size	H264HAL_V400R003_StartDec, .-H264HAL_V400R003_StartDec
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	__func__.15061, %object
	.size	__func__.15061, 31
__func__.15061:
	.ascii	"H264HAL_V400R003_CutSliceChain\000"
	.space	1
	.type	__func__.15084, %object
	.size	__func__.15084, 27
__func__.15084:
	.ascii	"H264HAL_V400R003_SetPicMsg\000"
	.space	1
	.type	g_StructTrans, %object
	.size	g_StructTrans, 32
g_StructTrans:
	.word	0
	.word	3
	.word	1
	.word	1
	.word	2
	.word	2
	.word	3
	.word	3
	.type	__func__.15127, %object
	.size	__func__.15127, 29
__func__.15127:
	.ascii	"H264HAL_V400R003_SetSliceMsg\000"
	.space	3
	.type	g_SliceTypeForPMV, %object
	.size	g_SliceTypeForPMV, 12
g_SliceTypeForPMV:
	.word	1
	.word	2
	.word	0
	.type	g_ListStructFrame, %object
	.size	g_ListStructFrame, 32
g_ListStructFrame:
	.word	0
	.word	1
	.word	3
	.word	3
	.word	3
	.word	3
	.word	2
	.word	2
	.type	g_ListStructField, %object
	.size	g_ListStructField, 32
g_ListStructField:
	.word	0
	.word	1
	.word	2
	.word	2
	.word	2
	.word	2
	.word	2
	.word	2
	.type	__func__.15198, %object
	.size	__func__.15198, 26
__func__.15198:
	.ascii	"H264HAL_V400R003_StartDec\000"
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"line: %d, p = NULL is not expected value!\012\000"
	.space	1
.LC1:
	.ascii	"H264HAL_V400R003_InitHal return error.\012\000"
.LC2:
	.ascii	"can not map slice msg virtual address!\012\000"
.LC3:
	.ascii	"%s: %s\012\000"
.LC4:
	.ascii	"qmatrix[%d] = 0x%x\012\000"
.LC5:
	.ascii	"picmsg Dxx addr 0x%x = 0x%x\012\000"
	.space	3
.LC6:
	.ascii	"can not map down msg virtual address!\012\000"
	.space	1
.LC7:
	.ascii	"picmsg D[0] addr 0x%x = 0x%x\012\000"
	.space	2
.LC8:
	.ascii	"picmsg D[1] addr 0x%x = 0x%x\012\000"
	.space	2
.LC9:
	.ascii	"picmsg D[2] addr 0x%x = 0x%x\012\000"
	.space	2
.LC10:
	.ascii	"picmsg D[3] addr 0x%x = 0x%x\012\000"
	.space	2
.LC11:
	.ascii	"picmsg D[4] addr 0x%x = 0x%x\012\000"
	.space	2
.LC12:
	.ascii	"picmsg D[5] addr 0x%x = 0x%x\012\000"
	.space	2
.LC13:
	.ascii	"picmsg D[6] addr 0x%x = 0x%x\012\000"
	.space	2
.LC14:
	.ascii	"picmsg D[7] addr 0x%x = 0x%x\012\000"
	.space	2
.LC15:
	.ascii	"picmsg D[8] addr 0x%x = 0x%x\012\000"
	.space	2
.LC16:
	.ascii	"picmsg D[9] addr 0x%x = 0x%x\012\000"
	.space	2
.LC17:
	.ascii	"picmsg D[%d] addr 0x%x = 0x%x\012\000"
	.space	1
.LC18:
	.ascii	"picmsg D[26] addr 0x%x = 0x%x\012\000"
	.space	1
.LC19:
	.ascii	"Before slicemsg D[%d] tmp =0x%x,bitsoffset =0x%x,by"
	.ascii	"tespos = 0x%x\012\000"
	.space	2
.LC20:
	.ascii	"slicemsg D[%d] addr 0x%x = 0x%x\012\000"
	.space	3
.LC21:
	.ascii	"slicemsg D[4] addr 0x%x = 0x%x\012\000"
.LC22:
	.ascii	"slicemsg D[5] addr 0x%x = 0x%x\012\000"
.LC23:
	.ascii	"slicemsg g_pListX[1][0]->frame_store->pmv_address_i"
	.ascii	"dc = %d\012\000"
.LC24:
	.ascii	"slicemsg D[6] addr 0x%x = 0x%x\012\000"
.LC25:
	.ascii	"slicemsg D[7] addr 0x%x = 0x%x\012\000"
.LC26:
	.ascii	"slicemsg D[8] addr 0x%x = 0x%x\012\000"
.LC27:
	.ascii	"slicemsg D[9] addr 0x%x = 0x%x\012\000"
.LC28:
	.ascii	"slicemsg D10~D13  D18~D25 list0size = %d\012\000"
	.space	2
.LC29:
	.ascii	"slicemsg D[%d] address 0x%x = 0x%x\012\000"
.LC30:
	.ascii	"slicemsg D14~D17  D26~D33 list1size = %d\012\000"
	.space	2
.LC31:
	.ascii	"slicemsg D10~D13, D18~D25 list0size = %d\012\000"
	.space	2
.LC32:
	.ascii	"slicemsg D14~D17 D26 ~D33 list1size = %d\012\000"
	.space	2
.LC33:
	.ascii	"slicemsg burst1 D0~D31, burst2 D0~31, burst3 D0~D31"
	.ascii	" list0size = %d\012\000"
.LC34:
	.ascii	"luma_lg = %d\012\000"
	.space	2
.LC35:
	.ascii	"wp_weight_l0_y = %d\012\000"
	.space	3
.LC36:
	.ascii	"wp_offset_l0_y = %d\012\000"
	.space	3
.LC37:
	.ascii	"chroma_lg = %d\012\000"
.LC38:
	.ascii	"wp_weight_l1_y = %d\012\000"
	.space	3
.LC39:
	.ascii	"wp_offset_l1_y = %d\012\000"
	.space	3
.LC40:
	.ascii	"wp_weight_l0_u = %d\012\000"
	.space	3
.LC41:
	.ascii	"wp_offset_l0_u = %d\012\000"
	.space	3
.LC42:
	.ascii	"wp_weight_l1_u = %d\012\000"
	.space	3
.LC43:
	.ascii	"wp_offset_l1_u = %d\012\000"
	.space	3
.LC44:
	.ascii	"wp_weight_l0_v = %d\012\000"
	.space	3
.LC45:
	.ascii	"wp_offset_l0_v = %d\012\000"
	.space	3
.LC46:
	.ascii	"wp_weight_l1_v = %d\012\000"
	.space	3
.LC47:
	.ascii	"wp_offset_l1_v = %d\012\000"
	.space	3
.LC48:
	.ascii	"slicemsg burst1 D32~D63, burst2 D32~63, burst3 D32~"
	.ascii	"D63 list1size = %d\012\000"
	.space	1
.LC49:
	.ascii	"%s: pMfdeTask(%p) = NULL\012\000"
	.space	2
.LC50:
	.ascii	"VdhId is wrong! H264HAL_V200R003_StartDec\012\000"
	.space	1
.LC51:
	.ascii	"%s: VdhId(%d) > %d\012\000"
.LC52:
	.ascii	"point of picture para null\012\000"
.LC53:
	.ascii	"picture width out of range\012\000"
.LC54:
	.ascii	"point of fst slice para null\012\000"
	.space	2
.LC55:
	.ascii	"vdm register virtual address not mapped, reset fail"
	.ascii	"ed!\012\000"
.LC56:
	.ascii	"\012\012***********************H264HAL_V200R003_Sta"
	.ascii	"rtDec is Now %d***********************\012\000"
	.space	3
.LC57:
	.ascii	"BASIC_V400R003_CFG0 = 0x%x\012\000"
.LC58:
	.ascii	"BASIC_V400R003_CFG1 = 0x%x\012\000"
.LC59:
	.ascii	"AVM_V400R003_ADDR = 0x%x\012\000"
	.space	2
.LC60:
	.ascii	"VAM_V400R003_ADDR = 0x%x\012\000"
	.space	2
.LC61:
	.ascii	"STREAM_V400R003_BASE_ADDR = 0x%x\012\000"
	.space	2
.LC62:
	.ascii	"YSTADDR_V400R003_1D = 0x%x\012\000"
.LC63:
	.ascii	"YSTRIDE_V400R003_1D = 0x%x\012\000"
.LC64:
	.ascii	"UVOFFSET_V400R003_1D = 0x%x\012\000"
	.space	3
.LC65:
	.ascii	"HEAD_INF_OFFSET_V400R003_1D = 0x%x\012\000"
.LC66:
	.ascii	"PPFD_V400R003_BUF_ADDR = 0x%x\012\000"
	.space	1
.LC67:
	.ascii	"PPFD_V400R003_BUF_LEN = 0x%x\012\000"
	.space	2
.LC68:
	.ascii	"REF_V400R003_PIC_TYPE = 0x%x\012\000"
	.space	2
.LC69:
	.ascii	"FF_V400R003_APT_EN = 0x%x\012\000"
	.space	1
.LC70:
	.ascii	"pSlicePara = NULL!\012\000"
.LC71:
	.ascii	"line %d Set slice msg not wrong!\012\000"
	.space	2
.LC72:
	.ascii	"line %d tmp_pSlicePara is NULL!\012\000"
	.space	3
.LC73:
	.ascii	"!!! no slice to dec, add up msg report.\000"
	.bss
	.align	2
.LANCHOR1 = . + 0
	.type	StartCnt.15193, %object
	.size	StartCnt.15193, 4
StartCnt.15193:
	.space	4
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
