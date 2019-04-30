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
