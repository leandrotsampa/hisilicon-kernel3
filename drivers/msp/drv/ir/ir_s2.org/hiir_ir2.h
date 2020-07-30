/******************************************************************************

  Copyright (C), 2001-2011, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
File Name     : ir_keyboad.h
Version       : Initial Draft
Author        : Hisilicon multimedia software group
Created       : 2010/11/15
Description   : ir_keyboad.c header file
History       :
1.Date        : 2010/11/15
Author      : f00104257
Modification: Created file
******************************************************************************/

#include <linux/init.h>
#include <linux/input.h>
#include <linux/types.h>
#include <linux/kernel.h>
#include <linux/platform_device.h>
#include <linux/workqueue.h>
#include <linux/sched.h>
#include <linux/version.h>
#include <linux/proc_fs.h>
#include <linux/ioport.h>
#include <linux/string.h>
#include <linux/ioctl.h>
#include <linux/fs.h>
#include <linux/delay.h>
#include <linux/sched.h>
#include <linux/vmalloc.h>
#include <linux/seq_file.h>
#include <linux/ptrace.h>
#include <linux/timer.h>
#include <linux/log2.h>
#include <linux/mii.h>
#include <linux/syscalls.h>
#include <linux/slab.h>
//#include <asm/system.h>
//#include <asm/byteorder.h>
//#include <asm/uaccess.h>
//#include <asm/irq.h>
//#include <asm/io.h>
//#include <asm/memory.h>
//#include <mach/hardware.h>


/* key value define*/
#define IR_KEY_UP               0x35caff00
#define IR_KEY_DOWN             0x2dd2ff00
#define IR_KEY_LEFT            0x6699ff00
#define IR_KEY_RIGHT             0x3ec1ff00
#define IR_KEY_OK               0x31ceff00
#define IR_KEY_BACK             0x6f90ff00
#define IR_KEY_MENU             0x629dff00
#define IR_KEY_POWER            0x639cff00
#define IR_KEY_HOME             0x34cbff00
#define IR_KEY_VOLADD           0x7f80ff00
#define IR_KEY_VOLSUB           0x7e81ff00
#define IR_KEY_MUTE             0x22ddff00
#define IR_KEY_1                0x6d92ff00
#define IR_KEY_2                0x6c93ff00
#define IR_KEY_3                0x33ccff00
#define IR_KEY_4                0x718eff00
#define IR_KEY_5                0x708fff00
#define IR_KEY_6                0x37c8ff00
#define IR_KEY_7                0x758aff00
#define IR_KEY_8                0x748bff00
#define IR_KEY_9                0x3bc4ff00
#define IR_KEY_0                0x7887ff00
#define IR_KEY_F1               0x7b84ff00
#define IR_KEY_F2               0x7689ff00
#define IR_KEY_F3               0x26d9ff00
#define IR_KEY_F4               0x6996ff00
#define IR_KEY_SEARCH           0x6897ff00
#define IR_KEY_REWIND           0x25daff00
#define IR_KEY_FORWARD          0x29d6ff00
#define IR_KEY_STOP             0x2fd0ff00
#define IR_KEY_SETUP            0x6a95ff00
#define IR_KEY_INFO             0x38c7ff00
#define IR_KEY_AUDIO            0x2ed1ff00
#define IR_KEY_SUBTITLE         0x738cff00
#define IR_KEY_BACKSPACE        0x7788ff00
#define IR_KEY_PLAYPAUSE        0x3cc3ff00
#define IR_KEY_FAVORITES        0x6b94ff00
#define IR_KEY_CHANNELUP        0x7a85ff00
#define IR_KEY_CHANNELDOWN      0x7986ff00
#define IR_KEY_PAGEDOWN         0x6798ff00
#define IR_KEY_PAGEUP           0x30cfff00
#define IR_KEY_IME              0x609fff00
#define IR_KEY_MORE             0x39c6ff00
#define IR_KEY_BTV              0x649bff00
#define IR_KEY_VOD              0x659aff00
#define IR_KEY_NVOD             0x3fc0ff00
#define IR_KEY_NPVR             0x3dc2ff00
#define IR_KEY_SEEK             0x7d82ff00

#define PN_KEY_UP               0x639cf300
#define PN_KEY_DOWN             0x6798f300
#define PN_KEY_RIGHT            0x6b94f300
#define PN_KEY_LEFT             0x6f90f300
#define PN_KEY_OK               0x738cf300
#define PN_KEY_BACK             0x7788f300
#define PN_KEY_MENU             0x7b84f300

#define ML_IR_KEY_UP            0xbc439f00
#define ML_IR_KEY_DOWN          0xf50a9f00
#define ML_IR_KEY_LEFT          0xf9069f00
#define ML_IR_KEY_RIGHT         0xf10e9f00
#define ML_IR_KEY_OK            0xfd029f00
#define ML_IR_KEY_BACK          0xb04f9f00
#define ML_IR_KEY_MENU          0xe9169f00
#define ML_IR_KEY_POWER         0xa8579f00
#define ML_IR_KEY_HOME          0xb8479f00
#define ML_IR_KEY_VOLADD        0xff009f00
#define ML_IR_KEY_VOLSUB        0xa25d9f00
#define ML_IR_KEY_MUTE          0xa35c9f00
#define ML_IR_KEY_1             0xe51a9f00
#define ML_IR_KEY_2             0xfe019f00
#define ML_IR_KEY_3             0xba459f00
#define ML_IR_KEY_4             0xa6599f00
#define ML_IR_KEY_5             0xb24d9f00
#define ML_IR_KEY_6             0xbf409f00
#define ML_IR_KEY_7             0xad529f00
#define ML_IR_KEY_8             0xac539f00
#define ML_IR_KEY_9             0xbe419f00
#define ML_IR_KEY_0             0xa55a9f00
#define ML_IR_KEY_F1            0xaa559f00
#define ML_IR_KEY_F2            0xb14e9f00
#define ML_IR_KEY_F3            0xb6499f00
#define ML_IR_KEY_F4            0xb7489f00
#define ML_IR_KEY_SEARCH        0xf20d9f00
#define ML_IR_KEY_REWIND        0xf8079f00
#define ML_IR_KEY_FORWARD       0xfc039f00
#define ML_IR_KEY_STOP          0xec139f00
#define ML_IR_KEY_SETUP         0xf6099f00
#define ML_IR_KEY_INFO          0xef109f00
#define ML_IR_KEY_AUDIO         0xbb449f00
#define ML_IR_KEY_SUBTITLE      0xb9469f00
#define ML_IR_KEY_PLAYPAUSE     0xaf509f00
#define ML_IR_KEY_FAVORITES     0xea159f00
#define ML_IR_KEY_PAGEDOWN      0xf40b9f00
#define ML_IR_KEY_PAGEUP        0xf00f9f00
#define ML_IR_KEY_TVSYS         0xfb049f00
#define ML_IR_KEY_REPEAT        0xf7089f00
#define ML_IR_KEY_FOCUS         0xee119f00
#define ML_IR_KEY_HELP          0xfa059f00
#define ML_IR_KEY_EJECT         0xeb149f00

#define ML_IR_KEY_MOVIE			0xab549f00
#define ML_IR_KEY_MYAPP			0xa45b9f00
#define ML_IR_KEY_BROWSER		0xe8179f00
#define ML_IR_KEY_ZOOMIN        0xa7589f00
#define ML_IR_KEY_ZOOMOUT       0xf30c9f00

