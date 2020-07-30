#ifndef __DRV_AFLT_PRIVATE_H__
#define __DRV_AFLT_PRIVATE_H__

#include "hi_type.h"
#include "hi_module.h"
#include "hi_drv_sys.h"
#include "hi_drv_dev.h"
#include "hi_drv_mmz.h"
#include "hi_drv_mem.h"
#include "hi_drv_proc.h"
#include "hi_drv_stat.h"
#include "hi_drv_module.h"

#include "hal_aflt.h"
#include "hi_audsp_aflt.h"
#include "drv_adsp_ext.h"

#ifdef __cplusplus
 #if __cplusplus
extern "C" {
 #endif
#endif /* __cplusplus */

/***************************** Macro Definition ******************************/
#define AFLT_NAME "HI_AFLT"

/***************************** Struct Definition ******************************/
typedef struct tagAFLT_REGISTER_PARAM_S
{
    DRV_PROC_READ_FN  pfnReadProc;
    DRV_PROC_WRITE_FN pfnWriteProc;
} AFLT_REGISTER_PARAM_S;

typedef struct tagAFTL_STORING_S
{
    AFLT_STATUS_E      enCurnStatus;
    AFLT_CREATE_ATTR_S stCreateAttr;

    MMZ_BUFFER_S       stInBufMmz;
    MMZ_BUFFER_S       stOutBufMmz;
    HAL_AFLT_INBUF_ATTR_S      stInBufAttr;
    HAL_AFLT_OUTBUF_ATTR_S     stOutBufAttr;
}AFTL_STORING_S;

typedef struct tagAFLT_STATUS_PROC_S
{
    HI_U32      u32InbufUse;
    HI_U32      u32InbufUsePerc;
    HI_U32      u32OutbufUse;
    HI_U32      u32OutbufUsePerc;
}AFLT_STATUS_PROC_S;
typedef struct tagAFLT_PRIVATE_PROC_INFO_S
{
    HI_U32      u32DbgGetBufCntTry;
    HI_U32      u32DbgGetBufCntOk;
    HI_U32      u32DbgPutBufCntTry;
    HI_U32      u32DbgPutBufCntOk;
    HI_U32      u32DbgAcquireFrmCntTry;
    HI_U32      u32DbgAcquireFrmCntOk;
    HI_U32      u32DbgReleaseFrmCntTry;
    HI_U32      u32DbgReleaseFrmCntOk;
}AFLT_PRIVATE_PROC_INFO_S;

typedef struct tagAFLT_CHANNEL_S
{
    AFLT_CREATE_ATTR_S  stCreateAttr;
    
    /* internal state */
    AFLT_STATUS_E       enCurnStatus;

    /*Aflt buffer attr*/
    MMZ_BUFFER_S        stMsgPoolMmz;
    MMZ_BUFFER_S        stOutBufMmz;
    MMZ_BUFFER_S        stInBufMmz;

    HAL_AFLT_MSGPOOL_ATTR_S    stMsgAttr;
    HAL_AFLT_INBUF_ATTR_S      stInBufAttr;
    HAL_AFLT_OUTBUF_ATTR_S     stOutBufAttr;

    AFLT_PRIVATE_PROC_INFO_S           stPrivProcInfo;
} AFLT_CHANNEL_S;

typedef struct tagAFLT_CHAN_ENTITY_S
{
    AFLT_CHANNEL_S *   pstChan;        /* Channel structure pointer */
    struct file *      pstFile;         /* File handle */
    HI_BOOL            bUsed;           /* Busy or free */
    atomic_t           atmUseCnt;       /* Channel use count, support multi user */
    
    MMZ_BUFFER_S       stMsgRbfMmz;

    AFTL_STORING_S   stStoreAttr;
} AFLT_CHAN_ENTITY_S;

/* Global parameter */
typedef struct tagAFLT_GLOBAL_PARAM_S
{
    HI_U32                 u32ChanNum;     /* Record AFLT channel num */
    AFLT_CHAN_ENTITY_S      astChanEntity[AFLT_MAX_CHAN_NUM];   /* Channel parameter */
    atomic_t               atmOpenCnt;     /* Open times */
    HI_BOOL                bReady;         /* Init flag */
    AFLT_REGISTER_PARAM_S*  pstProcParam;   /* AFLT Proc functions */
    HI_BOOL                bAfltSwFlag;
    ADSP_EXPORT_FUNC_S*    pAdspFunc;       /* ADSP extenal functions */
} AFLT_GLOBAL_PARAM_S;

/***************************** Function Declare ******************************/
HI_S32  AFLT_DRV_Init(HI_VOID);
HI_VOID AFLT_DRV_Exit(HI_VOID);
HI_S32  AFLT_DRV_Open(struct inode *inode, struct file  *filp);
HI_S32  AFLT_DRV_Release(struct inode *inode, struct file  *filp);
HI_S32  AFLT_DRV_RegisterProc(AFLT_REGISTER_PARAM_S *pstParam);
HI_VOID AFLT_DRV_UnRegisterProc(HI_VOID);
HI_S32  AFLT_DRV_Suspend(PM_BASEDEV_S *pdev, pm_message_t state);
HI_S32  AFLT_DRV_Resume(PM_BASEDEV_S *pdev);
long    AFLT_DRV_Ioctl(struct file *file, HI_U32 cmd, unsigned long arg);
HI_S32  AFLT_DRV_ReadProc( struct seq_file* p, HI_VOID* v );
HI_S32  AFLT_DRV_WriteProc(struct file * file, const char __user * buf, size_t count, loff_t *ppos);


#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* __cplusplus */

#endif /* __DRV_AFLT_PRIVATE_H__ */

