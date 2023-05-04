#!/bin/bash

# Load Variables
# sudo export $(grep -v '^#' .env | xargs)

# Universal /source.list
# clear sources.list but shouldn't be empty
echo " " > /etc/apt/sources.list

# adding repos to sources.lis.d folder
add-apt-repository -n -y "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc) main restricted universe multiverse"
add-apt-repository -n -y "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc)-updates main restricted universe multiverse"
add-apt-repository -n -y "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc)-backports main restricted universe multiverse"
add-apt-repository -n -y "deb http://security.ubuntu.com/ubuntu $(lsb_release -sc)-security main restricted universe multiverse"

# The second run for System indentify it as template:
### Found existing deb entry in /etc/apt/sources.list.d/archive_uri-http_archive_ubuntu_com_ubuntu_-jammy.list
### Archive has template, updating /etc/apt/sources.list
add-apt-repository -n -y "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc) main restricted universe multiverse"
add-apt-repository -n -y "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc)-updates main restricted universe multiverse"
add-apt-repository -n -y "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc)-backports main restricted universe multiverse"
add-apt-repository -n -y "deb http://security.ubuntu.com/ubuntu $(lsb_release -sc)-security main restricted universe multiverse"

# All commented deb-src repo stay in sources.list.d and all deb repo will be in sources.list

apt update -y && apt uprade -y

# Install CURL
sudo apt install curl -y

# Enable SSH
#sudo apt install openssh-server -y
#sudo systemctl enable ssh
#sudo systemctl start ssh
#sudo ufw allow ssh
#sudo ufw enable

## Set LAN Address
# sudo rm -rf /etc/network/interfaces
# cp ./interfaces /etc/network/interfaces
# sudo systemctl restart networking.service
# sudo /etc/init.d/networking restart

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

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose 
docker-compose --version


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

# Install & Configure DDClient
#sudo apt-get install ddclient libio-socket-ssl-perl
#sudo rm -rf /etc/ddclient.conf
#sudo cp ./ddclient.conf /etc/ddclient.conf
#sudo service ddclient restart

# Install webmin
curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh
sh setup-repos.sh
apt-get install webmin

# Enable Multi-Arch
#sudo dpkg --add-architecture i386
#sudo apt-get update
#sudo apt-get dist-upgrade
#sudo apt-get install libgtk2.0-0:i386 libpangox-1.0-0:i386 libpangoxft-1.0-0:i386 libidn11:i386 libglu1-mesa:i386
#sudo apt-get install -f

# Install wine
#sudo dpkg --add-architecture i386
#sudo wget -nc https://dl.winehq.org/wine-builds/Release.key
#sudo apt-key add Release.key

#sudo apt-get update
#sudo apt-get install --install-recommends winehq-stable -y
