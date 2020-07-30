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
	.file	"system_timer.c"

	.text
	.align	2
	.type	TimerSwFunc, %function
TimerSwFunc:
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
	ldr	r3, .L8
	ldr	r2, [r3]
	cmp	r2, #2
	beq	.L7
.L2:
	mov	r0, #5
	bl	msecs_to_jiffies
	ldr	r3, .L8+4
	ldr	r1, [r3]
	add	r1, r0, r1
	ldr	r0, .L8+8
	bl	mod_timer
	ldmfd	sp, {fp, sp, pc}
.L7:
	ldr	r3, [r3, #4]
	cmp	r3, #0
	beq	.L2
	blx	r3
	b	.L2
.L9:
	.align	2
.L8:
	.word	.LANCHOR0
	.word	jiffies
	.word	.LANCHOR0+8
	.fnend
	.size	TimerSwFunc, .-TimerSwFunc
	.align	2
	.global	TIMER_RegIsrFunc
	.type	TIMER_RegIsrFunc, %function
TIMER_RegIsrFunc:
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
	ldr	r3, .L11
	str	r0, [r3, #4]
	ldmfd	sp, {fp, sp, pc}
.L12:
	.align	2
.L11:
	.word	.LANCHOR0
	.fnend
	.size	TIMER_RegIsrFunc, .-TIMER_RegIsrFunc
	.align	2
	.global	TIMER_DelIsrFunc
	.type	TIMER_DelIsrFunc, %function
TIMER_DelIsrFunc:
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
	ldr	r3, .L14
	mov	r2, #0
	str	r2, [r3, #4]
	ldmfd	sp, {fp, sp, pc}
.L15:
	.align	2
.L14:
	.word	.LANCHOR0
	.fnend
	.size	TIMER_DelIsrFunc, .-TIMER_DelIsrFunc
	.align	2
	.global	TIMER_SetEnable
	.type	TIMER_SetEnable, %function
TIMER_SetEnable:
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
	ldr	r3, .L17
	mov	r2, #2
	str	r2, [r3]
	ldmfd	sp, {fp, sp, pc}
.L18:
	.align	2
.L17:
	.word	.LANCHOR0
	.fnend
	.size	TIMER_SetEnable, .-TIMER_SetEnable
	.align	2
	.global	TIMER_SetDisable
	.type	TIMER_SetDisable, %function
TIMER_SetDisable:
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
	ldr	r3, .L20
	mov	r2, #3
	str	r2, [r3]
	ldmfd	sp, {fp, sp, pc}
.L21:
	.align	2
.L20:
	.word	.LANCHOR0
	.fnend
	.size	TIMER_SetDisable, .-TIMER_SetDisable
	.align	2
	.global	TIMER_Init
	.type	TIMER_Init, %function
TIMER_Init:
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
	ldr	r4, .L23
	mov	r0, #0
	mov	ip, #1
	mov	r2, r0
	mov	r1, r0
	mov	r5, r4
	mov	r3, r0
	str	ip, [r5], #8
	str	r0, [r4, #4]
	mov	r0, r5
	bl	init_timer_key
	ldr	r3, .L23+4
	mov	r0, #5
	str	r3, [r4, #24]
	bl	msecs_to_jiffies
	ldr	r3, .L23+8
	ldr	r3, [r3]
	add	r3, r0, r3
	mov	r0, r5
	str	r3, [r4, #16]
	bl	add_timer
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L24:
	.align	2
.L23:
	.word	.LANCHOR0
	.word	TimerSwFunc
	.word	jiffies
	.fnend
	.size	TIMER_Init, .-TIMER_Init
	.align	2
	.global	TIMER_DeInit
	.type	TIMER_DeInit, %function
TIMER_DeInit:
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
	ldr	r2, .L26
	mov	r3, #0
	mov	r0, r2
	str	r3, [r2, #4]
	str	r3, [r0], #8
	bl	del_timer
	ldmfd	sp, {fp, sp, pc}
.L27:
	.align	2
.L26:
	.word	.LANCHOR0
	.fnend
	.size	TIMER_DeInit, .-TIMER_DeInit
	.bss
	.align	2
.LANCHOR0 = . + 0
	.type	g_Timer_Status, %object
	.size	g_Timer_Status, 4
g_Timer_Status:
	.space	4
	.type	g_TIMERRm, %object
	.size	g_TIMERRm, 4
g_TIMERRm:
	.space	4
	.type	g_timer_cast, %object
	.size	g_timer_cast, 28
g_timer_cast:
	.space	28
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
