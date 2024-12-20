#!/bin/bash
whiptail   --nocancel --inputbox "Enter your name" 10 30 2>nadadb/temp/.usertemp
userdb=$(cat nadadb/temp/.usertemp)
 pass=0
if grep -q  ^"$userdb" nadadb/temp/.user
then
        grep ^$userdb nadadb/temp/.user | cut -d ":" -f 2 >nadadb/temp/.pass
        pass=$(cat nadadb/temp/.pass)
        #whiptail --msgbox "Hello $userdb, passward is $pass" 10 30
	whiptail --nocancel --passwordbox "Passward $userdb" 10 30 2>nadadb/temp/.tempass
	if [ $pass = $(cat nadadb/temp/.tempass) ]
	then
        whiptail --msgbox "Hello $userdb" 10 30
	. opr.sh
			
	else
        whiptail --msgbox "Failed Authentication" 10 30
	if whiptail --yesno "Try again" 10 30
	then
		. welcome.sh
	fi
		

	fi
else
        whiptail --msgbox "$userdb Dont maych any user in db" 10 30
fi


~                                                                                 
~                                                                                 
~
