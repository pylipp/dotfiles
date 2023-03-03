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
# - move_lists: dict of list aliases and list IDs
try:
    with open(pathlib.Path.home() / ".config" / "trl_config.json") as config_file:
        config = json.load(config_file)["boards"]
        DEFAULT_BOARD = os.getenv("TRL_BOARD")
        board_config = config[DEFAULT_BOARD]
        LABELS = board_config["labels"]
        LISTS = board_config["lists"]
        MOVE_LISTS = board_config["move_lists"]
except KeyError as e:
    print(e)
    raise SystemExit("trl_config.json found but incomplete.")


WORKSPACE_COMMANDS = [
    "add-board",
    "show-boards",
    "card-assign",  # card ID/name/URL
    "card-details",  # card ID/name/URL
    "move-card",  # card list
]
BOARD_COMMANDS = [
    "add-list",
    "show-labels",
    "show-lists",
]
LIST_COMMANDS = [
    "add-card",  # -l LIST(name) -g LABELS
    "show-cards",  # -l LIST(name)
    "delete-card",  # -l LIST(name)
]


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
    trello_cmd = ["trello", command]

    if "-h" in options or "--help" in options:
        pass

    elif command == "move-card":
        for flag, list_id in MOVE_LISTS.items():
            try:
                options.remove(flag)
                options.append(list_id)
                break
            except ValueError:
                pass

    elif command == "move-all-cards":
        trello_cmd.extend(["-b", DEFAULT_BOARD, "-c", DEFAULT_BOARD])
        trello_cmd.extend(["-l", select_list("Select source list: ")])
        trello_cmd.extend(["-d", select_list("Select destination list: ")])

    elif command in BOARD_COMMANDS:
        trello_cmd.extend(["-b", DEFAULT_BOARD])

    elif command in LIST_COMMANDS:
        # Select list and add default board
        list_name = select_list()
        label_options = select_labels() if command == "add-card" else []
        trello_cmd.extend(["-b", DEFAULT_BOARD, "-l", list_name] + label_options)

    elif command == "browse-card":
        webbrowser.open(f"https://trello.com/c/{options[0]}")
        sys.exit(0)

    trello_cmd.extend(options)
    return trello_cmd


def select_list(prompt="Select list: "):
    try:
        proc = subprocess.run(
            ["fzf", f"--prompt={prompt}"],
            input=bytes("\n".join(LISTS), encoding="utf-8"),
            stdout=subprocess.PIPE,
        )
        return proc.stdout.decode().strip()
    except Exception as e:
        print(e)
        list_names = "\n".join([f"{i:2d}: {name}" for i, name in enumerate(LISTS)])
        list_rank = input(f"{list_names}\n{prompt}")
        return LISTS[int(list_rank)]


def select_labels():
    label_ids = sorted(LABELS.keys())
    label_names = "\n".join([f"{i:2d}: {LABELS[id]}" for i, id in enumerate(label_ids)])
    raw_label_ranks = input(f"{label_names}\nPlease select labels, comma-separated: ")
    try:
        label_ranks = [int(r) for r in raw_label_ranks.split(",")]
        return ["-g", ",".join([label_ids[r] for r in label_ranks])]
    except ValueError:
        # Fallback if no or invalid selection made
        return []
