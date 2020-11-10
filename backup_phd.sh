#!/bin/bash

# THIS NEEDS MORE INSPECTIONG
# PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/sbin:/mnt/c/Users/user/Documents/richards_lovely_scripts
# export DISPLAY=:0.0

# define absolute path to source and back-up location
source=/mnt/c/Users/user/Desktop/PhD
backup_internal=/mnt/d/PhD-Backup
backup_external=/mnt/e/PhD-Backup
backup_onedrive=/mnt/c/Users/user/'OneDrive - University of Southampton'/PhD-Backup

# sync laptop to internal HDD and read completion line of logs
echo "Syncing to interanl HDD"
single_backup.sh -q $source $backup_internal internalHDD_history

# sync laptop to external HDD
echo "Syncing to external HDD"
single_backup.sh -q $source $backup_external externalHDD_history

# sync laptop to OneDrive
echo "Syncing to University OneDrive"
single_backup.sh -q $source "$backup_onedrive" oneDrive_history
