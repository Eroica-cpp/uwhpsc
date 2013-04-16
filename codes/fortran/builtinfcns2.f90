! $UWHPSC/codes/fortran/builtinfcns2.f90

program builtinfcns

    implicit none
    real :: pi, x, y    ! note kind is not specified

    ! compute pi as arc-cosine of -1:
    pi = acos(-1.0)

    x = cos(pi)
    y = sqrt(exp(log(pi)))**2

    print *, "pi = ", pi
    print *, "x = ", x
    print *, "y = ", y

end program builtinfcns
