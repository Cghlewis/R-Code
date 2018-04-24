####Cleaning academic data (missing merging, transposing and finding duplicates)

#View our data (the excel file we imported using Rio)
head(data8,10)
colnames(data8)

#What types of variables do we have
str(data8)

#Dates come in as strings so convert those back to dates

      #Use this if dates come in as strings
data8$StartDate3<-as.Date(data8$StartDate)
data8$EndDate3<-as.Date(data8$EndDate)

      #Can use this if dates come in as numbers

data4$StartDate2<-convertToDate(data4$StartDate)
data4$EndDate2<-convertToDate(data4$EndDate)

str(data8)

#Drop the old dates if you had to change date type
newdata <- data8[c(-1:-2)]
head(newdata)

##Remove cases that didn't complete the survey

      ##V10 was a variable we collected that tells us whether the survey was complete or not

newdata<-subset(newdata, V10!=0)

#Drop unnecessary vars
newdata$V10<-NULL
newdata$Q1<-NULL
newdata$Q3<-NULL

head(newdata)
colnames(newdata)

#Rename the variables

install.packages("plyr")
library(plyr)

newdata<-rename(newdata, c("Q4"="SchoolID", "Q5"="Age", "Q6"="Gender", "Q7"="Race", "Q7_TEXT"="Race_Text",
                  "Q8"="Grade"))
head(newdata)

#Recode Gender

install.packages("car")
library(car)

newdata$Female<-recode(newdata$Gender,"1=0;2=1")
table(newdata$Female, newdata$Gender)

      ##OR
newdata$Female2<-ifelse(newdata$Gender == 1, 0, ifelse(newdata$Gender == 2, 1, 3))
table(newdata$Female2, newdata$Gender)

      ##OR (this makes gender a string with labels)
newdata$Female3[newdata$Female2==0] <- "Male"
newdata$Female3[newdata$Female2==1] <- "Female"

str(newdata$Female3)

#Reverse code 18_1

      #If someone didn't get the max score, this formula will not work (you will need to say 11+1 instead)
      #This won't work if someone has missing data in Q18_1

newdata$Q18_1new<-((max(newdata$Q18_1)+1)-newdata$Q18_1)

table(newdata$Q18_1, newdata$Q18_1new)

      #This works with missing data

newdata$Q18_1new2<-recode(newdata$Q18_1,"1=11; 2=10; 3=9; 4=8; 5=7; 6=6; 7=5; 8=4; 9=3; 10=2; 11=1")

str(newdata)

table(newdata$Q18_1, newdata$Q18_1new2, useNA='always')

#Sum scores

      ##Summing but omitting cases with missing data

newdata$Stresssum <- newdata$Q18_1new + newdata$Q18_2 + newdata$Q18_3 + newdata$Q18_4 +
  newdata$Q18_5

      ##OR
      #Will also omit cases with missing values
      ##It says sum variables in columns 9-12 and also the variable in column 14

newdata$Stresssum2<- rowSums(newdata[ , c(9:12,14)]) 

#Review the sum scores
#Does everything look okay?
#Stats for sum score

      #Have to add na.rm=true if there are NAs (remove cases with NA)

mean(newdata$Stresssum, na.rm=TRUE)
sd(newdata$Stresssum)
range(newdata$Stresssum)

      #This package allows you to see several descriptives at once, don't have to put na.rm=TRUE either

install.packages("psych")
library(psych)

describe(newdata$Stresssum)

describeBy(newdata$Stresssum, group=newdata$Female3)

table(newdata$Grade)

table(Female3,Grade)













