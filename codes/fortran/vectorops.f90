! $UWHPSC/codes/fortran/vectorops.f90

program vectorops

    implicit none
    real(kind=8), dimension(3) :: x, y

    x = (/10.,20.,30./)
    y = (/100.,400.,900./)

    print *, "x = "
    print *, x

    print *, "x**2 + y = "
    print *, x**2 + y

    print *, "x*y = "
    print *, x*y

    print *, "sqrt(y) = "
    print *, sqrt(y)

    print *, "dot_product(x,y) = "
    print *, dot_product(x,y)


end program vectorops
