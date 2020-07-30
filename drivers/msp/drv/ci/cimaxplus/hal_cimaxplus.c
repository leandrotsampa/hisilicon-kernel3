/**
 \file
 \brief CI hal interface
 \copyright Shenzhen Hisilicon Co., Ltd.
 \date 2011-2021
 \version draft
 \author l00185424
 \date 2011-7-20
 */

/***************************** Include files  *******************************/

#include <linux/delay.h>
#include <mach/hardware.h>
#include <asm/io.h>

#include <linux/fs.h>
#include <linux/sched.h>
#include <linux/kthread.h>
#include <asm/uaccess.h>

#include "hi_debug.h"
#include "drv_gpio_ext.h"
#include "hal_ci.h"
#include "drv_cimaxplus_ioctl.h"
#include "hi_drv_mem.h"
#include "hi_drv_module.h"
#include "hi_drv_spi.h"
#include "drv_gpio_spi.h"

#if (LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36))
#define IOCTL ioctl
#define CI_DRV_IOCTL(file, cmd, arg) file->f_op->IOCTL(file->f_mapping->host, file, cmd, arg)
#else
#define IOCTL unlocked_ioctl
#define CI_DRV_IOCTL(file, cmd, arg) file->f_op->IOCTL(file, cmd, arg)
#endif

//#define _DEBUG

/***************************** Macro Definition ******************************/

#define CIMAXPLUS_DEV_FILE "/dev/cimaxusb0"

/* CIMAXPLUS registers internal addresses */
#define MOD_IT_STATUS_REG 0x205
#define MOD_CTRL_REGA 0x207
#define MOD_CTRL_REGB 0x208
#define ROUTER_CAM_CH_REG 0x22f
#define ROUTER_CAM_MOD_REG 0x230
#define MEM_ACC_TIME_REGA 0x217
#define MEM_ACC_TIME_REGB 0x218
#define BITRATE_CH0_LSB_REG 0x2c5

/* CIMAXPLUS Config bit */
#define CIMAXPLUS_MODULE_RST 0x20
#define CIMAXPLUS_ACCESS_MODE_MASK 0x0C
#define CIMAXPLUS_CARD_READY_MASK_A 0x04
#define CIMAXPLUS_CARD_READY_MASK_B 0x08

#define CIMAXPLUS_MEM_ACC_TIME_MASK 0x70
#define CIMAXPLUS_MEM_ACC_TIME_100NS 0
#define CIMAXPLUS_MEM_ACC_TIME_150NS 1
#define CIMAXPLUS_MEM_ACC_TIME_200NS 2
#define CIMAXPLUS_MEM_ACC_TIME_250NS 3
#define CIMAXPLUS_MEM_ACC_TIME_600NS 4

#define CIMAXPLUS_MOD_A_SEL_MASK 0x07
#define CIMAXPLUS_MOD_B_SEL_MASK 0x70
#define CIMAXPLUS_CH_0_OUT_SEL_MASK 0x0F
#define CIMAXPLUS_CH_0_OUT_SEL_MODA 0x00
#define CIMAXPLUS_CH_0_OUT_SEL_CH0IN 0x01
#define CIMAXPLUS_CH_0_OUT_SEL_CH1IN 0x02
#define CIMAXPLUS_CH_0_OUT_SEL_PSREMAPPER 0x03
#define CIMAXPLUS_CH_0_OUT_SEL_PREHEADERADDER 0x04
#define CIMAXPLUS_CH_0_OUT_SEL_MODB 0x05
#define CIMAXPLUS_CH_0_OUT_SEL_GAPREMOVER0 0x06
#define CIMAXPLUS_CH_0_OUT_SEL_GAPREMOVER1 0x07
#define CIMAXPLUS_CH_1_OUT_SEL_MASK 0xF0
#define CIMAXPLUS_CH_1_OUT_SEL_MODB 0x00
#define CIMAXPLUS_CH_1_OUT_SEL_CH0IN 0x10
#define CIMAXPLUS_CH_1_OUT_SEL_CH1IN 0x20
#define CIMAXPLUS_CH_1_OUT_SEL_PSREMAPPER 0x30
#define CIMAXPLUS_CH_1_OUT_SEL_PREHEADERADDER 0x40
#define CIMAXPLUS_CH_1_OUT_SEL_MODA 0x50
#define CIMAXPLUS_CH_1_OUT_SEL_GAPREMOVER0 0x60
#define CIMAXPLUS_CH_1_OUT_SEL_GAPREMOVER1 0x70

/*=============================================================================
* CIMaX+ commands
=============================================================================*/

/** CIMaX+ register header size. */
#define CIMAX_REGISTER_HEADER_SIZE 4

/** CIMaX+ register command position. */
#define CIMAX_REGISTER_CMD_POS 0

/** CIMaX+ register address most significant byte position. */
#define CIMAX_REGISTER_REG_ADDR_MSB_POS 1

/** CIMaX+ register address least significant byte position. */
#define CIMAX_REGISTER_REG_ADDR_LSB_POS 2

/** CIMaX+ register number of registers position. */
#define CIMAX_REGISTER_NUM_OF_REGS_POS 3

/** CIMaX+ register maximum payload size. */
#define CIMAX_REGISTER_MAX_PAYLOAD_SIZE 255

/** CIMaX+ register init request. */
#define CIMAX_REGISTER_INIT_REQ 0x00

/** CIMaX+ register write request. */
#define CIMAX_REGISTER_WRITE_REQ 0x7F

/** CIMaX+ register read request. */
#define CIMAX_REGISTER_READ_REQ 0xFF

/** CIMaX+ register init response OK. */
#define CIMAX_REGISTER_INIT_RESP_OK 0x4B

/** CIMaX+ register init response not OK. */
#define CIMAX_REGISTER_INIT_RESP_NOK 0xCB

/** CIMaX+ register write response OK. */
#define CIMAX_REGISTER_WRITE_RESP_OK 0x4D

/** CIMaX+ register write response not OK. */
#define CIMAX_REGISTER_WRITE_RESP_NOK 0xCD

/** CIMaX+ register read response OK. */
#define CIMAX_REGISTER_READ_RESP_OK 0x4C

/** CIMaX+ register read response not OK. */
#define CIMAX_REGISTER_READ_RESP_NOK 0xCC

/** CIMaX+* register command parse error response. */
#define CIMAX_REGISTER_CMD_PARSE_ERROR 0x51

/** CIMaX+* register boot command not OK. */
#define CIMAX_REGISTER_BOOT_CMD_NOK 0x70

/** CIMaX+* register get SW version command. */
#define CIMAX_REGISTER_GETSWVER 0x0C

/** CIMaX+* register get SW version response OK. */
#define CIMAX_REGISTER_GETSWVER_RESP_OK 0x53

/** CIMaX+* register get SW version response not OK. */
#define CIMAX_REGISTER_GETSWVER_RESP_NOK 0xD3

#define CIMAX_REGISTER_INIT_REQ      0x00
#define CIMAX_REGISTER_INIT_REQ_OK   0x4B
#define CIMAX_REGISTER_INIT_REQ_NOK  0xCB

/*=============================================================================
* CAM commands
=============================================================================*/

/** CIMaX+ CAM packet counter value. */
#define CIMAX_CAM_PACKET_COUNTER_VALUE 0x01

/** CIMaX+ CAM inserted value. */
#define CIMAX_CAM_INSERTED 0x01

/** CIMaX+ CAM extracted value. */
#define CIMAX_CAM_EXTRACTED 0x00

/** CIMaX+ CAM slot mask. */
#define CIMAX_CAM_SLOT_MASK 0x80

/** CIMaX+ CAM slot bit position. */
#define CIMAX_CAM_SLOT_BIT_POSITION 7

/** CIMaX+ CAM type command mask. */
#define CIMAX_CAM_TYP_CMD_MASK 0x7F

/** CIMaX+ CAM header size. */
#define CIMAX_CAM_HEADER_SIZE 4

/** CIMaX+ CAM command or status position. */
#define CIMAX_CAM_COMMAND_OR_STATUS_POS 0

/** CIMaX+ CAM packet counter position. */
#define CIMAX_CAM_PACKET_COUNTER_POS 1

/** CIMaX+ CAM data length most significant byte position. */
#define CIMAX_CAM_DATA_LEN_MSB_POS 2

/** CIMaX+ CAM data length least significant byte position. */
#define CIMAX_CAM_DATA_LEN_LSB_POS 3

/** CIMaX+ CAM first byte of the data position. */
#define CIMAX_CAM_FIRST_DATA_BYTE_POS 4

/** CIMaX+ CAM second byte of the data position. */
#define CIMAX_CAM_SECOND_DATA_BYTE_POS 5

/** CIMaX+ CAM maximum payload size. *//* 65535 */
#define CIMAX_CAM_MAX_PAYLOAD_SIZE 4096

#define CIMAX_CAM_MAX_PAYLOAD_SIZE_TEMP 512

/** CIMaX+ CAM maximum card information structure size. */
#define CIMAX_CAM_CIS_MAX_SIZE 512   /* To be checked  */
/** CIMaX+ CAM COR writing command payload size. */
#define CIMAX_CAM_COR_PAYLOAD_SIZE 5

/** CIMaX+ CAM COR additional payload size. */
#define CIMAX_CAM_COR_ADD_PAYLOAD_SIZE 2

/** CIMaX+ CAM buffer negotiation command payload size. */
#define CIMAX_CAM_NEGOTIATE_PAYLOAD_SIZE 2

/** CIMaX+ CAM status maximum size. *//* 1024 */
#define CIMAX_CAM_STATUS_MAX_SIZE 1000

/** CIMaX+ CAM detection response payload size. */
#define CIMAX_CAM_CAMDET_PAYLOAD_SIZE 1

/** CIMaX+ CAM REG_STATUS payload size. */
#define CIMAX_CAM_REG_STATUS_PAYLOAD_SIZE 1

/** CIMaX+ CAM COR address most significant byte position. */
#define CIMAX_CAM_COR_ADDR_MSB_POS 0

/** CIMaX+ CAM COR address least significant byte position. */
#define CIMAX_CAM_COR_ADDR_LSB_POS 1

/** CIMaX+ CAM COR coomand value position. */
#define CIMAX_CAM_COR_VALUE_POS 2

/** CIMaX+ CAM COR command last byte most significant byte position. */
#define CIMAX_CAM_COR_LAST_MSB_POS 3

/** CIMaX+ CAM COR command last byte least significant byte position. */
#define CIMAX_CAM_COR_LAST_LSB_POS 4

/** CIMaX+ CAM buffer negotiation command most significant byte position. */
#define CIMAX_CAM_NEGOTIATE_SIZE_MSB_POS 0

/** CIMaX+ CAM buffer negotiation command least significant byte position. */
#define CIMAX_CAM_NEGOTIATE_SIZE_LSB_POS 1

/** CIMaX+ CAMReset command. */
#define CIMAX_CAM_RESET_CMD 0x01

/** CIMaX+ GetCIS command. */
#define CIMAX_CAM_GET_CIS_CMD 0x02

/** CIMaX+ CAM WriteCOR command. */
#define CIMAX_CAM_WRITE_COR_CMD 0x03

/** CIMaX+ CAM Negotiate command. */
#define CIMAX_CAM_NEGOCIATE_CMD 0x04

/** CIMaX+ CAM WriteLPDU command. */
#define CIMAX_CAM_WRITE_LPDU_CMD 0x05

/** CIMaX+ CAM ReadLPDU command. */
#define CIMAX_CAM_READ_LPDU_CMD 0x06

/** CIMaX+ GetSWVer  command. */
#define CIMAX_CAM_GET_SW_VER 0x0C

/** CIMaX+ GetSWVer OK. */
#define CIMAX_CAM_GET_SW_VER_OK 0x53

/** CIMaX+ GetEvt  command. */
#define CIMAX_CAM_GET_EVT 0x0D

/** CIMaX+ CAM REGSTATUS command. */
#define CIMAX_CAM_REG_STATUS 0x0E

/** CIMaX+ CAM CAMReset A response. */
#define CIMAX_CAM_A_RESET_OK 0x40

/** CIMaX+ CAM CAMReset B response. */
#define CIMAX_CAM_B_RESET_OK 0xC0

/** CIMaX+ CAM GetCIS A response. */
#define CIMAX_CAM_A_GET_CIS_OK 0x41

/** CIMaX+ CAM GetCIS B response. */
#define CIMAX_CAM_B_GET_CIS_OK 0xC1

/** CIMaX+ CAM WriteCOR A response. */
#define CIMAX_CAM_A_WRITE_COR_OK 0x42

/** CIMaX+ CAM WriteCOR B response. */
#define CIMAX_CAM_B_WRITE_COR_OK 0xC2

/** CIMaX+ CAM Negotiate A response. */
#define CIMAX_CAM_A_NEGOTIATE_OK 0x43

/** CIMaX+ CAM Negotiate B response. */
#define CIMAX_CAM_B_NEGOTIATE_OK 0xC3

/** CIMaX+ CAM WriteLPDU A response. */
#define CIMAX_CAM_A_WRITE_LPDU_OK 0x44

/** CIMaX+ CAM WriteLPDU B response. */
#define CIMAX_CAM_B_WRITE_LPDU_OK 0xC4

/** CIMaX+ CAM CamDet A response. */
#define CIMAX_CAM_A_DET_OK 0x45

/** CIMaX+ CAM CamDet B response. */
#define CIMAX_CAM_B_DET_OK 0xC5

/** CIMaX+ CAM ReadLPDU A response. */
#define CIMAX_CAM_A_READ_LPDU_OK 0x46

/** CIMaX+ CAM ReadLPDU B OK. */
#define CIMAX_CAM_B_READ_LPDU_OK 0xC6

/** CIMaX+ CAM CAMNoCAM A response. */
#define CIMAX_CAM_A_NO_CAM 0x49

/** CIMaX+ CAM CAMNoCAM B response. */
#define CIMAX_CAM_B_NO_CAM 0xC9

/** CIMaX+ CAM CAMError A response. */
#define CIMAX_CAM_A_CAM_ERROR 0x4A

/** CIMaX+ CAM CAMError B response. */
#define CIMAX_CAM_B_CAM_ERROR 0xCA

/** CIMaX+ CAM DataReady A response. */
#define CIMAX_CAM_A_DATA_READY 0x4E

/** CIMaX+ CAM DataReady B response. */
#define CIMAX_CAM_B_DATA_READY 0xCE

/** CIMaX+ CAM CAMWriteBusy A response. */
#define CIMAX_CAM_A_WRITE_BUSY 0x54

/** CIMaX+ CAM NO EVT. */
#define CIMAX_CAM_NO_EVT 0x55

/** CIMaX+ CAM Parse Error. */
#define CIMAX_CAM_PARSE_ERROR 0x51

/** CIMaX+ CAM CAMWriteBusy B response. */
#define CIMAX_CAM_B_WRITE_BUSY 0xD4
/** CIMaX+ CAM CMD_PENDING A response. */
#define CIMAX_CAM_A_CMD_PENDING 0x56
/** CIMaX+ CAM CMD_PENDING B response. */
#define CIMAX_CAM_B_CMD_PENDING 0xD6

/** CIMaX+ CAM REGSTATUSOK A response. */
#define CIMAX_CAM_A_REG_STATUS_OK 0x57

/** CIMaX+ CAM REGSTATUSOK B response. */
#define CIMAX_CAM_B_REG_STATUS_OK 0xD7

/** CIMaX+ status GPIO event. */
#define CIMAX_STATUS_GPIO_EVT 0x58

/*=============================================================================
* CAMError status
=============================================================================*/

/** CIMaX+ CAM Not Ready. */
#define CAMERROR_RESET 0x0101

/** CIMaX+ CAM CIS buffer not allocate. */
#define CAMERROR_CIS_BUFFER 0x0201

/** CIMaX+ CAM CIS bad size (> 512 bytes). */
#define CAMERROR_CIS_BAD_SIZE 0x0202

/** CIMaX+ CAM CAM Not Activated. */
#define CAMERROR_CIS_CAM_NOT_ACTIVATED 0x0203

/** CIMaX+ CAM CAM not ready after software reset during write COR process. */
#define CAMERROR_COR_CAM_NOT_READY 0x0301

/** CIMaX+ CAM Checking of COR Value failed. */
#define CAMERROR_COR_VALUE_CHECKING 0x0302

/** CIMaX+ CAM CAM not responding after SR bit is raised during Buffer negociation phase. */
#define CAMERROR_NEGOTIATE_NOT_RESPONDING 0x0401

/** CIMaX+ CAM CAM buffer size length <> 2. */
#define CAMERROR_NEGOTIATE_SIZE_LENGTH 0x0402

/** CIMaX+ CAM CAM not ready to accept new buffer size negociate during Buffer negociation phase. */
#define CAMERROR_NEGOTIATE_NOT_READY 0x0403

/** CIMaX+ CAM LPDU not available. */
#define CAMERROR_LPDU_NOT_AVAILABLE 0x0601

/** A return value in case of no errors. */
#define CIMAX_NO_ERROR 0

/** A return value in case of errors. */
#define CIMAX_ERROR -1

/** A return value in case of USB communication errors. */
#define CIMAX_USB_COMM_ERROR -2

/** A return value in case of timeout error. */
#define CIMAX_TIMEOUT_ERROR -3

/** A return value in case of init response error. */
#define CIMAX_INIT_RESP_ERROR -4

/** A return value in case of write response error. */
#define CIMAX_WRITE_RESP_ERROR -5

/** A return value in case of read response error. */
#define CIMAX_READ_RESP_ERROR -6

/** A return value in case of command parse error. */
#define CIMAX_CMD_PARSE_ERROR -7

/** A return value in case of boot command error. */
#define CIMAX_BOOT_CMD_ERROR -8

/** A return value in case of invalid slot ID error. */
#define CIMAX_INVALID_SLOT_ID_ERROR -10

/** A return value in case of CAM response error. */
#define CIMAX_CAM_RESPONSE_ERROR -11

/** A return value in case of no CAM error. */
#define CIMAX_NO_CAM_ERROR -12

/** A return value in case of CAM error. */
#define CIMAX_CAM_ERROR -13

/** A return value in case of CAM write busy error. */
#define CIMAX_CAM_WRITE_BUSY_ERROR -15

/** A return value in case of CAM command pending. */
#define CIMAX_CAM_CMD_PENDING -16

/* Status register bits */
#define PCCD_RE 0x01    /* Read error */
#define PCCD_WE 0x02    /* Write error */
#define PCCD_FR 0x40    /* Free */
#define PCCD_DA 0x80    /* Data available */

#define WRITECOR_RETRY_TIMES (10)
#define WRITECOR_DELAY_TIME (500)

#define IOWR_RETRY_TIMES (100)
#define IOWR_DELAY_TIME (10)
#define RESET_RETRY_TIMES (10)
#define RESET_DELAY_TIME (100)
#define DEV_RETRY_TIMES (30)
#define DEV_DELAY_TIME (100)

#define RESET_WAIT_TIME (500)
#define PROBE_WAIT_TIME (50)

/** Read register. */
#define REG_OP_READ (0)

/** Write register. */
#define REG_OP_WRITE (1)

/** Read register until some bits are set. */
#define REG_OP_WAIT_TO_BE_SET (2)

/** Read register until some bits are cleared. */
#define REG_OP_WAIT_TO_BE_CLEARED (3)

/** Read register until it's value is not equal to defined. */
#define REG_OP_WAIT_EQUAL (4)

/** Perform logical AND over register. */
#define REG_OP_LOGICAL_AND (5)

/** Perform logical OR over register. */
#define REG_OP_LOGICAL_OR (6)

/** Wait timeout in miliseconds. */
#define REG_OP_WAIT (7)

#define CKMAN_CONFIG 0x0048
#define CKMAN_SELECT 0x0049
#define USB2TS_CTRL 0x0221
#define USB2TS0_RDL 0x0222
#define USB2TS1_RDL 0x0223
#define TS2USB_CTRL 0x0224
#define TSOUT_PAR_CTRL 0x0225
#define TSOUT_PAR_CLK_SEL 0x0226
#define S2P_CH0_CTRL 0x0227
#define S2P_CH1_CTRL 0x0228
#define P2S_CH0_CTRL 0x0229
#define P2S_CH1_CTRL 0x022A
#define TS_IT_STATUS 0x022B
#define TS_IT_MASK 0x022C
#define IN_SEL 0x022D
#define OUT_SEL 0x022E
#define ROUTER_CAM_CH 0x022F
#define ROUTER_CAM_MOD 0x0230
#define FIFO_CTRL 0x0231
#define GAP_REMOVER_CH0_CTRL 0x0234
#define GAP_REMOVER_CH1_CTRL 0x0235
#define SYNC_RTV_CTRL 0x0236
#define MERGER_DIV_MOCLK 0x02C0
#define SYNC_SYMBOL 0x02C3
#define PID_AND_SYNC_REMAPPER_INV_CTRL 0x02C4
#define CFG_0                             0x0201
#define CFG_1                             0x0202
#define CFG_2                             0x0203
#define GPIO0_DIR                         0x020B
#define GPIO0_DATA_IN                     0x020C
#define GPIO0_DATA_OUT                    0x020D
#define GPIO0_STATUS                      0x020E
#define GPIO0_IT_MASK                     0x020F
#define GPIO0_DFT                         0x0210
#define GPIO0_MASK_DATA                   0x0211
#define GPIO1_DIR                         0x0212
#define GPIO1_DATA_IN                     0x0213
#define GPIO1_DATA_OUT                    0x0214
#define GPIO1_STATUS                      0x0215
#define GPIO1_IT_MASK                     0x0216

#define RESET_REG_NUM (8)
#define IN_SEL_RESET_POS (0)
#define OUT_SEL_RESET_POS (1)
#define ROUTER_CAM_MOD_POS (RESET_REG_NUM)          
#define ROUTER_CAM_CH_POS (1 + ROUTER_CAM_MOD_POS)  /*selects the source for the channel 0 out and/or channel 1 out*/
#define CKMAN_SELECT_POS (2 + ROUTER_CAM_CH_POS)    /*selects the source for the module A and/or module B*/
#define CKMAN_CONFIG_POS (1 + CKMAN_SELECT_POS)     /*handles the clock enabling / disabling of the clock digital inputs and sources.*/
#define GAP_REMOVER_0_POS (1 + CKMAN_CONFIG_POS)    /*GAP REMOVER0 control */
#define GAP_REMOVER_1_POS (1 + GAP_REMOVER_0_POS)   /*GAP REMOVER1 control */
#define S2P_CH0_CTRL_POS (1 + GAP_REMOVER_1_POS)    /*Serial to parallel contrl of ch0*/
#define P2S_CH0_CTRL_POS (1 + S2P_CH0_CTRL_POS)     /*Parallel to serial contrl of ch0*/
#define S2P_CH1_CTRL_POS (1 + P2S_CH0_CTRL_POS)     /*Serial to parallel contrl of ch1*/
#define P2S_CH1_CTRL_POS (1 + S2P_CH1_CTRL_POS)     /*Parallel to serial contrl of ch1*/
#define USB2TS_CTRL_POS (1 + P2S_CH1_CTRL_POS)      /*USB to TS contrl*/
#define USB2TS0_RDL_POS (1 + USB2TS_CTRL_POS)       /*USB to TS0 read length*/
#define USB2TS1_RDL_POS (1 + USB2TS0_RDL_POS)       /*USB to TS1 read length*/
#define OUT_SEL_POS (1 + USB2TS1_RDL_POS)           /*Source select of TS out*/
#define IN_SEL_POS (1 + OUT_SEL_POS)                /*Source select of TS in*/

#define ROUTER_CAM_MODA_NONE (0x00)
#define ROUTER_CAM_MODA_FROM_CH0IN (0x01)
#define ROUTER_CAM_MODA_FROM_CH1IN (0x02)
#define ROUTER_CAM_MODA_FROM_PSREMAPPER (0x03)
#define ROUTER_CAM_MODA_FROM_PREHEADERADDER (0x04)
#define ROUTER_CAM_MODA_FROM_MODB (0x05)
#define ROUTER_CAM_MODA_FROM_GAPREMOVER0 (0x06)
#define ROUTER_CAM_MODA_FROM_GAPREMOVER1 (0x07)
#define ROUTER_CAM_MODB_NONE (0x00)
#define ROUTER_CAM_MODB_FROM_CH0IN (0x10)
#define ROUTER_CAM_MODB_FROM_CH1IN (0x20)
#define ROUTER_CAM_MODB_FROM_PSREMAPPER (0x30)
#define ROUTER_CAM_MODB_FROM_PREHEADERADDER (0x40)
#define ROUTER_CAM_MODB_FROM_MODA (0x50)
#define ROUTER_CAM_MODB_FROM_GAPREMOVER0 (0x60)
#define ROUTER_CAM_MODB_FROM_GAPREMOVER1 (0x70)

#define ROUTER_CAM_CH_0_OUT_SEL_MODA (0x00)
#define ROUTER_CAM_CH_0_OUT_SEL_CH0IN (0x01)
#define ROUTER_CAM_CH_0_OUT_SEL_CH1IN (0x02)
#define ROUTER_CAM_CH_0_OUT_SEL_PSREMAPPER (0x03)
#define ROUTER_CAM_CH_0_OUT_SEL_PREHEADERADDER (0x04)
#define ROUTER_CAM_CH_0_OUT_SEL_MODB (0x05)
#define ROUTER_CAM_CH_0_OUT_SEL_GAPREMOVER0 (0x06)
#define ROUTER_CAM_CH_0_OUT_SEL_GAPREMOVER1 (0x07)
#define ROUTER_CAM_CH_1_OUT_SEL_MODB (0x00)
#define ROUTER_CAM_CH_1_OUT_SEL_CH0IN (0x10)
#define ROUTER_CAM_CH_1_OUT_SEL_CH1IN (0x20)
#define ROUTER_CAM_CH_1_OUT_SEL_PSREMAPPER (0x30)
#define ROUTER_CAM_CH_1_OUT_SEL_PREHEADERADDER (0x40)
#define ROUTER_CAM_CH_1_OUT_SEL_MODA (0x50)
#define ROUTER_CAM_CH_1_OUT_SEL_GAPREMOVER0 (0x60)
#define ROUTER_CAM_CH_1_OUT_SEL_GAPREMOVER1 (0x70)

#define CKMAN_CONFIG_S0CLK_DISABLE (0x00)
#define CKMAN_CONFIG_S0CLK_ENABLE (0x40)
#define CKMAN_CONFIG_S1CLK_DISABLE (0x00)
#define CKMAN_CONFIG_S1CLK_ENABLE (0x20)
#define CKMAN_CONFIG_PROCCLK_DISABLE (0x00)
#define CKMAN_CONFIG_PROCCLK_ENABLE (0x10)
#define CKMAN_CONFIG_DEFALUT (0x0F)

#define CKMAN_SELECT_S0CLK_27MHZ (0x00)
#define CKMAN_SELECT_S0CLK_54MHZ (0x10)
#define CKMAN_SELECT_S0CLK_72MHZ (0x20)
#define CKMAN_SELECT_S0CLK_108MHZ (0x30)
#define CKMAN_SELECT_S1CLK_27MHZ (0x00)
#define CKMAN_SELECT_S1CLK_54MHZ (0x04)
#define CKMAN_SELECT_S1CLK_72MHZ (0x08)
#define CKMAN_SELECT_S1CLK_108MHZ (0x0C)
#define CKMAN_SELECT_PROCCLK_54MHZ (0x00)
#define CKMAN_SELECT_PROCCLK_72MHZ (0x01)
#define CKMAN_SELECT_PROCCLK_108MHZ (0x02)

#define GAP_REMOVER_DISABLE (0x00)
#define GAP_REMOVER_ENABLE (0x13)
#define GAP_REMOVER_FOR_USB (0x13)

#define S2P_CTRL_DISABLE (0x00)
#define P2S_CTRL_DISABLE (0x00)
#define S2P_CTRL_ENABLE (0x23)
#define P2S_CTRL_ENABLE (0x59)

#define USB2TS_CTRL_DISABLE (0x00)
#define USB2TS_CTRL_0_ENABLE (0x03)
#define USB2TS_CTRL_1_ENABLE (0x0C)

#define TS2USB_CTRL_DISABLE (0x00)
#define TS2USB_CTRL_0_ENABLE (0x03)
#define TS2USB_CTRL_1_ENABLE (0x0C)

#define USB2TS0_RDL_DISABLE (0x80)

/*
 * 0x25 - 0x38
 * The best value:0x28(40)
 * F(read) = 40*54/256 = 8.4375MHz, the actual frequency is 8.973MHz.
 */
#define USB2TS0_RDL_ENABLE (0x28)

#define USB2TS1_RDL_DISABLE (0x80)
#define USB2TS1_RDL_ENABLE (0x28)

#define OUT_SEL_TSSE_DISABLE (0x00)
#define OUT_SEL_TSSE_P2S1 (0x04)
#define OUT_SEL_TSP_DISABLE (0x00)
#define OUT_SEL_TSP_TSOUTP (0x01)
#define OUT_SEL_TSP_P2S0 (0x02)    
#define OUT_SEL_TSP_CH0OUT (0x03)  

#define IN_SEL_CH_0_IN_SEL_NULL (0x00)
#define IN_SEL_CH_0_IN_SEL_TSINP (0x01)
#define IN_SEL_CH_0_IN_SEL_USBEP3 (0x02)
#define IN_SEL_CH_0_IN_SEL_TSINS1 (0x04)
#define IN_SEL_CH_0_IN_SEL_TSINS2 (0x05)
#define IN_SEL_CH_0_IN_SEL_TSINS3 (0x06)
#define IN_SEL_CH_0_IN_SEL_TSINS4 (0x07)
#define IN_SEL_CH_1_IN_SEL_NULL (0x00)
#define IN_SEL_CH_1_IN_SEL_TSINP (0x10)
#define IN_SEL_CH_1_IN_SEL_USBEP4 (0x20)
#define IN_SEL_CH_1_IN_SEL_TSINS1 (0x40)
#define IN_SEL_CH_1_IN_SEL_TSINS2 (0x50)
#define IN_SEL_CH_1_IN_SEL_TSINS3 (0x60)
#define IN_SEL_CH_1_IN_SEL_TSINS4 (0x70)

#define MAX_FW_PKT_SIZE	      255

#define INTVECT_VECTORS_LEN   0x06
#define START_INTVECT_ADDR	  0xFFFA
#define STOP_INTVECT_ADDR	  (START_INTVECT_ADDR + INTVECT_VECTORS_LEN -1)

#define FW_SIGNATURE_ADDR     0x80
#define FW_SIGNATURE_LEN      0x02

#define FW_SIZE_ADDR          0x8D
#define FW_SIZE_LEN           0x02

#define BISTROM_LAUNCH_ADDR   0x82
#define BISTROM_LAUNCH_SIZE   0x01

#define BOOT_STATUS_REG_ADDR  0x0009

#define START_FW_ADDR	      0x8000
#define STOP_FW_ADDR	      0xCFF9
#define FW_SIZE               (STOP_FW_ADDR - START_FW_ADDR + 1 + INTVECT_VECTORS_LEN)

#define MAX_SPI_INT_RECHECK_COUNT  1000

#define MIN(a,b) ((a)<(b) ? (a) : (b))

#ifdef HI_CIMAXPLUS_MODE_SPI
#define SPI_READ(dev, data, size)  HI_DRV_SPI_ReadQuery((dev), (data), (size))  
#define SPI_WRITE(dev, data, size) HI_DRV_SPI_WriteQuery((dev), (data), (size))  
#ifdef USE_GPIO_SPI_FUNC
#define SPI_CS0_CI     (2*8+3)
#define SPI_CLK0_CI    (2*8+0)
#define SPI_MISO0_CI   (2*8+2)
#define SPI_MOSI0_CI   (2*8+1)
#define SPI_CS1_CI     (5*8+3)
#define SPI_CLK1_CI    (5*8+1)
#define SPI_MISO1_CI   (5*8+2)
#define SPI_MOSI1_CI   (16*8+0) 
#define SPI_CS2_CI     (16*8+5)
#define SPI_CLK2_CI    (16*8+2)
#define SPI_MISO2_CI   (16*8+3)
#define SPI_MOSI2_CI   (16*8+0) 
#undef  SPI_READ
#undef  SPI_WRITE
#define SPI_READ(dev, data, size)  GPIO_SPI_Read((dev), (data), (size))
#define SPI_WRITE(dev, data, size) GPIO_SPI_Write((dev), (data), (size))
#endif
#endif

/*************************** Structure Definition ****************************/

typedef enum hiCIMAXPLUS_WORK_MODE
{
    CIMAXPLUS_WORK_MODE_BOOT,
    CIMAXPLUS_WORK_MODE_FW     
}CIMAXPLUS_WORK_MODE_S;

/**
 * @struct REG_SETTING_S
 * @brief The structure to represent register settings.
 */
typedef struct
{
    /** CIMaX+ register address. */
    HI_U16 u16Reg;

    /** CIMaX+ register value. */
    HI_U8 u8Val;

    /** CIMaX+ register operation. */
    HI_U8 u8Op;
} REG_SETTING_S;

/* CI PC CARD configure and management structure */
typedef struct hiCIMAXPLUS_PCCD_PARAMETER
{
    CI_PCCD_ATTR_S      stAttr;     /* Voltage, speed, ... */
    HI_BOOL             bPlugIn;    /* Slot card plug status */
    HI_BOOL             bTSByPass;  /* Slot TS ByPass status */
    HI_UNF_CI_TS_MODE_E enTSMode;   /* Slot TS pass mode */
    HI_U8               u8MODSelection; /* Source Selection for Module(When non-bypass) */
    HI_U8               u8CHOutSelection; /* Source Selection for CHannel out(When bypass) */
    HI_UNF_CI_TSI_SERIAL_PORT_E enTsiSerialPort;
    HI_CI_PCCD_RUN_STEP enRunStep;
} CIMAXPLUS_PCCD_PARAMETER_S;

/* CI driver configure structure */
typedef struct hiCIMAXPLUS_PARAMETER_S
{
    HI_U32 u32ResetGpioNo;
    HI_U32 u32IntGpioNo; 
    HI_U32 u32SpiDevNum;
    CIMAXPLUS_WORK_MODE_S  enWorkMode;
    HI_UNF_CI_TSI_MODE_E enTSIMode; /* The mode of CI Transport Stream Interface connection */
    HI_UNF_CI_CMD_EXCHANGE_CHAN_E  enCmdExchangeChan;
    struct file *pFILE;
    CIMAXPLUS_PCCD_PARAMETER_S astCardParam[HI_UNF_CI_PCCD_BUTT];
} CIMAXPLUS_PARAMETER_S;

typedef struct
{
  HI_U8* txData;
  HI_U32 txSize;
  HI_U8* rxData;
  HI_U32 rxSize;
} CIMAXPLUS_ACCESS_DATA_S;

typedef long unsigned int HI_UL;

/*************************** Global Declarations *****************************/

/*************************** Static Declarations *****************************/

static GPIO_EXT_FUNC_S* s_pGpioFunc = HI_NULL;

static REG_SETTING_S s_astDevConfig[] =
{
    /** TS interface init. */
    {IN_SEL,               0x00, REG_OP_WRITE}, /** Close TS input. */
    {OUT_SEL,              0x00, REG_OP_WRITE}, /** Close TS output. */
    {FIFO_CTRL,            0x0f, REG_OP_WRITE}, /** Reset TS FIFO. */
    {SYNC_RTV_CTRL,        0x0f, REG_OP_WRITE},
    {S2P_CH0_CTRL,         0x00, REG_OP_WRITE},
    {P2S_CH0_CTRL,         0x00, REG_OP_WRITE},
    {S2P_CH1_CTRL,         0x00, REG_OP_WRITE},
    {P2S_CH1_CTRL,         0x00, REG_OP_WRITE},

    /** Set router CAM. */
    {ROUTER_CAM_MOD,       0x00, REG_OP_WRITE}, 
    {ROUTER_CAM_CH,        0x00, REG_OP_WRITE},
    {0x0000,	           200, REG_OP_WAIT }, /** Wait 200 miliseconds. */

    /** Set CLOCK. */
    {CKMAN_SELECT,         0x00, REG_OP_WRITE},
    {CKMAN_CONFIG,         0x00, REG_OP_WRITE},

    {GAP_REMOVER_CH0_CTRL, 0x00, REG_OP_WRITE},
    {GAP_REMOVER_CH1_CTRL, 0x00, REG_OP_WRITE},

    /* Set serial */
    {S2P_CH0_CTRL,         0x00, REG_OP_WRITE},
    {P2S_CH0_CTRL,         0x00, REG_OP_WRITE},
    {S2P_CH1_CTRL,         0x00, REG_OP_WRITE},
    {P2S_CH1_CTRL,         0x00, REG_OP_WRITE},

    /* Only use TS2USB, don't use USB2TS */
    {USB2TS_CTRL,          0x00, REG_OP_WRITE},
    {USB2TS0_RDL,          0x80, REG_OP_WRITE},
    {USB2TS1_RDL,          0x80, REG_OP_WRITE},

    /** Set In/Out. */
    {OUT_SEL,              0x00, REG_OP_WRITE}, 
    {IN_SEL,               0x00, REG_OP_WRITE}, 

    /** CAM power. */
    {GPIO0_DATA_OUT,  0x00, REG_OP_WRITE},
    {CFG_2,           0x00, REG_OP_WRITE},          /** Unlock CFG. */
    {CFG_1,           0x00, REG_OP_WRITE},          /** 1) DVB/CI/CI+/SCARD 2slot. */
    {GPIO0_DFT,       0x00, REG_OP_WRITE},          /** 2) Set the Default "power off" state such as VCC_MODA=VCC_MODB=VPPx_MODA=VPPx_MODB='Z'. */
    {GPIO0_MASK_DATA, 0x07, REG_OP_WRITE},          /** 3) Set GPIO3 as external power switch driver. */
    {GPIO0_DATA_OUT,  0x01, REG_OP_WRITE},          /** 4) Set "power on" state (VCC=VPP1=VPP2= 5V). */
    {CFG_2,           0x01, REG_OP_WRITE},          /** 5) Lock config. */
    {GPIO0_DIR,       0x07, REG_OP_WRITE},          /** 6) Write in the GPIO0_DIR_REG: defines the GPIOs, which are used to drive the external power switch, in output mode. */
    {CFG_1,           0x20, REG_OP_WAIT_TO_BE_SET}, /** 7) Check VCCENable. */
    {CFG_1,           0x08, REG_OP_LOGICAL_OR},     /** 8) Set & wait for PcmciaOutputEnable. */
    {CFG_1,           0x08, REG_OP_WAIT_TO_BE_SET},
};

