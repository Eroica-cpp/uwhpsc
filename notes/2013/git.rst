
.. _git:

=============================================================
Git
=============================================================

See :ref:`versioncontrol` and the links there
for a more general discussion of the concepts.

.. _classgit:

Instructions for cloning the class repository
---------------------------------------------

All of the materials for this class, including homeworks, sample programs,
and the webpages you are now
reading (or at least the *.rst* files used to create them, see
:ref:`sphinx`), are in a Git repository hosted at Bitbucket, located
at  
`<http://bitbucket.org/rjleveque/uwhpsc/>`_.
In addition to viewing the files via the link above, you can also view
changesets, issues, etc. (see :ref:`bitbucket`).

To obtain a copy, simply move to the directory where you want your copy to
reside (assumed to be your home directory below)
and then *clone* the repository::

        $ cd 
        $ git clone https://rjleveque@bitbucket.org/rjleveque/uwhpsc.git

Note the following:

 * It is assumed you have *git* installed, see
   :ref:`software_installation`.

 * The clone statement will download the entire repository as a new
   subdirectory called *uwhpsc*, residing in your home directory.  If you
   want *uwhpsc* to reside elsewhere, you should first *cd* to that
   directory.

It will be useful to set a Unix environment variable (see :ref:`env`) called
*UWHPSC* to refer to the directory you have just created.  Assuming you are
using the bash shell (see :ref:`bash`), and that you cloned uwhpsc
into your home directory, you can do this via::

        $ export UWHPSC=$HOME/uwhpsc

This uses the standard environment variable *HOME*, which is the full path
to your home directory.

If you put it somewhere else, you can instead do::

        $ cd uwhpsc
        $ export UWHPSC=`pwd`

The syntax
*`pwd`* means to run the *pwd* command (print working directory) and insert the
output of this command into the export command.  


Type::

        $ printenv UWHPSC

to make sure *UWHPSC* is set properly. This should print the full path to the
new directory.

If you log out and log in again later, you will find that this environment
variable is no longer set.  Or if you set it in one terminal window, it
will not be set in others.  To have it set automatically every time a new
bash shell is created (e.g. whenever a new terminal window is opened), add a
line of the form::

        export UWHPSC=$HOME/uwhpsc

to your *.bashrc* file.  (See :ref:`bashrc`).  This assumes it is in your
home directory.  If not, you will have to add a line of the form::

        export UWHPSC=full-path-to-uwhpsc

where the full path is what was returned by the *printenv* statement above.


.. _uwhpsc_update:

Updating your clone
-------------------

The files in the class repository will change as the quarter progresses ---
new notes, sample programs, and homeworks will be added.  In order
to bring these changes over to your cloned copy, all you need to do is::

        $ cd $UWHPSC
        $ git fetch origin
        $ git merge origin/master

Of course this assumes that *UWHPSC* has been properly set, see above.

The *git fetch* command instructs *git* to fetch any changes from *origin*,
which points to the remote bitbucket repository that you originally cloned
from.  In the merge command, `origin/master` refers to the master branch 
in this repository (which
is the only branch that exists for this particular repository).
This merges any changes retrieved into the files in your current working
directory.

The last two command can be combined as::

        $ git pull origin master

or simply::

        $ git pull
 
since `origin` and `master` are the defaults.


.. _mygit:

Creating your own Bitbucket repository
--------------------------------------

In addition to using the class repository, students in AMath 483/583 are
also required to create their own repository on Bitbucket.  It is possible
to use *git* for your own work without creating a repository on a hosted
site such as Bitbucket (see :ref:`newgit` below), but there are several
reasons for this requirement:

 * You should learn how to use Bitbucket for more than just pulling changes.

 * You will use this repository to "submit" your solutions to homeworks.
   You will give the instructor and TA permission to clone your repository so
   that we can grade the homework (others will not be able to clone or view it
   unless you also give them permission).

 * It is recommended that after the class ends you 
   continue to use your repository as a way to back up your important work on
   another computer (with all the benefits of version control too!).
   At that point, of course, you can change the permissions so the
   instructor and TA no longer have access.

Below are the instructions for creating your own repository.  Note that
this should be a *private repository* so nobody can view or clone it unless
you grant permission.

Anyone can create a free private repository on Bitbucket.  
Note that you can also create an unlimited number of public repositories
free at Bitbucket, which you might want to do for open source software
projects, or for classes like this one.

Follow these directions exactly.  Doing so is part of :ref:`homework1`.
We will clone your repository and check that *testfile.txt* has been created
and modified as directed below.


#. On the machine you're working on:: 

    $ git config --global user.name "Your Name"
    $ git config --global user.email you@example.com

   These will be used when you commit changes.  
   If you don't do this, you might get a warning message 
   the first time you try to commit.

#. Go to `<http://bitbucket.org/>`_ and click on "Sign up now" if you don't
   already have an account.

#. Fill in the form, make sure you remember your username and password.

#. You should then be taken to your account.  Click on "Create" next
   to "Repositories".

