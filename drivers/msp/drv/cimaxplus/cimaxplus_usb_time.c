/**************************************************************************//**
 * @file    cimax+usb_fw.c
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

//#define TIMESTAMP

/******************************************************************************
 * Include
 ******************************************************************************/
#include <linux/delay.h>

#include "cimaxplus_usb-driver.h"
#include "cimaxplus_usb_time.h"

/******************************************************************************
 * Structures
 ******************************************************************************/


/******************************************************************************
 * Globals
 ******************************************************************************/
#ifdef TIMESTAMP
ItemArray gstArray;
#endif
/******************************************************************************
 * Functions
 ******************************************************************************/
/******************************************************************************
 * @brief
 *   Init timestamp.
 *
 * @param
 *   None
 *
 * @return
 *   None.
 ******************************************************************************/
void InitTimestamp(void)
{
#ifdef TIMESTAMP
   gstArray.count = 0;
#endif
   return;
}

/******************************************************************************
 * @brief
 *   Set timestamp.
 *
 * @param   pcFormat
 *   Printf-like format
 *
 * @return
 *   None.
 ******************************************************************************/
void SetTimestamp(const char* pcFormat, ...)
{
#ifdef TIMESTAMP
   va_list stArgs;

   if (gstArray.count >= MAX_ITEMS)
   {
      if (gstArray.count++ == MAX_ITEMS) ShowTimestamp();
      return;
   }
   ktime_get_ts(&gstArray.stItem[gstArray.count].stTime);
   va_start(stArgs, pcFormat);
   vsprintf(gstArray.stItem[gstArray.count++].pcLine, pcFormat, stArgs);
   va_end(stArgs);
#endif
   return;
}

/******************************************************************************
 * @brief
 *   Display all timestamps.
 *
 * @param
 *   None
 *
 * @return
 *   None.
 ******************************************************************************/
void ShowTimestamp(void)
{
#ifdef TIMESTAMP
   int i;

   if (gstArray.count == 0)
   {
      err("No timestamps available");
      return;
   }

   info("===============================================================");
   info("                         TIMESTAMPS");
   info("===============================================================");

   for (i = 0; i < gstArray.count; i++)
   {
      info("[%04d] [%03d.%09d] %s", i, gstArray.stItem[i].stTime.tv_sec,
           gstArray.stItem[i].stTime.tv_nsec,
           gstArray.stItem[i].pcLine);
      if ((i % 100) == 0)
      {
         msleep(5);
      }
   }
   info("===============================================================");
   gstArray.count = 0;

#endif
   return;
}
