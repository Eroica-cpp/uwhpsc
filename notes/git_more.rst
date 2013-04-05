

.. _git_more:

=============================================================
More about Git
=============================================================

Using *git* to stay synced up on multiple computers
----------------------------------------------------

If you want to use your *git* repository on two or more computers, staying
in sync via bitbucket should work well. To avoid having merge conflicts or
missing something on one computer because you didn't push it from the other,
here are some tips:

* When you finish working on one machine, make sure your directory is
  "clean" (using "git status") and if not, add and commit any changes.

* Use "git push" to make sure all commits are pushed to bitbucket.

* When you start working on a different machine, make sure you are up to
  date by doing::

        $ git fetch origin          # fetch changes from bitbucket
        $ git merge origin/master   # merge into your working directory

  These can probably be replaced by simply doing::

        $ git pull

  but for more complicated merges it's recommended that you do the steps
  separately to have more control over what's being done, and perhaps to
  inspect what was fetched before merging.

  If you do this in a clean directory that was pushed since you made any
  changes, then this merge should go fine without any conflicts.


