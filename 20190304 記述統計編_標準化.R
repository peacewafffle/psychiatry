
x <- c(40, 46, 60, 49, 43, 60, 34, 50, 44, 33, 40, 41, 42, 47, 38)
hist(x)
summary(x)
var(x)
sd(x)
scale(x) #標準化
scale(x)*10+50　#偏差値
var(scale(x)) #標準化により0に
mean(scale(x))　#標準化により1に
hist(x, breaks = seq(20, 80, 2.5))

#正規分布
m <- mean(x)
s <- sd(x)
x1 <- seq(20, 80, 0.01)
d <- dnorm(x1, mean=m, sd=s)
plot(x1,d, type="l")

#pnorm関数
X <- 850
m <- 582.6
s <- 172.7
n <- 103955
Z <- (X-m)/s

d = pnorm(Z, mean=0, sd=1) 
n*(1-d)*100

