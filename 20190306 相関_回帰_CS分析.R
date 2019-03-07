data("cars")

x1 <- cars$speed
y1 <- cars$dist

plot(x1, y1)

x2 <- rnorm(100, mean=0, sd=1)
y2 <- rnorm(100, mean=0, sd=1)
plot(x2, y2)

data("cars")
x1 <- cars$speed
y1 <- cars$dist
plot(x1, y1)
cor(x1, y1) #相関係数を求める

n <- 30
r <- 0.7

x <- rnorm(n, mean = 0, sd = 1)
e <- rnorm(n, mean = 0, sd = 1)
y <- r*x + sqrt(1-r^2)*e

plot(x ,y, xlim = c(-4,4), ylim = c(-4, 4))
cor(x, y)

#回帰直線

data("cars")
cars

x <- cars$speed
y <- cars$dist
plot(x, y)
cor(x, y)

b <- cov(x,y) / var(x)
a <- mean(y) - b*mean(x)

abline(a,b)

res <- lm(y~x) #直接回帰直線を求める方法　~（チルダ）
plot(x, y)
abline(res)

#重回帰
y <- c(82, 97, 130, 108, 144, 165)
x1 <- c(11, 10, 14, 9, 15, 20)
x2 <- c(3, 4, 5, 7, 6, 7)

res <- lm(y~x1+x2) #回帰分析とほぼ同じで+で繋げる

ys <- scale(y) #標準化
xs1 <- scale(x1)
xs2 <- scale(x2)

res2 <- lm(ys~xs1+xs2)

y <- c(31.1, 25.6, 28.3, 24.4, 36.0, 18.9, 35.7)
x1 <- c(8, 7, 15, 10, 8, 14, 8)
x2 <- c(8, 13, 6, 13, 4, 17, 6)
x3 <- c(150, 77, 90, 62, 99, 91, 90)
x4 <- c(930, 980, 970, 1030, 1180, 920, 1150)
x5 <- c(920, 1420, 914, 1102, 824, 1533, 801)

m <- cbind(x1, x2, x3, x4, x5, y)
cor(m)

res <- lm(y~x1+x2+x3)
summary(res) #Multiple R-squared、 一般的にt-valueの絶対値が2より大きければ信頼して使える回帰係数

#練習問題 （アンケート調査）
d <- read.csv("data03-mac.csv")
View(d)
plot(d[,1], d[,7], xlim = c(1, 5), ylim = c(1, 5))

rnum <-6
table(d[,rnum], d[,7]) #離散データの相関を散布図で確認できる
cor(d[,rnum], d[,7])

#CS分析
x <- cor(d[,1:6], d[,7]) #設問1-6まで一気に計算できる
y <- colMeans(d[,1:6]) #列ごとの平均値を一気に計算できる

plot(x, y, xlim = c(0,1), ylim = c(1,5))
text(x, y + 0.3, labels = c(1:6))

cor(d)
round(cor(d), 2) #小数点2位まで表示する
res <- lm(d[,7]~d[,1]+d[,5]+d[,6])
summary(res)
