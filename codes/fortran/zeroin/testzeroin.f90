! $UWHPSC/codes/fortran/roots/testzeroin.f90

program main

    use myfcn
    ! This module holds n, a, and provides function power(x)

    implicit none
    real(kind=8) :: x, x1, x2, y, tol
    real(kind=8), external :: zeroin

    print *, "Test routine for computing n'th root of a"
    print *, "Input a "
    read *, a
    print *, "Input n "
    read *, n
    print *, "Input x1,x2:  interval containing zero"
    read *, x1, x2

    tol = 1.d-10  ! tolerance requested to zeroin

    y = zeroin(x1, x2, power, tol)

    print *, 'Estimated value: ', y
    print *, 'Correct   value: ', a ** (1.d0/n)

end program main
