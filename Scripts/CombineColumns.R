

#Import weather data, call it "Weather" so it's shorter than the file name
Weather <- read.csv(file = 'MasterWeatherStation_EmpireChestnut.csv', header = TRUE, stringsAsFactors=FALSE)
head(Weather) #Look at the first 10 rows


#Make a vector of weather parameters from weather file (weatherpars), 
weatherpars <- c("^RH", "^Temp.*Air$", "^Temp.*Soil$")
parnames <- c("RH", "AirTemp", "SoilTemp")

getpar <- function(weatherpar, Weather) {
  parcolumns <- Weather %>% 
    select(matches(weatherpar))
  colnames(parcolumns) <- c("a", "b", "c")
  par_all <- coalesce(parcolumns$a, parcolumns$b, parcolumns$c)
  return(par_all)
}

output <- do.call(cbind, lapply(weatherpars, getpar, Weather))
colnames(output) <- parnames
output <- cbind(Date = Weather$Date, output)