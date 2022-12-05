#!/bin/bash -eu
cd omniscripts

# Modin_on_hdk
export LD_PRELOAD_OLD=${LD_PRELOAD}
export LD_LIBRARY_PATH_OLD=${LD_LIBRARY_PATH}

export LD_PRELOAD=${CONDA_PREFIX}/envs/${ENV_NAME}/lib/libtbbmalloc_proxy.so.2
export LD_LIBRARY_PATH=${CONDA_PREFIX}/envs/${ENV_NAME}/lib/


./teamcity_build_scripts/33-ny_taxi_modin_on_hdk_20M_records.sh |& tee /results/taxi_hdk.res
./teamcity_build_scripts/30-census_modin_on_hdk.sh |& tee /results/census_hdk.res
./teamcity_build_scripts/34-plasticc_modin_on_hdk.sh |& tee /results/plasticc_hdk.res

export LD_PRELOAD=${LD_PRELOAD_OLD}
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH_OLD}

#Stock pandas
# HDK scripts deactivate conda, so we need to reactivate it again
source ${CONDA_PREFIX}/bin/activate

./teamcity_build_scripts/42-ny_taxi_pandas_20M_records.sh |& tee /results/taxi_pandas.res
./teamcity_build_scripts/41-census_pandas.sh |& tee /results/census_pandas.res
./teamcity_build_scripts/43-plasticc_pandas.sh |& tee /results/plasticc_pandas.res