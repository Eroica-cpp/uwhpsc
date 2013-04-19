! $UWHPSC/codes/fortran/circles/circle_mod.f90
! Version where pi is a module variable.

module circle_mod

    implicit none
    real(kind=8) :: pi 
    save  

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
