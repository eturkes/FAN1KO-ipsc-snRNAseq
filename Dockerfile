#    This file is part of FAN1KO-ipsc-snRNAseq.
#    Copyright (C) 2022  Emir Turkes, Emma Bunting, Jessica Olive,
#    Jasmine Donaldson, Sarah Tabrizi, UK Dementia Research Institute at
#    UCL
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#    Emir Turkes can be contacted at emir.turkes@eturkes.com

FROM rocker/rstudio:4.2.1

LABEL maintainer="Emir Turkes emir.turkes@eturkes.com"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libgeos-dev \
        libxml2-dev \
        libglpk-dev \
    && Rscript -e "install.packages('base64enc')" \
        -e "install.packages('digest')" \
        -e "install.packages('evaluate')" \
        -e "install.packages('glue')" \
        -e "install.packages('highr')" \
        -e "install.packages('htmltools')" \
        -e "install.packages('jsonlite')" \
        -e "install.packages('knitr')" \
        -e "install.packages('magrittr')" \
        -e "install.packages('rmarkdown')" \
        -e "install.packages('stringi')" \
        -e "install.packages('stringr')" \
        -e "install.packages('xfun')" \
        -e "install.packages('yaml')" \
        -e "install.packages('conflicted')" \
        -e "install.packages('DT')" \
        -e "install.packages('viridis')" \
        -e "install.packages('BiocManager')" \
        -e "install.packages('remotes')" \
        -e "BiocManager::install('SingleCellExperiment')" \
        -e "BiocManager::install('scuttle')" \
        -e "BiocManager::install('DropletUtils')" \
        -e "BiocManager::install('glmGamPoi')" \
        -e "BiocManager::install('GSVA')" \
        -e "remotes::install_github('satijalab/seurat', ref = 'develop')" \
    && apt-get clean \
    && rm -Rf \
        /var/lib/apt/lists/ \
        /tmp/downloaded_packages/ \
        /tmp/*.rds
