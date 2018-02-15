# This is the same as scale.geno.R, but uses function "scale_better"
# instead of "scale", which should use less memory.
source("scale.R")
cat("Loading genotype data.\n")
load("../data/geno.RData")
cat("Centering and scaling genotype matrix.\n")
geno <- scale_better(geno)
