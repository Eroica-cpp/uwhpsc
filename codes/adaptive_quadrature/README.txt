
This directory contains three versions of an adaptive quadrature program for
estimating the integral from a to b of a function f(x).

serial:  a serial code, using a recursive subroutine

openmp1: first attempt at using OpenMP, splitting the original interval in
         half and assigning one thread to each.  May not be load balanced
         if the integrand is much more smooth in one half than the other.

openmp2: load balanced version that uses nested omp calls.

In any directory, type
  make test
to run and 
  make plot
to produce two plots, one that shows the quadrature points used, and the
other showing the subintervals on which the Trapezoid rule is applied, in
the order done, starting from the top and going down.  For the openmp
versions, blue intervals are done with thread 0 and red intervals with
thread 1.

The code prompts for tol, the desired error to aim for.  In any directory
you might try the following tolerances:
  tol = 0.5, 0.1, 0.01, 0.001
and compare the resulting plots.

The script makeplot.py makes these plots for any of the versions.

