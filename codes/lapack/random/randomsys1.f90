
! $UWHPSC/codes/lapack/random/randomsys1.f90

program randomsys1
    implicit none
    integer, parameter :: nmax=1000
    real(kind=8), dimension(nmax) :: b, x
    real(kind=8), dimension(nmax,nmax) :: a
    real(kind=8) :: err
    integer :: i, info, lda, ldb, nrhs, n
    integer, dimension(nmax) :: ipiv

    ! initialize random number generator seed
    ! if you remove this, the same numbers will be generated each
    ! time you run this code.
    call init_random_seed()  

    print *, "Input n ... "
    read *, n
    if (n<1 .or. n>nmax) then
        print *, "n must be positive and no greater than ",nmax
        stop
        endif
    call random_number(a(1:n,1:n))
    call random_number(x(1:n))
    b(1:n) = matmul(a(1:n,1:n),x(1:n)) ! compute RHS
    
    nrhs = 1 ! number of right hand sides in b
    lda = nmax  ! leading dimension of a
    ldb = nmax  ! leading dimension of b

    call dgesv(n, nrhs, a, lda, ipiv, b, ldb, info)

    ! Note: the solution is returned in b
    ! and a has been changed.

    ! compare computed solution to original x:
    print *, "         x          computed       rel. error"
    do i=1,n
        err = abs(x(i)-b(i))/abs(x(i))
        print '(3d16.6)', x(i),b(i),err
        enddo

end program randomsys1
