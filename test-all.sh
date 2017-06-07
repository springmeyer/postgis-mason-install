#!/bin/bash

set -eu
set -o pipefail

function echo_step    { >&2 echo -e "\033[1m\033[36m* $1\033[0m"; }
function echo_success { >&2 echo -e "\033[1m\033[32m* $1\033[0m"; }

# echo setting up mason
echo_step "Setting up mason"
./setup.sh && echo_success "Setup complete"
echo_step "Initializing db and extensions"
./initialize.sh && echo_success "Initialization complete"
echo_step "Running server"
./run.sh && echo_success "Run complete"
echo_step "Stopping server"
./stop.sh && echo_success "Stop complete"

# should be able to cleanup all data and re-initialize and run again cleanly
echo_step "Cleaning up all data"
./cleanup.sh && echo_success "cleanup complete"
echo_step "Running through initialization, start, and stop again"
./initialize.sh
./run.sh
./stop.sh
./cleanup.sh && echo_success "Second run through complete"

echo "Success!"
