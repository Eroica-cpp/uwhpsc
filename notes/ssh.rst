

.. _ssh:

=============================================================
Using ssh to connect to remote computers
=============================================================

Some computers allow you to remotely log and start a Unix shell running
using ssh (secure shell).  To do so you generally type something like::

    $ ssh username@host

where username is your account name on the machine you are trying to connect
to and host is the host name.

On Linux or a
Mac, the `ssh` command should work fine in a terminal.  On Windows, you may
need to install something like `putty <http://www.putty.org/>`_.  


.. _ssh_X:

X-window forwarding
-------------------

If you plan on running a program remotely that might pop up its own
X-window, e.g. when doing plotting in Python or Matlab, you should use::

    $ ssh -X username@host

In order for X-windows forwarding to work you must be running
a X-window server on your machine.  If you are running on a linux machine
this is generally not an issue.  On a Mac you need to install the *Xcode
developer tools* (which you will need anyway).

On Windows you will need something like `xming
<http://sourceforge.net/projects/xming/>`_.  A variety of tutorials on
using *putty* and *xming* together can be found by googling "putty and
xming".

scp
---------------

To transfer files you can use `scp`, similar to the copy command `cp` but used
when the source and destination are on different computers::

    $ scp somefile username@host:somedirectory

which would copy `somefile` in your local directory to `somedirectory`
on the remote `host`, which is an address like `homer.u.washington.edu`,
for example.  

Going  in the other direction, you could copy a remote file to your local
machine via::

    $ scp username@host:somedirectory/somefile . 

The last "." means "this directory".  You could instead give the path to a
different local directory.

You will have to type your password on the remote host each
time you do this, unless you have remote ssh access set up, see for example
`this page <http://www.debian.org/devel/passwordlessssh>`_.

