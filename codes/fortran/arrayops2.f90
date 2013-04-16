! $UWHPSC/codes/fortran/arrayops2.f90

program arrayops2

    implicit none
    real(kind=8), dimension(3,2) :: a,b
    integer i

    a = reshape((/1,2,3,4,5,6/), (/3,2/))

    b = transpose(a)

    print *, "b = "
    do i=1,2
        print *, b(i,:)   ! i'th row
        enddo

    c = matmul(a,b)
    print *, "c = "
    do i=1,3
        print *, c(i,:)   ! i'th row
        enddo

    x = (/5,6/)
    y = matmul(a,x)
    print *, "x = ",x
    print *, "y = ",y

end program arrayops2
