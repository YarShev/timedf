#!/bin/bash -e

# This variable is used to improve performance and its value was obtained during the experiment.
# Each workload can have a different value.
export MODIN_HDK_FRAGMENT_SIZE=32000000

BENCH_NAME="plasticc"
DATA_FILE="${DATASETS_PWD}/plasticc/"

# This benchmark also support -use_xgb True
USE_MODIN_XGB="False"
source $(dirname "$0")/00-run_bench.sh -use_modin_xgb "${USE_MODIN_XGB}"