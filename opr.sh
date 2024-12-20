#!/bin/bash 
#opreation menu
whiptail --notags --menu "opreation " 25 78 16 \
	"1" "Select"\
	"2" "Insert_record"\
	"3" "Update_record"\
	"4" "Drop_table"\
	"5" "Add table"\
	"6" "list tables"\
        "7" "Exit"	2>nadadb/temp/.opttemp
choice=$(cat nadadb/temp/.opttemp)
#if [[ -n $chioce ]]
#then
case $choice in
	1) . select.sh
		;;
	2) . insert.sh
		;;
	3) . update.sh
		;;
	4) . drop.sh
		;;
	5) . create.sh
		;;
	6) . men.sh
		;;
	7) . bye.sh
		;;

esac
#fi
