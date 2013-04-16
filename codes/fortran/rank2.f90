
! $UWHPSC/codes/fortran/rank2.f90

program rank2

    implicit none
    real(kind=8) :: A(3,4), B(12)
    equivalence (A,B)
    integer :: i,j

    A = reshape((/(10*i, i=1,12)/), (/3,4/))

    do i=1,3
        print 20, i, (A(i,j), j=1,4)
 20     format("Row ",i1," of A contains: ", 11x, 4f6.1)
        print 21, i, (3*(j-1)+i, j=1,4)
 21     format("Row ",i1," is in locations",4i3)
        print 22, (B(3*(j-1)+i), j=1,4)
 22     format("These elements of B contain:", 4x, 4f6.1, /)
        enddo

end program rank2

