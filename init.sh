#/bin/bash
sudo rm /etc/apt/sources.list
cp sources.list /etc/apt/sources.list
sudo apt update
sudo apt upgrade
sudo apt install -y openssh-server
sudo rm /etc/ssh/sshd_config
cp sshd_config /etc/ssh/sshd_config
sudo apt install -y sshpass
