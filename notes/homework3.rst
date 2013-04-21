
.. _homework3:

==========================================
Homework 3 
==========================================


Due Wednesday, May 1, 2013, by 11:00pm PDT.

The goals of this homework are to:

* Learn more about "best practices in scientific computing".
* Get more experience writing Python code and tests.
* Get some experience with Fortran code.



#.  **Reading assignment**

    Download and read the paper `Best Practices for Scientific Computing 
    <http://arxiv.org/abs/1210.0530>`_ by
    G. Wilson, D. A. Aruliah, C. T. Brown, et. al.
    There is a link to the pdf or postscript versions on the right hand side
    of the arXiv page.  

    You should be pleased to find that you are now starting to follow many
    of these best practices, but there are many good tips in the paper that
    have not been covered in lectures.

    There will be a quiz on this paper to complete as part of the homework
    assignment.  This quiz can be found on the Canvas page
    `Homework 3 quiz <https://canvas.uw.edu/courses/812916/quizzes/739901>`_.
    

    Note: If you are not familiar with the `arXiv <http://arxiv.org/>`_ you
    might want to explore the wide range of preprints and publications that
    authors have posted to make them freely available.

#.  **Programming assignments**
    You should create a new subdirectory `homework3` (of the same private
    repository you have used for submitting previous  homeworks).  
    Develop your code for the problems below in this directory
    and feel free to commit as
    often as you like, it will help you recover from blunders.

