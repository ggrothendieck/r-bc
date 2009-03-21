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
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{\dots}{ Each argument is a line passed to bc. }
  \item{scale}{ Number of decimals. If unspecified the value is taken
   from the \code{bc.scale} option and if that is also unspecified, 
   100 is used.}
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
  \code{S3} \code{Ops} and \code{exp}, \code{log}, \code{sin} and
  \code{cos}.

  The default action is to collapse all lines that are returned into a
  single line but if the user sets \code{Sys.setenv(BC_LINE_LINE="100")},
  say, or some other then no collapsing will be done and its the responsibility
  of the user to ensure that the number specified is sufficiently large.
  Specifying \code{BC_LINE_LENGTH} in this way will result in a minor speedup.

  
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
\section{Warning}{\code{bc} does not accept \code{"e"} notation such as
\code{1e-5} so be careful about passing numbers which might get converted
to such notation as they are converted to character before passing them to
\code{bc} and such conversion can result in the use of \code{"e"} notation.  
Its better to pass them as character strings, e.g.
\code{".00001"} rather than \code{.00001}.  Similarly \code{"10000"} or
\code{10000L} is safer than \code{10000}.}
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
