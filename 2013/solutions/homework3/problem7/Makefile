
OBJECTS = functions.o newton.o test1.o
OBJECTS3 = functions.o newton.o test_quartic.o
FFLAGS = -g

.PHONY: test1 clean test_quartic

test1: test1.exe
	./test1.exe

test1.exe: $(OBJECTS)
	gfortran $(FFLAGS) $(OBJECTS) -o test1.exe

test_quartic: test_quartic.exe
	./test_quartic.exe

test_quartic.exe: $(OBJECTS3)
	gfortran $(FFLAGS) $(OBJECTS3) -o test_quartic.exe

%.o : %.f90
	gfortran $(FFLAGS) -c  $< 

clean:
	rm -f *.o *.exe *.mod

