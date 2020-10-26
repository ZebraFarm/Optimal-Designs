InformationMatrix <- function()
  return(D(w))

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
