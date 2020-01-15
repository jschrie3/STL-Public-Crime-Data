#------------------Data Preprosessing Script-------------------------------#
#---------------Created By Laknath Gunathilake-----------------------------#

#loading Required Library's------------------------------------------------# 
library(here)
library(chron)
source(here('R Scripts/library.R')) # This script loads all the library's stored in library.R script


#The following code reads each one of the individual files and merges them into a single file

myMergedData<-fread(here('DataFiles/Clean Files','Mergeddata2019.csv'))


#extract the date and time from the date_occur column
myMergedData$incident_time<-substring(myMergedData$date_occur,12,16)
myMergedData$time<-as.POSIXct(myMergedData$incident_time,format="%H:%M", tz = "UTC")
myMergedData$time<-times(strftime(myMergedData$time,"%H:%M:%S"))


chron(time=substring(myMergedData$time,12,16))

myMergedData$incident_date<-as.Date(myMergedData$date_occur,format='%m/%d/%Y')
chron(time = myMergedData$incident_time)

timedf<-myMergedData%>%select(date_occur,incident_time,time)




#Convert offenses into the UCR codes available in----------------------------------------------------------
#https://ucr.fbi.gov/additional-ucr-publications/ucr_handbook.pdf pg (8)


myMergedData<-myMergedData%>%mutate(crime=as.character(crime))
myMergedData$new_ucr <- with(myMergedData, substring(crime,1,ifelse(nchar(crime) == 6, 2, 1)))

test<-myMergedData%>%mutate(ucr=case_when(new_ucr=="1"~'Criminal Homicide',
                                          new_ucr=="2"~' Forcible Rape',
                                          new_ucr=='3'~'Robbery',
                                          new_ucr=='4'~'Aggravated Assault',
                                          new_ucr=='5'~'Burglary ',
                                          new_ucr=='6'~'Theft',
                                          new_ucr=='7'~'Motor Vehicle Theft',
                                          new_ucr=='8'~'Arson',
                                          new_ucr=='9'~'Other Assaults',
                                          new_ucr=='10'~'Forgery and Counterfeiting',
                                          new_ucr=='11'~'Fraud',
                                          new_ucr=='12'~'Embezzlement',
                                          new_ucr=='13'~'Stolen Property',
                                          new_ucr=='14'~'Vandalism',
                                          new_ucr=='15'~'Carrying, Possessing weapons',
                                          new_ucr=='16'~'Prostitution',
                                          new_ucr=='17'~'Sex Offenses',
                                          new_ucr=='18'~' Drug Abuse Violations',
                                          new_ucr=='19'~' Gambling',
                                          new_ucr=='20'~'Offenses Against the Family and Children',
                                          new_ucr=='21'~'DUI',
                                          new_ucr=='22'~'Liquor Laws',
                                          new_ucr=='23'~'Drunkenness',
                                          new_ucr=='24'~'Disorderly Conduct',
                                          new_ucr=='25'~'Vagrancy',
                                          new_ucr=='26'~'All Other Offenses',
                                          new_ucr=='27'~ 'Suspicion',
                                          new_ucr=='28'~'Curfew and Loitering',
                                          new_ucr=='29'~'Runaways'))











#-------------
mapready<-test%>%select(coded_month,description,x_coord,y_coord,count,ucr)

#Getting rid of rows that contain -1 in count indicating that the incident was unfounded--------------------
mapready<-mapready%>%filter(count!=-1)%>%select(-count)

#Getting rid of values where the coordinate values are missing
mapready<-mapready%>%filter(x_coord!=0) 

mapready_sf<-st_as_sf(mapready,coords = c("x_coord","y_coord"),crs=102696) # This sets the x and y to spatial coordinates.

my_latlon_df <- st_transform(mapready_sf, crs = 4326 )  #re-project into a geographic system like WGS84 to convert to lat long
my_latlon_df <- my_latlon_df%>%
  mutate( lat= st_coordinates(my_latlon_df)[,1],
          lon = st_coordinates(my_latlon_df)[,2])%>%select(-geometry)


write.csv(my_latlon_df,here('DataFiles/Results/mapdata.csv'),row.names = F)


my_latlon_df<-head(my_latlon_df,50)
mapview(my_latlon_df,zcol = "description",burst = F)