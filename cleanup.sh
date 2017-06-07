#!/bin/bash

set -eu
set -o pipefail

if [[ ! -f mason-config.env ]]; then
    echo "Please run setup.sh first"
    exit 1
fi

# do each time you use the local postgis:
source mason-config.env

if [[ -d ${PGHOST} ]]; then
    echo "removing local pghost: ${PGHOST}"
    rm -rf ${PGHOST}
fi

if [[ -d ${PGTEMP_DIR} ]]; then
    echo "removing local temp dir: ${PGTEMP_DIR}"
    rm -rf ${PGTEMP_DIR}
fi

if [[ -d ${PGDATA} ]]; then
    echo "removing local pgdata: ${PGDATA}"
    rm -rf ${PGDATA}
fi
