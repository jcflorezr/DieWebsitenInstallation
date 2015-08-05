#!/bin/bash

echo ===============================================================================================
echo ================================= Install vsftpd FTP Server ===================================
echo ===============================================================================================
# REFERENCE --> http://www.mclarenx.com/2012/08/10/configurar-vsftpd-y-evitar-los-errores-500-y-530/comment-page-1/

# Install vsftpd from apt
apt-get --assume-yes install vsftpd

# Overwrite the 'vsftpd.conf' file with all the neccesary configuration
cp /home/diewebsiten/DieWebsitenInstallation/ftpserver/vsftpd.conf /etc/vsftpd.conf

# Create the 'vsftpd.chroot_list' adding our 'ftpdw' user
echo "ftpdw" | tee -a /etc/vsftpd.chroot_list

# Create a ghost shell for 'ftp' users
mkdir /bin/ftp
echo "/bin/ftp" | tee -a /etc/shells

# Create the '/home/diewebsiten/ftp' folder for the 'ftpdw' user
mkdir /home/diewebsiten/ftp
mkdir /home/diewebsiten/ftp/files

# Create the 'ftpdw' user and give access to the directories created before
useradd -s /bin/ftp -g ftp -d /home/diewebsiten/ftp ftpdw
echo ftpdw:ftpdw | chpasswd
chown ftpdw:ftp -R /home/diewebsiten/ftp/files



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



echo ===============================================================================================
echo =========================== Install Cassandra database as service =============================
echo ===============================================================================================
# REFERENCE --> http://docs.datastax.com/en/cassandra/2.0/cassandra/install/installDeb_t.html

# Add the DataStax Community repository to the /etc/apt/sources.list.d/cassandra.sources.list
echo "deb http://debian.datastax.com/community stable main" | tee -a /etc/apt/sources.list.d/cassandra.sources.list

# Add the DataStax repository key to your aptitude trusted keys.
curl -L http://debian.datastax.com/debian/repo_key | apt-key add -

# Install the package. For checking the latest version --> http://www.planetcassandra.org/cassandra/
apt-get update
apt-get --assume-yes install dsc20=2.0.14-1 cassandra=2.0.14

# Because the Debian packages start the Cassandra service automatically, you must stop the server and clear the data:
# Doing this removes the default cluster_name (Test Cluster) from the system table. All nodes must use the same cluster name.
service cassandra stop
rm -rf /var/lib/cassandra/data/system/*

# Create CASSANDRA_HOME environment variable and 'cassandra' alias for start and stop cassandra as service
cat /home/diewebsiten/DieWebsitenInstallation/cassandra/bash >> /etc/bash.bashrc
. /etc/bash.bashrc


echo ===============================================================================================
echo ================================ Install Apache Tomcat 8.0.23 =================================
echo ===============================================================================================
# REFERENCE --> https://www.digitalocean.com/community/tutorials/how-to-install-apache-tomcat-8-on-ubuntu-14-04

# First, create a new tomcat group:
groupadd tomcat

# Then create a new tomcat user. We'll make this user a member of the tomcat group, 
# with a home directory of /opt/tomcatdw (where we will install Tomcat), 
# and with a shell of /bin/false (so nobody can log into the account):
useradd -s /bin/false -g tomcat -d /opt/tomcatdw tomcatdw
echo tomcatdw:tomcatdw | chpasswd

# create /opt/tomcatdw directory
mkdir /opt/tomcatdw
cd /opt/tomcatdw

# Download Apache Tomcat and extract the tar file
wget http://mirror.sdunix.com/apache/tomcat/tomcat-8/v8.0.23/bin/apache-tomcat-8.0.23.tar.gz
tar xvf apache-tomcat-8*tar.gz -C /opt/tomcatdw --strip-components=1

# Give the 'tomcatdw' user write access to the conf directory, and read access to the files in that directory
chgrp -R tomcat conf
chmod g+rwx conf
chmod g+r conf/*

# Make the 'tomcatdw' user the owner of the work, temp, and logs directories:
chown -R tomcatdw work/ temp/ logs/

# Because we want to be able to run Tomcat as a service, we will set up an Upstart script.
cp /home/diewebsiten/DieWebsitenInstallation/tomcat/tomcat.conf /etc/init/

# Now let's reload the Upstart configuration, so we can use our new Tomcat script:
initctl reload-configuration

# Create 'tomcatdw' alias for start and stop Apache Tomcat as service
cat /home/diewebsiten/DieWebsitenInstallation/tomcat/bash >> /etc/bash.bashrc
. /etc/bash.bashrc

# Tomcat is ready to be run. Start it with this command:
tomcatdw start
