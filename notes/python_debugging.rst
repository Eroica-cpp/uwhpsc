
.. _python_debugging:

=============================================================
Python debugging
=============================================================

For some general tips on writing and debugging programs in any language, see
:ref:`debugging`.


Python IDEs
-----------

An IDE (Integrated Development Environment) generally provides an editor and
debugger that are linked directly to the language.   See
 * `<http://en.wikipedia.org/wiki/Integrated_development_environment>`_.

Python has a IDE called IDLE that
provides an editor that has some debugger features.  You might want to
explore this, see 
 * `<http://docs.python.org/library/idle.html>`_.

Other IDEs also provided Python interfaces, such as Eclipse.
See, e.g., 
  * `<http://en.wikipedia.org/wiki/Eclipse_(software)>`_
  * `<http://www.vogella.de/articles/Python/article.html>`_
  * `<http://heather.cs.ucdavis.edu/~matloff/eclipse.html>`_

These environments generally provide an interface to `pdb`, the Python
debugger described below.

Reloading modules
-----------------

Note that if you are debugging a Python code by running it repeatedly in an
interactive shell, you need to make sure it is seeing the most recent
version of the code after you make editing changes.  If you run it using
`execfile` (or `run` in IPython), it should find the most recent version.

If you import it as a module, then you need to make sure you do a `reload`
as described at :ref:`python_reload`.


Print statements
----------------

Print statements can be added almost anywhere in a Python code to print
things out to the terminal window as it goes along.  

You might want to put some special symbols in debugging statements to flag
them as such, which makes it easier to see what output is your debug output
and also makes it easier to find them again later to remove from the code,
e.g. you might use "+++" or "DEBUG".  

As an example, suppose you are trying to better understand Python namespaces
and the difference between local and global variables.  Then this code might
be useful:

.. literalinclude:: ../codes/python/debugdemo1a.py
   :language: python
   :linenos:

Here the print function in the definition of `f(x)` is being used for
debugging purposes.
Executing this code gives::

    >>> execfile("debugdemo1a.py")
    +++ before calling f: x = 3.0, y = -22.0
    +++ in function f: x = 13.0, y = -22.0, z = 3.0
    +++ after calling f: x = 3.0, y = 13.0


If you are printing large amounts you might want to write to a file rather
than to the terminal, see :ref:`python_io`.

.. _pdb:

pdb debugger
------------

Inserting print statements may work best in some situations, but it is often
better to use a *debugger*.  The Python debugger pdb is very easy to use,
often even easier than inserting print statements and well worth learning.
See the `pdb documentation <http://docs.python.org/2/library/pdb.html>`_
for more information.


You can insert *breakpoints* in your code where control should pass back to
the user, at which point you can query the value of any variable, or step
through the program line by line from this point on.   For the above example
we might do this as below:


.. literalinclude:: ../codes/python/debugdemo1b.py
   :language: python
   :linenos:

Of course one could set multiple breakpoints with other `pdb.set_trace()`
commands.

Now we get the prompt for the `pdb` shell when we hit the breakpoint::

    >>> execfile("debugdemo1b.py")

    > /Users/rjl/uwhpsc/codes/python/debugdemo1b.py(11)f()
    -> return x

    (Pdb) p x
    13.0
    (Pdb) p y
    -22.0
    (Pdb) p z
    3.0


Note that `p` is short for `print`.  You could also type `print x` but this
would then execute the Python print command instead of the debugger command
(though in this case it would print the same thing).

There are many other `pdb` commands,
such as `next` to execute the next line, `continue` to continue executing
until the next breakpoint, etc.  See the documentation for more details.

For example, lets execute the next two statements and then print `x` and `y`::

    (Pdb) n
    --Return--
    > /Users/rjl/uwhpsc/codes/python/debugdemo1b.py(11)f()->13.0
    -> return x

    (Pdb) n
    > /Users/rjl/uwhpsc/codes/python/debugdemo1b.py(15)<module>()
    -> print "x = ",x

    (Pdb) p x,y
    (3.0, 13.0)

    (Pdb) p z
    *** NameError: NameError("name 'z' is not defined",)

    (Pdb) quit
    >>>


You can also run the code as a script from the Unix prompt and again you
will be put into the pdb shell when the breakpoint is reached::

    $ python debugdemo1b.py
    > /Users/rjl/uwhpsc/codes/python/debugdemo1b.py(11)f()
    -> return x
    (Pdb) p z
    3.0
    (Pdb) continue
    x =  3.0
    y =  13.0



Debugging after an exception occurs
-----------------------------------

Often code has bugs that cause an exception to be raised that causes the
program to halt execution. Consider the following file:


.. literalinclude:: ../codes/python/debugdemo2.py
   :language: python
   :linenos:

If you change N to 20 it will run fine, but with `N = 40` we find::

    >>> execfile("debugdemo2.py")
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
      File "debugdemo2.py", line 14, in <module>
        w[i] = 1/eps2
    ZeroDivisionError: float division

At some point `eps2` apparently has the value 0.  To figure out when this
happens, we could insert a `pdb.set_trace()` command in the loop and step
through it until the error occurs and then look at `i`, but we can do so
even more easily using a *post-mortem* analysis after it dies, using
`pdb.pm()`::

    >>> import pdb
    >>> pdb.pm()
    > /Users/rjl/uwhpsc/codes/python/debugdemo2.py(14)<module>()->None
    -> w[i] = 1/eps2
    (Pdb) p i
    34
    (Pdb) p eps2
    0.0
    (Pdb) p epsilon
    5.9962169748381002e-17

This starts up `pdb` at exactly the point where the exception is about to
occur.  We see that the divide by zero happens when `i = 34` (because
`epsilon` is so small that `1. + epsilon` is rounded off to `1.` in the
computer, see :ref:`floats`).

Using pdb from IPython
----------------------

In IPython it's even easier to do this post-mortem analysis.  Just type::

    In [50]: pdb
    Automatic pdb calling has been turned ON


and then `pdb` will be automatically invoked if an exception occurs:: 

    In [51]: run debugdemo2.py
    ---------------------------------------------------------------------------

    ZeroDivisionError: float division
    > /Users/rjl/uwhpsc/codes/python/debugdemo2.py(14)<module>()
         13     eps2 = z - 1.         # expect eps2 == epsilon?
    ---> 14     w[i] = 1/eps2
         15 

    ipdb> p i
    34
    ipdb> q

    In [52]: 

Type `pdb` again to turn it off.  

Note: `pdb`, like `run` is a `magic function` in IPython, an extension of
the language itself, type `magic` at the IPython prompt for more info.

If these commands don't work, type `%magic` and read this documentation.

Other pdb commands
------------------

There are a number of other commands, see the references above.

