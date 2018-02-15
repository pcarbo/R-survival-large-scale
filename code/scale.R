# The same as scale(X,center = TRUE,scale = TRUE), but uses less
# memory.
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
