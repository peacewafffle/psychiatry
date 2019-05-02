getwd()
setwd("/Users/peacewaffle/Desktop")
stats <- read.csv("P2-Demographic-Data.csv")


# Exploring Data
stats
nrow(stats)
ncol(stats)
head(stats)
tail(stats)
head(stats, n=10)
str(stats) 
summary(stats)

# Using the $ sign
stats
head(stats)
stats[3,3]
stats[3, "Birth.rate"]
stats["Angola",3] # This does not work.
stats$Internet.users
stats$Internet.users[2]
stats[,"Internet.users"]
str(stats)
levels(stats$Income.Group)

# Basic Operations with a DF
stats[1:10,] #subsetting
stats[c(4,100),]
#Remember how the[] work
is.data.frame(stats[1,]) #no need for drop=F
is.data.frame(stats[,1])
is.data.frame(stats[,1,drop=F])
#multiple columns
head(stats)
stats$Birth.rate * stats$Internet.users
stats$Birth.rate + stats$Internet.users
#add column
head(stats)
stats$MyCalc <- stats$Birth.rate * stats$Internet.users
head(stats)
#test of knowledge
stats$xyz <- 1:5
head(stats)
#remove a cloumn
head(stats)
stats$MyCalc <- NULL
stats$xyz <- NULL
head(stats)

# Filtering Data Frames
head(stats)
filter <- stats$Internet.users <2
stats[filter,]

stats[stats$Birth.rate>40 & stats$Internet.users < 2,]
stats[stats$Income.Group == "High income",]
levels(stats$Income.Group)

stats[stats$Country.Name == "Malta",]

# Introduction to qplot()
library(ggplot2)
?qplot
qplot(data=stats,x=Internet.users)
qplot(data=stats, x=Income.Group, y=Birth.rate, size=I(3), 
      colour=I("blue"))
qplot(data=stats, x=Income.Group, y=Birth.rate, geom="boxplot")

#Visualizing what we need
qplot(data=stats, x=Internet.users, y=Birth.rate)
qplot(data=stats, x=Internet.users, y=Birth.rate,
      size=I(4))
qplot(data=stats, x=Internet.users, y=Birth.rate,
      colour=I("red"), size=I(4))
qplot(data=stats, x=Internet.users, y=Birth.rate,
      colour=Income.Group, size=I(4))

#Creating Data Frames
mydf <- data.frame(Countries_2012_Dataset, Codes_2012_Dataset,
                   Regions_2012_Dataset)
head(mydf)
#colnames(mydf) <- c("County", "Code", "Region")
#head(mydf)
rm(mydf)

mydf <- data.frame(Country=Countries_2012_Dataset, Code=Codes_2012_Dataset,
                   Region=Regions_2012_Dataset)
head(mydf)
tail(mydf)
summary(mydf)

#Merging Data Frames
head(stats)
head(mydf)

merged <- merge(stats, mydf, by.x = "Country.Code", by.y = "Code")
head(merged)

merged$Country <- NULL
str(merged)
tail(merged)

#Visualizing with new Spilit
qplot(data=merged, x=Internet.users, y=Birth.rate)
qplot(data=merged, x=Internet.users, y=Birth.rate,
      colour=Region)
#1. Shape
qplot(data=merged, x=Internet.users, y=Birth.rate,
      colour=Region,size=I(2), shape=I(15))
#2. Transparancy
qplot(data=merged, x=Internet.users, y=Birth.rate,
      colour=Region,size=I(2), shape=I(19),
      alpha=I(0.6))
#3. Title
qplot(data=merged, x=Internet.users, y=Birth.rate,
      colour=Region,size=I(2), shape=I(19),
      alpha=I(0.6),
      main="Birth Rate vs Internet Users")

