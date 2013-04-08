"""
Module for approximating sqrt.
More ...
"""

def sqrt2(x, debug=False):
    """
    more details.
    """
    from numpy import nan
    
    if x==0.:
        return 0.
    elif x<0:
        print "*** Error, x must be nonnegative"
        return nan
    assert x>0. and type(x) is float, "Unrecognized input"
        
    s = 1.
    kmax = 100
    tol = 1.e-14
    for k in range(kmax):
        if debug:
            print "Before iteration %s, s = %20.15f" % (k,s)
        s0 = s
        s = 0.5 * (s + x/s)
        delta_s = s - s0
        if abs(delta_s / x) < tol:
            break
    if debug:
        print "After %s iterations, s = %20.15f" % (k+1,s) 
    return s 

  