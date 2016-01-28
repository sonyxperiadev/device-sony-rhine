#!/bin/bash

# Copyright (C) 2010 The Android Open Source Project
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

if [ -f ../../../vendor/qcom/proprietary/firmware/qcom-modem-firmware.mk ]; then
    echo "You already have the proprietary blobs. Nice!"
    exit 0
fi

if [ -z "${DEVICE}" ]; then
    echo "You need to define the DEVICE."
    exit 1
fi;

if [ -z "${MANUFACTURER}" ]; then
    echo "You need to define the MANUFACTURER."
    exit 1
fi;

if [ -z "${STOCK}" ]; then
    echo "You need to define the STOCK factory image."
    exit 1
fi;

if [ ! -f "../../../vendor/${MANUFACTURER}/${DEVICE}/${DEVICE}-partial.mk" ]; then
    pushd ../../../
        device/${MANUFACTURER}/rhine/download-sony-blobs.sh || exit 1
    popd
fi;

if [[ -z "${ANDROIDFS_DIR}" ]]; then
    ANDROIDFS_DIR=../../../backup-${DEVICE}
fi

if [[ ! -d ${ANDROIDFS_DIR}/system/etc/firmware/modem.mdt ]]; then
    echo Backing up necessary files to backup-${DEVICE}
    adb root &&
    adb wait-for-device &&
    adb pull /system/build.prop ${ANDROIDFS_DIR}/system/build.prop &&
    adb pull /system/etc/firmware ${ANDROIDFS_DIR}/system/etc/firmware
fi

echo Pulling files from ${ANDROIDFS_DIR}
DEVICE_BUILD_ID=`cat ${ANDROIDFS_DIR}/system/build.prop | grep ro.build.display.id | sed -e 's/ro.build.display.id=//' | tr -d '\n\r'`

if [[ "${DEVICE_BUILD_ID}" != "${STOCK}" ]]; then
    echo Invalid system backup - Wrong base version found: ${DEVICE_BUILD_ID}.
    echo
    echo Do this:
    echo 1. Delete backup-${DEVICE}
    echo 2. Flash your device with a ${STOCK} FTF.
    echo 3. Try building again
    exit -1
fi

DEVICE_BLOBS_DIR=vendor/$MANUFACTURER/$DEVICE-blobs
BASE_PROPRIETARY_DEVICE_DIR=$DEVICE_BLOBS_DIR/proprietary
PROPRIETARY_DEVICE_DIR=../../../$DEVICE_BLOBS_DIR/proprietary

mkdir -p $PROPRIETARY_DEVICE_DIR

for NAME in etc/firmware
do
    mkdir -p $PROPRIETARY_DEVICE_DIR/$NAME
done

BLOBS_LIST=../../../$DEVICE_BLOBS_DIR/$DEVICE-vendor-blobs.mk

(cat << EOF) | sed s/__DEVICE__/$DEVICE/g | sed s/__MANUFACTURER__/$MANUFACTURER/g > ../../../$DEVICE_BLOBS_DIR/$DEVICE-vendor-blobs.mk
# Copyright (C) 2010 The Android Open Source Project
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

# Prebuilt libraries that are needed to build open-source libraries
PRODUCT_COPY_FILES :=

# All the blobs
PRODUCT_COPY_FILES += \\
EOF

# copy_file
# pull file from the device and adds the file to the list of blobs
#
# $1 = src/dst name
# $2 = directory path on device
# $3 = directory name in $PROPRIETARY_DEVICE_DIR
copy_file()
{
    echo Pulling \"$1\"
    if [[ -z "${ANDROIDFS_DIR}" ]]; then
        NAME=$1
        adb pull /$2/$1 $PROPRIETARY_DEVICE_DIR/$3/$2
    else
        NAME=`basename ${ANDROIDFS_DIR}/$2/$1`
        rm -f $PROPRIETARY_DEVICE_DIR/$3/$NAME
        cp ${ANDROIDFS_DIR}/$2/$NAME $PROPRIETARY_DEVICE_DIR/$3/$NAME
    fi

    if [[ -f $PROPRIETARY_DEVICE_DIR/$3/$NAME ]]; then
        echo   $BASE_PROPRIETARY_DEVICE_DIR/$3/$NAME:$2/$NAME \\ >> $BLOBS_LIST
    else
        echo Failed to pull $1. Giving up.
        exit -1
    fi
}

# copy_files
# pulls a list of files from the device and adds the files to the list of blobs
#
# $1 = list of files
# $2 = directory path on device
# $3 = directory name in $PROPRIETARY_DEVICE_DIR
copy_files()
{
    for NAME in $1
    do
        copy_file "$NAME" "$2" "$3"
    done
}

# copy_files_glob
# pulls a list of files matching a pattern from the device and
# adds the files to the list of blobs
#
# $1 = pattern/glob
# $2 = directory path on device
# $3 = directory name in $PROPRIETARY_DEVICE_DIR
# $4 = list of files to exclude
copy_files_glob()
{
    DEVICE_PATH=$2
    BLOB_PATH=$3

    EXCLUDED=""
    if [ ! -z "$4" ]; then
        for EXCL in $4
        do
            echo "Excluding $EXCL"
            EXCLUDED="$EXCLUDED -not -name ${EXCL}"
        done
    fi;

    for NAME in $(find "${ANDROIDFS_DIR}/${DEVICE_PATH}/" -maxdepth 1 -type f -name "$1" ${EXCLUDED})
    do
        copy_file "`basename $NAME`" "${DEVICE_PATH}" "${BLOB_PATH}"
    done
}
