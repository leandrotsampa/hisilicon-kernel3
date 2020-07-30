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
	.file	"mvc.c"

	.text
	.align	2
	.global	MVC_IsSTRefFlg
	.type	MVC_IsSTRefFlg, %function
MVC_IsSTRefFlg:
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
	ldr	r0, [r0]
	bic	r0, r0, #-16777216
	bic	r0, r0, #255
	sub	r0, r0, #65536
	clz	r0, r0
	mov	r0, r0, lsr #5
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_IsSTRefFlg, .-MVC_IsSTRefFlg
	.align	2
	.global	MVC_IsLTRefFlg
	.type	MVC_IsLTRefFlg, %function
MVC_IsLTRefFlg:
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
	ldr	r0, [r0]
	bic	r0, r0, #-16777216
	bic	r0, r0, #255
	sub	r0, r0, #256
	clz	r0, r0
	mov	r0, r0, lsr #5
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_IsLTRefFlg, .-MVC_IsLTRefFlg
	.align	2
	.global	MVC_compare_pic_by_pic_num_desc
	.type	MVC_compare_pic_by_pic_num_desc, %function
MVC_compare_pic_by_pic_num_desc:
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
	ldr	r2, [r0]
	ldr	r3, [r1]
	ldr	r2, [r2, #12]
	ldr	r3, [r3, #12]
	cmp	r2, r3
	blt	.L5
	mvngt	r0, #0
	movle	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L5:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_compare_pic_by_pic_num_desc, .-MVC_compare_pic_by_pic_num_desc
	.align	2
	.global	MVC_compare_pic_by_lt_pic_num_asc
	.type	MVC_compare_pic_by_lt_pic_num_asc, %function
MVC_compare_pic_by_lt_pic_num_asc:
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
	ldr	r2, [r0]
	ldr	r3, [r1]
	ldr	r2, [r2, #8]
	ldr	r3, [r3, #8]
	cmp	r2, r3
	blt	.L9
	movgt	r0, #1
	movle	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L9:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_compare_pic_by_lt_pic_num_asc, .-MVC_compare_pic_by_lt_pic_num_asc
	.align	2
	.global	MVC_compare_fs_by_frame_num_desc
	.type	MVC_compare_fs_by_frame_num_desc, %function
MVC_compare_fs_by_frame_num_desc:
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
	ldr	r2, [r0]
	ldr	r3, [r1]
	ldr	r2, [r2, #24]
	ldr	r3, [r3, #24]
	cmp	r2, r3
	blt	.L12
	mvngt	r0, #0
	movle	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L12:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_compare_fs_by_frame_num_desc, .-MVC_compare_fs_by_frame_num_desc
	.align	2
	.global	MVC_compare_fs_by_lt_pic_idx_asc
	.type	MVC_compare_fs_by_lt_pic_idx_asc, %function
MVC_compare_fs_by_lt_pic_idx_asc:
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
	ldr	r2, [r0]
	ldr	r3, [r1]
	ldr	r2, [r2, #28]
	ldr	r3, [r3, #28]
	cmp	r2, r3
	bcc	.L15
	movhi	r0, #1
	movls	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L15:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_compare_fs_by_lt_pic_idx_asc, .-MVC_compare_fs_by_lt_pic_idx_asc
	.align	2
	.global	MVC_compare_pic_by_poc_asc
	.type	MVC_compare_pic_by_poc_asc, %function
MVC_compare_pic_by_poc_asc:
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
	ldr	r2, [r0]
	ldr	r3, [r1]
	ldr	r2, [r2, #16]
	ldr	r3, [r3, #16]
	cmp	r2, r3
	blt	.L18
	movgt	r0, #1
	movle	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L18:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_compare_pic_by_poc_asc, .-MVC_compare_pic_by_poc_asc
	.align	2
	.global	MVC_compare_pic_by_poc_desc
	.type	MVC_compare_pic_by_poc_desc, %function
MVC_compare_pic_by_poc_desc:
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
	ldr	r2, [r0]
	ldr	r3, [r1]
	ldr	r2, [r2, #16]
	ldr	r3, [r3, #16]
	cmp	r2, r3
	blt	.L21
	mvngt	r0, #0
	movle	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L21:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_compare_pic_by_poc_desc, .-MVC_compare_pic_by_poc_desc
	.align	2
	.global	MVC_compare_fs_by_poc_asc
	.type	MVC_compare_fs_by_poc_asc, %function
MVC_compare_fs_by_poc_asc:
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
	ldr	r2, [r0]
	ldr	r3, [r1]
	ldr	r2, [r2, #32]
	ldr	r3, [r3, #32]
	cmp	r2, r3
	blt	.L24
	movgt	r0, #1
	movle	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L24:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_compare_fs_by_poc_asc, .-MVC_compare_fs_by_poc_asc
	.align	2
	.global	MVC_compare_fs_by_poc_desc
	.type	MVC_compare_fs_by_poc_desc, %function
MVC_compare_fs_by_poc_desc:
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
	ldr	r2, [r0]
	ldr	r3, [r1]
	ldr	r2, [r2, #32]
	ldr	r3, [r3, #32]
	cmp	r2, r3
	blt	.L27
	mvngt	r0, #0
	movle	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L27:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_compare_fs_by_poc_desc, .-MVC_compare_fs_by_poc_desc
	.align	2
	.type	MVC_SetFrmRepeatCount.part.1, %function
MVC_SetFrmRepeatCount.part.1:
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
	add	ip, r0, #11075584
	add	ip, ip, #45056
	ldr	lr, [r0, #136]
	ldr	r3, [r0, #132]
	ldr	r2, [ip, #2728]
	add	r2, r2, lr, lsr #1
	mov	r3, r3, lsr #1
	add	ip, r2, #1
	cmp	r3, ip
	movcc	r3, #0
	strcc	r3, [r1, #24]
	ldmccfd	sp, {fp, sp, pc}
	sub	r3, r3, #1
	rsb	r3, r2, r3
	cmp	r3, #1
	movhi	r3, #2
	movls	r3, #1
	strhi	r3, [r1, #24]
	strls	r3, [r1, #24]
	ldrhi	r3, [r0, #136]
	ldrls	r3, [r0, #136]
	addhi	r3, r3, #4
	addls	r3, r3, #2
	str	r3, [r0, #136]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_SetFrmRepeatCount.part.1, .-MVC_SetFrmRepeatCount.part.1
	.align	2
	.type	MVC_CombinePacket.part.12, %function
MVC_CombinePacket.part.12:
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
	ldr	r1, .L33
	mov	r4, r0
	mov	r0, #7
	mov	r5, #0
	bl	dprint_vfmw
	ldr	ip, [r4, #232]
	ldr	r1, .L33+4
	mov	r0, #7
	ldr	lr, [ip, #40]
	ldr	r3, [ip, #44]
	ldr	r2, [ip, #16]
	str	lr, [sp, #4]
	ldr	ip, [ip, #12]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [r4, #232]
	ldr	ip, .L33+8
	ldr	r2, [r3, #12]
	ldr	r0, [r3, #36]
	ldr	r1, [r3, #8]
	rsb	r0, r2, r0
	ldr	r3, [ip, #52]
	blx	r3
	ldr	r3, [r4, #232]
	mov	ip, #1
	ldr	r1, .L33+12
	mov	r0, #7
	ldr	r2, [r3, #60]
	ldr	r6, [r3, #32]
	str	r2, [r3, #32]
	ldr	r3, [r4, #232]
	str	r5, [r3, #24]
	ldr	r3, [r4, #232]
	ldr	lr, [r3, #12]
	ldr	r2, [r3, #36]
	rsb	r2, lr, r2
	str	r2, [r3, #8]
	ldr	r3, [r4, #232]
	ldr	lr, [r3, #12]
	ldr	r2, [r3, #44]
	rsb	r2, lr, r2
	str	r2, [r3, #16]
	ldr	r3, [r4, #232]
	ldr	lr, [r3, #40]
	ldr	r2, [r3, #12]
	add	r2, r2, lr
	str	r2, [r3, #12]
	ldr	r3, [r4, #232]
	str	ip, [r3, #68]
	ldr	r2, [r4, #232]
	ldr	r3, [r2, #12]
	ldr	r2, [r2, #16]
	bl	dprint_vfmw
	mov	r1, r6
	ldr	r0, [r4, #120]
	bl	SM_ReleaseStreamSeg
	ldr	r3, [r4, #232]
	str	r5, [r3, #36]
	ldr	r3, [r4, #232]
	str	r5, [r3, #52]
	ldr	r3, [r4, #232]
	str	r5, [r3, #40]
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L34:
	.align	2
.L33:
	.word	.LC0
	.word	.LC1
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC2
	.fnend
	.size	MVC_CombinePacket.part.12, .-MVC_CombinePacket.part.12
	.align	2
	.global	mvc_ue_v
	.type	mvc_ue_v, %function
mvc_ue_v:
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
	add	r8, r0, #548
	mov	r6, r0
	mov	r7, r1
	mov	r0, r8
	mov	r1, #32
	bl	BsShow
	mov	r5, r0
	bl	ZerosMS_32
	cmp	r0, #15
	mov	r4, r0
	bls	.L39
	cmp	r0, #31
	bls	.L40
	mvn	r5, #0
	mov	r8, #32
	mov	r3, #1
	strb	r3, [r6, #10]
.L37:
	ldr	r6, [r6, #232]
	mov	r2, r7
	mov	r3, r5
	ldr	r1, .L41
	mov	r0, #21
	ldr	lr, [r6, #64]
	add	r4, lr, r8
	str	r4, [r6, #64]
	bl	dprint_vfmw
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L39:
	mov	r4, r0, asl #1
	mov	r0, r8
	add	r8, r4, #1
	rsb	r4, r4, #31
	mov	r4, r5, lsr r4
	mov	r1, r8
	sub	r5, r4, #1
	bl	BsSkip
	b	.L37
.L40:
	add	r5, r0, #1
	mov	r1, r0
	mov	r0, r8
	bl	BsSkip
	mov	r1, r5
	mov	r0, r8
	bl	BsShow
	mov	r1, r5
	sub	r5, r0, #1
	mov	r0, r8
	bl	BsSkip
	mov	ip, r4, asl #1
	add	r8, ip, #1
	b	.L37
.L42:
	.align	2
.L41:
	.word	.LC3
	.fnend
	.size	mvc_ue_v, .-mvc_ue_v
	.align	2
	.global	mvc_se_v
	.type	mvc_se_v, %function
mvc_se_v:
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
	add	r7, r0, #548
	mov	r8, r0
	mov	r6, r1
	mov	r0, r7
	mov	r1, #32
	bl	BsShow
	mov	r4, r0
	bl	ZerosMS_32
	cmp	r0, #15
	mov	r5, r0
	bhi	.L44
	mov	r5, r0, asl #1
	mov	r0, r7
	rsb	r3, r5, #31
	add	r5, r5, #1
	mov	r3, r4, lsr r3
	and	r2, r3, #1
	mov	r1, r5
	rsb	r4, r2, #0
	eor	r3, r4, r3, lsr #1
	add	r4, r3, r2
	bl	BsSkip
.L45:
	ldr	lr, [r8, #232]
	mov	r2, r6
	mov	r3, r4
	ldr	r1, .L48
	mov	r0, #21
	ldr	ip, [lr, #64]
	add	r5, ip, r5
	str	r5, [lr, #64]
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L44:
	cmp	r0, #31
	bls	.L47
	mov	r3, #1
	mvn	r4, #-2147483648
	mov	r5, #32
	strb	r3, [r8, #10]
	b	.L45
.L47:
	mov	r1, r0
	mov	r0, r7
	bl	BsSkip
	mov	r1, r5
	mov	r0, r7
	mov	r5, r5, asl #1
	bl	BsGet
	mov	r1, #1
	add	r5, r5, #1
	mov	r9, r0
	mov	r0, r7
	bl	BsGet
	and	r0, r0, #1
	rsb	r4, r0, #0
	eor	r9, r9, r4
	add	r4, r9, r0
	b	.L45
.L49:
	.align	2
.L48:
	.word	.LC3
	.fnend
	.size	mvc_se_v, .-mvc_se_v
	.align	2
	.global	mvc_u_v
	.type	mvc_u_v, %function
mvc_u_v:
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
	add	r0, r0, #548
	mov	r6, r1
	mov	r7, r2
	bl	BsGet
	ldr	lr, [r5, #232]
	mov	r2, r7
	ldr	r1, .L51
	ldr	ip, [lr, #64]
	add	ip, ip, r6
	str	ip, [lr, #64]
	mov	r4, r0
	mov	r3, r0
	mov	r0, #21
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L52:
	.align	2
.L51:
	.word	.LC3
	.fnend
	.size	mvc_u_v, .-mvc_u_v
	.align	2
	.global	mvc_u_1
	.type	mvc_u_1, %function
mvc_u_1:
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
	mov	r6, r1
	add	r0, r0, #548
	mov	r1, #1
	bl	BsGet
	ldr	lr, [r5, #232]
	mov	r2, r6
	ldr	r1, .L54
	ldr	ip, [lr, #64]
	add	ip, ip, #1
	str	ip, [lr, #64]
	mov	r4, r0
	mov	r3, r0
	mov	r0, #21
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L55:
	.align	2
.L54:
	.word	.LC3
	.fnend
	.size	mvc_u_1, .-mvc_u_1
	.align	2
	.global	MVC_GetMinPOC
	.type	MVC_GetMinPOC, %function
MVC_GetMinPOC:
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
	add	r10, r0, #11075584
	mov	r9, r3
	add	r10, r10, #45056
	mov	r8, r2
	mvn	r3, #-2147483648
	mvn	r2, #0
	str	r2, [r9]
	mov	r6, r0
	str	r3, [r8]
	mov	r7, r1
	ldr	r3, [r10, #2728]
	ldr	r2, [r10, #2732]
	cmp	r2, r3
	strhi	r3, [r10, #2732]
	cmp	r3, #0
	beq	.L63
	movw	r5, #47588
	mvn	r3, #0
	movt	r5, 169
	str	r3, [fp, #-48]
	add	r5, r0, r5
	mov	r4, #0
	b	.L62
.L60:
	ldr	r1, [r8]
	ldr	r2, [r3, #32]
	cmp	r1, r2
	ble	.L59
	ldrb	r1, [r3, #5]
	cmp	r1, #0
	beq	.L59
	ldrb	r1, [r0, #1]
	sub	r1, r1, #1
	cmp	r1, #1
	bls	.L78
.L59:
	ldr	r3, [r10, #2728]
	add	r4, r4, #1
	cmp	r3, r4
	bls	.L63
.L62:
	ldr	r3, [r5, #4]!
	cmp	r3, #0
	beq	.L59
	ldrsb	r1, [r3, #6]
	ldr	r0, [r6, #120]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	beq	.L59
	cmn	r7, #1
	ldr	r3, [r5]
	bne	.L60
	ldrb	r2, [r3, #5]
	cmp	r2, #0
	beq	.L59
	ldrb	r2, [r0, #1]
	sub	r2, r2, #1
	cmp	r2, #1
	bhi	.L59
	ldr	r1, [r8]
	ldr	r2, [r3, #32]
	cmp	r1, r2
	ble	.L61
	str	r2, [r8]
	str	r4, [r9]
	add	r4, r4, #1
	ldr	r3, [r5]
	ldr	r3, [r3, #56]
	str	r3, [fp, #-48]
	ldr	r3, [r10, #2728]
	cmp	r3, r4
	bhi	.L62
.L63:
	ldr	r0, [r9]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L78:
	ldr	r3, [r3, #56]
	cmp	r7, r3
	streq	r2, [r8]
	streq	r4, [r9]
	b	.L59
.L61:
	bne	.L59
	ldr	r3, [r3, #56]
	ldr	r2, [fp, #-48]
	cmp	r3, r2
	strlt	r4, [r9]
	ldrlt	r3, [r5]
	ldrlt	r3, [r3, #56]
	strlt	r3, [fp, #-48]
	b	.L59
	.fnend
	.size	MVC_GetMinPOC, .-MVC_GetMinPOC
	.align	2
	.global	MVC_FrameStoreRefFlg
	.type	MVC_FrameStoreRefFlg, %function
MVC_FrameStoreRefFlg:
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
	ldrb	r0, [r0, #3]
	adds	r0, r0, #0
	movne	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_FrameStoreRefFlg, .-MVC_FrameStoreRefFlg
	.align	2
	.global	MVC_NonLongTermRefFlg
	.type	MVC_NonLongTermRefFlg, %function
MVC_NonLongTermRefFlg:
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
	ldrb	r3, [r0, #3]
	cmp	r3, #3
	beq	.L95
	tst	r3, #1
	bne	.L96
.L84:
	and	r3, r3, #2
	ands	r3, r3, #255
	beq	.L88
.L85:
	ldrb	r0, [r0, #737]
	clz	r0, r0
	mov	r0, r0, lsr #5
	ldmfd	sp, {fp, sp, pc}
.L88:
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L96:
	ldrb	r2, [r0, #701]
	cmp	r2, #0
	bne	.L84
.L89:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L95:
	ldrb	r3, [r0, #665]
	cmp	r3, #0
	beq	.L89
	ldrb	r3, [r0, #701]
	cmp	r3, #0
	bne	.L85
	b	.L89
	.fnend
	.size	MVC_NonLongTermRefFlg, .-MVC_NonLongTermRefFlg
	.align	2
	.global	MVC_ShortTermRefFlg
	.type	MVC_ShortTermRefFlg, %function
MVC_ShortTermRefFlg:
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
	ldrb	r3, [r0, #3]
	cmp	r3, #3
	beq	.L112
	tst	r3, #1
	bne	.L113
.L101:
	and	r3, r3, #2
	ands	r3, r3, #255
	beq	.L105
.L102:
	ldr	r0, [r0, #736]
	bic	r0, r0, #-16777216
	bic	r0, r0, #255
	sub	r0, r0, #65536
	clz	r0, r0
	mov	r0, r0, lsr #5
	ldmfd	sp, {fp, sp, pc}
.L105:
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L113:
	ldr	r2, [r0, #700]
	bic	r2, r2, #-16777216
	bic	r2, r2, #255
	cmp	r2, #65536
	bne	.L101
.L106:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L112:
	ldr	r3, [r0, #664]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #65536
	beq	.L106
	ldr	r3, [r0, #700]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #65536
	bne	.L102
	b	.L106
	.fnend
	.size	MVC_ShortTermRefFlg, .-MVC_ShortTermRefFlg
	.align	2
	.global	MVC_LongTermRefFlg
	.type	MVC_LongTermRefFlg, %function
MVC_LongTermRefFlg:
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
	ldrb	r3, [r0, #3]
	cmp	r3, #3
	beq	.L129
	tst	r3, #1
	bne	.L130
.L118:
	and	r3, r3, #2
	ands	r3, r3, #255
	beq	.L122
.L119:
	ldr	r0, [r0, #736]
	bic	r0, r0, #-16777216
	bic	r0, r0, #255
	sub	r0, r0, #256
	clz	r0, r0
	mov	r0, r0, lsr #5
	ldmfd	sp, {fp, sp, pc}
.L122:
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L130:
	ldr	r2, [r0, #700]
	bic	r2, r2, #-16777216
	bic	r2, r2, #255
	cmp	r2, #256
	bne	.L118
.L123:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L129:
	ldr	r3, [r0, #664]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #256
	beq	.L123
	ldr	r3, [r0, #700]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #256
	bne	.L119
	b	.L123
	.fnend
	.size	MVC_LongTermRefFlg, .-MVC_LongTermRefFlg
	.align	2
	.global	MVC_UpdateLTReflist
	.type	MVC_UpdateLTReflist, %function
MVC_UpdateLTReflist:
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
	add	r3, r0, #11075584
	mov	r7, r0
	add	r3, r3, #45056
	str	r3, [fp, #-48]
	ldr	r10, [r3, #2728]
	cmp	r10, #0
	beq	.L132
	movw	r8, #47588
	add	r9, r0, #11141120
	movt	r8, 169
	mov	r4, #0
	add	r9, r9, #12288
	add	r8, r0, r8
	mov	r6, r4
.L134:
	ldr	r5, [r8, #4]!
	add	r6, r6, #1
	cmp	r5, #0
	mov	r0, r5
	beq	.L133
	bl	MVC_LongTermRefFlg
	cmp	r0, #0
	beq	.L133
	ldr	r2, [r9, #2056]
	ldr	r1, [r5, #56]
	cmp	r1, r2
	movweq	r2, #28314
	movteq	r2, 42
	addeq	r2, r4, r2
	addeq	r4, r4, #1
	streq	r5, [r7, r2, asl #2]
.L133:
	cmp	r6, r10
	bne	.L134
	ldr	r3, [fp, #-48]
	cmp	r4, r10
	str	r4, [r3, #2740]
	bcs	.L131
	movw	r0, #28313
	mov	r2, #0
	movt	r0, 42
	add	r0, r4, r0
	add	r0, r7, r0, lsl #2
.L137:
	add	r4, r4, #1
	str	r2, [r0, #4]!
	cmp	r4, r10
	bne	.L137
.L131:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L132:
	ldr	r3, [fp, #-48]
	str	r10, [r3, #2740]
	b	.L131
	.fnend
	.size	MVC_UpdateLTReflist, .-MVC_UpdateLTReflist
	.align	2
	.global	MVC_UpdateReflist
	.type	MVC_UpdateReflist, %function
MVC_UpdateReflist:
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
	add	r3, r0, #11075584
	mov	r7, r0
	add	r3, r3, #45056
	str	r3, [fp, #-48]
	ldr	r10, [r3, #2728]
	cmp	r10, #0
	beq	.L148
	movw	r8, #47588
	add	r9, r0, #11141120
	movt	r8, 169
	mov	r4, #0
	add	r9, r9, #12288
	add	r8, r0, r8
	mov	r6, r4
.L150:
	ldr	r5, [r8, #4]!
	add	r6, r6, #1
	cmp	r5, #0
	mov	r0, r5
	beq	.L149
	bl	MVC_ShortTermRefFlg
	cmp	r0, #0
	beq	.L149
	ldr	r2, [r9, #2056]
	ldr	r1, [r5, #56]
	cmp	r1, r2
	movweq	r2, #28298
	movteq	r2, 42
	addeq	r2, r4, r2
	addeq	r4, r4, #1
	streq	r5, [r7, r2, asl #2]
.L149:
	cmp	r6, r10
	bne	.L150
	ldr	r3, [fp, #-48]
	cmp	r4, r10
	str	r4, [r3, #2736]
	bcs	.L147
	movw	r0, #28297
	mov	r2, #0
	movt	r0, 42
	add	r0, r4, r0
	add	r0, r7, r0, lsl #2
.L153:
	add	r4, r4, #1
	str	r2, [r0, #4]!
	cmp	r4, r10
	bne	.L153
.L147:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L148:
	ldr	r3, [fp, #-48]
	str	r10, [r3, #2736]
	b	.L147
	.fnend
	.size	MVC_UpdateReflist, .-MVC_UpdateReflist
	.align	2
	.global	MVC_GetPicNumX
	.type	MVC_GetPicNumX, %function
MVC_GetPicNumX:
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
	ldrb	r3, [r0, #3]
	cmp	r3, #0
	ldr	r3, [r0, #616]
	mvn	r0, r1
	movne	r3, r3, asl #1
	addne	r3, r3, #1
	add	r0, r0, r3
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_GetPicNumX, .-MVC_GetPicNumX
	.align	2
	.global	MVC_UnMarkFrameStoreRef
	.type	MVC_UnMarkFrameStoreRef, %function
MVC_UnMarkFrameStoreRef:
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
	ldrb	r2, [r1, #2]
	mov	r3, r1
	tst	r2, #1
	beq	.L167
	ldrb	r1, [r1, #3]
	mov	ip, #0
	strb	ip, [r3, #701]
	and	r1, r1, #2
	strb	ip, [r3, #702]
	strb	r1, [r3, #3]
.L167:
	tst	r2, #2
	beq	.L168
	ldrb	r1, [r3, #3]
	mov	ip, #0
	strb	ip, [r3, #737]
	and	r1, r1, #1
	strb	ip, [r3, #738]
	strb	r1, [r3, #3]
.L168:
	cmp	r2, #3
	ldrsb	r1, [r3, #6]
	moveq	r2, #0
	streqb	r2, [r3, #666]
	streqb	r2, [r3, #665]
	mov	r2, #0
	strb	r2, [r3, #3]
	ldr	r0, [r0, #120]
	bl	FSP_SetRef
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_UnMarkFrameStoreRef, .-MVC_UnMarkFrameStoreRef
	.align	2
	.global	MVC_UnMarkLTFrmByFrmIdx
	.type	MVC_UnMarkLTFrmByFrmIdx, %function
MVC_UnMarkLTFrmByFrmIdx:
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
	add	r3, r0, #11075584
	add	r3, r3, #45056
	ldr	r4, [r3, #2740]
	cmp	r4, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	movw	ip, #47716
	add	r6, r0, #11141120
	movt	ip, 169
	add	r6, r6, #12288
	add	ip, r0, ip
	mov	r3, #0
	b	.L179
.L178:
	cmp	r3, r4
	beq	.L184
.L179:
	ldr	r2, [ip, #4]!
	add	r3, r3, #1
	ldr	lr, [r2, #28]
	cmp	lr, r1
	bne	.L178
	ldr	r5, [r2, #56]
	ldr	lr, [r6, #2056]
	cmp	r5, lr
	bne	.L178
	mov	r1, r2
	bl	MVC_UnMarkFrameStoreRef
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L184:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	MVC_UnMarkLTFrmByFrmIdx, .-MVC_UnMarkLTFrmByFrmIdx
	.align	2
	.global	MVC_UnMarkLTFldByFrmIdx
	.type	MVC_UnMarkLTFldByFrmIdx, %function
MVC_UnMarkLTFldByFrmIdx:
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
	add	ip, r0, #11075584
	add	ip, ip, #45056
	ldr	r6, [ip, #2740]
	cmp	r6, #0
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	movw	r4, #47716
	add	r8, r0, #11141120
	movt	r4, 169
	add	r8, r8, #12288
	add	r4, r0, r4
	mov	ip, #0
	b	.L189
.L187:
	cmp	ip, r6
	beq	.L203
.L189:
	ldr	lr, [r4, #4]!
	add	ip, ip, #1
	ldr	r5, [lr, #28]
	cmp	r5, r3
	bne	.L187
	ldr	r7, [lr, #56]
	ldr	r5, [r8, #2056]
	cmp	r7, r5
	bne	.L187
	cmp	r2, #1
	ldreqb	r5, [lr, #737]
	beq	.L202
	cmp	r2, #2
	bne	.L187
	ldrb	r5, [lr, #701]
.L202:
	clz	r5, r5
	mov	r5, r5, lsr #5
	cmp	lr, r1
	orrne	r5, r5, #1
	cmp	r5, #0
	beq	.L187
	mov	r1, lr
	bl	MVC_UnMarkFrameStoreRef
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L203:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	MVC_UnMarkLTFldByFrmIdx, .-MVC_UnMarkLTFldByFrmIdx
	.align	2
	.global	MVC_UnMarkSTRef
	.type	MVC_UnMarkSTRef, %function
MVC_UnMarkSTRef:
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
	ldrb	r3, [r1, #3]
	cmp	r3, #0
	bne	.L205
	add	ip, r0, #11075584
	ldr	r1, [r1, #616]
	add	ip, ip, #45056
	sub	r1, r1, #1
	ldr	r4, [ip, #2736]
	rsb	r2, r2, r1
	cmp	r4, #0
	beq	.L233
	movw	ip, #47652
	add	r5, r0, #11141120
	movt	ip, 169
	add	r5, r5, #12288
	add	ip, r0, ip
	b	.L211
.L210:
	cmp	r3, r4
	beq	.L234
.L211:
	ldr	r1, [ip, #4]!
	add	r3, r3, #1
	ldr	lr, [r1, #676]
	cmp	lr, r2
	bne	.L210
	ldrb	lr, [r1, #3]
	cmp	lr, #3
	bne	.L210
	ldr	lr, [r1, #664]
	bic	lr, lr, #-16777216
	bic	lr, lr, #255
	cmp	lr, #65536
	bne	.L210
	ldr	r6, [r1, #56]
	ldr	lr, [r5, #2056]
	cmp	r6, lr
	bne	.L210
	bl	MVC_UnMarkFrameStoreRef
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L205:
	add	r3, r0, #11075584
	ldr	r1, [r1, #616]
	add	r3, r3, #45056
	ldr	r5, [r3, #2736]
	rsb	r2, r2, r1, lsl #1
	cmp	r5, #0
	beq	.L235
	movw	r4, #47652
	add	r7, r0, #11141120
	movt	r4, 169
	add	r7, r7, #12288
	add	r4, r0, r4
	mov	ip, #0
	b	.L216
.L212:
	tst	r3, #2
	beq	.L214
	ldr	r3, [r1, #736]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #65536
	beq	.L236
.L214:
	add	ip, ip, #1
	cmp	ip, r5
	beq	.L237
.L216:
	ldr	r1, [r4, #4]!
	ldrb	r3, [r1, #3]
	ands	r6, r3, #1
	beq	.L212
	ldr	lr, [r1, #700]
	bic	lr, lr, #-16777216
	bic	lr, lr, #255
	cmp	lr, #65536
	bne	.L212
	ldr	r8, [r1, #56]
	ldr	lr, [r7, #2056]
	cmp	r8, lr
	bne	.L212
	ldr	lr, [r1, #712]
	cmp	lr, r2
	bne	.L212
	add	r2, r0, ip, lsl #2
	and	r3, r3, #2
	add	r2, r2, #11075584
	strb	r3, [r1, #3]
	add	r2, r2, #45056
	mov	r1, #0
	ldr	r3, [r2, #2600]
	strb	r1, [r3, #702]
	ldr	r3, [r2, #2600]
	ldrb	ip, [r3, #664]
	cmp	ip, #3
	cmpne	ip, r1
	streqb	r1, [r3, #666]
	ldreq	r3, [r2, #2600]
	streqb	r1, [r3, #665]
	ldreq	r3, [r2, #2600]
	ldrb	ip, [r3, #3]
	cmp	ip, #0
	ldmnefd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	ldr	r1, [r3, #48]
	mov	r2, ip
	add	r1, r0, r1, lsl #2
	str	ip, [r1, #148]
	ldrsb	r1, [r3, #6]
	ldr	r0, [r0, #120]
	bl	FSP_SetRef
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L236:
	ldr	lr, [r1, #56]
	ldr	r3, [r7, #2056]
	cmp	lr, r3
	bne	.L214
	ldr	r3, [r1, #748]
	cmp	r3, r2
	bne	.L214
	add	r3, r0, ip, lsl #2
	strb	r6, [r1, #3]
	add	r3, r3, #11075584
	mov	r2, #0
	add	r3, r3, #45056
	ldr	r1, [r3, #2600]
	strb	r2, [r1, #738]
	ldr	r1, [r3, #2600]
	ldrb	ip, [r1, #664]
	cmp	ip, #3
	cmpne	ip, r2
	streqb	r2, [r1, #666]
	ldreq	r1, [r3, #2600]
	streqb	r2, [r1, #665]
	ldreq	r1, [r3, #2600]
	ldrb	ip, [r1, #3]
	cmp	ip, #0
	ldmnefd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	ldr	r3, [r1, #48]
	mov	r2, ip
	add	r3, r0, r3, lsl #2
	str	ip, [r3, #148]
	ldrsb	r1, [r1, #6]
	ldr	r0, [r0, #120]
	bl	FSP_SetRef
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L237:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L234:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L233:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L235:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	MVC_UnMarkSTRef, .-MVC_UnMarkSTRef
	.align	2
	.global	MVC_UnMarkLTRef
	.type	MVC_UnMarkLTRef, %function
MVC_UnMarkLTRef:
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
	ldrb	r3, [r1, #3]
	cmp	r3, #0
	beq	.L239
	add	r3, r0, #11075584
	add	r3, r3, #45056
	ldr	r5, [r3, #2740]
	cmp	r5, #0
	beq	.L267
	movw	r4, #47716
	add	r7, r0, #11141120
	movt	r4, 169
	add	r7, r7, #12288
	add	r4, r0, r4
	mov	ip, #0
	b	.L248
.L244:
	tst	r3, #2
	beq	.L246
	ldr	r3, [r1, #736]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #256
	beq	.L268
.L246:
	add	ip, ip, #1
	cmp	ip, r5
	beq	.L269
.L248:
	ldr	r1, [r4, #4]!
	ldrb	r3, [r1, #3]
	ands	r6, r3, #1
	beq	.L244
	ldr	lr, [r1, #700]
	bic	lr, lr, #-16777216
	bic	lr, lr, #255
	cmp	lr, #256
	bne	.L244
	ldr	r8, [r1, #56]
	ldr	lr, [r7, #2056]
	cmp	r8, lr
	bne	.L244
	ldr	lr, [r1, #708]
	cmp	r2, lr
	bne	.L244
	add	r2, r0, ip, lsl #2
	and	r3, r3, #2
	add	r2, r2, #11075584
	strb	r3, [r1, #3]
	add	r2, r2, #45056
	mov	r1, #0
	ldr	r3, [r2, #2664]
	strb	r1, [r3, #701]
	ldr	r3, [r2, #2664]
	ldrb	ip, [r3, #664]
	cmp	ip, #3
	cmpne	ip, r1
	streqb	r1, [r3, #666]
	ldreq	r3, [r2, #2664]
	streqb	r1, [r3, #665]
	ldreq	r3, [r2, #2664]
	ldrb	ip, [r3, #3]
	cmp	ip, #0
	ldmnefd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	ldr	r1, [r3, #48]
	mov	r2, ip
	add	r1, r0, r1, lsl #2
	str	ip, [r1, #148]
	ldrsb	r1, [r3, #6]
	ldr	r0, [r0, #120]
	bl	FSP_SetRef
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L239:
	add	r1, r0, #11075584
	add	r1, r1, #45056
	ldr	r4, [r1, #2740]
	cmp	r4, #0
	beq	.L270
	movw	ip, #47716
	add	r5, r0, #11141120
	movt	ip, 169
	add	r5, r5, #12288
	add	ip, r0, ip
	b	.L250
.L249:
	cmp	r3, r4
	beq	.L271
.L250:
	ldr	r1, [ip, #4]!
	add	r3, r3, #1
	ldr	lr, [r1, #672]
	cmp	lr, r2
	bne	.L249
	ldrb	lr, [r1, #3]
	cmp	lr, #3
	bne	.L249
	ldr	lr, [r1, #664]
	bic	lr, lr, #-16777216
	bic	lr, lr, #255
	cmp	lr, #256
	bne	.L249
	ldr	r6, [r1, #56]
	ldr	lr, [r5, #2056]
	cmp	r6, lr
	bne	.L249
	bl	MVC_UnMarkFrameStoreRef
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L268:
	ldr	lr, [r1, #56]
	ldr	r3, [r7, #2056]
	cmp	lr, r3
	bne	.L246
	ldr	r3, [r1, #744]
	cmp	r2, r3
	bne	.L246
	add	r3, r0, ip, lsl #2
	strb	r6, [r1, #3]
	add	r3, r3, #11075584
	mov	r2, #0
	add	r3, r3, #45056
	ldr	r1, [r3, #2664]
	strb	r2, [r1, #737]
	ldr	r1, [r3, #2664]
	ldrb	ip, [r1, #664]
	cmp	ip, #3
	cmpne	ip, r2
	streqb	r2, [r1, #666]
	ldreq	r1, [r3, #2664]
	streqb	r2, [r1, #665]
	ldreq	r1, [r3, #2664]
	ldrb	ip, [r1, #3]
	cmp	ip, #0
	ldmnefd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	ldr	r3, [r1, #48]
	mov	r2, ip
	add	r3, r0, r3, lsl #2
	str	ip, [r3, #148]
	ldrsb	r1, [r1, #6]
	ldr	r0, [r0, #120]
	bl	FSP_SetRef
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L271:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L269:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L270:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L267:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	MVC_UnMarkLTRef, .-MVC_UnMarkLTRef
	.align	2
	.global	MVC_MarkPicLTRef
	.type	MVC_MarkPicLTRef, %function
MVC_MarkPicLTRef:
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
	ldrb	r6, [r3, #3]
	add	r3, r0, #11075584
	cmp	r6, #0
	add	r3, r3, #45056
	beq	.L273
	ldr	r7, [r3, #2736]
	cmp	r7, #0
	beq	.L302
	movw	r5, #47652
	add	r8, r0, #11141120
	movt	r5, 169
	add	r8, r8, #12288
	add	r5, r0, r5
	mov	ip, #0
	b	.L287
.L279:
	tst	r4, #2
	beq	.L282
	ldr	lr, [r3, #736]
	bic	lr, lr, #-16777216
	bic	lr, lr, #255
	cmp	lr, #65536
	beq	.L303
.L282:
	add	ip, ip, #1
	cmp	ip, r7
	beq	.L304
.L287:
	ldr	r3, [r5, #4]!
	ldrb	r4, [r3, #3]
	tst	r4, #1
	beq	.L279
	ldr	lr, [r3, #700]
	bic	lr, lr, #-16777216
	bic	lr, lr, #255
	cmp	lr, #65536
	bne	.L279
	ldr	lr, [r3, #712]
	cmp	lr, r2
	bne	.L279
	ldr	r9, [r3, #56]
	ldr	lr, [r8, #2056]
	cmp	r9, lr
	bne	.L279
	ldrb	lr, [r3, #737]
	cmp	lr, #1
	bne	.L283
	ldr	lr, [r3, #28]
	cmp	lr, r1
	bne	.L282
.L283:
	add	r0, r0, ip, lsl #2
	str	r1, [r3, #28]
	add	r3, r0, #11075584
	sub	r6, r6, #1
	add	r3, r3, #45056
	clz	r6, r6
	mov	ip, #1
	mov	r0, #0
	ldr	r2, [r3, #2600]
	mov	r6, r6, lsr #5
	add	r1, r6, r1, lsl #1
	str	r1, [r2, #708]
	ldr	r2, [r3, #2600]
	strb	ip, [r2, #701]
	ldr	r2, [r3, #2600]
	strb	r0, [r2, #702]
	ldr	r2, [r3, #2600]
	ldrb	r1, [r2, #664]
	cmp	r1, #3
	cmpne	r1, r0
	bne	.L305
	ldrb	r1, [r2, #737]
	ldrb	r0, [r2, #701]
	cmp	r1, r0
	streqb	r1, [r2, #665]
	ldreq	r3, [r3, #2600]
	ldreqb	r2, [r3, #702]
	streqb	r2, [r3, #666]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L273:
	ldr	r4, [r3, #2736]
	cmp	r4, #0
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	movw	ip, #47652
	add	r5, r0, #11141120
	movt	ip, 169
	add	r5, r5, #12288
	add	ip, r0, ip
	b	.L278
.L277:
	add	r6, r6, #1
	cmp	r6, r4
	beq	.L306
.L278:
	ldr	r3, [ip, #4]!
	ldrb	lr, [r3, #3]
	cmp	lr, #3
	bne	.L277
	ldr	lr, [r3, #664]
	bic	lr, lr, #-16777216
	bic	lr, lr, #255
	cmp	lr, #65536
	bne	.L277
	ldr	lr, [r3, #676]
	cmp	lr, r2
	bne	.L277
	ldr	r7, [r3, #56]
	ldr	lr, [r5, #2056]
	cmp	r7, lr
	bne	.L277
	add	r6, r0, r6, lsl #2
	str	r1, [r3, #28]
	add	r3, r6, #11075584
	mov	r0, #1
	add	r3, r3, #45056
	mov	r2, #0
	ldr	ip, [r3, #2600]
	str	r1, [ip, #672]
	ldr	r1, [r3, #2600]
	strb	r0, [r1, #665]
	ldr	r1, [r3, #2600]
	strb	r0, [r1, #701]
	ldr	r1, [r3, #2600]
	strb	r0, [r1, #737]
	ldr	r1, [r3, #2600]
	strb	r2, [r1, #666]
	ldr	r1, [r3, #2600]
	strb	r2, [r1, #702]
	ldr	r3, [r3, #2600]
	strb	r2, [r3, #738]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L303:
	ldr	lr, [r3, #748]
	cmp	lr, r2
	bne	.L282
	ldr	r4, [r3, #56]
	ldr	lr, [r8, #2056]
	cmp	r4, lr
	bne	.L282
	ldrb	lr, [r3, #701]
	cmp	lr, #1
	bne	.L286
	ldr	lr, [r3, #28]
	cmp	lr, r1
	bne	.L282
.L286:
	add	r0, r0, ip, lsl #2
	str	r1, [r3, #28]
	add	r3, r0, #11075584
	sub	r6, r6, #2
	add	r3, r3, #45056
	clz	r6, r6
	mov	ip, #1
	mov	r0, #0
	ldr	r2, [r3, #2600]
	mov	r6, r6, lsr #5
	add	r1, r6, r1, lsl #1
	str	r1, [r2, #744]
	ldr	r2, [r3, #2600]
	strb	ip, [r2, #737]
	ldr	r2, [r3, #2600]
	strb	r0, [r2, #738]
	ldr	r2, [r3, #2600]
	ldrb	r1, [r2, #664]
	cmp	r1, #3
	cmpne	r1, r0
	bne	.L307
	ldrb	r1, [r2, #737]
	ldrb	r0, [r2, #701]
	cmp	r1, r0
	streqb	r1, [r2, #665]
	ldreq	r3, [r3, #2600]
	ldreqb	r2, [r3, #738]
	streqb	r2, [r3, #666]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L304:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L306:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L305:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L307:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L302:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	MVC_MarkPicLTRef, .-MVC_MarkPicLTRef
	.align	2
	.global	MVC_MarkSTToLTRef
	.type	MVC_MarkSTToLTRef, %function
MVC_MarkSTToLTRef:
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
	mov	r6, r1
	ldrb	r1, [r1, #3]
	mov	r8, r3
	mov	r7, r0
	cmp	r1, #0
	bne	.L309
	ldr	r5, [r6, #616]
	mov	r1, r3
	sub	r5, r5, #1
	rsb	r5, r2, r5
	bl	MVC_UnMarkLTFrmByFrmIdx
.L310:
	mov	r3, r6
	mov	r2, r5
	mov	r1, r8
	mov	r0, r7
	bl	MVC_MarkPicLTRef
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L309:
	add	r3, r0, #11075584
	ldr	r5, [r6, #616]
	add	r3, r3, #45056
	ldr	r1, [r3, #2736]
	rsb	r5, r2, r5, lsl #1
	cmp	r1, #0
	beq	.L310
	movw	r2, #47652
	add	r0, r0, #11141120
	movt	r2, 169
	add	r0, r0, #12288
	add	r2, r7, r2
	mov	lr, #0
	b	.L313
.L311:
	tst	r3, #2
	beq	.L312
	ldr	r3, [ip, #736]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #65536
	beq	.L324
.L312:
	cmp	lr, r1
	beq	.L310
.L313:
	ldr	ip, [r2, #4]!
	add	lr, lr, #1
	ldrb	r3, [ip, #3]
	tst	r3, #1
	beq	.L311
	ldr	r4, [ip, #700]
	bic	r4, r4, #-16777216
	bic	r4, r4, #255
	cmp	r4, #65536
	bne	.L311
	ldr	r4, [ip, #712]
	cmp	r4, r5
	bne	.L311
	ldr	r9, [ip, #56]
	ldr	r4, [r0, #2056]
	cmp	r9, r4
	bne	.L311
	mov	r1, ip
	mov	r3, r8
	mov	r2, #1
	mov	r0, r7
	bl	MVC_UnMarkLTFldByFrmIdx
	b	.L310
.L324:
	ldr	r3, [ip, #748]
	cmp	r3, r5
	bne	.L312
	ldr	r4, [ip, #56]
	ldr	r3, [r0, #2056]
	cmp	r4, r3
	bne	.L312
	mov	r1, ip
	mov	r3, r8
	mov	r2, #2
	mov	r0, r7
	bl	MVC_UnMarkLTFldByFrmIdx
	b	.L310
	.fnend
	.size	MVC_MarkSTToLTRef, .-MVC_MarkSTToLTRef
	.align	2
	.global	MVC_UpdateMaxLTFrmIdx
	.type	MVC_UpdateMaxLTFrmIdx, %function
MVC_UpdateMaxLTFrmIdx:
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
	add	r5, r0, #11075584
	add	r5, r5, #45056
	mov	r8, r0
	ldr	r3, [r5, #2740]
	str	r1, [r5, #2744]
	cmp	r3, #0
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	movw	r6, #47716
	add	r7, r0, #11141120
	movt	r6, 169
	add	r7, r7, #12288
	add	r6, r0, r6
	mov	r3, r1
	mov	r4, #0
	b	.L329
.L327:
	ldr	r3, [r5, #2740]
	cmp	r3, r4
	ldmlsfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	ldr	r3, [r5, #2744]
.L329:
	ldr	r1, [r6, #4]!
	add	r4, r4, #1
	ldr	r2, [r1, #28]
	cmp	r2, r3
	bcc	.L327
	ldr	r2, [r1, #56]
	ldr	r3, [r7, #2056]
	cmp	r2, r3
	bne	.L327
	mov	r0, r8
	bl	MVC_UnMarkFrameStoreRef
	b	.L327
	.fnend
	.size	MVC_UpdateMaxLTFrmIdx, .-MVC_UpdateMaxLTFrmIdx
	.align	2
	.global	MVC_UnMarkAllSTRef
	.type	MVC_UnMarkAllSTRef, %function
MVC_UnMarkAllSTRef:
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
	add	r6, r0, #11075584
	add	r6, r6, #45056
	mov	r8, r0
	ldr	r3, [r6, #2736]
	cmp	r3, #0
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	movw	r5, #47652
	add	r7, r0, #11141120
	movt	r5, 169
	add	r7, r7, #12288
	add	r5, r0, r5
	mov	r4, #0
	b	.L333
.L332:
	ldr	r3, [r6, #2736]
	cmp	r3, r4
	bls	.L336
.L333:
	ldr	r1, [r5, #4]!
	add	r4, r4, #1
	ldr	r3, [r7, #2056]
	ldr	r2, [r1, #56]
	cmp	r2, r3
	bne	.L332
	mov	r0, r8
	bl	MVC_UnMarkFrameStoreRef
	ldr	r3, [r6, #2736]
	cmp	r3, r4
	bhi	.L333
.L336:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	MVC_UnMarkAllSTRef, .-MVC_UnMarkAllSTRef
	.align	2
	.global	MVC_MarkCurrPicLT
	.type	MVC_MarkCurrPicLT, %function
MVC_MarkCurrPicLT:
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
	mov	r5, r2
	ldrb	r2, [r1, #3]
	mov	r4, r1
	cmp	r2, #0
	beq	.L340
	mov	r3, r5
	ldr	r1, [r1, #608]
	bl	MVC_UnMarkLTFldByFrmIdx
.L339:
	mov	r2, #1
	mov	r3, #0
	str	r5, [r4, #620]
	strb	r2, [r4, #4]
	strb	r3, [r4, #5]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L340:
	mov	r1, r5
	bl	MVC_UnMarkLTFrmByFrmIdx
	b	.L339
	.fnend
	.size	MVC_MarkCurrPicLT, .-MVC_MarkCurrPicLT
	.align	2
	.global	MVC_RemoveFrameStoreOutDPB
	.type	MVC_RemoveFrameStoreOutDPB, %function
MVC_RemoveFrameStoreOutDPB:
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
	add	r1, r0, r1, lsl #2
	add	r4, r1, #11075584
	mov	r5, r0
	add	r7, r4, #45056
	ldr	r2, [r7, #2536]
	cmp	r2, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	r1, [r2, #52]
	movw	r3, #47800
	add	r6, r0, #11075584
	movt	r3, 169
	add	r1, r0, r1
	add	r0, r6, #45056
	add	r3, r1, r3
	mov	r1, #0
	strb	r1, [r3, #4]
	ldr	r3, [r0, #2960]
	cmp	r3, r1
	subne	r3, r3, #1
	str	r3, [r0, #2960]
	ldrsb	r1, [r2, #6]
	ldr	r0, [r5, #120]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	beq	.L344
	ldrsb	r3, [r0, #1]
	cmp	r3, #3
	beq	.L345
	ldr	r3, [r7, #2536]
	mov	r2, #0
	ldr	r0, [r5, #120]
	ldrsb	r1, [r3, #6]
	bl	FSP_SetDisplay
.L345:
	ldr	r3, [r7, #2536]
	mov	r2, #0
	ldr	r0, [r5, #120]
	ldrsb	r1, [r3, #6]
	bl	FSP_SetRef
.L344:
	add	r1, r4, #45056
	mov	r3, #0
	add	r6, r6, #45056
	ldr	r2, [r1, #2536]
	strb	r3, [r2, #2]
	ldr	r2, [r1, #2536]
	strb	r3, [r2, #5]
	ldr	r2, [r1, #2536]
	strb	r3, [r2, #3]
	str	r3, [r1, #2536]
	ldr	r3, [r6, #2732]
	sub	r3, r3, #1
	str	r3, [r6, #2732]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	MVC_RemoveFrameStoreOutDPB, .-MVC_RemoveFrameStoreOutDPB
	.align	2
	.global	MVC_RemoveUnUsedFrameStore
	.type	MVC_RemoveUnUsedFrameStore, %function
MVC_RemoveUnUsedFrameStore:
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
	add	r3, r0, #11075584
	add	r3, r3, #45056
	mov	r8, r0
	mov	r7, r1
	ldr	r6, [r3, #2728]
	cmp	r6, #0
	beq	.L373
	movw	r5, #47588
	mov	r4, #0
	movt	r5, 169
	add	r5, r0, r5
.L361:
	ldr	r3, [r5, #4]!
	cmp	r3, #0
	beq	.L360
	ldrb	r2, [r3, #3]
	cmp	r2, #0
	bne	.L360
	ldrb	r2, [r3, #5]
	cmp	r2, #0
	bne	.L360
	ldr	r1, [r3, #56]
	cmn	r7, #1
	cmpne	r1, r7
	beq	.L374
.L360:
	add	r4, r4, #1
	cmp	r4, r6
	bne	.L361
.L373:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L374:
	ldr	ip, [r3, #16]
	mov	r1, r4
	mov	r0, r8
	cmp	ip, #1
	beq	.L360
	strb	r2, [r3, #2]
	bl	MVC_RemoveFrameStoreOutDPB
	b	.L360
	.fnend
	.size	MVC_RemoveUnUsedFrameStore, .-MVC_RemoveUnUsedFrameStore
	.align	2
	.global	MVC_CheckFrameStore
	.type	MVC_CheckFrameStore, %function
MVC_CheckFrameStore:
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
	ldrb	r3, [r0, #6]
	mov	r5, r0
	mov	r4, r1
	cmp	r3, #0
	bne	.L376
	ldrsb	r3, [r1, #8]
	cmp	r3, #1
	bne	.L388
	strb	r3, [r0, #6]
.L376:
	ldrsb	r1, [r4, #6]
	ldr	r0, [r5, #120]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	beq	.L378
	ldrsb	r3, [r0, #1]
	cmp	r3, #3
	cmpne	r3, #0
	beq	.L398
	ldrb	r2, [r4, #2]
	ldrb	r3, [r4, #1]
	cmp	r2, #0
	beq	.L387
	cmp	r3, #1
	beq	.L387
	cmp	r2, #3
	beq	.L399
	cmp	r2, #1
	beq	.L400
	cmp	r2, #2
	beq	.L401
.L383:
	ldr	r3, [r5, #224]
	ldr	r2, [r0, #168]
	ldr	r3, [r3, #4]
	cmp	r2, r3
	movls	r0, #0
	bhi	.L402
.L396:
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L398:
	ldrsb	r2, [r4, #6]
	mov	r0, #1
	ldr	r1, .L403
	bl	dprint_vfmw
.L380:
	ldr	r3, [r4, #16]
	cmp	r3, #1
	mvnne	r0, #2
	moveq	r3, #2
	mvneq	r0, #2
	streq	r3, [r4, #16]
	b	.L396
.L399:
	ldrb	r3, [r4, #4]
	cmp	r3, #3
	bne	.L383
	mov	r2, r3
	ldr	r1, .L403+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L396
.L400:
	ldrb	r3, [r4, #4]
	tst	r3, #1
	beq	.L383
	mov	r0, r2
	ldr	r1, .L403+8
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L396
.L401:
	ldrb	r3, [r4, #4]
	tst	r3, #2
	beq	.L383
	ldr	r1, .L403+12
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L396
.L388:
	mvn	r0, #0
	b	.L396
.L378:
	ldrsb	ip, [r4, #6]
	mov	r2, r4
	ldr	r3, [r4, #16]
	mov	r0, #1
	ldr	r1, .L403+16
	str	ip, [sp]
	bl	dprint_vfmw
	b	.L380
.L387:
	ldr	r1, .L403+20
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L396
.L402:
	ldr	r1, .L403+24
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L396
.L404:
	.align	2
.L403:
	.word	.LC4
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC5
	.word	.LC6
	.word	.LC10
	.fnend
	.size	MVC_CheckFrameStore, .-MVC_CheckFrameStore
	.align	2
	.global	MVC_ExchangePts
	.type	MVC_ExchangePts, %function
MVC_ExchangePts:
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
	add	r8, r1, #640
	mvn	r7, #0
	mvn	r6, #0
	mov	r5, r0
	ldrd	r2, [r8]
	cmp	r3, r7
	cmpeq	r2, r6
	beq	.L405
	add	r9, r0, #11075584
	add	r9, r9, #45056
	ldr	r3, [r9, #2728]
	cmp	r3, #0
	beq	.L405
	movw	r10, #47588
	mvn	r6, #1
	movt	r10, 169
	add	r10, r0, r10
	mvn	r7, #0
	mov	r4, #0
	mvn	r3, #0
	str	r3, [fp, #-48]
.L410:
	ldr	r3, [r10, #4]!
	cmp	r3, #0
	beq	.L409
	ldrsb	r1, [r3, #6]
	ldr	r0, [r5, #120]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	beq	.L409
	ldrsb	r3, [r0, #1]
	cmp	r3, #3
	cmpne	r3, #0
	beq	.L409
	ldr	r3, [r10]
	add	r3, r3, #640
	ldrd	r0, [r3]
	cmp	r1, r7
	cmpeq	r0, r6
	strcc	r4, [fp, #-48]
	movcc	r6, r0
	movcc	r7, r1
.L409:
	ldr	r3, [r9, #2728]
	add	r4, r4, #1
	cmp	r4, r3
	bcc	.L410
	ldr	r3, [fp, #-48]
	cmn	r3, #1
	beq	.L405
	ldrd	r2, [r8]
	cmp	r3, r7
	cmpeq	r2, r6
	bhi	.L424
.L405:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L424:
	strd	r6, [sp]
	mov	r0, #29
	ldr	r1, .L425
	bl	dprint_vfmw
	ldr	r3, [fp, #-48]
	movw	r1, #28282
	movt	r1, 42
	add	r1, r3, r1
	ldrd	r2, [r8]
	ldr	r1, [r5, r1, asl #2]
	add	r1, r1, #640
	strd	r2, [r1]
	strd	r6, [r8]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L426:
	.align	2
.L425:
	.word	.LC11
	.fnend
	.size	MVC_ExchangePts, .-MVC_ExchangePts
	.align	2
	.global	MVC_GetImagePara
	.type	MVC_GetImagePara, %function
MVC_GetImagePara:
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
	add	r3, r0, #11075584
	add	ip, r3, #40960
	ldr	r2, [r0, #252]
	mov	r4, r1
	mov	r5, r0
	ldr	r1, [ip, #888]
	mov	r0, #2240
	ldr	lr, [r4, #180]
	movw	r8, #3992
	ldr	r7, [r5, #248]
	mla	r0, r0, r1, r2
	bic	r1, lr, #768
	bic	r1, r1, #3
	ldrb	r6, [r4, #2]
	ldr	r2, [r0, #28]
	str	r1, [r4, #180]
	ldr	r0, [r5, #56]
	mla	r2, r8, r2, r7
	mov	r0, r0, asl #10
	str	r0, [r4, #208]
	cmp	r6, #3
	ldrls	pc, [pc, r6, asl #2]
	b	.L465
.L430:
	.word	.L429
	.word	.L431
	.word	.L432
	.word	.L429
.L432:
	ldrb	r0, [r4]
	add	r3, r5, #11075584
	ldr	lr, [r4, #44]
	add	r3, r3, #45056
	orr	r1, r1, #2816
	and	r0, r0, #3
	orr	r1, r1, r0
	str	r1, [r4, #180]
	str	lr, [r4, #232]
.L428:
	ldrb	r1, [r2, #20]
	str	r1, [r4, #512]
	str	r1, [r4, #516]
	ldrb	r1, [r2, #24]
	cmp	r1, #0
	ldrne	r1, [r2, #68]
	mov	r2, #1
	str	r2, [r4, #520]
	str	r1, [r4, #524]
	ldrb	r2, [ip, #883]
	cmp	r2, #1
	movne	r2, #0
	str	r2, [r4, #272]
	ldr	r2, [r5, #224]
	ldr	r2, [r2, #12]
	cmp	r2, #0
	ble	.L450
	ldrb	r2, [r4, #664]
	cmp	r2, #0
	bne	.L450
	ldrb	r2, [r4, #2]
	cmp	r2, #3
	ldreq	r2, [r4, #180]
	biceq	r2, r2, #768
	streq	r2, [r4, #180]
.L450:
	ldrb	r2, [r3, #2488]
	cmp	r2, #0
	beq	.L451
	ldr	r2, [r3, #2504]
	cmp	r2, #3
	moveq	r3, #1
	streq	r3, [r4, #392]
	beq	.L451
	cmp	r2, #4
	moveq	r3, #2
	streq	r3, [r4, #392]
	beq	.L451
	cmp	r2, #5
	moveq	r3, #3
	streq	r3, [r4, #392]
	beq	.L451
	mov	r0, #0
	ldr	r1, .L477
	str	r0, [r4, #392]
	ldr	r2, [r3, #2504]
	bl	dprint_vfmw
.L451:
	ldr	r0, [r5, #120]
	ldrsb	r1, [r4, #6]
	bl	FSP_GetFsImagePtr
	subs	r5, r0, #0
	ldmeqfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	ldr	r3, .L477+4
	mov	r2, #592
	add	r1, r4, #72
	ldr	r3, [r3, #52]
	blx	r3
	mov	r3, #15
	str	r3, [r5, #340]
	mov	r2, #1
	ldrb	r3, [r4, #664]
	strb	r2, [r5, #335]
	cmp	r3, #0
	movne	r3, #4
	strb	r3, [r5, #328]
	ldr	r3, [r4, #692]
	strb	r2, [r5, #333]
	str	r3, [r5, #344]
	str	r3, [r5, #352]
	str	r3, [r5, #348]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L431:
	ldrb	r0, [r4]
	add	r3, r5, #11075584
	ldr	lr, [r4, #44]
	orr	r1, r1, #1792
	and	r0, r0, #3
	add	r3, r3, #45056
	orr	r1, r1, r0
	str	r1, [r4, #180]
	str	lr, [r4, #232]
	b	.L428
.L429:
	ldrb	r1, [r4, #664]
	cmp	r1, #0
	bne	.L433
	ldr	r1, [r4, #40]
	mov	r7, #3072
	ldr	r0, [r4, #44]
	cmp	r1, #0
	ldrb	r1, [r4]
	moveq	r6, #512
	movne	r6, #768
	str	r0, [r4, #232]
.L434:
	ldr	r8, [r4, #716]
	ldr	r0, [r4, #752]
	cmp	r8, r0
	beq	.L474
	movle	r0, #1
	movgt	r0, #0
.L445:
	add	r3, r3, #45056
	ldrb	r8, [r3, #2524]
	cmp	r8, #3
	moveq	r0, #4096
	beq	.L446
	cmp	r8, #4
	movne	r0, r0, asl #12
	moveq	r0, #0
.L446:
	bic	lr, lr, #13056
	orr	r6, r7, r6
	bic	lr, lr, #3
	and	r1, r1, #3
	orr	lr, r6, lr
	orr	lr, lr, r1
	orr	lr, lr, r0
	str	lr, [r4, #180]
	b	.L428
.L433:
	ldr	r8, [r4, #724]
	ldr	r1, [r5, #116]
	ldr	r0, [r4, #760]
	cmp	r8, r1
	bhi	.L475
	cmp	r1, r0
	bcc	.L438
.L436:
	ldr	r0, [r4, #44]
	mov	r6, #3
	ldrb	r1, [r4]
	ldrb	r10, [r4, #703]
	ldrb	r9, [r4, #739]
	str	r0, [r4, #232]
.L439:
	ldrb	r0, [r4, #4]
	cmp	r0, #1
	beq	.L476
	cmp	r0, #2
	streq	r8, [r4, #232]
	movne	r7, r6, asl #10
	moveq	r1, r10
	moveq	r7, #1024
.L441:
	mov	r6, #768
	str	r10, [r4, #172]
	str	r9, [r4, #176]
	b	.L434
.L438:
	ldrb	r1, [r4, #703]
	mov	r6, #1
	ldrb	r9, [r4, #739]
	str	r8, [r4, #232]
	mov	r10, r1
	b	.L439
.L474:
	ldr	r0, [r4, #184]
	cmp	r0, #720
	movne	r0, #1
	bne	.L445
	ldr	r0, [r4, #188]
	subs	r0, r0, #480
	movne	r0, #1
	b	.L445
.L475:
	cmp	r1, r0
	bcc	.L436
	ldrb	r1, [r4, #739]
	mov	r6, #2
	str	r0, [r4, #232]
	ldrb	r10, [r4, #703]
	mov	r9, r1
	b	.L439
.L476:
	ldr	r0, [r4, #760]
	mov	r1, r9
	mov	r7, #2048
	str	r0, [r4, #232]
	b	.L441
.L465:
	add	r3, r5, #11075584
	add	r3, r3, #45056
	b	.L428
.L478:
	.align	2
.L477:
	.word	.LC12
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	MVC_GetImagePara, .-MVC_GetImagePara
	.align	2
	.global	MVC_SetFrmRepeatCount
	.type	MVC_SetFrmRepeatCount, %function
MVC_SetFrmRepeatCount:
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
	ldr	r3, [r0, #224]
	ldr	r3, [r3, #600]
	add	r3, r3, #2032
	add	r3, r3, #15
	cmp	r3, #4096
	movcc	r3, #0
	strcc	r3, [r1, #24]
	ldmccfd	sp, {fp, sp, pc}
	bl	MVC_SetFrmRepeatCount.part.1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_SetFrmRepeatCount, .-MVC_SetFrmRepeatCount
	.align	2
	.global	MVC_SplitFrmToFlds
	.type	MVC_SplitFrmToFlds, %function
MVC_SplitFrmToFlds:
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
	ldrb	lr, [r0, #665]
	ldrb	ip, [r0, #666]
	mov	r5, #1
	ldr	r1, [r0, #688]
	mov	r4, #2
	ldrb	r2, [r0, #667]
	ldr	r3, [r0, #668]
	strb	r5, [r0, #700]
	strb	r4, [r0, #736]
	strb	lr, [r0, #701]
	strb	lr, [r0, #737]
	strb	ip, [r0, #702]
	strb	ip, [r0, #738]
	str	r1, [r0, #724]
	str	r1, [r0, #760]
	strb	r2, [r0, #703]
	strb	r2, [r0, #739]
	str	r3, [r0, #704]
	str	r3, [r0, #740]
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	MVC_SplitFrmToFlds, .-MVC_SplitFrmToFlds
	.align	2
	.global	MVC_CombineFldsToFrm
	.type	MVC_CombineFldsToFrm, %function
MVC_CombineFldsToFrm:
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
	ldr	r2, [r0, #752]
	ldr	r1, [r0, #716]
	mov	lr, #3
	ldr	r3, [r0, #760]
	cmp	r2, r1
	ldr	r5, [r0, #724]
	ldrb	r4, [r0, #737]
	ldr	ip, [r0, #704]
	movge	r2, r1
	add	r3, r3, r5
	cmp	r4, #0
	strb	lr, [r0, #664]
	mov	r3, r3, lsr #1
	str	ip, [r0, #668]
	str	r2, [r0, #680]
	str	r2, [r0, #32]
	str	r3, [r0, #688]
	beq	.L484
	ldrb	r2, [r0, #701]
	cmp	r2, #0
	bne	.L485
.L484:
	ldr	r2, [r0, #736]
	mov	r1, #0
	strb	r1, [r0, #665]
	bic	r2, r2, #-16777216
	bic	r2, r2, #255
	cmp	r2, r1
	beq	.L489
	ldr	r2, [r0, #700]
	bic	r2, r2, #-16777216
	bic	r2, r2, #255
	cmp	r2, #0
	movne	ip, #1
	bne	.L487
.L489:
	mov	ip, #0
.L487:
	ldrb	r2, [r0, #739]
	ldrb	r1, [r0, #703]
	str	r3, [r0, #44]
	cmp	r2, r1
	strb	ip, [r0, #666]
	movcs	r3, r2
	movcc	r3, r1
	strb	r3, [r0, #667]
	strb	r3, [r0]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L485:
	mov	r1, #1
	strb	r1, [r0, #665]
	b	.L489
	.fnend
	.size	MVC_CombineFldsToFrm, .-MVC_CombineFldsToFrm
	.align	2
	.global	MVC_GetAPC
	.type	MVC_GetAPC, %function
MVC_GetAPC:
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
	subs	r6, r1, #0
	mov	r5, r0
	beq	.L520
	cmp	r2, #1
	beq	.L501
	cmp	r2, #2
	beq	.L502
	ldr	r9, [r6, #716]
	ldr	r10, [r6, #752]
.L503:
	add	r8, r5, #11075584
	add	r7, r8, #45056
	ldr	ip, [r7, #2956]
	cmp	ip, #0
	beq	.L512
	ldrb	r4, [r7, #2748]
	cmp	r4, #0
	movwne	r3, #47804
	movne	r4, #0
	movtne	r3, 169
	addne	r3, r5, r3
	bne	.L506
	b	.L504
.L510:
	ldrb	r2, [r3, #1]!
	cmp	r2, #0
	beq	.L504
.L506:
	add	r4, r4, #1
	cmp	r4, ip
	bne	.L510
.L512:
	mvn	r0, #0
.L516:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L502:
	ldr	r9, [r6, #752]
	mov	r10, r9
	b	.L503
.L504:
	ldrsb	r1, [r6, #6]
	ldr	r0, [r5, #120]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	beq	.L507
	ldr	r3, [r0, #608]
	cmp	r3, #0
	beq	.L507
	add	r2, r5, r4
	movw	r3, #47800
	movt	r3, 169
	add	r3, r2, r3
	mov	r2, #1
	add	r5, r5, r4, lsl #2
	strb	r2, [r3, #4]
	add	r5, r5, #11075584
	ldr	r3, [r0, #608]
	add	r5, r5, #45056
	add	r8, r8, #45056
	ldr	r1, .L521
	mov	r0, #13
	ldr	r3, [r3, #8]
	str	r9, [r5, #2828]
	str	r10, [r5, #2892]
	str	r3, [r5, #2764]
	ldr	r3, [r7, #2960]
	cmp	r3, #15
	addls	r2, r3, r2
	mov	r3, r4
	movhi	r2, #16
	str	r2, [r8, #2960]
	ldr	r2, [r6, #228]
	bl	dprint_vfmw
	mov	r0, #0
	str	r4, [r6, #52]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L501:
	ldr	r9, [r6, #716]
	mov	r10, r9
	b	.L503
.L507:
	mov	r1, #0
	ldrsb	r2, [r6, #6]
	ldrb	r3, [r6, #3]
	stmia	sp, {r0, r1}
	mov	r0, r1
	ldr	r1, .L521+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L516
.L520:
	mov	r0, r6
	movw	r3, #2123
	ldr	r2, .L521+8
	ldr	r1, .L521+12
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L516
.L522:
	.align	2
.L521:
	.word	.LC15
	.word	.LC16
	.word	.LC13
	.word	.LC14
	.fnend
	.size	MVC_GetAPC, .-MVC_GetAPC
	.align	2
	.global	MVC_SlidingWinMark
	.type	MVC_SlidingWinMark, %function
MVC_SlidingWinMark:
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
	add	r3, r0, #11075584
	ldr	r2, [r0, #236]
	add	r3, r3, #45056
	mov	r10, r0
	ldr	r2, [r2, #3944]
	ldr	r0, [r3, #2740]
	ldr	r1, [r3, #2736]
	rsb	r2, r0, r2
	cmp	r1, r2
	beq	.L548
.L523:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L548:
	ldr	r8, [r3, #2728]
	cmp	r8, #0
	beq	.L528
	movw	r6, #47588
	add	r1, r10, #11141120
	movt	r6, 169
	mov	r2, #0
	add	r1, r1, #12288
	add	r6, r10, r6
	mov	r5, r2
	mvn	r9, #-2147483648
.L527:
	ldr	r4, [r6, #4]!
	cmp	r4, #0
	beq	.L526
	ldr	r7, [r4, #64]
	cmp	r9, r7
	bls	.L526
	ldrb	r3, [r4, #3]
	mov	r0, r4
	cmp	r3, #0
	beq	.L526
	str	r1, [fp, #-52]
	str	r2, [fp, #-48]
	bl	MVC_NonLongTermRefFlg
	ldr	r2, [fp, #-48]
	ldr	r1, [fp, #-52]
	cmp	r0, #0
	beq	.L526
	ldr	r0, [r4, #56]
	ldr	r3, [r1, #2056]
	cmp	r0, r3
	moveq	r9, r7
	moveq	r2, r5
.L526:
	add	r5, r5, #1
	cmp	r5, r8
	bne	.L527
.L525:
	movw	r3, #28282
	movt	r3, 42
	add	r3, r2, r3
	ldr	r4, [r10, r3, asl #2]
	cmp	r4, #0
	beq	.L523
	ldrb	r3, [r4, #3]
	cmp	r3, #0
	beq	.L523
	mov	r0, r4
	bl	MVC_NonLongTermRefFlg
	cmp	r0, #0
	beq	.L523
	add	r3, r10, #11141120
	ldr	r2, [r4, #56]
	add	r3, r3, #12288
	ldr	r3, [r3, #2056]
	cmp	r2, r3
	bne	.L523
	mov	r0, r10
	mov	r1, r4
	bl	MVC_UnMarkFrameStoreRef
	mov	r0, r10
	bl	MVC_UpdateReflist
	b	.L523
.L528:
	mov	r2, r8
	b	.L525
	.fnend
	.size	MVC_SlidingWinMark, .-MVC_SlidingWinMark
	.align	2
	.global	MVC_DumpDPB
	.type	MVC_DumpDPB, %function
MVC_DumpDPB:
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
	ldr	r3, .L562
	mov	r7, r0
	ldr	r3, [r3]
	tst	r3, #16384
	beq	.L549
	add	r6, r0, #11075584
	add	r6, r6, #45056
	ldr	r3, [r6, #2732]
	cmp	r3, #0
	movwne	r5, #47588
	movne	r4, #0
	movtne	r5, 169
	addne	r5, r0, r5
	beq	.L555
.L554:
	ldr	ip, [r5, #4]!
	mov	r2, r4
	ldr	r1, .L562+4
	mov	r0, #14
	add	r4, r4, #1
	ldrb	lr, [ip, #3]
	ldr	r3, [ip, #20]
	str	lr, [sp, #4]
	ldr	ip, [ip, #32]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [r6, #2732]
	cmp	r3, r4
	bhi	.L554
.L555:
	ldr	r1, .L562+8
	mov	r0, #14
	bl	dprint_vfmw
	ldr	r3, [r6, #2736]
	cmp	r3, #0
	movwne	r5, #47652
	movne	r4, #0
	movtne	r5, 169
	addne	r5, r7, r5
	beq	.L553
.L556:
	ldr	ip, [r5, #4]!
	mov	r2, r4
	ldr	r1, .L562+12
	mov	r0, #14
	ldrb	lr, [ip, #3]
	ldr	r3, [ip, #20]
	str	lr, [sp, #4]
	ldr	ip, [ip, #32]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [r5]
	mov	r2, r4
	ldr	r1, .L562+16
	mov	r0, #14
	add	r4, r4, #1
	ldr	r3, [r3, #680]
	bl	dprint_vfmw
	ldr	r3, [r6, #2736]
	cmp	r3, r4
	bhi	.L556
.L553:
	ldr	r1, .L562+8
	mov	r0, #14
	bl	dprint_vfmw
.L549:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L563:
	.align	2
.L562:
	.word	g_PrintEnable
	.word	.LC18
	.word	.LC17
	.word	.LC19
	.word	.LC20
	.fnend
	.size	MVC_DumpDPB, .-MVC_DumpDPB
	.align	2
	.global	MVC_UpdateCurrFrameInfo
	.type	MVC_UpdateCurrFrameInfo, %function
MVC_UpdateCurrFrameInfo:
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
	add	r0, r0, #11141120
	add	r3, r0, #12288
	ldrb	r2, [r3, #1370]
	ldr	r4, [r3, #1976]
	strb	r2, [r4, #1]
	ldrb	r2, [r3, #1372]
	cmp	r2, #0
	movne	r2, #3
	bne	.L565
	ldrb	r2, [r3, #1373]
	cmp	r2, #0
	movne	r2, #3
.L565:
	strb	r2, [r4, #3]
	ldr	r2, [r3, #1984]
	str	r2, [r4, #20]
	ldr	r2, [r3, #2028]
	str	r2, [r4, #44]
	ldrb	r2, [r3, #1380]
	strb	r2, [r4]
	ldr	r2, [r3, #1996]
	str	r2, [r4, #32]
	ldr	r2, [r3, #2052]
	str	r2, [r4, #48]
	ldr	r2, [r3, #1988]
	str	r2, [r4, #28]
	ldrb	r2, [r3, #1377]
	str	r2, [r4, #40]
	ldrb	r2, [r3, #1375]
	cmp	r2, #1
	moveq	r1, #3
	movne	r1, #0
	strb	r1, [r4, #4]
	ldrb	r2, [r3, #1371]
	cmp	r2, #1
	beq	.L568
	bcc	.L569
	cmp	r2, #2
	ldmnefd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	str	r4, [r4, #740]
	mov	ip, #1
	strb	ip, [r4, #736]
	mov	r6, #0
	ldrb	ip, [r3, #1372]
	strb	ip, [r4, #737]
	ldrb	ip, [r3, #1373]
	strb	ip, [r4, #738]
	ldr	ip, [r3, #2004]
	str	ip, [r4, #752]
	ldrb	ip, [r3, #1380]
	strb	ip, [r4, #739]
	ldr	lr, [r3, #2028]
	str	r6, [r4, #40]
	str	lr, [r4, #760]
	ldrb	r5, [r3, #1369]
	cmp	r5, r6
	beq	.L586
	ldr	r2, [r4, #724]
	mov	r5, #3
	strb	r5, [r4, #2]
	add	r3, r3, #1952
	add	lr, lr, r2
	str	lr, [r4, #44]
	str	lr, [r4, #688]
	mvn	r7, #0
	ldrb	r2, [r3, #-577]
	cmp	r2, #1
	orreq	r6, r1, #2
	strb	r6, [r4, #4]
	ldrd	r8, [r3]
	mvn	r6, #0
	cmp	r9, r7
	cmpeq	r8, r6
	beq	.L577
	add	r1, r4, #640
	ldrd	r2, [r1]
	cmp	r3, r7
	cmpeq	r2, r6
	beq	.L587
.L577:
	ldrb	r3, [r4, #703]
.L584:
	add	r1, r0, #12288
	cmp	r3, ip
	mov	r0, r4
	movcc	r3, ip
	strb	r3, [r4]
	ldr	r3, [r1, #1996]
	str	r3, [r4, #32]
	bl	MVC_CombineFldsToFrm
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L569:
	str	r4, [r4, #668]
	mov	r1, #3
	mov	r2, #0
	strb	r1, [r4, #2]
	strb	r2, [r4, #664]
	add	r1, r3, #1376
	ldrb	r5, [r3, #1372]
	mov	r2, #592
	add	r1, r1, #8
	add	r0, r4, #72
	strb	r5, [r4, #665]
	ldrb	r6, [r3, #1373]
	strb	r6, [r4, #666]
	ldr	ip, [r3, #2000]
	str	ip, [r4, #680]
	ldrb	r7, [r3, #1380]
	strb	r7, [r4, #667]
	ldr	r8, [r3, #2028]
	str	r8, [r4, #688]
	ldr	ip, [r3, #2004]
	str	ip, [r4, #716]
	ldr	r3, [r3, #2008]
	str	r3, [r4, #752]
	bl	memcpy
	mov	r2, #1
	mov	r3, #2
	str	r8, [r4, #724]
	str	r8, [r4, #760]
	strb	r7, [r4, #703]
	strb	r7, [r4, #739]
	strb	r6, [r4, #702]
	strb	r6, [r4, #738]
	strb	r5, [r4, #701]
	strb	r5, [r4, #737]
	str	r4, [r4, #704]
	str	r4, [r4, #740]
	strb	r2, [r4, #700]
	strb	r3, [r4, #736]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L568:
	strb	r2, [r4, #700]
	mov	r5, #0
	str	r4, [r4, #704]
	ldrb	ip, [r3, #1372]
	strb	ip, [r4, #701]
	ldrb	ip, [r3, #1373]
	strb	ip, [r4, #702]
	ldr	ip, [r3, #2004]
	str	ip, [r4, #716]
	ldrb	ip, [r3, #1380]
	strb	ip, [r4, #703]
	ldr	lr, [r3, #2028]
	str	r5, [r4, #40]
	str	lr, [r4, #724]
	ldrb	r6, [r3, #1369]
	cmp	r6, r5
	beq	.L588
	ldr	r2, [r4, #760]
	mov	r6, #3
	strb	r6, [r4, #2]
	add	r3, r3, #1952
	add	lr, lr, r2
	str	lr, [r4, #44]
	str	lr, [r4, #688]
	mvn	r7, #0
	ldrb	r2, [r3, #-577]
	mvn	r6, #0
	cmp	r2, #1
	orreq	r5, r1, #1
	strb	r5, [r4, #4]
	ldrd	r8, [r3]
	cmp	r9, r7
	cmpeq	r8, r6
	beq	.L573
	add	r1, r4, #640
	ldrd	r2, [r1]
	cmp	r3, r7
	cmpeq	r2, r6
	streqd	r8, [r1]
.L573:
	ldrb	r3, [r4, #739]
	b	.L584
.L586:
	strb	r2, [r4, #2]
	add	r1, r0, #13632
	str	lr, [r4, #44]
	add	r1, r1, #40
	str	lr, [r4, #688]
	add	r0, r4, #72
	ldrb	r3, [r3, #1375]
	mov	r2, #592
	cmp	r3, #1
	moveq	r5, #2
	strb	r5, [r4, #4]
	bl	memcpy
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L588:
	strb	r2, [r4, #2]
	add	r1, r3, #1376
	str	lr, [r4, #44]
	add	r1, r1, #8
	str	lr, [r4, #688]
	add	r0, r4, #72
	ldrb	r3, [r3, #1375]
	mov	r2, #592
	sub	r3, r3, #1
	clz	r3, r3
	mov	r3, r3, lsr #5
	strb	r3, [r4, #4]
	bl	memcpy
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L587:
	strd	r8, [r1]
	b	.L577
	.fnend
	.size	MVC_UpdateCurrFrameInfo, .-MVC_UpdateCurrFrameInfo
	.align	2
	.global	MVC_SimpleSlideDPB
	.type	MVC_SimpleSlideDPB, %function
MVC_SimpleSlideDPB:
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
	add	r3, r0, #11075584
	add	r3, r3, #45056
	mov	r7, r0
	ldr	r5, [r3, #2728]
	ldr	r3, [r3, #2732]
	cmp	r3, r5
	addcc	r6, r0, #11141120
	bcc	.L590
	cmp	r5, #0
	beq	.L595
	movw	ip, #47588
	add	r6, r0, #11141120
	movt	ip, 169
	mov	r1, #0
	add	r8, r6, #12288
	add	ip, r0, ip
	mov	r3, r1
	mvn	r4, #-2147483648
.L593:
	ldr	r2, [ip, #4]!
	cmp	r2, #0
	beq	.L592
	ldr	lr, [r2, #64]
	cmp	r4, lr
	bls	.L592
	ldr	r0, [r2, #56]
	ldr	r2, [r8, #2056]
	cmp	r0, r2
	moveq	r4, lr
	moveq	r1, r3
.L592:
	add	r3, r3, #1
	cmp	r3, r5
	bne	.L593
	mov	r5, r1
.L591:
	movw	r3, #28282
	mov	r0, r7
	movt	r3, 42
	add	r3, r1, r3
	ldr	r1, [r7, r3, asl #2]
	bl	MVC_UnMarkFrameStoreRef
	mov	r1, r5
	mov	r0, r7
	bl	MVC_RemoveFrameStoreOutDPB
.L590:
	add	r3, r6, #12288
	mov	r1, #0
	ldr	r2, [r3, #1992]
	strb	r1, [r3, #1372]
	cmp	r2, r1
	movne	r2, #1
	strneb	r2, [r3, #1373]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L595:
	add	r6, r0, #11141120
	mov	r1, r5
	b	.L591
	.fnend
	.size	MVC_SimpleSlideDPB, .-MVC_SimpleSlideDPB
	.align	2
	.global	MVC_ReleaseNAL
	.type	MVC_ReleaseNAL, %function
MVC_ReleaseNAL:
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
	subs	r5, r1, #0
	mov	r6, r0
	beq	.L614
	add	r7, r5, #56
	mov	r4, r5
	mov	r3, #0
	strb	r3, [r5, #1]
	strb	r3, [r5, #3]
.L609:
	ldr	r3, [r4, #8]
	mov	r0, r6
	cmp	r3, #0
	beq	.L608
	ldr	r1, [r4, #32]
	bl	SM_ReleaseStreamSeg
	ldr	r3, [r4, #12]
	ldr	r2, [r4, #8]
	mov	r0, #7
	ldr	r1, .L615
	bl	dprint_vfmw
	mov	r3, #0
	str	r3, [r4, #8]
	str	r3, [r4, #24]
	str	r3, [r4, #12]
.L608:
	add	r4, r4, #28
	cmp	r4, r7
	bne	.L609
	mov	r3, #0
	strb	r3, [r5]
	str	r3, [r5, #68]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L614:
	mov	r0, r5
	movw	r3, #4036
	ldr	r2, .L615+4
	ldr	r1, .L615+8
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L616:
	.align	2
.L615:
	.word	.LC21
	.word	.LC13
	.word	.LC14
	.fnend
	.size	MVC_ReleaseNAL, .-MVC_ReleaseNAL
	.align	2
	.global	MVC_ClearCurrNal
	.type	MVC_ClearCurrNal, %function
MVC_ClearCurrNal:
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
	ldr	r1, [r0, #232]
	mov	r4, r0
	cmp	r1, #0
	beq	.L618
	ldr	r0, [r0, #120]
	bl	MVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #232]
.L618:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	MVC_ClearCurrNal, .-MVC_ClearCurrNal
	.align	2
	.global	MVC_ClearCurrSlice
	.type	MVC_ClearCurrSlice, %function
MVC_ClearCurrSlice:
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
	ldr	r1, .L627
	mov	r4, r0
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r1, [r4, #232]
	cmp	r1, #0
	beq	.L623
	ldr	r0, [r4, #120]
	bl	MVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #232]
.L623:
	ldr	r3, [r4, #80]
	mov	r0, #0
	add	r3, r3, #1
	str	r3, [r4, #80]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L628:
	.align	2
.L627:
	.word	.LC22
	.fnend
	.size	MVC_ClearCurrSlice, .-MVC_ClearCurrSlice
	.align	2
	.global	MVC_ClearAllNal
	.type	MVC_ClearAllNal, %function
MVC_ClearAllNal:
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
	add	r4, r0, #936
	add	r5, r0, #12992
	b	.L631
.L630:
	add	r4, r4, #88
	cmp	r4, r5
	beq	.L633
.L631:
	ldrb	r3, [r4, #1]
	cmp	r3, #1
	bne	.L630
	mov	r1, r4
	ldr	r0, [r6, #120]
	add	r4, r4, #88
	bl	MVC_ReleaseNAL
	cmp	r4, r5
	bne	.L631
.L633:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	MVC_ClearAllNal, .-MVC_ClearAllNal
	.align	2
	.global	MVC_ClearAllSlice
	.type	MVC_ClearAllSlice, %function
MVC_ClearAllSlice:
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
	movw	r4, #15072
	add	r5, r0, #11141120
	movt	r4, 170
	add	r5, r5, #15616
	add	r4, r0, r4
	mov	r6, r0
	mov	r7, #0
.L636:
	ldr	r1, [r4, #4]!
	cmp	r1, #0
	beq	.L635
	ldr	r0, [r6, #120]
	bl	MVC_ReleaseNAL
	str	r7, [r4]
.L635:
	cmp	r4, r5
	bne	.L636
	mov	r0, #0
	str	r0, [r6, #64]
	str	r0, [r6, #104]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	MVC_ClearAllSlice, .-MVC_ClearAllSlice
	.align	2
	.global	MVC_ClearCurrPic
	.type	MVC_ClearCurrPic, %function
MVC_ClearCurrPic:
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
	bl	MVC_ClearAllSlice
	ldr	r0, [r4, #40]
	add	r3, r4, #11075584
	mov	r2, #0
	add	r3, r3, #40960
	movw	r1, #23352
	movt	r1, 1
	str	r0, [r3, #2540]
	mov	r0, #2
	str	r1, [r3, #2544]
	mov	r1, #7
	strb	r0, [r3, #2529]
	mov	r0, #32
	strb	r1, [r3, #2531]
	mov	r1, #3
	strb	r0, [r3, #2530]
	mvn	r0, #0
	str	r1, [r3, #2552]
	mov	r1, #262144
	str	r0, [r3, #2556]
	mov	r0, r2
	str	r1, [r3, #2568]
	strb	r2, [r3, #2528]
	str	r2, [r3, #2560]
	str	r2, [r3, #2564]
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	MVC_ClearCurrPic, .-MVC_ClearCurrPic
	.align	2
	.global	MVC_ArrangeVahbMem
	.type	MVC_ArrangeVahbMem, %function
MVC_ArrangeVahbMem:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #44
	sub	sp, sp, #44
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r3, .L650
	mov	r5, r1
	mov	r6, r2
	mov	r4, r0
	mov	r2, #32
	sub	r0, fp, #60
	ldr	r3, [r3, #48]
	mov	r1, #0
	blx	r3
	ldr	r3, [r4, #224]
	str	r6, [fp, #-32]
	mov	r0, #0
	str	r5, [fp, #-52]
	ldr	r3, [r3, #28]
	str	r6, [fp, #-48]
	cmp	r3, #24
	str	r5, [fp, #-44]
	str	r6, [fp, #-40]
	str	r5, [fp, #-36]
	strb	r0, [fp, #-60]
	strb	r0, [fp, #-59]
	beq	.L643
	add	r2, r4, #11075584
	ldrb	r3, [fp, #4]
	add	r2, r2, #45056
	mov	r1, #5
	strb	r0, [fp, #-56]
	ldr	r2, [r2, #2728]
	strb	r1, [fp, #-55]
	add	r2, r2, #3
	strb	r2, [fp, #-57]
.L647:
	sub	r1, fp, #60
	ldr	r0, [r4, #120]
	strb	r3, [fp, #-54]
	mov	r5, #0
	strb	r5, [fp, #-58]
	bl	FSP_ConfigInstance
	subs	r6, r0, #0
	bne	.L644
	ldr	r1, [r4, #224]
	sub	r3, fp, #64
	ldr	r0, [r4, #120]
	ldr	r2, [r1, #24]
	ldr	r1, [r1, #20]
	bl	FSP_ConfigFrameBuf
	cmp	r0, r5
	moveq	r0, #1
	bne	.L649
.L648:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L643:
	mov	r3, #1
	mov	r2, #5
	strb	r0, [fp, #-56]
	strb	r3, [fp, #-57]
	strb	r2, [fp, #-55]
	b	.L647
.L644:
	mov	r0, r5
	ldr	r1, .L650+4
	bl	dprint_vfmw
	mvn	r0, #19
	b	.L648
.L649:
	mov	r0, r6
	ldr	r1, .L650+8
	bl	dprint_vfmw
	mvn	r0, #19
	b	.L648
.L651:
	.align	2
.L650:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC24
	.word	.LC23
	.fnend
	.size	MVC_ArrangeVahbMem, .-MVC_ArrangeVahbMem
	.align	2
	.global	MVC_RepairList
	.type	MVC_RepairList, %function
MVC_RepairList:
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
	add	r3, r0, #11075584
	add	r3, r3, #40960
	mov	r7, r0
	ldrb	r3, [r3, #872]
	cmp	r3, #1
	beq	.L654
	bcc	.L669
	cmp	r3, #2
	bne	.L675
.L670:
	mov	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L666:
	mov	r0, r7
.L675:
	bl	MVC_ClearCurrSlice
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L654:
	mov	r0, #2
.L655:
	movw	r6, #41876
	add	r8, r7, #11141120
	movt	r6, 169
	add	r6, r7, r6
	add	r8, r8, #12288
	add	r5, r7, #256
	ldr	r2, [r6, #4]!
	mov	lr, r7
	mov	r4, #0
	mov	r9, #1
	cmp	r2, #0
	beq	.L657
.L677:
	ldr	r10, [lr, #256]
	cmp	r10, #0
	bne	.L671
	mov	ip, r5
	mov	r3, r10
	b	.L659
.L660:
	ldr	r1, [ip, #4]!
	cmp	r1, #0
	bne	.L662
.L659:
	add	r3, r3, #1
	cmp	r3, r2
	bne	.L660
	ldr	r3, [r7, #224]
	ldr	r3, [r3, #12]
	cmp	r3, #2
	bne	.L666
	ldr	r1, [r8, #1976]
	add	r1, r1, #664
.L662:
	mov	ip, r5
	mov	r3, #0
	b	.L668
.L664:
	ldr	r10, [ip, #4]!
.L668:
	add	r3, r3, #1
	cmp	r10, #0
	streq	r1, [ip]
	cmp	r3, r2
	bne	.L664
.L665:
	add	r4, r4, #1
	add	r5, r5, #132
	cmp	r0, r4
	add	lr, lr, #132
	bls	.L670
	ldr	r2, [r6, #4]!
	cmp	r2, #0
	bne	.L677
.L657:
	ldr	r3, [r7, #224]
	ldr	r3, [r3, #12]
	cmp	r3, #2
	bne	.L666
	str	r9, [r6]
	ldr	r3, [r8, #1976]
	add	r3, r3, #664
	str	r3, [lr, #256]
	b	.L665
.L671:
	mov	r1, r10
	b	.L662
.L669:
	mov	r0, #1
	b	.L655
	.fnend
	.size	MVC_RepairList, .-MVC_RepairList
	.align	2
	.global	MVC_GetShortTermPicPoint
	.type	MVC_GetShortTermPicPoint, %function
MVC_GetShortTermPicPoint:
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
	add	r3, r0, #11075584
	add	r2, r3, #40960
	ldrb	r4, [r2, #873]
	cmp	r4, #0
	beq	.L679
	ldrb	r2, [r2, #874]
	cmp	r2, #0
	movne	r4, #2
	moveq	r4, #1
.L679:
	add	r3, r3, #45056
	ldr	r5, [r3, #2736]
	cmp	r5, #0
	beq	.L687
	movw	r3, #47656
	mov	r2, #0
	movt	r3, 169
	add	r3, r0, r3
	b	.L684
.L697:
	ldrb	ip, [r0, #3]
	cmp	ip, #3
	beq	.L695
.L682:
	add	r2, r2, #1
	add	r3, r3, #4
	cmp	r2, r5
	beq	.L696
.L684:
	cmp	r4, #0
	ldr	r0, [r3]
	beq	.L697
	ldrb	lr, [r0, #3]
	tst	lr, #1
	beq	.L683
	ldr	ip, [r0, #700]
	bic	ip, ip, #-16777216
	bic	ip, ip, #255
	cmp	ip, #65536
	beq	.L698
.L683:
	tst	lr, #2
	beq	.L682
	ldr	ip, [r0, #736]
	bic	ip, ip, #-16777216
	bic	ip, ip, #255
	cmp	ip, #65536
	bne	.L682
	ldr	ip, [r0, #748]
	cmp	ip, r1
	bne	.L682
	add	r0, r0, #736
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L695:
	ldr	ip, [r0, #664]
	bic	ip, ip, #-16777216
	bic	ip, ip, #255
	cmp	ip, #65536
	bne	.L682
	ldr	ip, [r0, #676]
	cmp	ip, r1
	bne	.L682
	add	r0, r0, #664
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L698:
	ldr	ip, [r0, #712]
	cmp	ip, r1
	bne	.L683
	add	r0, r0, #700
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L696:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L687:
	mov	r0, r5
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	MVC_GetShortTermPicPoint, .-MVC_GetShortTermPicPoint
	.align	2
	.global	MVC_GetLongTermPicPoint
	.type	MVC_GetLongTermPicPoint, %function
MVC_GetLongTermPicPoint:
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
	add	r3, r0, #11075584
	add	r2, r3, #40960
	ldrb	r4, [r2, #873]
	cmp	r4, #0
	beq	.L700
	ldrb	r2, [r2, #874]
	cmp	r2, #0
	movne	r4, #2
	moveq	r4, #1
.L700:
	add	r3, r3, #45056
	ldr	r5, [r3, #2740]
	cmp	r5, #0
	beq	.L708
	movw	r3, #47720
	mov	r2, #0
	movt	r3, 169
	add	r3, r0, r3
	b	.L705
.L718:
	ldrb	ip, [r0, #3]
	cmp	ip, #3
	beq	.L716
.L703:
	add	r2, r2, #1
	add	r3, r3, #4
	cmp	r2, r5
	beq	.L717
.L705:
	cmp	r4, #0
	ldr	r0, [r3]
	beq	.L718
	ldrb	lr, [r0, #3]
	tst	lr, #1
	beq	.L704
	ldr	ip, [r0, #700]
	bic	ip, ip, #-16777216
	bic	ip, ip, #255
	cmp	ip, #256
	beq	.L719
.L704:
	tst	lr, #2
	beq	.L703
	ldr	ip, [r0, #736]
	bic	ip, ip, #-16777216
	bic	ip, ip, #255
	cmp	ip, #256
	bne	.L703
	ldr	ip, [r0, #744]
	cmp	ip, r1
	bne	.L703
	add	r0, r0, #736
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L716:
	ldr	ip, [r0, #664]
	bic	ip, ip, #-16777216
	bic	ip, ip, #255
	cmp	ip, #256
	bne	.L703
	ldr	ip, [r0, #672]
	cmp	ip, r1
	bne	.L703
	add	r0, r0, #664
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L719:
	ldr	ip, [r0, #708]
	cmp	ip, r1
	bne	.L704
	add	r0, r0, #700
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L717:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L708:
	mov	r0, r5
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	MVC_GetLongTermPicPoint, .-MVC_GetLongTermPicPoint
	.align	2
	.global	MVC_ReorderSTList
	.type	MVC_ReorderSTList, %function
MVC_ReorderSTList:
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
	mov	ip, r1, asl #7
	ldr	r7, [fp, #4]
	add	r6, ip, r1, lsl #2
	add	r6, r6, #256
	mov	r1, r3
	mov	r5, r3
	mov	r8, r2
	add	r6, r0, r6
	bl	MVC_GetShortTermPicPoint
	ldr	r4, [r7]
	add	r2, r8, #1
	ldr	r3, [fp, #8]
	cmp	r2, r4
	ble	.L721
	add	lr, r6, r2, lsl #2
	mov	ip, r2
.L722:
	ldr	r4, [lr, #-4]!
	sub	ip, ip, #1
	str	r4, [lr, #4]
	ldr	r4, [r7]
	cmp	r4, ip
	blt	.L722
.L721:
	add	r1, r4, #1
	str	r1, [r7]
	str	r0, [r6, r4, asl #2]
	ldr	ip, [r7]
	cmp	r2, ip
	ldmltfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	add	r4, r6, ip, lsl #2
	mov	lr, ip
	b	.L726
.L725:
	str	r0, [r6, lr, asl #2]
	add	lr, lr, #1
.L724:
	cmp	r2, ip
	blt	.L734
.L726:
	ldr	r0, [r4], #4
	add	ip, ip, #1
	cmp	r0, #0
	beq	.L724
	ldrb	r1, [r0, #1]
	cmp	r1, #0
	bne	.L725
	ldr	r1, [r0, #12]
	cmp	r1, r5
	bne	.L725
	ldr	r1, [r0, #4]
	ldr	r1, [r1, #56]
	cmp	r1, r3
	bne	.L725
	cmp	r2, ip
	bge	.L726
.L734:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	MVC_ReorderSTList, .-MVC_ReorderSTList
	.align	2
	.global	MVC_ReorderLTList
	.type	MVC_ReorderLTList, %function
MVC_ReorderLTList:
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
	mov	ip, r1, asl #7
	ldr	r7, [fp, #4]
	add	r6, ip, r1, lsl #2
	add	r6, r6, #256
	mov	r1, r3
	mov	r5, r3
	mov	r8, r2
	add	r6, r0, r6
	bl	MVC_GetLongTermPicPoint
	ldr	r4, [r7]
	add	r2, r8, #1
	ldr	r3, [fp, #8]
	cmp	r2, r4
	ble	.L736
	add	lr, r6, r2, lsl #2
	mov	ip, r2
.L737:
	ldr	r4, [lr, #-4]!
	sub	ip, ip, #1
	str	r4, [lr, #4]
	ldr	r4, [r7]
	cmp	r4, ip
	blt	.L737
.L736:
	add	r1, r4, #1
	str	r1, [r7]
	str	r0, [r6, r4, asl #2]
	ldr	ip, [r7]
	cmp	r2, ip
	ldmltfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	add	r4, r6, ip, lsl #2
	mov	lr, ip
	b	.L741
.L740:
	str	r0, [r6, lr, asl #2]
	add	lr, lr, #1
.L739:
	cmp	r2, ip
	blt	.L752
.L741:
	ldr	r0, [r4], #4
	add	ip, ip, #1
	cmp	r0, #0
	beq	.L739
	ldrb	r1, [r0, #1]
	cmp	r1, #0
	beq	.L740
	ldr	r1, [r0, #8]
	cmp	r1, r5
	bne	.L740
	ldr	r1, [r0, #4]
	ldr	r1, [r1, #56]
	cmp	r1, r3
	bne	.L740
	cmp	r2, ip
	bge	.L741
.L752:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	MVC_ReorderLTList, .-MVC_ReorderLTList
	.align	2
	.global	MVC_GetMaxViewIdx
	.type	MVC_GetMaxViewIdx, %function
MVC_GetMaxViewIdx:
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
	add	ip, r0, #10747904
	add	ip, ip, #20480
	movw	lr, #22868
	movt	lr, 164
	add	lr, r0, lr
	ldr	r5, [ip, #2384]
	adds	r5, r5, #1
	beq	.L760
	ldr	ip, [ip, #2388]
	cmp	r1, ip
	beq	.L761
	mov	r6, r5
	mov	ip, #0
	b	.L755
.L757:
	ldr	r4, [lr, #4]!
	cmp	r1, r4
	beq	.L763
.L755:
	add	ip, ip, #1
	cmp	ip, r5
	bne	.L757
	cmp	r6, #0
	blt	.L764
.L754:
	cmp	r2, #0
	add	r6, r6, r3, lsl #1
	movwne	r3, #5718
	movweq	r3, #5726
	movt	r3, 41
	add	r3, r6, r3
	add	r0, r0, r3, lsl #2
	ldr	r0, [r0, #4]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L763:
	mov	r6, ip
	cmp	r6, #0
	bge	.L754
.L764:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L760:
	mov	r6, r5
	b	.L754
.L761:
	mov	r6, #0
	b	.L754
	.fnend
	.size	MVC_GetMaxViewIdx, .-MVC_GetMaxViewIdx
	.align	2
	.global	mvc_get_inter_view_pic
	.type	mvc_get_inter_view_pic, %function
mvc_get_inter_view_pic:
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
	movw	ip, #27254
	movt	ip, 42
	add	ip, r3, ip
	mov	r4, #1552
	ldr	lr, [r0, ip, asl #2]
	movw	ip, #31360
	mla	r3, r4, r3, r0
	cmp	lr, #0
	movt	ip, 169
	add	ip, r3, ip
	beq	.L771
	add	r4, r0, #11141120
	mov	r3, #0
	mov	r0, ip
	add	r4, r4, #12288
	b	.L770
.L767:
	cmp	r3, lr
	add	r0, r0, #776
	beq	.L773
.L770:
	ldr	ip, [r0, #56]
	add	r3, r3, #1
	cmp	ip, r1
	bne	.L767
	ldrb	ip, [r4, #1371]
	cmp	ip, #0
	bne	.L768
	ldr	ip, [r0, #684]
	cmp	ip, r2
	bne	.L767
	add	r0, r0, #664
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L768:
	cmp	ip, #1
	beq	.L774
	cmp	ip, #2
	bne	.L767
	ldr	ip, [r0, #756]
	cmp	ip, r2
	bne	.L767
	add	r0, r0, #736
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L774:
	ldr	ip, [r0, #720]
	cmp	ip, r2
	bne	.L767
	add	r0, r0, #700
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L773:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L771:
	mov	r0, lr
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	mvc_get_inter_view_pic, .-mvc_get_inter_view_pic
	.align	2
	.global	mvc_reorder_interview
	.type	mvc_reorder_interview, %function
mvc_reorder_interview:
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
	ldr	r4, [fp, #8]
	ldr	r6, [fp, #4]
	mov	r7, r2
	mov	r5, r3
	mov	r8, r1
	mov	r2, r4, asl #7
	mov	r1, r3
	mov	r3, r4
	add	r4, r2, r4, lsl #2
	add	r4, r4, #256
	mov	r2, r6
	add	r4, r0, r4
	bl	mvc_get_inter_view_pic
	cmp	r0, #0
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	ldr	r3, [r7]
	add	r1, r8, #1
	cmp	r1, r3
	bls	.L777
	add	lr, r4, r1, lsl #2
	mov	ip, r1
.L778:
	ldr	r3, [lr, #-4]!
	sub	ip, ip, #1
	str	r3, [lr, #4]
	ldr	r3, [r7]
	cmp	r3, ip
	bcc	.L778
.L777:
	add	r2, r3, #1
	str	r2, [r7]
	str	r0, [r4, r3, asl #2]
	ldr	ip, [r7]
	cmp	r1, ip
	ldmccfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	add	r3, r4, ip, lsl #2
	mov	lr, ip
	b	.L782
.L780:
	cmp	r1, ip
	str	r0, [r4, lr, asl #2]
	add	lr, lr, #1
	bcc	.L789
.L782:
	ldr	r0, [r3], #4
	add	ip, ip, #1
	cmp	r0, #0
	beq	.L780
	ldr	r2, [r0, #4]
	ldr	r2, [r2, #56]
	cmp	r2, r5
	bne	.L780
	ldr	r2, [r0, #20]
	cmp	r2, r6
	bne	.L780
	cmp	r1, ip
	bcs	.L782
.L789:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	mvc_reorder_interview, .-mvc_reorder_interview
	.align	2
	.global	MVC_ReorderRefPiclist
	.type	MVC_ReorderRefPiclist, %function
MVC_ReorderRefPiclist:
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
	add	r9, r0, #11075584
	str	r2, [fp, #-64]
	add	r9, r9, #40960
	mov	r2, #0
	mov	r5, r0
	mov	r10, r1
	ldrb	r3, [r9, #873]
	str	r2, [fp, #-48]
	cmp	r3, r2
	beq	.L791
	ldrb	r3, [r9, #874]
	cmp	r3, r2
	movne	r3, #2
	moveq	r3, #1
.L791:
	cmp	r10, #1
	bls	.L840
.L790:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L840:
	ldr	r0, [r5, #236]
	cmp	r10, #0
	movweq	r1, #40784
	movweq	r8, #41048
	movweq	r2, #41312
	movweq	r7, #41568
	movwne	r1, #40916
	movwne	r8, #41180
	movwne	r2, #41440
	movwne	r7, #41700
	cmp	r3, #0
	ldr	r3, [r0, #2896]
	movt	r2, 169
	add	r2, r5, r2
	add	r3, r3, #4
	str	r2, [fp, #-100]
	mov	r2, #1
	movt	r1, 169
	mov	r3, r2, asl r3
	str	r3, [fp, #-88]
	ldr	r3, [r9, #900]
	movt	r8, 169
	ldrne	r2, [fp, #-88]
	movt	r7, 169
	add	r1, r5, r1
	add	r8, r5, r8
	movne	r3, r3, asl #1
	add	r7, r5, r7
	addne	r3, r3, #1
	str	r3, [fp, #-92]
	ldr	r3, [fp, #-64]
	movne	r2, r2, asl #1
	strne	r2, [fp, #-88]
	adds	r3, r3, #2
	str	r3, [fp, #-72]
	beq	.L790
	ldr	r2, [r1]
	cmp	r2, #3
	beq	.L790
	movw	r3, #22868
	str	r9, [fp, #-68]
	mov	r0, r3
	mov	r3, #0
	mov	r4, r3
	str	r3, [fp, #-76]
	str	r3, [fp, #-80]
	mov	r6, r3
	ldr	r3, [fp, #-92]
	movt	r0, 164
	mov	r9, r1
	add	r0, r5, r0
	str	r0, [fp, #-96]
	str	r3, [fp, #-60]
	mov	r3, #1
	str	r3, [fp, #-84]
	b	.L798
.L799:
	cmp	r2, #2
	beq	.L841
	ldr	r3, [fp, #-84]
	cmp	r3, #1
	beq	.L805
	ldr	r3, [fp, #-68]
	ldrb	r3, [r3, #881]
	str	r3, [fp, #-56]
	mov	r3, r10, asl #1
.L806:
	cmp	r2, #4
	ldr	r2, [r7]
	beq	.L842
	add	r2, r2, #1
	add	r4, r2, r4
	ldr	r2, [fp, #-76]
	cmp	r2, r4
	rsble	r4, r2, r4
.L816:
	ldr	r2, [fp, #-56]
	add	r0, r5, #11141120
	add	r0, r0, #12288
	ldr	r1, [fp, #-64]
	cmp	r2, #0
	ldr	r2, [fp, #-80]
	add	r3, r3, r2
	movwne	r2, #5722
	add	r3, r3, r4
	movweq	r2, #5730
	movt	r2, 41
	add	r2, r3, r2
	add	r2, r5, r2, lsl #2
	ldr	r3, [r2, #4]
	sub	r2, fp, #48
	str	r10, [sp, #4]
	ldr	ip, [r0, #1996]
	mov	r0, r5
	str	ip, [sp]
	bl	mvc_reorder_interview
.L803:
	ldr	r3, [fp, #-72]
	add	r6, r6, #1
	cmp	r6, r3
	beq	.L790
	ldr	r2, [r9, #4]!
	add	r7, r7, #4
	add	r8, r8, #4
	cmp	r2, #3
	beq	.L790
.L798:
	cmp	r2, #1
	bhi	.L799
	cmp	r2, #0
	ldr	r3, [r8]
	bne	.L800
	ldr	r2, [fp, #-60]
	mvn	r3, r3
	adds	r3, r2, r3
	str	r3, [fp, #-60]
	bmi	.L843
.L801:
	ldr	r2, [fp, #-60]
	mov	r1, r10
	ldr	r3, [fp, #-92]
	mov	r0, r5
	cmp	r3, r2
	movlt	r3, r2
	ldrlt	r2, [fp, #-88]
	ldrge	r3, [fp, #-60]
	rsblt	r3, r2, r3
	ldr	r2, [fp, #-68]
	ldr	ip, [r2, #2512]
	sub	r2, fp, #48
	str	r2, [sp]
	ldr	r2, [fp, #-64]
	str	ip, [sp, #4]
	bl	MVC_ReorderSTList
	b	.L803
.L842:
	mvn	r2, r2
	adds	r4, r2, r4
	ldrmi	r2, [fp, #-76]
	addmi	r4, r4, r2
	b	.L816
.L805:
	add	r3, r5, #10747904
	ldr	r1, [fp, #-68]
	add	r3, r3, #20480
	ldr	ip, [r3, #2384]
	ldr	r1, [r1, #2512]
	adds	ip, ip, #1
	beq	.L807
	ldr	r3, [r3, #2388]
	cmp	r1, r3
	beq	.L808
	ldr	r0, [fp, #-96]
	mov	r3, #0
	str	ip, [fp, #-80]
	b	.L809
.L811:
	ldr	lr, [r0, #4]!
	cmp	r1, lr
	beq	.L825
.L809:
	add	r3, r3, #1
	cmp	r3, ip
	bne	.L811
.L810:
	ldr	r3, [fp, #-68]
	mov	r4, ip
	ldr	r0, [fp, #-96]
	ldrb	r3, [r3, #881]
	str	r3, [fp, #-56]
	mov	r3, #0
	b	.L821
.L813:
	ldr	lr, [r0, #4]!
	cmp	r1, lr
	beq	.L826
.L821:
	add	r3, r3, #1
	cmp	r3, ip
	bne	.L813
	cmp	r4, #0
	blt	.L827
.L820:
	ldr	r3, [fp, #-56]
	cmp	r3, #0
	mov	r3, r10, asl #1
	beq	.L814
	add	r4, r3, r4
	movw	r1, #5718
	movt	r1, 41
	add	r1, r4, r1
	mov	r0, #0
	str	r0, [fp, #-84]
	add	r1, r5, r1, lsl #2
	mvn	r4, #0
	ldr	r1, [r1, #4]
	str	r1, [fp, #-76]
	b	.L806
.L800:
	ldr	r2, [fp, #-60]
	add	r3, r3, #1
	add	r3, r2, r3
	ldr	r2, [fp, #-88]
	str	r3, [fp, #-60]
	cmp	r2, r3
	rsble	r3, r2, r3
	strle	r3, [fp, #-60]
	b	.L801
.L841:
	ldr	r1, [fp, #-68]
	sub	r0, fp, #48
	ldr	r3, [fp, #-100]
	ldr	r2, [fp, #-64]
	ldr	ip, [r1, #2512]
	mov	r1, r10
	ldr	r3, [r3, r6, asl #2]
	str	r0, [sp]
	mov	r0, r5
	str	ip, [sp, #4]
	bl	MVC_ReorderLTList
	b	.L803
.L825:
	str	r3, [fp, #-80]
	b	.L810
.L826:
	mov	r4, r3
	cmp	r4, #0
	bge	.L820
.L827:
	mov	r3, #0
	mvn	r4, #0
	mov	r1, r3
	str	r3, [fp, #-84]
	str	r1, [fp, #-76]
	mov	r3, r10, asl #1
	b	.L806
.L814:
	add	r4, r3, r4
	movw	r1, #5726
	movt	r1, 41
	add	r1, r4, r1
	ldr	r0, [fp, #-56]
	mvn	r4, #0
	add	r1, r5, r1, lsl #2
	str	r0, [fp, #-84]
	ldr	r1, [r1, #4]
	str	r1, [fp, #-76]
	b	.L806
.L843:
	ldr	r2, [fp, #-88]
	add	r3, r3, r2
	str	r3, [fp, #-60]
	b	.L801
.L807:
	ldr	r3, [fp, #-68]
	mov	r4, ip
	str	ip, [fp, #-80]
	ldrb	r3, [r3, #881]
	str	r3, [fp, #-56]
	b	.L820
.L808:
	ldr	r1, [fp, #-68]
	mov	r3, #0
	mov	r4, r3
	str	r3, [fp, #-80]
	ldrb	r1, [r1, #881]
	str	r1, [fp, #-56]
	b	.L820
	.fnend
	.size	MVC_ReorderRefPiclist, .-MVC_ReorderRefPiclist
	.align	2
	.global	MVC_ReorderListX
	.type	MVC_ReorderListX, %function
MVC_ReorderListX:
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
	add	r4, r0, #11075584
	add	r5, r4, #40960
	mov	r6, r0
	ldrb	r1, [r5, #872]
	cmp	r1, #2
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	add	r7, r4, #36864
	ldrb	r3, [r7, #3916]
	cmp	r3, #0
	bne	.L856
.L847:
	ldr	r3, [r5, #932]
	cmp	r1, #1
	add	r3, r3, #1
	str	r3, [r5, #920]
	ldmnefd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldrb	r3, [r7, #3917]
	cmp	r3, #0
	bne	.L857
.L849:
	add	r4, r4, #40960
	ldr	r3, [r4, #936]
	add	r3, r3, #1
	str	r3, [r4, #924]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L856:
	mov	r1, #0
	ldr	r2, [r5, #932]
	bl	MVC_ReorderRefPiclist
	ldrb	r1, [r5, #872]
	b	.L847
.L857:
	ldr	r2, [r5, #936]
	mov	r0, r6
	bl	MVC_ReorderRefPiclist
	b	.L849
	.fnend
	.size	MVC_ReorderListX, .-MVC_ReorderListX
	.align	2
	.global	MVC_GenPiclistfromFrmlist
	.type	MVC_GenPiclistfromFrmlist, %function
MVC_GenPiclistfromFrmlist:
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
	cmp	r2, #31
	ldr	r6, [fp, #8]
	ldr	lr, .L921
	mov	r7, r1
	ldr	ip, .L921+4
	movcc	r4, r2
	movcs	r4, #31
	cmp	r6, #0
	str	r3, [fp, #-52]
	movne	r6, lr
	moveq	r6, ip
	cmp	r0, #1
	moveq	r5, #0
	moveq	r10, r5
	beq	.L861
	cmp	r0, #2
	moveq	r5, #0
	moveq	r10, r5
	bne	.L869
.L870:
	cmp	r10, r4
	movcs	r3, #0
	movcc	r3, #1
	cmp	r5, r4
	str	r3, [fp, #-48]
	movcs	r2, #0
	movcc	r2, #1
	orrs	r3, r2, r3
	beq	.L869
	cmp	r2, #0
	beq	.L875
	add	r8, r7, r5, lsl #2
	b	.L874
.L871:
	add	r5, r5, #1
	cmp	r4, r5
	bls	.L875
.L874:
	mov	r9, r8
	ldr	r0, [r8], #4
	ldrb	ip, [r0, #2]
	tst	ip, #2
	beq	.L871
	add	r0, r0, #736
	blx	r6
	cmp	r0, #0
	beq	.L871
	ldr	r3, [fp, #4]
	add	r5, r5, #1
	ldr	r2, [r9]
	ldr	r0, [r3]
	add	r2, r2, #736
	ldr	r3, [fp, #-52]
	str	r2, [r3, r0, asl #2]
	ldr	r3, [fp, #4]
	ldr	r2, [r3]
	add	r2, r2, #1
	str	r2, [r3]
.L875:
	ldr	r3, [fp, #-48]
	cmp	r3, #0
	addne	r8, r7, r10, lsl #2
	bne	.L877
	b	.L870
.L876:
	add	r10, r10, #1
	cmp	r4, r10
	bls	.L870
.L877:
	mov	r9, r8
	ldr	r0, [r8], #4
	ldrb	r2, [r0, #2]
	tst	r2, #1
	beq	.L876
	add	r0, r0, #700
	blx	r6
	cmp	r0, #0
	beq	.L876
	ldr	r3, [fp, #4]
	add	r10, r10, #1
	ldr	r2, [r9]
	ldr	r0, [r3]
	add	r2, r2, #700
	ldr	r3, [fp, #-52]
	str	r2, [r3, r0, asl #2]
	ldr	r3, [fp, #4]
	ldr	r2, [r3]
	add	r2, r2, #1
	str	r2, [r3]
	b	.L870
.L920:
	add	r0, r0, #700
	blx	r6
	cmp	r0, #0
	beq	.L862
	ldr	r3, [fp, #4]
	add	r10, r10, #1
	ldr	r2, [r8]
	ldr	r0, [r3]
	add	r2, r2, #700
	ldr	r3, [fp, #-52]
	str	r2, [r3, r0, asl #2]
	ldr	r3, [fp, #4]
	ldr	r2, [r3]
	add	r2, r2, #1
	str	r2, [r3]
.L866:
	ldr	r3, [fp, #-48]
	cmp	r3, #0
	addne	r8, r7, r5, lsl #2
	bne	.L868
	b	.L861
.L867:
	add	r5, r5, #1
	cmp	r4, r5
	bls	.L861
.L868:
	mov	r9, r8
	ldr	r0, [r8], #4
	ldrb	r2, [r0, #2]
	tst	r2, #2
	beq	.L867
	add	r0, r0, #736
	blx	r6
	cmp	r0, #0
	beq	.L867
	ldr	r3, [fp, #4]
	add	r5, r5, #1
	ldr	r2, [r9]
	ldr	r0, [r3]
	add	r2, r2, #736
	ldr	r3, [fp, #-52]
	str	r2, [r3, r0, asl #2]
	ldr	r3, [fp, #4]
	ldr	r2, [r3]
	add	r2, r2, #1
	str	r2, [r3]
.L861:
	cmp	r10, r4
	movcs	r2, #0
	movcc	r2, #1
	cmp	r5, r4
	movcs	r3, #0
	movcc	r3, #1
	str	r3, [fp, #-48]
	orrs	r3, r3, r2
	beq	.L869
	cmp	r2, #0
	beq	.L866
	add	r9, r7, r10, lsl #2
	b	.L865
.L862:
	add	r10, r10, #1
	cmp	r4, r10
	bls	.L866
.L865:
	mov	r8, r9
	ldr	r0, [r9], #4
	ldrb	ip, [r0, #2]
	tst	ip, #1
	beq	.L862
	b	.L920
.L869:
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L922:
	.align	2
.L921:
	.word	MVC_IsLTRefFlg
	.word	MVC_IsSTRefFlg
	.fnend
	.size	MVC_GenPiclistfromFrmlist, .-MVC_GenPiclistfromFrmlist
	.align	2
	.global	MVC_GetBaseViewId
	.type	MVC_GetBaseViewId, %function
MVC_GetBaseViewId:
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
	add	r3, r0, #12992
	add	r3, r3, #16
	mov	r2, #0
.L926:
	ldr	r1, [r3]
	cmp	r1, #0
	beq	.L924
	ldrb	r1, [r3, #-4]
	cmp	r1, #0
	bne	.L934
.L924:
	add	r2, r2, #1
	add	r3, r3, #335872
	cmp	r2, #32
	add	r3, r3, #308
	bne	.L926
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L934:
	movw	r3, #8500
	movt	r3, 5
	mla	r2, r3, r2, r0
	add	r2, r2, #12992
	ldr	r0, [r2, #20]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_GetBaseViewId, .-MVC_GetBaseViewId
	.align	2
	.global	MVC_GetVOIdx
	.type	MVC_GetVOIdx, %function
MVC_GetVOIdx:
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
	beq	.L939
	ldr	r3, [r0]
	cmp	r3, r2
	beq	.L940
	mov	ip, r0
	mov	r3, #0
	mov	r0, r1
	b	.L937
.L938:
	ldr	lr, [ip, #4]!
	cmp	lr, r2
	beq	.L941
.L937:
	add	r3, r3, #1
	cmp	r3, r1
	bne	.L938
	ldmfd	sp, {fp, sp, pc}
.L941:
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L939:
	mov	r0, r1
	ldmfd	sp, {fp, sp, pc}
.L940:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_GetVOIdx, .-MVC_GetVOIdx
	.align	2
	.global	MVC_is_view_id_in_ref_view_list
	.type	MVC_is_view_id_in_ref_view_list, %function
MVC_is_view_id_in_ref_view_list:
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
	beq	.L946
	ldr	r3, [r1]
	cmp	r3, r0
	beq	.L947
	mov	r3, #0
	b	.L944
.L945:
	ldr	ip, [r1, #4]!
	cmp	ip, r0
	beq	.L943
.L944:
	add	r3, r3, #1
	cmp	r3, r2
	mov	lr, r3
	bne	.L945
.L943:
	cmp	r2, #0
	cmpne	r2, lr
	movhi	r0, #1
	movls	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L946:
	mov	lr, r2
	b	.L943
.L947:
	mov	lr, #0
	b	.L943
	.fnend
	.size	MVC_is_view_id_in_ref_view_list, .-MVC_is_view_id_in_ref_view_list
	.align	2
	.global	MVC_GenPiclistfromFrmlist_Interview
	.type	MVC_GenPiclistfromFrmlist_Interview, %function
MVC_GenPiclistfromFrmlist_Interview:
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
	ldr	ip, [fp, #4]
	beq	.L964
	cmp	r0, #2
	ldmnefd	sp, {fp, sp, pc}
	cmp	r2, #0
	ldmeqfd	sp, {fp, sp, pc}
	ldr	r0, [ip]
	add	r1, r1, #736
	mov	lr, #0
.L955:
	add	lr, lr, #1
	str	r1, [r3, r0, asl #2]
	cmp	lr, r2
	ldr	r0, [ip]
	add	r1, r1, #776
	add	r0, r0, #1
	str	r0, [ip]
	bne	.L955
	ldmfd	sp, {fp, sp, pc}
.L964:
	cmp	r2, #0
	ldmeqfd	sp, {fp, sp, pc}
	ldr	r0, [ip]
	add	r1, r1, #700
	mov	lr, #0
.L951:
	add	lr, lr, #1
	str	r1, [r3, r0, asl #2]
	cmp	lr, r2
	ldr	r0, [ip]
	add	r1, r1, #776
	add	r0, r0, #1
	str	r0, [ip]
	bne	.L951
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_GenPiclistfromFrmlist_Interview, .-MVC_GenPiclistfromFrmlist_Interview
	.align	2
	.global	mvc_append_interview_list
	.type	mvc_append_interview_list, %function
mvc_append_interview_list:
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
	add	lr, r0, #10747904
	add	ip, r0, #11075584
	add	lr, lr, #20480
	add	r5, ip, #40960
	mov	r9, r0
	movw	r0, #22868
	ldr	r6, [lr, #2384]
	movt	r0, 164
	str	r2, [fp, #-48]
	add	r0, r9, r0
	adds	r6, r6, #1
	ldr	r7, [r5, #2512]
	beq	.L984
	ldr	r2, [lr, #2388]
	cmp	r7, r2
	beq	.L985
	mov	r2, #0
	b	.L967
.L968:
	ldr	lr, [r0, #4]!
	cmp	r7, lr
	beq	.L966
.L967:
	add	r2, r2, #1
	cmp	r2, r6
	mov	r4, r2
	bne	.L968
.L966:
	ldrb	r2, [r5, #881]
	add	r4, r4, r1, lsl #1
	add	r6, r9, #11141120
	add	ip, ip, #45056
	cmp	r2, #0
	add	r6, r6, #12288
	movwne	r2, #5718
	movweq	r2, #5726
	movtne	r2, 41
	movteq	r2, 41
	addne	r2, r4, r2
	addeq	r2, r4, r2
	ldrb	r8, [r6, #1371]
	addne	r4, r9, r4, lsl #2
	add	r2, r9, r2, lsl #2
	movwne	r10, #22892
	addeq	r4, r9, r4, lsl #2
	movweq	r10, #22924
	ldr	r7, [r2, #4]
	sub	r8, r8, #2
	ldr	r2, [ip, #2728]
	movt	r10, 164
	clz	r8, r8
	add	r10, r4, r10
	subs	r4, r2, #1
	mov	r8, r8, lsr #5
	bmi	.L965
	movw	r5, #28282
	movt	r5, 42
	add	r5, r2, r5
	mov	r2, r3
	mov	r3, r9
	add	r5, r9, r5, lsl #2
	mov	r9, r2
	b	.L982
.L1008:
	ldrb	r2, [r1, #2]
	cmp	r2, #3
	ldreq	r0, [r1, #684]
	bne	.L972
.L974:
	add	r2, r1, r8
	ldrb	r2, [r2, #12]
	cmp	r2, #0
	beq	.L972
	ldr	r2, [r6, #1996]
	cmp	r2, r0
	beq	.L1007
.L972:
	subs	r4, r4, #1
	bmi	.L965
.L982:
	ldr	r1, [r5, #-4]!
	cmp	r1, #0
	beq	.L972
	ldrb	r2, [r6, #1371]
	cmp	r2, #0
	beq	.L1008
	cmp	r2, #1
	beq	.L1009
	cmp	r2, #2
	bne	.L972
	ldrb	r0, [r6, #1369]
	ldrb	r2, [r1, #2]
	cmp	r0, #0
	ubfx	r2, r2, #1, #1
	beq	.L977
	ldr	r0, [r6, #1976]
	ldr	ip, [r1, #720]
	ldr	r0, [r0, #720]
	cmp	ip, r0
	movne	r2, #0
	andeq	r2, r2, #1
.L977:
	cmp	r2, #0
	ldrne	r0, [r1, #756]
	bne	.L974
	subs	r4, r4, #1
	bpl	.L982
.L965:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1009:
	ldrb	r0, [r6, #1369]
	ldrb	r2, [r1, #2]
	cmp	r0, #0
	and	r2, r2, #1
	beq	.L976
	ldr	r0, [r6, #1976]
	ldr	ip, [r1, #756]
	ldr	r0, [r0, #756]
	cmp	ip, r0
	movne	r2, #0
	andeq	r2, r2, #1
.L976:
	cmp	r2, #0
	ldrne	r0, [r1, #720]
	bne	.L974
	b	.L972
.L1007:
	cmp	r7, #0
	ldr	lr, [r1, #56]
	beq	.L972
	ldr	r2, [r10]
	cmp	lr, r2
	beq	.L978
	mov	r0, r10
	mov	r2, #0
.L979:
	add	r2, r2, #1
	cmp	r2, r7
	beq	.L972
	ldr	ip, [r0, #4]!
	cmp	lr, ip
	bne	.L979
.L978:
	str	r3, [fp, #-52]
	mov	r2, #776
	ldr	r3, .L1010
	ldr	r0, [r9]
	ldr	ip, [r3, #52]
	ldr	r3, [fp, #-48]
	mla	r0, r2, r0, r3
	blx	ip
	ldr	r2, [r9]
	ldr	r0, [fp, #-48]
	mov	r1, #776
	mov	ip, #776
	ldr	r3, [fp, #-52]
	mla	r2, r1, r2, r0
	str	r2, [r2, #740]
	str	r2, [r2, #704]
	str	r2, [r2, #668]
	ldr	r2, [r9]
	ldr	r1, [r3, #52]
	mla	r2, ip, r2, r0
	sub	r1, r1, #1
	str	r1, [r2, #48]
	ldr	r2, [r9]
	cmp	r2, r7
	beq	.L965
	add	r2, r2, #1
	str	r2, [r9]
	b	.L972
.L984:
	mov	r4, r6
	b	.L966
.L985:
	mov	r4, #0
	b	.L966
.L1011:
	.align	2
.L1010:
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	mvc_append_interview_list, .-mvc_append_interview_list
	.align	2
	.global	MVC_InitListX
	.type	MVC_InitListX, %function
MVC_InitListX:
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
	add	r2, r0, #11075584
	add	r7, r0, #11141120
	add	r5, r2, #40960
	mov	r3, #0
	add	r7, r7, #12288
	mov	r6, r0
	ldrb	r9, [r5, #872]
	str	r3, [r5, #2524]
	cmp	r9, r3
	str	r3, [r5, #2520]
	ldrb	r4, [r7, #1371]
	bne	.L1013
	cmp	r4, r3
	add	r3, r2, #45056
	str	r3, [fp, #-240]
	bne	.L1171
	ldr	ip, [r3, #2736]
	cmp	ip, #0
	beq	.L1097
	movw	r1, #47652
	mov	r3, r4
	movt	r1, 169
	add	r1, r0, r1
	b	.L1019
.L1018:
	cmp	r3, ip
	beq	.L1017
.L1019:
	ldr	r2, [r1, #4]!
	add	r3, r3, #1
	ldrb	r0, [r2, #3]
	cmp	r0, #3
	bne	.L1018
	ldr	r0, [r2, #664]
	bic	r0, r0, #-16777216
	bic	r0, r0, #255
	cmp	r0, #65536
	addeq	r0, r4, #64
	addeq	r2, r2, #664
	addeq	r4, r4, #1
	streq	r2, [r6, r0, asl #2]
	cmp	r3, ip
	bne	.L1019
.L1017:
	add	r3, r6, #256
	mov	r1, r4
	str	r3, [fp, #-244]
	mov	r2, #4
	mov	r0, r3
	ldr	r3, .L1181
	bl	qsort
	ldr	r3, [fp, #-240]
	str	r4, [r5, #920]
	ldr	r1, [r3, #2740]
	cmp	r1, #0
	beq	.L1098
	movw	r0, #47716
	mov	r8, r4
	movt	r0, 169
	mov	r3, #0
	add	r0, r6, r0
	b	.L1022
.L1021:
	cmp	r3, r1
	beq	.L1172
.L1022:
	ldr	r2, [r0, #4]!
	add	r3, r3, #1
	ldrb	ip, [r2, #3]
	cmp	ip, #3
	bne	.L1021
	ldr	ip, [r2, #664]
	bic	ip, ip, #-16777216
	bic	ip, ip, #255
	cmp	ip, #256
	addeq	ip, r8, #64
	addeq	r2, r2, #664
	addeq	r8, r8, #1
	streq	r2, [r6, ip, asl #2]
	cmp	r3, r1
	bne	.L1022
.L1172:
	rsb	r1, r4, r8
.L1020:
	add	r0, r4, #64
	ldr	r3, .L1181+4
	mov	r2, #4
	add	r0, r6, r0, lsl #2
	bl	qsort
	str	r8, [r5, #920]
	b	.L1023
.L1013:
	cmp	r4, #0
	beq	.L1040
	add	r2, r2, #45056
	str	r2, [fp, #-240]
	ldr	ip, [r2, #2736]
	cmp	ip, #0
	beq	.L1173
	movw	r9, #47652
	mov	r4, r3
	movt	r9, 169
	add	r9, r0, r9
	mov	r1, r9
.L1059:
	ldr	r2, [r1, #4]!
	add	r3, r3, #1
	ldrb	r0, [r2, #2]
	cmp	r0, #0
	beq	.L1058
	sub	r0, fp, #44
	ldr	lr, [r7, #1996]
	add	r8, r0, r4, lsl #2
	ldr	r0, [r2, #32]
	cmp	lr, r0
	strge	r2, [r8, #-192]
	addge	r4, r4, #1
.L1058:
	cmp	r3, ip
	bne	.L1059
	sub	r10, fp, #236
	ldr	r3, .L1181+8
	mov	r2, #4
	mov	r1, r4
	mov	r0, r10
	bl	qsort
	ldr	r3, [fp, #-240]
	ldr	r8, [r3, #2736]
	cmp	r8, #0
	beq	.L1168
.L1095:
	mov	r3, r9
	mov	r2, #0
	mov	r9, r4
.L1062:
	ldr	r1, [r3, #4]!
	add	r2, r2, #1
	ldrb	r0, [r1, #2]
	cmp	r0, #0
	beq	.L1061
	sub	r0, fp, #44
	ldr	ip, [r7, #1996]
	add	lr, r0, r9, lsl #2
	ldr	r0, [r1, #32]
	cmp	ip, r0
	strlt	r1, [lr, #-192]
	addlt	r9, r9, #1
.L1061:
	cmp	r2, r8
	bne	.L1062
	rsb	r8, r4, r9
	mov	r3, r4, asl #2
	add	r0, r10, r3
	str	r3, [fp, #-244]
	mov	r1, r8
	ldr	r3, .L1181+12
	mov	r2, #4
	bl	qsort
	cmp	r4, #0
	subeq	ip, fp, #172
	beq	.L1063
.L1090:
	sub	ip, fp, #172
	mov	r2, r10
	add	r8, ip, r8, lsl #2
	mov	r3, #0
.L1064:
	add	r3, r3, #1
	ldr	r1, [r2], #4
	cmp	r3, r4
	str	r1, [r8], #4
	bcc	.L1064
.L1063:
	cmp	r9, r4
	bls	.L1065
	ldr	r3, [fp, #-244]
	add	r2, r10, r3
	mov	r3, ip
.L1066:
	add	r4, r4, #1
	ldr	r1, [r2], #4
	cmp	r4, r9
	str	r1, [r3], #4
	bne	.L1066
.L1065:
	movw	r8, #41880
	mov	r4, #0
	add	r3, r6, #256
	str	r4, [r5, #920]
	str	r4, [r5, #924]
	mov	r1, r10
	ldrb	r0, [r7, #1371]
	mov	r2, r9
	str	r4, [sp, #4]
	movt	r8, 169
	add	r8, r6, r8
	str	r8, [sp]
	str	ip, [fp, #-252]
	movw	r10, #41884
	str	r3, [fp, #-244]
	bl	MVC_GenPiclistfromFrmlist
	ldr	ip, [fp, #-252]
	add	r3, r6, #388
	ldrb	r0, [r7, #1371]
	mov	r2, r9
	str	r4, [sp, #4]
	movt	r10, 169
	mov	r1, ip
	add	r10, r6, r10
	str	r10, [sp]
	str	r3, [fp, #-248]
	bl	MVC_GenPiclistfromFrmlist
	ldr	r3, [fp, #-240]
	ldr	r9, [r3, #2740]
	cmp	r9, r4
	subeq	ip, fp, #108
	beq	.L1067
	movw	r3, #47716
	sub	ip, fp, #108
	movt	r3, 169
	add	r3, r6, r3
	mov	r2, ip
.L1068:
	add	r4, r4, #1
	ldr	r1, [r3, #4]!
	cmp	r4, r9
	str	r1, [r2], #4
	bne	.L1068
.L1067:
	mov	r0, ip
	ldr	r3, .L1181+16
	mov	r2, #4
	mov	r1, r9
	str	ip, [fp, #-240]
	bl	qsort
	ldr	ip, [fp, #-240]
	mov	r4, #1
	ldrb	r0, [r7, #1371]
	mov	r2, r9
	ldr	r3, [fp, #-244]
	mov	r1, ip
	str	r4, [sp, #4]
	str	r8, [sp]
	bl	MVC_GenPiclistfromFrmlist
	ldr	ip, [fp, #-240]
	ldrb	r0, [r7, #1371]
	mov	r2, r9
	str	r4, [sp, #4]
	ldr	r3, [fp, #-248]
	mov	r1, ip
	str	r10, [sp]
	bl	MVC_GenPiclistfromFrmlist
	ldr	r4, [r5, #920]
	ldr	r3, [r5, #924]
	rsb	r3, r3, r4
	clz	r3, r3
	mov	r3, r3, lsr #5
.L1057:
	cmp	r4, #1
	movls	r3, #0
	andhi	r3, r3, #1
	cmp	r3, #0
	beq	.L1069
	cmp	r4, #0
	beq	.L1070
	ldr	lr, [r6, #256]
	ldr	r3, [r6, #388]
	cmp	lr, r3
	bne	.L1069
	ldr	r1, [fp, #-244]
	add	r2, r6, #388
	mov	r3, #0
	b	.L1071
.L1072:
	ldr	ip, [r1, #4]!
	ldr	r0, [r2, #4]!
	cmp	ip, r0
	bne	.L1069
.L1071:
	add	r3, r3, #1
	cmp	r3, r4
	bne	.L1072
.L1073:
	ldr	r3, [r6, #392]
	str	lr, [r6, #392]
	str	r3, [r6, #388]
	ldrb	r3, [r5, #884]
.L1091:
	cmp	r3, #0
	bne	.L1160
.L1074:
	movw	r4, #31360
	movw	r3, #43480
	movt	r4, 169
	add	r4, r6, r4
	mov	r0, r6
	movt	r3, 169
	mov	r1, #0
	mov	r2, r4
	add	r3, r6, r3
	bl	mvc_append_interview_list
	ldrb	r0, [r7, #1371]
	cmp	r0, #0
	bne	.L1174
	ldr	r1, [r5, #2520]
	ldr	ip, [r5, #920]
	cmp	r1, #0
	beq	.L1076
	add	r2, ip, #63
	movw	r3, #32024
	movt	r3, 169
	add	r3, r6, r3
	add	r2, r6, r2, lsl #2
.L1077:
	add	r0, r0, #1
	str	r3, [r2, #4]!
	cmp	r0, r1
	add	r3, r3, #776
	bne	.L1077
	add	ip, ip, r0
.L1076:
	str	ip, [r5, #920]
.L1078:
	ldrb	r1, [r5, #872]
	cmp	r1, #1
	beq	.L1175
.L1161:
	ldr	r0, [r5, #920]
.L1075:
	cmp	r1, #0
	bne	.L1033
	cmp	r0, #0
	ldreq	r1, .L1181+20
	beq	.L1162
.L1032:
	ldr	r2, [r5, #932]
	ldr	r3, [r5, #936]
	add	r2, r2, #1
	ldr	r1, [r5, #924]
	cmp	r0, r2
	add	r3, r3, #1
	movcc	r2, r0
	cmp	r3, r1
	str	r2, [r5, #920]
	movcs	r3, r1
	cmp	r2, #32
	str	r3, [r5, #924]
	bhi	.L1084
.L1092:
	add	r1, r2, #63
	mov	r0, #0
	add	r1, r6, r1, lsl #2
.L1085:
	add	r2, r2, #1
	str	r0, [r1, #4]!
	cmp	r2, #32
	bls	.L1085
.L1084:
	cmp	r3, #32
	bhi	.L1088
	add	r3, r3, #96
	add	r1, r6, #516
	mov	r2, #0
	add	r6, r6, r3, lsl #2
.L1087:
	str	r2, [r6, #4]!
	cmp	r6, r1
	bne	.L1087
.L1088:
	mov	r0, #0
.L1154:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1040:
	add	r3, r2, #45056
	str	r3, [fp, #-240]
	ldr	r10, [r3, #2736]
	cmp	r10, #0
	beq	.L1043
	movw	r9, #47652
	mov	r3, r4
	movt	r9, 169
	add	r9, r0, r9
	mov	r1, r9
	b	.L1045
.L1044:
	cmp	r3, r10
	beq	.L1176
.L1045:
	ldr	r2, [r1, #4]!
	add	r3, r3, #1
	ldrb	r0, [r2, #3]
	cmp	r0, #3
	bne	.L1044
	ldr	r0, [r2, #680]
	add	lr, r4, #64
	ldr	ip, [r7, #2000]
	add	r2, r2, #664
	cmp	ip, r0
	strge	r2, [r6, lr, asl #2]
	addge	r4, r4, #1
	cmp	r3, r10
	bne	.L1045
.L1176:
	add	r3, r6, #256
	mov	r2, #4
	str	r3, [fp, #-244]
	mov	r1, r4
	mov	r0, r3
	ldr	r3, .L1181+24
	bl	qsort
	ldr	r3, [fp, #-240]
	ldr	r8, [r3, #2736]
	cmp	r8, #0
	beq	.L1167
.L1093:
	mov	r3, r9
	mov	r10, r4
	mov	r2, #0
	b	.L1048
.L1047:
	cmp	r2, r8
	beq	.L1177
.L1048:
	ldr	r1, [r3, #4]!
	add	r2, r2, #1
	ldrb	r0, [r1, #3]
	cmp	r0, #3
	bne	.L1047
	ldr	r0, [r1, #680]
	add	lr, r10, #64
	ldr	ip, [r7, #2000]
	add	r1, r1, #664
	cmp	ip, r0
	strlt	r1, [r6, lr, asl #2]
	addlt	r10, r10, #1
	cmp	r2, r8
	bne	.L1048
.L1177:
	rsb	r8, r4, r10
	add	r0, r4, #64
	ldr	r3, .L1181+28
	mov	r2, #4
	mov	r1, r8
	add	r0, r6, r0, lsl #2
	bl	qsort
	add	r9, r10, #64
	cmp	r4, #0
	add	r9, r6, r9, lsl #2
	beq	.L1050
.L1089:
	add	r8, r8, #96
	add	r2, r6, #252
	mov	r3, #0
	add	r8, r6, r8, lsl #2
.L1051:
	add	r3, r3, #1
	ldr	r1, [r2, #4]!
	cmp	r3, r4
	str	r1, [r8, #4]!
	bcc	.L1051
.L1050:
	cmp	r10, r4
	bls	.L1052
	add	r3, r4, #63
	add	r2, r6, #384
	add	r3, r6, r3, lsl #2
.L1053:
	add	r4, r4, #1
	ldr	r1, [r3, #4]!
	cmp	r4, r10
	str	r1, [r2, #4]!
	bne	.L1053
.L1052:
	ldr	r3, [fp, #-240]
	str	r10, [r5, #924]
	str	r10, [r5, #920]
	ldr	r1, [r3, #2740]
	cmp	r1, #0
	beq	.L1099
	movw	r0, #47716
	mov	r4, r10
	movt	r0, 169
	mov	r3, #0
	add	r0, r6, r0
	b	.L1056
.L1055:
	cmp	r3, r1
	beq	.L1178
.L1056:
	ldr	r2, [r0, #4]!
	add	r3, r3, #1
	ldrb	ip, [r2, #2]
	cmp	ip, #3
	bne	.L1055
	ldrb	ip, [r2, #665]
	cmp	ip, #1
	addeq	ip, r6, r4, lsl #2
	addeq	r2, r2, #664
	addeq	r4, r4, #1
	streq	r2, [ip, #256]
	streq	r2, [ip, #388]
	cmp	r3, r1
	bne	.L1056
.L1178:
	rsb	r1, r10, r4
.L1054:
	mov	r0, r9
	ldr	r3, .L1181+4
	mov	r2, #4
	bl	qsort
	ldr	r1, [r5, #920]
	ldr	r3, .L1181+4
	mov	r2, #4
	add	r0, r1, #97
	rsb	r1, r1, r4
	add	r0, r6, r0, lsl #2
	bl	qsort
	str	r4, [r5, #924]
	str	r4, [r5, #920]
	mov	r3, #1
	b	.L1057
.L1171:
	ldr	lr, [r3, #2736]
	cmp	lr, #0
	moveq	r9, lr
	beq	.L1016
	movw	r1, #47652
	mov	r3, r9
	movt	r1, 169
	add	r1, r0, r1
.L1025:
	ldr	r2, [r1, #4]!
	sub	r0, fp, #44
	add	ip, r0, r9, lsl #2
	add	r3, r3, #1
	ldrb	r0, [r2, #3]
	cmp	r0, #0
	strne	r2, [ip, #-192]
	addne	r9, r9, #1
	cmp	r3, lr
	bne	.L1025
.L1016:
	mov	r1, r9
	ldr	r3, .L1181+32
	mov	r2, #4
	sub	r0, fp, #236
	movw	r8, #41880
	bl	qsort
	mov	r4, #0
	add	r3, r6, #256
	str	r4, [r5, #920]
	mov	r2, r9
	ldrb	r0, [r7, #1371]
	sub	r1, fp, #236
	str	r4, [sp, #4]
	movt	r8, 169
	add	r8, r6, r8
	str	r8, [sp]
	str	r3, [fp, #-244]
	bl	MVC_GenPiclistfromFrmlist
	ldr	r3, [fp, #-240]
	ldr	r9, [r3, #2740]
	cmp	r9, r4
	subeq	ip, fp, #108
	beq	.L1026
	movw	r3, #47716
	sub	ip, fp, #108
	movt	r3, 169
	add	r3, r6, r3
	mov	r2, ip
.L1027:
	add	r4, r4, #1
	ldr	r1, [r3, #4]!
	cmp	r4, r9
	str	r1, [r2], #4
	bne	.L1027
.L1026:
	mov	r0, ip
	ldr	r3, .L1181+16
	mov	r2, #4
	mov	r1, r9
	str	ip, [fp, #-240]
	bl	qsort
	ldr	ip, [fp, #-240]
	mov	r3, #1
	ldrb	r0, [r7, #1371]
	mov	r2, r9
	str	r3, [sp, #4]
	str	r8, [sp]
	mov	r1, ip
	ldr	r3, [fp, #-244]
	bl	MVC_GenPiclistfromFrmlist
.L1023:
	ldrb	r3, [r5, #884]
	mov	r2, #0
	str	r2, [r5, #924]
	cmp	r3, r2
	beq	.L1074
	ldr	r0, [r5, #920]
	cmp	r0, #0
	bne	.L1179
	ldr	r3, [r6, #224]
	ldr	r3, [r3, #12]
	cmp	r3, #2
	bne	.L1034
	ldrb	r3, [r7, #1371]
	cmp	r3, #0
	bne	.L1035
	ldr	r3, [r7, #1976]
	add	r3, r3, #664
	str	r3, [r6, #256]
.L1036:
	mov	r3, #1
	str	r3, [r5, #920]
.L1160:
	ldrb	r1, [r5, #872]
	b	.L1161
.L1179:
	ldrb	r3, [r5, #872]
	cmp	r3, #0
	beq	.L1032
.L1033:
	cmp	r0, #0
	bne	.L1032
	ldr	r1, [r5, #924]
	cmp	r1, #0
	beq	.L1180
	ldr	r3, [r5, #936]
	mov	r2, r0
	str	r0, [r5, #920]
	add	r3, r3, #1
	cmp	r3, r1
	movcs	r3, r1
	str	r3, [r5, #924]
	b	.L1092
.L1069:
	ldrb	r3, [r5, #884]
	b	.L1091
.L1174:
	movw	ip, #41880
	ldr	r2, [r5, #2520]
	ldr	r3, [fp, #-244]
	mov	r1, r4
	movt	ip, 169
	add	ip, r6, ip
	str	ip, [sp]
	bl	MVC_GenPiclistfromFrmlist_Interview
	b	.L1078
.L1035:
	cmp	r3, #1
	ldr	r3, [r7, #1976]
	addeq	r3, r3, #700
	addne	r3, r3, #736
	str	r3, [r6, #256]
	b	.L1036
.L1070:
	ldr	lr, [r6, #388]
	b	.L1073
.L1175:
	movw	r4, #32912
	movw	r3, #43484
	movt	r4, 169
	add	r4, r6, r4
	mov	r0, r6
	movt	r3, 169
	mov	r2, r4
	add	r3, r6, r3
	bl	mvc_append_interview_list
	ldrb	r0, [r7, #1371]
	cmp	r0, #0
	bne	.L1080
	ldr	r1, [r5, #2524]
	ldr	ip, [r5, #924]
	cmp	r1, #0
	beq	.L1081
	add	r2, ip, #96
	movw	r3, #33576
	movt	r3, 169
	add	r3, r6, r3
	add	r2, r6, r2, lsl #2
.L1082:
	add	r0, r0, #1
	str	r3, [r2, #4]!
	cmp	r0, r1
	add	r3, r3, #776
	bne	.L1082
	add	ip, ip, r0
.L1081:
	str	ip, [r5, #924]
	ldrb	r1, [r5, #872]
	ldr	r0, [r5, #920]
	b	.L1075
.L1168:
	mov	r3, r4, asl #2
	mov	r1, r8
	str	r3, [fp, #-244]
	mov	r2, r3
	ldr	r3, .L1181+12
	add	r0, r10, r2
	mov	r2, #4
	bl	qsort
	subs	r9, r4, #0
	bne	.L1090
.L1163:
	sub	ip, fp, #172
	b	.L1065
.L1167:
	add	r9, r4, #64
	ldr	r3, .L1181+28
	mov	r2, #4
	mov	r1, r8
	add	r9, r6, r9, lsl #2
	mov	r0, r9
	bl	qsort
	subs	r10, r4, #0
	bne	.L1089
	b	.L1052
.L1097:
	mov	r4, ip
	b	.L1017
.L1098:
	mov	r8, r4
	b	.L1020
.L1099:
	mov	r4, r10
	b	.L1054
.L1173:
	sub	r10, fp, #236
	ldr	r3, .L1181+8
	mov	r1, ip
	mov	r2, #4
	mov	r0, r10
	str	ip, [fp, #-244]
	bl	qsort
	ldr	r3, [fp, #-240]
	ldr	ip, [fp, #-244]
	ldr	r8, [r3, #2736]
	cmp	r8, #0
	movwne	r9, #47652
	movne	r4, ip
	movtne	r9, 169
	addne	r9, r6, r9
	bne	.L1095
	ldr	r3, .L1181+12
	mov	r2, #4
	mov	r1, r8
	mov	r0, r10
	mov	r9, r8
	bl	qsort
	b	.L1163
.L1043:
	add	r3, r0, #256
	mov	r2, #4
	str	r3, [fp, #-244]
	mov	r1, r10
	mov	r0, r3
	ldr	r3, .L1181+24
	bl	qsort
	ldr	r3, [fp, #-240]
	ldr	r8, [r3, #2736]
	cmp	r8, #0
	movwne	r9, #47652
	movne	r4, r10
	movtne	r9, 169
	addne	r9, r6, r9
	bne	.L1093
	ldr	r9, [fp, #-244]
	mov	r2, #4
	ldr	r3, .L1181+28
	mov	r1, r8
	mov	r10, r8
	mov	r0, r9
	bl	qsort
	b	.L1052
.L1180:
	ldr	r1, .L1181+36
.L1162:
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r6
	bl	MVC_ClearCurrSlice
	mvn	r0, #0
	b	.L1154
.L1080:
	movw	ip, #41884
	ldr	r2, [r5, #2524]
	mov	r1, r4
	movt	ip, 169
	add	r3, r6, #388
	add	ip, r6, ip
	str	ip, [sp]
	bl	MVC_GenPiclistfromFrmlist_Interview
	b	.L1160
.L1034:
	ldr	r1, .L1181+40
	b	.L1162
.L1182:
	.align	2
.L1181:
	.word	MVC_compare_pic_by_pic_num_desc
	.word	MVC_compare_pic_by_lt_pic_num_asc
	.word	MVC_compare_fs_by_poc_desc
	.word	MVC_compare_fs_by_poc_asc
	.word	MVC_compare_fs_by_lt_pic_idx_asc
	.word	.LC26
	.word	MVC_compare_pic_by_poc_desc
	.word	MVC_compare_pic_by_poc_asc
	.word	MVC_compare_fs_by_frame_num_desc
	.word	.LC27
	.word	.LC25
	.fnend
	.size	MVC_InitListX, .-MVC_InitListX
	.align	2
	.global	MVC_DumpList
	.type	MVC_DumpList, %function
MVC_DumpList:
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
	ldr	r3, .L1196
	ldr	r3, [r3]
	tst	r3, #8192
	beq	.L1183
	movw	r8, #41876
	add	r7, r0, #252
	movt	r8, 169
	add	r8, r0, r8
	mov	r6, #0
.L1185:
	ldr	r3, [r8, #4]!
	cmp	r3, #0
	movne	r5, r7
	movne	r4, #0
	beq	.L1187
.L1186:
	ldr	ip, [r5, #4]!
	mov	r3, r4
	mov	r2, r6
	ldr	r1, .L1196+4
	mov	r0, #13
	add	r4, r4, #1
	ldr	ip, [ip, #4]
	ldr	lr, [ip, #32]
	str	lr, [sp, #4]
	ldr	ip, [ip, #20]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [r8]
	cmp	r3, r4
	bhi	.L1186
.L1187:
	add	r6, r6, #1
	add	r7, r7, #132
	cmp	r6, #2
	bne	.L1185
.L1183:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L1197:
	.align	2
.L1196:
	.word	g_PrintEnable
	.word	.LC28
	.fnend
	.size	MVC_DumpList, .-MVC_DumpList
	.align	2
	.global	MVC_FindNearestPOCPicId
	.type	MVC_FindNearestPOCPicId, %function
MVC_FindNearestPOCPicId:
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
	add	r3, r0, #11075584
	add	r3, r3, #45056
	ldr	r2, [r3, #2732]
	cmp	r2, #0
	beq	.L1203
	ldr	r4, [r3, #2728]
	add	r3, r0, #11141120
	add	r3, r3, #12288
	cmp	r4, #0
	ldr	r5, [r3, #1996]
	beq	.L1204
	movw	ip, #47588
	mov	r6, #0
	movt	ip, 169
	add	ip, r0, ip
	mov	r1, r6
	mvn	lr, #-2147483648
.L1202:
	ldr	r2, [ip, #4]!
	add	r1, r1, #1
	cmp	r2, #0
	beq	.L1201
	ldr	r3, [r2, #32]
	rsb	r3, r3, r5
	cmp	r3, #0
	rsblt	r3, r3, #0
	cmp	r3, lr
	ldrlt	r6, [r2, #228]
	movlt	lr, r3
.L1201:
	cmp	r1, r4
	bne	.L1202
.L1200:
	mov	r0, r6
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1204:
	mov	r6, r4
	b	.L1200
.L1203:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	MVC_FindNearestPOCPicId, .-MVC_FindNearestPOCPicId
	.align	2
	.global	MVC_FindMinRefIdx
	.type	MVC_FindMinRefIdx, %function
MVC_FindMinRefIdx:
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
	add	r3, r0, #11075584
	add	r3, r3, #40960
	ldrb	r2, [r3, #872]
	cmp	r2, #2
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	add	r2, r0, #11141120
	movw	r6, #48020
	add	r2, r2, #12288
	ldrb	lr, [r2, #1371]
	cmp	lr, #0
	bne	.L1239
	ldr	r4, [r3, #920]
	movw	r5, #48024
	movt	r6, 169
	movt	r5, 169
	cmp	r4, #0
	add	r6, r0, r6
	add	r5, r0, r5
	mov	r7, lr
	beq	.L1217
.L1241:
	add	r2, r0, #252
	mov	ip, #32
	mov	r3, #0
	b	.L1215
.L1214:
	add	r3, r3, #1
	cmp	r3, r4
	beq	.L1240
.L1215:
	ldr	r1, [r2, #4]!
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #52]
	cmp	r1, lr
	bne	.L1214
	cmp	ip, r3
	movcs	ip, r3
	add	r3, r3, #1
	cmp	r3, r4
	str	ip, [r5, #-4]
	str	ip, [r6, #4]
	bne	.L1215
.L1240:
	cmp	ip, #31
	bhi	.L1217
.L1216:
	add	lr, lr, #1
	add	r6, r6, #8
	cmp	lr, #16
	add	r5, r5, #8
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	cmp	r4, #0
	bne	.L1241
.L1217:
	str	r7, [r5, #-4]
	str	r7, [r6, #4]
	b	.L1216
.L1239:
	ldr	r5, [r3, #920]
	mov	lr, #0
	movt	r6, 169
	mov	r7, lr
	cmp	r5, #0
	add	r6, r0, r6
	beq	.L1221
.L1243:
	add	r1, r0, #252
	mov	r4, #32
	mov	r2, #0
	b	.L1219
.L1218:
	add	r2, r2, #1
	cmp	r2, r5
	beq	.L1242
.L1219:
	ldr	r3, [r1, #4]!
	ldr	r8, [r3, #4]
	ldrb	ip, [r3]
	ldr	r3, [r8, #52]
	mov	r3, r3, asl #1
	cmp	ip, #2
	orreq	r3, r3, #1
	cmp	r3, lr
	bne	.L1218
	cmp	r4, r2
	movcs	r4, r2
	add	r2, r2, #1
	cmp	r2, r5
	str	r4, [r6]
	bne	.L1219
.L1242:
	cmp	r4, #31
	bhi	.L1221
.L1220:
	add	lr, lr, #1
	add	r6, r6, #4
	cmp	lr, #32
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	cmp	r5, #0
	bne	.L1243
.L1221:
	str	r7, [r6]
	b	.L1220
	.fnend
	.size	MVC_FindMinRefIdx, .-MVC_FindMinRefIdx
	.align	2
	.global	MVC_DecList
	.type	MVC_DecList, %function
MVC_DecList:
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
	bl	MVC_FindNearestPOCPicId
	add	r5, r4, #11075584
	add	r3, r5, #40960
	mvn	r6, #0
	ldrb	r2, [r3, #872]
	str	r6, [r3, #2504]
	cmp	r2, #2
	str	r0, [r3, #2508]
	beq	.L1251
	mov	r0, r4
	bl	MVC_InitListX
	cmp	r0, #0
	bne	.L1252
	mov	r0, r4
	bl	MVC_ReorderListX
	mov	r0, r4
	bl	MVC_RepairList
	cmp	r0, #0
	bne	.L1249
	mov	r0, r4
	add	r5, r5, #40960
	bl	MVC_FindMinRefIdx
	ldr	r3, [r4, #256]
	mov	r0, #0
	cmp	r3, #0
	ldrne	r3, [r3, #4]
	ldrne	r6, [r3, #228]
	str	r6, [r5, #2504]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1251:
	mov	r0, #0
	str	r0, [r3, #920]
	str	r0, [r3, #924]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1249:
	mov	r0, r6
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1252:
	ldr	r1, .L1253
	mov	r0, #13
	bl	dprint_vfmw
	mov	r0, r6
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1254:
	.align	2
.L1253:
	.word	.LC29
	.fnend
	.size	MVC_DecList, .-MVC_DecList
	.align	2
	.global	MVC_NoPicOut
	.type	MVC_NoPicOut, %function
MVC_NoPicOut:
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
	ldr	ip, [r0, #48]
	cmp	ip, #0
	beq	.L1262
	movw	r3, #48159
	mov	r2, #0
	movt	r3, 169
	mov	lr, r2
	add	r3, r0, r3
	b	.L1261
.L1270:
	ldrb	r1, [r3, #-2]
	cmp	r1, #1
	beq	.L1259
	cmp	r2, ip
	add	r3, r3, #776
	beq	.L1262
.L1261:
	ldrb	r1, [r3]
	add	r2, r2, #1
	cmp	r1, #1
	bne	.L1270
.L1259:
	cmp	r2, ip
	strb	lr, [r3, #-5]
	strb	lr, [r3, #-4]
	add	r3, r3, #776
	bne	.L1261
.L1262:
	ldr	r2, [r0, #52]
	cmp	r2, #0
	beq	.L1271
	mov	r3, #0
	add	r0, r0, #144
	mov	r1, r3
.L1263:
	add	r3, r3, #1
	str	r1, [r0, #4]!
	cmp	r3, r2
	bne	.L1263
	ldmfd	sp, {fp, sp, pc}
.L1271:
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_NoPicOut, .-MVC_NoPicOut
	.align	2
	.global	MVC_GetBackPicFromVOQueue
	.type	MVC_GetBackPicFromVOQueue, %function
MVC_GetBackPicFromVOQueue:
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
	mov	r8, r0
	ldr	r0, [r0, #120]
	bl	FSP_GetFspType
	cmp	r0, #0
	beq	.L1289
.L1273:
	ldr	r3, [r8, #48]
	cmp	r3, #0
	beq	.L1280
	movw	r5, #48776
	mov	r6, #0
	movt	r5, 169
	add	r5, r8, r5
	mov	r7, #0
	mov	r9, #0
.L1279:
	sub	r4, r5, #32
	mov	r3, #0
	strb	r3, [r5, #-622]
	strb	r3, [r5, #-621]
.L1278:
	ldrd	r2, [r4, #8]!
	orrs	r1, r2, r3
	bne	.L1290
.L1277:
	cmp	r4, r5
	bne	.L1278
	ldr	r3, [r8, #48]
	add	r9, r9, #1
	add	r5, r5, #776
	cmp	r3, r9
	bhi	.L1279
.L1280:
	ldr	r2, [r8, #52]
	cmp	r2, #0
	beq	.L1291
	mov	r3, #0
	add	r8, r8, #144
	mov	r1, r3
.L1281:
	add	r3, r3, #1
	str	r1, [r8, #4]!
	cmp	r3, r2
	bne	.L1281
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1290:
	mov	r1, r2
	ldr	r0, [r8, #120]
	bl	FreeUsdByDec
	strd	r6, [r4]
	b	.L1277
.L1289:
	add	r0, r8, #584
	bl	ResetVoQueue
	b	.L1273
.L1291:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	MVC_GetBackPicFromVOQueue, .-MVC_GetBackPicFromVOQueue
	.align	2
	.global	mvc_wait_vo
	.type	mvc_wait_vo, %function
mvc_wait_vo:
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
	.size	mvc_wait_vo, .-mvc_wait_vo
	.align	2
	.global	MVC_RoundLog2
	.type	MVC_RoundLog2, %function
MVC_RoundLog2:
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
	mul	r0, r0, r0
	mov	r3, #0
	mov	r2, #1
.L1294:
	add	r3, r3, #1
	cmp	r0, r2, asl r3
	bge	.L1294
	mov	r0, r3, asr #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_RoundLog2, .-MVC_RoundLog2
	.align	2
	.global	MVC_GetReRangeFlag
	.type	MVC_GetReRangeFlag, %function
MVC_GetReRangeFlag:
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
	add	ip, r0, #11075584
	mov	r5, r1
	add	r7, ip, #40960
	mov	r4, r0
	ldr	r0, [r0, #252]
	mov	lr, #2240
	ldrb	r1, [r7, #884]
	ldr	r3, [r7, #888]
	sxtb	r2, r1
	cmn	r2, #1
	mla	r3, lr, r3, r0
	beq	.L1314
	cmp	r1, #0
	bne	.L1299
	ldrb	r2, [r4, #2]
	ldr	r3, [r3, #28]
	cmp	r2, #1
	beq	.L1315
	ldr	r2, [r4, #28]
	cmp	r2, r3
	movweq	r6, #35364
	movteq	r6, 168
	addeq	r6, r4, r6
	bne	.L1316
.L1298:
	ldrb	r3, [r6, #20]
	ldr	r1, [r6, #3952]
	rsb	r3, r3, #2
	ldr	r2, [r6, #3948]
	ldr	r0, [r4, #12]
	mla	r3, r1, r3, r3
	ldr	r1, [r4, #16]
	add	r2, r2, #1
	cmp	r2, r0
	cmpeq	r3, r1
	movne	lr, #1
	moveq	lr, #0
	beq	.L1317
.L1303:
	ldr	ip, .L1319
	ldr	ip, [ip]
	cmp	ip, #0
	beq	.L1310
	mov	r0, r0, asl #4
	mov	r1, r1, asl #4
	strh	r0, [fp, #-44]
	mov	r2, r2, asl #4
	strh	r1, [fp, #-42]
	mov	r1, r3, asl #4
	strh	r2, [fp, #-40]
	mov	r3, #8
	strh	r1, [fp, #-38]
	sub	r2, fp, #44
	mov	r1, #2
	ldr	r0, [r4, #120]
	blx	ip
	mov	lr, #1
	mov	r0, lr
.L1304:
	ldrb	r3, [r7, #883]
	cmp	r3, #1
	ldrne	ip, [r6, #3972]
	subne	ip, ip, #1
	beq	.L1318
.L1307:
	ldr	r3, [r4, #44]
	cmp	r3, ip
	orrne	lr, lr, #1
	str	lr, [r5]
	str	ip, [r4, #44]
.L1312:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L1317:
	add	ip, ip, #45056
	ldr	r8, [r6, #3972]
	ldr	ip, [ip, #2728]
	add	ip, ip, #1
	cmp	r8, ip
	bhi	.L1303
.L1313:
	mov	r0, lr
	b	.L1304
.L1314:
	ldr	r2, [r3, #28]
	movw	r6, #3992
	ldr	r3, [r4, #248]
	mla	r6, r6, r2, r3
	b	.L1298
.L1318:
	movw	r1, #39336
	add	r3, r4, #290816
	movt	r1, 168
	add	r3, r3, #808
	add	r1, r4, r1
	mov	ip, #0
.L1306:
	ldr	r2, [r3]
	add	r3, r3, #335872
	add	r3, r3, #308
	cmp	r2, ip
	subhi	ip, r2, #1
	cmp	r3, r1
	bne	.L1306
	add	ip, ip, #1
	mov	ip, ip, asl #1
	cmp	ip, #16
	movcs	ip, #16
	b	.L1307
.L1310:
	mov	lr, #1
	b	.L1313
.L1315:
	movw	r6, #8500
	movt	r6, 5
	mla	r6, r6, r3, r4
	add	r6, r6, #286720
	add	r6, r6, #932
	b	.L1298
.L1316:
	ldr	r1, .L1319+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1312
.L1299:
	ldr	r1, .L1319+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1312
.L1320:
	.align	2
.L1319:
	.word	g_event_report
	.word	.LC30
	.word	.LC31
	.fnend
	.size	MVC_GetReRangeFlag, .-MVC_GetReRangeFlag
	.global	__aeabi_uidiv
	.global	__aeabi_uidivmod
	.align	2
	.global	MVC_DecPOC
	.type	MVC_DecPOC, %function
MVC_DecPOC:
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
	add	r6, r0, #11075584
	ldr	r5, [r0, #236]
	add	r7, r6, #40960
	mov	r2, #1
	ldrb	r1, [r7, #875]
	ldr	ip, [r5, #2900]
	ldr	r3, [r5, #2896]
	sub	r1, r1, #5
	clz	r1, r1
	cmp	ip, r2
	add	r3, r3, #4
	ldr	lr, [r5, #2904]
	mov	r1, r1, lsr #5
	mov	r3, r2, asl r3
	beq	.L1323
	bcc	.L1324
	cmp	ip, #2
	ldmnefd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	cmp	r1, #0
	bne	.L1379
	add	r4, r6, #36864
	ldrb	r2, [r4, #3832]
	cmp	r2, #0
	bne	.L1357
	ldr	r1, [r4, #3888]
	ldr	r0, [r4, #3884]
	ldr	r2, [r4, #3896]
	cmp	r1, r0
	addcc	r2, r2, r3
	strcc	r2, [r4, #3892]
	bcs	.L1359
.L1360:
	add	r3, r2, r1
	str	r3, [r4, #3880]
	ldrb	r0, [r7, #880]
	mov	r3, r3, asl #1
	cmp	r0, #0
	subeq	r3, r3, #1
	str	r3, [r4, #3868]
	ldrb	r0, [r7, #873]
	cmp	r0, #0
	bne	.L1363
	str	r3, [r4, #3864]
	str	r3, [r4, #3860]
	str	r3, [r4, #3856]
.L1356:
	add	r6, r6, #36864
	str	r1, [r6, #3884]
	str	r2, [r6, #3896]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1324:
	cmp	r1, #0
	add	lr, lr, #4
	mov	r2, r2, asl lr
	bne	.L1380
	add	r4, r6, #36864
	ldrb	r3, [r4, #3832]
	cmp	r3, #0
	bne	.L1328
	ldr	lr, [r4, #3844]
	ldr	ip, [r4, #3848]
	mov	r1, lr
.L1329:
	ldr	r0, [r4, #3836]
	cmp	r0, ip
	bcs	.L1327
	rsb	r3, r0, ip
	cmp	r3, r2, lsr #1
	addcs	r1, r1, r2
	strcs	r1, [r4, #3852]
	bcs	.L1331
.L1327:
	cmp	r0, ip
	bls	.L1332
	rsb	r3, ip, r0
	cmp	r3, r2, lsr #1
	rsbhi	r1, r2, r1
	strhi	r1, [r4, #3852]
	bls	.L1332
.L1331:
	ldrb	r3, [r7, #873]
	cmp	r3, #0
	bne	.L1333
.L1382:
	ldr	r3, [r4, #3840]
	add	r1, r1, r0
	str	r1, [r4, #3856]
	add	r3, r1, r3
	str	r3, [r4, #3860]
	cmp	r3, r1
	movge	r3, r1
	str	r3, [r4, #3868]
.L1334:
	ldr	r2, [r4, #3888]
	str	r3, [r4, #3864]
	add	r3, r6, #40960
	ldr	r1, [r4, #3884]
	cmp	r2, r1
	strne	r2, [r4, #3884]
	ldrb	r3, [r3, #880]
	cmp	r3, #0
	addne	r6, r6, #36864
	ldrne	r2, [r6, #3836]
	ldrne	r3, [r6, #3852]
	strne	r2, [r6, #3848]
	strne	r3, [r6, #3844]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1323:
	cmp	r1, #0
	add	r4, r6, #36864
	movne	r3, #0
	strne	r3, [r4, #3892]
	bne	.L1338
	ldrb	r2, [r4, #3832]
	cmp	r2, #0
	beq	.L1339
	mov	r3, r1
	str	r1, [r4, #3896]
	str	r1, [r4, #3884]
.L1340:
	str	r3, [r4, #3892]
.L1338:
	ldr	r3, [r5, #2916]
	cmp	r3, #0
	beq	.L1342
	ldr	r3, [r4, #3888]
	ldr	r0, [r4, #3892]
	add	r0, r3, r0
	str	r0, [r4, #3880]
	ldrb	r8, [r7, #880]
	cmp	r8, #0
	bne	.L1344
	cmp	r0, #0
	beq	.L1345
	sub	r0, r0, #1
	str	r0, [r4, #3880]
.L1344:
	mov	r3, #0
	str	r3, [r4, #3912]
	ldr	r1, [r5, #2916]
	cmp	r1, r3
	bgt	.L1365
	cmp	r0, #0
	beq	.L1348
.L1381:
	sub	r9, r0, #1
	mov	r0, r9
	bl	__aeabi_uidiv
	mov	r10, r0
	mov	r0, r9
	str	r10, [r4, #3904]
	ldr	r1, [r5, #2916]
	bl	__aeabi_uidivmod
	ldr	r0, [r4, #3912]
	mul	r0, r0, r10
	str	r0, [r4, #3908]
	cmp	r1, #0
	str	r1, [r4, #3900]
	blt	.L1349
	add	r2, r5, #2912
	mov	r3, #0
	add	r2, r2, #4
.L1350:
	add	r3, r3, #1
	ldr	ip, [r2, #4]!
	cmp	r1, r3
	add	r0, r0, ip
	str	r0, [r4, #3908]
	bge	.L1350
.L1349:
	cmp	r8, #0
	ldreq	r3, [r5, #2908]
	addeq	r0, r0, r3
	streq	r0, [r4, #3908]
	ldrb	r3, [r7, #873]
	cmp	r3, #0
	bne	.L1352
	ldr	r2, [r4, #3872]
	ldr	r1, [r4, #3876]
	add	r2, r0, r2
	str	r2, [r4, #3856]
	ldr	r3, [r5, #2912]
	add	r3, r2, r3
	add	r0, r3, r1
	str	r0, [r4, #3860]
	cmp	r0, r2
	movge	r0, r2
	str	r0, [r4, #3868]
.L1353:
	add	r6, r6, #36864
	ldr	r2, [r6, #3888]
	ldr	r3, [r6, #3892]
	str	r0, [r6, #3864]
	str	r2, [r6, #3884]
	str	r3, [r6, #3896]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1342:
	str	r3, [r4, #3880]
	ldrb	r8, [r7, #880]
.L1345:
	mov	r0, #0
	str	r0, [r4, #3912]
	ldr	r3, [r5, #2916]
	cmp	r3, r0
	ble	.L1348
.L1365:
	add	ip, r5, #2912
	mov	r3, #0
	add	ip, ip, #4
	mov	r2, r3
.L1347:
	ldr	r1, [ip, #4]!
	add	r2, r2, #1
	add	r3, r3, r1
	str	r3, [r4, #3912]
	ldr	r1, [r5, #2916]
	cmp	r1, r2
	bgt	.L1347
	cmp	r0, #0
	bne	.L1381
.L1348:
	mov	r0, #0
	str	r0, [r4, #3908]
	b	.L1349
.L1380:
	add	r4, r0, #11075584
	add	r4, r4, #36864
.L1330:
	mov	r3, #0
	ldr	r0, [r4, #3836]
	str	r3, [r4, #3844]
	mov	lr, r3
	str	r3, [r4, #3848]
	mov	r1, ip
	b	.L1327
.L1379:
	add	r3, r6, #36864
	mov	r1, #0
	mov	r2, r1
	str	r1, [r3, #3892]
	str	r1, [r3, #3860]
	str	r1, [r3, #3856]
	str	r1, [r3, #3864]
	str	r1, [r3, #3868]
	ldr	r1, [r3, #3888]
	b	.L1356
.L1332:
	str	lr, [r4, #3852]
	ldrb	r3, [r7, #873]
	cmp	r3, #0
	beq	.L1382
.L1333:
	ldrb	r3, [r7, #874]
	cmp	r3, #0
	add	r3, r1, r0
	streq	r3, [r4, #3856]
	strne	r3, [r4, #3860]
	str	r3, [r4, #3868]
	b	.L1334
.L1352:
	ldrb	r3, [r7, #874]
	cmp	r3, #0
	ldrne	r2, [r5, #2912]
	ldreq	r3, [r4, #3872]
	ldrne	r3, [r4, #3872]
	addne	r0, r0, r2
	addeq	r0, r0, r3
	streq	r0, [r4, #3856]
	addne	r0, r0, r3
	strne	r0, [r4, #3860]
	str	r0, [r4, #3868]
	b	.L1353
.L1328:
	movw	r3, #3833
	ldrsb	r3, [r4, r3]
	cmp	r3, #0
	bne	.L1330
	ldr	r0, [r4, #3856]
	mov	r1, ip
	mov	lr, r3
	str	r3, [r4, #3844]
	mov	ip, r0
	str	r0, [r4, #3848]
	b	.L1329
.L1339:
	ldr	r1, [r4, #3888]
	ldr	r2, [r4, #3884]
	cmp	r1, r2
	bcs	.L1341
	ldr	r2, [r4, #3896]
	add	r3, r3, r2
	str	r3, [r4, #3892]
	b	.L1338
.L1363:
	ldrb	r0, [r7, #874]
	str	r3, [r4, #3864]
	cmp	r0, #0
	streq	r3, [r4, #3856]
	strne	r3, [r4, #3860]
	b	.L1356
.L1357:
	str	r1, [r4, #3884]
	mov	r2, r1
	str	r1, [r4, #3896]
	ldr	r1, [r4, #3888]
.L1359:
	str	r2, [r4, #3892]
	b	.L1360
.L1341:
	ldr	r3, [r4, #3896]
	b	.L1340
	.fnend
	.size	MVC_DecPOC, .-MVC_DecPOC
	.align	2
	.global	MVC_CalcPicNum
	.type	MVC_CalcPicNum, %function
MVC_CalcPicNum:
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
	add	r5, r0, #11141120
	add	r5, r5, #12288
	ldr	r3, [r0, #236]
	mov	r6, #1
	ldrb	r2, [r5, #1371]
	ldr	r3, [r3, #2896]
	cmp	r2, #0
	add	r3, r3, #4
	mov	r6, r6, asl r3
	add	r3, r0, #11075584
	beq	.L1384
	add	r3, r3, #45056
	sub	r7, r2, #1
	sub	r2, r2, #2
	clz	r7, r7
	ldr	r1, [r3, #2736]
	clz	r2, r2
	mov	r7, r7, lsr #5
	cmp	r1, #0
	mov	r2, r2, lsr #5
	movwne	lr, #47652
	movne	r1, #0
	movtne	lr, 169
	addne	lr, r0, lr
	beq	.L1404
.L1403:
	ldr	ip, [lr, #4]!
	ldrb	r4, [ip, #3]
	cmp	r4, #0
	beq	.L1398
	ldr	r4, [ip, #20]
	ldr	r8, [r5, #1984]
	cmp	r4, r8
	rsbhi	r4, r6, r4
	str	r4, [ip, #24]
	ldr	ip, [lr]
	ldrb	r4, [ip, #3]
	tst	r4, #1
	beq	.L1401
	ldr	r8, [ip, #700]
	bic	r8, r8, #-16777216
	bic	r8, r8, #255
	cmp	r8, #65536
	ldreq	r4, [ip, #24]
	addeq	r4, r7, r4, lsl #1
	streq	r4, [ip, #712]
	ldreq	ip, [lr]
	ldreqb	r4, [ip, #3]
.L1401:
	tst	r4, #2
	beq	.L1398
	ldr	r4, [ip, #736]
	bic	r4, r4, #-16777216
	bic	r4, r4, #255
	cmp	r4, #65536
	ldreq	r4, [ip, #24]
	addeq	r4, r2, r4, lsl #1
	streq	r4, [ip, #748]
.L1398:
	ldr	ip, [r3, #2736]
	add	r1, r1, #1
	cmp	ip, r1
	bhi	.L1403
.L1404:
	ldr	r1, [r3, #2740]
	cmp	r1, #0
	beq	.L1428
	movw	r4, #47716
	mov	ip, #0
	movt	r4, 169
	add	r4, r0, r4
.L1409:
	ldr	lr, [r4, #4]!
	add	ip, ip, #1
	ldrb	r1, [lr, #3]
	cmp	r1, #0
	beq	.L1406
	tst	r1, #1
	beq	.L1407
	ldr	r0, [lr, #700]
	bic	r0, r0, #-16777216
	bic	r0, r0, #255
	cmp	r0, #256
	ldreq	r1, [lr, #28]
	addeq	r1, r7, r1, lsl #1
	streq	r1, [lr, #708]
	ldreq	lr, [r4]
	ldreqb	r1, [lr, #3]
.L1407:
	tst	r1, #2
	beq	.L1406
	ldr	r1, [lr, #736]
	bic	r1, r1, #-16777216
	bic	r1, r1, #255
	cmp	r1, #256
	ldreq	r1, [lr, #28]
	addeq	r1, r2, r1, lsl #1
	streq	r1, [lr, #744]
.L1406:
	ldr	r1, [r3, #2740]
	cmp	r1, ip
	bhi	.L1409
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1384:
	add	r3, r3, #45056
	ldr	r1, [r3, #2736]
	cmp	r1, #0
	movwne	lr, #47652
	movtne	lr, 169
	addne	lr, r0, lr
	bne	.L1393
.L1394:
	ldr	r2, [r3, #2740]
	cmp	r2, #0
	beq	.L1429
	movw	ip, #47716
	mov	r2, #0
	movt	ip, 169
	add	ip, r0, ip
	b	.L1396
.L1395:
	ldr	r1, [r3, #2740]
	cmp	r1, r2
	bls	.L1430
.L1396:
	ldr	r1, [ip, #4]!
	add	r2, r2, #1
	ldrb	r0, [r1, #3]
	cmp	r0, #3
	bne	.L1395
	ldr	r0, [r1, #664]
	bic	r0, r0, #-16777216
	bic	r0, r0, #255
	cmp	r0, #256
	ldreq	r0, [r1, #28]
	streq	r0, [r1, #672]
	ldr	r1, [r3, #2740]
	cmp	r1, r2
	bhi	.L1396
.L1430:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1431:
	ldr	ip, [r1, #664]
	bic	ip, ip, #-16777216
	bic	ip, ip, #255
	cmp	ip, #65536
	bne	.L1390
	ldr	ip, [r1, #20]
	ldr	r4, [r5, #1984]
	rsb	r7, r6, ip
	cmp	ip, r4
	strhi	r7, [r1, #24]
	strls	ip, [r1, #24]
	ldr	r1, [lr]
	ldr	ip, [r1, #24]
	str	ip, [r1, #676]
.L1390:
	ldr	r1, [r3, #2736]
	add	r2, r2, #1
	cmp	r1, r2
	bls	.L1394
.L1393:
	ldr	r1, [lr, #4]!
	ldrb	ip, [r1, #3]
	cmp	ip, #3
	bne	.L1390
	b	.L1431
.L1429:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1428:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	MVC_CalcPicNum, .-MVC_CalcPicNum
	.align	2
	.global	MVC_IsOutDPB
	.type	MVC_IsOutDPB, %function
MVC_IsOutDPB:
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
	beq	.L1437
	add	r3, r0, #11075584
	add	r3, r3, #45056
	ldr	lr, [r3, #2728]
	cmp	lr, #0
	beq	.L1437
	ldr	r2, [r3, #2536]
	rsb	r3, r2, r1
	cmp	r2, #0
	clz	r3, r3
	mov	r3, r3, lsr #5
	moveq	r3, #0
	cmp	r3, #0
	bne	.L1439
	movw	ip, #47592
	movt	ip, 169
	add	ip, r0, ip
	b	.L1434
.L1435:
	ldr	r2, [ip, #4]!
	rsb	r0, r2, r1
	cmp	r2, #0
	clz	r0, r0
	mov	r0, r0, lsr #5
	moveq	r0, #0
	cmp	r0, #0
	bne	.L1439
.L1434:
	add	r3, r3, #1
	cmp	r3, lr
	bne	.L1435
.L1437:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L1439:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_IsOutDPB, .-MVC_IsOutDPB
	.align	2
	.global	mvc_combine_scalinglist
	.type	mvc_combine_scalinglist, %function
mvc_combine_scalinglist:
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
	cmp	r2, #0
	ldmlefd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	ldr	r6, .L1447
	mov	lr, #0
	mov	r5, #255
	sub	r7, r6, #16
.L1444:
	cmp	r2, #16
	ldreqb	ip, [lr, r7]
	ldrneb	ip, [lr, r6]
	add	lr, lr, #1
	cmp	lr, r2
	and	r3, ip, #3
	mov	r4, ip, lsr #2
	ldrb	r8, [r0, ip, asl #2]
	mov	r3, r3, asl #3
	ldr	ip, [r1, r4, asl #2]
	bic	ip, ip, r5, asl r3
	orr	r3, ip, r8, asl r3
	str	r3, [r1, r4, asl #2]
	bne	.L1444
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1448:
	.align	2
.L1447:
	.word	.LANCHOR0+16
	.fnend
	.size	mvc_combine_scalinglist, .-mvc_combine_scalinglist
	.align	2
	.global	mvc_assign_quant_params
	.type	mvc_assign_quant_params, %function
mvc_assign_quant_params:
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
	subs	r3, r0, #0
	str	r1, [fp, #-48]
	str	r3, [fp, #-52]
	beq	.L1480
	ldr	r3, [fp, #-48]
	cmp	r3, #0
	beq	.L1481
	ldr	r3, [fp, #-48]
	ldrb	r3, [r3, #18]
	cmp	r3, #0
	beq	.L1469
	ldr	r3, [fp, #-48]
	mov	r4, #0
	ldr	r1, [fp, #-52]
	add	r2, r3, #2016
	add	r8, r3, #1728
	str	r2, [fp, #-56]
	add	r9, r1, #2384
	mov	r6, r2
	add	r7, r3, #1984
	add	r5, r3, #5
	ldr	r10, .L1486
	b	.L1454
.L1484:
	cmp	r4, #0
	beq	.L1482
	cmp	r4, #3
	beq	.L1483
	ldr	r3, [r10, #52]
	mov	r2, #16
	sub	r1, r6, #16
	mov	r0, r6
	blx	r3
.L1462:
	add	r4, r4, #1
	cmp	r4, #7
	bhi	.L1469
.L1468:
	add	r8, r8, #64
	add	r9, r9, #64
	add	r6, r6, #16
	add	r7, r7, #4
	add	r5, r5, #1
.L1454:
	cmp	r4, #5
	ldrsb	r3, [r5]
	bhi	.L1455
	cmp	r3, #0
	beq	.L1484
	ldr	r3, [r7]
	cmp	r3, #0
	beq	.L1462
	ldr	r1, .L1486+4
	cmp	r4, #2
	mov	r2, #16
	ldr	r3, [r10, #52]
	add	r0, r1, r2
	add	r4, r4, #1
	movhi	r1, r0
	mov	r0, r6
	blx	r3
	cmp	r4, #7
	bls	.L1468
.L1469:
	mov	r0, #0
.L1451:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1455:
	cmp	r3, #0
	bne	.L1464
	ldr	r3, [fp, #-52]
	mov	r2, #64
	ldrb	r3, [r3, #27]
	cmp	r3, #0
	ldr	r3, [r10, #52]
	bne	.L1485
.L1479:
	ldr	r1, .L1486+8
	cmp	r4, #6
	add	r0, r1, r2
	movne	r1, r0
	mov	r0, r8
	blx	r3
	b	.L1462
.L1464:
	ldr	r3, [r7]
	cmp	r3, #0
	beq	.L1462
	ldr	r3, [r10, #52]
	mov	r2, #64
	b	.L1479
.L1485:
	mov	r1, r9
	mov	r0, r8
	blx	r3
	b	.L1462
.L1480:
	movw	r3, #6985
	ldr	r2, .L1486+12
	ldr	r1, .L1486+16
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1451
.L1481:
	mov	r0, r3
	ldr	r2, .L1486+12
	movw	r3, #6986
	ldr	r1, .L1486+16
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1451
.L1483:
	ldr	r3, [fp, #-52]
	mov	r2, #16
	ldr	r0, [fp, #-48]
	mov	r4, #4
	ldrb	r3, [r3, #27]
	add	r0, r0, #2064
	cmp	r3, #0
	ldr	r3, [r10, #52]
	ldrne	r1, [fp, #-52]
	ldreq	r1, .L1486+20
	addne	r1, r1, #2720
	blx	r3
	b	.L1468
.L1482:
	ldr	r3, [fp, #-52]
	mov	r2, #16
	ldr	r0, [fp, #-56]
	mov	r4, #1
	ldrb	r3, [r3, #27]
	cmp	r3, #0
	ldr	r3, [r10, #52]
	ldrne	r1, [fp, #-52]
	ldreq	r1, .L1486+4
	addne	r1, r1, #2672
	blx	r3
	b	.L1468
.L1487:
	.align	2
.L1486:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR1
	.word	.LANCHOR1+32
	.word	.LC13
	.word	.LC14
	.word	.LANCHOR1+16
	.fnend
	.size	mvc_assign_quant_params, .-mvc_assign_quant_params
	.align	2
	.global	MVC_WriteCurrPicYUV
	.type	MVC_WriteCurrPicYUV, %function
MVC_WriteCurrPicYUV:
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
	add	r5, r0, #11141120
	ldr	r1, .L1491
	add	r3, r5, #12288
	add	r5, r5, #12288
	mov	r0, #2
	ldrb	r4, [r3, #1371]
	ldr	r3, [r3, #1976]
	mov	r2, r4
	ldr	r3, [r3, #228]
	bl	dprint_vfmw
	ldr	ip, [r5, #2036]
	cmp	r4, #3
	cmpne	r4, #0
	ldr	r3, [r5, #2032]
	addne	r2, r4, #1
	ldr	r1, .L1491+4
	moveq	r2, #1
	str	ip, [sp]
	mov	r0, #22
	bl	dprint_vfmw
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1492:
	.align	2
.L1491:
	.word	.LC32
	.word	.LC33
	.fnend
	.size	MVC_WriteCurrPicYUV, .-MVC_WriteCurrPicYUV
	.align	2
	.global	MVC_WritePicMsg
	.type	MVC_WritePicMsg, %function
MVC_WritePicMsg:
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
	mov	r6, r0
	add	r4, r0, #11141120
	add	r7, r6, #11075584
	add	r5, r4, #12288
	add	ip, r7, #32768
	str	ip, [fp, #-52]
	ldr	lr, [r5, #2052]
	mov	r0, #2
	mov	r8, ip
	ldr	ip, [r5, #1540]
	ldrb	r3, [r5, #1371]
	add	r10, r4, #16384
	ldr	r2, [r5, #1992]
	add	r9, r7, #36864
	ldr	r1, .L1529
	stmia	sp, {ip, lr}
	bl	dprint_vfmw
	movw	r3, #14240
	movt	r3, 170
	mov	r2, #0
	str	r2, [r6, #64]
	ldrd	r0, [r6, r3]
	movw	r3, #15632
	movt	r3, 170
	strd	r0, [r6, r3]
	ldr	r3, [r6, #544]
	str	r3, [r10, #248]
	ldr	r3, [r5, #1524]
	str	r3, [r10, #28]
	ldr	r3, [r5, #1528]
	str	r3, [r10, #32]
	ldr	r3, [r5, #1532]
	str	r3, [r10, #36]
	ldr	r2, [r5, #1992]
	ldrb	r3, [r5, #1371]
	ldr	r0, [r5, #2036]
	str	r2, [r5, #3352]
	strb	r3, [r5, #3336]
	ldr	r3, [r6, #236]
	ldr	r1, [r5, #2040]
	ldrb	r2, [r3, #21]
	str	r0, [r5, #3356]
	str	r1, [r5, #3360]
	str	r2, [r5, #3368]
	ldr	r2, [r3, #3948]
	add	r2, r2, #1
	str	r2, [r5, #3364]
	ldrb	r2, [r8, #1716]
	strb	r2, [r5, #3339]
	ldr	r2, [r9, #1652]
	str	r2, [r5, #3372]
	ldrb	r2, [r9, #1592]
	str	r2, [r5, #3376]
	ldr	r3, [r3, #748]
	strb	r3, [r5, #3337]
	ldrb	r3, [r9, #1596]
	str	r3, [r5, #3380]
	ldr	r2, [r9, #3868]
	ldr	r3, [r5, #1976]
	str	r2, [r5, #3384]
	ldr	r2, [r9, #3856]
	str	r2, [r5, #3388]
	ldr	r2, [r9, #3860]
	str	r2, [r5, #3392]
	ldrsb	r1, [r3, #6]
	ldr	r0, [r6, #120]
	bl	FSP_GetLogicFs
	subs	r8, r0, #0
	beq	.L1527
	ldr	r2, [r8, #608]
	ldr	r3, [r8, #612]
	cmp	r2, #0
	beq	.L1497
	cmp	r3, #0
	beq	.L1497
	movw	r3, #16060
	movw	r2, #15932
	add	r1, r4, #16320
	ldr	r0, [r6, #120]
	movt	r3, 170
	movt	r2, 170
	add	r3, r6, r3
	add	r2, r6, r2
	bl	FSP_GetDecFsAddrTab
	ldr	r3, [r8, #608]
	movw	r2, #16324
	movw	r1, #16404
	movt	r2, 170
	movt	r1, 170
	ldr	r3, [r3, #8]
	add	r2, r6, r2
	add	r1, r6, r1
	add	r7, r7, #45056
	str	r3, [r5, #3628]
	ldr	r0, [r6, #120]
	bl	FSP_GetPmvAddrTab
	ldr	r3, [r5, #2052]
	str	r3, [r5, #3636]
	ldr	r3, [r8, #624]
	str	r3, [r10, #24]
	ldr	r3, [r8, #612]
	ldr	r3, [r3, #16]
	str	r3, [r5, #3632]
	ldr	r3, [r8, #612]
	ldr	r3, [r3, #76]
	str	r3, [r5, #3640]
	ldr	r3, [r7, #2956]
	cmp	r3, #0
	str	r3, [fp, #-48]
	str	r3, [r10, #240]
	beq	.L1503
	movw	r5, #47816
	movw	lr, #16428
	movw	ip, #47880
	movw	r0, #16492
	movw	r1, #47944
	movw	r2, #16556
	ldr	r10, [fp, #-48]
	movt	r5, 169
	movt	lr, 170
	movt	ip, 169
	movt	r0, 170
	movt	r1, 169
	movt	r2, 170
	add	r5, r6, r5
	add	lr, r6, lr
	add	ip, r6, ip
	add	r0, r6, r0
	add	r1, r6, r1
	add	r2, r6, r2
	mov	r3, #0
.L1502:
	ldr	r8, [r5, #4]!
	add	r3, r3, #1
	cmp	r3, r10
	str	r8, [lr, #4]!
	ldr	r8, [ip, #4]!
	str	r8, [r0, #4]!
	ldr	r8, [r1, #4]!
	str	r8, [r2, #4]!
	bne	.L1502
.L1503:
	ldr	r3, [fp, #-52]
	ldrb	r3, [r3, #1723]
	cmp	r3, #0
	bne	.L1528
	ldrb	ip, [r9, #1610]
	cmp	ip, #0
	bne	.L1504
	ldr	r0, .L1529+4
	add	r4, r4, #15680
.L1505:
	and	r3, ip, #3
	add	ip, ip, #1
	cmp	ip, #24
	add	r3, r0, r3, lsl #2
	ldr	r3, [r3, #352]
	bic	r2, r3, #16711680
	ubfx	r1, r3, #8, #8
	bic	r2, r2, #65280
	mov	r3, r3, lsr #8
	orr	r2, r2, r1, asl #16
	and	r3, r3, #65280
	orr	r3, r2, r3
	str	r3, [r4, #4]!
	bne	.L1505
	movw	r8, #15780
	mov	r5, #0
	movt	r8, 170
	add	r8, r6, r8
.L1506:
	add	r3, r5, #1
	and	r2, r5, #14
	and	r3, r3, #15
	add	r5, r5, #2
	add	r2, r0, r2, lsl #2
	cmp	r5, #32
	add	r3, r0, r3, lsl #2
	ldr	r1, [r2, #368]
	ldr	ip, [r3, #368]
	ubfx	r3, r1, #8, #8
	mov	r2, r1, lsr #24
	uxtb	r9, r1
	uxtb	r4, ip
	mov	lr, ip, lsr #16
	orr	r3, r3, r2, asl #8
	mov	r1, r1, lsr #8
	mov	r4, r4, asl #16
	and	r2, ip, #-16777216
	orr	lr, r4, lr, asl #24
	ubfx	ip, ip, #8, #8
	orr	r3, r3, r2
	orr	lr, lr, r9
	and	r1, r1, #65280
	orr	r3, r3, ip, asl #16
	orr	r2, lr, r1
	stmia	r8, {r2, r3}
	add	r8, r8, #8
	bne	.L1506
.L1511:
	ldr	r3, [fp, #-48]
	cmp	r3, #0
	beq	.L1508
	movw	r4, #47820
	movw	r9, #16760
	movw	r8, #16824
	movt	r4, 169
	movt	r9, 170
	movt	r8, 170
	add	r4, r6, r4
	add	r9, r6, r9
	add	r8, r6, r8
	mov	r5, #0
.L1514:
	ldr	r2, [r4]
	mov	r1, #0
	ldr	r0, [r6, #120]
	add	r5, r5, #1
	bl	FSP_GetStoreType
	adds	r0, r0, #0
	movne	r0, #1
	str	r0, [r9, #4]!
	ldr	r3, [r4], #4
	str	r3, [r8, #4]!
	ldr	r3, [r7, #2956]
	cmp	r3, r5
	bhi	.L1514
.L1508:
	mov	r0, #0
.L1524:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1528:
	ldrb	ip, [r9, #1610]
.L1504:
	cmp	ip, #1
	add	r4, r4, #15680
	mov	r0, #0
	beq	.L1509
.L1512:
	movw	r3, #25668
	movt	r3, 42
	add	r3, r0, r3
	add	r0, r0, #1
	ldr	r3, [r6, r3, asl #2]
	cmp	r0, #24
	bic	r2, r3, #16711680
	ubfx	r1, r3, #8, #8
	bic	r2, r2, #65280
	mov	r3, r3, lsr #8
	orr	r2, r2, r1, asl #16
	and	r3, r3, #65280
	orr	r3, r2, r3
	str	r3, [r4, #4]!
	bne	.L1512
	movw	r9, #15780
	mov	r10, #1
	movt	r9, 170
	add	r9, r6, r9
	mov	r8, #0
.L1513:
	mov	r2, r8, lsr #3
	mov	r3, r8, asl #1
	and	r1, r3, #14
	and	r0, r10, #15
	mov	r3, r2, asl #4
	movw	r2, #25692
	add	r0, r3, r0
	add	r3, r3, r1
	mov	r1, r2
	movt	r2, 42
	movt	r1, 42
	add	r2, r0, r2
	add	r1, r3, r1
	add	r8, r8, #1
	ldr	r2, [r6, r2, asl #2]
	cmp	r8, #16
	ldr	r3, [r6, r1, asl #2]
	add	r10, r10, #2
	ubfx	r5, r2, #8, #8
	and	lr, r2, #-16777216
	mov	r0, r2, lsr #16
	uxtb	r1, r2
	mov	ip, r3, lsr #24
	uxtb	r4, r3
	mov	r2, r0, asl #24
	mov	r0, r3, lsr #8
	mov	ip, ip, asl #8
	orr	r2, r2, r1, asl #16
	orr	ip, ip, r5, asl #16
	orr	r1, r2, r4
	ubfx	r3, r3, #8, #8
	and	r2, r0, #65280
	orr	ip, ip, lr
	orr	r2, r1, r2
	orr	r3, ip, r3
	stmia	r9, {r2, r3}
	add	r9, r9, #8
	bne	.L1513
	b	.L1511
.L1509:
	movw	r3, #26502
	movt	r3, 42
	add	r3, r0, r3
	add	r0, r0, #1
	ldr	r3, [r6, r3, asl #2]
	cmp	r0, #24
	bic	r2, r3, #16711680
	ubfx	r1, r3, #8, #8
	bic	r2, r2, #65280
	mov	r3, r3, lsr #8
	orr	r2, r2, r1, asl #16
	and	r3, r3, #65280
	orr	r3, r2, r3
	str	r3, [r4, #4]!
	bne	.L1509
	movw	r9, #15780
	mov	r10, #1
	movt	r9, 170
	add	r9, r6, r9
	mov	r8, #0
.L1510:
	mov	r2, r8, lsr #3
	mov	r3, r8, asl #1
	and	r1, r3, #14
	and	r0, r10, #15
	mov	r3, r2, asl #4
	movw	r2, #26526
	add	r0, r3, r0
	add	r3, r3, r1
	mov	r1, r2
	movt	r2, 42
	movt	r1, 42
	add	r2, r0, r2
	add	r1, r3, r1
	add	r8, r8, #1
	ldr	r2, [r6, r2, asl #2]
	cmp	r8, #16
	ldr	r3, [r6, r1, asl #2]
	add	r10, r10, #2
	ubfx	r5, r2, #8, #8
	and	lr, r2, #-16777216
	mov	r0, r2, lsr #16
	uxtb	r1, r2
	mov	ip, r3, lsr #24
	uxtb	r4, r3
	mov	r2, r0, asl #24
	mov	r0, r3, lsr #8
	mov	ip, ip, asl #8
	orr	r2, r2, r1, asl #16
	orr	ip, ip, r5, asl #16
	orr	r1, r2, r4
	ubfx	r3, r3, #8, #8
	and	r2, r0, #65280
	orr	ip, ip, lr
	orr	r2, r1, r2
	orr	r3, ip, r3
	stmia	r9, {r2, r3}
	add	r9, r9, #8
	bne	.L1510
	b	.L1511
.L1497:
	ldr	r1, .L1529+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1524
.L1527:
	ldr	r3, [r5, #1976]
	ldr	r1, .L1529+12
	ldrsb	r2, [r3, #6]
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1524
.L1530:
	.align	2
.L1529:
	.word	.LC34
	.word	.LANCHOR1
	.word	.LC36
	.word	.LC35
	.fnend
	.size	MVC_WritePicMsg, .-MVC_WritePicMsg
	.align	2
	.global	MVC_UpdatePicQpInf
	.type	MVC_UpdatePicQpInf, %function
MVC_UpdatePicQpInf:
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
	ldr	r2, [r1, #28]
	ldr	r3, [r1, #32]
	cmp	r2, r0
	movlt	r2, r0
	cmp	r3, r0
	str	r2, [r1, #28]
	movge	r3, r0
	str	r3, [r1, #32]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_UpdatePicQpInf, .-MVC_UpdatePicQpInf
	.align	2
	.global	MVC_WriteSliceMsg
	.type	MVC_WriteSliceMsg, %function
MVC_WriteSliceMsg:
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
	ldr	r3, [r0, #64]
	movw	r1, #4060
	mov	r4, r0
	mov	ip, r3
	str	r3, [fp, #-48]
	mul	r1, r1, ip
	ldr	r3, [r0, #32]
	ldr	r0, [r0, #544]
	add	r2, ip, #1
	sub	r3, r3, #1
	str	r2, [r4, #64]
	cmp	ip, r3
	add	r6, r0, r1
	addcc	r3, r1, #4048
	addcc	r3, r3, #12
	movcs	r3, #0
	addcc	r3, r0, r3
	str	r3, [r6, #4056]
	ldr	r2, [r4, #232]
	ldrb	ip, [r2]
	ldr	r3, [r2, #68]
	cmp	ip, #1
	cmpls	ip, r3
	bcs	.L1535
	add	lr, ip, #3
	add	lr, r6, lr, lsl #2
.L1536:
	mov	r3, ip, asl #5
	sub	r3, r3, ip, asl #2
	add	ip, ip, #1
	add	r2, r2, r3
	ldr	r2, [r2, #24]
	str	r2, [lr, #4]!
	ldr	r2, [r4, #232]
	add	r2, r2, r3
	ldr	r2, [r2, #20]
	str	r2, [lr, #-8]
	ldr	r2, [r4, #232]
	add	r3, r2, r3
	ldr	r3, [r3, #28]
	str	r3, [lr, #8]
	ldr	r2, [r4, #232]
	ldr	r3, [r2, #68]
	cmp	r3, ip
	movhi	r5, #1
	movls	r5, #0
	cmp	ip, #1
	movhi	r5, #0
	cmp	r5, #0
	bne	.L1536
.L1535:
	cmp	r3, #1
	bhi	.L1541
	add	r3, r3, #3
	add	ip, r6, #20
	mov	r2, #0
	add	r3, r6, r3, lsl #2
.L1540:
	str	r2, [r3, #4]!
	cmp	r3, ip
	str	r2, [r3, #-8]
	str	r2, [r3, #8]
	bne	.L1540
.L1541:
	add	r8, r4, #11141120
	ldr	r3, [fp, #-48]
	add	r8, r8, #12288
	add	r5, r4, #11075584
	cmp	r3, #0
	add	r9, r5, #36864
	ldrb	r3, [r8, #1377]
	add	r5, r5, #40960
	strb	r3, [r6, #1]
	ldr	r3, [r9, #1640]
	ldr	r2, [r5, #2488]
	add	r3, r3, #26
	add	r3, r3, r2
	str	r3, [r6, #32]
	bne	.L1635
	ldr	r2, [r8, #1976]
	str	r3, [r2, #692]
	ldr	r3, [r8, #1976]
	ldr	r2, [r6, #32]
	str	r2, [r3, #696]
.L1542:
	ldr	r3, [r5, #2484]
	str	r3, [r6, #36]
	ldr	r3, [r5, #936]
	str	r3, [r6, #40]
	ldr	r3, [r5, #932]
	str	r3, [r6, #44]
	ldrb	r3, [r5, #872]
	strb	r3, [r0, r1]
	ldr	r3, [r5, #928]
	str	r3, [r6, #48]
	ldrb	r3, [r5, #878]
	strb	r3, [r6, #2]
	ldr	r3, [r4, #236]
	ldrb	r3, [r3, #22]
	strb	r3, [r6, #3]
	ldr	r3, [r5, #920]
	str	r3, [r6, #52]
	ldr	r3, [r5, #924]
	str	r3, [r6, #56]
	ldrb	r3, [r5, #872]
	cmp	r3, #1
	ldreq	r3, [r9, #1636]
	streqb	r3, [r6, #4]
	beq	.L1544
	cmp	r3, #0
	ldreqb	r3, [r9, #1594]
	movne	r3, #0
	strb	r3, [r6, #4]
.L1544:
	ldr	r3, [r9, #1644]
	str	r3, [r6, #60]
	ldr	r3, [r9, #1648]
	str	r3, [r6, #64]
	ldr	r3, [r5, #2496]
	str	r3, [r6, #68]
	ldr	r3, [r5, #2500]
	str	r3, [r6, #72]
	ldr	r3, [r5, #2492]
	str	r3, [r6, #76]
	ldrb	r3, [r5, #872]
	cmp	r3, #2
	beq	.L1583
	ldr	r7, [r5, #920]
	cmp	r7, #0
	beq	.L1586
	ldr	r3, [r4, #256]
	ldr	r2, [r3, #4]
	ldrb	r3, [r2, #1]
	cmp	r3, #0
	addne	r1, r4, #256
	movne	r3, #0
	bne	.L1551
	b	.L1549
.L1553:
	ldr	r2, [r1, #4]!
	ldr	r2, [r2, #4]
	ldrb	r0, [r2, #1]
	cmp	r0, #0
	beq	.L1549
.L1551:
	add	r3, r3, #1
	cmp	r3, r7
	bne	.L1553
	mov	r3, #0
	str	r3, [fp, #-52]
.L1548:
	ldr	ip, [r5, #924]
	cmp	ip, #0
	beq	.L1587
	ldr	r3, [r4, #388]
	ldr	r2, [r3, #4]
	ldrb	r3, [r2, #1]
	cmp	r3, #0
	addne	r1, r4, #388
	movne	r3, #0
	bne	.L1557
	b	.L1555
.L1559:
	ldr	r2, [r1, #4]!
	ldr	r2, [r2, #4]
	ldrb	r0, [r2, #1]
	cmp	r0, #0
	beq	.L1555
.L1557:
	add	r3, r3, #1
	cmp	r3, ip
	bne	.L1559
	mov	r3, #0
	str	r3, [fp, #-56]
.L1554:
	ldrb	ip, [r8, #1371]
	ldr	r3, [r5, #920]
	cmp	ip, #0
	beq	.L1560
	cmp	r3, #0
	beq	.L1575
	mov	r3, r6
	mov	r7, #0
	str	r6, [fp, #-60]
	add	r10, r4, #256
	mov	r6, r7
	str	r8, [fp, #-64]
	mov	r7, r3
	mov	r8, r5
	ldr	r5, [fp, #-52]
	b	.L1574
.L1572:
	strb	r1, [r7, #1630]
	ldr	r1, [r10]
	ldrb	r1, [r1, #1]
	strb	r1, [r7, #1631]
	ldr	r1, [r10]
	ldr	r1, [r1, #16]
	str	r1, [r7, #1656]
.L1573:
	ldr	r1, [r8, #920]
	add	r6, r6, #1
	add	r10, r10, #4
	add	r7, r7, #36
	cmp	r1, r6
	bls	.L1636
.L1574:
	ldr	r1, [r10]
	ldr	r0, [r4, #120]
	ldr	r1, [r1, #4]
	ldrsb	r1, [r1, #6]
	bl	FSP_GetLogicFs
	ldr	r1, [r10]
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #48]
	str	r1, [r7, #1636]
	ldr	r1, [r10]
	ldr	r1, [r1, #4]
	ldrb	r1, [r1, #2]
	strb	r1, [r7, #1625]
	ldr	r1, [r10]
	ldr	r1, [r1, #4]
	ldrb	r1, [r1, #1]
	cmp	r1, #1
	moveq	r0, r5
	beq	.L1571
	cmp	r0, #0
	ldrne	r1, [r0, #608]
	ldrne	r0, [r1, #8]
.L1571:
	str	r0, [r7, #1640]
	ldr	r1, [r10]
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #52]
	str	r1, [r7, #1644]
	ldr	r1, [r10]
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #32]
	str	r1, [r7, #1632]
	ldr	r1, [r10]
	ldrb	r1, [r1]
	strb	r1, [r7, #1624]
	ldr	r1, [r10]
	ldr	r1, [r1, #4]
	ldrb	r1, [r1, #664]
	strb	r1, [r7, #1626]
	ldr	r1, [r10]
	ldrb	r1, [r1]
	cmp	r1, #1
	bne	.L1572
	strb	r1, [r7, #1628]
	ldr	r1, [r10]
	ldrb	r1, [r1, #1]
	strb	r1, [r7, #1629]
	ldr	r1, [r10]
	ldr	r1, [r1, #16]
	str	r1, [r7, #1652]
	b	.L1573
.L1636:
	mov	r5, r8
	ldr	r6, [fp, #-60]
	ldr	r8, [fp, #-64]
.L1575:
	ldrb	r3, [r5, #872]
	cmp	r3, #1
	beq	.L1637
.L1563:
	movw	r2, #48016
	add	r3, r6, #3920
	add	r0, r6, #4048
	movt	r2, 169
	add	r3, r3, #4
	add	r2, r4, r2
	add	r0, r0, #4
.L1580:
	ldr	r1, [r2, #4]!
	str	r1, [r3, #4]!
	cmp	r3, r0
	bne	.L1580
	ldrb	r3, [r9, #1594]
	cmp	r3, #0
	str	r3, [r8, #3620]
	ldr	r3, [r9, #1636]
	str	r3, [r8, #3624]
	beq	.L1581
	ldrb	r2, [r5, #872]
	cmp	r2, #0
	beq	.L1582
.L1581:
	cmp	r3, #1
	beq	.L1638
.L1583:
	ldr	r2, [fp, #-48]
	movw	r3, #36536
	movt	r3, 42
	ldr	r1, [r4, #232]
	add	r3, r2, r3
	mov	r2, #0
	add	r3, r4, r3, lsl #2
	str	r1, [r3, #4]
	str	r2, [r4, #232]
.L1532:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1635:
	ldr	r2, [r8, #1976]
	ldr	lr, [r2, #692]
	ldr	ip, [r2, #696]
	cmp	lr, r3
	movlt	lr, r3
	cmp	ip, r3
	str	lr, [r2, #692]
	movge	ip, r3
	str	ip, [r2, #696]
	b	.L1542
.L1549:
	ldrsb	r1, [r2, #6]
	ldr	r0, [r4, #120]
	bl	FSP_GetLogicFs
	subs	r3, r0, #0
	beq	.L1639
	ldr	r3, [r3, #608]
	ldr	r3, [r3, #8]
	str	r3, [fp, #-52]
	b	.L1548
.L1638:
	ldrb	r3, [r5, #872]
	cmp	r3, #1
	bne	.L1583
.L1582:
	ldr	r3, [r5, #940]
	movw	r8, #41904
	movw	r7, #42032
	movw	lr, #42160
	movw	ip, #42672
	movw	r0, #42800
	str	r3, [r6, #80]
	movw	r1, #42928
	ldr	r10, [r5, #944]
	movt	r8, 169
	movt	r7, 169
	movt	lr, 169
	movt	ip, 169
	movt	r0, 169
	movt	r1, 169
	add	r8, r4, r8
	add	r7, r4, r7
	add	lr, r4, lr
	add	ip, r4, ip
	add	r0, r4, r0
	add	r1, r4, r1
	mov	r9, r6
	mov	r3, r6
	mov	r2, #0
	str	r6, [fp, #-52]
	str	r10, [r9, #84]!
.L1584:
	ldr	r10, [r8, #4]!
	add	r2, r2, #1
	add	r3, r3, #4
	str	r10, [r9, #4]!
	ldr	r10, [r7, #4]!
	str	r10, [r3, #212]
	ldr	r10, [lr, #4]!
	str	r10, [r3, #340]
	ldr	r10, [ip, #4]!
	str	r10, [r3, #852]
	ldr	r10, [r0, #4]!
	str	r10, [r3, #980]
	ldr	r10, [r1, #4]!
	str	r10, [r3, #1108]
	ldr	r10, [r5, #932]
	cmp	r10, r2
	bcs	.L1584
	ldrb	r3, [r5, #872]
	cmp	r3, #1
	bne	.L1583
	movw	r7, #42288
	movw	lr, #42416
	movw	ip, #42544
	movw	r0, #43056
	movw	r1, #43184
	movw	r2, #43312
	ldr	r8, [fp, #-52]
	movt	r7, 169
	movt	lr, 169
	movt	ip, 169
	movt	r0, 169
	movt	r1, 169
	movt	r2, 169
	add	r6, r6, #468
	add	r7, r4, r7
	add	lr, r4, lr
	add	ip, r4, ip
	add	r0, r4, r0
	add	r1, r4, r1
	add	r2, r4, r2
	mov	r3, #0
.L1585:
	ldr	r9, [r7, #4]!
	add	r3, r3, #1
	add	r8, r8, #4
	str	r9, [r6, #4]!
	ldr	r9, [lr, #4]!
	str	r9, [r8, #596]
	ldr	r9, [ip, #4]!
	str	r9, [r8, #724]
	ldr	r9, [r0, #4]!
	str	r9, [r8, #1236]
	ldr	r9, [r1, #4]!
	str	r9, [r8, #1364]
	ldr	r9, [r2, #4]!
	str	r9, [r8, #1492]
	ldr	r9, [r5, #936]
	cmp	r9, r3
	bcs	.L1585
	b	.L1583
.L1560:
	cmp	r3, #0
	beq	.L1568
	add	r2, r4, #256
	str	r8, [fp, #-64]
	mov	r8, r5
	ldr	r5, [fp, #-52]
	mov	r7, r6
	str	r6, [fp, #-60]
	mov	r10, r2
	mov	r6, ip
.L1567:
	ldr	r1, [r10]
	ldr	r0, [r4, #120]
	ldr	r1, [r1, #4]
	ldrsb	r1, [r1, #6]
	bl	FSP_GetLogicFs
	ldr	r1, [r10]
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #48]
	str	r1, [r7, #1636]
	ldr	r1, [r10]
	ldr	r1, [r1, #4]
	ldrb	r1, [r1, #2]
	strb	r1, [r7, #1625]
	ldr	r1, [r10]
	ldr	r1, [r1, #4]
	ldrb	r1, [r1, #1]
	cmp	r1, #1
	moveq	r0, r5
	beq	.L1566
	cmp	r0, #0
	ldrne	r1, [r0, #608]
	ldrne	r0, [r1, #8]
.L1566:
	str	r0, [r7, #1640]
	mov	r3, #0
	ldr	r1, [r10]
	add	r6, r6, #1
	add	r7, r7, #36
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #52]
	str	r1, [r7, #1608]
	ldr	r1, [r10]
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #32]
	str	r1, [r7, #1596]
	ldr	r1, [r10]
	ldrb	r1, [r1, #1]
	strb	r1, [r7, #1591]
	ldr	r1, [r10]
	ldrb	r1, [r1]
	strb	r1, [r7, #1590]
	ldr	r1, [r10]
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #680]
	str	r1, [r7, #1612]
	ldr	r1, [r10]
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #716]
	str	r1, [r7, #1616]
	ldr	r1, [r10], #4
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #752]
	strb	r3, [r7, #1588]
	str	r1, [r7, #1620]
	ldr	r1, [r8, #920]
	cmp	r1, r6
	bhi	.L1567
	mov	r5, r8
	ldr	r6, [fp, #-60]
	ldr	r8, [fp, #-64]
.L1568:
	ldrb	r3, [r5, #872]
	cmp	r3, #1
	bne	.L1563
	ldr	r3, [r5, #924]
	cmp	r3, #0
	beq	.L1563
	add	r3, r4, #388
	str	r8, [fp, #-60]
	mov	r8, r5
	ldr	r5, [fp, #-56]
	mov	r7, #0
	mov	r10, r6
	str	r6, [fp, #-52]
	mov	r6, r7
	mov	r7, r3
.L1570:
	ldr	r1, [r7]
	ldr	r0, [r4, #120]
	ldr	r1, [r1, #4]
	ldrsb	r1, [r1, #6]
	bl	FSP_GetLogicFs
	ldr	r1, [r7]
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #48]
	str	r1, [r10, #2788]
	ldr	r1, [r7]
	ldr	r1, [r1, #4]
	ldrb	r1, [r1, #2]
	strb	r1, [r10, #2777]
	ldr	r1, [r7]
	ldr	r1, [r1, #4]
	ldrb	r1, [r1, #1]
	cmp	r1, #1
	moveq	r0, r5
	beq	.L1569
	cmp	r0, #0
	ldrne	r1, [r0, #608]
	ldrne	r0, [r1, #8]
.L1569:
	str	r0, [r10, #1640]
	mov	r3, #0
	ldr	r1, [r7]
	add	r6, r6, #1
	add	r10, r10, #36
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #52]
	str	r1, [r10, #2760]
	ldr	r1, [r7]
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #32]
	str	r1, [r10, #2748]
	ldr	r1, [r7]
	ldrb	r1, [r1, #1]
	strb	r1, [r10, #2743]
	ldr	r1, [r7]
	ldrb	r1, [r1]
	strb	r1, [r10, #2742]
	ldr	r1, [r7]
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #680]
	str	r1, [r10, #2764]
	ldr	r1, [r7]
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #716]
	str	r1, [r10, #2768]
	ldr	r1, [r7], #4
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #752]
	strb	r3, [r10, #2740]
	str	r1, [r10, #2772]
	ldr	r1, [r8, #924]
	cmp	r1, r6
	bhi	.L1570
.L1631:
	mov	r5, r8
	ldr	r6, [fp, #-52]
	ldr	r8, [fp, #-60]
	b	.L1563
.L1555:
	ldrsb	r1, [r2, #6]
	ldr	r0, [r4, #120]
	bl	FSP_GetLogicFs
	subs	r3, r0, #0
	beq	.L1640
	ldr	r3, [r3, #608]
	ldr	r3, [r3, #8]
	str	r3, [fp, #-56]
	b	.L1554
.L1637:
	ldr	r3, [r5, #924]
	cmp	r3, #0
	beq	.L1563
	mov	r3, #0
	mov	r10, r6
	str	r6, [fp, #-52]
	add	r7, r4, #388
	str	r8, [fp, #-60]
	mov	r6, r3
	mov	r8, r5
	ldr	r5, [fp, #-56]
	b	.L1579
.L1577:
	strb	r1, [r10, #2782]
	ldr	r1, [r7]
	ldrb	r1, [r1, #1]
	strb	r1, [r10, #2783]
	ldr	r1, [r7]
	ldr	r1, [r1, #16]
	str	r1, [r10, #2808]
.L1578:
	ldr	r1, [r8, #924]
	add	r6, r6, #1
	add	r7, r7, #4
	add	r10, r10, #36
	cmp	r1, r6
	bls	.L1631
.L1579:
	ldr	r1, [r7]
	ldr	r0, [r4, #120]
	ldr	r1, [r1, #4]
	ldrsb	r1, [r1, #6]
	bl	FSP_GetLogicFs
	ldr	r1, [r7]
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #48]
	str	r1, [r10, #2788]
	ldr	r1, [r7]
	ldr	r1, [r1, #4]
	ldrb	r1, [r1, #2]
	strb	r1, [r10, #2777]
	ldr	r1, [r7]
	ldr	r1, [r1, #4]
	ldrb	r1, [r1, #1]
	cmp	r1, #1
	moveq	r0, r5
	beq	.L1576
	cmp	r0, #0
	ldrne	r1, [r0, #608]
	ldrne	r0, [r1, #8]
.L1576:
	str	r0, [r10, #2792]
	ldr	r1, [r7]
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #52]
	str	r1, [r10, #2796]
	ldr	r1, [r7]
	ldr	r1, [r1, #4]
	ldr	r1, [r1, #32]
	str	r1, [r10, #2784]
	ldr	r1, [r7]
	ldrb	r1, [r1]
	strb	r1, [r10, #2776]
	ldr	r1, [r7]
	ldr	r1, [r1, #4]
	ldrb	r1, [r1, #664]
	strb	r1, [r10, #2778]
	ldr	r1, [r7]
	ldrb	r1, [r1]
	cmp	r1, #1
	bne	.L1577
	strb	r1, [r10, #2780]
	ldr	r1, [r7]
	ldrb	r1, [r1, #1]
	strb	r1, [r10, #2781]
	ldr	r1, [r7]
	ldr	r1, [r1, #16]
	str	r1, [r10, #2804]
	b	.L1578
.L1587:
	str	ip, [fp, #-56]
	b	.L1554
.L1586:
	str	r7, [fp, #-52]
	b	.L1548
.L1640:
	movw	r3, #8068
	ldr	r2, .L1641
	ldr	r1, .L1641+4
	bl	dprint_vfmw
	b	.L1532
.L1639:
	movw	r3, #8047
	ldr	r2, .L1641
	ldr	r1, .L1641+4
	bl	dprint_vfmw
	b	.L1532
.L1642:
	.align	2
.L1641:
	.word	.LANCHOR0+80
	.word	.LC37
	.fnend
	.size	MVC_WriteSliceMsg, .-MVC_WriteSliceMsg
	.align	2
	.global	MVC_StopPicNum
	.type	MVC_StopPicNum, %function
MVC_StopPicNum:
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
	.size	MVC_StopPicNum, .-MVC_StopPicNum
	.align	2
	.global	MVC_GetPicStreamSize
	.type	MVC_GetPicStreamSize, %function
MVC_GetPicStreamSize:
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
	add	r0, r0, #11141120
	add	r0, r0, #16384
	ldr	r2, [r0, #248]
	cmp	r2, #0
	beq	.L1647
	mov	r0, #0
.L1646:
	ldr	r3, [r2, #8]
	ldr	r1, [r2, #12]
	ldr	r2, [r2, #4056]
	add	r3, r3, r1
	add	r3, r3, #7
	cmp	r2, #0
	add	r0, r0, r3, lsr #3
	bne	.L1646
	ldmfd	sp, {fp, sp, pc}
.L1647:
	mov	r0, r2
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_GetPicStreamSize, .-MVC_GetPicStreamSize
	.align	2
	.global	MVC_SliceCheck
	.type	MVC_SliceCheck, %function
MVC_SliceCheck:
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
	ldr	r1, .L1660
	mov	r4, r0
	add	r5, r0, #11075584
	bl	mvc_ue_v
	add	r5, r5, #40960
	str	r0, [r5, #928]
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L1658
	cmp	r0, #262144
	bcs	.L1659
	ldr	r2, [r4, #12]
	ldr	r3, [r4, #16]
	mul	r3, r3, r2
	sub	r3, r3, #1
	cmp	r0, r3
	bhi	.L1658
	ldr	r1, .L1660+4
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r1, .L1660+8
	mov	r2, r0
	mov	r6, r0
	mov	r0, #19
	bl	dprint_vfmw
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L1658
	cmp	r6, #9
	bhi	.L1654
	mov	r1, #1
	movw	r0, #297
	mov	r2, r1, asl r6
	and	r0, r0, r2
	cmp	r0, #0
	bne	.L1655
	ands	r3, r2, #660
	bne	.L1656
	tst	r2, #66
	beq	.L1654
	strb	r1, [r5, #872]
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1655:
	strb	r3, [r5, #872]
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1654:
	mov	r2, r6
	ldr	r1, .L1660+12
	mov	r0, #1
	bl	dprint_vfmw
.L1658:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1656:
	mov	r3, #2
	strb	r3, [r5, #872]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1659:
	ldr	r1, .L1660+16
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1661:
	.align	2
.L1660:
	.word	.LC38
	.word	.LC40
	.word	.LC41
	.word	.LC42
	.word	.LC39
	.fnend
	.size	MVC_SliceCheck, .-MVC_SliceCheck
	.align	2
	.global	MVC_PPSSPSCheck
	.type	MVC_PPSSPSCheck, %function
MVC_PPSSPSCheck:
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
	add	r5, r0, #11075584
	add	r5, r5, #40960
	mov	r4, r0
	ldr	r1, .L1674
	mov	r0, #19
	ldr	r2, [r5, #888]
	bl	dprint_vfmw
	ldr	r3, [r4, #252]
	ldr	r2, [r5, #888]
	mov	r1, #2240
	mla	r1, r1, r2, r3
	ldrb	r3, [r1, #19]
	cmp	r3, #0
	beq	.L1672
	ldrb	r3, [r5, #884]
	sxtb	r5, r3
	cmn	r5, #1
	beq	.L1673
	cmp	r3, #0
	bne	.L1667
	ldr	r2, [r1, #28]
	movw	r3, #8500
	movt	r3, 5
	mul	r3, r3, r2
	add	r0, r4, r3
	add	ip, r0, #12992
	add	r3, r0, #286720
	add	ip, ip, #8
	add	r3, r3, #932
	ldrb	ip, [ip, #4]
	cmp	ip, #0
	beq	.L1668
	add	r0, r0, #286720
	ldrb	r0, [r0, #957]
	cmp	r0, #0
	beq	.L1668
.L1666:
	mov	r0, #0
	str	r1, [r4, #244]
	str	r3, [r4, #240]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1673:
	ldr	r0, [r4, #248]
	movw	r3, #3992
	ldr	r2, [r1, #28]
	mla	r3, r3, r2, r0
	ldrb	r0, [r3, #25]
	cmp	r0, #0
	bne	.L1666
	ldr	r1, .L1674+4
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r5
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1668:
	ldr	r1, .L1674+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1672:
	ldr	r1, .L1674+12
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1667:
	mov	r2, r5
	ldr	r1, .L1674+16
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1675:
	.align	2
.L1674:
	.word	.LC43
	.word	.LC45
	.word	.LC46
	.word	.LC44
	.word	.LC31
	.fnend
	.size	MVC_PPSSPSCheck, .-MVC_PPSSPSCheck
	.align	2
	.global	MVC_PPSSPSCheckTmpId
	.type	MVC_PPSSPSCheckTmpId, %function
MVC_PPSSPSCheckTmpId:
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
	mov	r2, r1
	mov	r5, r1
	mov	r4, r0
	ldr	r1, .L1685
	mov	r0, #19
	bl	dprint_vfmw
	ldr	r2, [r4, #252]
	mov	r3, #2240
	mla	r3, r3, r5, r2
	ldrb	r2, [r3, #19]
	cmp	r2, #0
	beq	.L1682
	ldr	r1, [r4, #36]
	ldr	r2, [r3, #28]
	sub	r3, r1, #1
	cmp	r2, r3
	bhi	.L1683
	movw	r3, #41844
	movt	r3, 169
	add	r3, r4, r3
	ldrsb	r5, [r3]
	cmn	r5, #1
	beq	.L1684
.L1681:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1684:
	ldr	r1, [r4, #248]
	movw	r3, #3992
	mla	r3, r3, r2, r1
	ldrb	r3, [r3, #25]
	cmp	r3, #0
	bne	.L1681
	ldr	r1, .L1685+4
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r5
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1682:
	mov	r2, r5
	ldr	r1, .L1685+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1683:
	ldr	r1, .L1685+12
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1686:
	.align	2
.L1685:
	.word	.LC47
	.word	.LC50
	.word	.LC48
	.word	.LC49
	.fnend
	.size	MVC_PPSSPSCheckTmpId, .-MVC_PPSSPSCheckTmpId
	.align	2
	.global	MVC_IsNewPic
	.type	MVC_IsNewPic, %function
MVC_IsNewPic:
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
	add	ip, r0, #11075584
	ldr	lr, [r0, #236]
	add	r3, ip, #40960
	ldr	r0, [r3, #2536]
	ldr	r1, [lr, #744]
	ldr	r2, [r3, #2540]
	ldr	r4, [r3, #888]
	ldr	r6, [r3, #2544]
	cmp	r2, r4
	cmpeq	r0, r1
	ldr	r5, [r3, #900]
	ldrb	r4, [r3, #2528]
	ldrb	r0, [r3, #873]
	movne	r1, #1
	moveq	r1, #0
	cmp	r6, r5
	moveq	r2, r1
	orrne	r2, r1, #1
	cmp	r4, r0
	orrne	r2, r2, #1
	cmp	r4, #0
	cmpne	r0, #0
	beq	.L1689
	ldrb	r0, [r3, #2529]
	ldrb	r1, [r3, #874]
	cmp	r0, r1
	orrne	r2, r2, #1
.L1689:
	ldrb	r1, [r3, #2531]
	ldrb	r0, [r3, #880]
	cmp	r1, r0
	moveq	r1, #0
	beq	.L1690
	cmp	r0, #0
	cmpne	r1, #0
	moveq	r1, #1
	movne	r1, #0
.L1690:
	ldrb	r0, [r3, #2530]
	ldrb	r4, [r3, #875]
	cmp	r0, r4
	orrne	r2, r2, #1
	cmp	r4, #5
	cmpeq	r0, #5
	orr	r2, r2, r1
	beq	.L1702
.L1691:
	ldr	r1, [lr, #2900]
	cmp	r1, #0
	bne	.L1692
	add	r1, ip, #36864
	ldr	r0, [r3, #2556]
	ldr	r4, [r3, #2552]
	ldr	r5, [r1, #3840]
	ldr	lr, [r1, #3836]
	cmp	r4, lr
	cmpeq	r0, r5
	movne	r1, #1
	moveq	r1, #0
	orr	r2, r2, r1
.L1693:
	ldrb	r1, [r3, #883]
	cmp	r1, #0
	beq	.L1694
	ldr	r1, [r3, #2572]
	ldrb	r0, [r3, #2532]
	ldrb	r6, [r3, #881]
	ldr	r5, [r3, #2512]
	ldrb	r4, [r3, #2533]
	cmp	r1, r5
	cmpeq	r0, r6
	ldrb	lr, [r3, #882]
	movne	r1, #1
	moveq	r1, #0
	cmp	r4, lr
	moveq	r3, r1
	orrne	r3, r1, #1
	orr	r2, r2, r3
.L1694:
	add	r3, ip, #40960
	ldr	r1, .L1703
	mov	r0, #19
	ldr	r4, [r3, #928]
	cmp	r4, #0
	movne	r4, r2
	orreq	r4, r2, #1
	mov	r2, r4
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1692:
	cmp	r1, #1
	bne	.L1693
	add	r1, ip, #36864
	ldr	r0, [r3, #2564]
	ldr	r4, [r3, #2560]
	ldr	r5, [r1, #3876]
	ldr	lr, [r1, #3872]
	cmp	r4, lr
	cmpeq	r0, r5
	movne	r1, #1
	moveq	r1, #0
	orr	r2, r2, r1
	b	.L1693
.L1702:
	ldr	r0, [r3, #2548]
	ldr	r1, [r3, #916]
	cmp	r0, r1
	orrne	r2, r2, #1
	b	.L1691
.L1704:
	.align	2
.L1703:
	.word	.LC51
	.fnend
	.size	MVC_IsNewPic, .-MVC_IsNewPic
	.align	2
	.global	mvc_ref_pic_list_reordering
	.type	mvc_ref_pic_list_reordering, %function
mvc_ref_pic_list_reordering:
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
	add	r5, r0, #11075584
	add	r8, r5, #40960
	add	r5, r5, #36864
	ldr	r2, [r0, #240]
	mov	r3, #0
	ldrb	r1, [r8, #883]
	mov	r6, #1
	strb	r3, [r5, #3916]
	mov	r4, r0
	cmp	r1, r3
	strb	r3, [r5, #3917]
	ldrb	r3, [r8, #873]
	movne	r7, #5
	moveq	r7, #3
	cmp	r3, #0
	ldr	r3, [r2, #2896]
	addne	r3, r3, #5
	addeq	r3, r3, #4
	mov	r6, r6, asl r3
	ldrb	r3, [r8, #872]
	cmp	r3, #1
	bls	.L1760
.L1759:
	ldrb	r3, [r4, #10]
.L1726:
	adds	r3, r3, #0
	movne	r3, #1
	rsb	r0, r3, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1760:
	ldr	r1, .L1767
	bl	mvc_u_1
	uxtb	r0, r0
	strb	r0, [r5, #3916]
	cmp	r0, #0
	beq	.L1716
	ldr	r3, [r8, #932]
	cmn	r3, #2
	beq	.L1742
	movw	r10, #40780
	mov	r9, #0
	movt	r10, 169
	add	r10, r4, r10
	b	.L1723
.L1717:
	cmp	r0, #2
	beq	.L1761
	sub	r0, r0, #4
	cmp	r0, #1
	bls	.L1762
.L1720:
	ldr	r3, [r8, #932]
	add	r9, r9, #1
	add	r3, r3, #2
	cmp	r3, r9
	bls	.L1763
.L1723:
	ldr	r1, .L1767+4
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r7, r0
	str	r0, [r10, #4]!
	ldrb	r3, [r4, #10]
	bcc	.L1713
	cmp	r3, #0
	bne	.L1713
	cmp	r0, #3
	beq	.L1716
	cmp	r0, #1
	bhi	.L1717
	ldr	r1, .L1767+8
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r6, r0
	str	r0, [r10, #264]
	ldrb	r3, [r4, #10]
	bls	.L1719
	cmp	r3, #0
	beq	.L1720
.L1719:
	mov	r2, r0
	ldr	r1, .L1767+12
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1716:
	ldrb	r3, [r8, #872]
	cmp	r3, #1
	bne	.L1759
	ldr	r1, .L1767+16
	mov	r0, r4
	bl	mvc_u_1
	uxtb	r0, r0
	strb	r0, [r5, #3917]
	cmp	r0, #0
	beq	.L1759
	ldr	r3, [r8, #936]
	cmn	r3, #2
	beq	.L1759
	movw	r9, #40912
	mov	r5, #0
	movt	r9, 169
	add	r9, r4, r9
	b	.L1739
.L1738:
	add	r5, r5, #1
	cmp	r5, r3
	bcs	.L1759
.L1739:
	ldr	r1, .L1767+20
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r7, r0
	str	r0, [r9, #4]!
	ldrb	r3, [r4, #10]
	bcc	.L1730
	cmp	r3, #0
	bne	.L1730
	cmp	r0, #3
	beq	.L1726
	cmp	r0, #1
	bls	.L1764
	cmp	r0, #2
	beq	.L1765
	sub	r0, r0, #4
	cmp	r0, #1
	bls	.L1766
	ldr	r3, [r8, #936]
	add	r3, r3, #2
	cmp	r3, r5
	bne	.L1738
.L1740:
	ldr	r1, .L1767+24
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1764:
	ldr	r1, .L1767+28
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r6, r0
	str	r0, [r9, #264]
	ldrb	r3, [r4, #10]
	bls	.L1734
	cmp	r3, #0
	bne	.L1734
.L1735:
	ldr	r2, [r8, #936]
	add	r3, r2, #2
	cmp	r3, r5
	bne	.L1738
	movw	r1, #26614
	movt	r1, 42
	add	r1, r2, r1
	add	r1, r4, r1, lsl #2
	ldr	r2, [r1, #4]
	cmp	r2, #3
	beq	.L1738
	b	.L1740
.L1761:
	ldr	r1, .L1767+32
	mov	r0, r4
	bl	mvc_ue_v
	str	r0, [r10, #528]
	b	.L1720
.L1765:
	ldr	r1, .L1767+36
	mov	r0, r4
	bl	mvc_ue_v
	str	r0, [r9, #524]
	b	.L1735
.L1762:
	ldr	r1, .L1767+40
	mov	r0, r4
	bl	mvc_ue_v
	str	r0, [r10, #784]
	b	.L1720
.L1766:
	ldr	r1, .L1767+44
	mov	r0, r4
	bl	mvc_ue_v
	str	r0, [r9, #784]
	b	.L1735
.L1713:
	mov	r2, r0
	ldr	r1, .L1767+48
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1730:
	mov	r2, r0
	ldr	r1, .L1767+52
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1763:
	cmp	r9, r3
	bne	.L1716
.L1711:
	movw	r2, #26578
	movt	r2, 42
	add	r2, r3, r2
	add	r2, r4, r2, lsl #2
	ldr	r3, [r2, #8]
	cmp	r3, #3
	beq	.L1716
	ldr	r1, .L1767+56
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1734:
	mov	r2, r0
	ldr	r1, .L1767+60
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1742:
	mov	r3, #0
	b	.L1711
.L1768:
	.align	2
.L1767:
	.word	.LC52
	.word	.LC53
	.word	.LC55
	.word	.LC56
	.word	.LC60
	.word	.LC61
	.word	.LC67
	.word	.LC63
	.word	.LC57
	.word	.LC65
	.word	.LC58
	.word	.LC66
	.word	.LC54
	.word	.LC62
	.word	.LC59
	.word	.LC64
	.fnend
	.size	mvc_ref_pic_list_reordering, .-mvc_ref_pic_list_reordering
	.align	2
	.global	mvc_pred_weight_table
	.type	mvc_pred_weight_table, %function
mvc_pred_weight_table:
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
	ldr	r3, [r0, #244]
	add	r6, r0, #11075584
	ldr	r1, .L1799
	mov	r5, r0
	ldr	r7, [r0, #240]
	add	r6, r6, #40960
	str	r3, [fp, #-48]
	bl	mvc_ue_v
	mov	r4, #1
	str	r0, [r6, #940]
	mov	r8, r4, asl r0
	ldr	r9, [r7, #748]
	cmp	r9, #0
	bne	.L1793
.L1770:
	cmp	r0, #7
	bhi	.L1773
	ldr	r3, [r6, #944]
	cmp	r3, #7
	bhi	.L1773
	ldrb	r2, [r5, #10]
	cmp	r2, #0
	movweq	r10, #42036
	moveq	r4, r2
	movteq	r10, 169
	addeq	r10, r5, r10
	beq	.L1781
	b	.L1772
.L1777:
	ldr	r2, [r7, #748]
	cmp	r2, #0
	bne	.L1794
.L1778:
	str	r2, [r10]
	str	r2, [r10, #768]
	str	r2, [r10, #128]
	str	r2, [r10, #896]
.L1780:
	ldr	r2, [r6, #932]
	add	r4, r4, #1
	add	r10, r10, #4
	cmp	r2, r4
	bcc	.L1795
.L1781:
	ldr	r1, .L1799+4
	mov	r0, r5
	bl	mvc_u_1
	cmp	r0, #0
	streq	r8, [r10, #-128]
	streq	r0, [r10, #640]
	beq	.L1777
	ldr	r1, .L1799+8
	mov	r0, r5
	bl	mvc_se_v
	ldr	r1, .L1799+12
	str	r0, [r10, #-128]
	mov	r0, r5
	bl	mvc_se_v
	str	r0, [r10, #640]
	ldr	r2, [r7, #748]
	cmp	r2, #0
	beq	.L1778
.L1794:
	ldr	r1, .L1799+16
	mov	r0, r5
	bl	mvc_u_1
	cmp	r0, #0
	bne	.L1796
	str	r9, [r10]
	str	r0, [r10, #768]
	str	r9, [r10, #128]
	str	r0, [r10, #896]
	b	.L1780
.L1795:
	ldr	r3, [fp, #-48]
	ldr	r3, [r3, #44]
	cmp	r3, #1
	beq	.L1782
.L1783:
	ldrb	r0, [r5, #10]
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r0, r0, #0
.L1775:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1796:
	ldr	r1, .L1799+20
	mov	r0, r5
	bl	mvc_se_v
	ldr	r1, .L1799+24
	str	r0, [r10]
	mov	r0, r5
	bl	mvc_se_v
	ldr	r1, .L1799+20
	str	r0, [r10, #768]
	mov	r0, r5
	bl	mvc_se_v
	ldr	r1, .L1799+24
	str	r0, [r10, #128]
	mov	r0, r5
	bl	mvc_se_v
	str	r0, [r10, #896]
	b	.L1780
.L1793:
	ldr	r1, .L1799+28
	mov	r0, r5
	bl	mvc_ue_v
	mov	r3, r0
	ldr	r0, [r6, #940]
	mov	r9, r4, asl r3
	str	r3, [r6, #944]
	b	.L1770
.L1782:
	ldrb	r3, [r6, #872]
	cmp	r3, #1
	bne	.L1783
	movw	r4, #42420
	mov	r10, #0
	movt	r4, 169
	add	r4, r5, r4
	b	.L1789
.L1785:
	ldr	r3, [r7, #748]
	cmp	r3, #0
	bne	.L1797
.L1786:
	str	r3, [r4]
	str	r3, [r4, #768]
	str	r3, [r4, #128]
	str	r3, [r4, #896]
.L1788:
	ldr	r3, [r6, #936]
	add	r10, r10, #1
	add	r4, r4, #4
	cmp	r3, r10
	bcc	.L1783
.L1789:
	ldr	r1, .L1799+32
	mov	r0, r5
	bl	mvc_u_1
	cmp	r0, #0
	streq	r8, [r4, #-128]
	streq	r0, [r4, #640]
	beq	.L1785
	ldr	r1, .L1799+36
	mov	r0, r5
	bl	mvc_se_v
	ldr	r1, .L1799+40
	str	r0, [r4, #-128]
	mov	r0, r5
	bl	mvc_se_v
	str	r0, [r4, #640]
	ldr	r3, [r7, #748]
	cmp	r3, #0
	beq	.L1786
.L1797:
	ldr	r1, .L1799+44
	mov	r0, r5
	bl	mvc_u_1
	cmp	r0, #0
	bne	.L1798
	str	r9, [r4]
	str	r0, [r4, #768]
	str	r9, [r4, #128]
	str	r0, [r4, #896]
	b	.L1788
.L1773:
	ldrb	r2, [r5, #10]
.L1772:
	ldr	r1, .L1799+48
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1775
.L1798:
	ldr	r1, .L1799+52
	mov	r0, r5
	bl	mvc_se_v
	ldr	r1, .L1799+56
	str	r0, [r4]
	mov	r0, r5
	bl	mvc_se_v
	ldr	r1, .L1799+52
	str	r0, [r4, #768]
	mov	r0, r5
	bl	mvc_se_v
	ldr	r1, .L1799+56
	str	r0, [r4, #128]
	mov	r0, r5
	bl	mvc_se_v
	str	r0, [r4, #896]
	b	.L1788
.L1800:
	.align	2
.L1799:
	.word	.LC68
	.word	.LC71
	.word	.LC72
	.word	.LC73
	.word	.LC74
	.word	.LC75
	.word	.LC76
	.word	.LC69
	.word	.LC77
	.word	.LC78
	.word	.LC79
	.word	.LC80
	.word	.LC70
	.word	.LC81
	.word	.LC82
	.fnend
	.size	mvc_pred_weight_table, .-mvc_pred_weight_table
	.align	2
	.global	MVC_DecMMCO
	.type	MVC_DecMMCO, %function
MVC_DecMMCO:
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
	mov	r4, r0
	moveq	r7, #100
	beq	.L1813
	mov	r9, #0
	b	.L1804
.L1835:
	ldr	r1, .L1841
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r5, #2
	beq	.L1833
.L1815:
	cmp	r5, #6
	orreq	r6, r6, #1
	cmp	r6, #0
	bne	.L1818
	cmp	r5, #4
	beq	.L1834
.L1819:
	cmp	r5, #6
	bhi	.L1811
.L1816:
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L1811
	cmp	r5, #0
	beq	.L1821
.L1820:
	subs	r7, r7, #1
	beq	.L1822
.L1813:
	ldr	r1, .L1841+4
	mov	r0, r4
	bl	mvc_ue_v
	bic	r3, r0, #2
	sub	r6, r0, #3
	clz	r6, r6
	cmp	r3, #1
	mov	r5, r0
	mov	r6, r6, lsr #5
	beq	.L1835
	cmp	r5, #2
	bne	.L1815
.L1833:
	ldr	r1, .L1841+8
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r6, #0
	beq	.L1816
.L1818:
	ldr	r1, .L1841+12
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r5, #4
	bne	.L1819
.L1834:
	ldr	r1, .L1841+16
	mov	r0, r4
	bl	mvc_ue_v
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	beq	.L1820
.L1811:
	ldr	r1, .L1841+20
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1840:
	ldr	r1, .L1841
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r3, [r8, #4]
	cmp	r3, #2
	str	r0, [r8, #8]
	beq	.L1836
.L1807:
	cmp	r3, #3
	cmpne	r3, #6
	beq	.L1837
.L1808:
	cmp	r3, #4
	beq	.L1838
.L1809:
	cmp	r3, #6
	bhi	.L1811
	ldrb	r2, [r4, #10]
	cmp	r2, #0
	bne	.L1811
	cmp	r3, #0
	add	r9, r9, #1
	beq	.L1821
	cmp	r9, #100
	beq	.L1839
.L1804:
	ldr	r1, .L1841+4
	mov	r0, r4
	ldrb	r5, [r4, #3]
	bl	mvc_ue_v
	mov	r6, r9, asl #2
	mov	r7, r9, asl #4
	add	r1, r6, r7
	movw	r2, #2004
	movw	r8, #43536
	mla	r2, r2, r5, r1
	movt	r8, 169
	add	r2, r4, r2
	add	r8, r2, r8
	mov	r3, r0
	bic	r0, r0, #2
	cmp	r0, #1
	str	r3, [r8, #4]
	beq	.L1840
	cmp	r3, #2
	bne	.L1807
.L1836:
	ldr	r1, .L1841+8
	mov	r0, r4
	bl	mvc_ue_v
	add	r3, r6, r7
	movw	r2, #2004
	movw	r1, #43544
	mla	r3, r2, r5, r3
	movw	r2, #43536
	movt	r1, 169
	movt	r2, 169
	add	r3, r4, r3
	add	r1, r3, r1
	add	r2, r3, r2
	str	r0, [r1, #4]
	ldr	r3, [r2, #4]
	cmp	r3, #3
	cmpne	r3, #6
	bne	.L1808
.L1837:
	ldr	r1, .L1841+12
	mov	r0, r4
	bl	mvc_ue_v
	add	r3, r6, r7
	movw	r2, #2004
	movw	r1, #43544
	mla	r3, r2, r5, r3
	movw	r2, #43536
	movt	r1, 169
	movt	r2, 169
	add	r3, r4, r3
	add	r1, r3, r1
	add	r2, r3, r2
	str	r0, [r1, #8]
	ldr	r3, [r2, #4]
	cmp	r3, #4
	bne	.L1809
.L1838:
	ldr	r1, .L1841+16
	mov	r0, r4
	bl	mvc_ue_v
	add	r6, r6, r7
	movw	r7, #2004
	movw	r2, #43552
	mla	r5, r7, r5, r6
	movw	r3, #43536
	movt	r2, 169
	movt	r3, 169
	add	r5, r4, r5
	add	r2, r5, r2
	add	r3, r5, r3
	str	r0, [r2, #4]
	ldr	r3, [r3, #4]
	b	.L1809
.L1821:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1839:
	ldr	r1, .L1841+24
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1822:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1842:
	.align	2
.L1841:
	.word	.LC85
	.word	.LC84
	.word	.LC86
	.word	.LC87
	.word	.LC88
	.word	.LC89
	.word	.LC83
	.fnend
	.size	MVC_DecMMCO, .-MVC_DecMMCO
	.align	2
	.global	mvc_dec_ref_pic_marking
	.type	mvc_dec_ref_pic_marking, %function
mvc_dec_ref_pic_marking:
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
	add	r3, r0, #11075584
	mov	r4, r0
	add	r3, r3, #40960
	ldrb	r7, [r0, #3]
	ldrb	r8, [r3, #877]
	cmp	r8, #0
	beq	.L1844
	clz	r2, r7
	mov	r2, r2, lsr #5
	strb	r2, [r0, #3]
	mov	r6, r2
.L1853:
	ldrb	r3, [r3, #875]
	cmp	r3, #5
	beq	.L1864
	ldr	r1, .L1868
	mov	r0, r4
	bl	mvc_u_1
	movw	r2, #2004
	mla	r6, r2, r6, r4
	movw	r5, #43536
	movt	r5, 169
	ldr	r1, .L1868+4
	add	r5, r6, r5
	mov	r3, r0
	uxtb	r2, r0
	strb	r3, [r5, #3]
	mov	r0, #16
	bl	dprint_vfmw
	ldrb	r3, [r5, #3]
	cmp	r3, #0
	bne	.L1847
.L1851:
	mov	r8, #0
.L1861:
	mov	r0, r8
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L1844:
	movw	r2, #2004
	movw	r1, #43536
	mla	r2, r2, r7, r0
	movt	r1, 169
	movw	r5, #43536
	mov	r6, r7
	movt	r5, 169
	add	r5, r2, r5
	ldrb	r2, [r2, r1]
	cmp	r2, #0
	beq	.L1853
	ldrb	r3, [r3, #875]
	cmp	r3, #5
	beq	.L1865
	ldr	r1, .L1868
	ldrb	r6, [r5, #3]
	bl	mvc_u_1
	cmp	r6, r0
	bne	.L1866
	ldrb	r3, [r5, #3]
	cmp	r3, #0
	beq	.L1851
	mov	r1, r8
	mov	r0, r4
	bl	MVC_DecMMCO
	mov	r8, r0
	b	.L1861
.L1847:
	mov	r1, #1
	mov	r0, r4
	bl	MVC_DecMMCO
	cmn	r0, #1
	mov	r8, r0
	movne	r3, #1
	movne	r8, #0
	strneb	r3, [r5]
	bne	.L1861
	mov	r3, #0
	ldr	r1, .L1868+8
	strb	r3, [r5]
	mov	r0, #1
	strb	r7, [r4, #3]
	bl	dprint_vfmw
	b	.L1861
.L1865:
	ldr	r1, .L1868+12
	ldrb	r6, [r5, #1]
	bl	mvc_u_1
	cmp	r6, r0
	bne	.L1867
	mov	r0, r4
	ldr	r1, .L1868+16
	ldrb	r4, [r5, #2]
	bl	mvc_u_1
	cmp	r4, r0
	beq	.L1851
	ldr	r1, .L1868+20
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1861
.L1864:
	ldr	r1, .L1868+12
	mov	r0, r4
	bl	mvc_u_1
	movw	r2, #2004
	mla	r2, r2, r6, r4
	movw	r5, #43536
	movt	r5, 169
	ldr	r1, .L1868+16
	mov	r8, #0
	add	r5, r2, r5
	strb	r0, [r5, #1]
	mov	r0, r4
	bl	mvc_u_1
	ldrb	r2, [r5, #1]
	ldr	r1, .L1868+24
	strb	r0, [r5, #2]
	mov	r0, #16
	bl	dprint_vfmw
	mov	r0, r8
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L1866:
	ldr	r1, .L1868+28
	mov	r0, #1
	bl	dprint_vfmw
	ldr	ip, [r4, #68]
	ldr	r3, [r4, #100]
	mov	r0, #1
	ldr	r2, [r4, #88]
	mvn	r8, #0
	ldr	r1, .L1868+32
	str	ip, [sp]
	bl	dprint_vfmw
	b	.L1861
.L1867:
	ldr	r1, .L1868+36
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1861
.L1869:
	.align	2
.L1868:
	.word	.LC93
	.word	.LC94
	.word	.LC95
	.word	.LC90
	.word	.LC91
	.word	.LC97
	.word	.LC92
	.word	.LC98
	.word	.LC99
	.word	.LC96
	.fnend
	.size	mvc_dec_ref_pic_marking, .-mvc_dec_ref_pic_marking
	.align	2
	.global	MVC_ProcessSliceHeaderFirstPart
	.type	MVC_ProcessSliceHeaderFirstPart, %function
MVC_ProcessSliceHeaderFirstPart:
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
	ldr	r1, .L1935
	mov	r4, r0
	bl	mvc_ue_v
	ldr	r3, [r4, #40]
	sub	r3, r3, #1
	cmp	r0, r3
	mov	r6, r0
	bhi	.L1871
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L1871
	mov	r1, r0
	mov	r0, r4
	bl	MVC_PPSSPSCheckTmpId
	cmp	r0, #0
	bne	.L1926
	add	r7, r4, #11075584
	mov	r0, r4
	add	r5, r7, #40960
	str	r6, [r5, #888]
	bl	MVC_PPSSPSCheck
	subs	r8, r0, #0
	bne	.L1927
	ldr	r6, [r4, #240]
	mov	r0, r4
	ldr	r2, .L1935+4
	ldr	r9, [r4, #244]
	ldr	r1, [r6, #2896]
	add	r1, r1, #4
	bl	mvc_u_v
	str	r0, [r5, #900]
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L1924
	adds	r0, r0, #0
	ldrb	r3, [r5, #875]
	movne	r0, #1
	cmp	r3, #5
	movne	r0, #0
	cmp	r0, #0
	bne	.L1928
.L1877:
	mov	r3, #0
	strb	r3, [r5, #873]
	strb	r3, [r5, #874]
	ldrb	r3, [r6, #20]
	cmp	r3, #0
	beq	.L1929
	ldr	r2, [r6, #3948]
	ldr	r1, [r6, #3952]
	add	r3, r2, #1
	mla	r3, r1, r3, r3
.L1900:
	ldrb	r2, [r6, #21]
	cmp	r2, #0
	bne	.L1883
	strb	r2, [r5, #876]
.L1885:
	ldr	r2, [r5, #928]
	cmp	r2, r3
	bcs	.L1930
.L1886:
	ldrb	r3, [r5, #875]
	cmp	r3, #5
	beq	.L1931
.L1888:
	add	r10, r7, #36864
	mov	r3, #0
	str	r3, [r10, #3836]
	str	r3, [r10, #3840]
	ldr	r3, [r6, #2900]
	cmp	r3, #0
	beq	.L1932
.L1892:
	mov	r3, #0
	str	r3, [r10, #3872]
	str	r3, [r10, #3876]
	ldr	r3, [r6, #2900]
	cmp	r3, #1
	beq	.L1933
.L1895:
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L1924
	ldrb	r3, [r9, #17]
	cmp	r3, #0
	beq	.L1898
	ldr	r1, .L1935+8
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r0, #0
	bne	.L1899
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	beq	.L1898
.L1899:
	ldr	r1, .L1935+12
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L1935+16
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L1924
	mov	r3, #0
	ldr	r0, [r4, #120]
	mov	r2, r3
	mov	r1, #102
	blx	ip
.L1924:
	mvn	r8, #0
.L1910:
	mov	r0, r8
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1929:
	ldr	r1, .L1935+20
	mov	r0, r4
	bl	mvc_u_1
	uxtb	r0, r0
	strb	r0, [r5, #873]
	cmp	r0, #0
	bne	.L1934
	ldr	r2, [r6, #3948]
	ldrb	ip, [r6, #20]
	ldr	r1, [r6, #3952]
	add	r3, r2, #1
	cmp	ip, #0
	mla	r3, r1, r3, r3
	bne	.L1902
	mov	r3, r3, asl #1
	b	.L1900
.L1883:
	mov	r2, #1
	strb	r2, [r5, #876]
.L1903:
	ldr	r2, [r5, #928]
	cmp	r2, r3, lsr #1
	bcc	.L1886
	ldr	r1, .L1935+24
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1910
.L1934:
	ldr	r1, .L1935+28
	mov	r0, r4
	bl	mvc_u_1
	strb	r0, [r5, #874]
	ldr	r2, [r6, #3948]
	ldrb	r0, [r6, #20]
	ldr	r1, [r6, #3952]
	add	r3, r2, #1
	cmp	r0, #0
	ldrb	r0, [r5, #873]
	mla	r3, r1, r3, r3
	moveq	r2, #2
	beq	.L1881
.L1902:
	mov	r2, #1
.L1881:
	cmp	r0, #0
	mul	r3, r2, r3
	beq	.L1900
	cmp	r0, #1
	mov	r2, #0
	strb	r2, [r5, #876]
	bne	.L1885
	b	.L1903
.L1898:
	mov	r0, r4
	add	r7, r7, #40960
	bl	MVC_IsNewPic
	uxtb	r0, r0
	strb	r0, [r7, #877]
	cmp	r0, #0
	bne	.L1910
	ldr	r2, [r7, #928]
	ldr	r3, [r7, #2568]
	cmp	r2, r3
	bhi	.L1910
	ldr	r1, .L1935+32
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1910
.L1932:
	ldr	r1, [r6, #2904]
	mov	r0, r4
	ldr	r2, .L1935+36
	add	r1, r1, #4
	bl	mvc_u_v
	str	r0, [r10, #3836]
	ldrb	r3, [r9, #1]
	cmp	r3, #0
	beq	.L1892
	ldrb	r3, [r5, #873]
	cmp	r3, #0
	bne	.L1892
	ldr	r1, .L1935+40
	mov	r0, r4
	bl	mvc_se_v
	str	r0, [r10, #3840]
	b	.L1892
.L1933:
	ldrb	r3, [r6, #18]
	cmp	r3, #0
	bne	.L1895
	ldr	r1, .L1935+44
	mov	r0, r4
	bl	mvc_se_v
	str	r0, [r10, #3872]
	ldrb	r3, [r9, #1]
	cmp	r3, #1
	bne	.L1895
	ldrb	r3, [r5, #873]
	cmp	r3, #0
	bne	.L1895
	ldr	r1, .L1935+48
	mov	r0, r4
	bl	mvc_se_v
	str	r0, [r10, #3876]
	b	.L1895
.L1871:
	mov	r2, r6
	ldr	r1, .L1935+52
	mvn	r8, #0
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r8
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1931:
	ldr	r1, .L1935+56
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r0, #65536
	str	r0, [r5, #916]
	bcs	.L1889
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	beq	.L1888
.L1889:
	ldr	r1, .L1935+60
	mov	r0, #1
	bl	dprint_vfmw
	b	.L1888
.L1926:
	ldr	r1, .L1935+64
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1910
.L1927:
	ldr	r1, .L1935+68
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1910
.L1928:
	ldr	r3, [r5, #2512]
	cmp	r3, #0
	bgt	.L1877
	ldr	r1, .L1935+72
	mov	r0, #1
	bl	dprint_vfmw
	b	.L1877
.L1930:
	ldr	r1, .L1935+76
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1910
.L1936:
	.align	2
.L1935:
	.word	.LC100
	.word	.LC104
	.word	.LC116
	.word	.LC117
	.word	g_event_report
	.word	.LC106
	.word	.LC108
	.word	.LC107
	.word	.LC118
	.word	.LC112
	.word	.LC113
	.word	.LC114
	.word	.LC115
	.word	.LC101
	.word	.LC110
	.word	.LC111
	.word	.LC102
	.word	.LC103
	.word	.LC105
	.word	.LC109
	.fnend
	.size	MVC_ProcessSliceHeaderFirstPart, .-MVC_ProcessSliceHeaderFirstPart
	.align	2
	.global	MVC_ProcessSliceHeaderSecondPart
	.type	MVC_ProcessSliceHeaderSecondPart, %function
MVC_ProcessSliceHeaderSecondPart:
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
	add	r4, r0, #11075584
	add	r4, r4, #40960
	ldr	r3, [r0, #40]
	mov	r5, r0
	ldr	r6, [r0, #244]
	ldr	r2, [r4, #888]
	sub	r3, r3, #1
	cmp	r3, r2
	bcc	.L1938
	ldrb	r7, [r0, #10]
	cmp	r7, #0
	bne	.L1938
	bl	MVC_PPSSPSCheck
	cmp	r0, #0
	bne	.L2020
	ldrb	r3, [r4, #872]
	cmp	r3, #1
	beq	.L2021
.L1942:
	ldr	r2, [r6, #36]
	cmp	r3, #1
	str	r2, [r4, #932]
	ldr	r2, [r6, #40]
	str	r2, [r4, #936]
	bls	.L2022
	cmp	r3, #2
	beq	.L1969
.L1953:
	mov	r3, #32
	str	r3, [r4, #936]
.L1954:
	mov	r0, r5
	bl	mvc_ref_pic_list_reordering
	subs	r8, r0, #0
	bne	.L2023
	ldrb	r3, [r6, #2]
	cmp	r3, #0
	beq	.L1956
	ldrb	r3, [r4, #872]
	cmp	r3, #0
	moveq	r7, #1
	moveq	r2, r7
	beq	.L1957
.L1956:
	ldr	r3, [r6, #44]
	cmp	r3, #1
	beq	.L2024
.L1973:
	mov	r2, #0
.L1957:
	strb	r7, [r4, #879]
	mov	r0, #19
	ldr	r1, .L2030
	bl	dprint_vfmw
	ldrb	r2, [r4, #879]
	mov	r3, #0
	str	r3, [r4, #940]
	cmp	r2, r3
	str	r3, [r4, #944]
	bne	.L2025
.L1958:
	ldrb	r3, [r4, #880]
	cmp	r3, #0
	bne	.L2026
.L1959:
	mov	r3, #0
	str	r3, [r4, #2484]
	ldrb	r3, [r6]
	cmp	r3, #0
	beq	.L1960
	ldrb	r3, [r4, #872]
	cmp	r3, #1
	bls	.L2027
.L1960:
	ldr	r1, .L2030+4
	mov	r0, r5
	bl	mvc_se_v
	mov	r3, #0
	str	r3, [r4, #2492]
	str	r3, [r4, #2496]
	str	r3, [r4, #2500]
	str	r0, [r4, #2488]
	ldrb	r3, [r6, #3]
	cmp	r3, #0
	bne	.L2028
.L1989:
	mov	r0, r8
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1969:
	mov	r3, #32
	str	r3, [r4, #932]
	b	.L1953
.L2028:
	ldr	r1, .L2030+8
	mov	r0, r5
	bl	mvc_ue_v
	cmp	r0, #2
	str	r0, [r4, #2492]
	bhi	.L1963
	ldrb	r3, [r5, #10]
	cmp	r3, #0
	bne	.L1963
	cmp	r0, #1
	beq	.L1989
	ldr	r1, .L2030+12
	mov	r0, r5
	bl	mvc_se_v
	add	r3, r0, #6
	str	r0, [r4, #2496]
	cmp	r3, #12
	bhi	.L1966
	ldrb	r3, [r5, #10]
	cmp	r3, #0
	bne	.L1966
	ldr	r1, .L2030+16
	mov	r0, r5
	bl	mvc_se_v
	add	r3, r0, #6
	str	r0, [r4, #2500]
	cmp	r3, #12
	bhi	.L1968
	ldrb	r3, [r5, #10]
	cmp	r3, #0
	beq	.L1989
.L1968:
	ldr	r1, .L2030+20
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1989
.L2025:
	mov	r0, r5
	bl	mvc_pred_weight_table
	cmp	r0, #0
	beq	.L1958
	ldr	r1, .L2030+24
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1989
.L2026:
	mov	r0, r5
	bl	mvc_dec_ref_pic_marking
	cmp	r0, #0
	beq	.L1959
	ldr	r1, .L2030+28
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1989
.L2024:
	ldrb	r3, [r4, #872]
	cmp	r3, #1
	moveq	r7, r3
	moveq	r2, r7
	bne	.L1973
	b	.L1957
.L2021:
	ldr	r1, .L2030+32
	mov	r0, r5
	bl	mvc_u_1
	ldrb	r3, [r4, #872]
	strb	r0, [r4, #878]
	b	.L1942
.L2022:
	ldr	r1, .L2030+36
	mov	r0, r5
	bl	mvc_u_1
	cmp	r0, #0
	bne	.L1944
	ldr	r3, [r4, #932]
.L1945:
	ldrb	r2, [r4, #873]
	cmp	r2, #0
	bne	.L1946
	cmp	r3, #15
	bhi	.L1947
	ldr	r3, [r4, #936]
	cmp	r3, #15
	bhi	.L2029
.L1948:
	ldrb	r3, [r5, #10]
	cmp	r3, #0
	bne	.L1947
.L1949:
	ldrb	r3, [r4, #872]
	cmp	r3, #2
	beq	.L1969
	cmp	r3, #1
	bne	.L1953
	b	.L1954
.L1938:
	ldr	r1, .L2030+40
	mvn	r8, #0
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r8
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2027:
	ldr	r1, .L2030+44
	mov	r0, r5
	bl	mvc_ue_v
	cmp	r0, #2
	str	r0, [r4, #2484]
	bhi	.L1961
	ldrb	r3, [r5, #10]
	cmp	r3, #0
	beq	.L1960
.L1961:
	ldr	r1, .L2030+48
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1989
.L1946:
	cmp	r3, #31
	bhi	.L1950
	ldr	r3, [r4, #936]
	cmp	r3, #31
	bls	.L1951
	ldrb	r3, [r4, #872]
	cmp	r3, #1
	bne	.L1951
.L1950:
	ldr	r1, .L2030+52
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1989
.L1951:
	ldrb	r3, [r5, #10]
	cmp	r3, #0
	beq	.L1949
	b	.L1950
.L2029:
	ldrb	r3, [r4, #872]
	cmp	r3, #1
	bne	.L1948
.L1947:
	ldr	r1, .L2030+56
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1989
.L1944:
	ldr	r1, .L2030+60
	mov	r0, r5
	bl	mvc_ue_v
	ldrb	r2, [r4, #872]
	cmp	r2, #1
	mov	r3, r0
	str	r0, [r4, #932]
	bne	.L1945
	ldr	r1, .L2030+64
	mov	r0, r5
	bl	mvc_ue_v
	ldr	r3, [r4, #932]
	str	r0, [r4, #936]
	b	.L1945
.L1966:
	ldr	r1, .L2030+68
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1989
.L1963:
	ldr	r1, .L2030+72
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1989
.L2020:
	ldr	r1, .L2030+76
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1989
.L2023:
	ldr	r1, .L2030+80
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1989
.L2031:
	.align	2
.L2030:
	.word	.LC126
	.word	.LC131
	.word	.LC132
	.word	.LC134
	.word	.LC136
	.word	.LC137
	.word	.LC127
	.word	.LC128
	.word	.LC119
	.word	.LC120
	.word	.LC101
	.word	.LC129
	.word	.LC130
	.word	.LC124
	.word	.LC123
	.word	.LC121
	.word	.LC122
	.word	.LC135
	.word	.LC133
	.word	.LC102
	.word	.LC125
	.fnend
	.size	MVC_ProcessSliceHeaderSecondPart, .-MVC_ProcessSliceHeaderSecondPart
	.align	2
	.global	MVC_ExitSlice
	.type	MVC_ExitSlice, %function
MVC_ExitSlice:
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
	add	r2, r0, #11075584
	add	r3, r2, #40960
	ldr	ip, [r0, #236]
	ldrb	r1, [r3, #873]
	ldr	lr, [r3, #888]
	cmp	r1, #0
	ldr	r5, [r3, #928]
	str	lr, [r3, #2540]
	ldr	r4, [ip, #744]
	strb	r1, [r3, #2528]
	ldrneb	r1, [r3, #874]
	ldr	lr, [r3, #900]
	str	r5, [r3, #2568]
	strneb	r1, [r3, #2529]
	ldrb	r1, [r3, #875]
	str	lr, [r3, #2544]
	cmp	r1, #5
	ldrb	lr, [r3, #880]
	strb	r1, [r3, #2530]
	ldreq	r1, [r3, #916]
	str	r4, [r3, #2536]
	strb	lr, [r3, #2531]
	streq	r1, [r3, #2548]
	ldr	r1, [ip, #2900]
	cmp	r1, #0
	bne	.L2035
	add	r1, r2, #36864
	ldr	lr, [r1, #3836]
	str	lr, [r3, #2552]
	ldr	r1, [r1, #3840]
	str	r1, [r3, #2556]
	ldr	r1, [ip, #2900]
.L2035:
	cmp	r1, #1
	addeq	r2, r2, #36864
	ldreq	r1, [r2, #3872]
	streq	r1, [r3, #2560]
	ldreq	r2, [r2, #3876]
	streq	r2, [r3, #2564]
	ldrb	r2, [r3, #883]
	cmp	r2, #1
	bne	.L2037
	ldr	ip, [r3, #2512]
	ldrb	r1, [r3, #881]
	ldrb	r2, [r3, #882]
	str	ip, [r3, #2572]
	strb	r1, [r3, #2532]
	strb	r2, [r3, #2533]
.L2037:
	ldr	r3, [r0, #80]
	add	r3, r3, #1
	str	r3, [r0, #80]
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	MVC_ExitSlice, .-MVC_ExitSlice
	.align	2
	.global	MVC_PicTypeStatistic
	.type	MVC_PicTypeStatistic, %function
MVC_PicTypeStatistic:
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
	add	r3, r0, #11075584
	add	r3, r3, #40960
	ldrb	r2, [r3, #872]
	cmp	r2, #1
	beq	.L2043
	bcc	.L2044
	cmp	r2, #2
	ldmnefd	sp, {fp, sp, pc}
	ldrb	r3, [r3, #875]
	add	r0, r0, #11141120
	cmp	r3, #5
	beq	.L2053
.L2046:
	add	r0, r0, #12288
	mov	r3, #0
	strb	r3, [r0, #1381]
	ldmfd	sp, {fp, sp, pc}
.L2044:
	add	r0, r0, #11141120
	add	r3, r0, #12288
	ldrb	r2, [r3, #1380]
	cmp	r2, #2
	movne	r2, #1
	strneb	r2, [r3, #1380]
	b	.L2046
.L2043:
	add	r0, r0, #11141120
	mov	r2, #2
	add	r0, r0, #12288
	mov	r3, #0
	strb	r2, [r0, #1380]
	strb	r3, [r0, #1381]
	ldmfd	sp, {fp, sp, pc}
.L2053:
	add	r0, r0, #12288
	mov	r3, #1
	strb	r3, [r0, #1381]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_PicTypeStatistic, .-MVC_PicTypeStatistic
	.align	2
	.global	MVC_CalcStreamBits
	.type	MVC_CalcStreamBits, %function
MVC_CalcStreamBits:
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
	add	r3, r0, #11075584
	mov	r4, r0
	add	r3, r3, #36864
	ldrb	r3, [r3, #1592]
	cmp	r3, #0
	beq	.L2055
	ldr	r2, [r0, #232]
	ldr	r3, [r2, #64]
	add	r3, r3, #7
	bic	r3, r3, #7
	str	r3, [r2, #64]
	ldr	r2, [r0, #232]
	ldr	r3, [r2, #72]
	sub	r3, r3, #1
	str	r3, [r2, #72]
.L2055:
	ldr	r3, [r4, #232]
	ldrb	r6, [r3]
	cmp	r6, #0
	beq	.L2066
	mov	r1, #0
	mov	r0, r3
	mov	r5, r1
.L2057:
	add	r1, r1, #1
	ldr	ip, [r0, #12]
	cmp	r1, r6
	add	r0, r0, #28
	add	r5, r5, ip
	bne	.L2057
.L2056:
	mov	r7, r6, asl #5
	ldr	r0, [r3, #72]
	sub	r7, r7, r6, asl #2
	ldr	r2, [r3, #64]
	add	r1, r3, r7
	mov	r3, r5
	str	r0, [sp, #4]
	mov	r0, #7
	ldr	ip, [r1, #12]
	ldr	r1, .L2077
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [r4, #232]
	mov	r2, r6
	mov	r0, #7
	ldr	r1, .L2077+4
	ldrb	r6, [r3]
	ldr	ip, [r3, #64]
	mov	lr, r6, asl #5
	and	ip, ip, r0
	sub	lr, lr, r6, asl #2
	add	r3, r3, lr
	str	ip, [r3, #24]
	ldr	r3, [r4, #232]
	ldrb	r6, [r3]
	ldr	r8, [r3, #64]
	mov	lr, r6, asl #5
	sub	lr, lr, r6, asl #2
	add	r3, r3, lr
	ldr	ip, [r3, #16]
	add	ip, ip, r8, lsr #3
	rsb	ip, r5, ip
	str	ip, [r3, #28]
	ldr	ip, [r4, #232]
	ldrb	r6, [ip]
	ldr	lr, [ip, #64]
	mov	r3, r6, asl #5
	sub	r3, r3, r6, asl #2
	add	ip, ip, r3
	ldr	r3, [ip, #12]
	add	r3, r5, r3
	rsb	r3, lr, r3, lsl #3
	str	r3, [ip, #20]
	ldr	ip, [r4, #232]
	ldrb	lr, [ip]
	mov	r3, lr, asl #5
	sub	r3, r3, lr, asl #2
	add	r3, ip, r3
	ldr	ip, [r3, #28]
	ldr	lr, [r3, #24]
	and	ip, ip, #3
	add	ip, lr, ip, lsl #3
	str	ip, [r3, #24]
	ldr	ip, [r4, #232]
	ldrb	lr, [ip]
	mov	r3, lr, asl #5
	sub	r3, r3, lr, asl #2
	add	r3, ip, r3
	ldr	ip, [r3, #28]
	bic	ip, ip, #3
	str	ip, [r3, #28]
	ldr	ip, [r4, #232]
	add	r7, ip, r7
	ldrb	r5, [ip]
	ldr	r3, [r7, #24]
	mov	lr, r5, asl #5
	sub	lr, lr, r5, asl #2
	add	ip, ip, lr
	ldr	ip, [ip, #28]
	str	ip, [sp, #4]
	ldr	ip, [r7, #20]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	ip, [r4, #232]
	ldr	r2, [ip, #68]
	sub	r3, r2, #1
	cmp	r3, #1
	bhi	.L2076
	ldrb	r6, [ip]
	add	r1, r6, #1
	cmp	r2, r1
	movhi	r2, #1
	movls	r2, #0
	cmp	r1, #1
	movhi	r2, #0
	cmp	r2, #0
	beq	.L2060
	add	r6, r6, #2
	mov	r5, #0
.L2061:
	sub	r3, r6, #1
	ldr	r1, .L2077+8
	mov	r0, #7
	mov	lr, r3, asl #5
	mov	r2, r3
	sub	r3, lr, r3, asl #2
	add	ip, ip, r3
	str	r5, [ip, #24]
	ldr	ip, [r4, #232]
	add	ip, ip, r3
	ldr	lr, [ip, #16]
	str	lr, [ip, #28]
	ldr	ip, [r4, #232]
	add	ip, ip, r3
	ldr	lr, [ip, #12]
	mov	lr, lr, asl #3
	str	lr, [ip, #20]
	ldr	ip, [r4, #232]
	add	ip, ip, r3
	ldr	lr, [ip, #28]
	ldr	r7, [ip, #24]
	and	lr, lr, #3
	add	lr, r7, lr, lsl #3
	str	lr, [ip, #24]
	ldr	ip, [r4, #232]
	add	ip, ip, r3
	ldr	lr, [ip, #28]
	bic	lr, lr, #3
	str	lr, [ip, #28]
	ldr	ip, [r4, #232]
	add	ip, ip, r3
	ldr	r3, [ip, #24]
	ldr	ip, [ip, #20]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	ip, [r4, #232]
	ldr	r3, [ip, #68]
	cmp	r6, #1
	cmpls	r6, r3
	add	r6, r6, #1
	movcc	r2, #1
	movcs	r2, #0
	cmp	r2, #0
	bne	.L2061
	sub	r3, r3, #1
.L2060:
	mov	r2, r3, asl #5
	ldr	r1, [ip, #72]
	sub	r3, r2, r3, asl #2
	add	ip, ip, r3
	ldr	r3, [ip, #20]
	rsb	r3, r1, r3
	str	r3, [ip, #20]
	ldr	ip, [r4, #232]
	ldrb	r1, [ip]
	ldr	r3, [ip, #68]
	cmp	r1, r3
	bcs	.L2054
	sxth	r3, r1
	add	r4, r4, #11141120
	add	r4, r4, #12288
	mov	r2, r3, asl #5
	sub	r3, r2, r3, asl #2
	add	r3, ip, r3
.L2064:
	ldr	r2, [r3, #28]
	add	r1, r1, #1
	ldr	r0, [r4, #2048]
	add	r3, r3, #28
	cmp	r2, r0
	strcc	r2, [r4, #2048]
	ldr	r2, [ip, #68]
	cmp	r2, r1
	bhi	.L2064
.L2054:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L2076:
	ldr	r1, .L2077+12
	mov	r0, #0
	bl	dprint_vfmw
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L2066:
	mov	r5, r6
	b	.L2056
.L2078:
	.align	2
.L2077:
	.word	.LC138
	.word	.LC139
	.word	.LC141
	.word	.LC140
	.fnend
	.size	MVC_CalcStreamBits, .-MVC_CalcStreamBits
	.align	2
	.global	MVC_Scaling_List
	.type	MVC_Scaling_List, %function
MVC_Scaling_List:
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
	subs	r7, r3, #0
	str	r0, [fp, #-52]
	mov	r9, r1
	ble	.L2079
	mov	r3, r7
	mov	r1, #8
	mov	r6, r9
	ldr	r8, .L2090
	mov	r5, r1
	mov	r4, #0
	mov	r10, #255
	mov	r7, r2
	mov	r9, r3
	b	.L2084
.L2083:
	mov	lr, ip, lsr #2
	and	r3, ip, #3
	str	r5, [r6, ip, asl #2]
	uxtb	r0, r5
	mov	ip, r3, asl #3
	ldr	r3, [r7, lr, asl #2]
	cmp	r4, r9
	bic	r3, r3, r10, asl ip
	orr	r0, r3, r0, asl ip
	str	r0, [r7, lr, asl #2]
	beq	.L2079
.L2084:
	cmp	r9, #16
	ldreq	r3, .L2090+4
	ldrneb	ip, [r4, r8]
	ldreqb	ip, [r4, r3]
	cmp	r1, #0
	add	r4, r4, #1
	beq	.L2083
	ldr	r1, .L2090+8
	ldr	r0, [fp, #-52]
	str	ip, [fp, #-48]
	bl	mvc_se_v
	ldr	r2, [fp, #4]
	ldr	ip, [fp, #-48]
	add	r0, r5, r0
	add	r0, r0, #256
	mov	r1, r0, asr #31
	mov	lr, r1, lsr #24
	add	r0, r0, lr
	uxtb	r0, r0
	rsb	r3, lr, r0
	rsb	r1, lr, r0
	clz	r3, r3
	mov	r3, r3, lsr #5
	cmp	r3, #0
	moveq	r5, r1
	cmp	ip, #0
	movne	r3, #0
	andeq	r3, r3, #1
	str	r3, [r2]
	b	.L2083
.L2079:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2091:
	.align	2
.L2090:
	.word	.LANCHOR0+16
	.word	.LANCHOR0
	.word	.LC142
	.fnend
	.size	MVC_Scaling_List, .-MVC_Scaling_List
	.align	2
	.global	MVC_ProcessPPS
	.type	MVC_ProcessPPS, %function
MVC_ProcessPPS:
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
	mov	r5, r1
	ldr	r1, .L2150
	mov	r4, r0
	bl	mvc_u_1
	strb	r0, [r5]
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2141
	ldr	r1, .L2150+4
	mov	r0, r4
	bl	mvc_u_1
	strb	r0, [r5, #1]
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2141
	ldr	r1, .L2150+8
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r0, #0
	str	r0, [r5, #32]
	bne	.L2096
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	beq	.L2097
.L2096:
	ldr	r1, .L2150+12
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L2150+16
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L2141
	mov	r3, #0
	ldr	r0, [r4, #120]
	mov	r2, r3
	mov	r1, #102
	blx	ip
	mvn	r0, #0
.L2094:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2104:
	ldr	r1, .L2150+20
	mov	r0, r4
	bl	mvc_u_1
	ldr	r1, .L2150+24
	str	r0, [r5, #60]
	mov	r0, r4
	bl	mvc_u_1
	uxtb	r0, r0
	strb	r0, [r5, #18]
	cmp	r0, #1
	beq	.L2105
.L2123:
	ldr	r1, .L2150+28
	mov	r0, r4
	bl	mvc_se_v
	add	r3, r0, #12
	str	r0, [r5, #56]
	cmp	r3, #24
	bhi	.L2106
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	beq	.L2124
.L2106:
	ldr	r1, .L2150+32
	mov	r0, #1
	bl	dprint_vfmw
.L2141:
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2097:
	ldr	r1, .L2150+36
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r0, #31
	str	r0, [r5, #36]
	bhi	.L2098
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2098
	ldr	r1, .L2150+40
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r0, #31
	str	r0, [r5, #40]
	bhi	.L2100
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2100
	ldr	r1, .L2150+44
	mov	r0, r4
	bl	mvc_u_1
	strb	r0, [r5, #2]
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2141
	ldr	r2, .L2150+48
	mov	r1, #2
	mov	r0, r4
	bl	mvc_u_v
	cmp	r0, #2
	str	r0, [r5, #44]
	bhi	.L2142
	ldr	r1, .L2150+52
	mov	r0, r4
	bl	mvc_se_v
	ldr	r1, .L2150+56
	str	r0, [r5, #48]
	mov	r0, r4
	bl	mvc_se_v
	ldr	r1, .L2150+60
	mov	r0, r4
	bl	mvc_se_v
	ldr	r1, .L2150+64
	str	r0, [r5, #52]
	mov	r0, r4
	bl	mvc_u_1
	ldr	r1, .L2150+68
	strb	r0, [r5, #3]
	mov	r0, r4
	bl	mvc_u_1
	ldr	r1, .L2150+72
	strb	r0, [r5, #4]
	mov	r0, r4
	bl	mvc_u_1
	uxtb	r0, r0
	strb	r0, [r5, #17]
	cmp	r0, #0
	bne	.L2143
.L2103:
	ldr	r3, [r5, #52]
	mov	r6, #0
	add	r0, r4, #548
	str	r6, [r5, #60]
	strb	r6, [r5, #18]
	str	r3, [r5, #56]
	bl	BsResidBits
	ldr	r3, [r4, #232]
	ldr	r3, [r3, #72]
	add	r3, r3, #3
	cmp	r0, r3
	bcs	.L2104
.L2124:
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2143:
	ldr	r1, .L2150+76
	mov	r0, #1
	bl	dprint_vfmw
	b	.L2103
.L2098:
	ldr	r1, .L2150+80
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2094
.L2100:
	ldr	r1, .L2150+84
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2094
.L2105:
	sub	r8, fp, #72
	add	r10, r5, #4
	add	r7, r5, #2016
	add	r9, r5, #64
	b	.L2114
.L2147:
	ldr	lr, [r5, #28]
	ldr	r3, [r4, #248]
	mla	r3, ip, lr, r3
	ldrb	ip, [r3, #27]
	cmp	ip, #1
	beq	.L2144
	ldr	r3, .L2150+88
	cmp	r1, #0
	add	ip, r3, #16
	moveq	r3, ip
	mov	r1, r3
	ldr	r3, .L2150+92
	ldr	r3, [r3, #52]
	blx	r3
.L2109:
	add	r6, r6, #1
	add	r7, r7, #16
	cmp	r6, #6
	add	r9, r9, #64
	beq	.L2145
.L2114:
	ldr	r1, .L2150+96
	mov	r0, r4
	bl	mvc_u_1
	movw	ip, #3992
	clz	r1, r6
	mov	r2, #16
	cmp	r0, #1
	mov	r3, r0
	mov	r0, r7
	str	r3, [r8, #4]!
	strb	r3, [r10, #1]!
	beq	.L2146
	cmp	r6, #0
	cmpne	r6, #3
	mov	r1, r1, lsr #5
	beq	.L2147
	ldr	r3, .L2150+92
	mov	r2, #16
	sub	r1, r7, #16
	mov	r0, r7
	ldr	r3, [r3, #52]
	blx	r3
	b	.L2109
.L2145:
	add	r8, r5, #2112
	add	r10, r5, #448
	sub	r7, fp, #76
	add	r9, r5, #11
	mov	r6, #0
.L2122:
	ldr	r2, [r5, #60]
	mov	r3, #0
	cmp	r2, #1
	strne	r3, [r7]
	strneb	r3, [r9]
	beq	.L2148
.L2117:
	ldr	r1, [r4, #248]
	movw	ip, #3992
	ldr	r3, [r5, #28]
	mov	r0, r8
	mov	r2, #64
	mla	r3, ip, r3, r1
	ldrb	r1, [r3, #27]
	cmp	r1, #1
	beq	.L2149
	ldr	r1, .L2150+100
	cmp	r6, #0
	ldr	r3, .L2150+92
	add	ip, r1, #64
	ldr	r3, [r3, #52]
	movne	r1, ip
	blx	r3
.L2118:
	add	r6, r6, #1
	add	r8, r8, #64
	cmp	r6, #2
	add	r10, r10, #256
	add	r7, r7, #4
	add	r9, r9, #1
	bne	.L2122
	b	.L2123
.L2146:
	mov	r3, r2
	str	r8, [sp]
	mov	r2, r7
	mov	r1, r9
	mov	r0, r4
	bl	MVC_Scaling_List
	ldr	r3, [r8]
	cmp	r3, #1
	bne	.L2109
	ldr	r1, .L2150+88
	mov	r2, #16
	ldr	r3, .L2150+92
	cmp	r6, #2
	add	r0, r1, r2
	ldr	r3, [r3, #52]
	movhi	r1, r0
	mov	r0, r7
	blx	r3
	b	.L2109
.L2144:
	ldr	r2, .L2150+92
	add	r1, r6, #167
	mov	r0, r7
	add	r1, r3, r1, lsl #4
	ldr	ip, [r2, #52]
	mov	r2, #16
	blx	ip
	b	.L2109
.L2142:
	ldr	r1, .L2150+104
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2094
.L2148:
	ldr	r1, .L2150+108
	mov	r0, r4
	bl	mvc_u_1
	mov	r2, r8
	mov	r1, r10
	mov	r3, #64
	mov	ip, r0
	cmp	ip, #1
	mov	r0, r4
	str	ip, [r7]
	strb	ip, [r9]
	bne	.L2117
	str	r7, [sp]
	bl	MVC_Scaling_List
	ldr	r3, [r7]
	cmp	r3, #1
	bne	.L2118
	ldr	r1, .L2150+100
	mov	r2, #64
	ldr	r3, .L2150+92
	cmp	r6, #0
	add	r0, r1, r2
	ldr	r3, [r3, #52]
	movne	r1, r0
	mov	r0, r8
	blx	r3
	b	.L2118
.L2149:
	add	r1, r3, r6, lsl #6
	ldr	r3, .L2150+92
	add	r1, r1, #2768
	ldr	ip, [r3, #52]
	blx	ip
	b	.L2118
.L2151:
	.align	2
.L2150:
	.word	.LC143
	.word	.LC144
	.word	.LC145
	.word	.LC146
	.word	g_event_report
	.word	.LC161
	.word	.LC162
	.word	.LC163
	.word	.LC166
	.word	.LC147
	.word	.LC149
	.word	.LC151
	.word	.LC152
	.word	.LC154
	.word	.LC155
	.word	.LC156
	.word	.LC157
	.word	.LC158
	.word	.LC159
	.word	.LC160
	.word	.LC148
	.word	.LC150
	.word	.LANCHOR1
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC164
	.word	.LANCHOR1+32
	.word	.LC153
	.word	.LC165
	.fnend
	.size	MVC_ProcessPPS, .-MVC_ProcessPPS
	.align	2
	.global	MVC_PPSEqual
	.type	MVC_PPSEqual, %function
MVC_PPSEqual:
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
	subs	r6, r0, #0
	beq	.L2179
	cmp	r1, #0
	beq	.L2180
	ldr	r2, [r1, #28]
	ldr	r0, [r6, #28]
	ldr	r3, [r6, #24]
	ldr	ip, [r1, #24]
	ldrb	lr, [r6]
	cmp	r0, r2
	cmpeq	r3, ip
	ldrb	r4, [r1]
	ldrb	ip, [r6, #1]
	ldrb	r5, [r1, #1]
	moveq	r2, #1
	movne	r2, #0
	ldr	r0, [r6, #36]
	cmp	lr, r4
	movne	r3, #0
	andeq	r3, r2, #1
	ldr	r4, [r1, #36]
	cmp	ip, r5
	movne	lr, #0
	andeq	lr, r3, #1
	ldr	r2, [r6, #40]
	ldr	r5, [r1, #40]
	cmp	r0, r4
	movne	ip, #0
	andeq	ip, lr, #1
	ldrb	r3, [r6, #2]
	ldrb	r4, [r1, #2]
	cmp	r2, r5
	movne	r0, #0
	andeq	r0, ip, #1
	ldr	lr, [r6, #44]
	ldr	r5, [r1, #44]
	cmp	r3, r4
	movne	r2, #0
	andeq	r2, r0, #1
	ldr	ip, [r6, #48]
	ldr	r4, [r1, #48]
	cmp	lr, r5
	movne	r3, #0
	andeq	r3, r2, #1
	ldr	r0, [r6, #52]
	ldr	r5, [r1, #52]
	cmp	ip, r4
	movne	lr, #0
	andeq	lr, r3, #1
	ldrb	r2, [r6, #3]
	ldrb	r4, [r1, #3]
	cmp	r0, r5
	movne	ip, #0
	andeq	ip, lr, #1
	ldrb	r3, [r6, #4]
	ldrb	lr, [r1, #4]
	cmp	r2, r4
	movne	r0, #0
	andeq	r0, ip, #1
	ldr	ip, [r6, #60]
	ldr	r4, [r1, #60]
	cmp	r3, lr
	movne	r2, #0
	andeq	r2, r0, #1
	ldrb	r0, [r6, #18]
	ldrb	lr, [r1, #18]
	cmp	ip, r4
	movne	r3, #0
	andeq	r3, r2, #1
	cmp	lr, r0
	movne	r3, #0
	andeq	r3, r3, #1
	cmp	r0, #0
	beq	.L2156
	mov	ip, ip, asl #1
	adds	r2, ip, #6
	str	r2, [fp, #-56]
	beq	.L2156
	add	r2, r6, #4
	sub	r9, r1, #1088
	str	r2, [fp, #-52]
	add	r2, r1, #4
	str	r2, [fp, #-48]
	add	r2, r1, #64
	sub	r9, r9, #4
	add	r7, r1, #1984
	add	r8, r6, #1984
	mov	r10, r6
	mov	r5, r6
	str	r6, [fp, #-60]
	mov	r0, #0
	mov	r6, r2
	str	r1, [fp, #-64]
.L2161:
	ldr	r1, [fp, #-52]
	ldrb	r2, [r1, #1]!
	str	r1, [fp, #-52]
	ldr	r1, [fp, #-48]
	ldrsb	ip, [r1, #1]!
	str	r1, [fp, #-48]
	sxtb	r1, r2
	cmp	ip, r1
	movne	r3, #0
	andeq	r3, r3, #1
	cmp	r2, #0
	beq	.L2178
	ldr	r2, [r8]
	ldr	r1, [r7]
	cmp	r2, r1
	movne	r3, #0
	andeq	r3, r3, #1
	cmp	r0, #5
	bhi	.L2158
	cmp	r2, #0
	add	r4, r10, #64
	bne	.L2157
	add	r10, r10, #128
	mov	r1, r6
	mov	r2, r4
.L2159:
	ldr	lr, [r2], #4
	ldr	ip, [r1], #4
	cmp	lr, ip
	movne	r3, #0
	andeq	r3, r3, #1
	cmp	r2, r10
	bne	.L2159
.L2157:
	ldr	r2, [fp, #-56]
	add	r0, r0, #1
	add	r8, r8, #4
	add	r7, r7, #4
	cmp	r0, r2
	add	r5, r5, #256
	add	r9, r9, #256
	mov	r10, r4
	add	r6, r6, #64
	bne	.L2161
	ldr	r6, [fp, #-60]
	ldr	r1, [fp, #-64]
.L2156:
	ldr	r0, [r6, #56]
	ldr	r2, [r1, #56]
	cmp	r0, r2
	movne	r0, #0
	andeq	r0, r3, #1
	eor	r0, r0, #1
	rsb	r0, r0, #0
.L2154:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2158:
	cmp	r2, #0
	bne	.L2178
	sub	r2, r5, #1088
	sub	r4, r5, #836
	sub	r2, r2, #4
	mov	r1, r9
.L2160:
	ldr	lr, [r2, #4]!
	ldr	ip, [r1, #4]!
	cmp	lr, ip
	movne	r3, #0
	andeq	r3, r3, #1
	cmp	r2, r4
	bne	.L2160
.L2178:
	add	r4, r10, #64
	b	.L2157
.L2180:
	mov	r0, r1
	movw	r3, #10278
	ldr	r2, .L2181
	ldr	r1, .L2181+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2154
.L2179:
	movw	r3, #10277
	ldr	r2, .L2181
	ldr	r1, .L2181+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2154
.L2182:
	.align	2
.L2181:
	.word	.LC13
	.word	.LC14
	.fnend
	.size	MVC_PPSEqual, .-MVC_PPSEqual
	.align	2
	.global	MVC_DecPPS
	.type	MVC_DecPPS, %function
MVC_DecPPS:
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
	ldr	r1, .L2198
	mov	r4, r0
	bl	mvc_ue_v
	ldr	r3, [r4, #40]
	sub	r3, r3, #1
	cmp	r0, r3
	mov	r5, r0
	bls	.L2184
	mov	r2, r0
	ldr	r1, .L2198+4
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r2, [r4, #40]
	sub	r3, r2, #1
	cmp	r5, r3
	bls	.L2191
	ldr	r3, .L2198+8
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L2191
	str	r2, [fp, #-40]
	mov	r3, #8
	str	r5, [fp, #-44]
	sub	r2, fp, #44
	ldr	r0, [r4, #120]
	mov	r1, #110
	blx	ip
	mvn	r0, #0
.L2185:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L2184:
	ldr	r1, .L2198+12
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r3, [r4, #36]
	sub	r3, r3, #1
	cmp	r0, r3
	mov	ip, r0
	bhi	.L2195
	mov	r8, #2240
	ldr	r3, [r4, #252]
	mul	r6, r8, r5
	add	r3, r3, r6
	ldrb	r7, [r3, #19]
	cmp	r7, #0
	beq	.L2187
	ldr	r7, .L2198+16
	mov	r0, r4
	mov	r1, r7
	str	r5, [r7, #24]
	str	ip, [r7, #28]
	bl	MVC_ProcessPPS
	subs	r5, r0, #0
	bne	.L2196
	ldr	r1, [r4, #252]
	mov	r0, r7
	add	r1, r1, r6
	bl	MVC_PPSEqual
	cmp	r0, #0
	beq	.L2185
	ldr	ip, .L2198+20
	mov	r3, #1
	ldr	r0, [r4, #252]
	mov	r2, r8
	mov	r1, r7
	strb	r3, [r7, #20]
	add	r0, r0, r6
	ldr	ip, [ip, #56]
	strb	r3, [r7, #19]
	blx	ip
	mov	r0, r5
	b	.L2185
.L2187:
	str	r5, [r3, #24]
	mov	r0, r4
	ldr	r3, [r4, #252]
	add	r3, r3, r6
	str	ip, [r3, #28]
	ldr	r1, [r4, #252]
	add	r1, r1, r6
	bl	MVC_ProcessPPS
	cmp	r0, #0
	bne	.L2197
	ldr	r3, [r4, #252]
	mov	r2, #1
	add	r3, r3, r6
	strb	r2, [r3, #20]
	ldr	r3, [r4, #252]
	add	r6, r3, r6
	strb	r2, [r6, #19]
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L2191:
	mvn	r0, #0
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L2195:
	ldr	r1, .L2198+24
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2185
.L2196:
	movw	r2, #10041
	ldr	r1, .L2198+28
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2185
.L2197:
	movw	r2, #10061
	ldr	r1, .L2198+28
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r4, #252]
	mov	r2, #1
	mvn	r0, #0
	add	r3, r3, r6
	strb	r2, [r3, #20]
	ldr	r3, [r4, #252]
	add	r6, r3, r6
	strb	r7, [r6, #19]
	b	.L2185
.L2199:
	.align	2
.L2198:
	.word	.LC167
	.word	.LC168
	.word	g_event_report
	.word	.LC169
	.word	.LANCHOR2
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC170
	.word	.LC171
	.fnend
	.size	MVC_DecPPS, .-MVC_DecPPS
	.align	2
	.global	mvc_vui_parameters
	.type	mvc_vui_parameters, %function
mvc_vui_parameters:
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
	mov	r5, r1
	ldr	r1, .L2248
	mov	r4, r0
	bl	mvc_u_1
	uxtb	r0, r0
	strb	r0, [r5]
	cmp	r0, #0
	streqb	r0, [r5, #15]
	bne	.L2242
.L2202:
	ldr	r1, .L2248+4
	mov	r0, r4
	bl	mvc_u_1
	uxtb	r0, r0
	strb	r0, [r5, #1]
	cmp	r0, #0
	bne	.L2243
.L2203:
	ldr	r1, .L2248+8
	mov	r0, r4
	bl	mvc_u_1
	uxtb	r0, r0
	strb	r0, [r5, #3]
	cmp	r0, #0
	moveq	r3, #5
	streq	r3, [r5, #28]
	bne	.L2244
.L2205:
	ldr	r1, .L2248+12
	mov	r0, r4
	bl	mvc_u_1
	uxtb	r0, r0
	strb	r0, [r5, #6]
	cmp	r0, #0
	bne	.L2245
.L2206:
	ldr	r1, .L2248+16
	mov	r0, r4
	bl	mvc_u_1
	uxtb	r0, r0
	strb	r0, [r5, #8]
	cmp	r0, #0
	bne	.L2246
.L2208:
	ldr	r1, .L2248+20
	mov	r0, r4
	bl	mvc_u_1
	uxtb	r0, r0
	strb	r0, [r5, #7]
	cmp	r0, #0
	beq	.L2210
	ldr	r1, .L2248+24
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r2, .L2248+28
	mov	r1, #4
	str	r0, [r5, #96]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2248+32
	mov	r1, #4
	strb	r0, [r5, #92]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r3, [r5, #96]
	cmp	r3, #31
	strb	r0, [r5, #93]
	bhi	.L2213
	ldrb	r6, [r4, #10]
	cmp	r6, #0
	bne	.L2213
	add	r7, r5, #96
	add	r8, r5, #59
.L2214:
	ldr	r1, .L2248+36
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r1, .L2248+40
	add	r6, r6, #1
	str	r0, [r7, #4]!
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r1, .L2248+44
	str	r0, [r7, #128]
	mov	r0, r4
	bl	mvc_u_1
	strb	r0, [r8, #1]!
	ldr	r3, [r5, #96]
	cmp	r3, r6
	bcs	.L2214
	ldr	r2, .L2248+48
	mov	r1, #5
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2248+52
	mov	r1, #5
	str	r0, [r5, #356]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2248+56
	mov	r1, #5
	str	r0, [r5, #360]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2248+60
	mov	r1, #5
	str	r0, [r5, #364]
	mov	r0, r4
	bl	mvc_u_v
	str	r0, [r5, #368]
.L2210:
	ldr	r1, .L2248+64
	mov	r0, r4
	bl	mvc_u_1
	uxtb	r0, r0
	strb	r0, [r5, #10]
	cmp	r0, #0
	bne	.L2247
	ldrb	r3, [r5, #7]
	cmp	r3, #0
	bne	.L2219
.L2218:
	ldr	r1, .L2248+68
	mov	r0, r4
	bl	mvc_u_1
	ldr	r1, .L2248+72
	strb	r0, [r5, #11]
	mov	r0, r4
	bl	mvc_u_1
	uxtb	r0, r0
	strb	r0, [r5, #12]
	cmp	r0, #0
	bne	.L2220
	ldrb	r0, [r4, #10]
.L2221:
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r0, r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2247:
	ldr	r1, .L2248+24
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r2, .L2248+28
	mov	r1, #4
	str	r0, [r5, #408]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2248+32
	mov	r1, #4
	strb	r0, [r5, #404]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r3, [r5, #408]
	cmp	r3, #31
	strb	r0, [r5, #405]
	bhi	.L2213
	ldrb	r6, [r4, #10]
	cmp	r6, #0
	bne	.L2213
	add	r8, r5, #368
	add	r7, r5, #408
	add	r8, r8, #3
.L2216:
	ldr	r1, .L2248+36
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r1, .L2248+40
	add	r6, r6, #1
	str	r0, [r7, #4]!
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r1, .L2248+44
	str	r0, [r7, #128]
	mov	r0, r4
	bl	mvc_u_1
	strb	r0, [r8, #1]!
	ldr	r3, [r5, #408]
	cmp	r3, r6
	bcs	.L2216
	ldr	r2, .L2248+48
	mov	r1, #5
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2248+52
	mov	r1, #5
	str	r0, [r5, #668]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2248+56
	mov	r1, #5
	str	r0, [r5, #672]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2248+60
	mov	r1, #5
	str	r0, [r5, #676]
	mov	r0, r4
	bl	mvc_u_v
	ldrb	r3, [r5, #7]
	cmp	r3, #0
	str	r0, [r5, #680]
	bne	.L2219
	ldrb	r3, [r5, #10]
	cmp	r3, #0
	beq	.L2218
.L2219:
	ldr	r1, .L2248+76
	mov	r0, r4
	bl	mvc_u_1
	strb	r0, [r5, #14]
	b	.L2218
.L2246:
	ldr	r2, .L2248+80
	mov	r1, #32
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2248+84
	mov	r1, #32
	str	r0, [r5, #52]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r1, .L2248+88
	str	r0, [r5, #56]
	mov	r0, r4
	bl	mvc_u_1
	uxtb	r0, r0
	strb	r0, [r5, #9]
	cmp	r0, #1
	bne	.L2208
	ldr	r1, [r5, #52]
	cmp	r1, #0
	beq	.L2208
	ldr	r0, [r5, #56]
	bl	__aeabi_uidiv
	mov	r0, r0, lsr #1
	str	r0, [r4, #56]
	b	.L2208
.L2245:
	ldr	r1, .L2248+92
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r1, .L2248+96
	str	r0, [r5, #44]
	mov	r0, r4
	bl	mvc_ue_v
	str	r0, [r5, #48]
	b	.L2206
.L2244:
	ldr	r2, .L2248+100
	mov	r1, #3
	mov	r0, r4
	bl	mvc_u_v
	ldr	r1, .L2248+104
	str	r0, [r5, #28]
	mov	r0, r4
	bl	mvc_u_1
	ldr	r1, .L2248+108
	strb	r0, [r5, #4]
	mov	r0, r4
	bl	mvc_u_1
	uxtb	r0, r0
	strb	r0, [r5, #5]
	cmp	r0, #0
	beq	.L2205
	ldr	r2, .L2248+112
	mov	r1, #8
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2248+116
	mov	r1, #8
	str	r0, [r5, #32]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2248+120
	mov	r1, #8
	str	r0, [r5, #36]
	mov	r0, r4
	bl	mvc_u_v
	str	r0, [r5, #40]
	b	.L2205
.L2243:
	ldr	r1, .L2248+124
	mov	r0, r4
	bl	mvc_u_1
	strb	r0, [r5, #2]
	b	.L2203
.L2242:
	ldr	r2, .L2248+128
	mov	r1, #8
	mov	r0, r4
	bl	mvc_u_v
	uxtb	r0, r0
	strb	r0, [r5, #15]
	cmp	r0, #255
	bne	.L2202
	ldr	r2, .L2248+132
	mov	r1, #16
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2248+136
	mov	r1, #16
	str	r0, [r5, #16]
	mov	r0, r4
	bl	mvc_u_v
	str	r0, [r5, #20]
	b	.L2202
.L2220:
	ldr	r1, .L2248+140
	mov	r0, r4
	bl	mvc_u_1
	ldr	r1, .L2248+144
	strb	r0, [r5, #13]
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r1, .L2248+148
	str	r0, [r5, #684]
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r1, .L2248+152
	str	r0, [r5, #688]
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r1, .L2248+156
	str	r0, [r5, #696]
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r1, .L2248+160
	str	r0, [r5, #692]
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r1, .L2248+164
	str	r0, [r5, #700]
	mov	r0, r4
	bl	mvc_ue_v
	str	r0, [r5, #704]
	ldrb	r0, [r4, #10]
	cmp	r0, #0
	beq	.L2221
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2213:
	ldr	r1, .L2248+168
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2249:
	.align	2
.L2248:
	.word	.LC172
	.word	.LC176
	.word	.LC178
	.word	.LC185
	.word	.LC188
	.word	.LC192
	.word	.LC193
	.word	.LC194
	.word	.LC195
	.word	.LC197
	.word	.LC198
	.word	.LC199
	.word	.LC200
	.word	.LC201
	.word	.LC202
	.word	.LC203
	.word	.LC204
	.word	.LC206
	.word	.LC207
	.word	.LC205
	.word	.LC189
	.word	.LC190
	.word	.LC191
	.word	.LC186
	.word	.LC187
	.word	.LC179
	.word	.LC180
	.word	.LC181
	.word	.LC182
	.word	.LC183
	.word	.LC184
	.word	.LC177
	.word	.LC173
	.word	.LC174
	.word	.LC175
	.word	.LC208
	.word	.LC209
	.word	.LC210
	.word	.LC211
	.word	.LC212
	.word	.LC213
	.word	.LC214
	.word	.LC196
	.fnend
	.size	mvc_vui_parameters, .-mvc_vui_parameters
	.align	2
	.global	MVC_SPSEqual
	.type	MVC_SPSEqual, %function
MVC_SPSEqual:
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
	subs	r5, r0, #0
	beq	.L2282
	cmp	r1, #0
	beq	.L2283
	ldrb	lr, [r1]
	ldrb	r3, [r5]
	ldr	ip, [r5, #736]
	ldr	r2, [r1, #736]
	ldrb	r0, [r5, #1]
	cmp	r3, lr
	cmpeq	ip, r2
	ldrb	r6, [r1, #1]
	ldrb	r2, [r5, #2]
	ldrb	r4, [r1, #2]
	moveq	lr, #1
	movne	lr, #0
	ldr	r3, [r5, #740]
	cmp	r0, r6
	movne	ip, #0
	andeq	ip, lr, #1
	ldr	r6, [r1, #740]
	cmp	r2, r4
	movne	r0, #0
	andeq	r0, ip, #1
	ldr	lr, [r1, #744]
	ldr	r4, [r5, #744]
	cmp	r3, r6
	movne	r2, #0
	andeq	r2, r0, #1
	ldrb	ip, [r1, #27]
	ldrb	r0, [r5, #27]
	cmp	r4, lr
	movne	r3, #0
	andeq	r3, r2, #1
	cmp	ip, r0
	movne	r3, #0
	andeq	r3, r3, #1
	cmp	r0, #0
	beq	.L2254
	add	r0, r1, #5
	add	r2, r5, #5
	sub	r9, r1, #404
	add	r7, r1, #748
	mov	ip, r0
	mov	r8, r5
	mov	r6, r5
	str	r5, [fp, #-48]
	mov	r0, #0
	mov	r4, r2
	mov	r5, ip
	str	r1, [fp, #-52]
.L2259:
	ldrb	r2, [r4, #1]!
	ldrsb	ip, [r5, #1]!
	sxtb	r1, r2
	cmp	ip, r1
	movne	r3, #0
	andeq	r3, r3, #1
	cmp	r2, #0
	beq	.L2255
	cmp	r0, #5
	bhi	.L2256
	add	r2, r6, #748
	add	r10, r6, #812
	mov	r1, r7
.L2257:
	ldr	lr, [r2, #4]!
	ldr	ip, [r1, #4]!
	cmp	lr, ip
	movne	r3, #0
	andeq	r3, r3, #1
	cmp	r2, r10
	bne	.L2257
.L2255:
	add	r0, r0, #1
	add	r8, r8, #256
	cmp	r0, #8
	add	r9, r9, #256
	add	r6, r6, #64
	add	r7, r7, #64
	bne	.L2259
	ldr	r5, [fp, #-48]
	ldr	r1, [fp, #-52]
.L2254:
	ldr	r2, [r1, #2896]
	ldr	ip, [r5, #2900]
	ldr	r0, [r1, #2900]
	ldr	lr, [r5, #2896]
	cmp	ip, r0
	cmpeq	lr, r2
	moveq	r2, #1
	movne	r2, #0
	cmp	ip, #0
	and	r3, r3, r2
	beq	.L2261
	cmp	ip, #1
	bne	.L2260
	ldr	r0, [r1, #2908]
	ldr	ip, [r5, #2908]
	ldrb	r2, [r5, #18]
	ldrb	r6, [r1, #18]
	ldr	r4, [r5, #2912]
	cmp	ip, r0
	cmpeq	r2, r6
	ldr	lr, [r1, #2912]
	ldr	r6, [r5, #2916]
	ldr	ip, [r1, #2916]
	moveq	r0, #1
	movne	r0, #0
	cmp	r4, lr
	movne	r2, #0
	andeq	r2, r0, #1
	cmp	r6, ip
	movne	r2, #0
	andeq	r2, r2, #1
	cmp	r6, #0
	and	r3, r3, r2
	beq	.L2260
	add	ip, r5, #2912
	add	r0, r1, #2912
	add	ip, ip, #4
	add	r0, r0, #4
	mov	r2, #0
.L2263:
	ldr	r4, [ip, #4]!
	add	r2, r2, #1
	ldr	lr, [r0, #4]!
	cmp	r4, lr
	movne	r3, #0
	andeq	r3, r3, #1
	cmp	r2, r6
	bne	.L2263
.L2260:
	ldrb	ip, [r1, #19]
	ldrb	lr, [r5, #19]
	ldr	r0, [r5, #3944]
	ldr	r4, [r1, #3944]
	ldr	r2, [r5, #3948]
	cmp	lr, ip
	cmpeq	r0, r4
	ldr	r7, [r1, #3948]
	ldr	r6, [r5, #3952]
	ldr	r4, [r1, #3952]
	moveq	ip, #1
	movne	ip, #0
	ldrb	lr, [r1, #20]
	cmp	r2, r7
	movne	r0, #0
	andeq	r0, ip, #1
	ldrb	ip, [r5, #20]
	cmp	r6, r4
	movne	r2, #0
	andeq	r2, r0, #1
	cmp	lr, ip
	movne	r2, #0
	andeq	r2, r2, #1
	cmp	ip, #0
	and	r3, r3, r2
	bne	.L2264
	ldrb	r0, [r5, #21]
	ldrb	r2, [r1, #21]
	cmp	r0, r2
	movne	r3, #0
	andeq	r3, r3, #1
.L2264:
	ldrb	r2, [r1, #22]
	ldrb	ip, [r5, #23]
	ldrb	r0, [r1, #23]
	ldrb	lr, [r5, #22]
	cmp	r0, ip
	cmpeq	lr, r2
	moveq	r2, #1
	movne	r2, #0
	cmp	ip, #0
	and	r3, r3, r2
	bne	.L2284
.L2265:
	ldrb	r0, [r5, #24]
	ldrb	r2, [r1, #24]
	cmp	r0, r2
	movne	r0, #0
	andeq	r0, r3, #1
	eor	r0, r0, #1
	rsb	r0, r0, #0
.L2252:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2284:
	ldr	ip, [r1, #3960]
	ldr	lr, [r5, #3960]
	ldr	r0, [r5, #3956]
	ldr	r4, [r1, #3956]
	ldr	r2, [r1, #3964]
	cmp	lr, ip
	cmpeq	r0, r4
	ldr	r6, [r5, #3964]
	ldr	r4, [r5, #3968]
	ldr	lr, [r1, #3968]
	moveq	ip, #1
	movne	ip, #0
	cmp	r6, r2
	movne	r0, #0
	andeq	r0, ip, #1
	cmp	r4, lr
	movne	r2, #0
	andeq	r2, r0, #1
	and	r3, r3, r2
	b	.L2265
.L2256:
	sub	r2, r8, #404
	sub	r10, r8, #148
	mov	r1, r9
.L2258:
	ldr	lr, [r2, #4]!
	ldr	ip, [r1, #4]!
	cmp	lr, ip
	movne	r3, #0
	andeq	r3, r3, #1
	cmp	r2, r10
	bne	.L2258
	b	.L2255
.L2261:
	ldr	r0, [r5, #2904]
	ldr	r2, [r1, #2904]
	cmp	r0, r2
	movne	r3, #0
	andeq	r3, r3, #1
	b	.L2260
.L2283:
	mov	r0, r1
	movw	r3, #10522
	ldr	r2, .L2285
	ldr	r1, .L2285+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2252
.L2282:
	movw	r3, #10521
	ldr	r2, .L2285
	ldr	r1, .L2285+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2252
.L2286:
	.align	2
.L2285:
	.word	.LC13
	.word	.LC14
	.fnend
	.size	MVC_SPSEqual, .-MVC_SPSEqual
	.global	__aeabi_idiv
	.align	2
	.global	MVC_GetDar
	.type	MVC_GetDar, %function
MVC_GetDar:
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
	cmp	r0, #0
	moveq	r4, r0
	beq	.L2288
	subs	lr, r0, #255
	movne	lr, #1
	cmp	r0, #16
	movle	r4, #0
	andgt	r4, lr, #1
	cmp	r4, #0
	movne	r4, #0
	bne	.L2288
	cmp	r2, #0
	cmpne	r1, #0
	moveq	ip, #1
	movne	ip, #0
	cmp	r0, #255
	movne	ip, #0
	andeq	ip, ip, #1
	cmp	ip, #0
	bne	.L2288
	cmp	r0, #1
	moveq	r4, #5
	beq	.L2288
	cmp	lr, #0
	ldrne	r2, .L2314
	addne	r0, r2, r0, lsl #3
	ldrne	r1, [r0, #100]
	ldrne	r2, [r0, #104]
	mul	r0, r3, r1
	ldr	r3, [fp, #4]
	mul	r1, r3, r2
	mov	r0, r0, asl #10
	bl	__aeabi_idiv
	sub	r3, r0, #2400
	sub	r2, r0, #2256
	sub	r3, r3, #6
	sub	r2, r2, #7
	cmp	r3, #0
	rsblt	r3, r0, #2400
	addlt	r3, r3, #6
	cmp	r2, #0
	rsblt	r2, r0, #2256
	addlt	r2, r2, #7
	cmp	r3, r2
	movlt	r4, #4
	blt	.L2288
	sub	r3, r0, #1808
	sub	r3, r3, #12
	cmp	r3, #0
	rsblt	r3, r0, #1808
	addlt	r3, r3, #12
	cmp	r2, r3
	movlt	r4, #3
	bge	.L2313
.L2288:
	mov	r2, r4
	ldr	r1, .L2314+4
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L2313:
	sub	r4, r0, #1360
	sub	r4, r4, #5
	cmp	r4, #0
	rsblt	r4, r0, #1360
	addlt	r4, r4, #5
	cmp	r3, r4
	movlt	r4, #2
	movge	r4, #1
	b	.L2288
.L2315:
	.align	2
.L2314:
	.word	.LANCHOR0
	.word	.LC215
	.fnend
	.size	MVC_GetDar, .-MVC_GetDar
	.align	2
	.global	MVC_ProcessSPS
	.type	MVC_ProcessSPS, %function
MVC_ProcessSPS:
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
	subs	r5, r1, #0
	mov	r4, r0
	beq	.L2429
	ldr	r3, [r5, #736]
	cmp	r3, #100
	cmpne	r3, #122
	bic	r1, r3, #16
	sub	r3, r3, #110
	moveq	r2, #1
	movne	r2, #0
	cmp	r1, #128
	orreq	r2, r2, #1
	bics	r3, r3, #8
	orreq	r3, r2, #1
	movne	r3, r2
	cmp	r3, #0
	streqb	r3, [r5, #27]
	moveq	r3, #1
	streq	r3, [r5, #748]
	bne	.L2430
.L2329:
	ldr	r1, .L2444
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r0, #12
	str	r0, [r5, #2896]
	bhi	.L2342
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2342
	ldr	r1, .L2444+4
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r0, #2
	str	r0, [r5, #2900]
	bhi	.L2344
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2344
	cmp	r0, #0
	beq	.L2431
	cmp	r0, #1
	beq	.L2432
.L2350:
	ldr	r1, .L2444+8
	mov	r0, r4
	bl	mvc_ue_v
	str	r0, [r5, #3944]
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2427
	ldr	r1, .L2444+12
	mov	r0, r4
	bl	mvc_u_1
	strb	r0, [r5, #19]
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2427
	ldr	r1, .L2444+16
	mov	r0, r4
	bl	mvc_ue_v
	movw	r7, #509
	sub	r3, r0, #1
	str	r0, [r5, #3948]
	cmp	r3, r7
	bhi	.L2355
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2355
	ldr	r1, .L2444+20
	mov	r0, r4
	bl	mvc_ue_v
	str	r0, [r5, #3952]
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2427
	ldr	r1, .L2444+24
	mov	r0, r4
	bl	mvc_u_1
	uxtb	r0, r0
	strb	r0, [r5, #20]
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2427
	cmp	r0, #0
	bne	.L2433
	ldr	r1, .L2444+28
	mov	r0, r4
	bl	mvc_u_1
	ldr	r6, [r5, #3952]
	add	r6, r6, #1
	cmp	r6, #255
	strb	r0, [r5, #21]
	bhi	.L2388
	ldr	r3, [r5, #3948]
	add	r3, r3, #1
	cmp	r6, #1
	cmphi	r3, #3
	movhi	r8, #2
	bhi	.L2359
.L2388:
	ldr	r1, .L2444+32
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2420
.L2430:
	ldr	r1, .L2444+36
	bl	mvc_ue_v
	cmp	r0, #1
	str	r0, [r5, #748]
	bhi	.L2320
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2320
	ldr	r1, .L2444+40
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r0, #0
	bne	.L2322
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	beq	.L2323
.L2322:
	ldr	r1, .L2444+44
	mov	r0, #1
	bl	dprint_vfmw
.L2323:
	ldr	r1, .L2444+48
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r0, #0
	bne	.L2324
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	beq	.L2325
.L2324:
	ldr	r1, .L2444+52
	mov	r0, #1
	bl	dprint_vfmw
.L2325:
	ldr	r1, .L2444+56
	mov	r0, r4
	bl	mvc_u_1
	cmp	r0, #0
	bne	.L2326
	ldrb	r10, [r4, #10]
	cmp	r10, #0
	bne	.L2326
	ldr	r1, .L2444+60
	mov	r0, r4
	bl	mvc_u_1
	uxtb	r0, r0
	strb	r0, [r5, #27]
	cmp	r0, #1
	bne	.L2329
	sub	r7, fp, #72
	add	r9, r5, #5
	add	r6, r5, #2672
	add	r8, r5, #752
	b	.L2335
.L2436:
	ldr	r3, .L2444+64
	cmp	r1, #0
	add	ip, r3, #16
	moveq	r3, ip
	mov	r1, r3
	ldr	r3, .L2444+68
	ldr	r3, [r3, #52]
	blx	r3
.L2331:
	add	r10, r10, #1
	add	r6, r6, #16
	cmp	r10, #6
	add	r8, r8, #64
	beq	.L2434
.L2335:
	ldr	r1, .L2444+72
	mov	r0, r4
	bl	mvc_u_1
	clz	r1, r10
	mov	r2, #16
	mov	r1, r1, lsr #5
	cmp	r0, #1
	mov	r3, r0
	mov	r0, r6
	str	r3, [r7, #4]!
	strb	r3, [r9, #1]!
	beq	.L2435
	cmp	r10, #0
	cmpne	r10, #3
	beq	.L2436
	ldr	r3, .L2444+68
	mov	r2, #16
	sub	r1, r6, #16
	mov	r0, r6
	ldr	r3, [r3, #52]
	blx	r3
	b	.L2331
.L2386:
	cmp	r1, r9
	cmpcs	r0, r6
	bcs	.L2385
	ldr	r3, .L2444+76
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L2427
	strh	r1, [fp, #-72]
	mov	r3, #8
	strh	r0, [fp, #-70]
	sub	r2, fp, #76
	strh	r9, [fp, #-76]
	mov	r1, #107
	strh	r6, [fp, #-74]
	ldr	r0, [r4, #120]
	blx	ip
.L2427:
	mvn	r0, #0
.L2420:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2433:
	ldr	r6, [r5, #3952]
	strb	r3, [r5, #21]
	sub	r3, r6, #1
	cmp	r3, r7
	bhi	.L2388
	ldr	r3, [r5, #3948]
	mov	r8, #1
	add	r6, r6, #1
	add	r3, r3, r8
.L2359:
	mul	r6, r6, r8
	mov	r9, r3, asl #4
	mov	r6, r6, asl #4
	mul	r1, r9, r6
	add	r1, r1, r1, lsr #1
	cmp	r1, #100663296
	bhi	.L2437
	ldr	r2, [r5, #740]
	sub	r3, r2, #10
	cmp	r3, #31
	ldrls	pc, [pc, r3, asl #2]
	b	.L2361
.L2363:
	.word	.L2362
	.word	.L2364
	.word	.L2395
	.word	.L2395
	.word	.L2361
	.word	.L2361
	.word	.L2361
	.word	.L2361
	.word	.L2361
	.word	.L2361
	.word	.L2395
	.word	.L2366
	.word	.L2368
	.word	.L2361
	.word	.L2361
	.word	.L2361
	.word	.L2361
	.word	.L2361
	.word	.L2361
	.word	.L2361
	.word	.L2368
	.word	.L2369
	.word	.L2370
	.word	.L2361
	.word	.L2361
	.word	.L2361
	.word	.L2361
	.word	.L2361
	.word	.L2361
	.word	.L2361
	.word	.L2372
	.word	.L2372
.L2431:
	ldr	r1, .L2444+80
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r0, #12
	str	r0, [r5, #2904]
	bhi	.L2347
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	beq	.L2350
.L2347:
	ldr	r1, .L2444+84
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2420
.L2395:
	mov	r0, #60416
	movt	r0, 13
.L2365:
	bl	__aeabi_uidiv
	ldr	r1, .L2444+88
	cmp	r0, #16
	movcc	r7, r0
	movcs	r7, #16
	mov	r2, r7
	mov	r0, #21
	bl	dprint_vfmw
	ldr	r2, [r5, #3944]
	cmp	r2, r7
	bhi	.L2373
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	beq	.L2374
.L2373:
	mov	r3, r7
	ldr	r1, .L2444+92
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r3, [r5, #3944]
	cmp	r3, #16
	bhi	.L2424
	cmp	r7, r3
	movcc	r7, r3
.L2424:
	str	r7, [r5, #3944]
.L2374:
	ldr	r1, .L2444+96
	mov	r0, r4
	bl	mvc_u_1
	strb	r0, [r5, #22]
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2427
	ldr	r1, .L2444+100
	mov	r0, r4
	bl	mvc_u_1
	uxtb	r0, r0
	strb	r0, [r5, #23]
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2427
	cmp	r0, #0
	bne	.L2438
.L2376:
	mov	r2, r9, lsr #1
	mov	r3, r6, lsr #1
	str	r9, [r5, #3976]
	str	r6, [r5, #3980]
	str	r2, [r5, #3984]
	str	r3, [r5, #3988]
.L2378:
	ldr	r1, .L2444+104
	mov	r0, r4
	bl	mvc_u_1
	uxtb	r3, r0
	strb	r3, [r5, #24]
	ldrb	r2, [r4, #10]
	cmp	r2, #0
	bne	.L2427
	cmp	r3, #0
	mov	r2, #2
	str	r2, [r5, #68]
	bne	.L2439
	mov	r0, r3
	strb	r3, [r5, #43]
	mov	r3, #5
	str	r3, [r5, #56]
.L2381:
	ldr	r2, [r5, #48]
	mov	r3, r9
	ldr	r1, [r5, #44]
	str	r6, [sp]
	bl	MVC_GetDar
	ldr	r3, [r5, #3944]
	cmp	r3, #0
	str	r0, [r5, #52]
	beq	.L2384
	cmp	r7, r3
	movcs	r7, r3
.L2384:
	ldr	r3, [r4, #224]
	cmp	r7, #16
	movcs	r7, #16
	ldr	r2, [r3, #28]
	cmp	r2, #25
	beq	.L2440
.L2385:
	cmp	r6, #1920
	bcc	.L2387
	cmp	r7, #4
	movcs	r7, #4
.L2387:
	add	r7, r7, #1
	mov	r0, #0
	str	r7, [r5, #3972]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2372:
	mov	r0, #12582912
	b	.L2365
.L2368:
	mov	r0, #30208
	movt	r0, 47
	b	.L2365
.L2434:
	sub	r7, fp, #88
	add	r9, r5, #11
	add	r6, r5, #2768
	add	r8, r5, #1136
	mov	r10, #0
.L2340:
	ldr	r1, .L2444+72
	mov	r0, r4
	bl	mvc_u_1
	mov	r2, #64
	mov	r3, r0
	cmp	r3, #1
	mov	r0, r6
	str	r3, [r7, #4]!
	strb	r3, [r9, #1]!
	beq	.L2441
	ldr	r1, .L2444+108
	cmp	r10, #0
	ldr	r3, .L2444+68
	add	ip, r1, #64
	ldr	r3, [r3, #52]
	movne	r1, ip
	blx	r3
.L2337:
	add	r10, r10, #1
	add	r6, r6, #64
	cmp	r10, #2
	add	r8, r8, #256
	bne	.L2340
	b	.L2329
.L2435:
	mov	r3, r2
	str	r7, [sp]
	mov	r2, r6
	mov	r1, r8
	mov	r0, r4
	bl	MVC_Scaling_List
	ldr	r3, [r7]
	cmp	r3, #1
	bne	.L2331
	ldr	r1, .L2444+64
	mov	r2, #16
	ldr	r3, .L2444+68
	cmp	r10, #2
	add	r0, r1, r2
	ldr	r3, [r3, #52]
	movhi	r1, r0
	mov	r0, r6
	blx	r3
	b	.L2331
.L2320:
	ldr	r1, .L2444+112
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2342:
	ldr	r1, .L2444+116
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2420
.L2438:
	ldr	r1, .L2444+120
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r1, .L2444+124
	str	r0, [r5, #3956]
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r1, .L2444+128
	str	r0, [r5, #3960]
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r1, .L2444+132
	str	r0, [r5, #3964]
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r3, [r5, #3964]
	ldr	r2, [r5, #3956]
	mov	r1, r8, asl #1
	ldr	ip, [r5, #3960]
	mov	r3, r3, asl #1
	mov	r2, r2, asl #1
	mul	r8, r8, r3
	rsb	r3, r2, r9
	sub	r3, r3, ip, asl #1
	rsb	ip, r8, r6
	str	r0, [r5, #3968]
	mls	r0, r0, r1, ip
	cmp	r3, #0
	cmpgt	r0, #0
	ble	.L2376
	add	r2, r2, r3, lsr #1
	add	r8, r8, r0, lsr #1
	str	r2, [r5, #3984]
	str	r8, [r5, #3988]
	str	r3, [r5, #3976]
	str	r0, [r5, #3980]
	b	.L2378
.L2439:
	add	r1, r5, #28
	mov	r0, r4
	bl	mvc_vui_parameters
	cmp	r0, #0
	bne	.L2426
	ldrb	r3, [r5, #40]
	cmp	r3, #0
	beq	.L2426
	ldr	r2, [r5, #732]
	clz	r3, r2
	mov	r3, r3, lsr #5
	cmp	r7, r2
	orrcc	r3, r3, #1
	cmp	r3, #0
	bne	.L2442
	ldr	r3, [r5, #3944]
	ldrb	r0, [r5, #43]
	cmp	r2, r3
	movcs	r7, r2
	movcc	r7, r3
	b	.L2381
.L2442:
	mov	r3, r7
	ldr	r1, .L2444+136
	mov	r0, #1
	bl	dprint_vfmw
.L2426:
	ldrb	r0, [r5, #43]
	b	.L2381
.L2440:
	ldr	r2, [r3, #700]
	cmp	r2, #0
	bne	.L2385
	ldr	r2, [r3, #684]
	ldr	r1, [r3, #660]
	cmp	r7, r2
	ldr	r0, [r3, #664]
	bls	.L2386
	ldr	r3, .L2444+76
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L2427
	str	r2, [fp, #-72]
	mov	r3, #8
	str	r7, [fp, #-76]
	sub	r2, fp, #76
	ldr	r0, [r4, #120]
	mov	r1, #106
	blx	ip
	mvn	r0, #0
	b	.L2420
.L2326:
	ldr	r1, .L2444+140
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2420
.L2432:
	ldr	r1, .L2444+144
	mov	r0, r4
	bl	mvc_u_1
	strb	r0, [r5, #18]
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2427
	ldr	r1, .L2444+148
	mov	r0, r4
	bl	mvc_se_v
	str	r0, [r5, #2908]
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2427
	ldr	r1, .L2444+152
	mov	r0, r4
	bl	mvc_se_v
	str	r0, [r5, #2912]
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2427
	ldr	r1, .L2444+156
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r0, #255
	str	r0, [r5, #2916]
	bhi	.L2352
	ldrb	r6, [r4, #10]
	cmp	r6, #0
	bne	.L2352
	cmp	r0, #0
	addne	r7, r5, #2912
	addne	r7, r7, #4
	bne	.L2354
	b	.L2350
.L2443:
	ldr	r3, [r5, #2916]
	cmp	r3, r6
	bls	.L2350
.L2354:
	ldr	r1, .L2444+160
	mov	r0, r4
	bl	mvc_se_v
	add	r6, r6, #1
	str	r0, [r7, #4]!
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	beq	.L2443
	b	.L2427
.L2355:
	mov	r2, r0
	ldr	r1, .L2444+164
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2420
.L2369:
	mov	r0, #30720
	movt	r0, 105
	b	.L2365
.L2366:
	mov	r0, #55296
	movt	r0, 27
	b	.L2365
.L2370:
	mov	r0, #7864320
	b	.L2365
.L2364:
	mov	r0, #17920
	movt	r0, 5
	b	.L2365
.L2362:
	mov	r0, #20992
	movt	r0, 2
	b	.L2365
.L2361:
	ldr	r1, .L2444+168
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2420
.L2352:
	ldr	r1, .L2444+172
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2420
.L2441:
	mov	r3, r2
	str	r7, [sp]
	mov	r2, r6
	mov	r1, r8
	mov	r0, r4
	bl	MVC_Scaling_List
	ldr	r3, [r7]
	cmp	r3, #1
	bne	.L2337
	ldr	r1, .L2444+108
	mov	r2, #64
	ldr	r3, .L2444+68
	cmp	r10, #0
	add	r0, r1, r2
	ldr	r3, [r3, #52]
	movne	r1, r0
	mov	r0, r6
	blx	r3
	b	.L2337
.L2344:
	ldr	r1, .L2444+176
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2420
.L2437:
	ldr	r1, .L2444+180
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2420
.L2429:
	mov	r0, r5
	movw	r3, #10711
	ldr	r2, .L2444+184
	ldr	r1, .L2444+188
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2420
.L2445:
	.align	2
.L2444:
	.word	.LC225
	.word	.LC227
	.word	.LC230
	.word	.LC238
	.word	.LC239
	.word	.LC241
	.word	.LC242
	.word	.LC256
	.word	.LC243
	.word	.LC216
	.word	.LC218
	.word	.LC219
	.word	.LC220
	.word	.LC221
	.word	.LC222
	.word	.LC224
	.word	.LANCHOR1
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC164
	.word	g_event_report
	.word	.LC229
	.word	.LC231
	.word	.LC246
	.word	.LC247
	.word	.LC248
	.word	.LC249
	.word	.LC254
	.word	.LANCHOR1+32
	.word	.LC217
	.word	.LC226
	.word	.LC250
	.word	.LC251
	.word	.LC252
	.word	.LC253
	.word	.LC255
	.word	.LC223
	.word	.LC232
	.word	.LC233
	.word	.LC234
	.word	.LC235
	.word	.LC237
	.word	.LC240
	.word	.LC245
	.word	.LC236
	.word	.LC228
	.word	.LC244
	.word	.LC13
	.word	.LC14
	.fnend
	.size	MVC_ProcessSPS, .-MVC_ProcessSPS
	.align	2
	.global	MVC_DecSPS
	.type	MVC_DecSPS, %function
MVC_DecSPS:
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
	ldr	r2, .L2491
	mov	r1, #8
	mov	r4, r0
	bl	mvc_u_v
	ldr	r1, .L2491+4
	mov	r7, r0
	mov	r0, r4
	bl	mvc_u_1
	ldr	r1, .L2491+8
	mov	r9, r0
	mov	r0, r4
	bl	mvc_u_1
	ldr	r1, .L2491+12
	mov	r8, r0
	mov	r0, r4
	bl	mvc_u_1
	ldr	r1, .L2491+16
	str	r0, [fp, #-56]
	mov	r0, r4
	bl	mvc_u_1
	ldr	r1, .L2491+20
	str	r0, [fp, #-60]
	mov	r0, r4
	bl	mvc_u_1
	ldr	r1, .L2491+24
	str	r0, [fp, #-64]
	mov	r0, r4
	bl	mvc_u_1
	ldr	r2, .L2491+28
	mov	r1, #2
	str	r0, [fp, #-68]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2491+32
	mov	r1, #8
	mov	r0, r4
	bl	mvc_u_v
	ldr	r1, .L2491+36
	mov	r5, r0
	mov	r0, r4
	bl	mvc_ue_v
	ldrb	r2, [r4, #10]
	cmp	r2, #0
	mov	r6, r0
	bne	.L2484
	ldr	r2, [r4, #36]
	sub	r2, r2, #1
	cmp	r0, r2
	bhi	.L2486
	cmp	r7, #100
	mov	r10, r7
	beq	.L2452
	bhi	.L2453
	cmp	r7, #77
	beq	.L2452
	cmp	r7, #88
	beq	.L2454
	cmp	r7, #66
	bne	.L2451
	ldr	r1, .L2491+40
	mov	r0, #1
	bl	dprint_vfmw
.L2452:
	cmp	r5, #9
	mov	r2, r5
	bls	.L2483
.L2489:
	cmp	r5, #41
	bhi	.L2483
.L2458:
	movw	r1, #3992
	ldr	r3, [r4, #248]
	mul	r5, r1, r6
	add	r3, r3, r5
	ldrb	ip, [r3, #25]
	cmp	ip, #0
	beq	.L2459
	ldr	r3, .L2491+44
	mov	r0, r4
	ldrb	ip, [fp, #-56]
	add	r1, r3, #2240
	str	r10, [r3, #2976]
	strb	ip, [r3, #2242]
	ldrb	ip, [fp, #-60]
	strb	r9, [r3, #2240]
	strb	r8, [r3, #2241]
	strb	ip, [r3, #2243]
	ldrb	ip, [fp, #-64]
	str	r2, [r3, #2980]
	str	r6, [r3, #2984]
	strb	ip, [r3, #2244]
	ldrb	ip, [fp, #-68]
	str	r3, [fp, #-56]
	strb	ip, [r3, #2245]
	bl	MVC_ProcessSPS
	ldr	r3, [fp, #-56]
	subs	r7, r0, #0
	bne	.L2487
	ldr	r1, [r4, #248]
	add	r0, r3, #2240
	str	r3, [fp, #-56]
	add	r1, r1, r5
	bl	MVC_SPSEqual
	ldr	r3, [fp, #-56]
	cmp	r0, #0
	bne	.L2488
.L2448:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2453:
	cmp	r7, #122
	beq	.L2456
	cmp	r7, #144
	beq	.L2456
	cmp	r7, #110
	beq	.L2456
.L2451:
	mov	r2, r7
	ldr	r1, .L2491+48
	mov	r0, #1
	mov	r10, #100
	bl	dprint_vfmw
	cmp	r5, #9
	mov	r2, r5
	bhi	.L2489
.L2483:
	mov	r3, #41
	ldr	r1, .L2491+52
	mov	r0, #1
	bl	dprint_vfmw
	mov	r2, #41
	b	.L2458
.L2459:
	str	r10, [r3, #736]
	mov	r0, r4
	ldr	r3, [r4, #248]
	ldrb	r1, [fp, #-56]
	str	ip, [fp, #-72]
	strb	r9, [r3, r5]
	ldr	r3, [r4, #248]
	add	r3, r3, r5
	strb	r8, [r3, #1]
	ldr	r3, [r4, #248]
	add	r3, r3, r5
	strb	r1, [r3, #2]
	ldr	r3, [r4, #248]
	ldrb	r1, [fp, #-60]
	add	r3, r3, r5
	strb	r1, [r3, #3]
	ldr	r3, [r4, #248]
	ldrb	r1, [fp, #-64]
	add	r3, r3, r5
	strb	r1, [r3, #4]
	ldr	r3, [r4, #248]
	ldrb	r1, [fp, #-68]
	add	r3, r3, r5
	strb	r1, [r3, #5]
	ldr	r3, [r4, #248]
	add	r3, r3, r5
	str	r2, [r3, #740]
	ldr	r3, [r4, #248]
	add	r3, r3, r5
	str	r6, [r3, #744]
	ldr	r1, [r4, #248]
	add	r1, r1, r5
	bl	MVC_ProcessSPS
	ldr	ip, [fp, #-72]
	cmp	r0, #0
	bne	.L2490
	ldr	r3, [r4, #248]
	mov	r2, #1
	add	r3, r3, r5
	strb	r2, [r3, #26]
	ldr	r3, [r4, #248]
	add	r5, r3, r5
	strb	r2, [r5, #25]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2486:
	ldr	r1, .L2491+56
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r2, [r4, #36]
	sub	r3, r2, #1
	cmp	r6, r3
	bls	.L2484
	ldr	r3, .L2491+60
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L2484
	str	r2, [fp, #-48]
	mov	r3, #8
	str	r6, [fp, #-52]
	sub	r2, fp, #52
	ldr	r0, [r4, #120]
	mov	r1, #109
	blx	ip
.L2484:
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2456:
	ldr	r1, .L2491+64
	mov	r0, #1
	bl	dprint_vfmw
	cmp	r5, #9
	mov	r2, r5
	bhi	.L2489
	b	.L2483
.L2454:
	ldr	r1, .L2491+68
	mov	r0, #1
	bl	dprint_vfmw
	cmp	r5, #9
	mov	r2, r5
	bhi	.L2489
	b	.L2483
.L2488:
	ldr	lr, .L2491+72
	mov	ip, #1
	ldr	r0, [r4, #248]
	movw	r2, #3992
	add	r1, r3, #2240
	strb	ip, [r3, #2266]
	add	r0, r0, r5
	ldr	r4, [lr, #56]
	strb	ip, [r3, #2265]
	blx	r4
	mov	r0, r7
	b	.L2448
.L2487:
	mov	r3, r6
	movw	r2, #11255
	ldr	r1, .L2491+76
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2448
.L2490:
	mov	r3, r6
	movw	r2, #11282
	ldr	r1, .L2491+76
	mov	r0, #1
	str	ip, [fp, #-56]
	bl	dprint_vfmw
	ldr	r3, [r4, #248]
	mov	r2, #1
	ldr	ip, [fp, #-56]
	mvn	r0, #0
	add	r3, r3, r5
	strb	r2, [r3, #26]
	ldr	r3, [r4, #248]
	add	r5, r3, r5
	strb	ip, [r5, #25]
	b	.L2448
.L2492:
	.align	2
.L2491:
	.word	.LC257
	.word	.LC258
	.word	.LC259
	.word	.LC260
	.word	.LC261
	.word	.LC262
	.word	.LC263
	.word	.LC264
	.word	.LC265
	.word	.LC266
	.word	.LC267
	.word	.LANCHOR2
	.word	.LC270
	.word	.LC271
	.word	.LC170
	.word	g_event_report
	.word	.LC269
	.word	.LC268
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC272
	.fnend
	.size	MVC_DecSPS, .-MVC_DecSPS
	.align	2
	.global	MVC_FreeMvcExtMem
	.type	MVC_FreeMvcExtMem, %function
MVC_FreeMvcExtMem:
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
	.size	MVC_FreeMvcExtMem, .-MVC_FreeMvcExtMem
	.align	2
	.global	MVC_FreeMvcVuiExtMem
	.type	MVC_FreeMvcVuiExtMem, %function
MVC_FreeMvcVuiExtMem:
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
	.size	MVC_FreeMvcVuiExtMem, .-MVC_FreeMvcVuiExtMem
	.align	2
	.global	MVC_ProcessSUBSPSMvcExt
	.type	MVC_ProcessSUBSPSMvcExt, %function
MVC_ProcessSUBSPSMvcExt:
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
	subs	r5, r1, #0
	mov	r4, r0
	beq	.L2557
	ldr	r1, .L2558
	bl	mvc_ue_v
	cmp	r0, #1
	str	r0, [r5, #4]
	bhi	.L2498
	ldrb	r6, [r4, #10]
	cmp	r6, #0
	addeq	r7, r5, #4
	bne	.L2498
.L2500:
	ldr	r1, .L2558+4
	mov	r0, r4
	bl	mvc_ue_v
	add	r6, r6, #1
	str	r0, [r7, #4]!
	ldr	r3, [r5, #4]
	cmp	r3, r6
	bcs	.L2500
	cmp	r3, #0
	mov	r2, #0
	str	r2, [r5, #16]
	str	r2, [r5, #24]
	beq	.L2501
	add	r8, r5, #16
	mov	r7, #1
.L2511:
	ldr	r1, .L2558+8
	mov	r0, r4
	bl	mvc_ue_v
	add	r9, r8, #4
	str	r0, [r8, #4]
	ldr	r3, [r5, #4]
	cmp	r3, #15
	movcs	r3, #15
	cmp	r0, r3
	bhi	.L2502
	ldrb	r6, [r4, #10]
	cmp	r6, #0
	bne	.L2502
	cmp	r0, #0
	addne	r10, r8, #16
	beq	.L2507
.L2506:
	ldr	r1, .L2558+12
	mov	r0, r4
	bl	mvc_ue_v
	add	r6, r6, #1
	str	r0, [r10, #4]!
	ldr	r3, [r9]
	cmp	r6, r3
	bcc	.L2506
.L2507:
	ldr	r1, .L2558+16
	mov	r0, r4
	bl	mvc_ue_v
	str	r0, [r9, #8]
	ldr	r3, [r5, #4]
	cmp	r3, #15
	movcc	r2, r3
	movcs	r2, #15
	cmp	r0, r2
	bhi	.L2504
	ldrb	r6, [r4, #10]
	cmp	r6, #0
	bne	.L2504
	cmp	r0, #0
	addne	r8, r8, #24
	beq	.L2509
.L2510:
	ldr	r1, .L2558+20
	mov	r0, r4
	bl	mvc_ue_v
	add	r6, r6, #1
	str	r0, [r8, #4]!
	ldr	r3, [r9, #8]
	cmp	r6, r3
	bcc	.L2510
	ldr	r3, [r5, #4]
.L2509:
	add	r7, r7, #1
	mov	r8, r9
	cmp	r7, r3
	bls	.L2511
	cmp	r3, #0
	mov	r3, #0
	addne	r8, r5, #48
	str	r3, [r5, #48]
	str	r3, [r5, #56]
	movne	r7, #1
	beq	.L2525
.L2524:
	ldr	r1, .L2558+24
	mov	r0, r4
	bl	mvc_ue_v
	add	r9, r8, #4
	str	r0, [r8, #4]
	ldr	r3, [r5, #4]
	cmp	r3, #15
	movcs	r3, #15
	cmp	r0, r3
	bhi	.L2515
	ldrb	r6, [r4, #10]
	cmp	r6, #0
	bne	.L2515
	cmp	r0, #0
	addne	r10, r8, #16
	beq	.L2520
.L2519:
	ldr	r1, .L2558+28
	mov	r0, r4
	bl	mvc_ue_v
	add	r6, r6, #1
	str	r0, [r10, #4]!
	ldr	r3, [r9]
	cmp	r6, r3
	bcc	.L2519
.L2520:
	ldr	r1, .L2558+32
	mov	r0, r4
	bl	mvc_ue_v
	str	r0, [r9, #8]
	ldr	r3, [r5, #4]
	cmp	r3, #15
	movcc	r2, r3
	movcs	r2, #15
	cmp	r0, r2
	bhi	.L2517
	ldrb	r6, [r4, #10]
	cmp	r6, #0
	bne	.L2517
	cmp	r0, #0
	addne	r8, r8, #24
	beq	.L2522
.L2523:
	ldr	r1, .L2558+36
	mov	r0, r4
	bl	mvc_ue_v
	add	r6, r6, #1
	str	r0, [r8, #4]!
	ldr	r3, [r9, #8]
	cmp	r6, r3
	bcc	.L2523
	ldr	r3, [r5, #4]
.L2522:
	add	r7, r7, #1
	mov	r8, r9
	cmp	r7, r3
	bls	.L2524
.L2525:
	ldr	r1, .L2558+40
	mov	r0, r4
	bl	mvc_ue_v
	add	r3, r0, #1
	str	r0, [r5, #80]
	cmp	r3, #16
	str	r3, [fp, #-60]
	bhi	.L2513
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2513
	ldr	r2, [fp, #-60]
	cmp	r2, #0
	beq	.L2530
	add	r2, r5, #8384
	add	r1, r5, #80
	add	r2, r2, #16
	str	r1, [fp, #-72]
	str	r2, [fp, #-68]
	add	r2, r5, #212
	str	r3, [fp, #-56]
	str	r2, [fp, #-64]
	str	r5, [fp, #-76]
.L2529:
	ldr	r2, .L2558+44
	mov	r1, #8
	mov	r0, r4
	bl	mvc_u_v
	ldr	r3, [fp, #-72]
	ldr	r1, .L2558+48
	str	r0, [r3, #4]!
	mov	r0, r4
	mov	r5, r3
	str	r3, [fp, #-72]
	bl	mvc_ue_v
	add	r3, r0, #1
	str	r0, [r5, #64]
	str	r3, [fp, #-52]
	mov	r2, r3
	cmp	r2, #64
	bhi	.L2527
	ldrb	r7, [r4, #10]
	cmp	r7, #0
	bne	.L2527
	cmp	r2, #0
	beq	.L2537
	ldr	r3, [fp, #-64]
	movw	r10, #8188
	ldr	r2, [fp, #-68]
	movt	r10, 4
	add	r10, r3, r10
	mov	r8, r3
	str	r2, [fp, #-48]
.L2536:
	ldr	r2, .L2558+52
	mov	r1, #3
	mov	r0, r4
	bl	mvc_u_v
	ldr	r1, .L2558+56
	str	r0, [r8], #4
	mov	r0, r4
	bl	mvc_ue_v
	add	r6, r0, #1
	str	r0, [r8, #4092]
	cmp	r6, #64
	bhi	.L2531
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2531
	cmp	r6, #0
	movne	r5, r3
	ldrne	r9, [fp, #-48]
	beq	.L2535
.L2532:
	ldr	r1, .L2558+60
	mov	r0, r4
	bl	mvc_ue_v
	add	r5, r5, #1
	cmp	r6, r5
	str	r0, [r9, #4]!
	bne	.L2532
.L2535:
	ldr	r1, .L2558+64
	mov	r0, r4
	bl	mvc_ue_v
	cmp	r0, #1024
	str	r0, [r10, #4]!
	bcs	.L2533
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	bne	.L2533
	ldr	r3, [fp, #-48]
	add	r7, r7, #1
	add	r3, r3, #256
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-52]
	cmp	r3, r7
	bne	.L2536
.L2537:
	ldr	r2, [fp, #-64]
	ldr	r3, [fp, #-56]
	add	r2, r2, #256
	str	r2, [fp, #-64]
	ldr	r2, [fp, #-60]
	add	r3, r3, #1
	str	r3, [fp, #-56]
	cmp	r2, r3
	ldr	r3, [fp, #-68]
	add	r3, r3, #16384
	str	r3, [fp, #-68]
	bne	.L2529
.L2530:
	mov	r0, #0
	b	.L2549
.L2502:
	mov	r2, r0
	ldr	r1, .L2558+68
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
.L2549:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2504:
	mov	r2, r0
	ldr	r1, .L2558+72
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2517:
	mov	r2, r0
	ldr	r1, .L2558+76
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2549
.L2515:
	mov	r2, r0
	ldr	r1, .L2558+80
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2549
.L2498:
	mov	r2, r0
	movw	r3, #65534
	ldr	r1, .L2558+84
	mov	r0, #1
	str	r3, [r5, #80]
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2549
.L2501:
	str	r3, [r5, #48]
	str	r3, [r5, #56]
	b	.L2525
.L2533:
	mov	r2, r0
	ldr	r1, .L2558+88
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2549
.L2531:
	ldr	r3, [fp, #-56]
	movw	ip, #65534
	ldr	r5, [fp, #-76]
	mov	r2, r6
	ldr	r1, .L2558+92
	mov	r0, #1
	add	r3, r7, r3, lsl #6
	add	r3, r3, #1072
	add	r3, r3, #4
	add	r3, r5, r3, lsl #2
	str	ip, [r3, #4]
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2549
.L2557:
	mov	r0, r5
	movw	r3, #11402
	ldr	r2, .L2558+96
	ldr	r1, .L2558+100
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2549
.L2513:
	movw	r3, #65534
	ldr	r2, [fp, #-60]
	ldr	r1, .L2558+104
	mov	r0, #1
	str	r3, [r5, #80]
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2549
.L2527:
	ldr	r3, [fp, #-56]
	mov	r0, #1
	ldr	r5, [fp, #-76]
	ldr	r2, [fp, #-52]
	add	r5, r5, r3, lsl #2
	ldr	r1, .L2558+108
	movw	r3, #65534
	str	r3, [r5, #148]
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2549
.L2559:
	.align	2
.L2558:
	.word	.LC273
	.word	.LC275
	.word	.LC276
	.word	.LC279
	.word	.LC277
	.word	.LC281
	.word	.LC283
	.word	.LC286
	.word	.LC284
	.word	.LC288
	.word	.LC282
	.word	.LC290
	.word	.LC291
	.word	.LC293
	.word	.LC294
	.word	.LC297
	.word	.LC295
	.word	.LC278
	.word	.LC280
	.word	.LC287
	.word	.LC285
	.word	.LC274
	.word	.LC298
	.word	.LC296
	.word	.LC13
	.word	.LC14
	.word	.LC289
	.word	.LC292
	.fnend
	.size	MVC_ProcessSUBSPSMvcExt, .-MVC_ProcessSUBSPSMvcExt
	.align	2
	.global	MVC_ProcessSUBSPSMvcVuiExt
	.type	MVC_ProcessSUBSPSMvcVuiExt, %function
MVC_ProcessSUBSPSMvcVuiExt:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #76
	sub	sp, sp, #76
	push	{lr}
	bl	__gnu_mcount_nc
	mov	r5, r1
	ldr	r1, .L2593
	mov	r4, r0
	bl	mvc_ue_v
	add	r3, r5, #278528
	cmp	r0, #1024
	str	r0, [r3, #560]
	bcs	.L2590
	adds	r6, r0, #1
	mov	r1, #0
	adc	r7, r1, #0
	strd	r6, [fp, #-116]
	orrs	r2, r6, r7
	beq	.L2578
	add	r1, r5, #294912
	add	r9, r5, #315392
	add	r9, r9, #856
	movw	r2, #16687
	mov	ip, r1
	movw	r6, #34136
	movw	r1, #16751
	movw	r0, #33844
	mov	r8, r5
	movt	r2, 4
	add	ip, ip, #820
	add	r2, r5, r2
	movt	r6, 4
	str	r2, [fp, #-104]
	movt	r1, 4
	add	r6, r5, r6
	add	r2, r5, r1
	movt	r0, 4
	str	r2, [fp, #-96]
	add	r2, r3, #111
	str	ip, [fp, #-76]
	str	r2, [fp, #-88]
	add	r2, r5, r0
	str	r6, [fp, #-48]
	str	r2, [fp, #-80]
	add	r2, r3, #560
	str	r2, [fp, #-92]
	add	r2, r3, #176
	str	r2, [fp, #-72]
	add	r2, r3, #432
	str	r2, [fp, #-52]
	add	r2, r3, #496
	str	r2, [fp, #-56]
	add	r2, r3, #240
	add	r3, r3, #816
	str	r2, [fp, #-84]
	str	r3, [fp, #-60]
	mov	r2, #1
	mov	r3, #0
	strd	r2, [fp, #-68]
	mov	r3, #0
	str	r3, [fp, #-100]
.L2577:
	ldr	r2, .L2593+4
	mov	r1, #3
	mov	r0, r4
	bl	mvc_u_v
	ldr	r3, [fp, #-88]
	ldr	r1, .L2593+8
	strb	r0, [r3, #1]!
	mov	r0, r4
	str	r3, [fp, #-88]
	bl	mvc_ue_v
	ldr	r3, [fp, #-92]
	adds	r5, r0, #1
	str	r0, [r3, #4]!
	str	r3, [fp, #-92]
	beq	.L2567
	ldr	r10, [fp, #-60]
	mov	r7, #0
	ldr	r6, [fp, #-48]
.L2564:
	ldr	r1, .L2593+12
	mov	r0, r4
	bl	mvc_ue_v
	add	r7, r7, #1
	cmp	r5, r7
	str	r0, [r10, #4]!
	bne	.L2564
	str	r6, [fp, #-48]
.L2567:
	ldr	r1, .L2593+16
	mov	r0, r4
	bl	mvc_u_1
	ldr	r3, [fp, #-96]
	uxtb	r0, r0
	strb	r0, [r3, #1]!
	cmp	r0, #0
	str	r3, [fp, #-96]
	bne	.L2591
.L2566:
	ldr	r1, .L2593+20
	mov	r0, r4
	bl	mvc_u_1
	ldr	r3, [fp, #-52]
	uxtb	r0, r0
	strb	r0, [r3]
	cmp	r0, #0
	beq	.L2568
	ldr	r1, .L2593+24
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r5, [fp, #-48]
	ldr	r2, .L2593+28
	mov	r1, #4
	str	r0, [r5]
	mov	r0, r4
	bl	mvc_u_v
	movw	r3, #34132
	movt	r3, 4
	add	r3, r8, r3
	ldr	r2, .L2593+32
	mov	r1, #4
	strb	r0, [r3]
	mov	r0, r4
	bl	mvc_u_v
	movw	r3, #34133
	movt	r3, 4
	add	r3, r8, r3
	strb	r0, [r3]
	ldr	r3, [r5]
	cmp	r3, #31
	bhi	.L2570
	ldrb	r5, [r4, #10]
	cmp	r5, #0
	bne	.L2570
	ldr	r6, [fp, #-48]
	movw	r10, #34099
	movt	r10, 4
	add	r10, r8, r10
	mov	r7, r6
.L2571:
	ldr	r1, .L2593+36
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r1, .L2593+40
	add	r5, r5, #1
	str	r0, [r7, #4]!
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r1, .L2593+44
	str	r0, [r7, #128]
	mov	r0, r4
	bl	mvc_u_1
	strb	r0, [r10, #1]!
	ldr	r3, [r6]
	cmp	r3, r5
	bcs	.L2571
	ldr	r2, .L2593+48
	mov	r1, #5
	mov	r0, r4
	str	r6, [fp, #-48]
	bl	mvc_u_v
	movw	r3, #34396
	movt	r3, 4
	add	r3, r8, r3
	ldr	r2, .L2593+52
	mov	r1, #5
	str	r0, [r3]
	mov	r0, r4
	bl	mvc_u_v
	add	r3, r8, #294912
	ldr	r2, .L2593+56
	mov	r1, #5
	str	r0, [r3, #1632]
	mov	r0, r4
	bl	mvc_u_v
	movw	r3, #34404
	movt	r3, 4
	add	r3, r8, r3
	ldr	r2, .L2593+60
	mov	r1, #5
	str	r0, [r3]
	mov	r0, r4
	bl	mvc_u_v
	movw	r3, #34408
	movt	r3, 4
	add	r3, r8, r3
	str	r0, [r3]
.L2568:
	ldr	r1, .L2593+64
	mov	r0, r4
	bl	mvc_u_1
	ldr	r3, [fp, #-56]
	uxtb	r0, r0
	strb	r0, [r3]
	cmp	r0, #0
	bne	.L2592
	ldr	r3, [fp, #-52]
	ldrb	r3, [r3]
	cmp	r3, #0
	bne	.L2576
.L2575:
	ldr	r1, .L2593+68
	mov	r0, r4
	bl	mvc_u_1
	ldrd	r2, [fp, #-68]
	ldrd	r6, [fp, #-116]
	add	r8, r8, #312
	add	r9, r9, #312
	cmp	r7, r3
	ldr	r3, [fp, #-100]
	cmpeq	r6, r2
	add	r1, r3, #1
	ldr	r3, [fp, #-72]
	str	r1, [fp, #-100]
	add	r3, r3, #1
	str	r3, [fp, #-72]
	movhi	r3, #1
	movls	r3, #0
	cmp	r1, #63
	movhi	r1, #0
	andls	r1, r3, #1
	ldrd	r2, [fp, #-68]
	adds	r6, r2, #1
	adc	r7, r3, #0
	ldr	r3, [fp, #-52]
	cmp	r1, #0
	strd	r6, [fp, #-68]
	add	r3, r3, #1
	str	r3, [fp, #-52]
	ldr	r3, [fp, #-56]
	add	r3, r3, #1
	str	r3, [fp, #-56]
	ldr	r3, [fp, #-48]
	add	r3, r3, #312
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-76]
	add	r3, r3, #4
	str	r3, [fp, #-76]
	ldr	r3, [fp, #-80]
	add	r3, r3, #4
	str	r3, [fp, #-80]
	ldr	r3, [fp, #-84]
	add	r3, r3, #1
	str	r3, [fp, #-84]
	ldr	r3, [fp, #-60]
	add	r3, r3, #256
	str	r3, [fp, #-60]
	ldr	r3, [fp, #-104]
	strb	r0, [r3, #1]!
	str	r3, [fp, #-104]
	bne	.L2577
.L2578:
	mov	r0, #0
.L2588:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2592:
	ldr	r1, .L2593+24
	mov	r0, r4
	bl	mvc_ue_v
	add	r3, r8, #315392
	ldr	r2, .L2593+28
	mov	r1, #4
	mov	r5, r3
	str	r3, [fp, #-108]
	str	r0, [r9]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2593+32
	mov	r1, #4
	strb	r0, [r5, #852]
	mov	r0, r4
	bl	mvc_u_v
	movw	r3, #54101
	movt	r3, 4
	add	r3, r8, r3
	strb	r0, [r3]
	ldr	r3, [r9]
	cmp	r3, #31
	bhi	.L2570
	ldrb	r5, [r4, #10]
	cmp	r5, #0
	bne	.L2570
	movw	r10, #54067
	ldr	r6, [fp, #-48]
	movt	r10, 4
	add	r10, r8, r10
	mov	r7, r9
.L2573:
	ldr	r1, .L2593+36
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r1, .L2593+40
	add	r5, r5, #1
	str	r0, [r7, #4]!
	mov	r0, r4
	bl	mvc_ue_v
	ldr	r1, .L2593+44
	str	r0, [r7, #128]
	mov	r0, r4
	bl	mvc_u_1
	strb	r0, [r10, #1]!
	ldr	r3, [r9]
	cmp	r3, r5
	bcs	.L2573
	ldr	r2, .L2593+48
	mov	r1, #5
	mov	r0, r4
	str	r6, [fp, #-48]
	bl	mvc_u_v
	movw	r3, #54364
	movt	r3, 4
	add	r3, r8, r3
	ldr	r2, .L2593+52
	mov	r1, #5
	str	r0, [r3]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r3, [fp, #-108]
	ldr	r2, .L2593+56
	mov	r1, #5
	str	r0, [r3, #1120]
	mov	r0, r4
	bl	mvc_u_v
	movw	r3, #54372
	movt	r3, 4
	add	r3, r8, r3
	ldr	r2, .L2593+60
	mov	r1, #5
	str	r0, [r3]
	mov	r0, r4
	bl	mvc_u_v
	movw	r3, #54376
	movt	r3, 4
	add	r3, r8, r3
	str	r0, [r3]
	ldr	r3, [fp, #-52]
	ldrb	r3, [r3]
	cmp	r3, #0
	bne	.L2576
	ldr	r3, [fp, #-56]
	ldrb	r3, [r3]
	cmp	r3, #0
	beq	.L2575
.L2576:
	ldr	r1, .L2593+72
	mov	r0, r4
	bl	mvc_u_1
	ldr	r3, [fp, #-72]
	strb	r0, [r3]
	b	.L2575
.L2591:
	ldr	r2, .L2593+76
	mov	r1, #32
	mov	r0, r4
	bl	mvc_u_v
	ldr	r3, [fp, #-76]
	ldr	r2, .L2593+80
	mov	r1, #32
	str	r0, [r3]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r3, [fp, #-80]
	ldr	r1, .L2593+84
	str	r0, [r3]
	mov	r0, r4
	bl	mvc_u_1
	ldr	r3, [fp, #-84]
	strb	r0, [r3]
	b	.L2566
.L2570:
	ldr	r1, .L2593+88
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2590:
	mov	r2, r0
	ldr	r1, .L2593+92
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2588
.L2594:
	.align	2
.L2593:
	.word	.LC299
	.word	.LC301
	.word	.LC302
	.word	.LC304
	.word	.LC303
	.word	.LC308
	.word	.LC309
	.word	.LC310
	.word	.LC311
	.word	.LC312
	.word	.LC313
	.word	.LC314
	.word	.LC315
	.word	.LC316
	.word	.LC317
	.word	.LC318
	.word	.LC319
	.word	.LC321
	.word	.LC320
	.word	.LC305
	.word	.LC306
	.word	.LC307
	.word	.LC196
	.word	.LC300
	.fnend
	.size	MVC_ProcessSUBSPSMvcVuiExt, .-MVC_ProcessSUBSPSMvcVuiExt
	.align	2
	.global	MVC_DecSubSPS
	.type	MVC_DecSubSPS, %function
MVC_DecSubSPS:
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
	ldr	r2, .L2623
	mov	r1, #8
	mov	r4, r0
	bl	mvc_u_v
	ldr	r1, .L2623+4
	mov	r7, r0
	mov	r0, r4
	bl	mvc_u_1
	ldr	r1, .L2623+8
	mov	r10, r0
	mov	r0, r4
	bl	mvc_u_1
	ldr	r1, .L2623+12
	str	r0, [fp, #-48]
	mov	r0, r4
	bl	mvc_u_1
	ldr	r1, .L2623+16
	str	r0, [fp, #-52]
	mov	r0, r4
	bl	mvc_u_1
	ldr	r1, .L2623+20
	str	r0, [fp, #-56]
	mov	r0, r4
	bl	mvc_u_1
	ldr	r1, .L2623+24
	str	r0, [fp, #-60]
	mov	r0, r4
	bl	mvc_u_1
	ldr	r2, .L2623+28
	mov	r1, #2
	str	r0, [fp, #-64]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2623+32
	mov	r1, #8
	mov	r0, r4
	bl	mvc_u_v
	ldr	r1, .L2623+36
	mov	r8, r0
	mov	r0, r4
	bl	mvc_ue_v
	ldrb	r3, [r4, #10]
	cmp	r3, #0
	mov	r5, r0
	bne	.L2608
	cmp	r0, #31
	bhi	.L2618
	sub	r3, r7, #66
	cmp	r3, #78
	ldrls	pc, [pc, r3, asl #2]
	b	.L2598
.L2600:
	.word	.L2599
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2601
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2602
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2601
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2603
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2601
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2603
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2601
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2598
	.word	.L2603
.L2599:
	ldr	r1, .L2623+40
	mov	r0, #1
	bl	dprint_vfmw
.L2601:
	cmp	r8, #41
	bhi	.L2619
.L2604:
	movw	r3, #8500
	movw	r2, #26248
	movt	r3, 5
	movt	r2, 4
	mul	r3, r3, r5
	mov	r0, r4
	add	r9, r4, r3
	add	r6, r9, #286720
	add	r2, r9, r2
	str	r3, [fp, #-68]
	add	r1, r6, #932
	ldrb	r3, [fp, #-48]
	str	r8, [r6, #1672]
	str	r7, [r6, #1668]
	strb	r3, [r6, #933]
	ldrb	r3, [fp, #-52]
	strb	r10, [r6, #932]
	strb	r3, [r6, #934]
	ldrb	r3, [fp, #-56]
	strb	r3, [r6, #935]
	ldrb	r3, [fp, #-60]
	strb	r3, [r6, #936]
	ldrb	r3, [fp, #-64]
	strb	r3, [r6, #937]
	str	r5, [r2, #4]
	bl	MVC_ProcessSPS
	ldr	r3, [fp, #-68]
	subs	r8, r0, #0
	bne	.L2620
	cmp	r7, #118
	cmpne	r7, #128
	mov	r10, #1
	strb	r10, [r6, #957]
	beq	.L2621
.L2606:
	movw	r3, #8500
	mov	r2, #1
	movt	r3, 5
	mla	r4, r3, r5, r4
	add	r4, r4, #12992
	strb	r2, [r4, #12]
.L2596:
	mov	r0, r8
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2619:
	mov	r2, r8
	ldr	r1, .L2623+44
	mov	r0, #1
	mov	r8, #41
	bl	dprint_vfmw
	b	.L2604
.L2621:
	ldr	r1, .L2623+48
	mov	r0, r4
	str	r3, [fp, #-48]
	bl	mvc_u_1
	ldr	r3, [fp, #-48]
	add	r9, r9, #12992
	add	r9, r9, #8
	add	r3, r4, r3
	add	r7, r3, #12992
	add	r7, r7, #12
	mov	r1, r7
	strb	r0, [r9, #5]
	mov	r0, r4
	bl	MVC_ProcessSUBSPSMvcExt
	cmp	r0, #0
	bne	.L2622
	ldr	r1, .L2623+52
	mov	r0, r4
	bl	mvc_u_1
	cmp	r0, #0
	str	r0, [r6, #928]
	beq	.L2606
	mov	r1, r7
	mov	r0, r4
	bl	MVC_ProcessSUBSPSMvcVuiExt
	cmp	r0, #0
	beq	.L2606
	mov	r0, r10
	ldr	r1, .L2623+56
	bl	dprint_vfmw
	strb	r8, [r9, #4]
	mvn	r8, #0
	b	.L2596
.L2603:
	ldr	r1, .L2623+60
	mov	r0, #1
	bl	dprint_vfmw
	b	.L2601
.L2602:
	ldr	r1, .L2623+64
	mov	r0, #1
	bl	dprint_vfmw
	b	.L2601
.L2598:
	mov	r2, r7
	ldr	r1, .L2623+68
	mov	r0, #1
	mvn	r8, #0
	bl	dprint_vfmw
	mov	r0, r8
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2608:
	mvn	r8, #0
	b	.L2596
.L2618:
	ldr	r1, .L2623+72
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L2596
.L2620:
	ldr	r1, .L2623+76
	mov	r0, #1
	bl	dprint_vfmw
	add	ip, r9, #12992
	mov	r3, #0
	mvn	r8, #0
	strb	r3, [ip, #12]
	strb	r3, [r6, #957]
	b	.L2596
.L2622:
	mov	r0, r10
	ldr	r1, .L2623+80
	bl	dprint_vfmw
	strb	r8, [r9, #4]
	mvn	r8, #0
	b	.L2596
.L2624:
	.align	2
.L2623:
	.word	.LC322
	.word	.LC323
	.word	.LC324
	.word	.LC325
	.word	.LC326
	.word	.LC327
	.word	.LC328
	.word	.LC329
	.word	.LC330
	.word	.LC331
	.word	.LC267
	.word	.LC333
	.word	.LC335
	.word	.LC337
	.word	.LC338
	.word	.LC269
	.word	.LC268
	.word	.LC332
	.word	.LC170
	.word	.LC334
	.word	.LC336
	.fnend
	.size	MVC_DecSubSPS, .-MVC_DecSubSPS
	.align	2
	.global	MVC_PassBytes
	.type	MVC_PassBytes, %function
MVC_PassBytes:
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
	ldr	ip, [r0, #232]
	cmp	ip, #0
	cmpne	r1, #0
	beq	.L2634
	ldrb	r3, [ip]
	mov	r2, r3, asl #2
	mov	r5, r3, asl #5
	rsb	r4, r2, r5
	add	r4, ip, r4
	add	r6, r4, #8
	ldr	lr, [r4, #8]
	cmp	lr, #0
	beq	.L2634
	ldr	lr, [ip, #68]
	cmp	r3, #1
	cmpls	lr, #2
	bhi	.L2634
	cmp	lr, r3
	bls	.L2634
	ldr	lr, [r4, #12]
	mov	r6, r2
	ldr	r4, [r4, #24]
	mov	lr, lr, asl #3
	add	r1, r4, r1, lsl #3
	cmp	r1, lr
	bhi	.L2629
	b	.L2627
.L2630:
	ldr	r4, [r2, #24]
	ldr	r2, [r2, #12]
	rsb	lr, lr, r4
	add	r1, r1, lr
	mov	lr, r2, asl #3
	cmp	r1, lr
	bls	.L2627
.L2629:
	rsb	r2, r6, r5
	add	r3, r3, #1
	add	ip, ip, r2
	mov	r6, r3, asl #2
	mov	r5, r3, asl #5
	str	lr, [ip, #24]
	rsb	r2, r6, r5
	ldr	ip, [r0, #232]
	ldrb	r4, [ip]
	add	r4, r4, #1
	strb	r4, [ip]
	ldr	ip, [r0, #232]
	add	r2, ip, r2
	ldr	r4, [ip, #68]
	cmp	r4, r3
	bhi	.L2630
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2627:
	rsb	r2, r6, r5
	mov	r0, #1
	add	ip, ip, r2
	str	r1, [ip, #24]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2634:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	MVC_PassBytes, .-MVC_PassBytes
	.align	2
	.global	MVC_GetBytes
	.type	MVC_GetBytes, %function
MVC_GetBytes:
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
	beq	.L2650
	ldr	r3, [r0, #232]
	cmp	r3, #0
	cmpne	r2, #0
	beq	.L2650
	ldrb	r7, [r3]
	mov	ip, r7, asl #5
	sub	ip, ip, r7, asl #2
	add	ip, r3, ip
	ldr	ip, [ip, #8]
	cmp	ip, #0
	beq	.L2650
	ldr	ip, [r3, #68]
	cmp	r7, #1
	cmpls	ip, #2
	movhi	lr, #1
	movls	lr, #0
	bhi	.L2650
	cmp	ip, r7
	bls	.L2650
.L2645:
	mov	r5, r7, asl #5
	sub	r5, r5, r7, asl #2
	add	r3, r3, r5
	ldr	r4, [r3, #24]
	ldr	r8, [r3, #8]
	add	r4, r4, #7
	ldr	r6, [r3, #12]
	add	ip, r8, r4, lsr #3
	add	r6, r8, r6
	cmp	ip, r6
	bcs	.L2640
	ldrb	r3, [r8, r4, lsr #3]
	add	lr, lr, #1
	cmp	r2, lr
	add	r4, r1, #1
	add	ip, ip, #1
	strb	r3, [r1]
	b	.L2652
.L2643:
	cmp	ip, r6
	mov	r1, r4
	beq	.L2640
	ldrb	r3, [ip], #1
	add	lr, lr, #1
	cmp	r2, lr
	strb	r3, [r4], #1
.L2652:
	ldr	r3, [r0, #232]
	add	r3, r3, r5
	ldr	r1, [r3, #24]
	add	r1, r1, #8
	str	r1, [r3, #24]
	bhi	.L2643
	mov	r0, r2
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2640:
	ldr	ip, [r0, #232]
	add	r7, r7, #1
	ldrb	r3, [ip]
	add	r3, r3, #1
	strb	r3, [ip]
	ldr	r3, [r0, #232]
	ldr	ip, [r3, #68]
	cmp	ip, r7
	bhi	.L2645
	mov	r0, lr
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2650:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	MVC_GetBytes, .-MVC_GetBytes
	.align	2
	.global	MVC_DecFramePackingSEI
	.type	MVC_DecFramePackingSEI, %function
MVC_DecFramePackingSEI:
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
	ldr	r1, .L2660
	mov	r4, r0
	bl	mvc_ue_v
	add	r6, r4, #11075584
	ldr	r2, .L2660+4
	add	r5, r6, #45056
	mov	r1, #1
	str	r0, [r5, #2512]
	mov	r0, r4
	bl	mvc_u_v
	uxtb	r0, r0
	strb	r0, [r5, #2489]
	cmp	r0, #0
	beq	.L2659
.L2654:
	mov	r0, r4
	ldr	r2, .L2660+8
	mov	r1, #1
	add	r6, r6, #45056
	bl	mvc_u_v
	mov	r3, #1
	strb	r3, [r6, #2488]
	strb	r0, [r6, #2490]
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2659:
	ldr	r2, .L2660+12
	mov	r1, #7
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2660+16
	mov	r1, #1
	str	r0, [r5, #2504]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2660+20
	mov	r1, #6
	strb	r0, [r5, #2491]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2660+24
	mov	r1, #1
	str	r0, [r5, #2508]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2660+28
	mov	r1, #1
	strb	r0, [r5, #2492]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2660+32
	mov	r1, #1
	strb	r0, [r5, #2493]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2660+36
	mov	r1, #1
	strb	r0, [r5, #2494]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2660+40
	mov	r1, #1
	strb	r0, [r5, #2495]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2660+44
	mov	r1, #1
	strb	r0, [r5, #2496]
	mov	r0, r4
	bl	mvc_u_v
	ldrb	r3, [r5, #2491]
	cmp	r3, #0
	strb	r0, [r5, #2497]
	bne	.L2655
	ldr	r3, [r5, #2504]
	cmp	r3, #5
	beq	.L2655
	ldr	r2, .L2660+48
	mov	r1, #1
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2660+52
	mov	r1, #1
	strb	r0, [r5, #2498]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2660+56
	mov	r1, #1
	strb	r0, [r5, #2499]
	mov	r0, r4
	bl	mvc_u_v
	ldr	r2, .L2660+60
	mov	r1, #1
	strb	r0, [r5, #2500]
	mov	r0, r4
	bl	mvc_u_v
	strb	r0, [r5, #2501]
.L2655:
	ldr	r2, .L2660+64
	mov	r1, #8
	mov	r0, r4
	bl	mvc_u_v
	ldr	r1, .L2660+68
	str	r0, [r5, #2516]
	mov	r0, r4
	bl	mvc_ue_v
	str	r0, [r5, #2520]
	b	.L2654
.L2661:
	.align	2
.L2660:
	.word	.LC339
	.word	.LC340
	.word	.LC356
	.word	.LC341
	.word	.LC342
	.word	.LC343
	.word	.LC344
	.word	.LC345
	.word	.LC346
	.word	.LC347
	.word	.LC348
	.word	.LC349
	.word	.LC350
	.word	.LC351
	.word	.LC352
	.word	.LC353
	.word	.LC354
	.word	.LC355
	.fnend
	.size	MVC_DecFramePackingSEI, .-MVC_DecFramePackingSEI
	.align	2
	.global	MVC_DecPicTimingSEI
	.type	MVC_DecPicTimingSEI, %function
MVC_DecPicTimingSEI:
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
	add	r6, r0, #11075584
	add	r2, r6, #32768
	ldr	r3, [r0, #248]
	movw	r4, #3992
	mov	r5, r0
	ldr	r2, [r2, #2440]
	mla	r4, r4, r2, r3
	ldrb	r2, [r4, #25]
	cmp	r2, #0
	bne	.L2663
	ldr	ip, [r0, #36]
	cmp	ip, #0
	ble	.L2664
	ldrb	r2, [r3, #25]
	cmp	r2, #0
	addeq	r3, r3, #3984
	addeq	r3, r3, #8
	beq	.L2667
	b	.L2686
.L2668:
	ldrb	r1, [r3, #-3967]
	cmp	r1, #0
	bne	.L2665
.L2667:
	add	r2, r2, #1
	mov	r4, r3
	cmp	r2, ip
	add	r3, r3, #3984
	add	r3, r3, #8
	bne	.L2668
.L2664:
	ldr	r1, .L2688
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r3, #0
.L2669:
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2686:
	mov	r4, r3
.L2665:
	cmp	r4, #0
	beq	.L2664
.L2663:
	ldrb	r3, [r4, #24]
	cmp	r3, #0
	beq	.L2670
	ldrb	r3, [r4, #35]
	cmp	r3, #0
	beq	.L2687
	ldr	r1, [r4, #388]
	ldr	r8, [r4, #392]
	add	r1, r1, #1
	add	r8, r8, #1
.L2673:
	ldr	r2, .L2688+4
	mov	r0, r5
	bl	mvc_u_v
	add	r7, r6, #45056
	mov	r1, r8
	ldr	r2, .L2688+8
	str	r0, [r7, #2528]
	mov	r0, r5
	bl	mvc_u_v
	str	r0, [r7, #2532]
.L2670:
	ldrb	r0, [r4, #39]
	cmp	r0, #0
	moveq	r3, r0
	beq	.L2669
	mov	r0, r5
	ldr	r2, .L2688+12
	mov	r1, #4
	add	r6, r6, #45056
	bl	mvc_u_v
	mov	r3, #0
	strb	r0, [r6, #2524]
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2687:
	ldrb	r3, [r4, #38]
	cmp	r3, #0
	beq	.L2670
	ldr	r1, [r4, #700]
	ldr	r8, [r4, #704]
	add	r1, r1, #1
	add	r8, r8, #1
	b	.L2673
.L2689:
	.align	2
.L2688:
	.word	.LC357
	.word	.LC358
	.word	.LC359
	.word	.LC360
	.fnend
	.size	MVC_DecPicTimingSEI, .-MVC_DecPicTimingSEI
	.align	2
	.global	MVC_DecSEI
	.type	MVC_DecSEI, %function
MVC_DecSEI:
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
	ldr	r2, [r0, #232]
	sub	r7, fp, #44
	mov	r3, #0
	mov	r1, #32
	mov	r4, r0
	add	r6, r0, #548
	mov	r8, r3
	strb	r3, [r7, #-1]!
	str	r1, [r2, #24]
	b	.L2693
.L2875:
	bl	BsSkip
	cmp	r5, #0
	ble	.L2692
	ldrb	r3, [fp, #-45]
	cmp	r3, #255
	bne	.L2874
.L2693:
	mov	r2, #1
	mov	r1, r7
	mov	r0, r4
	bl	MVC_GetBytes
	ldr	r3, [r4, #572]
	ldr	ip, [r4, #564]
	mov	r1, #8
	add	r3, r3, r1
	ldrb	r2, [fp, #-45]
	cmp	r3, ip, asl #3
	add	r8, r8, r2
	mov	r5, r0
	mov	r0, r6
	ble	.L2875
.L2692:
	ldr	r1, .L2906
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2695
.L2874:
	mov	r3, #0
	str	r3, [fp, #-56]
.L2829:
	mov	r5, #0
	b	.L2699
.L2877:
	bl	BsSkip
	cmp	r9, #0
	ble	.L2697
	ldrb	r3, [fp, #-45]
	cmp	r3, #255
	bne	.L2876
.L2699:
	mov	r2, #1
	mov	r1, r7
	mov	r0, r4
	bl	MVC_GetBytes
	ldr	r3, [r4, #572]
	ldr	ip, [r4, #564]
	mov	r1, #8
	add	r3, r3, r1
	ldrb	r2, [fp, #-45]
	cmp	r3, ip, asl #3
	add	r5, r5, r2
	mov	r9, r0
	mov	r0, r6
	ble	.L2877
.L2697:
	ldr	r1, .L2906+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2876:
	cmp	r5, #409600
	bgt	.L2697
	ldr	r3, [r4, #232]
	ldr	r2, [r3, #68]
	cmp	r2, #2
	ldreq	r2, [r3, #52]
	ldreq	r3, [r3, #24]
	ldrne	r2, [r3, #24]
	addeq	r2, r2, r3
	moveq	r2, r2, lsr #3
	cmp	r8, #45
	ldrls	pc, [pc, r8, asl #2]
	b	.L2702
.L2704:
	.word	.L2703
	.word	.L2705
	.word	.L2706
	.word	.L2707
	.word	.L2708
	.word	.L2709
	.word	.L2710
	.word	.L2711
	.word	.L2712
	.word	.L2713
	.word	.L2714
	.word	.L2715
	.word	.L2716
	.word	.L2717
	.word	.L2718
	.word	.L2719
	.word	.L2720
	.word	.L2721
	.word	.L2722
	.word	.L2723
	.word	.L2724
	.word	.L2725
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2702
	.word	.L2726
.L2726:
	mov	r1, r5
	mov	r0, r4
	ldr	r8, [r4, #572]
	bl	MVC_DecFramePackingSEI
	ldr	r2, [r4, #572]
	mov	r9, r5, asl #3
	rsb	r3, r8, r2
	cmp	r3, r9
	bge	.L2815
	rsb	r9, r3, r9
	ldr	r3, [r4, #564]
	cmp	r9, #0
	add	r8, r9, #7
	movge	r8, r9
	mov	r8, r8, asr #3
	cmp	r8, #0
	movle	r3, r3, asl #3
	ble	.L2817
	add	r1, r2, #8
	mov	r3, r3, asl #3
	cmp	r1, r3
	bgt	.L2817
	mov	r10, #0
	b	.L2818
.L2819:
	add	r1, r2, #8
	cmp	r1, r3
	bgt	.L2817
.L2818:
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	add	r10, r10, #1
	ldr	r3, [r4, #564]
	cmp	r10, r8
	ldr	r2, [r4, #572]
	mov	r3, r3, asl #3
	bne	.L2819
.L2817:
	mov	r1, r9, asr #31
	mov	r0, r1, lsr #29
	add	r1, r9, r0
	and	r1, r1, #7
	rsb	r1, r0, r1
	add	r2, r1, r2
	cmp	r2, r3
	ble	.L2878
.L2815:
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2879
.L2728:
	ldr	r3, [r4, #60]
	cmp	r3, #3
	bhi	.L2880
.L2824:
	mov	r8, #0
	b	.L2828
.L2826:
	bl	BsSkip
	cmp	r5, #0
	ble	.L2827
	ldrb	r3, [fp, #-45]
	cmp	r3, #255
	bne	.L2881
.L2828:
	mov	r2, #1
	mov	r1, r7
	mov	r0, r4
	bl	MVC_GetBytes
	ldr	r3, [r4, #572]
	ldr	ip, [r4, #564]
	mov	r1, #8
	add	r3, r3, r1
	ldrb	r2, [fp, #-45]
	cmp	r3, ip, asl #3
	add	r8, r8, r2
	mov	r5, r0
	mov	r0, r6
	ble	.L2826
.L2827:
	mov	r0, #0
.L2695:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2725:
	mov	r3, r5
	ldr	r1, .L2906+8
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2882
.L2811:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2812
.L2813:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2812:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2813
	ldr	r3, [r4, #60]
	cmp	r3, #3
	bls	.L2824
.L2880:
	ldr	r1, .L2906+12
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2724:
	mov	r3, r5
	ldr	r1, .L2906+16
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2883
.L2808:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2809
.L2810:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2809:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2810
	b	.L2728
.L2723:
	mov	r3, r5
	ldr	r1, .L2906+20
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2884
.L2805:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2806
.L2807:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2806:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2807
	b	.L2728
.L2721:
	mov	r3, r5
	ldr	r1, .L2906+24
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2885
.L2799:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2800
.L2801:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2800:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2801
	b	.L2728
.L2722:
	mov	r3, r5
	ldr	r1, .L2906+28
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2886
.L2802:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2803
.L2804:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2803:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2804
	b	.L2728
.L2720:
	mov	r3, r5
	ldr	r1, .L2906+32
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2887
.L2796:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2797
.L2798:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2797:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2798
	b	.L2728
.L2719:
	mov	r3, r5
	ldr	r1, .L2906+36
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2888
.L2793:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2794
.L2795:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2794:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2795
	b	.L2728
.L2711:
	mov	r3, r5
	ldr	r1, .L2906+40
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2889
.L2769:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2770
.L2771:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2770:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2771
	b	.L2728
.L2715:
	mov	r3, r5
	ldr	r1, .L2906+44
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2890
.L2781:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2782
.L2783:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2782:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2783
	b	.L2728
.L2706:
	mov	r3, r5
	ldr	r1, .L2906+48
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2891
.L2738:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2739
.L2740:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2739:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2740
	b	.L2728
.L2717:
	mov	r3, r5
	ldr	r1, .L2906+52
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2892
.L2787:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2788
.L2789:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2788:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2789
	b	.L2728
.L2709:
	ldr	r3, [fp, #-56]
	cmp	r3, #0
	bne	.L2708
	mov	r3, r5
	ldr	r1, .L2906+56
	mov	r0, #20
	bl	dprint_vfmw
.L2745:
	ldr	r0, [r4, #120]
	ldr	r8, [r4, #60]
	bl	GetUsd
	add	r8, r8, #132
	str	r0, [r4, r8, asl #2]
	ldr	r3, [r4, #60]
	add	r3, r3, #132
	ldr	r1, [r4, r3, asl #2]
	cmp	r1, #0
	beq	.L2832
	ldr	r2, [r4, #232]
	cmp	r5, #1024
	movlt	r10, r5
	movge	r10, #1024
	ldrb	r0, [r2]
	ldr	ip, [r2, #68]
	cmp	r0, ip
	bcs	.L2833
	sxth	r3, r0
	mov	r8, #0
	mov	lr, r3, asl #5
	sub	r3, lr, r3, asl #2
	add	r2, r2, r3
.L2747:
	ldr	r3, [r2, #24]
	add	r0, r0, #1
	ldr	lr, [r2, #12]
	cmp	r0, ip
	add	r3, r3, #7
	add	r2, r2, #28
	sub	r3, lr, r3, lsr #3
	add	r8, r8, r3
	bne	.L2747
	mov	r2, r8
.L2746:
	ldrsb	r3, [fp, #-56]
	cmp	r10, r2
	movle	r8, r10
	cmp	r3, #1
	movne	r3, #0
	movne	r9, r3
	beq	.L2893
.L2749:
	rsb	r2, r3, r8
	mov	r0, r4
	bl	MVC_GetBytes
	subs	r8, r0, #0
	ble	.L2894
	rsb	r3, r9, r10
	cmp	r8, r3
	ldr	r3, [r4, #60]
	blt	.L2895
	add	r3, r3, #132
	cmp	r10, r5
	rsb	r9, r9, r5
	ldr	r3, [r4, r3, asl #2]
	str	r9, [r3, #1052]
	bcc	.L2896
.L2760:
	cmp	r9, #0
	ble	.L2755
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2755
	mov	r5, #0
	b	.L2762
.L2763:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2755
.L2762:
	add	r5, r5, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r9
	bne	.L2763
.L2755:
	ldr	r3, [r4, #60]
	mov	r2, #8
	ldr	r1, [r4, #224]
	add	r3, r3, #132
	ldr	ip, .L2906+60
	ldr	r3, [r4, r3, asl #2]
	ldrd	r0, [r1, #56]
	add	r3, r3, #1056
	ldr	ip, [ip]
	strd	r0, [r3]
	cmp	ip, #0
	ldr	r3, [r4, #60]
	add	r3, r3, #132
	ldr	r3, [r4, r3, asl #2]
	str	r2, [r3, #1040]
	ldr	r3, [r4, #60]
	ldr	r2, [r4, #84]
	add	r3, r3, #132
	ldr	r3, [r4, r3, asl #2]
	str	r2, [r3, #1044]
	beq	.L2728
	ldr	r2, [r4, #60]
	movw	r3, #1064
	mov	r1, #6
	ldr	r0, [r4, #120]
	add	r2, r2, #132
	ldr	r2, [r4, r2, asl #2]
	blx	ip
	b	.L2728
.L2713:
	mov	r3, r5
	ldr	r1, .L2906+64
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2897
.L2775:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2776
.L2777:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2776:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2777
	b	.L2728
.L2712:
	mov	r3, r5
	ldr	r1, .L2906+68
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2898
.L2772:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2773
.L2774:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2773:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2774
	b	.L2728
.L2714:
	mov	r3, r5
	ldr	r1, .L2906+72
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2899
.L2778:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2779
.L2780:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2779:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2780
	b	.L2728
.L2703:
	mov	r3, r5
	ldr	r1, .L2906+76
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2900
.L2727:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2729
.L2730:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2729:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2730
	b	.L2728
.L2718:
	mov	r3, r5
	ldr	r1, .L2906+80
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2901
.L2790:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2791
.L2792:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2791:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2792
	b	.L2728
.L2710:
	mov	r3, r5
	ldr	r1, .L2906+84
	mov	r0, #20
	bl	dprint_vfmw
	cmp	r5, #0
	ble	.L2766
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2766
	mov	r8, #0
	b	.L2767
.L2768:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2766
.L2767:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2768
.L2766:
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	bge	.L2728
	movw	r3, #12452
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2728
.L2716:
	mov	r3, r5
	ldr	r1, .L2906+88
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2902
.L2784:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2785
.L2786:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2785:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2786
	b	.L2728
.L2705:
	mov	r3, r5
	ldr	r1, .L2906+92
	mov	r0, #20
	mov	r9, r5, asl #3
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	ldr	r8, [r4, #572]
	bl	MVC_DecPicTimingSEI
	ldr	r2, [r4, #572]
	rsb	r3, r8, r2
	cmp	r3, r9
	bge	.L2732
	rsb	r9, r3, r9
	ldr	r3, [r4, #564]
	cmp	r9, #0
	add	r8, r9, #7
	movge	r8, r9
	mov	r8, r8, asr #3
	cmp	r8, #0
	movle	r3, r3, asl #3
	ble	.L2734
	add	r1, r2, #8
	mov	r3, r3, asl #3
	cmp	r1, r3
	bgt	.L2734
	mov	r10, #0
	b	.L2735
.L2736:
	add	r1, r2, #8
	cmp	r1, r3
	bgt	.L2734
.L2735:
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	add	r10, r10, #1
	ldr	r3, [r4, #564]
	cmp	r10, r8
	ldr	r2, [r4, #572]
	mov	r3, r3, asl #3
	bne	.L2736
.L2734:
	mov	r1, r9, asr #31
	mov	r0, r1, lsr #29
	add	r1, r9, r0
	and	r1, r1, #7
	rsb	r1, r0, r1
	add	r2, r2, r1
	cmp	r3, r2
	bge	.L2903
.L2732:
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	bge	.L2728
	movw	r3, #12226
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2728
.L2707:
	mov	r3, r5
	ldr	r1, .L2906+96
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2904
.L2741:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2742
.L2743:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2742:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2743
	b	.L2728
.L2702:
	mov	r1, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	blt	.L2905
.L2821:
	cmp	r5, #0
	ble	.L2728
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
	mov	r8, #0
	b	.L2822
.L2823:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2728
.L2822:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2823
	b	.L2728
.L2881:
	cmp	r3, #128
	bne	.L2829
	b	.L2827
.L2708:
	mov	r3, r5
	ldr	r1, .L2906+100
	mov	r0, #20
	bl	dprint_vfmw
	mov	r3, #1
	str	r3, [fp, #-56]
	b	.L2745
.L2895:
	add	r3, r3, #132
	ldr	r3, [r4, r3, asl #2]
	str	r8, [r3, #1052]
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2755
	mov	r5, #0
	b	.L2756
.L2758:
	ldr	r3, [r4, #572]
	ldr	r2, [r4, #564]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2755
.L2756:
	add	r5, r5, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2758
	b	.L2755
.L2907:
	.align	2
.L2906:
	.word	.LC361
	.word	.LC362
	.word	.LC389
	.word	.LC390
	.word	.LC388
	.word	.LC387
	.word	.LC385
	.word	.LC386
	.word	.LC384
	.word	.LC383
	.word	.LC375
	.word	.LC379
	.word	.LC366
	.word	.LC381
	.word	.LC369
	.word	g_event_report
	.word	.LC377
	.word	.LC376
	.word	.LC378
	.word	.LC363
	.word	.LC382
	.word	.LC374
	.word	.LC380
	.word	.LC365
	.word	.LC367
	.word	.LC368
	.word	.LC370
	.word	.LC372
	.word	.LANCHOR0+236
	.word	.LC364
	.word	.LC371
	.word	.LC373
.L2893:
	strb	r3, [r1, #1026]
	mov	r0, r4
	ldr	r3, [r4, #60]
	mov	r1, #8
	ldr	r2, .L2906+104
	add	r3, r3, #132
	ldr	r9, [r4, r3, asl #2]
	bl	mvc_u_v
	strb	r0, [r9, #1027]
	ldr	r3, [r4, #60]
	add	r3, r3, #132
	ldr	ip, [r4, r3, asl #2]
	ldrb	r3, [ip, #1027]
	cmp	r3, #255
	beq	.L2750
	mov	r3, #3
	mov	r2, #0
	mov	r9, r3
	strb	r2, [ip, #1028]
.L2751:
	ldr	ip, [r4, #60]
	mov	r1, #16
	ldr	r2, .L2906+108
	mov	r0, r4
	add	ip, ip, #132
	str	r3, [fp, #-60]
	ldr	ip, [r4, ip, asl #2]
	str	ip, [fp, #-64]
	bl	mvc_u_v
	ldr	ip, [fp, #-64]
	ldr	r3, [fp, #-60]
	add	ip, ip, #1024
	mov	r1, r3
	strh	r0, [ip, #6]
	mov	r0, r4
	bl	MVC_PassBytes
	ldr	r3, [fp, #-60]
	cmp	r8, r3
	beq	.L2755
	ldr	r2, [r4, #60]
	add	r2, r2, #132
	ldr	r1, [r4, r2, asl #2]
	b	.L2749
.L2888:
	mov	r3, #12672
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2793
.L2889:
	movw	r3, #12464
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2769
.L2890:
	movw	r3, #12568
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2781
.L2891:
	movw	r3, #12238
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2738
.L2892:
	movw	r3, #12620
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2787
.L2884:
	movw	r3, #12776
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2805
.L2885:
	movw	r3, #12724
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2799
.L2886:
	movw	r3, #12750
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2802
.L2887:
	movw	r3, #12698
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2796
.L2882:
	movw	r3, #12828
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2811
.L2883:
	movw	r3, #12802
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2808
.L2898:
	movw	r3, #12490
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2772
.L2899:
	movw	r3, #12542
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2778
.L2900:
	movw	r3, #12173
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2727
.L2901:
	movw	r3, #12646
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2790
.L2897:
	movw	r3, #12516
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2775
.L2902:
	movw	r3, #12594
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2784
.L2904:
	movw	r3, #12264
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2741
.L2879:
	movw	r3, #12880
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2728
.L2905:
	movw	r3, #12892
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2821
.L2903:
	mov	r0, r6
	bl	BsSkip
	b	.L2732
.L2878:
	mov	r0, r6
	bl	BsSkip
	b	.L2815
.L2896:
	rsb	r1, r10, r5
	mov	r0, r4
	bl	MVC_PassBytes
	cmp	r0, #0
	bge	.L2760
	movw	r3, #12400
	ldr	r2, .L2906+112
	ldr	r1, .L2906+116
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2760
.L2833:
	mov	r2, #0
	mov	r8, r2
	b	.L2746
.L2750:
	ldr	r2, .L2906+120
	mov	r1, #8
	mov	r0, r4
	mov	r3, #4
	str	ip, [fp, #-64]
	str	r3, [fp, #-60]
	bl	mvc_u_v
	ldr	r3, [fp, #-60]
	ldr	ip, [fp, #-64]
	mov	r9, r3
	strb	r0, [ip, #1028]
	b	.L2751
.L2832:
	mvn	r0, #0
	b	.L2695
.L2894:
	ldr	r1, .L2906+124
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r4, #60]
	ldr	r0, [r4, #120]
	add	r3, r3, #132
	ldr	r1, [r4, r3, asl #2]
	bl	FreeUsdByDec
	ldr	r3, [r4, #60]
	mov	r2, #0
	mvn	r0, #0
	add	r3, r3, #132
	str	r2, [r4, r3, asl #2]
	b	.L2695
	.fnend
	.size	MVC_DecSEI, .-MVC_DecSEI
	.align	2
	.global	MVC_InitOldSlice
	.type	MVC_InitOldSlice, %function
MVC_InitOldSlice:
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
	ldr	r1, [r0, #40]
	add	r3, r0, #11075584
	movw	r2, #23352
	add	r3, r3, #40960
	movt	r2, 1
	mov	r0, #2
	str	r1, [r3, #2540]
	mov	r1, #7
	str	r2, [r3, #2544]
	mov	r2, #32
	strb	r1, [r3, #2531]
	mov	r1, #3
	strb	r2, [r3, #2530]
	mvn	r2, #0
	str	r1, [r3, #2552]
	mov	r1, #262144
	str	r2, [r3, #2556]
	mov	r2, #0
	strb	r0, [r3, #2529]
	str	r1, [r3, #2568]
	strb	r2, [r3, #2528]
	str	r2, [r3, #2560]
	str	r2, [r3, #2564]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_InitOldSlice, .-MVC_InitOldSlice
	.align	2
	.global	MVC_IsNewPicNal
	.type	MVC_IsNewPicNal, %function
MVC_IsNewPicNal:
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
	ldrb	r3, [r1, #3]
	mov	r5, r0
	and	r3, r3, #31
	sub	r3, r3, #1
	cmp	r3, #7
	ldrls	pc, [pc, r3, asl #2]
	b	.L2917
.L2912:
	.word	.L2911
	.word	.L2917
	.word	.L2917
	.word	.L2917
	.word	.L2911
	.word	.L2917
	.word	.L2913
	.word	.L2913
.L2913:
	ldr	r3, [r0]
	mov	r2, #1
	str	r2, [r0]
	adds	r3, r3, #0
	movne	r3, #1
	rsb	r0, r3, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L2911:
	ldr	r3, [r0]
	cmp	r3, #0
	beq	.L2914
.L2916:
	mvn	r0, #0
.L2915:
	mov	r2, #0
	str	r2, [r5]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L2917:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L2914:
	ldrb	ip, [r1, #5]
	ldrb	r3, [r1, #6]
	ldrb	r2, [r1, #7]
	mov	ip, ip, asl #16
	ldrb	r4, [r1, #4]
	orr	r3, ip, r3, asl #8
	orr	r3, r3, r2
	orr	r4, r3, r4, asl #24
	mov	r0, r4
	bl	ZerosMS_32
	cmp	r0, #15
	bhi	.L2916
	mov	r3, r0, asl #1
	rsb	r3, r3, #31
	mov	r3, r4, lsr r3
	subs	r0, r3, #1
	mvnne	r0, #0
	b	.L2915
	.fnend
	.size	MVC_IsNewPicNal, .-MVC_IsNewPicNal
	.align	2
	.global	MVC_FindZeroBitsInSeg
	.type	MVC_FindZeroBitsInSeg, %function
MVC_FindZeroBitsInSeg:
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
	cmp	r0, #0
	cmpne	r1, #0
	mov	r9, r0
	str	r1, [fp, #-48]
	movle	r4, #1
	movgt	r4, #0
	ble	.L2944
	ldr	r3, [fp, #-48]
	subs	r7, r3, #0
	add	r8, r3, #63
	movge	r8, r3
	ands	r3, r3, #63
	movne	r3, #1
	add	r8, r3, r8, asr #6
	cmp	r8, #0
	ble	.L2932
	ldr	r5, .L2945
	ldr	r10, .L2945+4
.L2930:
	cmp	r7, #64
	ldr	r3, [r10, #52]
	ldr	r0, .L2945
	movcc	r6, r7
	movcs	r6, #64
	mov	r2, r6
	rsb	r1, r6, r7
	sub	r6, r6, #1
	add	r1, r9, r1
	blx	r3
	add	r3, r5, r6
	ldrb	r2, [r5, r6]
	cmp	r2, #0
	bne	.L2922
	ldr	r2, .L2945
	add	r4, r4, #1
	cmp	r3, r2
	bne	.L2925
	b	.L2923
.L2926:
	cmp	r3, r5
	add	r4, r4, #1
	beq	.L2923
.L2925:
	ldrb	r2, [r3, #-1]!
	cmp	r2, #0
	beq	.L2926
.L2922:
	mov	r0, r4, asl #3
.L2921:
	ldr	r3, [fp, #-48]
	cmp	r4, r3
	bge	.L2934
	sub	r3, r3, #1
	rsb	r4, r4, r3
	ldrb	r2, [r9, r4]
	tst	r2, #1
	moveq	r2, r2, lsr #1
	moveq	r3, #1
	bne	.L2934
.L2929:
	tst	r2, #1
	mov	r2, r2, lsr #1
	bne	.L2927
	add	r3, r3, #1
	cmp	r3, #8
	bne	.L2929
	b	.L2927
.L2923:
	subs	r8, r8, #1
	sub	r7, r7, #64
	bne	.L2930
	b	.L2922
.L2934:
	mov	r3, #0
.L2927:
	add	r0, r3, r0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2944:
	mov	r2, r1
	mov	r0, #0
	ldr	r1, .L2945+8
	bl	dprint_vfmw
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2932:
	mov	r0, r4
	b	.L2921
.L2946:
	.align	2
.L2945:
	.word	.LANCHOR3-1952
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC391
	.fnend
	.size	MVC_FindZeroBitsInSeg, .-MVC_FindZeroBitsInSeg
	.align	2
	.global	MVC_FindTrailZeros
	.type	MVC_FindTrailZeros, %function
MVC_FindTrailZeros:
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
	beq	.L2953
	ldr	r3, [r4, #232]
	ldr	r2, [r3, #68]
	cmp	r2, #1
	bls	.L2952
	ldr	r1, [r3, #40]
	ldr	r0, [r3, #36]
	bl	MVC_FindZeroBitsInSeg
	ldr	r3, [r4, #232]
	ldr	r2, [r3, #40]
	cmp	r0, r2, asl #3
	bcs	.L2956
	cmn	r0, #1
	beq	.L2952
.L2951:
	add	r0, r0, #1
	str	r0, [r3, #72]
	ldr	r3, [r4, #232]
	ldr	r2, [r3, #68]
	cmp	r2, #1
	bls	.L2955
	ldr	r1, [r3, #40]
	ldr	r2, [r3, #72]
	cmp	r2, r1, asl #3
	bcs	.L2957
.L2955:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L2957:
	ldr	r1, [r3, #60]
	ldr	r0, [r4, #120]
	bl	SM_ReleaseStreamSeg
	ldr	r2, [r4, #232]
	mov	r3, #0
	mov	r1, #1
	mov	r0, r3
	str	r3, [r2, #36]
	ldr	r2, [r4, #232]
	str	r1, [r2, #68]
	ldr	r2, [r4, #232]
	str	r3, [r2, #72]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L2956:
	ldr	r1, [r3, #60]
	ldr	r0, [r4, #120]
	bl	SM_ReleaseStreamSeg
	ldr	r3, [r4, #232]
	mov	r1, #0
	mov	r2, #1
	str	r1, [r3, #36]
	ldr	r3, [r4, #232]
	str	r2, [r3, #68]
	ldr	r3, [r4, #232]
.L2952:
	ldr	r1, [r3, #12]
	ldr	r0, [r3, #8]
	bl	MVC_FindZeroBitsInSeg
	ldr	r3, [r4, #232]
	b	.L2951
.L2953:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	MVC_FindTrailZeros, .-MVC_FindTrailZeros
	.align	2
	.global	MVC_CombinePacket
	.type	MVC_CombinePacket, %function
MVC_CombinePacket:
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
	ldr	r3, [r0, #232]
	ldr	r3, [r3, #12]
	cmp	r3, #4096
	ldmcsfd	sp, {fp, sp, pc}
	bl	MVC_CombinePacket.part.12
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_CombinePacket, .-MVC_CombinePacket
	.align	2
	.global	MVC_FindNaluArraySlot
	.type	MVC_FindNaluArraySlot, %function
MVC_FindNaluArraySlot:
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
	ldrb	r2, [r0, #937]
	cmp	r2, #0
	beq	.L2965
	mov	r2, r0
	mov	r3, #1
	b	.L2963
.L2962:
	add	r3, r3, #1
	cmp	r3, #137
	beq	.L2968
.L2963:
	ldrb	r1, [r2, #1025]
	add	r2, r2, #88
	cmp	r1, #0
	bne	.L2962
	mov	r2, r3
.L2961:
	mov	ip, #88
	mov	r1, #1
	mla	r3, ip, r3, r0
	mov	r0, r2
	strb	r1, [r3, #937]
	ldmfd	sp, {fp, sp, pc}
.L2968:
	mvn	r2, #0
	mov	r0, r2
	ldmfd	sp, {fp, sp, pc}
.L2965:
	mov	r3, r2
	b	.L2961
	.fnend
	.size	MVC_FindNaluArraySlot, .-MVC_FindNaluArraySlot
	.align	2
	.global	MVC_InquireSliceProperty
	.type	MVC_InquireSliceProperty, %function
MVC_InquireSliceProperty:
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
	ldr	r3, [r0, #68]
	mov	r4, r0
	mov	r9, r1
	mov	r7, r2
	ldr	r1, .L3012
	sub	r2, r3, #1
	mov	r0, #22
	bl	dprint_vfmw
	mov	r3, #0
	str	r3, [r7]
	add	r6, r4, #11075584
	str	r3, [r9]
	add	r5, r6, #40960
	ldr	r2, [r4, #232]
	add	r1, r4, #12288
	mvn	ip, #0
	ldrb	r0, [r2, #2]
	strb	r0, [r5, #875]
	ldrb	lr, [r2, #4]
	strb	lr, [r5, #880]
	ldrb	r2, [r2, #5]
	strb	r3, [r5, #883]
	str	ip, [r5, #2512]
	strb	r2, [r5, #884]
	ldrb	r3, [r1, #704]
	cmp	r3, #1
	beq	.L3005
	cmp	r2, #255
	beq	.L3006
.L2971:
	mov	r0, r4
	bl	MVC_SliceCheck
	subs	r8, r0, #0
	bne	.L2987
	mov	r0, r4
	bl	MVC_ProcessSliceHeaderFirstPart
	cmp	r0, #0
	bne	.L3007
	ldrb	r3, [r5, #877]
	mov	ip, #2240
	sub	r3, r3, #1
	clz	r3, r3
	mov	r3, r3, lsr #5
	str	r3, [r9]
	ldrb	r1, [r5, #884]
	ldr	r3, [r5, #888]
	ldr	r0, [r4, #252]
	sxtb	r2, r1
	cmn	r2, #1
	mla	r3, ip, r3, r0
	beq	.L3008
	cmp	r1, #0
	bne	.L2983
	ldrb	r2, [r4, #2]
	ldr	r3, [r3, #28]
	cmp	r2, #1
	beq	.L3009
	ldr	r2, [r4, #28]
	cmp	r2, r3
	movweq	r3, #35364
	movteq	r3, 168
	addeq	r3, r4, r3
	bne	.L3010
.L2982:
	ldrb	r2, [r3, #20]
	add	r6, r6, #45056
	ldr	r0, [r3, #3952]
	rsb	r1, r2, #2
	ldr	r2, [r3, #3948]
	ldr	ip, [r4, #16]
	mla	r1, r0, r1, r1
	ldr	r0, [r4, #12]
	add	r2, r2, #1
	cmp	r0, r2
	cmpeq	ip, r1
	movne	r2, #1
	strne	r2, [r7]
	ldr	r2, [r3, #3972]
	ldr	r3, [r6, #2728]
	add	r3, r3, #1
	cmp	r2, r3
	movhi	r3, #1
	strhi	r3, [r7]
.L2979:
	mov	r0, r8
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L3005:
	strb	r3, [r5, #883]
	ldr	r3, [r1, #712]
	str	r3, [r5, #2512]
	ldrb	r3, [r1, #708]
	strb	r3, [r5, #881]
	ldrb	r3, [r1, #709]
	strb	r3, [r5, #882]
	b	.L2971
.L3008:
	ldr	r3, [r3, #28]
	movw	r1, #3992
	ldr	r2, [r4, #248]
	mla	r3, r1, r3, r2
	b	.L2982
.L3006:
	ldr	r3, [r4, #20]
	cmp	r3, #0
	beq	.L2971
	add	r3, r4, #10747904
	add	r3, r3, #20480
	ldr	r2, [r3, #2384]
	cmp	r2, #0
	bne	.L2974
	ldrb	r2, [r3, #2380]
	cmp	r2, #0
	bne	.L2974
	add	r3, r4, #12992
	add	r3, r3, #16
.L2977:
	ldr	r1, [r3]
	cmp	r1, #0
	beq	.L2975
	ldrb	r1, [r3, #-4]
	cmp	r1, #0
	bne	.L3011
.L2975:
	add	r2, r2, #1
	add	r3, r3, #335872
	cmp	r2, #32
	add	r3, r3, #308
	bne	.L2977
	mvn	r3, #0
	b	.L3004
.L3009:
	movw	r2, #8500
	movt	r2, 5
	mla	r3, r2, r3, r4
	add	r3, r3, #286720
	add	r3, r3, #932
	b	.L2982
.L2974:
	ldr	r3, [r3, #2388]
.L3004:
	cmn	r3, #1
	str	r3, [r5, #2512]
	beq	.L2971
	sub	r0, r0, #5
	mov	r3, #1
	clz	r0, r0
	strb	r3, [r5, #883]
	strb	r3, [r5, #882]
	mov	r0, r0, lsr #5
	strb	r0, [r5, #881]
	b	.L2971
.L2987:
	mvn	r8, #0
	b	.L2979
.L3010:
	ldr	r1, .L3012+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L2979
.L3007:
	ldr	r1, .L3012+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L2979
.L2983:
	ldr	r1, .L3012+12
	mov	r0, #1
	mvn	r8, #0
	bl	dprint_vfmw
	b	.L2979
.L3011:
	movw	r3, #8500
	movt	r3, 5
	mla	r3, r3, r2, r4
	add	r3, r3, #12992
	add	r3, r3, #16
	ldr	r3, [r3, #4]
	b	.L3004
.L3013:
	.align	2
.L3012:
	.word	.LC392
	.word	.LC30
	.word	.LC393
	.word	.LC394
	.fnend
	.size	MVC_InquireSliceProperty, .-MVC_InquireSliceProperty
	.align	2
	.global	MVC_HaveSliceToDec
	.type	MVC_HaveSliceToDec, %function
MVC_HaveSliceToDec:
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
	ldr	r0, [r0, #64]
	clz	r0, r0
	mov	r0, r0, lsr #5
	rsb	r0, r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	MVC_HaveSliceToDec, .-MVC_HaveSliceToDec
	.align	2
	.global	MVC_IsRefListWrong
	.type	MVC_IsRefListWrong, %function
MVC_IsRefListWrong:
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
	add	r5, r0, #11075584
	add	r5, r5, #40960
	mov	r7, r0
	ldr	r3, [r5, #920]
	cmp	r3, #0
	beq	.L3016
	add	r6, r0, #252
	mov	r4, #0
	b	.L3020
.L3017:
	ldr	r3, [r0, #608]
	cmp	r3, #0
	beq	.L3019
	ldr	r3, [r5, #920]
	cmp	r4, r3
	bcs	.L3042
.L3020:
	ldr	r3, [r6, #4]!
	add	r4, r4, #1
	ldr	r0, [r7, #120]
	ldr	r3, [r3, #4]
	ldrsb	r1, [r3, #6]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	bne	.L3017
.L3019:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3042:
	cmp	r3, #0
	beq	.L3016
	ldr	r3, [r5, #924]
	cmp	r3, #0
	addne	r6, r7, #384
	movne	r4, #0
	bne	.L3023
	b	.L3016
.L3043:
	ldr	r3, [r0, #608]
	cmp	r3, #0
	beq	.L3019
	ldr	r3, [r5, #924]
	cmp	r4, r3
	bcs	.L3016
.L3023:
	ldr	r3, [r6, #4]!
	add	r4, r4, #1
	ldr	r0, [r7, #120]
	ldr	r3, [r3, #4]
	ldrsb	r1, [r3, #6]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	bne	.L3043
	b	.L3019
.L3016:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	MVC_IsRefListWrong, .-MVC_IsRefListWrong
	.align	2
	.global	MVC_DEC_Destroy
	.type	MVC_DEC_Destroy, %function
MVC_DEC_Destroy:
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
	bl	MVC_ClearCurrPic
	mov	r0, r5
	bl	MVC_ClearAllNal
	ldr	r3, [r5, #60]
	cmp	r3, #0
	beq	.L3045
	mov	r4, #0
	add	r6, r5, #524
	mov	r7, r4
.L3047:
	ldr	r1, [r6, #4]!
	add	r4, r4, #1
	cmp	r1, #0
	beq	.L3046
	ldr	r0, [r5, #120]
	bl	FreeUsdByDec
	str	r7, [r6]
.L3046:
	ldr	r3, [r5, #60]
	cmp	r3, r4
	bhi	.L3047
.L3045:
	movw	r9, #48776
	movw	r8, #14280
	movt	r9, 169
	movt	r8, 170
	add	r9, r5, r9
	add	r8, r5, r8
	mov	r6, #0
	mov	r7, #0
.L3051:
	sub	r4, r9, #32
.L3049:
	ldrd	r2, [r4, #8]!
	orrs	r1, r2, r3
	bne	.L3064
.L3048:
	cmp	r4, r9
	bne	.L3049
	add	r9, r4, #776
	cmp	r9, r8
	bne	.L3051
	ldr	r1, .L3065
	mov	r0, #2
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L3064:
	mov	r1, r2
	ldr	r0, [r5, #120]
	bl	FreeUsdByDec
	strd	r6, [r4]
	b	.L3048
.L3066:
	.align	2
.L3065:
	.word	.LC395
	.fnend
	.size	MVC_DEC_Destroy, .-MVC_DEC_Destroy
	.align	2
	.global	MVC_DEC_RecycleImage
	.type	MVC_DEC_RecycleImage, %function
MVC_DEC_RecycleImage:
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
	mov	r8, r1
	mov	r0, #2
	ldr	r1, .L3078
	bl	dprint_vfmw
	mov	r1, r8
	ldr	r0, [r5, #120]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	beq	.L3072
	ldrsb	r3, [r0, #1]
	cmp	r3, #0
	beq	.L3072
	add	r4, r0, #528
	add	r9, r0, #560
	mov	r6, #0
	mov	r7, #0
.L3070:
	ldrd	r2, [r4, #8]!
	orrs	r1, r2, r3
	bne	.L3077
.L3069:
	cmp	r4, r9
	bne	.L3070
	ldr	r0, [r5, #120]
	mov	r1, r8
	mov	r2, #0
	bl	FSP_SetDisplay
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L3077:
	mov	r1, r2
	ldr	r0, [r5, #120]
	bl	FreeUsdByDec
	strd	r6, [r4]
	b	.L3069
.L3072:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L3079:
	.align	2
.L3078:
	.word	.LC396
	.fnend
	.size	MVC_DEC_RecycleImage, .-MVC_DEC_RecycleImage
	.align	2
	.global	MVC_OutputFrmToVO
	.type	MVC_OutputFrmToVO, %function
MVC_OutputFrmToVO:
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
	clz	r5, r1
	mov	r7, r2
	mov	r6, r1
	mov	r4, r0
	mov	r5, r5, lsr #5
	cmp	r0, #0
	movne	ip, r5
	orreq	ip, r5, #1
	cmp	ip, #0
	bne	.L3114
	ldr	r3, [r0, #224]
	ldr	r3, [r3, #12]
	cmp	r3, #0
	ble	.L3083
	ldrb	r3, [r0, #8]
	cmp	r3, #2
	beq	.L3083
	ldr	r3, [r0, #520]
	cmp	r3, #0
	strneb	ip, [r3, #2]
	movne	r0, #1
	strne	ip, [r4, #520]
	beq	.L3085
.L3113:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L3083:
	mov	r1, r6
	mov	r0, r4
	bl	MVC_CheckFrameStore
	cmn	r0, #3
	beq	.L3085
	ldr	r1, [r4, #520]
	cmp	r1, #0
	beq	.L3087
	mov	r0, r4
	bl	MVC_GetImagePara
	ldr	r1, [r4, #520]
	mov	r0, r4
	bl	MVC_CheckFrameStore
	subs	r8, r0, #0
	beq	.L3115
	cmn	r8, #3
	beq	.L3095
	mov	r3, r8
	movw	r2, #1948
	ldr	r1, .L3123
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r4, #520]
	mov	r0, r4
	sub	r8, r8, #1
	clz	r8, r8
	ldr	r1, [r3, #228]
	bl	MVC_DEC_RecycleImage
	mov	r8, r8, lsr #5
.L3094:
	ldr	r3, [r4, #520]
	tst	r8, r5
	mov	r0, #0
	strb	r0, [r3, #2]
	str	r0, [r4, #520]
	bne	.L3113
.L3087:
	mov	r1, r6
	mov	r0, r4
	bl	MVC_GetImagePara
	mov	r1, r6
	mov	r0, r4
	bl	MVC_CheckFrameStore
	subs	r3, r0, #0
	beq	.L3116
	movw	r2, #1997
	ldr	r1, .L3123
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r1, [r6, #228]
	mov	r0, r4
	bl	MVC_DEC_RecycleImage
	mov	r0, #2
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L3114:
	mov	r3, r1
	mov	r2, r0
	ldr	r1, .L3123+4
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #2
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L3085:
	mov	r0, #1
	b	.L3113
.L3116:
	mov	r2, #1
	ldrsb	r1, [r6, #6]
	ldr	r0, [r4, #120]
	bl	FSP_SetDisplay
	ldrsb	r1, [r6, #6]
	ldr	r0, [r4, #120]
	bl	FSP_GetFsImagePtr
	subs	r5, r0, #0
	beq	.L3117
	cmp	r7, #1
	add	r3, r4, #584
	streq	r7, [r5, #188]
	mov	r2, r4
	ldr	r0, [r4, #120]
	mov	r1, #15
	str	r5, [sp]
	bl	InsertImgToVoQueue
	cmp	r0, #1
	bne	.L3118
	ldr	r3, [r4, #224]
	ldr	r3, [r3, #600]
	add	r3, r3, #2032
	add	r3, r3, #15
	cmp	r3, #4096
	movcc	r3, #0
	strcc	r3, [r5, #24]
	bcs	.L3119
.L3102:
	ldr	r2, [r4, #144]
	mov	r0, #0
	ldr	r3, [r4, #136]
	add	r2, r2, #1
	str	r2, [r4, #144]
	add	r3, r3, #2
	str	r3, [r4, #136]
	b	.L3113
.L3118:
	mov	r2, r0
	ldr	r1, .L3123+8
	mov	r0, #0
	bl	dprint_vfmw
	ldrsb	r1, [r6, #6]
	mov	r2, #0
	ldr	r0, [r4, #120]
	bl	FSP_SetDisplay
	mov	r0, r4
	mov	r1, #1
	bl	MVC_ClearAll
	mvn	r0, #0
	b	.L3113
.L3095:
	ldr	r2, [r4, #520]
	mov	r3, #0
	strb	r3, [r2, #2]
	str	r3, [r4, #520]
	b	.L3087
.L3115:
	ldr	r3, [r4, #520]
	mov	r2, #1
	ldr	r0, [r4, #120]
	ldrsb	r1, [r3, #6]
	bl	FSP_SetDisplay
	ldr	r3, [r4, #520]
	ldr	r0, [r4, #120]
	ldrsb	r1, [r3, #6]
	bl	FSP_GetFsImagePtr
	subs	r8, r0, #0
	beq	.L3120
	ldr	r3, [r4, #520]
	mov	r2, r4
	mov	r1, #15
	cmp	r6, r3
	cmpeq	r7, #1
	moveq	r3, #1
	streq	r3, [r8, #188]
	add	r3, r4, #584
	ldr	r0, [r4, #120]
	str	r8, [sp]
	bl	InsertImgToVoQueue
	cmp	r0, #1
	bne	.L3121
	ldr	r3, [r4, #224]
	ldr	r3, [r3, #600]
	add	r3, r3, #2032
	add	r3, r3, #15
	cmp	r3, #4096
	movcc	r3, #0
	strcc	r3, [r8, #24]
	bcs	.L3122
.L3093:
	ldr	r2, [r4, #144]
	mov	r8, #1
	ldr	r3, [r4, #136]
	add	r2, r2, r8
	str	r2, [r4, #144]
	add	r3, r3, #2
	str	r3, [r4, #136]
	b	.L3094
.L3119:
	mov	r1, r5
	mov	r0, r4
	bl	MVC_SetFrmRepeatCount.part.1
	b	.L3102
.L3122:
	mov	r1, r8
	mov	r0, r4
	bl	MVC_SetFrmRepeatCount.part.1
	b	.L3093
.L3121:
	mov	r2, r0
	ldr	r1, .L3123+8
	mov	r0, #0
	mov	r5, r0
	bl	dprint_vfmw
	ldr	r3, [r4, #520]
	mov	r2, r5
	strb	r5, [r3, #2]
	ldr	r3, [r4, #520]
	ldr	r0, [r4, #120]
	ldrsb	r1, [r3, #6]
	bl	FSP_SetDisplay
	str	r5, [r4, #520]
	mov	r0, r4
	mov	r1, #1
	bl	MVC_ClearAll
	mvn	r0, #0
	b	.L3113
.L3117:
	movw	r2, #1971
	ldr	r1, .L3123+12
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3113
.L3120:
	movw	r2, #1919
	ldr	r1, .L3123+12
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3113
.L3124:
	.align	2
.L3123:
	.word	.LC400
	.word	.LC397
	.word	.LC399
	.word	.LC398
	.fnend
	.size	MVC_OutputFrmToVO, .-MVC_OutputFrmToVO
	.align	2
	.global	MVC_OutputFrmFromDPB
	.type	MVC_OutputFrmFromDPB, %function
MVC_OutputFrmFromDPB:
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
	add	r4, r0, r1, lsl #2
	add	r4, r4, #11075584
	mov	r6, r1
	add	r4, r4, #45056
	mov	r5, r0
	ldr	r3, [r4, #2536]
	cmp	r3, #0
	moveq	r4, r3
	beq	.L3126
	mov	r2, #0
	strb	r2, [r3, #5]
	ldr	r1, [r4, #2536]
	bl	MVC_OutputFrmToVO
	ldr	r3, [r4, #2536]
	ldrb	r2, [r3, #3]
	cmn	r0, #1
	movne	r0, #0
	moveq	r0, #1
	cmp	r2, #0
	rsb	r4, r0, #0
	beq	.L3128
.L3126:
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3128:
	mov	r0, r5
	mov	r1, r6
	bl	MVC_RemoveFrameStoreOutDPB
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	MVC_OutputFrmFromDPB, .-MVC_OutputFrmFromDPB
	.align	2
	.global	MVC_FlushDPB
	.type	MVC_FlushDPB, %function
MVC_FlushDPB:
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
	beq	.L3148
	add	r8, r5, #11075584
	add	r8, r8, #45056
	ldr	r3, [r8, #2728]
	cmp	r3, #0
	movwne	r7, #47588
	movne	r6, #0
	movtne	r7, 169
	addne	r7, r5, r7
	beq	.L3136
.L3135:
	ldr	r1, [r7, #4]!
	add	r6, r6, #1
	cmp	r1, #0
	beq	.L3134
	ldrb	r3, [r1, #3]
	cmp	r3, #0
	beq	.L3134
	ldr	r3, [r1, #56]
	cmn	r4, #1
	cmpne	r3, r4
	bne	.L3134
	mov	r0, r5
	bl	MVC_UnMarkFrameStoreRef
.L3134:
	ldr	r3, [r8, #2728]
	cmp	r3, r6
	bhi	.L3135
.L3136:
	mov	r1, r4
	mov	r0, r5
	bl	MVC_RemoveUnUsedFrameStore
	ldr	r0, [r8, #2728]
	cmp	r0, #0
	beq	.L3133
	movw	r1, #47588
	mov	r7, #0
	movt	r1, 169
	add	r1, r5, r1
	mov	r2, r7
	mvn	r6, #0
.L3140:
	ldr	r3, [r1, #4]!
	add	r2, r2, #1
	cmp	r3, #0
	beq	.L3138
	ldr	r3, [r3, #56]
	cmn	r4, #1
	cmpne	r4, r3
	addeq	r7, r7, #1
	cmp	r4, r3
	cmnne	r4, #1
	movne	r6, r3
.L3138:
	cmp	r2, r0
	bne	.L3140
	cmp	r7, #0
	beq	.L3133
	adds	r8, r6, #1
	movne	r8, #1
	cmp	r4, r6
	movle	r9, #0
	andgt	r9, r8, #1
	b	.L3146
.L3147:
	subs	r7, r7, #1
	beq	.L3133
.L3146:
	cmp	r9, #0
	sub	r3, fp, #44
	sub	r2, fp, #40
	mov	r1, r6
	mov	r0, r5
	beq	.L3143
	bl	MVC_GetMinPOC
	ldr	r1, [fp, #-44]
	mov	r0, r5
	cmn	r1, #1
	beq	.L3133
	bl	MVC_OutputFrmFromDPB
	cmp	r0, #0
	bne	.L3148
.L3143:
	mov	r1, r4
	sub	r3, fp, #44
	sub	r2, fp, #40
	mov	r0, r5
	bl	MVC_GetMinPOC
	ldr	r1, [fp, #-44]
	mov	r0, r5
	cmn	r1, #1
	beq	.L3133
	bl	MVC_OutputFrmFromDPB
	cmp	r0, #0
	bne	.L3148
	cmp	r4, r6
	movge	r3, #0
	andlt	r3, r8, #1
	cmp	r3, #0
	beq	.L3147
	mov	r1, r6
	sub	r3, fp, #44
	sub	r2, fp, #40
	mov	r0, r5
	bl	MVC_GetMinPOC
	ldr	r1, [fp, #-44]
	mov	r0, r5
	cmn	r1, #1
	beq	.L3133
	bl	MVC_OutputFrmFromDPB
	cmp	r0, #0
	beq	.L3147
.L3148:
	mvn	r0, #0
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L3133:
	mov	r0, #0
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	MVC_FlushDPB, .-MVC_FlushDPB
	.align	2
	.global	MVC_AdaptiveMemMark
	.type	MVC_AdaptiveMemMark, %function
MVC_AdaptiveMemMark:
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
	add	r9, r0, #11141120
	add	r9, r9, #12288
	add	r8, r0, #11075584
	movw	r7, #13656
	add	r8, r8, #36864
	ldr	r4, [r9, #1980]
	movt	r7, 170
	add	r10, r0, #11075584
	add	r7, r0, r7
	add	r6, r4, #2000
	add	r4, r4, #4
	add	r6, r6, #4
	mov	r5, r0
.L3195:
	ldr	r3, [r4]
	cmp	r3, #6
	ldrls	pc, [pc, r3, asl #2]
	b	.L3186
.L3188:
	.word	.L3187
	.word	.L3189
	.word	.L3190
	.word	.L3191
	.word	.L3192
	.word	.L3193
	.word	.L3194
.L3194:
	ldr	r2, [r4, #12]
	mov	r1, r7
	mov	r0, r5
	bl	MVC_MarkCurrPicLT
.L3186:
	add	r4, r4, #20
	cmp	r4, r6
	bne	.L3195
.L3187:
	ldrb	r3, [r8, #3832]
	cmp	r3, #1
	beq	.L3203
	mov	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3193:
	mov	r0, r5
	bl	MVC_UnMarkAllSTRef
	mov	r0, r5
	bl	MVC_UpdateReflist
	mov	r1, #0
	mov	r0, r5
	bl	MVC_UpdateMaxLTFrmIdx
	mov	r0, r5
	bl	MVC_UpdateLTReflist
	mov	r3, #1
	strb	r3, [r8, #3832]
	b	.L3186
.L3192:
	mov	r0, r5
	ldr	r1, [r4, #16]
	bl	MVC_UpdateMaxLTFrmIdx
	mov	r0, r5
	bl	MVC_UpdateLTReflist
	b	.L3186
.L3191:
	ldr	r3, [r4, #12]
	mov	r1, r7
	ldr	r2, [r4, #4]
	mov	r0, r5
	bl	MVC_MarkSTToLTRef
	mov	r0, r5
	bl	MVC_UpdateReflist
	mov	r0, r5
	bl	MVC_UpdateLTReflist
	b	.L3186
.L3190:
	mov	r0, r5
	ldr	r2, [r4, #8]
	mov	r1, r7
	bl	MVC_UnMarkLTRef
	mov	r0, r5
	bl	MVC_UpdateLTReflist
	b	.L3186
.L3189:
	mov	r0, r5
	ldr	r2, [r4, #4]
	mov	r1, r7
	bl	MVC_UnMarkSTRef
	mov	r0, r5
	bl	MVC_UpdateReflist
	b	.L3186
.L3203:
	add	r10, r10, #40960
	mov	r2, #0
	str	r2, [r9, #1984]
	movw	r3, #26846
	ldr	r1, [r10, #2516]
	movt	r3, 42
	add	r3, r1, r3
	add	r3, r5, r3, lsl #2
	str	r2, [r3, #4]
	ldrb	r3, [r9, #1371]
	str	r2, [r9, #2768]
	cmp	r3, #1
	beq	.L3198
	bcc	.L3199
	cmp	r3, #2
	streq	r2, [r9, #2008]
	streq	r2, [r9, #1996]
	streq	r2, [r8, #3860]
	streq	r2, [r8, #3868]
.L3197:
	ldr	r1, [r9, #2056]
	mov	r0, r5
	bl	MVC_FlushDPB
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r0, r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3199:
	ldr	r1, [r9, #1996]
	ldr	r2, [r9, #2004]
	ldr	r3, [r9, #2008]
	rsb	r2, r1, r2
	str	r2, [r9, #2004]
	rsb	r3, r1, r3
	str	r3, [r9, #2008]
	cmp	r3, r2
	movge	r3, r2
	str	r3, [r9, #2000]
	str	r3, [r9, #1996]
	ldr	r1, [r8, #3868]
	ldr	r2, [r8, #3856]
	ldr	r3, [r8, #3860]
	rsb	r2, r1, r2
	str	r2, [r8, #3856]
	rsb	r3, r1, r3
	str	r3, [r8, #3860]
	cmp	r3, r2
	movge	r3, r2
	str	r3, [r8, #3864]
	str	r3, [r8, #3868]
	b	.L3197
.L3198:
	str	r2, [r9, #2004]
	str	r2, [r9, #1996]
	str	r2, [r8, #3856]
	str	r2, [r8, #3868]
	b	.L3197
	.fnend
	.size	MVC_AdaptiveMemMark, .-MVC_AdaptiveMemMark
	.align	2
	.global	MVC_IDRMemMarking
	.type	MVC_IDRMemMarking, %function
MVC_IDRMemMarking:
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
	add	r6, r0, #11141120
	mov	r7, r0
	add	r6, r6, #12288
	ldr	r3, [r6, #1980]
	ldrb	r3, [r3, #1]
	cmp	r3, #0
	beq	.L3205
	ldr	lr, [r0, #52]
	cmp	lr, #0
	beq	.L3214
	movw	r1, #47588
	mov	r2, #0
	movt	r1, 169
	add	r0, r0, #148
	add	r1, r7, r1
	mov	r4, r2
.L3213:
	ldr	r3, [r1, #4]!
	add	r2, r2, #1
	cmp	r3, #0
	beq	.L3210
	ldr	ip, [r3, #16]
	cmp	ip, #1
	streqb	ip, [r7, #6]
	ldr	ip, [r3, #56]
	ldr	r3, [r6, #2056]
	cmp	ip, r3
	streq	r4, [r0]
.L3210:
	cmp	r2, lr
	add	r0, r0, #4
	bne	.L3213
.L3214:
	add	r9, r7, #11075584
	add	ip, r9, #45056
	ldr	r10, [ip, #2728]
	cmp	r10, #0
	beq	.L3208
	movw	r4, #47588
	mov	r5, #0
	movt	r4, 169
	mov	r8, r5
	add	r4, r7, r4
	b	.L3219
.L3217:
	cmp	r5, r10
	beq	.L3208
.L3219:
	ldr	r1, [r4, #4]!
	add	r5, r5, #1
	cmp	r1, #0
	beq	.L3217
	ldr	r0, [r1, #56]
	ldr	r2, [r6, #2056]
	cmp	r0, r2
	bne	.L3217
	strb	r8, [r1, #666]
	mov	r2, #0
	strb	r8, [r1, #665]
	ldr	r1, [r4]
	str	ip, [fp, #-48]
	strb	r8, [r1, #702]
	strb	r8, [r1, #701]
	ldr	r1, [r4]
	strb	r8, [r1, #738]
	strb	r8, [r1, #737]
	ldr	r1, [r4]
	strb	r8, [r1, #3]
	ldr	r1, [r4]
	ldr	r0, [r7, #120]
	ldrsb	r1, [r1, #6]
	bl	FSP_SetRef
	ldr	r1, [r4]
	mov	r3, #1
	movw	r2, #47800
	movt	r2, 169
	strb	r8, [r1, #2]
	ldr	r1, [r4]
	strb	r8, [r1, #5]
	ldr	r1, [r4]
	strb	r3, [r1, #7]
	ldr	r0, [r4]
	ldr	r1, [r0, #52]
	add	r1, r7, r1
	add	r2, r1, r2
	strb	r8, [r2, #4]
	ldrsb	r1, [r0, #6]
	ldr	r0, [r7, #120]
	bl	FSP_GetDisplay
	mov	r2, #0
	ldr	ip, [fp, #-48]
	cmp	r0, #3
	beq	.L3218
	ldr	r1, [r4]
	ldr	r0, [r7, #120]
	ldrsb	r1, [r1, #6]
	bl	FSP_SetDisplay
	ldr	ip, [fp, #-48]
.L3218:
	str	r8, [r4]
	cmp	r5, r10
	str	r8, [r4, #64]
	str	r8, [r4, #128]
	ldr	r2, [ip, #2732]
	sub	r2, r2, #1
	str	r2, [ip, #2732]
	bne	.L3219
.L3208:
	mov	r0, r7
	bl	MVC_UpdateReflist
	mov	r0, r7
	bl	MVC_UpdateLTReflist
	ldr	r3, [r6, #1980]
	ldrb	r3, [r3, #2]
	cmp	r3, #0
	bne	.L3232
	add	r9, r9, #45056
	mov	r0, r3
	mov	r2, #1
	str	r3, [r9, #2744]
	strb	r3, [r6, #1372]
	strb	r2, [r6, #1373]
.L3220:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3232:
	add	r9, r9, #45056
	mov	r3, #0
	mov	r2, #1
	mov	r0, r3
	str	r2, [r9, #2744]
	strb	r2, [r6, #1372]
	str	r3, [r6, #1988]
	strb	r3, [r6, #1373]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3205:
	ldr	r1, [r6, #2056]
	bl	MVC_FlushDPB
	cmp	r0, #0
	addeq	r9, r7, #11075584
	beq	.L3208
.L3221:
	mvn	r0, #0
	b	.L3220
	.fnend
	.size	MVC_IDRMemMarking, .-MVC_IDRMemMarking
	.align	2
	.global	MVC_Marking
	.type	MVC_Marking, %function
MVC_Marking:
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
	add	r3, r0, #11075584
	add	r5, r0, #11141120
	add	r3, r3, #36864
	add	r4, r5, #12288
	mov	r2, #0
	strb	r2, [r3, #3832]
	mov	r6, r0
	ldrb	r2, [r4, #1371]
	sub	r2, r2, #2
	clz	r2, r2
	mov	r2, r2, lsr #5
	strb	r2, [r3, #3833]
	ldrb	r3, [r4, #1374]
	cmp	r3, #5
	beq	.L3234
	ldrb	r3, [r4, #1380]
	cmp	r3, #0
	bne	.L3235
	ldr	r3, [r0, #224]
	ldr	r2, [r3, #632]
	cmp	r2, #1
	beq	.L3256
.L3235:
	ldr	r3, [r4, #1980]
	ldrb	r3, [r3, #3]
	cmp	r3, #0
	ldr	r3, [r4, #1992]
	beq	.L3257
	cmp	r3, #0
	bne	.L3258
.L3242:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3257:
	cmp	r3, #0
	beq	.L3242
.L3241:
	ldrb	r7, [r4, #1369]
	cmp	r7, #0
	beq	.L3259
.L3245:
	add	r5, r5, #12288
	mov	r0, #0
	ldrb	r3, [r5, #1372]
	clz	r3, r3
	mov	r3, r3, lsr #5
	strb	r3, [r5, #1373]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3256:
	ldr	r2, [r3, #628]
	cmp	r2, #0
	bne	.L3235
	ldr	r2, [r3, #636]
	cmp	r2, #0
	bne	.L3235
	ldr	r3, [r3, #600]
	add	r3, r3, #1024
	cmp	r3, #2048
	bls	.L3235
.L3234:
	mov	r0, r6
	bl	MVC_IDRMemMarking
	cmp	r0, #0
	bne	.L3236
.L3243:
	ldrb	r3, [r4, #1374]
	cmp	r3, #5
	beq	.L3238
	ldr	r3, [r4, #1992]
	cmp	r3, #0
	beq	.L3242
	ldr	r3, [r4, #1980]
	ldrb	r3, [r3, #3]
	cmp	r3, #0
	beq	.L3241
	b	.L3245
.L3259:
	mov	r0, r6
	bl	MVC_SlidingWinMark
	ldr	r3, [r4, #1980]
	strb	r7, [r3]
	strb	r7, [r4, #1372]
.L3238:
	ldr	r3, [r4, #1992]
	cmp	r3, #0
	bne	.L3245
	b	.L3242
.L3258:
	mov	r0, r6
	bl	MVC_AdaptiveMemMark
	ldr	r3, [r4, #1980]
	mov	r2, #0
	strb	r2, [r3]
	cmp	r0, r2
	beq	.L3243
.L3236:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	MVC_Marking, .-MVC_Marking
	.align	2
	.global	MVC_DirectOutput
	.type	MVC_DirectOutput, %function
MVC_DirectOutput:
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
	add	r5, r0, #11141120
	mov	r4, r0
	add	r5, r5, #12288
	ldrb	r6, [r5, #1371]
	cmp	r6, #1
	beq	.L3262
	bcc	.L3263
	cmp	r6, #2
	beq	.L3264
	mov	r6, #0
.L3261:
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3264:
	ldr	r3, [r5, #1976]
	mov	r2, #3
	strb	r2, [r3, #664]
	ldrb	r2, [r5, #1369]
	cmp	r2, #0
	bne	.L3282
	ldr	r1, [r0, #520]
	cmp	r1, #0
	beq	.L3283
	bl	MVC_OutputFrmToVO
	ldr	r3, [r5, #1976]
	str	r3, [r4, #520]
	str	r3, [r3, #740]
	mov	r6, r0
.L3284:
	ldr	r3, [r4, #520]
	mov	r8, #2
	ldrb	r0, [r5, #1370]
	mov	r7, #0
	add	r1, r5, #1376
	mov	r2, #592
	add	r1, r1, #8
	strb	r0, [r3, #1]
	ldr	r3, [r4, #520]
	strb	r8, [r3, #2]
	ldr	r3, [r4, #520]
	strb	r7, [r3, #5]
	ldr	r3, [r4, #520]
	strb	r7, [r3, #7]
	ldr	r3, [r4, #520]
	strb	r7, [r3, #3]
	ldr	r3, [r4, #520]
	ldrb	r0, [r5, #1380]
	strb	r0, [r3]
	ldr	r3, [r4, #520]
	str	r7, [r3, #40]
	ldr	r0, [r4, #520]
	add	r0, r0, #72
	bl	memcpy
	ldr	r3, [r4, #520]
	ldr	r2, [r5, #2028]
	str	r2, [r3, #760]
	ldr	r3, [r4, #520]
	ldr	r2, [r3, #760]
	str	r2, [r3, #688]
	str	r2, [r3, #44]
	ldr	r3, [r4, #520]
	strb	r8, [r3, #736]
	ldrb	r2, [r5, #1375]
	ldr	r3, [r4, #520]
	cmp	r2, #1
	movne	r2, r7
	moveq	r2, r8
	strb	r2, [r3, #4]
.L3341:
	ldr	r3, [r4, #520]
	ldr	r2, [r5, #1996]
	str	r2, [r3, #32]
	ldr	r3, [r4, #520]
	ldr	r2, [r5, #2056]
	str	r2, [r3, #56]
	ldr	r3, [r4, #520]
	ldr	r2, [r5, #2060]
	str	r2, [r3, #60]
	ldrb	r8, [r4, #9]
	cmp	r8, #1
	bne	.L3261
	ldr	r3, [r4, #520]
	mov	r2, r7
	ldr	r0, [r4, #120]
	ldrsb	r1, [r3, #6]
	bl	FSP_SetRef
	mov	r2, r7
	ldr	r1, [r4, #520]
	mov	r0, r4
	bl	MVC_OutputFrmToVO
	ldr	r3, [r4, #520]
	cmp	r3, r7
	mov	r6, r0
	beq	.L3294
	ldr	r3, [r5, #1976]
	mov	r2, r8
	ldr	r0, [r4, #120]
	ldrsb	r1, [r3, #6]
	bl	FSP_ClearLogicFs
	b	.L3294
.L3263:
	ldr	r3, [r5, #1976]
	mov	r2, #0
	strb	r2, [r3, #664]
	ldr	r1, [r0, #520]
	cmp	r1, r2
	beq	.L3265
	bl	MVC_OutputFrmToVO
	cmp	r0, #0
	bne	.L3344
.L3266:
	ldr	r3, [r4, #520]
	cmp	r3, #0
	beq	.L3265
	ldr	r3, [r5, #1976]
	mov	r2, #1
	ldr	r0, [r4, #120]
	ldrsb	r1, [r3, #6]
	bl	FSP_ClearLogicFs
.L3265:
	ldr	r3, [r5, #1976]
	mov	r0, #3
	mov	r7, #0
	add	r1, r5, #1376
	add	r1, r1, #8
	mov	r2, #592
	str	r3, [r4, #520]
	str	r3, [r3, #668]
	ldr	r3, [r4, #520]
	ldr	ip, [r5, #1976]
	str	ip, [r3, #704]
	ldr	r3, [r4, #520]
	ldr	ip, [r5, #1976]
	str	ip, [r3, #740]
	ldrb	ip, [r5, #1370]
	ldr	r3, [r4, #520]
	strb	ip, [r3, #1]
	ldr	r3, [r4, #520]
	strb	r0, [r3, #2]
	ldr	r3, [r4, #520]
	strb	r7, [r3, #3]
	ldr	r3, [r4, #520]
	strb	r7, [r3, #5]
	ldr	r3, [r4, #520]
	strb	r7, [r3, #7]
	ldr	r0, [r4, #520]
	add	r0, r0, #72
	bl	memcpy
	ldr	r3, [r4, #520]
	ldr	r1, [r5, #2028]
	mov	r2, r7
	str	r1, [r3, #688]
	str	r1, [r3, #44]
	ldr	r3, [r4, #520]
	strb	r7, [r3, #664]
	ldr	r3, [r4, #520]
	ldrb	r1, [r5, #1380]
	strb	r1, [r3]
	ldr	r3, [r4, #520]
	ldrb	r1, [r5, #1377]
	str	r1, [r3, #40]
	ldrb	r1, [r5, #1375]
	ldr	r3, [r4, #520]
	cmp	r1, #1
	moveq	r6, #3
	strb	r6, [r3, #4]
	ldr	r3, [r4, #520]
	ldr	r1, [r5, #1996]
	str	r1, [r3, #32]
	ldr	r3, [r4, #520]
	ldr	r1, [r5, #2056]
	str	r1, [r3, #56]
	ldr	r3, [r4, #520]
	ldr	r1, [r5, #2060]
	str	r1, [r3, #60]
	ldr	r3, [r4, #520]
	ldr	r0, [r4, #120]
	ldrsb	r1, [r3, #6]
	bl	FSP_SetRef
	mov	r2, r7
	ldr	r1, [r4, #520]
	mov	r0, r4
	bl	MVC_OutputFrmToVO
	ldr	r3, [r4, #520]
	cmp	r3, r7
	mov	r6, r0
	beq	.L3294
.L3336:
	ldr	r3, [r5, #1976]
	mov	r2, #1
	ldr	r0, [r4, #120]
	ldrsb	r1, [r3, #6]
	bl	FSP_ClearLogicFs
.L3294:
	mov	r3, #0
	mov	r0, r6
	str	r3, [r4, #520]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3262:
	ldr	r3, [r5, #1976]
	mov	r2, #3
	strb	r2, [r3, #664]
	ldrb	r2, [r5, #1369]
	cmp	r2, #0
	bne	.L3270
	ldr	r1, [r0, #520]
	cmp	r1, #0
	beq	.L3271
	bl	MVC_OutputFrmToVO
	ldr	r3, [r5, #1976]
	str	r3, [r4, #520]
	str	r3, [r3, #704]
	mov	r6, r0
.L3272:
	ldr	r3, [r4, #520]
	mov	r8, #1
	ldrb	r0, [r5, #1370]
	mov	r7, #0
	add	r1, r5, #1376
	mov	r2, #592
	add	r1, r1, #8
	strb	r0, [r3, #1]
	ldr	r3, [r4, #520]
	strb	r8, [r3, #2]
	ldr	r3, [r4, #520]
	strb	r7, [r3, #5]
	ldr	r3, [r4, #520]
	strb	r7, [r3, #7]
	ldr	r3, [r4, #520]
	strb	r7, [r3, #3]
	ldr	r3, [r4, #520]
	ldrb	r0, [r5, #1380]
	strb	r0, [r3]
	ldr	r3, [r4, #520]
	str	r7, [r3, #40]
	ldr	r0, [r4, #520]
	add	r0, r0, #72
	bl	memcpy
	ldr	r3, [r4, #520]
	ldr	r2, [r5, #2028]
	str	r2, [r3, #724]
	ldr	r3, [r4, #520]
	ldr	r2, [r3, #724]
	str	r2, [r3, #688]
	str	r2, [r3, #44]
	ldr	r3, [r4, #520]
	strb	r8, [r3, #700]
	ldrb	r3, [r5, #1375]
	ldr	r2, [r4, #520]
	rsb	r3, r8, r3
	clz	r3, r3
	mov	r3, r3, lsr #5
	strb	r3, [r2, #4]
	b	.L3341
.L3282:
	ldr	r3, [r0, #520]
	add	r1, r5, #1376
	add	r1, r1, #8
	mov	r2, #592
	cmp	r3, #0
	ldreq	r3, [r5, #1976]
	streq	r3, [r0, #520]
	streq	r3, [r3, #740]
	ldreq	r3, [r0, #520]
	add	ip, r3, #656
	add	r0, r3, #72
	ldr	r10, [r3, #640]
	ldrd	r8, [ip, #-8]
	ldrd	r6, [ip]
	ldr	ip, [r3, #644]
	str	ip, [fp, #-48]
	bl	memcpy
	movw	r3, #14240
	ldr	ip, [fp, #-48]
	mov	r1, r3
	movt	r3, 170
	add	r3, r4, r3
	movt	r1, 170
	ldr	r1, [r4, r1]
	and	r2, r10, ip
	ldr	r3, [r3, #4]
	movw	r0, #14256
	movt	r0, 170
	and	r1, r1, r3
	adds	r3, r2, #1
	movne	r3, #1
	cmn	r1, #1
	movne	r3, #0
	cmp	r3, #0
	ldrne	r3, [r4, #520]
	strne	ip, [r3, #644]
	mov	ip, #2
	strne	r10, [r3, #640]
	movw	r3, #14256
	movt	r3, 170
	add	r3, r4, r3
	ldr	r1, [r4, #520]
	ldrd	r2, [r3, #-8]
	add	r1, r1, #656
	cmp	r3, r9
	cmpeq	r2, r8
	movhi	r2, r8
	movhi	r3, r9
	strd	r2, [r1, #-8]
	ldrd	r0, [r0, r4]
	ldr	r3, [r4, #520]
	cmp	r1, r7
	cmpeq	r0, r6
	add	r3, r3, #656
	movhi	r0, r6
	movhi	r1, r7
	strd	r0, [r3]
	mov	r0, #3
	ldr	r2, [r4, #520]
	ldrb	r3, [r2, #1]
	cmp	r3, #0
	ldrneb	r3, [r5, #1370]
	strb	r3, [r2, #1]
	ldr	r2, [r4, #520]
	ldrb	r3, [r2, #2]
	orr	r3, r3, ip
	strb	r3, [r2, #2]
	ldr	r2, [r4, #520]
	ldrb	r1, [r5, #1380]
	ldrb	r3, [r2]
	cmp	r3, r1
	movcc	r3, r1
	strb	r3, [r2]
	ldr	r3, [r4, #520]
	strb	ip, [r3, #736]
	ldr	r3, [r4, #520]
	strb	r0, [r3, #664]
	ldr	r3, [r4, #520]
	ldr	r2, [r5, #2028]
	str	r2, [r3, #760]
	ldr	r2, [r4, #520]
	ldr	r3, [r2, #760]
	ldr	r1, [r2, #724]
	add	r3, r3, r1
	mov	r3, r3, lsr #1
	str	r3, [r2, #688]
	ldr	r3, [r4, #520]
	ldr	r2, [r3, #688]
	str	r2, [r3, #44]
	ldr	r3, [r4, #520]
	ldr	r2, [r3, #740]
	str	r2, [r3, #668]
	ldrb	r3, [r5, #1375]
	cmp	r3, #1
	ldr	r3, [r4, #520]
	ldrb	r2, [r3, #4]
	beq	.L3342
.L3293:
	strb	r2, [r3, #4]
	mov	r2, #0
	ldr	r3, [r4, #520]
	ldr	r1, [r5, #1996]
	str	r1, [r3, #32]
	ldr	r3, [r4, #520]
	ldr	r0, [r4, #120]
	ldrsb	r1, [r3, #6]
	bl	FSP_SetRef
	mov	r2, #0
	ldr	r1, [r4, #520]
	mov	r0, r4
	bl	MVC_OutputFrmToVO
	ldr	r3, [r4, #520]
	cmp	r3, #0
	mov	r6, r0
	bne	.L3336
	b	.L3294
.L3270:
	ldr	r3, [r0, #520]
	add	r1, r5, #1376
	add	r1, r1, #8
	mov	r2, #592
	cmp	r3, #0
	ldreq	r3, [r5, #1976]
	streq	r3, [r0, #520]
	streq	r3, [r3, #704]
	ldreq	r3, [r0, #520]
	add	ip, r3, #656
	add	r0, r3, #72
	ldr	r10, [r3, #640]
	ldrd	r8, [ip, #-8]
	ldrd	r6, [ip]
	ldr	ip, [r3, #644]
	str	ip, [fp, #-48]
	bl	memcpy
	movw	r3, #14240
	ldr	ip, [fp, #-48]
	mov	r1, r3
	movt	r3, 170
	add	r3, r4, r3
	movt	r1, 170
	ldr	r1, [r4, r1]
	and	r2, r10, ip
	ldr	r3, [r3, #4]
	movw	r0, #14256
	movt	r0, 170
	and	r1, r1, r3
	adds	r3, r2, #1
	movne	r3, #1
	cmn	r1, #1
	movne	r3, #0
	cmp	r3, #0
	ldrne	r3, [r4, #520]
	strne	ip, [r3, #644]
	mov	ip, #1
	strne	r10, [r3, #640]
	movw	r3, #14256
	movt	r3, 170
	add	r3, r4, r3
	ldr	r1, [r4, #520]
	ldrd	r2, [r3, #-8]
	add	r1, r1, #656
	cmp	r3, r9
	cmpeq	r2, r8
	movhi	r2, r8
	movhi	r3, r9
	strd	r2, [r1, #-8]
	ldrd	r0, [r0, r4]
	ldr	r3, [r4, #520]
	cmp	r1, r7
	cmpeq	r0, r6
	add	r3, r3, #656
	movhi	r0, r6
	movhi	r1, r7
	strd	r0, [r3]
	mov	r0, #3
	ldr	r2, [r4, #520]
	ldrb	r3, [r2, #1]
	cmp	r3, #0
	ldrneb	r3, [r5, #1370]
	strb	r3, [r2, #1]
	ldr	r2, [r4, #520]
	ldrb	r3, [r2, #2]
	orr	r3, r3, ip
	strb	r3, [r2, #2]
	ldr	r2, [r4, #520]
	ldrb	r1, [r5, #1380]
	ldrb	r3, [r2]
	cmp	r3, r1
	movcc	r3, r1
	strb	r3, [r2]
	ldr	r3, [r4, #520]
	strb	ip, [r3, #700]
	ldr	r3, [r4, #520]
	strb	r0, [r3, #664]
	ldr	r3, [r4, #520]
	ldr	r2, [r5, #2028]
	str	r2, [r3, #724]
	ldr	r2, [r4, #520]
	ldr	r3, [r2, #760]
	ldr	r1, [r2, #724]
	add	r3, r3, r1
	mov	r3, r3, lsr ip
	str	r3, [r2, #688]
	ldr	r3, [r4, #520]
	ldr	r2, [r3, #688]
	str	r2, [r3, #44]
	ldr	r3, [r4, #520]
	ldr	r2, [r3, #704]
	str	r2, [r3, #668]
	ldrb	r3, [r5, #1375]
	cmp	r3, ip
	ldr	r3, [r4, #520]
	ldrb	r2, [r3, #4]
	bne	.L3293
.L3342:
	orr	r2, r2, ip
	b	.L3293
.L3344:
	str	r0, [sp]
	movw	r3, #2548
	ldr	r2, .L3345
	mov	r0, #22
	ldr	r1, .L3345+4
	bl	dprint_vfmw
	b	.L3266
.L3283:
	ldr	r3, [r5, #1976]
	mov	r6, r1
	str	r3, [r0, #520]
	str	r3, [r3, #740]
	b	.L3284
.L3271:
	ldr	r3, [r5, #1976]
	mov	r6, r1
	str	r3, [r0, #520]
	str	r3, [r3, #704]
	b	.L3272
.L3346:
	.align	2
.L3345:
	.word	.LANCHOR0+248
	.word	.LC401
	.fnend
	.size	MVC_DirectOutput, .-MVC_DirectOutput
	.align	2
	.global	MVC_DEC_GetRemainImg
	.type	MVC_DEC_GetRemainImg, %function
MVC_DEC_GetRemainImg:
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
	add	r6, r0, #11075584
	mov	r5, r0
	add	r6, r6, #45056
	ldr	r3, [r6, #2728]
	cmp	r3, #0
	beq	.L3361
	movw	r8, #47588
	mov	r4, #0
	movt	r8, 169
	add	r8, r0, r8
	mov	r7, r4
	mov	r9, r8
	b	.L3350
.L3349:
	ldr	r3, [r6, #2728]
	cmp	r3, r7
	bls	.L3388
.L3350:
	ldr	r3, [r9, #4]!
	add	r7, r7, #1
	cmp	r3, #0
	beq	.L3349
	ldrb	r2, [r3, #5]
	cmp	r2, #0
	beq	.L3349
	ldrsb	r1, [r3, #6]
	ldr	r0, [r5, #120]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	beq	.L3349
	ldrb	r3, [r0, #1]
	sub	r3, r3, #1
	cmp	r3, #1
	ldr	r3, [r6, #2728]
	addls	r4, r4, #1
	cmp	r3, r7
	bhi	.L3350
.L3388:
	cmp	r4, #0
	beq	.L3351
	mvn	r7, #0
	b	.L3354
.L3352:
	ldr	r1, [r5, r3, asl #2]
	bl	MVC_OutputFrmToVO
	subs	r4, r4, #1
	mov	r7, r0
	beq	.L3386
.L3354:
	sub	r3, fp, #44
	sub	r2, fp, #40
	mvn	r1, #0
	mov	r0, r5
	bl	MVC_GetMinPOC
	ldr	r1, [fp, #-44]
	movw	r3, #28282
	mov	r2, r4
	cmn	r1, #1
	movt	r3, 42
	mov	r0, r5
	add	r3, r1, r3
	bne	.L3352
.L3386:
	ldr	r3, [r6, #2728]
	cmp	r3, #0
	beq	.L3348
.L3353:
	mov	r4, #0
	b	.L3357
.L3356:
	ldr	r3, [r6, #2728]
	cmp	r3, r4
	bls	.L3348
.L3357:
	ldr	r1, [r8, #4]!
	add	r4, r4, #1
	cmp	r1, #0
	beq	.L3356
	ldrb	r3, [r1, #3]
	cmp	r3, #0
	beq	.L3356
	mov	r0, r5
	bl	MVC_UnMarkFrameStoreRef
	ldr	r3, [r6, #2728]
	cmp	r3, r4
	bhi	.L3357
.L3348:
	mvn	r1, #0
	mov	r0, r5
	bl	MVC_RemoveUnUsedFrameStore
	cmp	r7, #0
	bne	.L3359
	mov	r0, r7
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L3351:
	cmp	r3, #0
	mvnne	r7, #0
	bne	.L3353
	mvn	r1, #0
	mov	r0, r5
	bl	MVC_RemoveUnUsedFrameStore
.L3359:
	add	r0, r5, #584
	bl	GetVoLastImageID
	mov	r7, r0
	mov	r0, r7
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L3361:
	mvn	r7, #0
	b	.L3348
	.fnend
	.size	MVC_DEC_GetRemainImg, .-MVC_DEC_GetRemainImg
	.align	2
	.global	MVC_InitDPB
	.type	MVC_InitDPB, %function
MVC_InitDPB:
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
	subs	r4, r0, #0
	beq	.L3406
	bl	MVC_ClearAllSlice
	movw	r7, #47592
	movw	r6, #47720
	movw	r5, #47656
	movt	r7, 169
	movt	r6, 169
	movt	r5, 169
	mov	r8, #0
	add	r7, r4, r7
	add	r6, r4, r6
	add	r5, r4, r5
	mov	r9, r8
.L3394:
	ldr	r3, [r7]
	mov	r2, #1
	add	r8, r8, r2
	cmp	r3, #0
	beq	.L3391
	ldrsb	r1, [r3, #6]
	ldr	r0, [r4, #120]
	bl	FSP_ClearLogicFs
.L3391:
	ldr	r3, [r5]
	mov	r2, #1
	cmp	r3, #0
	beq	.L3392
	ldrsb	r1, [r3, #6]
	ldr	r0, [r4, #120]
	bl	FSP_ClearLogicFs
.L3392:
	ldr	r3, [r6]
	mov	r2, #1
	cmp	r3, #0
	beq	.L3393
	ldrsb	r1, [r3, #6]
	ldr	r0, [r4, #120]
	bl	FSP_ClearLogicFs
.L3393:
	cmp	r8, #16
	str	r9, [r6], #4
	mov	r2, #0
	str	r9, [r5], #4
	str	r9, [r7], #4
	bne	.L3394
	ldr	r3, [r4, #44]
	add	r5, r4, #11075584
	add	r6, r5, #45056
	str	r3, [r6, #2728]
	str	r2, [r6, #2732]
	str	r2, [r6, #2736]
	str	r2, [r6, #2740]
	str	r2, [r6, #2744]
	ldr	r1, [r4, #520]
	cmp	r1, r2
	beq	.L3396
	ldrb	r3, [r4, #8]
	cmp	r3, #2
	beq	.L3397
.L3401:
	add	r3, r4, #11141120
	add	r3, r3, #12288
	ldr	r3, [r3, #1976]
	cmp	r3, #0
	beq	.L3399
	ldrsb	r1, [r3, #6]
	mov	r2, #1
	ldr	r0, [r4, #120]
	bl	FSP_ClearLogicFs
.L3399:
	mov	r3, #0
	str	r3, [r4, #520]
.L3396:
	ldr	r3, .L3424
	movw	r0, #47804
	mov	r2, #344
	mov	r1, #0
	movt	r0, 169
	add	r0, r4, r0
	ldr	r3, [r3, #48]
	blx	r3
	ldr	ip, [r6, #2728]
	mov	r0, #0
	add	r3, r4, #144
	add	r1, r4, #216
	mov	r2, r0
	str	ip, [r6, #2956]
	str	r0, [r6, #2960]
.L3403:
	str	r2, [r3, #4]!
	cmp	r3, r1
	bne	.L3403
	add	r2, r4, #252
	add	r3, r4, #384
	mov	r0, #0
.L3404:
	str	r0, [r2, #4]!
	cmp	r2, r3
	mov	r1, #0
	bne	.L3404
	add	r2, r5, #40960
	add	r4, r4, #516
	mov	r0, r1
	str	r1, [r2, #920]
.L3405:
	str	r0, [r3, #4]!
	cmp	r3, r4
	mov	r2, #0
	bne	.L3405
	add	r5, r5, #40960
	mov	r0, r2
	str	r2, [r5, #924]
.L3390:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L3397:
	mov	r0, r4
	bl	MVC_OutputFrmToVO
	cmp	r0, #0
	bne	.L3423
.L3400:
	ldr	r3, [r4, #520]
	cmp	r3, #0
	bne	.L3401
	b	.L3396
.L3423:
	str	r0, [sp]
	movw	r3, #5955
	ldr	r2, .L3424+4
	mov	r0, #22
	ldr	r1, .L3424+8
	bl	dprint_vfmw
	b	.L3400
.L3406:
	mvn	r0, #0
	b	.L3390
.L3425:
	.align	2
.L3424:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0+268
	.word	.LC402
	.fnend
	.size	MVC_InitDPB, .-MVC_InitDPB
	.align	2
	.global	MVC_ClearDPB
	.type	MVC_ClearDPB, %function
MVC_ClearDPB:
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
	bl	MVC_FlushDPB
	cmp	r0, #0
	bne	.L3435
.L3427:
	mov	r0, r4
	bl	MVC_InitDPB
	cmp	r0, #0
	beq	.L3428
	movw	r3, #369
	ldr	r2, .L3436
	ldr	r1, .L3436+4
	mov	r0, #22
	bl	dprint_vfmw
.L3428:
	mov	r0, #0
	strb	r0, [r4, #6]
	str	r0, [r4, #220]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L3435:
	mov	r3, #364
	ldr	r2, .L3436
	ldr	r1, .L3436+8
	mov	r0, #22
	bl	dprint_vfmw
	b	.L3427
.L3437:
	.align	2
.L3436:
	.word	.LANCHOR0+280
	.word	.LC404
	.word	.LC403
	.fnend
	.size	MVC_ClearDPB, .-MVC_ClearDPB
	.align	2
	.global	MVC_DecVDM
	.type	MVC_DecVDM, %function
MVC_DecVDM:
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
	add	r6, r0, #11141120
	mov	r4, r0
	add	r5, r6, #12288
	ldrb	r3, [r5, #1371]
	cmp	r3, #0
	beq	.L3439
	ldrb	r3, [r5, #1369]
	cmp	r3, #1
	beq	.L3439
.L3440:
	ldr	r3, [r4, #108]
	ldrb	r2, [r4, #8]
	ubfx	r7, r3, #16, #2
	cmp	r7, r2
	beq	.L3441
	sub	r2, r2, #2
	cmp	r2, #1
	cmpls	r7, #1
	bls	.L3498
.L3441:
	uxtb	r3, r7
	strb	r3, [r4, #8]
	cmp	r3, #2
	beq	.L3444
	cmp	r3, #3
	beq	.L3445
	cmp	r3, #1
	beq	.L3499
	ldrb	r3, [r4, #11]
	cmp	r3, #1
	beq	.L3500
.L3452:
	ldr	r3, [r4, #64]
.L3448:
	ldrb	r2, [r5, #1381]
	strb	r2, [r4, #11]
.L3453:
	cmp	r3, #0
	beq	.L3496
	ldrb	r3, [r5, #1380]
	cmp	r3, #2
	beq	.L3501
	cmp	r3, #1
	bne	.L3456
	ldr	r2, [r5, #2056]
	cmp	r2, #0
	streqb	r3, [r4, #7]
.L3456:
	ldr	r2, [r4, #88]
	mov	r0, #2
	ldrb	r3, [r5, #1371]
	sub	r2, r2, #1
	ldr	r1, .L3504
	bl	dprint_vfmw
	ldr	r2, [r5, #2044]
	add	r3, r6, #16384
	mov	r1, #1
	str	r2, [r3, #44]
	ldr	r2, [r5, #2048]
	strb	r1, [r5, #3338]
	str	r2, [r3, #40]
	ldr	r2, [r4, #64]
	str	r2, [r3, #244]
	ldr	r0, [r4, #88]
	cmp	r0, #0
	beq	.L3493
	ldrb	r1, [r5, #1380]
	cmp	r1, #0
	bne	.L3457
	ldr	r2, .L3504+4
	ldr	ip, [r2]
	cmp	ip, #0
	beq	.L3458
	ldr	r2, [r3, #248]
	cmp	r2, #0
	beq	.L3467
.L3460:
	ldr	r3, [r2, #8]
	ldr	r0, [r2, #12]
	ldr	r2, [r2, #4056]
	add	r3, r3, r0
	add	r3, r3, #7
	cmp	r2, #0
	add	r1, r1, r3, lsr #3
	bne	.L3460
.L3459:
	sub	r2, fp, #28
	mov	r3, #4
	ldr	r0, [r4, #120]
	str	r1, [r2, #-4]!
	mov	r1, #20
	blx	ip
	ldr	r2, [r4, #224]
.L3461:
	movw	r3, #15624
	movt	r3, 170
	add	r3, r4, r3
	str	r3, [r4, #228]
	ldr	r1, [r2, #856]
	cmp	r1, #1
	beq	.L3502
	cmp	r1, #2
	beq	.L3503
.L3464:
	ldr	r3, [r2, #588]
	add	r6, r6, #16384
	mov	r0, #0
	str	r3, [r6, #508]
	ldr	r3, [r2, #624]
	str	r3, [r6, #512]
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3439:
	ldr	r3, [r4, #140]
	ldr	r2, [r4, #144]
	add	r3, r3, #1
	ldr	r1, [r4, #224]
	cmp	r3, r2
	movlt	r3, r2
	str	r3, [r4, #140]
	rsb	r3, r2, r3
	str	r3, [r1, #572]
	b	.L3440
.L3498:
	mov	r2, r7
	ldr	r1, .L3504+8
	mov	r0, #2
	bl	dprint_vfmw
	strb	r7, [r4, #8]
.L3445:
	mov	r0, r4
	bl	MVC_ClearCurrPic
	mov	r0, r4
	mvn	r1, #0
	bl	MVC_ClearDPB
	mvn	r0, #0
.L3493:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3499:
	ldrb	r3, [r5, #1380]
	cmp	r3, #2
	bne	.L3452
	ldr	r3, [r5, #1992]
	cmp	r3, #0
	beq	.L3449
	ldrb	r3, [r4, #11]
	cmp	r3, #1
	bne	.L3452
.L3465:
	ldrb	r2, [r5, #1381]
	ldr	r3, [r4, #64]
	strb	r2, [r4, #11]
	b	.L3453
.L3444:
	ldrb	r3, [r5, #1380]
	cmp	r3, #0
	bne	.L3449
	ldr	r3, [r4, #64]
	cmp	r3, #0
	beq	.L3448
	ldr	r2, [r4, #544]
	ldr	r2, [r2, #48]
	cmp	r2, #0
	beq	.L3448
.L3449:
	mov	r3, #1
	mov	r0, r4
	strb	r3, [r5, #1375]
	bl	MVC_ClearCurrPic
	mvn	r0, #0
	b	.L3493
.L3457:
	add	r3, r4, #11075584
	add	r3, r3, #45056
	ldr	r3, [r3, #2732]
	cmp	r3, #0
	bne	.L3458
	ldr	r2, [r4, #224]
	ldr	r3, [r2, #12]
	cmp	r3, #2
	beq	.L3461
.L3496:
	mov	r0, r4
	bl	MVC_ClearCurrPic
	mvn	r0, #0
	b	.L3493
.L3500:
	ldrb	r3, [r5, #1380]
	cmp	r3, #2
	bne	.L3452
	b	.L3465
.L3501:
	ldrb	r3, [r4, #7]
	cmp	r3, #2
	bne	.L3456
	ldr	r3, [r4, #224]
	ldr	r7, [r3, #12]
	cmp	r7, #0
	bne	.L3456
	ldr	r3, [r5, #1992]
	mov	r0, #1
	ldr	r2, [r5, #1996]
	ldr	r1, .L3504+12
	bl	dprint_vfmw
	mov	r0, r4
	bl	MVC_ClearCurrPic
	ldr	r3, [r5, #1976]
	ldr	r0, [r4, #120]
	mov	r2, r7
	ldrsb	r1, [r3, #6]
	bl	FSP_SetDisplay
	mvn	r0, #0
	b	.L3493
.L3458:
	ldr	r2, [r4, #224]
	b	.L3461
.L3502:
	cmp	r3, #0
	beq	.L3464
	ldrb	r3, [r5, #1380]
	cmp	r3, #2
	bne	.L3464
	mov	r2, #0
	str	r2, [r4, #228]
	ldr	r3, [r5, #1976]
	ldr	r0, [r4, #120]
	ldrsb	r1, [r3, #6]
	bl	FSP_SetDisplay
	b	.L3496
.L3503:
	ldr	r1, [r2, #860]
	cmp	r3, #0
	cmpne	r1, #0
	ble	.L3464
	ldrb	r3, [r5, #1380]
	cmp	r3, #2
	bne	.L3464
	mov	r2, #0
	str	r2, [r4, #228]
	ldr	r3, [r5, #1976]
	ldr	r0, [r4, #120]
	ldrsb	r1, [r3, #6]
	bl	FSP_SetDisplay
	ldr	r2, [r4, #224]
	mov	r0, r4
	ldr	r3, [r2, #860]
	sub	r3, r3, #1
	str	r3, [r2, #860]
	bl	MVC_ClearCurrPic
	mvn	r0, #0
	b	.L3493
.L3467:
	mov	r1, r2
	b	.L3459
.L3505:
	.align	2
.L3504:
	.word	.LC407
	.word	g_event_report
	.word	.LC405
	.word	.LC406
	.fnend
	.size	MVC_DecVDM, .-MVC_DecVDM
	.align	2
	.global	MVC_FlushDecoder
	.type	MVC_FlushDecoder, %function
MVC_FlushDecoder:
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
	add	r3, r0, #11075584
	add	r3, r3, #40960
	mov	r1, #1
	mov	ip, #0
	strb	r1, [r3, #877]
	str	ip, [r3, #928]
	strb	r1, [r0]
	bl	MVC_DecVDM
	cmp	r0, #0
	ldmeqfd	sp, {fp, sp, pc}
	movw	r3, #12991
	ldr	r2, .L3511
	ldr	r1, .L3511+4
	mov	r0, #22
	bl	dprint_vfmw
	ldmfd	sp, {fp, sp, pc}
.L3512:
	.align	2
.L3511:
	.word	.LANCHOR0+296
	.word	.LC408
	.fnend
	.size	MVC_FlushDecoder, .-MVC_FlushDecoder
	.align	2
	.global	MVC_ReceivePacket
	.type	MVC_ReceivePacket, %function
MVC_ReceivePacket:
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
	ldr	ip, [r1, #12]
	mov	r4, r0
	ldr	r3, [r1, #8]
	mov	r5, r1
	ldr	r2, [r1, #4]
	mov	r0, #7
	add	r6, r4, #11141120
	ldr	r1, .L3576
	str	ip, [sp]
	bl	dprint_vfmw
	add	r3, r6, #16384
	mov	r2, #0
	str	r2, [r3, #520]
	ldr	r3, [r4, #224]
	ldr	r2, [r3, #824]
	cmp	r2, #1
	beq	.L3571
.L3514:
	ldr	r3, [r4, #232]
	cmp	r3, #0
	beq	.L3534
	ldrb	r2, [r5]
	cmp	r2, #1
	beq	.L3572
.L3517:
	ldr	r1, .L3576+4
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r1, [r4, #232]
	cmp	r1, #0
	beq	.L3534
	ldr	r0, [r4, #120]
	bl	MVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #232]
.L3534:
	ldr	r3, [r5, #12]
	cmp	r3, #0
	ble	.L3521
	ldr	r3, [r5, #4]
	cmp	r3, #0
	beq	.L3521
	ldr	r3, [r5, #8]
	cmp	r3, #0
	beq	.L3521
	ldrb	r3, [r4, #937]
	cmp	r3, #0
	beq	.L3537
	mov	r2, r4
	mov	r3, #1
	b	.L3524
.L3523:
	add	r3, r3, #1
	cmp	r3, #137
	beq	.L3535
.L3524:
	ldrb	r1, [r2, #1025]
	add	r2, r2, #88
	cmp	r1, #0
	bne	.L3523
	mov	r1, r3
.L3522:
	mov	r2, #88
	cmn	r1, #1
	mla	r3, r2, r3, r4
	mov	r0, #1
	strb	r0, [r3, #937]
	beq	.L3535
	mul	r3, r2, r1
	mov	r1, #0
	add	r2, r3, #936
	add	r3, r4, r3
	add	r2, r4, r2
	str	r2, [r4, #232]
	ldr	r2, [r5, #4]
	str	r2, [r3, #944]
	ldr	r2, [r5, #12]
	str	r2, [r3, #948]
	ldr	r2, [r5, #8]
	str	r2, [r3, #952]
	ldr	r3, [r4, #232]
	str	r1, [r3, #24]
	ldr	r3, [r4, #232]
	ldr	r2, [r5, #16]
	str	r2, [r3, #32]
	ldrd	r2, [r5, #24]
	ldr	ip, [r4, #232]
	strd	r2, [ip, #80]
	ldr	r3, [r4, #232]
	str	r0, [r3, #68]
	ldr	r3, [r4, #232]
	strb	r1, [r3]
	ldr	r3, [r4, #232]
	ldrb	r2, [r5]
	strb	r2, [r3, #3]
	ldr	r3, [r4, #232]
	b	.L3527
.L3572:
	ldr	r1, [r3, #68]
	cmp	r1, #1
	bhi	.L3517
	ldrb	r1, [r3, #3]
	cmp	r1, #1
	bne	.L3518
	b	.L3517
.L3571:
	ldr	r3, [r3, #864]
	cmp	r3, #0
	beq	.L3514
	ldr	r3, [r4, #232]
	cmp	r3, #0
	ldrneb	r2, [r5]
	beq	.L3534
.L3518:
	strb	r2, [r3, #3]
	ldr	r3, [r4, #224]
	ldr	r2, [r3, #824]
	cmp	r2, #1
	beq	.L3573
.L3529:
	ldr	r3, [r5, #12]
	cmp	r3, #0
	ble	.L3530
	ldr	r2, [r5, #4]
	cmp	r2, #0
	beq	.L3530
	ldr	r3, [r5, #8]
	cmp	r3, #0
	beq	.L3530
	ldr	r3, [r4, #232]
	ldr	r1, [r3, #68]
	cmp	r1, #1
	bls	.L3574
.L3531:
	mov	r2, #1
	strb	r2, [r3, #3]
	ldr	r1, [r5, #16]
	ldr	r0, [r4, #120]
	bl	SM_ReleaseStreamSeg
	ldr	r3, .L3576+8
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L3568
	mov	r3, #0
	mov	r1, #113
	mov	r2, r3
	ldr	r0, [r4, #120]
	blx	ip
.L3568:
	ldr	r3, [r4, #232]
.L3527:
	ldrb	r0, [r3, #3]
	clz	r0, r0
	mov	r0, r0, lsr #5
	rsb	r0, r0, #0
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L3521:
	ldr	r1, .L3576+12
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r1, [r5, #16]
	ldr	r0, [r4, #120]
	bl	SM_ReleaseStreamSeg
	ldr	r3, .L3576+8
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L3570
.L3569:
	mov	r3, #0
	ldr	r0, [r4, #120]
	mov	r2, r3
	mov	r1, #113
	blx	ip
.L3570:
	mvn	r0, #0
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L3530:
	ldr	r3, [r4, #232]
	b	.L3531
.L3573:
	ldr	r3, [r3, #864]
	cmp	r3, #0
	bne	.L3568
	b	.L3529
.L3574:
	mov	ip, r1, asl #5
	mov	r0, #0
	sub	r1, ip, r1, asl #2
	add	r3, r3, r1
	str	r2, [r3, #8]
	ldr	r3, [r4, #232]
	ldr	ip, [r5, #12]
	ldr	r1, [r3, #68]
	mov	r2, r1, asl #5
	sub	r2, r2, r1, asl #2
	add	r3, r3, r2
	str	ip, [r3, #12]
	ldr	r3, [r4, #232]
	ldr	ip, [r5, #8]
	ldr	r1, [r3, #68]
	mov	r2, r1, asl #5
	sub	r2, r2, r1, asl #2
	add	r3, r3, r2
	str	ip, [r3, #16]
	ldr	r3, [r4, #232]
	ldr	r1, [r3, #68]
	mov	r2, r1, asl #5
	sub	r2, r2, r1, asl #2
	add	r3, r3, r2
	str	r0, [r3, #24]
	ldr	r3, [r4, #232]
	ldr	r0, [r5, #16]
	ldr	r1, [r3, #68]
	mov	r2, r1, asl #5
	sub	r2, r2, r1, asl #2
	add	r3, r3, r2
	str	r0, [r3, #32]
	ldr	r2, [r4, #232]
	ldr	r3, [r2, #68]
	add	r3, r3, #1
	str	r3, [r2, #68]
	ldr	r3, [r4, #232]
	ldr	r2, [r3, #12]
	cmp	r2, #4096
	bcc	.L3575
.L3532:
	add	r6, r6, #16384
	mov	r2, #1
	str	r2, [r6, #520]
	b	.L3527
.L3575:
	mov	r0, r4
	bl	MVC_CombinePacket.part.12
	ldr	r3, [r4, #232]
	b	.L3532
.L3535:
	ldr	r1, .L3576+16
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, r4
	bl	MVC_ClearAllNal
	mov	r0, r4
	bl	MVC_ClearCurrPic
	mvn	r1, #0
	mov	r0, r4
	bl	MVC_ClearDPB
	ldr	r3, .L3576+8
	ldr	ip, [r3]
	cmp	ip, #0
	bne	.L3569
	b	.L3570
.L3537:
	mov	r1, r3
	b	.L3522
.L3577:
	.align	2
.L3576:
	.word	.LC409
	.word	.LC410
	.word	g_event_report
	.word	.LC412
	.word	.LC411
	.fnend
	.size	MVC_ReceivePacket, .-MVC_ReceivePacket
	.align	2
	.global	MVC_ClearAll
	.type	MVC_ClearAll, %function
MVC_ClearAll:
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
	mov	r8, r0
	mov	r4, r1
	mov	r0, #22
	ldr	r1, .L3611
	bl	dprint_vfmw
	mov	r0, r8
	bl	MVC_ClearCurrPic
	mov	r0, r8
	bl	MVC_ClearAllNal
	mov	r0, r8
	bl	MVC_InitDPB
	cmp	r0, #0
	bne	.L3608
.L3579:
	cmp	r4, #0
	beq	.L3580
	add	r1, r8, #584
	ldr	r0, [r8, #120]
	bl	FSP_ClearNotInVoQueue
.L3581:
	movw	r4, #48152
	mov	r10, #0
	movt	r4, 169
	add	r4, r8, r4
	mov	r6, #0
	mov	r7, #0
.L3584:
	add	r5, r4, #592
	add	r9, r4, #624
	mov	r3, #0
	mov	r2, #1
	mvn	lr, #0
	mov	ip, #18
	mov	r0, #16
	mov	r1, #2
	str	r10, [r4, #228]
	str	r4, [r4, #740]
	str	r4, [r4, #704]
	str	r4, [r4, #668]
	strb	r3, [r4, #1]
	strb	r3, [r4, #2]
	strb	r3, [r4, #3]
	str	r3, [r4, #28]
	str	r3, [r4, #20]
	str	r3, [r4, #32]
	strb	r3, [r4, #5]
	strb	r3, [r4, #664]
	str	lr, [r4, #24]
	strb	r2, [r4, #7]
	strb	r2, [r4, #700]
	str	ip, [r4, #48]
	str	r0, [r4, #52]
	strb	r1, [r4, #736]
.L3583:
	ldrd	r2, [r5, #8]!
	orrs	r1, r2, r3
	bne	.L3609
.L3582:
	cmp	r5, r9
	bne	.L3583
	add	r10, r10, #1
	add	r4, r4, #776
	cmp	r10, #40
	bne	.L3584
	movw	r4, #14192
	movw	r5, #14224
	movt	r4, 170
	movt	r5, 170
	add	r4, r8, r4
	add	r5, r8, r5
	mov	r6, #0
	mov	r7, #0
.L3586:
	ldrd	r2, [r4, #8]!
	orrs	r1, r2, r3
	bne	.L3610
.L3585:
	cmp	r4, r5
	bne	.L3586
	ldr	r3, [r8, #60]
	cmp	r3, #0
	beq	.L3590
	mov	r4, #0
	add	r5, r8, #524
	mov	r6, r4
.L3589:
	ldr	r1, [r5, #4]!
	add	r4, r4, #1
	cmp	r1, #0
	beq	.L3588
	ldr	r0, [r8, #120]
	bl	FreeUsdByDec
	str	r6, [r5]
.L3588:
	ldr	r3, [r8, #60]
	cmp	r3, r4
	bhi	.L3589
.L3590:
	add	r5, r8, #11075584
	ldr	ip, .L3611+4
	movw	r0, #41832
	mov	r4, #0
	add	r3, r5, #45056
	strb	r4, [r8, #4]
	strb	r4, [r8, #9]
	add	r5, r5, #40960
	strb	r4, [r8, #6]
	movt	r0, 169
	strb	r4, [r8, #7]
	add	r0, r8, r0
	strb	r4, [r8, #3]
	mov	r1, r4
	str	r4, [r8, #60]
	movw	r2, #1656
	str	r4, [r8, #64]
	str	r4, [r8, #104]
	str	r4, [r8, #220]
	str	r4, [r8, #232]
	add	r8, r8, #11141120
	add	r8, r8, #12288
	strb	r4, [r3, #484]
	ldr	ip, [ip, #48]
	strb	r4, [r5, #2576]
	strb	r4, [r3, #485]
	strb	r4, [r5, #2577]
	blx	ip
	mov	r2, #2
	mov	r3, #1
	strb	r2, [r5, #872]
	strb	r3, [r5, #877]
	mov	r0, r4
	mov	r3, #256
	strb	r4, [r8, #1368]
	strb	r4, [r8, #2760]
	str	r4, [r8, #2764]
	str	r3, [r8, #2768]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3609:
	mov	r1, r2
	ldr	r0, [r8, #120]
	bl	FreeUsdByDec
	strd	r6, [r5]
	b	.L3582
.L3610:
	mov	r1, r2
	ldr	r0, [r8, #120]
	bl	FreeUsdByDec
	strd	r6, [r4]
	b	.L3585
.L3580:
	add	r0, r8, #584
	bl	ResetVoQueue
	ldr	r0, [r8, #120]
	bl	FSP_EmptyInstance
	b	.L3581
.L3608:
	movw	r3, #394
	ldr	r2, .L3611+8
	ldr	r1, .L3611+12
	mov	r0, #22
	bl	dprint_vfmw
	b	.L3579
.L3612:
	.align	2
.L3611:
	.word	.LC413
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0+316
	.word	.LC404
	.fnend
	.size	MVC_ClearAll, .-MVC_ClearAll
	.align	2
	.global	MVC_InsertFrmInDPB
	.type	MVC_InsertFrmInDPB, %function
MVC_InsertFrmInDPB:
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
	add	r3, r0, #11075584
	mov	r4, r2
	add	r3, r3, #45056
	ldrb	r7, [r4, #3]
	mov	r6, r0
	str	r1, [fp, #-48]
	ldr	r3, [r3, #2732]
	cmp	r3, #0
	ldreq	r2, .L3714
	streq	r3, [r2, #-1884]
	cmp	r7, #1
	beq	.L3616
	bcc	.L3617
	cmp	r7, #2
	beq	.L3618
	mov	r2, r7
	ldr	r1, .L3714+4
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, r6
	mov	r1, #1
	bl	MVC_ClearAll
	mov	r0, #0
.L3622:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3618:
	ldr	r3, [r4, #608]
	mov	r2, #3
	strb	r2, [r3, #664]
	ldrb	r3, [r4, #1]
	cmp	r3, #0
	ldr	r3, [fp, #-48]
	mov	r3, r3, asl #2
	beq	.L3638
	add	r8, r0, r3
	add	r2, r8, #11075584
	str	r2, [fp, #-52]
	add	r5, r2, #45056
	ldr	r2, [r5, #2536]
	cmp	r2, #0
	beq	.L3638
	strb	r7, [r2, #736]
	ldr	r3, [r5, #2536]
	ldr	r2, [r4, #608]
	str	r2, [r3, #740]
	ldr	r3, [r5, #2536]
	ldrb	r2, [r4, #4]
	strb	r2, [r3, #737]
	ldr	r3, [r5, #2536]
	ldrb	r2, [r4, #5]
	strb	r2, [r3, #738]
	ldr	r3, [r5, #2536]
	ldr	r2, [r4, #640]
	str	r2, [r3, #752]
	ldr	r3, [r5, #2536]
	ldrb	r2, [r4, #12]
	strb	r2, [r3, #739]
	ldr	r3, [r5, #2536]
	ldr	r2, [r4, #660]
	str	r2, [r3, #760]
	ldr	r3, [r5, #2536]
	ldr	r1, [r3, #724]
	ldr	r2, [r3, #760]
	add	r2, r2, r1
	str	r2, [r3, #688]
	str	r2, [r3, #44]
	add	r1, r4, #16
	ldr	r2, [r5, #2536]
	ldrb	r3, [r2, #1]
	cmp	r3, #0
	ldrneb	r3, [r4, #2]
	strb	r3, [r2, #1]
	ldr	r2, [r5, #2536]
	ldrb	r3, [r2, #2]
	orr	r3, r3, #2
	strb	r3, [r2, #2]
	ldrb	r3, [r4, #7]
	cmp	r3, #1
	ldr	r3, [r5, #2536]
	ldrb	r2, [r3, #4]
	orreq	r2, r2, #2
	strb	r2, [r3, #4]
	mov	r2, #592
	ldr	r3, [r5, #2536]
	add	ip, r3, #656
	add	r0, r3, #72
	ldr	r10, [r3, #640]
	ldrd	r8, [ip, #-8]
	ldr	r7, [r3, #644]
	strd	r8, [fp, #-60]
	ldrd	r8, [ip]
	strd	r8, [fp, #-68]
	bl	memcpy
	add	r3, r4, #592
	and	r2, r10, r7
	adds	r2, r2, #1
	ldrd	r8, [fp, #-60]
	ldmdb	r3, {r0, r1}
	movne	r2, #1
	and	r1, r1, r0
	add	r0, r4, #608
	cmn	r1, #1
	movne	r2, #0
	cmp	r2, #0
	ldrne	r2, [r5, #2536]
	strne	r10, [r2, #640]
	strne	r7, [r2, #644]
	ldrd	r2, [r3]
	ldr	r1, [r5, #2536]
	cmp	r3, r9
	cmpeq	r2, r8
	add	r1, r1, #656
	movhi	r2, r8
	movhi	r3, r9
	ldrd	r8, [fp, #-68]
	strd	r2, [r1, #-8]
	ldrd	r2, [r0, #-8]
	ldr	r1, [r5, #2536]
	cmp	r3, r9
	cmpeq	r2, r8
	add	r1, r1, #656
	movhi	r3, r9
	movhi	r2, r8
	strd	r2, [r1]
	ldrb	r3, [r4, #4]
	cmp	r3, #1
	beq	.L3650
	ldrb	r3, [r4, #5]
	cmp	r3, #1
	beq	.L3650
.L3651:
	ldr	r3, [fp, #-52]
	add	r8, r3, #45056
	ldr	r2, [r8, #2536]
	ldrb	r3, [r2, #739]
	ldrb	r1, [r2, #703]
	cmp	r3, r1
	movcc	r3, r1
	strb	r3, [r2]
	ldr	r3, [r8, #2536]
	ldr	r2, [r4, #656]
	str	r2, [r3, #756]
	ldr	r2, [r8, #2536]
	ldr	r3, [r2, #756]
	ldr	r1, [r2, #720]
	cmp	r3, r1
	movge	r3, r1
	str	r3, [r2, #36]
	ldr	r0, [r8, #2536]
	bl	MVC_CombineFldsToFrm
	ldr	r2, [r8, #2536]
	ldrb	r1, [r4, #11]
	movw	r3, #28370
	movt	r3, 42
	strb	r1, [r2, #13]
	ldrb	r1, [r4, #10]
	ldr	r2, [r8, #2536]
	strb	r1, [r2, #11]
	ldr	r2, [r8, #2536]
	ldr	r1, [r2, #52]
	ldr	r2, [r2, #752]
	add	r3, r1, r3
	add	r3, r6, r3, lsl #2
	str	r2, [r3, #4]
	b	.L3637
.L3617:
	ldr	r3, [fp, #-48]
	ldr	r2, [r4, #608]
	add	r3, r0, r3, lsl #2
	add	r10, r3, #11075584
	mov	r3, #3
	add	r5, r10, #45056
	str	r2, [r5, #2536]
	ldrb	r1, [r4, #2]
	strb	r1, [r2, #1]
	ldr	r2, [r5, #2536]
	strb	r3, [r2, #2]
	ldr	r1, [r4, #608]
	ldr	r2, [r5, #2536]
	ldrb	r1, [r1, #5]
	strb	r1, [r2, #5]
	ldr	r1, [r4, #608]
	ldr	r2, [r5, #2536]
	ldrb	r1, [r1, #7]
	strb	r1, [r2, #7]
	ldrb	r1, [r4, #4]
	ldr	r2, [r5, #2536]
	cmp	r1, #0
	beq	.L3713
.L3619:
	strb	r3, [r2, #3]
	add	r1, r4, #16
	ldr	r3, [r5, #2536]
	mov	r2, #592
	ldr	r0, [r4, #684]
	mov	r8, #0
	str	r0, [r3, #48]
	ldr	r0, [r5, #2536]
	add	r0, r0, #72
	bl	memcpy
	ldr	r1, [r5, #2536]
	ldr	ip, [r4, #660]
	add	r3, r10, #45056
	mov	lr, #1
	ldr	r10, .L3714
	mov	r2, r8
	mov	r0, r6
	str	ip, [r1, #688]
	str	ip, [r1, #44]
	ldr	r1, [r5, #2536]
	ldr	ip, [r4, #608]
	str	ip, [r1, #740]
	str	ip, [r1, #704]
	str	ip, [r1, #668]
	ldr	r1, [r5, #2536]
	ldr	ip, [r4, #620]
	str	ip, [r1, #28]
	ldr	r1, [r5, #2536]
	ldr	ip, [r4, #616]
	str	ip, [r1, #20]
	ldr	r1, [r5, #2536]
	strb	r8, [r1, #664]
	ldr	r1, [r5, #2536]
	ldrb	ip, [r4, #4]
	strb	ip, [r1, #665]
	ldr	r1, [r5, #2536]
	ldrb	ip, [r4, #5]
	strb	ip, [r1, #666]
	ldr	r1, [r5, #2536]
	ldrb	ip, [r4, #12]
	strb	ip, [r1, #667]
	strb	ip, [r1]
	ldr	r1, [r5, #2536]
	ldrb	ip, [r4, #9]
	str	ip, [r1, #40]
	ldr	r1, [r5, #2536]
	ldr	ip, [r4, #628]
	str	ip, [r1, #32]
	ldr	r1, [r5, #2536]
	ldr	ip, [r4, #632]
	str	ip, [r1, #680]
	ldr	r1, [r5, #2536]
	ldr	ip, [r4, #636]
	str	ip, [r1, #716]
	ldr	r1, [r5, #2536]
	ldr	ip, [r4, #640]
	str	ip, [r1, #752]
	ldr	r1, [r5, #2536]
	ldr	ip, [r4, #644]
	str	ip, [r1, #36]
	ldr	r1, [r5, #2536]
	ldr	ip, [r4, #648]
	str	ip, [r1, #684]
	ldr	r1, [r5, #2536]
	ldr	ip, [r4, #652]
	str	ip, [r1, #720]
	ldr	r1, [r5, #2536]
	ldr	ip, [r4, #656]
	str	ip, [r1, #756]
	ldrb	r1, [r4, #7]
	ldr	ip, [r5, #2536]
	cmp	r1, lr
	moveq	r7, #3
	strb	r7, [ip, #4]
	ldr	r1, [r3, #2536]
	ldr	ip, [r4, #688]
	str	ip, [r1, #56]
	ldr	r1, [r3, #2536]
	ldr	ip, [r4, #692]
	str	ip, [r1, #60]
	ldr	r1, [r3, #2536]
	ldrb	ip, [r4, #11]
	strb	ip, [r1, #13]
	strb	ip, [r1, #12]
	ldrb	r5, [r4, #10]
	ldr	ip, [r3, #2536]
	ldr	r1, [r10, #-1884]
	strb	r5, [ip, #11]
	add	r7, r1, lr
	strb	r5, [ip, #10]
	ldr	ip, [r3, #2536]
	str	r7, [r10, #-1884]
	str	r1, [ip, #64]
	ldr	r3, [r3, #2536]
	ldr	r1, [r3, #668]
	ldrb	r10, [r3, #665]
	ldrb	r7, [r3, #666]
	ldr	r5, [r3, #688]
	ldrb	ip, [r3, #667]
	strb	lr, [r3, #700]
	mov	lr, #2
	strb	r10, [r3, #701]
	strb	lr, [r3, #736]
	strb	r10, [r3, #737]
	strb	r7, [r3, #702]
	strb	r7, [r3, #738]
	str	r5, [r3, #724]
	str	r5, [r3, #760]
	strb	ip, [r3, #703]
	strb	ip, [r3, #739]
	str	r1, [r3, #704]
	str	r1, [r3, #740]
	ldr	r1, [r4, #608]
	bl	MVC_GetAPC
	cmp	r0, #0
	movne	r3, r0
	movwne	r2, #2243
	movne	r0, r8
	bne	.L3711
.L3637:
	ldr	r2, [fp, #-48]
	movw	r3, #28282
	movt	r3, 42
	add	r3, r2, r3
	ldr	r3, [r6, r3, asl #2]
	ldrb	r0, [r3, #3]
	cmp	r0, #0
	beq	.L3622
	ldr	r0, [r6, #120]
	mov	r2, #1
	ldrsb	r1, [r3, #6]
	bl	FSP_SetRef
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3616:
	ldr	r3, [r4, #608]
	mov	r2, #3
	strb	r2, [r3, #664]
	ldrb	r3, [r4, #1]
	cmp	r3, #0
	ldr	r3, [fp, #-48]
	mov	r3, r3, asl #2
	beq	.L3623
	add	r8, r0, r3
	add	r2, r8, #11075584
	str	r2, [fp, #-52]
	add	r5, r2, #45056
	ldr	r2, [r5, #2536]
	cmp	r2, #0
	beq	.L3623
	strb	r7, [r2, #700]
	ldr	r3, [r5, #2536]
	ldrb	r2, [r4, #12]
	strb	r2, [r3, #703]
	ldr	r3, [r5, #2536]
	ldrb	r2, [r4, #4]
	strb	r2, [r3, #701]
	ldr	r3, [r5, #2536]
	ldrb	r2, [r4, #5]
	strb	r2, [r3, #702]
	ldr	r3, [r5, #2536]
	ldr	r2, [r4, #636]
	str	r2, [r3, #716]
	ldr	r3, [r5, #2536]
	ldrb	r2, [r4, #12]
	strb	r2, [r3, #703]
	ldr	r3, [r5, #2536]
	ldr	r2, [r4, #660]
	str	r2, [r3, #724]
	ldr	r3, [r5, #2536]
	ldr	r1, [r3, #724]
	ldr	r2, [r3, #760]
	add	r2, r2, r1
	str	r2, [r3, #688]
	str	r2, [r3, #44]
	add	r1, r4, #16
	ldr	r2, [r5, #2536]
	ldrb	r3, [r2, #1]
	cmp	r3, #0
	ldrneb	r3, [r4, #2]
	strb	r3, [r2, #1]
	ldr	r2, [r5, #2536]
	ldrb	r3, [r2, #2]
	orr	r3, r3, #1
	strb	r3, [r2, #2]
	ldrb	r3, [r4, #7]
	cmp	r3, #1
	ldr	r3, [r5, #2536]
	ldrb	r2, [r3, #4]
	orreq	r2, r2, #1
	strb	r2, [r3, #4]
	mov	r2, #592
	ldr	r3, [r5, #2536]
	add	ip, r3, #656
	add	r0, r3, #72
	ldr	r10, [r3, #640]
	ldrd	r8, [ip, #-8]
	ldr	r7, [r3, #644]
	strd	r8, [fp, #-60]
	ldrd	r8, [ip]
	strd	r8, [fp, #-68]
	bl	memcpy
	add	r3, r4, #592
	and	r2, r10, r7
	adds	r2, r2, #1
	ldrd	r8, [fp, #-60]
	ldmdb	r3, {r0, r1}
	movne	r2, #1
	and	r1, r1, r0
	add	r0, r4, #608
	cmn	r1, #1
	movne	r2, #0
	cmp	r2, #0
	ldrne	r2, [r5, #2536]
	strne	r10, [r2, #640]
	strne	r7, [r2, #644]
	ldrd	r2, [r3]
	ldr	r1, [r5, #2536]
	cmp	r3, r9
	cmpeq	r2, r8
	add	r1, r1, #656
	movhi	r2, r8
	movhi	r3, r9
	ldrd	r8, [fp, #-68]
	strd	r2, [r1, #-8]
	ldrd	r2, [r0, #-8]
	ldr	r1, [r5, #2536]
	cmp	r3, r9
	cmpeq	r2, r8
	add	r1, r1, #656
	movhi	r3, r9
	movhi	r2, r8
	strd	r2, [r1]
	ldrb	r3, [r4, #4]
	cmp	r3, #1
	beq	.L3634
	ldrb	r3, [r4, #5]
	cmp	r3, #1
	beq	.L3634
.L3635:
	ldr	r3, [fp, #-52]
	add	r8, r3, #45056
	ldr	r2, [r8, #2536]
	ldrb	r3, [r2, #739]
	ldrb	r1, [r2, #703]
	cmp	r3, r1
	movcc	r3, r1
	strb	r3, [r2]
	ldr	r3, [r8, #2536]
	ldr	r2, [r4, #652]
	str	r2, [r3, #720]
	ldr	r2, [r8, #2536]
	ldr	r3, [r2, #756]
	ldr	r1, [r2, #720]
	cmp	r3, r1
	movge	r3, r1
	str	r3, [r2, #36]
	ldr	r3, [r8, #2536]
	ldrb	r2, [r4, #11]
	strb	r2, [r3, #12]
	ldrb	r2, [r4, #10]
	ldr	r3, [r8, #2536]
	strb	r2, [r3, #10]
	ldr	r0, [r8, #2536]
	bl	MVC_CombineFldsToFrm
	ldr	r2, [r8, #2536]
	movw	r3, #28354
	movt	r3, 42
	ldr	r1, [r2, #52]
	ldr	r2, [r2, #716]
	add	r3, r1, r3
	add	r3, r6, r3, lsl #2
	str	r2, [r3, #4]
	b	.L3637
.L3623:
	add	r5, r6, r3
	ldr	r2, [r4, #608]
	add	r5, r5, #11075584
	mov	r1, #1
	add	r3, r5, #45056
	str	r2, [r3, #2536]
	strb	r1, [r2, #700]
	ldr	r2, [r3, #2536]
	ldr	r0, [r4, #608]
	str	r0, [r2, #704]
	ldr	r2, [r3, #2536]
	ldrb	r0, [r4, #4]
	strb	r0, [r2, #701]
	ldr	r2, [r3, #2536]
	ldrb	r0, [r4, #5]
	strb	r0, [r2, #702]
	ldr	r2, [r3, #2536]
	ldr	r0, [r4, #636]
	str	r0, [r2, #716]
	ldr	r2, [r3, #2536]
	ldrb	r0, [r4, #12]
	strb	r0, [r2, #703]
	ldr	r2, [r3, #2536]
	ldr	r0, [r4, #660]
	str	r0, [r2, #724]
	ldr	r2, [r3, #2536]
	ldr	r0, [r2, #724]
	str	r0, [r2, #688]
	str	r0, [r2, #44]
	ldr	r2, [r3, #2536]
	ldrb	r0, [r4, #2]
	strb	r0, [r2, #1]
	ldr	r2, [r3, #2536]
	strb	r1, [r2, #2]
	ldr	r1, [r4, #608]
	ldr	r2, [r3, #2536]
	ldrb	r1, [r1, #5]
	strb	r1, [r2, #5]
	ldr	r1, [r4, #608]
	ldr	r2, [r3, #2536]
	ldrb	r1, [r1, #7]
	strb	r1, [r2, #7]
	ldrb	r2, [r4, #4]
	cmp	r2, #1
	beq	.L3625
	ldrb	r2, [r4, #5]
	cmp	r2, #1
	beq	.L3625
.L3626:
	add	r5, r5, #45056
	mov	r7, #0
	mov	r2, #592
	add	r1, r4, #16
	ldr	r3, [r5, #2536]
	str	r7, [r3, #40]
	ldr	r0, [r5, #2536]
	add	r0, r0, #72
	bl	memcpy
	ldr	r1, [r5, #2536]
	ldr	ip, [r4, #684]
	mov	r2, #1
	ldr	r3, .L3714
	mov	r0, r6
	str	ip, [r1, #48]
	ldr	ip, [r5, #2536]
	ldr	lr, [r4, #616]
	ldr	r1, [r3, #-1884]
	str	lr, [ip, #20]
	add	ip, r1, r2
	ldr	lr, [r5, #2536]
	ldr	r8, [r4, #628]
	str	r8, [lr, #32]
	ldr	lr, [r5, #2536]
	ldr	r8, [r4, #644]
	str	r8, [lr, #36]
	ldr	lr, [r5, #2536]
	ldrb	r8, [r4, #12]
	strb	r8, [lr]
	ldr	lr, [r5, #2536]
	ldr	r8, [r4, #652]
	str	r8, [lr, #720]
	ldr	lr, [r5, #2536]
	ldr	r8, [r4, #688]
	str	r8, [lr, #56]
	ldr	lr, [r5, #2536]
	ldr	r8, [r4, #692]
	str	r8, [lr, #60]
	ldr	lr, [r5, #2536]
	ldrb	r8, [r4, #11]
	strb	r8, [lr, #12]
	ldr	lr, [r5, #2536]
	ldrb	r8, [r4, #10]
	strb	r8, [lr, #10]
	ldr	lr, [r5, #2536]
	str	r1, [lr, #64]
	str	ip, [r3, #-1884]
	ldrb	r3, [r4, #7]
	ldr	r1, [r5, #2536]
	rsb	r3, r2, r3
	clz	r3, r3
	mov	r3, r3, lsr #5
	strb	r3, [r1, #4]
	ldr	r1, [r4, #608]
	bl	MVC_GetAPC
	cmp	r0, #0
	beq	.L3637
	mov	r3, r0
	movw	r2, #2306
	mov	r0, r7
.L3711:
	ldr	r1, .L3714+8
	bl	dprint_vfmw
	mov	r0, r6
	mvn	r1, #0
	bl	MVC_ClearDPB
	mvn	r0, #0
	b	.L3622
.L3638:
	add	r5, r6, r3
	ldr	r2, [r4, #608]
	add	r5, r5, #11075584
	mov	r1, #2
	add	r3, r5, #45056
	str	r2, [r3, #2536]
	strb	r1, [r2, #736]
	ldr	r2, [r3, #2536]
	ldr	r0, [r4, #608]
	str	r0, [r2, #740]
	ldr	r2, [r3, #2536]
	ldrb	r0, [r4, #4]
	strb	r0, [r2, #737]
	ldr	r2, [r3, #2536]
	ldrb	r0, [r4, #5]
	strb	r0, [r2, #738]
	ldr	r2, [r3, #2536]
	ldr	r0, [r4, #640]
	str	r0, [r2, #752]
	ldr	r2, [r3, #2536]
	ldrb	r0, [r4, #12]
	strb	r0, [r2, #739]
	ldr	r2, [r3, #2536]
	ldr	r0, [r4, #660]
	str	r0, [r2, #760]
	ldr	r2, [r3, #2536]
	ldr	r0, [r2, #724]
	str	r0, [r2, #688]
	str	r0, [r2, #44]
	ldr	r2, [r3, #2536]
	ldrb	r0, [r4, #2]
	strb	r0, [r2, #1]
	ldr	r2, [r3, #2536]
	strb	r1, [r2, #2]
	ldr	r1, [r4, #608]
	ldr	r2, [r3, #2536]
	ldrb	r1, [r1, #5]
	strb	r1, [r2, #5]
	ldr	r1, [r4, #608]
	ldr	r2, [r3, #2536]
	ldrb	r1, [r1, #7]
	strb	r1, [r2, #7]
	ldrb	r2, [r4, #4]
	cmp	r2, #1
	beq	.L3640
	ldrb	r2, [r4, #5]
	cmp	r2, #1
	beq	.L3640
.L3641:
	add	r5, r5, #45056
	mov	r8, #0
	mov	r2, #592
	add	r1, r4, #16
	ldr	r3, [r5, #2536]
	str	r8, [r3, #40]
	ldr	r0, [r5, #2536]
	add	r0, r0, #72
	bl	memcpy
	ldr	r1, [r5, #2536]
	ldr	ip, [r4, #684]
	mov	r2, #2
	ldr	r3, .L3714
	mov	r0, r6
	str	ip, [r1, #48]
	ldr	ip, [r5, #2536]
	ldr	lr, [r4, #616]
	ldr	r1, [r3, #-1884]
	str	lr, [ip, #20]
	add	r7, r1, #1
	ldr	ip, [r5, #2536]
	ldr	lr, [r4, #628]
	str	lr, [ip, #32]
	ldr	ip, [r5, #2536]
	ldr	lr, [r4, #644]
	str	lr, [ip, #36]
	ldr	ip, [r5, #2536]
	ldrb	lr, [r4, #12]
	strb	lr, [ip, #739]
	strb	lr, [ip]
	ldr	ip, [r5, #2536]
	ldr	lr, [r4, #656]
	str	lr, [ip, #756]
	ldr	ip, [r5, #2536]
	ldr	lr, [r4, #688]
	str	lr, [ip, #56]
	ldr	ip, [r5, #2536]
	ldr	lr, [r4, #692]
	str	lr, [ip, #60]
	ldr	ip, [r5, #2536]
	ldrb	lr, [r4, #11]
	strb	lr, [ip, #13]
	ldr	ip, [r5, #2536]
	ldrb	lr, [r4, #10]
	strb	lr, [ip, #11]
	ldr	ip, [r5, #2536]
	str	r1, [ip, #64]
	ldrb	ip, [r4, #7]
	ldr	r1, [r5, #2536]
	cmp	ip, #1
	str	r7, [r3, #-1884]
	moveq	r7, r2
	movne	r7, r8
	strb	r7, [r1, #4]
	ldr	r1, [r4, #608]
	bl	MVC_GetAPC
	cmp	r0, #0
	movne	r3, r0
	movwne	r2, #2431
	movne	r0, r8
	beq	.L3637
	b	.L3711
.L3713:
	ldrb	r3, [r4, #5]
	cmp	r3, #0
	movne	r3, #3
	b	.L3619
.L3640:
	ldr	r2, [r3, #2536]
	mov	r1, #2
	strb	r1, [r2, #3]
	ldrb	r2, [r4, #4]
	cmp	r2, #1
	ldreq	r3, [r3, #2536]
	ldreq	r2, [r4, #620]
	streq	r2, [r3, #28]
	b	.L3641
.L3625:
	ldr	r2, [r3, #2536]
	mov	r1, #1
	strb	r1, [r2, #3]
	ldrb	r2, [r4, #4]
	cmp	r2, r1
	ldreq	r3, [r3, #2536]
	ldreq	r2, [r4, #620]
	streq	r2, [r3, #28]
	b	.L3626
.L3634:
	ldr	r2, [r5, #2536]
	ldrb	r3, [r2, #3]
	orr	r3, r3, #1
	strb	r3, [r2, #3]
	ldrb	r3, [r4, #4]
	cmp	r3, #1
	ldreq	r3, [r5, #2536]
	ldreq	r2, [r4, #620]
	streq	r2, [r3, #28]
	b	.L3635
.L3650:
	ldr	r2, [r5, #2536]
	ldrb	r3, [r2, #3]
	orr	r3, r3, #2
	strb	r3, [r2, #3]
	ldrb	r3, [r4, #4]
	cmp	r3, #1
	ldreq	r3, [r5, #2536]
	ldreq	r2, [r4, #620]
	streq	r2, [r3, #28]
	b	.L3651
.L3715:
	.align	2
.L3714:
	.word	.LANCHOR3
	.word	.LC415
	.word	.LC414
	.fnend
	.size	MVC_InsertFrmInDPB, .-MVC_InsertFrmInDPB
	.align	2
	.global	MVC_AllocFrameStore
	.type	MVC_AllocFrameStore, %function
MVC_AllocFrameStore:
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
	add	r9, r0, #11075584
	mov	r6, r0
	add	r7, r9, #40960
	str	r1, [fp, #-52]
	ldrb	r5, [r7, #873]
	cmp	r5, #0
	beq	.L3717
	ldrb	r3, [r7, #874]
	cmp	r3, #0
	movne	r5, #2
	moveq	r5, #1
.L3717:
	ldr	r3, [fp, #-52]
	cmp	r3, #1
	ldrb	r3, [r6, #8]
	beq	.L3718
	cmp	r3, #2
	add	r4, r6, #11141120
	beq	.L3797
	sub	r3, r5, #1
	add	r4, r4, #12288
	cmp	r3, #1
	mov	r3, #0
	strb	r3, [r4, #1369]
	bls	.L3801
.L3740:
	mov	r8, #0
	strb	r8, [r4, #1368]
	ldr	r10, [r6, #48]
	cmp	r10, r8
	beq	.L3747
	movw	ip, #48152
	add	r9, r9, #45056
	movt	ip, 169
	add	ip, r6, ip
	movw	r3, #47592
	movt	r3, 169
	add	r3, r6, r3
	str	r3, [fp, #-48]
.L3746:
	ldrb	r3, [ip, #2]
	cmp	r3, #0
	bne	.L3742
	cmp	ip, #0
	beq	.L3759
	ldr	lr, [r9, #2728]
	cmp	lr, #0
	beq	.L3759
	ldr	r2, [r9, #2536]
	rsb	r3, ip, r2
	cmp	r2, #0
	clz	r3, r3
	mov	r3, r3, lsr #5
	moveq	r3, #0
	cmp	r3, #0
	bne	.L3742
	ldr	r1, [fp, #-48]
	b	.L3744
.L3745:
	ldr	r2, [r1, #4]!
	rsb	r0, ip, r2
	cmp	r2, #0
	clz	r0, r0
	mov	r0, r0, lsr #5
	moveq	r0, #0
	cmp	r0, #0
	bne	.L3742
.L3744:
	add	r3, r3, #1
	cmp	r3, lr
	bne	.L3745
.L3759:
	mov	r3, #776
	movw	r2, #48192
	mla	r8, r3, r8, r6
	movt	r2, 169
	movw	r1, #48224
	add	r0, r4, #1376
	mov	r9, #0
	mov	r3, #1
	add	r2, r8, r2
	str	ip, [r4, #1976]
	strb	r3, [r4, #1368]
	mov	r10, ip
	str	r9, [r2, #4]
	mov	ip, #101
	mov	r2, #592
	movt	r1, 169
	add	r0, r0, #8
	add	r1, r8, r1
	str	ip, [r4, #2028]
	str	r3, [fp, #-48]
	bl	memcpy
	movw	r2, #48152
	str	r9, [r4, #1544]
	movt	r2, 169
	add	r2, r8, r2
	ldr	r3, [fp, #-48]
	strb	r9, [r2, #4]
	strb	r9, [r10, #7]
	ldr	r2, [r4, #1976]
	strb	r9, [r2, #3]
	ldr	r2, [r4, #1976]
	strb	r3, [r2, #5]
	ldr	r3, [r4, #1976]
	str	r9, [r3, #16]
	ldrb	r8, [r4, #1368]
	cmp	r8, #1
	bne	.L3747
	ldr	r3, [fp, #-52]
	ldr	r0, [r6, #120]
	clz	r1, r3
	mov	r1, r1, lsr #5
	bl	FSP_NewLogicFs
	mov	r10, r0
	mov	r1, r0
	ldr	r0, [r6, #120]
	bl	FSP_GetLogicFs
	mvn	r2, r10
	mov	r2, r2, lsr #31
	cmp	r0, #0
	mov	r3, r0
	moveq	r2, #0
	cmp	r2, #0
	beq	.L3748
	ldr	r2, [r6, #224]
	ldr	r2, [r2, #28]
	cmp	r2, #25
	beq	.L3802
.L3749:
	ldr	r8, .L3809
	add	r1, r3, #8
	ldr	r0, [r4, #1976]
	mov	r2, #592
	str	r3, [fp, #-48]
	ldr	ip, [r8, #52]
	add	r0, r0, #72
	blx	ip
	ldr	r1, [r4, #1976]
	movw	r0, #13672
	mov	r2, #592
	ldr	ip, [r8, #52]
	movt	r0, 170
	add	r1, r1, #72
	add	r0, r6, r0
	blx	ip
	ldr	r2, [r4, #1976]
	ldr	r3, [fp, #-48]
	strb	r10, [r2, #6]
	ldrsb	r3, [r3, #4]
	str	r3, [r4, #2052]
.L3739:
	ldr	r3, [fp, #-52]
	uxtb	r2, r5
	strb	r2, [r4, #1371]
	cmp	r3, #1
	moveq	r0, #0
	beq	.L3793
	ldrb	r3, [r7, #873]
	ldr	r1, [r4, #1976]
	cmp	r3, #0
	movne	r3, #3
	strb	r3, [r1, #664]
	ldrb	r3, [r4, #1369]
	cmp	r3, #1
	beq	.L3803
	strb	r2, [r4, #2760]
	cmp	r5, #0
	ldr	r3, [r7, #900]
	movne	r0, #0
	moveq	r0, r5
	str	r3, [r4, #2768]
	ldrb	r3, [r7, #880]
	str	r3, [r4, #2764]
	ldr	r3, [r6, #128]
	str	r3, [r4, #2772]
	ldr	r3, [r7, #2512]
	str	r10, [r4, #2776]
	streqb	r5, [r4, #2761]
	str	r3, [r4, #2784]
	movne	r3, #1
	strneb	r3, [r4, #2761]
.L3793:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3742:
	add	r8, r8, #1
	add	ip, ip, #776
	cmp	r8, r10
	bne	.L3746
.L3747:
	ldr	r1, .L3809+4
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, r6
	mov	r1, #1
	bl	MVC_ClearAll
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3804:
	add	r4, r6, #11141120
	mov	r5, #0
.L3797:
	add	r4, r4, #12288
.L3737:
	mov	r3, #0
	strb	r3, [r4, #1369]
	b	.L3740
.L3718:
	cmp	r3, #2
	beq	.L3804
	add	r4, r6, #11141120
	mov	r3, #0
	add	r4, r4, #12288
	mov	r5, r3
	strb	r3, [r4, #1369]
	b	.L3740
.L3802:
	ldr	r2, [r6, #16]
	ldr	r8, [r0, #148]
	ldr	r1, [r6, #12]
	mov	r2, r2, asl #4
	ldr	r0, [r0, #52]
	str	r2, [r3, #124]
	mul	r8, r8, r2
	mov	r2, r1, asl #4
	str	r2, [r3, #120]
	str	r3, [fp, #-48]
	add	r0, r8, r0
	str	r0, [r3, #56]
	bl	MEM_Phy2Vir
	ldr	r3, [fp, #-48]
	ldr	r1, [r3, #36]
	ldr	r2, [r3, #148]
	str	r9, [r3, #492]
	str	r0, [r3, #488]
	ldr	r0, [r3, #68]
	add	r0, r8, r0
	add	r8, r8, r1
	str	r0, [r3, #72]
	str	r8, [r3, #40]
	add	r8, r8, r2
	str	r8, [r3, #48]
	bl	MEM_Phy2Vir
	ldr	r3, [fp, #-48]
	str	r9, [r3, #508]
	str	r0, [r3, #504]
	b	.L3749
.L3801:
	ldrb	r3, [r4, #2760]
	cmp	r3, #0
	beq	.L3721
	ldr	r1, [r4, #2784]
	ldr	r2, [r7, #2512]
	cmp	r1, r2
	beq	.L3722
.L3721:
	add	r3, r9, #45056
	ldr	r1, [r3, #2728]
	subs	r3, r1, #1
	bmi	.L3740
	movw	r2, #28282
	movt	r2, 42
	add	r2, r1, r2
	add	r2, r6, r2, lsl #2
	b	.L3733
.L3724:
	cmp	r5, #2
	beq	.L3805
.L3723:
	subs	r3, r3, #1
	bmi	.L3740
.L3733:
	ldr	r8, [r2, #-4]!
	cmp	r8, #0
	beq	.L3723
	cmp	r5, #1
	bne	.L3724
	ldrb	r1, [r8, #2]
	cmp	r1, #2
	bne	.L3723
.L3725:
	ldr	r0, [r7, #900]
	ldr	r1, [r8, #20]
	cmp	r0, r1
	bne	.L3723
	ldr	r0, [r7, #2512]
	ldr	r1, [r8, #56]
	cmp	r0, r1
	bne	.L3723
	ldrb	r1, [r7, #880]
	cmp	r1, #0
	ldrb	r1, [r8, #3]
	beq	.L3806
	cmp	r1, #0
	beq	.L3723
.L3729:
	add	r0, r4, #1376
	mov	r3, #1
	mov	r2, #592
	strb	r3, [r4, #1369]
	add	r1, r8, #72
	str	r8, [r4, #1976]
	add	r0, r0, #8
	bl	memcpy
	ldrsb	r1, [r8, #6]
	ldr	r0, [r6, #120]
	bl	FSP_GetLogicFs
	subs	r3, r0, #0
	beq	.L3807
	ldrb	r2, [r4, #1369]
	ldrsb	r3, [r3, #4]
	cmp	r2, #0
	str	r3, [r4, #2052]
	beq	.L3740
	ldr	r3, [r4, #1976]
	cmp	r3, #0
	beq	.L3740
.L3798:
	mov	r10, #0
	b	.L3739
.L3805:
	ldrb	r1, [r8, #2]
	cmp	r1, #1
	bne	.L3723
	b	.L3725
.L3803:
	mov	r3, #0
	strb	r3, [r4, #2760]
	ldr	r2, [r7, #900]
	mov	r0, r3
	str	r2, [r4, #2768]
	ldrb	r2, [r7, #880]
	str	r2, [r4, #2764]
	ldr	r2, [r6, #128]
	strb	r3, [r4, #2761]
	str	r10, [r4, #2776]
	str	r2, [r4, #2772]
	ldr	r3, [r7, #2512]
	str	r3, [r4, #2784]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3806:
	cmp	r1, #0
	bne	.L3723
	b	.L3729
.L3722:
	sub	r10, r5, #2
	cmp	r3, #1
	cmpeq	r5, #2
	clz	r10, r10
	mov	r10, r10, lsr #5
	beq	.L3734
	cmp	r5, #1
	cmpeq	r3, #2
	bne	.L3740
.L3734:
	ldr	r2, [r4, #2768]
	ldr	r3, [r7, #900]
	cmp	r2, r3
	bne	.L3740
	ldrb	r3, [r7, #880]
	cmp	r3, #0
	ldr	r3, [r4, #2764]
	bne	.L3735
	cmp	r3, #0
	bne	.L3740
.L3736:
	ldr	r3, [r6, #128]
	ldr	r2, [r6, #124]
	rsb	r3, r2, r3
	cmp	r3, #2
	bhi	.L3740
	ldr	r3, [r4, #1976]
	mov	r2, #1
	strb	r2, [r4, #1369]
	cmp	r3, #0
	beq	.L3737
	cmp	r10, #0
	bne	.L3808
	cmp	r5, #1
	bne	.L3739
	ldrb	r3, [r3, #2]
	cmp	r3, #2
	bne	.L3737
	b	.L3739
.L3748:
	ldr	r3, [r4, #1976]
	mov	r0, r2
	strb	r2, [r4, #1368]
	ldr	r1, .L3809+8
	strb	r2, [r3, #5]
	bl	dprint_vfmw
	mov	r1, r8
	mov	r0, r6
	bl	MVC_ClearAll
	mvn	r0, #0
	b	.L3793
.L3807:
	movw	r2, #6626
	ldr	r1, .L3809+12
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3793
.L3808:
	ldrb	r3, [r3, #2]
	cmp	r3, r2
	bne	.L3737
	b	.L3798
.L3735:
	cmp	r3, #0
	beq	.L3740
	b	.L3736
.L3810:
	.align	2
.L3809:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC417
	.word	.LC418
	.word	.LC416
	.fnend
	.size	MVC_AllocFrameStore, .-MVC_AllocFrameStore
	.align	2
	.global	MVC_DEC_Init
	.type	MVC_DEC_Init, %function
MVC_DEC_Init:
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
	ldr	r8, .L3823
	ldr	r4, [r0, #928]
	movw	r2, #16912
	mov	r6, r0
	mov	r5, r1
	movt	r2, 170
	mov	r1, #0
	ldr	r3, [r8, #48]
	blx	r3
	str	r4, [r6, #928]
	add	r0, r6, #584
	mov	r4, #2240
	bl	ResetVoQueue
	str	r5, [r6, #224]
	mov	r3, #0
	str	r3, [r6, #228]
	strb	r3, [r6]
	ldr	r3, [r5, #28]
	cmp	r3, #25
	ldreq	r3, [r5, #676]
	movne	r3, #32
	movne	r2, #256
	strne	r3, [r6, #36]
	movne	r3, #136
	streq	r3, [r6, #36]
	ldreq	r3, [r5, #680]
	streq	r3, [r6, #40]
	ldreq	r3, [r5, #668]
	str	r3, [r6, #32]
	strne	r2, [r6, #40]
	ldr	r0, [r5, #580]
	bl	MEM_Phy2Vir
	ldr	ip, [r6, #36]
	ldr	r3, [r6, #224]
	movw	r2, #3992
	ldr	lr, [r6, #40]
	mul	r2, r2, ip
	ldr	r3, [r3, #576]
	add	r3, r0, r3
	str	r3, [r6, #248]
	add	r0, r3, r2
	str	r0, [r6, #252]
	cmp	r3, #0
	cmpne	r0, #0
	mla	r0, r4, lr, r0
	moveq	r1, #1
	movne	r1, #0
	cmp	r0, #0
	orreq	r1, r1, #1
	cmp	r1, #0
	str	r0, [r6, #544]
	bne	.L3820
	ldr	r5, [r5, #604]
	cmp	r5, #0
	beq	.L3821
.L3816:
	add	r3, r6, #11075584
	movw	r2, #4060
	add	r1, r3, #36864
	add	r3, r3, #32768
	ldr	r9, [r8, #48]
	add	r4, r6, #12992
	str	lr, [r1, #1616]
	mov	r1, #0
	str	ip, [r3, #2440]
	mov	r5, r1
	ldr	r3, [r6, #32]
	add	r4, r4, #12
	movw	r7, #22860
	movt	r7, 164
	add	r7, r6, r7
	mul	r2, r2, r3
	blx	r9
	ldr	r3, [r6, #108]
	mov	r2, #9856
	mov	lr, #40
	mov	ip, #25
	str	lr, [r6, #48]
	strb	r5, [r6, #4]
	ubfx	r3, r3, #16, #2
	strb	r5, [r6, #6]
	mov	r1, r5
	strb	r3, [r6, #8]
	movt	r2, 164
	strb	r5, [r6, #7]
	mov	r3, #18
	str	ip, [r6, #56]
	mov	r0, r4
	str	r3, [r6, #52]
	str	r5, [r6, #68]
	ldr	r3, [r8, #48]
	str	r5, [r6, #72]
	str	r5, [r6, #76]
	str	r5, [r6, #80]
	str	r5, [r6, #84]
	str	r5, [r6, #88]
	str	r5, [r6, #92]
	str	r5, [r6, #96]
	str	r5, [r6, #60]
	str	r5, [r6, #528]
	str	r5, [r6, #532]
	str	r5, [r6, #536]
	str	r5, [r6, #540]
	str	r5, [r6, #220]
	blx	r3
	movw	r2, #8500
	ldr	r3, [r8, #48]
	movt	r2, 5
	mov	r0, r7
	mov	r1, r5
	blx	r3
	mov	r3, r4
	mov	r2, r5
.L3817:
	strb	r2, [r3]
	add	ip, r3, #274432
	add	r3, r3, #335872
	mov	r4, #0
	add	r3, r3, #308
	strb	r2, [ip, #241]
	cmp	r3, r7
	bne	.L3817
	add	r2, r6, #12288
	movw	r3, #34464
	mov	r1, #32
	movt	r3, 169
	strb	r4, [r2, #704]
	add	r3, r6, r3
	mov	r0, r6
	str	r3, [r6, #236]
	str	r4, [r6, #20]
	strb	r4, [r6, #2]
	str	r1, [r6, #24]
	str	r1, [r6, #28]
	bl	VCTRL_GetChanIDByCtx
	cmn	r0, #1
	str	r0, [r6, #120]
	beq	.L3822
	mov	r1, r4
	mov	r0, r6
	bl	MVC_ClearAll
	mov	r0, #1
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L3821:
	mov	r0, r3
	mov	r1, r5
	ldr	r3, [r8, #48]
	blx	r3
	ldr	r2, [r6, #40]
	mov	r1, r5
	ldr	r3, [r8, #48]
	ldr	r0, [r6, #252]
	mul	r2, r4, r2
	blx	r3
	ldr	lr, [r6, #40]
	ldr	ip, [r6, #36]
	ldr	r0, [r6, #544]
	b	.L3816
.L3820:
	movw	r3, #13922
	ldr	r2, .L3823+4
	ldr	r1, .L3823+8
	mov	r0, #22
	bl	dprint_vfmw
	mvn	r0, #19
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L3822:
	mov	r0, r4
	ldr	r1, .L3823+12
	bl	dprint_vfmw
	mvn	r0, #19
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L3824:
	.align	2
.L3823:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0+332
	.word	.LC419
	.word	.LC420
	.fnend
	.size	MVC_DEC_Init, .-MVC_DEC_Init
	.align	2
	.global	MVC_StorePicInDpb
	.type	MVC_StorePicInDpb, %function
MVC_StorePicInDpb:
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
	add	r4, r0, #11075584
	add	r7, r0, #11141120
	add	r2, r4, #36864
	add	r6, r7, #12288
	mov	r8, #0
	mov	r5, r0
	strb	r8, [r2, #3832]
	ldrb	r3, [r6, #1371]
	sub	r3, r3, #2
	clz	r3, r3
	mov	r3, r3, lsr #5
	strb	r3, [r2, #3833]
	ldrb	r3, [r6, #1368]
	cmp	r3, r8
	beq	.L3988
	ldr	r3, [r0, #128]
	str	r3, [r0, #124]
	ldrb	r3, [r6, #1381]
	cmp	r3, #0
	bne	.L3989
.L3828:
	ldrb	r0, [r5, #8]
	cmp	r0, #2
	beq	.L3990
	ldr	r8, [r5, #224]
	ldr	r3, [r8, #12]
	cmp	r3, #0
	ble	.L3991
.L3833:
	ldrb	r2, [r6, #1370]
	cmp	r2, #0
	beq	.L3992
.L3834:
	cmp	r3, #2
	ldr	r3, [r6, #1992]
	beq	.L3993
.L3859:
	cmp	r3, #0
	beq	.L3866
	ldr	r3, [r5, #112]
	ldr	r2, [r6, #2028]
	cmp	r3, r2
	bcs	.L3867
	ldrb	r1, [r6, #1370]
	cmp	r1, #0
	beq	.L3994
.L3867:
	mov	r0, r5
	bl	MVC_Marking
	cmp	r0, #0
	bne	.L3995
	mov	r0, r5
	bl	MVC_UpdateReflist
	mov	r0, r5
	bl	MVC_UpdateLTReflist
	ldr	r1, [r6, #2056]
	mov	r0, r5
	bl	MVC_RemoveUnUsedFrameStore
.L3860:
	ldrb	r3, [r6, #1369]
	cmp	r3, #1
	beq	.L3870
	add	r4, r4, #45056
	ldr	ip, [r4, #2728]
.L3871:
	ldr	r3, [r6, #1992]
	cmp	r3, #0
	beq	.L3880
	ldr	r2, [r4, #2736]
	ldr	r3, [r4, #2740]
	add	r1, r3, r2
	cmp	r1, ip
	bcs	.L3905
.L3880:
	mvn	r9, #0
	mov	r8, r9
	b	.L3889
.L3884:
	ldr	r3, [r6, #1992]
	mov	r1, r8
	mov	r0, r5
	mov	r9, r2
	cmp	r3, #0
	bne	.L3885
	ldr	r2, [r6, #1996]
	ldr	r3, [fp, #-56]
	cmp	r2, r3
	blt	.L3996
.L3885:
	bl	MVC_OutputFrmFromDPB
	cmn	r0, #1
	mov	r10, r0
	beq	.L3888
	ldr	ip, [r4, #2728]
.L3889:
	ldr	lr, [r4, #2732]
	sub	r3, fp, #52
	sub	r2, fp, #56
	mvn	r1, #0
	cmp	lr, ip
	mov	r0, r5
	bcc	.L3882
	bl	MVC_GetMinPOC
	cmp	r0, #0
	blt	.L3997
	ldr	r2, [r4, #2732]
	cmp	r2, r9
	ldrne	r8, [fp, #-52]
	bne	.L3884
	ldr	r3, [fp, #-52]
	cmp	r3, r8
	beq	.L3998
	mov	r8, r3
	b	.L3884
.L3989:
	ldr	r3, [r6, #1980]
	ldrb	r9, [r3, #1]
	cmp	r9, #0
	beq	.L3829
	bl	MVC_InitDPB
	cmp	r0, #0
	beq	.L3828
	mov	r0, r8
	ldr	r1, .L4014
	bl	dprint_vfmw
	movw	r3, #3630
	mvn	r2, #0
	ldr	r1, .L4014+4
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3907
.L3992:
	ldrb	r1, [r6, #1371]
	ldr	r10, [r6, #1976]
	sub	r2, r1, #1
	cmp	r2, #1
	movhi	r2, #0
	movls	r2, #1
	cmp	r1, #0
	beq	.L3835
	ldrb	r0, [r10, #2]
	cmp	r0, #0
	moveq	ip, r2
	orrne	ip, r2, #1
	cmp	ip, #0
	beq	.L3834
	cmp	r2, #0
	beq	.L3999
.L3908:
	ldr	r2, [r5, #220]
	cmp	r2, #0
	bne	.L3838
	add	r1, r6, #1360
	mov	r3, #1
	add	r1, r1, #8
	str	r3, [r5, #220]
	mov	r2, #696
	add	r0, r6, #2064
	bl	memcpy
	ldr	r3, [r8, #12]
	b	.L3834
.L3866:
	ldrb	r3, [r6, #1369]
	cmp	r3, #1
	beq	.L3870
	add	r4, r4, #45056
	ldr	ip, [r4, #2728]
	b	.L3880
.L3835:
	cmp	r2, #0
	bne	.L3908
.L3841:
	cmp	r3, #0
	ble	.L3911
	movw	r3, #13656
	mov	r8, r10
	movt	r3, 170
	add	r3, r5, r3
.L3844:
	cmp	r1, #0
	beq	.L3846
	ldrb	r2, [r3, #1]
	cmp	r2, #1
	beq	.L4000
.L3846:
	ldr	r2, [r3, #660]
	str	r2, [r8, #44]
.L3847:
	mov	r1, r8
	mov	r0, r5
	str	r3, [fp, #-64]
	bl	MVC_GetImagePara
	ldrsb	r1, [r8, #6]
	ldr	r0, [r5, #120]
	bl	FSP_GetFsImagePtr
	ldr	r3, [fp, #-64]
	subs	r9, r0, #0
	beq	.L4001
	add	lr, r3, #592
	add	r1, r3, #608
	add	r0, r9, #576
	add	ip, r9, #592
	ldrd	r2, [lr, #-8]
	strd	r2, [r0, #-8]
	ldrd	r2, [lr]
	strd	r2, [r0]
	ldrd	r2, [r1, #-8]
	strd	r2, [ip, #-8]
	ldr	r2, [r8, #44]
	cmp	r2, #0
	str	r2, [r9, #160]
	beq	.L3854
	ldr	r3, [r9, #108]
	ands	r3, r3, #3
	beq	.L4002
.L3852:
	ldr	r3, [r5, #224]
	ldr	r3, [r3, #4]
	cmp	r3, r2
	bcc	.L4003
.L3854:
	mov	r2, #1
	ldrsb	r1, [r8, #6]
	ldr	r0, [r5, #120]
	bl	FSP_SetDisplay
	ldr	r0, [r5, #120]
	add	r3, r5, #584
	str	r9, [sp]
	mov	r2, r5
	mov	r1, #15
	bl	InsertImgToVoQueue
	cmp	r0, #1
	beq	.L3851
	mov	r2, #0
	ldrsb	r1, [r8, #6]
	ldr	r0, [r5, #120]
	bl	FSP_SetDisplay
.L3851:
	ldr	r3, [r5, #224]
	ldr	r3, [r3, #600]
	add	r3, r3, #2032
	add	r3, r3, #15
	cmp	r3, #4096
	movcc	r3, #0
	strcc	r3, [r9, #24]
	bcs	.L4004
.L3857:
	ldr	r3, [r5, #136]
	add	r3, r3, #2
	str	r3, [r5, #136]
.L3845:
	ldr	r3, [r5, #220]
	cmp	r3, #2
	beq	.L3858
.L3843:
	mov	r3, #1
	str	r3, [r8, #16]
	strb	r3, [r10, #8]
.L3858:
	ldr	r3, [r5, #224]
	mov	r2, #2
	str	r2, [r5, #220]
	ldr	r3, [r3, #12]
	cmp	r3, #2
	ldr	r3, [r6, #1992]
	bne	.L3859
.L3993:
	cmp	r3, #0
	beq	.L3860
	add	r4, r4, #45056
	mov	r0, r5
	bl	MVC_SimpleSlideDPB
	ldr	r1, [r4, #2728]
	cmp	r1, #0
	beq	.L3861
	ldr	r3, [r4, #2536]
	cmp	r3, #0
	beq	.L3913
	movw	r2, #47592
	mov	r3, #0
	movt	r2, 169
	add	r2, r5, r2
	b	.L3862
.L3863:
	ldr	r0, [r2, #4]!
	cmp	r0, #0
	beq	.L3913
.L3862:
	add	r3, r3, #1
	cmp	r3, r1
	bne	.L3863
.L3861:
	movw	r2, #13656
	mov	r0, r5
	movt	r2, 170
	add	r2, r5, r2
	bl	MVC_InsertFrmInDPB
	subs	r8, r0, #0
	bne	.L4005
	ldr	r1, [r4, #2732]
	mov	r0, r5
	add	r1, r1, #1
	str	r1, [r4, #2732]
	bl	MVC_UpdateReflist
	mov	r0, r5
	bl	MVC_UpdateLTReflist
	mov	r2, r8
	movw	r3, #3811
	ldr	r1, .L4014+4
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3865
.L3870:
	ldr	r3, [r5, #520]
	ldr	lr, [r6, #1976]
	cmp	r3, #0
	rsb	r2, r3, lr
	clz	r2, r2
	mov	r2, r2, lsr #5
	moveq	r2, #0
	cmp	r2, #0
	beq	.L4006
	mov	r0, r5
	bl	MVC_DirectOutput
	cmn	r0, #1
	mov	r4, r0
	beq	.L4007
.L3876:
	movw	r3, #3863
	mov	r2, r4
	ldr	r1, .L4014+4
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3832
.L3997:
	ldr	r1, .L4014+8
	movw	r2, #3913
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r1, #0
	mov	r0, r5
	bl	MVC_ClearDPB
.L3882:
	ldr	r3, [r6, #1992]
	cmp	r3, #0
	beq	.L3894
	ldrb	r3, [r6, #1372]
	cmp	r3, #0
	bne	.L3894
	ldr	r2, [r4, #2736]
	cmp	r2, #0
	beq	.L3894
	movw	ip, #47652
	mov	lr, r3
	movt	ip, 169
	add	ip, r5, ip
	b	.L3899
.L3896:
	ldr	r2, [r4, #2736]
	cmp	r2, r3
	bls	.L3894
.L3899:
	ldr	r2, [ip, #4]!
	add	r3, r3, #1
	ldr	r1, [r6, #1984]
	ldr	r0, [r2, #20]
	cmp	r0, r1
	bne	.L3896
	ldr	r0, [r2, #56]
	ldr	r1, [r6, #2056]
	cmp	r0, r1
	bne	.L3896
	strb	lr, [r2, #3]
	ldr	r1, [ip]
	ldrb	r2, [r1, #5]
	cmp	r2, #1
	streqb	r2, [r1, #7]
	ldreq	r2, [ip]
	streqb	lr, [r2, #5]
	ldreq	r1, [ip]
	ldr	r0, [r5, #52]
	ldr	r2, [r1, #48]
	cmp	r2, r0
	add	r2, r5, r2, lsl #2
	strne	lr, [r2, #148]
	strne	r0, [r1, #48]
	b	.L3896
.L3894:
	ldr	r1, [r4, #2728]
	cmp	r1, #0
	beq	.L3893
	ldr	r3, [r4, #2536]
	cmp	r3, #0
	beq	.L3917
	movw	r2, #47592
	mov	r3, #0
	movt	r2, 169
	add	r2, r5, r2
	b	.L3900
.L3901:
	ldr	r0, [r2, #4]!
	cmp	r0, #0
	beq	.L3917
.L3900:
	add	r3, r3, #1
	cmp	r3, r1
	bne	.L3901
.L3893:
	movw	r2, #13656
	mov	r0, r5
	movt	r2, 170
	add	r2, r5, r2
	bl	MVC_InsertFrmInDPB
	cmp	r0, #0
	bne	.L4008
	ldr	r3, [r4, #2732]
	mov	r0, r5
	add	r3, r3, #1
	str	r3, [r4, #2732]
	bl	MVC_UpdateReflist
	mov	r0, r5
	bl	MVC_UpdateLTReflist
.L3865:
	mov	r4, #0
.L3903:
	add	r7, r7, #12288
	mov	r3, #0
	mov	r0, r4
	strb	r3, [r7, #1368]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3829:
	mvn	r1, #0
	bl	MVC_FlushDPB
	cmp	r0, #0
	beq	.L3828
	mov	r0, r9
	ldr	r1, .L4014+12
	bl	dprint_vfmw
	movw	r3, #3640
	mvn	r2, #0
	ldr	r1, .L4014+4
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3907
.L3991:
	ldr	r2, [r5, #220]
	cmp	r2, #2
	bne	.L3833
	b	.L3834
.L4006:
	add	r4, r4, #45056
	ldr	ip, [r4, #2728]
	cmp	ip, #0
	beq	.L3873
	ldr	r3, [r4, #2536]
	adds	r1, r3, #0
	movne	r1, #1
	cmp	lr, r3
	movne	r1, #0
	cmp	r1, #0
	movweq	r2, #47592
	movteq	r2, 169
	addeq	r2, r5, r2
	bne	.L4009
.L3877:
	add	r1, r1, #1
	cmp	r1, ip
	beq	.L3871
	ldr	r3, [r2, #4]!
	adds	r0, r3, #0
	movne	r0, #1
	cmp	lr, r3
	movne	r0, #0
	cmp	r0, #0
	beq	.L3877
.L3874:
	movw	r2, #13656
	mov	r0, r5
	movt	r2, 170
	add	r2, r5, r2
	bl	MVC_InsertFrmInDPB
	cmn	r0, #1
	mov	r4, r0
	beq	.L4010
	mov	r0, r5
	bl	MVC_UpdateReflist
	mov	r0, r5
	bl	MVC_UpdateLTReflist
	movw	r3, #3889
	mov	r2, #0
	ldr	r1, .L4014+4
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3865
.L3999:
	cmp	r0, #0
	beq	.L3834
	b	.L3841
.L3917:
	mov	r1, r3
	b	.L3893
.L3888:
	mov	r3, r0
	movw	r2, #3953
	ldr	r1, .L4014+16
	mov	r0, #1
	bl	dprint_vfmw
	mov	r2, r10
	movw	r3, #3954
	ldr	r1, .L4014+4
	mov	r0, #14
	bl	dprint_vfmw
.L3907:
	ldr	r3, [r6, #1976]
	mov	r2, #1
	ldr	r0, [r5, #120]
	mvn	r4, #0
	ldrsb	r1, [r3, #6]
	bl	FSP_ClearLogicFs
	mov	r3, r4
	movw	r2, #4012
	ldr	r1, .L4014+16
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r2, [r6, #1976]
	mov	r3, #0
	strb	r3, [r2, #5]
	ldr	r2, [r6, #1976]
	strb	r3, [r2, #2]
	b	.L3903
.L3990:
	ldr	r1, .L4014+20
	bl	dprint_vfmw
	mov	r0, r5
	bl	MVC_DirectOutput
	ldr	r3, [r6, #2052]
	ldr	r2, [r5, #52]
	cmp	r3, r2
	addne	r3, r3, #36
	movne	r1, #0
	addne	r3, r5, r3, lsl #2
	mov	r4, r0
	strne	r1, [r3, #4]
	strne	r2, [r6, #2052]
	movw	r3, #3659
	mov	r2, r0
	ldr	r1, .L4014+4
	mov	r0, #14
	bl	dprint_vfmw
.L3832:
	cmn	r4, #1
	bne	.L3903
	b	.L3907
.L3838:
	cmp	r2, #1
	beq	.L4011
	cmp	r1, #0
	beq	.L3841
	ldrb	r2, [r10, #2]
	cmp	r2, #0
	bne	.L3841
	b	.L3834
.L3996:
	ldrb	r3, [r5, #8]
	cmp	r3, #2
	beq	.L4012
.L3886:
	mov	r0, r5
	bl	MVC_DirectOutput
	cmn	r0, #1
	mov	r4, r0
	beq	.L4013
.L3887:
	movw	r3, #3945
	mov	r2, r4
	ldr	r1, .L4014+4
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3832
.L3911:
	mov	r8, r10
	b	.L3845
.L3998:
	mov	r3, r8
	ldr	r2, .L4014+24
	ldr	r1, .L4014+28
	mov	r0, #1
	bl	dprint_vfmw
	movw	r3, #3922
	mvn	r2, #0
	ldr	r1, .L4014+4
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3907
.L4004:
	mov	r1, r9
	mov	r0, r5
	bl	MVC_SetFrmRepeatCount.part.1
	b	.L3857
.L3913:
	mov	r1, r3
	b	.L3861
.L4012:
	ldrb	r3, [r6, #1371]
	cmp	r3, #0
	ldrne	r3, [r6, #1976]
	strne	r3, [r5, #524]
	b	.L3886
.L4011:
	cmp	r3, #0
	ldr	r8, [r6, #2672]
	ble	.L3843
	movw	r3, #14352
	ldrb	r1, [r6, #2067]
	movt	r3, 170
	add	r3, r5, r3
	b	.L3844
.L4002:
	movw	r2, #3740
	ldr	r1, .L4014+32
	mov	r0, #1
	str	r3, [fp, #-64]
	bl	dprint_vfmw
	ldr	r2, .L4014+36
	ldr	ip, [r2]
	cmp	ip, #0
	beq	.L3853
	ldr	r3, [fp, #-64]
	mov	r1, #111
	ldr	r0, [r5, #120]
	mov	r2, r3
	blx	ip
.L3853:
	ldr	r2, [r9, #160]
	cmp	r2, #0
	bne	.L3852
	b	.L3854
.L4000:
	mov	r1, #3
	ldr	r2, [r8, #44]
	strb	r1, [r8, #2]
	ldr	r1, [r3, #660]
	add	r2, r2, r1
	str	r2, [r8, #44]
	b	.L3847
.L3988:
	mov	r0, r3
	ldr	r1, .L4014+40
	bl	dprint_vfmw
	mov	r3, #3616
	mvn	r2, #0
	ldr	r1, .L4014+4
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3907
.L4013:
	mov	r3, r0
	movw	r2, #3942
	ldr	r1, .L4014+16
	mov	r0, #1
	bl	dprint_vfmw
	b	.L3887
.L3995:
	mov	r2, r0
	ldr	r1, .L4014+44
	mov	r0, #1
	bl	dprint_vfmw
	movw	r3, #3836
	mvn	r2, #0
	ldr	r1, .L4014+4
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3907
.L4008:
	mov	r3, r0
	movw	r2, #3998
	ldr	r1, .L4014+16
	mov	r0, #1
	bl	dprint_vfmw
	movw	r3, #3999
	mvn	r2, #0
	ldr	r1, .L4014+4
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3907
.L4009:
	mov	r1, r2
	b	.L3874
.L3873:
	ldr	r3, [r6, #1992]
	cmp	r3, #0
	beq	.L3880
	ldr	r2, [r4, #2736]
	ldr	r3, [r4, #2740]
.L3905:
	str	r3, [sp, #4]
	mov	r0, #1
	mov	r3, ip
	str	r2, [sp]
	ldr	r1, .L4014+48
	movw	r2, #3902
	bl	dprint_vfmw
	mvn	r1, #0
	mov	r0, r5
	bl	MVC_ClearDPB
	movw	r3, #3905
	mvn	r2, #0
	ldr	r1, .L4014+4
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3907
.L3994:
	ldr	r1, .L4014+52
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L4014+36
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L3868
	ldr	r4, [r6, #2028]
	mov	r3, #8
	ldr	lr, [r5, #112]
	sub	r2, fp, #52
	mov	r1, #104
	ldr	r0, [r5, #120]
	str	r4, [fp, #-52]
	str	lr, [fp, #-48]
	blx	ip
.L3868:
	mov	r0, r5
	bl	MVC_ClearCurrPic
	mvn	r1, #0
	mov	r0, r5
	bl	MVC_ClearDPB
	movw	r3, #3827
	mvn	r2, #0
	ldr	r1, .L4014+4
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3907
.L4007:
	mov	r3, r0
	movw	r2, #3859
	ldr	r1, .L4014+16
	mov	r0, #1
	bl	dprint_vfmw
	b	.L3876
.L4005:
	mov	r3, r8
	movw	r2, #3802
	ldr	r1, .L4014+16
	mov	r0, #0
	bl	dprint_vfmw
	movw	r3, #3803
	mvn	r2, #0
	ldr	r1, .L4014+4
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3907
.L4010:
	mov	r3, r0
	movw	r2, #3882
	ldr	r1, .L4014+16
	mov	r0, #1
	bl	dprint_vfmw
	mov	r2, r4
	movw	r3, #3883
	ldr	r1, .L4014+4
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3907
.L4003:
	ldrsb	r1, [r8, #6]
	mov	r2, #0
	ldr	r0, [r5, #120]
	bl	FSP_SetDisplay
	movw	r3, #3759
	mvn	r2, #0
	ldr	r1, .L4014+4
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3907
.L4001:
	movw	r3, #3729
	mvn	r2, #0
	ldr	r1, .L4014+4
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3907
.L4015:
	.align	2
.L4014:
	.word	.LC423
	.word	.LC422
	.word	.LC431
	.word	.LC424
	.word	.LC427
	.word	.LC425
	.word	.LANCHOR0+348
	.word	.LC432
	.word	.LC426
	.word	g_event_report
	.word	.LC421
	.word	.LC429
	.word	.LC430
	.word	.LC428
	.fnend
	.size	MVC_StorePicInDpb, .-MVC_StorePicInDpb
	.global	__aeabi_idivmod
	.align	2
	.global	MVC_DecGap
	.type	MVC_DecGap, %function
MVC_DecGap:
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
	ldrb	r1, [r0, #3]
	add	r3, r0, #11075584
	movw	lr, #2004
	add	r7, r3, #40960
	mov	r5, r0
	mov	ip, r3
	mul	lr, lr, r1
	ldr	r2, [r7, #2516]
	ldr	r1, [r0, #236]
	add	r0, r0, #11141120
	str	r3, [fp, #-80]
	movw	r3, #26846
	mov	r4, r0
	movt	r3, 42
	str	r0, [fp, #-76]
	add	r3, r2, r3
	add	r0, r5, lr
	movw	r2, #43536
	movt	r2, 169
	add	r2, r0, r2
	add	r8, ip, #36864
	ldrb	r0, [r1, #19]
	ldrb	r2, [r2, #3]
	add	r6, r5, r3, lsl #2
	cmp	r0, #1
	movw	r3, #43536
	add	r4, r4, #12288
	add	ip, ip, #45056
	str	r2, [fp, #-72]
	movt	r3, 169
	ldr	r2, [r7, #900]
	add	r3, lr, r3
	add	r3, r5, r3
	ldr	lr, [r6, #4]
	str	r2, [fp, #-52]
	ldr	r2, [r8, #3872]
	str	r2, [fp, #-64]
	moveq	r2, #2
	movne	r2, #0
	str	r2, [fp, #-56]
	ldr	r2, [r8, #3876]
	str	r2, [fp, #-68]
	ldr	r2, [r1, #2896]
	str	r3, [r4, #1980]
	ldr	r6, [ip, #2732]
	cmp	r6, #0
	beq	.L4031
	add	r2, r2, #4
	mov	r6, #1
	mov	r3, r6, asl r2
	add	r0, lr, r6
	str	r3, [fp, #-60]
	mov	r1, r3
	bl	__aeabi_uidivmod
	mov	r3, #0
	mov	r0, #2
	str	r3, [r8, #3876]
	str	r3, [r8, #3872]
	mov	r10, r1
	ldr	r1, .L4034
	bl	dprint_vfmw
	ldr	r9, [fp, #-52]
	mov	r3, r10
	ldr	r1, .L4034+4
	mov	r0, #2
	mov	r2, r9
	bl	dprint_vfmw
	cmp	r9, r10
	mov	r3, r9
	movgt	r3, r4
	movgt	r4, r10
	movgt	r10, r3
	bgt	.L4024
	b	.L4025
.L4022:
	strb	r9, [r10, #1372]
	mov	r0, r5
	bl	MVC_StorePicInDpb
	movw	lr, #26846
	movt	lr, 42
	ldr	r1, [fp, #-60]
	subs	r3, r0, #0
	add	r0, r4, #1
	bne	.L4032
	ldr	r3, [r7, #2516]
	add	lr, r3, lr
	add	lr, r5, lr, lsl #2
	str	r4, [lr, #4]
	bl	__aeabi_idivmod
	ldr	r3, [fp, #-52]
	cmp	r3, r1
	mov	r4, r1
	ble	.L4025
.L4024:
	mov	r1, #1
	mov	r0, r5
	bl	MVC_AllocFrameStore
	mov	r9, #0
	ldr	r1, .L4034+8
	subs	r3, r0, #0
	mov	r0, #2
	bne	.L4033
	str	r3, [fp, #-48]
	bl	dprint_vfmw
	ldr	r1, [r10, #1976]
	strb	r6, [r10, #1374]
	ldr	r3, [fp, #-56]
	str	r4, [r1, #20]
	ldr	r1, [r10, #1976]
	str	r4, [r10, #1984]
	str	r4, [r1, #676]
	str	r3, [r10, #1992]
	ldr	r1, [r10, #1976]
	ldr	r3, [fp, #-48]
	str	r3, [r1, #672]
	ldr	r1, [r10, #1976]
	strb	r6, [r1, #7]
	ldr	r1, [r10, #1976]
	strb	r3, [r1, #5]
	ldr	r1, [r10, #1976]
	strb	r6, [r1, #1]
	strb	r6, [r10, #1370]
	ldr	r1, [r10, #1980]
	ldr	r0, [r7, #2512]
	str	r0, [r10, #2056]
	strb	r3, [r1, #3]
	ldr	r3, [r5, #236]
	ldr	r3, [r3, #2900]
	cmp	r3, #0
	beq	.L4022
	str	r4, [r8, #3888]
	mov	r0, r5
	bl	MVC_DecPOC
	ldr	r3, [r8, #3868]
	str	r3, [r10, #1996]
	ldr	r3, [r8, #3864]
	str	r3, [r10, #2000]
	ldr	r3, [r8, #3856]
	str	r3, [r10, #2004]
	ldr	r3, [r8, #3860]
	str	r3, [r10, #2008]
	b	.L4022
.L4031:
	ldr	r1, .L4034+12
	mov	r0, r6
	bl	dprint_vfmw
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L4025:
	ldr	r2, [fp, #-64]
	mov	r0, #0
	ldr	r3, [fp, #-76]
	str	r2, [r8, #3872]
	add	r3, r3, #12288
	ldr	r2, [fp, #-68]
	str	r2, [r8, #3876]
	ldrb	r2, [fp, #-72]
	ldr	r3, [r3, #1980]
	strb	r2, [r3, #3]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L4033:
	ldr	r2, [fp, #-64]
	mov	r0, r9
	ldr	r3, [fp, #-76]
	ldr	r1, .L4034+16
	str	r2, [r8, #3872]
	add	r3, r3, #12288
	ldr	r2, [fp, #-68]
	str	r2, [r8, #3876]
	ldrb	r2, [fp, #-72]
	ldr	r3, [r3, #1980]
	strb	r2, [r3, #3]
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L4032:
	ldr	r2, [fp, #-80]
	mov	r0, r9
	ldr	ip, [fp, #-64]
	add	r1, r2, #36864
	ldrb	lr, [fp, #-72]
	movw	r2, #6926
	str	ip, [r1, #3872]
	ldr	ip, [fp, #-68]
	str	ip, [r1, #3876]
	ldr	ip, [r10, #1980]
	ldr	r1, .L4034+20
	strb	lr, [ip, #3]
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L4035:
	.align	2
.L4034:
	.word	.LC434
	.word	.LC435
	.word	.LC437
	.word	.LC433
	.word	.LC436
	.word	.LC438
	.fnend
	.size	MVC_DecGap, .-MVC_DecGap
	.align	2
	.global	MVC_InitPic
	.type	MVC_InitPic, %function
MVC_InitPic:
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
	add	r5, r0, #11141120
	add	r8, r0, #11075584
	add	r5, r5, #12288
	add	r6, r8, #40960
	ldr	r3, [r0, #252]
	mov	r4, r0
	ldrb	r0, [r5, #1368]
	mov	r1, #0
	ldr	r2, [r6, #888]
	mov	r9, #2240
	cmp	r0, r1
	str	r1, [fp, #-48]
	mla	r9, r9, r2, r3
	beq	.L4037
	ldr	r3, [r5, #1976]
	cmp	r3, r1
	beq	.L4038
	ldrb	r7, [r3, #2]
	cmp	r7, r1
	beq	.L4195
.L4038:
	mov	r3, #0
	strb	r3, [r5, #1368]
.L4037:
	sub	r1, fp, #48
	mov	r0, r4
	bl	MVC_GetReRangeFlag
	ldrb	r3, [r6, #884]
	cmp	r3, #255
	mov	r10, r0
	beq	.L4196
.L4039:
	cmp	r3, #0
	bne	.L4042
	ldrb	r2, [r4, #2]
	cmp	r2, #1
	beq	.L4197
	ldr	r3, [r9, #28]
	ldr	r2, [r4, #28]
	cmp	r2, r3
	movweq	r3, #35364
	movteq	r3, 168
	addeq	r3, r4, r3
	streq	r3, [r4, #236]
	bne	.L4198
.L4042:
	add	r7, r8, #36864
	ldr	r3, [r9, #24]
	ldr	r2, [r7, #1616]
	cmp	r2, r3
	beq	.L4199
.L4046:
	mov	r3, #0
	mov	r1, r9
	strb	r3, [r9, #20]
	ldr	r0, [r4, #236]
	bl	mvc_assign_quant_params
	ldr	r3, .L4212
	movw	r0, #38456
	mov	r2, #2240
	movt	r0, 169
	mov	r1, r9
	add	r0, r4, r0
	ldr	r3, [r3, #56]
	blx	r3
.L4047:
	ldr	r3, [fp, #-48]
	cmp	r3, #0
	ldr	r3, [r4, #224]
	bne	.L4200
	ldr	r3, [r3, #864]
	cmp	r3, #1
	beq	.L4049
.L4058:
	ldr	r2, [r7, #1616]
	ldr	r3, [r9, #24]
	cmp	r2, r3
	bne	.L4067
	ldrb	r3, [r9, #20]
	cmp	r3, #0
	bne	.L4067
.L4068:
	ldrb	r3, [r6, #884]
	cmp	r3, #255
	moveq	r3, #0
	streq	r3, [r6, #2516]
	beq	.L4070
	cmp	r3, #0
	bne	.L4070
	add	r1, r4, #10747904
	movw	r2, #22868
	add	r1, r1, #20480
	movt	r2, 164
	ldr	ip, [r6, #2512]
	add	r2, r4, r2
	ldr	r0, [r1, #2384]
	adds	r0, r0, #1
	beq	.L4071
	ldr	r1, [r1, #2388]
	cmp	ip, r1
	beq	.L4112
	mov	lr, r0
	b	.L4072
.L4073:
	ldr	r1, [r2, #4]!
	cmp	ip, r1
	beq	.L4071
.L4072:
	add	r3, r3, #1
	cmp	r3, lr
	mov	r0, r3
	bne	.L4073
.L4071:
	str	r0, [r6, #2516]
.L4070:
	ldrb	r2, [r6, #875]
	ldr	r3, [r4, #236]
	cmp	r2, #5
	ldreq	r2, [r6, #2516]
	ldr	r10, [r3, #2896]
	movweq	r3, #26846
	movteq	r3, 42
	addeq	r3, r2, r3
	ldreq	r9, [r6, #900]
	addeq	r3, r4, r3, lsl #2
	ldrne	r9, [r6, #900]
	streq	r9, [r3, #4]
	ldrb	r3, [r4, #8]
	cmp	r3, #2
	beq	.L4076
	ldr	r2, [r4, #224]
	ldr	r3, [r2, #12]
	str	r2, [fp, #-56]
	cmp	r3, #2
	beq	.L4076
	ldr	r1, [r6, #2516]
	movw	r3, #26846
	movt	r3, 42
	add	r3, r1, r3
	add	r3, r4, r3, lsl #2
	ldr	r0, [r3, #4]
	cmp	r0, r9
	beq	.L4076
	mov	r3, #1
	add	r10, r10, #4
	mov	r10, r3, asl r10
	add	r0, r0, r3
	str	r3, [fp, #-60]
	mov	r1, r10
	bl	__aeabi_uidivmod
	cmp	r1, r9
	beq	.L4076
	ldr	r3, [fp, #-60]
	ldr	r2, [fp, #-56]
	str	r3, [r2, #596]
	ldr	r3, [r4, #224]
	ldr	r2, [r3, #596]
	cmp	r2, #0
	beq	.L4201
.L4077:
	add	r3, r8, #32768
	ldrb	r3, [r3, #1715]
	cmp	r3, #0
	bne	.L4086
	ldr	r1, .L4212+4
	mov	r0, #2
	bl	dprint_vfmw
	ldr	r3, [r4, #224]
	ldr	r3, [r3, #600]
	bics	r3, r3, #1024
	bne	.L4193
	ldr	r2, [r6, #2512]
	cmp	r2, #0
	bne	.L4193
	ldr	r0, [r6, #2516]
	movw	r3, #26846
	movt	r3, 42
	mov	r1, r10
	add	r3, r0, r3
	str	r2, [fp, #-56]
	ldr	r9, [r6, #900]
	add	r3, r4, r3, lsl #2
	ldr	r0, [r3, #4]
	add	r0, r0, #1
	bl	__aeabi_uidivmod
	cmp	r9, r1
	bcs	.L4076
	ldrb	r3, [r6, #872]
	cmp	r3, #2
	beq	.L4076
	mov	r0, r4
	bl	MVC_ClearCurrPic
	mvn	r1, #0
	mov	r0, r4
	bl	MVC_ClearDPB
	ldr	r3, [r6, #2516]
	movw	r0, #26846
	mov	r1, r10
	movt	r0, 42
	add	r0, r3, r0
	ldr	r5, [r6, #900]
	add	r0, r4, r0, lsl #2
	ldr	r0, [r0, #4]
	add	r0, r0, #1
	bl	__aeabi_uidivmod
	ldr	r2, [fp, #-56]
	mov	r3, r5
	mov	r0, r2
	movw	r2, #7452
	str	r1, [sp]
	ldr	r1, .L4212+8
	bl	dprint_vfmw
	mvn	r0, #0
.L4184:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L4200:
	ldr	r2, [r3, #700]
	cmp	r2, #0
	bne	.L4049
	ldr	r3, [r3, #28]
	cmp	r3, #25
	beq	.L4202
.L4049:
	ldr	r3, [r4, #84]
	cmp	r10, #0
	add	r3, r3, #1
	str	r3, [r4, #84]
	bne	.L4059
	ldr	r3, [r4, #224]
	ldr	r3, [r3, #864]
	cmp	r3, #1
	beq	.L4060
	mvn	r1, #0
	mov	r0, r4
	bl	MVC_FlushDPB
	cmp	r0, #0
	bne	.L4203
.L4192:
	mov	r0, r4
	bl	MVC_InitDPB
	cmp	r0, #0
	bne	.L4110
	ldr	r3, [r4, #224]
	ldr	r3, [r3, #864]
	cmp	r3, #1
	bne	.L4058
.L4064:
	ldr	r1, [r7, #1572]
	add	ip, r8, #32768
	add	r3, r4, #48
	mov	r0, r4
	mov	r1, r1, asl #1
	str	r1, [r4, #52]
	ldr	r2, [r7, #1552]
	ldrb	r10, [ip, #1716]
	add	r2, r2, #1
	ldr	ip, [r7, #1548]
	rsb	r10, r10, #2
	str	r1, [sp]
	mov	r2, r2, asl #4
	add	ip, ip, #1
	mul	r10, r10, r2
	mov	ip, ip, asl #4
	str	ip, [fp, #-56]
	mov	r1, ip
	mov	r2, r10
	bl	MVC_ArrangeVahbMem
	ldr	ip, [fp, #-56]
	cmp	r0, #1
	beq	.L4185
.L4190:
	ldr	r3, [r4, #224]
	ldr	r3, [r3, #864]
	cmp	r3, #1
	mvneq	r0, #1
	beq	.L4184
	mov	r5, #0
	ldr	r1, .L4212+12
	str	r5, [r4, #12]
	mov	r0, r5
	str	r5, [r4, #16]
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r4
	bl	MVC_ClearAll
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L4067:
	ldr	r3, .L4212
	movw	r0, #38456
	mov	r2, #0
	movt	r0, 169
	strb	r2, [r9, #20]
	add	r0, r4, r0
	mov	r1, r9
	ldr	r3, [r3, #56]
	mov	r2, #2240
	blx	r3
	b	.L4068
.L4086:
	mov	r0, r4
	bl	MVC_DecGap
	cmp	r0, #0
	bne	.L4089
.L4193:
	ldr	r9, [r6, #900]
.L4076:
	ldrb	r3, [r6, #880]
	cmp	r3, #0
	beq	.L4090
	ldr	r2, [r6, #2516]
	movw	r3, #26846
	movt	r3, 42
	add	r3, r2, r3
	add	r3, r4, r3, lsl #2
	str	r9, [r3, #4]
.L4090:
	mov	r0, r4
	str	r9, [r7, #3888]
	bl	MVC_DecPOC
	mov	r1, #0
	mov	r0, r4
	bl	MVC_AllocFrameStore
	cmp	r0, #0
	bne	.L4204
	strb	r0, [r5, #1375]
	mov	r1, #1
	strb	r1, [r5, #1368]
	ldrb	r3, [r6, #875]
	strb	r3, [r5, #1374]
	ldr	r10, [r6, #900]
	str	r10, [r5, #1984]
	ldrb	r9, [r6, #880]
	str	r9, [r5, #1992]
	ldr	ip, [r7, #3868]
	str	ip, [r5, #1996]
	ldr	r3, [r7, #3864]
	str	r3, [r5, #2000]
	ldr	r2, [r7, #3856]
	str	r2, [r5, #2004]
	ldr	lr, [r7, #3860]
	str	r3, [r5, #2016]
	mvn	r3, #0
	str	ip, [r5, #2012]
	str	lr, [r5, #2024]
	str	r2, [r5, #2020]
	str	lr, [r5, #2008]
	strb	r0, [r5, #1370]
	strb	r0, [r5, #1373]
	strb	r0, [r5, #1372]
	str	r3, [r5, #2048]
	ldrb	ip, [r6, #873]
	cmp	ip, #0
	strneb	r1, [r6, #873]
	ldr	r2, [r4, #236]
	movne	ip, r1
	movne	r1, #2
	str	ip, [fp, #-60]
	ldrb	r0, [r2, #20]
	ldr	r3, [r2, #3952]
	rsb	r0, r0, #2
	str	r2, [fp, #-56]
	mla	r0, r3, r0, r0
	bl	__aeabi_uidiv
	ldr	r2, [fp, #-56]
	ldr	ip, [fp, #-60]
	cmp	ip, #0
	str	r0, [r5, #2036]
	ldrb	r3, [r2, #20]
	ldr	ip, [r2, #3952]
	rsb	r1, r3, #2
	mla	r1, ip, r1, r1
	str	r1, [r5, #2040]
	ldr	r1, [r2, #3948]
	add	r3, r1, #1
	str	r3, [r5, #2032]
	mul	r3, r3, r0
	str	r3, [r5, #2044]
	ldrb	r3, [r7, #1592]
	strb	r3, [r5, #1376]
	movne	r3, #0
	bne	.L4093
	ldrb	r3, [r2, #21]
	adds	r3, r3, #0
	movne	r3, #1
.L4093:
	cmp	r9, #0
	strb	r3, [r5, #1377]
	beq	.L4094
	ldr	r2, [r6, #2516]
	movw	r3, #26846
	movt	r3, 42
	add	r3, r2, r3
	add	r3, r4, r3, lsl #2
	str	r10, [r3, #4]
.L4094:
	ldr	r3, [r5, #1976]
	cmp	r3, #0
	ldrneb	r2, [r6, #884]
	strneb	r2, [r3, #9]
	mvn	r3, #0
	str	r3, [r5, #2056]
	ldrb	r3, [r6, #883]
	cmp	r3, #0
	beq	.L4096
	ldr	r3, [r6, #2512]
	str	r3, [r5, #2056]
	ldrb	r3, [r6, #881]
	strb	r3, [r5, #1378]
	ldrb	r3, [r6, #882]
	strb	r3, [r5, #1379]
.L4096:
	ldr	r3, [r6, #2516]
	movw	r10, #2004
	movw	ip, #43536
	movw	lr, #14240
	movt	ip, 169
	movt	lr, 170
	str	r3, [r5, #2060]
	movw	r7, #14256
	ldrb	r1, [r4, #3]
	movt	r7, 170
	add	r7, r4, r7
	movw	r9, #14256
	movt	r9, 170
	mov	r0, #29
	mla	r10, r10, r1, r4
	ldr	r1, .L4212+16
	add	r8, r8, #32768
	add	ip, r10, ip
	str	ip, [r5, #1980]
	ldr	ip, [r4, #224]
	ldrd	r2, [ip, #56]
	strd	r2, [r4, lr]
	ldrd	r2, [ip, #72]
	strd	r2, [r7, #-8]
	ldrd	r2, [ip, #88]
	strd	r2, [r4, r9]
	mvn	r2, #0
	mvn	r3, #0
	strd	r2, [ip, #56]
	ldrd	r2, [r4, lr]
	bl	dprint_vfmw
	ldrd	r2, [r7, #-8]
	ldr	r1, .L4212+20
	mov	r0, #29
	bl	dprint_vfmw
	ldr	ip, [r4, #236]
	movw	lr, #8864
	movw	r0, #13672
	movt	r0, 170
	add	r0, r4, r0
	ldr	r3, [ip, #3948]
	add	r3, r3, #1
	mov	r3, r3, asl #4
	str	r3, [r5, #1496]
	ldrb	r2, [ip, #20]
	ldr	r1, [ip, #3952]
	rsb	r3, r2, #2
	mla	r3, r1, r3, r3
	mov	r3, r3, asl #4
	str	r3, [r5, #1500]
	ldr	r1, [r8, #1748]
	str	lr, [r5, #1492]
	ldr	r2, [ip, #56]
	and	r1, r1, #7
	ldrb	r3, [ip, #52]
	ldr	ip, [ip, #748]
	mov	r2, r2, asl #5
	subs	ip, ip, #1
	uxtb	r2, r2
	movne	ip, #1
	orr	r3, r2, r3, asl #14
	orr	r3, r3, ip, asl #2
	str	r3, [r5, #1492]
	bl	SetAspectRatio
	ldr	r0, [r5, #1976]
	ldr	r3, [r4, #84]
	cmp	r0, #0
	str	r3, [r5, #1548]
	beq	.L4205
	ldr	r3, [r4, #236]
	ldr	r3, [r3, #3984]
	str	r3, [r0, #200]
	str	r3, [r5, #1512]
	ldr	r3, [r4, #236]
	ldr	r2, [r5, #1976]
	ldr	r3, [r3, #3988]
	str	r3, [r2, #204]
	str	r3, [r5, #1516]
	ldr	r3, [r4, #236]
	ldr	r2, [r5, #1976]
	ldr	r3, [r3, #3976]
	str	r3, [r2, #192]
	str	r3, [r5, #1504]
	ldr	r2, [r4, #236]
	ldr	r3, [r5, #1976]
	ldr	r2, [r2, #3980]
	str	r2, [r3, #196]
	ldrb	r3, [r5, #1371]
	ldr	r1, [r5, #1976]
	ldr	r0, [r5, #1492]
	adds	r3, r3, #0
	str	r2, [r5, #1508]
	movne	r3, #1
	str	r3, [r5, #1480]
	str	r0, [r1, #180]
	ldr	r2, [r5, #1480]
	ldr	r3, [r5, #1976]
	str	r2, [r3, #168]
	ldr	r3, [r6, #900]
	ldr	r2, [r5, #1976]
	str	r3, [r5, #1568]
	ldr	r1, [r6, #2512]
	str	r1, [r5, #1576]
	str	r3, [r2, #256]
	ldr	r3, [r5, #1976]
	ldr	r2, [r6, #2512]
	str	r2, [r3, #264]
	ldr	r3, [r5, #1976]
	ldr	r0, [r4, #120]
	ldrsb	r1, [r3, #6]
	bl	FSP_GetDispPhyFs
	cmp	r0, #0
	beq	.L4098
	ldr	r3, [r5, #1480]
	mov	r1, #0
	ldr	r2, [r0, #8]
	subs	r3, r3, r1
	ldr	r0, [r4, #120]
	movne	r3, #1
	bl	FSP_SetStoreType
.L4098:
	movw	ip, #14192
	movw	lr, #14224
	ldr	r3, [r4, #60]
	movt	ip, 170
	movt	lr, 170
	add	ip, r4, ip
	add	lr, r4, lr
	mov	r6, #0
.L4102:
	ldrd	r0, [ip, #8]!
	orrs	r2, r0, r1
	bne	.L4099
	cmp	r3, #0
	beq	.L4099
	ldr	r2, [r4, #528]
	subs	r3, r3, #1
	stmia	ip, {r2, r6}
	beq	.L4100
	add	r1, r4, #528
	mov	r2, #0
.L4101:
	add	r2, r2, #1
	ldr	r0, [r1, #4]!
	cmp	r2, r3
	str	r0, [r1, #-4]
	bne	.L4101
.L4100:
	add	r2, r3, #132
	str	r6, [r4, r2, asl #2]
	str	r3, [r4, #60]
.L4099:
	cmp	ip, lr
	bne	.L4102
	cmp	r3, #0
	beq	.L4104
	mov	r6, r3
	ble	.L4104
	add	r7, r3, #132
	mov	r8, #0
	add	r7, r4, r7, lsl #2
.L4105:
	ldr	r1, [r7, #-4]!
	sub	r6, r6, #1
	ldr	r0, [r4, #120]
	bl	FreeUsdByDec
	cmp	r6, #0
	str	r8, [r7]
	bne	.L4105
.L4104:
	mov	r6, #0
	mov	r0, r4
	str	r6, [r4, #60]
	strb	r6, [r5, #1380]
	bl	MVC_UpdateReflist
	mov	r0, r4
	bl	MVC_UpdateLTReflist
	mov	r0, r4
	bl	MVC_CalcPicNum
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L4199:
	ldrb	r3, [r9, #20]
	cmp	r3, #0
	beq	.L4047
	b	.L4046
.L4196:
	mov	r2, #1
	strb	r2, [r4, #2]
	ldr	r2, [r9, #28]
	movw	lr, #3992
	ldr	ip, [r4, #248]
	add	r1, r8, #32768
	movw	r7, #34464
	str	r2, [r4, #24]
	ldr	r2, [r9, #28]
	ldr	r0, [r1, #2440]
	mla	r2, lr, r2, ip
	ldr	r1, [r2, #744]
	cmp	r0, r1
	beq	.L4206
.L4040:
	ldr	ip, .L4212
	movt	r7, 169
	ldr	r3, [r4, #84]
	add	r7, r4, r7
	mov	lr, #0
	mov	r1, r2
	add	r3, r3, #1
	mov	r0, r7
	str	r3, [r4, #84]
	strb	lr, [r2, #26]
	movw	r2, #3992
	ldr	r3, [ip, #56]
	blx	r3
	ldrb	r3, [r6, #884]
.L4041:
	str	r7, [r4, #236]
	b	.L4039
.L4060:
	ldr	r1, .L4212+24
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r4
	bl	MVC_GetBackPicFromVOQueue
	b	.L4192
.L4206:
	ldrb	r1, [r2, #26]
	cmp	r1, #0
	movteq	r7, 169
	addeq	r7, r4, r7
	beq	.L4041
	b	.L4040
.L4195:
	ldrsb	r1, [r3, #6]
	mov	r2, #1
	ldr	r0, [r4, #120]
	bl	FSP_ClearLogicFs
	ldr	r3, [r5, #1976]
	strb	r7, [r3, #2]
	ldr	r3, [r5, #1976]
	strb	r7, [r3, #5]
	b	.L4038
.L4201:
	ldr	r2, [r3, #632]
	cmp	r2, #1
	beq	.L4207
.L4078:
	ldr	r3, [r6, #2516]
	ldr	r1, [r6, #900]
	add	r3, r4, r3, lsl #2
	add	r3, r3, #11075584
	add	r2, r3, #40960
	ldr	r2, [r2, #892]
	cmp	r1, r2
	bls	.L4079
	ldr	ip, [r7, #1572]
	rsb	r0, r2, r1
	cmp	r2, #0
	cmpne	ip, r0
	bcs	.L4077
	ldrb	r2, [r6, #872]
	cmp	r2, #2
	bne	.L4208
	add	r3, r3, #40960
	cmp	r1, #0
	subne	r2, r1, #1
	subeq	r2, r10, #1
	mvn	r1, #0
	str	r2, [r3, #892]
	mov	r0, r4
	bl	MVC_FlushDPB
	subs	r3, r0, #0
	beq	.L4077
	movw	r2, #7398
	ldr	r1, .L4212+28
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4184
.L4202:
	ldr	r3, [r4, #84]
	cmp	r10, #0
	add	r3, r3, #1
	str	r3, [r4, #84]
	beq	.L4050
	mvn	r1, #0
	mov	r0, r4
	str	r2, [fp, #-56]
	bl	MVC_FlushDPB
	ldr	r2, [fp, #-56]
	subs	r3, r0, #0
	bne	.L4209
	mov	r0, r4
	bl	MVC_InitDPB
	subs	r3, r0, #0
	bne	.L4107
	add	r2, r8, #32768
	ldr	r3, [r7, #1552]
	ldr	ip, [r7, #1548]
	ldrb	r10, [r2, #1716]
	add	r3, r3, #1
	ldr	r2, [r4, #12]
	add	ip, ip, #1
	mov	r3, r3, asl #4
	rsb	r10, r10, #2
	cmp	r2, #0
	mov	ip, ip, asl #4
	mul	r10, r10, r3
	bne	.L4185
	ldr	r3, [r7, #1572]
	ldr	r0, [r4, #224]
	mov	r3, r3, asl #1
	str	r3, [r4, #52]
	ldr	r1, [r0, #660]
	str	r3, [fp, #-56]
	cmp	r1, ip
	bcc	.L4052
	ldr	r2, [r0, #664]
	cmp	r2, r10
	bcc	.L4052
	add	lr, r8, #45056
	ldr	r3, [r0, #684]
	ldr	lr, [lr, #2728]
	cmp	r3, lr
	bcc	.L4210
	ldr	lr, [r0, #688]
	str	ip, [fp, #-60]
	cmp	lr, #0
	moveq	r3, #1
	streq	r3, [r4, #52]
	streq	r3, [fp, #-56]
	ldr	r3, [fp, #-56]
	ldreq	r1, [r0, #660]
	ldreq	r2, [r0, #664]
	mov	r0, r4
	str	r3, [sp]
	add	r3, r4, #48
	bl	MVC_ArrangeVahbMem
	ldr	ip, [fp, #-60]
	cmp	r0, #1
	bne	.L4190
.L4185:
	mov	ip, ip, lsr #4
	mov	r10, r10, lsr #4
	str	ip, [r4, #12]
	str	r10, [r4, #16]
	b	.L4058
.L4197:
	strb	r3, [r4, #2]
	movw	r1, #8500
	ldr	r3, [r9, #28]
	movt	r1, 5
	mov	r2, r1
	ldr	ip, .L4212
	movw	r0, #22860
	mla	r1, r1, r3, r4
	movt	r0, 164
	ldr	r3, [ip, #56]
	add	r0, r4, r0
	add	r1, r1, #12992
	add	r1, r1, #12
	blx	r3
	add	r2, r4, #11010048
	add	r2, r2, #32768
	movw	r3, #35364
	movt	r3, 168
	add	r3, r4, r3
	str	r3, [r4, #236]
	ldr	r3, [r2, #3340]
	str	r3, [r4, #28]
	b	.L4042
.L4059:
	ldr	r1, .L4212+24
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r4
	bl	MVC_GetBackPicFromVOQueue
	mov	r0, r4
	bl	MVC_InitDPB
	cmp	r0, #0
	beq	.L4064
.L4110:
	mov	r3, r0
	movw	r2, #7287
	ldr	r1, .L4212+32
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4184
.L4079:
	rsb	r0, r2, r1
	ldr	ip, [r7, #1572]
	add	r0, r0, r10
	cmp	r2, #0
	cmpne	ip, r0
	bcs	.L4077
	ldrb	r2, [r6, #872]
	cmp	r2, #2
	bne	.L4211
	add	r3, r3, #40960
	cmp	r1, #0
	subne	r2, r1, #1
	subeq	r2, r10, #1
	mvn	r1, #0
	str	r2, [r3, #892]
	mov	r0, r4
	bl	MVC_FlushDPB
	subs	r3, r0, #0
	beq	.L4077
	movw	r2, #7425
	ldr	r1, .L4212+28
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4184
.L4050:
	mov	r0, r4
	bl	MVC_InitDPB
	subs	r3, r0, #0
	bne	.L4107
	ldr	r3, [r7, #1552]
	add	r2, r8, #32768
	ldr	ip, [r7, #1548]
	add	r3, r3, #1
	ldrb	r10, [r2, #1716]
	add	ip, ip, #1
	mov	r3, r3, asl #4
	rsb	r10, r10, #2
	mov	ip, ip, asl #4
	mul	r10, r10, r3
	b	.L4185
.L4198:
	ldr	r1, .L4212+36
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4184
.L4089:
	movw	r2, #7479
	ldr	r1, .L4212+40
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4184
.L4207:
	ldr	r2, [r3, #628]
	cmp	r2, #0
	bne	.L4078
	ldr	r2, [r3, #636]
	cmp	r2, #0
	bne	.L4078
	ldr	r3, [r3, #600]
	add	r3, r3, #1024
	cmp	r3, #2048
	bhi	.L4077
	b	.L4078
.L4112:
	mov	r0, r3
	b	.L4071
.L4204:
	movw	r2, #7499
	ldr	r1, .L4212+44
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4184
.L4205:
	movw	r2, #7607
	ldr	r1, .L4212+48
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4184
.L4203:
	mov	r3, r0
	movw	r2, #7278
	mov	r0, r10
	ldr	r1, .L4212+28
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4184
.L4208:
	mov	r0, r4
	bl	MVC_ClearCurrPic
	mvn	r1, #0
	mov	r0, r4
	bl	MVC_ClearDPB
	ldr	r2, [r6, #2516]
	ldr	r3, [r7, #1572]
	movw	r1, #26846
	ldr	ip, [r6, #900]
	movt	r1, 42
	add	r1, r2, r1
	movw	r2, #7387
.L4194:
	add	r4, r4, r1, lsl #2
	str	r3, [sp]
	ldr	r1, .L4212+52
	mov	r0, #0
	ldr	r3, [r4, #4]
	rsb	r3, r3, ip
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4184
.L4107:
	movw	r2, #7203
	ldr	r1, .L4212+32
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4184
.L4211:
	mov	r0, r4
	bl	MVC_ClearCurrPic
	mvn	r1, #0
	mov	r0, r4
	bl	MVC_ClearDPB
	ldr	r2, [r6, #2516]
	movw	r1, #26846
	ldr	r3, [r7, #1572]
	movt	r1, 42
	ldr	ip, [r6, #900]
	add	r1, r2, r1
	movw	r2, #7414
	b	.L4194
.L4052:
	ldr	r1, .L4212+56
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4184
.L4209:
	mov	r0, r2
	ldr	r1, .L4212+28
	movw	r2, #7194
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4184
.L4210:
	ldr	r1, .L4212+60
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4184
.L4213:
	.align	2
.L4212:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC445
	.word	.LC446
	.word	.LC443
	.word	.LC449
	.word	.LC450
	.word	.LC452
	.word	.LC439
	.word	.LC440
	.word	.LC30
	.word	.LC447
	.word	.LC448
	.word	.LC451
	.word	.LC444
	.word	.LC441
	.word	.LC442
	.fnend
	.size	MVC_InitPic, .-MVC_InitPic
	.align	2
	.global	MVC_DecSlice
	.type	MVC_DecSlice, %function
MVC_DecSlice:
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
	ldr	r2, [r0, #68]
	mov	r5, r0
	ldr	r1, .L4267
	mov	r0, #22
	sub	r2, r2, #1
	add	r4, r5, #11075584
	bl	dprint_vfmw
	ldr	r3, [r5, #232]
	add	r4, r4, #40960
	mov	r0, r5
	ldrb	r2, [r3, #2]
	strb	r2, [r4, #875]
	ldrb	r3, [r3, #4]
	strb	r3, [r4, #880]
	bl	MVC_ProcessSliceHeaderFirstPart
	cmp	r0, #0
	bne	.L4260
	mov	r0, r5
	bl	MVC_ProcessSliceHeaderSecondPart
	cmp	r0, #0
	bne	.L4260
	ldr	r2, [r5, #64]
	cmp	r2, #0
	moveq	r3, r2
	beq	.L4221
	mov	r1, r0
	movw	r8, #15072
	movt	r8, 170
	mov	r3, r1
	add	r8, r5, r8
	mov	r6, r1
	b	.L4229
.L4261:
	cmp	lr, r1
	add	r3, r7, r3
	rsbhi	r1, r1, lr
	rsbhi	r0, r0, r9
	addhi	r1, r1, r0
	movls	r1, r9
	add	r3, r3, r1
.L4227:
	cmp	ip, #0
	add	r6, r6, #1
	movne	r1, ip
	movne	r0, r7
	moveq	r1, lr
	moveq	r0, r9
	cmp	r6, r2
	beq	.L4221
.L4229:
	ldr	r7, [r8, #4]!
	ldr	lr, [r7, #8]
	ldr	ip, [r7, #36]
	cmp	lr, #0
	ldrne	r9, [r7, #12]
	moveq	r9, lr
	cmp	ip, #0
	ldrne	r7, [r7, #40]
	moveq	r7, ip
	cmp	r1, #0
	bne	.L4261
	add	r3, r9, r3
	add	r3, r3, r7
	b	.L4227
.L4221:
	add	r6, r5, #11141120
	str	r3, [r5, #104]
	add	r6, r6, #12288
	movw	r0, #1620
	ldr	ip, [r6, #2036]
	ldr	r1, [r6, #2032]
	mul	r1, r1, ip
	cmp	r1, r0
	movgt	r1, r1, asl #7
	ble	.L4262
.L4231:
	ldr	r0, [r5, #32]
	cmp	r0, r2
	bls	.L4232
	cmp	r1, r3
	bcc	.L4232
	ldrb	r3, [r4, #877]
	cmp	r3, #0
	bne	.L4263
.L4235:
	mov	r0, r5
	bl	MVC_PicTypeStatistic
	mov	r0, r5
	bl	MVC_DecList
	cmp	r0, #0
	bne	.L4264
	mov	r0, r5
	bl	MVC_IsRefListWrong
	subs	r4, r0, #0
	bne	.L4265
	mov	r0, r5
	bl	MVC_CalcStreamBits
	mov	r0, r5
	bl	MVC_WriteSliceMsg
	mov	r0, r5
	bl	MVC_ExitSlice
	ldr	r3, [r5, #100]
	mov	r0, r4
	mov	r2, #1
	add	r3, r3, r2
	strb	r2, [r5, #4]
	str	r3, [r5, #100]
.L4218:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L4262:
	mov	r0, r1, asl #10
	movw	ip, #32769
	sub	r1, r0, r1, asl #8
	cmp	r1, ip
	movgt	r1, r1, asr #1
	movle	r1, #16384
	b	.L4231
.L4263:
	ldr	r1, .L4267+4
	mov	r0, #2
	bl	dprint_vfmw
	ldr	r3, [r5, #88]
	mov	r2, #0
	str	r2, [r5, #100]
	add	r3, r3, #1
	str	r3, [r5, #88]
	ldrb	r3, [r6, #1371]
	mov	r0, r5
	cmp	r3, r2
	ldreq	r3, [r5, #92]
	ldrne	r3, [r5, #96]
	addeq	r3, r3, #1
	addne	r3, r3, #1
	streq	r3, [r5, #92]
	strne	r3, [r5, #96]
	bl	MVC_InitPic
	cmn	r0, #2
	beq	.L4218
	cmp	r0, #0
	bne	.L4266
	mov	r0, r5
	bl	MVC_WritePicMsg
	b	.L4235
.L4260:
	ldr	r1, .L4267+8
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L4267+12
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L4258
	sub	r2, fp, #36
	mvn	r1, #0
	mov	r3, #4
	str	r1, [r2, #-8]!
	mov	r1, #100
	ldr	r0, [r5, #120]
	blx	ip
.L4258:
	mov	r0, r5
	bl	MVC_ClearCurrSlice
	mvn	r0, #0
	b	.L4218
.L4232:
	str	r1, [sp]
	mov	r0, #0
	ldr	r1, .L4267+16
	bl	dprint_vfmw
	ldr	r3, [r5, #64]
	ldr	r2, [r5, #32]
	cmp	r3, r2
	bcc	.L4234
	ldr	r1, .L4267+12
	ldr	ip, [r1]
	cmp	ip, #0
	beq	.L4234
	str	r3, [fp, #-44]
	mov	r1, #108
	str	r2, [fp, #-40]
	mov	r3, #8
	sub	r2, fp, #44
	ldr	r0, [r5, #120]
	blx	ip
.L4234:
	ldr	r1, .L4267+20
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r5
	bl	MVC_ClearCurrPic
	mvn	r0, #0
	b	.L4218
.L4264:
	mov	r2, r0
	ldr	r1, .L4267+24
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4218
.L4265:
	ldr	r1, .L4267+28
	mov	r0, #1
	bl	dprint_vfmw
	b	.L4258
.L4266:
	ldr	r1, .L4267+32
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4218
.L4268:
	.align	2
.L4267:
	.word	.LC392
	.word	.LC455
	.word	.LC393
	.word	g_event_report
	.word	.LC453
	.word	.LC454
	.word	.LC457
	.word	.LC458
	.word	.LC456
	.fnend
	.size	MVC_DecSlice, .-MVC_DecSlice
	.align	2
	.global	MVC_DecOneNal
	.type	MVC_DecOneNal, %function
MVC_DecOneNal:
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
	ldr	lr, [r0, #232]
	mov	r4, r0
	mov	r5, r1
	ldr	r3, [lr, #68]
	cmp	r3, #0
	ldrne	ip, [r0, #104]
	movne	r2, lr
	movne	r3, #0
	beq	.L4274
.L4273:
	ldr	r0, [r2, #12]
	add	r3, r3, #1
	add	r2, r2, #28
	add	ip, ip, r0
	str	ip, [r4, #104]
	ldr	r0, [lr, #68]
	cmp	r0, r3
	bhi	.L4273
.L4274:
	add	r7, r4, #548
	mov	r8, #0
	mov	r1, #32
	strb	r8, [lr]
	mov	r0, r7
	bl	BsGet
	ldr	r3, [r4, #232]
	mvn	r1, #0
	and	ip, r0, #31
	strb	ip, [r3, #2]
	ldr	r3, [r4, #232]
	mov	r6, r0
	ubfx	r0, r0, #5, #2
	ubfx	r2, r6, #7, #1
	strb	r0, [r3, #4]
	ldr	r3, [r4, #232]
	str	r2, [r3, #76]
	ldr	r2, [r4, #232]
	ldr	r3, [r2, #64]
	add	r3, r3, #32
	str	r3, [r2, #64]
	ldr	r3, [r4, #232]
	strb	r8, [r4, #10]
	strb	r1, [r3, #5]
	ldr	r3, [r4, #232]
	ldrb	r3, [r3, #2]
	cmp	r3, #14
	cmpne	r3, #20
	beq	.L4455
.L4272:
	ldr	r2, [r4, #68]
	mov	r0, #22
	ldr	r1, .L4466
	bl	dprint_vfmw
	ldr	r3, [r4, #68]
	movw	r2, #371
	cmp	r3, r2
	beq	.L4456
.L4277:
	ldr	r2, [r4, #232]
	add	r3, r3, #1
	str	r3, [r4, #68]
	ldrb	r2, [r2, #2]
	sub	r3, r2, #1
	cmp	r3, #29
	ldrls	pc, [pc, r3, asl #2]
	b	.L4278
.L4280:
	.word	.L4279
	.word	.L4278
	.word	.L4278
	.word	.L4278
	.word	.L4279
	.word	.L4281
	.word	.L4282
	.word	.L4283
	.word	.L4284
	.word	.L4285
	.word	.L4286
	.word	.L4287
	.word	.L4288
	.word	.L4289
	.word	.L4290
	.word	.L4278
	.word	.L4278
	.word	.L4278
	.word	.L4291
	.word	.L4278
	.word	.L4278
	.word	.L4278
	.word	.L4278
	.word	.L4278
	.word	.L4278
	.word	.L4278
	.word	.L4278
	.word	.L4278
	.word	.L4278
	.word	.L4292
.L4455:
	mov	r1, #24
	mov	r0, r7
	bl	BsGet
	ldr	r3, [r4, #232]
	ubfx	r2, r0, #23, #1
	strb	r2, [r3, #5]
	ldr	r3, [r4, #232]
	mov	r6, r0
	ldrsb	r2, [r3, #5]
	cmp	r2, #0
	bne	.L4275
	add	r2, r4, #12288
	mov	r1, #1
	ubfx	r0, r0, #16, #6
	ubfx	ip, r6, #2, #1
	strb	r1, [r2, #704]
	ubfx	lr, r6, #6, #10
	ubfx	r1, r6, #3, #3
	strb	r0, [r2, #706]
	strb	r1, [r2, #707]
	ubfx	r0, r6, #1, #1
	strb	ip, [r2, #708]
	and	r1, r6, #1
	str	lr, [r2, #712]
	ubfx	ip, r6, #22, #1
	strb	r0, [r2, #709]
	strb	r1, [r2, #710]
	strb	ip, [r2, #705]
	ldrb	r2, [r3, #2]
	cmp	r2, #20
	beq	.L4457
.L4275:
	ldr	r2, [r3, #64]
	add	r2, r2, #24
	str	r2, [r3, #64]
	ldr	r3, [r4, #232]
	ldrb	r3, [r3, #2]
	b	.L4272
.L4279:
	ldr	r3, [r4, #80]
	mov	r0, #22
	ldr	r1, .L4466+4
	bl	dprint_vfmw
	ldr	r3, [r4, #232]
	add	r0, r4, #11075584
	add	r2, r4, #12288
	add	r0, r0, #40960
	mvn	lr, #0
	ldrb	ip, [r3, #2]
	mov	r1, #0
	strb	ip, [r0, #875]
	ldrb	r5, [r3, #4]
	strb	r5, [r0, #880]
	ldrb	r3, [r3, #5]
	str	lr, [r0, #2512]
	strb	r1, [r0, #883]
	strb	r3, [r0, #884]
	ldrb	lr, [r2, #704]
	cmp	lr, #1
	beq	.L4458
	cmp	r3, #255
	beq	.L4459
.L4294:
	ldr	r2, [r4, #88]
	mov	r0, #21
	ldr	r1, .L4466+8
	bl	dprint_vfmw
	mov	r0, r4
	bl	MVC_SliceCheck
	subs	r5, r0, #0
	mov	r0, r4
	bne	.L4460
	bl	MVC_DecSlice
	cmn	r0, #2
	beq	.L4305
	cmp	r0, #0
	beq	.L4436
	ldr	r3, .L4466+12
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L4435
	ldr	r0, [r4, #120]
	mov	r3, r5
	mov	r2, r5
	mov	r1, #113
	blx	ip
.L4435:
	mvn	r0, #0
	b	.L4305
.L4281:
	ldr	r1, .L4466+16
	mov	r2, #6
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r4
	bl	MVC_DecSEI
	ldr	r1, [r4, #232]
	cmp	r1, #0
	mov	r5, r0
	beq	.L4312
	ldr	r0, [r4, #120]
	bl	MVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #232]
.L4312:
	cmp	r5, #0
	bne	.L4461
.L4436:
	mov	r0, #0
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L4282:
	ldr	r1, .L4466+20
	mov	r2, #7
	ldr	r3, [r4, #72]
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r4
	bl	MVC_DecSPS
	ldr	r1, [r4, #232]
	cmp	r1, #0
	mov	r5, r0
	beq	.L4310
	ldr	r0, [r4, #120]
	bl	MVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #232]
.L4310:
	cmp	r5, #0
	bne	.L4462
	ldr	r3, [r4, #72]
	mov	r0, r5
	add	r3, r3, #1
	str	r3, [r4, #72]
	b	.L4305
.L4284:
	ldr	r1, .L4466+24
	mov	r2, #9
.L4443:
	mov	r0, #22
	bl	dprint_vfmw
.L4448:
	ldr	r1, [r4, #232]
	cmp	r1, #0
	beq	.L4436
	ldr	r0, [r4, #120]
	bl	MVC_ReleaseNAL
	mov	r3, #0
	mov	r0, r3
	str	r3, [r4, #232]
.L4305:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L4285:
	mov	r2, #10
	ldr	r1, .L4466+28
	b	.L4443
.L4283:
	ldr	r1, .L4466+32
	mov	r2, #8
	ldr	r3, [r4, #76]
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r4
	bl	MVC_DecPPS
	ldr	r1, [r4, #232]
	cmp	r1, #0
	mov	r5, r0
	beq	.L4308
	ldr	r0, [r4, #120]
	bl	MVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #232]
.L4308:
	cmp	r5, #0
	bne	.L4463
	ldr	r3, [r4, #76]
	mov	r0, r5
	add	r3, r3, #1
	str	r3, [r4, #76]
	b	.L4305
.L4286:
	mov	r2, #11
	ldr	r1, .L4466+36
	mov	r0, #22
	bl	dprint_vfmw
	mov	r1, #32
	mov	r0, r7
	bl	BsGet
	mov	r1, #32
	mov	r5, r0
	mov	r0, r7
	bl	BsGet
	movw	r2, #20036
	movw	r3, #20553
	movt	r2, 17221
	movt	r3, 18515
	cmp	r0, r2
	cmpeq	r5, r3
	bne	.L4448
	ldr	r5, .L4466+12
	mov	r3, #1
	strb	r3, [r4, #1]
	ldr	ip, [r5]
	cmp	ip, #0
	beq	.L4315
	mov	r3, #0
	mov	r1, #112
	mov	r2, r3
	ldr	r0, [r4, #120]
	blx	ip
.L4315:
	mov	r6, #0
	mov	r0, r4
	strb	r6, [r4]
	bl	MVC_DecVDM
	cmp	r0, r6
	beq	.L4448
	b	.L4451
.L4287:
	mov	r2, #12
	ldr	r1, .L4466+40
	b	.L4443
.L4288:
	mov	r2, #13
	ldr	r1, .L4466+44
	b	.L4443
.L4289:
	mov	r2, #14
	ldr	r1, .L4466+48
	b	.L4443
.L4290:
	ldr	r1, .L4466+52
	mov	r2, #15
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r4
	bl	MVC_DecSubSPS
	ldr	r1, [r4, #232]
	cmp	r1, #0
	mov	r5, r0
	beq	.L4316
	ldr	r0, [r4, #120]
	bl	MVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #232]
.L4316:
	cmp	r5, #0
	bne	.L4464
	ldr	r3, [r4, #20]
	mov	r0, r5
	add	r3, r3, #1
	str	r3, [r4, #20]
	b	.L4305
.L4291:
	mov	r2, #19
	ldr	r1, .L4466+56
	b	.L4443
.L4292:
	mov	r2, #30
	ldr	r1, .L4466+60
	mov	r0, #22
	bl	dprint_vfmw
	cmp	r5, #0
	bne	.L4318
	ldr	r1, [r4, #232]
	cmp	r1, #0
	beq	.L4318
	ldr	r0, [r4, #120]
	bl	MVC_ReleaseNAL
	str	r5, [r4, #232]
.L4318:
	mov	r1, #32
	mov	r0, r7
	bl	BsGet
	mov	r1, #32
	mov	r5, r0
	mov	r0, r7
	bl	BsGet
	ldr	r3, .L4466+64
	rev	r5, r5
	ldr	r2, [r3, #440]
	ldr	r3, [r3, #436]
	rev	r0, r0
	cmp	r0, r2
	cmpeq	r5, r3
	bne	.L4436
	ldr	r5, .L4466+12
	ldr	ip, [r5]
	cmp	ip, #0
	beq	.L4319
	mov	r3, #0
	mov	r1, #112
	mov	r2, r3
	ldr	r0, [r4, #120]
	blx	ip
.L4319:
	mov	r6, #0
	mov	r0, r4
	strb	r6, [r4]
	bl	MVC_DecVDM
	cmp	r0, r6
	beq	.L4436
.L4451:
	ldr	ip, [r5]
	cmp	ip, r6
	beq	.L4435
	ldr	r0, [r4, #120]
	mov	r3, r6
	mov	r2, r6
	mov	r1, #113
	blx	ip
	mvn	r0, #0
	b	.L4305
.L4278:
	mov	r3, r6
	ldr	r1, .L4466+68
	mov	r0, #22
	bl	dprint_vfmw
	cmp	r6, #256
	beq	.L4320
	ldr	r1, .L4466+72
	mov	r0, #1
	bl	dprint_vfmw
.L4320:
	ldr	r1, [r4, #232]
	cmp	r1, #0
	beq	.L4321
	ldr	r0, [r4, #120]
	bl	MVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #232]
.L4321:
	ldr	r3, .L4466+12
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L4436
.L4440:
	mov	r3, #0
	ldr	r0, [r4, #120]
	mov	r2, r3
	mov	r1, #113
	blx	ip
	b	.L4436
.L4456:
	ldr	r1, .L4466+76
	mov	r0, #22
	bl	dprint_vfmw
	ldr	r3, [r4, #68]
	b	.L4277
.L4457:
	cmp	ip, #0
	movne	r2, #1
	moveq	r2, #5
	strb	r2, [r3, #2]
	ldr	r3, [r4, #232]
	b	.L4275
.L4460:
	bl	MVC_ClearCurrSlice
	ldr	r3, .L4466+12
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L4435
.L4304:
	mov	r3, #0
	ldr	r0, [r4, #120]
	mov	r2, r3
	mov	r1, #113
	blx	ip
	mvn	r0, #0
	b	.L4305
.L4463:
	ldr	r5, .L4466+12
	mov	r0, #1
	ldr	r1, .L4466+80
	bl	dprint_vfmw
	ldr	ip, [r5]
	cmp	ip, #0
	beq	.L4435
.L4453:
	sub	r2, fp, #36
	mvn	r6, #0
	mov	r3, #4
	mov	r1, #100
	str	r6, [r2, #-4]!
	ldr	r0, [r4, #120]
	blx	ip
	ldr	ip, [r5]
	cmp	ip, #0
	bne	.L4304
	b	.L4435
.L4464:
	ldr	r1, .L4466+84
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L4466+12
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L4435
	sub	r2, fp, #36
	ldr	r0, [r4, #120]
	mov	r3, #4
	mvn	r4, #0
	mov	r1, #100
	str	r4, [r2, #-4]!
	blx	ip
	mov	r0, r4
	b	.L4305
.L4462:
	ldr	r5, .L4466+12
	mov	r0, #1
	ldr	r1, .L4466+88
	bl	dprint_vfmw
	ldr	ip, [r5]
	cmp	ip, #0
	bne	.L4453
	b	.L4435
.L4461:
	ldr	r1, .L4466+92
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L4466+12
	ldr	ip, [r3]
	cmp	ip, #0
	bne	.L4440
	b	.L4436
.L4459:
	ldr	r3, [r4, #20]
	cmp	r3, #0
	beq	.L4294
	add	r3, r4, #10747904
	add	r3, r3, #20480
	ldr	r2, [r3, #2384]
	cmp	r2, #0
	beq	.L4297
	ldrb	r2, [r3, #2380]
	cmp	r2, #1
	beq	.L4298
.L4297:
	add	r3, r4, #12992
	mov	r2, #0
	add	r3, r3, #16
.L4301:
	ldr	r1, [r3]
	cmp	r1, #0
	beq	.L4299
	ldrb	r1, [r3, #-4]
	cmp	r1, #0
	bne	.L4465
.L4299:
	add	r2, r2, #1
	add	r3, r3, #335872
	cmp	r2, #32
	add	r3, r3, #308
	bne	.L4301
	mvn	r3, #0
.L4434:
	cmn	r3, #1
	str	r3, [r0, #2512]
	beq	.L4294
	sub	ip, ip, #5
	mov	r3, #1
	clz	ip, ip
	strb	r3, [r0, #883]
	strb	r3, [r0, #882]
	mov	ip, ip, lsr #5
	strb	ip, [r0, #881]
	b	.L4294
.L4458:
	strb	lr, [r0, #883]
	ldr	r3, [r2, #712]
	str	r3, [r0, #2512]
	ldrb	r3, [r2, #708]
	strb	r3, [r0, #881]
	ldrb	r3, [r2, #709]
	strb	r3, [r0, #882]
	strb	r1, [r2, #704]
	b	.L4294
.L4465:
	movw	r3, #8500
	movt	r3, 5
	mla	r3, r3, r2, r4
	add	r3, r3, #12992
	add	r3, r3, #16
	ldr	r3, [r3, #4]
	b	.L4434
.L4298:
	ldr	r3, [r3, #2388]
	b	.L4434
.L4467:
	.align	2
.L4466:
	.word	.LC459
	.word	.LC461
	.word	.LC462
	.word	g_event_report
	.word	.LC467
	.word	.LC465
	.word	.LC469
	.word	.LC470
	.word	.LC463
	.word	.LC472
	.word	.LC471
	.word	.LC473
	.word	.LC474
	.word	.LC475
	.word	.LC476
	.word	.LC477
	.word	.LANCHOR1
	.word	.LC478
	.word	.LC479
	.word	.LC460
	.word	.LC464
	.word	.LC334
	.word	.LC466
	.word	.LC468
	.fnend
	.size	MVC_DecOneNal, .-MVC_DecOneNal
	.align	2
	.global	MVC_DEC_DecodePacket
	.type	MVC_DEC_DecodePacket, %function
MVC_DEC_DecodePacket:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #28
	sub	sp, sp, #28
	push	{lr}
	bl	__gnu_mcount_nc
	cmp	r1, #0
	mov	ip, #0
	mov	r4, r0
	str	ip, [fp, #-40]
	str	ip, [fp, #-44]
	str	ip, [fp, #-48]
	beq	.L4522
	ldr	r2, [r0, #224]
	ldrb	lr, [r0, #5]
	ldr	r3, [r2, #8]
	cmp	lr, #1
	mov	r3, r3, asl #16
	and	r3, r3, #196608
	str	r3, [r0, #108]
	ldr	r3, [r2]
	str	r3, [r0, #112]
	ldr	r3, [r2, #4]
	strb	ip, [r0, #10]
	str	r3, [r0, #116]
	beq	.L4471
	ldr	r3, [r2, #824]
	cmp	r3, #1
	addne	r5, r0, #11141120
	addne	r5, r5, #16384
	beq	.L4523
.L4472:
	mov	r0, r4
	bl	MVC_ReceivePacket
	ldr	r3, [r4, #232]
	str	r3, [r5, #524]
.L4474:
	cmp	r0, #0
	mov	r3, #0
	strb	r3, [r4, #5]
	beq	.L4475
.L4494:
	mov	r0, #0
.L4517:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L4523:
	ldr	r3, [r2, #864]
	add	r5, r0, #11141120
	add	r5, r5, #16384
	cmp	r3, #1
	bne	.L4472
	ldr	r3, [r5, #520]
	cmp	r3, #1
	bne	.L4472
	ldr	r3, [r5, #524]
	str	r3, [r0, #232]
	str	ip, [r5, #520]
	strb	ip, [r0, #5]
	b	.L4473
.L4475:
	ldr	r3, [r4, #232]
.L4473:
	mov	r2, #0
	str	r2, [r3, #64]
	ldr	r3, [r4, #232]
	add	r6, r4, #548
	mov	r0, r6
	ldr	r2, [r3, #12]
	ldr	r1, [r3, #8]
	bl	BsInit
	mov	r1, #32
	mov	r0, r6
	bl	BsGet
	ldr	r3, [r4, #232]
	mvn	r2, #0
	mov	r5, r0
	and	r0, r0, #31
	strb	r0, [r3, #2]
	ubfx	r1, r5, #5, #2
	ldr	r3, [r4, #232]
	strb	r1, [r3, #4]
	ldr	r3, [r4, #232]
	strb	r2, [r3, #5]
	ldr	r3, [r4, #232]
	ldrb	r3, [r3, #2]
	cmp	r3, #20
	beq	.L4524
.L4520:
	and	r5, r5, #27
	mov	r3, #0
	cmp	r5, #1
	strb	r3, [r4, #10]
	beq	.L4480
.L4481:
	mov	r0, r4
	bl	MVC_FindTrailZeros
	cmp	r0, #0
	bne	.L4525
.L4493:
	ldr	r3, [r4, #232]
	mov	r5, #0
	mov	r0, r6
	str	r5, [r3, #64]
	ldr	r3, [r4, #232]
	ldr	r1, [r3, #8]
	ldr	r2, [r3, #12]
	bl	BsInit
	mov	r1, r5
	mov	r0, r4
	bl	MVC_DecOneNal
	cmn	r0, #2
	beq	.L4517
	cmp	r0, r5
	beq	.L4494
	ldr	r3, .L4528
	ldr	ip, [r3]
	cmp	ip, r5
	beq	.L4521
	ldr	r0, [r4, #120]
	mov	r3, r5
	mov	r2, r5
	mov	r1, #113
	blx	ip
.L4521:
	mvn	r0, #0
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L4471:
	ldr	r0, [r0, #232]
	clz	r0, r0
	mov	r0, r0, lsr #5
	rsb	r0, r0, #0
	b	.L4474
.L4524:
	mov	r1, #24
	mov	r0, r6
	bl	BsGet
	ldr	r3, [r4, #232]
	ubfx	r2, r0, #23, #1
	strb	r2, [r3, #5]
	ldr	r1, [r4, #232]
	ldrsb	r2, [r1, #5]
	cmp	r2, #0
	bne	.L4520
	ubfx	ip, r0, #22, #1
	add	r3, r4, #12288
	cmp	ip, #0
	mov	r5, #1
	strb	ip, [r3, #705]
	ubfx	lr, r0, #6, #10
	ubfx	ip, r0, #2, #1
	strb	r5, [r3, #704]
	strb	ip, [r3, #708]
	ubfx	r0, r0, #1, #1
	str	lr, [r3, #712]
	movne	ip, r5
	strb	r0, [r3, #709]
	moveq	ip, #5
	strb	ip, [r1, #2]
	strb	r2, [r4, #10]
.L4480:
	sub	r2, fp, #32
	sub	r1, fp, #36
	mov	r0, r4
	bl	MVC_InquireSliceProperty
	cmp	r0, #0
	bne	.L4482
	ldr	r3, [fp, #-36]
	ldr	r2, [r4, #128]
	sub	r3, r3, #1
	clz	r3, r3
	mov	r3, r3, lsr #5
	cmp	r3, #0
	add	r3, r2, r3
	str	r3, [r4, #128]
	bne	.L4526
.L4483:
	ldr	r3, [fp, #-32]
	cmp	r3, #1
	bne	.L4481
	mvn	r1, #0
	mov	r0, r4
	bl	MVC_FlushDPB
	cmp	r0, #0
	bne	.L4527
.L4490:
	ldr	r0, [r4, #120]
	bl	FSP_GetFspType
	cmp	r0, #0
	bne	.L4481
	sub	r3, fp, #40
	sub	r2, fp, #44
	sub	r1, fp, #48
	ldr	r0, [r4, #120]
	bl	VCTRL_GetChanImgNum
	b	.L4481
.L4482:
	ldr	r1, [r4, #232]
	cmp	r1, #0
	beq	.L4492
	ldr	r0, [r4, #120]
	bl	MVC_ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #232]
.L4492:
	ldr	r3, .L4528
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L4521
	mov	r3, #0
	ldr	r0, [r4, #120]
	mov	r2, r3
	mov	r1, #113
	blx	ip
	mvn	r0, #0
	b	.L4517
.L4525:
	ldr	r1, .L4528+4
	mov	r0, #22
	bl	dprint_vfmw
	b	.L4493
.L4526:
	add	r5, r4, #11075584
	add	r5, r5, #40960
	ldrb	r3, [r5, #873]
	cmp	r3, #1
	ldr	r3, [r4, #132]
	addeq	r3, r3, #1
	addne	r3, r3, #2
	str	r3, [r4, #132]
	ldr	r3, [r4, #64]
	cmp	r3, #0
	beq	.L4483
	ldr	r3, [r4, #232]
	mov	ip, #0
	mov	r0, r6
	mov	r2, #12
	ldr	r1, .L4528+8
	str	ip, [r3, #64]
	bl	BsInit
	mov	r1, #1
	mov	r0, r4
	bl	MVC_DecOneNal
	ldrb	r3, [r5, #873]
	mvn	r0, #1
	cmp	r3, #1
	ldr	r3, [r4, #132]
	subeq	r3, r3, #1
	subne	r3, r3, #2
	str	r3, [r4, #132]
	mov	r3, #1
	strb	r3, [r4, #5]
	b	.L4517
.L4527:
	mov	r3, #0
	movw	r2, #14179
	ldr	r1, .L4528+12
	mov	r0, #22
	bl	dprint_vfmw
	b	.L4490
.L4522:
	mov	r0, r1
	movw	r3, #14062
	ldr	r2, .L4528+16
	ldr	r1, .L4528+20
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4517
.L4529:
	.align	2
.L4528:
	.word	g_event_report
	.word	.LC480
	.word	.LANCHOR1+432
	.word	.LC439
	.word	.LC13
	.word	.LC14
	.fnend
	.size	MVC_DEC_DecodePacket, .-MVC_DEC_DecodePacket
	.align	2
	.global	MVC_DEC_VDMPostProc
	.type	MVC_DEC_VDMPostProc, %function
MVC_DEC_VDMPostProc:
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
	ldrb	r7, [r0]
	mov	r4, r0
	cmp	r7, #0
	bne	.L4531
	add	r6, r0, #11141120
	add	r6, r6, #12288
	str	r1, [r6, #2028]
	bl	MVC_ClearAllSlice
	mov	r0, r4
	bl	MVC_StorePicInDpb
	subs	r5, r0, #0
	bne	.L4542
	mov	r3, #1
	mov	r0, r5
	strb	r3, [r4, #4]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L4531:
	add	r3, r0, #11141120
	add	r3, r3, #12288
	str	r1, [r3, #2028]
	bl	MVC_ClearAllSlice
	mov	r0, r4
	bl	MVC_StorePicInDpb
	subs	r2, r0, #0
	bne	.L4543
.L4534:
	mvn	r1, #0
	mov	r0, r4
	bl	MVC_FlushDPB
	subs	r2, r0, #0
	bne	.L4544
.L4535:
	ldr	ip, [r4, #40]
	add	r3, r4, #11075584
	add	r3, r3, #40960
	mov	r1, #0
	movw	r2, #23352
	strb	r1, [r4, #4]
	mov	r0, r1
	movt	r2, 1
	str	ip, [r3, #2540]
	mov	r5, #2
	strb	r1, [r3, #2528]
	mov	r4, #7
	str	r1, [r3, #2560]
	mov	lr, #32
	str	r1, [r3, #2564]
	mov	ip, #3
	str	r2, [r3, #2544]
	mvn	r1, #0
	mov	r2, #262144
	strb	r5, [r3, #2529]
	strb	r4, [r3, #2531]
	strb	lr, [r3, #2530]
	str	ip, [r3, #2552]
	str	r1, [r3, #2556]
	str	r2, [r3, #2568]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L4542:
	ldr	r3, [r6, #1976]
	mov	r2, #1
	ldr	r0, [r4, #120]
	ldrsb	r1, [r3, #6]
	bl	FSP_ClearLogicFs
	mov	r2, r5
	ldr	r1, .L4545
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	bl	MVC_ClearCurrPic
	mov	r0, r4
	mvn	r1, #0
	bl	MVC_ClearDPB
	str	r7, [r6, #1976]
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L4544:
	ldr	r1, .L4545+4
	mov	r0, #1
	bl	dprint_vfmw
	b	.L4535
.L4543:
	ldr	r1, .L4545+8
	mov	r0, #1
	bl	dprint_vfmw
	b	.L4534
.L4546:
	.align	2
.L4545:
	.word	.LC481
	.word	.LC483
	.word	.LC482
	.fnend
	.size	MVC_DEC_VDMPostProc, .-MVC_DEC_VDMPostProc
	.align	2
	.global	MVC_DEC_GetImageBuffer
	.type	MVC_DEC_GetImageBuffer, %function
MVC_DEC_GetImageBuffer:
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
	ldr	r7, [r0, #48]
	mov	r5, r0
	cmp	r7, #0
	beq	.L4563
	movw	r4, #48152
	movw	r9, #47592
	movt	r4, 169
	add	r8, r0, #11075584
	add	r4, r0, r4
	movt	r9, 169
	add	r8, r8, #45056
	add	r9, r0, r9
	mov	ip, r4
	mov	r6, #0
.L4555:
	ldrb	r3, [ip, #2]
	cmp	r3, #0
	bne	.L4550
	cmp	ip, #0
	beq	.L4551
	ldr	lr, [r8, #2728]
	cmp	lr, #0
	beq	.L4551
	ldr	r2, [r8, #2536]
	rsb	r3, ip, r2
	cmp	r2, #0
	clz	r3, r3
	mov	r3, r3, lsr #5
	moveq	r3, #0
	cmp	r3, #0
	bne	.L4550
	mov	r1, r9
	b	.L4552
.L4553:
	ldr	r2, [r1, #4]!
	rsb	r0, ip, r2
	cmp	r2, #0
	clz	r0, r0
	mov	r0, r0, lsr #5
	moveq	r0, #0
	cmp	r0, #0
	bne	.L4550
.L4552:
	add	r3, r3, #1
	cmp	r3, lr
	bne	.L4553
.L4551:
	ldr	r0, [r5, #120]
	bl	FSP_IsNewFsAvalible
	cmp	r0, #1
	beq	.L4563
	ldr	r0, [r5, #120]
	bl	FSP_IsNewFsAvalible
	cmn	r0, #1
	bne	.L4583
	add	r1, r5, #584
	ldr	r0, [r5, #120]
	bl	FSP_ClearNotInVoQueue
	b	.L4583
.L4550:
	add	r6, r6, #1
	add	ip, ip, #776
	cmp	r6, r7
	bne	.L4555
	sub	r2, fp, #40
	sub	r1, fp, #44
	add	r0, r5, #584
	bl	GetQueueImgNum
	ldr	r1, .L4587
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r1, .L4587+4
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r3, [r5, #48]
	cmp	r3, #0
	beq	.L4585
	movw	r7, #47592
	add	r8, r5, #11075584
	movt	r7, 169
	add	r8, r8, #45056
	add	r7, r5, r7
	mov	r6, #0
.L4556:
	cmp	r4, #0
	ldrb	r3, [r4, #2]
	ldrb	r9, [r4, #5]
	beq	.L4567
	ldr	lr, [r8, #2728]
	cmp	lr, #0
	beq	.L4567
	ldr	r2, [r8, #2536]
	rsb	r1, r4, r2
	cmp	r2, #0
	clz	r1, r1
	mov	r1, r1, lsr #5
	moveq	r1, #0
	cmp	r1, #0
	bne	.L4569
	mov	r2, r7
	b	.L4560
.L4561:
	ldr	ip, [r2, #4]!
	rsb	r0, r4, ip
	cmp	ip, #0
	clz	r0, r0
	mov	r0, r0, lsr #5
	moveq	r0, #0
	cmp	r0, #0
	bne	.L4569
.L4560:
	add	r1, r1, #1
	cmp	r1, lr
	bne	.L4561
.L4567:
	mov	r2, #1
.L4559:
	str	r2, [sp, #4]
	mov	r0, #0
	mov	r2, r6
	str	r9, [sp]
	ldr	r1, .L4587+8
	add	r6, r6, #1
	bl	dprint_vfmw
	ldr	r3, [r5, #48]
	add	r4, r4, #776
	cmp	r3, r6
	bhi	.L4556
.L4562:
	ldr	r3, [fp, #-40]
	mov	r0, #0
	ldr	r2, [fp, #-44]
	ldr	r1, .L4587+12
	bl	dprint_vfmw
	ldr	r3, [r5, #48]
	ldr	r0, [r8, #2732]
	ldr	r2, [fp, #-44]
	sub	r3, r3, #2
	ldr	r1, [fp, #-40]
	rsb	r3, r0, r3
	add	r2, r2, r1
	cmp	r2, r3
	blt	.L4586
.L4583:
	mov	r0, #0
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L4563:
	mov	r0, #1
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L4569:
	mov	r2, #0
	b	.L4559
.L4586:
	ldr	r1, .L4587+16
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, r5
	mov	r1, #1
	bl	MVC_ClearAll
	mov	r0, #0
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L4585:
	add	r8, r5, #11075584
	add	r8, r8, #45056
	b	.L4562
.L4588:
	.align	2
.L4587:
	.word	.LC484
	.word	.LC485
	.word	.LC487
	.word	.LC486
	.word	.LC488
	.fnend
	.size	MVC_DEC_GetImageBuffer, .-MVC_DEC_GetImageBuffer
	.global	MvcTmpBuf
	.global	MVC_quant8_org
	.global	MVC_quant_org
	.global	MVC_quant8_inter_default
	.global	MVC_quant8_intra_default
	.global	MVC_quant_inter_default
	.global	MVC_quant_intra_default
	.global	MVC_g_ZZ_SCAN8
	.global	MVC_g_ZZ_SCAN
	.global	MVC_CalcZeroNum
	.global	MVC_g_AspecRatioIdc
	.global	MVC_g_NalTypeEOPIC
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	MVC_g_ZZ_SCAN, %object
	.size	MVC_g_ZZ_SCAN, 16
MVC_g_ZZ_SCAN:
	.byte	0
	.byte	1
	.byte	4
	.byte	8
	.byte	5
	.byte	2
	.byte	3
	.byte	6
	.byte	9
	.byte	12
	.byte	13
	.byte	10
	.byte	7
	.byte	11
	.byte	14
	.byte	15
	.type	MVC_g_ZZ_SCAN8, %object
	.size	MVC_g_ZZ_SCAN8, 64
MVC_g_ZZ_SCAN8:
	.byte	0
	.byte	1
	.byte	8
	.byte	16
	.byte	9
	.byte	2
	.byte	3
	.byte	10
	.byte	17
	.byte	24
	.byte	32
	.byte	25
	.byte	18
	.byte	11
	.byte	4
	.byte	5
	.byte	12
	.byte	19
	.byte	26
	.byte	33
	.byte	40
	.byte	48
	.byte	41
	.byte	34
	.byte	27
	.byte	20
	.byte	13
	.byte	6
	.byte	7
	.byte	14
	.byte	21
	.byte	28
	.byte	35
	.byte	42
	.byte	49
	.byte	56
	.byte	57
	.byte	50
	.byte	43
	.byte	36
	.byte	29
	.byte	22
	.byte	15
	.byte	23
	.byte	30
	.byte	37
	.byte	44
	.byte	51
	.byte	58
	.byte	59
	.byte	52
	.byte	45
	.byte	38
	.byte	31
	.byte	39
	.byte	46
	.byte	53
	.byte	60
	.byte	61
	.byte	54
	.byte	47
	.byte	55
	.byte	62
	.byte	63
	.type	__FUNCTION__.15833, %object
	.size	__FUNCTION__.15833, 18
__FUNCTION__.15833:
	.ascii	"MVC_WriteSliceMsg\000"
	.space	2
	.type	MVC_SarTable.16126, %object
	.size	MVC_SarTable.16126, 136
MVC_SarTable.16126:
	.word	1
	.word	1
	.word	1
	.word	1
	.word	12
	.word	11
	.word	10
	.word	11
	.word	16
	.word	11
	.word	40
	.word	33
	.word	24
	.word	11
	.word	20
	.word	11
	.word	32
	.word	11
	.word	80
	.word	33
	.word	18
	.word	11
	.word	15
	.word	11
	.word	64
	.word	33
	.word	160
	.word	99
	.word	4
	.word	3
	.word	3
	.word	2
	.word	2
	.word	1
	.type	__func__.16360, %object
	.size	__func__.16360, 11
__func__.16360:
	.ascii	"MVC_DecSEI\000"
	.space	1
	.type	__func__.15013, %object
	.size	__func__.15013, 17
__func__.15013:
	.ascii	"MVC_DirectOutput\000"
	.space	3
	.type	__func__.15593, %object
	.size	__func__.15593, 12
__func__.15593:
	.ascii	"MVC_InitDPB\000"
	.type	__FUNCTION__.14733, %object
	.size	__FUNCTION__.14733, 13
__FUNCTION__.14733:
	.ascii	"MVC_ClearDPB\000"
	.space	3
	.type	__func__.16471, %object
	.size	__func__.16471, 17
__func__.16471:
	.ascii	"MVC_FlushDecoder\000"
	.space	3
	.type	__FUNCTION__.14741, %object
	.size	__FUNCTION__.14741, 13
__FUNCTION__.14741:
	.ascii	"MVC_ClearAll\000"
	.space	3
	.type	__FUNCTION__.16598, %object
	.size	__FUNCTION__.16598, 13
__FUNCTION__.16598:
	.ascii	"MVC_DEC_Init\000"
	.space	3
	.type	__func__.15163, %object
	.size	__func__.15163, 18
__func__.15163:
	.ascii	"MVC_StorePicInDpb\000"
	.data
	.align	2
.LANCHOR1 = . + 0
	.type	MVC_quant_intra_default, %object
	.size	MVC_quant_intra_default, 16
MVC_quant_intra_default:
	.word	471076102
	.word	538711053
	.word	622861332
	.word	707076124
	.type	MVC_quant_inter_default, %object
	.size	MVC_quant_inter_default, 16
MVC_quant_inter_default:
	.word	403967498
	.word	454562830
	.word	505092116
	.word	572398360
	.type	MVC_quant8_intra_default, %object
	.size	MVC_quant8_intra_default, 64
MVC_quant8_intra_default:
	.word	269289990
	.word	454629138
	.word	303041290
	.word	488315159
	.word	387059725
	.word	522001177
	.word	420942352
	.word	555687195
	.word	454629138
	.word	606150429
	.word	488315159
	.word	639901983
	.word	522001177
	.word	673588257
	.word	555687195
	.word	707274276
	.type	MVC_quant8_inter_default, %object
	.size	MVC_quant8_inter_default, 256
MVC_quant8_inter_default:
	.word	286199049
	.word	404100371
	.word	319884557
	.word	421008917
	.word	353571087
	.word	454629398
	.word	370479889
	.word	471537944
	.word	404100371
	.word	505158425
	.word	421008917
	.word	538844187
	.word	454629398
	.word	555752988
	.word	471537944
	.word	589373470
	.space	192
	.type	MVC_quant_org, %object
	.size	MVC_quant_org, 16
MVC_quant_org:
	.word	269488144
	.word	269488144
	.word	269488144
	.word	269488144
	.type	MVC_quant8_org, %object
	.size	MVC_quant8_org, 64
MVC_quant8_org:
	.word	269488144
	.word	269488144
	.word	269488144
	.word	269488144
	.word	269488144
	.word	269488144
	.word	269488144
	.word	269488144
	.word	269488144
	.word	269488144
	.word	269488144
	.word	269488144
	.word	269488144
	.word	269488144
	.word	269488144
	.word	269488144
	.type	MVC_g_NalTypeEOPIC, %object
	.size	MVC_g_NalTypeEOPIC, 12
MVC_g_NalTypeEOPIC:
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
	.type	MVC_CalcZeroNum, %object
	.size	MVC_CalcZeroNum, 256
MVC_CalcZeroNum:
	.byte	8
	.byte	7
	.byte	6
	.byte	6
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.type	MVC_g_AspecRatioIdc, %object
	.size	MVC_g_AspecRatioIdc, 112
MVC_g_AspecRatioIdc:
	.word	1
	.word	1
	.word	1
	.word	1
	.word	12
	.word	11
	.word	10
	.word	11
	.word	16
	.word	11
	.word	40
	.word	33
	.word	24
	.word	11
	.word	20
	.word	11
	.word	32
	.word	11
	.word	80
	.word	33
	.word	18
	.word	11
	.word	15
	.word	11
	.word	64
	.word	33
	.word	160
	.word	99
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"\012\012END of the bit buffer, copy the first packe"
	.ascii	"t!\012\012\000"
	.space	2
.LC1:
	.ascii	"0:phy:0x%x, 1:phy:0x%x; len0:%d len1:%d\012\000"
	.space	3
.LC2:
	.ascii	"0:phy:0x%x, len0:%d\012\000"
	.space	3
.LC3:
	.ascii	"%-50s%50d\012\000"
	.space	1
.LC4:
	.ascii	"MVC_FRAME %d, state=%d, is already output\012\000"
	.space	1
.LC5:
	.ascii	"plfs(fs=%p, eFoState=%d) is null, logic_fs_id = %d\012"
	.ascii	"\000"
.LC6:
	.ascii	"not used MVC_FRAME: (%d,%d)\012\000"
	.space	3
.LC7:
	.ascii	"MVC_FRAME skip: is_used=%d,skip=%d\012\000"
.LC8:
	.ascii	"topfield skip\012\000"
	.space	1
.LC9:
	.ascii	"bottom field skip\012\000"
	.space	1
.LC10:
	.ascii	"err(%d) > out_thr(%d)\012\000"
	.space	1
.LC11:
	.ascii	"exg_pts: %lld <-> %lld\012\000"
.LC12:
	.ascii	"stream MVC_FRAME packing type is %d! what can we do"
	.ascii	"?\012\000"
	.space	2
.LC13:
	.ascii	"/home/share/HiSTBAndroid5.x/release/HiSTBAndroid5.x"
	.ascii	"/master/HiSTBAndroidV6_release/HiSTBAndroidV600R002"
	.ascii	"C00SPC030/device/hisilicon/bigfish/sdk/source/kerne"
	.ascii	"l/linux-3.18.y/drivers/msp/vfmw/vfmw_v5.0/firmware/"
	.ascii	"common/syntax/mvc.c\000"
.LC14:
	.ascii	"NULL pointer: %s, L%d\012\000"
	.space	1
.LC15:
	.ascii	"framestore %d allocate apc %d\012\000"
	.space	1
.LC16:
	.ascii	"find APC, but logic_fs_id %d abnormal(ref=%d,plfs=%"
	.ascii	"p, pdfs=%p)\012\000"
.LC17:
	.ascii	"\012\000"
	.space	2
.LC18:
	.ascii	"pMvcCtx->DPB.fs[%d]: frame_num=%d poc=%d is_referen"
	.ascii	"ce=%d\012\000"
	.space	2
.LC19:
	.ascii	"pMvcCtx->DPB.fs_ref[%d]: frame_num=%d poc=%d is_ref"
	.ascii	"erence=%d\012\000"
	.space	2
.LC20:
	.ascii	"pMvcCtx->DPB.fs_ref[%d]: MVC_FRAME.poc=%d \012\000"
.LC21:
	.ascii	"\012 VFMW ** release streambuff=%p   bitstream_leng"
	.ascii	"th=%d\012\000"
	.space	1
.LC22:
	.ascii	"clear curr slice.\012\000"
	.space	1
.LC23:
	.ascii	"partition fs memory fail!\012\000"
	.space	1
.LC24:
	.ascii	"ERROR: FSP_ConfigInstance fail!\012\000"
	.space	3
.LC25:
	.ascii	"for P slice size of list equal 0(1st).\012\000"
.LC26:
	.ascii	"for P slice size of list equal 0(2nd).\012\000"
.LC27:
	.ascii	"for B slice size of two list all equal 0.\012\000"
	.space	1
.LC28:
	.ascii	"list[%d][%d]: frame_num=%d, poc=%d\012\000"
.LC29:
	.ascii	"init list error.\012\000"
	.space	2
.LC30:
	.ascii	"In one access unit,all non-base view should have th"
	.ascii	"e same subsps!\012\000"
	.space	1
.LC31:
	.ascii	"sps but mvc flag %d is wrong\012\000"
	.space	2
.LC32:
	.ascii	"save pic yuv :  structure = %d;  idc = %d\012\000"
	.space	1
.LC33:
	.ascii	"structure = %d pMvcCtx->CurrPic.pic_width_in_mb = %"
	.ascii	"d pMvcCtx->CurrPic.pic_height_in_mb = %d\012\000"
	.space	3
.LC34:
	.ascii	"nal_ref_idc=%d, structure=%d, image_id=%d, pmv_idc="
	.ascii	"%d\012\000"
	.space	1
.LC35:
	.ascii	"logic MVC_FRAME id(=%d): get LogicFs error!\012\000"
	.space	3
.LC36:
	.ascii	"phy fs is null: pstDecodeFs = %p, pstDispOutFs = %p"
	.ascii	"\012\000"
	.space	3
.LC37:
	.ascii	"fuction return value is null,%s %d unknow error!!\012"
	.ascii	"\000"
	.space	1
.LC38:
	.ascii	"SH: first_mb_in_slice\000"
	.space	2
.LC39:
	.ascii	"MVC_SliceCheck first_mb_in_slice >= MAX_MB_NUM_IN_P"
	.ascii	"IC error.\012\000"
	.space	2
.LC40:
	.ascii	"SH: slice_type\000"
	.space	1
.LC41:
	.ascii	"slice type = %d\012\000"
	.space	3
.LC42:
	.ascii	"slice type = %d, err\012\000"
	.space	2
.LC43:
	.ascii	"slice  pps id = %d\012\000"
.LC44:
	.ascii	"pps with this pic_parameter_set_id = %d havn't deco"
	.ascii	"de\012\000"
	.space	1
.LC45:
	.ascii	"sps with this pic_parameter_set_id havn't decode\012"
	.ascii	"\000"
	.space	2
.LC46:
	.ascii	"subsps with this seq_parameter_set_id = %d havn't d"
	.ascii	"ecoded\012\000"
	.space	1
.LC47:
	.ascii	"tmp slice  pps id = %d\012\000"
.LC48:
	.ascii	"MVC_PPSSPSCheckTmpId: pps with this pic_parameter_s"
	.ascii	"et_id = %d havn't decode\012\000"
	.space	3
.LC49:
	.ascii	"MVC_PPSSPSCheckTmpId: seq_parameter_set_id out of r"
	.ascii	"ange.\012\000"
	.space	2
.LC50:
	.ascii	"MVC_PPSSPSCheckTmpId: sps with this pic_parameter_s"
	.ascii	"et_id = %d havn't decode\012\000"
	.space	3
.LC51:
	.ascii	"new pic flag = %d\012\000"
	.space	1
.LC52:
	.ascii	"SH: ref_pic_list_reordering_flag_l0\000"
.LC53:
	.ascii	"SH: reordering_of_pic_nums_idc_l0\000"
	.space	2
.LC54:
	.ascii	"reorder idc l0 = %d, g_SeErrFlag=%d\012\000"
	.space	3
.LC55:
	.ascii	"SH: abs_diff_pic_num_minus1_l0\000"
	.space	1
.LC56:
	.ascii	"abs_diff_pic_num_minus1_l0 = %d, g_SeErrFlag=%d\012"
	.ascii	"\000"
	.space	3
.LC57:
	.ascii	"SH: long_term_pic_idx_l0\000"
	.space	3
.LC58:
	.ascii	"SH: abs_diff_view_idx_minus1_l0\000"
.LC59:
	.ascii	"num of idc l0 exceed\012\000"
	.space	2
.LC60:
	.ascii	"SH: ref_pic_list_reordering_flag_l1\000"
.LC61:
	.ascii	"SH: reordering_of_pic_nums_idc_l1\000"
	.space	2
.LC62:
	.ascii	"reorder idc l1 = %d, g_SeErrFlag=%d\012\000"
	.space	3
.LC63:
	.ascii	"SH: abs_diff_pic_num_minus1_l1\000"
	.space	1
.LC64:
	.ascii	"abs_diff_pic_num_minus1_l1 = %d, g_SeErrFlag=%d\012"
	.ascii	"\000"
	.space	3
.LC65:
	.ascii	"SH: long_term_pic_idx_l1\000"
	.space	3
.LC66:
	.ascii	"SH: abs_diff_view_idx_minus1_l1\000"
.LC67:
	.ascii	"num of idc l1 exceed\012\000"
	.space	2
.LC68:
	.ascii	"SH: luma_log2_weight_denom\000"
	.space	1
.LC69:
	.ascii	"SH: chroma_log2_weight_denom\000"
	.space	3
.LC70:
	.ascii	"WP log2 exceed  and err flag = %d\012\000"
	.space	1
.LC71:
	.ascii	"SH: luma_weight_flag_l0\000"
.LC72:
	.ascii	"SH: luma_weight_l0\000"
	.space	1
.LC73:
	.ascii	"SH: luma_offset_l0\000"
	.space	1
.LC74:
	.ascii	"SH: chroma_weight_flag_l0\000"
	.space	2
.LC75:
	.ascii	"SH: chroma_weight_l0\000"
	.space	3
.LC76:
	.ascii	"SH: chroma_offset_l0\000"
	.space	3
.LC77:
	.ascii	"SH: luma_weight_flag_l1\000"
.LC78:
	.ascii	"SH: luma_weight_l1\000"
	.space	1
.LC79:
	.ascii	"SH: luma_offset_l1\000"
	.space	1
.LC80:
	.ascii	"SH: chroma_weight_flag_l1\000"
	.space	2
.LC81:
	.ascii	"SH: chroma_weight_l1\000"
	.space	3
.LC82:
	.ascii	"SH: chroma_offset_l1\000"
	.space	3
.LC83:
	.ascii	"overflow MVC_MAX_MMCO_LEN\012\000"
	.space	1
.LC84:
	.ascii	"SH: memory_management_control_operation\000"
.LC85:
	.ascii	"SH: difference_of_pic_nums_minus1\000"
	.space	2
.LC86:
	.ascii	"SH: long_term_pic_num\000"
	.space	2
.LC87:
	.ascii	"SH: long_term_frame_idx\000"
.LC88:
	.ascii	"SH: max_long_term_frame_idx_plus1\000"
	.space	2
.LC89:
	.ascii	"mmco exceed 6\012\000"
	.space	1
.LC90:
	.ascii	"SH: no_output_of_prior_pics_flag\000"
	.space	3
.LC91:
	.ascii	"SH: long_term_reference_flag\000"
	.space	3
.LC92:
	.ascii	"IDR and no_output_of_prior_pics_flag = %d\012\000"
	.space	1
.LC93:
	.ascii	"SH: adaptive_ref_pic_marking_mode_flag\000"
	.space	1
.LC94:
	.ascii	"adaptive_ref_pic_marking_mode_flag = %d\012\000"
	.space	3
.LC95:
	.ascii	"MMCO para would save dec err\012\000"
	.space	2
.LC96:
	.ascii	"mulitislice diff no_out_of_prior_pics_flag, used fi"
	.ascii	"rst.\012\000"
	.space	3
.LC97:
	.ascii	"mulitislice diff long_term_reference_flag, used fir"
	.ascii	"st.\012\000"
.LC98:
	.ascii	"mulitislice diff adaptive_ref_pic_marking_mode_flag"
	.ascii	", used first.\012\000"
	.space	2
.LC99:
	.ascii	"TotalPicNum=%d, SliceNumInPic=%d, TotalNal=%d\012\000"
	.space	1
.LC100:
	.ascii	"SH: pic_parameter_set_id\000"
	.space	3
.LC101:
	.ascii	"pps id:%d in sliceheader err\012\000"
	.space	2
.LC102:
	.ascii	"PPS or SPS of this slice not valid\012\000"
.LC103:
	.ascii	"MVC_PPSSPSCheck failed, PPS or SPS of this slice no"
	.ascii	"t valid\012\000"
.LC104:
	.ascii	"SH: frame_num\000"
	.space	2
.LC105:
	.ascii	"IDR NAL but frame_num!=0.\012\000"
	.space	1
.LC106:
	.ascii	"SH: field_pic_flag\000"
	.space	1
.LC107:
	.ascii	"SH: bottom_field_flag\000"
	.space	2
.LC108:
	.ascii	"field first_mb_in_slice bigger than pic size\012\000"
	.space	2
.LC109:
	.ascii	"MVC_FRAME first_mb_in_slice bigger than pic size\012"
	.ascii	"\000"
	.space	2
.LC110:
	.ascii	"SH: idr_pic_id\000"
	.space	1
.LC111:
	.ascii	"idr_pic_id bigger than 65535\012\000"
	.space	2
.LC112:
	.ascii	"SH: pic_order_cnt_lsb\000"
	.space	2
.LC113:
	.ascii	"SH: delta_pic_order_cnt_bottom\000"
	.space	1
.LC114:
	.ascii	"SH: delta_pic_order_cnt[0]\000"
	.space	1
.LC115:
	.ascii	"SH: delta_pic_order_cnt[1]\000"
	.space	1
.LC116:
	.ascii	"SH: redundant_pic_cnt\000"
	.space	2
.LC117:
	.ascii	"redundant pic not support.\012\000"
.LC118:
	.ascii	"first_mb_in_slice in currslice small than prevslice"
	.ascii	" in same pic\012\000"
	.space	3
.LC119:
	.ascii	"SH: direct_spatial_mv_pred_flag\000"
.LC120:
	.ascii	"SH: num_ref_idx_override_flag\000"
	.space	2
.LC121:
	.ascii	"SH: num_ref_idx_l0_active_minus1\000"
	.space	3
.LC122:
	.ascii	"SH: num_ref_idx_l1_active_minus1\000"
	.space	3
.LC123:
	.ascii	"MVC_FRAME num_ref_idx_lx_active_minus1 exceed\012\000"
	.space	1
.LC124:
	.ascii	"field num_ref_idx_lx_active_minus1 exceed\012\000"
	.space	1
.LC125:
	.ascii	"reordering para dec err\012\000"
	.space	3
.LC126:
	.ascii	"apply_weights_flag=%d\012\000"
	.space	1
.LC127:
	.ascii	"wpt dec err\012\000"
	.space	3
.LC128:
	.ascii	"mark para dec err\012\000"
	.space	1
.LC129:
	.ascii	"SH: cabac_init_idc\000"
	.space	1
.LC130:
	.ascii	"cabac_init_idc bigger than 3\012\000"
	.space	2
.LC131:
	.ascii	"SH: slice_qp_delta\000"
	.space	1
.LC132:
	.ascii	"SH: disable_deblocking_filter_idc\000"
	.space	2
.LC133:
	.ascii	"disable_deblocking_filter_idc dec err\012\000"
	.space	1
.LC134:
	.ascii	"SH: slice_alpha_c0_offset_div2\000"
	.space	1
.LC135:
	.ascii	"slice_alpha_c0_offset_div2 dec err\012\000"
.LC136:
	.ascii	"SH: slice_beta_offset_div2\000"
	.space	1
.LC137:
	.ascii	"slice_beta_offset_div2 dec err\012\000"
.LC138:
	.ascii	"pMvcCtx->pCurrNal->nal_bitoffset = %d; code_len_byt"
	.ascii	"e = %d; bitstream_length = %d; pMvcCtx->pCurrNal->n"
	.ascii	"al_trail_zero_bit_num = %d\012\000"
	.space	2
.LC139:
	.ascii	"stream[%d]: bitsoffset = %d; valid_bitlen = %d; byt"
	.ascii	"espos = %x\012\000"
	.space	1
.LC140:
	.ascii	"nal_segment = %d is not expected value\012\000"
.LC141:
	.ascii	"stream[%d]: bitsoffset = %d; valid_bitlen = %d\012\000"
.LC142:
	.ascii	"   : delta_sl   \000"
	.space	3
.LC143:
	.ascii	"PPS: entropy_coding_mode_flag\000"
	.space	2
.LC144:
	.ascii	"PPS: pic_order_present_flag\000"
.LC145:
	.ascii	"PPS: num_slice_groups_minus1\000"
	.space	3
.LC146:
	.ascii	"MVC_BASELINE stream with FMO, not support.\012\000"
.LC147:
	.ascii	"PPS: num_ref_idx_l0_active_minus1\000"
	.space	2
.LC148:
	.ascii	"num_ref_idx_l0_active_minus1 out of range.\012\000"
.LC149:
	.ascii	"PPS: num_ref_idx_l1_active_minus1\000"
	.space	2
.LC150:
	.ascii	"num_ref_idx_l1_active_minus1 out of range.\012\000"
.LC151:
	.ascii	"PPS: weighted prediction flag\000"
	.space	2
.LC152:
	.ascii	"PPS: weighted_bipred_idc\000"
	.space	3
.LC153:
	.ascii	"weighted_bipred_idc out of range\012\000"
	.space	2
.LC154:
	.ascii	"PPS: pic_init_qp_minus26\000"
	.space	3
.LC155:
	.ascii	"PPS: pic_init_qs_minus26\000"
	.space	3
.LC156:
	.ascii	"PPS: chroma_qp_index_offset\000"
.LC157:
	.ascii	"PPS: deblocking_filter_control_present_flag\000"
.LC158:
	.ascii	"PPS: constrained_intra_pred_flag\000"
	.space	3
.LC159:
	.ascii	"PPS: redundant_pic_cnt_present_flag\000"
.LC160:
	.ascii	"redundant pic not support when find redundant slice"
	.ascii	" later, exit\012\000"
	.space	3
.LC161:
	.ascii	"PPS: transform_8x8_mode_flag\000"
	.space	3
.LC162:
	.ascii	"PPS: pic_scaling_matrix_present_flag\000"
	.space	3
.LC163:
	.ascii	"PPS: second_chroma_qp_index_offset\000"
	.space	1
.LC164:
	.ascii	"SPS: seq_scaling_list_present_flag\000"
	.space	1
.LC165:
	.ascii	"PPS: pic_scaling_list_present_flag\000"
	.space	1
.LC166:
	.ascii	"second_chroma_qp_index_offset out of range.\012\000"
	.space	3
.LC167:
	.ascii	"PPS: pic_parameter_set_id\000"
	.space	2
.LC168:
	.ascii	"pic_parameter_set_id(%d) out of range.\012\000"
.LC169:
	.ascii	"PPS: seq_parameter_set_id\000"
	.space	2
.LC170:
	.ascii	"seq_parameter_set_id out of range.\012\000"
.LC171:
	.ascii	"PPS decode error line: %d.\012\000"
.LC172:
	.ascii	"VUI: aspect_ratio_info_present_flag\000"
.LC173:
	.ascii	"VUI: aspect_ratio_idc\000"
	.space	2
.LC174:
	.ascii	"VUI: sar_width\000"
	.space	1
.LC175:
	.ascii	"VUI: sar_height\000"
.LC176:
	.ascii	"VUI: overscan_info_present_flag\000"
.LC177:
	.ascii	"VUI: overscan_appropriate_flag\000"
	.space	1
.LC178:
	.ascii	"VUI: video_signal_type_present_flag\000"
.LC179:
	.ascii	"VUI: video_format\000"
	.space	2
.LC180:
	.ascii	"VUI: video_full_range_flag\000"
	.space	1
.LC181:
	.ascii	"VUI: color_description_present_flag\000"
.LC182:
	.ascii	"VUI: colour_primaries\000"
	.space	2
.LC183:
	.ascii	"VUI: transfer_characteristics\000"
	.space	2
.LC184:
	.ascii	"VUI: matrix_coefficients\000"
	.space	3
.LC185:
	.ascii	"VUI: chroma_loc_info_present_flag\000"
	.space	2
.LC186:
	.ascii	"VUI: chroma_sample_loc_type_top_field\000"
	.space	2
.LC187:
	.ascii	"VUI: chroma_sample_loc_type_bottom_field\000"
	.space	3
.LC188:
	.ascii	"VUI: timing_info_present_flag\000"
	.space	2
.LC189:
	.ascii	"VUI: num_units_in_tick\000"
	.space	1
.LC190:
	.ascii	"VUI: time_scale\000"
.LC191:
	.ascii	"VUI: fixed_frame_rate_flag\000"
	.space	1
.LC192:
	.ascii	"VUI: nal_hrd_parameters_present_flag\000"
	.space	3
.LC193:
	.ascii	"VUI: cpb_cnt_minus1\000"
.LC194:
	.ascii	"VUI: bit_rate_scale\000"
.LC195:
	.ascii	"VUI: cpb_size_scale\000"
.LC196:
	.ascii	"hrd->cpb_cnt_minus1 out of range\012\000"
	.space	2
.LC197:
	.ascii	"VUI: bit_rate_value_minus1\000"
	.space	1
.LC198:
	.ascii	"VUI: cpb_size_value_minus1\000"
	.space	1
.LC199:
	.ascii	"VUI: cbr_flag\000"
	.space	2
.LC200:
	.ascii	"VUI: initial_cpb_removal_delay_length_minus1\000"
	.space	3
.LC201:
	.ascii	"VUI: cpb_removal_delay_length_minus1\000"
	.space	3
.LC202:
	.ascii	"VUI: dpb_output_delay_length_minus1\000"
.LC203:
	.ascii	"VUI: time_offset_length\000"
.LC204:
	.ascii	"VUI: vcl_hrd_parameters_present_flag\000"
	.space	3
.LC205:
	.ascii	"VUI: low_delay_hrd_flag\000"
.LC206:
	.ascii	"VUI: pic_struct_present_flag\000"
	.space	3
.LC207:
	.ascii	"VUI: bitstream_restriction_flag\000"
.LC208:
	.ascii	"VUI: motion_vectors_over_pic_boundaries_flag\000"
	.space	3
.LC209:
	.ascii	"VUI: max_bytes_per_pic_denom\000"
	.space	3
.LC210:
	.ascii	"VUI: max_bits_per_mb_denom\000"
	.space	1
.LC211:
	.ascii	"VUI: log2_max_mv_length_horizontal\000"
	.space	1
.LC212:
	.ascii	"VUI: log2_max_mv_length_vertical\000"
	.space	3
.LC213:
	.ascii	"VUI: num_reorder_frames\000"
.LC214:
	.ascii	"VUI: max_dec_frame_buffering\000"
	.space	3
.LC215:
	.ascii	"dar=%d\012\000"
.LC216:
	.ascii	"SPS: chroma_format_idc\000"
	.space	1
.LC217:
	.ascii	"pSPS->chroma_format_idc out of range.\012\000"
	.space	1
.LC218:
	.ascii	"SPS: bit_depth_luma_minus8\000"
	.space	1
.LC219:
	.ascii	"bit_depth_luma_minus8 not equal 0.\012\000"
.LC220:
	.ascii	"SPS: bit_depth_chroma_minus8\000"
	.space	3
.LC221:
	.ascii	"bit_depth_chroma_minus8 not equal 0.\012\000"
	.space	2
.LC222:
	.ascii	"SPS: qpprime_y_zero_trans_bypass_flag\000"
	.space	2
.LC223:
	.ascii	"qpprime_y_zero_trans_bypass_flag not equal 0.\012\000"
	.space	1
.LC224:
	.ascii	"SPS: seq_scaling_matrix_present_flag\000"
	.space	3
.LC225:
	.ascii	"SPS: log2_max_frame_num_minus4\000"
	.space	1
.LC226:
	.ascii	"pSPS->log2_max_frame_num_minus4 out of range.\012\000"
	.space	1
.LC227:
	.ascii	"SPS: pic_order_cnt_type\000"
.LC228:
	.ascii	"pSPS->pic_order_cnt_type out of range.\012\000"
.LC229:
	.ascii	"SPS: log2_max_pic_order_cnt_lsb_minus4\000"
	.space	1
.LC230:
	.ascii	"SPS: num_ref_frames\000"
.LC231:
	.ascii	"pSPS->log2_max_pic_order_cnt_lsb_minus4 out of rang"
	.ascii	"e.\012\000"
	.space	1
.LC232:
	.ascii	"SPS: delta_pic_order_always_zero_flag\000"
	.space	2
.LC233:
	.ascii	"SPS: offset_for_non_ref_pic\000"
.LC234:
	.ascii	"SPS: offset_for_top_to_bottom_field\000"
.LC235:
	.ascii	"SPS: num_ref_frames_in_pic_order_cnt_cycle\000"
	.space	1
.LC236:
	.ascii	"pSPS->num_ref_frames_in_pic_order_cnt_cycle out of "
	.ascii	"range.\012\000"
	.space	1
.LC237:
	.ascii	"SPS: offset_for_ref_frame[i]\000"
	.space	3
.LC238:
	.ascii	"SPS: gaps_in_frame_num_value_allowed_flag\000"
	.space	2
.LC239:
	.ascii	"SPS: pic_width_in_mbs_minus1\000"
	.space	3
.LC240:
	.ascii	"pSPS->pic_width_in_mbs_minus1 out of range(=%d).\012"
	.ascii	"\000"
	.space	2
.LC241:
	.ascii	"SPS: pic_height_in_map_units_minus1\000"
.LC242:
	.ascii	"SPS: frame_mbs_only_flag\000"
	.space	3
.LC243:
	.ascii	"pSPS->pic_height_in_map_units_minus1 out of range.\012"
	.ascii	"\000"
.LC244:
	.ascii	"pic size too large.\012\000"
	.space	3
.LC245:
	.ascii	"level_idc %d not support.\012\000"
	.space	1
.LC246:
	.ascii	"dpb size according level : %d\012\000"
	.space	1
.LC247:
	.ascii	"pSPS->num_ref_frames(%d) > DPB size(%d), try to sel"
	.ascii	"ect the reasonable one.\012\000"
.LC248:
	.ascii	"SPS: direct_8x8_inference_flag\000"
	.space	1
.LC249:
	.ascii	"SPS: frame_cropping_flag\000"
	.space	3
.LC250:
	.ascii	"SPS: frame_cropping_rect_left_offset\000"
	.space	3
.LC251:
	.ascii	"SPS: frame_cropping_rect_right_offset\000"
	.space	2
.LC252:
	.ascii	"SPS: frame_cropping_rect_top_offset\000"
.LC253:
	.ascii	"SPS: frame_cropping_rect_bottom_offset\000"
	.space	1
.LC254:
	.ascii	"SPS: vui_parameters_present_flag\000"
	.space	3
.LC255:
	.ascii	"max_dec_frame_buffering(%d) > MaxDpbSize(%d)\012\000"
	.space	2
.LC256:
	.ascii	"SPS: mb_adaptive_frame_field_flag\000"
	.space	2
.LC257:
	.ascii	"SPS: profile_idc\000"
	.space	3
.LC258:
	.ascii	"SPS: constrained_set0_flag\000"
	.space	1
.LC259:
	.ascii	"SPS: constrained_set1_flag\000"
	.space	1
.LC260:
	.ascii	"SPS: constrained_set2_flag\000"
	.space	1
.LC261:
	.ascii	"SPS: constrained_set3_flag\000"
	.space	1
.LC262:
	.ascii	"SPS: constrained_set4_flag\000"
	.space	1
.LC263:
	.ascii	"SPS: constrained_set5_flag\000"
	.space	1
.LC264:
	.ascii	"SPS: reserved_zero_2bits\000"
	.space	3
.LC265:
	.ascii	"SPS: level_idc\000"
	.space	1
.LC266:
	.ascii	"SPS: seq_parameter_set_id\000"
	.space	2
.LC267:
	.ascii	"MVC_BASELINE stream, try to decode, exit when FMO o"
	.ascii	"ccurred.\012\000"
	.space	3
.LC268:
	.ascii	"MVC_EXTENDED stream, try to decode, exit when datap"
	.ascii	"artition occurred.\012\000"
	.space	1
.LC269:
	.ascii	"others High profile stream, try to decode, exit whe"
	.ascii	"n high profile not support occurred.\012\000"
	.space	3
.LC270:
	.ascii	"profile_idc = %5d error, try to decode as main prof"
	.ascii	"ile.\012\000"
	.space	3
.LC271:
	.ascii	"level_idc = %5d error, try to decode as level_idc %"
	.ascii	"d.\012\000"
	.space	1
.LC272:
	.ascii	"Line %d: SPS[%d] decode error.\012\000"
.LC273:
	.ascii	"SUBSPS: num_views_minus1\000"
	.space	3
.LC274:
	.ascii	"pSubsps->num_views_minus1(%d) out of range.\012\000"
	.space	3
.LC275:
	.ascii	"SUBSPS: view_id[]\000"
	.space	2
.LC276:
	.ascii	"SUBSPS: num_anchor_refs_l0[]\000"
	.space	3
.LC277:
	.ascii	"SUBSPS: num_anchor_refs_l1[]\000"
	.space	3
.LC278:
	.ascii	"pSubsps->num_anchor_refs_l0(%d) out of range.\012\000"
	.space	1
.LC279:
	.ascii	"SUBSPS: anchor_ref_l0[][]\000"
	.space	2
.LC280:
	.ascii	"pSubsps->num_anchor_refs_l1(%d) out of range.\012\000"
	.space	1
.LC281:
	.ascii	"SUBSPS: anchor_ref_l1[][]\000"
	.space	2
.LC282:
	.ascii	"SUBSPS: num_level_values_signalled_minus1\000"
	.space	2
.LC283:
	.ascii	"SUBSPS: num_non_anchor_refs_l0[]\000"
	.space	3
.LC284:
	.ascii	"SUBSPS: num_non_anchor_refs_l1[]\000"
	.space	3
.LC285:
	.ascii	"pSubsps->num_non_anchor_refs_l0(%d) out of range.\012"
	.ascii	"\000"
	.space	1
.LC286:
	.ascii	"SUBSPS: non_anchor_ref_l0[][]\000"
	.space	2
.LC287:
	.ascii	"pSubsps->num_non_anchor_refs_l1(%d) out of range.\012"
	.ascii	"\000"
	.space	1
.LC288:
	.ascii	"SUBSPS: non_anchor_ref_l1[][]\000"
	.space	2
.LC289:
	.ascii	"num_level(%d) out of range.\012\000"
	.space	3
.LC290:
	.ascii	"SUBSPS: level_idc[]\000"
.LC291:
	.ascii	"SUBSPS: num_applicable_ops_minus1\000"
	.space	2
.LC292:
	.ascii	"num_ops(%d) out of range.\012\000"
	.space	1
.LC293:
	.ascii	"SUBSPS: applicable_op_temporal_id[][]\000"
	.space	2
.LC294:
	.ascii	"SUBSPS: applicable_op_num_target_views_minus1[][]\000"
	.space	2
.LC295:
	.ascii	"SUBSPS: applicable_op_num_views_minus1\000"
	.space	1
.LC296:
	.ascii	"applicable_op_num_target_views(%d) out of range.\012"
	.ascii	"\000"
	.space	2
.LC297:
	.ascii	"SUBSPS: applicable_op_target_view_id[][][]\000"
	.space	1
.LC298:
	.ascii	"pSubsps->applicable_op_num_views_minus1(%d) out of "
	.ascii	"range.\012\000"
	.space	1
.LC299:
	.ascii	"MVC VUI: vui_mvc_num_ops_minus1\000"
.LC300:
	.ascii	"vui_mvc_num_ops_minus1 %d out of range\012\000"
.LC301:
	.ascii	"MVC VUI: vui_mvc_temporal_id[]\000"
	.space	1
.LC302:
	.ascii	"SUBSPS VUI: vui_mvc_num_target_output_views_minus1["
	.ascii	"]\000"
	.space	3
.LC303:
	.ascii	"MVC VUI: vui_mvc_timing_info_present_flag\000"
	.space	2
.LC304:
	.ascii	"MVC VUI: vui_mvc_view_id[][]\000"
	.space	3
.LC305:
	.ascii	"MVC VUI: vui_mvc_num_units_in_tick\000"
	.space	1
.LC306:
	.ascii	"MVC VUI: vui_mvc_time_scale[]\000"
	.space	2
.LC307:
	.ascii	"MVC VUI: vui_mvc_fixed_frame_rate_flag\000"
	.space	1
.LC308:
	.ascii	"MVC VUI: vui_mvc_nal_hrd_parameters_present_flag[]\000"
	.space	1
.LC309:
	.ascii	"MVC VUI: cpb_cnt_minus1\000"
.LC310:
	.ascii	"MVC VUI: bit_rate_scale\000"
.LC311:
	.ascii	"MVC VUI: cpb_size_scale\000"
.LC312:
	.ascii	"MVC VUI: bit_rate_value_minus1\000"
	.space	1
.LC313:
	.ascii	"MVC VUI: cpb_size_value_minus1\000"
	.space	1
.LC314:
	.ascii	"MVC VUI: cbr_flag\000"
	.space	2
.LC315:
	.ascii	"MVC VUI: initial_cpb_removal_delay_length_minus1\000"
	.space	3
.LC316:
	.ascii	"MVC VUI: cpb_removal_delay_length_minus1\000"
	.space	3
.LC317:
	.ascii	"MVC VUI: dpb_output_delay_length_minus1\000"
.LC318:
	.ascii	"MVC VUI: time_offset_length\000"
.LC319:
	.ascii	"MVC VUI: vui_mvc_vcl_hrd_parameters_present_flag[]\000"
	.space	1
.LC320:
	.ascii	"MVC VUI: vui_mvc_low_delay_hrd_flag[]\000"
	.space	2
.LC321:
	.ascii	"MVC VUI: vui_mvc_pic_struct_present_flag[]\000"
	.space	1
.LC322:
	.ascii	"SUBSPS: profile_idc\000"
.LC323:
	.ascii	"SUBSPS: constrained_set0_flag\000"
	.space	2
.LC324:
	.ascii	"SUBSPS: constrained_set1_flag\000"
	.space	2
.LC325:
	.ascii	"SUBSPS: constrained_set2_flag\000"
	.space	2
.LC326:
	.ascii	"SUBSPS: constrained_set3_flag\000"
	.space	2
.LC327:
	.ascii	"SUBSPS: constrained_set4_flag\000"
	.space	2
.LC328:
	.ascii	"SUBSPS: constrained_set5_flag\000"
	.space	2
.LC329:
	.ascii	"SUBSPS: reserved_zero_2bits\000"
.LC330:
	.ascii	"SUBSPS: level_idc\000"
	.space	2
.LC331:
	.ascii	"SUBSPS: seq_parameter_set_id\000"
	.space	3
.LC332:
	.ascii	"profile_idc = %5d error\012\000"
	.space	3
.LC333:
	.ascii	"level_idc = %5d error, try to decode as level_idc 4"
	.ascii	"1.\012\000"
	.space	1
.LC334:
	.ascii	"SUBSPS decode error.\012\000"
	.space	2
.LC335:
	.ascii	"SUBSPS: bit_equal_to_one\000"
	.space	3
.LC336:
	.ascii	"SUBSPS Mvc Ext decode error.\012\000"
	.space	2
.LC337:
	.ascii	"SUBSPS: mvc_vui_parameters_present_flag\000"
.LC338:
	.ascii	"SUBSPS Mvc Vui Ext decode error.\012\000"
	.space	2
.LC339:
	.ascii	"SEI: frame_packing_arrangement_id\000"
	.space	2
.LC340:
	.ascii	"SEI: frame_packing_arrangement_cancel_flag\000"
	.space	1
.LC341:
	.ascii	"SEI: frame_packing_arrangement_type\000"
.LC342:
	.ascii	"SEI: quincunx_sampling_flag\000"
.LC343:
	.ascii	"SEI: content_interpretation_type\000"
	.space	3
.LC344:
	.ascii	"SEI: spatial_flipping_flag\000"
	.space	1
.LC345:
	.ascii	"SEI: frame0_flipped_flag\000"
	.space	3
.LC346:
	.ascii	"SEI: field_views_flag\000"
	.space	2
.LC347:
	.ascii	"SEI: current_frame_is_frame0_flag\000"
	.space	2
.LC348:
	.ascii	"SEI: frame0_self_contained_flag\000"
.LC349:
	.ascii	"SEI: frame1_self_contained_flag\000"
.LC350:
	.ascii	"SEI: frame0_grid_position_x\000"
.LC351:
	.ascii	"SEI: frame0_grid_position_y\000"
.LC352:
	.ascii	"SEI: frame1_grid_position_x\000"
.LC353:
	.ascii	"SEI: frame1_grid_position_y\000"
.LC354:
	.ascii	"SEI: frame_packing_arrangement_reserved_byte\000"
	.space	3
.LC355:
	.ascii	"SEI: frame_packing_arrangement_repetition_period\000"
	.space	3
.LC356:
	.ascii	"SEI: frame_packing_arrangement_extension_flag\000"
	.space	2
.LC357:
	.ascii	"DecPicTimingSEI but SPS is invalid.\012\000"
	.space	3
.LC358:
	.ascii	"SEI: cpb_removal_delay\000"
	.space	1
.LC359:
	.ascii	"SEI: dpb_output_delay\000"
	.space	2
.LC360:
	.ascii	"pic_struct\000"
	.space	1
.LC361:
	.ascii	"SEI nal dec payload type err\012\000"
	.space	2
.LC362:
	.ascii	"SEI nal dec payloadSize err\012\000"
	.space	3
.LC363:
	.ascii	"MVC_SEI_BUFFERING_PERIOD,offset = %d,payload_size ="
	.ascii	" %d \012\000"
	.space	3
.LC364:
	.ascii	"MVC_PassBytes err [%s][%d]\012\000"
.LC365:
	.ascii	"MVC_SEI_PIC_TIMING,offset = %d,payload_size = %d \012"
	.ascii	"\000"
	.space	1
.LC366:
	.ascii	"MVC_SEI_PAN_SCAN_RECT,offset = %d,payload_size = %d"
	.ascii	" \012\000"
	.space	2
.LC367:
	.ascii	"MVC_SEI_FILLER_PAYLOAD,offset = %d,payload_size = %"
	.ascii	"d \012\000"
	.space	1
.LC368:
	.ascii	"MVC_SEI_USER_DATA_REGISTERED_ITU_T_T35, offset = %d"
	.ascii	", payload_size = %d \012\000"
	.space	3
.LC369:
	.ascii	"MVC_SEI_USER_DATA_UNREGISTERED, offset = %d, payloa"
	.ascii	"d_size = %d \012\000"
	.space	3
.LC370:
	.ascii	"SEI: itu_t_t35_country_code\000"
.LC371:
	.ascii	"SEI: itu_t_t35_country_code_extension_byte\000"
	.space	1
.LC372:
	.ascii	"SEI: itu_t_t35_provider_code\000"
	.space	3
.LC373:
	.ascii	"cann't dec usrdata\012\000"
.LC374:
	.ascii	"MVC_SEI_RECOVERY_POINT,offset = %d,payload_size = %"
	.ascii	"d \012\000"
	.space	1
.LC375:
	.ascii	"MVC_SEI_DEC_REF_PIC_MARKING_REPETITION,offset = %d,"
	.ascii	"payload_size = %d \012\000"
	.space	1
.LC376:
	.ascii	"MVC_SEI_SPARE_PIC,offset = %d,payload_size = %d \012"
	.ascii	"\000"
	.space	2
.LC377:
	.ascii	"MVC_SEI_SCENE_INFO,offset = %d,payload_size = %d \012"
	.ascii	"\000"
	.space	1
.LC378:
	.ascii	"MVC_SEI_SUB_SEQ_INFO,offset = %d,payload_size = %d "
	.ascii	"\012\000"
	.space	3
.LC379:
	.ascii	"MVC_SEI_SUB_SEQ_LAYER_CHARACTERISTICS,offset = %d,p"
	.ascii	"ayload_size = %d \012\000"
	.space	2
.LC380:
	.ascii	"MVC_SEI_SUB_SEQ_CHARACTERISTICS,offset = %d,payload"
	.ascii	"_size = %d \012\000"
.LC381:
	.ascii	"MVC_SEI_FULL_FRAME_FREEZE,offset = %d,payload_size "
	.ascii	"= %d \012\000"
	.space	2
.LC382:
	.ascii	"MVC_SEI_FULL_FRAME_FREEZE_RELEASE,offset = %d,paylo"
	.ascii	"ad_size = %d \012\000"
	.space	2
.LC383:
	.ascii	"MVC_SEI_FULL_FRAME_SNAPSHOT,offset = %d,payload_siz"
	.ascii	"e = %d \012\000"
.LC384:
	.ascii	"MVC_SEI_PROGRESSIVE_REFINEMENT_SEGMENT_START,offset"
	.ascii	" = %d,payload_size = %d \012\000"
	.space	3
.LC385:
	.ascii	"MVC_SEI_PROGRESSIVE_REFINEMENT_SEGMENT_END,offset ="
	.ascii	" %d,payload_size = %d \012\000"
	.space	1
.LC386:
	.ascii	"MVC_SEI_MOTION_CONSTRAINED_SLICE_GROUP_SET,offset ="
	.ascii	" %d,payload_size = %d \012\000"
	.space	1
.LC387:
	.ascii	"MVC_SEI_FILM_GRAIN_CHARACTERISTICS,offset = %d,payl"
	.ascii	"oad_size = %d \012\000"
	.space	1
.LC388:
	.ascii	"MVC_SEI_DEBLOCKING_FILTER_DISPLAY_PREFERENCE,offset"
	.ascii	" = %d,payload_size = %d \012\000"
	.space	3
.LC389:
	.ascii	"MVC_SEI_STEREO_VIDEO_INFO,offset = %d,payload_size "
	.ascii	"= %d \012\000"
	.space	2
.LC390:
	.ascii	"too much usrdat, cann't dec SEI\012\000"
	.space	3
.LC391:
	.ascii	"\012 mvc the stream is error,len:%d\012\000"
	.space	2
.LC392:
	.ascii	"\012Slice nal or IDR nal = %d\012\000"
.LC393:
	.ascii	"sliceheader dec err\012\000"
	.space	3
.LC394:
	.ascii	"MVC_InquireSliceProperty mvc flag %d is wrong\012\000"
	.space	1
.LC395:
	.ascii	"MvcDec destroy\012\000"
.LC396:
	.ascii	"MVC recycle image\012\000"
	.space	1
.LC397:
	.ascii	"pH264Ctx is %#x, pFrameStore is %#x\012\000"
	.space	3
.LC398:
	.ascii	"line: %d, pstLogicFsImage is NULL\012\000"
	.space	1
.LC399:
	.ascii	"InsertVO err:%d, MVC_ClearAll\012\000"
	.space	1
.LC400:
	.ascii	"mvc.c line %d: MVC_FRAME para err(ret=%d), recycle "
	.ascii	"image self\012\000"
	.space	1
.LC401:
	.ascii	"[%s][%d] MVC_OutputFrmToVO return %d !\012\000"
.LC402:
	.ascii	"[%s][%d] MVC_OutputFrmToVO return %d\012\000"
	.space	2
.LC403:
	.ascii	"%s %d MVC_OK != MVC_FlushDPB!!\012\000"
.LC404:
	.ascii	"%s %d MVC_OK != MVC_InitDPB!!\012\000"
	.space	1
.LC405:
	.ascii	"----------------- MVC_IMODE -> %d -----------------"
	.ascii	"-\012\000"
	.space	2
.LC406:
	.ascii	"Discard this B(poc=%d) befor P, is_ref_idc=%d.\012\000"
.LC407:
	.ascii	"***** VDM start, TotalPicNum=%d, pMvcCtx->CurrPic.s"
	.ascii	"tructure=%d.\012\000"
	.space	3
.LC408:
	.ascii	"MVC_DecVDM fail [%s][%d]\012\000"
	.space	2
.LC409:
	.ascii	"\012 receive streambuff=%p; phy_addr=0x%x; bitstrea"
	.ascii	"m_length=%d\012\000"
	.space	3
.LC410:
	.ascii	"nal_releaMVC_SE_ERR\012\000"
	.space	3
.LC411:
	.ascii	"cann't find slot for current nal\012\000"
	.space	2
.LC412:
	.ascii	"receive a zero packet\012\000"
	.space	1
.LC413:
	.ascii	"clear all dec para\012\000"
.LC414:
	.ascii	"line %d, get APC error, ret %d\012\000"
.LC415:
	.ascii	"InserFrmInDPB: cur pic struct = %d!\012\000"
	.space	3
.LC416:
	.ascii	"line: %d, pImage is NULL!\012\000"
	.space	1
.LC417:
	.ascii	"FS_ALLOC_ERR, MVC_ClearAll\012\000"
.LC418:
	.ascii	"Can not new logic fs! MVC_ClearAll\012\000"
.LC419:
	.ascii	"%s %d NULL== pMvcCtx->SPS || NULL == pMvcCtx->PPS |"
	.ascii	"| NULL == pMvcCtx->DecSlicePara!!\012\000"
	.space	2
.LC420:
	.ascii	"-1 == VCTRL_GetChanIDByCtx() Err! \012\000"
.LC421:
	.ascii	"CurrPic.state is 'MVC_EMPTY'\012\000"
	.space	2
.LC422:
	.ascii	"MVC_StorePicInDpb return(%d) from L%d\012\000"
	.space	1
.LC423:
	.ascii	"Is IDR, but init DPB failed!\012\000"
	.space	2
.LC424:
	.ascii	"Is IDR, but FlushDPB failed!\012\000"
	.space	2
.LC425:
	.ascii	"MVC_DirectOutput mode\012\000"
	.space	1
.LC426:
	.ascii	"line %d, REPORT_IFRAME_ERR\012\000"
.LC427:
	.ascii	"line %d, return %d\012\000"
.LC428:
	.ascii	"err(%d) > ref_thr(%d)\012\000"
	.space	1
.LC429:
	.ascii	"MVC_Marking return %d\012\000"
	.space	1
.LC430:
	.ascii	"line %d: pMvcCtx->DPB.size = %d, ref %d, ltref %d\012"
	.ascii	"\000"
	.space	1
.LC431:
	.ascii	"line %d, MVC_GetMinPOC failed\012\000"
	.space	1
.LC432:
	.ascii	"%s: pos(%d) = pre_pos, force return.\012\000"
	.space	2
.LC433:
	.ascii	"GAP found while DPB is MVC_EMPTY!\012\000"
	.space	1
.LC434:
	.ascii	"MVC_FRAME num gap try to fill it \012\000"
	.space	1
.LC435:
	.ascii	"CurrFrameNum = %d  UnusedShortTermFrameNum = %d\012"
	.ascii	"\000"
	.space	3
.LC436:
	.ascii	"cann't allocate MVC_FRAME store when gap find\012\000"
	.space	1
.LC437:
	.ascii	"allocate MVC_FRAME store when gap find\012\000"
.LC438:
	.ascii	"line %d: store gap pic err, ret=%d\012\000"
.LC439:
	.ascii	"line %d: flush dpb return %d\012\000"
	.space	2
.LC440:
	.ascii	"line %d: init dpb return %d\012\000"
	.space	3
.LC441:
	.ascii	"resolution error, the CAP_LEVEL_USER_DEFINE_WITH_OP"
	.ascii	"TION channel with s32ReRangeEn == 0 can't support s"
	.ascii	"uch bitstream.\012\000"
	.space	2
.LC442:
	.ascii	"s32MaxRefFrameNum < pMvcCtx->DPB.size, the CAP_LEVE"
	.ascii	"L_USER_DEFINE_WITH_OPTION channel can't support suc"
	.ascii	"h bitstream.\012\000"
.LC443:
	.ascii	"mem arrange err, MVC_ClearAll\012\000"
	.space	1
.LC444:
	.ascii	"line %d: MVC_FRAME gap(=%d) > dpb size(=%d)\012\000"
	.space	3
.LC445:
	.ascii	"MVC_FRAME num gap don't allowed but gap find\012\000"
	.space	2
.LC446:
	.ascii	"line %d: frame num(%d/%d) find gap in NON-I slice b"
	.ascii	"ut here gap is not allowed\012\000"
	.space	1
.LC447:
	.ascii	"line %d: dec gap failed\012\000"
	.space	3
.LC448:
	.ascii	"line %d: alloc framestore failed\012\000"
	.space	2
.LC449:
	.ascii	"dec_pts: %lld\012\000"
	.space	1
.LC450:
	.ascii	"dec_usertag: %lld\012\000"
	.space	1
.LC451:
	.ascii	"line %d: CurrPic.frame_store is NULL\012\000"
	.space	2
.LC452:
	.ascii	"get back frm\012\000"
	.space	2
.LC453:
	.ascii	"Start Reason: SliceParaNum, MaxBytesReceived = %d, "
	.ascii	"%d(thr=%d)\012\000"
	.space	1
.LC454:
	.ascii	"Too many slice or bitstream, err!\012\000"
	.space	1
.LC455:
	.ascii	"Start Reason: new_pic_flag\012\000"
.LC456:
	.ascii	"init pic err, find next recover point or next valid"
	.ascii	" sps, pps, or exit\012\000"
	.space	1
.LC457:
	.ascii	"MVC_DecList error, ret=%d\012\000"
	.space	1
.LC458:
	.ascii	"dec list err.\012\000"
	.space	1
.LC459:
	.ascii	"pMvcCtx->TotalNal = %d, type:%d\012\000"
	.space	3
.LC460:
	.ascii	"stop i want\012\000"
	.space	3
.LC461:
	.ascii	"***** NAL: IDR/Slice, nal_unit_type=%d, TotalSlice="
	.ascii	"%d\012\000"
	.space	1
.LC462:
	.ascii	"*******TotalPicNum=%d********\012\000"
	.space	1
.LC463:
	.ascii	"***** NAL: PPS, nal_unit_type=%d, TotalPPS=%d\012\000"
	.space	1
.LC464:
	.ascii	"PPS decode error.\012\000"
	.space	1
.LC465:
	.ascii	"***** NAL: SPS, nal_unit_type=%d, TotalSPS=%d\012\000"
	.space	1
.LC466:
	.ascii	"SPS decode error.\012\000"
	.space	1
.LC467:
	.ascii	"***** NAL: SEI, nal_unit_type=%d\012\000"
	.space	2
.LC468:
	.ascii	"SEI decode error.\012\000"
	.space	1
.LC469:
	.ascii	"***** NAL: AUD, nal_unit_type=%d\012\000"
	.space	2
.LC470:
	.ascii	"***** NAL: EOSEQ, nal_unit_type=%d\012\000"
.LC471:
	.ascii	"***** NAL: FILL, nal_unit_type=%d\012\000"
	.space	1
.LC472:
	.ascii	"***** NAL: EOSTREAM, nal_unit_type=%d\012\000"
	.space	1
.LC473:
	.ascii	"***** NAL: SPSEXT, nal_unit_type=%d\012\000"
	.space	3
.LC474:
	.ascii	"***** NAL: PREFIX, nal_unit_type=%d\012\000"
	.space	3
.LC475:
	.ascii	"***** NAL: SUBSPS, nal_unit_type=%d\012\000"
	.space	3
.LC476:
	.ascii	"***** NAL: AUX, nal_unit_type=%d\012\000"
	.space	2
.LC477:
	.ascii	"***** NAL: EOPIC, nal_unit_type=%d\012\000"
.LC478:
	.ascii	"***** NAL: UNSUPPORT, nal_unit_type=%d,nalu header:"
	.ascii	"%x\012\000"
	.space	1
.LC479:
	.ascii	"nal_header != 0x00000100 not support.\012\000"
	.space	1
.LC480:
	.ascii	"MVC_FindTrailZeros ERR\012\000"
.LC481:
	.ascii	"store pic err, ret = %d\012\000"
	.space	3
.LC482:
	.ascii	"MVC_IMODE nal store pic err, ret = %d\012\000"
	.space	1
.LC483:
	.ascii	"MVC_IMODE nal flush dpb err, ret = %d\012\000"
	.space	1
.LC484:
	.ascii	"cann't find FrameStore\012\000"
.LC485:
	.ascii	"========== MVC FrameStore state(is_used, is_in_dpb,"
	.ascii	" MVC_IsOutDPB) ========\012\000"
.LC486:
	.ascii	"ReadImgNum = %d, NewImgNum = %d\012\000"
	.space	3
.LC487:
	.ascii	"%02d: %d %d %d\012\000"
.LC488:
	.ascii	"FrameStore leak, MVC_ClearAll\012\000"
	.bss
	.align	2
.LANCHOR2 = . + 0
.LANCHOR3 = . + 8184
	.type	pps_tmp.16046, %object
	.size	pps_tmp.16046, 2240
pps_tmp.16046:
	.space	2240
	.type	sps_tmp.16182, %object
	.size	sps_tmp.16182, 3992
sps_tmp.16182:
	.space	3992
	.type	MvcTmpBuf, %object
	.size	MvcTmpBuf, 68
MvcTmpBuf:
	.space	68
	.type	cnt.14999, %object
	.size	cnt.14999, 4
cnt.14999:
	.space	4
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
