#!/bin/bash

# Setup pre-commit.
# Expected to be run from the root, as ./scripts/setup-pre-commit.sh
# This is needed because we need ot activate the virtualenv first

source .venv/bin/activate

pre-commit install
pre-commit install-hooks
