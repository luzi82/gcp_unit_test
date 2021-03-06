#!/bin/bash

set -e

PACKAGE_NAME=gcp_unit_test_ml_engine_general

if [ -f setting.json ]; then
    SETTING_FILE=setting.json
elif [ -f ~/.gcp_unit_test/setting.json ]; then
    SETTING_FILE=~/.gcp_unit_test/setting.json
else
    echo SSUAXFZF setting.json not found
    False
fi

CONFIG_ID=`jq -r '.GCP_CONFIG_ID' ${SETTING_FILE}`
REGION=`jq -r '.GCP_REGION' ${SETTING_FILE}`
BOTO_PATH=`jq -r '.BOTO_PATH' ${SETTING_FILE}`

export BOTO_PATH

PROJECT_ID=$(gcloud config list project --format "value(core.project)" --configuration ${CONFIG_ID})
BUCKET_NAME=${PROJECT_ID}-main

TIMESTAMP=`date +%Y%m%d%H%M%S`
