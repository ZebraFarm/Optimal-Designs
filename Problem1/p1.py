#!/usr/bin/python3.8

print("Initializing Libraries ...")

import timeit
import math
import numpy as np
import cvxpy as cp 

def main():
    
    #print("What is N ... ")
    #N = int(input())        

	N = []
	for i in range(11,100,10):
		N.append(i)

	for i in range(101,1000,100):
		N.append(i)

	for i in range(1001,20002,1000):
		N.append(i)

	print(N)

	for n in N:
		    #Generate A
		A = []
		for i in range(1,n+1):
		    u_i = -1 + 2 * (i-1) / (n-1)
		    tmp_a =  np.array([[1, u_i, u_i**2]]) # 1 x 3
		    tmp_b = np.transpose(tmp_a)           # 3 x 1
		    A_i = np.matmul(tmp_b,tmp_a)

		    A.append(A_i)

		time = [0,0]
		for l in range(2):
		    # Initializing Variables, Objective, and Constraints
		    W = cp.Variable(n)
		    obj = cp.Minimize(- cp.log_det( cp.sum( [W[i] * A[i] for i in range(n)]) ) )
		    const = [0 <= W, cp.sum(W) == 1]

		    # Creating Problem & Solving
		    start = timeit.default_timer()

		    prob = cp.Problem(obj, const)
		    prob.solve()
		    
		    stop = timeit.default_timer()

		    time[l] = stop - start

		print(time[0]/2 + time[1]/2, ',')



'''
    eps = 0.0001
    for w in W:
    	if w.value > eps:
    		print(w.key, w.value)

    print("\nW = ", W.value)
    print("Sum of W = ",sum(W.value))
    print("Method used: ", prob.solver_stats.solver_name)
    print('Time to Compute: ', stop - start) 
'''

if __name__ == '__main__':
    print("Starting... \n")
    main()
else:
    print("Error has occured ...")

