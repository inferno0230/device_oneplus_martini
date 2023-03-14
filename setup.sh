#!/bin/bash

cd ../../..

if [ -d "vendor/oneplus/martini" ]; then
    read -p "The 'vendor/oneplus/martini' directory already exists. Do you want to overwrite it? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf vendor/oneplus/martini
    else
        echo "Skipping vendor/oneplus/martini"
        continue
    fi
fi
echo "Cloning vendor_oneplus_martini"
git clone git@github.com:inferno0230/vendor/oneplus/martini

if [ -d "kernel/oneplus/martini" ]; then
    read -p "The 'kernel/oneplus/martini' directory already exists. Do you want to overwrite it? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf kernel/oneplus/martini
    else
        echo "Skipping kernel/oneplus/martini"
        continue
    fi
fi
echo "Cloning kernel_oneplus_martini"
git clone git@github.com:inferno0230/kernel/oneplus/martini

if [ -d "hardware/oplus" ]; then
    read -p "The 'hardware/oplus' directory already exists. Do you want to overwrite it? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf hardware/oplus
    else
        echo "Skipping hardware/oplus"
        continue
    fi
fi
echo "Cloning android_hardware_oplus"
git clone git clone git@github.com:AOSPA/android_hardware_oplus hardware/oplus

if [ -d "packages/resources/devicesettings" ]; then
    read -p "The 'packages/resources/devicesettings' directory already exists. Do you want to overwrite it? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf packages/resources/devicesettings
    else
        echo "Skipping packages/resources/devicesettings"
        continue
    fi
fi
echo "Cloning android_packages_resources_devicesettings"
git clone https://github.com/AOSPA/android_packages_resources_devicesettings packages/resources/devicesettings

if [ -d "vendor/qcom/opensource/audio-hal/primary-hal" ]; then
    read -p "The 'vendor/qcom/opensource/audio-hal/primary-hal' directory already exists. Do you want to overwrite it? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf vendor/qcom/opensource/audio-hal/primary-hal
    else
        echo "Skipping vendor/qcom/opensource/audio-hal/primary-hal"
        continue
    fi
fi
echo "Cloning android_hardware_qcom_audio"
git clone git@github.com:AOSPA/android_hardware_qcom_audio -b topaz-888 vendor/qcom/opensource/audio-hal/primary-hal

if [ -d "hardware/qcom/gps" ]; then
    read -p "The 'hardware/qcom/gps' directory already exists. Do you want to overwrite it? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf hardware/qcom/gps
    else
        echo "Skipping hardware/qcom/gps"
        continue
    fi
fi
echo "Cloning android_hardware_qcom_gps"
git clone git@github.com:AOSPA/android_hardware_qcom_gps -b topaz-888 hardware/qcom/gps

if [ -d "hardware/qcom/media" ]; then
    read -p "The 'hardware/qcom/media' directory already exists. Do you want to overwrite it? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf hardware/qcom/media
    else
        echo "Skipping hardware/qcom/media"
        continue
    fi
fi
echo "Cloning android_hardware_qcom_media"
git clone git@github.com:AOSPA/android_hardware_qcom_media -b topaz-888 hardware/qcom/media

if [ -d "vendor/nxp/opensource/halimpl" ]; then
    read -p "The 'vendor/nxp/opensource/halimpl' directory already exists. Do you want to overwrite it? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf vendor/nxp/opensource/halimpl
    else
        echo "Skipping vendor/nxp/opensource/halimpl"
        continue
    fi
fi
echo "Cloning android_vendor_nxp_opensource_halimpl"
git clone git@github.com:AOSPA/android_vendor_nxp_opensource_halimpl vendor/nxp/opensource/halimpl -b topaz-SN100X-legacy

if [ -d "vendor/nxp/opensource/hidlimpl" ]; then
    read -p "The 'vendor/nxp/opensource/hidlimpl' directory already exists. Do you want to overwrite it? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf vendor/nxp/opensource/hidlimpl
    else
        echo "Skipping vendor/nxp/opensource/hidlimpl"
        continue
    fi
fi
echo "Cloning android_vendor_nxp_opensource_hidlimpl"
git clone git@github.com:AOSPA/android_vendor_nxp_opensource_hidlimpl vendor/nxp/opensource/hidlimpl -b topaz-SN100X-legacy


