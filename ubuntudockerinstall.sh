#!bin/bash
sudo apt-get remove -y docker docker-engine
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce
sudo systemctl enable docker
sudo systemctl start docker

sudo mkdir -p /etc/systemd/system/docker.service.d/
#sudo cat >/etc/systemd/system/docker.service.d/docker.conf << EOL
sudo tee /etc/systemd/system/docker.service.d/docker.conf << EOL
[Service]
EnvironmentFile=/etc/default/docker
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// \$DOCKER_OPTS
EOL

sudo sed -i -e 's/.*DOCKER_OPTS=.*/DOCKER_OPTS="--storage-driver=overlay2"/' /etc/default/docker

sudo systemctl daemon-reload
sudo systemctl restart docker
sudo docker info