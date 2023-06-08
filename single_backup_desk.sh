#!/usr/bin/env bash

# THis bash script performs a single backup of a given source to a desired
# destination (and provides all log files)
#
# # The script takes in positional arguments as:
#     - absolute path to source directory
#     - absolute path to destination directory
#     - name of backup histroy log file (defaults to "source_backup_history")

# The scrupt has one optional flag:
#   -q: quite
#       do not print any messages associated with the transfer

# optional quite flag
has_q_flag="false"
while getopts :q opt;
do
	case ${opt} in
		q) has_q_flag="true";;
		/?) echo "Valid flags [-q]"; exit 1;;
	esac
done
shift $(( OPTIND - 1))

# define variables
source=$1
dest=$2
temp_logs=/tmp
if [ ! -z $3 ];
then
	backup_history_name=$3
else
	backup_histroy_name=source_backup_history
fi

# move history file from source to /tmp/
if [ ! -f "$source/$backup_history_name.log" ];
then
	> $source/$backup_history_name.log
fi
mv $source/$backup_history_name.log $temp_logs/$backup_history_name.log

# suncing the directories
if [ $has_q_flag == "false" ];
then
	echo "Syncing $source to $dest"
fi
rsync -avq --delete --exclude={'*.log','venv'} $source/ "$dest/" 2> "$dest/"errors.log
# --log-file=$temp_logs/latest_backup.log

# create error notification if something went wrong
rsync_status=$?
if [ $rsync_status -ne 0 ];
then
	exit_message=$(/home/tb6g16/Documents/utility_scripts/rsync_status_matcher.sh $rsync_status)
	attention=/home/tb6g16/Documents/ATTENTION_$backup_history_name.txt
	error="There was an error with the last backup to $dest:"
	echo "$error" > $attention
	cat "$dest/"errors.log >> $attention
	echo "$rsync_status: $exit_message" >> $attention
fi

# append backup info and move to source directory
if [ $has_q_flag == "false" ];
then
	echo "Appending to backup history log"
fi
if [ $rsync_status -eq 0 ];
then
	message="$(date): Successfully Performed Backup
	    Source:     $source/
	    Destination $dest/
	"
else
	message="$(date): (ERROR) Failed Backup
	    Source:      $source/
	    Destination: $dest/
	"
fi
echo "$message" >> $temp_logs/$backup_history_name.log
mv $temp_logs/$backup_history_name.log $source/$backup_history_name.log
