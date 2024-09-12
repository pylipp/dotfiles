"""Wrapper around trello-cli.
Invoke via `trl`. All commands and options are forwarded.

Setup trello-cli
- run: yarn global add trello-cli
- run: trello  # creates config file and instructs where to get app key from
- insert app key in config file
- run: trello  # instructs where to get credentials from
- run: trello set-auth <credentials>
"""
import subprocess
import sys
import pathlib
import webbrowser
import json
import os

# Config content (board names are keys)
# - lists: list of list names
# - labels: dict of label IDs and names
with open(pathlib.Path.home() / ".config" / "trl_config.json") as config_file:
    DEFAULT_BOARD = os.getenv("TRL_BOARD")
    if DEFAULT_BOARD is None:
        print("DEFAULT_BOARD not set")
        LABELS = []
        LISTS = []
    else:
        try:
            config = json.load(config_file)["boards"]
            board_config = config[DEFAULT_BOARD]
            LABELS = board_config["labels"]
            LISTS = board_config["lists"]
        except KeyError as e:
            print(e)
            raise SystemExit("trl_config.json found but incomplete.")


def parse_cli():
    # First arg is command, followed by arbitrary options
    if len(sys.argv) > 1:
        return sys.argv[1], sys.argv[2:]
    # Fallback to help if no command specified
    return "--help", []


def main():
    command, options = parse_cli()
    trello_cmd = construct_trello_command(command, options)
    print(" ".join(trello_cmd))
    print()
    subprocess.run(trello_cmd)


def construct_trello_command(command, options):
    trello_cmd = ["trellod", command]

    if "-h" in options or "--help" in options:
        pass

    elif command in ["card:assigned-to", "list:archive"]:
        # no --board nor --list option
        pass

    elif command == "card:browse":
        # not implemented
        pass

    elif command.startswith("list"):
        trello_cmd.extend(["--board", DEFAULT_BOARD])

    elif command.startswith("card"):  # create, delete, move, show, list, assign
        trello_cmd.extend(["--board", DEFAULT_BOARD])
        source_list = select(elements=LISTS, prompt="From list: ")
        trello_cmd.extend(["--list", source_list])

        if command == "card:move":
            trello_cmd.extend(["--to", select(elements=LISTS, prompt="To list: ")])
        elif command == "card:create":
            title = input("Card title: ").strip()
            trello_cmd.extend(["--name", title])
            for label in select(
                elements=LABELS.values(), prompt="Label(s): ", multi=True
            ):
                trello_cmd.extend(["--label", label])

        if command in ["card:create", "card:list"]:
            trello_cmd.extend(options)
            return trello_cmd

        # move, show, assign, delete must also select card name
        proc = subprocess.run(
            ["trellod", "card:list", "--board", DEFAULT_BOARD, "--list", source_list],
            capture_output=True,
        )
        # Output are lines of "<CARD NAME> (ID: ...)"
        cards = [line.split(" (ID:")[0] for line in proc.stdout.decode().splitlines()]
        trello_cmd.extend(["--card", select(elements=cards, prompt="Card: ")])

    trello_cmd.extend(options)
    return trello_cmd


def select(*, elements, prompt="Select list: ", multi=False):
    try:
        command = ["fzf", "--height=20", f"--prompt={prompt}"]
        if multi:
            command.append("--multi")

        proc = subprocess.run(
            command,
            input=bytes("\n".join(elements), encoding="utf-8"),
            stdout=subprocess.PIPE,
        )
        raw_output = proc.stdout.decode()
        if multi:
            return [line.strip() for line in raw_output.splitlines()]
        return raw_output.strip()

    except Exception as e:
        print(e)
        list_names = "\n".join([f"{i:2d}: {name}" for i, name in enumerate(elements)])
        list_rank = input(f"{list_names}\n{prompt}")
        return elements[int(list_rank)]
