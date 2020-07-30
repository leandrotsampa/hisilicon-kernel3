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
	.file	"vdm_hal_vp9.c"

	.text
	.align	2
	.global	VP9HAL_V400R003_InitHal
	.type	VP9HAL_V400R003_InitHal, %function
VP9HAL_V400R003_InitHal:
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
	.size	VP9HAL_V400R003_InitHal, .-VP9HAL_V400R003_InitHal
	.align	2
	.global	VP9HAL_V400R003_CfgReg
	.type	VP9HAL_V400R003_CfgReg, %function
VP9HAL_V400R003_CfgReg:
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
	ldr	r5, .L19
	mov	ip, #44
	ldr	lr, .L19+4
	mov	r6, r0
	ldr	r4, .L19+8
	mov	r8, r1
	mla	ip, ip, r2, r5
	ldrb	r0, [lr]
	mov	lr, #0
	rsb	r1, lr, r3
	cmp	r0, #1
	clz	r1, r1
	str	lr, [fp, #-48]
	mov	r5, r3
	mov	r1, r1, lsr #5
	moveq	r1, #0
	ldr	r0, [ip, #8]
	cmp	r1, lr
	ldr	r0, [r4, r0, asl #2]
	ldr	r10, [r0, #1192]
	bne	.L16
	cmp	r2, #0
	bgt	.L17
	bne	.L13
	ldr	r3, [r8]
	cmp	r3, #0
	beq	.L18
.L9:
	add	r6, r6, #266240
	ldr	r1, [fp, #-48]
	ldr	r0, [r8, #1196]
	mov	r3, r5
	ldr	r7, [r6, #1576]
	mov	r2, #0
	ldr	ip, [r6, #1580]
	bic	r0, r0, #15
	str	r0, [r6, #1832]
	mov	r0, #8
	ldr	lr, [r8, #1200]
	mov	r4, r2
	mul	ip, r7, ip
	bic	lr, lr, #15
	str	lr, [r6, #1836]
	mov	r7, #3
	mov	r9, #2
	sub	ip, ip, #1
	bfi	r1, ip, #0, #20
	str	r1, [fp, #-48]
	mov	r1, r1, lsr #24
	and	r1, r1, #191
	bfc	r1, #7, #1
	strb	r1, [fp, #-45]
	ldr	ip, [fp, #-48]
	mov	r1, ip
	str	ip, [fp, #-56]
	bl	MFDE_ConfigReg
	ldr	ip, [fp, #-56]
	ldr	r1, .L19+12
	mov	r0, r7
	mov	r2, ip
	bl	dprint_vfmw
	strh	r7, [fp, #-46]
	mov	r3, #0
	bfi	r3, r4, #5, #1
	strb	r3, [fp, #-45]
	mov	r3, #0
	ldr	r2, [r6, #1952]
	bfi	r3, r10, #3, #1
	ldr	ip, [r6, #1948]
	mov	r0, #14
	ldrb	r1, [fp, #-45]
	bfi	r3, r2, #4, #1
	and	r3, r3, #223
	strb	r0, [fp, #-48]
	bfi	r1, ip, #6, #1
	orr	r3, r3, #192
	bfi	r1, r4, #7, #1
	strb	r3, [fp, #-47]
	strb	r1, [fp, #-45]
	mov	r3, r5
	ldr	r10, [fp, #-48]
	mov	r2, r4
	mov	r0, #12
	mov	r1, r10
	bl	MFDE_ConfigReg
	mov	r2, r10
	ldr	r1, .L19+16
	mov	r0, r7
	bl	dprint_vfmw
	ldr	r10, [r8, #56]
	mov	r3, r5
	mov	r2, r4
	bic	r10, r10, #15
	mov	r0, #16
	mov	r1, r10
	bl	MFDE_ConfigReg
	mov	r2, r10
	ldr	r1, .L19+20
	mov	r0, r7
	bl	dprint_vfmw
	ldr	r10, [r8, #40]
	mov	r3, r5
	mov	r2, r4
	bic	r10, r10, #15
	mov	r0, #20
	mov	r1, r10
	bl	MFDE_ConfigReg
	mov	r2, r10
	ldr	r1, .L19+24
	mov	r0, r7
	bl	dprint_vfmw
	ldr	r10, [r6, #1608]
	mov	r3, r5
	mov	r2, r4
	mov	r0, #24
	mov	r1, r10
	bl	MFDE_ConfigReg
	mov	r2, r10
	ldr	r1, .L19+28
	mov	r0, r7
	bl	dprint_vfmw
	ldr	r10, [r8, #1164]
	mov	r3, r5
	mov	r2, r4
	bic	r10, r10, #15
	mov	r0, #128
	mov	r1, r10
	bl	MFDE_ConfigReg
	mov	r2, r10
	ldr	r1, .L19+32
	mov	r0, r7
	bl	dprint_vfmw
	ldr	r10, [r8, #1168]
	mov	r3, r5
	mov	r2, r4
	mov	r0, #132
	mov	r1, r10
	bl	MFDE_ConfigReg
	mov	r2, r10
	ldr	r1, .L19+36
	mov	r0, r7
	bl	dprint_vfmw
	mov	r1, r9
	mov	r3, r5
	mov	r2, r4
	mov	r0, #152
	str	r9, [fp, #-48]
	bl	MFDE_ConfigReg
	mov	r2, r9
	ldr	r1, .L19+40
	mov	r0, r7
	bl	dprint_vfmw
	ldr	r1, [r6, #1576]
	mov	r2, r4
	mov	r3, r5
	cmp	r1, #256
	mov	r0, #4
	movhi	r1, #0
	movls	r1, #1
	bl	SCD_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, r4
	mov	r0, #60
	movt	r1, 48
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, r4
	mov	r0, #64
	movt	r1, 48
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, r4
	mov	r0, #68
	movt	r1, 48
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, r4
	mov	r0, #72
	movt	r1, 48
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, r4
	mov	r0, #76
	movt	r1, 48
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, r4
	mov	r0, #80
	movt	r1, 48
	bl	MFDE_ConfigReg
	movw	r1, #3075
	mov	r3, r5
	mov	r2, r4
	mov	r0, #84
	movt	r1, 48
	bl	MFDE_ConfigReg
	ldr	r9, [r6, #1580]
	mov	r3, r5
	mov	r2, r4
	mov	r0, #92
	mov	r9, r9, asl #6
	mov	r1, r9
	bl	MFDE_ConfigReg
	mov	r2, r9
	ldr	r1, .L19+44
	mov	r0, r7
	bl	dprint_vfmw
	ldr	r9, [r6, #1920]
	mov	r3, r5
	mov	r2, r4
	bic	r9, r9, #15
	mov	r0, #96
	mov	r1, r9
	bl	MFDE_ConfigReg
	mov	r2, r9
	ldr	r1, .L19+48
	mov	r0, r7
	bl	dprint_vfmw
	ldr	r9, [r6, #1584]
	mov	r3, r5
	mov	r2, r4
	mov	r0, #100
	mov	r1, r9
	bl	MFDE_ConfigReg
	mov	r2, r9
	ldr	r1, .L19+52
	mov	r0, r7
	bl	dprint_vfmw
	ldr	r9, [r6, #1588]
	mov	r3, r5
	mov	r2, r4
	mov	r0, #104
	mov	r1, r9
	bl	MFDE_ConfigReg
	mov	r2, r9
	ldr	r1, .L19+56
	mov	r0, r7
	bl	dprint_vfmw
	ldr	r6, [r6, #1968]
	mov	r3, r5
	mov	r2, r4
	mov	r0, #108
	mov	r1, r6
	bl	MFDE_ConfigReg
	mov	r2, r6
	ldr	r1, .L19+60
	mov	r0, r7
	bl	dprint_vfmw
	ldr	r6, [r8, #1188]
	mov	r3, r5
	mov	r2, r4
	mov	r0, #112
	mov	r1, r6
	bl	MFDE_ConfigReg
	mov	r2, r6
	ldr	r1, .L19+64
	mov	r0, r7
	bl	dprint_vfmw
	mov	r0, #32
	mov	r3, r5
	mov	r2, r4
	mvn	r1, #0
	bl	MFDE_ConfigReg
	mov	r0, r4
.L4:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L18:
	mov	r0, #0
	movt	r0, 63683
	bl	MEM_Phy2Vir
	subs	r3, r0, #0
	beq	.L10
	str	r3, [r8]
	b	.L9
.L17:
	str	r1, [sp]
	mov	r3, r2
	mov	r0, r1
	ldr	r2, .L19+68
	ldr	r1, .L19+72
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4
.L13:
	mov	r0, r1
	ldr	r1, .L19+76
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4
.L16:
	mov	r0, lr
	ldr	r2, .L19+68
	ldr	r1, .L19+80
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4
.L10:
	ldr	r1, .L19+84
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4
.L20:
	.align	2
.L19:
	.word	g_VdmDrvParam
	.word	g_HalDisable
	.word	s_pstVfmwChan
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
	.word	.LC17
	.word	.LANCHOR0
	.word	.LC1
	.word	.LC2
	.word	.LC0
	.word	.LC3
	.fnend
	.size	VP9HAL_V400R003_CfgReg, .-VP9HAL_V400R003_CfgReg
	.align	2
	.global	VP9HAL_V400R003_CfgFrameMsg
	.type	VP9HAL_V400R003_CfgFrameMsg, %function
VP9HAL_V400R003_CfgFrameMsg:
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
	ldr	r0, [r1, #56]
	mov	r6, r1
	bl	MEM_Phy2Vir
	subs	r4, r0, #0
	beq	.L25
	ldr	r3, [r5]
	mov	r0, #4
	ldr	r1, .L27
	add	r7, r5, #266240
	str	r3, [r4]
	ldr	r2, [r4]
	bl	dprint_vfmw
	ldr	r3, [r5, #4]
	ldr	r1, .L27+4
	mov	r0, #4
	str	r3, [r4, #4]
	ldr	r2, [r4, #4]
	bl	dprint_vfmw
	ldr	r3, [r5, #8]
	ldr	r1, .L27+8
	mov	r0, #4
	str	r3, [r4, #8]
	ldr	r2, [r4, #8]
	bl	dprint_vfmw
	ldr	r3, [r5, #12]
	ldr	r1, .L27+12
	mov	r0, #4
	str	r3, [r4, #12]
	ldr	r2, [r4, #12]
	bl	dprint_vfmw
	ldr	r3, [r5, #16]
	ldr	r1, .L27+16
	mov	r0, #4
	str	r3, [r4, #16]
	ldr	r2, [r4, #16]
	bl	dprint_vfmw
	ldr	r3, [r5, #20]
	ldr	r1, .L27+20
	mov	r0, #4
	str	r3, [r4, #20]
	ldr	r2, [r4, #20]
	bl	dprint_vfmw
	ldr	r3, [r5, #24]
	ldr	r1, .L27+24
	mov	r0, #4
	str	r3, [r4, #24]
	ldr	r2, [r4, #24]
	bl	dprint_vfmw
	ldr	r3, [r5, #28]
	ldr	r1, .L27+28
	mov	r0, #4
	str	r3, [r4, #28]
	ldr	r2, [r4, #28]
	bl	dprint_vfmw
	ldr	r3, [r5, #32]
	ldr	r1, .L27+32
	mov	r0, #4
	str	r3, [r4, #32]
	ldr	r2, [r4, #32]
	bl	dprint_vfmw
	ldr	r3, [r5, #36]
	ldr	r1, .L27+36
	mov	r0, #4
	str	r3, [r4, #36]
	ldr	r2, [r4, #36]
	bl	dprint_vfmw
	ldr	r3, [r5, #40]
	ldr	r1, .L27+40
	mov	r0, #4
	str	r3, [r4, #40]
	ldr	r2, [r4, #40]
	bl	dprint_vfmw
	ldr	r3, [r5, #44]
	ldr	r1, .L27+44
	mov	r0, #4
	str	r3, [r4, #44]
	ldr	r2, [r4, #44]
	bl	dprint_vfmw
	ldr	r3, [r5, #48]
	ldr	r1, .L27+48
	mov	r0, #4
	str	r3, [r4, #48]
	ldr	r2, [r4, #48]
	bl	dprint_vfmw
	ldr	r3, [r5, #52]
	ldr	r1, .L27+52
	mov	r0, #4
	str	r3, [r4, #52]
	ldr	r2, [r4, #52]
	bl	dprint_vfmw
	ldr	r3, [r5, #56]
	ldr	r1, .L27+56
	mov	r0, #4
	str	r3, [r4, #56]
	ldr	r2, [r4, #56]
	bl	dprint_vfmw
	ldr	r3, [r5, #60]
	ldr	r1, .L27+60
	mov	r0, #4
	str	r3, [r4, #60]
	ldr	r2, [r4, #60]
	bl	dprint_vfmw
	ldr	r3, [r5, #64]
	ldr	r1, .L27+64
	mov	r0, #4
	str	r3, [r4, #64]
	ldr	r2, [r4, #64]
	bl	dprint_vfmw
	ldr	r3, [r5, #68]
	ldr	r1, .L27+68
	mov	r0, #4
	str	r3, [r4, #68]
	ldr	r2, [r4, #68]
	bl	dprint_vfmw
	ldr	r3, [r5, #72]
	ldr	r1, .L27+72
	mov	r0, #4
	str	r3, [r4, #72]
	ldr	r2, [r4, #72]
	bl	dprint_vfmw
	ldr	r3, [r5, #76]
	ldr	r1, .L27+76
	mov	r0, #4
	str	r3, [r4, #76]
	ldr	r2, [r4, #76]
	bl	dprint_vfmw
	ldr	r3, [r5, #80]
	ldr	r1, .L27+80
	mov	r0, #4
	str	r3, [r4, #80]
	ldr	r2, [r4, #80]
	bl	dprint_vfmw
	ldr	r3, [r5, #84]
	ldr	r1, .L27+84
	mov	r0, #4
	str	r3, [r4, #84]
	ldr	r2, [r4, #84]
	bl	dprint_vfmw
	ldr	r3, [r5, #88]
	ldr	r1, .L27+88
	mov	r0, #4
	str	r3, [r4, #88]
	ldr	r2, [r4, #88]
	bl	dprint_vfmw
	ldr	r3, [r5, #92]
	ldr	r1, .L27+92
	mov	r0, #4
	str	r3, [r4, #92]
	ldr	r2, [r4, #92]
	bl	dprint_vfmw
	ldr	r3, [r5, #96]
	ldr	r1, .L27+96
	mov	r0, #4
	str	r3, [r4, #96]
	ldr	r2, [r4, #96]
	bl	dprint_vfmw
	ldr	r3, [r5, #100]
	ldr	r1, .L27+100
	mov	r0, #4
	str	r3, [r4, #100]
	ldr	r2, [r4, #100]
	bl	dprint_vfmw
	ldr	r3, [r5, #104]
	ldr	r1, .L27+104
	mov	r0, #4
	str	r3, [r4, #104]
	ldr	r2, [r4, #104]
	bl	dprint_vfmw
	ldr	r3, [r5, #108]
	ldr	r1, .L27+108
	mov	r0, #4
	str	r3, [r4, #108]
	ldr	r2, [r4, #108]
	bl	dprint_vfmw
	ldr	r3, [r5, #112]
	ldr	r1, .L27+112
	mov	r0, #4
	str	r3, [r4, #112]
	ldr	r2, [r4, #112]
	bl	dprint_vfmw
	ldr	r3, [r5, #116]
	ldr	r1, .L27+116
	mov	r0, #4
	str	r3, [r4, #116]
	ldr	r2, [r4, #116]
	bl	dprint_vfmw
	ldr	r3, [r5, #120]
	ldr	r1, .L27+120
	mov	r0, #4
	str	r3, [r4, #120]
	ldr	r2, [r4, #120]
	bl	dprint_vfmw
	ldr	r3, [r7, #1972]
	ldr	r1, .L27+124
	mov	r0, #4
	bic	r3, r3, #15
	str	r3, [r4, #124]
	ldr	r2, [r4, #124]
	bl	dprint_vfmw
	ldr	r3, [r7, #1976]
	ldr	r1, .L27+128
	mov	r0, #4
	str	r3, [r4, #128]
	ldr	r2, [r4, #128]
	bl	dprint_vfmw
	ldr	r3, [r7, #1920]
	ldr	r1, .L27+128
	mov	r0, #4
	str	r3, [r4, #128]
	ldr	r2, [r4, #128]
	bl	dprint_vfmw
	ldr	r3, [r7, #1924]
	ldr	r1, .L27+132
	mov	r0, #4
	str	r3, [r4, #132]
	ldr	r2, [r4, #132]
	bl	dprint_vfmw
	ldr	r3, [r7, #1928]
	ldr	r1, .L27+136
	mov	r0, #4
	str	r3, [r4, #136]
	ldr	r2, [r4, #136]
	bl	dprint_vfmw
	ldr	r3, [r7, #1932]
	ldr	r1, .L27+140
	mov	r0, #4
	str	r3, [r4, #140]
	ldr	r2, [r4, #140]
	bl	dprint_vfmw
	ldr	r3, [r6, #1144]
	ldr	r1, .L27+144
	mov	r0, #4
	bic	r3, r3, #15
	str	r3, [r4, #144]
	ldr	r2, [r4, #144]
	bl	dprint_vfmw
	ldr	r3, [r6, #1148]
	ldr	r1, .L27+148
	mov	r0, #4
	bic	r3, r3, #15
	str	r3, [r4, #148]
	ldr	r2, [r4, #148]
	bl	dprint_vfmw
	ldr	r3, [r6, #1152]
	ldr	r1, .L27+152
	mov	r0, #4
	bic	r3, r3, #15
	str	r3, [r4, #152]
	ldr	r2, [r4, #152]
	bl	dprint_vfmw
	ldr	r8, [r6, #1196]
	ldr	r1, .L27+156
	mov	r0, #4
	bic	r8, r8, #15
	str	r8, [r4, #156]
	ldr	r2, [r4, #156]
	bl	dprint_vfmw
	mov	r0, r8
	bl	MEM_Phy2Vir
	subs	r9, r0, #0
	beq	.L26
	ldr	r8, .L27+160
	movw	r1, #1029
	mov	r2, #4608
	movt	r1, 4
	add	r1, r5, r1
	ldr	r3, [r8, #52]
	blx	r3
	ldr	r3, [r6, #1160]
	ldr	r1, .L27+164
	mov	r0, #4
	bic	r3, r3, #15
	str	r3, [r4, #160]
	ldr	r2, [r4, #160]
	bl	dprint_vfmw
	ldr	r3, [r6, #1200]
	ldr	r1, .L27+168
	mov	r0, #4
	bic	r3, r3, #15
	str	r3, [r4, #164]
	ldr	r2, [r4, #164]
	bl	dprint_vfmw
	ldr	r3, [r7, #1936]
	ldr	r1, .L27+172
	mov	r0, #4
	bic	r3, r3, #15
	str	r3, [r4, #168]
	ldr	r2, [r4, #168]
	bl	dprint_vfmw
	ldr	r3, [r6, #1192]
	ldr	r1, .L27+176
	mov	r0, #4
	bic	r3, r3, #15
	str	r3, [r4, #172]
	ldr	r2, [r4, #172]
	bl	dprint_vfmw
	ldr	r3, [r5, #180]
	ldr	r1, .L27+180
	mov	r0, #4
	str	r3, [r4, #180]
	ldr	r2, [r4, #180]
	bl	dprint_vfmw
	ldr	r3, [r5, #184]
	ldr	r1, .L27+184
	mov	r0, #4
	str	r3, [r4, #184]
	ldr	r2, [r4, #184]
	bl	dprint_vfmw
	ldr	r3, [r5, #188]
	ldr	r1, .L27+188
	mov	r0, #4
	str	r3, [r4, #188]
	ldr	r2, [r4, #188]
	bl	dprint_vfmw
	ldr	r3, [r5, #192]
	ldr	r1, .L27+192
	mov	r0, #4
	str	r3, [r4, #192]
	ldr	r2, [r4, #192]
	bl	dprint_vfmw
	ldr	r3, [r5, #196]
	ldr	r1, .L27+196
	mov	r0, #4
	str	r3, [r4, #196]
	ldr	r2, [r4, #196]
	bl	dprint_vfmw
	ldr	r3, [r5, #200]
	ldr	r1, .L27+200
	mov	r0, #4
	str	r3, [r4, #200]
	ldr	r2, [r4, #200]
	bl	dprint_vfmw
	ldr	r3, [r5, #204]
	ldr	r1, .L27+204
	mov	r0, #4
	str	r3, [r4, #204]
	ldr	r2, [r4, #204]
	bl	dprint_vfmw
	ldr	r3, [r5, #208]
	ldr	r1, .L27+208
	mov	r0, #4
	str	r3, [r4, #208]
	ldr	r2, [r4, #208]
	bl	dprint_vfmw
	ldr	r3, [r5, #212]
	ldr	r1, .L27+212
	mov	r0, #4
	str	r3, [r4, #212]
	ldr	r2, [r4, #212]
	bl	dprint_vfmw
	ldr	r3, [r5, #216]
	ldr	r1, .L27+216
	mov	r0, #4
	str	r3, [r4, #216]
	ldr	r2, [r4, #216]
	bl	dprint_vfmw
	ldr	r3, [r5, #220]
	ldr	r1, .L27+220
	mov	r0, #4
	str	r3, [r4, #220]
	ldr	r2, [r4, #220]
	bl	dprint_vfmw
	ldr	r3, [r5, #224]
	ldr	r1, .L27+224
	mov	r0, #4
	str	r3, [r4, #224]
	ldr	r2, [r4, #224]
	bl	dprint_vfmw
	ldr	r3, [r5, #228]
	ldr	r1, .L27+228
	mov	r0, #4
	str	r3, [r4, #228]
	ldr	r2, [r4, #228]
	bl	dprint_vfmw
	ldr	r3, [r5, #232]
	ldr	r1, .L27+232
	mov	r0, #4
	str	r3, [r4, #232]
	ldr	r2, [r4, #232]
	bl	dprint_vfmw
	ldr	r3, [r5, #236]
	ldr	r1, .L27+236
	mov	r0, #4
	str	r3, [r4, #236]
	ldr	r2, [r4, #236]
	bl	dprint_vfmw
	ldr	r3, [r5, #240]
	ldr	r1, .L27+240
	mov	r0, #4
	str	r3, [r4, #240]
	ldr	r2, [r4, #240]
	bl	dprint_vfmw
	ldr	r3, [r5, #244]
	ldr	r1, .L27+244
	mov	r0, #4
	str	r3, [r4, #244]
	ldr	r2, [r4, #244]
	bl	dprint_vfmw
	ldr	r3, [r5, #248]
	ldr	r1, .L27+248
	mov	r0, #4
	str	r3, [r4, #248]
	ldr	r2, [r4, #248]
	bl	dprint_vfmw
	ldr	r3, [r6, #60]
	ldr	r1, .L27+252
	mov	r0, #4
	str	r3, [r4, #252]
	ldr	r2, [r4, #252]
	bl	dprint_vfmw
	mov	r0, r9
	ldr	r3, [r8, #136]
	mov	r2, #4608
	ldr	r1, [r7, #1832]
	blx	r3
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L25:
	ldr	r3, .L27+256
	ldr	r2, .L27+260
	ldr	r1, .L27+264
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L26:
	ldr	r2, .L27+260
	ldr	r1, .L27+268
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L28:
	.align	2
.L27:
	.word	.LC20
	.word	.LC21
	.word	.LC22
	.word	.LC23
	.word	.LC24
	.word	.LC25
	.word	.LC26
	.word	.LC27
	.word	.LC28
	.word	.LC29
	.word	.LC30
	.word	.LC31
	.word	.LC32
	.word	.LC33
	.word	.LC34
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
	.word	.LC49
	.word	.LC50
	.word	.LC51
	.word	.LC52
	.word	.LC53
	.word	.LC54
	.word	.LC55
	.word	.LC56
	.word	.LC57
	.word	.LC58
	.word	.LC59
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC61
	.word	.LC62
	.word	.LC63
	.word	.LC64
	.word	.LC65
	.word	.LC66
	.word	.LC67
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
	.word	.LC18
	.word	.LANCHOR0+24
	.word	.LC19
	.word	.LC60
	.fnend
	.size	VP9HAL_V400R003_CfgFrameMsg, .-VP9HAL_V400R003_CfgFrameMsg
	.align	2
	.global	VP9HAL_V400R003_CfgTileMsg
	.type	VP9HAL_V400R003_CfgTileMsg, %function
VP9HAL_V400R003_CfgTileMsg:
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
	ldr	r7, [r1, #60]
	mov	r5, r0
	mov	r0, r7
	bl	MEM_Phy2Vir
	subs	r9, r0, #0
	beq	.L38
	add	r8, r5, #262144
	ldr	r2, [r8, #1024]
	sub	r3, r2, #1
	cmp	r3, #1024
	bcs	.L39
.L32:
	cmp	r2, #0
	movne	r4, r9
	movne	r6, #0
	beq	.L36
.L35:
	ldr	r3, [r5, #1024]
	mov	r0, #4
	ldr	r1, .L40
	add	r5, r5, #256
	add	r4, r4, #256
	str	r3, [r4, #-256]
	ldr	r2, [r4, #-256]
	bl	dprint_vfmw
	ldr	r3, [r5, #772]
	ldr	r1, .L40+4
	mov	r0, #4
	str	r3, [r4, #-252]
	ldr	r2, [r4, #-252]
	bl	dprint_vfmw
	ldr	r3, [r5, #776]
	ldr	r1, .L40+8
	mov	r0, #4
	str	r3, [r4, #-248]
	ldr	r2, [r4, #-248]
	bl	dprint_vfmw
	ldr	r3, [r5, #780]
	ldr	r1, .L40+12
	mov	r0, #4
	str	r3, [r4, #-244]
	ldr	r2, [r4, #-244]
	bl	dprint_vfmw
	ldr	r3, [r5, #784]
	ldr	r1, .L40+16
	mov	r0, #4
	str	r3, [r4, #-240]
	ldr	r2, [r4, #-240]
	bl	dprint_vfmw
	ldr	r3, [r5, #788]
	ldr	r1, .L40+20
	mov	r0, #4
	str	r3, [r4, #-236]
	ldr	r2, [r4, #-236]
	bl	dprint_vfmw
	ldr	r3, [r5, #792]
	ldr	r1, .L40+24
	mov	r0, #4
	str	r3, [r4, #-232]
	ldr	r2, [r4, #-232]
	bl	dprint_vfmw
	ldr	r3, [r5, #796]
	ldr	r1, .L40+28
	mov	r0, #4
	str	r3, [r4, #-228]
	ldr	r2, [r4, #-228]
	bl	dprint_vfmw
	ldr	r3, [r5, #800]
	ldr	r1, .L40+32
	mov	r0, #4
	str	r3, [r4, #-224]
	ldr	r2, [r4, #-224]
	bl	dprint_vfmw
	ldr	r3, [r5, #804]
	ldr	r1, .L40+36
	mov	r0, #4
	str	r3, [r4, #-220]
	ldr	r2, [r4, #-220]
	bl	dprint_vfmw
	ldr	r3, [r5, #808]
	ldr	r1, .L40+40
	mov	r0, #4
	str	r3, [r4, #-216]
	ldr	r2, [r4, #-216]
	bl	dprint_vfmw
	ldr	r3, [r5, #812]
	ldr	r1, .L40+44
	mov	r0, #4
	str	r3, [r4, #-212]
	ldr	r2, [r4, #-212]
	bl	dprint_vfmw
	ldr	r3, [r5, #1020]
	ldr	r1, .L40+48
	mov	r0, #4
	str	r3, [r4, #-4]
	ldr	r2, [r4, #-4]
	bl	dprint_vfmw
	cmp	r6, #0
	strgt	r7, [r4, #-260]
	add	r6, r6, #1
	ldr	r3, [r8, #1024]
	add	r7, r7, #256
	cmp	r6, r3
	bcc	.L35
	cmp	r3, #1
	bls	.L36
	add	r3, r9, r3, lsl #8
	mov	r2, #0
	mov	r0, r2
	str	r2, [r3, #-4]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L39:
	ldr	r1, .L40+52
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r2, [r8, #1024]
	b	.L32
.L36:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L38:
	ldr	r3, .L40+56
	ldr	r2, .L40+60
	ldr	r1, .L40+64
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L41:
	.align	2
.L40:
	.word	.LC85
	.word	.LC86
	.word	.LC87
	.word	.LC88
	.word	.LC89
	.word	.LC90
	.word	.LC91
	.word	.LC92
	.word	.LC93
	.word	.LC94
	.word	.LC95
	.word	.LC96
	.word	.LC97
	.word	.LC84
	.word	.LC18
	.word	.LANCHOR0+52
	.word	.LC19
	.fnend
	.size	VP9HAL_V400R003_CfgTileMsg, .-VP9HAL_V400R003_CfgTileMsg
	.align	2
	.global	VP9HAL_V400R003_StartDec
	.type	VP9HAL_V400R003_StartDec, %function
VP9HAL_V400R003_StartDec:
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
	ldr	r5, .L55
	cmp	r1, #0
	movw	r4, #1224
	mov	r6, r0
	mla	r4, r4, r1, r5
	bgt	.L53
	bne	.L51
	add	r1, r0, #266240
	ldr	r3, [r1, #1576]
	cmp	r3, #512
	bhi	.L47
	ldr	r3, [r1, #1580]
	cmp	r3, #512
	bhi	.L47
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L54
.L49:
	mov	r3, r2
	mov	r1, r4
	mov	r2, #0
	mov	r0, r6
	bl	VP9HAL_V400R003_CfgReg
	mov	r2, #0
	mov	r1, r4
	mov	r0, r6
	bl	VP9HAL_V400R003_CfgFrameMsg
	mov	r1, r4
	mov	r0, r6
	mov	r2, #0
	bl	VP9HAL_V400R003_CfgTileMsg
	mov	r0, #0
.L44:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L54:
	mov	r0, #0
	str	r2, [fp, #-32]
	movt	r0, 63683
	bl	MEM_Phy2Vir
	subs	r3, r0, #0
	beq	.L50
	str	r3, [r5]
	ldr	r2, [fp, #-32]
	b	.L49
.L53:
	mov	r0, #0
	mov	r3, r1
	str	r0, [sp]
	ldr	r2, .L55+4
	ldr	r1, .L55+8
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L44
.L47:
	ldr	r3, .L55+12
	mov	r0, #0
	ldr	r2, .L55+4
	ldr	r1, .L55+16
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L44
.L51:
	ldr	r1, .L55+20
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L44
.L50:
	ldr	r1, .L55+24
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L44
.L56:
	.align	2
.L55:
	.word	g_HwMem
	.word	.LANCHOR0+80
	.word	.LC1
	.word	.LC99
	.word	.LC19
	.word	.LC98
	.word	.LC3
	.fnend
	.size	VP9HAL_V400R003_StartDec, .-VP9HAL_V400R003_StartDec
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	__func__.15064, %object
	.size	__func__.15064, 23
__func__.15064:
	.ascii	"VP9HAL_V400R003_CfgReg\000"
	.space	1
	.type	__func__.15078, %object
	.size	__func__.15078, 28
__func__.15078:
	.ascii	"VP9HAL_V400R003_CfgFrameMsg\000"
	.type	__func__.15089, %object
	.size	__func__.15089, 27
__func__.15089:
	.ascii	"VP9HAL_V400R003_CfgTileMsg\000"
	.space	1
	.type	__func__.15101, %object
	.size	__func__.15101, 25
__func__.15101:
	.ascii	"VP9HAL_V400R003_StartDec\000"
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"%s: pMfdeTask(%p) = NULL\012\000"
	.space	2
.LC1:
	.ascii	"%s: VdhId(%d) > %d\012\000"
.LC2:
	.ascii	"VdhId is wrong! VP9HAL_V400R003_CfgReg\012\000"
.LC3:
	.ascii	"vdm register virtual address not mapped, reset fail"
	.ascii	"ed!\012\000"
.LC4:
	.ascii	"BASIC_CFG0 = 0x%x\012\000"
	.space	1
.LC5:
	.ascii	"BASIC_CFG1 = 0x%x\012\000"
	.space	1
.LC6:
	.ascii	"AVM_ADDR = 0x%x\012\000"
	.space	3
.LC7:
	.ascii	"VAM_ADDR = 0x%x\012\000"
	.space	3
.LC8:
	.ascii	"STREAM_BASE_ADDR = 0x%x\012\000"
	.space	3
.LC9:
	.ascii	"PPFD_BUF_ADDR = 0x%x\012\000"
	.space	2
.LC10:
	.ascii	"PPFD_BUF_LEN = 0x%x\012\000"
	.space	3
.LC11:
	.ascii	"FF_APT_EN = 0x%x\012\000"
	.space	2
.LC12:
	.ascii	"DEC_OVER_INT_LEVEL=0x%x\012\000"
	.space	3
.LC13:
	.ascii	"YSTADDR_1D = 0x%x\012\000"
	.space	1
.LC14:
	.ascii	"YSTRIDE_1D = 0x%x\012\000"
	.space	1
.LC15:
	.ascii	"UVOFFSET_1D = 0x%x\012\000"
.LC16:
	.ascii	"HEAD_INF_OFFSET = 0x%x\012\000"
.LC17:
	.ascii	"VREG_LINE_NUM_STADDR = 0x%x\012\000"
	.space	3
.LC18:
	.ascii	"can not map down msg virtual address!\012\000"
	.space	1
.LC19:
	.ascii	"%s: %s\012\000"
.LC20:
	.ascii	"PicMsg D[0] = 0x%x\012\000"
.LC21:
	.ascii	"PicMsg D[1] = 0x%x\012\000"
.LC22:
	.ascii	"PicMsg D[2] = 0x%x\012\000"
.LC23:
	.ascii	"PicMsg D[3] = 0x%x\012\000"
.LC24:
	.ascii	"PicMsg D[4] = 0x%x\012\000"
.LC25:
	.ascii	"PicMsg D[5] = 0x%x\012\000"
.LC26:
	.ascii	"PicMsg D[6] = 0x%x\012\000"
.LC27:
	.ascii	"PicMsg D[7] = 0x%x\012\000"
.LC28:
	.ascii	"PicMsg D[8] = 0x%x\012\000"
.LC29:
	.ascii	"PicMsg D[9] = 0x%x\012\000"
.LC30:
	.ascii	"PicMsg D[10] = 0x%x\012\000"
	.space	3
.LC31:
	.ascii	"PicMsg D[11] = 0x%x\012\000"
	.space	3
.LC32:
	.ascii	"PicMsg D[12] = 0x%x\012\000"
	.space	3
.LC33:
	.ascii	"PicMsg D[13] = 0x%x\012\000"
	.space	3
.LC34:
	.ascii	"PicMsg D[14] = 0x%x\012\000"
	.space	3
.LC35:
	.ascii	"PicMsg D[15] = 0x%x\012\000"
	.space	3
.LC36:
	.ascii	"PicMsg D[16] = 0x%x\012\000"
	.space	3
.LC37:
	.ascii	"PicMsg D[17] = 0x%x\012\000"
	.space	3
.LC38:
	.ascii	"PicMsg D[18] = 0x%x\012\000"
	.space	3
.LC39:
	.ascii	"PicMsg D[19] = 0x%x\012\000"
	.space	3
.LC40:
	.ascii	"PicMsg D[20] = 0x%x\012\000"
	.space	3
.LC41:
	.ascii	"PicMsg D[21] = 0x%x\012\000"
	.space	3
.LC42:
	.ascii	"PicMsg D[22] = 0x%x\012\000"
	.space	3
.LC43:
	.ascii	"PicMsg D[23] = 0x%x\012\000"
	.space	3
.LC44:
	.ascii	"PicMsg D[24] = 0x%x\012\000"
	.space	3
.LC45:
	.ascii	"PicMsg D[25] = 0x%x\012\000"
	.space	3
.LC46:
	.ascii	"PicMsg D[26] = 0x%x\012\000"
	.space	3
.LC47:
	.ascii	"PicMsg D[27] = 0x%x\012\000"
	.space	3
.LC48:
	.ascii	"PicMsg D[28] = 0x%x\012\000"
	.space	3
.LC49:
	.ascii	"PicMsg D[29] = 0x%x\012\000"
	.space	3
.LC50:
	.ascii	"PicMsg D[30] = 0x%x\012\000"
	.space	3
.LC51:
	.ascii	"PicMsg D[31] = 0x%x\012\000"
	.space	3
.LC52:
	.ascii	"PicMsg D[32] = 0x%x\012\000"
	.space	3
.LC53:
	.ascii	"PicMsg D[33] = 0x%x\012\000"
	.space	3
.LC54:
	.ascii	"PicMsg D[34] = 0x%x\012\000"
	.space	3
.LC55:
	.ascii	"PicMsg D[35] = 0x%x\012\000"
	.space	3
.LC56:
	.ascii	"PicMsg D[36] = 0x%x\012\000"
	.space	3
.LC57:
	.ascii	"PicMsg D[37] = 0x%x\012\000"
	.space	3
.LC58:
	.ascii	"PicMsg D[38] = 0x%x\012\000"
	.space	3
.LC59:
	.ascii	"PicMsg D[39] = 0x%x\012\000"
	.space	3
.LC60:
	.ascii	"%s: pu8Vir = NULL\012\000"
	.space	1
.LC61:
	.ascii	"PicMsg D[40] = 0x%x\012\000"
	.space	3
.LC62:
	.ascii	"PicMsg D[41] = 0x%x\012\000"
	.space	3
.LC63:
	.ascii	"PicMsg D[42] = 0x%x\012\000"
	.space	3
.LC64:
	.ascii	"PicMsg D[43] = 0x%x\012\000"
	.space	3
.LC65:
	.ascii	"PicMsg D[45] = 0x%x\012\000"
	.space	3
.LC66:
	.ascii	"PicMsg D[46] = 0x%x\012\000"
	.space	3
.LC67:
	.ascii	"PicMsg D[47] = 0x%x\012\000"
	.space	3
.LC68:
	.ascii	"PicMsg D[48] = 0x%x\012\000"
	.space	3
.LC69:
	.ascii	"PicMsg D[49] = 0x%x\012\000"
	.space	3
.LC70:
	.ascii	"PicMsg D[50] = 0x%x\012\000"
	.space	3
.LC71:
	.ascii	"PicMsg D[51] = 0x%x\012\000"
	.space	3
.LC72:
	.ascii	"PicMsg D[52] = 0x%x\012\000"
	.space	3
.LC73:
	.ascii	"PicMsg D[53] = 0x%x\012\000"
	.space	3
.LC74:
	.ascii	"PicMsg D[54] = 0x%x\012\000"
	.space	3
.LC75:
	.ascii	"PicMsg D[55] = 0x%x\012\000"
	.space	3
.LC76:
	.ascii	"PicMsg D[56] = 0x%x\012\000"
	.space	3
.LC77:
	.ascii	"PicMsg D[57] = 0x%x\012\000"
	.space	3
.LC78:
	.ascii	"PicMsg D[58] = 0x%x\012\000"
	.space	3
.LC79:
	.ascii	"PicMsg D[59] = 0x%x\012\000"
	.space	3
.LC80:
	.ascii	"PicMsg D[60] = 0x%x\012\000"
	.space	3
.LC81:
	.ascii	"PicMsg D[61] = 0x%x\012\000"
	.space	3
.LC82:
	.ascii	"PicMsg D[62] = 0x%x\012\000"
	.space	3
.LC83:
	.ascii	"PicMsg D[63] = 0x%x\012\000"
	.space	3
.LC84:
	.ascii	"ERROR: pVp9DecParam->TotalTileNum(%d) out of [0-102"
	.ascii	"4]\012\000"
	.space	1
.LC85:
	.ascii	"TileMsg D[0] = 0x%x\012\000"
	.space	3
.LC86:
	.ascii	"TileMsg D[1] = 0x%x\012\000"
	.space	3
.LC87:
	.ascii	"TileMsg D[2] = 0x%x\012\000"
	.space	3
.LC88:
	.ascii	"TileMsg D[3] = 0x%x\012\000"
	.space	3
.LC89:
	.ascii	"TileMsg D[4] = 0x%x\012\000"
	.space	3
.LC90:
	.ascii	"TileMsg D[5] = 0x%x\012\000"
	.space	3
.LC91:
	.ascii	"TileMsg D[6] = 0x%x\012\000"
	.space	3
.LC92:
	.ascii	"TileMsg D[7] = 0x%x\012\000"
	.space	3
.LC93:
	.ascii	"TileMsg D[8] = 0x%x\012\000"
	.space	3
.LC94:
	.ascii	"TileMsg D[9] = 0x%x\012\000"
	.space	3
.LC95:
	.ascii	"TileMsg D[10] = 0x%x\012\000"
	.space	2
.LC96:
	.ascii	"TileMsg D[11] = 0x%x\012\000"
	.space	2
.LC97:
	.ascii	"TileMsg D[63] = 0x%x\012\000"
	.space	2
.LC98:
	.ascii	"VdhId is wrong! VP9HAL_V400R003_StartDec\012\000"
	.space	2
.LC99:
	.ascii	"picture width out of range\000"
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
