#!/bin/bash

if [ $# -eq 0 ]; then
  	echo "No arguments supplied. Possible arguments: [ubuntu|macosx]."
elif [ $# -gt 1 ]; then
	echo "Only one argument needed. Possible arguments: [ubuntu|macosx]."
elif [ $1 == "ubuntu" ] || [ $1 == "macosx" ]; then
	if [ $1 == "ubuntu" ]; then
  		/home/diewebsiten/DieWebsitenInstallation/ftpserver/$1/vsftpd.sh
  		/home/diewebsiten/DieWebsitenInstallation/java/$1/java.sh
		/home/diewebsiten/DieWebsitenInstallation/cassandra/$1/cassandra.sh
		/home/diewebsiten/DieWebsitenInstallation/tomcat/$1/tomcat.sh
  	fi
	~/DieWebsitenInstallation/java/$1/java.sh
	~/DieWebsitenInstallation/cassandra/$1/cassandra.sh
	~/DieWebsitenInstallation/tomcat/$1/tomcat.sh
else
  	echo $1
  	echo "is an invalid argument. Possible arguments: [ubuntu|macosx]"
fi