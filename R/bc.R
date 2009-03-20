bc <- function(
        ...,                           # input to bc
        scale = getOption("bc.scale"), # precision
        logical = FALSE,               # should the result be logical?
        cmd = "bc -l") {               # the actual command to call bc
    if (is.null(scale)) 
        scale <- 100
    out <- system(cmd, intern = TRUE,
                  input = c(sprintf("scale=%d", scale), 
                            paste(..., sep = "")))
    if (nchar(Sys.getenv("BC_LINE_LENGTH")) == 0)
        out <- paste(sub("\\\\", "", out), collapse = "")
    if (logical) 
        as.logical(out) 
        else structure(out, class = c("bc", "character"))
}

# - A bc object is a character string with class "bc".
# - The ordinary R operators: +, -, etc. can operate on bc objects
# giving new bc objects.
# - printing a bc object causes it to be passes to bc and back

as.character.bc <- function(x, ...) 
	as.character(x)
	
# [wk] ??
as.expression.bc <- function(x, ...) 
	bc(x, ...)[[1]]
	
# [wk] TODO -- fix this one
as.bc <- function(x, ...) 
	UseMethod("as.bc")

Math.bc <- local({
    transtab <- matrix( c("exp", "e", 
                          "log", "l", 
                          "sin", "s",
                          "cos", "c"), nc = 2, byrow = TRUE)
    function(x, ...) {
    	idx <- match(.Generic, transtab[,1], nomatch = 0)
	    fn <- if (idx > 0) transtab[idx, 2] 
	          else .Generic
	    bc(fn, "(", x, ")") } 
})

Ops.bc <- function (e1, e2) {
    if (missing(e2)) bc(.Generic, e1)
    else bc(e1, .Generic, e2) }

print.bc <- function(x, ...) 
	print(unclass(bc(unclass(x), ...)))
