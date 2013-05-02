
.. _sphinx:

=============================================================
Sphinx documentation 
=============================================================

Sphinx is a Python-based documentation system that allows writing
documentation in a simple mark-up language called ReStructuredText, which
can then be converted to html or to latex files (and then to pdf or
postscript).  See [sphinx]_ for general information, 
[sphinx-documentation]_ for a
complete manual, and [sphinx-rst]_ or [rst-documentation]_
for a primer on ReStructuredText.
See also [sphinx-cheatsheet]_.

Although originally designed for aiding in documentation of Python software,
it is now being used for documentation of packages in other languages as
well.  See [sphinx-examples]_ for a list of other projects that use Sphinx.

It can also be used for things beyond software documentation.  In
particular, it has been used to create the class note webpages that you are
now reading.  It was chosen for two main reasons:

#. It is a convenient way to create a set of hyper-linked web pages on a variety
   of topics without having to write raw html or worry much about formatting.

#. Writing good documentation is a crucial aspect of high performance
   scientific computing and students in this class should learn ways to
   simplify this task.  For this reason many homework assignments must be
   "submitted" in the form of Sphinx pages.

The easiest way to learn how to create Sphinx pages is to read some of the
documentation 
and then examine Sphinx pages such as the one you are now reading to see how
it is written.  You can do this with these class notes or you might look at
one of the other [sphinx-examples]_ to see other styles.

Note that any time you are reading a page of these class notes (or other
things created with Sphinx) there is generally a menu item *Show Source* (on
this page it's on the left, under the heading *This Page*) and clicking on
this link shows the raw text file as originally written.  *Try this now*.

It is possible to customize Sphinx so the pages look very different, as
you'll see if you visit some other projects listed at [sphinx-examples]_.

Using Sphinx for your own project
---------------------------------

If you want to create your own set of Sphinx pages for some project, it is
easy to get started following the instructions at [sphinx]_, or for a quick
start with a different look and feel, see [sphinx-sampledoc]_.

Using Sphinx to create these webpages
-------------------------------------

If you clone the git repository for this class (see :ref:`git`), you will find
a subdirectory called *notes*, containing a number of files with the
extension *.rst*, one for each webpage, containing the ReStructuredText
input.  

To create the html pages, first make sure you have Sphinx installed via::

        $ which sphinx-build

(see :ref:`software_installation`) and then type::

        $ make html

This should process all the files (see :ref:`makefiles`) and create a
subdirectory of *notes* called *_build/html*.  The file
*_build/html/index.html* contains the main Table of Contents page.
Navigate your browser to this page using *Open File* on the *File* menu of
your browser. 

Or you may be able to direct Firefox directly to this page via::

        $ firefox _build/html/index.html

Making a pdf version
--------------------

If you type::

        $ make latex

then Sphinx will create a subdirectory *_build/latex* containing latex
files.  If you have latex installed, you can then do::

        $ cd _build/latex
        $ make all-pdf

to run latex and create a pdf version of all the class notes.




Further reading
---------------

See [sphinx]_ for general information, [sphinx-documentation]_ for a
complete manual, and [sphinx-rst]_ or [rst-documentation]_.
See also [sphinx-cheatsheet]_.

See [sphinx-sampledoc]_ to get started on your own project.


