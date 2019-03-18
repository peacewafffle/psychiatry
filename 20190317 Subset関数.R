# subset関数　グループ毎に解析
dat <- read.csv("ADAS_Figure.csv") 
dat_a<- subset(dat, Diagnosis=="MCI")
View(dat_a)
hist(dat_a$FTF)
hist(dat_a$VTC)
shapiro.test(dat_a$FTF)
shapiro.test(dat_a$VTC)
cor(dat_a$FTF, dat_a$VTC, method="pearson") 

