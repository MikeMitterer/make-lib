"""MakeLib als Python-Paket: Ort der *.mk fuer DEV_MAKE."""

from __future__ import annotations

import sys
from importlib.metadata import PackageNotFoundError, version
from pathlib import Path

USAGE = """Aufruf: makelib-path [--version]

Gibt das Verzeichnis mit colours.mk und tools.mk aus, etwa fuer
export DEV_MAKE="$(makelib-path)".

  --version   installierte Version ausgeben
  -h, --help  diese Hilfe"""


def lib_dir() -> Path:
    """Verzeichnis mit den *.mk: im Paket, bei -e die Arbeitskopie (src/)."""
    here = Path(__file__).resolve().parent
    bundled = here / "lib"
    if (bundled / "tools.mk").is_file():
        return bundled
    return here.parents[1] / "src"


def package_version() -> str:
    """Version des installierten Pakets mmit-makelib."""
    try:
        return version("mmit-makelib")
    except PackageNotFoundError:
        return "unbekannt"


def main() -> int:
    """makelib-path: gibt das Verzeichnis aus, mit --version die Version."""
    args = sys.argv[1:]
    if not args:
        print(lib_dir())
        return 0
    if args == ["--version"]:
        print(f"makelib-path {package_version()}")
        return 0
    if args[0] in ("-h", "--help") and len(args) == 1:
        print(USAGE)
        return 0
    print(USAGE, file=sys.stderr)
    return 2
