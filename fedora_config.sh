#!/bin/bash

# CONFIGURANDO ZRAM NO SISTEMA
cat /proc/swaps

# CONFIGURANDO ZSWAP NO SISTEMA
cat /sys/module/zswap/parameters/enabled

	cd /etc/default
	sudo cp grub grub.bkp
	sudo nano /etc/default/grub
