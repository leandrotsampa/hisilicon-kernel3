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
	.file	"vdh_module.c"

	.text
	.align	2
	.global	VDH_Reset_Global
	.type	VDH_Reset_Global, %function
VDH_Reset_Global:
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
	ldr	r4, .L15
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L2
	mov	r0, #0
	blx	r3
	ldr	r3, [r4, #76]
	cmp	r3, #0
	beq	.L4
.L13:
	mov	r0, #0
	blx	r3
	ldr	r3, [r4, #60]
	cmp	r3, #0
	beq	.L6
.L14:
	mov	r0, #0
	blx	r3
.L7:
	ldr	r0, [r4, #64]
	cmp	r0, #0
	beq	.L8
	blx	r0
.L9:
	ldr	r3, [r4, #4]
	cmp	r3, #0
	beq	.L10
	mov	r0, #0
	blx	r3
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L10:
	mov	r0, r3
	mov	r2, #54
	ldr	r1, .L15+4
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L8:
	mov	r2, #52
	ldr	r1, .L15+4
	bl	dprint_vfmw
	b	.L9
.L2:
	mov	r0, r3
	mov	r2, #48
	ldr	r1, .L15+4
	bl	dprint_vfmw
	ldr	r3, [r4, #76]
	cmp	r3, #0
	bne	.L13
.L4:
	mov	r0, r3
	mov	r2, #49
	ldr	r1, .L15+4
	bl	dprint_vfmw
	ldr	r3, [r4, #60]
	cmp	r3, #0
	bne	.L14
.L6:
	mov	r0, r3
	mov	r2, #51
	ldr	r1, .L15+4
	bl	dprint_vfmw
	b	.L7
.L16:
	.align	2
.L15:
	.word	g_vdm_hal_fun_ptr
	.word	.LC0
	.fnend
	.size	VDH_Reset_Global, .-VDH_Reset_Global
	.align	2
	.global	VDH_Start_Mfde_Repair
	.type	VDH_Start_Mfde_Repair, %function
VDH_Start_Mfde_Repair:
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
	mov	r6, #0
	ldrb	r4, [r0]
	movt	r6, 63683
	mov	r5, r0
	mov	r0, r6
	bl	MEM_Phy2Vir
	cmp	r0, #0
	beq	.L21
	cmp	r4, #0
	bne	.L20
	ldr	r6, .L22
	movw	r3, #3075
	ldr	r0, [r5, #100]
	movt	r3, 48
	ldr	r1, .L22+4
	ldr	r2, [r6]
	str	r0, [r2, #16]
	ldr	r0, [r5, #116]
	str	r0, [r2, #36]
	ldr	r0, [r5, #96]
	str	r0, [r2, #12]
	str	r3, [r2, #60]
	str	r3, [r2, #64]
	str	r3, [r2, #68]
	str	r3, [r2, #72]
	str	r3, [r2, #76]
	str	r3, [r2, #80]
	str	r3, [r2, #84]
	ldr	r3, [r5, #92]
	str	r3, [r2, #8]
	ldr	r3, [r1, #108]
	blx	r3
	ldr	r3, [r6]
	mov	r2, #1
	str	r4, [r3]
	ldr	r3, [r6]
	str	r2, [r3]
	ldr	r3, [r6]
	str	r4, [r3]
.L17:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L20:
	mov	r5, #1
	mov	r3, r4
	str	r5, [sp]
	mov	r0, #32
	ldr	r2, .L22+8
	ldr	r1, .L22+12
	bl	dprint_vfmw
	mov	r3, r4
	str	r5, [sp]
	mov	r0, #32
	ldr	r2, .L22+8
	ldr	r1, .L22+12
	bl	dprint_vfmw
	mov	r3, r4
	str	r5, [sp]
	mov	r0, #32
	ldr	r2, .L22+8
	ldr	r1, .L22+12
	bl	dprint_vfmw
	mov	r3, r4
	str	r5, [sp]
	mov	r0, #32
	ldr	r2, .L22+8
	ldr	r1, .L22+12
	bl	dprint_vfmw
	mov	r3, r4
	str	r5, [sp]
	mov	r0, #32
	ldr	r2, .L22+8
	ldr	r1, .L22+12
	bl	dprint_vfmw
	mov	r3, r4
	str	r5, [sp]
	mov	r0, #32
	ldr	r2, .L22+8
	ldr	r1, .L22+12
	bl	dprint_vfmw
	mov	r3, r4
	str	r5, [sp]
	mov	r0, #32
	ldr	r2, .L22+8
	ldr	r1, .L22+12
	bl	dprint_vfmw
	mov	r3, r4
	str	r5, [sp]
	mov	r0, #32
	ldr	r2, .L22+8
	ldr	r1, .L22+12
	bl	dprint_vfmw
	mov	r3, r4
	str	r5, [sp]
	mov	r0, #32
	ldr	r2, .L22+8
	ldr	r1, .L22+12
	bl	dprint_vfmw
	mov	r3, r4
	str	r5, [sp]
	mov	r0, #32
	ldr	r2, .L22+8
	ldr	r1, .L22+12
	bl	dprint_vfmw
	mov	r3, r4
	ldr	r2, .L22+8
	mov	r0, #32
	ldr	r1, .L22+12
	str	r5, [sp]
	bl	dprint_vfmw
	ldr	r3, .L22+4
	ldr	r3, [r3, #108]
	blx	r3
	mov	r3, r4
	str	r5, [sp]
	mov	r0, #32
	ldr	r2, .L22+8
	ldr	r1, .L22+12
	bl	dprint_vfmw
	mov	r3, r4
	str	r5, [sp]
	mov	r0, #32
	ldr	r2, .L22+8
	ldr	r1, .L22+12
	bl	dprint_vfmw
	str	r5, [sp]
	mov	r3, r4
	ldr	r2, .L22+8
	ldr	r1, .L22+12
	mov	r0, #32
	bl	dprint_vfmw
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L21:
	str	r6, [sp]
	mov	r3, r4
	ldr	r2, .L22+8
	ldr	r1, .L22+16
	bl	dprint_vfmw
	b	.L17
.L23:
	.align	2
.L22:
	.word	g_HwMem
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.word	.LC2
	.word	.LC1
	.fnend
	.size	VDH_Start_Mfde_Repair, .-VDH_Start_Mfde_Repair
	.align	2
	.global	VDH_Start_Mfde_Decode
	.type	VDH_Start_Mfde_Decode, %function
VDH_Start_Mfde_Decode:
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
	mov	r6, #0
	ldrb	r5, [r0]
	movt	r6, 63683
	mov	r4, r0
	mov	r0, r6
	bl	MEM_Phy2Vir
	cmp	r0, #0
	beq	.L34
	ldr	r6, .L36
	ldr	r1, [r4, #56]
	ldr	r0, [r6]
	bl	MEM_WritePhyWord
	ldr	r0, [r6]
	ldr	r1, [r4, #64]
	add	r0, r0, #8
	bl	MEM_WritePhyWord
	cmp	r5, #0
	bne	.L27
	ldr	r3, .L36+4
	ldr	r2, [r4, #92]
	ldr	r3, [r3]
	str	r2, [r3, #8]
	ldr	r2, [r4, #96]
	str	r2, [r3, #12]
	ldr	r2, [r4, #100]
	str	r2, [r3, #16]
	ldr	r2, [r4, #104]
	str	r2, [r3, #20]
	ldr	r2, [r4, #108]
	str	r2, [r3, #24]
.L28:
	ldr	r3, [r4, #60]
	ldr	r0, [r6]
	cmp	r3, #0
	add	r0, r0, #4
	beq	.L35
	bl	MEM_ReadPhyWord
	orr	r1, r0, #65536
.L30:
	ldr	r0, [r6]
	add	r0, r0, #4
	bl	MEM_WritePhyWord
	cmp	r5, #0
	bne	.L31
	ldr	r3, .L36+4
	movw	r2, #3075
	movt	r2, 48
	ldr	r3, [r3]
	str	r2, [r3, #60]
	str	r2, [r3, #64]
	str	r2, [r3, #68]
	str	r2, [r3, #72]
	str	r2, [r3, #76]
	str	r2, [r3, #80]
	str	r2, [r3, #84]
	ldr	r2, [r4, #124]
	str	r2, [r3, #96]
	ldr	r2, [r4, #128]
	str	r2, [r3, #100]
	ldr	r2, [r4, #132]
	str	r2, [r3, #104]
	ldr	r2, [r4, #136]
	str	r2, [r3, #108]
	ldr	r2, [r4, #144]
	str	r2, [r3, #116]
	ldr	r2, [r4, #148]
	str	r2, [r3, #120]
	ldr	r2, [r4, #152]
	str	r2, [r3, #124]
	ldr	r2, [r4, #156]
	str	r2, [r3, #128]
	ldr	r2, [r4, #160]
	str	r2, [r3, #132]
	ldr	r2, [r4, #164]
	str	r2, [r3, #148]
	ldr	r2, [r4, #168]
	str	r2, [r3, #152]
	ldr	r2, [r4, #172]
	str	r2, [r3, #156]
.L32:
	ldr	r0, [r4, #20]
	bl	VDEC_Set_ClockSkip
	ldr	r3, .L36+8
	ldr	r1, [r4, #16]
	ldr	r0, [r6]
	ldr	r2, [r3]
	add	r0, r0, #12
	ldr	r3, [r2, #120]
	bfi	r3, r1, #8, #2
	str	r3, [r2, #120]
	ldr	r1, [r4, #68]
	bl	MEM_WritePhyWord
	cmp	r5, #0
	bne	.L33
	ldr	r6, .L36+4
	mov	r0, #30
	ldr	r1, [r4, #112]
	ldr	r7, .L36+12
	ldr	r3, [r6]
	add	r2, r3, #61440
	str	r1, [r3, #32]
	ldr	r1, [r4, #116]
	str	r1, [r3, #36]
	ldr	r1, [r4, #176]
	ldr	r3, [r7, #112]
	str	r1, [r2, #32]
	blx	r3
	ldr	r3, [r7, #108]
	blx	r3
	ldr	r3, [r6]
	mov	r2, #1
	str	r5, [r3]
	ldr	r3, [r6]
	str	r2, [r3]
	ldr	r3, [r6]
	str	r5, [r3]
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L35:
	bl	MEM_ReadPhyWord
	uxth	r1, r0
	b	.L30
.L33:
	mov	r4, #1
	mov	r3, r5
	ldr	r6, .L36+12
	mov	r0, #32
	str	r4, [sp]
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r4, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	mov	r3, r5
	str	r4, [sp]
	mov	r0, #32
	bl	dprint_vfmw
	ldr	r3, [r6, #112]
	mov	r0, #30
	blx	r3
	ldr	r3, [r6, #108]
	blx	r3
	mov	r3, r5
	str	r4, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r4, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	str	r4, [sp]
	mov	r3, r5
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	mov	r0, #32
	bl	dprint_vfmw
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L31:
	mov	r7, #1
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	str	r7, [sp]
	mov	r3, r5
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	mov	r0, #32
	bl	dprint_vfmw
	b	.L32
.L27:
	mov	r7, #1
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	mov	r3, r5
	str	r7, [sp]
	mov	r0, #32
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	bl	dprint_vfmw
	str	r7, [sp]
	mov	r3, r5
	ldr	r2, .L36+16
	ldr	r1, .L36+20
	mov	r0, #32
	bl	dprint_vfmw
	b	.L28
.L34:
	str	r6, [sp]
	mov	r3, r5
	ldr	r2, .L36+16
	ldr	r1, .L36+24
	bl	dprint_vfmw
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L37:
	.align	2
.L36:
	.word	s_ScdRegPhyBaseAddr
	.word	g_HwMem
	.word	g_pstRegCrg
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0+24
	.word	.LC2
	.word	.LC1
	.fnend
	.size	VDH_Start_Mfde_Decode, .-VDH_Start_Mfde_Decode
	.align	2
	.global	VDH_Init_Module
	.type	VDH_Init_Module, %function
VDH_Init_Module:
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
	bl	VDH_Reset_Global
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VDH_Init_Module, .-VDH_Init_Module
	.align	2
	.global	VDH_Start_Mfde_Module
	.type	VDH_Start_Mfde_Module, %function
VDH_Start_Mfde_Module:
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
	ldrb	r3, [r0, #2]
	cmp	r3, #1
	beq	.L42
	bl	VDH_Start_Mfde_Decode
	ldmfd	sp, {fp, sp, pc}
.L42:
	bl	VDH_Start_Mfde_Repair
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VDH_Start_Mfde_Module, .-VDH_Start_Mfde_Module
	.align	2
	.global	VDH_Start_Scd_Module
	.type	VDH_Start_Scd_Module, %function
VDH_Start_Scd_Module:
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
	mov	r0, #49152
	ldrb	r4, [r5]
	movt	r0, 63683
	bl	MEM_Phy2Vir
	cmp	r0, #0
	beq	.L50
	ldr	r6, .L52
	mov	r0, r4
	bl	ResetSCD
	ldr	r1, [r5, #24]
	ldr	r0, [r6, r4, asl #2]
	add	r0, r0, #2048
	add	r0, r0, #4
	bl	MEM_WritePhyWord
	ldr	r0, [r6, r4, asl #2]
	ldr	r1, [r5, #28]
	add	r0, r0, #2048
	add	r0, r0, #8
	bl	MEM_WritePhyWord
	ldr	r0, [r6, r4, asl #2]
	ldr	r1, [r5, #32]
	add	r0, r0, #2048
	add	r0, r0, #12
	bl	MEM_WritePhyWord
	ldr	r0, [r6, r4, asl #2]
	ldr	r1, [r5, #36]
	add	r0, r0, #2064
	bl	MEM_WritePhyWord
	ldr	r0, [r6, r4, asl #2]
	ldr	r1, [r5, #40]
	add	r0, r0, #2064
	add	r0, r0, #4
	bl	MEM_WritePhyWord
	ldr	r0, [r6, r4, asl #2]
	ldr	r1, [r5, #44]
	add	r0, r0, #2064
	add	r0, r0, #8
	bl	MEM_WritePhyWord
	ldr	r0, [r6, r4, asl #2]
	ldr	r1, [r5, #52]
	add	r0, r0, #2080
	bl	MEM_WritePhyWord
	ldrb	r3, [r5, #1]
	cmp	r3, #0
	bne	.L51
.L46:
	ldr	r0, [r6, r4, asl #2]
	ldr	r1, [r5, #72]
	add	r0, r0, #2080
	add	r0, r0, #8
	bl	MEM_WritePhyWord
	ldr	r0, [r6, r4, asl #2]
	ldr	r1, [r5, #76]
	add	r0, r0, #2080
	add	r0, r0, #12
	bl	MEM_WritePhyWord
	ldr	r0, [r6, r4, asl #2]
	ldr	r1, [r5, #80]
	add	r0, r0, #2096
	bl	MEM_WritePhyWord
	ldr	r0, [r6, r4, asl #2]
	ldr	r1, [r5, #84]
	add	r0, r0, #2096
	add	r0, r0, #4
	bl	MEM_WritePhyWord
	ldr	r0, [r6, r4, asl #2]
	ldr	r1, [r5, #88]
	add	r0, r0, #2096
	add	r0, r0, #8
	bl	MEM_WritePhyWord
	ldr	r0, [r6, r4, asl #2]
	ldr	r1, [r5, #48]
	add	r0, r0, #2064
	add	r0, r0, #12
	bl	MEM_WritePhyWord
	ldr	r0, [r6, r4, asl #2]
	mov	r1, #0
	add	r0, r0, #2048
	bl	MEM_WritePhyWord
	ldr	r0, [r6, r4, asl #2]
	mov	r1, #1
	add	r0, r0, #2048
	bl	MEM_WritePhyWord
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L51:
	ldr	r1, [r5, #56]
	ldr	r0, [r6, r4, asl #2]
	bl	MEM_WritePhyWord
	b	.L46
.L50:
	mov	r3, #49152
	ldr	r2, .L52+4
	movt	r3, 63683
	ldr	r1, .L52+8
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L53:
	.align	2
.L52:
	.word	s_ScdRegPhyBaseAddr
	.word	.LANCHOR0+48
	.word	.LC3
	.fnend
	.size	VDH_Start_Scd_Module, .-VDH_Start_Scd_Module
	.align	2
	.global	VDH_Record_CrgRegData
	.type	VDH_Record_CrgRegData, %function
VDH_Record_CrgRegData:
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
	streq	r2, [r0]
	ldmeqfd	sp, {fp, sp, pc}
	cmp	r1, #1
	streq	r2, [r0, #4]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VDH_Record_CrgRegData, .-VDH_Record_CrgRegData
	.align	2
	.global	VDH_Record_ScdRegData
	.type	VDH_Record_ScdRegData, %function
VDH_Record_ScdRegData:
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
	movw	r3, #2068
	cmp	r1, r3
	beq	.L59
	bls	.L87
	movw	r3, #2088
	cmp	r1, r3
	beq	.L71
	bls	.L88
	cmp	r1, #2096
	streq	r2, [r0, #56]
	ldmeqfd	sp, {fp, sp, pc}
	bls	.L89
	movw	r3, #2100
	cmp	r1, r3
	streq	r2, [r0, #60]
	ldmeqfd	sp, {fp, sp, pc}
	movw	r3, #2104
	cmp	r1, r3
	bne	.L90
	str	r2, [r0, #64]
	ldmfd	sp, {fp, sp, pc}
.L87:
	cmp	r1, #12
	beq	.L61
	bls	.L91
	movw	r3, #2056
	cmp	r1, r3
	streq	r2, [r0, #4]
	ldmeqfd	sp, {fp, sp, pc}
	bls	.L92
	movw	r3, #2060
	cmp	r1, r3
	streq	r2, [r0, #8]
	ldmeqfd	sp, {fp, sp, pc}
	cmp	r1, #2064
	bne	.L93
	str	r2, [r0, #12]
	ldmfd	sp, {fp, sp, pc}
.L88:
	movw	r3, #2076
	cmp	r1, r3
	streq	r2, [r0, #24]
	ldmeqfd	sp, {fp, sp, pc}
	cmp	r1, #2080
	streq	r2, [r0, #28]
	ldmeqfd	sp, {fp, sp, pc}
	movw	r3, #2072
	cmp	r1, r3
	streq	r2, [r0, #20]
	ldmfd	sp, {fp, sp, pc}
.L91:
	cmp	r1, #4
	streq	r2, [r0, #36]
	ldmeqfd	sp, {fp, sp, pc}
	cmp	r1, #8
	streq	r2, [r0, #40]
	ldmeqfd	sp, {fp, sp, pc}
	cmp	r1, #0
	streq	r2, [r0, #32]
	ldmfd	sp, {fp, sp, pc}
.L89:
	movw	r3, #2092
	cmp	r1, r3
	bne	.L94
	str	r2, [r0, #52]
	ldmfd	sp, {fp, sp, pc}
.L92:
	movw	r3, #2052
	cmp	r1, r3
	bne	.L95
	str	r2, [r0]
	ldmfd	sp, {fp, sp, pc}
.L71:
	str	r2, [r0, #48]
	ldmfd	sp, {fp, sp, pc}
.L61:
	str	r2, [r0, #44]
	ldmfd	sp, {fp, sp, pc}
.L59:
	str	r2, [r0, #16]
	ldmfd	sp, {fp, sp, pc}
.L90:
	ldmfd	sp, {fp, sp, pc}
.L95:
	ldmfd	sp, {fp, sp, pc}
.L94:
	ldmfd	sp, {fp, sp, pc}
.L93:
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VDH_Record_ScdRegData, .-VDH_Record_ScdRegData
	.align	2
	.global	VDH_Record_MfdeRegData
	.type	VDH_Record_MfdeRegData, %function
VDH_Record_MfdeRegData:
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
	cmp	r1, #104
	beq	.L98
	bls	.L135
	cmp	r1, #128
	beq	.L113
	bhi	.L114
	cmp	r1, #116
	streq	r2, [r0, #52]
	ldmeqfd	sp, {fp, sp, pc}
	bhi	.L116
	cmp	r1, #108
	streq	r2, [r0, #44]
	ldmeqfd	sp, {fp, sp, pc}
	cmp	r1, #112
	bne	.L136
	str	r2, [r0, #48]
	ldmfd	sp, {fp, sp, pc}
.L135:
	cmp	r1, #24
	beq	.L100
	bls	.L137
	cmp	r1, #92
	streq	r2, [r0, #28]
	ldmeqfd	sp, {fp, sp, pc}
	bhi	.L108
	cmp	r1, #32
	streq	r2, [r0, #20]
	ldmeqfd	sp, {fp, sp, pc}
	cmp	r1, #36
	bne	.L138
	str	r2, [r0, #24]
	ldmfd	sp, {fp, sp, pc}
.L114:
	cmp	r1, #152
	streq	r2, [r0, #76]
	ldmeqfd	sp, {fp, sp, pc}
	bhi	.L122
	cmp	r1, #132
	streq	r2, [r0, #68]
	ldmeqfd	sp, {fp, sp, pc}
	cmp	r1, #148
	bne	.L139
	str	r2, [r0, #72]
	ldmfd	sp, {fp, sp, pc}
.L137:
	cmp	r1, #12
	streq	r2, [r0, #4]
	ldmeqfd	sp, {fp, sp, pc}
	bls	.L140
	cmp	r1, #16
	streq	r2, [r0, #8]
	ldmeqfd	sp, {fp, sp, pc}
	cmp	r1, #20
	bne	.L141
	str	r2, [r0, #12]
	ldmfd	sp, {fp, sp, pc}
.L122:
	cmp	r1, #156
	streq	r2, [r0, #80]
	ldmeqfd	sp, {fp, sp, pc}
	movw	r3, #61472
	cmp	r1, r3
	bne	.L142
	str	r2, [r0, #84]
	ldmfd	sp, {fp, sp, pc}
.L108:
	cmp	r1, #96
	streq	r2, [r0, #32]
	ldmeqfd	sp, {fp, sp, pc}
	cmp	r1, #100
	bne	.L143
	str	r2, [r0, #36]
	ldmfd	sp, {fp, sp, pc}
.L116:
	cmp	r1, #120
	streq	r2, [r0, #56]
	ldmeqfd	sp, {fp, sp, pc}
	cmp	r1, #124
	bne	.L144
	str	r2, [r0, #60]
	ldmfd	sp, {fp, sp, pc}
.L113:
	str	r2, [r0, #64]
	ldmfd	sp, {fp, sp, pc}
.L140:
	cmp	r1, #8
	bne	.L145
	str	r2, [r0]
	ldmfd	sp, {fp, sp, pc}
.L100:
	str	r2, [r0, #16]
	ldmfd	sp, {fp, sp, pc}
.L98:
	str	r2, [r0, #40]
	ldmfd	sp, {fp, sp, pc}
.L142:
	ldmfd	sp, {fp, sp, pc}
.L136:
	ldmfd	sp, {fp, sp, pc}
.L139:
	ldmfd	sp, {fp, sp, pc}
.L138:
	ldmfd	sp, {fp, sp, pc}
.L141:
	ldmfd	sp, {fp, sp, pc}
.L143:
	ldmfd	sp, {fp, sp, pc}
.L144:
	ldmfd	sp, {fp, sp, pc}
.L145:
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VDH_Record_MfdeRegData, .-VDH_Record_MfdeRegData
	.align	2
	.global	VDH_Init_Hardware
	.type	VDH_Init_Hardware, %function
VDH_Init_Hardware:
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
	ldr	r4, .L151
	ldr	r3, [r4, #60]
	cmp	r3, #0
	beq	.L147
	mov	r0, #0
	blx	r3
.L148:
	ldr	r0, [r4, #64]
	cmp	r0, #0
	beq	.L149
	blx	r0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L149:
	movw	r2, #473
	ldr	r1, .L151+4
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L147:
	mov	r0, r3
	mov	r2, #472
	ldr	r1, .L151+4
	bl	dprint_vfmw
	b	.L148
.L152:
	.align	2
.L151:
	.word	g_vdm_hal_fun_ptr
	.word	.LC0
	.fnend
	.size	VDH_Init_Hardware, .-VDH_Init_Hardware
	.align	2
	.global	VDH_Enable_Scd_Module
	.type	VDH_Enable_Scd_Module, %function
VDH_Enable_Scd_Module:
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
	ldr	r3, .L156
	ldr	r3, [r3, #16]
	cmp	r3, #0
	beq	.L154
	blx	r3
	ldmfd	sp, {fp, sp, pc}
.L154:
	mov	r0, r3
	movw	r2, #485
	ldr	r1, .L156+4
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L157:
	.align	2
.L156:
	.word	g_vdm_hal_fun_ptr
	.word	.LC0
	.fnend
	.size	VDH_Enable_Scd_Module, .-VDH_Enable_Scd_Module
	.align	2
	.global	VDH_Disable_Scd_Module
	.type	VDH_Disable_Scd_Module, %function
VDH_Disable_Scd_Module:
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
	ldr	r3, .L161
	ldr	r3, [r3, #20]
	cmp	r3, #0
	beq	.L159
	blx	r3
	ldmfd	sp, {fp, sp, pc}
.L159:
	mov	r0, r3
	mov	r2, #496
	ldr	r1, .L161+4
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L162:
	.align	2
.L161:
	.word	g_vdm_hal_fun_ptr
	.word	.LC0
	.fnend
	.size	VDH_Disable_Scd_Module, .-VDH_Disable_Scd_Module
	.align	2
	.global	VDH_Reset_Scd_Module
	.type	VDH_Reset_Scd_Module, %function
VDH_Reset_Scd_Module:
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
	bl	ResetSCD
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VDH_Reset_Scd_Module, .-VDH_Reset_Scd_Module
	.align	2
	.global	VDH_Enable_Mfde_Module
	.type	VDH_Enable_Mfde_Module, %function
VDH_Enable_Mfde_Module:
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
	ldr	r3, .L167
	ldr	r3, [r3]
	cmp	r3, #0
	beq	.L165
	blx	r3
	ldmfd	sp, {fp, sp, pc}
.L165:
	mov	r0, r3
	movw	r2, #517
	ldr	r1, .L167+4
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L168:
	.align	2
.L167:
	.word	g_vdm_hal_fun_ptr
	.word	.LC0
	.fnend
	.size	VDH_Enable_Mfde_Module, .-VDH_Enable_Mfde_Module
	.align	2
	.global	VDH_Disable_Mfde_Module
	.type	VDH_Disable_Mfde_Module, %function
VDH_Disable_Mfde_Module:
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
	ldr	r3, .L172
	ldr	r3, [r3, #4]
	cmp	r3, #0
	beq	.L170
	blx	r3
	ldmfd	sp, {fp, sp, pc}
.L170:
	mov	r0, r3
	movw	r2, #527
	ldr	r1, .L172+4
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L173:
	.align	2
.L172:
	.word	g_vdm_hal_fun_ptr
	.word	.LC0
	.fnend
	.size	VDH_Disable_Mfde_Module, .-VDH_Disable_Mfde_Module
	.align	2
	.global	VDH_Reset_Mfde_Module
	.type	VDH_Reset_Mfde_Module, %function
VDH_Reset_Mfde_Module:
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
	ldr	r3, .L177
	ldr	r3, [r3, #68]
	cmp	r3, #0
	beq	.L175
	blx	r3
	ldmfd	sp, {fp, sp, pc}
.L175:
	mov	r0, r3
	movw	r2, #537
	ldr	r1, .L177+4
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L178:
	.align	2
.L177:
	.word	g_vdm_hal_fun_ptr
	.word	.LC0
	.fnend
	.size	VDH_Reset_Mfde_Module, .-VDH_Reset_Mfde_Module
	.align	2
	.global	VDH_Enable_Bpd_Module
	.type	VDH_Enable_Bpd_Module, %function
VDH_Enable_Bpd_Module:
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
	ldr	r3, .L184
	ldr	r3, [r3, #24]
	cmp	r3, #0
	ldmeqfd	sp, {fp, sp, pc}
	blx	r3
	ldmfd	sp, {fp, sp, pc}
.L185:
	.align	2
.L184:
	.word	g_vdm_hal_fun_ptr
	.fnend
	.size	VDH_Enable_Bpd_Module, .-VDH_Enable_Bpd_Module
	.align	2
	.global	VDH_Disable_Bpd_Module
	.type	VDH_Disable_Bpd_Module, %function
VDH_Disable_Bpd_Module:
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
	ldr	r3, .L191
	ldr	r3, [r3, #28]
	cmp	r3, #0
	ldmeqfd	sp, {fp, sp, pc}
	blx	r3
	ldmfd	sp, {fp, sp, pc}
.L192:
	.align	2
.L191:
	.word	g_vdm_hal_fun_ptr
	.fnend
	.size	VDH_Disable_Bpd_Module, .-VDH_Disable_Bpd_Module
	.align	2
	.global	VDH_Enable_Dsp_Module
	.type	VDH_Enable_Dsp_Module, %function
VDH_Enable_Dsp_Module:
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
	ldr	r3, .L196
	ldr	r3, [r3, #8]
	cmp	r3, #0
	beq	.L194
	blx	r3
	ldmfd	sp, {fp, sp, pc}
.L194:
	mov	r0, r3
	movw	r2, #567
	ldr	r1, .L196+4
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L197:
	.align	2
.L196:
	.word	g_vdm_hal_fun_ptr
	.word	.LC0
	.fnend
	.size	VDH_Enable_Dsp_Module, .-VDH_Enable_Dsp_Module
	.align	2
	.global	VDH_Disable_Dsp_Module
	.type	VDH_Disable_Dsp_Module, %function
VDH_Disable_Dsp_Module:
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
	ldr	r3, .L201
	ldr	r3, [r3, #12]
	cmp	r3, #0
	beq	.L199
	blx	r3
	ldmfd	sp, {fp, sp, pc}
.L199:
	mov	r0, r3
	movw	r2, #577
	ldr	r1, .L201+4
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L202:
	.align	2
.L201:
	.word	g_vdm_hal_fun_ptr
	.word	.LC0
	.fnend
	.size	VDH_Disable_Dsp_Module, .-VDH_Disable_Dsp_Module
	.align	2
	.global	VDH_Load_Dsp_Code
	.type	VDH_Load_Dsp_Code, %function
VDH_Load_Dsp_Code:
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
	bl	SCDDRV_LoadDspCode
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	VDH_Load_Dsp_Code, .-VDH_Load_Dsp_Code
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	__func__.48232, %object
	.size	__func__.48232, 22
__func__.48232:
	.ascii	"VDH_Start_Mfde_Repair\000"
	.space	2
	.type	__func__.48240, %object
	.size	__func__.48240, 22
__func__.48240:
	.ascii	"VDH_Start_Mfde_Decode\000"
	.space	2
	.type	__func__.48252, %object
	.size	__func__.48252, 21
__func__.48252:
	.ascii	"VDH_Start_Scd_Module\000"
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"VDMHAL_NULL_FUN_PRINT,L%d\012\000"
	.space	1
.LC1:
	.ascii	"%s: map mfde %d register 0x%x failed!\012\000"
	.space	1
.LC2:
	.ascii	"%s: WR_VREG but VdhId(%d) > MAX_VDH_NUM(%d)\012\000"
	.space	3
.LC3:
	.ascii	"%s: map scd register 0x%x failed!\012\000"
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
