#!/usr/bin/python3.8

import sys
import cvxpy as cp 
import designs as des
import numpy as np

def main():

	#a, b = sys.argv[1:2]
	#(-1,1),(-2,2),(0,1)(0,5)
	a = -1;b = 1
	print('a:',a," b:",b)
	N = 1001
	p = 3

	#Header
	print('C-Optimal')


	A = model(N,p,a,b)
	c1 = np.array([[1],[1],[1],[1]])
	c2 = np.array([[1],[-1],[1],[-1]])
	#c3 = np.array([[0],[1],[0],[-1]])

	results = des.c_optimal_multi(A, N, [c1, c2])
	print(results.value)

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