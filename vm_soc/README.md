# Security Operations Center Setup

## About

### ISO

linux used : https://releases.ubuntu.com/24.04.3/ubuntu-24.04.3-desktop-amd64.iso

### SOC tools 

```
Elasticstack
    Elastic Search - storage and search 
    Logstash       - processing and logs normalisation
    Kibana         - alert and visualisation
```

## Setup

```bash
    sudo apt update && sudo apt-get upgrade -y && sudo apt-get install git && git clone https://github.com/ftTower/Purple-Lab.git && cd Purple-Lab && clear && pwd && ls && make soc 
```