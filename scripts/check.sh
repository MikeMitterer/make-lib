#!/usr/bin/env bash
# Prüft MakeLib über example/Makefile gegen src/ dieses Checkouts.
#
# Fälle:
#   - jedes Theme aus src/colours.mk: help läuft, mit Farben und Hilfezeilen
#   - NO_COLOR: help ohne ANSI-Codes
#   - colors: die Farbtabelle läuft
#   - DEV_MAKE ohne tools.mk: das Beispiel bricht mit klarer Meldung ab
#
# Läuft mit macOS-Bash 3.2 und GNU Make 3.81.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="${ROOT}/src"
EXAMPLE="${ROOT}/example"
ESC=$'\033'

failures=0
fail() { printf '  ✗ %s\n' "$1" >&2; failures=$((failures + 1)); }
ok()   { printf '  ✓ %s\n' "$1"; }

# Make im Beispiel mit dem src/ dieses Checkouts, unabhängig von DEV_MAKE der Umgebung
runExample() { env -u NO_COLOR -u MAKEFLAGS TERM=xterm-256color make -s -C "${EXAMPLE}" DEV_MAKE="${SRC}" "$@" 2>&1; }

# Theme-Namen stehen nur in colours.mk
themes=$(sed -n 's/^\(else \)\{0,1\}ifeq (\$(MAKE_THEME),\([a-z]*\))$/\2/p' "${SRC}/colours.mk")
[[ -n "${themes}" ]] || fail "keine Themes in src/colours.mk gefunden"

for theme in ${themes}; do
    if ! out=$(runExample help MAKE_THEME="${theme}"); then
        fail "help mit Theme ${theme} scheitert: ${out}"
    elif [[ "${out}" != *"${ESC}["* ]]; then
        fail "help mit Theme ${theme} ohne Farben"
    elif [[ "${out}" != *"Diese Hilfe anzeigen"* ]]; then
        fail "help mit Theme ${theme} ohne Hilfezeilen"
    else
        ok "help mit Theme ${theme}"
    fi
done

if ! out=$(runExample help NO_COLOR=1); then
    fail "help mit NO_COLOR scheitert: ${out}"
elif [[ "${out}" == *"${ESC}"* ]]; then
    fail "help mit NO_COLOR enthält ANSI-Codes"
else
    ok "help mit NO_COLOR ohne Farben"
fi

if out=$(runExample colors); then
    ok "colors"
else
    fail "colors scheitert: ${out}"
fi

empty="$(mktemp -d)"
trap 'rm -rf "${empty}"' EXIT
if out=$(env -u MAKEFLAGS make -s -C "${EXAMPLE}" DEV_MAKE="${empty}" help 2>&1); then
    fail "Beispiel ohne MakeLib läuft durch, statt abzubrechen"
elif [[ "${out}" != *"MakeLib fehlt"* ]]; then
    fail "Beispiel ohne MakeLib bricht ohne Hinweis ab: ${out}"
else
    ok "Beispiel ohne MakeLib bricht mit Hinweis ab"
fi

if (( failures > 0 )); then
    printf '\n  %d Prüfung(en) fehlgeschlagen\n' "${failures}" >&2
    exit 1
fi
