! $UWHPSC/codes/fortran/arrayops1.f90

program arrayops1

    implicit none
    real(kind=8), dimension(4) :: x,y
    integer i

    x = (/10.d0, 20.d0, 30.d0, 40.d0/)

    print *, "x = ",x

    print *, "x(2:3) = ", x(2:3)


end program arrayops1
