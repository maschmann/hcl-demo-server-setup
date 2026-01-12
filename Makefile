.PHONY: help install

HOST ?= raspberrypi.local
USER ?= pi
TOKEN ?= 
FLAGS ?= 

help:
	@echo "Usage: make install TOKEN=<github_pat> [HOST=<hostname_or_ip>] [USER=<ssh_user>]"
	@echo "  HOST: Target host (default: raspberrypi.local)"
	@echo "  USER: SSH user (default: pi)"
	@echo "  TOKEN: GitHub Personal Access Token (required for private repo access)"
	@echo "  FLAGS: Additional Ansible flags (e.g. '-k' for password prompt)"

install:
	@if [ -z "$(TOKEN)" ]; then echo "Error: TOKEN is required."; echo "Usage: make install TOKEN=..."; exit 1; fi
	ansible-playbook -i $(HOST), -u $(USER) ansible/playbook.yml -e "github_token=$(TOKEN)" $(FLAGS)
