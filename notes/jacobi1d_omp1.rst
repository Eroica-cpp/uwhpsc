

.. _jacobi1d_omp1:

=============================================================
Jacobi iteration using OpenMP with `parallel do` constructs
=============================================================

The code below implements Jacobi iteration for solving the linear system
arising from the steady state heat equation 
with a simple application of `parallel do` loops using OpenMP.

Compare to:

 * :ref:`jacobi1d_omp2`  

 * :ref:`jacobi1d_mpi`  

The code:


.. literalinclude:: ../codes/openmp/jacobi1d_omp1.f90
   :language: fortran
   :linenos:

