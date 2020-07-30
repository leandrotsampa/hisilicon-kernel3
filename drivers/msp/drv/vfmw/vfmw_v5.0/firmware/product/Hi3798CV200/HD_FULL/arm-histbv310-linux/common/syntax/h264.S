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
	.file	"h264.c"

	.text
	.align	2
	.global	IsSTRefFlg
	.type	IsSTRefFlg, %function
IsSTRefFlg:
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
	.size	IsSTRefFlg, .-IsSTRefFlg
	.align	2
	.global	IsLTRefFlg
	.type	IsLTRefFlg, %function
IsLTRefFlg:
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
	.size	IsLTRefFlg, .-IsLTRefFlg
	.align	2
	.global	compare_pic_by_pic_num_desc
	.type	compare_pic_by_pic_num_desc, %function
compare_pic_by_pic_num_desc:
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
	blt	.L5
	mvngt	r0, #0
	movle	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L5:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	compare_pic_by_pic_num_desc, .-compare_pic_by_pic_num_desc
	.align	2
	.global	compare_pic_by_lt_pic_num_asc
	.type	compare_pic_by_lt_pic_num_asc, %function
compare_pic_by_lt_pic_num_asc:
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
	ldr	r2, [r2, #4]
	ldr	r3, [r3, #4]
	cmp	r2, r3
	blt	.L9
	movgt	r0, #1
	movle	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L9:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	compare_pic_by_lt_pic_num_asc, .-compare_pic_by_lt_pic_num_asc
	.align	2
	.global	compare_fs_by_frame_num_desc
	.type	compare_fs_by_frame_num_desc, %function
compare_fs_by_frame_num_desc:
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
	ldr	r2, [r2, #608]
	ldr	r3, [r3, #608]
	cmp	r2, r3
	blt	.L12
	mvngt	r0, #0
	movle	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L12:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	compare_fs_by_frame_num_desc, .-compare_fs_by_frame_num_desc
	.align	2
	.global	compare_fs_by_lt_pic_idx_asc
	.type	compare_fs_by_lt_pic_idx_asc, %function
compare_fs_by_lt_pic_idx_asc:
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
	ldr	r2, [r2, #612]
	ldr	r3, [r3, #612]
	cmp	r2, r3
	bcc	.L15
	movhi	r0, #1
	movls	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L15:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	compare_fs_by_lt_pic_idx_asc, .-compare_fs_by_lt_pic_idx_asc
	.align	2
	.global	compare_pic_by_poc_asc
	.type	compare_pic_by_poc_asc, %function
compare_pic_by_poc_asc:
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
	blt	.L18
	movgt	r0, #1
	movle	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L18:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	compare_pic_by_poc_asc, .-compare_pic_by_poc_asc
	.align	2
	.global	compare_pic_by_poc_desc
	.type	compare_pic_by_poc_desc, %function
compare_pic_by_poc_desc:
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
	blt	.L21
	mvngt	r0, #0
	movle	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L21:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	compare_pic_by_poc_desc, .-compare_pic_by_poc_desc
	.align	2
	.global	compare_fs_by_poc_asc
	.type	compare_fs_by_poc_asc, %function
compare_fs_by_poc_asc:
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
	ldr	r2, [r2, #616]
	ldr	r3, [r3, #616]
	cmp	r2, r3
	blt	.L24
	movgt	r0, #1
	movle	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L24:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	compare_fs_by_poc_asc, .-compare_fs_by_poc_asc
	.align	2
	.global	compare_fs_by_poc_desc
	.type	compare_fs_by_poc_desc, %function
compare_fs_by_poc_desc:
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
	ldr	r2, [r2, #616]
	ldr	r3, [r3, #616]
	cmp	r2, r3
	blt	.L27
	mvngt	r0, #0
	movle	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L27:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	compare_fs_by_poc_desc, .-compare_fs_by_poc_desc
	.align	2
	.type	SetFrmRepeatCount.part.1, %function
SetFrmRepeatCount.part.1:
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
	add	ip, r0, #57344
	add	r0, r0, #24576
	ldr	lr, [ip, #3908]
	ldr	r2, [r0, #2144]
	ldr	r3, [ip, #3904]
	add	r2, r2, lr, lsr #1
	add	r0, r2, #1
	mov	r3, r3, lsr #1
	cmp	r3, r0
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
	ldrhi	r3, [ip, #3908]
	ldrls	r3, [ip, #3908]
	addhi	r3, r3, #4
	addls	r3, r3, #2
	str	r3, [ip, #3908]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	SetFrmRepeatCount.part.1, .-SetFrmRepeatCount.part.1
	.align	2
	.type	DumpList.part.5, %function
DumpList.part.5:
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
	add	r8, r0, #26880
	add	r10, r0, #20480
	add	r8, r8, #248
	add	r10, r10, #248
	mov	r7, r0
	mov	r6, #0
	mov	r9, r8
.L33:
	ldr	r3, [r10, #4]!
	cmp	r3, #0
	movne	r5, r9
	movne	r4, #0
	beq	.L36
.L34:
	ldr	ip, [r5, #4]!
	mov	r3, r4
	mov	r2, r6
	ldr	r1, .L67
	mov	r0, #13
	add	r4, r4, #1
	ldr	ip, [ip, #32]
	ldr	lr, [ip, #616]
	str	lr, [sp, #4]
	ldr	ip, [ip, #604]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [r10]
	cmp	r4, r3
	bcc	.L34
.L36:
	add	r6, r6, #1
	add	r9, r9, #132
	cmp	r6, #2
	bne	.L33
	add	r5, r7, #20480
	ldr	r3, [r5, #252]
	cmp	r3, #0
	bne	.L63
.L37:
	ldr	r3, [r5, #256]
	cmp	r3, #0
	bne	.L64
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L64:
	ldr	r1, .L67+4
	mov	r0, #13
	bl	dprint_vfmw
	ldr	r3, [r5, #256]
	cmp	r3, #0
	addne	r7, r7, #27136
	movne	r4, #0
	addne	r7, r7, #124
	bne	.L50
	b	.L51
.L65:
	bcc	.L48
	cmp	r2, #2
	ldr	r1, .L67+8
	mov	r0, #13
	bne	.L46
	ldr	r3, [r3, #32]
	ldr	r2, [r3, #616]
	bl	dprint_vfmw
.L46:
	ldr	r3, [r5, #256]
	add	r4, r4, #1
	cmp	r4, r3
	bcs	.L51
.L50:
	ldr	r3, [r7, #4]!
	ldrb	r2, [r3]
	cmp	r2, #1
	bne	.L65
	ldr	r3, [r3, #32]
	mov	r0, #13
	ldr	r1, .L67+12
	add	r4, r4, #1
	ldr	r2, [r3, #616]
	bl	dprint_vfmw
	ldr	r3, [r5, #256]
	cmp	r4, r3
	bcc	.L50
.L51:
	ldr	r1, .L67+16
	mov	r0, #13
	bl	dprint_vfmw
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L48:
	ldr	r3, [r3, #32]
	mov	r0, #13
	ldr	r1, .L67+20
	ldr	r2, [r3, #616]
	bl	dprint_vfmw
	b	.L46
.L63:
	ldr	r1, .L67+24
	mov	r0, #13
	bl	dprint_vfmw
	ldr	r3, [r5, #252]
	cmp	r3, #0
	movne	r4, #0
	bne	.L38
	b	.L43
.L66:
	bcc	.L41
	cmp	r2, #2
	ldr	r1, .L67+8
	mov	r0, #13
	bne	.L39
	ldr	r3, [r3, #32]
	ldr	r2, [r3, #616]
	bl	dprint_vfmw
.L39:
	ldr	r3, [r5, #252]
	add	r4, r4, #1
	cmp	r4, r3
	bcs	.L43
.L38:
	ldr	r3, [r8, #4]!
	ldrb	r2, [r3]
	cmp	r2, #1
	bne	.L66
	ldr	r3, [r3, #32]
	mov	r0, #13
	ldr	r1, .L67+12
	add	r4, r4, #1
	ldr	r2, [r3, #616]
	bl	dprint_vfmw
	ldr	r3, [r5, #252]
	cmp	r4, r3
	bcc	.L38
.L43:
	ldr	r1, .L67+16
	mov	r0, #13
	bl	dprint_vfmw
	b	.L37
.L41:
	ldr	r3, [r3, #32]
	mov	r0, #13
	ldr	r1, .L67+20
	ldr	r2, [r3, #616]
	bl	dprint_vfmw
	b	.L39
.L68:
	.align	2
.L67:
	.word	.LC0
	.word	.LC6
	.word	.LC5
	.word	.LC4
	.word	.LC2
	.word	.LC3
	.word	.LC1
	.fnend
	.size	DumpList.part.5, .-DumpList.part.5
	.align	2
	.type	CombinePacket.part.11, %function
CombinePacket.part.11:
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
	ldr	r1, .L70
	mov	r4, r0
	mov	r0, #7
	mov	r5, #0
	bl	dprint_vfmw
	ldr	ip, [r4, #368]
	ldr	r1, .L70+4
	mov	r0, #7
	ldr	lr, [ip, #40]
	ldr	r3, [ip, #44]
	ldr	r2, [ip, #16]
	str	lr, [sp, #4]
	ldr	ip, [ip, #12]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [r4, #368]
	ldr	ip, .L70+8
	ldr	r2, [r3, #12]
	ldr	r0, [r3, #36]
	ldr	r1, [r3, #8]
	rsb	r0, r2, r0
	ldr	r3, [ip, #52]
	blx	r3
	ldr	r3, [r4, #368]
	mov	ip, #1
	ldr	r1, .L70+12
	mov	r0, #7
	ldr	r2, [r3, #60]
	ldr	r6, [r3, #32]
	str	r2, [r3, #32]
	ldr	r3, [r4, #368]
	str	r5, [r3, #24]
	ldr	r3, [r4, #368]
	ldr	lr, [r3, #12]
	ldr	r2, [r3, #36]
	rsb	r2, lr, r2
	str	r2, [r3, #8]
	ldr	r3, [r4, #368]
	ldr	lr, [r3, #12]
	ldr	r2, [r3, #44]
	rsb	r2, lr, r2
	str	r2, [r3, #16]
	ldr	r3, [r4, #368]
	ldr	lr, [r3, #40]
	ldr	r2, [r3, #12]
	add	r2, r2, lr
	str	r2, [r3, #12]
	ldr	r3, [r4, #368]
	str	ip, [r3, #68]
	ldr	r2, [r4, #368]
	ldr	r3, [r2, #12]
	ldr	r2, [r2, #16]
	bl	dprint_vfmw
	add	r3, r4, #57344
	mov	r1, r6
	ldr	r0, [r3, #3888]
	bl	SM_ReleaseStreamSeg
	ldr	r3, [r4, #368]
	str	r5, [r3, #36]
	ldr	r3, [r4, #368]
	str	r5, [r3, #52]
	ldr	r3, [r4, #368]
	str	r5, [r3, #40]
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L71:
	.align	2
.L70:
	.word	.LC7
	.word	.LC8
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC9
	.fnend
	.size	CombinePacket.part.11, .-CombinePacket.part.11
	.align	2
	.global	ue_v
	.type	ue_v, %function
ue_v:
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
	add	r7, r0, #13504
	add	r7, r7, #24
	mov	r8, r0
	mov	r6, r1
	mov	r1, #32
	mov	r0, r7
	bl	BsShow
	mov	r5, r0
	bl	ZerosMS_32
	cmp	r0, #15
	mov	r4, r0
	bls	.L76
	cmp	r0, #31
	bls	.L77
	add	r3, r8, #57344
	mvn	r5, #0
	mov	r7, #32
	mov	r2, #1
	str	r2, [r3, #3828]
.L74:
	ldr	ip, [r8, #368]
	mov	r2, r6
	mov	r3, r5
	ldr	r1, .L78
	mov	r0, #21
	ldr	lr, [ip, #64]
	add	r4, lr, r7
	str	r4, [ip, #64]
	bl	dprint_vfmw
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L76:
	mov	r4, r0, asl #1
	mov	r0, r7
	add	r7, r4, #1
	rsb	r4, r4, #31
	mov	r4, r5, lsr r4
	mov	r1, r7
	sub	r5, r4, #1
	bl	BsSkip
	b	.L74
.L77:
	add	r5, r0, #1
	mov	r1, r0
	mov	r0, r7
	bl	BsSkip
	mov	r1, r5
	mov	r0, r7
	bl	BsShow
	mov	r1, r5
	sub	r5, r0, #1
	mov	r0, r7
	bl	BsSkip
	mov	ip, r4, asl #1
	add	r7, ip, #1
	b	.L74
.L79:
	.align	2
.L78:
	.word	.LC10
	.fnend
	.size	ue_v, .-ue_v
	.align	2
	.global	se_v
	.type	se_v, %function
se_v:
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
	add	r6, r0, #13504
	add	r6, r6, #24
	mov	r8, r0
	mov	r7, r1
	mov	r1, #32
	mov	r0, r6
	bl	BsShow
	mov	r4, r0
	bl	ZerosMS_32
	cmp	r0, #15
	mov	r5, r0
	bhi	.L81
	mov	r5, r0, asl #1
	mov	r0, r6
	rsb	r3, r5, #31
	add	r5, r5, #1
	mov	r3, r4, lsr r3
	and	r2, r3, #1
	mov	r1, r5
	rsb	r4, r2, #0
	eor	r4, r4, r3, lsr #1
	add	r4, r4, r2
	bl	BsSkip
.L82:
	ldr	lr, [r8, #368]
	mov	r2, r7
	mov	r3, r4
	ldr	r1, .L85
	mov	r0, #21
	ldr	ip, [lr, #64]
	add	r5, ip, r5
	str	r5, [lr, #64]
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L81:
	cmp	r0, #31
	bls	.L84
	add	r3, r8, #57344
	mov	r2, #1
	mvn	r4, #-2147483648
	mov	r5, #32
	str	r2, [r3, #3828]
	b	.L82
.L84:
	mov	r1, r0
	mov	r0, r6
	bl	BsSkip
	mov	r1, r5
	mov	r0, r6
	mov	r5, r5, asl #1
	bl	BsGet
	mov	r1, #1
	add	r5, r5, #1
	mov	r9, r0
	mov	r0, r6
	bl	BsGet
	and	r0, r0, #1
	rsb	r4, r0, #0
	eor	r9, r9, r4
	add	r4, r9, r0
	b	.L82
.L86:
	.align	2
.L85:
	.word	.LC10
	.fnend
	.size	se_v, .-se_v
	.align	2
	.global	u_v
	.type	u_v, %function
u_v:
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
	add	r0, r0, #13504
	mov	r6, r1
	add	r0, r0, #24
	mov	r7, r2
	bl	BsGet
	ldr	lr, [r5, #368]
	mov	r2, r7
	ldr	r1, .L88
	ldr	ip, [lr, #64]
	add	ip, ip, r6
	str	ip, [lr, #64]
	mov	r4, r0
	mov	r0, #21
	mov	r3, r4
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L89:
	.align	2
.L88:
	.word	.LC10
	.fnend
	.size	u_v, .-u_v
	.align	2
	.global	u_1
	.type	u_1, %function
u_1:
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
	add	r0, r0, #13504
	mov	r6, r1
	add	r0, r0, #24
	mov	r1, #1
	bl	BsGet
	ldr	lr, [r5, #368]
	mov	r2, r6
	ldr	r1, .L91
	ldr	ip, [lr, #64]
	add	ip, ip, #1
	str	ip, [lr, #64]
	mov	r4, r0
	mov	r3, r0
	mov	r0, #21
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L92:
	.align	2
.L91:
	.word	.LC10
	.fnend
	.size	u_1, .-u_1
	.align	2
	.global	H264_IsEosNal
	.type	H264_IsEosNal, %function
H264_IsEosNal:
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
	add	r4, r0, #13504
	add	r4, r4, #24
	mov	r1, #32
	mov	r0, r4
	bl	BsGet
	mov	r1, #32
	mov	r5, r0
	mov	r0, r4
	bl	BsGet
	movw	r2, #20036
	movw	r3, #20553
	movt	r2, 17221
	movt	r3, 18515
	cmp	r0, r2
	cmpeq	r5, r3
	moveq	r0, #1
	movne	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	H264_IsEosNal, .-H264_IsEosNal
	.align	2
	.global	GetMinPOC
	.type	GetMinPOC, %function
GetMinPOC:
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
	add	r5, r0, #24576
	mov	ip, #0
	mvn	r3, #-2147483648
	str	ip, [r2]
	str	r3, [r1]
	ldr	r3, [r5, #2148]
	ldr	ip, [r5, #2144]
	cmp	r3, ip
	strhi	ip, [r5, #2148]
	movhi	r3, ip
	cmp	r3, #0
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	add	r0, r0, #26368
	mov	r3, #0
	add	r0, r0, #156
.L98:
	ldr	ip, [r0, #4]!
	ldr	r4, [r1]
	ldr	lr, [ip, #616]
	cmp	r4, lr
	ble	.L97
	ldrb	ip, [ip, #4]
	cmp	ip, #0
	strne	lr, [r1]
	strne	r3, [r2]
.L97:
	ldr	ip, [r5, #2148]
	add	r3, r3, #1
	cmp	ip, r3
	bhi	.L98
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	GetMinPOC, .-GetMinPOC
	.align	2
	.global	FrameStoreRefFlg
	.type	FrameStoreRefFlg, %function
FrameStoreRefFlg:
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
	ldrb	r0, [r0, #2]
	adds	r0, r0, #0
	movne	r0, #1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	FrameStoreRefFlg, .-FrameStoreRefFlg
	.align	2
	.global	ShortTermRefFlg
	.type	ShortTermRefFlg, %function
ShortTermRefFlg:
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
	cmp	r3, #3
	beq	.L120
	tst	r3, #1
	bne	.L121
.L109:
	and	r3, r3, #2
	ands	r3, r3, #255
	beq	.L113
.L110:
	ldr	r0, [r0, #716]
	bic	r0, r0, #-16777216
	bic	r0, r0, #255
	sub	r0, r0, #65536
	clz	r0, r0
	mov	r0, r0, lsr #5
	ldmfd	sp, {fp, sp, pc}
.L113:
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L121:
	ldr	r2, [r0, #680]
	bic	r2, r2, #-16777216
	bic	r2, r2, #255
	cmp	r2, #65536
	bne	.L109
.L114:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L120:
	ldr	r3, [r0, #644]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #65536
	beq	.L114
	ldr	r3, [r0, #680]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #65536
	bne	.L110
	b	.L114
	.fnend
	.size	ShortTermRefFlg, .-ShortTermRefFlg
	.align	2
	.global	LongTermRefFlg
	.type	LongTermRefFlg, %function
LongTermRefFlg:
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
	cmp	r3, #3
	beq	.L137
	tst	r3, #1
	bne	.L138
.L126:
	and	r3, r3, #2
	ands	r3, r3, #255
	beq	.L130
.L127:
	ldr	r0, [r0, #716]
	bic	r0, r0, #-16777216
	bic	r0, r0, #255
	sub	r0, r0, #256
	clz	r0, r0
	mov	r0, r0, lsr #5
	ldmfd	sp, {fp, sp, pc}
.L130:
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L138:
	ldr	r2, [r0, #680]
	bic	r2, r2, #-16777216
	bic	r2, r2, #255
	cmp	r2, #256
	bne	.L126
.L131:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L137:
	ldr	r3, [r0, #644]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #256
	beq	.L131
	ldr	r3, [r0, #680]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #256
	bne	.L127
	b	.L131
	.fnend
	.size	LongTermRefFlg, .-LongTermRefFlg
	.align	2
	.global	UpdateLTReflist
	.type	UpdateLTReflist, %function
UpdateLTReflist:
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
	add	r9, r0, #24576
	mov	r6, r0
	ldr	r8, [r9, #2148]
	cmp	r8, #0
	beq	.L146
	add	r10, r0, #26368
	mov	r4, #0
	add	r10, r10, #156
	mov	r5, r4
.L142:
	ldr	r7, [r10, #4]!
	add	r5, r5, #1
	mov	r0, r7
	bl	LongTermRefFlg
	add	r3, r4, #6656
	add	r3, r3, #8
	cmp	r0, #0
	strne	r7, [r6, r3, asl #2]
	addne	r4, r4, #1
	cmp	r5, r8
	bne	.L142
.L140:
	ldr	r3, [r9, #2144]
	str	r4, [r9, #2156]
	cmp	r3, r4
	ldmlsfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	add	r0, r4, #6656
	mov	r2, #0
	add	r0, r0, #7
	add	r0, r6, r0, lsl #2
.L144:
	add	r4, r4, #1
	str	r2, [r0, #4]!
	cmp	r4, r3
	bne	.L144
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L146:
	mov	r4, r8
	b	.L140
	.fnend
	.size	UpdateLTReflist, .-UpdateLTReflist
	.align	2
	.global	UpdateReflist
	.type	UpdateReflist, %function
UpdateReflist:
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
	add	r9, r0, #24576
	mov	r6, r0
	ldr	r8, [r9, #2148]
	cmp	r8, #0
	beq	.L159
	add	r10, r0, #26368
	mov	r4, #0
	add	r10, r10, #156
	mov	r5, r4
.L155:
	ldr	r7, [r10, #4]!
	add	r5, r5, #1
	mov	r0, r7
	bl	ShortTermRefFlg
	add	r3, r4, #6592
	add	r3, r3, #56
	cmp	r0, #0
	strne	r7, [r6, r3, asl #2]
	addne	r4, r4, #1
	cmp	r5, r8
	bne	.L155
.L153:
	ldr	r3, [r9, #2144]
	str	r4, [r9, #2152]
	cmp	r3, r4
	ldmlsfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	add	r0, r4, #6592
	mov	r2, #0
	add	r0, r0, #55
	add	r0, r6, r0, lsl #2
.L157:
	add	r4, r4, #1
	str	r2, [r0, #4]!
	cmp	r4, r3
	bne	.L157
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L159:
	mov	r4, r8
	b	.L153
	.fnend
	.size	UpdateReflist, .-UpdateReflist
	.align	2
	.global	GetPicNumX
	.type	GetPicNumX, %function
GetPicNumX:
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
	.size	GetPicNumX, .-GetPicNumX
	.align	2
	.global	UnMarkFrameStoreRef
	.type	UnMarkFrameStoreRef, %function
UnMarkFrameStoreRef:
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
	ldrb	r3, [r1, #1]
	tst	r3, #1
	beq	.L169
	ldrb	r2, [r1, #2]
	mov	ip, #0
	strb	ip, [r1, #681]
	and	r2, r2, #2
	strb	ip, [r1, #682]
	strb	r2, [r1, #2]
.L169:
	tst	r3, #2
	beq	.L170
	ldrb	r2, [r1, #2]
	mov	ip, #0
	strb	ip, [r1, #717]
	and	r2, r2, #1
	strb	ip, [r1, #718]
	strb	r2, [r1, #2]
.L170:
	cmp	r3, #3
	add	r0, r0, #57344
	moveq	r3, #0
	streqb	r3, [r1, #646]
	streqb	r3, [r1, #645]
	mov	r3, #0
	mov	r2, r3
	strb	r3, [r1, #2]
	ldr	r1, [r1, #600]
	ldr	r0, [r0, #3888]
	bl	FSP_SetRef
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	UnMarkFrameStoreRef, .-UnMarkFrameStoreRef
	.align	2
	.type	SlidingWinMark.part.2, %function
SlidingWinMark.part.2:
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
	add	r3, r0, #24576
	mov	r8, r0
	ldr	r7, [r3, #2148]
	cmp	r7, #0
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	add	r6, r0, #26368
	mov	r4, #0
	add	r6, r6, #156
.L181:
	ldr	r5, [r6, #4]!
	add	r4, r4, #1
	ldrb	r3, [r5, #2]
	mov	r0, r5
	cmp	r3, #0
	beq	.L180
	bl	ShortTermRefFlg
	cmp	r0, #0
	bne	.L192
.L180:
	cmp	r4, r7
	bne	.L181
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L192:
	mov	r0, r8
	mov	r1, r5
	bl	UnMarkFrameStoreRef
	mov	r0, r8
	bl	UpdateReflist
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	SlidingWinMark.part.2, .-SlidingWinMark.part.2
	.align	2
	.global	UnMarkLTFrmByFrmIdx
	.type	UnMarkLTFrmByFrmIdx, %function
UnMarkLTFrmByFrmIdx:
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
	add	r3, r0, #24576
	ldr	r4, [r3, #2156]
	cmp	r4, #0
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	ip, [r3, #2080]
	ldr	r3, [ip, #612]
	cmp	r3, r1
	addne	r2, r0, #26624
	movne	r3, #0
	addne	r2, r2, #32
	bne	.L197
	b	.L195
.L198:
	ldr	ip, [r2, #4]!
	ldr	lr, [ip, #612]
	cmp	lr, r1
	beq	.L195
.L197:
	add	r3, r3, #1
	cmp	r3, r4
	bne	.L198
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L195:
	mov	r1, ip
	bl	UnMarkFrameStoreRef
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	UnMarkLTFrmByFrmIdx, .-UnMarkLTFrmByFrmIdx
	.align	2
	.global	UnMarkLTFldByFrmIdx
	.type	UnMarkLTFldByFrmIdx, %function
UnMarkLTFldByFrmIdx:
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
	add	ip, r0, #24576
	ldr	r6, [ip, #2156]
	cmp	r6, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	add	r4, r0, #26624
	mov	ip, #0
	add	r4, r4, #28
	b	.L208
.L206:
	cmp	ip, r6
	beq	.L222
.L208:
	ldr	lr, [r4, #4]!
	add	ip, ip, #1
	ldr	r5, [lr, #612]
	cmp	r5, r3
	bne	.L206
	cmp	r2, #1
	ldreqb	r5, [lr, #717]
	beq	.L221
	cmp	r2, #2
	bne	.L206
	ldrb	r5, [lr, #681]
.L221:
	clz	r5, r5
	mov	r5, r5, lsr #5
	cmp	lr, r1
	orrne	r5, r5, #1
	cmp	r5, #0
	beq	.L206
	mov	r1, lr
	bl	UnMarkFrameStoreRef
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L222:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	UnMarkLTFldByFrmIdx, .-UnMarkLTFldByFrmIdx
	.align	2
	.global	UnMarkSTRef
	.type	UnMarkSTRef, %function
UnMarkSTRef:
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
	ldrb	r3, [r1, #3]
	cmp	r3, #0
	bne	.L224
	add	ip, r0, #24576
	ldr	r1, [r1, #616]
	ldr	r4, [ip, #2152]
	sub	r1, r1, #1
	rsb	r2, r2, r1
	cmp	r4, #0
	beq	.L252
	add	ip, r0, #26368
	add	ip, ip, #220
	b	.L230
.L229:
	cmp	r3, r4
	beq	.L253
.L230:
	ldr	r1, [ip, #4]!
	add	r3, r3, #1
	ldr	lr, [r1, #652]
	cmp	lr, r2
	bne	.L229
	ldrb	lr, [r1, #2]
	cmp	lr, #3
	bne	.L229
	ldr	lr, [r1, #644]
	bic	lr, lr, #-16777216
	bic	lr, lr, #255
	cmp	lr, #65536
	bne	.L229
	bl	UnMarkFrameStoreRef
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L224:
	add	r3, r0, #24576
	ldr	r1, [r1, #616]
	ldr	r5, [r3, #2152]
	rsb	r2, r2, r1, lsl #1
	cmp	r5, #0
	beq	.L254
	add	r4, r0, #26368
	mov	ip, #0
	add	r4, r4, #220
	b	.L235
.L231:
	tst	r3, #2
	beq	.L233
	ldr	r3, [r1, #716]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #65536
	beq	.L255
.L233:
	add	ip, ip, #1
	cmp	ip, r5
	beq	.L256
.L235:
	ldr	r1, [r4, #4]!
	ldrb	r3, [r1, #2]
	ands	r6, r3, #1
	beq	.L231
	ldr	lr, [r1, #680]
	bic	lr, lr, #-16777216
	bic	lr, lr, #255
	cmp	lr, #65536
	bne	.L231
	ldr	lr, [r1, #688]
	cmp	lr, r2
	bne	.L231
	add	r2, r0, ip, lsl #2
	and	r3, r3, #2
	add	r2, r2, #24576
	strb	r3, [r1, #2]
	mov	r1, #0
	ldr	r3, [r2, #2016]
	strb	r1, [r3, #682]
	ldr	r3, [r2, #2016]
	ldrb	ip, [r3, #644]
	cmp	ip, #3
	cmpne	ip, r1
	streqb	r1, [r3, #646]
	ldreq	r3, [r2, #2016]
	streqb	r1, [r3, #645]
	ldreq	r3, [r2, #2016]
	ldrb	r1, [r3, #2]
	cmp	r1, #0
	ldmnefd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	ip, [r3, #636]
	add	lr, r0, #57344
	mov	r2, r1
	add	ip, ip, #14912
	add	ip, ip, #26
	str	r1, [r0, ip, asl #2]
	ldr	r1, [r3, #600]
	ldr	r0, [lr, #3888]
	bl	FSP_SetRef
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L255:
	ldr	r3, [r1, #724]
	cmp	r3, r2
	bne	.L233
	add	r3, r0, ip, lsl #2
	strb	r6, [r1, #2]
	add	r3, r3, #24576
	mov	r2, #0
	ldr	r1, [r3, #2016]
	strb	r2, [r1, #718]
	ldr	r1, [r3, #2016]
	ldrb	ip, [r1, #644]
	cmp	ip, #3
	cmpne	ip, r2
	streqb	r2, [r1, #646]
	ldreq	r1, [r3, #2016]
	streqb	r2, [r1, #645]
	ldreq	r1, [r3, #2016]
	ldrb	r3, [r1, #2]
	cmp	r3, #0
	ldmnefd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	ip, [r1, #636]
	add	lr, r0, #57344
	mov	r2, r3
	add	ip, ip, #14912
	add	ip, ip, #26
	str	r3, [r0, ip, asl #2]
	ldr	r1, [r1, #600]
	ldr	r0, [lr, #3888]
	bl	FSP_SetRef
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L256:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L253:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L252:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L254:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	UnMarkSTRef, .-UnMarkSTRef
	.align	2
	.global	UnMarkLTRef
	.type	UnMarkLTRef, %function
UnMarkLTRef:
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
	ldrb	r3, [r1, #3]
	cmp	r3, #0
	beq	.L258
	add	r3, r0, #24576
	ldr	r5, [r3, #2156]
	cmp	r5, #0
	beq	.L286
	add	r4, r0, #26624
	mov	ip, #0
	add	r4, r4, #28
	b	.L267
.L263:
	tst	r3, #2
	beq	.L265
	ldr	r3, [r1, #716]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #256
	beq	.L287
.L265:
	add	ip, ip, #1
	cmp	ip, r5
	beq	.L288
.L267:
	ldr	r1, [r4, #4]!
	ldrb	r3, [r1, #2]
	ands	r6, r3, #1
	beq	.L263
	ldr	lr, [r1, #680]
	bic	lr, lr, #-16777216
	bic	lr, lr, #255
	cmp	lr, #256
	bne	.L263
	ldr	lr, [r1, #684]
	cmp	r2, lr
	bne	.L263
	add	r2, r0, ip, lsl #2
	and	r3, r3, #2
	add	r2, r2, #24576
	strb	r3, [r1, #2]
	mov	r1, #0
	ldr	r3, [r2, #2080]
	strb	r1, [r3, #681]
	ldr	r3, [r2, #2080]
	ldrb	ip, [r3, #644]
	cmp	ip, #3
	cmpne	ip, r1
	streqb	r1, [r3, #646]
	ldreq	r3, [r2, #2080]
	streqb	r1, [r3, #645]
	ldreq	r3, [r2, #2080]
	ldrb	r2, [r3, #2]
	cmp	r2, #0
	ldreq	r3, [r3, #636]
	addeq	r3, r3, #14912
	addeq	r3, r3, #26
	streq	r2, [r0, r3, asl #2]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L258:
	add	r1, r0, #24576
	ldr	r4, [r1, #2156]
	cmp	r4, #0
	beq	.L289
	add	ip, r0, #26624
	add	ip, ip, #28
	b	.L269
.L268:
	cmp	r3, r4
	beq	.L290
.L269:
	ldr	r1, [ip, #4]!
	add	r3, r3, #1
	ldr	lr, [r1, #648]
	cmp	lr, r2
	bne	.L268
	ldrb	lr, [r1, #2]
	cmp	lr, #3
	bne	.L268
	ldr	lr, [r1, #644]
	bic	lr, lr, #-16777216
	bic	lr, lr, #255
	cmp	lr, #256
	bne	.L268
	bl	UnMarkFrameStoreRef
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L287:
	ldr	r3, [r1, #720]
	cmp	r2, r3
	bne	.L265
	add	r3, r0, ip, lsl #2
	strb	r6, [r1, #2]
	add	r3, r3, #24576
	mov	r1, #0
	ldr	r2, [r3, #2080]
	strb	r1, [r2, #717]
	ldr	r2, [r3, #2080]
	ldrb	ip, [r2, #644]
	cmp	ip, #3
	cmpne	ip, r1
	streqb	r1, [r2, #646]
	ldreq	r2, [r3, #2080]
	streqb	r1, [r2, #645]
	ldreq	r2, [r3, #2080]
	ldrb	r1, [r2, #2]
	cmp	r1, #0
	ldreq	r3, [r2, #636]
	addeq	r3, r3, #14912
	addeq	r3, r3, #26
	streq	r1, [r0, r3, asl #2]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L290:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L288:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L289:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L286:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	UnMarkLTRef, .-UnMarkLTRef
	.align	2
	.global	MarkPicLTRef
	.type	MarkPicLTRef, %function
MarkPicLTRef:
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
	ldrb	r5, [r3, #3]
	add	r3, r0, #24576
	cmp	r5, #0
	beq	.L292
	ldr	r7, [r3, #2152]
	cmp	r7, #0
	beq	.L321
	add	r6, r0, #26368
	mov	ip, #0
	add	r6, r6, #220
	b	.L306
.L298:
	tst	r4, #2
	beq	.L301
	ldr	lr, [r3, #716]
	bic	lr, lr, #-16777216
	bic	lr, lr, #255
	cmp	lr, #65536
	beq	.L322
.L301:
	add	ip, ip, #1
	cmp	ip, r7
	beq	.L323
.L306:
	ldr	r3, [r6, #4]!
	ldrb	r4, [r3, #2]
	tst	r4, #1
	beq	.L298
	ldr	lr, [r3, #680]
	bic	lr, lr, #-16777216
	bic	lr, lr, #255
	cmp	lr, #65536
	bne	.L298
	ldr	lr, [r3, #688]
	cmp	lr, r2
	bne	.L298
	ldrb	lr, [r3, #717]
	cmp	lr, #1
	bne	.L302
	ldr	lr, [r3, #612]
	cmp	lr, r1
	bne	.L301
.L302:
	str	r1, [r3, #612]
	sub	r3, r5, #1
	add	r2, r0, ip, lsl #2
	clz	r3, r3
	add	r2, r2, #24576
	mov	ip, #1
	mov	r3, r3, lsr #5
	mov	r0, #0
	add	r1, r3, r1, lsl #1
	ldr	r3, [r2, #2016]
	str	r1, [r3, #684]
	ldr	r3, [r2, #2016]
	strb	ip, [r3, #681]
	ldr	r3, [r2, #2016]
	strb	r0, [r3, #682]
	ldr	r3, [r2, #2016]
	ldrb	r1, [r3, #644]
	cmp	r1, #3
	cmpne	r1, r0
	bne	.L324
	ldrb	r1, [r3, #717]
	ldrb	r0, [r3, #681]
	cmp	r1, r0
	streqb	r1, [r3, #645]
	ldreq	r3, [r2, #2016]
	ldreqb	r2, [r3, #682]
	streqb	r2, [r3, #646]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L292:
	ldr	r6, [r3, #2152]
	cmp	r6, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	add	lr, r0, #26368
	mov	r3, r5
	add	lr, lr, #220
	b	.L297
.L296:
	add	r3, r3, #1
	cmp	r3, r6
	beq	.L325
.L297:
	ldr	ip, [lr, #4]!
	ldrb	r4, [ip, #2]
	cmp	r4, #3
	bne	.L296
	ldr	r4, [ip, #644]
	bic	r4, r4, #-16777216
	bic	r4, r4, #255
	cmp	r4, #65536
	bne	.L296
	ldr	r4, [ip, #652]
	cmp	r4, r2
	bne	.L296
	add	r3, r0, r3, lsl #2
	str	r1, [ip, #612]
	add	r3, r3, #24576
	mov	r0, #1
	mov	r2, #0
	ldr	ip, [r3, #2016]
	str	r1, [ip, #648]
	ldr	r1, [r3, #2016]
	strb	r0, [r1, #645]
	ldr	r1, [r3, #2016]
	strb	r0, [r1, #681]
	ldr	r1, [r3, #2016]
	strb	r0, [r1, #717]
	ldr	r1, [r3, #2016]
	strb	r2, [r1, #646]
	ldr	r1, [r3, #2016]
	strb	r2, [r1, #682]
	ldr	r3, [r3, #2016]
	strb	r2, [r3, #718]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L322:
	ldr	lr, [r3, #724]
	cmp	lr, r2
	bne	.L301
	ldrb	lr, [r3, #681]
	cmp	lr, #1
	bne	.L305
	ldr	lr, [r3, #612]
	cmp	lr, r1
	bne	.L301
.L305:
	str	r1, [r3, #612]
	sub	r3, r5, #2
	add	r0, r0, ip, lsl #2
	clz	r3, r3
	add	r0, r0, #24576
	mov	ip, #1
	mov	r3, r3, lsr #5
	mov	r2, #0
	add	r1, r3, r1, lsl #1
	ldr	r3, [r0, #2016]
	str	r1, [r3, #720]
	ldr	r3, [r0, #2016]
	strb	ip, [r3, #717]
	ldr	r3, [r0, #2016]
	strb	r2, [r3, #718]
	ldr	r3, [r0, #2016]
	ldrb	r2, [r3, #644]
	cmp	r2, #3
	cmpne	r2, #0
	bne	.L326
	ldrb	r2, [r3, #717]
	ldrb	r1, [r3, #681]
	cmp	r2, r1
	streqb	r2, [r3, #645]
	ldreq	r3, [r0, #2016]
	ldreqb	r2, [r3, #718]
	streqb	r2, [r3, #646]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L323:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L325:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L324:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L326:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L321:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	MarkPicLTRef, .-MarkPicLTRef
	.align	2
	.global	MarkSTToLTRef
	.type	MarkSTToLTRef, %function
MarkSTToLTRef:
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
	bne	.L328
	ldr	r5, [r6, #616]
	mov	r1, r3
	sub	r5, r5, #1
	rsb	r5, r2, r5
	bl	UnMarkLTFrmByFrmIdx
.L329:
	mov	r3, r6
	mov	r2, r5
	mov	r1, r8
	mov	r0, r7
	bl	MarkPicLTRef
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L328:
	add	r3, r0, #24576
	ldr	r5, [r6, #616]
	ldr	r1, [r3, #2152]
	rsb	r5, r2, r5, lsl #1
	cmp	r1, #0
	beq	.L329
	add	r2, r0, #26368
	mov	lr, #0
	add	r2, r2, #220
	b	.L332
.L330:
	tst	r3, #2
	beq	.L331
	ldr	r3, [ip, #716]
	bic	r3, r3, #-16777216
	bic	r3, r3, #255
	cmp	r3, #65536
	beq	.L343
.L331:
	cmp	lr, r1
	beq	.L329
.L332:
	ldr	ip, [r2, #4]!
	add	lr, lr, #1
	ldrb	r3, [ip, #2]
	tst	r3, #1
	beq	.L330
	ldr	r4, [ip, #680]
	bic	r4, r4, #-16777216
	bic	r4, r4, #255
	cmp	r4, #65536
	bne	.L330
	ldr	r0, [ip, #688]
	cmp	r0, r5
	bne	.L330
	mov	r1, ip
	mov	r3, r8
	mov	r2, #1
	mov	r0, r7
	bl	UnMarkLTFldByFrmIdx
	b	.L329
.L343:
	ldr	r3, [ip, #724]
	cmp	r3, r5
	bne	.L331
	mov	r1, ip
	mov	r3, r8
	mov	r2, #2
	mov	r0, r7
	bl	UnMarkLTFldByFrmIdx
	b	.L329
	.fnend
	.size	MarkSTToLTRef, .-MarkSTToLTRef
	.align	2
	.global	UpdateMaxLTFrmIdx
	.type	UpdateMaxLTFrmIdx, %function
UpdateMaxLTFrmIdx:
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
	add	r6, r0, #24576
	mov	r7, r0
	ldr	r3, [r6, #2156]
	str	r1, [r6, #2160]
	cmp	r3, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	add	r5, r0, #26624
	mov	r3, r1
	add	r5, r5, #28
	mov	r4, #0
	b	.L348
.L346:
	ldr	r3, [r6, #2156]
	cmp	r3, r4
	ldmlsfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	r3, [r6, #2160]
.L348:
	ldr	r1, [r5, #4]!
	add	r4, r4, #1
	ldr	r2, [r1, #612]
	cmp	r2, r3
	bcc	.L346
	mov	r0, r7
	bl	UnMarkFrameStoreRef
	b	.L346
	.fnend
	.size	UpdateMaxLTFrmIdx, .-UpdateMaxLTFrmIdx
	.align	2
	.global	UnMarkAllSTRef
	.type	UnMarkAllSTRef, %function
UnMarkAllSTRef:
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
	add	r7, r0, #24576
	mov	r6, r0
	ldr	r3, [r7, #2152]
	cmp	r3, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	add	r5, r0, #26368
	mov	r4, #0
	add	r5, r5, #220
.L351:
	ldr	r1, [r5, #4]!
	mov	r0, r6
	bl	UnMarkFrameStoreRef
	ldr	r3, [r7, #2152]
	add	r4, r4, #1
	cmp	r3, r4
	bhi	.L351
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	UnMarkAllSTRef, .-UnMarkAllSTRef
	.align	2
	.global	MarkCurrPicLT
	.type	MarkCurrPicLT, %function
MarkCurrPicLT:
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
	beq	.L357
	mov	r3, r5
	ldr	r1, [r1, #608]
	bl	UnMarkLTFldByFrmIdx
.L356:
	mov	r2, #1
	mov	r3, #0
	str	r5, [r4, #620]
	strb	r2, [r4, #4]
	strb	r3, [r4, #5]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L357:
	mov	r1, r5
	bl	UnMarkLTFrmByFrmIdx
	b	.L356
	.fnend
	.size	MarkCurrPicLT, .-MarkCurrPicLT
	.align	2
	.global	RemoveFrameStoreOutDPB
	.type	RemoveFrameStoreOutDPB, %function
RemoveFrameStoreOutDPB:
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
	add	r5, r0, r1, lsl #2
	add	r5, r5, #24576
	mov	r4, r1
	mov	r6, r0
	ldr	r2, [r5, #1952]
	cmp	r2, #0
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	ldr	r3, [r2, #640]
	add	r7, r0, #24576
	mov	r1, #0
	add	r8, r0, #57344
	add	r3, r3, #6656
	add	r3, r3, #28
	add	r3, r0, r3, lsl #2
	str	r1, [r3, #4]
	ldr	r3, [r7, #2424]
	cmp	r3, r1
	subne	r3, r3, #1
	str	r3, [r7, #2424]
	ldr	r1, [r2, #600]
	ldr	r0, [r8, #3888]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	beq	.L361
	ldrsb	r3, [r0, #1]
	cmp	r3, #3
	beq	.L362
	ldr	r3, [r5, #1952]
	mov	r2, #0
	ldr	r0, [r8, #3888]
	ldr	r1, [r3, #600]
	bl	FSP_SetDisplay
.L362:
	ldr	r3, [r5, #1952]
	mov	r2, #0
	ldr	r0, [r8, #3888]
	ldr	r1, [r3, #600]
	bl	FSP_SetRef
.L361:
	ldr	r2, [r5, #1952]
	mov	r3, #0
	strb	r3, [r2, #1]
	ldr	r2, [r5, #1952]
	strb	r3, [r2, #4]
	ldr	r2, [r5, #1952]
	strb	r3, [r2, #2]
	ldr	r1, [r7, #2148]
	sub	r1, r1, #1
	cmp	r4, r1
	addcc	r3, r4, #6592
	addcc	r3, r3, #40
	addcc	r3, r6, r3, lsl #2
	bcs	.L365
.L364:
	add	r4, r4, #1
	ldr	r2, [r3, #4]!
	cmp	r4, r1
	str	r2, [r3, #-4]
	bne	.L364
.L365:
	add	r3, r1, #6592
	mov	r2, #0
	add	r3, r3, #40
	str	r2, [r6, r3, asl #2]
	str	r1, [r7, #2148]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	RemoveFrameStoreOutDPB, .-RemoveFrameStoreOutDPB
	.align	2
	.global	RemoveUnUsedFrameStore
	.type	RemoveUnUsedFrameStore, %function
RemoveUnUsedFrameStore:
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
	subs	r5, r0, #0
	beq	.L389
	add	r3, r5, #24576
	ldr	r6, [r3, #2148]
	cmp	r6, #0
	addne	r7, r5, #57344
	movne	r10, #0
	movne	r8, r10
	movne	r9, r10
	bne	.L387
	b	.L388
.L398:
	ldrb	r1, [r2, #4]
	cmp	r1, #0
	bne	.L385
	ldr	r0, [r2, #752]
	cmp	r0, #1
	beq	.L385
	strb	r1, [r2, #1]
	mov	r0, r5
	mov	r1, r10
	add	r8, r8, #1
	bl	RemoveFrameStoreOutDPB
	cmp	r8, r6
	beq	.L388
.L387:
	add	r4, r5, r10, lsl #2
	ldr	r0, [r7, #3888]
	add	r4, r4, #24576
	ldr	r2, [r4, #1952]
	ldr	r1, [r2, #600]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	beq	.L382
	ldrsh	r2, [r0]
	cmp	r2, #0
	bne	.L383
	ldr	r1, [r4, #1952]
	ldrb	r2, [r1, #2]
	cmp	r2, #0
	bne	.L384
	ldrsb	r0, [r0]
	cmp	r0, #0
	bne	.L397
.L384:
	mvn	r3, #0
	str	r3, [r1, #600]
	ldr	r2, [r4, #1952]
	strb	r9, [r2, #2]
.L382:
	ldr	r1, [r4, #1952]
	ldr	r2, [r1, #752]
	sub	r2, r2, #1
	clz	r2, r2
	mov	r2, r2, lsr #5
	strb	r2, [r1, #4]
.L383:
	ldr	r2, [r4, #1952]
	ldrb	r1, [r2, #2]
	cmp	r1, #0
	beq	.L398
.L385:
	add	r8, r8, #1
	add	r10, r10, #1
	cmp	r8, r6
	bne	.L387
.L388:
	mov	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L397:
	ldr	r1, [r1, #600]
	ldr	r0, [r7, #3888]
	bl	FSP_SetRef
	ldr	r1, [r4, #1952]
	b	.L384
.L389:
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	.fnend
	.size	RemoveUnUsedFrameStore, .-RemoveUnUsedFrameStore
	.align	2
	.global	CheckFrameStore
	.type	CheckFrameStore, %function
CheckFrameStore:
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
	add	r3, r0, #57344
	mov	r5, r0
	mov	r4, r1
	ldr	r2, [r3, #2492]
	cmp	r2, #0
	bne	.L400
	ldr	r2, [r1, #752]
	cmp	r2, #1
	beq	.L401
	ldr	r2, [r3, #3816]
	cmp	r2, #0
	beq	.L425
.L401:
	mov	r2, #1
	str	r2, [r3, #2492]
.L400:
	ldr	r0, [r3, #3888]
	ldr	r1, [r4, #600]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	beq	.L403
	ldrsb	r3, [r0, #1]
	cmp	r3, #3
	cmpne	r3, #0
	beq	.L426
	ldrb	r2, [r4, #1]
	ldrb	r3, [r4]
	cmp	r2, #0
	beq	.L411
	cmp	r3, #1
	beq	.L411
	ldr	r3, [r4]
	mov	r1, #768
	movt	r1, 768
	bic	r3, r3, #16711680
	bic	r3, r3, #255
	cmp	r3, r1
	beq	.L427
	cmp	r2, #1
	beq	.L428
	cmp	r2, #2
	beq	.L429
.L409:
	ldr	r3, [r5]
	ldr	r2, [r0, #168]
	ldr	r3, [r3, #4]
	cmp	r2, r3
	movls	r0, #0
	bhi	.L430
.L424:
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L425:
	ldr	r2, [r0]
	ldr	r2, [r2, #12]
	cmp	r2, #0
	bne	.L401
	mvn	r0, #0
	b	.L424
.L426:
	ldr	r2, [r4, #600]
	mov	r0, #1
	ldr	r1, .L431
	bl	dprint_vfmw
.L405:
	ldr	r3, [r4, #752]
	cmp	r3, #1
	beq	.L412
	mvn	r0, #2
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L428:
	ldrb	r3, [r4, #3]
	tst	r3, #1
	beq	.L409
	mov	r0, r2
	ldr	r1, .L431+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L424
.L429:
	ldrb	r3, [r4, #3]
	tst	r3, #2
	beq	.L409
	ldr	r1, .L431+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L424
.L412:
	mov	r3, #2
	mvn	r0, #2
	str	r3, [r4, #752]
	b	.L424
.L403:
	ldr	ip, [r4, #600]
	mov	r2, r4
	ldr	r3, [r4, #752]
	mov	r0, #1
	ldr	r1, .L431+12
	str	ip, [sp]
	bl	dprint_vfmw
	b	.L405
.L411:
	ldr	r1, .L431+16
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L424
.L430:
	ldr	r1, .L431+20
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L424
.L427:
	ldrb	r3, [r4, #3]
	mov	r0, #1
	ldr	r1, .L431+24
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L424
.L432:
	.align	2
.L431:
	.word	.LC11
	.word	.LC15
	.word	.LC16
	.word	.LC12
	.word	.LC13
	.word	.LC17
	.word	.LC14
	.fnend
	.size	CheckFrameStore, .-CheckFrameStore
	.align	2
	.global	ExchangePts
	.type	ExchangePts, %function
ExchangePts:
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
	add	r10, r1, #576
	mvn	r5, #0
	mvn	r4, #0
	str	r0, [fp, #-52]
	ldrd	r2, [r10]
	cmp	r3, r5
	cmpeq	r2, r4
	beq	.L433
	add	r9, r0, #24576
	ldr	r3, [r9, #2148]
	cmp	r3, #0
	beq	.L433
	add	r8, r0, #26368
	add	r5, r0, #57344
	add	r8, r8, #156
	mvn	r6, #1
	mvn	r7, #0
	mov	r4, #0
	mvn	r3, #0
	str	r3, [fp, #-48]
.L438:
	ldr	r3, [r8, #4]!
	cmp	r3, #0
	beq	.L437
	ldr	r1, [r3, #600]
	ldr	r0, [r5, #3888]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	beq	.L437
	ldrsb	r3, [r0, #1]
	cmp	r3, #3
	cmpne	r3, #0
	beq	.L437
	ldr	r3, [r8]
	add	r3, r3, #576
	ldrd	r0, [r3]
	cmp	r1, r7
	cmpeq	r0, r6
	strcc	r4, [fp, #-48]
	movcc	r6, r0
	movcc	r7, r1
.L437:
	ldr	r3, [r9, #2148]
	add	r4, r4, #1
	cmp	r4, r3
	bcc	.L438
	ldr	r3, [fp, #-48]
	cmn	r3, #1
	beq	.L433
	ldrd	r2, [r10]
	cmp	r3, r7
	cmpeq	r2, r6
	bhi	.L452
.L433:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L452:
	strd	r6, [sp]
	mov	r0, #29
	ldr	r1, .L453
	bl	dprint_vfmw
	ldr	r3, [fp, #-48]
	ldr	r1, [fp, #-52]
	add	r8, r3, #6592
	ldrd	r2, [r10]
	add	r8, r8, #40
	ldr	r1, [r1, r8, asl #2]
	add	r1, r1, #576
	strd	r2, [r1]
	strd	r6, [r10]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L454:
	.align	2
.L453:
	.word	.LC18
	.fnend
	.size	ExchangePts, .-ExchangePts
	.align	2
	.global	GetImagePara
	.type	GetImagePara, %function
GetImagePara:
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
	add	lr, r0, #12288
	add	r2, r0, #20480
	mov	r8, #2208
	ldr	r3, [lr, #1304]
	mov	r4, r1
	ldr	r2, [r2, #220]
	add	r5, r0, #57344
	ldr	ip, [r1, #116]
	mov	r7, #4000
	ldr	r6, [lr, #1300]
	mla	r1, r8, r2, r3
	bic	r2, ip, #768
	bic	r2, r2, #3
	ldrb	lr, [r4, #1]
	ldr	r3, [r1, #28]
	str	r2, [r4, #116]
	ldr	r1, [r5, #2500]
	mla	r3, r7, r3, r6
	mov	r1, r1, asl #10
	str	r1, [r4, #144]
	cmp	lr, #3
	ldrls	pc, [pc, lr, asl #2]
	b	.L491
.L458:
	.word	.L457
	.word	.L459
	.word	.L460
	.word	.L457
.L460:
	ldr	r1, [r4, #628]
	mov	r7, #3
	ldr	lr, [r4, #632]
	add	r6, r0, #24576
	ldr	ip, [r4, #736]
	and	r1, r1, r7
	orr	r2, r2, r1
	str	r7, [r4, #108]
	orr	r2, r2, #2816
	str	lr, [r4, #168]
	str	r2, [r4, #116]
	str	ip, [r4, #112]
.L456:
	ldrb	r2, [r3, #18]
	str	r2, [r4, #448]
	str	r2, [r4, #452]
	ldrb	r2, [r3, #22]
	cmp	r2, #0
	ldrne	r2, [r3, #3332]
	mov	r3, #1
	str	r3, [r4, #456]
	str	r2, [r4, #460]
	ldr	r3, [r0]
	ldr	r3, [r3, #12]
	cmp	r3, #0
	ble	.L477
	ldrb	r3, [r4, #644]
	cmp	r3, #0
	bne	.L477
	ldrb	r3, [r4, #1]
	cmp	r3, #3
	ldreq	r3, [r4, #116]
	biceq	r3, r3, #768
	streq	r3, [r4, #116]
.L477:
	mov	r1, r4
	bl	ExchangePts
	ldrb	r3, [r6, #1816]
	cmp	r3, #0
	beq	.L478
	ldr	r3, [r6, #1832]
	cmp	r3, #3
	moveq	r3, #1
	streq	r3, [r4, #328]
	beq	.L478
	cmp	r3, #4
	moveq	r3, #2
	streq	r3, [r4, #328]
	beq	.L478
	cmp	r3, #5
	moveq	r3, #3
	streq	r3, [r4, #328]
	beq	.L478
	mov	r0, #0
	ldr	r1, .L502
	str	r0, [r4, #328]
	ldr	r2, [r6, #1832]
	bl	dprint_vfmw
.L478:
	ldr	r0, [r5, #3888]
	ldr	r1, [r4, #600]
	bl	FSP_GetFsImagePtr
	subs	r5, r0, #0
	ldmeqfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	ldr	r3, .L502+4
	mov	r2, #592
	add	r1, r4, #8
	ldr	r3, [r3, #52]
	blx	r3
	mov	r3, #0
	str	r3, [r5, #340]
	mov	r2, #1
	ldrb	r3, [r4, #644]
	strb	r2, [r5, #335]
	cmp	r3, #0
	movne	r3, #4
	strb	r3, [r5, #328]
	ldr	r3, [r4, #668]
	strb	r2, [r5, #333]
	str	r3, [r5, #344]
	str	r3, [r5, #352]
	str	r3, [r5, #348]
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L459:
	ldr	r1, [r4, #628]
	mov	r7, #3
	ldr	lr, [r4, #632]
	add	r6, r0, #24576
	ldr	ip, [r4, #700]
	and	r1, r1, r7
	orr	r2, r2, r1
	str	r7, [r4, #112]
	orr	r2, r2, #1792
	str	lr, [r4, #168]
	str	r2, [r4, #116]
	str	ip, [r4, #108]
	b	.L456
.L457:
	ldrb	r2, [r4, #644]
	cmp	r2, #0
	bne	.L461
	ldr	r2, [r4, #624]
	mov	r9, #3072
	ldr	r1, [r4, #632]
	cmp	r2, #0
	ldr	r7, [r4, #700]
	ldr	r2, [r4, #628]
	ldr	lr, [r4, #736]
	moveq	r8, #512
	movne	r8, #768
	str	r1, [r4, #168]
.L463:
	ldr	r6, [r4, #692]
	ldr	r1, [r4, #728]
	cmp	r6, r1
	beq	.L499
	movle	r1, #1
	movgt	r1, #0
.L474:
	add	r6, r0, #24576
	ldrb	r10, [r6, #1852]
	cmp	r10, #3
	moveq	r1, #4096
	beq	.L475
	cmp	r10, #4
	movne	r1, r1, asl #12
	moveq	r1, #0
.L475:
	bic	ip, ip, #13056
	orr	r8, r9, r8
	bic	ip, ip, #3
	and	r2, r2, #3
	orr	ip, r8, ip
	str	r7, [r4, #108]
	orr	r2, ip, r2
	str	lr, [r4, #112]
	orr	r2, r2, r1
	str	r2, [r4, #116]
	b	.L456
.L461:
	ldr	r7, [r4, #696]
	ldr	r2, [r5, #3884]
	ldr	r1, [r4, #732]
	cmp	r7, r2
	bhi	.L500
	cmp	r2, r1
	bcc	.L467
.L465:
	ldr	r1, [r4, #632]
	mov	r8, #3
	ldr	r2, [r4, #628]
	ldr	r6, [r4, #700]
	str	r1, [r4, #168]
	ldr	r1, [r4, #736]
.L468:
	ldrb	lr, [r4, #3]
	cmp	lr, #1
	beq	.L501
	cmp	lr, #2
	streq	r7, [r4, #168]
	movne	r9, r8, asl #10
	moveq	r2, r6
	moveq	r9, #1024
.L470:
	mov	r7, r6
	mov	lr, r1
	mov	r8, #768
	str	r6, [r4, #108]
	str	r1, [r4, #112]
	b	.L463
.L467:
	ldr	r2, [r4, #700]
	mov	r8, #1
	ldr	r1, [r4, #736]
	str	r7, [r4, #168]
	mov	r6, r2
	b	.L468
.L499:
	ldr	r1, [r4, #120]
	cmp	r1, #720
	movne	r1, #1
	bne	.L474
	ldr	r1, [r4, #124]
	subs	r1, r1, #480
	movne	r1, #1
	b	.L474
.L500:
	cmp	r2, r1
	bcc	.L465
	ldr	r2, [r4, #736]
	mov	r8, #2
	str	r1, [r4, #168]
	ldr	r6, [r4, #700]
	mov	r1, r2
	b	.L468
.L501:
	ldr	lr, [r4, #732]
	mov	r2, r1
	mov	r9, #2048
	str	lr, [r4, #168]
	b	.L470
.L491:
	add	r6, r0, #24576
	b	.L456
.L503:
	.align	2
.L502:
	.word	.LC19
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	GetImagePara, .-GetImagePara
	.align	2
	.global	SetFrmRepeatCount
	.type	SetFrmRepeatCount, %function
SetFrmRepeatCount:
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
	ldr	r3, [r0]
	ldr	r3, [r3, #600]
	add	r3, r3, #2032
	add	r3, r3, #15
	cmp	r3, #4096
	movcc	r3, #0
	strcc	r3, [r1, #24]
	ldmccfd	sp, {fp, sp, pc}
	bl	SetFrmRepeatCount.part.1
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	SetFrmRepeatCount, .-SetFrmRepeatCount
	.align	2
	.global	SplitFrmToFlds
	.type	SplitFrmToFlds, %function
SplitFrmToFlds:
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
	ldrb	lr, [r0, #645]
	ldrb	ip, [r0, #646]
	mov	r5, #1
	ldr	r1, [r0, #660]
	mov	r4, #2
	ldr	r2, [r0, #664]
	ldr	r3, [r0, #676]
	strb	r5, [r0, #680]
	strb	r4, [r0, #716]
	strb	lr, [r0, #681]
	strb	lr, [r0, #717]
	strb	ip, [r0, #682]
	strb	ip, [r0, #718]
	str	r1, [r0, #696]
	str	r1, [r0, #732]
	str	r2, [r0, #700]
	str	r2, [r0, #736]
	str	r3, [r0, #712]
	str	r3, [r0, #748]
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	SplitFrmToFlds, .-SplitFrmToFlds
	.align	2
	.global	CombineFldsToFrm
	.type	CombineFldsToFrm, %function
CombineFldsToFrm:
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
	ldr	r2, [r0, #728]
	ldr	r1, [r0, #692]
	mov	lr, #3
	ldr	r3, [r0, #732]
	cmp	r2, r1
	ldr	r5, [r0, #696]
	ldrb	r4, [r0, #717]
	ldr	ip, [r0, #712]
	movge	r2, r1
	add	r3, r3, r5
	cmp	r4, #0
	strb	lr, [r0, #644]
	mov	r3, r3, lsr #1
	str	ip, [r0, #676]
	str	r2, [r0, #656]
	str	r2, [r0, #616]
	str	r3, [r0, #660]
	beq	.L509
	ldrb	r2, [r0, #681]
	cmp	r2, #0
	bne	.L510
.L509:
	ldr	r2, [r0, #716]
	mov	r1, #0
	strb	r1, [r0, #645]
	bic	r2, r2, #-16777216
	bic	r2, r2, #255
	cmp	r2, r1
	beq	.L514
	ldr	r2, [r0, #680]
	bic	r2, r2, #-16777216
	bic	r2, r2, #255
	cmp	r2, #0
	movne	ip, #1
	bne	.L512
.L514:
	mov	ip, #0
.L512:
	ldr	r2, [r0, #736]
	ldr	r1, [r0, #700]
	str	r3, [r0, #632]
	cmp	r2, r1
	strb	ip, [r0, #646]
	movcs	r3, r2
	movcc	r3, r1
	str	r3, [r0, #664]
	str	r3, [r0, #628]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L510:
	mov	r1, #1
	strb	r1, [r0, #645]
	b	.L514
	.fnend
	.size	CombineFldsToFrm, .-CombineFldsToFrm
	.align	2
	.global	GetAPC
	.type	GetAPC, %function
GetAPC:
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
	subs	r7, r1, #0
	mov	r5, r0
	beq	.L545
	cmp	r2, #1
	beq	.L526
	cmp	r2, #2
	beq	.L527
	ldr	r8, [r7, #692]
	ldr	r9, [r7, #728]
.L528:
	add	r6, r5, #24576
	ldr	ip, [r6, #2420]
	cmp	ip, #0
	beq	.L537
	ldr	r4, [r6, #2164]
	cmp	r4, #0
	addne	r3, r5, #26624
	movne	r4, #0
	addne	r3, r3, #116
	bne	.L531
	b	.L529
.L535:
	ldr	r2, [r3, #4]!
	cmp	r2, #0
	beq	.L529
.L531:
	add	r4, r4, #1
	cmp	r4, ip
	bne	.L535
.L537:
	mvn	r0, #0
.L541:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L527:
	ldr	r8, [r7, #728]
	mov	r9, r8
	b	.L528
.L529:
	add	r3, r5, #57344
	ldr	r1, [r7, #600]
	ldr	r0, [r3, #3888]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	beq	.L532
	ldr	r3, [r0, #608]
	cmp	r3, #0
	beq	.L532
	add	r5, r5, r4, lsl #2
	mov	r3, #1
	add	r5, r5, #24576
	ldr	r1, .L546
	str	r3, [r5, #2164]
	ldr	r3, [r0, #608]
	mov	r0, #13
	ldr	r3, [r3, #8]
	str	r8, [r5, #2292]
	str	r9, [r5, #2356]
	str	r3, [r5, #2228]
	ldr	r3, [r6, #2424]
	cmp	r3, #15
	addls	r3, r3, #1
	movhi	r3, #16
	str	r3, [r6, #2424]
	mov	r3, r4
	ldr	r2, [r7, #164]
	bl	dprint_vfmw
	mov	r0, #0
	str	r4, [r7, #640]
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L526:
	ldr	r8, [r7, #692]
	mov	r9, r8
	b	.L528
.L532:
	mov	r1, #0
	ldr	r2, [r7, #600]
	ldrb	r3, [r7, #2]
	stmia	sp, {r0, r1}
	mov	r0, r1
	ldr	r1, .L546+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L541
.L545:
	mov	r0, r7
	movw	r3, #2197
	ldr	r2, .L546+8
	ldr	r1, .L546+12
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L541
.L547:
	.align	2
.L546:
	.word	.LC22
	.word	.LC23
	.word	.LC20
	.word	.LC21
	.fnend
	.size	GetAPC, .-GetAPC
	.align	2
	.global	SlidingWinMark
	.type	SlidingWinMark, %function
SlidingWinMark:
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
	add	r2, r0, #24576
	add	r3, r0, #16384
	ldr	r1, [r2, #2156]
	ldr	r3, [r3, #456]
	ldr	r2, [r2, #2152]
	rsb	r3, r1, r3
	cmp	r2, r3
	ldmnefd	sp, {fp, sp, pc}
	bl	SlidingWinMark.part.2
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	SlidingWinMark, .-SlidingWinMark
	.align	2
	.global	DumpDPB
	.type	DumpDPB, %function
DumpDPB:
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
	ldr	r3, .L563
	mov	r5, r0
	ldr	r3, [r3]
	tst	r3, #16384
	beq	.L550
	add	r6, r0, #24576
	ldr	r3, [r6, #2148]
	cmp	r3, #0
	addne	r7, r0, #26368
	movne	r4, #0
	addne	r7, r7, #156
	beq	.L556
.L555:
	ldr	ip, [r7, #4]!
	mov	r2, r4
	ldr	r1, .L563+4
	mov	r0, #14
	add	r4, r4, #1
	ldrb	lr, [ip, #2]
	ldr	r3, [ip, #604]
	str	lr, [sp, #4]
	ldr	ip, [ip, #616]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [r6, #2148]
	cmp	r3, r4
	bhi	.L555
.L556:
	ldr	r1, .L563+8
	mov	r0, #14
	bl	dprint_vfmw
	ldr	r3, [r6, #2152]
	cmp	r3, #0
	addne	r5, r5, #26368
	movne	r4, #0
	addne	r5, r5, #220
	beq	.L554
.L557:
	ldr	ip, [r5, #4]!
	mov	r2, r4
	ldr	r1, .L563+12
	mov	r0, #14
	ldrb	lr, [ip, #2]
	ldr	r3, [ip, #604]
	str	lr, [sp, #4]
	ldr	ip, [ip, #616]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [r5]
	mov	r2, r4
	ldr	r1, .L563+16
	mov	r0, #14
	add	r4, r4, #1
	ldr	r3, [r3, #656]
	bl	dprint_vfmw
	ldr	r3, [r6, #2152]
	cmp	r3, r4
	bhi	.L557
.L554:
	ldr	r1, .L563+8
	mov	r0, #14
	bl	dprint_vfmw
.L550:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L564:
	.align	2
.L563:
	.word	g_PrintEnable
	.word	.LC24
	.word	.LC2
	.word	.LC25
	.word	.LC26
	.fnend
	.size	DumpDPB, .-DumpDPB
	.align	2
	.global	UpdateCurrFrameInfo
	.type	UpdateCurrFrameInfo, %function
UpdateCurrFrameInfo:
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
	add	r3, r0, #57344
	ldrb	r2, [r3, #458]
	ldr	r4, [r3, #1064]
	strb	r2, [r4]
	ldrb	r2, [r3, #460]
	cmp	r2, #0
	movne	r2, #3
	bne	.L566
	ldrb	r2, [r3, #461]
	cmp	r2, #0
	movne	r2, #3
.L566:
	strb	r2, [r4, #2]
	ldr	r2, [r3, #1072]
	str	r2, [r4, #604]
	ldr	r2, [r3, #1108]
	str	r2, [r4, #632]
	ldr	r2, [r3, #1100]
	str	r2, [r4, #628]
	ldr	r2, [r3, #1084]
	str	r2, [r4, #616]
	ldr	r2, [r3, #1132]
	str	r2, [r4, #636]
	ldr	r2, [r3, #1076]
	str	r2, [r4, #612]
	ldrb	r2, [r3, #465]
	str	r2, [r4, #624]
	ldrb	r2, [r3, #463]
	cmp	r2, #1
	moveq	r1, #3
	movne	r1, #0
	strb	r1, [r4, #3]
	ldrb	r2, [r3, #459]
	cmp	r2, #1
	beq	.L569
	bcc	.L570
	cmp	r2, #2
	ldmnefd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	str	r4, [r4, #748]
	mov	r0, #1
	strb	r0, [r4, #716]
	mov	r0, #0
	ldrb	ip, [r3, #460]
	strb	ip, [r4, #717]
	ldrb	ip, [r3, #461]
	strb	ip, [r4, #718]
	ldr	ip, [r3, #1092]
	str	ip, [r4, #728]
	ldr	lr, [r3, #1100]
	str	lr, [r4, #736]
	ldr	ip, [r3, #1108]
	str	r0, [r4, #624]
	str	ip, [r4, #732]
	ldrb	r5, [r3, #457]
	cmp	r5, r0
	beq	.L587
	ldr	r2, [r4, #696]
	mov	r5, #3
	strb	r5, [r4, #1]
	mvn	r7, #0
	add	ip, ip, r2
	str	ip, [r4, #632]
	str	ip, [r4, #660]
	mvn	r6, #0
	ldrb	r2, [r3, #463]
	cmp	r2, #1
	add	r2, r3, #1040
	orreq	r0, r1, #2
	strb	r0, [r4, #3]
	ldrd	r8, [r2]
	cmp	r9, r7
	cmpeq	r8, r6
	beq	.L578
	add	r2, r4, #576
	ldrd	r0, [r2]
	cmp	r1, r7
	cmpeq	r0, r6
	beq	.L588
.L578:
	ldr	r2, [r4, #700]
.L585:
	cmp	r2, lr
	mov	r0, r4
	movcc	r2, lr
	str	r2, [r4, #628]
	ldr	r3, [r3, #1084]
	str	r3, [r4, #616]
	bl	CombineFldsToFrm
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L570:
	str	r4, [r4, #676]
	mov	r1, #3
	mov	r2, #0
	strb	r1, [r4, #1]
	strb	r2, [r4, #644]
	add	r1, r3, #472
	ldrb	r5, [r3, #460]
	mov	r2, #592
	add	r0, r4, #8
	strb	r5, [r4, #645]
	ldrb	r6, [r3, #461]
	strb	r6, [r4, #646]
	ldr	ip, [r3, #1088]
	str	ip, [r4, #656]
	ldr	r7, [r3, #1100]
	str	r7, [r4, #664]
	ldr	r8, [r3, #1108]
	str	r8, [r4, #660]
	ldr	ip, [r3, #1092]
	str	ip, [r4, #692]
	ldr	r3, [r3, #1096]
	str	r3, [r4, #728]
	bl	memcpy
	mov	r2, #1
	mov	r3, #2
	str	r8, [r4, #696]
	str	r8, [r4, #732]
	str	r7, [r4, #700]
	str	r7, [r4, #736]
	strb	r6, [r4, #682]
	strb	r6, [r4, #718]
	strb	r5, [r4, #681]
	strb	r5, [r4, #717]
	str	r4, [r4, #712]
	str	r4, [r4, #748]
	strb	r2, [r4, #680]
	strb	r3, [r4, #716]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L569:
	strb	r2, [r4, #680]
	mov	r0, #0
	str	r4, [r4, #712]
	ldrb	ip, [r3, #460]
	strb	ip, [r4, #681]
	ldrb	ip, [r3, #461]
	strb	ip, [r4, #682]
	ldr	ip, [r3, #1092]
	str	ip, [r4, #692]
	ldr	lr, [r3, #1100]
	str	lr, [r4, #700]
	ldr	ip, [r3, #1108]
	str	r0, [r4, #624]
	str	ip, [r4, #696]
	ldrb	r5, [r3, #457]
	cmp	r5, r0
	beq	.L589
	ldr	r2, [r4, #732]
	mov	r5, #3
	strb	r5, [r4, #1]
	mvn	r7, #0
	add	ip, ip, r2
	str	ip, [r4, #632]
	str	ip, [r4, #660]
	mvn	r6, #0
	ldrb	r2, [r3, #463]
	cmp	r2, #1
	add	r2, r3, #1040
	orreq	r0, r1, #1
	strb	r0, [r4, #3]
	ldrd	r8, [r2]
	cmp	r9, r7
	cmpeq	r8, r6
	beq	.L574
	add	r2, r4, #576
	ldrd	r0, [r2]
	cmp	r1, r7
	cmpeq	r0, r6
	streqd	r8, [r2]
.L574:
	ldr	r2, [r4, #736]
	b	.L585
.L587:
	strb	r2, [r4, #1]
	add	r1, r3, #472
	str	ip, [r4, #632]
	add	r0, r4, #8
	str	ip, [r4, #660]
	mov	r2, #592
	ldrb	r3, [r3, #463]
	cmp	r3, #1
	moveq	r5, #2
	strb	r5, [r4, #3]
	bl	memcpy
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L589:
	strb	r2, [r4, #1]
	add	r1, r3, #472
	str	ip, [r4, #632]
	add	r0, r4, #8
	str	ip, [r4, #660]
	mov	r2, #592
	ldrb	r3, [r3, #463]
	sub	r3, r3, #1
	clz	r3, r3
	mov	r3, r3, lsr #5
	strb	r3, [r4, #3]
	bl	memcpy
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L588:
	strd	r8, [r2]
	b	.L578
	.fnend
	.size	UpdateCurrFrameInfo, .-UpdateCurrFrameInfo
	.align	2
	.global	SimpleSlideDPB
	.type	SimpleSlideDPB, %function
SimpleSlideDPB:
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
	add	r3, r0, #24576
	mov	r4, r0
	ldr	r1, [r3, #2148]
	ldr	r2, [r3, #2144]
	cmp	r1, r2
	bcs	.L596
.L591:
	add	r0, r4, #57344
	mov	r2, #0
	ldr	r3, [r0, #1080]
	strb	r2, [r0, #460]
	cmp	r3, r2
	movne	r3, #1
	strneb	r3, [r0, #461]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L596:
	ldr	r1, [r3, #1952]
	bl	UnMarkFrameStoreRef
	mov	r1, #0
	mov	r0, r4
	bl	RemoveFrameStoreOutDPB
	b	.L591
	.fnend
	.size	SimpleSlideDPB, .-SimpleSlideDPB
	.align	2
	.global	ReleaseNAL
	.type	ReleaseNAL, %function
ReleaseNAL:
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
	beq	.L606
	add	r7, r5, #56
	mov	r4, r5
	mov	r3, #0
	strb	r3, [r5, #1]
	strb	r3, [r5, #4]
.L601:
	ldr	r3, [r4, #8]
	mov	r0, r6
	cmp	r3, #0
	beq	.L600
	ldr	r1, [r4, #32]
	bl	SM_ReleaseStreamSeg
	ldr	r3, [r4, #12]
	ldr	r2, [r4, #8]
	mov	r0, #7
	ldr	r1, .L607
	bl	dprint_vfmw
	mov	r3, #0
	str	r3, [r4, #8]
	str	r3, [r4, #24]
	str	r3, [r4, #12]
.L600:
	add	r4, r4, #28
	cmp	r4, r7
	bne	.L601
	mov	r3, #0
	strb	r3, [r5]
	str	r3, [r5, #68]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L606:
	mov	r0, r5
	movw	r3, #4182
	ldr	r2, .L607+4
	ldr	r1, .L607+8
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L608:
	.align	2
.L607:
	.word	.LC27
	.word	.LC20
	.word	.LC21
	.fnend
	.size	ReleaseNAL, .-ReleaseNAL
	.align	2
	.global	ClearCurrNal
	.type	ClearCurrNal, %function
ClearCurrNal:
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
	ldr	r1, [r0, #368]
	mov	r4, r0
	cmp	r1, #0
	beq	.L610
	add	r3, r0, #57344
	ldr	r0, [r3, #3888]
	bl	ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #368]
.L610:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	ClearCurrNal, .-ClearCurrNal
	.align	2
	.global	ClearCurrSlice
	.type	ClearCurrSlice, %function
ClearCurrSlice:
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
	ldr	r1, .L619
	mov	r5, r0
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r1, [r5, #368]
	add	r4, r5, #57344
	cmp	r1, #0
	beq	.L615
	ldr	r0, [r4, #3888]
	bl	ReleaseNAL
	mov	r3, #0
	str	r3, [r5, #368]
.L615:
	ldr	r3, [r4, #3844]
	mov	r0, #0
	add	r3, r3, #1
	str	r3, [r4, #3844]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L620:
	.align	2
.L619:
	.word	.LC28
	.fnend
	.size	ClearCurrSlice, .-ClearCurrSlice
	.align	2
	.global	ClearAllNal
	.type	ClearAllNal, %function
ClearAllNal:
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
	add	r5, r0, #13504
	add	r5, r5, #24
	add	r4, r0, #376
	add	r6, r0, #57344
	b	.L623
.L622:
	add	r4, r4, #96
	cmp	r4, r5
	beq	.L625
.L623:
	ldrb	r3, [r4, #1]
	cmp	r3, #1
	bne	.L622
	mov	r1, r4
	ldr	r0, [r6, #3888]
	add	r4, r4, #96
	bl	ReleaseNAL
	cmp	r4, r5
	bne	.L623
.L625:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	ClearAllNal, .-ClearAllNal
	.align	2
	.global	ClearAllSlice
	.type	ClearAllSlice, %function
ClearAllSlice:
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
	add	r4, r0, #59136
	add	r5, r0, #59648
	add	r4, r4, #68
	add	r5, r5, #100
	add	r6, r0, #57344
	mov	r7, #0
.L628:
	ldr	r1, [r4, #4]!
	cmp	r1, #0
	beq	.L627
	ldr	r0, [r6, #3888]
	bl	ReleaseNAL
	str	r7, [r4]
.L627:
	cmp	r4, r5
	bne	.L628
	mov	r0, #0
	str	r0, [r6, #3812]
	str	r0, [r6, #3872]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	ClearAllSlice, .-ClearAllSlice
	.align	2
	.global	H264_ClearCurrPic
	.type	H264_ClearCurrPic, %function
H264_ClearCurrPic:
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
	bl	ClearAllSlice
	add	r0, r4, #12288
	add	r3, r4, #20480
	mov	r2, #0
	ldr	r0, [r0, #1292]
	movw	r1, #23352
	movt	r1, 1
	mov	ip, #2
	str	r1, [r3, #1872]
	mov	r1, #7
	str	r0, [r3, #1864]
	mov	r0, #32
	str	r1, [r3, #1868]
	mov	r1, #3
	strb	r0, [r3, #1858]
	mvn	r0, #0
	str	r1, [r3, #1880]
	mov	r1, #262144
	str	r0, [r3, #1884]
	mov	r0, r2
	strb	ip, [r3, #1857]
	str	r1, [r3, #1896]
	strb	r2, [r3, #1856]
	str	r2, [r3, #1888]
	str	r2, [r3, #1892]
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	H264_ClearCurrPic, .-H264_ClearCurrPic
	.align	2
	.global	H264_ArrangeVahbMem
	.type	H264_ArrangeVahbMem, %function
H264_ArrangeVahbMem:
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
	ldr	r3, .L642
	mov	r5, r1
	mov	r6, r2
	mov	r4, r0
	mov	r2, #32
	sub	r0, fp, #60
	ldr	r3, [r3, #48]
	mov	r1, #0
	blx	r3
	ldr	r3, [r4]
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
	beq	.L635
	add	r2, r4, #24576
	ldrb	r3, [fp, #4]
	mov	r1, #5
	strb	r0, [fp, #-56]
	ldr	r2, [r2, #2144]
	strb	r1, [fp, #-55]
	add	r2, r2, #1
	strb	r2, [fp, #-57]
.L639:
	add	r5, r4, #57344
	sub	r1, fp, #60
	strb	r3, [fp, #-54]
	mov	r6, #0
	ldr	r0, [r5, #3888]
	strb	r6, [fp, #-58]
	bl	FSP_ConfigInstance
	subs	r7, r0, #0
	bne	.L636
	ldr	r1, [r4]
	sub	r3, fp, #64
	ldr	r0, [r5, #3888]
	ldr	r2, [r1, #24]
	ldr	r1, [r1, #20]
	bl	FSP_ConfigFrameBuf
	cmp	r0, r6
	moveq	r0, #1
	bne	.L641
.L640:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L635:
	mov	r3, #1
	mov	r2, #5
	strb	r0, [fp, #-56]
	strb	r3, [fp, #-57]
	strb	r2, [fp, #-55]
	b	.L639
.L636:
	mov	r0, r6
	ldr	r1, .L642+4
	bl	dprint_vfmw
	mvn	r0, #19
	b	.L640
.L641:
	mov	r0, r7
	ldr	r1, .L642+8
	bl	dprint_vfmw
	mvn	r0, #19
	b	.L640
.L643:
	.align	2
.L642:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC30
	.word	.LC29
	.fnend
	.size	H264_ArrangeVahbMem, .-H264_ArrangeVahbMem
	.align	2
	.global	RepairList
	.type	RepairList, %function
RepairList:
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
	add	r3, r0, #20480
	mov	r4, r0
	ldrb	r2, [r3, #208]
	cmp	r2, #1
	beq	.L646
	bcc	.L661
	cmp	r2, #2
	bne	.L670
.L662:
	mov	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L670:
	ldr	r1, .L674
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	bl	ClearCurrSlice
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L661:
	mov	r6, #1
.L647:
	add	r0, r4, #20480
	add	lr, r4, #26880
	add	r0, r0, #248
	mov	r5, #0
	add	lr, lr, #252
	add	r7, r4, #57344
	ldr	r3, [r0, #4]!
	mov	r2, r5
	mov	r8, #1
	cmp	r3, #0
	beq	.L649
.L672:
	ldr	r10, [lr]
	cmp	r10, #0
	bne	.L663
	mov	ip, lr
	mov	r1, r10
	b	.L651
.L652:
	ldr	r9, [ip, #4]!
	cmp	r9, #0
	bne	.L650
.L651:
	add	r1, r1, #1
	cmp	r1, r3
	bne	.L652
	ldr	r1, [r4]
	ldr	r1, [r1, #12]
	cmp	r1, #2
	bne	.L671
	ldr	r5, [r7, #1064]
	add	r5, r5, #644
.L654:
	mov	r9, r10
	mov	ip, lr
	mov	r1, #0
	b	.L660
.L656:
	ldr	r9, [ip, #4]!
.L660:
	add	r1, r1, #1
	cmp	r9, #0
	streq	r5, [ip]
	cmp	r1, r3
	bne	.L656
	add	r2, r2, #1
	add	lr, lr, #132
	cmp	r6, r2
	bls	.L662
.L669:
	ldr	r3, [r0, #4]!
	cmp	r3, #0
	bne	.L672
.L649:
	ldr	r1, [r4]
	ldr	r1, [r1, #12]
	cmp	r1, #2
	bne	.L673
	add	r2, r2, #1
	str	r8, [r0]
	cmp	r6, r2
	ldr	r3, [r7, #1064]
	add	lr, lr, #132
	add	r3, r3, #644
	str	r3, [lr, #-132]
	bhi	.L669
	b	.L662
.L663:
	mov	r9, r10
.L650:
	mov	r5, r9
	b	.L654
.L646:
	mov	r6, #2
	b	.L647
.L673:
	ldr	r1, .L674+4
.L667:
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	bl	ClearCurrSlice
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L671:
	mov	r2, r5
	mov	r3, #0
	ldr	r1, .L674+8
	b	.L667
.L675:
	.align	2
.L674:
	.word	.LC31
	.word	.LC33
	.word	.LC32
	.fnend
	.size	RepairList, .-RepairList
	.align	2
	.global	GetShortTermPicPoint
	.type	GetShortTermPicPoint, %function
GetShortTermPicPoint:
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
	add	r3, r0, #20480
	ldrb	r4, [r3, #209]
	cmp	r4, #0
	beq	.L677
	ldrb	r3, [r3, #210]
	cmp	r3, #0
	movne	r4, #2
	moveq	r4, #1
.L677:
	add	r3, r0, #24576
	ldr	r5, [r3, #2152]
	cmp	r5, #0
	beq	.L685
	add	r3, r0, #26368
	mov	r2, #0
	add	r3, r3, #224
	b	.L682
.L695:
	ldrb	ip, [r0, #2]
	cmp	ip, #3
	beq	.L693
.L680:
	add	r2, r2, #1
	add	r3, r3, #4
	cmp	r2, r5
	beq	.L694
.L682:
	cmp	r4, #0
	ldr	r0, [r3]
	beq	.L695
	ldrb	lr, [r0, #2]
	tst	lr, #1
	beq	.L681
	ldr	ip, [r0, #680]
	bic	ip, ip, #-16777216
	bic	ip, ip, #255
	cmp	ip, #65536
	beq	.L696
.L681:
	tst	lr, #2
	beq	.L680
	ldr	ip, [r0, #716]
	bic	ip, ip, #-16777216
	bic	ip, ip, #255
	cmp	ip, #65536
	bne	.L680
	ldr	ip, [r0, #724]
	cmp	ip, r1
	bne	.L680
	add	r0, r0, #716
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L693:
	ldr	ip, [r0, #644]
	bic	ip, ip, #-16777216
	bic	ip, ip, #255
	cmp	ip, #65536
	bne	.L680
	ldr	ip, [r0, #652]
	cmp	ip, r1
	bne	.L680
	add	r0, r0, #644
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L696:
	ldr	ip, [r0, #688]
	cmp	ip, r1
	bne	.L681
	add	r0, r0, #680
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L694:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L685:
	mov	r0, r5
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	GetShortTermPicPoint, .-GetShortTermPicPoint
	.align	2
	.global	GetLongTermPicPoint
	.type	GetLongTermPicPoint, %function
GetLongTermPicPoint:
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
	add	r3, r0, #20480
	ldrb	r4, [r3, #209]
	cmp	r4, #0
	beq	.L698
	ldrb	r3, [r3, #210]
	cmp	r3, #0
	movne	r4, #2
	moveq	r4, #1
.L698:
	add	r3, r0, #24576
	ldr	r5, [r3, #2156]
	cmp	r5, #0
	beq	.L706
	add	r3, r0, #26624
	mov	r2, #0
	add	r3, r3, #32
	b	.L703
.L716:
	ldrb	ip, [r0, #2]
	cmp	ip, #3
	beq	.L714
.L701:
	add	r2, r2, #1
	add	r3, r3, #4
	cmp	r2, r5
	beq	.L715
.L703:
	cmp	r4, #0
	ldr	r0, [r3]
	beq	.L716
	ldrb	lr, [r0, #2]
	tst	lr, #1
	beq	.L702
	ldr	ip, [r0, #680]
	bic	ip, ip, #-16777216
	bic	ip, ip, #255
	cmp	ip, #256
	beq	.L717
.L702:
	tst	lr, #2
	beq	.L701
	ldr	ip, [r0, #716]
	bic	ip, ip, #-16777216
	bic	ip, ip, #255
	cmp	ip, #256
	bne	.L701
	ldr	ip, [r0, #720]
	cmp	ip, r1
	bne	.L701
	add	r0, r0, #716
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L714:
	ldr	ip, [r0, #644]
	bic	ip, ip, #-16777216
	bic	ip, ip, #255
	cmp	ip, #256
	bne	.L701
	ldr	ip, [r0, #648]
	cmp	ip, r1
	bne	.L701
	add	r0, r0, #644
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L717:
	ldr	ip, [r0, #684]
	cmp	ip, r1
	bne	.L702
	add	r0, r0, #680
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L715:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L706:
	mov	r0, r5
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	GetLongTermPicPoint, .-GetLongTermPicPoint
	.align	2
	.global	ReorderSTList
	.type	ReorderSTList, %function
ReorderSTList:
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
	ldr	r7, [fp, #4]
	mov	r5, r1
	mov	r1, r3
	mov	r8, r2
	mov	r6, r3
	bl	GetShortTermPicPoint
	ldr	r4, [r7]
	add	r2, r8, #1
	cmp	r2, r4
	ble	.L719
	add	lr, r5, r2, lsl #2
	mov	ip, r2
.L720:
	ldr	r3, [lr, #-4]!
	sub	ip, ip, #1
	str	r3, [lr, #4]
	ldr	r4, [r7]
	cmp	r4, ip
	blt	.L720
.L719:
	add	r3, r4, #1
	str	r3, [r7]
	str	r0, [r5, r4, asl #2]
	ldr	ip, [r7]
	cmp	r2, ip
	ldmltfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	add	r4, r5, ip, lsl #2
	mov	lr, ip
.L724:
	ldr	r0, [r4], #4
	add	ip, ip, #1
	cmp	r0, #0
	beq	.L722
	ldrb	r3, [r0, #1]
	cmp	r3, #0
	bne	.L723
	ldr	r3, [r0, #8]
	cmp	r3, r6
	beq	.L722
.L723:
	str	r0, [r5, lr, asl #2]
	add	lr, lr, #1
.L722:
	cmp	r2, ip
	bge	.L724
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	ReorderSTList, .-ReorderSTList
	.align	2
	.global	ReorderLTList
	.type	ReorderLTList, %function
ReorderLTList:
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
	ldr	r7, [fp, #4]
	mov	r5, r1
	mov	r1, r3
	mov	r8, r2
	mov	r6, r3
	bl	GetLongTermPicPoint
	ldr	r4, [r7]
	add	r2, r8, #1
	cmp	r2, r4
	ble	.L732
	add	lr, r5, r2, lsl #2
	mov	ip, r2
.L733:
	ldr	r3, [lr, #-4]!
	sub	ip, ip, #1
	str	r3, [lr, #4]
	ldr	r4, [r7]
	cmp	r4, ip
	blt	.L733
.L732:
	add	r3, r4, #1
	str	r3, [r7]
	str	r0, [r5, r4, asl #2]
	ldr	ip, [r7]
	cmp	r2, ip
	ldmltfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	add	r4, r5, ip, lsl #2
	mov	lr, ip
.L737:
	ldr	r0, [r4], #4
	add	ip, ip, #1
	cmp	r0, #0
	beq	.L735
	ldrb	r3, [r0, #1]
	cmp	r3, #0
	beq	.L736
	ldr	r3, [r0, #4]
	cmp	r3, r6
	beq	.L735
.L736:
	str	r0, [r5, lr, asl #2]
	add	lr, lr, #1
.L735:
	cmp	r2, ip
	bge	.L737
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	ReorderLTList, .-ReorderLTList
	.align	2
	.global	ReorderRefPiclist
	.type	ReorderRefPiclist, %function
ReorderRefPiclist:
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
	add	r2, r0, #20480
	str	r1, [fp, #-56]
	mov	r8, r3
	mov	r3, #0
	ldrb	r1, [r2, #209]
	mov	r7, r0
	str	r3, [fp, #-48]
	cmp	r1, r3
	ldr	ip, [fp, #4]
	add	r3, r0, #12288
	beq	.L748
	ldr	lr, [r2, #220]
	mov	r4, #2208
	ldr	r5, [r3, #1304]
	mov	r0, #4000
	ldr	r6, [r2, #228]
	mov	r1, #2
	ldr	r3, [r3, #1300]
	mla	r2, r4, lr, r5
	mov	lr, r6, asl #1
	add	lr, lr, #1
	str	lr, [fp, #-64]
	ldr	r2, [r2, #28]
	mla	r3, r0, r2, r3
	ldr	r3, [r3, #2196]
	add	r3, r3, #4
	mov	r3, r1, asl r3
	str	r3, [fp, #-60]
.L758:
	adds	r9, r8, #2
	beq	.L747
	ldr	r3, [ip]
	cmp	r3, #3
	beq	.L747
	mov	r2, r8
	ldr	r6, [fp, #8]
	ldr	r5, [fp, #-64]
	mov	r4, #0
	mov	r8, ip
	mov	r10, r2
	b	.L751
.L752:
	ldr	r3, [fp, #12]
	sub	r1, fp, #48
	mov	r2, r10
	mov	r0, r7
	ldr	r3, [r3, r4, asl #2]
	add	r4, r4, #1
	str	r1, [sp]
	ldr	r1, [fp, #-56]
	bl	ReorderLTList
	cmp	r4, r9
	beq	.L747
.L757:
	ldr	r3, [r8, #4]!
	add	r6, r6, #4
	cmp	r3, #3
	beq	.L747
.L751:
	cmp	r3, #1
	bhi	.L752
	cmp	r3, #0
	ldr	r3, [r6]
	bne	.L753
	mvn	r3, r3
	adds	r5, r5, r3
	ldrmi	r3, [fp, #-60]
	addmi	r5, r5, r3
.L754:
	ldr	r3, [fp, #-64]
	sub	r2, fp, #48
	ldr	r1, [fp, #-56]
	mov	r0, r7
	cmp	r3, r5
	str	r2, [sp]
	add	r4, r4, #1
	mov	r2, r10
	ldrlt	r3, [fp, #-60]
	movge	r3, r5
	rsblt	r3, r3, r5
	bl	ReorderSTList
	cmp	r4, r9
	bne	.L757
.L747:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L753:
	add	r3, r3, #1
	add	r5, r5, r3
	ldr	r3, [fp, #-60]
	cmp	r3, r5
	rsble	r5, r3, r5
	b	.L754
.L748:
	ldr	r1, [r2, #220]
	mov	r4, #2208
	ldr	r5, [r3, #1304]
	mov	lr, #4000
	ldr	r2, [r2, #228]
	mov	r0, #1
	ldr	r3, [r3, #1300]
	mla	r1, r4, r1, r5
	str	r2, [fp, #-64]
	ldr	r2, [r1, #28]
	mla	r3, lr, r2, r3
	ldr	r3, [r3, #2196]
	add	r3, r3, #4
	mov	r3, r0, asl r3
	str	r3, [fp, #-60]
	b	.L758
	.fnend
	.size	ReorderRefPiclist, .-ReorderRefPiclist
	.align	2
	.global	ReorderListX
	.type	ReorderListX, %function
ReorderListX:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #16
	sub	sp, sp, #16
	push	{lr}
	bl	__gnu_mcount_nc
	add	r4, r0, #20480
	mov	r5, r0
	ldrb	r3, [r4, #208]
	cmp	r3, #2
	beq	.L766
	add	r6, r0, #16384
	ldrb	r2, [r6, #3512]
	cmp	r2, #0
	bne	.L778
.L769:
	cmp	r3, #1
	ldr	r3, [r4, #264]
	add	r3, r3, #1
	str	r3, [r4, #252]
	bne	.L766
	ldrb	r3, [r6, #3513]
	cmp	r3, #0
	bne	.L779
.L771:
	ldr	r3, [r4, #268]
	add	r3, r3, #1
	str	r3, [r4, #256]
.L766:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L778:
	add	r7, r0, #20224
	add	lr, r0, #19968
	add	ip, r0, #19712
	add	r1, r0, #26880
	ldr	r3, [r4, #264]
	add	lr, lr, #196
	add	ip, ip, #188
	add	r7, r7, #204
	stmia	sp, {ip, lr}
	add	r2, r4, #252
	str	r7, [sp, #8]
	add	r1, r1, #252
	bl	ReorderRefPiclist
	ldrb	r3, [r4, #208]
	b	.L769
.L779:
	add	ip, r5, #20480
	add	r0, r5, #20224
	add	r2, r5, #19968
	add	r1, r5, #27136
	ldr	r3, [r4, #268]
	add	ip, ip, #76
	add	r0, r0, #72
	add	r2, r2, #64
	stmib	sp, {r0, ip}
	add	r1, r1, #128
	str	r2, [sp]
	mov	r0, r5
	add	r2, r5, #20736
	bl	ReorderRefPiclist
	b	.L771
	.fnend
	.size	ReorderListX, .-ReorderListX
	.align	2
	.global	GenPiclistfromFrmlist
	.type	GenPiclistfromFrmlist, %function
GenPiclistfromFrmlist:
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
	ldr	lr, .L843
	mov	r7, r1
	ldr	ip, .L843+4
	movcc	r4, r2
	movcs	r4, #31
	cmp	r6, #0
	str	r3, [fp, #-52]
	movne	r6, lr
	moveq	r6, ip
	cmp	r0, #1
	moveq	r5, #0
	moveq	r10, r5
	beq	.L783
	cmp	r0, #2
	moveq	r5, #0
	moveq	r10, r5
	bne	.L791
.L792:
	cmp	r10, r4
	movcs	r3, #0
	movcc	r3, #1
	cmp	r5, r4
	str	r3, [fp, #-48]
	movcs	r2, #0
	movcc	r2, #1
	orrs	r3, r2, r3
	beq	.L791
	cmp	r2, #0
	beq	.L797
	add	r8, r7, r5, lsl #2
	b	.L796
.L793:
	add	r5, r5, #1
	cmp	r4, r5
	bls	.L797
.L796:
	mov	r9, r8
	ldr	r0, [r8], #4
	ldrb	ip, [r0, #1]
	tst	ip, #2
	beq	.L793
	add	r0, r0, #716
	blx	r6
	cmp	r0, #0
	beq	.L793
	ldr	r3, [fp, #4]
	add	r5, r5, #1
	ldr	r2, [r9]
	ldr	r0, [r3]
	add	r2, r2, #716
	ldr	r3, [fp, #-52]
	str	r2, [r3, r0, asl #2]
	ldr	r3, [fp, #4]
	ldr	r2, [r3]
	add	r2, r2, #1
	str	r2, [r3]
.L797:
	ldr	r3, [fp, #-48]
	cmp	r3, #0
	addne	r8, r7, r10, lsl #2
	bne	.L799
	b	.L792
.L798:
	add	r10, r10, #1
	cmp	r4, r10
	bls	.L792
.L799:
	mov	r9, r8
	ldr	r0, [r8], #4
	ldrb	r2, [r0, #1]
	tst	r2, #1
	beq	.L798
	add	r0, r0, #680
	blx	r6
	cmp	r0, #0
	beq	.L798
	ldr	r3, [fp, #4]
	add	r10, r10, #1
	ldr	r2, [r9]
	ldr	r0, [r3]
	add	r2, r2, #680
	ldr	r3, [fp, #-52]
	str	r2, [r3, r0, asl #2]
	ldr	r3, [fp, #4]
	ldr	r2, [r3]
	add	r2, r2, #1
	str	r2, [r3]
	b	.L792
.L842:
	add	r0, r0, #680
	blx	r6
	cmp	r0, #0
	beq	.L784
	ldr	r3, [fp, #4]
	add	r10, r10, #1
	ldr	r2, [r8]
	ldr	r0, [r3]
	add	r2, r2, #680
	ldr	r3, [fp, #-52]
	str	r2, [r3, r0, asl #2]
	ldr	r3, [fp, #4]
	ldr	r2, [r3]
	add	r2, r2, #1
	str	r2, [r3]
.L788:
	ldr	r3, [fp, #-48]
	cmp	r3, #0
	addne	r8, r7, r5, lsl #2
	bne	.L790
	b	.L783
.L789:
	add	r5, r5, #1
	cmp	r4, r5
	bls	.L783
.L790:
	mov	r9, r8
	ldr	r0, [r8], #4
	ldrb	r2, [r0, #1]
	tst	r2, #2
	beq	.L789
	add	r0, r0, #716
	blx	r6
	cmp	r0, #0
	beq	.L789
	ldr	r3, [fp, #4]
	add	r5, r5, #1
	ldr	r2, [r9]
	ldr	r0, [r3]
	add	r2, r2, #716
	ldr	r3, [fp, #-52]
	str	r2, [r3, r0, asl #2]
	ldr	r3, [fp, #4]
	ldr	r2, [r3]
	add	r2, r2, #1
	str	r2, [r3]
.L783:
	cmp	r10, r4
	movcs	r2, #0
	movcc	r2, #1
	cmp	r5, r4
	movcs	r3, #0
	movcc	r3, #1
	str	r3, [fp, #-48]
	orrs	r3, r3, r2
	beq	.L791
	cmp	r2, #0
	beq	.L788
	add	r9, r7, r10, lsl #2
	b	.L787
.L784:
	add	r10, r10, #1
	cmp	r4, r10
	bls	.L788
.L787:
	mov	r8, r9
	ldr	r0, [r9], #4
	ldrb	ip, [r0, #1]
	tst	ip, #1
	beq	.L784
	b	.L842
.L791:
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L844:
	.align	2
.L843:
	.word	IsLTRefFlg
	.word	IsSTRefFlg
	.fnend
	.size	GenPiclistfromFrmlist, .-GenPiclistfromFrmlist
	.align	2
	.global	InitListX
	.type	InitListX, %function
InitListX:
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
	add	r6, r0, #20480
	mov	r4, r0
	add	r8, r0, #57344
	ldrb	r3, [r6, #208]
	cmp	r3, #0
	bne	.L846
	ldrb	r7, [r8, #459]
	cmp	r7, #0
	bne	.L970
	add	r3, r0, #24576
	str	r3, [fp, #-240]
	ldr	ip, [r3, #2152]
	cmp	ip, #0
	beq	.L913
	add	r1, r0, #26368
	mov	r3, r7
	add	r1, r1, #220
	b	.L852
.L851:
	cmp	r3, ip
	beq	.L850
.L852:
	ldr	r2, [r1, #4]!
	add	r3, r3, #1
	ldrb	r0, [r2, #2]
	cmp	r0, #3
	bne	.L851
	ldr	r0, [r2, #644]
	bic	r0, r0, #-16777216
	bic	r0, r0, #255
	cmp	r0, #65536
	bne	.L851
	add	r0, r7, #6720
	cmp	r3, ip
	add	r0, r0, #62
	add	r2, r2, #644
	add	r7, r7, #1
	add	r0, r4, r0, lsl #2
	str	r2, [r0, #4]
	bne	.L852
.L850:
	add	r0, r4, #26880
	ldr	r3, .L978
	mov	r1, r7
	add	r0, r0, #252
	mov	r2, #4
	bl	qsort
	ldr	r3, [fp, #-240]
	str	r7, [r6, #252]
	ldr	r1, [r3, #2156]
	cmp	r1, #0
	beq	.L914
	add	r0, r4, #26624
	mov	r5, r7
	add	r0, r0, #28
	mov	r3, #0
	b	.L855
.L854:
	cmp	r3, r1
	beq	.L971
.L855:
	ldr	r2, [r0, #4]!
	add	r3, r3, #1
	ldrb	ip, [r2, #2]
	cmp	ip, #3
	bne	.L854
	ldr	ip, [r2, #644]
	bic	ip, ip, #-16777216
	bic	ip, ip, #255
	cmp	ip, #256
	bne	.L854
	add	ip, r5, #6720
	cmp	r3, r1
	add	ip, ip, #62
	add	r2, r2, #644
	add	r5, r5, #1
	add	ip, r4, ip, lsl #2
	str	r2, [ip, #4]
	bne	.L855
.L971:
	rsb	r1, r7, r5
.L853:
	add	r0, r4, r7, lsl #2
	ldr	r3, .L978+4
	add	r0, r0, #26880
	mov	r2, #4
	add	r0, r0, #252
	bl	qsort
	mov	r2, r5
	cmp	r2, #0
	mov	r3, #0
	str	r5, [r6, #252]
	str	r3, [r6, #256]
	beq	.L972
.L861:
	ldr	r0, [r6, #264]
	ldr	r1, [r6, #268]
	add	r0, r0, #1
	cmp	r2, r0
	add	r1, r1, #1
	movcs	r2, r0
	cmp	r3, r1
	str	r2, [r6, #252]
	movcs	r3, r1
	cmp	r2, #32
	str	r3, [r6, #256]
	bhi	.L905
	add	r2, r2, #6720
	add	r1, r4, #27136
	add	r2, r2, #62
	add	r1, r1, #124
	mov	r0, #0
	add	r2, r4, r2, lsl #2
.L904:
	str	r0, [r2, #4]!
	cmp	r2, r1
	bne	.L904
.L905:
	cmp	r3, #32
	bhi	.L903
	add	r3, r3, #6784
	add	r1, r4, #27392
	add	r3, r3, #31
	mov	r2, #0
	add	r4, r4, r3, lsl #2
.L906:
	str	r2, [r4, #4]!
	cmp	r4, r1
	bne	.L906
.L903:
	mov	r0, #0
.L956:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L846:
	ldrb	r5, [r8, #459]
	add	r3, r0, #24576
	str	r3, [fp, #-240]
	cmp	r5, #0
	beq	.L867
	ldr	ip, [r3, #2152]
	cmp	ip, #0
	beq	.L973
	add	r9, r0, #26368
	mov	r5, #0
	add	r9, r9, #220
	mov	r3, r5
	mov	r1, r9
.L886:
	ldr	r2, [r1, #4]!
	add	r3, r3, #1
	ldrb	r0, [r2, #1]
	cmp	r0, #0
	beq	.L885
	sub	r0, fp, #44
	ldr	lr, [r8, #1084]
	add	r7, r0, r5, lsl #2
	ldr	r0, [r2, #616]
	cmp	lr, r0
	strge	r2, [r7, #-192]
	addge	r5, r5, #1
.L885:
	cmp	r3, ip
	bne	.L886
	sub	r10, fp, #236
	ldr	r3, .L978+8
	mov	r2, #4
	mov	r1, r5
	mov	r0, r10
	bl	qsort
	ldr	r3, [fp, #-240]
	ldr	r7, [r3, #2152]
	cmp	r7, #0
	beq	.L967
.L911:
	mov	r3, r9
	mov	r2, #0
	mov	r9, r5
.L889:
	ldr	r1, [r3, #4]!
	add	r2, r2, #1
	ldrb	r0, [r1, #1]
	cmp	r0, #0
	beq	.L888
	sub	r0, fp, #44
	ldr	ip, [r8, #1084]
	add	lr, r0, r9, lsl #2
	ldr	r0, [r1, #616]
	cmp	ip, r0
	strlt	r1, [lr, #-192]
	addlt	r9, r9, #1
.L888:
	cmp	r2, r7
	bne	.L889
	rsb	r7, r5, r9
	mov	r3, r5, asl #2
	add	r0, r10, r3
	str	r3, [fp, #-244]
	mov	r1, r7
	ldr	r3, .L978+12
	mov	r2, #4
	bl	qsort
	cmp	r5, #0
	subeq	ip, fp, #172
	beq	.L890
.L908:
	sub	ip, fp, #172
	mov	r2, r10
	add	r7, ip, r7, lsl #2
	mov	r3, #0
.L891:
	add	r3, r3, #1
	ldr	r1, [r2], #4
	cmp	r3, r5
	str	r1, [r7], #4
	bcc	.L891
.L890:
	cmp	r9, r5
	bls	.L892
	ldr	r3, [fp, #-244]
	add	r2, r10, r3
	mov	r3, ip
.L893:
	add	r5, r5, #1
	ldr	r1, [r2], #4
	cmp	r5, r9
	str	r1, [r3], #4
	bne	.L893
.L892:
	add	r2, r4, #20480
	add	r3, r4, #26880
	add	r2, r2, #252
	mov	r5, #0
	add	r3, r3, #252
	str	r5, [r6, #252]
	str	r5, [r6, #256]
	mov	r1, r10
	ldrb	r0, [r8, #459]
	add	r10, r4, #27136
	str	ip, [fp, #-252]
	mov	ip, r2
	str	r2, [fp, #-248]
	mov	r2, r9
	str	ip, [sp]
	add	r10, r10, #128
	str	r5, [sp, #4]
	str	r3, [fp, #-244]
	bl	GenPiclistfromFrmlist
	ldr	ip, [fp, #-252]
	mov	r2, r9
	ldrb	r0, [r8, #459]
	mov	r3, r10
	str	r5, [sp, #4]
	mov	r1, ip
	add	ip, r4, #20736
	str	ip, [sp]
	str	ip, [fp, #-252]
	bl	GenPiclistfromFrmlist
	ldr	r3, [fp, #-240]
	ldr	r7, [r3, #2156]
	cmp	r7, r5
	subeq	r9, fp, #108
	beq	.L894
	add	r3, r4, #26624
	sub	r9, fp, #108
	add	r3, r3, #28
	mov	r2, r9
.L895:
	add	r5, r5, #1
	ldr	r1, [r3, #4]!
	cmp	r5, r7
	str	r1, [r2], #4
	bne	.L895
.L894:
	ldr	r3, .L978+16
	mov	r2, #4
	mov	r1, r7
	mov	r0, r9
	bl	qsort
	ldr	r3, [fp, #-248]
	ldrb	r0, [r8, #459]
	mov	r5, #1
	mov	r2, r7
	mov	r1, r9
	str	r3, [sp]
	str	r5, [sp, #4]
	ldr	r3, [fp, #-244]
	bl	GenPiclistfromFrmlist
	ldr	r2, [fp, #-252]
	ldrb	r0, [r8, #459]
	mov	r3, r10
	mov	r1, r9
	str	r5, [sp, #4]
	str	r2, [sp]
	mov	r2, r7
	bl	GenPiclistfromFrmlist
	ldr	r2, [r6, #252]
	ldr	r3, [r6, #256]
	rsb	r1, r3, r2
	clz	r1, r1
	mov	r1, r1, lsr #5
.L884:
	cmp	r2, #1
	movls	r1, #0
	andhi	r1, r1, #1
	cmp	r1, #0
	beq	.L896
	cmp	r2, #0
	ldr	r1, [fp, #-240]
	beq	.L897
	ldr	r7, [r1, #2556]
	ldr	r1, [r1, #2688]
	cmp	r7, r1
	bne	.L896
	add	r0, r4, #27136
	ldr	ip, [fp, #-244]
	add	r0, r0, #128
	mov	r1, #0
	b	.L898
.L899:
	ldr	r5, [ip, #4]!
	ldr	lr, [r0, #4]!
	cmp	r5, lr
	bne	.L896
.L898:
	add	r1, r1, #1
	cmp	r1, r2
	bne	.L899
.L900:
	ldr	r0, [fp, #-240]
	ldr	r1, [r0, #2692]
	str	r7, [r0, #2692]
	str	r1, [r0, #2688]
.L896:
	orrs	r1, r2, r3
	bne	.L861
	ldr	r1, .L978+20
.L962:
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	bl	ClearCurrSlice
	mvn	r0, #0
	b	.L956
.L867:
	ldr	r10, [r3, #2152]
	cmp	r10, #0
	beq	.L870
	add	r9, r0, #26368
	mov	r3, r5
	add	r9, r9, #220
	mov	r1, r9
	b	.L872
.L871:
	cmp	r3, r10
	beq	.L974
.L872:
	ldr	r2, [r1, #4]!
	add	r3, r3, #1
	ldrb	r0, [r2, #2]
	cmp	r0, #3
	bne	.L871
	add	r0, r5, #6720
	ldr	ip, [r2, #656]
	add	r0, r0, #62
	ldr	lr, [r8, #1088]
	add	r2, r2, #644
	add	r0, r4, r0, lsl #2
	cmp	lr, ip
	addge	r5, r5, #1
	strge	r2, [r0, #4]
	cmp	r3, r10
	bne	.L872
.L974:
	add	r3, r4, #26880
	mov	r1, r5
	mov	r2, r3
	add	r2, r2, #252
	ldr	r3, .L978+24
	mov	r0, r2
	str	r2, [fp, #-244]
	mov	r2, #4
	bl	qsort
	ldr	r3, [fp, #-240]
	ldr	r7, [r3, #2152]
	cmp	r7, #0
	beq	.L966
.L909:
	mov	r3, r9
	mov	r10, r5
	mov	r2, #0
	b	.L875
.L874:
	cmp	r2, r7
	beq	.L975
.L875:
	ldr	r1, [r3, #4]!
	add	r2, r2, #1
	ldrb	r0, [r1, #2]
	cmp	r0, #3
	bne	.L874
	add	r0, r10, #6720
	ldr	ip, [r1, #656]
	add	r0, r0, #62
	ldr	lr, [r8, #1088]
	add	r1, r1, #644
	add	r0, r4, r0, lsl #2
	cmp	lr, ip
	addlt	r10, r10, #1
	strlt	r1, [r0, #4]
	cmp	r2, r7
	bne	.L875
.L975:
	add	r8, r5, #6720
	rsb	r7, r5, r10
	add	r8, r8, #62
	mov	r2, #4
	ldr	r3, .L978+28
	mov	r1, r7
	add	r0, r4, r8, lsl #2
	add	r9, r4, r10, lsl #2
	add	r0, r0, r2
	add	r9, r9, #26880
	bl	qsort
	cmp	r5, #0
	add	r9, r9, #252
	beq	.L877
.L907:
	add	r7, r7, #6784
	add	r2, r4, #26880
	add	r7, r7, #31
	add	r2, r2, #248
	mov	r3, #0
	add	r7, r4, r7, lsl #2
.L878:
	add	r3, r3, #1
	ldr	r1, [r2, #4]!
	cmp	r3, r5
	str	r1, [r7, #4]!
	bcc	.L878
.L877:
	cmp	r10, r5
	bls	.L879
	add	r3, r4, #27136
	add	r8, r4, r8, lsl #2
	add	r3, r3, #124
.L880:
	add	r5, r5, #1
	ldr	r2, [r8, #4]!
	cmp	r5, r10
	str	r2, [r3, #4]!
	bne	.L880
.L879:
	ldr	r3, [fp, #-240]
	str	r10, [r6, #256]
	str	r10, [r6, #252]
	ldr	r1, [r3, #2156]
	cmp	r1, #0
	beq	.L916
	add	r0, r4, #26624
	mov	r5, r10
	add	r0, r0, #28
	mov	r3, #0
	b	.L883
.L882:
	cmp	r3, r1
	beq	.L976
.L883:
	ldr	r2, [r0, #4]!
	add	r3, r3, #1
	ldrb	ip, [r2, #1]
	cmp	ip, #3
	bne	.L882
	ldrb	ip, [r2, #645]
	cmp	ip, #1
	bne	.L882
	add	ip, r4, r5, lsl #2
	cmp	r3, r1
	add	ip, ip, #24576
	add	r2, r2, #644
	add	r5, r5, #1
	str	r2, [ip, #2556]
	str	r2, [ip, #2688]
	bne	.L883
.L976:
	rsb	r1, r10, r5
.L881:
	mov	r0, r9
	ldr	r3, .L978+4
	mov	r2, #4
	bl	qsort
	ldr	r0, [r6, #252]
	ldr	r3, .L978+4
	mov	r2, #4
	rsb	r1, r0, r5
	add	r0, r4, r0, lsl #2
	add	r0, r0, #27136
	add	r0, r0, #128
	bl	qsort
	mov	r3, r5
	str	r5, [r6, #256]
	mov	r2, r5
	str	r5, [r6, #252]
	mov	r1, #1
	b	.L884
.L970:
	add	r2, r0, #24576
	str	r2, [fp, #-240]
	ldr	lr, [r2, #2152]
	cmp	lr, #0
	moveq	r7, lr
	beq	.L849
	add	r1, r0, #26368
	mov	r7, r3
	add	r1, r1, #220
.L858:
	ldr	r2, [r1, #4]!
	sub	r0, fp, #44
	add	ip, r0, r7, lsl #2
	add	r3, r3, #1
	ldrb	r0, [r2, #2]
	cmp	r0, #0
	strne	r2, [ip, #-192]
	addne	r7, r7, #1
	cmp	r3, lr
	bne	.L858
.L849:
	add	r10, r4, #26880
	mov	r1, r7
	ldr	r3, .L978+32
	mov	r2, #4
	sub	r0, fp, #236
	add	r10, r10, #252
	bl	qsort
	add	ip, r4, #20480
	add	ip, ip, #252
	mov	r5, #0
	mov	r2, r7
	str	r5, [r6, #252]
	mov	r3, r10
	ldrb	r0, [r8, #459]
	sub	r1, fp, #236
	str	ip, [sp]
	str	r5, [sp, #4]
	str	ip, [fp, #-244]
	bl	GenPiclistfromFrmlist
	ldr	r3, [fp, #-240]
	ldr	ip, [fp, #-244]
	ldr	r7, [r3, #2156]
	cmp	r7, r5
	subeq	r9, fp, #108
	beq	.L859
	add	r3, r4, #26624
	sub	r9, fp, #108
	add	r3, r3, #28
	mov	r2, r9
.L860:
	add	r5, r5, #1
	ldr	r1, [r3, #4]!
	cmp	r5, r7
	str	r1, [r2], #4
	bne	.L860
.L859:
	ldr	r3, .L978+16
	mov	r2, #4
	mov	r1, r7
	mov	r0, r9
	str	ip, [fp, #-244]
	bl	qsort
	ldr	ip, [fp, #-244]
	mov	r3, r10
	ldrb	r0, [r8, #459]
	mov	r2, r7
	mov	r1, r9
	str	ip, [sp]
	mov	ip, #1
	str	ip, [sp, #4]
	bl	GenPiclistfromFrmlist
	ldr	r2, [r6, #252]
	mov	r3, #0
	str	r3, [r6, #256]
	cmp	r2, #0
	bne	.L861
.L972:
	ldr	r3, [r4]
	ldr	r3, [r3, #12]
	cmp	r3, #2
	bne	.L862
	ldrb	r3, [r8, #459]
	cmp	r3, #0
	beq	.L977
	cmp	r3, #1
	ldr	r2, [fp, #-240]
	ldr	r3, [r8, #1064]
	addeq	r3, r3, #680
	addne	r3, r3, #716
	str	r3, [r2, #2556]
.L864:
	mov	r3, #0
	mov	r2, #1
	b	.L861
.L977:
	ldr	r2, [fp, #-240]
	ldr	r3, [r8, #1064]
	add	r3, r3, #644
	str	r3, [r2, #2556]
	b	.L864
.L897:
	ldr	r7, [r1, #2688]
	b	.L900
.L966:
	add	r8, r5, #6720
	mov	r2, #4
	add	r8, r8, #62
	ldr	r3, .L978+28
	mov	r1, r7
	add	r9, r4, r8, lsl #2
	add	r9, r9, r2
	mov	r0, r9
	bl	qsort
	subs	r10, r5, #0
	bne	.L907
	b	.L879
.L967:
	mov	r3, r5, asl #2
	mov	r1, r7
	str	r3, [fp, #-244]
	mov	r2, r3
	ldr	r3, .L978+12
	add	r0, r10, r2
	mov	r2, #4
	bl	qsort
	subs	r9, r5, #0
	bne	.L908
.L963:
	sub	ip, fp, #172
	b	.L892
.L913:
	mov	r7, ip
	b	.L850
.L973:
	sub	r10, fp, #236
	ldr	r3, .L978+8
	mov	r1, ip
	mov	r2, #4
	mov	r0, r10
	str	ip, [fp, #-244]
	bl	qsort
	ldr	r3, [fp, #-240]
	ldr	ip, [fp, #-244]
	ldr	r7, [r3, #2152]
	cmp	r7, #0
	addne	r9, r4, #26368
	movne	r5, ip
	addne	r9, r9, #220
	bne	.L911
	ldr	r3, .L978+12
	mov	r2, #4
	mov	r1, r7
	mov	r0, r10
	mov	r9, r7
	bl	qsort
	b	.L963
.L870:
	add	r3, r0, #26880
	mov	r1, r10
	mov	r2, r3
	add	r2, r2, #252
	ldr	r3, .L978+24
	mov	r0, r2
	str	r2, [fp, #-244]
	mov	r2, #4
	bl	qsort
	ldr	r3, [fp, #-240]
	ldr	r7, [r3, #2152]
	cmp	r7, #0
	addne	r9, r4, #26368
	movne	r5, r10
	addne	r9, r9, #220
	bne	.L909
	ldr	r9, [fp, #-244]
	mov	r2, #4
	ldr	r3, .L978+28
	mov	r1, r7
	mov	r10, r7
	mov	r0, r9
	bl	qsort
	b	.L879
.L914:
	mov	r5, r7
	b	.L853
.L916:
	mov	r5, r10
	b	.L881
.L862:
	ldr	r1, .L978+36
	b	.L962
.L979:
	.align	2
.L978:
	.word	compare_pic_by_pic_num_desc
	.word	compare_pic_by_lt_pic_num_asc
	.word	compare_fs_by_poc_desc
	.word	compare_fs_by_poc_asc
	.word	compare_fs_by_lt_pic_idx_asc
	.word	.LC35
	.word	compare_pic_by_poc_desc
	.word	compare_pic_by_poc_asc
	.word	compare_fs_by_frame_num_desc
	.word	.LC34
	.fnend
	.size	InitListX, .-InitListX
	.align	2
	.global	DumpList
	.type	DumpList, %function
DumpList:
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
	ldr	r3, .L985
	ldr	r3, [r3]
	tst	r3, #8192
	ldmeqfd	sp, {fp, sp, pc}
	bl	DumpList.part.5
	ldmfd	sp, {fp, sp, pc}
.L986:
	.align	2
.L985:
	.word	g_PrintEnable
	.fnend
	.size	DumpList, .-DumpList
	.align	2
	.global	FindNearestPOCPicId
	.type	FindNearestPOCPicId, %function
FindNearestPOCPicId:
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
	add	r3, r0, #24576
	ldr	r4, [r3, #2148]
	cmp	r4, #0
	beq	.L992
	ldr	r3, [r3, #1952]
	add	r2, r0, #57344
	ldr	r5, [r2, #1084]
	ldr	lr, [r3, #616]
	rsb	lr, lr, r5
	cmp	lr, #0
	rsblt	lr, lr, #0
	cmp	r4, #1
	bls	.L993
	add	r1, r0, #26368
	mov	r2, #1
	add	r1, r1, #160
	mov	r0, #0
.L991:
	ldr	ip, [r1, #4]!
	add	r2, r2, #1
	ldr	r3, [ip, #616]
	rsb	r3, r3, r5
	cmp	r3, #0
	rsblt	r3, r3, #0
	cmp	r3, lr
	ldrlt	r0, [ip, #164]
	movlt	lr, r3
	cmp	r2, r4
	bne	.L991
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L993:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L992:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	FindNearestPOCPicId, .-FindNearestPOCPicId
	.align	2
	.global	FindMinRefIdx
	.type	FindMinRefIdx, %function
FindMinRefIdx:
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
	add	r3, r0, #20480
	ldrb	r2, [r3, #208]
	cmp	r2, #2
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	add	r2, r0, #57344
	add	r5, r0, #26880
	ldrb	ip, [r2, #459]
	cmp	ip, #0
	bne	.L1025
	ldr	lr, [r3, #252]
	mov	r4, r5
	mov	r6, r5
	mov	r7, ip
	cmp	lr, #0
	add	r5, r5, #124
	add	r4, r4, #128
	add	r6, r6, #248
	beq	.L1003
.L1027:
	mov	r2, r6
	mov	r0, #32
	mov	r3, #0
	b	.L1001
.L1000:
	add	r3, r3, #1
	cmp	r3, lr
	beq	.L1026
.L1001:
	ldr	r1, [r2, #4]!
	ldr	r1, [r1, #32]
	ldr	r1, [r1, #640]
	cmp	r1, ip
	bne	.L1000
	cmp	r0, r3
	movcs	r0, r3
	add	r3, r3, #1
	cmp	r3, lr
	str	r0, [r4, #-4]
	str	r0, [r5, #4]
	bne	.L1001
.L1026:
	cmp	r0, #31
	bhi	.L1003
.L1002:
	add	ip, ip, #1
	add	r5, r5, #8
	cmp	ip, #16
	add	r4, r4, #8
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	cmp	lr, #0
	bne	.L1027
.L1003:
	str	r7, [r4, #-4]
	str	r7, [r5, #4]
	b	.L1002
.L1025:
	ldr	r4, [r3, #252]
	mov	ip, #0
	mov	r6, r5
	mov	r7, ip
	cmp	r4, #0
	add	r5, r5, #124
	add	r6, r6, #248
	beq	.L1007
.L1029:
	mov	r1, r6
	mov	lr, #32
	mov	r2, #0
	b	.L1005
.L1004:
	add	r2, r2, #1
	cmp	r2, r4
	beq	.L1028
.L1005:
	ldr	r3, [r1, #4]!
	ldr	r8, [r3, #32]
	ldrb	r0, [r3]
	ldr	r3, [r8, #640]
	mov	r3, r3, asl #1
	cmp	r0, #2
	orreq	r3, r3, #1
	cmp	r3, ip
	bne	.L1004
	cmp	lr, r2
	movcs	lr, r2
	add	r2, r2, #1
	cmp	r2, r4
	str	lr, [r5]
	bne	.L1005
.L1028:
	cmp	lr, #31
	bhi	.L1007
.L1006:
	add	ip, ip, #1
	add	r5, r5, #4
	cmp	ip, #32
	ldmeqfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	cmp	r4, #0
	bne	.L1029
.L1007:
	str	r7, [r5]
	b	.L1006
	.fnend
	.size	FindMinRefIdx, .-FindMinRefIdx
	.align	2
	.global	DecList
	.type	DecList, %function
DecList:
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
	bl	FindNearestPOCPicId
	add	r5, r6, #20480
	mvn	r4, #0
	ldrb	r3, [r5, #208]
	str	r4, [r5, #1836]
	cmp	r3, #2
	str	r0, [r5, #1840]
	beq	.L1043
	mov	r0, r6
	bl	InitListX
	cmp	r0, #0
	bne	.L1044
	ldr	r4, .L1047
	mov	r0, #13
	ldr	r1, .L1047+4
	bl	dprint_vfmw
	ldr	r3, [r4]
	tst	r3, #8192
	bne	.L1045
.L1034:
	mov	r0, r6
	bl	ReorderListX
	mov	r0, r6
	bl	RepairList
	cmp	r0, #0
	bne	.L1036
	mov	r0, r6
	bl	FindMinRefIdx
	add	r3, r6, #24576
	mov	r0, #13
	ldr	r1, .L1047+8
	ldr	r3, [r3, #2556]
	cmp	r3, #0
	ldrne	r3, [r3, #32]
	mvneq	r3, #0
	ldrne	r3, [r3, #164]
	str	r3, [r5, #1836]
	bl	dprint_vfmw
	ldr	r4, [r4]
	ands	r4, r4, #8192
	bne	.L1046
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1046:
	mov	r0, r6
	bl	DumpList.part.5
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1043:
	mov	r0, #0
	str	r0, [r5, #252]
	str	r0, [r5, #256]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1045:
	mov	r0, r6
	bl	DumpList.part.5
	b	.L1034
.L1036:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1044:
	ldr	r1, .L1047+12
	mov	r0, #13
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1048:
	.align	2
.L1047:
	.word	g_PrintEnable
	.word	.LC37
	.word	.LC38
	.word	.LC36
	.fnend
	.size	DecList, .-DecList
	.align	2
	.global	NoPicOut
	.type	NoPicOut, %function
NoPicOut:
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
	add	r4, r0, #57344
	ldr	ip, [r4, #2476]
	cmp	ip, #0
	addne	r3, r0, #27904
	movne	r2, #0
	addne	r3, r3, #116
	movne	lr, r2
	bne	.L1055
	b	.L1056
.L1064:
	ldrb	r1, [r3, #-616]
	cmp	r1, #1
	beq	.L1053
	cmp	r2, ip
	add	r3, r3, #760
	beq	.L1056
.L1055:
	ldr	r1, [r3]
	add	r2, r2, #1
	cmp	r1, #1
	bne	.L1064
.L1053:
	cmp	r2, ip
	strb	lr, [r3, #-619]
	strb	lr, [r3, #-618]
	add	r3, r3, #760
	bne	.L1055
.L1056:
	ldr	r2, [r4, #2480]
	cmp	r2, #0
	beq	.L1065
	add	r0, r0, #59648
	mov	r3, #0
	add	r0, r0, #100
	mov	r1, r3
.L1057:
	add	r3, r3, #1
	str	r1, [r0, #4]!
	cmp	r3, r2
	bne	.L1057
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1065:
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	NoPicOut, .-NoPicOut
	.align	2
	.global	GetBackPicFromVOQueue
	.type	GetBackPicFromVOQueue, %function
GetBackPicFromVOQueue:
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
	add	r10, r0, #57344
	mov	r8, r0
	ldr	r0, [r10, #3888]
	bl	FSP_GetFspType
	cmp	r0, #0
	beq	.L1083
.L1067:
	ldr	r3, [r10, #2476]
	cmp	r3, #0
	beq	.L1074
	add	r5, r8, #27904
	mov	r6, #0
	add	r5, r5, #56
	mov	r7, #0
	mov	r9, #0
.L1073:
	sub	r4, r5, #32
	mov	r3, #0
	strb	r3, [r5, #-559]
	strb	r3, [r5, #-558]
.L1072:
	ldrd	r2, [r4, #8]!
	orrs	r1, r2, r3
	bne	.L1084
.L1071:
	cmp	r4, r5
	bne	.L1072
	ldr	r3, [r10, #2476]
	add	r9, r9, #1
	add	r5, r5, #760
	cmp	r3, r9
	bhi	.L1073
.L1074:
	ldr	r2, [r10, #2480]
	cmp	r2, #0
	beq	.L1085
	add	r8, r8, #59648
	mov	r3, #0
	add	r8, r8, #100
	mov	r1, r3
.L1075:
	add	r3, r3, #1
	str	r1, [r8, #4]!
	cmp	r3, r2
	bne	.L1075
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1084:
	mov	r1, r2
	ldr	r0, [r10, #3888]
	bl	FreeUsdByDec
	strd	r6, [r4]
	b	.L1071
.L1083:
	add	r0, r8, #8
	bl	ResetVoQueue
	b	.L1067
.L1085:
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	.fnend
	.size	GetBackPicFromVOQueue, .-GetBackPicFromVOQueue
	.align	2
	.global	wait_vo
	.type	wait_vo, %function
wait_vo:
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
	.size	wait_vo, .-wait_vo
	.align	2
	.global	GetReRangeFlag
	.type	GetReRangeFlag, %function
GetReRangeFlag:
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
	add	r7, r0, #12288
	add	r3, r0, #20480
	mov	r5, r0
	mov	ip, #2208
	ldr	r0, [r7, #1304]
	mov	r4, #4000
	ldr	r3, [r3, #220]
	mov	r6, r1
	ldr	r2, [r7, #1300]
	ldr	lr, [r7, #1276]
	mla	r3, ip, r3, r0
	ldr	r0, [r7, #1280]
	ldr	r3, [r3, #28]
	mla	r4, r4, r3, r2
	ldrb	r3, [r4, #18]
	ldr	r1, [r4, #3252]
	rsb	r3, r3, #2
	ldr	r2, [r4, #3248]
	mla	r3, r1, r3, r3
	add	r2, r2, #1
	cmp	r2, lr
	cmpeq	r3, r0
	movne	r1, #1
	moveq	r1, #0
	bne	.L1088
	add	r8, r5, #24576
	ldr	ip, [r4, #3272]
	ldr	r8, [r8, #2144]
	add	r8, r8, #1
	cmp	ip, r8
	movls	r3, r1
	movls	r0, r3
	bls	.L1089
.L1088:
	ldr	r1, .L1093
	ldr	ip, [r1]
	cmp	ip, #0
	beq	.L1092
	add	r1, r5, #57344
	mov	lr, lr, asl #4
	mov	r0, r0, asl #4
	mov	r2, r2, asl #4
	strh	r0, [fp, #-42]
	mov	r3, r3, asl #4
	strh	r2, [fp, #-40]
	sub	r2, fp, #44
	strh	r3, [fp, #-38]
	mov	r3, #8
	ldr	r0, [r1, #3888]
	mov	r1, #2
	strh	lr, [fp, #-44]
	blx	ip
	ldr	ip, [r4, #3272]
	mov	r3, #1
	mov	r0, r3
.L1089:
	add	r5, r5, #16384
	ldr	r2, [r4, #36]
	ldr	lr, [r7, #1344]
	ldr	r1, [r5, #484]
	cmp	lr, r2
	cmpeq	r1, ip
	movne	r2, #1
	moveq	r2, #0
	orr	r3, r2, r3
	str	r3, [r6]
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L1092:
	mov	r3, #1
	ldr	ip, [r4, #3272]
	mov	r0, r3
	b	.L1089
.L1094:
	.align	2
.L1093:
	.word	g_event_report
	.fnend
	.size	GetReRangeFlag, .-GetReRangeFlag
	.global	__aeabi_uidiv
	.global	__aeabi_uidivmod
	.align	2
	.global	DecPOC
	.type	DecPOC, %function
DecPOC:
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
	add	r2, r0, #12288
	add	r6, r0, #20480
	mov	r4, #2208
	ldr	r3, [r2, #1304]
	mov	r5, #4000
	ldr	r1, [r6, #220]
	mov	ip, #1
	ldr	lr, [r2, #1300]
	ldrb	r2, [r6, #211]
	mla	r3, r4, r1, r3
	sub	r2, r2, #5
	clz	r2, r2
	mov	r2, r2, lsr #5
	ldr	r3, [r3, #28]
	mla	r5, r5, r3, lr
	ldr	r1, [r5, #2200]
	ldr	r3, [r5, #2196]
	cmp	r1, ip
	ldr	lr, [r5, #2204]
	add	r3, r3, #4
	mov	r3, ip, asl r3
	beq	.L1097
	bcc	.L1098
	cmp	r1, #2
	ldmnefd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	cmp	r2, #0
	add	r4, r0, #16384
	bne	.L1153
	ldr	r1, [r4, #3444]
	cmp	r1, #0
	bne	.L1131
	ldr	r2, [r4, #3484]
	ldr	r0, [r4, #3480]
	ldr	r1, [r4, #3492]
	cmp	r2, r0
	addcc	r1, r1, r3
	strcc	r1, [r4, #3488]
	bcs	.L1133
.L1134:
	add	r3, r1, r2
	str	r3, [r4, #3476]
	ldr	r0, [r6, #240]
	mov	r3, r3, asl #1
	cmp	r0, #0
	subeq	r3, r3, #1
	str	r3, [r4, #3464]
	ldrb	r0, [r6, #209]
	cmp	r0, #0
	bne	.L1137
	str	r3, [r4, #3460]
	str	r3, [r4, #3456]
	str	r3, [r4, #3452]
.L1130:
	str	r2, [r4, #3480]
	str	r1, [r4, #3492]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1098:
	cmp	r2, #0
	add	lr, lr, #4
	add	r4, r0, #16384
	mov	ip, ip, asl lr
	bne	.L1104
	ldr	r3, [r4, #3444]
	cmp	r3, #0
	bne	.L1102
	ldr	lr, [r4, #3428]
	ldr	r1, [r4, #3432]
	mov	r2, lr
.L1103:
	ldr	r0, [r4, #3420]
	cmp	r0, r1
	bcs	.L1101
	rsb	r3, r0, r1
	cmp	r3, ip, lsr #1
	addcs	r2, r2, ip
	strcs	r2, [r4, #3436]
	bcc	.L1101
.L1105:
	ldrb	r3, [r6, #209]
	cmp	r3, #0
	bne	.L1107
.L1155:
	ldr	r3, [r4, #3424]
	add	r2, r2, r0
	str	r2, [r4, #3452]
	add	r3, r2, r3
	str	r3, [r4, #3456]
	cmp	r3, r2
	movge	r3, r2
	str	r3, [r4, #3464]
.L1108:
	ldr	r2, [r4, #3484]
	ldr	r1, [r4, #3480]
	str	r3, [r4, #3460]
	cmp	r2, r1
	strne	r2, [r4, #3480]
	ldr	r3, [r6, #240]
	cmp	r3, #0
	ldrne	r2, [r4, #3420]
	ldrne	r3, [r4, #3436]
	strne	r2, [r4, #3432]
	strne	r3, [r4, #3428]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1097:
	cmp	r2, #0
	add	r4, r0, #16384
	movne	r3, #0
	strne	r3, [r4, #3488]
	bne	.L1112
	ldr	r1, [r4, #3444]
	cmp	r1, #0
	beq	.L1113
	mov	r3, r2
	str	r2, [r4, #3492]
	str	r2, [r4, #3480]
.L1114:
	str	r3, [r4, #3488]
.L1112:
	ldr	r3, [r5, #2216]
	cmp	r3, #0
	beq	.L1116
	ldr	r3, [r4, #3484]
	ldr	r0, [r4, #3488]
	add	r0, r3, r0
	str	r0, [r4, #3476]
	ldr	r7, [r6, #240]
	cmp	r7, #0
	bne	.L1118
	cmp	r0, #0
	beq	.L1119
	sub	r0, r0, #1
	str	r0, [r4, #3476]
.L1118:
	mov	r3, #0
	str	r3, [r4, #3508]
	ldr	r1, [r5, #2216]
	cmp	r1, r3
	bgt	.L1139
	cmp	r0, #0
	beq	.L1122
.L1156:
	sub	r8, r0, #1
	mov	r0, r8
	bl	__aeabi_uidiv
	mov	r9, r0
	mov	r0, r8
	str	r9, [r4, #3500]
	ldr	r1, [r5, #2216]
	bl	__aeabi_uidivmod
	ldr	r0, [r4, #3508]
	mul	r0, r0, r9
	str	r0, [r4, #3504]
	cmp	r1, #0
	str	r1, [r4, #3496]
	blt	.L1123
	add	r2, r5, #2208
	mov	r3, #0
	add	r2, r2, #8
.L1124:
	add	r3, r3, #1
	ldr	ip, [r2, #4]!
	cmp	r1, r3
	add	r0, r0, ip
	str	r0, [r4, #3504]
	bge	.L1124
.L1123:
	cmp	r7, #0
	ldreq	r3, [r5, #2208]
	addeq	r0, r0, r3
	streq	r0, [r4, #3504]
	ldrb	r3, [r6, #209]
	cmp	r3, #0
	bne	.L1126
	ldr	r2, [r4, #3468]
	ldr	r1, [r4, #3472]
	add	r2, r0, r2
	str	r2, [r4, #3452]
	ldr	r3, [r5, #2212]
	add	r3, r2, r3
	add	r0, r3, r1
	str	r0, [r4, #3456]
	cmp	r0, r2
	movge	r0, r2
	str	r0, [r4, #3464]
.L1127:
	ldr	r2, [r4, #3484]
	ldr	r3, [r4, #3488]
	str	r0, [r4, #3460]
	str	r2, [r4, #3480]
	str	r3, [r4, #3492]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1102:
	ldr	lr, [r4, #3448]
	cmp	lr, #0
	beq	.L1154
.L1104:
	ldr	r0, [r4, #3420]
	mov	r3, #0
	mov	lr, r3
	mov	r2, r1
	str	r3, [r4, #3428]
	str	r3, [r4, #3432]
.L1101:
	cmp	r0, r1
	bls	.L1106
	rsb	r1, r1, r0
	cmp	r1, ip, lsr #1
	rsbhi	r2, ip, r2
	strhi	r2, [r4, #3436]
	bhi	.L1105
.L1106:
	str	lr, [r4, #3436]
	ldrb	r3, [r6, #209]
	cmp	r3, #0
	beq	.L1155
.L1107:
	ldrb	r3, [r6, #210]
	cmp	r3, #0
	add	r3, r2, r0
	streq	r3, [r4, #3452]
	strne	r3, [r4, #3456]
	str	r3, [r4, #3464]
	b	.L1108
.L1153:
	mov	r3, #0
	ldr	r2, [r4, #3484]
	mov	r1, r3
	str	r3, [r4, #3488]
	str	r3, [r4, #3456]
	str	r3, [r4, #3452]
	str	r3, [r4, #3460]
	str	r3, [r4, #3464]
	b	.L1130
.L1116:
	str	r3, [r4, #3476]
	ldr	r7, [r6, #240]
.L1119:
	mov	r0, #0
	str	r0, [r4, #3508]
	ldr	r3, [r5, #2216]
	cmp	r3, r0
	ble	.L1122
.L1139:
	add	ip, r5, #2208
	mov	r3, #0
	add	ip, ip, #8
	mov	r2, r3
.L1121:
	ldr	r1, [ip, #4]!
	add	r2, r2, #1
	add	r3, r3, r1
	str	r3, [r4, #3508]
	ldr	r1, [r5, #2216]
	cmp	r1, r2
	bgt	.L1121
	cmp	r0, #0
	bne	.L1156
.L1122:
	mov	r0, #0
	str	r0, [r4, #3504]
	b	.L1123
.L1126:
	ldrb	r3, [r6, #210]
	cmp	r3, #0
	ldrne	r2, [r5, #2212]
	ldreq	r3, [r4, #3468]
	ldrne	r3, [r4, #3468]
	addne	r0, r0, r2
	addeq	r0, r0, r3
	streq	r0, [r4, #3452]
	addne	r0, r0, r3
	strne	r0, [r4, #3456]
	str	r0, [r4, #3464]
	b	.L1127
.L1113:
	ldr	r1, [r4, #3484]
	ldr	r2, [r4, #3480]
	cmp	r1, r2
	bcs	.L1115
	ldr	r2, [r4, #3492]
	add	r3, r3, r2
	str	r3, [r4, #3488]
	b	.L1112
.L1137:
	ldrb	r0, [r6, #210]
	str	r3, [r4, #3460]
	cmp	r0, #0
	streq	r3, [r4, #3452]
	strne	r3, [r4, #3456]
	b	.L1130
.L1131:
	str	r2, [r4, #3480]
	mov	r1, r2
	str	r2, [r4, #3492]
	ldr	r2, [r4, #3484]
.L1133:
	str	r1, [r4, #3488]
	b	.L1134
.L1154:
	ldr	r3, [r4, #3452]
	mov	r2, r1
	str	lr, [r4, #3428]
	mov	r1, r3
	str	r3, [r4, #3432]
	b	.L1103
.L1115:
	ldr	r3, [r4, #3492]
	b	.L1114
	.fnend
	.size	DecPOC, .-DecPOC
	.align	2
	.global	CalcPicNum
	.type	CalcPicNum, %function
CalcPicNum:
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
	add	r2, r0, #12288
	add	r3, r0, #20480
	mov	r4, #2208
	ldr	r1, [r2, #1304]
	mov	lr, #4000
	ldr	ip, [r3, #220]
	add	r6, r0, #57344
	ldr	r3, [r2, #1300]
	mov	r7, #1
	ldrb	r2, [r6, #459]
	mla	r1, r4, ip, r1
	cmp	r2, #0
	ldr	r1, [r1, #28]
	mla	r3, lr, r1, r3
	ldr	r3, [r3, #2196]
	add	r3, r3, #4
	mov	r7, r7, asl r3
	add	r3, r0, #24576
	beq	.L1158
	sub	r5, r2, #1
	sub	r4, r2, #2
	ldr	r2, [r3, #2152]
	clz	r5, r5
	clz	r4, r4
	cmp	r2, #0
	mov	r5, r5, lsr #5
	addne	lr, r0, #26368
	mov	r4, r4, lsr #5
	movne	r1, #0
	addne	lr, lr, #220
	beq	.L1178
.L1177:
	ldr	ip, [lr, #4]!
	ldrb	r2, [ip, #2]
	cmp	r2, #0
	beq	.L1172
	ldr	r2, [ip, #604]
	ldr	r8, [r6, #1072]
	cmp	r2, r8
	rsbhi	r2, r7, r2
	str	r2, [ip, #608]
	ldr	r2, [lr]
	ldrb	ip, [r2, #2]
	tst	ip, #1
	beq	.L1175
	ldr	r8, [r2, #680]
	bic	r8, r8, #-16777216
	bic	r8, r8, #255
	cmp	r8, #65536
	ldreq	ip, [r2, #608]
	addeq	ip, r5, ip, lsl #1
	streq	ip, [r2, #688]
	ldreq	r2, [lr]
	ldreqb	ip, [r2, #2]
.L1175:
	tst	ip, #2
	beq	.L1172
	ldr	ip, [r2, #716]
	bic	ip, ip, #-16777216
	bic	ip, ip, #255
	cmp	ip, #65536
	ldreq	ip, [r2, #608]
	addeq	ip, r4, ip, lsl #1
	streq	ip, [r2, #724]
.L1172:
	ldr	r2, [r3, #2152]
	add	r1, r1, #1
	cmp	r2, r1
	bhi	.L1177
.L1178:
	ldr	r2, [r3, #2156]
	cmp	r2, #0
	beq	.L1202
	add	r0, r0, #26624
	mov	r2, #0
	add	r0, r0, #28
.L1183:
	ldr	ip, [r0, #4]!
	add	r2, r2, #1
	ldrb	r1, [ip, #2]
	cmp	r1, #0
	beq	.L1180
	tst	r1, #1
	beq	.L1181
	ldr	lr, [ip, #680]
	bic	lr, lr, #-16777216
	bic	lr, lr, #255
	cmp	lr, #256
	ldreq	r1, [ip, #612]
	addeq	r1, r5, r1, lsl #1
	streq	r1, [ip, #684]
	ldreq	ip, [r0]
	ldreqb	r1, [ip, #2]
.L1181:
	tst	r1, #2
	beq	.L1180
	ldr	r1, [ip, #716]
	bic	r1, r1, #-16777216
	bic	r1, r1, #255
	cmp	r1, #256
	ldreq	r1, [ip, #612]
	addeq	r1, r4, r1, lsl #1
	streq	r1, [ip, #720]
.L1180:
	ldr	r1, [r3, #2156]
	cmp	r1, r2
	bhi	.L1183
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1158:
	ldr	r1, [r3, #2152]
	cmp	r1, #0
	addne	ip, r0, #26368
	addne	ip, ip, #220
	bne	.L1167
.L1168:
	ldr	r2, [r3, #2156]
	cmp	r2, #0
	beq	.L1203
	add	r0, r0, #26624
	mov	r2, #0
	add	r0, r0, #28
	b	.L1170
.L1169:
	ldr	r1, [r3, #2156]
	cmp	r1, r2
	bls	.L1204
.L1170:
	ldr	r1, [r0, #4]!
	add	r2, r2, #1
	ldrb	ip, [r1, #2]
	cmp	ip, #3
	bne	.L1169
	ldr	ip, [r1, #644]
	bic	ip, ip, #-16777216
	bic	ip, ip, #255
	cmp	ip, #256
	ldreq	ip, [r1, #612]
	streq	ip, [r1, #648]
	ldr	r1, [r3, #2156]
	cmp	r1, r2
	bhi	.L1170
.L1204:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1205:
	ldr	lr, [r1, #644]
	bic	lr, lr, #-16777216
	bic	lr, lr, #255
	cmp	lr, #65536
	bne	.L1164
	ldr	lr, [r1, #604]
	ldr	r4, [r6, #1072]
	rsb	r5, r7, lr
	cmp	lr, r4
	strhi	r5, [r1, #608]
	strls	lr, [r1, #608]
	ldr	r1, [ip]
	ldr	lr, [r1, #608]
	str	lr, [r1, #652]
.L1164:
	ldr	r1, [r3, #2152]
	add	r2, r2, #1
	cmp	r1, r2
	bls	.L1168
.L1167:
	ldr	r1, [ip, #4]!
	ldrb	lr, [r1, #2]
	cmp	lr, #3
	bne	.L1164
	b	.L1205
.L1203:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1202:
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	CalcPicNum, .-CalcPicNum
	.align	2
	.global	IsOutDPB
	.type	IsOutDPB, %function
IsOutDPB:
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
	beq	.L1211
	add	r3, r0, #24576
	ldr	ip, [r3, #2148]
	cmp	ip, #0
	beq	.L1211
	ldr	r3, [r3, #1952]
	cmp	r3, r1
	beq	.L1213
	add	r0, r0, #26368
	mov	r3, #0
	add	r0, r0, #160
	b	.L1208
.L1209:
	ldr	r2, [r0, #4]!
	cmp	r2, r1
	beq	.L1213
.L1208:
	add	r3, r3, #1
	cmp	r3, ip
	bne	.L1209
.L1211:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L1213:
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	IsOutDPB, .-IsOutDPB
	.align	2
	.global	WriteCurrPicYUV
	.type	WriteCurrPicYUV, %function
WriteCurrPicYUV:
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
	add	r5, r0, #57344
	ldr	r1, .L1217
	mov	r0, #2
	ldrb	r4, [r5, #459]
	ldr	r3, [r5, #1064]
	mov	r2, r4
	ldr	r3, [r3, #164]
	bl	dprint_vfmw
	ldr	ip, [r5, #1116]
	cmp	r4, #3
	cmpne	r4, #0
	ldr	r3, [r5, #1112]
	addne	r2, r4, #1
	ldr	r1, .L1217+4
	moveq	r2, #1
	str	ip, [sp]
	mov	r0, #22
	bl	dprint_vfmw
	sub	sp, fp, #20
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1218:
	.align	2
.L1217:
	.word	.LC39
	.word	.LC40
	.fnend
	.size	WriteCurrPicYUV, .-WriteCurrPicYUV
	.align	2
	.global	WritePicMsg
	.type	WritePicMsg, %function
WritePicMsg:
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
	add	r5, r0, #57344
	mov	r4, r0
	ldr	r1, .L1255
	mov	r0, #2
	ldr	lr, [r5, #1132]
	mov	r7, #0
	ldr	ip, [r5, #628]
	add	r9, r4, #12288
	ldrb	r3, [r5, #459]
	add	r8, r4, #16384
	ldr	r2, [r5, #1080]
	stmia	sp, {ip, lr}
	bl	dprint_vfmw
	movw	r2, #58384
	str	r7, [r5, #3812]
	add	r3, r4, #59648
	ldrd	r0, [r4, r2]
	strd	r0, [r3, #232]
	ldr	lr, [r5, #3808]
	ldr	ip, [r5, #612]
	ldr	r0, [r5, #616]
	ldr	r1, [r5, #620]
	ldr	r2, [r5, #1080]
	ldrb	r3, [r5, #459]
	str	lr, [r5, #3536]
	str	ip, [r5, #3316]
	str	r0, [r5, #3320]
	str	r1, [r5, #3324]
	strb	r3, [r5, #2528]
	str	r2, [r5, #2544]
	ldr	r1, [r5, #1116]
	ldrb	r2, [r9, #1327]
	ldr	r3, [r5, #1120]
	str	r1, [r5, #2548]
	str	r2, [r5, #2560]
	str	r3, [r5, #2552]
	ldr	r3, [r8, #460]
	add	r3, r3, #1
	str	r3, [r5, #2556]
	ldrb	r3, [r9, #1326]
	strb	r3, [r5, #2531]
	ldr	r3, [r8, #1272]
	str	r3, [r5, #2564]
	ldrb	r3, [r8, #1212]
	str	r3, [r5, #2568]
	ldr	r3, [r9, #1348]
	strb	r3, [r5, #2529]
	ldrb	r3, [r8, #1216]
	str	r3, [r5, #2572]
	ldr	r2, [r8, #3464]
	ldr	r3, [r5, #1064]
	ldr	r0, [r5, #3888]
	str	r2, [r5, #2576]
	ldr	r2, [r8, #3452]
	str	r2, [r5, #2580]
	ldr	r2, [r8, #3456]
	str	r2, [r5, #2584]
	ldr	r1, [r3, #600]
	bl	FSP_GetLogicFs
	subs	r10, r0, #0
	beq	.L1253
	ldr	r2, [r10, #608]
	ldr	r3, [r10, #612]
	cmp	r2, #0
	beq	.L1223
	cmp	r3, #0
	beq	.L1223
	add	r3, r4, #60160
	add	r1, r4, #60416
	add	r1, r1, #152
	ldr	r0, [r5, #3888]
	mov	r2, r3
	add	r3, r3, #148
	add	r2, r2, #20
	add	r6, r4, #24576
	bl	FSP_GetDecFsAddrTab
	ldr	r3, [r10, #608]
	add	r2, r4, #60416
	ldr	r0, [r5, #3888]
	ldr	r3, [r3, #8]
	mov	r1, r2
	add	r2, r2, #156
	add	r1, r1, #236
	str	r3, [r5, #2820]
	bl	FSP_GetPmvAddrTab
	ldr	r3, [r5, #1132]
	str	r3, [r5, #2828]
	ldr	r3, [r10, #624]
	str	r3, [r5, #3312]
	ldr	r3, [r10, #612]
	ldr	r3, [r3, #16]
	str	r3, [r5, #2824]
	ldr	r3, [r10, #612]
	ldr	r3, [r3, #76]
	str	r3, [r5, #2832]
	ldr	r3, [r6, #2420]
	cmp	r3, #0
	str	r3, [fp, #-48]
	str	r3, [r5, #3528]
	beq	.L1229
	add	lr, r4, #60672
	add	r10, r4, #26624
	add	r1, r4, #26880
	mov	r3, r7
	ldr	r7, [fp, #-48]
	mov	ip, r10
	mov	r0, lr
	mov	r2, lr
	add	r10, r10, #176
	add	lr, lr, #4
	add	ip, ip, #240
	add	r0, r0, #68
	add	r1, r1, #48
	add	r2, r2, #132
	str	r4, [fp, #-52]
.L1228:
	ldr	r4, [r10, #4]!
	add	r3, r3, #1
	cmp	r3, r7
	str	r4, [lr, #4]!
	ldr	r4, [ip, #4]!
	str	r4, [r0, #4]!
	ldr	r4, [r1, #4]!
	str	r4, [r2, #4]!
	bne	.L1228
	ldr	r4, [fp, #-52]
.L1229:
	ldrb	r3, [r9, #1333]
	cmp	r3, #0
	bne	.L1254
	ldrb	r1, [r8, #1230]
	cmp	r1, #0
	bne	.L1230
	add	r0, r4, #59904
	ldr	r9, .L1255+4
	add	r0, r0, #24
.L1231:
	and	r3, r1, #3
	add	r1, r1, #1
	cmp	r1, #24
	ldr	r3, [r9, r3, asl #2]
	bic	r2, r3, #16711680
	ubfx	ip, r3, #8, #8
	bic	r2, r2, #65280
	mov	r3, r3, lsr #8
	orr	r2, r2, ip, asl #16
	and	r3, r3, #65280
	orr	r3, r2, r3
	str	r3, [r0, #4]!
	bne	.L1231
	add	r8, r4, #59904
	mov	r7, #0
	add	r8, r8, #124
.L1232:
	add	r3, r7, #1
	and	r2, r7, #14
	and	r3, r3, #15
	add	r7, r7, #2
	add	r2, r9, r2, lsl #2
	cmp	r7, #32
	add	r3, r9, r3, lsl #2
	ldr	r2, [r2, #16]
	ldr	r1, [r3, #16]
	ubfx	r3, r2, #8, #8
	mov	r0, r2, lsr #24
	uxtb	r10, r2
	uxtb	lr, r1
	mov	ip, r1, lsr #16
	orr	r3, r3, r0, asl #8
	mov	r2, r2, lsr #8
	mov	lr, lr, asl #16
	and	r0, r1, #-16777216
	orr	ip, lr, ip, asl #24
	ubfx	r1, r1, #8, #8
	orr	ip, ip, r10
	and	r2, r2, #65280
	orr	r3, r3, r0
	orr	r2, ip, r2
	orr	r3, r3, r1, asl #16
	stmia	r8, {r2, r3}
	add	r8, r8, #8
	bne	.L1232
.L1237:
	ldr	r3, [fp, #-48]
	cmp	r3, #0
	beq	.L1234
	add	r9, r4, #60928
	add	r7, r4, #26624
	add	r7, r7, #180
	mov	r8, #0
	mov	r4, r9
	add	r9, r9, #80
	add	r4, r4, #144
.L1240:
	ldr	r2, [r7]
	mov	r1, #0
	ldr	r0, [r5, #3888]
	add	r8, r8, #1
	bl	FSP_GetStoreType
	adds	r0, r0, #0
	movne	r0, #1
	str	r0, [r9, #4]!
	ldr	r3, [r7], #4
	str	r3, [r4, #4]!
	ldr	r3, [r6, #2420]
	cmp	r3, r8
	bhi	.L1240
.L1234:
	mov	r0, #0
.L1250:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1254:
	ldrb	r1, [r8, #1230]
.L1230:
	cmp	r1, #1
	add	ip, r4, #59904
	mov	r0, #0
	add	ip, ip, #24
	beq	.L1235
.L1238:
	add	r3, r0, #3888
	add	r0, r0, #1
	add	r3, r3, #2
	cmp	r0, #24
	add	r3, r4, r3, lsl #2
	ldr	r3, [r3, #8]
	bic	r2, r3, #16711680
	ubfx	r1, r3, #8, #8
	bic	r2, r2, #65280
	mov	r3, r3, lsr #8
	orr	r2, r2, r1, asl #16
	and	r3, r3, #65280
	orr	r3, r2, r3
	str	r3, [ip, #4]!
	bne	.L1238
	add	r9, r4, #59904
	mov	r10, #1
	add	r9, r9, #124
	mov	r8, #0
.L1239:
	mov	r2, r8, lsr #3
	mov	r3, r8, asl #1
	and	r1, r10, #15
	and	r0, r3, #14
	mov	r3, r2, asl #4
	add	r8, r8, #1
	add	r2, r3, r1
	add	r3, r3, r0
	add	r2, r2, #3904
	add	r3, r3, #3904
	add	r2, r2, #10
	add	r3, r3, #10
	cmp	r8, #16
	add	r10, r10, #2
	add	r2, r4, r2, lsl #2
	add	r3, r4, r3, lsl #2
	ldr	r1, [r2, #8]
	ldr	r3, [r3, #8]
	ubfx	r7, r1, #8, #8
	and	r0, r1, #-16777216
	mov	r2, r1, lsr #16
	uxtb	r1, r1
	mov	ip, r3, lsr #24
	uxtb	lr, r3
	mov	r2, r2, asl #24
	mov	ip, ip, asl #8
	orr	r2, r2, r1, asl #16
	orr	ip, ip, r7, asl #16
	mov	r1, r3, lsr #8
	orr	r2, r2, lr
	and	r1, r1, #65280
	ubfx	r3, r3, #8, #8
	orr	r0, ip, r0
	orr	r2, r2, r1
	orr	r3, r0, r3
	stmia	r9, {r2, r3}
	add	r9, r9, #8
	bne	.L1239
	b	.L1237
.L1235:
	add	r3, r0, #4864
	add	r0, r0, #1
	add	r3, r3, #30
	cmp	r0, #24
	add	r3, r4, r3, lsl #2
	ldr	r3, [r3, #4]
	bic	r2, r3, #16711680
	ubfx	r1, r3, #8, #8
	bic	r2, r2, #65280
	mov	r3, r3, lsr #8
	orr	r2, r2, r1, asl #16
	and	r3, r3, #65280
	orr	r3, r2, r3
	str	r3, [ip, #4]!
	bne	.L1235
	add	r9, r4, #59904
	mov	r10, #1
	add	r9, r9, #124
	mov	r8, #0
.L1236:
	mov	r2, r8, lsr #3
	mov	r3, r8, asl #1
	and	r1, r10, #15
	and	r0, r3, #14
	mov	r3, r2, asl #4
	add	r8, r8, #1
	add	r2, r3, r1
	add	r3, r3, r0
	add	r2, r2, #4864
	add	r3, r3, #4864
	add	r2, r2, #54
	add	r3, r3, #54
	cmp	r8, #16
	add	r10, r10, #2
	add	r2, r4, r2, lsl #2
	add	r3, r4, r3, lsl #2
	ldr	r1, [r2, #4]
	ldr	r3, [r3, #4]
	ubfx	r7, r1, #8, #8
	and	r0, r1, #-16777216
	mov	r2, r1, lsr #16
	uxtb	r1, r1
	mov	ip, r3, lsr #24
	uxtb	lr, r3
	mov	r2, r2, asl #24
	mov	ip, ip, asl #8
	orr	r2, r2, r1, asl #16
	orr	ip, ip, r7, asl #16
	mov	r1, r3, lsr #8
	orr	r2, r2, lr
	and	r1, r1, #65280
	ubfx	r3, r3, #8, #8
	orr	r0, ip, r0
	orr	r2, r2, r1
	orr	r3, r0, r3
	stmia	r9, {r2, r3}
	add	r9, r9, #8
	bne	.L1236
	b	.L1237
.L1223:
	ldr	r1, .L1255+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1250
.L1253:
	ldr	r3, [r5, #1064]
	ldr	r1, .L1255+12
	ldr	r2, [r3, #600]
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1250
.L1256:
	.align	2
.L1255:
	.word	.LC41
	.word	.LANCHOR0
	.word	.LC43
	.word	.LC42
	.fnend
	.size	WritePicMsg, .-WritePicMsg
	.align	2
	.global	UpdatePicQpInf
	.type	UpdatePicQpInf, %function
UpdatePicQpInf:
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
	ldr	r2, [r1, #24]
	ldr	r3, [r1, #28]
	cmp	r2, r0
	movlt	r2, r0
	cmp	r3, r0
	str	r2, [r1, #24]
	movge	r3, r0
	str	r3, [r1, #28]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	UpdatePicQpInf, .-UpdatePicQpInf
	.align	2
	.global	WriteSliceMsg
	.type	WriteSliceMsg, %function
WriteSliceMsg:
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
	add	r9, r0, #57344
	add	lr, r0, #12288
	mov	r4, r0
	movw	r0, #4060
	ldr	r3, [r9, #3812]
	ldr	ip, [r9, #3808]
	mov	r2, r3
	str	r3, [fp, #-52]
	mul	r0, r0, r2
	add	r3, r3, #1
	str	r3, [r9, #3812]
	ldr	r3, [lr, #1284]
	add	r6, ip, r0
	sub	r3, r3, #1
	cmp	r2, r3
	addcc	r3, r0, #4048
	addcc	r3, r3, #12
	movcs	r3, #0
	addcc	r3, ip, r3
	str	r3, [r6, #4056]
	ldr	r1, [r4, #368]
	ldrb	r5, [r1]
	ldr	r3, [r1, #68]
	cmp	r5, #1
	cmpls	r5, r3
	bcs	.L1261
	add	r7, r5, #3
	add	r7, r6, r7, lsl #2
.L1262:
	mov	r3, r5, asl #5
	sub	r3, r3, r5, asl #2
	add	r5, r5, #1
	add	r1, r1, r3
	ldr	r2, [r1, #24]
	str	r2, [r7, #4]!
	ldr	r2, [r4, #368]
	add	r2, r2, r3
	ldr	r2, [r2, #20]
	str	r2, [r7, #-8]
	ldr	r2, [r4, #368]
	add	r3, r2, r3
	ldr	r3, [r3, #28]
	str	r3, [r7, #8]
	ldr	r1, [r4, #368]
	ldr	r3, [r1, #68]
	cmp	r3, r5
	movhi	r2, #1
	movls	r2, #0
	cmp	r5, #1
	movhi	r2, #0
	cmp	r2, #0
	bne	.L1262
.L1261:
	cmp	r3, #1
	bhi	.L1267
	add	r3, r3, #3
	add	r5, r6, #20
	mov	r1, #0
	add	r3, r6, r3, lsl #2
.L1266:
	str	r1, [r3, #4]!
	cmp	r3, r5
	str	r1, [r3, #-8]
	str	r1, [r3, #8]
	bne	.L1266
.L1267:
	ldrb	r3, [r9, #465]
	add	r2, r4, #16384
	ldr	r1, [fp, #-52]
	add	r5, r4, #20480
	str	r2, [fp, #-48]
	strb	r3, [r6, #1]
	cmp	r1, #0
	ldr	r3, [r2, #1260]
	ldr	r1, [r5, #1820]
	add	r3, r3, #26
	add	r3, r3, r1
	str	r3, [r6, #32]
	bne	.L1361
	ldr	r1, [r9, #1064]
	str	r3, [r1, #668]
	ldr	r3, [r9, #1064]
	ldr	r1, [r6, #32]
	str	r1, [r3, #672]
.L1268:
	ldr	r3, [r5, #1816]
	str	r3, [r6, #36]
	ldr	r3, [r5, #268]
	str	r3, [r6, #40]
	ldr	r3, [r5, #264]
	str	r3, [r6, #44]
	ldrb	r3, [r5, #208]
	strb	r3, [ip, r0]
	ldr	r3, [r5, #260]
	str	r3, [r6, #48]
	ldrb	r3, [r5, #214]
	strb	r3, [r6, #2]
	ldrb	r3, [lr, #1328]
	strb	r3, [r6, #3]
	ldr	r3, [r5, #252]
	str	r3, [r6, #52]
	ldr	r3, [r5, #256]
	str	r3, [r6, #56]
	ldrb	r3, [r5, #208]
	cmp	r3, #1
	beq	.L1362
	cmp	r3, #0
	ldreq	r3, [fp, #-48]
	movne	r3, #0
	ldreqb	r3, [r3, #1214]
	strb	r3, [r6, #4]
.L1270:
	ldr	r2, [fp, #-48]
	ldr	r3, [r2, #1264]
	str	r3, [r6, #60]
	ldr	r3, [r2, #1268]
	str	r3, [r6, #64]
	ldr	r3, [r5, #1828]
	str	r3, [r6, #68]
	ldr	r3, [r5, #1832]
	str	r3, [r6, #72]
	ldr	r3, [r5, #1824]
	str	r3, [r6, #76]
	ldrb	r3, [r5, #208]
	cmp	r3, #2
	beq	.L1309
	ldr	r8, [r5, #252]
	cmp	r8, #0
	beq	.L1312
	add	r3, r4, #24576
	ldr	r3, [r3, #2556]
	ldr	r0, [r3, #32]
	ldrb	r3, [r0]
	cmp	r3, #0
	addne	r1, r4, #26880
	movne	r3, #0
	addne	r1, r1, #252
	bne	.L1277
	b	.L1275
.L1279:
	ldr	r2, [r1, #4]!
	ldr	r0, [r2, #32]
	ldrb	r2, [r0]
	cmp	r2, #0
	beq	.L1275
.L1277:
	add	r3, r3, #1
	cmp	r3, r8
	bne	.L1279
	mov	r3, #0
	str	r3, [fp, #-56]
.L1274:
	ldr	lr, [r5, #256]
	cmp	lr, #0
	beq	.L1313
	add	r3, r4, #24576
	ldr	r3, [r3, #2688]
	ldr	r0, [r3, #32]
	ldrb	r3, [r0]
	cmp	r3, #0
	addne	r1, r4, #27136
	movne	r3, #0
	addne	r1, r1, #128
	bne	.L1283
	b	.L1281
.L1285:
	ldr	r2, [r1, #4]!
	ldr	r0, [r2, #32]
	ldrb	r2, [r0]
	cmp	r2, #0
	beq	.L1281
.L1283:
	add	r3, r3, #1
	cmp	r3, lr
	bne	.L1285
	mov	r3, #0
	str	r3, [fp, #-60]
.L1280:
	ldrb	ip, [r9, #459]
	ldr	r3, [r5, #252]
	cmp	ip, #0
	beq	.L1286
	cmp	r3, #0
	beq	.L1301
	add	r7, r4, #26880
	mov	r8, #0
	str	r4, [fp, #-64]
	mov	r10, r6
	mov	r4, r5
	add	r7, r7, #252
	mov	r5, r8
	ldr	r8, [fp, #-56]
	b	.L1300
.L1298:
	strb	r2, [r10, #1630]
	ldr	r2, [r7]
	ldrb	r2, [r2, #1]
	strb	r2, [r10, #1631]
	ldr	r2, [r7]
	ldr	r2, [r2, #12]
	str	r2, [r10, #1656]
.L1299:
	ldr	r2, [r4, #252]
	add	r5, r5, #1
	add	r7, r7, #4
	add	r10, r10, #36
	cmp	r2, r5
	bls	.L1363
.L1300:
	ldr	r2, [r7]
	ldr	r0, [r9, #3888]
	ldr	r2, [r2, #32]
	ldr	r1, [r2, #600]
	bl	FSP_GetLogicFs
	ldr	r2, [r7]
	ldr	r2, [r2, #32]
	ldr	r2, [r2, #636]
	str	r2, [r10, #1636]
	ldr	r2, [r7]
	ldr	r2, [r2, #32]
	ldrb	r2, [r2, #1]
	strb	r2, [r10, #1625]
	ldr	r2, [r7]
	ldr	r2, [r2, #32]
	ldrb	r2, [r2]
	cmp	r2, #1
	moveq	r0, r8
	beq	.L1297
	cmp	r0, #0
	ldrne	r2, [r0, #608]
	ldrne	r0, [r2, #8]
.L1297:
	str	r0, [r10, #1640]
	ldr	r2, [r7]
	ldr	r2, [r2, #32]
	ldr	r2, [r2, #640]
	str	r2, [r10, #1644]
	ldr	r2, [r7]
	ldr	r2, [r2, #32]
	ldr	r2, [r2, #616]
	str	r2, [r10, #1632]
	ldr	r2, [r7]
	ldrb	r2, [r2]
	strb	r2, [r10, #1624]
	ldr	r2, [r7]
	ldr	r2, [r2, #32]
	ldrb	r2, [r2, #644]
	strb	r2, [r10, #1626]
	ldr	r2, [r7]
	ldrb	r2, [r2]
	cmp	r2, #1
	bne	.L1298
	strb	r2, [r10, #1628]
	ldr	r2, [r7]
	ldrb	r2, [r2, #1]
	strb	r2, [r10, #1629]
	ldr	r2, [r7]
	ldr	r2, [r2, #12]
	str	r2, [r10, #1652]
	b	.L1299
.L1363:
	mov	r5, r4
	ldr	r4, [fp, #-64]
.L1301:
	ldrb	r3, [r5, #208]
	cmp	r3, #1
	beq	.L1364
.L1289:
	add	r1, r4, #26880
	add	r3, r6, #3920
	add	ip, r6, #4048
	add	r1, r1, #120
	add	r3, r3, #4
	add	ip, ip, #4
.L1306:
	ldr	r2, [r1, #4]!
	str	r2, [r3, #4]!
	cmp	r3, ip
	bne	.L1306
	ldr	r2, [fp, #-48]
	ldrb	r3, [r2, #1214]
	cmp	r3, #0
	str	r3, [r9, #2812]
	ldr	r3, [r2, #1256]
	str	r3, [r9, #2816]
	beq	.L1307
	ldrb	r2, [r5, #208]
	cmp	r2, #0
	beq	.L1308
.L1307:
	cmp	r3, #1
	beq	.L1365
.L1309:
	ldr	r3, [fp, #-52]
	mov	r2, #0
	ldr	r1, [r4, #368]
	add	r3, r3, #14784
	add	r3, r3, #18
	str	r1, [r4, r3, asl #2]
	str	r2, [r4, #368]
.L1258:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1361:
	ldr	r1, [r9, #1064]
	ldr	r8, [r1, #668]
	ldr	r7, [r1, #672]
	cmp	r8, r3
	movlt	r8, r3
	cmp	r7, r3
	str	r8, [r1, #668]
	movge	r7, r3
	str	r7, [r1, #672]
	b	.L1268
.L1275:
	ldr	r1, [r0, #600]
	ldr	r0, [r9, #3888]
	bl	FSP_GetLogicFs
	subs	r3, r0, #0
	beq	.L1366
	ldr	r3, [r3, #608]
	ldr	r3, [r3, #8]
	str	r3, [fp, #-56]
	b	.L1274
.L1365:
	ldrb	r3, [r5, #208]
	cmp	r3, #1
	bne	.L1309
.L1308:
	ldr	r3, [r5, #272]
	add	r9, r4, #20736
	add	lr, r4, #21504
	add	r7, r4, #20992
	add	r0, r4, #21760
	mov	r8, r9
	str	r3, [r6, #80]
	mov	ip, lr
	ldr	r10, [r5, #276]
	add	r9, r9, #20
	add	r8, r8, #148
	add	r7, r7, #20
	add	lr, lr, #20
	add	ip, ip, #148
	add	r0, r0, #20
	mov	r1, r6
	mov	r3, r6
	mov	r2, #0
	str	r6, [fp, #-48]
	str	r10, [r1, #84]!
.L1310:
	ldr	r10, [r9, #4]!
	add	r2, r2, #1
	add	r3, r3, #4
	str	r10, [r1, #4]!
	ldr	r10, [r8, #4]!
	str	r10, [r3, #212]
	ldr	r10, [r7, #4]!
	str	r10, [r3, #340]
	ldr	r10, [lr, #4]!
	str	r10, [r3, #852]
	ldr	r10, [ip, #4]!
	str	r10, [r3, #980]
	ldr	r10, [r0, #4]!
	str	r10, [r3, #1108]
	ldr	r10, [r5, #264]
	cmp	r10, r2
	bcs	.L1310
	ldrb	r3, [r5, #208]
	cmp	r3, #1
	bne	.L1309
	add	lr, r4, #21248
	add	r1, r4, #22016
	add	r7, r4, #20992
	add	r0, r4, #21760
	ldr	r8, [fp, #-48]
	mov	ip, lr
	mov	r2, r1
	add	r6, r6, #468
	add	r7, r7, #148
	add	lr, lr, #20
	add	ip, ip, #148
	add	r0, r0, #148
	add	r1, r1, #20
	add	r2, r2, #148
	mov	r3, #0
.L1311:
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
	ldr	r9, [r5, #268]
	cmp	r9, r3
	bcs	.L1311
	b	.L1309
.L1286:
	cmp	r3, #0
	beq	.L1294
	add	r10, r4, #26880
	ldr	r8, [fp, #-56]
	add	r10, r10, #252
	str	r4, [fp, #-64]
	mov	r7, r6
	mov	r4, r5
	mov	r5, ip
.L1293:
	ldr	r2, [r10]
	ldr	r0, [r9, #3888]
	ldr	r2, [r2, #32]
	ldr	r1, [r2, #600]
	bl	FSP_GetLogicFs
	ldr	r2, [r10]
	ldr	r2, [r2, #32]
	ldr	r2, [r2, #636]
	str	r2, [r7, #1636]
	ldr	r2, [r10]
	ldr	r2, [r2, #32]
	ldrb	r2, [r2, #1]
	strb	r2, [r7, #1625]
	ldr	r2, [r10]
	ldr	r2, [r2, #32]
	ldrb	r2, [r2]
	cmp	r2, #1
	moveq	r0, r8
	beq	.L1292
	cmp	r0, #0
	ldrne	r2, [r0, #608]
	ldrne	r0, [r2, #8]
.L1292:
	str	r0, [r7, #1640]
	mov	r3, #0
	ldr	r2, [r10]
	add	r5, r5, #1
	add	r7, r7, #36
	ldr	r2, [r2, #32]
	ldr	r2, [r2, #640]
	str	r2, [r7, #1608]
	ldr	r2, [r10]
	ldr	r2, [r2, #32]
	ldr	r2, [r2, #616]
	str	r2, [r7, #1596]
	ldr	r2, [r10]
	ldrb	r2, [r2, #1]
	strb	r2, [r7, #1591]
	ldr	r2, [r10]
	ldrb	r2, [r2]
	strb	r2, [r7, #1590]
	ldr	r2, [r10]
	ldr	r2, [r2, #32]
	ldr	r2, [r2, #656]
	str	r2, [r7, #1612]
	ldr	r2, [r10]
	ldr	r2, [r2, #32]
	ldr	r2, [r2, #692]
	str	r2, [r7, #1616]
	ldr	r2, [r10], #4
	ldr	r2, [r2, #32]
	ldr	r2, [r2, #728]
	strb	r3, [r7, #1588]
	str	r2, [r7, #1620]
	ldr	r2, [r4, #252]
	cmp	r2, r5
	bhi	.L1293
	mov	r5, r4
	ldr	r4, [fp, #-64]
.L1294:
	ldrb	r3, [r5, #208]
	cmp	r3, #1
	bne	.L1289
	ldr	r3, [r5, #256]
	cmp	r3, #0
	beq	.L1289
	mov	r7, #0
	add	r10, r4, #27136
	str	r4, [fp, #-56]
	mov	r4, r5
	mov	r5, r7
	ldr	r7, [fp, #-60]
	add	r10, r10, #128
	mov	r8, r6
.L1296:
	ldr	r2, [r10]
	ldr	r0, [r9, #3888]
	ldr	r2, [r2, #32]
	ldr	r1, [r2, #600]
	bl	FSP_GetLogicFs
	ldr	r2, [r10]
	ldr	r2, [r2, #32]
	ldr	r2, [r2, #636]
	str	r2, [r8, #2788]
	ldr	r2, [r10]
	ldr	r2, [r2, #32]
	ldrb	r2, [r2, #1]
	strb	r2, [r8, #2777]
	ldr	r2, [r10]
	ldr	r2, [r2, #32]
	ldrb	r2, [r2]
	cmp	r2, #1
	moveq	r0, r7
	beq	.L1295
	cmp	r0, #0
	ldrne	r2, [r0, #608]
	ldrne	r0, [r2, #8]
.L1295:
	str	r0, [r8, #1640]
	mov	r3, #0
	ldr	r2, [r10]
	add	r5, r5, #1
	add	r8, r8, #36
	ldr	r2, [r2, #32]
	ldr	r2, [r2, #640]
	str	r2, [r8, #2760]
	ldr	r2, [r10]
	ldr	r2, [r2, #32]
	ldr	r2, [r2, #616]
	str	r2, [r8, #2748]
	ldr	r2, [r10]
	ldrb	r2, [r2, #1]
	strb	r2, [r8, #2743]
	ldr	r2, [r10]
	ldrb	r2, [r2]
	strb	r2, [r8, #2742]
	ldr	r2, [r10]
	ldr	r2, [r2, #32]
	ldr	r2, [r2, #656]
	str	r2, [r8, #2764]
	ldr	r2, [r10]
	ldr	r2, [r2, #32]
	ldr	r2, [r2, #692]
	str	r2, [r8, #2768]
	ldr	r2, [r10], #4
	ldr	r2, [r2, #32]
	ldr	r2, [r2, #728]
	strb	r3, [r8, #2740]
	str	r2, [r8, #2772]
	ldr	r2, [r4, #256]
	cmp	r2, r5
	bhi	.L1296
.L1357:
	mov	r5, r4
	ldr	r4, [fp, #-56]
	b	.L1289
.L1281:
	ldr	r1, [r0, #600]
	ldr	r0, [r9, #3888]
	bl	FSP_GetLogicFs
	subs	r3, r0, #0
	beq	.L1367
	ldr	r3, [r3, #608]
	ldr	r3, [r3, #8]
	str	r3, [fp, #-60]
	b	.L1280
.L1362:
	ldr	r3, [fp, #-48]
	ldr	r3, [r3, #1256]
	strb	r3, [r6, #4]
	b	.L1270
.L1364:
	ldr	r3, [r5, #256]
	cmp	r3, #0
	beq	.L1289
	add	r7, r4, #27136
	mov	r10, #0
	str	r4, [fp, #-56]
	mov	r8, r6
	mov	r4, r5
	add	r7, r7, #128
	mov	r5, r10
	ldr	r10, [fp, #-60]
	b	.L1305
.L1303:
	strb	r2, [r8, #2782]
	ldr	r2, [r7]
	ldrb	r2, [r2, #1]
	strb	r2, [r8, #2783]
	ldr	r2, [r7]
	ldr	r2, [r2, #12]
	str	r2, [r8, #2808]
.L1304:
	ldr	r2, [r4, #256]
	add	r5, r5, #1
	add	r7, r7, #4
	add	r8, r8, #36
	cmp	r2, r5
	bls	.L1357
.L1305:
	ldr	r2, [r7]
	ldr	r0, [r9, #3888]
	ldr	r2, [r2, #32]
	ldr	r1, [r2, #600]
	bl	FSP_GetLogicFs
	ldr	r2, [r7]
	ldr	r2, [r2, #32]
	ldr	r2, [r2, #636]
	str	r2, [r8, #2788]
	ldr	r2, [r7]
	ldr	r2, [r2, #32]
	ldrb	r2, [r2, #1]
	strb	r2, [r8, #2777]
	ldr	r2, [r7]
	ldr	r2, [r2, #32]
	ldrb	r2, [r2]
	cmp	r2, #1
	moveq	r0, r10
	beq	.L1302
	cmp	r0, #0
	ldrne	r2, [r0, #608]
	ldrne	r0, [r2, #8]
.L1302:
	str	r0, [r8, #2792]
	ldr	r2, [r7]
	ldr	r2, [r2, #32]
	ldr	r2, [r2, #640]
	str	r2, [r8, #2796]
	ldr	r2, [r7]
	ldr	r2, [r2, #32]
	ldr	r2, [r2, #616]
	str	r2, [r8, #2784]
	ldr	r2, [r7]
	ldrb	r2, [r2]
	strb	r2, [r8, #2776]
	ldr	r2, [r7]
	ldr	r2, [r2, #32]
	ldrb	r2, [r2, #644]
	strb	r2, [r8, #2778]
	ldr	r2, [r7]
	ldrb	r2, [r2]
	cmp	r2, #1
	bne	.L1303
	strb	r2, [r8, #2780]
	ldr	r2, [r7]
	ldrb	r2, [r2, #1]
	strb	r2, [r8, #2781]
	ldr	r2, [r7]
	ldr	r2, [r2, #12]
	str	r2, [r8, #2804]
	b	.L1304
.L1313:
	str	lr, [fp, #-60]
	b	.L1280
.L1312:
	str	r8, [fp, #-56]
	b	.L1274
.L1367:
	movw	r2, #7491
	ldr	r1, .L1368
	bl	dprint_vfmw
	b	.L1258
.L1366:
	movw	r2, #7470
	ldr	r1, .L1368
	bl	dprint_vfmw
	b	.L1258
.L1369:
	.align	2
.L1368:
	.word	.LC44
	.fnend
	.size	WriteSliceMsg, .-WriteSliceMsg
	.align	2
	.global	StopPicNum
	.type	StopPicNum, %function
StopPicNum:
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
	.size	StopPicNum, .-StopPicNum
	.align	2
	.global	H264_GetPicStreamSize
	.type	H264_GetPicStreamSize, %function
H264_GetPicStreamSize:
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
	add	r0, r0, #57344
	ldr	r2, [r0, #3536]
	cmp	r2, #0
	beq	.L1374
	mov	r0, #0
.L1373:
	ldr	r3, [r2, #8]
	ldr	r1, [r2, #12]
	ldr	r2, [r2, #4056]
	add	r3, r3, r1
	add	r3, r3, #7
	cmp	r2, #0
	add	r0, r0, r3, lsr #3
	bne	.L1373
	ldmfd	sp, {fp, sp, pc}
.L1374:
	mov	r0, r2
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	H264_GetPicStreamSize, .-H264_GetPicStreamSize
	.align	2
	.global	SliceCheck
	.type	SliceCheck, %function
SliceCheck:
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
	ldr	r1, .L1387
	add	r4, r0, #20480
	add	r6, r0, #57344
	mov	r5, r0
	bl	ue_v
	str	r0, [r4, #260]
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L1385
	cmp	r0, #262144
	bcs	.L1386
	add	r2, r5, #12288
	ldr	r1, [r2, #1276]
	ldr	r3, [r2, #1280]
	mul	r3, r3, r1
	sub	r3, r3, #1
	cmp	r0, r3
	bhi	.L1385
	mov	r0, r5
	ldr	r1, .L1387+4
	bl	ue_v
	ldr	r1, .L1387+8
	mov	r2, r0
	mov	r5, r0
	mov	r0, #19
	bl	dprint_vfmw
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L1385
	cmp	r5, #9
	bhi	.L1381
	mov	r1, #1
	movw	r0, #297
	mov	r2, r1, asl r5
	and	r0, r0, r2
	cmp	r0, #0
	bne	.L1382
	ands	r3, r2, #660
	bne	.L1383
	tst	r2, #66
	beq	.L1381
	strb	r1, [r4, #208]
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1382:
	strb	r3, [r4, #208]
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1381:
	mov	r2, r5
	ldr	r1, .L1387+12
	mov	r0, #1
	bl	dprint_vfmw
.L1385:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1383:
	mov	r3, #2
	strb	r3, [r4, #208]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1386:
	ldr	r1, .L1387+16
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1388:
	.align	2
.L1387:
	.word	.LC45
	.word	.LC47
	.word	.LC48
	.word	.LC49
	.word	.LC46
	.fnend
	.size	SliceCheck, .-SliceCheck
	.align	2
	.global	PPSSPSCheck
	.type	PPSSPSCheck, %function
PPSSPSCheck:
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
	add	r5, r0, #20480
	mov	r4, r0
	add	r4, r4, #12288
	ldr	r1, .L1395
	mov	r0, #19
	ldr	r2, [r5, #220]
	bl	dprint_vfmw
	ldr	r1, [r4, #1304]
	ldr	r2, [r5, #220]
	mov	r3, #2208
	mla	r3, r3, r2, r1
	ldrb	r1, [r3, #19]
	cmp	r1, #0
	beq	.L1393
	ldr	r2, [r3, #28]
	mov	r3, #4000
	ldr	r1, [r4, #1300]
	mla	r3, r3, r2, r1
	ldrb	r3, [r3, #23]
	cmp	r3, #0
	beq	.L1394
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1393:
	ldr	r1, .L1395+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1394:
	ldr	r1, .L1395+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1396:
	.align	2
.L1395:
	.word	.LC50
	.word	.LC51
	.word	.LC52
	.fnend
	.size	PPSSPSCheck, .-PPSSPSCheck
	.align	2
	.global	PPSSPSCheckTmpId
	.type	PPSSPSCheckTmpId, %function
PPSSPSCheckTmpId:
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
	ldr	r1, .L1405
	mov	r0, #19
	bl	dprint_vfmw
	add	r0, r4, #12288
	mov	r3, #2208
	ldr	r2, [r0, #1304]
	mla	r3, r3, r5, r2
	ldrb	r2, [r3, #19]
	cmp	r2, #0
	beq	.L1402
	ldr	r1, [r0, #1288]
	ldr	r2, [r3, #28]
	sub	r3, r1, #1
	cmp	r2, r3
	bhi	.L1403
	ldr	r1, [r0, #1300]
	mov	r3, #4000
	mla	r3, r3, r2, r1
	ldrb	r3, [r3, #23]
	cmp	r3, #0
	beq	.L1404
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1402:
	mov	r2, r5
	ldr	r1, .L1405+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1403:
	ldr	r1, .L1405+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1404:
	ldr	r1, .L1405+12
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L1406:
	.align	2
.L1405:
	.word	.LC53
	.word	.LC54
	.word	.LC55
	.word	.LC56
	.fnend
	.size	PPSSPSCheckTmpId, .-PPSSPSCheckTmpId
	.align	2
	.global	IsNewPic
	.type	IsNewPic, %function
IsNewPic:
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
	add	r3, r0, #20480
	add	lr, r0, #12288
	ldr	ip, [r3, #1860]
	ldr	r1, [lr, #1344]
	ldr	r2, [r3, #1864]
	ldr	r4, [r3, #220]
	ldr	r6, [r3, #1872]
	cmp	r2, r4
	cmpeq	ip, r1
	ldr	r5, [r3, #228]
	ldrb	r4, [r3, #1856]
	ldrb	ip, [r3, #209]
	movne	r1, #1
	moveq	r1, #0
	cmp	r6, r5
	moveq	r2, r1
	orrne	r2, r1, #1
	cmp	r4, ip
	orrne	r2, r2, #1
	cmp	r4, #0
	cmpne	ip, #0
	beq	.L1409
	ldrb	ip, [r3, #1857]
	ldrb	r1, [r3, #210]
	cmp	ip, r1
	orrne	r2, r2, #1
.L1409:
	ldr	r1, [r3, #1868]
	ldr	ip, [r3, #240]
	cmp	r1, ip
	moveq	r1, #0
	beq	.L1410
	cmp	ip, #0
	cmpne	r1, #0
	moveq	r1, #1
	movne	r1, #0
.L1410:
	ldrb	ip, [r3, #1858]
	ldrb	r4, [r3, #211]
	cmp	ip, r4
	orrne	r2, r2, #1
	cmp	r4, #5
	cmpeq	ip, #5
	orr	r2, r2, r1
	beq	.L1418
.L1411:
	ldr	r1, [lr, #3508]
	cmp	r1, #0
	bne	.L1412
	add	r0, r0, #16384
	ldr	r1, [r3, #1880]
	ldr	ip, [r3, #1884]
	ldr	lr, [r0, #3424]
	ldr	r0, [r0, #3420]
	cmp	r1, r0
	cmpeq	ip, lr
	movne	r1, #1
	moveq	r1, #0
	orr	r2, r2, r1
.L1413:
	ldr	r4, [r3, #260]
	mov	r0, #19
	ldr	r1, .L1419
	cmp	r4, #0
	movne	r4, r2
	orreq	r4, r2, #1
	mov	r2, r4
	bl	dprint_vfmw
	mov	r0, r4
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L1412:
	cmp	r1, #1
	bne	.L1413
	add	r0, r0, #16384
	ldr	r1, [r3, #1888]
	ldr	ip, [r3, #1892]
	ldr	lr, [r0, #3472]
	ldr	r0, [r0, #3468]
	cmp	r1, r0
	cmpeq	ip, lr
	movne	r1, #1
	moveq	r1, #0
	orr	r2, r2, r1
	b	.L1413
.L1418:
	ldr	ip, [r3, #1876]
	ldr	r1, [r3, #248]
	cmp	ip, r1
	orrne	r2, r2, #1
	b	.L1411
.L1420:
	.align	2
.L1419:
	.word	.LC57
	.fnend
	.size	IsNewPic, .-IsNewPic
	.align	2
	.global	ref_pic_list_reordering
	.type	ref_pic_list_reordering, %function
ref_pic_list_reordering:
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
	add	r5, r0, #20480
	add	r3, r0, #12288
	mov	lr, #2208
	ldr	r1, [r5, #220]
	mov	ip, #4000
	ldr	r2, [r3, #1304]
	add	r8, r0, #16384
	ldr	r3, [r3, #1300]
	mov	r4, r0
	mov	r0, #0
	mov	r7, #1
	mla	r2, lr, r1, r2
	ldr	r2, [r2, #28]
	strb	r0, [r8, #3512]
	strb	r0, [r8, #3513]
	mla	r3, ip, r2, r3
	ldrb	r1, [r5, #209]
	cmp	r1, r0
	ldr	r3, [r3, #2196]
	addne	r3, r3, #5
	addeq	r3, r3, #4
	mov	r7, r7, asl r3
	ldrb	r3, [r5, #208]
	cmp	r3, #1
	addhi	r6, r4, #57344
	bls	.L1475
.L1474:
	ldr	r3, [r6, #3828]
.L1440:
	adds	r3, r3, #0
	movne	r3, #1
	rsb	r0, r3, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1475:
	ldr	r1, .L1480
	mov	r0, r4
	bl	u_1
	uxtb	r0, r0
	strb	r0, [r8, #3512]
	cmp	r0, #0
	beq	.L1473
	ldr	r3, [r5, #264]
	cmn	r3, #2
	beq	.L1454
	add	r10, r4, #19712
	add	r6, r4, #57344
	add	r10, r10, #184
	mov	r9, #0
	b	.L1437
.L1432:
	cmp	r0, #2
	beq	.L1476
.L1435:
	ldr	r3, [r5, #264]
	add	r3, r3, #2
	cmp	r3, r9
	bls	.L1477
.L1437:
	ldr	r1, .L1480+4
	mov	r0, r4
	bl	ue_v
	add	r9, r9, #1
	cmp	r0, #3
	str	r0, [r10, #4]!
	ldr	r3, [r6, #3828]
	bhi	.L1428
	cmp	r3, #0
	bne	.L1428
	cmp	r0, #3
	beq	.L1431
	cmp	r0, #1
	bhi	.L1432
	ldr	r1, .L1480+8
	mov	r0, r4
	bl	ue_v
	cmp	r7, r0
	str	r0, [r10, #264]
	ldr	r3, [r6, #3828]
	bls	.L1434
	cmp	r3, #0
	beq	.L1435
.L1434:
	mov	r2, r0
	ldr	r1, .L1480+12
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1476:
	ldr	r1, .L1480+16
	mov	r0, r4
	bl	ue_v
	str	r0, [r10, #528]
	b	.L1435
.L1473:
	ldrb	r3, [r5, #208]
	add	r6, r4, #57344
.L1424:
	cmp	r3, #1
	bne	.L1474
	ldr	r1, .L1480+20
	mov	r0, r4
	bl	u_1
	uxtb	r0, r0
	strb	r0, [r8, #3513]
	cmp	r0, #0
	beq	.L1474
	ldr	r3, [r5, #268]
	cmn	r3, #2
	beq	.L1474
	add	r9, r4, #19968
	mov	r8, #0
	add	r9, r9, #60
	b	.L1452
.L1451:
	add	r8, r8, #1
	cmp	r8, r3
	bcs	.L1474
.L1452:
	ldr	r1, .L1480+24
	mov	r0, r4
	bl	ue_v
	cmp	r0, #3
	str	r0, [r9, #4]!
	ldr	r3, [r6, #3828]
	bhi	.L1444
	cmp	r3, #0
	bne	.L1444
	cmp	r0, #3
	beq	.L1440
	cmp	r0, #1
	bls	.L1478
	cmp	r0, #2
	beq	.L1479
	ldr	r3, [r5, #268]
	add	r3, r3, #2
	cmp	r3, r8
	bne	.L1451
.L1453:
	ldr	r1, .L1480+28
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1478:
	ldr	r1, .L1480+32
	mov	r0, r4
	bl	ue_v
	cmp	r7, r0
	str	r0, [r9, #264]
	ldr	r3, [r6, #3828]
	bls	.L1448
	cmp	r3, #0
	bne	.L1448
.L1449:
	ldr	r2, [r5, #268]
	add	r3, r2, #2
	cmp	r3, r8
	bne	.L1451
	add	r2, r2, #4992
	add	r2, r2, #18
	ldr	r2, [r4, r2, asl #2]
	cmp	r2, #3
	beq	.L1451
	b	.L1453
.L1479:
	ldr	r1, .L1480+36
	mov	r0, r4
	bl	ue_v
	str	r0, [r9, #524]
	b	.L1449
.L1431:
	ldrb	r3, [r5, #208]
	b	.L1424
.L1428:
	mov	r2, r0
	ldr	r1, .L1480+40
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1444:
	mov	r2, r0
	ldr	r1, .L1480+44
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1477:
	cmp	r9, r3
	bne	.L1431
.L1426:
	add	r3, r3, #4928
	add	r3, r3, #46
	add	r3, r4, r3, lsl #2
	ldr	r3, [r3, #4]
	cmp	r3, #3
	beq	.L1473
	ldr	r1, .L1480+48
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1448:
	mov	r2, r0
	ldr	r1, .L1480+52
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1454:
	mov	r3, #0
	b	.L1426
.L1481:
	.align	2
.L1480:
	.word	.LC58
	.word	.LC59
	.word	.LC61
	.word	.LC62
	.word	.LC63
	.word	.LC65
	.word	.LC66
	.word	.LC71
	.word	.LC68
	.word	.LC70
	.word	.LC60
	.word	.LC67
	.word	.LC64
	.word	.LC69
	.fnend
	.size	ref_pic_list_reordering, .-ref_pic_list_reordering
	.align	2
	.global	pred_weight_table
	.type	pred_weight_table, %function
pred_weight_table:
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
	add	r3, r0, #12288
	add	r6, r0, #20480
	mov	r10, #2208
	mov	r7, #4000
	ldr	r2, [r3, #1304]
	mov	r5, r0
	ldr	ip, [r6, #220]
	mov	r4, #1
	ldr	r3, [r3, #1300]
	ldr	r1, .L1512
	mla	r2, r10, ip, r2
	str	r2, [fp, #-48]
	ldr	r2, [r2, #28]
	mla	r7, r7, r2, r3
	bl	ue_v
	str	r0, [r6, #272]
	mov	r8, r4, asl r0
	ldr	r9, [r7, #40]
	cmp	r9, #0
	bne	.L1506
.L1483:
	cmp	r0, #7
	bhi	.L1486
	ldr	r3, [r6, #276]
	cmp	r3, #7
	bhi	.L1486
	add	r3, r5, #57344
	str	r3, [fp, #-52]
	ldr	r2, [r3, #3828]
	cmp	r2, #0
	addeq	r10, r5, #20736
	moveq	r4, r2
	addeq	r10, r10, #152
	beq	.L1494
	b	.L1485
.L1490:
	ldr	r2, [r7, #40]
	cmp	r2, #0
	bne	.L1507
.L1491:
	str	r2, [r10]
	str	r2, [r10, #768]
	str	r2, [r10, #128]
	str	r2, [r10, #896]
.L1493:
	ldr	r2, [r6, #264]
	add	r4, r4, #1
	add	r10, r10, #4
	cmp	r2, r4
	bcc	.L1508
.L1494:
	ldr	r1, .L1512+4
	mov	r0, r5
	bl	u_1
	cmp	r0, #0
	streq	r8, [r10, #-128]
	streq	r0, [r10, #640]
	beq	.L1490
	ldr	r1, .L1512+8
	mov	r0, r5
	bl	se_v
	ldr	r1, .L1512+12
	str	r0, [r10, #-128]
	mov	r0, r5
	bl	se_v
	str	r0, [r10, #640]
	ldr	r2, [r7, #40]
	cmp	r2, #0
	beq	.L1491
.L1507:
	ldr	r1, .L1512+16
	mov	r0, r5
	bl	u_1
	cmp	r0, #0
	bne	.L1509
	str	r9, [r10]
	str	r0, [r10, #768]
	str	r9, [r10, #128]
	str	r0, [r10, #896]
	b	.L1493
.L1508:
	ldr	r3, [fp, #-48]
	ldr	r3, [r3, #44]
	cmp	r3, #1
	beq	.L1495
.L1496:
	ldr	r3, [fp, #-52]
	ldr	r0, [r3, #3828]
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r0, r0, #0
.L1488:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1509:
	ldr	r1, .L1512+20
	mov	r0, r5
	bl	se_v
	ldr	r1, .L1512+24
	str	r0, [r10]
	mov	r0, r5
	bl	se_v
	ldr	r1, .L1512+20
	str	r0, [r10, #768]
	mov	r0, r5
	bl	se_v
	ldr	r1, .L1512+24
	str	r0, [r10, #128]
	mov	r0, r5
	bl	se_v
	str	r0, [r10, #896]
	b	.L1493
.L1506:
	ldr	r1, .L1512+28
	mov	r0, r5
	bl	ue_v
	mov	r3, r0
	ldr	r0, [r6, #272]
	mov	r9, r4, asl r3
	str	r3, [r6, #276]
	b	.L1483
.L1495:
	ldrb	r3, [r6, #208]
	cmp	r3, #1
	bne	.L1496
	add	r10, r5, #21248
	mov	r4, #0
	add	r10, r10, #24
	b	.L1502
.L1498:
	ldr	r3, [r7, #40]
	cmp	r3, #0
	bne	.L1510
.L1499:
	str	r3, [r10]
	str	r3, [r10, #768]
	str	r3, [r10, #128]
	str	r3, [r10, #896]
.L1501:
	ldr	r3, [r6, #268]
	add	r4, r4, #1
	add	r10, r10, #4
	cmp	r3, r4
	bcc	.L1496
.L1502:
	ldr	r1, .L1512+32
	mov	r0, r5
	bl	u_1
	cmp	r0, #0
	streq	r8, [r10, #-128]
	streq	r0, [r10, #640]
	beq	.L1498
	ldr	r1, .L1512+36
	mov	r0, r5
	bl	se_v
	ldr	r1, .L1512+40
	str	r0, [r10, #-128]
	mov	r0, r5
	bl	se_v
	str	r0, [r10, #640]
	ldr	r3, [r7, #40]
	cmp	r3, #0
	beq	.L1499
.L1510:
	ldr	r1, .L1512+44
	mov	r0, r5
	bl	u_1
	cmp	r0, #0
	bne	.L1511
	str	r9, [r10]
	str	r0, [r10, #768]
	str	r9, [r10, #128]
	str	r0, [r10, #896]
	b	.L1501
.L1486:
	add	r5, r5, #57344
	ldr	r2, [r5, #3828]
.L1485:
	ldr	r1, .L1512+48
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1488
.L1511:
	ldr	r1, .L1512+52
	mov	r0, r5
	bl	se_v
	ldr	r1, .L1512+56
	str	r0, [r10]
	mov	r0, r5
	bl	se_v
	ldr	r1, .L1512+52
	str	r0, [r10, #768]
	mov	r0, r5
	bl	se_v
	ldr	r1, .L1512+56
	str	r0, [r10, #128]
	mov	r0, r5
	bl	se_v
	str	r0, [r10, #896]
	b	.L1501
.L1513:
	.align	2
.L1512:
	.word	.LC72
	.word	.LC75
	.word	.LC76
	.word	.LC77
	.word	.LC78
	.word	.LC79
	.word	.LC80
	.word	.LC73
	.word	.LC81
	.word	.LC82
	.word	.LC83
	.word	.LC84
	.word	.LC74
	.word	.LC85
	.word	.LC86
	.fnend
	.size	pred_weight_table, .-pred_weight_table
	.align	2
	.global	DecMMCO
	.type	DecMMCO, %function
DecMMCO:
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
	mov	r9, r0
	moveq	r6, #100
	beq	.L1526
	add	r8, r0, #24576
	mov	r10, #0
	b	.L1517
.L1548:
	ldr	r1, .L1554
	mov	r0, r9
	bl	ue_v
	cmp	r4, #2
	beq	.L1546
.L1528:
	cmp	r4, #6
	orreq	r5, r5, #1
	cmp	r5, #0
	bne	.L1531
	cmp	r4, #4
	beq	.L1547
.L1532:
	cmp	r4, #6
	bhi	.L1524
.L1529:
	add	r3, r9, #57344
	ldr	r3, [r3, #3828]
	cmp	r3, #0
	bne	.L1524
	cmp	r4, #0
	beq	.L1534
.L1533:
	subs	r6, r6, #1
	beq	.L1535
.L1526:
	ldr	r1, .L1554+4
	mov	r0, r9
	bl	ue_v
	bic	r3, r0, #2
	sub	r5, r0, #3
	clz	r5, r5
	cmp	r3, #1
	mov	r4, r0
	mov	r5, r5, lsr #5
	beq	.L1548
	cmp	r4, #2
	bne	.L1528
.L1546:
	ldr	r1, .L1554+8
	mov	r0, r9
	bl	ue_v
	cmp	r5, #0
	beq	.L1529
.L1531:
	ldr	r1, .L1554+12
	mov	r0, r9
	bl	ue_v
	cmp	r4, #4
	bne	.L1532
.L1547:
	ldr	r1, .L1554+16
	mov	r0, r9
	bl	ue_v
	add	r3, r9, #57344
	ldr	r3, [r3, #3828]
	cmp	r3, #0
	beq	.L1533
.L1524:
	ldr	r1, .L1554+20
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1553:
	ldr	r1, .L1554
	mov	r0, r9
	bl	ue_v
	ldr	r2, [r4, #8]
	cmp	r2, #2
	str	r0, [r4, #12]
	beq	.L1549
.L1520:
	cmp	r2, #3
	cmpne	r2, #6
	beq	.L1550
.L1521:
	cmp	r2, #4
	beq	.L1551
.L1522:
	cmp	r2, #6
	bhi	.L1524
	add	r3, r9, #57344
	ldr	r3, [r3, #3828]
	cmp	r3, #0
	bne	.L1524
	cmp	r2, #0
	add	r10, r10, #1
	beq	.L1534
	cmp	r10, #100
	beq	.L1552
.L1517:
	ldr	r1, .L1554+4
	mov	r0, r9
	ldr	r5, [r8, #1812]
	bl	ue_v
	mov	r6, r10, asl #2
	mov	r7, r10, asl #4
	add	r4, r6, r7
	movw	r3, #2004
	mla	r4, r3, r5, r4
	add	r4, r9, r4
	add	r4, r4, #22272
	add	r4, r4, #104
	bic	r1, r0, #2
	str	r0, [r4, #8]
	cmp	r1, #1
	mov	r2, r0
	beq	.L1553
	cmp	r2, #2
	bne	.L1520
.L1549:
	ldr	r1, .L1554+8
	mov	r0, r9
	bl	ue_v
	add	r3, r6, r7
	movw	r2, #2004
	mla	r3, r2, r5, r3
	add	r3, r9, r3
	add	r2, r3, #22272
	str	r0, [r2, #120]
	ldr	r2, [r2, #112]
	cmp	r2, #3
	cmpne	r2, #6
	bne	.L1521
.L1550:
	ldr	r1, .L1554+12
	mov	r0, r9
	bl	ue_v
	add	r3, r6, r7
	movw	r2, #2004
	mla	r3, r2, r5, r3
	add	r3, r9, r3
	add	r2, r3, #22272
	str	r0, [r2, #124]
	ldr	r2, [r2, #112]
	cmp	r2, #4
	bne	.L1522
.L1551:
	ldr	r1, .L1554+16
	mov	r0, r9
	bl	ue_v
	add	r6, r6, r7
	movw	r7, #2004
	mla	r5, r7, r5, r6
	add	r5, r9, r5
	add	r3, r5, #22272
	add	r5, r3, #104
	ldr	r2, [r3, #112]
	str	r0, [r3, #128]
	b	.L1522
.L1534:
	mov	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1552:
	ldr	r1, .L1554+24
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1535:
	mvn	r0, #0
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1555:
	.align	2
.L1554:
	.word	.LC89
	.word	.LC88
	.word	.LC90
	.word	.LC91
	.word	.LC92
	.word	.LC93
	.word	.LC87
	.fnend
	.size	DecMMCO, .-DecMMCO
	.align	2
	.global	dec_ref_pic_marking
	.type	dec_ref_pic_marking, %function
dec_ref_pic_marking:
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
	add	r3, r0, #20480
	add	r6, r0, #24576
	mov	r5, r0
	ldrb	r8, [r3, #213]
	ldr	r7, [r6, #1812]
	cmp	r8, #0
	beq	.L1557
	clz	r4, r7
	mov	r4, r4, lsr #5
	str	r4, [r6, #1812]
	ldrb	r3, [r3, #211]
	cmp	r3, #5
	beq	.L1575
.L1558:
	ldr	r1, .L1580
	mov	r0, r5
	bl	u_1
	movw	r1, #2004
	mla	r4, r1, r4, r5
	ldr	r1, .L1580+4
	add	r4, r4, #22272
	add	r4, r4, #104
	mov	r3, r0
	uxtb	r2, r0
	strb	r3, [r4, #7]
	mov	r0, #16
	bl	dprint_vfmw
	ldrb	r3, [r4, #7]
	cmp	r3, #0
	bne	.L1560
.L1564:
	mov	r8, #0
.L1572:
	mov	r0, r8
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L1557:
	movw	r4, #2004
	mla	r4, r4, r7, r0
	add	r4, r4, #22272
	add	r4, r4, #104
	ldrb	r2, [r4, #4]
	cmp	r2, #0
	bne	.L1576
	ldrb	r3, [r3, #211]
	mov	r4, r7
	cmp	r3, #5
	bne	.L1558
.L1575:
	ldr	r1, .L1580+8
	mov	r0, r5
	bl	u_1
	movw	r3, #2004
	mla	r4, r3, r4, r5
	ldr	r1, .L1580+12
	mov	r8, #0
	add	r4, r4, #22272
	strb	r0, [r4, #109]
	mov	r0, r5
	bl	u_1
	ldrb	r2, [r4, #109]
	ldr	r1, .L1580+16
	strb	r0, [r4, #110]
	mov	r0, #16
	bl	dprint_vfmw
	mov	r0, r8
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L1576:
	ldrb	r3, [r3, #211]
	cmp	r3, #5
	beq	.L1577
	ldr	r1, .L1580
	ldrb	r6, [r4, #7]
	bl	u_1
	cmp	r6, r0
	bne	.L1578
	ldrb	r3, [r4, #7]
	cmp	r3, #0
	beq	.L1564
	mov	r1, r8
	mov	r0, r5
	bl	DecMMCO
	mov	r8, r0
	b	.L1572
.L1560:
	mov	r0, r5
	mov	r1, #1
	bl	DecMMCO
	cmn	r0, #1
	mov	r8, r0
	movne	r3, #1
	movne	r8, #0
	strneb	r3, [r4, #4]
	bne	.L1572
	mov	r3, #0
	ldr	r1, .L1580+20
	strb	r3, [r4, #4]
	mov	r0, #1
	str	r7, [r6, #1812]
	bl	dprint_vfmw
	b	.L1572
.L1577:
	ldr	r1, .L1580+8
	ldrb	r6, [r4, #5]
	bl	u_1
	cmp	r6, r0
	bne	.L1579
	mov	r0, r5
	ldr	r1, .L1580+12
	ldrb	r4, [r4, #6]
	bl	u_1
	cmp	r4, r0
	beq	.L1564
	ldr	r1, .L1580+24
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1572
.L1578:
	add	r5, r5, #57344
	ldr	r1, .L1580+28
	mov	r0, #1
	mvn	r8, #0
	bl	dprint_vfmw
	ldr	ip, [r5, #3832]
	ldr	r3, [r5, #3868]
	mov	r0, #1
	ldr	r2, [r5, #3852]
	ldr	r1, .L1580+32
	str	ip, [sp]
	bl	dprint_vfmw
	b	.L1572
.L1579:
	ldr	r1, .L1580+36
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1572
.L1581:
	.align	2
.L1580:
	.word	.LC97
	.word	.LC98
	.word	.LC94
	.word	.LC95
	.word	.LC96
	.word	.LC99
	.word	.LC101
	.word	.LC102
	.word	.LC103
	.word	.LC100
	.fnend
	.size	dec_ref_pic_marking, .-dec_ref_pic_marking
	.align	2
	.global	ProcessSliceHeaderFirstPart
	.type	ProcessSliceHeaderFirstPart, %function
ProcessSliceHeaderFirstPart:
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
	ldr	r1, .L1656
	add	r5, r0, #12288
	mov	r6, r0
	bl	ue_v
	ldr	r3, [r5, #1292]
	sub	r3, r3, #1
	cmp	r0, r3
	mov	r10, r0
	bhi	.L1583
	add	r9, r6, #57344
	ldr	r3, [r9, #3828]
	cmp	r3, #0
	bne	.L1583
	mov	r1, r0
	mov	r0, r6
	bl	PPSSPSCheckTmpId
	subs	r8, r0, #0
	bne	.L1647
	add	r4, r6, #20480
	mov	r7, #2208
	mov	r1, #4000
	str	r10, [r4, #220]
	ldr	r2, [r5, #1304]
	ldrb	r0, [r4, #211]
	ldr	r3, [r5, #1300]
	mla	r7, r7, r10, r2
	cmp	r0, #5
	ldr	r2, [r7, #28]
	mla	r5, r1, r2, r3
	beq	.L1587
	ldr	r3, [r5, #3244]
	cmp	r3, #0
	beq	.L1587
.L1588:
	ldr	r1, [r5, #2196]
	mov	r0, r6
	ldr	r2, .L1656+4
	add	r1, r1, #4
	bl	u_v
	str	r0, [r4, #228]
	ldr	r3, [r9, #3828]
	cmp	r3, #0
	bne	.L1645
	ldrb	r3, [r4, #211]
	cmp	r3, #5
	beq	.L1648
.L1591:
	mov	r3, #0
	strb	r3, [r4, #209]
	strb	r3, [r4, #210]
	ldrb	r3, [r5, #18]
	cmp	r3, #0
	beq	.L1649
	ldr	r2, [r5, #3248]
	ldr	r1, [r5, #3252]
	add	r3, r2, #1
	mla	r3, r1, r3, r3
.L1615:
	ldrb	r2, [r5, #19]
	cmp	r2, #0
	bne	.L1598
	strb	r2, [r4, #212]
.L1600:
	ldr	r2, [r4, #260]
	cmp	r2, r3
	bcs	.L1650
.L1601:
	ldrb	r3, [r4, #211]
	cmp	r3, #5
	beq	.L1651
.L1603:
	add	r10, r6, #16384
	mov	r3, #0
	str	r3, [r10, #3420]
	str	r3, [r10, #3424]
	ldr	r3, [r5, #2200]
	cmp	r3, #0
	beq	.L1652
.L1607:
	mov	r3, #0
	str	r3, [r10, #3468]
	str	r3, [r10, #3472]
	ldr	r3, [r5, #2200]
	cmp	r3, #1
	beq	.L1653
.L1610:
	ldr	r3, [r9, #3828]
	cmp	r3, #0
	bne	.L1645
	ldrb	r3, [r7, #17]
	cmp	r3, #0
	beq	.L1613
	ldr	r1, .L1656+8
	mov	r0, r6
	bl	ue_v
	cmp	r0, #0
	bne	.L1614
	ldr	r3, [r9, #3828]
	cmp	r3, #0
	bne	.L1614
.L1613:
	mov	r0, r6
	bl	IsNewPic
	uxtb	r0, r0
	strb	r0, [r4, #213]
	cmp	r0, #0
	bne	.L1627
	ldr	r2, [r4, #260]
	ldr	r3, [r4, #1896]
	cmp	r2, r3
	bls	.L1654
.L1627:
	mov	r0, r8
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1587:
	ldrb	r3, [r4, #208]
	cmp	r3, #2
	beq	.L1588
	ldr	r1, .L1656+12
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1627
.L1598:
	mov	r2, #1
	strb	r2, [r4, #212]
.L1618:
	ldr	r2, [r4, #260]
	cmp	r2, r3, lsr #1
	bcc	.L1601
	ldr	r1, .L1656+16
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1627
.L1614:
	ldr	r1, .L1656+20
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L1656+24
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L1645
	mov	r3, #0
	ldr	r0, [r9, #3888]
	mov	r2, r3
	mov	r1, #102
	blx	ip
.L1645:
	mvn	r8, #0
	mov	r0, r8
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1649:
	ldr	r1, .L1656+28
	mov	r0, r6
	bl	u_1
	uxtb	r0, r0
	strb	r0, [r4, #209]
	cmp	r0, #0
	bne	.L1655
	ldr	r2, [r5, #3248]
	ldrb	ip, [r5, #18]
	ldr	r1, [r5, #3252]
	add	r3, r2, #1
	cmp	ip, #0
	mla	r3, r1, r3, r3
	bne	.L1617
	mov	r3, r3, asl #1
	b	.L1615
.L1652:
	ldr	r1, [r5, #2204]
	mov	r0, r6
	ldr	r2, .L1656+32
	add	r1, r1, #4
	bl	u_v
	str	r0, [r10, #3420]
	ldrb	r3, [r7, #1]
	cmp	r3, #0
	beq	.L1607
	ldrb	r3, [r4, #209]
	cmp	r3, #0
	bne	.L1607
	ldr	r1, .L1656+36
	mov	r0, r6
	bl	se_v
	str	r0, [r10, #3424]
	b	.L1607
.L1648:
	cmp	r0, #0
	str	r0, [r4, #224]
	beq	.L1591
	ldr	r1, .L1656+40
	mov	r0, #1
	bl	dprint_vfmw
	b	.L1591
.L1653:
	ldrb	r3, [r5, #16]
	cmp	r3, #0
	bne	.L1610
	ldr	r1, .L1656+44
	mov	r0, r6
	bl	se_v
	str	r0, [r10, #3468]
	ldrb	r3, [r7, #1]
	cmp	r3, #1
	bne	.L1610
	ldrb	r3, [r4, #209]
	cmp	r3, #0
	bne	.L1610
	ldr	r1, .L1656+48
	mov	r0, r6
	bl	se_v
	str	r0, [r10, #3472]
	b	.L1610
.L1655:
	ldr	r1, .L1656+52
	mov	r0, r6
	bl	u_1
	strb	r0, [r4, #210]
	ldr	r2, [r5, #3248]
	ldrb	r0, [r5, #18]
	ldr	r1, [r5, #3252]
	add	r3, r2, #1
	cmp	r0, #0
	ldrb	r0, [r4, #209]
	mla	r3, r1, r3, r3
	moveq	r2, #2
	beq	.L1596
.L1617:
	mov	r2, #1
.L1596:
	cmp	r0, #0
	mul	r3, r2, r3
	beq	.L1615
	cmp	r0, #1
	mov	r2, #0
	strb	r2, [r4, #212]
	bne	.L1600
	b	.L1618
.L1651:
	ldr	r1, .L1656+56
	mov	r0, r6
	bl	ue_v
	cmp	r0, #65536
	str	r0, [r4, #248]
	bcs	.L1604
	ldr	r3, [r9, #3828]
	cmp	r3, #0
	beq	.L1603
.L1604:
	ldr	r1, .L1656+60
	mov	r0, #1
	bl	dprint_vfmw
	b	.L1603
.L1583:
	mov	r2, r10
	ldr	r1, .L1656+64
	mvn	r8, #0
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r8
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1647:
	ldr	r1, .L1656+68
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1627
.L1650:
	ldr	r1, .L1656+72
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1627
.L1654:
	ldr	r1, .L1656+76
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r8, #0
	b	.L1627
.L1657:
	.align	2
.L1656:
	.word	.LC104
	.word	.LC108
	.word	.LC120
	.word	.LC107
	.word	.LC112
	.word	.LC121
	.word	g_event_report
	.word	.LC110
	.word	.LC116
	.word	.LC117
	.word	.LC109
	.word	.LC118
	.word	.LC119
	.word	.LC111
	.word	.LC114
	.word	.LC115
	.word	.LC105
	.word	.LC106
	.word	.LC113
	.word	.LC122
	.fnend
	.size	ProcessSliceHeaderFirstPart, .-ProcessSliceHeaderFirstPart
	.align	2
	.global	ProcessSliceHeaderSecondPart
	.type	ProcessSliceHeaderSecondPart, %function
ProcessSliceHeaderSecondPart:
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
	add	r6, r0, #12288
	add	r4, r0, #20480
	mov	r5, r0
	ldr	r3, [r6, #1292]
	ldr	r2, [r4, #220]
	sub	r3, r3, #1
	cmp	r3, r2
	bcc	.L1659
	add	r8, r0, #57344
	ldr	r3, [r8, #3828]
	cmp	r3, #0
	bne	.L1659
	bl	PPSSPSCheck
	cmp	r0, #0
	bne	.L1741
	ldr	r2, [r4, #220]
	mov	r7, #2208
	ldrb	r3, [r4, #208]
	ldr	r9, [r6, #1304]
	mul	r7, r7, r2
	cmp	r3, #1
	add	r6, r9, r7
	beq	.L1742
.L1663:
	ldr	r2, [r6, #36]
	cmp	r3, #1
	str	r2, [r4, #264]
	ldr	r2, [r6, #40]
	str	r2, [r4, #268]
	bls	.L1743
	cmp	r3, #2
	beq	.L1690
.L1674:
	mov	r3, #32
	str	r3, [r4, #268]
.L1675:
	mov	r0, r5
	bl	ref_pic_list_reordering
	subs	r10, r0, #0
	bne	.L1744
	ldrb	r3, [r6, #2]
	cmp	r3, #0
	beq	.L1677
	ldrb	r3, [r4, #208]
	cmp	r3, #0
	moveq	r2, #1
	moveq	r3, r2
	beq	.L1678
.L1677:
	ldr	r3, [r6, #44]
	cmp	r3, #1
	beq	.L1745
.L1694:
	mov	r2, #0
	mov	r3, r2
.L1678:
	strb	r3, [r4, #215]
	mov	r0, #19
	ldr	r1, .L1751
	bl	dprint_vfmw
	ldrb	r2, [r4, #215]
	mov	r3, #0
	str	r3, [r4, #272]
	cmp	r2, r3
	str	r3, [r4, #276]
	bne	.L1746
.L1679:
	ldr	r3, [r4, #240]
	cmp	r3, #0
	bne	.L1747
.L1680:
	mov	r3, #0
	str	r3, [r4, #1816]
	ldrb	r3, [r9, r7]
	cmp	r3, #0
	beq	.L1681
	ldrb	r3, [r4, #208]
	cmp	r3, #1
	bls	.L1748
.L1681:
	ldr	r1, .L1751+4
	mov	r0, r5
	bl	se_v
	mov	r3, #0
	str	r3, [r4, #1824]
	str	r3, [r4, #1828]
	str	r3, [r4, #1832]
	str	r0, [r4, #1820]
	ldrb	r3, [r6, #3]
	cmp	r3, #0
	bne	.L1749
.L1710:
	mov	r0, r10
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1690:
	mov	r3, #32
	str	r3, [r4, #264]
	b	.L1674
.L1749:
	ldr	r1, .L1751+8
	mov	r0, r5
	bl	ue_v
	cmp	r0, #2
	str	r0, [r4, #1824]
	bhi	.L1684
	ldr	r3, [r8, #3828]
	cmp	r3, #0
	bne	.L1684
	cmp	r0, #1
	beq	.L1710
	ldr	r1, .L1751+12
	mov	r0, r5
	bl	se_v
	add	r3, r0, #6
	str	r0, [r4, #1828]
	cmp	r3, #12
	bhi	.L1687
	ldr	r3, [r8, #3828]
	cmp	r3, #0
	bne	.L1687
	mov	r0, r5
	ldr	r1, .L1751+16
	bl	se_v
	add	r3, r0, #6
	str	r0, [r4, #1832]
	cmp	r3, #12
	bhi	.L1689
	ldr	r3, [r8, #3828]
	cmp	r3, #0
	beq	.L1710
.L1689:
	ldr	r1, .L1751+20
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r10, #0
	b	.L1710
.L1746:
	mov	r0, r5
	bl	pred_weight_table
	cmp	r0, #0
	beq	.L1679
	ldr	r1, .L1751+24
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r10, #0
	b	.L1710
.L1747:
	mov	r0, r5
	bl	dec_ref_pic_marking
	cmp	r0, #0
	beq	.L1680
	ldr	r1, .L1751+28
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r10, #0
	b	.L1710
.L1745:
	ldrb	r3, [r4, #208]
	cmp	r3, #1
	moveq	r2, r3
	bne	.L1694
	b	.L1678
.L1742:
	ldr	r1, .L1751+32
	mov	r0, r5
	bl	u_1
	ldrb	r3, [r4, #208]
	strb	r0, [r4, #214]
	b	.L1663
.L1743:
	ldr	r1, .L1751+36
	mov	r0, r5
	bl	u_1
	cmp	r0, #0
	bne	.L1665
	ldr	r3, [r4, #264]
.L1666:
	ldrb	r2, [r4, #209]
	cmp	r2, #0
	bne	.L1667
	cmp	r3, #15
	bhi	.L1668
	ldr	r3, [r4, #268]
	cmp	r3, #15
	bhi	.L1750
.L1669:
	ldr	r3, [r8, #3828]
	cmp	r3, #0
	bne	.L1668
.L1670:
	ldrb	r3, [r4, #208]
	cmp	r3, #2
	beq	.L1690
	cmp	r3, #1
	bne	.L1674
	b	.L1675
.L1659:
	ldr	r1, .L1751+40
	mvn	r10, #0
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r10
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1748:
	ldr	r1, .L1751+44
	mov	r0, r5
	bl	ue_v
	cmp	r0, #2
	str	r0, [r4, #1816]
	bhi	.L1682
	ldr	r3, [r8, #3828]
	cmp	r3, #0
	beq	.L1681
.L1682:
	ldr	r1, .L1751+48
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r10, #0
	b	.L1710
.L1667:
	cmp	r3, #31
	bhi	.L1671
	ldr	r3, [r4, #268]
	cmp	r3, #31
	bls	.L1672
	ldrb	r3, [r4, #208]
	cmp	r3, #1
	bne	.L1672
.L1671:
	ldr	r1, .L1751+52
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r10, #0
	b	.L1710
.L1672:
	ldr	r3, [r8, #3828]
	cmp	r3, #0
	beq	.L1670
	b	.L1671
.L1750:
	ldrb	r3, [r4, #208]
	cmp	r3, #1
	bne	.L1669
.L1668:
	ldr	r1, .L1751+56
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r10, #0
	b	.L1710
.L1665:
	ldr	r1, .L1751+60
	mov	r0, r5
	bl	ue_v
	ldrb	r2, [r4, #208]
	cmp	r2, #1
	mov	r3, r0
	str	r0, [r4, #264]
	bne	.L1666
	ldr	r1, .L1751+64
	mov	r0, r5
	bl	ue_v
	ldr	r3, [r4, #264]
	str	r0, [r4, #268]
	b	.L1666
.L1687:
	ldr	r1, .L1751+68
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r10, #0
	b	.L1710
.L1684:
	ldr	r1, .L1751+72
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r10, #0
	b	.L1710
.L1741:
	ldr	r1, .L1751+76
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r10, #0
	b	.L1710
.L1744:
	ldr	r1, .L1751+80
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r10, #0
	b	.L1710
.L1752:
	.align	2
.L1751:
	.word	.LC130
	.word	.LC135
	.word	.LC136
	.word	.LC138
	.word	.LC140
	.word	.LC141
	.word	.LC131
	.word	.LC132
	.word	.LC123
	.word	.LC124
	.word	.LC105
	.word	.LC133
	.word	.LC134
	.word	.LC128
	.word	.LC127
	.word	.LC125
	.word	.LC126
	.word	.LC139
	.word	.LC137
	.word	.LC106
	.word	.LC129
	.fnend
	.size	ProcessSliceHeaderSecondPart, .-ProcessSliceHeaderSecondPart
	.align	2
	.global	ExitSlice
	.type	ExitSlice, %function
ExitSlice:
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
	add	r3, r0, #20480
	add	lr, r0, #12288
	mov	r1, #2208
	ldr	ip, [r3, #220]
	mov	r7, #4000
	ldr	r2, [lr, #1304]
	ldr	r5, [lr, #1300]
	ldrb	r6, [r3, #209]
	mla	r1, r1, ip, r2
	cmp	r6, #0
	ldr	r4, [r3, #260]
	ldr	lr, [r3, #228]
	ldr	r2, [r1, #28]
	str	ip, [r3, #1864]
	ldr	ip, [r3, #240]
	mla	r2, r7, r2, r5
	ldr	r1, [r2, #36]
	str	r4, [r3, #1896]
	str	lr, [r3, #1872]
	str	r1, [r3, #1860]
	ldrneb	r1, [r3, #210]
	strb	r6, [r3, #1856]
	str	ip, [r3, #1868]
	strneb	r1, [r3, #1857]
	ldrb	r1, [r3, #211]
	cmp	r1, #5
	strb	r1, [r3, #1858]
	ldreq	r1, [r3, #248]
	streq	r1, [r3, #1876]
	ldr	r1, [r2, #2200]
	cmp	r1, #0
	bne	.L1756
	add	r1, r0, #16384
	ldr	ip, [r1, #3420]
	str	ip, [r3, #1880]
	ldr	r1, [r1, #3424]
	str	r1, [r3, #1884]
	ldr	r1, [r2, #2200]
.L1756:
	cmp	r1, #1
	addeq	r2, r0, #16384
	add	r0, r0, #57344
	ldreq	r1, [r2, #3468]
	streq	r1, [r3, #1888]
	ldreq	r2, [r2, #3472]
	streq	r2, [r3, #1892]
	ldr	r3, [r0, #3844]
	add	r3, r3, #1
	str	r3, [r0, #3844]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	ExitSlice, .-ExitSlice
	.align	2
	.global	PicTypeStatistic
	.type	PicTypeStatistic, %function
PicTypeStatistic:
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
	add	r2, r0, #20480
	ldrb	r3, [r2, #208]
	cmp	r3, #1
	beq	.L1763
	bcc	.L1764
	cmp	r3, #2
	ldmnefd	sp, {fp, sp, pc}
	ldrb	r3, [r2, #211]
	add	r0, r0, #57344
	cmp	r3, #5
	beq	.L1773
.L1766:
	mov	r3, #0
	str	r3, [r0, #1104]
	ldmfd	sp, {fp, sp, pc}
.L1764:
	add	r0, r0, #57344
	ldr	r3, [r0, #1100]
	cmp	r3, #2
	movne	r3, #1
	strne	r3, [r0, #1100]
	b	.L1766
.L1763:
	add	r0, r0, #57344
	mov	r2, #2
	mov	r3, #0
	str	r2, [r0, #1100]
	str	r3, [r0, #1104]
	ldmfd	sp, {fp, sp, pc}
.L1773:
	mov	r3, #1
	str	r3, [r0, #1104]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	PicTypeStatistic, .-PicTypeStatistic
	.align	2
	.global	CalcStreamBits
	.type	CalcStreamBits, %function
CalcStreamBits:
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
	add	r3, r0, #16384
	mov	r4, r0
	ldrb	r3, [r3, #1212]
	cmp	r3, #0
	beq	.L1775
	ldr	r2, [r0, #368]
	ldr	r3, [r2, #64]
	add	r3, r3, #7
	bic	r3, r3, #7
	str	r3, [r2, #64]
	ldr	r2, [r0, #368]
	ldr	r3, [r2, #72]
	sub	r3, r3, #1
	str	r3, [r2, #72]
.L1775:
	ldr	r3, [r4, #368]
	ldrb	r6, [r3]
	cmp	r6, #0
	beq	.L1786
	mov	r1, #0
	mov	r0, r3
	mov	r5, r1
.L1777:
	add	r1, r1, #1
	ldr	ip, [r0, #12]
	cmp	r1, r6
	add	r0, r0, #28
	add	r5, r5, ip
	bne	.L1777
.L1776:
	mov	r7, r6, asl #5
	ldr	r0, [r3, #72]
	sub	r7, r7, r6, asl #2
	ldr	r2, [r3, #64]
	add	r1, r3, r7
	mov	r3, r5
	str	r0, [sp, #4]
	mov	r0, #7
	ldr	ip, [r1, #12]
	ldr	r1, .L1797
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	r3, [r4, #368]
	mov	r2, r6
	mov	r0, #7
	ldr	r1, .L1797+4
	ldrb	r6, [r3]
	ldr	ip, [r3, #64]
	mov	lr, r6, asl #5
	and	ip, ip, r0
	sub	lr, lr, r6, asl #2
	add	r3, r3, lr
	str	ip, [r3, #24]
	ldr	r3, [r4, #368]
	ldrb	r6, [r3]
	ldr	r8, [r3, #64]
	mov	lr, r6, asl #5
	sub	lr, lr, r6, asl #2
	add	r3, r3, lr
	ldr	ip, [r3, #16]
	add	ip, ip, r8, lsr #3
	rsb	ip, r5, ip
	str	ip, [r3, #28]
	ldr	ip, [r4, #368]
	ldrb	r6, [ip]
	ldr	lr, [ip, #64]
	mov	r3, r6, asl #5
	sub	r3, r3, r6, asl #2
	add	ip, ip, r3
	ldr	r3, [ip, #12]
	add	r3, r5, r3
	rsb	r3, lr, r3, lsl #3
	str	r3, [ip, #20]
	ldr	ip, [r4, #368]
	ldrb	lr, [ip]
	mov	r3, lr, asl #5
	sub	r3, r3, lr, asl #2
	add	r3, ip, r3
	ldr	ip, [r3, #28]
	ldr	lr, [r3, #24]
	and	ip, ip, #3
	add	ip, lr, ip, lsl #3
	str	ip, [r3, #24]
	ldr	ip, [r4, #368]
	ldrb	lr, [ip]
	mov	r3, lr, asl #5
	sub	r3, r3, lr, asl #2
	add	r3, ip, r3
	ldr	ip, [r3, #28]
	bic	ip, ip, #3
	str	ip, [r3, #28]
	ldr	ip, [r4, #368]
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
	ldr	ip, [r4, #368]
	ldr	r2, [ip, #68]
	sub	r3, r2, #1
	cmp	r3, #1
	bhi	.L1796
	ldrb	r6, [ip]
	add	r1, r6, #1
	cmp	r2, r1
	movhi	r2, #1
	movls	r2, #0
	cmp	r1, #1
	movhi	r2, #0
	cmp	r2, #0
	beq	.L1780
	add	r6, r6, #2
	mov	r5, #0
.L1781:
	sub	r3, r6, #1
	ldr	r1, .L1797+8
	mov	r0, #7
	mov	lr, r3, asl #5
	mov	r2, r3
	sub	r3, lr, r3, asl #2
	add	ip, ip, r3
	str	r5, [ip, #24]
	ldr	ip, [r4, #368]
	add	ip, ip, r3
	ldr	lr, [ip, #16]
	str	lr, [ip, #28]
	ldr	ip, [r4, #368]
	add	ip, ip, r3
	ldr	lr, [ip, #12]
	mov	lr, lr, asl #3
	str	lr, [ip, #20]
	ldr	ip, [r4, #368]
	add	ip, ip, r3
	ldr	lr, [ip, #28]
	ldr	r7, [ip, #24]
	and	lr, lr, #3
	add	lr, r7, lr, lsl #3
	str	lr, [ip, #24]
	ldr	ip, [r4, #368]
	add	ip, ip, r3
	ldr	lr, [ip, #28]
	bic	lr, lr, #3
	str	lr, [ip, #28]
	ldr	ip, [r4, #368]
	add	ip, ip, r3
	ldr	r3, [ip, #24]
	ldr	ip, [ip, #20]
	str	ip, [sp]
	bl	dprint_vfmw
	ldr	ip, [r4, #368]
	ldr	r3, [ip, #68]
	cmp	r6, #1
	cmpls	r6, r3
	add	r6, r6, #1
	movcc	r2, #1
	movcs	r2, #0
	cmp	r2, #0
	bne	.L1781
	sub	r3, r3, #1
.L1780:
	mov	r2, r3, asl #5
	ldr	r1, [ip, #72]
	sub	r3, r2, r3, asl #2
	add	ip, ip, r3
	ldr	r3, [ip, #20]
	rsb	r3, r1, r3
	str	r3, [ip, #20]
	ldr	ip, [r4, #368]
	ldrb	r1, [ip]
	ldr	r3, [ip, #68]
	cmp	r1, r3
	bcs	.L1774
	sxth	r3, r1
	add	r4, r4, #57344
	mov	r2, r3, asl #5
	sub	r3, r2, r3, asl #2
	add	r3, ip, r3
.L1784:
	ldr	r2, [r3, #28]
	add	r1, r1, #1
	ldr	r0, [r4, #1128]
	add	r3, r3, #28
	cmp	r2, r0
	strcc	r2, [r4, #1128]
	ldr	r2, [ip, #68]
	cmp	r2, r1
	bhi	.L1784
.L1774:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L1796:
	ldr	r1, .L1797+12
	mov	r0, #0
	bl	dprint_vfmw
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L1786:
	mov	r5, r6
	b	.L1776
.L1798:
	.align	2
.L1797:
	.word	.LC142
	.word	.LC143
	.word	.LC145
	.word	.LC144
	.fnend
	.size	CalcStreamBits, .-CalcStreamBits
	.align	2
	.global	Scaling_List
	.type	Scaling_List, %function
Scaling_List:
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
	ble	.L1799
	mov	r3, r7
	mov	r1, #8
	mov	r6, r9
	ldr	r8, .L1810
	mov	r5, r1
	mov	r4, #0
	mov	r10, #255
	mov	r7, r2
	mov	r9, r3
	b	.L1804
.L1803:
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
	beq	.L1799
.L1804:
	cmp	r9, #16
	ldreq	r3, .L1810+4
	ldrneb	ip, [r4, r8]
	ldreqb	ip, [r4, r3]
	cmp	r1, #0
	add	r4, r4, #1
	beq	.L1803
	ldr	r1, .L1810+8
	ldr	r0, [fp, #-52]
	str	ip, [fp, #-48]
	bl	se_v
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
	b	.L1803
.L1799:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1811:
	.align	2
.L1810:
	.word	.LANCHOR1+16
	.word	.LANCHOR1
	.word	.LC146
	.fnend
	.size	Scaling_List, .-Scaling_List
	.align	2
	.global	ProcessPPS
	.type	ProcessPPS, %function
ProcessPPS:
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
	mov	r4, r1
	ldr	r1, .L1870
	mov	r5, r0
	bl	u_1
	add	r6, r5, #57344
	strb	r0, [r4]
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L1861
	ldr	r1, .L1870+4
	mov	r0, r5
	bl	u_1
	strb	r0, [r4, #1]
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L1861
	ldr	r1, .L1870+8
	mov	r0, r5
	bl	ue_v
	cmp	r0, #0
	str	r0, [r4, #32]
	bne	.L1816
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	beq	.L1817
.L1816:
	ldr	r1, .L1870+12
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L1870+16
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L1861
	mov	r3, #0
	ldr	r0, [r6, #3888]
	mov	r2, r3
	mov	r1, #102
	blx	ip
	mvn	r0, #0
.L1814:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1824:
	ldr	r1, .L1870+20
	mov	r0, r5
	bl	u_1
	ldr	r1, .L1870+24
	str	r0, [r4, #60]
	mov	r0, r5
	bl	u_1
	uxtb	r0, r0
	strb	r0, [r4, #18]
	cmp	r0, #1
	beq	.L1825
.L1843:
	mov	r0, r5
	ldr	r1, .L1870+28
	bl	se_v
	add	r3, r0, #12
	str	r0, [r4, #56]
	cmp	r3, #24
	bhi	.L1826
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	beq	.L1844
.L1826:
	ldr	r1, .L1870+32
	mov	r0, #1
	bl	dprint_vfmw
.L1861:
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1817:
	ldr	r1, .L1870+36
	mov	r0, r5
	bl	ue_v
	cmp	r0, #31
	str	r0, [r4, #36]
	bhi	.L1818
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L1818
	ldr	r1, .L1870+40
	mov	r0, r5
	bl	ue_v
	cmp	r0, #31
	str	r0, [r4, #40]
	bhi	.L1820
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L1820
	ldr	r1, .L1870+44
	mov	r0, r5
	bl	u_1
	strb	r0, [r4, #2]
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L1861
	ldr	r2, .L1870+48
	mov	r1, #2
	mov	r0, r5
	bl	u_v
	cmp	r0, #2
	str	r0, [r4, #44]
	bhi	.L1862
	ldr	r1, .L1870+52
	mov	r0, r5
	bl	se_v
	ldr	r1, .L1870+56
	str	r0, [r4, #48]
	mov	r0, r5
	bl	se_v
	ldr	r1, .L1870+60
	mov	r0, r5
	bl	se_v
	ldr	r1, .L1870+64
	str	r0, [r4, #52]
	mov	r0, r5
	bl	u_1
	ldr	r1, .L1870+68
	strb	r0, [r4, #3]
	mov	r0, r5
	bl	u_1
	ldr	r1, .L1870+72
	strb	r0, [r4, #4]
	mov	r0, r5
	bl	u_1
	uxtb	r0, r0
	strb	r0, [r4, #17]
	cmp	r0, #0
	bne	.L1863
.L1823:
	ldr	r3, [r4, #52]
	add	r0, r5, #13504
	mov	r7, #0
	add	r0, r0, #24
	str	r7, [r4, #60]
	str	r3, [r4, #56]
	strb	r7, [r4, #18]
	bl	BsResidBits
	ldr	r3, [r5, #368]
	ldr	r3, [r3, #72]
	add	r3, r3, #3
	cmp	r0, r3
	bcs	.L1824
.L1844:
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1863:
	ldr	r1, .L1870+76
	mov	r0, #1
	bl	dprint_vfmw
	b	.L1823
.L1818:
	ldr	r1, .L1870+80
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1814
.L1820:
	ldr	r1, .L1870+84
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1814
.L1825:
	add	r3, r4, #4
	str	r6, [fp, #-80]
	sub	r9, fp, #72
	add	r8, r4, #1984
	add	r10, r4, #64
	mov	r6, r3
	b	.L1834
.L1867:
	ldr	lr, [lr, #1300]
	ldr	r3, [r4, #28]
	mla	r3, ip, r3, lr
	ldrb	ip, [r3, #25]
	cmp	ip, #1
	beq	.L1864
	ldr	r3, .L1870+88
	cmp	r1, #0
	add	ip, r3, #16
	moveq	r3, ip
	mov	r1, r3
	ldr	r3, .L1870+92
	ldr	r3, [r3, #52]
	blx	r3
.L1829:
	add	r7, r7, #1
	add	r8, r8, #16
	cmp	r7, #6
	add	r10, r10, #64
	beq	.L1865
.L1834:
	ldr	r1, .L1870+96
	mov	r0, r5
	bl	u_1
	clz	r1, r7
	add	lr, r5, #12288
	mov	ip, #4000
	mov	r2, #16
	mov	r1, r1, lsr #5
	cmp	r0, #1
	mov	r3, r0
	mov	r0, r8
	str	r3, [r9, #4]!
	strb	r3, [r6, #1]!
	beq	.L1866
	cmp	r7, #0
	cmpne	r7, #3
	beq	.L1867
	ldr	r3, .L1870+92
	mov	r2, #16
	sub	r1, r8, #16
	mov	r0, r8
	ldr	r3, [r3, #52]
	blx	r3
	b	.L1829
.L1865:
	ldr	r6, [fp, #-80]
	add	ip, r4, #448
	add	r3, r5, #12288
	sub	r8, fp, #76
	add	r9, r4, #2080
	add	r10, r4, #11
	str	r5, [fp, #-80]
	mov	r7, #0
	str	r6, [fp, #-84]
	mov	r5, r3
	mov	r6, r4
	mov	r4, ip
.L1842:
	ldr	r2, [r6, #60]
	mov	r3, #0
	cmp	r2, #1
	strne	r3, [r8]
	strneb	r3, [r10]
	beq	.L1868
.L1837:
	ldr	r1, [r6, #28]
	mov	lr, #4000
	ldr	r3, [r5, #1300]
	mov	r0, r9
	mov	r2, #64
	mla	r3, lr, r1, r3
	ldrb	r1, [r3, #25]
	cmp	r1, #1
	beq	.L1869
	ldr	r1, .L1870+100
	cmp	r7, #0
	ldr	r3, .L1870+92
	add	ip, r1, #64
	ldr	r3, [r3, #52]
	movne	r1, ip
	blx	r3
.L1838:
	add	r7, r7, #1
	add	r9, r9, #64
	cmp	r7, #2
	add	r4, r4, #256
	add	r8, r8, #4
	add	r10, r10, #1
	bne	.L1842
	mov	r4, r6
	ldr	r5, [fp, #-80]
	ldr	r6, [fp, #-84]
	b	.L1843
.L1866:
	mov	r3, r2
	str	r9, [sp]
	mov	r2, r8
	mov	r1, r10
	mov	r0, r5
	bl	Scaling_List
	ldr	r3, [r9]
	cmp	r3, #1
	bne	.L1829
	ldr	r1, .L1870+88
	mov	r2, #16
	ldr	r3, .L1870+92
	cmp	r7, #2
	add	r0, r1, r2
	ldr	r3, [r3, #52]
	movhi	r1, r0
	mov	r0, r8
	blx	r3
	b	.L1829
.L1864:
	add	r1, r3, r7, lsl #4
	ldr	r3, .L1870+92
	add	r1, r1, #1968
	mov	r2, #16
	add	r1, r1, #4
	mov	r0, r8
	ldr	r3, [r3, #52]
	blx	r3
	b	.L1829
.L1862:
	ldr	r1, .L1870+104
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1814
.L1868:
	ldr	r1, .L1870+108
	ldr	r0, [fp, #-80]
	bl	u_1
	mov	r2, r9
	mov	r1, r4
	mov	r3, #64
	mov	lr, r0
	cmp	lr, #1
	ldr	r0, [fp, #-80]
	str	lr, [r8]
	strb	lr, [r10]
	bne	.L1837
	str	r8, [sp]
	bl	Scaling_List
	ldr	r3, [r8]
	cmp	r3, #1
	bne	.L1838
	ldr	r1, .L1870+100
	mov	r2, #64
	ldr	r3, .L1870+92
	cmp	r7, #0
	add	r0, r1, r2
	ldr	r3, [r3, #52]
	movne	r1, r0
	mov	r0, r9
	blx	r3
	b	.L1838
.L1869:
	add	r1, r3, r7, lsl #6
	ldr	r3, .L1870+92
	add	r1, r1, #2064
	add	r1, r1, #4
	ldr	r3, [r3, #52]
	blx	r3
	b	.L1838
.L1871:
	.align	2
.L1870:
	.word	.LC147
	.word	.LC148
	.word	.LC149
	.word	.LC150
	.word	g_event_report
	.word	.LC165
	.word	.LC166
	.word	.LC167
	.word	.LC170
	.word	.LC151
	.word	.LC153
	.word	.LC155
	.word	.LC156
	.word	.LC158
	.word	.LC159
	.word	.LC160
	.word	.LC161
	.word	.LC162
	.word	.LC163
	.word	.LC164
	.word	.LC152
	.word	.LC154
	.word	.LANCHOR0+80
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC168
	.word	.LANCHOR0+112
	.word	.LC157
	.word	.LC169
	.fnend
	.size	ProcessPPS, .-ProcessPPS
	.align	2
	.global	PPSEqual
	.type	PPSEqual, %function
PPSEqual:
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
	subs	r6, r0, #0
	beq	.L1895
	cmp	r1, #0
	beq	.L1896
	ldr	r2, [r6, #24]
	ldr	ip, [r6, #28]
	ldr	r0, [r1, #28]
	ldr	r4, [r1, #24]
	ldrb	lr, [r6]
	cmp	ip, r0
	cmpeq	r2, r4
	ldrb	r3, [r1]
	ldrb	r4, [r6, #1]
	ldrb	ip, [r1, #1]
	moveq	r2, #1
	movne	r2, #0
	cmp	lr, r3
	movne	r0, #0
	andeq	r0, r2, #1
	ldr	lr, [r6, #36]
	cmp	r4, ip
	movne	r3, #0
	andeq	r3, r0, #1
	ldr	r2, [r1, #36]
	ldr	r4, [r6, #40]
	ldr	r0, [r1, #40]
	cmp	lr, r2
	movne	ip, #0
	andeq	ip, r3, #1
	ldrb	lr, [r6, #2]
	ldrb	r3, [r1, #2]
	cmp	r4, r0
	movne	r2, #0
	andeq	r2, ip, #1
	ldr	r4, [r6, #44]
	ldr	ip, [r1, #44]
	cmp	lr, r3
	movne	r0, #0
	andeq	r0, r2, #1
	ldr	lr, [r6, #48]
	ldr	r2, [r1, #48]
	cmp	r4, ip
	movne	r3, #0
	andeq	r3, r0, #1
	ldr	r4, [r6, #52]
	ldr	r0, [r1, #52]
	cmp	lr, r2
	movne	ip, #0
	andeq	ip, r3, #1
	ldrb	r5, [r6, #3]
	ldrb	lr, [r1, #3]
	cmp	r4, r0
	movne	r2, #0
	andeq	r2, ip, #1
	ldrb	r3, [r6, #4]
	ldrb	r4, [r1, #4]
	cmp	r5, lr
	movne	r0, #0
	andeq	r0, r2, #1
	ldr	ip, [r6, #60]
	ldr	lr, [r1, #60]
	cmp	r3, r4
	movne	r3, #0
	andeq	r3, r0, #1
	ldrb	r2, [r1, #18]
	ldrb	r0, [r6, #18]
	cmp	ip, lr
	movne	r3, #0
	andeq	r3, r3, #1
	cmp	r2, r0
	movne	r2, #0
	andeq	r2, r3, #1
	cmp	r0, #0
	beq	.L1876
	mov	ip, ip, asl #1
	adds	r3, ip, #6
	str	r3, [fp, #-48]
	beq	.L1876
	add	r0, r1, #4
	sub	r8, r1, #1088
	add	r3, r6, #4
	sub	r8, r8, #4
	add	r9, r1, #64
	mov	r5, r0
	mov	r10, r6
	mov	r7, r6
	str	r6, [fp, #-52]
	mov	r0, #0
	mov	r6, r3
	str	r1, [fp, #-56]
.L1881:
	ldrb	r3, [r6, #1]!
	ldrsb	ip, [r5, #1]!
	sxtb	r1, r3
	cmp	ip, r1
	movne	r2, #0
	andeq	r2, r2, #1
	cmp	r3, #0
	beq	.L1894
	cmp	r0, #5
	bhi	.L1878
	add	r4, r10, #64
	add	r10, r10, #128
	mov	r1, r9
	mov	r3, r4
.L1879:
	ldr	lr, [r3], #4
	ldr	ip, [r1], #4
	cmp	lr, ip
	movne	r2, #0
	andeq	r2, r2, #1
	cmp	r3, r10
	bne	.L1879
.L1877:
	ldr	r3, [fp, #-48]
	add	r0, r0, #1
	add	r7, r7, #256
	add	r8, r8, #256
	cmp	r0, r3
	mov	r10, r4
	add	r9, r9, #64
	bne	.L1881
	ldr	r6, [fp, #-52]
	ldr	r1, [fp, #-56]
.L1876:
	ldr	r0, [r6, #56]
	ldr	r3, [r1, #56]
	cmp	r0, r3
	movne	r0, #0
	andeq	r0, r2, #1
	eor	r0, r0, #1
	rsb	r0, r0, #0
.L1874:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L1878:
	sub	r3, r7, #1088
	sub	r4, r7, #836
	sub	r3, r3, #4
	mov	r1, r8
.L1880:
	ldr	lr, [r3, #4]!
	ldr	ip, [r1, #4]!
	cmp	lr, ip
	movne	r2, #0
	andeq	r2, r2, #1
	cmp	r3, r4
	bne	.L1880
.L1894:
	add	r4, r10, #64
	b	.L1877
.L1896:
	mov	r0, r1
	movw	r3, #9667
	ldr	r2, .L1897
	ldr	r1, .L1897+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1874
.L1895:
	movw	r3, #9666
	ldr	r2, .L1897
	ldr	r1, .L1897+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1874
.L1898:
	.align	2
.L1897:
	.word	.LC20
	.word	.LC21
	.fnend
	.size	PPSEqual, .-PPSEqual
	.align	2
	.global	H264_DecPPS
	.type	H264_DecPPS, %function
H264_DecPPS:
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
	ldr	r1, .L1916
	add	r4, r0, #12288
	mov	r5, r0
	bl	ue_v
	ldr	r3, [r4, #1292]
	sub	r3, r3, #1
	cmp	r0, r3
	mov	r6, r0
	bls	.L1900
	ldr	r1, .L1916+4
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r4, #1292]
	sub	r2, r3, #1
	cmp	r6, r2
	bls	.L1908
	ldr	r2, .L1916+8
	ldr	ip, [r2]
	cmp	ip, #0
	beq	.L1908
	add	r5, r5, #57344
	str	r3, [fp, #-40]
	str	r6, [fp, #-44]
	mov	r3, #8
	ldr	r0, [r5, #3888]
	sub	r2, fp, #44
	mov	r1, #110
	blx	ip
	mvn	r0, #0
.L1901:
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1900:
	ldr	r1, .L1916+12
	mov	r0, r5
	bl	ue_v
	ldr	r3, [r4, #1288]
	sub	r3, r3, #1
	cmp	r0, r3
	mov	ip, r0
	bhi	.L1912
	ldr	r2, [r4, #1300]
	mov	r3, #4000
	mla	r3, r3, r0, r2
	ldrb	r3, [r3, #23]
	cmp	r3, #0
	beq	.L1913
	mov	r9, #2208
	ldr	r3, [r4, #1304]
	mul	r7, r9, r6
	add	r3, r3, r7
	ldrb	r8, [r3, #19]
	cmp	r8, #0
	beq	.L1904
	ldr	r8, .L1916+16
	mov	r0, r5
	mov	r1, r8
	str	r6, [r8, #24]
	str	ip, [r8, #28]
	bl	ProcessPPS
	subs	r5, r0, #0
	bne	.L1914
	ldr	r1, [r4, #1304]
	mov	r0, r8
	add	r1, r1, r7
	bl	PPSEqual
	cmp	r0, #0
	beq	.L1901
	ldr	ip, .L1916+20
	mov	r3, #1
	ldr	r0, [r4, #1304]
	mov	r2, r9
	mov	r1, r8
	strb	r3, [r8, #20]
	add	r0, r0, r7
	ldr	ip, [ip, #56]
	strb	r3, [r8, #19]
	blx	ip
	mov	r0, r5
	b	.L1901
.L1904:
	str	r6, [r3, #24]
	mov	r0, r5
	ldr	r3, [r4, #1304]
	add	r3, r3, r7
	str	ip, [r3, #28]
	ldr	r1, [r4, #1304]
	add	r1, r1, r7
	bl	ProcessPPS
	cmp	r0, #0
	bne	.L1915
	ldr	r3, [r4, #1304]
	mov	r2, #1
	add	r3, r3, r7
	strb	r2, [r3, #20]
	ldr	r3, [r4, #1304]
	add	r7, r3, r7
	strb	r2, [r7, #19]
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1908:
	mvn	r0, #0
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1912:
	ldr	r1, .L1916+24
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1901
.L1914:
	ldr	r1, .L1916+28
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1901
.L1913:
	ldr	r1, .L1916+32
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1901
.L1915:
	ldr	r1, .L1916+28
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r4, #1304]
	mov	r2, #1
	mvn	r0, #0
	add	r3, r3, r7
	strb	r2, [r3, #20]
	ldr	r3, [r4, #1304]
	add	r7, r3, r7
	strb	r8, [r7, #19]
	b	.L1901
.L1917:
	.align	2
.L1916:
	.word	.LC171
	.word	.LC172
	.word	g_event_report
	.word	.LC173
	.word	.LANCHOR2
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC174
	.word	.LC176
	.word	.LC175
	.fnend
	.size	H264_DecPPS, .-H264_DecPPS
	.align	2
	.global	vui_parameters
	.type	vui_parameters, %function
vui_parameters:
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
	ldr	r1, .L1967
	mov	r4, r0
	bl	u_1
	uxtb	r0, r0
	strb	r0, [r5]
	cmp	r0, #0
	streqb	r0, [r5, #15]
	bne	.L1961
.L1920:
	ldr	r1, .L1967+4
	mov	r0, r4
	bl	u_1
	uxtb	r0, r0
	strb	r0, [r5, #1]
	cmp	r0, #0
	bne	.L1962
.L1921:
	ldr	r1, .L1967+8
	mov	r0, r4
	bl	u_1
	uxtb	r0, r0
	strb	r0, [r5, #3]
	cmp	r0, #0
	moveq	r3, #5
	streq	r3, [r5, #28]
	bne	.L1963
.L1923:
	ldr	r1, .L1967+12
	mov	r0, r4
	bl	u_1
	uxtb	r0, r0
	strb	r0, [r5, #6]
	cmp	r0, #0
	bne	.L1964
.L1924:
	ldr	r1, .L1967+16
	mov	r0, r4
	bl	u_1
	uxtb	r0, r0
	strb	r0, [r5, #8]
	cmp	r0, #0
	bne	.L1965
.L1926:
	ldr	r1, .L1967+20
	mov	r0, r4
	bl	u_1
	uxtb	r0, r0
	strb	r0, [r5, #7]
	cmp	r0, #0
	beq	.L1928
	ldr	r1, .L1967+24
	mov	r0, r4
	bl	ue_v
	ldr	r2, .L1967+28
	mov	r1, #4
	str	r0, [r5, #120]
	mov	r0, r4
	bl	u_v
	ldr	r2, .L1967+32
	mov	r1, #4
	strb	r0, [r5, #116]
	mov	r0, r4
	bl	u_v
	ldr	r3, [r5, #120]
	cmp	r3, #31
	strb	r0, [r5, #117]
	bhi	.L1931
	add	r9, r4, #57344
	ldr	r6, [r9, #3828]
	cmp	r6, #0
	bne	.L1931
	add	r7, r5, #120
	add	r8, r5, #83
.L1932:
	ldr	r1, .L1967+36
	mov	r0, r4
	bl	ue_v
	ldr	r1, .L1967+40
	add	r6, r6, #1
	str	r0, [r7, #4]!
	mov	r0, r4
	bl	ue_v
	ldr	r1, .L1967+44
	str	r0, [r7, #128]
	mov	r0, r4
	bl	u_1
	strb	r0, [r8, #1]!
	ldr	r3, [r5, #120]
	cmp	r3, r6
	bcs	.L1932
	ldr	r2, .L1967+48
	mov	r1, #5
	mov	r0, r4
	bl	u_v
	ldr	r2, .L1967+52
	mov	r1, #5
	str	r0, [r5, #380]
	mov	r0, r4
	bl	u_v
	ldr	r2, .L1967+56
	mov	r1, #5
	str	r0, [r5, #384]
	mov	r0, r4
	bl	u_v
	ldr	r2, .L1967+60
	mov	r1, #5
	str	r0, [r5, #388]
	mov	r0, r4
	bl	u_v
	str	r0, [r5, #392]
.L1928:
	ldr	r1, .L1967+64
	mov	r0, r4
	bl	u_1
	uxtb	r0, r0
	strb	r0, [r5, #10]
	cmp	r0, #0
	bne	.L1966
	ldrb	r3, [r5, #7]
	add	r9, r4, #57344
	cmp	r3, #0
	bne	.L1937
.L1936:
	ldr	r1, .L1967+68
	mov	r0, r4
	bl	u_1
	ldr	r1, .L1967+72
	strb	r0, [r5, #11]
	mov	r0, r4
	bl	u_1
	uxtb	r0, r0
	strb	r0, [r5, #12]
	cmp	r0, #0
	bne	.L1938
	ldr	r0, [r9, #3828]
.L1939:
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r0, r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1966:
	ldr	r1, .L1967+24
	mov	r0, r4
	bl	ue_v
	ldr	r2, .L1967+28
	mov	r1, #4
	str	r0, [r5, #432]
	mov	r0, r4
	bl	u_v
	ldr	r2, .L1967+32
	mov	r1, #4
	strb	r0, [r5, #428]
	mov	r0, r4
	bl	u_v
	ldr	r3, [r5, #432]
	cmp	r3, #31
	strb	r0, [r5, #429]
	bhi	.L1931
	add	r9, r4, #57344
	ldr	r6, [r9, #3828]
	cmp	r6, #0
	bne	.L1931
	add	r8, r5, #392
	add	r7, r5, #432
	add	r8, r8, #3
.L1934:
	ldr	r1, .L1967+36
	mov	r0, r4
	bl	ue_v
	ldr	r1, .L1967+40
	add	r6, r6, #1
	str	r0, [r7, #4]!
	mov	r0, r4
	bl	ue_v
	ldr	r1, .L1967+44
	str	r0, [r7, #128]
	mov	r0, r4
	bl	u_1
	strb	r0, [r8, #1]!
	ldr	r3, [r5, #432]
	cmp	r3, r6
	bcs	.L1934
	ldr	r2, .L1967+48
	mov	r1, #5
	mov	r0, r4
	bl	u_v
	ldr	r2, .L1967+52
	mov	r1, #5
	str	r0, [r5, #692]
	mov	r0, r4
	bl	u_v
	ldr	r2, .L1967+56
	mov	r1, #5
	str	r0, [r5, #696]
	mov	r0, r4
	bl	u_v
	ldr	r2, .L1967+60
	mov	r1, #5
	str	r0, [r5, #700]
	mov	r0, r4
	bl	u_v
	ldrb	r3, [r5, #7]
	cmp	r3, #0
	str	r0, [r5, #704]
	bne	.L1937
	ldrb	r3, [r5, #10]
	cmp	r3, #0
	beq	.L1936
.L1937:
	ldr	r1, .L1967+76
	mov	r0, r4
	bl	u_1
	strb	r0, [r5, #14]
	b	.L1936
.L1965:
	ldr	r2, .L1967+80
	mov	r1, #32
	mov	r0, r4
	bl	u_v
	ldr	r2, .L1967+84
	mov	r1, #32
	str	r0, [r5, #52]
	mov	r0, r4
	bl	u_v
	ldr	r1, .L1967+88
	str	r0, [r5, #56]
	mov	r0, r4
	bl	u_1
	uxtb	r0, r0
	strb	r0, [r5, #9]
	cmp	r0, #1
	bne	.L1926
	ldr	r1, [r5, #52]
	cmp	r1, #0
	beq	.L1926
	ldr	r0, [r5, #56]
	add	r9, r4, #57344
	bl	__aeabi_uidiv
	mov	r0, r0, lsr #1
	str	r0, [r9, #2500]
	b	.L1926
.L1964:
	ldr	r1, .L1967+92
	mov	r0, r4
	bl	ue_v
	ldr	r1, .L1967+96
	str	r0, [r5, #44]
	mov	r0, r4
	bl	ue_v
	str	r0, [r5, #48]
	b	.L1924
.L1963:
	ldr	r2, .L1967+100
	mov	r1, #3
	mov	r0, r4
	bl	u_v
	ldr	r1, .L1967+104
	str	r0, [r5, #28]
	mov	r0, r4
	bl	u_1
	ldr	r1, .L1967+108
	strb	r0, [r5, #4]
	mov	r0, r4
	bl	u_1
	uxtb	r0, r0
	strb	r0, [r5, #5]
	cmp	r0, #0
	beq	.L1923
	ldr	r2, .L1967+112
	mov	r1, #8
	mov	r0, r4
	bl	u_v
	ldr	r2, .L1967+116
	mov	r1, #8
	str	r0, [r5, #32]
	mov	r0, r4
	bl	u_v
	ldr	r2, .L1967+120
	mov	r1, #8
	str	r0, [r5, #36]
	mov	r0, r4
	bl	u_v
	str	r0, [r5, #40]
	b	.L1923
.L1962:
	ldr	r1, .L1967+124
	mov	r0, r4
	bl	u_1
	strb	r0, [r5, #2]
	b	.L1921
.L1961:
	ldr	r2, .L1967+128
	mov	r1, #8
	mov	r0, r4
	bl	u_v
	uxtb	r0, r0
	strb	r0, [r5, #15]
	cmp	r0, #255
	bne	.L1920
	ldr	r2, .L1967+132
	mov	r1, #16
	mov	r0, r4
	bl	u_v
	ldr	r2, .L1967+136
	mov	r1, #16
	str	r0, [r5, #16]
	mov	r0, r4
	bl	u_v
	str	r0, [r5, #20]
	b	.L1920
.L1938:
	ldr	r1, .L1967+140
	mov	r0, r4
	bl	u_1
	ldr	r1, .L1967+144
	strb	r0, [r5, #13]
	mov	r0, r4
	bl	ue_v
	ldr	r1, .L1967+148
	str	r0, [r5, #60]
	mov	r0, r4
	bl	ue_v
	ldr	r1, .L1967+152
	str	r0, [r5, #64]
	mov	r0, r4
	bl	ue_v
	ldr	r1, .L1967+156
	str	r0, [r5, #72]
	mov	r0, r4
	bl	ue_v
	ldr	r1, .L1967+160
	str	r0, [r5, #68]
	mov	r0, r4
	bl	ue_v
	ldr	r1, .L1967+164
	str	r0, [r5, #76]
	mov	r0, r4
	bl	ue_v
	str	r0, [r5, #80]
	ldr	r0, [r9, #3828]
	cmp	r0, #0
	beq	.L1939
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1931:
	ldr	r1, .L1967+168
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L1968:
	.align	2
.L1967:
	.word	.LC177
	.word	.LC181
	.word	.LC183
	.word	.LC190
	.word	.LC193
	.word	.LC197
	.word	.LC198
	.word	.LC199
	.word	.LC200
	.word	.LC202
	.word	.LC203
	.word	.LC204
	.word	.LC205
	.word	.LC206
	.word	.LC207
	.word	.LC208
	.word	.LC209
	.word	.LC211
	.word	.LC212
	.word	.LC210
	.word	.LC194
	.word	.LC195
	.word	.LC196
	.word	.LC191
	.word	.LC192
	.word	.LC184
	.word	.LC185
	.word	.LC186
	.word	.LC187
	.word	.LC188
	.word	.LC189
	.word	.LC182
	.word	.LC178
	.word	.LC179
	.word	.LC180
	.word	.LC213
	.word	.LC214
	.word	.LC215
	.word	.LC216
	.word	.LC217
	.word	.LC218
	.word	.LC219
	.word	.LC201
	.fnend
	.size	vui_parameters, .-vui_parameters
	.align	2
	.global	SPSEqual
	.type	SPSEqual, %function
SPSEqual:
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
	beq	.L2001
	cmp	r1, #0
	beq	.L2002
	ldrb	lr, [r1]
	ldrb	r3, [r5]
	ldr	ip, [r5, #28]
	ldr	r2, [r1, #28]
	ldrb	r0, [r5, #1]
	cmp	r3, lr
	cmpeq	ip, r2
	ldrb	r6, [r1, #1]
	ldrb	r2, [r5, #2]
	ldrb	r4, [r1, #2]
	moveq	lr, #1
	movne	lr, #0
	ldr	r3, [r5, #32]
	cmp	r0, r6
	movne	ip, #0
	andeq	ip, lr, #1
	ldr	r6, [r1, #32]
	cmp	r2, r4
	movne	r0, #0
	andeq	r0, ip, #1
	ldr	lr, [r1, #36]
	ldr	r4, [r5, #36]
	cmp	r3, r6
	movne	r2, #0
	andeq	r2, r0, #1
	ldrb	ip, [r1, #25]
	ldrb	r0, [r5, #25]
	cmp	r4, lr
	movne	r3, #0
	andeq	r3, r2, #1
	cmp	ip, r0
	movne	r3, #0
	andeq	r3, r3, #1
	cmp	r0, #0
	beq	.L1973
	add	r0, r1, #3
	add	r2, r5, #3
	sub	r9, r1, #1104
	add	r7, r1, #48
	mov	ip, r0
	mov	r8, r5
	mov	r6, r5
	str	r5, [fp, #-48]
	mov	r0, #0
	mov	r4, r2
	mov	r5, ip
	str	r1, [fp, #-52]
.L1978:
	ldrb	r2, [r4, #1]!
	ldrsb	ip, [r5, #1]!
	sxtb	r1, r2
	cmp	ip, r1
	movne	r3, #0
	andeq	r3, r3, #1
	cmp	r2, #0
	beq	.L1974
	cmp	r0, #5
	bhi	.L1975
	add	r2, r6, #48
	add	r10, r6, #112
	mov	r1, r7
.L1976:
	ldr	lr, [r2, #4]!
	ldr	ip, [r1, #4]!
	cmp	lr, ip
	movne	r3, #0
	andeq	r3, r3, #1
	cmp	r2, r10
	bne	.L1976
.L1974:
	add	r0, r0, #1
	add	r8, r8, #256
	cmp	r0, #8
	add	r9, r9, #256
	add	r6, r6, #64
	add	r7, r7, #64
	bne	.L1978
	ldr	r5, [fp, #-48]
	ldr	r1, [fp, #-52]
.L1973:
	ldr	r2, [r1, #2196]
	ldr	ip, [r5, #2200]
	ldr	r0, [r1, #2200]
	ldr	lr, [r5, #2196]
	cmp	ip, r0
	cmpeq	lr, r2
	moveq	r2, #1
	movne	r2, #0
	cmp	ip, #0
	and	r3, r3, r2
	beq	.L1980
	cmp	ip, #1
	bne	.L1979
	ldr	r0, [r1, #2208]
	ldr	ip, [r5, #2208]
	ldrb	r2, [r5, #16]
	ldrb	r6, [r1, #16]
	ldr	r4, [r5, #2212]
	cmp	ip, r0
	cmpeq	r2, r6
	ldr	lr, [r1, #2212]
	ldr	r6, [r5, #2216]
	ldr	ip, [r1, #2216]
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
	beq	.L1979
	add	ip, r5, #2208
	add	r0, r1, #2208
	add	ip, ip, #8
	add	r0, r0, #8
	mov	r2, #0
.L1982:
	ldr	r4, [ip, #4]!
	add	r2, r2, #1
	ldr	lr, [r0, #4]!
	cmp	r4, lr
	movne	r3, #0
	andeq	r3, r3, #1
	cmp	r2, r6
	bne	.L1982
.L1979:
	ldrb	ip, [r1, #17]
	ldrb	lr, [r5, #17]
	ldr	r0, [r5, #3244]
	ldr	r4, [r1, #3244]
	ldr	r2, [r5, #3248]
	cmp	lr, ip
	cmpeq	r0, r4
	ldr	r7, [r1, #3248]
	ldr	r6, [r5, #3252]
	ldr	r4, [r1, #3252]
	moveq	ip, #1
	movne	ip, #0
	ldrb	lr, [r1, #18]
	cmp	r2, r7
	movne	r0, #0
	andeq	r0, ip, #1
	ldrb	ip, [r5, #18]
	cmp	r6, r4
	movne	r2, #0
	andeq	r2, r0, #1
	cmp	lr, ip
	movne	r2, #0
	andeq	r2, r2, #1
	cmp	ip, #0
	and	r3, r3, r2
	bne	.L1983
	ldrb	r0, [r5, #19]
	ldrb	r2, [r1, #19]
	cmp	r0, r2
	movne	r3, #0
	andeq	r3, r3, #1
.L1983:
	ldrb	r2, [r1, #20]
	ldrb	ip, [r5, #21]
	ldrb	r0, [r1, #21]
	ldrb	lr, [r5, #20]
	cmp	r0, ip
	cmpeq	lr, r2
	moveq	r2, #1
	movne	r2, #0
	cmp	ip, #0
	and	r3, r3, r2
	bne	.L2003
.L1984:
	ldrb	r0, [r5, #22]
	ldrb	r2, [r1, #22]
	cmp	r0, r2
	movne	r0, #0
	andeq	r0, r3, #1
	eor	r0, r0, #1
	rsb	r0, r0, #0
.L1971:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2003:
	ldr	ip, [r1, #3260]
	ldr	lr, [r5, #3260]
	ldr	r0, [r5, #3256]
	ldr	r4, [r1, #3256]
	ldr	r2, [r1, #3264]
	cmp	lr, ip
	cmpeq	r0, r4
	ldr	r6, [r5, #3264]
	ldr	r4, [r5, #3268]
	ldr	lr, [r1, #3268]
	moveq	ip, #1
	movne	ip, #0
	cmp	r6, r2
	movne	r0, #0
	andeq	r0, ip, #1
	cmp	r4, lr
	movne	r2, #0
	andeq	r2, r0, #1
	and	r3, r3, r2
	b	.L1984
.L1975:
	sub	r2, r8, #1104
	sub	r10, r8, #848
	mov	r1, r9
.L1977:
	ldr	lr, [r2, #4]!
	ldr	ip, [r1, #4]!
	cmp	lr, ip
	movne	r3, #0
	andeq	r3, r3, #1
	cmp	r2, r10
	bne	.L1977
	b	.L1974
.L1980:
	ldr	r0, [r5, #2204]
	ldr	r2, [r1, #2204]
	cmp	r0, r2
	movne	r3, #0
	andeq	r3, r3, #1
	b	.L1979
.L2002:
	mov	r0, r1
	movw	r3, #9900
	ldr	r2, .L2004
	ldr	r1, .L2004+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1971
.L2001:
	movw	r3, #9899
	ldr	r2, .L2004
	ldr	r1, .L2004+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L1971
.L2005:
	.align	2
.L2004:
	.word	.LC20
	.word	.LC21
	.fnend
	.size	SPSEqual, .-SPSEqual
	.global	__aeabi_idiv
	.align	2
	.global	H264GetDar
	.type	H264GetDar, %function
H264GetDar:
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
	cmp	r0, #0
	mov	ip, r1
	moveq	r4, r0
	beq	.L2007
	subs	lr, r0, #255
	movne	lr, #1
	cmp	r0, #16
	movle	r4, #0
	andgt	r4, lr, #1
	cmp	r4, #0
	movne	r4, #0
	bne	.L2007
	cmp	r2, #0
	cmpne	r1, #0
	moveq	r1, #1
	movne	r1, #0
	cmp	r0, #255
	movne	r1, #0
	andeq	r1, r1, #1
	cmp	r1, #0
	bne	.L2007
	cmp	r0, #1
	moveq	r4, #5
	beq	.L2007
	cmp	lr, #0
	str	r3, [fp, #-24]
	ldrne	r2, .L2033
	addne	r0, r2, r0, lsl #3
	ldrne	r2, [r0, #84]
	ldrne	ip, [r0, #80]
	mov	r1, r2
	mov	r0, ip, asl #10
	bl	__aeabi_idiv
	ldr	r3, [fp, #-24]
	ldr	r1, [fp, #4]
	mov	r4, r0
	mov	r0, r3, asl #10
	bl	__aeabi_idiv
	mul	r0, r0, r4
	add	r2, r0, #1020
	cmp	r0, #0
	add	r2, r2, #3
	movlt	r0, r2
	mov	r2, r0, asr #10
	sub	r3, r2, #2400
	sub	r1, r2, #2256
	sub	r3, r3, #6
	sub	r1, r1, #7
	cmp	r3, #0
	rsblt	r3, r2, #2400
	addlt	r3, r3, #6
	cmp	r1, #0
	rsblt	r1, r2, #2256
	addlt	r1, r1, #7
	cmp	r3, r1
	movlt	r4, #4
	blt	.L2007
	sub	r3, r2, #1808
	sub	r3, r3, #12
	cmp	r3, #0
	rsblt	r3, r2, #1808
	addlt	r3, r3, #12
	cmp	r1, r3
	movlt	r4, #3
	bge	.L2032
.L2007:
	mov	r2, r4
	ldr	r1, .L2033+4
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r4
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L2032:
	sub	r0, r2, #1360
	sub	r0, r0, #5
	cmp	r0, #0
	rsblt	r0, r2, #1360
	addlt	r0, r0, #5
	cmp	r3, r0
	movlt	r4, #2
	movge	r4, #1
	b	.L2007
.L2034:
	.align	2
.L2033:
	.word	.LANCHOR1
	.word	.LC220
	.fnend
	.size	H264GetDar, .-H264GetDar
	.align	2
	.global	ProcessSPS
	.type	ProcessSPS, %function
ProcessSPS:
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
	subs	r4, r1, #0
	mov	r5, r0
	beq	.L2149
	ldr	r2, [r4, #28]
	cmp	r2, #100
	cmpne	r2, #110
	moveq	r3, #1
	movne	r3, #0
	cmp	r2, #122
	orreq	r3, r3, #1
	cmp	r2, #144
	orreq	r3, r3, #1
	cmp	r2, #83
	orreq	r3, r3, #1
	cmp	r2, #86
	orreq	r3, r3, #1
	cmp	r3, #0
	streqb	r3, [r4, #25]
	moveq	r3, #1
	streq	r3, [r4, #40]
	bne	.L2150
.L2050:
	ldr	r1, .L2166
	mov	r0, r5
	bl	ue_v
	cmp	r0, #12
	str	r0, [r4, #2196]
	bhi	.L2063
	add	r6, r5, #57344
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L2063
	ldr	r1, .L2166+4
	mov	r0, r5
	bl	ue_v
	cmp	r0, #2
	str	r0, [r4, #2200]
	bhi	.L2065
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L2065
	cmp	r0, #0
	beq	.L2151
	cmp	r0, #1
	beq	.L2152
.L2071:
	ldr	r1, .L2166+8
	mov	r0, r5
	bl	ue_v
	str	r0, [r4, #3244]
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L2147
	ldr	r1, .L2166+12
	mov	r0, r5
	bl	u_1
	strb	r0, [r4, #17]
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L2147
	ldr	r1, .L2166+16
	mov	r0, r5
	bl	ue_v
	movw	r8, #509
	sub	r3, r0, #1
	str	r0, [r4, #3248]
	cmp	r3, r8
	bhi	.L2076
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L2076
	ldr	r1, .L2166+20
	mov	r0, r5
	bl	ue_v
	str	r0, [r4, #3252]
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L2147
	ldr	r1, .L2166+24
	mov	r0, r5
	bl	u_1
	uxtb	r0, r0
	strb	r0, [r4, #18]
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L2147
	cmp	r0, #0
	bne	.L2153
	ldr	r1, .L2166+28
	mov	r0, r5
	bl	u_1
	ldr	r7, [r4, #3252]
	add	r7, r7, #1
	cmp	r7, #255
	strb	r0, [r4, #19]
	bhi	.L2108
	ldr	r3, [r4, #3248]
	add	r3, r3, #1
	cmp	r7, #1
	cmphi	r3, #3
	movhi	r9, #2
	bhi	.L2080
.L2108:
	ldr	r1, .L2166+32
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2140
.L2150:
	ldr	r1, .L2166+36
	bl	ue_v
	cmp	r0, #1
	str	r0, [r4, #40]
	bhi	.L2039
	add	r6, r5, #57344
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L2039
	ldr	r1, .L2166+40
	mov	r0, r5
	bl	ue_v
	uxth	r0, r0
	add	r2, r0, #8
	str	r2, [r4, #44]
	cmp	r2, #8
	beq	.L2154
.L2041:
	ldr	r1, .L2166+44
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L2166+48
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L2042
	ldr	r0, [r4, #44]
	mov	r2, #0
	mov	r3, #8
	str	r2, [fp, #-68]
	mov	r1, #119
	sub	r2, fp, #68
	str	r0, [fp, #-64]
	ldr	r0, [r6, #3888]
	blx	ip
.L2042:
	ldr	r1, .L2166+52
	mov	r0, r5
	bl	ue_v
	uxth	r0, r0
	add	r2, r0, #8
	str	r2, [r4, #48]
	cmp	r2, #8
	beq	.L2155
.L2044:
	ldr	r1, .L2166+56
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L2166+48
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L2045
	ldr	r0, [r4, #48]
	mov	r2, #0
	mov	r3, #8
	str	r2, [fp, #-68]
	mov	r1, #119
	sub	r2, fp, #68
	str	r0, [fp, #-64]
	ldr	r0, [r6, #3888]
	blx	ip
.L2045:
	ldr	r1, .L2166+60
	mov	r0, r5
	bl	u_1
	cmp	r0, #0
	bne	.L2047
	ldr	r6, [r6, #3828]
	cmp	r6, #0
	bne	.L2047
	ldr	r1, .L2166+64
	mov	r0, r5
	bl	u_1
	uxtb	r0, r0
	strb	r0, [r4, #25]
	cmp	r0, #1
	bne	.L2050
	add	r10, r4, #1968
	sub	r7, fp, #72
	add	r10, r10, #4
	add	r9, r4, #3
	add	r8, r4, #52
	b	.L2056
.L2158:
	ldr	r3, .L2166+68
	cmp	r1, #0
	add	ip, r3, #16
	moveq	r3, ip
	mov	r1, r3
	ldr	r3, .L2166+72
	ldr	r3, [r3, #52]
	blx	r3
.L2052:
	add	r6, r6, #1
	add	r10, r10, #16
	cmp	r6, #6
	add	r8, r8, #64
	beq	.L2156
.L2056:
	ldr	r1, .L2166+76
	mov	r0, r5
	bl	u_1
	clz	r1, r6
	mov	r2, #16
	mov	r1, r1, lsr #5
	cmp	r0, #1
	mov	r3, r0
	mov	r0, r10
	str	r3, [r7, #4]!
	strb	r3, [r9, #1]!
	beq	.L2157
	cmp	r6, #0
	cmpne	r6, #3
	beq	.L2158
	ldr	r3, .L2166+72
	mov	r2, #16
	sub	r1, r10, #16
	mov	r0, r10
	ldr	r3, [r3, #52]
	blx	r3
	b	.L2052
.L2155:
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	beq	.L2045
	b	.L2044
.L2154:
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	beq	.L2042
	b	.L2041
.L2107:
	cmp	r1, r10
	cmpcs	r0, r7
	bcs	.L2106
	ldr	r3, .L2166+48
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L2147
	strh	r1, [fp, #-72]
	mov	r3, #8
	strh	r0, [fp, #-70]
	sub	r2, fp, #76
	strh	r10, [fp, #-76]
	mov	r1, #107
	strh	r7, [fp, #-74]
	ldr	r0, [r6, #3888]
	blx	ip
.L2147:
	mvn	r0, #0
.L2140:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2153:
	ldr	r7, [r4, #3252]
	strb	r3, [r4, #19]
	sub	r3, r7, #1
	cmp	r3, r8
	bhi	.L2108
	ldr	r3, [r4, #3248]
	mov	r9, #1
	add	r7, r7, #1
	add	r3, r3, r9
.L2080:
	mul	r7, r7, r9
	mov	r10, r3, asl #4
	mov	r7, r7, asl #4
	mul	r1, r10, r7
	add	r1, r1, r1, lsr #1
	cmp	r1, #100663296
	bhi	.L2159
	ldr	r2, [r4, #32]
	sub	r3, r2, #10
	cmp	r3, #31
	ldrls	pc, [pc, r3, asl #2]
	b	.L2082
.L2084:
	.word	.L2083
	.word	.L2085
	.word	.L2115
	.word	.L2115
	.word	.L2082
	.word	.L2082
	.word	.L2082
	.word	.L2082
	.word	.L2082
	.word	.L2082
	.word	.L2115
	.word	.L2087
	.word	.L2089
	.word	.L2082
	.word	.L2082
	.word	.L2082
	.word	.L2082
	.word	.L2082
	.word	.L2082
	.word	.L2082
	.word	.L2089
	.word	.L2090
	.word	.L2091
	.word	.L2082
	.word	.L2082
	.word	.L2082
	.word	.L2082
	.word	.L2082
	.word	.L2082
	.word	.L2082
	.word	.L2093
	.word	.L2093
.L2151:
	ldr	r1, .L2166+80
	mov	r0, r5
	bl	ue_v
	cmp	r0, #12
	str	r0, [r4, #2204]
	bhi	.L2068
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	beq	.L2071
.L2068:
	ldr	r1, .L2166+84
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2140
.L2115:
	mov	r0, #60416
	movt	r0, 13
.L2086:
	bl	__aeabi_uidiv
	ldr	r1, .L2166+88
	cmp	r0, #16
	movcc	r8, r0
	movcs	r8, #16
	mov	r2, r8
	mov	r0, #21
	bl	dprint_vfmw
	ldr	r2, [r4, #3244]
	cmp	r2, r8
	bhi	.L2094
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	beq	.L2095
.L2094:
	mov	r3, r8
	ldr	r1, .L2166+92
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r3, [r4, #3244]
	cmp	r3, #16
	bhi	.L2144
	cmp	r8, r3
	movcc	r8, r3
.L2144:
	str	r8, [r4, #3244]
.L2095:
	ldr	r1, .L2166+96
	mov	r0, r5
	bl	u_1
	strb	r0, [r4, #20]
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L2147
	ldr	r1, .L2166+100
	mov	r0, r5
	bl	u_1
	uxtb	r0, r0
	strb	r0, [r4, #21]
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L2147
	cmp	r0, #0
	bne	.L2160
.L2097:
	mov	r2, r10, lsr #1
	mov	r3, r7, lsr #1
	str	r10, [r4, #3276]
	str	r7, [r4, #3280]
	str	r2, [r4, #3284]
	str	r3, [r4, #3288]
.L2099:
	ldr	r1, .L2166+104
	mov	r0, r5
	bl	u_1
	uxtb	r3, r0
	strb	r3, [r4, #22]
	ldr	r2, [r6, #3828]
	cmp	r2, #0
	bne	.L2147
	cmp	r3, #0
	mov	r2, #2
	str	r2, [r4, #3332]
	bne	.L2161
	mov	r0, r3
	strb	r3, [r4, #3307]
	mov	r3, #5
	str	r3, [r4, #3320]
.L2102:
	ldr	r2, [r4, #3312]
	mov	r3, r10
	ldr	r1, [r4, #3308]
	str	r7, [sp]
	bl	H264GetDar
	ldr	r3, [r4, #3244]
	cmp	r3, #0
	str	r0, [r4, #3316]
	beq	.L2105
	cmp	r8, r3
	movcs	r8, r3
.L2105:
	cmp	r8, #16
	add	r3, r5, #12288
	movcs	r8, #16
	str	r8, [r3, #1296]
	ldr	r3, [r5]
	ldr	r2, [r3, #28]
	cmp	r2, #25
	beq	.L2162
.L2106:
	add	r8, r8, #1
	mov	r0, #0
	str	r8, [r4, #3272]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2093:
	mov	r0, #12582912
	b	.L2086
.L2089:
	mov	r0, #30208
	movt	r0, 47
	b	.L2086
.L2156:
	add	r6, r4, #2064
	sub	r7, fp, #88
	add	r6, r6, #4
	add	r9, r4, #9
	add	r8, r4, #436
	mov	r10, #0
.L2061:
	ldr	r1, .L2166+76
	mov	r0, r5
	bl	u_1
	mov	r2, #64
	mov	r3, r0
	cmp	r3, #1
	mov	r0, r6
	str	r3, [r7, #4]!
	strb	r3, [r9, #1]!
	beq	.L2163
	ldr	r1, .L2166+108
	cmp	r10, #0
	ldr	r3, .L2166+72
	add	ip, r1, #64
	ldr	r3, [r3, #52]
	movne	r1, ip
	blx	r3
.L2058:
	add	r10, r10, #1
	add	r6, r6, #64
	cmp	r10, #2
	add	r8, r8, #256
	bne	.L2061
	b	.L2050
.L2157:
	mov	r3, r2
	str	r7, [sp]
	mov	r2, r10
	mov	r1, r8
	mov	r0, r5
	bl	Scaling_List
	ldr	r3, [r7]
	cmp	r3, #1
	bne	.L2052
	ldr	r1, .L2166+68
	mov	r2, #16
	ldr	r3, .L2166+72
	cmp	r6, #2
	add	r0, r1, r2
	ldr	r3, [r3, #52]
	movhi	r1, r0
	mov	r0, r10
	blx	r3
	b	.L2052
.L2039:
	ldr	r1, .L2166+112
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2063:
	ldr	r1, .L2166+116
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2140
.L2160:
	ldr	r1, .L2166+120
	mov	r0, r5
	bl	ue_v
	ldr	r1, .L2166+124
	str	r0, [r4, #3256]
	mov	r0, r5
	bl	ue_v
	ldr	r1, .L2166+128
	str	r0, [r4, #3260]
	mov	r0, r5
	bl	ue_v
	ldr	r1, .L2166+132
	str	r0, [r4, #3264]
	mov	r0, r5
	bl	ue_v
	ldr	r2, [r4, #3264]
	ldr	r1, [r4, #3256]
	mov	ip, r9, asl #1
	ldr	r3, [r4, #3260]
	mov	r2, r2, asl #1
	mov	r1, r1, asl #1
	mul	r9, r9, r2
	rsb	r2, r1, r10
	sub	r3, r2, r3, asl #1
	rsb	r2, r9, r7
	str	r0, [r4, #3268]
	mls	r0, r0, ip, r2
	cmp	r3, #0
	cmpgt	r0, #0
	ble	.L2097
	add	r1, r1, r3, lsr #1
	add	r9, r9, r0, lsr #1
	str	r1, [r4, #3284]
	str	r9, [r4, #3288]
	str	r3, [r4, #3276]
	str	r0, [r4, #3280]
	b	.L2099
.L2161:
	add	r1, r4, #3280
	mov	r0, r5
	add	r1, r1, #12
	bl	vui_parameters
	cmp	r0, #0
	bne	.L2146
	ldrb	r3, [r4, #3304]
	cmp	r3, #0
	beq	.L2146
	ldr	r2, [r4, #3372]
	clz	r3, r2
	mov	r3, r3, lsr #5
	cmp	r8, r2
	orrcc	r3, r3, #1
	cmp	r3, #0
	bne	.L2164
	ldr	r3, [r4, #3244]
	ldrb	r0, [r4, #3307]
	cmp	r2, r3
	movcs	r8, r2
	movcc	r8, r3
	b	.L2102
.L2164:
	mov	r3, r8
	ldr	r1, .L2166+136
	mov	r0, #1
	bl	dprint_vfmw
.L2146:
	ldrb	r0, [r4, #3307]
	b	.L2102
.L2162:
	ldr	r2, [r3, #700]
	cmp	r2, #0
	bne	.L2106
	ldr	r2, [r3, #684]
	ldr	r1, [r3, #660]
	cmp	r8, r2
	ldr	r0, [r3, #664]
	bls	.L2107
	ldr	r3, .L2166+48
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L2147
	str	r2, [fp, #-72]
	mov	r3, #8
	str	r8, [fp, #-76]
	sub	r2, fp, #76
	ldr	r0, [r6, #3888]
	mov	r1, #106
	blx	ip
	mvn	r0, #0
	b	.L2140
.L2047:
	ldr	r1, .L2166+140
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2140
.L2152:
	ldr	r1, .L2166+144
	mov	r0, r5
	bl	u_1
	strb	r0, [r4, #16]
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L2147
	ldr	r1, .L2166+148
	mov	r0, r5
	bl	se_v
	str	r0, [r4, #2208]
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L2147
	ldr	r1, .L2166+152
	mov	r0, r5
	bl	se_v
	str	r0, [r4, #2212]
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	bne	.L2147
	ldr	r1, .L2166+156
	mov	r0, r5
	bl	ue_v
	cmp	r0, #255
	str	r0, [r4, #2216]
	bhi	.L2073
	ldr	r7, [r6, #3828]
	cmp	r7, #0
	bne	.L2073
	cmp	r0, #0
	addne	r8, r4, #2208
	addne	r8, r8, #8
	bne	.L2075
	b	.L2071
.L2165:
	ldr	r3, [r4, #2216]
	cmp	r3, r7
	bls	.L2071
.L2075:
	ldr	r1, .L2166+160
	mov	r0, r5
	bl	se_v
	add	r7, r7, #1
	str	r0, [r8, #4]!
	ldr	r3, [r6, #3828]
	cmp	r3, #0
	beq	.L2165
	b	.L2147
.L2076:
	mov	r2, r0
	ldr	r1, .L2166+164
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2140
.L2090:
	mov	r0, #30720
	movt	r0, 105
	b	.L2086
.L2087:
	mov	r0, #55296
	movt	r0, 27
	b	.L2086
.L2091:
	mov	r0, #7864320
	b	.L2086
.L2085:
	mov	r0, #17920
	movt	r0, 5
	b	.L2086
.L2083:
	mov	r0, #20992
	movt	r0, 2
	b	.L2086
.L2082:
	ldr	r1, .L2166+168
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2140
.L2073:
	ldr	r1, .L2166+172
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2140
.L2163:
	mov	r3, r2
	str	r7, [sp]
	mov	r2, r6
	mov	r1, r8
	mov	r0, r5
	bl	Scaling_List
	ldr	r3, [r7]
	cmp	r3, #1
	bne	.L2058
	ldr	r1, .L2166+108
	mov	r2, #64
	ldr	r3, .L2166+72
	cmp	r10, #0
	add	r0, r1, r2
	ldr	r3, [r3, #52]
	movne	r1, r0
	mov	r0, r6
	blx	r3
	b	.L2058
.L2065:
	ldr	r1, .L2166+176
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2140
.L2159:
	ldr	r1, .L2166+180
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2140
.L2149:
	mov	r0, r4
	movw	r3, #10090
	ldr	r2, .L2166+184
	ldr	r1, .L2166+188
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2140
.L2167:
	.align	2
.L2166:
	.word	.LC230
	.word	.LC232
	.word	.LC235
	.word	.LC243
	.word	.LC244
	.word	.LC246
	.word	.LC247
	.word	.LC261
	.word	.LC248
	.word	.LC221
	.word	.LC223
	.word	.LC224
	.word	g_event_report
	.word	.LC225
	.word	.LC226
	.word	.LC227
	.word	.LC229
	.word	.LANCHOR0+80
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC168
	.word	.LC234
	.word	.LC236
	.word	.LC251
	.word	.LC252
	.word	.LC253
	.word	.LC254
	.word	.LC259
	.word	.LANCHOR0+112
	.word	.LC222
	.word	.LC231
	.word	.LC255
	.word	.LC256
	.word	.LC257
	.word	.LC258
	.word	.LC260
	.word	.LC228
	.word	.LC237
	.word	.LC238
	.word	.LC239
	.word	.LC240
	.word	.LC242
	.word	.LC245
	.word	.LC250
	.word	.LC241
	.word	.LC233
	.word	.LC249
	.word	.LC20
	.word	.LC21
	.fnend
	.size	ProcessSPS, .-ProcessSPS
	.align	2
	.global	Sps_SvcExt
	.type	Sps_SvcExt, %function
Sps_SvcExt:
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
	add	r1, r0, #12288
	add	r2, r0, #20480
	mov	lr, #2208
	mov	r4, r0
	ldr	r2, [r2, #220]
	add	r0, r0, #13504
	ldr	r3, [r1, #1304]
	mov	r5, #4000
	ldr	ip, [r1, #1300]
	add	r0, r0, #24
	mov	r1, #32
	mla	r3, lr, r2, r3
	ldr	r3, [r3, #28]
	mla	r5, r5, r3, ip
	bl	BsGet
	ldr	r1, .L2182
	mov	r6, r0
	mov	r0, r4
	bl	u_1
	ldr	r1, .L2182+4
	mov	r2, r0
	mov	r0, #17
	bl	dprint_vfmw
	mov	r0, r4
	ldr	r2, .L2182+8
	mov	r1, #2
	bl	u_v
	cmp	r0, #1
	beq	.L2178
	ldr	r2, [r5, #40]
	sub	r1, r2, #1
	cmp	r1, #1
	bls	.L2179
.L2171:
	cmp	r2, #1
	beq	.L2180
.L2172:
	ldr	r1, .L2182+12
	mov	r0, r4
	bl	u_1
	cmp	r0, #0
	bne	.L2181
.L2173:
	mov	r0, r4
	ldr	r1, .L2182+16
	bl	u_1
	cmp	r0, #1
	moveq	r0, #0
	beq	.L2170
	ldr	ip, [r5, #40]
	mov	r2, r0
	mov	r3, r6
	ldr	r1, .L2182+20
	mov	r0, #1
	str	ip, [sp]
	bl	dprint_vfmw
	mov	r0, #0
.L2170:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L2181:
	ldr	r1, .L2182+24
	mov	r0, r4
	bl	u_1
	ldr	r1, .L2182+28
	mov	r2, r0
	mov	r0, #17
	bl	dprint_vfmw
	b	.L2173
.L2180:
	ldr	r2, .L2182+32
	mov	r1, #2
	mov	r0, r4
	bl	u_v
	ldr	r1, .L2182+36
	mov	r2, r0
	mov	r0, #17
	bl	dprint_vfmw
	b	.L2172
.L2179:
	ldr	r1, .L2182+40
	mov	r0, r4
	bl	u_1
	ldr	r1, .L2182+44
	mov	r2, r0
	mov	r0, #17
	bl	dprint_vfmw
	ldr	r2, [r5, #40]
	b	.L2171
.L2178:
	ldr	r1, .L2182+48
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2170
.L2183:
	.align	2
.L2182:
	.word	.LC262
	.word	.LC263
	.word	.LC264
	.word	.LC270
	.word	.LC273
	.word	.LC274
	.word	.LC271
	.word	.LC272
	.word	.LC268
	.word	.LC269
	.word	.LC266
	.word	.LC267
	.word	.LC265
	.fnend
	.size	Sps_SvcExt, .-Sps_SvcExt
	.align	2
	.global	H264_DecSPS
	.type	H264_DecSPS, %function
H264_DecSPS:
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
	ldr	r2, .L2219
	mov	r1, #8
	mov	r4, r0
	add	r7, r0, #57344
	bl	u_v
	ldr	r1, .L2219+4
	mov	r10, r0
	mov	r0, r4
	bl	u_1
	ldr	r1, .L2219+8
	str	r0, [fp, #-56]
	mov	r0, r4
	bl	u_1
	ldr	r1, .L2219+12
	str	r0, [fp, #-60]
	mov	r0, r4
	bl	u_1
	ldr	r1, .L2219+16
	str	r0, [fp, #-64]
	mov	r0, r4
	bl	u_1
	ldr	r2, .L2219+20
	mov	r1, #4
	str	r0, [fp, #-68]
	mov	r0, r4
	bl	u_v
	ldr	r2, .L2219+24
	mov	r1, #8
	mov	r0, r4
	bl	u_v
	ldr	r1, .L2219+28
	mov	r6, r0
	mov	r0, r4
	bl	ue_v
	ldr	r2, [r7, #3828]
	cmp	r2, #0
	mov	r9, r0
	bne	.L2213
	add	r5, r4, #12288
	ldr	r2, [r5, #1288]
	sub	r2, r2, #1
	cmp	r0, r2
	bhi	.L2214
	sub	r2, r10, #66
	mov	r8, r10
	cmp	r2, #78
	ldrls	pc, [pc, r2, asl #2]
	b	.L2189
.L2191:
	.word	.L2190
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2192
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2192
	.word	.L2189
	.word	.L2189
	.word	.L2192
	.word	.L2189
	.word	.L2193
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2192
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2194
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2194
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2189
	.word	.L2194
.L2190:
	ldr	r1, .L2219+32
	mov	r0, #1
	bl	dprint_vfmw
.L2192:
	cmp	r6, #9
	mov	r2, r6
	bls	.L2212
.L2218:
	cmp	r6, #41
	bhi	.L2212
.L2196:
	mov	r3, #4000
	ldr	r1, [r5, #1300]
	mul	r7, r3, r9
	add	r1, r1, r7
	ldrb	r6, [r1, #23]
	cmp	r6, #0
	beq	.L2197
	ldr	r6, .L2219+36
	mov	r0, r4
	str	r3, [fp, #-72]
	ldrb	r3, [fp, #-56]
	add	r1, r6, #2208
	str	r8, [r6, #2236]
	str	r2, [r6, #2240]
	strb	r3, [r6, #2208]
	ldrb	r3, [fp, #-60]
	str	r9, [r6, #2244]
	strb	r3, [r6, #2209]
	ldrb	r3, [fp, #-64]
	strb	r3, [r6, #2210]
	ldrb	r3, [fp, #-68]
	strb	r3, [r6, #2211]
	bl	ProcessSPS
	ldr	r3, [fp, #-72]
	cmp	r0, #0
	bne	.L2215
	ldr	r1, [r5, #1300]
	add	r0, r6, #2208
	str	r3, [fp, #-56]
	add	r1, r1, r7
	bl	SPSEqual
	ldr	r3, [fp, #-56]
	cmp	r0, #0
	bne	.L2216
.L2199:
	cmp	r8, #83
	cmpne	r8, #86
	beq	.L2201
.L2202:
	mov	r0, #0
.L2186:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2212:
	mov	r3, #41
	ldr	r1, .L2219+40
	mov	r0, #1
	bl	dprint_vfmw
	mov	r2, #41
	b	.L2196
.L2197:
	str	r8, [r1, #28]
	mov	r0, r4
	ldr	r3, [r5, #1300]
	ldrb	r1, [fp, #-56]
	strb	r1, [r3, r7]
	ldr	r3, [r5, #1300]
	ldrb	r1, [fp, #-60]
	add	r3, r3, r7
	strb	r1, [r3, #1]
	ldr	r3, [r5, #1300]
	ldrb	r1, [fp, #-64]
	add	r3, r3, r7
	strb	r1, [r3, #2]
	ldr	r3, [r5, #1300]
	ldrb	r1, [fp, #-68]
	add	r3, r3, r7
	strb	r1, [r3, #3]
	ldr	r3, [r5, #1300]
	add	r3, r3, r7
	str	r2, [r3, #32]
	ldr	r3, [r5, #1300]
	add	r3, r3, r7
	str	r9, [r3, #36]
	ldr	r1, [r5, #1300]
	add	r1, r1, r7
	bl	ProcessSPS
	cmp	r0, #0
	bne	.L2217
	ldr	r3, [r5, #1300]
	mov	r2, #1
	cmp	r8, #83
	cmpne	r8, #86
	add	r3, r3, r7
	strb	r2, [r3, #24]
	ldr	r3, [r5, #1300]
	add	r7, r3, r7
	strb	r2, [r7, #23]
	bne	.L2202
.L2201:
	mov	r0, r4
	bl	Sps_SvcExt
	cmp	r0, #0
	beq	.L2202
	ldr	r1, .L2219+44
	mov	r0, #1
	bl	dprint_vfmw
.L2213:
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2214:
	ldr	r1, .L2219+48
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r2, [r5, #1288]
	sub	r3, r2, #1
	cmp	r9, r3
	bls	.L2213
	ldr	r3, .L2219+52
	ldr	r4, [r3]
	cmp	r4, #0
	beq	.L2213
	str	r2, [fp, #-48]
	mov	r3, #8
	str	r9, [fp, #-52]
	sub	r2, fp, #52
	ldr	r0, [r7, #3888]
	mov	r1, #109
	blx	r4
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2194:
	ldr	r1, .L2219+56
	mov	r0, #1
	bl	dprint_vfmw
	cmp	r6, #9
	mov	r2, r6
	bhi	.L2218
	b	.L2212
.L2193:
	ldr	r1, .L2219+60
	mov	r0, #1
	bl	dprint_vfmw
	cmp	r6, #9
	mov	r2, r6
	bhi	.L2218
	b	.L2212
.L2189:
	mov	r2, r10
	ldr	r1, .L2219+64
	mov	r0, #1
	mov	r8, #100
	bl	dprint_vfmw
	cmp	r6, #9
	mov	r2, r6
	bhi	.L2218
	b	.L2212
.L2216:
	ldr	ip, .L2219+68
	mov	r2, r3
	ldr	r0, [r5, #1300]
	mov	r3, #1
	add	r1, r6, #2208
	strb	r3, [r6, #2232]
	add	r0, r0, r7
	ldr	ip, [ip, #56]
	strb	r3, [r6, #2231]
	blx	ip
	b	.L2199
.L2215:
	mov	r3, r9
	movw	r2, #10716
	ldr	r1, .L2219+72
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2186
.L2217:
	mov	r3, r9
	movw	r2, #10741
	ldr	r1, .L2219+72
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r5, #1300]
	mov	r2, #1
	mvn	r0, #0
	add	r3, r3, r7
	strb	r2, [r3, #24]
	ldr	r3, [r5, #1300]
	add	r7, r3, r7
	strb	r6, [r7, #23]
	b	.L2186
.L2220:
	.align	2
.L2219:
	.word	.LC275
	.word	.LC276
	.word	.LC277
	.word	.LC278
	.word	.LC279
	.word	.LC280
	.word	.LC281
	.word	.LC282
	.word	.LC283
	.word	.LANCHOR2
	.word	.LC287
	.word	.LC289
	.word	.LC174
	.word	g_event_report
	.word	.LC285
	.word	.LC284
	.word	.LC286
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC288
	.fnend
	.size	H264_DecSPS, .-H264_DecSPS
	.align	2
	.global	PassBytes
	.type	PassBytes, %function
PassBytes:
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
	ldr	ip, [r0, #368]
	cmp	ip, #0
	cmpne	r1, #0
	beq	.L2230
	ldrb	r3, [ip]
	mov	r2, r3, asl #2
	mov	r5, r3, asl #5
	rsb	r4, r2, r5
	add	r4, ip, r4
	add	r6, r4, #8
	ldr	lr, [r4, #8]
	cmp	lr, #0
	beq	.L2230
	ldr	lr, [ip, #68]
	cmp	r3, #1
	cmpls	lr, #2
	bhi	.L2230
	cmp	lr, r3
	bls	.L2230
	ldr	lr, [r4, #12]
	mov	r6, r2
	ldr	r4, [r4, #24]
	mov	lr, lr, asl #3
	add	r1, r4, r1, lsl #3
	cmp	r1, lr
	bhi	.L2225
	b	.L2223
.L2226:
	ldr	r4, [r2, #24]
	ldr	r2, [r2, #12]
	rsb	lr, lr, r4
	add	r1, r1, lr
	mov	lr, r2, asl #3
	cmp	r1, lr
	bls	.L2223
.L2225:
	rsb	r2, r6, r5
	add	r3, r3, #1
	add	ip, ip, r2
	mov	r6, r3, asl #2
	mov	r5, r3, asl #5
	str	lr, [ip, #24]
	rsb	r2, r6, r5
	ldr	ip, [r0, #368]
	ldrb	r4, [ip]
	add	r4, r4, #1
	strb	r4, [ip]
	ldr	ip, [r0, #368]
	add	r2, ip, r2
	ldr	r4, [ip, #68]
	cmp	r4, r3
	bhi	.L2226
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2223:
	rsb	r2, r6, r5
	mov	r0, #1
	add	ip, ip, r2
	str	r1, [ip, #24]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2230:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	PassBytes, .-PassBytes
	.align	2
	.global	GetBytes
	.type	GetBytes, %function
GetBytes:
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
	beq	.L2245
	ldr	r3, [r0, #368]
	cmp	r3, #0
	cmpne	r2, #0
	ble	.L2245
	ldrb	r7, [r3]
	mov	ip, r7, asl #5
	sub	ip, ip, r7, asl #2
	add	ip, r3, ip
	ldr	ip, [ip, #8]
	cmp	ip, #0
	beq	.L2245
	ldr	ip, [r3, #68]
	cmp	r7, #1
	cmpls	ip, #2
	movhi	lr, #1
	movls	lr, #0
	bhi	.L2245
	cmp	ip, r7
	bls	.L2245
.L2240:
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
	bcs	.L2236
	ldrb	r3, [r8, r4, lsr #3]
	add	lr, lr, #1
	cmp	lr, r2
	add	r4, r1, #1
	add	ip, ip, #1
	strb	r3, [r1]
	b	.L2247
.L2238:
	cmp	ip, r6
	mov	r1, r4
	beq	.L2236
	ldrb	r3, [ip], #1
	add	lr, lr, #1
	cmp	lr, r2
	strb	r3, [r4], #1
.L2247:
	ldr	r3, [r0, #368]
	add	r3, r3, r5
	ldr	r1, [r3, #24]
	add	r1, r1, #8
	str	r1, [r3, #24]
	bcc	.L2238
	mov	r0, r2
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2236:
	ldr	ip, [r0, #368]
	add	r7, r7, #1
	ldrb	r3, [ip]
	add	r3, r3, #1
	strb	r3, [ip]
	ldr	r3, [r0, #368]
	ldr	ip, [r3, #68]
	cmp	ip, r7
	bhi	.L2240
	mov	r0, lr
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2245:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	GetBytes, .-GetBytes
	.align	2
	.global	H264_DecFramePackingSEI
	.type	H264_DecFramePackingSEI, %function
H264_DecFramePackingSEI:
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
	ldr	r1, .L2255
	mov	r5, r0
	bl	ue_v
	add	r4, r5, #24576
	ldr	r2, .L2255+4
	mov	r1, #1
	str	r0, [r4, #1840]
	mov	r0, r5
	bl	u_v
	uxtb	r0, r0
	strb	r0, [r4, #1817]
	cmp	r0, #0
	beq	.L2254
.L2249:
	mov	r0, r5
	ldr	r2, .L2255+8
	mov	r1, #1
	bl	u_v
	mov	r3, #1
	strb	r3, [r4, #1816]
	strb	r0, [r4, #1818]
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L2254:
	ldr	r2, .L2255+12
	mov	r1, #7
	mov	r0, r5
	bl	u_v
	ldr	r2, .L2255+16
	mov	r1, #1
	str	r0, [r4, #1832]
	mov	r0, r5
	bl	u_v
	ldr	r2, .L2255+20
	mov	r1, #6
	strb	r0, [r4, #1819]
	mov	r0, r5
	bl	u_v
	ldr	r2, .L2255+24
	mov	r1, #1
	str	r0, [r4, #1836]
	mov	r0, r5
	bl	u_v
	ldr	r2, .L2255+28
	mov	r1, #1
	strb	r0, [r4, #1820]
	mov	r0, r5
	bl	u_v
	ldr	r2, .L2255+32
	mov	r1, #1
	strb	r0, [r4, #1821]
	mov	r0, r5
	bl	u_v
	ldr	r2, .L2255+36
	mov	r1, #1
	strb	r0, [r4, #1822]
	mov	r0, r5
	bl	u_v
	ldr	r2, .L2255+40
	mov	r1, #1
	strb	r0, [r4, #1823]
	mov	r0, r5
	bl	u_v
	ldr	r2, .L2255+44
	mov	r1, #1
	strb	r0, [r4, #1824]
	mov	r0, r5
	bl	u_v
	ldrb	r3, [r4, #1819]
	cmp	r3, #0
	strb	r0, [r4, #1825]
	bne	.L2250
	ldr	r3, [r4, #1832]
	cmp	r3, #5
	beq	.L2250
	ldr	r2, .L2255+48
	mov	r1, #1
	mov	r0, r5
	bl	u_v
	ldr	r2, .L2255+52
	mov	r1, #1
	strb	r0, [r4, #1826]
	mov	r0, r5
	bl	u_v
	ldr	r2, .L2255+56
	mov	r1, #1
	strb	r0, [r4, #1827]
	mov	r0, r5
	bl	u_v
	ldr	r2, .L2255+60
	mov	r1, #1
	strb	r0, [r4, #1828]
	mov	r0, r5
	bl	u_v
	strb	r0, [r4, #1829]
.L2250:
	ldr	r2, .L2255+64
	mov	r1, #8
	mov	r0, r5
	bl	u_v
	ldr	r1, .L2255+68
	str	r0, [r4, #1844]
	mov	r0, r5
	bl	ue_v
	str	r0, [r4, #1848]
	b	.L2249
.L2256:
	.align	2
.L2255:
	.word	.LC290
	.word	.LC291
	.word	.LC307
	.word	.LC292
	.word	.LC293
	.word	.LC294
	.word	.LC295
	.word	.LC296
	.word	.LC297
	.word	.LC298
	.word	.LC299
	.word	.LC300
	.word	.LC301
	.word	.LC302
	.word	.LC303
	.word	.LC304
	.word	.LC305
	.word	.LC306
	.fnend
	.size	H264_DecFramePackingSEI, .-H264_DecFramePackingSEI
	.align	2
	.global	H264_Sei_Get_Dpb_Output_Time
	.type	H264_Sei_Get_Dpb_Output_Time, %function
H264_Sei_Get_Dpb_Output_Time:
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
	add	r2, r0, #12288
	add	r3, r0, #20480
	mov	r4, #2208
	ldr	lr, [r2, #1304]
	add	r0, r0, #24576
	ldr	r3, [r3, #220]
	mov	r1, #4000
	ldr	r6, [r2, #1300]
	ldr	ip, [r0, #1856]
	mla	r4, r4, r3, lr
	ldr	r3, [r0, #1868]
	ldr	lr, [r0, #1860]
	add	r3, r3, #1
	ldr	r2, [r0, #1872]
	subs	r5, r3, #1
	add	r2, r2, #1
	ldr	r4, [r4, #28]
	movne	r5, #1
	cmp	ip, #0
	str	ip, [r0, #1876]
	str	r2, [r0, #1872]
	mla	r1, r1, r4, r6
	movne	r5, #0
	cmp	r5, #0
	str	r3, [r0, #1868]
	str	lr, [r0, #1884]
	ldrne	ip, [r0, #1880]
	ldr	r2, [r1, #3344]
	addne	ip, ip, #2
	str	r2, [r0, #1920]
	ldr	r2, [r1, #3348]
	strne	ip, [r0, #1876]
	cmp	r3, #1
	str	r2, [r0, #1924]
	beq	.L2265
	ldrb	r3, [r0, #1945]
	add	r4, r0, #1872
	cmp	r3, #1
	ldrd	r2, [r4, #40]
	beq	.L2266
	adds	r2, r2, ip
	adc	r3, r3, #0
	strd	r2, [r4, #32]
.L2260:
	adds	r2, r2, lr
	mov	lr, #0
	adc	r3, r3, #0
	strb	lr, [r0, #1945]
	ldr	r4, [r1, #3368]
	movs	r3, r3, lsr #1
	mov	r2, r2, rrx
	ldr	r8, [r1, #3344]
	add	lr, r0, #1872
	subs	r6, r2, r4
	sbc	r7, r3, #0
	umull	r4, r5, r6, r8
	mla	r5, r8, r7, r5
	strd	r4, [lr, #16]
	ldr	r1, [r1, #3368]
	subs	r2, r2, r1
	sbc	r3, r3, #0
	strd	r2, [lr, #24]
	str	ip, [r0, #1880]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2265:
	mov	r6, #0
	str	r6, [r0, #1904]
	mov	r2, r6
	mov	r3, r6
	str	r6, [r0, #1912]
	str	r6, [r0, #1908]
	str	r6, [r0, #1916]
	b	.L2260
.L2266:
	adds	r2, r2, ip
	adc	r3, r3, #0
	strd	r2, [r4, #32]
	strd	r2, [r4, #40]
	b	.L2260
	.fnend
	.size	H264_Sei_Get_Dpb_Output_Time, .-H264_Sei_Get_Dpb_Output_Time
	.align	2
	.global	H264_Get_Last_IDR_Frame_Info
	.type	H264_Get_Last_IDR_Frame_Info, %function
H264_Get_Last_IDR_Frame_Info:
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
	cmp	r1, #5
	ldmnefd	sp, {r4, r5, fp, sp, pc}
	ldr	r1, [r0]
	mvn	r3, #0
	mvn	r2, #0
	ldrd	r4, [r1, #56]
	cmp	r5, r3
	cmpeq	r4, r2
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	add	r2, r0, #26368
	movw	r1, #26512
	add	r3, r2, #112
	strd	r4, [r2, #136]
	ldrd	r2, [r3, #-8]
	strd	r2, [r0, r1]
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	H264_Get_Last_IDR_Frame_Info, .-H264_Get_Last_IDR_Frame_Info
	.align	2
	.global	H264_Sei_Get_Frame_Pts
	.type	H264_Sei_Get_Frame_Pts, %function
H264_Sei_Get_Frame_Pts:
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
	add	r2, r0, #26368
	add	r1, r0, #24576
	mov	r4, r0
	movw	r0, #26512
	ldrd	r6, [r2, #136]
	mov	r3, r2
	ldr	r5, [r1, #1920]
	ldr	r10, [r1, #1924]
	strd	r6, [fp, #-52]
	cmp	r5, #0
	ldrd	r6, [r3, #104]
	ldrd	r2, [r4, r0]
	strd	r2, [fp, #-60]
	beq	.L2272
	mov	r9, r5
	mov	r0, r10
	b	.L2271
.L2273:
	mov	r9, r1
.L2271:
	mov	r1, r9
	bl	__aeabi_uidivmod
	mov	r0, r9
	cmp	r1, #0
	bne	.L2273
.L2270:
	ldrd	r2, [fp, #-60]
	mov	r1, r9
	mov	r0, r5
	mov	r8, #1000
	subs	r2, r6, r2
	movw	r5, #58384
	mul	r6, r8, r2
	bl	__aeabi_uidiv
	mov	r1, r9
	mul	r6, r0, r6
	mov	r0, r10
	bl	__aeabi_uidiv
	mov	r1, r0
	mov	r0, r6
	bl	__aeabi_uidiv
	ldrd	r2, [fp, #-52]
	adds	r2, r2, r0
	adc	r3, r3, #0
	mov	r0, r2
	mov	r1, r3
	strd	r0, [r4, r5]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2272:
	mov	r9, r10
	b	.L2270
	.fnend
	.size	H264_Sei_Get_Frame_Pts, .-H264_Sei_Get_Frame_Pts
	.align	2
	.global	H264_DecPicTimingSEI
	.type	H264_DecPicTimingSEI, %function
H264_DecPicTimingSEI:
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
	add	r2, r0, #12288
	mov	r4, #4000
	mov	r5, r0
	ldr	r1, [r2, #1344]
	ldr	r3, [r2, #1300]
	mla	r4, r4, r1, r3
	ldrb	r1, [r4, #23]
	cmp	r1, #0
	bne	.L2275
	ldr	ip, [r2, #1288]
	cmp	ip, #0
	ble	.L2276
	ldrb	r2, [r3, #23]
	cmp	r2, #0
	addeq	r3, r3, #4000
	beq	.L2279
	b	.L2297
.L2280:
	ldrb	r1, [r3, #-3977]
	cmp	r1, #0
	bne	.L2277
.L2279:
	add	r2, r2, #1
	mov	r4, r3
	cmp	r2, ip
	add	r3, r3, #4000
	bne	.L2280
.L2276:
	ldr	r1, .L2300
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r3, #0
.L2281:
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2297:
	mov	r4, r3
.L2277:
	cmp	r4, #0
	beq	.L2276
.L2275:
	ldrb	r3, [r4, #22]
	cmp	r3, #0
	beq	.L2283
	ldrb	r3, [r4, #3299]
	cmp	r3, #0
	beq	.L2298
	ldr	r1, [r4, #3676]
	ldr	r7, [r4, #3680]
	add	r1, r1, #1
	add	r7, r7, #1
.L2287:
	ldr	r2, .L2300+4
	mov	r0, r5
	bl	u_v
	add	r6, r5, #24576
	ldr	r2, .L2300+8
	mov	r1, r7
	str	r0, [r6, #1856]
	mov	r0, r5
	bl	u_v
	add	r3, r5, #57344
	ldr	r2, .L2300+12
	str	r0, [r6, #1860]
	ldr	r3, [r3, #3888]
	ldr	r3, [r2, r3, asl #2]
	ldrsb	r2, [r3, #160]
	cmp	r2, #1
	beq	.L2299
.L2283:
	ldrb	r0, [r4, #3303]
	cmp	r0, #0
	moveq	r3, r0
	beq	.L2281
	ldr	r2, .L2300+16
	mov	r1, #4
	mov	r0, r5
	add	r5, r5, #24576
	bl	u_v
	mov	r3, #0
	strb	r0, [r5, #1852]
	mov	r0, r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2298:
	ldrb	r3, [r4, #3302]
	cmp	r3, #0
	beq	.L2283
	ldr	r1, [r4, #3988]
	ldr	r7, [r4, #3992]
	add	r1, r1, #1
	add	r7, r7, #1
	b	.L2287
.L2299:
	ldr	r2, [r3, #168]
	cmp	r2, #0
	bne	.L2283
	ldr	r3, [r3, #172]
	cmp	r3, #1
	bne	.L2283
	mov	r0, r5
	bl	H264_Sei_Get_Dpb_Output_Time
	b	.L2283
.L2301:
	.align	2
.L2300:
	.word	.LC308
	.word	.LC309
	.word	.LC310
	.word	s_pstVfmwChan
	.word	.LC311
	.fnend
	.size	H264_DecPicTimingSEI, .-H264_DecPicTimingSEI
	.align	2
	.global	H264_DecSEI
	.type	H264_DecSEI, %function
H264_DecSEI:
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
	add	r10, r0, #57344
	ldr	r3, .L2570
	mov	r1, #0
	mov	r7, r0
	ldr	r2, [r10, #3888]
	strb	r1, [fp, #-45]
	ldr	r3, [r3, r2, asl #2]
	ldrsb	r2, [r3, #160]
	cmp	r2, #1
	beq	.L2535
.L2303:
	ldr	r3, [r7, #368]
	mov	r2, #32
	str	r2, [r3, #24]
.L2304:
	add	r6, r7, #13504
	add	r4, r7, #12288
	add	r6, r6, #24
	mov	r8, #0
	b	.L2307
.L2537:
	bl	BsSkip
	cmp	r5, #0
	ble	.L2306
	ldrb	r3, [fp, #-45]
	cmp	r3, #255
	bne	.L2536
.L2307:
	mov	r2, #1
	sub	r1, fp, #45
	mov	r0, r7
	bl	GetBytes
	ldr	r3, [r4, #1264]
	ldr	ip, [r4, #1256]
	mov	r1, #8
	add	r3, r3, r1
	ldrb	r2, [fp, #-45]
	cmp	r3, ip, asl #3
	add	r8, r8, r2
	mov	r5, r0
	mov	r0, r6
	ble	.L2537
.L2306:
	ldr	r1, .L2570+4
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2309
.L2536:
	mov	r3, #0
	str	r3, [fp, #-60]
.L2487:
	mov	r5, #0
	b	.L2313
.L2539:
	bl	BsSkip
	cmp	r9, #0
	ble	.L2311
	ldrb	r3, [fp, #-45]
	cmp	r3, #255
	bne	.L2538
.L2313:
	mov	r2, #1
	sub	r1, fp, #45
	mov	r0, r7
	bl	GetBytes
	ldr	r3, [r4, #1264]
	ldr	ip, [r4, #1256]
	mov	r1, #8
	add	r3, r3, r1
	ldrb	r2, [fp, #-45]
	cmp	r3, ip, asl #3
	add	r5, r5, r2
	mov	r9, r0
	mov	r0, r6
	ble	.L2539
.L2311:
	ldr	r1, .L2570+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
.L2309:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2538:
	cmp	r5, #409600
	bgt	.L2311
	ldr	r3, [r7, #368]
	ldr	r2, [r3, #68]
	cmp	r2, #2
	ldreq	r2, [r3, #52]
	ldreq	r3, [r3, #24]
	ldrne	r2, [r3, #24]
	addeq	r2, r2, r3
	moveq	r2, r2, lsr #3
	cmp	r8, #45
	ldrls	pc, [pc, r8, asl #2]
	b	.L2316
.L2318:
	.word	.L2317
	.word	.L2319
	.word	.L2320
	.word	.L2321
	.word	.L2322
	.word	.L2323
	.word	.L2324
	.word	.L2325
	.word	.L2326
	.word	.L2327
	.word	.L2328
	.word	.L2329
	.word	.L2330
	.word	.L2331
	.word	.L2332
	.word	.L2333
	.word	.L2334
	.word	.L2335
	.word	.L2336
	.word	.L2337
	.word	.L2338
	.word	.L2339
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2316
	.word	.L2340
.L2340:
	mov	r1, r5
	mov	r0, r7
	ldr	r8, [r4, #1264]
	bl	H264_DecFramePackingSEI
	ldr	r0, [r4, #1264]
	mov	r9, r5, asl #3
	rsb	r3, r8, r0
	cmp	r3, r9
	bge	.L2470
	rsb	r3, r3, r9
	str	r3, [fp, #-56]
	cmp	r3, #0
	add	r8, r3, #7
	movge	r8, r3
	ldr	r3, [r4, #1256]
	mov	r8, r8, asr #3
	cmp	r8, #0
	movle	r3, r3, asl #3
	ble	.L2472
	add	r2, r0, #8
	mov	r3, r3, asl #3
	cmp	r2, r3
	bgt	.L2472
	mov	r9, #0
	b	.L2473
.L2474:
	add	r2, r0, #8
	cmp	r2, r3
	bgt	.L2472
.L2473:
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	add	r9, r9, #1
	ldr	r3, [r4, #1256]
	cmp	r9, r8
	ldr	r0, [r4, #1264]
	mov	r3, r3, asl #3
	bne	.L2474
.L2472:
	ldr	r2, [fp, #-56]
	mov	r1, r2, asr #31
	mov	r1, r1, lsr #29
	add	r2, r2, r1
	and	r2, r2, #7
	rsb	r1, r1, r2
	add	r2, r0, r1
	cmp	r3, r2
	bge	.L2540
.L2470:
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2541
.L2531:
	ldr	r3, [r10, #2504]
.L2343:
	cmp	r3, #3
	bhi	.L2542
.L2482:
	mov	r8, #0
	b	.L2486
.L2484:
	bl	BsSkip
	cmp	r5, #0
	ble	.L2485
	ldrb	r3, [fp, #-45]
	cmp	r3, #255
	bne	.L2543
.L2486:
	mov	r2, #1
	sub	r1, fp, #45
	mov	r0, r7
	bl	GetBytes
	ldr	r3, [r4, #1264]
	ldr	ip, [r4, #1256]
	mov	r1, #8
	add	r3, r3, r1
	ldrb	r2, [fp, #-45]
	cmp	r3, ip, asl #3
	add	r8, r8, r2
	mov	r5, r0
	mov	r0, r6
	ble	.L2484
.L2485:
	mov	r0, #0
.L2568:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2339:
	mov	r3, r5
	ldr	r1, .L2570+12
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2544
.L2464:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2467
.L2468:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2467:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2468
	b	.L2531
.L2338:
	mov	r3, r5
	ldr	r1, .L2570+16
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2545
.L2459:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2462
.L2463:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2462:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2463
	b	.L2531
.L2335:
	mov	r3, r5
	ldr	r1, .L2570+20
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2546
.L2444:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2447
.L2448:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2447:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2448
	b	.L2531
.L2334:
	mov	r3, r5
	ldr	r1, .L2570+24
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2547
.L2439:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2442
.L2443:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2442:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2443
	b	.L2531
.L2333:
	mov	r3, r5
	ldr	r1, .L2570+28
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2548
.L2434:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2437
.L2438:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2437:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2438
	b	.L2531
.L2332:
	mov	r3, r5
	ldr	r1, .L2570+32
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2549
.L2429:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2432
.L2433:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2432:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2433
	b	.L2531
.L2337:
	mov	r3, r5
	ldr	r1, .L2570+36
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2550
.L2454:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2457
.L2458:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2457:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2458
	b	.L2531
.L2336:
	mov	r3, r5
	ldr	r1, .L2570+40
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2551
.L2449:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2452
.L2453:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2452:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2453
	b	.L2531
.L2331:
	mov	r3, r5
	ldr	r1, .L2570+44
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2552
.L2424:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2427
.L2428:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2427:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2428
	b	.L2531
.L2330:
	mov	r3, r5
	ldr	r1, .L2570+48
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2553
.L2419:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2422
.L2423:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2422:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2423
	b	.L2531
.L2329:
	mov	r3, r5
	ldr	r1, .L2570+52
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2554
.L2414:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2417
.L2418:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2417:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2418
	b	.L2531
.L2328:
	mov	r3, r5
	ldr	r1, .L2570+56
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2555
.L2409:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2412
.L2413:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2412:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2413
	b	.L2531
.L2327:
	mov	r3, r5
	ldr	r1, .L2570+60
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2556
.L2404:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2407
.L2408:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2407:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2408
	b	.L2531
.L2326:
	mov	r3, r5
	ldr	r1, .L2570+64
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2557
.L2399:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2402
.L2403:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2402:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2403
	b	.L2531
.L2325:
	mov	r3, r5
	ldr	r1, .L2570+68
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2558
.L2394:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2397
.L2398:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2397:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2398
	b	.L2531
.L2324:
	mov	r3, r5
	ldr	r1, .L2570+72
	mov	r0, #20
	bl	dprint_vfmw
	cmp	r5, #0
	ble	.L2391
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2391
	mov	r8, #0
	b	.L2392
.L2393:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2391
.L2392:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2393
.L2391:
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	bge	.L2531
	movw	r3, #11583
	b	.L2532
.L2323:
	ldr	r3, [fp, #-60]
	cmp	r3, #0
	bne	.L2322
	mov	r3, r5
	ldr	r1, .L2570+76
	mov	r0, #20
	bl	dprint_vfmw
	ldr	r8, [r10, #2504]
	cmp	r8, #3
	bhi	.L2559
.L2367:
	ldr	r0, [r10, #3888]
	bl	GetUsd
	add	r3, r8, #14912
	add	r3, r3, #50
	add	r3, r7, r3, lsl #2
	str	r0, [r3, #4]
	ldr	r3, [r10, #2504]
	add	r3, r3, #14912
	add	r3, r3, #50
	add	r3, r7, r3, lsl #2
	ldr	lr, [r3, #4]
	cmp	lr, #0
	beq	.L2490
	ldr	r2, [r7, #368]
	cmp	r5, #1024
	movlt	r3, r5
	movge	r3, #1024
	ldrb	r0, [r2]
	ldr	ip, [r2, #68]
	str	r3, [fp, #-56]
	cmp	r0, ip
	bcs	.L2491
	sxth	r3, r0
	mov	r8, #0
	mov	r1, r3, asl #5
	sub	r1, r1, r3, asl #2
	add	r1, r2, r1
.L2369:
	ldr	r3, [r1, #24]
	add	r0, r0, #1
	ldr	r2, [r1, #12]
	cmp	r0, ip
	add	r3, r3, #7
	add	r1, r1, #28
	sub	r3, r2, r3, lsr #3
	add	r8, r8, r3
	bne	.L2369
	mov	r2, r8
.L2368:
	ldr	r1, [fp, #-56]
	ldrsb	r3, [fp, #-60]
	cmp	r1, r2
	movle	r8, r1
	cmp	r3, #1
	movne	r3, #0
	movne	r9, r3
	beq	.L2560
.L2371:
	rsb	r2, r3, r8
	cmp	r2, #0
	ble	.L2561
	ldr	r3, [r10, #2504]
	mov	r0, r7
	add	r3, r3, #14912
	add	r3, r3, #50
	add	r3, r7, r3, lsl #2
	ldr	r1, [r3, #4]
	bl	GetBytes
	subs	r8, r0, #0
	ble	.L2562
	ldr	r3, [fp, #-56]
	rsb	r3, r9, r3
	cmp	r8, r3
	ldr	r3, [r10, #2504]
	bge	.L2377
	add	r3, r3, #14912
	add	r3, r3, #50
	add	r3, r7, r3, lsl #2
	ldr	r3, [r3, #4]
	str	r8, [r3, #1052]
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2378
	mov	r5, #0
	b	.L2379
.L2382:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2378
.L2379:
	add	r5, r5, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2382
.L2378:
	ldr	r3, [r10, #2504]
	mov	r2, #8
	ldr	r1, [r7]
	add	r3, r3, #14912
	ldr	ip, .L2570+80
	add	r3, r3, #50
	ldrd	r0, [r1, #56]
	add	r3, r7, r3, lsl #2
	ldr	ip, [ip]
	ldr	r3, [r3, #4]
	cmp	ip, #0
	add	r3, r3, #1056
	strd	r0, [r3]
	ldr	r3, [r10, #2504]
	add	r3, r3, #14912
	add	r3, r3, #50
	add	r3, r7, r3, lsl #2
	ldr	r3, [r3, #4]
	str	r2, [r3, #1040]
	ldr	r3, [r10, #2504]
	ldr	r2, [r10, #3848]
	add	r3, r3, #14912
	add	r3, r3, #50
	add	r3, r7, r3, lsl #2
	ldr	r3, [r3, #4]
	str	r2, [r3, #1044]
	beq	.L2381
	ldr	r2, [r10, #2504]
	movw	r3, #1064
	mov	r1, #6
	ldr	r0, [r10, #3888]
	add	r2, r2, #14912
	add	r2, r2, #50
	add	r2, r7, r2, lsl #2
	ldr	r2, [r2, #4]
	blx	ip
.L2381:
	ldr	r3, [r10, #2504]
	add	r3, r3, #1
	str	r3, [r10, #2504]
	cmp	r3, #3
	bls	.L2482
.L2542:
	ldr	r1, .L2570+84
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2309
.L2319:
	mov	r3, r5
	ldr	r1, .L2570+88
	mov	r0, #20
	mov	r9, r5, asl #3
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	ldr	r8, [r4, #1264]
	bl	H264_DecPicTimingSEI
	ldr	r2, [r4, #1264]
	rsb	r3, r8, r2
	cmp	r3, r9
	bge	.L2348
	rsb	r3, r3, r9
	str	r3, [fp, #-56]
	cmp	r3, #0
	add	r8, r3, #7
	movge	r8, r3
	ldr	r3, [r4, #1256]
	mov	r8, r8, asr #3
	cmp	r8, #0
	movle	r3, r3, asl #3
	ble	.L2350
	add	r1, r2, #8
	mov	r3, r3, asl #3
	cmp	r1, r3
	bgt	.L2350
	mov	r9, #0
	b	.L2351
.L2352:
	add	r1, r2, #8
	cmp	r1, r3
	bgt	.L2350
.L2351:
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	add	r9, r9, #1
	ldr	r3, [r4, #1256]
	cmp	r9, r8
	ldr	r2, [r4, #1264]
	mov	r3, r3, asl #3
	bne	.L2352
.L2350:
	ldr	ip, [fp, #-56]
	mov	r1, ip, asr #31
	mov	r0, r1, lsr #29
	add	r1, ip, r0
	and	r1, r1, #7
	rsb	r1, r0, r1
	add	r2, r1, r2
	cmp	r2, r3
	ble	.L2563
.L2348:
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	bge	.L2531
	movw	r3, #11331
.L2532:
	ldr	r2, .L2570+116
	mov	r0, #20
	ldr	r1, .L2570+120
	bl	dprint_vfmw
	ldr	r3, [r10, #2504]
	b	.L2343
.L2317:
	add	r1, r7, #24576
	mov	lr, #1
	mov	r0, #0
	mov	r3, r5
	ldr	ip, [r1, #1864]
	str	r0, [r1, #1872]
	mov	r0, #20
	add	ip, ip, lr
	strb	lr, [r1, #1945]
	str	ip, [r1, #1864]
	ldr	r1, .L2570+92
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2564
.L2341:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2345
.L2346:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2345:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2346
	b	.L2531
.L2321:
	mov	r3, r5
	ldr	r1, .L2570+96
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2565
.L2360:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2363
.L2364:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2363:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2364
	b	.L2531
.L2320:
	mov	r3, r5
	ldr	r1, .L2570+100
	mov	r0, #20
	bl	dprint_vfmw
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2566
.L2355:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2358
.L2359:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2358:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2359
	b	.L2531
.L2322:
	mov	r3, r5
	ldr	r1, .L2570+104
	mov	r0, #20
	bl	dprint_vfmw
	ldr	r8, [r10, #2504]
	mov	r3, #1
	str	r3, [fp, #-60]
	cmp	r8, #3
	bls	.L2367
.L2559:
	ldr	r1, [r10, #2508]
	ldr	r0, [r10, #3888]
	bl	FreeUsdByDec
	ldr	r1, [r10, #2512]
	ldr	r0, [r10, #3888]
	bl	FreeUsdByDec
	ldr	r1, [r10, #2516]
	ldr	r0, [r10, #3888]
	bl	FreeUsdByDec
	ldr	r1, [r10, #2520]
	ldr	r0, [r10, #3888]
	bl	FreeUsdByDec
	mov	r3, #0
	mov	r8, r3
	str	r3, [r10, #2508]
	str	r3, [r10, #2512]
	str	r3, [r10, #2516]
	str	r3, [r10, #2520]
	str	r3, [r10, #2504]
	b	.L2367
.L2571:
	.align	2
.L2570:
	.word	s_pstVfmwChan
	.word	.LC312
	.word	.LC313
	.word	.LC341
	.word	.LC340
	.word	.LC337
	.word	.LC336
	.word	.LC335
	.word	.LC334
	.word	.LC339
	.word	.LC338
	.word	.LC333
	.word	.LC332
	.word	.LC331
	.word	.LC330
	.word	.LC329
	.word	.LC328
	.word	.LC327
	.word	.LC326
	.word	.LC320
	.word	g_event_report
	.word	.LC342
	.word	.LC316
	.word	.LC314
	.word	.LC318
	.word	.LC317
	.word	.LC319
	.word	.LC321
	.word	.LC323
	.word	.LANCHOR1+216
	.word	.LC315
	.word	.LC322
	.word	.LC324
	.word	.LC325
.L2316:
	mov	r1, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	blt	.L2567
.L2477:
	cmp	r5, #0
	ble	.L2531
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
	mov	r8, #0
	b	.L2480
.L2481:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2531
.L2480:
	add	r8, r8, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r8
	bne	.L2481
	b	.L2531
.L2543:
	cmp	r3, #128
	bne	.L2487
	mov	r0, #0
	b	.L2568
.L2377:
	add	r3, r3, #14912
	ldr	r2, [fp, #-56]
	add	r3, r3, #50
	rsb	r9, r9, r5
	cmp	r2, r5
	add	r3, r7, r3, lsl #2
	ldr	r3, [r3, #4]
	str	r9, [r3, #1052]
	bcc	.L2569
.L2384:
	cmp	r9, #0
	ble	.L2378
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2378
	mov	r5, #0
	b	.L2386
.L2387:
	ldr	r3, [r4, #1264]
	ldr	r2, [r4, #1256]
	add	r3, r3, #8
	cmp	r3, r2, asl #3
	bgt	.L2378
.L2386:
	add	r5, r5, #1
	mov	r1, #8
	mov	r0, r6
	bl	BsSkip
	cmp	r5, r9
	bne	.L2387
	b	.L2378
.L2535:
	ldr	r2, [r3, #168]
	cmp	r2, r1
	bne	.L2303
	ldr	r2, [r3, #172]
	cmp	r2, #1
	bne	.L2303
	ldr	r3, [r3, #164]
	cmp	r3, #1
	bne	.L2303
	ldr	r3, [r0, #368]
	mov	r2, #48
	str	r2, [r3, #24]
	b	.L2304
.L2563:
	mov	r0, r6
	bl	BsSkip
	b	.L2348
.L2541:
	movw	r3, #12011
	b	.L2532
.L2540:
	mov	r0, r6
	bl	BsSkip
	b	.L2470
.L2560:
	strb	r3, [lr, #1026]
	mov	r1, #8
	ldr	r3, [r10, #2504]
	mov	r0, r7
	ldr	r2, .L2570+108
	add	r3, r3, #14912
	add	r3, r3, #50
	add	r3, r7, r3, lsl #2
	ldr	r9, [r3, #4]
	bl	u_v
	strb	r0, [r9, #1027]
	ldr	r3, [r10, #2504]
	add	r3, r3, #14912
	add	r3, r3, #50
	add	r3, r7, r3, lsl #2
	ldr	ip, [r3, #4]
	ldrb	r3, [ip, #1027]
	cmp	r3, #255
	beq	.L2372
	mov	r3, #3
	mov	r2, #0
	mov	r9, r3
	strb	r2, [ip, #1028]
.L2373:
	ldr	ip, [r10, #2504]
	mov	r1, #16
	ldr	r2, .L2570+112
	mov	r0, r7
	add	ip, ip, #14912
	str	r3, [fp, #-64]
	add	ip, ip, #50
	add	ip, r7, ip, lsl #2
	ldr	ip, [ip, #4]
	str	ip, [fp, #-68]
	bl	u_v
	ldr	ip, [fp, #-68]
	ldr	r3, [fp, #-64]
	add	ip, ip, #1024
	mov	r1, r3
	strh	r0, [ip, #6]
	mov	r0, r7
	bl	PassBytes
	ldr	r3, [fp, #-64]
	cmp	r8, r3
	bne	.L2371
	b	.L2378
.L2569:
	rsb	r1, r2, r5
	mov	r0, r7
	bl	PassBytes
	cmp	r0, #0
	bge	.L2384
	movw	r3, #11530
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2384
.L2491:
	mov	r2, #0
	mov	r8, r2
	b	.L2368
.L2567:
	movw	r3, #12023
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2477
.L2566:
	movw	r3, #11343
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2355
.L2565:
	movw	r3, #11369
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2360
.L2564:
	movw	r3, #11278
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2341
.L2558:
	movw	r3, #11595
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2394
.L2557:
	movw	r3, #11621
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2399
.L2556:
	movw	r3, #11647
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2404
.L2555:
	movw	r3, #11673
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2409
.L2554:
	movw	r3, #11699
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2414
.L2553:
	movw	r3, #11725
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2419
.L2552:
	movw	r3, #11751
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2424
.L2551:
	movw	r3, #11881
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2449
.L2550:
	movw	r3, #11907
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2454
.L2549:
	movw	r3, #11777
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2429
.L2548:
	movw	r3, #11803
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2434
.L2547:
	movw	r3, #11829
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2439
.L2546:
	movw	r3, #11855
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2444
.L2545:
	movw	r3, #11933
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2459
.L2544:
	movw	r3, #11959
	ldr	r2, .L2570+116
	ldr	r1, .L2570+120
	mov	r0, #20
	bl	dprint_vfmw
	b	.L2464
.L2490:
	mvn	r0, #0
	b	.L2309
.L2372:
	ldr	r2, .L2570+124
	mov	r1, #8
	mov	r0, r7
	mov	r3, #4
	str	ip, [fp, #-68]
	str	r3, [fp, #-64]
	bl	u_v
	ldr	r3, [fp, #-64]
	ldr	ip, [fp, #-68]
	mov	r9, r3
	strb	r0, [ip, #1028]
	b	.L2373
.L2561:
	ldr	r1, .L2570+128
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r10, #2504]
	ldr	r0, [r10, #3888]
	add	r3, r3, #14912
	add	r3, r3, #50
	add	r3, r7, r3, lsl #2
	ldr	r1, [r3, #4]
	bl	FreeUsdByDec
	ldr	r3, [r10, #2504]
	mov	r2, #0
	mvn	r0, #0
	add	r3, r3, #14912
	add	r3, r3, #50
	add	r3, r7, r3, lsl #2
	str	r2, [r3, #4]
	b	.L2309
.L2562:
	ldr	r1, .L2570+132
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r10, #2504]
	ldr	r0, [r10, #3888]
	add	r3, r3, #14912
	add	r3, r3, #50
	add	r3, r7, r3, lsl #2
	ldr	r1, [r3, #4]
	bl	FreeUsdByDec
	ldr	r3, [r10, #2504]
	mov	r2, #0
	mvn	r0, #0
	add	r3, r3, #14912
	add	r3, r3, #50
	add	r7, r7, r3, lsl #2
	str	r2, [r7, #4]
	b	.L2309
	.fnend
	.size	H264_DecSEI, .-H264_DecSEI
	.align	2
	.global	InitOldSlice
	.type	InitOldSlice, %function
InitOldSlice:
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
	add	r2, r0, #12288
	add	r0, r0, #20480
	movw	r3, #23352
	ldr	r1, [r2, #1292]
	movt	r3, 1
	mov	r2, #2
	str	r3, [r0, #1872]
	strb	r2, [r0, #1857]
	mov	r3, #32
	mov	r2, #7
	strb	r3, [r0, #1858]
	str	r2, [r0, #1868]
	mvn	r3, #0
	mov	r2, #3
	str	r3, [r0, #1884]
	str	r2, [r0, #1880]
	mov	r3, #0
	mov	r2, #262144
	str	r1, [r0, #1864]
	str	r2, [r0, #1896]
	strb	r3, [r0, #1856]
	str	r3, [r0, #1888]
	str	r3, [r0, #1892]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	InitOldSlice, .-InitOldSlice
	.align	2
	.global	H264_IsNewPicNal
	.type	H264_IsNewPicNal, %function
H264_IsNewPicNal:
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
	b	.L2581
.L2576:
	.word	.L2575
	.word	.L2581
	.word	.L2581
	.word	.L2581
	.word	.L2575
	.word	.L2581
	.word	.L2577
	.word	.L2577
.L2577:
	ldr	r3, [r0]
	mov	r2, #1
	str	r2, [r0]
	adds	r3, r3, #0
	movne	r3, #1
	rsb	r0, r3, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L2575:
	ldr	r3, [r0]
	cmp	r3, #0
	beq	.L2578
.L2580:
	mvn	r0, #0
.L2579:
	mov	r2, #0
	str	r2, [r5]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L2581:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L2578:
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
	bhi	.L2580
	mov	r3, r0, asl #1
	rsb	r3, r3, #31
	mov	r3, r4, lsr r3
	subs	r0, r3, #1
	mvnne	r0, #0
	b	.L2579
	.fnend
	.size	H264_IsNewPicNal, .-H264_IsNewPicNal
	.align	2
	.global	FindZeroBitsInSeg
	.type	FindZeroBitsInSeg, %function
FindZeroBitsInSeg:
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
	ble	.L2608
	ldr	r3, [fp, #-48]
	subs	r7, r3, #0
	add	r8, r3, #63
	movge	r8, r3
	ands	r3, r3, #63
	movne	r3, #1
	add	r8, r3, r8, asr #6
	cmp	r8, #0
	ble	.L2596
	ldr	r5, .L2609
	ldr	r10, .L2609+4
.L2594:
	cmp	r7, #64
	ldr	r3, [r10, #52]
	ldr	r0, .L2609
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
	bne	.L2586
	ldr	r2, .L2609
	add	r4, r4, #1
	cmp	r3, r2
	bne	.L2589
	b	.L2587
.L2590:
	cmp	r3, r5
	add	r4, r4, #1
	beq	.L2587
.L2589:
	ldrb	r2, [r3, #-1]!
	cmp	r2, #0
	beq	.L2590
.L2586:
	mov	r0, r4, asl #3
.L2585:
	ldr	r3, [fp, #-48]
	cmp	r4, r3
	bge	.L2598
	sub	r3, r3, #1
	rsb	r4, r4, r3
	ldrb	r2, [r9, r4]
	tst	r2, #1
	moveq	r2, r2, lsr #1
	moveq	r3, #1
	bne	.L2598
.L2593:
	tst	r2, #1
	mov	r2, r2, lsr #1
	bne	.L2591
	add	r3, r3, #1
	cmp	r3, #8
	bne	.L2593
	b	.L2591
.L2587:
	subs	r8, r8, #1
	sub	r7, r7, #64
	bne	.L2594
	b	.L2586
.L2598:
	mov	r3, #0
.L2591:
	add	r0, r3, r0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2608:
	mov	r2, r1
	mov	r0, #0
	ldr	r1, .L2609+8
	bl	dprint_vfmw
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2596:
	mov	r0, r4
	b	.L2585
.L2610:
	.align	2
.L2609:
	.word	.LANCHOR3-1976
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC343
	.fnend
	.size	FindZeroBitsInSeg, .-FindZeroBitsInSeg
	.align	2
	.global	FindTrailZeros
	.type	FindTrailZeros, %function
FindTrailZeros:
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
	beq	.L2617
	ldr	r3, [r4, #368]
	ldr	r2, [r3, #68]
	cmp	r2, #1
	bls	.L2616
	ldr	r1, [r3, #40]
	ldr	r0, [r3, #36]
	bl	FindZeroBitsInSeg
	ldr	r3, [r4, #368]
	ldr	r2, [r3, #40]
	cmp	r0, r2, asl #3
	bcs	.L2620
	cmn	r0, #1
	beq	.L2616
.L2615:
	add	r0, r0, #1
	str	r0, [r3, #72]
	ldr	r3, [r4, #368]
	ldr	r2, [r3, #68]
	cmp	r2, #1
	bls	.L2619
	ldr	r1, [r3, #40]
	ldr	r2, [r3, #72]
	cmp	r2, r1, asl #3
	bcs	.L2621
.L2619:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L2621:
	add	r2, r4, #57344
	ldr	r1, [r3, #60]
	ldr	r0, [r2, #3888]
	bl	SM_ReleaseStreamSeg
	ldr	r2, [r4, #368]
	mov	r3, #0
	mov	r1, #1
	mov	r0, r3
	str	r3, [r2, #36]
	ldr	r2, [r4, #368]
	str	r1, [r2, #68]
	ldr	r2, [r4, #368]
	str	r3, [r2, #72]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L2620:
	add	r2, r4, #57344
	ldr	r1, [r3, #60]
	ldr	r0, [r2, #3888]
	bl	SM_ReleaseStreamSeg
	ldr	r3, [r4, #368]
	mov	r1, #0
	mov	r2, #1
	str	r1, [r3, #36]
	ldr	r3, [r4, #368]
	str	r2, [r3, #68]
	ldr	r3, [r4, #368]
.L2616:
	ldr	r1, [r3, #12]
	ldr	r0, [r3, #8]
	bl	FindZeroBitsInSeg
	ldr	r3, [r4, #368]
	b	.L2615
.L2617:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	FindTrailZeros, .-FindTrailZeros
	.align	2
	.global	CombinePacket
	.type	CombinePacket, %function
CombinePacket:
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
	ldr	r3, [r0, #368]
	ldr	r3, [r3, #12]
	cmp	r3, #4096
	ldmcsfd	sp, {fp, sp, pc}
	bl	CombinePacket.part.11
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	CombinePacket, .-CombinePacket
	.align	2
	.global	FindNaluArraySlot
	.type	FindNaluArraySlot, %function
FindNaluArraySlot:
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
	mov	ip, r0
	ldrb	r0, [r0, #377]
	cmp	r0, #0
	beq	.L2629
	mov	r2, ip
	mov	r3, #1
	b	.L2627
.L2626:
	add	r3, r3, #1
	cmp	r3, #137
	beq	.L2632
.L2627:
	ldrb	r1, [r2, #473]
	add	r2, r2, #96
	cmp	r1, #0
	bne	.L2626
	mov	r0, r3
.L2625:
	mov	r2, r3, asl #7
	mov	r1, #1
	sub	r3, r2, r3, asl #5
	add	ip, ip, r3
	strb	r1, [ip, #377]
	ldmfd	sp, {fp, sp, pc}
.L2632:
	mvn	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L2629:
	mov	r3, r0
	b	.L2625
	.fnend
	.size	FindNaluArraySlot, .-FindNaluArraySlot
	.align	2
	.global	InquireSliceExtProperty
	.type	InquireSliceExtProperty, %function
InquireSliceExtProperty:
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
	add	r0, r0, #13504
	mov	r1, #24
	add	r0, r0, #24
	bl	BsGet
	ldr	r3, [r4, #368]
	ubfx	r2, r0, #23, #1
	strb	r2, [r3, #3]
	ldr	r2, [r4, #368]
	ldrb	r3, [r2, #3]
	cmp	r3, #0
	add	r3, r4, #57344
	ldreqb	r0, [r3, #1852]
	beq	.L2635
	ubfx	lr, r0, #16, #6
	ubfx	ip, r0, #15, #1
	ubfx	r1, r0, #12, #3
	strb	lr, [r3, #1853]
	strb	ip, [r3, #1854]
	ubfx	lr, r0, #8, #4
	ubfx	ip, r0, #5, #3
	strb	r1, [r3, #1855]
	strb	lr, [r3, #1856]
	ubfx	r1, r0, #4, #1
	ubfx	lr, r0, #3, #1
	strb	ip, [r3, #1857]
	strb	r1, [r3, #1858]
	ubfx	ip, r0, #2, #1
	and	r1, r0, #3
	strb	lr, [r3, #1859]
	ubfx	r0, r0, #22, #1
	strb	ip, [r3, #1860]
	strb	r1, [r3, #1861]
	strb	r0, [r3, #1852]
.L2635:
	cmp	r0, #1
	mov	r0, #0
	moveq	r3, #5
	streqb	r3, [r2, #2]
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	InquireSliceExtProperty, .-InquireSliceExtProperty
	.align	2
	.global	InquireSliceProperty
	.type	InquireSliceProperty, %function
InquireSliceProperty:
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
	add	r6, r0, #57344
	mov	r5, r2
	mov	r4, r0
	ldr	r2, [r6, #3832]
	mov	r9, r1
	mov	r0, #22
	ldr	r1, .L2657
	sub	r2, r2, #1
	add	r8, r4, #20480
	bl	dprint_vfmw
	mov	r3, #0
	str	r3, [r5]
	mov	r0, r4
	str	r3, [r9]
	ldr	r3, [r4, #368]
	ldrb	r2, [r3, #2]
	strb	r2, [r8, #211]
	ldr	r3, [r3, #76]
	str	r3, [r8, #240]
	bl	SliceCheck
	subs	r7, r0, #0
	bne	.L2645
	mov	r0, r4
	bl	ProcessSliceHeaderFirstPart
	cmp	r0, #0
	bne	.L2656
	ldrb	r0, [r8, #213]
	add	r2, r4, #12288
	mov	r1, #2208
	mov	lr, #4000
	sub	r0, r0, #1
	add	r4, r4, #24576
	clz	r0, r0
	mov	r0, r0, lsr #5
	str	r0, [r9]
	ldr	ip, [r8, #220]
	ldr	r8, [r2, #1304]
	ldr	r3, [r2, #1300]
	ldr	r0, [r2, #1276]
	mla	r1, r1, ip, r8
	ldr	ip, [r2, #1280]
	ldr	r2, [r1, #28]
	mla	r3, lr, r2, r3
	ldrb	r2, [r3, #18]
	ldr	lr, [r3, #3252]
	rsb	r1, r2, #2
	ldr	r2, [r3, #3248]
	mla	r1, lr, r1, r1
	add	r2, r2, #1
	cmp	r0, r2
	cmpeq	ip, r1
	beq	.L2640
	mov	r2, #1
	str	r2, [r5]
	ldr	r2, [r4, #2144]
	ldr	r1, [r3, #3272]
	add	r3, r2, #1
	cmp	r1, r3
	bls	.L2642
.L2641:
	mov	r3, #1
	str	r3, [r5]
.L2642:
	ldr	r3, [r6, #3852]
	cmp	r3, #0
	cmpne	r0, #0
	beq	.L2638
	ldr	r3, .L2657+4
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L2638
	mov	r3, #0
	ldr	r0, [r6, #3888]
	mov	r2, r3
	mov	r1, #120
	blx	ip
.L2638:
	mov	r0, r7
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2640:
	ldr	r2, [r3, #3272]
	ldr	r3, [r4, #2144]
	add	r3, r3, #1
	cmp	r2, r3
	bhi	.L2641
	ldr	r3, [r5]
	cmp	r3, #1
	beq	.L2642
	mov	r0, r7
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2645:
	mvn	r7, #0
	b	.L2638
.L2656:
	ldr	r1, .L2657+8
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r7, #0
	b	.L2638
.L2658:
	.align	2
.L2657:
	.word	.LC344
	.word	g_event_report
	.word	.LC345
	.fnend
	.size	InquireSliceProperty, .-InquireSliceProperty
	.align	2
	.global	HaveSliceToDec
	.type	HaveSliceToDec, %function
HaveSliceToDec:
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
	add	r0, r0, #57344
	ldr	r0, [r0, #3812]
	clz	r0, r0
	mov	r0, r0, lsr #5
	rsb	r0, r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HaveSliceToDec, .-HaveSliceToDec
	.align	2
	.global	IsRefListWrong
	.type	IsRefListWrong, %function
IsRefListWrong:
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
	add	r6, r0, #20480
	mov	r7, r0
	ldr	r3, [r6, #252]
	cmp	r3, #0
	beq	.L2661
	add	r5, r0, #26880
	add	r8, r0, #57344
	add	r5, r5, #248
	mov	r4, #0
	b	.L2665
.L2662:
	ldr	r3, [r0, #608]
	cmp	r3, #0
	beq	.L2664
	ldr	r3, [r6, #252]
	cmp	r4, r3
	bcs	.L2687
.L2665:
	ldr	r3, [r5, #4]!
	add	r4, r4, #1
	ldr	r0, [r8, #3888]
	ldr	r3, [r3, #32]
	ldr	r1, [r3, #600]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	bne	.L2662
.L2664:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2687:
	cmp	r3, #0
	beq	.L2661
	ldr	r3, [r6, #256]
	cmp	r3, #0
	addne	r7, r7, #27136
	movne	r4, #0
	addne	r7, r7, #124
	bne	.L2668
	b	.L2661
.L2688:
	ldr	r3, [r0, #608]
	cmp	r3, #0
	beq	.L2664
	ldr	r3, [r6, #256]
	cmp	r4, r3
	bcs	.L2661
.L2668:
	ldr	r3, [r7, #4]!
	add	r4, r4, #1
	ldr	r0, [r8, #3888]
	ldr	r3, [r3, #32]
	ldr	r1, [r3, #600]
	bl	FSP_GetLogicFs
	cmp	r0, #0
	bne	.L2688
	b	.L2664
.L2661:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	IsRefListWrong, .-IsRefListWrong
	.align	2
	.global	H264DEC_Destroy
	.type	H264DEC_Destroy, %function
H264DEC_Destroy:
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
	add	r5, r0, #57344
	mov	r8, r0
	bl	H264_ClearCurrPic
	mov	r0, r8
	bl	ClearAllNal
	ldr	r3, [r5, #3824]
	cmp	r3, #1
	moveq	r3, #0
	streq	r3, [r5, #3824]
	ldr	r3, [r5, #2504]
	cmp	r3, #0
	beq	.L2691
	add	r6, r8, #59648
	mov	r4, #0
	add	r6, r6, #200
	mov	r7, r4
.L2693:
	ldr	r1, [r6, #4]!
	add	r4, r4, #1
	cmp	r1, #0
	beq	.L2692
	ldr	r0, [r5, #3888]
	bl	FreeUsdByDec
	str	r7, [r6]
.L2692:
	ldr	r3, [r5, #2504]
	cmp	r3, r4
	bhi	.L2693
.L2691:
	add	r9, r8, #27904
	add	r8, r8, #58112
	add	r9, r9, #56
	add	r8, r8, #248
	mov	r6, #0
	mov	r7, #0
.L2697:
	sub	r4, r9, #32
.L2695:
	ldrd	r2, [r4, #8]!
	orrs	r1, r2, r3
	bne	.L2710
.L2694:
	cmp	r4, r9
	bne	.L2695
	add	r9, r4, #760
	cmp	r9, r8
	bne	.L2697
	ldr	r1, .L2711
	mov	r0, #2
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2710:
	mov	r1, r2
	ldr	r0, [r5, #3888]
	bl	FreeUsdByDec
	strd	r6, [r4]
	b	.L2694
.L2712:
	.align	2
.L2711:
	.word	.LC346
	.fnend
	.size	H264DEC_Destroy, .-H264DEC_Destroy
	.align	2
	.global	H264DEC_RecycleImage
	.type	H264DEC_RecycleImage, %function
H264DEC_RecycleImage:
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
	add	r5, r0, #57344
	mov	r8, r1
	mov	r0, #2
	ldr	r1, .L2724
	bl	dprint_vfmw
	ldr	r0, [r5, #3888]
	mov	r1, r8
	bl	FSP_GetLogicFs
	cmp	r0, #0
	beq	.L2718
	ldrsb	r3, [r0, #1]
	cmp	r3, #0
	beq	.L2718
	add	r4, r0, #528
	add	r9, r0, #560
	mov	r6, #0
	mov	r7, #0
.L2716:
	ldrd	r2, [r4, #8]!
	orrs	r1, r2, r3
	bne	.L2723
.L2715:
	cmp	r4, r9
	bne	.L2716
	ldr	r0, [r5, #3888]
	mov	r1, r8
	mov	r2, #0
	bl	FSP_SetDisplay
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2723:
	mov	r1, r2
	ldr	r0, [r5, #3888]
	bl	FreeUsdByDec
	strd	r6, [r4]
	b	.L2715
.L2718:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L2725:
	.align	2
.L2724:
	.word	.LC347
	.fnend
	.size	H264DEC_RecycleImage, .-H264DEC_RecycleImage
	.align	2
	.global	OutputFrmToVO
	.type	OutputFrmToVO, %function
OutputFrmToVO:
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
	cmp	r1, #0
	cmpne	r0, #0
	mov	r7, r2
	mov	r4, r0
	mov	r5, r1
	moveq	ip, #1
	movne	ip, #0
	beq	.L2765
	ldr	r3, [r0]
	ldr	r3, [r3, #12]
	cmp	r3, #0
	ble	.L2729
	add	r3, r0, #57344
	ldr	r2, [r3, #3816]
	cmp	r2, #2
	beq	.L2729
	ldr	r2, [r3, #1844]
	cmp	r2, #0
	strneb	ip, [r2, #1]
	movne	r0, #1
	strne	ip, [r3, #1844]
	beq	.L2731
.L2728:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L2729:
	mov	r1, r5
	mov	r0, r4
	bl	CheckFrameStore
	cmn	r0, #3
	beq	.L2731
	add	r6, r4, #57344
	ldr	r1, [r6, #1844]
	cmp	r1, #0
	beq	.L2732
	mov	r0, r4
	bl	GetImagePara
	ldr	r1, [r6, #1844]
	mov	r0, r4
	bl	CheckFrameStore
	subs	r3, r0, #0
	beq	.L2766
	cmn	r3, #3
	beq	.L2739
	ldr	r1, .L2774
	movw	r2, #2023
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, [r6, #1844]
	mov	r0, r4
	ldr	r1, [r3, #164]
	bl	H264DEC_RecycleImage
.L2739:
	ldr	r3, [r6, #1844]
	mov	r0, #0
	strb	r0, [r3, #1]
	ldr	r3, [r6, #1844]
	str	r0, [r6, #1844]
	cmp	r5, r3
	beq	.L2728
.L2732:
	mov	r1, r5
	mov	r0, r4
	bl	GetImagePara
	mov	r1, r5
	mov	r0, r4
	bl	CheckFrameStore
	subs	r3, r0, #0
	beq	.L2767
	cmn	r3, #3
	beq	.L2731
	movw	r2, #2081
	ldr	r1, .L2774
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r1, [r5, #164]
	mov	r0, r4
	bl	H264DEC_RecycleImage
	mov	r0, #2
	b	.L2728
.L2765:
	mov	r3, r1
	mov	r2, r0
	ldr	r1, .L2774+4
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, #2
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L2731:
	mov	r0, #1
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L2767:
	mov	r2, #1
	ldr	r1, [r5, #600]
	ldr	r0, [r6, #3888]
	bl	FSP_SetDisplay
	ldr	r1, [r5, #600]
	ldr	r0, [r6, #3888]
	bl	FSP_GetFsImagePtr
	subs	r8, r0, #0
	beq	.L2768
	cmp	r7, #1
	add	r3, r4, #8
	streq	r7, [r8, #188]
	mov	r2, r4
	ldr	r0, [r6, #3888]
	mov	r1, #0
	str	r8, [sp]
	bl	InsertImgToVoQueue
	cmp	r0, #1
	bne	.L2769
	ldr	r3, [r4]
	ldr	r3, [r3, #600]
	add	r3, r3, #2032
	add	r3, r3, #15
	cmp	r3, #4096
	movcc	r3, #0
	strcc	r3, [r8, #24]
	bcs	.L2770
.L2746:
	ldr	r2, [r6, #3916]
	mov	r0, #0
	ldr	r3, [r6, #3908]
	add	r2, r2, #1
	str	r2, [r6, #3916]
	add	r3, r3, #2
	str	r3, [r6, #3908]
	b	.L2728
.L2766:
	ldr	r3, [r6, #1844]
	mov	r2, #1
	ldr	r0, [r6, #3888]
	ldr	r1, [r3, #600]
	bl	FSP_SetDisplay
	ldr	r3, [r6, #1844]
	ldr	r0, [r6, #3888]
	ldr	r1, [r3, #600]
	bl	FSP_GetFsImagePtr
	subs	r8, r0, #0
	beq	.L2771
	ldr	r3, [r6, #1844]
	mov	r2, r4
	mov	r1, #0
	cmp	r5, r3
	cmpeq	r7, #1
	moveq	r3, #1
	streq	r3, [r8, #188]
	add	r3, r4, #8
	ldr	r0, [r6, #3888]
	str	r8, [sp]
	bl	InsertImgToVoQueue
	cmp	r0, #1
	bne	.L2772
	ldr	r3, [r4]
	ldr	r3, [r3, #600]
	add	r3, r3, #2032
	add	r3, r3, #15
	cmp	r3, #4096
	movcc	r3, #0
	strcc	r3, [r8, #24]
	bcs	.L2773
.L2738:
	ldr	r2, [r6, #3916]
	ldr	r3, [r6, #3908]
	add	r2, r2, #1
	str	r2, [r6, #3916]
	add	r3, r3, #2
	str	r3, [r6, #3908]
	b	.L2739
.L2770:
	mov	r1, r8
	mov	r0, r4
	bl	SetFrmRepeatCount.part.1
	b	.L2746
.L2773:
	mov	r1, r8
	mov	r0, r4
	bl	SetFrmRepeatCount.part.1
	b	.L2738
.L2769:
	mov	r2, r0
	ldr	r1, .L2774+8
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r1, [r5, #600]
	ldr	r0, [r6, #3888]
	mov	r2, #0
	bl	FSP_SetDisplay
	mov	r0, r4
	mov	r1, #1
	bl	ClearAll
	mvn	r0, #0
	b	.L2728
.L2772:
	mov	r2, r0
	ldr	r1, .L2774+8
	mov	r0, #0
	mov	r5, r0
	bl	dprint_vfmw
	ldr	r3, [r6, #1844]
	mov	r2, r5
	strb	r5, [r3, #1]
	ldr	r3, [r6, #1844]
	ldr	r0, [r6, #3888]
	ldr	r1, [r3, #600]
	bl	FSP_SetDisplay
	str	r5, [r6, #1844]
	mov	r0, r4
	mov	r1, #1
	bl	ClearAll
	mvn	r0, #0
	b	.L2728
.L2768:
	movw	r2, #2051
	ldr	r1, .L2774+12
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2728
.L2771:
	movw	r2, #1994
	ldr	r1, .L2774+16
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L2728
.L2775:
	.align	2
.L2774:
	.word	.LC351
	.word	.LC348
	.word	.LC350
	.word	.LC352
	.word	.LC349
	.fnend
	.size	OutputFrmToVO, .-OutputFrmToVO
	.align	2
	.global	OutputFrmFromDPB
	.type	OutputFrmFromDPB, %function
OutputFrmFromDPB:
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
	add	r4, r4, #24576
	mov	r6, r1
	mov	r3, #0
	mov	r5, r0
	ldr	r1, [r4, #1952]
	mov	r2, r3
	strb	r3, [r1, #4]
	ldr	r1, [r4, #1952]
	bl	OutputFrmToVO
	ldr	r3, [r4, #1952]
	ldrb	r3, [r3, #2]
	cmp	r3, #0
	mov	r7, r0
	bne	.L2777
	mov	r1, r6
	mov	r0, r5
	bl	RemoveFrameStoreOutDPB
.L2777:
	mov	r0, r7
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	OutputFrmFromDPB, .-OutputFrmFromDPB
	.align	2
	.global	FlushDPB
	.type	FlushDPB, %function
FlushDPB:
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
	add	r6, r0, #24576
	mov	r4, r0
	ldr	r3, [r6, #2148]
	cmp	r3, #0
	beq	.L2780
	add	r7, r0, #26368
	mov	r5, #0
	add	r7, r7, #156
	b	.L2782
.L2781:
	ldr	r3, [r6, #2148]
	cmp	r3, r5
	bls	.L2780
.L2782:
	ldr	r1, [r7, #4]!
	add	r5, r5, #1
	ldrb	r3, [r1, #2]
	cmp	r3, #0
	beq	.L2781
	mov	r0, r4
	bl	UnMarkFrameStoreRef
	ldr	r3, [r6, #2148]
	cmp	r3, r5
	bhi	.L2782
.L2780:
	mov	r0, r4
	bl	RemoveUnUsedFrameStore
	cmp	r0, #0
	beq	.L2784
	mov	r0, r4
	bl	RemoveUnUsedFrameStore
	cmp	r0, #0
	bne	.L2780
	b	.L2784
.L2786:
	bl	GetMinPOC
	ldr	r1, [fp, #-36]
	mov	r0, r4
	bl	OutputFrmFromDPB
	cmn	r0, #1
	beq	.L2785
.L2784:
	ldr	r3, [r6, #2148]
	sub	r2, fp, #36
	sub	r1, fp, #32
	mov	r0, r4
	cmp	r3, #0
	bne	.L2786
	mov	r0, r3
.L2785:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	FlushDPB, .-FlushDPB
	.align	2
	.global	AdaptiveMemMark
	.type	AdaptiveMemMark, %function
AdaptiveMemMark:
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
	add	r3, r0, #57344
	add	r7, r0, #57600
	add	r7, r7, #200
	add	r2, r0, #26368
	ldr	r4, [r3, #1068]
	mov	r5, r0
	str	r3, [fp, #-56]
	add	r3, r2, #220
	add	r6, r4, #2000
	add	r4, r4, #4
	add	r6, r6, #4
	str	r3, [fp, #-52]
	add	r3, r0, #16384
	str	r3, [fp, #-48]
.L2807:
	ldr	r3, [r4]
	cmp	r3, #6
	ldrls	pc, [pc, r3, asl #2]
	b	.L2795
.L2797:
	.word	.L2796
	.word	.L2798
	.word	.L2799
	.word	.L2800
	.word	.L2801
	.word	.L2802
	.word	.L2803
.L2803:
	ldr	r2, [r4, #12]
	mov	r1, r7
	mov	r0, r5
	bl	MarkCurrPicLT
.L2795:
	add	r4, r4, #20
	cmp	r4, r6
	bne	.L2807
.L2796:
	ldr	r3, [fp, #-48]
	ldr	r3, [r3, #3444]
	cmp	r3, #1
	movne	r0, #0
	beq	.L2816
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2802:
	add	r8, r5, #24576
	ldr	r3, [r8, #2152]
	cmp	r3, #0
	ldrne	r9, [fp, #-52]
	movne	r10, #0
	beq	.L2806
.L2805:
	ldr	r1, [r9, #4]!
	mov	r0, r5
	bl	UnMarkFrameStoreRef
	ldr	r1, [r8, #2152]
	add	r10, r10, #1
	cmp	r10, r1
	bcc	.L2805
.L2806:
	mov	r0, r5
	bl	UpdateReflist
	mov	r1, #0
	mov	r0, r5
	bl	UpdateMaxLTFrmIdx
	mov	r0, r5
	bl	UpdateLTReflist
	ldr	r2, [fp, #-48]
	mov	r3, #1
	str	r3, [r2, #3444]
	b	.L2795
.L2801:
	mov	r0, r5
	ldr	r1, [r4, #16]
	bl	UpdateMaxLTFrmIdx
	mov	r0, r5
	bl	UpdateLTReflist
	b	.L2795
.L2800:
	ldr	r3, [r4, #12]
	mov	r1, r7
	ldr	r2, [r4, #4]
	mov	r0, r5
	bl	MarkSTToLTRef
	mov	r0, r5
	bl	UpdateReflist
	mov	r0, r5
	bl	UpdateLTReflist
	b	.L2795
.L2799:
	mov	r0, r5
	ldr	r2, [r4, #8]
	mov	r1, r7
	bl	UnMarkLTRef
	mov	r0, r5
	bl	UpdateLTReflist
	b	.L2795
.L2798:
	mov	r0, r5
	ldr	r2, [r4, #4]
	mov	r1, r7
	bl	UnMarkSTRef
	mov	r0, r5
	bl	UpdateReflist
	b	.L2795
.L2816:
	ldr	r1, [fp, #-56]
	mov	r3, #0
	ldrb	r2, [r1, #459]
	str	r3, [r1, #1072]
	cmp	r2, #1
	beq	.L2810
	bcc	.L2811
	cmp	r2, #2
	bne	.L2809
	ldr	r2, [fp, #-56]
	str	r3, [r2, #1096]
	str	r3, [r2, #1084]
	ldr	r2, [fp, #-48]
	str	r3, [r2, #3456]
	str	r3, [r2, #3464]
.L2809:
	mov	r0, r5
	bl	FlushDPB
	adds	r0, r0, #0
	movne	r0, #1
	rsb	r0, r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2811:
	ldr	r0, [fp, #-56]
	ldr	r1, [r0, #1084]
	ldr	r2, [r0, #1092]
	ldr	r3, [r0, #1096]
	rsb	r2, r1, r2
	str	r2, [r0, #1092]
	rsb	r3, r1, r3
	str	r3, [r0, #1096]
	cmp	r3, r2
	movge	r3, r2
	str	r3, [r0, #1088]
	str	r3, [r0, #1084]
	ldr	r0, [fp, #-48]
	ldr	r1, [r0, #3464]
	ldr	r2, [r0, #3452]
	ldr	r3, [r0, #3456]
	rsb	r2, r1, r2
	str	r2, [r0, #3452]
	rsb	r3, r1, r3
	str	r3, [r0, #3456]
	cmp	r3, r2
	movge	r3, r2
	str	r3, [r0, #3460]
	str	r3, [r0, #3464]
	b	.L2809
.L2810:
	ldr	r2, [fp, #-56]
	str	r3, [r2, #1092]
	str	r3, [r2, #1084]
	ldr	r2, [fp, #-48]
	str	r3, [r2, #3452]
	str	r3, [r2, #3464]
	b	.L2809
	.fnend
	.size	AdaptiveMemMark, .-AdaptiveMemMark
	.align	2
	.global	IDRMemMarking
	.type	IDRMemMarking, %function
IDRMemMarking:
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
	add	r5, r0, #57344
	str	r0, [fp, #-48]
	ldr	r3, [r5, #1068]
	ldrb	r3, [r3, #1]
	cmp	r3, #0
	beq	.L2818
	add	r9, r0, #24576
	ldr	r3, [r9, #2148]
	cmp	r3, #0
	beq	.L2825
	ldr	r3, [fp, #-48]
	mov	r10, #0
	mov	r4, r10
	add	r8, r3, #26368
	add	r6, r3, #26624
	add	r6, r6, #28
	mov	r7, r8
	add	r8, r8, #160
	add	r7, r7, #220
.L2824:
	ldr	r1, [r8]
	mov	r2, #0
	add	r10, r10, #1
	ldr	r0, [r1, #752]
	cmp	r0, #1
	streq	r0, [r5, #2492]
	strb	r4, [r1, #646]
	strb	r4, [r1, #645]
	ldr	r1, [r8]
	strb	r4, [r1, #682]
	strb	r4, [r1, #681]
	ldr	r1, [r8]
	strb	r4, [r1, #718]
	strb	r4, [r1, #717]
	ldr	r1, [r8]
	strb	r4, [r1, #2]
	ldr	r1, [r8]
	ldr	r0, [r5, #3888]
	ldr	r1, [r1, #600]
	bl	FSP_SetRef
	ldr	r2, [r8]
	mov	r3, #1
	strb	r4, [r2, #1]
	ldr	r2, [r8]
	strb	r4, [r2, #4]
	ldr	r2, [r8]
	str	r3, [r2, #620]
	ldr	r1, [r8]
	ldr	r3, [fp, #-48]
	ldr	r2, [r1, #640]
	add	r2, r2, #6656
	add	r2, r2, #28
	add	r2, r3, r2, lsl #2
	str	r4, [r2, #4]
	ldr	r1, [r1, #600]
	ldr	r0, [r5, #3888]
	bl	FSP_GetDisplay
	mov	r2, #0
	cmp	r0, #3
	beq	.L2823
	ldr	r1, [r8]
	ldr	r0, [r5, #3888]
	ldr	r1, [r1, #600]
	bl	FSP_SetDisplay
.L2823:
	str	r4, [r8], #4
	str	r4, [r7, #4]!
	str	r4, [r6, #4]!
	ldr	r2, [r9, #2148]
	cmp	r2, r10
	bhi	.L2824
.L2825:
	mov	r3, #0
	str	r3, [r9, #2148]
	ldr	r1, [r5, #2480]
	cmp	r1, r3
	beq	.L2821
	ldr	r2, [fp, #-48]
	mov	r0, r3
	add	r2, r2, #59648
	add	r2, r2, #100
.L2828:
	add	r3, r3, #1
	str	r0, [r2, #4]!
	cmp	r3, r1
	bne	.L2828
.L2821:
	ldr	r4, [fp, #-48]
	mov	r0, r4
	bl	UpdateReflist
	mov	r0, r4
	bl	UpdateLTReflist
	ldr	r3, [r5, #1068]
	ldrb	r3, [r3, #2]
	cmp	r3, #0
	bne	.L2838
	str	r3, [r9, #2160]
	mov	r0, r3
	strb	r3, [r5, #460]
	mov	r3, #1
	strb	r3, [r5, #461]
.L2829:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2838:
	mov	r3, #0
	mov	r2, #1
	mov	r0, r3
	str	r2, [r9, #2160]
	strb	r2, [r5, #460]
	str	r3, [r5, #1076]
	strb	r3, [r5, #461]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2818:
	bl	FlushDPB
	cmp	r0, #0
	ldreq	r3, [fp, #-48]
	addeq	r9, r3, #24576
	beq	.L2821
.L2830:
	mvn	r0, #0
	b	.L2829
	.fnend
	.size	IDRMemMarking, .-IDRMemMarking
	.align	2
	.global	Marking
	.type	Marking, %function
Marking:
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
	add	r6, r0, #16384
	add	r4, r0, #57344
	mov	r3, #0
	str	r3, [r6, #3444]
	mov	r5, r0
	ldrb	r3, [r4, #459]
	sub	r3, r3, #2
	clz	r3, r3
	mov	r3, r3, lsr #5
	str	r3, [r6, #3448]
	ldrb	r3, [r4, #462]
	cmp	r3, #5
	beq	.L2840
	ldr	r3, [r4, #1100]
	cmp	r3, #0
	bne	.L2841
	ldr	r3, [r0]
	ldr	r2, [r3, #632]
	cmp	r2, #1
	beq	.L2865
.L2841:
	ldr	r3, [r4, #1068]
	ldrb	r3, [r3, #3]
	cmp	r3, #0
	ldr	r3, [r4, #1080]
	beq	.L2866
	cmp	r3, #0
	bne	.L2867
.L2848:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2866:
	cmp	r3, #0
	beq	.L2848
.L2847:
	ldrb	r2, [r4, #457]
	cmp	r2, #0
	bne	.L2852
	add	r2, r5, #24576
	ldr	r1, [r6, #456]
	ldr	ip, [r2, #2156]
	ldr	r0, [r2, #2152]
	rsb	r2, ip, r1
	cmp	r0, r2
	beq	.L2868
.L2853:
	mov	r2, #0
	strb	r2, [r4, #460]
.L2850:
	cmp	r3, #0
	beq	.L2848
.L2852:
	ldrb	r3, [r4, #460]
	mov	r0, #0
	clz	r3, r3
	mov	r3, r3, lsr #5
	strb	r3, [r4, #461]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2865:
	ldr	r2, [r3, #628]
	cmp	r2, #0
	bne	.L2841
	ldr	r2, [r3, #636]
	cmp	r2, #0
	bne	.L2841
	ldr	r3, [r3, #600]
	add	r3, r3, #1024
	cmp	r3, #2048
	bls	.L2841
.L2840:
	mov	r0, r5
	bl	IDRMemMarking
	cmp	r0, #0
	bne	.L2842
.L2849:
	ldrb	r3, [r4, #462]
	cmp	r3, #5
	ldreq	r3, [r4, #1080]
	beq	.L2850
	ldr	r3, [r4, #1080]
	cmp	r3, #0
	beq	.L2848
	ldr	r2, [r4, #1068]
	ldrb	r2, [r2, #3]
	cmp	r2, #0
	beq	.L2847
	b	.L2852
.L2867:
	mov	r0, r5
	bl	AdaptiveMemMark
	cmp	r0, #0
	beq	.L2849
.L2842:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L2868:
	mov	r0, r5
	bl	SlidingWinMark.part.2
	ldr	r3, [r4, #1080]
	b	.L2853
	.fnend
	.size	Marking, .-Marking
	.align	2
	.global	DirectOutput
	.type	DirectOutput, %function
DirectOutput:
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
	add	r4, r0, #57344
	mov	r5, r0
	ldrb	r6, [r4, #459]
	cmp	r6, #1
	beq	.L2871
	bcc	.L2872
	cmp	r6, #2
	beq	.L2873
	mov	r6, #0
.L2870:
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2873:
	ldr	r3, [r4, #1064]
	mov	r2, #3
	strb	r2, [r3, #644]
	ldrb	r2, [r4, #457]
	cmp	r2, #0
	bne	.L2892
	ldr	r1, [r4, #1844]
	cmp	r1, #0
	beq	.L2893
	bl	OutputFrmToVO
	subs	r6, r0, #0
	bne	.L2960
.L2894:
	ldr	r3, [r4, #1064]
	str	r3, [r4, #1844]
	str	r3, [r3, #748]
.L2895:
	ldr	r3, [r4, #1844]
	mov	r8, #2
	ldrb	r0, [r4, #458]
	mov	r7, #0
	mov	r2, #592
	add	r1, r4, #472
	strb	r0, [r3]
	ldr	r3, [r4, #1844]
	strb	r8, [r3, #1]
	ldr	r3, [r4, #1844]
	strb	r7, [r3, #4]
	ldr	r3, [r4, #1844]
	str	r7, [r3, #620]
	ldr	r3, [r4, #1844]
	strb	r7, [r3, #2]
	ldr	r3, [r4, #1844]
	ldr	r0, [r4, #1100]
	str	r0, [r3, #628]
	ldr	r3, [r4, #1844]
	str	r7, [r3, #624]
	ldr	r0, [r4, #1844]
	add	r0, r0, #8
	bl	memcpy
	ldr	r3, [r4, #1844]
	ldr	r2, [r4, #1108]
	str	r2, [r3, #732]
	ldr	r3, [r4, #1844]
	ldr	r2, [r3, #732]
	str	r2, [r3, #660]
	str	r2, [r3, #632]
	ldr	r3, [r4, #1844]
	strb	r8, [r3, #716]
	ldrb	r2, [r4, #463]
	ldr	r3, [r4, #1844]
	cmp	r2, #1
	moveq	r2, r8
	movne	r2, r7
	strb	r2, [r3, #3]
	ldr	r8, [r4, #3820]
	cmp	r8, #1
	bne	.L2870
.L2955:
	ldr	r3, [r4, #1844]
	mov	r2, r7
	ldr	r0, [r4, #3888]
	ldr	r1, [r3, #600]
	bl	FSP_SetRef
	mov	r2, r7
	mov	r0, r5
	ldr	r1, [r4, #1844]
	bl	OutputFrmToVO
	ldr	r3, [r4, #1844]
	cmp	r3, r7
	mov	r6, r0
	beq	.L2905
	ldr	r3, [r4, #1064]
	mov	r2, r8
	ldr	r0, [r4, #3888]
	ldr	r1, [r3, #600]
	bl	FSP_ClearLogicFs
	b	.L2905
.L2872:
	ldr	r3, [r4, #1064]
	mov	r2, #0
	strb	r2, [r3, #644]
	ldr	r1, [r4, #1844]
	cmp	r1, r2
	beq	.L2874
	bl	OutputFrmToVO
	cmp	r0, #0
	bne	.L2961
.L2875:
	ldr	r3, [r4, #1844]
	cmp	r3, #0
	beq	.L2874
	ldr	r3, [r4, #1064]
	mov	r2, #1
	ldr	r0, [r4, #3888]
	ldr	r1, [r3, #600]
	bl	FSP_ClearLogicFs
.L2874:
	ldr	r3, [r4, #1064]
	mov	r0, #3
	mov	r7, #0
	mov	r2, #592
	add	r1, r4, #472
	str	r3, [r4, #1844]
	str	r3, [r3, #676]
	ldr	r3, [r4, #1844]
	ldr	ip, [r4, #1064]
	str	ip, [r3, #712]
	ldr	r3, [r4, #1844]
	ldr	ip, [r4, #1064]
	str	ip, [r3, #748]
	ldrb	ip, [r4, #458]
	ldr	r3, [r4, #1844]
	strb	ip, [r3]
	ldr	r3, [r4, #1844]
	strb	r0, [r3, #1]
	ldr	r3, [r4, #1844]
	strb	r7, [r3, #2]
	ldr	r3, [r4, #1844]
	strb	r7, [r3, #4]
	ldr	r3, [r4, #1844]
	str	r7, [r3, #620]
	ldr	r0, [r4, #1844]
	add	r0, r0, #8
	bl	memcpy
	ldr	r3, [r4, #1844]
	ldr	r1, [r4, #1108]
	mov	r2, r7
	str	r1, [r3, #660]
	str	r1, [r3, #632]
	ldr	r3, [r4, #1844]
	strb	r7, [r3, #644]
	ldr	r3, [r4, #1844]
	ldr	r1, [r4, #1100]
	str	r1, [r3, #628]
	ldr	r3, [r4, #1844]
	ldrb	r1, [r4, #465]
	str	r1, [r3, #624]
	ldrb	r1, [r4, #463]
	ldr	r3, [r4, #1844]
	cmp	r1, #1
	moveq	r6, #3
	strb	r6, [r3, #3]
	ldr	r3, [r4, #1844]
	ldr	r0, [r4, #3888]
	ldr	r1, [r3, #600]
	bl	FSP_SetRef
	mov	r2, r7
	mov	r0, r5
	ldr	r1, [r4, #1844]
	bl	OutputFrmToVO
	ldr	r3, [r4, #1844]
	cmp	r3, r7
	mov	r6, r0
	beq	.L2905
.L2953:
	ldr	r3, [r4, #1064]
	mov	r2, #1
	ldr	r0, [r4, #3888]
	ldr	r1, [r3, #600]
	bl	FSP_ClearLogicFs
.L2905:
	mov	r3, #0
	mov	r0, r6
	str	r3, [r4, #1844]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2871:
	ldr	r3, [r4, #1064]
	mov	r2, #3
	strb	r2, [r3, #644]
	ldrb	r2, [r4, #457]
	cmp	r2, #0
	bne	.L2879
	ldr	r1, [r4, #1844]
	cmp	r1, #0
	beq	.L2880
	bl	OutputFrmToVO
	subs	r6, r0, #0
	bne	.L2962
.L2881:
	ldr	r3, [r4, #1064]
	str	r3, [r4, #1844]
	str	r3, [r3, #712]
.L2882:
	ldr	r3, [r4, #1844]
	mov	r8, #1
	ldrb	r0, [r4, #458]
	mov	r7, #0
	mov	r2, #592
	add	r1, r4, #472
	strb	r0, [r3]
	ldr	r3, [r4, #1844]
	strb	r8, [r3, #1]
	ldr	r3, [r4, #1844]
	strb	r7, [r3, #4]
	ldr	r3, [r4, #1844]
	str	r7, [r3, #620]
	ldr	r3, [r4, #1844]
	strb	r7, [r3, #2]
	ldr	r3, [r4, #1844]
	ldr	r0, [r4, #1100]
	str	r0, [r3, #628]
	ldr	r3, [r4, #1844]
	str	r7, [r3, #624]
	ldr	r0, [r4, #1844]
	add	r0, r0, #8
	bl	memcpy
	ldr	r3, [r4, #1844]
	ldr	r2, [r4, #1108]
	str	r2, [r3, #696]
	ldr	r3, [r4, #1844]
	ldr	r2, [r3, #696]
	str	r2, [r3, #660]
	str	r2, [r3, #632]
	ldr	r3, [r4, #1844]
	strb	r8, [r3, #680]
	ldrb	r3, [r4, #463]
	ldr	r2, [r4, #1844]
	rsb	r3, r8, r3
	clz	r3, r3
	mov	r3, r3, lsr #5
	strb	r3, [r2, #3]
	ldr	r8, [r4, #3820]
	cmp	r8, #1
	beq	.L2955
	mov	r0, r6
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2892:
	ldr	ip, [r4, #1844]
	mov	r2, #592
	add	r1, r4, #472
	cmp	ip, #0
	ldreq	r3, [r4, #1064]
	streq	r3, [r4, #1844]
	streq	r3, [r3, #748]
	ldreq	ip, [r4, #1844]
	add	r3, ip, #592
	add	r0, ip, #8
	ldr	r10, [ip, #580]
	ldrd	r6, [r3, #-8]
	ldr	r9, [ip, #16]
	ldr	r8, [ip, #20]
	strd	r6, [fp, #-52]
	ldrd	r6, [r3]
	ldr	r3, [ip, #576]
	strd	r6, [fp, #-60]
	str	r3, [fp, #-64]
	ldr	r7, [ip, #24]
	ldr	r6, [ip, #28]
	bl	memcpy
	ldr	r3, [fp, #-64]
	add	r0, r5, #58368
	movw	r2, #58384
	ldr	ip, [r5, r2]
	and	r2, r3, r10
	ldr	r1, [r0, #20]
	adds	r2, r2, #1
	and	r1, r1, ip
	movne	r2, #1
	cmn	r1, #1
	movne	r2, #0
	cmp	r2, #0
	ldrne	r2, [r4, #1844]
	strne	r3, [r2, #576]
	add	r3, r5, #58368
	strne	r10, [r2, #580]
	add	r3, r3, #32
	ldr	r1, [r4, #1844]
	ldrd	r2, [r3, #-8]
	add	ip, r1, #592
	ldrd	r0, [fp, #-52]
	cmp	r3, r1
	cmpeq	r2, r0
	movhi	r2, r0
	movw	r0, #58400
	movhi	r3, r1
	strd	r2, [ip, #-8]
	ldrd	r2, [r5, r0]
	ldrd	r0, [fp, #-60]
	ldr	ip, [r4, #1844]
	cmp	r3, r1
	cmpeq	r2, r0
	add	r1, ip, #592
	ldrhid	r2, [fp, #-60]
.L2901:
	strd	r2, [r1]
	mov	ip, #2
	ldr	r3, [r4, #480]
	mov	r0, #3
	ldr	r2, [r4, #1844]
	cmp	r3, r9
	movcs	r3, r9
	str	r3, [r2, #16]
	ldr	r3, [r4, #484]
	ldr	r2, [r4, #1844]
	cmp	r3, r8
	movcs	r3, r8
	str	r3, [r2, #20]
	ldr	r3, [r4, #488]
	ldr	r2, [r4, #1844]
	cmp	r3, r7
	movcs	r3, r7
	str	r3, [r2, #24]
	ldr	r3, [r4, #492]
	ldr	r2, [r4, #1844]
	cmp	r3, r6
	movcs	r3, r6
	str	r3, [r2, #28]
	ldr	r2, [r4, #1844]
	ldrb	r3, [r2]
	cmp	r3, #0
	ldrneb	r3, [r4, #458]
	strb	r3, [r2]
	ldr	r2, [r4, #1844]
	ldrb	r3, [r2, #1]
	orr	r3, r3, ip
	strb	r3, [r2, #1]
	ldr	r2, [r4, #1844]
	ldr	r1, [r4, #1100]
	ldr	r3, [r2, #628]
	cmp	r3, r1
	movcc	r3, r1
	str	r3, [r2, #628]
	ldr	r3, [r4, #1844]
	strb	ip, [r3, #716]
	ldr	r3, [r4, #1844]
	strb	r0, [r3, #644]
	ldr	r3, [r4, #1844]
	ldr	r2, [r4, #1108]
	str	r2, [r3, #732]
	ldr	r2, [r4, #1844]
	ldr	r3, [r2, #732]
	ldr	r1, [r2, #696]
	add	r3, r3, r1
	mov	r3, r3, lsr #1
	str	r3, [r2, #660]
	ldr	r3, [r4, #1844]
	ldr	r2, [r3, #660]
	str	r2, [r3, #632]
	ldr	r3, [r4, #1844]
	ldr	r2, [r3, #748]
	str	r2, [r3, #676]
	ldrb	r3, [r4, #463]
	cmp	r3, #1
	ldr	r3, [r4, #1844]
	ldrb	r2, [r3, #3]
	beq	.L2957
.L2904:
	strb	r2, [r3, #3]
	mov	r2, #0
	ldr	r3, [r4, #1844]
	ldr	r0, [r4, #3888]
	ldr	r1, [r3, #600]
	bl	FSP_SetRef
	mov	r0, r5
	mov	r2, #0
	ldr	r1, [r4, #1844]
	bl	OutputFrmToVO
	ldr	r3, [r4, #1844]
	cmp	r3, #0
	mov	r6, r0
	bne	.L2953
	b	.L2905
.L2879:
	ldr	ip, [r4, #1844]
	mov	r2, #592
	add	r1, r4, #472
	cmp	ip, #0
	ldreq	r3, [r4, #1064]
	streq	r3, [r4, #1844]
	streq	r3, [r3, #712]
	ldreq	ip, [r4, #1844]
	add	r3, ip, #592
	add	r0, ip, #8
	ldr	r10, [ip, #580]
	ldrd	r6, [r3, #-8]
	ldr	r9, [ip, #16]
	ldr	r8, [ip, #20]
	strd	r6, [fp, #-52]
	ldrd	r6, [r3]
	ldr	r3, [ip, #576]
	strd	r6, [fp, #-60]
	str	r3, [fp, #-64]
	ldr	r7, [ip, #24]
	ldr	r6, [ip, #28]
	bl	memcpy
	ldr	r3, [fp, #-64]
	add	r0, r5, #58368
	movw	r2, #58384
	ldr	ip, [r5, r2]
	and	r2, r3, r10
	ldr	r1, [r0, #20]
	adds	r2, r2, #1
	and	r1, r1, ip
	movne	r2, #1
	cmn	r1, #1
	movne	r2, #0
	cmp	r2, #0
	ldrne	r2, [r4, #1844]
	strne	r3, [r2, #576]
	add	r3, r5, #58368
	strne	r10, [r2, #580]
	add	r3, r3, #32
	ldr	r1, [r4, #1844]
	ldrd	r2, [r3, #-8]
	add	ip, r1, #592
	ldrd	r0, [fp, #-52]
	cmp	r3, r1
	cmpeq	r2, r0
	movhi	r2, r0
	movw	r0, #58400
	movhi	r3, r1
	strd	r2, [ip, #-8]
	ldrd	r2, [r5, r0]
	ldrd	r0, [fp, #-60]
	ldr	ip, [r4, #1844]
	cmp	r3, r1
	cmpeq	r2, r0
	add	r1, ip, #592
	ldrhid	r2, [fp, #-60]
.L2887:
	strd	r2, [r1]
	mov	ip, #1
	ldr	r3, [r4, #480]
	mov	r0, #3
	ldr	r2, [r4, #1844]
	cmp	r3, r9
	movcs	r3, r9
	str	r3, [r2, #16]
	ldr	r3, [r4, #484]
	ldr	r2, [r4, #1844]
	cmp	r3, r8
	movcs	r3, r8
	str	r3, [r2, #20]
	ldr	r3, [r4, #488]
	ldr	r2, [r4, #1844]
	cmp	r3, r7
	movcs	r3, r7
	str	r3, [r2, #24]
	ldr	r3, [r4, #492]
	ldr	r2, [r4, #1844]
	cmp	r3, r6
	movcs	r3, r6
	str	r3, [r2, #28]
	ldr	r2, [r4, #1844]
	ldrb	r3, [r2]
	cmp	r3, #0
	ldrneb	r3, [r4, #458]
	strb	r3, [r2]
	ldr	r2, [r4, #1844]
	ldrb	r3, [r2, #1]
	orr	r3, r3, ip
	strb	r3, [r2, #1]
	ldr	r2, [r4, #1844]
	ldr	r1, [r4, #1100]
	ldr	r3, [r2, #628]
	cmp	r3, r1
	movcc	r3, r1
	str	r3, [r2, #628]
	ldr	r3, [r4, #1844]
	strb	ip, [r3, #680]
	ldr	r3, [r4, #1844]
	strb	r0, [r3, #644]
	ldr	r3, [r4, #1844]
	ldr	r2, [r4, #1108]
	str	r2, [r3, #696]
	ldr	r2, [r4, #1844]
	ldr	r3, [r2, #732]
	ldr	r1, [r2, #696]
	add	r3, r3, r1
	mov	r3, r3, lsr ip
	str	r3, [r2, #660]
	ldr	r3, [r4, #1844]
	ldr	r2, [r3, #660]
	str	r2, [r3, #632]
	ldr	r3, [r4, #1844]
	ldr	r2, [r3, #712]
	str	r2, [r3, #676]
	ldrb	r3, [r4, #463]
	cmp	r3, ip
	ldr	r3, [r4, #1844]
	ldrb	r2, [r3, #3]
	bne	.L2904
.L2957:
	orr	r2, r2, ip
	b	.L2904
.L2961:
	str	r0, [sp]
	movw	r3, #2675
	ldr	r2, .L2963
	mov	r0, #22
	ldr	r1, .L2963+4
	bl	dprint_vfmw
	b	.L2875
.L2893:
	ldr	r3, [r4, #1064]
	mov	r6, r1
	str	r3, [r4, #1844]
	str	r3, [r3, #748]
	b	.L2895
.L2880:
	ldr	r3, [r4, #1064]
	mov	r6, r1
	str	r3, [r4, #1844]
	str	r3, [r3, #712]
	b	.L2882
.L2960:
	str	r6, [sp]
	movw	r3, #2869
	ldr	r2, .L2963
	mov	r0, #22
	ldr	r1, .L2963+4
	bl	dprint_vfmw
	b	.L2894
.L2962:
	str	r6, [sp]
	movw	r3, #2727
	ldr	r2, .L2963
	mov	r0, #22
	ldr	r1, .L2963+4
	bl	dprint_vfmw
	b	.L2881
.L2964:
	.align	2
.L2963:
	.word	.LANCHOR1+228
	.word	.LC353
	.fnend
	.size	DirectOutput, .-DirectOutput
	.align	2
	.global	H264DEC_GetRemainImg
	.type	H264DEC_GetRemainImg, %function
H264DEC_GetRemainImg:
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
	add	r5, r0, #24576
	mov	r4, r0
	ldr	r3, [r5, #2148]
	cmp	r3, #0
	beq	.L2967
	add	r7, r0, #26368
	mov	r6, #0
	add	r7, r7, #156
	b	.L2969
.L2968:
	ldr	r3, [r5, #2148]
	cmp	r3, r6
	bls	.L2967
.L2969:
	ldr	r1, [r7, #4]!
	add	r6, r6, #1
	ldrb	r3, [r1, #2]
	cmp	r3, #0
	beq	.L2968
	mov	r0, r4
	bl	UnMarkFrameStoreRef
	ldr	r3, [r5, #2148]
	cmp	r3, r6
	bhi	.L2969
.L2967:
	mov	r0, r4
	bl	RemoveUnUsedFrameStore
	cmp	r0, #0
	bne	.L2967
	mvn	r6, #0
.L2971:
	ldr	r3, [r5, #2148]
	sub	r2, fp, #36
	sub	r1, fp, #32
	mov	r0, r4
	cmp	r3, #0
	beq	.L2983
	bl	GetMinPOC
	ldr	r3, [fp, #-36]
	mov	r1, #0
	mov	r0, r4
	add	r3, r4, r3, lsl #2
	add	r3, r3, #24576
	ldr	r2, [r3, #1952]
	strb	r1, [r2, #4]
	ldr	r1, [r3, #1952]
	ldr	r2, [r5, #2148]
	bl	OutputFrmToVO
	ldr	r1, [fp, #-36]
	add	r3, r1, #6592
	add	r3, r3, #40
	ldr	r3, [r4, r3, asl #2]
	ldrb	r3, [r3, #2]
	cmp	r3, #0
	mov	r6, r0
	bne	.L2971
	mov	r0, r4
	bl	RemoveFrameStoreOutDPB
	b	.L2971
.L2983:
	cmp	r6, #0
	beq	.L2974
	add	r0, r4, #8
	bl	GetVoLastImageID
	mov	r6, r0
.L2974:
	mov	r0, r6
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	H264DEC_GetRemainImg, .-H264DEC_GetRemainImg
	.align	2
	.global	InitDPB
	.type	InitDPB, %function
InitDPB:
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
	subs	r7, r0, #0
	beq	.L3001
	bl	ClearAllSlice
	add	r6, r7, #26368
	add	r5, r7, #26624
	mov	r8, #0
	mov	r4, r6
	add	r5, r5, #32
	add	r6, r6, #160
	add	r4, r4, #224
	add	r10, r7, #57344
	mov	r9, r8
.L2989:
	ldr	r3, [r6]
	mov	r2, #1
	add	r8, r8, r2
	cmp	r3, #0
	beq	.L2986
	ldr	r1, [r3, #600]
	ldr	r0, [r10, #3888]
	bl	FSP_ClearLogicFs
.L2986:
	ldr	r3, [r4]
	mov	r2, #1
	cmp	r3, #0
	beq	.L2987
	ldr	r1, [r3, #600]
	ldr	r0, [r10, #3888]
	bl	FSP_ClearLogicFs
.L2987:
	ldr	r3, [r5]
	mov	r2, #1
	cmp	r3, #0
	beq	.L2988
	ldr	r1, [r3, #600]
	ldr	r0, [r10, #3888]
	bl	FSP_ClearLogicFs
.L2988:
	cmp	r8, #16
	str	r9, [r5], #4
	mov	r2, #0
	str	r9, [r4], #4
	str	r9, [r6], #4
	bne	.L2989
	add	r3, r7, #16384
	add	r4, r7, #24576
	ldr	r3, [r3, #484]
	str	r2, [r4, #2148]
	sub	r3, r3, #1
	str	r2, [r4, #2152]
	str	r3, [r4, #2144]
	str	r2, [r4, #2156]
	str	r2, [r4, #2160]
	ldr	r1, [r10, #1844]
	cmp	r1, r2
	beq	.L2991
	ldr	r3, [r10, #3816]
	cmp	r3, #2
	beq	.L2992
.L2996:
	ldr	r3, [r10, #1064]
	cmp	r3, #0
	beq	.L2994
	ldr	r1, [r3, #600]
	mov	r2, #1
	ldr	r0, [r10, #3888]
	bl	FSP_ClearLogicFs
.L2994:
	mov	r3, #0
	str	r3, [r10, #1844]
.L2991:
	ldr	r3, .L3019
	add	r0, r7, #26624
	mov	r2, #392
	mov	r1, #0
	add	r0, r0, #116
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r1, [r4, #2144]
	add	r3, r7, #59648
	mov	r0, #0
	str	r0, [r4, #2424]
	mov	r2, r3
	add	r3, r3, #100
	add	r2, r2, #168
	str	r1, [r4, #2420]
	mov	r1, r0
.L2998:
	str	r1, [r3, #4]!
	cmp	r3, r2
	bne	.L2998
	add	r2, r7, #26880
	add	r3, r7, #27136
	add	r2, r2, #248
	add	r3, r3, #124
	mov	r0, #0
.L2999:
	str	r0, [r2, #4]!
	cmp	r2, r3
	mov	r1, #0
	bne	.L2999
	add	ip, r7, #20480
	add	r7, r7, #27392
	mov	r2, r1
	str	r1, [ip, #252]
.L3000:
	str	r2, [r3, #4]!
	cmp	r3, r7
	mov	r0, #0
	bne	.L3000
	str	r0, [ip, #256]
.L2985:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L2992:
	mov	r0, r7
	bl	OutputFrmToVO
	cmp	r0, #0
	bne	.L3018
.L2995:
	ldr	r3, [r10, #1844]
	cmp	r3, #0
	bne	.L2996
	b	.L2991
.L3018:
	str	r0, [sp]
	movw	r3, #5642
	ldr	r2, .L3019+4
	mov	r0, #22
	ldr	r1, .L3019+8
	bl	dprint_vfmw
	b	.L2995
.L3001:
	mvn	r0, #0
	b	.L2985
.L3020:
	.align	2
.L3019:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR1+244
	.word	.LC353
	.fnend
	.size	InitDPB, .-InitDPB
	.align	2
	.global	ClearDPB
	.type	ClearDPB, %function
ClearDPB:
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
	bl	FlushDPB
	subs	r3, r0, #0
	beq	.L3022
	movw	r2, #522
	ldr	r1, .L3026
	mov	r0, #0
	bl	dprint_vfmw
.L3022:
	mov	r0, r4
	add	r4, r4, #57344
	bl	InitDPB
	mov	r3, #0
	mov	r0, r3
	str	r3, [r4, #2492]
	str	r3, [r4, #3892]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L3027:
	.align	2
.L3026:
	.word	.LC354
	.fnend
	.size	ClearDPB, .-ClearDPB
	.align	2
	.global	DecVDM
	.type	DecVDM, %function
DecVDM:
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
	add	r4, r0, #57344
	mov	r6, r0
	ldrb	r3, [r4, #459]
	cmp	r3, #0
	beq	.L3029
	ldrb	r3, [r4, #457]
	cmp	r3, #1
	beq	.L3029
.L3030:
	ldr	r5, [r4, #3876]
	ldr	r3, [r4, #3816]
	ubfx	r5, r5, #16, #3
	cmp	r3, r5
	beq	.L3031
	subs	r2, r5, #2
	sub	r3, r3, #2
	movne	r2, #1
	cmp	r3, #1
	movhi	r2, #0
	cmp	r2, #0
	beq	.L3031
	cmp	r5, #4
	cmpne	r5, #1
	bls	.L3108
.L3031:
	cmp	r5, #2
	str	r5, [r4, #3816]
	beq	.L3034
	cmp	r5, #3
	beq	.L3035
	cmp	r5, #1
	beq	.L3109
	ldr	r3, [r4, #3812]
	cmp	r3, #0
	beq	.L3104
	cmp	r5, #4
	ldr	r3, [r4, #1100]
	beq	.L3110
.L3045:
	cmp	r3, #2
	beq	.L3060
.L3049:
	cmp	r3, #1
	streq	r3, [r4, #2496]
.L3051:
	ldr	r2, [r4, #3852]
	mov	r0, #2
	ldrb	r3, [r4, #459]
	sub	r2, r2, #1
	ldr	r1, .L3114
	bl	dprint_vfmw
	ldr	r2, [r4, #3852]
	ldr	r0, [r4, #1124]
	mov	r3, #1
	ldr	r1, [r4, #1128]
	cmp	r2, #0
	ldr	r2, [r4, #3812]
	str	r0, [r4, #3332]
	str	r1, [r4, #3328]
	str	r2, [r4, #3532]
	strb	r3, [r4, #2530]
	beq	.L3052
	ldr	r1, [r4, #1100]
	cmp	r1, #0
	beq	.L3111
	add	r3, r6, #24576
	ldr	r3, [r3, #2148]
	cmp	r3, #0
	bne	.L3054
	ldr	r3, [r6]
	ldr	r2, [r3, #12]
	cmp	r2, #2
	bne	.L3104
.L3057:
	add	r2, r6, #59648
	add	r2, r2, #224
	str	r2, [r6, #360]
	ldr	r1, [r3, #856]
	cmp	r1, #1
	beq	.L3112
	cmp	r1, #2
	bne	.L3059
	ldr	r1, [r3, #860]
	cmp	r2, #0
	cmpne	r1, #0
	ble	.L3059
	ldr	r2, [r4, #1100]
	cmp	r2, #2
	bne	.L3059
	mov	r2, #0
	str	r2, [r6, #360]
	ldr	r3, [r4, #1064]
	ldr	r0, [r4, #3888]
	ldr	r1, [r3, #600]
	bl	FSP_SetDisplay
	ldr	r2, [r6]
	mov	r0, r6
	ldr	r3, [r2, #860]
	sub	r3, r3, #1
	str	r3, [r2, #860]
	bl	H264_ClearCurrPic
	mvn	r0, #0
	b	.L3101
.L3029:
	ldr	r3, [r4, #3912]
	ldr	r2, [r4, #3916]
	add	r3, r3, #1
	cmp	r3, r2
	movlt	r3, r2
	str	r3, [r4, #3912]
	ldr	r1, [r6]
	rsb	r3, r2, r3
	str	r3, [r1, #572]
	b	.L3030
.L3108:
	mov	r2, r5
	ldr	r1, .L3114+4
	mov	r0, #2
	bl	dprint_vfmw
	str	r5, [r4, #3816]
.L3035:
	mov	r0, r6
	bl	H264_ClearCurrPic
	mov	r0, r6
	bl	ClearDPB
	mvn	r0, #0
.L3101:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L3052:
	ldr	r3, [r6]
.L3059:
	ldr	r2, [r3, #588]
	mov	r0, #0
	str	r2, [r4, #3796]
	ldr	r3, [r3, #624]
	str	r3, [r4, #3800]
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L3034:
	ldr	r5, [r4, #1100]
	cmp	r5, #0
	bne	.L3041
	ldr	r3, [r4, #3812]
	cmp	r3, #0
	beq	.L3104
	ldr	r3, [r4, #3808]
	ldr	r3, [r3, #48]
	cmp	r3, #0
	beq	.L3051
	mov	r3, #1
	mov	r0, r6
	strb	r3, [r4, #463]
	bl	H264_ClearCurrPic
	mov	r0, r5
	ldr	r1, .L3114+8
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3101
.L3109:
	ldr	r3, [r4, #1100]
	cmp	r3, #2
	beq	.L3113
	ldr	r2, [r4, #3812]
	cmp	r2, #0
	bne	.L3049
.L3104:
	mov	r0, r6
	bl	H264_ClearCurrPic
	mvn	r0, #0
	b	.L3101
.L3113:
	ldr	r3, [r4, #1080]
	cmp	r3, #0
	beq	.L3041
	ldr	r3, [r4, #3812]
	cmp	r3, #0
	beq	.L3104
.L3060:
	ldr	r3, [r4, #2496]
	cmp	r3, #2
	bne	.L3051
	ldr	r3, [r6]
	ldr	r5, [r3, #12]
	cmp	r5, #0
	bne	.L3051
	ldr	r3, .L3114+12
	ldrb	r3, [r3]
	cmp	r3, #1
	beq	.L3051
	ldr	r3, [r4, #1080]
	mov	r0, #1
	ldr	r2, [r4, #1084]
	ldr	r1, .L3114+16
	bl	dprint_vfmw
	mov	r0, r6
	bl	H264_ClearCurrPic
	ldr	r3, [r4, #1064]
	ldr	r0, [r4, #3888]
	mov	r2, r5
	ldr	r1, [r3, #600]
	bl	FSP_SetDisplay
	mvn	r0, #0
	b	.L3101
.L3110:
	cmp	r3, #0
	bne	.L3045
	ldr	r3, [r4, #2496]
	cmp	r3, #0
	moveq	r3, #2
	streq	r3, [r4, #2496]
	movne	r3, #1
	strne	r3, [r4, #2496]
	b	.L3051
.L3111:
	ldr	r3, .L3114+20
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L3054
	ldr	r2, [r4, #3536]
	cmp	r2, #0
	beq	.L3055
.L3056:
	ldr	r3, [r2, #8]
	ldr	r0, [r2, #12]
	ldr	r2, [r2, #4056]
	add	r3, r3, r0
	add	r3, r3, #7
	cmp	r2, #0
	add	r1, r1, r3, lsr #3
	bne	.L3056
.L3055:
	sub	r2, fp, #28
	mov	r3, #4
	ldr	r0, [r4, #3888]
	str	r1, [r2, #-4]!
	mov	r1, #20
	blx	ip
	ldr	r3, [r6]
	b	.L3057
.L3054:
	ldr	r3, [r6]
	b	.L3057
.L3112:
	cmp	r2, #0
	beq	.L3059
	ldr	r2, [r4, #1100]
	cmp	r2, #2
	bne	.L3059
	mov	r2, #0
	str	r2, [r6, #360]
	ldr	r3, [r4, #1064]
	ldr	r0, [r4, #3888]
	ldr	r1, [r3, #600]
	bl	FSP_SetDisplay
	b	.L3104
.L3041:
	mov	r3, #1
	mov	r0, r6
	strb	r3, [r4, #463]
	bl	H264_ClearCurrPic
	mvn	r0, #0
	b	.L3101
.L3115:
	.align	2
.L3114:
	.word	.LC358
	.word	.LC355
	.word	.LC356
	.word	g_allow_B_before_P
	.word	.LC357
	.word	g_event_report
	.fnend
	.size	DecVDM, .-DecVDM
	.align	2
	.global	H264_FlushDecoder
	.type	H264_FlushDecoder, %function
H264_FlushDecoder:
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
	add	r2, r0, #20480
	mov	r1, #0
	mov	r4, #1
	str	r1, [r2, #260]
	strb	r4, [r2, #213]
	str	r4, [r0, #364]
	bl	DecVDM
	cmp	r0, #0
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	mov	r0, r4
	ldr	r1, .L3121
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L3122:
	.align	2
.L3121:
	.word	.LC359
	.fnend
	.size	H264_FlushDecoder, .-H264_FlushDecoder
	.align	2
	.global	H264_VES_Splitter
	.type	H264_VES_Splitter, %function
H264_VES_Splitter:
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
	add	r4, r0, #13504
	mov	r6, r0
	add	r4, r4, #24
	mov	r7, r1
	add	r8, r0, #57344
	mov	r1, #24
	mov	r0, r4
	mov	r5, #0
	mov	r10, r3
	mov	r9, r2
	str	r5, [fp, #-48]
	bl	BsSkip
	movw	r3, #58048
	str	r5, [r8, #696]
	ldr	r3, [r6, r3]
	cmp	r7, r5
	str	r3, [fp, #-48]
	beq	.L3125
	cmp	r7, #1
	beq	.L3126
	mov	r2, r7
	ldr	r1, .L3238
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r5
.L3206:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3126:
	cmp	r9, #0
	mov	r1, #16
	mov	r0, r4
	bne	.L3137
	bl	BsGet
	mov	r1, #8
	mov	r5, r0
	mov	r0, r4
	bl	BsGet
	movw	r2, #31745
	cmp	r5, r2
	beq	.L3138
	mov	r1, #32
	mov	r0, r4
	bl	BsBack
	ldr	r3, [r6, #368]
	movw	r2, #32257
	cmp	r5, r2
	mov	r2, #16
	str	r2, [r3, #64]
	beq	.L3232
	mov	r1, #8
	mov	r0, r4
	bl	BsSkip
	mov	r1, #8
	mov	r0, r4
	bl	BsGet
	and	r0, r0, #31
	cmp	r0, #11
	beq	.L3233
.L3218:
	ldr	r1, [r6, #368]
	cmp	r1, #0
	beq	.L3209
	ldr	r0, [r8, #3888]
	bl	ReleaseNAL
	mov	r3, #0
	mvn	r0, #0
	str	r3, [r6, #368]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3125:
	cmp	r9, #0
	bne	.L3127
	mov	r1, #16
	mov	r0, r4
	bl	BsGet
	mov	r1, #8
	movw	r7, #31745
	mov	r5, r0
	mov	r0, r4
	bl	BsGet
	cmp	r5, r7
	beq	.L3128
	mov	r1, #24
	mov	r0, r4
	bl	BsBack
	bic	r5, r5, #512
	mov	r0, r4
	mov	r1, #24
	bl	BsBack
	cmp	r5, r7
	beq	.L3218
	b	.L3143
.L3137:
	bl	BsGet
	mov	r1, #8
	mov	r7, r0
	mov	r0, r4
	bl	BsGet
	movw	r3, #31745
	cmp	r7, r3
	beq	.L3145
	mov	r1, #24
	mov	r0, r4
	bl	BsBack
	mov	r0, r4
	mov	r1, #24
	bl	BsBack
	movw	r3, #32257
	cmp	r7, r3
	beq	.L3234
.L3143:
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3128:
	and	r0, r0, #31
	cmp	r0, #25
	bne	.L3218
	ldr	r4, .L3238+4
	ldr	ip, [r4]
	cmp	ip, #0
	beq	.L3131
	mov	r3, r9
	mov	r2, r9
	mov	r1, #112
	ldr	r0, [r8, #3888]
	blx	ip
.L3131:
	mov	r0, r6
	bl	DecVDM
	cmp	r0, #0
	beq	.L3235
.L3215:
	ldr	ip, [r4]
	cmp	ip, #0
	beq	.L3209
	mov	r3, #0
	ldr	r0, [r8, #3888]
	mov	r2, r3
	mov	r1, #113
	blx	ip
	mvn	r0, #0
	b	.L3206
.L3138:
	and	r3, r0, #31
	cmp	r3, #25
	cmpeq	r10, #1
	moveq	r10, #1
	movne	r10, #0
	bne	.L3236
	ldr	r4, .L3238+4
	ldr	ip, [r4]
	cmp	ip, #0
	beq	.L3141
	mov	r3, r9
	mov	r2, r9
	mov	r1, #112
	ldr	r0, [r8, #3888]
	blx	ip
.L3141:
	mov	r0, r6
	bl	DecVDM
	subs	r5, r0, #0
	bne	.L3215
.L3221:
	ldr	r1, [r6, #368]
	cmp	r1, #0
	beq	.L3209
	ldr	r0, [r8, #3888]
	bl	ReleaseNAL
	str	r5, [r6, #368]
.L3209:
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3127:
	mov	r0, r4
	mov	r1, #24
	bl	BsBack
	mov	r0, r7
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3145:
	and	r0, r0, #31
	cmp	r0, #25
	bne	.L3143
	ldr	r4, .L3238+4
	ldr	ip, [r4]
	cmp	ip, #0
	beq	.L3147
	mov	r3, r5
	mov	r2, r5
	mov	r1, #112
	ldr	r0, [r8, #3888]
	blx	ip
.L3147:
	mov	r0, r6
	bl	DecVDM
	cmp	r0, #0
	bne	.L3215
	ldr	r2, [r8, #696]
	sub	r1, fp, #48
	ldr	r0, [r8, #700]
	bl	MEM_MapMemBlock
	ldr	r3, [r6, #368]
	ldr	r4, .L3238+8
	mov	r2, #5
	ldr	r1, .L3238+12
	ldr	r3, [r3, #12]
	ldr	ip, [r4, #52]
	sub	r3, r3, #7
	ldr	r0, [fp, #-48]
	str	r3, [r8, #696]
	blx	ip
.L3226:
	ldr	r2, [r6, #368]
	ldr	r0, [fp, #-48]
	ldr	r3, [r4, #52]
	ldr	r1, [r2, #8]
	add	r0, r0, #5
	ldr	r2, [r8, #696]
	add	r1, r1, #6
	blx	r3
	ldr	r3, [r8, #696]
	add	r3, r3, #5
	str	r3, [r8, #696]
	ldr	r1, [r6, #368]
	ldr	r2, [r1, #40]
	cmp	r2, #0
	bne	.L3237
.L3149:
	ldr	r5, .L3238+16
	ldr	r3, [r8, #3888]
	ldr	r3, [r5, r3, asl #2]
	cmp	r3, #0
	beq	.L3150
	ldr	r3, [r4, #16]
	mov	r0, #0
	blx	r3
	ldr	r2, [r8, #3888]
	ldr	r3, [r4, #44]
	ldr	r1, [r8, #696]
	ldr	r2, [r5, r2, asl #2]
	ldr	r0, [fp, #-48]
	blx	r3
	ldr	r3, [r4, #12]
	mov	r0, #0
	blx	r3
.L3150:
	ldr	r0, [fp, #-48]
	bl	MEM_UnMapMemBlock
	b	.L3218
.L3236:
	ldr	r1, [r6, #368]
	cmp	r1, #0
	beq	.L3209
	ldr	r0, [r8, #3888]
	bl	ReleaseNAL
	str	r10, [r6, #368]
	mvn	r0, #0
	b	.L3206
.L3232:
	ldr	r5, .L3238+20
	ldr	r3, [r8, #3888]
	ldr	r3, [r5, r3, asl #2]
	cmp	r3, #0
	beq	.L3143
	ldr	r4, .L3238+8
	mov	r0, r9
	ldr	r3, [r4, #16]
	blx	r3
	ldr	r3, [r6, #368]
	ldr	r2, [r8, #3888]
	ldr	ip, [r4, #44]
	ldr	r1, [r3, #12]
	ldr	r2, [r5, r2, asl #2]
	ldr	r0, [r3, #8]
	blx	ip
	ldr	r3, [r4, #12]
	mov	r0, r9
	blx	r3
	mov	r0, r9
	b	.L3206
.L3235:
	ldr	r3, [r6, #368]
	sub	r1, fp, #48
	ldr	r4, .L3238+8
	ldr	r0, [r8, #700]
	ldr	r2, [r3, #12]
	sub	r2, r2, #7
	str	r2, [r8, #696]
	bl	MEM_MapMemBlock
	ldr	r3, [r4, #52]
	mov	r2, #5
	ldr	r1, .L3238+12
	ldr	r0, [fp, #-48]
	blx	r3
	b	.L3226
.L3234:
	movw	r3, #13354
	ldr	r2, .L3238+24
	ldr	r1, .L3238+28
	mov	r0, r5
	bl	dprint_vfmw
	b	.L3221
.L3237:
	ldr	r0, [fp, #-48]
	ldr	r1, [r1, #36]
	add	r0, r0, r3
	ldr	r3, [r4, #52]
	blx	r3
	ldr	r3, [r6, #368]
	ldr	r2, [r8, #696]
	ldr	r3, [r3, #40]
	add	r3, r3, r2
	str	r3, [r8, #696]
	b	.L3149
.L3233:
	mov	r0, r6
	bl	H264_IsEosNal
	cmp	r0, #1
	bne	.L3218
	mov	r1, #32
	mov	r0, r4
	bl	BsBack
	mov	r1, #32
	mov	r0, r4
	bl	BsBack
	mov	r0, r4
	mov	r1, #32
	bl	BsBack
	mov	r0, #3
	b	.L3206
.L3239:
	.align	2
.L3238:
	.word	.LC361
	.word	g_event_report
	.word	vfmw_Osal_Func_Ptr_S
	.word	RPU_START_CODE
	.word	vfmw_save_metadata_file
	.word	vfmw_save_el_file
	.word	.LANCHOR1+252
	.word	.LC360
	.fnend
	.size	H264_VES_Splitter, .-H264_VES_Splitter
	.align	2
	.global	ReceivePacket
	.type	ReceivePacket, %function
ReceivePacket:
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
	add	r6, r0, #57344
	ldr	r3, [r1, #8]
	mov	r4, r0
	ldr	r2, [r1, #4]
	mov	r5, r1
	mov	r0, #7
	ldr	r1, .L3303
	str	ip, [sp]
	bl	dprint_vfmw
	mov	r3, #0
	str	r3, [r6, #3920]
	ldr	r3, [r4]
	ldr	r2, [r3, #824]
	cmp	r2, #1
	beq	.L3298
.L3241:
	ldr	r3, [r4, #368]
	cmp	r3, #0
	beq	.L3261
	ldrb	r2, [r5]
	cmp	r2, #1
	beq	.L3299
.L3244:
	ldr	r1, .L3303+4
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r1, [r4, #368]
	cmp	r1, #0
	beq	.L3261
	ldr	r0, [r6, #3888]
	bl	ReleaseNAL
	mov	r3, #0
	str	r3, [r4, #368]
.L3261:
	ldr	r3, [r5, #12]
	cmp	r3, #0
	ble	.L3248
	ldr	r3, [r5, #4]
	cmp	r3, #0
	beq	.L3248
	ldr	r3, [r5, #8]
	cmp	r3, #0
	beq	.L3248
	ldrb	r3, [r4, #377]
	cmp	r3, #0
	beq	.L3264
	mov	r2, r4
	mov	r3, #1
	b	.L3251
.L3250:
	add	r3, r3, #1
	cmp	r3, #137
	beq	.L3262
.L3251:
	ldrb	r1, [r2, #473]
	add	r2, r2, #96
	cmp	r1, #0
	bne	.L3250
	mov	r2, r3
.L3249:
	mov	r1, r3, asl #7
	cmn	r2, #1
	sub	r3, r1, r3, asl #5
	mov	r1, #1
	add	r3, r4, r3
	strb	r1, [r3, #377]
	beq	.L3262
	mov	r3, r2, asl #7
	mov	r0, #0
	sub	r3, r3, r2, asl #5
	add	r2, r3, #376
	add	r3, r4, r3
	add	r2, r4, r2
	str	r2, [r4, #368]
	ldr	r2, [r5, #4]
	str	r2, [r3, #384]
	ldr	r2, [r5, #12]
	str	r2, [r3, #388]
	ldr	r2, [r5, #8]
	str	r2, [r3, #392]
	ldr	r3, [r4, #368]
	str	r0, [r3, #24]
	ldr	r3, [r4, #368]
	ldr	r2, [r5, #16]
	str	r2, [r3, #32]
	ldrd	r2, [r5, #24]
	ldr	ip, [r4, #368]
	strd	r2, [ip, #88]
	ldr	r3, [r4, #368]
	str	r1, [r3, #68]
	ldr	r3, [r4, #368]
	strb	r0, [r3]
	ldr	r3, [r4, #368]
	ldrb	r2, [r5]
	strb	r2, [r3, #4]
	ldr	r3, [r4, #368]
	b	.L3254
.L3299:
	ldr	r1, [r3, #68]
	cmp	r1, #1
	bhi	.L3244
	ldrb	r1, [r3, #4]
	cmp	r1, #1
	bne	.L3245
	b	.L3244
.L3298:
	ldr	r3, [r3, #864]
	cmp	r3, #0
	beq	.L3241
	ldr	r3, [r4, #368]
	cmp	r3, #0
	ldrneb	r2, [r5]
	beq	.L3261
.L3245:
	strb	r2, [r3, #4]
	ldr	r3, [r4]
	ldr	r2, [r3, #824]
	cmp	r2, #1
	beq	.L3300
.L3256:
	ldr	r3, [r5, #12]
	cmp	r3, #0
	ble	.L3257
	ldr	r2, [r5, #4]
	cmp	r2, #0
	beq	.L3257
	ldr	r3, [r5, #8]
	cmp	r3, #0
	beq	.L3257
	ldr	r3, [r4, #368]
	ldr	r1, [r3, #68]
	cmp	r1, #1
	bls	.L3301
.L3258:
	mov	r2, #1
	strb	r2, [r3, #4]
	ldr	r1, [r5, #16]
	ldr	r0, [r6, #3888]
	bl	SM_ReleaseStreamSeg
	ldr	r3, .L3303+8
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L3295
	mov	r3, #0
	ldr	r0, [r6, #3888]
	mov	r2, r3
	mov	r1, #113
	blx	ip
.L3295:
	ldr	r3, [r4, #368]
.L3254:
	ldrb	r2, [r5, #1]
	strb	r2, [r3, #5]
	ldr	r3, [r4, #368]
	ldrb	r0, [r3, #4]
	clz	r0, r0
	mov	r0, r0, lsr #5
	rsb	r0, r0, #0
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L3248:
	ldr	r1, .L3303+12
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r1, [r5, #16]
	ldr	r0, [r6, #3888]
	bl	SM_ReleaseStreamSeg
	ldr	r3, .L3303+8
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L3297
.L3296:
	mov	r3, #0
	ldr	r0, [r6, #3888]
	mov	r2, r3
	mov	r1, #113
	blx	ip
.L3297:
	mvn	r0, #0
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L3257:
	ldr	r3, [r4, #368]
	b	.L3258
.L3300:
	ldr	r3, [r3, #864]
	cmp	r3, #0
	bne	.L3295
	b	.L3256
.L3301:
	mov	ip, r1, asl #5
	mov	r0, #0
	sub	r1, ip, r1, asl #2
	add	r3, r3, r1
	str	r2, [r3, #8]
	ldr	r3, [r4, #368]
	ldr	ip, [r5, #12]
	ldr	r1, [r3, #68]
	mov	r2, r1, asl #5
	sub	r2, r2, r1, asl #2
	add	r3, r3, r2
	str	ip, [r3, #12]
	ldr	r3, [r4, #368]
	ldr	ip, [r5, #8]
	ldr	r1, [r3, #68]
	mov	r2, r1, asl #5
	sub	r2, r2, r1, asl #2
	add	r3, r3, r2
	str	ip, [r3, #16]
	ldr	r3, [r4, #368]
	ldr	r1, [r3, #68]
	mov	r2, r1, asl #5
	sub	r2, r2, r1, asl #2
	add	r3, r3, r2
	str	r0, [r3, #24]
	ldr	r3, [r4, #368]
	ldr	r0, [r5, #16]
	ldr	r1, [r3, #68]
	mov	r2, r1, asl #5
	sub	r2, r2, r1, asl #2
	add	r3, r3, r2
	str	r0, [r3, #32]
	ldr	r2, [r4, #368]
	ldr	r3, [r2, #68]
	add	r3, r3, #1
	str	r3, [r2, #68]
	ldr	r3, [r4, #368]
	ldr	r2, [r3, #12]
	cmp	r2, #4096
	bcc	.L3302
.L3259:
	mov	r2, #1
	str	r2, [r6, #3920]
	b	.L3254
.L3302:
	mov	r0, r4
	bl	CombinePacket.part.11
	ldr	r3, [r4, #368]
	b	.L3259
.L3262:
	ldr	r1, .L3303+16
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, r4
	bl	ClearAllNal
	mov	r0, r4
	bl	H264_ClearCurrPic
	mov	r0, r4
	bl	ClearDPB
	ldr	r3, .L3303+8
	ldr	ip, [r3]
	cmp	ip, #0
	bne	.L3296
	b	.L3297
.L3264:
	mov	r2, r3
	b	.L3249
.L3304:
	.align	2
.L3303:
	.word	.LC362
	.word	.LC363
	.word	g_event_report
	.word	.LC365
	.word	.LC364
	.fnend
	.size	ReceivePacket, .-ReceivePacket
	.align	2
	.global	ClearAll
	.type	ClearAll, %function
ClearAll:
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
	mov	r4, r1
	mov	r0, #22
	ldr	r1, .L3333
	add	r7, r8, #57344
	bl	dprint_vfmw
	mov	r0, r8
	bl	H264_ClearCurrPic
	mov	r0, r8
	bl	ClearAllNal
	mov	r0, r8
	bl	InitDPB
	cmp	r4, #0
	beq	.L3306
	add	r1, r8, #8
	ldr	r0, [r7, #3888]
	bl	FSP_ClearNotInVoQueue
.L3307:
	add	r4, r8, #27904
	mov	r6, #0
	add	r4, r4, #56
.L3310:
	sub	r5, r4, #32
	mov	r3, #0
	sub	r2, r4, #560
	mov	r1, #1
	mvn	r9, #0
	mov	lr, #17
	mov	ip, #16
	mov	r0, #2
	str	r6, [r4, #-396]
	strb	r3, [r4, #-560]
	strb	r3, [r4, #-559]
	strb	r3, [r4, #-558]
	str	r3, [r4, #52]
	str	r3, [r4, #44]
	str	r3, [r4, #56]
	strb	r3, [r4, #-556]
	strb	r3, [r4, #84]
	str	r9, [r4, #48]
	str	r1, [r4, #60]
	strb	r1, [r4, #120]
	str	lr, [r4, #76]
	str	ip, [r4, #80]
	str	r2, [r4, #188]
	str	r2, [r4, #152]
	str	r2, [r4, #116]
	strb	r0, [r4, #156]
.L3309:
	ldrd	r2, [r5, #8]!
	orrs	r1, r2, r3
	bne	.L3331
.L3308:
	cmp	r5, r4
	bne	.L3309
	add	r6, r6, #1
	add	r4, r5, #760
	cmp	r6, #40
	bne	.L3310
	add	r4, r8, #58112
	add	r5, r8, #58368
	add	r4, r4, #224
.L3312:
	ldrd	r2, [r4, #8]!
	orrs	r1, r2, r3
	bne	.L3332
.L3311:
	cmp	r4, r5
	bne	.L3312
	ldr	r3, [r7, #2504]
	cmp	r3, #0
	beq	.L3316
	add	r5, r8, #59648
	mov	r4, #0
	add	r5, r5, #200
	mov	r6, r4
.L3315:
	ldr	r1, [r5, #4]!
	add	r4, r4, #1
	cmp	r1, #0
	beq	.L3314
	ldr	r0, [r7, #3888]
	bl	FreeUsdByDec
	str	r6, [r5]
.L3314:
	ldr	r3, [r7, #2504]
	cmp	r3, r4
	bhi	.L3315
.L3316:
	ldr	r3, .L3333+4
	add	r5, r8, #20480
	add	ip, r8, #24576
	mov	r4, #0
	add	r0, r5, #208
	str	r4, [r7, #2504]
	str	r4, [r7, #3864]
	mov	r1, r4
	str	r4, [r7, #2484]
	mov	r2, #1648
	str	r4, [r7, #3812]
	str	r4, [r7, #3872]
	str	r4, [r7, #3820]
	str	r4, [r7, #2492]
	str	r4, [r7, #3892]
	str	r4, [r7, #2496]
	ldr	r3, [r3, #48]
	str	r4, [r8, #368]
	str	r4, [ip, #1812]
	strb	r4, [r5, #3904]
	strb	r4, [r5, #1900]
	strb	r4, [r5, #3905]
	strb	r4, [r5, #1901]
	blx	r3
	mov	r2, #2
	mov	r3, #1
	strb	r2, [r5, #208]
	strb	r3, [r5, #213]
	mov	r0, r4
	mov	r3, #256
	strb	r4, [r7, #456]
	strb	r4, [r7, #1816]
	str	r4, [r7, #1820]
	str	r3, [r7, #1824]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L3331:
	mov	r1, r2
	ldr	r0, [r7, #3888]
	bl	FreeUsdByDec
	mov	r2, #0
	mov	r3, #0
	strd	r2, [r5]
	b	.L3308
.L3332:
	mov	r1, r2
	ldr	r0, [r7, #3888]
	bl	FreeUsdByDec
	mov	r2, #0
	mov	r3, #0
	strd	r2, [r4]
	b	.L3311
.L3306:
	add	r0, r8, #8
	bl	ResetVoQueue
	ldr	r0, [r7, #3888]
	bl	FSP_EmptyInstance
	b	.L3307
.L3334:
	.align	2
.L3333:
	.word	.LC366
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	ClearAll, .-ClearAll
	.align	2
	.global	InsertFrmInDPB
	.type	InsertFrmInDPB, %function
InsertFrmInDPB:
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
	ldrb	r7, [r2, #3]
	mov	r4, r2
	mov	r5, r0
	str	r1, [fp, #-48]
	cmp	r7, #1
	beq	.L3337
	bcc	.L3338
	cmp	r7, #2
	beq	.L3339
	mov	r2, r7
	ldr	r1, .L3434
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, r5
	mov	r1, #1
	bl	ClearAll
	mov	r0, #0
.L3343:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3339:
	ldr	r3, [r2, #608]
	mov	r2, #3
	strb	r2, [r3, #644]
	ldrb	r3, [r4, #1]
	cmp	r3, #0
	ldr	r3, [fp, #-48]
	mov	r3, r3, asl #2
	beq	.L3359
	add	r6, r0, r3
	add	r6, r6, #24576
	ldr	r2, [r6, #1952]
	cmp	r2, #0
	beq	.L3359
	strb	r7, [r2, #716]
	ldr	r3, [r6, #1952]
	ldr	r2, [r4, #608]
	str	r2, [r3, #748]
	ldr	r3, [r6, #1952]
	ldrb	r2, [r4, #4]
	strb	r2, [r3, #717]
	ldr	r3, [r6, #1952]
	ldrb	r2, [r4, #5]
	strb	r2, [r3, #718]
	ldr	r3, [r6, #1952]
	ldr	r2, [r4, #640]
	str	r2, [r3, #728]
	ldr	r3, [r6, #1952]
	ldr	r2, [r4, #644]
	str	r2, [r3, #736]
	ldr	r3, [r6, #1952]
	ldr	r2, [r4, #652]
	str	r2, [r3, #732]
	ldr	r3, [r6, #1952]
	ldr	r1, [r3, #696]
	ldr	r2, [r3, #732]
	add	r2, r2, r1
	str	r2, [r3, #660]
	str	r2, [r3, #632]
	add	r1, r4, #16
	ldr	r2, [r6, #1952]
	ldrb	r3, [r2]
	cmp	r3, #0
	ldrneb	r3, [r4, #2]
	strb	r3, [r2]
	ldr	r2, [r6, #1952]
	ldrb	r3, [r2, #1]
	orr	r3, r3, #2
	strb	r3, [r2, #1]
	ldrb	r3, [r4, #7]
	cmp	r3, #1
	ldr	r3, [r6, #1952]
	ldrb	r2, [r3, #3]
	orreq	r2, r2, #2
	strb	r2, [r3, #3]
	mov	r2, #592
	ldr	lr, [r6, #1952]
	add	ip, lr, r2
	add	r0, lr, #8
	ldr	r3, [lr, #576]
	ldrd	r8, [ip, #-8]
	ldr	r10, [lr, #16]
	str	r3, [fp, #-72]
	strd	r8, [fp, #-60]
	ldr	r3, [lr, #580]
	ldrd	r8, [ip]
	ldr	ip, [lr, #20]
	ldr	r7, [lr, #28]
	strd	r8, [fp, #-68]
	mov	r9, r3
	str	ip, [fp, #-52]
	ldr	r8, [lr, #24]
	bl	memcpy
	ldr	r3, [fp, #-72]
	add	r2, r4, #592
	and	ip, r3, r9
	ldmdb	r2, {r0, lr}
	adds	r1, ip, #1
	ldr	ip, [fp, #-52]
	and	r0, r0, lr
	movne	r1, #1
	cmn	r0, #1
	movne	r1, #0
	cmp	r1, #0
	ldrne	r1, [r6, #1952]
	strne	r3, [r1, #576]
	movne	r3, r9
	strne	r3, [r1, #580]
	ldrd	r0, [fp, #-60]
	ldrd	r2, [r2]
	ldr	lr, [r6, #1952]
	cmp	r3, r1
	cmpeq	r2, r0
	add	r1, lr, #592
	ldrhid	r2, [fp, #-60]
.L3369:
	strd	r2, [r1, #-8]
	add	r0, r4, #608
	ldr	r1, [r6, #1952]
	ldrd	r2, [r0, #-8]
	add	lr, r1, #592
	ldrd	r0, [fp, #-68]
	cmp	r3, r1
	cmpeq	r2, r0
	movhi	r2, r0
	movhi	r3, r1
	strd	r2, [lr]
	ldr	r3, [r4, #24]
	ldr	r2, [r6, #1952]
	cmp	r3, r10
	movcs	r3, r10
	str	r3, [r2, #16]
	ldr	r3, [r4, #28]
	ldr	r2, [r6, #1952]
	cmp	r3, ip
	movcs	r3, ip
	str	r3, [r2, #20]
	ldr	r3, [r4, #32]
	ldr	r2, [r6, #1952]
	cmp	r3, r8
	movcs	r3, r8
	str	r3, [r2, #24]
	ldr	r3, [r4, #36]
	ldr	r2, [r6, #1952]
	cmp	r3, r7
	movcs	r3, r7
	str	r3, [r2, #28]
	ldrb	r3, [r4, #4]
	cmp	r3, #1
	beq	.L3371
	ldrb	r3, [r4, #5]
	cmp	r3, #1
	beq	.L3371
.L3372:
	ldr	r2, [r6, #1952]
	ldr	r3, [r2, #736]
	ldr	r1, [r2, #700]
	cmp	r3, r1
	movcc	r3, r1
	str	r3, [r2, #628]
	ldr	r2, [r4, #628]
	ldr	r3, [r6, #1952]
	str	r2, [r3, #616]
	ldr	r0, [r6, #1952]
	bl	CombineFldsToFrm
	ldr	r2, [r6, #1952]
	ldr	r3, [r2, #640]
	ldr	r2, [r2, #728]
	add	r3, r3, #6720
	add	r3, r3, #12
	add	r3, r5, r3, lsl #2
	str	r2, [r3, #4]
	b	.L3358
.L3338:
	ldr	r3, [fp, #-48]
	ldr	r2, [r2, #608]
	add	r8, r0, r3, lsl #2
	mov	r3, #3
	add	r8, r8, #24576
	str	r2, [r8, #1952]
	ldrb	r1, [r4, #2]
	strb	r1, [r2]
	ldr	r2, [r8, #1952]
	strb	r3, [r2, #1]
	ldr	r1, [r4, #608]
	ldr	r2, [r8, #1952]
	ldrb	r1, [r1, #4]
	strb	r1, [r2, #4]
	ldr	r1, [r4, #608]
	ldr	r2, [r8, #1952]
	ldr	r1, [r1, #620]
	str	r1, [r2, #620]
	ldrb	r1, [r4, #4]
	ldr	r2, [r8, #1952]
	cmp	r1, #0
	beq	.L3433
.L3340:
	strb	r3, [r2, #2]
	add	r1, r4, #16
	ldr	r3, [r8, #1952]
	mov	r2, #592
	ldr	r0, [r4, #676]
	mov	r6, #0
	mov	r10, #1
	str	r0, [r3, #636]
	ldr	r0, [r8, #1952]
	add	r0, r0, #8
	bl	memcpy
	ldr	r3, [r8, #1952]
	ldr	r1, [r4, #652]
	mov	ip, #2
	mov	r2, r6
	mov	r0, r5
	str	r1, [r3, #660]
	str	r1, [r3, #632]
	ldr	r3, [r8, #1952]
	ldr	r1, [r4, #608]
	str	r1, [r3, #748]
	str	r1, [r3, #712]
	str	r1, [r3, #676]
	ldr	r3, [r8, #1952]
	ldr	r1, [r4, #620]
	str	r1, [r3, #612]
	ldr	r3, [r8, #1952]
	ldr	r1, [r4, #616]
	str	r1, [r3, #604]
	ldr	r3, [r8, #1952]
	strb	r6, [r3, #644]
	ldr	r3, [r8, #1952]
	ldrb	r1, [r4, #4]
	strb	r1, [r3, #645]
	ldr	r3, [r8, #1952]
	ldrb	r1, [r4, #5]
	strb	r1, [r3, #646]
	ldr	r3, [r8, #1952]
	ldr	r1, [r4, #644]
	str	r1, [r3, #664]
	str	r1, [r3, #628]
	ldr	r3, [r8, #1952]
	ldrb	r1, [r4, #9]
	str	r1, [r3, #624]
	ldr	r3, [r8, #1952]
	ldr	r1, [r4, #628]
	str	r1, [r3, #616]
	ldr	r3, [r8, #1952]
	ldr	r1, [r4, #632]
	str	r1, [r3, #656]
	ldr	r3, [r8, #1952]
	ldr	r1, [r4, #636]
	str	r1, [r3, #692]
	ldr	r3, [r8, #1952]
	ldr	r1, [r4, #640]
	str	r1, [r3, #728]
	ldrb	r1, [r4, #7]
	ldr	r3, [r8, #1952]
	cmp	r1, r10
	moveq	r7, #3
	strb	r7, [r3, #3]
	ldr	r3, [r8, #1952]
	ldr	r1, [r3, #676]
	ldrb	r8, [r3, #645]
	ldrb	r7, [r3, #646]
	ldr	lr, [r3, #660]
	strb	ip, [r3, #716]
	ldr	ip, [r3, #664]
	strb	r10, [r3, #680]
	strb	r8, [r3, #681]
	strb	r8, [r3, #717]
	strb	r7, [r3, #682]
	strb	r7, [r3, #718]
	str	lr, [r3, #696]
	str	lr, [r3, #732]
	str	ip, [r3, #700]
	str	ip, [r3, #736]
	str	r1, [r3, #712]
	str	r1, [r3, #748]
	ldr	r1, [r4, #608]
	bl	GetAPC
	cmp	r0, #0
	movne	r3, r0
	movwne	r2, #2312
	movne	r0, r6
	bne	.L3431
.L3358:
	ldr	r3, [fp, #-48]
	add	r1, r5, #57344
	mov	r2, #1
	add	r3, r3, #6592
	ldr	r0, [r1, #3888]
	add	r3, r3, #40
	ldr	r3, [r5, r3, asl #2]
	ldr	r1, [r3, #600]
	bl	FSP_SetRef
	mov	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3337:
	ldr	r3, [r2, #608]
	mov	r2, #3
	strb	r2, [r3, #644]
	ldrb	r3, [r4, #1]
	cmp	r3, #0
	ldr	r3, [fp, #-48]
	mov	r3, r3, asl #2
	beq	.L3344
	add	r6, r0, r3
	add	r6, r6, #24576
	ldr	r2, [r6, #1952]
	cmp	r2, #0
	beq	.L3344
	strb	r7, [r2, #680]
	ldr	r3, [r6, #1952]
	ldr	r2, [r4, #644]
	str	r2, [r3, #700]
	ldr	r3, [r6, #1952]
	ldrb	r2, [r4, #4]
	strb	r2, [r3, #681]
	ldr	r3, [r6, #1952]
	ldrb	r2, [r4, #5]
	strb	r2, [r3, #682]
	ldr	r3, [r6, #1952]
	ldr	r2, [r4, #636]
	str	r2, [r3, #692]
	ldr	r3, [r6, #1952]
	ldr	r2, [r4, #644]
	str	r2, [r3, #700]
	ldr	r3, [r6, #1952]
	ldr	r2, [r4, #652]
	str	r2, [r3, #696]
	ldr	r3, [r6, #1952]
	ldr	r1, [r3, #696]
	ldr	r2, [r3, #732]
	add	r2, r2, r1
	str	r2, [r3, #660]
	str	r2, [r3, #632]
	add	r1, r4, #16
	ldr	r2, [r6, #1952]
	ldrb	r3, [r2]
	cmp	r3, #0
	ldrneb	r3, [r4, #2]
	strb	r3, [r2]
	ldr	r2, [r6, #1952]
	ldrb	r3, [r2, #1]
	orr	r3, r3, #1
	strb	r3, [r2, #1]
	ldrb	r3, [r4, #7]
	cmp	r3, #1
	ldr	r3, [r6, #1952]
	ldrb	r2, [r3, #3]
	orreq	r2, r2, #1
	strb	r2, [r3, #3]
	mov	r2, #592
	ldr	lr, [r6, #1952]
	add	ip, lr, r2
	add	r0, lr, #8
	ldr	r3, [lr, #576]
	ldrd	r8, [ip, #-8]
	ldr	r10, [lr, #16]
	str	r3, [fp, #-72]
	strd	r8, [fp, #-60]
	ldr	r3, [lr, #580]
	ldrd	r8, [ip]
	ldr	ip, [lr, #20]
	ldr	r7, [lr, #28]
	strd	r8, [fp, #-68]
	mov	r9, r3
	str	ip, [fp, #-52]
	ldr	r8, [lr, #24]
	bl	memcpy
	ldr	r3, [fp, #-72]
	add	r2, r4, #592
	and	ip, r3, r9
	ldmdb	r2, {r0, lr}
	adds	r1, ip, #1
	ldr	ip, [fp, #-52]
	and	r0, r0, lr
	movne	r1, #1
	cmn	r0, #1
	movne	r1, #0
	cmp	r1, #0
	ldrne	r1, [r6, #1952]
	strne	r3, [r1, #576]
	movne	r3, r9
	strne	r3, [r1, #580]
	ldrd	r0, [fp, #-60]
	ldrd	r2, [r2]
	ldr	lr, [r6, #1952]
	cmp	r3, r1
	cmpeq	r2, r0
	add	r1, lr, #592
	ldrhid	r2, [fp, #-60]
.L3353:
	strd	r2, [r1, #-8]
	add	r0, r4, #608
	ldr	r1, [r6, #1952]
	ldrd	r2, [r0, #-8]
	add	lr, r1, #592
	ldrd	r0, [fp, #-68]
	cmp	r3, r1
	cmpeq	r2, r0
	movhi	r2, r0
	movhi	r3, r1
	strd	r2, [lr]
	ldr	r3, [r4, #24]
	ldr	r2, [r6, #1952]
	cmp	r3, r10
	movcs	r3, r10
	str	r3, [r2, #16]
	ldr	r3, [r4, #28]
	ldr	r2, [r6, #1952]
	cmp	r3, ip
	movcs	r3, ip
	str	r3, [r2, #20]
	ldr	r3, [r4, #32]
	ldr	r2, [r6, #1952]
	cmp	r3, r8
	movcs	r3, r8
	str	r3, [r2, #24]
	ldr	r3, [r4, #36]
	ldr	r2, [r6, #1952]
	cmp	r3, r7
	movcs	r3, r7
	str	r3, [r2, #28]
	ldrb	r3, [r4, #4]
	cmp	r3, #1
	beq	.L3355
	ldrb	r3, [r4, #5]
	cmp	r3, #1
	beq	.L3355
.L3356:
	ldr	r2, [r6, #1952]
	ldr	r3, [r2, #736]
	ldr	r1, [r2, #700]
	cmp	r3, r1
	movcc	r3, r1
	str	r3, [r2, #628]
	ldr	r2, [r4, #628]
	ldr	r3, [r6, #1952]
	str	r2, [r3, #616]
	ldr	r0, [r6, #1952]
	bl	CombineFldsToFrm
	ldr	r2, [r6, #1952]
	ldr	r3, [r2, #640]
	ldr	r2, [r2, #692]
	add	r3, r3, #6656
	add	r3, r3, #60
	add	r3, r5, r3, lsl #2
	str	r2, [r3, #4]
	b	.L3358
.L3344:
	add	r6, r5, r3
	ldr	r3, [r4, #608]
	add	r6, r6, #24576
	mov	r2, #1
	str	r3, [r6, #1952]
	strb	r2, [r3, #680]
	ldr	r3, [r6, #1952]
	ldr	r1, [r4, #608]
	str	r1, [r3, #712]
	ldr	r3, [r6, #1952]
	ldrb	r1, [r4, #4]
	strb	r1, [r3, #681]
	ldr	r3, [r6, #1952]
	ldrb	r1, [r4, #5]
	strb	r1, [r3, #682]
	ldr	r3, [r6, #1952]
	ldr	r1, [r4, #636]
	str	r1, [r3, #692]
	ldr	r3, [r6, #1952]
	ldr	r1, [r4, #644]
	str	r1, [r3, #700]
	ldr	r3, [r6, #1952]
	ldr	r1, [r4, #652]
	str	r1, [r3, #696]
	ldr	r3, [r6, #1952]
	ldr	r1, [r3, #696]
	str	r1, [r3, #660]
	str	r1, [r3, #632]
	ldr	r3, [r6, #1952]
	ldrb	r1, [r4, #2]
	strb	r1, [r3]
	ldr	r3, [r6, #1952]
	strb	r2, [r3, #1]
	ldr	r2, [r4, #608]
	ldr	r3, [r6, #1952]
	ldrb	r2, [r2, #4]
	strb	r2, [r3, #4]
	ldr	r2, [r4, #608]
	ldr	r3, [r6, #1952]
	ldr	r2, [r2, #620]
	str	r2, [r3, #620]
	ldrb	r3, [r4, #4]
	cmp	r3, #1
	beq	.L3346
	ldrb	r3, [r4, #5]
	cmp	r3, #1
	beq	.L3346
.L3347:
	ldr	r3, [r6, #1952]
	mov	r7, #0
	mov	r2, #592
	add	r1, r4, #16
	str	r7, [r3, #624]
	ldr	r0, [r6, #1952]
	add	r0, r0, #8
	bl	memcpy
	ldr	r3, [r6, #1952]
	ldr	r1, [r4, #676]
	mov	r2, #1
	mov	r0, r5
	str	r1, [r3, #636]
	ldr	r3, [r6, #1952]
	ldr	r1, [r4, #616]
	str	r1, [r3, #604]
	ldr	r3, [r6, #1952]
	ldr	r1, [r4, #628]
	str	r1, [r3, #616]
	ldr	r3, [r6, #1952]
	ldr	r1, [r4, #644]
	str	r1, [r3, #628]
	ldrb	r3, [r4, #7]
	ldr	r1, [r6, #1952]
	rsb	r3, r2, r3
	clz	r3, r3
	mov	r3, r3, lsr #5
	strb	r3, [r1, #3]
	ldr	r1, [r4, #608]
	bl	GetAPC
	cmp	r0, #0
	beq	.L3358
	mov	r3, r0
	movw	r2, #2365
	mov	r0, r7
.L3431:
	ldr	r1, .L3434+4
	bl	dprint_vfmw
	mov	r0, r5
	bl	ClearDPB
	mvn	r0, #0
	b	.L3343
.L3359:
	add	r6, r5, r3
	ldr	r3, [r4, #608]
	add	r6, r6, #24576
	mov	r2, #2
	str	r3, [r6, #1952]
	strb	r2, [r3, #716]
	ldr	r3, [r6, #1952]
	ldr	r1, [r4, #608]
	str	r1, [r3, #748]
	ldr	r3, [r6, #1952]
	ldrb	r1, [r4, #4]
	strb	r1, [r3, #717]
	ldr	r3, [r6, #1952]
	ldrb	r1, [r4, #5]
	strb	r1, [r3, #718]
	ldr	r3, [r6, #1952]
	ldr	r1, [r4, #640]
	str	r1, [r3, #728]
	ldr	r3, [r6, #1952]
	ldr	r1, [r4, #644]
	str	r1, [r3, #736]
	ldr	r3, [r6, #1952]
	ldr	r1, [r4, #652]
	str	r1, [r3, #732]
	ldr	r3, [r6, #1952]
	ldr	r1, [r3, #696]
	str	r1, [r3, #660]
	str	r1, [r3, #632]
	ldr	r3, [r6, #1952]
	ldrb	r1, [r4, #2]
	strb	r1, [r3]
	ldr	r3, [r6, #1952]
	strb	r2, [r3, #1]
	ldr	r2, [r4, #608]
	ldr	r3, [r6, #1952]
	ldrb	r2, [r2, #4]
	strb	r2, [r3, #4]
	ldr	r2, [r4, #608]
	ldr	r3, [r6, #1952]
	ldr	r2, [r2, #620]
	str	r2, [r3, #620]
	ldrb	r3, [r4, #4]
	cmp	r3, #1
	beq	.L3361
	ldrb	r3, [r4, #5]
	cmp	r3, #1
	beq	.L3361
.L3362:
	ldr	r3, [r6, #1952]
	mov	r8, #0
	mov	r2, #592
	add	r1, r4, #16
	str	r8, [r3, #624]
	ldr	r0, [r6, #1952]
	add	r0, r0, #8
	bl	memcpy
	ldr	r3, [r6, #1952]
	ldr	r1, [r4, #676]
	mov	r2, #2
	mov	r0, r5
	str	r1, [r3, #636]
	ldr	r3, [r6, #1952]
	ldr	r1, [r4, #616]
	str	r1, [r3, #604]
	ldr	r3, [r6, #1952]
	ldr	r1, [r4, #628]
	str	r1, [r3, #616]
	ldr	r3, [r6, #1952]
	ldr	r1, [r4, #644]
	str	r1, [r3, #736]
	str	r1, [r3, #628]
	ldrb	r1, [r4, #7]
	ldr	r3, [r6, #1952]
	cmp	r1, #1
	moveq	r7, r2
	movne	r7, r8
	strb	r7, [r3, #3]
	ldr	r1, [r4, #608]
	bl	GetAPC
	cmp	r0, #0
	movne	r3, r0
	movwne	r2, #2510
	movne	r0, r8
	beq	.L3358
	b	.L3431
.L3433:
	ldrb	r3, [r4, #5]
	cmp	r3, #0
	movne	r3, #3
	b	.L3340
.L3361:
	ldr	r3, [r6, #1952]
	mov	r2, #2
	strb	r2, [r3, #2]
	ldrb	r3, [r4, #4]
	cmp	r3, #1
	ldreq	r3, [r6, #1952]
	ldreq	r2, [r4, #620]
	streq	r2, [r3, #612]
	b	.L3362
.L3346:
	ldr	r3, [r6, #1952]
	mov	r2, #1
	strb	r2, [r3, #2]
	ldrb	r3, [r4, #4]
	cmp	r3, r2
	ldreq	r3, [r6, #1952]
	ldreq	r2, [r4, #620]
	streq	r2, [r3, #612]
	b	.L3347
.L3355:
	ldr	r2, [r6, #1952]
	ldrb	r3, [r2, #2]
	orr	r3, r3, #1
	strb	r3, [r2, #2]
	ldrb	r3, [r4, #4]
	cmp	r3, #1
	ldreq	r3, [r6, #1952]
	ldreq	r2, [r4, #620]
	streq	r2, [r3, #612]
	b	.L3356
.L3371:
	ldr	r2, [r6, #1952]
	ldrb	r3, [r2, #2]
	orr	r3, r3, #2
	strb	r3, [r2, #2]
	ldrb	r3, [r4, #4]
	cmp	r3, #1
	ldreq	r3, [r6, #1952]
	ldreq	r2, [r4, #620]
	streq	r2, [r3, #612]
	b	.L3372
.L3435:
	.align	2
.L3434:
	.word	.LC368
	.word	.LC367
	.fnend
	.size	InsertFrmInDPB, .-InsertFrmInDPB
	.align	2
	.global	StorePicInDPB
	.type	StorePicInDPB, %function
StorePicInDPB:
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
	ldr	r3, [r0]
	mov	r5, r0
	ldr	r3, [r3, #592]
	cmp	r3, #1
	beq	.L3607
	add	r4, r0, #57344
	mov	r3, #0
	str	r3, [r4, #552]
	str	r3, [r4, #556]
.L3439:
	add	r2, r5, #16384
	mov	r3, #0
	str	r3, [r2, #3444]
	ldrb	r3, [r4, #459]
	sub	r3, r3, #2
	clz	r3, r3
	mov	r3, r3, lsr #5
	str	r3, [r2, #3448]
	ldrb	r0, [r4, #456]
	cmp	r0, #0
	beq	.L3608
	ldr	r3, .L3635
	ldr	r1, [r4, #3888]
	ldr	r2, [r4, #3900]
	ldr	r3, [r3, r1, asl #2]
	str	r2, [r4, #3896]
	ldrsb	r2, [r3, #160]
	cmp	r2, #1
	beq	.L3609
.L3442:
	ldr	r0, [r4, #3816]
	cmp	r0, #2
	beq	.L3610
	ldr	r6, [r5]
	ldr	r3, [r6, #12]
	cmp	r3, #0
	ble	.L3611
	ldrb	r2, [r4, #458]
	cmp	r2, #0
	bne	.L3448
.L3622:
	ldrb	r1, [r4, #459]
	ldr	r10, [r4, #1064]
	sub	r2, r1, #1
	cmp	r2, #1
	movhi	r2, #0
	movls	r2, #1
	cmp	r1, #0
	beq	.L3449
	ldrb	r0, [r10, #1]
	cmp	r0, #0
	moveq	ip, r2
	orrne	ip, r2, #1
	cmp	ip, #0
	beq	.L3448
	cmp	r2, #0
	beq	.L3612
.L3524:
	ldr	r2, [r4, #3892]
	cmp	r2, #0
	bne	.L3452
	mov	r3, #1
	mov	r2, #680
	str	r3, [r4, #3892]
	add	r1, r4, #456
	add	r0, r4, #1136
	bl	memcpy
	ldr	r3, [r6, #12]
.L3448:
	cmp	r3, #2
	ldr	r3, [r4, #1080]
	beq	.L3613
	cmp	r3, #0
	beq	.L3485
	ldr	r3, [r4, #3880]
	ldr	r2, [r4, #1108]
	cmp	r3, r2
	bcs	.L3486
	ldrb	r1, [r4, #458]
	cmp	r1, #0
	beq	.L3614
.L3486:
	mov	r0, r5
	bl	Marking
	subs	r2, r0, #0
	beq	.L3488
	ldr	r1, .L3635+4
	mov	r0, #1
	bl	dprint_vfmw
	movw	r3, #3939
	mvn	r2, #0
	ldr	r1, .L3635+8
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3523
.L3449:
	cmp	r2, #0
	bne	.L3524
.L3455:
	add	r6, r5, #57600
	add	r6, r6, #200
.L3457:
	cmp	r1, #0
	beq	.L3458
	ldrb	r3, [r6, #1]
	cmp	r3, #1
	beq	.L3615
.L3458:
	ldr	r3, [r6, #652]
	str	r3, [r10, #632]
.L3459:
	mov	r1, r10
	mov	r0, r5
	bl	GetImagePara
	ldr	r1, [r10, #600]
	ldr	r0, [r4, #3888]
	bl	FSP_GetFsImagePtr
	subs	r7, r0, #0
	beq	.L3616
	ldrb	r3, [r6, #3]
	add	ip, r6, #592
	cmp	r3, #0
	beq	.L3461
	ldrb	r3, [r6, #1]
	cmp	r3, #1
	beq	.L3617
.L3461:
	ldrd	r2, [ip, #-8]
	add	r0, r7, #576
.L3598:
	strd	r2, [r0, #-8]
.L3462:
	ldrd	r2, [ip]
	add	lr, r6, #608
	add	ip, r7, #592
	add	r1, r6, #256
	strd	r2, [r0]
	mov	r2, #56
	ldrd	r8, [lr, #-8]
	add	r0, r7, #240
	ldr	r3, .L3635+12
	strd	r8, [ip, #-8]
	ldr	ip, [r6, #24]
	str	ip, [r7, #8]
	ldr	ip, [r6, #28]
	str	ip, [r7, #12]
	ldr	ip, [r6, #32]
	str	ip, [r7, #16]
	ldr	ip, [r6, #36]
	str	ip, [r7, #20]
	ldr	ip, [r10, #632]
	ldr	r3, [r3, #52]
	str	ip, [r7, #160]
	ldr	ip, [r6, #244]
	str	ip, [r7, #228]
	ldr	ip, [r6, #240]
	str	ip, [r7, #224]
	ldrd	r8, [r6, #248]
	strd	r8, [r7, #232]
	blx	r3
	ldr	r2, [r7, #160]
	cmp	r2, #0
	beq	.L3468
	ldr	r3, [r7, #108]
	ands	r6, r3, #3
	beq	.L3618
.L3466:
	ldr	r3, [r5]
	ldr	r1, [r3, #4]
	cmp	r1, r2
	bcc	.L3619
.L3468:
	mov	r2, #1
	ldr	r1, [r10, #600]
	ldr	r0, [r4, #3888]
	bl	FSP_SetDisplay
	ldr	r0, [r4, #3888]
	add	r3, r5, #8
	str	r7, [sp]
	mov	r2, r5
	mov	r1, #0
	bl	InsertImgToVoQueue
	cmp	r0, #1
	beq	.L3620
	mov	r2, #0
	ldr	r1, [r10, #600]
	ldr	r0, [r4, #3888]
	bl	FSP_SetDisplay
.L3470:
	ldr	r3, [r5]
	ldr	r3, [r3, #600]
	add	r3, r3, #2032
	add	r3, r3, #15
	cmp	r3, #4096
	movcc	r3, #0
	strcc	r3, [r7, #24]
	bcs	.L3621
.L3472:
	ldr	r2, [r4, #3892]
	ldr	r3, [r4, #3908]
	cmp	r2, #2
	add	r3, r3, #2
	str	r3, [r4, #3908]
	movne	r3, #1
	strne	r3, [r10, #752]
	mov	r3, #2
	str	r3, [r4, #3892]
	ldr	r3, [r5]
	ldr	r3, [r3, #12]
	b	.L3448
.L3608:
	ldr	r1, .L3635+16
	bl	dprint_vfmw
	movw	r3, #3637
	mvn	r2, #0
	ldr	r1, .L3635+8
	mov	r0, #14
	bl	dprint_vfmw
.L3523:
	ldr	r3, [r4, #1064]
	mov	r2, #1
	ldr	r0, [r4, #3888]
	mvn	r6, #0
	ldr	r1, [r3, #600]
	bl	FSP_ClearLogicFs
	mov	r3, r6
	movw	r2, #4158
	ldr	r1, .L3635+20
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r2, [r4, #1064]
	mov	r3, #0
	strb	r3, [r2, #4]
	ldr	r2, [r4, #1064]
	strb	r3, [r2, #1]
.L3521:
	mov	r0, r6
	mov	r3, #0
	strb	r3, [r4, #456]
.L3595:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3607:
	ldr	r2, .L3635+24
	add	r4, r0, #57344
	ldr	r2, [r2]
	add	r2, r2, #4096
	ldr	r0, [r2, #84]
	ldr	r1, [r2, #88]
	str	r3, [r4, #552]
	cmp	r1, #0
	moveq	r1, #1
	bl	__aeabi_uidiv
	str	r0, [r4, #556]
	b	.L3439
.L3611:
	ldr	r2, [r4, #3892]
	cmp	r2, #2
	beq	.L3448
	ldrb	r2, [r4, #458]
	cmp	r2, #0
	bne	.L3448
	b	.L3622
.L3613:
	cmp	r3, #0
	beq	.L3478
	ldrb	r3, [r4, #462]
	cmp	r3, #5
	beq	.L3479
.L3483:
	mov	r0, r5
	add	r6, r5, #24576
	bl	SimpleSlideDPB
	add	r2, r5, #57600
	ldr	r1, [r6, #2148]
	add	r2, r2, #200
	mov	r0, r5
	bl	InsertFrmInDPB
	subs	r7, r0, #0
	beq	.L3623
	mov	r3, r7
	movw	r2, #3905
	ldr	r1, .L3635+20
	mov	r0, #0
	bl	dprint_vfmw
	movw	r3, #3906
	mvn	r2, #0
	ldr	r1, .L3635+8
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3523
.L3612:
	cmp	r0, #0
	beq	.L3448
	b	.L3455
.L3488:
	mov	r0, r5
	bl	UpdateReflist
	mov	r0, r5
	bl	UpdateLTReflist
	mov	r0, r5
	bl	RemoveUnUsedFrameStore
	cmp	r0, #0
	beq	.L3478
	ldr	r1, .L3635+28
	mov	r0, #22
	bl	dprint_vfmw
.L3478:
	ldrb	r3, [r4, #457]
	cmp	r3, #1
	beq	.L3490
	add	r6, r5, #24576
.L3494:
	ldr	r3, [r4, #1080]
	cmp	r3, #0
	beq	.L3624
	ldr	r2, [r6, #2152]
	ldr	r1, [r6, #2156]
	ldr	r3, [r6, #2144]
	add	r0, r1, r2
	cmp	r3, r0
	bhi	.L3502
	ldr	r0, [r5]
	ldr	r0, [r0, #12]
	cmp	r0, #3
	beq	.L3503
	ldr	r0, .L3635+32
	ldrb	r0, [r0]
	cmp	r0, #1
	beq	.L3503
	str	r1, [sp, #4]
	mov	r0, #1
	str	r2, [sp]
	movw	r2, #4018
	ldr	r1, .L3635+36
	bl	dprint_vfmw
	mov	r0, r5
	bl	ClearDPB
	movw	r3, #4044
	mvn	r2, #0
	ldr	r1, .L3635+8
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3523
.L3485:
	ldrb	r3, [r4, #457]
	cmp	r3, #1
	beq	.L3490
	add	r6, r5, #24576
	ldr	r3, [r6, #2144]
.L3502:
	mvn	r9, #0
	mov	r8, r9
	b	.L3512
.L3513:
	bl	GetMinPOC
	ldr	r3, [r4, #1080]
	cmp	r3, #0
	bne	.L3505
	ldr	r2, [r4, #1084]
	ldr	r3, [fp, #-56]
	cmp	r2, r3
	blt	.L3625
.L3505:
	ldr	r7, [r6, #2148]
	cmp	r7, r9
	ldrne	r8, [fp, #-52]
	bne	.L3510
	ldr	r3, [fp, #-52]
	cmp	r3, r8
	beq	.L3626
	mov	r8, r3
.L3510:
	mov	r1, r8
	mov	r0, r5
	bl	OutputFrmFromDPB
	mov	r9, r7
	cmn	r0, #1
	mov	r10, r0
	beq	.L3511
	ldr	r3, [r6, #2144]
.L3512:
	ldr	ip, [r6, #2148]
	sub	r2, fp, #52
	sub	r1, fp, #56
	mov	r0, r5
	cmp	ip, r3
	bcs	.L3513
	ldr	r3, [r4, #1080]
	cmp	r3, #0
	beq	.L3514
	ldrb	r3, [r4, #460]
	cmp	r3, #0
	bne	.L3514
	ldr	r2, [r6, #2152]
	cmp	r2, #0
	beq	.L3514
	add	r2, r5, #26368
	mov	lr, r3
	add	r2, r2, #220
	b	.L3519
.L3516:
	ldr	r1, [r6, #2152]
	cmp	r1, r3
	bls	.L3627
.L3519:
	ldr	r1, [r2, #4]!
	add	r3, r3, #1
	ldr	r0, [r4, #1072]
	ldr	ip, [r1, #604]
	cmp	ip, r0
	bne	.L3516
	strb	lr, [r1, #2]
	ldr	r1, [r2]
	ldrb	r0, [r1, #4]
	cmp	r0, #1
	streq	r0, [r1, #620]
	ldreq	r1, [r2]
	streqb	lr, [r1, #4]
	ldreq	r1, [r2]
	ldr	r7, [r4, #2480]
	ldr	ip, [r1, #636]
	add	r0, ip, #14912
	cmp	ip, r7
	add	r0, r0, #26
	strne	lr, [r5, r0, asl #2]
	strne	r7, [r1, #636]
	b	.L3516
.L3627:
	ldr	ip, [r6, #2148]
.L3514:
	add	r2, r5, #57600
	mov	r1, ip
	add	r2, r2, #200
	mov	r0, r5
	bl	InsertFrmInDPB
	ldr	r2, [r6, #2148]
	str	r2, [r4, #1840]
	subs	r3, r0, #0
	bne	.L3628
	add	r2, r2, #1
	mov	r0, r5
	str	r2, [r6, #2148]
	bl	UpdateReflist
	mov	r0, r5
	bl	UpdateLTReflist
.L3484:
	mov	r6, #0
	b	.L3521
.L3609:
	ldr	r2, [r3, #168]
	cmp	r2, #0
	bne	.L3442
	ldr	r3, [r3, #172]
	cmp	r3, #1
	bne	.L3442
	mov	r0, r5
	bl	H264_Sei_Get_Frame_Pts
	b	.L3442
.L3624:
	ldr	r3, [r6, #2144]
	b	.L3502
.L3490:
	ldr	r3, [r4, #1844]
	ldr	r0, [r4, #1064]
	cmp	r3, #0
	rsb	r1, r3, r0
	clz	r1, r1
	mov	r1, r1, lsr #5
	moveq	r1, #0
	cmp	r1, #0
	beq	.L3629
	mov	r0, r5
	bl	DirectOutput
	cmn	r0, #1
	mov	r6, r0
	beq	.L3630
	cmp	r0, #1
	ldreq	r2, [r4, #1064]
	moveq	r3, #0
	streqb	r3, [r2, #4]
	ldreq	r2, [r4, #1064]
	streqb	r3, [r2, #1]
.L3498:
	movw	r3, #3975
	mov	r2, r6
	ldr	r1, .L3635+8
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3446
.L3610:
	ldr	r1, .L3635+40
	bl	dprint_vfmw
	mov	r0, r5
	bl	DirectOutput
	ldr	r3, [r4, #1132]
	ldr	r2, [r4, #2480]
	cmp	r3, r2
	addne	r3, r3, #14912
	addne	r3, r3, #26
	movne	r1, #0
	strne	r1, [r5, r3, asl #2]
	mov	r6, r0
	strne	r2, [r4, #1132]
	cmp	r0, #1
	ldr	r1, .L3635+8
	ldreq	r2, [r4, #1064]
	moveq	r3, #0
	streqb	r3, [r2, #4]
	ldreq	r2, [r4, #1064]
	streqb	r3, [r2, #1]
	mov	r2, r0
	movw	r3, #3698
	mov	r0, #14
	bl	dprint_vfmw
.L3446:
	cmn	r6, #1
	bne	.L3521
	b	.L3523
.L3452:
	cmp	r2, #1
	beq	.L3631
	cmp	r1, #0
	beq	.L3455
	ldrb	r2, [r10, #1]
	cmp	r2, #0
	bne	.L3455
	b	.L3448
.L3629:
	add	r6, r5, #24576
	ldr	ip, [r6, #2148]
	cmp	ip, #0
	beq	.L3494
	ldr	r3, [r6, #1952]
	cmp	r0, r3
	addne	r3, r5, #26368
	addne	r3, r3, #160
	beq	.L3495
.L3499:
	add	r1, r1, #1
	cmp	r1, ip
	beq	.L3494
	ldr	r2, [r3, #4]!
	cmp	r0, r2
	bne	.L3499
.L3495:
	add	r2, r5, #57600
	mov	r0, r5
	add	r2, r2, #200
	bl	InsertFrmInDPB
	cmn	r0, #1
	mov	r6, r0
	beq	.L3632
	mov	r0, r5
	bl	UpdateReflist
	mov	r0, r5
	bl	UpdateLTReflist
	movw	r3, #3995
	mov	r2, #0
	ldr	r1, .L3635+8
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3484
.L3511:
	mov	r3, r0
	movw	r2, #4094
	ldr	r1, .L3635+20
	mov	r0, #1
	bl	dprint_vfmw
	mov	r2, r10
	movw	r3, #4095
	ldr	r1, .L3635+8
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3523
.L3619:
	ldr	r3, .L3635+44
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L3475
	str	r2, [fp, #-52]
	mov	r3, #8
	str	r1, [fp, #-48]
	sub	r2, fp, #52
	mov	r1, #104
	ldr	r0, [r4, #3888]
	blx	ip
.L3475:
	ldr	r1, [r10, #600]
	mov	r2, #0
	ldr	r0, [r4, #3888]
	bl	FSP_SetDisplay
	movw	r3, #3862
	mvn	r2, #0
	ldr	r1, .L3635+8
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3523
.L3628:
	movw	r2, #4131
	ldr	r1, .L3635+20
	mov	r0, #1
	bl	dprint_vfmw
	movw	r3, #4132
	mvn	r2, #0
	ldr	r1, .L3635+8
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3523
.L3623:
	ldr	r3, [r6, #2148]
	mov	r0, r5
	add	r3, r3, #1
	str	r3, [r6, #2148]
	bl	UpdateReflist
	mov	r0, r5
	bl	UpdateLTReflist
	mov	r2, r7
	movw	r3, #3914
	ldr	r1, .L3635+8
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3484
.L3503:
	sub	r2, fp, #52
	sub	r1, fp, #56
	mov	r0, r5
	bl	GetMinPOC
	ldr	r1, [fp, #-52]
	mov	r0, r5
	bl	RemoveFrameStoreOutDPB
	mov	r0, r5
	bl	UpdateReflist
	mov	r0, r5
	bl	UpdateLTReflist
	ldr	r3, [r6, #2144]
	b	.L3502
.L3618:
	movw	r2, #3829
	ldr	r1, .L3635+48
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L3635+44
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L3467
	mov	r3, r6
	mov	r2, r6
	mov	r1, #111
	ldr	r0, [r4, #3888]
	blx	ip
.L3467:
	ldr	r2, [r7, #160]
	cmp	r2, #0
	bne	.L3466
	b	.L3468
.L3617:
	ldrd	r0, [ip, #-8]
	mvn	r3, #0
	mvn	r2, #0
	cmp	r1, r3
	cmpeq	r0, r2
	addne	r0, r7, #576
	bne	.L3462
	add	r3, r5, #58880
	add	r3, r3, #192
	ldrd	r2, [r3, #-8]
	cmp	r3, r1
	cmpeq	r2, r0
	add	r0, r7, #576
	bne	.L3598
	b	.L3462
.L3630:
	mov	r3, r0
	movw	r2, #3965
	ldr	r1, .L3635+20
	mov	r0, #1
	bl	dprint_vfmw
	b	.L3498
.L3614:
	ldr	r1, .L3635+52
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L3635+44
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L3487
	ldr	r6, [r4, #1108]
	mov	r3, #8
	ldr	lr, [r4, #3880]
	sub	r2, fp, #52
	mov	r1, #104
	ldr	r0, [r4, #3888]
	str	r6, [fp, #-52]
	str	lr, [fp, #-48]
	blx	ip
.L3487:
	mov	r0, r5
	bl	H264_ClearCurrPic
	mov	r0, r5
	bl	ClearDPB
	movw	r3, #3930
	mvn	r2, #0
	ldr	r1, .L3635+8
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3523
.L3620:
	ldr	r3, [r4, #3916]
	add	r3, r3, #1
	str	r3, [r4, #3916]
	b	.L3470
.L3625:
	ldr	r3, [r4, #3816]
	cmp	r3, #2
	beq	.L3633
.L3506:
	mov	r0, r5
	bl	DirectOutput
	cmn	r0, #1
	mov	r6, r0
	beq	.L3634
	cmp	r0, #1
	ldreq	r2, [r4, #1064]
	moveq	r3, #0
	streqb	r3, [r2, #4]
	ldreq	r2, [r4, #1064]
	streqb	r3, [r2, #1]
.L3508:
	movw	r3, #4074
	mov	r2, r6
	ldr	r1, .L3635+8
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3446
.L3626:
	mov	r3, r8
	ldr	r2, .L3635+56
	ldr	r1, .L3635+60
	mov	r0, #1
	bl	dprint_vfmw
	movw	r3, #4081
	mvn	r2, #0
	ldr	r1, .L3635+8
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3523
.L3621:
	mov	r1, r7
	mov	r0, r5
	bl	SetFrmRepeatCount.part.1
	b	.L3472
.L3479:
	mov	r0, r5
	bl	IDRMemMarking
	cmp	r0, #0
	beq	.L3483
	mvn	r0, #0
	b	.L3595
.L3615:
	mov	r2, #3
	ldr	r3, [r10, #632]
	strb	r2, [r10, #1]
	ldr	r2, [r6, #652]
	add	r3, r3, r2
	str	r3, [r10, #632]
	b	.L3459
.L3631:
	add	r6, r5, #57600
	ldr	r10, [r4, #1744]
	add	r6, r6, #200
	b	.L3457
.L3633:
	ldrb	r3, [r4, #459]
	cmp	r3, #0
	ldrne	r3, [r4, #1064]
	strne	r3, [r4, #1848]
	b	.L3506
.L3632:
	mov	r3, r0
	movw	r2, #3988
	ldr	r1, .L3635+20
	mov	r0, #1
	bl	dprint_vfmw
	mov	r2, r6
	movw	r3, #3989
	ldr	r1, .L3635+8
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3523
.L3616:
	movw	r2, #3790
	ldr	r1, .L3635+64
	bl	dprint_vfmw
	movw	r3, #3791
	mvn	r2, #0
	ldr	r1, .L3635+8
	mov	r0, #14
	bl	dprint_vfmw
	b	.L3523
.L3634:
	mov	r3, r0
	movw	r2, #4065
	ldr	r1, .L3635+20
	mov	r0, #1
	bl	dprint_vfmw
	b	.L3508
.L3636:
	.align	2
.L3635:
	.word	s_pstVfmwChan
	.word	.LC376
	.word	.LC370
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC369
	.word	.LC374
	.word	g_HwMem
	.word	.LC377
	.word	g_apple_airplay_mirrorinig_flag
	.word	.LC378
	.word	.LC371
	.word	g_event_report
	.word	.LC373
	.word	.LC375
	.word	.LANCHOR1+272
	.word	.LC379
	.word	.LC372
	.fnend
	.size	StorePicInDPB, .-StorePicInDPB
	.align	2
	.global	AllocFrameStore
	.type	AllocFrameStore, %function
AllocFrameStore:
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
	add	r8, r0, #20480
	mov	r7, r0
	str	r1, [fp, #-52]
	ldrb	r6, [r8, #209]
	cmp	r6, #0
	beq	.L3638
	ldrb	r3, [r8, #210]
	cmp	r3, #0
	beq	.L3700
	add	r5, r0, #57344
	ldr	r6, [r5, #3816]
	cmp	r6, #2
	beq	.L3676
	ldrb	r3, [r5, #1816]
	mov	r2, #0
	strb	r2, [r5, #457]
	cmp	r3, #1
	mov	r3, #2
	str	r3, [fp, #-48]
	bne	.L3668
.L3664:
	ldr	r2, [r5, #1824]
	ldr	r3, [r8, #228]
	cmp	r2, r3
	bne	.L3668
	ldr	r3, [r8, #240]
	cmp	r3, #0
	ldr	r3, [r5, #1820]
	beq	.L3701
	cmp	r3, #0
	beq	.L3668
.L3644:
	ldr	r3, [r5, #3900]
	ldr	r2, [r5, #3896]
	rsb	r3, r2, r3
	cmp	r3, #2
	bhi	.L3668
	ldr	r1, [r5, #1064]
	mov	r3, #1
	strb	r3, [r5, #457]
	cmp	r1, #0
	beq	.L3646
	ldr	r3, [fp, #-48]
	cmp	r3, #2
	beq	.L3702
	ldr	r3, [fp, #-48]
	cmp	r3, #1
	beq	.L3703
.L3671:
	mov	ip, #0
	b	.L3650
.L3638:
	add	r5, r0, #57344
	ldr	r3, [r5, #3816]
	cmp	r3, #2
	strneb	r6, [r5, #457]
	strne	r6, [fp, #-48]
	beq	.L3676
.L3668:
	ldr	r4, [r5, #2476]
	mov	lr, #0
	strb	lr, [r5, #456]
	cmp	r4, lr
	beq	.L3658
	add	ip, r7, #27392
	add	r10, r7, #26368
	add	ip, ip, #8
	add	r10, r10, #160
	add	r9, r7, #24576
.L3657:
	ldrb	r3, [ip, #1]
	cmp	r3, #0
	bne	.L3653
	cmp	ip, #0
	beq	.L3673
	ldr	r0, [r9, #2148]
	cmp	r0, #0
	beq	.L3673
	ldr	r2, [r9, #1952]
	cmp	r2, ip
	beq	.L3653
	mov	r2, r10
	b	.L3655
.L3656:
	ldr	r1, [r2, #4]!
	cmp	r1, ip
	beq	.L3653
.L3655:
	add	r3, r3, #1
	cmp	r3, r0
	bne	.L3656
.L3673:
	mov	r9, #760
	mov	r4, ip
	mla	r9, r9, lr, r7
	movw	ip, #28032
	mov	r10, #0
	str	r4, [r5, #1064]
	mov	r6, #1
	mov	lr, #101
	add	r1, r9, #27392
	strb	r6, [r5, #456]
	mov	r2, #592
	add	r1, r1, #16
	str	r10, [r9, ip]
	add	r0, r5, #472
	str	lr, [r5, #1108]
	bl	memcpy
	add	lr, r9, #27392
	str	r10, [r5, #632]
	strb	r10, [lr, #11]
	str	r10, [r4, #620]
	ldr	r2, [r5, #1064]
	strb	r10, [r2, #2]
	ldr	r2, [r5, #1064]
	strb	r6, [r2, #4]
	ldr	r3, [r5, #1064]
	str	r10, [r3, #752]
	ldrb	r4, [r5, #456]
	cmp	r4, r6
	bne	.L3658
	ldr	r3, [fp, #-52]
	ldr	r0, [r5, #3888]
	clz	r1, r3
	mov	r1, r1, lsr #5
	bl	FSP_NewLogicFs
	mov	r6, r0
	mov	r1, r0
	ldr	r0, [r5, #3888]
	bl	FSP_GetLogicFs
	mvn	r2, r6
	mov	r2, r2, lsr #31
	cmp	r0, #0
	mov	r9, r0
	moveq	r2, #0
	cmp	r2, #0
	beq	.L3659
	ldr	r2, [r7]
	ldr	r2, [r2, #28]
	cmp	r2, #25
	beq	.L3704
.L3660:
	ldr	r4, .L3707
	mov	r2, #592
	ldr	r0, [r5, #1064]
	add	r1, r9, #8
	ldr	ip, [r4, #52]
	add	r0, r0, #8
	blx	ip
	ldr	r1, [r5, #1064]
	add	r0, r7, #57600
	ldr	ip, [r4, #52]
	add	r1, r1, #8
	mov	r2, #592
	add	r0, r0, #216
	blx	ip
	ldr	r2, [r5, #1064]
	mov	ip, r6
	str	r6, [r2, #600]
	ldrsb	r3, [r9, #4]
	ldr	r1, [r5, #1064]
	str	r3, [r5, #1132]
.L3650:
	ldrb	r2, [fp, #-48]
	strb	r2, [r5, #459]
	ldrb	r3, [r8, #209]
	cmp	r3, #0
	movne	r3, #3
	strb	r3, [r1, #644]
	ldrb	r3, [r5, #457]
	cmp	r3, #1
	beq	.L3705
	ldr	r3, [fp, #-48]
	strb	r2, [r5, #1816]
	cmp	r3, #0
	ldr	r3, [r8, #228]
	ldr	r2, [r5, #3900]
	ldreq	r0, [fp, #-48]
	movne	r0, #0
	str	r3, [r5, #1824]
	ldr	r3, [r8, #240]
	str	ip, [r5, #1836]
	str	r2, [r5, #1832]
	str	r3, [r5, #1820]
	movne	r3, #1
	moveq	r3, r0
	strb	r3, [r5, #1817]
.L3693:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3653:
	add	lr, lr, #1
	add	ip, ip, #760
	cmp	lr, r4
	bne	.L3657
.L3658:
	ldr	r1, .L3707+4
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, r7
	mov	r1, #1
	bl	ClearAll
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3700:
	add	r5, r0, #57344
	ldr	r2, [r5, #3816]
	cmp	r2, #2
	beq	.L3706
	ldrb	r2, [r5, #1816]
	strb	r3, [r5, #457]
	mov	r3, #1
	cmp	r2, #2
	str	r3, [fp, #-48]
	bne	.L3668
	b	.L3664
.L3676:
	str	r6, [fp, #-48]
.L3697:
	mov	r3, #0
	strb	r3, [r5, #457]
	b	.L3668
.L3706:
	mov	r3, #1
	str	r3, [fp, #-48]
	b	.L3697
.L3704:
	add	r1, r7, #12288
	ldr	r4, [r0, #148]
	ldr	r0, [r0, #52]
	ldr	r2, [r1, #1280]
	ldr	r1, [r1, #1276]
	mov	r2, r2, asl #4
	str	r2, [r9, #124]
	mov	r1, r1, asl #4
	str	r1, [r9, #120]
	mul	r4, r4, r2
	add	r0, r4, r0
	str	r0, [r9, #56]
	bl	MEM_Phy2Vir
	ldr	r1, [r9, #36]
	ldr	r2, [r9, #148]
	str	r10, [r9, #492]
	str	r0, [r9, #488]
	ldr	r0, [r9, #68]
	add	r0, r4, r0
	add	r4, r4, r1
	str	r0, [r9, #72]
	str	r4, [r9, #40]
	add	r4, r4, r2
	str	r4, [r9, #48]
	bl	MEM_Phy2Vir
	str	r10, [r9, #508]
	str	r0, [r9, #504]
	b	.L3660
.L3705:
	mov	r3, #0
	strb	r3, [r5, #1816]
	ldr	r1, [r8, #228]
	mov	r0, r3
	ldr	r2, [r5, #3900]
	str	r1, [r5, #1824]
	ldr	r1, [r8, #240]
	strb	r3, [r5, #1817]
	str	ip, [r5, #1836]
	str	r1, [r5, #1820]
	str	r2, [r5, #1832]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3701:
	cmp	r3, #0
	beq	.L3644
	b	.L3668
.L3659:
	ldr	r3, [r5, #1064]
	mov	r0, r2
	strb	r2, [r5, #456]
	ldr	r1, .L3707+8
	strb	r2, [r3, #4]
	bl	dprint_vfmw
	mov	r1, r4
	mov	r0, r7
	bl	ClearAll
	mvn	r0, #0
	b	.L3693
.L3703:
	ldrb	r3, [r1, #1]
	cmp	r3, #2
	bne	.L3697
.L3649:
	ldr	r1, [r5, #1064]
	cmp	r1, #0
	bne	.L3671
	b	.L3668
.L3702:
	ldrb	r3, [r1, #1]
	cmp	r3, #1
	bne	.L3697
	b	.L3649
.L3646:
	strb	r1, [r5, #457]
	b	.L3668
.L3708:
	.align	2
.L3707:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC380
	.word	.LC381
	.fnend
	.size	AllocFrameStore, .-AllocFrameStore
	.global	__aeabi_idivmod
	.align	2
	.global	DecGap
	.type	DecGap, %function
DecGap:
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
	add	r1, r0, #24576
	add	r2, r0, #20480
	add	r9, r0, #12288
	movw	r3, #2004
	ldr	ip, [r1, #1812]
	mov	r6, r0
	mov	lr, r2
	ldrb	r0, [r9, #1325]
	add	r8, r6, #16384
	add	r4, r6, #57344
	mul	r3, r3, ip
	ldr	ip, [lr, #228]
	cmp	r0, #1
	str	r2, [fp, #-60]
	ldr	r0, [lr, #224]
	str	ip, [fp, #-52]
	moveq	ip, #2
	movne	ip, #0
	str	ip, [fp, #-56]
	add	ip, r6, r3
	ldr	lr, [r8, #3468]
	add	ip, ip, #22272
	ldr	r2, [r9, #3504]
	mov	r3, ip
	add	ip, ip, #104
	add	r3, r3, #108
	str	lr, [fp, #-68]
	ldrb	ip, [ip, #7]
	str	ip, [fp, #-76]
	ldr	ip, [r8, #3472]
	str	r3, [r4, #1068]
	ldr	r5, [r1, #2148]
	str	ip, [fp, #-72]
	cmp	r5, #0
	beq	.L3724
	add	r2, r2, #4
	mov	r5, #1
	mov	r3, r5, asl r2
	add	r0, r0, r5
	str	r3, [fp, #-64]
	mov	r1, r3
	bl	__aeabi_uidivmod
	mov	r3, #0
	mov	r0, #2
	str	r3, [r8, #3472]
	str	r3, [r8, #3468]
	mov	r10, r1
	ldr	r1, .L3728
	bl	dprint_vfmw
	ldr	r7, [fp, #-52]
	mov	r3, r10
	ldr	r1, .L3728+4
	mov	r0, #2
	mov	r2, r7
	bl	dprint_vfmw
	cmp	r7, r10
	mov	r3, r7
	movgt	r3, r9
	movgt	r9, r10
	movgt	r10, r4
	movgt	r4, r3
	bgt	.L3717
	b	.L3718
.L3715:
	mov	r1, r7
	strb	r7, [r10, #460]
	mov	r0, r6
	bl	StorePicInDPB
	ldr	r1, [fp, #-64]
	subs	r3, r0, #0
	add	r0, r9, #1
	bne	.L3725
	ldr	r3, [fp, #-60]
	str	r9, [r3, #224]
	bl	__aeabi_idivmod
	ldr	r3, [fp, #-52]
	cmp	r3, r1
	mov	r9, r1
	ble	.L3726
.L3717:
	mov	r1, #1
	mov	r0, r6
	bl	AllocFrameStore
	mov	r7, #0
	ldr	r1, .L3728+8
	subs	r3, r0, #0
	mov	r0, #2
	bne	.L3727
	str	r3, [fp, #-48]
	bl	dprint_vfmw
	ldr	r1, [r10, #1064]
	strb	r5, [r10, #462]
	ldr	r3, [fp, #-56]
	str	r9, [r1, #604]
	ldr	r1, [r10, #1064]
	str	r9, [r10, #1072]
	str	r9, [r1, #652]
	str	r3, [r10, #1080]
	ldr	r1, [r10, #1064]
	ldr	r3, [fp, #-48]
	str	r3, [r1, #648]
	ldr	r1, [r10, #1064]
	str	r5, [r1, #620]
	ldr	r1, [r10, #1064]
	strb	r3, [r1, #4]
	ldr	r1, [r10, #1064]
	strb	r5, [r1]
	ldr	r1, [r10, #1068]
	strb	r5, [r10, #458]
	strb	r3, [r1, #3]
	ldr	r3, [r4, #3508]
	cmp	r3, #0
	beq	.L3715
	str	r9, [r8, #3484]
	mov	r0, r6
	bl	DecPOC
	ldr	r3, [r8, #3464]
	str	r3, [r10, #1084]
	ldr	r3, [r8, #3460]
	str	r3, [r10, #1088]
	ldr	r3, [r8, #3452]
	str	r3, [r10, #1092]
	ldr	r3, [r8, #3456]
	str	r3, [r10, #1096]
	b	.L3715
.L3724:
	ldr	r1, .L3728+12
	mov	r0, r5
	bl	dprint_vfmw
	mov	r0, r5
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3726:
	mov	r4, r10
.L3718:
	ldr	r3, [fp, #-68]
	mov	r0, #0
	ldrb	r2, [fp, #-76]
	str	r3, [r8, #3468]
	ldr	r3, [fp, #-72]
	str	r3, [r8, #3472]
	ldr	r3, [r4, #1068]
	strb	r2, [r3, #3]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3727:
	ldr	r3, [fp, #-68]
	mov	r0, r7
	ldrb	r2, [fp, #-76]
	ldr	r1, .L3728+16
	str	r3, [r8, #3468]
	ldr	r3, [fp, #-72]
	str	r3, [r8, #3472]
	ldr	r3, [r10, #1068]
	strb	r2, [r3, #3]
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3725:
	ldr	r2, [fp, #-68]
	mov	r0, r7
	ldrb	lr, [fp, #-76]
	ldr	r1, .L3728+20
	str	r2, [r8, #3468]
	ldr	r2, [fp, #-72]
	str	r2, [r8, #3472]
	movw	r2, #6506
	ldr	ip, [r10, #1068]
	strb	lr, [ip, #3]
	bl	dprint_vfmw
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3729:
	.align	2
.L3728:
	.word	.LC383
	.word	.LC384
	.word	.LC386
	.word	.LC382
	.word	.LC385
	.word	.LC387
	.fnend
	.size	DecGap, .-DecGap
	.align	2
	.global	H264DEC_Init
	.type	H264DEC_Init, %function
H264DEC_Init:
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
	ldr	r8, .L3743
	ldr	r4, [r0, #352]
	mov	r5, r0
	mov	r7, r1
	movw	r2, #61280
	ldr	r3, [r8, #48]
	mov	r1, #0
	blx	r3
	str	r4, [r5, #352]
	add	r0, r5, #8
	bl	ResetVoQueue
	mov	r3, #0
	str	r7, [r5]
	str	r3, [r5, #360]
	str	r3, [r5, #364]
	ldr	r3, [r7, #28]
	cmp	r3, #25
	beq	.L3740
	add	r6, r5, #12288
	mov	r1, #32
	mov	r2, #256
	mov	r3, #136
	str	r1, [r6, #1288]
	str	r2, [r6, #1292]
	str	r3, [r6, #1284]
.L3732:
	ldr	r0, [r7, #580]
	add	r4, r5, #57344
	bl	MEM_Phy2Vir
	ldr	lr, [r6, #1288]
	ldr	r3, [r5]
	mov	r2, #4000
	ldr	r1, [r6, #1292]
	mul	r2, r2, lr
	ldr	r3, [r3, #576]
	add	r3, r0, r3
	mov	r0, #2208
	add	ip, r3, r2
	str	r3, [r6, #1300]
	cmp	r3, #0
	cmpne	ip, #0
	str	ip, [r6, #1304]
	mla	r0, r0, r1, ip
	moveq	r9, #1
	movne	r9, #0
	cmp	r0, #0
	orreq	r9, r9, #1
	cmp	r9, #0
	str	r0, [r4, #3808]
	bne	.L3741
	ldr	r7, [r7, #604]
	mov	r10, r7
	adds	r7, r3, #0
	movne	r7, #1
	cmp	r10, #0
	movne	r7, #0
	cmp	ip, #0
	moveq	ip, #0
	andne	ip, r7, #1
	cmp	ip, #0
	beq	.L3735
	mov	r0, r3
	mov	r1, r9
	ldr	r3, [r8, #48]
	blx	r3
	ldr	r2, [r6, #1292]
	mov	ip, #2208
	mov	r1, r9
	ldr	r3, [r8, #48]
	ldr	r0, [r6, #1304]
	mul	r2, ip, r2
	blx	r3
	ldr	r1, [r6, #1292]
	ldr	lr, [r6, #1288]
	ldr	r0, [r4, #3808]
.L3735:
	add	r3, r5, #16384
	movw	r2, #4060
	ldr	ip, [r8, #48]
	str	r1, [r3, #1236]
	mov	r1, #0
	ldr	r3, [r6, #1284]
	mov	r7, r1
	str	lr, [r6, #1344]
	mul	r2, r2, r3
	blx	ip
	mov	r1, #40
	mov	r2, #17
	mov	r3, #25
	str	r7, [r4, #3832]
	mov	r0, r5
	str	r7, [r4, #3836]
	str	r7, [r4, #3840]
	str	r7, [r4, #3844]
	str	r7, [r4, #3848]
	str	r7, [r4, #3852]
	str	r7, [r4, #3856]
	str	r7, [r4, #3860]
	str	r7, [r4, #3824]
	str	r7, [r4, #2504]
	str	r7, [r4, #2508]
	str	r7, [r4, #2512]
	str	r7, [r4, #2516]
	str	r7, [r4, #2520]
	str	r7, [r4, #2484]
	str	r7, [r4, #2492]
	str	r7, [r4, #3892]
	str	r7, [r4, #2496]
	str	r1, [r4, #2476]
	str	r2, [r4, #2480]
	str	r3, [r4, #2500]
	bl	VCTRL_GetChanIDByCtx
	cmn	r0, #1
	str	r0, [r4, #3888]
	beq	.L3742
	mov	r1, r7
	mov	r0, r5
	bl	ClearAll
	mov	r0, #1
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3740:
	ldr	r3, [r7, #676]
	add	r6, r5, #12288
	str	r3, [r6, #1288]
	ldr	r3, [r7, #680]
	str	r3, [r6, #1292]
	ldr	r3, [r7, #668]
	str	r3, [r6, #1284]
	b	.L3732
.L3741:
	movw	r3, #13027
	ldr	r2, .L3743+4
	ldr	r1, .L3743+8
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #19
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3742:
	mov	r0, r7
	ldr	r1, .L3743+12
	bl	dprint_vfmw
	mvn	r0, #19
	ldmfd	sp, {r3, r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3744:
	.align	2
.L3743:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR1+288
	.word	.LC388
	.word	.LC389
	.fnend
	.size	H264DEC_Init, .-H264DEC_Init
	.align	2
	.global	InitPic
	.type	InitPic, %function
InitPic:
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
	add	r9, r0, #12288
	add	r8, r0, #20480
	add	r4, r0, #57344
	mov	r5, r0
	ldr	r1, [r9, #1304]
	mov	r10, #2208
	ldr	r0, [r8, #220]
	mov	r7, #4000
	ldrb	r2, [r4, #456]
	ldr	r3, [r9, #1300]
	mla	r10, r10, r0, r1
	cmp	r2, #0
	ldr	r2, [r10, #28]
	mla	r7, r7, r2, r3
	beq	.L3746
	ldr	r3, [r4, #1064]
	cmp	r3, #0
	beq	.L3747
	ldrb	r6, [r3, #1]
	cmp	r6, #0
	beq	.L3884
.L3748:
	mov	r3, #0
	strb	r3, [r4, #456]
.L3746:
	sub	r1, fp, #48
	mov	r0, r5
	bl	GetReRangeFlag
	ldr	r2, [r9, #1344]
	ldr	r3, [r7, #36]
	cmp	r2, r3
	mov	r6, r0
	beq	.L3885
.L3749:
	ldr	r3, .L3901
	add	r0, r5, #13568
	mov	r2, #0
	add	r0, r0, #28
	strb	r2, [r7, #24]
	mov	r1, r7
	ldr	r3, [r3, #56]
	mov	r2, #4000
	blx	r3
	ldr	r3, [fp, #-48]
	cmp	r3, #0
	ldr	r3, [r5]
	beq	.L3751
.L3895:
	ldr	r2, [r3, #700]
	cmp	r2, #0
	bne	.L3752
	ldr	r3, [r3, #28]
	cmp	r3, #25
	beq	.L3886
.L3752:
	ldr	r3, [r4, #3848]
	cmp	r6, #0
	add	r3, r3, #1
	str	r3, [r4, #3848]
	bne	.L3763
	ldr	r3, [r5]
	ldr	r3, [r3, #864]
	cmp	r3, #1
	beq	.L3763
	mov	r0, r5
	bl	FlushDPB
	cmp	r0, #0
	bne	.L3887
	mov	r0, r5
	bl	InitDPB
	cmp	r0, #0
	bne	.L3814
.L3768:
	ldr	r3, [r5]
	ldr	r3, [r3, #864]
	cmp	r3, #1
	beq	.L3771
.L3879:
	add	r6, r5, #16384
.L3762:
	ldr	r2, [r6, #1236]
	ldr	r3, [r10, #24]
	cmp	r2, r3
	bne	.L3774
	ldrb	r3, [r10, #20]
	cmp	r3, #0
	bne	.L3774
.L3775:
	ldr	r3, [r6, #3444]
	ldr	r10, [r9, #3504]
	cmp	r3, #0
	movne	r3, #0
	strne	r3, [r8, #224]
	strne	r3, [r4, #1824]
	ldr	r3, [r4, #3816]
	cmp	r3, #2
	beq	.L3777
	ldr	r2, [r5]
	ldr	r3, [r2, #12]
	str	r2, [fp, #-56]
	sub	r3, r3, #2
	cmp	r3, #1
	bls	.L3777
	ldr	ip, [r8, #228]
	ldr	r3, [r8, #224]
	cmp	ip, r3
	str	ip, [fp, #-60]
	beq	.L3778
	mov	r1, #1
	add	r10, r10, #4
	mov	r10, r1, asl r10
	add	r0, r3, r1
	str	r3, [fp, #-64]
	mov	r1, r10
	bl	__aeabi_uidivmod
	ldr	ip, [fp, #-60]
	cmp	ip, r1
	beq	.L3815
	ldr	r2, [fp, #-56]
	ldr	r3, [fp, #-64]
	ldr	r1, [r2, #596]
	cmp	r1, #0
	bne	.L3779
	ldr	r1, [r2, #632]
	cmp	r1, #1
	beq	.L3888
.L3780:
	cmp	ip, r3
	bls	.L3781
	ldr	r2, [r6, #484]
	rsb	r3, r3, ip
	cmp	r2, r3
	bcs	.L3779
	ldrb	r3, [r8, #208]
	cmp	r3, #2
	bne	.L3889
	cmp	ip, #0
	mov	r0, r5
	subeq	ip, r10, #1
	subne	ip, ip, #1
	str	ip, [r8, #224]
	bl	FlushDPB
	subs	r3, r0, #0
	beq	.L3779
	movw	r2, #6832
	ldr	r1, .L3901+4
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
.L3873:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3774:
	ldr	r3, .L3901
	add	r0, r5, #17408
	mov	r2, #0
	mov	r1, r10
	strb	r2, [r10, #20]
	add	r0, r0, #188
	ldr	r3, [r3, #56]
	mov	r2, #2208
	blx	r3
	b	.L3775
.L3763:
	ldr	r1, .L3901+8
	mov	r0, #22
	bl	dprint_vfmw
	ldr	r3, [r4, #3928]
	cmp	r3, #1
	beq	.L3890
.L3765:
	mov	r0, r5
	bl	InitDPB
	cmp	r0, #0
	bne	.L3814
	cmp	r6, #0
	beq	.L3768
.L3771:
	add	r6, r5, #16384
	add	r3, r5, #59648
	add	r3, r3, #172
	mov	r0, r5
	ldr	lr, [r6, #484]
	str	lr, [r4, #2480]
	ldr	r2, [r6, #464]
	ldrb	r1, [r9, #1326]
	add	r2, r2, #1
	ldr	ip, [r6, #460]
	rsb	r1, r1, #2
	str	lr, [sp]
	mov	r2, r2, asl #4
	add	ip, ip, #1
	mul	r2, r1, r2
	mov	ip, ip, asl #4
	str	ip, [fp, #-56]
	mov	r1, ip
	str	r2, [fp, #-60]
	bl	H264_ArrangeVahbMem
	ldr	ip, [fp, #-56]
	cmp	r0, #1
	beq	.L3891
.L3878:
	ldr	r3, [r5]
	ldr	r3, [r3, #864]
	cmp	r3, #1
	mvneq	r0, #1
	beq	.L3873
	mov	r4, #0
	ldr	r1, .L3901+12
	str	r4, [r9, #1276]
	mov	r0, r4
	str	r4, [r9, #1280]
	bl	dprint_vfmw
	mov	r1, r4
	mov	r0, r5
	bl	ClearAll
	mvn	r0, #0
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3815:
	mov	r3, ip
.L3778:
	ldr	r2, [r8, #240]
	mov	r0, r5
	cmp	r2, #0
	strne	r3, [r8, #224]
	str	r3, [r6, #3484]
	bl	DecPOC
	mov	r1, #0
	mov	r0, r5
	bl	AllocFrameStore
	cmp	r0, #0
	bne	.L3892
	strb	r0, [r4, #463]
	mov	r1, #1
	strb	r1, [r4, #456]
	mvn	r3, #0
	ldrb	r2, [r8, #211]
	strb	r2, [r4, #462]
	ldr	ip, [r8, #228]
	str	ip, [r4, #1072]
	ldr	r2, [r8, #240]
	str	ip, [fp, #-56]
	str	r2, [r4, #1080]
	ldr	lr, [r6, #3464]
	str	r2, [fp, #-60]
	str	lr, [r4, #1084]
	ldr	lr, [r6, #3460]
	str	lr, [r4, #1088]
	ldr	lr, [r6, #3452]
	str	lr, [r4, #1092]
	ldr	lr, [r6, #3456]
	strb	r0, [r4, #458]
	strb	r0, [r4, #461]
	str	lr, [r4, #1096]
	strb	r0, [r4, #460]
	str	r3, [r4, #1128]
	ldrb	r3, [r8, #209]
	cmp	r3, #0
	strneb	r1, [r8, #209]
	ldrb	r10, [r9, #1326]
	ldr	r0, [r6, #464]
	movne	r3, r1
	rsb	r10, r10, #2
	movne	r1, #2
	str	r3, [fp, #-64]
	mla	r10, r0, r10, r10
	mov	r0, r10
	bl	__aeabi_uidiv
	str	r10, [r4, #1120]
	ldr	r3, [fp, #-64]
	ldr	ip, [fp, #-56]
	cmp	r3, #0
	ldr	r2, [fp, #-60]
	movne	r3, #0
	str	r0, [r4, #1116]
	ldr	lr, [r6, #460]
	add	r1, lr, #1
	str	r1, [r4, #1112]
	mul	r1, r1, r0
	str	r1, [r4, #1124]
	ldrb	r1, [r6, #1212]
	strb	r1, [r4, #464]
	movne	r1, r3
	bne	.L3799
	ldrb	r1, [r9, #1327]
	cmp	r1, #0
	movne	r3, #1
	movne	r1, r3
.L3799:
	str	r3, [r4, #3804]
	add	r3, r5, #24576
	strb	r1, [r4, #465]
	cmp	r2, #0
	strne	ip, [r8, #224]
	movw	ip, #2004
	ldr	r0, [r3, #1812]
	movw	lr, #58384
	add	r8, r5, #58368
	movw	r10, #58400
	ldr	r1, .L3901+16
	mla	ip, ip, r0, r5
	mov	r0, #29
	add	ip, ip, #22272
	add	ip, ip, #108
	str	ip, [r4, #1068]
	ldr	ip, [r5]
	ldrd	r2, [ip, #56]
	strd	r2, [r5, lr]
	ldrd	r2, [ip, #72]
	strd	r2, [r8, #24]
	ldrd	r2, [ip, #88]
	strd	r2, [r5, r10]
	mvn	r2, #0
	ldr	r10, [ip, #104]
	mvn	r3, #0
	str	r10, [r4, #480]
	ldr	r10, [ip, #108]
	str	r10, [r4, #484]
	ldr	r10, [ip, #112]
	str	r10, [r4, #488]
	ldr	r10, [ip, #128]
	str	r10, [r4, #492]
	ldr	r10, [r7, #44]
	str	r10, [r4, #648]
	ldr	r10, [r7, #48]
	str	r10, [r4, #652]
	strd	r2, [ip, #56]
	ldrd	r2, [r5, lr]
	bl	dprint_vfmw
	ldrd	r2, [r8, #24]
	ldr	r1, .L3901+20
	mov	r0, #29
	bl	dprint_vfmw
	ldr	r3, [r6, #460]
	add	r0, r5, #57600
	add	r3, r3, #1
	add	r0, r0, #216
	mov	r3, r3, asl #4
	str	r3, [r4, #584]
	ldrb	r2, [r9, #1326]
	ldr	r1, [r6, #464]
	rsb	r3, r2, #2
	mla	r3, r1, r3, r3
	mov	r3, r3, asl #4
	str	r3, [r4, #588]
	ldr	r2, [r9, #1348]
	ldr	r3, [r6, #532]
	subs	r2, r2, #1
	ldr	r1, [r6, #528]
	movne	r2, #1
	and	r1, r1, #7
	mov	r3, r3, asl #5
	mov	r2, r2, asl #2
	orr	r2, r2, r1, asl #14
	uxtb	r3, r3
	orr	r3, r2, r3
	str	r3, [r4, #580]
	bl	SetAspectRatio
	ldrb	r3, [r4, #459]
	ldr	r2, [r4, #1064]
	adds	r3, r3, #0
	ldr	r1, [r4, #3848]
	movne	r3, #1
	cmp	r2, #0
	str	r3, [r4, #568]
	str	r1, [r4, #636]
	beq	.L3893
	ldr	r3, [r4, #580]
	str	r3, [r2, #116]
	ldr	r3, [r4, #1064]
	ldr	r2, [r4, #568]
	str	r2, [r3, #104]
	ldr	r3, [r4, #1064]
	ldr	r2, [r4, #476]
	str	r2, [r3, #12]
	ldr	r3, [r4, #1064]
	ldr	r2, [r4, #472]
	str	r2, [r3, #8]
	ldr	r3, [r4, #1064]
	ldr	r2, [r4, #584]
	str	r2, [r3, #120]
	ldr	r3, [r4, #1064]
	ldr	r2, [r4, #588]
	str	r2, [r3, #124]
	ldr	r3, [r7, #3284]
	ldr	r2, [r4, #1064]
	str	r3, [r2, #136]
	str	r3, [r4, #600]
	ldr	r2, [r4, #1064]
	ldr	r3, [r7, #3288]
	str	r3, [r2, #140]
	str	r3, [r4, #604]
	ldr	r2, [r4, #1064]
	ldr	r3, [r7, #3276]
	str	r3, [r2, #128]
	str	r3, [r4, #592]
	ldr	r2, [r4, #1064]
	ldr	r3, [r7, #3280]
	str	r3, [r2, #132]
	str	r3, [r4, #596]
	ldr	r3, [r4, #1064]
	ldr	r0, [r4, #3888]
	ldr	r1, [r3, #600]
	bl	FSP_GetDispPhyFs
	cmp	r0, #0
	beq	.L3802
	ldr	r3, [r4, #568]
	mov	r1, #0
	ldr	r2, [r0, #8]
	subs	r3, r3, r1
	ldr	r0, [r4, #3888]
	movne	r3, #1
	bl	FSP_SetStoreType
.L3802:
	add	ip, r5, #58112
	add	r6, r5, #59648
	ldr	r3, [r4, #2504]
	add	ip, ip, #224
	add	r6, r6, #204
	add	lr, r5, #58368
	mov	r7, #0
.L3806:
	ldrd	r0, [ip, #8]!
	orrs	r2, r0, r1
	bne	.L3803
	cmp	r3, #0
	beq	.L3803
	ldr	r2, [r4, #2508]
	subs	r3, r3, #1
	stmia	ip, {r2, r7}
	beq	.L3804
	mov	r1, r6
	mov	r2, #0
.L3805:
	add	r2, r2, #1
	ldr	r0, [r1, #4]!
	cmp	r2, r3
	str	r0, [r1, #-4]
	bne	.L3805
.L3804:
	add	r2, r3, #14912
	add	r2, r2, #50
	add	r2, r5, r2, lsl #2
	str	r7, [r2, #4]
	str	r3, [r4, #2504]
.L3803:
	cmp	ip, lr
	bne	.L3806
	cmp	r3, #0
	beq	.L3808
	mov	r7, r3
	ble	.L3808
	add	r6, r3, #14912
	mov	r8, #0
	add	r6, r6, #51
	add	r6, r5, r6, lsl #2
.L3809:
	ldr	r1, [r6, #-4]!
	sub	r7, r7, #1
	ldr	r0, [r4, #3888]
	bl	FreeUsdByDec
	cmp	r7, #0
	str	r8, [r6]
	bne	.L3809
.L3808:
	mov	r0, r5
	mov	r5, #0
	str	r5, [r4, #2504]
	str	r5, [r4, #1100]
	bl	CalcPicNum
	mov	r0, r5
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3790:
	mov	r0, r5
	bl	DecGap
	cmp	r0, #0
	bne	.L3894
.L3777:
	ldr	r3, [r8, #228]
	b	.L3778
.L3885:
	ldrb	r3, [r7, #24]
	cmp	r3, #0
	bne	.L3749
	ldr	r3, [fp, #-48]
	cmp	r3, #0
	ldr	r3, [r5]
	bne	.L3895
.L3751:
	ldr	r3, [r3, #864]
	cmp	r3, #1
	bne	.L3879
	b	.L3752
.L3886:
	ldr	r3, [r4, #3848]
	cmp	r6, #0
	add	r3, r3, #1
	str	r3, [r4, #3848]
	beq	.L3753
	mov	r0, r5
	str	r2, [fp, #-56]
	bl	FlushDPB
	ldr	r2, [fp, #-56]
	subs	r3, r0, #0
	bne	.L3896
	mov	r0, r5
	bl	InitDPB
	subs	r3, r0, #0
	bne	.L3810
	add	r6, r5, #16384
	ldrb	ip, [r9, #1326]
	ldr	r1, [r9, #1276]
	ldr	r3, [r6, #464]
	rsb	ip, ip, #2
	ldr	r2, [r6, #460]
	cmp	r1, #0
	add	r3, r3, #1
	add	r2, r2, #1
	mov	r3, r3, asl #4
	mov	r2, r2, asl #4
	str	r2, [fp, #-56]
	mul	ip, ip, r3
	bne	.L3760
	ldr	r0, [r6, #484]
	ldr	r2, [fp, #-56]
	str	r0, [r4, #2480]
	ldr	r3, [r5]
	ldr	r1, [r3, #660]
	cmp	r1, r2
	bcc	.L3756
	ldr	r2, [r3, #664]
	cmp	r2, ip
	str	r2, [fp, #-60]
	bcc	.L3756
	add	lr, r5, #24576
	ldr	r2, [r3, #684]
	ldr	lr, [lr, #2144]
	cmp	r2, lr
	bcc	.L3897
	ldr	lr, [r3, #688]
	str	ip, [fp, #-64]
	cmp	lr, #0
	moveq	r0, #1
	streq	r0, [r4, #2480]
	ldreq	r1, [r3, #660]
	ldreq	r3, [r3, #664]
	str	r0, [sp]
	mov	r0, r5
	streq	r3, [fp, #-60]
	add	r3, r5, #59648
	ldr	r2, [fp, #-60]
	add	r3, r3, #172
	bl	H264_ArrangeVahbMem
	ldr	ip, [fp, #-64]
	cmp	r0, #1
	bne	.L3878
	b	.L3760
.L3888:
	ldr	r1, [r2, #628]
	cmp	r1, #0
	bne	.L3780
	ldr	r1, [r2, #636]
	cmp	r1, #0
	bne	.L3780
	ldr	r2, [r2, #600]
	add	r2, r2, #1024
	cmp	r2, #2048
	bls	.L3780
.L3779:
	ldrb	r3, [r9, #1325]
	cmp	r3, #0
	bne	.L3790
	ldr	r1, .L3901+24
	mov	r0, #2
	bl	dprint_vfmw
	ldr	r3, [r5]
	ldr	r3, [r3, #600]
	bics	r3, r3, #1024
	str	r3, [fp, #-56]
	bne	.L3777
	ldr	r3, [r8, #228]
	mov	r1, r10
	ldr	r0, [r8, #224]
	add	r0, r0, #1
	str	r3, [fp, #-60]
	bl	__aeabi_uidivmod
	ldr	r3, [fp, #-60]
	cmp	r3, r1
	bcs	.L3792
	ldrb	r2, [r8, #208]
	cmp	r2, #2
	beq	.L3778
	mov	r0, r5
	bl	H264_ClearCurrPic
	ldr	r3, .L3901+28
	ldrb	r3, [r3]
	cmp	r3, #0
	bne	.L3793
	mov	r0, r5
	bl	ClearDPB
.L3793:
	movw	r2, #6893
	ldr	r1, .L3901+32
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3873
.L3884:
	ldr	r1, [r3, #600]
	mov	r2, #1
	ldr	r0, [r4, #3888]
	bl	FSP_ClearLogicFs
	ldr	r3, [r4, #1064]
	strb	r6, [r3, #1]
	ldr	r3, [r4, #1064]
	strb	r6, [r3, #4]
	b	.L3748
.L3891:
	ldr	r3, [fp, #-60]
	mov	ip, ip, lsr #4
	str	ip, [r9, #1276]
	mov	r3, r3, lsr #4
	str	r3, [r9, #1280]
	b	.L3762
.L3890:
	mov	r0, r5
	bl	GetBackPicFromVOQueue
	b	.L3765
.L3781:
	rsb	r3, r3, ip
	ldr	r2, [r6, #484]
	add	r3, r3, r10
	cmp	r2, r3
	bcs	.L3779
	ldrb	r3, [r8, #208]
	cmp	r3, #2
	bne	.L3898
	cmp	ip, #0
	mov	r0, r5
	subeq	ip, r10, #1
	subne	ip, ip, #1
	str	ip, [r8, #224]
	bl	FlushDPB
	subs	r3, r0, #0
	beq	.L3779
	movw	r2, #6863
	ldr	r1, .L3901+4
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3873
.L3753:
	mov	r0, r5
	bl	InitDPB
	subs	r3, r0, #0
	bne	.L3810
	add	r6, r5, #16384
	ldrb	ip, [r9, #1326]
	ldr	r3, [r6, #464]
	rsb	ip, ip, #2
	ldr	r2, [r6, #460]
	add	r3, r3, #1
	add	r2, r2, #1
	mov	r3, r3, asl #4
	mov	r2, r2, asl #4
	str	r2, [fp, #-56]
	mul	ip, ip, r3
.L3760:
	ldr	r3, [fp, #-56]
	mov	ip, ip, lsr #4
	str	ip, [r9, #1280]
	mov	r3, r3, lsr #4
	str	r3, [r9, #1276]
	b	.L3762
.L3747:
	movw	r3, #6569
	ldr	r2, .L3901+36
	ldr	r1, .L3901+40
	mov	r0, #22
	bl	dprint_vfmw
	b	.L3748
.L3894:
	movw	r2, #6920
	ldr	r1, .L3901+44
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3873
.L3892:
	movw	r2, #6946
	ldr	r1, .L3901+48
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3873
.L3792:
	mov	r0, r5
	bl	DecGap
	cmp	r0, #0
	beq	.L3777
	ldr	r0, [fp, #-56]
	movw	r2, #6905
	ldr	r1, .L3901+44
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3873
.L3814:
	mov	r3, r0
	movw	r2, #6738
	ldr	r1, .L3901+52
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3873
.L3893:
	movw	r3, #7033
	ldr	r2, .L3901+36
	ldr	r1, .L3901+56
	mov	r0, #22
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3873
.L3887:
	mov	r3, r0
	movw	r2, #6729
	mov	r0, r6
	ldr	r1, .L3901+4
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3873
.L3898:
	mov	r0, r5
	bl	H264_ClearCurrPic
	ldr	r3, .L3901+28
	ldrb	r3, [r3]
	cmp	r3, #0
	beq	.L3899
.L3787:
	ldr	ip, [r6, #484]
	movw	r2, #6852
.L3881:
	ldr	r1, [r8, #228]
	mov	r0, #0
	ldr	r3, [r8, #224]
	str	ip, [sp]
	rsb	r3, r3, r1
	ldr	r1, .L3901+60
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3873
.L3889:
	mov	r0, r5
	bl	H264_ClearCurrPic
	ldr	r3, .L3901+28
	ldrb	r3, [r3]
	cmp	r3, #0
	beq	.L3900
.L3783:
	ldr	ip, [r6, #484]
	movw	r2, #6821
	b	.L3881
.L3756:
	ldr	r1, .L3901+64
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3873
.L3810:
	movw	r2, #6612
	ldr	r1, .L3901+52
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3873
.L3896:
	mov	r0, r2
	ldr	r1, .L3901+4
	movw	r2, #6603
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3873
.L3900:
	mov	r0, r5
	bl	ClearDPB
	b	.L3783
.L3897:
	ldr	r1, .L3901+68
	mov	r0, #0
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3873
.L3899:
	mov	r0, r5
	bl	ClearDPB
	b	.L3787
.L3902:
	.align	2
.L3901:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC354
	.word	.LC395
	.word	.LC394
	.word	.LC401
	.word	.LC402
	.word	.LC397
	.word	g_apple_airplay_mirrorinig_flag
	.word	.LC398
	.word	.LANCHOR1+304
	.word	.LC390
	.word	.LC399
	.word	.LC400
	.word	.LC391
	.word	.LC403
	.word	.LC396
	.word	.LC392
	.word	.LC393
	.fnend
	.size	InitPic, .-InitPic
	.align	2
	.global	H264_DecSlice
	.type	H264_DecSlice, %function
H264_DecSlice:
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
	add	r7, r0, #57344
	mov	r5, r0
	ldr	r1, .L3963
	mov	r0, #22
	ldr	r2, [r7, #3832]
	add	r6, r5, #20480
	sub	r2, r2, #1
	bl	dprint_vfmw
	ldr	r3, [r5, #368]
	ldr	r1, .L3963+4
	ldrb	r2, [r3, #2]
	strb	r2, [r6, #211]
	ldr	r3, [r3, #76]
	str	r3, [r6, #240]
	ldr	r3, [r7, #3888]
	ldr	r3, [r1, r3, asl #2]
	ldrsb	r1, [r3, #160]
	cmp	r1, #1
	beq	.L3956
.L3904:
	mov	r0, r5
	bl	ProcessSliceHeaderFirstPart
	cmp	r0, #0
	bne	.L3955
	mov	r0, r5
	bl	ProcessSliceHeaderSecondPart
	cmp	r0, #0
	bne	.L3955
	ldr	r2, [r7, #3812]
	cmp	r2, #0
	moveq	r3, r2
	beq	.L3911
	add	r9, r5, #59136
	mov	r3, r0
	add	r9, r9, #68
	mov	r1, r0
	mov	r8, r0
	b	.L3919
.L3957:
	cmp	r4, r1
	add	r3, ip, r3
	rsbhi	r0, r0, r10
	rsbhi	r1, r1, r4
	addhi	r0, r1, r0
	movls	r0, r10
	add	r3, r3, r0
.L3917:
	cmp	lr, #0
	add	r8, r8, #1
	moveq	r1, r4
	moveq	r0, r10
	movne	r1, lr
	movne	r0, ip
	cmp	r8, r2
	beq	.L3911
.L3919:
	ldr	ip, [r9, #4]!
	ldr	r4, [ip, #8]
	ldr	lr, [ip, #36]
	cmp	r4, #0
	ldrne	r10, [ip, #12]
	moveq	r10, r4
	cmp	lr, #0
	ldrne	ip, [ip, #40]
	moveq	ip, lr
	cmp	r1, #0
	bne	.L3957
	add	r3, r10, r3
	add	r3, r3, ip
	b	.L3917
.L3911:
	ldr	ip, [r7, #1116]
	movw	r0, #1620
	ldr	r1, [r7, #1112]
	str	r3, [r7, #3872]
	mul	r1, r1, ip
	cmp	r1, r0
	movgt	r1, r1, asl #8
	ble	.L3958
.L3921:
	add	r4, r5, #12288
	ldr	r0, [r4, #1284]
	cmp	r0, r2
	bls	.L3922
	cmp	r1, r3
	bcc	.L3922
	ldrb	r3, [r6, #213]
	cmp	r3, #0
	bne	.L3959
.L3925:
	mov	r0, r5
	bl	PicTypeStatistic
	mov	r0, r5
	bl	DecList
	cmp	r0, #0
	bne	.L3960
	mov	r0, r5
	bl	IsRefListWrong
	subs	r4, r0, #0
	bne	.L3961
	mov	r0, r5
	bl	CalcStreamBits
	mov	r0, r5
	bl	WriteSliceMsg
	mov	r0, r5
	bl	ExitSlice
	ldr	r3, [r7, #3868]
	mov	r0, r4
	mov	r2, #1
	add	r3, r3, r2
	str	r2, [r7, #2484]
	str	r3, [r7, #3868]
.L3908:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L3958:
	mov	r0, r1, asl #10
	movw	ip, #32769
	sub	r1, r0, r1, asl #8
	cmp	r1, ip
	movgt	r1, r1, asr #1
	movle	r1, #16384
	b	.L3921
.L3959:
	ldr	r1, .L3963+8
	mov	r0, #2
	bl	dprint_vfmw
	ldrb	r3, [r6, #211]
	ldrb	r1, [r7, #459]
	mov	r2, #0
	cmp	r3, #5
	ldr	r3, [r7, #3852]
	str	r2, [r7, #3868]
	mov	r0, r5
	streq	r3, [r7, #3864]
	cmp	r1, r2
	add	r3, r3, #1
	str	r3, [r7, #3852]
	ldreq	r3, [r7, #3856]
	ldrne	r3, [r7, #3860]
	addeq	r3, r3, #1
	addne	r3, r3, #1
	streq	r3, [r7, #3856]
	strne	r3, [r7, #3860]
	bl	InitPic
	cmn	r0, #2
	beq	.L3908
	cmp	r0, #0
	bne	.L3962
	mov	r0, r5
	bl	WritePicMsg
	b	.L3925
.L3956:
	ldr	r1, [r3, #168]
	cmp	r1, #0
	bne	.L3904
	ldr	r3, [r3, #172]
	cmp	r3, #1
	cmpeq	r2, #5
	bne	.L3904
	ldr	r1, [r5]
	mvn	r3, #0
	mvn	r2, #0
	ldrd	r0, [r1, #56]
	cmp	r1, r3
	cmpeq	r0, r2
	beq	.L3904
	add	r2, r5, #26368
	movw	ip, #26512
	add	r3, r2, #112
	strd	r0, [r2, #136]
	ldrd	r2, [r3, #-8]
	strd	r2, [r5, ip]
	b	.L3904
.L3955:
	ldr	r1, .L3963+12
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L3963+16
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L3953
	sub	r2, fp, #44
	mvn	r1, #0
	ldr	r0, [r7, #3888]
	mov	r3, #4
	str	r1, [r2, #-8]!
	mov	r1, #100
	blx	ip
.L3953:
	mov	r0, r5
	bl	ClearCurrSlice
	mvn	r0, #0
	b	.L3908
.L3922:
	str	r1, [sp]
	mov	r0, #0
	ldr	r1, .L3963+20
	bl	dprint_vfmw
	ldr	r2, [r4, #1284]
	ldr	r3, [r7, #3812]
	cmp	r3, r2
	bcc	.L3924
	ldr	r1, .L3963+16
	ldr	ip, [r1]
	cmp	ip, #0
	beq	.L3924
	str	r3, [fp, #-52]
	mov	r1, #108
	str	r2, [fp, #-48]
	mov	r3, #8
	sub	r2, fp, #52
	ldr	r0, [r7, #3888]
	blx	ip
.L3924:
	ldr	r1, .L3963+24
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r5
	bl	H264_ClearCurrPic
	mvn	r0, #0
	b	.L3908
.L3960:
	mov	r2, r0
	ldr	r1, .L3963+28
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3908
.L3961:
	ldr	r1, .L3963+32
	mov	r0, #1
	bl	dprint_vfmw
	b	.L3953
.L3962:
	ldr	r1, .L3963+36
	mov	r0, #1
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L3908
.L3964:
	.align	2
.L3963:
	.word	.LC344
	.word	s_pstVfmwChan
	.word	.LC406
	.word	.LC345
	.word	g_event_report
	.word	.LC404
	.word	.LC405
	.word	.LC408
	.word	.LC409
	.word	.LC407
	.fnend
	.size	H264_DecSlice, .-H264_DecSlice
	.align	2
	.global	H264_DecOneNal
	.type	H264_DecOneNal, %function
H264_DecOneNal:
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
	mov	r5, r1
	ldr	r1, [r0, #368]
	add	r4, r0, #57344
	mov	r6, r0
	ldr	r3, [r1, #68]
	cmp	r3, #0
	movne	ip, r1
	movne	r2, #0
	ldrne	r3, [r4, #3872]
	beq	.L3970
.L3969:
	ldr	lr, [ip, #12]
	add	r2, r2, #1
	add	ip, ip, #28
	add	r3, r3, lr
	str	r3, [r4, #3872]
	ldr	lr, [r1, #68]
	cmp	lr, r2
	bhi	.L3969
.L3970:
	mov	r2, #0
	ldr	r3, .L4137
	strb	r2, [r1]
	ldr	r2, [r4, #3888]
	ldr	r3, [r3, r2, asl #2]
	ldrsb	r2, [r3, #160]
	cmp	r2, #1
	beq	.L4129
.L3968:
	add	r8, r6, #13504
	mov	r1, #32
	add	r8, r8, #24
	mov	r0, r8
	bl	BsGet
	ldr	r2, [r6, #368]
	ldr	r3, [r2, #64]
	add	r3, r3, #32
	str	r3, [r2, #64]
	mov	r7, r0
.L3971:
	ldr	lr, [r6, #368]
	and	r0, r7, #31
	ubfx	r2, r7, #5, #2
	ubfx	r3, r7, #7, #1
	mov	ip, #0
	ldr	r1, .L4137+4
	strb	r0, [lr, #2]
	mov	r0, #22
	ldr	lr, [r6, #368]
	str	r2, [lr, #76]
	ldr	r2, [r6, #368]
	str	r3, [r2, #80]
	str	ip, [r4, #3828]
	ldr	r3, [r6, #368]
	ldr	r2, [r4, #3832]
	ldrb	r3, [r3, #2]
	bl	dprint_vfmw
	ldr	r1, [r4, #3832]
	movw	r3, #371
	cmp	r1, r3
	beq	.L4130
.L3972:
	add	r1, r1, #1
	str	r1, [r4, #3832]
	ldr	r3, [r6, #368]
	ldrb	r2, [r3, #2]
	cmp	r2, #20
	beq	.L4131
.L3973:
	sub	r3, r2, #1
	cmp	r3, #29
	ldrls	pc, [pc, r3, asl #2]
	b	.L3981
.L3983:
	.word	.L3982
	.word	.L3981
	.word	.L3981
	.word	.L3981
	.word	.L3982
	.word	.L3984
	.word	.L3985
	.word	.L3986
	.word	.L3987
	.word	.L3988
	.word	.L3989
	.word	.L3990
	.word	.L3991
	.word	.L3981
	.word	.L3985
	.word	.L3981
	.word	.L3981
	.word	.L3981
	.word	.L3992
	.word	.L3982
	.word	.L3981
	.word	.L3981
	.word	.L3981
	.word	.L3981
	.word	.L3981
	.word	.L3981
	.word	.L3981
	.word	.L3981
	.word	.L3981
	.word	.L3993
.L4129:
	ldr	r2, [r3, #168]
	cmp	r2, #0
	bne	.L3968
	ldr	r2, [r3, #172]
	cmp	r2, #1
	bne	.L3968
	ldr	r3, [r3, #164]
	cmp	r5, #0
	cmpeq	r3, #1
	bne	.L3968
	add	r8, r6, #13504
	mov	r1, #40
	add	r8, r8, #24
	mov	r0, r8
	bl	BsSkip
	mov	r0, r8
	mov	r1, #8
	bl	BsGet
	ldr	r2, [r6, #368]
	ldr	r3, [r2, #64]
	add	r3, r3, #48
	str	r3, [r2, #64]
	mov	r7, r0
	b	.L3971
.L3993:
	mov	r2, #30
	ldr	r1, .L4137+8
	mov	r0, #22
	bl	dprint_vfmw
	cmp	r5, #0
	bne	.L4008
	ldr	r1, [r6, #368]
	cmp	r1, #0
	beq	.L4008
	ldr	r0, [r4, #3888]
	bl	ReleaseNAL
	str	r5, [r6, #368]
.L4008:
	mov	r1, #32
	mov	r0, r8
	bl	BsGet
	mov	r1, #32
	mov	r5, r0
	mov	r0, r8
	bl	BsGet
	movw	r2, #20036
	movw	r3, #20553
	movt	r2, 17221
	movt	r3, 18515
	cmp	r0, r2
	cmpeq	r5, r3
	bne	.L4115
	ldr	r5, .L4137+12
	ldr	ip, [r5]
	cmp	ip, #0
	beq	.L4009
	mov	r3, #0
	mov	r1, #112
	mov	r2, r3
	ldr	r0, [r4, #3888]
	blx	ip
.L4009:
	mov	r7, #0
	mov	r0, r6
	str	r7, [r6, #364]
	bl	DecVDM
	cmp	r0, r7
	beq	.L4115
.L4124:
	ldr	ip, [r5]
	cmp	ip, r7
	beq	.L4110
.L4112:
	ldr	r0, [r4, #3888]
	mov	r3, r7
	mov	r2, r7
	mov	r1, #113
	blx	ip
.L4110:
	mvn	r0, #0
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L3982:
	ldr	r3, [r4, #3844]
	mov	r0, #22
	ldr	r1, .L4137+16
	add	r5, r6, #20480
	bl	dprint_vfmw
	ldr	r3, [r6, #368]
	mov	r0, r6
	ldrb	r2, [r3, #2]
	strb	r2, [r5, #211]
	ldr	r2, [r3, #76]
	str	r2, [r5, #240]
	ldrb	r3, [r3, #5]
	strb	r3, [r5, #216]
	bl	SliceCheck
	subs	r7, r0, #0
	bne	.L4132
	mov	r0, r6
	bl	H264_DecSlice
	cmn	r0, #2
	beq	.L4108
	cmp	r0, #0
	beq	.L3996
	ldr	r3, .L4137+12
	ldr	ip, [r3]
	cmp	ip, #0
	bne	.L4112
	b	.L4110
.L3984:
	ldr	r1, .L4137+20
	mov	r2, #6
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r6
	bl	H264_DecSEI
	ldr	r1, [r6, #368]
	cmp	r1, #0
	mov	r5, r0
	beq	.L4004
	ldr	r0, [r4, #3888]
	bl	ReleaseNAL
	mov	r3, #0
	str	r3, [r6, #368]
.L4004:
	cmp	r5, #0
	bne	.L4133
.L4115:
	mov	r0, #0
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L3985:
	ldr	r1, .L4137+24
	mov	r0, #22
	ldr	r3, [r4, #3836]
	bl	dprint_vfmw
	mov	r0, r6
	bl	H264_DecSPS
	ldr	r1, [r6, #368]
	cmp	r1, #0
	mov	r5, r0
	beq	.L4002
	ldr	r0, [r4, #3888]
	bl	ReleaseNAL
	mov	r3, #0
	str	r3, [r6, #368]
.L4002:
	cmp	r5, #0
	bne	.L4134
	ldr	r3, [r4, #3836]
	mov	r0, r5
	add	r3, r3, #1
	str	r3, [r4, #3836]
	b	.L4108
.L3989:
	mov	r2, #11
	ldr	r1, .L4137+28
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r6
	bl	H264_IsEosNal
	cmp	r0, #1
	beq	.L4135
.L4117:
	ldr	r1, [r6, #368]
	cmp	r1, #0
	beq	.L4115
	ldr	r0, [r4, #3888]
	bl	ReleaseNAL
	mov	r3, #0
	mov	r0, r3
	str	r3, [r6, #368]
.L4108:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L3990:
	ldr	r1, .L4137+32
	mov	r2, #12
.L4119:
	mov	r0, #22
	bl	dprint_vfmw
	b	.L4117
.L3991:
	mov	r2, #13
	ldr	r1, .L4137+36
	b	.L4119
.L3992:
	mov	r2, #19
	ldr	r1, .L4137+40
	b	.L4119
.L3987:
	mov	r2, #9
	ldr	r1, .L4137+44
	b	.L4119
.L3988:
	mov	r2, #10
	ldr	r1, .L4137+48
	b	.L4119
.L3986:
	ldr	r1, .L4137+52
	mov	r2, #8
	ldr	r3, [r4, #3840]
	mov	r0, #22
	bl	dprint_vfmw
	mov	r0, r6
	bl	H264_DecPPS
	ldr	r1, [r6, #368]
	cmp	r1, #0
	mov	r5, r0
	beq	.L4000
	ldr	r0, [r4, #3888]
	bl	ReleaseNAL
	mov	r3, #0
	str	r3, [r6, #368]
.L4000:
	cmp	r5, #0
	bne	.L4136
	ldr	r3, [r4, #3840]
	mov	r0, r5
	add	r3, r3, #1
	str	r3, [r4, #3840]
	b	.L4108
.L3981:
	mov	r3, r7
	ldr	r1, .L4137+56
	mov	r0, #22
	ldr	r5, .L4137+12
	bl	dprint_vfmw
	cmp	r7, #256
	beq	.L4010
	ldr	ip, [r5]
	cmp	ip, #0
	beq	.L4011
	mov	r3, #0
	mov	r1, #102
	mov	r2, r3
	ldr	r0, [r4, #3888]
	blx	ip
.L4010:
	ldr	r1, [r6, #368]
	cmp	r1, #0
	beq	.L4012
.L4013:
	ldr	r0, [r4, #3888]
	bl	ReleaseNAL
	mov	r3, #0
	str	r3, [r6, #368]
.L4012:
	ldr	ip, [r5]
	cmp	ip, #0
	beq	.L4115
.L4114:
	mov	r3, #0
	ldr	r0, [r4, #3888]
	mov	r2, r3
	mov	r1, #113
	blx	ip
	b	.L4115
.L4130:
	ldr	r1, .L4137+60
	mov	r0, #22
	bl	dprint_vfmw
	ldr	r1, [r4, #3832]
	b	.L3972
.L4131:
	mov	r1, #24
	mov	r0, r8
	bl	BsGet
	ldr	r3, [r6, #368]
	ubfx	r2, r0, #23, #1
	strb	r2, [r3, #3]
	ldr	r1, [r6, #368]
	mov	r7, r0
	ldrb	r3, [r1, #3]
	cmp	r3, #0
	bne	.L3974
	ldrb	r2, [r4, #1856]
	ldrb	r3, [r4, #1854]
.L3975:
	cmp	r2, #0
	bne	.L3976
	cmp	r3, #1
	beq	.L3977
.L3976:
	ldr	r1, .L4137+64
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r1, [r6, #368]
	cmp	r1, #0
	beq	.L4110
	ldr	r0, [r4, #3888]
	bl	ReleaseNAL
	mov	r3, #0
	mvn	r0, #0
	str	r3, [r6, #368]
	b	.L4108
.L3974:
	ubfx	r3, r0, #22, #1
	ubfx	r2, r0, #16, #6
	ubfx	ip, r7, #4, #1
	strb	r3, [r4, #1852]
	strb	r2, [r4, #1853]
	ubfx	r3, r0, #15, #1
	ubfx	r2, r7, #8, #4
	ubfx	r0, r0, #12, #3
	strb	ip, [r4, #1858]
	ubfx	ip, r7, #2, #1
	strb	r0, [r4, #1855]
	ubfx	r0, r7, #5, #3
	strb	r3, [r4, #1854]
	strb	r0, [r4, #1857]
	ubfx	r0, r7, #3, #1
	strb	r2, [r4, #1856]
	strb	r0, [r4, #1859]
	and	r0, r7, #3
	strb	ip, [r4, #1860]
	strb	r0, [r4, #1861]
	b	.L3975
.L4132:
	ldr	r1, .L4137+68
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r6
	bl	ClearCurrSlice
	ldr	r3, .L4137+12
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L4110
.L4111:
	mov	r3, #0
	ldr	r0, [r4, #3888]
	mov	r2, r3
	mov	r1, #113
	blx	ip
	mvn	r0, #0
	b	.L4108
.L4134:
	ldr	r5, .L4137+12
	mov	r0, #1
	ldr	r1, .L4137+72
	bl	dprint_vfmw
	ldr	ip, [r5]
	cmp	ip, #0
	beq	.L4110
.L4127:
	sub	r2, fp, #36
	mvn	r6, #0
	mov	r3, #4
	mov	r1, #100
	str	r6, [r2, #-4]!
	ldr	r0, [r4, #3888]
	blx	ip
	ldr	ip, [r5]
	cmp	ip, #0
	bne	.L4111
	b	.L4110
.L4133:
	ldr	r1, .L4137+76
	mov	r0, #1
	bl	dprint_vfmw
	ldr	r3, .L4137+12
	ldr	ip, [r3]
	cmp	ip, #0
	bne	.L4114
	b	.L4115
.L4136:
	ldr	r5, .L4137+12
	mov	r0, #1
	ldr	r1, .L4137+80
	bl	dprint_vfmw
	ldr	ip, [r5]
	cmp	ip, #0
	bne	.L4127
	b	.L4110
.L4011:
	ldr	r1, [r6, #368]
	cmp	r1, #0
	bne	.L4013
	b	.L4115
.L3977:
	ldrb	r3, [r4, #1852]
	mov	r0, #22
	cmp	r3, #1
	moveq	r3, #5
	streqb	r3, [r1, #2]
	ldrb	ip, [r4, #1857]
	ldreqb	r2, [r4, #1856]
	ldrb	r3, [r4, #1855]
	ldr	r1, .L4137+84
	str	ip, [sp]
	bl	dprint_vfmw
	mov	r2, r7
	ldr	r1, .L4137+88
	mov	r0, #22
	bl	dprint_vfmw
	ldr	r2, [r6, #368]
	ldr	r3, [r2, #64]
	add	r3, r3, #24
	str	r3, [r2, #64]
	ldr	r3, [r6, #368]
	ldrb	r2, [r3, #2]
	b	.L3973
.L4135:
	ldr	r5, .L4137+12
	add	r3, r6, #12288
	strb	r0, [r3, #1272]
	ldr	ip, [r5]
	cmp	ip, #0
	beq	.L4007
	mov	r3, #0
	mov	r1, #117
	mov	r2, r3
	ldr	r0, [r4, #3888]
	blx	ip
.L4007:
	mov	r7, #0
	mov	r0, r6
	str	r7, [r6, #364]
	bl	DecVDM
	cmp	r0, r7
	beq	.L4117
	b	.L4124
.L3996:
	ldrb	r3, [r5, #216]
	cmp	r3, #1
	bne	.L4115
	ldr	r5, .L4137+12
	ldr	ip, [r5]
	cmp	ip, #0
	beq	.L3998
	mov	r3, r0
	mov	r2, r0
	mov	r1, #112
	ldr	r0, [r4, #3888]
	blx	ip
.L3998:
	mov	r7, #0
	mov	r0, r6
	str	r7, [r6, #364]
	bl	DecVDM
	cmp	r0, #0
	bne	.L4124
	add	r6, r6, #12288
	mov	r3, #1
	strb	r3, [r6, #1273]
	b	.L4108
.L4138:
	.align	2
.L4137:
	.word	s_pstVfmwChan
	.word	.LC410
	.word	.LC428
	.word	g_event_report
	.word	.LC415
	.word	.LC420
	.word	.LC418
	.word	.LC425
	.word	.LC424
	.word	.LC426
	.word	.LC427
	.word	.LC422
	.word	.LC423
	.word	.LC417
	.word	.LC429
	.word	.LC411
	.word	.LC412
	.word	.LC416
	.word	.LC419
	.word	.LC421
	.word	.LC176
	.word	.LC413
	.word	.LC414
	.fnend
	.size	H264_DecOneNal, .-H264_DecOneNal
	.align	2
	.global	H264DEC_DecodePacket
	.type	H264DEC_DecodePacket, %function
H264DEC_DecodePacket:
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
	cmp	r1, #0
	mov	ip, #0
	mov	r5, r0
	str	ip, [fp, #-48]
	str	ip, [fp, #-52]
	str	ip, [fp, #-56]
	beq	.L4199
	ldr	r2, [r0]
	add	r4, r0, #57344
	ldr	lr, [r4, #2488]
	ldr	r3, [r2, #8]
	cmp	lr, #1
	mov	r3, r3, asl #16
	and	r3, r3, #458752
	str	r3, [r4, #3876]
	ldr	r3, [r2]
	str	r3, [r4, #3880]
	ldr	r3, [r2, #4]
	str	ip, [r4, #3828]
	str	r3, [r4, #3884]
	beq	.L4142
	ldr	r3, [r2, #824]
	cmp	r3, #1
	beq	.L4200
.L4143:
	mov	r0, r5
	bl	ReceivePacket
	ldr	r3, [r5, #368]
	str	r3, [r4, #3924]
.L4145:
	cmp	r0, #0
	mov	r3, #0
	str	r3, [r4, #2488]
	beq	.L4146
.L4165:
	mov	r0, #0
.L4196:
	sub	sp, fp, #32
	ldmfd	sp, {r4, r5, r6, r7, r8, fp, sp, pc}
.L4200:
	ldr	r3, [r2, #864]
	cmp	r3, #1
	bne	.L4143
	ldr	r3, [r4, #3920]
	cmp	r3, #1
	bne	.L4143
	ldr	r3, [r4, #3924]
	str	r3, [r0, #368]
	str	ip, [r4, #3920]
	str	ip, [r4, #2488]
	b	.L4144
.L4146:
	ldr	r3, [r5, #368]
.L4144:
	mov	r2, #0
	add	r6, r5, #13504
	str	r2, [r3, #64]
	add	r6, r6, #24
	ldr	r3, [r5, #368]
	mov	r0, r6
	ldr	r2, [r3, #12]
	ldr	r1, [r3, #8]
	bl	BsInit
	ldr	r3, .L4207
	ldr	r2, [r4, #3888]
	ldr	ip, [r3, r2, asl #2]
	ldrsb	r7, [ip, #160]
	cmp	r7, #1
	beq	.L4147
.L4149:
	mov	r7, #0
.L4148:
	mov	r1, #32
	mov	r0, r6
	bl	BsGet
	ldr	r2, [r5, #368]
	uxtb	r0, r0
	and	r3, r0, #31
	and	r1, r0, #27
	strb	r3, [r2, #2]
	sub	ip, r3, #20
	ldr	r2, [r5, #368]
	clz	ip, ip
	cmp	r3, #20
	cmpne	r1, #1
	ubfx	r0, r0, #5, #2
	mov	ip, ip, lsr #5
	str	r0, [r2, #76]
	beq	.L4201
.L4150:
	mov	r0, r5
	bl	FindTrailZeros
	subs	r3, r0, #0
	bne	.L4202
	ldr	r2, [r5, #368]
	mov	r0, r6
	str	r3, [r2, #64]
	ldr	r3, [r5, #368]
	ldr	r1, [r3, #8]
	ldr	r2, [r3, #12]
	bl	BsInit
	mov	r1, r7
	mov	r0, r5
	bl	H264_DecOneNal
	cmn	r0, #2
	beq	.L4196
	cmp	r0, #0
	beq	.L4165
	ldr	r1, .L4207+4
	mov	r0, #22
	bl	dprint_vfmw
.L4198:
	mvn	r0, #0
	b	.L4196
.L4142:
	ldr	r0, [r0, #368]
	clz	r0, r0
	mov	r0, r0, lsr #5
	rsb	r0, r0, #0
	b	.L4145
.L4201:
	cmp	ip, #0
	bne	.L4203
.L4151:
	sub	r2, fp, #40
	sub	r1, fp, #44
	mov	r0, r5
	bl	InquireSliceProperty
	cmp	r0, #0
	beq	.L4204
	ldr	r1, [r5, #368]
	cmp	r1, #0
	beq	.L4163
	ldr	r0, [r4, #3888]
	bl	ReleaseNAL
	mov	r3, #0
	str	r3, [r5, #368]
.L4163:
	ldr	r3, .L4207+8
	ldr	ip, [r3]
	cmp	ip, #0
	beq	.L4198
	mov	r3, #0
	ldr	r0, [r4, #3888]
	mov	r2, r3
	mov	r1, #113
	blx	ip
	mvn	r0, #0
	b	.L4196
.L4204:
	ldr	r2, [fp, #-44]
	ldr	r1, [r4, #3900]
	sub	r3, r2, #1
	clz	r3, r3
	mov	r3, r3, lsr #5
	cmp	r3, #0
	add	r3, r3, r1
	str	r3, [r4, #3900]
	bne	.L4205
	add	r3, r5, #12288
	ldrb	r2, [r3, #1273]
	cmp	r2, #1
	beq	.L4166
.L4156:
	ldr	r3, [fp, #-40]
	cmp	r3, #1
	bne	.L4150
	mov	r0, r5
	bl	FlushDPB
	subs	r3, r0, #0
	bne	.L4206
.L4162:
	ldr	r0, [r4, #3888]
	bl	FSP_GetFspType
	cmp	r0, #0
	bne	.L4150
	sub	r3, fp, #48
	sub	r2, fp, #52
	sub	r1, fp, #56
	ldr	r0, [r4, #3888]
	bl	VCTRL_GetChanImgNum
	ldr	r3, [r5]
	ldr	r3, [r3, #700]
	cmp	r3, #1
	bne	.L4150
	ldr	r3, [fp, #-52]
	ldr	r2, [fp, #-48]
	add	r3, r3, r2
	cmp	r3, #0
	ble	.L4150
.L4159:
	mov	r3, #1
	mvn	r0, #1
	str	r3, [r4, #2488]
	b	.L4196
.L4147:
	ldr	r3, [ip, #172]
	mov	r0, r5
	ldr	r2, [ip, #168]
	ldr	r1, [ip, #164]
	bl	H264_VES_Splitter
	cmp	r0, #3
	beq	.L4148
	cmp	r0, #0
	bne	.L4196
	b	.L4149
.L4203:
	mov	r0, r5
	bl	InquireSliceExtProperty
	b	.L4151
.L4166:
	mov	r2, #0
	strb	r2, [r3, #1273]
	b	.L4156
.L4205:
	add	r8, r5, #20480
	ldrb	r3, [r8, #209]
	cmp	r3, #1
	ldr	r3, [r4, #3904]
	addeq	r3, r3, #1
	addne	r3, r3, #2
	str	r3, [r4, #3904]
	add	r3, r5, #12288
	ldrb	r2, [r3, #1273]
	cmp	r2, #1
	beq	.L4166
	ldr	r3, [r4, #3812]
	cmp	r3, #0
	beq	.L4156
	ldr	r3, [r5, #368]
	mov	ip, #0
	mov	r0, r6
	mov	r2, #12
	ldr	r1, .L4207+12
	str	ip, [r3, #64]
	bl	BsInit
	mov	r0, r5
	mov	r1, #1
	bl	H264_DecOneNal
	ldrb	r3, [r8, #209]
	cmp	r3, #1
	ldr	r3, [r4, #3904]
	subeq	r3, r3, #1
	subne	r3, r3, #2
	str	r3, [r4, #3904]
	b	.L4159
.L4202:
	ldr	r1, .L4207+16
	mov	r0, #22
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4196
.L4206:
	movw	r2, #13528
	ldr	r1, .L4207+20
	mov	r0, #0
	bl	dprint_vfmw
	b	.L4162
.L4199:
	mov	r0, r1
	movw	r3, #13400
	ldr	r2, .L4207+24
	ldr	r1, .L4207+28
	bl	dprint_vfmw
	mvn	r0, #0
	b	.L4196
.L4208:
	.align	2
.L4207:
	.word	s_pstVfmwChan
	.word	.LC431
	.word	g_event_report
	.word	.LANCHOR0+432
	.word	.LC430
	.word	.LC354
	.word	.LC20
	.word	.LC21
	.fnend
	.size	H264DEC_DecodePacket, .-H264DEC_DecodePacket
	.align	2
	.global	H264DEC_VDMPostProc
	.type	H264DEC_VDMPostProc, %function
H264DEC_VDMPostProc:
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
	ldr	r5, [r0, #364]
	mov	r4, r0
	mov	r7, r3
	cmp	r5, #0
	bne	.L4210
	add	r6, r0, #57344
	str	r1, [r6, #1108]
	bl	ClearAllSlice
	mov	r1, r7
	mov	r0, r4
	bl	StorePicInDPB
	cmp	r0, #1
	mov	r7, r0
	bls	.L4211
	ldr	r3, [r6, #1064]
	mov	r2, #1
	ldr	r0, [r6, #3888]
	ldr	r1, [r3, #600]
	bl	FSP_ClearLogicFs
	mov	r2, r7
	ldr	r1, .L4223
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	bl	H264_ClearCurrPic
	mov	r0, r4
	bl	ClearDPB
	str	r5, [r6, #1064]
	mvn	r5, #0
	mov	r0, r5
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L4210:
	add	r5, r0, #57344
	str	r1, [r5, #1108]
	bl	ClearAllSlice
	mov	r1, r7
	mov	r0, r4
	bl	StorePicInDPB
	subs	r2, r0, #0
	bne	.L4221
	mov	r0, r4
	bl	FlushDPB
	subs	r2, r0, #0
	bne	.L4222
.L4214:
	add	r2, r4, #12288
	mov	r3, #0
	str	r3, [r5, #2484]
	add	r4, r4, #20480
	ldr	r1, [r2, #1292]
	mov	r5, r3
	movw	r2, #23352
	strb	r3, [r4, #1856]
	str	r3, [r4, #1888]
	movt	r2, 1
	str	r1, [r4, #1864]
	mov	r0, #7
	mov	r1, #2
	str	r3, [r4, #1892]
	str	r2, [r4, #1872]
	mov	r3, #32
	strb	r1, [r4, #1857]
	mvn	r2, #0
	mov	r1, #3
	str	r0, [r4, #1868]
	strb	r3, [r4, #1858]
	mov	r0, r5
	mov	r3, #262144
	str	r1, [r4, #1880]
	str	r2, [r4, #1884]
	str	r3, [r4, #1896]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L4211:
	mov	r3, #1
	mov	r0, r5
	str	r3, [r6, #2484]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L4221:
	ldr	r1, .L4223+4
	mov	r0, #1
	bl	dprint_vfmw
	mov	r0, r4
	bl	FlushDPB
	subs	r2, r0, #0
	beq	.L4214
.L4222:
	ldr	r1, .L4223+8
	mov	r0, #1
	bl	dprint_vfmw
	b	.L4214
.L4224:
	.align	2
.L4223:
	.word	.LC432
	.word	.LC433
	.word	.LC434
	.fnend
	.size	H264DEC_VDMPostProc, .-H264DEC_VDMPostProc
	.align	2
	.global	H264DEC_GetImageBuffer
	.type	H264DEC_GetImageBuffer, %function
H264DEC_GetImageBuffer:
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
	add	r4, r0, #57344
	mov	r5, r0
	ldr	r7, [r4, #2476]
	cmp	r7, #0
	beq	.L4241
	add	r6, r0, #27392
	add	r9, r0, #26368
	add	r6, r6, #8
	add	r9, r9, #160
	add	r8, r0, #24576
	mov	lr, #0
	mov	r1, r6
.L4233:
	ldrb	r3, [r1, #1]
	cmp	r3, #0
	bne	.L4228
	cmp	r1, #0
	beq	.L4229
	ldr	r0, [r8, #2148]
	cmp	r0, #0
	beq	.L4229
	ldr	r2, [r8, #1952]
	cmp	r2, r1
	beq	.L4228
	mov	r2, r9
	b	.L4230
.L4231:
	ldr	ip, [r2, #4]!
	cmp	ip, r1
	beq	.L4228
.L4230:
	add	r3, r3, #1
	cmp	r3, r0
	bne	.L4231
.L4229:
	ldr	r0, [r4, #3888]
	bl	FSP_IsNewFsAvalible
	cmp	r0, #1
	beq	.L4241
	cmn	r0, #1
	bne	.L4261
	add	r1, r5, #8
	ldr	r0, [r4, #3888]
	bl	FSP_ClearNotInVoQueue
	b	.L4261
.L4228:
	add	lr, lr, #1
	add	r1, r1, #760
	cmp	lr, r7
	bne	.L4233
	sub	r2, fp, #40
	sub	r1, fp, #44
	add	r0, r5, #8
	bl	GetQueueImgNum
	ldr	r1, .L4265
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r1, .L4265+4
	mov	r0, #0
	bl	dprint_vfmw
	ldr	r3, [r4, #2476]
	cmp	r3, #0
	addne	r8, r5, #26368
	addne	r9, r5, #24576
	addne	r8, r8, #160
	movne	r7, #0
	beq	.L4263
.L4234:
	cmp	r6, #0
	ldrb	r3, [r6, #1]
	ldrb	lr, [r6, #4]
	beq	.L4245
	ldr	r0, [r9, #2148]
	cmp	r0, #0
	beq	.L4245
	ldr	r2, [r9, #1952]
	cmp	r6, r2
	beq	.L4247
	mov	r1, r8
	mov	ip, #0
	b	.L4238
.L4239:
	ldr	r2, [r1, #4]!
	cmp	r6, r2
	beq	.L4247
.L4238:
	add	ip, ip, #1
	cmp	ip, r0
	bne	.L4239
.L4245:
	mov	r2, #1
.L4237:
	str	r2, [sp, #4]
	mov	r0, #0
	mov	r2, r7
	str	lr, [sp]
	ldr	r1, .L4265+8
	add	r7, r7, #1
	bl	dprint_vfmw
	ldr	r3, [r4, #2476]
	add	r6, r6, #760
	cmp	r3, r7
	bhi	.L4234
.L4240:
	ldr	r3, [fp, #-40]
	mov	r0, #0
	ldr	r2, [fp, #-44]
	ldr	r1, .L4265+12
	bl	dprint_vfmw
	ldr	r3, [r4, #2476]
	ldr	r0, [r9, #2148]
	ldr	r2, [fp, #-44]
	sub	r3, r3, #2
	ldr	r1, [fp, #-40]
	rsb	r3, r0, r3
	add	r2, r2, r1
	cmp	r2, r3
	blt	.L4264
.L4261:
	mov	r0, #0
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L4241:
	mov	r0, #1
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L4247:
	mov	r2, #0
	b	.L4237
.L4264:
	ldr	r1, .L4265+16
	mov	r0, #0
	bl	dprint_vfmw
	mov	r0, r5
	mov	r1, #1
	bl	ClearAll
	mov	r0, #0
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L4263:
	add	r9, r5, #24576
	b	.L4240
.L4266:
	.align	2
.L4265:
	.word	.LC435
	.word	.LC436
	.word	.LC438
	.word	.LC437
	.word	.LC439
	.fnend
	.size	H264DEC_GetImageBuffer, .-H264DEC_GetImageBuffer
	.align	2
	.global	H264DEC_GetImageWidth
	.type	H264DEC_GetImageWidth, %function
H264DEC_GetImageWidth:
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
	add	r0, r0, #16384
	ldr	r0, [r0, #460]
	add	r0, r0, #1
	mov	r0, r0, asl #4
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	H264DEC_GetImageWidth, .-H264DEC_GetImageWidth
	.align	2
	.global	H264DEC_GetImageHeight
	.type	H264DEC_GetImageHeight, %function
H264DEC_GetImageHeight:
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
	add	r3, r0, #16384
	add	r0, r0, #12288
	ldr	r3, [r3, #464]
	ldrb	r0, [r0, #1326]
	add	r3, r3, #1
	rsb	r0, r0, #2
	mov	r3, r3, asl #4
	mul	r0, r0, r3
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	H264DEC_GetImageHeight, .-H264DEC_GetImageHeight
	.global	TmpBuf
	.global	g_CabacMN
	.global	quant8_org
	.global	quant_org
	.global	quant8_inter_default
	.global	quant8_intra_default
	.global	quant_inter_default
	.global	quant_intra_default
	.global	g_ZZ_SCAN8
	.global	g_ZZ_SCAN
	.global	CalcZeroNum
	.global	g_AspecRatioIdc
	.global	g_NalTypeEOPIC
	.section	.rodata
	.align	2
.LANCHOR1 = . + 0
	.type	g_ZZ_SCAN, %object
	.size	g_ZZ_SCAN, 16
g_ZZ_SCAN:
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
	.type	g_ZZ_SCAN8, %object
	.size	g_ZZ_SCAN8, 64
g_ZZ_SCAN8:
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
	.type	SarTable.15983, %object
	.size	SarTable.15983, 136
SarTable.15983:
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
	.type	__func__.16164, %object
	.size	__func__.16164, 12
__func__.16164:
	.ascii	"H264_DecSEI\000"
	.type	__func__.15024, %object
	.size	__func__.15024, 13
__func__.15024:
	.ascii	"DirectOutput\000"
	.space	3
	.type	__func__.15489, %object
	.size	__func__.15489, 8
__func__.15489:
	.ascii	"InitDPB\000"
	.type	__func__.16430, %object
	.size	__func__.16430, 18
__func__.16430:
	.ascii	"H264_VES_Splitter\000"
	.space	2
	.type	__func__.15142, %object
	.size	__func__.15142, 14
__func__.15142:
	.ascii	"StorePicInDPB\000"
	.space	2
	.type	__FUNCTION__.16401, %object
	.size	__FUNCTION__.16401, 13
__FUNCTION__.16401:
	.ascii	"H264DEC_Init\000"
	.space	3
	.type	__FUNCTION__.15623, %object
	.size	__FUNCTION__.15623, 8
__FUNCTION__.15623:
	.ascii	"InitPic\000"
	.data
	.align	2
.LANCHOR0 = . + 0
	.type	quant_org, %object
	.size	quant_org, 16
quant_org:
	.word	269488144
	.word	269488144
	.word	269488144
	.word	269488144
	.type	quant8_org, %object
	.size	quant8_org, 64
quant8_org:
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
	.type	quant_intra_default, %object
	.size	quant_intra_default, 16
quant_intra_default:
	.word	471076102
	.word	538711053
	.word	622861332
	.word	707076124
	.type	quant_inter_default, %object
	.size	quant_inter_default, 16
quant_inter_default:
	.word	403967498
	.word	454562830
	.word	505092116
	.word	572398360
	.type	quant8_intra_default, %object
	.size	quant8_intra_default, 64
quant8_intra_default:
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
	.type	quant8_inter_default, %object
	.size	quant8_inter_default, 256
quant8_inter_default:
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
	.type	g_NalTypeEOPIC, %object
	.size	g_NalTypeEOPIC, 12
g_NalTypeEOPIC:
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
	.type	g_CabacMN, %object
	.size	g_CabacMN, 5120
g_CabacMN:
	.word	388044546
	.word	352326208
	.word	153820416
	.word	721207
	.word	4522025
	.word	4128831
	.word	4128768
	.word	0
	.word	351339062
	.word	55239807
	.word	-378996171
	.word	-13236429
	.word	521477919
	.word	422707200
	.word	0
	.word	0
	.word	87683918
	.word	-180289218
	.word	17367089
	.word	-613020375
	.word	54458195
	.word	72745057
	.word	-112721920
	.word	0
	.word	21230414
	.word	-180289218
	.word	440602714
	.word	157864575
	.word	-328728576
	.word	0
	.word	0
	.word	0
	.word	204602441
	.word	288553558
	.word	-278922691
	.word	154007875
	.word	-78971830
	.word	-78579384
	.word	20578304
	.word	0
	.word	-45745583
	.word	-178256329
	.word	121895766
	.word	39321658
	.word	-45287842
	.word	87426117
	.word	-45023144
	.word	0
	.word	370745856
	.word	268442146
	.word	320219136
	.word	721207
	.word	4522025
	.word	4128831
	.word	4128768
	.word	0
	.word	351339062
	.word	55239807
	.word	-378996171
	.word	-13236429
	.word	521477919
	.word	422707200
	.word	0
	.word	0
	.word	37878343
	.word	-212925132
	.word	-32963543
	.word	-478802647
	.word	54458195
	.word	72745057
	.word	-112721920
	.word	0
	.word	-62064057
	.word	-212925132
	.word	956442916
	.word	440783743
	.word	-245039104
	.word	0
	.word	0
	.word	0
	.word	154336582
	.word	171312709
	.word	-212205516
	.word	137101122
	.word	-11730618
	.word	-27854008
	.word	3997696
	.word	0
	.word	-28968110
	.word	-161480133
	.word	38534487
	.word	-43777736
	.word	-45417899
	.word	3931473
	.word	-111740065
	.word	0
	.word	487594240
	.word	234886184
	.word	336207104
	.word	721207
	.word	4522025
	.word	4128831
	.word	4128768
	.word	0
	.word	351339062
	.word	55239807
	.word	-378996171
	.word	-13236429
	.word	521477919
	.word	422707200
	.word	0
	.word	0
	.word	437320789
	.word	-395967175
	.word	-164364994
	.word	-446493399
	.word	54458195
	.word	72745057
	.word	-112721920
	.word	0
	.word	-28640171
	.word	-395967175
	.word	905979178
	.word	207741055
	.word	-361431040
	.word	0
	.word	0
	.word	0
	.word	104460105
	.word	238680669
	.word	-229049812
	.word	70714167
	.word	-61866421
	.word	-194905806
	.word	20709376
	.word	0
	.word	-178654873
	.word	-344714439
	.word	339346516
	.word	106955071
	.word	-78253206
	.word	88016459
	.word	-44368027
	.word	0
	.word	388044546
	.word	352326208
	.word	153820416
	.word	3013710
	.word	-44040151
	.word	4128831
	.word	4128768
	.word	0
	.word	351339062
	.word	55239807
	.word	-378996171
	.word	-13236429
	.word	203950899
	.word	238747648
	.word	0
	.word	0
	.word	87683918
	.word	-180289218
	.word	17367089
	.word	-613020375
	.word	54458195
	.word	72745057
	.word	-112721920
	.word	0
	.word	21230414
	.word	-180289218
	.word	440602714
	.word	157864575
	.word	-328728576
	.word	0
	.word	0
	.word	0
	.word	204602441
	.word	288553558
	.word	-278922691
	.word	154007875
	.word	-78971830
	.word	-78579384
	.word	20578304
	.word	0
	.word	-45745583
	.word	-178256329
	.word	121895766
	.word	39321658
	.word	-45287842
	.word	87426117
	.word	-45023144
	.word	0
	.word	370745856
	.word	268442146
	.word	320219136
	.word	219088691
	.word	38797353
	.word	4128831
	.word	4128768
	.word	0
	.word	351339062
	.word	55239807
	.word	-378996171
	.word	-13236429
	.word	421532977
	.word	355860480
	.word	0
	.word	0
	.word	37878343
	.word	-212925132
	.word	-32963543
	.word	-478802647
	.word	54458195
	.word	72745057
	.word	-112721920
	.word	0
	.word	-62064057
	.word	-212925132
	.word	956442916
	.word	440783743
	.word	-245039104
	.word	0
	.word	0
	.word	0
	.word	154336582
	.word	171312709
	.word	-212205516
	.word	137101122
	.word	-11730618
	.word	-27854008
	.word	3997696
	.word	0
	.word	-28968110
	.word	-161480133
	.word	38534487
	.word	-43777736
	.word	-45417899
	.word	3931473
	.word	-111740065
	.word	0
	.word	487594240
	.word	234886184
	.word	336207104
	.word	119732056
	.word	-327221207
	.word	4128831
	.word	4128768
	.word	0
	.word	351339062
	.word	55239807
	.word	-378996171
	.word	-13236429
	.word	354489138
	.word	289210368
	.word	0
	.word	0
	.word	437320789
	.word	-395967175
	.word	-164364994
	.word	-446493399
	.word	54458195
	.word	72745057
	.word	-112721920
	.word	0
	.word	-28640171
	.word	-395967175
	.word	905979178
	.word	207741055
	.word	-361431040
	.word	0
	.word	0
	.word	0
	.word	104460105
	.word	238680669
	.word	-229049812
	.word	70714167
	.word	-61866421
	.word	-194905806
	.word	20709376
	.word	0
	.word	-178654873
	.word	-344714439
	.word	339346516
	.word	106955071
	.word	-78253206
	.word	88016459
	.word	-44368027
	.word	0
	.word	-276827290
	.word	5437770
	.word	-345250433
	.word	-511711105
	.word	-295705217
	.word	-344792449
	.word	0
	.word	0
	.word	-277089165
	.word	-260377229
	.word	-45614550
	.word	-80544458
	.word	-29491142
	.word	20971080
	.word	-11864229
	.word	0
	.word	-111282857
	.word	-45221049
	.word	-62915516
	.word	-195757762
	.word	-113178563
	.word	87621186
	.word	20971581
	.word	-28442624
	.word	402657033
	.word	135859474
	.word	252251411
	.word	170200082
	.word	102568993
	.word	253625389
	.word	20578366
	.word	121438208
	.word	-94504364
	.word	-129040318
	.word	-12124098
	.word	-29557189
	.word	-78906050
	.word	-63244478
	.word	-11599801
	.word	54788096
	.word	252053011
	.word	118492174
	.word	302845195
	.word	219090704
	.word	202837271
	.word	252972570
	.word	237769000
	.word	288292864
	.word	-197132732
	.word	-246090904
	.word	-79430885
	.word	-47710676
	.word	3076160
	.word	-129698226
	.word	-95553962
	.word	0
	.word	20055860
	.word	170065964
	.word	187040045
	.word	3015980
	.word	521208115
	.word	120724499
	.word	270601790
	.word	0
	.word	203819821
	.word	254217002
	.word	220991533
	.word	204016177
	.word	505549354
	.word	171381043
	.word	288227417
	.word	0
	.word	170719550
	.word	254021160
	.word	270208029
	.word	19665956
	.word	304088362
	.word	19925566
	.word	288229696
	.word	0
	.word	403772693
	.word	420880155
	.word	371004195
	.word	238160441
	.word	121634381
	.word	-61670050
	.word	155579501
	.word	0
	.word	-45680547
	.word	-161815937
	.word	-195235529
	.word	-163775938
	.word	-62786487
	.word	-129173168
	.word	-145166482
	.word	0
	.word	-210964124
	.word	-211422373
	.word	-195103144
	.word	-262867370
	.word	-111938729
	.word	-312606394
	.word	4782922
	.word	305856512
	.word	451745519
	.word	451878631
	.word	485237225
	.word	635773417
	.word	686040815
	.word	569714929
	.word	704259585
	.word	688979968
	.word	-194448031
	.word	-262080168
	.word	-128583339
	.word	-145362088
	.word	71499085
	.word	-45286836
	.word	171638604
	.word	-11337728
	.word	618472670
	.word	551953890
	.word	752886510
	.word	586230001
	.word	569975803
	.word	553657858
	.word	554506019
	.word	221904896
	.word	-11863455
	.word	-111416193
	.word	-178131884
	.word	-179307959
	.word	-62196906
	.word	-211749535
	.word	-311099392
	.word	0
	.word	-127471260
	.word	6225920
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	519707395
	.word	437649408
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	-110890401
	.word	39780352
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	503126528
	.word	371064832
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	-63374510
	.word	-112399747
	.word	-129041631
	.word	-63898059
	.word	-46206137
	.word	-162532266
	.word	-212143519
	.word	0
	.word	-62193080
	.word	-179569337
	.word	254735173
	.word	4063297
	.word	354808136
	.word	154734646
	.word	4066376
	.word	0
	.word	636494844
	.word	653797117
	.word	620963333
	.word	704652048
	.word	655756848
	.word	455415100
	.word	205783649
	.word	0
	.word	5045066
	.word	4650315
	.word	21233729
	.word	-230096066
	.word	71237444
	.word	-213185737
	.word	88083526
	.word	0
	.word	536421361
	.word	587014659
	.word	620700165
	.word	537600773
	.word	571221771
	.word	505225754
	.word	489100098
	.word	0
	.word	0
	.word	0
	.word	-45351145
	.word	19005739
	.word	3604023
	.word	3998016
	.word	4519772
	.word	0
	.word	-277287824
	.word	-294455979
	.word	-245566887
	.word	-431492783
	.word	-229638076
	.word	-230234056
	.word	-381360078
	.word	-179699712
	.word	401808115
	.word	686895602
	.word	738405638
	.word	740434230
	.word	324141056
	.word	0
	.word	0
	.word	0
	.word	-227871903
	.word	-245697446
	.word	-296159671
	.word	-145755562
	.word	-162924986
	.word	-163185854
	.word	-146736326
	.word	37421056
	.word	368449781
	.word	486022399
	.word	486743305
	.word	588520740
	.word	239271936
	.word	0
	.word	0
	.word	0
	.word	-444668830
	.word	-412751549
	.word	-464327586
	.word	-262935954
	.word	-346296730
	.word	-211950721
	.word	0
	.word	0
	.word	-111346855
	.word	-111086740
	.word	-95617492
	.word	2949172
	.word	-46072261
	.word	-62456757
	.word	-128782490
	.word	0
	.word	-27919794
	.word	-11798195
	.word	37094706
	.word	-45874894
	.word	103480401
	.word	20970566
	.word	4391481
	.word	-28573696
	.word	186384936
	.word	53215281
	.word	3015212
	.word	36896815
	.word	69665342
	.word	103678006
	.word	53871162
	.word	71237632
	.word	-211095446
	.word	-162010254
	.word	-294718878
	.word	-361829526
	.word	-295179413
	.word	-378739088
	.word	-161418145
	.word	-77922304
	.word	235604750
	.word	151720459
	.word	352917502
	.word	552673521
	.word	585836521
	.word	719268321
	.word	786704116
	.word	354222080
	.word	-47251647
	.word	-12978339
	.word	-145947880
	.word	2752560
	.word	3668539
	.word	-112724909
	.word	-178789769
	.word	0
	.word	186844224
	.word	20777763
	.word	303631384
	.word	220007716
	.word	-161613495
	.word	-28766930
	.word	154270052
	.word	0
	.word	104007225
	.word	120915508
	.word	104270637
	.word	237242421
	.word	-11401417
	.word	-45215954
	.word	371195732
	.word	0
	.word	-144840098
	.word	-78247613
	.word	-61802923
	.word	-12187844
	.word	154797373
	.word	204607282
	.word	305205558
	.word	0
	.word	770192851
	.word	820396501
	.word	736962550
	.word	503910938
	.word	337313849
	.word	-229442741
	.word	-312353411
	.word	0
	.word	-45418660
	.word	-128456322
	.word	20643101
	.word	-14417626
	.word	36436535
	.word	3801152
	.word	-45418918
	.word	0
	.word	154468917
	.word	87424573
	.word	3670072
	.word	-213910724
	.word	-12712903
	.word	-96140231
	.word	237438003
	.word	222560256
	.word	419897081
	.word	469965828
	.word	536879871
	.word	503717382
	.word	537468691
	.word	437983774
	.word	622074914
	.word	289800192
	.word	170460974
	.word	-13433039
	.word	137627945
	.word	103744055
	.word	220793388
	.word	103941429
	.word	221316159
	.word	104857600
	.word	452992000
	.word	536615686
	.word	570957322
	.word	404103443
	.word	371202591
	.word	355015212
	.word	388960321
	.word	239534080
	.word	87426620
	.word	104531525
	.word	4652061
	.word	85919530
	.word	20708922
	.word	-45548207
	.word	-178192384
	.word	0
	.word	54526269
	.word	155123712
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	21169467
	.word	155385856
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	-28967365
	.word	105250816
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	138151487
	.word	289472512
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	-13631420
	.word	-62523304
	.word	3803141
	.word	168693266
	.word	219873832
	.word	3865926
	.word	-95422379
	.word	0
	.word	120721447
	.word	86770740
	.word	187759420
	.word	-12910533
	.word	371262764
	.word	237764430
	.word	3934533
	.word	0
	.word	270406176
	.word	304289309
	.word	404690726
	.word	304813097
	.word	188680507
	.word	155254622
	.word	-27658388
	.word	0
	.word	170658079
	.word	204145461
	.word	237111846
	.word	-46920408
	.word	287311660
	.word	119934258
	.word	171514411
	.word	0
	.word	353900308
	.word	437721888
	.word	471276568
	.word	388503584
	.word	471668522
	.word	322508341
	.word	373099350
	.word	0
	.word	0
	.word	0
	.word	-96274141
	.word	-114624467
	.word	-80677832
	.word	-96666818
	.word	-129828788
	.word	0
	.word	-61867705
	.word	-79300794
	.word	-129829308
	.word	-313920443
	.word	-263786173
	.word	-331420346
	.word	-264050111
	.word	-331415552
	.word	167647991
	.word	569845753
	.word	704523523
	.word	822684955
	.word	607846400
	.word	0
	.word	0
	.word	0
	.word	-78251439
	.word	-162662063
	.word	-279908791
	.word	-62196141
	.word	-146278589
	.word	-12715966
	.word	-230555589
	.word	37421056
	.word	368255474
	.word	670641918
	.word	855784454
	.word	1024538402
	.word	708706304
	.word	0
	.word	0
	.word	0
	.word	-645927333
	.word	-278862255
	.word	-580720538
	.word	-379460233
	.word	-396104850
	.word	-295248769
	.word	0
	.word	0
	.word	5307225
	.word	-111215524
	.word	-378474169
	.word	-113442763
	.word	-79497907
	.word	-145688748
	.word	-162013569
	.word	0
	.word	-211291301
	.word	-145100196
	.word	-129174441
	.word	-378607511
	.word	-162599824
	.word	-278678913
	.word	-1166029185
	.word	-763428864
	.word	70060572
	.word	169812469
	.word	886379023
	.word	469771242
	.word	652681728
	.word	669917428
	.word	1721892864
	.word	955318272
	.word	-344004228
	.word	-328276354
	.word	-411242647
	.word	-444996235
	.word	-278469003
	.word	-445325446
	.word	-161484188
	.word	-127991808
	.word	335155962
	.word	234887924
	.word	535831015
	.word	568993252
	.word	669133538
	.word	802565596
	.word	836643311
	.word	537460736
	.word	2555969
	.word	-246096513
	.word	-345637593
	.word	-80348867
	.word	-179572403
	.word	-279189653
	.word	-412097414
	.word	0
	.word	-62719154
	.word	-62392248
	.word	37486391
	.word	-112788917
	.word	-128328073
	.word	-45408236
	.word	504812671
	.word	0
	.word	570170634
	.word	637219811
	.word	670512350
	.word	1170621377
	.word	754655239
	.word	937631745
	.word	6948
	.word	0
	.word	-277879694
	.word	-94765488
	.word	-61671595
	.word	-128843960
	.word	88080707
	.word	154665029
	.word	21301061
	.word	0
	.word	1169768385
	.word	1119899062
	.word	920204509
	.word	703996928
	.word	687808014
	.word	471471909
	.word	204933953
	.word	0
	.word	-28707736
	.word	-144973441
	.word	-179505620
	.word	-164301255
	.word	-147132344
	.word	-112853947
	.word	-78973098
	.word	0
	.word	3603261
	.word	3866428
	.word	-46270397
	.word	-413863350
	.word	-79624908
	.word	37290045
	.word	-146410170
	.word	305594368
	.word	568795874
	.word	618931940
	.word	652550894
	.word	602940146
	.word	553133562
	.word	587210250
	.word	470948377
	.word	489226240
	.word	-112854461
	.word	-263324096
	.word	37616195
	.word	-46136775
	.word	-46006974
	.word	4065587
	.word	-12386745
	.word	-28639232
	.word	635381724
	.word	685450978
	.word	786377442
	.word	686305763
	.word	653535478
	.word	654126843
	.word	521411870
	.word	422313984
	.word	53937976
	.word	121047101
	.word	37943074
	.word	18877215
	.word	87359031
	.word	-29163447
	.word	-128385024
	.word	0
	.word	-62455750
	.word	121438208
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	4915784
	.word	139264000
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	-12126392
	.word	238813184
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	204475185
	.word	439156736
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	-46858172
	.word	-112527528
	.word	53741316
	.word	168300808
	.word	269681445
	.word	-12715191
	.word	-12125106
	.word	0
	.word	153686553
	.word	153093419
	.word	154075180
	.word	3342894
	.word	321322050
	.word	254151722
	.word	153223257
	.word	0
	.word	237179423
	.word	287511838
	.word	288166954
	.word	304945946
	.word	271976258
	.word	272108361
	.word	172226164
	.word	0
	.word	270860335
	.word	304286501
	.word	204016169
	.word	36703273
	.word	220790843
	.word	53613352
	.word	54661682
	.word	0
	.word	370546454
	.word	454369556
	.word	438050328
	.word	455217706
	.word	421990962
	.word	205919542
	.word	239536979
	.word	0
	.word	0
	.word	0
	.word	-79233000
	.word	-14352854
	.word	-30083271
	.word	-96469951
	.word	-62654126
	.word	0
	.word	-78251439
	.word	-162662063
	.word	-279908791
	.word	-62196141
	.word	-146278589
	.word	-12715966
	.word	-230555589
	.word	37421056
	.word	301342963
	.word	720843259
	.word	889208835
	.word	1141522971
	.word	792264704
	.word	0
	.word	0
	.word	0
	.word	-44958388
	.word	-112657842
	.word	-196545980
	.word	-45680052
	.word	-79496386
	.word	3800125
	.word	-147062474
	.word	37355520
	.word	301342963
	.word	720843259
	.word	889208835
	.word	1141522971
	.word	792264704
	.word	0
	.word	0
	.word	0
	.word	-595595429
	.word	-228595884
	.word	-413731751
	.word	-279191169
	.word	-229839257
	.word	-212149377
	.word	0
	.word	0
	.word	189793612
	.word	39060814
	.word	-395056558
	.word	-146931659
	.word	3928661
	.word	-212208802
	.word	-178461825
	.word	0
	.word	-61410216
	.word	-78447288
	.word	-62654392
	.word	-262539451
	.word	-12909246
	.word	70908999
	.word	-28900806
	.word	-11927552
	.word	69664810
	.word	119671581
	.word	136250917
	.word	120193832
	.word	136383787
	.word	220464175
	.word	53936698
	.word	104595456
	.word	-360716417
	.word	-411507329
	.word	-311236235
	.word	-411638155
	.word	-395189130
	.word	-512173188
	.word	-161549978
	.word	-161284096
	.word	301142263
	.word	301210603
	.word	635578840
	.word	718745809
	.word	669003480
	.word	885862103
	.word	886647789
	.word	537591808
	.word	-97057731
	.word	-229385345
	.word	-345705927
	.word	-196872889
	.word	-162665643
	.word	-262608536
	.word	-245179521
	.word	0
	.word	-64159931
	.word	4127027
	.word	-63964630
	.word	-47580619
	.word	139261774
	.word	-179107532
	.word	4455258
	.word	0
	.word	137104172
	.word	237635376
	.word	70779956
	.word	220530993
	.word	322570800
	.word	204275781
	.word	337709119
	.word	0
	.word	-211104129
	.word	-77852359
	.word	-78187682
	.word	-195297715
	.word	4718409
	.word	71366993
	.word	88084281
	.word	0
	.word	1036597458
	.word	1053708733
	.word	770450430
	.word	470753793
	.word	654384657
	.word	338039341
	.word	255197263
	.word	0
	.word	-78645912
	.word	-178527617
	.word	-162334672
	.word	-130156478
	.word	-112790965
	.word	-162531501
	.word	-195236244
	.word	0
	.word	21229896
	.word	-78907312
	.word	-346821824
	.word	-216012992
	.word	-480376501
	.word	289405002
	.word	-81527269
	.word	224067584
	.word	602808807
	.word	486348810
	.word	452993778
	.word	886319080
	.word	319889177
	.word	605886497
	.word	571416084
	.word	373882880
	.word	21168196
	.word	-163380924
	.word	5046848
	.word	4520782
	.word	121046331
	.word	37817910
	.word	254543164
	.word	38141952
	.word	619718130
	.word	636428289
	.word	571415823
	.word	404300310
	.word	521151250
	.word	521937193
	.word	605821743
	.word	356384768
	.word	4324943
	.word	4783196
	.word	-61871547
	.word	-263455174
	.word	20640590
	.word	-145490863
	.word	-211615744
	.word	0
	.word	54655301
	.word	139264000
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	337777439
	.word	455868416
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	-28512682
	.word	205914112
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	304026394
	.word	605552640
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	-96992444
	.word	-129502366
	.word	-212731354
	.word	-213976518
	.word	-29626295
	.word	-162729130
	.word	-145492393
	.word	0
	.word	-163445954
	.word	-45814703
	.word	1966343
	.word	-48764086
	.word	272820604
	.word	287649006
	.word	853469823
	.word	0
	.word	319819556
	.word	254022940
	.word	420814356
	.word	520887056
	.word	405405789
	.word	238554937
	.word	438757503
	.word	0
	.word	88142918
	.word	188155192
	.word	4522561
	.word	-95812298
	.word	121043532
	.word	-179110323
	.word	-28501718
	.word	0
	.word	404167440
	.word	404627229
	.word	371791402
	.word	272371508
	.word	238814030
	.word	-260369099
	.word	372775229
	.word	0
	.word	0
	.word	0
	.word	-146278107
	.word	-131271375
	.word	-164039621
	.word	-130025661
	.word	-96143793
	.word	0
	.word	-45156278
	.word	-146213304
	.word	-297012153
	.word	-180356282
	.word	-280235448
	.word	-263981003
	.word	-230951116
	.word	-180092928
	.word	167649014
	.word	536617471
	.word	554114828
	.word	622272294
	.word	339738624
	.word	0
	.word	0
	.word	0
	.word	-45156278
	.word	-146213304
	.word	-297012153
	.word	-180356282
	.word	-280235448
	.word	-263981003
	.word	-230951116
	.word	-180092928
	.word	167649014
	.word	536617471
	.word	554114828
	.word	622272294
	.word	339738624
	.word	0
	.word	0
	.word	0
	.type	CalcZeroNum, %object
	.size	CalcZeroNum, 256
CalcZeroNum:
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
	.type	g_AspecRatioIdc, %object
	.size	g_AspecRatioIdc, 112
g_AspecRatioIdc:
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
	.ascii	"list[%d][%d]: frame_num=%d, poc=%d\012\000"
.LC1:
	.ascii	"L0: \000"
	.space	3
.LC2:
	.ascii	"\012\000"
	.space	2
.LC3:
	.ascii	"%d \000"
.LC4:
	.ascii	"%dt \000"
	.space	3
.LC5:
	.ascii	"%db \000"
	.space	3
.LC6:
	.ascii	"L1:\000"
.LC7:
	.ascii	"\012\012END of the bit buffer, copy the first packe"
	.ascii	"t!\012\012\000"
	.space	2
.LC8:
	.ascii	"0:phy:0x%x, 1:phy:0x%x; len0:%d len1:%d\012\000"
	.space	3
.LC9:
	.ascii	"0:phy:0x%x, len0:%d\012\000"
	.space	3
.LC10:
	.ascii	"%-50s%50d\012\000"
	.space	1
.LC11:
	.ascii	"frame %d, state=%d, is already output\012\000"
	.space	1
.LC12:
	.ascii	"plfs(fs=%p, eFoState=%d) is null, logic_fs_id = %d\012"
	.ascii	"\000"
.LC13:
	.ascii	"not used frame: (%d,%d)\012\000"
	.space	3
.LC14:
	.ascii	"frame skip: is_used=%d,skip=%d\012\000"
.LC15:
	.ascii	"topfield skip: is_used=%d,skip=%d\012\000"
	.space	1
.LC16:
	.ascii	"bottom field skip: is_used=%d,skip=%d\012\000"
	.space	1
.LC17:
	.ascii	"err(%d) > out_thr(%d)\012\000"
	.space	1
.LC18:
	.ascii	"exg_pts: %lld <-> %lld\012\000"
.LC19:
	.ascii	"stream frame packing type is %d! what can we do?\012"
	.ascii	"\000"
	.space	2
.LC20:
	.ascii	"/home/share/HiSTBAndroid5.x/release/HiSTBAndroid5.x"
	.ascii	"/master/HiSTBAndroidV6_release/HiSTBAndroidV600R002"
	.ascii	"C00SPC030/device/hisilicon/bigfish/sdk/source/kerne"
	.ascii	"l/linux-3.18.y/drivers/msp/vfmw/vfmw_v5.0/firmware/"
	.ascii	"common/syntax/h264.c\000"
	.space	3
.LC21:
	.ascii	"NULL pointer: %s, L%d\012\000"
	.space	1
.LC22:
	.ascii	"framestore %d allocate apc %d\012\000"
	.space	1
.LC23:
	.ascii	"find APC, but logic_fs_id %d abnormal(ref=%d,plfs=%"
	.ascii	"p, pdfs=%p)\012\000"
.LC24:
	.ascii	"pH264Ctx->DPB.fs[%d]: frame_num=%d poc=%d is_refere"
	.ascii	"nce=%d\012\000"
	.space	1
.LC25:
	.ascii	"pH264Ctx->DPB.fs_ref[%d]: frame_num=%d poc=%d is_re"
	.ascii	"ference=%d\012\000"
	.space	1
.LC26:
	.ascii	"pH264Ctx->DPB.fs_ref[%d]: frame.poc=%d \012\000"
	.space	3
.LC27:
	.ascii	"\012 VFMW ** release streambuff=%p   bitstream_leng"
	.ascii	"th=%d\012\000"
	.space	1
.LC28:
	.ascii	"clear curr slice.\012\000"
	.space	1
.LC29:
	.ascii	"partition fs memory fail!\012\000"
	.space	1
.LC30:
	.ascii	"ERROR: FSP_ConfigInstance fail!\012\000"
	.space	3
.LC31:
	.ascii	"slice_type %d invalid, clear current slice.\012\000"
	.space	3
.LC32:
	.ascii	"pRepairPic(%p)/found(%d) = 0, clear current slice.\012"
	.ascii	"\000"
.LC33:
	.ascii	"listXsize[%d] = %d, clear current slice.\012\000"
	.space	2
.LC34:
	.ascii	"for P slice size of list equal 0.\012\000"
	.space	1
.LC35:
	.ascii	"for B slice size of two list all equal 0.\012\000"
	.space	1
.LC36:
	.ascii	"init list error.\012\000"
	.space	2
.LC37:
	.ascii	"L0: list after init.\012\000"
	.space	2
.LC38:
	.ascii	"L0: list after reorder.\012\000"
	.space	3
.LC39:
	.ascii	"save pic yuv :  structure = %d;  idc = %d\012\000"
	.space	1
.LC40:
	.ascii	"structure = %d pH264Ctx->CurrPic.pic_width_in_mb = "
	.ascii	"%d pH264Ctx->CurrPic.pic_height_in_mb = %d\012\000"
	.space	1
.LC41:
	.ascii	"nal_ref_idc=%d, structure=%d, image_id=%d, pmv_idc="
	.ascii	"%d\012\000"
	.space	1
.LC42:
	.ascii	"logic frame id(=%d): get LogicFs error!\012\000"
	.space	3
.LC43:
	.ascii	"phy fs is null: pstDecodeFs = %p, pstDispOutFs = %p"
	.ascii	"\012\000"
	.space	3
.LC44:
	.ascii	"line: %d pstLogicFs is null\012\000"
	.space	3
.LC45:
	.ascii	"SH: first_mb_in_slice\000"
	.space	2
.LC46:
	.ascii	"slicecheck first_mb_in_slice >= MAX_MB_NUM_IN_PIC e"
	.ascii	"rror.\012\000"
	.space	2
.LC47:
	.ascii	"SH: slice_type\000"
	.space	1
.LC48:
	.ascii	"slice type = %d\012\000"
	.space	3
.LC49:
	.ascii	"slice type = %d, err\012\000"
	.space	2
.LC50:
	.ascii	"slice  pps id = %d\012\000"
.LC51:
	.ascii	"pps with this pic_parameter_set_id = %d havn't deco"
	.ascii	"de\012\000"
	.space	1
.LC52:
	.ascii	"sps with this pic_parameter_set_id = %d havn't deco"
	.ascii	"de\012\000"
	.space	1
.LC53:
	.ascii	"tmp slice  pps id = %d\012\000"
.LC54:
	.ascii	"PPSSPSCheckTmpId: pps with this pic_parameter_set_i"
	.ascii	"d = %d havn't decode\012\000"
	.space	3
.LC55:
	.ascii	"PPSSPSCheckTmpId: seq_parameter_set_id out of range"
	.ascii	".\012\000"
	.space	2
.LC56:
	.ascii	"PPSSPSCheckTmpId: sps with this pic_parameter_set_i"
	.ascii	"d = %d havn't decode\012\000"
	.space	3
.LC57:
	.ascii	"new pic flag = %d\012\000"
	.space	1
.LC58:
	.ascii	"SH: ref_pic_list_reordering_flag_l0\000"
.LC59:
	.ascii	"SH: reordering_of_pic_nums_idc_l0\000"
	.space	2
.LC60:
	.ascii	"reorder idc l0 = %d, g_SeErrFlag=%d\012\000"
	.space	3
.LC61:
	.ascii	"SH: abs_diff_pic_num_minus1_l0\000"
	.space	1
.LC62:
	.ascii	"abs_diff_pic_num_minus1_l0 = %d, g_SeErrFlag=%d\012"
	.ascii	"\000"
	.space	3
.LC63:
	.ascii	"SH: long_term_pic_idx_l0\000"
	.space	3
.LC64:
	.ascii	"num of idc l0 exceed\012\000"
	.space	2
.LC65:
	.ascii	"SH: ref_pic_list_reordering_flag_l1\000"
.LC66:
	.ascii	"SH: reordering_of_pic_nums_idc_l1\000"
	.space	2
.LC67:
	.ascii	"reorder idc l1 = %d, g_SeErrFlag=%d\012\000"
	.space	3
.LC68:
	.ascii	"SH: abs_diff_pic_num_minus1_l1\000"
	.space	1
.LC69:
	.ascii	"abs_diff_pic_num_minus1_l1 = %d, g_SeErrFlag=%d\012"
	.ascii	"\000"
	.space	3
.LC70:
	.ascii	"SH: long_term_pic_idx_l1\000"
	.space	3
.LC71:
	.ascii	"num of idc l1 exceed\012\000"
	.space	2
.LC72:
	.ascii	"SH: luma_log2_weight_denom\000"
	.space	1
.LC73:
	.ascii	"SH: chroma_log2_weight_denom\000"
	.space	3
.LC74:
	.ascii	"WP log2 exceed  and err flag = %d\012\000"
	.space	1
.LC75:
	.ascii	"SH: luma_weight_flag_l0\000"
.LC76:
	.ascii	"SH: luma_weight_l0\000"
	.space	1
.LC77:
	.ascii	"SH: luma_offset_l0\000"
	.space	1
.LC78:
	.ascii	"SH: chroma_weight_flag_l0\000"
	.space	2
.LC79:
	.ascii	"SH: chroma_weight_l0\000"
	.space	3
.LC80:
	.ascii	"SH: chroma_offset_l0\000"
	.space	3
.LC81:
	.ascii	"SH: luma_weight_flag_l1\000"
.LC82:
	.ascii	"SH: luma_weight_l1\000"
	.space	1
.LC83:
	.ascii	"SH: luma_offset_l1\000"
	.space	1
.LC84:
	.ascii	"SH: chroma_weight_flag_l1\000"
	.space	2
.LC85:
	.ascii	"SH: chroma_weight_l1\000"
	.space	3
.LC86:
	.ascii	"SH: chroma_offset_l1\000"
	.space	3
.LC87:
	.ascii	"overflow MAX_MMCO_LEN\012\000"
	.space	1
.LC88:
	.ascii	"SH: memory_management_control_operation\000"
.LC89:
	.ascii	"SH: difference_of_pic_nums_minus1\000"
	.space	2
.LC90:
	.ascii	"SH: long_term_pic_num\000"
	.space	2
.LC91:
	.ascii	"SH: long_term_frame_idx\000"
.LC92:
	.ascii	"SH: max_long_term_frame_idx_plus1\000"
	.space	2
.LC93:
	.ascii	"mmco exceed 6\012\000"
	.space	1
.LC94:
	.ascii	"SH: no_output_of_prior_pics_flag\000"
	.space	3
.LC95:
	.ascii	"SH: long_term_reference_flag\000"
	.space	3
.LC96:
	.ascii	"IDR and no_output_of_prior_pics_flag = %d\012\000"
	.space	1
.LC97:
	.ascii	"SH: adaptive_ref_pic_marking_mode_flag\000"
	.space	1
.LC98:
	.ascii	"adaptive_ref_pic_marking_mode_flag = %d\012\000"
	.space	3
.LC99:
	.ascii	"MMCO para would save dec err\012\000"
	.space	2
.LC100:
	.ascii	"mulitislice diff no_out_of_prior_pics_flag, used fi"
	.ascii	"rst.\012\000"
	.space	3
.LC101:
	.ascii	"mulitislice diff long_term_reference_flag, used fir"
	.ascii	"st.\012\000"
.LC102:
	.ascii	"mulitislice diff adaptive_ref_pic_marking_mode_flag"
	.ascii	", used first.\012\000"
	.space	2
.LC103:
	.ascii	"TotalPicNum=%d, SliceNumInPic=%d, TotalNal=%d\012\000"
	.space	1
.LC104:
	.ascii	"SH: pic_parameter_set_id\000"
	.space	3
.LC105:
	.ascii	"pps id:%d in sliceheader err\012\000"
	.space	2
.LC106:
	.ascii	"PPS or SPS of this slice not valid\012\000"
.LC107:
	.ascii	"recover point but isn't I_SLICE.\012\000"
	.space	2
.LC108:
	.ascii	"SH: frame_num\000"
	.space	2
.LC109:
	.ascii	"IDR NAL but frame_num!=0.\012\000"
	.space	1
.LC110:
	.ascii	"SH: field_pic_flag\000"
	.space	1
.LC111:
	.ascii	"SH: bottom_field_flag\000"
	.space	2
.LC112:
	.ascii	"field first_mb_in_slice bigger than pic size\012\000"
	.space	2
.LC113:
	.ascii	"frame first_mb_in_slice bigger than pic size\012\000"
	.space	2
.LC114:
	.ascii	"SH: idr_pic_id\000"
	.space	1
.LC115:
	.ascii	"idr_pic_id bigger than 65535\012\000"
	.space	2
.LC116:
	.ascii	"SH: pic_order_cnt_lsb\000"
	.space	2
.LC117:
	.ascii	"SH: delta_pic_order_cnt_bottom\000"
	.space	1
.LC118:
	.ascii	"SH: delta_pic_order_cnt[0]\000"
	.space	1
.LC119:
	.ascii	"SH: delta_pic_order_cnt[1]\000"
	.space	1
.LC120:
	.ascii	"SH: redundant_pic_cnt\000"
	.space	2
.LC121:
	.ascii	"redundant pic not support.\012\000"
.LC122:
	.ascii	"first_mb_in_slice in currslice small than prevslice"
	.ascii	" in same pic\012\000"
	.space	3
.LC123:
	.ascii	"SH: direct_spatial_mv_pred_flag\000"
.LC124:
	.ascii	"SH: num_ref_idx_override_flag\000"
	.space	2
.LC125:
	.ascii	"SH: num_ref_idx_l0_active_minus1\000"
	.space	3
.LC126:
	.ascii	"SH: num_ref_idx_l1_active_minus1\000"
	.space	3
.LC127:
	.ascii	"frame num_ref_idx_lx_active_minus1 exceed\012\000"
	.space	1
.LC128:
	.ascii	"field num_ref_idx_lx_active_minus1 exceed\012\000"
	.space	1
.LC129:
	.ascii	"reordering para dec err\012\000"
	.space	3
.LC130:
	.ascii	"apply_weights_flag=%d\012\000"
	.space	1
.LC131:
	.ascii	"wpt dec err\012\000"
	.space	3
.LC132:
	.ascii	"mark para dec err\012\000"
	.space	1
.LC133:
	.ascii	"SH: cabac_init_idc\000"
	.space	1
.LC134:
	.ascii	"cabac_init_idc bigger than 3\012\000"
	.space	2
.LC135:
	.ascii	"SH: slice_qp_delta\000"
	.space	1
.LC136:
	.ascii	"SH: disable_deblocking_filter_idc\000"
	.space	2
.LC137:
	.ascii	"disable_deblocking_filter_idc dec err\012\000"
	.space	1
.LC138:
	.ascii	"SH: slice_alpha_c0_offset_div2\000"
	.space	1
.LC139:
	.ascii	"slice_alpha_c0_offset_div2 dec err\012\000"
.LC140:
	.ascii	"SH: slice_beta_offset_div2\000"
	.space	1
.LC141:
	.ascii	"slice_beta_offset_div2 dec err\012\000"
.LC142:
	.ascii	"pH264Ctx->pCurrNal->nal_bitoffset = %d; code_len_by"
	.ascii	"te = %d; bitstream_length = %d; pH264Ctx->pCurrNal-"
	.ascii	">nal_trail_zero_bit_num = %d\012\000"
.LC143:
	.ascii	"stream[%d]: bitsoffset = %d; valid_bitlen = %d; byt"
	.ascii	"espos = %x\012\000"
	.space	1
.LC144:
	.ascii	"nal_segment = %d is not expected value\012\000"
.LC145:
	.ascii	"stream[%d]: bitsoffset = %d; valid_bitlen = %d\012\000"
.LC146:
	.ascii	"   : delta_sl   \000"
	.space	3
.LC147:
	.ascii	"PPS: entropy_coding_mode_flag\000"
	.space	2
.LC148:
	.ascii	"PPS: pic_order_present_flag\000"
.LC149:
	.ascii	"PPS: num_slice_groups_minus1\000"
	.space	3
.LC150:
	.ascii	"Baseline stream with FMO, not support.\012\000"
.LC151:
	.ascii	"PPS: num_ref_idx_l0_active_minus1\000"
	.space	2
.LC152:
	.ascii	"num_ref_idx_l0_active_minus1 out of range.\012\000"
.LC153:
	.ascii	"PPS: num_ref_idx_l1_active_minus1\000"
	.space	2
.LC154:
	.ascii	"num_ref_idx_l1_active_minus1 out of range.\012\000"
.LC155:
	.ascii	"PPS: weighted prediction flag\000"
	.space	2
.LC156:
	.ascii	"PPS: weighted_bipred_idc\000"
	.space	3
.LC157:
	.ascii	"weighted_bipred_idc out of range\012\000"
	.space	2
.LC158:
	.ascii	"PPS: pic_init_qp_minus26\000"
	.space	3
.LC159:
	.ascii	"PPS: pic_init_qs_minus26\000"
	.space	3
.LC160:
	.ascii	"PPS: chroma_qp_index_offset\000"
.LC161:
	.ascii	"PPS: deblocking_filter_control_present_flag\000"
.LC162:
	.ascii	"PPS: constrained_intra_pred_flag\000"
	.space	3
.LC163:
	.ascii	"PPS: redundant_pic_cnt_present_flag\000"
.LC164:
	.ascii	"redundant pic not support when find redundant slice"
	.ascii	" later, exit\012\000"
	.space	3
.LC165:
	.ascii	"PPS: transform_8x8_mode_flag\000"
	.space	3
.LC166:
	.ascii	"PPS: pic_scaling_matrix_present_flag\000"
	.space	3
.LC167:
	.ascii	"PPS: second_chroma_qp_index_offset\000"
	.space	1
.LC168:
	.ascii	"SPS: seq_scaling_list_present_flag\000"
	.space	1
.LC169:
	.ascii	"PPS: pic_scaling_list_present_flag\000"
	.space	1
.LC170:
	.ascii	"second_chroma_qp_index_offset out of range.\012\000"
	.space	3
.LC171:
	.ascii	"PPS: pic_parameter_set_id\000"
	.space	2
.LC172:
	.ascii	"pic_parameter_set_id out of range.\012\000"
.LC173:
	.ascii	"PPS: seq_parameter_set_id\000"
	.space	2
.LC174:
	.ascii	"seq_parameter_set_id out of range.\012\000"
.LC175:
	.ascii	"SPS haven't decode.\012\000"
	.space	3
.LC176:
	.ascii	"PPS decode error.\012\000"
	.space	1
.LC177:
	.ascii	"VUI: aspect_ratio_info_present_flag\000"
.LC178:
	.ascii	"VUI: aspect_ratio_idc\000"
	.space	2
.LC179:
	.ascii	"VUI: sar_width\000"
	.space	1
.LC180:
	.ascii	"VUI: sar_height\000"
.LC181:
	.ascii	"VUI: overscan_info_present_flag\000"
.LC182:
	.ascii	"VUI: overscan_appropriate_flag\000"
	.space	1
.LC183:
	.ascii	"VUI: video_signal_type_present_flag\000"
.LC184:
	.ascii	"VUI: video_format\000"
	.space	2
.LC185:
	.ascii	"VUI: video_full_range_flag\000"
	.space	1
.LC186:
	.ascii	"VUI: color_description_present_flag\000"
.LC187:
	.ascii	"VUI: colour_primaries\000"
	.space	2
.LC188:
	.ascii	"VUI: transfer_characteristics\000"
	.space	2
.LC189:
	.ascii	"VUI: matrix_coefficients\000"
	.space	3
.LC190:
	.ascii	"VUI: chroma_loc_info_present_flag\000"
	.space	2
.LC191:
	.ascii	"VUI: chroma_sample_loc_type_top_field\000"
	.space	2
.LC192:
	.ascii	"VUI: chroma_sample_loc_type_bottom_field\000"
	.space	3
.LC193:
	.ascii	"VUI: timing_info_present_flag\000"
	.space	2
.LC194:
	.ascii	"VUI: num_units_in_tick\000"
	.space	1
.LC195:
	.ascii	"VUI: time_scale\000"
.LC196:
	.ascii	"VUI: fixed_frame_rate_flag\000"
	.space	1
.LC197:
	.ascii	"VUI: nal_hrd_parameters_present_flag\000"
	.space	3
.LC198:
	.ascii	"VUI: cpb_cnt_minus1\000"
.LC199:
	.ascii	"VUI: bit_rate_scale\000"
.LC200:
	.ascii	"VUI: cpb_size_scale\000"
.LC201:
	.ascii	"hrd->cpb_cnt_minus1 out of range\012\000"
	.space	2
.LC202:
	.ascii	"VUI: bit_rate_value_minus1\000"
	.space	1
.LC203:
	.ascii	"VUI: cpb_size_value_minus1\000"
	.space	1
.LC204:
	.ascii	"VUI: cbr_flag\000"
	.space	2
.LC205:
	.ascii	"VUI: initial_cpb_removal_delay_length_minus1\000"
	.space	3
.LC206:
	.ascii	"VUI: cpb_removal_delay_length_minus1\000"
	.space	3
.LC207:
	.ascii	"VUI: dpb_output_delay_length_minus1\000"
.LC208:
	.ascii	"VUI: time_offset_length\000"
.LC209:
	.ascii	"VUI: vcl_hrd_parameters_present_flag\000"
	.space	3
.LC210:
	.ascii	"VUI: low_delay_hrd_flag\000"
.LC211:
	.ascii	"VUI: pic_struct_present_flag\000"
	.space	3
.LC212:
	.ascii	"VUI: bitstream_restriction_flag\000"
.LC213:
	.ascii	"VUI: motion_vectors_over_pic_boundaries_flag\000"
	.space	3
.LC214:
	.ascii	"VUI: max_bytes_per_pic_denom\000"
	.space	3
.LC215:
	.ascii	"VUI: max_bits_per_mb_denom\000"
	.space	1
.LC216:
	.ascii	"VUI: log2_max_mv_length_horizontal\000"
	.space	1
.LC217:
	.ascii	"VUI: log2_max_mv_length_vertical\000"
	.space	3
.LC218:
	.ascii	"VUI: num_reorder_frames\000"
.LC219:
	.ascii	"VUI: max_dec_frame_buffering\000"
	.space	3
.LC220:
	.ascii	"dar=%d\012\000"
.LC221:
	.ascii	"SPS: chroma_format_idc\000"
	.space	1
.LC222:
	.ascii	"pSPS->chroma_format_idc out of range.\012\000"
	.space	1
.LC223:
	.ascii	"SPS: bit_depth_luma_minus8\000"
	.space	1
.LC224:
	.ascii	"bit_depth_luma(%d) not equal 8.\012\000"
	.space	3
.LC225:
	.ascii	"SPS: bit_depth_chroma_minus8\000"
	.space	3
.LC226:
	.ascii	"bit_depth_chroma(%d) not equal 8.\012\000"
	.space	1
.LC227:
	.ascii	"SPS: qpprime_y_zero_trans_bypass_flag\000"
	.space	2
.LC228:
	.ascii	"qpprime_y_zero_trans_bypass_flag not equal 0.\012\000"
	.space	1
.LC229:
	.ascii	"SPS: seq_scaling_matrix_present_flag\000"
	.space	3
.LC230:
	.ascii	"SPS: log2_max_frame_num_minus4\000"
	.space	1
.LC231:
	.ascii	"pSPS->log2_max_frame_num_minus4 out of range.\012\000"
	.space	1
.LC232:
	.ascii	"SPS: pic_order_cnt_type\000"
.LC233:
	.ascii	"pSPS->pic_order_cnt_type out of range.\012\000"
.LC234:
	.ascii	"SPS: log2_max_pic_order_cnt_lsb_minus4\000"
	.space	1
.LC235:
	.ascii	"SPS: num_ref_frames\000"
.LC236:
	.ascii	"pSPS->log2_max_pic_order_cnt_lsb_minus4 out of rang"
	.ascii	"e.\012\000"
	.space	1
.LC237:
	.ascii	"SPS: delta_pic_order_always_zero_flag\000"
	.space	2
.LC238:
	.ascii	"SPS: offset_for_non_ref_pic\000"
.LC239:
	.ascii	"SPS: offset_for_top_to_bottom_field\000"
.LC240:
	.ascii	"SPS: num_ref_frames_in_pic_order_cnt_cycle\000"
	.space	1
.LC241:
	.ascii	"pSPS->num_ref_frames_in_pic_order_cnt_cycle out of "
	.ascii	"range.\012\000"
	.space	1
.LC242:
	.ascii	"SPS: offset_for_ref_frame[i]\000"
	.space	3
.LC243:
	.ascii	"SPS: gaps_in_frame_num_value_allowed_flag\000"
	.space	2
.LC244:
	.ascii	"SPS: pic_width_in_mbs_minus1\000"
	.space	3
.LC245:
	.ascii	"pSPS->pic_width_in_mbs_minus1 out of range(=%d).\012"
	.ascii	"\000"
	.space	2
.LC246:
	.ascii	"SPS: pic_height_in_map_units_minus1\000"
.LC247:
	.ascii	"SPS: frame_mbs_only_flag\000"
	.space	3
.LC248:
	.ascii	"pSPS->pic_height_in_map_units_minus1 out of range.\012"
	.ascii	"\000"
.LC249:
	.ascii	"pic size too large.\012\000"
	.space	3
.LC250:
	.ascii	"level_idc %d not support.\012\000"
	.space	1
.LC251:
	.ascii	"dpb size according level : %d\012\000"
	.space	1
.LC252:
	.ascii	"pSPS->num_ref_frames(%d) > DPB size(%d), try to sel"
	.ascii	"ect the reasonable one.\012\000"
.LC253:
	.ascii	"SPS: direct_8x8_inference_flag\000"
	.space	1
.LC254:
	.ascii	"SPS: frame_cropping_flag\000"
	.space	3
.LC255:
	.ascii	"SPS: frame_cropping_rect_left_offset\000"
	.space	3
.LC256:
	.ascii	"SPS: frame_cropping_rect_right_offset\000"
	.space	2
.LC257:
	.ascii	"SPS: frame_cropping_rect_top_offset\000"
.LC258:
	.ascii	"SPS: frame_cropping_rect_bottom_offset\000"
	.space	1
.LC259:
	.ascii	"SPS: vui_parameters_present_flag\000"
	.space	3
.LC260:
	.ascii	"max_dec_frame_buffering(%d) > MaxDpbSize(%d)\012\000"
	.space	2
.LC261:
	.ascii	"SPS: mb_adaptive_frame_field_flag\000"
	.space	2
.LC262:
	.ascii	"SPS_SVC_EXT: inter_layer_deblocking_filter_control_"
	.ascii	"present_flag\000"
.LC263:
	.ascii	"inter_layer_present_flag:%d!\012\000"
	.space	2
.LC264:
	.ascii	"SPS_SVC_EXT: extended_spatial_scalability_idc\000"
	.space	2
.LC265:
	.ascii	"spatial scalability not support!!\012\000"
	.space	1
.LC266:
	.ascii	"SPS_SVC_EXT: chroma_phase_x_plus1_flag\000"
	.space	1
.LC267:
	.ascii	"chroma_phase_x_plus1_flag:%d!!\012\000"
.LC268:
	.ascii	"SPS_SVC_EXT: chroma_phase_y_plus1\000"
	.space	2
.LC269:
	.ascii	"chroma_phase_y_plus1:%d!\012\000"
	.space	2
.LC270:
	.ascii	"SPS_SVC_EXT: seq_tcoeff_level_prediction_flag\000"
	.space	2
.LC271:
	.ascii	"SPS_SVC_EXT: adaptive_tcoeff_level_prediction_flag\000"
	.space	1
.LC272:
	.ascii	"adaptive_tcoeff_level_prediction_flag:%d!\012\000"
	.space	1
.LC273:
	.ascii	"SPS_SVC_EXT: slice_header_restriction_flag\000"
	.space	1
.LC274:
	.ascii	"slice_header_restriction_flag error:%d,%x,%d\012\000"
	.space	2
.LC275:
	.ascii	"SPS: profile_idc\000"
	.space	3
.LC276:
	.ascii	"SPS: constrained_set0_flag\000"
	.space	1
.LC277:
	.ascii	"SPS: constrained_set1_flag\000"
	.space	1
.LC278:
	.ascii	"SPS: constrained_set2_flag\000"
	.space	1
.LC279:
	.ascii	"SPS: constrained_set3_flag\000"
	.space	1
.LC280:
	.ascii	"SPS: reserved_zero_4bits\000"
	.space	3
.LC281:
	.ascii	"SPS: level_idc\000"
	.space	1
.LC282:
	.ascii	"SPS: seq_parameter_set_id\000"
	.space	2
.LC283:
	.ascii	"Baseline stream, try to decode, exit when FMO occur"
	.ascii	"red.\012\000"
	.space	3
.LC284:
	.ascii	"EXTENDED stream, try to decode, exit when dataparti"
	.ascii	"tion occurred.\012\000"
	.space	1
.LC285:
	.ascii	"others High profile stream, try to decode, exit whe"
	.ascii	"n high profile not support occurred.\012\000"
	.space	3
.LC286:
	.ascii	"profile_idc = %5d error, try to decode as main prof"
	.ascii	"ile.\012\000"
	.space	3
.LC287:
	.ascii	"level_idc = %5d error, try to decode as level_idc %"
	.ascii	"d.\012\000"
	.space	1
.LC288:
	.ascii	"Line %d: SPS[%d] decode error.\012\000"
.LC289:
	.ascii	"svc ext error:\012\000"
.LC290:
	.ascii	"SEI: frame_packing_arrangement_id\000"
	.space	2
.LC291:
	.ascii	"SEI: frame_packing_arrangement_cancel_flag\000"
	.space	1
.LC292:
	.ascii	"SEI: frame_packing_arrangement_type\000"
.LC293:
	.ascii	"SEI: quincunx_sampling_flag\000"
.LC294:
	.ascii	"SEI: content_interpretation_type\000"
	.space	3
.LC295:
	.ascii	"SEI: spatial_flipping_flag\000"
	.space	1
.LC296:
	.ascii	"SEI: frame0_flipped_flag\000"
	.space	3
.LC297:
	.ascii	"SEI: field_views_flag\000"
	.space	2
.LC298:
	.ascii	"SEI: current_frame_is_frame0_flag\000"
	.space	2
.LC299:
	.ascii	"SEI: frame0_self_contained_flag\000"
.LC300:
	.ascii	"SEI: frame1_self_contained_flag\000"
.LC301:
	.ascii	"SEI: frame0_grid_position_x\000"
.LC302:
	.ascii	"SEI: frame0_grid_position_y\000"
.LC303:
	.ascii	"SEI: frame1_grid_position_x\000"
.LC304:
	.ascii	"SEI: frame1_grid_position_y\000"
.LC305:
	.ascii	"SEI: frame_packing_arrangement_reserved_byte\000"
	.space	3
.LC306:
	.ascii	"SEI: frame_packing_arrangement_repetition_period\000"
	.space	3
.LC307:
	.ascii	"SEI: frame_packing_arrangement_extension_flag\000"
	.space	2
.LC308:
	.ascii	"DecPicTimingSEI but SPS is invalid.\012\000"
	.space	3
.LC309:
	.ascii	"SEI: cpb_removal_delay\000"
	.space	1
.LC310:
	.ascii	"SEI: dpb_output_delay\000"
	.space	2
.LC311:
	.ascii	"pic_struct\000"
	.space	1
.LC312:
	.ascii	"SEI nal dec payload type err\012\000"
	.space	2
.LC313:
	.ascii	"SEI nal dec payloadSize err\012\000"
	.space	3
.LC314:
	.ascii	"SEI_BUFFERING_PERIOD,offset = %d,payload_size = %d "
	.ascii	"\012\000"
	.space	3
.LC315:
	.ascii	"PassBytes err [%s][%d]\012\000"
.LC316:
	.ascii	"SEI_PIC_TIMING,offset = %d,payload_size = %d \012\000"
	.space	1
.LC317:
	.ascii	"SEI_PAN_SCAN_RECT,offset = %d,payload_size = %d \012"
	.ascii	"\000"
	.space	2
.LC318:
	.ascii	"SEI_FILLER_PAYLOAD,offset = %d,payload_size = %d \012"
	.ascii	"\000"
	.space	1
.LC319:
	.ascii	"SEI_USER_DATA_REGISTERED_ITU_T_T35, offset = %d, pa"
	.ascii	"yload_size = %d \012\000"
	.space	3
.LC320:
	.ascii	"SEI_USER_DATA_UNREGISTERED, offset = %d, payload_si"
	.ascii	"ze = %d \012\000"
	.space	3
.LC321:
	.ascii	"SEI: itu_t_t35_country_code\000"
.LC322:
	.ascii	"SEI: itu_t_t35_country_code_extension_byte\000"
	.space	1
.LC323:
	.ascii	"SEI: itu_t_t35_provider_code\000"
	.space	3
.LC324:
	.ascii	"len_tmp = %d cann't dec usrdata\012\000"
	.space	3
.LC325:
	.ascii	"cann't dec usrdata\012\000"
.LC326:
	.ascii	"SEI_RECOVERY_POINT,offset = %d,payload_size = %d \012"
	.ascii	"\000"
	.space	1
.LC327:
	.ascii	"SEI_DEC_REF_PIC_MARKING_REPETITION,offset = %d,payl"
	.ascii	"oad_size = %d \012\000"
	.space	1
.LC328:
	.ascii	"SEI_SPARE_PIC,offset = %d,payload_size = %d \012\000"
	.space	2
.LC329:
	.ascii	"SEI_SCENE_INFO,offset = %d,payload_size = %d \012\000"
	.space	1
.LC330:
	.ascii	"SEI_SUB_SEQ_INFO,offset = %d,payload_size = %d \012"
	.ascii	"\000"
	.space	3
.LC331:
	.ascii	"SEI_SUB_SEQ_LAYER_CHARACTERISTICS,offset = %d,paylo"
	.ascii	"ad_size = %d \012\000"
	.space	2
.LC332:
	.ascii	"SEI_SUB_SEQ_CHARACTERISTICS,offset = %d,payload_siz"
	.ascii	"e = %d \012\000"
.LC333:
	.ascii	"SEI_FULL_FRAME_FREEZE,offset = %d,payload_size = %d"
	.ascii	" \012\000"
	.space	2
.LC334:
	.ascii	"SEI_FULL_FRAME_FREEZE_RELEASE,offset = %d,payload_s"
	.ascii	"ize = %d \012\000"
	.space	2
.LC335:
	.ascii	"SEI_FULL_FRAME_SNAPSHOT,offset = %d,payload_size = "
	.ascii	"%d \012\000"
.LC336:
	.ascii	"SEI_PROGRESSIVE_REFINEMENT_SEGMENT_START,offset = %"
	.ascii	"d,payload_size = %d \012\000"
	.space	3
.LC337:
	.ascii	"SEI_PROGRESSIVE_REFINEMENT_SEGMENT_END,offset = %d,"
	.ascii	"payload_size = %d \012\000"
	.space	1
.LC338:
	.ascii	"SEI_MOTION_CONSTRAINED_SLICE_GROUP_SET,offset = %d,"
	.ascii	"payload_size = %d \012\000"
	.space	1
.LC339:
	.ascii	"SEI_FILM_GRAIN_CHARACTERISTICS,offset = %d,payload_"
	.ascii	"size = %d \012\000"
	.space	1
.LC340:
	.ascii	"SEI_DEBLOCKING_FILTER_DISPLAY_PREFERENCE,offset = %"
	.ascii	"d,payload_size = %d \012\000"
	.space	3
.LC341:
	.ascii	"SEI_STEREO_VIDEO_INFO,offset = %d,payload_size = %d"
	.ascii	" \012\000"
	.space	2
.LC342:
	.ascii	"too much usrdat, cann't dec SEI\012\000"
	.space	3
.LC343:
	.ascii	"\012the stream is error,len:%d\012\000"
	.space	3
.LC344:
	.ascii	"\012Slice nal or IDR nal = %d\012\000"
.LC345:
	.ascii	"sliceheader dec err\012\000"
	.space	3
.LC346:
	.ascii	"H264Dec destroy\012\000"
	.space	3
.LC347:
	.ascii	"H264 recycle image\012\000"
.LC348:
	.ascii	"pH264Ctx is %p, pFrameStore is %p\012\000"
	.space	1
.LC349:
	.ascii	"line; %d pstLogicFsImage is NULL!\012\000"
	.space	1
.LC350:
	.ascii	"InsertVO err:%d, ClearAll\012\000"
	.space	1
.LC351:
	.ascii	"H264.c line %d: frame para err(ret=%d), recycle ima"
	.ascii	"ge self\012\000"
.LC352:
	.ascii	"line: %d pstLogicFsImage is NULL!\012\000"
	.space	1
.LC353:
	.ascii	"[%s][%d] OutputFrmToVO return %d\012\000"
	.space	2
.LC354:
	.ascii	"line %d: flush dpb return %d\012\000"
	.space	2
.LC355:
	.ascii	"----------------- Imode -> %d ------------------\012"
	.ascii	"\000"
	.space	2
.LC356:
	.ascii	"I_MODE but first_mb_in_slice != 0\012\000"
	.space	1
.LC357:
	.ascii	"Discard this B(poc=%d) befor P, is_ref_idc=%d.\012\000"
.LC358:
	.ascii	"***** VDM start, TotalPicNum=%d, pH264Ctx->CurrPic."
	.ascii	"structure=%d.\012\000"
	.space	2
.LC359:
	.ascii	"DecVDM ERR\012\000"
.LC360:
	.ascii	"*****[%s][%d],EL Codec can only dec EL stream in DV"
	.ascii	"_DUAL_VES_IMP stream!!*****\012\000"
.LC361:
	.ascii	"***** VES Splitter: UNSUPPORT, HDR_capacity=%d*****"
	.ascii	"\012\000"
	.space	3
.LC362:
	.ascii	"\012 receive streambuff=%p; phy_addr=0x%x; bitstrea"
	.ascii	"m_length=%d\012\000"
	.space	3
.LC363:
	.ascii	"nal_release_err\012\000"
	.space	3
.LC364:
	.ascii	"cann't find slot for current nal\012\000"
	.space	2
.LC365:
	.ascii	"receive a zero packet\012\000"
	.space	1
.LC366:
	.ascii	"clear all dec para\012\000"
.LC367:
	.ascii	"line %d, get APC error, ret %d\012\000"
.LC368:
	.ascii	"InserFrmInDPB: cur pic struct = %d!\012\000"
	.space	3
.LC369:
	.ascii	"CurrPic.state is 'EMPTY'\012\000"
	.space	2
.LC370:
	.ascii	"StorePicInDPB return(%d) from L%d\012\000"
	.space	1
.LC371:
	.ascii	"directoutput mode\012\000"
	.space	1
.LC372:
	.ascii	"line: %d pImg is NULL!\012\000"
.LC373:
	.ascii	"line %d, REPORT_IFRAME_ERR\012\000"
.LC374:
	.ascii	"line %d, return %d\012\000"
.LC375:
	.ascii	"err(%d) > ref_thr(%d)\012\000"
	.space	1
.LC376:
	.ascii	"marking return %d\012\000"
	.space	1
.LC377:
	.ascii	"return value is unexpeced!\012\000"
.LC378:
	.ascii	"line %d: pH264Ctx->DPB.size = %d, ref %d, ltref %d\012"
	.ascii	"\000"
.LC379:
	.ascii	"%s: pos(%d) = pre_pos, force return.\012\000"
	.space	2
.LC380:
	.ascii	"FS_ALLOC_ERR, ClearAll\012\000"
.LC381:
	.ascii	"Can not new logic fs! ClearAll\012\000"
.LC382:
	.ascii	"GAP found while DPB is empty!\012\000"
	.space	1
.LC383:
	.ascii	"frame num gap try to fill it \012\000"
	.space	1
.LC384:
	.ascii	"CurrFrameNum = %d  UnusedShortTermFrameNum = %d\012"
	.ascii	"\000"
	.space	3
.LC385:
	.ascii	"cann't allocate frame store when gap find\012\000"
	.space	1
.LC386:
	.ascii	"allocate frame store when gap find\012\000"
.LC387:
	.ascii	"line %d: store gap pic err, ret=%d\012\000"
.LC388:
	.ascii	"%s %d unknow error!!\012\000"
	.space	2
.LC389:
	.ascii	"-1 == VCTRL_GetChanIDByCtx() Err! \012\000"
.LC390:
	.ascii	"%s %d frame_store is null!!\012\000"
	.space	3
.LC391:
	.ascii	"line %d: init dpb return %d\012\000"
	.space	3
.LC392:
	.ascii	"resolution error, the CAP_LEVEL_USER_DEFINE_WITH_OP"
	.ascii	"TION channel with s32ReRangeEn == 0 can't support s"
	.ascii	"uch bitstream.\012\000"
	.space	2
.LC393:
	.ascii	"s32MaxRefFrameNum < pH264Ctx->DPB.size, the CAP_LEV"
	.ascii	"EL_USER_DEFINE_WITH_OPTION channel can't support su"
	.ascii	"ch bitstream.\012\000"
	.space	3
.LC394:
	.ascii	"mem arrange err, ClearAll\012\000"
	.space	1
.LC395:
	.ascii	"get back frm\012\000"
	.space	2
.LC396:
	.ascii	"line %d: frame gap(=%d) > dpb size(=%d)\012\000"
	.space	3
.LC397:
	.ascii	"frame num gap don't allowed but gap find\012\000"
	.space	2
.LC398:
	.ascii	"line %d: find gap in NON-I slice but here gap is no"
	.ascii	"t allowed\012\000"
	.space	2
.LC399:
	.ascii	"line %d: dec gap failed\012\000"
	.space	3
.LC400:
	.ascii	"line %d: alloc framestore failed\012\000"
	.space	2
.LC401:
	.ascii	"dec_pts: %lld\012\000"
	.space	1
.LC402:
	.ascii	"dec_usertag: %lld\012\000"
	.space	1
.LC403:
	.ascii	"%s %d NULL == pH264Ctx->CurrPic.frame_store!!\012\000"
	.space	1
.LC404:
	.ascii	"Start Reason: SliceParaNum, MaxBytesReceived = %d, "
	.ascii	"%d(thr=%d)\012\000"
	.space	1
.LC405:
	.ascii	"Too many slice or bitstream, err!\012\000"
	.space	1
.LC406:
	.ascii	"Start Reason: new_pic_flag\012\000"
.LC407:
	.ascii	"init pic err, find next recover point or next valid"
	.ascii	" sps, pps, or exit\012\000"
	.space	1
.LC408:
	.ascii	"DecList error, ret=%d\012\000"
	.space	1
.LC409:
	.ascii	"dec list err.\012\000"
	.space	1
.LC410:
	.ascii	"pH264Ctx->TotalNal = %d, type:%d\012\000"
	.space	2
.LC411:
	.ascii	"stop i want\012\000"
	.space	3
.LC412:
	.ascii	"svc_extension_flag error:priority_id:%d, pred_flag%"
	.ascii	"d\012\000"
	.space	2
.LC413:
	.ascii	"%d,%d,%d\012\000"
	.space	2
.LC414:
	.ascii	"svc stream,nal_header:%x\012\000"
	.space	2
.LC415:
	.ascii	"***** NAL: IDR/Slice, nal_unit_type=%d, TotalSlice="
	.ascii	"%d\012\000"
	.space	1
.LC416:
	.ascii	"SliceCheck failed, clear current slice.\012\000"
	.space	3
.LC417:
	.ascii	"***** NAL: PPS, nal_unit_type=%d, TotalPPS=%d\012\000"
	.space	1
.LC418:
	.ascii	"***** NAL: SPS, nal_unit_type=%d, TotalSPS=%d\012\000"
	.space	1
.LC419:
	.ascii	"SPS decode error.\012\000"
	.space	1
.LC420:
	.ascii	"***** NAL: SEI, nal_unit_type=%d\012\000"
	.space	2
.LC421:
	.ascii	"SEI decode error.\012\000"
	.space	1
.LC422:
	.ascii	"***** NAL: AUD, nal_unit_type=%d\012\000"
	.space	2
.LC423:
	.ascii	"***** NAL: EOSEQ, nal_unit_type=%d\012\000"
.LC424:
	.ascii	"***** NAL: FILL, nal_unit_type=%d\012\000"
	.space	1
.LC425:
	.ascii	"***** NAL: EOSTREAM, nal_unit_type=%d\012\000"
	.space	1
.LC426:
	.ascii	"***** NAL: SPSEXT, nal_unit_type=%d\012\000"
	.space	3
.LC427:
	.ascii	"***** NAL: AUX, nal_unit_type=%d\012\000"
	.space	2
.LC428:
	.ascii	"***** NAL: EOPIC, nal_unit_type=%d\012\000"
.LC429:
	.ascii	"***** NAL: UNSUPPORT, nal_unit_type=%d,nalu header:"
	.ascii	"%x\012\000"
	.space	1
.LC430:
	.ascii	"FindTrailZeros ERR\012\000"
.LC431:
	.ascii	"H264_DecOneNal ERR\012\000"
.LC432:
	.ascii	"store pic err, ret = %d\012\000"
	.space	3
.LC433:
	.ascii	"imode nal store pic err, ret = %d\012\000"
	.space	1
.LC434:
	.ascii	"imode nal flush dpb err, ret = %d\012\000"
	.space	1
.LC435:
	.ascii	"cann't find FrameStore\012\000"
.LC436:
	.ascii	"========== H264 FrameStore state(is_used, is_in_dpb"
	.ascii	", IsOutDPB) ========\012\000"
	.space	3
.LC437:
	.ascii	"ReadImgNum = %d, NewImgNum = %d\012\000"
	.space	3
.LC438:
	.ascii	"%02d: %d %d %d\012\000"
.LC439:
	.ascii	"FrameStore leak, ClearAll\012\000"
	.bss
	.align	2
.LANCHOR2 = . + 0
.LANCHOR3 = . + 8184
	.type	pps_tmp.15903, %object
	.size	pps_tmp.15903, 2208
pps_tmp.15903:
	.space	2208
	.type	sps_tmp.16052, %object
	.size	sps_tmp.16052, 4000
sps_tmp.16052:
	.space	4000
	.type	TmpBuf, %object
	.size	TmpBuf, 68
TmpBuf:
	.space	68
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
