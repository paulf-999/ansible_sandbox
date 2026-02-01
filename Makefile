SHELL = /bin/sh

#================================================================
# Usage
#================================================================
# make deps       # install Python deps (requirements.txt) + Galaxy deps (requirements.yml)
# make install    # create & prepare Docker containers
# make run        # run playbooks/site.yml against inventories/dev
# make plan       # dry-run (check mode)
# make clean      # remove containers

#=======================================================================
# Variables
#=======================================================================
.EXPORT_ALL_VARIABLES:

-include .env

# Load colours/messages and any shared vars
include src/make/variables.mk

#=======================================================================
# Targets
#=======================================================================
all: deps install

deps:
	@pip3 install -r requirements.txt

install:
	@echo "${INFO}\nCalled makefile target 'install'. Create & prepare Docker containers (Docker container used to mimic a hosted VM).${COLOUR_OFF}"
	@bash src/sh/docker_containers/create_docker_containers.sh

run: env-check
	@echo "${INFO}\nCalled makefile target 'run'. Launch Ansible playbook.${COLOUR_OFF}"
	@ansible-playbook -i inventories/sandbox/inventory.ini playbooks/site.yml

# Check that required environment variables are set
env-check:
	@set -a; \
	if [ -f .env ]; then . "./.env"; fi; \
	set +a; \
	if [ -z "$$GIT_PAT_TOKEN" ]; then \
		echo "ERROR: GIT_PAT_TOKEN is not set."; \
		echo "Add it to .env, e.g.:"; \
		echo "  GIT_PAT_TOKEN=ghp_your_real_token_here"; \
		exit 1; \
	fi

clean:
	@echo "${INFO}\nCalled makefile target 'clean'. Restoring the repository to its initial state.${COLOUR_OFF}"
	@bash src/sh/docker_containers/destroy_docker_containers.sh || true

.PHONY: all deps install run clean
