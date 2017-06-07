#!/bin/bash

set -eu
set -o pipefail

MASON_VERSION="v0.11.1"
GDAL_VERSION="2.1.3"
POSTGIS_VERSION="2.3.2-1"

mkdir -p ./mason
curl -sSfL https://github.com/mapbox/mason/archive/${MASON_VERSION}.tar.gz | tar --gunzip --extract --strip-components=1 --exclude="*md" --exclude="test*" --directory=./mason

# do once: install stuff
./mason/mason install libgdal ${GDAL_VERSION}
GDAL_DATA_VALUE=$(./mason/mason prefix libgdal ${GDAL_VERSION})/share/gdal/
./mason/mason install postgis ${POSTGIS_VERSION}
./mason/mason link postgis ${POSTGIS_VERSION}


if [[ ! -d ${GDAL_DATA_VALUE} ]]; then
    echo "${GDAL_DATA_VALUE} not found (needed for postgis to access GDAL_DATA)"
    exit 1
fi


# setup config
echo 'export CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"' > mason-config.env
echo 'export PGDATA=${CURRENT_DIR}/local-postgres' >> mason-config.env
echo 'export PGHOST=${CURRENT_DIR}/local-unix-socket' >> mason-config.env
echo 'export PGTEMP_DIR=${CURRENT_DIR}/local-tmp' >> mason-config.env
echo 'export PGPORT=1111' >> mason-config.env
echo 'export PATH=${CURRENT_DIR}/mason_packages/.link/bin:${PATH}' >> mason-config.env
echo "export GDAL_DATA=${GDAL_DATA_VALUE}" >> mason-config.env
echo "generated mason-config.env"
