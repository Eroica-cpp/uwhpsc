! $UWHPSC/codes/fortran/circles/circle_mod.f90

module circle_mod

    implicit none
    real(kind=8) :: pi = 3.141592653589793d0

contains

    real(kind=8) function area(r)
        real(kind=8), intent(in) :: r
        area = pi * r**2
    end function area

    real(kind=8) function circumference(r)
        real(kind=8), intent(in) :: r
        circumference = 2.d0 * pi * r
    end function circumference

end module circle_mod