#.  Recall that Newton's method for finding the root of a nonlinear function
    :math:`f(x)` consists of choosing an initial guess :math:`x_0` and then
    iterating via:

    .. math::
       x_{k+1} = x_k - \frac{f(x_k)}{f'(x_k)}

    The module `mysqrt.py` developed in lectures and found in
    `$UWHPSC/lectures/lecture6`  was a special case of this
    for the function :math:`f(x) = x^2 - a` for some :math:`a`, in which
    case it converges to :math:`\sqrt{a}`.  (Slightly different notation was
    used there.)

    The section :ref:`special_newton` shows a graphical description of how
    Newton's method works.  

    The section :ref:`fortran_newton` shows the Fortran code for
    implementing something that is very similar to what you are first asked to
    do in Python, so you might first look at the main Newton iteration loop 
    in that code if you are not sure how to proceed with this programming.

    Write a Python module `newton.py` that contains 
    a function `solve` that takes the following inputs:

      * `fvals`, a function that returns the values of :math:`f(x)` and
        :math:`f'(x)` for any input :math:`x` (see the example below),
      * `x0`, the initial guess,
      * `debug`, an optional argument with default `False`.

    The function should return a tuple consisting of the final iterate 
    (the approximation to the root determined) and the number of iterations
    taken.

    The module should also contain the following test:

    .. literalinclude:: ../codes/homework3/test_code.py
       :language: python
       :linenos:

    Note that the definition of `fvals_sqrt` illustrates how to return a
    tuple of values `(f,fp)`  The parentheses are optional in defining this
    tuple and are not used in the code above, but line 10 could also say 
    `return (f,fp)`.  Similarly, line 22 could say `(fx,fpx) = ...`.

    **Convergence test.** The example in `mysqrt.py` checked the magnitude
    of the change between one iteration and the next to test for
    convergence.  In your version, instead check the value of :math:`f(x_k)`
    and stop iterating when :math:`|f(x_k)| < 10^{-14}`.

    This does not always guarantee that the value of :math:`x_k` is within
    `1e-14` of the true root of the function, but works well unless
    :math:`f'(x)` is very small at the root.

    Do your iteration in a loop that takes at most `maxiter = 20`
    iterations.

    **Sample output.** 
    If your code is written properly, running this test should give the
    following output::
        
        In [116]: newton.test1()
         
        solve returns x = 2.000000000000002e+00 after 5 iterations 
        the value of f(x) is 8.881784197001252e-15
         
        solve returns x = 2.000000000000000e+00 after 0 iterations 
        the value of f(x) is 0.000000000000000e+00
         
        solve returns x = 2.000000000000000e+00 after 10 iterations 
        the value of f(x) is 0.000000000000000e+00


    With the debug option turned on it should print::
 
        In [117]: newton.test1(debug_solve=True)
         
        Initial guess: x =    1.000000000000000
        After 1 iterations, x =    2.500000000000000
        After 2 iterations, x =    2.050000000000000
        After 3 iterations, x =    2.000609756097561
        After 4 iterations, x =    2.000000092922295
        After 5 iterations, x =    2.000000000000002
        solve returns x = 2.000000000000002e+00 after 5 iterations 
        the value of f(x) is 8.881784197001252e-15
         
        Initial guess: x =    2.000000000000000
        solve returns x = 2.000000000000000e+00 after 0 iterations 
        the value of f(x) is 0.000000000000000e+00
         
        Initial guess: x =  100.000000000000000
        After 1 iterations, x =   50.020000000000003
        After 2 iterations, x =   25.049984006397441
        After 3 iterations, x =   12.604832373535455
        After 4 iterations, x =    6.461085492374608
        After 5 iterations, x =    3.540088255585130
        After 6 iterations, x =    2.335001794270128
        After 7 iterations, x =    2.024031288207058
        After 8 iterations, x =    2.000142661533015
        After 9 iterations, x =    2.000000005087716
        After 10 iterations, x =    2.000000000000000
        solve returns x = 2.000000000000000e+00 after 10 iterations 
        the value of f(x) is 0.000000000000000e+00


    Note that the statements printed are somewhat different than in the
    example `mysqrt.py` and printed at different points so you will need to
    think about how to implement this properly.

    The formatting used for the floats is `%20.15e`.



#.  The plot below shows two functions :math:`g_1(x) = \sin(x)`
    and :math:`g_2(x) = 1 - x^2`.  These two functions intersect at only two
    points as indicated by the black dots.  

    .. image:: images/intersections1.png
       :width: 10cm

    Finding the intersections
    requires solving :math:`\sin(x) = 1 - x^2`, or equivalently solving for
    zeros of the function :math:`f(x) = g_1(x) - g_2(x).`
    This can be done using Newton's method.  Which zero is found depends on
    the starting guess :math:`x_0`.  For some starting guesses the method
    might not converge at all, but if we start close enough to one of the
    zeros, the method will converge to that zero.

    A program written to do this might produce the following output::

        With initial guess x0 = -5.000000000000000e-01,
              solve returns x = -1.409624004002596e+00 after 9 iterations 

        With initial guess x0 = 5.000000000000000e-01,
              solve returns x = 6.367326508052821e-01 after 4 iterations 

    The goal of this problem is to produce such a program in Python and
    to produce similar output and plot for a different set of functions:
    :math:`g_1(x) = x\cos(\pi x)` and :math:`g_2(x) = 1 - 0.6 x^2`.

    Start by plotting these functions over the interval :math:`-10 \leq x
    \leq 10` from an interactive IPython session and then use the zoom feature 
    on the plot to get initial guess for each intersection.  Note: you
    should see that there are 4 intersections to be found.

    Then write a Python script to set up this problem and solve using
    the `newton.solve` function you wrote earlier.  Your script should
    be named `intersections.py` and should
    import the `newton` module or at least::

        from newton import solve

    The output of your script
    should have the same form as the example shown above, with the `x0` and
    `x` values formatted as `%20.15e`.  Of course there should be 4 sets of
    output instead of two, finding the 4 distinct intersections.

    The script should also produce a plot of the two functions over the
    interval :math:`-5 \leq x \leq 5` with the 4 intersections marked with
    black dots.  

    Plotting hints: 

    * `plot(x,y,'ko')` plots black dots at points specified by the arrays
      `x,y`.
    * The matplotlib `legend` command can be used to add the legend
      indicating which curve is `g1` and which is `g2`.

#.  Starting with the Fortran code in `$UWHPSC/codes/fortran/newton` (see
    also :ref:`fortran_newton`), modify this code to solve the intersection
    problem described above to compute the four intersection points, with
    output format the same as from the Python version.

    You do **not** have to produce plots for this part, which is not
    possible to do directly from Fortran.

    Create a new program `intersections.f90` with the main program.

    Put the new functions you need to define in the `functions.f90` module. 
    Leave the existing functions `f_sqrt` and `fprime_sqrt` in this module
    (so the new ones will need different names).

#.  Modify the `Makefile` from `$UWHPSC/codes/fortran/Makefile` so that typing::

        $ make intersections

    runs the code that prints out the four intersection points.
    Typing::

        $ make test1

    should still work too.  Note that this means you may want to define
    a new macro such as `OBJECTS2` that is the list of object files needed
    to create `intersections.exe`

#.  **583 students only --- to appear***
    
.. warning :: Incomplete, more will be added to the assignment for 583
   students.

To submit
---------

Your homework3 directory should contain:

    * `newton.py` with your Newton code and tests
    * `intersections.py` with the code to solve the intersection problem and
      create plots

    * `newton.f90`  
    * `functions.f90`
    * `intersections.f90`
    * `test1.f90`  (unchanged, but "make test1" should still work)
    * `Makefile`  (modified to add "make intersections" option)

As usual, commit your results, push to bitbucket, and see the Canvas
course page for the link to submit the SHA-1 hash code.  These should be 
submitted by the due date to receive full credit.

    
