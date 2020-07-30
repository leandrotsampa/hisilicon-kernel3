#include <linux/slab.h>
#include <linux/dma-mapping.h>
#include <linux/semaphore.h>
#include <linux/semaphore.h>
#include <asm/cacheflush.h>
#include <linux/list.h>

#include <linux/hisi/tee_smmu.h>

#include "teek_client_api.h"
#define HI_ZERO 0
#define ADDR_INVALID (~0)

static DEFINE_SEMAPHORE(smmu_lock);

LIST_HEAD(smmu_list);

extern void hisi_get_iommu_ptable_addr(unsigned int *pt_addr,
		unsigned int *err_rdaddr, unsigned int *wraddr);

/* for tee  */
TEEC_Context context;
TEEC_Session session;
typedef enum {
	HI_SECSMMU_SET = 0x2000,
	HI_SECSMMU_CLR,
	HI_SECSMMU_SMMUMAP,
	HI_SECSMMU_SMMUUNMAP,
	HI_SECSMMU_AGENT_CLOSED,
} SMMU_COMMANDID;

typedef enum {
	SECSMMU_CLR = 0,
	SECSMMU_SET,
	SECSMMU_SMMUMAP,
	SECSMMU_SMMUUNMAP,
	SECSMMU_AGENT_CLOSED,
} SMMU_OPERATION;

#define INVALIDATE_ADDR	(0)


#if 0
static const TEEC_UUID smmu_uuid =
{
	/* TEEC_UUIC needed   */
	0x70e6926a, 0x816b, 0x19f4,
	{0xa6, 0x28, 0x3f, 0xcc, 0xaa, 0xb1, 0x21, 0xfa}
};
#else
static const TEEC_UUID smmu_uuid =
{
	/* TEEC_UUIC needed   */
	0x0F0F0F0F, 0x0F0F, 0x0F0F,
	{0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F}
};

#endif
#define HI_ZERO 0

/*
 * sec_addr is one kind of sec mem addreww, flag is indicate the type:
 * 0:phys addr   1: sec smmu.
 */
u32 hisi_get_tee_meminfo(u32 sec_addr, int flag)
{
	TEE_MEM_LIST *tee_mem;
	TEE_MEMBLOCKS *mblock;

	down(&smmu_lock);
	if (list_empty(&smmu_list)) {
		/* smmu_list is empth means
		 * all is normal mem and no sec map
		 */
		up(&smmu_lock);
		return INVALIDATE_ADDR;
	}
	list_for_each_entry(tee_mem, &smmu_list, list) {
		mblock = (TEE_MEMBLOCKS *)phys_to_virt(tee_mem->phys_buf);
		if (flag) {
			if (mblock->sec_smmu == sec_addr)
				break;
		} else {
			if (mblock->phys_addr == sec_addr)
				break;
		}

		mblock = NULL;
	}
	if (NULL == mblock) {
		TEEC_Error("%s cannot find memblock, sec_ddr:0x%x  iommu:0x%x \n",
							__func__, sec_addr, flag);
		up(&smmu_lock);
		return INVALIDATE_ADDR;
	}

	up(&smmu_lock);
	return virt_to_phys(mblock);
}

/*
 * MAX_MEMBLOCK_NUM = sizeof(struct tz_pageinfo)*N + sizeof(TEE_MEMBLOCKS)
 * N is the number of memblocks which will be used in secure os. In worst case,
 * each memblock is one page and N is 1M in 4G ddr. But in actusl applications,
 * N is less then 1M.
 */
