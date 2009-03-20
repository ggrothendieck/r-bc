
bc <- function(..., scale = getOption("bc.scale"), logical = FALSE, 
	cmd = "bc -l") {
	if (is.null(scale)) scale <- 100
    input <- paste(..., sep = "")
    out <- system(cmd, input = c(paste("scale", scale, sep = "="), 
		paste(..., sep = "")), intern = TRUE)
	if (nchar(Sys.getenv("BC_LINE_LENGTH")) == 0) {
		out <- paste(sub("\\\\", "", out), collapse= "")
	}
	result <- structure(out, class = c("bc", "character"))
    if (logical) as.logical(result) else result
}

# - A bc object is a character string with class "bc".
# - The ordinary R operators: +, -, etc. can operate on bc objects
# giving new bc objects.
# - printing a bc object causes it to be passes to bc and back

as.character.bc <- function(x, ...) as.character(unclass(x))
as.expression.bc <- function(x, ...) bc(x, ...)[[1]]

as.bc <- function(x, ...) UseMethod("as.bc")

Ops.bc <- function (e1, e2) 
    if (missing(e2)) { bc(.Generic, e1)
    } else bc(e1, .Generic, e2)

transtab <- matrix( c("exp", "e", 
					  "log", "l", 
					  "sin", "s",
					  "cos", "c"), nc = 2, byrow = TRUE)

Math.bc <- function(x, ...) {
	idx <- match(.Generic, transtab[,1], nomatch = 0)
	fn <- if (idx > 0) transtab[idx, 2] else .Generic
	bc(fn, "(", x, ")")
}

print.bc <- function(x, ...) print(unclass(bc(unclass(x), ...)))

