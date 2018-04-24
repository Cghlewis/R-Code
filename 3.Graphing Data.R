##Making graphs in R

#Graphs built in to R
hist(newdata$Stresssum)

plot(newdata$Q18_1new,newdata$Q18_2)

boxplot(newdata$Stresssum~newdata$Grade)

      #Add group labels (las=2 makes my group names horizontal)

boxplot(newdata$Stresssum~newdata$Grade, las=2, names=c("Grade 1", "Grade 2", "Grade 3"))

      #Add axis labels and adjust the range on my y axis
boxplot(Stresssum~Grade, data=newdata, xlab='Grade',ylab = 'Stress Sum Score', ylim=c(0,100))

      #Add color (just google R colors to get a list of all color options)

boxplot(newdata$Stresssum~newdata$Grade, ylab='Stress Sum Score',las=2, col=c("aquamarine1", "coral1", "cadetblue1"),names=c("Grade 1", "Grade 2", "Grade 3"))


##You can set the working dataset so you don't have to write "newdata" all the time
      #this is only an attachment, you cannot alter this dataframe

# Set the working dataset
attach(newdata)

xyplot(Q18_1new~Q18_2|Female3)


#Packages for graphs

#Lattice
        #This package allows creation of trellis graphs (you can group graph by variables)

install.packages("lattice")
library(lattice)

xyplot(newdata$Q18_1new~newdata$Q18_2)
xyplot(newdata$Q18_1new~newdata$Q18_2|newdata$Female3)


histogram(newdata$Stresssum)
histogram(~newdata$Stresssum|newdata$Female3)


#ggplot2

install.packages("ggplot2")
library(ggplot2)

      #Qplot
      #Scatterplot

qplot(x=Q18_1new, y=Q18_2,data=newdata, geom="point")

      #Histogram, adjust bin width

qplot(Stresssum,data=newdata, geom="histogram", binwidth=.5, na.rm=TRUE)

      #Ggplot

      #Scatterplot
      #Add color by Gender and size by grade and shape by gender and axis labels
      #For this plot you have to designate Grade as a factor or the legend will show grade as a continous variable

ggplot(newdata,aes(x=Q18_1new,y=Q18_2, color=Female3, shape=Female3, size=factor(Grade))) +geom_point() +labs(color="Female3", x="Stress1", y="Stress2")

      #Different shapes are different numbers, google R shapes

ggplot(newdata,aes(x=Q18_1new,y=Q18_2, color=Female3, size=factor(Grade)))+geom_point(shape=18) +labs(color="Female3", x="Stress1", y="Stress2")

      #Histogram

ggplot(newdata, aes(x=Stresssum, fill=Female3)) +geom_histogram

      ##Decide your number of bins

ggplot(newdata, aes(x=Stresssum, fill=Female3)) +geom_histogram(bins = 10)
