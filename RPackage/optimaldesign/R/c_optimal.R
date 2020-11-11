#' c-optimal Design
#' @description Computes an c-optimal Design using simplex constraints
#' @param N the number of feasible points
#' @param A a list of the design models, computed from the Polynomial Order, computed at each Feasible Point
#' @param c the scaling value, can be a vector or matrix
#' @return returns the CVXR solution to the optimization problem
#' C_Optimal(N,A,c)

C_Optimal <- function(N,
                      A,
                      c)
{
  W = Variable(N)
  obj = Minimize(matrix_frac( c ,Reduce('+', lapply(1:N, function(x) W[x] * A[[x]]) ) ) )
  const = list(W >= 0, sum(W) == 1)

  # Creating Problem & Solving
  prob = Problem(obj, const)
  ans = solve(prob)
  return(ans)
}
