# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
SHELL := /bin/bash
APP_NAME=jwt

setup: ## Setup uv, bats, and venv
	brew install uv bats-core
	brew tap kaos/shell
	brew install bats-assert
	uv venv --seed

setup-requirements: ## Install requirements for the project
	./scripts/setup-requirements.sh

setup-pre-commit: ## Setup pre-commit and hooks
	./scripts/setup-pre-commit.sh

format: ## Format the code
	ruff format src/ tests/

test: ## Run tests
	pytest -vv --capture=no
	rm tests/bats/*.bats
	python tests/bats/build.py
	bats tests/bats/