static CIMAXPLUS_PARAMETER_S s_astCIMaXPlusParam[HI_UNF_CI_PORT_BUTT];

#ifdef HI_CIMAXPLUS_MODE_SPI
 
static unsigned char s_cimax_firmware_bin[] = {
#include "cimax_spidvb_211.bin.txt"
};
#endif

/* Read extended register for CIMaX+ */
static HI_S32        CIMAXPLUS_ReadExReg(HI_UNF_CI_PORT_E enCIPort, HI_U32 u32Address, HI_U8* pu8Buffer, HI_U32 u32NumOfBytes);

/* Write extended register for CIMaX+ */
static HI_S32        CIMAXPLUS_WriteExReg(HI_UNF_CI_PORT_E enCIPort, HI_U32 u32Address, HI_U8* pu8Value, HI_U32 u32NumOfBytes);

static HI_S32 CIMAXPLUS_AccessCAM(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_U8 u8Cmd,
                                  const HI_U8 *pu8BufferOut, HI_U16 u16NumOfBytes, HI_U8 *pu8BufferIn,
                                  HI_U32 u32NumOfBytesIn);
#ifdef HI_CIMAXPLUS_MODE_SPI
static HI_U32 CIMAXPLUS_SPI_GetEvt(HI_UNF_CI_PORT_E enCIPort);
static HI_S32 CIMAXPLUS_Access(HI_UNF_CI_PORT_E enCIPort, CIMAXPLUS_ACCESS_DATA_S *pstAccessData);
static HI_U32 CIMAXPLUS_SPI_Write(HI_UNF_CI_PORT_E enCIPort, HI_U8 *Write, HI_U32 WriteCnt);
static HI_U32 CIMAXPLUS_SPI_Read(HI_UNF_CI_PORT_E enCIPort, HI_U8 *Read, HI_U32 ReadCnt);
#endif

/******************************* API declaration *****************************/

static void CIMAXPLUS_PrintData(HI_U8 *pbName, HI_U8 *pbData, HI_U32 u32Size)
{  
    int i;

    HI_PRINT("%s ", pbName);
    for (i=0; i<u32Size; i++)
    {

        HI_PRINT("0x%02X ", pbData[i]);
        if(((i+1) % 16) == 0)
            HI_PRINT("\n   ");  
    }
    if (( i % 16) != 0)
    {
        HI_PRINT("\n");
    }
}


#ifdef HI_CIMAXPLUS_MODE_SPI
static HI_S32 CIMAXPLUS_SPI_Init(HI_UNF_CI_PORT_E enCIPort)
{
    HI_S32 s32Ret = HI_SUCCESS;

#ifdef USE_GPIO_SPI_FUNC
    GPIO_SPI_S stGpioSpi[] = 
    {
        {SPI_CS0_CI, SPI_CLK0_CI, SPI_MISO0_CI, SPI_MOSI0_CI},
        {SPI_CS1_CI, SPI_CLK1_CI, SPI_MISO1_CI, SPI_MOSI1_CI},
        {SPI_CS2_CI, SPI_CLK2_CI, SPI_MISO2_CI, SPI_MOSI2_CI}
    };
    s32Ret = GPIO_SPI_Init();  
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_CI("GPIO SPI Init failed :%d.\n", s32Ret);
        return s32Ret;
    }
	
    if (s_astCIMaXPlusParam[enCIPort].u32SpiDevNum >= (sizeof(stGpioSpi)/sizeof(stGpioSpi[0])))
    { 
        HI_ERR_CI("Invalid SPI GPIO number %d.\n", s_astCIMaXPlusParam[enCIPort].u32SpiDevNum);
        return HI_FAILURE;
    }
	
    s32Ret = GPIO_SPI_Create(&stGpioSpi[s_astCIMaXPlusParam[enCIPort].u32SpiDevNum], &s_astCIMaXPlusParam[enCIPort].u32SpiDevNum);  
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_CI("Create GPIO SPI failed :%d.\n", s32Ret);
        return s32Ret;
    } 
#else
    s32Ret = HI_DRV_SPI_Open(s_astCIMaXPlusParam[enCIPort].u32SpiDevNum);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_CI("Open SPI device(%d)failed :%d.\n", s_astCIMaXPlusParam[enCIPort].u32SpiDevNum, s32Ret);
        return s32Ret;
    }

   /* Motorola¡¯s standard SPI mode 0 */
    s32Ret = HI_DRV_SPI_SetFrom(s_astCIMaXPlusParam[enCIPort].u32SpiDevNum, 0, 1, 1, 8);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_CI("Set SPI from (%d)failed :%d.\n", s_astCIMaXPlusParam[enCIPort].u32SpiDevNum, s32Ret);
        return s32Ret;
    }

    /* big/little end, 0: little, 1: big */
    HI_DRV_SPI_SetBlend(s_astCIMaXPlusParam[enCIPort].u32SpiDevNum, 0);
#endif
    if ((s_pGpioFunc) && (s_pGpioFunc->pfnGpioDirSetBit))
    {
        s32Ret = s_pGpioFunc->pfnGpioDirSetBit(s_astCIMaXPlusParam[enCIPort].u32IntGpioNo, 1);//input
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_CI("CIMAXPLUS SPI Init fail.\n");
        }

    }

    s_astCIMaXPlusParam[enCIPort].enWorkMode = CIMAXPLUS_WORK_MODE_BOOT;
        
    return HI_SUCCESS;
    
}

HI_U32 CIMAXPLUS_SPI_Read(HI_UNF_CI_PORT_E enCIPort, HI_U8 *Read, HI_U32 ReadCnt)
{
    HI_U32   u32Val;
    HI_U16   dataLen = 0;
    HI_U32   s32Ret;
    HI_U32   i;
    HI_U8    u8Ch;

    if ((s_astCIMaXPlusParam[enCIPort].enWorkMode == CIMAXPLUS_WORK_MODE_FW) 
      && (s_pGpioFunc) && (s_pGpioFunc->pfnGpioReadBit))
    {
        for (i=0; i<MAX_SPI_INT_RECHECK_COUNT; i++)
        {
            s32Ret = s_pGpioFunc->pfnGpioReadBit(s_astCIMaXPlusParam[enCIPort].u32IntGpioNo, &u32Val);
            if (HI_SUCCESS != s32Ret)
            {
                HI_ERR_CI("CIMAXPLUS SPI Init fail.\n");
            }
            HI_INFO_CI("INT_GPIO 0x%x\n", u32Val);
            if ((u32Val&0x01) == 0x00)
            {
                break;
            }
            msleep(1);
         }
         if (i >= MAX_SPI_INT_RECHECK_COUNT)
         {
            HI_INFO_CI("INT_GPIO NO CLEAN (0x%x)\n", u32Val);
    //          return CIMAX_TIMEOUT_ERROR;
         }
    }
    else
    {
        msleep(1);
    }

    for(i=0; i<1000; i++)
    {
       SPI_READ(s_astCIMaXPlusParam[enCIPort].u32SpiDevNum, &Read[0], 1);
       if(Read[0] != 0x00)
       {
            break;
       }
       msleep(1);
    }
      
    /* Get response header. */
    SPI_READ(s_astCIMaXPlusParam[enCIPort].u32SpiDevNum, &Read[1], CIMAX_REGISTER_HEADER_SIZE - 1);
    ReadCnt-=CIMAX_REGISTER_HEADER_SIZE;
    /* Parse header. */
    switch(Read[CIMAX_REGISTER_CMD_POS] & CIMAX_CAM_TYP_CMD_MASK)
    {
    case CIMAX_REGISTER_INIT_RESP_OK:   /* Fall through. */
    case CIMAX_REGISTER_INIT_RESP_NOK:  /* Fall through. */
    case CIMAX_REGISTER_WRITE_RESP_OK:  /* Fall through. */
    case CIMAX_REGISTER_WRITE_RESP_NOK: /* Fall through. */
    case CIMAX_REGISTER_READ_RESP_OK:   /* Fall through. */
    case CIMAX_REGISTER_READ_RESP_NOK:  /* Fall through. */
    case CIMAX_REGISTER_CMD_PARSE_ERROR:
        dataLen = Read[CIMAX_REGISTER_NUM_OF_REGS_POS];
    break;
    default:
        /* Get data length for CAM response. */
        dataLen = Read[CIMAX_CAM_DATA_LEN_MSB_POS];
        dataLen = (dataLen << 8);
        dataLen = dataLen | Read[CIMAX_CAM_DATA_LEN_LSB_POS];
    }
    /* Read CAM response payload if needed. */
    if (dataLen > 0)
    {
        SPI_READ(s_astCIMaXPlusParam[enCIPort].u32SpiDevNum,&Read[CIMAX_CAM_HEADER_SIZE], MIN(dataLen, ReadCnt));
    }
#ifdef _DEBUG  
    CIMAXPLUS_PrintData("-<", Read, CIMAX_REGISTER_HEADER_SIZE + dataLen);
#endif
    for(i=ReadCnt; i<dataLen;i++)
    {
        SPI_READ(s_astCIMaXPlusParam[enCIPort].u32SpiDevNum,&u8Ch, 1); 
    }
    return HI_SUCCESS;
}

HI_U32 CIMAXPLUS_SPI_Write(HI_UNF_CI_PORT_E enCIPort, HI_U8 *Write, HI_U32 WriteCnt)
{
   SPI_WRITE(s_astCIMaXPlusParam[enCIPort].u32SpiDevNum, Write, WriteCnt);
#ifdef _DEBUG  
   CIMAXPLUS_PrintData("->", Write, WriteCnt);
#endif
   return HI_SUCCESS;
}

static HI_S32 CIMAXPLUS_SPI_FWStart(HI_UNF_CI_PORT_E enCIPort)
{
    HI_U32 s32Ret;
    HI_UCHAR abSendBuffer[CIMAX_REGISTER_HEADER_SIZE] = {0};
    HI_UCHAR abRcvdBuffer[CIMAX_REGISTER_HEADER_SIZE] = {0};
   
    abSendBuffer[0] = CIMAX_REGISTER_INIT_REQ;
    abSendBuffer[1] = 0x00;
    abSendBuffer[2] = 0x00;
    abSendBuffer[3] = 0x00;
    s32Ret = CIMAXPLUS_SPI_Write(enCIPort, abSendBuffer, CIMAX_REGISTER_HEADER_SIZE);
    if (0 != s32Ret)
    {
        HI_ERR_CI("Write cimax+ reg enq fail:%d.\n", s32Ret);
        return HI_ERR_CI_REG_WRITE_ERR;
    }
    s32Ret = CIMAXPLUS_SPI_Read(enCIPort, abRcvdBuffer, CIMAX_REGISTER_HEADER_SIZE);
    if (0 != s32Ret)
    {
        HI_ERR_CI("Read cimax+ reg write resp fail:%d.\n", s32Ret);
        return HI_ERR_CI_REG_READ_ERR;
    }
    if (abRcvdBuffer[0] != CIMAX_REGISTER_INIT_REQ_OK)
    {
        HI_ERR_CI("FW start (%d) NOK.\n", enCIPort);
        return HI_FAILURE;
    }
    return HI_SUCCESS;
}

HI_U32 CIMAXPLUS_SPI_GetEvt(HI_UNF_CI_PORT_E enCIPort)
{
    HI_U32 s32Ret;
    HI_U32 u32Evt;
    HI_UCHAR abSendBuffer[CIMAX_REGISTER_HEADER_SIZE] = {0};
    HI_UCHAR abRcvdBuffer[CIMAX_REGISTER_HEADER_SIZE + 2] = {0};
   
    abSendBuffer[0] = CIMAX_CAM_GET_EVT;
    abSendBuffer[1] = 0x01;
    abSendBuffer[2] = 0x00;
    abSendBuffer[3] = 0x00;
    s32Ret = CIMAXPLUS_SPI_Write(enCIPort, abSendBuffer, CIMAX_REGISTER_HEADER_SIZE);
    if (0 != s32Ret)
    {
        HI_ERR_CI("Write cimax+ reg enq fail:%d.\n", s32Ret);
        return HI_ERR_CI_REG_WRITE_ERR;
    }
    s32Ret = CIMAXPLUS_SPI_Read(enCIPort, abRcvdBuffer, CIMAX_REGISTER_HEADER_SIZE+2);
    if (0 != s32Ret)
    {
        HI_ERR_CI("Read cimax+ reg resp fail:%d.\n", s32Ret);
        return HI_ERR_CI_REG_READ_ERR;
    }
    switch(abRcvdBuffer[0])
    {
    case CIMAX_CAM_A_DET_OK:
        HI_INFO_CI("CAM A Det %d\n", abRcvdBuffer[4]);
        break;
    case CIMAX_CAM_B_DET_OK:
        HI_INFO_CI("CAM B Det %d\n", abRcvdBuffer[4]);
        break;
    case CIMAX_CAM_A_DATA_READY:
        HI_INFO_CI("CAM A data reday.\n");
        break;
    case CIMAX_CAM_B_DATA_READY:
        HI_INFO_CI("CAM B data reday.\n");
        break;
    case CIMAX_STATUS_GPIO_EVT:
        HI_INFO_CI("GPIOs  change %d.\n", abRcvdBuffer[4]);
        break;
    case CIMAX_CAM_NO_EVT:
        HI_INFO_CI("CAM no evt.\n");
        break;
    case CIMAX_CAM_PARSE_ERROR:
        HI_INFO_CI("CAM PARSE ERROR: 0x%02X%02X.\n", abRcvdBuffer[4], abRcvdBuffer[5]);
        break;
    default:
         HI_INFO_CI("Unknow evt 0x%02X.\n", abRcvdBuffer[0]);
         break;
    }

    u32Evt = (abRcvdBuffer[0] << 8) | abRcvdBuffer[4];

    return u32Evt;
}

static HI_S32 CIMAXPLUS_MISR(const HI_UCHAR *ptr, int size, HI_U32 FWSign)
{
   HI_S32 k, i;
   HI_U16 mySign;

   for ( k=0; k<size; k++ )
   {
      mySign = ptr[k]&0x01;

      for (i=0; i<16; i++)
         if ( 0x88B7&(1<<i) )
            mySign ^= (FWSign>>i)&0x01;

      mySign |= ((FWSign<<1)^(ptr[ k ]))&0x00FE;
      mySign |= (FWSign<<1) & 0x00FF00;

      FWSign = mySign;
   }

   return FWSign;
}

