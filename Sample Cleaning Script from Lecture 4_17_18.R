install.packages("openxlsx")
library(openxlsx)

  ##1
  #Import Data
data<-read.xlsx("https://raw.githubusercontent.com/Cghlewis/Sample-files/master/XLSX two row.xlsx
",sheet=1, startRow =2, colNames=TRUE)
str(data)

data2<-read.xlsx("https://raw.githubusercontent.com/Cghlewis/Sample-files/master/XLSX two row.xlsx
",sheet=2, startRow =1, colNames=TRUE)
str(data2)


  ##2
  #Merge in ID
Merged<-merge(data,data2,by=c("TeacherName"), all=TRUE)

  #Delete name
Merged$TeacherName<-NULL

  ##3
  #Check for duplicates
install.packages("dplyr")
library(dplyr)

which(duplicated(Merged$TeacherID))

  #Remove the duplicate

Merged<-Merged[-c(19),]

  ##4
  #Drop unnecessary variables
Merged$V10<-NULL
Merged$Q1<-NULL
Merged$Q3<-NULL

  ##5
  #Rename variables and add labels if necessary 

  #Rename variables

install.packages("plyr")
library(plyr)

Merged<-rename(Merged, c("Q4"="SchoolID", "Q5"="Age", "Q6"="Gender", "Q7"="Race", "Q7_TEXT"="Race_Text",
                           "Q8"="Grade"))
head(Merged)

  #Add variable labels

install.packages("Hmisc")
library(Hmisc)

label(Merged$Age) <- "Age at time of survey"
describe(Merged)

  ##6
  #Add value labels for nominal/factor variables

Merged$SchoolID<-factor(Merged$SchoolID,levels=c(1,2,3,4),labels=c("SchoolA","SchoolB","SchoolC","SchoolD"))
describe(Merged)

  ##7
  #Recode any variables if necessary

Merged$Q18_1new<-((max(Merged$Q18_1)+1)-Merged$Q18_1)

  #Check to see if recode worked
table(Merged$Q18_1, Merged$Q18_1new)

  #Recode Gender
install.packages("car")
library(car)

Merged$Female<-recode(Merged$Gender,"1=0;2=1")

  #Check to see if recode worked
table(Merged$Female, Merged$Gender)

  #Make our date an actual date

Merged$StartDate2<-convertToDate(Merged$StartDate)
Merged$EndDate2<-convertToDate(Merged$EndDate)


  #Check to see if it worked
str(Merged)

  #Drop all original variables

Merged$StartDate<-NULL
Merged$EndDate<-NULL
Merged$Gender<-NULL
Merged$Q18_1<-NULL

  ##8
  #Create measure scores (na.rm=TRUE)

Merged$Stresssum <- Merged$Q18_1new + Merged$Q18_2 + Merged$Q18_3 + Merged$Q18_4 +
  Merged$Q18_5


  ##9
  #We don't actually have any missing data
  #If we wanted to make missing -999 then do

Merged$Q18_1new[Merged$Q18_1new=='NA']<--999


   ##Number of cases

nrow(Merged)

    #Number of cases by number of variables

dim(Merged)

   ##Check descriptives
  
mean(Merged$Stresssum)
sd(Merged$Stresssum)
range(Merged$Stresssum)
  
install.packages("psych")
library(psych)
  
describe(Merged)
  
    ##Check for missing data (Tweak this to skip over string variables)
  
Merged[!complete.cases(Merged),]


library(Hmisc)
describe(Merged)

    ##Export

    #write adds in an extra column b/c r gives row names so say row names false
    #missing values have N/A
write.csv(Merged, file="C:/Users/hamptoncg/Desktop/R/Merged2.csv", row.names=F)

    #Or can use a package

install.packages("rio")
library(rio)

    #missing values are blank
export(Merged, file="C:/Users/hamptoncg/Desktop/R/Merged3.csv")

