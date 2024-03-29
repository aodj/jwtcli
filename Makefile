# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
SHELL := /bin/bash

BATS_TARGET := *.bats
ifneq ($(filter-out setup setup-ci setup-requirements setup-pre-commit format template-bats test bats,$(MAKECMDGOALS)), )
BATS_TARGET := $(filter-out setup setup-ci setup-requirements setup-pre-commit format template-bats test bats,$(MAKECMDGOALS)).bats
endif


setup: ## Setup uv, bats, and venv
	brew install uv bats-core
	brew tap kaos/shell
	brew install bats-assert
	uv venv --seed


setup-ci: ## Setup, but for CI
	curl -LsSf https://astral.sh/uv/install.sh | sh
	uv pip install --system --upgrade --editable .[test]


setup-requirements: ## Install requirements for the project
	./scripts/setup-requirements.sh


setup-dev-requirements: ## Install dev requirements for the project
	./scripts/setup-requirements.sh dev


setup-test-requirements: ## Install test requirements for the project
	./scripts/setup-requirements.sh test


setup-pre-commit: ## Setup pre-commit and hooks
	./scripts/setup-pre-commit.sh


format: ## Format the code
	ruff format src/ tests/


template-bats: ## Render the bats templates
	@./scripts/clean-bats.sh
	python tests/bats/build.py


test: template-bats ## Run tests
	pytest -vv --capture=no
	bats tests/bats/


# run all bats tests using 'make bats'
# or a specific group using the group name 'make bats encode-using-secret'
# group names are given in tests/bats/usecases.yaml
bats: template-bats ## Run specific group of or all bats tests
	bats tests/bats/$(BATS_TARGET)


%:
	@:
