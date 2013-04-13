

.. _nose:

=============================================================
nose -- Python unit testing framework
=============================================================

It is generally a good idea to write "unit tests" as you develop code, 
tests that check one small unit of the code to insure that it gives the
expected output for some set of inputs.  

If you are developing a Python module containing some functions, then each
function might have one or more tests to go with it.  Often these are
designed so that running the test produces no output if the test passes, but
raises some exception if it fails.  

If the test functions all have the string "test" somewhere in their title,
then *nose* can be used to easily sniff out these tests and run them all (or
some subset with appropriate arguments).

To install *nose* on the class VM::

    $ sudo apt-get install python-setuptools 
    $ sudo easy_install nose                  

You first have to install *setuptools* so that `easy_install` is available,
which is often used for Python packages.


To read more about *nose* and see some examples:

* `nose documentation <https://nose.readthedocs.org/en/latest/>`_
* `Intro by Titus Brown <http://ivory.idyll.org/articles/nose-intro.html>`_

