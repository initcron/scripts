#!/bin/bash

apt-get install build-essential -yq
apt-get install libfuse-dev -yq
apt-get install fuse-utils -yq
apt-get install libcurl4-openssl-dev -yq
apt-get install libxml2-dev -yq
apt-get install mime-support -yq


cd /usr/local/src
wget -c http://s3fs.googlecode.com/files/s3fs-1.73.tar.gz 
tar -xzf s3fs-1.73.tar.gz
cd s3fs-1.73
./configure --prefix=/usr
make
make install

