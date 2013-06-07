! $UWHPSC/codes/io/binwrite.f90

! Illustrate writing out an array using binary (unformatted) vs. ASCII.
! Creates two files u.bin (binary) and u.txt (ASCII).
! The ASCII file should be three times larger if you do:
!  $  ls -l u.*


program binwrite
    
    integer, parameter :: m = 100, n = 500
    real(kind=8) :: u(m,n)

    open(unit=20, file="u.bin", form="unformatted", &
         status="unknown", access="stream")
    open(unit=21, file="u.txt")
    open(unit=22, file="mn.txt")

    do j=1,n
        do i=1,m
            u(i,j) = dble(m*(j-1) + i)
        enddo
     enddo

    write(20) u  ! writes array in binary

    write(21,'(e24.16)') u  ! writes array in ascii

    write(22,*) m,n

    close(20)

end program binwrite
