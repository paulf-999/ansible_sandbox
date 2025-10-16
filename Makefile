SHELL = /bin/sh

#================================================================
# Usage
#================================================================
# make deps      # install dependencies
# make install   # end-to-end setup (create & prepare containers)
# make run       # run the sample playbook
# make clean     # cleanup containers

#=======================================================================
# Variables
#=======================================================================
.EXPORT_ALL_VARIABLES:

# load variables from separate file
include src/make/variables.mk

#=======================================================================
# Targets
#=======================================================================
all: deps install

deps:
	@echo "${INFO}\nCalled makefile target 'deps'. Download any required libraries.${COLOUR_OFF}\n"
	@echo "${DEBUG}Installing Python deps with pip.${COLOUR_OFF}\n"
	@pip install -r requirements.txt

install:
	@echo "${INFO}\nCalled makefile target 'install'. Completed sandbox setup.\n${COLOUR_OFF}"
	@echo "${INFO}Create & prepare Docker nodes (node1, node2) using Ubuntu.${COLOUR_OFF}"
	@bash src/sh/create_docker_containers.sh

run:
	@echo "${INFO}\nCalled makefile target 'run'. Launch Ansible playbook.${COLOUR_OFF}\n"
	@ansible-playbook -i inventory.ini test_playbook.yml

clean:
	@echo "${INFO}\nCalled makefile target 'clean'. Restoring the repository to its initial state.${COLOUR_OFF}\n"
	@bash src/sh/destroy_docker_containers.sh || true

.PHONY: all deps install run clean
