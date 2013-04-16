
.. _fortran_taylor:

=============================================================
Fortran examples: Taylor series
=============================================================

Here is an example code that uses the Taylor series for :math:`exp(x)` to
estimate the value of this function at :math:`x=1`:

.. literalinclude:: ../codes/fortran/taylor.f90
   :language: fortran
   :linenos:

Running this code gives::

     x =    1.00000000000000     
     exp_true  =    2.71828182845905     
     exptaylor =    2.71828174591064     
     error     =  -8.254840055954560E-008

Here's a modification where the number of terms to use is computed based on
the size of the next term in the series.  The function has been rewritten as
a subroutine so the number of terms can be returned as well.

.. literalinclude:: ../codes/fortran/taylor_converge.f90
   :language: fortran
   :linenos:

This produces::

      x         true              approximate          error         nterms
   -20.000   0.2061153622D-08   0.5621884472D-08   0.1727542678D+01    95
   -16.000   0.1125351747D-06   0.1125418051D-06   0.5891819580D-04    81
   -12.000   0.6144212353D-05   0.6144213318D-05   0.1569943213D-06    66
    -8.000   0.3354626279D-03   0.3354626279D-03   0.6586251980D-11    51
    -4.000   0.1831563889D-01   0.1831563889D-01   0.1723771005D-13    34
     0.000   0.1000000000D+01   0.1000000000D+01   0.0000000000D+00     1
     4.000   0.5459815003D+02   0.5459815003D+02   0.5205617665D-15    30
     8.000   0.2980957987D+04   0.2980957987D+04   0.1525507414D-15    42
    12.000   0.1627547914D+06   0.1627547914D+06   0.3576402292D-15    51
    16.000   0.8886110521D+07   0.8886110521D+07   0.0000000000D+00    59
    20.000   0.4851651954D+09   0.4851651954D+09   0.1228543295D-15    67

Comments:

 * Note the use of `exit` to break out of the loop.

 * Note that it is getting full machine precision for positive values of `x`
   but, as expected, the accuracy suffers for negative `x` due to cancellation.


