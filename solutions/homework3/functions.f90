! Modified to add f_int and fprime_int for the intersections problem.

module functions

    implicit none
    real(kind=8) :: epsilon
    save

contains

real(kind=8) function f_sqrt(x)
    implicit none
    real(kind=8), intent(in) :: x

    f_sqrt = x**2 - 4.d0

end function f_sqrt


real(kind=8) function fprime_sqrt(x)
    implicit none
    real(kind=8), intent(in) :: x
    
    fprime_sqrt = 2.d0 * x

end function fprime_sqrt

real(kind=8) function f_int(x)
    implicit none
    real(kind=8), intent(in) :: x
    real(kind=8) :: pi
    pi = acos(-1.d0)

    f_int = x*cos(pi*x) - (1.d0 - 0.6d0*x**2)

end function f_int


real(kind=8) function fprime_int(x)
    implicit none
    real(kind=8), intent(in) :: x
    real(kind=8) :: pi
    pi = acos(-1.d0)
    
    fprime_int = (cos(pi*x) - x*pi*sin(pi*x)) + 1.2d0*x

end function fprime_int

end module functions
