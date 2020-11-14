#!/bin/bash
# backup-project-alt.sh


# Backup to NFS mount script.
# Encryption using openssl.


# What to backup
backup_files="/var/spool/mail /etc /root /boot /opt"

# Where to backup to.
dest="/mnt/backup"

# Create archive filename.
day=$(date +%A)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

# Print start status msg
echo "Backing up $backup_files to $dest/$archive_file"
date
echo

# Copy script to cron daily
sudo cp backup-project-alt.sh /etc/cron.daily/backup-project-alt.sh

# Backup the files with Tar and encrypt with openssl
tar czf $dest/"$archive_file" "$backup_files" | openssl enc -e -aes256 -out backup_secured.tar.gz

# Print end status msg.
echo
echo "Backup finished"
date

echo "Cleaing files older than 3 days!"

find $dest -type f -mtime +3 -exec rm -f {} \;

exit 0
