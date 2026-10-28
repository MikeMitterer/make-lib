# Beispiel: MakeLib in einem Makefile verwenden
#
# Aufruf aus dem Repo:   make -C example
# Mit Theme:             make -C example MAKE_THEME=ocean
#
# In einem eigenen Projekt kommt DEV_MAKE aus der Umgebung und zeigt auf
# MakeLib/src. Nur hier im Repo zeigt der Standard auf ../src, damit das
# Beispiel ohne Einrichtung läuft.
DEV_MAKE ?= $(abspath $(dir $(lastword $(MAKEFILE_LIST)))../src)

# Dieses Makefile nutzt Makros aus tools.mk: MakeLib ist damit Voraussetzung.
# Wer nur Farben braucht, bindet allein colours.mk mit -include ein und
# bekommt ohne MakeLib eine Ausgabe ohne Farben.
ifeq ($(wildcard $(DEV_MAKE)/tools.mk),)
$(error MakeLib fehlt: DEV_MAKE auf MakeLib/src setzen (https://github.com/MikeMitterer/make-lib))
endif
include $(DEV_MAKE)/colours.mk
include $(DEV_MAKE)/tools.mk

.DEFAULT_GOAL := help
.PHONY: help colors

help: ## Hilfe mit den Makros aus tools.mk
	@printf '\n$(THEME_INDENT_GROUP)$(THEME_COLOR_GROUP)Befehle$(RESET)\n'
	$(usageLine2) "help" "Diese Hilfe anzeigen"
	$(usageLine2) "colors" "256-Farben-Tabelle anzeigen"
	@printf '\n$(THEME_INDENT_GROUP)$(THEME_COLOR_GROUP)Optionen$(RESET)\n'
	$(optionLine2) "MAKE_THEME=ocean" "Theme wählen (classic, ocean, earth, night …)"
	$(infoLine2) "Ohne Farben: NO_COLOR=1 setzen"
	@printf '\n'

colors: ## Farbtabelle aus colours.mk
	$(call print_colours)
