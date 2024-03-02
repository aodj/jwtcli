from cryptography.hazmat.primitives.asymmetric import ed448
from cryptography.hazmat.primitives.serialization import (
    Encoding,
    PrivateFormat,
    PublicFormat,
    NoEncryption,
)

private_key = ed448.Ed448PrivateKey.generate()

with open("tests/bats/keys/ed448-private.key", "wb") as fp:
    fp.write(
        private_key.private_bytes(
            encoding=Encoding.PEM,
            format=PrivateFormat.PKCS8,
            encryption_algorithm=NoEncryption(),
        )
    )
with open("tests/bats/keys/ed448-public.crt", "wb") as fp:
    fp.write(
        private_key.public_key().public_bytes(
            encoding=Encoding.PEM, format=PublicFormat.SubjectPublicKeyInfo
        )
    )
