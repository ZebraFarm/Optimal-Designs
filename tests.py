#!/usr/bin/python3.8

import designs as des
import cvxpy as cp 
import numpy as np
import matplotlib.pyplot as plt

def main():

	

	n = 21; p = 2; a = -1; b = 1

	N = [x for x in range(11,212,50)]
	P = [2,3,5,10]

	N=[21];P=[2]

	time_a = np.empty((len(P),len(N)))
	time_d = np.empty((len(P),len(N)))
	time_e = np.empty((len(P),len(N)))

	for i in range(len(P)):
		for j in range(len(N)):

			A = model(N[j],P[i],a,b)

			time_a[i][j] = des.a_optimal(A,n).solver_stats.solve_time
			time_d[i][j] = des.d_optimal(A,n).solver_stats.solve_time
			time_e[i][j] = des.e_optimal(A,n).solver_stats.solve_time



	fig, ax = plt.subplots()
	ax.plot(N,time_a[0])#,N,time_a[1],N,time_a[2],N,time_a[3])
	ax.set_xlim(0,max(N))
	ax.set_ylim(0,max(time_a[0]))
	ax.set_xlabel('Number of Variables')
	ax.set_ylabel('Time (s)')
	ax.legend(loc='best')
	ax.grid(True)

	plt.show()






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