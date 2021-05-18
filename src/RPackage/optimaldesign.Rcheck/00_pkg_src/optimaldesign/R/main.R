library(CVXR)
#source("./")
#source("./A_optimal.R")
#source("./D_optimal.R")
#source("./E_optimal.R")
#source("./c_optimal.R")
#source("./model.R")

#' Computes an A-optimal Design
#' @param N the number of feasible points
#' @param a the lower bound
#' @param b the upper bound
#' @param PolyOrder the order of the design space
#' @param Method the type of optimal design to be used
#' @param FeasablePoints the points whose weights will be optimized
#' @param A the design model
#' @param c a scaling parameter to the model
#' @import CVXR
#' @return returns the CVXR solution to the optimization problem
#' @export
#' @examples
#' optimalDesigns(N,a,b,PolyOrder,Method, FeasablePoints,A,c)

optimalDesigns <- function(N,
                           a,
                           b,
                           PolyOrder = 3,
                           Method = "D",
                           FeasablePoints = NA,
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

  if(is.na(FeasablePoints))
    FeasablePoints <- function(i,a,b)
      a + (b-a) * (i-1) / (N-1)

  if(is.na(A))
    A = model(N,a,b,PolyOrder,FeasablePoints)

  switch(Method,
         "A" = A_Optimal(N,A),
         "C" = C_Optimal(N,A,c),
         "D" = D_Optimal(N,A),
         "E" = E_Optimal(N,A)
         )
}
