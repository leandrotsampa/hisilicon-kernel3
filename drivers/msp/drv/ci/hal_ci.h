#ifndef __HAL_CI_H__
#define __HAL_CI_H__
       
#include "drv_ci_ioctl.h"

#define MAX_CIS_SIZE (512)


#ifdef __cplusplus
#if __cplusplus
       extern "C"{
#endif
#endif

#if !(defined(HI_CI_DEV_CIMAX) || defined(HI_CI_DEV_CIMAXPLUS) || defined(HI_CI_DEV_HICI) || defined(STARCI2WIN_SUPPORT))
    #error You need to define at least one type of CI devices!
#endif

typedef enum
{
    HI_CI_PCCD_RUN_STEP_RESUME,
    HI_CI_PCCD_RUN_STEP_STANDBY,
    HI_CI_PCCD_RUN_STEP_RUNNING,
    HI_CI_PCCD_RUN_STEP_BUIT,
}HI_CI_PCCD_RUN_STEP;

/* Added begin 2012-04-24 l00185424: support various CI device */
/* standard ci operation */
typedef struct hiCI_OPS_S
{	
    /* Init & open device */
    HI_S32 (*ci_device_open)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_ATTR_S stAttr);
    /* Close & deinit device */
    HI_VOID (*ci_device_close)(HI_UNF_CI_PORT_E enCIPort);
    /* Open Card */
    HI_S32 (*ci_pccd_open)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId);
    /* Close Card */
    HI_VOID (*ci_pccd_close)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId);
    /* Read data, IO or ATTR, offset automatically */
    HI_S32 (*ci_pccd_read_byte)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                                                HI_U32 u32Address, HI_U8 *pu8Value);
    /* Write data, IO or ATTR, offset automatically */
    HI_S32 (*ci_pccd_write_byte)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                                                HI_U32 u32Address, HI_U8 u8Value);
    /* Card present or absent detect */
    HI_S32 (*ci_pccd_detect)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                        HI_UNF_CI_PCCD_STATUS_E_PTR penCardIdStatus);
    /* Card busy or ready detect */
    HI_S32 (*ci_pccd_ready_or_busy)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                        HI_UNF_CI_PCCD_READY_E_PTR penCardReady);
    /* Reset PCCD */ 
    HI_S32 (*ci_pccd_reset)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId);
    /* Set access mode of card */
    HI_S32 (*ci_pccd_set_access_mode)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            HI_UNF_CI_PCCD_ACCESSMODE_E enAccessMode);
    /* Get Read/Write status: FR/DA/RE/WE */
    HI_S32 (*ci_pccd_get_rw_status)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_U8 *pu8Value);
    /* TS ByPass */
    HI_S32 (*ci_pccd_ts_bypass)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_BOOL bByPass);
    /* Power ON/OFF */
    HI_S32 (*ci_pccd_ctrl_power)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                    HI_UNF_CI_PCCD_CTRLPOWER_E enCtrlPower);
    /* Low Power */
    HI_S32 (*ci_standby)(HI_UNF_CI_PORT_E enCIPort);
    /* Resume CI */
    HI_S32 (*ci_resume)(HI_UNF_CI_PORT_E enCIPort);
    /* Debug: Get access mode */
    HI_S32 (*ci_pccd_get_access_mode)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                                    HI_UNF_CI_PCCD_ACCESSMODE_E *penAccessMode);
    /* Debug: Get bapass mode */
    HI_S32 (*ci_pccd_get_bypass_mode)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_BOOL *bBypassMode);
    /* Set PCMCIA card attribute get from CIS */
    HI_S32 (*ci_pccd_set_attr)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, CI_PCCD_ATTR_S *pstAttr);

    /* For CIMaX+, the provider(SmarDTV)'s driver interface can GetCIS/WriteCOR/Negotiate/IOWrite/IORead directly. */
    
    HI_S32 (*ci_pccd_set_ts_mode)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                                    HI_UNF_CI_TS_MODE_E enTSMode);
    HI_S32 (*ci_pccd_get_cis)(HI_UNF_CI_PORT_E enCIPort, 
                                    HI_UNF_CI_PCCD_E enCardId, HI_U8 pu8CIS[MAX_CIS_SIZE], HI_U32 *pu32Len);
    HI_S32 (*ci_pccd_write_cor)(HI_UNF_CI_PORT_E enCIPort, 
                                    HI_UNF_CI_PCCD_E enCardId, HI_U16 u16Addr, HI_U8 u8COR);
    HI_S32 (*ci_pccd_negotiate)(HI_UNF_CI_PORT_E enCIPort, 
                                    HI_UNF_CI_PCCD_E enCardId, HI_U16 *pu16BufferSize);
    HI_S32 (*ci_pccd_io_reset)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId);
    HI_S32 (*ci_pccd_io_write)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                                    const HI_U8 *pu8Buffer, HI_U32 u32WriteLen);
    HI_S32 (*ci_pccd_io_read)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                                    HI_U8 *pu8Buffer, HI_U32 *pu32ReadLen);
    HI_S32 (*ci_pccd_ts_write)(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            HI_UNF_CI_PCCD_TSWRITE_S *pstWriteData);
}CI_OPS_S;
/* Added end 2012-04-24 l00185424: support various CI device */


