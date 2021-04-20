#Get working directory
getwd()

#Import weather data, call it "Weather" so it's shorter than the file name
Weather <- read.csv(file = 'MasterWeatherStation_EmpireChestnut.csv', header = TRUE, stringsAsFactors=FALSE)
head(Weather) #Look at the first 10 rows

str(Weather) #Look at dataframe's internal structure, including format of each column
colnames(Weather) #Look at names of columns

columns <- colnames(Weather) #Make list of column names into a vector
columns

#Create a new dataframe which is a subset of the old one, minus the column called Line.
df = subset(Weather, select = -c(Line.))  



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


#Don't need this, it was an earlier iteration of the idea
makepar_df <- function(i, weatherpars, parnames, Weather) {
  weatherpar <- weatherpars[i]
  parname <- parnames[i]
  par_df <- cbind(Date = Weather$Date, getpar(weatherpar, Weather))
  colnames(par_df)[2] <- parname
  return(par_df)
}
output <- makepar_df(1, weatherpars, parnames, Weather)





head(parcolumns)




#Create a new dataframe which is a subset of the old one, keeping only the columns selected
RH = subset(Weather, select = c(Date, RH..S.THB.20648665.20640418.2......Carrollton..Empire.Chestnut.,
                                RH..S.THB.20648665.20640418.2......EmpireChestnut,
                                RH..S.THB.20648665.20640418.2......ChestnutFarm))
  #Dataframe of Date and Relative Humidity

AirTemp = subset(Weather, select = c(Date, Temperature..S.THB.20648665.20640418.1....C..Carrollton..Empire.Chestnut..Air,
                                  Temperature..S.THB.20648665.20640418.1....C..EmpireChestnut.Air,
                                  Temperature..S.THB.20648665.20640418.1....C..ChestnutFarm.Air))
  #Dataframe of Date and Air Temperature

Rain = subset(Weather, select = c(Date, Rain..S.RGE.20648665.20647793.1...mm..Carrollton..Empire.Chestnut.,
                                  Rain..S.RGE.20648665.20647793.1...mm..EmpireChestnut,
                                  Rain..S.RGE.20648665.20647793.1...mm..ChestnutFarm))
  #Dataframe of Date and Rainfall


#Install dplyr for data manipulation
install.packages("dplyr")
library(dplyr) #load dplyr
library(tidyverse) #load tidyverse which includes dplyr & ggplot


#### Manipulating Relative Humidity columns
#Rename columns, list name being replaced first, then replacement name
names(RH)[names(RH) == "RH..S.THB.20648665.20640418.2......Carrollton..Empire.Chestnut."] <- "RH1"
names(RH)[names(RH) == "RH..S.THB.20648665.20640418.2......EmpireChestnut"] <- "RH2"
names(RH)[names(RH) == "RH..S.THB.20648665.20640418.2......ChestnutFarm"] <- "RH3"

class(RH) #Checks the type of data (character, factor, dataframe, etc)

#Creates a duplicate data frame to manipulate without messing up the original
RH_blank <- RH  #my data

RH_all <- coalesce(RH$RH1, RH$RH2, RH$RH3)


# Convert all columns to character (matrix)
RH_blank <- sapply(RH_blank, as.character) 
class(RH_blank)
RH_blank[is.na(RH_blank)] <- "" # Replace NA with blank

RH_df = as.data.frame((RH_blank)) #Convert back to dataframe to combine columns

#Concatenate the specified columns in the dataframe into a new column
RH_df$RH <- paste(RH_df$RH1, RH_df$RH2, RH_df$RH3) 
RH_df = select(RH_df, -RH1, -RH2, -RH3) #Delete original columns after combining them
rm(RH_blank) #Delete RH_blank because it's no longer needed

### End of Manipulating Relative Humidity columns


### Extracting Data from Relative Humidty Dataframe

#Convert second column (RH) to numeric, while leaving first column (Date) as character
RH_df$RH <- as.numeric(as.character(RH_df$RH))

mean(RH_df$RH) #Mean RH for full date range

#Mutate the date so that the times are removed and each row is assigned a date
RH_df <- RH_df %>%
  mutate(Date = as.Date(Date, format = "%m/%d/%y"))





####Playground Below
## Make a new dataframe for each day, sort by Date
May19 <- RH_df[RH_df$Date >= "05/19/20" & RH_df$Date <= "05/20/20",]
May20 <- RH_df[RH_df$Date >= "05/20/20" & RH_df$Date <= "05/21/20",]

library(dplyr)
May19 %>% group_by(Date) %>% summarise_each(funs(sum))

RH_df$Date <- as.Date(RH_df$Date,format = "%m/%d/%y")


mean(May19$RH)
max(May19$RH)
min(May19$RH)
range(May19$RH)
summary(RH_df)

colMax <- function(data) sapply(data, max, na.rm = TRUE)

head(RH_num)
class(RH_df)
mean(RH_num$RH)


summary(May19)
