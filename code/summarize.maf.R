# TO DO: Explain here briefly what this script does.
cat("Loading genotype data.\n")
load("../data/geno.RData")
cat("Computing minor allele frequencies.\n")
maf <- colMeans(geno,na.rm = TRUE)/2
maf <- pmin(maf,1 - maf)
cat("Distribution of minor allele frequencies.\n")
print(quantile(maf,seq(0,1,0.1)),digits = 2)
