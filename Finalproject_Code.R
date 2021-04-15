#Get working directory
getwd()

#Import weather data, call it "Weather" so it's shorter than the file name
Weather <- read.csv(file = 'MasterWeatherStation_EmpireChestnut.csv', header = TRUE)
head(Weather) #Look at the first 10 rows

str(Weather) #Look at dataframe's internal structure, including format of each column
colnames(Weather) #Look at names of columns

columns <- colnames(Weather) #Make list of column names into a vector
columns

#Create a new dataframe which is a subset of the old one, minus the column called Line.
df = subset(Weather, select = -c(Line.))  

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

#Concatenate columns in a dataframe
RH$RH <- paste(RH$RH1, RH$RH2, RH$RH3)

class(RH) #Checks the type of data (character, factor, dataframe, etc)

#Creates a duplicate data frame to manipulate without messing up the original
RH_blank <- RH  #my data
RH_blank = select(RH_blank, -RH) #Delete column to make new one after turning "NA" to blank

RH_blank <- sapply(RH_blank, as.character) # Convert all columns to character (matrix)
class(RH_blank)
RH_blank[is.na(RH_blank)] <- "" # Replace NA with blank

RH_df = as.data.frame((RH_blank)) #Convert back to dataframe to combine columns

#Concatenate the specified columns in the dataframe into a new column
RH_df$RH <- paste(RH_df$RH1, RH_df$RH2, RH_df$RH3) 
RH_df = select(RH_df, -RH1, -RH2, -RH3) #Delete original columns after combining them
rm(RH_blank) #Delete RH_blank because it's no longer needed

### End of Manipulating Relative Humidity columns
