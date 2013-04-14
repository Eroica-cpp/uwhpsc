

.. _ipython_notebook:

=============================================================
IPython_notebook
=============================================================

The IPython notebook is fairly new and changing rapidly.  The version
originally installed in the class VM is version 0.10.  To get the latest
development version, which has some nicer features, do the following::

    $ cd
    $ git clone https://github.com/ipython/ipython.git
    $ cd ipython
    $ sudo python setup.py install

Then start the notebook via::

    $ ipython notebook --pylab inline

in order to have the plots appear inline.  If you leave off this argument, a
new window will be opened for each plot.

Read more about the notebook in the `documentation
<http://ipython.org/ipython-doc/dev/interactive/htmlnotebook.html>`_

See some cool examples in the `IPython notebook viewer
<http://nbviewer.ipython.org/>`_.

See also :ref:`sagemath`.

