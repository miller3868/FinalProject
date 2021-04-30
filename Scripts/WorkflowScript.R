getwd()
setwd("/Users/ACM/FinalProject/Data")
library(tidyverse) #load dplyr

#Import weather data, call it "Weather" so it's shorter than the file name
Weather <- read.csv(file = 'MasterWeatherStation_EmpireChestnut.csv', header = TRUE, stringsAsFactors=FALSE)
head(Weather) #Look at the first 10 rows

Weather2 <- subset(Weather, select = -c(Line.)) #Make duplicate of original data for manipulation, get rid of "Line" column

#Run CombineColumns script: 
  #Input is Weather2 dataframe
  #Output is dataframe called CombColumns

#Run AggRows script: 
  #Input is CombColumns dataframe
  #Output is directory called MergeCSV (in Data directory) with separte CSV files of summary statistics

#Run MergeData script:
  #Input is MergeCSV directory
  #Output is WeatherSummary.csv file in "Results" directory


