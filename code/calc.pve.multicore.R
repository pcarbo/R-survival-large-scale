# This is the same as calc.pve.R, but uses parLapply to speed up the
# computation when multiple cores (CPUs) are available.
#
# To run this script using Rscript (or "batch mode"), type the
# following in the command line:
#
#   Rscript calc.pve.multicore.R <nc>
#
# where <nc> is the number of threads to use for computing the
# weights.
#

# SCRIPT PARAMETERS
# -----------------
# Candidate values for the PVE estimate
h <- seq(0.01,0.99,0.005)

# The computation of the weights is divided among this many
# threads.
args <- commandArgs(trailingOnly = TRUE)
nc   <- as.integer(args[1])

# SET UP ENVIRONMENT
# ------------------
library(parallel)
source("pve.R")

# LOAD DATA
# ---------
cat("Loading data.\n")
load("../data/gwas.RData")
cat(sprintf("Loaded %d x %d genotype matrix.\n",nrow(X),ncol(X)))

# DATA PROCESSING
# ---------------
# Center phenotypes. (We assume the genotypes have already been centered.)
y <- y - mean(y)

# ESTIMATE PVE
# ------------
# For each <setting h, get the model parameter---the variance of the
# regression coefficients.
cat("Computing prior variance settings.\n")
sa <- get.prior.variances(X,h)

# Now we reach the most numerically intensive part. Here we compute
# the log-weight for each genetic variance setting.
cat("Computing weights for",length(h),"PVE settings.\n")
cat("Number of threads used for BLAS operations:",
    Sys.getenv("OPENBLAS_NUM_THREADS"),"\n")
cat("Weights are being computed separately in",nc,"threads.\n")
timing <- system.time(logw <- compute.log.weights.parlapply(K,y,sa,nc))
cat("Computation took",timing["elapsed"],"seconds.\n")

# SUMMARIZE RESULTS
# -----------------
# Now that we have done the hard work of computing the importance
# weights, we can quickly compute a numerical estimate of the
# posterior mean h.
w <- normalizelogweights(logw)
cat(sprintf("Mean PVE estimate is %0.3f.\n",sum(w*h)))
