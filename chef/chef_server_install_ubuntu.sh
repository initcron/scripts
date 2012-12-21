#!/bin/bash 
# This script installs Chef Server on Ubuntu 

echo "I: Installing chef server..."
echo "deb http://apt.opscode.com/ `lsb_release -cs`-0.10 main" | sudo tee /etc/apt/sources.list.d/opscode.list
sudo mkdir -p /etc/apt/trusted.gpg.d
gpg --keyserver keys.gnupg.net --recv-keys 83EF826A
gpg --export packages@opscode.com | sudo tee /etc/apt/trusted.gpg.d/opscode-keyring.gpg > /dev/null
sudo apt-get update
sudo apt-get install opscode-keyring # permanent upgradeable keyring
sudo apt-get upgrade -yq
sudo apt-get install chef chef-server -yq
echo "I: DONE"

echo "configuring knide command line client..."
mkdir -p ~/.chef
sudo cp /etc/chef/validation.pem /etc/chef/webui.pem ~/.chef
sudo chown -R $USER ~/.chef
echo "Running knife configure in interactive mode...."
knife configure -i


exit 0 

