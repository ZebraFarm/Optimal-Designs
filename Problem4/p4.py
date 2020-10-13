#!/usr/bin/python3.8

print("Initializing Libraries ...")

import timeit
import math
import numpy as np
import cvxpy as cp 

def main():
    
    print("What is N ... ", end = '')
    N = 1001#int(input())        

    print("\nWhat is a ... ", end = '')
    a = -1#int(input())        

    print("\nWhat is b ... ", end = '')
    b = 1#int(input())        

    print("\nWhat is p ... ", end = '')
    p = 3#int(input())        

    print('\n( N, a, b, p) = (',N,',',a,',',b,',',p,')')

    c_1 = np.array([[1],[1],[1],[1]])
    c_2 = np.array([[1],[-1],[1],[-1]])

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
    obj = cp.Minimize( cp.matrix_frac( c_1 , sum( [W[i] * A[i] for i in range(N)]) ) + cp.matrix_frac( c_2 , sum( [W[i] * A[i] for i in range(N)]) ) )
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
            print(f"{a + (b - a) * ((i+1)-1) / (N-1)}\t{W[i].value}")

    print("Sum of W = ",sum(W.value))

    print("\nMethod used: ", prob.solver_stats.solver_name)
    print('Time to Compute: ', stop - start) 

if __name__ == '__main__':
    print("Starting... \n")
    main()
else:
    print("Error has occured ...")

