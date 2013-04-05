"""
$UWHPSC/codes/python/script1.py

Sample script to print values of a function at a few points.
"""
import numpy as np

def f(x):
    """
    A quadratic function.
    """
    y = x**2 + 1.
    return y

print "     x        f(x)"
for x in np.linspace(0,4,3):
    print "%8.3f  %8.3f" % (x, f(x))

