# 랜덤 막대그래프

# 1초 간격으로 그래프 그리기
# install.packages("animation")
library(animation)

ani.options(interval = 3)
i <- 0

while (TRUE) {
  y <- runif(5, 0, 1) # 5개 숫자, 최소 0, 최대 1
  #print(y)
  barplot(y, ylim = c(0, 1), col = rainbow(5))
  ani.pause()
  i <- i + 1
  if (i > 5)
    break
}

# 난수 추출
runif(5, min = 0, max = 1)
 