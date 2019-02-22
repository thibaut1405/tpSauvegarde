#/bin/bash

dbname=nextcloud
dbuser=root
dbpassword=root
databasebackup=db_`date +"%Y.%m.%d"`.sql

# put nextcloud instance to maintenance mode
sshpass -p "root" ssh root@192.168.33.200 'sudo -u www-data /usr/bin/php /var/www/html/nextcloud/occ maintenance:mode --on'
# dump the database
echo "date"
read saisie

sshpass -p "root" scp -r -p /home/BDD_BACKUP/DAYLI_BACKUP/db_$saisie.sql root@192.168.33.200:~/db_$saisie.sql
sshpass -p "root" ssh root@192.168.33.200 "mysql -u $dbuser -p$dbpassword nextcloud < ~/db_$saisie.sql"

# Get out of maintenance mode
sshpass -p "root" ssh root@192.168.33.200 'sudo -u www-data /usr/bin/php /var/www/html/nextcloud/occ maintenance:mode --off'


