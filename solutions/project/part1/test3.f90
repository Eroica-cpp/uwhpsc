
program test

    use mpi

    use quadrature, only: trapezoid
    use functions, only: f, fevals_proc, k

    implicit none
    real(kind=8) :: a,b,int_true, int_approx, int_sub, dx_sub
    real(kind=8) :: ab_sub(2)   ! to hold a and b for each subinterval

    integer :: i,j,jj,n_proc,proc_num, num_procs,ierr,n,fevals_total,nsub
    integer :: nextsub, numsent, sender
    integer, dimension(MPI_STATUS_SIZE) :: status

    call MPI_INIT(ierr)
    call MPI_COMM_SIZE(MPI_COMM_WORLD, num_procs, ierr)
    call MPI_COMM_RANK(MPI_COMM_WORLD, proc_num, ierr)

    ! All processes set these values so we don't have to broadcast:
    k = 1.d3   ! functions module variable 
    a = 0.d0
    b = 2.d0
    int_true = (b-a) + (b**4 - a**4) / 4.d0 - (1.d0/k) * (cos(k*b) - cos(k*a))
    n = 1000
    !nsub = 4

    if (num_procs == 1) then
        print *, "*** Error: need to use at least two processes"
        go to 999
        endif


    ! Each process keeps track of number of fevals:
    fevals_proc = 0

    if (proc_num==0) then
        int_approx = 0.d0
        print 100, num_procs
100     format("Using ",i3," processes")

        print *, "How many subintervals? "
        read *, nsub

        print 10, int_true
 10     format("true integral: ", es22.14)
        print *, " "  ! blank line
        endif

    call MPI_BARRIER(MPI_COMM_WORLD,ierr) ! wait for process 0 to print
    call MPI_BCAST(nsub, 1, MPI_INTEGER, 0, MPI_COMM_WORLD, ierr)

    ! -----------------------------------------
    ! code for Master (Processor 0):
    ! -----------------------------------------

    if (proc_num == 0) then

      numsent = 0 ! keep track of how many subintervals sent

      dx_sub = (b-a) / nsub

      ! send the first batch to get all workers working:
      do j=1,min(num_procs-1, nsub)
        ab_sub(1) = a + (j-1)*dx_sub
        ab_sub(2) = a + j*dx_sub
        call MPI_SEND(ab_sub, 2, MPI_DOUBLE_PRECISION, j, j, &
                      MPI_COMM_WORLD, ierr)
        numsent = numsent + 1
        enddo

      ! as results come back, send out more work...
      ! the variable sender tells who sent back a result and ready for more
      do j=1,nsub
        call MPI_RECV(int_sub, 1, MPI_DOUBLE_PRECISION, &
                        MPI_ANY_SOURCE, MPI_ANY_TAG, &
                        MPI_COMM_WORLD, status, ierr)
        sender = status(MPI_SOURCE)
        jj = status(MPI_TAG)
        ! print *,"+++ int_sub, int_approx: ",int_sub, int_approx
        int_approx = int_approx + int_sub

        if (numsent < nsub) then
            ! still more work to do, the next subinterval will be sent and
            ! this index also used as the tag:
            nextsub = numsent + 1 
            ab_sub(1) = a + (nextsub-1)*dx_sub
            ab_sub(2) = a + nextsub*dx_sub
            
            call MPI_SEND(ab_sub, 2, MPI_DOUBLE_PRECISION, sender, nextsub, &
                          MPI_COMM_WORLD, ierr)
            numsent = numsent + 1
          else
            ! send an empty message with tag=0 to indicate this worker
            ! is done:
            call MPI_SEND(MPI_BOTTOM, 0, MPI_INTEGER, &
                            sender, 0, MPI_COMM_WORLD, ierr)
          endif
         enddo
        endif

    ! -----------------------------------------
    ! code for Workers (Processors 1, 2, ...):
    ! -----------------------------------------
    if (proc_num /= 0) then

        if (proc_num > nsub) go to 99   ! no work expected

        do while (.true.)
            ! repeat until message with tag==0 received...

            call MPI_RECV(ab_sub, 2, MPI_DOUBLE_PRECISION, &
                          0, MPI_ANY_TAG, &
                          MPI_COMM_WORLD, status, ierr)

            j = status(MPI_TAG)   ! this is the subinterval number

            !print 12, proc_num, j       ! for debugging
12          format("+++ Process ",i4,"  received message with tag ",i6)

            if (j==0) go to 99    ! received "done" message

            int_sub = trapezoid(f,ab_sub(1),ab_sub(2),n)

            call MPI_SEND(int_sub, 1, MPI_DOUBLE_PRECISION, &
                        0, j, MPI_COMM_WORLD, ierr)

            enddo
        endif

99  continue   ! might jump to here if finished early


    call MPI_BARRIER(MPI_COMM_WORLD,ierr) ! wait for all process to print

    ! print the number of function evaluations by each thread:
    print 101,  proc_num, fevals_proc
101 format("fevals by Process ",i2,": ",i13)

    call MPI_BARRIER(MPI_COMM_WORLD,ierr) ! wait for all process to print

    call MPI_REDUCE(fevals_proc, fevals_total, 1, MPI_INTEGER, MPI_SUM, 0, &
                    MPI_COMM_WORLD, ierr)

    if (proc_num==0) then
        print 13, nsub*n, int_approx
13      format("Trapezoid approximation with ",i8," total points: ",es22.14)
        print 102, fevals_total
102     format("Total number of fevals: ",i10)
        endif

999 continue
    call MPI_FINALIZE(ierr)

end program test
