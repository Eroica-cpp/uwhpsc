
.. _python_scripts_modules:

=============================================================
Python scripts and modules
=============================================================

A Python script is a collection of commands in a file designed to be
executed like a program.  The file can of course contain functions and
import various modules, but the idea is that it will be run or executed
from the command line or from within a Python interactive shell to perform a
specific task.  Often a script first contains a set of function definitions
and then has the *main program* that might call the functions.  

Consider this script,  found in $UWHPSC/python/script1.py:

**script1.py**

.. literalinclude:: ../codes/python/script1.py
   :language: python
   :linenos:


The *main program* starts with the print statement.

There are several ways to run a script contained in a file.  

At the Unix prompt::

     $ python script1.py
         x        f(x)
       0.000     1.000
       2.000     5.000
       4.000    17.000

From within Python::

    >>> execfile("script1.py")
    [same output as above]

From within IPython, using either `execfile` as above, or `run`::

    In [48]: run script1.py
    [same output as above]

Or, you can `import` the file as a module (see :ref:`importing_modules`
below for more about this)::

    >>> import script1
         x        f(x)
       0.000     1.000
       2.000     5.000
       4.000    17.000

Note that this also gives the same output.  Whenever a module is imported,
any statements that are in the main body of the module are executed when it
is imported.  In addition, any variables or functions defined in the file
are available as attributes of the module, e.g., ::

    >>> script1.f(4)
    17.0

    >>> script1.np
    <module 'numpy' from
    '/Library/Python/2.5/site-packages/numpy-1.4.0.dev7064-py2.5-macosx-10.3-fat.egg/numpy/__init__.pyc'>


Note there are some differences between executing the script and importing
it.  When it is executed as a script, 
it is as if the commands were typed at the command line.  Hence::

    >>> execfile('script1.py')
         x        f(x)
       0.000     1.000
       2.000     5.000
       4.000    17.000

    >>> f
    <function f at 0x1c0430>

    >>> np
    <module 'numpy' from
    '/Library/Python/2.5/site-packages/numpy-1.4.0.dev7064-py2.5-macosx-10.3-fat.egg/numpy/__init__.pyc'>

In this case `f` and `np` are in the namespace of the interactive session as
if we had defined them at the prompt.

.. _python_name_main:

Writing scripts for ease of importing
-------------------------------------

The script used above as an example contains a function `f(x)` that we might
want to be able to import without necessarily running the *main program*.
This can be arranged by modifying the script as follows:

**script2.py**

.. literalinclude:: ../codes/python/script2.py
   :language: python
   :linenos:

When a file is imported or executed, an attribute `__name__` is
automatically set, and has the value `__main__` only if the file is executed
as a script, not if it is imported as a module.  So we see the following
behavior::

     $ python script2.py 
         x        f(x)
       0.000     1.000
       2.000     5.000
       4.000    17.000

as with `script1.py`, but::

    >>> import script2           # does not print table

    >>> script2.__name__
    'script2'                    # not '__main__'

    >>> script2.f(4)
    17.0

    >>> script2.print_table()
         x        f(x)
       0.000     1.000
       2.000     5.000
       4.000    17.000


.. _python_reload:

Reloading modules
-----------------

When you import a module, Python keeps track of the fact that it is imported
and if it encounters another statement to import the same module will not
bother to do so again (the list of modules already import is in
`sys.modules`).  This is convenient since loading a module can be
time consuming.  So if you're debugging a script using `execfile` or `run`
from an IPython shell, each time you change it and then re-execute it will
not reload `numpy`, for example.

Sometimes, however, you want to force reloading of a module, in particular
if it has changed (e.g. when we are debugging it).  

Suppose, for example, that we modify `script2.py` so
that the quadratic function is changed from `y = x**2 + 1 ` to 
`y = x**2 + 10`.  
If we make this change and then try the following (in the same Python
session as above, where `script2` was already imported as a module)::

    >>> import script2

    >>> script2.print_table()
         x        f(x)
       0.000     1.000
       2.000     5.000
       4.000    17.000

we get the same results as above, even though we changed `script2.py`.  

We have to use the `reload` command to see the change we want::

    >>> reload(script2)
    <module 'script2' from 'script2.py'>

    >>> script2.print_table()
         x        f(x)
       0.000    10.000
       2.000    14.000
       4.000    26.000

.. _python_argv:

Command line arguments
----------------------

We might want to make this script a bit fancier by adding an optional argument
to the `print_table` function to print a different number of points, rather
than the 3 points shown above.

The next version has this change, and also has a modified version of the
main program that allows the user to specify this value `n` as a command
line argument:

**script3.py**

.. literalinclude:: ../codes/python/script3.py
   :language: python
   :linenos:

Note that:

 * The function `sys.argv` from the `sys` module returns the arguments that
   were present if the script is executed from the command line.  It is a
   list of strings, with `sys.argv[0]` being the name of the script itself,
   `sys.argv[1]` being the next thing on the line, etc. (if there were more
   than one command line argument, separated by spaces).

 * We use `int(sys.argv[1])` to convert the argument, if present, from a 
   string to an integer.

 * We put this conversion in a try-except block in case the user gives an
   invalid argument.

Sample output::

    $ python script3.py
         x        f(x)
       0.000     1.000
       2.000     5.000
       4.000    17.000

    $ python script3.py 5
         x        f(x)
       0.000     1.000
       1.000     2.000
       2.000     5.000
       3.000    10.000
       4.000    17.000

    $ python script3.py 5.2
    *** Error: expect an integer n as the argument

.. _importing_modules:

Importing modules
-----------------

