#!/bin/bash
#
# @author: pnlinh1207@gmail.com
#
# @link: https://www.cyberciti.biz/faq/howto-linux-unix-start-restart-cron/
#
# vi /etc/crontab
# 0  1    * * *   root    bash /root/docker_backup.sh > /dev/null  2>&1
# sudo /etc/init.d/cron restart
# sudo service cron restart
# /etc/init.d/cron restart
DOCKER_CONTAINER_NAME=ubuntu
DOCKER_IMAGE_NAME=pnlinh/ubuntu:latest
# Commit docker container to image
echo "Committing container..."
docker commit "$DOCKER_CONTAINER_NAME" "$DOCKER_IMAGE_NAME"
echo "Commit container to image successfully !"
# Push docker image to Dockerhub 
echo "Pushing image to Docker Hub..."
docker push "$DOCKER_IMAGE_NAME"
echo "Push image to Docker Hub successfully !"
echo "[!] All done"