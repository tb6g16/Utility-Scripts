#!/usr/bin/env bash

# This script will approximate the word count of latex document using the pdftotext
# command and counting the words in the resulting text document.

# define variables
# NEED A ROBUST WAY TO CROP THE FIRST AND LAST PAGES OFF
filename=$1

# convert the pdf file to a text file
pdftotext ./out/$filename.pdf

# perform a word count on the text file
wc -w ./out/$filename.txt

# remove the text file afterwards
rm ./out/$filename.txt
