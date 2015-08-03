# Install Cassandra database as service on ubuntu
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

# REFERENCE --> https://www.digitalocean.com/community/tutorials/how-to-install-cassandra-and-run-a-single-node-cluster-on-a-ubuntu-vps

# Make sure that the folders Cassandra accesses, such as the log folder, exists and that Cassandra has the right to write on it:
#sudo mkdir /var/lib/cassandra
#sudo mkdir /var/log/cassandra
#sudo chown -R $USER:$GROUP /var/lib/cassandra
#sudo chown -R $USER:$GROUP /var/log/cassandra