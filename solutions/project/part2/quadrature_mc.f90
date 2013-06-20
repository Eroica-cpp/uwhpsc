
module quadrature_mc

contains

function quad_mc(g, a, b, ndim, npoints)

    implicit none
    real(kind=8),external :: g
    integer, intent(in) :: ndim, npoints
    real(kind=8), intent(in) :: a(ndim), b(ndim)
    real(kind=8) :: quad_mc

    integer :: i

    real(kind=4), allocatable :: r(:), rr(:)
    real(kind=8) :: gsum, volume
    real(kind=8), allocatable :: x(:)

    allocate(r(ndim*npoints))
    allocate(x(ndim), rr(ndim))

    gsum = 0.d0

    volume = product(b-a)

    call random_number(r)
    do i=1,npoints
        rr = r((i-1)*ndim + 1 : i*ndim)  ! next ndim elements of r
        x = a + rr*(b-a)   ! sets ndim elements of x elementwise
        gsum = gsum + g(x,ndim)
        enddo
    quad_mc = volume * gsum /  npoints

    deallocate(x,r,rr)

end function quad_mc

end module quadrature_mc
