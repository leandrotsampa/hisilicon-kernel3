This software is used to calculate the DDR hash value when standby.

1.Compilation
	make clean;make		Compile the software. ddr_wakeup_check.bin is generated.
	
2.Usage
	- Use the tool hex2char.exe to convert the ddr_wakeup_check.bin to output.txt
	- Copy the output.txt to the source\kernel\linux-3.10.y\arch\arm\mach-s40\ for linux version 3.10.
		For linux version 3.18, please copy the output.txt to the source\kernel\linux-3.18.y.patch\drivers\hisilicon\soc.
	- Recompile the kernel