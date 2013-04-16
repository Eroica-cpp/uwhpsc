! $UWHPSC/codes/fortran/array1

program array1

    ! demonstrate declaring and using arrays

    implicit none
    integer, parameter :: m = 3, n=2
    real (kind=8), dimension(m,n) :: A 
    real (kind=8), dimension(m) :: b 
    real (kind=8), dimension(n) :: x 
    integer :: i,j

    ! initialize matrix A and vector x:
    do j=1,n
        do i=1,m
            A(i,j) = i+j
            enddo
        x(j) = 1.
        enddo

    ! multiply A*x to get b:
    do i=1,m
        b(i) = 0.
        do j=1,m
            b(i) = b(i) + A(i,j)*x(j)
            enddo
        enddo

    print *, "A = "
    do i=1,m
        print *, A(i,:)   ! i'th row of A
        enddo
    print "(2d16.6)", ((A(i,j), j=1,2), i=1,3)
    print *, "x = "
    print "(d16.6)", x
    print *, "b = "
    print "(d16.6)", b

end program array1