/* For CIMaX */
#ifdef HI_CI_DEV_CIMAX
HI_S32 CIMAX_Open(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_ATTR_S stAttr);
HI_VOID CIMAX_Close(HI_UNF_CI_PORT_E enCIPort);
HI_S32 CIMAX_PCCD_Open(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId);
HI_VOID CIMAX_PCCD_Close(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId);
HI_S32 CIMAX_PCCD_ReadByte(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                                            HI_U32 u32Address, HI_U8 *pu8Value);
HI_S32 CIMAX_PCCD_WriteByte(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                                            HI_U32 u32Address, HI_U8 u8Value);
HI_S32 CIMAX_PCCD_Detect(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            HI_UNF_CI_PCCD_STATUS_E_PTR penCardIdStatus);
HI_S32 CIMAX_PCCD_ReadyOrBusy(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            HI_UNF_CI_PCCD_READY_E_PTR penCardReady);
HI_S32 CIMAX_PCCD_Reset(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId);
HI_S32 CIMAX_PCCD_SetAccessMode(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            HI_UNF_CI_PCCD_ACCESSMODE_E enAccessMode);
HI_S32 CIMAX_PCCD_GetRWStatus(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_U8 *pu8Value);
HI_S32 CIMAX_PCCD_TSByPass(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_BOOL bByPass);
HI_S32 CIMAX_PCCD_SetTSMode(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_UNF_CI_TS_MODE_E enTSMode);
HI_S32 CIMAX_PCCD_CtrlPower(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            HI_UNF_CI_PCCD_CTRLPOWER_E enCtrlPower);
HI_S32 CIMAX_Standby(HI_UNF_CI_PORT_E enCIPort);
HI_S32 CIMAX_Resume(HI_UNF_CI_PORT_E enCIPort);
HI_S32 CIMAX_PCCD_GetAccessMode(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            HI_UNF_CI_PCCD_ACCESSMODE_E *penAccessMode);
HI_S32 CIMAX_PCCD_GetBypassMode(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_BOOL *bBypass);
HI_S32 CIMAX_PCCD_SetAttr(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            CI_PCCD_ATTR_S *pstAttr);
#endif

/* For CIMaX+ */
#ifdef HI_CI_DEV_CIMAXPLUS
HI_S32 CIMAXPLUS_Open(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_ATTR_S stAttr);
HI_VOID CIMAXPLUS_Close(HI_UNF_CI_PORT_E enCIPort);
HI_S32 CIMAXPLUS_PCCD_Open(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId);
HI_VOID CIMAXPLUS_PCCD_Close(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId);
HI_S32 CIMAXPLUS_PCCD_Detect(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            HI_UNF_CI_PCCD_STATUS_E_PTR penCardIdStatus);
HI_S32 CIMAXPLUS_PCCD_ReadyOrBusy(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            HI_UNF_CI_PCCD_READY_E_PTR penCardReady);
HI_S32 CIMAXPLUS_PCCD_Reset(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId);
HI_S32 CIMAXPLUS_PCCD_GetRWStatus(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_U8 *pu8Value);
HI_S32 CIMAXPLUS_PCCD_TSByPass(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_BOOL bByPass);
HI_S32 CIMAXPLUS_PCCD_CtrlPower(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            HI_UNF_CI_PCCD_CTRLPOWER_E enCtrlPower);
HI_S32 CIMAXPLUS_PCCD_SetAccessMode(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                                            HI_UNF_CI_PCCD_ACCESSMODE_E enAccessMode);
HI_S32 CIMAXPLUS_PCCD_GetAccessMode(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            HI_UNF_CI_PCCD_ACCESSMODE_E *penAccessMode);

