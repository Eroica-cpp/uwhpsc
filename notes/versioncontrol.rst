
.. _versioncontrol:

=============================================================
Version Control Software
=============================================================

In this class we will use *git*.  See the section :ref:`git`
for more information on using *git* and the repositories required for this
class.

There are many other version control systems that are currently popular,
such as cvs, Subversion, Mercurial, and Bazaar.
See [wikipedia-revision-control-software]_ for a much longer list with
links.
See [wikipedia-revision-control]_ for a general discussion of such systems.

Version control systems were originally developed to aid in the development
of large software projects with many authors working on inter-related
pieces.  The basic idea is that you want to work on a file (one piece of the
code), you check it out of a repository, make changes, and then check it
back in when you're satisfied.  The repository keeps track of all changes
(and who made them) and can restore any previous version of a single file or
of the state of the whole project.  It does not keep a full copy of every
file ever checked in, it keeps track of differences (*diff*s) between
versions, so if you check in a version that only has one line changed from
the previous version, only the characters that actually changed are kept
track of.  

It sounds like a hassle to be checking files in and out, but there are a
number of advantages to this system that make version control an
extremely useful tool even for use with you own projects if you are the only
one working on something.  Once you get comfortable with it you may wonder
how you ever lived without it.

Advantages include:

 * You can revert to a previous version of a file if you decide the changes
   you made are incorrect.  You can also easily compare different versions
   to see what changes you made, e.g. where a bug was introduced.

 * If you use a computer program and some set of data to produce some
   results for a publication, you can check in exactly the code and data
   used.  If you later want to modify the code or data to produce new results,
   as generally happens with computer programs, you still have access to the
   first version without having to archive a full copy of all files for
   every experiment you do.  Working in this manner is crucial if you want
   to be able to later reproduce earlier results, as if often necessary if
   you need to tweak the plots for to some journal's specifications or if a
   reader of your paper wants to know exactly what parameter choices you
   made to get a certain set of results.   This is an important aspect of
   doing *reproducible research*, as should be required in science.  (See
   Section :ref:`repro_research`).  If nothing else you can save yourself
   hours of headaches down the road trying to figure out how you got your
   own results.

 * If you work on more than one machine, e.g. a desktop and laptop, version
   control systems are one way to keep your projects synched up between
   machines.


Client-server systems
---------------------

The original version control systems all used a client-server model, in
which there is one computer that contains **the repository** and everyone
else checks code into and out of that repository.

Systems such as CVS and Subversion (svn) have this form.
An important feature of these systems is that only the repository has the
full history of all changes made.  

There is a `software-carpentry webpage on version control
<http://software-carpentry.org/4_0/vc/>`_ that gives a brief overview
of client-server systems.

Distributed systems
-------------------

Git, and other systems such as Mercurial and Bazaar, use a distributed
system in which there is not necessarily a "master repository".  Any working
copy contains the full history of changes made to this copy.  

The best way to get a feel for how *git* works is to use it, for example
by following the instructions in Section :ref:`git`.


Further reading
---------------

See the :ref:`biblio_vcs` section of the bibliography.
