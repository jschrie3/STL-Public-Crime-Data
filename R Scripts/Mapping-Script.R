
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


stlmap <- get_map(stlouis,maptype = 'toner-hybrid', zoom = 12, scale = 2,source = "stamen")
ggmap(stlmap)

my_latlon_df<-head(my_latlon_df,20)

#Initial Mapping 
ggmap(stlmap,
      base_layer = ggplot(my_latlon_df,aes(lat,lon)))+
      geom_point(aes(color=Description))
      




