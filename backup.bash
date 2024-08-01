#!/bin/bash 

# requires borg: sudo apt-get install borgbackup

# Before running this script, set up the backup storage dir once:
#   cd /mnt/backup_drive
#   sudo mkdir backup
#   sudo chown $USER:$USER backup
#   borg init backup

MOUNTPOINT=${MOUNTPOINT:-/mnt/backup_drive}
[[ ! -e $MOUNTPOINT ]] && sudo mkdir $MOUNTPOINT
BACKUPDIR=$MOUNTPOINT/backup

if [[ ! -d $BACKUPDIR ]]; then
    PARTITION=${PARTITION:-/dev/sdb6}
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
#   - shell history
# excluding binary and build files created by latex or python

CONFIGDIR=~/.config/borg
LOGDIR=$CONFIGDIR/logs
mkdir -p $LOGDIR

BACKUPDATE=$(date +%Y%m%d)
LOGFILE=$LOGDIR/$BACKUPDATE.log
BORGARCHIVE=$BACKUPDIR::$BACKUPDATE

borg create --verbose --stats --compression lz4 \
    --exclude "sh:**/build" \
    --exclude "*__pycache__*" \
    --exclude "*node_modules*" \
    --exclude "*boxtribute/**/core*" \
    --exclude "*.docker*" \
    --exclude "*.pyc" \
    $BORGARCHIVE \
    \
    code \
    Documents \
    Pictures \
    Music \
    \
    .config \
    .files/local_* \
    .files/global_gituser \
    .gnupg \
    .ssh \
    \
    .mozilla/firefox \
    .cache/thunderbird \
    .local/share/qutebrowser \
    .thunderbird \
    \
    .virtualenvs \
    \
    .bash_history \
    .zsh_history \
    >> $LOGFILE 2>&1

if [[ $? -ne 0 ]]; then
    echo Error backing up!
    unset BORG_PASSPHRASE
    cat "$LOGFILE"
    exit 1
fi

echo Successfully backed up!

# clean up old backups
borg prune --verbose --stats \
    --keep-within=2m \
    --keep-monthly=2 \
    --keep-yearly=2 \
    $BACKUPDIR \
    >> $LOGFILE 2>&1

echo "*** Backup overview ***"
borg list $BACKUPDIR

unset BORG_PASSPHRASE

# store current UNIX time stamp to remind when next backup is due
BACKUP_DATES_FILE=$CONFIGDIR/backup_dates
date +%s >> $BACKUP_DATES_FILE

echo "Backup completed. Eventually do 'sudo umount $MOUNTPOINT'."
