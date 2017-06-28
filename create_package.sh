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


echo ".PHONY: all test install clean" >> Makefile
echo "" >> Makefile
echo "all:" >> Makefile
echo -e "\t@echo Available targets: install, test" >> Makefile
echo "" >> Makefile
echo "install:" >> Makefile
echo -e "\tpip install -U -r requirements.txt -e ." >> Makefile
echo "" >> Makefile
echo "test:" >> Makefile
echo -e "\t@[ -z \$\$VIRTUAL_ENV ] && echo 'Acticate $package_name virtualenv.' || python -m unittest discover" >> Makefile
echo "" >> Makefile
echo "tags:" >> Makefile
echo -e "\tctags -R ." >> Makefile

echo "from setuptools import setup, find_packages

setup(
        name='$package_name',
        version='0.1',
        description='TODO',
        url='http://github.com/pylipp/$package_name',
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
. /usr/local/bin/virtualenvwrapper.sh
mkvirtualenv --python=$python_version $package_name
