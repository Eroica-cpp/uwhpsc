
import pylab
import numpy as np
import sys

# Read in the data files:
# Note: they might not exist, so use try...except:

try:
    x,fx = np.loadtxt('fplotpts.txt', unpack=True)
    xi,fi = np.loadtxt('fquadpts.txt', unpack=True)
    interval_data = np.loadtxt('intervals.txt')
    info_data = np.loadtxt('info.txt')
except:
    # Reach this point if there's a problem reading the txt files
    print "Problem reading *.txt data files"
    sys.exit(0)   # give up and quit!


pylab.figure(1)
pylab.clf()

# Plot the function f using the values from fplotpts.txt:
pylab.plot(x, fx, 'b', linewidth=2)

# plot the Quadrature points as red dots
pylab.plot(xi, fi, 'ro', markersize=4)

# add an informative title:
tol = info_data[0]
gcounter = int(info_data[1])
pylab.title("%g adaptive quadrature points for tol = %8.5f" %(gcounter,tol))

# plot x-axis:
pylab.plot([-2,5],[0,0],'k')
# add ticks at quadrature points:
for x in xi:
    pylab.plot([x,x],[-.05,.05],'k')

pylab.ylim(-1.5,1.5)

# Save plot to a file:
fname = 'plot.png'
pylab.savefig(fname)
print "Created plot of quadrature points in file ",fname

#=======================================

pylab.figure(2)
pylab.clf()

x1 = interval_data[:,0]
x2 = interval_data[:,1]
level = interval_data[:,2]
print "+++ shape = ", interval_data.shape
if interval_data.shape[1] == 4:
    thread_num = interval_data[:,3]
else:
    thread_num = np.zeros(x1.shape)

col = ['b','r','g','m']  # colors for each thread number

for i in range(len(x1)):
    n = int(thread_num[i]) # convert to integer
    #print "+++ ",col[n]
    pylab.plot([x1[i],x2[i]], [-i,-i], color=col[n], linewidth=2)

pylab.title("Subintervals used for each Trapezoid rule")
pylab.axis("off")
pylab.ylim([-len(x1)-1, 1])

# Save plot to a file:
fname = 'intervals.png'
pylab.savefig(fname)
print "Created plot of intervals in file ",fname

