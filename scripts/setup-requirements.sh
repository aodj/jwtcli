#!/usr/bin/env bash

# Setup requirements
# Expected to be run from the root, as ./scripts/setup-requirements.sh
# This is needed because we need ot activate the virtualenv first

source .venv/bin/activate

uv pip compile -o requirements.txt pyproject.toml
uv pip compile -o requirements-dev.txt --extra=dev pyproject.toml
uv pip install --requirement requirements.txt
uv pip install --requirement requirements-dev.txt
rm requirements.txt
rm requirements-dev.txt
