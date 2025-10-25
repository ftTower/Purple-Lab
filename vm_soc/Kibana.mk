.SILENT:

GREEN = \033[32m
RED = \033[31m
YELLOW = \033[33m
BLUE = \033[34m
NC = \033[0m # No Color

update:
	sudo apt update && sudo apt upgrade -y

dep :
	sudo apt-get install kibana nginx -y

kibana :
	sudo systemctl enable kibana
	sudo systemctl start kibana


reverse_proxy:
	echo "$(YELLOW)Configuring a Reverse Proxy for kibana...$(NC)"
	@/bin/bash -c 'read -p "Enter username: " username; \
	read -s -p "Enter password: " password; \
	echo; \
	sudo mkdir -p /etc/nginx; \
	echo "$$username:`echo $$password | openssl passwd -apr1 -stdin`" | sudo tee -a /etc/nginx/htpasswd.users'
	echo "$(BLUE)Getting domain or public IP...$(NC)"
	@domain=$$(hostname -f 2>/dev/null | grep -E '^[^.]+\.[^.]+' || echo ""); \
	if [ -z "$$domain" ]; then \
		echo "$(YELLOW)No domain found, getting public IP...$(NC)"; \
		public_ip=$$(curl -s https://ipinfo.io/ip 2>/dev/null || curl -s https://icanhazip.com 2>/dev/null || curl -s https://ifconfig.me 2>/dev/null || echo "localhost"); \
		domain=$$public_ip; \
	fi; \
	echo "$(GREEN)Using: $$domain$(NC)"; \
	sudo cp conf_kibana /etc/nginx/sites-available/kibana; \
	sudo sed -i "s/your_domain/$$domain/g" /etc/nginx/sites-available/kibana; \
	sudo mkdir -p /etc/nginx/sites-enabled; \
	sudo rm -f /etc/nginx/sites-enabled/default; \
	sudo ln -sf /etc/nginx/sites-available/kibana /etc/nginx/sites-enabled/; \
	sudo nginx -t && sudo systemctl reload nginx; \
	echo "$(GREEN)Kibana reverse proxy configured with domain/IP: $$domain$(NC)"; \
	echo "$(BLUE)Access Kibana at: http://$$domain$(NC)"

kibana_all: update dep kibana reverse_proxy
	