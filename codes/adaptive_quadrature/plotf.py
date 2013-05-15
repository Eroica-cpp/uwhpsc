"""
Plots the function for making a slide.
"""

from pylab import *

x = linspace(-2.5,4.5,1000)
beta = 10.
y = exp(-beta**2 * x**2) + sin(x)

plot(x,y,linewidth=2,color='b')
plot([-3,5],[0,0],'k')
ylim(-1.5, 1.5)

savefig('f.png')
