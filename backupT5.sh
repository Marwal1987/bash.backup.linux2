#!/bin/bash
# backupT5.sh
# Run with root priviliges 
# Backup to /mnt.
# Compress using tar.

# What to backup.
backup_files="/home /root /etc"

# Where to backup to.
dest="/mnt/backup"

# Create archive filename.
day=$(date +%A)                                               # +%A means show current weekday.
hostname=$(hostname -s)                                       # -s  means shortversion of hostname. Cut at first dot.
archive_file="$hostname-$day"

# Print start status msg.
echo "Backing up $backup_files to $dest/$archive_file"
echo

# Check to see if the script exists in daily cron directory.
function check {
  if [ ! -s "/etc/cron.daily/backupT5" ]                   # -s means files exists and its size is greater than 0                
  then 
   cp "$0" /etc/cron.daily/backupT5
   echo "2 * * * * /etc/cron.daily/backupT5" >> /etc/crontab
   echo "The backup has been set to run daily"
   echo "The exact run time is in the /etc/crontab file."
  fi
}

check

# Make the backup directory
mkdir -p $dest 2>/dev/null

# Move to the destination the tar file should be
cd $dest

# Compress with tar
tar -czf "$archive_file".tgz $backup_files 2>/dev/null
## Make a for loop to make one backup of each directory at row 8

# Print end status msg.
echo
echo "Backup finished."

echo
echo "Cleaning files older than 3 days."
echo
find $dest -type f -mtime +3 -exec rm -rf {} \;              # mtime = measure time. +3, 3 days  -f filename -r recursive

echo
echo "Cleaning finished."
echo

exit 0
