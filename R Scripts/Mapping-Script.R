
#----Script for Mapping Data wit R-----
# Run the following script to obtain the cleaned data ready and available for Mapping
workpcpath<-'C:/Users/Gunathilakel/Desktop/STL-Public-Crime-Data/R Scripts/Data-Cleaning-Script.R'
homepcpath<-'C:/Users/lakna/OneDrive/Desktop/STL-Public-Crime-Data/R Scripts/Data-Cleaning-Script.R'
source(workpcpath) 
#install required library's
library('sf')
library('mapview')
library('ggmap')


#St Louis coordinates
stlouis<-c(lon=-90.199402,lat=38.627003)


map_5 <- get_map(stlouis, zoom = 13, scale = 2)
ggmap(map_5)


#obtaining data 



ggmap(map_5)+geom_point(aes(Lon,Lat),data=mapready)
