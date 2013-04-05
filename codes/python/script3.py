"""
$UWHPSC/codes/python/script3.py

Modification of script2.py that allows a command line argument telling how
many points to plot in the table.

Usage example: To print table with 5 values:
   python script3 5

"""
import numpy as np

def f(x):
    """
    A quadratic function.
    """
    y = x**2 + 1.
    return y

def print_table(n=3):
    print "     x        f(x)"
    for x in np.linspace(0,4,n):
        print "%8.3f  %8.3f" % (x, f(x))

if __name__ == "__main__":
    """
    What to do if the script is executed at command line.
    Note that sys.argv is a list of the tokens typed at the command line.
    """
    import sys
    print "sys.argv is ",sys.argv
    if len(sys.argv) > 1:
        try:
            n = int(sys.argv[1])
            print_table(n)
        except:
            print "*** Error: expect an integer n as the argument"
    else:
        print_table()
