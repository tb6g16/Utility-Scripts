#!/usr/bin/env bash

# This bash script perform a single backup of a given source to a desired
# destination (and provide all log files)

# The script takes in positional arguments as:
#   - absolute path to source directory
#   - absolute path to destination directory
#   - name of backup history log file (defaults to "source_backup_history")

# The script has one optional flag:
#   -q: quite
#       do not print any messages associated with the transfer

# optional quite flag
has_q_flag="false"
while getopts :q opt;
do
    case ${opt} in
        q) has_q_flag="true";;
        \?) echo "Valid flags: [-q]"; exit 1;;
    esac
done
shift $(( OPTIND - 1 ))

# define variables
source=$1
dest=$2
temp_logs=/mnt/c/Users/user/Documents/rsync_temp_logs
if [ ! -z $3 ];
then
    backup_history_name=$3
else
    backup_history_name=source_backup_history
fi

# move history file from source to temp_logs
if [ ! -f "$source/$backup_history_name.log" ];
then
    > $source/$backup_history_name.log
fi
mv $source/$backup_history_name.log $temp_logs/$backup_history_name.log

# syncing the directories
if [ $has_q_flag == "false" ];
then
    echo "Syncing directories of $source and to $dest"
fi
rsync -avq --delete --exclude '*.log' $source/ "$dest/" 2> "$dest/"errors.log
# --log-file=$temp_logs/latest_backup.log

# create error notification is something went wrong
rsync_status=$?
if [ $rsync_status -ne 0 ];
then
    exit_message=$(rsync_status_matcher.sh $rsync_status)
    attention=/mnt/c/users/user/Desktop/ATTENTION_$backup_history_name.txt
    error="There was an error with the last backup to $dest:"
    echo "$error" > $attention
    cat "$dest/"errors.log >> $attention
    echo "$rsync_status: $exit_message" >> $attention
fi

# appending backup info and move to source directory
if [ $has_q_flag == "false" ];
then
    echo "Appending to backup history log"
fi
if [ $rsync_status -eq 0 ];
then
    message="$(date): Successfully Performed Backup
        Source: $source/
        Destination: $dest/
    "
else
    message="$(date): (ERROR) Performed Backup
        Source: $source/
        Destination: $dest/
    "
fi
echo "$message" >> $temp_logs/$backup_history_name.log
mv $temp_logs/$backup_history_name.log $source/$backup_history_name.log
