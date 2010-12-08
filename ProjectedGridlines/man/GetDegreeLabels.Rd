\name{GetDegreeLabels}
\alias{GetDegreeLabels}
\title{This function creates labels, in decimal degrees, for the graticules output from GetGratLines.}
\usage{GetDegreeLabels(spobj)}
\description{This function creates labels, in decimal degrees, for the graticules output from \code{GetGratLines}.}
\details{This function requires the unprojected version of the data (\code{spobj}) and this is used to get the
label text, in decimal degrees, for each of the graticules}
\value{a list with EW_Labels corresponding to the EW graticules and NS_Labels for NS graticules}
\note{the function calls \code{gridlines()} and does not specify line loctations, instead relying
on \code{gridlines()} use of \code{pretty()}. Here, there is no use of the \code{ndisc} 
as we're just getting the labels.}
\author{Josh M London \email{josh.london@noaa.gov}}
\arguments{\item{spobj}{an unrpojected sp object that is the basis of the final projected outcome}}
