import sys
import pathlib
import unittest

SCRIPT_DIR = pathlib.Path(__file__).absolute().parent
sys.path.insert(0, SCRIPT_DIR)
from trl import construct_trello_command


class TrlTests(unittest.TestCase):
    def test_workspace_commands(self):
        for command in ["add-board", "show-boards"]:
            self.assertEqual(
                construct_trello_command(command, []),
                ["trello", command],
            )
