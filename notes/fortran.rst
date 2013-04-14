
.. _fortran:

=============================================================
Fortran
=============================================================

.. toctree::
   :maxdepth: 2

   fortran_compilers:
   fortran_compiling:
   fortran_ex1:
   fortran_intrinsic:
   fortran_default8:
   fortran_arrays:
   fortran_loops:
   fortran_if:


General References:
-------------------

 * See the :ref:`biblio_fortran` section of the bibliography for links.

.. comment:
 * There's a copy of the book [McCormack-scientific-fortran]_ 
   on reserve in the Engineering Library.

History
-------

FORTRAN stands for *FORmula TRANslator* and was the first major *high
level language* to catch on.  The first compiler was written in
1954-57.  Before this, programmers generally had to write programs in 
assembly language.

Many version followed: Fortran II, III, IV. Fortran 66
followed a set of standards formulated in 1966.

See 

 * `<http://www.ibiblio.org/pub/languages/fortran/ch1-1.html>`_
 * `<http://en.wikipedia.org/wiki/Fortran>`_

for brief histories.


Fortran 77
----------

The standards established in 1977 lead to Fortran 77, or f77, and
many codes are still in use that follow this standard.

Fortran 77 does not have all the features of newer versions and many
things are done quite differently.  

One feature of f77 is that lines of code have a very rigid structure.
This was required in early versions of Fortran due to the fact that
computer programs were written on :ref:`punchcard`.  All statements
must start in column 7 or beyond and no statement may extend beyond
column 72. The first 6 columns are used for things like labels
(numbers associated with particular statements).  In f77 any line
that starts with a 'c' in column 1 is a comment.  

We will not use f77 in this class but if you need to work with
Fortran in the future you may need to learn more about it because of
all the *legacy codes* that still use it.

Fortran 90/95
-------------

Dramatically new standards were introduced with Fortran 90, and these
were improved in mostly minor ways in Fortran 95.  There are newer
Fortran 2003 and 2008 standards but few compilers implement these fully yet.
See `Wikipedia page on Fortran standards <http://gcc.gnu.org/wiki/GFortranStandards>`_
for more information.

For this class we will use the Fortran 90/95 standards, which we will
refer to as Fortran 90 for brevity.

.. _fortran_compilers:

Compilers
---------

Unlike Python code, a Fortran program must pass through several
stages before being executed.  There are several different compilers
that can turn Fortran code into an *executable*, as described more
below.

In this class we will use *gfortran*, which is an open source
compiler, part of the `GNU Project <http://www.gnu.org/>`_.
See `<http://gcc.gnu.org/fortran/>`_ for more about gfortran.

There is an older compiler in this suite called *g77* which
compiles Fortran 77 code, but *gfortran* can also be used for Fortran
77 code and has replaced g77.

There are several commercial compilers which are better in some ways,
in particular they sometimes do better optimization and produce
faster running executables.  They also may have better debugging
tools built in.  Some popular ones are the Intel and Portland Group
compilers.


File extensions
---------------

For the gfortran compiler, fixed format code should have the
*.f* while free format code has the extension *.f90* or *.f95*.  We
will use *.f90*.

.. _fortran_compiling:

Compiling, linking, and running a Fortran code
----------------------------------------------

Suppose we have a Fortran file named `demo1.f90`, for example the
program below.  We can not run this directly the way we did a Python
script.  Instead it must be converted into *object code*, a version
of the code that is in a machine language specific to the type of
computer.  This is done by the *compiler*.

Then a *linker* must be used to convert the object code into an 
*executable* that can actually be executed.

This is broken into two steps because often large programs are split
into many different *.f90* files.  Each one can be compiled into a
separate *object file*, which by default has the same name but with a
*.o* extension (for example, from `demo1.f90` the compiler would
produce `demo1.o`).  One may also want to call on *library routines* that
have already been compiled and reside in some library.  The linker
combines all of these into a single executable.

For more details on the process, see for example:

 * `<http://en.wikipedia.org/wiki/Compiler>`_
 * `<http://en.wikipedia.org/wiki/Linker_%28computing%29>`_

For the simplest case of a self-contained program in one file, we can
combine both stages in a single `gfortran` command, e.g. ::

    $ gfortran demo1.f90

By default this will produce an *executable* named `a.out` for
obscure historical reasons (it stands for *assembler output*,
see `wikipedia <http://en.wikipedia.org/wiki/A.out>`_).

To run the code you would then type::

    $ ./a.out

Note we type `./a.out` to indicate that we are executing `a.out` from
the current directory.  There is an environment variable `PATH` that
contains your *search path*, the set of directories that are searched
whenever you type a command name at the Unix prompt.  Often this is
set so that the current directory is the first place searched, in
which case you could just type `a.out` instead of `./a.out`.
However, it is generally considered bad practice to include the
current directory in your search path because bad things can happen
if you accidentally execute a file. 

