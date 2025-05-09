# Funktion zum Erzeugen einer Zeile mit zwei Spalten
#
# Usage:
#     @$(call usageLine, "help",          "This help message")
#
define usageLine
	printf "    $(YELLOW)%-20s$(RESET) $(GREEN)%s$(RESET)\n" $(strip $(1)) $(strip $(2))
endef

# Funktion zum Erzeugen einer Zeile mit einer Spalte
#
# Usage:
#     @$(call infoLine,                   "Von BashLib -> Workspace usw.")
define infoLine
	printf "    $(YELLOW)%-24s$(RESET) $(WHITE)%s$(RESET)\n" "" $(strip $(1))
endef

# Funktion zum Erzeugen einer Zeile mit zwei Spalten
# Es wird ein optionaler Parameter für die vorhergehende Zeile angegeben
#
# Usage:
#     @$(call optionLine,    "[COMMENT=\"...\"]",     "Kommentar für das Backup")
#
define optionLine
	printf "        $(WHITE)%-20s$(RESET) $(WHITE)%s$(RESET)\n" $(strip $(1) $(strip $(2)))
endef
