#' This function gets the coordinates (in projected units) for the graticule labels
#' 
#' This function requires the \code{SpatialLines} object, \code{gl} returned from \code{GetGratLines}
#' and offset values for the EW and NS labels. The spatial extent of \code{gl} is greater than
#' the spatial extent of target data (remember, this was done in \code{GetGratLines} to insure the
#' projected lines went all the way to the edge of the extent. However, the GetLabelCoords just
#' extracts the first coordinate values from each line. Depending on the edge distortion of the
#' projection, the label coordinates can be offset from the actual intersection of the graticules
#' and the axis/border. In the provided example, I have removed tick marks to make this less obvious.
#' But, in some cases, the user may need to provide an additional offset to improve the looks.
#' 
#' This approach is less elegant and more hacker than I would like. In theory, the \code{bbox} of the
#' target projected data could be used to find the corresponding axis coordinate for each label instead
#' of using just the first coordinate. I haven't had the time/patience/skills to generalize this approach. 
#' Additionally, the current offset applies to all labels on the axis. I should improve this to allow
#' specific offsets for each label as most projection distortions are not linear.
#' 
#' @param gl the \code{SpatialLines} object returned from \code{GetGratLines}
#' @param offset a named list with values \code{ew} and {ns} specifying an offset for all labels on the axis
#' @return a list with EW_Coords corresponding to the EW labels and NS_Coords for NS labels
#' @author Josh M London \email{josh.london@@noaa.gov}
#' @export
GetLabelCoords<-function(gl,offset=list(ew=0,ns=0)){
	ewc<-coordinates(gl["EW"]@lines[[1]])
	nsc<-coordinates(gl["NS"]@lines[[1]])
	ewCoords<-lapply(ewc,function(x) {return(x[1,1])})
	nsCoords<-lapply(nsc,function(x) {return(x[1,2])})
	ewCoords<-lapply(ewCoords,function(x) {return(x+offset$ew)})
	nsCoords<-lapply(nsCoords,function(x) {return(x+offset$ns)})
	return(list(EW_Coords=unlist(ewCoords),NS_Coords=unlist(nsCoords)))
}
