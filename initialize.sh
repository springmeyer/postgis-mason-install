#!/bin/bash

set -eu
set -o pipefail

if [[ ! -f mason-config.env ]]; then
    echo "Please run setup.sh first"
    exit 1
fi

# do each time you use the local postgis:
source mason-config.env

# do once: create directories to hold postgres data
echo "Creating pghost: ${PGHOST} and temp dir: ${PGTEMP_DIR}"
mkdir ${PGHOST}
mkdir ${PGTEMP_DIR}

# do once: initialize local db cluster
echo "Initializing database cluser at ${PGDATA}"
./mason_packages/.link/bin/initdb
sleep 2

