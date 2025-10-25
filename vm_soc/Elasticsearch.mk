.SILENT:

GREEN = \033[32m
RED = \033[31m
YELLOW = \033[33m
BLUE = \033[34m
BLINK = \033[5m

NC = \033[0m # No Color

update:
	sudo apt update && sudo apt upgrade -y

dep :
	sudo apt-get install curl -y

elastic :
	curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
	sudo apt update && sudo apt install elasticsearch
	sudo cp ./vm_soc/conf_elastic_s.yml /etc/elasticsearch/elasticsearch.yml
	sudo systemctl start elasticsearch
	sudo systemctl enable elasticsearch
# 	curl -X GET "localhost:9200"

elastic_search_msg :
	echo "$(FOCUS)Successfully installed and configured elasticsearch$(NC)"


elastic_search_all : update
	make -f Elasticsearch.mk dep
	make -f Elasticsearch.mk elastic
	make -f Elasticsearch.mk elastic_search_msg


clean:
	sudo systemctl stop elasticsearch
	sudo systemctl disable elasticsearch
	sudo apt remove elasticsearch -y
	sudo rm -f /etc/apt/sources.list.d/elastic-7.x.list
	sudo rm -f /usr/share/keyrings/elasticsearch-keyring.gpg
	sudo apt update

.PHONY: update dep elastic all clean