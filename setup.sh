#!/bin/bash

# Install Script for aps
# The setup moves the script to /usr/local/bin
# and chages the rights for the script.

# Copyright Matti Kaupenjohann
# Author: Matti Kaupenjohann
# Date: 2021-04-16
#
# *****************************************************************************
#                                GPL 3 License
#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <https://www.gnu.org/licenses/>.
# *****************************************************************************

tempfiles=( )
cleanup() {
	$DIALOG --infobox "Removing temp-files ..." 3 30 
	rm -f "${tempfiles[@]}"
	sleep 2
	$DIALOG --clear
	clear
}
trap cleanup 0

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

cp_script() {
	echo "# Copied script to destination:"
	cp -rv aps "$INSTALL_PATH"
}

chmod_script() {
	echo "# Changed rights for script:"
	chmod -v 755 "$INSTALL_PATH"
}

main(){
if ! [ "$(id -u)" = 0 ]; then
   	error ${LINENO} "The script need to be run as root." 1
fi

temp_setup="$(mktemp /tmp/aps_setup.XXXXX --suffix=.tmp)"
tempfiles+=( "$temp_setup" )

MSG="
   INSTALLING \\ UPDATING  
                           
      ___    ____  _____   
     /   |  / __ \\/ ___/  
    / /| | / /_/ /\\__ \   
   / ___ |/ ____/___/ /    
  /_/  |_/_/    /____/     
                           
 The Advanced Port Scanner!
"

DIALOG=dialog 
$DIALOG --no-collapse --ok-label "CONTINUE" --msgbox "$MSG" 0 0
$DIALOG --clear    # Dialog-screen reset
RESPONSE=1
while [ $RESPONSE -eq 1 ]
do
INSTALL_PATH=$($DIALOG --inputbox "Enter Custom Install Path or press Enter to Continue " 0 0 \
		"/usr/local/bin/aps" 3>&1 1>&2 2>&3)
$DIALOG --clear
$DIALOG --yesno "Do you want to use $INSTALL_PATH as install path?" 0 0
RESPONSE=$?
$DIALOG --clear
done

if [ -f aps ]; then
	cp_script >> "$temp_setup"
	$DIALOG --infobox "$(cat "$temp_setup")" 10 80
	sleep 1
	chmod_script >> "$temp_setup"
	$DIALOG --infobox "$(cat "$temp_setup")" 10 80
	sleep 1
	$DIALOG --msgbox "Installation Complete!" 0 0
	
else
	error "$(LINENO)" "Script aps not found. Are you calling this setup script from correct dir?" 2
fi
}


main
