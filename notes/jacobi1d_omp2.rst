

.. _jacobi1d_omp2:

================================================================
Jacobi iteration using OpenMP with coarse-grain `parallel` block
================================================================

The code below implements Jacobi iteration for solving the linear system
arising from the steady state heat equation 
with a single `parallel` block.  Work is split up manually between threads.

Compare to:

 * :ref:`jacobi1d_omp1`  

 * :ref:`jacobi1d_mpi`  

The code:

.. literalinclude:: ../codes/openmp/jacobi1d_omp2.f90
   :language: fortran
   :linenos:

