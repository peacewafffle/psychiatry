p <- rnorm(n, mean = m, sd = s)
n <- 10000
m <- 170
s <- 5.5

p <- rnorm(n, mean = m, sd = s)

hist(p)

x <- sample(p, 100)

hist(x)
summary(x)
sd(x)

n <- 3000000
m <- 70
s <- 10

d <- rnorm(n, mean = m, sd = s)
d <-ifelse(d>100, 100, d)

hist(d)

x <- sample(d, 3)
x
mean(x)
sd(x)
max(x)
var(x)
sum((x-mean(x))**2)/2

n <- 3000000
m <- 70
s <- 10

d <- rnorm(n, mean = m, sd = s)
d <-ifelse(d>100, 100, d)

hist(d)

x <- sample(d, 1)


r1 <- x-1.96*s
r2 <- x+1.96*s
x
c(r1, r2)

n <- 3000000
m <- 70
s <- 10

d <- rnorm(n, mean = m, sd = s)
d <-ifelse(d>100, 100, d)

n1 <- 1
n2 <- 15

x1 <- sample(d, n1)
x2 <- sample(d, n2)
xb <- mean(x2)

rl1 <- x1 - 1.96*(s/sqrt(n1))
ru1 <- x1 + 1.96*(s/sqrt(n1))

rl2 <- x1 - 1.96*(s/sqrt(n2))
ru2 <- x1 + 1.96*(s/sqrt(n2))

c(rl1, ru1, ru1-rl1)
c(rl2, ru2, ru2-rl2)

n <- 400
x <- rnorm(n, mean = 70, sd = 10)

xb <- mean(x)
s <- sd(x)

rl <- xb - 1.96*(s/sqrt(n)) 
ru <- xb + 1.96*(s/sqrt(n)) 
c (rl, ru)

# 仮設検定

xb <- 98
s <- 5
m <- 100
n <- 30

z <- (xb-m) / (s/sqrt(n))

pnorm(1.96, mean=0, sd=1) #平均0、標準偏差0の正規分布における1.96までの面積（積分された値）
pnorm(-1.96, mean=0, sd=1) 
pnorm(-1.64, mean=0, sd=1) 
qnorm(0.05, mean=0, sd=1) #pnormとは逆に0.05になる値を見つけてくれる
qnorm(0.95, mean=0, sd=1)

x <- rnorm(30, mean=98, sd=5)

t.test(x, conf.level = 0.99)
t.test(x, mu=100, alternative = "less") #片側検定
t.test(x, mu=100) #両側検定

n <- c(1:600)
r <- 1.96*(10/sqrt(n))
plot(n, r, type="l", xlim=c(0,200))

d <- read.csv("data02-mac.csv")
hist(d$年齢)
hist(d$設問1, breaks = seq(0, 5, 1))

xb <- mean(d$設問1)
s <- sd(d$設問1)
m <- 3.5
n <- nrow(d)
z <- (xb - m) / (s / sqrt(n))

# for文
mm <- c(3.5, 2.5, 4.2, 3.2, 3.7)
zz <- rep(0, 5) #repeat関数　0を5回繰り返す
xm <- rep(0, 5)
for(i in 1:5){
  xm[i] <- mean(d[,3+i])
  zz[i] <- (mean(d[,3+i]) - mm[i]) / (sd(d[,3+i]) / sqrt(n))
}

t.test(d$設問1, mu = mm[1])