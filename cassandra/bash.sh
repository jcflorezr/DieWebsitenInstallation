# ------- jcflorezr -------
# configure java and cassandra
# https://www.digitalocean.com/community/tutorials/how-to-install-cassandra-and-run-a-single-node-cluster-on-a-ubuntu-vps

# JDK environment variable
export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_51
export PATH=${PATH}:${JAVA_HOME}/bin
# JRE environment variable
export JRE_HOME=/usr/lib/jre1.8.0_51
export PATH=${PATH}:${JRE_HOME}/bin

# Cassandra database environment variable
export CASSANDRA_HOME=/usr/lib/dsc-cassandra-2.0.14
export PATH=$PATH:$CASSANDRA_HOME/bin
# Alias for executing cassandra
cassandra() {
   if [$# -eq 0]; then
      printf "No arguments supplied. Possible arguments: start, stop, restart."
   elif [$1 == "start"]; then
      sudo /etc/init.d/cassandra start
   elif [$1 == "stop"]; then
      sudo /etc/init.d/cassandra stop
   elif [$1 == "restart"]; then
      sudo /etc/init.d/cassandra restart
   else
      msg = $1
      msg =  " is an invalid argument. Possible arguments: start, stop, restart."
      printf $msg
   fi
}
