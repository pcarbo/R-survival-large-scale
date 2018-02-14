# Right now all the functions will go in one file, functions.R. Maybe
# later I will try to organize them better.

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
scale_matrix <- function (X, verbose = TRUE) {

  # Center and scale each column.
  Y <- scale(X)

  # Summarize the scaled matrix.
  if (verbose) {
    s0  <- apply(X,2,function (x) sd(x,na.rm = TRUE))
    s1  <- apply(Y,2,function (x) sd(x,na.rm = TRUE))
    dat <- rbind(summary(s0),summary(s1))
    rownames(dat) <- c("before","after")
    print(dat)
  }
  return(Y)
}
