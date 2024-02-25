import json

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
@click.option("-h", "--as-header", is_flag=True, default=False, required=False)
def encode(payload: str, algorithm: str, secret: str, as_header: bool):
    token = jwt.encode(
        payload=json.loads(payload),
        key=secret,
        algorithm=algorithm,
    )

    if as_header:
        click.echo(f"Authorization: Bearer {token}")
    else:
        click.echo(token)
