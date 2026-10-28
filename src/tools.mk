# Gemeinsames Zweispaltenlayout. Alte Makronamen und Argumente bleiben gültig.
THEME_INDENT_TARGET ?= $(shell printf '%7s' '')
THEME_WIDTH_TARGET ?= 22
THEME_COLUMN_GAP ?= 1

_themeLine = sh -c 'label=$$1; text=$$2; width=$(THEME_WIDTH_TARGET); gap=$(THEME_COLUMN_GAP); \
  printf "%s%b%s%b" "$(THEME_INDENT_TARGET)" "$(THEME_COLOR_TARGET)" "$$label" "$(RESET)"; \
  if [ "$${\#label}" -gt "$$width" ]; then \
    printf "\n%s" "$(THEME_INDENT_TARGET)"; padding=$$((width + gap)); \
  else padding=$$((width - $${\#label} + gap)); fi; \
  printf "%*s%b%s%b\n" "$$padding" "" "$(THEME_COLOR_DESC)" "$$text" "$(RESET)"' _

# $(call usageLine, "help", "Hilfe anzeigen")
define usageLine
	$(_themeLine) $(strip $(1)) $(strip $(2))
endef
usageLine2 = @$(_themeLine)

# Die Semikolon-Ersetzung erhält das bisherige infoLine-Verhalten.
comma := ,
define infoLine
	$(_themeLine) "" "$(subst ;,$(comma),$(strip $(1)))"
endef
infoLine2 = @$(_themeLine) ""

define optionLine
	$(_themeLine) $(strip $(1)) $(strip $(2))
endef
optionLine2 = @$(_themeLine)
