
.. _topcommand:

====================
Unix ``top`` command
====================

The Unix ``top`` command is a very useful way to see what programs are
currently running on the system and how heavily they are using system
resources.  (The command is named "top" because it shows the top users
of the system.)  It is a good idea to run ``top`` to check for other
users running large programs before running one yourself on a shared
computer (such as the Applied Math servers), and you can also use it
to monitor your own programs.

Running ``top``
---------------

To run ``top``, simply type::

 $ top

at the command line.  ``top`` will fill your terminal window with a
real-time display of system status, with a summary area displaying
general information about memory and processor usage in the first few
lines, followed by a list of processes and information about them.  An
example display is shown below, with the process list truncated for
brevity::

    top - 14:45:34 up  6:32,  2 users,  load average: 0.78, 0.61, 0.59
    Tasks: 110 total,   3 running, 106 sleeping,   0 stopped,   1 zombie
    Cpu(s): 75.0%us,  0.6%sy,  0.0%ni, 24.4%id,  0.0%wa,  0.0%hi,  0.0%si,
    0.0%st
    Mem:    507680k total,   491268k used,    16412k free,    24560k buffers
    Swap:        0k total,        0k used,        0k free,   316368k cached

      PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
     2342 uwhpsc    20   0  8380 1212  796 R  300  0.2   0:28.55 jacobi2d.exe       
      842 root      20   0  100m  24m 9780 R    2  5.0 178:27.50 Xorg               
     1051 uwhpsc    20   0 40236  11m 8904 S    1  2.3   0:01.53 xfce4-terminal     
        1 root      20   0  3528 1864 1304 S    0  0.4   0:01.12 init               
        2 root      20   0     0    0    0 S    0  0.0   0:00.00 kthreadd      



Summary area
------------

The summary area shows a great deal of information about the general
state of the system.  The main highlights are the third through fifth
lines, which show CPU and memory usage.

CPU is given as percentages spent doing various tasks.  The
abbreviations have the following meanings:

* ``us`` -- time spent running non-niced user processes (most of your
  programs will fall into this category)
* ``sy`` -- time spent running the Linux kernel and its processes
* ``ni`` -- time spent running niced use processes
* ``id`` -- time spent idle
* ``wa`` -- time spent waiting for I/O

The fourth and fifth lines show the usage of physical (i.e. actual RAM
chips) and virtual memory.  The first three fields are mostly
self-explanatory, though on Linux the ``used`` memory includes disk
cache.  (Linux uses RAM that's not allocated by programs to cache data
from the disk, which can improve the computer's performance because
RAM is much faster than disk.)  ``buffers`` gives the amount
of memory used for I/O buffering, and ``cached`` is the amount used by
the disk cache.  Programs' memory allocation takes priority over
buffering and caching, so the total amount of memory available is the
sum ``free + buffers + cached``.


Task area
---------

The task area gives a sorted list of the processes currently running
on your system.  By default, the list is sorted in descending order of
CPU usage; the example display above is sorted by memory usage
instead.  Many different fields can be displayed in the task area; the
default fields are:

* ``PID``: Process ID number.  Useful for killing processes.
* ``USER``: Name of the user running the process.
* ``PR``: Relative priority of the process.
* ``NI``: Nice value of the process.  Negative nice values give a
  process higher priority, while positive ones give it lower
  priority.
* ``VIRT``: Total amount of memory used by the process.  This
  includes all code, data, and shared libraries being used.  The
  field name comes from the fact that this includes memory that has
  been swapped to disk, so it measures the total virtual memory used,
  not necessarily how much of it is currently present in RAM.
* ``RES``: Total amount of physical ("resident") memory used by the
  process.
* ``S``: Process status.  The most common values are ``S`` for
  "Sleeping" or ``R`` for "Running".
* ``%CPU``: Percent of CPU time being used by the process.  This is
  relative to a single CPU; in a multiprocessor system, it may be
  higher than 100%.
* ``%MEM``: Percent of available RAM being used by the process.  This
  does not include data that has been swapped to disk.
* ``TIME+``: Total CPU time used by the process since it started.
  This only counts the time the process has spent using the CPU, not
  time spent sleeping.
* ``COMMAND``: The name of the program.


Interactive commands
--------------------

There are many useful commands you can issue to ``top``; only a few of
them are listed here.  For more information, see the ``top`` manual
page.

======= ===========================================================================
Command Meaning
======= ===========================================================================
``q``   Quit
``?``   Help
``u``   Select processes belonging to a particular user.  Useful on shared systems.
``k``   Kill a process
``F``   Select which field to sort by
======= ===========================================================================


Further reading
---------------

For more information, see the quick reference guide at
`<http://www.oreillynet.com/linux/cmd/cmd.csp?path=t/top>`_, or type
``man top`` in a Unix terminal window to read the manual page.
