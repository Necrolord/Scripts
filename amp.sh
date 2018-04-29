#!/bin/bash
#Set exit on error
	set -e
#Clear screen
	clear
#Function to check root permission
	func_permissions () {
		if [[ $EUID -ne 0 ]]; then
			echo ""
			echo "------------------------------------------------------"	
			echo "This script must be run as root, use sudo "$0" instead" 1>&2
			echo ""
			exit 1
		fi
	}

#Function for Apache installation including SELinux and Firewall config
	func_apache () {
		echo "Checking if apache already installed"
		sleep 1 
 		#service httpd status
 		#if [ $? = 0 ]; then
		rpm -qa | grep -qw httpd && func_apache1 || func_apache2
	}

	func_apache1 () {
   	 	# apache service exists
			echo "------------------------"
			echo ""
      			echo "Apache already installed, no installation is required"
			echo ""
			echo ":------------------------"	
      			sleep 1
			}

      	func_apache2 () {
 		# installing apache
      			echo "Updating yum , installing apache and configuring firewall and SELinux"
      			sleep 1
      			echo ""
      			yum -y update
      			systemctl start httpd
      			systemctl enable httpd
			chkconfig httpd on
		
    		if [[ 'firewall-cmd --state' = running ]];then
			firewall-cmd --zone=public --permanent --add-service=http
      			firewall-cmd --zone=public --permanent --add-service=https
      			firewall-cmd --reload
    		else
      			echo "Firewall setting were not applied since firewall is not running"
    		fi
      			sestatus=$(getenforce)
      			if $sestatus != "Enforced";then
       			echo "No SELinux settings required"
      		else
       			setsebool httpd_disable_trans 1
       			setsebool -P httpd_disable_trans 1	
       			continue
      		fi	
	}

#NGNIX installation script
	func_ngnix () {
		echo "Updating yum"
		yum -y update

	}

clear
func_permissions
#Checking if OS is supported
		echo "-------------------------------------------------"
		echo "-------------A M P Installer --------------------"
		echo "-------------------------------------------------"
		echo "-------- AMP = Apache MySQL PHP----------------- "
		sleep 1
		echo ""
		echo ""
		echo "Checking if your OS supported by this script"
		sleep 1
		OS_version=$(awk -F= '/^NAME/{print tolower($2)}' /etc/os-release)

		#If OS is not CentOS exiting from script

		grep -q 'centos' <<< $OS_version && echo "$OS_version is supported" || (echo "$OS_version is not supported" && exit 1)
		sleep 1
		echo ""
		echo "OS test passed"
		echo "Checking if dialog package installed , it will be installed in case no exists already"
		echo ""
		sleep 1
		rpm -qa | grep -qw dialog || sudo yum -y install dialog
		sleep 1
		echo "----------------------------------------------------------"
		echo "Requirements are ok, starting installation proccess"
		sleep 2


# Web Engine Installation
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="AMP installer"
TITLE="SELECT WEB ENGINE"
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
	   func_apache
	   echo "Installation completed"
            ;;
        2)
           echo "Initiating ngnix installation script"
	   func_ngnix
	   echo "Installation completed"
            ;;
esac
