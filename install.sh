#!/bin/bash

set -eu
set -o pipefail

if [[ ! -f mason-config.env ]]; then
    echo "Please run setup.sh first"
    exit 1
fi

# do each time you use the local postgis:
source mason-config.env

# do once: install stuff
./mason/mason install postgis 2.2.2
./mason/mason link postgis 2.2.2

# do once: create directories to hold postgres data
echo "Creating pghost: ${PGHOST} and temp dir: ${PGTEMP_DIR}"
mkdir ${PGHOST}
mkdir ${PGTEMP_DIR}

# do once: initialize local db cluster
echo "Initializing database cluser at ${PGDATA}"
./mason_packages/.link/bin/initdb
sleep 2

# do each time you use this local postgis:
# start server and background (NOTE: if running interactively hit return to fully background and get your prompt back)
./mason_packages/.link/bin/postgres -k $PGHOST > postgres.log &
sleep 2

# set up postgres to know about local temp directory
./mason_packages/.link/bin/psql postgres -c "CREATE TABLESPACE temp_disk LOCATION '${PGTEMP_DIR}';"
./mason_packages/.link/bin/psql postgres -c "SET temp_tablespaces TO 'temp_disk';"

# add plpython support if you need
./mason_packages/.link/bin/psql postgres -c "CREATE PROCEDURAL LANGUAGE 'plpythonu' HANDLER plpython_call_handler;"

# create postgis enabled db
./mason_packages/.link/bin/createdb template_postgis -T postgres
./mason_packages/.link/bin/psql template_postgis -c "CREATE EXTENSION postgis;"
./mason_packages/.link/bin/psql template_postgis -c "SELECT PostGIS_Full_Version();"
./mason_packages/.link/bin/psql template_postgis -c "CREATE EXTENSION hstore"

echo "Fully bootstrapped template_postgis and server is now running"
echo "To stop server do:"
echo "    source mason-config.env && ./mason_packages/.link/bin/pg_ctl -w stop"
