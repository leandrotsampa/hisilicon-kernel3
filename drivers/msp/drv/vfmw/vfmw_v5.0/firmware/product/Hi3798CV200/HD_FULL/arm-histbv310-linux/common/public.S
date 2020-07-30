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
	.file	"public.c"

	.text
	.align	2
	.global	DBG_AddTrace
	.type	DBG_AddTrace, %function
DBG_AddTrace:
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
	ldr	r3, .L9
	mov	r6, r0
	ldr	ip, [r3]
	cmp	ip, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	lr, [ip, #28]
	ldr	r3, [ip, #24]
	ldr	r5, .L9+4
	cmp	lr, r3
	mov	r4, lr, asl #5
	ldr	r3, [ip, #16]
	sub	r4, r4, lr, asl #2
	addlt	r0, lr, #1
	movge	r0, #0
	add	r4, r3, r4
	str	r0, [ip, #28]
	ldr	r3, [r5, #4]
	str	r1, [r4, #16]
	str	r2, [r4, #20]
	blx	r3
	mov	r1, r6
	mov	r2, #15
	str	r0, [r4, #24]
	mov	r0, r4
	ldr	r3, [r5, #88]
	blx	r3
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L10:
	.align	2
.L9:
	.word	.LANCHOR0
	.word	vfmw_Osal_Func_Ptr_S
	.fnend
	.size	DBG_AddTrace, .-DBG_AddTrace
	.align	2
	.global	DBG_GetTracerInfo
	.type	DBG_GetTracerInfo, %function
DBG_GetTracerInfo:
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
	ldr	r4, .L14
	mov	r8, r0
	mov	r7, r1
	mov	r6, r2
	mov	r5, r3
	ldr	r0, [r4]
	cmp	r0, #0
	beq	.L12
	bl	MEM_Vir2Phy
	mov	r3, #32768
	str	r0, [r8]
	str	r3, [r7]
	ldr	r3, [r4]
	ldr	r3, [r3, #16]
	str	r3, [r6]
	ldr	r3, [r4]
	ldr	r2, [r3, #24]
	add	r2, r2, #1
	str	r2, [r5]
	ldr	r3, [r4]
	ldr	r2, [fp, #4]
	ldr	r3, [r3, #28]
	str	r3, [r2]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L12:
	str	r0, [r8]
	str	r0, [r1]
	str	r0, [r2]
	str	r0, [r3]
	ldr	r3, [fp, #4]
	str	r0, [r3]
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L15:
	.align	2
.L14:
	.word	.LANCHOR0
	.fnend
	.size	DBG_GetTracerInfo, .-DBG_GetTracerInfo
	.align	2
	.global	DBG_CountTimeInfo
	.type	DBG_CountTimeInfo, %function
DBG_CountTimeInfo:
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
	ldr	r3, .L37
	mov	r5, r0
	mov	r4, r2
	mov	r6, r1
	ldr	r3, [r3]
	blx	r3
	mov	r2, r5, asl #3
	mov	r3, r5, asl #6
	rsb	lr, r2, r3
	mov	ip, r0
	ldr	r0, .L37+4
	add	lr, r0, lr
	str	r5, [lr, #8]
	cmp	r6, #12
	ldrls	pc, [pc, r6, asl #2]
	b	.L16
.L19:
	.word	.L18
	.word	.L20
	.word	.L21
	.word	.L16
	.word	.L16
	.word	.L22
	.word	.L23
	.word	.L16
	.word	.L16
	.word	.L16
	.word	.L16
	.word	.L16
	.word	.L24
.L24:
	rsb	r2, r2, r3
	add	r3, r0, r2
	ldr	r0, [r3, #12]
	str	ip, [r3, #40]
	rsb	ip, r0, ip
	str	ip, [r3, #52]
.L16:
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L18:
	rsb	r2, r2, r3
	add	r3, r0, r2
	ldr	r2, [r3, #12]
	cmp	r2, #0
	streq	ip, [r3, #12]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L20:
	rsb	r1, r2, r3
	add	r3, r0, r1
	ldr	r2, [r3, #12]
	cmp	r2, #0
	strne	ip, [r3, #16]
	strne	r4, [r3, #4]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L21:
	rsb	r2, r2, r3
	add	r3, r0, r2
	ldr	r2, [r3, #12]
	cmp	r2, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	r0, [r3, #16]
	rsb	r2, r2, ip
	str	ip, [r3, #20]
	str	r2, [r3, #44]
	rsb	ip, r0, ip
	str	ip, [r3, #24]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L22:
	rsb	r2, r2, r3
	add	r3, r0, r2
	ldr	r2, [r3, #12]
	cmp	r2, #0
	strne	ip, [r3, #28]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L23:
	rsb	r2, r2, r3
	add	r3, r0, r2
	ldr	r2, [r3, #12]
	cmp	r2, #0
	ldmeqfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	ldr	r0, [r3, #28]
	rsb	r2, r2, ip
	str	ip, [r3, #32]
	mov	r1, #0
	rsb	ip, r0, ip
	str	r2, [r3, #48]
	str	r1, [r3, #12]
	str	ip, [r3, #36]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L38:
	.align	2
.L37:
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LANCHOR0
	.fnend
	.size	DBG_CountTimeInfo, .-DBG_CountTimeInfo
	.align	2
	.global	IsDprintTypeEnable
	.type	IsDprintTypeEnable, %function
IsDprintTypeEnable:
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
	cmp	r0, #32
	beq	.L41
	ldr	r3, .L42
	mov	r2, #1
	ldr	r3, [r3, #900]
	ands	r3, r3, r2, asl r0
	movne	r0, r2
	moveq	r0, #0
	ldmfd	sp, {fp, sp, pc}
.L41:
	mov	r0, #1
	ldmfd	sp, {fp, sp, pc}
.L43:
	.align	2
.L42:
	.word	.LANCHOR0
	.fnend
	.size	IsDprintTypeEnable, .-IsDprintTypeEnable
	.align	2
	.global	vfmw_dprint_nothing
	.type	vfmw_dprint_nothing, %function
vfmw_dprint_nothing:
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
	.size	vfmw_dprint_nothing, .-vfmw_dprint_nothing
	.align	2
	.global	dprint_vfmw
	.type	dprint_vfmw, %function
dprint_vfmw:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r1, r2, r3}
	.save {r1, r2, r3}
	stmfd	sp!, {r4, fp, ip, lr, pc}
	.pad #4
	.save {r4, fp, ip, lr}
	.setfp fp, ip, #-16
	sub	fp, ip, #16
	.pad #8
	sub	sp, sp, #8
	push	{lr}
	bl	__gnu_mcount_nc
	cmp	r0, #32
	beq	.L46
	ldr	r3, .L57
	mov	r2, #1
	ldr	r3, [r3, #900]
	ands	r3, r3, r2, asl r0
	beq	.L48
.L46:
	add	ip, fp, #8
	ldr	r4, .L57
	ldr	r2, [fp, #4]
	mov	r1, #1024
	mov	r3, ip
	add	r0, r4, #904
	str	ip, [fp, #-20]
	bl	vsnprintf
	movw	r3, #1021
	sub	r2, r0, #1
	cmp	r2, r3
	bhi	.L48
	ldr	r3, .L57+4
	ldr	r3, [r3]
	cmp	r3, #1
	beq	.L56
	cmp	r3, #3
	bne	.L48
	ldr	r2, [r4, #1928]
	cmp	r2, #0
	beq	.L48
	ldr	r3, .L57+8
	mov	r1, r0
	add	r0, r4, #904
	ldr	r3, [r3, #44]
	blx	r3
.L47:
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L48:
	mvn	r0, #0
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
.L56:
	add	r1, r4, #904
	ldr	r0, .L57+12
	bl	printk
	b	.L47
.L58:
	.align	2
.L57:
	.word	.LANCHOR0
	.word	.LANCHOR1
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC0
	.fnend
	.size	dprint_vfmw, .-dprint_vfmw
	.align	2
	.global	DBG_CreateTracer
	.type	DBG_CreateTracer, %function
DBG_CreateTracer:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #36
	sub	sp, sp, #36
	push	{lr}
	bl	__gnu_mcount_nc
	ldr	r5, .L64
	ldr	r1, [r5]
	cmp	r1, #0
	movne	r4, #0
	beq	.L63
.L60:
	mov	r0, r4
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L63:
	str	r1, [sp]
	sub	r3, fp, #52
	mov	r2, #32768
	ldr	r0, .L64+4
	mov	ip, #3
	str	ip, [fp, #-32]
	bl	MEM_AllocMemBlock
	subs	r4, r0, #0
	mvnne	r4, #0
	bne	.L60
	ldr	r2, [fp, #-36]
	movw	r6, #30085
	ldr	r1, [fp, #-48]
	movt	r6, 21861
	ldr	r0, [fp, #-44]
	bl	MEM_AddMemRecord
	ldr	ip, [fp, #-44]
	ldr	r0, [fp, #-48]
	mov	r1, r4
	ldr	r3, .L64+8
	mov	r2, #32768
	str	ip, [r5, #1932]
	str	r0, [r5]
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r1, [r5]
	ldr	r3, [fp, #-48]
	movw	r2, #18725
	movt	r2, 9362
	movw	ip, #14922
	add	r3, r3, #32
	str	r3, [r1, #16]
	ldr	r3, [fp, #-36]
	movt	ip, 6698
	ldr	r0, [fp, #-44]
	movw	lr, #27263
	sub	r3, r3, #32
	str	ip, [r1]
	ldr	ip, [r5]
	movw	r5, #12085
	mov	r3, r3, lsr #2
	str	r4, [r1, #28]
	add	r0, r0, #32
	movt	r5, 3861
	umull	r2, r3, r3, r2
	str	r0, [r1, #20]
	movt	lr, 19039
	mov	r0, #22
	sub	r3, r3, #4
	str	r3, [r1, #24]
	str	r6, [ip, #4]
	str	r5, [ip, #8]
	ldr	r1, [ip, #24]
	ldr	r2, [fp, #-44]
	str	lr, [ip, #12]
	add	r3, r2, #32
	str	r1, [sp]
	ldr	r1, .L64+12
	bl	dprint_vfmw
	b	.L60
.L65:
	.align	2
.L64:
	.word	.LANCHOR0
	.word	.LC1
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC2
	.fnend
	.size	DBG_CreateTracer, .-DBG_CreateTracer
	.align	2
	.global	DBG_DestroyTracer
	.type	DBG_DestroyTracer, %function
DBG_DestroyTracer:
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
	ldr	r4, .L71
	ldr	r0, [r4]
	cmp	r0, #0
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	bl	MEM_Vir2Phy
	ldr	r1, [r4]
	mov	r5, r0
	bl	MEM_ReleaseMemBlock
	ldr	r3, [r4]
	mov	r2, r5
	mov	r0, #22
	ldr	r1, .L71+4
	bl	dprint_vfmw
	mov	r3, #0
	str	r3, [r4]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L72:
	.align	2
.L71:
	.word	.LANCHOR0
	.word	.LC3
	.fnend
	.size	DBG_DestroyTracer, .-DBG_DestroyTracer
	.align	2
	.global	DBG_PrintTracer
	.type	DBG_PrintTracer, %function
DBG_PrintTracer:
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
	ldr	r5, .L92
	mov	r6, r0
	ldr	r4, [r5]
	cmp	r4, #0
	beq	.L89
.L74:
	ldr	r2, [r4]
	movw	r3, #14922
	movt	r3, 6698
	cmp	r2, r3
	bne	.L77
	ldr	r2, [r4, #4]
	movw	r3, #30085
	movt	r3, 21861
	cmp	r2, r3
	beq	.L90
.L77:
	mov	r2, r6
	ldr	r1, .L92+4
	mov	r0, #32
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L90:
	ldr	r2, [r4, #8]
	movw	r3, #12085
	movt	r3, 3861
	cmp	r2, r3
	bne	.L77
	ldr	r2, [r4, #12]
	movw	r3, #27263
	movt	r3, 19039
	cmp	r2, r3
	bne	.L77
	ldr	r1, .L92+8
	mov	r0, #32
	bl	dprint_vfmw
	ldr	r3, [r4, #16]
	ldr	r2, .L92+12
	mov	r0, #32
	ldr	r1, .L92+16
	bl	dprint_vfmw
	ldr	r3, [r4, #20]
	ldr	r2, .L92+20
	mov	r0, #32
	ldr	r1, .L92+24
	bl	dprint_vfmw
	ldr	r3, [r4, #24]
	ldr	r2, .L92+28
	mov	r0, #32
	ldr	r1, .L92+32
	bl	dprint_vfmw
	ldr	r3, [r4, #28]
	ldr	r2, .L92+36
	mov	r0, #32
	ldr	r1, .L92+32
	bl	dprint_vfmw
	ldr	r3, [r4, #24]
	ldr	r7, [r4, #28]
	cmp	r3, #0
	movgt	r8, #0
	ble	.L83
.L82:
	cmp	r7, #0
	sub	r7, r7, #1
	mov	r2, r8
	ldr	r1, .L92+40
	moveq	r7, r3
	ldr	r3, [r4, #16]
	mov	r6, r7, asl #5
	mov	r0, #32
	sub	r6, r6, r7, asl #2
	add	r8, r8, #1
	add	r6, r3, r6
	bl	dprint_vfmw
	ldr	r1, .L92+44
	mov	r0, #32
	mov	r2, r6
	bl	dprint_vfmw
	ldr	r2, [r6, #16]
	ldr	r1, .L92+48
	mov	r0, #32
	bl	dprint_vfmw
	ldr	r3, [r6, #20]
	ldr	r1, .L92+52
	mov	r0, #32
	mov	r2, r3
	bl	dprint_vfmw
	ldr	r2, [r6, #24]
	ldr	r1, .L92+56
	mov	r0, #32
	bl	dprint_vfmw
	ldr	r3, [r4, #24]
	cmp	r3, r8
	bgt	.L82
.L83:
	ldr	r3, [r5]
	cmp	r3, #0
	ldmnefd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	ldr	r3, .L92+60
	mov	r0, r4
	ldr	r3, [r3, #104]
	blx	r3
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L89:
	ldr	r3, .L92+60
	mov	r1, #1048576
	ldr	r3, [r3, #100]
	blx	r3
	subs	r4, r0, #0
	beq	.L91
	add	r2, r4, #32
	mov	r3, r4
	str	r2, [r4, #16]
	mov	r0, #32
	mov	r2, r6
	ldr	r1, .L92+64
	bl	dprint_vfmw
	b	.L74
.L91:
	mov	r2, r6
	ldr	r1, .L92+68
	mov	r0, #32
	bl	dprint_vfmw
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L93:
	.align	2
.L92:
	.word	.LANCHOR0
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
	.word	.LC18
	.word	.LC19
	.word	vfmw_Osal_Func_Ptr_S
	.word	.LC5
	.word	.LC4
	.fnend
	.size	DBG_PrintTracer, .-DBG_PrintTracer
	.align	2
	.global	CHECK_REC_POS_ENABLE
	.type	CHECK_REC_POS_ENABLE, %function
CHECK_REC_POS_ENABLE:
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
	ldr	r3, .L95
	ldr	r3, [r3, #4]
	mov	r0, r3, asr r0
	and	r0, r0, #1
	ldmfd	sp, {fp, sp, pc}
.L96:
	.align	2
.L95:
	.word	.LANCHOR1
	.fnend
	.size	CHECK_REC_POS_ENABLE, .-CHECK_REC_POS_ENABLE
	.global	__aeabi_uidiv
	.align	2
	.global	qsort
	.type	qsort, %function
qsort:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, r8, r9, r10, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #268
	sub	sp, sp, #268
	push	{lr}
	bl	__gnu_mcount_nc
	cmp	r2, #0
	cmpne	r1, #1
	str	r0, [fp, #-296]
	mov	r5, r3
	mov	r6, r2
	movls	ip, #1
	movhi	ip, #0
	bls	.L97
	sub	r1, r1, #1
	rsb	r3, r2, #0
	str	ip, [fp, #-304]
	mla	r7, r2, r1, r0
	str	r3, [fp, #-292]
.L99:
	ldr	r3, [fp, #-296]
	mov	r1, r6
	rsb	r0, r3, r7
	bl	__aeabi_uidiv
	add	r0, r0, #1
	cmp	r0, #8
	bhi	.L100
	ldr	r3, [fp, #-296]
	cmp	r3, r7
	bcs	.L101
	add	r4, r3, r6
	mov	r9, r3
.L106:
	cmp	r4, r7
	mov	r8, r9
	bhi	.L102
	mov	r10, r4
.L104:
	mov	r1, r8
	mov	r0, r10
	blx	r5
	cmp	r0, #0
	movgt	r8, r10
	add	r10, r10, r6
	cmp	r10, r7
	bls	.L104
.L102:
	cmp	r8, r7
	beq	.L107
	cmp	r6, #0
	beq	.L107
	add	r0, r8, r6
	mov	r3, r7
.L108:
	ldrb	r1, [r3]
	ldrb	r2, [r8]
	strb	r1, [r8], #1
	cmp	r8, r0
	strb	r2, [r3], #1
	bne	.L108
.L107:
	ldr	r3, [fp, #-292]
	add	r7, r7, r3
	cmp	r9, r7
	bcc	.L106
.L101:
	ldr	r3, [fp, #-304]
	subs	r3, r3, #1
	str	r3, [fp, #-304]
	bmi	.L97
	sub	r2, fp, #44
	add	r3, r2, r3, lsl #2
	ldr	r2, [r3, #-240]
	ldr	r7, [r3, #-120]
	str	r2, [fp, #-296]
	b	.L99
.L100:
	ldr	r8, [fp, #-296]
	mov	r4, r0, lsr #1
	mla	r4, r6, r4, r8
	mov	r0, r8
	mov	r1, r4
	blx	r5
	mov	r3, r8
	cmp	r8, r4
	cmpne	r0, #0
	ble	.L109
	sub	r8, r6, #1
	cmp	r6, #0
	mov	r10, r8
	beq	.L110
	add	lr, r3, r6
	mov	r1, r4
.L111:
	ldrb	r0, [r1]
	ldrb	r2, [r3]
	strb	r0, [r3], #1
	cmp	r3, lr
	strb	r2, [r1], #1
	bne	.L111
	ldr	r9, [fp, #-296]
	mov	r1, r7
	mov	r0, r9
	blx	r5
	cmp	r9, r7
	cmpne	r0, #0
	ble	.L205
.L143:
	ldr	r2, [fp, #-296]
	mov	r1, r7
	sub	r3, r2, #1
	add	lr, r2, r10
.L115:
	ldrb	r2, [r3, #1]!
	ldrb	r0, [r1]
	cmp	r3, lr
	strb	r0, [r3]
	strb	r2, [r1], #1
	bne	.L115
	mov	r1, r7
	mov	r0, r4
	blx	r5
	cmp	r7, r4
	cmpne	r0, #0
	ble	.L119
.L145:
	add	ip, r4, r10
	sub	r3, r4, #1
	mov	r2, r7
.L120:
	ldrb	r1, [r3, #1]!
	ldrb	r0, [r2]
	cmp	r3, ip
	strb	r0, [r3]
	strb	r1, [r2], #1
	bne	.L120
.L119:
	ldr	r3, [fp, #-296]
	mov	r9, r7
	str	r7, [fp, #-300]
	mov	r7, r4
	ldr	r4, [fp, #-292]
	add	r10, r3, r6
	mov	r8, r3
.L118:
	cmp	r7, r8
	bhi	.L122
	str	r9, [fp, #-288]
	mov	r9, r10
	ldr	r8, [fp, #-300]
	mov	r10, r4
	b	.L124
.L206:
	blx	r5
	cmp	r0, #0
	bgt	.L194
	add	r9, r9, r6
.L124:
	cmp	r8, r9
	mov	r1, r7
	mov	r0, r9
	mov	r4, r9
	bcs	.L206
.L194:
	mov	r8, r4
	mov	r4, r10
	mov	r10, r9
	ldr	r9, [fp, #-288]
	b	.L128
.L185:
	blx	r5
	cmp	r0, #0
	bgt	.L128
	add	r10, r10, r6
.L122:
	cmp	r7, r10
	mov	r1, r7
	mov	r0, r10
	mov	r8, r10
	bhi	.L185
	add	r10, r10, r6
	str	r9, [fp, #-288]
	ldr	r8, [fp, #-300]
	mov	r9, r10
	mov	r10, r4
	b	.L124
.L125:
	blx	r5
	cmp	r0, #0
	ble	.L129
.L128:
	add	r9, r9, r4
	mov	r1, r7
	cmp	r7, r9
	mov	r0, r9
	bcc	.L125
.L129:
	cmp	r10, r9
	bhi	.L207
	cmp	r9, r10
	beq	.L208
	cmp	r6, #0
	beq	.L132
	add	r10, r10, r6
	mov	r1, r9
	mov	r2, r8
.L133:
	ldrb	r0, [r1]
	ldrb	r3, [r2]
	strb	r0, [r2], #1
	cmp	r2, r10
	strb	r3, [r1], #1
	bne	.L133
.L132:
	cmp	r7, r9
	moveq	r7, r8
	b	.L118
.L208:
	cmp	r7, r9
	add	r10, r9, r6
	moveq	r7, r8
	b	.L118
.L207:
	add	r8, r9, r6
	mov	r4, r7
	cmp	r8, r4
	ldr	r7, [fp, #-300]
	bls	.L195
	ldr	r9, [fp, #-292]
	b	.L135
.L210:
	blx	r5
	cmp	r0, #0
	bne	.L209
.L135:
	add	r8, r8, r9
	mov	r1, r4
	cmp	r8, r4
	mov	r0, r8
	bhi	.L210
	str	r7, [fp, #-288]
	mov	r7, r8
	mov	r8, r6
	mov	r6, r5
	mov	r5, r9
	ldr	r9, [fp, #-296]
	b	.L138
.L212:
	blx	r6
	cmp	r0, #0
	bne	.L211
.L138:
	add	r7, r7, r5
	mov	r1, r4
	cmp	r9, r7
	mov	r0, r7
	bcc	.L212
	str	r5, [fp, #-292]
	mov	r5, r6
	mov	r6, r8
	mov	r8, r7
	ldr	r7, [fp, #-288]
	rsb	r2, r9, r0
	str	r9, [fp, #-296]
	rsb	r1, r10, r7
	cmp	r2, r1
	bge	.L140
	cmp	r7, r10
	bls	.L101
.L152:
	ldr	r3, [fp, #-304]
	sub	r2, fp, #44
	add	r2, r2, r3, lsl #2
	add	r3, r3, #1
	str	r3, [fp, #-304]
	str	r10, [r2, #-240]
	str	r7, [r2, #-120]
.L142:
	ldr	r3, [fp, #-296]
	cmp	r3, r8
	bcs	.L101
.L155:
	mov	r7, r8
	b	.L99
.L109:
	ldr	r8, [fp, #-296]
	mov	r1, r7
	mov	r0, r8
	blx	r5
	cmp	r8, r7
	cmpne	r0, #0
	ble	.L113
	cmp	r6, #0
	sub	r10, r6, #1
	bne	.L143
	mov	r1, r7
	mov	r0, r4
	blx	r5
	b	.L119
.L209:
	ldr	r3, [fp, #-296]
	rsb	r1, r10, r7
	rsb	r2, r3, r8
	cmp	r2, r1
	blt	.L213
	ldr	r3, [fp, #-296]
	cmp	r3, r8
	bcs	.L140
.L148:
	ldr	r3, [fp, #-304]
	sub	r2, fp, #44
	ldr	r1, [fp, #-296]
	add	r2, r2, r3, lsl #2
	add	r3, r3, #1
	str	r3, [fp, #-304]
	str	r1, [r2, #-240]
	str	r8, [r2, #-120]
.L140:
	cmp	r7, r10
	bls	.L101
	str	r10, [fp, #-296]
	b	.L99
.L195:
	str	r7, [fp, #-288]
	mov	r7, r8
	ldr	r9, [fp, #-296]
	mov	r8, r6
	mov	r6, r5
	ldr	r5, [fp, #-292]
	b	.L138
.L110:
	mov	r1, r7
	ldr	r0, [fp, #-296]
	blx	r5
.L113:
	mov	r1, r7
	mov	r0, r4
	blx	r5
	cmp	r7, r4
	cmpne	r0, #0
	ble	.L119
	cmp	r6, #0
	sub	r10, r6, #1
	bne	.L145
	b	.L119
.L211:
	str	r5, [fp, #-292]
	mov	r5, r6
	mov	r6, r8
	mov	r8, r7
	ldr	r7, [fp, #-288]
	rsb	r2, r9, r8
	str	r9, [fp, #-296]
	rsb	r1, r10, r7
	cmp	r2, r1
	bge	.L148
	cmp	r7, r10
	bhi	.L152
	b	.L155
.L213:
	cmp	r7, r10
	bls	.L142
	b	.L152
.L97:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L205:
	mov	r1, r7
	mov	r0, r4
	blx	r5
	cmp	r7, r4
	cmpne	r0, #0
	movgt	r10, r8
	bgt	.L145
	b	.L119
	.fnend
	.size	qsort, .-qsort
	.global	g_stLowdlyInfo
	.global	g_TunnelLineNumber
	.global	g_TraceImgPeriod
	.global	g_TraceFramePeriod
	.global	g_TraceBsPeriod
	.global	g_TraceCtrl
	.global	g_TmpMsg
	.global	g_pMemPrint
	.global	g_PrintDevice
	.global	g_PrintEnable
	.global	g_LogFileName
	.global	g_LogEnable
	.global	g_fpLog
	.global	TracerPhyAddr
	.global	s_pstTracer
	.data
	.align	2
.LANCHOR1 = . + 0
	.type	g_PrintDevice, %object
	.size	g_PrintDevice, 4
g_PrintDevice:
	.word	1
	.type	g_TraceCtrl, %object
	.size	g_TraceCtrl, 4
g_TraceCtrl:
	.word	-1
	.type	g_TunnelLineNumber, %object
	.size	g_TunnelLineNumber, 4
g_TunnelLineNumber:
	.word	10
	.type	g_TraceImgPeriod, %object
	.size	g_TraceImgPeriod, 4
g_TraceImgPeriod:
	.word	500
	.type	g_TraceBsPeriod, %object
	.size	g_TraceBsPeriod, 4
g_TraceBsPeriod:
	.word	200
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"N: %s\000"
	.space	2
.LC1:
	.ascii	"VFMW_Tracer\000"
.LC2:
	.ascii	"________________ mem_phy, trace_phy,trace_max = 0x%"
	.ascii	"x, 0x%x,%d _________________\012\000"
	.space	3
.LC3:
	.ascii	"=============== destroy tracer: phy,vir = 0x%x,%p ="
	.ascii	"==================\012\000"
	.space	1
.LC4:
	.ascii	"map vir address for '%x' failed!!!\012\000"
.LC5:
	.ascii	"tracer memory '0x%x' is mapped to '%p'\012\000"
.LC6:
	.ascii	"no valid trace info stored in '%x'!!!\012\000"
	.space	1
.LC7:
	.ascii	"====================== tracer context ============="
	.ascii	"========\012\000"
	.space	3
.LC8:
	.ascii	"pstTraceBaseObj\000"
.LC9:
	.ascii	"%-25s :%x\012\000"
	.space	1
.LC10:
	.ascii	"s32TraceBasePhyAddr\000"
.LC11:
	.ascii	"%-25s :%p\012\000"
	.space	1
.LC12:
	.ascii	"s32MaxTraceNumMinus4\000"
	.space	3
.LC13:
	.ascii	"%-25s :%d\012\000"
	.space	1
.LC14:
	.ascii	"s32CurrTraceNum\000"
.LC15:
	.ascii	"-%05d-\000"
	.space	1
.LC16:
	.ascii	"func:%-15s;\000"
.LC17:
	.ascii	" line:%5d;\000"
	.space	1
.LC18:
	.ascii	" data:0x%08x(%-10d);\000"
	.space	3
.LC19:
	.ascii	" time:%u\012\000"
	.bss
	.align	2
.LANCHOR0 = . + 0
	.type	s_pstTracer, %object
	.size	s_pstTracer, 4
s_pstTracer:
	.space	4
	.type	g_stLowdlyInfo, %object
	.size	g_stLowdlyInfo, 896
g_stLowdlyInfo:
	.space	896
	.type	g_PrintEnable, %object
	.size	g_PrintEnable, 4
g_PrintEnable:
	.space	4
	.type	g_TmpMsg, %object
	.size	g_TmpMsg, 1024
g_TmpMsg:
	.space	1024
	.type	g_fpLog, %object
	.size	g_fpLog, 4
g_fpLog:
	.space	4
	.type	TracerPhyAddr, %object
	.size	TracerPhyAddr, 4
TracerPhyAddr:
	.space	4
	.type	g_TraceFramePeriod, %object
	.size	g_TraceFramePeriod, 4
g_TraceFramePeriod:
	.space	4
	.type	g_pMemPrint, %object
	.size	g_pMemPrint, 4
g_pMemPrint:
	.space	4
	.type	g_LogFileName, %object
	.size	g_LogFileName, 500
g_LogFileName:
	.space	500
	.type	g_LogEnable, %object
	.size	g_LogEnable, 4
g_LogEnable:
	.space	4
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
