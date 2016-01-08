# Copyright (C) 2015-2016 Nicolas Lamirault <nicolas.lamirault@gmail.com>

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

APP = hyperion-nomad
VERSION = 0.1.0

SHELL := /bin/bash

VAGRANT = vagrant

DOCKER = "docker"

NOMAD_URI = https://releases.hashicorp.com/nomad
NOMAD_VERSION=0.2.0

PACKER ?= packer

TERRAFORM = ?= terraform

NO_COLOR=\033[0m
OK_COLOR=\033[32;01m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m

OUTPUT=bin

all: help

help:
	@echo -e "$(OK_COLOR) ==== [$(APP)] [$(VERSION)]====$(NO_COLOR)"
	@echo -e "$(WARN_COLOR)- init$(NO_COLOR)    : Initialize environment$(NO_COLOR)"

clean:
	rm -fr bin

configure:
	@mkdir -p ./bin

.PHONY: nomad
nomad: configure
	@echo -e "$(OK_COLOR)[$(APP)] Download Nomad$(NO_COLOR)"
	curl --silent -o nomad-${NOMAD_VERSION}.zip -L ${NOMAD_URI}/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip && \
		unzip -d bin nomad-${NOMAD_VERSION}.zip && \
		chmod +x $(OUTPUT)/nomad && \
		rm -fr nomad-${NOMAD_VERSION}.zip

.PHONY: init
init: nomad

