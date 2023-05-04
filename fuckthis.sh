#!/bin/bash

# clear sources.list but shouldn't be empty
echo " " > /etc/apt/sources.list

# adding repos to sources.lis.d folder
add-apt-repository -n -y "deb http://archive.ubuntu.com/ubuntu/ jammy main restricted universe multiverse"
add-apt-repository -n -y "deb http://archive.ubuntu.com/ubuntu/ jammy-updates main restricted universe multiverse"
add-apt-repository -n -y "deb http://archive.ubuntu.com/ubuntu/ jammy-backports main restricted universe multiverse"
add-apt-repository -n -y "deb http://security.ubuntu.com/ubuntu jammy-security main restricted universe multiverse"

# The second run for System indentify it as template:
### Found existing deb entry in /etc/apt/sources.list.d/archive_uri-http_archive_ubuntu_com_ubuntu_-jammy.list
### Archive has template, updating /etc/apt/sources.list
add-apt-repository -n -y "deb http://archive.ubuntu.com/ubuntu/ jammy main restricted universe multiverse"
add-apt-repository -n -y "deb http://archive.ubuntu.com/ubuntu/ jammy-updates main restricted universe multiverse"
add-apt-repository -n -y "deb http://archive.ubuntu.com/ubuntu/ jammy-backports main restricted universe multiverse"
add-apt-repository -n -y "deb http://security.ubuntu.com/ubuntu jammy-security main restricted universe multiverse"

# All commented deb-src repo stay in sources.list.d and all deb repo will be in sources.list

apt update -y && apt uprade -y