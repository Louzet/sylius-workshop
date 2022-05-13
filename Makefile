DC := docker-compose -f docker-compose.yml
PHP := $(DC) exec php
NODE := $(DC) exec node


.DEFAULT_GOAL := help
.PHONY: help
help: ## Affiche cette aide
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-27s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: build
build: ## Build or rebuild services
	$(info Make: Build or rebuild services.)
	$(DC) build --remove-orphans

.PHONY: up
up: ## Builds, (re)creates, starts, and attaches to containers for a service.
	$(info Make: Builds, (re)creates, starts, and attaches to containers for a service.)
	$(DC) up -d

.PHONY: stop
stop: ## Stop running containers without remove them
	$(info Make: Stop running containers without remove them.)
	$(DC) stop

.PHONY: down
down: ## destroy images and containers created
	$(info Make: Destroy images and containers created.)
	$(DOCKER_COMPOSE) down --remove-orphans --volume

restart: stop up

.PHONY: ps
ps: ## Lists containers
	$(info Make: Lists containers.)
	$(DC) ps


.PHONY: logs
logs: ## Displays log output from services
	$(info Make: Displays log output from services.)
	$(DC) logs

###########
.PHONY: php
php: ## Jump inside the php container
	$(info Make: Jump inside the php container.)
	$(PHP) sh

.PHONY: node
node: ## Jump inside the node container
	$(info Make: Jump inside the node container.)
	$(NODE) sh