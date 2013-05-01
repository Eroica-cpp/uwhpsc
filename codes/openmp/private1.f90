! $UWHPSC/codes/openmp/private1.f90

program private1
   
   use omp_lib
   implicit none
   integer :: n
   integer :: i, nthreads
   real(kind=8), dimension(100) :: x
   real(kind=8) :: y

   ! Specify number of threads to use:
   nthreads = 2
   !$ call omp_set_num_threads(nthreads)
   !$ print "('Using OpenMP with ',i3,' threads')", nthreads

   n = 7
   y = 2.d0
   !$omp parallel do firstprivate(y) lastprivate(y)
   do i=1,n
      y = y + 10.d0
      x(i) = y
      !$omp critical
      print *, "i = ",i,"  x(i) = ",x(i)
      !$omp end critical
   enddo

   print *, "At end, y = ",y


end program private1

