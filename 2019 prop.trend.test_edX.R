tab <- matrix(c(0.5, 0.1, 0, 0.4), 2, 2)
tab
chisq.test(tab)

PA <- 0.7
PB <- 0.5
r <- 0.3
d <- r * sqrt(PA * (1-PA) * PB * (1-PB))
HAB <- PA * PB +d
HAb <- PA * (1-PB) - d
HaB <- (1-PA) * PB -d
Hab <- (1-PA) * (1-PB) + d
tab <- matrix(c(HAB, HaB, HAb,Hab), 2, 2)
chisq.test(tab, correct=FALSE)
r^2 # chi-sq = r^2