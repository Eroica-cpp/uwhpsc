
! $UWHPSC/codes/f2py/jacobi1

! For use with f2py:
!   $ f2py -m jacobi1 -c jacobi1.f90
! Then in Python you can import jacobi1 and use it to take a fixed number of
! iterations using Jacobi in one space dimension to solve
!      u(i-1) - 2*u(i) + u(i+1) = -dx**2 * f(i).
! Python call:
!   >>> u = jacobi1.iterate(u0, iters, f)
! where 
!   iters is the number of iterations to take,
!   u0(0:n+1) is the initial guess (with desired boundary values 
!             in u0(0) and u0(n+1), these are not changed.
!   f(0:n+1) contains values of f(x) at each grid point.
! 

subroutine iterate(u0,iters,f,u,n)
    implicit none
    integer, intent(in) :: n, iters
    real(kind=8), dimension(0:n+1), intent(in) :: u0, f
    real(kind=8), dimension(0:n+1), intent(out) :: u

    ! local variables:
    real(kind=8), dimension(:), allocatable :: uold
    real(kind=8) :: dx
    integer :: i, iter

    ! allocate storage for boundary points too:
    allocate(uold(0:n+1))

    ! grid spacing:
    dx = 1.d0 / (n+1.d0)

    uold = u0

    ! initialize boundary values of u:
    u(0) = u0(0)
    u(n+1) = u0(n+1)

    ! take the iterations requested:
    do iter=1,iters
        do i=1,n
            u(i) = 0.5d0*(uold(i-1) + uold(i+1) + dx**2*f(i))
            enddo
        uold = u
        enddo

end subroutine iterate
