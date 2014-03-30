
.. _software_installation:

=============================================================
Downloading and installing software for this class
=============================================================

In 2014 we will use 
`SageMathCloud <https://cloud.sagemath.com/>`_
for much of the computing in this class (see :ref:`smc`), but
if you want to install software on your own computer, this page gives some
hints.

Another option for computing in the cloud is to follow the instructions in
the section :ref:`aws`.

Rather than downloading and installing all of this software individually, 
you might want to
consider using the :ref:`vm`, which already contains everything you need.

It is assumed that you are on a Unix-like machine (e.g Linux or Mac OS
X).  For some flavors of Unix it is easy to download and install some
of the required packages using *apt-get* (see :ref:`apt-get`), 
or your system's package
manager.  Many Python packages can also be installed using
*easy_install* (see :ref:`easy_install`). 

If you must use a Windows PC, then you should 
download and install [VirtualBox]_ for Windows and then 
run the :ref:`vm` to provide a Linux environment.  Some of the software
we'll use is available on Windows, but we will assume you are using a
Unix-like environment and learning to do so is part of the goal of this class.

If you are using a Mac and want to install the necessary software, you also
need to install `Xcode <https://developer.apple.com/xcode/>`_ developer
tools, which includes necessary compilers and *make*, for example.

Some of this software may already be available on your machine.  The *which*
command in Unix will tell you if a command is found on your *search path*,
e.g.::

         $ which python
         /usr/bin/python

tells me that when I type the python command it runs the program located in
the file listed. Often executables are stored in directories named *bin*,
which is short for *binary*, since they are often binary machine code files.

If *which* doesn't print anything, or says something like::

        $ which xyz
        /usr/bin/which: no xyz in (/usr/bin:/usr/local/bin)

then the command cannot be found on the *search path*.  So either the
software is not installed or it has been installed in a directory that isn't
searched by the shell program (see :ref:`shells`) when it tries to interpret
your command.  See :ref:`unix_path` for more information.

Versions
--------

Often there is more than one version of software packages in use.  Newer
versions may have more features than older versions and perhaps even behave
differently with respect to common features.  For some of what we do it will
be important to have a version that is sufficiently current.  

For example, Python has changed dramatically in recent years.  Everything we
need (I think!) for this class can be found in
Version 2.X.Y for any :math:`X \geq 4`.  

Major changes were made to Python in going to Python 3.0, which has not been
broadly adopted by the community yet (because much code would have to be
rewritten).  In this class we are *not* using Python 3.X.  (See
[Python-3.0-tutorial]_ for more information.)

To determine what version of software
you have installed, often the command can be issued with the ``--version``
flag, e.g.::

        $ python --version
        Python 2.5.4

Individual packages
-------------------

.. _installing_python:

Python
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If the version of Python on your computer is older than 2.7.0 (see above), 
you should upgrade.

See `<http://www.python.org/download/>`_ or consider the Enthought Python
Distribution (EPD) or Anaconda CE described below.

.. _installing_superpack:

SciPy Superpack
^^^^^^^^^^^^^^^^

On Mac OSX, you can often install gfortran and all the Python packages we'll
need using the `SciPy Superpack <http://fonnesbeck.github.com/ScipySuperpack/>`_.

.. _installing_epd:

Enthought Python Distribution (EPD)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You might consider installing 
`EPD free <http://www.enthought.com/products/epd_free.php>`_

This includes a recent version of Python 2.X as well as many of the other
Python packages listed below (IPython, NumPy, SciPy, matplotlib, mayavi).

EPD works well on Windows machines too.

.. _installing_anaconda:

Anaconda CE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`Anaconda <https://store.continuum.io/cshop/anaconda>`_
is a new collection of Python tools distributed by 
`Continuum Analytics <http://www.continuum.io/index.html>`_
The "community edition" Anaconda CE is free and contains most of the tools
we'll be using, including IPython, NumPy, SciPy, matplotlib, 
and many others.  The full Anaconda is also free for academic users.

.. _installing_ipython:


IPython
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The IPython shell is much nicer to use than the standard Python shell (see
:ref:`shells` and :ref:`ipython`).
(Included in EPD, Anaconda, and the SciPy Superpack.)

