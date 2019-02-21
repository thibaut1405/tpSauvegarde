#/bin/bash
numberWeek=`date +%W`
thirtyDayAgo=`date +%Y.%m.%d -d "30 day ago"`
dateYesterday=`date +%Y.%m.%d -d "1 day ago"`
numberOfDay=`date +%w`
day=`date +%d`

if [ ! -d /home/DAYLI_BACKUP ];
then
        mkdir /home/DAYLI_BACKUP
        sshpass -p "root" rsync --backup --backup-dir=`date +%Y.%m.%d` -a -e ssh 192.168.33.200:/var/www/html/nextcloud /home/DAYLI_BACKUP/DAYLI_`date +%Y.%m.%d`
else
	sshpass -p "root" rsync --backup --backup-dir=`date +%Y.%m.%d` -a -e ssh 192.168.33.200:/var/www/html/nextcloud /home/DAYLI_BACKUP/DAYLI_`date +%Y.%m.%d`

	if [ "$numberOfDay" == "1" ];
	then
		if [ -d /home/WEEKLY_BACKUP ];
		then
				rsync --delete -avr /home/DAYLI_BACKUP/DAYLI_`date +%Y.%m.%d`/ /home/WEEKLY_BACKUP
		else
				mkdir /home/WEEKLY_BACKUP
				rsync --delete -avr /home/DAYLI_BACKUP/DAYLI_`date +%Y.%m.%d`/ /home/WEEKLY_BACKUP
		fi
        fi
	if [ -d /home/DAYLI_BACKUP/DAYLI_$thirtyDayAgo ];
	then
		rm -r /home/DAYLI_BACKUP/DAYLI_$thirtyDayAgo
	fi
	if [ "$day" == "01" ];
	then
		if [ ! -d /home/MONTHLY_BACKUP ];
		then
			mkdir /home/MONTHLY_BACKUP
			tar -cvjf /home/MONTHLY_BACKUP/monthly_`date +%Y.%m.%d`.tar.bz2 /home/DAYLI_BACKUP/DAYLI_`date +%Y.%m.%d`/
		else
			rm /home/MONTHLY_BACKUP/*
			tar -cvjf /home/MONTHLY_BACKUP/monthly_`date +%Y.%m.%d`.tar.bz2 /home/DAYLI_BACKUP/DAYLI_`date +%Y.%m.%d`/
		fi
	fi
fi
