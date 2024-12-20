#!/bin/bash 
files=()
typeset dir=nadadb/temp
while IFS= read -r -d $'\0' file
do
	files+=("$file")
done < <(find nadadb/ -maxdepth 1 -type f -print0)
options=()
for i in "${!files[@]}"
do
	filename=$(basename "${files[$i]}")
	options+=("$((i+1))" "$filename") 
done
#options+=("+" "Add table")
whiptail --notags --menu "Select table:" 25 78 16 "${options[@]} " 2>nadadb/temp/.mentemp
choice=$(cat nadadb/temp/.mentemp)
rm nadadb/temp/.mentemp 
if whiptail --yes-button "Main menu" --no-button "exit" --yesno "Where U want next?" 30 75
                then
                        . opr.sh
                else
                        . bye.sh
                fi

