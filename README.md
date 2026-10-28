# make-lib

## Usage

Die libs in diesem Folder werden den `Makefile`s   
z.B. über

```makefile
    ifdef DEV_MAKE
        include ${DEV_MAKE}/colours.mk
    endif
```

eingebunden

## Libs

- colours.mk, Unterstützung für ANSI-Colors im Makefile


## CLI-Themes und Abstände

Die drei eigenständigen Dateien MakeLib `colours.mk`, BashLib
`src/colors.lib.sh` und ProjectTools `src/python/colors.py` verwenden dieselbe
Palette und Theme-Auswahl: `classic` (Standard), `ocean`, `earth`, `night`,
`mono`, `sunset`, `forest`, `neon`, `shell`. Ein unbekannter Name verwendet
`classic`. Die Auswahl kann wie bisher in der jeweiligen Datei umgestellt
oder mit `MAKE_THEME` überschrieben werden. Es gibt keine generierte Datei.
Make exportiert die Auswahl und Layout-Werte an seine Kindprozesse.

```bash
make help MAKE_THEME=ocean
MAKE_THEME=ocean "$PROJECT_TOOLS/bash/py-run.sh" --help
MAKE_THEME=ocean python3 "$PROJECT_TOOLS/python/changelog.py" --help
```

| Einstellung | Vorgabe | Bedeutung |
|---|---|---|
| `THEME_INDENT_GROUP` | zwei Leerzeichen | Gruppenüberschrift |
| `THEME_INDENT_TARGET` | sieben Leerzeichen | Target oder Option |
| `THEME_WIDTH_TARGET` | `22` | Breite der ersten Spalte |
| `THEME_COLUMN_GAP` | `1` | Mindestabstand zur Beschreibung |
| `THEME_WIDTH_HELP` | `110` | Python-Hilfe: gesamte Textbreite |
| `THEME_GROUP_SPACING` | `1` | Leerzeilen zwischen Gruppen |

Mit diesen Vorgaben beginnt die Beschreibung in Spalte 31. Lange Beschriftungen
stehen bei `usageLine`/`themeLine` und der Python-Hilfe auf einer eigenen Zeile.
Python bricht lange Beschreibungen an der Gesamtbreite um; Bash und Make
geben Beschreibungstexte wie bisher unverändert aus. Einrückungen sind weiterhin
**Leerzeichenketten**, Breiten und Abstände nichtnegative Zahlen. Einzelne
Werte vor dem Include/Source beziehungsweise per Umgebung überschreiben.

`THEME_COLOR_GROUP`, `TARGET`, `DESC`, `SERVER`, `DANGER` (jeweils mit dem Präfix
`THEME_COLOR_`) behalten ihre Namen. Hinzu kommen `THEME_COLOR_SUCCESS` und
`THEME_COLOR_WARNING`. Grundfarben und die bisherigen öffentlichen Makros,
Bash-Funktionen und Argumente bleiben verfügbar. Die Standarddarstellung der
Ausgabehelfer folgt jetzt dem gemeinsamen Theme.

Die neuen Bash-/Python-Helfer geben in Pipes, bei `NO_COLOR` und `TERM=dumb`
keine ANSI-Farben aus. Make berücksichtigt `NO_COLOR` und behält seine bisherige
TERM-basierte Farberkennung. Bash-Grundkonstanten bleiben aus Kompatibilität
unveränderte Escape-Strings für `printf '%b'` oder `echo -e`.

## Lizenz

Copyright © 2022–2026 Michael Mitterer. **MangoLila GmbH** ist Anbieter und
Lizenzgeber.

MakeLib steht unter der **[EUPL 1.2](LICENSE)**, nur Version 1.2. Sie erlaubt
private und gewerbliche Nutzung, Änderungen, Weitergabe, Verkauf und Hosting
ohne kostenpflichtige Lizenz. Wer MakeLib oder eine geänderte Fassung
weitergibt, behält die Urheber- und Lizenzhinweise bei, kennzeichnet
Änderungen und stellt den Quellcode nach den Copyleft-Regeln der Lizenz
bereit. Details: [LICENSING.md](LICENSING.md), deutscher Lizenztext:
[LICENSE.de.txt](LICENSE.de.txt).
