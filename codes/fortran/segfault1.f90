
! $UWHPSC/codes/fortran/segfault1.f90

program segfault1

    implicit none
    real(kind=8) :: a(3)
    integer i

    do i = 1,1000
        a(i) = 5.
        print *, i
        enddo

    print *, "Finished running"

end program segfault1

