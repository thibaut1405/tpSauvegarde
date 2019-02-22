#/bin/bash
numberWeek=`date +%W`
thirtyDayAgo=`date +%Y.%m.%d -d "30 day ago"`
dateYesterday=`date +%Y.%m.%d -d "1 day ago"`
numberOfDay=`date +%w`
day=`date +%d`

if [ ! -d /home/NEXTCLOUD/ ];
then
	mkdir /home/NEXTCLOUD
fi

if [ ! -d /home/NEXTCLOUD/DAYLI_BACKUP ];
then
        mkdir /home/NEXTCLOUD/DAYLI_BACKUP
        sshpass -p "root" rsync --backup --backup-dir=`date +%Y.%m.%d` -a -e ssh 192.168.33.200:/var/www/html/nextcloud /home/NEXTCLOUD/DAYLI_BACKUP
else
	sshpass -p "root" rsync --backup --backup-dir=`date +%Y.%m.%d` -a -e ssh 192.168.33.200:/var/www/html/nextcloud /home/NEXTCLOUD/DAYLI_BACKUP

	if [ "$numberOfDay" == "1" ];
	then
		if [ -d /home/NEXTCLOUD/WEEKLY_BACKUP ];
		then
				rsync --delete -avr /home/NEXTCLOUD/DAYLI_BACKUP/* /home/NEXTCLOUD/WEEKLY_BACKUP/`date +%Y.%m.%d`/
		else
				mkdir /home/NEXTCLOUD/WEEKLY_BACKUP
				rsync --delete -avr /home/NEXTCLOUD/DAYLI_BACKUP/* /home/NEXTCLOUD/WEEKLY_BACKUP/`date +%Y.%m.%d`/
		fi
        fi
	if [ -d /home/NEXTCLOUD/DAYLI_BACKUP/$thirtyDayAgo ];
	then
		rm -r /home/NEXTCLOUD/DAYLI_BACKUP/$thirtyDayAgo
	fi
        if [ -d /home/NEXTCLOUD/WEEKLY_BACKUP/$thirtyDayAgo ];
        then
                rm -r /home/NEXTCLOUD/WEEKLY_BACKUP/$thirtyDayAgo
        fi
	if [ "$day" == "01" ];
	then
		if [ ! -d /home/NEXTCLOUD/MONTHLY_BACKUP ];
		then
			mkdir /home/NEXTCLOUD/MONTHLY_BACKUP
			tar -cvjf /home/NEXTCLOUD/MONTHLY_BACKUP/monthly_`date +%Y.%m.%d`.tar.bz2 /home/NEXTCLOUD/DAYLI_BACKUP/`date +%Y.%m.%d`/
		else
			rm /home/NEXTCLOUD/MONTHLY_BACKUP/*
			tar -cvjf /home/NEXTCLOUD/MONTHLY_BACKUP/monthly_`date +%Y.%m.%d`.tar.bz2 /home/NEXTCLOUD/DAYLI_BACKUP/`date +%Y.%m.%d`/
		fi
	fi
fi
