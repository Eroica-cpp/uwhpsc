! $UWHPSC/codes/fortran/loops1.f90

program loops1

   implicit none
   integer :: i

   do i=1,3           ! prints 1,2,3
      print *, i
      enddo

   do i=5,11,2        ! prints 5,7,9,11
      print *, i
      enddo

   do i=6,2,-1        ! prints 6,5,4,3,2
      print *, i
      enddo

   i = 0
   do while (i < 5)   ! prints 0,1,2,3,4
      print *, i
      i = i+1
      enddo

end program loops1

