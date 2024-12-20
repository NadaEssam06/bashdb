#!/bin/bash
typeset retype=0
checktype(){
	case $1 in
		[1-9]*)
			retype=1
			return 1
			;;
		*)
			retype=2
			return 2
			;;
	esac
}
checkpk(){
	awk -F ":" '{if($1 == "meta");}' nadadb/$inserttable
}
items=0
#ask to table name to insert 

whiptail --nocancel  --inputbox "Enter The table name" 20 40 2>nadadb/temp/.inserttable
inserttable=$(cat nadadb/temp/.inserttable)
#search for it
if [ -f "nadadb/$inserttable" ]
then #exist
	awk -F ":" '{if($1 != "meta")exit; print $2}' nadadb/$inserttable >nadadb/temp/.lnames
	temp1=$(cat nadadb/temp/.lnames)
	names=()
	while IFS=$'\n' read -r word
	do
        	names+=("$word")
	done < <(cat nadadb/temp/.lnames)
	insline=()
	typeset -i counter=0
	for i in ${names[@]}
	do
		whiptail --inputbox "$i" 10 20 2>nadadb/temp/.che
		insertche=$(cat nadadb/temp/.che)
		awk -F ":" -v i=$i  '{if ($2 == i){ print $3;exit } }' nadadb/$inserttable >nadadb/temp/.var
		var=$(cat nadadb/temp/.var)
		rm nadadb/temp/.var
		checktype $insertche
		if [[ $? -eq  $var ]]
		then
			echo $i
			insline[$counter]=$insertche
			((counter++))
		else
			(counter=0)
			whiptail --msgbox "Not valid $i" 10 20
			. insert.sh
		fi
		
	done
		for j in ${insline[@]}
		do
			printf "%s:"$j	>>nadadb/$inserttable

		done
		printf "\n" >>nadadb/$inserttable
		if whiptail --yes-button "Main menu" --no-button "exit" --yesno "Continue" 30 70
		then
			. opr.sh
		else
			. bye.sh
		fi

else #not exist
	whiptail --nocancel --msgbox "not exist" 10 20
	. opr.sh
fi


	#menu of items
	#take them in order 
	#check them
		#right ->insert
		#wrong ->re-enter
#if not show the names


