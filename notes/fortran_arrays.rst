
.. _fortran_arrays:

=============================================================
Array storage in Fortran
=============================================================


When an array is declared in Fortran, a set of storage locations in memory
are set aside for the storage of all the values in the array.  How many
bytes of memory this requires depends on how large the array is and what
data type each element has. If the array is declared *allocatable* then the
declaration only determines the *rank* of the array (the number of
indices it will have), and memory is not actually allocated until the
`allocate` statement is encountered.  

By default, arrays in Fortran are indexed starting at 1. So if you declare::

    real(kind=8) :: x(3)

or equivalently::

    real(kind=8), dimension(3) :: x

for example, then the elements should be referred to as `x(1), x(2),` and
`x(3)`.

You can also specify a different starting index, for example here are
several arrays of length 3 with different starting indices::

    real(kind=8) :: x(0:2), y(4:6), z(-2:0)

A statement like

    x(0) = z(-1)

would then be valid.


Arrays in Fortran occupy successive memory locations starting at some
address in memory, say `istart`, and increasing by some constant number for
each element of the array.  For example, for an array of `real (kind=8)` values
the byte-address would increase by 8 for each successive element.  As
programmers we don't need to worry much about the actual addresses, but it
is important to understand how arrays are laid out in memory, particularly
if the rank of the array (number of indices) is larger than 1, as discussed
below in Section :ref:`fortran_arrays_hirank`.

Passing rank 1 arrays to subroutines, Fortran 77 style
------------------------------------------------------

Even for arrays of rank 1, it is sometimes useful to remember that to a
Fortran compiler an array is often specified simply the the memory address
of the first component.  This helps explain the strange behavior of the
following program:

.. literalinclude:: ../codes/fortran/arraypassing1.f90
   :language: fortran
   :linenos:

which produces the output::

 x =    5.00000000000000     
 y =    5.00000000000000     
 i =   1075052544
 j =            0

The address of `x` is passed to the subroutine, which interprets it as the
address of the starting point of an array of length 3.  The subroutine sets
the value of `x` to 5 and also sets the values of the next 2 memory
locations (based on 8-byte real numbers) to 5.  Because `y`, `i`, and `j`
were declared after `x` and hence happen to occupy memory after `x`, 
these values are corrupted by the subroutine.   

Note that integers are stored in 4 bytes so both `i` and `j` are covered by
the single 8-bytes interpreted as `a(3)`.  Storing a value as
an 8-byte float and then interpreting  the two halfs as
integers (when `i` and `j` are
printed) is likely to give nonsense.

It is also possible to make the code crash by improperly accessing memory.  
(This is actually be better than just producing nonsense with no
warning, but figuring out *why* the code crashed may be difficult.)

If you change the dimension of `a` from 3 to 1000 in the subroutine above:

.. literalinclude:: ../codes/fortran/arraypassing2.f90
   :language: fortran
   :linenos:

then the code produces::

  Segmentation fault

This means that the subroutine attempted to write into a memory location
that it should not have access to.  A small number of memory locations were
reserved for data when the variables `x,y,i,j` were declared.  No new memory
is allocated in the subroutine -- the statement ::

    real(kind=8), intent(inout) :: a(1000)

simply declares a `dummy argument` of rank 1.  This statement could be
replaced by ::

    real(kind=8), intent(inout) :: a(:)

and the code would still compile and give the same results.  The starting
address of a set of storage locations is passed into the subroutine and the
location of any element in the array is computed from this, whether or not
it actually lies in the array as it was declared in the calling program!

The programs above are written in Fortran 77 style.  
In Fortran 77, every subroutine or function is compiled independently of
others with no way to check that the arguments passed into a subroutine
actually agree in type with the dummy arguments used in the subroutine.
This is a limitation that often leads to debugging nightmares.

Luckily Fortran 90 can help reduce these problems, since it is possible to
create an `interface` that provides more information about the arguments
expected.  Here's one simple way to do this for the code above:

.. literalinclude:: ../codes/fortran/arraypassing3.f90
   :language: fortran
   :linenos:

Trying to compile this code produces an error message::

    $ gfortran arraypassing3.f90
    arraypassing3.f90:14.17:

        call setvals(x)
                    1
    Error: Type/rank mismatch in argument 'a' at (1)

