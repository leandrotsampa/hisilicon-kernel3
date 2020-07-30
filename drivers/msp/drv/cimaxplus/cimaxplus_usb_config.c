/**************************************************************************//**
 * @file    cimax+usb_config.c
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
/******************************************************************************
 * Include
 ******************************************************************************/
#include <linux/slab.h>
#include <linux/init.h>

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/poll.h>
#include <linux/usb.h>

#include <linux/errno.h>
#include <linux/firmware.h>

#include <asm/uaccess.h>
#include <asm/mutex.h>

#include "cimaxplus_usb-driver.h"
#include "cimaxplus_usb_config.h"
#include "bodydef.h"

#define __USE_KERNER_CIMAX_FIRMWARE_CFG

/******************************************************************************
 * Structures
 ******************************************************************************/
/******************************************************************************
 * Globals
 ******************************************************************************/
char cimax_config_file[] = CIMAX_CONFIG_NAME;
#ifdef __USE_KERNER_CIMAX_FIRMWARE_CFG
static const unsigned char s_cimax_firmware_cfg[] = {
#include "cimaxplus_usb.cfg.txt"
};
#endif
/******************************************************************************
 * Functions
 ******************************************************************************/
/******************************************************************************
 * @brief
 *   set CIMaX+ register value.
 *
 * @param   bus_adap
 *   Pointer to CIMaX+ usb adapter.
 *
 * @param   addr
 *   Addr of CIMaX+ register.
 *
 * @param   val
 *   CIMaX+ register value to set.
 *
 * @return
 *   0 if OK otherwise -1.
 ******************************************************************************/
int usb_setbyte( pdevice_t bus_adap, unsigned int addr, unsigned char val )
{
   unsigned char cmd[5];
   unsigned char *buf;
   int len;
   struct usb_device *dev = bus_adap->usbdev;

   cmd[0] = 0x7F; 
   cmd[1] = (unsigned char)((addr>>8)&0xff);
   cmd[2] = (unsigned char)(addr&0xff);
   cmd[3] = 0x01;
   cmd[4] = val;  
   if(bus_adap->ops->write_ep6_message(dev, cmd, sizeof(cmd)) == sizeof(cmd)) {
      //err("%s-%s: cmd=0x%x\n", DRIVER_NAME, __FUNCTION__,cmd[0]);
      buf = kcalloc(256, sizeof(unsigned char), GFP_KERNEL);
      if (!buf) {
         err("%s-%s: out of memory.\n", DRIVER_NAME, __FUNCTION__);
         return -ENOMEM;
      }

      while ((len = bus_adap->ops->read_ep5_message(dev, buf, 256)) >= 0) {
         if(len == 0) {
            continue;
         }
         //err("%s-%s: 0x%x\n", DRIVER_NAME, __FUNCTION__,buf[0]);
         if((len == 5 ) && ((buf[0] & 0x7f) == 0x45)) {
            continue;
         }
         if ( len < 4 ) {
            err("%s-%s: failed to read addr 0x%x\n", DRIVER_NAME, __FUNCTION__,addr);
            kfree(buf);
            return -1;
         }
         else {
            break;
         }
      }
   }
   else {
      err("%s-%s: failed to write addr 0x%x\n", DRIVER_NAME, __FUNCTION__, addr);
      return -1;
   }
   kfree(buf);
   return 0;
}

/******************************************************************************
 * @brief
 *   get CIMaX+ register value.
 *
 * @param   bus_adap
 *   Pointer to CIMaX+ usb adapter.
 *
 * @param   addr
 *   Addr of CIMaX+ register.
 *
 * @param   val
 *   pointer to buffer to store CIMaX+ register value.
 *
 * @return
 *   0 if OK otherwise -1.
 ******************************************************************************/
