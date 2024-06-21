# 동전 던지기 시뮬레이션 
# 동전 앞면이 나오는 확률
plot(NA,
     xlab = "동전을 던진 회수", ylab = "앞면이 나오는 비율",
     xlim = c(0, 100), ylim = c(0, 1),
     main = "동전 던지는 횟수에 따른 앞면이 나올 확률 변화")
abline(h = 0.5, col = "red", lty = 2)

count <- 0
for(n in 1:100) {
  coin <- sample(c("앞면", "뒷면"), 1) # 앞면, 뒷면 중 1개 나오게 설정
  if (coin == "앞면")
    count = count + 1
  prob <- count / n
  points(n, prob) # 횟수, 확률 점으로 찍기
  Sys.sleep(1)
}
