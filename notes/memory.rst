

.. _memory:

=============================================================
Storing information in binary
=============================================================

All information stored in a computer must somehow be encoded as a sequence
of 0's and 1's, because all
storage devices consist of a set of locations that can have one of two possible
states.  One state represents 0, the other state represents 1.  For example,
on a CD or DVD there are billions of locations where either small pit has
been created by a laser beam (representing a 1) or no pit exists
(representing a 0).  An old magnetic tape (such as a audio cassette tape or
VHS video tape) consisted of a sequence of locations that could be
magnetized with an upward or downward polarization, representing 0 or 1.

A single storage location stores a single bit (binary digit) of information.
A set of 8 bits is a byte and this is generally the smallest unit of
information a computer deals with.  A byte can store :math:`2^8 = 256` different
patterns of 0's and 1's and these different patterns might represent
different things, depending on the context.  

Integers
--------

If we want to store an integer
then it makes sense to store the binary representation of the integer, and
in one byte we could store any of the numbers 0 through 255, with the usual
binary representation::

        00000000 = 0
        00000001 = 1
        00000010 = 2
        00000011 = 3
        00000100 = 4
        etc.
        11111111 = 255

Of course many practical problems involve integers larger than 256, and possibly
negative integers as well as positive.  So in practice a single integer is
generally stored using more than 1 byte.  The default for most computer
languages is to use 4 bytes for an integer, which is 32 bits.  One bit is
used to indicate whether the number is positive of negative, leaving 31 bits
to represent the values from 0 to :math:`2^{31} = 2147483648` as well as the
negatives of these values.  Actually it's a bit more complicated (no pun
intended) since the scheme just described allows storing both +0 and -0  and
a more complicated system allows storing one more integer, and in practice
the two's complement representation is used, as described at 
`[wikipedia] <http://en.wikipedia.org/wiki/Two%27s_complement>`_, which
shows a table of how the numbers -128 through 127 would actually be
represented in one byte.

Real numbers
------------

If we are dealing with real numbers rather than integers, a more complicated
system is needed for storing arbitrary numbers over a fairly wide range
in a fixed number of bytes.  

Note that fractions can be represented in binary using inverse powers of 2.
For example, the decimal number 5.625 can be expressed as 
:math:`4+1+\frac 1 2 + \frac 1 8`, i.e.::
    
    5.625 = 1*2^2 + 0*2^1 + 1*2^0 + 1*2^{-1} + 0*2^{-2} + 1*2^{-3}

and hence as 101.101 in binary. 

Early computers used *fixed point* notation in
which it was always assumed that a certain number of bits to the right of
the decimal point were stored.  This does not work well for most scientific
computations, however.  Instead computers now store real numbers as
*floating point numbers*, by storing a *mantissa* and an *exponent*.

The decimal number 5.625 could be written as :math:`0.5625 \times 10^1` in
normalized form, with mantissa 0.5625 and exponent 1.

Similarly, the binary number 101.101 in floating point form has mantissa
0.101101 and exponent 10 (the number 2 in binary, since the mantissa must be
multiplied by :math:`2^2 = 4` to shift the binary point by two spaces).

Most scientific computation is done using 8-byte representation of real
numbers (64 bits) in which 52 bits are used for the mantissa and 11 bits for
the exponent (and one for the sign). 
See `[wikipedia] <http://en.wikipedia.org/wiki/Floating_point>`_ for more
details.  This is the standard for objects of type *float* in Python.  In
Fortran this is sometimes called *double precision* because 4-byte floating
point numbers (*single precision*) were commonly used for non-scientific
applications.  8 byte floats are generally inadequate for most scientific 
computing problems, but there are some problems for which higher precision
(e.g. *quad precision*, 16 bytes) is required.  


Before the 1980's, different computer manufacturers came up with their own
conventions for how to store real numbers, often handling computer
arithmetic poorly and leading to severe problems in portability of computer
codes between machines.  The IEEE standards have largely solved this
problem.   
See `[wikipedia] <http://en.wikipedia.org/wiki/IEEE_floating_point>`_ for more
details.

Text
----

If we are storing text, such as the words you are now reading, the
characters must also be encoded as strings of 0's and 1's.  Since a single
byte can represent 256 different things, text is generally encoded using one
byte for each character.  In the English language we need 52 different
patterns to represent all the possible letters (one for each lower case
letter and a distinct pattern for the corresponding upper case letter).  We
also need 10 patterns for the digits and a fairly large number of other
patterns to represent each other symbol (e.g. punctuation symbols, dollar
signs, etc.) that might be used.  

A standard 8-bit encoding is UTF-8 
`[wikipedia] <http://en.wikipedia.org/wiki/UTF-8>`_.
This is an extension of the earlier standard called ASCII
`[wikipedia] <http://en.wikipedia.org/wiki/ASCII>`_, which only used 7 bits.  
For encoding a wider variety of symbols and characters (such as
Chinese, Arabic, etc.) there are standard encodings UTF-16 and
UTF-32 using more bits for each character.

See :ref:`punchcard` for an example of how the ASCII character are
represented on an punch card, an early form of computer memory.