HI_S32 CIMAXPLUS_Standby(HI_UNF_CI_PORT_E enCIPort);
HI_S32 CIMAXPLUS_Resume(HI_UNF_CI_PORT_E enCIPort);
HI_S32 CIMAXPLUS_PCCD_GetBypassMode(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_BOOL *bBypass);
HI_S32 CIMAXPLUS_PCCD_GetCIS(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            HI_U8 pu8CIS[MAX_CIS_SIZE], HI_U32 *pu32Len);
HI_S32 CIMAXPLUS_PCCD_WriteCOR(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            HI_U16 u16Addr, HI_U8 u8COR);
HI_S32 CIMAXPLUS_PCCD_Negotiate(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            HI_U16 *pu16BufferSize);
HI_S32 CIMAXPLUS_PCCD_IOReset(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId);
HI_S32 CIMAXPLUS_PCCD_IOWrite(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                                            const HI_U8 *pu8Buffer, HI_U32 u32WriteLen);
HI_S32 CIMAXPLUS_PCCD_IORead(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                                            HI_U8 *pu8Buffer, HI_U32 *pu32ReadLen);
HI_S32 CIMAXPLUS_PCCD_SetAttr(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            CI_PCCD_ATTR_S *pstAttr);
HI_S32 CIMAXPLUS_PCCD_SetTSMode(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                                HI_UNF_CI_TS_MODE_E enTSMode);
HI_S32 CIMAXPLUS_PCCD_TSWrite(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            HI_UNF_CI_PCCD_TSWRITE_S *pstWriteData);
#endif

/* For HICI */
#ifdef HI_CI_DEV_HICI
HI_S32 HICI_Open(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_ATTR_S stAttr);
HI_VOID HICI_Close(HI_UNF_CI_PORT_E enCIPort);
HI_S32 HICI_PCCD_Open(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId);
HI_VOID HICI_PCCD_Close(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId);
HI_S32 HICI_PCCD_ReadByte(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                                            HI_U32 u32Address, HI_U8 *pu8Value);
HI_S32 HICI_PCCD_WriteByte(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                                            HI_U32 u32Address, HI_U8 u8Value);
HI_S32 HICI_PCCD_Detect(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            HI_UNF_CI_PCCD_STATUS_E_PTR penCardIdStatus);
HI_S32 HICI_PCCD_ReadyOrBusy(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            HI_UNF_CI_PCCD_READY_E_PTR penCardReady);
HI_S32 HICI_PCCD_Reset(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId);
HI_S32 HICI_PCCD_SetAccessMode(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, 
                                            HI_UNF_CI_PCCD_ACCESSMODE_E enAccessMode);
HI_S32 HICI_PCCD_GetAccessMode(HI_UNF_CI_PORT_E enCIPort,HI_UNF_CI_PCCD_E enCardId, 
															 HI_UNF_CI_PCCD_ACCESSMODE_E *penAccessMode);
HI_S32 HICI_PCCD_GetRWStatus(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_U8 *pu8Value);
HI_S32 HICI_PCCD_CtrlPower(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                           HI_UNF_CI_PCCD_CTRLPOWER_E enCtrlPower);
HI_S32 HICI_PCCD_TSByPass(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_BOOL bByPass);
HI_S32 HICI_PCCD_GetBypassMode(HI_UNF_CI_PORT_E enCIPort,
                                HI_UNF_CI_PCCD_E enCardId, HI_BOOL *bBypass);
HI_S32 HICI_Standby(HI_UNF_CI_PORT_E enCIPort);
HI_S32 HICI_Resume(HI_UNF_CI_PORT_E enCIPort);

#endif

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif 

#endif