int usb_getbyte( pdevice_t bus_adap, unsigned int addr, unsigned char *val )
{
   unsigned char cmd[4];
   unsigned char *buf;
   int len;
   struct usb_device *dev = bus_adap->usbdev;

   cmd[0] = 0xFF; 
   cmd[1] = (unsigned char)((addr>>8)&0xff);
   cmd[2] = (unsigned char)(addr&0xff);
   cmd[3] = 0x01;
   if(bus_adap->ops->write_ep6_message(dev, cmd, sizeof(cmd)) == sizeof(cmd)) {
      //err("%s-%s: cmd=0x%x\n", DRIVER_NAME, __FUNCTION__,cmd[0]);
      buf = kcalloc(256, sizeof(unsigned char), GFP_KERNEL);
      if (!buf) {
         err("%s-%s: out of memory.\n", DRIVER_NAME, __FUNCTION__);
         return -ENOMEM;
      }

      while ((len = bus_adap->ops->read_ep5_message(dev, buf, 256)) >= 0) {
         if(len == 0) {
            continue;
         }
         //err("%s-%s: 0x%x\n", DRIVER_NAME, __FUNCTION__,buf[0]);
         if((len == 5 ) && ((buf[0] & 0x7f) == 0x45)) {
            continue;
         }
         if ( len >= 5 ) {
            *val = buf[4];
            break;
         }
         else {
            err("%s-%s: failed to read addr 0x%x\n", DRIVER_NAME, __FUNCTION__,addr);
            kfree(buf);
            return -1;
         }
      }
   }
   else {
      err("%s-%s: failed to read addr 0x%x\n", DRIVER_NAME, __FUNCTION__,addr);
      return -1;
   }
   kfree(buf);
   return 0;
}

/******************************************************************************
 * @brief
 *   compute a logical Or between CIMaX+ register value and a param value.
 *
 * @param   bus_adap
 *   Pointer to CIMaX+ usb adapter.
 *
 * @param   addr
 *   Addr of CIMaX+ register.
 *
 * @param   val
 *   value to compute.
 *
 * @param   pval
 *   pointer to buffer to store CIMaX+ register value.
 *
 * @return
 *   0 if OK otherwise -1.
 ******************************************************************************/
int setLogicalOr( pdevice_t bus_adap, unsigned int addr, unsigned char val, unsigned char *pval )
{
   *pval |= val;

   if ( usb_setbyte( bus_adap, addr, *pval ) < 0 )
      return -1;

   if ( usb_getbyte( bus_adap, addr, pval ) < 0 )
      return -1;

   dbg("=> Logical OR [%02X] => %02X\n", val, *pval );

   return 0;
}

/******************************************************************************
 * @brief
 *   compute a logical And between CIMaX+ register value and a param value.
 *
 * @param   bus_adap
 *   Pointer to CIMaX+ usb adapter.
 *
 * @param   addr
 *   Addr of CIMaX+ register.
 *
 * @param   val
 *   value to compute.
 *
 * @param   pval
 *   pointer to buffer to store CIMaX+ register value.
 *
 * @return
 *   0 if OK otherwise -1.
 ******************************************************************************/
int setLogicalAnd( pdevice_t bus_adap, unsigned int addr, unsigned char val, unsigned char *pval )
{
   *pval &= val;

   if ( usb_setbyte( bus_adap, addr, *pval ) < 0 )
      return -1;

   if ( usb_getbyte( bus_adap, addr, pval ) < 0 )
      return -1;

   dbg( "=> Logical AND [%02X] => %02X\n", val, *pval );

   return 0;
}

/******************************************************************************
 * @brief
 *   wait CIMaX+ register value match a param value.
 *
 * @param   bus_adap
 *   Pointer to CIMaX+ usb adapter.
 *
 * @param   addr
 *   Addr of CIMaX+ register.
 *
 * @param   val
 *   value to match.
 *
 * @param   pval
 *   pointer to buffer to store CIMaX+ register value.
 *
 * @return
 *   0 if OK otherwise -1.
 ******************************************************************************/
int waitForValue( pdevice_t bus_adap, unsigned int addr, unsigned char val, unsigned char *pval )
{
   dbg( "=> Wait for Value [%02X]\n", val );
   if ( *pval == val )
      return 0;

   while (1)
   {
      if ( usb_getbyte( bus_adap, addr, pval ) < 0 )
         return -1;

      dbg("\r => %02X", *pval );

      if ( *pval == val )
      {
         break;
      }
   }

   dbg( "\n" );

   return 0;
}

/******************************************************************************
 * @brief
 *   wait CIMaX+ register bits match a param value.
 *
 * @param   bus_adap
 *   Pointer to CIMaX+ usb adapter.
 *
 * @param   addr
 *   Addr of CIMaX+ register.
 *
 * @param   val
 *   value to match.
 *
 * @param   pval
 *   pointer to buffer to store CIMaX+ register value.
 *
 * @return
 *   0 if OK otherwise -1.
 ******************************************************************************/
int waitForBitsSet( pdevice_t bus_adap, unsigned int addr, unsigned char val, unsigned char *pval )
{
   dbg( "=> Wait for Bits set [%02X]\n", val );
   if ( (*pval & val) == val )
     return 0;

   while (1)
   {
      if ( usb_getbyte( bus_adap, addr, pval ) < 0 )
         return -1;

      dbg("\r => %02X", *pval );

      if ( (*pval & val) == val )
      {
         break;
      }
   }

   dbg( "\n" );

   return 0;
}

