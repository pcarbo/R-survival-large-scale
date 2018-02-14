# Right now all the functions will go in one file, functions.R. Maybe
# later I will try to organize them better.

# Generate SNP genotype data with minor allele frequencies that are
# uniform over range [0.05,0.5]. Genotypes are simulated assuming all
# SNPs are uncorrelated (i.e., unlinked). Inputs argument "n" and "p"
# are, respectively, the number of samples and SNPs to simulate.
sim.geno <- function (n, p) {
  f    <- 0.05 + 0.45*runif(p)
  geno <- (runif(n*p) < f) +
          (runif(n*p) < f)
  return(matrix(as.double(geno),n,p,byrow = TRUE))
}
