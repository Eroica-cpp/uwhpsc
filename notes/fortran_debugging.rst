
.. _fortran_debugging:

=============================================================
Fortran debugging
=============================================================



Print statements
----------------

Adding print statements to a program is a tried and true method of
debugging, and the only method that many programmers use.
Not because it's the best method, but it's sometimes the simplest way to
examine what's going on at a particular point in a program.  

Print statements can be added almost anywhere in a Fortran code to print
things out to the terminal window as it goes along.  

You might want to put some special symbols in debugging statements to flag
them as such, which makes it easier to see what output is your debug output,
and also makes it easier to find them again later to remove from the code,
e.g. you might use "+++" or "DEBUG".  

Compiling with various gfortran flags
-------------------------------------

There are a number of flags you can use when compiling your code that will
make it easier to debug.

Here's a generic set of options you might try::

    $ gfortran -g -W -Wall -fbounds-check -pedantic-errors \
          -ffpe-trap=zero,invalid,overflow,underflow  program.f90

See :ref:`gfortran_flags` or the 
`gfortran man page <http://linux.die.net/man/1/gfortran>` 
for more information.  Most of these options
indicate that the program should give warnings or die if certain bad things
happen.

Compiling with the `-g` flag indicates that information should be
generated and saved during compilation that can be used to help debug the
code using a debugger such as `gdb` or `totalview`.  You generally have to
compile with this option to use a debugger.

The `gdb` debugger
------------------

This is the Gnu open source debugger for Gnu compilers such as gfortran.
Unfortunately it often works very poorly for Fortran.

You can install it on the VM using::

    $ sudo apt-get install gdb

And then use via, e.g.:

    $ cd $UWHPSC/codes/fortran
    $ gfortran -g segfault1.f90
    $ gdb a.out
    (gdb) run
      .... runs for a while and then prints
         Program received signal EXC_BAD_ACCESS, Could not access memory.
         Tells what line it died in.

    (gdb) p i
    $1 = 241
    (gdb) q

This at least reveals where the error happened and allows printing the value
of `i` when it died.


Totalview
---------

Totalview is a commercial debugger that works quite well on Fortran codes
together with various compilers, including gfortran.  It also works with
other languages, and for parallel computing.

See `Rogue Wave Softare -- totalview family <http://www.roguewave.com/products/totalview-family.aspx>`_.


