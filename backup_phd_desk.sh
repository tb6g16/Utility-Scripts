#!/usr/bin/env bash

# define absolute path to source and backup location
source=/home/tb6g16/Documents/PhD
backup_raid=/home/tb6g16/raid/PhD_backup

# sync desktop to sirius and read completion line of logs
echo "Backing up to Sirius RAID"
/home/tb6g16/Documents/utility_scripts/single_backup_desk.sh -q $source $backup_raid raid_history

