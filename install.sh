#!/bin/bash

COMPOSE_VERSION=1.27.4

if [ $# -eq 0 ]
  then
    echo "Enter the domain for the certificate."
    exit 1;
fi


echo "This script will download Docker, docker-compose, certbot and will generate a SSL certificate for the following domain:" $1;

echo "Press Ctrl + C to cancel."

sleep 5

sudo apt-get update

sudo apt-get install snapd

sudo snap install core; sudo snap refresh core

sudo snap install --classic certbot

sudo ln -s /snap/bin/certbot /usr/bin/certbot

curl https://get.docker.com | sh

sudo usermod -aG docker $USER

sudo curl -L "https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo certbot certonly --cert-name gitlab -d $1

sed -i "s/gitlab.your-domain.com/$1/" docker-compose.yml

sed -i "s/gitlab.your-domain.com/$1/" conf.d/gitlab.conf

sudo docker-compose up -d
