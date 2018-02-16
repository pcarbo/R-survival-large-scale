# This is a version of scale.geno.rcpp.R that accepts two command-line
# arguments: the input data file and the output file.
library(Rcpp)
sourceCpp("scale.cpp")
args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 2)
  stop("Usage: Rscript scale.geno.auto.R <data-input> <data-output>")
data.in  <- args[1]
data.out <- args[2]
cat("Loading genotype data.\n")
load(data.in)
cat("Computing column means and sds.\n")
a <- colMeans(geno,na.rm = TRUE)
p <- ncol(geno)
b <- rep(0,p)
for (i in 1:p)
  b[i] <- sd(geno[,i],na.rm = TRUE)
cat("Centering and scaling genotype matrix.\n")
scale_rcpp(geno,a,b)
cat("Saving scaled matrix to file.\n")
save(list = "geno",file = data.out)
