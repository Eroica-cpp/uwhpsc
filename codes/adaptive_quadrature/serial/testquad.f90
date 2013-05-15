! $UWHPSC/codes/adaptive_quadrature/serial/testquad.f90

! Test the quadrature module.

program main

    use adapquad_mod    ! defines adapquad
    use functions_mod   ! defines g and gint, and gcounter
    use evalfunc_mod    ! defines evalfunc
    real(kind=8) :: a, b, int_approx, int_true, tol, errest, error

    ! open file for writing quadrature points used:
    open(unit=7,file="fquadpts.txt")

    ! open file for writing intervals and levels:
    open(unit=8,file="intervals.txt")

    print *, "Tolerance? "
    read *, tol
    a = -2.d0
    b = 4.d0

    ! true solution:
    int_true = gint(b) - gint(a)

    ! gcounter, a module variable in functions_mod,
    ! keeps track of how many times g is evaluated.
    gcounter = 0  

    call adapquad(g, a, b, tol, int_approx, errest)

    error = int_approx - int_true
    print 61, tol
    print 62, int_approx, int_true, error, errest
61  format(/,"Adaptive quadrature:    tol = ",e13.6)
62  format("   approx = ",e20.13, /, &
           "   true =   ",e20.13, /, &
           "   error =  ",e10.3, /, &
           "   errest = ",e10.3)

    print 63, gcounter
63  format("   g was evaluated ",i9," times")

    open(unit=9,file="info.txt")
    write(9,901) tol,gcounter
901 format(e14.5, i8)

    ! evaluate and print g for plotting purposes:
    call evalfunc(g, a, b)

end program main
