#!/bin/sh

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

# Shell script for building a Singularity image from Docker Hub and running it
# Run with "sh ./singularity.sh rstudio 8787"
# Then locally something like "ssh -N -L 8787:localhost:8787 user@ip-address"
# The ports can be set to whatever you choose
# For more details: https://divingintogeneticsandgenomics.rbind.io/post/run-rstudio-server-with-singularity-on-hpc/
# Be sure to check images and paths

singularity pull fan1ko-ipsc-snrnaseq.simg docker://eturkes/fan1ko-ipsc-snrnaseq:R4.2.1v3

if [ "$1" = "all" ]; then
    singularity exec \
        -B .:/home/rstudio/FAN1KO-ipsc-snRNAseq \
        ad-cbd-exosome-proteins.simg \
    Rscript -e "source('/home/rstudio/FAN1KO-ipsc-snRNAseq/R/run_all.R')"

elif [ "$1" = "rstudio" ]; then
    # TODO: Point bind point to user's home.
    DISABLE_AUTH=true RSTUDIO_SESSION_TIMEOUT="0" \
    singularity exec \
        -B .:/home/rstudio/FAN1KO-ipsc-snRNAseq \
        fan1ko-ipsc-snrnaseq.simg rserver --www-address=127.0.0.1 --www-port=$2
fi
