#!/bin/bash

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

# SHORT COMINGS:
#   - NO WAY TO AUTOMATICALLY ASSESS ERRORS
#   - CRON JOB AUTOMATION
