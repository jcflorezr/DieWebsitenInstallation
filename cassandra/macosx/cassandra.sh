#!/bin/bash

echo ===============================================================================================
echo ======================================= Mac OSX 10+ ===========================================
echo ===============================================================================================
echo ==================== Install Cassandra database as service with Homebrew ======================
echo ===============================================================================================
# REFERENCE --> https://gist.github.com/hkhamm/a9a2b45dd749e5d3b3ae


# Install Homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

# Install Python. Mac OS X has a copy of Python preinstalled, but this makes sure you get the newest version.
brew install python

# Install CQL. To use cqlsh, the Cassandra query language shell, you need to install cql.
pip install cql

# Install Cassandra
brew install cassandra

# Create 'cassandra' alias for starting and stopping Cassandra as service
cat /home/diewebsiten/DieWebsitenInstallation/cassandra/macosx/bash >> ~/.bash_profile
. ~/.bash_profile