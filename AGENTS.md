# pandoc-xelatex-docker

Builds a production Docker image (Ubuntu 22.04) for high-quality PDF generation
from Markdown, LaTeX, and other formats via Pandoc plus XeLaTeX over a full TeX
Live install with professional TeX Gyre fonts and Unicode support.

**The image bakes in the shared Enigmata SDK PDF template** at
`/opt/enigmata/enigmata-xelatex.tex`, so every SDK repo references one canonical
template instead of vendoring its own copy. Consumers today: `cipher-sdk` and
`policy-sdk`. A change to `enigmata-xelatex.tex` changes every SDK's PDF output.

The template's footer organization comes from the `organization` metadata
variable, falling back to "Enigmata, Inc.".

## Build and use

```sh
docker build -t pandoc-xelatex .

pandoc SDK.md -o out.pdf --pdf-engine=xelatex \
  --template=/opt/enigmata/enigmata-xelatex.tex \
  --metadata-file=metadata.yaml --metadata=copyrightyear:"$(date +%Y)"

docker run --rm -v "$PWD:/documents" pandoc-xelatex bash
```

Default `WORKDIR` is `/documents`. `.github/workflows/publish.yml` builds and
pushes to `ghcr.io/<owner>/pandoc-xelatex` (tags `latest` and `sha`) on push to
`main` or manual dispatch.

## Naming

An Enigmata repo (Enigmata, Inc., renamed from Probability Drive). Never
introduce `pd`, `PD`, or `probabilitydrive` names. The Cloudsmith slug
`pd-k8sf` is the one permanent exception. Existing `pd_` wire constants and
persisted identifiers are legacy debt: flag them, never blind-rename them.

The `pd` and `PD` tokens already in this repo are pandoc and PDF
abbreviations, not the brand.
