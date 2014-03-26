
.. _2013_homework4:

==========================================
2013 Homework 4 
==========================================

.. warning :: This is a 2013 homework assignment.  


Due Wednesday, May 8, 2013, by 11:00pm PDT.

The goals of this homework are to:

* Get more experience with Fortran code.
* Get some experience with OpenMP.
* Learn a bit about quadrature if you're not familiar with it.


#. The IPython notebook `$UWHPSC/codes/homework4/quadrature.ipynb`
   contains a brief discussion of numerical quadrature and the 
   trapezoidal rule in particular.  It also contains some sample code 
   for trying out the trapezoidal method on some test functions, printing
   tables of the error for different numbers of grid points, and plotting
   the errors on a log-log plot.

   This notebook is best viewed live so that you can experiment with
   changing things in order to explore these examples.  If you have a
   sufficiently recent version of the notebok installed (see
   :ref:`ipython_notebook`) then you should be able to do::

        $ cd $UWHPSC/codes/homework4
        $ ipython notebook --pylab inline 

   and then click on the `quadrature` notebook.

   You can also view a static version of the notebook, which is in 
   `$UWHPSC/codes/homework4/quadrature_notebook.pdf`.

   There is also a Python script version of the code in the notebook at
   `$UWHPSC/codes/homework4/quadrature.py` if you find that easier to experiment
   with. (But see the comments at the top of that file.)

   Experiment with the notebook or the module to make sure you understand
   the material presented.  You do not need to submit anything for this
   part.

#. Create a new subdirectory `$MYHPSC/homework4` for the code you write
   below.  

   Develop a Fortran version of the Python code, with the following
   requirements:

   * The module quadrature.f90 should contain a function `trapezoid`
     that has the same input arguments and output as the Python function
     `trapezoid` from the notebook.  This function should return a 
     double precision value, the estimate of the integral.

     This module should also contain a subroutine `error_table` that prints
     out a table of errors similar to the Python version.  

     Note that an array `nvals` should be passed in and in the subroutine
     definition you won't know how long this will be.  You can declare it as::

            integer, dimension(:), intent(in) :: nvals

     and then use `size(nvals)` when you need the length for the loop bounds.

     These print statements might be useful for formatting the table::

            print *, "    n         trapezoid            error       ratio"

     for the heading, and then in the loop::

                print 11, n, int_trap, error, ratio
         11     format(i8, es22.14, es13.3, es13.3)

     so the format looks similar to the Python example.

   * You should be able to use the module together with the main program
     provided in `$UWHPSC/codes/homework4/test1.f90`, which will test it
     on the first example used in the notebook.

     Note that the function is defined in this same file following the
     `contains` statement.

   * Your module `quadrature.f90` should also work if we test it
     out with a different main program / function for grading purposes, so please 
     make sure the arguments of the function and subroutine in this module are as
     specified.

   * You do not need to create a `Makefile`.  You are welcome to do so if 
     you find it convenient, but it is enough if your program runs with
     the commands ::

        $ gfortran quadrature.f90 test1.f90
        $ ./a.out

#.  Write a second main program `test2.f90` (you can copy `test1.f90` and
    modify it) that tests your code on the function `f2` from the notebook
    example, the oscillatory function :math:`1. + x^3 + \sin(kx)` with `k =
    1000.`  and the set of values for `n` given in Python by the "list
    comprehension" ::

        nvals = array([5 * 2**i for i in range(12)])

    In Fortran you can write a loop to fill `nvals`.


#.  Create a second version of the quadrature module named
    `quadrature_omp.f90` that uses OpenMP within `trapezoid` to convert the 
    main loop that sums up the terms required by the trapezoid formula
    into a parallel do loop.

    Create a new version of `test2.f90` named `test2_omp.f90` 
    that sets the number of threads to be used to 2.  It should 
    run correctly and give the same results with 2 or more threads if you compile
    with::

        $ gfortran -fopenmp quadrature_omp.f90 test2_omp.f90

    as if you compile without the `-fopenmp` flag.

    Note that even if you are using a computer with only one processor, you
    can still specify 2 threads (or more) and the program should still run
    and give the same results.  (The threads will simply have to take turns
    running rather than running in parallel, but this is handled for you by OpenMP.)

    You might want to experiment with timing your code for different numbers
    of threads (perhaps for much larger values of `n`).  However, you will
    not be graded on speed.

    Note that you will have to "use omp_lib" both in the main program and in
    the trapezoid function.

    **Note:** There is no additional 583 problem this week.

To submit
---------

Your homework4 directory should contain:

    * `quadrature.f90` module
    * `test1.f90` main program as provided
    * `test2.f90` you created
    * `quadrature_omp.f90` module with OpenMP
    * `test2_omp.f90` main program with OpenMP

As usual, commit your results, push to bitbucket, and see the Canvas
course page for the link to submit the SHA-1 hash code.  These should be 
submitted by the due date/time to receive full credit.

    
