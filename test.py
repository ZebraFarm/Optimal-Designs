#!/usr/bin/python3.8

import sys
import cvxpy as cp 
import numpy as np

def main():

	#a, b = sys.argv[1:2]
	#(-1,1),(-2,2),(0,1)(0,5)
	a = -1;b = 1
	print('a:',a," b:",b)
	N = [x for x in range(11,1002,200)]
	for i in range(1001,21002,2000):
		N.append(i)
	N.append(100000)
	print(N)
	p = 3
	eps = 0.01

	#Header
	print('A-Optimal')
	print('N\tU_i\tValue')

	for n in N:
		A = model(n,p,a,b)

		W = cp.Variable(n)
		obj = cp.Minimize( cp.matrix_frac( np.identity(p+1), cp.sum( [W[i] * A[i] for i in range(n)]) ) )
		const = [0 <= W, cp.sum(W) == 1]

	    # Creating Problem & Solving
		prob = cp.Problem(obj, const)
		prob.solve()
		
		#Output
		for i in range(n):
			if W.value[i] > eps:
				print(f"{n}\t{a + (b - a) * ((i+1)-1) / (n-1)}\t{W[i].value}")


def model(N,p,a,b):
	A = []
	for i in range(1,N+1):
		u_i = a + (b - a) * (i-1) / (N-1)
		tmp_a =  np.array([[u_i**i for i in range(p+1)]]) # 1 x (p+1)
		tmp_b = np.transpose(tmp_a)          			  # (p+1) x 1
		A_i = np.matmul(tmp_b,tmp_a)
		
		A.append(A_i)

	return A

main()