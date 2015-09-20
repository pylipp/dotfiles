#!/usr/bin/env python3 

from subprocess import call
import os 
import sys

repos = {}
repos["dotfiles"] = "~/Dokumente/dotfiles"
repos["mscthesis"] = "~/Dokumente/Documents/master project/thesis/mscthesis"
repos["pythir"] = "~/Dropbox/code/pythir"
repos["financeager"] = "~/Dropbox/code/financeager"

def main(repolist):
    # Display status of repos specified as command line arguments.
    if len(repolist):
        seq = repolist 
    # Display status of all repos in the repos-dictionary.
    else:
        seq = repos.keys()
    for name in seq:
        printGitStatus(name)

def printGitStatus(name):
    path = repos.get(name)
    if path is None:
        print("Git repo '{name}' not specified.".format(name=name))
        return
    path = os.path.expanduser(path)
    print(name.upper())
    os.chdir(path)
    call(["git", "status", "-bs"])
    print()

main(sys.argv[1:])
