#' This function creates labels, in decimal degrees, for the graticules output from \code{GetGratLines}. 
#' 
#' This function requires the unprojected version of the data (\code{spobj}) and this is used to get the
#' label text, in decimal degrees, for each of the graticules
#' 
#' @param spobj an unprojected sp object that is the basis of the final projected outcome
#' @return a list with EW_Labels corresponding to the EW graticules and NS_Labels for NS graticules
#' @note the function calls \code{gridlines()} and does not specify line loctations, instead relying
#' on \code{gridlines()} use of \code{pretty()}. Here, there is no use of the \code{ndisc} 
#' as we're just getting the labels.
#' @author Josh M London \email{josh.london@@noaa.gov}
#' @export

GetDegreeLabels<-function(spobj){
	ewl<-coordinates(gridlines(spobj)["EW"]@lines[[1]])
	nsl<-coordinates(gridlines(spobj)["NS"]@lines[[1]])
	ewLabels<-lapply(ewl,function(x) {return(x[1,1])})
	nsLabels<-lapply(nsl,function(x) {return(x[1,2])})
	return(list(EW_Labels=unlist(ewLabels),NS_Labels=unlist(nsLabels)))
}
