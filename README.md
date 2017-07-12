R interface to bc calculator
----------------------------

This R package allows R users to access the arbitrary precision decimal calculation facilities of the bc calculator normally found on UNIX systems and also freely available on Windows and other systems.

To install, Ensure that the bc calculator itself is on your path (on UNIX this
should already be the case), that you have the R devtools package installed in
R and from within R run this:

```
devtools::isntall_github("ggrothendieck/r-bc")
```

The GNU bc site is here http://www.gnu.org/software/bc/ and a Windows version
of bc is available here http://gnuwin32.sourceforge.net/packages/bc.htm


Example
-------

This is an example of calculating pi. We create a "bc" object, one, with the value 1. Since anything combined with a "bc" object also becomes a "bc" object:

```
library(bc)
one <- bc(1) 
4*atan(one) 
## [1] "3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170676" ```
```

FAQ
---

1. On Windows I get an error message: Error in system(cmd, input = input, intern = TRUE) : -l not found

Use a version of bc that supports the `-l` argument (for the standard math library). Another possibility is to use the args= argument to bc which defaults to `args="-l"` but we can call bc like this `bc(...whatever..., args = "")` to avoid using -l.

2. Why does 9%2 give 0 and not 1?

In bc % only means integer remainder if `scale=0` and in the bc package scale defaults to a large value so that it is useful in high precision arithmetic. Also even without this large setting scale would still be set to nonzero because bc is called with the `-l` option to enable the math package and that option automatically sets `scale=20` (if scale is not otherwise set).

If you do wish to set scale to zero then use bc("9%2", scale=0) or use `options(bc.scale=0)` to change the default to 0. If the latter is placed in your .Rprofile file then the scale will be set to 0 in subsequent sessions as well.

For more info on how % works in bc see the bc man page.
