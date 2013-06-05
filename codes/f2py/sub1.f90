
! $UWHPSC/codes/f2py/sub1.f90

! A test subroutine for trying out f2py:
!   $ f2py -m sub1 -c sub1.f90
!   $ python
!   >>> import sub1
!   >>> sub1.mysub(3., 5.)
!   (8.0, -2.0)

subroutine mysub(a,b,c,d)
    real (kind=8), intent(in) :: a,b
    real (kind=8), intent(out) :: c,d
    c = a+b
    d = a-b
end subroutine mysub
