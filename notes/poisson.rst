
.. _poisson:

==============================================================
Numerical methods for the Poisson problem
==============================================================


The steady state diffusion equation gives rise to a *Poisson problem*

:math:`u_{xx} + u_{yy} = -f(x,y)`

where :math:`f(x,y)` is the source term.  In the simplest case 
:math:`f(x,y) = 0` this reduces to *Laplace's equation*.
This must be augmented with boundary conditions around the edge of some
two-dimensional region.  *Dirchlet boundary conditions* consist of
specifying the solution :math:`u(x,y)` at all points around the boundary. 
*Neumann boundary conditions* consist of specifying the normal dirivative
(i.e. the direction derivative of the solution in the direction orthogonal
to the boundary) and are used in physical situations where the if the flux of 
heat or the diffused quantity is known along the boundary rather than the
value of the solution itself (for example an *insulated boundary* has no
flux and the normal derivative is zero).  We will only study Dirichlet
problems, where :math:`u` itself is known at boundary points.  We will also
concentrate on problems in a rectangular domain :math:`a_x < x < b_x` and
:math:`a_y < y < b_y`, in which case it is natural to discretize
on a *Cartesian grid* aligned with the axes.

The Poisson problem can be discretized on a two-dimensional Cartesian grid 
with equal grid
spacing :math:`h` in the :math:`x` and :math:`y` directions as

:math:`U_{i-1,j} + U_{i+1,j} + U_{i,j-1} + U_{i,j+1} - 4u_{ij} = -h^2
f(x_i,y_j)`.

This gives a coupled system of equations with :math:`n_x n_y` unknowns,
where it is assumed that :math:`h(n_x+1) = b_x - a_x` and
:math:`h(n_y+1) = b_y - a_y`.  The linear system has a very sparse
coefficient matrix since each of the :math:`n_x n_y` rows has at most 5
nonzero entries.

If the boundary data varies smoothly around the boundary then it can be
shown that solving this linear system gives an approximate solution 
of the partial differential equation that is :math:`{\cal O}(h^2)` accurate
each each point.  There are many books that contain much 
more about the development and analysis of such finite difference methods. 

.. _poisson_iter:

Iterative methods for the Poisson problem
-----------------------------------------

Simple iterative methods such as Jacobi, Gauss-Siedel, and Successive
Over-Relaxation (SOR) are discussed in the lectures and used a examples for
implementations in OpenMP and MPI.  For three implementation of Jacobi in
one space dimension, see

* :ref:`jacobi1d_omp1`
* :ref:`jacobi1d_omp2`
* :ref:`jacobi1d_mpi`

For a sample implementation of Jacobi in two space dimensions can be found
in `$UWHPSC/lectures/lecture1`.


.. _poisson_mc:

Monte Carlo methods for the steady state diffusion equation
------------------------------------------------------------

Solving the linear system described above would give an approximate solution
to the Poisson problem at each point on the grid.  Suppose we only want to
approximate the solution at a single point :math:`(x_0,y_0)` for some reason.  
Is there a way
to estimate this without solving the system for all values :math:`U_{ij}`?
Not easily from the linear system, but there are other approaches that might
be used.

We will consider a Monte Carlo approach in which a large number of 
*random walks* starting from the point of interest are used to estimate the
solution.  See :ref:`random` for a discussion of random number generators
and Monte Carlo methods more generally.

We will assume there is no source term, :math:`f(x,y)=0` so that we are
solving Laplace's equation.  The random walk solution is more complicated if
there is a source term.

A random walk starting at some point :math:`(x_0,y_0)` wanders randomly in
the domain until it hits the boundary at some point.  We do this many times
over and keep track of the boundary value given for :math:`u(x,y)` at the
point where each walk hits the boundary.  It can be shown that if we do for
a large number of walks and average the results, this converges to the
desired solution value :math:`u(x_0,y_0)`.  Note that we expect more walks
to to hit the boundary at parts of the boundary near :math:`(x_0,y_0)` than
at points further away, so the boundary conditions at such points will have
more influence on the solution.  This is intuitively what we expect for a
steady state solution of a diffusion or heat conduction problem.

To implement this numerically we will consider the simplification 
of a *lattice random walk*, in which we put down a grid on the domain as in
the finite difference discretization and allow the random walk to only go in
one of 4 directions in each time step, from a point on the grid to one of
its four neighbors.  For isotropic diffusion as we are considering,
we can define a random walk by choosing 1 of the four
neighbors with equal probability in each step.  

The code `$UWHPSC/codes/project/laplace_mc.py` illustrates this.  
Run this code with
`plot_walk = True` to see plots of a few random walks on a coarse grid, or with
`plot_walk = False` to report the solution after many random walks on a finer
grid.

With this lattice random walk we do not expect the approximate solution to
converge to the true solution of the PDE, as the number of trials increases.
Instead we expect it to converge to the solution of the linear system
determined by the finite difference method described above.
In other words if we choose :math:`(x_0,y_0) = (x_i, y_j)$ for some grid
point :math:`(i,j)` then we expect the Monte Carlo solution to converge to
:math:`U_{ij}` rather than to :math:`u(x_i,y_j)`.

**Why does this work?**  Here's one way to think about it.  Suppose doing this
random walk starting at :math:`u(x_i,y_j)` converges to some value :math:`E_{ij}`,
the expected value of u at the boundary hit when starting a random walk at this
point.  If :math:`(x_i,y_j)` is one of the boundary points then 
:math:`E_{ij} = U_{ij}` since we immediately hit the boundary with zero
steps, so every random walk starting at this point returns :math:`u` at this
point.  On the other hand, if :math:`(x_i,y_j)` is an interior point, then
after a single step of the random walk we will be at one of the four
neighbors.  Continuing our original random walk from this point is
equivalent to starting a new random walk at this point.  So for example
any random walk that first takes a step to the right from :math:`(x_i,y_j)`
to :math:`(x_{i+1},y_j)` has the same expected boundary value as obtained
from all random walks starting at :math:`(x_{i+1},y_j)`, i.e. the value
:math:`E_{i+1,j}`.  But only 1/4 of the random walks starting at
:math:`(x_i,y_j)` go first to the right.  So the expected value over all
walks starting at :math:`(x_i,y_j)` is expected to be the average of the
expected value when starting at any of the 4 neighbors.  In other words,

:math:`E_{ij} = \frac 1 4 (E_{i-1,j} + E_{i+1,j} + E_{i,j-1} + E_{i,j+1})`

But this means :math:`E_{ij}` satisfies the same linear system of equations
as :math:`U_{ij}` (and also the same boundary conditions),
and hence must be the same.