See `<http://ipython.scipy.org/moin/>`_

.. _installing_numpy:


NumPy and SciPy
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Used for numerical computing in Python (see :ref:`numerical_python`).
(Included in EPD, Anaconda, and the SciPy Superpack.)

See `<http://www.scipy.org/Installing_SciPy>`_

Matplotlib
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Matlab-like plotting package for 1d and 2d plots in Python.
(Included in EPD, Anaconda, and the SciPy Superpack.)

See `<http://matplotlib.sourceforge.net/>`_

.. _installing_git:

Git
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Version control system (see :ref:`git`).

See `downloads <http://git-scm.com/downloads>`_.

.. _installing_sphinx:

Sphinx
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Documentation system used to create these class notes pages (see
:ref:`sphinx`).

See `<http://sphinx.pocoo.org/>`_

.. _installing_gfortran:


gfortran
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

GNU fortran compiler (see :ref:`fortran`).  

You may already have this installed, try::

        $ which gfortran


See `<http://gcc.gnu.org/wiki/GFortran>`_

.. _installing_openmp:

OpenMP
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Included with gfortran (see :ref:`openmp`).


.. _installing_mpi:

Open MPI
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Message Passing Interface software for parallel computing (see :ref:`mpi`).

See `<http://www.open-mpi.org/>`_

Some instructions for installing from source on a Mac can be found at
`here
<https://sites.google.com/site/dwhipp/tutorials/installing-open-mpi-on-mac-os-x>`_.


.. _installing_lapack:

LAPack
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Linear Algebra Package, a standard library of highly optimized linear
algebra subroutines.  LAPack depends on the BLAS (Basic Linear Algebra
Subroutines); it is distributed with a reference BLAS implementation,
but more highly optimized BLAS are available for most systems.

See `<http://www.netlib.org/lapack/>`_


.. _apt-get:

Software available through *apt-get*
------------------------------------

On a recent Debian or Ubuntu Linux system, most of the software for
this class can be installed through *apt-get*.  To install, type the
command::

 $ sudo apt-get install PACKAGE


where the appropriate PACKAGE to install comes from the list below.

NOTE: You will only be able to do this on your own machine, the VM described
at :ref:`vm`, or a computer on which you have super user privileges to
install software in the sytsem files.  (See :ref:`sudo`)


You can also install
these packages using a graphical package manager such as Synaptic
instead of *apt-get*.  If you are able to install all of these
packages, you do not need to install the Enthought Python
Distribution.

========================  =================
Software                  Package
========================  =================
Python                    python
IPython                   ipython
NumPy                     python-numpy
SciPy                     python-scipy
Matplotlib                python-matplotlib
Python development files  python-dev
Git                       git
Sphinx                    python-sphinx
gfortran                  gfortran
OpenMPI libraries         libopenmpi-dev
OpenMPI executables       openmpi-bin
LAPack                    liblapack-dev
========================  =================

Many of these packages depend on other packages; answer "yes" when
*apt-get* asks you if you want to download them.  Some of them, such
as Python, are probably already installed on your system, in which
case *apt-get* will tell you that they are already installed and do
nothing.

The script below was used to install software on the Ubuntu VM:

       .. literalinclude:: install.sh


.. _easy_install:

Software available through *easy_install*
-----------------------------------------

*easy_install* is a Python utility that can automatically download and
install many Python packages.  It is part of the Python *setuptools*
package, available from `<http://pypi.python.org/pypi/setuptools>`_,
and requires Python to already be installed on your system.  Once this
package is installed, you can install Python packages on a Unix system
by typing::

 $ sudo easy_install PACKAGE

where the PACKAGE to install comes from the list below.  Note that
these packages are redundant with the ones available from *apt-get*;
use *apt-get* if it's available.

========== ========================
Software   Package
========== ========================
IPython    IPython[kernel,security]
NumPy      numpy
SciPy      scipy
Matplotlib matplotlib
Mayavi     mayavi
Git        git
Sphinx     sphinx
========== ========================

If these packages fail to build, you may need to install the Python
headers.
