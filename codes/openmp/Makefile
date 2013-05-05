# $CLASSHG/codes/openmp/Makefile

# Usage:  to try out yeval.f90, for example:
#   make test FNAME=yeval

FC = gfortran
FFLAGS = -fopenmp
LFLAGS = 

.PHONY: clean, test

FNAME ?= test

%.o : %.f90
	$(FC) $(FFLAGS) -c $<

$(FNAME).exe: $(FNAME).f90
	$(FC) $(FFLAGS) $(LFLAGS) $(FNAME).f90 -o $(FNAME).exe

test: $(FNAME).exe
	time ./$(FNAME).exe

clean:
	rm -f *.o *.exe