Now at least the compiler recognizes that an array is expected 
rather than a single
value.  But it is still possible to write a code that compiles and produces
nonsense by declaring `x` and `y` to be rank 1 arrays of length 1:

.. literalinclude:: ../codes/fortran/arraypassing4.f90
   :language: fortran
   :linenos:

The compiler sees that an object of the correct type (a rank 1 array) is
being passed and does not give an error.  Running the code gives ::

 x =    5.00000000000000     
 y =    5.00000000000000     
 i =   1075052544
 j =            0


You might hope that using the gfortran flag `-fbounds-check` (see
:ref:`gfortran_flags`) would catch such bugs.  Unfortunately it does not.  It
will catch it if you refer to `x(2)` in the main program of the code just
given, where it knows the length of `x` that was declared, but not in the
subroutine.

.. _fortran_arrays_hirank:

Fortran arrays of higher rank
-----------------------------

Suppose we declare `A` to be a rank 2 array with 3 rows and 4 columns,
which we might want to do to store a 3 by 4 matrix.

    real(kind=8) :: A(3,4)

Since memory is laid out linearly (each location has a single address, not a
set of indices), the compiler must decide how to map the 12
array elements to memory locations.

Unfortunately different languages use different conventions.  In Fortran
arrays are stored *by column* in memory, so the 12 consecutive memory
locations would correspond to::

    A(1,1)
    A(2,1)
    A(3,1)
    A(1,2)
    A(2,2)
    A(3,2)
    A(1,3)
    A(2,3)
    A(3,3)
    A(1,4)
    A(2,4)
    A(3,4)

To illustrate this, consider the following program.  It declares an array
`A` of shape (3,4) and a rank-1 array `B` of length 12.  It also uses the
Fortran `equivalence` statement to tell the compiler that these two arrays
should point to the *same* locations in memory.  This program shows that
`A(i,j)` is the same as `B(3*(j-1) + i)`:


.. literalinclude:: ../codes/fortran/rank2.f90
   :language: fortran
   :linenos:

This program produces::

    Row 1 of A contains:              10.0  40.0  70.0 100.0
    Row 1 is in locations  1  4  7 10
    These elements of B contain:      10.0  40.0  70.0 100.0

    Row 2 of A contains:              20.0  50.0  80.0 110.0
    Row 2 is in locations  2  5  8 11
    These elements of B contain:      20.0  50.0  80.0 110.0

    Row 3 of A contains:              30.0  60.0  90.0 120.0
    Row 3 is in locations  3  6  9 12
    These elements of B contain:      30.0  60.0  90.0 120.0


Note also that the `reshape` command used in Line 10 of this program takes
the set of values and assigns them to elements of the array *by columns*.
Actually it just puts these values into the 12 memory elements used for the
matrix one after another, but because of the way arrays are interpreted,
this corresponds to filling the array by columns.

Note some other things about this program:

 * Lines 10, 13, 15, and 17 use an `implied do` construct, in which `i` or `j`
   loops over the values specified.

 * Lines 14, 16, and 18 are *format statements* and these formats are used
   in the lines preceding them instead of the default format `*`.
   For more about formatted I/O see :ref:`fortran_io`.

In C or Python, storage is *by rows* instead, so the 12 consecutive
memorylocations would correspond to::

    A(1,1)
    A(1,2)
    A(1,3)
    A(2,1)
    etc.


Why do we care how arrays are stored?
-------------------------------------

The layout of arrays in memory
is often important to know when doing high-performance computing, as we
will see when we discuss cache properties.

It is also important to know this in order to understand older Fortran
programs.  When an array of rank 2 is passed to a subroutine, the subroutine
needs to know not only that the array has rank 2, but also what the *leading
dimension* of the array is, the number of rows.  In older codes this value
is often passed in to a subroutine along with the array.  In Fortran 90 this
can be avoided if there is a suitable interface, for example if the
subroutine is in a module.

As we saw above, the `(i,j)` element of the 3 by 4 array `A` is in location
`(3*(j-1) + i)`.  The same would be true for a 3 by 5 array or a 3 by 1000
array.  More generally, if the array is `nrows` by `ncols`, then the `(i,j)`
element is in location `nrows*(j-1) + i` and so the value of `nrows` must be
known by the compiler in order to translate the indices `(i,j)` into the
propoer storage location.  


