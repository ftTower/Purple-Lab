include ./vm_soc/*.mk


update :
	sudo apt update && sudo apt-get upgrade -y && sudo apt-get install git make vim -y && clear


msg :
	echo "$(FOCUS)installation Finished$(NC)"

soc: update kibana_all elastic_search_all msg
