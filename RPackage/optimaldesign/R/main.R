library(CVXR)
source("./")

optimalDesigns <- function(N,
                           a,
                           b,
                           FeasablePoints = function(x) a,
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
  if (!as.numeric(p) ||  p < 1)
    return('p must be numeric, and p >= 1')
  if(!is.character(Method) || nchar(Method) != 1)
    return("Please clarify Method to be used \(\"A\",\"C\",\"D\",\"E\"\)")
  if(Method == "C")

  if(is.na(A))
    A = model(N,a,b,p,u)

  switch(Method,
         "A" = A-Optimal(N,A),
         "C" = C-Optimal(N,A),
         "D" = D-Optimal(N,A),
         "E" = E-Optimal(N,A),
         )
}


InformationMatrix <- function()
  return(D(w))

A-Optimal <- function(N,
                      A)
{


}
