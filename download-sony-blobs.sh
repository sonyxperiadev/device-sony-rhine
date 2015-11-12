#!/bin/sh

ZIP_FILE="SW_binaries_for_Xperia_AOSP_L_MR1_v11.zip"
URL_BASE="http://dl-developer.sonymobile.com/eula"
EULA_URL="${URL_BASE}/SW_binaries_for_Xperia_AOSP_Lollipop_MR1_v11_EULA.html"

NOW=$(($(date +"%s") * 1000))
TOMORROW=$((${NOW} + 1000 * 60 * 60 * 24 * 1))

DIR=download-rhine

mkdir -p ${DIR} && (cd ${DIR} && sha1sum --status -c ../device/sony/rhine/blobs-sha1.txt) ||
(
  SDK_URL="${URL_BASE}/$(curl -s ${EULA_URL} | grep 'var sdk' | cut -d"'" -f2)${TOMORROW}"

  REPLY=""

  if [ ! -x "$(which w3m)" ]; then
    echo "No W3M. Please either install W3M or download Sony blobs from ${EULA_URL}"
    echo "and place the ${ZIP_FILE} file at ${PWD}/${DIR}/"
    exit 1
  fi;

  w3m -o display_charset=UTF-8 ${EULA_URL} | head -n-15; echo "TO DOWNLOAD SONY BLOBS, PLEASE TYPE: I ACCEPT THE LICENSE" && read REPLY

  if [ "${REPLY}" != "I ACCEPT THE LICENSE" ]; then
      echo "LICENSE NOT ACCEPTED, NOT DOWNLOADING BLOBS."
      exit 1
  fi;

  echo "Downloading to ${ZIP_FILE} ..."

  curl -s --cookie "dw_accepted=true" ${SDK_URL} -o ${DIR}/${ZIP_FILE}
)

unzip -u ${DIR}/${ZIP_FILE}
