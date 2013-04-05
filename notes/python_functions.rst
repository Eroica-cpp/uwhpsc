

.. _python_functions:

=============================================================
Python functions
=============================================================

Functions are easily defined in Python using *def*, for example::

    >>> def myfcn(x):
    ...     import numpy as np
    ...     y = np.cos(x) * np.exp(x)
    ...     return y
    ... 

    >>> myfcn(0.)
    1.0

    >>> myfcn(1.)
    1.4686939399158851

As elsewhere in Python, there is no begin-end notation except the
indentation.  If you are defining a function at the command line as above,
you need to input a blank line to indicate that you are done typing in the
function.  

Defining functions in modules
-----------------------------

Except for very simple functions, you do not want to type it in at the
command line in Python.  Normally you want to create a text file containing
your function and import the resulting module into your interactive session.

If you have a file named *myfile.py* for example that contains::

    def myfcn(x):
        import numpy as np
        y = np.cos(x) * np.exp(x)
        return y

and this file is in your Python search path (see :ref:`python_path`), then
you can do::

    >>> from myfile import myfcn
    >>> myfcn(0.)
    1.0
    >>> myfcn(1.)
    1.4686939399158851

In Python a function is an object that can be manipulated like any other
object.  

.. _lambda_functions:

Lambda functions
----------------

Some functions can be easily defined in a single line of code, and it is
sometimes useful to be able to define a function "on the fly" using "lambda"
notation.  To define a function that returns 2*x for any input x, rather
than::

    def f(x):
        return 2*x

we could also define *f* via::

    f = lambda x: 2*x


You can also define functions of more than one variable, e.g.::

    g = lambda x,y: 2*(x+y)


Further reading
---------------


