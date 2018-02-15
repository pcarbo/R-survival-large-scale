# Short script to center and scale the columns (i.e., SNPs) of a
# matrix containing genotypes. Note that some of the genotypes may be
# missing.
cat("Loading genotype data.\n")
load("../data/geno.RData")
cat("Centering and scaling genotype matrix.\n")
geno <- scale(geno)

