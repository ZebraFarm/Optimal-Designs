library(CVXR)
#source("./designs.R")

optimalDesigns <- function(N,
                           a,
                           b,
                           FeasablePoints = NA,
                           PolyOrder = 3,
                           A = NA,
                           c = NA,
                           Method = "D",
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
         "A" = A-Optimal(N,A),
         "C" = C-Optimal(N,A,c),
         "D" = D-Optimal(N,A),
         "E" = E-Optimal(N,A),
         )
}
