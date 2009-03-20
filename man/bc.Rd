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
bc(..., scale = 100, logical = FALSE, cmd = "bc -l")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{\dots}{ Each argument is a line passed to bc. }
  \item{scale}{ Number of digits of precision. }
  \item{logical}{ If \code{TRUE} convert result to logical. }
  \item{cmd}{ Character string representing the \code{bc} command. }
}
\details{
  Passes its arguments to bc and collects the result back as a \code{"bc"}
  class object.  There are \code{"bc"} methods for \code{print}, 
  \code{S3} \code{Ops} and \code{exp}, \code{log}, \code{sin} and
  \code{cos}.

  
}
\value{
  Returns an object of class \code{c("bc", "character")}.
}
\references{ \url{http://sourceforge.net/projects/unxutils} }
\note{
  The \code{bc} function runs the \code{bc} executable.  This is normally 
  included with UNIX so no further setup is needed on that platform.
  For Windows, \code{bc} can be downloaded by issuing the command {bcInstall()}.
  This will download it into the package itself and subsequent calls to
  \code{bc} will find it.  Alternately Windows users can download \code{bc.exe}
  from Download area of the home page of this package on googlecode placing 
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
