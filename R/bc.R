
bc <- function(..., scale = getOption("bc.scale"), 
	retclass = c("bc", "character", "logical", "numeric"),
	cmd, args = "-l", verbose = getOption("bc.verbose")) {

	if (missing(cmd)) {
		bcfile <- Sys.which("bc")
		cmd <- if (nchar(bcfile) > 0) "bc"
		else {
			if (.Platform$OS.type == "windows") {
				system.file("bcdir", "bc.exe", package = "bc")
			} else system.file("bcdir", "bc", package = "bc")
		}
	}
	cmd <- paste(cmd, args)
	if (is.null(verbose)) verbose <- FALSE

	dots <- list(...)
	dots <- sapply(dots, format, scientific = FALSE)
	dots <- paste(dots, collapse = "")

	run <- function() {
		scale <- format(as.numeric(scale), scientific = FALSE)
		input <- c(paste("scale", scale, sep = "="), dots)
		if (verbose) cat("bc input:", input, "\n")
		out <- system(cmd, input = input, intern = TRUE)
		if (verbose) cat("bc output:", out, "\n")
		out
	}
	BC_LINE_LENGTH <- Sys.getenv("BC_LINE_LENGTH")
	if (nchar(BC_LINE_LENGTH) == 0) {
		if (is.null(scale)) scale <- 100
		out <- run()
		out <- paste(sub("\\\\", "", out), collapse= "")
	} else {
		# ensure BC_LINE_LENGTH not in scientific format
		bc_line_length <- as.numeric(BC_LINE_LENGTH)
		BC_LINE_LENGTH <- format(bc_line_length, scientific = FALSE)
		Sys.setenv(BC_LINE_LENGTH = BC_LINE_LENGTH)
		if (is.null(scale)) scale <- min(100, floor(bc_line_length / 2))
		out <- run()
	}

	retclass <- match.arg(retclass)
	switch(retclass,
		bc = structure(out, class = c("bc", "character")),
		character = out,
		logical = as.logical(out),
		numeric = as.numeric(out))
}

# - A bc object is a character string with class "bc".
# - The ordinary R operators: +, -, etc. can operate on bc objects
# giving new bc objects.
# - printing a bc object causes it to be passes to bc and back

as.character.bc <- function(x, ...) as.character(unclass(x))

Ops.bc <- function (e1, e2) 
    if (missing(e2)) { bc(.Generic, e1)
    } else bc(e1, .Generic, e2)

transtab <- matrix( c("exp", "e", 
					  "log", "l", 
					  "atan", "a",
					  "sin", "s",
					  "cos", "c"), nc = 2, byrow = TRUE)

Math.bc <- function(x, ...) {
	idx <- match(.Generic, transtab[,1], nomatch = 0)
	fn <- if (idx > 0) transtab[idx, 2] else .Generic
	bc(fn, "(", x, ")")
}

print.bc <- function(x, ...) print(unclass(bc(unclass(x), ...)))

