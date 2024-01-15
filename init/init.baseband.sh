#! /vendor/bin/sh

# Set baseband properties from /vendor/firmware_mnt/verinfo/ver_info.txt
setprop gsm.version.baseband $(cat /vendor/firmware_mnt/ver*/* | grep '"modem":' | awk -F'"' '{print $4}')
