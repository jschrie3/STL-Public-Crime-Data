#----------The following Script reads each of the individual files and stores them in a format that can be used by ggmap---------


#loading Required Library's 
library(dplyr)
library(data.table)
library(sf)
library(tidyverse)
library(ggmap)


path<-'' #set the path to the directory in your computer when the files are located
workpcpath<-'C:/Users/Gunathilakel/Desktop/STL-Public-Crime-Data/DataFiles/CrimeFiles' 
homepcpath<-'C:/Users/lakna/OneDrive/Desktop/STL-Public-Crime-Data/DataFiles/CrimeFiles'
#Data cleaning Script
setwd(workpcpath) 

#The following code reads each one of the individual files and merges them into a single file
myMergedData <- 
  do.call(rbind,
          lapply(list.files(path = getwd()), fread))


mapready<-myMergedData%>%select(CodedMonth,Description,XCoord,YCoord)
mapready_sf<-st_as_sf(mapready,coords = c("XCoord","YCoord"),crs=102696) # This sets the x and y to spatial coordinates.

my_latlon_df <- st_transform(mapready_sf, crs = 4326 )  #re-project into a geographic system like WGS84 to convert to lat long
my_latlon_df <- my_latlon_df%>%
  mutate( lat= st_coordinates(my_latlon_df)[,1],
          lon = st_coordinates(my_latlon_df)[,2])

rm(mapready,mapready_sf,myMergedData)
