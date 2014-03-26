
.. _2013_homework5:

==========================================
2013 Homework 5 
==========================================

.. warning :: This is a 2013 homework assignment.  


Due Wednesday, May 22, 2013, by 11:00pm PDT.

The goals of this homework are to:

* Get more experience with Fortran and OpenMP.
* Experiment with coarse grain parallelism.
* Learn a bit more about quadrature.

#. I wrote an article recently urging applied mathematicians to share 
   research code, which appeared in SIAM News.
   Some colleagues at other universities have told me it's required
   reading for their students, so of course I have to assign it too!  
   It's pretty light reading.   

     * `<http://www.siam.org/news/news.php?id=2064>`_
     * `some related links  <http://faculty.washington.edu/rjl/pubs/topten/index.html>`_

   After reading it, take the Homework 5 quiz avaiable from the Canvas page.

#. The IPython notebook `$UWHPSC/codes/homework5/notebook/quadrature2.ipynb`
   is an improved version of the notebook from the last homework.  Some of
   the functions have been made more general and a discussion has
   been added of Simpson's Rule, a more accurate formula than Trapezoid.

   This notebook is best viewed live so that you can experiment with
   changing things in order to explore these examples.  If you have a
   sufficiently recent version of the notebok installed (see
   :ref:`ipython_notebook`) then you should be able to do::

        $ cd $UWHPSC/codes/homework5/notebook
        $ ipython notebook --pylab inline 

   and then click on the `quadrature2` notebook.


   You can also view it at
   `<https://www.wakari.io/sharing/bundle/rjleveque/quadrature2>`_ .
   If you have created a Wakari account, you should be able to 
   download it to your account to try it out.

   You can also view a static version of the notebook, which is in 
   `$UWHPSC/codes/homework5/notebook/quadrature2.pdf`.

   There is also a Python script version of the code in the notebook at
   `$UWHPSC/codes/homework5/notebook/quadrature.py` if you 
   find that easier to experiment with. 
   (But see the comments at the top of that file.)

   Experiment with the notebook or the module to make sure you understand
   the material presented.  

   Study this code to make sure you understand it.
   
#. The directory `$UWHPSC/codes/homework5/` also contains Fortran code
   that implements the last part of homework 4, with some added
   enhancements.  In particular:

   * timing has been added
   * a counter has been added to the f2 function to count how many times it
     is called, and this is printed at the end.
   * fevals is a module variable (shared between threads) to store the
     number of function calls by each thread when OpenMP is used.
   * the `error_table` subroutine has a new input parameter `method` to
     pass in the function that approximates the integral.  When this is
     called from the main program `test.f90` the function `trapezoid` is
     passed in.  In this homework you will also test Simpson's rule.
   * The function `f2` has been moved to a module and the parameter `k` 
     is a module variable.
     

   Study this code and experiment with it.

   With 4 threads it might produce something like the following (timings
   will depend on how many cores you have)::
        
        Using  4 threads
        true integral:   6.00136745954910E+00
          
               n         approximation        error       ratio
              50  6.00200615142458E+00    6.387E-04    0.000E+00
             100  6.01762134207395E+00    1.625E-02    3.929E-02
             200  5.99787907396672E+00    3.488E-03    4.659E+00
             400  5.99537682567465E+00    5.991E-03    5.823E-01
             800  6.00057196798962E+00    7.955E-04    7.531E+00
            1600  6.00118591794817E+00    1.815E-04    4.382E+00
            3200  6.00132301603504E+00    4.444E-05    4.085E+00
            6400  6.00135640717690E+00    1.105E-05    4.021E+00
           12800  6.00136470029559E+00    2.759E-06    4.006E+00
           25600  6.00136677000209E+00    6.895E-07    4.002E+00
           51200  6.00136728718235E+00    1.724E-07    4.000E+00
          102400  6.00136741645906E+00    4.309E-08    4.000E+00
          
        Elapsed time =   0.00554200 seconds
        CPU time =   0.01890300 seconds
        fevals by thread  0:         51211
        fevals by thread  1:         51187
        fevals by thread  2:         51187
        fevals by thread  3:         51165
        Total number of fevals:     204750
        

   You do not need to submit anything for this part.

#. Create a new subdirectory `$MYHPSC/homework5` for the code you write
   below.  You can use the code provided as a starting point.

   Create a new module `quadrature2.f90` by starting with `quadrature.f90`
   and adding a new function `simpson` that
   implements Simpson's rule.  It should have the same input arguments as
   `trapezoid`.  

   Write a new main program `test2.f90` to test this.
   Check that it is 4th order accurate on the function `f2`
   provided with various values of `k`.  Check it also with some other
   functions if you want, since we will test it with something other than
   the provided function `f2`.

   **Note:** this module should also be called `quadrature2`, not just the
   file name, i.e. it should start with the line::

        module quadrature2

   and `test2.f90` should::

        use quadrature2, only: ...
   
   This is important for grading purposes since we might have a different
   main program that will `use` your module!

