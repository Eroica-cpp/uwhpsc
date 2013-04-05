
.. _numerical_python:

=============================================================
Numerics in Python
=============================================================


Python is a general programming language and is used for many purposes that have
nothing to do with scientific computing or numerical methods.  However,
there are a number of modules that can be imported that provide a variety of
numerical methods and other tools that are very useful for scientific
computing.

The basic module needed for most numerical work is *NumPy*, which provides in
particular the data structures needed for working with 
arrays of real numbers representing vectors or matrices.  The module *SciPy*
provides additional numerical methods and tools.

If you know Matlab, you will find that many of the things you are used to
doing in that language can be done using *NumPy* and *SciPy*, although the
syntax is often a bit different.  Matlab users will find web page
[NumPy-for-Matlab-Users]_ crucial for understanding the differences and
transitioning to Python, and this page is useful for all new users.  A
tutorial can be found at [NumPy-tutorial]_.

Vectors and Matrices
--------------------

Python has lists as a built-in data type, e.g.::

        >>> x = [1., 2., 3.]

defines a list that contains 3 real numbers and might be viewed as a vector.
However, you cannot easily do arithmetic on such lists the way you can with
vectors in Matlab, e.g.  2*x does not give [2., 4., 6.] as you might hope::

        >>> 2*x
        [1.0, 2.0, 3.0, 1.0, 2.0, 3.0]

instead it doubles the length of *x*, and *x+x* would give the same thing.
You also cannot apply *sqrt* to a list to get a new list containing the
square root of each element, for example.

Two-dimensional arrays are also a bit clumsy in Python, as they have to be
specified as a list of lists, e.g. a 3x2 array with the elements 11,12 in
the first row, 21,22 in the second row, 31,32 in the third row would be
specified by::

        >>> A = [[11, 12], [21, 22], [31, 32]]

Note that indexing always starts with 0 in Python, so we find for example
that::

        >>> A[0]
        [11, 12]

        >>> A[1]
        [21, 22]

        >>> A[1][0]
        21

Here A[0] refers to the 0-index element of A, which is itself a list [11, 12].
and A[1][0] can be understood as the 0-index element of A[1] = [21, 22].

You cannot work with A as a matrix, for example to multiply it by a vector,
except by writing code that loops over the elements explicitly.

NumPy was developed to make it easy to do the sorts of things we want to do
with matrices and vectors, and more generally n-dimensional arrays of real
numbers.

For example::

        >>> import numpy as np
        >>> x = np.array([1., 2., 3.])
        >>> x
        array([ 1.,  2.,  3.])

        >>> 2*x
        array([ 2.,  4.,  6.])

        >>> np.sqrt(x)
        array([ 1.        ,  1.41421356,  1.73205081])

We see that we can multiply by a scalar or take component-wise square roots.

You may find it ugly to have to start numpy command with np., as necessary
here since we imported numpy as np. Instead you could do::

        >>> from numpy import *

and then just use *sqrt*, for example, and you will get the NumPy version.
But in these notes and many Python examples you'll see, the module is
explicitly listed so it is clear where a function is coming from.

For matrices, we can convert our list of lists into a *NumPy* array as
follows (we specify *dtype=float* to make sure the elements of A are stored
as floating point real number even though we type them here as integers)::

        >>> A = np.array([[11, 12], [21, 22], [31, 32]], dtype=float)
        >>> A
        array([[ 11.,  12.],
               [ 21.,  22.],
               [ 31.,  32.]])

        >>> A[0,1]
        12.

Note that we can now index into the array as in matrix notation A[0,1]
(remembering that indexing starts at 0 in Python), so this the [0,1]
element of A means the first row and second column.

We can also do slicing operations, extracting a single row or column::

        >>> A[0,:]      
        array([11., 12.])
        >>> A[:,0]
        array([11., 21., 31.])

Since A is a NumPy array object, there are certain methods automatically
defined on A, such as the transpose:

        >>> A.T
        array([[11., 21., 31.],
               [12., 22., 32.]])

Seeing all the methods defined for A is easy if you use the IPython shell
(see :ref:`ipython`), just type A. followed by the tab key (you will find
there are 155 methods defined).


We can do matrix-vector or matrix-matrix multiplication using the NumPy dot
function::

        >>> np.dot(A.T, x)
        array([ 146.,  152.])

        >>> np.dot(A.T, A)
        array([[1523., 1586.],
               [1586., 1652.]])

This looks somewhat less mathematical than Matlab notation A'*A, but the syntax
and data structures of Matlab were designed specifically for linear algebra,
whereas Python is a more general language and so doing linear algebra has to
be done in this framework.

Note that elements of a *NumPy* array are always all of the same type, and
generally we want *floats*, though integer arrays can also be defined.  
This is different than Python lists, which can contain elements with
different types, e.g.::

        >>> L = [2, 3., 'xyz', [4,5]]

        >>> print type(L[0]), type(L[1]), type(L[2]), type(L[3])
        <type 'int'> <type 'float'> <type 'str'> <type 'list'>



Component-wise operations
-------------------------

One thing to watch out for if you are used to Matlab notation:  In Matlab
some operations (such as sqrt, sin, cos, exp, etc) can be applied to vectors
or matrices and will automatically be applied component-wise.  Other
operations like * and / (multiplication and division) attempt to do things
in terms of linear algebra, and so in Matlab, A*B gives the matrix product
and only makes sense if the number of columns of A agrees with the number of
rows of B.  If you want a component-wise product of A and B you must use .*
instead, with a period before the *.

In NumPy,  * and / are applied component-wise, like any other operation.  To
get a matrix-product you must use *dot*::


        >>> A = np.array([[1,2], [3,4]])
        >>> B = np.array([[5,0], [0,7]])
        >>> A
        array([[1, 2],
               [3, 4]])
        >>> B
        array([[5, 0],
               [0, 7]])

        >>> A*B
        array([[ 5,  0],
               [ 0, 28]])

        >>> np.dot(A,B)
        array([[ 5, 14],
               [15, 28]])

Many other linear algebra tools can be found in *NumPy*.  For example, to
solve a linear system Ax = b using Gaussian Elimination, we can do::

        >>> A
        array([[1, 2],
               [3, 4]])

        >>> b = np.array([2,3])
        >>> x = np.linalg.solve(A,b)

        >>> x
        array([-1. ,  1.5])

To find the eigenvalues and eigenvectors of A::

        >>> evals, evecs = np.linalg.eig(A)

        >>> evals
        array([-0.37228132,  5.37228132])

        >>> evecs
        array([[-0.82456484, -0.41597356],
               [ 0.56576746, -0.90937671]])

Note: You may be tempted to use the variable name *lambda* for the eigenvalues
of a matrix, but this isn't allowed in Python because *lambda* is a keyword
of the language, see :ref:`lambda_functions`.


Further reading
---------------

Be sure to visit

 * `<http://www.scipy.org/Tentative_NumPy_Tutorial>`_

 * `<http://www.scipy.org/NumPy_for_Matlab_Users>`_

See also [NumPy-pros-cons]_ for more about differences with other
mathematical languages.

