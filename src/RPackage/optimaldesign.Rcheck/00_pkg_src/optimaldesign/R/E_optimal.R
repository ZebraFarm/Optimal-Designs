#' Computes an E-optimal Design
#' @param
#' @import
#' @return
#' @export
#' @examples
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
