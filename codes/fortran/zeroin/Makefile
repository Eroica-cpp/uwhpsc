# $CLASSHG/codes/fortran/zeroin/Makefile

OBJECTS = zeroin.o myfcn.o testzeroin.o

FFLAGS = -g

.PHONY: test plot clean clobber

test: testzeroin.exe
	./testzeroin.exe

testzeroin.exe: $(OBJECTS)
	gfortran $(OBJECTS) -o testzeroin.exe

%.o : %.f
	gfortran $(FFLAGS) -c $< 

%.o : %.f90
	gfortran $(FFLAGS) -c $< 

clean:
	rm -f *.o *.exe *.mod

