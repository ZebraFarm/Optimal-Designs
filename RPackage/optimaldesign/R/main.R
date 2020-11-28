library(CVXR)
#source("./")
#source("./A_optimal.R")
#source("./D_optimal.R")
#source("./E_optimal.R")
#source("./c_optimal.R")
#source("./model.R")

#' Optimal Design
#' @description Computes an Optimal Design by minimizing a convex objective function with simplex constraints.  Polynomial regression models with one independent variable are considered, and the design space is an interval.
#' @param N the number of feasible points, (a positive integer).  It can be slow if N is larger than 500.
#' @param a the lower bound (numeric) of the design space
#' @param b the upper bound (numeric, where b > a) of the design space
#' @param PolyOrder the order of the polynomial regression model (a positive integer)
#' @param Method the optimality criterion of optimal design to be used ('A','C','D','E')
#' @param FeasiblePoints the points whose weights will be optimized, can be in the form of a vector of size N, or as a function for points 1 to N
#' @param A a list of matrices, computed from the Polynomial Order, computed at each Feasible Point
#' @param c a constant vector/matrix used in the c-optimality criterion
#' @param epsilon the smallest value of the feasible point returned.
#' @import CVXR
#' @return returns the CVXR solution to the optimization problem
#' @examples optimalDesigns(N = 21, a = -1, b = 1,PolyOrder = 3, Method = "D")
#' This will return the D-Optimal Design.

optimalDesigns <- function(N,
                           a,
                           b,
                           PolyOrder = 3,
                           Method = "D",
                           FeasiblePoints = NA,
                           A = NA,
                           c = NA,
                           epsilon = 0.0001,
                           ...)
{
  if(!is.numeric(N))
    return('N must be numeric')

  if(!is.numeric(a) || !is.numeric(b) || a > b)
    return('a and b must be numeric values where a is smaller than b')

  if (!as.numeric(PolyOrder) || PolyOrder < 1)
    return('PolyOrder must be numeric, and PolyOrder >= 1')

  if(!is.character(Method) || nchar(Method) != 1)
    return("Please clarify Method to be used (A,C,D,E)")

  if(Method == "C" && nrow(c) != PolyOrder+1)
    return('c must be a numeric vector of size ',PolyOrder+1)

  if(is.na(FeasiblePoints))
    FeasiblePoints <- function(i,a,b)
      a + (b-a) * (i-1) / (N-1)

  if(is.na(A))
    A = model(N,a,b,PolyOrder,FeasiblePoints)

  ans = switch(Method,
               "A" = A_Optimal(N,A),
               "C" = C_Optimal(N,A,c),
               "D" = D_Optimal(N,A),
               "E" = E_Optimal(N,A)
               )
  wstar = ans[[1]]

  index = 1:N
  xi = index[wstar>epsilon]

  if (is.vector(FeasiblePoints))
    support = FeasiblePoints[xi]
  else
    support = FeasiblePoints(xi,a,b)  #support points of the optimal design

  w_opt = wstar[xi] #optimal weights

  cat("The", Method,"-optimal design is:","\n")
  Optimal = data.frame(Index = xi,Support_Points = support, Weigths = w_opt)  #optimal design
  print(round(Optimal,4))

  return(ans) #return not the
}
