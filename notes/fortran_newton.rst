

.. _fortran_newton:

=============================================================
Fortran example for Newton's method
=============================================================

This example shows one way to implement Newton's method for solving an
equation :math:`f(x)=0`, i.e. for a zero or root of the function `f(x)`.

See :ref:`special_newton` for a description of how Newton's method works.

These codes can be found in `$UWHPSC/codes/fortran/newton`.

Here is the module that implements Newton's method in the subroutine
`solve`:


.. literalinclude:: ../codes/fortran/newton/newton.f90
   :language: fortran
   :linenos:

The `solve` routine takes two functions `f` and `fp` as arguments.  These
functions must return the value :math:`f(x)` and :math:`f'(x)` respectively
for any input `x`.  

A sample test code shows how `solve` is called:


.. literalinclude:: ../codes/fortran/newton/test1.f90
   :language: fortran
   :linenos:

This makes use of a module `functions.f90` that includes the definition of
the functions used here.  Since :math:`f(x) = x^2 - 4`, we are attempting to
compute the square root of 4.



.. literalinclude:: ../codes/fortran/newton/functions.f90
   :language: fortran
   :linenos:


This test can be run via::

    $ make test1

which uses the Makefile in the same directory:

.. literalinclude:: ../codes/fortran/newton/Makefile
   :language: make
   :linenos:


