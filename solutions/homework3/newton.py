
import numpy as np

def solve(fvals, x0, debug=False):
    tol = 1e-14
    maxiter = 20 
    x = x0
    if debug:
        print "Initial guess: x = %22.15e" % x0
    for k in range(maxiter):
        f,fp = fvals(x)
        if abs(f) < tol:
            break
        delta_x = f / fp
        x = x - delta_x
        if debug:
            print "After %s iterations, x = %22.15e" % (k+1,x)

    if k==maxiter-1:
        f,fp = fvals(x)
        if abs(f) > tol:
            print "*** warning: has not yet converged"
        return x, k+1
    else:
        return x, k

def fvals_sqrt(x):
    """
    Return f(x) and f'(x) for applying Newton to find a square root.
    """
    f = x**2 - 4.
    fp = 2.*x
    return f, fp

def test1(debug_solve=False):
    """
    Test Newton iteration for the square root with different initial
    conditions.
    """
    from numpy import sqrt
    for x0 in [1., 2., 100.]:
        print " "  # blank line
        x,iters = solve(fvals_sqrt, x0, debug=debug_solve)
        print "solve returns x = %22.15e after %i iterations " % (x,iters)
        fx,fpx = fvals_sqrt(x)
        print "the value of f(x) is %22.15e" % fx
        assert abs(x-2.) < 1e-14, "*** Unexpected result: x = %22.15e"  % x

