include vm_soc/*.mk


update :
	sudo apt update && sudo apt-get upgrade -y && sudo apt-get install git make -y && clear

make soc: elastic_search_all kibana_all 
