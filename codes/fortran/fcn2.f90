! $UWHPSC/codes/fortran/fcn2.f90

program fcn2
    implicit none
    real(kind=8) :: y,z
    real(kind=8), external :: f

    y = 2.
    print *, "Before calling f: y = ",y
    z = f(y)
    print *, "After calling f:  y = ",y
    print *, "z = ",z
end program fcn2

real(kind=8) function f(x)
    implicit none
    real(kind=8), intent(inout) :: x
    f = x**2
    x = 5.
end function f
