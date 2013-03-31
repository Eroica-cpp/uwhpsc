

.. _metrics:

=============================================================
Binary/metric prefixes for computer size, speed, etc.
=============================================================

Computers are often described in terms such as megahertz, gigabytes,
teraflops, etc.  This section has a brief summary of the meaning of these
terms.


.. _prefixes:

Prefixes
--------

Numbers associated with computers are often very large or small and so
standard scientific prefixes are used to denote powers of 10. E.g. a
kilobyte is 1000 bytes and a megabyte is a million bytes.  These prefixes
are listed below, where 1e3 for example means :math:`10^3`::

        kilo  = 1e3
        mega  = 1e6
        giga  = 1e9
        tera  = 1e12
        peta  = 1e15
         exa  = 1e18

Note, however, that in some computer contexts (e.g. size of main memory)
these prefixes refer to nearby numbers that are exactly powers of 2.
However, recent standards have given these new names::

        kibi = 2^{10} = 1024
        mebi = 2^{20} = 1048576
        etc.

So :math:`2^{20}` bytes is a *mebibyte*, abbreviated MiB.
For a more detailed discussion of this (and additional prefixes)
see `[wikipedia] <http://en.wikipedia.org/wiki/Binary_prefix>`_.

For numbers that are much smaller than 1 a different set of prefixes are
used, e.g. a millisecond is 1/1000 = 1e-3 second::

        mille = 1e-3
        micro = 1e-6
         nano = 1e-9
         pico = 1e-12
        femto = 1e-15


Units of memory, storage
------------------------

The amount of memory or disk space on a computer is normally measured in
bytes (1 byte = 8 bits) since almost everything we want to store on a
computer requires some integer number of bytes (e.g. an ASCII character can
be stored in 1 byte, a standard integer in 4 bytes, see :ref:`storage`).

Memory on a computer is generally split up into different types of memory
implemented with different technologies.  There is generally a large quantity
of fairly slow memory (slow to move into the processor to operate on it) and
a much smaller quantity of faster memory (used for the data and programs
that are actively being processed).  Fast memory is much more expensive than
slow memeory, consumes more power, and produces more heat.  

The *hard disk* on a computer is used to store data for long periods of
time and is generally slow to access (i.e. to move into the core memory for
processing), but may be large, hundreds of gigabytes (hundreds of
billions of bytes).  

The *main memory* or *core memory* might only be 1GB or a few GB.
Computers also have a smaller amount of 

Units of speed
--------------

The speed of a processor is often measured in Hertz (cycles per second)
or some multiple such as Gigahertz (billions of cycles per second).  This
tells how many *clock cycles* are executed each second.  Each instruction
that a computer can execute takes some integer number of clock cycles.
Different instructions may take different numbers of clock cycles.  An
instruction like "add the contents of registers 1 and 2 and store the result
in register 3" will typically take only 2 clock cycles.  On the other hand
the instruction "load x into register 1" can take a varying number of clock
cycles depending on where x is stored. If x is in cache because it has been
recently used, this instruction may take only a few cycles.  If it is not in
cache and it must be loaded from main memory, it might take 100 cycles.  If
the data set used by the program is so huge that it doesn't all fit in
memory and x must be retrieved from the hard disk, it can be orders of
magnitude slower.

So knowing how fast your computer's processor is in Hertz does not
necessarily directly tell you how quickly a given program will execute.  It
depends on what the program is doing and also on other factors such as how
fast the memory accesses are.

.. _flops:

Flops
-----

In scientific computing we frequently write programs that perform many
*floating point operations* such as multiplication or addition of two
floating point numbers.  A floating point operation is often called
a **flop**.

For many algorithms it is relatively easy to estimate how many flops are
required.  For example, multiplying an :math:`n\times n` 
matrix by a vector of length n
requires roughly :math:`n^2` flops.  So it is convenient to know roughly how
many floating point operations the computer can perform in one second.  In
this context **flops** often stands for *floating point operations per
second*.  For example, a computer with a peak speed of 100 Mflops can
perform up to 100 million floating point operations per second.  As in the
above discussion on clock speed, the actual performance on a particular problem
typically depends very much on factors other than the peak speed, which is
generally measured assuming that all the data needed for the floating point
operations is already in cache so there is no time wasted fetching data.  On
a real problem there may be many more clock cycles used on memory accesses
than on the actual floating point operations.
Because of this, counting flops is no longer a reliable way to determine
how long a program will take to execute.  It's also not possible to 
compare the relative merits of two algorithms for the same problem simply by
counting how many arithmetic operations are required.  For large problems,
the way that data is accessed can be at least as important.

