FROM rocker/r-ver:3.6.2

# install build dependencies
RUN set -ex; \
    \
    export DEBIAN_FRONTEND=noninteractive; \
    \
    buildDeps=" \
        curl \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev \
        wget \
        zlib1g-dev \
    " ; \
    \
    apt-get update; \
    apt-get install -y $buildDeps --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*;

# install renv
ENV RENV_VERSION 0.9.3-56
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

# install the R package
WORKDIR /opt/work
COPY renv.lock renv.lock
RUN R -e 'renv::restore()'
