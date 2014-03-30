! Main program

program intersections

    use newton, only: solve
    use functions, only: f_int, fprime_int

    implicit none
    real(kind=8) :: x, x0, fx
    real(kind=8) :: x0vals(4)
    integer :: iters, itest
	logical :: debug

    print *, "Test routine for computing zero of f"
    debug = .true.

    ! values to test as x0:
    x0vals = (/-2.2d0, -1.6d0, -0.8d0, 1.45d0/)

    do itest=1,4
        x0 = x0vals(itest)
		print *, ' '  ! blank line
        call solve(f_int, fprime_int, x0, x, iters, debug)

        print 11, x, iters
11      format('solver returns x = ', es22.15, ' after', i3, ' iterations')

        fx = f_int(x)
        print 12, fx
12      format('the value of f(x) is ', es22.15)

        enddo

end program intersections
