#!/bin/bash

set -e

if [ ! -z ${FULL_TEST_TASK_LIST+x} ]; then echo `realpath "$0"` >> ${FULL_TEST_TASK_LIST} ; fi

source ./_env.sh

if [ ! -d env2 ]; then
    virtualenv -p python2 env2
fi

source env2/bin/activate

pip install -U -r requirements.txt

OUTPUT=output

gcloud ml-engine local train \
    --job-dir ${OUTPUT} \
    --module-name ${PACKAGE_NAME}.task \
    --package-path ${PACKAGE_NAME}

JOB_NAME=${PACKAGE_NAME}_py2_${TIMESTAMP}
OUTPUT=gs://${BUCKET_NAME}/${JOB_NAME}

gcloud ml-engine jobs submit training ${JOB_NAME} \
    --job-dir ${OUTPUT} \
    --runtime-version 1.4 \
    --module-name ${PACKAGE_NAME}.task \
    --package-path ${PACKAGE_NAME} \
    --region ${REGION} \
    --stream-logs

if [ ! -z ${FULL_TEST_SUCCESS_LIST+x} ]; then echo `realpath "$0"` >> ${FULL_TEST_SUCCESS_LIST} ; fi
