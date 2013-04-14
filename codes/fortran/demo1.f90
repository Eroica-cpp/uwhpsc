! $UWHPSC/codes/fortran/demo1.f90

program demo1

! Fortran 90 program illustrating data types.

implicit none   ! to give error if a variable not declared
real :: x
real (kind=8) :: y, z
integer :: m

m = 3
print *, " "
print *, "M = ",M   ! note that M==m  (case insensitive)


print *, " "
print *, "x is real (kind=4)"
x = 1.e0 + 1.23456789e-6
print *, "x = ", x


print *, " "
print *, "y is real (kind=8)"
print *, "  but 1.e0 is real (kind=4):"
y = 1.e0 + 1.23456789e-6
print *, "y = ", y


print *, " "
print *, "z is real (kind=8)"
z = 1. + 1.23456789d-6
print *, "z = ", z

end program demo1
