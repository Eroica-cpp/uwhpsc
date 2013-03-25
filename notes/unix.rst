

.. _unix:

=============================================================
Unix, Linux, and OS X
=============================================================

A brief introduction to Unix shells appears in the section :ref:`shells`.
Please read that first before continuing here.

There are many Unix commands and most of them have many optional arguments
(generally specified by adding something like -x after the command name,
where x is some letter).   Only a few important commands are reviewed here.
See the references (e.g. [Wikipedia-unix-utilities]_)
for links with many more details.

pwd and cd
----------

The command name *pwd* stands for "print working directory" and tells you
the full path to the directory you are currently working in, e.g.::

     $ pwd
     /Users/rjl/uwhpsc


To change directories, use the *cd* command, either relative to the current
directory, or as an absolute path (starting with a "/", like the output of
the above pwd command).  To go up one level::

    $ cd ..
    $ pwd
    /Users/rjl


ls
----

*ls* is used to list the contents of the current working directory.
As with many commands, *ls* can take both *arguments* and *options*.  An
option tells the shell more about what you want the command to do, and is
preceded by a dash, e.g.::

    $ ls -l

The *-l* option tells *ls* to give a long listing that contains additional
information about each file, such as how large it is, who owns it, when it
was last modified, etc.   The first 10 mysterious characters tell who has
permission to read, write, or execute the file, see `[Wikipedia]
<http://en.wikipedia.org/wiki/File_system_permissions>`_.


Commands often also take *arguments*, just like a function takes an argument
and the function value depends on the argument supplied.  In the case of
*ls*, you can specify a list of files to apply *ls* to. For example, if we
only want to list the information about a specific file::

    $ ls -l fname

You can also use the *wildcard* * character to match more than one file::

    $ ls *.x

If you type

        $ ls -F

then directories will show up with a trailing / and executable files with a
trailing asterisk, useful in distinguishing these from ordinary files.

When you type *ls* with no arguments it generally shows most files and
subdirectories, but may not show them all.  By default it does not show
files or directories that start with a period (dot).  These are "hidden"
files such as *.bashrc* described in Section :ref:`bashrc`.  

To list these hidden files use::

        $ ls -aF

