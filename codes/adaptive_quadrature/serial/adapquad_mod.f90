! $UWHPSC/codes/adaptive_quadrature/serial/adapquad_mod.f90

! Adaptive quadrature code (serial, no parallelization)
! The difference between the Trapezoid approximation and Simpson is used
! as an error estimate.
!
! If the estimate is greater than the tolerance, subdivde the interval and 
! apply recursively.

module adapquad_mod

    implicit none
    integer, parameter :: maxlevel = 30
    save

contains

recursive subroutine adapquad(f,a,b,tol,intest,errest,level,fa,fb)
    implicit none
    real(kind=8), intent(in) :: a,b,tol
    real(kind=8), intent(out) :: intest
    real(kind=8), optional, intent(out) :: errest
    integer, optional, intent(in) :: level
    real(kind=8), optional, intent(in) :: fa,fb
    real(kind=8), external :: f

    ! local variables:
    real(kind=8) :: xmid, fmid, trapezoid, simpson, errest1, errest2, &
                    intest1, intest2, tol2, f_a, f_b
    integer :: thislevel, nextlevel

    ! Unit 7 should be opened for writing out quadrature points in
    ! the main program.  Use this format statement for writes below:
701 format(2e20.10)

    ! Unit 8 should be opened for writing out intervals, level in
    ! the main program.  Use this format statement for writes below:
801 format(2e20.10,i3)

    if (.not. present(level)) then
        ! called from main program, which is level=1:
        thislevel = 1
    else
        thislevel = level
    endif

    write(8,801) a,b,thislevel

    !print 601, a, b, thislevel
601 format('+++ adapquad called with a = ',e13.6,'  b = ',e13.6, ' level = ',i3)

    if (present(fa)) then
        f_a = fa
    else
        f_a = f(a)
        write(7,701) a, f_a
    endif
    if (present(fb)) then
        f_b = fb
    else
        f_b = f(b)
        write(7,701) b, f_b
    endif

    trapezoid = 0.5d0*(b-a)*(f_a + f_b)
    
    xmid = 0.5d0*(a + b)
    fmid = f(xmid)

    ! write function value for plotting:
    write(7,701) xmid, fmid

    ! print to screen for debugging:
    !print *, '+++ Level = ',thislevel, '  xmid = ',xmid

    simpson = (b-a)*(f_a + 4.d0*fmid + f_b) / 6.d0

    errest = abs(trapezoid - simpson)

    !print 602, errest
602 format('+++   error estimate: ',e13.6)

    if ((errest > tol) .and. (thislevel < maxlevel)) then
        ! recursively apply this subroutine to each half, with
        ! tolerance tol/2 for each, and nextlevel = thislevel+1:
        tol2 = tol / 2.d0
        nextlevel = thislevel + 1
        call adapquad(f,a,xmid,tol2,intest1,errest1,nextlevel,f_a,fmid)
        call adapquad(f,xmid,b,tol2,intest2,errest2,nextlevel,fmid,f_b)
        intest = intest1 + intest2
        errest = errest1 + errest2
    else
        ! Use the trapezoid approximation.
        ! Note that simpson would be better, 
        ! but we have error estimate for trapezoid
        intest = trapezoid
    endif

end subroutine adapquad


end module adapquad_mod
