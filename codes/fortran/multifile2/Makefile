
# $UWHPSC/codes/fortran/multifile1/Makefile

# Note: need to compile sub1m before main:
OBJECTS = sub1m.o main.o 

main.exe: $(OBJECTS)
	gfortran $(OBJECTS) -o main.exe

%.o : %.f90
	gfortran -c $< 