/* by limst, added key codes for seowoo RCU */
#define SW_IR_KEY_RECORD        0xb54afe01  // Remocon Key REC
#define SW_IR_KEY_POWER         0xff00fe01  // Remocon Key Power
#define SW_IR_KEY_FILE_EXPLORER 0xe31cfe01  // Remocon Key USB
#define SW_IR_KEY_PVR_LIST      0x0ef1fe01  // Remocon Key PVR
#define SW_IR_KEY_BROWER        0x0df2fe01  // Remocon Key BROWER
#define SW_IR_KEY_GOOGLE_PLAY   0x0cf3fe01  // Remocon Key GOOGLE
#define SW_IR_KEY_INSTALL_APP   0x0bf4fe01  // Remocon Key INSTALL App
#define SW_IR_KEY_REWIND        0xb34cfe01  // Remocon Key RW (<<)
#define SW_IR_KEY_PLAYPAUSE     0xb44bfe01  // Remocon Key Play/Pause (>||)
#define SW_IR_KEY_STOP          0xb649fe01  // Remocon Key STOP
#define SW_IR_KEY_FORWARD       0xb24dfe01  // Remocon Key FW (>>)
#define SW_IR_KEY_PAGEDOWN      0xb14efe01  // Remocon Key PAGEDOWN
#define SW_IR_KEY_PAGEUP        0xb04ffe01  // Remocon Key PAGEUP
#define SW_IR_KEY_UP            0xea15fe01  // Remocon Key UP
#define SW_IR_KEY_DOWN          0xe916fe01  // Remocon Key DOWN
#define SW_IR_KEY_LEFT          0xeb14fe01  // Remocon Key RIGHT
#define SW_IR_KEY_RIGHT         0xe817fe01  // Remocon Key LEFT
#define SW_IR_KEY_OK            0xed12fe01  // Remocon Key OK
#define SW_IR_KEY_BACK          0xee11fe01  // Remocon Key BACK(EXIT)
#define SW_IR_KEY_INFO          0xe619fe01  // Remocon Key INFO
#define SW_IR_KEY_RED           0xb847fe01  // Remocon Key RED
#define SW_IR_KEY_GREEN         0xbe41fe01  // Remocon Key GREEN
#define SW_IR_KEY_YELLOW        0xbd42fe01  // Remocon Key YELLOW
#define SW_IR_KEY_BLUE          0xe21dfe01  // Remocon Key BLUE
#define SW_IR_KEY_VOLADD        0xaf50fe01  // Remocon Key VOL +
#define SW_IR_KEY_VOLSUB        0xae51fe01  // Remocon Key VOL -
#define SW_IR_KEY_CHANNELUP     0xad52fe01  // Remocon Key CH +
#define SW_IR_KEY_CHANNELDOWN   0xac53fe01  // Remocon Key CH -
#define SW_IR_KEY_HOME          0xba45fe01  // Remocon Key HOME
#define SW_IR_KEY_MUTE          0xfc03fe01  // Remocon Key MUTE
#define SW_IR_KEY_1             0xfe01fe01  // Remocon Key NUM 1
#define SW_IR_KEY_2             0xfd02fe01  // Remocon Key NUM 2
#define SW_IR_KEY_3             0xf906fe01  // Remocon Key NUM 3
#define SW_IR_KEY_4             0xfb04fe01  // Remocon Key NUM 4
#define SW_IR_KEY_5             0xfa05fe01  // Remocon Key NUM 5
#define SW_IR_KEY_6             0xf807fe01  // Remocon Key NUM 6
#define SW_IR_KEY_7             0xf708fe01  // Remocon Key NUM 7
#define SW_IR_KEY_8             0xf50afe01  // Remocon Key NUM 8
#define SW_IR_KEY_9             0xf40bfe01  // Remocon Key NUM 9
#define SW_IR_KEY_0             0xf10efe01  // Remocon Key NUM 10
#define SW_IR_KEY_EPG           0xe718fe01  // Remocon Key EPG
#define SW_IR_KEY_MENU          0xef10fe01  // Remocon Key MENU

#define SW_IR_KEY_F1            0x0ef1fe01
#define SW_IR_KEY_F2            0x0df2fe01
#define SW_IR_KEY_F3            0x0cf3fe01
#define SW_IR_KEY_F4            0x0bf4fe01
#if 0
#define SW_IR_KEY_SETUP         0x6a95fe01
#endif
#if 0
#define SW_IR_KEY_SUBTITLE      0x738cfe01
#endif
#define SW_IR_KEY_BACKSPACE     0xf30cfe01
#define SW_IR_KEY_FAVORITES     0xbb44fe01
#if 0
#define SW_IR_KEY_IME           0x609ffe01
#define SW_IR_KEY_MORE          0x39c6fe01
#define SW_IR_KEY_BTV           0x649bfe01
#define SW_IR_KEY_VOD           0x659afe01
#define SW_IR_KEY_NVOD          0x3fc0fe01
#define SW_IR_KEY_NPVR          0x3dc2fe01
#define SW_IR_KEY_SEEK          0x7d82fe01
#endif

/* by moya0426, added key codes for XBMC RCU */
#define SMT_IR_KEY_POWER         0xf40bff00  // Remocon Key POWER
#define SMT_IR_KEY_INFO          0xe41bff00  // Remocon Key INFO
#define SMT_IR_KEY_MUTE          0xf50aff00  // Remocon Key MUTE

#define SMT_IR_KEY_1             0xfe01ff00  // Remocon Key NUM 1
#define SMT_IR_KEY_2             0xfd02ff00  // Remocon Key NUM 2
#define SMT_IR_KEY_3             0xfc03ff00  // Remocon Key NUM 3
#define SMT_IR_KEY_EPG		 0xe718ff00  // Remocon Key EPG

#define SMT_IR_KEY_4             0xfb04ff00  // Remocon Key NUM 4
#define SMT_IR_KEY_5             0xfa05ff00  // Remocon Key NUM 5
#define SMT_IR_KEY_6             0xf906ff00  // Remocon Key NUM 6
#define SMT_IR_KEY_FILE_EXPLORER 0xed12ff00  // Remocon Key SETTING

#define SMT_IR_KEY_7             0xf807ff00  // Remocon Key NUM 7
#define SMT_IR_KEY_8             0xf708ff00  // Remocon Key NUM 8
#define SMT_IR_KEY_9             0xf609ff00  // Remocon Key NUM 9
#define SMT_IR_KEY_INSTALL_APP   0xe31cff00  // Remocon Key INSTALL App

#define SMT_IR_KEY_MOUSE         0xbf40ff00  // Remocon Key Enter
#define SMT_IR_KEY_0             0xff00ff00  // Remocon Key NUM 0
#define SMT_IR_KEY_HOME          0xe916ff00  // Remocon Key DEL
#define SMT_IR_KEY_PVR_LIST      0xab54ff00  // Remocon Key PVR

#define SMT_IR_KEY_GOTO          0xea15ff00 //  // Remocon Key LIVETV
#define SMT_IR_KEY_MOVIE         0xe51aff00  // Remocon Key MOVIE
#define SMT_IR_KEY_AUDIO         0xec13ff00  // Remocon Key AUDIO
#define SMT_IR_KEY_PHOTO         0xeb14ff00  // Remocon Key PHOTO

#define SMT_IR_KEY_MENU          0xef10ff00  // Remocon Key MENU
#define SMT_IR_KEY_BACK          0xbe41ff00  // Remocon Key BACK(EXIT)

#define SMT_IR_KEY_UP            0xba45ff00  // Remocon Key UP
#define SMT_IR_KEY_DOWN          0xb649ff00  // Remocon Key DOWN
#define SMT_IR_KEY_LEFT          0xb946ff00  // Remocon Key LEFT
#define SMT_IR_KEY_RIGHT         0xf20dff00  // Remocon Key RIGHT
#define SMT_IR_KEY_OK            0xe11eff00  // Remocon Key OK

