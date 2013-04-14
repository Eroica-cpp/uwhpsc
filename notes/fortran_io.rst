

.. _fortran_io:

=============================================================
Fortran Input / Output
=============================================================

Formats vs. unformatted
-----------------------

`print` or `write` statements for output and `read` statements for input can
specify a *format* or can be *unformatted*.  

For example,  ::
    
    print *, 'x = ', x

is an *unformatted* print statement that prints a character string followed
by the value of a variable `x`.  The format used to print `x` (e.g. the
number of digits shown, the number of spaces in front) will be chosen
by the compiler based on what type of variable `x` is.  

The statements::

    i = 4
    x = 2.d0 / 3.d0
    print *, 'i = ', i, ' and x = ', x

yield::

   i =            4  and x =   0.666666666666667     

The * in the print statement tells the compiler to choose the format.

To have more control over the format, a *formatted print* statement can be
used.  A format can be placed directly in the statement in place of the * ,
or can be
written separately with a label, and the label number used in the `print`
statement.  

For example, if we wish to display the integer `i` in a *field* of
3 spaces and 
print `x` in scientific notation with 12 digits of the mantissa displayed,
in a *field* that is 18 digits wide, we could do ::

      print 600, i, x
  600 format('i = ',i3,' and x = ', e17.10)
  
This yields::

  i =   4 and x =  0.6666666667E+00

The 4 is right-justified in a field of 3 characters after the 'i = '
string.

Note that if the number doesn't fit in the field, asterisks will be printed
instead! ::

      i = 4000
      print 600, i, x

gives::

    i = *** and x =  0.6666666667E+00


Instead of using a label and writing the format on a separate line, it can
be put directly in the print statement, though this is often hard to read.
The above print statement can be written as::

  print "('i = ',i3,' and x = ', e17.10)", i, x


Writing to a file 
-----------------

Instead of printing directly to the terminal, we often want to write results
out to a file.  This can be done using the `open` statement to open a file
and attach it to a particular unit number, and then use the `write`
statement to write to this unit::

    open(unit=20, file='output.txt')
    write(20,*) i, x
    close(20)

This would do an *unformatted* write to the file 'output.txt' instead of
writing to the terminal.  The * in the write statement can be replaced by a
format, or a format label, as in the `print` statement.

There are many other optional arguments to the `open` command.

Unit numbers should generally be larger than 6.  By default, unit 6 refers
to the terminal for output, so ::

    write(6,*) i, x

is the same as ::

    print *, i, x

Reading input 
-------------

Unformatted read::

    print *, "Please input n... "
    read *, n

Reading from a file::

    open(unit=21, file="infile.txt")
    read(21,*) n
    close(21)

