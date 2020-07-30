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
	.file	"dsp_mem.c"

	.text
	.align	2
	.global	HI_ADSP_MALLOC
	.type	HI_ADSP_MALLOC, %function
HI_ADSP_MALLOC:
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
	mov	r0, r1
	mov	r1, #208
	bl	__kmalloc
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HI_ADSP_MALLOC, .-HI_ADSP_MALLOC
	.align	2
	.global	HI_ADSP_FREE
	.type	HI_ADSP_FREE, %function
HI_ADSP_FREE:
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
	subs	r0, r1, #0
	ldmeqfd	sp, {fp, sp, pc}
	bl	kfree
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HI_ADSP_FREE, .-HI_ADSP_FREE
	.align	2
	.global	HI_ADSP_V_MALLOC
	.type	HI_ADSP_V_MALLOC, %function
HI_ADSP_V_MALLOC:
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
	mov	r0, r1
	bl	vmalloc
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HI_ADSP_V_MALLOC, .-HI_ADSP_V_MALLOC
	.align	2
	.global	HI_ADSP_V_FREE
	.type	HI_ADSP_V_FREE, %function
HI_ADSP_V_FREE:
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
	subs	r0, r1, #0
	ldmeqfd	sp, {fp, sp, pc}
	bl	vfree
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HI_ADSP_V_FREE, .-HI_ADSP_V_FREE
	.global	__aeabi_uidivmod
	.align	2
	.global	HI_ADSP_MALLOC_Aligned
	.type	HI_ADSP_MALLOC_Aligned, %function
HI_ADSP_MALLOC_Aligned:
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
	sub	r3, r2, #4
	cmp	r3, #252
	mov	r4, r2
	mov	r7, r0
	mov	r6, r1
	bhi	.L19
	cmp	r2, #1
	bls	.L21
	mov	r3, #0
.L18:
	add	r3, r3, #1
	mov	ip, r4, lsr r3
	cmp	ip, #1
	bhi	.L18
	mvn	r5, #0
	mov	r5, r5, asl r3
	bics	r3, r4, r5
	bne	.L19
.L17:
	cmp	r4, r6
	bcs	.L20
	mov	r1, r4
	mov	r0, r6
	bl	__aeabi_uidivmod
	cmp	r1, #0
	bne	.L19
.L20:
	add	r1, r4, r6
	mov	r0, r7
	bl	HI_ADSP_MALLOC
	cmp	r0, #0
	beq	.L19
	add	r4, r0, r4
	and	r4, r4, r5
	rsb	r3, r0, r4
	mov	r0, r4
	strb	r3, [r4, #-1]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L19:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L21:
	mvn	r5, #0
	b	.L17
	.fnend
	.size	HI_ADSP_MALLOC_Aligned, .-HI_ADSP_MALLOC_Aligned
	.align	2
	.global	HI_ADSP_FREE_Aligned
	.type	HI_ADSP_FREE_Aligned, %function
HI_ADSP_FREE_Aligned:
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
	ldmeqfd	sp, {fp, sp, pc}
	ldrb	r0, [r1, #-1]
	subs	r0, r1, r0
	ldmeqfd	sp, {fp, sp, pc}
	bl	kfree
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HI_ADSP_FREE_Aligned, .-HI_ADSP_FREE_Aligned
	.align	2
	.global	HI_ADSP_VMALLOC_Aligned
	.type	HI_ADSP_VMALLOC_Aligned, %function
HI_ADSP_VMALLOC_Aligned:
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
	sub	r3, r2, #4
	cmp	r3, #252
	mov	r4, r2
	mov	r6, r1
	bhi	.L39
	cmp	r2, #1
	bls	.L41
	mov	r3, #0
.L38:
	add	r3, r3, #1
	mov	ip, r4, lsr r3
	cmp	ip, #1
	bhi	.L38
	mvn	r5, #0
	mov	r5, r5, asl r3
	bics	r3, r4, r5
	bne	.L39
.L37:
	cmp	r4, r6
	bcs	.L40
	mov	r1, r4
	mov	r0, r6
	bl	__aeabi_uidivmod
	cmp	r1, #0
	bne	.L39
.L40:
	add	r0, r4, r6
	bl	vmalloc
	cmp	r0, #0
	beq	.L39
	add	r4, r0, r4
	and	r4, r4, r5
	rsb	r3, r0, r4
	mov	r0, r4
	strb	r3, [r4, #-1]
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L39:
	mov	r0, #0
	ldmfd	sp, {r4, r5, r6, r7, fp, sp, pc}
.L41:
	mvn	r5, #0
	b	.L37
	.fnend
	.size	HI_ADSP_VMALLOC_Aligned, .-HI_ADSP_VMALLOC_Aligned
	.align	2
	.global	HI_ADSP_VFREE_Aligned
	.type	HI_ADSP_VFREE_Aligned, %function
HI_ADSP_VFREE_Aligned:
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
	ldmeqfd	sp, {fp, sp, pc}
	ldrb	r0, [r1, #-1]
	subs	r0, r1, r0
	ldmeqfd	sp, {fp, sp, pc}
	bl	vfree
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	HI_ADSP_VFREE_Aligned, .-HI_ADSP_VFREE_Aligned
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
