#!/bin/bash

echo "A bashscipt to install a hyperledger fabric node based on the tutorial: https://medium.com/@eSizeDave/https-medium-com-esizedave-how-to-install-hyperledger-fabric-1-2-on-ubuntu-16-04-lts-ecdfa4dcec72"

echo "TESTED ON UBUNTU 16.04 LTS SERVER 64 BIT. SUGGESTED RAM 4 GB"

echo "Updating and upgrading the system"
sudo apt-get update
sudo apt-get -y upgrade

echo "install python"
sudo apt-get install -y python

echo "Install required packages for the installation script"
sudo apt-get install -y curl apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "install docker engine and docker compose"
sudo apt-get update
sudo apt-get install -y docker-ce

sudo chmod +x /usr/local/bin/docker-compose

echo "install golang"
curl -O https://storage.googleapis.com/golang/go1.10.3.linux-amd64.tar.gz
tar -xvf go1.10.3.linux-amd64.tar.gz
sudo mv go /usr/local

echo "export golang path variables"
echo export GOPATH=$HOME/go >> ~/.profile
echo export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin >> ~/.profile

echo "correct the locale"
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

source ~/.profile

echo "install more essential packages"
sudo apt-get update
sudo apt-get install -y build-essential openssl libssl-dev pkg-config

cd /usr/local/src
sudo mkdir node
cd node

echo "install node"
echo "THIS WILL TAKE A LOT OF TIME"
sudo wget https://nodejs.org/dist/v8.9.3/node-v8.9.3.tar.gz
sudo tar zxvf node-v8.9.3.tar.gz
cd node-v8.9.3
sudo ./configure
sudo make
sudo make install

echo "install npm"
sudo npm install -y npm@5.6.0 -g

echo "Deal with Hyperledger Fabric"
cd /usr/local
sudo mkdir hyperledger
cd hyperledger
curl -sSL http://bit.ly/2ysbOFE | sudo bash -s 1.2.0
export PATH=/usr/local/hyperledger/fabric-samples/bin:$PATH

echo "generate genesis block"
cd /usr/local/hyperledger/fabric-samples/first-network
sudo ./byfn.sh generate
