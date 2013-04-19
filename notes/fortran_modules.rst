
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

The line::

        use <MODULE-NAME> 

can be replaced by::

        use <MODULE-NAME>, only: <LIST OF SYMBOLS>

to specify that only certain variables/subroutines/functions from the module
should be used.  Doing it this way also makes it clear exactly what symbols
are coming from which module in the case where you *use* several modules.


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

Note: that a parameter can be defined with a specific value that will then be 
available to all program units using the module.

.. _module_variables:

Module variables
-----------------

It is also possible to declare *variables* that can be shared between all
program units using the module.  This is a way to define "global variables"
that might be set in one program unit and used in another, without the need
to pass the variable as a subroutine or function argument.  
Module variables can be defined in a module and the Fortran statement ::

    save

is used to indicate that variables defined in the module should have values
saved between one use of the module to another.  You should generally
specify this if you use any module variables.


Here is another version of the circles code that stores *pi* as a module
variable rather than a parameter:


.. literalinclude:: ../codes/fortran/circles2/circle_mod.f90
   :language: fortran
   :linenos:

In this case we also need to initialize the variable *pi* by means of a 
subroutine such as:

.. literalinclude:: ../codes/fortran/circles2/initialize.f90
   :language: fortran
   :linenos:

These might be used as follows in a main program:

.. literalinclude:: ../codes/fortran/circles2/main.f90
   :language: fortran
   :linenos:

This example can be compiled and executed by going into the directory
`$UWHPSC/fortran/circles2/` and typing::

    $ gfortran circle_mod.f90 initialize.f90 main.f90 -o main.exe
    $ ./main.exe

Or by using the Makefile in this directory::

    $ make main.exe
    $ ./main.exe

Here is the Makefile:

.. literalinclude:: ../codes/fortran/circles2/Makefile
   :language: make
   :linenos:

For more about Makefiles, see :ref:`makefiles` and :ref:`biblio_make`.
