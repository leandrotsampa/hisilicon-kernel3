#include <linux/linkage.h>
#include <asm/assembler.h> 

ENTRY(hi_pm_sleep)
	ldr x0, =1
	b	cpu_suspend
ENDPROC(hi_pm_sleep)


