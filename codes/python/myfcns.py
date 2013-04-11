
"""
Module containing some test functions.
"""

def f1(x):
    """
    A simple quadratic function.
    """
    y = x**2 - 3.*x + 5.
    return y

def f2(x):
    """
    An exponential function.
    """
    from numpy import exp
    y = exp(4.*x)
    return y
