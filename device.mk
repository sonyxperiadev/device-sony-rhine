# Copyright 2014 The Android Open Source Project
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

$(call inherit-product, device/sony/msm8974_common/common.mk)

SOMC_PLATFORM := rhine

DEVICE_PACKAGE_OVERLAYS += \
    device/sony/rhine/overlay

SONY_ROOT = device/sony/rhine/rootdir/
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)fstab.rhine:root/fstab.rhine \
    $(SONY_ROOT)init.rhine.rc:root/init.rhine.rc \
    $(SONY_ROOT)init.rhine.usb.rc:root/init.rhine.usb.rc \
    $(SONY_ROOT)init.rhine.pwr.rc:root/init.rhine.pwr.rc \
    $(SONY_ROOT)system/etc/init.rhine.bt.sh:system/etc/init.rhine.bt.sh \
	$(SONY_ROOT)system/etc/init.rhine.wifi.sh:system/etc/init.rhine.wifi.sh \
    $(SONY_ROOT)system/etc/audio_policy.conf:system/etc/audio_policy.conf \
    $(SONY_ROOT)system/etc/gps.conf:system/etc/gps.conf \
    $(SONY_ROOT)system/etc/media_codecs.xml:system/etc/media_codecs.xml \
    $(SONY_ROOT)system/etc/media_profiles.xml:system/etc/media_profiles.xml \
    $(SONY_ROOT)system/etc/nfcee_access.xml:system/etc/nfcee_access.xml \
    $(SONY_ROOT)system/etc/snd_soc_msm/snd_soc_msm_2x:system/etc/snd_soc_msm/snd_soc_msm_2x \
    $(SONY_ROOT)system/etc/snd_soc_msm/snd_soc_msm_Taiko:system/etc/snd_soc_msm/snd_soc_msm_Taiko \
    $(SONY_ROOT)system/etc/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf \
    $(SONY_ROOT)system/etc/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
    $(SONY_ROOT)system/usr/idc/clearpad.idc:system/usr/idc/clearpad.idc \
    $(SONY_ROOT)system/usr/idc/max1187x_touchscreen_0.idc:system/usr/idc/max1187x_touchscreen_0.idc \
    $(SONY_ROOT)system/usr/keylayout/msm8974-taiko-mtp-snd-card_Button_Jack.kl:system/usr/keylayout/msm8974-taiko-mtp-snd-card_Button_Jack.kl \
    $(SONY_ROOT)system/usr/keylayout/Vendor_045e_Product_0719.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl \
    $(SONY_ROOT)system/usr/keylayout/Vendor_046d_Product_c21a.kl:system/usr/keylayout/Vendor_046d_Product_c21a.kl \
    $(SONY_ROOT)system/usr/keylayout/Vendor_046d_Product_c21d.kl:system/usr/keylayout/Vendor_046d_Product_c21d.kl \
    $(SONY_ROOT)system/usr/keylayout/Vendor_0810_Product_0002.kl:system/usr/keylayout/Vendor_0810_Product_0002.kl \
    $(SONY_ROOT)system/usr/keylayout/atmel_mxt_ts.kl:system/usr/keylayout/atmel_mxt_ts.kl \
    $(SONY_ROOT)system/usr/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(SONY_ROOT)system/usr/keylayout/mhl-rcp.kl:system/usr/keylayout/mhl-rcp.kl \
    $(SONY_ROOT)ueventd.rhine.rc:root/ueventd.rhine.rc \
    $(SONY_ROOT)/init.recovery.rhine.rc:root/init.recovery.rhine.rc
	
# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:system/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:system/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml

#Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.primary.msm8974 \
    audio.r_submix.default \
    audio.usb.default \
    libaudio-resampler \
    libacdbloader \
    libacdbmapper \
    libaudcal \
    libaudioalsa \
    libdiag

# for audio.primary.msm8974
PRODUCT_PACKAGES += \
    libtinyalsa \
    libtinycompress \
    libaudioroute

#lights
PRODUCT_PACKAGES += \
    lights.rhine

#GPS
PRODUCT_PACKAGES += \
    libloc_api_v02 \
    libloc_adapter \
    libloc_eng \
    libgps.utils \
    gps.msm8974

#NFC
PRODUCT_PACKAGES += \
    com.android.nfc_extras \
    libnfc_jni \
    libnfc \
    Nfc

#WLAN
PRODUCT_PACKAGES += \
    hostapd \
    libwpa_client \
    wpa_supplicant \
    wpa_supplicant.conf

#OSS
PRODUCT_PACKAGES += \
    thermanager \
    wcnss_addr \
    bt_addr

# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qualcomm.bt.hci_transport=smd

# Platform specific default properties
#
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp
