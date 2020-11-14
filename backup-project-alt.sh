#!/bin/bash
# backupT5.sh

# Backup to NFS mount script.
# Encryption using openssl.

# What to backup.
backup_files="/home /root /etc /usr"

# Where to backup to.
dest="/mnt/backup"

# Create archive filename.
day=$(date +%A)                                                       # +%A means show current weekday.
hostname=$(hostname -s)                                               # -s  means shortversion of hostname. Cut at first dot.
archive_file="$hostname-$day.tgz"              

# Print start status msg.
echo "Backing up $backup_files to $dest/$archive_file"
echo


# Check to see if the script exists in daily cron directory
function check_schedule {
  if [ ! -s "/etc/cron.daily/backupT5.sh" ]                           # -s means files exists and its size is greater than 0                
  then 
   sudo cp backupT5.sh /etc/cron.daily/backupT5.sh                    # Why sudo? The Cron directory is owned by root.
   echo "The backup has been set to run daily"
   echo "The exact run time is in the /etc/crontab file."
  exit 1
  fi
}

check_schedule

# Backup the files with Tar and encrypt with openssl.
tar czf $dest/"$archive_file" "$backup_files" | openssl enc -e -aes256 -out "$archive_file"-secured.tar.gz

# Print end status msg.
echo
echo "Backup finished."

echo
echo "Cleaning files older than 3 days."
echo
find $dest -type f -mtime +3 -exec rm -fr {} \;                        # 

echo
echo "Cleaning finished."
echo

exit 0
