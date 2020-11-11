#' Computes the design model
#' @param N the number of feasible points
#' @param a the lower bound
#' @param b the upper bound
#' @param PolyOrder the order of the design space
#' @param Method the type of optimal design to be used
#' @param FeasablePoints the points whose weights will be optimized
#' @export
#' @return returns A the design model
#' @examples model(N = 21, a = -1, b = 1, PolyOrder = 3, FeasiblePoints = function(i,a = -1,b = 1) a + (b-a) * (i-1) / (N-1))
#' @examples model(N = 21, a = -1, b = 1, PolyOrder = 3, FeasiblePoints =  -1 + (1 - (-1)) * (1:21-1) / (21-1))
#' model(N,a,b,PolyOrder,FeasiblePoints)

model <- function(N,
                  a,
                  b,
                  PolyOrder,
                  FeasiblePoints)
{
  if(is.vecotor(FeasiblePoints))
    A = lapply(1:N, function(i) A[[i]] = FeasiblePoints[i]^P %*% t(FeasiblePoints[i]^P))
  else
    A = lapply(1:N, function(i) A[[i]] = FeasiblePoints(i,a,b)^P %*% t(FeasiblePoints(i,a,b)^P))

  return(A)
}
