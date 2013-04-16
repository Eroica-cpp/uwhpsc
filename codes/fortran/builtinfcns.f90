! $UWHPSC/codes/fortran/builtinfcns.f90

program builtinfcns

    implicit none
    real (kind=8) :: pi, x, y

    ! compute pi as arc-cosine of -1:
    pi = acos(-1.d0)  ! need -1.d0 for full precision!

    x = cos(pi)
    y = sqrt(exp(log(pi)))**2

    print *, "pi = ", pi
    print *, "x = ", x
    print *, "y = ", y

end program builtinfcns
