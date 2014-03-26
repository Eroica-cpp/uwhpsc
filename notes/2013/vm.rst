
.. _2013_vm:

=============================================================
Virtual Machine for this class [2013 version]
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
webpage <http://faculty.washington.edu/rjl/classes/am583s2013/>`_.
Note that the file is quite
large (approximately 750 MB compressed), and if possible you should
download it from on-campus to shorten the download time.  The TA's will also
have the VM on memory sticks for transferring.


System requirements
-------------------

The VM is around 2.1 GB in size, uncompressed, and the virtual disk
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

#. Enter the amount of memory to give the VM, in megabytes.  
   512 MB is the recommended minimum.  Click *Next*.

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


Starting the VM
---------------

Once you have configured the VM in VirtualBox, you can start it by
double-clicking it in the list of VM's on your system.  The virtual
machine will take a little time to start up; as it does, VirtualBox
will display a few messages explaining about mouse pointer and
keyboard capturing, which you should read.

After the VM has finished booting, it will present you with a login
screen; the login and password are both ``uwhpsc``.  (We would have
liked to set up a VM with no password, but many things in Linux assume
you have one.)

Note that you will also need this password to quit the VM.

Running programs
----------------

You can access the programs on the virtual machine through the Applications
Menu (the mouse on an *X* symbol in the upper-left corner of the
screen), or by clicking the quick-launch icons next to the menu
button.  By default, you will have quick-launch icons for a command
prompt window (also known as a *terminal window*), a text editor, and
a web browser.  After logging in for the first time, you should start
the web browser to make sure your network connection is working.

Fixing networking issues
------------------------

When a Linux VM is moved to a new computer, it sometimes doesn't
realize that the previous computer's network adaptor is no longer
available.  

Also, if you move your computer from one wireless network to another while
the VM is running, it may lose connection with the internet.  

If this happens, it should be sufficient to shut down the VM (with the 0/1
button on the top right corner) and then restart it.
On shutdown, a script is automatically run that does the following, which in
earlier iterations of the VM had to be done manually...

 $ sudo rm /etc/udev/rules.d/70-persistent-net.rules

This will remove the incorrect settings; Linux should then autodetect
and correctly configure the network interface it boots.  

Shutting down
-------------

When you are done using the virtual machine, you can shut it down by
clicking the 0/1 button on the top-right corner of the VM.
You will need the password `uwhpsc`.

Cutting and pasting
-------------------

If you want to cut text from one window in the VM and paste it into another,
you should be able to highlight the text and then type ctrl-c (or in a
terminal window, ctrl-shift-C, since ctrl-c is the interrupt signal). To
paste, type ctrl-v (or ctrl-shift-V in a terminal window).

If you want to be able to cut and paste between a window in the VM and a
window on your host machine, click on Machine from the main VitualBox menu
(or `Settings` in the Oracle VM VirtualBox Manager window), then click on
`General` and then `Advanced`.  Select `Bidirectional` from the `Shared
Clipboard` menu.

Shared Folders
--------------

If you create a file on the VM that you want to move to the file system of
the host machine, or vice versa, you can create a "shared folder" that is
seen by both.  

First create a folder (i.e. directory) on the host machine, e.g. via::

    $ mkdir ~/uwhpsc_shared

This creates a new subdirectory in your home directory on the host machine. 

In the VirtualBox menu click on `Devices`, then click on
`Shared Folders`.  Click the + button on the right side and then type in the
full path to the folder you want to share under `Folder Path`, including the
folder name, and then the folder name itself under `Folder name`.  
If you click on `Auto-mount` then this will be mounted every time you start
the VM.  

Then click `OK` twice.  

Then, in the VM (at the linux prompt), type the following commands::

    sharename=uwhpsc_shared   # or whatever name the folder has
    sudo mkdir /mnt/$sharename 
    sudo chmod 777 /mnt/$sharename 
    sudo mount -t vboxsf -o uid=1000,gid=1000 $sharename /mnt/$sharename 

You may need the password `uwhpsc` for the first `sudo` command.

The folder should now be found in the VM in `/mnt/$sharename`.
(Note `$sharename` is a variable set in the first command above.)

If auto-mounting doesn't work properly, you may need to repeat the final
`sudo mount ...` command  each time you start the VM.  


Enabling more processors
------------------------


