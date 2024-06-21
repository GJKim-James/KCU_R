# 2개 동전 전지기
plot.new()

count <- c(0, 0, 0)

for (n in 1:200) {
  coin <- sample(c(0, 1), 2, replace = T) # (0, 1) 2번; 동전 2번 던지는 효과
  # 나올 수 있는 경우 : (0, 0), (0, 1), (1, 0), (1, 1)
  #print(coin)
  index <- sum(coin) + 1
  #print(index)
  count[index] <- count[index] + 1
  
  probability <- count / n # 확률
  
  title <- paste("반복 수: ", n, " / 200")
  
  bp <- barplot(probability,
                names.arg = c(0, 1, 2),
                xlab = "앞면이 나온 횟수",
                ylab = "확률",
                col = rainbow(3),
                main = title)
  
  # 막대 그래프에 확률 적기
  text(x = bp, y = probability, labels = probability, pos = 1)
  
  Sys.sleep(0.05)
}