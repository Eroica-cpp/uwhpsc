! Main program for quartic function

program test_quartic

    use newton, only: solve, tol
    use functions, only: f_quartic, fprime_quartic, epsilon

    implicit none
    real(kind=8) :: x, x0, fx, xstar
    real(kind=8) :: tolvals(3), epsvals(3)
    integer :: iters, itest1, itest2
	logical :: debug

    x0 = 4.d0
    print 10 ,x0
10  format("Starting with initial guess ", es22.15,/)
    debug = .false.

    ! values to test as epsilon:
    epsvals = (/1.d-4, 1.d-8, 1.d-12/)

    ! values to test as tol:
    tolvals = (/1.d-5, 1.d-10, 1.d-14/)

    print *, '    epsilon        tol    iters          x                 f(x)        x-xstar'

    do itest1=1,3
        epsilon = epsvals(itest1)
        xstar = 1.d0 + epsilon**(0.25d0)
        do itest2=1,3

        tol = tolvals(itest2)

        call solve(f_quartic, fprime_quartic, x0, x, iters, debug)

        fx = f_quartic(x)
        print 11, epsilon, tol, iters, x, fx, x-xstar
11      format(2es13.3, i4, es24.15, 2es13.3)

        enddo
		print *, ' '  ! blank line
        enddo

end program test_quartic
