
.. _2013_homework6:

==========================================
2013 Homework 6 
==========================================

.. warning :: This is a 2013 homework assignment.  


Due Friday, May 31, 2013, by 11:00pm PDT.
**Note change in due date**

The goals of this homework are to:

* Get some experience with MPI.
* Study some of the sample codes in more detail in order to modify them.

First make sure MPI works by trying out the sample programs
in the directory `$UWHPSC/codes/mpi`.

Create a new subdirectory `homework6` in your repository for the codes you
create.

#.  The sample program `$UWHPSC/codes/mpi/copyvalue.f90` sets a value of `i`
    in Process 0 and passes this through a chain of processes up to Process
    `num_procs - 1`.  There are print statements in this codes so that running
    it should give, for example with 4 processes specified::

        $ mpif90 copyvalue.f90 
        $ mpiexec -n 4 a.out

        Process   0 setting      i =  55
        Process   1 receives     i =  55
        Process   1 sends        i =  55
        Process   2 receives     i =  55
        Process   2 sends        i =  55
        Process   3 ends up with i =  55

    Create a modified code `copyvalue2.f90`
    that instead sets the value `i = 55` in Process
    `num_procs - 1` and passes the value backwards to Process 0. 

    Also change your version to subtract 1 from the value of `i` by each Process
    along the way.  So the output should now look like::

        $ mpif90 copyvalue2.f90
        $ mpiexec -n 4 a.out

        Process   3 setting      i =  55
        Process   2 receives     i =  55
        Process   2 sends        i =  54
        Process   1 receives     i =  54
        Process   1 sends        i =  53
        Process   0 ends up with i =  53


