#Not working at this time, troubles with "log_det"

library(CVXR)

N = 21
a = -1
b = 1
p = 2

A = list(N)
for (i in 1:N){
  u_i = a + (b-a) * (i-1) / (N-1)
  tmp =  0:p
  tmp = u_i^tmp
  
  A_i = tmp %*% t(tmp)
  
  A[[i]] = A_i
}

# Initializing Variables, Objective, and Constraints
W = Variable(N)
obj = Minimize(- log_det(Reduce('+', lapply(1:N, function(x) W[x] * A[[x]]) ) ) )
const = list(W >= 0, sum(W) == 1)

# Creating Problem & Solving
prob = Problem(obj, const)
ans = solve(prob)
ans
