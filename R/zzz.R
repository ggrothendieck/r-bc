
.First.lib <- function(lib, pkg, ...) {
   if (.Platform$OS.type != "windows") return()

   if (is.null(Sys.which("bc.exe")) && !file.exists(bcFile("bc.exe"))) {
	cat(bcFile("bc.exe"), "not found.\n")
        # cat("Run bcInstall() without arguments to install bc.\n")
   }
   invisible()
}
