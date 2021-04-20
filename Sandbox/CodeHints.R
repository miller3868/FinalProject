#Useful code and examples

rm(RH_df) #Removes data frame/file

#Install dplyr for data manipulation
install.packages("dplyr")
library(dplyr) #load dplyr

# 3 ways to delete columns with dplyr:
mydata2 = select(mydata, -a, -x, -y)
mydata2 = select(mydata, -c(a, x, y))
mydata2 = select(mydata, -a:-y)

##Useful website for column manipulation:
# https://www.listendata.com/2015/06/r-keep-drop-columns-from-data-frame.html

#Merging data:
# To merge two data frames (datasets) horizontally, use the merge function. In most cases, you join two data frames by one or more common key variables
# merge two data frames by ID
total <- merge(dataframeA,dataframeB,by="ID")
# merge two data frames by ID and Country
total <- merge(dataframeA,dataframeB,by=c("ID","Country"))

# To join two data frames (datasets) vertically (by row), use the rbind function. The two data frames must have the same variables, but they do not have to be in the same order.
total <- rbind(dataframeA, dataframeB)

# If data frameA has variables that data frameB does not, then either:
#Delete the extra variables in data frameA or
#Create the additional variables in data frameB and set them to NA (missing) before joining them with rbind( ).

#Concatenate columns in a dataframe
dataf$MY <- paste(dataf$Month, dataf$Year) 

#Creates a duplicate data frame to manipulate without messing up the original
data_blank <- data #example

# Convert all columns to character (matrix)
data_blank <- sapply(data_blank, as.character) 

# Replace NA with blank
data_blank[is.na(data_blank)] <- "" 

#Convert back to dataframe to combine columns
DF2 = as.data.frame(t(Mat1)) 
#Note that "t" indicates "transpose" and transposes the rows/columns
#Use without "t" to convert without transposing rows and columns



