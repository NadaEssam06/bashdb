#!/bin/bash
dir=nadadb/temp
dtemp=0
ctemp=0
fname=0
ftest=0
chyes=0
# choose data type
fileds(){
	whiptail --nocancel  --inputbox "Enter Field name" 10 20 2>$dir/.fname
	fname=$(cat $dir/.fname)
	awk -F":" -v fname=$fname,ftest=$ftest '{if($2==fname){ ftest=1;exit}}' nadadb/$1 
	if [ $ftest = "1" ]
	then
		whiptail --msgbox "Filed is exist already" 10 20
		. create.sh
	else
	whiptail --nocancel  --notags --menu "Data type of $1 field" 25 78 16\
       "1" "Number"\
       "2" "String" 2>$dir/.dtemp
	dtemp=$(cat $dir/.dtemp)
	ch=$(awk -F":" '{if($1 == "meta") if($4 == "1") print $4}' nadadb/$1)
	if [ $ch = "1" ]
	then
		echo meta:$fname:$dtemp:2>>nadadb/$1
	else
		whiptail --nocancel  --notags --menu "Constrain of $1 field" 25 78 16\
		"1" "Primary Key"\
		"2" "None" 2>$dir/.ctemp
		ctemp=$(cat $dir/.ctemp)
		echo meta:$fname:$dtemp:$ctemp>>nadadb/$1

	fi
	fi
}
whiptail --nocancel --inputbox "Enter table name" 10 20 2>$dir/.tname
tname=$(cat $dir/.tname)
if [ -f nadadb/$tname ]
then
	whiptail --msgbox "$tname already exist" 10 20 
	. create.sh
else
	touch nadadb/$tname
	fileds $tname
	while true
	do
		if whiptail  --yesno "Continue?" 10 20 
		then
			fileds $tname
		else
			if whiptail --yes-button "back to main menu" --no-button "Exit"  --yesno "Continue?" 30 75
			then
				. men.sh
				break;
			else
				break;
			fi
		fi
	done

fi
