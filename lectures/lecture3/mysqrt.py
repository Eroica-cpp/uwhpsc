x = 9.
s = 1.
for k in range(6):
    print "Before iteration %s, s = %s" % (k,s)
    s = 0.5 * (s + x/s)
print "After %s iterations, s = %s" % (k+1,s)    