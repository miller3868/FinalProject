#Get working directory
getwd()
setwd("/Users/ACM/FinalProject/Data")

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
install.packages("plyr")
library(lubridate)
library(plyr)

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

Weather2$DATE <- as.Date(Weather2$Date,format = "%m/%d/%y")

AirTempMean <- aggregate(AirTemp~Date, CombColumns, mean)
names(AirTempMean)[names(AirTempMean) == "AirTemp"] <- "AirTempMean"
write.csv(AirTempMean,
          file = "/Users/ACM/FinalProject/Data/MergeCSV/AirTempMean.csv", row.names=F)

AirTempMax <- aggregate(AirTemp~Date, CombColumns, max) 
names(AirTempMax)[names(AirTempMax) == "AirTemp"] <- "AirTempMax"
write.csv(AirTempMax,
          file = "/Users/ACM/FinalProject/Data/MergeCSV/AirTempMax.csv", row.names=F)

AirTempMin <- aggregate(AirTemp~Date, CombColumns, min)
names(AirTempMin)[names(AirTempMin) == "AirTemp"] <- "AirTempMin"
write.csv(AirTempMin,
          file = "/Users/ACM/FinalProject/Data/MergeCSV/AirTempMin.csv", row.names=F)

RainfallMean <- aggregate(Rainfall~Date, CombColumns, mean)
names(RainfallMean)[names(RainfallMean) == "Rainfall"] <- "RainfallMean"
write.csv(RainfallMean,
          file = "/Users/ACM/FinalProject/Data/MergeCSV/RainfallMean.csv", row.names=F)

RainfallSum <- aggregate(Rainfall~Date, CombColumns, sum)
names(RainfallSum)[names(RainfallSum) == "Rainfall"] <- "RainfallSum"
write.csv(RainfallSum,
          file = "/Users/ACM/FinalProject/Data/MergeCSV/RainfallSum.csv", row.names=F)

RHMean <- aggregate(RH~Date, CombColumns, mean)
names(RHMean)[names(RHMean) == "RH"] <- "RHMean"
write.csv(RHMean,
          file = "/Users/ACM/FinalProject/Data/MergeCSV/RHMean.csv", row.names=F)

RHSum <- aggregate(RH~Date, CombColumns, sum)
names(RHSum)[names(RHSum) == "RH"] <- "RHSum"
write.csv(RHSum,
          file = "/Users/ACM/FinalProject/Data/MergeCSV/RHSum.csv", row.names=F)


multmerge = function(mypath) {
  filenames=list.files(path=mypath, full.names=TRUE)
  datalist = lapply(filenames, function(x){read.csv(file=x,header=T)})
  Reduce(function(x,y) {merge(x,y)}, datalist)
}
  
WeatherMerge = multmerge("/Users/ACM/FinalProject/Data/MergeCSV")
  
write.csv(WeatherMerge,
          file = "/Users/ACM/FinalProject/Results/WeatherSummary.csv", row.names=F)


ggplot(data=RainfallSum, aes(x = Date, y = Rainfall)) +
  geom_point() +
  labs(title = "Rainfall")


ag <- by(CombColumns[,c("RH", "AirTemp", "Rainfall", "SoilTemp", "SoilMoisture", "LeafWetness")],
         list(CombColumns$Date), function(x)rbind(colMeans(x), apply(x, 2, max), apply(x, 2, min)),
         means <- t(sapply(ag, function(x)x[1,])),
         max <- t(sapply(ag, function(x)x[2,])),
         mins <- t(sapply(ag, function(x)x[3,])),
         plot.dat <- data.frame(
           mean = c(means),
           max = c(maxs),
           min = c(mins),
           date = rep(as.Date(rownames(means), "%Y-%m-%d"), ncol(means)),
           vars = rep(colnames(means), each=nrow(means))))

byDay <- aggregate( CombColumns[,c("AirTemp")], CombColumns[,c("Date")], mean)
byDay <- aggregate( tab[,c("CM10", "CM30")], tab[,c("Year","month","day")], mean )

byDay <- CombColumns %>% group_by(Date) %>% summarise(mean = mean(AirTemp), mean2 = mean(Rainfall))

Weather2 <- subset(Weather, select = -c(Line.)) #Make duplicate of original data for manipulation
Weather2$DATE <- as.Date(Weather2$Date,format = "%m/%d/%y")  #Add new DATE column that is just date without timestamp

Weather2_JunJul <- Weather2 %>%
  filter(DATE >= '2020-06-01' & DATE <= '2020-07-31')

df = subset(Weather2, select = -c(Line.)) 
df2 = subset(Weather2, select = -c(Line.), DATE == "2020-05-19")

dfm <- match_df(Weather2, Weather2, on = "DATE") #Looks at matches between dataframes


install.packages("stringr") # Install stringr package
library("stringr")   

data1 <- df[str_detect(df$DATE, "2020-06"), ]  # Extract matching rows with str_detect
head(data1)


  
bb_longterm <- match_df(baseball, longterm, on="id")

ggplot(data=output, aes(x = Date, y = AirTemp)) +
  geom_point() +
  labs(title = "Air Temp")

outputd = as.data.frame((output)) #Convert output matrix to dataframe

outputd <- outputd %>%
  mutate(Date = as.Date(Date, format = "%m/%d/%y"))

outputn <- lapply(outputd,as.numeric) #Convert to numeric

Weather2$Date <- as.Date(Weather2$Date,format = "%m/%d/%y")

ggplot(data=Weather2, aes(x = Date, y = Temperature..S.THB.20648665.20640418.1....C..Carrollton..Empire.Chestnut..Air)) +
  geom_point() +
  labs(title = "Air Temp")

ggplot(data=Weather2, aes(x = Date, y = Rain..S.RGE.20648665.20647793.1...mm..Carrollton..Empire.Chestnut.)) +
  geom_point() +
  labs(title = "Rainfall")

ggplot(data=Weather2, aes(x = Date, y = Temperature..S.TMB.20648665.20634447.1....C..Carrollton..Empire.Chestnut..Soil)) +
  geom_point() +
  labs(title = "Soil Temp")

Weather2 <- Weather2 %>%
  na.omit()

precip_boulder_AugOct <- boulder_daily_precip %>%
  filter(DATE >= as.Date('2013-08-15') & DATE <= as.Date('2013-10-15'))




head(outputn)

hist(Weather)

x <- c(outputn$Date)

new <- match_df(outputn, "Date", on = NULL)


# Maps the length of each column
outputn %>% 
  map(length)

class(outputd)
class(outputn)
mean(outputn$Rainfall)



mean(outputd$Rainfall)


## Convert atomic vectors to numerica dataframe 

## Make new dataframe with column that just keeps date and removes timestamp
outputd$Date <- as.Date(output$Date, format = "%m/%d/%y")

mean(output$RH)


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
