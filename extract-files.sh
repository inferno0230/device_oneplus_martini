#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=martini
VENDOR=oneplus

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
        odm/etc/camera/CameraHWConfiguration.config)
            sed -i "/SystemCamera = / s/1;/0;/g" "${2}"
            ;;
        product/etc/sysconfig/com.android.hotwordenrollment.common.util.xml)
            sed -i "s/\/my_product/\/product/" "${2}"
            ;;
        system_ext/lib64/libwfdnative.so)
            sed -i "s/android.hidl.base@1.0.so/libhidlbase.so\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00/" "${2}"
            ;;
        vendor/etc/media_lahaina/video_system_specs.json)
            sed -i "/max_retry_alloc_output_timeout/ s/1000/0/" "${2}"
            ;;
        vendor/lib/libgui1_vendor.so)
            "${PATCHELF}" --replace-needed "libui.so" "libui-v30.so" "${2}"
            ;;
        vendor/lib64/hw/com.qti.chi.override.so)
            "${SIGSCAN}" -p "45 B8 05 94" -P "1F 20 03 D5" -f "${2}"
            ;;
        vendor/lib64/vendor.qti.hardware.camera.postproc@1.0-service-impl.so)
            "${SIGSCAN}" -p "23 0B 00 94" -P "1F 20 03 D5" -f "${2}"
            ;;
        vendor/bin/hw/vendor.qti.hardware.vibrator.service)
            "${PATCHELF}" --replace-needed "android.hardware.vibrator-V1-ndk_platform.so" "android.hardware.vibrator-V1-ndk.so" "${2}"
            ;;
        vendor/lib64/vendor.qti.hardware.vibrator.impl.so)
            "${PATCHELF}" --replace-needed "android.hardware.vibrator-V1-ndk_platform.so" "android.hardware.vibrator-V1-ndk.so" "${2}"
            ;;
        vendor/lib64/hw/com.qti.chi.override.so)
            "${SIGSCAN}" -p "45 B8 05 94" -P "1F 20 03 D5" -f "${2}"
            ;;
        odm/lib/liblvimfs_wrapper.so|odm/lib64/libCOppLceTonemapAPI.so|odm/lib64/libaps_frame_registration.so|vendor/lib64/libalsc.so)
            "${PATCHELF}" --replace-needed "libstdc++.so" "libstdc++_vendor.so" "${2}"
            ;;
        vendor/bin/init.kernel.post_boot-lahaina.sh)
            sed -i "s/uag/schedutil/" "${2}"
            ;;
        odm/lib/libdlbdsservice_v3_6.so | odm/lib/libstagefright_soft_ddpdec.so | odm/lib/libstagefrightdolby.so | odm/lib64/libdlbdsservice_v3_6.so)
            "${PATCHELF}" --replace-needed "libstagefright_foundation.so" "libstagefright_foundation-v33.so" "${2}"
            ;;
    esac
}

# Initialize the helper for device
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"

