x <- read.csv("test.csv")
x
x[,3]
x$変数3

y <- x +1
write.csv(y, "test2.csv")
