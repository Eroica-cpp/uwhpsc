! $UWHPSC/codes/mpi/quadrature/functions_mod.f90

module functions_mod

    ! Define the function we want to integrate.
    ! Also define the indefinite integral (anti-derivative) of g for
    ! use in computing the true solution to compute the error.

    ! The integer gevals can be initialized to 0 in the main program
    ! and then will count how many times the function g is called by each proc.
    ! Note that this is automatically local to each processor!

    ! k is the wave number used in g and gint.

    use mpi
    implicit none
    integer :: gevals
    real(kind=8) :: k
    save

contains

real(kind=8) function g(x)
    ! Test function to integrate
    implicit none
    real(kind=8), intent(in) :: x
    integer :: proc_num, ierr

    g = exp(0.1d0*x) + cos(k*x)
    gevals = gevals + 1

end function g

real(kind=8) function gint(x)
    ! Anti-derivative of g
    implicit none
    real(kind=8), intent(in) :: x
    gint = 10.d0*exp(0.1d0*x) + sin(k*x) / k
end function gint

end module functions_mod