#define SMT_IR_KEY_VOLADD        0xae51ff00  // Remocon Key VOL +
#define SMT_IR_KEY_VOLSUB        0xb847ff00  // Remocon Key VOL -
#define SMT_IR_KEY_CHANNELUP     0xe21dff00  // Remocon Key CH +
#define SMT_IR_KEY_CHANNELDOWN   0xbc43ff00  // Remocon Key CH -
#define SMT_IR_KEY_MEDIA         0xa25dff00  // Remocon Key Home

#define SMT_IR_KEY_SAT           0xb14eff00  // Remocon Key INFO
#define SMT_IR_KEY_RECALL        0xf00fff00  // Remocon Key RECALL
#define SMT_IR_KEY_TV_RADIO      0xe619ff00  // Remocon Key TV/R
#define SMT_IR_KEY_BROWER        0xbd42ff00  // Remocon Key AUDIO

#define SMT_IR_KEY_TXT           0xb54aff00  // Remocon Key TXT
#define SMT_IR_KEY_GOOGLE_PLAY   0xb24dff00  // Remocon Key SUB
#define SMT_IR_KEY_FORMAT        0xaf50ff00  // Remocon Key FORMAT
#define SMT_IR_KEY_RATIO         0xbb44ff00  // Remocon Key Ratio

#define SMT_IR_KEY_RED           0xad52ff00  // Remocon Key RED
#define SMT_IR_KEY_GREEN         0xa55aff00  // Remocon Key GREEN
#define SMT_IR_KEY_YELLOW        0xa956ff00  // Remocon Key YELLOW
#define SMT_IR_KEY_BLUE          0xa15eff00  // Remocon Key BLUE

#define SMT_IR_KEY_STOP          0xa05fff00  // Remocon Key STOP
#define SMT_IR_KEY_RECORD        0xb44bff00  // Remocon Key REC
#define SMT_IR_KEY_REWIND        0xb34cff00  // Remocon Key RW (<<)
#define SMT_IR_KEY_FORWARD       0xa857ff00  // Remocon Key FW (>>)

#define SMT_IR_KEY_PLAYPAUSE     0xac53ff00  // Remocon Key Play
#define SMT_IR_KEY_REPEAT        0xa659ff00 //0xea15ff00  // Remocon Key Pause
#define SMT_IR_KEY_PAGEDOWN      0xa758ff00  // Remocon Key PAGEDOWN
#define SMT_IR_KEY_PAGEUP        0xaa55ff00  // Remocon Key PAGEUP
#define SMT_IR_KEY_FAV        	 0xe01fff00  // Remocon Key FAV add by choi 20140703
#define SMT_IR_KEY_WWW           0xe817ff00  // Remocon Key WWW add by choi 20140703

/*by sifon add hdbox RCU enigma2 */

#define HDB_IR_KEY_POWER            0xf50af902
#define HDB_IR_KEY_MUTE             0xf30cf902

#define HDB_IR_KEY_VFORMAT          0xf10ef902
#define HDB_IR_KEY_SLEEP            0xe11ef902
#define HDB_IR_KEY_TVRADIO          0xe51af902
#define HDB_IR_KEY_RESOLUTION       0xf00ff902

#define HDB_IR_KEY_REWIND           0xa758f902
#define HDB_IR_KEY_FORWARD          0xa35cf902
#define HDB_IR_KEY_PLAYPAUSE        0xaa55f902
#define HDB_IR_KEY_PREVIOUS         0xaf50f902
#define HDB_IR_KEY_NEXT             0xb34cf902
#define HDB_IR_KEY_RECORD           0xa956f902
#define HDB_IR_KEY_PAUSE            0xf807f902
#define HDB_IR_KEY_STOP             0xab54f902
#define HDB_IR_KEY_CHECK            0xbd42f902

#define HDB_IR_KEY_RED              0xb44bf902
#define HDB_IR_KEY_GREEN            0xb54af902
#define HDB_IR_KEY_YELLOW           0xb649f902
#define HDB_IR_KEY_BLUE             0xb748f902

#define HDB_IR_KEY_INFO             0xf906f902
#define HDB_IR_KEY_RECALL           0xf609f902

#define HDB_IR_KEY_UP               0xff00f902
#define HDB_IR_KEY_DOWN             0xfe01f902
#define HDB_IR_KEY_LEFT             0xfc03f902
#define HDB_IR_KEY_RIGHT            0xfd02f902
#define HDB_IR_KEY_OK               0xe01ff902

#define HDB_IR_KEY_MENU             0xfb04f902
#define HDB_IR_KEY_EXIT             0xe31cf902

#define HDB_IR_KEY_PAGEDOWN         0xbc43f902
#define HDB_IR_KEY_FAVORITES        0xbe41f902
#define HDB_IR_KEY_PAGEUP           0xbb44f902

#define HDB_IR_KEY_VOLUMEUP         0xb14ef902
#define HDB_IR_KEY_VOLUMEDOWN       0xb04ff902
#define HDB_IR_KEY_EPG              0xf708f902
#define HDB_IR_KEY_CHANNELUP        0xa15ef902
#define HDB_IR_KEY_CHANNELDOWN      0xa05ff902
#define HDB_IR_KEY_OPEN		    0xbf40f902

#define HDB_IR_KEY_PIP              0xae51f902
#define HDB_IR_KEY_PIPMOVE          0xad52f902
#define HDB_IR_KEY_PIPSIZE          0xac53f902

#define HDB_IR_KEY_1                0xee11f902
#define HDB_IR_KEY_2                0xed12f902
#define HDB_IR_KEY_3                0xec13f902
#define HDB_IR_KEY_4                0xeb14f902
#define HDB_IR_KEY_5                0xea15f902
#define HDB_IR_KEY_6                0xe916f902
#define HDB_IR_KEY_7                0xe817f902
#define HDB_IR_KEY_8                0xe718f902
#define HDB_IR_KEY_9                0xe619f902
#define HDB_IR_KEY_0                0xef10f902

#define HDB_IR_KEY_SUBTITLE         0xf40bf902
#define HDB_IR_KEY_TEXT             0xf20df902

