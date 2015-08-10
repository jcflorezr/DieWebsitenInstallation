#!/bin/bash

echo ===============================================================================================
echo ======================================= Ubuntu 14.04 ==========================================
echo ===============================================================================================
echo ================================= Install Java JDK and JRE ====================================
echo ===============================================================================================

# split gz file
#split -b 40m "/home/diewebsiten/java/jdk/jdk-8u51-linux-x64.gz" "/usr/lib/jvm/jdk-8u51-linux-x64.gz.part-" 

# Create the '/usr/lib/jvm' directory and uncompress the gz splitted file into it
mkdir /usr/lib/jvm
cd /home/diewebsiten/DieWebsitenInstallation/java/jdk
cat jdk-8u51-linux-x64.gz.part-* | tar xz
mv jdk1.8.0_51 /usr/lib/jvm/

# Create JAVA_HOME and JRE_HOME environment variables
cat /home/diewebsiten/DieWebsitenInstallation/java/bash >> /etc/bash.bashrc
. /etc/bash.bashrc