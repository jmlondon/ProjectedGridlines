library(sp)
library(rgdal)
library(maptools)
library(RColorBrewer)
library(ggplot2)
library(grid)

#read in the maptools north carolina shapefile, unprojected
d <- readShapePoly(system.file("shapes/sids.shp", package="maptools")[1], proj4string=CRS("+proj=longlat +datum=NAD27"))

# create a dummy factor variable, with equal labels:
set.seed(31)
d$f = factor(sample(1:5,100,replace=T),labels=letters[1:5])

#specify a custom Albers equal centered on the coordinate data
#this works for points and polygons, but lines need to be converted to points
med.lat <- round(median(coordinates(d)[,2]))
med.lon <- round(median(coordinates(d)[,1]))
lat1<-bbox(d)[2,1]+diff(range(bbox(d)[2,]))/3
lat2<-bbox(d)[2,2]-diff(range(bbox(d)[2,]))/3

myProj <- paste("+proj=aea +lat_1=",lat1," +lat_2=",lat2," +lat_0=",med.lat,
                " +lon_0=", med.lon, "+x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m",sep="")

#project the data, the graticule lines. note the gridlines function calls the unprojected data
d.proj <- spTransform(d,CRS(myProj))
coordLim <- bbox(d.proj)
#grat.lines<-spTransform(gridlines(d,ndisc=500),CRS(myProj))
grat <- GetGratLines(d,myProj,list(t=0.25,b=-0.25,l=-0.25,r=0.25))
gratdf <- SpatialLinesDataFrame(grat, data = data.frame(rep(NA, length(g))), match.ID = FALSE)

## Get x, y labels and locations
x_grat_at<-GetLabelCoords(g,offset=list(ew=0))$EW_Coords

y_grat_at<-GetLabelCoords(g,offset=list(ns=0))$NS_Coords

x_grat<-list(draw=TRUE,
             at=x_grat_at,
             labels=as.character(GetDegreeLabels(d)$EW_Labels),
             tck=c(0,0),
             cex=0.75)

y_grat<-list(draw=TRUE,
             at=y_grat_at,
             labels=as.character(GetDegreeLabels(d)$NS_Labels),
             rot=90,
             tck=c(0,0),
             cex=0.75)



ggd.proj <- fortify(d.proj, region = "f")
gggrat <- fortify(gratdf)


ggplot(ggd.proj) +
    geom_polygon(aes(x=long, y=lat, group=group, fill = id)) +
    geom_path(data = gggrat, aes(x=long,y=lat,group=group), col = 'grey', linetype = 'dashed') +
    coord_equal(xlim = coordLim[1,], ylim = coordLim[2,]) +
    scale_x_discrete(name = 'Lat', breaks = x_grat$at, labels = x_grat$labels) +
    scale_y_discrete(name = 'Long', breaks = y_grat$at, labels = y_grat$labels) +
    theme_bw()