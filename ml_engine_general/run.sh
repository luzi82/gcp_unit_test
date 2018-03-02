#!/bin/bash

set -e

source ./_env.sh

if [ ! -d env ]; then
    virtualenv -p python3 env
fi

source env/bin/activate

pip install -U -r requirements.txt

OUTPUT=output

gcloud ml-engine local train \
    --job-dir ${OUTPUT} \
    --module-name ${PACKAGE_NAME}.task \
    --package-path ${PACKAGE_NAME}

OUTPUT=gs://${BUCKET_NAME}/${JOB_NAME}

gcloud ml-engine jobs submit training ${JOB_NAME} \
    --job-dir ${OUTPUT} \
    --runtime-version 1.4 \
    --module-name ${PACKAGE_NAME}.task \
    --package-path ${PACKAGE_NAME} \
    --region ${REGION} \
    --config config.yaml \
    --stream-logs
