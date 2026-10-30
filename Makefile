SHELL := bash

.DEFAULT_GOAL := help

WORKSPACE    := $(realpath $(shell pwd))
PROJECT_NAME := $(notdir $(WORKSPACE))

# MakeLib bindet hier immer die eigenen Dateien aus src/ ein, nicht DEV_MAKE der
# Umgebung: Geprüft wird der Stand dieses Checkouts.
include $(WORKSPACE)/src/colours.mk
include $(WORKSPACE)/src/tools.mk

# ─── Hilfe ───────────────────────────────────────────────────────────────────

.PHONY: help
help: ## Alle verfügbaren Befehle anzeigen
	@echo
	@echo "Please use \`make <$(THEME_COLOR_GROUP)target$(RESET)>' where <target> is one of"
	@echo
	@echo "Project: $(THEME_COLOR_GROUP)$(PROJECT_NAME)$(RESET)"
	@echo
	@grep -hE '^(##@|[a-zA-Z0-9_-]+:.*?## )' $(MAKEFILE_LIST) | \
	  awk 'BEGIN {FS = ":.*## "}; \
	    /^##@/ { printf "\n$(THEME_INDENT_GROUP)$(THEME_COLOR_GROUP)%s$(RESET)\n", substr($$0, 4); next }; \
	    /## /  { printf "$(THEME_INDENT_TARGET)$(THEME_COLOR_TARGET)%-$(THEME_WIDTH_TARGET)s%$(THEME_COLUMN_GAP)s$(THEME_COLOR_DESC)%s$(RESET)\n", $$1, "", $$2 }'
	@echo

# ─── Setup ───────────────────────────────────────────────────────────────────

##@ Setup

# MakeLib hat keine Pakete und keine Git-Hooks. setup bleibt trotzdem der eine
# Einrichtungsweg (agent-lessons worktree_setup) und ist beliebig oft aufrufbar.
.PHONY: setup
setup: ## Projekt einrichten (MakeLib braucht nichts weiter)
	@echo -e "  $(GREEN)✓$(RESET) $(PROJECT_NAME) ist eingerichtet, nichts zu installieren"

# ─── Prüfen ──────────────────────────────────────────────────────────────────

##@ Prüfen

.PHONY: check
check: ## Beispiel-Makefile mit allen Themes, ohne Farben und ohne MakeLib prüfen
	@bash scripts/check.sh
