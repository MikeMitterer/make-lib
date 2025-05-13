# Define standard colors
# Weitere Infos:
#	https://gist.github.com/rsperl/d2dfe88a520968fbc1f49db0a29345b9
#

ifneq (,$(findstring xterm,${TERM}))
	# BLACK        := $(shell tput -Txterm setaf 0)
	# RED          := $(shell tput -Txterm setaf 1)
	# GREEN        := $(shell tput -Txterm setaf 2)
	# YELLOW       := $(shell tput -Txterm setaf 3)
	# LIGHTPURPLE  := $(shell tput -Txterm setaf 4)
	# PURPLE       := $(shell tput -Txterm setaf 5)
	# BLUE         := $(shell tput -Txterm setaf 6)
	# WHITE        := $(shell tput -Txterm setaf 7)

	BLACK        := $(shell printf "\033[38;5;%sm" 0)
	RED          := $(shell printf "\033[38;5;%sm" 1)
	GREEN        := $(shell printf "\033[38;5;%sm" 2)
	YELLOW       := $(shell printf "\033[38;5;%sm" 3)
	LIGHTPURPLE  := $(shell printf "\033[38;5;%sm" 200)
	PURPLE       := $(shell printf "\033[38;5;%sm" 135)
	BLUE         := $(shell printf "\033[38;5;%sm" 6)
	WHITE        := $(shell printf "\033[38;5;%sm" 7)


	# No-Color
	RESET := $(shell tput -Txterm sgr0)
	NC := $(shell tput -Txterm sgr0)
else
	BLACK        := ""
	RED          := ""
	GREEN        := ""
	YELLOW       := ""
	LIGHTPURPLE  := ""
	PURPLE       := ""
	BLUE         := ""
	WHITE        := ""

	# No-Color
	RESET        := ""
	NC           := ""
endif

# Die Farben können als Sample ausgegeben werden
#
# Usage:
#     colors: ## show all the colors
#	      $(call print_colours)
define print_colours
	@echo "256 Farben Tabelle:"
	@for i in {0..255}; do \
		printf "\033[38;5;%sm%4s\033[0m " $$i $$i; \
		if [ $$((($$i + 1) % 16)) -eq 0 ]; then \
			echo ""; \
		fi; \
	done
endef


