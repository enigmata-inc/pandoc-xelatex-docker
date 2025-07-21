FROM ubuntu:22.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install TeX Live and dependencies
RUN apt-get update && apt-get install -y \
    texlive-xetex \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-lang-english \
    texlive-pictures \
    texlive-science \
    texlive-font-utils \
    lmodern \
    tex-gyre \
    fonts-liberation \
    fonts-roboto \
    fonts-open-sans \
    gsfonts-x11 \
    imagemagick \
    librsvg2-bin \
    wget \
    make \
    && rm -rf /var/lib/apt/lists/*

# Install latest Pandoc
RUN wget https://github.com/jgm/pandoc/releases/download/3.1.11/pandoc-3.1.11-1-amd64.deb \
    && dpkg -i pandoc-3.1.11-1-amd64.deb \
    && rm pandoc-3.1.11-1-amd64.deb

# Create working directory
WORKDIR /documents

# Default command
CMD ["bash"]