/*by leandrotsampa add Atto RCU enigma2 */
#define ATTO_IR_KEY_UP          0xde21377d
#define ATTO_IR_KEY_DOWN        0xda25377d
#define ATTO_IR_KEY_RIGHT       0xdb24377d
#define ATTO_IR_KEY_LEFT        0xdd22377d
#define ATTO_IR_KEY_ENTER       0xdc23377d
#define ATTO_IR_KEY_BACK        0x57a8377d
#define ATTO_IR_KEY_MENU        0x59a6377d
#define ATTO_IR_KEY_POWER       0x5fa0377d
#define ATTO_IR_KEY_HOME        0x2fd0377d
#define ATTO_IR_KEY_VOLUMEUP    0x3bc4377d
#define ATTO_IR_KEY_VOLUMEDOWN  0x3ac5377d
#define ATTO_IR_KEY_MUTE        0xce31377d
#define ATTO_IR_KEY_1           0xfe01377d
#define ATTO_IR_KEY_2           0xfd02377d
#define ATTO_IR_KEY_3           0xfc03377d
#define ATTO_IR_KEY_4           0xfb04377d
#define ATTO_IR_KEY_5           0xfa05377d
#define ATTO_IR_KEY_6           0xf906377d
#define ATTO_IR_KEY_7           0xf807377d
#define ATTO_IR_KEY_8           0xf708377d
#define ATTO_IR_KEY_9           0xf609377d
#define ATTO_IR_KEY_0           0xff00377d
#define ATTO_IR_KEY_F1          0x3fc0377d
#define ATTO_IR_KEY_F2          0x3ec1377d
#define ATTO_IR_KEY_F3          0x3dc2377d
#define ATTO_IR_KEY_F4          0x3cc3377d
#define ATTO_IR_KEY_SEARCH      0x4eb1377d
#define ATTO_IR_KEY_REWIND      0xac53377d
#define ATTO_IR_KEY_FORWARD     0xab54377d
#define ATTO_IR_KEY_STOP        0xa857377d
#define ATTO_IR_KEY_SETUP       0x6a95ff00
#define ATTO_IR_KEY_INFO        0x5ea1377d
#define ATTO_IR_KEY_AUDIO       0x5da2377d
#define ATTO_IR_KEY_SUBTITLE    0x47b8377d
#define ATTO_IR_KEY_BACKSPACE   0x56a9377d
#define ATTO_IR_KEY_PLAY        0xad52377d
#define ATTO_IR_KEY_PAUSE       0xa758377d
#define ATTO_IR_KEY_FAVORITES   0x53ac377d
#define ATTO_IR_KEY_CHANNELUP   0x9e61377d 
#define ATTO_IR_KEY_CHANNELDOWN 0x9d62377d 
#define ATTO_IR_KEY_PAGEDOWN    0x7986ff00
#define ATTO_IR_KEY_PAGEUP      0x7a85ff00
#define ATTO_IR_KEY_FN_1        0x609fff00
#define ATTO_IR_KEY_FN_2        0x39c6ff00
#define ATTO_IR_KEY_FN_D        0x649bff00
#define ATTO_IR_KEY_FN_E        0x659aff00
#define ATTO_IR_KEY_FN_F        0x3fc0ff00
#define ATTO_IR_KEY_FN_B        0x7d82ff00
#define ATTO_IR_KEY_RECALL      0x9a65ff00
#define ATTO_IR_KEY_RECORD      0xae51377d
#define ATTO_IR_KEY_SAT         0x55aa377d
#define ATTO_IR_KEY_TV          0x2ed1377d
#define ATTO_IR_KEY_EPG         0x58a7377d
#define ATTO_IR_KEY_TIME        0x5ca3377d
#define ATTO_IR_KEY_TEXT        0x48b7377d
#define ATTO_IR_KEY_RADIO       0xf20d377d
#define ATTO_IR_KEY_MOUSE       0x2dd2377d


/* input event */
typedef struct
{
	HI_U64 SrcKeyId;
	HI_U32 linux_key_code;

}IR_KEYMAP_S;

