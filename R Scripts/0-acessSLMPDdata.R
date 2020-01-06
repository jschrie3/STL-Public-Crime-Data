#Loading Required Library's---------------------------------------------------------
library(here)
library(sf)
library(compstatr)
library(data.table)
library(dplyr)
library(tidyverse)
library(ggmap)



#Accessing the SLMPD data using the compstart package-------------------------------
df<-cs_get_data(year = 2018)


setwd('C:/Users/Gunathilakel/Desktop/STL-Public-Crime-Data/DataFiles/CrimeFiles/2018')

#Saving all the individual monthly crime files obtained using the cs_get_data function 
#into the repsective year folder-----------------------------------------------------
for(i in seq_along(df)) {
  write.table(df[[i]], paste(names(df)[i], ".csv", sep = ""), 
              col.names = TRUE, row.names = FALSE, sep = "\t", quote = FALSE)
}


#Reading the Saved datainto a single dataframe for that year-------------------------
myMergedData <- 
  do.call(rbind,
          lapply(list.files(path = getwd(),full.names = TRUE), fread))

write.csv(myMergedData,here('CleanFiles/Mergeddata2018.csv'))