static HI_S32 CIMAXPLUS_SPI_FwUpload(HI_UNF_CI_PORT_E enCIPort)
{
   HI_S32 s32Ret = HI_SUCCESS;
   HI_UCHAR *ptr;
   HI_U32 startAddr = START_FW_ADDR;
   HI_U32 size; 
   HI_U32 i;
   HI_S32 FWSign = 0;
   HI_UCHAR abVal[MAX_FW_PKT_SIZE];
   CIMAXPLUS_ACCESS_DATA_S stAccessData;
    
    /*1.  Copy FW binary files from address @0x8000 */
    HI_INFO_CI("1.  Copy FW binary files from address @0x8000\n");
    ptr = &s_cimax_firmware_bin[START_FW_ADDR];

    do {
        size = ( startAddr <= (STOP_FW_ADDR+1- MAX_FW_PKT_SIZE) ) ? ( MAX_FW_PKT_SIZE) : (STOP_FW_ADDR+1-startAddr);
        HI_INFO_CI("%s: firmware start address %08x size %d\n",__FUNCTION__, startAddr, size);
        s32Ret = CIMAXPLUS_WriteExReg(enCIPort, startAddr, ptr, size);
        if (s32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("Write SPI register(%d)failed :%d.\n", enCIPort, s32Ret);
            return s32Ret;
        }
        /*
        s32Ret = CIMAXPLUS_ReadExReg(enCIPort, startAddr, abVal, size);
        if (s32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("Read SPI register(%d)failed :%d.\n", s_astCIMaXPlusParam[enCIPort].u32SpiDevNum, s32Ret);
            return s32Ret;
        }
        if(memcmp(ptr, abVal, size) != 0)
        {
            HI_ERR_CI("Write SPI register(%d)failed, address %08x size %d\n", s_astCIMaXPlusParam[enCIPort].u32SpiDevNum, startAddr, size);
            return HI_FAILURE;
        }
        */
        startAddr += size;
        ptr += size;
        if(startAddr >= STOP_FW_ADDR) 
        {
            break;
        }
   } while(1);

    /*2. Copy  the  last  6  bytes  of  FW to  address  @0xFFFA */ 
    HI_INFO_CI("2.  Copy  the  last  6  bytes  of  FW to  address  @0xFFFA\n");
    ptr = s_cimax_firmware_bin + START_INTVECT_ADDR;
    s32Ret = CIMAXPLUS_WriteExReg(enCIPort, START_INTVECT_ADDR, ptr, 6);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_CI("Write SPI register(%d)failed :%d.\n", enCIPort, s32Ret);
        return s32Ret;
    }

    /*3.  Compute BISTROM signature of uploaded bytes*/ 
    HI_INFO_CI("3.  Compute BISTROM signature of uploaded bytes\n");
    FWSign = CIMAXPLUS_MISR(s_cimax_firmware_bin+START_FW_ADDR, STOP_FW_ADDR-START_FW_ADDR+1, FWSign);
    FWSign = CIMAXPLUS_MISR(s_cimax_firmware_bin+START_INTVECT_ADDR, INTVECT_VECTORS_LEN, FWSign);
    HI_INFO_CI("FWSign 0x%04x\n", FWSign);//0x828F

    /*4.  Set CIMaX+ signature to 0x80-0x81 */
    HI_INFO_CI("4.  Set CIMaX+ signature to 0x80-0x81");
    abVal[1] = (HI_UCHAR)((FWSign >> 8)&0xFF);
    abVal[0] = (HI_UCHAR)(FWSign&0xFF);
    s32Ret = CIMAXPLUS_WriteExReg(enCIPort, FW_SIGNATURE_ADDR, abVal, FW_SIGNATURE_LEN);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_CI("Write SPI register(%d)failed :%d.\n", enCIPort, s32Ret);
        return s32Ret;
    }

    /*5.  Set CIMaX+ FW size to 0x8D-0x8E */
    HI_INFO_CI("5.  Set CIMaX+ FW size to 0x8D-0x8E\n");
    abVal[1] = (HI_UCHAR)((FW_SIZE >> 8)&0xFF);
    abVal[0] = (HI_UCHAR)(FW_SIZE&0xFF);
    s32Ret = CIMAXPLUS_WriteExReg(enCIPort, FW_SIZE_ADDR, abVal, FW_SIZE_LEN);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_CI("Write SPI register(%d)failed :%d.\n",enCIPort, s32Ret);
        return s32Ret;
    }

    /*5.  Start BISTROM  computation on CIMaX+ */
    HI_INFO_CI("5.  Start BISTROM  computation on CIMaX+\n");
    abVal[0] = 0x0F;
    s32Ret = CIMAXPLUS_WriteExReg(enCIPort, BISTROM_LAUNCH_ADDR, abVal, BISTROM_LAUNCH_SIZE);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_CI("Read SPI data(%d)failed :%d.\n", enCIPort, s32Ret);
        return s32Ret;
    }

   /*6.  Check BISTROM  comparison result (BootStatus register) */
    HI_INFO_CI("6.  Check BISTROM  comparison result (BootStatus register)\n");
    for (i=0; i<50; i++)
    {
        s32Ret = CIMAXPLUS_ReadExReg(enCIPort, BOOT_STATUS_REG_ADDR, abVal, 1);
        if (s32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("Read SPI data(%d)failed :%d.\n", enCIPort, s32Ret);
            return s32Ret;
        }
        if (abVal[0] == 0x02)
        {
            s32Ret = HI_SUCCESS;
            break;
        }
        msleep(1);
    }

    s32Ret = CIMAXPLUS_SPI_FWStart(enCIPort);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_CI("Init FW(%d)failed :%d.\n",enCIPort, s32Ret);
        return s32Ret;
    }
    HI_INFO_CI("7.  BISTROM success, FW Upload end.\n");
    s_astCIMaXPlusParam[enCIPort].enWorkMode = CIMAXPLUS_WORK_MODE_FW;
    msleep(1000);
    abVal[0] = CIMAX_CAM_GET_SW_VER;
    abVal[1] = 0x01; 
    abVal[2] = 0x00; 
    abVal[3] = 0x00;
    stAccessData.txData = abVal;
    stAccessData.txSize = CIMAX_REGISTER_HEADER_SIZE;
    stAccessData.rxData = abVal;
    stAccessData.rxSize = 12;
    s32Ret = CIMAXPLUS_Access(enCIPort, &stAccessData);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_CI("Read SW Ver failed :%d.\n", s32Ret);
        return s32Ret;
    }
    HI_INFO_CI("    => --------------------\n" );
    HI_INFO_CI("    => F.W. Version = %02X.%02X.%02X.%02X.%02X%c\n",abVal[4], abVal[5], abVal[6], abVal[7], abVal[8], abVal[9]);
    HI_INFO_CI("    => Boot Version = %d.%d\n", abVal[10], abVal[11] );
    HI_INFO_CI("    => --------------------\n" );
    
   return s32Ret;
}
#endif //end #ifdef HI_CIMAXPLUS_MODE_SPI


HI_S32 CIMAXPLUS_Access(HI_UNF_CI_PORT_E enCIPort, CIMAXPLUS_ACCESS_DATA_S *pstAccessData)
{
    HI_U32 s32Ret = HI_SUCCESS;
#ifdef HI_CIMAXPLUS_MODE_SPI
    HI_U32 u32Val = 0x00; 
#endif
#ifdef HI_CIMAXPLUS_MODE_USB
    struct file *pFILE;
    ioctl_data_t stData;
#endif

    switch(s_astCIMaXPlusParam[enCIPort].enCmdExchangeChan)
    {
#ifdef HI_CIMAXPLUS_MODE_USB
    case HI_UNF_CI_CMD_EXCHANGE_CHAN_USB:
    {
        pFILE = s_astCIMaXPlusParam[enCIPort].pFILE;
        if (!pFILE)
        {
            return HI_FAILURE;
        }
        stData.txData = pstAccessData->txData;
        stData.txSize = pstAccessData->txSize;
        stData.rxData = pstAccessData->rxData;
        stData.rxSize = pstAccessData->rxSize;
        CI_DRV_IOCTL(pFILE, DEVICE_IOC_CI_WRITE, (HI_UL)&stData);
#ifdef _DEBUG  
        CIMAXPLUS_PrintData("->", pstAccessData->txData, pstAccessData->txSize);
        CIMAXPLUS_PrintData("-<", pstAccessData->rxData, pstAccessData->rxSize);
#endif
        break;
    }
#endif
#ifdef HI_CIMAXPLUS_MODE_SPI 
    case HI_UNF_CI_CMD_EXCHANGE_CHAN_SPI:
    {
        if ((s_astCIMaXPlusParam[enCIPort].enWorkMode == CIMAXPLUS_WORK_MODE_FW) 
            && (s_pGpioFunc) && (s_pGpioFunc->pfnGpioReadBit))
        {
            s32Ret = s_pGpioFunc->pfnGpioReadBit(s_astCIMaXPlusParam[enCIPort].u32IntGpioNo, &u32Val);
            if (HI_SUCCESS != s32Ret)
            {
                HI_ERR_CI("CIMAXPLUS SPI Init fail.\n");
            }
            HI_INFO_CI("INT_GPIO 0x%x\n", u32Val);
            if ((u32Val&0x01) == 0x00)
            {
                CIMAXPLUS_SPI_GetEvt(enCIPort);
                msleep(1);
            }
        }
        else
        {
            msleep(1);
        }

        s32Ret = CIMAXPLUS_SPI_Write(enCIPort, pstAccessData->txData, pstAccessData->txSize);
        if (0 != s32Ret)
        {
            HI_ERR_CI("Write Read cimax+ reg enq fail:%d.\n", s32Ret);
            return HI_ERR_CI_REG_WRITE_ERR;
        }
        s32Ret = CIMAXPLUS_SPI_Read(enCIPort, pstAccessData->rxData, pstAccessData->rxSize);
        if (0 != s32Ret)
        {
            HI_ERR_CI("Read cimax+ reg resp fail:%d.\n", s32Ret);
            return HI_ERR_CI_REG_READ_ERR;
        }
        msleep(1);
        break;
    }
#endif 
    default:
        s32Ret = HI_FAILURE;
        HI_ERR_CI("Unsupport CMD_EXCHANGE_CHAN %d.\n", s_astCIMaXPlusParam[enCIPort].enCmdExchangeChan);
    }
 
    return s32Ret;
}

/* Read extended register for CIMaX+ */
HI_S32 CIMAXPLUS_ReadExReg(HI_UNF_CI_PORT_E enCIPort, HI_U32 u32Address, HI_U8* pu8Buffer, HI_U32 u32NumOfBytes)
{
    HI_S32 s32Ret = HI_SUCCESS;
    HI_U8 au8BufferOut[CIMAX_REGISTER_HEADER_SIZE] = {0};
    HI_U8 au8BufferIn[CIMAX_REGISTER_HEADER_SIZE + CIMAX_REGISTER_MAX_PAYLOAD_SIZE] = {0};
    CIMAXPLUS_ACCESS_DATA_S stData;

    /* Send read data request (only header). */
    au8BufferOut[CIMAX_REGISTER_CMD_POS] = CIMAX_REGISTER_READ_REQ;
    au8BufferOut[CIMAX_REGISTER_REG_ADDR_MSB_POS] = (HI_U8)(u32Address >> 8);
    au8BufferOut[CIMAX_REGISTER_REG_ADDR_LSB_POS] = (HI_U8)(u32Address);
    au8BufferOut[CIMAX_REGISTER_NUM_OF_REGS_POS] = (HI_U8)u32NumOfBytes;

    stData.txData = au8BufferOut;
    stData.txSize = sizeof(au8BufferOut);
    stData.rxData = au8BufferIn;
    stData.rxSize = CIMAX_REGISTER_HEADER_SIZE + u32NumOfBytes;


    /* Send command to CIMaX+. */
    s32Ret = CIMAXPLUS_Access(enCIPort, &stData);

    /* Check if response is valid. */
    if (0 != s32Ret)
    {
        HI_ERR_CI("Read cimax+ reg fail:%d.\n", s32Ret);
        return HI_ERR_CI_REG_READ_ERR;
    }
    else if ((au8BufferIn[CIMAX_REGISTER_CMD_POS] != CIMAX_REGISTER_READ_RESP_OK)
       || (au8BufferIn[CIMAX_REGISTER_REG_ADDR_MSB_POS] != (HI_U8)(u32Address >> 8))
       || (au8BufferIn[CIMAX_REGISTER_REG_ADDR_LSB_POS] != (HI_U8)(u32Address))
       || (au8BufferIn[CIMAX_REGISTER_NUM_OF_REGS_POS] != u32NumOfBytes)
       || (stData.rxSize != (u32NumOfBytes + CIMAX_REGISTER_HEADER_SIZE)))
    {
        CIMAXPLUS_PrintData("R-ERR->", stData.txData, stData.txSize);
        CIMAXPLUS_PrintData("R-ERR-<", stData.rxData, stData.rxSize);
        HI_ERR_CI("Read cimax+ reg err.\n");
        return HI_ERR_CI_REG_READ_ERR;
    }

    /* Copy read data to input buffer. */
    memcpy(pu8Buffer, &au8BufferIn[CIMAX_REGISTER_HEADER_SIZE], u32NumOfBytes);
    return HI_SUCCESS;
}

/* Write extended register for CIMaX+ */
HI_S32 CIMAXPLUS_WriteExReg(HI_UNF_CI_PORT_E enCIPort, HI_U32 u32Address, HI_U8* pu8Value, HI_U32 u32NumOfBytes)
{
    HI_S32 s32Ret = HI_SUCCESS;
    HI_U8 au8BufferOut[CIMAX_REGISTER_HEADER_SIZE + CIMAX_REGISTER_MAX_PAYLOAD_SIZE] = {0};
    HI_U8 au8BufferIn[CIMAX_REGISTER_HEADER_SIZE] = {0};
    CIMAXPLUS_ACCESS_DATA_S stData;

    /* Prepare command header. */
    au8BufferOut[CIMAX_REGISTER_CMD_POS] = CIMAX_REGISTER_WRITE_REQ;
    au8BufferOut[CIMAX_REGISTER_REG_ADDR_MSB_POS] = (HI_U8)(u32Address >> 8);
    au8BufferOut[CIMAX_REGISTER_REG_ADDR_LSB_POS] = (HI_U8)(u32Address);
    au8BufferOut[CIMAX_REGISTER_NUM_OF_REGS_POS] = u32NumOfBytes;

    /* Prepare command payload. */
    memcpy(&au8BufferOut[CIMAX_REGISTER_HEADER_SIZE], pu8Value, u32NumOfBytes);

    stData.txData = au8BufferOut;
    stData.txSize = CIMAX_REGISTER_HEADER_SIZE + u32NumOfBytes;
    stData.rxData = au8BufferIn;
    stData.rxSize = sizeof(au8BufferIn);

    /* Send command to CIMaX+. */
    s32Ret = CIMAXPLUS_Access(enCIPort, &stData);

    /* Check if response is valid. */
    if (0 != s32Ret)
    {
        HI_ERR_CI("Write cimax+ reg fail:%d.\n", s32Ret);
        return HI_ERR_CI_REG_WRITE_ERR;
    }
    else if ((au8BufferIn[CIMAX_REGISTER_CMD_POS] != CIMAX_REGISTER_WRITE_RESP_OK)
       || (au8BufferIn[CIMAX_REGISTER_REG_ADDR_MSB_POS] != (HI_U8)(u32Address >> 8))
       || (au8BufferIn[CIMAX_REGISTER_REG_ADDR_LSB_POS] != (HI_U8)(u32Address))
       || (au8BufferIn[CIMAX_REGISTER_NUM_OF_REGS_POS] != 0x00)
       || (stData.rxSize != CIMAX_REGISTER_HEADER_SIZE))
    {
        CIMAXPLUS_PrintData("W-ERR->", stData.txData, stData.txSize);
        CIMAXPLUS_PrintData("W-ERR-<", stData.rxData, stData.rxSize);
        HI_ERR_CI("Write cimax+ reg fail\n");
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    return HI_SUCCESS;
}

static HI_S32 CIMAXPLUS_CreateConfigTable(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_TSI_MODE_E enTSIMode,
                                   HI_UNF_CI_PCCD_E enCISwitchPCCD, HI_UNF_CI_TS_MODE_E enSlotAMode,
                                   HI_UNF_CI_TS_MODE_E enSlotBMode)
{
    HI_U8 u8MODASrc   = ROUTER_CAM_MODA_FROM_CH0IN;
    HI_U8 u8MODBSrc   = ROUTER_CAM_MODB_FROM_CH1IN;
    HI_U8 u8CH0OutSel = ROUTER_CAM_CH_0_OUT_SEL_MODA;
    HI_U8 u8CH1OutSel = ROUTER_CAM_CH_1_OUT_SEL_MODB;
    HI_U8 u8S2PCh0   = S2P_CTRL_DISABLE;
    HI_U8 u8P2SCh0   = P2S_CTRL_DISABLE;
    HI_U8 u8P2SCh1   = S2P_CTRL_DISABLE;
    HI_U8 u8S2PCh1   = P2S_CTRL_DISABLE;
    HI_U8 u8CH0InSel = IN_SEL_CH_0_IN_SEL_NULL;
    HI_U8 u8CH1InSel = IN_SEL_CH_1_IN_SEL_NULL;
    HI_U8 u8OutTSP      = OUT_SEL_TSP_DISABLE;
    HI_U8 u8OutTSSE     = OUT_SEL_TSSE_DISABLE;
    HI_U8 u8S0ClkEn     = CKMAN_CONFIG_S0CLK_DISABLE;
    HI_U8 u8S1ClkEn     = CKMAN_CONFIG_S1CLK_DISABLE;
    HI_U8 u8ProcClkEn   = CKMAN_CONFIG_PROCCLK_DISABLE;
    HI_U8 u8S0ClkFreq   = CKMAN_SELECT_S0CLK_27MHZ;
    HI_U8 u8S1ClkFreq   = CKMAN_SELECT_S1CLK_27MHZ;
    HI_U8 u8ProcClkFreq = CKMAN_SELECT_PROCCLK_54MHZ;
    HI_U8 u8GapRemover0 = GAP_REMOVER_DISABLE;
    HI_U8 u8GapRemover1 = GAP_REMOVER_DISABLE;
    HI_U8 u8USB2TS0     = USB2TS_CTRL_DISABLE;
    HI_U8 u8USB2TS1     = USB2TS_CTRL_DISABLE;
    HI_U8 u8USB2TS0RDL  = USB2TS0_RDL_DISABLE;
    HI_U8 u8USB2TS1RDL  = USB2TS1_RDL_DISABLE;

    HI_INFO_CI("CONFIG: TSI=%d, TS=(%d,%d)\n", enTSIMode, enSlotAMode, enSlotBMode);
    s_astCIMaXPlusParam[enCIPort].enTSIMode = enTSIMode;
    s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_A].enTSMode = enSlotAMode;
    s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_B].enTSMode = enSlotBMode;

    switch (enSlotAMode)
    {
    case HI_UNF_CI_TS_PARALLEL:
        u8CH0InSel = IN_SEL_CH_0_IN_SEL_TSINP;
        u8OutTSP = OUT_SEL_TSP_CH0OUT;
        break;

    case HI_UNF_CI_TS_SERIAL:
        u8CH0InSel = s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_A].enTsiSerialPort;
        u8S2PCh0      = S2P_CTRL_ENABLE;
        u8P2SCh0      = P2S_CTRL_ENABLE;
        u8OutTSP      = OUT_SEL_TSP_P2S0;
        u8S0ClkEn     = CKMAN_CONFIG_S0CLK_ENABLE;
        u8S0ClkFreq   = CKMAN_SELECT_S0CLK_108MHZ;
        u8GapRemover0 = GAP_REMOVER_ENABLE;
    default:
        break;

    case HI_UNF_CI_TS_USB2PARALLEL:
        u8CH0InSel = IN_SEL_CH_0_IN_SEL_USBEP3;
//      u8MODASrc  = ROUTER_CAM_MODA_FROM_CH0IN;/* ROUTER_CAM_MODA_FROM_PSREMAPPER */
        u8OutTSP = OUT_SEL_TSP_CH0OUT;
        u8ProcClkEn   = CKMAN_CONFIG_PROCCLK_ENABLE;
        u8ProcClkFreq = CKMAN_SELECT_PROCCLK_108MHZ;
        u8USB2TS0 = USB2TS_CTRL_0_ENABLE;
        u8USB2TS0RDL = USB2TS0_RDL_ENABLE;
        break;

    case HI_UNF_CI_TS_USB2SERIAL:
