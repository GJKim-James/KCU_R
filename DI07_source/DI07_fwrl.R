# 반복문의 이해
# for
sum <- 0
for (i in 1:10) {
  sum <- sum + i
}
print(sum)

# while 
sum <- 0
i <- 1
#while (i <= 10) {
while (i < 11) {
  sum <- sum + i
  i <- i + 1
}
print(sum)

# repeat, break  
sum <- 0
i <- 1
repeat {
  sum <- sum + i
  i <- i + 1
  if (i > 10)
    break
}
print(sum)

# next 
sum <- 0
for (i in 1:10) {
  if (i %% 2 == 0)
    next
  sum <- sum + i
}
print(sum)

sum <- 0
for (i in 1:10) {
  if (i %% 2 == 1)
      sum <- sum + i
}
print(sum) 