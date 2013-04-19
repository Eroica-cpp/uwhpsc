! $UWHPSC/codes/fortran/circles/main.f90

program main

    use circle_mod, only: pi, area
    implicit none
    real(kind=8) :: a

    call initialize()   ! sets pi

    ! print module variable pi:
    print *, 'pi = ', pi

    ! test the area function from module:
    a = area(2.d0)
    print *, 'area for a circle of radius 2: ', a

end program main
