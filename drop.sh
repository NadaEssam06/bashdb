#!/bin/bash
whiptail --nocancel  --inputbox "Enter The table name" 20 40 2>nadadb/temp/.droptable
droptable=$(cat nadadb/temp/.droptable)
if [ -f "nadadb/$droptable" ]
then
       if whiptail --yesno "There is no ctr+z , are u sure you wan drop this table" 20 40
       then
	       rm nadadb/$droptable
	      whiptail --msgbox "Dropped" 10 20
	      . opr.sh
      else
		if whiptail --yes-button "Drop another table" --no-button "Main menu" --yesno "Where U want go?" 30 75
		then
			. drop.sh
		else
			. opr.sh
		fi
       fi
else
 	whiptail --msgbox "No table with this name" 10 20      		
	if whiptail --yes-button "Drop another table" --no-button "Main menu" --yesno "Where U want go?" 30 75
	then
		. drop.sh
	else
		. opr.sh
	fi
fi




