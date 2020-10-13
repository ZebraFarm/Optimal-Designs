import numpy as np
import cvxpy as cp 


def a_optimal(A,N):

    # Initializing Variables, Objective, and Constraints
	p = A[1].shape[0] - 1
	W = cp.Variable(N)
	obj = cp.Minimize( cp.matrix_frac( np.identity(p+1), cp.sum( [W[i] * A[i] for i in range(N)]) ) )
	const = [0 <= W, cp.sum(W) == 1]

    # Creating Problem & Solving
	prob = cp.Problem(obj, const)
	prob.solve()

	return prob

def c_optimal(A,N,c):

    # Initializing Variables, Objective, and Constraints
    p = A[1].shape[0] - 1
    W = cp.Variable(N)
    obj = cp.Minimize( cp.matrix_frac( c , sum( [W[i] * A[i] for i in range(N)]) ) )
    const = [0 <= W, cp.sum(W) == 1]

    # Creating Problem & Solving
    prob = cp.Problem(obj, const)
    prob.solve()

    return prob

# C is a list of numpy vectors
def c_optimal_multi(A,N,C):

    # Initializing Variables, Objective, and Constraints
    p = A[1].shape[0] - 1
    W = cp.Variable(N)
    obj = cp.Minimize( cp.sum([cp.matrix_frac( c , sum( [W[i] * A[i] for i in range(N)]) ) for c in C ] ) )
    const = [0 <= W, cp.sum(W) == 1]

    # Creating Problem & Solving
    prob = cp.Problem(obj, const)
    prob.solve()

    return prob

def d_optimal(A,N):


    # Initializing Variables, Objective, and Constraints
	W = cp.Variable(N)
	obj = cp.Minimize(- cp.log_det( cp.sum( [W[i] * A[i] for i in range(N)]) ) )
	const = [0 <= W, cp.sum(W) == 1]

    # Creating Problem & Solving
	prob = cp.Problem(obj, const)
	prob.solve()

	return prob

def e_optimal(A,N):

    # Initializing Variables, Objective, and Constraints
	W = cp.Variable(N)
	obj = cp.Maximize( cp.lambda_min( cp.sum( [W[i] * A[i] for i in range(N)]) ) )
	const = [0 <= W, cp.sum(W) == 1]

    # Creating Problem & Solving
	prob = cp.Problem(obj, const)
	prob.solve()

	return prob