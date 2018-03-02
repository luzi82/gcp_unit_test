#!/bin/bash

RESULT=0

pushd ml_engine_general
    ./run.sh || RESULT=1
popd 

exit ${RESULT}