#. Your `simpson` routine should include an `omp parallel do` loop similar
   to `trapezoid`.  Make sure it gives the same results in the error table
   for both with and without the `-fopenmp` during compilation, and for
   different choices of the number of threads.

   Remember that you can run with more threads than your computer has cores
   and it should still work, but will probably make it run slower rather
   than faster.  We will not be checking timings although you might want to
   pay attention to this to see if your computer behaves as expected.

#. Create a new version of the `quadrature` module named `quadrature3` that
   has no parallel loops in `trapezoid` and instead has a parallel do loop 
   in the `error_table` routine when it loops over the different values of
   `n` to test from the `nvals` array.

   In this loop make `last_error` a *firstprivate* variable and think about
   what other variables need to be *private*.  More about this below.

   Test this version with a new test program `test3.f90` that calls
   `error_table` with `method = trapezoid`. 

   Note the following:

   * If you run this with more than one thread, the different lines of the
     error table probably will not print out in the same order as on a
     single thread.
   * The values of `ratio` in the table will be wrong relative to the single 
     thread code for various `n`.  Make sure you understand why.
     (The values of the `error` should still agree with the single-thread
     code, however.)
   * This is not a very good way to try to parallelize this code because
     it does not have good *load balancing*.  If you run with 2 threads, for
     example, one of them will do many more function evaluations than the
     other thread, if you allow OpenMP to split up the values of `n` between
     threads in the default manner.  Think about why this is so and make
     sure you understand what's going on.  


   Make the changes for the next two parts also in your `quadrature3.f90` version.  


#.  Because of the load-balancing issue just mentioned, it is useful to
    include another clause in the `omp parallel do` loop directive in error
    table::

        !$omp parallel do ...  &   ! whatever you needed before
        !$omp          schedule(dynamic)
        do j=1,size(nvals)

    This instructs the compiler to split up the values of `j` from 1 to
    `size(nvals)` dynamically rather than deciding in advance that the first
    half of the values will go to Thread 0 and the second half to Thread 1,
    for example.  Instead the two threads would start working on `j=1` and
    `j=2` and whichever finishes first would start on `j=3`.  This should
    give a somewhat better balance between threads.

    Note that it can't do a perfect job for this example since computing the
    error for the last value of `j` (the largest value of `n`)
    takes  more function evaluations that all the others put together!

#.   In order to improve load balancing, reorder the parallel loop so that
     `n` is decreasing rather than increasing via::

            do j=size(nvals),1,-1

    Think about why this is better.

    In this case you might get results like this::
        
        Using  4 threads
        true integral:   6.00136745954910E+00
          
               n         approximation        error       ratio
           12800  6.00136470029559E+00    2.759E-06    0.000E+00
            6400  6.00135640717688E+00    1.105E-05    2.497E-01
           25600  6.00136677000212E+00    6.895E-07    0.000E+00
            1600  6.00118591794817E+00    1.815E-04    3.798E-03
            3200  6.00132301603504E+00    4.444E-05    2.487E-01
             800  6.00057196798962E+00    7.955E-04    2.282E-01
             400  5.99537682567465E+00    5.991E-03    7.419E-03
             200  5.99787907396672E+00    3.488E-03    2.280E-01
             100  6.01762134207395E+00    1.625E-02    3.686E-01
              50  6.00200615142457E+00    6.387E-04    5.462E+00
           51200  6.00136728718236E+00    1.724E-07    0.000E+00
          102400  6.00136741645906E+00    4.309E-08    0.000E+00
          
        Elapsed time =   0.00621600 seconds
        CPU time =   0.01550900 seconds
        fevals by thread  0:         51200
        fevals by thread  1:        102400
        fevals by thread  2:         22600
        fevals by thread  3:         28550
        Total number of fevals:     204750


    (Can you guess from this which thread got which values of `n`?)
    Notice that the table is very much out of order in this case, since lines
    were printed as threads finished their work.

    One could clean up the table by keeping the approximation and error
    values for each n in a short array and then printing at the end in 
    the proper order, along with the correct ratios.  But you don't need
    to do this for the assignment.

    The changes for Problems 6,7,8 should all be made in the same version.
    So what you turn in
    for `quadrature3.f90` will have the parallel loop in `error_table`,
    will use dynamic scheduling, and have the loop on `j` reordered.
    The `test3.f90` program should call `error_table` with `method =
    trapezoid`.


