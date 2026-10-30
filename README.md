<div align="center">

# MakeLib

**Colours, themes and help lines for Makefiles**

[Requirements](#requirements) · [Installation](#installation) ·
[Including](#including) · [Example](example/Makefile) · [License](#license)

English · [Deutsch](README.de.md)

</div>

MakeLib consists of two files that a Makefile pulls in with `include`:
`colours.mk` provides ANSI colours and themes, `tools.mk` provides macros for
two-column help output. They are found through the variable `DEV_MAKE`.
If you only use the colours, including MakeLib is optional; if you use the
macros, MakeLib is a requirement (see [Including](#including)).

## Overview

- [Requirements](#requirements)
- [Installation](#installation)
- [Including](#including)
- [Files](#files)
- [Colours and themes](#colours-and-themes)
- [Development](#development)
- [License](#license)

## Requirements

- **GNU Make**, including version 3.81 that ships with macOS.
- **pipx** for the installation, and Python 3.9 or newer.
- **`DEV_MAKE`** points to the directory with `colours.mk` and `tools.mk`;
  `makelib-path` prints it (see [Installation](#installation)).

[↑ Overview](#overview)

## Installation

MakeLib is installed with pipx as a versioned package. `<release-tag>` is a
tag from the [releases](https://github.com/MikeMitterer/make-lib/tags):

```bash
pipx install 'git+https://github.com/MikeMitterer/make-lib.git@<release-tag>'
```

The command `makelib-path` prints the directory with `colours.mk` and
`tools.mk`; `makelib-path --version` prints the installed version. Set
`DEV_MAKE` from it, for example in `~/.bashrc` or `~/.zshrc`:

```bash
export DEV_MAKE="$(makelib-path)"
```

A Makefile can also determine the directory itself. Without an installation
`DEV_MAKE` stays empty and `-include` skips the file:

```make
DEV_MAKE ?= $(shell makelib-path 2>/dev/null)
-include $(DEV_MAKE)/colours.mk
```

If you work on MakeLib itself, install your working copy instead
(`<path-to-make-lib>` is its folder); changes to the `.mk` files then take
effect without reinstalling:

```bash
pipx install -e <path-to-make-lib>
```

[↑ Overview](#overview)

## Including

**A Makefile does not rebuild anything from MakeLib.** Replacement definitions
in your own Makefile would be copies that drift apart over time. How to
include MakeLib depends on what the Makefile uses.

**Only colours from `colours.mk`: optional with `-include`.** If MakeLib is
missing, the colour variables stay empty and the output appears without
colours. The Makefile then also runs in a fresh clone or in CI without
`DEV_MAKE`.

```make
-include $(DEV_MAKE)/colours.mk

help:
	@printf '\n$(THEME_COLOR_GROUP)Commands$(RESET)\n'
```

**Macros from `tools.mk`: MakeLib is a requirement.** Without the file,
`usageLine2` and the other macros would be empty, and make fails with an
obscure message from the shell. The Makefile therefore checks first and stops
with a clear hint:

```make
ifeq ($(wildcard $(DEV_MAKE)/tools.mk),)
$(error MakeLib fehlt: DEV_MAKE auf MakeLib/src setzen (https://github.com/MikeMitterer/make-lib))
endif
include $(DEV_MAKE)/colours.mk
include $(DEV_MAKE)/tools.mk

help:
	@printf '\n$(THEME_COLOR_GROUP)Commands$(RESET)\n'
	$(usageLine2) "help" "Show help"
	$(usageLine2) "test" "Run tests"
```

[↑ Overview](#overview)

## Files

A complete example using both files is in
[example/Makefile](example/Makefile); in the repository it runs with
`make -C example`.


| File | Contents |
|---|---|
| `src/colours.mk` | Basic colours (`RED`, `GREEN`, `YELLOW`, `BLUE` …, `RESET`, `NC`), extended palette, theme colours (`THEME_COLOR_GROUP`, `THEME_COLOR_TARGET`, `THEME_COLOR_DESC` …), layout values (`THEME_INDENT_GROUP`, `THEME_INDENT_TARGET`, `THEME_WIDTH_TARGET`, `THEME_WIDTH_HELP` …), macro `print_colours` for a 256-colour table |
| `src/tools.mk` | Two-column lines for help output: `usageLine`, `infoLine`, `optionLine` (with `$(call …)`) and `usageLine2`, `infoLine2`, `optionLine2` (directly with arguments) |

[↑ Overview](#overview)

## Colours and themes

`MAKE_THEME` selects the theme (`classic`, `ocean`, `earth`, `night`, `mono`,
`sunset`, `forest`, `neon`, `shell`), as a variable when calling make or in
the environment, for example `export MAKE_THEME=ocean`.
With `NO_COLOR` set, or a terminal without `xterm` in `TERM`, there are no
colours. Layout values, colour roles and the alignment with BashLib and
ProjectTools are described in [docs/themes.md](docs/themes.md) (German).

[↑ Overview](#overview)

## Development

`make setup` sets up a checkout; MakeLib needs nothing installed for it, but
the target can be run any number of times. `make check` checks
[example/Makefile](example/Makefile) against `src/` of this checkout: every
theme, the output without colours, the colour table and the abort without
MakeLib. The checks are in [scripts/check.sh](scripts/check.sh).

[↑ Overview](#overview)

## License

Copyright © 2022–2026 Michael Mitterer. **MangoLila GmbH** is the provider and
licensor.

MakeLib is licensed under the **[EUPL 1.2](LICENSE)**, version 1.2 only. It
permits personal and commercial use, changes, redistribution, sale and hosting
without a paid license.

If you redistribute MakeLib or a changed version, or offer it as a network
service, keep the copyright and license notices, mark your changes and
provide the corresponding source under the license's copyleft rules.

The warranty and liability exclusions in EUPL Articles 7 and 8 also apply to
consumers, as far as the law permits. Mandatory rights remain unaffected,
including liability for intent, gross negligence, personal injury and product
liability. No additional guarantee is given.

Contact: **office@MangoLila.at**.

Details: [LICENSE](LICENSE) · [German license text](LICENSE.de.txt) ·
[Provider and consumer declaration](LICENSING.md)