const IR_KEYMAP_S Key_Code[] =
{
	{IR_KEY_UP,            KEY_UP           },   //0x35caff00
	{IR_KEY_DOWN,          KEY_DOWN         },   //0x2dd2ff00
	{IR_KEY_RIGHT,         KEY_RIGHT         },   //0x6699ff00
	{IR_KEY_LEFT,          KEY_LEFT        },   //0x3ec1ff00
	{IR_KEY_OK,            KEY_ENTER        },   //0x31ceff00
	{IR_KEY_BACK,          KEY_BACK         },   //0x6f90ff00
	{IR_KEY_MENU,          KEY_MENU         },   //0x629dff00
	{IR_KEY_POWER,         KEY_POWER        },   //0x639cff00
	{IR_KEY_HOME,          KEY_HOME         },   //0x34cbff00
	{IR_KEY_VOLADD,        KEY_VOLUMEUP     },   //0x7f80ff00
	{IR_KEY_VOLSUB,        KEY_VOLUMEDOWN   },   //0x7e81ff00
	{IR_KEY_MUTE,          KEY_MUTE         },   //0x22ddff00
	{IR_KEY_1,             KEY_1			},	 //0x6d92ff00
	{IR_KEY_2,             KEY_2			},	 //0x6c93ff00
	{IR_KEY_3,             KEY_3			},	 //0x33ccff00
	{IR_KEY_4,             KEY_4			},	 //0x718eff00
	{IR_KEY_5,             KEY_5			},	 //0x708fff00
	{IR_KEY_6,             KEY_6			},	 //0x37c8ff00
	{IR_KEY_7,             KEY_7			},	 //0x758aff00
	{IR_KEY_8,             KEY_8			},	 //0x748bff00
	{IR_KEY_9,             KEY_9			},	 //0x3bc4ff00
	{IR_KEY_0,             KEY_0			},	 //0x7887ff00
	{IR_KEY_F1,            KEY_F1			},	 //0x7b84ff00
	{IR_KEY_F2,            KEY_F2			},	 //0x7689ff00
	{IR_KEY_F3,            KEY_F3			},	 //0x26d9ff00
	{IR_KEY_F4,            KEY_F4			},	 //0x6996ff00
	{IR_KEY_SEARCH,        KEY_SEARCH       },   //0x6897ff00
	{IR_KEY_REWIND,        KEY_REWIND       },   //0x25daff00
	{IR_KEY_FORWARD,       KEY_FORWARD      },   //0x29d6ff00
	{IR_KEY_STOP,          KEY_STOP         },   //0x2fd0ff00
	{IR_KEY_SETUP,         KEY_SETUP        },   //0x6a95ff00
	{IR_KEY_INFO,          KEY_INFO         },   //0x38c7ff00
	{IR_KEY_AUDIO,         KEY_AUDIO        },   //0x2ed1ff00
	{IR_KEY_SUBTITLE,      KEY_SUBTITLE     },   //0x738cff00
	{IR_KEY_BACKSPACE,     KEY_BACKSPACE	},	 //0x7788ff00
	{IR_KEY_PLAYPAUSE,     KEY_PLAYPAUSE	},	 //0x3cc3ff00
	{IR_KEY_FAVORITES,     KEY_FAVORITES	},	 //0x6b94ff00
	{IR_KEY_CHANNELUP,     KEY_CHANNELUP	},	 //0x7a85ff00
	{IR_KEY_CHANNELDOWN,   KEY_CHANNELDOWN  },   //0x7986ff00
	{IR_KEY_PAGEDOWN,      KEY_PAGEDOWN     },   //0x6798ff00
	{IR_KEY_PAGEUP,        KEY_PAGEUP       },   //0x30cfff00
	{IR_KEY_IME,           KEY_FN_1         },   //0x609fff00
	{IR_KEY_MORE,          KEY_FN_2         },   //0x39c6ff00
	{IR_KEY_BTV,           KEY_FN_D			},	 //0x649bff00
	{IR_KEY_VOD,           KEY_FN_E			},	 //0x659aff00
	{IR_KEY_NVOD,          KEY_FN_F			},	 //0x3fc0ff00
	{IR_KEY_NPVR,          KEY_FN_S			},	 //0x3dc2ff00
	{IR_KEY_SEEK,          KEY_FN_B			},	 //0x7d82ff00

	{PN_KEY_UP,            KEY_UP           },   //0x639cf300
	{PN_KEY_DOWN,          KEY_DOWN         },   //0x6798f300
	{PN_KEY_RIGHT,         KEY_LEFT         },   //0x6f90f300
	{PN_KEY_LEFT,          KEY_RIGHT        },   //0x6b94f300
	{PN_KEY_OK,            KEY_ENTER        },   //0x738cf300
	{PN_KEY_BACK,          KEY_BACK			},	 //0x7788f300
	{PN_KEY_MENU,          KEY_MENU			},	 //0x7b84f300

	{ML_IR_KEY_UP,         KEY_UP           },   //0xbc439f00
	{ML_IR_KEY_DOWN,       KEY_DOWN         },   //0xf50a9f00
	{ML_IR_KEY_RIGHT,      KEY_RIGHT        },
	{ML_IR_KEY_LEFT,       KEY_LEFT         },
	{ML_IR_KEY_OK,         KEY_ENTER        },   //0xfd029f00
	{ML_IR_KEY_BACK,       KEY_BACK         },   //0xb04f9f00
	{ML_IR_KEY_MENU,       KEY_MENU         },   //0xe9169f00
	{ML_IR_KEY_POWER,      KEY_POWER        },   //0xa8579f00
	{ML_IR_KEY_HOME,       KEY_HOME         },   //0xb8479f00
	{ML_IR_KEY_VOLADD,     KEY_VOLUMEUP     },   //0xe8179f00
	{ML_IR_KEY_VOLSUB,     KEY_VOLUMEDOWN   },   //0xab549f00
	{ML_IR_KEY_MUTE,       KEY_MUTE         },   //0xa45b9f00
	{ML_IR_KEY_1,          KEY_1			},	 //0xfa059f00
	{ML_IR_KEY_2,          KEY_2			},	 //0xf6099f00
	{ML_IR_KEY_3,          KEY_3			},	 //0xea159f00
	{ML_IR_KEY_4,          KEY_4			},	 //0xfb049f00
	{ML_IR_KEY_5,          KEY_5			},	 //0xf7089f00
	{ML_IR_KEY_6,          KEY_6			},	 //0xeb149f00
	{ML_IR_KEY_7,          KEY_7			},	 //0xff009f00
	{ML_IR_KEY_8,          KEY_8			},	 //0xef109f00
	{ML_IR_KEY_9,          KEY_9			},	 //0xf30c9f00
	{ML_IR_KEY_0,          KEY_0			},	 //0xee119f00
	{ML_IR_KEY_F1,         KEY_F1			},	 //0xaa559f00
	{ML_IR_KEY_F2,         KEY_F2			},	 //0xb14e9f00
	{ML_IR_KEY_F3,         KEY_F3			},	 //0xb6499f00
	{ML_IR_KEY_F4,         KEY_F4			},	 //0xb7489f00
	{ML_IR_KEY_SEARCH,     KEY_SEARCH       },   //0xbe419f00
	{ML_IR_KEY_REWIND,     KEY_REWIND       },   //0xf8079f00
	{ML_IR_KEY_FORWARD,    KEY_FORWARD      },   //0xfc039f00
	{ML_IR_KEY_STOP,       KEY_STOP         },   //0xec139f00
	{ML_IR_KEY_SETUP,      KEY_SETUP        },   //0xe51a9f00
	{ML_IR_KEY_INFO,       KEY_INFO         },
	{ML_IR_KEY_AUDIO,      KEY_AUDIO        },
	{ML_IR_KEY_SUBTITLE,   KEY_SUBTITLE     },
	{ML_IR_KEY_PLAYPAUSE,  KEY_PLAYPAUSE    },
	{ML_IR_KEY_FAVORITES,  KEY_FAVORITES    },
	{ML_IR_KEY_PAGEDOWN,   KEY_PAGEDOWN     },
	{ML_IR_KEY_PAGEUP,     KEY_PAGEUP       },
	{ML_IR_KEY_TVSYS,      KEY_TV           },
	{ML_IR_KEY_REPEAT,     KEY_REDO         },
	{ML_IR_KEY_FOCUS,      KEY_F5			},
	{ML_IR_KEY_HELP,       KEY_HELP         },
	{ML_IR_KEY_EJECT,      KEY_EJECTCLOSECD },
	{ML_IR_KEY_MYAPP,      KEY_COMPUTER     },
	{ML_IR_KEY_MOVIE,      KEY_MEDIA        },
	{ML_IR_KEY_BROWSER,    KEY_WWW          },
	{ML_IR_KEY_ZOOMOUT,    KEY_ZOOMOUT      },

	{SW_IR_KEY_RECORD,       KEY_RECORD       },
	{SW_IR_KEY_POWER,        KEY_POWER        },
	{SW_IR_KEY_FILE_EXPLORER,KEY_FN_1         },
	{SW_IR_KEY_PVR_LIST,     KEY_FN_D         },
	{SW_IR_KEY_BROWER,       KEY_WWW          },
	{SW_IR_KEY_GOOGLE_PLAY,  KEY_FN_E         },
	{SW_IR_KEY_INSTALL_APP,  KEY_FN_F         },
	{SW_IR_KEY_REWIND,       KEY_REWIND       },
	{SW_IR_KEY_PLAYPAUSE,    KEY_PLAYPAUSE	  },
	{SW_IR_KEY_STOP,         KEY_STOP         },
	{SW_IR_KEY_FORWARD,      KEY_FORWARD      },
        {SW_IR_KEY_PAGEDOWN,     KEY_PAGEDOWN     },
        {SW_IR_KEY_PAGEUP,       KEY_PAGEUP       },
	{SW_IR_KEY_UP,           KEY_UP           },
	{SW_IR_KEY_DOWN,         KEY_DOWN         },
	{SW_IR_KEY_RIGHT,        KEY_RIGHT        },
	{SW_IR_KEY_LEFT,         KEY_LEFT         },
	{SW_IR_KEY_OK,           KEY_ENTER        },
	{SW_IR_KEY_BACK,         KEY_BACK         },
	{SW_IR_KEY_INFO,         KEY_INFO         },
	{SW_IR_KEY_RED,          KEY_F1           },
	{SW_IR_KEY_GREEN,        KEY_F2           },
	{SW_IR_KEY_YELLOW,       KEY_F3           },
	{SW_IR_KEY_BLUE,         KEY_F4           },
	{SW_IR_KEY_CHANNELUP,    KEY_CHANNELUP	  },
	{SW_IR_KEY_CHANNELDOWN,  KEY_CHANNELDOWN  },
	{SW_IR_KEY_VOLADD,       KEY_VOLUMEUP     },
	{SW_IR_KEY_VOLSUB,       KEY_VOLUMEDOWN   },
	{SW_IR_KEY_HOME,         KEY_HOME         },
	{SW_IR_KEY_MUTE,         KEY_MUTE         },
	{SW_IR_KEY_1,            KEY_1		  },
	{SW_IR_KEY_2,            KEY_2		  },
	{SW_IR_KEY_3,            KEY_3		  },
	{SW_IR_KEY_4,            KEY_4		  },
	{SW_IR_KEY_5,            KEY_5		  },
	{SW_IR_KEY_6,            KEY_6		  },
	{SW_IR_KEY_7,            KEY_7		  },
	{SW_IR_KEY_8,            KEY_8		  },
	{SW_IR_KEY_9,            KEY_9		  },
	{SW_IR_KEY_0,            KEY_0		  },
	{SW_IR_KEY_MENU,         KEY_MENU         },
	{SW_IR_KEY_EPG,          KEY_FN_S          },
//	{SW_IR_KEY_SEARCH,     KEY_SEARCH       },
//	{SW_IR_KEY_SETUP,      KEY_SETUP        },
//	{SW_IR_KEY_AUDIO,      KEY_AUDIO        },
//	{SW_IR_KEY_SUBTITLE,   KEY_SUBTITLE     },
	{SW_IR_KEY_BACKSPACE,  KEY_BACKSPACE	},
	{SW_IR_KEY_FAVORITES,  KEY_FAVORITES	},
#if 0
	{SW_IR_KEY_IME,        KEY_FN_1         },
	{SW_IR_KEY_MORE,       KEY_FN_2         },
	{SW_IR_KEY_BTV,        KEY_FN_D			},
	{SW_IR_KEY_VOD,        KEY_FN_E			},
	{SW_IR_KEY_NVOD,       KEY_FN_F			},
	{SW_IR_KEY_NPVR,       KEY_FN_S			},
	{SW_IR_KEY_SEEK,       KEY_FN_B			},
#endif
{ML_IR_KEY_ZOOMIN,     KEY_ZOOMIN       },

	{SMT_IR_KEY_POWER,        KEY_POWER        },
	{SMT_IR_KEY_TV_RADIO,     KEY_MODE         },
        {SMT_IR_KEY_MUTE,         KEY_MUTE         },
	{SMT_IR_KEY_EPG	,	  KEY_EPG          },
	{SMT_IR_KEY_TXT,          KEY_TEXT         },
	{SMT_IR_KEY_FORMAT,       KEY_F9           },
	{SMT_IR_KEY_RATIO,        KEY_F8           },
        {SMT_IR_KEY_1,            KEY_1            },
        {SMT_IR_KEY_2,            KEY_2            },
        {SMT_IR_KEY_3,            KEY_3            },
        {SMT_IR_KEY_4,            KEY_4            },
        {SMT_IR_KEY_5,            KEY_5            },
        {SMT_IR_KEY_6,            KEY_6            },
        {SMT_IR_KEY_7,            KEY_7            },
        {SMT_IR_KEY_8,            KEY_8            },
        {SMT_IR_KEY_9,            KEY_9            },
        {SMT_IR_KEY_0,            KEY_0            },
        {SMT_IR_KEY_SAT,          KEY_F7           },
        {SMT_IR_KEY_INFO,         KEY_INFO         },
        {SMT_IR_KEY_RED,          KEY_RED          },
        {SMT_IR_KEY_GREEN,        KEY_GREEN        },
        {SMT_IR_KEY_YELLOW,       KEY_YELLOW       },
        {SMT_IR_KEY_BLUE,         KEY_BLUE         },
        {SMT_IR_KEY_MENU,         KEY_MENU         },
        {SMT_IR_KEY_BACK,         KEY_EXIT         },
        {SMT_IR_KEY_UP,           KEY_UP           },
        {SMT_IR_KEY_DOWN,         KEY_DOWN         },
        {SMT_IR_KEY_RIGHT,        KEY_RIGHT        },
        {SMT_IR_KEY_LEFT,         KEY_LEFT         },
        {SMT_IR_KEY_OK,           KEY_OK           },
        {SMT_IR_KEY_VOLADD,       KEY_VOLUMEUP     },
        {SMT_IR_KEY_VOLSUB,       KEY_VOLUMEDOWN   },
        {SMT_IR_KEY_CHANNELUP,    KEY_CHANNELUP    },
        {SMT_IR_KEY_CHANNELDOWN,  KEY_CHANNELDOWN  },
        {SMT_IR_KEY_HOME,         KEY_F10          },
        {SMT_IR_KEY_BROWER,       KEY_AUDIO        },
        {SMT_IR_KEY_GOOGLE_PLAY,  KEY_SUBTITLE     },
        {SMT_IR_KEY_INSTALL_APP,  KEY_FN_F         },
	{SMT_IR_KEY_MEDIA,        KEY_FILE         },
        {SMT_IR_KEY_FILE_EXPLORER,KEY_FN_1         },
        {SMT_IR_KEY_AUDIO,        KEY_AUDIO        },
	{SMT_IR_KEY_PHOTO,        KEY_FN_B         },
	{SMT_IR_KEY_MOVIE,        KEY_TV           },
        {SMT_IR_KEY_PVR_LIST,     KEY_PVR         },
        {SMT_IR_KEY_RECALL,       KEY_0         },
        //{SMT_IR_KEY_AB,           KEY_BACKSPACE   },
        //{SMT_IR_KEY_MOUSE,        KEY_FN_S        },
        {SMT_IR_KEY_GOTO,         KEY_HELP         },
        {SMT_IR_KEY_STOP,         KEY_STOP         },
	{SMT_IR_KEY_RECORD,       KEY_RECORD       },
        {SMT_IR_KEY_REWIND,       KEY_REWIND       },
        {SMT_IR_KEY_FORWARD,      KEY_FASTFORWARD      },
        {SMT_IR_KEY_PLAYPAUSE,    KEY_PLAYPAUSE    },
        {SMT_IR_KEY_REPEAT,       KEY_F6           },
        {SMT_IR_KEY_PAGEDOWN,     KEY_PAGEDOWN     },
        {SMT_IR_KEY_PAGEUP,       KEY_PAGEUP       },
        {SMT_IR_KEY_FAV,       	  KEY_FAVORITES       },//Remocon Key FAV add by choi 20140702
        {SMT_IR_KEY_WWW,          KEY_WWW      },//Remocon Key WWW add by choi 20140702


	{HDB_IR_KEY_POWER,         KEY_POWER        },  
	{HDB_IR_KEY_MUTE,          KEY_MUTE         },  

	{HDB_IR_KEY_TVRADIO,       KEY_MODE	    },	 


	{HDB_IR_KEY_REWIND,        KEY_REWIND       },   
	{HDB_IR_KEY_FORWARD,       KEY_FASTFORWARD      },   
	{HDB_IR_KEY_RECORD,        KEY_RECORD       },   
	{HDB_IR_KEY_PAUSE,         KEY_PAUSE        },   
	{HDB_IR_KEY_STOP,          KEY_STOP         },   
	{HDB_IR_KEY_PLAYPAUSE,     KEY_PLAYPAUSE	},	 

	{HDB_IR_KEY_RED,           KEY_RED          },	 
	{HDB_IR_KEY_GREEN,         KEY_GREEN	    },	 
	{HDB_IR_KEY_YELLOW,        KEY_YELLOW	    },	 
	{HDB_IR_KEY_BLUE,          KEY_BLUE	    },	 

	{HDB_IR_KEY_INFO,          KEY_INFO         },   
	{HDB_IR_KEY_RECALL,        KEY_LAST         },   

	{HDB_IR_KEY_UP,            KEY_UP           },   
	{HDB_IR_KEY_DOWN,          KEY_DOWN         },   
	{HDB_IR_KEY_RIGHT,         KEY_RIGHT        },  
	{HDB_IR_KEY_LEFT,          KEY_LEFT         },   
	{HDB_IR_KEY_OK,            KEY_OK           },  

	{HDB_IR_KEY_MENU,          KEY_MENU         },  
	{HDB_IR_KEY_EXIT,          KEY_EXIT         },  

	{HDB_IR_KEY_PAGEUP,        KEY_PAGEUP       },   
	{HDB_IR_KEY_FAVORITES,     KEY_FAVORITES	},	 
	{HDB_IR_KEY_PAGEDOWN,      KEY_PAGEDOWN     },   

	{HDB_IR_KEY_VOLUMEUP,      KEY_VOLUMEUP     },  
	{HDB_IR_KEY_VOLUMEDOWN,    KEY_VOLUMEDOWN   },  

	{HDB_IR_KEY_EPG,           KEY_EPG			},	 

	{HDB_IR_KEY_CHANNELUP,     KEY_CHANNELUP	},	 
	{HDB_IR_KEY_CHANNELDOWN,   KEY_CHANNELDOWN  },   

	{HDB_IR_KEY_1,             KEY_1			},	 
	{HDB_IR_KEY_2,             KEY_2			},	 
	{HDB_IR_KEY_3,             KEY_3			},	 
	{HDB_IR_KEY_4,             KEY_4			},	 
	{HDB_IR_KEY_5,             KEY_5			},	 
	{HDB_IR_KEY_6,             KEY_6			},	 
	{HDB_IR_KEY_7,             KEY_7			},	 
	{HDB_IR_KEY_8,             KEY_8			},	 
	{HDB_IR_KEY_9,             KEY_9			},	 
	{HDB_IR_KEY_0,             KEY_0			},	 

	{HDB_IR_KEY_TEXT,           KEY_TEXT			},	 
	{HDB_IR_KEY_SUBTITLE,      KEY_SUBTITLE     },   

	
	{ATTO_IR_KEY_UP,          KEY_UP          },
	{ATTO_IR_KEY_DOWN,        KEY_DOWN        },
	{ATTO_IR_KEY_RIGHT,       KEY_RIGHT       },
	{ATTO_IR_KEY_LEFT,        KEY_LEFT        },
	{ATTO_IR_KEY_ENTER,       KEY_OK          },
	{ATTO_IR_KEY_BACK,        KEY_EXIT        },
	{ATTO_IR_KEY_MENU,        KEY_MENU        },
	{ATTO_IR_KEY_POWER,       KEY_POWER       },
	{ATTO_IR_KEY_HOME,        KEY_HOME        },
	{ATTO_IR_KEY_VOLUMEUP,    KEY_VOLUMEUP    },
	{ATTO_IR_KEY_VOLUMEDOWN,  KEY_VOLUMEDOWN  },
	{ATTO_IR_KEY_MUTE,        KEY_MUTE        },
	{ATTO_IR_KEY_1,           KEY_1           },
	{ATTO_IR_KEY_2,           KEY_2           },
	{ATTO_IR_KEY_3,           KEY_3           },
	{ATTO_IR_KEY_4,           KEY_4           },
	{ATTO_IR_KEY_5,           KEY_5           },
	{ATTO_IR_KEY_6,           KEY_6           },
	{ATTO_IR_KEY_7,           KEY_7           },
	{ATTO_IR_KEY_8,           KEY_8           },
	{ATTO_IR_KEY_9,           KEY_9           },
	{ATTO_IR_KEY_0,           KEY_0           },
	{ATTO_IR_KEY_F1,          KEY_RED         },
	{ATTO_IR_KEY_F2,          KEY_GREEN       },
	{ATTO_IR_KEY_F3,          KEY_YELLOW      },
	{ATTO_IR_KEY_F4,          KEY_BLUE        },
	{ATTO_IR_KEY_SEARCH,      KEY_SEARCH      },
	{ATTO_IR_KEY_REWIND,      KEY_REWIND      },
	{ATTO_IR_KEY_FORWARD,     KEY_FORWARD 	  },
	{ATTO_IR_KEY_STOP,        KEY_STOP        },
	{ATTO_IR_KEY_SETUP,       KEY_SETUP       },
	{ATTO_IR_KEY_INFO,        KEY_INFO        },
	{ATTO_IR_KEY_AUDIO,       KEY_AUDIO       },
	{ATTO_IR_KEY_SUBTITLE,    KEY_SUBTITLE    },
	{ATTO_IR_KEY_BACKSPACE,   KEY_BACKSPACE   },
	{ATTO_IR_KEY_PLAY,        KEY_PLAY        },
	{ATTO_IR_KEY_PAUSE,       KEY_PAUSE       },
	{ATTO_IR_KEY_FAVORITES,   KEY_FAVORITES   },
	{ATTO_IR_KEY_CHANNELUP,   KEY_CHANNELUP   },
	{ATTO_IR_KEY_CHANNELDOWN, KEY_CHANNELDOWN },
	{ATTO_IR_KEY_PAGEDOWN,    KEY_PAGEDOWN    },
	{ATTO_IR_KEY_PAGEUP,      KEY_PAGEUP      },
	{ATTO_IR_KEY_FN_1,        KEY_FN_1        },
	{ATTO_IR_KEY_FN_2,        KEY_FN_2        },
	{ATTO_IR_KEY_FN_D,        KEY_FN_D        },
	{ATTO_IR_KEY_FN_E,        KEY_FN_E        },
	{ATTO_IR_KEY_FN_F,        KEY_FN_F        },
	{ATTO_IR_KEY_MOUSE,       KEY_FN_S		  },
	{ATTO_IR_KEY_FN_B,        KEY_FN_B        },
	{ATTO_IR_KEY_RECALL,      KEY_LAST        },
	{ATTO_IR_KEY_RECORD,      KEY_RECORD      },
	{ATTO_IR_KEY_SAT,         KEY_SAT         },
	{ATTO_IR_KEY_TV,          KEY_TV          },
	{ATTO_IR_KEY_EPG,         KEY_EPG         },
	{ATTO_IR_KEY_TIME,        KEY_TIME        },
	{ATTO_IR_KEY_TEXT,        KEY_TEXT        },
	{ATTO_IR_KEY_RADIO,       KEY_RADIO       },

};

