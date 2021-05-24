#!/usr/bin/env bash

# This script is designed to push the contents of a specified folder to a new 
# (possibly remote) location using rsync. It is very similar to the backup
# script except with different logging habits.

# The script takes in positional arguments as:
#   - absolute path to source directory (can include IP of remote machine)
#   - absolute path to destination directory (can include IP of remote machine)

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

# syncing the directories
if [ $has_q_flag == "false" ];
then
    echo "Pushing directories from $source to $dest"
fi
rsync -avq --delete --exclude '*.log' $source/ "$dest/" 2> "$dest/"errors.log

# echo error message if something went wrong
rsync_status=$?
if [ $has_q_flag == "false" ];
then
    if [ $rsync_status -ne 0 ];
    then
        echo ERROR OCCURED, CHECK ERROR.LOG IN DESTINATION DIRECTORY
    fi
fi
