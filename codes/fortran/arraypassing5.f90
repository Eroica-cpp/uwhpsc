! $UWHPSC/codes/fortran/arraypassing5.f90

module arraypassing_module

contains

subroutine setvals(a)
    ! subroutine that sets values in an array a of length 3.
    implicit none
    real(kind=8), intent(inout) :: a(3)
    integer i
    do i = 1,3
        a(i) = 5.
        enddo
end subroutine setvals

end module arraypassing_module

program arraypassing5

    use arraypassing_module
    implicit none
    real(kind=8), dimension(1) :: x,y
    integer :: i,j

    x(1) = 1.
    y(1) = 2.
    i = 3
    j = 4
    call setvals(x)
    print *, "x = ",x(1)
    print *, "y = ",y(1)
    print *, "i = ",i
    print *, "j = ",j

end program arraypassing5
