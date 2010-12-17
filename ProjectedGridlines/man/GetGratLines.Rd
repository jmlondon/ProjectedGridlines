\name{GetGratLines}
\alias{GetGratLines}
\title{This function creates the projected graticule lines.}
\usage{GetGratLines(spobj, proj_str, exp_deg, ndisc=500, ...)}
\description{This function creates the projected graticule lines.}
\details{Here I use the phrase 'graticule lines' as an attempt to minimize confusion with the existing \code{gridlines} function.
It essentially calls \code{gridlines()} on the unprojected spatial object (\code{spobj})
and then uses \code{spTransform()} to project those lines to the provided proj4 string.
One artifact of projecting the gridlines is the extent of the projected gridlines will usually
be smaller than the extent of the \code{spobj} once projected. To account for this, \code{bbox(spobj)} is
expanded in each direction by a specified amount. These values are dependent on the specific
projection and extent of the data}
\value{a \code{SpatialLines} object with projection as specified by \code{proj_str}}
\note{the function calls \code{gridlines()} and does not specify line loctations, instead relying
on \code{gridlines()} use of \code{pretty()}. It does specify a default \code{ndisc=500} for nicer 
looking lines when projected.}
\author{Josh M London \email{josh.london@noaa.gov}}
\arguments{\item{spobj}{an unrpojected sp object that is the basis of the final projected outcome}
\item{proj_str}{a proj4 string specifying the desired projection}
\item{exp_deg}{is a named list with values \code{l,r,b,t} specifying the amount in decimal
degrees each side (left, right, bottom, top) should be expanded to account for differences
in extent between the projected gridlines and the final projected extent of \code{spobj}}
\item{...}{passing of parameters relevant to \code{gridlines()}}}
