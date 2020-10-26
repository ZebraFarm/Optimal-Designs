#Not working at this time, troubles with "log_det"

library(CVXR)

N = 101
a = -1
b = 1
p = 3
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


##########################################
(wstar=ans[[1]])  #optimal weights  
index=c(1:N)
xi=c(index[wstar>0.0001])
support=u_i(xi,a,b)
w_opt=wstar[xi]
cat("The order of the polynomial is p=", p , "\n")
cat("The design space, (a,b)=", a, b, "\n")
cat("The number of points in S, N=", N, "\n")

cat("D-optimal design is:","\n")
cbind(support,w_opt)       #D-optimal design

cat("The objective function value is:",ans$value,"\n")  #???
cat("The computation time is:",ans$solve_time,"\n")  #???

##########################################






