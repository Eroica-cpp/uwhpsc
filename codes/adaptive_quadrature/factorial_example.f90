! $UWHPSC/adaptive_quadtrature/factorial_example.f90

! Illustrate a recursive subroutine to compute n! = n*(n-1)*(n-2)...3*2*1

program factorial_example

    implicit none
    integer :: n, nfact

    print *, "Compute n! recursively.  Input n..."
    read *, n
    call myfactorial(n,nfact)
    print *, "n!  = ", nfact

contains

    recursive subroutine myfactorial(m,mfact)
    implicit none
    integer, intent(in) :: m
    integer, intent(out) :: mfact
    integer :: m1fact

    if (m <= 1) then
        mfact = 1
    else
        call myfactorial(m-1, m1fact)
        mfact = m * m1fact
    endif
    end subroutine myfactorial

end program factorial_example
