#define pr_fmt(fmt) "SYS_CHK:%s(%d): " fmt, __func__, __LINE__

#include <linux/init.h>
#include <linux/module.h>
#include <linux/io.h>
#include <asm/io.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/proc_fs.h>
#include <linux/seq_file.h>
#include <linux/reboot.h>
#include <linux/suspend.h>
#include <asm/uaccess.h>
#include <linux/mm.h>
#include <linux/moduleparam.h>
#include <asm/cacheflush.h>
#include <linux/delay.h>
#include <linux/kthread.h>
#include <linux/crypto.h>
#include <linux/err.h>
#include <linux/scatterlist.h>
#include <asm/setup.h>

#include "rsa.h"
#include "hi_drv_cipher.h"
#include "hi_drv_mmz.h"

extern HI_S32 DRV_CA_OTP_V200_GetSCSActive(HI_U32 *pActiveFlag);
extern int get_param_data(const char *name, char *buf, unsigned int buflen);

#define SYSTEM_LIST_FILE "/system/etc/system_list"
#define CONFIG_RSAKEY_TAG_VAL   0x52534101  /* RSA */
#define BUF_SIZE 1024
#define OFFSET_ACTUAL_DATA_SIZE 0x34
#define OFFSET_SIG_DATA         0x74
#define SIG_DATA_LEN            0x100
#define SHA1_LEN                20
#define MAX_RETRY_TIMES         20
#define SHA1_BLOCK_SIZE         64
#define HASH_PAD_MAX_LEN        (64)
#define ERRMSG_LEN              512

#ifndef SIGN_BLOCK_SIZE
#define SIGN_BLOCK_SIZE         (0x200000)   //2M
#endif

enum e_status {
	E_STATUS_STOP = 0,
	E_STATUS_RUNNING,
	E_STATUS_SUCCESS,
	E_STATUS_FAIL,
};

static char *status_str[] = {
	"Stop",
	"Running",
	"Success",
	"Fail"
};
static char errmsg[ERRMSG_LEN];
static int chk_fail_flag = E_STATUS_STOP;
static char *file_data_buf;
static char *line_buf;
static unsigned char RSAKey[512] = {0};
static unsigned char g_all_partition_hash[128] = {0};
static unsigned char g_system_hash[32] = {0};
static struct task_struct *verify_task = NULL;
static struct notifier_block verify_pm_notifier;

static int parse_tag_rsakey(void)
{
	int taglen;

	memset(RSAKey, 0, 512);

	taglen = get_param_data("rsa_n", RSAKey, 256);
	if (taglen <= 0)
		return -1;

	taglen = get_param_data("rsa_e", RSAKey + 508, 4);
	if (taglen <= 0)
		return -1;

	taglen = get_param_data("rsa_ha", g_all_partition_hash, 96);
	if (taglen <= 0)
		return -1;

	return 0;
}

/* read file interface */
static int filp_fread(char *buf, int len, struct file *filp)
{
	int readlen;
	mm_segment_t oldfs;

	if (filp == NULL)
		return -ENOENT;
	if (filp->f_op->read == NULL)
		return -ENOSYS;
	if (((filp->f_flags & O_ACCMODE) & (O_RDONLY | O_RDWR)) != 0)
		return -EACCES;
	oldfs = get_fs();
	set_fs(KERNEL_DS);
	readlen = filp->f_op->read(filp, buf, len, &filp->f_pos);
	set_fs(oldfs);

	return readlen;
}

static int syschk_show(struct seq_file *m, void *v)
{
	int i = 0;
	seq_printf(m, "Status: %s\n", status_str[chk_fail_flag]);
	for (i = 0; i < 32; i++)
	{
		seq_printf(m, "%02x", g_system_hash[i]);
	}
	seq_printf(m, "\n");
	if (chk_fail_flag == E_STATUS_FAIL) {
		seq_printf(m, "Errmsg: %s\n", errmsg);
	}
	return 0;
}

static void *syschk_start(struct seq_file *m, loff_t *pos)
{
	return *pos < 1 ? (void *)1 : NULL;
}

static void *syschk_next(struct seq_file *m, void *v, loff_t *pos)
{
	++*pos;
	return NULL;
}

static void syschk_stop(struct seq_file *m, void *v)
{
}

const struct seq_operations syschk_op = {
	.start = syschk_start,
	.next  = syschk_next,
	.stop  = syschk_stop,
	.show  = syschk_show
};