typedef struct {
	struct input_dev *input;
	int irq;
	unsigned int addr;
	char *name;
}hi_event_dev;

static hi_event_dev *g_irkeypad_edev  = NULL;

#define MOUSE_MODE_EN             1
#define MOUSE_MAX_STEP            100
#define MOUSE_MIN_STEP            5

static int    g_mouse_move_step = MOUSE_MIN_STEP;
#define KPC_EV_KEY_PRESS          (0x1)
#define KPC_EV_KEY_RELEASE        (0x0)




/******************************added by wkf45780 for ir module suspend and resume start **/
#if 0
static unsigned int IR_CFG_Val;
static unsigned int IR_LEADS_Val;
static unsigned int IR_LEADE_Val;
static unsigned int IR_SLEADE_Val;
static unsigned int IR_B0_Val;
static unsigned int IR_B1_Val;
static unsigned int IR_DATAH_Val;
static unsigned int IR_DATAL_Val;
#endif
/******************************added by wkf45780 for ir module suspend and resume end **/



/*************************************************************
Function:       HI_IR_GetValue
Description:    get the value and status of key
Calls:
Data Accessed:
Data Updated:   NA
Input:          u32TimeOut: overtime value with unit of ms : 0 means no block while 0xFFFFFFFF means block forever
Output:         pu32PressStatus:    status of the key
                   0:  means press or hold
                   1:  means release
                pu32KeyId:          value of the key

Return:         HI_SUCCESS
                HI_FAILURE
Others:         NA
*************************************************************/
HI_S32 HI_IR_GetValue(HI_UNF_KEY_STATUS_E *penPressStatus, struct key_attr Irkey, HI_U64 *pu64KeyId)
{
	*penPressStatus = Irkey.key_stat;
	*pu64KeyId = Irkey.lower;
	return HI_SUCCESS;
}

