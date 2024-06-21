t <- c(TRUE, FALSE)
x <- rep(t, each=2)
y <- rep(t, times=2)
z <- data.frame("x" = x,"y" = y,"x and y" = (x & y))
z

write.table(z, "C:/Users/User/Desktop/TF.csv", sep = ",")
df <- read.csv("C:/Users/User/Desktop/TF.csv", header = T)
df
