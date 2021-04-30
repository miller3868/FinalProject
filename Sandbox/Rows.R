
#Make vector of month names
monthnames <- c("May", "June", "July", "Aug", "Sept", "Oct", "Nov")
#Make vector that pulls out dates by month
monthpars <- c(CombColumns[str_detect(CombColumns$Date, "2020-05"), ],
               CombColumns[str_detect(CombColumns$Date, "2020-06"), ],
               CombColumns[str_detect(CombColumns$Date, "2020-07"), ],
               CombColumns[str_detect(CombColumns$Date, "2020-08"), ],
               CombColumns[str_detect(CombColumns$Date, "2020-09"), ],
               CombColumns[str_detect(CombColumns$Date, "2020-10"), ],
               CombColumns[str_detect(CombColumns$Date, "2020-11"), ])

Mean <- function(monthpars) {
  
}

Myfunc<- function(directory, MyFiles, id = 1:332) {
  # uncomment the 3 lines below for testing
  #directory<-"local"
  #id=c(2, 4)
  #MyFiles<-c(f2.csv,f4.csv)
  idd<-id
  
  df2 <- data.frame()
  
  for(i in 1:length(idd)) {
    EmptyVector <- read.csv(MyFiles[i])  
    comp_cases[i]<-sum(complete.cases(EmptyVector))
    print(comp_cases[[i]])
    id=idd[i]
    ret2=comp_cases[[i]]
    df2<-rbind(df2,data.frame(id,ret2))
  }
  print(df2)
  return(df2)
}


mean(monthpars$AirTemp)

rowdata <- function(monthpar, CombColumns) {
  Tempdata <- CombColumns %>%
  select(matches(monthpar))
  r1 <- mean(monthpar$AirTemp) 
  r2 <- max(monthpar$AirTemp)
  r3 <- min(monthpar$AirTemp)
  Temp <- data.frame(r1, r2, r3)
  return(Temp)}

rowout <- do.call(rbind, lapply(monthpars, rowdata, CombColumns))
colnames(Temp) <- monthnames
TempOut <- rbind(Temp, data.frame(r1, r2, r3))

output <- do.call(cbind, lapply(weatherpars, getpar, Weather2))
output <- as.data.frame(output)
colnames(output) <- parnames
CombColumns <- cbind(Date = (Weather2$DATE <- as.Date(Weather2$DATE, format = "%m/%d/%y")), 
                     FullDate = Weather2$Date, output)


getpar <- function(weatherpar, Weather2) {
  parcolumns <- Weather2 %>% 
    select(matches(weatherpar))
  colnames(parcolumns) <- c("a", "b", "c")
  par_all <- coalesce(parcolumns$a, parcolumns$b, parcolumns$c)
  return(par_all)
}

#Separate data from CombColumns into a dataframe for each month
May <- CombColumns[str_detect(CombColumns$Date, "2020-05"), ]
June <- CombColumns[str_detect(CombColumns$Date, "2020-06"), ]
July <- CombColumns[str_detect(CombColumns$Date, "2020-07"), ]
Aug <- CombColumns[str_detect(CombColumns$Date, "2020-08"), ]
Sept <- CombColumns[str_detect(CombColumns$Date, "2020-09"), ]
Oct <- CombColumns[str_detect(CombColumns$Date, "2020-10"), ]
Nov <- CombColumns[str_detect(CombColumns$Date, "2020-11"), ]

Temp <- cbind(mean(May$AirTemp), mean(June$AirTemp), mean(July$AirTemp), mean(Aug$AirTemp), mean(Sept$AirTemp),
              mean(Oct$AirTemp), mean(Nov$AirTemp)) 

colnames(Temp) <- monthnames




library("data.table")
data2 <- iris[iris$Species %like% "virg", ]

data1 <- df[df$DATE %like% "2020-05", ]


ed_exp3 <- education[which(education$Region == 2), names(education) %in% 
                      c("State","Minor.Population","Education.Expenditures")]


ed_exp4 <- subset(education, Region == 2, select = c("State","Minor.Population","Education.Expenditures"))
data <- subset(Weather2, DATE == "^2020-05*", select = c("Water.Content..S.SMD.20648665.20646428.1...m.3.m.3..ChestnutFarm.Soil.Moisture",
                                                     "Temperature..S.TMB.20648665.20634447.1....C..ChestnutFarm.Soil",
                                                     "Wetness..S.LWA.20648665.20647035.1......ChestnutFarm.Leaf"))

ed_exp5 <- select(filter(education, Region == 2), c(State,Minor.Population:Education.Expenditures))




  par_all <- coalesce(parcolumns$a, parcolumns$b, parcolumns$c)
  return(par_all)


output <- do.call(cbind, lapply(weatherpars, getpar, Weather))
colnames(output) <- parnames
output <- cbind(Date = Weather$Date, output)

data1 <- df[str_detect(df$DATE, "2020-06"), ]  # Extract matching rows with str_detect







