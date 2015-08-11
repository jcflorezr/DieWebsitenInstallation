#!/bin/bash

echo ===============================================================================================
echo ======================================= Ubuntu 14.04 ==========================================
echo ===============================================================================================


# Check if Java is already installed and is not too old
java_not_exists_or_too_old=true

if [ ! -z "$JAVA_HOME" ]; then
	JAVA_VER=$(java -version 2>&1 | sed 's/java version "\(.*\)\.\(.*\)\..*"/\1\2/; 1q')
	if [ "$JAVA_VER" -lt 16 ]; then 
		echo "There is a < 1.6 java version"
	else 
		java_not_exists_or_too_old=false
	fi	
fi

if [ "$java_not_exists_or_too_old" = true ]; then

	echo =============================== Installing Java JDK and JRE ===================================
	echo ===============================================================================================

	# split gz file
	#split -b 40m "/home/diewebsiten/java/jdk/jdk-8u51-linux-x64.gz" "/usr/lib/jvm/jdk-8u51-linux-x64.gz.part-" 

	# Create the '/usr/lib/jvm' directory and uncompress the gz splitted file into it
	mkdir /usr/lib/jvm
	cd /home/diewebsiten/DieWebsitenInstallation/java/jdk
	cat jdk-8u51-linux-x64.gz.part-* | tar xz
	mv jdk1.8.0_51 /usr/lib/jvm/

	# Create JAVA_HOME and JRE_HOME environment variables
	cat /home/diewebsiten/DieWebsitenInstallation/java/ubuntu/bash >> /etc/bash.bashrc
	. /etc/bash.bashrc

else 

	echo ==================== Java JDK and JRE already installed in this system ========================
	echo ========================= type in your terminal "java -version" ===============================
	echo ===============================================================================================

fi