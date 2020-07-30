#ifndef __DRV_AMP_H__
#define __DRV_AMP_H__

#ifdef __cplusplus
 #if __cplusplus
extern "C" {
 #endif
#endif /* __cplusplus */

#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* __cplusplus */

typedef enum hiDRV_AMP_I2C_ADDR_E
{
    HI_DRV_AMP_I2C_ADDR_TAS5707_H = 0x36,           /**Tas5707 I2C address, Select bit is high*/ /**<CNcomment:Tas5707 I2C 器件地址*/
    HI_DRV_AMP_I2C_ADDR_TAS5707_L = 0x34,           /**Tas5707 I2C address, Select bit is low*/ /**<CNcomment:Tas5707 I2C 器件地址*/
    HI_DRV_AMP_I2C_ADDR_TAS5711_H = 0x36,           /**Tas5711 I2C address, Select bit is high*/ /**<CNcomment:Tas5711 I2C 器件地址*/
    HI_DRV_AMP_I2C_ADDR_TAS5711_L = 0x34,           /**Tas5711 I2C address, Select bit is low*/ /**<CNcomment:Tas5711 I2C 器件地址*/
    HI_DRV_AMP_I2C_ADDR_NTP8214_H = 0x56,           /**NTP8214 I2C address, Select bit is high*/ /**<CNcomment:NTP8214 I2C 器件地址*/
    HI_DRV_AMP_I2C_ADDR_NTP8214_L = 0x54,           /**NTP8214 I2C address, Select bit is low*/ /**<CNcomment:NTP8214 I2C 器件地址*/
    HI_DRV_AMP_I2C_ADDR_NTP8212_H = 0x56,           /**NTP8212 I2C address, Select bit is high*/ /**<CNcomment:NTP8212 I2C 器件地址*/
    HI_DRV_AMP_I2C_ADDR_NTP8212_L = 0x54,           /**NTP8212 I2C address, Select bit is low*/ /**<CNcomment:NTP8212 I2C 器件地址*/
    HI_DRV_AMP_I2C_ADDR_RT9107B_H = 0x36,           /**RT9107B I2C address, Select bit is high*/ /**<CNcomment:RT9107B I2C 器件地址*/
    HI_DRV_AMP_I2C_ADDR_RT9107B_L = 0x34,           /**RT9107B I2C address, Select bit is low*/ /**<CNcomment:RT9107B I2C 器件地址*/
    HI_DRV_AMP_I2C_ADDR_ALC1310_H = 0x36,           /**ALC1310 I2C address, Select bit is high*/ /**<CNcomment:ALC1310 I2C 器件地址*/
    HI_DRV_AMP_I2C_ADDR_ALC1310_L = 0x34,           /**ALC1310 I2C address, Select bit is low*/ /**<CNcomment:ALC1310 I2C 器件地址*/
    HI_DRV_AMP_I2C_ADDR_AD83586 = 0x60,             /**AD83586 I2C address, Select bit is high*/ /**<CNcomment:AD83586 I2C 器件地址*/
    HI_DRV_AMP_I2C_ADDR_AD82584_H = 0x62,           /**AD82584 I2C address, Select bit is high*/ /**<CNcomment:AD82584 I2C 器件地址*/
    HI_DRV_AMP_I2C_ADDR_AD82584_L = 0x60,           /**AD82584 I2C address, Select bit is low*/ /**<CNcomment:AD82584 I2C 器件地址*/
    HI_DRV_AMP_I2C_ADDR_BUTT
} HI_DRV_AMP_I2C_ADDR_E;

/**Defines the type of AMP.*/
/**CNcomment:定义数字功放类型*/
typedef enum hiDRV_AMP_E
{
    HI_DRV_AMP_TAS5707 = 0,       /**Tas5707*/ /**<CNcomment:数字功放Tas5707 */
    HI_DRV_AMP_TAS5711,           /**Tas5711*/ /**<CNcomment:数字功放Tas5711 */
    HI_DRV_AMP_NTP8214,           /**NTP8214*/ /**<CNcomment:数字功放NTP8214 */
    HI_DRV_AMP_NTP8212,           /**NTP8214*/ /**<CNcomment:数字功放NTP8212 */
    HI_DRV_AMP_RT9107B,           /**RT9107B*/ /**<CNcomment:数字功放RT9107B */
    HI_DRV_AMP_ALC1310,           /**ALC1310*/ /**<CNcomment:数字功放ALC1310 */
    HI_DRV_AMP_AD83586,           /**AD83586*/ /**<CNcomment:数字功放AD83586 */
    HI_DRV_AMP_ANALOG,            /**Analog AMP*/ /**<CNcomment:模拟功放 */
    HI_DRV_AMP_AD82584,           /**AD82584*/ /**<CNcomment:数字功放AD82584 */
    HI_DRV_AMP_BUTT
} HI_DRV_AMP_E;

#endif /* __DRV_AMP_H__ */

