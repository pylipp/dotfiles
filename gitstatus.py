#!/usr/bin/env python3 

from subprocess import call
import os 
import sys

repos = {}
errors = []

def main(repolist):
    if _readInRepos():
        # Display status of repos specified as command line arguments.
        if len(repolist):
            seq = repolist 
        # Display status of all repos in the repos-dictionary.
        else:
            seq = repos.keys()
        for name in seq:
            _printGitStatus(name)
    if len(errors):
        print("---ERRORS---")
        for e in errors:
            print(e)

def _printGitStatus(name):
    """ Queries and prints status of the git repo 'name'. """
    path = repos.get(name.strip().upper())
    if path is None:
        errors.append("Git repo '{name}' not specified.".format(name=name))
        return
    fullpath = os.path.expanduser(path)
    try:
        os.chdir(fullpath)
        print("{} at {}".format(name.upper(), path))
        call(["git", "status", "-bs"])
        #TODO: Raise error if path is not under source control
        print()
    except (OSError) as e:
        errors.append(e)

def _readInRepos():
    """ Returns true if 'personalrepos' file exists. """
    try:
        with open("personalrepos", 'r') as repoFile:
            for i, line in enumerate(repoFile):
                # Skip comments and empty lines
                if not line.startswith('#') and len(line.strip()):
                    try:
                        name, path = line.split(';')
                        if isinstance(name, str) and isinstance(path, str):
                            repos[name.strip().upper()] = path.strip()
                        else:
                            raise ValueError("name or path are incorrectly specified.")
                    except (ValueError) as e:
                        errors.append("Error while parsing line {}: {}".format(i,e))
                        continue
        return True
    except (IOError) as e:
        errors.append(e)
        return False


main(sys.argv[1:])
