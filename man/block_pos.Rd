% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/helper_functions.R
\name{block_pos}
\alias{block_pos}
\title{Dertermine grid point positions to insure groups are connected}
\usage{
block_pos(total, width)
}
\arguments{
\item{total}{Integer, total number of grid points needed.}

\item{width}{Integer, width of the chart.}
}
\value{
tibble with total number of rows and 2 column named x and y
    respectively.
}
\description{
Dertermine grid point positions to insure groups are connected
}
\examples{
block_pos(100, 10)
block_pos(111, 8)
}
