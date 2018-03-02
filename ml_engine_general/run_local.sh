#!/bin/bash

set -e

. ./_env.sh

gcloud ml-engine local train \
    --job-dir ${OUTPUT} \
    --module-name ${PACKAGE_NAME}.task \
    --package-path ${PACKAGE_NAME}
