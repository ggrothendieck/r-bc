This [R](http://www.r-project.org) package allows R users to access the arbitrary precision **decimal** calculation facilities of the bc calculator normally found on UNIX systems and also freely available [on Windows](http://r-bc.googlecode.com/files/bc_1.05.zip) and other systems.

# Examples #

Here is an example of calculating pi.  We create a `"bc"` object, `one`, with the value `1`. Since anything combined with a `"bc"` object also becomes a `"bc"` object:

```
> # make sure you have the bc calculator itself on your path
> # UNIX users will have it and Windows users can use the bcInstall() command
> library(bc) # or source("http://r-bc.googlecode.com/svn/trunk/R/bc.R")
> one <- bc(1)
> 4*atan(one)
[1] "3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170676"
```

An example of using this package for decimal to hex conversion can be found in this  [r-help post](https://stat.ethz.ch/pipermail/r-help/2009-May/197562.html) .

For more examples see the [R Wiki High Precision Arithmetic](http://rwiki.sciviews.org/doku.php?id=misc:r_accuracy:high_precision_arithmetic#berkeley_calculator) page.

# FAQ #

### 1. On Windows I get an error message: Error in system(cmd, input = input, intern = TRUE) : -l not found ###

Use a version of bc that supports the `-l` argument (for the standard math library). See [downloads tab](http://code.google.com/p/r-bc/downloads/list) above or the [bc for Windows (UnxUtils)](http://sourceforge.net/projects/unxutils) link to the right.  Another possibility is to use the `args=` argument to bc which defaults to `args="-l"` but we can call bc like this `bc(...whatever..., args = "")` to avoid using `-l`.

Some other possible problems are discussed [here](https://stat.ethz.ch/pipermail/r-help/2014-May/374344.html).

### 2. Why does 9%2 give 0 and not 1? ###

In bc % only means integer remainder if `scale=0` and in the bc package scale defaults to a large value so that it is useful in high precision arithmetic.  Also even without this large setting scale would still be set to nonzero because bc is called with the -l option to enable the math package and that option automatically sets `scale=20` (if scale is not otherwise set).

If you do wish to set scale to zero then use `bc("9%2", scale=0) or use `options(bc.scale=0)` to change the default to 0.  If the latter is placed in your .Rprofile file then the scale will be set to 0 in subsequent sessions as well.

For more info on how % works in bc see the [bc man page](http://x-bc.sourceforge.net/man_bc.html), [this r-help post](https://stat.ethz.ch/pipermail/r-help/2010-July/247049.html) and the links cited in that post.
