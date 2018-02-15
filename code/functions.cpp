#include <Rcpp.h>

using namespace Rcpp;

// TO DO: Explain here what this function does, and how to use it in R.
//
// [[Rcpp::export]]
double scale_rcpp (NumericMatrix& X) {
  int i, j;
  int nr = X.nrow();
  int nc = X.ncol();

  // Column-major order.
  for(j = 0; j < nc; j++)
    for(i = 0; i < nr; i++)
      X(i,j) += 1;

  return 0;
}
