import json
import sys
from cryptography.hazmat.primitives.serialization import (
    load_pem_private_key,
    load_pem_public_key,
)
from typing import Optional, TextIO

import click
from click_default_group import DefaultGroup
import jwt
import jwt.algorithms


@click.group(
    cls=DefaultGroup,
    default="encode",
    default_if_no_args=True,
)
def cli():
    pass


def check_for_pipe(ctx, param, value):
    # if we have a value, use it
    if value:
        return value
    # check to see if there's a piped in value
    if value is None and not sys.stdin.isatty():
        return sys.stdin.read().strip()


def convert_key_strings_to_bytes(input: str) -> bytes:
    # We need to convert the input to the correct format:
    # a) It needs to be bytes and not a string, hence the `.encode()`
    # b) We need to ensure line breaks are correctly handled.
    #    The input given is 'foo\nbar' which when encoded becomes
    #    b'foo\\nbar' so the replace is to correct for that.
    return input.encode().replace(b"\\n", b"\n")


key_based_algorithms = (
    "rs256",
    "rs384",
    "rs512",
    "es256",
    "es256k",
    "es384",
    "es512",
    "ps256",
    "ps384",
    "ps512",
    "eddsa",
)


@cli.command()
@click.argument("payload", callback=check_for_pipe, required=False)
@click.option(
    "-a",
    "--algorithm",
    type=click.Choice(
        jwt.algorithms.get_default_algorithms().keys(), case_sensitive=False
    ),
    default="HS256",
    show_default=True,
)
@click.option("-h", "--as-header", is_flag=True, default=False, required=False)
@click.option("-s", "--secret", type=click.STRING, default="", required=False)
@click.option("-pk", "--private-key", type=click.STRING, default="", required=False)
@click.option("-pkf", "--private-key-file", type=click.File(), required=False)
@click.option("-p", "--password", type=click.STRING, default=None, required=False)
def encode(
    payload: str,
    algorithm: str,
    secret: str,
    as_header: bool,
    private_key: str,
    private_key_file: TextIO,
    password: Optional[str],
):
    if algorithm.lower() in key_based_algorithms:
        # need to ensure we have the necessary arguments
        assert private_key or private_key_file

        if private_key:
            secret = load_pem_private_key(
                convert_key_strings_to_bytes(private_key), password=password
            )
        elif private_key_file:
            secret = load_pem_private_key(
                private_key_file.read().encode(), password=password
            )

    token = jwt.encode(
        payload=json.loads(payload),
        key=secret,
        algorithm=algorithm,
    )

    if as_header:
        click.echo(f"Authorization: Bearer {token}")
    else:
        click.echo(token)


@cli.command()
@click.argument("value", callback=check_for_pipe, required=False)
@click.option(
    "-a",
    "--algorithm",
    type=click.Choice(
        jwt.algorithms.get_default_algorithms().keys(), case_sensitive=False
    ),
    default="HS256",
    show_default=True,
)
@click.option("-s", "--secret", type=click.STRING, default="", required=False)
@click.option("-pk", "--public-key", type=click.STRING, default="", required=False)
@click.option("-pkf", "--public-key-file", type=click.File(), required=False)
def decode(
    value: str,
    algorithm: str,
    secret: str,
    public_key: str,
    public_key_file: TextIO,
):
    if algorithm.lower() in key_based_algorithms:
        assert public_key or public_key_file

        if public_key:
            secret = load_pem_public_key(convert_key_strings_to_bytes(public_key))
        elif public_key_file:
            secret = load_pem_public_key(public_key_file.read().encode())

    click.echo(
        jwt.decode(
            jwt=value,
            key=secret,
            algorithms=[algorithm],
        )
    )
