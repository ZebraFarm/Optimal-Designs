#!/usr/bin/python3.8

import sys
import timeit
import designs as des
import cvxpy as cp 
import numpy as np
import matplotlib.pyplot as plt

def main():

	#a, b = sys.argv[1:2]
	a = -1;b = 1
	n = 21
	p = 2

	N = [x for x in range(11,1002,100)]
	for i in range(2001,20002,1000):
		N.append(i)
	print(N)
	P = [2,3,5,10]

	time_a = [[] for i in range(len(P))]
	time_d = [[] for i in range(len(P))]
	time_e = [[] for i in range(len(P))]

	for n in N:
		print(n)
		for i in range(len(P)):
			
			A = model(n,P[i],a,b)

			start = timeit.default_timer()
			des.a_optimal(A,n)
			stop = timeit.default_timer()
			time_a[i].append(stop - start)

			start = timeit.default_timer()
			des.d_optimal(A,n)
			stop = timeit.default_timer()
			time_d[i].append(stop - start)

			start = timeit.default_timer()
			des.e_optimal(A,n)
			stop = timeit.default_timer()
			time_e[i].append(stop - start)

	#Header
	print('A-Optimal')
	print('N', end = '\t')
	for p in P:
		print(p, end = '\t')
	print()	

	#Outputs
	for i in range(len(N)):
		print(N[i], end = '\t')
		for j in range(len(P)):
			print(time_a[j][i], end = '\t')
		print()

	#Header
	print('D-Optimal')
	print('N', end = '\t')
	for p in P:
		print(p, end = '\t')
	print()	

	#Outputs
	for i in range(len(N)):
		print(N[i], end = '\t')
		for j in range(len(P)):
			print(time_d[j][i], end = '\t')
		print()

	#Header
	print('E-Optimal')
	print('N', end = '\t')
	for p in P:
		print(p, end = '\t')
	print()	

	#Outputs
	for i in range(len(N)):
		print(N[i], end = '\t')
		for j in range(len(P)):
			print(time_e[j][i], end = '\t')
		print()

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