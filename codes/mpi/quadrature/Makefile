# $UWHPSC/codes/fortran/mpi/quadrature/Makefile

OBJECTS = functions_mod.o quadrature_mod.o testquad.o

NUMPROCS ?= 4

.PHONY: test plot clean

FLAGS ?= 

test: testquad.exe
	mpiexec -n $(NUMPROCS) ./testquad.exe

testquad.exe: $(OBJECTS)
	mpif90 $(FLAGS) $(OBJECTS) -o testquad.exe

%.o : %.f90
	mpif90 -c $(FLAGS) $< 

clean:
	rm -f *.o *.exe *.mod

