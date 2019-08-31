#!/bin/bash

# Utility script to create a vanilla Python package

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 path [python_version]"
    exit
fi

package_name=`basename $1`
package_dir=$1
python_version="/usr/bin/python3.5"
if [[ $# -eq 2 ]]; then
    python_version=$2
fi
mail_address="beth.aleph@yahoo.de"

mkdir $package_dir
cd $package_dir

mkdir $package_name
mkdir test

echo "# $package_name" > README.md
echo "__version__ = '0.1'" > $package_name/__init__.py

version_command="'import $package_name; print($package_name.__version__)'"

echo "\
VERSION=\$(shell python -c $version_command)

.PHONY: all test install tags upload tag publish coverage lint

all:
	@echo 'Available targets: install, test, upload, tag, publish, coverage, lint'

install:
	pip install -U -r requirements.txt -e .

test:
	python setup.py test

upload: README.md setup.py
	rm -f dist/*
	python setup.py bdist_wheel --universal
	twine upload dist/*

tag:
	git tag v\$(VERSION)
	git push --tags

publish: tag upload

coverage:
	coverage run --source $package_name setup.py test
	coverage report
	coverage html

lint:
	flake8 $package_name test" > Makefile


echo "from setuptools import setup, find_packages
from $package_name import __version__

with open('README.md') as readme:
    long_description = readme.read()

setup(
    name='$package_name',
    version=__version__,
    description='TODO',
    long_description=long_description,
    url='https://github.com/pylipp/$package_name',
    author='Philipp Metzner',
    author_email='$mail_address',
    license='GPLv3',
    #classifiers=[],
    packages=find_packages(exclude=['test', 'doc']),
    entry_points = {
        'console_scripts': ['$package_name = $package_name.main:main']
        },
    install_requires=[]
)" > setup.py

git init
git add -A
git config user.email $mail_address 
git config user.name pylipp
git ci -m "Initial commit."
# git create $package_name

export WORKON_HOME=$HOME/.virtualenvs
. "$WORKON_HOME"/virtualenvwrapper/bin/virtualenvwrapper.sh
mkvirtualenv --python=$python_version $package_name
pip install pudb ptpython flake8 twine
deactivate
