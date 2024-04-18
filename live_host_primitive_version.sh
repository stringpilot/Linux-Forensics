#!/bin/bash

# Bash automation to investigate a live host

echo 'Tools for Live host investigation on unix' > investigation_output.txt
echo 'Ensure you have sudo privs' >> investigation_output.txt
echo '-------------------------------------------' >> investigation_output.txt
echo '-------------------------------------------' >> investigation_output.txt
echo '[+] live system information' >> investigation_output.txt
hostnamectl >> investigation_output.txt
echo '---------------------------------' >> investigation_output.txt
echo '[+] Distro and kernel version' >> investigation_output.txt
uname -r >> investigation_output.txt
echo '---------------------------------' >> investigation_output.txt
echo '[+] Time zone Information' >> investigation_output.txt
date +"%Z %z" >> investigation_output.txt
echo '---------------------------------' >> investigation_output.txt
echo '[+] Live host IP' >> investigation_output.txt
ip a >> investigation_output.txt
echo '----------------------------------' >> investigation_output.txt
echo '[+] Display the routing table' >> investigation_output.txt
if ! command -v netstat &> /dev/null; then
    ip route >> investigation_output.txt
else
    netstat -r >> investigation_output.txt
fi
echo '---------------------------------' >> investigation_output.txt
echo '[+] Shutdown Information' >> investigation_output.txt
last -x -F shutdown >> investigation_output.txt
echo '---------------------------------' >> investigation_output.txt
echo '[+] Uptime Information' >> investigation_output.txt
echo '[*] The time a live system has been online for' >> investigation_output.txt
uptime >> investigation_output.txt
echo '[*] Show the uptime since when it was booted' >> investigation_output.txt
uptime -s >> investigation_output.txt
echo '---------------------------------' >> investigation_output.txt
echo '[+] Check installed applications' >> investigation_output.txt
echo '[*] Note: We will output all response in a text file' >> investigation_output.txt
if ! command -v apt &> /dev/null; then
    dpkg -l > application_output.txt
else
    apt list --installed > application_output.txt
fi
echo '---------------------------------' >> investigation_output.txt
echo '[+] Users and groups' >> investigation_output.txt
echo '[*] Output Users on a text file' >> investigation_output.txt
cat /etc/passwd > users_passwd_output.txt
passwd -S >> users_passwd_output.txt
echo '[*] Output Group on a text file' >> investigation_output.txt
cat /etc/group > groups_output.txt
echo '---------------------------------' >> investigation_output.txt
echo '[+] Crons' >> investigation_output.txt
echo '[*] Output Cron on a text file' >> investigation_output.txt
cat /etc/crontab > crontab_output.txt
cat /var/spool/cron >> crontab_output.txt
echo '-----------------------------------' >> investigation_output.txt
echo '[+] Sudoers' >> investigation_output.txt
cat /etc/sudoers >> investigation_output.txt
echo '-----------------------------------' >> investigation_output.txt
echo '-----------------------------------' >> investigation_output.txt
echo ' Live Host interrogation fin' >> investigation_output.txt
echo '-----------------------------------' >> investigation_output.txt
echo '-----------------------------------' >> investigation_output.txt
