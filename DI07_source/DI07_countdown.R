# 카운트 다운
install.packages("animation")
library(animation)

ani.options(interval = 1)
plot.new()

for (i in 10:0) {
  rect(0, 0, 1, 1, col = "lightpink") # 사각형 생성
  
  text_size = 11 - i # 글씨 크기 점점 크게 만들어주기
  text(0.5, 0.5, i, cex = text_size, col = rgb(0, 1, 0, 1)) # 글씨 넣어주기
  
  ani.pause() # default 1초
}