#ifndef __VFMW_TRUST_INTF_H__
#define __VFMW_TRUST_INTF_H__

#include "vfmw.h"
#ifdef VDH_DISTRIBUTOR_ENABLE
#include "vdh_secure.h"
#endif

#if defined(ENV_SOS_KERNEL)

// Definition for Trusted Core VFMW
SINT32 VCTRL_RunProcess(VOID);
SINT32 VCTRL_ReadProc(SINT8 *page, SINT32 count);
SINT32 VCTRL_WriteProc(UINT32 option, SINT32 value);
SINT32 VCTRL_GetChanImage( SINT32 ChanID, IMAGE *pImage );
SINT32 VCTRL_ReleaseChanImage( SINT32 ChanID, IMAGE *pImage );

SINT32 SEC_VDEC_Init( UINT32 pVdecCallback);
SINT32 SEC_VDEC_InitWithOperation(UINT32 pArgs);
SINT32 SEC_VDEC_Control(SINT32 ChanID, UINT32 eCmdID, UINT32 pArgs);
SINT32 SEC_VDEC_Exit(VOID);
SINT32 SEC_VDEC_Suspend(VOID);
SINT32 SEC_VDEC_Resume(VOID);
SINT32 SEC_VCTRL_RunProcess(VOID);
SINT32 SEC_VCTRL_ReadProc(UINT32 page, SINT32 count);
SINT32 SEC_VCTRL_WriteProc(UINT32 option, SINT32 value);
SINT32 SEC_VCTRL_SetDbgOption (UINT32 opt, UINT32 p_args);
SINT32 SEC_VCTRL_GetChanImage( SINT32 ChanID, UINT32 pImage );
SINT32 SEC_VCTRL_ReleaseChanImage( SINT32 ChanID, UINT32 pImage );

#endif

#endif