//      u8MODASrc  = ROUTER_CAM_MODA_FROM_CH0IN;/* ROUTER_CAM_MODA_FROM_PSREMAPPER */
        u8CH0InSel = IN_SEL_CH_0_IN_SEL_USBEP3;
        u8P2SCh0      = P2S_CTRL_ENABLE;
        u8OutTSP      = OUT_SEL_TSP_P2S0;
        u8S0ClkEn     = CKMAN_CONFIG_S0CLK_ENABLE;
        u8S0ClkFreq   = CKMAN_SELECT_S0CLK_108MHZ;
        u8ProcClkEn   = CKMAN_CONFIG_PROCCLK_ENABLE;
        u8ProcClkFreq = CKMAN_SELECT_PROCCLK_108MHZ;
        u8GapRemover0 = GAP_REMOVER_FOR_USB;
        u8USB2TS0     = USB2TS_CTRL_0_ENABLE;
        u8USB2TS0RDL  = USB2TS0_RDL_ENABLE;
        break;
    }

    switch (enSlotBMode)
    {
        /* Slot B only support serial or USB2Serial */
    case HI_UNF_CI_TS_PARALLEL:
    case HI_UNF_CI_TS_USB2PARALLEL:
        return HI_FAILURE;

    case HI_UNF_CI_TS_SERIAL:
        u8CH1InSel = (s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_B].enTsiSerialPort) << 4;
        u8S2PCh1      = S2P_CTRL_ENABLE;
        u8P2SCh1      = P2S_CTRL_ENABLE;
        u8OutTSSE     = OUT_SEL_TSSE_P2S1;
        u8S1ClkEn     = CKMAN_CONFIG_S1CLK_ENABLE;
        u8S1ClkFreq   = CKMAN_SELECT_S1CLK_108MHZ;
        u8GapRemover1 = GAP_REMOVER_ENABLE;
    default:
        break;

    case HI_UNF_CI_TS_USB2SERIAL:
        u8MODBSrc  = ROUTER_CAM_MODB_FROM_CH1IN;/*ROUTER_CAM_MODB_FROM_PSREMAPPER;*/
        u8CH1InSel = IN_SEL_CH_1_IN_SEL_USBEP4;
        u8P2SCh1      = P2S_CTRL_ENABLE;
        u8OutTSSE     = OUT_SEL_TSSE_P2S1;
        u8S1ClkEn     = CKMAN_CONFIG_S1CLK_ENABLE;
        u8S1ClkFreq   = CKMAN_SELECT_S1CLK_108MHZ;
        u8ProcClkEn   = CKMAN_CONFIG_PROCCLK_ENABLE;
        u8ProcClkFreq = CKMAN_SELECT_PROCCLK_108MHZ;
        u8GapRemover1 = GAP_REMOVER_FOR_USB;
        u8USB2TS1     = USB2TS_CTRL_1_ENABLE;
        u8USB2TS1RDL  = USB2TS1_RDL_ENABLE;
        break;
    }

    switch (enTSIMode)
    {
        /* Daisy-chained: Ch 0 In -> Mod A -> Mod B -> Ch 0 Out -> TSP */
    case HI_UNF_CI_TSI_DAISY_CHAINED:
        u8MODASrc   = ROUTER_CAM_MODA_FROM_CH0IN;
        u8MODBSrc   = ROUTER_CAM_MODB_FROM_MODA;
        u8CH0OutSel = ROUTER_CAM_CH_0_OUT_SEL_MODB;
        u8CH1OutSel = ROUTER_CAM_CH_1_OUT_SEL_MODB;

        /* Ch 1 In select null */
        u8CH1InSel = IN_SEL_CH_1_IN_SEL_NULL;

        /* OUT_SEL TS SErial2 disable */
        u8OutTSSE = OUT_SEL_TSSE_DISABLE;

        /* S2P1/P2S1 disable */
        u8S2PCh1 = S2P_CTRL_DISABLE;
        u8P2SCh1 = P2S_CTRL_DISABLE;

        /* S1CLK disable */
        u8S1ClkEn   = CKMAN_CONFIG_S1CLK_DISABLE;
        u8S1ClkFreq = CKMAN_SELECT_S1CLK_27MHZ;

        /* GAP_REMOVER_CH1_CTRL disable */
        u8GapRemover1 = GAP_REMOVER_DISABLE;
        break;

        /* Non-daisy-chained: Ch 0 In -> Mod A -> Ch 0 Out, Ch 1 In -> Mod B -> Ch 1 Out */
    case HI_UNF_CI_TSI_INDEPENDENT:
        u8MODASrc   = ROUTER_CAM_MODA_FROM_CH0IN;
        u8MODBSrc   = ROUTER_CAM_MODB_FROM_CH1IN;
        u8CH0OutSel = ROUTER_CAM_CH_0_OUT_SEL_MODA;
        u8CH1OutSel = ROUTER_CAM_CH_1_OUT_SEL_MODB;
    default:
        break;
    }

    s_astDevConfig[ROUTER_CAM_MOD_POS].u8Val = u8MODBSrc | u8MODASrc;
    s_astDevConfig[ROUTER_CAM_CH_POS].u8Val = u8CH1OutSel | u8CH0OutSel;
    s_astDevConfig[CKMAN_SELECT_POS].u8Val  = u8S0ClkFreq | u8S1ClkFreq | u8ProcClkFreq;
    s_astDevConfig[CKMAN_CONFIG_POS].u8Val  = u8S0ClkEn | u8S1ClkEn | u8ProcClkEn | CKMAN_CONFIG_DEFALUT;
    s_astDevConfig[GAP_REMOVER_0_POS].u8Val = u8GapRemover0;
    s_astDevConfig[GAP_REMOVER_1_POS].u8Val = u8GapRemover1;
    s_astDevConfig[S2P_CH0_CTRL_POS].u8Val = u8S2PCh0;
    s_astDevConfig[P2S_CH0_CTRL_POS].u8Val = u8P2SCh0;
    s_astDevConfig[S2P_CH1_CTRL_POS].u8Val = u8S2PCh1;
    s_astDevConfig[P2S_CH1_CTRL_POS].u8Val = u8P2SCh1;
    s_astDevConfig[USB2TS_CTRL_POS].u8Val = u8USB2TS0 | u8USB2TS1;
    s_astDevConfig[USB2TS0_RDL_POS].u8Val = u8USB2TS0RDL;
    s_astDevConfig[USB2TS1_RDL_POS].u8Val = u8USB2TS1RDL;
    s_astDevConfig[OUT_SEL_POS].u8Val = u8OutTSSE | u8OutTSP;
    s_astDevConfig[IN_SEL_POS].u8Val = u8CH1InSel | u8CH0InSel;

    HI_INFO_CI("Will config ROUTER_CAM_MOD:0x%04x to %02x.\n", ROUTER_CAM_MOD, s_astDevConfig[ROUTER_CAM_MOD_POS].u8Val);
    HI_INFO_CI("Will config ROUTER_CAM_CH:0x%04x to %02x.\n", ROUTER_CAM_CH, s_astDevConfig[ROUTER_CAM_CH_POS].u8Val);
    HI_INFO_CI("Will config CKMAN_SELECT:0x%04x to %02x.\n", CKMAN_SELECT, s_astDevConfig[CKMAN_SELECT_POS].u8Val);
    HI_INFO_CI("Will config CKMAN_CONFIG:0x%04x to %02x.\n", CKMAN_CONFIG, s_astDevConfig[CKMAN_CONFIG_POS].u8Val);
    HI_INFO_CI("Will config GAP_REMOVER_CH0_CTRL:0x%04x to %02x.\n", GAP_REMOVER_CH0_CTRL,
              s_astDevConfig[GAP_REMOVER_0_POS].u8Val);
    HI_INFO_CI("Will config GAP_REMOVER_CH1_CTRL:0x%04x to %02x.\n", GAP_REMOVER_CH1_CTRL,
              s_astDevConfig[GAP_REMOVER_1_POS].u8Val);
    HI_INFO_CI("Will config S2P_CH0_CTRL:0x%04x to %02x.\n", S2P_CH0_CTRL, s_astDevConfig[S2P_CH0_CTRL_POS].u8Val);
    HI_INFO_CI("Will config P2S_CH0_CTRL:0x%04x to %02x.\n", P2S_CH0_CTRL, s_astDevConfig[P2S_CH0_CTRL_POS].u8Val);
    HI_INFO_CI("Will config S2P_CH1_CTRL:0x%04x to %02x.\n", S2P_CH1_CTRL, s_astDevConfig[S2P_CH1_CTRL_POS].u8Val);
    HI_INFO_CI("Will config P2S_CH1_CTRL:0x%04x to %02x.\n", P2S_CH1_CTRL, s_astDevConfig[P2S_CH1_CTRL_POS].u8Val);
    HI_INFO_CI("Will config USB2TS_CTRL:0x%04x to %02x.\n", USB2TS_CTRL, s_astDevConfig[USB2TS_CTRL_POS].u8Val);
    HI_INFO_CI("Will config USB2TS0_RDL:0x%04x to %02x.\n", USB2TS0_RDL, s_astDevConfig[USB2TS0_RDL_POS].u8Val);
    HI_INFO_CI("Will config USB2TS1_RDL:0x%04x to %02x.\n", USB2TS1_RDL, s_astDevConfig[USB2TS1_RDL_POS].u8Val);
    HI_INFO_CI("Will config OUT_SEL:0x%04x to %02x.\n", OUT_SEL, s_astDevConfig[OUT_SEL_POS].u8Val);
    HI_INFO_CI("Will config IN_SEL:0x%04x to %02x.\n", IN_SEL, s_astDevConfig[IN_SEL_POS].u8Val);

    return HI_SUCCESS;
}

/* s_astDevConfig */
static HI_S32 CIMAXPLUS_Config(HI_UNF_CI_PORT_E enCIPort)
{
    REG_SETTING_S *pstSetting = HI_NULL;
    HI_U32 u32Size;
    HI_U32 u32Cnt;
    HI_U8 buf[CIMAX_REGISTER_MAX_PAYLOAD_SIZE];

    pstSetting = s_astDevConfig;
    u32Size = sizeof(s_astDevConfig);

    HI_INFO_CI("Download CIMaX+ configuration(register settings): u32Size=%d\n", u32Size);

    for (u32Cnt = 0; u32Cnt < u32Size / sizeof(REG_SETTING_S); u32Cnt++)
    {
        switch (pstSetting[u32Cnt].u8Op)
        {
            /* Read register. */
        case REG_OP_READ:
            if (CIMAXPLUS_ReadExReg(enCIPort, pstSetting[u32Cnt].u16Reg, buf, 1) != HI_SUCCESS)
            {
                /* CIMaX+ read error. */
                HI_ERR_CI("FAILED at REG_OP_READ operation.\n");
                return CIMAX_ERROR;
            }

            HI_INFO_CI("Read operation: register 0x%04x = 0x%02x.\n", pstSetting[u32Cnt].u16Reg, buf[0]);
            break;

        /* Write register. */
        case REG_OP_WRITE:
            if (CIMAXPLUS_WriteExReg(enCIPort, pstSetting[u32Cnt].u16Reg, (HI_U8 *)&pstSetting[u32Cnt].u8Val, 1) < 0)
            {
                /* CIMaX+ write error. */
                HI_ERR_CI("FAILED at REG_OP_WRITE operation.\n");
                return CIMAX_ERROR;
            }

            HI_INFO_CI("Write operation: register 0x%04x = 0x%02x.\n", pstSetting[u32Cnt].u16Reg,
                       pstSetting[u32Cnt].u8Val);
            break;
            
        case REG_OP_WAIT_TO_BE_SET:
            do
            {
                if (CIMAXPLUS_ReadExReg(enCIPort, pstSetting[u32Cnt].u16Reg, buf, 1) < 0)
                {
                    /* CIMaX+ read error. */
                    HI_ERR_CI("FAILED at REG_OP_WAIT_TO_BE_SET operation.\n");
                    return CIMAX_ERROR;
                }
            } while ((buf[0] & pstSetting[u32Cnt].u8Val) != pstSetting[u32Cnt].u8Val);

            HI_INFO_CI("Wait register to be set operation: register 0x%04x = 0x%02x.\n", pstSetting[u32Cnt].u16Reg,
                       buf[0]);
            break;
            
        case REG_OP_WAIT_TO_BE_CLEARED:
            do
            {
                if (CIMAXPLUS_ReadExReg(enCIPort, pstSetting[u32Cnt].u16Reg, buf, 1) < 0)
                {
                    /* CIMaX+ read error. */
                    HI_ERR_CI("FAILED at REG_OP_WAIT_TO_BE_CLEARED operation.\n");
                    return CIMAX_ERROR;
                }
            } while ((buf[0] & pstSetting[u32Cnt].u8Val) != 0);

            HI_INFO_CI("Wait register to be cleared operation: register 0x%04x = 0x%02x.\n", pstSetting[u32Cnt].u16Reg,
                       buf[0]);
            break;
            
        case REG_OP_WAIT_EQUAL:
            do
            {
                if (CIMAXPLUS_ReadExReg(enCIPort, pstSetting[u32Cnt].u16Reg, buf, 1) < 0)
                {
                    /* CIMaX+ read error. */
                    HI_ERR_CI("FAILED at REG_OP_WAIT_EQUAL operation.\n");
                    return CIMAX_ERROR;
                }
            } while (buf[0] != pstSetting[u32Cnt].u8Val);

            HI_INFO_CI("Wait register to be equal operation: register 0x%04x = 0x%02x.\n", pstSetting[u32Cnt].u16Reg,
                       buf[0]);
            break;
            
        case REG_OP_LOGICAL_AND:
            if (CIMAXPLUS_ReadExReg(enCIPort, pstSetting[u32Cnt].u16Reg, buf, 1) < 0)
            {
                /* CIMaX+ read error. */
                HI_ERR_CI("FAILED at REG_OP_LOGICAL_AND operation (reading).\n");
                return CIMAX_ERROR;
            }

            buf[0] &= pstSetting[u32Cnt].u8Val;
            if (CIMAXPLUS_WriteExReg(enCIPort, pstSetting[u32Cnt].u16Reg, buf, 1) < 0)
            {
                /* CIMaX+ write error. */
                HI_ERR_CI("FAILED at REG_OP_LOGICAL_AND operation (writing).\n");
                return CIMAX_ERROR;
            }

            HI_INFO_CI("Logical AND operation: register 0x%04x = 0x%02x.\n", pstSetting[u32Cnt].u16Reg, buf[0]);
            break;
            
        case REG_OP_LOGICAL_OR:
            if (CIMAXPLUS_ReadExReg(enCIPort, pstSetting[u32Cnt].u16Reg, buf, 1) < 0)
            {
                /* CIMaX+ read error. */
                HI_ERR_CI("FAILED at REG_OP_LOGICAL_OR operation (reading).\n");
                return CIMAX_ERROR;
            }

            buf[0] |= pstSetting[u32Cnt].u8Val;
            if (CIMAXPLUS_WriteExReg(enCIPort, pstSetting[u32Cnt].u16Reg, buf, 1) < 0)
            {
                /* CIMaX+ write error. */
                return CIMAX_ERROR;
            }

            HI_INFO_CI("Logical OR operation: register 0x%04x = 0x%02x.\n", pstSetting[u32Cnt].u16Reg, buf[0]);
            break;

        case REG_OP_WAIT:
            HI_INFO_CI("Wait for %d ms.\n", pstSetting[u32Cnt].u8Val);
            msleep(pstSetting[u32Cnt].u8Val);
            break;

        default:
            HI_ERR_CI("\nInvalid operation 0x%02x!\n", pstSetting[u32Cnt].u8Op);
            return CIMAX_ERROR;
            break;
        }
    }

    return CIMAX_NO_ERROR;
}

static HI_BOOL CIMAXPLUS_NoCam(HI_UNF_CI_PCCD_E enCardId, HI_U8 *pu8Buffer)
{
    HI_U8 u8CamStatus = CIMAX_CAM_A_NO_CAM;

    /* Check if response is valid. */
    if (HI_UNF_CI_PCCD_A != enCardId)
    {
        u8CamStatus = CIMAX_CAM_B_NO_CAM;
    }

    if ((pu8Buffer[CIMAX_CAM_COMMAND_OR_STATUS_POS] == u8CamStatus)
       && (pu8Buffer[CIMAX_CAM_PACKET_COUNTER_POS] == CIMAX_CAM_PACKET_COUNTER_VALUE)
       && (pu8Buffer[CIMAX_CAM_DATA_LEN_MSB_POS] == 0x00)
       && (pu8Buffer[CIMAX_CAM_DATA_LEN_LSB_POS] == 0x00))
    {
        return HI_TRUE;
    }

    return HI_FALSE;
}

static HI_BOOL CIMAXPLUS_CamError(HI_UNF_CI_PCCD_E enCardId, HI_U8 *pu8Buffer)
{
    HI_U8 u8CamStatus = CIMAX_CAM_A_CAM_ERROR;
    HI_U16 u16ReceivedErrorNumber;

    /* Check if response is valid. */
    if (HI_UNF_CI_PCCD_A != enCardId)
    {
        u8CamStatus = CIMAX_CAM_B_CAM_ERROR;
    }

    if ((pu8Buffer[CIMAX_CAM_COMMAND_OR_STATUS_POS] == u8CamStatus)
       && (pu8Buffer[CIMAX_CAM_PACKET_COUNTER_POS] == CIMAX_CAM_PACKET_COUNTER_VALUE)
       && (pu8Buffer[CIMAX_CAM_DATA_LEN_MSB_POS] == 0x00)
       && (pu8Buffer[CIMAX_CAM_DATA_LEN_LSB_POS] == 0x02))
    {
        u16ReceivedErrorNumber  = pu8Buffer[CIMAX_CAM_FIRST_DATA_BYTE_POS] & 0x0F;
        u16ReceivedErrorNumber  = u16ReceivedErrorNumber << 8;
        u16ReceivedErrorNumber |= pu8Buffer[CIMAX_CAM_SECOND_DATA_BYTE_POS];

        switch (u16ReceivedErrorNumber)
        {
        case CAMERROR_RESET:
            HI_ERR_CI("CAM not ready!\n");
            break;
        case CAMERROR_CIS_BUFFER:
            HI_ERR_CI("CIS buffer not allocated!\n");
            break;
        case CAMERROR_CIS_BAD_SIZE:
            HI_ERR_CI("Bad CIS size (> 512 bytes)!\n");
            break;
        case CAMERROR_CIS_CAM_NOT_ACTIVATED:
            HI_ERR_CI("CAM not activated!\n");
            break;
        case CAMERROR_COR_CAM_NOT_READY:
            HI_ERR_CI("CAM not ready after software reset during write COR process!\n");
            break;
        case CAMERROR_COR_VALUE_CHECKING:
            HI_ERR_CI("Checking of COR value failed!\n");
            break;
        case CAMERROR_NEGOTIATE_NOT_RESPONDING:
            HI_ERR_CI("CAM not responding after SR bit is raised during buffer negociation phase!\n");
            break;
        case CAMERROR_NEGOTIATE_SIZE_LENGTH:
            HI_ERR_CI("CAM buffer size length <> 2!\n");
            break;
        case CAMERROR_NEGOTIATE_NOT_READY:
            HI_ERR_CI("CAM not ready to accept new buffer size negotiate during buffer negociation phase!\n");
            break;
        case CAMERROR_LPDU_NOT_AVAILABLE:
            HI_ERR_CI("LPDU not available!\n");
            break;
        default:
            HI_ERR_CI("unknown error 0x%04x!\n", u16ReceivedErrorNumber);
            break;
        }

        return HI_TRUE;
    }

    return HI_FALSE;
}

static HI_BOOL CIMAXPLUS_CamWriteBusy(HI_UNF_CI_PCCD_E enCardId, HI_U8 *pu8Buffer)
{
    HI_U8 u8CamStatus = CIMAX_CAM_A_WRITE_BUSY;

    /* Check if response is valid. */
    if (HI_UNF_CI_PCCD_A != enCardId)
    {
        u8CamStatus = CIMAX_CAM_B_WRITE_BUSY;
    }

    if ((pu8Buffer[CIMAX_CAM_COMMAND_OR_STATUS_POS] == u8CamStatus)
       && (pu8Buffer[CIMAX_CAM_PACKET_COUNTER_POS] == CIMAX_CAM_PACKET_COUNTER_VALUE)
       && (pu8Buffer[CIMAX_CAM_DATA_LEN_MSB_POS] == 0x00)
       && (pu8Buffer[CIMAX_CAM_DATA_LEN_LSB_POS] == 0x00))
    {
        return HI_TRUE;
    }

    return HI_FALSE;
}