When Python starts up there are a certain number of basic commands defined
along with the general syntax of the language, but most useful things needed
for specific purposes (such as working with webpages, or solving linear
systems) are in *modules* that do not load by default.  Otherwise it would
take forever to start up Python, loading lots of things you don't plan to
use.  So when you start using Python, either interactively or at the top of
a script, often the  first thing you do is *import* one or more modules.

A Python module is often defined simply by grouping a set of parameters and
functions together in a single .py file.  
See :ref:`python_scripts_modules` for some examples.

Two useful modules are *os* and *sys* that help you interact with the
operating system and the Python system that is running.  These are standard
modules that should be available with any Python implementation, so you
should be able to import them at the Python prompt::

    >>> import os, sys

Each module contains many different functions and parameters which are the
*methods* and *attributes* of the module.   Here we will only use a couple
of these.  The
*getcwd* method of the os module is called to return the "current working
directory"  (the same thing *pwd* prints in Unix), e.g.::

    >>> os.getcwd()
    /home/uwhpsc/uwhpsc/codes/python

Note that this function is called with no arguments, but you need the open
and close parens.  If you type "os.getcwd" without these, Python will
instead print what type of object this function is::

    >>> os.getcwd
    <built-in function getcwd>

.. python_path:

The Python Path
---------------

The *sys* module has an attribute *sys.path*, a variable that is set by
default to the search path for modules.  Whenever you perform an *import*,
this is the set of directories that Python searches through looking for a
file by that name (with a .py extension).  If you print this, you will see a
list of strings, each one of which is the full path to some directory.
Sometimes the first thing in this list is the empty string, which means "the
current directory", so it looks for a module in your working directory first
and if it doesn't find it, searches through the other directories in order:

    >>> print sys.path
    ['', '/usr/lib/python2.7', ....]

If you try to import a module and it doesn't find a file with this name on
the path, then you will get an import error::

    >>> import junkname
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    ImportError: No module named junkname

When new Python software such as NumPy or SciPy is installed, the
installation script should modify the path appropriately so it can be found.
You can also add to the path if you have your own directory that you want
Python to look in, e.g.::

    >>> sys.path.append("/home/uwhpsc/mypython")

will append the directory indicated to the path.  To avoid having to do this
each time you start Python, you can set a Unix environment variable that
is used to modify the path every time Python is started.  First print out
the current value of this variable::

    $ echo $PYTHONPATH

It will probably be blank unless you've set this before or have installed
software that sets this automatically.  
To append the above example directory to this path::

    $ export PYTHONPATH=$PYTHONPATH:/home/uwhpsc/mypython

This appends another directory to the search path already specified (if any).
You can repeat this multiple times to add more directories, or put something
like::

    export PYTHONPATH=$PYTHONPATH:dir1:dir2:dir3

in your *.bashrc* file if there are the only 3 personal 
directories you always want to search.


Other forms of import
----------------------------------------

If all we want to use from the *os* module is *getcwd*, then another option
is to do::

    >>> from os import getcwd
    >>> getcwd()
    '/Users/rjl/uwhpsc/codes/python'

In this case we only imported one method from the module, not the whole
thing.  Note that now *getcwd* is called by just giving the name of the
method, not *module.method*.  The name *getcwd* is
now in our *namespace*.  If we only imported *getcwd* and tried typing 
"os.getcwd()" we'd get an error, since it wouldn't find *os* in our
namespace.

You can rename things when you import them, which is sometimes useful if
different modules contain different objects with the same name.
For example, to compare how the `sqrt` function in the standard Python math
module compares to the numpy version::

    >>> from math import sqrt as sqrtm
    >>> from numpy import sqrt as sqrtn

    >>> sqrtm(-1.)
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    ValueError: math domain error

    >>> sqrtn(-1.)
    nan

The standard function gives an error whereas the *numpy* version returns
*nan*, a special *numpy* object representing "Not a Number".


You can also import a module and give it a different name locally.  This is
particularly useful if you import a module with a long name, but even for
*numpy* many examples you'll find on the web abbreviate this as *np*
(see :ref:`numerical_python`)::

    >>> import numpy as np
    >>> theta = np.linspace(0., 2*np.pi, 5)
    >>> theta
    array([ 0.        ,  1.57079633,  3.14159265,  4.71238898,  6.28318531])

    >>> np.cos(theta)
    array([  1.00000000e+00,   6.12323400e-17,  -1.00000000e+00, -1.83697020e-16,   1.00000000e+00])

If you don't like having to type the module name repeatedly you can import
just the things you need into your namespace::

    >>> from numpy import pi, linspace, cos
    >>> theta = linspace(0., 2*pi, 5)
    >>> theta
    array([ 0.        ,  1.57079633,  3.14159265,  4.71238898,  6.28318531])
    >>> cos(theta)
    array([  1.00000000e+00,   6.12323400e-17,  -1.00000000e+00, -1.83697020e-16,   1.00000000e+00])


If you're going to be using lots of things form *numpy* you might want to
import everything into your namespace::

    >>> from numpy import *

Then *linspace*, *pi*, *cos*, and several hundred other things will be available
without the prefix.

When writing code it is often best to not do this, however, since then it is
not clear to the reader (or even to the programmer sometimes)
what methods or attributes are coming from which module if several
different modules are being used. (They may define methods with the same
names but that do very different things, for example.)

When using IPython, it is often convenient to start it with::

    $ ipython --pylab

This automatically imports everything from *numpy* into the namespace, and
also all of the plotting tools from *matplotlib*.  

Further reading
----------------

`Modules section of Python documentation
<http://docs.python.org/2/tutorial/modules.html>`_
