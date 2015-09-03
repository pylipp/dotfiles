#!/usr/bin/env python3 

from subprocess import call
import os

repos = ["~/Documents/dotfiles",
        "~/Documents/thesis/latex"
        ] 

for repo in repos:
    path = os.path.expanduser(repo)
    print(path)
    os.chdir(path)
    call(["git", "status", "-bs"])
    print()
