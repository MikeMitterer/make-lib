# Entwicklung

[← README](../README.de.md)

Diese Seite beschreibt die Arbeit **an** MakeLib: Einrichten aus dem
Checkout, Befehle, Prüfung und Release.

## Übersicht

- [Voraussetzungen](#voraussetzungen)
- [Einrichten](#einrichten)
- [Befehle](#befehle)
- [Prüfen](#prüfen)
- [Paket und Release](#paket-und-release)

## Voraussetzungen

| Werkzeug | Wofür |
|---|---|
| GNU Make, Bash, Git | alle Targets |
| ProjectTools | `make docs-check`, `make check` und `make status`; die verlangte Version steht in `.dev-tools.conf.sh`, `make hints` nennt den Installationsbefehl |
| BashLib | nur `make version` und die `tag-*`-Targets; `make hints` nennt den Installationsbefehl |

Das Makefile bindet `colours.mk` und `tools.mk` immer aus `src/` dieses
Checkouts ein, nicht über `DEV_MAKE`.

[↑ Übersicht](#übersicht)

## Einrichten

```bash
make setup
```

`setup` richtet den pre-commit-Hook aus `.githooks/` ein, der vor jedem Commit
`make docs-check` aufruft. MakeLib installiert sonst nichts; der Aufruf ist
beliebig oft möglich.

[↑ Übersicht](#übersicht)

## Befehle

`make help` zeigt alle Targets. `make info` nennt die gefundenen Werkzeuge
und Versionen, `make hints` die Installationsbefehle. `make status` zeigt den
Git-Stand des Repos.

[↑ Übersicht](#übersicht)

## Prüfen

```bash
make check
```

`check` prüft zuerst die Doku (`make docs-check`) und dann
[example/Makefile](../example/Makefile) gegen `src/` dieses Checkouts: jedes
Theme, die Ausgabe ohne Farben, die Farbtabelle und den Abbruch ohne MakeLib.
Die Prüfungen stehen in [scripts/check.sh](../scripts/check.sh).

[↑ Übersicht](#übersicht)

## Paket und Release

MakeLib ist ein pip-Paket (`pyproject.toml`); der Befehl `makelib-path` gibt
das Verzeichnis der `.mk`-Dateien aus. Die Version steht in `pyproject.toml`.
Ein Release erhöht sie, committet, setzt den Tag
`v<version>+YYMMDD.HHMM.hash` und pusht:

```bash
make tag-patch MSG="Kurzbeschreibung"
```

`make tag-minor` und `make tag-major` erhöhen die anderen Stellen;
`make version` zeigt Versionsdatei und letzten Tag.

[↑ Übersicht](#übersicht)
