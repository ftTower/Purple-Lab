

update:
	sudo apt update && sudo apt upgrade -y

dep :
	sudo apt-get install curl vim git -y

elastic :
	curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
	echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
	sudo apt update && sudo apt install elasticsearch
	sudo cp vm_soc/conf_elastic_s.yml /etc/elasticsearch/elasticsearch.yml

all : update dep elastic
