#loading Required Library's 
library(dplyr)
library(data.table)

#Data cleaning Script
setwd('C:/Users/lakna/OneDrive/Desktop/STL-Public-Crime-Data/DataFiles/CrimeFiles')


myMergedData <- 
  do.call(rbind,
          lapply(list.files(path = getwd()), fread))


mapready<-myMergedData%>%select(Description,XCoord,YCoord)

rm(myMergedData)