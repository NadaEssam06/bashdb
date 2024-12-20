#!/bin/bash
whiptail --nocancel  --inputbox "Enter The table name" 20 40 2>nadadb/temp/.uptable
uptable=$(cat nadadb/temp/.uptable)
#search for it
if [ -f "nadadb/$uptable" ]
then #exist
  #up=awk -F":" '{if($1 == "meta") if($4 == "1") print $2}' nadadb/$uptable
  whiptail --inputbox "Enter value to update " 15 30 2>nadadb/temp/.up
  up=$(cat nadadb/temp/.up)
  rm nadadb/temp/.up
  whiptail --inputbox "Update to......" 15 30 2>nadadb/temp/.up
  upto=$(cat nadadb/temp/.up)
  #awk -F ":" -v up=$up -v upto=$upto '{if($1 !="meta") gsub(up,upto); print }' nadadb/$uptable >test15
   sed -i "s/$up/$upto/g" nadadb/$uptable 
else
whiptail --msgbox "No table with this name" 10 20
        if whiptail --yes-button "Update in another table" --no-button "Main menu" --yesno "Where U want go?" 30 75
        then
                . update.sh
        else
                . opr.sh
        fi

fi
