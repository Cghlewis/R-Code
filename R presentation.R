##########Using R for data management##############

###Download R studio

##Hashtags!!
##Comment everything you do

#This is all using a pc, things are different for mac

###Extras

##Using sweep to clear environment
#Clear console


#####################################Getting your data into R#############################################

##Set your working directory so you don't have to write that every time
##Use forward slashes
##R is case sensitive
#Use sweep below to clear out Global Environment
#Use Edit--Clear Console to clear console

setwd("C:/Users/hamptoncg/Desktop/R")

##Read data into R and assign it to a "data frame", otherwise it will read in data but you can't access it

#Read.table can be used to load in any basic text file

#Typing read.table into console to get all options

#txt

data<-read.table("Comma Separated TXT.txt", header = FALSE, sep=",")

#dat

data2<-read.table("Tab Delimited DAT.dat", sep="\t", header=FALSE)

#csv
data3<-read.table("CSV.csv", sep=",",header=TRUE)

  #Could also use read.csv
sample<-read.csv("CSV.csv")

  #There are TOO many ways to install the same file

####install.packages("readr")
####library(readr)

####sample2<-read_csv("CSV.csv")

###For files that have any formatting you can't use read.table. You'll need some sort of package.

#xlsx

  #Install packages to help load data

install.packages("openxlsx")
library(openxlsx)

  #Typing read.xlsx into console to get all options

data4<-read.xlsx("XLSX two row.xlsx", sheet=1, startRow =2, colNames=TRUE)
str(data4)

  #Dates come in as strings this way
  #Can convert back to date using this

data4$StartDate2<-convertToDate(data4$StartDate)
data4$EndDate2<-convertToDate(data4$EndDate)


#spss, sas, stata, you can use the "foreign" package

install.packages("foreign")

library(foreign)

data12<-read.spss("SPSS.sav", to.data.frame=T, use.value.labels=FALSE)
str(data6)
str(data12)

##OR

readLines("C:/Users/hamptoncg/Desktop/R/Teacher_Self_Report.csv", 
          n=10)

##Bad thing about foreign is that it brings strings in as factors which you may not want

#Haven is how R loads in data if you use the file--import dataset drop down menu
library(haven)
SPSS <- read_sav("C:/Users/hamptoncg/Desktop/R/SPSS.sav")
View(SPSS)

str(SPSS)

##There is one package that will allow you to load in all data types the same way, Rio

install.packages("rio")
library(rio)

#txt

data7<-import("Comma Separated TXT.txt")

#xlsx
##Date actually loads in correctly! 
data8<-import("XLSX two row.xlsx", skip=1)
str(data8)

#SPSS
#Rio will load your strings in as strings
data9<-import("SPSS.sav")
str(data9$TeacherID)
str(data9)
#Looks a lot cleaner
#Structure will look weird for SPSS b/c it brings in all the SPSS formatting but it's ok

####install.packages("Hmisc")
###library(Hmisc)
####mydata <- spss.get("SpSS.sav", use.value.labels=TRUE)


