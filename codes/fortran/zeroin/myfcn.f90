! $CLASSHG/codes/fortran/zeroin/myfcn.f90

! Provides the function power(x) = x**n - a.
! A zero of this function will be found using zeroin.

module myfcn

    implicit none
    real(kind=8) :: a
    integer :: n
    save

contains

real(kind=8) function power(x)

    implicit none
    real(kind=8) :: x
    power = x**n - a

end function power

end module myfcn
