\name{bc}
\alias{bc}
\alias{Ops.bc} 
\alias{Math.bc} 
\alias{print.bc} 
\alias{as.expression.bc} 
\alias{as.character.bc} 
\alias{as.bc} 
\alias{bcFile}
\alias{bcInstall}
\alias{transtab}
\title{ R to bc interface }
\description{
 Interface to bc calculator.
}
\usage{
bc(..., scale = getOption("bc.scale"), logical = FALSE, cmd, args = "-l")
}
\arguments{
  \item{\dots}{ Each argument is a line passed to bc. }
  \item{scale}{ Number of decimals. If unspecified, the value is taken
   from the \code{bc.scale} option and if that is also unspecified, 
   \code{min(100, BC_LINE_LENGTH/2)} is used if the \code{BC_LINE_LENGTH} 
   environment variable was specified and 100 if a value for that
   environment variable was not specified.}
  \item{logical}{ If \code{TRUE} convert result to logical. }
  \item{cmd}{ Character string representing the \code{bc} command.  Default
    is to use "bc" but if that is not found on path it looks in \code{bcdir} in
    the \code{bc} package directory. On Windows the \code{bcInstall()} command
    can be used to automatically download and install \code{bc} in 
    \code{bcdir}.  On UNIX systems \code{bc} is normally present on path so 
    no action need be taken.}
  \item{args}{ Arguments used when issuing \code{bc} command. }
}
\details{
  Passes its arguments to bc and collects the result back as a \code{"bc"}
  class object.  There are \code{"bc"} methods for \code{print}, 
  \code{S3} \code{Ops} and \code{exp}, \code{log}, \code{atan}, \code{sin} and
  \code{cos}.

  The default action is to collapse all lines that are returned into a
  single line but if the user sets the \code{BC_LINE_LENGTH} environment 
  variable, e.g. \code{Sys.setenv(BC_LINE_LINE=100)}, say, 
  then no collapsing will be done and its the responsibility
  of the user to ensure that the number specified is sufficiently large.
  If not errors will result.
  Specifying \code{BC_LINE_LENGTH} in this way may result in a minor speedup.
  
}
\value{
  Returns an object of class \code{c("bc", "character")}.
}
\references{ Main Gnu bc site: \url{http://www.gnu.org/software/bc/},
Windows distribution: \url{http://sourceforge.net/projects/unxutils},
Another Windows distribution (less convenient since it requires readline4.dll):
\url{http://gnuwin32.sourceforge.net/packages/bc.htm},
minimal Windows distribution containing only \code{bc.exe} on r-bc site:
\url{http://r-bc.googlecode.com/files/bc_1.05.zip}.
}
\note{
  The \code{bc} function runs the \code{bc} executable.  This is normally 
  included with UNIX so no further setup is needed on that platform.
  For Windows, \code{bc} can be downloaded by issuing the \code{R} command 
  {bcInstall()} with no arguments.
  This will download it into the package itself and subsequent calls to
  \code{bc} will find it.  Alternately Windows users can download \code{bc}
  from the Download area of the home page of this package on googlecode placing 
  it anywhere in their path.

}
\examples{
\dontrun{
# all these are the same
bc("1.1^100")
bc(1.1) ^ 100
zero <- bc(0); (zero + 1.1) ^ 100
}
}
\keyword{ misc }
