# Security Operations Center Setup

## About

### ISO

linux used : https://releases.ubuntu.com/24.04.3/ubuntu-24.04.3-desktop-amd64.iso


Ensure VM use DHCP for the NAT network:

```
sudo bash -c 'cat <<EOF > /etc/network/interfaces
# Network interfaces configuration

source /etc/network/interfaces.d/*

auto lo
iface lo inet loopback

auto enp0s3
iface enp0s3 inet dhcp
EOF'
sudo systemctl restart networking
clear && ip a
```

### SOC tools 

```
Elasticstack
    Elastic Search - storage and search 
    Logstash       - processing and logs normalisation
    Kibana         - alert and visualisation
```

## Setup

```bash
    sudo apt update && sudo apt-get upgrade -y && sudo apt-get install git make && git clone https://github.com/ftTower/Purple-Lab.git && cd Purple-Lab && clear && pwd && ls && make soc 
```