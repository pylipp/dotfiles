#!/bin/bash 

if [[ $# -ne 1 ]]; then
    echo "Usage: backup.bash DESTINATION"
    exit
fi

cd ~

#udiskctl mount -b /dev/sdb2
destination=$1/ubuntu16-04-backup

# does not matter whether destination has a trailing slash or not
echo "Backing up to $destination..."

# trailing slash to copy subfolders of HOME
# don't use pattern with starting slash
sudo rsync -azv --progress --delete --delete-excluded \
    --exclude $USER/.adobe \
    --exclude .cache \
    --exclude .cargo \
    --exclude .compiz \
    --exclude .dbus \
    --exclude .dropbox* \
    --exclude .gnome2* \
    --exclude .gradle \
    --exclude .java \
    --exclude .macromedia \
    --exclude .m2 \
    --exclude .oracle_jre_usage \
    --exclude .zcompdump* \
    --exclude "VirtualBox VMs" \
    --exclude build \
    --exclude __pycache__ \
    $HOME/ $destination
