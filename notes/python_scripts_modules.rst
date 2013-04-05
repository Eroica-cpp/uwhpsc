
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

Consider this script,  found in $CLASSHG/python/script1.py:

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

Or, you can `import` the file as a module::

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