If you have a reasonably new computer with a multi-core
processor and want to be able to run parallel programs across multiple
cores, you can tell VirtualBox to allow the VM to use additional
cores.  To do this, open the VirtualBox
*Settings*.  Under *System*, click the *Processor*
tab, then use the slider to set the number of processors the VM will
see.  Note that some older multi-core processors do not support the
necessary extensions for this, and on these machines you will only be
able to run the VM on a single core.

Problems enabling multiple processors...
------------------------

Users may encounter several problems with enabling mutliple processors. Some users may not
be able to change this setting (it will be greyed out). Other users when may find no improved performance after enabling multiple processors. Still others may encounter an error such as::

    VD: error VERR_NOT_SUPPORTED

All of these problems indicate that virtualization has not been enabled on your processors. 

Fortunately this has an easy fix. You just have to enable virtualization in your BIOS
settings. 

1. To  access the BIOS settings you must restart your computer and press a certain
button on startup. This button will depend on the company that manufactures your computer 
(for example for Lenovo's it appears to be the f1 key).

2. Next you must locate a setting that will refer to either virtualization, VT, or VT-x. 
Again the exact specifications will depend on the computer's manufacturer, however
it should be found in the Security section (or the Performance section if you are using a Dell). 

3. Enable this setting,
then save and exit the bios settings.After your computer reboots you should be able to start the VM using multiple processors now. 

4. If your BIOS does not have any settings like this it is possible that your BIOS is set up to hide this option from you, and you
may need to follow the advice here: http://mathy.vanvoorden.be/blog/2010/01/enable-vt-x-on-dell-laptop/

Note: Unfortunately some older hardware does not support virtualization, and so if these solutions don't work for you it may
be that this is the case for your processors. There also may be other possible problems...so don't be afraid to ask the TAs for help! 

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
by going to the Applications menu in the upper-left corner, pointing to
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

.. _2013_vm_additions:

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

How This Virtual Machine was made
-----------------------------------

    1. Download Ubuntu 12.04 PC (Intel x86) alternate install ISO from 
       http://cdimage.ubuntu.com/xubuntu/releases/12.04.2/release/xubuntu-12.04.2-alternate-i386.iso

    2. Create a new virtual box

    3. Set the system as Ubuntu

    4. Use defualt options

    5. After that double click on your new virtual machine...a dropdown
       box should appear where you can select
       your ubuntu iso

    6. As you are installing...at the first menu hit F4 and install a 
       command line system

    7. Let the install proceed following the instructions as given. On most
       options the default answer will be appropriate.
       When it comes time to format the hard drive, choose the manual option.
       Format all the free space and set it as the mount
       point. From the next list choose root (you dont need a swap space). 

    8. Install the necessary packages

       .. literalinclude:: install.sh

    9. To setup the login screen edit the file Xresources so that the 
       greeting line says.::

	xlogin*greeting: Login and Password are uwhpsc

    10. Create the file uwhpscvm-shutdown.::

       .. literalinclude:: uwhpscvm-shutdown

    11. Save it at.::

	/usr/local/bin/uwhpscvm-shutdown

    12. Execute the following command command.::

	$ sudo chmod +x /usr/local/bin/uwhpscvm-shutdown

    13. Right click on the upper panel and select add new items and choose
        to add a new launcher.

    14. Name the new launcher something like shutdown and in the command 
        blank copy the following line.::

	 gksudo /usr/local/bin/uwhpscvm-shutdown

    15. Go to preferred applications and select Thunar for file managment 
        and the xfce4 terminal.

    16. Run jockey-gtk and install guest-additions.

    17. Go to Applications then Settings then screensaver and select 
        "disable screen saver" mode

    18. In the settings menu select the general settings and hit the advanced
        tab. Here you can set the clipboard and drag
        and drop to allow Host To Guest.

    19. Shutdown the machine and then go to the main virtualbox screen.
        Click on the virtualmachine and then hit the settings button.

    20. After, in the system settings click on the processor tab. This may let
        you allow the virtual machine to use more than one processor (depending
        on your computer). Choose a setting somewhere in the green section of
        the Processors slider. 

About the VM
------------

The class virtual machine is running XUbuntu 12.04, a variant of Ubuntu
Linux (`<http://www.ubuntu.com>`_), which itself is an offshoot of
Debian GNU/Linux (`<http://www.debian.org>`_).  XUbuntu is a
stripped-down, simplified version of Ubuntu suitable for running on
smaller systems (or virtual machines); it runs the *xfce4* desktop
environment.


Further reading
---------------

[VirtualBox]_
[VirtualBox-documentation]_
