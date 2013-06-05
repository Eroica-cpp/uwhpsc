! $UWHPSC/codes/f2py/fcn1.f90

! A test function for trying out f2py:
!   $ f2py -m fcn1 -c fcn1.f90
!   $ python
!   >>> import fcn1
!   >>> fcn1.f1(1.)
!   2.7182818284590451


function f1(x)
    real(kind=8), intent(in) :: x
    real(kind=8) :: f1
    f1 = exp(x)
end function f1
