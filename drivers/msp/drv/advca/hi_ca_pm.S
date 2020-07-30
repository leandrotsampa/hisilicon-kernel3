/*
** This routing:
** 1. load the ddr_wakeup_check.bin into SRAM of ARM
** 2. jump pc to SRAM to execute upper ddr_wakeup_check.bin
** 3. ddr_wakeup_check.bin will check ddr_wakeup_check flag, if so, calculate sha1 of DDR Content.
** 4. set the MCU_SUSPEND_FLAG supsend flag to SC_GEN15, then C51(MCU) will suspend the HOSTCPU(ARM).
**
*/

#include <mach/platform.h>
#include <mach/hardware.h>
#include <asm/memory.h>
#include <linux/linkage.h>



ENTRY (hi_ca_pm_sleep)


	ldr	r0, = _ddr_wakeup_check_code_begin
	ldr	r0, [r0]                     /* r0 store source start add */
	ldr	r1, =hi_sram_virtbase
	ldr 	r1, [r1]                 /* r1 store RAM base add */
	ldr	r2, = _ddr_wakeup_check_code_end
	ldr	r2, [r2]                     /* r2 store source end add */
	
loop_copy_to_ddr:                   
	ldmia	r0!, {r3-r10}            /* load source code from r0 to r3~r10, r0 = r0 + 8*/
	stmia	r1!, {r3-r10}            /* store r3~r10 to ram r1, r1 = r1 + 8*/
	cmp	r0,r2                        /* compare r0 with r2*/
	ble	loop_copy_to_ddr             /* if r0 < r2 , jump to loop_copy_to_ddr, else come to next step */

	ldr	r2, =SRAM_BASE_ADDRESS

	@disable mmu
	mrc	p15, 0, r1, c1, c0, 0
	bic	r1, #1
	mcr	p15, 0, r1, c1, c0, 0

	bx	r2  /*jump to SRAM code:SRAM_BASE_ADDRESS to exute*/
	b .
	b .
	NOP
	NOP
	NOP
ENDPROC(hi_ca_pm_sleep)


/* Gloal vairable */
.global _ca_pm_code_begin
_ca_pm_code_begin:
.incbin WAKE_UP_BIN
.global _ca_pm_code_end
_ca_pm_code_end:

.global hi_sram_virtbase
hi_sram_virtbase:
.word hi_sram_virtbase

.global _ddr_wakeup_check_code_begin
_ddr_wakeup_check_code_begin:
.word _ddr_wakeup_check_code_begin

.global _ddr_wakeup_check_code_end
_ddr_wakeup_check_code_end:
.word _ddr_wakeup_check_code_end
