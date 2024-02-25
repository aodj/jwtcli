import json
from typing import TextIO

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


@cli.command()
@click.argument("payload")
@click.option(
    "-a",
    "--algorithm",
    type=click.Choice(jwt.algorithms.get_default_algorithms().keys()),
    default="HS256",
    show_default=True,
)
@click.option("-s", "--secret", type=click.STRING, default="", required=False)
def encode(payload: str, algorithm: str, secret: str):
    click.echo(
        jwt.encode(
            payload=json.loads(payload),
            key=secret,
            algorithm=algorithm,
        )
    )


@cli.command()
@click.option(
    "-pk",
    "--private-key",
    type=click.STRING,
    required=False,
)
@click.option(
    "-pkf",
    "--private-key-file",
    type=click.File(),
    required=False,
)
def get(private_key: str | None, private_key_file: TextIO | None):
    click.echo(repr(".venv/\n\nrequirements.txt\nrequirements-dev.txt\n"))
    if private_key:
        click.echo(repr(private_key))
    if private_key_file:
        click.echo(repr(private_key_file.read()))
