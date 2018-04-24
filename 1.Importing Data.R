##########Using R for data management##############

###Download R studio

##Hashtags!!
##Comment everything you do

#This is all using a pc, things are different for mac

###Extras
          ##Can use sweep to clear environment
          ##Can use Edit->Clear console to clear console

##Reading in data
          ##Use forward slashes
          ##R is case sensitive

#Just to read the dataset, does not make a dataframe

readLines("C:/Users/hamptoncg/Desktop/R/CSV.csv", 
          n=10)


#####################################Getting your data into R#############################################

##Set your working directory so you don't have to write that every time

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

data4<-read.csv("CSV.csv")

       #It is exactly like read.table except for defaults (example it automatically reads headers)


##For files that have any formatting you can't use read.table. You'll need some sort of package.

       ##Packages most be loaded one time in R and then called from the library every time you open R


##Package 1: Open XLSX

       #xlsx

install.packages("openxlsx")
library(openxlsx)

       #Typing read.xlsx into console to get all options

       #In the example below there are two rows of labels at the top.  I only want the 
       #second row.

data5<-read.xlsx("XLSX two row.xlsx", sheet=1, startRow =2, colNames=TRUE)
str(data5)


     #Dates come in as numbers this way
     #Can convert back to date using this

data5$StartDate2<-convertToDate(data5$StartDate)
data5$EndDate2<-convertToDate(data5$EndDate)


##Package 2: Read XL

install.packages("readxl")
library(readxl)

      #Read XL is how R loads in excel if you use the file--import dataset drop down menu
      #Typing read_excel into console to get all options

XLSX_one_row <- read_excel("XLSX two row.xlsx", skip=1)
View(XLSX_one_row)
str(XLSX_one_row)

XLSX_one_row <- read_excel("XLSX one row.xlsx")
View(XLSX_two_row)
str(XLSX_two_row)

      #Dates come in as strings this way

##Package 3: Readr

      #Readr is how R loads in csv if you use the file--import drop down menu

install.packages("readr")
library(readr)
dataset <- read_csv("CSV.csv")

##Package 3: Foreign 

      #spss, sas, stata, you can use the "foreign" package

install.packages("foreign")
library(foreign)

       #Typing read.spss into console to get all options
       #spss, sas, stata
       #You must save the dataset to data frame
       #Use.value.labels=True (which is default) turns your value labels into factors (You may or may not want)

data6<-read.spss("SPSS.sav", to.data.frame=T)
str(data6)


##Package 3: Haven

      #Haven is how R loads in spss, sas and stata if you use the file--import dataset drop down menu
      #spss, sas, stata

install.packages("haven")
library(haven)

       #Typing read_sav into console to get all options***

SPSS <- read_sav("C:/Users/hamptoncg/Desktop/R/SPSS.sav")
View(SPSS)
str(SPSS)

##There is one package that will allow you to load in all data types the same function (csv, excel, spss, stata, sas, etc.)

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
          #Looks a lot cleaner
          #Structure will look weird for SPSS b/c it brings in all the SPSS formatting but it's ok
          #Value labels do not come in as factors
data9<-import("SPSS.sav")
str(data9$TeacherID)
str(data9)

##Reading a file directly from github

x <- read.csv ("https://raw.githubusercontent.com/Cghlewis/Sample-files/master/CSV.csv")