HI_S32 IR_GetMapKey(IR_KEYMAP_S *pIRKeyMap,
HI_U32 IRKeyNum,HI_U64 SrcKeyId,HI_U32 *pUsrKeyId)
{
	HI_S32 i;

	for ( i = 0 ; i < IRKeyNum ; i++ )
	{
		if (SrcKeyId == pIRKeyMap[i].SrcKeyId)
		{
		    *pUsrKeyId = pIRKeyMap[i].linux_key_code;
		    return HI_SUCCESS;
		}
	}

	return HI_FAILURE;
}

static int android_ir_resume(void)
{
	hi_event_dev *edev = g_irkeypad_edev;
	input_event(edev->input, EV_KEY, KEY_WAKEUP, KPC_EV_KEY_PRESS);
	input_event(edev->input, EV_KEY, KEY_WAKEUP, KPC_EV_KEY_RELEASE);
	input_sync(edev->input);
	return 0;
}

static int android_ir_suspend(void)
{
	return 0;
}

static ssize_t android_ir_put(const struct key_attr irkey_to_user)
{
	HI_U64 keyval;
	HI_U32 flg;
	HI_S32 Ret;
	HI_U32	linux_key_code;
	static HI_U32 u32MouseMode = 0;
	hi_event_dev *edev = g_irkeypad_edev;
	HI_UNF_KEY_STATUS_E PressStatus;

	flg = 1;
	HI_IR_GetValue(&PressStatus, irkey_to_user, &keyval);

#if 0
	printk("[moya0426] Remocon keyval=0x%llx\n",keyval);
#endif
	/* 3. check and report keys*/

#if MOUSE_MODE_EN == 1		//this code is only for mouse mode

	if((IR_KEY_NPVR == keyval) || (SMT_IR_KEY_MOUSE == keyval) || (ATTO_IR_KEY_MOUSE == keyval)) {
		if(HI_UNF_KEY_STATUS_UP == PressStatus) {
			printk("2222\n");
			u32MouseMode = !u32MouseMode;
			input_event(edev->input, EV_KEY, KEY_PVR, u32MouseMode);
		}
	}

	if(u32MouseMode) {
		if(PressStatus !=HI_UNF_KEY_STATUS_HOLD) {
			g_mouse_move_step = MOUSE_MIN_STEP;
		}
		else {
			g_mouse_move_step = ((g_mouse_move_step+5)>MOUSE_MAX_STEP ? MOUSE_MAX_STEP : (g_mouse_move_step+5));
		}

		if((IR_KEY_UP == keyval) || (SMT_IR_KEY_UP == keyval) || (SW_IR_KEY_UP == keyval) || (ATTO_IR_KEY_UP == keyval) ) { //key up
			flg = 0;
			input_event(edev->input, EV_REL, REL_Y, -g_mouse_move_step);
		}
		else if((IR_KEY_DOWN == keyval) || (SMT_IR_KEY_DOWN == keyval) || (SW_IR_KEY_DOWN == keyval) || (ATTO_IR_KEY_DOWN == keyval)) { //key down
			flg = 0;
			input_event(edev->input, EV_REL, REL_Y, g_mouse_move_step);
		}
		else if((IR_KEY_LEFT == keyval) || (SMT_IR_KEY_LEFT == keyval) || (SW_IR_KEY_LEFT == keyval) || (ATTO_IR_KEY_LEFT == keyval)) { //key left
			flg = 0;
			input_event(edev->input, EV_REL, REL_X, -g_mouse_move_step);
		}
		else if((IR_KEY_RIGHT == keyval) || (SMT_IR_KEY_RIGHT == keyval) || (SW_IR_KEY_RIGHT == keyval) || (ATTO_IR_KEY_RIGHT == keyval)) { //key right
			flg = 0;
			input_event(edev->input, EV_REL, REL_X, g_mouse_move_step);
		}
		else if((IR_KEY_OK == keyval) || (SMT_IR_KEY_OK == keyval) || (SW_IR_KEY_OK == keyval) || (ATTO_IR_KEY_ENTER == keyval)) { //key ok
			flg = 0;
			if(HI_UNF_KEY_STATUS_BUTT == PressStatus) {
				input_event(edev->input, EV_KEY, BTN_LEFT, 0x01);
				input_event(edev->input, EV_KEY, BTN_LEFT, 0x00);
			}
			else if(HI_UNF_KEY_STATUS_DOWN == PressStatus) {
				input_event(edev->input, EV_KEY,BTN_LEFT, 0x01);
			}
			else if(HI_UNF_KEY_STATUS_UP == PressStatus){
				input_event(edev->input, EV_KEY,BTN_LEFT, 0x00);
			}
		}
	}

	if(flg) {

		Ret=IR_GetMapKey(Key_Code,sizeof(Key_Code)/sizeof(Key_Code[0]),keyval,&linux_key_code);
		if(Ret == HI_FAILURE)
		{
		     printk("there is no key for \n");
		     return -1;
		}
// sky(stby)
#if 0
		if (linux_key_code== KEY_POWER) {
			struct file *fp;
			fp = filp_open("/var/.xbmc", O_RDONLY, 0);
			if (!IS_ERR(fp)) {
				linux_key_code = KEY_SUSPEND; // AKEYCODE_STB_POWER
				filp_close(fp, NULL);
			}
		 	printk("imkey_power2{%x}\n", linux_key_code);
		}
#endif
		if(PressStatus ==HI_UNF_KEY_STATUS_BUTT)
		{
		   	printk("!!!!KEY ERR!!!!\n");
		}
		else if(PressStatus ==HI_UNF_KEY_STATUS_DOWN)
		{
		   	input_event(edev->input, EV_KEY, linux_key_code,0x01);
		}
		else if(PressStatus ==HI_UNF_KEY_STATUS_UP)
		{
		  	input_event(edev->input, EV_KEY, linux_key_code,0x00);
		}
		else if(PressStatus ==HI_UNF_KEY_STATUS_HOLD)
		{
		  	input_event(edev->input, EV_KEY, linux_key_code,0x02);
		}
	}
#endif

#if MOUSE_MODE_EN == 0

		Ret=IR_GetMapKey(Key_Code,sizeof(Key_Code)/sizeof(Key_Code[0]),keyval,&linux_key_code);
		if(Ret == HI_FAILURE)
		{
		     printk("there is no key for \n");
		     return -1;
		}
// sky(stby)
#if 1
		if (linux_key_code== KEY_POWER) {
			struct file *fp;
			fp = filp_open("/var/.xbmc", O_RDONLY, 0);
			if (!IS_ERR(fp)) {
				linux_key_code = KEY_SUSPEND; // AKEYCODE_STB_POWER
				filp_close(fp, NULL);
			}
		 	printk("irkey_power2{%x}\n", linux_key_code);
		}
#endif
		if(PressStatus ==HI_UNF_KEY_STATUS_BUTT)
		{
		   	printk("!!!!KEY ERR!!!!\n");
		}
		else if(PressStatus ==HI_UNF_KEY_STATUS_DOWN)
		{
		       input_event(edev->input, EV_KEY, linux_key_code,0x01);
		}
		else if(PressStatus ==HI_UNF_KEY_STATUS_UP)
		{
		       input_event(edev->input, EV_KEY, linux_key_code,0x00);
		}
		else if(PressStatus ==HI_UNF_KEY_STATUS_HOLD)
		{
		       input_event(edev->input, EV_KEY, linux_key_code,0x02);
		}


#endif




//	printk("#####keyval=0x%llx\n",keyval);
//	printk("#####linux_key_code=0x%x\n",linux_key_code);
//	printk("#####PressStatus=0x%x\n",PressStatus);
/**/
	/* 4. clear interrupt only we involved */
	input_sync(edev->input);

	return 0;

}



