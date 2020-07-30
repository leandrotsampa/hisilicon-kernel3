/*$$$!!Warning: Huawei key information asset. No spread without permission.$$$*/
/*CODEMARK:EG4uRhTwMmgcVFBsBnYHCDadN5jJKSuVyxmmaCmKFU6eJEbB2fyHF9weu4/jer/hxLHb+S1e
E0zVg4C3NiZh4SXu1DUPt3BK64ZJx2SaroRGHNiiHF+WHQB7TpwAx/T6Y4I3Wkp4oP+C2K8t
/5koJPsX6LzmZA6hNoH347lCOqFjkssF5fB1nIVSv67wSkidHv0iDxYc2lSsAuwAuUpFOvB4
S1TddpZ0DIfEUuomHoTV9ahgNGOGmsnvABUtP6kv2CpSHG7u6F/vXGpbE93o8Q==#*/
/*$$$!!Warning: Deleting or modifying the preceding information is prohibited.$$$*/
 #include <asm/unistd.h>

#include <linux/module.h>
//#include <linux/config.h>
#include <linux/errno.h>
#include <linux/miscdevice.h>
#include <linux/fcntl.h>
#include <linux/init.h>
#include <linux/delay.h>
#include <linux/proc_fs.h>
#include <linux/workqueue.h>
#include <linux/ioport.h>
#include <linux/interrupt.h>
#if 1
#include <linux/semaphore.h>
#else
#include <asm/semaphore.h>
#endif
#include <linux/wait.h>
#include <asm/uaccess.h>
#include <asm/io.h>

struct file *kfile_open(const char *filename, int flags, int mode)
{
    struct file *filp = filp_open(filename, flags, mode);
    return (IS_ERR(filp)) ? NULL : filp;
}

void kfile_close(struct file *filp)
{
    if (filp)
        filp_close(filp, NULL);
}

int kfile_read(char *buf, unsigned int len, struct file *filp)
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

int kfile_write(char *buf, int len, struct file *filp)
{
    int writelen;
    mm_segment_t oldfs;

    if (NULL == buf)
    {
        return -ENOENT;
    }

    if (filp == NULL)
        return -ENOENT;

    if (filp->f_op->write == NULL)
        return -ENOSYS;

    if (((filp->f_flags & O_ACCMODE) & (O_WRONLY | O_RDWR)) == 0)
        return -EACCES;

    oldfs = get_fs();
    set_fs(KERNEL_DS);
    writelen = filp->f_op->write(filp, buf, len, &filp->f_pos);
    set_fs(oldfs);

    return writelen;
}

int kfile_seek(loff_t offset, int origin, struct file *filp)
{
    int seeklen;
    mm_segment_t oldfs;

    if (filp == NULL)
        return -ENOENT;

    if (filp->f_op->llseek == NULL)
        return -ENOSYS;

    if (((filp->f_flags & O_ACCMODE) & (O_RDONLY | O_RDWR)) != 0)
        return -EACCES;

    oldfs = get_fs();
    set_fs(KERNEL_DS);
    seeklen = filp->f_op->llseek(filp, offset, origin);
    set_fs(oldfs);

    return seeklen;
}


void dump(unsigned char data[], int len)
{
    int i;
    for(i=0; i<len; i++)
    {
    }
}














