
.. _makefiles:

=============================================================
Makefiles
=============================================================

The directory `$UWHPSC/codes/fortran/multifile1` contains a Fortran code
`fullcode.f90` that consists of a main program and two subroutines:

.. literalinclude:: ../codes/fortran/multifile1/fullcode.f90
   :language: fortran
   :linenos:

To illustrate the construction of a Makefile, we first break this up into
three separate files:

.. literalinclude:: ../codes/fortran/multifile1/main.f90
   :language: fortran
   :linenos:

.. literalinclude:: ../codes/fortran/multifile1/sub1.f90
   :language: fortran
   :linenos:

.. literalinclude:: ../codes/fortran/multifile1/sub2.f90
   :language: fortran
   :linenos:


The directory `$UWHPSC/codes/fortran/multifile1` contains several Makefiles
that get successively more sophisticated to compile the codes in this
directory.

In the first version we write out explicitly what to do for each file:

.. literalinclude:: ../codes/fortran/multifile1/Makefile
   :language: make
   :linenos:

In the second version there is a general rule for creating `.o` files from
`.f90` files:

.. literalinclude:: ../codes/fortran/multifile1/Makefile2
   :language: make
   :linenos:

In the third version we define a macro `OBJECTS` so we only have to write
out this list once, which minimizes the chance of introducing errors:

.. literalinclude:: ../codes/fortran/multifile1/Makefile3
   :language: make
   :linenos:

In the fourth version, we add a Fortran compile flag (for level 3
optimization) and an linker flag (blank in this example):

.. literalinclude:: ../codes/fortran/multifile1/Makefile4
   :language: make
   :linenos:

Next we add a `phony` target `clean` 
that removes the files created when compiling
the code in order to facilitate cleanup.  It is *phony* because it does not
create a file named `clean`.

.. literalinclude:: ../codes/fortran/multifile1/Makefile5
   :language: make
   :linenos:

Finally we add a help message so that `make help` says something useful:

.. literalinclude:: ../codes/fortran/multifile1/Makefile6
   :language: make
   :linenos:

Fancier things are also possible, for example automatically detecting all
the `.f90` files in the directory to construct the list of `SOURCES`
and `OBJECTS`:

.. literalinclude:: ../codes/fortran/multifile1/Makefile7
   :language: make
   :linenos:

Further reading
---------------

* `<http://software-carpentry.org/4_0/make/>`_

* :ref:`biblio_make` in bibliography.

* `remake <http://bashdb.sourceforge.net/remake/>`_, a make debugger
 
