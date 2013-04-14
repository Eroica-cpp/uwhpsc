
.. _fortran_modules:

=============================================================
Fortran modules
=============================================================

The general structure of a Fortran module::

    module <MODULE-NAME> 
        ! Declare variables
    contains 
        ! Define subroutines or functions
    end module <MODULE-NAME>


A program or subroutine can *use* this module::

    program <NAME> 
        use <MODULE-NAME> 
        ! Declare variables 
        ! Executable statements
    end program <NAME>

A very simple module is:

.. literalinclude:: ../codes/fortran/multifile2/sub1m.f90
   :language: fortran
   :linenos:

and a program that uses this:

.. literalinclude:: ../codes/fortran/multifile2/main.f90
   :language: fortran
   :linenos:

Some reasons to use modules
---------------------------

 * Can define global variables in modules to be used in several different
   routines.

   In Fortran 77 this had to be done with common blocks — much less elegant.

 * Subroutine/function interface information is generated to aid in checking
   that proper arguments are passed.

   It’s often best to put all subroutines and functions in modules for this
   reason.

 * Can define new data types to be used in several routines.

Compiling modules
-----------------

Modules must be compiled *before* any program units that *use* the module.
When a module is compiled, a `.o` file is created, but also a `.mod` file is
created that must be present in order to compile a unit that *uses* the
module.

Circles module example
----------------------

Here is an example of a module that defines one parameter `pi` and 
two functions:


.. literalinclude:: ../codes/fortran/circles/circle_mod.f90
   :language: fortran
   :linenos:

This might be used as follows:

.. literalinclude:: ../codes/fortran/circles/main.f90
   :language: fortran
   :linenos:

This gives the following output::

 pi =    3.14159265358979     
 area for a circle of radius 2:    12.5663706143592     

Note:

 * A parameter can be defined with a specific value that will then be 
   available to all program units using the module.

 * It is also possible to declare variables that can be shared between all
   program units using the module.  But then it's not permitted to set the
   value of the variable in the module.


