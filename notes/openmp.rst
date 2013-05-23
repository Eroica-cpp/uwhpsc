
.. _openmp:

=============================================================
OpenMP
=============================================================

OpenMP is discussed in :ref:`slides` starting with Lecture 13.


Sample codes
------------

There are a few sample codes in the `$UWHPSC/codes/openmp` directory.
See the `README.txt` file for instructions on compiling and executing.


Here is a very simple code, that simply evaluates a costly function at many
points:

.. literalinclude:: ../codes/openmp/yeval.f90
   :language: fortran
   :linenos:

Note the following:

* Lines starting with `!$` are only executed if the code is compiled and run
  with the flag `-fopenmp`, otherwise they are comments.

* `x` must be declared a `private` variable in the `omp parallel do` loop,
  so that each thread has its own version.  Otherwise another thread might
  reset `x` between the time its assigned a value and the time this value is
  used to set `y(i)`.

* The loop iterator `i` is private by default, but all other varaibles
  are shared by default.

* If you try to run this and get a "segmentation fault", it is probably
  because the stack size limit is too small.  You can see the limit with::

        $ ulimit -s 

  On linux you can do::

        $ ulimit -s unlimited

  But on a Mac there is a hard limit and the best you can do is::

        $ ulimit -s hard

  If you still get a segmentation fault you will have to decrease `n` for 
  this example.

Other directives
-----------------

This example illustrates some directives beyond the *parallel do*:


.. literalinclude:: ../codes/openmp/demo2.f90
   :language: fortran
   :linenos:

Notes:

* `!$omp sections` is used to split up work between threads

* There is an implicit barrier after `!$omp end sections`, so the 
  explicit barrier here is optional.

* The print statement is only done once since it is in `!$omp single`.
  The `nowait` clause indicates that the other thread can proceed without
  waiting for this print to be executed.

Fine-grain vs. coarse-grain paralellism
---------------------------------------

Consider the problem of normalizing a vector by dividing each element by the
1-norm of the vector, defined by :math:`\|x\|_1 = \sum_{i=1}^n |x_i|`.

We must first loop over all points to compute the norm.  Then we must loop
over all points and set :math:`y_i = x_i / \|x\|_1`.  Note that we cannot
combine these two loops into a single loop!

Here is an example with *fine-grain paralellism*, where we use the OpenMP
`omp parallel do` directive or the `omp do` directive within a `omp
parallel` block.  


.. literalinclude:: ../codes/openmp/normalize1.f90
   :language: fortran
   :linenos:

Note the following:

* We initialize :math:`x_i=i` as a test, so :math:`\|x\|_1 = n(n+1)/2`.

* The compiler decides how to split the loop between threads.
  The loop starting on line 38 might be split differently than the
  loop starting on line 45.

* Because of this, all threads must have access to all of memory.  


Next is a version with *coarse-grain parallelism*, were we decide how to
split up the array between threads and then execute the same code on each
thread, but each thread will compute its own version of `istart` and `iend`
for its portion of the array.  With this code we are guaranteed that 
thread 0 always handles `x(1)`, for example, so in principle the data could
be distributed.  When using OpenMP on a shared memory computer this doesn't
matter, but this version is more easily generalized to MPI.

.. literalinclude:: ../codes/openmp/normalize2.f90
   :language: fortran
   :linenos:

Note the following:

* `istart` and `iend`, the starting and ending values of `i`
  taken by each thread, are explicitly computed in terms of the thread
  number.  We must be careful to handle the case when the number of 
  threads does not evenly divide `n`.

* Various variables must be declared `private` in lines 37-38.

* `norm` must be initialized to 0 before the `omp parallel` block.
  Otherwise some thread might set it to 0 after another thread has already
  updated it by its `norm_thread`.

* The update to `norm`  on line 60 
  must be in a `omp critical` block, so two threads
  don't try to update it simultaneously (data race).

* There must be an `omp barrier` on line 65
  between updating `norm` by each thread and
  using `norm` to compute each `y(i)`.   We must make sure all threads have
  updated `norm` or it won't have the correct value when we use it.

For comparison of fine-grain and
coarse-grain parallelism on Jacobi iteration, see

* :ref:`jacobi1d_omp1` 
* :ref:`jacobi1d_omp2` 

Further reading
---------------

* :ref:`biblio_openmp` in bibliography


