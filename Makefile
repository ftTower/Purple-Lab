include vm_soc/*.mk


update :
	sudo apt update && sudo apt-get upgrade -y && sudo apt-get install git make vim -y && clear

make soc: update elastic_search_all kibana_all 
