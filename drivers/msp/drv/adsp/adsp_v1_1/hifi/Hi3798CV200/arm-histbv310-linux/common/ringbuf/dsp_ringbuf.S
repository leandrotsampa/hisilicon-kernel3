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
	.file	"dsp_ringbuf.c"

	.text
	.align	2
	.global	RBUF_Create
	.type	RBUF_Create, %function
RBUF_Create:
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
	mov	r5, r1
	mov	r0, #26
	mov	r1, #84
	bl	HI_ADSP_MALLOC
	subs	r4, r0, #0
	beq	.L2
	mov	r1, #84
	bl	__memzero
	mov	r2, #36
	mov	r1, r5
	mov	r0, r4
	bl	memcpy
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L3
	ldr	r3, [r4, #4]
	ldr	r0, [r4, #8]
.L4:
	ldr	r1, [r4, #12]
	mov	r2, #0
	ldr	ip, [r4, #16]
	str	r3, [r4, #44]
	str	r0, [r4, #48]
	str	ip, [r4, #40]
	str	r1, [r4, #36]
	str	r2, [r1]
	ldr	r3, [r4, #40]
	str	r2, [r3]
	str	r4, [r6]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L3:
	ldr	r2, [r5, #24]
	mov	r0, #26
	ldr	r1, [r5, #8]
	bl	HI_ADSP_VMALLOC_Aligned
	cmp	r0, #0
	beq	.L5
	str	r0, [r4, #4]
	mov	r3, r0
	ldr	r0, [r5, #8]
	str	r0, [r4, #8]
	b	.L4
.L5:
	mov	r1, r4
	mov	r0, #26
	bl	HI_ADSP_FREE
.L2:
	mov	r3, #0
	str	r3, [r6]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	RBUF_Create, .-RBUF_Create
	.align	2
	.global	RBUF_Create_EXT
	.type	RBUF_Create_EXT, %function
RBUF_Create_EXT:
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
	mov	r5, r1
	mov	r0, #26
	mov	r1, #84
	bl	HI_ADSP_MALLOC
	subs	r4, r0, #0
	beq	.L12
	mov	r1, #84
	bl	__memzero
	mov	r2, #36
	mov	r1, r5
	mov	r0, r4
	bl	memcpy
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L13
	ldr	r3, [r4, #4]
	ldr	r2, [r4, #8]
.L14:
	ldr	r0, [r4, #16]
	ldr	r1, [r4, #12]
	str	r3, [r4, #44]
	str	r2, [r4, #48]
	str	r0, [r4, #40]
	str	r1, [r4, #36]
	str	r4, [r6]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L13:
	ldr	r2, [r5, #24]
	mov	r0, #26
	ldr	r1, [r5, #8]
	bl	HI_ADSP_VMALLOC_Aligned
	cmp	r0, #0
	beq	.L15
	str	r0, [r4, #4]
	mov	r3, r0
	ldr	r2, [r5, #8]
	str	r2, [r4, #8]
	b	.L14
.L15:
	mov	r1, r4
	mov	r0, #26
	bl	HI_ADSP_FREE
.L12:
	mov	r3, #0
	str	r3, [r6]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
	.fnend
	.size	RBUF_Create_EXT, .-RBUF_Create_EXT
	.align	2
	.global	RBUF_Destroy
	.type	RBUF_Destroy, %function
RBUF_Destroy:
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
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L26
.L22:
	mov	r1, r4
	mov	r0, #26
	bl	HI_ADSP_FREE
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L26:
	ldr	r1, [r4, #4]
	mov	r0, #26
	bl	HI_ADSP_VFREE_Aligned
	b	.L22
	.fnend
	.size	RBUF_Destroy, .-RBUF_Destroy
	.align	2
	.global	RBUF_ReadData
	.type	RBUF_ReadData, %function
RBUF_ReadData:
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
	subs	r4, r0, #0
	mov	r7, r1
	beq	.L40
	ldr	r0, [r4, #40]
	mov	ip, #0
	ldr	r1, [r4, #36]
	ldr	r3, [r4, #56]
	str	ip, [fp, #-48]
	add	r3, r3, #1
	str	r3, [r4, #56]
	ldr	r3, [r0]
	ldr	r1, [r1]
	str	ip, [fp, #-40]
	cmp	r3, r1
	str	r3, [fp, #-44]
	bhi	.L29
	add	r0, r2, r3
	cmp	r1, r0
	rsbcc	r5, r3, r1
	movcc	r6, ip
	bcc	.L30
.L42:
	mov	r5, r2
	mov	r6, ip
.L30:
	cmp	r5, #0
	beq	.L33
	cmp	r7, #0
	ldr	r1, [r4, #44]
	ldr	r9, [fp, #-44]
	beq	.L36
	add	r1, r1, r9
	mov	r2, r5
	mov	r0, r7
	bl	memcpy
	ldr	r8, [fp, #-48]
	add	r0, r7, r5
	add	r3, r5, r9
	cmp	r8, #0
	beq	.L33
	cmp	r0, #0
	ldr	r1, [r4, #44]
	ldr	r7, [fp, #-40]
	beq	.L32
	add	r1, r1, r7
	mov	r2, r8
	bl	memcpy
.L32:
	add	r3, r7, r8
.L33:
	ldr	r1, [r4, #48]
	ldr	r2, [r4, #40]
	cmp	r1, r3
	moveq	r3, #0
	adds	r0, r6, r5
	str	r3, [r2]
	ldreq	r3, [r4, #60]
	addeq	r3, r3, #1
	streq	r3, [r4, #60]
	ldr	r3, [r4, #52]
	add	r3, r3, r0
	str	r3, [r4, #52]
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L29:
	ldr	r5, [r4, #48]
	add	r0, r2, r3
	cmp	r0, r5
	bls	.L42
	rsb	r5, r3, r5
	rsb	r6, r5, r2
	cmp	r1, r6
	strcc	r1, [fp, #-48]
	movcc	r6, r1
	strcs	r6, [fp, #-48]
	b	.L30
.L36:
	ldr	r8, [fp, #-48]
	add	r3, r5, r9
	cmp	r8, #0
	ldrne	r7, [fp, #-40]
	bne	.L32
	b	.L33
.L40:
	mov	r0, r4
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	RBUF_ReadData, .-RBUF_ReadData
	.align	2
	.global	RBUF_WriteData
	.type	RBUF_WriteData, %function
RBUF_WriteData:
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
	subs	r5, r0, #0
	mov	r8, r1
	beq	.L65
	ldr	r0, [r5, #40]
	mov	r7, #0
	ldr	r1, [r5, #36]
	ldr	r3, [r5, #72]
	str	r7, [fp, #-60]
	add	r3, r3, #1
	str	r3, [r5, #72]
	ldr	r4, [r0]
	ldr	r3, [r1]
	str	r7, [fp, #-56]
	cmp	r4, r3
	str	r7, [fp, #-48]
	str	r3, [fp, #-52]
	bls	.L74
	add	r0, r2, r3
	cmp	r4, r0
	bhi	.L56
	rsb	r4, r3, r4
	str	r7, [fp, #-68]
	str	r4, [fp, #-60]
.L55:
	cmp	r4, #0
	beq	.L60
	sub	r7, fp, #52
	sub	r10, fp, #60
	mov	r6, r4
	mov	r9, #0
.L64:
	ldr	r0, [r5, #44]
	subs	r1, r8, #0
	mov	r2, r6
	add	r0, r0, r3
	beq	.L75
	str	r3, [fp, #-64]
	bl	memcpy
	ldr	r3, [fp, #-64]
	add	r8, r8, r6
.L58:
	add	r9, r9, #1
	add	r3, r6, r3
	cmp	r9, #2
	beq	.L73
	ldr	r6, [r10, #4]!
	cmp	r6, #0
	beq	.L73
	ldr	r3, [r7, #4]!
	b	.L64
.L74:
	ldr	r4, [r5, #48]
	add	r0, r2, r3
	cmp	r4, r0
	bcs	.L56
	rsb	r4, r3, r4
	str	r4, [fp, #-60]
	rsb	r2, r4, r2
	str	r2, [fp, #-68]
	str	r2, [fp, #-56]
	b	.L55
.L73:
	ldr	r1, [r5, #36]
.L60:
	ldr	r2, [r5, #48]
	cmp	r2, r3
	ldr	r2, [fp, #-68]
	movls	r3, #0
	adds	r0, r4, r2
	str	r3, [r1]
	ldreq	r3, [r5, #76]
	addeq	r3, r3, #1
	streq	r3, [r5, #76]
	ldr	r3, [r5, #68]
	add	r3, r3, r0
	str	r3, [r5, #68]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L75:
	cmp	r6, #0
	beq	.L58
	mov	r1, r6
	str	r3, [fp, #-64]
	bl	__memzero
	ldr	r3, [fp, #-64]
	b	.L58
.L56:
	str	r2, [fp, #-60]
	mov	r4, r2
	mov	r2, #0
	str	r2, [fp, #-68]
	b	.L55
.L65:
	mov	r0, r2
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	.fnend
	.size	RBUF_WriteData, .-RBUF_WriteData
	.align	2
	.global	RBUF_ReadDataComplete
	.type	RBUF_ReadDataComplete, %function
RBUF_ReadDataComplete:
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
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	lr, [r0, #40]
	ldr	r3, [r0, #36]
	ldr	r2, [lr]
	ldr	ip, [r3]
	cmp	r2, ip
	bls	.L93
	ldr	r4, [r0, #48]
	add	r3, r1, r2
	cmp	r3, r4
	bhi	.L94
	mov	r5, r1
.L80:
	cmp	r5, #0
	beq	.L91
.L85:
	add	r3, r5, r2
.L82:
	cmp	r4, r3
	moveq	r3, #0
	str	r3, [lr]
	ldr	r3, [r0, #52]
	add	r1, r3, r1
	str	r1, [r0, #52]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L93:
	add	r3, r1, r2
	cmp	ip, r3
	rsbcc	r5, r2, ip
	ldrcs	r4, [r0, #48]
	movcs	r5, r1
	ldrcc	r4, [r0, #48]
	b	.L80
.L94:
	rsb	r5, r2, r4
	rsb	r3, r5, r1
	cmp	r3, ip
	movcs	r3, ip
	cmp	r5, #0
	beq	.L91
	cmp	r3, #0
	bne	.L82
	b	.L85
.L91:
	mov	r3, r2
	b	.L82
	.fnend
	.size	RBUF_ReadDataComplete, .-RBUF_ReadDataComplete
	.align	2
	.global	RBUF_WriteDataComplete
	.type	RBUF_WriteDataComplete, %function
RBUF_WriteDataComplete:
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
	ldmeqfd	sp, {r4, r5, fp, sp, pc}
	ldr	r3, [r0, #40]
	ldr	r2, [r0, #36]
	ldr	lr, [r0, #48]
	ldr	r3, [r3]
	ldr	ip, [r2]
	cmp	r3, ip
	bhi	.L98
	add	r3, r1, ip
	cmp	lr, r3
	bcs	.L98
	rsb	r4, ip, lr
	cmp	r4, #0
	rsb	r3, r4, r1
	beq	.L102
	cmp	r3, #0
	beq	.L101
.L99:
	cmp	lr, r3
	moveq	r3, #0
	str	r3, [r2]
	ldr	r3, [r0, #68]
	add	r1, r3, r1
	str	r1, [r0, #68]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L98:
	cmp	r1, #0
	movne	r4, r1
	beq	.L102
.L101:
	add	r3, r4, ip
	b	.L99
.L102:
	mov	r3, ip
	b	.L99
	.fnend
	.size	RBUF_WriteDataComplete, .-RBUF_WriteDataComplete
	.align	2
	.global	RBUF_QueryInfo
	.type	RBUF_QueryInfo, %function
RBUF_QueryInfo:
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
	beq	.L116
	ldr	r3, [r0, #28]
	ldr	lr, [r0, #24]
	str	r3, [r1, #32]
	ldr	r3, [r0, #44]
	str	r3, [r1]
	ldr	r3, [r0, #48]
	str	r3, [r1, #12]
	ldr	r3, [r0, #36]
	ldr	r3, [r3]
	str	r3, [r1, #8]
	ldr	r3, [r0, #40]
	ldr	r3, [r3]
	str	r3, [r1, #4]
	ldr	r2, [r0, #40]
	ldr	r3, [r0, #36]
	ldr	ip, [r2]
	ldr	r3, [r3]
	cmp	ip, r3
	rsbls	r3, ip, r3
	strls	r3, [r1, #16]
	ldrhi	r4, [r0, #48]
	addhi	r2, r3, r4
	rsbhi	r4, ip, r4
	rsbhi	r3, ip, r2
	strhi	r4, [r1, #16]
	str	r3, [r1, #20]
	ldr	r3, [r0, #40]
	ldr	r2, [r0, #36]
	ldr	r3, [r3]
	ldr	r2, [r2]
	cmp	r3, r2
	rsbhi	r3, r2, r3
	strhi	r3, [r1, #24]
	ldrls	r0, [r0, #48]
	addls	r3, r3, r0
	rsbls	r0, r2, r0
	rsbls	r3, r2, r3
	strls	r0, [r1, #24]
	cmp	lr, r3
	str	r3, [r1, #28]
	bcs	.L117
	ldr	r2, [r1, #28]
	rsb	r3, lr, r3
	ldr	r0, [r1, #24]
	str	r3, [r1, #28]
	rsb	r2, r0, r2
	cmp	lr, r2
	strhi	r3, [r1, #24]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L117:
	mov	r3, #0
	str	r3, [r1, #24]
	str	r3, [r1, #28]
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L116:
	mov	r0, r1
	mov	r1, #36
	bl	__memzero
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	RBUF_QueryInfo, .-RBUF_QueryInfo
	.align	2
	.global	RBUF_QueryBusy
	.type	RBUF_QueryBusy, %function
RBUF_QueryBusy:
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
	ldmeqfd	sp, {fp, sp, pc}
	ldr	r3, [r0, #40]
	ldr	r2, [r0, #36]
	ldr	r3, [r3]
	ldr	r2, [r2]
	cmp	r3, r2
	rsbls	r0, r3, r2
	ldrhi	r0, [r0, #48]
	addhi	r0, r2, r0
	rsbhi	r0, r3, r0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	RBUF_QueryBusy, .-RBUF_QueryBusy
	.align	2
	.global	RBUF_QueryFree
	.type	RBUF_QueryFree, %function
RBUF_QueryFree:
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
	ldmeqfd	sp, {fp, sp, pc}
	ldr	r2, [r0, #40]
	ldr	r3, [r0, #36]
	ldr	r1, [r0, #24]
	ldr	r2, [r2]
	ldr	r3, [r3]
	cmp	r2, r3
	ldrls	r0, [r0, #48]
	addls	r2, r2, r0
	rsb	r3, r3, r2
	cmp	r1, r3
	rsbcc	r0, r1, r3
	movcs	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	RBUF_QueryFree, .-RBUF_QueryFree
	.align	2
	.global	RBUF_CheckFree
	.type	RBUF_CheckFree, %function
RBUF_CheckFree:
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
	subs	r3, r0, #0
	beq	.L134
	ldr	r0, [r3, #36]
	ldr	r2, [r3, #40]
	ldr	r4, [r3, #24]
	ldr	r2, [r2]
	ldr	ip, [r0]
	cmp	r2, ip
	rsbls	r0, r2, ip
	rsbhi	lr, ip, r2
	ldrls	lr, [r3, #48]
	ldrhi	r0, [r3, #48]
	addls	r2, r2, lr
	addhi	ip, ip, r0
	rsbls	lr, ip, r2
	rsbhi	r0, r2, ip
	cmp	r4, lr
	addcs	ip, r0, r1
	movcs	r1, #1
	bcc	.L135
.L133:
	ldr	r0, [r3, #28]
	cmp	r0, ip
	movcs	r0, r1
	orrcc	r0, r1, #1
	eor	r0, r0, #1
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L135:
	rsb	r2, r4, lr
	add	ip, r0, r1
	cmp	r1, r2
	movcc	r1, #0
	movcs	r1, #1
	b	.L133
.L134:
	mov	r0, r3
	ldmfd	sp, {r4, r5, fp, sp, pc}
	.fnend
	.size	RBUF_CheckFree, .-RBUF_CheckFree
	.align	2
	.global	RBUF_Flush
	.type	RBUF_Flush, %function
RBUF_Flush:
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
	ldrne	r2, [r0, #36]
	ldrne	r3, [r0, #40]
	ldrne	r2, [r2]
	strne	r2, [r3]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	RBUF_Flush, .-RBUF_Flush
	.align	2
	.global	RBUF_ReadDataDma
	.type	RBUF_ReadDataDma, %function
RBUF_ReadDataDma:
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
	subs	r4, r0, #0
	mov	r7, r1
	beq	.L154
	ldr	r0, [r4, #40]
	mov	ip, #0
	ldr	r1, [r4, #36]
	ldr	r3, [r4, #56]
	str	ip, [fp, #-48]
	add	r3, r3, #1
	str	r3, [r4, #56]
	ldr	r3, [r0]
	ldr	r1, [r1]
	str	ip, [fp, #-40]
	cmp	r3, r1
	str	r3, [fp, #-44]
	bhi	.L143
	add	r0, r2, r3
	cmp	r1, r0
	rsbcc	r5, r3, r1
	movcc	r6, ip
	bcc	.L144
.L156:
	mov	r5, r2
	mov	r6, ip
.L144:
	cmp	r5, #0
	beq	.L147
	cmp	r7, #0
	ldr	r1, [r4, #44]
	ldr	r9, [fp, #-44]
	beq	.L150
	add	r1, r1, r9
	mov	r2, r5
	mov	r0, r7
	bl	memcpy
	ldr	r8, [fp, #-48]
	add	r0, r7, r5
	add	r3, r5, r9
	cmp	r8, #0
	beq	.L147
	cmp	r0, #0
	ldr	r1, [r4, #44]
	ldr	r7, [fp, #-40]
	beq	.L146
	add	r1, r1, r7
	mov	r2, r8
	bl	memcpy
.L146:
	add	r3, r7, r8
.L147:
	ldr	r1, [r4, #48]
	ldr	r2, [r4, #40]
	cmp	r1, r3
	moveq	r3, #0
	adds	r0, r6, r5
	str	r3, [r2]
	ldreq	r3, [r4, #60]
	addeq	r3, r3, #1
	streq	r3, [r4, #60]
	ldr	r3, [r4, #52]
	add	r3, r3, r0
	str	r3, [r4, #52]
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L143:
	ldr	r5, [r4, #48]
	add	r0, r2, r3
	cmp	r0, r5
	bls	.L156
	rsb	r5, r3, r5
	rsb	r6, r5, r2
	cmp	r1, r6
	strcc	r1, [fp, #-48]
	movcc	r6, r1
	strcs	r6, [fp, #-48]
	b	.L144
.L150:
	ldr	r8, [fp, #-48]
	add	r3, r5, r9
	cmp	r8, #0
	ldrne	r7, [fp, #-40]
	bne	.L146
	b	.L147
.L154:
	mov	r0, r4
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
	.fnend
	.size	RBUF_ReadDataDma, .-RBUF_ReadDataDma
	.align	2
	.global	RBUF_WriteDataDma
	.type	RBUF_WriteDataDma, %function
RBUF_WriteDataDma:
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
	subs	r5, r0, #0
	mov	r8, r1
	beq	.L179
	ldr	r0, [r5, #40]
	mov	r7, #0
	ldr	r1, [r5, #36]
	ldr	r3, [r5, #72]
	str	r7, [fp, #-60]
	add	r3, r3, #1
	str	r3, [r5, #72]
	ldr	r4, [r0]
	ldr	r3, [r1]
	str	r7, [fp, #-56]
	cmp	r4, r3
	str	r7, [fp, #-48]
	str	r3, [fp, #-52]
	bls	.L188
	add	r0, r2, r3
	cmp	r4, r0
	bhi	.L170
	rsb	r4, r3, r4
	str	r7, [fp, #-68]
	str	r4, [fp, #-60]
.L169:
	cmp	r4, #0
	beq	.L174
	sub	r7, fp, #52
	sub	r10, fp, #60
	mov	r6, r4
	mov	r9, #0
.L178:
	ldr	r0, [r5, #44]
	subs	r1, r8, #0
	mov	r2, r6
	add	r0, r0, r3
	beq	.L189
	str	r3, [fp, #-64]
	bl	memcpy
	ldr	r3, [fp, #-64]
	add	r8, r8, r6
.L172:
	add	r9, r9, #1
	add	r3, r6, r3
	cmp	r9, #2
	beq	.L187
	ldr	r6, [r10, #4]!
	cmp	r6, #0
	beq	.L187
	ldr	r3, [r7, #4]!
	b	.L178
.L188:
	ldr	r4, [r5, #48]
	add	r0, r2, r3
	cmp	r4, r0
	bcs	.L170
	rsb	r4, r3, r4
	str	r4, [fp, #-60]
	rsb	r2, r4, r2
	str	r2, [fp, #-68]
	str	r2, [fp, #-56]
	b	.L169
.L187:
	ldr	r1, [r5, #36]
.L174:
	ldr	r2, [r5, #48]
	cmp	r2, r3
	ldr	r2, [fp, #-68]
	movls	r3, #0
	adds	r0, r4, r2
	str	r3, [r1]
	ldreq	r3, [r5, #76]
	addeq	r3, r3, #1
	streq	r3, [r5, #76]
	ldr	r3, [r5, #68]
	add	r3, r3, r0
	str	r3, [r5, #68]
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L189:
	cmp	r6, #0
	beq	.L172
	mov	r1, r6
	str	r3, [fp, #-64]
	bl	__memzero
	ldr	r3, [fp, #-64]
	b	.L172
.L170:
	str	r2, [fp, #-60]
	mov	r4, r2
	mov	r2, #0
	str	r2, [fp, #-68]
	b	.L169
.L179:
	mov	r0, r2
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
	.fnend
	.size	RBUF_WriteDataDma, .-RBUF_WriteDataDma
	.align	2
	.global	RBUF_CopyData
	.type	RBUF_CopyData, %function
RBUF_CopyData:
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
	cmp	r1, #0
	cmpne	r0, #0
	mov	r8, r0
	mov	r5, r2
	mov	r7, r1
	moveq	r4, #1
	movne	r4, #0
	moveq	r0, #0
	beq	.L191
	ldr	r3, [r8, #40]
	ldr	r2, [r1, #36]
	ldr	r1, [r8, #36]
	ldr	r0, [r3]
	ldr	ip, [r2]
	ldr	r10, [r7, #44]
	str	r0, [fp, #-52]
	ldr	r0, [r3]
	ldr	r1, [r1]
	ldr	r3, [r8, #44]
	cmp	r0, r1
	str	r3, [fp, #-48]
	bhi	.L192
	add	lr, r5, r0
	mov	r4, #1
	cmp	r1, lr
	bcc	.L213
.L210:
	mov	r3, r5
	mov	r0, r4
	mov	r6, #0
.L193:
	ldr	r1, [r7, #40]
	ldr	r9, [r1]
	ldr	r1, [r2]
	cmp	r9, r1
	bhi	.L194
	ldr	r9, [r7, #48]
	add	r2, r5, r1
	cmp	r9, r2
	bcc	.L214
.L208:
	cmp	r4, #0
	mov	r9, r5
	bne	.L215
.L198:
	cmp	r0, #2
	beq	.L216
.L197:
	cmp	r3, r9
	beq	.L217
	bls	.L201
	ldr	r4, [fp, #-48]
	mov	r2, r9
	ldr	r1, [fp, #-52]
	add	r0, r10, ip
	rsb	r3, r9, r3
	str	r3, [fp, #-56]
	add	r1, r4, r1
	bl	memcpy
	ldr	r1, [fp, #-52]
	ldr	r2, [fp, #-56]
	mov	r0, r10
	add	r1, r9, r1
	mov	r9, r4
	add	r1, r4, r1
	add	r4, r2, r6
	bl	memcpy
	ldr	r3, [fp, #-56]
	mov	r2, r6
	mov	r1, r9
	add	r0, r10, r3
	bl	memcpy
.L199:
	ldr	r1, [r8, #48]
	mov	r0, r5
	ldr	r3, [r8, #40]
	cmp	r1, r6
	ldr	r2, [r7, #48]
	moveq	r6, #0
	str	r6, [r3]
	ldr	r3, [r7, #36]
	cmp	r2, r4
	moveq	r4, #0
	str	r4, [r3]
.L191:
	sub	sp, fp, #40
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, r10, fp, sp, pc}
.L192:
	ldr	lr, [r8, #48]
	add	r6, r5, r0
	cmp	r6, lr
	bhi	.L218
	mov	r4, #1
	b	.L210
.L194:
	add	r2, r5, r1
	cmp	r9, r2
	rsbls	r9, r1, r9
	bhi	.L208
	cmp	r4, #0
	beq	.L198
.L215:
	ldr	r2, [fp, #-48]
	add	r0, r10, ip
	ldr	r3, [fp, #-52]
	add	r4, r5, ip
	add	r1, r2, r3
	mov	r2, r5
	add	r6, r5, r3
	bl	memcpy
	b	.L199
.L214:
	cmp	r4, #0
	rsb	r9, r1, r9
	rsb	r4, r9, r5
	beq	.L197
	ldr	r3, [fp, #-52]
	mov	r2, r9
	add	r0, r10, ip
	add	r6, r3, r9
	ldr	r9, [fp, #-48]
	add	r1, r9, r3
	bl	memcpy
	add	r1, r9, r6
	mov	r0, r10
	mov	r2, r4
	add	r6, r4, r6
	bl	memcpy
	b	.L199
.L218:
	rsb	r3, r0, lr
	mov	r0, #2
	rsb	r6, r3, r5
	cmp	r6, r1
	movcs	r6, r1
	b	.L193
.L213:
	rsb	r3, r0, r1
	mov	r6, #0
	mov	r0, r4
	b	.L193
.L216:
	ldr	r9, [fp, #-48]
	add	r4, r3, ip
	ldr	r1, [fp, #-52]
	mov	r2, r3
	add	r0, r10, ip
	add	r1, r9, r1
	bl	memcpy
	add	r0, r10, r4
	mov	r1, r9
	mov	r2, r6
	add	r4, r4, r6
	bl	memcpy
	b	.L199
.L201:
	ldr	r6, [fp, #-48]
	mov	r2, r3
	ldr	r1, [fp, #-52]
	add	r0, r10, ip
	rsb	r9, r3, r9
	str	r3, [fp, #-52]
	add	r1, r6, r1
	str	ip, [fp, #-48]
	bl	memcpy
	ldr	ip, [fp, #-48]
	ldr	r3, [fp, #-52]
	mov	r2, r9
	mov	r1, r6
	str	r6, [fp, #-48]
	add	r0, r3, ip
	add	r6, r9, r4
	add	r0, r10, r0
	bl	memcpy
	ldr	r3, [fp, #-48]
	mov	r2, r4
	mov	r0, r10
	add	r1, r3, r9
	bl	memcpy
	b	.L199
.L217:
	ldr	r9, [fp, #-48]
	mov	r2, r3
	ldr	r1, [fp, #-52]
	add	r0, r10, ip
	mov	r6, r4
	add	r1, r9, r1
	bl	memcpy
	mov	r2, r4
	mov	r1, r9
	mov	r0, r10
	bl	memcpy
	b	.L199
	.fnend
	.size	RBUF_CopyData, .-RBUF_CopyData
	.align	2
	.global	RBUF_GetCompressInfo
	.type	RBUF_GetCompressInfo, %function
RBUF_GetCompressInfo:
	.fnstart


	.movsp ip
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	.pad #4
	.save {r4, r5, r6, r7, fp, ip, lr}
	.setfp fp, ip, #-4
	sub	fp, ip, #4
	.pad #24
	sub	sp, sp, #24
	push	{lr}
	bl	__gnu_mcount_nc
	cmp	r0, #0
	streq	r0, [r1]
	streq	r0, [r2]
	beq	.L219
	add	r3, r0, #40
	ldmia	r3, {r3, r4, r5}
	ldr	lr, [r3]
	add	r3, lr, #2
	cmp	r3, r5
	ldrh	ip, [r4, lr]
	movcs	r3, #0
	cmp	ip, #0
	add	r5, r4, r3
	beq	.L227
	movw	r6, #65535
	cmp	ip, r6
	beq	.L224
	ldrh	r6, [r5]
	cmp	ip, r6
	bhi	.L228
.L224:
	str	ip, [r1]
	movw	r6, #65535
	ldrh	r7, [r4, lr]
	cmp	r7, r6
	beq	.L229
	ldrh	r3, [r5]
	movw	r1, #63602
	movt	r1, 65535
	movw	r0, #19999
	rsb	ip, ip, r3
	str	ip, [r2]
	strh	r1, [r4, lr]
	strh	r0, [r5]
.L219:
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L229:
	mov	ip, #0
	str	ip, [r1]
	ldrh	r1, [r5]
	add	r3, r3, #2
	str	r1, [r2]
	ldr	r1, [r0, #48]
	ldr	r2, [r0, #40]
	cmp	r3, r1
	movcs	r3, ip
	str	r3, [r2]
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L228:
	ldr	r2, .L230
	movw	r3, #810
	str	ip, [sp, #16]
	mov	r1, #26
	str	ip, [sp, #12]
	mov	r0, #1
	stmia	sp, {r2, r6}
	str	r6, [sp, #8]
	ldr	r2, .L230+4
	bl	HI_LogOut
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L227:
	ldr	lr, .L230+8
	movw	r3, #802
	str	ip, [sp, #4]
	mov	r1, #26
	ldr	r2, .L230+4
	mov	r0, #1
	str	lr, [sp]
	bl	HI_LogOut
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L231:
	.align	2
.L230:
	.word	.LC1
	.word	.LANCHOR0
	.word	.LC0
	.fnend
	.size	RBUF_GetCompressInfo, .-RBUF_GetCompressInfo
	.align	2
	.global	RBUF_UpdateAttr
	.type	RBUF_UpdateAttr, %function
RBUF_UpdateAttr:
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
	ldrne	r3, [r1, #32]
	strne	r3, [r0, #32]
	ldrne	r3, [r1, #28]
	strne	r3, [r0, #28]
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	RBUF_UpdateAttr, .-RBUF_UpdateAttr
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	__func__.25936, %object
	.size	__func__.25936, 25
__func__.25936:
	.ascii	"CIRC_BUF_GetCompressInfo\000"
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"error: Pa(%d) <= 0\012\000"
.LC1:
	.ascii	"error: Pb(%d %#x) < Pa(%d %#x)\012\000"
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
