#!bin/bash
#
# Author: pnlinh1207@gmail.com
echo "Install zip"
apt-get install zip
echo "Install zip OK"
wget https://downloads.rclone.org/v1.41/rclone-v1.41-linux-amd64.zip
unzip rclone-v*.zip
\cp rclone-v*-linux-amd64/rclone /usr/sbin/
rm -rf rclone-*
echo "Install Rclone OK"
echo "Setup config for Rclone"
rclone config