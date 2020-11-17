#!/bin/bash
# backuprestore.sh
# Run with root privileges

# Variables.
hostname=$(hostname -s)
dest="/mnt/backup"

echo "Enter which weekday's backup you want to restore"
ls $dest
read WEEKDAY

case $WEEKDAY in

  monday | Monday | MONDAY)
    tar -xzvf $dest/"$hostname"-Monday.tgz -C /
    echo -n "Monday\'s backup has been restored"
    ;;

  tuesday | Tuesday | TUESDAY)
    tar -xzvf $dest/"$hostname"-Tuesday.tgz -C /
    echo -n "Tuesday\'s backup has been restored"
    ;;

  wednesday | Wednesday | WEDNESDAY)
    tar -xzvf $dest/"$hostname"-Wednesday.tgz -C /
    echo -n "Wednesday\'s backup has been restored"
    ;;

  thursday | Thursday | THURSDAY)
    tar -xzvf $dest/"$hostname"-Thursday.tgz -C /
    echo -n "Thursday\'s backup has been restored"
    ;;
    
  friday | Friday | FRIDAY)
    tar -xzvf $dest/"$hostname"-Friday.tgz -C /
    echo -n "Thursday\'s backup has been restored"
    ;; 
    
  saturday | Saturday | SATURDAY)
    tar -xzvf $dest/"$hostname"-Saturday.tgz -C /
    echo -n "Saturday\'s backup has been restored"
    ;;
    
  sunday | Sunday | SUNDAY)
    tar -xzvf $dest/"$hostname"-Sunday.tgz -C /
    echo -n "Sunday\'s backup has been restored"
    ;;
esac
