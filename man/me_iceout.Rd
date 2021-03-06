% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datasets.R
\docType{data}
\name{me_iceout}
\alias{me_iceout}
\title{Maine Bureau of Parks & Lands State Ice-out Data}
\format{A data frame with 1,131 rows and 6 variables}
\usage{
data(me_iceout)
}
\description{
This dataset contains the Maine state-level historical data
generated via \code{\link[=read_maine_iceout_data]{read_maine_iceout_data()}}.
\itemize{
\item \code{state} <chr> (always Maine)
\item \code{town} <chr> (town name)
\item \code{body_name} <chr> (inland body of water name)
\item \code{date} <Date> (iceout date)
\item \code{year} <int> (ice-out year)
\item \code{doy} <int> (ice-out day of year)
}
}
\note{
Last updated 2019-01-15.
}
\references{
\url{https://www.maine.gov/dacf/parks/water_activities/boating/ice_out06.shtml}
}
\keyword{datasets}
