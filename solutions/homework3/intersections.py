"""
Script to solve the intersections problem.
"""

from newton import solve
from numpy import linspace, pi, cos, sin, abs, where
import matplotlib.pyplot as plt

def g1vals(x):
    g1 =  x*cos(pi*x)
    g1p =  cos(pi*x) - x*pi*sin(pi*x)
    return g1, g1p

def g2vals(x):
    g2 = 1. - 0.6*x**2
    g2p = -1.2*x
    return g2, g2p


def fvals(x):
    g1,g1p = g1vals(x)
    g2,g2p = g2vals(x)
    f = g1 - g2
    fp = g1p - g2p
    return f, fp

xx = linspace(-10,10,1000)
g1xx, g1pxx = g1vals(xx)
g2xx, g2pxx = g2vals(xx)

plt.figure(1)
plt.clf()
plt.plot(xx, g1xx, 'b')
plt.plot(xx, g2xx, 'r')
plt.legend(['g1','g2'])

plt.figure(2)
plt.clf()
fxx, fpxx = fvals(xx)
plt.plot(xx, fxx, 'b')
plt.plot(xx, 0*xx, 'k')  # x-axis
plt.title("plot of f(x) = g2(x) - g1(x)")

plt.figure(1)
for x0 in [-2.2, -1.6, -0.8, 1.45]:

    x,iters = solve(fvals, x0)
    print "\nWith initial guess x0 = %22.15e," % x0
    print "      solve returns x = %22.15e after %i iterations " % (x,iters)
    g1x,g1px = g1vals(x)
    fx,fpx = fvals(x)
    print "    f(x) = %22.15e" % fx
    plt.plot(x,g1x,'ko')

plt.axis((-5,5,-4,4))
plt.savefig('intersections.png')
