#include <Rcpp.h>

using namespace Rcpp;

// TO DO: Explain here what this function does, and how to use it in R.
//
// [[Rcpp::export]]
double scale_rcpp (NumericMatrix& X, NumericVector& a, NumericVector& b) {
  int    nr = X.nrow();
  int    nc = X.ncol();
  int    i, j;
  double aj, bj;

  for(j = 0; j < nc; j++) {
    aj = a(j);
    bj = b(j);
    for(i = 0; i < nr; i++)
      X(i,j) = (X(i,j) - aj) / bj;
  }

  return 0;
}
