#!/bin/bash

wget https://download.docker.com/linux/debian/dists/stretch/pool/stable/amd64/docker-ce_18.06.3~ce~3-0~debian_amd64.deb
sudo dpkg --install docker-ce_18.06.3~ce~3-0~debian_amd64.deb
sudo docker run hello-world
sudo groupadd docker
sudo usermod -aG docker $USER
