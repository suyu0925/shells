#!/bin/bash

## Check if redis has already installed
redis_path=$(which redis-server)

if [ ! -n "$redis_path" ]; then
  exit 0
fi

#############################################
# Need su permission for following
#############################################

# Install the Build and Test Dependencies
sudo apt-get update
sudo apt-get install build-essential tcl

# Download, Compile, and Install Redis

## Download and Extract the Source Code
cd /tmp

# Now, download the latest stable version of Redis. This is always available at a stable download URL:
curl -O http://download.redis.io/redis-stable.tar.gz

# Unpack the tarball by typing:
tar xzvf redis-stable.tar.gz

# Move into the Redis source directory structure that was just extracted:
cd redis-stable

## Build and Install Redis

# Now, we can compile the Redis binaries by typing:
make

# After the binaries are compiled, run the test suite to make sure everything was built correctly
make test

# This will typically take a few minutes to run. Once it is complete
sudo make install

## Configure Redis

# To start off, we need to create a configuration directory. We will use the conventional /etc/redis directory
sudo mkdir /etc/redis
sudo cp /tmp/redis-stable/redis.conf /etc/redis

# modify configuration
sudo cp /etc/redis/redis.conf /etc/redis/default.conf 
sudo cp `dirname $0`/redis/redis.conf /etc/redis

# Create a Redis systemd Unit File
sudo cp `dirname $0`/redis/redis.service /etc/systemd/system/redis.service

## Create the Redis User, Group and Directories

sudo adduser --system --group --no-create-home redis

sudo mkdir /var/lib/redis

sudo chown redis:redis /var/lib/redis

sudo chmod 770 /var/lib/redis

## Start and Test Redis

# Start the Redis Service
sudo systemctl start redis

# Check that the service had no errors by running:
sudo systemctl status redis

## Enable Redis to Start at Boot

# If all of your tests worked, and you would like to start Redis automatically when your server boots, you can enable the systemd service.
sudo systemctl enable redis

echo "install done, now you can test redis with redis-cli"
