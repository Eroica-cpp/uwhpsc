! $UWHPSC/codes/fortran/arraypassing2.f90

program arraypassing2

    implicit none
    real(kind=8) :: x,y
    integer :: i,j

    x = 1.
    y = 2.
    i = 3
    j = 4
    call setvals(x)
    print *, "x = ",x
    print *, "y = ",y
    print *, "i = ",i
    print *, "j = ",j

end program arraypassing2

subroutine setvals(a)
    ! subroutine that sets values in an array a of length 1000.
    implicit none
    real(kind=8), intent(inout) :: a(1000)
    integer i
    do i = 1,1000
        a(i) = 5.
        enddo
end subroutine setvals
