#!/bin/bash

# This bash file will act a wrapper to the mail command, providing a bit of
# default behaviour I think would be useful

# define variables
subject=$1
message=$2
if [ ! -z $3 ];
then
    destination=$3
else
    destination=tburton0703@yahoo.co.uk
fi

# send message
mail -s $subject $destination
$message
^D