#define MAX_MEMBLOCK_NUM (1024*1024*1024)
static u32 _hisi_tee_smmumem_into_ta(TEE_MEM_BUFFER_S *teebuf, u32 addr, int iommu)
{
	struct scatterlist *sg;
	struct tz_pageinfo *tmp;
	size_t size;
	void *buf;
	int i = 0;
	TEE_MEM_LIST *tee_mem;
	TEE_MEMBLOCKS *tz_mblock = NULL;

	if (NULL == teebuf->table) {
		TEEC_Error("TEEC sec smmu get meminfo failed!\n");
		goto out;
	}

	if (teebuf->table->nents >= MAX_MEMBLOCK_NUM) {
		TEEC_Error("Too many memblocks in sg list! The max number of \
				memblock is 0x%x and current number is 0x%x\n",
				MAX_MEMBLOCK_NUM, teebuf->table->nents);
		goto out;
	}

	size = (teebuf->table->nents)*sizeof(struct tz_pageinfo) + sizeof(TEE_MEMBLOCKS);
	buf = kmalloc(size, GFP_KERNEL);
	if (NULL == buf) {
		TEEC_Error("TEEC sec smmu failed to alloc buf!\n");
		goto free_tzm;
	}

	memset(buf, 0, size);
	tz_mblock = (TEE_MEMBLOCKS *)buf;
	tz_mblock->total_size = teebuf->u32Size;

	if (iommu)
		tz_mblock->normal_smmu = addr;
	else
		tz_mblock->phys_addr = addr;
	tz_mblock->pageinfoaddr = virt_to_phys(buf) + sizeof(TEE_MEMBLOCKS);
	memcpy(buf, tz_mblock, sizeof(TEE_MEMBLOCKS));
	tmp = kzalloc(sizeof(struct tz_pageinfo), GFP_KERNEL);
	if (NULL == tmp) {
		TEEC_Error("TEEC sec smmu get tz_pageinfo mem failed!\n");
		goto free_dma;
	}	

	for_each_sg(teebuf->table->sgl, sg, teebuf->table->nents, i) {
		struct page *page = NULL;
		u32 len = 0;
		u32 phys = 0x0;

		memset(tmp, 0, sizeof(struct tz_pageinfo));
		page = sg_page(sg);
		phys = page_to_pfn(page) << PAGE_SHIFT;
		len = PAGE_ALIGN(sg->length) >> PAGE_SHIFT;

		tmp->phys_addr = phys;
		tmp->npages = len;
		memcpy((buf + i*sizeof(struct tz_pageinfo) + sizeof(TEE_MEMBLOCKS)), tmp, sizeof(struct tz_pageinfo));
	}
	kfree(tmp);
#ifdef CONFIG_ARM64
	__flush_dcache_area((void *)buf, (size_t)size);
#else
	__cpuc_flush_dcache_area((void *)buf, (size_t)size);
	outer_flush_range(virt_to_phys(buf), virt_to_phys(buf) + size);
#endif
	tee_mem = kmalloc(sizeof(TEE_MEM_LIST), GFP_KERNEL);
	if (NULL == tee_mem) {
		pr_err("no mem!\n");
		goto free_dma;
	}
	tee_mem->phys_buf = virt_to_phys(buf);
	list_add(&tee_mem->list, &smmu_list);

	return virt_to_phys(buf);
free_dma:
	kfree(buf);
free_tzm:
out:
	return 0;
}

static void _hisi_tee_smmumem_outfrom_ta(u32 buf_phy)
{
	TEE_MEM_LIST *tee_mem;

	if (list_empty(&smmu_list)) {
		pr_err("%s:no tee mem on the list!\n", __func__);
		return;
	}

	list_for_each_entry(tee_mem, &smmu_list, list) {
		if (tee_mem->phys_buf == buf_phy) {
			list_del(&tee_mem->list);
			kfree(tee_mem);
			kfree(phys_to_virt(buf_phy));
			return;
		}
	}
	pr_err("cannot find the buffer(phys:0x%x),free failed!\n",
					buf_phy);

	return;
}

/*
 * teebuf: meminfo list
 * addr: phys_addr of mem
 * iommu: indicate the addr type
 */
u32 hisi_tee_smmumem_into_ta(TEE_MEM_BUFFER_S *teebuf, u32 addr, int iommu)
{
	u32 buf_phys = 0;

	down(&smmu_lock);
	buf_phys = _hisi_tee_smmumem_into_ta(teebuf, addr, iommu);
	up(&smmu_lock);

	return buf_phys;
}

void hisi_tee_smmumem_outfrom_ta(u32 buf_phys)
{
	down(&smmu_lock);
	_hisi_tee_smmumem_outfrom_ta(buf_phys);
	up(&smmu_lock);
}

