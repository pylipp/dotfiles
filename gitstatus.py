#!/usr/bin/env python3 

from subprocess import call
import os

HOME = "/home/metzner/"
repos = ["Documents/dotfiles",
        "Documents/thesis/latex"] 

for repo in repos:
    path = HOME + repo
    print(path)
    os.chdir(path)
    call(["git", "status", "-bs"])
    print()
