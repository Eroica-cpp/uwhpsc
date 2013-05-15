# $CLASSHG/codes/fortran/roots/hw3/Makefile

OBJECTS = evalfunc_mod.o functions_mod.o adapquad_mod.o testquad.o

.PHONY: test plot clean clobber

FLAGS = -g

test: testquad.exe
	./testquad.exe

testquad.exe: $(OBJECTS)
	gfortran $(FLAGS) $(OBJECTS) -o testquad.exe

plot: 
	@echo "Assuming .txt files are correct!"
	python ../makeplot.py

%.o : %.f90
	gfortran $(FLAGS) -c $< 

clean:
	rm -f *.o *.exe *.mod

clobber: clean
	rm -f *.png fplotpts.txt fquadpts.txt intervals.txt info.txt
