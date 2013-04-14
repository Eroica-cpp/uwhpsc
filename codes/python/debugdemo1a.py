"""
$UWHPSC/codes/python/debugdemo1a.py

Debugging demo using print statements
"""

x = 3.
y = -22.

def f(z):
    x = z+10
    print "+++ in function f: x = %s, y = %s, z = %s" % (x,y,z)
    return x

print "+++ before calling f: x = %s, y = %s" % (x,y)
y = f(x)
print "+++ after calling f: x = %s, y = %s" % (x,y)

