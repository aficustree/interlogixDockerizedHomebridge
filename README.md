# interlogixDockerizedHomebridge

Setup a RPi using a USB->Serial adapter to a NX584 automation panel. System automatically checks for later version on boot and updates before launching. If the system cannot access the internet, the system boots it's last state without intervention. 

## Pre-Reqs

Script requires moreutils, ptyhon3, pip3, docker and docker-compose.

```bash
apt-get -y install moreutils python3 python3-pip
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
pip3 install docker-compose
```

## Installation

- Clone this repo to `/usr/local/src/alarm`
- move the sample systemd file to  `/etc/systemd/system/` then activate it `systemctl enable nx584autoupdater`
- move the onetouch script to the root of `/usr/local/src/alarm`
- echo the environment file and append to `/etc/environment`
- update /etc/environment with your PIN number
- run `onetouch.sh`
- reboot

