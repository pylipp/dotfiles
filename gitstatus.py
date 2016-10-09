#!/usr/bin/env python3

import subprocess
import os


cmd = "find {} -type d -name .git".format(os.path.expanduser("~"))
gitfiles = subprocess.check_output(cmd.split())
gitfiles = gitfiles.splitlines()
repos = []
ignored_repos = [
        os.path.expanduser(repo) for repo in [
            b"~/.files/.vim",
            b"~/software/ptypy",
            b"~/software/vim",
            b"~/software/ipython"
            ]
        ]

for gitfile in gitfiles:
    repo, ext = os.path.split(gitfile)
    if not ext.endswith(b".git"):
        print(ext)
        continue
    if any([repo.startswith(ign_repo) for ign_repo in ignored_repos]):
        continue
    repos.append(repo)

for repo in repos:
    os.chdir(repo)
    print(repo)
    subprocess.call(["git", "status", "-bs"])
    print()
