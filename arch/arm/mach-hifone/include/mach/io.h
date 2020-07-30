#ifndef __ASM_ARM_ARCH_IO_H
#define __ASM_ARM_ARCH_IO_H

#include <asm/pgtable.h>

#define IO_SPACE_LIMIT 0xffffffff

#define __io(a)		__typesafe_io(a)
#define __mem_pci(a)	(a)

/*  phys_addr		virt_addr 
 * 0xF800_0000 <-----> 0xFD00_0000
 */
 /*
#define S40_IOCH1_VIRT	(0xF6000000)
#define S40_IOCH1_PHYS	(0xF1000000)
#define S40_IOCH1_SIZE	(0x09000000)
*/
/* SZ_2M for fixed pci io space  */
#define HIFONE_IOCH1_VIRT	(VMALLOC_END - SZ_2M - HIFONE_IOCH1_SIZE)//0xFED90000
#define HIFONE_IOCH1_PHYS	(0xF9C00000)
#define HIFONE_IOCH1_SIZE	(0x70000)

#define HIFONE_IOCH2_VIRT	(HIFONE_IOCH1_VIRT - HIFONE_IOCH2_SIZE)
#define HIFONE_IOCH2_PHYS	(0xF9A00000)
#define HIFONE_IOCH2_SIZE	(0xB0000)

#define HIFONE_IOCH3_VIRT	(HIFONE_IOCH2_VIRT - HIFONE_IOCH3_SIZE)
#define HIFONE_IOCH3_PHYS	(0xF9800000)
#define HIFONE_IOCH3_SIZE	(0x150000)

#define HIFONE_IOCH4_VIRT	(HIFONE_IOCH3_VIRT - HIFONE_IOCH4_SIZE)
#define HIFONE_IOCH4_PHYS	(0xF9200000)
#define HIFONE_IOCH4_SIZE	(0x40000)

#define HIFONE_IOCH5_VIRT	(HIFONE_IOCH4_VIRT - HIFONE_IOCH5_SIZE)
#define HIFONE_IOCH5_PHYS	(0xF8C10000)
#define HIFONE_IOCH5_SIZE	(0x120000)

#define HIFONE_IOCH6_VIRT	(HIFONE_IOCH5_VIRT - HIFONE_IOCH6_SIZE)
#define HIFONE_IOCH6_PHYS	(0xF8B00000)
#define HIFONE_IOCH6_SIZE	(0x30000)

#define HIFONE_IOCH7_VIRT	(HIFONE_IOCH6_VIRT - HIFONE_IOCH7_SIZE)
#define HIFONE_IOCH7_PHYS	(0xF8A20000)
#define HIFONE_IOCH7_SIZE	(0xA0000)

#define HIFONE_IOCH8_VIRT	(HIFONE_IOCH7_VIRT - HIFONE_IOCH8_SIZE)
#define HIFONE_IOCH8_PHYS	(0xF8000000)
#define HIFONE_IOCH8_SIZE	(0x7000)

#define HIFONE_IOCH9_VIRT	(HIFONE_IOCH8_VIRT - HIFONE_IOCH9_SIZE)
#define HIFONE_IOCH9_PHYS	(0xF1000000)
#define HIFONE_IOCH9_SIZE	(0x10000)

#define DEFAULT_UART_BASE_ADDR_V	HIFONE_IOCH6_VIRT

#define __IO_ADDRESS1(x) ((x >= HIFONE_IOCH1_PHYS) ? ((x) + HIFONE_IOCH1_VIRT - HIFONE_IOCH1_PHYS) : (__IO_ADDRESS2(x)))
#define __IO_ADDRESS2(x) ((x >= HIFONE_IOCH2_PHYS) ? ((x) + HIFONE_IOCH2_VIRT - HIFONE_IOCH2_PHYS) : (__IO_ADDRESS3(x)))
#define __IO_ADDRESS3(x) ((x >= HIFONE_IOCH3_PHYS) ? ((x) + HIFONE_IOCH3_VIRT - HIFONE_IOCH3_PHYS) : (__IO_ADDRESS4(x)))
#define __IO_ADDRESS4(x) ((x >= HIFONE_IOCH4_PHYS) ? ((x) + HIFONE_IOCH4_VIRT - HIFONE_IOCH4_PHYS) : (__IO_ADDRESS5(x)))
#define __IO_ADDRESS5(x) ((x >= HIFONE_IOCH5_PHYS) ? ((x) + HIFONE_IOCH5_VIRT - HIFONE_IOCH5_PHYS) : (__IO_ADDRESS6(x)))
#define __IO_ADDRESS6(x) ((x >= HIFONE_IOCH6_PHYS) ? ((x) + HIFONE_IOCH6_VIRT - HIFONE_IOCH6_PHYS) : (__IO_ADDRESS7(x)))
#define __IO_ADDRESS7(x) ((x >= HIFONE_IOCH7_PHYS) ? ((x) + HIFONE_IOCH7_VIRT - HIFONE_IOCH7_PHYS) : (__IO_ADDRESS8(x)))
#define __IO_ADDRESS8(x) ((x >= HIFONE_IOCH8_PHYS) ? ((x) + HIFONE_IOCH8_VIRT - HIFONE_IOCH8_PHYS) : (__IO_ADDRESS9(x)))
#define __IO_ADDRESS9(x) ((x) + HIFONE_IOCH9_VIRT - HIFONE_IOCH9_PHYS)

#define IO_OFFSET_LOW  (0x1000000)
#define IO_OFFSET_HIGH (0x4000000)

#define IO_ADDRESS(x)   (__IO_ADDRESS1(x))
#define IO_ADDRESS_LOW(x)  ((x) + IO_OFFSET_LOW)
#define IO_ADDRESS_HIGH(x) ((x) - IO_OFFSET_HIGH)
#endif