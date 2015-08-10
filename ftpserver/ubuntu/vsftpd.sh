#!/bin/bash

echo ===============================================================================================
echo ======================================= Ubuntu 14.04 ==========================================
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
chmod -R +777 /home/diewebsiten/ftp/files

# Restart vsftpd server for updating changes
service vsftpd restart