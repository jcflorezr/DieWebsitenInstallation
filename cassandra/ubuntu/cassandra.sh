#!/bin/bash

echo ===============================================================================================
echo ======================================= Ubuntu 14.04 ==========================================
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
cat /home/diewebsiten/DieWebsitenInstallation/cassandra/ubuntu/bash >> /etc/bash.bashrc
. /etc/bash.bashrc