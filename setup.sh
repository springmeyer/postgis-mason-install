#!/bin/bash

set -eu
set -o pipefail

# pull mason via submodule
git submodule update --init

# enable mason as this local path
export MASON_DIR=$(pwd)/mason

# setup config
echo 'export CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"' > mason-config.env
echo 'export PGDATA=${CURRENT_DIR}/local-postgres' >> mason-config.env
echo 'export PGHOST=${CURRENT_DIR}/local-unix-socket' >> mason-config.env
echo 'export PGTEMP_DIR=${CURRENT_DIR}/local-tmp' >> mason-config.env
echo 'export PGPORT=1111' >> mason-config.env
echo 'export PATH=${CURRENT_DIR}/mason_packages/.link/bin/:${PATH}' >> mason-config.env
# this is needed to setup mason, until https://github.com/mapbox/mason/issues/140 is fixed
echo 'export MASON_DIR=$(pwd)/mason' >> mason-config.env

echo "installing gdal, so postgis can access GDAL_DATA"
./mason/mason install gdal 2.0.2
GDAL_DATA_VALUE=$(./mason/mason prefix gdal 2.0.2)/share/gdal/
echo "export GDAL_DATA=${GDAL_DATA_VALUE}" >> mason-config.env

echo "generated mason-config.env"
