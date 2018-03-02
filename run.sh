#!/bin/bash

export FULL_TEST_TASK_LIST=${PWD}/task_list.log
export FULL_TEST_SUCCESS_LIST=${PWD}/success_list.log

rm -rf ${FULL_TEST_TASK_LIST} ${FULL_TEST_SUCCESS_LIST}
touch ${FULL_TEST_TASK_LIST}
touch ${FULL_TEST_SUCCESS_LIST}

pushd ml_engine_general
    ./run.sh
popd 

RESULT=0
diff ${FULL_TEST_TASK_LIST} ${FULL_TEST_SUCCESS_LIST} || RESULT=1

exit ${RESULT}
