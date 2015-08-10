#!/bin/bash

if [ $# -eq 0 ]; then
  	echo "No arguments supplied. Possible arguments: [ubuntu|macosx]."
elif [ $# -gt 1 ]; then
  	echo "Only one argument needed. Possible arguments: [start|stop|restart]."
elif [ $1 == "ubuntu" ] || [ $1 == "macosx" ]; then
	if [ $1 == "ubuntu" ]; then
		
		# Update apt-get repository
  		apt-get update
  		
  		# Install curl command if needed
		apt-get --assume-yes install curl
		
		# Install git for Downloading DieWebsiten
		apt-get --assume-yes install git
		
		# Create home directory for DieWebsiten in Ubuntu
		mkdir /home/diewebsiten/ && cd $_

		# Download DieWebsitenInstallation repository
		git clone https://github.com/juan890202/DieWebsitenInstallation

		# Install all the platforms needed by DieWebsiten
		cd /home/diewebsiten/DieWebsitenInstallation/ && bash start.sh

		# Refresh /bin/bash
		. /etc/bash.bashrc

		# Download DieWebsiten repository
		# cd /home/diewebsiten/ && git clone https://github.com/juan890202/DieWebsiten

	elif [ $1 == "macosx" ]; then

		# Download DieWebsitenInstallation repository
		cd ~ && git clone https://github.com/juan890202/DieWebsitenInstallation

		# Install all the platforms needed by DieWebsiten
		cd ~/DieWebsitenInstallation/ && bash start.sh

		# Refresh /bin/bash
		. /etc/bash.bashrc

		# Download DieWebsiten repository
		# cd ~ && git clone https://github.com/juan890202/DieWebsiten

  	fi
else
  	echo $1
  	echo "is an invalid argument. Possible arguments: [ubuntu|macosx]"
fi

		