static int init_done;
int hisi_teesmmu_init(void)
{
	TEEC_Result result;
	unsigned int origin;

	/* init context*/
	result = TEEK_InitializeContext(NULL, &context);
	if(result != TEEC_SUCCESS) {
		TEEC_Error("TEEC_InitializeContext failed, ret=0x%x.\n", result);
		goto cleanup_1;
	}
	/* open session */
	result = TEEK_OpenSession(&context, &session, &smmu_uuid,
				TEEC_LOGIN_PUBLIC, NULL, NULL, &origin);
	if(result != TEEC_SUCCESS) {
		TEEC_Error("TEEC_OpenSession failed, ReturnCode=0x%x, \
				ReturnOrigin=0x%x\n", result, origin);
		goto cleanup_2;
	}
	TEEC_Debug("TEEC sec smmu initialized.\n");
	init_done++;

	return 0;

cleanup_2:
	TEEK_FinalizeContext(&context);
cleanup_1:
	return -1;
}

void hisi_teesmmu_exit(void)
{
	TEEK_CloseSession(&session);
	TEEK_FinalizeContext(&context);
	init_done = 0;

	TEEC_Debug("TEEC sec smmu removed.\n");
}

static int hisi_secmem_handle(u32 buf_phy, int chioce)
{
	TEEC_Result result;
	TEEC_Operation operation;
	unsigned int origin;
	int ret;
	int init = 0;

	if (!init_done) {
		ret = hisi_teesmmu_init();
		if (ret) {
			TEEC_Error("TEEC sec smmu init failed!\n");
			goto out;
		}
		init = 1;
	}

	memset(&operation, 0x00, sizeof(operation));
	operation.started = 1;

	operation.paramTypes = TEEC_PARAM_TYPES(TEEC_VALUE_INOUT, TEEC_NONE,
							TEEC_NONE, TEEC_NONE);

	operation.params[0].value.a = buf_phy;
	operation.params[0].value.b = sizeof(TEE_MEMBLOCKS);

	switch (chioce) {
	case SECSMMU_SET:
	{
		result = TEEK_InvokeCommand(&session, HI_SECSMMU_SET,
						&operation, &origin);
		break;
	}
	case SECSMMU_CLR:
	{
		result = TEEK_InvokeCommand(&session, HI_SECSMMU_CLR,
						&operation, &origin);
		break;
	}
	case SECSMMU_SMMUMAP:
	{
		result = TEEK_InvokeCommand(&session, HI_SECSMMU_SMMUMAP,
						&operation, &origin);
		break;
	}
	case SECSMMU_SMMUUNMAP:
	{
		result = TEEK_InvokeCommand(&session, HI_SECSMMU_SMMUUNMAP,
						&operation, &origin);
		break;
	}
	case SECSMMU_AGENT_CLOSED:
	{
		result = TEEK_InvokeCommand(&session, HI_SECSMMU_AGENT_CLOSED,
						&operation, &origin);
		break;
	}
	default:
		TEEC_Error("%s :cmd err!\n", __func__);
		ret = -1;
		goto exit;
	}

	if(result != TEEC_SUCCESS) {
		TEEC_Error("InvokeCommand failed, ReturnCode=0x%x, \
					ReturnOrigin=0x%x\n", result, origin);
		ret = result;
		goto exit;
	} else {
		TEEC_Debug("InvokeCommand success\n");
		ret = 0;
	}

exit:
	if (init)
		hisi_teesmmu_exit();
out:
	return ret;

}

int hisi_secmem_alloc(TEE_MEM_BUFFER_S *teebuf, u32 addr, int iommu, u32 *sec_smmu)
{
	
	int ret = 0;
	u32 buf_phy;
	TEE_MEMBLOCKS *tz_mblock = NULL;

	down(&smmu_lock);
	if (NULL == teebuf) {
		TEEC_Error("%s : err args!\n", __func__);
		ret = -1;
		goto err;
	}

	buf_phy = _hisi_tee_smmumem_into_ta(teebuf, addr, iommu);
	if (!buf_phy) {
		TEEC_Error("_hisi_tee_smmumem_into_ta failed!\n");
		goto err;
	}
	ret = hisi_secmem_handle(buf_phy, SECSMMU_SET);
	if (ret)
		goto exit;
	tz_mblock = (TEE_MEMBLOCKS *)phys_to_virt(buf_phy);

	*sec_smmu = tz_mblock->sec_smmu;
	up(&smmu_lock);
	return 0;

exit:
	_hisi_tee_smmumem_outfrom_ta(buf_phy);
err:
	up(&smmu_lock);
	return ret;
}

