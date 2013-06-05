
.PHONY: clean

%.so : %.f90
	f2py -m $* -c $<

clean:
	rm -f *.so *.pyc

