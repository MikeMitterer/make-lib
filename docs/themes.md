# CLI-Themes und Abstände

Die drei eigenständigen Dateien MakeLib `colours.mk`, BashLib
`src/colors.lib.sh` und ProjectTools `colors.py` verwenden dieselbe
Palette und Theme-Auswahl: `classic` (Standard), `ocean`, `earth`, `night`,
`mono`, `sunset`, `forest`, `neon`, `shell`. Ein unbekannter Name verwendet
`classic`. Die Auswahl kann wie bisher in der jeweiligen Datei umgestellt
oder mit `MAKE_THEME` überschrieben werden. Es gibt keine generierte Datei.
Make exportiert die Auswahl und Layout-Werte an seine Kindprozesse.

```bash
export MAKE_THEME=ocean
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

`THEME_COLOR_GROUP`, `THEME_COLOR_TARGET`, `THEME_COLOR_DESC`,
`THEME_COLOR_SERVER` und `THEME_COLOR_DANGER` behalten ihre Namen. Hinzu kommen `THEME_COLOR_SUCCESS` und
`THEME_COLOR_WARNING`. Grundfarben und die bisherigen öffentlichen Makros,
Bash-Funktionen und Argumente bleiben verfügbar. Die Standarddarstellung der
Ausgabehelfer folgt jetzt dem gemeinsamen Theme.

Die neuen Bash-/Python-Helfer geben in Pipes, bei `NO_COLOR` und `TERM=dumb`
keine ANSI-Farben aus. Make berücksichtigt `NO_COLOR` und behält seine bisherige
TERM-basierte Farberkennung. Bash-Grundkonstanten bleiben aus Kompatibilität
unveränderte Escape-Strings für `printf '%b'` oder `echo -e`.

Palette und Themes sind mit BashLib `colors.lib.sh` und ProjectTools
`colors.py` abgestimmt. Wer sie in `colours.mk` ändert, gleicht die beiden
anderen Dateien an.

Zurück zum [README](../README.md).
