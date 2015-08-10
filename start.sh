#!/bin/bash

if [ $# -eq 0 ]; then
  	echo "No arguments supplied. Possible arguments: [ubuntu|macosx]."
elif [ $# -gt 1 ]; then
	echo "Only one argument needed. Possible arguments: [ubuntu|macosx]."
elif [ $1 == "ubuntu" ] || [ $1 == "macosx" ]; then
	if [ $1 == "ubuntu" ]; then
  		exec /home/diewebsiten/DieWebsitenInstallation/ftpserver/ubuntu/vsftpd.sh
  	fi
	exec /home/diewebsiten/DieWebsitenInstallation/java/$1/java.sh
	exec /home/diewebsiten/DieWebsitenInstallation/cassandra/$1/cassandra.sh
	exec /home/diewebsiten/DieWebsitenInstallation/tomcat/$1/tomcat.sh
else
  	echo $1
  	echo "is an invalid argument. Possible arguments: [ubuntu|macosx]"
fi