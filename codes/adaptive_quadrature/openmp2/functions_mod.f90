! $UWHPSC/codes/adaptive_quadrature/openmp2/functions_mod.f90

module functions_mod

    ! Define the function we want to integrate.
    ! Also define the indefinite integral (anti-derivative) of g for
    ! use in computing the true solution to compute the error.

    ! The counter gcounter can be initialized to 0 in the main program
    ! and then will count how many times the function g is called.

    implicit none
    integer :: gcounter  
    real(kind=8), parameter :: beta = 10.d0
    save

contains

real(kind=8) function g(x)
    ! Test function to integrate
    implicit none
    real(kind=8), intent(in) :: x
    g = exp(-beta**2 * x**2) + sin(x)
    gcounter = gcounter + 1
end function g

real(kind=8) function gint(x)
    ! Anti-derivative of g
    implicit none
    real(kind=8), parameter :: pi = 3.141592653589793d0
    real(kind=8), intent(in) :: x
    gint = sqrt(pi)/(2.d0*beta) * erf(beta*x) - cos(x)
end function gint

end module functions_mod
