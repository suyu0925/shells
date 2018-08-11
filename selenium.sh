#!/bin/bash

if [ `id -u` -eq 0 ];then
  echo "has sudo permission"
else
  echo "has not sudo permission"
  exit 1
fi

firefox() {
  ## Firefox and geckodriver
  sudo apt-get install -y firefox

  geckodriver_path=$(which geckodriver)
  if [ ! -n "$geckodriver_path" ]; then
    echo "start install geckodriver..."
  else
    echo "geckodriver has already installed on "$geckodriver_path
    return 0
  fi

  cd /tmp

  wget https://github.com/mozilla/geckodriver/releases/download/v0.21.0/geckodriver-v0.21.0-linux64.tar.gz

  tar xzvf geckodriver-v0.21.0-linux64.tar.gz

  sudo cp ./geckodriver /usr/local/bin

  geckodriver--version
}

chromium() {
  ## Chromium and chromedriver
  sudo apt-get install -y chromium

  cd /tmp

  wget https://chromedriver.storage.googleapis.com/2.41/chromedriver_linux64.zip

  # NOTICE: can not reach googleapis.com, abandon chromium
}

firefox
