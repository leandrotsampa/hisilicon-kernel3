/*$$$!!Warning: Huawei key information asset. No spread without permission.$$$*/
/*CODEMARK:EG4uRhTwMmgcVFBsBnYHCDadN5jJKSuVyxmmaCmKFU6eJEbB2fyHF9weu4/jer/hxLHb+S1e
E0zVg4C3NiZh4SXu1DUPt3BK64ZJx2SaroQUPqbpJPz/c/KR2HuFneshZ7x5/nUrYcwVjZST
wdqlOw4LIoUaxjKAAL/YTScI2J0ub3x+uLVQN/2Jk5gTuLCoOlRmmdEgFgatAAL33lHVXxJF
n/gksxrOOY+cTifT3k//p47rpOxRRc+LAteIOtaOXdKw4rBOtQR9UdceiUKvOQ==#*/
/*$$$!!Warning: Deleting or modifying the preceding information is prohibited.$$$*/

/*
 * Optimization of some functions from mpegvideo.c for armv5te
 * Copyright (c) 2007 Siarhei Siamashka <ssvb@users.sourceforge.net>
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

void ff_dct_unquantize_h263_armv5te(DCTELEM *block, int qmul, int qadd, int count);

#ifdef ENABLE_ARM_TESTS
/**
 * h263 dequantizer supplementary function, it is performance critical and needs to
 * have optimized implementations for each architecture. Is also used as a reference
 * implementation in regression tests
 */
static inline void dct_unquantize_h263_helper_c(DCTELEM *block, int qmul, int qadd, int count)
{
    int i, level;

    for (i = 0; i < count; i++)
    {
        level = block[i];

        if (level)
        {
            if (level < 0)
            {
                level = level * qmul - qadd;
            }
            else
            {
                level = level * qmul + qadd;
            }

            block[i] = level;
        }
    }
}
#endif

static void dct_unquantize_h263_intra_armv5te(MpegEncContext *s,
        DCTELEM *block, int n, int qscale)
{
    int level, qmul, qadd;
    int nCoeffs;

    assert(s->block_last_index[n] >= 0);

    qmul = qscale << 1;

    if (!s->h263_aic)
    {
        if (n < 4)
        { level = block[0] * s->y_dc_scale; }
        else
        { level = block[0] * s->c_dc_scale; }

        qadd = (qscale - 1) | 1;
    }
    else
    {
        qadd = 0;
        level = block[0];
    }

    if (s->ac_pred)
    { nCoeffs = 63; }
    else
    { nCoeffs = s->inter_scantable.raster_end[ s->block_last_index[n] ]; }

    ff_dct_unquantize_h263_armv5te(block, qmul, qadd, nCoeffs + 1);
    block[0] = level;
}

static void dct_unquantize_h263_inter_armv5te(MpegEncContext *s,
        DCTELEM *block, int n, int qscale)
{
    int qmul, qadd;
    int nCoeffs;

    assert(s->block_last_index[n] >= 0);

    qadd = (qscale - 1) | 1;
    qmul = qscale << 1;

    nCoeffs = s->inter_scantable.raster_end[ s->block_last_index[n] ];

    ff_dct_unquantize_h263_armv5te(block, qmul, qadd, nCoeffs + 1);
}

void MPV_common_init_armv5te(MpegEncContext *s)
{
    s->dct_unquantize_h263_intra = dct_unquantize_h263_intra_armv5te;
    s->dct_unquantize_h263_inter = dct_unquantize_h263_inter_armv5te;
}
