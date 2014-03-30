
.. _smc:

===================
Using SageMathCloud
===================

First create an account at `SageMathCloud <https://cloud.sagemath.com/>`_.
You should create an account using your UW email address `netid@uw.edu`.
This will make it easiest for us to add you as a collaborator on projects.

When you log into your account, click on the "New Project" button.  It will
take a few minutes to launch the project.

Within this project, click on "New" and you will see several options.  In
particular you could create a ...

* *Terminal:* this will give you a linux terminal window.  You can type
  commands here as you would in any other linux terminal.  See :ref:`unix`.

  You might start by cloning the class repository into your project by
  following the instructions at 

* *IPython Notebook:* If you are familiar with Python, you can type Python
  commands into the first input cell and hit Shift-Enter to evaluate a cell.

* *Latex editor:* This is a nice WYSIWYG editor for the mathematical
  typesetting program latex, which is widely used for scientific writing,
  particularly in the mathematical sciences.

Making a plot in IPython
-------------------------

Open an IPython Notebook and type these commands in the first cell::

    x = linspace(0,1,1001)
    plot(x, sin(10*pi*x**2))

Then hit Shift-Enter to evaluate, which should produce a plot in the
notebook.

Now in the next cell type::

    plot(x, sin(20*pi*x**2))
    savefig('myplot.png')

and Shift-Enter, to recreate the plot and save this as a png file.   
(Note that it only saves a figure created in the same cell, not the one from
the previous cell!)

Viewing a png file
------------------

To view this png file (from outside the notebook) there are several options:

* Click on the Files tab at the top of the page and then click on
  `myplot.png`.

* Open a terminal and do `ls` to list the files.  Assuming you're in the
  home directory you should see `myplot.png` listed as one of the files.
  Type `open myplot.png` in the terminal.

* View it on the web from a web browser (even on a different computer) at
  the URL
  `https://cloud.sagemath.com/PROJECT-ID/raw/myplot.png`
  where `PROJECT-ID` is replaced by the long string of numbers that appears
  in the address bar when you're working on your project, e.g.
  `0c7b8079-70bb-45ef-8554-53178fd7e447`.

* Download the file to your own computer to view it locally, or to
  incorporate in a paper you are writing, for example.

  One simple way to transfer files in general is to clone your own git
  repository on the SMC project and then add and commit 
  the file you want to transfer.  

  You can also use `scp` to copy a file *from* the SMC to your account on
  some other machine, e.g. a UW computer.  In a terminal window on the SMC 
  project, type::

    scp myplot.png NETID@COMPUTER.u.washington.edu:

  This will copy the file to your account on a UW computer (replace NETID with
  yours and COMPUTER with the appropriate computer name).
  You can put a directory path after the : in this command if you want to
  put it somewhere other than the home directory.


Editing files
-------------

Several editors are available from a SMC terminal window, e.g.

* nano
* emacs
* vi

For example, in a terminal window you can type::

    nano filename.txt

to edit a file.

For a simple point-and-click editor, simply type::

    open filename.txt

This opens it in a separate window.  This is the best way to edit a file if
you are working collaboratively with others, e.g. during the lab sessions.
Other editors sometimes behave strangely if more than one person is viewing
the terminal window of the project simultaneously.

Collaborating
-------------

Multiple people can open the same project and see the same set of files,
even take turns typing into the same terminal window or IPython Notebook. To
give someone else access to a project, open the project and then click on
the wrench icon at the top of the page. Then just type in the netid or name
of the person you want to add.

The collaborator should then see this project appear in the list of projects
of their own account.
    

Other resources
---------------

See the `FAQ <https://github.com/sagemath/cloud/wiki/FAQ>`_ for more tips.
