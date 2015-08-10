#!/bin/bash

echo ===============================================================================================
echo ======================================== Mac OSX 10+ ==========================================
echo ===============================================================================================
echo ================================ Install Apache Tomcat 8.0.23 =================================
echo ===============================================================================================
# REFERENCE --> https://wolfpaulus.com/jounal/mac/tomcat8/
# REFERENCE --> http://wiki.apache.org/tomcat/TomcatOnMacOS


if [ "$USER" == "root" ]; then

	echo "ERROR: Apache Tomcat must not be installed by root user"
	echo "EXITING PROCESS"
	exit 1

else

	# Create container folder (if does not exists)
	sudo mkdir -p /usr/local

	# Copy tomcat folder to specified path
	sudo cp ~/DieWebsitenInstallation/tomcat/apache-tomcat-8.0.23 /usr/local

	# To make it easy to replace this release with future releases, we are going to create a symbolic link that we are going to use when referring to Tomcat 
	# (after removing the old link, you might have from installing a previous version):
	sudo rm -f /Library/Tomcat
	sudo ln -s /usr/local/apache-tomcat-8.0.23 /Library/Tomcat

	# Change ownership of the /Library/Tomcat folder hierarchy to current user
	sudo chown -R $USER /Library/Tomcat

	#Make all scripts executable
	sudo chmod +x /Library/Tomcat/bin/*.sh

	# Because we want to be able to run Tomcat as a service, we will set up an Upstart script.
	cp ~/DieWebsitenInstallation/tomcat/macosx/org.apache.tomcat.plist /Library/LaunchDaemons/

	# Create 'tomcatdw' alias for start and stop Apache Tomcat as service
	cat ~/DieWebsitenInstallation/tomcat/macosx/bash >> ~/.bash_profile
	. ~/.bash_profile

fi
