#!/bin/bash
if [ ! -d /home/BDD_BACKUP ];
then
        mkdir /home/BDD_BACKUP
	mkdir /home/BDD_BACKUP/DAYLI_BACKUP
	mkdir /home/BDD_BACKUP/WEEKLY_BACKUP
	mkdir /home/BDD_BACKUP/MONTHLY_BACKUP
fi

dbname=nextcloud
dbuser=root
dbpassword=root
databasebackup=db_`date +"%Y.%m.%d"`.sql
thirtyDayAgo=`date +%Y.%m.%d -d "30 day ago"`
dateYesterday=`date +%Y.%m.%d -d "1 day ago"`
numberOfDay=`date +%w`
day=`date +%d`

# put nextcloud instance to maintenance mode
sshpass -p "root" ssh root@192.168.33.200 'sudo -u www-data /usr/bin/php /var/www/html/nextcloud/occ maintenance:mode --on'

# dump the database
sshpass -p "root" ssh root@192.168.33.200 "mysqldump --single-transaction -u $dbuser -p$dbpassword $dbname > ~/$databasebackup"

# copy datas from to backup server

sshpass -p "root" rsync --backup --backup-dir=`date +%Y.%m.%d` -a -e ssh 192.168.33.200:~/$databasebackup /home/BDD_BACKUP/DAYLI_BACKUP/$databasebackup



if [ "$numberOfDay" == "1" ];
then
	rsync --delete -avr /home/BDD_BACKUP/DAYLI_BACKUP/`date +%Y.%m.%d` /home/BDD_BACKUP/WEEKLY_BACKUP
fi

if [ -d /home/BDD_BACKUP/DAYLI_BACKUP/$thirtyDayAgo ];
then
	rm -r /home/BDD_BACKUP/DAYLI_BACKUP/$thirtyDayAgo/
fi

if [ -d /home/BDD_BACKUP/WEEKLY_BACKUP/$thirtyDayAgo ];
then
        rm -r /home/BDD_BACKUP/WEEKLY_BACKUP/$thirtyDayAgo/
fi

if [ "$day" == "01" ];
then
   	rm /home/BDD_BACKUP/MONTHLY_BACKUP/*
        tar -cvjf /home/BDD_BACKUP/MONTHLY_BACKUP/monthly_`date +%Y.%m.%d`.tar.bz2 /home/BDD_BACKUP/DAYLI_BACKUP/`date +%Y.%m.%d`/
fi


# put nextcloud back to normal mode
sshpass -p "root" ssh root@192.168.33.200 'sudo -u www-data /usr/bin/php /var/www/html/nextcloud/occ maintenance:mode --off'
