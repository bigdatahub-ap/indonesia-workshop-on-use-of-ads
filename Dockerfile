# ---- Stage 1: render the Quarto site from source ----
FROM rocker/r-ver:4.3.2 AS builder

ENV DEBIAN_FRONTEND=noninteractive

# System libraries needed to build R packages, plus Python for the example notebooks
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl gdebi-core \
    python3 python3-pip \
    libcurl4-openssl-dev libssl-dev libxml2-dev libgit2-dev \
    libfontconfig1-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev \
    libharfbuzz-dev libfribidi-dev \
    && rm -rf /var/lib/apt/lists/*

# Quarto CLI
ARG QUARTO_VERSION=1.5.57
RUN curl -sLO https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb \
    && gdebi --non-interactive quarto-${QUARTO_VERSION}-linux-amd64.deb \
    && rm quarto-${QUARTO_VERSION}-linux-amd64.deb

# R packages used by the example notebooks (content/*.qmd and notebooks/*_R.ipynb)
RUN Rscript -e "install.packages(c('tidyverse','ggplot2','knitr','rmarkdown','IndexNumR','PriceIndices'), repos='https://cran.r-project.org')"

# Python packages used by the example notebooks (notebooks/*_Python.ipynb)
RUN pip3 install --no-cache-dir \
    jupyter numpy pandas matplotlib polars pyindexnum itables

WORKDIR /workspace
COPY . .

RUN quarto render

# ---- Stage 2: serve the rendered static site ----
FROM nginx:alpine

COPY --from=builder /workspace/_site /usr/share/nginx/html

EXPOSE 80
