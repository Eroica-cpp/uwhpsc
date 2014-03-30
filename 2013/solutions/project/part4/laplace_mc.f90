
program laplace_mc

    use mpi

    use problem_description, only: utrue,nx,ny,ax,ay,dx,dy
    use random_util, only: init_random_seed
    use mc_walk, only: random_walk, many_walks, nwalks

    implicit none
    integer :: i,i0,j0,max_steps,seed1,n_mc,n_success,n_total,nwalks_total
    real(kind=8) :: x0,y0,u_true,u_mc,u_sum_old,u_sum_new, u_mc_total,error

    integer :: num_procs, proc_num, ierr

    call MPI_INIT(ierr)
    call MPI_COMM_SIZE(MPI_COMM_WORLD, num_procs, ierr)
    call MPI_COMM_RANK(MPI_COMM_WORLD, proc_num, ierr)


    open(unit=25, file='mc_laplace_error.txt', status='unknown')

    x0 = 0.9d0
    y0 = 0.6d0
    i0 = nint((x0-ax)/dx)
    j0 = nint((y0-ay)/dy)

    ! shift (x0,y0) to a grid point if it wasn't already:
    x0 = ax + i0*dx
    y0 = ay + j0*dy

    max_steps = 100*max(nx,ny)

    u_true = utrue(x0, y0)

    seed1 = 12345   ! or set to 0 for random seed
    seed1 = seed1 + 97*proc_num  ! unique for each process
    call init_random_seed(seed1)

    nwalks = 0  ! to keep track of how many walks each process does

    n_mc = 10
    call many_walks(i0, j0, max_steps, n_mc, u_mc, n_success)

    if (proc_num == 0) then

        ! start accumulating totals:
        u_mc_total = u_mc
        n_total = n_success

        ! relative error gives estimate of number of correct digits:
        error = abs(u_mc_total - u_true) / abs(u_true)
        print '(i10,e23.15,e15.6)', n_total, u_mc_total, error
        write(25,'(i10,e23.15,e15.6)') n_total, u_mc_total, error
        endif

    ! loop to add successively double the number of points used:

    do i=1,12
        ! compute approximation with new chunk of points
        call many_walks(i0, j0, max_steps, n_mc, u_mc, n_success)

        if (proc_num == 0) then
            ! update estimate of u based on doubling number:
            ! but not that not all were successful:
            u_sum_old = u_mc_total * n_total
            u_sum_new = u_mc * n_success
            n_total = n_total + n_success
            u_mc_total = (u_sum_old + u_sum_new) / n_total

            ! relative error:
            error = abs(u_mc_total - u_true) / abs(u_true)

            write(25,'(i10,e23.15,e15.6)') n_total, u_mc_total, error
            print '(i10,e23.15,e15.6)', n_total, u_mc_total, error
            endif
        n_mc = 2*n_mc
        enddo

    call MPI_REDUCE(nwalks,nwalks_total,1,MPI_INTEGER,MPI_SUM,0, &
                 MPI_COMM_WORLD,ierr)

    if (proc_num == 0) then
        print '("Final approximation to u(x0,y0): ",es22.14)',u_mc_total
        print '("Total walks performed by all processes: ",i10)', nwalks_total
        endif

    call MPI_BARRIER(MPI_COMM_WORLD,ierr)

    print '("Walks performed by Process ",i2,": ",i10)', &
        proc_num,nwalks
    
    call MPI_FINALIZE(ierr)


end program laplace_mc
