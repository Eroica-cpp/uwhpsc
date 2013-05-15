! $UWHPSC/codes/adaptive_quadrature/openmp1/testquad.f90

! Test the quadrature module.

program main

    use omp_lib
    use adapquad_mod    ! defines adapquad
    use functions_mod   ! defines g and gint, and gcounter
    use evalfunc_mod    ! defines evalfunc

    implicit none
    real(kind=8) :: a, b, int_approx, int_true, tol, errest, error, &
                    xmid,intest1,intest2,errest1,errest2,tol2
    integer :: thread_num

    ! Specify number of threads to use:  
    !   (only 1 or 2 since interval split in half)
    nthreads = 1
    !$ nthreads = 2
    !$ call omp_set_num_threads(nthreads)
    !$ print *, "Compiled with OpenMP"
    print "('Using ',i3,' threads')", nthreads


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

    xmid = 0.5d0*(a+b)
    tol2 = tol / 2.d0

    !$omp parallel sections 
    !$omp section
        call adapquad(g,a,xmid,tol2,intest1,errest1)
    !$omp section
        call adapquad(g,xmid,b,tol2,intest2,errest2)
    !$omp end parallel sections

    int_approx = intest1 + intest2
    errest = errest1 + errest2

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
