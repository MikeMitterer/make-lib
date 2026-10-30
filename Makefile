SHELL := bash

.DEFAULT_GOAL := help

WORKSPACE    := $(realpath $(shell pwd))
PROJECT_NAME := $(notdir $(WORKSPACE))

# Release-Tags der pipx-Werkzeuge (makefile-conventions, Gemeinsame Werkzeuge)
include .dev-tools.conf.sh

# MakeLib bindet hier immer die eigenen Dateien aus src/ ein, nicht DEV_MAKE der
# Umgebung: Geprüft wird der Stand dieses Checkouts.
include $(WORKSPACE)/src/colours.mk
include $(WORKSPACE)/src/tools.mk

# BashLib nur für die Maintainer-Targets: Umgebung, sonst das pipx-Paket.
BASH_LIBS ?= $(shell bashlib-path 2>/dev/null)
export BASH_LIBS

PROJECTTOOLS_MIN     := $(patsubst v%,%,$(firstword $(subst +, ,$(PROJECTTOOLS_TAG))))
PROJECTTOOLS_INSTALL := pipx install --force 'git+https://github.com/MikeMitterer/bash-ProjectTools.git@$(PROJECTTOOLS_TAG)'
PROJECTTOOLS_FOUND    = $(shell projecttools --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
BASHLIB_INSTALL      := pipx install 'git+https://github.com/MikeMitterer/bash-lib.git@$(BASHLIB_TAG)'

# Kennzeichnet in der Hilfe Targets, die BashLib brauchen. In der
# Target-Beschreibung steht dafür am Ende „— Maintainer“.
MAINTAINER_MARK = $(THEME_COLOR_DANGER)[Maintainer]$(THEME_COLOR_DESC)

# Prüft vor Maintainer-Targets, ob BashLib vorhanden ist.
define require_bash_libs
	@test -r "$(BASH_LIBS)/version.lib.sh" || { \
		echo -e "  $(RED)✗$(RESET) Nur für Maintainer: benötigt BashLib ($(YELLOW)BASH_LIBS$(RESET))." >&2; \
		echo -e "    $(BASHLIB_INSTALL)" >&2; \
		exit 1; }
endef

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
	    /## /  { desc = $$2; sub(/ — Maintainer$$/, " $(MAINTAINER_MARK)", desc); \
	             printf "$(THEME_INDENT_TARGET)$(THEME_COLOR_TARGET)%-$(THEME_WIDTH_TARGET)s%$(THEME_COLUMN_GAP)s$(THEME_COLOR_DESC)%s$(RESET)\n", $$1, "", desc }'
	@echo

.PHONY: info
info: ## Umgebungsvariablen und Werkzeugversionen anzeigen
	@echo
	@echo "    $(YELLOW)PROJECT_NAME$(RESET)  = $(BLUE)$(PROJECT_NAME)$(RESET)"
	@echo "    $(YELLOW)WORKSPACE$(RESET)     = $(BLUE)$(WORKSPACE)$(RESET)"
	@echo "    $(YELLOW)BASH_LIBS$(RESET)     = $(BLUE)$(or $(BASH_LIBS),nicht gefunden)$(RESET)"
	@echo "    $(YELLOW)ProjectTools$(RESET)  = $(BLUE)$(or $(PROJECTTOOLS_FOUND),nicht gefunden)$(RESET) (verlangt ab $(PROJECTTOOLS_MIN))"
	@echo

# Repo-Adresse aus git remote origin (SSH oder HTTPS) als https-URL, und der
# letzte Release-Tag. Werte von außen landen im Rezept; nur erlaubte Zeichen
# übernehmen, sonst leer.
REPO_URL    := $(shell git remote get-url origin 2>/dev/null | sed -E 's|^git@([^:]+):|https://\1/|; s|\.git$$||' | grep -xE '[A-Za-z0-9._:/@+~-]+')
RELEASE_TAG := $(or $(shell git describe --tags --abbrev=0 2>/dev/null | grep -xE '[A-Za-z0-9._+-]+'),vX.Y.Z)
NO_REMOTE   := kein Remote origin (git remote add origin …)

# Eine Zeile für hints: Beschriftung, auf THEME_WIDTH_TARGET Zeichen aufgefüllt,
# dann der Wert. printf füllt nach Bytes auf; die Breite zählt deshalb Zeichen.
# Aufruf: $(call hint_row,Beschriftung,Wert), ohne Komma in den Werten.
hint_row = label="$(1)"; \
	chars=$$(printf '%s' "$$label" | LC_ALL=C tr -d '\200-\277' | wc -c); \
	printf "$(THEME_INDENT_TARGET)$(THEME_COLOR_TARGET)%s$(RESET)%*s$(THEME_COLOR_DESC)%s$(RESET)\n" \
		"$$label" $$(( $(THEME_WIDTH_TARGET) - chars + $(THEME_COLUMN_GAP) )) "" "$(2)"

.PHONY: hints
hints: ## Nützliche Links und Hinweise anzeigen
	@echo
	@echo "$(THEME_INDENT_GROUP)$(THEME_COLOR_GROUP)Erster Start$(RESET)"
	@$(call hint_row,1. Setup,make setup)
	@$(call hint_row,2. Prüfen,make check)
	@echo
	@echo "$(THEME_INDENT_GROUP)$(THEME_COLOR_GROUP)Werkzeuge$(RESET)"
	@$(call hint_row,ProjectTools,$(PROJECTTOOLS_INSTALL))
	@$(call hint_row,BashLib (Maintainer),$(BASHLIB_INSTALL))
	@$(call hint_row,Arbeitskopie,pipx install -e <Pfad>)
	@echo
	@echo "$(THEME_INDENT_GROUP)$(THEME_COLOR_GROUP)Links$(RESET)"
	@$(call hint_row,Repository,$(or $(REPO_URL),$(NO_REMOTE)))
	@$(call hint_row,Letzter Release,$(RELEASE_TAG))
	@echo

