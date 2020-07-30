/**************************************************************************//**
 * @file    cimax+usb-driver.h
 *
 * @brief   CIMaX+ USB Driver for linux based operating systems.
 *
 * Copyright (C) 2009-2011    Bruno Tonelli   <bruno.tonelli@smardtv.com>
 *                          & Franck Descours <franck.descours@smardtv.com>
 *                            for SmarDTV France, La Ciotat
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 *
 ******************************************************************************/
     
#include <linux/version.h>
#include "drv_cimaxplus_ioctl.h"
#include <linux/module.h>
#include <linux/init.h>

#ifndef CIMAXPLUS_USB_DRIVER_H
#define CIMAXPLUS_USB_DRIVER_H

/* l00185424 */
#define KERNEL_ACCESS
#define WAIT_FIRMWARE_UPLOAD
#define ONLY_SUPPORT_ONE_DEVICE
#define DROP_USB_IN_DATA
#define DROP_ASYNC_DATAREADY
#define DONOT_STUFF_NULL_PACKET


/******************************************************************************
 * Includes
 *****************************************************************************/
/******************************************************************************
 * Defines
 *****************************************************************************/
/**
 *  @brief
 *    Driver Name
*/
#define DRIVER_NAME        "cimax+usb"
/**
 *  @brief
 *    An unassigned USB minor.
*/
#define DEVICE_MINOR                          240

/**
 *  @brief
 *    Driver version.
*/
#define DEVICE_VERSION                     0x1000

/**
 *  @brief
 *    Number of CA module supported by the driver.
*/
#define DEVICE_NUM_CAM                          2

/**
 *  @brief
 *    Buffer length.
*/
#define DEVICE_MESSAGE_LENGTH                4100

/* Offset */
#define DEVICE_COMMAND_OFFSET                   0
#define DEVICE_STATUS_OFFSET                    0
#define DEVICE_COUNTER_OFFSET                   1
#define DEVICE_LENGTH_MSB_OFFSET                2
#define DEVICE_LENGTH_LSB_OFFSET                3
#define DEVICE_DATA_OFFSET                      4

/* Mask */
#define DEVICE_SEL_MASK                      0x80
#define DEVICE_TYP_MASK                      0x40
#define DEVICE_CMD_MASK                      0x3F

/* Command tag */
#define DEVICE_CMD_INIT                      0x00
#define DEVICE_CMD_WRITE_REG                 0x7F
#define DEVICE_CMD_READ_REG                  0xFF
#define DEVICE_CMD_CAMRESET                  0x01
#define DEVICE_CMD_GETCIS                    0x02
#define DEVICE_CMD_WRITECOR                  0x03
#define DEVICE_CMD_NEGOTIATE                 0x04
#define DEVICE_CMD_WRITELPDU                 0x05
#define DEVICE_CMD_READLPDU                  0x06
#define DEVICE_CMD_WRITEEXT                  0x07
#define DEVICE_CMD_READEXT                   0x08
#define DEVICE_CMD_CC1RESET                  0x09
#define DEVICE_CMD_MCARD_WRITE               0x0a

/* Status field */
#define DEVICE_CAMRESETOK                    0x00
#define DEVICE_CISOK                         0x01
#define DEVICE_WRITECOROK                    0x02
#define DEVICE_NEGOTIATEOK                   0x03
#define DEVICE_WRITELPDUOK                   0x04
#define DEVICE_CAMDET                        0x05
#define DEVICE_READLPDUOK                    0x06
#define DEVICE_WRITEEXTOK                    0x07
#define DEVICE_READEXTOK                     0x08
#define DEVICE_NO_CAM                        0x09
#define DEVICE_NOK                           0x0a
#define DEVICE_INITOK                        0x0b
#define DEVICE_READ_REGOK                    0x0c
#define DEVICE_WRITE_REGOK                   0x0d
#define DEVICE_DATAREADY                     0x0e
#define DEVICE_MCARD_WRITEOK                 0x0f
#define DEVICE_MCARD_READ                    0x10
#define DEVICE_CAMPARSE_ERROR                0x11
#define DEVICE_WRITELPDUBUSY                 0x14
#define DEVICE_CMDPENDING                    0x16
#define DEVICE_REGSTATUSOK                   0x17
#define DEVICE_GPIOCHANGE                    0x18
#define DEVICE_FRBit                         0x1A


