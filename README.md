# luamathaccents

**Version 1.0 (2026/07/26)**

Type accented mathematical symbols directly in your source file using
Unicode combining characters. With luamathaccents loaded, the two-character
sequence `x` + U+0302 (combining circumflex accent) — which your editor
displays as an accented letter — is rewritten on input to `\hat x`, and
likewise for two dozen other combining characters (grave, acute, tilde,
macron, breve, dot, diaeresis, caron, vector arrow, harpoons, and more).

The package uses LuaTeX's `process_input_buffer` callback, so it
requires the LuaTeX engine (`lualatex`). Some of the rarer generated
commands (`\ovhook`, `\candra`, `\annuity`, ...) are provided by the
`unicode-math` package.

## Usage

```latex
\usepackage{luamathaccents}
```

The rewriting is active from that point on. `\LuaMathAccentsOff` and
`\LuaMathAccentsOn` disable and re-enable it mid-document.

See `luamathaccents-doc.pdf` for the full list of supported combining
characters and some caveats.

Development happens at <https://github.com/NittanyLion/luamathaccents>;
please report bugs there.

## Installation

The package is contained in `luamathaccents.sty` and `luamathaccents.lua`; both
must be findable by LuaLaTeX. For a TDS-compliant installation, place
the files as:

- `tex/lualatex/luamathaccents/luamathaccents.sty`
- `tex/lualatex/luamathaccents/luamathaccents.lua`
- `doc/lualatex/luamathaccents/luamathaccents-doc.tex`
- `doc/lualatex/luamathaccents/luamathaccents-doc.pdf`
- `doc/lualatex/luamathaccents/README.md`

The documentation is built with `lualatex luamathaccents-doc.tex` (run
twice).

## License

Copyright 2026 Joris Pinkse.

This work may be distributed and/or modified under the conditions of
the [LaTeX Project Public License](https://www.latex-project.org/lppl.txt),
either version 1.3c of this license or (at your option) any later
version. This work has the LPPL maintenance status "maintained"; the
current maintainer is Joris Pinkse (pinkse@gmail.com).
