#' Computes an c-optimal Design
#' @param
#' @import
#' @return
#' @export
#' @examples
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
