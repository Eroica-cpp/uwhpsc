
# $UWHPSC/codes/lapack/random/Makefile

FC = gfortran
FFLAGS = -O3
LFLAGS = -lblas -llapack
.PHONY: clean test1 test2 test3

%.o : %.f90
	$(FC) $(FFLAGS) -c $<

randomsys1.exe: randomsys1.o init_random_seed.o
	$(FC) randomsys1.o init_random_seed.o $(LFLAGS) -o randomsys1.exe

test1: randomsys1.exe
	./randomsys1.exe

randomsys2.exe: randomsys2.o init_random_seed.o
	$(FC) randomsys2.o init_random_seed.o $(LFLAGS) -o randomsys2.exe

test2: randomsys2.exe
	./randomsys2.exe

randomsys3.exe: randomsys3.o  init_random_seed.o
	$(FC) randomsys3.o init_random_seed.o $(LFLAGS) -o randomsys3.exe

test3: randomsys3.exe
	./randomsys3.exe

clean:
	rm -f *.o *.exe
