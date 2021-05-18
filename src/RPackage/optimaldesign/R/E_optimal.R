#' E-optimal Design
#' @description Computes an E-optimal Design
#' @param N the number of feasible points
#' @param A a list of N matrices from the regression model computed from the Polynomial Order, computed at each Feasible Point
#' @return returns the CVXR solution to the optimization problem
#' E_Optimal(N,A)

E_Optimal <- function(N,
                      A)
{
  W = Variable(N)
  obj = Maximize( lambda_min( Reduce('+', lapply(1:N, function(x) W[x] * A[[x]]) ) ) )
  const = list(W >= 0, sum(W) == 1)

  # Creating Problem & Solving
  prob = Problem(obj, const)
  ans = solve(prob)
  return(ans)
}
