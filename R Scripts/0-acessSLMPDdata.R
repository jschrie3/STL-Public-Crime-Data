#--------------Script for Obtaining Data--------------------------------------#
#-------------Created by Laknath Gunathilake----------------------------------#


#Loading Required Library's---------------------------------------------------------
library(here)
source(here('R Scripts/library.R'))

#Accessing the SLMPD data using the compstart package-------------------------------
i <- cs_create_index()
df<-cs_get_data(year = 2019,index = i)

setwd('C:/Users/Gunathilakel/Desktop/STL-Public-Crime-Data/DataFiles/CrimeFiles/2019')

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


#Write the combined data into the clean files folder---------------------------------
write.csv(myMergedData,here('DataFiles/Clean Files/Mergeddata2019.csv')) 

