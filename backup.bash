#!/bin/bash 

# requires borg: sudo apt-get install borgbackup

# Before running this script, set up the backup storage dir once:
#   cd /mnt/ubuntu
#   sudo mkdir backup
#   sudo chown $USER:$USER backup
#   borg init backup

MOUNTPOINT=/mnt/ubuntu
[[ ! -e $MOUNTPOINT ]] && sudo mkdir $MOUNTPOINT
BACKUPDIR=$MOUNTPOINT/backup

if [[ ! -d $BACKUPDIR ]]; then
    PARTITION=/dev/sdb6
    if [[ -e $PARTITION ]]; then
        sudo mount $PARTITION $MOUNTPOINT
    else
        echo "Could not mount $PARTITION to $MOUNTPOINT!"
        exit 1
    fi
fi

cd ~

read -sp "Enter passphrase for \"$BACKUPDIR\": " BORG_PASSPHRASE
echo ""
export BORG_PASSPHRASE

# backing up my
#   - data
#   - configs
#   - mail/browser stuff
#   - Python virtualenvs
#   - ZSH history
# excluding binary and build files created by latex or python

CONFIGDIR=~/.config/borg
LOGDIR=$CONFIGDIR/logs
mkdir -p $LOGDIR

BACKUPDATE=$(date +%Y%m%d)
LOGFILE=$LOGDIR/$BACKUPDATE.log
BORGARCHIVE=$BACKUPDIR::$BACKUPDATE

borg create --verbose --stats --compression lz4 $BORGARCHIVE \
    --exclude "sh:**/build" \
    --exclude "*__pycache__*" \
    --exclude "*.pyc" \
    \
    code \
    Documents \
    Pictures \
    \
    .config \
    .files/local_shrc \
    .files/global_gituser \
    .screenlayout \
    .vimrc \
    \
    .mozilla/firefox \
    .cache/thunderbird \
    .local/share/qutebrowser \
    .thunderbird \
    \
    .virtualenvs \
    \
    .zsh_history \
    >> $LOGFILE 2>&1

# clean up old backups
borg prune --verbose --stats \
    --keep-within=2m \
    --keep-monthly=2 \
    --keep-yearly=2 \
    $BACKUPDIR \
    >> $LOGFILE 2>&1

unset BORG_PASSPHRASE

# store current UNIX time stamp to remind when next backup is due
BACKUP_DATES_FILE=$CONFIGDIR/backup_dates
date +%s >> $BACKUP_DATES_FILE

sudo umount $MOUNTPOINT
