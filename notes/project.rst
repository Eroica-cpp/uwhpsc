
.. _project:

==========================================
Final Project
==========================================


Due Wendesday, June 12, 2013, by 11:00pm PDT.

The goals of this project are to:

* Get some more experience with MPI and the master-worker paradigm.
* Learn about Monte Carlo methods and random number generators.

See also:

* :ref:`random`

Create a new subdirectory `project` in your repository for the codes you
create.

**PART 1**

Create a subdirectory `project/part1` for this part.

#.  In the last part of :ref:`homework6`, you wrote an MPI code to compute
    a Trapezoid approximation to an integral by splitting the original
    interval up into `nsub = num_procs - 1` subintervals. The master Process
    0 farmed these out to the remaining processes and collected the results.

    Modify your code to make a new version `test3.f90`
    that allows nsub to be set to a value larger (or smaller) than
    `num_procs - 1`.  In this case the master process should send out
    subintervals to the worker processes until all the work is done.  This
    will require doing something similar to what is done in the sample code
    `$UWHPSC/codes/mpi/matrix1norm2.f90` to keep track of which subintervals
    have been handled.  

    Have Process 0 read in the number of subintervals with the lines::

            print *, "How many subintervals? "
            read *, nsub

    and then broadcast this value to the other processes.  

    Test that your code works both when the number of subintervals is
    smaller or larger than the number of processes specified with `mpiexec`.

    If the code is run with a single process then it should halt with an
    error message (since there are no workers to compute the integral over
    subintervals in this case).

    Provide a `Makefile` that compiles using `mpif90` and runs the code by 
    default with 4 processes, as in Homework 6.

    **Sample output**

    Your code should produce output similar to this, for example... ::
        
        $ make test3
        mpif90  -c  functions.f90 
        mpif90  -c  quadrature.f90 
        mpif90  -c  test3.f90 
        mpif90  functions.o quadrature.o test3.o -o test3.exe
        mpiexec -n 4    test3.exe
        Using   4 processes
         How many subintervals? 
        2
        true integral:   6.00136745954910E+00
          
        fevals by Process  0:             0
        fevals by Process  1:          1000
        fevals by Process  2:          1000
        fevals by Process  3:             0
        Trapezoid approximation with     2000 total points:   6.00125232481036E+00
        Total number of fevals:       2000
        
        
        
        $ make test3
        mpiexec -n 4    test3.exe
        Using   4 processes
         How many subintervals? 
        7
        true integral:   6.00136745954910E+00
          
        fevals by Process  0:             0
        fevals by Process  1:          3000
        fevals by Process  2:          2000
        fevals by Process  3:          2000
        Trapezoid approximation with     7000 total points:   6.00135820753458E+00
        Total number of fevals:       7000
        
        
        $ make test3 NUM_PROCS=1
        mpiexec -n 1 test3.exe
         *** Error: need to use at least two processes
        

**PART 2**

Create a subdirectory `project/part2` for this part.

#.  Monte Carlo methods are often used to estimate the values of definite
    integrals in high dimensional spaces since traditional quadrature
    methods based on regular grids may require too many points.  

    The files in `$UWHPSC/codes/project/part2` contain much of what is
    needed to experiment with a Monte Carlo approximation to the integral

    :math:`\int_{a_1}^{b_1} \int_{a_2}^{b_2} \cdots \int_{a_d}^{b_d} g(x_1,x_2,\ldots,x_d) dx_1~dx_2~\cdots~dx_d`

    over a rectangular region in :math:`d` space dimensions.  The Monte
    Carlo approximation to the integral is given by 

    :math:`\frac V N \sum_1^N g(x_1^{[k]},x_2^{[k]},\ldots,x_d^{[k]})`

    where :math:`(x_1^{[k]},x_2^{[k]},\ldots,x_d^{[k]})` is the k'th
    random point and :math:`V = (b_1-a_1)(b_2-a_2)\cdots(b_d-a_d)` is the
    volume of the rectangular region of integration.

    The main program in `test_quad_mc.f90` is set up to experiment with a
    simple integral with varying number of Monte-Carlo points.  

    What is missing is the module `quadrature_mc.f90`.  Create this module,
    containing a function `quad_mc` with the calling sequence::

        quad_mc(g, a, b, ndim, npoints)

    that returns a Monte Carlo approximation to the integral, where:

    * `g` is the function defining the integrand.  `g` takes two
      arguments `x` and `ndim`, where `x` is an array of length `ndim`,
      the number of dimensions we are integrating over.
      (See the example in the `functions.f90` module.)

    * `a` and `b` are arrays of length `ndim` that have the lower and upper
      limits of integration in each dimension.

    * `ndim` is the number of dimensions to integrate over.

    * `npoints` is the number of Monte Carlo samples to use.


    The random number generator should be called only once to generate all
    the points needed and then the function `g` evaluated at appropriate
    points.  Note that you will need `npoints*ndim` random numbers since
    each point `x` has `ndim` components.

    Allocate appropriate size arrays to manage this.

    Note that the function :math:`g(x)` specified for this test is very
    simple so that the true solution can be easily computed in any number of 
    dimensions.

    :math:`g(x) = x_1^2 + x_2^2 + \cdots + x_d^2`

    The test program in `test_quad_mc.f90` computes the exact integral of
    this over any rectangular region.  Convince yourself this is right.

    Once you have provided a suitable module as described above,
    running this code should give results like the following::

        $ make plot
        gfortran  -c  random_util.f90 
        gfortran  -c  functions.f90 
        gfortran  -c  quadrature_mc.f90 
        gfortran  -c  test_quad_mc.f90 
        gfortran  random_util.o functions.o quadrature_mc.o test_quad_mc.o -o
        test.exe
        ./test.exe
        Testing Monte Carlo quadrature in 20 dimensions
        True integral:   1.95734186666667E+08
         seed1 for random number generator:       12345
        Final approximation to integral:   1.95728471073896E+08
         Total g evaluations:      1310720
         python plot_mc_quad_error.py

    A file `mc_quad_error.txt` should be created with the estimate of the
    integral computed with varying number of random points and the error
    in each.  

    A plot of these results should also be created as `mc_quad_error.png`,
    that looks like this:

    .. image:: images/mc_quad_error.png
       :width: 10cm


    The test problem is set up to estimate a 20-dimensional integral.
    Note that the relative error is plotted, which gives an indication
    of the number of correct digits.  (Note that the absolute error is about 
    2e8 times larger for this problem!)

.. warning:: Incomplete... more will be added soon.

