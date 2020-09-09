#!/usr/bin/python3.6

print("Initializing Libraries ...")

import timeit
import math
import numpy as np
import cvxpy as cp 

# Turns out this function is not usable for CVXPY
def fun(A, W):

    sol = np.zeros((3,3))
    for i in range(len(A)):
        sol += W[i] * A[i]

    return sol

# Turns out this function is not usable for CVXPY
def objective(A, W, fun):

    Dw = fun(A, W) 
    det_Dw = np.linalg.det(Dw)
    log_det_Dw = math.log(det_Dw)

    return -1 * log_det_Dw



def main():
    
    print("What is N ... ")
    N = int(input())        


    #Generate A
    A = []
    for i in range(1,N+1):
        u_i = -1 + 2 * (i-1) / (N-1)
        tmp_a =  np.array([[1, u_i, u_i**2]]) # 1 x 3
        tmp_b = np.transpose(tmp_a)           # 3 x 1
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

    #print("\nW = ", W.value)
    #print("Sum of W = ",sum(W.value))

    print("Method used: ", prob.solver_stats.solver_name)
    print('Time to Compute: ', stop - start) 

if __name__ == '__main__':
    print("Starting... \n")
    main()
else:
    print("Error has occured ...")

