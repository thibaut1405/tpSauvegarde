#!/bin/bash
#
## on se place dans le repertoire ou l'on veut sauvegarder les bases
#
if [ ! -d /home/BDD_BACKUP ];
then
        mkdir /home/BDD_BACKUP
fi
cd /home/BDD_BACKUP
# Récupère toutes les bases de données
sshpass -p "root" ssh root@192.168.33.200 "mysqldump -u root -p'root' nextcloud > backup.sql"
#sshpass -p "root" ssh root@192.168.33.200 databases=`mysql --user=root --password=root -e "SHOW DATABASES;" | grep -Ev "(information_schema|performance_schema|mysql|sys)"`

# parcours les bases

#for i in $databases; do

## Sauvegarde des bases de donnees en fichiers .sql
#mysqldump --user=root --password=root $i > ${i}_`date +"%Y-%m-%d"`.sql
## Compression des exports en tar.bz2 (le meilleur taux de compression)
#tar jcf ${i}_`date +"%Y-%m-%d"`.sql.tar.bz2 ${i}_`date +"%Y-%m-%d"`.sql

## Suppression des exports non compresses
#rm ${i}_`date +"%Y-%m-%d"`.sql

#done

