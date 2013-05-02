! $UWHPSC/codes/openmp/test2.f90
! This version does not use a critical block ! 
! The output may be erroneous.

program test2
   
   use omp_lib
   implicit none
   integer :: thread_num

   integer :: nthreads
   
   ! Specify number of threads to use:
   !$ call omp_set_num_threads(2)
  
   print *, "Testing openmp, you should see each thread print..."
   print *, "*** This version does not use a critical block ! ***"

   !$omp parallel 
   !$ thread_num = omp_get_thread_num()    ! unique for each thread
   !$ print *, "This thread = ",thread_num ! each thread prints
   !$omp end parallel 

end program test2
