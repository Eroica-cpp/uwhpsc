
! $UWHPSC/codes/fortran/taylor_converge.f90

program taylor_converge

    implicit none                  
    real (kind=8) :: x, exp_true, y, relative_error
    integer :: nmax, nterms, j

    nmax = 100

    print *, "     x         true              approximate          error         nterms"
    do j = -20,20,4
       x = float(j)                      ! convert to a real
       call exptaylor(x,nmax,y,nterms)   ! defined below
       exp_true = exp(x)
       relative_error = abs(y-exp_true) / exp_true
       print '(f10.3,3d19.10,i6)', x, exp_true, y, relative_error, nterms
       enddo

end program taylor_converge

!====================================
subroutine exptaylor(x,nmax,y,nterms)
!====================================
    implicit none

    ! subroutine arguments:
    real (kind=8), intent(in) :: x
    integer, intent(in) :: nmax
    real (kind=8), intent(out) :: y
    integer, intent(out) :: nterms

    ! local variables:
    real (kind=8) :: term, partial_sum
    integer :: j

    term = 1.
    partial_sum = term

    do j=1,nmax
        ! j'th term is  x**j / j!  which is the previous term times x/j:
        term = term*x/j   
        ! add this term to the partial sum:
        partial_sum = partial_sum + term   
        if (abs(term) < 1.d-16*partial_sum) exit
        enddo
     nterms = j       ! number of terms used
     y = partial_sum  ! this is the value returned
end subroutine exptaylor