static HI_BOOL CIMAXPLUS_CamCmdPending(HI_UNF_CI_PCCD_E enCardId, HI_U8 *pu8Buffer)
{
    HI_U8 u8CamStatus = CIMAX_CAM_A_CMD_PENDING;

    /* Check if response is valid. */
    if (HI_UNF_CI_PCCD_A != enCardId)
    {
        u8CamStatus = CIMAX_CAM_B_CMD_PENDING;
    }

    if ((pu8Buffer[CIMAX_CAM_COMMAND_OR_STATUS_POS] == u8CamStatus)
       && (pu8Buffer[CIMAX_CAM_PACKET_COUNTER_POS] == CIMAX_CAM_PACKET_COUNTER_VALUE)
       && (pu8Buffer[CIMAX_CAM_DATA_LEN_MSB_POS] == 0x00)
       && (pu8Buffer[CIMAX_CAM_DATA_LEN_LSB_POS] == 0x01))
    {
        return HI_TRUE;
    }

    return HI_FALSE;
}

HI_S32 CIMAXPLUS_AccessCAM(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_U8 u8Cmd,
                                  const HI_U8 *pu8BufferOut, HI_U16 u16NumOfBytes, HI_U8 *pu8BufferIn,
                                  HI_U32 u32NumOfBytesIn)
{    
    HI_S32 s32Ret = HI_SUCCESS;
    HI_U8 au8Buf[CIMAX_CAM_HEADER_SIZE + CIMAX_CAM_MAX_PAYLOAD_SIZE_TEMP] = {0};
    HI_U8 *pu8Buf = HI_NULL;
    HI_U8 *pu8BigBuf = HI_NULL;
    CIMAXPLUS_ACCESS_DATA_S stData;

    /* If send data size > CIMAX_CAM_MAX_PAYLOAD_SIZE_TEMP, alloc memory */
    if (u16NumOfBytes <= CIMAX_CAM_MAX_PAYLOAD_SIZE_TEMP)
    {
        pu8Buf = au8Buf;
    }
    else
    {
        pu8BigBuf = HI_KMALLOC_CI(CIMAX_CAM_HEADER_SIZE + CIMAX_CAM_MAX_PAYLOAD_SIZE, GFP_KERNEL);
        if (HI_NULL == pu8BigBuf)
        {
            HI_ERR_CI("AccessCAM: No memory!\n");
            return HI_FAILURE;
        }
        pu8Buf = pu8BigBuf;
    }

    /* Prepare command header. */
    if (HI_UNF_CI_PCCD_A == enCardId)
    {
        pu8Buf[CIMAX_CAM_COMMAND_OR_STATUS_POS] = u8Cmd;
    }
    else
    {
        pu8Buf[CIMAX_CAM_COMMAND_OR_STATUS_POS] = u8Cmd | CIMAX_CAM_SLOT_MASK;
    }

    pu8Buf[CIMAX_CAM_PACKET_COUNTER_POS] = CIMAX_CAM_PACKET_COUNTER_VALUE;
    pu8Buf[CIMAX_CAM_DATA_LEN_MSB_POS] = (u16NumOfBytes >> 8) & 0xFF;
    pu8Buf[CIMAX_CAM_DATA_LEN_LSB_POS] = u16NumOfBytes & 0xFF;

    /* Prepare command payload. */
    if (u16NumOfBytes > 0)
    {
        memcpy(pu8Buf+CIMAX_REGISTER_HEADER_SIZE, pu8BufferOut, u16NumOfBytes);
    }

    stData.txData = pu8Buf;
    stData.txSize = CIMAX_CAM_HEADER_SIZE + u16NumOfBytes;
    stData.rxData = pu8BufferIn;
    stData.rxSize = u32NumOfBytesIn;

    /* Send command to CIMaX+. */
    s32Ret = CIMAXPLUS_Access(enCIPort, &stData);
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_CI("AccessCAM: ioctl fail:%d!\n", s32Ret);
        if (pu8BigBuf)
        {
            HI_KFREE_CI(pu8BigBuf);
            pu8BigBuf = HI_NULL;
        }
        return HI_FAILURE;
    }

    if ((enCardId << CIMAX_CAM_SLOT_BIT_POSITION)
        != (pu8BufferIn[CIMAX_CAM_COMMAND_OR_STATUS_POS] & CIMAX_CAM_SLOT_MASK))
    {
        HI_ERR_CI("AccessCAM: ***** slot MISMATCH (%d instead of %d)! *****\n",
                  (pu8BufferIn[CIMAX_CAM_COMMAND_OR_STATUS_POS] >> CIMAX_CAM_SLOT_BIT_POSITION), enCardId);
        if (pu8BigBuf)
        {
            HI_KFREE_CI(pu8BigBuf);
            pu8BigBuf = HI_NULL;
        }
        return HI_FAILURE;
    }

    /* Check response from CIMaX+. */
    if (CIMAXPLUS_NoCam(enCardId, pu8BufferIn) == HI_TRUE)
    {
        HI_WARN_CI("AccessCAM: CAMNoCAM %d received!\n", enCardId);
        if (pu8BigBuf)
        {
            HI_KFREE_CI(pu8BigBuf);
            pu8BigBuf = HI_NULL;
        }
        return CIMAX_NO_CAM_ERROR;
    }

    if (CIMAXPLUS_CamError(enCardId, pu8BufferIn) == HI_TRUE)
    {
        HI_WARN_CI("AccessCAM: CAMError %d received!\n", enCardId);
        if (pu8BigBuf)
        {
            HI_KFREE_CI(pu8BigBuf);
            pu8BigBuf = HI_NULL;
        }
        return CIMAX_CAM_ERROR;
    }

    if (CIMAXPLUS_CamWriteBusy(enCardId, pu8BufferIn) == HI_TRUE)
    {
        /*HI_ERR_CI("AccessCAM: CAMWriteBusy %d received!\n", enCardId);*/
        if (pu8BigBuf)
        {
            HI_KFREE_CI(pu8BigBuf);
            pu8BigBuf = HI_NULL;
        }
        return CIMAX_CAM_WRITE_BUSY_ERROR;
    }

    if (CIMAXPLUS_CamCmdPending(enCardId, pu8BufferIn) == HI_TRUE)
    {
        HI_WARN_CI("AccessCAM: CAMCmdPending %d received!\n", enCardId);
        if (pu8BigBuf)
        {
            HI_KFREE_CI(pu8BigBuf);
            pu8BigBuf = HI_NULL;
        }
        return CIMAX_CAM_CMD_PENDING;
    }

    if (pu8BigBuf)
    {
        HI_KFREE_CI(pu8BigBuf);
        pu8BigBuf = HI_NULL;
    }
    return HI_SUCCESS;
}

static HI_S32 CIMAXPLUS_Init(HI_UNF_CI_PORT_E enCIPort)
{
    HI_S32 s32Ret = HI_FAILURE;
#ifdef HI_CIMAXPLUS_MODE_USB
    HI_S32 alt_setting = 2;
    HI_S32 s32DeviceReady = 0;
    HI_S32 u32RetryTimes = 0;
#endif

    /* Down valid */
    if ((s_pGpioFunc) && (s_pGpioFunc->pfnGpioDirSetBit) && (s_pGpioFunc->pfnGpioWriteBit))
    {
        s32Ret  = s_pGpioFunc->pfnGpioDirSetBit(s_astCIMaXPlusParam[enCIPort].u32ResetGpioNo, 0); //output
        s32Ret |= s_pGpioFunc->pfnGpioWriteBit(s_astCIMaXPlusParam[enCIPort].u32ResetGpioNo, 1);
        msleep(RESET_WAIT_TIME);
        s32Ret |= s_pGpioFunc->pfnGpioWriteBit(s_astCIMaXPlusParam[enCIPort].u32ResetGpioNo, 0);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_CI("Reset cimax+ device fail.\n");
            return HI_FAILURE;
        }
    }
    else
    {
        return HI_FAILURE;
    }

    /* Waiting upload fw and cfg */
    msleep(PROBE_WAIT_TIME * 20);

    if (s_astCIMaXPlusParam[enCIPort].enCmdExchangeChan == HI_UNF_CI_CMD_EXCHANGE_CHAN_USB)
    {
 #ifdef HI_CIMAXPLUS_MODE_USB
		/* Open file */
        s_astCIMaXPlusParam[enCIPort].pFILE = filp_open(CIMAXPLUS_DEV_FILE, O_RDWR, 0);
        while (IS_ERR(s_astCIMaXPlusParam[enCIPort].pFILE))
        {
            msleep(DEV_DELAY_TIME);
            s_astCIMaXPlusParam[enCIPort].pFILE = filp_open(CIMAXPLUS_DEV_FILE, O_RDWR, 0);
            if (u32RetryTimes++ >= DEV_RETRY_TIMES)
            {
                break;
            }
        }

        /* Check pFILE valid */
        if (IS_ERR(s_astCIMaXPlusParam[enCIPort].pFILE))
        {
            HI_ERR_CI("Open cimax+ USB device fail.\n");
            return HI_FAILURE;
        }

        /* Check f_op and ioctl valid */
        if (!(s_astCIMaXPlusParam[enCIPort].pFILE->f_op) || !(s_astCIMaXPlusParam[enCIPort].pFILE->f_op->IOCTL))
        {
            filp_close(s_astCIMaXPlusParam[enCIPort].pFILE, NULL);
            s_astCIMaXPlusParam[enCIPort].pFILE = HI_NULL;
            HI_ERR_CI("File has no IOCTL operations registered.\n");
            return HI_FAILURE;
        }

        /* Check other param used by ioctl valid */
        if (!(s_astCIMaXPlusParam[enCIPort].pFILE->f_mapping) || !(s_astCIMaXPlusParam[enCIPort].pFILE->f_mapping->host))
        {
            filp_close(s_astCIMaXPlusParam[enCIPort].pFILE, NULL);
            s_astCIMaXPlusParam[enCIPort].pFILE = HI_NULL;
            HI_ERR_CI("File has no f_mapping.\n");
            return HI_FAILURE;
        }

        /* Wait device ready */
        u32RetryTimes = 0;
        s32Ret = CI_DRV_IOCTL(s_astCIMaXPlusParam[enCIPort].pFILE, DEVICE_IOC_DEV_READY, (HI_S32)&s32DeviceReady);
        while (!s32DeviceReady)
        {
            msleep(DEV_DELAY_TIME);
            s32Ret = CI_DRV_IOCTL(s_astCIMaXPlusParam[enCIPort].pFILE, DEVICE_IOC_DEV_READY, (HI_S32)&s32DeviceReady);
            if (u32RetryTimes++ >= DEV_RETRY_TIMES)
            {
                break;
            }
        }

        /* Check device ready */
        if (!s32DeviceReady)
        {
            HI_ERR_CI("Wait device ready fail.\n");
            return HI_FAILURE;
        }
        
        /* Set alt_setting */
        s32Ret = CI_DRV_IOCTL(s_astCIMaXPlusParam[enCIPort].pFILE, DEVICE_IOC_SELECT_INTF, alt_setting);
#endif
    }
	else
	{
#ifdef HI_CIMAXPLUS_MODE_SPI
		s32Ret  = CIMAXPLUS_SPI_Init(enCIPort);
		if (HI_SUCCESS != s32Ret)
		{
			HI_ERR_CI("CIMAXPLUS_SPI_Init fail.\n");
			return HI_FAILURE;
		}
		s32Ret  = CIMAXPLUS_SPI_FwUpload(enCIPort);
		if (HI_SUCCESS != s32Ret)
		{
			HI_ERR_CI("CIMAXPLUS_SPI_FwUpload fail.\n");
			return HI_FAILURE;
		}
#endif
	}  
    return s32Ret;
}

static HI_VOID CIMAXPLUS_DeInit(HI_UNF_CI_PORT_E enCIPort)
{
    HI_S32 s32Ret = 0;
    HI_U32 u32GPIOGroup;
    HI_S32 u32GPIOBit;

#ifdef HI_CIMAXPLUS_MODE_USB
    struct file *pFILE;

    pFILE = s_astCIMaXPlusParam[enCIPort].pFILE;
    if (HI_NULL != pFILE)
    {
        CI_DRV_IOCTL(pFILE, DEVICE_IOC_UNLOCK_READ, 0);
        filp_close(pFILE, NULL);
        s_astCIMaXPlusParam[enCIPort].pFILE = HI_NULL;
    }
#endif
#ifdef HI_CIMAXPLUS_MODE_SPI
#ifdef USE_GPIO_SPI_FUNC
    s32Ret = GPIO_SPI_Destory(s_astCIMaXPlusParam[enCIPort].u32SpiDevNum);
    if (HI_SUCCESS != s32Ret)
    {
    	HI_ERR_CI("GPIO_SPI_Destory fail.\n");
    }
#else
    s32Ret = HI_DRV_SPI_Close(s_astCIMaXPlusParam[enCIPort].u32SpiDevNum);
    if (HI_SUCCESS != s32Ret)
    {
    	HI_ERR_CI("HI_DRV_SPI_Close fail.\n");
    }    
#endif
#endif
    /* Up */
    u32GPIOGroup = s_astCIMaXPlusParam[enCIPort].u32ResetGpioNo / 8;
    u32GPIOBit = s_astCIMaXPlusParam[enCIPort].u32ResetGpioNo % 8;
    if ((s_pGpioFunc) && (s_pGpioFunc->pfnGpioDirSetBit) && (s_pGpioFunc->pfnGpioWriteBit))
    {
        s32Ret = s_pGpioFunc->pfnGpioDirSetBit(u32GPIOGroup * HI_GPIO_BIT_NUM + u32GPIOBit, 0);
        s32Ret |= s_pGpioFunc->pfnGpioWriteBit(u32GPIOGroup * HI_GPIO_BIT_NUM + u32GPIOBit, 1);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_CI("Unload cimax+ device fail.\n");
        }
    }
}

/* Open CI Port */
HI_S32 CIMAXPLUS_Open(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_ATTR_S stAttr)
{
    HI_S32 s32Ret = HI_SUCCESS;

    memset(&s_astCIMaXPlusParam[enCIPort], 0, sizeof(CIMAXPLUS_PARAMETER_S));

    /* Init parameters */
    s_astCIMaXPlusParam[enCIPort].u32ResetGpioNo = stAttr.unDevAttr.stCIMaXPlus.u32ResetGpioNo;
    s_astCIMaXPlusParam[enCIPort].enTSIMode = stAttr.enTSIMode;
    s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_A].enTSMode =
        stAttr.enTSMode[HI_UNF_CI_PCCD_A];
    s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_B].enTSMode =
        stAttr.enTSMode[HI_UNF_CI_PCCD_B];
    s_astCIMaXPlusParam[enCIPort].u32IntGpioNo = stAttr.unDevAttr.stCIMaXPlus.u32IntGpioNo;
    s_astCIMaXPlusParam[enCIPort].enCmdExchangeChan = stAttr.unDevAttr.stCIMaXPlus.enCmdExchangeChan;
    s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_A].enTsiSerialPort = 
        stAttr.unDevAttr.stCIMaXPlus.enTsiSerialPort[HI_UNF_CI_PCCD_A];
    s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_B].enTsiSerialPort = 
        stAttr.unDevAttr.stCIMaXPlus.enTsiSerialPort[HI_UNF_CI_PCCD_B];
    s_astCIMaXPlusParam[enCIPort].u32SpiDevNum = stAttr.unDevAttr.stCIMaXPlus.u32SPIDevNo;
    s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_A].enRunStep = HI_CI_PCCD_RUN_STEP_RUNNING;
    s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_B].enRunStep = HI_CI_PCCD_RUN_STEP_RUNNING;
    
    s_pGpioFunc = HI_NULL;
    HI_DRV_MODULE_GetFunction(HI_ID_GPIO, (HI_VOID**)&s_pGpioFunc);

    /* Only support HI_UNF_CI_PORT_0 now */
    s32Ret = CIMAXPLUS_Init(enCIPort);
    if (HI_SUCCESS != s32Ret)
    {
        CIMAXPLUS_DeInit(enCIPort);
        HI_ERR_CI("CIMaX+ init fail.\n");
        return s32Ret;
    }
    
    s32Ret = CIMAXPLUS_CreateConfigTable(enCIPort,
                                         s_astCIMaXPlusParam[enCIPort].enTSIMode,
                                         HI_UNF_CI_PCCD_BUTT,
                                         s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_A].enTSMode,
                                         s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_B].enTSMode);
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_CI("CIMaX+ create config fail.\n");
        return s32Ret;
    }

    s32Ret = CIMAXPLUS_Config(enCIPort);
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_CI("CIMaX+ config fail.\n");
        return s32Ret;
    }    

    switch (s_astCIMaXPlusParam[enCIPort].enTSIMode)
    {
    case HI_UNF_CI_TSI_DAISY_CHAINED:

        /* Daisy-chained, only use CH 0 OUT */
        s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_A].u8CHOutSelection =
            ROUTER_CAM_CH_0_OUT_SEL_MODB;
        s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_B].u8CHOutSelection =
            ROUTER_CAM_CH_0_OUT_SEL_MODA;//ROUTER_CAM_CH_0_OUT_SEL_MODB ??? 
        s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_A].u8MODSelection =
            ROUTER_CAM_MODA_FROM_CH0IN;
        s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_B].u8MODSelection =
            ROUTER_CAM_MODB_FROM_MODA;
        break;
    case HI_UNF_CI_TSI_INDEPENDENT:
    default:
        s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_A].u8CHOutSelection =
            CIMAXPLUS_CH_0_OUT_SEL_CH0IN; //??? ROUTER_CAM_CH_0_OUT_SEL_MODA
        s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_B].u8CHOutSelection =
            CIMAXPLUS_CH_1_OUT_SEL_CH1IN;//??? ROUTER_CAM_CH_0_OUT_SEL_MODB
        s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_A].u8MODSelection =
            ROUTER_CAM_MODA_FROM_CH0IN;
        s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_B].u8MODSelection =
            ROUTER_CAM_MODB_FROM_CH1IN;
        break;
    }
        
    return HI_SUCCESS;
}

/* Close CI Port */
HI_VOID CIMAXPLUS_Close(HI_UNF_CI_PORT_E enCIPort)
{
    CIMAXPLUS_DeInit(enCIPort);
    memset(s_astCIMaXPlusParam, 0, sizeof(s_astCIMaXPlusParam));
    s_pGpioFunc = HI_NULL;
}

/* Open Card */
HI_S32 CIMAXPLUS_PCCD_Open(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId)
{
    /* Init parameters */
    /* Default pass through */
    s_astCIMaXPlusParam[enCIPort].astCardParam[enCardId].bPlugIn   = HI_TRUE;
    s_astCIMaXPlusParam[enCIPort].astCardParam[enCardId].bTSByPass = HI_FALSE;

    /* Do nothing on hardware */

    return HI_SUCCESS;
}

