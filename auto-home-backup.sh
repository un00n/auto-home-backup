#!/bin/bash
# Automated Backup Script with Compression for $HOME Directory

# Set source directory and backup directory
srcdir=$HOME
dir="$HOME/Documents/backups"

# Check if backup directory exists, create if not
if [ -d $dir ]; then
    desdir="$HOME/Documents/backups"
else
    mkdir -p $dir
    desdir="$HOME/Documents/backups"
fi

# Create a timestamp for a unique backup folder
filename=$(date +"%Y%m%d%H%M%S")
backupfolder="$desdir/backup_$filename"
mkdir -p $backupfolder 

# Perform backup using rsync, excluding .cache directory
rsync -a --info=progress2 --exclude=".cache" $srcdir $backupfolder

# Compress the backup folder using tar
tar -czf "$backupfolder.tar.gz" -C $desdir "backup_$filename" --remove-files

# Check if the compressed backup file exists
if [ -e "$backupfolder.tar.gz" ]; then
    echo "Backup completed successfully! Backup stored in: $desdir"
else
    echo "Error! Backup failed."
fi
