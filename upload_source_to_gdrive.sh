#!/bin/bash
#
# @athor: pnlinh1207@gmail.com
#
# @link: https://www.cyberciti.biz/faq/howto-linux-unix-start-restart-cron/
#
# vi /etc/crontab
# 0  2    * * *   root    bash /root/upload_source_to_gdrive.sh > /dev/null  2>&1
# sudo /etc/init.d/cron restart
# sudo service cron restart
# /etc/init.d/cron restart
TIMESTAMP=$(date +"%F")
BACKUP_FILE_NAME=/root/"$TIMESTAMP"_backup.zip
PARENT_ID=gdrive_id # ./gdrive list to get ID you need
cd dockershare/ || return
echo "Compressing..."
zip -r "$BACKUP_FILE_NAME" .
echo "Compress OK"
cd ~ || return
echo "Uploading..."
./gdrive upload --parent "$PARENT_ID" "$BACKUP_FILE_NAME"
echo "Upload OK"
# Remove backup file
rm "$BACKUP_FILE_NAME"
echo "Remove file OK"
echo "[!] All done :D"