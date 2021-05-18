#' A-optimal Design
#' @description Computes an A-optimal Design
#' @param N the number of feasible points
#' @param A a list of N matrices from the regression model computed from the Polynomial Order, computed at each Feasible Point
#' @return returns the CVXR solution to the optimization problem
#' A_Optimal(N,A)

A_Optimal <- function(N,
                      A)
{
  p=dim(A[[1]])[1]-1
  W = Variable(N)
  obj = Minimize(matrix_frac(diag(p+1),Reduce('+', lapply(1:N, function(x) W[x] * A[[x]]) ) ) )
  const = list(W >= 0, sum(W) == 1)

  # Creating Problem & Solving
  prob = Problem(obj, const)
  ans = solve(prob)
  return(ans)
}

