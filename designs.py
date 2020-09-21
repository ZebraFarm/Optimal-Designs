import numpy as np
import cvxpy as cp 

def main():

	N = 21; p = 2; a = -1; b = 1

	A = model(N,p,a,b)
	print("A-optimal: ", a_optimal(A,N)[0].value)
	print("E-optimal: ", e_optimal(A,N)[0].value)
	print("D-optimal: ", d_optimal(A,N)[0].value)

def model(N,p,a,b):
	A = []
	for i in range(1,N+1):
		u_i = a + (b - a) * (i-1) / (N-1)
		tmp_a =  np.array([[u_i**i for i in range(p+1)]]) # 1 x (p+1)
		tmp_b = np.transpose(tmp_a)          			  # (p+1) x 1
		A_i = np.matmul(tmp_b,tmp_a)
		
		A.append(A_i)

	return A

def a_optimal(A,N):

    # Initializing Variables, Objective, and Constraints
	p = A[1].shape[0] - 1
	W = cp.Variable(N)
	obj = cp.Minimize( cp.matrix_frac( np.identity(p+1), cp.sum( [W[i] * A[i] for i in range(N)]) ) )
	const = [0 <= W, cp.sum(W) == 1]

    # Creating Problem & Solving
	prob = cp.Problem(obj, const)
	prob.solve()

	return(W, prob)

def d_optimal(A,N):


    # Initializing Variables, Objective, and Constraints
	W = cp.Variable(N)
	obj = cp.Minimize(- cp.log_det( cp.sum( [W[i] * A[i] for i in range(N)]) ) )
	const = [0 <= W, cp.sum(W) == 1]

    # Creating Problem & Solving
	prob = cp.Problem(obj, const)
	prob.solve()

	return(W, prob)

def e_optimal(A,N):

    # Initializing Variables, Objective, and Constraints
	W = cp.Variable(N)
	obj = cp.Maximize( cp.lambda_min( cp.sum( [W[i] * A[i] for i in range(N)]) ) )
	const = [0 <= W, cp.sum(W) == 1]

    # Creating Problem & Solving
	prob = cp.Problem(obj, const)
	prob.solve()

	return(W, prob)


main()