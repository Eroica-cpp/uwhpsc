! $UWHPSC/codes/adaptive_quadrature/openmp1/evalfunc_mod.f90

! Evaluate the function defined in the functions module for plotting.

module evalfunc_mod

contains

subroutine evalfunc(f, a, b)
    implicit none
    real(kind=8), intent(in) :: a,b
    real(kind=8), external :: f
    ! local variables
    integer :: i, n2
    real(kind=8) :: x, dx, a2, b2

    open(unit=8,file="fplotpts.txt")

    ! evaluate at points on an expanded interval
    ! for plotting as a smooth function:
    n2 = 1000
    a2 = a - 0.1d0*(b-a)
    b2 = b + 0.1d0*(b-a)
    dx = (b2-a2)/n2
    do i=1,n2+1
        x = a2 + (i-1)*dx
        write(8,801) x, f(x)
801     format(2e20.10)
    enddo
end subroutine evalfunc

end module evalfunc_mod
