! $UWHPSC/codes/openmp/jacobi1d_omp2.f90
!
! Domain decomposition version of Jacobi iteration illustrating
! coarse grain parallelism with OpenMP.
!
! The grid points are split up into nthreads disjoint sets and each thread
! is assigned one set that it updates for all iterations.

program jacobi1d_omp2
    use omp_lib
    implicit none
    real(kind=8), dimension(:), allocatable :: x,u,uold,f
    real(kind=8) :: alpha, beta, dx, tol, dumax, dumax_thread
    real(kind=8), intrinsic :: exp
    real(kind=8) :: t1,t2
    integer :: n, nthreads, points_per_thread,thread_num
    integer :: i,iter,maxiter,istart,iend,nprint

    ! Specify number of threads to use:
    nthreads = 1       ! need this value in serial mode
    !$ nthreads = 2    
    !$ call omp_set_num_threads(nthreads)
    !$ print "('Using OpenMP with ',i3,' threads')", nthreads

    nprint = 10000 ! print dumax every nprint iterations

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

    ! tolerance and max number of iterations:
    tol = 0.1 * dx**2
    print *, "Convergence tolerance: tol = ",tol
    maxiter = 100000
    print *, "Maximum number of iterations: maxiter = ",maxiter

    ! Determine how many points to handle with each thread.
    ! Note that dividing two integers and assigning to an integer will
    ! round down if the result is not an integer.  
    ! This, together with the min(...) in the definition of iend below,
    ! insures that all points will get distributed to some thread.
    points_per_thread = (n + nthreads - 1) / nthreads
    print *, "points_per_thread = ",points_per_thread


    ! Start of the parallel block... 
    ! ------------------------------

    ! This is the only time threads are forked in this program:

    !$omp parallel private(thread_num, iter, istart, iend, i, dumax_thread) 

    thread_num = 0     ! needed in serial mode
    !$ thread_num = omp_get_thread_num()    ! unique for each thread

    ! Determine start and end index for the set of points to be 
    ! handled by this thread:
    istart = thread_num * points_per_thread + 1
    iend = min((thread_num+1) * points_per_thread, n)

    !$omp critical
    print '("Thread ",i2," will take i = ",i6," through i = ",i6)', &
          thread_num, istart, iend
    !$omp end critical

    ! Initialize:
    ! -----------

    ! each thread sets part of these arrays:
    do i=istart, iend
        ! grid points:
        x(i) = i*dx
        ! source term:
        f(i) = 100.*exp(x(i))
        ! initial guess:
        u(i) = alpha + x(i)*(beta-alpha)
        enddo
    
    ! boundary conditions need to be added:
    u(0) = alpha
    u(n+1) = beta

    uold = u   ! initialize, including boundary values


    ! Jacobi iteratation:
    ! -------------------


    do iter=1,maxiter

        ! initialize uold to u (note each thread does part!)
        uold(istart:iend) = u(istart:iend) 

        !$omp single
        dumax = 0.d0     ! global max initialized by one thread
        !$omp end single

        ! Make sure all of uold is initialized before iterating
        !$omp barrier
        ! Make sure uold is consitent in memory:
        !$omp flush

        dumax_thread = 0.d0   ! max seen by this thread
        do i=istart,iend
            u(i) = 0.5d0*(uold(i-1) + uold(i+1) + dx**2*f(i))
            dumax_thread = max(dumax_thread, abs(u(i)-uold(i)))
            enddo

        !$omp critical
        ! update global dumax using value from this thread:
        dumax = max(dumax, dumax_thread)
        !$omp end critical

        ! make sure all threads are done with dumax:
        !$omp barrier

        !$omp single
        ! only one thread will do this print statement:
        if (mod(iter,nprint)==0) then
            print '("After ",i8," iterations, dumax = ",d16.6,/)', iter, dumax
            endif
        !$omp end single

        ! check for convergence:
        ! note that all threads have same value of dumax 
        ! at this point, so they will all exit on the same iteration.
        
        if (dumax .lt. tol) exit

        ! need to synchronize here so no thread resets dumax = 0
        ! at start of next iteration before all have done the test above.
        !$omp barrier

        enddo

    print '("Thread number ",i2," finished after ",i9, &
            " iterations, dumax = ", e16.6)', &
          thread_num,iter,dumax

    !$omp end parallel

    call cpu_time(t2)
    print '("CPU time = ",f12.8, " seconds")', t2-t1


    ! Write solution to heatsoln.txt:
    write(20,*) "          x                  u"
    do i=0,n+1
        write(20,'(2e20.10)'), x(i), u(i)
        enddo

    print *, "Solution is in heatsoln.txt"

    close(20)

end program jacobi1d_omp2
