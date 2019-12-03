#loading Required Library's 
library(dplyr)
library(data.table)

workpcpath<-'C:/Users/Gunathilakel/Desktop/STL-Public-Crime-Data/DataFiles/CrimeFiles'
homepcpath<-'C:/Users/lakna/OneDrive/Desktop/STL-Public-Crime-Data/DataFiles/CrimeFiles'
#Data cleaning Script
setwd(workpcpath)

getwd()

myMergedData <- 
  do.call(rbind,
          lapply(list.files(path = getwd()), fread))


mapready<-myMergedData%>%select(Description,XCoord,YCoord)

mapready<-mapready%>%rename(Lon=XCoord,Lat=YCoord)


