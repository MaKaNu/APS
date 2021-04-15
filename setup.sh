#!/bin/bash

# Install Script for aps
# The setup moves the script to /usr/local/bin
# and chages the rights for the script.

# Copyright Matti Kaupenjohann
# Author: Matti Kaupenjohann
# Version: 1.0.0

error() {
  local parent_lineno="$1"
  local message="$2"
  local code="${3:-1}"
  if [[ -n "$message" ]] ; then
    echo "Error on or near line ${parent_lineno}: ${message}; exiting with status ${code}"
  else
    echo "Error on or near line ${parent_lineno}; exiting with status ${code}"
  fi
  exit "${code}"
}
trap 'error ${LINENO}' ERR

main(){
if ! [ $(id -u) = 0 ]; then
   	error ${LINENO} "The script need to be run as root." 1
fi

MSG="
   INSTALLING \\ UPDATING  
                           
      ___    ____  _____   
     /   |  / __ \\/ ___/  
    / /| | / /_/ /\\__ \   
   / ___ |/ ____/___/ /    
  /_/  |_/_/    /____/     
                           
 The Advanced Port Scanner!
"

dialog --no-collapse --ok-label "CONTINUE" --msgbox "$MSG" 0 0
dialog --clear    # Dialog-Bildschirm löschen
if [ -f aps ]; then
	DIALOG=dialog 
		(
		echo "50" ; cp -uv aps /usr/local/bin/aps;
		echo "XXX" ; echo "Copy Script"; echo "XXX"
		echo "100" ; chmod -c 755 /usr/local/bin/aps;
		echo "XXX" ; echo "Change rights"; echo "XXX"
		)
	$DIALOG --title "Installation" --gauge "Start installation" 8 30
else
	error $(LINENO) "Script aps not found. Are you calling this setup script from correct dir?" 2
fi
dialog --msgbox "Installation Complete!" 0 0
clear
}


main
