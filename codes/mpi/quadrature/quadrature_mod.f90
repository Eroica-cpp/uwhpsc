! $UWHPSC/codes/mpi/quadrature/quadrature_mod.f90

! Quadrature rules to approximate definite integrals.

module quadrature_mod

    use mpi

contains


subroutine simpson(f, a, b, n, integral)
    implicit none
    real(kind=8), intent(in) :: a,b
    integer, intent(in) :: n
    real(kind=8), intent(out) :: integral
    real(kind=8), external :: f
    ! local variables
    real(kind=8) :: xi, dx
    real(kind=8) :: int_proc, a_proc, b_proc, xi_proc
    integer :: numprocs, ierr,points_per_proc,proc_num
    integer :: i,istart,iend

    call MPI_COMM_SIZE(MPI_COMM_WORLD, numprocs, ierr)
    call MPI_COMM_RANK(MPI_COMM_WORLD, proc_num, ierr)

    ! Determine how many points to handle with each proc
    points_per_proc = (n + numprocs - 1)/numprocs
    if (proc_num == 0) then   ! Only one proc should print to avoid clutter
        print *, "points_per_proc = ", points_per_proc
    end if

    ! Determine start and end index for this proc's points
    istart = proc_num * points_per_proc + 1
    iend = min((proc_num + 1)*points_per_proc, n)

    dx = (b-a) / n
    integral = 0.d0

    a_proc = a + dx*(istart-1)
    b_proc = a + dx*iend
    int_proc = f(a_proc) + f(b_proc)


    ! Diagnostic: tell the user which points will be handled by which proc
    ! Note: print everything in a single print statement so all the 
    ! info for a given process gets printed together.

    print 201, proc_num, istart, iend, a_proc, b_proc
201 format("Process ",i2," will take i = ",i9," through i = ",i9, /, &
           "   Corresponding to a_proc = ",e13.6," and b_proc = ",e13.6)

    do i=istart+1,iend
        xi_proc = a + dx*(i-1)
        int_proc = int_proc + 2.d0*f(xi_proc)
        enddo

    do i=istart,iend
        xi_proc = a + dx*(i-0.5d0)
        int_proc = int_proc + 4.d0*f(xi_proc)
        enddo

    call MPI_REDUCE(int_proc,integral,1,MPI_DOUBLE_PRECISION,MPI_SUM,0, &
                        MPI_COMM_WORLD,ierr)

    if (proc_num == 0) then
        integral = dx*integral / 6.d0
    endif

    ! broadcast to all other processes so they all return the right thing:
    call MPI_BCAST(integral, 1, MPI_DOUBLE_PRECISION, 0, MPI_COMM_WORLD, ierr)

end subroutine simpson


end module quadrature_mod
