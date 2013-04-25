

.. _punchcard:

===============================================
Punch cards
===============================================

Once upon a time (through the 1970s) many computer programs were written on
punch cards of the type shown here [`image source
<http://en.wikipedia.org/wiki/File:FortranCardPROJ039.agr.jpg>`_]:

.. image:: images/FortranCardPROJ039-agr.jpg
   :width: 20cm


This is a form of binary memory (see :ref:`memory`)
where a specific set of locations each has a
hole punched (representing 1) or not (representing 0).
Each character typed on the top line is represented by the bits reading down
the corresponding column, e.g. the first character Z is represented by
001000000001 since there are only two holes punched in this column.


When programs were written on cards, one card was required for each line of
the program.  The early conventions of the :ref:`fortran` programming
language are related to the columns on a punch card.  
Only the first 72 columns were used for the program statements.  The last 8
columns could be used to print a card number, so that the unlucky programmer
who dropped a deck of cards had some chance of reordering them properly.
Many Fortran 77  compilers still ignore any characters beyond column 72 in a
line of a program, leading to bugs that can be hard to find if care is not 
taken, e.g. a called *xnew* might be truncated to *x* if the *x* is in
column 72.  If the program also uses a variable called *x*, this will not be
caught by the compiler.

A program would require a *punch card deck* as shown in this photo
[`image source
<http://en.wikipedia.org/wiki/File:PunchCardDecks.agr.jpg>`_]:

.. image:: images/PunchCardDecks-agr.jpg
   :width: 15cm


Punch cards were a great step forward from *punched tape* `[wikipedia]
<http://en.wikipedia.org/wiki/Punched_tape>`_ where a long strip of paper
was used to store the entire program (and making a mistake required retyping
more than just one card).

