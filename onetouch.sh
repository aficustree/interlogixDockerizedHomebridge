#!/bin/sh
# run with env variable set to your PIN number

echo "env vari is: "
echo $PIN
export PIN=$PIN
docker volume create homebridge
docker volume create nx584plugins
cd /usr/local/src/alarm
rm -rf ./tmp
git clone https://github.com/aficustree/interlogixDockerizedHomebridge.git tmp 
if [ $? -eq 0 ]
then
  rm -rf ./interlogixDockerizedHomebridge
  mv ./tmp ./interlogixDockerizedHomebridge
  cmp -s ./interlogixDockerizedHomebridge/onetouch.sh ./onetouch.sh
  if [ $? -eq 1 ]
  then
    cp ./interlogixDockerizedHomebridge/onetouch.sh .
    chmod 755 onetouch.sh
    exec onetouch.sh
  fi
  rm -rf /var/lib/docker/volumes/homebridge/_data/*
  mv ./interlogixDockerizedHomebridge/homebridge/* /var/lib/docker/volumes/homebridge/_data
else
  echo "Couldn't pull interlogixDockerizedHomebridge, using existing"
fi
rm -rf ./tmp
git clone https://github.com/aficustree/nx584ADPlugin tmp
if [ $? -eq 0 ]
then
  rm -rf ./nx584ADPlugin
  mv ./tmp ./nx584ADPlugin
  rm -rf /var/lib/docker/volumes/nx584plugins/_data/*
  mv ./nx584ADPlugin/* /var/lib/docker/volumes/nx584plugins/_data
else
  echo "Couldn't pull nx584ADPlugin, using existing"
fi
cat /var/lib/docker/volumes/homebridge/_data/config.json | jq --arg mypin "$PIN" '(.platforms[] | select (.platform == "alarmdecoder-platform").setPIN)=$mypin' | sponge /var/lib/docker/volumes/homebridge/_data/config.json
cd ./interlogixDockerizedHomebridge
docker-compose build pynx584
docker-compose pull homebridge
docker-compose up -d
exit 0