#!/usr/bin/env bash

# rsa keypair
# https://stackoverflow.com/a/44474607
openssl genrsa 2048 -out tests/bats/keys/rsa.pem
openssl pkcs8 -topk8 -inform PEM -outform PEM -nocrypt -in tests/bats/keys/rsa.pem -out tests/bats/keys/rsa-private.key
openssl rsa -in tests/bats/keys/rsa-private.key -pubout -out tests/bats/keys/rsa-public.crt


# es256 keypair
# when done under openssl es256 uses prime256v1
# https://blog.frickjack.com/2021/04/sign-and-verify-jwt-with-es256.html
# https://connect2id.com/products/nimbus-jose-jwt/openssl-key-generation
openssl ecparam -genkey -name prime256v1 -noout -out tests/bats/keys/es256.pem
openssl pkcs8 -topk8 -inform PEM -outform PEM -nocrypt -in tests/bats/keys/es256.pem -out tests/bats/keys/es256-private.key
openssl ec -in tests/bats/keys/es256-private.key -pubout -out tests/bats/keys/es256-public.crt


# es256k keypair
openssl ecparam -genkey -name secp256k1 -noout -out tests/bats/keys/es256k.pem
openssl pkcs8 -topk8 -inform PEM -outform PEM -nocrypt -in tests/bats/keys/es256k.pem -out tests/bats/keys/es256k-private.key
openssl ec -in tests/bats/keys/es256k-private.key -pubout -out tests/bats/keys/es256k-public.crt


# es384 keypair
openssl ecparam -genkey -name secp384r1 -noout -out tests/bats/keys/es384.pem
openssl pkcs8 -topk8 -inform PEM -outform PEM -nocrypt -in tests/bats/keys/es384.pem -out tests/bats/keys/es384-private.key
openssl ec -in tests/bats/keys/es384-private.key -pubout -out tests/bats/keys/es384-public.crt


# es512 keypair
openssl ecparam -genkey -name secp521r1 -noout -out tests/bats/keys/es512.pem
openssl pkcs8 -topk8 -inform PEM -outform PEM -nocrypt -in tests/bats/keys/es512.pem -out tests/bats/keys/es512-private.key
openssl ec -in tests/bats/keys/es512-private.key -pubout -out tests/bats/keys/es512-public.crt


# ps256
openssl genpkey -algorithm rsa-pss -pkeyopt rsa_keygen_bits:2048 -pkeyopt rsa_pss_keygen_md:sha256 -pkeyopt rsa_pss_keygen_mgf1_md:sha256 -pkeyopt rsa_pss_keygen_saltlen:32 -out tests/bats/keys/ps256.pem
openssl pkcs8 -topk8 -inform PEM -outform PEM -nocrypt -in tests/bats/keys/ps256.pem -out tests/bats/keys/ps256-private.key
openssl ec -in tests/bats/keys/ps256-private.key -pubout -out tests/bats/keys/ps256-public.crt


# ps384
openssl genpkey -algorithm rsa-pss -pkeyopt rsa_keygen_bits:2048 -pkeyopt rsa_pss_keygen_md:sha384 -pkeyopt rsa_pss_keygen_mgf1_md:sha384 -pkeyopt rsa_pss_keygen_saltlen:32 -out tests/bats/keys/ps384.pem
openssl pkcs8 -topk8 -inform PEM -outform PEM -nocrypt -in tests/bats/keys/ps384.pem -out tests/bats/keys/ps384-private.key
openssl ec -in tests/bats/keys/ps384-private.key -pubout -out tests/bats/keys/ps384-public.crt


# ps512
openssl genpkey -algorithm rsa-pss \
    -pkeyopt rsa_keygen_bits:2048 \
    -pkeyopt rsa_pss_keygen_md:sha512 \
    -pkeyopt rsa_pss_keygen_mgf1_md:sha512 \
    -pkeyopt rsa_pss_keygen_saltlen:32 \
    -out tests/bats/keys/ps512.pem
openssl pkcs8 -topk8 -inform PEM -outform PEM -nocrypt -in tests/bats/keys/ps512.pem -out tests/bats/keys/ps512-private.key
openssl ec -in tests/bats/keys/ps512-private.key -pubout -out tests/bats/keys/ps512-public.crt


# Ed25519 (EdDSA)
python make_ed25519_keys.py


# Ed448 (EdDSA)
python make_ed448_keys.py
