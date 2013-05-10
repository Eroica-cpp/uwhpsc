
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


Sample codes
------------

Some sample codes will be put in the `$UWHPSC/codes/mpi` directory.

See also the samples in the list below.

Further reading
---------------

 * `Argonne tutorials  <http://www.mcs.anl.gov/research/projects/mpi/tutorial/>`_
 * `Tutorial slides by Bill Gropp <http://www.mcs.anl.gov/research/projects/mpi/tutorial/gropp/talk.html>`_
 * `Livermore tutorials <https://computing.llnl.gov/tutorials/mpi/>`_
 * `Open MPI <http://www.open-mpi.org/>`_
 * `The MPI Standard <http://www.mcs.anl.gov/research/projects/mpi/>`_
 * `Some sample codes  <http://www.mcs.anl.gov/research/projects/mpi/usingmpi/examples/simplempi/main.htm>`_
 * `LAM MPI tutorials <http://www.lam-mpi.org/tutorials/>`_
 * Google "MPI tutorial" to find more.
