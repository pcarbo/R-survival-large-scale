# Generate SNP genotype data with minor allele frequencies that are
# uniform over range [0.05,0.5]. Genotypes are simulated assuming all
# SNPs are uncorrelated (i.e., unlinked). Inputs argument n and p are,
# respectively, the number of samples and SNPs to simulate.  Setting
# na.rate > 0 will set the genotypes to missing uniformly at random at
# the requested rate.
sim.geno <- function (n, p, na.rate = 0) {
  f    <- 0.05 + 0.45*runif(p)
  geno <- (runif(n*p) < f) +
          (runif(n*p) < f)
  if (na.rate > 0) {
    i       <- which(runif(n*p) < na.rate)
    geno[i] <- NA
  }
  return(matrix(as.double(geno),n,p,byrow = TRUE))
}

# TO DO: Explain here what this function does, and how to use it.
scale_better <- function (X) {

  # Center and scale each column.
  p <- ncol(X)
  for (i in 1:p) {
    y     <- X[,i]
    y     <- y - mean(y,na.rm = TRUE)
    y     <- y / sd(y,na.rm = TRUE)
    X[,i] <- y
  }
  
  # Return the scaled matrix.
  return(X)
}
