# Small script to simulated data that models an idealized genome-wide
# association study, in which all single nucleotide polymorphisms
# (SNPs) have alternative alleles at high frequencies in the
# population (>5%), and all SNPs contribute some (small) amount of
# variation to the quantitative trait.
#
# Adjust the script parameters below to control how the data are
# enerated.
#
source("sim.geno.R")

# SCRIPT PARAMETERS
# -----------------
r <- 0.6   # Proportion of variance in trait explained by SNPs.
n <- 1000  # Number of samples.
p <- 3e5   # Number of markers (SNPs).

# Initialize random number generation so that the results are
# reproducible.
set.seed(1)

# GENERATE DATA SET
# -----------------
# Simulate genotype matrix X.
cat("Generating data set.\n")
X <- sim.geno(n,p)

# Center the columns of X.
X <- scale(X,center = TRUE,scale = FALSE)

# Generate (small) polygenic additive effects for the SNPs.
beta <- rnorm(p)

# Adjust the QTL effects so that we control for the proportion of variance
# explained (r). That is, we adjust beta so that r = a/(a+1), where I've
# defined a = beta'*cov(X)*beta. Here, sb is the variance of the (nonzero)
# QTL effects.
sb   <- r/(1-r)/var(c(X %*% beta))
beta <- sqrt(sb) * beta

# Generate the quantitative trait measurements.
y <- c(X %*% beta + rnorm(n))

# Compute the n x n kinship matrix. This computation may take a minute
# or two.
cat("Computing kinship matrix.\n")
K <- tcrossprod(X)/p

# Save the genotype data, phenotype data and the kinship matrix to an
# .RData file.
cat("Saving data to file.\n")
save(list = c("X","y","K"),file = "../data/gwas.RData")
