! $UWHPSC/codes/fortran/sub3.f90

module sub3module

contains 

subroutine fsub(x,f)
  ! compute f(x) = x**2 for all elements of the array x. 
  implicit none
  real(kind=8), dimension(:), intent(in) :: x
  real(kind=8), dimension(size(x)), intent(out) :: f
  f = x**2
end subroutine fsub

end module sub3module

!----------------------------------------------

program sub3
    use sub3module
    implicit none
    real(kind=8), dimension(3) :: y,z

    y = (/2., 3., 4./)
    call fsub(y,z)
    print *, "z = ",z
end program sub3