#.  The directory `$UWHPSC/codes/homework6` contains an MPI version of the
    quadrature codes, which simply uses the Trapezoid Rule to calculate an
    approximation to a single integral.
    Copy these files into your repository and then fix the file `test.f90`
    so that it properly prints out the total number of `f` evaluations at the end. 
    The sample version simply prints 0 and to do the right thing you will have
    to use `MPI_REDUCE` to sum up the values of `feval_proc` that each process
    computes.  

    There is a Makefile that can be used to run with different values of
    `num_procs`, and when working properly you code should give results
    similar to this::

        $ make test
        mpif90  -c  functions.f90 
        mpif90  -c  quadrature.f90 
        mpif90  -c  test.f90 
        mpif90  functions.o quadrature.o test.o -o test.exe

        mpiexec -n 4    test.exe
        Using   4 processes
        true integral:   6.00136745954910E+00
          
        Process   0 with n =     1000 computes int_approx =   6.00088098873994E+00
        Process   3 with n =     1000 computes int_approx =   6.00088098873994E+00
        Process   1 with n =     1000 computes int_approx =   6.00088098873994E+00
        Process   2 with n =     1000 computes int_approx =   6.00088098873994E+00
        fevals by Process  3:          1000
        fevals by Process  0:          1000
        fevals by Process  1:          1000
        fevals by Process  2:          1000
        Total number of fevals:       4000

    The default number of processes is 4, but you can change this, e.g.::

        $ make test NUM_PROCS=6
        mpiexec -n 6 test.exe
        Using   6 processes
        true integral:   6.00136745954910E+00
          
        Process   0 with n =     1000 computes int_approx =   6.00088098873994E+00
        Process   4 with n =     1000 computes int_approx =   6.00088098873994E+00
        Process   5 with n =     1000 computes int_approx =   6.00088098873994E+00
        fevals by Process  5:          1000
        Process   1 with n =     1000 computes int_approx =   6.00088098873994E+00
        fevals by Process  1:          1000
        Process   2 with n =     1000 computes int_approx =   6.00088098873994E+00
        fevals by Process  2:          1000
        Process   3 with n =     1000 computes int_approx =   6.00088098873994E+00
        fevals by Process  3:          1000
        fevals by Process  0:          1000
        fevals by Process  4:          1000
        Total number of fevals:       6000

    **Note:** In spite of the `MPI_BARRIER` calls in between blocks of print 
    statements, the statements may appear in somewhat the wrong order as 
    above because of the way print buffers work.  
    Having multiple processes print to the screen (or to the same
    file) in an MPI code is generally a bad idea (and doesn't even make
    sense if you're running on a cluster of computers that don't share the same
    file system or have access to the terminal).  But it's useful for our
    purposes in better understanding what's being done.

    The way `test.f90` is written it is not using multiple processors in a
    sensible way.  Each process is independently computing exactly the
    same thing -- an approximation to the integral using the same
    number of points `n` across the full interval from `a` to `b`.

    Create a new version `test2.f90` that instead does the following:

    * When run with `num_procs` processors, split the interval from `a` to `b`
      up into `num_procs - 1` pieces.  Process 0 should act as the *master*
      process that splits up the interval and sends the subintervals out to each
      worker process 1, 2, ..., `num_procs - 1`.  Process 0 should then receive
      a value `int_sub` from each worker process that is the Trapezoidal
      approximation the the integral over this subinterval computed with `n`
      points.  Process 0 adds these up and prints out the resulting
      approximation to the integral over the full interval `a` to `b`.

    * Use this master-worker paradigm and a similar framework to the 
      sample code `$UWHPSC/codes/mpi/matrix1norm1.f90`.  Note that
      Process 0 does not compute an approximation on any subinterval, 
      it just acts as the master.  

    * For this problem it would be both easier and perhaps more
      sensible to instead have each process compute an approximation
      on a subinterval and then use MPI_REDUCE to combine these
      into the final full approximation.  But the point of this
      exercise is to get some experience with the master-worker
      paradigm.

    * The master process should compute the left and right edge of
      the j'th subinterval and send these to Process `j`.  These should be 
      sent with a single call to `MPI_SEND`, e.g. in the code for the master
      process you might have lines like::

          if (proc_num == 0) then

              dx_sub = (b-a) / nsub

              do j=1,nsub
                ab_sub(1) = a + (j-1)*dx_sub
                ab_sub(2) = a + j*dx_sub
                call MPI_SEND(ab_sub, 2, MPI_DOUBLE_PRECISION, j, j, &
                              MPI_COMM_WORLD, ierr)
                enddo

             ! followed by a loop to receive back each result.

      Here `ab_sub` is an array of length 2 that holds the left and right
      edges of the j'th subinterval.  

      The code for each worker process should receive this information and
      then have a call of the form::

        int_sub = trapezoid(f,ab_sub(1),ab_sub(2),n)

      to compute the Trapezoid approximation on this subinterval with `n` 
      points, and then send the result back to Process 0.

    Sample results might look like the following::


        $ make test2
        mpif90  -c  functions.f90 
        mpif90  -c  quadrature.f90 
        mpif90  -c  test2.f90 
        mpif90  functions.o quadrature.o test2.o -o test2.exe
        mpiexec -n 4    test2.exe

        Using   4 processes
        true integral:   6.00136745954910E+00
          
        fevals by Process  0:             0
        fevals by Process  1:          1000
        fevals by Process  2:          1000
        fevals by Process  3:          1000
        Trapezoid approximation with     3000 total points:   6.00131677608477E+00
        Total number of fevals:       3000


    Note that Process 0 does no function evaluations and each of the others
    use `n = 1000` points for their subinterval.

    With this version of the code, increasing the number of processes
    should improve the approximation to the integral.

    The final two lines of the output shown above were printed with these 
    statements::

        if (proc_num==0) then
            print '("Trapezoid approximation with ",i8," total points: ",es22.14)',&
                    nsub*n, int_approx
            print '("Total number of fevals: ",i10)', fevals_total
            endif

    (Note that the format statement can be directly included in the print
    statement by enclosing it in quotes of a different sort than used in
    specifying the format.)

**There is no additional 583 problem on this assignment.**


To submit
---------

Your homework6 directory should contain:

* copyvalue2.f90 
* quadrature.f90 (unchanged)
* functions.f90 (unchanged)
* test.f90 (modified to properly print `fevals_total`)
* test2.f90 (modified for master-worker version)
* Makefile (modified so `make test2` works)


As usual, commit your results, push to bitbucket, and see the Canvas
course page for the link to submit the SHA-1 hash code.  These should be 
submitted by the due date/time to receive full credit.

    
