/*--------------------------------------------------------------------------------------------------------------------------*/
/*!!Warning: This is a key information asset of Huawei Tech Co.,Ltd                                                         */
/*CODEMARK:kOyQZYzjDpyGdBAEC2GaWinjiDDUykL9e8pckESWBbMVmSWkBuyJO01cTiy3TdzKxGk0oBQa
mSMf7J4FkTpfvw3GhTDOicZI2CRBFXfE/6689oSZ0qEh9fvFJXfmiYOqJc+ojONAi8vqCsXf
rvOvFThv1p2DIQ7/+F2T7N8KBVM1/AvHYeKyxL0EfWyFDfdebldw0wDLB8Rz1f3CCf0vOy+5
4nrbJoifjTNxulzNsJjIkgBqyQhoW8S042B/RZIcOCpyv5gDR4tSpiYG7OE7WQ==*/
/*--------------------------------------------------------------------------------------------------------------------------*/
#ifndef __VPSS_IN_INTF_H__
#define __VPSS_IN_INTF_H__
#include "vpss_common.h"
#include "drv_vdec_ext.h"

#include "vpss_in_common.h"

#if defined(CHIP_TYPE_hi3716mv410) || defined(CHIP_TYPE_hi3716mv420) 
#include "vpss_in_3716mv410.h"
#endif

#if defined(CHIP_TYPE_hi3798cv200_a)
#include "vpss_in_hifoneb02.h"
#endif

#if defined(CHIP_TYPE_hi3798mv100_a)||defined(CHIP_TYPE_hi3796mv100)||defined(CHIP_TYPE_hi3798mv100)
#include "vpss_in_3798mv100.h"
#endif

#if defined(CHIP_TYPE_hi3798cv200)
#include "vpss_in_3798cv200.h"
#endif

#endif

