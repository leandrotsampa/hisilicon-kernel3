/*$$$!!Warning: Huawei key information asset. No spread without permission.$$$*/
/*CODEMARK:EG4uRhTwMmgcVFBsBnYHCDadN5jJKSuVyxmmaCmKFU6eJEbB2fyHF9weu4/jer/hxLHb+S1e
E0zVg4C3NiZh4SXu1DUPt3BK64ZJx2SaroQUPqbpJPz/c/KR2HuFneshZ7x5/nUrYcwVjZST
wdqlOzAsAhjj2Jn8W1K+1eyyREW/HQ7M+I3V3jxaLKvhaA+WPwABA/r9TihDOauP294OmNR8
7LqG8+OJyOFQ1G4HBqedVsQNvGzQIwbPWY943/hVTVJ2ABu7DORnU24SZt9XeQ==#*/
/*$$$!!Warning: Deleting or modifying the preceding information is prohibited.$$$*/

/*
 * Copyright (c) 2008 Siarhei Siamashka <ssvb@users.sourceforge.net>
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

#include "dsputil.h"

void ff_vector_fmul_vfp(float *dst, const float *src, const float *src1, int len);
void ff_vector_fmul_reverse_vfp(float *dst, const float *src0,
                                const float *src1, int len);
void ff_float_to_int16_vfp(int16_t *dst, const float *src, long len);
#ifdef ARMV8
void ff_vector_fmul_neon(float *dst, const float *src0, const float *src1,
                         int len);
void ff_vector_fmul_reverse_neon(float *dst, const float *src0,
                                 const float *src1, int len);
#endif

void ff_float_init_arm_vfp(DSPContext *c, AVCodecContext *avctx)
{
#ifdef ARMV8
    c->vector_fmul = ff_vector_fmul_neon;
    c->vector_fmul_reverse = ff_vector_fmul_reverse_neon;
#else
    c->vector_fmul = ff_vector_fmul_vfp;
    c->vector_fmul_reverse = ff_vector_fmul_reverse_vfp;
#endif
}
