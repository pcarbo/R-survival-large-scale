source("functions.R")
cat("Loading genotype data.\n")
load("../data/geno.RData")
cat("Standard deviations of columns (SNPs):\n")
summary(apply(geno,2,function (x) sd(x,na.rm = TRUE)))
# cat("Centering and scaling genotype matrix.\n")
# geno <- scale.geno(geno)
# cat("Standard deviations of columns (SNPs):\n")
# summary(apply(geno,2,function (x) sd(x,na.rm = TRUE)))



