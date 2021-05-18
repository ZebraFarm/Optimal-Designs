#' Computes an D-optimal Design
#' @param
#' @import
#' @return
#' @export
#' @examples
#' D_Optimal(N,A)

D_Optimal <- function(N,
                      A)
{
  W = Variable(N)
  obj = Minimize(- log_det(Reduce('+', lapply(1:N, function(x) W[x] * A[[x]]) ) ) )
  const = list(W >= 0, sum(W) == 1)

  # Creating Problem & Solving
  prob = Problem(obj, const)
  ans = solve(prob)
  return(ans)
}
