/**************************************************************************//**
 * @file    cimax+usb_time.h
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

#ifndef __CIMAXPLUS_USB_TIME_H
#define __CIMAXPLUS_USB_TIME_H

/******************************************************************************
 * Include
 ******************************************************************************/
#include <linux/ktime.h>

/******************************************************************************
 * Defines
 ******************************************************************************/
#define MAX_ITEMS     100000
#define MAX_LINE_SIZE    128

/******************************************************************************
 * Enums
 ******************************************************************************/
/******************************************************************************
 * Structures
 ******************************************************************************/
typedef struct
{
   struct timespec stTime;
   char            pcLine[MAX_LINE_SIZE];
} Item;

typedef struct
{
   int  count;
   Item stItem[MAX_ITEMS];
} ItemArray;

extern ItemArray gstArray;

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
void InitTimestamp(void);

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
void SetTimestamp(const char* pcFormat, ...);

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
void ShowTimestamp(void);

#endif
