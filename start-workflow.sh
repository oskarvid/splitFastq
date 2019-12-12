#!/bin/bash

set -Ee
# Uncomment to enable debugging
#set -vo xtrace

#source scripts/functions.sh
#source settings/settings.conf

# Set default variables
START=$(date +%s)
DATE=$(date +%F.%H.%M.%S)

# Run sbatch with all variables set and store the slurm id in $SLURMID
docker run \
--rm \
-ti \
-u $UID:1000 \
-v $(pwd):/data \
-w /data \
oskarv/gatk-snakemake snakemake -j -p

# Print benchmarking data
FINISH=$(date +%s)
EXECTIME=$(( $FINISH-$START ))
printf "The entire workflow, including input file transfer, job execution on Colossus, and output file transfer back to the p172ncspmdata disk, took %dd:%dh:%dm:%ds\n" $((EXECTIME/86400)) $((EXECTIME%86400/3600)) $((EXECTIME%3600/60)) $((EXECTIME%60))
