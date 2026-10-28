# colours.mk — ANSI-Farben + Help-Themes für Makefiles
#
# Palette, Themes und Layout sind mit BashLib/src/colors.lib.sh und
# ProjectTools/src/python/colors.py abgestimmt. Änderungen in allen drei
# Farb-Libs abgleichen; die Dateien werden eigenständig gepflegt.
#
# Weitere Infos:
#   https://gist.github.com/rsperl/d2dfe88a520968fbc1f49db0a29345b9
#
# Einbinden:
#   -include ${DEV_MAKE}/colours.mk
#
# Theme setzen (Standard: classic):
#   make help MAKE_THEME=ocean
#   oder in .env:  MAKE_THEME=classic

# ─── Basis-Farben ─────────────────────────────────────────────────────────────
#
# Palette und Themes mit BashLib/src/colors.lib.sh und ProjectTools/src/python/colors.py
# abgestimmt. Alle drei Dateien bleiben eigenständige, direkt nutzbare Quellen.

ifeq ($(origin NO_COLOR),undefined)
ifneq (,$(findstring xterm,${TERM}))
_THEME_USE_COLOR := 1
endif
endif

ifeq ($(_THEME_USE_COLOR),1)
    BLACK        := $(shell printf "\033[38;5;0m")
    RED          := $(shell printf "\033[38;5;196m")
    GREEN        := $(shell printf "\033[38;5;10m")
    YELLOW       := $(shell printf "\033[38;5;11m")
    BLUE         := $(shell printf "\033[38;5;33m")
    WHITE        := $(shell printf "\033[38;5;15m")
    ORANGE       := $(shell printf "\033[38;5;208m")
    BROWN        := $(shell printf "\033[38;5;94m")
    PURPLE       := $(shell printf "\033[38;5;164m")
    GREY         := $(shell printf "\033[38;5;245m")
    DARK_GREY    := $(shell printf "\033[38;5;245m")
    BOLD         := $(shell printf "\033[1m")

    # Light-Varianten — synchron mit BashLib (LIGHT_*-Konstanten)
    LIGHT_RED    := $(shell printf "\033[38;5;203m")
    LIGHT_GREEN  := $(shell printf "\033[38;5;155m")
    LIGHT_BLUE   := $(shell printf "\033[38;5;45m")
    LIGHT_PURPLE := $(shell printf "\033[38;5;170m")
    LIGHT_CYAN   := $(shell printf "\033[38;5;123m")
    LIGHT_GRAY   := $(shell printf "\033[38;5;251m")

    # Erweiterte Palette — für Themes und eigene Verwendung
    CYAN         := $(shell printf "\033[38;5;51m")
    STEEL_BLUE   := $(shell printf "\033[38;5;75m")
    GOLD         := $(shell printf "\033[38;5;220m")
    CORAL        := $(shell printf "\033[38;5;203m")
    TAN          := $(shell printf "\033[38;5;179m")
    OLIVE        := $(shell printf "\033[38;5;143m")
    AMBER        := $(shell printf "\033[38;5;208m")
    BRICK        := $(shell printf "\033[38;5;160m")
    SLATE_BLUE   := $(shell printf "\033[38;5;111m")
    TEAL         := $(shell printf "\033[38;5;79m")
    SALMON       := $(shell printf "\033[38;5;215m")
    HOT_PINK     := $(shell printf "\033[38;5;197m")
    PINK         := $(shell printf "\033[38;5;205m")
    CREAM        := $(shell printf "\033[38;5;223m")
    BRIGHT_RED   := $(shell printf "\033[38;5;196m")
    DARK_GREEN   := $(shell printf "\033[38;5;34m")
    LIME         := $(shell printf "\033[38;5;77m")
    PALE_GREEN   := $(shell printf "\033[38;5;151m")
    STRAW        := $(shell printf "\033[38;5;185m")
    TERRACOTTA   := $(shell printf "\033[38;5;167m")
    MAGENTA      := $(shell printf "\033[38;5;201m")
    NEON_GREEN   := $(shell printf "\033[38;5;118m")
    NEON_YELLOW  := $(shell printf "\033[38;5;226m")

    RESET        := $(shell tput -Txterm sgr0)
    NC           := $(shell tput -Txterm sgr0)
else
    BLACK        :=
    RED          :=
    GREEN        :=
    YELLOW       :=
    BLUE         :=
    WHITE        :=
    ORANGE       :=
    BROWN        :=
    PURPLE       :=
    GREY         :=
    DARK_GREY    :=
    BOLD         :=
    LIGHT_RED    :=
    LIGHT_GREEN  :=
    LIGHT_BLUE   :=
    LIGHT_PURPLE :=
    LIGHT_CYAN   :=
    LIGHT_GRAY   :=
    CYAN         :=
    STEEL_BLUE   :=
    GOLD         :=
    CORAL        :=
    TAN          :=
    OLIVE        :=
    AMBER        :=
    BRICK        :=
    SLATE_BLUE   :=
    TEAL         :=
    SALMON       :=
    HOT_PINK     :=
    PINK         :=
    CREAM        :=
    BRIGHT_RED   :=
    DARK_GREEN   :=
    LIME         :=
    PALE_GREEN   :=
    STRAW        :=
    TERRACOTTA   :=
    MAGENTA      :=
    NEON_GREEN   :=
    NEON_YELLOW  :=
    RESET        :=
    NC           :=
