#/bin/bash
sudo apt update
sudo apt upgrade
sudo apt install -y openssh-server
sudo rm /etc/ssh/sshd_config
cp ~/tpSauvegarde/sshd_config /etc/ssh/sshd_config
sudo apt install -y sshpass
