#!/bin/bash
if [ ! -d /home/BDD_BACKUP ];
then
        mkdir /home/BDD_BACKUP
fi

dbname=nextcloud
dbuser=root
dbpassword=root
databasebackup=db_`date +"%Y.%m.%d"`.sql

# put nextcloud instance to maintenance mode
sshpass -p "root" ssh root@192.168.33.200 'sudo -u www-data /usr/bin/php /var/www/html/nextcloud/occ maintenance:mode --on'

# dump the database
sshpass -p "root" ssh root@192.168.33.200 "mysqldump --single-transaction -u $dbuser -p$dbpassword $dbname > ~/$databasebackup"

# copy datas from to backup server
sshpass -p "root" rsync -avx root@192.168.33.200:~/$databasebackup /home/BDD_BACKUP/$databasebackup

# put nextcloud back to normal mode
sshpass -p "root" ssh root@192.168.33.200 'sudo -u www-data /usr/bin/php /var/www/html/nextcloud/occ maintenance:mode --off'
