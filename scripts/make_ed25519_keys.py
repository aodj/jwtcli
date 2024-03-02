from cryptography.hazmat.primitives.asymmetric import ed25519
from cryptography.hazmat.primitives.serialization import (
    Encoding,
    PrivateFormat,
    PublicFormat,
    NoEncryption,
)

private_key = ed25519.Ed25519PrivateKey.generate()

with open("tests/bats/keys/ed25519-private.key", "wb") as fp:
    fp.write(
        private_key.private_bytes(
            encoding=Encoding.PEM,
            format=PrivateFormat.PKCS8,
            encryption_algorithm=NoEncryption(),
        )
    )
with open("tests/bats/keys/ed25519-public.crt", "wb") as fp:
    fp.write(
        private_key.public_key().public_bytes(
            encoding=Encoding.PEM, format=PublicFormat.SubjectPublicKeyInfo
        )
    )
