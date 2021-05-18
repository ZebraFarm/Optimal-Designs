#!/usr/bin/python3.8

print("Initializing Libraries ...")

import timeit
import math
import numpy as np
import cvxpy as cp 

def main():
    
    print("What is N ... ", end = '')
    N = int(input())        

    print("\nWhat is a ... ", end = '')
    a = int(input())        

    print("\nWhat is b ... ", end = '')
    b = int(input())        

    print("\nWhat is p ... ", end = '')
    p = int(input())        

    print('\n( N, a, b, p) = (',N,',',a,',',b,',',p,')')

    #Generate A
    A = []
    for i in range(1,N+1):
        u_i = a + (b - a) * (i-1) / (N-1)
        tmp_a =  np.array([[u_i**i for i in range(p+1)]]) # 1 x (p+1)
        tmp_b = np.transpose(tmp_a)          			  # (p+1) x 1
        A_i = np.matmul(tmp_b,tmp_a)

        A.append(A_i)

    # Initializing Variables, Objective, and Constraints
    W = cp.Variable(N)
    obj = cp.Minimize(- cp.log_det( cp.sum( [W[i] * A[i] for i in range(N)]) ) )
    const = [0 <= W, cp.sum(W) == 1]

    # Creating Problem & Solving
    start = timeit.default_timer()

    prob = cp.Problem(obj, const)
    prob.solve()
    
    stop = timeit.default_timer()

    print('Index\tValue')
        eps = 0.0001
        for i in range(N):
            if W.value[i] > eps:
                print(f"{i}\t{W[i].value}")

    print("Sum of W = ",sum(W.value))

    print("\nMethod used: ", prob.solver_stats.solver_name)
    print('Time to Compute: ', stop - start) 

if __name__ == '__main__':
    print("Starting... \n")
    main()
else:
    print("Error has occured ...")

