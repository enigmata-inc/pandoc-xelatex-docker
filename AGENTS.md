# pandoc-xelatex-docker

Builds a Docker image (Ubuntu 26.04) for PDF generation from Markdown, LaTeX,
and other formats via Pandoc plus XeLaTeX over TeX Live, with TeX Gyre fonts
and Unicode support.

**The image bakes in the shared Enigmata SDK PDF template** at
`/opt/enigmata/enigmata-xelatex.tex`, so every SDK repo references one canonical
template instead of vendoring its own copy. A change to `enigmata-xelatex.tex`
changes every consumer's PDF output. The consumers today, and how each one
picks up a new image:

- `enigmata-inc/cipher-sdk` pins a tag plus digest (`PANDOC_IMAGE` in
  `website/pdf/generate-pdf.sh`, currently `sha-98bfdf7`), so it only moves
  when someone bumps that line.
- `enigmata-institute/policy-sdk` pulls `:latest` (`website/pdf/generate-pdf.sh`
  and `.github/workflows/deploy-docs.yml`), so a merge here reaches its next
  docs build with no review on its side.

The template's footer organization comes from the `organization` metadata
variable, falling back to "Enigmata, Inc.".

## Build and use

```sh
docker build -t pandoc-xelatex .

docker run --rm -v "$PWD:/documents" pandoc-xelatex \
  pandoc SDK.md -o out.pdf --pdf-engine=xelatex \
  --template=/opt/enigmata/enigmata-xelatex.tex \
  --metadata-file=metadata.yaml --metadata=copyrightyear:"$(date +%Y)"
```

Default `WORKDIR` is `/documents`.

## CI and publishing

- `.github/workflows/ci.yml` (job `build`) builds the image on every pull
  request to `main` without pushing. It is not a required check today (see
  Open work).
- `.github/workflows/publish.yml` builds and pushes
  `ghcr.io/enigmata-inc/pandoc-xelatex` (tags `latest` and `sha-<short>`) on
  every push to `main` and on manual dispatch. It has no paths filter, so a
  docs-only merge also republishes `latest`. Both workflows share the GHA layer
  cache; when the apt layer is evicted from it, the rebuild installs whatever
  Ubuntu serves that day.
- Dependabot tracks the `FROM` image and the Actions. It cannot see the Pandoc
  `.deb` URL in the `Dockerfile`.

## Naming

An Enigmata repo (Enigmata, Inc., renamed from Probability Drive). We keep new
`pd`, `PD`, and `probabilitydrive` names out because the rename is meant to be
complete; the Cloudsmith slug `pd-k8sf` is the one permanent exception. The
`pd` and `PD` tokens already in this repo are pandoc and PDF abbreviations,
not the brand.

## Open work

- **Pandoc is pinned to an old release with no checksum.** `Dockerfile:30-33`
  downloads `pandoc-3.1.11-1-amd64.deb` by URL (the comment calls it "latest";
  the current upstream release is 3.12.1) and installs it without verifying a
  sha256. Done when the `.deb` is a current release, its sha256 is checked
  before `dpkg -i`, and the cipher-sdk and policy-sdk PDFs have been rebuilt
  and compared with the new image.
- **The PR build is not a required check.** `main` branch protection exists
  but has no required status checks, so a red `build` can merge and
  `publish.yml` then fails on `main`. Done when `build` (GitHub Actions app,
  strict) is required on `main`. Owner decides (branch-protection change).