If you don't like the name `a.out` you can specify an output name
using the `-o` flag with the `gfortran` command.  For example, 
if you like the Windows convention of using the extension `.exe` for
executable files::

    $ gfortran demo1.f90 -o demo1.exe
    $ ./demo1.exe

will also run the code.

Note that if you try one of the above commands, there will be no file
`demo1.o` created.  By default `gfortran` removes this file once the
executed is created.  

Later we will see that it is often useful to split up the compile and
link steps, particularly if there are several files that need to be
compiled and linked.  We can do this using the `-c` flag to compile
without linking::

    $ gfortran -c demo1.f90              # produces demo1.o
    $ gfortran demo1.o -o demo1.exe      # produces demo1.exe

There are many other compiler flags that can be used, see 
`linux man page for gfortran
<http://linux.die.net/man/1/gfortran>`_ for a list.

.. _fortran_ex1:

Sample codes
------------

The first example simply assigns some numbers to variables and then
prints them out.   The comments below the code explain some features.

.. literalinclude:: ../codes/fortran/demo1.f90
   :language: fortran
   :linenos:

*Comments:*

 * Exclamation points are used for comments

 * The `implicit none` statement in line 7 means that any variable
   to be used must be explicitly declared.  See
   :ref:`fortran_implicit` for more about this.

 * Lines 8-10 declare four variables `x, y, z, n`.   Note that `x` is declared to
   have type `real` which is a floating point number stored in 4
   bytes, also known as *single precision*.  This could have
   equivalently been written as::

        real (kind=4) :: x

   `y` and `z` are floating point numbers stored in 8 bytes
   (corresponding to *double precision* in older versions of
   Fortran).  This is generally what you want to use.

 * Fortran is not case-sensitive, so `M` and `m` refer to the same
   variable!!

 * `1.23456789e-10` specifies a 4-byte real number.  The 8-byte
   equivalent is `1.23456789d-10`, with a `d` instead of `e`.
   This is apparent from the output below.

Compiling and running this program produces::

    $ gfortran demo1.f90 -o demo1.exe
    $ ./demo1.exe
  
     M =            3
      
     x is real (kind=4)
     x =    1.000001    
      
     y is real (kind=8)
       but 1.e0 is real (kind=4):
     y =    1.00000119209290     
      
     z is real (kind=8)
     z =    1.00000123456789     


For most of what we'll do in this class, we will use real numbers
with `(kind=8)`.  Be careful to specify constants using the `d`
rather than `e` notation if you need to use scientific notation.

(But see :ref:`fortran_default8` below for another approach.)

.. _fortran_intrinsic:

Intrinsic functions
-------------------

There are a number of built-in functions that you can use in Fortran,
for example the trig functions:

.. literalinclude:: ../codes/fortran/builtinfcns.f90
   :language: fortran
   :linenos:

This produces::

    $ gfortran builtinfcns.f90
    $ ./a.out
     pi =    3.14159265358979     
     x =   -1.00000000000000     
     y =    3.14159265358979     


See `<http://www.nsc.liu.se/~boein/f77to90/a5.html>`_ for a good list
of other intrinsic functions.

.. _fortran_default8:

Default 8-byte real numbers
---------------------------

Note that you can declare variables to be real without appending `(kind=8)`
if you compile programs with the gfortran flag `-fdefault-real-8`, e.g.
if we modify the program above to:

.. literalinclude:: ../codes/fortran/builtinfcns2.f90
   :language: fortran
   :linenos:
    
Then::

    $ gfortran builtinfcns2.f90
    $ ./a.out
     pi =    3.141593    
     x =   -1.000000    
     y =    3.141593    

gives single precision results, but we can obtain double precisions with::

    $ gfortran -fdefault-real-8 builtinfcns2.f90
    $ ./a.out
     pi =    3.14159265358979     
     x =   -1.00000000000000     
     y =    3.14159265358979     

Note that if you plan to do this you might want to define a Unix alias, e.g.  ::

    $ alias gfort="gfortran -fdefault-real-8"

so you can just type::

    $ gfort builtinfcns2.f90
    $ ./a.out
     pi =    3.14159265358979
     x =   -1.00000000000000
     y =    3.14159265358979

Such an alias could be put in your :ref:`bashrc`.

We'll also see how to specify compiler flags easily in a :ref:`makefile`.


.. _fortran_arrays:

Fortran Arrays
--------------

Note that arrays are indexed starting at 1 by default, rather than 0 as in
Python.  Also note that components of an array are accessed using
parentheses, not square brackets!

