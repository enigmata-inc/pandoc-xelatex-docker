# pandoc-xelatex-docker

## Company name: Enigmata (formerly Probability Drive)

> **Rename:** Our company was renamed from **Probability Drive, Inc.** to **Enigmata, Inc.** Use the new names everywhere and never reintroduce the old ones.

| Old | New |
| --- | --- |
| Probability Drive, Inc. | Enigmata, Inc. |
| Probability Drive / ProbabilityDrive | Enigmata |
| probabilitydrive.com | enigmata.xyz |
| pd.institute | enigmata.institute |
| `pd` (brand / name prefix) | `enigmata` |

**Rules for Claude:**
- Never introduce `pd`, `PD`, `probabilitydrive`, or `Probability Drive` in new code, identifiers, filenames, config, URLs, docs, or user-facing copy. Always use the Enigmata equivalent.
- The migration is total: **everything** still carrying a `pd` / `probabilitydrive` name is legacy debt to be renamed to Enigmata over time. Treat any such reference as migrate-eventually, never as a convention to copy. Some (frozen wire constants, persisted identifiers, public API symbols) need a versioned migration rather than a blind rename — flag those, don't silently break them.
- **The one permanent exception** is the existing Cloudsmith repository slug **`pd-k8sf`** (e.g. `pd-k8sf/internal`). It is the *only* `pd` name that survives the rebrand — keep it exactly as-is and do not coin new `pd`-prefixed names by analogy.

## Purpose

Builds a production Docker image (Ubuntu 22.04) for high-quality PDF generation from Markdown/LaTeX and other formats via Pandoc + XeLaTeX over a full TeX Live install with professional fonts (TeX Gyre) and Unicode support. The image bakes in the shared Enigmata SDK PDF template so every SDK repo references one canonical template instead of vendoring its own copy.

Note: `pd`/`PD` tokens in this repo are pandoc/PDF abbreviations, not the brand.

## Key files

- `Dockerfile` — image definition; installs TeX Live, fonts, Pandoc 3.1.11, and copies the template to `/opt/enigmata/enigmata-xelatex.tex`.
- `enigmata-xelatex.tex` — the bundled Pandoc XeLaTeX template; footer org comes from the `organization` metadata variable, falling back to "Enigmata, Inc.".
- `.github/workflows/publish.yml` — on push to `main` (or manual dispatch), builds and pushes the image to GitHub Container Registry as `ghcr.io/<owner>/pandoc-xelatex` (tags `latest` and `sha`).
- `README.md` — overview, included packages/fonts, and usage examples.
- `LICENSE` — MIT, Copyright (c) 2025 Enigmata, Inc.

## Build and usage

Build the image locally:

```sh
docker build -t pandoc-xelatex .
```

Generate a PDF using the bundled Enigmata template:

```sh
pandoc SDK.md -o out.pdf --pdf-engine=xelatex \
  --template=/opt/enigmata/enigmata-xelatex.tex \
  --metadata-file=metadata.yaml --metadata=copyrightyear:"$(date +%Y)"
```

Run interactively against documents in the current directory (default `WORKDIR` is `/documents`):

```sh
docker run --rm -v "$PWD:/documents" pandoc-xelatex bash
```