static int android_ir_register_inputdevice(void)
{
	hi_event_dev *edev;
	int i;
//	int retval;

	//1. alloc input device resource
	edev = kzalloc(sizeof(hi_event_dev), GFP_KERNEL);
	if(!edev) {
		printk("events edev or hi_keypad_ input_dev alloc fail!\n");
		return -1;
	}

	edev->name = "remote control";
	edev->input = input_allocate_device();

	// 2. indicate that we generate key events
	set_bit(EV_KEY, edev->input->evbit);
	set_bit(EV_REL, edev->input->evbit);

	for(i=1; i<= 0x1ff; i++) {
		set_bit(i, edev->input->keybit);
	}

	set_bit(EV_SYN, edev->input->relbit);
	set_bit(EV_KEY, edev->input->relbit);

	//3. set input date and register device
	//platform_set_drvdata(pdev, edev);

	edev->input->name = edev->name;
	edev->input->id.bustype = BUS_HOST;
	edev->input->id.vendor = 0x0001;
	edev->input->id.product = 0x0001;
	edev->input->id.version = 0x0100;

	if(input_register_device(edev->input)) {
		printk("input_register_device fail!\n");
		input_free_device(edev->input);
		kfree(edev);
		return -1;
	}
	g_irkeypad_edev = edev;
	printk("input_register sucfully\n");
	return 0;

}

int android_ir_unregister_inputdevice(void)
{
	hi_event_dev *edev = g_irkeypad_edev;
	input_unregister_device(edev->input);
	kfree(edev);
	printk("input_unregister  sucfully\n");
	return 0;
}
