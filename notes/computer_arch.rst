

.. _computer_arch:

=============================================================
Computer Architecture
=============================================================

This page is currently a very brief survey of a few issues.  See the links
below for more details.

Not so long ago, most computers consisted of a single central processing unit
(CPU) together with some a few registers (high speed storage locations for
data currently being processed) and *main memory*, typically a hard disk
from which data is moved in and out of the registers as needed (a slower
operation).  Computer speed, at least for doing large scale scientific
computations, was generally limited by the speed of the CPU.  Processor
speeds are often quoted in terms of *Hertz* the number of *machine cycles
per second* (or these days in terms of GigaHertz, GHz, in billions of cycles
per second).  A single operation like adding or multiplying two numbers
might take more than one cycle, how many depends on the architecture and
other factors we'll get to later.  For scientific codes, the most important
metric was often how many floating point operations could be done per
second, measured in flops (or Gigaflops, etc.).   
See :ref:`flops` for more about this.

.. _moores_law:

Moore's Law
-----------

For many years computers kept getting faster primarily because the clock
cycle was reduced and so the CPU was made faster.  In 1965, Gordon Moore
(co-founder of Intel) predicted that the transistor density (and hence the
speed) of chips would double every 18 months for the forseeable future.
This is know as **Moore's law** 
This proved remarkably accurate for more than 40 years, see the graphs at
`[wikipedia-moores-law] <http://en.wikipedia.org/wiki/Moore%27s_law>`_.
Note that doubling every 18 months means an increase by a factor of 4096
every 14 years.    

Unfortunately, the days of just waiting for a faster computer in order to do
larger calculations has come to an end.  Two primary considerations are:

 * The limit has nearly been reached of how densely transistors can be
   packed and how fast a single processor can be made.

 * Even current processors can generally do computations much more quickly
   than sufficient quantities of data can be moved between memory and
   the CPU.  If you are doing 1 billion meaningful multiplies per second 
   you need to move lots of data around.

There is a hard limit imposed by the speed of light.  A 2 GHz
processor has a clock cycle of 0.5e-9 seconds.  The speed of light is
about 3e8 meters per second. So in one clock cycle information cannot
possibly travel more than 0.15 meters.  (A light year is a long distance but
a light nanosecond is only about 1 foot.)  If you're trying to move billions
of bits of information each second then you have a problem.

Another major problem is power consumption.  Doubling the clock speed of a
processor takes roughly 8 times as much power and also produces much more
heat.  By contrast, doubling the number of processors only takes twice as
much power.

There are ways to continue improving computing power in the future, but they
must include two things:

 * Increasing the number of cores or CPUs that are being used simultaneously
   (i.e., parallel computing)

 * Using memory hierachies to improve the ability to have large amounts of
   data available to the CPU when it needs it.


Further reading
---------------

See the :ref:`biblio_computer_arch` section of the bibliography.

See also the slides from [Yelick-UCB]_, [Gropp-UIUC]_ and other courses
listed in the bibliography.

