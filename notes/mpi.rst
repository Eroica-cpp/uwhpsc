
.. _mpi:

=============================================================
MPI
=============================================================


MPI stands for *Message Passing Interface* and is a standard approach for
programming distributed memory machines such as clusters, supercomputers, or
heterogeneous networks of computers.  It can also be used on a single
shared memory computer, although it is often more cumbersome to program in
MPI than in OpenMP.

MPI implementations
-------------------

A number of different implementations are available (open source and vendor
supplied for specific machines).   See 
`this list
<http://www.mcs.anl.gov/research/projects/mpi/implementations.html>`_, for
example.

.. _mpi_vm

MPI on the class VM
-------------------

The VM has `open-mpi <http://www.open-mpi.org/>`_  partially installed.

You will need to do the following::

    $ sudo apt-get update
    $ sudo apt-get install openmpi-dev

On other Ubuntu installations you will also have to do::

    $ sudo apt-get install openmpi-bin          # Already on the VM


You should then be able to do the following::

    $ cd $UWHPSC/codes/mpi
    $ mpif90 test1.f90
    $ mpiexec -n 4 a.out

and see output like::

    Hello from Process number           1  of            4  processes
    Hello from Process number           3  of            4  processes
    Hello from Process number           0  of            4  processes
    Hello from Process number           2  of            4  processes


Test code
-----------------

The simple test code used above illustrates use of some of the basic MPI
subroutines.  

.. literalinclude:: ../codes/mpi/test1.f90
   :language: fortran
   :linenos:

Reduction example
-----------------

The next example uses `MPI_REDUCE` to add up partial sums computed by
independent processes.

.. literalinclude:: ../codes/mpi/pisum1.f90
   :language: fortran
   :linenos:

Send-Receive example
--------------------

In this example, a value is set in Process 0 and then passed to Process 1
and on to Process 2, etc. until it reaches the last process, where it is
printed out.

.. literalinclude:: ../codes/mpi/copyvalue.f90
   :language: fortran
   :linenos:

Master-worker examples
----------------------

The next two examples illustrate using Process 0 as a *master* process to
farm work out to the other processes.  In both cases the 1-norm of a matrix
is computed, which is the maximum over `j` of the 1-norm of the `j`th column
of the matrix.

In the first case we assume there are the same number of worker processes as
columns in the matrix:

.. literalinclude:: ../codes/mpi/matrix1norm1.f90
   :language: fortran
   :linenos:

In the next case we consider the more realistic situation where there may be
many more columns in the matrix than worker processes.  In this case the
*master* process must do more work to keep track of how which columns have
already been handled and farm out work as worker processes become free.

.. literalinclude:: ../codes/mpi/matrix1norm2.f90
   :language: fortran
   :linenos:

Sample codes
------------

Some other sample codes can also be found in the `$UWHPSC/codes/mpi` directory.

* :ref:`jacobi1d_mpi` 

See also the samples in the list below.

Further reading
---------------

 * :ref:`biblio_mpi` section of the bibliography lists some books.
 * `Argonne tutorials  <http://www.mcs.anl.gov/research/projects/mpi/tutorial/>`_
 * `Tutorial slides by Bill Gropp <http://www.mcs.anl.gov/research/projects/mpi/tutorial/gropp/talk.html>`_
 * `Livermore tutorials <https://computing.llnl.gov/tutorials/mpi/>`_
 * `Open MPI <http://www.open-mpi.org/>`_
 * `The MPI Standard <http://www.mcs.anl.gov/research/projects/mpi/>`_
 * `Some sample codes  <http://www.mcs.anl.gov/research/projects/mpi/usingmpi/examples/simplempi/main.htm>`_
 * `LAM MPI tutorials <http://www.lam-mpi.org/tutorials/>`_
 * Google "MPI tutorial" to find more.
 * `Documentation on MPI subroutines <http://www.mcs.anl.gov/research/projects/mpi/www/www3/>`_