Obviously, in order to interpret a byte stored in the computer, such as
01001011 properly, the computer needs to know whether it represents a UTF-8
character, a 1-byte integer, or something else.  

.. _colors:

Colors
------

Another thing a string of 0's and 1's
might represent is a color, for example one pixel in an image that is
being displayed.  Each pixel is one dot of light and a string of 0's and 1's
must be used to indicate what color each pixel should be.  There are various
possible ways to specify a color.  One that is often used is to specify an
RGB triple, three integers that indicate the amount of Red, Green, and Blue
in the desired color.  Often each value is allowed to range from 0
(indicating none) to 255 (maximal amount). These values can all be stored in
1 byte of data, so with this system 3 bytes (24 bits) are used to store the
color of a single pixel.  The color red, for example, has maximal R and 0
for G and B and hence has the first byte 256 and the next two bytes 0 and 0.
Here is red a few other colors in their RGB and binary representations::

        [255,  0,  0]  = 11111111 00000000 00000000 = red
        [  0,  0,  0]  = 00000000 00000000 00000000 = black
        [255,255,255]  = 11111111 11111111 11111111 = white
        [ 57, 39, 91]  = 00111001 00100111 01011011 = official Husky purple
        [240,213,118]  = 11110000 11010101 01110110 = official Husky gold

Colors in html documents and elsewhere are often specified by writing out
exactly what each values each of the bytes should have.  Writing out the
bits as above is generally awkward for humans, so instead graphics languages
like Matlab or Matplotlib in Python generally allow you to specify the 
RGB triple in terms of fractions between 0 and 1 (divide the RGB values
above by 255 to get the fractions)::

        [1.0, 0.0, 0.0]  = red
        [0.0, 0.0, 0.0]  = black
        [1.0, 1.0, 1.0]  = white
        [ 0.22352941,  0.15294118,  0.35686275] = official Husky purple
        [ 0.94117647,  0.83529412,  0.4627451 ] = official Husky gold

Another way is common in html documents (and also allowed in Matplotlib),
where the color red is denoted by the string::

        '#ff0000' = red
        '#000000' = black
        '#ffffff' = white
        '#39275b' = official Husky purple
        '#f0d576' = official Husky gold

This string is written using *hexadecimal* notation (see below).  
The # sign just
indicates that it's a hexidecimal string and it is followed by 3 2-digit
hexidecimal numbers, e.g. for red they are ff, 00, and 00.

The latter two colors can be seen in the header of this webpage.

To find the hex string for a desired color, or view the color for a given
string, try the `farbtastic demo <http://acko.net/dev/farbtastic>`_.
See also `[wikipedia-web-colors] <http://en.wikipedia.org/wiki/Web_colors>`_ 
or `this page of colors
<http://www.webdiner.com/annexe/hexcode/hexcode.htm>`_
showing RGB triples and hexcodes.

.. _hex:

Hexidecimal numbers
-------------------

A hexidecimal number is in base 16, e.g. the hexidecimal 345 represents::

        345 = 3*(16)**2 + 4*(16)**1 + 5 

which is 837 in decimal notation.  Each hexidecimal digit can take one of 16
values and so in addition to the digits 0, 1, ..., 9 we need symbols to
represent 10, 11, 12, 13, 14, and 15.  For these the letters a,b,c,d,e,f are
used, so for example::

        a4e = 10*(16)**2 + 4*(16) + 14

which is 2638 in decimal notation.  

Hex notation is a convenient way to express binary numbers because there is
a very simple way to translate between hex and binary.  To convert the hex
number a4e to binary, for example, just translate each hex digit separately
into binary, a = 1010, 4 = 0100, e = 1110, and then catenate these together,
so::

        a4e = 101001001110

in binary.  Conversely, to convert a binary number such as 100101101 to hex,
group the bits in groups of 4 (starting at the right, adding 0's to the left
if necessary) and convert each group into a hex digit::

       1100101101 = 0011 0010 1101 = 32d in hex.

Returning to the hex notation for colors, we can see that '#ff0000'
corresponds to 111111110000000000000000, the binary string representing pure
red.

Machine instructions
--------------------

In addition to storing data (numbers, text, colors, etc.) as strings of
bits, we must also store the computer instructions that make up a computer
program as a string of bits.  This may seem obvious now, but was actually a
revolutionary idea when it was first proposed by the eminant mathematician
(and one of the earliest "computer scientists") John von Neumann.  The idea
of a "von Neumann" machine in which the computer program is stored in the
same way the data is, and can be modified at will to cause the computer to
do different things, originated in 1930s and 40s through work of von
Neumann, Turing, and Zuse (see `[wikipedia]
<http://en.wikipedia.org/wiki/Von_Neumann_architecture>`_).
Prior to this time, computers were designed to do one particular set of
operations, executing one algorithm, and only the data could be easily
changed.  To "reprogram" the computer to do something different required
physically rewiring the circuits.

Current computers store a sequence of instructions to be executed, as binary
strings.  These strings are different than the strings that might represent
the instructions when the human-readable program is converted to ASCII to
store as a text file.  

See :ref:`machine_code_and_assembly` for more about this.
