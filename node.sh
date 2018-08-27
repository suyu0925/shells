#!/bin/bash

if [ `id -u` -eq 0 ];then
  echo "has sudo permission"
else
  echo "has not sudo permission"
  exit 1
fi

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

# install build tools
sudo apt-get install -y build-essential

# yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update && sudo apt-get install --no-install-recommends yarn

yarn --version

# global install pm2
sudo yarn global add pm2 -d

which pm2