#define DEVICE_DATAREADY_SYNC                0x3e

/**
 *  @brief
 *    MPEG2 transport size,.isochronous size and number of frames per URB.
*/
#define DEVICE_MPEG2_PACKET_SIZE             188
#define DEVICE_MPEG2_SYNC_BYTE               0x47
#define DEVICE_NULL_HEADER_SIZE              8
#define DEVICE_NUM_FRAMES_PER_URB            8
#define DEVICE_ISOC_LENGTH(x)                (DEVICE_NUM_FRAMES_PER_URB*x)

#ifndef DROP_USB_IN_DATA
#define DEVICE_VB_LENGTH                     902400    
#else
#define DEVICE_VB_LENGTH                     4    
#endif
/**
 *  @brief
 *    Endpoint address.
*/
#define DEVICE_TS_IN_PIPE                      1 /* and 2 */
#define DEVICE_TS_OUT_PIPE                     3 /* and 4 */
#define DEVICE_INT_IN_PIPE                     5
#define DEVICE_BULK_OUT_PIPE                   6
#define DEVICE_BULK_OUT_MAXPACKET            256

/**
 *  @brief
 *    Number of isochronous/int URBs in the driver.
*/
#define DEVICE_NUM_ISOC_OUT_URBS                3
#define DEVICE_NUM_ISOC_IN_URBS                 2
#define DEVICE_NUM_INT_IN_URBS                  2

/**
 *  @brief
 *    ioctl() calls definition.
*/
/* Moved to priv_cimax+.h by l00185424 */
/*typedef signed long               __i32;
#define DEVICE_IOC_MAGIC          'a'
#define DEVICE_IOC_SELECT_INTF    _IOWR(DEVICE_IOC_MAGIC,  0, __i32)
#define DEVICE_IOC_CI_WRITE       _IOWR(DEVICE_IOC_MAGIC,  1, ioctl_data_t)
#define DEVICE_IOC_UNLOCK_READ    _IOWR(DEVICE_IOC_MAGIC,  2, __i32)
#define DEVICE_IOC_SET_CONFIG     _IOWR(DEVICE_IOC_MAGIC,  3, ioctl_data_t)
#define DEVICE_IOC_MAXNR          4*/

/******************************************************************************
 * Types
 *****************************************************************************/
#ifdef __KERNEL__
#include <linux/list.h>
#include <asm/atomic.h>

#undef dbg
#undef dbg_isoc_in
#undef dbg_isoc_out

#undef err
#undef info
#undef warn
//////////////////////////////////////
//#define DEBUG
//////////////////////////////////////
#ifdef DEBUG
#define dbg(format, arg...) HI_FATAL_CIMAXPLUS("cimax+usb: %s> " format "\n" , \
                                      __FUNCTION__, ## arg)
#define dbg_s(format, arg...) HI_FATAL_CIMAXPLUS("cimax+usb: " format "\n" , ## arg)
#else
#define dbg(format, arg...) do {} while (0)
#define dbg_s(format, arg...) do {} while (0)
#endif

#ifdef DEBUG_ISOC_IN
#define dbg_isoc_in(format, arg...) HI_FATAL_CIMAXPLUS("cimax+usb: %s> " format "\n" , \
                                          __FUNCTION__, ## arg)
#else
#define dbg_isoc_in(format, arg...) do {} while (0)
#endif

#ifdef DEBUG_ISOC_OUT
#define dbg_isoc_out(format, arg...) HI_FATAL_CIMAXPLUS("cimax+usb: %s> " format "\n" , \
                                      __FUNCTION__, ## arg)
#else
#define dbg_isoc_out(format, arg...) do {} while (0)
#endif

#define err(format, arg...) HI_ERR_CIMAXPLUS("cimax+usb: %s> ERROR " format "\n" , \
                                   __FUNCTION__, ## arg)
#define info(format, arg...) HI_INFO_CIMAXPLUS("cimax+usb: %s> " format "\n" , \
                                    __FUNCTION__, ## arg)
#define warn(format, arg...) HI_WARN_CIMAXPLUS("cimax+usb: %s> WARN" format "\n" , \
                                    __FUNCTION__, ## arg)

