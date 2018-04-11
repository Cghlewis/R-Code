##Making graphs in R

#Graphs built in
hist(newdata$Stresssum)

plot(newdata$Q18_1new,newdata$Q18_2)

xyplot(newdata$Q18_1new~newdata$Q18_2)

xyplot(newdata$Q18_1new~newdata$Q18_2|newdata$Female3)

##You can set the working dataset so you don't have to write "newdata" all the time, but
#this is only an attachment, you cannot alter this dataframe

# Set the working dataset
attach(newdata)

xyplot(Q18_1new~Q18_2|Female3)


#Packages for graphs

install.packages("lattice")
library(lattice)

histogram(newdata$Stresssum)
histogram(~newdata$Stresssum|newdata$Female3)


install.packages("ggplot2")
library(ggplot2)

qplot(x=Q18_1new, y=Q18_2,data=newdata, geom="point")


##For this plot you have to designate Grade as a factor or the legend will show grade as
#a continous variable
ggplot(newdata,aes(x=Q18_1new,y=Q18_2, color=Female3, shape=Female3, size=factor(Grade))) +geom_point() +labs(color="Female3", x="Stress1", y="Stress2")

##Different shapes are different numbers
ggplot(newdata,aes(x=Q18_1new,y=Q18_2, color=Female3, size=factor(Grade)))+geom_point(shape=18) +labs(color="Female3", x="Stress1", y="Stress2")

##Decide your number of bins

ggplot(newdata, aes(x=Stresssum, fill=Female3)) +geom_histogram(bins = 10)