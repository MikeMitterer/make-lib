# Funktion zum Erzeugen einer Zeile mit zwei Spalten
#
# Usage:
#     @$(call usageLine, "help",          "This help message")
#
define usageLine
	printf "    $(YELLOW)%-20s$(RESET) $(GREEN)%s$(RESET)\n" $(strip $(1)) $(strip $(2))
endef

# Usage:
#     $(usageLine2)        "help"          "This help message"
usageLine2 = @sh -c 'printf "    $(YELLOW)%-20s$(RESET) $(GREEN)%s$(RESET)\n" "$$1" "$$2"' _

# Funktion zum Erzeugen einer Zeile mit einer Spalte
#
# Usage:
#     @$(call infoLine,                   "Von BashLib -> Workspace usw.")
define infoLine
	sh -c 'printf "    $(YELLOW)%-24s$(RESET) $(WHITE)%s$(RESET)\n" "" "$${1//;/,}"' _ "$(strip $(1))"
endef

# Usage:
#     $(infoLine2)        "Von BashLib, MakeLib usw zu $(YELLOW)$(REL_HOST_DIR)$(NC)"
infoLine2 = @sh -c 'printf "    $(YELLOW)%-24s$(RESET) $(WHITE)%s$(RESET)\n" "" "$$1"' _

# Funktion zum Erzeugen einer Zeile mit zwei Spalten
# Es wird ein optionaler Parameter für die vorhergehende Zeile angegeben
#
# Usage:
#     @$(call optionLine,    "[COMMENT=\"...\"]",     "Kommentar für das Backup")
#
define optionLine
	printf "        $(WHITE)%-20s$(RESET) $(WHITE)%s$(RESET)\n" $(strip $(1) $(strip $(2)))
endef

# Usage:
#     $(optionLine2)        "[COMMENT=\"...\"]",     "Kommentar für das Backup"
optionLine2 = @sh -c 'printf "        $(WHITE)%-20s$(RESET) $(WHITE)%s$(RESET)\n" "$$1" "$$2"' _
