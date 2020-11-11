#' Computes an A-optimal Design
#' @param N the number of feasible points
#' @param A the design model
#' @import CVXR
#' @return returns the CVXR solution to the optimization problem
#' A_Optimal(N,A)

A_Optimal <- function(N,
A)
{
  W = Variable(N)
  obj = Minimize(matrix_frac(diag(p+1),Reduce('+', lapply(1:N, function(x) W[x] * A[[x]]) ) ) )
  const = list(W >= 0, sum(W) == 1)

  # Creating Problem & Solving
  prob = Problem(obj, const)
  ans = solve(prob)
  return(ans)
}

