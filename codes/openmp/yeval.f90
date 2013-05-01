! $UWHPSC/codes/openmp/yeval.f90

! If this code gives a Segmentation Fault when compiled and run with -fopenmp 
! Then you could try:
!   $ ulimit -s unlimited
! to increase the allowed stack size.
! This may not work on all computers.  On a Mac the best you can do is
!   $ ulimit -s hard


program yeval
   
   use omp_lib
   implicit none
   integer, parameter :: n = 100000000
   integer :: i, nthreads
   real(kind=8), dimension(n) :: y
   real(kind=8) :: dx, x

   ! Specify number of threads to use:
   !$ print *, "How many threads to use? "
   !$ read *, nthreads
   !$ call omp_set_num_threads(nthreads)
   !$ print "('Using OpenMP with ',i3,' threads')", nthreads

   dx = 1.d0 / (n+1.d0)

   !$omp parallel do private(x) 
   do i=1,n
      x = i*dx
      y(i) = exp(x)*cos(x)*sin(x)*sqrt(5*x+6.d0)
   enddo

   print *, "Filled vector y of length", n

end program yeval

