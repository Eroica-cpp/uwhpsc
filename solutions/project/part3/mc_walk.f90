
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
        ub = 0.d0  ! this value should not be used
    else
        iabort = 0
    endif

    nwalks = nwalks + 1
        
end subroutine random_walk


subroutine many_walks(i0, j0, max_steps, n_mc, u_mc, n_success)
    implicit none
    integer, intent(in) :: i0,j0,max_steps,n_mc
    integer, intent(out) :: n_success
    real(kind=8), intent(out) :: u_mc

    integer :: k, iabort, nb_sum
    real(kind=8) :: ub,ub_sum

    ub_sum = 0.d0
    nb_sum = 0

    do k=1,n_mc
        call random_walk(i0, j0, max_steps, ub, iabort)
        if (iabort == 0) then
            ub_sum = ub_sum + ub
            nb_sum = nb_sum + 1
            endif
        enddo

    u_mc = ub_sum / nb_sum
    n_success = nb_sum
    
end subroutine many_walks


end module mc_walk
