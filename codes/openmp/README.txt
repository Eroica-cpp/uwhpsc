
Instructions to run a code from this directory using OpenMP:

The Makefile is set up to accept a file name FNAME, so for example to
compile and test demo1.f90:

    $ make test FNAME=demo1

This runs the code using the Unix time utility, so it also prints the
runtime at the end.  Recall that 'real' is the elapsed time and 'user' is
the total CPU time (by all threads).

You may need to increase the stack limit to avoid a segmentation fault when
running demo1.f90.  On linux you can do:
    $ ulimit -s
to see the stack size and
    $ ulimit -s unlimited
to make it unlimited.

On a Mac there's a hard limit to how large the stack can be and the best you
can do is:
    $ ulimit -s hard

