

.. _jacobi1d_mpi:

================================================================
Jacobi iteration using MPI 
================================================================

The code below implements Jacobi iteration for solving the linear system
arising from the steady state heat equation 
using MPI.  Note that in this code each process, or task, has only a portion
of the arrays and must exchange boundary data using message passing.

Compare to:

 * :ref:`jacobi1d_omp1`  

 * :ref:`jacobi1d_omp2`  

The code:

.. literalinclude:: ../codes/mpi/jacobi1d_mpi.f90
   :language: fortran
   :linenos:

