#!/usr/bin/env bash

# Setup requirements
# Expected to be run from the root, as ./scripts/setup-requirements.sh
# This is needed because we need ot activate the virtualenv first

source .venv/bin/activate

# this is expected to be called from the Makefile, hence the $2 and not $1
case $2 in
    (dev)
        uv pip compile -o requirements-dev.txt --extra=dev pyproject.toml
        uv pip install --requirement requirements-dev.txt
        rm requirements-dev.txt
        ;;
    (test)
        uv pip compile -o requirements-test.txt --extra=test pyproject.toml
        uv pip install --requirement requirements-test.txt
        rm requirements-test.txt
        ;;
    (*)
        uv pip compile -o requirements.txt pyproject.toml
        uv pip install --requirement requirements.txt
        rm requirements.txt
        ;;
esac
