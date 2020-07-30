
#include <linux/init.h>
#include <linux/module.h>
#include <linux/types.h>
#include <linux/fs.h>
#include <linux/proc_fs.h>
#include <linux/device.h>
#include <asm/uaccess.h>
#include <linux/sched.h>
#include <linux/kernel.h>
#include <linux/interrupt.h>
#include <linux/smp.h>
#include <linux/kthread.h>
#include <linux/mutex.h>
#include <linux/syscalls.h>

//#define TEEC_DEBUG
#include "tee_client_api.h"
#include "tee_client_id.h"
#include "sec_mmz.h"

static const TEEC_UUID COMMON_uuid =
{
	0x79b77788, 0x9789, 0x4a7a,
	{ 0xa2, 0xbe, 0xb6, 0x01, 0x55, 0xee, 0xf5, 0xf5 }
};

TEEC_Context context;
TEEC_Session session;
unsigned int dev_id;

int HI_SEC_MMZ_Init(void)
{
	TEEC_Result result;

	result = TEEC_InitializeContext(NULL, &context, &dev_id);
	if(result != TEEC_SUCCESS) {
		TEEC_Error("TEEC_InitializeContext failed, ret=0x%x.", result);
		goto cleanup_1;
	}
	result = TEEC_OpenSession(&context, &session, &COMMON_uuid, TEEC_LOGIN_PUBLIC, NULL, NULL, NULL, dev_id);
	if(result != TEEC_SUCCESS) {
		TEEC_Error("TEEC_OpenSession failed, ret=0x%x.", result);
		goto cleanup_2;
	}

	TEEC_Debug("TZ sec mmz initialized.\n");

	return 0;

cleanup_2:
	TEEC_FinalizeContext(&context,dev_id);
cleanup_1:
	return -1;
}

void HI_SEC_MMZ_DeInit(void)
{
	TEEC_CloseSession(&session,dev_id);
	TEEC_FinalizeContext(&context,dev_id);

	TEEC_Debug("TZ sec mmz removed.\n");
}

void *HI_SEC_MMZ_New(unsigned long size , char *mmz_name, char *mmb_name)
{
	TEEC_Result result;
	TEEC_Operation operation;

	void * pa = 0;

	if (!mmz_name)
	{
		TEEC_Error("NULL mmz name, not supported!\n");
		return NULL;
	}

	if (!mmb_name)
	{
		TEEC_Error("NULL mmb name, not supported!\n");
		return NULL;
	}

	memset(&operation, 0x00, sizeof(operation));
	operation.started = 1;

	operation.params[0].tmpref.buffer = mmz_name;
	operation.params[0].tmpref.size = strlen(mmz_name) + 1;

	operation.params[1].tmpref.buffer = mmb_name;
	operation.params[1].tmpref.size = strlen(mmb_name) + 1;
	operation.params[2].value.a = size;

	operation.paramTypes = TEEC_PARAM_TYPES(
				TEEC_MEMREF_TEMP_INPUT,
				TEEC_MEMREF_TEMP_INPUT,
				TEEC_VALUE_INPUT,
				TEEC_VALUE_OUTPUT);

	result = TEEC_InvokeCommand(&session, HI_MMZ_NEW, &operation, NULL, dev_id);
	if (result == TEEC_SUCCESS)
	{
		pa = (void *)operation.params[3].value.a;
		TEEC_Debug("new '%s'(phy_addr:0x%x, size:%lu) mmb from mmz(%s) successful.\n", mmb_name, (unsigned int)pa, size, mmz_name);
	} else {
		pa = NULL;
		TEEC_Error("new '%s'(size:%lu) mmb from mmz(%s) failed, ret=0x%x.\n", mmb_name, size, mmz_name, result);
	}

	return pa;
}

int HI_SEC_MMZ_Delete(unsigned long phys_addr)
{
	TEEC_Result result;
	TEEC_Operation operation;
	int ret  = -1;

	memset(&operation, 0x00, sizeof(operation));
	operation.started = 1;
	operation.params[0].value.a = phys_addr;

	operation.paramTypes = TEEC_PARAM_TYPES(TEEC_VALUE_INPUT,
				TEEC_NONE,
				TEEC_NONE,
				TEEC_NONE);

	result = TEEC_InvokeCommand(&session, HI_MMZ_DEL, &operation, NULL, dev_id);
	if (result != TEEC_SUCCESS)
	{
		TEEC_Error("delete mmb(phy_addr:0x%lx) failed, ret=0x%x.\n", phys_addr, result);
		ret = -1;
	}
	else
	{
		TEEC_Debug("delete mmb(phy_addr:0x%lx) successful.\n", phys_addr);
		ret = 0;
	}

	return ret;
}

