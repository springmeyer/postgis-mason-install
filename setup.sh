#!/bin/bash

set -eu
set -o pipefail

GDAL_VERSION="2.1.3"
POSTGIS_VERSION="2.3.2-1"
# https://github.com/mapbox/mason/pull/404
MASON_VERSION="b0c4310"

mkdir -p ./mason
curl -sSfL https://github.com/mapbox/mason/archive/${MASON_VERSION}.tar.gz | tar --gunzip --extract --strip-components=1 --exclude="*md" --exclude="test*" --directory=./mason

# do once: install stuff
./mason/mason install libgdal ${GDAL_VERSION}
./mason/mason install postgis ${POSTGIS_VERSION}
./mason/mason link postgis ${POSTGIS_VERSION}


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
GDAL_DATA_VALUE=$(./mason/mason prefix libgdal ${GDAL_VERSION})/share/gdal/
if [[ ! -d ${GDAL_DATA_VALUE} ]]; then
    echo "${GDAL_DATA_VALUE} not found"
    exit 1
fi
echo "export GDAL_DATA=${GDAL_DATA_VALUE}" >> mason-config.env

echo "generated mason-config.env"