/* Close Card */
HI_VOID CIMAXPLUS_PCCD_Close(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId)
{
    /* Do nothing on hardware */

    /* Default pass through */
    s_astCIMaXPlusParam[enCIPort].astCardParam[enCardId].bPlugIn   = HI_TRUE;
    s_astCIMaXPlusParam[enCIPort].astCardParam[enCardId].bTSByPass = HI_FALSE;
}

/* Card present or absent detect */
HI_S32 CIMAXPLUS_PCCD_Detect(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                             HI_UNF_CI_PCCD_STATUS_E_PTR penCardIdStatus)
{
    HI_U32 u32Address;
    HI_U8 u8Tmp = 0;


    if (s_astCIMaXPlusParam[enCIPort].astCardParam[enCardId].enRunStep == HI_CI_PCCD_RUN_STEP_RESUME)
    {
        *penCardIdStatus = HI_UNF_CI_PCCD_STATUS_ABSENT;
        s_astCIMaXPlusParam[enCIPort].astCardParam[enCardId].enRunStep = HI_CI_PCCD_RUN_STEP_RUNNING;
        s_astCIMaXPlusParam[enCIPort].astCardParam[enCardId].bPlugIn = 0x00;
        return HI_SUCCESS;
    }

    switch (enCardId)
    {
    case HI_UNF_CI_PCCD_A:
        u32Address = MOD_CTRL_REGA;
        break;

    case HI_UNF_CI_PCCD_B:
        u32Address = MOD_CTRL_REGB;
        break;

    default:
        return HI_ERR_CI_INVALID_PARA;
    }

    if (CIMAXPLUS_ReadExReg(enCIPort, u32Address, &u8Tmp, 1))
    {
        return HI_ERR_CI_REG_READ_ERR;
    }
    else
    {
        HI_INFO_CI("u8Tmp=%d.\n", u8Tmp);
        *penCardIdStatus = u8Tmp & 0x01;
        /* Self bypass when pull out, non-bypass when plug in */
        if (s_astCIMaXPlusParam[enCIPort].astCardParam[enCardId].bPlugIn != (u8Tmp & 0x01))
        {
            /* plug in */
            if (u8Tmp & 0x01)
            {
            //    CIMAXPLUS_PCCD_TSByPass(enCIPort, enCardId, HI_FALSE);
            }
            /* pull out */
            else
            {
            //    CIMAXPLUS_PCCD_TSByPass(enCIPort, enCardId, HI_TRUE);
            }

            s_astCIMaXPlusParam[enCIPort].astCardParam[enCardId].bPlugIn = u8Tmp & 0x01;
        }
    }

    return HI_SUCCESS;
}

/* Card busy or ready detect */
HI_S32 CIMAXPLUS_PCCD_ReadyOrBusy(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                                  HI_UNF_CI_PCCD_READY_E_PTR penCardReady)
{
    HI_U32 u32Address;
    HI_U8 u8Tmp = 0;
    HI_U8 u8Mask;

    u32Address = MOD_IT_STATUS_REG;

    if (CIMAXPLUS_ReadExReg(enCIPort, u32Address, &u8Tmp, 1))
    {
        return HI_ERR_CI_REG_READ_ERR;
    }
    else
    {
        switch (enCardId)
        {
        case HI_UNF_CI_PCCD_A:
            u8Mask = CIMAXPLUS_CARD_READY_MASK_A;
            break;

        case HI_UNF_CI_PCCD_B:
            u8Mask = CIMAXPLUS_CARD_READY_MASK_B;
            break;

        default:
            return HI_ERR_CI_INVALID_PARA;
        }

        /* This mask bit's value 1 is low active */
        if ((u8Tmp & u8Mask) == 0)
        {
            *penCardReady = HI_UNF_CI_PCCD_READY;
        }
        else
        {
            *penCardReady = HI_UNF_CI_PCCD_BUSY;
        }
    }

    return HI_SUCCESS;
}

/* Reset PCCD */
HI_S32 CIMAXPLUS_PCCD_Reset(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId)
{
    HI_S32 s32Ret   = CIMAX_NO_CAM_ERROR;
    HI_S32 s32Retry = 0;
    HI_U8 au8BufferIn[CIMAX_CAM_HEADER_SIZE + CIMAX_CAM_STATUS_MAX_SIZE] = {0};
    HI_U8 u8CamStatus = (HI_UNF_CI_PCCD_A == enCardId) ? CIMAX_CAM_A_RESET_OK : CIMAX_CAM_B_RESET_OK;
    
    /* Send command to CIMaX+. */
    while (CIMAX_NO_CAM_ERROR == s32Ret)
    {
        s32Ret = CIMAXPLUS_AccessCAM(enCIPort, enCardId, CIMAX_CAM_RESET_CMD, HI_NULL, 0, au8BufferIn,
                                     CIMAX_CAM_HEADER_SIZE);

        if (0 == s32Ret)
        {
            break;
        }
        else
        {
            s32Retry++;
            if (s32Retry > RESET_RETRY_TIMES)
            {
                break;
            }

            msleep(RESET_DELAY_TIME);
        }
    }

    /* Check if response is valid. */
    if (0 != s32Ret)
    {
        HI_ERR_CI("PCCD Reset fail:%d.\n", s32Ret);
        return HI_FAILURE;
    }
    else if ((au8BufferIn[CIMAX_CAM_COMMAND_OR_STATUS_POS] != u8CamStatus)
       || (au8BufferIn[CIMAX_CAM_PACKET_COUNTER_POS] != CIMAX_CAM_PACKET_COUNTER_VALUE)
       || (au8BufferIn[CIMAX_CAM_DATA_LEN_MSB_POS] != 0x00)
       || (au8BufferIn[CIMAX_CAM_DATA_LEN_LSB_POS] != 0x00))
    {
        HI_ERR_CI("PCCD Reset err.\n");
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

/* Get Read/Write status: FR/DA/RE/WE */
HI_S32 CIMAXPLUS_PCCD_GetRWStatus(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_U8 *pu8Value)
{
    HI_S32 s32Ret = HI_SUCCESS;
    HI_U8 au8BufferIn[CIMAX_CAM_HEADER_SIZE + CIMAX_CAM_REG_STATUS_PAYLOAD_SIZE] = {0};
    HI_U8 u8CamStatus = (HI_UNF_CI_PCCD_A == enCardId) ? CIMAX_CAM_A_REG_STATUS_OK : CIMAX_CAM_B_REG_STATUS_OK;

    /* Send command to CIMaX+. */
    s32Ret = CIMAXPLUS_AccessCAM(enCIPort, enCardId, CIMAX_CAM_REG_STATUS, HI_NULL, 0, au8BufferIn, sizeof(au8BufferIn));

    /* Check if response is valid. */
    if (0 != s32Ret)
    {
        HI_ERR_CI("PCCD GetStatus fail:%d.\n", s32Ret);
        return HI_FAILURE;
    }
    else if ((au8BufferIn[CIMAX_CAM_COMMAND_OR_STATUS_POS] != u8CamStatus)
       || (au8BufferIn[CIMAX_CAM_PACKET_COUNTER_POS] != CIMAX_CAM_PACKET_COUNTER_VALUE)
       || (au8BufferIn[CIMAX_CAM_DATA_LEN_MSB_POS] != 0x00)
       || (au8BufferIn[CIMAX_CAM_DATA_LEN_LSB_POS] != 0x01))
    {
        HI_ERR_CI("PCCD GetStatus err.\n");
        return HI_FAILURE;
    }

    /* Extract status register. */
    *pu8Value = au8BufferIn[CIMAX_CAM_FIRST_DATA_BYTE_POS];
    return HI_SUCCESS;
}

/* TS ByPass */
HI_S32 CIMAXPLUS_PCCD_TSByPass(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_BOOL bByPass)
{
    HI_U8 u8ModTmp = 0;
    HI_U8 u8ChTmp = 0;

    if (s_astCIMaXPlusParam[enCIPort].astCardParam[enCardId].bTSByPass == bByPass)
    {
        return HI_SUCCESS;
    }

    /* Read CAM selection */
    if (CIMAXPLUS_ReadExReg(enCIPort, ROUTER_CAM_MOD_REG, &u8ModTmp, 1))
    {
        return HI_ERR_CI_REG_READ_ERR;
    }

    /* Read channel out selection */
    if (CIMAXPLUS_ReadExReg(enCIPort, ROUTER_CAM_CH_REG, &u8ChTmp, 1))
    {
        return HI_ERR_CI_REG_READ_ERR;
    }

    HI_INFO_CI("TS CTRL: REG %04x read %02x\n", ROUTER_CAM_MOD_REG, u8ModTmp);
    HI_INFO_CI("TS CTRL: REG %04x read %02x\n", ROUTER_CAM_CH_REG, u8ChTmp);

    if (HI_UNF_CI_TSI_DAISY_CHAINED == s_astCIMaXPlusParam[enCIPort].enTSIMode)
    {
        if (!bByPass)
        {
            /* Double card non-bypass */
            if (((!s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_B].bTSByPass)
                 && (HI_UNF_CI_PCCD_A == enCardId))
               || ((!s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_A].bTSByPass)
                 && (HI_UNF_CI_PCCD_B == enCardId)))
            {
                /* ch 0 in -> CAM A -> CAM B -> ch 0 out */
                u8ModTmp = ROUTER_CAM_MODA_FROM_CH0IN | ROUTER_CAM_MODB_FROM_MODA;
                u8ChTmp = ROUTER_CAM_CH_0_OUT_SEL_MODB | ROUTER_CAM_CH_1_OUT_SEL_MODB;
                HI_INFO_CI("DC:Double card non-bypass\n");
            }
            /* Only CAM A non-bypass */
            else if (HI_UNF_CI_PCCD_A == enCardId)
            {
                /* none -> CAM B, ch 0 in -> CAM A -> ch 0 out */
                u8ModTmp = ROUTER_CAM_MODA_FROM_CH0IN | ROUTER_CAM_MODB_NONE;
                u8ChTmp = ROUTER_CAM_CH_0_OUT_SEL_MODA | ROUTER_CAM_CH_1_OUT_SEL_MODA;
                HI_INFO_CI("DC:Only CAM A non-bypass\n");
            }
            /* Only CAM B non-bypass */
            else if (HI_UNF_CI_PCCD_B == enCardId)
            {
                /* none -> CAM A, ch 0 in -> CAM B -> ch 0 out */
                u8ModTmp = ROUTER_CAM_MODA_NONE | ROUTER_CAM_MODB_FROM_CH0IN;
                u8ChTmp = ROUTER_CAM_CH_0_OUT_SEL_MODB | ROUTER_CAM_CH_1_OUT_SEL_MODB;
                HI_INFO_CI("DC:Only CAM B non-bypass\n");
            }

            /* Write register */
            if (CIMAXPLUS_WriteExReg(enCIPort, ROUTER_CAM_MOD_REG, &u8ModTmp, 1))
            {
                return HI_ERR_CI_REG_WRITE_ERR;
            }

            HI_INFO_CI("DC:Non-bypass: REG %04x write %02x\n", ROUTER_CAM_MOD_REG, u8ModTmp);

            /* Write register */
            if (CIMAXPLUS_WriteExReg(enCIPort, ROUTER_CAM_CH_REG, &u8ChTmp, 1))
            {
                return HI_ERR_CI_REG_WRITE_ERR;
            }

            HI_INFO_CI("DC:Non-bypass: REG %04x write %02x\n", ROUTER_CAM_CH_REG, u8ChTmp);
        }
        /* By pass */
        else
        {
            /* Double card bypass */
            if (((s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_B].bTSByPass)
                 && (HI_UNF_CI_PCCD_A == enCardId))
               || ((s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_A].bTSByPass)
                 && (HI_UNF_CI_PCCD_B == enCardId)))
            {
                /* none -> CAM A,  none -> CAM B, ch 0 in -> ch 0 out */
                u8ModTmp = ROUTER_CAM_MODA_NONE | ROUTER_CAM_MODB_NONE;
                u8ChTmp = ROUTER_CAM_CH_0_OUT_SEL_CH0IN | ROUTER_CAM_CH_1_OUT_SEL_CH0IN;
                HI_INFO_CI("DC:Double card bypass\n");
            }
            /* Only CAM A bypass */
            else if (HI_UNF_CI_PCCD_A == enCardId)
            {
                /* none -> CAM A, ch 0 in -> CAM B -> ch 0 out */
                u8ModTmp = ROUTER_CAM_MODA_NONE | ROUTER_CAM_MODB_FROM_CH0IN;
                u8ChTmp = ROUTER_CAM_CH_0_OUT_SEL_MODB | ROUTER_CAM_CH_1_OUT_SEL_MODB;
                HI_INFO_CI("DC:Only CAM A bypass\n");
            }
            /* Only CAM B bypass */
            else if (HI_UNF_CI_PCCD_B == enCardId)
            {
                /* none -> CAM B, ch 0 in -> CAM A -> ch 0 out */
                u8ModTmp = ROUTER_CAM_MODA_FROM_CH0IN | ROUTER_CAM_MODB_NONE;
                u8ChTmp = ROUTER_CAM_CH_0_OUT_SEL_MODA | ROUTER_CAM_CH_1_OUT_SEL_MODA;
                HI_INFO_CI("DC:Only CAM B bypass\n");
            }

            /* Write register */
            if (CIMAXPLUS_WriteExReg(enCIPort, ROUTER_CAM_MOD_REG, &u8ModTmp, 1))
            {
                return HI_ERR_CI_REG_WRITE_ERR;
            }

            HI_INFO_CI("DC:Bypass: REG %04x write %02x\n", ROUTER_CAM_MOD_REG, u8ModTmp);

            /* Write register */
            if (CIMAXPLUS_WriteExReg(enCIPort, ROUTER_CAM_CH_REG, &u8ChTmp, 1))
            {
                return HI_ERR_CI_REG_WRITE_ERR;
            }

            HI_INFO_CI("DC:Bypass: REG %04x write %02x\n", ROUTER_CAM_CH_REG, u8ChTmp);
        }
    }
    else
    {
        if (!bByPass)
        {
            /* Set CAM selection */
            if (HI_UNF_CI_PCCD_A == enCardId)
            {
                u8ModTmp &= ~CIMAXPLUS_MOD_A_SEL_MASK;
            }
            else
            {
                u8ModTmp &= ~CIMAXPLUS_MOD_B_SEL_MASK;
            }

            u8ModTmp |= s_astCIMaXPlusParam[enCIPort].astCardParam[enCardId].u8MODSelection;

            /* Write register */
            if (CIMAXPLUS_WriteExReg(enCIPort, ROUTER_CAM_MOD_REG, &u8ModTmp, 1))
            {
                return HI_ERR_CI_REG_WRITE_ERR;
            }

            HI_INFO_CI("IN:Non-bypass: REG %04x write %02x\n", ROUTER_CAM_MOD_REG, u8ModTmp);

            /* Set channel out selection */
            if (HI_UNF_CI_PCCD_A == enCardId)
            {
                u8ChTmp &= ~CIMAXPLUS_CH_0_OUT_SEL_MASK;
            }
            else
            {
                u8ChTmp &= ~CIMAXPLUS_CH_1_OUT_SEL_MASK;
            }

            /* Write register */
            if (CIMAXPLUS_WriteExReg(enCIPort, ROUTER_CAM_CH_REG, &u8ChTmp, 1))
            {
                return HI_ERR_CI_REG_WRITE_ERR;
            }

            HI_INFO_CI("IN:Non-bypass: REG %04x write %02x\n", ROUTER_CAM_CH_REG, u8ChTmp);
        }
        /* By pass */
        else
        {            
            /* Cam select NONE */
            if (HI_UNF_CI_PCCD_A == enCardId)
            {
                u8ModTmp &= ~CIMAXPLUS_MOD_A_SEL_MASK;
            }
            else
            {
                u8ModTmp &= ~CIMAXPLUS_MOD_B_SEL_MASK;
            }

            /* Write register */
            if (CIMAXPLUS_WriteExReg(enCIPort, ROUTER_CAM_MOD_REG, &u8ModTmp, 1))
            {
                return HI_ERR_CI_REG_WRITE_ERR;
            }

            HI_INFO_CI("IN:Bypass: REG %04x write %02x\n", ROUTER_CAM_MOD_REG, u8ModTmp);

            /* Set channel out selection */
            if (HI_UNF_CI_PCCD_A == enCardId)
            {
                u8ChTmp &= ~CIMAXPLUS_CH_0_OUT_SEL_MASK;
            }
            else
            {
                u8ChTmp &= ~CIMAXPLUS_CH_1_OUT_SEL_MASK;
            }

            u8ChTmp |= s_astCIMaXPlusParam[enCIPort].astCardParam[enCardId].u8CHOutSelection;

            /* Write register */
            if (CIMAXPLUS_WriteExReg(enCIPort, ROUTER_CAM_CH_REG, &u8ChTmp, 1))
            {
                return HI_ERR_CI_REG_WRITE_ERR;
            }

            HI_INFO_CI("IN:Bypass: REG %04x write %02x\n", ROUTER_CAM_CH_REG, u8ChTmp);
        }
    }

    /* Save ByPass flag */
    s_astCIMaXPlusParam[enCIPort].astCardParam[enCardId].bTSByPass = bByPass;
    
    return HI_SUCCESS;
}

/* Set access mode of card */
HI_S32 CIMAXPLUS_PCCD_SetAccessMode(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                                    HI_UNF_CI_PCCD_ACCESSMODE_E enAccessMode)
{
    /* CIMaX+ don't need set access mode independently */
    return HI_SUCCESS;
}

HI_S32 CIMAXPLUS_PCCD_GetAccessMode(HI_UNF_CI_PORT_E enCIPort,
                                    HI_UNF_CI_PCCD_E enCardId, HI_UNF_CI_PCCD_ACCESSMODE_E *penAccessMode)
{
    HI_U32 u32Address;
    HI_U8 u8Tmp = 0;

    switch (enCardId)
    {
    case HI_UNF_CI_PCCD_A:
        u32Address = MOD_CTRL_REGA;
        break;

    case HI_UNF_CI_PCCD_B:
        u32Address = MOD_CTRL_REGB;
        break;

    default:
        return HI_ERR_CI_INVALID_PARA;
    }

    /* Read control reg */
    if (CIMAXPLUS_ReadExReg(enCIPort, u32Address, &u8Tmp, 1))
    {
        return HI_ERR_CI_REG_READ_ERR;
    }

    /* Get bit */
    *penAccessMode = (u8Tmp & CIMAXPLUS_ACCESS_MODE_MASK) >> 2;

    return HI_SUCCESS;
}

HI_S32 CIMAXPLUS_PCCD_CtrlPower(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                                HI_UNF_CI_PCCD_CTRLPOWER_E enCtrlPower)
{
    /* Our reference board doesn't use the GPIO to control power */
    return HI_SUCCESS;
}

