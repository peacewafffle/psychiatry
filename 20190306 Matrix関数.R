d <- read.csv("data01-mac.csv")

hist(d$打率)
hist(d$打率)
hist(d$本塁打)

hist(d$打率, breaks = seq(0.2,0.34,0.01))

scale(d$打率)*10+50

x <- matrix(0, 51, 5)
x[,1] <- scale(d$打率) * 10 + 50 　　#行列を作り、データの値を組み込む
x[,2] <- scale(d$本塁打) * 10 + 50
x[,3] <- scale(d$打点) * 10 + 50
x[,4] <- scale(d$盗塁) * 10 + 50
x[,5] <- scale(d$出塁率) * 10 + 50
x[1,]
round(x[1,]) #四捨五入

