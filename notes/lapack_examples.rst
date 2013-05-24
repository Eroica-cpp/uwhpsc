

.. _lapack_examples:

=============================================================
LAPACK examples
=============================================================

Some examples using the LAPACK routine 
`dgesv <http://www.netlib.org/lapack/double/dgesv.f>`_ for solving a linear
system are in `$UWHPSC/codes/lapack`.


See :ref:`linalg` for more about LAPACK and other software.

Here is the first example with static array allocation as in Fortran 77:
Note that the `lda` parameter is used to indicate the size of the array that
was declared, even though `n` may be smaller.

.. literalinclude:: ../codes/lapack/random/randomsys1.f90
   :language: fortran
   :linenos:

Here is the code rewritten to use dynamic memory allocation:

.. literalinclude:: ../codes/lapack/random/randomsys2.f90
   :language: fortran
   :linenos:

The next version also estimates the condition number of the matrix using 
the LAPACK routine 
`dgecon <http://www.netlib.org/lapack/double/dgecon.f>`_: 

.. literalinclude:: ../codes/lapack/random/randomsys3.f90
   :language: fortran
   :linenos:
