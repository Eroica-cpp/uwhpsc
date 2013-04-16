! $UWHPSC/codes/fortran/sub2.f90

program sub2
    implicit none
    real(kind=8), dimension(3) :: y,z
    integer n

    y = (/2., 3., 4./)
    n = size(y)
    call fsub(y,n,z)
    print *, "z = ",z
end program sub2

subroutine fsub(x,n,f)
  ! compute f(x) = x**2 for all elements of the array x 
  ! of length n.
  implicit none
  integer, intent(in) :: n
  real(kind=8), dimension(n), intent(in) :: x
  real(kind=8), dimension(n), intent(out) :: f
  f = x**2
end subroutine fsub