#. You should now see a form where you can specify the name of a repository 
   and a description.  The repository name need not be the same as your user 
   name (a single user might have several repositories).  For example, the class
   repository is named *uwhpsc*, owned by user *rjleveque*.
   To avoid confusion, you should probably not name your repository
   *uwhpsc*.  

#. Make sure you click on "Private" at the bottom.  Also turn "Issue
   tracking" and "Wiki" on if you wish to use these features.  

#. Click on "Create repository".  

#. You should now see a page with instructions on how to *clone* your 
   (currently empty) repository.  In a Unix window, *cd* to the directory where
   you want your cloned copy to reside, and perform the clone by typing in
   the clone command shown.  This will create a new directory with the same
   name as the repository.

#. You should now be able to *cd* into the directory this created.

#. To keep track of where this directory is and get to it easily in the
   future, create an environment variable *MYHPSC* from inside this directory
   by::

        $ export MYHPSC=`pwd`

   See the discussion above in section :ref:`classgit` for what this does.  You
   will also probably want to add a line to your *.bashrc* file to define 
   *MYHPSC* similar to the line added for *UWHPSC*.

#. The directory you are now in will appear empty if you simply do::

        $ ls

   But try::

        $ ls -a
        ./  ../  .git/


   the *-a* option causes *ls* to list files starting with a dot, which are
   normally suppressed.  See :ref:`ls` for a discussion of *./* and *../*.
   The directory *.git* is the directory that stores all the information
   about the contents of this directory and a complete history of every file
   and every change ever committed.  You shouldn't touch or modify the files in
   this directory, they are used by *git*.

#. Add a new file to your directory::

        $ cat > testfile.txt
        This is a new file 
        with only two lines so far.
        ^D

   The Unix *cat* command simply redirects everything you type on the
   following lines into a file called *testfile.txt*.  This goes on until
   you type a <ctrl>-d (the 4th line in the example
   above).  After typing <ctrl>-d you should get the Unix
   prompt back.  Alternatively, you could create the file testfile.txt using
   your favorite text editor (see :ref:`editors`).

#. Type::

        $ git status -s

   The response should be::

        ?? testfile.txt

   The ?? means that this file is not under revision control.  
   The *-s* flag results in this *short* status list.  Leave it off for more
   information.

   To put the file under revision control, type::

        $ git add testfile.txt
        $ git status -s
        A  testfile.txt

   The A means it has been added.  However, at this point *git* is not
   we have not yet taken a *snapshot* of this version of the file.
   To do so, type::

        $ git commit -m "My first commit of a test file."

   The string following the -m is a comment about this commit that may help
   you in general remember why you committed new or changed files.  

   You should get a response like::

        [master (root-commit) 28a4da5] My first commit of a test file.
         1 file changed, 2 insertions(+)
         create mode 100644 testfile.txt


   We can now see the status of our directory via::

        $ git status
        # On branch master
        nothing to commit (working directory clean)


   Alternatively, you can check the status of a single file with::

        $ git status testfile.txt

   You can get a list of all the commits you have made (only one so far)
   using::

    $ git log

    commit 28a4da5a0deb04b32a0f2fd08f78e43d6bd9e9dd
    Author: Randy LeVeque <rjl@ned>
    Date:   Tue Mar 5 17:44:22 2013 -0800

        My first commit of a test file.

   The number 28a4da5a0deb04b32a0f2fd08f78e43d6bd9e9dd above is the "name"
   of this commit and you can always get back to the state of your files as
   of this commit by using this number.  You don't have to remember it, you
   can use commands like *git log* to find it later.

   Yes, this is a number... it is a 40 digit hexadecimal number, meaning it
   is in base 16 so in addition to 0, 1, 2, ..., 9, there are 6 more digits
   a, b, c, d, e, f representing 10 through 15.  This number is almost
   certainly guaranteed to be unique among all commits you will ever
   do (or anyone has ever done, for that matter).  It is computed based
   on the state of all the files in this snapshot as a `SHA-1
   Cryptographic hash function <http://en.wikipedia.org/wiki/SHA-1>`_,
   called a SHA-1 Hash for short.

   


   Modifying a file 
   ----------------

   Now let's modify this file::

        $ cat >> testfile.txt
        Adding a third line
        ^D

   Here the *>>* tells *cat* that we want to add on to the end of an
   existing file rather than creating a new one.  (Or you can edit the file
   with your favorite editor and add this third line.)

   Now try the following::

        $ git status -s
         M testfile.txt

   The M indicates this file has been modified relative to the most recent
   version that was committed.  

   To see what changes have been made, try::

        $ git diff testfile.txt

   This will produce something like::

        diff --git a/testfile.txt b/testfile.txt
        index d80ef00..fe42584 100644
        --- a/testfile.txt
        +++ b/testfile.txt
        @@ -1,2 +1,3 @@
         This is a new file
         with only two lines so far
        +Adding a third line

   The + in front of the last line shows that it was added.
   The two lines before it are printed to show the context.  If the
   file were longer, *git diff*
   would only print a few lines around any change to indicate the context.


   Now let's try to commit this changed file::

        $ git commit -m "added a third line to the test file"

   This will fail!  You should get a response like this::

        # On branch master
        # Changes not staged for commit:
        #   (use "git add <file>..." to update what will be committed)
        #   (use "git checkout -- <file>..." to discard changes in working
        #   directory)
        #
        #   modified:   testfile.txt
        #
        no changes added to commit (use "git add" and/or "git commit -a")

   *git* is saying that the file *testfile.txt* is modified but that no
   files have been **staged** for this commit.

   If you are used to Mercurial, *git* has an extra level of complexity (but
   also flexibility):  you can choose which modified files will be included
   in the next commit.  Since we only have one file, there will not be a
   commit unless we add this to the **index** of files staged for the next
   commit::

        $ git add testfile.txt 

   Note that the status is now::

        $ git status -s
        M  testfile.txt

   This is different in a subtle way from what we saw before: The *M* is 
   in the first column rather than the second, meaning it has been both
   modified and staged.

   We can get more information if we leave off the *-s* flag::

        $ git status

        # On branch master
        # Changes to be committed:
        #   (use "git reset HEAD <file>..." to unstage)
        #
        #   modified:   testfile.txt
        #

   Now *testfile.txt* is on the index of files staged for the next commit.

   Now we can do the commit::

        $ git commit -m "added a third line to the test file"

        [master 51918d7] added a third line to the test file
         1 file changed, 1 insertion(+)

   Try doing *git log* now and you should see something like::

        commit 51918d7ea4a63da6ab42b3c03f661cbc1a560815
        Author: Randy LeVeque <rjl@ned>
        Date:   Tue Mar 5 18:11:34 2013 -0800

            added a third line to the test file

        commit 28a4da5a0deb04b32a0f2fd08f78e43d6bd9e9dd
        Author: Randy LeVeque <rjl@ned>
        Date:   Tue Mar 5 17:44:22 2013 -0800

            My first commit of a test file.

   If you want to revert your working directory back to the first snapshot 
   you could do::

        $ git checkout 28a4da5a0de
        Note: checking out '28a4da5a0de'.

        You are in 'detached HEAD' state. You can look around, make experimental
        changes and commit them, and you can discard any commits you make in this
        state without impacting any branches by performing another checkout.

        HEAD is now at 28a4da5... My first commit of a test file.

   Take a look at the file, it should be back to the state with only two
   lines.  

   Note that you don't need the full SHA-1 hash code, the first few digits
   are enough to uniquely identify it.

   You can go back to the most recent version with::

        $ git checkout master
        Switched to branch 'master'

   We won't discuss branches, but unless you create a new branch, the
   default name for your main branch is *master* and this *checkout* command 
   just goes back to the most recent commit.

#. So far you have been using *git* to keep track of changes in your own
   directory, on your computer.  None of these changes have been seen by
   Bitbucket, so if someone else cloned your repository from there, they
   would not see *testfile.txt*.

   Now let's *push* these changes back to the Bitbucket repository::

   First do::

        $ git status

   to make sure there are no changes that have not been committed.  This
   should print nothing.

   Now do::

        $ git push -u origin master

   This will prompt for your Bitbucket password and should then print
   something indicating that it has uploaded these two commits to
   your bitbucket repository.

   Not only has it copied the 1 file over, it has added both changesets, so
   the entire history of your commits is now stored in the repository.  If
   someone else clones the repository, they get the entire commit history
   and could revert to any previous version, for example.

   To push future commits to bitbucket, you should only need to do::

        $ git push

   and by default it will push your master branch (the only branch you
   have, probably) to `origin`, which is the shorthand name for the 
   place you originally cloned the repository from.  To see where this
   actually points to::

        $ git remote -v

   This lists all `remotes`.  
   By default there is only one, the place you cloned the repository from.
   (Or none if you had created a new repository using `git init` rather
   than cloning an existing one.)  

#. Check that the file is in your Bitbucket repository:  Go back to that web
   page for your repository and click on the  "Source" tab at the top.  It
   should display the files in your repository and show *testfile.txt*.

   Now click on the "Commits" tab at the top.  It should show that you
   made two commits and display the comments you added with the *-m* flag
   with each commit.

   If you click on the hex-string for a commit, it will show the 
   *change set* for this commit.  What you
   should see is the file in its final state, with three lines.  The third
   line should be highlighted in green, indicating that this line was added
   in this changeset.  A line highlighted in red would indicate a line deleted
   in this changeset.  (See also :ref:`bitbucket`.)

This is enough for now!  

:ref:`homework1` instructs you to add some additional files to the Bitbucket
repository.

Feel free to experiment further with your repository at this point.


Further reading
---------------

Next see :ref:`bitbucket` and/or :ref:`git_more`.

Remember that you can get help with *git* commands by typing, e.g.::

        $ git help
        $ git help diff  # or any other specific command name

Each command has lots of options!

:ref:`biblio_git` contains references to other sources of information and
tutorials.



