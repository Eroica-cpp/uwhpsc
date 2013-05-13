! $UWHPSC/codes/openmp/pisum2.f90
! Computes pi using OpenMP.  
! Compare to $UWHPSC/codes/mpi/pisum1.f90

program pisum2
    
    use omp_lib
    implicit none
    real(kind=8) :: pi,pisum,pisum_thread,x,dx
    integer :: n, nthreads, points_per_thread,thread_num
    integer :: i,istart,iend

    ! Specify number of threads to use:
    nthreads = 1       ! need this value in serial mode
    !$ nthreads = 8    
    !$ call omp_set_num_threads(nthreads)
    !$ print "('Using OpenMP with ',i3,' threads')", nthreads

    print *, "Input n ... "
    read *, n


    ! First do with parallel do loop ...
    ! ----------------------------------

    print *, "WITH OMP PARALLEL DO LOOP:"
    dx = 1.d0 / n
    pisum = 0.d0
    !$omp parallel do reduction(+: pisum) &
    !$omp             private(x)
    do i=1,n
        x = (i-0.5d0) * dx
        pisum = pisum + 1.d0 / (1.d0 + x**2)
        enddo
    pi = 4.d0 * dx * pisum
    print *, 'The approximation to pi = ', pi


    ! Now do with parallel blocks of code...
    ! --------------------------------------

    print *, "WITH OMP PARALLEL:"

    ! Determine how many points to handle with each thread.
    ! Note that dividing two integers and assigning to an integer will
    ! round down if the result is not an integer.  
    ! This, together with the min(...) in the definition of iend below,
    ! insures that all points will get distributed to some thread.
    points_per_thread = (n + nthreads - 1) / nthreads
    print *, "points_per_thread = ",points_per_thread

    dx = 1.d0 / real(n, kind=8)
    pisum = 0.d0

    !$omp parallel private(i,pisum_thread,x, &
    !$omp                  istart,iend,thread_num) 

    thread_num = 0     ! needed in serial mode
    !$ thread_num = omp_get_thread_num()    ! unique for each thread

    ! Determine start and end index for the set of points to be 
    ! handled by this thread:
    istart = thread_num * points_per_thread + 1
    iend = min((thread_num+1) * points_per_thread, n)

    !$omp critical
    print 201, thread_num, istart, iend
    !$omp end critical
201 format("Thread ",i2," will take i = ",i6," through i = ",i6)

    pisum_thread = 0.d0
    do i=istart,iend
        x = (i-0.5d0)*dx
        pisum_thread = pisum_thread + 1.d0 / (1.d0 + x**2)
        enddo

    ! update global pisum with value from each thread:
    !$omp critical
      pisum = pisum + pisum_thread
    !$omp end critical

    !$omp end parallel 

    pi = 4.d0 * dx * pisum

    print *, 'The approximation to pi = ', pi

end program pisum2

