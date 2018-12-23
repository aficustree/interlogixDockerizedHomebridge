#!/bin/sh

docker volume create homebridge
docker volume create nx584plugins
git clone https://github.com/aficustree/interlogixDockerizedHomebridge.git
mv ./interlogixDockerizedHomebridge/homebridge/* /var/lib/docker/volumes/homebridge/_data

git clone https://github.com/aficustree/nx584ADPlugin
mv ./nx584ADPlugin/* /var/lib/docker/volumes/nx584plugins/_data