
.. _vm:

=============================================================
Virtual Machine for this class
=============================================================

We are using a wide variety of software in this class, much of which is
probably not found on your computer.  It is all open source software (see
:ref:`licences`) and links/instructions
can be found in the section :ref:`software_installation`.

An alternative, which many will find more convenient, is to download and
install the [VirtualBox]_ software and then download a Virtual Machine (VM)
that has been built specifically for this course.  VirtualBox will run this
machine, which will emulate a specific version of Linux that already has
installed all of the software packages that will be used in this course.

You can find the VM on the `class 
webpage <http://www.amath.washington.edu/~rjl/uwamath583s13/>`_.
Note that the file is quite
large (approximately 750 MB compressed), and if possible you should
download it from on-campus to shorten the download time.

System requirements
-------------------

The VM is around 1.9 GB in size, uncompressed, and the virtual disk
image may expand to up to 8 GB, depending on how much data you store
in the VM.  Make sure you have enough free space available before
installing.  You can set how much RAM is available to the VM when
configuring it, but it is recommended that you give it at least 512
MB; since your computer must host your own operating system at the
same time, it is recommended that you have at least 1 GB of total RAM.

Setting up the VM in VirtualBox
-------------------------------

Once you have downloaded and uncompressed the virtual machine disk
image from the class web site, you can set it up in VirtualBox, by
doing the following:

#. Start VirtualBox

#. Click the *New* button near the upper-left corner

#. Click *Next* at the starting page

#. Enter a name for the VM (put in whatever you like); for *OS Type*,
   select "Linux", and for *Version*, select "Ubuntu".  Click *Next*.

#. Enter the amount of memory to give the VM, in megabytes.  Give it
   as much as you can spare; 512 MB is the recommended minimum.  Click *Next*.

#. Click *Use existing hard disk*, then click the folder icon next to
   the disk list.  In the Virtual Media Manager that appears, click
   *Add*, then select the virtual machine disk image you downloaded
   from the class web site.  Ignore the message about the recommended
   size of the boot disk, and leave the box labeled "Boot Hard Disk
   (Primary Master)" checked.  Once you have selected the disk image,
   click *Next*.

#. Review the summary VirtualBox gives you, then click *Finish*.  Your
   new virtual machine should appear on the left side of the VirtualBox
   window.

Optionally, if you have a reasonably new computer with a multi-core
processor and want to be able to run parallel programs across multiple
cores, you can tell VirtualBox to allow the VM to use additional
cores.  To do this, click the VM on the left side of the VirtualBox
window, then click *Settings*.  Under *System*, click the *Processor*
tab, then use the slider to set the number of processors the VM will
see.  Note that some older multi-core processors do not support the
necessary extensions for this, and on these machines you will only be
able to run the VM on a single core.

Starting the VM
---------------

Once you have configured the VM in VirtualBox, you can start it by
double-clicking it in the list of VM's on your system.  The virtual
machine will take a little time to start up; as it does, VirtualBox
will display a few messages explaining about mouse pointer and
keyboard capturing, which you should read.

After the VM has finished booting, it will present you with a login
screen; the login and password are both ``amath583``.  (We would have
liked to set up a VM with no password, but many things in Linux assume
you have one.)

Running programs
----------------

You can access the programs on the virtual machine through the main
menu (the mouse on an *X* symbol in the lower-left corner of the
screen), or by clicking the quick-launch icons next to the menu
button.  By default, you will have quick-launch icons for a command
prompt window (also known as a *terminal window*), a text editor, and
a web browser.  After logging in for the first time, you should start
the web browser to make sure your network connection is working.

Fixing networking issues
------------------------

When a Linux VM is moved to a new computer, it sometimes doesn't
realize that the previous computer's network adaptor is no longer
available.  If you find yourself unable to connect to the Internet,
open a terminal window and type the following command::

 $ sudo rm /etc/udev/rules.d/70-persistent-net.rules

This will remove the incorrect settings; Linux should then autodetect
and correctly configure the network interface it boots.  To reboot the
VM, click the door icon in the bottom-right of the screen,
then click *Restart*.  If this does not work, contact the TA.

Changing guest resolution/VM window size
----------------------------------------

.. seealso:: 
   The section :ref:`vm_additions`, which makes this easier.

It's possible that the size of the VM's window may be too large for
your display; resizing it in the normal way will result in not all of
the VM desktop being displayed, which may not be the ideal way to
work.  Alternately, if you are working on a high-resolution display,
you may want to *increase* the size of the VM's desktop to take
advantage of it.  In either case, you can change the VM's display size
by going to the main menu in the lower-left corner, pointing to
*Settings*, then clicking *Display*.  Choose a resolution from the
drop-down list, then click *Apply*.

Setting the host key
--------------------

.. seealso:: 
   The section :ref:`vm_additions`, which makes this easier.

When you click on the VM window, it will capture your mouse and future mouse
actions will apply to the windows in the VM.  To uncapture the mouse you
need to hit some control key, called the *host key*.  It should give you a
message about this.  If it says the host key is Right Control, for example,
that means the Control key on the right side of your keyboard (it does *not*
mean to click the right mouse button).

On some systems, the host key that transfers input focus between the
VM and the host operating system may be a key that you want to use in
the VM for other purposes.  To fix this, you can
change the host key in VirtualBox.  In the main VirtualBox window (not
the VM's window; in fact, the VM doesn't need to be running to do
this), go to the *File* menu, then click *Settings*.  Under *Input*,
click the box marked "Host Key", then press the key you want to use.

Shutting down
-------------

When you are done using the virtual machine, you can shut it down by
clicking the door icon in the bottom-right of the
screen, then clicking *Shut down*.

About the VM
------------

The class virtual machine is running XUbuntu 10.10, a variant of Ubuntu
Linux (`<http://www.ubuntu.com>`_), which itself is an offshoot of
Debian GNU/Linux (`<http://www.debian.org>`_).  XUbuntu is a
stripped-down, simplified version of Ubuntu suitable for running on
smaller systems (or virtual machines); it runs the *xfce4* desktop
environment.

.. _vm_additions:

Guest Additions
---------------

While we have installed the VirtualBox guest additions on the class
VM, the guest additions sometimes stop working when the VM is moved to
a different computer, so you may need to reinstall them.
Do the following so that the VM will automatically capture and uncapture
your mouse depending on whether you click in the VM window or outside it,
and to make it easier to resize the VM window to fit your display.


    1. Boot the VM, and log in.

    2. In the VirtualBox menu bar on your host system, select Devices -->
       Install Guest Additions...  (Note: click on the window for the class
       VM itself to get this menu, not on the main "Sun VirtualBox" window.)

    3. A CD drive should appear on the VM's desktop, along with a popup
       window.  (If it doesn't, see the additional instructions below.)
       Select "Allow Auto-Run" in the popup window.  Then enter the
       password you use to log in.

    4. The Guest Additions will begin to install, and a window will appear,
       displaying the progress of the installation.  When the installation is done,
       the window will tell you to press 'Enter' to close it.

    5. Right-click the CD drive on the desktop, and select 'Eject'.

    6. Restart the VM.

If step 3 doesn't work the first time, you might need to:

  Alternative Step 3:
    #. Reboot the VM.
    #. Mount the CD image by right-clicking the CD drive icon, and clicking
       'Mount'.
    #. Double click the CD image to open it.
    #. Double click 'autorun.sh'.
    #. Enter the VM password to install. 



Further reading
---------------

[VirtualBox]_
[VirtualBox-documentation]_