static int syschk_open(struct inode *inode, struct file *file)
{
	return seq_open(file, &syschk_op);
}

static const struct file_operations proc_syschk_operations = {
	.open    = syschk_open,
	.read    = seq_read,
	.llseek  = seq_lseek,
	.release = seq_release,
};

static void __init proc_syschk_init(void)
{
	if(!proc_create("sys_chk", 0, NULL, &proc_syschk_operations))
		pr_err("unable to register /proc/sys_chk\n");
}

/* Run it when verify failed. */
static int fail_process(void)
{
	//todo
	chk_fail_flag = E_STATUS_FAIL;
	ssleep(15);
	kernel_restart(NULL);
	return 0;
}

static int get_rsa_key(rsa_context *rsa)
{
	int ret;
	unsigned char *base = RSAKey;

	hirsa_init( rsa, RSA_PKCS_V15, 0 );
	/* get N and E */
	ret = himpi_read_binary( &rsa->N, base, 0x100);
	ret |= himpi_read_binary( &rsa->E, base + 0x100, 0x100);
	rsa->len = ( himpi_msb( &rsa->N ) + 7 ) >> 3;
	return ret;
}

/* calc hash of SYSTEM_LIST_FILE */
static int sha256_filelist(struct file *filp, int actual_len, unsigned char *hash)
{
	int ret;
	int readlen;
	char *buf = file_data_buf;
	struct crypto_hash *tfm;
	struct hash_desc desc;
	struct scatterlist sg;

	tfm = crypto_alloc_hash("sha256", 0, CRYPTO_ALG_ASYNC);
	if (IS_ERR(tfm)) {
		pr_err("Failed to load transform for sha256: %ld\n", PTR_ERR(tfm));
		return -1;
	}

	desc.tfm = tfm;
	desc.flags = 0;

	ret = crypto_hash_init(&desc);
	if (ret) {
		pr_err("hash init fail.\n");
		return -1;
	}

	/* set read pointer to 0 */
	filp->f_pos = 0;
	while (actual_len > 0) {
		readlen = actual_len > BUF_SIZE ? BUF_SIZE : actual_len;
		actual_len -= readlen;

		ret = filp_fread(buf, readlen, filp);
		if (readlen != ret) {
			pr_err(" read len not equal to request len: %d != %d.\n", ret, readlen);
			return -1;
		}
		sg_init_one(&sg, buf, readlen);
		crypto_hash_update(&desc, &sg, readlen);
	}

	crypto_hash_final(&desc, hash);
	crypto_free_hash(tfm);

	return 0;
}

/* calc hash of array */
static int sha256_array(unsigned char *input, int len, unsigned char *hash)
{
	int ret;
	struct crypto_hash *tfm;
	struct hash_desc desc;
	struct scatterlist sg;

	tfm = crypto_alloc_hash("sha256", 0, CRYPTO_ALG_ASYNC);
	if (IS_ERR(tfm)) {
		pr_err("Failed to load transform for sha256: %ld\n", PTR_ERR(tfm));
		return -1;
	}

	desc.tfm = tfm;
	desc.flags = 0;

	ret = crypto_hash_init(&desc);
	if (ret) {
		pr_err("hash init fail.\n");
		return -1;
	}

	sg_init_one(&sg, input, len);
	crypto_hash_update(&desc, &sg, len);
	crypto_hash_final(&desc, hash);
	crypto_free_hash(tfm);

	return 0;
}

/* verify signature of system list file. */
static int verify_filelist(struct file *filp, int file_size, int *actual_len)
{
	int ret;
	int actual_data_size;
	unsigned char sign[SIG_DATA_LEN];
	unsigned char hash[32];
	rsa_context key;

	ret = get_rsa_key(&key);
	if (ret) {
		pr_err("get rsa key fail.\n");
		kfree(sign);
		return -1;
	}

	/* read actual len */
	filp->f_pos = file_size - 0x2000 + OFFSET_ACTUAL_DATA_SIZE;
	ret = filp_fread((char *)&actual_data_size, 4, filp);
	if (4 != ret) {
		pr_err("file read len (%d) wrong.\n", ret);
		return -1;
	}

	/* read sig data */
	filp->f_pos = file_size - 0x2000 + OFFSET_SIG_DATA;
	ret = filp_fread((char *)sign, SIG_DATA_LEN, filp);
	if (ret != SIG_DATA_LEN) {
		pr_err("file read len (%d) wrong.\n", ret);
		return -1;
	}

	/* calculate hash of SYSTEM_FILE_LIST */
	ret = sha256_filelist(filp, actual_data_size, hash);
	if (ret){
		pr_err("calc hash fail.\n");
		return -1;
	}

	ret = hirsa_pkcs1_verify( &key, RSA_PUBLIC, SIG_RSA_SHA256, 32, hash, sign);

	*actual_len = actual_data_size;
	memcpy(&g_all_partition_hash[96], hash, 32);
	return ret;
}

