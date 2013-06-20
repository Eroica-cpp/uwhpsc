
module mc_walk

implicit none
integer :: nwalks

contains


subroutine random_walk(i0, j0, max_steps, ub, iabort)

    use problem_description, only: nx,ny,ax,ay,dx,dy,uboundary

    implicit none
    integer, intent(in) :: i0,j0,max_steps
    real(kind=8), intent(out) :: ub
    integer, intent(out) :: iabort

    real(kind=4), allocatable :: r(:)
    integer i,j,istep
    real(kind=4) :: rr
    real(kind=8) :: xb,yb

    allocate(r(max_steps))

    i = i0
    j = j0
    call random_number(r)

    do istep=1,max_steps
        rr = r(istep)
        if (rr < 0.25d0) then
            i = i-1
          else if (rr < 0.5d0) then
            i = i+1
          else if (rr < 0.75d0) then
            j = j-1
          else 
            j = j+1
          endif

        if (i*j*(nx+1-i)*(ny+1-j) == 0) then
            xb = ax + i*dx
            yb = ay + j*dy
            ub = uboundary(xb, yb)
            exit  ! end the walk
            endif
        enddo

    
    if (istep == max_steps+1) then
        iabort = 1
        ub = 0.d0  ! this value won't be used
    else
        iabort = 0
    endif

    nwalks = nwalks + 1
        
end subroutine random_walk


subroutine many_walks(i0, j0, max_steps, n_mc, u_mc, n_success)

    use mpi

    implicit none
    integer, intent(in) :: i0,j0,max_steps,n_mc
    integer, intent(out) :: n_success
    real(kind=8), intent(out) :: u_mc

    integer :: k, iabort, nb_sum
    real(kind=8) :: ub,ub_sum

    integer, dimension(MPI_STATUS_SIZE) :: status
    integer :: num_procs, proc_num, ierr, j, numsent, sender

    call MPI_COMM_SIZE(MPI_COMM_WORLD, num_procs, ierr)
    call MPI_COMM_RANK(MPI_COMM_WORLD, proc_num, ierr)

    ! -----------------------------------------
    ! code for Master (Processor 0):
    ! -----------------------------------------


    if (proc_num == 0) then
      ub_sum = 0.d0
      nb_sum = 0

      numsent = 0
      ! send the first batch to get all workers working:
      do j=1,min(num_procs-1, n_mc)
          call MPI_SEND(MPI_BOTTOM, 0, MPI_INTEGER, j, 1, &
                      MPI_COMM_WORLD, ierr)
          numsent = numsent + 1
          enddo

      ! as results come back, send out more work...
      ! the variable sender tells who sent back a result and ready for more
      do k=1,n_mc
        call MPI_RECV(ub, 1, MPI_DOUBLE_PRECISION, &
                        MPI_ANY_SOURCE, MPI_ANY_TAG, &
                        MPI_COMM_WORLD, status, ierr)
        sender = status(MPI_SOURCE)
        iabort = status(MPI_TAG)
        if (iabort == 0) then
            ub_sum = ub_sum + ub
            nb_sum = nb_sum + 1
            endif
        if (numsent < n_mc) then
            ! still more work to do
            call MPI_SEND(MPI_BOTTOM, 0, MPI_INTEGER, sender, 1, &
                      MPI_COMM_WORLD, ierr)
            numsent = numsent + 1
          else
            ! send an empty message with tag=0 to indicate this worker
            ! is done:
            call MPI_SEND(MPI_BOTTOM, 0, MPI_INTEGER, &
                            sender, 0, MPI_COMM_WORLD, ierr)
          endif
         enddo

        u_mc = ub_sum / nb_sum
        n_success = nb_sum
        endif

    ! -----------------------------------------
    ! code for Workers (Processors 1, 2, ...):
    ! -----------------------------------------
    if (proc_num /= 0) then

        if (proc_num > n_mc) go to 99   ! no work expected

        do while (.true.)
            ! repeat until message with tag==0 received...

            call MPI_RECV(MPI_BOTTOM, 0, MPI_INTEGER, &
                          0, MPI_ANY_TAG, MPI_COMM_WORLD, status, ierr)

            j = status(MPI_TAG)   ! this tells worker whether to stop

            if (j==0) go to 99    ! received "done" message

            call random_walk(i0, j0, max_steps, ub, iabort)
            call MPI_SEND(ub, 1, MPI_DOUBLE_PRECISION, &
                        0, iabort, MPI_COMM_WORLD, ierr)

            enddo
        endif

99  continue   ! jump here when done

    call MPI_BARRIER(MPI_COMM_WORLD,ierr) ! wait for all processes to finish

end subroutine many_walks


end module mc_walk