/******************************************************************************
 * @brief
 *   wait CIMaX+ register bits cleared.
 *
 * @param   bus_adap
 *   Pointer to CIMaX+ usb adapter.
 *
 * @param   addr
 *   Addr of CIMaX+ register.
 *
 * @param   val
 *   bits to check.
 *
 * @param   pval
 *   pointer to buffer to store CIMaX+ register value.
 *
 * @return
 *   0 if OK otherwise -1.
 ******************************************************************************/
int waitForBitsCleared( pdevice_t bus_adap, unsigned int addr, unsigned char val, unsigned char *pval )
{
   dbg( "=> Wait for Bits cleared [%02X]\n", val );
   if ( (*pval & val) == 0x00 )
      return 0;

   while (1)
   {
      if ( usb_getbyte( bus_adap, addr, pval ) < 0 )
         return -1;

      dbg("\r => %02X", *pval );

      if ( (*pval & val) == 0x00 )
      {
         break;
      }

   }

   dbg( "\n" );

   return 0;
}

/******************************************************************************
 * @brief
 *   retreive addr of CIMaX+ register.
 *
 * @param   dev
 *   Pointer to CIMaX+ register Name.
 *
 * @return
 *   Address of CIMaX+ register.
 ******************************************************************************/
int cimaxusb_rtr_reg_addr(char *str_addr)
{
   int i32NbItem = sizeof(cimax_reg_map) /sizeof(reg_t); 
   int i32index;
   int i32ValAddr = -1;

   for(i32index=0;i32index<i32NbItem;i32index++) {
      if(strcmp(str_addr,cimax_reg_map[i32index].RegisterName) == 0) {
         i32ValAddr = cimax_reg_map[i32index].RegAddr;
         break;
      }
   }
   return i32ValAddr;
}

/******************************************************************************
 * @brief
 *   parse CIMaX+ config file.
 *
 * @param   dev
 *   Pointer to usb device.
 *
 * @param   fw_data
 *   Pointer to buffer with firmware data.
 *
 * @return
 *   O if no error otherwise errno.
 ******************************************************************************/
