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
	.file	"aoe_reg.c"

	.text
	.align	2
	.global	AOE_REG_ReadBitDepth
	.type	AOE_REG_ReadBitDepth, %function
AOE_REG_ReadBitDepth:
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
	cmp	r1, #1
	beq	.L3
	bcc	.L4
	cmp	r1, #2
	beq	.L5
	mvn	r3, #0
	mov	r2, #0
	str	r2, [r0]
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L5:
	mov	r3, #0
	mov	r2, #24
	str	r2, [r0]
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L4:
	mov	r3, #0
	mov	r2, #8
	str	r2, [r0]
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L3:
	mov	r3, #0
	mov	r2, #16
	str	r2, [r0]
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	AOE_REG_ReadBitDepth, .-AOE_REG_ReadBitDepth
	.align	2
	.global	AOE_REG_ReadChannel
	.type	AOE_REG_ReadChannel, %function
AOE_REG_ReadChannel:
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
	cmp	r1, #1
	beq	.L12
	bcc	.L13
	cmp	r1, #3
	beq	.L14
	mvn	r3, #0
	mov	r2, #0
	str	r2, [r0]
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L14:
	mov	r3, #0
	mov	r2, #8
	str	r2, [r0]
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L13:
	mov	r3, #0
	mov	r2, #1
	str	r2, [r0]
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L12:
	mov	r3, #0
	mov	r2, #2
	str	r2, [r0]
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	AOE_REG_ReadChannel, .-AOE_REG_ReadChannel
	.align	2
	.global	AOE_REG_ReadPcmType
	.type	AOE_REG_ReadPcmType, %function
AOE_REG_ReadPcmType:
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
	cmp	r1, #4
	strls	r1, [r0]
	movls	r0, #0
	mvnhi	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	AOE_REG_ReadPcmType, .-AOE_REG_ReadPcmType
	.align	2
	.global	AOE_REG_ReadSampelRate
	.type	AOE_REG_ReadSampelRate, %function
AOE_REG_ReadSampelRate:
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
	cmp	r1, #12
	ldrls	r2, .L24
	movls	r3, #0
	mvnhi	r3, #0
	ldrls	r2, [r2, r1, asl #2]
	strls	r2, [r0]
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
.L25:
	.align	2
.L24:
	.word	.LANCHOR0
	.fnend
	.size	AOE_REG_ReadSampelRate, .-AOE_REG_ReadSampelRate
	.align	2
	.global	AOE_REG_ReadDataFormat
	.type	AOE_REG_ReadDataFormat, %function
AOE_REG_ReadDataFormat:
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
	str	r1, [r0]
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	AOE_REG_ReadDataFormat, .-AOE_REG_ReadDataFormat
	.align	2
	.global	AOE_REG_ReadBufLatencyMs
	.type	AOE_REG_ReadBufLatencyMs, %function
AOE_REG_ReadBufLatencyMs:
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
	str	r1, [r0]
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	AOE_REG_ReadBufLatencyMs, .-AOE_REG_ReadBufLatencyMs
	.align	2
	.global	AOE_REG_ReadBufDelayMs
	.type	AOE_REG_ReadBufDelayMs, %function
AOE_REG_ReadBufDelayMs:
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
	str	r1, [r0]
	mov	r0, #0
	ldmfd	sp, {fp, sp, pc}
	.fnend
	.size	AOE_REG_ReadBufDelayMs, .-AOE_REG_ReadBufDelayMs
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	g_u32AoeSampleRateTab, %object
	.size	g_u32AoeSampleRateTab, 52
g_u32AoeSampleRateTab:
	.word	8000
	.word	11025
	.word	12000
	.word	16000
	.word	22050
	.word	24000
	.word	32000
	.word	44100
	.word	48000
	.word	88200
	.word	96000
	.word	176400
	.word	192000
	.ident	"GCC: (gcc-4.9.2 + glibc-2.22 (Build by czyong) Tue Oct 27 16:32:03 CST 2015) 4.9.2 20140904 (prerelease)"
	.section	.note.GNU-stack,"",%progbits
