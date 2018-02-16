#!/bin/bash

# This bash script illustrates how to use the sbatch command to submit
# a data analysis to the SLURM job scheduler, in which the script
# parameters are specified in the command line. Here is an example of
# running this script:
# 
#   sbatch scale.geno.sbatch ../data/geno.RData ../output/geno.scaled.RData
#

#SBATCH --partition=broadwl
#SBATCH --mem=3G
#SBATCH --time=00:10:00

# Get the input and output data files specified as command-line arguments.
INPUT=${1}
OUTPUT=${2}

# For reproducibility, add version number to "module load" call.
module load R/3.4.3

# Run the R script.
R CMD BATCH --no-save --no-restore "--args ${INPUT} ${OUTPUT}" \
  scale.geno.automated.R ../output/geno.scaled.automated.Rout
