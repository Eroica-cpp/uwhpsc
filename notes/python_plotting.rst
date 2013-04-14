
.. _python_plotting:

=============================================================
Plotting with Python 
=============================================================

.. _pylab:

matplotlib and pylab
--------------------

There are nice tools for making plots of 1d and 2d data (curves, contour
plots, etc.) in the module 
`matplotlib <http://matplotlib.sourceforge.net/>`_.
Many of these plot commands are very similar to those in Matlab.

To see some of what's possible (and learn how to do it), visit the 
`matplotlib gallery <http://matplotlib.sourceforge.net/gallery.html>`_.
Clicking on a figure displays the Python commands needed to create it.

The best way to get matplotlib working interactively in a standard Python
shell is to do::

    $ python
    >>> import pylab
    >>> pylab.interactive(True)

*pylab* includes not only *matplotlib* but also *numpy*.  
Then you should be able to do::

    >>> x = pylab.linspace(-1, 1, 20)
    >>> pylab.plot(x, x**2, 'o-')

and see a plot of a parabola appear.  You should also be able to use the
buttons at the bottom of the window, e.g click the
magnifying glass and then use the mouse to select a rectangle in the plot to
zoom in.

Alternatively, you could do::

    >>> from pylab import *
    >>> interactive(True)

With this approach you don't need to start every pylab function name with
pylab, e.g.::

    >>> x = linspace(-1, 1, 20)
    >>> plot(x, x**2, 'o-')

In these notes we'll generally use module names just so it's clear where
things come from.

If you use the IPython shell, you can do::

    $ ipython --pylab

    In [1]: x = linspace(-1, 1, 20)
    In [2]: plot(x, x**2, 'o-')

The --pylab flag causes everything to be imported from pylab and set up for
interactive plotting.

.. _mayavi:

Mayavi and mlab
---------------

Mayavi is a Python plotting package designed primarily for 3d plots.  See:

 * `Documentation <http://code.enthought.com/projects/mayavi/docs/development/html/mayavi/index.html>`_

 * `Gallery <http://code.enthought.com/projects/mayavi/docs/development/html/mayavi/auto/examples.html>`_

See :ref:`software_installation` for some ways to install Mayavi.

.. _visit:

VisIt
-----

VisIt is an open source visualization package being developed at Lawrence Livermore
National Laboratory.  It is designed for industrial-strength visualization problems
and can deal with very large distributed data sets using MPI.

There is a GUI interface and also a Python interface for scripting.

See:

 * `Documentation <https://wci.llnl.gov/codes/visit/doc.html>`_

 * `Gallery <https://wci.llnl.gov/codes/visit/gallery.html>`_

 * `Tutorial <http://www.visitusers.org/index.php?title=Short_Tutorial>`_

.. _paraview:

ParaView
--------

ParaView is another open source package developed originally for work at the
National Labs.  

There is a GUI interface and also a Python interface for scripting.

See:

 * `Documentation <http://www.paraview.org/paraview/help/documentation.html>`_

 * `Gallery <http://www.paraview.org/paraview/project/imagegallery.php>`_


