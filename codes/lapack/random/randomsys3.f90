
! $UWHPSC/codes/lapack/random/randomsys3.f90

program randomsys3
    implicit none
    real(kind=8), dimension(:),allocatable :: x,b,work
    real(kind=8), dimension(:,:),allocatable :: a
    real(kind=8) :: errnorm, xnorm, rcond, anorm, colsum
    integer :: i, info, lda, ldb, nrhs, n, j
    integer, dimension(:), allocatable :: ipiv
    integer, allocatable, dimension(:) :: iwork
    character, dimension(1) :: norm

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

    b = matmul(a,x)    ! compute RHS

    ! compute 1-norm needed for condition number

    anorm = 0.d0
    do j=1,n
        colsum = 0.d0
        do i=1,n
            colsum = colsum + abs(a(i,j))
            enddo
        anorm = max(anorm, colsum)
        enddo

    
    nrhs = 1 ! number of right hand sides in b
    lda = n  ! leading dimension of a
    ldb = n  ! leading dimension of b

    call dgesv(n, nrhs, a, lda, ipiv, b, ldb, info)

    ! compute 1-norm of error
    errnorm = 0.d0
    xnorm = 0.d0
    do i=1,n
        errnorm = errnorm + abs(x(i)-b(i))
        xnorm = xnorm + abs(x(i))
        enddo

    ! relative error in 1-norm:
    errnorm = errnorm / xnorm


    ! compute condition number of matrix:
    ! note: uses A returned from dgesv with L,U factors:

    allocate(work(4*n))
    allocate(iwork(n))
    norm = '1'  ! use 1-norm
    call dgecon(norm,n,a,lda,anorm,rcond,work,iwork,info)

    if (info /= 0) then
        print *, "*** Error in dgecon: info = ",info
        endif

    print 201, n, 1.d0/rcond, errnorm
201 format("For n = ",i4," the approx. condition number is ",e10.3,/, &
           " and the relative error in 1-norm is ",e10.3)    

    deallocate(a,b,ipiv)
    deallocate(work,iwork)

end program randomsys3
