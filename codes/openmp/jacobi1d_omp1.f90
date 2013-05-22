! $UWHPSC/codes/openmp/jacobi1d_omp1.f90
!
! Jacobi iteration illustrating fine grain parallelism with OpenMP.
!
! Several omp parallel do loops are used.  Each time threads will be
! forked and the compiler will decide how to split up the loop.

program jacobi1d_omp1
    use omp_lib
    implicit none
    integer :: n, nthreads
    real(kind=8), dimension(:), allocatable :: x,u,uold,f
    real(kind=8) :: alpha, beta, dx, tol, dumax
    real(kind=8), intrinsic :: exp
    real(kind=8) :: t1,t2
    integer :: i,iter,maxiter 

    ! Specify number of threads to use:
    nthreads = 2
    !$ call omp_set_num_threads(nthreads)
    !$ print "('Using OpenMP with ',i3,' threads')", nthreads

    print *, "Input n ... "
    read *, n

    ! allocate storage for boundary points too:
    allocate(x(0:n+1), u(0:n+1), uold(0:n+1), f(0:n+1))

    open(unit=20, file="heatsoln.txt", status="unknown")

    call cpu_time(t1)

    ! grid spacing:
    dx = 1.d0 / (n+1.d0)

    ! boundary conditions:
    alpha = 20.d0
    beta = 60.d0

    !$omp parallel do
    do i=0,n+1
        ! grid points:
        x(i) = i*dx
        ! source term:
        f(i) = 100.*exp(x(i))
        ! initial guess:
        u(i) = alpha + x(i)*(beta-alpha)
        enddo

    ! tolerance and max number of iterations:
    tol = 0.1 * dx**2
    print *, "Convergence tolerance: tol = ",tol
    maxiter = 100000
    print *, "Maximum number of iterations: maxiter = ",maxiter

    ! Jacobi iteratation:

    uold = u  ! starting values before updating

    do iter=1,maxiter
        dumax = 0.d0
        !$omp parallel do reduction(max : dumax)
        do i=1,n
            u(i) = 0.5d0*(uold(i-1) + uold(i+1) + dx**2*f(i))
            dumax = max(dumax, abs(u(i)-uold(i)))
            enddo
        if (mod(iter,10000)==0) then
            print *, iter, dumax
            endif
        ! check for convergence:
        if (dumax .lt. tol) exit

        !$omp parallel do 
        do i=1,n
            uold(i) = u(i)   ! for next iteration
            enddo
        enddo

        call cpu_time(t2)
        print '("CPU time = ",f12.8, " seconds")', t2-t1

        print *, "Total number of iterations: ",iter

    write(20,*) "          x                  u"
    do i=0,n+1
        write(20,'(2e20.10)'), x(i), u(i)
        enddo

    print *, "Solution is in heatsoln.txt"


    close(20)

end program jacobi1d_omp1
