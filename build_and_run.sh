#!/usr/bin/env bash

# bash script for compile and running C99 code for both windows and linux

f_name="main"
do_print="false"
has_r_flag="false"

while getopts :r opt;
do
    case ${opt} in
        r) has_r_flag="true";;
        \?) echo "Valid flags: [-r]"; exit 1;;
    esac
done
shift $(( OPTIND - 1 ))

for arg in "$@"
do
    # echo "$arg"
    if  [ "$arg" == "-n" ]
    then
        do_print="true"
    elif [ "$arg" != "-h" ]
    then
        f_name="$arg"
    fi
done

# also want to change it so the import includes the .c extension
gcc $f_name.c -o $f_name.exe -std=c99 -Wall -pedantic -lm
# enable the below two lines and comment the one above to make gcc compile a binary file and MinGW to compile a .exe file
# gcc $f_name.c -o $f_name -ansi -Wall -pedantic -lm
# x86_64-w64-mingw32-gcc $f_name.c -o $f_name.exe -ansi -Wall -pedantic

if [ $has_r_flag == "false" ];
then
    ./$f_name.exe
fi

# if [ "$do_print" == "false" ]
# then
    # echo ""
# fi
