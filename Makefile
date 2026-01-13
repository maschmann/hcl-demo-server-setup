.PHONY: help install

INVENTORY ?= ansible/inventory
TOKEN ?= 
FLAGS ?= 
USER ?= 

help:
	@echo "Usage: make install TOKEN=<github_pat> [INVENTORY=<file>] [USER=<ssh_user>]"
	@echo "  INVENTORY: Path to inventory file (default: ansible/inventory)"
	@echo "  USER: Optional SSH user override. Better to set 'ansible_user' in inventory."
	@echo "  TOKEN: GitHub Personal Access Token (required for private repo access)"
	@echo "  FLAGS: Additional Ansible flags (e.g. '-k' for password prompt, '-K' for sudo password)"

install:
	@if [ -z "$(TOKEN)" ]; then echo "Error: TOKEN is required."; echo "Usage: make install TOKEN=..."; exit 1; fi
	ansible-playbook -i $(INVENTORY) $(if $(USER),-u $(USER),) ansible/playbook.yml -e "github_token=$(TOKEN)" $(FLAGS)
