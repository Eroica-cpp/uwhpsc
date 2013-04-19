
# $UWHPSC/codes/fortran/multifile1/Makefile

output.txt: main.exe
	./main.exe > output.txt

main.exe: main.o sub1.o sub2.o
	gfortran main.o sub1.o sub2.o -o main.exe

main.o: main.f90
	gfortran -c main.f90
sub1.o: sub1.f90
	gfortran -c sub1.f90
sub2.o: sub2.f90
	gfortran -c sub2.f90


