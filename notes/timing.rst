

.. _timing:

=============================================================
Timing code
=============================================================

.. _timing_unix:

Unix time command
-----------------

There is a built in command `time` that can be used to time other commands.
Just type `time command` at the prompt, e.g.::

    $ time ./a.out
    <output from code>

    real    0m5.279s
    user    0m1.915s
    sys     0m0.006s

This executes the command `./a.out` in this case (running a Fortran
executable) and then prints information
about the time required to execute, where, roughly speaking,
*real* is the wall-clock time, *user* is the time spent executing the
user's program, and *sys* is the time spent on system tasks required by the
program.

There may be a big difference between the *real* time and the sum of the
other two times if the computer is simulataneously executing many other
tasks and your program is only getting some of its attention.

Using *time* does not allow you to examine how much CPU time different parts
of the code required, for example.

.. _timing_fortran:

Fortran timing utilities
------------------------

There are two Fortran intrinsic functions that are very useful.

`system_clock` tells the elapsed wall time between two successive calls, and
might be used as follows::

    integer(kind=8) :: tclock1, tclock2, clock_rate
    real(kind=8) :: elapsed_time

    call system_clock(tclock1)

    <code to be timed>

    call system_clock(tclock2, clock_rate)
    elapsed_time = float(tclock2 - tclock1) / float(clock_rate)


`cpu_time` tells the CPU time used between two successive calls::

    real(kind=8) :: t1, t2, elapsed_cpu_time

    call cpu_time(t1) 

    <code to be timed>

    call cpu_time(t2) 
    elapsed_cpu_time = t2 - t1

    
Here is an example code that uses both, and tests matrix-matrix multiply.

.. literalinclude:: ../codes/fortran/timings.f90
   :language: fortran
   :linenos:

Note that the matrix-matrix product is computed 20 times over to give a
better estimate of the timings.  

You might want to experiment with this code and various sizes of the
matrices and optimization levels.  Here are a few sample results on a
MacBook Pro. 

First, with no optimization and :math:`200\times 200` matrices::

    $ gfortran timings.f90 
    $ ./a.out
     Will multiply n by n matrices, input n: 
    200
    Performed   20 matrix multiplies: CPU time =   0.81523600 seconds
    Elapsed time =   5.94083357 seconds

Note that the elapsed time include the time required to type in the response
to the prompt for `n`, as well as the time required to allocate and
initialize the matrices, whereas the CPU time is just for the matrix
multiplication loops.

Trying a larger :math:`400 \times 400` case gives::

    $ ./a.out
     Will multiply n by n matrices, input n: 
    400
    Performed   20 matrix multiplies: CPU time =   7.33721500 seconds
    Elapsed time =   9.87114525 seconds

Since computing the product of :math:`n \times n` matrices takes
:math:`O(n^3)` flops,
we expect this to take about 8 times as much CPU time as the previous test.
This is roughly what we observe.

Doubling the size again gives requires much more that 8 times as long
however::

    $ ./a.out
     Will multiply n by n matrices, input n: 
    800
    Performed   20 matrix multiplies: CPU time =  90.49682200 seconds
    Elapsed time =  93.98917389 seconds

Note that 3 matrices that are :math:`400\times 400` require 3.84 MB of memory,
whereas three :math:`800 \times 800` matrices require 15.6 MB.  Since the MacBook
used for this experiment 
has only 6 MB of L3 cache, the data no longer fit in cache.

**Compiling with optimization**

If we recompile with the -O3 optimization flag, the last two experiments
give these results::

    $ gfortran -O3 timings.f90 
    $ ./a.out
     Will multiply n by n matrices, input n: 
    400
    Performed   20 matrix multiplies: CPU time =   1.39002200 seconds
    Elapsed time =   3.58041191 seconds

and ::

    $ ./a.out
     Will multiply n by n matrices, input n: 
    800
    Performed   20 matrix multiplies: CPU time =  66.39167200 seconds
    Elapsed time =  68.29921722 seconds

Both have sped up relative to the un-optimized code, the first much more
dramatically.  

.. timing_openmp:

Timing OpenMP code
------------------

The code in `$UWHPSC/codes/openmp/timings.f90` shows an analogous code for
matrix multiplication using OpenMP. 

The code has been slightly modified so that `system_clock` is only timing
the inner loops in order to illustrate that `cpu_time` now computes the sum
of the CPU time of all threads.

Here's one sample result::

    $ gfortran -fopenmp -O3 timings.f90 
    $ ./a.out
     Using OpenMP, how many threads? 
    4
     Will multiply n by n matrices, input n: 
    400
    Performed   20 matrix multiplies: CPU time =   1.99064000 seconds
    Elapsed time =   0.58711302 seconds

Note that the CPU time reported is nearly 2 seconds but the elapsed time is
only 0.58 seconds in this case when 4 threads are being used.

The total CPU time is slightly more than the previous code that did not use
OpenMP, but the wall time is considerably less.

For :math:`800\times 800` matrices there is a similar speedup::

    $ ./a.out
     Using OpenMP, how many threads? 
    4
     Will multiply n by n matrices, input n: 
    800
    Performed   20 matrix multiplies: CPU time =  79.70573500 seconds
    Elapsed time =  21.37633133 seconds

Here is the code:

.. literalinclude:: ../codes/openmp/timings.f90
   :language: fortran
   :linenos:

