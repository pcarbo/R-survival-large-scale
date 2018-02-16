# This function takes as input an array of unnormalized log-importance
# weights and returns normalized importance weights such that the sum
# of the normalized importance weights is equal to 1. We guard against
# underflow or overflow by adjusting the log-importance weights so
# that the largest importance weight is 1.
normalizelogweights <- function (logw) {
  c <- max(logw)
  w <- exp(logw - c)
  return(w/sum(w))
}

# For each PVE setting h, get the prior variance of the regression
# coefficients assuming a fully "polygenic" model.
get.prior.variances <- function (X, h) {
  sx <- sum(apply(X,2,sd)^2)
  return(ncol(X)*h/(1-h)/sx)
}

# This function computes the marginal log-likelihood the regression
# model of Y given X assuming that the prior variance of the
# regression coefficients is sa. Here K is the "kinship" matrix, K =
# tcrossprod(X)/ncol(X). Also, note that H is the covariance matrix of
# Y divided by residual variance.
compute.log.weight <- function (K, y, sa) {
  n <- length(y)
  H <- diag(n) + sa*K
  R <- tryCatch(chol(H),error = function(e) FALSE)
  if (is.matrix(R)) {
    x    <- backsolve(R,forwardsolve(t(R),y))
    logw <- (-determinant(sum(y*x)*H,logarithm = TRUE)$modulus/2)
  } else
    logw <- 0
  return(logw)
}

# This function computes the marginal log-likelihood for multiple
# settings of the prior variance parameter.
compute.log.weights <- function (K, y, sa)
  sapply(as.list(sa),function (x) compute.log.weight(K,y,x))

# This is the same as compute.log.weights, but uses the "parLapply"
# function from the parallel package.
compute.log.weights.parlapply <- function (K, y, sa, nc = 1) {
  cl      <- makeCluster(nc)
  clusterExport(cl,c("compute.log.weight","compute.log.weights"))
  samples <- clusterSplit(cl,1:length(sa))
  logw    <- parLapply(cl,samples,
                       function (i, K, y, sa) compute.log.weights(K,y,sa[i]),
                       K,y,sa)
  logw    <- do.call(c,logw)
  logw[unlist(samples)] <- logw
  stopCluster(cl)
  return(logw)
}