int cimaxusb_parse_cfg( pdevice_t bus_adap,  const unsigned char *cfg_data, size_t size) 
{
   int errno = -EFAULT;
   char line[256], *ptr_line;
   char param1[256], param2[256];
   int val;
   unsigned char val2;
   unsigned int  addr;
   size_t len = 0;
   unsigned char *ptr = (unsigned char *)cfg_data;
   unsigned char op;

   dbg("%s: %s size = %d\n", DRIVER_NAME, __FUNCTION__, size);	
   do {
      ptr_line = line;
      switch(*ptr) {
         case ';':
            /* continue up to find \r character */
            while(*ptr != 0x0A) {
               *ptr_line++ = *ptr;	         
               ptr++;
               len++;
            }
            *ptr_line = 0;
            //err("%s: len = %08d line: %s\n", DRIVER_NAME, len, line);
         break;
         case 0x0A:
         case 0x0D:
            ptr++;
            len++;
         break;
         case '=':
         case '?':
         case '!':
         case '|':
         case '&':
            // save current opeation
            op = *ptr;
            // retreive params
            sscanf(ptr,"%s %s",param1,param2);
            ptr++;
            /* Added by l00185424 2012-06-05, fixed parse CFG file bug */
            len++;
            if(sscanf(ptr, "%s %X", param1, &val ) == 2) {
               //err("%s: param1=%s,param2=%s, val=%x\n",DRIVER_NAME,param1,param2,val);
               strcpy(ptr_line,param1);
               len += strlen(param1);
               ptr += strlen(param1);
               strncat(ptr_line,ptr,1);
               len++;
               ptr++;
               strcat(ptr_line,param2);
               len += strlen(param2);
               ptr += strlen(param2);
               //err("%s: len = %08d line: %s\n", DRIVER_NAME, len, line);
               if((addr = cimaxusb_rtr_reg_addr(param1)) < 0) {
                  err("%s: unknown register name: %s\n",
                         DRIVER_NAME, param1);
                  return -ENODEV;
               }
               if(usb_getbyte( bus_adap, addr, &val2 ) < 0) {
                  err("%s: CIMaX+ register reading problem: %s\n",
                         DRIVER_NAME, param1);
                  return -ENODEV;
               }

               switch( op) 
               {
                   case '=':
                       if ( waitForValue( bus_adap, addr, val, &val2 ) == -1 ) {
                           err("%s: waitForValue function failed on register: %s\n",
                                  DRIVER_NAME, param1);
                           return  -ENODEV;
                       }
                       break;
                   case '?':
                       if ( waitForBitsSet( bus_adap, addr, val, &val2 ) == -1 ) {
                           err("%s: waitForBitsSet function failed on register: %s\n",
                                  DRIVER_NAME, param1);
                           return  -ENODEV;
                       }
                       break;
                   case '!':
                       if ( waitForBitsCleared( bus_adap, addr, val, &val2 ) == -1 ) {
                           err("%s: waitForBitsCleared function failed on register: %s\n",
                                  DRIVER_NAME, param1);
                           return  -ENODEV;
                       }
                       break;
                   case '|':
                       if ( setLogicalOr( bus_adap, addr, val, &val2 ) == -1 ) {
                           err("%s: setLogicalOr function failed on register: %s\n",
                                  DRIVER_NAME, param1);
                           return  -ENODEV;
                       }
                       break;
                   case '&':
                       if ( setLogicalAnd( bus_adap, addr, val, &val2 ) == -1 ) {
                           err("%s: setLogicalAnd function failed on register: %s\n",
                                  DRIVER_NAME, param1);
                           return  -ENODEV;
                       }
                       break;
                   default:
                       err("Error: Marker Unknown <%c> !!!\n", op );
                       return -ENODEV;
               }
            }
         break;
         default:
            sscanf(ptr,"%s %s",param1,param2);
            sscanf(param2,"%X",&val);
            //err("%s: param1=%s,param2=%s,val=%x\n",DRIVER_NAME,param1,param2,val);
            strcpy(ptr_line,param1);
            len += strlen(param1);
            ptr += strlen(param1);
            strncat(ptr_line,ptr,1);
            len++;
            ptr++;
            strcat(ptr_line,param2);
            len += strlen(param2);
            ptr += strlen(param2);
            //err("%s: len = %08d line: %s\n", DRIVER_NAME, len, line);
            /* Modified by l00185424 2012-06-05 */
            if((addr = cimaxusb_rtr_reg_addr(param1)) == -1) {
               err("%s: unknown register name: %s\n",
                      DRIVER_NAME, param1);
               return -ENODEV;
            }
            if(usb_getbyte( bus_adap, addr, &val2 ) < 0) {
               err("%s: CIMaX+ register reading problem: %s\n",
                      DRIVER_NAME, param1);
               return -ENODEV;
            }
            if(usb_setbyte( bus_adap, addr, val ) < 0) {
               err("%s: CIMaX+ register writing problem: %s\n",
                      DRIVER_NAME, param1);
               return -ENODEV;
            }
            if(usb_getbyte( bus_adap, addr, &val2 ) < 0) {
               err("%s: CIMaX+ register checking problem: %s\n",
                      DRIVER_NAME, param1);
               return -ENODEV;
            }
          break;
      }
   } while(len < size);

   return ((errno == -EFAULT)? 0 : errno);
}

/******************************************************************************
 * @brief
 *   read configuration file ( CIMAX_CONFIG_NAME) and set in CIMaX+ chip.
 *
 * @param   bus_adap
 *   Pointer to usb device.
 *
 * @return
 *   None.
 ******************************************************************************/
int cimaxusb_configuration_setting(pdevice_t bus_adap)
{
   int errno = -EFAULT;
   const struct firmware *config = NULL;
   char *cfg = cimax_config_file;
   const unsigned char *cfg_data;
   size_t size;

#ifdef __USE_KERNER_CIMAX_FIRMWARE_CFG
   cfg_data = s_cimax_firmware_cfg;
   size = sizeof(s_cimax_firmware_cfg);
#else
   struct usb_device *dev = bus_adap->usbdev;

   dbg("request configuration file");
   /* request kernel to locate firmware file */
   if ((errno = request_firmware(&config, cfg,
             &dev->dev)) < 0) {
      err("%s: unable to locate configuration file: %s\n",
             DRIVER_NAME, cfg);
      goto error;
   }
   cfg_data = config->data;
   size = config->size;
#endif
   dbg("parse configuration file");
   if ((errno = cimaxusb_parse_cfg( bus_adap, cfg_data, size)) < 0) {
      err("%s: unable to parse config file: %s\n",
             DRIVER_NAME, cfg);
      goto error;
   }

error:
   /* release firmware if needed */
   if (config != NULL)
      release_firmware(config);
   return errno;
}


