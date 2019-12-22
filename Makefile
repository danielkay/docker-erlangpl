P := "$$(tput setaf 2)"
S := "$$(tput setaf 4)"
L := "$$(tput setaf 6)"
G := "$$(tput setaf 10)"
R := "$$(tput sgr0)"
usage:
	@echo ""
	@echo " $(L)┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓$(R)"
	@echo " $(L)┃ $(R)Docker Development Stack - Erlangpl Sidecar$(L) ┃$(R)"
	@echo " $(L)┡━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┩$(R)"
	@echo " $(L)│ $(R)Available Commands:$(L)                         │$(R)"
	@echo " $(L)╰─┬───────────────────────────────────────────╯$(R)"
	@echo "   $(L)╰─$(R) $(P)up$(R) - launch erlangpl container"
	@echo ""

MKFILE := $(abspath $(lastword $(MAKEFILE_LIST)))
MKDIR  := $(dir $(MKFILE))

# Shortcuts
up:
	@if [ -z ${ERLANG_CONTAINER} ] | [ -z ${ERLANG_CONTAINER} ]; then\
		echo "Usage: APP_NAME=phoenix ERLANG_CONTAINER=docker-phoenix_app_1 make up";\
	else\
		echo "$(P)Launching Erlangpl Container...$(R)";\
		COMPOSE_IGNORE_ORPHANS=True docker-compose --log-level ERROR -p dockerstack up -d;\
		echo "$(G)Done!$(R)\n\r";\
	fi
