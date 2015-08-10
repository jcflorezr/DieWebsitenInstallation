#!/bin/bash

echo ===============================================================================================
echo ======================================= Mac OSX 10+ ===========================================
echo ===============================================================================================


# Check if Java is already installed and is not too old
java_not_exists_or_too_old=true

if [ ! -z "$JAVA_HOME" ]; then
	JAVA_VER=$(java -version 2>&1 | sed 's/java version "\(.*\)\.\(.*\)\..*"/\1\2/; 1q')
	if [ "$JAVA_VER" -lt 16 ]; then 
		echo "ERROR: There is a < 1.6 java version, please update your Java Application."
		echo "EXITING PROCESS"
		exit 1
	else 
		java_not_exists_or_too_old=false
	fi	
fi

if [ "$java_not_exists_or_too_old" = true ]; then

	echo "ERROR: There is no Java Application installed, please refer to the next links:"
	echo "	https://docs.oracle.com/javase/8/docs/technotes/guides/install/mac_jdk.html"
	echo "	http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html"
	echo "EXITING PROCESS"
	exit 1

else 

	echo ==================== Java JDK and JRE already installed in this system ========================
	echo ========================= type in your terminal "java -version" ===============================
	echo ===============================================================================================

fi