! $UWHPSC/codes/mpi/quadrature/testquad.f90
! Test the quadrature module.

program main

    use mpi
    use quadrature_mod, only: simpson
    use functions_mod, only: g, gint, gevals, k

    implicit none
    real(kind=8) :: a, b, int_approx, int_true, error
    integer :: proc_num, ierr, n

    call MPI_INIT(ierr)

    k = 10.d0    ! wave number
    n = 50000    ! number of intervals

    a = 0.d0
    b = 3.d0
    int_true = gint(b) - gint(a)

    gevals = 0  ! keeps track of number of g evals
    call simpson(g, a, b, n, int_approx)
    error = int_approx - int_true


    call MPI_COMM_RANK(MPI_COMM_WORLD, proc_num, ierr)
    if (proc_num==0) then
        print 62, int_approx, int_true, error
        endif

    print 65, gevals, proc_num

62  format("   approx = ",e20.13, /, &
           "   true =   ",e20.13, /, &
           "   error =  ",e10.3)
65  format("   g was evaluated ",i9," times by proc ",i1)

    call MPI_FINALIZE(ierr)

end program main
