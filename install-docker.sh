#!../../../usr/bin/bash
echo Installing Docker

read -p "Production install? (y/N): " production

echo Removing Legacy Version

sudo apt-get remove docker docker-engine

echo Installing Prerequisites

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common 

echo Downloadking Repository Key

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo Setting Up Repository

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo Updating Package Index

sudo apt-get update

echo Installing Docker Community Edition

if [[ "$production" == "y" ]]
then
	apt-cache madison docker-ce
	read -p "Version (latest): " version
	if [[ "$version" -ne "" ]]
	then
		sudo apt-get install docker-ce=$version
	else
		sudo apt-get install docker-ce
	fi
fi
	
echo Running Test Container

sudo docker run hello-world
