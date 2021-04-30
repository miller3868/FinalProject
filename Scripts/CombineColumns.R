
#weatherpars = Make a vector of weather parameters from weather file, matching beginning and end of column names
#parnames = designate names for parameter columns after combining them
weatherpars <- c("^RH", "^Temp.*Air$", "^Temp.*Soil$", "^Rain", "^Dew",
                 "^Gust", "^Wetness", "^Water", "^Wind.Speed", "^Wind.Direction")
parnames <- c("RH", "AirTemp", "SoilTemp", "Rainfall", "DewPoint", 
              "GustSpeed", "LeafWetness", "SoilMoisture", "WindSpeed", "WindDirection")

#Make function getpar to pull columns from Weather data, match by weatherpar, coalsce 3 matches into 1 column
getpar <- function(weatherpar, Weather2) {
  parcolumns <- Weather2 %>% 
    select(matches(weatherpar))
  colnames(parcolumns) <- c("a", "b", "c")
  par_all <- coalesce(parcolumns$a, parcolumns$b, parcolumns$c)
  return(par_all)
}

#Make dataframe that combines output of getpar for each weather parameter
output <- do.call(cbind, lapply(weatherpars, getpar, Weather2))
output <- as.data.frame(output)  #Change output to dataframe for downstream manipulation
colnames(output) <- parnames  #Assign parnames to columns

#Use cbind() to combine the original date column (renanmed FullDate) from Weather with output dataframe
#Make new column called DATE that changes the date into R-recognized Date format and removes timestamp
CombColumns <- cbind(Date = (Weather2$DATE <- as.Date(Weather2$DATE, format = "%m/%d/%y")), 
                         FullDate = Weather2$Date, output)



