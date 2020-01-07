#----------The following Script reads each of the individual files and stores them in a format that can be used by ggmap---------

#loading Required Library's 
library(dplyr)
library(data.table)
library(sf)
library(tidyverse)
library(ggmap)
library(here)


#The following code reads each one of the individual files and merges them into a single file

myMergedData<-fread(here('DataFiles/Clean Files','Mergeddata2018.csv'))


mapready<-myMergedData%>%select(coded_month,description,x_coord,y_coord)

mapready<-mapready%>%filter(x_coord!=0) #Getting rid of values where the Xcoord is 0

mapready_sf<-st_as_sf(mapready,coords = c("x_coord","y_coord"),crs=102696) # This sets the x and y to spatial coordinates.

my_latlon_df <- st_transform(mapready_sf, crs = 4326 )  #re-project into a geographic system like WGS84 to convert to lat long
my_latlon_df <- my_latlon_df%>%
  mutate( lat= st_coordinates(my_latlon_df)[,1],
          lon = st_coordinates(my_latlon_df)[,2])%>%select(-geometry)



write.csv(my_latlon_df,here('DataFiles/Results/mapdata.csv'),row.names = F)

