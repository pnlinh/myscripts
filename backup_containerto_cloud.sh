#!/bin/bash
#
# @athor: pnlinh1207@gmail.com
#
# @link: https://www.cyberciti.biz/faq/howto-linux-unix-start-restart-cron/
#
# vi /etc/crontab
# 0  1    * * *   root    bash /root/docker_backup.sh > /dev/null  2>&1
# sudo /etc/init.d/cron restart
# sudo service cron restart
# /etc/init.d/cron restart

DOCKER_CONTAINER_NAME=ubuntu
DOCKER_CONTAINER_BACKUP_NAME=docker-content.tar.gz
GDRIVE_FOLDER_BACKUP_ID=0B3-tPMOH_TBFd05WTUljb2w3QkU

echo "Backing up Container"
docker export "$DOCKER_CONTAINER_NAME" | pv -cN "Docker Export Container" | gzip > /root/dockerbackup/"$DOCKER_CONTAINER_BACKUP_NAME"
echo "Uploading to Cloud"
/usr/local/bin/gdrive update "$GDRIVE_FOLDER_BACKUP_ID" /root/dockerbackup/"$DOCKER_CONTAINER_BACKUP_NAME"
rm -f /root/dockerbackup/"$DOCKER_CONTAINER_BACKUP_NAME"
echo "[!] All done"