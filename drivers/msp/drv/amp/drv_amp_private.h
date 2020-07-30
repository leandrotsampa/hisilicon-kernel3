#ifndef __DRV_AMP_PRIVATE_H__
#define __DRV_AMP_PRIVATE_H__

#include "hi_type.h"
#include "hi_module.h"
#include "hi_drv_sys.h"
#include "hi_drv_dev.h"
#include "hi_drv_mmz.h"
#include "hi_drv_mem.h"
#include "hi_drv_proc.h"
#include "hi_drv_stat.h"
#include "hi_drv_module.h"

#include "drv_amp_ext.h"
#include "drv_i2c_ext.h"
#include "drv_gpio_ext.h"
#include "hi_board.h"
#include "amp_i2s.h"
#include "drv_amp_ioctl.h"


#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif /* __cplusplus */

/***************************** Macro Definition ******************************/
#define AMP_NAME "HI_AMP"
#define AMP_MAX_CHAN_NUM 1

typedef enum
{
    AMP_CMD_PROC_SET_MUTE = 0,
    AMP_CMD_PROC_SET_DRC,
    AMP_CMD_PROC_SET_PEQ,
    AMP_CMD_PROC_BUTT
} AMP_CMD_PROC_E;  

#define AMP_STRING_SKIP_BLANK(str)       \
    while (str[0] == ' ')           \
    {                               \
        (str)++;                    \
    }  

#define AMP_PROC_SHOW_HELP() \
do                                                         \
{                                                          \
	HI_DRV_PROC_EchoHelper("-----------------------------------AMP-----------------------------------\n"); \
	HI_DRV_PROC_EchoHelper("echo    command     para      path              explanation\n\n"); \
    HI_DRV_PROC_EchoHelper("echo    mute        [1/0]   > /proc/msp/amp     Set amp mute(1:ON;0:OFF)\n"); \
    HI_DRV_PROC_EchoHelper("echo    drc         [1/0]   > /proc/msp/amp     Set amp drc(1:ON;0:OFF)\n"); \
    HI_DRV_PROC_EchoHelper("echo    peq         [1/0]   > /proc/msp/amp     Set amp peq(1:ON;0:OFF)\n"); \
	HI_DRV_PROC_EchoHelper("-------------------------------------------------------------------------\n"); \
} while (0)

/***************************** Struct Definition ******************************/
typedef struct tagAMP_REGISTER_PARAM_S
{
	DRV_PROC_READ_FN  pfnReadProc;
	DRV_PROC_WRITE_FN pfnWriteProc;
} AMP_REGISTER_PARAM_S;

typedef struct tagAMP_STORING_S
{
	HI_BOOL      bMute;
} AMP_STORING_S;

typedef struct tagAMP_STATUS_PROC_S
{
	HI_U32      u32InbufUse;
	HI_U32      u32InbufUsePerc;
	HI_U32      u32OutbufUse;
	HI_U32      u32OutbufUsePerc;
} AMP_STATUS_PROC_S;

typedef struct tagAMP_PRIVATE_PROC_INFO_S
{
	HI_U32      u32DbgGetBufCntTry;
	HI_U32      u32DbgGetBufCntOk;
	HI_U32      u32DbgPutBufCntTry;
	HI_U32      u32DbgPutBufCntOk;
	HI_U32      u32DbgAcquireFrmCntTry;
	HI_U32      u32DbgAcquireFrmCntOk;
	HI_U32      u32DbgReleaseFrmCntTry;
	HI_U32      u32DbgReleaseFrmCntOk;
} AMP_PRIVATE_PROC_INFO_S;


/* Global parameter */
typedef struct tagAMP_GLOBAL_PARAM_S
{
	atomic_t         		atmOpenCnt;     /* Open times */

	HI_U8				u8DeviceAddr;
	HI_U8				u8DeviceType;
	HI_U32 				u32I2CNum;
	HI_U32				u32GPIOOutputPolarity;
	HI_U32				u32ResetGPIONum;
	HI_U32				u32ResetPolarity;
	HI_U32				u32HWMuteGPIONum;
	HI_U32				u32HWMutePolarity;

	I2C_EXT_FUNC_S*       pI2CFunc;       /* AMP need I2C extenal functions */
	GPIO_EXT_FUNC_S*	pGpioFunc;      /* AMP need GPIO extenal functions */
	AMP_EXPORT_FUNC_S  stExtFunc;      /* AMP extenal functions */
} AMP_GLOBAL_PARAM_S;

typedef HI_S32(*FN_AMP_READ_PROC)(struct seq_file* p, HI_VOID* v);
typedef HI_S32(*FN_AMP_WRITE_PROC)(struct file *p, const char __user *buf, size_t count, loff_t *ppos);
typedef HI_S32(*FN_AMP_READREG)(HI_U32 u32RegAddr, HI_U32 u32ByteSize, HI_U8* pu8Value);
typedef HI_S32(*FN_AMP_WRITEREG)(HI_U32 u32RegAddr, HI_U32 u32ByteSize, HI_U8* pu8Value);
typedef HI_S32(*FN_AMP_GETSUBWOOFERVOL)(HI_U32* pu32dB);
typedef HI_S32(*FN_AMP_SETSUBWOOFERVOL)(HI_U32 u32dB);
typedef HI_S32(*FN_AMP_GETMUTE)(HI_BOOL* pbMute);
typedef HI_S32(*FN_AMP_SETMUTE)(HI_BOOL bMute);
typedef HI_VOID(*FN_AMP_DEINIT)(HI_VOID);
typedef HI_S32(*FN_AMP_INIT)(HI_VOID*);

typedef struct
{
	HI_BOOL                 bExtMClkFlag;		//USE External MCLK
	FN_AMP_READ_PROC		pfnAmpReadProc;
	FN_AMP_WRITE_PROC		pfnAmpWriteProc;
	FN_AMP_READREG			pfnAmpReadReg;
	FN_AMP_WRITEREG			pfnAmpWriteReg;
	FN_AMP_GETSUBWOOFERVOL	pfnAmpGetSubWooferVol;
	FN_AMP_SETSUBWOOFERVOL	pfnAmpSetSubWooferVol;
	FN_AMP_GETMUTE			pfnAmpGetMute;
	FN_AMP_SETMUTE			pfnAmpSetMute;
	FN_AMP_DEINIT			pfnAmpDeinit;
	FN_AMP_INIT				pfnAmpInit;
	FN_AMP_INIT				pfnAmpResume;
} AMP_DRV_FUNC_S;

/***************************** Function Declare ******************************/
HI_S32  AMP_DRV_Init(AMP_INFO_S *stAmpInfo);
HI_VOID AMP_DRV_Exit(HI_VOID);
HI_S32  AMP_DRV_Open(struct inode* inode, struct file*  filp);
HI_S32  AMP_DRV_Release(struct inode* inode, struct file*  filp);
HI_S32  AMP_DRV_RegisterProc(HI_VOID);
HI_VOID AMP_DRV_UnRegisterProc(HI_VOID);
HI_S32  AMP_DRV_Suspend(PM_BASEDEV_S* pdev, pm_message_t state);
HI_S32  AMP_DRV_Resume(PM_BASEDEV_S* pdev);
long    AMP_DRV_Ioctl(struct file* file, HI_U32 cmd, unsigned long arg);

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif /* __cplusplus */

#endif /* __DRV_AMP_PRIVATE_H__ */

