#ifndef __DRV_HDMIRX_ISR_INTERNAL_H__
#define __DRV_HDMIRX_ISR_INTERNAL_H__

#include "hal_hdmirx_reg.h"
#include "drv_hdmirx.h"
#include "hal_hdmirx.h"
#include "drv_hdmirx_info.h"
#include "drv_hdmirx_audio.h"
#include "drv_hdmirx_video.h"
#include "drv_hdmirx_sys.h"

#define	INTR3_SERVING_PACKETS_MASK      (intr_new_mpeg | intr_new_aud | intr_new_spd | intr_new_avi)
#define HDCP_FAIL_THRESHOLD_1ST         4
#define HDCP_FAIL_THRESHOLD_CONTINUED   100


extern struct hdmistatus hdmi_ctx;

#endif