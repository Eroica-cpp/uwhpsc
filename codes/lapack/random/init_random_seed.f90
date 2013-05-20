
! Initialize the random number generator using current time,
! so a new sequence of random numbers is generated each 
! execution time.

! Taken from http://gcc.gnu.org/onlinedocs/gfortran/RANDOM_005fSEED.html

SUBROUTINE init_random_seed()
    INTEGER :: i, n, clock
    INTEGER, DIMENSION(:), ALLOCATABLE :: seed
  
    CALL RANDOM_SEED(size = n)
    ALLOCATE(seed(n))
  
    CALL SYSTEM_CLOCK(COUNT=clock)
  
    seed = clock + 37 * (/ (i - 1, i = 1, n) /)
    CALL RANDOM_SEED(PUT = seed)
  
    print *, "Using random seed = ", seed
    print *, " "

    DEALLOCATE(seed)
END SUBROUTINE

