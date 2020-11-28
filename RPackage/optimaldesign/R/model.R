#' Computes the list of matrices A
#' @param N the number of feasible points
#' @param a the lower bound of the design space
#' @param b the upper bound of the design space
#' @param PolyOrder the order of the polynomial regression model
#' @param Method the optimality criterion of the optimal design
#' @param FeasablePoints the points whose weights will be optimized. The length of the FeasablePoints should be N.
#' @return returns A for the model
#' @examples model(N = 21, a = -1, b = 1, PolyOrder = 3, FeasiblePoints = function(i,a = -1,b = 1) a + (b-a) * (i-1) / (N-1))
#' @examples model(N = 21, a = -1, b = 1, PolyOrder = 3, FeasiblePoints =  -1 + (1 - (-1)) * (1:21-1) / (21-1))
#' model(N,a,b,PolyOrder,FeasiblePoints)

model <- function(N,
                  a,
                  b,
                  PolyOrder,
                  FeasiblePoints,
                  type = function(i) FeasiblePoints[i]^P %*% t(FeasiblePoints[i]^P)
                  )
{
  P = 0:PolyOrder
  A = list(N)

  A = lapply(1:N, A[[i]] = type(i) )

  trig = c(FeasiblePoints[i],sin(FeasiblePoints[i]),cos(FeasiblePoints[i]))

  type = function(i) FeasiblePoints[i]^P %*% t(FeasiblePoints[i]^P)

  if(is.vector(FeasiblePoints))
    A = lapply(1:N, function(i) A[[i]] = FeasiblePoints[i]^P %*% t(FeasiblePoints[i]^P))
  else
    A = lapply(1:N, function(i) A[[i]] = FeasiblePoints(i,a,b)^P %*% t(FeasiblePoints(i,a,b)^P))

  return(A)
}
