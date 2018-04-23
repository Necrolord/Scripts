#!/bin/bash

#Checking if OS is supported
./os_check.sh

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="AMP installer"
TITLE="Choose preferable Web engine"
MENU="Choose one of the following options:"

OPTIONS=(1 "Apache"
         2 "ngnix")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
clear
case $CHOICE in
        1)
           echo "Initiating apache installation script"
	   ./apache_install.sh
	   echo "Installation completed"
            ;;
        2)
           echo "Initiating ngnix installation script"
	   ./ngnix_install.sh
	   echo "Installation completed"
            ;;
esac
