#ifndef __PLATSMP__H__
#define __PLATSMP__H__

extern struct smp_operations hifone_smp_ops;

void hifone_secondary_startup(void);

void slave_cores_power_up(int cpu);

#endif

