# Copyright (C) 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Platform path
PLATFORM_COMMON_PATH := device/sony/rhine

$(call inherit-product, device/sony/common/common.mk)

SOMC_PLATFORM := rhine

SONY_ROOT := $(PLATFORM_COMMON_PATH)/rootdir

# Media
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/system/etc/audio_policy.conf:system/etc/audio_policy.conf \
    $(SONY_ROOT)/system/etc/media_codecs.xml:system/etc/media_codecs.xml \
    $(SONY_ROOT)/system/etc/media_profiles.xml:system/etc/media_profiles.xml

# Qualcom WiFi
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/system/etc/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
    $(SONY_ROOT)/system/etc/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf

# IDC
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/system/usr/idc/clearpad.idc:system/usr/idc/clearpad.idc \
    $(SONY_ROOT)/system/usr/idc/max1187x_touchscreen_0.idc:system/usr/idc/max1187x_touchscreen_0.idc

# Keylayout
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/system/usr/keylayout/msm8974-taiko-mtp-snd-card_Button_Jack.kl:system/usr/keylayout/msm8974-taiko-mtp-snd-card_Button_Jack.kl \
    $(SONY_ROOT)/system/usr/keylayout/atmel_mxt_ts.kl:system/usr/keylayout/atmel_mxt_ts.kl \
    $(SONY_ROOT)/system/usr/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(SONY_ROOT)/system/usr/keylayout/mhl-rcp.kl:system/usr/keylayout/mhl-rcp.kl

# Device Specific Hardware
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml

# Platform Init
PRODUCT_PACKAGES += \
    fstab.rhine \
    init.rhine.pwr

# NFC packages
PRODUCT_PACKAGES += \
    com.android.nfc_extras \
    libnfc_jni \
    libnfc \
    Nfc

# Audio
PRODUCT_PACKAGES += \
    audio.primary.msm8974

# GFX
PRODUCT_PACKAGES += \
    copybit.msm8974 \
    gralloc.msm8974 \
    hwcomposer.msm8974 \
    memtrack.msm8974

# GPS
PRODUCT_PACKAGES += \
    gps.msm8974

# CAMERA
PRODUCT_PACKAGES += \
    camera.msm8974

# Keymaster
PRODUCT_PACKAGES += \
    keystore.msm8974

# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qualcomm.bt.hci_transport=smd

# Qualcom FMRadio
PRODUCT_PACKAGES += \
    FMRadio

# Telephony Packages (AOSP)
PRODUCT_PACKAGES += \
    InCallUI \
    Stk

# RILD
PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/vendor/lib/libril-qc-qmi-1.so \
    ril.subscription.types=NV,RUIM

# system prop for opengles version
# 196608 is decimal for 0x30000 to
# report major/minor versions as 3
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=196608

# aDSP sensors
## max rate
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qti.sensors.max_accel_rate=false \
    ro.qti.sensors.max_gyro_rate=false \
    ro.qti.sensors.max_mag_rate=false \
    ro.qti.sensors.max_geomag_rotv=50

## sensor type
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qti.sdk.sensors.gestures=false \
    ro.qti.sensors.pedometer=false \
    ro.qti.sensors.step_detector=false \
    ro.qti.sensors.step_counter=false \
    ro.qti.sensors.pam=false \
    ro.qti.sensors.scrn_ortn=false \
    ro.qti.sensors.smd=true \
    ro.qti.sensors.game_rv=false \
    ro.qti.sensors.georv=false \
    ro.qti.sensors.cmc=false \
    ro.qti.sensors.bte=false \
    ro.qti.sensors.fns=false \
    ro.qti.sensors.qmd=false \
    ro.qti.sensors.amd=false \
    ro.qti.sensors.rmd=false \
    ro.qti.sensors.vmd=false \
    ro.qti.sensors.gtap=false \
    ro.qti.sensors.tap=false \
    ro.qti.sensors.facing=false \
    ro.qti.sensors.tilt=false \
    ro.qti.sensors.tilt_detector=false \
    ro.qti.sensors.dpc=false \
    ro.qti.sensors.wu=false
