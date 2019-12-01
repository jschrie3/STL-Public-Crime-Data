
#----Script for Mapping Data wit R-----
# Run the following script to obtain the cleaned data ready and available for Mapping
source('C:/Users/lakna/OneDrive/Desktop/STL-Public-Crime-Data/R Scripts/Data-Cleaning-Script.R') 
#install required library's
library('sf')
library('mapview')


locations_sf <- st_as_sf(mapready, coords = c("Xcoord", "Ycoord"), crs = 4326)
