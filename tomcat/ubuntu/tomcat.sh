#!/bin/bash

echo ===============================================================================================
echo ======================================= Ubuntu 14.04 ==========================================
echo ===============================================================================================
echo ============================== Installing Apache Tomcat 8.0.23 ================================
echo ===============================================================================================
# REFERENCE --> https://www.digitalocean.com/community/tutorials/how-to-install-apache-tomcat-8-on-ubuntu-14-04

# First, create a new tomcat group:
groupadd tomcat

# Then create a new tomcat user. We'll make this user a member of the tomcat group, 
# with a home directory of /opt/tomcatdw (where we will install Tomcat), 
# and with a shell of /bin/false (so nobody can log into the account):
useradd -s /bin/false -g tomcat -d /opt/apache-tomcat-8.0.23 tomcatdw
echo tomcatdw:tomcatdw | chpasswd

# Copy tomcat container folder to specified path (/opt/apache-tomcat-8.0.23)
cp -R /home/diewebsiten/DieWebsitenInstallation/tomcat/apache-tomcat-8.0.23 /opt && cd /opt/apache-tomcat-8.0.23

# Give the 'tomcat' group write access to the conf directory, and read access to the files in that directory
chgrp -R tomcat conf
chmod g+rwx conf
chmod g+r conf/*

# Make the 'tomcatdw' user the owner of the work, temp, and logs directories:
chown -R tomcatdw work/ temp/ logs/

# Because we want to be able to run Tomcat as a service, we will set up an Upstart script.
cp /home/diewebsiten/DieWebsitenInstallation/tomcat/ubuntu/tomcat.conf /etc/init/

# Now let's reload the Upstart configuration, so we can use our new Tomcat script:
initctl reload-configuration

# Create 'tomcatdw' alias for start and stop Apache Tomcat as service
cat /home/diewebsiten/DieWebsitenInstallation/tomcat/ubuntu/bash >> /etc/bash.bashrc
. /etc/bash.bashrc

# Open 8084 port for tomcat client connections
iptables -A INPUT -p tcp --dport 8084 -j ACCEPT
