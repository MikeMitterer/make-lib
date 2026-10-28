<div align="center">

# MakeLib

**Farben, Themes und Hilfezeilen für Makefiles**

[Voraussetzungen](#voraussetzungen) · [Installation](#installation) ·
[Einbinden](#einbinden) · [Dateien](#dateien) · [Lizenz](#lizenz)

</div>

MakeLib besteht aus zwei Dateien, die ein Makefile mit `include` einbindet:
`colours.mk` liefert ANSI-Farben und Themes, `tools.mk` Makros für eine
zweispaltige Hilfeausgabe. Gefunden werden sie über die Variable `DEV_MAKE`.
Ein Makefile soll auch ohne MakeLib laufen; dafür setzt es eigene
Ersatzwerte (siehe [Einbinden](#einbinden)).

## Übersicht

- [Voraussetzungen](#voraussetzungen)
- [Installation](#installation)
- [Einbinden](#einbinden)
- [Dateien](#dateien)
- [Farben und Themes](#farben-und-themes)
- [Lizenz](#lizenz)

## Voraussetzungen

- **GNU Make**, auch die Version 3.81, die macOS mitbringt.
- **`DEV_MAKE`** zeigt auf den Checkout dieses Repos (siehe
  [Installation](#installation)).

[↑ Übersicht](#übersicht)

## Installation

```bash
git clone https://github.com/MikeMitterer/make-lib.git ~/.local/share/make-lib
```

Danach `DEV_MAKE` dauerhaft setzen, etwa in `~/.bashrc` oder `~/.zshrc`:

```bash
export DEV_MAKE="$HOME/.local/share/make-lib"
```

`DEV_MAKE` zeigt auf das Repo selbst, nicht auf ein Unterverzeichnis. Der Ort
des Klons ist frei. Aktualisieren mit `git -C ~/.local/share/make-lib pull`.

[↑ Übersicht](#übersicht)

## Einbinden

**Immer mit `-include` und mit Ersatzwerten.** `-include` überspringt eine
fehlende Datei, statt abzubrechen. Die Ersatzwerte mit `?=` greifen nur, wenn
MakeLib sie nicht schon gesetzt hat. So läuft das Makefile auch in einem
frischen Klon oder im CI ohne `DEV_MAKE`.

```make
-include $(DEV_MAKE)/colours.mk
-include $(DEV_MAKE)/tools.mk

# Ersatz, wenn MakeLib fehlt
YELLOW ?= $(shell printf "\033[38;5;11m")
RESET  ?= $(shell printf "\033[0m")
THEME_COLOR_GROUP ?= $(YELLOW)
usageLine2 ?= @printf '       %-22s %s\n'

help:
	@printf '\n$(THEME_COLOR_GROUP)Befehle$(RESET)\n'
	$(usageLine2) "help" "Hilfe anzeigen"
	$(usageLine2) "test" "Tests starten"
```

Ersatzwerte braucht nur, was das eigene Makefile tatsächlich verwendet.

[↑ Übersicht](#übersicht)

## Dateien

| Datei | Inhalt |
|---|---|
| `colours.mk` | Grundfarben (`RED`, `GREEN`, `YELLOW`, `BLUE` …, `RESET`, `NC`), erweiterte Palette, Theme-Farben (`THEME_COLOR_GROUP`, `THEME_COLOR_TARGET`, `THEME_COLOR_DESC` …), Layoutwerte (`THEME_INDENT_GROUP`, `THEME_INDENT_TARGET`, `THEME_WIDTH_TARGET`, `THEME_WIDTH_HELP` …), Makro `print_colours` für eine 256-Farben-Tabelle |
| `tools.mk` | Zweispaltige Zeilen für Hilfeausgaben: `usageLine`, `infoLine`, `optionLine` (mit `$(call …)`) und `usageLine2`, `infoLine2`, `optionLine2` (direkt mit Argumenten) |

[↑ Übersicht](#übersicht)

## Farben und Themes

`MAKE_THEME` wählt das Theme (`classic`, `ocean`, `earth`, `night`, `mono`,
`sunset`, `forest`, `neon`, `shell`), als Variable beim Aufruf von make oder
in der Umgebung, etwa `export MAKE_THEME=ocean`.
Bei gesetztem `NO_COLOR` oder einem Terminal ohne `xterm` im `TERM` gibt es
keine Farben. Layoutwerte, Farbrollen und die Abstimmung mit BashLib und
ProjectTools stehen in [docs/themes.md](docs/themes.md).

[↑ Übersicht](#übersicht)

## Lizenz

Copyright © 2022–2026 Michael Mitterer. **MangoLila GmbH** ist Anbieterin und
Lizenzgeberin.

MakeLib steht unter der **[EUPL 1.2](LICENSE)**, nur Version 1.2. Sie erlaubt
private und gewerbliche Nutzung, Änderungen, Weitergabe, Verkauf und Hosting
ohne kostenpflichtige Lizenz.

Wer MakeLib oder eine geänderte Fassung weitergibt oder als Netzwerkdienst
anbietet, muss die Urheber- und Lizenzhinweise erhalten, Änderungen
kennzeichnen und den zugehörigen Quelltext nach den Copyleft-Regeln der
Lizenz bereitstellen.

Die Gewährleistungs- und Haftungsausschlüsse der EUPL-Artikel 7 und 8 gelten
auch gegenüber Verbrauchern, soweit das Gesetz es zulässt. Zwingende Rechte
bleiben unberührt, darunter die Haftung für Vorsatz, grobe Fahrlässigkeit,
Personenschäden und nach dem Produkthaftungsgesetz. Eine zusätzliche Garantie
wird nicht übernommen.

Kontakt: **office@MangoLila.at**.

Details: [LICENSE](LICENSE) · [Deutscher Lizenztext](LICENSE.de.txt) ·
[Anbieter- und Verbrauchererklärung](LICENSING.md)
