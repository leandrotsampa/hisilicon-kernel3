/*
 * Low-level user helpers placed in the vectors page for AArch32.
 * Based on the kuser helpers in arch/arm/kernel/entry-armv.S.
 *
 * Copyright (C) 2005-2011 Nicolas Pitre <nico@fluxnic.net>
 * Copyright (C) 2012 ARM Ltd.
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
 *
 *
 * AArch32 user helpers.
 *
 * Each segment is 32-byte aligned and will be moved to the top of the high
 * vector page.  New segments (if ever needed) must be added in front of
 * existing ones.  This mechanism should be used only for things that are
 * really small and justified, and not be abused freely.
 *
 * See Documentation/arm/kernel_user_helpers.txt for formal definitions.
 */

#include <asm/unistd.h>

	.align	5
	.globl	__kuser_helper_start
__kuser_helper_start:

__kuser_cmpxchg64:		
	.inst	0xe92d00f0	
	.inst	0xe1c040d0	
	.inst	0xe1c160d0	
	.inst	0xe1b20f9f	
	.inst	0xe0303004	
	.inst	0x00313005	
	.inst	0x01a23e96	
	.inst	0x03330001	
	.inst	0x0afffff9	
	.inst	0xf57ff05b	
	.inst	0xe2730000	
	.inst	0xe8bd00f0	
	.inst	0xe12fff1e	

	.align	5
__kuser_memory_barrier:		
	.inst	0xf57ff05b	
	.inst	0xe12fff1e	

	.align	5
__kuser_cmpxchg:		
	.inst	0xe1923f9f	
	.inst	0xe0533000	
	.inst	0x01823e91	
	.inst	0x03330001	
	.inst	0x0afffffa	
	.inst	0xf57ff05b	
	.inst	0xe2730000	
	.inst	0xe12fff1e	

	.align	5
__kuser_get_tls:		
	.inst	0xee1d0f70	
	.inst	0xe12fff1e	
	.rep	5
	.word	0
	.endr

__kuser_helper_version:		
	.word	((__kuser_helper_end - __kuser_helper_start) >> 5)
	.globl	__kuser_helper_end
__kuser_helper_end:

/*
 * AArch32 sigreturn code
 *
 * For ARM syscalls, the syscall number has to be loaded into r7.
 * We do not support an OABI userspace.
 *
 * For Thumb syscalls, we also pass the syscall number via r7. We therefore
 * need two 16-bit instructions.
 */
	.globl __aarch32_sigret_code_start
__aarch32_sigret_code_start:

	/*
	 * ARM Code
	 */
	.byte	__NR_compat_sigreturn, 0x70, 0xa0, 0xe3
	.byte	__NR_compat_sigreturn, 0x00, 0x00, 0xef

	/*
	 * Thumb code
	 */
	.byte	__NR_compat_sigreturn, 0x27		
	.byte	__NR_compat_sigreturn, 0xdf		

	/*
	 * ARM code
	 */
	.byte	__NR_compat_rt_sigreturn, 0x70, 0xa0, 0xe3
	.byte	__NR_compat_rt_sigreturn, 0x00, 0x00, 0xef

	/*
	 * Thumb code
	 */
	.byte	__NR_compat_rt_sigreturn, 0x27		
	.byte	__NR_compat_rt_sigreturn, 0xdf		

        .globl __aarch32_sigret_code_end
__aarch32_sigret_code_end:
