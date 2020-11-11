#' Computes the design model
#' @param N the number of feasible points
#' @param a the lower bound
#' @param b the upper bound
#' @param PolyOrder the order of the design space
#' @param Method the type of optimal design to be used
#' @param FeasablePoints the points whose weights will be optimized
#' @import
#' @return @ returns A the design model
#' @export
#' @examples
#' model(N,a,b,PolyOrder,FeasablePoints)

model <- function(N,
                  a,
                  b,
                  PolyOrder,
                  FeasablePoints)
{
  P = 0:PolyOrder
  A = lapply(1:N, function(i) A[[i]] = FeasablePoints(i,a,b)^P %*% t(FeasablePoints(i,a,b)^P))
  return(A)
}
