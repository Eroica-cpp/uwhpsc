
.. _reproducibility:

=============================================================
Reproducibility
=============================================================

Whenever you do a computation you should strive to make it reproducible, so
that if you want to produce the same result again at a later time you will
be able to.  This is particularly true if the result is important to
your research and will ultimately be used in a paper or thesis 
you are writing, for example.

This may take a bit more time and effort initially, but doing so routinely
can save you an enormous amount of time in the future if you need to
slightly modify what you did, or if you need to reconstruct what you did 
in order to convince yourself or others that you did it properly, or as the
basis for future work in the same direction.

In addition to the potential benefits to your own productivity in the
future, reproducibility of scientific results is a cornerstone of the
scientific method --- it should be possible for other researchers to
independently verify scientific claims by repeating experiments.  If it is
impossible to explain exactly what you did, then it will be impossible for
others to repeat your computational experiments.  Unfortunately most
publications in computational science fall short when it comes to
reproducibility.  Algorithms and data analysis techniques are usually
inadequately described in publications, and readers would find it very hard
to reproduce the results from scratch.  An obvious solution is to make the
actual computer code available.  At the very least, the authors of the paper
should maintain a complete copy of the code that was used to produce the
results.  Unfortunately even this is often not the case.

There is growing concern in many computational science communities with the
lack of reproducibility, not only because of the negative effect on
productivity and scientific progress, but also because the results of
simulations are increasingly important in making policy decisions that can
have far-reaching consequences.

Various efforts underway to develop better tools
for assisting in doing computational work in a reproducible manner and to
help provide better access to code and data that is used to obtain
research results.

Those interested in learning more about this topic might start with the
resources listed in :ref:`biblio_repro`.


In this class we will concentrate on version control as one easy way to
greatly improve the reproducibility of your own work.  If you create a *git*
repository for each project and are diligent about checking in versions of
the code that create important research products, with suitable commit
messages, then you will find it much easier in the long run to reconstruct
the version used to produce any particular result.

Scripting vs. using a shell or GUI
-----------------------------------

Many graphics packages let you type commands in at a shell prompt and/or
click buttons on a GUI to generate data or adjust plot parameters.  While
very convenient, this makes it hard to reproduce the resulting plot unless
you remember exactly what you did.  
It is a very good idea to instead write a script that produces the plot and
that sets all the appropriate plotting parameters in such a way that
rerunning the script gives exactly the same plot.  With some plotting tools
such a script can be automatically generated after you've come up with the
optimal plot by fiddling around with the GUI or by typing commands at the
prompt.  It's worth figuring out how to do this most easily for your own
tools and work style.  If you always create a script for each figure, and
then check that it works properly and commit it to the *git* repository
for the project, then you will be able to easily reproduce the figure again
later.

Even if you are not concerned with allowing others to create the same plot,
it is in your own best interest to make it easy for you to do so again in
the future.  For example, it often happens that the referees of a paper or
members of a thesis committee will suggest improving a figure by plotting
something differently, perhaps as simple as increasing the font size so that
the labels on the axes can be read.  If you have the code that produced the
plot this is easy to do in a few minutes.  If you don't, it may take days
(or longer) to figure out again exactly how you produced that plot to begin
with.

IPython history command
-----------------------

If you are using IPython and typing in commands at the prompt,
the *history* command can be used to print out a list of all the commands
entered, or something like::

    In[32]:  history 19-31

to print out commands *In[19]* through *In[31]*. 

