if [ ! -d /home/NEXTCLOUD/DAYLI_BACKUP/nextcloud ];
then
	echo "Ce dossier ne peut être trouvé"
else
	sshpass -p "root" rsync -a /home/NEXTCLOUD/DAYLI_BACKUP/nextcloud/* -e ssh 192.168.33.200:/var/www/html/nextcloud
	echo "vos fichiers ont bien été restorés"
fi
