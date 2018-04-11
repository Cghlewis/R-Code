#Presentation cont

#Let's view our data
head(data8,10)
colnames(data8)

#What types of variables do we have
str(data8)
#Dates look weird so let's convert those back to dates

#Can use this if dates come in as numbers

data4$StartDate2<-convertToDate(data4$StartDate)
data4$EndDate2<-convertToDate(data4$EndDate)


#Use this if dates come in as strings
data8$StartDate3<-as.Date(data8$StartDate)
data8$EndDate3<-as.Date(data8$EndDate)

str(data8)

#Drop the old dates if you had to change date type
newdata <- data8[c(-1:-2)]
head(newdata)

#Let's drop unnecessary vars
newdata$V10<-NULL
newdata$Q1<-NULL
newdata$Q3<-NULL

str(data8)

#Let's rename the variables
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

newdata$Q18_1new<-((max(newdata$Q18_1)+1)-newdata$Q18_1)
table(newdata$Q18_1, newdata$Q18_1new)
##If someone didn't get the max score, this formula will not work (you will need to say 11+1 instead)

#Sum scores

newdata$Stresssum <- newdata$Q18_1new + newdata$Q18_2 + newdata$Q18_3 + newdata$Q18_4 +
  newdata$Q18_5

##OR
colnames(newdata)

newdata$Stresssum2<- rowSums(newdata[ , c(9:12,14)]) 

#Review the sum scores
#Does everything look okay?
#Stats for sum score

mean(newdata$Stresssum)
sd(newdata$Stresssum)
range(newdata$Stresssum)
install.packages("psych")
library(psych)

describe(newdata$Stresssum)

describeBy(newdata$Stresssum, group=newdata$Female3)

table(newdata$Grade)

table(Female3,Grade)

str(newdata)







