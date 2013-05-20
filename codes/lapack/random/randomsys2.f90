
! $UWHPSC/codes/lapack/random/randomsys2.f90

program randomsys2
    implicit none
    real(kind=8), dimension(:),allocatable :: x,b
    real(kind=8), dimension(:,:),allocatable :: a
    real(kind=8) :: err
    integer :: i, info, lda, ldb, nrhs, n
    integer, dimension(:), allocatable :: ipiv

    ! initialize random number generator seed
    ! if you remove this, the same numbers will be generated each
    ! time you run this code.
    call init_random_seed()  

    print *, "Input n ... "
    read *, n

    allocate(a(n,n))
    allocate(b(n))
    allocate(x(n))
    allocate(ipiv(n))

    call random_number(a)
    call random_number(x)
    b = matmul(a,x) ! compute RHS
    
    nrhs = 1 ! number of right hand sides in b
    lda = n  ! leading dimension of a
    ldb = n  ! leading dimension of b

    call dgesv(n, nrhs, a, lda, ipiv, b, ldb, info)

    ! Note: the solution is returned in b
    ! and a has been changed.

    ! compare computed solution to original x:
    print *, "         x          computed       rel. error"
    do i=1,n
        err = abs(x(i)-b(i))/abs(x(i))
        print '(3d16.6)', x(i),b(i),err
        enddo

    deallocate(a,b,ipiv)

end program randomsys2
