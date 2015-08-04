For installing Die Websiten on Ubuntu 14.04 (VPS)

1. $ apt-get update
2. $ apt-get install git
3. $ mkdir /home/diewebsiten/
4. $ cd /home/diewebsiten/
5. $ git clone https://github.com/juan890202/DieWebsitenInstallation
6. $ cd /home/diewebsiten/DieWebsitenInstallation/
7. $ sh start.sh
8. $ git clone https://github.com/juan890202/DieWebsiten



For adding correct host key in 'known_hosts':
REFERENCE --> http://serverfault.com/questions/321167/add-correct-host-key-in-known-hosts-multiple-ssh-host-keys-per-hostname

1. $ ssh-keyscan -t rsa 'server ip'
2. and on the client, add this key to ~/.ssh/known_hosts



For removing large or troublesome blobs with BFG Repo-Cleaner
REFERENCE --> https://rtyley.github.io/bfg-repo-cleaner/

1. $ git clone --mirror git://example.com/"some-big-repo.git"
2. $ java -jar bfg-1.12.3.jar --strip-biggest-blobs 100 "some-big-repo.git"
3. $ cd "some-big-repo.git"
4. $ git reflog expire --expire=now --all && git gc --prune=now --aggressive
5. $ git push