# In this script, we will estimate the proportion of variance in the
# phenotype (Y) that is explained by the genotypes (X).  This
# estimation involves numerically intensive computations;
# specifically, it involves factorizing a large, symmetric matrix
# separately for each candidate value of the PVE ("proportion of
# variance explained").

# SCRIPT PARAMETERS
# -----------------
# Candidate values for the PVE estimate
h <- seq(0.01,0.99,0.005)

# SET UP ENVIRONMENT
# ------------------
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
timing <- system.time(logw <- compute.log.weights(K,y,sa))
cat("Computation took",timing["elapsed"],"seconds.\n")

# SUMMARIZE RESULTS
# -----------------
# Now that we have done the hard work of computing the importance
# weights, we can quickly compute a numerical estimate of the
# posterior mean h.
w <- normalizelogweights(logw)
cat(sprintf("Mean PVE estimate is %0.3f.\n",sum(w*h)))
