#!/bin/sh

# ===============================================================================================
# ================================= Install Java JDK and JRE ====================================
# ===============================================================================================

#split gz file
#split -b 40m "/home/diewebsiten/java/jdk/jdk-8u51-linux-x64.gz" "/usr/lib/jvm/jdk-8u51-linux-x64.gz.part-" 

# Create the /usr/lib/jvm directory and uncompress the gz splitted file into it
mkdir /usr/lib/jvm
cat jdk-8u51-linux-x64.gz.part-* | tar xz


# ===============================================================================================
# ====================== Install Cassandra database as service on ubuntu ========================
# ===============================================================================================
# REFERENCE --> http://docs.datastax.com/en/cassandra/2.0/cassandra/install/installDeb_t.html

# Add the DataStax Community repository to the /etc/apt/sources.list.d/cassandra.sources.list
echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list

# Add the DataStax repository key to your aptitude trusted keys.
curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -

# Install the package. For checking the latest version --> http://www.planetcassandra.org/cassandra/
sudo apt-get update
sudo apt-get install dsc20=2.0.14-1 cassandra=2.0.14

# Because the Debian packages start the Cassandra service automatically, you must stop the server and clear the data:
# Doing this removes the default cluster_name (Test Cluster) from the system table. All nodes must use the same cluster name.
sudo service cassandra stop
sudo rm -rf /var/lib/cassandra/data/system/*


# ===============================================================================================
# ================================ Install Apache Tomcat 8.0.23 =================================
# ===============================================================================================
# REFERENCE --> https://www.digitalocean.com/community/tutorials/how-to-install-apache-tomcat-8-on-ubuntu-14-04

# First, create a new tomcat group:
sudo groupadd tomcatdw

# Then create a new tomcat user. We'll make this user a member of the tomcat group, 
# with a home directory of /opt/tomcatdw (where we will install Tomcat), 
# and with a shell of /bin/false (so nobody can log into the account):
sudo useradd -s /bin/false -g tomcatdw -d /opt/tomcat tomcatdw

# create /opt/tomcat directory
sudo mkdir /opt/tomcatdw
cd /opt/tomcatdw

# Download Apache Tomcat and extract the tar file
wget http://mirror.sdunix.com/apache/tomcat/tomcat-8/v8.0.23/bin/apache-tomcat-8.0.23.tar.gz
sudo tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1

# Give the 'tomcatdw' user write access to the conf directory, and read access to the files in that directory
sudo chgrp -R tomcatdw conf
sudo chmod g+rwx conf
sudo chmod g+r conf/*

# Make the 'tomcatdw' user the owner of the work, temp, and logs directories:
sudo chown -R tomcatdw work/ temp/ logs/

# Because we want to be able to run Tomcat as a service, we will set up an Upstart script.
cp /home/diewebsiten/DieWebsitenInstallation/tomcat/tomcat.conf /etc/init/

# Now let's reload the Upstart configuration, so we can use our new Tomcat script:
sudo initctl reload-configuration

# Tomcat is ready to be run. Start it with this command:
tomcatdw start