static char *read_line(char *buf, int buf_len, struct file *fp)
{
	int ret;
	int i = 0;
	mm_segment_t fs;

	fs=get_fs();
	set_fs(KERNEL_DS);
	ret = fp->f_op->read(fp, buf, buf_len, &(fp->f_pos));
	set_fs(fs);

	if (ret <= 0)
		return NULL;

	while(buf[i++] != '\n' && i < ret);

	if(i < ret) {
		fp->f_pos += i-ret;
	}

	if(i < buf_len) {
		buf[i] = 0;
	}
	return buf;
}

/* get filename and hash in a line */
static int get_filename_and_hash(char *buf, char **filename, char **hash)
{
	int i = 0;
	char c;

	*filename = buf;
	while ('\0' != (c = buf[i++])) {
		if (c == '\t') {
			buf[i-1] = '\0';
			*hash = buf + i;
			return 0;
		}
	}

	return -1;
}

static int sha1_padding(CIPHER_HASH_DATA_S *pCipherHashData)
{
	int tmp = 0;
	int i = 0;
	char u8PadLen[8];

	if( NULL == pCipherHashData )
	{
		pr_err("Error! Null pointer input!\n");
		return -1;
	}

	memset(pCipherHashData->u8Padding, 0, sizeof(pCipherHashData->u8Padding));

	tmp = pCipherHashData->u32TotalDataLen % HASH_PAD_MAX_LEN;
	/* 56 = 64 - 8, 120 = 56 + 64 */
	pCipherHashData->u32PaddingLen = (tmp < 56) ? (56 - tmp) : (120 - tmp);
	/* add 8 bytes fix data length */
	pCipherHashData->u32PaddingLen += 8;

	/* Format(binary): {data|1000...00| fix_data_len(bits)} */
	memset(pCipherHashData->u8Padding, 0x80, 1);
	memset(pCipherHashData->u8Padding + 1, 0, pCipherHashData->u32PaddingLen - 1 - 8);
	/* write 8 bytes fix data length */
	memset(u8PadLen, 0, sizeof(u8PadLen));
	tmp = pCipherHashData->u32TotalDataLen;

	for (i = 0; i < 8; i++)
	{
		u8PadLen[i] = ((tmp * 8) >> ((7 - i) * 8)) & 0xff;
	}

	memcpy(pCipherHashData->u8Padding + pCipherHashData->u32PaddingLen - 8, u8PadLen, 8);

	return 0;
}

static int sha1_file(char *filename, unsigned char *hash, CIPHER_HASH_DATA_S *cipher)
{
	int ret, i = 0;
	char *buf;
	struct file *fp;
	struct inode *inode;
	int file_size = 0;
	int copy_times;
	unsigned char sha1_result[SHA1_LEN];

	fp = filp_open(filename, O_RDONLY, 0);
	if(IS_ERR(fp))
	{
		pr_err("open file fail (%ld).\n", PTR_ERR(fp));
		return -1;
	}

	inode=fp->f_dentry->d_inode;
	file_size=inode->i_size;

	buf = (HI_U8 *)(cipher->stMMZBuffer.u32StartVirAddr);
	memset((HI_U8 *)buf, 0, (SIGN_BLOCK_SIZE+128));
	cipher->enShaType = HI_UNF_CIPHER_HASH_TYPE_SHA1;
	cipher->u32TotalDataLen = 0;
	cipher->u32InputDataLen = 0;
	cipher->u32Offset = 0;

	ret = HI_DRV_CIPHER_CalcHashInit(cipher);
	if (ret) {
		pr_err("hash init fail.\n");
		filp_close(fp, NULL);
		return -1;
	}

	copy_times = file_size/SIGN_BLOCK_SIZE;
	for (i=0; i<copy_times; i++) {
		if (kthread_should_stop())
			return 0;

		file_size -= SIGN_BLOCK_SIZE;

		ret = filp_fread(buf, SIGN_BLOCK_SIZE, fp);
		if (SIGN_BLOCK_SIZE != ret) {
			pr_err("read len not equal to request len: %d != %d.\n", ret, SIGN_BLOCK_SIZE);
			filp_close(fp, NULL);
			return -1;
		}

		cipher->u32InputDataLen =  SIGN_BLOCK_SIZE;
		cipher->u32TotalDataLen += SIGN_BLOCK_SIZE;
		cipher->u32Offset = 0;
		HI_DRV_CIPHER_CalcHashUpdate(cipher);
	}

	if (file_size%SIGN_BLOCK_SIZE) {
		ret = filp_fread(buf, file_size, fp);
		if (file_size != ret) {
			pr_err("read len not equal to request len: %d != %d.\n", ret, file_size);
			filp_close(fp, NULL);
			return -1;
		}

		cipher->u32InputDataLen =  file_size;
		cipher->u32TotalDataLen += file_size;
		cipher->u32Offset = file_size;
	}

	sha1_padding(cipher);

	memcpy(buf + cipher->u32Offset, cipher->u8Padding, cipher->u32PaddingLen);
	cipher->u32InputDataLen = cipher->u32Offset + cipher->u32PaddingLen;
	memset(sha1_result, 0, SHA1_LEN);
	cipher->pu8Output = sha1_result;
	HI_DRV_CIPHER_CalcHashFinal(cipher);

	if (memcmp(sha1_result, hash, SHA1_LEN)) {
		return -1;
	}
	return 0;
}

