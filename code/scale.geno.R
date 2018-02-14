# TO DO: Explain here briefly what this script does.
source("functions.R")
cat("Loading genotype data.\n")
load("../data/geno.RData")
cat("Centering and scaling genotype matrix.\n")
# geno <- scale_matrix(geno,verbose = TRUE)
geno <- scale_matrix(geno,verbose = FALSE)


