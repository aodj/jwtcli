#!/usr/bin/env bash

# https://stackoverflow.com/a/17902999
path=tests/bats/*.bats
files=$(shopt -s nullglob dotglob; echo ${path})
if (( ${#files} )); then
    rm tests/bats/*.bats
fi
