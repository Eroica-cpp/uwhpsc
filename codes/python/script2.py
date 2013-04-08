"""
$UWHPSC/codes/python/script2.py

Sample script to print values of a function at a few points.
The printing is only done if the file is executed as a script, not if it is
imported as a module.
"""
import numpy as np

def f(x):
    """
    A quadratic function.
    """
    y = x**2 + 1.
    return y

def print_table():
    print "     x        f(x)"
    for x in np.linspace(0,4,3):
        print "%8.3f  %8.3f" % (x, f(x))

if __name__ == "__main__":
    print_table()