endif

# ─── Help-Themes ──────────────────────────────────────────────────────────────
#
# Themes: classic | ocean | earth | night | mono | sunset | forest | neon | shell
#
# Jedes Theme definiert:
#   THEME_COLOR_GROUP    Farbe für ##@ Gruppen-Überschriften
#   THEME_COLOR_TARGET   Farbe für Target-Namen
#   THEME_COLOR_DESC     Farbe für Beschreibungstexte
#   THEME_COLOR_SERVER   Farbe für ##R  (schreibende Server-Ops)
#   THEME_COLOR_DANGER   Farbe für ##D  (destruktive Server-Ops)
#   THEME_INDENT_GROUP   Einrückung vor Gruppen-Überschriften
#   THEME_INDENT_TARGET  Einrückung vor Targets
#
# Verwendung in Makefile-help:
#   /^##@/ { printf "\n$(THEME_INDENT_GROUP)$(THEME_COLOR_GROUP)%s$(RESET)\n", substr($$0, 4); next }
#   /##D /  { printf "$(THEME_INDENT_TARGET)$(THEME_COLOR_DANGER)%-28s $(THEME_COLOR_DESC)%s$(RESET)\n", $$1, $$2; next }
#   /##R /  { printf "$(THEME_INDENT_TARGET)$(THEME_COLOR_SERVER)%-28s $(THEME_COLOR_DESC)%s$(RESET)\n", $$1, $$2; next }
#   /## /   { printf "$(THEME_INDENT_TARGET)$(THEME_COLOR_TARGET)%-28s $(THEME_COLOR_DESC)%s$(RESET)\n", $$1, $$2 }

# Theme-Auswahl — gewünschtes Theme einkommentieren, alle anderen auskommentiert lassen.
# Alternativ dauerhaft in .env konfigurieren:  MAKE_THEME=ocean
# Einmalig überschreiben:                       make help MAKE_THEME=ocean
#

MAKE_THEME ?= classic
# MAKE_THEME ?= ocean
# MAKE_THEME ?= earth
# MAKE_THEME ?= night
# MAKE_THEME ?= mono
# MAKE_THEME ?= sunset
# MAKE_THEME ?= forest
# MAKE_THEME ?= neon
# MAKE_THEME ?= shell

ifeq ($(MAKE_THEME),classic)
  # Classic — Gelb/Blau/Grün, das vertraute Schema
  THEME_COLOR_GROUP   ?= $(YELLOW)
  THEME_COLOR_TARGET  ?= $(BLUE)
  THEME_COLOR_DESC    ?= $(GREEN)
  THEME_COLOR_SERVER  ?= $(ORANGE)
  THEME_COLOR_DANGER  ?= $(RED)
  THEME_INDENT_GROUP  ?= $(shell printf '%2s' '')
  THEME_INDENT_TARGET ?= $(shell printf '%7s' '')

else ifeq ($(MAKE_THEME),ocean)
  # Ocean — Orange/Stahlblau/Hellgrün
  THEME_COLOR_GROUP   ?= $(ORANGE)
  THEME_COLOR_TARGET  ?= $(STEEL_BLUE)
  THEME_COLOR_DESC    ?= $(LIGHT_GREEN)
  THEME_COLOR_SERVER  ?= $(GOLD)
  THEME_COLOR_DANGER  ?= $(CORAL)
  THEME_INDENT_GROUP  ?= $(shell printf '%2s' '')
  THEME_INDENT_TARGET ?= $(shell printf '%7s' '')

else ifeq ($(MAKE_THEME),earth)
  # Earth — Warme Braun-/Orangetöne
  THEME_COLOR_GROUP   ?= $(ORANGE)
  THEME_COLOR_TARGET  ?= $(TAN)
  THEME_COLOR_DESC    ?= $(OLIVE)
  THEME_COLOR_SERVER  ?= $(AMBER)
  THEME_COLOR_DANGER  ?= $(BRICK)
  THEME_INDENT_GROUP  ?= $(shell printf '%2s' '')
  THEME_INDENT_TARGET ?= $(shell printf '%7s' '')

else ifeq ($(MAKE_THEME),night)
  # Night — Gedämpfte Violett-/Lavendeltöne
  THEME_COLOR_GROUP   ?= $(PURPLE)
  THEME_COLOR_TARGET  ?= $(SLATE_BLUE)
  THEME_COLOR_DESC    ?= $(TEAL)
  THEME_COLOR_SERVER  ?= $(SALMON)
  THEME_COLOR_DANGER  ?= $(HOT_PINK)
  THEME_INDENT_GROUP  ?= $(shell printf '%2s' '')
  THEME_INDENT_TARGET ?= $(shell printf '%7s' '')

