#/bin/bash

sudo apt install -y openssh-server
sudo rm /etc/ssh/sshd.config
cp ~/tpSauvegarde/sshd_config /etc/ssh/sshd_config
sudo apt install -y sshpass
