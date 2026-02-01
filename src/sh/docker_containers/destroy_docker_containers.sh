#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status (fail fast).

# Load reusable shell script vars & functions
source src/sh/shell_utils.sh

# inputs are fetched from YAML config file
CONFIG_FILE="inputs/docker_config.yml"
CONTAINER_NAME=$(yq -r '.docker.container_name' "$CONFIG_FILE")

#=======================================================================
# Main script logic
#=======================================================================

log_message "${DEBUG}" "Removing VM (Docker container: '${CONTAINER_NAME}') used to host webserver "
docker rm -f node1 2>/dev/null || true
