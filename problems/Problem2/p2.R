library(CVXR)

N = 21
a = -1
b = 1
p = 2
P = 0:p

u_i <- function(i,a,b)
  a + (b-a) * (i-1) / (N-1)

A = list(N)
A = lapply(1:N, function(i) A[[i]] = u_i(i,a,b)^P %*% t(u_i(i,a,b)^P))

# Initializing Variables, Objective, and Constraints
W = Variable(N)
obj = Minimize(- log_det(Reduce('+', lapply(1:N, function(x) W[x] * A[[x]]) ) ) )
const = list(W >= 0, sum(W) == 1)

# Creating Problem & Solving
prob = Problem(obj, const)
ans = solve(prob)
ans
