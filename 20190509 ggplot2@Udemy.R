getwd()

movies <- read.csv("P2-Movie-Ratings.csv")
head(movies)
colnames(movies) <- c("Film", "Genre", "CriticRating", "AudienceRating","BudgetMillions", "Year")
head(movies)
tail(movies)
str(movies)
summary(movies)

factor(movies$Year)

movies$Year <- factor(movies$Year)
summary(movies)
str(movies)
?factor

#Aesthetics
library(ggplot2)

ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))

#add geometry
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) + 
  geom_point()

#add colour
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, colour=Genre, size=BudgetMillions)) + 
  geom_point()

# Plotting with Layers
p <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, colour=Genre, size=BudgetMillions)) 

#point
p + geom_point()

#lines
p + geom_line() 

#mutiple layers
p + geom_line() + geom_point()
p + geom_point() + geom_line()

#Overrinding Aesthetics
q <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, colour=Genre, size=BudgetMillions)) 

#add geom layer
#ex1
q + geom_point(aes(size=CriticRating))

#ex2
q + geom_point(aes(colour=BudgetMillions))

#ex3
q + geom_point(aes(x=BudgetMillions)) + xlab("Budget Millions $$$")

#ex4
q + geom_line() + geom_point()
#reduce line size
q + geom_line(size=1) + geom_point()


#Mapping vs Setting

r <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))
r + geom_point()  
# Add colour
#1 Maping (what we've done so far)
r + geom_point(aes(colour=Genre))
#2 Setting
r + geom_point(colour="DarkGreen")
# Error
#r + geom_point(aes(colour="DarkGreen"))

#1. Mapping
r + geom_point(aes(size=BudgetMillions))
#2. Setting
r + geom_point(size=10)
# Error
#r + geom_point(aes(size=10))

# Histograms and Densityd Charts
s <- ggplot(data=movies, aes(BudgetMillions))
s + geom_histogram(binwidth=10)

# add colour
s + geom_histogram(binwidth=10, aes(fill=Genre))
# add a border
s + geom_histogram(binwidth=10, aes(fill=Genre), colour="Black")
#>>>3 (we will improveit)

#someties you may need density charts
s + geom_density(aes(fill=Genre))
s + geom_density(aes(fill=Genre), position="stack")

# Stating Layer Tips

t <- ggplot(data=movies, aes(x=AudienceRating))
t + geom_histogram(binwidth = 10, fill="White", colour="Blue")

#another way
t <- ggplot(data=movies)
t + geom_histogram(binwidth = 10, 
                   aes(x=AudienceRating),
                   fill="White", colour="Blue")

#>>>4
t + geom_histogram(binwidth = 10, 
                   aes(x=CriticRating),
                   fill="White", colour="Blue")

#>>>5 

t <- ggplot()

# Statistical Transformations

?geom_smooth
u <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, colour=Genre))
u + geom_point() + geom_smooth(fill=NA)

# boxplots
u <- ggplot(data=movies,aes(x=Genre, y=AudienceRating,colour=Genre))
u + geom_boxplot()
u + geom_boxplot(size=1.2)
u + geom_boxplot(size=1.2) + geom_point()

#tip/ hack
u + geom_boxplot(size=1.2) + geom_jitter()

#another way
u + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)

#>>>6

# Using Facets
v <- ggplot(data=movies, aes(x=BudgetMillions))
v + geom_histogram(binwidth = 10, aes(fill=Genre),
                   colour="Black")

#facets
v + geom_histogram(binwidth = 10, aes(fill=Genre),
                   colour="Black") +
  facet_grid(Genre~., scales="free")

#scatterplots
w <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             colour=Genre))
w + geom_point(size=3)

#facet
w + geom_point(size=3) +
  facet_grid(Genre~.)

w + geom_point(size=3) +
  facet_grid(.~Year)

w + geom_point(size=3) +
  facet_grid(Genre~Year)

w + geom_point(size=3) +
  geom_smooth() +
  facet_grid(Genre~Year)

w + geom_point(aes(size=BudgetMillions)) +
  geom_smooth() +
  facet_grid(Genre~Year)

ggsave("movies.png", height=15, width=15, units="in", dpi = 300) 
#>>>1 (but still will improve)

# Coordinates

#limits
#zoom

m <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             size=BudgetMillions,
                             colour=Genre))

m + geom_point() +
  xlim(50,100) +
  ylim(50,100)

#won't wokr well always
n <- ggplot(data = movies,aes(x=BudgetMillions))
n + geom_histogram(biwidth=10, aes(fill=Genre), colour="Black") +
  ylim(0,50)

#insted - zoom
n + geom_histogram(biwidth=10, aes(fill=Genre), colour="Black") +
  coord_cartesian(ylim=c(0,50))

#improve #1
w + geom_point(aes(size=BudgetMillions)) +
  geom_smooth() +
  facet_grid(Genre~Year) +
  coord_cartesian(ylim=c(0,100))

#Theme
o <- ggplot(data=movies, aes(BudgetMillions))
h <- o + geom_histogram(binwidth = 10,aes(fill=Genre), colour="Black")
h

#axes labels
h + xlab("Money Axis") + 
  ylab("Number of Movies") +
  ggtitle("Movie Budget Distribution") +
  theme(axis.title.x = element_text(colour="DarkGreen", size=30),
        axis.title.y = element_text(colour="Red", size=30), 
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        legend.title = element_text(size=20),
        legend.text = element_text(size=10),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        
        plot.title = element_text(colour="DarkBlue",
                                  size=40,
                                  family = "Courier"))
        
