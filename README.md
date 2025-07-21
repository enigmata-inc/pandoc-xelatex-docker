# pandoc-xelatex-docker

Production-ready Docker image for high-quality PDF generation using Pandoc, XeLaTeX, and TeX Live with professional fonts and full Unicode support

## Overview

A comprehensive Docker image for converting Markdown, LaTeX, and other document formats to beautiful PDFs using Pandoc and XeLaTeX. Features a complete TeX Live installation with scientific packages, professional fonts (TeX Gyre), syntax highlighting, and extensive language support. Perfect for CI/CD pipelines, documentation systems, and automated report generation.

## Features

- **Complete TeX Live installation** with all recommended packages
- **Professional fonts** including TeX Gyre (Helvetica, Times, Courier clones)
- **Full Unicode support** for international documents
- **Syntax highlighting** for code blocks
- **Scientific typesetting** with math support
- **Multiple format support** (Markdown, LaTeX, HTML, DOCX, and more)
- **Optimized for CI/CD** pipelines

## Included Packages

### TeX Packages

- `texlive-xetex` - XeLaTeX engine
- `texlive-latex-base` - Core LaTeX
- `texlive-latex-extra` - Additional LaTeX packages
- `texlive-latex-recommended` - Recommended packages
- `texlive-fonts-recommended` - Standard fonts
- `texlive-fonts-extra` - Additional fonts
- `texlive-lang-english` - English language support
- `texlive-pictures` - TikZ/PGF support
- `texlive-science` - Math and science packages

### Fonts

- TeX Gyre fonts (professional alternatives to Helvetica, Times, Courier)
- Liberation fonts
- DejaVu fonts
- Roboto
- Open Sans
- Latin Modern

### Tools

- Pandoc 3.1.11 (latest version)
- ImageMagick (for image conversion)
- librsvg2 (for SVG support)

## Advanced Usage

### Custom LaTeX templates

Create a custom template with professional typography:

```latex
\documentclass{article}
\usepackage{fontspec}
\setmainfont{TeX Gyre Termes}  % Times alternative
\setsansfont{TeX Gyre Heros}   % Helvetica alternative
\setmonofont{TeX Gyre Cursor}  % Courier alternative

\begin{document}
$body$
\end{document}
```

### Syntax highlighting

The image includes support for syntax highlighting with multiple styles. Available styles include: `pygments`, `tango`, `espresso`, `zenburn`, `kate`, `monochrome`, `breezedark`, `haddock`

## Font Information

The image includes professional-quality fonts:

- **Sans-serif**: TeX Gyre Heros (Helvetica clone), Liberation Sans
- **Serif**: TeX Gyre Termes (Times clone), Liberation Serif  
- **Monospace**: TeX Gyre Cursor (Courier clone), DejaVu Sans Mono
- **Math**: Latin Modern Math, TeX Gyre Math fonts

## Environment Variables

- `DEBIAN_FRONTEND=noninteractive` - Prevents interactive prompts during package installation

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built on Ubuntu 22.04 LTS for stability
- Uses the official Pandoc releases
- Incorporates the comprehensive TeX Live distribution
