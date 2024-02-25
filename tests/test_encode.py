from jwtcli.cli import cli

from click.testing import CliRunner


def test_encode_basic():
    runner = CliRunner()
    result = runner.invoke(cli, ["encode", '{"foo": "bar"}'])
    assert (
        result.output
        == "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmb28iOiJiYXIifQ._NaFhGu8tCCgBKksGBA6ADwRdKx3e9GES_KyF4A5phE\n"
    )


def test_encode_default_algorithm():
    runner = CliRunner()
    result = runner.invoke(cli, ["encode", '{"foo": "bar"}', "--algorithm", "HS256"])
    assert (
        result.output
        == "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmb28iOiJiYXIifQ._NaFhGu8tCCgBKksGBA6ADwRdKx3e9GES_KyF4A5phE\n"
    )


def test_encode_default_command():
    runner = CliRunner()
    result = runner.invoke(cli, ['{"foo": "bar"}'])
    assert (
        result.output
        == "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmb28iOiJiYXIifQ._NaFhGu8tCCgBKksGBA6ADwRdKx3e9GES_KyF4A5phE\n"
    )


def test_encode_as_header():
    runner = CliRunner()
    result = runner.invoke(cli, ["encode", '{"foo": "bar"}', "--as-header"])
    assert (
        result.output
        == "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmb28iOiJiYXIifQ._NaFhGu8tCCgBKksGBA6ADwRdKx3e9GES_KyF4A5phE\n"
    )
