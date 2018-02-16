# In this script, we will estimate the proportion of variance in the
# phenotype (Y) that is explained by the genotypes (X).  This
# estimation involves numerically intensive computations;
# specifically, it involves factorizing a large, symmetric matrix
# separately for each candidate value of the PVE (proportion of
# variance explained).

# 1. SET UP ENVIRONMENT
# ---------------------
# These are some functions that we will use here and in other parts of
# the workshop.
source("pve.R")

# For running this code with Rscript, I always load the methods
# package just to be safe.
library(methods)

# Candidate values for the genetic variance parameter.
h <- seq(0.01,0.99,0.01)

# LOAD DATA
# ---------
cat("Loading data.\n")
load("../data/gwas.RData")

# DATA PROCESSING
# ---------------
# Center phenotypes. (We assume the genotypes are already centered.
y <- y - mean(y)

# 5. ESTIMATE GENETIC VARIANCE
# ----------------------------
# For each <setting h, get the model parameter---the variance of the
# regression coefficients.
cat("Computing prior variance settings.\n")
sa <- get.prior.variances(X,h)

# Now we reach the most numerically intensive part. Here we compute
# the log-weight for each genetic variance setting.
cat("Computing weights for",length(h),"PVE settings.\n")
cat("Number of threads used for BLAS operations:",
    Sys.getenv("OPENBLAS_NUM_THREADS"),"\n")
timing <- system.time(logw <- compute.log.weights(K,y,sa))
cat("Computation took",timing["elapsed"],"seconds.\n")

# SUMMARIZE RESULTS
# -----------------
# Now that we have done the hard work of computing the importance
# weights, we can quickly compute a numerical estimate of the
# posterior mean h.
w <- normalizelogweights(logw)
cat(sprintf("Mean PVE estimate is %0.3f.\n",sum(w*h)))
