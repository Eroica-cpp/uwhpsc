
program laplace_mc

    use problem_description, only: utrue,nx,ny,ax,ay,dx,dy
    use random_util, only: init_random_seed
    use mc_walk, only: random_walk, many_walks, nwalks

    implicit none
    integer :: i,i0,j0,max_steps,seed1,n_mc,n_success,n_total
    real(kind=8) :: x0,y0,u_true,u_mc,u_sum_old,u_sum_new, u_mc_total,error

    open(unit=25, file='mc_laplace_error.txt', status='unknown')

    x0 = 0.9d0
    y0 = 0.6d0
    i0 = nint((x0-ax)/dx)
    j0 = nint((y0-ay)/dy)

    ! shift (x0,y0) to a grid point if it wasn't already:
    x0 = ax + i0*dx
    y0 = ay + j0*dy

    max_steps = 100*max(nx,ny)
    !max_steps = 10

    nwalks = 0   ! to keep track of calls to random_walk

    u_true = utrue(x0, y0)

    seed1 = 12345   ! or set to 0 for random seed
    call init_random_seed(seed1)

    n_mc = 10
    call many_walks(i0, j0, max_steps, n_mc, u_mc, n_success)

    ! start accumulating totals:
    u_mc_total = u_mc
    n_total = n_success

    ! relative error gives estimate of number of correct digits:
    error = abs(u_mc_total - u_true) / abs(u_true)
    write(25,'(i10,e23.15,e15.6)') n_total, u_mc_total, error
    print '(i10,e23.15,e15.6)', n_total, u_mc_total, error

	
    ! loop to add successively double the number of points used:

    do i=1,12
        ! compute approximation with new chunk of points
        call many_walks(i0, j0, max_steps, n_mc, u_mc, n_success)

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

        n_mc = 2*n_mc
        enddo

    print '("Final approximation to u(x0,y0): ",es22.14)',u_mc_total
    print '("Total number of random walks: ",i10)',nwalks
    

end program laplace_mc
