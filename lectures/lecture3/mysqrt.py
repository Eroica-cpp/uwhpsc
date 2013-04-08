"""
Module for approximating sqrt.
More ...
"""

def sqrt2(x):
    """
    more details.
    """
    s = 1.
    kmax = 100
    tol = 1.e-14
    for k in range(kmax):
        print "Before iteration %s, s = %20.15f" % (k,s)
        s0 = s
        s = 0.5 * (s + x/s)
        delta_s = s - s0
        if abs(delta_s / x) < tol:
            break
    print "After %s iterations, s = %20.15f" % (k+1,s)  

  