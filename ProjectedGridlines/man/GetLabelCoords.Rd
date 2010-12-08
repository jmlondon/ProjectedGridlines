\name{GetLabelCoords}
\alias{GetLabelCoords}
\title{This function gets the coordinates (in projected units) for the graticule labels...}
\usage{GetLabelCoords(gl, offset=list(ew = 0, ns = 0))}
\description{This function gets the coordinates (in projected units) for the graticule labels}
\details{This function requires the \code{SpatialLines} object, \code{gl} returned from \code{GetGratLines}
and offset values for the EW and NS labels. The spatial extent of \code{gl} is greater than
the spatial extent of target data (remember, this was done in \code{GetGratLines} to insure the
projected lines went all the way to the edge of the extent. However, the GetLabelCoords just
extracts the first coordinate values from each line. Depending on the edge distortion of the
projection, the label coordinates can be offset from the actual intersection of the graticules
and the axis/border. In the provided example, I have removed tick marks to make this less obvious.
But, in some cases, the user may need to provide an additional offset to improve the looks.

This approach is less elegant and more hacker than I would like. In theory, the \code{bbox} of the
target projected data could be used to find the corresponding axis coordinate for each label instead
of using just the first coordinate. I haven't had the time/patience/skills to generalize this approach. 
Additionally, the current offset applies to all labels on the axis. I should improve this to allow
specific offsets for each label as most projection distortions are not linear.}
\value{a list with EW_Coords corresponding to the EW labels and NS_Coords for NS labels}
\author{Josh M London \email{josh.london@noaa.gov}}
\arguments{\item{gl}{the \code{SpatialLines} object returned from \code{GetGratLines}}
\item{offset}{a named list with values \code{ew} and {ns} specifying an offset for all labels on the axis}}