else ifeq ($(MAKE_THEME),mono)
  # Mono — Kein Farbrauschen, klare Hierarchie
  THEME_COLOR_GROUP   ?= $(BOLD)$(WHITE)
  THEME_COLOR_TARGET  ?= $(WHITE)
  THEME_COLOR_DESC    ?= $(GREY)
  THEME_COLOR_SERVER  ?= $(YELLOW)
  THEME_COLOR_DANGER  ?= $(RED)
  THEME_INDENT_GROUP  ?= $(shell printf '%2s' '')
  THEME_INDENT_TARGET ?= $(shell printf '%7s' '')

else ifeq ($(MAKE_THEME),sunset)
  # Sunset — Warme Pink-/Magenta-/Korall-Töne
  THEME_COLOR_GROUP   ?= $(PINK)
  THEME_COLOR_TARGET  ?= $(SALMON)
  THEME_COLOR_DESC    ?= $(CREAM)
  THEME_COLOR_SERVER  ?= $(GOLD)
  THEME_COLOR_DANGER  ?= $(BRIGHT_RED)
  THEME_INDENT_GROUP  ?= $(shell printf '%2s' '')
  THEME_INDENT_TARGET ?= $(shell printf '%7s' '')

else ifeq ($(MAKE_THEME),forest)
  # Forest — Satte Grüntöne
  THEME_COLOR_GROUP   ?= $(DARK_GREEN)
  THEME_COLOR_TARGET  ?= $(LIME)
  THEME_COLOR_DESC    ?= $(PALE_GREEN)
  THEME_COLOR_SERVER  ?= $(STRAW)
  THEME_COLOR_DANGER  ?= $(TERRACOTTA)
  THEME_INDENT_GROUP  ?= $(shell printf '%2s' '')
  THEME_INDENT_TARGET ?= $(shell printf '%7s' '')

else ifeq ($(MAKE_THEME),neon)
  # Neon — Knallige Signalfarben
  THEME_COLOR_GROUP   ?= $(MAGENTA)
  THEME_COLOR_TARGET  ?= $(NEON_GREEN)
  THEME_COLOR_DESC    ?= $(NEON_YELLOW)
  THEME_COLOR_SERVER  ?= $(AMBER)
  THEME_COLOR_DANGER  ?= $(BRIGHT_RED)
  THEME_INDENT_GROUP  ?= $(shell printf '%2s' '')
  THEME_INDENT_TARGET ?= $(shell printf '%7s' '')

else ifeq ($(MAKE_THEME),shell)
  # Shell — wie BashLib-Scripts (repo-status.sh, git-push-all.sh, usageLine):
  #   YELLOW = Section-Header / Tabellen-Header
  #   LIGHT_BLUE = Options-/Target-Spalte (vgl. usageLine)
  #   LIGHT_GRAY = Beschreibungstext (neutral lesbar)
  #   ORANGE = WARNING-Semantik (write-Ops)
  #   RED = ERROR-Semantik (destruktive Ops)
  THEME_COLOR_GROUP   ?= $(YELLOW)
  THEME_COLOR_TARGET  ?= $(LIGHT_BLUE)
  THEME_COLOR_DESC    ?= $(LIGHT_GRAY)
  THEME_COLOR_SERVER  ?= $(ORANGE)
  THEME_COLOR_DANGER  ?= $(RED)
  THEME_INDENT_GROUP  ?= $(shell printf '%2s' '')
  THEME_INDENT_TARGET ?= $(shell printf '%7s' '')

endif

# Fallback — greift wenn MAKE_THEME unbekannt ist
THEME_COLOR_GROUP   ?= $(YELLOW)
THEME_COLOR_TARGET  ?= $(BLUE)
THEME_COLOR_DESC    ?= $(GREEN)
THEME_COLOR_SERVER  ?= $(ORANGE)
THEME_COLOR_DANGER  ?= $(RED)
THEME_INDENT_GROUP  ?= $(shell printf '%2s' '')
THEME_INDENT_TARGET ?= $(shell printf '%7s' '')

# Gemeinsames Layout; pro Theme oben oder vor dem Include überschreibbar.
# Einrückungen bleiben aus Kompatibilitätsgründen Leerzeichen, Breiten sind Zahlen.
THEME_WIDTH_TARGET ?= 22
THEME_COLUMN_GAP ?= 1
THEME_WIDTH_HELP ?= 110
THEME_GROUP_SPACING ?= 1
THEME_COLOR_VALUE ?= $(YELLOW)
THEME_COLOR_SUCCESS ?= $(GREEN)
THEME_COLOR_WARNING ?= $(THEME_COLOR_SERVER)
export MAKE_THEME THEME_INDENT_GROUP THEME_INDENT_TARGET
export THEME_WIDTH_TARGET THEME_COLUMN_GAP THEME_WIDTH_HELP THEME_GROUP_SPACING

# ─── Farbtabelle ──────────────────────────────────────────────────────────────
#
# Usage:
#     colors: ## 256-Farben-Tabelle anzeigen
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
