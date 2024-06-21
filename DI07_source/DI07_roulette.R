# 룰렛 돌리기

# 룰렛 이미지 출력
install.packages("imager")
library(imager)
#getwd()
#setwd("C:/Users/User/Desktop/숭실사이버대학교/3학년 2학기/데이터과학 입문(이현진)/DI07_source")
img_path <- "roulette.png"
img <- load.image(img_path)
plot(img)

# 룰렛 이미지 크기 변환
img <- resize(img, size_x = 400L, size_y = 400L)
plot(img, xlim = c(0, 400), ylim = c(0, 400))

plot(img, xlim = c(0, 400), ylim = c(0, 400), axes = FALSE) # 좌표축 없애기

# 룰렛 회전
rot.count <- sample(11:20, 1) # 11 ~ 20 중 숫자 1개 선택
rot.count

angle <- 0
for(i in 1:rot.count) {
  angle <- angle + 36
  title <- paste("룰렛 회전:", i, "/", rot.count)
  
  imrotate(img, angle, cx = 200, cy = 200) %>% # 중심점
    draw_circle(x = 200, y = 30, radius = 30, 
                col = c(1, 0, 0, 0), opacity = 0.5) %>% # 원 그리기, opacity : 투명도
    plot(axes = FALSE, main = title)
  
  Sys.sleep(0.2)
}
