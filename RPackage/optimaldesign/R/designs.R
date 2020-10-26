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
