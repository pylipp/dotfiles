#!/usr/bin/env python3 

from subprocess import call
import os 
import sys

repos = {}

def main(repolist):
    _readInRepos()
    # Display status of repos specified as command line arguments.
    if len(repolist):
        seq = repolist 
    # Display status of all repos in the repos-dictionary.
    else:
        seq = repos.keys()
    for name in seq:
        _printGitStatus(name)

def _printGitStatus(name):
    path = repos.get(name)
    if path is None:
        print("Git repo '{name}' not specified.".format(name=name))
        return
    path = os.path.expanduser(path)
    print(name.upper())
    os.chdir(path)
    call(["git", "status", "-bs"])
    print()

def _readInRepos():
    with open("personalrepos", 'r') as repoFile:
        for i, line in enumerate(repoFile):
            # Skip comments and empty lines
            if not line.startswith('#') and len(line.strip()):
                try:
                    name, path = line.split(';')
                    if isinstance(name, str) and isinstance(path, str):
                        repos[name.strip()] = path.strip()
                    else:
                        raise ValueError("name or path are incorrectly specified.")
                except (ValueError) as e:
                    print("Error while parsing line {}: {}".format(i,e))
                    continue


main(sys.argv[1:])
