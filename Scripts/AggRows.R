## Aggregate rows by date and generate summary statistics (mean, max, sum, etc) per day.
## Write aggregated data to new dataframe. Repeat for each statistic of interest.
## Write each dataframe to a CSV file in MergeCSV folder to be merged into single dataframe. 

#Aggregates AirTemp by Date for CombColumns, calculates Mean
AirTempMean <- aggregate(AirTemp~Date, CombColumns, mean)  
#Column head AirTemp is renamed to AirTempMean
names(AirTempMean)[names(AirTempMean) == "AirTemp"] <- "AirTempMean"  
#Exports CSV file to MergeCSV directory
write.csv(AirTempMean,
          file = "/Users/ACM/FinalProject/Data/MergeCSV/AirTempMean.csv", row.names=F) 

#Repeat the steps above for different weather parameters and different summary statistics
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