/* verify each file in file_list */
static int verify_files(struct file *filp, int file_len)
{
	int i = 0;
	char *buf = line_buf;
	char *line;
	char *filename;
	char *hash;
	unsigned char val[SHA1_LEN];
	CIPHER_HASH_DATA_S cipher_hash_data;

	/* set read pointer to 0 */
	filp->f_pos = 0;

	memset(&cipher_hash_data, 0, sizeof(cipher_hash_data));

	if (HI_SUCCESS != HI_DRV_MMZ_AllocAndMap("SHA1_VERIFY", NULL, (SIGN_BLOCK_SIZE+128),
		0, (MMZ_BUFFER_S *)&(cipher_hash_data.stMMZBuffer))) {
		pr_err("HI_DRV_MMZ_AllocAndMap SHA1 fail.\n");
		snprintf(errmsg, ERRMSG_LEN, "verify file HI_DRV_MMZ_AllocAndMap fail");
		return -1;
	}

	while ((filp->f_pos < file_len) && (line = read_line(buf, BUF_SIZE, filp))) {
		if (kthread_should_stop()) {
			HI_DRV_MMZ_UnmapAndRelease((MMZ_BUFFER_S *)&cipher_hash_data.stMMZBuffer);
			return 0;
		}

		if (get_filename_and_hash(line, &filename, &hash)) {
			pr_err("get_filename_and_hash return fail.\n");
			snprintf(errmsg, ERRMSG_LEN, "verify file get_filename_and_hash fail");
			return -1;
		}

		for (i = 0; i < SHA1_LEN; i++) {
			val[i] = (unsigned char)simple_strtoul(hash, NULL, 16);
			hash += 3;
		}

		if (sha1_file(filename, val, &cipher_hash_data)) {
			pr_err("SHA1 file(%s) return fail.\n", filename);
			snprintf(errmsg, ERRMSG_LEN, "verify file (%s) fail", filename);
			return -1;
		}

		/* interval time 100ms */
		msleep(100);
	}

	HI_DRV_MMZ_UnmapAndRelease((MMZ_BUFFER_S *)&cipher_hash_data.stMMZBuffer);
	return 0;
}

