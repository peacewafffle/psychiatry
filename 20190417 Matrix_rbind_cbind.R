#matrix()
my.data <- 1:20
my.data

A <- matrix(my.data, 4, 5)
A
A[2,3]

B <- matrix(my.data, 4, 5, byrow=T)
B

#rbind
r1 <- c("I", "am", "happy")
r2 <- c("what", "a", "day")
r3 <- c(1,2,3)
c <- rbind(r1, r2, r3)
c
#   [,1]   [,2] [,3]   
r1 "I"    "am" "happy"
r2 "what" "a"  "day"  
r3 "1"    "2"  "3" 

#cbind
c1 <- 1:5
c2 <- -1:-5
D <- cbind(c1, c2)
D
#     c1 c2
[1,]  1 -1
[2,]  2 -2
[3,]  3 -3
[4,]  4 -4
[5,]  5 -5
