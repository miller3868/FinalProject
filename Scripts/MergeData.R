## Merge dataframes in MergeCSV directory into a single CSV file.
## Export CSV file to Results directory.

multmerge = function(mypath) {
  filenames=list.files(path=mypath, full.names=TRUE)
  datalist = lapply(filenames, function(x){read.csv(file=x,header=T)})
  Reduce(function(x,y) {merge(x,y)}, datalist)
}

WeatherMerge = multmerge("/Users/ACM/FinalProject/Data/MergeCSV")

write.csv(WeatherMerge,
          file = "/Users/ACM/FinalProject/Results/WeatherSummary.csv", row.names=F)
