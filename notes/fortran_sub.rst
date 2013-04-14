
.. _fortran_sub:

=============================================================
Fortran subroutines and functions
=============================================================

Functions
---------

Here's an example of the use of a function:

.. literalinclude:: ../codes/fortran/fcn1.f90
   :language: fortran
   :linenos:

It prints out::

   z =    4.00000000000000     

Comments:

 * A function returns a single value.  Since this function is named `f`,
   the value of `f` must be set in the function somewhere.  You cannot use
   `f` on the right hand side of any expression, e.g. you cannot set
   `g = f` in the function.

 * f is declared `external` in the main program to let the compiler 
   know it is a function defined elsewhere rather than a variable.

 * The `intent(in)` statement tells the compiler that `x` is a variable
   passed into the function that will not be modified in the function.

 * Here the program and function are in the same file.  Later we will see
   how to break things up so each function or subroutine is in a separate
   file.

Modifying arguments
-------------------

The input argument(s) to a function might also be modified, though this is
not so common as using a subroutine as described below.  But here's an
example:

.. literalinclude:: ../codes/fortran/fcn2.f90
   :language: fortran
   :linenos:

This produces::

     Before calling f: y =    2.00000000000000     
     After calling f:  y =    5.00000000000000     
     z =    4.00000000000000     


The use of *intent*
-------------------

You are not required to specify the intent of each argument, but there are
several good reasons for doing so:

 * It helps catch bugs.  If you specify `intent(in)` and then this variable
   is changed in the function or subroutine, the compiler will give an
   error.

 * It can help the compiler produce machine code that runs faster.  For
   example, if it
   is known to the compiler that some variables will never change during
   execution, this fact can be used.

Subroutines
-----------

In Fortran, subroutines are generally used much more frequently than
functions.  Functions are expected to produce a single output variable and
examples like the one just given where an argument is modified are considered
bad programming style.

Subroutines are more flexible since they can have any number of inputs and
outputs.  In particular they may have not output variable.  For example a
subroutine might take an array as an argument and print the array to some
file on disk but not return a value to the calling program.

Here is a version of the same program  as `fcn1` above,
that instead uses a subroutine:

.. literalinclude:: ../codes/fortran/sub1.f90
   :language: fortran
   :linenos:

Comments:

 * Now we tell the compiler that `x` is an input variable and `y` is an
   output variable for the subroutine.  The `intent` declarations are
   optional but sometimes help the compiler optimize code.


Here is a version that works on an array `x` instead of a single value:

.. literalinclude:: ../codes/fortran/sub2.f90
   :language: fortran
   :linenos:

This produces::

   4.00000000000000        9.00000000000000        16.0000000000000     

Comments:

 * The length of the array is also passed into the subroutine.  You can
   avoid this in Fortran 90 (see the next example below), but it
   was unavoidable in Fortran 77 and subroutines working on arrays in
   Fortran are often written so that the dimensions are passed in as
   arguments.

Subroutine in a module
----------------------

Here is a version that avoids passing the length of the array into the
subroutine.  In order for this to work some additional *interface*
information must be specified.  This is most easily done by including the
subroutine in a *module*.

.. literalinclude:: ../codes/fortran/sub3.f90
   :language: fortran
   :linenos:

Comments:

 * See the section :ref:`fortran_modules` for more information about modules.
   Note in particular that the module must be defined first and then used
   in the program via the `use` statement.

 * The declaration of `x` in the subroutine uses `dimension(:)` to indicate
   that it is an array with a single index (having `rank 1`), 
   without specifying how long the
   array is.  If `x` was a rank 2 array indexed by `x(i,j)`
   then the dimension statement would be `dimension(:,:)`.

 * The declaration of `f` in the subroutine uses `dimension(size(x))` to
   indicate that it is an array with one index and the length of the array
   is the same as that of `x`.  In fact it would be sufficient to tell the
   compiler that it is an array of rank 1::

      real(kind=8), dimension(:), intent(out) :: f

   but indicating that it has the same size ax `x` is useful for someone
   trying to understand the code.


Further reading
---------------

 * :ref:`fortran`

 * :ref:`fortran_taylor`