/* Low Power */
HI_S32 CIMAXPLUS_Standby(HI_UNF_CI_PORT_E enCIPort)
{
    HI_UNF_CI_PCCD_E enCardId;

    for(enCardId = HI_UNF_CI_PCCD_A; enCardId < HI_UNF_CI_PCCD_BUTT; enCardId++)
    {
        s_astCIMaXPlusParam[enCIPort].astCardParam[enCardId].enRunStep = HI_CI_PCCD_RUN_STEP_STANDBY;
    }

    return CIMAXPLUS_DeInit(enCIPort);
}

/* Resume CI */
HI_S32 CIMAXPLUS_Resume(HI_UNF_CI_PORT_E enCIPort)
{
    HI_UNF_CI_PCCD_E enCardId;
        
    for(enCardId = HI_UNF_CI_PCCD_A; enCardId < HI_UNF_CI_PCCD_BUTT; enCardId++)
    {
        s_astCIMaXPlusParam[enCIPort].astCardParam[enCardId].enRunStep = HI_CI_PCCD_RUN_STEP_RESUME;
    }

    return CIMAXPLUS_Init(enCIPort);
}

HI_S32 CIMAXPLUS_PCCD_GetBypassMode(HI_UNF_CI_PORT_E enCIPort,
                                HI_UNF_CI_PCCD_E enCardId, HI_BOOL *bBypass)
{
    *bBypass = s_astCIMaXPlusParam[enCIPort].astCardParam[enCardId].bTSByPass;
    return HI_SUCCESS;
}

HI_S32 CIMAXPLUS_PCCD_GetCIS(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                             HI_U8 pu8CIS[MAX_CIS_SIZE], HI_U32 *pu32Len)
{
    HI_S32 s32Ret = HI_SUCCESS;
    HI_U8 au8BufferIn[CIMAX_CAM_HEADER_SIZE + CIMAX_CAM_CIS_MAX_SIZE] = {0};
    HI_U16 u16dataSize = 0;
    HI_U8 u8CamStatus = (HI_UNF_CI_PCCD_A == enCardId) ? CIMAX_CAM_A_GET_CIS_OK : CIMAX_CAM_B_GET_CIS_OK;

    /* Send command to CIMaX+. */
    s32Ret = CIMAXPLUS_AccessCAM(enCIPort, enCardId, CIMAX_CAM_GET_CIS_CMD, HI_NULL, 0, au8BufferIn, sizeof(au8BufferIn));

    /* Check if response is valid. */
    if (0 != s32Ret)
    {
        HI_ERR_CI("PCCD GetCIS fail:%d.\n", s32Ret);
        return HI_FAILURE;
    }
    else if ((au8BufferIn[CIMAX_CAM_COMMAND_OR_STATUS_POS] != u8CamStatus)
       || (au8BufferIn[CIMAX_CAM_PACKET_COUNTER_POS] != CIMAX_CAM_PACKET_COUNTER_VALUE))
    {
        HI_ERR_CI("PCCD GetCIS err.\n");
        return HI_FAILURE;
    }

    /* Copy CIS data */
    u16dataSize = au8BufferIn[CIMAX_CAM_DATA_LEN_MSB_POS] << 8 | au8BufferIn[CIMAX_CAM_DATA_LEN_LSB_POS];
    if (u16dataSize > MAX_CIS_SIZE)
    {
        u16dataSize = MAX_CIS_SIZE;
    }

    memcpy(pu8CIS, &au8BufferIn[CIMAX_CAM_HEADER_SIZE], u16dataSize);
    *pu32Len = u16dataSize;

    return HI_SUCCESS;
}

HI_S32 CIMAXPLUS_PCCD_WriteCOR(HI_UNF_CI_PORT_E enCIPort,
                               HI_UNF_CI_PCCD_E enCardId, HI_U16 u16Addr, HI_U8 u8COR)
{
    HI_S32 s32Ret   = CIMAX_CAM_CMD_PENDING;
    HI_S32 s32Retry = 0;

    /* Don't support CIMAX_CAM_COR_ADD_PAYLOAD now. CIMAX_CAM_COR_ADD_PAYLOAD_SIZE */
    HI_U8 au8BufferOut[CIMAX_CAM_COR_PAYLOAD_SIZE] = {0};
    HI_U8 au8BufferIn[CIMAX_CAM_HEADER_SIZE + CIMAX_CAM_STATUS_MAX_SIZE] = {0};
    HI_U8 u8CamStatus = (HI_UNF_CI_PCCD_A == enCardId) ? CIMAX_CAM_A_WRITE_COR_OK : CIMAX_CAM_B_WRITE_COR_OK;

    /* Prepare command. */
    au8BufferOut[CIMAX_CAM_COR_ADDR_MSB_POS] = (HI_U8)(u16Addr >> 8);
    au8BufferOut[CIMAX_CAM_COR_ADDR_LSB_POS] = (HI_U8)(u16Addr & 0x00FF);
    au8BufferOut[CIMAX_CAM_COR_VALUE_POS] = u8COR;
    au8BufferOut[CIMAX_CAM_COR_LAST_MSB_POS] = 0x00;
    au8BufferOut[CIMAX_CAM_COR_LAST_LSB_POS] = 0x00;

    /* Send command to CIMaX+. */
    while (CIMAX_CAM_CMD_PENDING == s32Ret)
    {
        s32Ret = CIMAXPLUS_AccessCAM(enCIPort, enCardId, CIMAX_CAM_WRITE_COR_CMD,
                                     au8BufferOut, sizeof(au8BufferOut), au8BufferIn, sizeof(au8BufferIn));

        if (0 == s32Ret)
        {
            break;
        }
        else
        {
            s32Retry++;
            if (s32Retry > WRITECOR_RETRY_TIMES)
            {
                break;
            }

            msleep(WRITECOR_DELAY_TIME);
        }
    }

    /* Check if response is valid. */
    if (0 != s32Ret)
    {
        HI_ERR_CI("PCCD WriteCOR fail:%d.\n", s32Ret);
        return HI_FAILURE;
    }
    else if ((au8BufferIn[CIMAX_CAM_COMMAND_OR_STATUS_POS] != u8CamStatus)
       || (au8BufferIn[CIMAX_CAM_PACKET_COUNTER_POS] != CIMAX_CAM_PACKET_COUNTER_VALUE)
       || (au8BufferIn[CIMAX_CAM_DATA_LEN_MSB_POS] != 0x00)
       || (au8BufferIn[CIMAX_CAM_DATA_LEN_LSB_POS] != 0x00))
    {
        HI_ERR_CI("PCCD WriteCOR err.\n");
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

HI_S32 CIMAXPLUS_PCCD_Negotiate(HI_UNF_CI_PORT_E enCIPort,
                                HI_UNF_CI_PCCD_E enCardId, HI_U16 *pu16BufferSize)
{
    HI_S32 s32Ret = HI_SUCCESS;
    HI_U16 u16Size;
    HI_U8 au8BufferOut[CIMAX_CAM_NEGOTIATE_PAYLOAD_SIZE] = {0};
    HI_U8 au8BufferIn[CIMAX_CAM_HEADER_SIZE + CIMAX_CAM_NEGOTIATE_PAYLOAD_SIZE] = {0};
    HI_U8 u8CamStatus = (HI_UNF_CI_PCCD_A == enCardId) ? CIMAX_CAM_A_NEGOTIATE_OK : CIMAX_CAM_B_NEGOTIATE_OK;

    /* Prepare command. */
    u16Size = MIN(CIMAX_CAM_MAX_PAYLOAD_SIZE, *pu16BufferSize);
    au8BufferOut[CIMAX_CAM_NEGOTIATE_SIZE_MSB_POS] = (HI_U8)(u16Size >> 8);
    au8BufferOut[CIMAX_CAM_NEGOTIATE_SIZE_LSB_POS] = (HI_U8)(u16Size & 0x00FF);

    /* Send command to CIMaX+. */
    s32Ret = CIMAXPLUS_AccessCAM(enCIPort, enCardId, CIMAX_CAM_NEGOCIATE_CMD,
                                 au8BufferOut, sizeof(au8BufferOut), au8BufferIn, sizeof(au8BufferIn));

    /* Check if response is valid. */
    if (0 != s32Ret)
    {
        HI_ERR_CI("PCCD Negotiate fail:%d.\n", s32Ret);
        return HI_FAILURE;
    }
    else if ((au8BufferIn[CIMAX_CAM_COMMAND_OR_STATUS_POS] != u8CamStatus)
       || (au8BufferIn[CIMAX_CAM_PACKET_COUNTER_POS] != CIMAX_CAM_PACKET_COUNTER_VALUE)
       || (au8BufferIn[CIMAX_CAM_DATA_LEN_MSB_POS] != 0x00)
       || (au8BufferIn[CIMAX_CAM_DATA_LEN_LSB_POS] != CIMAX_CAM_NEGOTIATE_PAYLOAD_SIZE))
    {
        HI_ERR_CI("PCCD Negotiate err.\n");
        return HI_FAILURE;
    }

    *pu16BufferSize = (au8BufferIn[CIMAX_CAM_FIRST_DATA_BYTE_POS] << 8) | au8BufferIn[CIMAX_CAM_SECOND_DATA_BYTE_POS];
    return HI_SUCCESS;
}

HI_S32 CIMAXPLUS_PCCD_IOReset(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId)
{
    /* Do nothing */
    return HI_SUCCESS;
}

HI_S32 CIMAXPLUS_PCCD_IOWrite(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                              const HI_U8 *pu8Buffer, HI_U32 u32WriteLen)
{
    HI_S32 s32Ret   = CIMAX_CAM_CMD_PENDING;
    HI_S32 s32Retry = 0;
    HI_U8 au8BufferIn[CIMAX_CAM_HEADER_SIZE + CIMAX_CAM_STATUS_MAX_SIZE] = {0};
    HI_U8 u8CamStatus = (HI_UNF_CI_PCCD_A == enCardId) ? CIMAX_CAM_A_WRITE_LPDU_OK : CIMAX_CAM_B_WRITE_LPDU_OK;

    /* Send command to CIMaX+. */
    while ((CIMAX_CAM_WRITE_BUSY_ERROR == s32Ret) || (CIMAX_CAM_CMD_PENDING == s32Ret))
    {
        s32Ret = CIMAXPLUS_AccessCAM(enCIPort, enCardId, CIMAX_CAM_WRITE_LPDU_CMD,
                                     pu8Buffer, u32WriteLen, au8BufferIn, sizeof(au8BufferIn));

        if (0 == s32Ret)
        {
            break;
        }
        else
        {
            s32Retry++;
            if (s32Retry > IOWR_RETRY_TIMES)
            {
                break;
            }

            msleep(IOWR_DELAY_TIME);
        }
    }

    /* Check if response is valid. */
    if (0 != s32Ret)
    {
        HI_ERR_CI("PCCD IOWrite fail:%d.\n", s32Ret);
        return HI_FAILURE;
    }
    else if ((au8BufferIn[CIMAX_CAM_COMMAND_OR_STATUS_POS] != u8CamStatus)
       || (au8BufferIn[CIMAX_CAM_PACKET_COUNTER_POS] != CIMAX_CAM_PACKET_COUNTER_VALUE)
       || (au8BufferIn[CIMAX_CAM_DATA_LEN_MSB_POS] != 0x00)
       || (au8BufferIn[CIMAX_CAM_DATA_LEN_LSB_POS] != 0x00))
    {
        HI_ERR_CI("PCCD IOWrite err.\n");
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

HI_S32 CIMAXPLUS_PCCD_IORead(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                             HI_U8 *pu8Buffer, HI_U32 *pu32ReadLen)
{
    HI_S32 s32Ret   = CIMAX_CAM_CMD_PENDING;
    HI_S32 s32Retry = 0;
    HI_U8 *pu8BufferIn = HI_NULL;
    HI_U8 u8CamStatus = (HI_UNF_CI_PCCD_A == enCardId) ? CIMAX_CAM_A_READ_LPDU_OK : CIMAX_CAM_B_READ_LPDU_OK;

    pu8BufferIn = HI_KMALLOC_CI(CIMAX_CAM_HEADER_SIZE+CIMAX_CAM_MAX_PAYLOAD_SIZE, GFP_KERNEL);
    if (HI_NULL == pu8BufferIn)
    {
        HI_ERR_CI("PCCD IORead no memory.\n");
        return HI_ERR_CI_NO_MEMORY;
    }

    /* Send command to CIMaX+. */
    while ((CIMAX_CAM_WRITE_BUSY_ERROR == s32Ret) || (CIMAX_CAM_CMD_PENDING == s32Ret))
    {
        s32Ret = CIMAXPLUS_AccessCAM(enCIPort, enCardId, CIMAX_CAM_READ_LPDU_CMD, HI_NULL, 0, pu8BufferIn,
                                     CIMAX_CAM_HEADER_SIZE + CIMAX_CAM_MAX_PAYLOAD_SIZE);

        if (0 == s32Ret)
        {
            break;
        }
        else
        {
            s32Retry++;
            if (s32Retry > IOWR_RETRY_TIMES)
            {
                break;
            }

            msleep(IOWR_DELAY_TIME);
        }
    }

    /* Check if response is valid. */
    if (0 != s32Ret)
    {
        HI_ERR_CI("PCCD IORead fail:%d.\n", s32Ret);
        HI_KFREE_CI(pu8BufferIn);
        return HI_FAILURE;
    }
    else if ((pu8BufferIn[CIMAX_CAM_COMMAND_OR_STATUS_POS] != u8CamStatus)
       || (pu8BufferIn[CIMAX_CAM_PACKET_COUNTER_POS] != CIMAX_CAM_PACKET_COUNTER_VALUE))
    {
        HI_ERR_CI("PCCD IORead err.\n");
        HI_KFREE_CI(pu8BufferIn);
        return HI_FAILURE;
    }

    *pu32ReadLen = (pu8BufferIn[CIMAX_CAM_DATA_LEN_MSB_POS] << 8) | (pu8BufferIn[CIMAX_CAM_DATA_LEN_LSB_POS]);
    memcpy(pu8Buffer, pu8BufferIn+CIMAX_CAM_HEADER_SIZE, *pu32ReadLen);
    HI_KFREE_CI(pu8BufferIn);

    return HI_SUCCESS;
}

HI_S32 CIMAXPLUS_PCCD_SetAttr(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                              CI_PCCD_ATTR_S *pstAttr)
{
    HI_U32 u32Address;
    HI_U8 u8Tmp;
    HI_U8 u8Time;

    s_astCIMaXPlusParam[enCIPort].astCardParam[enCardId].stAttr = *pstAttr;

    if (HI_UNF_CI_PCCD_A == enCardId)
    {
        u32Address = MEM_ACC_TIME_REGA;
    }
    else
    {
        u32Address = MEM_ACC_TIME_REGB;
    }

    /* Read MEM_ACC_TIME_REG */
    if (CIMAXPLUS_ReadExReg(enCIPort, u32Address, &u8Tmp, 1))
    {
        return HI_ERR_CI_REG_READ_ERR;
    }

    /* Convert time */
    switch (s_astCIMaXPlusParam[enCIPort].astCardParam[enCardId].stAttr.enSpeed)
    {
    case CI_PCCD_SPEED_600NS:
    default:
        u8Time = CIMAXPLUS_MEM_ACC_TIME_600NS;
        break;
    case CI_PCCD_SPEED_250NS:
        u8Time = CIMAXPLUS_MEM_ACC_TIME_250NS;
        break;
    case CI_PCCD_SPEED_200NS:
        u8Time = CIMAXPLUS_MEM_ACC_TIME_200NS;
        break;
    case CI_PCCD_SPEED_150NS:
        u8Time = CIMAXPLUS_MEM_ACC_TIME_150NS;
        break;
    case CI_PCCD_SPEED_100NS:
        u8Time = CIMAXPLUS_MEM_ACC_TIME_100NS;
        break;
    }

    if ((u8Tmp & CIMAXPLUS_MEM_ACC_TIME_MASK) != (u8Time << 4))
    {
        HI_INFO_CI("Current time:%d, set to %d\n", (u8Tmp & CIMAXPLUS_MEM_ACC_TIME_MASK) >> 4, u8Time);
        u8Tmp = (u8Tmp & (~CIMAXPLUS_MEM_ACC_TIME_MASK)) | (u8Time << 4);

        if (CIMAXPLUS_WriteExReg(enCIPort, u32Address, &u8Tmp, 1))
        {
            HI_ERR_CI("CIMaX+ SetAttr fail.\n");
            return HI_ERR_CI_REG_WRITE_ERR;
        }
    }

    return HI_SUCCESS;
}

HI_S32 CIMAXPLUS_PCCD_SetTSMode(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                                HI_UNF_CI_TS_MODE_E enTSMode)
{
    HI_S32 s32Ret;

    switch (enCardId)
    {
    case HI_UNF_CI_PCCD_A:
    default:
        if (enTSMode == s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_A].enTSMode)
        {
            HI_ERR_CI("The same TS mode.\n");
            return HI_SUCCESS;
        }

        s32Ret = CIMAXPLUS_CreateConfigTable(enCIPort, s_astCIMaXPlusParam[enCIPort].enTSIMode,
                                             enCardId, enTSMode,
                                             s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_B].enTSMode);

        break;
    case HI_UNF_CI_PCCD_B:
        if (enTSMode == s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_B].enTSMode)
        {
            HI_ERR_CI("The same TS mode.\n");
            return HI_SUCCESS;
        }

        s32Ret = CIMAXPLUS_CreateConfigTable(enCIPort, s_astCIMaXPlusParam[enCIPort].enTSIMode,
                                             enCardId,
                                             s_astCIMaXPlusParam[enCIPort].astCardParam[HI_UNF_CI_PCCD_A].enTSMode,
                                             enTSMode);
        break;
    }

    if (HI_SUCCESS != s32Ret)
    {
        return s32Ret;
    }

    return CIMAXPLUS_Config(enCIPort);
}

HI_S32 CIMAXPLUS_PCCD_TSWrite(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                              HI_UNF_CI_PCCD_TSWRITE_S *pstWriteData)
{
    HI_S32 s32Ret = HI_SUCCESS;
    rw_data_t stRWData;
    struct file *pFILE;

    pFILE = s_astCIMaXPlusParam[enCIPort].pFILE;
    if (!pFILE)
    {
        return HI_FAILURE;
    }

    stRWData.type = DEVICE_TYPE_TS_WRITE;
    stRWData.moduleId = enCardId;
    stRWData.data = pstWriteData->pu8Data;
    stRWData.size = pstWriteData->u32Size;
    stRWData.copiedSize = 0;

    s32Ret = pFILE->f_op->write(pFILE, (char *)&stRWData, sizeof(stRWData), HI_NULL);
    if (0 > s32Ret)
    {
        HI_ERR_CI("CIMaX+ TS write fail. %d\n", s32Ret);
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

/*********************************** END ************************************************/
