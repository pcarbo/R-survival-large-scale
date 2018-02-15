# TO DO: Explain here briefly what this script does.
source("functions.R")
cat("Loading genotype data.\n")
load("../data/geno.RData")
cat("Centering and scaling genotype matrix.\n")
p <- ncol(geno)
for (i in 1:p) {
  x         <- geno[,i]
  x         <- x - mean(x,na.rm = TRUE)
  x         <- x / sd(x,na.rm = TRUE)
  geno[1,i] <- x[1]
}
