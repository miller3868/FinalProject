# Final Project: Summary and Workflow
### Amy Miller, PLNTPTH 8300 Practical Computing Skills for Biologists, SP21

This project is housed locally on my computer and pushed to GitHub. The parent directory is called Final Project. In it there is a ProjectProposal that outlines the project background and goals. Here is a guide to the important files and folders:
* The Data directory contains the raw data file and MergeCSV folder with working data
* The Scripts directory contains the scripts to execute the data analysis
* The Results directory has the final output file of organized and summarized weather data that can be used for downstream data analysis beyond the scope of this project
* The Snakefile contains the information for running the scripts, including the order of operations
* The Sandbox directory contains practice scripts, notes, and other useful things I've discovered along the way that I might want to refer back to in the future. Scripts in Sandbox are not very well organized and are not meant to be graded.  

## Technical Details:  
Coding language = R (RStudio Server available through OSC)  
Version Control via Git integrated into RStudio  
Scripts can be run in R or from the Command Line
I will not do this as a SLURM job through OSC because it's unnecessary given the small size of the data file (as previoulsy discussed)

## Workflow 
### This explains the workflow found in the Snakefile

* setwd("/Users/ACM/FinalProject/Data")
* library(tidyverse) #load dplyr

### Import weather data, call it "Weather" so it's shorter than the file name
* Weather <- read.csv(file = 'MasterWeatherStation_EmpireChestnut.csv', header = TRUE, stringsAsFactors=FALSE)
* head(Weather) #Look at the first 10 rows

* Weather2 <- subset(Weather, select = -c(Line.)) #Make duplicate of original data for manipulation, get rid of "Line" column

### Run CombineColumns script: 
* This merges the duplicated columns into a singe column per weather parameter and makes a new Date column with can be used to aggregate rows by date
* Input is Weather2 dataframe
* Output is dataframe called CombColumns

### Run AggRows script: 
* This aggregates rows by date, meaning all rows with the same date are recognized and summary statistics are generated for those blocks of data. Each parameter and statistic are exported as a separate dataframe. 
* Input is CombColumns dataframe
* Output is directory called MergeCSV (in Data directory) with separte CSV files of summary statistics

### Run MergeData script:
* This merges the separate dataframes into a single dataframe with is then exported as a CSV to the results directory and can be used in the future for regression analysis against chestnut disease data
* Input is MergeCSV directory
* Output is WeatherSummary.csv file in "Results" directory
  
  
