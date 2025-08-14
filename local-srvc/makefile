
COMPOSE_FILES := $(wildcard compose.*.yaml)
BASE_FILE := compose.yaml

up:
	@docker compose -f $(BASE_FILE) $(foreach f,$(COMPOSE_FILES),-f $(f)) up -d

down:
	@docker compose -f $(BASE_FILE) $(foreach f,$(COMPOSE_FILES),-f $(f)) down
