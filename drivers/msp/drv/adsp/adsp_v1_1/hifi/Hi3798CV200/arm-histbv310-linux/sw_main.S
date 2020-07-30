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
	.file	"sw_main.c"

	.text
	.align	2
	.type	AoEngineTask, %function
AoEngineTask:
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
	mov	r3, sp
	bic	r9, r3, #8128
	bic	r8, r9, #63
	mov	r1, #2
	ldr	r2, [r8, #12]
	ldr	r3, [r2, #12]
	orr	r3, r3, #32768
	str	r3, [r2, #12]
	ldr	r3, [r8, #12]
	str	r1, [r3]
#APP
	dmb ish
	ldr	r5, .L9
	movw	r6, #19264
	movt	r6, 76
	mov	r7, #0
	bl	AOE_Init
	movw	r3, #42405
	mov	r2, #0
	bfi	r3, r3, #16, #16
	stmia	r5, {r2, r3}
.L3:
	ldr	r4, [r5, #8]
	cmp	r4, #1
	bne	.L8
.L4:
	bl	AOE_ProcThread_Sw
	bl	AOE_GetThreadStatus
	sub	r3, fp, #36
	mov	r2, #2
	cmp	r0, #1
	beq	.L3
	ldr	r1, [r8, #12]
	strd	r6, [r3, #-8]!
	str	r2, [r1]
#APP
	dmb ish
	mov	r1, r4
	mov	r0, r3
	bl	schedule_hrtimeout
	ldr	r4, [r5, #8]
	cmp	r4, #1
	beq	.L4
.L8:
	bic	r9, r9, #63
	mov	r4, #0
	ldr	r3, [r9, #12]
	str	r4, [r3]
#APP
	dmb ish
	bl	AOE_DeInit
	mov	r0, r4
	sub	sp, fp, #36
	ldmfd	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
.L10:
	.align	2
.L9:
	.word	.LANCHOR0
	.fnend
	.size	AoEngineTask, .-AoEngineTask
	.align	2
	.global	AOE_SwEngineCreate
	.type	AOE_SwEngineCreate, %function
AOE_SwEngineCreate:
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
	ldr	r5, .L20
	mov	ip, #0
	ldr	r3, .L20+4
	mov	r1, ip
	mvn	r2, #0
	ldr	r0, .L20+8
	mov	r4, #1
	str	ip, [r5, #4]
	str	r4, [r5, #8]
	bl	kthread_create_on_node
	cmn	r0, #4096
	str	r0, [r5, #12]
	bhi	.L16
	bl	wake_up_process
	bl	TIMER_Init
	bl	TIMER_SetEnable
	ldr	r2, [r5, #4]
	movw	r3, #42405
	movt	r3, 42405
	cmp	r2, r3
	beq	.L14
	mov	r0, r4
	movw	r4, #511
	bl	msleep
	b	.L15
.L19:
	bl	msleep
	subs	r4, r4, #1
	beq	.L14
.L15:
	ldr	r2, [r5, #4]
	movw	r3, #42405
	movt	r3, 42405
	mov	r0, #1
	cmp	r2, r3
	bne	.L19
.L14:
	mov	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L16:
	mvn	r0, #0
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L21:
	.align	2
.L20:
	.word	.LANCHOR0
	.word	.LC0
	.word	AoEngineTask
	.fnend
	.size	AOE_SwEngineCreate, .-AOE_SwEngineCreate
	.align	2
	.global	AOE_SwEngineDestory
	.type	AOE_SwEngineDestory, %function
AOE_SwEngineDestory:
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
	ldr	r3, .L23
	mov	r4, #0
	str	r4, [r3, #8]
	bl	TIMER_SetDisable
	bl	TIMER_DeInit
	mov	r0, #10
	bl	msleep
	mov	r0, r4
	ldmfd	sp, {r4, r5, fp, sp, pc}
.L24:
	.align	2
.L23:
	.word	.LANCHOR0
	.fnend
	.size	AOE_SwEngineDestory, .-AOE_SwEngineDestory
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"AoEngineTask\000"
	.bss
	.align	2
.LANCHOR0 = . + 0
	.type	task_bug.26353, %object
	.size	task_bug.26353, 4
task_bug.26353:
	.space	4
	.type	g_AoeRunningFlag, %object
	.size	g_AoeRunningFlag, 4
g_AoeRunningFlag:
	.space	4
	.type	g_AoeTaskstate, %object
	.size	g_AoeTaskstate, 4
g_AoeTaskstate:
	.space	4
	.type	g_pstAOEThread, %object
	.size	g_pstAOEThread, 4
g_pstAOEThread:
	.space	4
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