Arrays can be dimensioned and used as in the following example:  

.. literalinclude:: ../codes/fortran/array1.f90
   :language: fortran
   :linenos:

Compiling and running this code gives the output::

 A = 
   2.00000000000000        3.00000000000000     
   3.00000000000000        4.00000000000000     
   4.00000000000000        5.00000000000000     
 x = 
   1.00000000000000        1.00000000000000     
 b = 
   5.00000000000000        7.00000000000000        9.00000000000000     

*Comments:*

  * In printing `A` we have used a *slice* operation: `A(i,:)`
    refers to the i'th row of `A`.  In Fortran 90 there are many other
    array operations that can be done more easily than we have done in
    the loops above.  We will investigate this further later.

  * Here we set the values of `m,n` as integer parameters before
    declaring the arrays `A,x,b`.  Being parameters means we can not
    change their values later in the program.

  * It is possible to declare arrays and determine their size later,
    using `allocatable` arrays, which we will also see later.


There are many array operations you can do, for example:

.. literalinclude:: ../codes/fortran/vectorops.f90
   :language: fortran
   :linenos:

produces::

     x = 
       10.0000000000000        20.0000000000000        30.0000000000000     
     x**2 + y = 
       200.000000000000        800.000000000000        1800.00000000000     
     x*y = 
       1000.00000000000        8000.00000000000        27000.0000000000     
     sqrt(y) = 
       10.0000000000000        20.0000000000000        30.0000000000000     
     dot_product(x,y) = 
       36000.0000000000     


Note that addition, multiplication, exponentiation, and intrinsic functions
such as `sqrt` all apply component-wise. 

Multidimensional arrays can be manipulated in similar manner.  
The produce to two arrays when computed with `*` is always component-wise.
For matrix multiplication, use `matmul`.   There is also a `transpose`
function:

.. literalinclude:: ../codes/fortran/arrayops.f90
   :language: fortran
   :linenos:

produces::

     a = 
       1.00000000000000        4.00000000000000     
       2.00000000000000        5.00000000000000     
       3.00000000000000        6.00000000000000     

     b = 
       1.00000000000000        2.00000000000000        3.00000000000000     
       4.00000000000000        5.00000000000000        6.00000000000000     

     c = 
       17.0000000000000        22.0000000000000        27.0000000000000  
       22.0000000000000        29.0000000000000        36.0000000000000 
       27.0000000000000        36.0000000000000        45.0000000000000

     x =    5.00000000000000        6.00000000000000
     y =    29.0000000000000        40.0000000000000        51.0000000000000  

.. _fortran_loops:


Loops
-----

.. literalinclude:: ../codes/fortran/loops1.f90
   :language: fortran
   :linenos:

The `while` statement used in the last example is considered obsolete.  It
is better to use a `do` loop with an `exit` statement if a condition is
satisfied.  The last loop could be rewritten as::

   i = 0
   do                 ! prints 0,1,2,3,4
      if (i>=5) exit
      print *, i
      i = i+1
      enddo

This form of the `do` is valid but is generally not a good idea.
Like the while loop, this has the danger that a bug in the code may
cause it to loop forever (e.g. if you typed `i = i-1` instead of `i = i+1`).

A better approach for loops of this form is to limit the number of iterations
to some maximum value (chosen to be ample for your application), and then
print a warning message, or take more drastic action, if this is exceeded, e.g.:

.. literalinclude:: ../codes/fortran/loops2.f90
   :language: fortran
   :linenos:

Note: `j` is incremented *before* comparing to `jmax`.

.. _fortran_if:

if-then-else
------------

.. literalinclude:: ../codes/fortran/ifelse1.f90
   :language: fortran
   :linenos:

Comments:
 
 * The `else` clause is optional

 * You can have optional `else if` clauses

There is also a one-line form of an `if` statement that was seen in a
previous example on this page::

    if (i>=5) exit

This is equivalent to::

    if (i>=5) then
        exit
        endif

Booleans
--------

 * Compare with `<, >, <=, >=, ==, /=`. You can also use the older Fortran 77
   style: `.lt., .gt., .le., .ge., .eq., .neq.`.

 * Combine with `.and.` and `.or.`

For example::

    ((x>=1.0) .and. (x<=2.0)) .or. (x>5)

A boolean variable is declared with type `logical` in Fortran, as for
example in the following code:

.. literalinclude:: ../codes/fortran/boolean1.f90
   :language: fortran
   :linenos:

Further reading
---------------

 * :ref:`fortran_sub`

 * :ref:`fortran_taylor`

 * `Fortran Resources page <http://www.personal.psu.edu/hdk/fortran.html>`_