# ─── Precheck ────────────────────────────────────────────────────────────────

# Ohne `##`: nicht in der Hilfe, läuft als Abhängigkeit von version und tag-*.
.PHONY: precheck
precheck:
	$(require_bash_libs)

# Ohne `##`: verlangt ProjectTools in Mindestversion und nennt sonst den Installationsbefehl.
.PHONY: require-tools
require-tools:
	@found='$(PROJECTTOOLS_FOUND)'; \
	if [[ -z "$$found" ]]; then problem='fehlt'; \
	elif [[ "$$(printf '%s\n' '$(PROJECTTOOLS_MIN)' "$$found" | sort -V | head -1)" != '$(PROJECTTOOLS_MIN)' ]]; then problem="$$found ist zu alt"; \
	else exit 0; fi; \
	printf '  $(RED)✗$(RESET) ProjectTools %s (verlangt ab %s): $(YELLOW)%s$(RESET)\n' "$$problem" '$(PROJECTTOOLS_MIN)' "$(PROJECTTOOLS_INSTALL)" >&2; \
	exit 1

# ─── Setup ───────────────────────────────────────────────────────────────────

##@ Setup

# MakeLib hat keine Pakete; setup richtet nur den Git-Hook ein. Es bleibt der
# eine Einrichtungsweg (agent-lessons worktree_setup) und ist beliebig oft aufrufbar.
.PHONY: setup
setup: ## Git-Hooks einrichten (pre-commit: make docs-check)
	@git config core.hooksPath .githooks
	@echo -e "  $(GREEN)✓$(RESET) $(PROJECT_NAME) ist eingerichtet"

# Prüf-Targets richten nichts ein; setup ist der einzige Weg (worktree_setup).
.PHONY: require-setup
require-setup:
	@[[ "$$(git config core.hooksPath)" == ".githooks" ]] || { \
		echo -e "  $(RED)✗$(RESET) Nicht eingerichtet: $(YELLOW)make setup$(RESET)" >&2; \
		exit 1; }

# ─── Status ──────────────────────────────────────────────────────────────────

##@ Status

.PHONY: status
status: require-tools ## Git-Status des Repos und offene Blocker-Issues
	@repo-status --show

# ─── Prüfen ──────────────────────────────────────────────────────────────────

##@ Prüfen

# Voller Prüflauf, auch für agent-lessons (integration_check: make check).
.PHONY: check
check: require-setup docs-check ## Doku und Beispiel-Makefile prüfen (alle Themes, ohne Farben, ohne MakeLib)
	@bash scripts/check.sh

.PHONY: docs-check
docs-check: require-tools ## Nutzerdoku gegen das Projekt prüfen (Links, Befehle, Variablen)
	@docs-check --run

# ─── Versionierung ───────────────────────────────────────────────────────────

# Nach versioning-conventions: Die Version steht in pyproject.toml; lesen und
# erhöhen nur über BashLib (readProjectVersion, semVerBump). Der Tag lautet
# v<version>+YYMMDD.HHMM.hash.

##@ Versionierung

.PHONY: version
version: precheck ## Aktuelle Version anzeigen (Versionsdatei + git tag) — Maintainer
	@echo
	@VER=$$(source "$${BASH_LIBS}/version.lib.sh" 2>/dev/null && readProjectVersion 2>/dev/null); \
	 [[ -z "$$VER" ]] && VER='nicht gesetzt'; \
	 TAG=$$(git describe --tags --abbrev=0 2>/dev/null || echo 'kein Tag'); \
	 echo "    $(YELLOW)version$(RESET)      = $(BLUE)$$VER$(RESET)"; \
	 echo "    $(YELLOW)git tag$(RESET)      = $(BLUE)$$TAG$(RESET)"
	@echo

.PHONY: tags
tags: ## Letzte 10 Tags mit Message anzeigen
	@echo
	@git tag --sort=-version:refname -n1 | head -10 | \
	  awk '{printf "    $(BLUE)%-28s$(RESET) $(GREEN)%s$(RESET)\n", $$1, substr($$0, index($$0,$$2))}'
	@echo

.PHONY: tag-major
tag-major: precheck ## Version committen, taggen UND pushen — Major (X.y.z → X+1.0.0)  [MSG="..."] — Maintainer
	source "$${BASH_LIBS}/version.lib.sh" && semVerBump major auto "" "$${MSG:-}"

.PHONY: tag-minor
tag-minor: precheck ## Version committen, taggen UND pushen — Minor (x.Y.z → x.Y+1.0)  [MSG="..."] — Maintainer
	source "$${BASH_LIBS}/version.lib.sh" && semVerBump minor auto "" "$${MSG:-}"

.PHONY: tag-patch
tag-patch: precheck ## Version committen, taggen UND pushen — Patch (x.y.Z → x.y.Z+1)  [MSG="..."] — Maintainer
	source "$${BASH_LIBS}/version.lib.sh" && semVerBump patch auto "" "$${MSG:-}"
