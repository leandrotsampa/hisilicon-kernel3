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
	.file	"postprocess.c"

	.text
	.align	2
	.global	PostPro_GetRepairStratage
	.type	PostPro_GetRepairStratage, %function
PostPro_GetRepairStratage:
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
	beq	.L4
	cmp	r0, #15
	beq	.L4
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L4:
	ldrb	r0, [r1, #3]
	clz	r0, r0
	mov	r0, r0, lsr #5
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	PostPro_GetRepairStratage, .-PostPro_GetRepairStratage
	.align	2
	.global	PostPro_CopyYuv
	.type	PostPro_CopyYuv, %function
PostPro_CopyYuv:
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
	ldr	ip, .L12
	mov	lr, #1744
	add	r3, r0, #12288
	ldr	r5, .L12+4
	mov	r9, #4
	mla	ip, lr, r1, ip
	ldr	r4, [r3, #2312]
	ldr	lr, [r3, #2300]
	ldr	r6, [r5, #128]
	mov	r5, #0
	ldr	r10, [r3, #2380]
	cmp	r6, #0
	str	r4, [ip, #12]
	mov	r4, #1
	str	lr, [ip, #4]
	str	lr, [ip, #8]
	ldr	lr, [r0, #216]
	str	lr, [ip, #16]
	ldr	lr, [r0, #224]
	str	lr, [ip, #20]
	ldrh	lr, [r0, #164]
	str	lr, [ip, #24]
	ldrh	r7, [r0, #166]
	moveq	r0, r4
	str	r10, [ip, #848]
	str	r9, [ip, #864]
	smulbb	lr, r7, lr
	str	r7, [ip, #28]
	str	r5, [ip, #36]
	strh	r5, [ip, #40]
	sub	lr, lr, #1
	str	r5, [ip, #852]
	strh	lr, [ip, #42]
	str	r4, [ip, #32]
	str	r4, [ip, #840]
	str	r4, [ip, #856]
	beq	.L10
	str	r2, [sp]
	mov	r3, r1
	mov	r2, r5
	mov	r1, r0
	mov	r0, #2
	blx	r6
	subs	r0, r0, r5
	movne	r0, #1
.L10:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L13:
	.align	2
.L12:
	.word	g_RepairParam
	.word	g_vdm_hal_fun_ptr
	.fnend
	.size	PostPro_CopyYuv, .-PostPro_CopyYuv
	.align	2
	.global	PostPro_CopyYuv_Vc1
	.type	PostPro_CopyYuv_Vc1, %function
PostPro_CopyYuv_Vc1:
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
	ldrh	r3, [r0, #74]
	mov	r8, r0
	str	r2, [fp, #-52]
	mov	r10, r1
	sub	r2, r3, #1
	cmp	r2, #2048
	movcc	r3, #16
	strcc	r3, [fp, #-48]
	bcc	.L15
	sub	r2, r3, #2048
	sub	r2, r2, #1
	cmp	r2, #2048
	movcc	r3, #32
	strcc	r3, [fp, #-48]
	bcs	.L22
.L15:
	ldr	r3, .L23
	mov	r4, #1744
	add	r5, r8, #12288
	mov	r7, #0
	mov	r6, #1
	ldr	r1, .L23+4
	mla	r4, r4, r10, r3
	ldr	ip, [r5, #96]
	ldr	lr, [r5, #264]
	mov	r0, #22
	ldr	r2, [r5, #224]
	ldr	r3, [r5, #268]
	str	ip, [r4, #8]
	ldr	ip, [r5, #100]
	str	r2, [r4, #4]
	mov	r2, lr
	str	lr, [r4, #24]
	str	ip, [r4, #16]
	ldr	ip, [r5, #108]
	str	r3, [r4, #28]
	str	r7, [r4, #36]
	str	ip, [r4, #20]
	str	r6, [r4, #32]
	bl	dprint_vfmw
	ldr	r0, .L23+8
	ldr	lr, [r4, #28]
	mov	r1, #4
	ldr	r9, [r4, #24]
	ldr	ip, [r5, #256]
	ldr	r5, [r0, #128]
	smulbb	lr, lr, r9
	ldr	r0, [fp, #-48]
	cmp	r5, r7
	str	ip, [r4, #848]
	str	r6, [r4, #840]
	sub	lr, lr, #1
	str	r0, [r4, #860]
	strh	r7, [r4, #40]
	moveq	r0, r6
	str	r6, [r4, #856]
	strh	lr, [r4, #42]
	str	r1, [r4, #864]
	str	r7, [r4, #844]
	str	r7, [r4, #852]
	beq	.L16
	ldr	r3, [fp, #-52]
	mov	r2, r7
	mov	r1, r8
	mov	r0, r6
	str	r3, [sp]
	mov	r3, r10
	blx	r5
	subs	r0, r0, r7
	movne	r0, #1
.L16:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L22:
	sub	r2, r3, #4096
	sub	r2, r2, #1
	cmp	r2, #2048
	movcc	r3, #48
	strcc	r3, [fp, #-48]
	bcc	.L15
	sub	r3, r3, #6144
	sub	r3, r3, #1
	cmp	r3, #2048
	movcs	r3, #16
	movcc	r3, #64
	str	r3, [fp, #-48]
	b	.L15
.L24:
	.align	2
.L23:
	.word	g_RepairParam
	.word	.LC0
	.word	g_vdm_hal_fun_ptr
	.fnend
	.size	PostPro_CopyYuv_Vc1, .-PostPro_CopyYuv_Vc1
	.align	2
	.global	PostPro_CopyYuv_Vp6
	.type	PostPro_CopyYuv_Vp6, %function
PostPro_CopyYuv_Vp6:
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
	ldr	r3, .L28
	mov	r4, #1744
	ldr	ip, [r0, #172]
	mov	r5, r0
	mov	r8, r2
	mov	r7, #0
	mla	r4, r4, r1, r3
	mov	r6, #1
	mov	r9, r1
	mov	r0, #22
	ldr	r1, .L28+4
	str	ip, [r4, #4]
	ldr	r2, [r5, #172]
	str	r2, [r4, #8]
	ldr	r2, [r5, #180]
	str	r2, [r4, #16]
	ldr	r2, [r5, #184]
	str	r2, [r4, #20]
	ldrh	r2, [r5, #52]
	str	r2, [r4, #24]
	ldrh	ip, [r5, #54]
	str	r7, [r4, #36]
	str	r6, [r4, #32]
	mov	r3, ip
	str	ip, [r4, #28]
	bl	dprint_vfmw
	ldr	r3, [r4, #24]
	ldr	r0, [r4, #28]
	mov	r1, #4
	ldr	ip, .L28+8
	add	lr, r4, #840
	str	r6, [r4, #840]
	smulbb	r0, r0, r3
	ldr	ip, [ip, #128]
	strh	r7, [r4, #40]
	str	r7, [r4, #844]
	cmp	ip, r7
	sub	r0, r0, #1
	strh	r0, [r4, #42]
	ldr	r3, [r5, #204]
	moveq	r0, r6
	str	r6, [r4, #856]
	str	r1, [r4, #864]
	str	r3, [r4, #848]
	str	r7, [r4, #852]
	beq	.L26
	str	r8, [sp]
	mov	r3, r9
	mov	r2, r7
	mov	r1, r5
	mov	r0, #10
	blx	ip
	subs	r0, r0, r7
	movne	r0, #1
.L26:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L29:
	.align	2
.L28:
	.word	g_RepairParam
	.word	.LC0
	.word	g_vdm_hal_fun_ptr
	.fnend
	.size	PostPro_CopyYuv_Vp6, .-PostPro_CopyYuv_Vp6
	.align	2
	.global	PostPro_CopyYuv_Vp9
	.type	PostPro_CopyYuv_Vp9, %function
PostPro_CopyYuv_Vp9:
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
	ldr	r3, .L33
	mov	r4, #1744
	add	r5, r0, #266240
	str	r2, [fp, #-48]
	mov	r10, r1
	mov	r7, #0
	mla	r4, r4, r1, r3
	ldr	r6, [r5, #1576]
	ldr	r1, [r5, #1580]
	mov	r9, r0
	ldr	ip, [r5, #1920]
	mov	r0, #22
	ldr	r2, [r5, #1928]
	ldr	r3, [r5, #1936]
	str	r6, [r4, #24]
	str	r2, [r4, #16]
	mov	r2, r6
	str	r3, [r4, #20]
	mov	r6, #1
	mov	r3, r1
	str	r1, [r4, #28]
	str	ip, [r4, #4]
	str	ip, [r4, #8]
	ldr	r1, .L33+4
	str	r7, [r4, #36]
	str	r6, [r4, #32]
	bl	dprint_vfmw
	ldr	r8, [r4, #28]
	ldr	r3, [r4, #24]
	mov	r0, #6
	ldr	lr, .L33+8
	ldr	ip, [r5, #1948]
	smulbb	r3, r8, r3
	ldr	r5, [lr, #128]
	str	r0, [r4, #864]
	cmp	r5, r7
	str	ip, [r4, #848]
	sub	r3, r3, #1
	str	r6, [r4, #840]
	strh	r7, [r4, #40]
	moveq	r0, r6
	str	r6, [r4, #856]
	strh	r3, [r4, #42]
	str	r7, [r4, #844]
	str	r7, [r4, #852]
	beq	.L31
	ldr	r3, [fp, #-48]
	mov	r2, r7
	mov	r1, r9
	mov	r0, #17
	str	r3, [sp]
	mov	r3, r10
	blx	r5
	subs	r0, r0, r7
	movne	r0, #1
.L31:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L34:
	.align	2
.L33:
	.word	g_RepairParam
	.word	.LC0
	.word	g_vdm_hal_fun_ptr
	.fnend
	.size	PostPro_CopyYuv_Vp9, .-PostPro_CopyYuv_Vp9
	.align	2
	.global	PostPro_GetHevcMbGroup
	.type	PostPro_GetHevcMbGroup, %function
PostPro_GetHevcMbGroup:
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
	mov	r7, r1
	ldr	r1, [r1, #8]
	str	r2, [fp, #-48]
	mov	r8, r0
	sub	r2, r1, #1
	cmp	r2, #199
	bhi	.L82
	ldr	lr, [r0, #868]
	mov	r5, #0
	ldr	r2, [r0, #24]
	ldr	r4, [r0, #28]
	cmp	lr, r5
	str	r5, [r0, #840]
	str	r5, [r0, #856]
	mul	r4, r4, r2
	bne	.L83
	ldr	r3, [r7, #8]
	mvn	r6, #0
	uxth	r10, r4
	add	r2, r4, r6
	mov	r1, r6
	str	r2, [fp, #-48]
	add	r0, r7, r3, lsl #2
	mov	r2, r7
	mov	r3, r0
	strh	r10, [r0, #14]
	strh	r10, [r0, #12]
	b	.L69
.L86:
	cmp	r0, r6
	movlt	r6, r1
	add	r3, r6, #1
	cmp	r0, r3
	ble	.L64
	ldr	r3, [r8, #840]
	cmp	r3, #199
	bgt	.L84
	add	r5, r1, r1, lsr #31
	sub	r1, r6, #100
	add	r6, r8, r3, lsl #2
	add	r3, r3, #1
	sxth	r9, r5
	strh	r5, [r6, #40]
	cmp	r1, r9
	sub	r5, r0, #1
	strgth	r1, [r6, #40]
	strh	r5, [r6, #42]
	str	r3, [r8, #840]
.L64:
	ldr	r3, [r7, #8]
	sub	r1, r3, #1
	cmp	r1, lr
	beq	.L85
.L73:
	add	lr, lr, #1
	mov	r6, ip
	cmp	r3, lr
	mov	r1, r0
	add	r2, r2, #4
	bcc	.L70
.L69:
	ldrh	r0, [r2, #12]
	ldrh	ip, [r2, #14]
	cmp	r0, r4
	cmple	ip, r4
	movgt	r3, #1
	movle	r3, #0
	cmp	r0, ip
	orrgt	r3, r3, #1
	cmp	r3, #0
	beq	.L86
	ldr	r3, [r7, #8]
	add	lr, lr, #1
	add	r2, r2, #4
	cmp	r3, lr
	bcs	.L69
.L70:
	mov	r0, #0
.L37:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L85:
	add	r1, r7, lr, lsl #2
	ldr	r5, [fp, #-48]
	ldrh	r1, [r1, #14]
	cmp	r1, r5
	bge	.L73
	ldr	r3, [r8, #840]
	cmp	r3, #199
	bgt	.L87
	add	r2, r8, r3, lsl #2
	sub	r10, r10, #1
	add	r3, r3, #1
	mov	r0, #0
	strh	r10, [r2, #42]
	strh	r1, [r2, #40]
	str	r3, [r8, #840]
	b	.L37
.L83:
	ldr	r1, .L90
	mov	r0, #44
	ldr	r2, .L90+4
	mla	r3, r0, r3, r1
	ldr	r3, [r3, #8]
	ldr	r0, [r2, r3, asl #2]
	add	r0, r0, #237568
	add	r0, r0, #376
	bl	HEVC_CalcTileMap
	ldr	r3, [r7, #8]
	cmp	r3, r5
	beq	.L45
	mov	ip, r5
	ldr	r6, .L90+8
	ldr	r5, .L90+12
	mov	r1, r7
	mov	lr, #1
.L44:
	ldrh	r0, [r1, #12]
	ldrh	r2, [r1, #14]
	cmp	r0, r2
	mov	r3, r0
	bls	.L43
	b	.L42
.L88:
	ldrh	r0, [r1, #12]
.L43:
	cmp	r4, r0
	blt	.L46
	cmp	r4, r2
	ldrge	r2, [r5, r3, asl #2]
	strgeb	lr, [r6, r2]
.L46:
	ldrh	r2, [r1, #14]
	add	r3, r3, #1
	cmp	r2, r3
	bcs	.L88
.L42:
	ldr	r3, [r7, #8]
	add	ip, ip, #1
	add	r1, r1, #4
	cmp	r3, ip
	bhi	.L44
.L45:
	ldr	r3, [fp, #-48]
	ldr	r3, [r3, #2564]
	cmp	r3, #0
	beq	.L41
	ldr	r6, [fp, #-48]
	mov	r10, #0
	ldr	ip, .L90+8
	mov	r9, r10
	str	r4, [fp, #-48]
	mov	r7, r6
.L48:
	ldr	r0, [r7, #3680]
	ldr	lr, [r7, #3684]
	cmp	r0, lr
	bhi	.L53
	ldr	r3, .L90+12
	mov	r4, r0, asl #2
	ldr	r5, [r3, r0, asl #2]
	ldrb	r3, [ip, r5]
	cmp	r3, #0
	ldrne	r2, .L90+12
	movne	r3, r0
	addne	r2, r2, r4
	bne	.L52
	b	.L51
.L54:
	ldr	r1, [r2, #4]!
	ldrb	r1, [ip, r1]
	cmp	r1, #0
	beq	.L51
.L52:
	add	r3, r3, #1
	cmp	r3, lr
	bls	.L54
.L53:
	ldr	r3, [r6, #2564]
	add	r10, r10, #1
	add	r7, r7, #8
	cmp	r3, r10
	bhi	.L48
	ldr	r4, [fp, #-48]
.L41:
	ldr	lr, .L90+8
	mov	ip, #0
.L60:
	cmp	ip, r4
	bcs	.L70
	ldrb	r3, [lr, ip]
	cmp	r3, #1
	addeq	ip, ip, #1
	ldreq	r0, [r8, #840]
	beq	.L56
	add	r1, ip, lr
	mov	r2, ip
	b	.L58
.L57:
	ldrb	r0, [r1, #1]!
	cmp	r0, #0
	bne	.L59
	mov	r2, r3
.L58:
	add	r3, r2, #1
	cmp	r4, r3
	bhi	.L57
.L59:
	ldr	r1, [r8, #840]
	add	r0, r1, #1
	add	r1, r8, r1, lsl #2
	strh	ip, [r1, #40]
	mov	ip, r3
	strh	r2, [r1, #42]
	str	r0, [r8, #840]
.L56:
	cmp	r0, #199
	ble	.L60
	ldr	r1, .L90+16
	mov	r0, #1
	bl	dprint_vfmw
	sub	r4, r4, #1
	mov	r0, #0
	mov	r3, #1
	strh	r0, [r8, #40]
	strh	r4, [r8, #42]
	str	r3, [r8, #840]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L51:
	ldr	r3, .L90+12
	add	r4, r3, r4
	b	.L50
.L89:
	ldr	r5, [r4, #4]!
.L50:
	strb	r9, [ip, r5]
	add	r0, r0, #1
	ldr	r3, [r7, #3684]
	cmp	r3, r0
	bcs	.L89
	b	.L53
.L82:
	mov	r2, r1
	mov	r0, #0
	ldr	r1, .L90+20
	bl	dprint_vfmw
	mov	r0, #1
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L84:
	ldr	r2, .L90+24
	mov	r0, #1
	ldr	r1, .L90+28
	bl	dprint_vfmw
	mov	r0, #1
	b	.L37
.L87:
	ldr	r2, .L90+24
	mov	r0, #1
	ldr	r1, .L90+32
	bl	dprint_vfmw
	mov	r0, #1
	b	.L37
.L91:
	.align	2
.L90:
	.word	g_VdmDrvParam
	.word	s_pstVfmwChan
	.word	g_IsDeced
	.word	g_TsToRsMap
	.word	.LC2
	.word	.LC1
	.word	.LANCHOR0
	.word	.LC3
	.word	.LC4
	.fnend
	.size	PostPro_GetHevcMbGroup, .-PostPro_GetHevcMbGroup
	.align	2
	.global	PostPro_GetVp9MbGroup
	.type	PostPro_GetVp9MbGroup, %function
PostPro_GetVp9MbGroup:
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
	ldr	r3, [r1, #8]
	sub	r3, r3, #1
	cmp	r3, #199
	bhi	.L105
	ldr	r2, [r0, #24]
	mov	r3, #0
	ldr	r5, [r0, #28]
	mvn	r6, #0
	str	r3, [r0, #840]
	mov	lr, r3
	str	r3, [r0, #856]
	mov	r7, r6
	mul	r5, r5, r2
	ldr	r2, [r1, #8]
	mov	r3, r1
	add	ip, r1, r2, lsl #2
	add	r9, r5, r6
	uxth	r8, r5
	mov	r2, ip
	strh	r8, [ip, #14]
	strh	r8, [ip, #12]
	b	.L101
.L109:
	cmp	ip, r6
	movlt	r6, r7
	add	r6, r6, #1
	cmp	r6, ip
	beq	.L97
	add	r7, r7, r7, lsr #31
	sub	r6, ip, #1
	cmp	r7, r6
	bge	.L97
	ldr	r2, [r0, #840]
	cmp	r2, #199
	bgt	.L106
	add	r10, r0, r2, lsl #2
	add	r2, r2, #1
	strh	r7, [r10, #40]
	strh	r6, [r10, #42]
	str	r2, [r0, #840]
.L97:
	ldr	r2, [r1, #8]
	sub	r6, r2, #1
	cmp	r6, lr
	beq	.L107
.L103:
	add	lr, lr, #1
	mov	r6, r4
	cmp	lr, r2
	mov	r7, ip
	add	r3, r3, #4
	bhi	.L108
.L101:
	ldrh	ip, [r3, #12]
	ldrh	r4, [r3, #14]
	cmp	ip, r5
	cmple	r4, r5
	movgt	r2, #1
	movle	r2, #0
	cmp	ip, r4
	orrgt	r2, r2, #1
	cmp	r2, #0
	beq	.L109
	ldr	r2, [r1, #8]
	add	lr, lr, #1
	add	r3, r3, #4
	cmp	lr, r2
	bls	.L101
.L108:
	mov	r3, #0
.L94:
	mov	r0, r3
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L107:
	add	r6, r1, lr, lsl #2
	ldrh	r6, [r6, #14]
	cmp	r6, r9
	bge	.L103
	ldr	r3, [r0, #840]
	cmp	r3, #199
	bgt	.L110
	add	r1, r0, r3, lsl #2
	add	r2, r3, #1
	sub	r8, r8, #1
	mov	r3, #0
	strh	r8, [r1, #42]
	strh	r6, [r1, #40]
	str	r2, [r0, #840]
	b	.L94
.L105:
	ldr	r1, .L111
	mov	r0, #0
	bl	dprint_vfmw
	mov	r3, #1
	mov	r0, r3
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L106:
	movw	r2, #1101
	ldr	r1, .L111+4
	mov	r0, #22
	bl	dprint_vfmw
	mov	r3, #1
	b	.L94
.L110:
	movw	r2, #1116
	ldr	r1, .L111+4
	mov	r0, #22
	bl	dprint_vfmw
	mov	r3, #1
	b	.L94
.L112:
	.align	2
.L111:
	.word	.LC5
	.word	.LC6
	.fnend
	.size	PostPro_GetVp9MbGroup, .-PostPro_GetVp9MbGroup
	.align	2
	.global	PostPro_GetMp24MbGroup
	.type	PostPro_GetMp24MbGroup, %function
PostPro_GetMp24MbGroup:
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
	ldr	r2, [r1, #8]
	sub	r3, r2, #1
	cmp	r3, #199
	bhi	.L133
	ldr	r2, [r0, #24]
	mov	r3, #0
	ldr	r4, [r0, #28]
	str	r3, [r0, #840]
	str	r3, [r0, #856]
	mul	r4, r4, r2
	ldr	r3, [r1, #8]
	cmp	r3, #0
	add	ip, r1, r3, lsl #2
	uxth	r10, r4
	strh	r10, [ip, #14]
	strh	r10, [ip, #12]
	bne	.L134
.L116:
	mvn	r6, #0
	mov	r3, r1
	add	r2, r4, r6
	mov	r5, r6
	mov	ip, #0
	str	r2, [fp, #-48]
	b	.L125
.L138:
	cmp	r2, lr
	movle	r7, #0
	movgt	r7, #1
	cmp	r2, r5
	orrlt	r7, r7, #1
	cmp	r7, #0
	bne	.L117
	cmp	r2, r6
	movlt	r6, r5
	add	r7, r6, #1
	cmp	r7, r2
	beq	.L121
	add	r5, r5, r5, lsr #31
	sub	r8, r2, #1
	cmp	r5, r8
	bge	.L121
	ldr	r7, [r0, #840]
	cmp	r7, #199
	bgt	.L135
	sub	r6, r6, #100
	sxth	r9, r5
	cmp	r6, r9
	add	r9, r0, r7, lsl #2
	add	r7, r7, #1
	strh	r5, [r9, #40]
	strh	r8, [r9, #42]
	strgth	r6, [r9, #40]
	str	r7, [r0, #840]
.L121:
	ldr	r7, [r1, #8]
	sub	r5, r7, #1
	cmp	r5, ip
	beq	.L136
.L127:
	add	ip, ip, #1
	mov	r6, lr
	cmp	ip, r7
	mov	r5, r2
	add	r3, r3, #4
	bhi	.L137
.L125:
	ldrh	r2, [r3, #12]
	ldrh	lr, [r3, #14]
	cmp	r2, r4
	cmple	lr, r4
	ble	.L138
.L117:
	ldr	r7, [r1, #8]
	add	ip, ip, #1
	add	r3, r3, #4
	cmp	ip, r7
	bls	.L125
.L137:
	mov	r3, #0
.L132:
	mov	r0, r3
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L136:
	add	r5, r1, ip, lsl #2
	ldr	r6, [fp, #-48]
	ldrh	r5, [r5, #14]
	cmp	r5, r6
	bge	.L127
	ldr	r3, [r0, #840]
	cmp	r3, #199
	bgt	.L139
	add	r1, r0, r3, lsl #2
	add	r2, r3, #1
	sub	r10, r10, #1
	mov	r3, #0
	strh	r10, [r1, #42]
	strh	r5, [r1, #40]
	str	r2, [r0, #840]
	b	.L132
.L134:
	mov	r3, ip
	ldrh	ip, [ip, #10]
	sub	r2, r4, #10
	add	r3, r3, #6
	cmp	ip, r2
	subge	r2, r10, #1
	strgeh	r2, [r3, #4]
	b	.L116
.L133:
	ldr	r1, .L140
	mov	r0, #0
	bl	dprint_vfmw
	mov	r3, #1
	mov	r0, r3
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L135:
	movw	r2, #1464
	ldr	r1, .L140+4
	mov	r0, #22
	bl	dprint_vfmw
	mov	r3, #1
	b	.L132
.L139:
	movw	r2, #1495
	ldr	r1, .L140+4
	mov	r0, #22
	bl	dprint_vfmw
	mov	r3, #1
	b	.L132
.L141:
	.align	2
.L140:
	.word	.LC1
	.word	.LC6
	.fnend
	.size	PostPro_GetMp24MbGroup, .-PostPro_GetMp24MbGroup
	.align	2
	.global	PostPro_GetVc1MbGroup
	.type	PostPro_GetVc1MbGroup, %function
PostPro_GetVc1MbGroup:
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
	ldr	r3, [r1, #8]
	sub	r3, r3, #1
	cmp	r3, #199
	bhi	.L155
	ldr	r2, [r0, #24]
	mov	r3, #0
	ldr	r5, [r0, #28]
	mvn	r6, #0
	str	r3, [r0, #840]
	mov	lr, r3
	str	r3, [r0, #856]
	mov	r7, r6
	mul	r5, r5, r2
	ldr	r2, [r1, #8]
	mov	r3, r1
	add	ip, r1, r2, lsl #2
	add	r9, r5, r6
	uxth	r8, r5
	mov	r2, ip
	strh	r8, [ip, #14]
	strh	r8, [ip, #12]
	b	.L151
.L159:
	cmp	ip, r6
	movlt	r6, r7
	add	r6, r6, #1
	cmp	r6, ip
	beq	.L147
	add	r7, r7, r7, lsr #31
	sub	r6, ip, #1
	cmp	r7, r6
	bge	.L147
	ldr	r2, [r0, #840]
	cmp	r2, #199
	bgt	.L156
	add	r10, r0, r2, lsl #2
	add	r2, r2, #1
	strh	r7, [r10, #40]
	strh	r6, [r10, #42]
	str	r2, [r0, #840]
.L147:
	ldr	r2, [r1, #8]
	sub	r6, r2, #1
	cmp	r6, lr
	beq	.L157
.L153:
	add	lr, lr, #1
	mov	r6, r4
	cmp	lr, r2
	mov	r7, ip
	add	r3, r3, #4
	bhi	.L158
.L151:
	ldrh	ip, [r3, #12]
	ldrh	r4, [r3, #14]
	cmp	ip, r5
	cmple	r4, r5
	movgt	r2, #1
	movle	r2, #0
	cmp	ip, r4
	orrgt	r2, r2, #1
	cmp	r2, #0
	beq	.L159
	ldr	r2, [r1, #8]
	add	lr, lr, #1
	add	r3, r3, #4
	cmp	lr, r2
	bls	.L151
.L158:
	mov	r3, #0
.L144:
	mov	r0, r3
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L157:
	add	r6, r1, lr, lsl #2
	ldrh	r6, [r6, #14]
	cmp	r6, r9
	bge	.L153
	ldr	r3, [r0, #840]
	cmp	r3, #199
	bgt	.L160
	add	r1, r0, r3, lsl #2
	add	r2, r3, #1
	sub	r8, r8, #1
	mov	r3, #0
	strh	r8, [r1, #42]
	strh	r6, [r1, #40]
	str	r2, [r0, #840]
	b	.L144
.L155:
	ldr	r1, .L161
	mov	r0, #0
	bl	dprint_vfmw
	mov	r3, #1
	mov	r0, r3
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L156:
	movw	r2, #1559
	ldr	r1, .L161+4
	mov	r0, #22
	bl	dprint_vfmw
	mov	r3, #1
	b	.L144
.L160:
	movw	r2, #1579
	ldr	r1, .L161+4
	mov	r0, #22
	bl	dprint_vfmw
	mov	r3, #1
	b	.L144
.L162:
	.align	2
.L161:
	.word	.LC5
	.word	.LC6
	.fnend
	.size	PostPro_GetVc1MbGroup, .-PostPro_GetVc1MbGroup
	.align	2
	.global	PostPro_GetVp6MbGroup
	.type	PostPro_GetVp6MbGroup, %function
PostPro_GetVp6MbGroup:
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
	ldr	r3, [r1, #8]
	sub	r3, r3, #1
	cmp	r3, #199
	bhi	.L176
	ldr	r2, [r0, #24]
	mov	r3, #0
	ldr	r5, [r0, #28]
	mvn	r6, #0
	str	r3, [r0, #840]
	mov	lr, r3
	str	r3, [r0, #856]
	mov	r7, r6
	mul	r5, r5, r2
	ldr	r2, [r1, #8]
	mov	r3, r1
	add	ip, r1, r2, lsl #2
	add	r9, r5, r6
	uxth	r8, r5
	mov	r2, ip
	strh	r8, [ip, #14]
	strh	r8, [ip, #12]
	b	.L172
.L180:
	cmp	ip, r6
	movlt	r6, r7
	add	r6, r6, #1
	cmp	r6, ip
	beq	.L168
	add	r7, r7, r7, lsr #31
	sub	r6, ip, #1
	cmp	r7, r6
	bge	.L168
	ldr	r2, [r0, #840]
	cmp	r2, #199
	bgt	.L177
	add	r10, r0, r2, lsl #2
	add	r2, r2, #1
	strh	r7, [r10, #40]
	strh	r6, [r10, #42]
	str	r2, [r0, #840]
.L168:
	ldr	r2, [r1, #8]
	sub	r6, r2, #1
	cmp	r6, lr
	beq	.L178
.L174:
	add	lr, lr, #1
	mov	r6, r4
	cmp	lr, r2
	mov	r7, ip
	add	r3, r3, #4
	bhi	.L179
.L172:
	ldrh	ip, [r3, #12]
	ldrh	r4, [r3, #14]
	cmp	ip, r5
	cmple	r4, r5
	movgt	r2, #1
	movle	r2, #0
	cmp	ip, r4
	orrgt	r2, r2, #1
	cmp	r2, #0
	beq	.L180
	ldr	r2, [r1, #8]
	add	lr, lr, #1
	add	r3, r3, #4
	cmp	lr, r2
	bls	.L172
.L179:
	mov	r3, #0
.L165:
	mov	r0, r3
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L178:
	add	r6, r1, lr, lsl #2
	ldrh	r6, [r6, #14]
	cmp	r6, r9
	bge	.L174
	ldr	r3, [r0, #840]
	cmp	r3, #199
	bgt	.L181
	add	r1, r0, r3, lsl #2
	add	r2, r3, #1
	sub	r8, r8, #1
	mov	r3, #0
	strh	r8, [r1, #42]
	strh	r6, [r1, #40]
	str	r2, [r0, #840]
	b	.L165
.L176:
	ldr	r1, .L182
	mov	r0, #0
	bl	dprint_vfmw
	mov	r3, #1
	mov	r0, r3
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L177:
	movw	r2, #1644
	ldr	r1, .L182+4
	mov	r0, #22
	bl	dprint_vfmw
	mov	r3, #1
	b	.L165
.L181:
	mov	r2, #1664
	ldr	r1, .L182+4
	mov	r0, #22
	bl	dprint_vfmw
	mov	r3, #1
	b	.L165
.L183:
	.align	2
.L182:
	.word	.LC5
	.word	.LC6
	.fnend
	.size	PostPro_GetVp6MbGroup, .-PostPro_GetVp6MbGroup
	.align	2
	.global	PostPro_GetVp8MbGroup
	.type	PostPro_GetVp8MbGroup, %function
PostPro_GetVp8MbGroup:
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
	ldr	r3, [r1, #8]
	sub	r3, r3, #1
	cmp	r3, #199
	bhi	.L197
	ldr	r2, [r0, #24]
	mov	r3, #0
	ldr	r5, [r0, #28]
	mvn	r6, #0
	str	r3, [r0, #840]
	mov	lr, r3
	str	r3, [r0, #856]
	mov	r7, r6
	mul	r5, r5, r2
	ldr	r2, [r1, #8]
	mov	r3, r1
	add	ip, r1, r2, lsl #2
	add	r9, r5, r6
	uxth	r8, r5
	mov	r2, ip
	strh	r8, [ip, #14]
	strh	r8, [ip, #12]
	b	.L193
.L201:
	cmp	ip, r6
	movlt	r6, r7
	add	r6, r6, #1
	cmp	r6, ip
	beq	.L189
	add	r7, r7, r7, lsr #31
	sub	r6, ip, #1
	cmp	r7, r6
	bge	.L189
	ldr	r2, [r0, #840]
	cmp	r2, #199
	bgt	.L198
	add	r10, r0, r2, lsl #2
	add	r2, r2, #1
	strh	r7, [r10, #40]
	strh	r6, [r10, #42]
	str	r2, [r0, #840]
.L189:
	ldr	r2, [r1, #8]
	sub	r6, r2, #1
	cmp	r6, lr
	beq	.L199
.L195:
	add	lr, lr, #1
	mov	r6, r4
	cmp	lr, r2
	mov	r7, ip
	add	r3, r3, #4
	bhi	.L200
.L193:
	ldrh	ip, [r3, #12]
	ldrh	r4, [r3, #14]
	cmp	ip, r5
	cmple	r4, r5
	movgt	r2, #1
	movle	r2, #0
	cmp	ip, r4
	orrgt	r2, r2, #1
	cmp	r2, #0
	beq	.L201
	ldr	r2, [r1, #8]
	add	lr, lr, #1
	add	r3, r3, #4
	cmp	lr, r2
	bls	.L193
.L200:
	mov	r3, #0
.L186:
	mov	r0, r3
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L199:
	add	r6, r1, lr, lsl #2
	ldrh	r6, [r6, #14]
	cmp	r6, r9
	bge	.L195
	ldr	r3, [r0, #840]
	cmp	r3, #199
	bgt	.L202
	add	r1, r0, r3, lsl #2
	add	r2, r3, #1
	sub	r8, r8, #1
	mov	r3, #0
	strh	r8, [r1, #42]
	strh	r6, [r1, #40]
	str	r2, [r0, #840]
	b	.L186
.L197:
	ldr	r1, .L203
	mov	r0, #0
	bl	dprint_vfmw
	mov	r3, #1
	mov	r0, r3
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L198:
	mov	r2, #1728
	ldr	r1, .L203+4
	mov	r0, #22
	bl	dprint_vfmw
	mov	r3, #1
	b	.L186
.L202:
	movw	r2, #1748
	ldr	r1, .L203+4
	mov	r0, #22
	bl	dprint_vfmw
	mov	r3, #1
	b	.L186
.L204:
	.align	2
.L203:
	.word	.LC5
	.word	.LC6
	.fnend
	.size	PostPro_GetVp8MbGroup, .-PostPro_GetVp8MbGroup
	.align	2
	.global	PostPro_GetAvsMbGroup
	.type	PostPro_GetAvsMbGroup, %function
PostPro_GetAvsMbGroup:
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
	ldr	r2, [r1, #8]
	sub	r3, r2, #1
	cmp	r3, #199
	bhi	.L216
	ldr	lr, [r0, #24]
	mov	r3, #0
	ldr	r4, [r0, #28]
	mvn	r7, #0
	str	r3, [r0, #856]
	mov	ip, r3
	ldr	r2, [r1, #8]
	mov	r9, r3
	mul	r4, r4, lr
	mov	r6, r7
	add	r5, r1, r2, lsl #2
	str	r1, [fp, #-56]
	mov	r8, r0
	add	lr, r4, r7
	str	lr, [fp, #-48]
	mov	r2, r5
	add	lr, r4, r4, lsr #31
	uxth	r10, r4
	strh	r10, [r5, #14]
	mov	lr, lr, asr #1
	str	r10, [fp, #-64]
	add	r3, lr, r7
	str	lr, [fp, #-60]
	str	r3, [fp, #-52]
	mov	r3, r1
	strh	r10, [r2, #12]
	b	.L212
.L219:
	cmp	r2, r7
	movlt	r7, r6
	add	r7, r7, #1
	cmp	r2, r7
	ble	.L210
	ldr	r7, [r8, #840]
	uxth	r5, r9
	rsb	r10, r5, r6, lsr #31
	rsb	r5, r5, r2
	add	r6, r10, r6
	sub	r5, r5, #1
	add	r10, r8, r7, lsl #2
	add	r7, r7, #1
	strh	r6, [r10, #40]
	strh	r5, [r10, #42]
	ldr	r5, [r8, #32]
	str	r7, [r8, #840]
	cmp	r5, #0
	bne	.L210
	ldr	r5, [fp, #-52]
	cmp	r2, r5
	addge	r8, r0, #872
	ldrge	r9, [fp, #-60]
.L210:
	ldr	r5, [r1, #8]
	sub	r6, r5, #1
	cmp	r6, ip
	beq	.L217
.L214:
	add	ip, ip, #1
	mov	r7, lr
	cmp	ip, r5
	mov	r6, r2
	add	r3, r3, #4
	bhi	.L218
.L212:
	ldrh	r2, [r3, #12]
	ldrh	lr, [r3, #14]
	cmp	r2, r4
	cmple	lr, r4
	movgt	r5, #1
	movle	r5, #0
	cmp	r2, lr
	orrgt	r5, r5, #1
	cmp	r5, #0
	beq	.L219
	ldr	r5, [r1, #8]
	add	ip, ip, #1
	add	r3, r3, #4
	cmp	ip, r5
	bls	.L212
.L218:
	mov	r2, #0
.L207:
	mov	r0, r2
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L217:
	add	r6, r1, ip, lsl #2
	ldr	r7, [fp, #-48]
	ldrh	r6, [r6, #14]
	cmp	r6, r7
	bge	.L214
	ldr	r1, [r0, #840]
	mov	r2, #0
	ldr	r3, [fp, #-64]
	add	ip, r1, #1
	add	r1, r0, r1, lsl #2
	sub	r3, r3, #1
	strh	r6, [r1, #40]
	strh	r3, [r1, #42]
	str	ip, [r0, #840]
	b	.L207
.L216:
	ldr	r1, .L220
	mov	r0, #0
	bl	dprint_vfmw
	mov	r2, #1
	mov	r0, r2
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L221:
	.align	2
.L220:
	.word	.LC1
	.fnend
	.size	PostPro_GetAvsMbGroup, .-PostPro_GetAvsMbGroup
	.align	2
	.global	PostPro_GetDivx3MbGroup
	.type	PostPro_GetDivx3MbGroup, %function
PostPro_GetDivx3MbGroup:
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
	ldr	r2, [r1, #8]
	sub	r3, r2, #1
	cmp	r3, #3
	bhi	.L233
	ldr	lr, [r0, #24]
	mov	r3, #0
	ldr	r4, [r0, #28]
	mvn	r7, #0
	str	r3, [r0, #856]
	mov	ip, r3
	ldr	r2, [r1, #8]
	mov	r9, r3
	mul	r4, r4, lr
	mov	r6, r7
	add	r5, r1, r2, lsl #2
	str	r1, [fp, #-56]
	mov	r8, r0
	add	lr, r4, r7
	str	lr, [fp, #-48]
	mov	r2, r5
	add	lr, r4, r4, lsr #31
	uxth	r10, r4
	strh	r10, [r5, #14]
	mov	lr, lr, asr #1
	str	r10, [fp, #-64]
	add	r3, lr, r7
	str	lr, [fp, #-60]
	str	r3, [fp, #-52]
	mov	r3, r1
	strh	r10, [r2, #12]
	b	.L229
.L236:
	cmp	r2, r7
	movlt	r7, r6
	add	r7, r7, #1
	cmp	r2, r7
	ble	.L227
	ldr	r7, [r8, #840]
	uxth	r5, r9
	rsb	r10, r5, r6, lsr #31
	rsb	r5, r5, r2
	add	r6, r10, r6
	sub	r5, r5, #1
	add	r10, r8, r7, lsl #2
	add	r7, r7, #1
	strh	r6, [r10, #40]
	strh	r5, [r10, #42]
	ldr	r5, [r8, #32]
	str	r7, [r8, #840]
	cmp	r5, #0
	bne	.L227
	ldr	r5, [fp, #-52]
	cmp	r2, r5
	addge	r8, r0, #872
	ldrge	r9, [fp, #-60]
.L227:
	ldr	r5, [r1, #8]
	sub	r6, r5, #1
	cmp	r6, ip
	beq	.L234
.L231:
	add	ip, ip, #1
	mov	r7, lr
	cmp	ip, r5
	mov	r6, r2
	add	r3, r3, #4
	bhi	.L235
.L229:
	ldrh	r2, [r3, #12]
	ldrh	lr, [r3, #14]
	cmp	r2, r4
	cmple	lr, r4
	movgt	r5, #1
	movle	r5, #0
	cmp	r2, lr
	orrgt	r5, r5, #1
	cmp	r5, #0
	beq	.L236
	ldr	r5, [r1, #8]
	add	ip, ip, #1
	add	r3, r3, #4
	cmp	ip, r5
	bls	.L229
.L235:
	mov	r2, #0
.L224:
	mov	r0, r2
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L234:
	add	r6, r1, ip, lsl #2
	ldr	r7, [fp, #-48]
	ldrh	r6, [r6, #14]
	cmp	r6, r7
	bge	.L231
	ldr	r1, [r0, #840]
	mov	r2, #0
	ldr	r3, [fp, #-64]
	add	ip, r1, #1
	add	r1, r0, r1, lsl #2
	sub	r3, r3, #1
	strh	r6, [r1, #40]
	strh	r3, [r1, #42]
	str	ip, [r0, #840]
	b	.L224
.L233:
	ldr	r1, .L237
	mov	r0, #0
	bl	dprint_vfmw
	mov	r2, #1
	mov	r0, r2
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L238:
	.align	2
.L237:
	.word	.LC1
	.fnend
	.size	PostPro_GetDivx3MbGroup, .-PostPro_GetDivx3MbGroup
	.align	2
	.global	PostPro_BubbleSort
	.type	PostPro_BubbleSort, %function
PostPro_BubbleSort:
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
	ldr	r8, [r0, #8]
	cmp	r8, #1
	bls	.L251
	mov	r7, #1
.L244:
	mov	r4, #0
	rsb	lr, r7, r8
	mov	r2, r4
	mov	r3, r0
	b	.L245
.L243:
	ldrh	r1, [r3, #12]
	ldrh	ip, [r3, #16]
	cmp	r1, ip
	bls	.L242
	ldrh	r6, [r3, #14]
	mov	r4, #1
	ldrh	r5, [r3, #18]
	strh	ip, [r3, #12]
	strh	r1, [r3, #16]
	strh	r6, [r3, #18]
	strh	r5, [r3, #14]
.L242:
	add	r3, r3, #4
.L245:
	cmp	r2, lr
	add	r2, r2, #1
	bne	.L243
	cmp	r4, #0
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	add	r7, r7, #1
	cmp	r8, r7
	movls	r4, #0
	andhi	r4, r4, #1
	cmp	r4, #0
	bne	.L244
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L251:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	PostPro_BubbleSort, .-PostPro_BubbleSort
	.global	__aeabi_uidivmod
	.global	__aeabi_uidiv
	.align	2
	.global	PostPro_GetH264MbGroup
	.type	PostPro_GetH264MbGroup, %function
PostPro_GetH264MbGroup:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #828
	sub	sp, sp, #828
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r7, [r1, #8]
	mov	r6, r1
	mov	r9, r0
	sub	r3, r7, #1
	cmp	r3, #199
	bhi	.L289
	ldr	r10, [r0, #24]
	cmp	r2, #0
	ldr	r4, [r0, #28]
	mul	r4, r4, r10
	uxtheq	r8, r4
	bne	.L290
.L256:
	mov	ip, #0
	str	ip, [r9, #840]
	str	ip, [r9, #856]
	mvn	r5, #0
	ldr	r2, [r6, #8]
	add	r3, r4, r5
	mov	r1, r5
	str	r3, [fp, #-848]
	mov	r3, r6
	add	r0, r6, r2, lsl #2
	strh	r8, [r0, #14]
	strh	r8, [r0, #12]
	b	.L273
.L294:
	cmp	r2, r5
	movlt	r5, r1
	add	lr, r5, #1
	cmp	r2, lr
	ble	.L268
	ldr	r7, [r9, #840]
	cmp	r7, #199
	bgt	.L291
	add	lr, r1, r1, lsr #31
	sub	r1, r5, #100
	add	r5, r9, r7, lsl #2
	add	r7, r7, #1
	sxth	r10, lr
	strh	lr, [r5, #40]
	cmp	r1, r10
	sub	lr, r2, #1
	strgth	r1, [r5, #40]
	strh	lr, [r5, #42]
	str	r7, [r9, #840]
.L268:
	ldr	lr, [r6, #8]
	sub	r1, lr, #1
	cmp	r1, ip
	beq	.L292
.L280:
	add	ip, ip, #1
	mov	r5, r0
	cmp	lr, ip
	mov	r1, r2
	add	r3, r3, #4
	bcc	.L293
.L273:
	ldrh	r2, [r3, #12]
	ldrh	r0, [r3, #14]
	cmp	r2, r4
	cmple	r0, r4
	movgt	r7, #1
	movle	r7, #0
	cmp	r2, r0
	orrgt	r7, r7, #1
	cmp	r7, #0
	beq	.L294
	ldr	lr, [r6, #8]
	add	ip, ip, #1
	add	r3, r3, #4
	cmp	lr, ip
	bcs	.L273
.L293:
	mov	r0, #0
.L283:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L292:
	add	r1, r6, ip, lsl #2
	ldr	r5, [fp, #-848]
	ldrh	r1, [r1, #14]
	cmp	r1, r5
	bge	.L280
	ldr	r3, [r9, #840]
	cmp	r3, #199
	bgt	.L295
	add	r2, r9, r3, lsl #2
	sub	r8, r8, #1
	add	r3, r3, #1
	mov	r0, #0
	strh	r8, [r2, #42]
	strh	r1, [r2, #40]
	str	r3, [r9, #840]
	b	.L283
.L290:
	cmp	r7, #0
	mov	r10, r10, asl #1
	beq	.L259
	sub	ip, fp, #844
	mov	r7, r7, asl #2
	add	lr, r1, r7
	mov	r3, r1
	mov	r2, ip
	str	ip, [fp, #-852]
.L258:
	ldrh	r0, [r3, #12]
	add	r3, r3, #4
	ldrh	r1, [r3, #10]
	cmp	r3, lr
	add	r2, r2, #4
	strh	r0, [r2, #-4]
	strh	r1, [r2, #-2]
	bne	.L258
	ldrh	r8, [ip]
	cmp	r10, #0
	ldrh	r3, [ip, #2]
	bic	r8, r8, #1
	orr	r3, r3, #1
	strh	r3, [ip, #2]
	uxth	r8, r8
	strh	r8, [ip]
	mov	r5, r3
	beq	.L278
	sub	r7, r7, #4
	sub	r3, r10, #2
	str	r3, [fp, #-848]
	add	r3, ip, r7
	mov	r7, #0
	str	r3, [fp, #-856]
	str	r4, [fp, #-868]
	uxth	r3, r10
	str	r3, [fp, #-864]
.L274:
	mov	r1, r10
	mov	r0, r8
	bl	__aeabi_uidivmod
	mov	r0, r5
	mov	r4, r1
	cmp	r4, #1
	mov	r1, r10
	bls	.L260
	bl	__aeabi_uidivmod
	ldr	r3, [fp, #-848]
	cmp	r3, r1
	bls	.L261
	str	r1, [fp, #-860]
	mov	r0, r8
	mov	r1, r10
	mov	r4, r4, lsr #1
	bl	__aeabi_uidiv
	mov	r1, r10
	mov	r8, r0
	mov	r0, r5
	bl	__aeabi_uidiv
	ldr	r2, [fp, #-860]
	mov	r2, r2, lsr #1
	cmp	r0, r8
	mov	r3, r0
	beq	.L262
	ldr	r1, [fp, #-864]
	add	lr, r6, r7, lsl #2
	add	r5, r7, #1
	cmp	r5, #199
	smulbb	r1, r8, r1
	uxth	r1, r1
	add	r4, r1, r4
	uxth	ip, r4
	strh	ip, [lr, #12]
	ldr	r0, [r9, #24]
	sub	r0, r0, #1
	add	r1, r1, r0
	strh	r1, [lr, #14]
	bhi	.L288
	ldr	r1, [fp, #-864]
	add	r5, r6, r5, lsl #2
	ldr	r0, [r9, #24]
	uxth	r2, r2
	smulbb	r3, r3, r1
	add	r1, r7, #2
	cmp	r1, #199
	add	ip, ip, r0
	strh	ip, [lr, #16]
	uxth	r3, r3
	add	r0, r2, r3
	strh	r0, [r5, #14]
	bhi	.L288
	ldr	r0, [r9, #24]
	add	r7, r7, #3
	add	r1, r6, r1, lsl #2
	cmp	r7, #199
	add	r3, r3, r0
	uxth	r3, r3
	strh	r3, [lr, #20]
	add	r2, r3, r2
	strh	r2, [r1, #14]
	bhi	.L288
.L264:
	ldr	r3, [fp, #-852]
	ldr	r2, [fp, #-856]
	cmp	r3, r2
	beq	.L296
	ldr	r3, [fp, #-852]
	add	r3, r3, #4
	ldrh	r8, [r3]
	ldrh	r5, [r3, #2]
	bic	r8, r8, #1
	strh	r8, [r3]
	orr	r5, r5, #1
	strh	r5, [r3, #2]
	str	r3, [fp, #-852]
	b	.L274
.L261:
	mov	r1, r10
	mov	r0, r8
	bl	__aeabi_uidiv
	add	r2, r6, r7, lsl #2
	add	r3, r7, #1
	cmp	r3, #199
	smulbb	r0, r0, r10
	uxth	r0, r0
	add	r4, r0, r4, lsr #1
	uxth	r4, r4
	strh	r4, [r2, #12]
	ldr	r1, [r9, #24]
	sub	r1, r1, #1
	add	r0, r0, r1
	strh	r0, [r2, #14]
	bhi	.L288
	add	r7, r7, #2
	ldr	r1, [r9, #24]
	add	r3, r6, r3, lsl #2
	cmp	r7, #199
	add	r4, r4, r1
	strh	r4, [r2, #16]
	strh	r5, [r3, #14]
	bls	.L264
.L288:
	ldr	r4, [fp, #-868]
	mov	r2, #1
	str	r2, [r6, #8]
	uxth	r8, r4
	sub	r3, r8, #1
	strh	r3, [r6, #14]
	mov	r3, #0
	strh	r3, [r6, #12]
.L276:
	mov	r0, r6
	bl	PostPro_BubbleSort
	b	.L256
.L260:
	bl	__aeabi_uidivmod
	ldr	r2, [fp, #-848]
	cmp	r2, r1
	bls	.L265
	add	r4, r6, r7, lsl #2
	str	r1, [fp, #-860]
	mov	r0, r5
	mov	r1, r10
	strh	r8, [r4, #12]
	bl	__aeabi_uidiv
	ldr	r3, [fp, #-860]
	add	ip, r7, #1
	cmp	ip, #199
	ubfx	r1, r3, #1, #16
	smulbb	r0, r0, r10
	uxth	r0, r0
	add	r3, r1, r0
	strh	r3, [r4, #14]
	bhi	.L288
	ldr	r3, [r9, #24]
	add	r7, r7, #2
	add	ip, r6, ip, lsl #2
	cmp	r7, #199
	add	r2, r0, r3
	uxth	r3, r2
	strh	r3, [r4, #16]
	add	r3, r3, r1
	strh	r3, [ip, #14]
	bls	.L264
	b	.L288
.L265:
	add	r2, r6, r7, lsl #2
	add	r7, r7, #1
	cmp	r7, #199
	strh	r8, [r2, #12]
	strh	r5, [r2, #14]
	bls	.L264
	b	.L288
.L262:
	smulbb	r3, r0, r10
	add	r1, r7, #1
	add	lr, r6, r7, lsl #2
	cmp	r1, #199
	uxth	r3, r3
	add	r4, r3, r4
	add	r2, r3, r2
	uxth	r4, r4
	uxth	r2, r2
	strh	r4, [lr, #12]
	strh	r2, [lr, #14]
	bhi	.L288
	ldr	r3, [r9, #24]
	add	r7, r7, #2
	add	r1, r6, r1, lsl #2
	cmp	r7, #199
	add	r4, r4, r3
	strh	r4, [lr, #16]
	ldr	r3, [r9, #24]
	add	r2, r2, r3
	strh	r2, [r1, #14]
	bls	.L264
	b	.L288
.L278:
	mov	r7, r10
.L259:
	uxth	r8, r4
	str	r7, [r6, #8]
	b	.L276
.L289:
	mov	r2, r7
	ldr	r1, .L297
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #1
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L296:
	ldr	r4, [fp, #-868]
	b	.L259
.L291:
	movw	r2, #1358
	ldr	r1, .L297+4
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, #1
	b	.L283
.L295:
	movw	r2, #1387
	ldr	r1, .L297+4
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, #1
	b	.L283
.L298:
	.align	2
.L297:
	.word	.LC1
	.word	.LC6
	.fnend
	.size	PostPro_GetH264MbGroup, .-PostPro_GetH264MbGroup
	.align	2
	.global	PostPro_GetRepairParam
	.type	PostPro_GetRepairParam, %function
PostPro_GetRepairParam:
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
	mov	r7, r3
	mov	r4, r1
	mov	r3, #0
	mov	r5, r2
	str	r0, [r1]
	str	r3, [r1, #840]
	str	r3, [r1, #1712]
	cmp	r0, #17
	ldrls	pc, [pc, r0, asl #2]
	b	.L300
.L302:
	.word	.L301
	.word	.L303
	.word	.L304
	.word	.L305
	.word	.L300
	.word	.L306
	.word	.L307
	.word	.L300
	.word	.L308
	.word	.L309
	.word	.L310
	.word	.L310
	.word	.L310
	.word	.L311
	.word	.L300
	.word	.L312
	.word	.L313
	.word	.L314
.L314:
	add	r5, r2, #266240
	mov	r3, #0
	mov	lr, #1
	mov	r2, #6
	ldr	ip, [r5, #1920]
	mov	r1, r7
	mov	r0, r4
	str	ip, [r4, #4]
	ldr	ip, [r5, #1920]
	str	ip, [r4, #8]
	ldr	ip, [r5, #1928]
	str	ip, [r4, #16]
	ldr	ip, [r5, #1936]
	str	ip, [r4, #20]
	ldr	ip, [r5, #1576]
	str	ip, [r4, #24]
	ldr	ip, [r5, #1580]
	str	lr, [r4, #32]
	str	r3, [r4, #36]
	str	ip, [r4, #28]
	str	r3, [r4, #852]
	ldr	r3, [r5, #1948]
	str	r2, [r4, #864]
	str	r3, [r4, #848]
	bl	PostPro_GetVp9MbGroup
.L333:
	ldr	r8, [r4, #840]
	ldr	r3, [r4, #24]
	ldr	r6, [r4, #28]
	cmp	r8, #0
	mul	r6, r6, r3
	beq	.L367
	mov	r8, #0
	mov	r5, r4
	mov	r9, r8
.L368:
	ldrsh	r3, [r5, #40]
	mov	r0, #22
	ldrsh	r2, [r5, #42]
	add	r9, r9, #1
	ldr	r1, .L435
	add	r5, r5, #4
	bl	dprint_vfmw
	ldrsh	r3, [r5, #38]
	ldrsh	r2, [r5, #36]
	ldr	r1, [r4, #840]
	rsb	r3, r2, r3
	cmp	r1, r9
	add	r3, r3, #1
	add	r8, r8, r3
	bhi	.L368
.L367:
	ldr	r1, [r4, #1712]
	cmp	r1, #0
	beq	.L369
	add	r0, r4, #912
	mov	r2, #0
	add	r0, r0, #2
.L370:
	ldrsh	r3, [r0]
	add	r2, r2, #1
	ldrsh	ip, [r0, #-2]
	cmp	r2, r1
	add	r0, r0, #4
	rsb	ip, ip, r3
	add	ip, ip, #1
	add	r8, r8, ip
	bne	.L370
.L369:
	cmp	r6, #0
	moveq	r4, r6
	beq	.L371
	mov	r0, #100
	mov	r1, r6
	mul	r0, r0, r8
	bl	__aeabi_uidiv
	cmp	r0, #100
	movcc	r4, r0
	movcs	r4, #100
.L371:
	mov	ip, #0
	mov	r3, r8
	mov	r2, r6
	ldr	r1, .L435+4
	str	ip, [r7, #8]
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L301:
	ldr	r3, [r2, #292]
	add	r3, r2, r3, lsl #2
	ldr	r3, [r3, #308]
	str	r3, [r1, #4]
	ldr	r3, [r2, #296]
	str	r3, [r1, #8]
	ldr	r3, [r2, #1008]
	ldr	r0, [r3, #1640]
	add	r3, r2, r0, lsl #2
	ldr	r3, [r3, #308]
	str	r3, [r1, #16]
	ldr	r3, [r2, #300]
	add	r3, r2, r3, lsl #2
	ldr	r3, [r3, #700]
	str	r3, [r1, #20]
	ldr	r3, [r2, #28]
	str	r3, [r1, #24]
	ldr	r3, [r2, #20]
	str	r3, [r1, #28]
	ldrb	r3, [r2]
	clz	r3, r3
	mov	r3, r3, lsr #5
	str	r3, [r1, #32]
	ldrb	r3, [r2, #1]
	clz	r3, r3
	mov	r3, r3, lsr #5
	str	r3, [r1, #36]
	ldr	ip, [r2, #1000]
	cmp	ip, #0
	beq	.L315
	ldr	r3, [r2, #1204]
	cmp	r3, r0
	addne	r2, r2, #1200
	movne	r3, #0
	addne	r2, r2, #4
	bne	.L318
	b	.L427
.L319:
	ldr	r1, [r2, #4]!
	cmp	r1, r0
	beq	.L316
.L318:
	add	r3, r3, #1
	cmp	r3, ip
	bne	.L319
.L315:
	ldr	r2, [r5, #32]
	ldrsb	r3, [r5, #2]
	cmp	r2, #0
	ldrneb	r2, [r5]
	clzne	r2, r2
	movne	r2, r2, lsr #5
	cmp	r3, #0
	streq	r3, [r7, #8]
	bne	.L428
.L322:
	ldr	r0, [r4, #4]
	ldr	r3, [r4, #16]
	cmp	r0, r3
	beq	.L429
.L349:
	ldrb	r3, [r5]
	cmp	r3, #0
	beq	.L358
	cmp	r3, #1
	beq	.L421
	cmp	r3, #2
	beq	.L421
	cmp	r3, #3
	bne	.L355
.L358:
	mov	r3, #0
.L421:
	str	r3, [r4, #852]
.L355:
	ldr	r3, [r5, #1268]
	mov	r2, #4
	str	r2, [r4, #864]
	str	r3, [r4, #848]
	b	.L333
.L303:
	add	r6, r2, #12288
	mov	r8, #0
	mov	r1, r7
	mov	r0, r4
	ldr	r3, [r6, #224]
	str	r3, [r4, #4]
	ldr	r3, [r6, #96]
	str	r3, [r4, #8]
	ldr	r3, [r6, #100]
	str	r3, [r4, #16]
	ldr	r3, [r6, #108]
	str	r3, [r4, #20]
	ldrh	r3, [r2, #78]
	add	r3, r3, #1
	str	r3, [r4, #24]
	ldrh	r3, [r2, #80]
	add	r3, r3, #1
	str	r3, [r4, #28]
	ldrb	r3, [r2, #5]
	str	r8, [r4, #36]
	tst	r3, #253
	moveq	r3, #1
	movne	r3, r8
	str	r3, [r4, #32]
	bl	PostPro_GetVc1MbGroup
	ldr	r2, [r4, #32]
	ldrb	r3, [r5, #68]
	cmp	r2, #1
	streq	r8, [r4, #852]
	and	r3, r3, #3
	str	r3, [r4, #844]
	beq	.L365
	ldrb	r3, [r5, #5]
	cmp	r3, #3
	beq	.L430
.L365:
	mov	r3, #4
	str	r3, [r4, #864]
	ldr	r3, [r6, #256]
	str	r3, [r4, #848]
	b	.L333
.L304:
	ldr	r0, [r2, #212]
	add	r3, r2, #12288
	mov	r6, #1
	mov	r2, #0
	mov	ip, #4
	mov	r1, r7
	str	r0, [r4, #4]
	mov	r0, r4
	ldr	lr, [r3, #2300]
	str	lr, [r4, #8]
	ldr	lr, [r5, #216]
	str	lr, [r4, #16]
	ldr	lr, [r5, #224]
	str	lr, [r4, #20]
	ldrh	lr, [r5, #164]
	str	lr, [r4, #24]
	ldrh	lr, [r5, #166]
	str	r6, [r4, #32]
	str	r2, [r4, #36]
	str	lr, [r4, #28]
	str	r2, [r4, #852]
	ldr	r3, [r3, #2380]
	str	ip, [r4, #864]
	str	r3, [r4, #848]
	bl	PostPro_GetMp24MbGroup
	b	.L333
.L305:
	ldr	r3, [r2, #200]
	mov	r2, #0
	str	r3, [r1, #4]
	ldr	r3, [r5, #224]
	str	r3, [r1, #8]
	ldr	r3, [r5, #196]
	str	r3, [r1, #16]
	ldr	r3, [r5, #256]
	str	r3, [r1, #20]
	ldrh	r3, [r5, #152]
	str	r3, [r1, #24]
	ldrh	r3, [r5, #148]
	str	r3, [r1, #28]
	ldrb	r3, [r5, #3]
	str	r2, [r1, #36]
	sub	r3, r3, #3
	clz	r3, r3
	mov	r3, r3, lsr #5
	str	r3, [r1, #32]
	ldrb	r3, [r5, #3]
	cmp	r3, #1
	beq	.L420
	cmp	r3, #2
	beq	.L420
	cmp	r3, #3
	streq	r2, [r1, #852]
.L360:
	add	r5, r5, #45056
	mov	r2, #4
	mov	r1, r7
	mov	r0, r4
	ldr	r3, [r5, #276]
	str	r2, [r4, #864]
	str	r3, [r4, #848]
	bl	PostPro_GetMp24MbGroup
	b	.L333
.L306:
	ldr	ip, [r2, #128]
	mov	r3, #0
	mov	lr, #1
	mov	r2, #4
	mov	r1, r7
	mov	r0, r4
	str	ip, [r4, #4]
	ldr	ip, [r5, #124]
	str	ip, [r4, #16]
	ldr	ip, [r5, #156]
	str	ip, [r4, #20]
	ldr	ip, [r5, #8]
	str	ip, [r4, #24]
	ldr	ip, [r5, #12]
	str	lr, [r4, #32]
	str	r3, [r4, #36]
	str	ip, [r4, #28]
	str	r3, [r4, #852]
	ldr	r3, [r5, #164]
	str	r2, [r4, #864]
	str	r3, [r4, #848]
	bl	PostPro_GetDivx3MbGroup
	b	.L333
.L307:
	add	r6, r2, #12288
	mov	ip, #0
	ldr	r0, [r6, #2160]
	str	r0, [r1, #4]
	ldr	r3, [r6, #2172]
	str	r3, [r1, #8]
	ldr	r10, [r6, #2152]
	str	r10, [r1, #16]
	ldr	lr, [r6, #2164]
	str	lr, [r1, #20]
	ldrh	r8, [r2, #56]
	str	r8, [r1, #24]
	ldrh	r1, [r2, #58]
	str	r1, [r4, #28]
	mov	r9, r1, lsr #1
	ldrb	r2, [r2, #17]
	str	ip, [r4, #36]
	sub	r2, r2, #3
	clz	r2, r2
	mov	r2, r2, lsr #5
	str	r2, [r4, #32]
	ldr	r3, [r7, #4]
	str	r10, [r4, #888]
	add	r0, r3, r0
	str	r0, [r4, #876]
	ldr	r3, [r7, #4]
	str	r2, [r4, #904]
	str	r1, [r4, #900]
	add	r3, r3, r3, lsl #3
	str	r8, [r4, #896]
	str	ip, [r4, #908]
	mla	r3, r9, r3, lr
	str	r3, [r4, #892]
	ldrb	r3, [r5, #17]
	cmp	r3, #3
	streq	ip, [r4, #852]
	beq	.L363
	cmp	r3, #1
	streq	r3, [r4, #852]
.L363:
	ldr	r3, [r6, #2600]
	mov	r2, #4
	mov	r1, r7
	str	r2, [r4, #864]
	mov	r0, r4
	str	r3, [r4, #848]
	bl	PostPro_GetAvsMbGroup
	b	.L333
.L308:
	ldr	ip, [r2, #56]
	mov	r3, #0
	mov	lr, #1
	mov	r2, #4
	mov	r1, r7
	mov	r0, r4
	str	ip, [r4, #4]
	ldr	ip, [r5, #52]
	str	ip, [r4, #16]
	ldr	ip, [r5, #72]
	str	ip, [r4, #20]
	ldr	ip, [r5, #4]
	str	ip, [r4, #24]
	ldr	ip, [r5, #8]
	str	lr, [r4, #32]
	str	r3, [r4, #36]
	str	ip, [r4, #28]
	str	r3, [r4, #852]
	ldr	r3, [r5, #80]
	str	r2, [r4, #864]
	str	r3, [r4, #848]
	bl	PostPro_GetMp24MbGroup
	b	.L333
.L309:
	ldr	ip, [r2, #52]
	mov	r3, #0
	mov	lr, #1
	mov	r2, #4
	mov	r1, r7
	mov	r0, r4
	str	ip, [r4, #4]
	ldr	ip, [r5, #48]
	str	ip, [r4, #16]
	ldr	ip, [r5, #68]
	str	ip, [r4, #20]
	ldr	ip, [r5, #4]
	str	ip, [r4, #24]
	ldr	ip, [r5, #8]
	str	lr, [r4, #32]
	str	r3, [r4, #36]
	str	ip, [r4, #28]
	str	r3, [r4, #852]
	ldr	r3, [r5, #76]
	str	r2, [r4, #864]
	str	r3, [r4, #848]
	bl	PostPro_GetMp24MbGroup
	b	.L333
.L310:
	ldr	r3, [r2, #172]
	mov	r6, #0
	mov	r2, #1
	mov	r1, r7
	mov	r0, r4
	str	r3, [r4, #4]
	ldr	r3, [r5, #172]
	str	r3, [r4, #8]
	ldr	r3, [r5, #180]
	str	r3, [r4, #16]
	ldr	r3, [r5, #184]
	str	r3, [r4, #20]
	ldrh	r3, [r5, #52]
	str	r3, [r4, #24]
	ldrh	r3, [r5, #54]
	str	r2, [r4, #32]
	str	r6, [r4, #36]
	str	r3, [r4, #28]
	bl	PostPro_GetVp6MbGroup
	str	r6, [r4, #844]
	str	r6, [r4, #852]
	mov	r2, #4
	ldr	r3, [r5, #204]
	str	r2, [r4, #864]
	str	r3, [r4, #848]
	b	.L333
.L311:
	ldr	ip, [r2, #3116]
	mov	r3, #0
	mov	lr, #1
	mov	r2, #4
	mov	r1, r7
	mov	r0, r4
	str	ip, [r4, #4]
	ldr	ip, [r5, #3116]
	str	ip, [r4, #8]
	ldr	ip, [r5, #3128]
	str	ip, [r4, #16]
	ldr	ip, [r5, #3132]
	str	ip, [r4, #20]
	ldr	ip, [r5, #2784]
	str	ip, [r4, #24]
	ldr	ip, [r5, #2788]
	str	lr, [r4, #32]
	str	r3, [r4, #36]
	str	ip, [r4, #28]
	str	r3, [r4, #852]
	ldr	r3, [r5, #3140]
	str	r2, [r4, #864]
	str	r3, [r4, #848]
	bl	PostPro_GetVp8MbGroup
	b	.L333
.L312:
	ldr	r3, [r2, #292]
	add	r3, r2, r3, lsl #2
	ldr	r3, [r3, #308]
	str	r3, [r1, #4]
	ldr	r3, [r2, #296]
	str	r3, [r1, #8]
	ldr	r3, [r2, #1008]
	ldr	r0, [r3, #1640]
	add	r3, r2, r0, lsl #2
	ldr	r3, [r3, #308]
	str	r3, [r1, #16]
	ldr	r3, [r2, #300]
	add	r3, r2, r3, lsl #2
	ldr	r3, [r3, #700]
	str	r3, [r1, #20]
	ldr	r3, [r2, #28]
	str	r3, [r1, #24]
	ldr	r3, [r2, #20]
	str	r3, [r1, #28]
	ldrb	r3, [r2]
	clz	r3, r3
	mov	r3, r3, lsr #5
	str	r3, [r1, #32]
	ldrb	r3, [r2, #1]
	clz	r3, r3
	mov	r3, r3, lsr #5
	str	r3, [r1, #36]
	ldr	ip, [r2, #1000]
	cmp	ip, #0
	beq	.L341
	ldr	r3, [r2, #1204]
	cmp	r3, r0
	addne	r2, r2, #1200
	movne	r3, #0
	addne	r2, r2, #4
	bne	.L344
	b	.L431
.L345:
	ldr	r1, [r2, #4]!
	cmp	r1, r0
	beq	.L342
.L344:
	add	r3, r3, #1
	cmp	r3, ip
	bne	.L345
.L341:
	ldr	r2, [r5, #32]
	ldrsb	r3, [r5, #2]
	cmp	r2, #0
	ldrneb	r2, [r5]
	clzne	r2, r2
	movne	r2, r2, lsr #5
	cmp	r3, #0
	streq	r3, [r7, #8]
	bne	.L432
.L348:
	ldr	r0, [r4, #4]
	ldr	r3, [r4, #16]
	cmp	r0, r3
	bne	.L349
	ldr	ip, [r5, #696]
	cmp	ip, #0
	beq	.L349
	ldr	r2, [r5, #308]
	cmp	r0, r2
	addeq	r1, r5, #308
	moveq	r3, #0
	bne	.L350
.L352:
	add	r3, r3, #1
	cmp	r3, ip
	beq	.L349
	ldr	r2, [r1, #4]!
	cmp	r0, r2
	beq	.L352
.L350:
	str	r2, [r4, #16]
	b	.L349
.L313:
	ldr	r3, [r2, #1280]
	mov	r1, #1
	add	r3, r3, #332
	add	r3, r3, #2
	ldr	r3, [r2, r3, asl #2]
	str	r3, [r4, #4]
	ldr	r3, [r2, #2788]
	str	r3, [r4, #8]
	ldr	r3, [r2, #2568]
	ldr	r3, [r3, #372]
	add	r3, r3, #332
	add	r3, r3, #2
	ldr	r3, [r2, r3, asl #2]
	str	r3, [r4, #16]
	ldr	r3, [r2, #1284]
	add	r3, r2, r3, lsl #2
	ldr	r3, [r3, #1468]
	str	r3, [r4, #20]
	ldr	r0, [r2, #68]
	mov	r3, r1, asl r0
	str	r0, [r4, #864]
	ldr	r2, [r2, #1316]
	str	r2, [r4, #848]
	ldr	r2, [r5, #188]
	sub	r2, r2, #1
	add	r2, r2, r3
	mov	r2, r2, lsr r0
	str	r2, [r4, #24]
	ldr	r2, [r5, #184]
	sub	r2, r2, #1
	add	r3, r2, r3
	mov	r3, r3, lsr r0
	str	r3, [r4, #28]
	ldrb	r3, [r5, #217]
	str	r1, [r4, #32]
	str	r3, [r4, #868]
	ldr	r3, [r5, #8]
	clz	r3, r3
	mov	r3, r3, lsr #5
	str	r3, [r4, #36]
	ldr	r3, [r5, #1332]
	cmp	r3, #0
	streq	r3, [r7, #8]
	bne	.L433
.L335:
	ldr	r1, [r4, #4]
	ldr	r3, [r4, #16]
	cmp	r1, r3
	beq	.L434
.L336:
	mov	r3, #0
	str	r3, [r4, #852]
	b	.L333
.L300:
	mov	r3, #844
	ldr	r2, .L435+8
	ldr	r1, .L435+12
	mov	r0, #0
	bl	dprint_vfmw
	b	.L333
.L420:
	str	r3, [r4, #852]
	b	.L360
.L430:
	ldrb	r3, [r5, #8]
	cmp	r3, #0
	moveq	r3, #1
	streq	r3, [r4, #852]
	beq	.L365
	cmp	r3, #1
	moveq	r3, #2
	streq	r3, [r4, #852]
	b	.L365
.L427:
	mov	r3, #0
.L316:
	add	r3, r5, r3, lsl #2
	ldr	r3, [r3, #1140]
	str	r3, [r4, #844]
	b	.L315
.L431:
	mov	r3, #0
.L342:
	add	r3, r5, r3, lsl #2
	ldr	r3, [r3, #1140]
	str	r3, [r4, #844]
	b	.L341
.L433:
	ldr	r3, [fp, #4]
	mov	r2, r5
	mov	r1, r7
	mov	r0, r4
	bl	PostPro_GetHevcMbGroup
	b	.L335
.L428:
	mov	r1, r7
	mov	r0, r4
	bl	PostPro_GetH264MbGroup
	b	.L322
.L432:
	mov	r1, r7
	mov	r0, r4
	bl	PostPro_GetH264MbGroup
	b	.L348
.L434:
	ldr	r0, [r5, #1464]
	cmp	r0, #0
	beq	.L336
	ldr	r2, [r5, #1336]
	cmp	r1, r2
	addeq	r5, r5, #1328
	moveq	r3, #0
	addeq	r5, r5, #8
	bne	.L337
.L339:
	add	r3, r3, #1
	cmp	r3, r0
	beq	.L336
	ldr	r2, [r5, #4]!
	cmp	r1, r2
	beq	.L339
.L337:
	str	r2, [r4, #16]
	b	.L336
.L429:
	ldr	ip, [r5, #696]
	cmp	ip, #0
	beq	.L349
	ldr	r2, [r5, #308]
	cmp	r0, r2
	addeq	r1, r5, #308
	moveq	r3, #0
	bne	.L350
.L326:
	add	r3, r3, #1
	cmp	r3, ip
	beq	.L349
	ldr	r2, [r1, #4]!
	cmp	r0, r2
	beq	.L326
	b	.L350
.L436:
	.align	2
.L435:
	.word	.LC8
	.word	.LC9
	.word	.LANCHOR0+24
	.word	.LC7
	.fnend
	.size	PostPro_GetRepairParam, .-PostPro_GetRepairParam
	.align	2
	.global	PostPro_GetErrRatio
	.type	PostPro_GetErrRatio, %function
PostPro_GetErrRatio:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #28
	sub	sp, sp, #28
	push	{lr}
	bl	__gnu_mcount_nc
	subs	r3, r0, #0
	beq	.L442
	ldr	ip, .L443
	mov	r2, #12
	ldr	r5, [r3]
	mov	r1, #0
	ldr	r4, .L443+4
	sub	r0, fp, #48
	ldr	ip, [ip, #48]
	ldr	r7, [r3, #4]
	ldr	r8, [r3, #8]
	blx	ip
	mov	r3, #816
	ldr	r1, .L443+8
	mla	r4, r3, r5, r4
	ldr	r6, .L443+12
	ldr	r3, [r1, #132]
	mov	r2, #1744
	str	r7, [fp, #-48]
	cmp	r3, #0
	str	r5, [fp, #-40]
	mla	r6, r2, r5, r6
	str	r4, [fp, #-44]
	beq	.L440
	sub	r0, fp, #48
	blx	r3
.L441:
	mov	r3, r4
	mov	r2, r8
	mov	r1, r6
	str	r5, [sp]
	mov	r0, r7
	bl	PostPro_GetRepairParam
	ldr	r1, .L443+16
	mov	r4, r0
	mov	r2, r0
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r4
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L440:
	mov	r0, r3
	mov	r2, #131
	ldr	r1, .L443+20
	bl	dprint_vfmw
	b	.L441
.L442:
	ldr	r1, .L443+24
	bl	dprint_vfmw
	mov	r0, #1
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L444:
	.align	2
.L443:
	.word	vfmw_Osal_Func_Ptr_S
	.word	g_DecReport
	.word	g_vdm_hal_fun_ptr
	.word	g_RepairParam
	.word	.LC12
	.word	.LC11
	.word	.LC10
	.fnend
	.size	PostPro_GetErrRatio, .-PostPro_GetErrRatio
	.align	2
	.global	PostPro_SetFullRepair
	.type	PostPro_SetFullRepair, %function
PostPro_SetFullRepair:
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
	mov	ip, #816
	ldr	r5, .L446
	mul	ip, ip, r2
	ldr	r3, .L446+4
	mov	lr, r2
	mov	r7, #1744
	str	r2, [sp]
	mov	r6, #1
	add	r4, r5, ip
	mov	r2, r1
	mla	r1, r7, lr, r3
	str	r6, [r5, ip]
	mov	r3, r4
	mov	ip, #0
	str	ip, [r4, #8]
	bl	PostPro_GetRepairParam
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L447:
	.align	2
.L446:
	.word	g_DecReport
	.word	g_RepairParam
	.fnend
	.size	PostPro_SetFullRepair, .-PostPro_SetFullRepair
	.align	2
	.global	PostPro_SetDecReport
	.type	PostPro_SetDecReport, %function
PostPro_SetDecReport:
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
	ldr	r3, .L467
	mov	r5, r0
	mov	r4, r2
	mov	r6, r1
	mov	r0, r2
	ldr	r3, [r3, #48]
	mov	r2, #816
	mov	r1, #0
	blx	r3
	cmp	r5, #17
	ldrls	pc, [pc, r5, asl #2]
	b	.L449
.L451:
	.word	.L460
	.word	.L460
	.word	.L460
	.word	.L460
	.word	.L449
	.word	.L460
	.word	.L456
	.word	.L449
	.word	.L460
	.word	.L460
	.word	.L460
	.word	.L460
	.word	.L460
	.word	.L460
	.word	.L449
	.word	.L460
	.word	.L460
	.word	.L460
.L456:
	ldrb	r3, [r6, #17]
	cmp	r3, #1
	beq	.L466
.L460:
	mov	r3, #0
	mov	r2, #1
	strh	r3, [r4, #12]
	str	r2, [r4, #8]
	strh	r3, [r4, #14]
.L464:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L449:
	movw	r3, #2159
	ldr	r2, .L467+4
	ldr	r1, .L467+8
	mov	r0, #0
	bl	dprint_vfmw
	b	.L464
.L466:
	mov	r3, #0
	mov	r2, #2
	strh	r3, [r4, #12]
	str	r2, [r4, #8]
	strh	r3, [r4, #14]
	ldrh	r2, [r6, #56]
	ldrh	r3, [r6, #58]
	mul	r3, r3, r2
	add	r3, r3, r3, lsr #31
	mov	r3, r3, asr #1
	strh	r3, [r4, #16]
	ldrh	r2, [r6, #56]
	ldrh	r3, [r6, #58]
	mul	r3, r3, r2
	add	r3, r3, r3, lsr #31
	mov	r3, r3, asr #1
	strh	r3, [r4, #18]
	b	.L464
.L468:
	.align	2
.L467:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0+48
	.word	.LC7
	.fnend
	.size	PostPro_SetDecReport, .-PostPro_SetDecReport
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	__func__.14864, %object
	.size	__func__.14864, 23
__func__.14864:
	.ascii	"PostPro_GetHevcMbGroup\000"
	.space	1
	.type	__func__.14817, %object
	.size	__func__.14817, 23
__func__.14817:
	.ascii	"PostPro_GetRepairParam\000"
	.space	1
	.type	__func__.15058, %object
	.size	__func__.15058, 21
__func__.15058:
	.ascii	"PostPro_SetDecReport\000"
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"pRepairParam->ImageWidth=%d,pRepairParam->ImageHeig"
	.ascii	"ht=%d\012\000"
	.space	2
.LC1:
	.ascii	"DecSliceNum(=%d) out of range!\012\000"
.LC2:
	.ascii	"pRepairParam->ValidGroupNum >(MAX_UP_MSG_SLICE_NUM "
	.ascii	"- 1)\012\000"
	.space	3
.LC3:
	.ascii	"%s:0 pRepairParam->ValidGroupNum(%d) > (MAX_UP_MSG_"
	.ascii	"SLICE_NUM - 1)\012\000"
	.space	1
.LC4:
	.ascii	"%s:1 pRepairParam->ValidGroupNum(%d) > (MAX_UP_MSG_"
	.ascii	"SLICE_NUM - 1)\012\000"
	.space	1
.LC5:
	.ascii	"DecSliceNum out of range!\012\000"
	.space	1
.LC6:
	.ascii	"line:%d! pRepairParam->ValidGroupNum > (MAX_UP_MSG_"
	.ascii	"SLICE_NUM - 1)\012\000"
	.space	1
.LC7:
	.ascii	"%s %d VidStd Err!\012\000"
	.space	1
.LC8:
	.ascii	"pRepairParam[0].MbGroup[i].EndMbn=%d,pRepairParam[0"
	.ascii	"].MbGroup[i].StartMbn=%d\012\000"
	.space	3
.LC9:
	.ascii	"total_mbs=%d,err_mbs=%d\012\000"
	.space	3
.LC10:
	.ascii	"PostPro_GetErrRatio: pParam = NULL\012\000"
.LC11:
	.ascii	"VDMHAL_NULL_FUN_PRINT,L%d\012\000"
	.space	1
.LC12:
	.ascii	"err_ratio=%d\012\000"
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
