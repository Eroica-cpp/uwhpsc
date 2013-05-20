
# $CLASSHG/codes/lapack/random/Makefile

FC = gfortran
FFLAGS = -O3
LFLAGS = -lblas -llapack
.PHONY: clean

%.o : %.f90
	$(FC) $(FFLAGS) -c $<

randomsys1.exe: randomsys1.o init_random_seed.o
	$(FC) $(LFLAGS) randomsys1.o init_random_seed.o -o randomsys1.exe

randomsys2.exe: randomsys2.o init_random_seed.o
	$(FC) $(LFLAGS) randomsys2.o init_random_seed.o -o randomsys2.exe

randomsys3.exe: randomsys3.o  init_random_seed.o
	$(FC) $(LFLAGS) randomsys3.o init_random_seed.o -o randomsys3.exe

clean:
	rm -f *.o *.exe
