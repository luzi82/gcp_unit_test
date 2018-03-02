#!/bin/bash

set -e

. ./_env.sh

gcloud ml-engine jobs submit training ${JOB_NAME} \
    --job-dir ${OUTPUT} \
    --runtime-version 1.4 \
    --module-name ${PACKAGE_NAME}.task \
    --package-path ${PACKAGE_NAME} \
    --region ${REGION} \
    --config config.yaml
