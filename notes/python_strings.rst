
.. _python_strings:

=============================================================
Python strings
=============================================================

See this `List of methods applicable to strings <http://docs.python.org/release/2.5.2/lib/string-methods.html>`_

String formatting
-----------------

Often you want to construct a string that incorporates the values of some
variables.  This can be done using the form *format % values* where *format*
is a string that describes the desired format and *values* is a single value
or tuple of values that go into various slots in the format.

See `String Formatting Operations
<http://docs.python.org/release/2.5.2/lib/typesseq-strings.html>`_

This is best learned from some examples::

    >>> x = 45.6
    >>> s = "The value of x is %s"  % x
    >>> s
    'The value of x is 45.6'

The *%s* in the format string means to convert x to a string and insert into
the format.  It will use as few spaces as possible.

    >>> s = "The value of x is %21.14e"  % x
    >>> s
    'The value of x is  4.56000000000000e+01'

In the case above, exponential notation is used with 14 digits to the right
of the decimal point, put into a field of 21 digits total.  (You need at
least 7 extra characters 
to leave room for a possible minus sign as well as the first
digit, the decimal point, and the exponent such as *e+01*.

    >>> y = -0.324876
    >>> s = "Now x is %8.3f and y is %8.3f" % (x,y)
    >>> s
    'Now x is   45.600 and y is   -0.325'


In this example, fixed notation is used instead of scientific notation, with
3 digits to the right of the decimal point, in a field 8 characters wide.
Note that *y* has been rounded.

In the last example, two variables are inserted into the format string.


Further reading
---------------

See  also:

* `<http://docs.python.org/tutorial/inputoutput.html>`_

* `List of methods applicable to strings <http://docs.python.org/release/2.5.2/lib/string-methods.html>`_

* `Input and Output documentation
  <http://docs.python.org/2/tutorial/inputoutput.html>`_