/*
 * addr is one kinds of sec mem,and flag is indicate the type:
 * phys addr or sec smmu addr
 */
int hisi_secmem_free(u32 sec_addr, int flag)
{
	int ret = 0;
	u32 buf_phy;

	buf_phy = hisi_get_tee_meminfo(sec_addr, flag); 
	if (INVALIDATE_ADDR == buf_phy) {
		TEEC_Error("%s cannot find memblock, sec_addr:0x%x flag:%d\n",
						__func__, sec_addr, flag);
		goto exit;

	}
	down(&smmu_lock);
	ret = hisi_secmem_handle(buf_phy, SECSMMU_CLR);
	if (ret)
		goto exit;
	_hisi_tee_smmumem_outfrom_ta(buf_phy);
	ret = 0;
exit:
	up(&smmu_lock);
	return ret;
}

/*
 * map to sec smmu
 *
 */
int hisi_secmem_mapto_secsmmu(TEE_MEM_BUFFER_S *teebuf, u32 addr, int iommu, u32 *sec_smmu)
{
	
	int ret = 0;
	u32 buf_phy;
	TEE_MEMBLOCKS *tz_mblock = NULL;

	down(&smmu_lock);
	if (NULL == teebuf) {
		TEEC_Error("%s : err args!\n", __func__);
		ret = -1;
		goto err;
	}

	buf_phy = _hisi_tee_smmumem_into_ta(teebuf, addr, iommu);
	if (!buf_phy) {
		TEEC_Error("_hisi_tee_smmumem_into_ta failed!\n");
		goto err;
	}
	ret = hisi_secmem_handle(buf_phy, SECSMMU_SMMUMAP);
	if (ret)
		goto exit;
	tz_mblock = (TEE_MEMBLOCKS *)phys_to_virt(buf_phy);

	*sec_smmu = tz_mblock->sec_smmu;
	up(&smmu_lock);
	return 0;

exit:
	_hisi_tee_smmumem_outfrom_ta(buf_phy);
err:
	up(&smmu_lock);
	return ret;
}

int hisi_secmem_unmap_from_secsmmu(u32 sec_smmu)
{
	int ret = 0;
	u32 buf_phy;

	buf_phy = hisi_get_tee_meminfo(sec_smmu, 1); 
	if (INVALIDATE_ADDR == buf_phy) {
		TEEC_Error("%s cannot find memblock, sec_smmu:0x%x \n",
							__func__, sec_smmu);
		goto exit;

	}
	down(&smmu_lock);
	ret = hisi_secmem_handle(buf_phy, SECSMMU_SMMUUNMAP);
	if (ret)
		goto exit;
	_hisi_tee_smmumem_outfrom_ta(buf_phy);
	ret = 0;
exit:
	up(&smmu_lock);
	return ret;
}

int hisi_secmem_agent_end(void)
{
	int ret = 0;

	ret = hisi_secmem_handle(0, SECSMMU_AGENT_CLOSED);
	if (ret) {
		TEEC_Error("%s failed!\n", __func__);
		return -1;
	}

	return 0;
}


EXPORT_SYMBOL(hisi_get_tee_meminfo);
EXPORT_SYMBOL(hisi_tee_smmumem_into_ta);
EXPORT_SYMBOL(hisi_tee_smmumem_outfrom_ta);
EXPORT_SYMBOL(hisi_teesmmu_init);
EXPORT_SYMBOL(hisi_teesmmu_exit);
EXPORT_SYMBOL(hisi_secmem_alloc);
EXPORT_SYMBOL(hisi_secmem_free);
EXPORT_SYMBOL(hisi_secmem_mapto_secsmmu);
EXPORT_SYMBOL(hisi_secmem_unmap_from_secsmmu);
EXPORT_SYMBOL(hisi_secmem_agent_end);
