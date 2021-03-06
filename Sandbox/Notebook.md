# FinalProject: Daily Notes and Ideas

### Notes on 4/26/21: 
* Got combine column script to work with wind speed and wind direction, but for some reason I'm not seeing any values for PAR. No error code from R, just an entire blank column under the heading PAR. When the Weather data file is read into R, the Solar Radiation columns are classified as "character" instead of "numeric"
* Discovered "aggregate" function to pull out summary statistics by date based on matching row names under Date column

### Notes on 4/20/21:
* Didn't get combine column script to work with solar radiation, wind speed, or wind direction. Something is not right with the way I enter them as weatherpars. 

* Made WorkflowScript.R to set the working directory, load the data, and load necessary packages. 
++ Also shows the order in which separate scripts will be run in Bash. 



## Update 16 April 2021
* Created an updated script (with Jelmer's help) to merge the weather parameters columns using the coalesce() function
* Organized Final Project directory: Made directory for Data, Scripts, and Sandbox. Sandbox contains code notes and sample code for me to play with. Once code is finalized, it is copied into Scripts. 


## Update 15 April 2021

## Workflow: Part A

* Import weather data, call it "Weather" so it's shorter than the file name
+ To Do: There are 11 variables, with 3 columns for each variable. Need to combine 3 columns into 1 for each variable
* Create a new dataframe which is a subset of the old one, keeping only the columns selected
+ Example: RH = subset(Weather, select = c(Date, RH..S.THB.20648665.20640418.2......Carrollton..Empire.Chestnut.,
                                RH..S.THB.20648665.20640418.2......EmpireChestnut,
                                RH..S.THB.20648665.20640418.2......ChestnutFarm))
+ Dataframe of Date and Relative Humidity
* Install dplyr for data manipulation
* Rename columns, list name being replaced first, then replacement name
+ Example: names(RH)[names(RH) == "RH..S.THB.20648665.20640418.2......Carrollton..Empire.Chestnut."] <- "RH1"
* Create a duplicate data frame to manipulate without messing up the original
* Convert all columns to character (matrix)
* Replace NA with blank
* Convert back to dataframe to combine columns
* Concatenate the specified columns in the dataframe into a new column
* Delete original columns after combining them
* Delete RH_blank (intermediate step) because it's no longer needed
* See Finalproject_Code.R for annotated script for this example

### To Do: Make a script to run for each parameter. Need to match each set of 3 columns by first and last word of each column name. 
* How to do this?? I've found ways to subset data based on specific variables/names, and based on column/row placement, but not based on matching values in each column header, regardless of what those value are. 


## Workflow: Part B
* Extract and manipulate data from each column of the weather parameters for further statistical analysis
* Convert second column (e.g. RH) to numeric, while leaving first column (Date) as character
* Mutate the date so that the time stampes are removed and each row is grouped by date

### To Do: Same issue as above, but with rows. How to subset the data by simply matching rows instead of identifying each row value to match? 

## Ideas:
* Use Snakemake to concatenate columns in Part A? 
* Use pipes to group rows by date and generate summary statistics for each group, such as mean, max, and min


