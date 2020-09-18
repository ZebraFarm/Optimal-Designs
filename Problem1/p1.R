#Not working at this time, troubles with "log_det"

library(CVXR)

N = 21

A = list(N)
for (i in 1:N){
  u_i = -1 + 2 * (i-1) / (N-1)
  tmp =  c(1, u_i, u_i^2)
  A_i = tmp %*% t(tmp)
  
  A[[i]] = A_i
}

fun <- function(W,A){
  N = length(W)
  p = nrow(A[[1]])
  
  scaled = lapply(1:N, function(x) W[x] * A[[x]])
  
  sum = matrix(0,nrow = p, ncol = p)
  for(i in 1:N) 
    sum = sum + scaled[[i]]
  
  #d_sum = det(sum)
  #ans = log(d_sum)
  return(ans)
}

# Initializing Variables, Objective, and Constraints
W = Variable(N)
obj = Minimize(- log_det(fun(W, A)) )
const = list(W >= 0, sum(W) == 1)

# Creating Problem & Solving
prob = Problem(obj, const)
ans = solve(prob)
ans