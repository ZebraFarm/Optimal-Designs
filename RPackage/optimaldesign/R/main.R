library(CVXR)
#source("./")
#source("./A_optimal.R")
#source("./D_optimal.R")
#source("./E_optimal.R")
#source("./c_optimal.R")
#source("./model.R")

#' Optimal Design
#' @description Computes an Optimal Design by minimizing the design with simplex constraints
#' @param N the number of feasible points
#' @param a the lower bound (numeric)
#' @param b the upper bound (numeric, where b > a)
#' @param PolyOrder the order of the design space
#' @param Method the type of optimal design to be used ('A','C','D','E')
#' @param FeasiblePoints the points whose weights will be optimized, can be in the form of a vector of size N, or as a function for points 1 to N
#' @param A a list of the design models, computed from the Polynomial Order, computed at each Feasible Point
#' @param c a scaling parameter to the model
#' @import CVXR
#' @return returns the CVXR solution to the optimization problem
#' @examples optimalDesigns(N = 21, a = -1, b = 1,PolyOrder = 3, Method = "D")[[1]]
#' This will return the 21 interior point optimal weights according to a D-Optimal Design

optimalDesigns <- function(N,
                           a,
                           b,
                           PolyOrder = 3,
                           Method = "D",
                           FeasiblePoints = NA,
                           A = NA,
                           c = NA,
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

  if(Method == "C" && nrow(c) == PolyOrder+1)
    return('c must be a numeric vector')

  if(is.na(FeasiblePoints))
    FeasiblePoints <- function(i,a,b)
      a + (b-a) * (i-1) / (N-1)

  if(is.na(A))
    A = model(N,a,b,PolyOrder,FeasiblePoints)

  switch(Method,
         "A" = A_Optimal(N,A),
         "C" = C_Optimal(N,A,c),
         "D" = D_Optimal(N,A),
         "E" = E_Optimal(N,A)
         )
}
