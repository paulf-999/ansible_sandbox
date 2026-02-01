#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status (fail fast).

# Load reusable shell script vars & functions
source src/sh/shell_utils.sh

#=======================================================================
# Variables
#=======================================================================

# inputs are fetched from YAML config file
CONFIG_FILE="inputs/docker_config.yml"

# Ensure yq file exist
if ! command -v yq >/dev/null 2>&1; then
    log_message "${ERROR}" "yq is not installed or not on PATH. Install yq before running this script."
    exit 1
fi

CONTAINER_NAME="$(yq -r '.docker.container_name' "${CONFIG_FILE}")"
IMAGE="$(yq -r '.docker.image' "${CONFIG_FILE}")"

# Repo root on the host (assumes script is run from repo root)
REPO_ROOT="$(pwd)"
REQUIREMENTS_FILE="${REPO_ROOT}/requirements.txt"

# Where to mount the repo inside the container
CONTAINER_REPO_DIR="/opt/git_repos/dmt-cac-ansible_sandbox"

#=======================================================================
# Functions
#=======================================================================

create_container() {
    log_message "${DEBUG}" "Creating VM (Docker container) to host webserver (Docker container name = '${CONTAINER_NAME}')"

    # Remove any existing container
    docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true

    # Create container, expose host port 80 -> container port 80
    # Mount the repo so the container can access requirements.txt and scripts
    docker run -d \
        --name "${CONTAINER_NAME}" \
        -p 80:80 \
        -v "${REPO_ROOT}:${CONTAINER_REPO_DIR}" \
        "${IMAGE}" \
        sleep infinity >/dev/null
}

install_python_and_tools() {
    log_message "${DEBUG}" "Installing Python inside the VM"

    docker exec "${CONTAINER_NAME}" bash -c '
      set -e
      apt-get update -y
      apt-get install -y python3 python3-apt python3-pip python3-venv curl ca-certificates git
      python3 -m pip install --upgrade pip
    ' >/dev/null 2>&1
}

install_python_requirements() {
    if [[ ! -f "${REQUIREMENTS_FILE}" ]]; then
        log_message "${ERROR}" "requirements.txt not found at: ${REQUIREMENTS_FILE}"
        exit 1
    fi

    log_message "${DEBUG}" "Installing Python libraries from requirements.txt inside the container"

    docker exec "${CONTAINER_NAME}" bash -c "
      set -e
      python3 -m pip install -r '${CONTAINER_REPO_DIR}/requirements.txt'
    " >/dev/null 2>&1
}

#=======================================================================
# Main script logic
#=======================================================================

create_container
install_python_and_tools
install_python_requirements

log_message "${INFO}" "Docker container '${CONTAINER_NAME}' is ready for use by Ansible."
