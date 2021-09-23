#!/bin/bash

echo "#############################################################################
#                                                                           #
# Project 'NodeJS quick installer'                                          #
#                                                                           #
# Copyright (C) 2021, Jan Nonnenmann, <project@jlno.de>                     #
#                                                                           #
#   This programm is licenced under GNU General Public License              #
#                                                                           #
#                                                                           #
#   You should have received a copy of the GNU General Public License       #
#   along with this program.  If not, see <https://www.gnu.org/licenses/>.  #
#                                                                           #
# https://github.com/jlno5/scripts/LICENSE                                  #
#                                                                           #
# This script is not associated with the official NodeJS Software.	        #
# https://github.com/jlno5/scripts/node			                            #
#                                                                           #
#############################################################################"

VERSION="v0.0.1"

# exit if user is not root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root (sudo)!"
  exit 1
fi

# check if curl is installed
if ! [ -x "$(command -v curl)" ]; then #########

  # ask for installation
  read -p "Do you want to download curl (it is required)? " -n 1 -r
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    sudo apt-get install curl -y
  else
    echo "Okay"
  fi


fi #########

# Choose NodeJS version 10-16
while :; do

  read -p "Which NodeJS version do you want to download? Type a number between 10 and 16! " NODE_VERSION
  echo ""
  [[ $NODE_VERSION =~ ^[0-9]+$ ]] || { echo "Enter a valid number"; continue; }

  if ((NODE_VERSION  >= 10 && NODE_VERSION <= 16)); then
    FULL_DOWNLOAD_PATH_WITHOUT_VERSION="https://deb.nodesource.com/setup_"
    FULL_DOWNLOAD_PATH="$FULL_DOWNLOAD_PATH_WITHOUT_VERSION$NODE_VERSION.x"
    curl -sL $FULL_DOWNLOAD_PATH -o nodesource_setup.sh

    STRING="<html>"
    FILE="nodesource_setup.sh"
    if  grep -q "$STRING" "$FILE" ; then
      echo "Something went wrong, please report it on https://github.com/jlno5/scripts/issues"
      exit 1
    fi

    sudo bash nodesource_setup.sh
    sudo apt-get install nodejs
    sudo rm nodesource_setup.sh
    break
  else
    echo "Not a acceptable NodeJS Version!"
  fi

done

echo ""
echo ""
echo ""
echo "Thanks for using my script. You can support me on GitHub by starring my project."
