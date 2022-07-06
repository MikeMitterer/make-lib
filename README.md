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

