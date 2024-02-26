import yaml
from jinja2 import Environment, FileSystemLoader

if __name__ == "__main__":
    environment = Environment(loader=FileSystemLoader("tests/bats/"))
    template = environment.get_template("usecases.j2")

    test_cases = {}
    with open("tests/bats/usecases.yaml") as handle:
        test_cases = yaml.safe_load(handle.read())

    for group, cases in test_cases.items():
        body = template.render(cases=cases)
        with open(f"tests/bats/{group}.bats", "w") as output:
            output.write(body)
