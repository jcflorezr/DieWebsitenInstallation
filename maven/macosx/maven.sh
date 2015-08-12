#!/bin/bash

echo ===============================================================================================
echo ======================================== Mac OSX 10+ ==========================================
echo ===============================================================================================
echo =================================== Installing Maven 3.2.5 ====================================
echo ===============================================================================================
# REFERENCE --> http://www.mkyong.com/maven/install-maven-on-mac-osx/

# Copy maven folder to Applications folder
cp -R ~/DieWebsitenInstallation/maven/apache-maven-3.2.5 /Applications

# Create maven environment variable
cat ~/DieWebsitenInstallation/maven/macosx/bash >> ~/.bash_profile
. ~/.bash_profile
