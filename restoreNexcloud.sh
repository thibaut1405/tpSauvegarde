echo "Entrez la date de restauration que vous souhaitez (format : 2019.02.25) :"
read saisie

if [ ! -d /home/DAYLI_BACKUP/DAYLI_$saisie ];
then
	echo "Ce dossier ne peut être trouvé"
else
	sshpass -p "root" rsync -a -e ssh /home/DAYLI_BACKUP/DAYLI_$saisie/nextcloud/* 192.168.33.200:/var/www/html/nextcloud
	echo "vos fichiers ont bien été restorés"
fi