/**
 *  @brief
 *    Video buffer structure.
*/
typedef struct
{
  __u8 data[DEVICE_VB_LENGTH];
  int  readOffset;
  int  writeOffset;
  int  isEmpty;
} video_buf_t,*pvideo_buf_t;
#endif

/**
 *  @brief
 *    Io control data structure exchanged between user and kernel space.
*/
/* Moved to priv_cimax+.h by l00185424 */
/*typedef struct
{
  __u8* txData;
  __u32 txSize;
  __u8* rxData;
  __u32 rxSize;
} ioctl_data_t,*pioctl_data_t;*/

/**
 *  @brief
 *    Read/write type exchanged between user and kernel space.
*/
/* Moved to priv_cimax+.h by l00185424 */
/*typedef enum {
  DEVICE_TYPE_CI_READ,
  DEVICE_TYPE_TS_WRITE,
  DEVICE_TYPE_TS_READ
} rw_type_t;*/

/**
 *  @brief
 *    Read/write data structure exchanged between user and kernel space.
*/
/* Moved to priv_cimax+.h by l00185424 */
/*typedef struct
{
  rw_type_t type;
  __u8      moduleId;
  __u8*     data;
  __u32     size;
  __u32     copiedSize;
} rw_data_t,*prw_data_t;*/

#ifdef __KERNEL__
/**
 *  @brief
 *    Message node structure. Can be inserted in a list.
*/
typedef struct
{
  __u8              data[DEVICE_MESSAGE_LENGTH];
  __u32             size;
  struct list_head  node;
} message_node_t,*pmessage_node_t;

/**
 *  @brief
 *    Received CI data.
*/
typedef struct
{
  wait_queue_head_t  syncWait;
  __u8               syncSignal;
  __u8               syncData[DEVICE_MESSAGE_LENGTH];
  __u32              syncDataSize;
  wait_queue_head_t  asyncWait;
  struct list_head   asyncDataList;
  __u8               bPendingSend;
} ci_rx_data_t,*pci_rx_data_t;

/**
 *  @brief
 *    CI bulk channel.
*/
typedef struct
{
  __u8               counter;
  __u16              inMaxPacketSize;
  __u16              outMaxPacketSize;
  struct urb*        intUrb[DEVICE_NUM_INT_IN_URBS];
  spinlock_t         intLock;
  spinlock_t         intUrbLock;
  __u8               intCurrStatus;
  __u8               intCurrIndex;
  __u16              intSizeToReceive;
  ci_rx_data_t       ciData[DEVICE_NUM_CAM];
} ci_bulk_t,*pci_bulk_t;

/**
 *  @brief
 *    TS channel (can use isoc or bulk interface).
*/
typedef struct
{
  spinlock_t        inLock;
  wait_queue_head_t inWait;
  video_buf_t       inVb;
  int               syncOffset;
  int               prevOffset;
  __u8              lastPacket[DEVICE_MPEG2_PACKET_SIZE];
  __u8              lastPacketSize;
  spinlock_t        outLock;
  __u8              nextFreeOutUrbIndex;
  atomic_t          numOutUrbs;
  __u8              outStop;
  __u16             maxPacketSize;
  /* isochronous urbs */
  struct urb*       isocInUrb[DEVICE_NUM_ISOC_IN_URBS];
  struct urb*       isocOutUrb[DEVICE_NUM_ISOC_OUT_URBS];
  /* bulk urbs */
  struct urb*       bulkInUrb;
   int              nbByteSend;
   int              nbByteRead;
   __u8             FirstTransfer;
   struct timer_list StartBulkReadTimer;

#ifdef DEBUG_BITRATE
   ktime_t bitrateTime
#endif
} ts_channel_t,*pts_channel_t;

typedef struct
{
  struct mutex       lock;
  struct usb_device* usbdev;
  __u8               opened;
  __u8               askToRelease;
  __u8               askToSuspend;
  __u8               outCompelete;
  ci_bulk_t          ciBulk;
  __u8               useIsoc;
  ts_channel_t       channel[DEVICE_NUM_CAM];
  /* bus adapter private ops callback */
  struct cimaxusb_priv_ops_t *ops;
} device_t,*pdevice_t;

typedef struct
{
   pdevice_t device;
   __u8      index;
} bulk_timer_t,*pbulk_timer_t;
#endif
#endif
