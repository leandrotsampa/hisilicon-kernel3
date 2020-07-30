
#include "base.h"
#include "keyled.h"

/************************************************************************* 
						2.0  keyled module
*************************************************************************/
/*variable*/
//HI_U8  kltype = HI_UNF_KEYLED_TYPE_74HC164;
HI_U8  klPmocVal = 0;

/* while kltype !=0, func as follow */
extern void keyled_isr_usr(void);
extern void KEYLED_Init_Usr(void);
extern void keyled_disable_usr(void);
extern void timer_display_usr(void);
extern void chan_display_usr(DATA_U32_S channum);
extern void no_display_usr(void);
extern void dbg_display_usr(HI_U16 val); 

HI_VOID timer_display(HI_VOID)
{
#ifndef POWER_UP_STANDBY_MODE1
    timer_display_usr(); 
#endif
	return;
}

HI_VOID chan_display(HI_VOID)
{ 	
    DATA_U32_S  channum;

    regAddr.val32 = g_u32DateBaseAddr + DATA_DISPVAL;

    read_regVal();
    channum.val32 = regData.val32;

#ifndef POWER_UP_STANDBY_MODE1
	chan_display_usr(channum);
#endif

	return;
}

HI_VOID no_display(HI_VOID) 
{
#ifndef POWER_UP_STANDBY_MODE1
	no_display_usr(); 
#endif

	return;
}     

HI_VOID KEYLED_Early_Display(HI_VOID)
{
	if (time_type == TIME_DISPLAY )
	{
		timer_display();
	}
	else if (time_type == DIGITAL_DISPLAY)
	{
		chan_display();
	}
	else
	{
		no_display();
	}
	
	return;
}

HI_VOID dbg_display(HI_U16 val)
{
#ifndef POWER_UP_STANDBY_MODE1    
	dbg_display_usr(val); 
#endif

	return;
}

HI_VOID KEYLED_Init(HI_VOID) 
{ 
	KEYLED_Init_Usr(); 

    return;
}

HI_VOID KEYLED_Disable(HI_VOID) 
{
	keyled_disable_usr();  

	return;
}

HI_VOID KEYLED_Isr(HI_VOID) 
{	
#ifndef POWER_UP_STANDBY_MODE1
	keyled_isr_usr();
#endif

	return;
}