**Additional problem required only for 583 students**

#.  Suppose we want to compute an integral in two space dimensions of the
    form

    :math:`\int_a^b \int_c^d g(x,y) \, dy \, dx`

    This can be rewritten as :math:`\int_a^b f(x) \, dx` where the function
    :math:`f(x) = \int_c^d g(x,y) \, dy`.
    As usual, we could approximate the integral of :math:`f(x)` by the 
    trapezoid rule in `x`.  
    But now for each `x`, in order to approximate :math:`f(x)`
    we must approximate :math:`f(x)` by a trapezoid rule
    approximation to the integral of :math:`g(x,y)` in :math:`y`.

    Create a new directory `homework5/quad2d` that contains new versions of
    the codes `functions.f90`, `quadrature.f90`, and `test.f90` that can be
    used to approximate 

    :math:`\int_0^2 \int_1^4 \sin(x+y)~dy~dx`

    for which the true value can be easily calculated for comparison.

    In this case the function `f(x)` defined in `functions.f90` should
    contain an implementation of the trapezoid rule (in `y`) that estimates
    :math:`\int_1^4 g(x,y) \, dy`  for any value `x`.

    The `functions` module should also contain a function `g(x,y)` that will
    be called by `f`.

    For the trapezoid rule in `y`, always use `ny = 1000` points.  
    (Not a great idea, see below, but let's keep it simple.)

    Modify the test program so that it produces an error table for ten
    values of `n` as shown in the sample output below.  (These are the
    values used in the trapezoid rule approximation in `x`).

    Also modify your code so that it keeps track of how many evaluations of
    the function `g(x,y)` each thread does, by introducing a new module 
    variable `gevals` that is initialized and incremented appropriately.  

    Start with the modules provided in `$UWHPSC/codes/homework5` and you can
    leave `quadrature.f90` alone.  In this module, OpenMP is used for the loop 
    in the `trapezoid` routine.  You do not need to add it to your new 
    trapezoid loop in the definition of `f(x)`.  (You would not want to
    since they you would have nested parallel loops.)

    Sample output might look like this::
        
        Using  4 threads
        true integral:  -1.17773797385703E+00
          
               n         approximation        error       ratio
               5 -1.15309805294824E+00    2.464E-02    0.000E+00
              10 -1.17288644038560E+00    4.852E-03    5.079E+00
              20 -1.17664941136820E+00    1.089E-03    4.457E+00
              40 -1.17747897159959E+00    2.590E-04    4.203E+00
              80 -1.17767418488683E+00    6.379E-05    4.060E+00
             160 -1.17772156012371E+00    1.641E-05    3.886E+00
             320 -1.17773323092813E+00    4.743E-06    3.461E+00
             640 -1.17773612733693E+00    1.847E-06    2.569E+00
            1280 -1.17773684879809E+00    1.125E-06    1.641E+00
            2560 -1.17773702883453E+00    9.450E-07    1.191E+00
          
        Elapsed time =   0.10095600 seconds
        CPU time =   0.36504200 seconds
        fevals by thread  0:          1298
        fevals by thread  1:          1278
        fevals by thread  2:          1278
        fevals by thread  3:          1261
        Total number of fevals:       5115
        gevals by thread  0:       1298000
        gevals by thread  1:       1278000
        gevals by thread  2:       1278000
        gevals by thread  3:       1261000
        Total number of gevals:    5115000

    Note that the error decreases at the expected rate initially but for
    larger values of `n` we do not get the factor of 4 improvement we might
    hope for.  This is because the inner integral in `y` is always approximated
    with 1000 points so there is an error in the values of `f(x)` produced
    that does not
    decrease as we increase the number of points used for the outer integral.  
    (A better idea of course would be to decrease `ny` along with `n`.)

    Note that you expect the total number of `g` evaluations to be 1000
    times larger than the total number of `f` evaluations.


To submit
---------

Your homework5 directory should contain:

* functions.f90   (unchanged from `$UWHPSC/codes/homework5`)
* quadrature2.f90
* test2.f90
* quadrature3.f90
* test3.f90
* Makefile (optional if you find it useful to enhance what's provided)

**For 583 students:**

* quad2d/quadrature.f90  (original from `$UWHPSC/codes/homework5` should work here)
* quad2d/functions.f90   (with f modified and g added)
* quad2d/test.f90    (modified for this problem)
* Makefile (optional)

As usual, commit your results, push to bitbucket, and see the Canvas
course page for the link to submit the SHA-1 hash code.  These should be 
submitted by the due date/time to receive full credit.

Don't forget to also take the quiz on the reading.
    
