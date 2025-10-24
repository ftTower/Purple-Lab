.SILENT:

update:
	sudo apt update && sudo apt upgrade -y

dep :
	sudo apt-get install curl vim git -y

elastic :
	curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
	sudo apt update && sudo apt install elasticsearch
	echo "Successfully installed elasticsearch"
	sudo cp ./conf_elastic_s.yml /etc/elasticsearch/elasticsearch.yml
	sudo systemctl start elasticsearch
	sudo systemctl enable elasticsearch
	echo "Successfully configured elasticsearch"
	curl -X GET "localhost:9200"

all : update dep elastic

clean:
	sudo systemctl stop elasticsearch
	sudo systemctl disable elasticsearch
	sudo apt remove elasticsearch -y
	sudo rm -f /etc/apt/sources.list.d/elastic-7.x.list
	sudo rm -f /usr/share/keyrings/elasticsearch-keyring.gpg
	sudo apt update

.PHONY: update dep elastic all clean