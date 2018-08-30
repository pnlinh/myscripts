#!/bin/bash
#
# Author: pnlinh1207@gmail.com
DOCKER_CONTAINER_NAME=ubuntu
DOCKER_IMAGE_NAME=pnlinh/ubuntu:latest
DOCKER_IMAGE_BACKUP_NAME=docker_image_content.tar.gz
# Cloud setting
REMOTE_NAME=name_setting_clound # Setting name cloud
SERVER_NAME=folder_for_backup # Folder name on Cloud
TIMESTAMP=$(date +"%F")
BACKUP_DIR="$TIMESTAMP"
mkdir -p "$BACKUP_DIR"
cd "$BACKUP_DIR" || return
# Commit docker container to image
docker commit "$DOCKER_CONTAINER_NAME" "$DOCKER_IMAGE_NAME"
echo "Commit docker to image successfully !"
# Push docker image to Dockerhub 
docker push "$DOCKER_IMAGE_NAME"
# Save docker image to zip file
docker save "$DOCKER_IMAGE_NAME" | gzip > "$DOCKER_IMAGE_BACKUP_NAME"
echo "Save docker image successfully !"
cd ..
echo "Starting uploading backup to Cloud"
rclone copy "$BACKUP_DIR" "$REMOTE_NAME:$SERVER_NAME/$BACKUP_DIR"
# Clean up folder backup
rm -rf "$BACKUP_DIR"
echo "Remove folder $BACKUP_DIR OK"
echo "Finished"
# Clean up folder backup on Cloud
# rclone -q --min-age 2w delete "$REMOTE_NAME:$SERVER_NAME" # Remove all backups older than 2 week
# rclone -q --min-age 2w rmdirs "$REMOTE_NAME:$SERVER_NAME" # Remove all empty folders older than 2 week
echo "All done :D"