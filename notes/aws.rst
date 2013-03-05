
.. _aws:

====================================
Amazon Web Services EC2 AMI
====================================

We are using a wide variety of software in this class, much of which is
probably not found on your computer.  It is all open source software (see
:ref:`licences`) and links/instructions
can be found in the section :ref:`software_installation`.
You can also use the :ref:`vm`.

Another alternative is to write and run your programs "in the cloud" 
using Amazon Web Services (AWS) Elastic Cloud Computing (EC2).
You can start up an "instance" (your own private computer, or so it appears)
that is configured using an Amazon Machine Image (AMI) that has been
configured with the Linux operating system and containing
all the software needed for this class.  

You must first sign up for an account  on the `AWS main page
<http://aws.amazon.com/>`_.  For this you will need a credit
card, but note that with an account you can get 750 hours per month of
free "micro instance" usage in the
`free usage tier <http://aws.amazon.com/free/>`_.
A micro instance is a single processor (that you will probably be sharing
with others) so it's not suitable for trying out parallel computing, but
should be just fine for much of the programming work in this class.

You can start up more powerful instances with 2 or more processors for a cost
starting at about 14.5 cents per hour (the High CPU Medium on-demand
instance).  See the `pricing guide <http://aws.amazon.com/ec2/#pricing>`_.  


For general information and guides to getting started:

* `Getting started with EC2 <http://docs.amazonwebservices.com/AWSEC2/latest/GettingStartedGuide/>`_,
  with tutorial to lead you through an example.

* `EC2 FAQ <http://aws.amazon.com/ec2/faqs>`_.

* `Pricing <http://aws.amazon.com/ec2/#pricing>`_.  Note: you are charged
  per hour for hours (or fraction thereof) that your instance is in
  `running` mode, regardless of whether the CPU is being used.

* `High Performance Computing on AWS <http://aws.amazon.com/hpc-applications/>`_
  with instructions on starting a cluster instance.

* `UW eScience information on AWS <http://escience.washington.edu/get-help-now/get-started-amazon-web-services>`_.


Finding the AMath 583 AMI
-------------------------

Once you have an AWS account, sign in to the 
`management console <https://console.aws.amazon.com/ec2/>`_
and click on the
EC2 tab, and then select Region US East (which has cheaper rates) and click
on `AMIs` on the menu to the left.  

Change `Viewing:` to `All Images` and `All Platforms` and then *after* it
has finished loading the database start typing 
`uwamath583s13` in the search bar.

Lanching an instance
---------------------

Select the `uwamath583s13` image and then
click on the `Launch` button on this page to start launching an instance 
based on this AMI.  This means a virtual machine will be started for you,
initialized with this disk image (which is a Ubuntu linux distribution with
all the software we need pre-loaded).

Next you can select what sort of instance you wish to start (larger
instances cost more per hour).

Click `Continue` on the next few screens and eventually you get to one that
asks for a key pair.  If you don't already have one, create a new one and
select it here.

Click `Continue` and you will get a screen to set Security Groups.  Select
the `quick-start-1` option.  On the next screen click `Launch`.


Logging on to your instance
---------------------------

Click `Close` on the next page to
go back to the Management Console.  Click on `Instances` on the left menu
and you should see a list of instance you
have created, in your case only one.  If the status is not yet `running`
then wait until it is (click on the `Refresh` button if necessary).

*Click on the instance* and information about it should appear at the bottom
of the screen. Scroll down until you find the `Public DNS` information

Go into the directory where your key pair is stored, in a file with a name
like `rjlkey.pem` and you should be able to `ssh` into your instance using
the name of the public DNS, with format like::

    $ ssh -X -i KEYPAIR-FILE  ubuntu@DNS

where KEYPAIR-FILE and DNS must be replaced by the appropriate
things, e.g. for the above example::

    $ ssh -X -i rjlkey.pem ubuntu@ec2-50-19-75-229.compute-1.amazonaws.com

Note:

* You must include `-i keypair-file`

* You must log in as user ubuntu.

* Including -X in the ssh command allows X window forwarding, so that if you
  give a command that opens a new window (e.g. plotting in Python) it will
  appear on your local screen.


Once you have logged into your instance, you are on Ubuntu Linux that has
software needed for this class pre-installed.

Other software is easily installed using `apt-get install`, as described
in :ref:`software_installation`.

Transferring files to/from your instance
----------------------------------------

You can use `scp` to transfer files between a running instance and
the computer on which the ssh key is stored.

From your computer (not from the instance)::

    $ scp -i KEYPAIR-FILE FILE-TO-SEND ubuntu@DNS:REMOTE-DIRECTORY

where DNS is the public DNS of the instance and `REMOTE-DIRECTORY` is
the path (relative to home directory) 
where you want the file to end up.  You can leave off
`:REMOTE-DIRECTORY` if you want it to end up in your home directory.

Going the other way, you can download a file from your instance to
your own computer via::

    $ scp -i KEYPAIR-FILE ubuntu@DNS:FILE-TO-GET .

to retrieve the file named `FILE-TO-GET` (which might include a path
relative to the home directory) into the current directory.

Stopping your instance
----------------------

Once you are done computing for the day, you will probably want to stop your
instance so you won't be charged while it's sitting idle.  You can do this
by selecting the instance from the Management Console / Instances, and then
select `Stop` from the `Instance Actions` menu.

You can restart it later and it will be in the same state you left it in.
But note that it will probably have a new Public DNS!

Creating your own AMI
---------------------

If you add additional software and want to save a disk image of your
improved virtual machine (e.g. in order to launch additional images in the
future to run multiple jobs at once), simply click on `Create Image (EBS
AMI)` from the `Instance Actions` menu.




Viewing webpages directly from your instance
--------------------------------------------


An apache webserver should already be running in your instance, 
but to allow people (including yourself) to view
webpages you will need to adjust the security settings.  Go back to the
Management Console and click on `Security Groups` on the left menu.  Select
`quick-start-1` and then click on `Inbound`.  You should see a list of ports
that only lists 22 (SSH).  You want to add port 80 (HTTP).  Select HTTP from
the drop-down menu that says `Custom TCP Rule` and type 80 for the `Port
range`.  Then click `Apply Rule Changes`.  


Now you should be able to point your browser to `http://DNS` where `DNS` is
replaced by the Public DNS name of your instance, the same as used for the
`ssh` command.  So for the example above, this would be ::

    http://ec2-50-19-75-229.compute-1.amazonaws.com  


The page being displayed can be found in `/var/www/index.html` on your
instance.  Any files you want to be visible on the web should be in
`/var/www`, or it is sufficient to have a link from this directory to where
they are located (created with the `ln -s` command in linux). 

So, for example, if you do the following::

    $ cd /var/www
    $ sudo ln -s /home/ubuntu ./home

then you can see the contents of your home directory at::

    http://ec2-50-19-75-229.compute-1.amazonaws.com/home  

Remember to change the DNS to the right thing for your instance!
