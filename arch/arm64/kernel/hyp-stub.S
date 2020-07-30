/*
 * Hypervisor stub
 *
 * Copyright (C) 2012 ARM Ltd.
 * Author:	Marc Zyngier <marc.zyngier@arm.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <linux/init.h>
#include <linux/linkage.h>
#include <linux/irqchip/arm-gic-v3.h>

#include <asm/assembler.h>
#include <asm/ptrace.h>
#include <asm/virt.h>

	.text
	.align 11

ENTRY(__hyp_stub_vectors)
	ventry	el2_sync_invalid	
	ventry	el2_irq_invalid		
	ventry	el2_fiq_invalid		
	ventry	el2_error_invalid	

	ventry	el2_sync_invalid	
	ventry	el2_irq_invalid		
	ventry	el2_fiq_invalid		
	ventry	el2_error_invalid	

	ventry	el1_sync		
	ventry	el1_irq_invalid		
	ventry	el1_fiq_invalid		
	ventry	el1_error_invalid	

	ventry	el1_sync_invalid	
	ventry	el1_irq_invalid		
	ventry	el1_fiq_invalid		
	ventry	el1_error_invalid	
ENDPROC(__hyp_stub_vectors)

	.align 11

el1_sync:
	mrs	x1, esr_el2
	lsr	x1, x1, #26
	cmp	x1, #0x16
	b.ne	2f			
	cbz	x0, 1f
	msr	vbar_el2, x0		
	b	2f
1:	mrs	x0, vbar_el2		
2:	eret
ENDPROC(el1_sync)

.macro invalid_vector	label
\label:
	b \label
ENDPROC(\label)
.endm

	invalid_vector	el2_sync_invalid
	invalid_vector	el2_irq_invalid
	invalid_vector	el2_fiq_invalid
	invalid_vector	el2_error_invalid
	invalid_vector	el1_sync_invalid
	invalid_vector	el1_irq_invalid
	invalid_vector	el1_fiq_invalid
	invalid_vector	el1_error_invalid

/*
 * __hyp_set_vectors: Call this after boot to set the initial hypervisor
 * vectors as part of hypervisor installation.  On an SMP system, this should
 * be called on each CPU.
 *
 * x0 must be the physical address of the new vector table, and must be
 * 2KB aligned.
 *
 * Before calling this, you must check that the stub hypervisor is installed
 * everywhere, by waiting for any secondary CPUs to be brought up and then
 * checking that is_hyp_mode_available() is true.
 *
 * If not, there is a pre-existing hypervisor, some CPUs failed to boot, or
 * something else went wrong... in such cases, trying to install a new
 * hypervisor is unlikely to work as desired.
 *
 * When you call into your shiny new hypervisor, sp_el2 will contain junk,
 * so you will need to set that to something sensible at the new hypervisor's
 * initialisation entry point.
 */

ENTRY(__hyp_get_vectors)
	mov	x0, xzr

ENTRY(__hyp_set_vectors)
	hvc	#0
	ret
ENDPROC(__hyp_get_vectors)
ENDPROC(__hyp_set_vectors)