int HI_SEC_MMZ_CA2TA(unsigned long CAphyaddr, unsigned long TAphyaddr, unsigned long CopySize)
{
	TEEC_Result result;
	TEEC_Operation operation;
	int ret = -1;

	operation.started = 1;
	operation.params[0].value.a = CAphyaddr;
	operation.params[1].value.a = TAphyaddr;
	operation.params[2].value.a = CopySize;

	operation.paramTypes = TEEC_PARAM_TYPES(TEEC_VALUE_INPUT,
				TEEC_VALUE_INPUT,
				TEEC_VALUE_INPUT,
				TEEC_NONE);


	result = TEEC_InvokeCommand(&session, HI_MMZ_CP_CA2TA, &operation, NULL, dev_id);
	if (result != TEEC_SUCCESS)
	{
		TEEC_Error("trans CAphy(0x%lx) to TAphy(0x%lx) failed, ret=0x%x.\n", CAphyaddr, TAphyaddr, result);
		ret = -1;
	}
	else
	{
		TEEC_Debug("trans CAphy(0x%lx) to TAphy(0x%lx) successful.\n", CAphyaddr, TAphyaddr);
		ret = 0;
	}

	return ret;
}

#ifdef CONFIG_SEC_MMZ_TA2CA
int HI_SEC_MMZ_TA2CA(unsigned long TAphyaddr, unsigned long CAphyaddr, unsigned long CopySize)
{
	TEEC_Result result;
	TEEC_Operation operation;
	uint32_t cmd = 0;
	uint32_t origin;

	operation.started = 1;
	operation.params[0].value.a = TAphyaddr;
	operation.params[1].value.a = CAphyaddr;
	operation.params[2].value.a = CopySize;

	operation.paramTypes = TEEC_PARAM_TYPES(TEEC_VALUE_INPUT,
				TEEC_VALUE_INPUT,
				TEEC_VALUE_INPUT,
				TEEC_NONE);


	result = TEEC_InvokeCommand(
				&session,
				HI_MMZ_CP_TA2CA,
				&operation,
				NULL,
				dev_id);

	if (result != TEEC_SUCCESS) {
		TEEC_Error("invoke failed, codes=0x%x\n", result);
	}

	return 0;
}
#endif

int HI_SEC_MMZ_TA2TA(unsigned long phyaddr1, unsigned long phyaddr2, unsigned long CopySize)
{
	TEEC_Result result;
	TEEC_Operation operation;
	int ret = -1;

	operation.started = 1;
	operation.params[0].value.a = phyaddr1;
	operation.params[1].value.a = phyaddr2;
	operation.params[2].value.a = CopySize;

	operation.paramTypes = TEEC_PARAM_TYPES(TEEC_VALUE_INPUT,
				TEEC_VALUE_INPUT,
				TEEC_VALUE_INPUT,
				TEEC_NONE);


	result = TEEC_InvokeCommand(&session, HI_MMZ_CP_TA2TA, &operation, NULL, dev_id);
	if (result != TEEC_SUCCESS)
	{
		TEEC_Error("trans TAphy(0x%lx) to TAphy(0x%lx) failed, ret=0x%x.\n", phyaddr1, phyaddr2, result);
		ret = -1;
	}
	else
	{
		TEEC_Debug("trans TAphy(0x%lx) to TAphy(0x%lx) successful.\n", phyaddr1, phyaddr2);
		ret = 0;
	}

	return ret;
}

EXPORT_SYMBOL(HI_SEC_MMZ_New);
EXPORT_SYMBOL(HI_SEC_MMZ_Delete);
EXPORT_SYMBOL(HI_SEC_MMZ_CA2TA);
#ifdef CONFIG_SEC_MMZ_TA2CA
EXPORT_SYMBOL(HI_SEC_MMZ_TA2CA);
#endif
EXPORT_SYMBOL(HI_SEC_MMZ_TA2TA);

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("TrustZone Driver");

module_init(HI_SEC_MMZ_Init);
module_exit(HI_SEC_MMZ_DeInit);

