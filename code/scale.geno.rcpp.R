# This is the same as scale.geno.R, but attempts to eliminate
# unnecessary memory allocation by "copying in place" using Rcpp.
library(Rcpp)
sourceCpp("scale.cpp")
cat("Loading genotype data.\n")
load("../data/geno.RData")
cat("Computing column means and sds.\n")
a <- colMeans(geno,na.rm = TRUE)
p <- ncol(geno)
b <- rep(0,p)
for (i in 1:p)
  b[i] <- sd(geno[,i],na.rm = TRUE)
cat("Centering and scaling genotype matrix.\n")
scale_rcpp(geno,a,b)