static int system_verify(void *unused)
{
	int ret;
	int i;
	struct file *filp = NULL;
	struct inode *inode;
	int file_size = 0;
	int actual_len;

	chk_fail_flag = E_STATUS_RUNNING;
	/* alloc data buf */
	if (NULL == (file_data_buf = (char *)kmalloc(2*BUF_SIZE, GFP_KERNEL))) {
		pr_err("malloc buf fail.\n");
		snprintf(errmsg, ERRMSG_LEN, "malloc buf fail");
		goto ERR1;
	}
	line_buf = file_data_buf + BUF_SIZE;

	i = 0;
	while (1) {
		if (kthread_should_stop()) {
			kfree(file_data_buf);
			return 0;
		}

		/* open file: system_list */
		filp = filp_open(SYSTEM_LIST_FILE, O_RDONLY, 0);
		if(!IS_ERR(filp))
			break;
		else {
			pr_err("open file fail (%ld) times: %d.\n", PTR_ERR(filp), i);
		}

		if (i++ > MAX_RETRY_TIMES) {
			pr_err("open file fail.\n");
			snprintf(errmsg, ERRMSG_LEN, "open system_list file fail");
			goto ERR2;
		}
		ssleep(10);
	}

	inode=filp->f_dentry->d_inode;
	file_size=inode->i_size;

	/* file length shoulg be N*8KB */
	if (file_size % 0x2000) {
		pr_err("file length (%x) should align to 8KB.\n", file_size);
		filp_close(filp, NULL);
		snprintf(errmsg, ERRMSG_LEN, "file length not align to 8KB");
		goto ERR2;
	}

	/* RSA2048 + SHA256 */
	ret = verify_filelist(filp, file_size, &actual_len);
	if (ret) {
		pr_err("verify_sign fail.\n");
		filp_close(filp, NULL);
		snprintf(errmsg, ERRMSG_LEN, "verify filelist fail");
		goto ERR2;
	}

	pr_info("actual_len: %x.\n", actual_len);

	/* SHA1 to every file */
	ret = verify_files(filp, actual_len);
	if (ret) {
		pr_err("verify_files fail.\n");
		filp_close(filp, NULL);
		goto ERR2;
	}

	if (!kthread_should_stop()) {
		/* verify success */
		chk_fail_flag = E_STATUS_SUCCESS;
		printk("Verify system files success!\n");

		sha256_array(g_all_partition_hash, 128, g_system_hash);
		printk("g_system_hash:\n");
		for (i = 0; i < 32; i++)
		{
			printk("0x%02x ", g_system_hash[i]);
			if ((i + 1) % 16 == 0)
				printk("\n");
		}
	}
	filp_close(filp, NULL);
	kfree(file_data_buf);
	do_exit(0);
	return 0;

ERR2:
	kfree(file_data_buf);
ERR1:
	fail_process();
	do_exit(0);
	return 0;
}

static int verify_pm_suspend(void)
{
	if ((chk_fail_flag == E_STATUS_RUNNING)
		&& (verify_task)) {
		kthread_stop(verify_task);
		verify_task = NULL;
	}
	return 0;
}

static void verify_pm_resume(void)
{
	if ((chk_fail_flag == E_STATUS_RUNNING)
		&& (!verify_task)) {
		verify_task = kthread_create(system_verify, NULL, "system_chk");
		if (IS_ERR(verify_task)) {
			pr_err("kthread create fail (%ld).\n", PTR_ERR(verify_task));
			snprintf(errmsg, ERRMSG_LEN, "kthread create fail");
			fail_process();
			return;
		}

		wake_up_process(verify_task);
	}
}

static int verify_pm_notifier_func(struct notifier_block *notifier,
		unsigned long pm_event,
		void *unused)
{
	switch (pm_event) {
		case PM_HIBERNATION_PREPARE:
		case PM_SUSPEND_PREPARE:
			verify_pm_suspend();
			break;
		case PM_POST_RESTORE:
			/* Restore from hibernation failed. We need to clean
			 * up in exactly the same way, so fall through. */
		case PM_POST_HIBERNATION:
		case PM_POST_SUSPEND:
			verify_pm_resume();
			break;

		case PM_RESTORE_PREPARE:
		default:
			break;
	}
	return NOTIFY_DONE;
}
int system_verify_init(void)
{
	int ret;
	HI_BOOL CAFlag;

	pr_info("enter system_verify_init!\n");

	if (parse_tag_rsakey()) {
		pr_err("get rsa key fail.\n");
		return -1;
	}

	proc_syschk_init();
	ret = DRV_CA_OTP_V200_GetSCSActive((HI_U32*)&CAFlag);

	if (HI_SUCCESS != ret || CAFlag != HI_TRUE) {
		pr_err("SecureBoot flag not enabled.\n");
		return -1;
	}

	verify_task = kthread_create(system_verify, NULL, "system_chk");
	if (IS_ERR(verify_task)) {
		pr_err("kthread create fail (%ld).\n", PTR_ERR(verify_task));
		snprintf(errmsg, ERRMSG_LEN, "kthread create fail");
		fail_process();
		return -1;
	}

	wake_up_process(verify_task);
	verify_pm_notifier.notifier_call = verify_pm_notifier_func;
	register_pm_notifier(&verify_pm_notifier);
	return 0;
}
