
bcFile <- function(filename = "bc.exe",
   slash = c("\\", "/")) {
   stopifnot(.Platform$OS.type == "windows")
   whole.path <- function(path, defpath, deffile) {
      if (path == "") path <- defpath
      if (file.info(path)$isdir) 
         file.path(sub("[/\\]$", "", path), deffile) 
      else path
   }
   bc.exe <- whole.path(Sys.getenv("BC_HOME"),
         system.file(package = "bc", "bcdir"), "bc.exe")
   fullname <- switch(match.arg(filename), bc.exe = bc.exe,
	 system.file(package = "bc", "bcdir"))
   slash <- match.arg(slash)
   chartr(setdiff(c("/", "\\"), slash), slash, fullname)
}

bcInstall <- function(url = 
   "http://r-bc.googlecode.com/files/bc_1.05.zip",
   overwrite = FALSE) {
   stopifnot(.Platform$OS.type == "windows")
   files <- "bc.exe"
   on.path <- Sys.which(files)
   if (nchar(on.path) > 0) {
      warning(paste(bcFile(files), "also found on PATH\n"))
   }
   tmpd <- tempdir()
   tmpz <- file.path(tmpd, basename(url))
   download.file(url, tmpz, mode = "wb")
   zip.unpack(tmpz, tmpd)
   lf <- function(f) list.files(path = tmpd, pattern = f,
      all.files = FALSE, full.names = TRUE, recursive = TRUE)
   for (f in files)
      if (length(lf(f)) ==0) stop(paste(f, "not found in", url))
   for (f in files) if (!file.copy(lf(f), bcFile(f), overwrite = overwrite))
      warning(paste(bcFile(f), "already exists.\n  Use overwrite = TRUE"))
   invisible()
}



