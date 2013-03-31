
.. _shells:

=======
Shells
=======

A shell is a program that allows you to interact with the computer's
operating system or some software package by typing in commands.  The shell
interprets (parses) the commands and typically immediately performs some
action as a result.  Sometimes a shell is called a *command line interface*
(CLI), as opposed to a *graphical user interface* (GUI), which generally is
more point-and-click.

On a Windows system, most people use the point-and-click approach,
though it is also possible to open a window in command-line mode
for its DOS operating system. Note that DOS is different from Unix, and 
we will *not* be using DOS.  Using :ref:`cygwin` is one way to get a
unix-like environment on Windows, but if have a Windows PC, we
recommend that you use one of the other options listed in
:ref:`software_installation`.

On a Unix or Linux computer, people normally use a shell in a "terminal
window" to interact with the computer, although most flavors of Linux also
have point-and-click interfaces depending on what "Window manager" is being
used.  

On a Mac there is also the option of using a Unix shell in a terminal window
(go to Applications --> Untilities --> Terminal to open a terminal).
The Mac OS X operating system (also known as Leopard, Lion, 
etc. depending on version) is essentially a flavor of Unix.

Unix shells
-----------

See also the Software Carpentry lectures on `The Shell
<http://software-carpentry.org/4_0/shell/index.html>`_.

When a terminal opens, it shows a *prompt* to indicate that it is waiting
for input. In these notes a single $ will generally be used to indicate a
Unix prompt, though your system might give something different.  Often the
name of the computer appears in the prompt.   (See :ref:`prompt` for
information on how you can change the Unix prompt to your liking.)

Type a command at the prompt and hit return, and in general you should get
some response followed by a new prompt.  For example::

    $ pwd
    /Users/rjl/
    $

In Unix the *pwd* command means "print working directory", and the result is
the full path to the directory you are currently working in.  (Directories
are called "folders" on windows systems.)  The output above shows that on my
computer at the top level there is a directory named */Users* that has a
subdirectory for each distinct user of the computer.  The directory
*/Users/rjl* is where Randy LeVeque's files are stored, and within this we
are several levels down.  

To see what files are in the current working directory, the *ls* (list)
command can be used::

    $ ls


For more about Unix commands, see the section :ref:`unix`.

There are actually several different shells that have been developed for
Unix, which have somewhat different command names and capabilities.  Basic
commands like *pwd* and *ls* (and many others) are the same for any Unix
shell, but they more complicated things may differ.

In this class, we will assume you are using the bash shell (see :ref:`bash`).
See :ref:`unix` for more Unix commands.

------------
Matlab shell
------------

If you have used Matlab before, you are familiar with the Matlab shell,
which uses the prompt >>.  If you use the GUI version of Matlab then this
shell is running in the "Command window".  You can also run Matlab from the
command line in Unix, resulting in the Matlab prompt simply showing up in
your terminal window.  To start it this way, use the *-nojvm* option::

    $ matlab -nojvm
    >> 


------------
Python shell
------------

We will use Python extensively in this class.  For more information see the
section :ref:`python`.

Most Unix (Linux, OSX) computers have Python available by default, invoked by::

    $ python
    Python 2.7.3 (default, Aug 28 2012, 13:37:53) 
    [GCC 4.2.1 Compatible Apple Clang 4.0 ((tags/Apple/clang-421.0.60))] on darwin
    Type "help", "copyright", "credits" or "license" for more information.
    >>> 

This prints out some information about the version of Python and then gives
the standard Python prompt, >>>.  At this point you are in the Python shell
and any commands you type will be interpreted by this shell rather than the
Unix shell.  You can now type Python commands, e.g.::

    >>> x = 3+4
    >>> x
    7
    >>> x+2
    9
    >>> 4/3
    1

The last line might be cause for concern, since 4/3 is not 1.  For more
about this, see :ref:`numerical_python`.  The problem is that since 4 and 3 are
both integers, Python gives an integer result.  To get a better result,
express 4 and 3 as real numbers (called *float*s in Python) by adding
decimal points::

    >>> 4./3.
    1.3333333333333333

The standard Python shell is very basic; you can type in Python commands and
it will interpret them, but it doesn't do much else.

.. _ipython_shell:

IPython shell
-------------

A much better shell for Python is the *IPython shell*, which has
extensive documentation at [IPython-documentation]_.

Note that IPython has a different sort of prompt::

    $ ipython

    Python 2.7.2 (default, Jun 20 2012, 16:23:33) 
    Type "copyright", "credits" or "license" for more information.

    IPython 0.14.dev -- An enhanced Interactive Python.
    ?         -> Introduction and overview of IPython's features.
    %quickref -> Quick reference.
    help      -> Python's own help system.
    object?   -> Details about 'object', use 'object??' for extra details.

    In [1]: x = 4./3.

    In [2]: x
    Out[2]: 1.3333333333333333

    In [3]: 

The prompt has the form *In [n]* and any output is preceeded by 
by *Out [n]*.  IPython stores all the inputs and outputs in an array of
strings, allowing you to later reuse expressions.  

For more about some handy features of this shell, see :ref:`ipython`.

The IPython shell also is programmed to recognize many commands that are not
Python commands, making it easier to do many things.  For example, IPython
recognizes *pwd*, *ls* and various other Unix commands, e.g. to print out
the working directory you are in while in IPython, just do::

    In [3]: pwd
    
Note that IPython is not installed by default on most computers, you will
have to download it and install yourself (see [IPython-documentation]_).  It
is installed on the :ref:`vm`.

If you get hooked on the IPython shell, you can even use it as a Unix shell,
see `documentation <http://ipython.scipy.org/doc/rel-0.10/html/interactive/shell.html>`_.

Further reading
---------------

See [IPython-documentation]_

