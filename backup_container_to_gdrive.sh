#!/bin/bash
#
# @athor: pnlinh1207@gmail.com
#
# @link: https://www.cyberciti.biz/faq/howto-linux-unix-start-restart-cron/
#
# vi /etc/crontab
# 0  1    * * *   root    bash /root/backup_container_to_gdrive.sh > /dev/null  2>&1
# sudo /etc/init.d/cron restart
# sudo service cron restart
# /etc/init.d/cron restart

# Docker config
DOCKER_CONTAINER_NAME=ubuntu
DOCKER_CONTAINER_BACKUP_NAME=docker-content.tar.gz
# Gdrive config
GDRIVE_FOLDER_ID=0B3-tPMOH_TBFd05WTUljb2w3QkU
GDRIVE_FILE_ID=0B3X9GlR6EmbnNTk0SkV0bm5Hd0E

echo "Backing up Container..."
docker export "$DOCKER_CONTAINER_NAME" | pv -cN "Docker Export Container" | gzip > /root/dockerbackup/"$DOCKER_CONTAINER_BACKUP_NAME"
echo "Uploading to Gdrive..."
# /usr/local/bin/gdrive update --parent "$GDRIVE_FOLDER_ID" "$GDRIVE_FILE_ID" /root/dockerbackup/"$DOCKER_CONTAINER_BACKUP_NAME"
/usr/local/bin/gdrive update "$GDRIVE_FILE_ID" /root/dockerbackup/"$DOCKER_CONTAINER_BACKUP_NAME"
rm -f /root/dockerbackup/"$DOCKER_CONTAINER_BACKUP_NAME"
echo "[!] All done"