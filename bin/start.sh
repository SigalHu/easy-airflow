#!/bin/sh

cd `dirname $0`
BIN_DIR=`pwd`

cd ..
PROJECT_DIR=`pwd`
LOG_DIR="${PROJECT_DIR}/logs"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export AIRFLOW_HOME="${PROJECT_DIR}/config"

source activate
conda activate airflow

airflow initdb
airflow webserver -p 8080 -D --pid "${BIN_DIR}/airflow-webserver.pid" \
        --stdout "${LOG_DIR}/airflow-webserver.out" --stderr "${LOG_DIR}/airflow-webserver.err" \
        -l "${LOG_DIR}/airflow-webserver.log"
airflow scheduler -D --pid "${BIN_DIR}/airflow-scheduler.pid" \
        --stdout "${LOG_DIR}/airflow-scheduler.out" --stderr "${LOG_DIR}/airflow-scheduler.err" \
        -l "${LOG_DIR}/airflow-scheduler.log"
