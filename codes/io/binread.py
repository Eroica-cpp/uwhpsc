# $UWHPSC/codes/io/binread.py

"""
Illustrate reading in binary data that was written by binwrite.f90.
"""

import numpy as np

file = open('u.bin', 'rb')
uvec = np.fromfile(file, dtype=np.float64)

m,n = np.loadtxt('mn.txt',dtype=int)

# now use Fortran ordering to fill u by columns:
u = uvec.reshape((m,n),order='F')

print "u has shape ",u.shape
