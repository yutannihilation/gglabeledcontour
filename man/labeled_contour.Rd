% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/geom-labeled-contour.r
\docType{data}
\name{labeled_contour}
\alias{StatContourLabel}
\alias{geom_contour_label}
\alias{geom_labeled_contour}
\alias{labeled_contour}
\title{Contour w/ Labels}
\usage{
StatContourLabel

geom_contour_label(mapping = NULL, data = NULL, position = "identity",
  na.rm = FALSE, show.legend = NA, inherit.aes = TRUE, digits = 3, ...)

geom_labeled_contour(mapping = NULL, data = NULL, stat = "contour",
  position = "identity", lineend = "butt", linejoin = "round",
  linemitre = 1, na.rm = FALSE, show.legend = NA, inherit.aes = TRUE,
  digits = 3, ...)
}
\arguments{
\item{digits}{this parameter is passed to \code{signif()}, but usually this doesn't matter since
the levels of contours are rounded already}
}
\description{
geom_contour() + labels
}
\examples{
library(ggplot2)
N <- 60
x <- seq(0, 100, length=N)
d.cont <- data.frame(x=rep(x,N), y=rep(x,each=N))
d.cont <- transform(d.cont, z.diff = x-y)

ggplot(d.cont, aes(x, y, z = z.diff)) +
  geom_contour() +
  geom_contour_label()

# shortcut
ggplot(d.cont, aes(x, y, z = z.diff)) +
  geom_labeled_contour()
}
\seealso{
The arguments are the same as \link[ggplot2]{geom_contour}, except for \code{digits}
}
\keyword{datasets}

