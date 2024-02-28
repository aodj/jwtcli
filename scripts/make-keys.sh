#!/usr/bin/env bash

# rsa keypair
# https://stackoverflow.com/a/44474607
openssl genrsa -out tests/bats/keys/rsa-keypair.pem 2048
openssl rsa -in tests/bats/keys/rsa-keypair.pem -pubout -out tests/bats/keys/rsa-keypair-public.crt
openssl pkcs8 -topk8 -inform PEM -outform PEM -nocrypt -in tests/bats/keys/rsa-keypair.pem -out tests/bats/keys/rsa-keypair-private.key