Note that this will also list two directories *./* and *../*  These appear
in every directory and always refer to the current directory and the parent
directory up one level.  The latter is frequently used to move up one level
in the directory structure via::

        $ cd ..


For more about *ls*, try::

    $ man ls

Note that this invokes the *man* command (manual pages) with the argument
*ls*, and causes Unix to print out some user manual information about *ls*.

If you try this, you will probably get one page of information with a ':' at
the bottom.  At this point you are in a different shell, one designed to
let you scroll or search through a long file within a terminal.  The ':' is
the prompt for this shell.  The commands you can type at this point are
different than those in the Unix shell.  The most useful are::

    : q  [to quit out of this shell and return to Unix]
    : <SPACE>   [tap the Spacebar to display the next screenfull]
    : b  [go back to the previous screenfull]

more, less, cat, head, tail
---------------------------

The same technique to paging through a long file can be applied to your own
files using the *less* command (an improvement over the original *more*
command of Unix), e.g.::

    $ less filename

will display the first screenfull of the file and give the : prompt.

The *cat* command prints the entire file rather than a page at a time.
*cat* stands for "catenate" and *cat* can also be used to combine multiple
files into a single file::

    $ cat file1 file2 file3 > bigfile

The contents of all three files, in the order given, will now be in
*bigfile*.  If you leave off the "> bigfile" then the results go to the
screen instead of to a new file, so "cat file1" just prints file1 on the
screen.  If you leave off file names before ">" it takes input from the
screen until you type <ctrl>-d, as used in the example at :ref:`myhg`.

Sometimes you want to just see the first 10 lines or the last 5 lines of a
file, for example.  Try::

    $ head -10 filename
    $ tail -5 filename

removing, moving, copying files
-------------------------------

If you want to get rid of a file named *filename*, use *rm*::

    $ rm -i filename
    remove filename?

The -i flags forces *rm* to ask before deleting, a good precaution.  Many
systems are set up so this is the default, possibly by including the
following line in the :ref:`bashrc`::

    alias rm='rm -i'

If you want to force removal without asking (useful if you're removing a
bunch of files at once and you're sure about what you're doing), use the -f
flag.

To rename a file or move to a different place (e.g. a different directory)::

    $ mv oldfile newfile

each can be a full or relative path to a location outside the current
working directory.

To copy a file use *cp*::

    $ cp oldfile newfile

The original *oldfile* still exists.
To copy an entire directory structure recursively (copying all files in it
and any subdirectories the same way), use "cp -r"::

    $ cp -r olddir newdir

background and foreground jobs
------------------------------

When you run a program that will take a long time to execute, you might want
to run it in *background* so that you can continue to use the Unix command
line to do other things while it runs.  For example, suppose
*fortrancode.exe* is a Fortran executable in your current directory 
that is going to run for a long time.  You can do::

    $ ./fortrancode.exe &
    [1] 15442

if you now hit return you should get the Unix prompt back and can continue
working.
    
The ./ before the command in the example above is 
to tell Unix to run the executable in this
directory (see :ref:`paths`), and the & at the end of the line tells it to
run in background.  The "[1] 15442" means that it is background job number 1
run from this shell and that it has the *processor id* 15442.

If you want to find out what jobs you have running in background and their
pid's, try::

     $ jobs -l
     [1]+ 15443 Running                 ./fortrancode.exe &

You can bring the job back to the foreground with::

    $ fg %1

Now you won't get a Unix prompt back until the job finishes (or you put it
back into background as described below). The %1 refers to job 1.  In this
example *fg* alone would suffice since there's only one job running, but
more generally you may have several in background.

To put a job that is foreground into background, you can often type
<ctrl>-z, which will pause the job and give you the prompt back::

    ^Z
    [1]+  Stopped                 ./fortrancode.exe
    $ 

Note that the job is not running in background now, it is stopped.  To get
it running again in background, type::

    $ bg %1

Or you could get it running in foreground with "fg %1".

nice and top
------------

If you are running a code that will run for a long time you might want to
make sure it doesn't slow down other things you are doing.  You can do this
with the *nice* command, e.g.::

    $ nice -n 19 ./fortrancode.exe &

gives the job lowest priority (nice values between 1 and 19 can be used) so
it won't hog the CPU if you're also trying to edit a file at the same time,
for example.

You can change the priority of a job running in background with *renice*,
e.g.::

    $ renice -n 19 15443

where the last number is the process id.

Another useful command is *top*.  This will fill your window with a page of
information about the jobs running on your computer that are using the most
resources currently.  See :ref:`topcommand` for some examples.

.. _kill:

killing jobs
------------

Sometimes you need to kill a job that's running, perhaps because you realize
it's going to run for too long, or you gave it or the wrong input data.  Or
you may be running a program like the IPython shell and it freezes up on you
with no way to get control back.  (This sometimes happens when plotting when
you give the *pylab.show()* command, for example.)

Many programs can be killed with <ctrl>-c.  For this to work the job must be
running in the foreground, so you might need to first give the *fg* command.

Sometimes this doesn't work, like when IPython freezes.  Then try stopping
it with <ctrl>-z (which should work), find out its PID, and use the *kill*
command::

    $ jobs -l
    [1]+ 15841 Suspended               ipython

    $ kill 15841

Hit return again you with luck you will see::

    $
    [1]+ Terminated              ipython
    $ 

If not, more drastic action is needed with the -9 flag::

    $ kill -9 15841

This almost always kills a process.  Be careful what you kill.

.. _sudo:

sudo
----

A command like::

    $ sudo rm 70-persistent-net.rules

found in the section :ref:`vm` means to do the remove command as super user.
You will be prompted for your password at this point.

You cannot do this unless you are registered on a list of super users. You
can do this on the VM because the *amath583* account has sudo privileges. The
reason this is needed is that the file being removed here is a system file
that ordinary users are not allowed to modify or delete.  

Another example is seen at :ref:`apt-get`, where only those with super user
permission can install software on to the system.


.. _bash:

The bash shell
--------------

There are several popular shells for Unix.  The examples given in these
notes assume the bash shell is used.  If you think your shell is different,
you can probably just type::

    $ bash

which will start a new bash shell and give you the bash prompt.

For more information on bash, see for example 
[Bash-Beginners-Guide]_, [gnu-bash]_, [Wikipedia-bash]_.

.. _bashrc:

.bashrc file
----------------

Everytime you start a new bash shell, e.g. by the command above, or when you
first log in or open a new window (assuming bash is the default), a file
named ".bashrc" in your home directory is executed as a bash script.  You
can place in this file anything you want to have executed on startup, such
as exporting environment variables, setting paths, defining aliases, setting
your prompt the way you like it, etc.  See below for more about these
things.

.. _env:

Environment variables
---------------------

The command *printenv* will print out any environment variables you have
set, e.g.::

    $ printenv
    USER=rjl
    HOME=/Users/rjl
    PWD=/Users/rjl/uwhpsc/sphinx
    FC=gfortran
    PYTHONPATH=/Users/rjl/claw4/trunk/python:/Applications/visit1.11.2/src/lib:
    PATH=/opt/local/bin:/opt/local/sbin:/Users/rjl/bin
    etc.

You can also print just one variable by, e.g.::

    $ printenv HOME
    /Users/rjl

or::

    $ echo $HOME
    /Users/rjl

The latter form has $HOME instead of HOME because we are actually *using*
the variable in an echo command rather than just printing its value.  This
particular variable is useful for things like

    $ cd $HOME/uwhpsc

which will go to the uwhpsc subdirectory of your home directory no
matter where you start.

As part of Homework 1 you are instructed to define a new environment
variable to make this even easier,  for example by::

    $ export UWHPSC=$HOME/uwhpsc

Note there are no spaces around the =.   This defines a new environment
variable and *exports* it, so that it can be used by other programs you
might run from this shell (not so important for our purposes, but sometimes
necessary).

You can now just do::

    $ cd $UWHPSC

to go to this directory.


Note that I have set an environment variable FC as::

    $ printenv FC
    gfortran

This environment variable is used in some Makefiles (see :ref:`makefiles`)
to determine which Fortran compiler to use in compiling Fortran codes.


.. _unix_path:

PATH and other search paths
---------------------------

Whenever you type a command at the Unix prompt, the shell looks for a
program to run.  This is true of built-in commands and also new commands you
might define or programs that have been installed.  To figure out where to
look for such programs, the shell searches through the directories specified
by the PATH variable (see :ref:`env` above).  This might look something
like::

    $ printenv PATH
    PATH=/usr/local/bin:/usr/bin:/Users/rjl/bin

This gives a list of directories to search through, in order, separated by
":".   The PATH is usually longer than this, but in the above example there
are 3 directories on the path.  The first two are general system-wide
repositories and the last one is my own *bin* directory (bin stands for
binary since the executables are often binary files, though often the bin
directory also contains shell scripts or other programs in text).

.. _which:

which
-----

The *which* command is useful for finding out the full path to the code that
is actually being executed when you type a command, e.g.::

    $ which gfortran
    /usr/bin/gfortran

    $ which f77
    $

In the latter case it found no program called f77 in the search path, either
because it is not installed or because the proper diretory is not on the
PATH.

Some programs require their own path to be set if it needs to search for
input files.  For example, you can set MATLABPATH or PYTHONPATH 
to be a list of directories (separated by ":") to search for .m files 
when you execute a command in Matlab, or for .py files when you import
a module in Python.

.. _prompt:

Setting the prompt
------------------

If you don't like the prompt bash is using you can change it by changing the
environment variable PS1, e.g.::

    $ PS1='myprompt* '
    myprompt* 

This is now your prompt.  There are various special characters you can use
to specify things in your prompts, for example::

    $ PS1='[\W] \h% '
    [sphinx] aspen% 

tells me that I'm currently in a directory named sphinx on a computer named
aspen.  This is handy to keep track of where you are, and what machine the
shell is running on if you might be using ssh to connect to remote machines
in some windows.

Once you find something you like, you can put this command in your .bashrc
file.


Further reading
---------------

[Wikipedia-unix-utilities]_
