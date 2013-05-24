

.. _linalg:

=============================================================
Linear Algebra software
=============================================================

.. _blas: 

The BLAS
--------

The Basic Linear Algebra Subroutines are extensively used in LAPACK, in
other linear algebra packages, and elsewhere.  

There are three levels of BLAS:

* Level 1: Scalar and vector operations
* Level 2: Matrix-vector operations
* Level 3: Matrix-matrix operations

For general information about BLAS see
`<http://www.netlib.org/blas/faq.html>`_.

Optimized versions of the BLAS are available for many computer
architectures.  See

* `OpenBLAS <http://xianyi.github.io/OpenBLAS/>`_
* `GotoBLAS <http://www.tacc.utexas.edu/tacc-projects/gotoblas2>`_

See also:

* `Automatically Tuned Linear Algebra Software (ATLAS) <http://math-atlas.sourceforge.net/>`_
* `BLACS <http://www.netlib.org/blacs/>`_ Basic Linear Algebra Communication
  Subprograms with message passing.
* `PSBLAS <http://www.ce.uniroma2.it/psblas/>`_ -- Parallel sparse BLAS.


.. _linalg_lapack:

LAPACK
------

* `LAPACK <http://www.netlib.org/lapack/>`_
* `LAPACK User's Guide <http://www.netlib.org/lapack/lug/>`_
* `<http://en.wikipedia.org/wiki/LAPACK>`_
* `ScaLAPACK <http://www.netlib.org/scalapack/>`_ for parallel distributed memory
  machines

To install BLAS and LAPACK to work with gfortran, see:

* `<http://gcc.gnu.org/wiki/GfortranBuild>`_

On some linux systems, including the VM for the class, you can install both
BLAS and LAPACK via::

    $ sudo apt-get install liblapack-dev 


.. _linalg_spdirect:

Direct methods for sparse systems
----------------------------------

Although iterative methods are often used for sparse systems, there are also
excellent software packages for direct methods (such as Gaussian
elimination):

* `UMFPACK <http://www.cise.ufl.edu/research/sparse/umfpack/>`_
* `SuperLU <http://crd-legacy.lbl.gov/~xiaoye/SuperLU/>`_
* `MUMPS <http://graal.ens-lyon.fr/MUMPS/>`_
* `Pardiso <http://www.pardiso-project.org/>`_


Other references
----------------

* :ref:`lapack_examples` for some examples.


* `Recent list of freely available linear algebra software
  <http://www.netlib.org/utk/people/JackDongarra/la-sw.html>`_

