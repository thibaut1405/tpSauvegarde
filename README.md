# tpSauvegarde

Pour faire fonctionner mes scripts 

Les machine doivent garder la configuration réseau d'origine

 1 - Git clone du repository

 2 - Lancer le script init.sh

 3 - Une fois cela fais vous n'aurez plus qu'a run les scripts 

Pour tout automatiser il faudrait créer une crontab comme celle ci : 

30 17 * * * ~/tpSauvegarde/rsync.sh

30 17 * * * ~/tpSauvegarde/bdd.sh

Bon test (sans embaras je l'espère)
