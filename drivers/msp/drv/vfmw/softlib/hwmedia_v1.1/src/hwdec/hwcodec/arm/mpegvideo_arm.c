/*$$$!!Warning: Huawei key information asset. No spread without permission.$$$*/
/*CODEMARK:EG4uRhTwMmgcVFBsBnYHCDadN5jJKSuVyxmmaCmKFU6eJEbB2fyHF9weu4/jer/hxLHb+S1e
E0zVg4C3NiZh4SXu1DUPt3BK64ZJx2SaroQUPqbpJPz/c/KR2HuFneshZ7x5/nUrYcwVjZST
wdqlO0ZY1gu3O9oQzG80oVdAgeZ1kZUb2n4rF3LwQr6+mUdWesu698syUjwiYmWSIkdOSp2w
3hq+LUy8WOxlrSkTpOWtH/49z2WXarT+mlRSitKPtktiNwT0oaMfqC6d4E5Neg==#*/
/*$$$!!Warning: Deleting or modifying the preceding information is prohibited.$$$*/

/*
 * Copyright (c) 2002 Michael Niedermayer
 *
 * This file is part of FFmpeg.
 *
 * FFmpeg is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * FFmpeg is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with FFmpeg; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

#include "avcodec.h"
#include "dsputil.h"
#include "mpegvideo.h"

void MPV_common_init_iwmmxt(MpegEncContext *s);
void MPV_common_init_armv5te(MpegEncContext *s);

void MPV_common_init_arm(MpegEncContext *s)
{
    /* IWMMXT support is a superset of armv5te, so
     * allow optimized functions for armv5te unless
     * a better iwmmxt function exists
     */
#if HAVE_ARMV5TE
    MPV_common_init_armv5te(s);
#endif
#if HAVE_IWMMXT
    MPV_common_init_iwmmxt(s);
#endif
}
