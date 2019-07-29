#!/bin/bash

# check sudo permission
if [ `id -u` -eq 0 ];then
  echo "has sudo permission"
else
  echo "has not sudo permission"
  exit 1
fi

# install nginx
sudo apt-get install -y nginx
