# This is the same as scale.geno.R, but attempts to eliminate
# unnecessary memory allocation by implementing the columnwise scaling
# in a loop inside the main environment.
cat("Loading genotype data.\n")
load("../data/geno.RData")
cat("Centering and scaling genotype matrix.\n")
p <- ncol(geno)
for (i in 1:p) {
  x        <- geno[,i]
  x        <- x - mean(x,na.rm = TRUE)
  x        <- x / sd(x,na.rm = TRUE)
  geno[,i] <- x
}
