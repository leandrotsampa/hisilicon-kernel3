#include <mach/platform.h>

	.macro  addruart, rp, rv, tmp
	ldr	\rp, =CONFIG_DEFAULT_UART_BASE_ADDR @physical base
	ldr	\rv, =0xFEC00000
	.endm

#include <debug/pl01x.S>
