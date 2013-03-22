
.. _homework1:

==========================================
Homework 1 
==========================================

.. warning :: Not yet assigned and may change slightly. 


Due Wednesday, April 10, 2011, by 11:00pm PDT.

The goals of this homework are to:

 * Make sure you are familiar with basic Unix commands (see :ref:`unix`)
   and an editor, (see :ref:`editors`),
 * Start using *git* (:ref:`git`) to download course materials,
 * Create your own bitbucket repository to keep your coursework and post homeworks
   to be graded.

Before tackling this homework, you should read some of the class notes and
links they point to.  In particular, the following sections are relevant:

 * :ref:`unix`
 * :ref:`software_installation`
 * :ref:`editors`
 * :ref:`git`
 * :ref:`bitbucket`
 * :ref:`biblio`

You do not need to "turn in" anything for this homework, but by doing it you
will create files in your repository that we can view to grade.

 #. First, if you have not already completed the survey on your background
    and computing needs, please do so now.  You can find it 
    `here <https://catalyst.uw.edu/webq/survey/rjl/128895>`_.

 #. Make sure you have access to *git* on the computer you plan to use
    (see :ref:`software_installation`).  Read the section :ref:`git` and the
    documentation linked from there in order to get a sense of how it works.

 #. Clone the class repository following the 
    :ref:`uwhpsc`.

    Make sure you have set the environment variable *UWHPSC*
    since this is used below.

 #. Set up your own personal repository on Bitbucket, by carefully following 
    all of the instructions at :ref:`mygit`.
    By following these instructions you will also create a clone of the
    repository and add some files to it.

    Make sure you have set the environment variable *MYHPSC*
    since this is used below.

 #. In the clone of your repository, 
    create a subdirectory *homeworks* and within
    this directory a subdirectory *homework1*, via the following commands::

        $ cd $MYHPSC
        $ mkdir homeworks
        $ cd homeworks
        $ mkdir homework1

    You should now be able to *cd* into this directory::

        $ cd homework1

    or later you can get there from anywhere via::

        $ cd $MYHPSC/homeworks/homework1


 #. Copy some files from the class repository to your own repository by::

        $ cp $UWHPSC/homeworks/homework1/*  $MYHPSC/homeworks/homework1

    This should create the files 
         * `test1.py`
         * `test2.sh`
         * `test3.f90`
    in the directory *$MYHPSC/homeworks/homework1*.  

 #. Use `git add` and `git commit` to add these three files and commit
    a snapshot.

 #. Modify `test1.py` as instructed in the *docstring* at the top of the
    file.  Try running it via::

        $ python test1.py

    It should give results like the following::

        Code run by Your Name
        Environment variable UWHPSC is /somepath/uwhpsc
        Environment variable MYHPSC is /somepath/myhpsc
        Imported numpy ok
        Imported matplotlib ok
        Imported pylab ok

    Following the instructions, you will add and commit to files, a modified
    version of `test1.py` and the output file `test1output.txt`.

 #. Run the bash shell script `test2.sh` via::

        $ bash test2.sh

    This should give output something like the following::

        Environment variable UWHPSC is /somepath/uwhpsc
        Environment variable MYHPSC is /somepath/myhpsc

        which ipython returns...
        /somepath/ipython

        which gfortran returns...
        /usr/local/bin/gfortran

        gfortran --version returns...
        GNU Fortran (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3

        [more stuff]

        Compiling and running a Fortran code...
         Successfully ran Fortran 90 program


    Now run it again and redirect the output to a file::

        $ bash test2.sh > test2output.txt
    
    Add and commit the output file to your repository.

    **Note:** At the end you should have the following files committed
    to your repository::

        * $MYHPSC/testfile.txt
        * $MYHPSC/homeworks/homework1/test1.py
        * $MYHPSC/homeworks/homework1/test1output.txt
        * $MYHPSC/homeworks/homework1/test2.sh
        * $MYHPSC/homeworks/homework1/test2output.txt
        * $MYHPSC/homeworks/homework1/test3.f90

    Make sure the copies you want graded have been committed, and then
    push them to bitbucket via::

        $ git push

    These files should then also be visible from your bitbucket webpage, by
    clicking on the "Source" tab, see :ref:`bitbucket`.


 #. You created a private repository, so you will have to give us permission 
    to view or clone it.  Do so by clicking on the "Admin" tab at the top of
    your Bitbucket account page and then use the "Add reader" tool.  You
    should add three users: *rjleveque* and the TAs *smoe* and *ssusie*.

 #. Finally, let us know where your Bitbucket repository is so that we can
    clone it and/or view your source files online in order to grade it.
    If you are registered in the class, you should be able access the
    `Canvas Survey 1
    <https://canvas.uw.edu/courses/812916/quizzes/736633>`_.
    Go to that page and follow instructions to send us this information.

    On this page you will also have to submit the SHA-1 hash of the 
    commit that you want graded.  This is the 40-digit hexadecimal string
    that shows up when you type::

        $ git log

    in your repository.

    
