#!/bin/bash

# Load Variables
# sudo export $(grep -v '^#' .env | xargs)

# Universal /source.list

sudo rm -rf /etc/apt/sources.list
sudo cp ./sources.list /etc/apt/sources.list
sudo apt-get update -y && sudo apt upgrade -y

# Install CURL
sudo apt install curl -y

# Enable SSH
sudo apt install openssh-server -y
sudo systemctl enable ssh
sudo systemctl start ssh
sudo ufw allow ssh
sudo ufw enable

# IP set IP
sudo rm -rf /etc/network/interfaces
cp ./interfaces /etc/network/interfaces
sudo systemctl restart networking.service
sudo /etc/init.d/networking restart

# Install XRDP
sudo apt install ubuntu-desktop -y
chmod +x  ./xrdp-installer.sh
./xrdp-installer.sh -s -l
sudo ufw allow 3389/tcp
#    Add to .Xsession file
# unset DBUS_SESSION_BUS_ADDRESS
# unset XDG_RUNTIME_DIR

# Install Docker Engine
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update -y

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo apt install docker-compose


# Install Portainer
sudo docker volume create portainer_data
sudo docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
sudo ufw allow 9000